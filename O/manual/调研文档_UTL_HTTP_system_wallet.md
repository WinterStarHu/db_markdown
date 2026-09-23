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
#   Part 1(场景 1-3):只要公网通即可。
#   Part 2(场景 A-G):先在同一 shell 跑 bash setup_tls_servers.sh 起 4 个 s_server,
#                      再跑 sqlplus。结束后 pkill -f 'openssl s_server' 清理。
```

## 8. 扩展测试:TLS 版本 / 证书 / 密码 边界场景

针对 `system:` 与 `file:` 钱包在 TLS 层的边界行为,补了 7 个场景。场景 B-G 依赖一组本地 `openssl s_server`(用同目录 `setup_tls_servers.sh` 起好):8543 有效证书、8544 仅 TLS1.1、8545 过期证书、8546 主机名不匹配。自建 CA 导入 `wallet_tests` 钱包(B-E 用)。

| # | 场景 | 结果 | 错误码 / 说明 |
|---|---|---|---|
| A | `system:` + 错误 password | ✅ OK(559) | 密码被**静默忽略**——`system:` 无密码可校验,传啥都不影响 |
| B | `file:wallet_tests` + 有效证书(TLS1.2) | ✅ OK(2000) | 基线:CA 受信、证书有效、主机名匹配 |
| C | `file:` + **仅 TLS1.1** 服务端 | ❌ | **ORA-29019 The protocol version is incorrect**——协议版本错,与证书错误(ORA-29024)区分开;证明 23ai 拒绝 TLS1.1,最低 TLS=1.2 |
| D | `file:` + **过期**证书(2020-01 已过期) | ❌ | ORA-29024——CA 可信(B 同一 CA 成功),故失败原因只能是过期 |
| E | `file:` + **主机名不匹配**(CN/SAN 不含 127.0.0.1) | ❌ | **ORA-24263 remote server address on certificate and target address mismatch**——专门的主机名校验错 |
| F | `system:` + 自签证书 | ❌ | ORA-29024——未知 CA(system: 只信公共根) |
| G | 会话级关 `_allow_system_wallet` | ⚠️ | ORA-02096:该隐藏参数**不可在 session 级修改**;G2 仍 OK(alter 失败没生效)。后用 `scope=spfile`+重启**真正关掉**(见 §10.4),system: 仍 OK——此开关并非 system: 总闸 |

关键结论:
- **密码对 `system:` 无意义**(场景 A):`UTL_HTTP.SET_WALLET('system:','任意值')` 照常工作,密码参数被忽略。
- **TLS 版本与证书校验是两道独立关卡**:TLS 版本不匹配 → ORA-29019(握手期,先于证书校验);证书问题 → ORA-29024(校验期)。故 C 的错误码与 D/E/F 不同,可据此区分故障层。
- **过期与未知 CA 都报 ORA-29024**(Oracle 在此路径不细分),区分需看上下文:若 CA 受信(B 成功)而仍失败 → 过期;若 CA 本就不在信任库 → 未知 CA。
- **主机名不匹配有专门错误码 ORA-24263**,可直接定位。
- **`_allow_system_wallet` 不是 system: 总开关**(纠正):`scope=spfile`+重启真正置 FALSE 后,显式 `SET_WALLET('system:')` 仍正常工作(见 §10.4)。它被 HTTP 初始化层读取,但管的是另一条"系统钱包"路径,不门控 `system:` 字面量。

## 9. 进阶实验:系统根过期 & 根/叶子过期的区分

### 9.1 系统 bundle 里已有的过期根
检查 `/etc/pki/tls/certs/ca-bundle.crt`(148 个根),发现 **1 个已过期**:
```
EXPIRED: subject=CN = Baltimore CyberTrust Root  notAfter=May 12 23:59:00 2025 GMT
=== SUMMARY: total roots=148  already_expired=1 ===
expiring_within_1y = 3  (Baltimore[已过期]、Entrust Root CA[2026-11]、Certigna[2027-06])
```
`ca-certificates` 包为 `2024.2.69`(2024-08 构建),滞后于 Baltimore 的 2025-05 过期时间,故过期根未被清理。
**平时不影响 `system:`**:公网站点叶子链到的是仍有效的根;且多路径校验会走有效路径。

### 9.2 把系统根全部置于过期(clock → 2049)
最远根 `notAfter=2048-03-27`(Telekom Security)。把 VM 时钟快进到 `2049-01-01`,则 148 根全部"过期"。
```bash
sudo timedatectl set-ntp false
sudo timedatectl set-time "2049-01-01 12:00:00"
# 触发: utl_http.set_wallet('system:'); utl_http.request('https://www.example.com/')
```
结果:`system:` → **ORA-29024 Certificate validation failure**(失败)。恢复时钟(set-ntp true 重同步)后 system: 恢复 OK(559),DB 状态 OPEN 未受影响。
**科学性瑕疵**:2049 时 example.com 的**叶子**(1 年期)也过期了,故该失败混了叶子过期的成分,不能单归因于根。

### 9.3 根/叶子过期——能否单独证明"根过期"
| 层 | 过期 | 是否被校验 | 证据 |
|---|---|---|---|
| 叶子(leaf) | 过期 | ❌ 失败 ORA-29024 | 场景 D |
| 中间(intermediate) | 过期 | ❌ 失败 ORA-29024 | 9.4 I1 |
| 根(锚,trust anchor) | 过期 | 经 `system:` 无法单独证明;整包过期会失败(但叶子同时过期) | 9.2 clock→2049 |

- **叶子过期 → 必失败**(场景 D:有效 CA + 过期叶子 → ORA-29024)。
- **中间证书过期 → 必失败**(I1:叶子有效 → 过期中间 → 有效根,仍 ORA-29024)。
- **根(锚)过期**:经 `system:` 用真实公网证书**无法干净隔离**——公网叶子 ~1 年期,根有效期到 2030s~2048,叶子永远比根先过期,不存在"叶子有效而其根已过期"的真实公网站点;且无公共 CA 私钥,签不出"被公共过期根签的有效叶子"。唯一能干净构造"根过期 + 叶子有效"的途径是 `file:` 钱包 + 自建过期自签根(需 faketime 或时钟快进铸根),**不走 system:**。

### 9.4 I1/I2 中间证书过期实验(走 `file:`,复用 /tmp/exproot 既有证书)
构造:tempca(有效自签根)+ expiredanchor(被 tempca 签、`notAfter=2020`,即过期中间)+ leaf_exp(被 expiredanchor 签、有效叶子)。钱包只信 tempca;服务端 `s_server -cert leaf_exp -cert_chain expiredanchor`。
链 = `leaf(有效) → expiredanchor(过期中间) → tempca(有效根,受信)`。
```
I1 leaf(有效)->expiredINTERMED->validRoot -> ERR -29273 ORA-29024: Certificate validation failure
I2 leaf(有效)->validRoot(无中间)        -> OK len=2000
```
结论:链中**非锚节点**(叶子、中间)的过期被强制校验;根(锚)过期能否被校验,经 `system:` 无法用真实证书单独证明(见 9.3)。

## 10. 参数行为详解(实测)

### 10.1 四个相关参数的元数据
```
ssl_wallet            = (null)  -- ssl_wallet                                   [CDB 级,动态可改 scope=both;PDB 内改报 ORA-65040]
wallet_root           = (null)  -- wallet root instance initialization parameter [不可动态改,ORA-02095;只能 spfile+重启]
_implicit_ssl_wallet  = TRUE    -- Implicitly use SSL Wallet for UTL_HTTP request
_allow_system_wallet  = TRUE    -- Allow Usage of SYSTEM Wallet Path for Outbound Communication
```

### 10.2 可改性
| 参数 | session 改 | system 改 | 实测 |
|---|---|---|---|
| `ssl_wallet` | ❌ | ✅(CDB$ROOT,scope=both)| PDB 内 `alter system set` → ORA-65040;切到 CDB$ROOT(`sys/oracle@localhost:1521/FREE as sysdba`)**scope=both 成功** |
| `wallet_root` | ❌ | ❌(动态)| `alter system set ... scope=both` → **ORA-02095**(只能 spfile+重启)|
| `_allow_system_wallet` | ❌(ORA-02096)| ✅ spfile | session 改报 ORA-02096;`scope=spfile` + 重启后生效(实测 param=FALSE 已确认)|
| `_implicit_ssl_wallet` | 未测改 | — | 仅静态取值 TRUE |

### 10.3 `ssl_wallet` + `_implicit_ssl_wallet` 行为
在 CDB$ROOT 设 `ssl_wallet=file:/home/oracle/wallet_http`(钱包里有 example.com 的 CA 链),`_implicit_ssl_wallet=TRUE` 保持默认:
```
I1 无 SET_WALLET(隐式用 ssl_wallet?)-> ERR -29273 ORA-29024   ← 没有自动套用
I2 SET_WALLET('system:')            -> OK  len=559            ← system: 不受 ssl_wallet 影响
```
再把 `_implicit_ssl_wallet` 置 FALSE(spfile+重启,确认 param=FALSE),`ssl_wallet` 仍设着,矩阵:
```
M1 无 SET_WALLET (_implicit=FALSE, ssl_wallet set) -> ERR -29273 ORA-29024   ← 与 TRUE 时一样
M2 system: (_implicit=FALSE)                       -> OK len=559
M3 file:    (_implicit=FALSE)                      -> OK len=559
```
**结论**:无论 `_implicit_ssl_wallet` TRUE 还是 FALSE,**UTL_HTTP 都不会自动拿 `ssl_wallet` 当 HTTPS 信任库**(M1/I1 均 ORA-29024);该参数在本配置对 UTL_HTTP 无可观察效果。要验证 HTTPS 仍须显式 `SET_WALLET`。`system:` 与 `ssl_wallet` 相互独立。
> 附:`ssl_wallet` 参数对 `file:` 前缀不识别——设 `file:/home/oracle/wallet_http` 被规范化成 `$ORACLE_HOME/dbs/file:/home/oracle/wallet_http`(当成相对路径)。`ssl_wallet` 应填纯目录路径。测试后已 `reset` 清干净。

### 10.4 `_allow_system_wallet=FALSE`(spfile + 重启,实测)
纠正前文假设:此开关 **并不是** `system:` 的总闸。
```
spfile: alter system set "_allow_system_wallet"=false scope=spfile  -> OK
shutdown immediate; startup;
确认: _allow_system_wallet=FALSE, status=OPEN
T1 SET_WALLET('system:') -> OK len=559   ← 开关关掉,system: 照样能用!
T2 SET_WALLET('file:...')  -> OK len=559   ← file: 不受影响(预期)
恢复: alter system set "_allow_system_wallet"=true scope=spfile + 重启 -> VERIFY system: OK
```
**结论**:`_allow_system_wallet=FALSE` **不会**禁用显式 `UTL_HTTP.SET_WALLET('system:')`。该参数虽被 HTTP 初始化层读取(二进制有 `pihtinit: Failed to get _allow_system_wallet parameter value` 字样),但在本配置下对 UTL_HTTP 显式 `system:` 无可观察影响——它大概管的是另一条"系统钱包"代码路径(如隐式/默认出站),而非 `system:` 字面量。**前文"它是 system: 总开关"的说法作废,以此实测为准。**

### 10.5 连接/启动要点(本 appliance 坑)
`.bashrc` 设了 `export TWO_TASK=freepdb1`,导致 `sys/oracle as sysdba`(不带 @)也走 listener→service `freepdb1`;**实例一旦关闭,listener 端口连不上(ORA-12514 / ORA-01017)**。要对 down 的实例做 STARTUP,须:
```bash
unset TWO_TASK
export ORACLE_SID=FREE              # 注意 oratab 是 FREE(大写),.bashrc 里小写 free 也能跑
sqlplus / as sysdba                  # bequeath OS 认证(本机 OS 认证可用,只是被 TWO_TASK 屏蔽了)
> STARTUP
```
即 OS 认证 `/ as sysdba` 本身是好的,平时"失败"是 TWO_TASK 把它拐去了 listener。

## 11. 备注 / 已知坑

- **`system` 必须带冒号**,写成 `system` 报 ORA-29248。
- **`_allow_system_wallet`(默认 TRUE)并非 `system:` 总开关**:实测置 FALSE + 重启后 `system:` 仍可用(§10.4)。它非 session 可调(ORA-02096),可经 `ALTER SYSTEM ... scope=spfile` + 重启修改。
- `UTL_HTTP.REQUEST` 只取前 2000 字节;大页面用 `BEGIN_REQUEST` + `GET_RESPONSE` + `READ_TEXT` 循环读全。
- 非 SYS 用户调用 UTL_HTTP 需走网络 ACL(`DBMS_NETWORK_ACL_ADMIN`),23ai 的 `APPEND_HOST_ACE` 签名与旧文档不同;SYS 豁免,故本脚本无需授权。
- 本 VM 改过网络(bridged→NAT+host-only);若日后恢复桥接,主机访问改回 VM 的局域网 IP。
