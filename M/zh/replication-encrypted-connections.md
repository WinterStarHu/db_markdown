# 17.3.1 设置复制以使用加密连接_MySQL 8.0 参考手册

17.3.1 设置复制以使用加密连接_MySQL 8.0 参考手册
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
17.1 配置复制
17.2 复制实现
17.3 复制安全
17.3.1 设置复制以使用加密连接1
17.3.2 加密二进制日志文件和中继日志文件1
17.3.3 复制权限检查1
17.4 复制解决方案
17.5 复制注意事项和技巧
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
MySQL 8.0 参考手册  / 第十七章复制  / 17.3 复制安全  /
17.3.1 设置复制以使用加密连接
17.3.1 设置复制以使用加密连接
要使用加密连接传输复制期间所需的二进制日志，源服务器和副本服务器都必须支持加密网络连接。如果任一服务器不支持加密连接（因为尚未为它们编译或配置），则无法通过加密连接进行复制。
为复制设置加密连接类似于为客户端/服务器连接设置加密连接。您必须获得（或创建）一个可以在源上使用的合适的安全证书，并在每个副本上获得一个类似的证书（来自相同的证书颁发机构）。您还必须获得合适的密钥文件。
有关为加密连接设置服务器和客户端的更多信息，请参阅
第 6.3.1 节，“配置 MySQL 以使用加密连接”。
要在源上启用加密连接，您必须创建或获取合适的证书和密钥文件，然后将以下配置参数添加到
[mysqld]源
my.cnf文件的部分，并根据需要更改文件名：
[mysqld]
ssl_ca=cacert.pem
ssl_cert=server-cert.pem
ssl_key=server-key.pem
文件的路径可以是相对的或绝对的；为此，我们建议您始终使用完整路径。
配置参数如下：
ssl_ca：证书颁发机构 (CA) 证书文件的路径名。(ssl_capath类似但指定了 CA 证书文件目录的路径名。)
ssl_cert: 服务器公钥证书文件的路径名。该证书可以发送到客户端并根据它拥有的 CA 证书进行身份验证。
ssl_key: 服务器私钥文件的路径名。
要在副本上启用加密连接，请使用
CHANGE REPLICATION SOURCE TO
语句（MySQL 8.0.23 及更高版本）或CHANGE
MASTER TO语句（MySQL 8.0.23 之前的版本）。
CHANGE REPLICATION SOURCE
TO要使用( )
命名副本的证书和 SSL 私钥文件CHANGE MASTER
TO，请添加适当的
( ) 选项，如下所示：
SOURCE_SSL_xxxMASTER_SSL_xxx    -> SOURCE_SSL_CA = 'ca_file_name',
-> SOURCE_SSL_CAPATH = 'ca_directory_name',
-> SOURCE_SSL_CERT = 'cert_file_name',
-> SOURCE_SSL_KEY = 'key_file_name',
这些选项对应于
具有相同名称的选项，如
加密连接的命令选项中所述。要使这些选项生效，还必须进行设置。对于复制连接，为或
指定一个值对应于设置
。仅当使用指定信息找到有效的匹配证书颁发机构 (CA) 证书时，连接尝试才会成功。
--ssl-xxxSOURCE_SSL=1SOURCE_SSL_CASOURCE_SSL_CAPATH--ssl-mode=VERIFY_CA
要激活主机名身份验证，请添加
SOURCE_SSL_VERIFY_SERVER_CERT选项，如下所示：
-> SOURCE_SSL_VERIFY_SERVER_CERT=1,
该选项对应的
--ssl-verify-server-cert选项在 MySQL 5.7 中弃用，在 MySQL 8.0 中移除。对于复制连接，指定
MASTER_SSL_VERIFY_SERVER_CERT=1对应于设置--ssl-mode=VERIFY_IDENTITY，如加密连接的命令选项中所述。要使此选项生效，
SOURCE_SSL=1还必须进行设置。主机名身份验证不适用于自签名证书。
要激活证书撤销列表 (CRL) 检查，请添加
SOURCE_SSL_CRL或
SOURCE_SSL_CRLPATH选项，如下所示：
-> SOURCE_SSL_CRL = 'crl_file_name',
-> SOURCE_SSL_CRLPATH = 'crl_directory_name',
这些选项对应于
具有相同名称的选项，如
加密连接的命令选项中所述。如果未指定，则不会进行 CRL 检查。
--ssl-xxx
要为复制连接指定副本允许的密码、密码套件和加密协议列表，请使用SOURCE_SSL_CIPHER、
SOURCE_TLS_VERSION和
SOURCE_TLS_CIPHERSUITES选项，如下所示：
-> SOURCE_SSL_CIPHER = 'cipher_list',
-> SOURCE_TLS_VERSION = 'protocol_list',
-> SOURCE_TLS_CIPHERSUITES = 'ciphersuite_list',
该SOURCE_SSL_CIPHER选项指定副本允许的一个或多个密码的冒号分隔列表，用于复制连接。
该SOURCE_TLS_VERSION选项指定复制连接的副本允许的 TLS 加密协议的逗号分隔列表，其格式类似于
tls_version服务器系统变量的格式。连接过程协商使用源和副本都允许的最高 TLS 版本。为了能够连接，副本必须至少有一个与源相同的 TLS 版本。
该SOURCE_TLS_CIPHERSUITES选项（从 MySQL 8.0.19 开始可用）指定一个或多个密码套件的冒号分隔列表，如果 TLSv1.3 用于连接，则复制连接的副本允许这些密码套件。如果此选项设置为NULL使用 TLSv1.3 时（如果未设置该选项，则为默认设置），则允许默认启用的密码套件。如果将选项设置为空字符串，则不允许使用任何密码套件，因此不使用 TLSv1.3。
您可以在这些列表中指定的协议、密码和密码套件取决于用于编译 MySQL 的 SSL 库。有关格式、允许值和未指定选项时的默认值的信息，请参阅第 6.3.2 节“加密连接 TLS 协议和密码”。
笔记
在 MySQL 8.0.16 到 8.0.18 中，MySQL 支持 TLSv1.3，但该SOURCE_TLS_CIPHERSUITES选项不可用。在这些版本中，如果 TLSv1.3 用于源和副本之间的连接，则源必须允许使用至少一个默认启用的 TLSv1.3 密码套件。从 MySQL 8.0.19 开始，您可以使用该选项指定任何选择的密码套件，如果需要，仅包括非默认密码套件。
更新源信息后，在副本上启动复制过程，如下所示：
mysql> START SLAVE;
首选从 MySQL 8.0.22 开始START REPLICA
，如下所示：
mysql> START REPLICA;
可以使用
SHOW
REPLICA STATUS（MySQL 8.0.22之前的
SHOW SLAVE
STATUS）语句来确认加密连接建立成功。
要求副本上的加密连接并不能确保源需要来自副本的加密连接。如果要确保源仅接受使用加密连接进行连接的副本，请使用该REQUIRE
SSL选项在源上创建一个复制用户帐户，然后授予该用户
REPLICATION SLAVE权限。例如：
mysql> CREATE USER 'repl'@'%.example.com' IDENTIFIED BY 'password'
-> REQUIRE SSL;
mysql> GRANT REPLICATION SLAVE ON *.*
-> TO 'repl'@'%.example.com';
如果您在源上有一个现有的复制用户帐户，您可以REQUIRE SSL使用以下语句添加到它：
mysql> ALTER USER 'repl'@'%.example.com' REQUIRE SSL;
© Mysql 中文网
