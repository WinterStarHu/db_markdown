# 4.2.5 使用类似 URI 的字符串或键值对连接到服务器_MySQL 8.0 参考手册

4.2.5 使用类似 URI 的字符串或键值对连接到服务器_MySQL 8.0 参考手册
Skip to Main Content
Documentation
MySQL手册
MySQL企业版
工作台
InnoDB集群
MySQL NDB集群
连接器
Section Menu:
Documentation Home
MySQL 8.0 参考手册
前言和法律声明
第一章 一般信息
第 2 章安装和升级 MySQL
第 3 章教程
第 4 章 MySQL 程序
4.1 MySQL程序概述
4.2 使用 MySQL 程序
4.2.1 调用MySQL程序1
4.2.2 指定程序选项1
4.2.3 连接服务器的命令选项1
4.2.4 使用命令选项连接到 MySQL 服务器1
4.2.5 使用类似 URI 的字符串或键值对连接到服务器1
4.2.6 使用 DNS SRV 记录连接到服务器1
4.2.7 连接传输协议1
4.2.8 连接压缩控制1
4.2.9 设置环境变量1
4.3 服务器和服务器启动程序
4.4 安装相关程序
4.5 客户端程序
4.6 管理和实用程序
4.7 程序开发实用程序
4.8 杂项程序
4.9 环境变量
4.10 MySQL 中的 Unix 信号处理
第 5 章 MySQL 服务器管理
第 6 章 安全
第 7 章备份与恢复
第8章优化
第9章语言结构
第 10 章字符集、排序规则、Unicode
第 11 章数据类型
第 12 章函数和运算符
第 13 章 SQL 语句
第14章MySQL数据字典
第 15 章 InnoDB 存储引擎
第 16 章替代存储引擎
第十七章复制
第十八章 组复制
第十九章MySQL Shell
第 20 章使用 MySQL 作为文档存储
第21章InnoDB Cluster
第 22 章 InnoDB 副本集
第 23 章 MySQL NDB Cluster 8.0
第24章分区
第25章存储对象
第 26 章 INFORMATION_SCHEMA 表
第 27 章 MySQL 性能模式
第 28 章 MySQL 系统模式
第 29 章连接器和 API
第30章MySQL企业版
第31章MySQL工作台
第 32 章 OCI 市场上的 MySQL
附录 A MySQL 8.0 常见问题解答
附录 B 错误信息和常见问题
附录 C 索引
MySQL 词汇表
MySQL 8.0 参考手册  / 第 4 章 MySQL 程序  / 4.2 使用 MySQL 程序  /
4.2.5 使用类似 URI 的字符串或键值对连接到服务器
4.2.5 使用类似 URI 的字符串或键值对连接到服务器
本节描述使用类似 URI 的连接字符串或键值对来指定如何为 MySQL Shell 等客户端建立与 MySQL 服务器的连接。有关使用命令行选项建立连接的信息，对于mysql或mysqldump等客户端，请参阅第 4.2.4 节，“使用命令选项连接到 MySQL 服务器”。有关无法连接的其他信息，请参阅
第 6.2.22 节，“连接到 MySQL 的故障排除”。
笔记
术语“ URI-like ”表示与RFC 3986定义的 URI（统一资源标识符）语法相似但不相同的连接字符串语法
。
以下 MySQL 客户端支持使用类似 URI 的连接字符串或键值对连接到 MySQL 服务器：
MySQL外壳
实现 X DevAPI 的 MySQL 连接器
本节记录了所有有效的类似 URI 的字符串和键值对连接参数，其中许多与使用命令行选项指定的参数相似：
使用类似 URI 的字符串指定的参数使用诸如myuser@example.com:3306/main-schema. 有关完整语法，请参阅使用类似 URI 的连接字符串进行连接。
用键值对指定的参数使用诸如
{user:'myuser', host:'example.com', port:3306,
schema:'main-schema'}. 有关完整语法，请参阅
使用键值对进行连接。
连接参数不区分大小写。如果指定，每个参数只能给出一次。如果多次指定一个参数，则会发生错误。
本节涵盖以下主题：
基本连接参数附加连接参数使用类似 URI 的连接字符串进行连接使用键值对连接
基本连接参数
以下讨论描述了指定与 MySQL 的连接时可用的参数。这些参数可以使用符合基本 URI 语法的字符串（请参阅使用类似 URI 的连接字符串进行连接）或作为键值对（请参阅
使用键值对进行连接）来提供。
scheme：要使用的传输协议。用于mysqlxX 协议连接和mysql经典 MySQL 协议连接。如果未指定协议，服务器将尝试猜测协议。支持 DNS SRV 的连接器可以使用该mysqlx+srv
方案（请参阅使用 DNS SRV 记录的连接）。
user：为身份验证过程提供的 MySQL 用户帐户。
password：用于身份验证过程的密码。
警告
在连接规范中指定显式密码是不安全的，不推荐使用。稍后的讨论将展示如何导致出现输入密码的交互式提示。
host：运行服务器实例的主机。该值可以是主机名、IPv4 地址或 IPv6 地址。如果未指定主机，则默认为localhost.
port: 目标MySQL服务器监听连接的TCP/IP网络端口。如果未指定端口，则 X 协议连接的默认值为 33060，经典 MySQL 协议连接的默认值为 3306。
socket: Unix 套接字文件的路径或 Windows 命名管道的名称。值是本地文件路径。在类似 URI 的字符串中，必须对它们进行编码，使用百分比编码或用括号将路径括起来。括号消除了对/目录分隔符等字符进行百分比编码的需要。例如，要
root@localhost使用 Unix socket
连接 as /tmp/mysql.sock，请使用百分比编码指定路径 as
root@localhost?socket=%2Ftmp%2Fmysql.sock，或使用括号 as
root@localhost?socket=(/tmp/mysql.sock)。
schema: 连接的默认数据库。如果未指定数据库，则连接没有默认数据库。
在 Unix 上的处理localhost取决于传输协议的类型。使用经典 MySQL 协议localhost的连接处理方式与其他 MySQL 客户端相同，这意味着
localhost假定它用于基于套接字的连接。对于使用 X 协议的连接， 的行为
localhost有所不同，因为它假定代表环回地址，例如 IPv4 地址 127.0.0.1。
附加连接参数
您可以为连接指定选项，可以通过附加 来作为类似 URI 的字符串中的属性，也可以
作为键值对。以下选项可用：
?attribute=value
ssl-mode：连接所需的安全状态。以下模式是允许的：
DISABLED
PREFERRED
REQUIRED
VERIFY_CA
VERIFY_IDENTITY
重要的
VERIFY_CA并且
VERIFY_IDENTITY是比默认值更好的选择PREFERRED，因为它们有助于防止中间人攻击。
有关这些模式的信息，请参阅
加密连接--ssl-mode的命令选项中的选项说明
。
ssl-ca：PEM 格式的 X.509 证书颁发机构文件的路径。
ssl-capath：包含 PEM 格式的 X.509 证书颁发机构文件的目录路径。
ssl-cert：PEM 格式的 X.509 证书文件的路径。
ssl-cipher：用于通过 TLSv1.2 使用 TLS 协议的连接的加密密码。
ssl-crl：包含 PEM 格式的证书吊销列表的文件的路径。
ssl-crlpath：包含 PEM 格式的证书吊销列表文件的目录的路径。
ssl-key：PEM 格式的 X.509 密钥文件的路径。
tls-version：经典 MySQL 协议加密连接允许的 TLS 协议。只有 MySQL Shell 支持此选项。(singular)的值
tls-version是逗号分隔的列表，例如
TLSv1.2,TLSv1.3. 有关详细信息，请参阅
第 6.3.2 节，“加密连接 TLS 协议和密码”。此选项取决于ssl-mode
未设置为的选项DISABLED。
tls-versions：用于加密 X 协议连接的允许的 TLS 协议。（复数）的值tls-versions是一个数组，例如[TLSv1.2,TLSv1.3]. 有关详细信息，请参阅
第 6.3.2 节，“加密连接 TLS 协议和密码”。此选项取决于ssl-mode
未设置为的选项DISABLED。
tls-ciphersuites：允许的 TLS 密码套件。的值
是在TLS Ciphersuitestls-ciphersuites中列出的 IANA 密码套件名称列表
。有关详细信息，请参阅
第 6.3.2 节，“加密连接 TLS 协议和密码”。此选项取决于
未设置为的选项。
ssl-modeDISABLED
auth-method：用于连接的身份验证方法。默认值为
AUTO，表示服务器尝试猜测。以下方法是允许的：
AUTO
MYSQL41
SHA256_MEMORY
FROM_CAPABILITIES
FALLBACK
PLAIN
对于 X 协议连接，任何配置
都将auth-method被覆盖为以下身份验证方法序列：
MYSQL41,
SHA256_MEMORY, PLAIN。
get-server-public-key: 从服务器请求基于 RSA 密钥对的密码交换所需的公钥。在使用 SSL 模式通过经典 MySQL 协议连接到 MySQL 8.0 服务器时使用
DISABLED。在这种情况下，您必须指定协议。例如：
mysql://user@localhost:3306?get-server-public-key=true
此选项适用于使用
caching_sha2_password身份验证插件进行身份验证的客户端。对于该插件，除非请求，否则服务器不会发送公钥。对于未使用该插件进行身份验证的帐户，将忽略此选项。如果不使用基于 RSA 的密码交换，它也会被忽略，就像客户端使用安全连接连接到服务器时的情况一样。
如果
给出并指定一个有效的公钥文件，它优先于.
server-public-key-path=file_nameget-server-public-key
有关
caching_sha2_password插件的信息，请参阅
第 6.4.1.2 节，“缓存 SHA-2 可插入身份验证”。
server-public-key-path：PEM 格式文件的路径名，其中包含服务器所需的公钥客户端副本，用于基于 RSA 密钥对的密码交换。在使用 SSL 模式通过经典 MySQL 协议连接到 MySQL 8.0 服务器时使用
DISABLED。
此选项适用于使用
sha256_password或
caching_sha2_password身份验证插件进行身份验证的客户端。对于未使用其中一个插件进行身份验证的帐户，将忽略此选项。如果不使用基于 RSA 的密码交换，它也会被忽略，就像客户端使用安全连接连接到服务器时的情况一样。
如果
给出并指定一个有效的公钥文件，它优先于.
server-public-key-path=file_nameget-server-public-key
有关sha256_password
和caching_sha2_password插件的信息，请参阅
第 6.4.1.3 节，“SHA-256 可插入身份验证”和
第 6.4.1.2 节，“缓存 SHA-2 可插入身份验证”。
ssh：用于连接到 SSH 服务器以使用 SSH 隧道访问 MySQL 服务器实例的 URI。URI 格式为
[user@]host[:port]. 使用该
uri选项指定目标 MySQL 服务器实例的 URI。有关来自 MySQL Shell 的 SSH 隧道连接的信息，请参阅
使用 SSH 隧道。
uri：要从选项指定的服务器通过 SSH 隧道访问的 MySQL 服务器实例的 URI ssh。URI 格式为[scheme://][user@]host[:port]. 不要使用基本连接参数 ( scheme, user,
host, port) 为 SSH 隧道指定 MySQL 服务器连接，只需使用该
uri选项即可。
ssh-password：连接SSH服务器的密码。
警告
在连接规范中指定显式密码是不安全的，不推荐使用。MySQL Shell 在需要时以交互方式提示输入密码。
ssh-config-file：用于连接SSH服务器的SSH配置文件。ssh.configFile如果未指定此选项，则可以使用 MySQL Shell 配置选项
将自定义文件设置为默认文件。如果
ssh.configFile没有设置，默认是标准的 SSH 配置文件
~/.ssh/config。
ssh-identity-file：用于连接到 SSH 服务器的标识文件。~/.ssh/id_rsa如果未指定此选项，则默认为在 SSH 代理（如果使用）、SSH 配置文件或 SSH 配置文件夹 ( )
中的标准私钥文件中配置的任何身份文件。
ssh-identity-pass：选项指定的标识文件的密码
ssh-identity-file。
警告
在连接规范中指定显式密码是不安全的，不推荐使用。MySQL Shell 在需要时以交互方式提示输入密码。
connect-timeout：一个整数值，用于配置客户端（例如 MySQL Shell）等待停止尝试连接到无响应的 MySQL 服务器的秒数。
compression：此选项请求或禁用连接压缩。在 MySQL 8.0.19 之前，它仅适用于经典 MySQL 协议连接，从 MySQL 8.0.20 开始，它也适用于 X 协议连接。
在 MySQL 8.0.19 之前，此选项的值为
true（或 1）启用压缩，默认值false
（或 0）禁用压缩。
从 MySQL 8.0.20 开始，此选项的值为 ，
required如果服务器不支持，则请求压缩并失败；preferred，它请求压缩并回退到未压缩的连接；和disabled，它请求未压缩的连接，如果服务器不允许这些连接，则失败。
preferred是 X 协议连接
disabled的默认值，也是经典 MySQL 协议连接的默认值。有关 X 插件连接压缩控制的信息，请参阅
第 20.5.5 节，“使用 X 插件进行连接压缩”.
请注意，不同的 MySQL 客户端以不同方式实现对连接压缩的支持。有关详细信息，请参阅客户的文档。
compression-algorithmsand
compression-level：这些选项在 MySQL Shell 8.0.20 及更高版本中可用，以更好地控制连接压缩。您可以指定它们以选择用于连接的压缩算法，以及用于该算法的数字压缩级别。您还可以使用compression-algorithmsinplace ofcompression来请求连接压缩。有关 MySQL Shell 的连接压缩控制的信息，请参阅
使用压缩连接。
connection-attributes：控制应用程序在连接时传递给服务器的键值对。有关连接属性的一般信息，请参阅
第 27.12.9 节，“性能模式连接属性表”。客户端通常定义一组默认属性，可以禁用或启用。例如：
mysqlx://user@host?connection-attributes
mysqlx://user@host?connection-attributes=true
mysqlx://user@host?connection-attributes=false
默认行为是发送默认属性集。除了默认属性之外，应用程序还可以指定要传递的属性。您将其他连接属性指定为connection-attributes
连接字符串中的参数。connection-attributes参数值必须为空（与指定相同
）
true、一个Boolean值（true或false启用或禁用默认属性集）或一个列表或零个或多个key=value用逗号分隔的说明符（除了默认属性集外还要发送） . 在列表中，缺少键值的计算结果为空字符串。更多示例：
mysqlx://user@host?connection-attributes=[attr1=val1,attr2,attr3=]
mysqlx://user@host?connection-attributes=[]
应用程序定义的属性名称不能以 开头，
_因为此类名称是为内部属性保留的。
使用类似 URI 的连接字符串进行连接
您可以使用类似 URI 的字符串指定与 MySQL 服务器的连接。这样的字符串可以与带有
--uri命令选项的 MySQL Shell、MySQL Shell\connect命令和实现 X DevAPI 的 MySQL 连接器一起使用。
笔记
术语“ URI-like ”表示与RFC 3986定义的 URI（统一资源标识符）语法相似但不相同的连接字符串语法
。
类似 URI 的连接字符串具有以下语法：
[scheme://][user[:[password]]@]host[:port][/schema][?attribute1=value1&attribute2=value2...
重要的
百分比编码必须用于类 URI 字符串元素中的保留字符。例如，如果您指定一个包含该@字符的字符串，则该字符必须替换为%40。如果在 IPv6 地址中包含区域 ID，则%
用作分隔符的字符必须替换为
%25.
您可以在类似 URI 的连接字符串中使用的参数在基本连接参数中进行了描述。
MySQL Shell 的shell.parseUri()和
shell.unparseUri()方法可用于解构和组装类似 URI 的连接字符串。给定一个类似 URI 的连接字符串，shell.parseUri()
返回一个包含在字符串中找到的每个元素的字典。shell.unparseUri()将 URI 组件和连接选项的字典转换为有效的类似 URI 的连接字符串，以连接到 MySQL，它可以在 MySQL Shell 中使用，也可以由实现 X DevAPI 的 MySQL 连接器使用。
如果在类似 URI 的字符串中未指定密码（建议这样做），交互式客户端会提示输入密码。以下示例显示如何使用用户名指定类似 URI 的字符串user_name。在每种情况下，都会提示输入密码。
与侦听端口 33065 的本地服务器实例的 X 协议连接。
mysqlx://user_name@localhost:33065
与侦听端口 3333 的本地服务器实例的经典 MySQL 协议连接。
mysql://user_name@localhost:3333
到远程服务器实例的 X 协议连接，使用主机名、IPv4 地址和 IPv6 地址。
mysqlx://user_name@server.example.com/
mysqlx://user_name@198.51.100.14:123
mysqlx://user_name@[2001:db8:85a3:8d3:1319:8a2e:370:7348]
使用套接字的 X 协议连接，使用百分比编码或括号提供路径。
mysqlx://user_name@/path%2Fto%2Fsocket.sock
mysqlx://user_name@(/path/to/socket.sock)
可以指定一个可选路径，它表示一个数据库。
# use 'world' as the default database
mysqlx://user_name@198.51.100.1/world
# use 'world_x' as the default database, encoding _ as %5F
mysqlx://user_name@198.51.100.2:33060/world%5Fx
可以指定一个可选的查询，由值组成，每个值作为一
对或单个给出。要指定多个值，请用字符分隔它们
。
和值的混合
是允许的。值可以是列表类型，列表值按外观排序。字符串必须采用百分比编码或用括号括起来。以下是等价的。
key=valuekey,key=valuekeyssluser@127.0.0.1?ssl-ca=%2Froot%2Fclientcert%2Fca-cert.pem\
&ssl-cert=%2Froot%2Fclientcert%2Fclient-cert.pem\
&ssl-key=%2Froot%2Fclientcert%2Fclient-key
ssluser@127.0.0.1?ssl-ca=(/root/clientcert/ca-cert.pem)\
&ssl-cert=(/root/clientcert/client-cert.pem)\
&ssl-key=(/root/clientcert/client-key)
要指定用于加密连接的 TLS 版本和密码套件：
mysql://user_name@198.51.100.2:3306/world%5Fx?\
tls-versions=[TLSv1.2,TLSv1.3]&tls-ciphersuites=[TLS_DHE_PSK_WITH_AES_128_\
GCM_SHA256, TLS_CHACHA20_POLY1305_SHA256]
前面的示例假定连接需要密码。对于交互式客户端，在登录提示时要求指定用户的密码。如果用户帐户没有密码（不安全且不推荐），或者如果正在使用套接字对等凭据身份验证（例如，使用 Unix 套接字连接），则必须在连接字符串中明确指定不提供密码并且不需要密码提示。为此，请
在字符串中的:之后
放置一个，user_name但不要在其后指定密码。例如：
mysqlx://user_name:@localhost
使用键值对连接
在 MySQL Shell 和一些实现 X DevAPI 的 MySQL 连接器中，您可以使用键值对指定与 MySQL 服务器的连接，以语言自然结构提供用于实现。例如，您可以使用键值对作为 JavaScript 中的 JSON 对象或 Python 中的字典来提供连接参数。无论提供键值对的方式如何，概念都保持不变：可以为本节中描述的键分配用于指定连接的值。shell.connect()您可以在 MySQL Shell 的方法或 InnoDB Cluster 的
方法中使用键值对指定连接
dba.createCluster()，并使用一些实现 X DevAPI 的 MySQL 连接器。
通常，键值对由
{和}字符
包围，字符,用作键值对之间的分隔符。字符用于键和值之间，:字符串必须分隔（例如，使用'字符）。与类似 URI 的连接字符串不同，不需要对字符串进行百分比编码。
指定为键值对的连接具有以下格式：
{ key: value, key: value, ...}基本连接参数
中描述了可用作连接键的参数。
如果在键值对中未指定密码（建议这样做），交互式客户端会提示输入密码。以下示例显示如何使用具有用户名的键值对指定连接
。在每种情况下，都会提示输入密码。
'user_name'
与侦听端口 33065 的本地服务器实例的 X 协议连接。
{user:'user_name', host:'localhost', port:33065}
与侦听端口 3333 的本地服务器实例的经典 MySQL 协议连接。
{user:'user_name', host:'localhost', port:3333}
到远程服务器实例的 X 协议连接，使用主机名、IPv4 地址和 IPv6 地址。
{user:'user_name', host:'server.example.com'}
{user:'user_name', host:198.51.100.14:123}
{user:'user_name', host:[2001:db8:85a3:8d3:1319:8a2e:370:7348]}
使用套接字的 X 协议连接。
{user:'user_name', socket:'/path/to/socket/file'}
可以指定一个可选的模式，它代表一个数据库。
{user:'user_name', host:'localhost', schema:'world'}
前面的示例假定连接需要密码。对于交互式客户端，在登录提示时要求指定用户的密码。如果用户帐户没有密码（不安全且不推荐），或者如果正在使用套接字对等凭据身份验证（例如，使用 Unix 套接字连接），则必须明确指定不提供密码并且密码提示不需要。为此，请
''在password键后使用提供一个空字符串。例如：
{user:'user_name', password:'', host:'localhost'}
© Mysql 中文网
