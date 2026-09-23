# 4.4.3 mysql_ssl_rsa_setup — 创建 SSL/RSA 文件_MySQL 8.0 参考手册

4.4.3 mysql_ssl_rsa_setup — 创建 SSL/RSA 文件_MySQL 8.0 参考手册
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
4.3 服务器和服务器启动程序
4.4 安装相关程序
4.4.1 comp_err——编译MySQL错误信息文件1
4.4.2 mysql_secure_installation——提高MySQL安装安全性1
4.4.3 mysql_ssl_rsa_setup — 创建 SSL/RSA 文件1
4.4.4 mysql_tzinfo_to_sql — 加载时区表1
4.4.5 mysql_upgrade — 检查和升级 MySQL 表1
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
MySQL 8.0 参考手册  / 第 4 章 MySQL 程序  / 4.4 安装相关程序  /
4.4.3 mysql_ssl_rsa_setup — 创建 SSL/RSA 文件
4.4.3 mysql_ssl_rsa_setup — 创建 SSL/RSA 文件
该程序创建 SSL 证书和密钥文件以及 RSA 密钥对文件，以支持在未加密连接上使用 SSL 的安全连接和使用 RSA 的安全密码交换（如果这些文件丢失）。
如果现有文件已过期，
mysql_ssl_rsa_setup也可用于创建新的 SSL 文件。
笔记
mysql_ssl_rsa_setup使用
openssl命令，所以它的使用取决于你的机器上是否安装了 OpenSSL。
对于使用 OpenSSL 编译的 MySQL 发行版，另一种生成 SSL 和 RSA 文件的方法是让服务器自动生成它们。请参阅
第 6.3.3.1 节，“使用 MySQL 创建 SSL 和 RSA 证书和密钥”。
重要的
mysql_ssl_rsa_setup使生成所需文件变得更容易，从而有助于降低使用 SSL 的障碍。但是，
mysql_ssl_rsa_setup生成的证书是自签名的，不是很安全。在获得使用mysql_ssl_rsa_setup创建的文件的经验后，请考虑从注册的证书颁发机构获取 CA 证书。
像这样调用mysql_ssl_rsa_setup：
mysql_ssl_rsa_setup [options]
典型的选项是
--datadir指定在何处创建文件，以及
--verbose查看
mysql_ssl_rsa_setup执行
的openssl命令
。
mysql_ssl_rsa_setup尝试使用一组默认文件名创建 SSL 和 RSA 文件。它的工作原理如下：
mysql_ssl_rsa_setup在环境变量指定的位置检查
openssl二进制文件。PATH如果
没有找到
openssl ， mysql_ssl_rsa_setup什么都不做。如果
存在openssl，则
mysql_ssl_rsa_setup在该选项指定的 MySQL 数据目录中查找默认的 SSL 和 RSA 文件，
未给出
--datadir
选项，则在编译的数据目录
--datadir
mysql_ssl_rsa_setup检查具有以下名称的 SSL 文件的数据目录：
ca.pem
server-cert.pem
server-key.pem
如果存在任何这些文件，则
mysql_ssl_rsa_setup 不会创建 SSL 文件。否则，它会调用openssl来创建它们，以及一些额外的文件：
ca.pem               Self-signed CA certificate
ca-key.pem           CA private key
server-cert.pem      Server certificate
server-key.pem       Server private key
client-cert.pem      Client certificate
client-key.pem       Client private key
这些文件启用使用 SSL 的安全客户端连接；参见
第 6.3.1 节，“配置 MySQL 以使用加密连接”。
mysql_ssl_rsa_setup检查具有以下名称的 RSA 文件的数据目录：
private_key.pem      Private member of private/public key pair
public_key.pem       Public member of private/public key pair
如果存在这些文件中的任何一个，
mysql_ssl_rsa_setup 将不创建 RSA 文件。否则，它会调用openssl来创建它们。这些文件允许使用 RSA 通过未加密的连接为由sha256_password或
caching_sha2_password插件验证的帐户安全交换密码；请参阅
第 6.4.1.3 节，“SHA-256 可插入身份验证”和
第 6.4.1.2 节，“缓存 SHA-2 可插入身份验证”。
有关
mysql_ssl_rsa_setup创建的文件的特征的信息，请参阅
第 6.3.3.1 节，“使用 MySQL 创建 SSL 和 RSA 证书和密钥”。
在启动时，MySQL 服务器会自动使用mysql_ssl_rsa_setup--ssl创建的 SSL 文件来启用 SSL，如果除了（可能连同
）之外没有给出明确的 SSL 选项
ssl_cipher。如果您更喜欢显式指定文件，请在启动时使用 、 和 选项调用客户端以
--ssl-ca分别
--ssl-cert命名
--ssl-key、ca.pem和
server-cert.pem文件
server-key.pem。
如果没有给出明确的 RSA 选项
，服务器还会自动使用
mysql_ssl_rsa_setup创建的 RSA 文件来启用 RSA。
如果服务器启用了 SSL，则客户端默认使用 SSL 进行连接。要明确指定证书和密钥文件，请分别使用--ssl-ca、
--ssl-cert和
--ssl-key选项命名
ca.pem、
client-cert.pem和
client-key.pem文件。但是，可能首先需要一些额外的客户端设置，因为mysql_ssl_rsa_setup默认情况下会在数据目录中创建这些文件。数据目录的权限通常只允许访问运行 MySQL 服务器的系统帐户，因此客户端程序不能使用位于那里的文件。要使文件可用，请将它们复制到一个可读的目录（但不是
可写）由客户：
对于本地客户端，可以使用 MySQL 安装目录。例如，如果数据目录是安装目录的子目录，而你当前所在的位置是数据目录，你可以这样复制文件：
cp ca.pem client-cert.pem client-key.pem ..
对于远程客户端，使用安全通道分发文件以确保它们在传输过程中不被篡改。
如果用于 MySQL 安装的 SSL 文件已过期，您可以使用mysql_ssl_rsa_setup创建新的：
停止服务器。
重命名或删除现有的 SSL 文件。您可能希望先备份它们。（RSA 文件不会过期，所以你不需要删除它们
。mysql_ssl_rsa_setup可以看到它们存在并且不会覆盖它们。）
使用
选项
运行mysql_ssl_rsa_setup--datadir以指定在何处创建新文件。
重新启动服务器。
mysql_ssl_rsa_setup支持以下命令行选项，可以在命令行或选项文件的组中指定[mysql_ssl_rsa_setup]。
[mysqld]有关 MySQL 程序使用的选项文件的信息，请参阅
第 4.2.2.2 节，“使用选项文件”。
表 4.9 mysql_ssl_rsa_setup 选项
选项名称
描述
--数据目录
数据目录路径
- 帮助
显示帮助信息并退出
- 后缀
X.509 证书通用名称属性的后缀
--uid
用于文件权限的有效用户名
--冗长
详细模式
- 版本
显示版本信息并退出
--help,
?
显示帮助信息并退出。
--datadir=dir_name
mysql_ssl_rsa_setup应该检查默认 SSL 和 RSA 文件
的目录的路径，
如果它们丢失，它应该在其中创建文件。默认是编译数据目录。
--suffix=str
X.509 证书中 Common Name 属性的后缀。后缀值限制为 17 个字符。默认基于 MySQL 版本号。
--uid=name,
-v
应该是任何已创建文件的所有者的用户的名称。该值是用户名，而不是数字用户 ID。在没有这个选项的情况下，由
mysql_ssl_rsa_setup创建的文件归执行它的用户所有。仅当您在root支持chown()系统调用的系统上执行程序时，此选项才有效。
--verbose,
-v
详细模式。产生更多关于程序做什么的输出。例如，该程序显示它运行的
openssl命令，并生成输出以指示它是否跳过 SSL 或 RSA 文件创建，因为某些默认文件已经存在。
--version,
-V
显示版本信息并退出。
© Mysql 中文网
