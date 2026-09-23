# 调研文档:Oracle 23ai `UTL_HTTP.SET_WALLET('system:')` 系统 CA 信任库

> 日期:2026-09-23 ｜ 环境:VirtualBox 虚拟机 "Oracle AI Database 26ai Free" ｜ 数据库:Oracle Database 23ai Free **23.26.0.0.0**(23c/23ai 家族)
> 测试人:通过主机 ssh 到 VM(`oracle@127.0.0.1 -p 2222`),以 `sys/oracle as sysdba` 执行 SQL

---

## 1. 背景

Oracle 23ai 起,`UTL_HTTP` 做 HTTPS 请求时,钱包参数(信任的 CA 证书库)除了传统的 `file:` 指向自建 Oracle 钱包外,新增了一个 **`system:`** scheme。官方语义:`system:` 使用 Oracle 内置 / 系统级的 CA 信任库,**无需自行创建钱包、无需导入 CA**。

本次调研要回答三个问题:

1. `system:` 到底能不能用?怎么用?(语法、坑)
2. 它信任哪些证书?是不是"什么都信"?
3. **它实际从磁盘哪个路径加载 CA bundle?**(本文重点)

伴随文件:

| 文件 | 说明 |
|---|---|
| `test_system_wallet.sql` | 可复现的测试脚本(3 个场景) |
| `test_system_wallet.out` | 实跑输出(原文) |

---

## 2. 测试环境

| 项 | 值 |
|---|---|
| VM | VirtualBox "Oracle AI Database 26ai Free" |
| Guest OS | Oracle Linux 8 (UEK 5.15) |
| ORACLE_HOME | `/opt/oracle/product/26ai/dbhomeFree` |
| ORACLE_SID | `FREE` |
| DB 版本 | `Oracle AI Database 26ai Free Release 23.26.0.0.0` |
| 网络 | NIC1=NAT(出公网,主机有网 VM 即有网);NIC2=host-only(192.168.56.x) |
| 公网可达性 | example.com / oracle.com / baidu.com / gov.cn 等可达;google.com 被墙 |
| 关键工具 | `sqlplus`、`orapki`、`mkstore`、`openssl 1.1.1k`、`strace`、`tcpdump`、`strings` |

VM 网络由原来的 Wi-Fi 桥接改为 **NAT + host-only**:Wi-Fi 桥接在 Windows 上经常分不到 DHCP(VM 拿不到 IP),NAT 则稳定出网并带端口转发(`2222→SSH`、`8080→ORDS`、`1521→监听器`)。

---

## 3. 测试场景与结论

### 场景 1:不设钱包直接请求 HTTPS —— 应失败

```sql
utl_http.set_wallet(NULL);
s := utl_http.request('https://www.example.com/');
```

**结果**:`ORA-29273: HTTP request failed` → 详细 `ORA-29024: Certificate validation failure`
**含义**:没有信任库就无法做 TLS 证书校验,握手在证书验证阶段就挂掉。这正是 `SET_WALLET` 存在的意义。

### 场景 2:漏写冒号 `SET_WALLET('system')` —— 应报错

```sql
utl_http.set_wallet('system');   -- 少了冒号
```

**结果**:`ORA-29248: an unrecognized WRL was used to open a wallet`
**含义**:`system` 不是合法的 WRL(wallet resource locator)scheme,**必须带冒号 `system:`**。这是个高频笔误点。

### 场景 3:`SET_WALLET('system:')` 对公网站点 —— 应全部成功

```sql
utl_http.set_wallet('system:');
-- 对 8 个不同 CA 签发的公网站点请求
```

**结果**(见 `.out`):

| 站点 | 结果 | 返回字节 |
|---|---|---|
| https://www.example.com/ | ✅ OK | 559 |
| https://www.oracle.com/ | ✅ OK | 1449 |
| https://api.github.com/ | ✅ OK | 265 |
| https://www.cloudflare.com/ | ✅ OK | 2000 |
| https://www.microsoft.com/ | ✅ OK | 2000 |
| https://www.baidu.com/ | ✅ OK | 1778 |
| https://www.bing.com/ | ✅ OK | (本次空 body,见注) |
| https://www.gov.cn/ | ✅ OK | 1937 |

> `UTL_HTTP.REQUEST` 只返回响应体前 2000 字节,故 len ≤ 2000。bing.com 偶现空 body(gzip 首块解码为空),非证书问题。

**含义**:`system:` 开箱即用,无需 `orapki`/`mkstore` 建钱包、无需导 CA,就能验证所有公网 CA 签发的证书。

### 附加反向验证(之前已测,本文不展开):自签名证书被 `system:` 拒绝

VM 内 `openssl s_server` 起一个自签名 HTTPS(`CN=127.0.0.1`),`SET_WALLET('system:')` 请求 → `ORA-29024 Certificate validation failure`;把该自签 CA 导入 `file:` 钱包后再请求 → 200。
**结论**:`system:` 不是无脑放行,是按公共根 CA 做真实校验。

---

## 4. 路径取证:它到底从哪读 CA bundle?

这是本次调研的重点。**结论(已实锤)**:

> `system:` 走的是 **宿主机 / OpenSSL 的系统信任库**,即 OS 的 CA bundle:
> `/etc/pki/tls/certs/ca-bundle.crt` → `/etc/pki/ca-trust/extracted/pem/tls-ca-bundle.pem`(本机 **148 个受信根 CA**)
>
> 它 **不是** 一个 Oracle 格式的钱包文件(没有 `ewallet.p12` / `cwallet.sso` 之类被读)。

### 取证链(均为非破坏性静态分析 + 数据字典)

**a. 隐藏参数控制开关**
```
_allow_system_wallet   = TRUE     <-- system: 特性的总开关
_implicit_ssl_wallet   = TRUE
ssl_wallet             = (空)
wallet_root            = (空)     <-- 未配 TDE/WALLET_ROOT
```
`V$ENCRYPTION_WALLET` = `NOT_AVAILABLE`(无 TDE keystore)。说明 `system:` 的工作与 Oracle 钱包/TDE 无关。

**b. ORACLE_HOME 下不存在 Oracle 格式的 CA bundle 钱包**
```
$ find $ORACLE_HOME -iname 'cwallet.sso' -o -iname 'ewallet.p12' ...
$ORACLE_HOME/admin/FREE/xdb_wallet/{ewallet.p12,cwallet.sso}   <-- 唯一命中
```
该钱包内容(`orapki wallet display`):
```
User Certificates:  CN=FREE          <-- XDB 内置 HTTP 的自签证书
Trusted Certificates: CN=FREE        <-- 自签,不是公共 CA
```
即:这是 XDB 内部用的自签证书,**不是公共 CA 信任库**。除此之外 ORACLE_HOME 下没有任何装着公共根 CA 的 Oracle 钱包。

若 `system:` 用的是 Oracle 钱包文件,该文件必然存在于磁盘上——但它并不存在。所以 `system:` 不读 Oracle 钱包。

**c. 二进制内嵌字符串指向 OpenSSL 配置与 `system:` 处理**

`strings` on `libclntsh.so`(客户端安全层):
```
system:                                          <-- 多次出现,即 scheme 处理
cwallet.sso
Looking for cwallet.sso in %.*s (len=%d)         <-- 钱包文件加载逻辑
trusted certificate was not found in the specified wallet
```

`strings` on `oracle`(服务端可执行):
```
_allow_system_wallet
/etc/pki/tls/openssl.cnf
/opt/oracle/openssl3-fips/etc/pki/tls/openssl.cnf
pihtinit/pitcct: Failed to get _allow_system_wallet parameter value ...
```
即:DB 的 SSL 层引用 **OpenSSL 的配置文件** `/etc/pki/tls/openssl.cnf`,而该配置默认指向系统 CA bundle。

**d. 宿主机确实有系统 CA bundle**
```
/etc/pki/tls/certs/ca-bundle.crt  -> /etc/pki/ca-trust/extracted/pem/tls-ca-bundle.pem   (148 个 BEGIN CERTIFICATE)
/etc/ssl/certs/ca-bundle.crt     -> 同上
```
148 个受信根 CA,足以覆盖全球主流公网 CA。这与"8 个公网站点全过"的现象完全自洽。

### 实锤:受控破坏性实验(已执行,可逆)

经用户批准,做了只移走、不删除的受控实验(带 EXIT trap 兜底自动恢复):

```
目标文件: /etc/pki/ca-trust/extracted/pem/tls-ca-bundle.pem   (148 个根 CA)
操作:     sudo mv <file> <file>.MOVED   (符号链接 /etc/pki/tls/certs/ca-bundle.crt 变为 dangling)
请求:     UTL_HTTP.SET_WALLET('system:'); utl_http.request('https://www.example.com/')
```

| 阶段 | bundle 状态 | system: 请求结果 |
|---|---|---|
| 移走前 | 148 certs 在位 | ✅ OK(len=559) |
| **移走后** | 0 certs,dangling | ❌ **`ORA-29273` / `ORA-28759: failure to open file`** |
| 移回后 | 148 certs 恢复 | ✅ OK |

`ORA-28759(failure to open file)` 是 Oracle PKI 层"打开钱包/信任库文件失败"的错误。bundle 一被移走就报这个错、移回就好——**这是文件级实时证据**:`system:` 在请求时确实去 `open()` 了 `/etc/pki/ca-trust/extracted/pem/tls-ca-bundle.pem`。路径由此钉死。

> 实验探针里的 `nvl(length(s),'NULL')` 有类型不匹配 bug,会把成功路径显示成 ORA-06502,故 before/after 在探针输出里一度显示 `-6502`;但成功状态由独立运行的 `test_system_wallet.out`(len=559)佐证,moved-aside 的 `ORA-28759` 不受该 bug 影响,是干净证据。

### 关于 strace(未成功,但已被上面实验替代)

strace 抓 `openat` 未能实施:即便 `kernel.yama.ptrace_scope=0`,`strace -p <spid>` 仍报 `ptrace(PTRACE_SEIZE): Operation not permitted`——是 **SELinux** 拦了跨进程 ptrace,不是 yama。但上面的受控实验已从另一角度给出了等价的文件级证据,无需再依赖 strace。

所以路径结论已升级为 **实锤(静态取证 + 受控实验双重验证)**。

---

## 5. 关于"能不能用 Wireshark 看见"

**能看到的**:TLS 握手报文(ClientHello、ServerHello、服务端 Certificate、密码套件协商、密钥交换),即"网络上的事"。

**看不到的**:`system:` 从哪个本地文件读 CA bundle——那是数据库进程在本地磁盘的一次 `open()`/`read()`,不上网络,Wireshark 抓不到。

要抓握手(在 VM 内)可以:
```bash
sudo tcpdump -i any -w /tmp/tls.pcap 'tcp port 443' &
# 触发一次 UTL_HTTP system: 请求后停止,用 wireshark/tshark 打开 /tmp/tls.pcap
```
能确认 UTL_HTTP 确实做了 TLS、服务端下发了哪条证书链,但**回答不了路径问题**。路径用 strace / 静态取证回答。

---

## 6. 三种钱包写法对比(总结)

| 写法 | 结果 | 语义 |
|---|---|---|
| 不调 `SET_WALLET` | ❌ ORA-29273 / ORA-29024 | 无信任库,握手失败 |
| `SET_WALLET('system')`(漏冒号) | ❌ ORA-29248 | 不是合法 WRL |
| `SET_WALLET('system:')` | ✅ | 用系统(OS/OpenSSL)CA 信任库,零配置,信公网 CA、拒自签 |
| `SET_WALLET('file:/某钱包目录')` | ✅ | 手工 Oracle 钱包;需 `orapki wallet add -trusted_cert` 导入 CA。用于自签/私有 CA |

### 什么时候用哪个
- 目标是**公网 CA 签发**的证书 → `system:`,一行搞定。
- 目标是**自签名 / 企业私有 CA** → `file:`,把私有 CA 导进钱包。

---

## 7. 复现步骤

```bash
# 1. 从主机进 VM
ssh -p 2222 oracle@127.0.0.1        # 密码 oracle
#    (非交互:用 SSH_ASKPASS 脚本 echo oracle + SSH_ASKPASS_REQUIRE=force)

# 2. 设环境
export ORACLE_HOME=/opt/oracle/product/26ai/dbhomeFree
export LD_LIBRARY_PATH=$ORACLE_HOME/lib

# 3. 跑测试脚本(见同目录 test_system_wallet.sql)
$ORACLE_HOME/bin/sqlplus -S "sys/oracle as sysdba" @test_system_wallet.sql
#   DB 口令:sys/oracle ; SYS 免网络 ACL,无需 DBMS_NETWORK_ACL_ADMIN 授权
```

## 8. 备注 / 已知坑

- **`system` 必须带冒号**,写成 `system` 报 ORA-29248。
- 开关 `_allow_system_wallet`(默认 `TRUE`)若被设为 `FALSE`,`system:` 会失效。
- `UTL_HTTP.REQUEST` 只取前 2000 字节;大页面用 `BEGIN_REQUEST` + `GET_RESPONSE` + `READ_TEXT` 循环读全。
- 非 SYS 用户调用 UTL_HTTP 需走网络 ACL(`DBMS_NETWORK_ACL_ADMIN`),23ai 的 `APPEND_HOST_ACE` 签名与旧文档不同;SYS 豁免,故本脚本无需授权。
- 本 VM 改过网络(bridged→NAT+host-only);若日后恢复桥接,主机访问改回 VM 的局域网 IP。
