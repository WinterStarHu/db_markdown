# 18.6.2 使用安全套接字层 (SSL) 保护组通信连接_MySQL 8.0 参考手册

18.6.2 使用安全套接字层 (SSL) 保护组通信连接_MySQL 8.0 参考手册
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
18.1 组复制背景
18.2 开始
18.3 要求和限制
18.4 监控组复制
18.5 组复制操作
18.6 组复制安全
18.6.1 连接安全管理通信栈1
18.6.2 使用安全套接字层 (SSL) 保护组通信连接1
18.6.3 保护分布式恢复连接1
18.6.4 群组复制IP地址权限1
18.7 组复制性能和故障排除
18.8 升级组复制
18.9 组复制系统变量
18.10 常见问题
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
MySQL 8.0 参考手册  / 第十八章 组复制  / 18.6 组复制安全  /
18.6.2 使用安全套接字层 (SSL) 保护组通信连接
18.6.2 使用安全套接字层 (SSL) 保护组通信连接
安全套接字可用于组成员之间的组通信连接。
Group Replication 系统变量
group_replication_ssl_mode用于激活 SSL 用于组通信连接并指定连接的安全模式。默认设置意味着不使用 SSL。该选项具有以下可能的值：
表 18.1 group_replication_ssl_mode 配置值
价值
描述
DISABLED
建立未加密的连接（默认）。
REQUIRED
如果服务器支持安全连接，则建立安全连接。
VERIFY_CA
与 类似REQUIRED，但还根据配置的证书颁发机构 (CA) 证书验证服务器 TLS 证书。
VERIFY_IDENTITY
与 类似VERIFY_CA，但还要验证服务器证书是否与尝试连接的主机相匹配。
如果使用 SSL，配置安全连接的方式取决于是使用 XCom 还是 MySQL 通信堆栈进行组通信（从 MySQL 8.0.27 开始可以在两者之间进行选择）。
使用 XCom 通信堆栈 ( group_replication_communication_stack=XCOM) 时：
组复制组通信连接的其余配置取自服务器的 SSL 配置。有关配置服务器 SSL 的选项的更多信息，请参阅
加密连接的命令选项。应用于 Group Replication 的组通信连接的服务器 SSL 选项如下：
表 18.2 SSL 选项
服务器配置
描述
ssl_key
PEM 格式的 SSL 私钥文件的路径名。在客户端，这是客户端私钥。在服务器端，这是服务器私钥。
ssl_cert
PEM 格式的 SSL 公钥证书文件的路径名。在客户端，这是客户端公钥证书。在服务器端，这是服务器公钥证书。
ssl_ca
PEM 格式的证书颁发机构 (CA) 证书文件的路径名。
ssl_capath
包含 PEM 格式的可信 SSL 证书颁发机构 (CA) 证书文件的目录的路径名。
ssl_crl
包含 PEM 格式的证书吊销列表的文件的路径名。
ssl_crlpath
包含 PEM 格式的证书吊销列表文件的目录的路径名。
ssl_cipher
加密连接的允许密码列表。
tls_version
服务器允许加密连接的 TLS 协议列表。
tls_ciphersuites
服务器允许哪些 TLSv1.3 密码套件进行加密连接。
重要的
从 MySQL 8.0.28 开始，对 TLSv1 和 TLSv1.1 连接协议的支持已从 MySQL 服务器中删除。这些协议已从 MySQL 8.0.26 中弃用，但如果使用已弃用的 TLS 协议版本，MySQL 服务器客户端（包括充当客户端的组复制服务器实例）不会向用户返回警告。有关详细信息，请参阅
取消对 TLSv1 和 TLSv1.1 协议的支持
。
从 MySQL 8.0.16 开始，MySQL Server 支持 TLSv1.3 协议，前提是 MySQL Server 是使用 OpenSSL 1.1.1 编译的。服务器在启动时会检查OpenSSL的版本，如果低于1.1.1，则将TLS版本相关的服务器系统变量（包括
group_replication_recovery_tls_version
系统变量）的默认值去掉TLSv1.3。
Group Replication 从 MySQL 8.0.18 开始支持 TLSv1.3。在 MySQL 8.0.16 和 MySQL 8.0.17 中，如果服务器支持 TLSv1.3，则该协议在 group 通信引擎中不支持，无法被 Group Replication 使用。
在 MySQL 8.0.18 中，TLSv1.3 可以用于 Group Replication 用于分布式恢复连接，但是
group_replication_recovery_tls_version
和
group_replication_recovery_tls_ciphersuites
系统变量不可用。因此，捐赠者服务器必须允许使用至少一个默认启用的 TLSv1.3 密码套件，如
第 6.3.2 节“加密连接 TLS 协议和密码”中所列。从 MySQL 8.0.19 开始，您可以使用选项为任何选择的密码套件配置客户端支持，如果需要，仅包括非默认密码套件。
在
tls_version系统变量中指定的 TLS 协议列表中，确保指定的版本是连续的（例如，TLSv1.2,TLSv1.3）。如果协议列表中存在任何间隙（例如，如果您指定TLSv1,TLSv1.2，省略 TLS 1.1）组复制可能无法建立组通信连接。
在复制组中，OpenSSL 协商使用所有成员都支持的最高 TLS 协议。配置为仅使用 TLSv1.3 (tls_version=TLSv1.3) 无法加入任何现有成员不支持 TLSv1.3 的复制组，因为在这种情况下，组成员使用的是较低的 TLS 协议版本。要将成员加入组，您必须将加入成员配置为还允许使用现有组成员支持的较低 TLS 协议版本。相反，如果加入的成员不支持 TLSv1.3，但现有组成员都支持并正在使用该版本相互连接，如果现有组成员已经允许使用合适的较低 TLS 协议，则该成员可以加入版本，或者如果您将它们配置为这样做。在这种情况下，OpenSSL 对从每个成员到加入成员的连接使用较低的 TLS 协议版本。每个成员'
从 MySQL 8.0.16 开始，您可以
tls_version在运行时更改系统变量以更改服务器允许的 TLS 协议版本列表。请注意，对于 Group Replication，
ALTER INSTANCE RELOAD TLS
从定义上下文的系统变量的当前值重新配置服务器的 TLS 上下文的语句不会在 Group Replication 运行时更改 Group Replication 的组通信连接的 TLS 上下文。要将重新配置应用于这些连接，您必须执行，
STOP GROUP_REPLICATION然后
START GROUP_REPLICATION在您更改了的一个或多个成员上重新启动组复制
tls_version系统变量。同样，如果要让一个组的所有成员都改为使用更高或更低的TLS协议版本，则必须在更改允许的TLS协议版本列表后对成员进行Group Replication的滚动重启，以便OpenSSL协商滚动重启完成后使用更高的 TLS 协议版本。有关在运行时更改允许的 TLS 协议版本列表的说明，请参阅
第 6.3.2 节“加密连接 TLS 协议和密码”和
加密连接的服务器端运行时配置和监视。
以下示例显示了
my.cnf在服务器上配置 SSL 并为组复制组通信连接激活 SSL 的文件的一部分：
[mysqld]
ssl_ca = "cacert.pem"
ssl_capath = "/.../ca_directory"
ssl_cert = "server-cert.pem"
ssl_cipher = "DHE-RSA-AEs256-SHA"
ssl_crl = "crl-server-revoked.crl"
ssl_crlpath = "/.../crl_directory"
ssl_key = "server-key.pem"
group_replication_ssl_mode= REQUIRED
重要的
该ALTER INSTANCE RELOAD TLS
语句根据定义上下文的系统变量的当前值重新配置服务器的 TLS 上下文，在 Group Replication 运行时不会更改 Group Replication 的组通信连接的 TLS 上下文。要将重新配置应用于这些连接，您必须执行，
STOP GROUP_REPLICATION然后START GROUP_REPLICATION重新启动组复制。
上述选项不涵盖加入成员和现有成员之间为分布式恢复建立的连接。这些连接使用 Group Replication 的专用分布式恢复 SSL 选项，这些选项在
第 18.6.3.2 节“用于分布式恢复的安全套接字层 (SSL) 连接”中进行了描述。
使用MySQL通信栈时（group_replication_communication_stack=MYSQL）：
组分布式恢复的安全设置应用于组成员之间的正常通信。
有关如何配置安全设置的信息
，请参阅
第 18.6.3 节，“保护分布式恢复连接” 。
© Mysql 中文网
