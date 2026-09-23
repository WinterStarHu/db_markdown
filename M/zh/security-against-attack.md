# 6.1.3 使 MySQL 免受攻击_MySQL 8.0 参考手册

6.1.3 使 MySQL 免受攻击_MySQL 8.0 参考手册
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
6.1 一般安全问题
6.1.1 安全指南1
6.1.2 保证密码安全1
6.1.3 使 MySQL 免受攻击1
6.1.4 安全相关的 mysqld 选项和变量1
6.1.5 如何以普通用户运行MySQL1
6.1.6 LOAD DATA LOCAL 的安全注意事项1
6.1.7 客户端编程安全指南1
6.2 访问控制和账户管理
6.3 使用加密连接
6.4 安全组件和插件
6.5 MySQL 企业数据屏蔽和去标识化
6.6 MySQL企业加密
6.7 SELinux
6.8 FIPS 支持
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
MySQL 8.0 参考手册  / 第 6 章 安全  / 6.1 一般安全问题  /
6.1.3 使 MySQL 免受攻击
6.1.3 使 MySQL 免受攻击
当您连接到 MySQL 服务器时，您应该使用密码。密码不会通过连接以明文形式传输。
所有其他信息都以文本形式传输，任何能够观看连接的人都可以阅读。如果客户端和服务器之间的连接通过不受信任的网络，并且您担心这一点，则可以使用压缩协议使流量更难破译。您还可以使用 MySQL 的内部 SSL 支持来使连接更加安全。请参阅
第 6.3 节，“使用加密连接”。或者，使用 SSH 在 MySQL 服务器和 MySQL 客户端之间获取加密的 TCP/IP 连接。您可以在http://www.openssh.org/找到开源 SSH 客户端
，以及开源和商业 SSH 客户端的比较：
http://en.wikipedia.org/wiki/Comparison_of_SSH_clients。
为了使 MySQL 系统安全，您应该认真考虑以下建议：
要求所有 MySQL 帐户都有密码。客户端程序不一定知道运行它的人的身份。对于客户端/服务器应用程序来说，用户可以向客户端程序指定任何用户名是很常见的。例如，任何人都可以像任何其他人一样使用mysql程序进行连接，只需调用它就
好像
没有密码一样。如果所有帐户都有密码，则使用其他用户的帐户进行连接会变得更加困难。
mysql -u other_user
db_nameother_user
有关设置密码的方法的讨论，请参阅
第 6.2.14 节，“分配帐户密码”。
确保在数据库目录中唯一具有读取或写入权限的 Unix 用户帐户是用于运行mysqld的帐户。
root
切勿以 Unix用户
身份运行 MySQL 服务器。这是非常危险的，因为任何拥有
FILE特权的用户都能够使服务器创建文件为root（例如，~root/.bashrc）。为了防止这种情况，
mysqld拒绝运行 as
root除非使用该--user=root选项明确指定。
mysqld可以（并且应该）作为普通的非特权用户运行。您可以创建一个单独的 Unix 帐户mysql，使一切更加安全。仅将此帐户用于管理 MySQL。要以不同的 Unix 用户身份启动mysqld ，请在指定服务器选项的选项文件组中
user指定用户名的例如：
[mysqld]my.cnf[mysqld]
user=mysql
这会导致服务器以指定用户身份启动，无论您是手动启动还是使用
mysqld_safe或
mysql.server启动它。有关详细信息，请参阅
第 6.1.5 节，“如何以普通用户身份运行 MySQL”。
以非 Unix 用户身份
运行mysqldroot并不意味着您需要更改表root中的用户名
user。MySQL 帐户的用户名与 Unix 帐户的用户名无关。
不要将FILE权限授予非管理用户。具有此权限的任何用户都可以使用mysqld守护程序的权限在文件系统中的任何位置写入文件。这包括服务器的数据目录，其中包含实现权限表的文件。为了使
FILE-privilege 操作更安全，生成的文件
SELECT ... INTO
OUTFILE不会覆盖现有文件并且每个人都可以写入。
该FILE权限还可用于读取任何世界可读或服务器运行的 Unix 用户可访问的文件。使用此权限，您可以将任何文件读取到数据库表中。这可能会被滥用，例如，通过使用LOAD
DATA加载/etc/passwd到一个表中，然后可以使用显示
SELECT。
要限制可以读写文件的位置，请将secure_file_priv
系统设置为特定目录。请参阅
第 5.1.8 节，“服务器系统变量”。
加密二进制日志文件和中继日志文件。加密有助于保护这些文件和其中包含的潜在敏感数据不被外部攻击者滥用，以及防止存储它们的操作系统用户未经授权查看。binlog_encryption您可以通过将系统变量设置为 来在 MySQL 服务器上启用加密
ON。有关详细信息，请参阅
第 17.3.2 节，“加密二进制日志文件和中继日志文件”。
不要向非管理用户授予PROCESS或
SUPER特权。mysqladmin processlist的输出SHOW
PROCESSLIST显示了当前正在执行的任何语句的文本，因此任何被允许查看服务器进程列表的用户都可能能够看到其他用户发出的语句。
mysqldCONNECTION_ADMIN为具有或
的用户保留一个额外的连接
SUPER，以便 MySQLroot用户可以登录并检查服务器活动，即使所有正常连接都在使用中。
该SUPER权限可用于终止客户端连接、通过更改系统变量的值来更改服务器操作以及控制复制服务器。
不允许使用表的符号链接。（可以使用该
--skip-symbolic-links
选项禁用此功能。）如果您将
mysqld运行为，这一点尤其重要root，因为对服务器数据目录具有写访问权限的任何人都可以删除系统中的任何文件！请参阅
第 8.12.2.2 节，“在 Unix 上使用 MyISAM 表的符号链接”。
存储程序和视图应使用
第 25.6 节“存储对象访问控制”中讨论的安全指南编写。
如果您不信任您的 DNS，您应该在授权表中使用 IP 地址而不是主机名。在任何情况下，您都应该非常小心地使用包含通配符的主机名值创建授权表条目。
如果要限制单个帐户允许的连接数，可以通过
在mysqldmax_user_connections中设置变量来实现。and语句还支持资源控制选项，
用于限制允许帐户使用服务器的范围。请参阅
第 13.7.1.3 节，“CREATE USER 语句”和
第 13.7.1.1 节，“ALTER USER 语句”。
CREATE
USERALTER USER
如果插件目录可由服务器写入，则用户可以使用 将可执行代码写入目录中的文件SELECT
... INTO DUMPFILE。这可以通过
plugin_dir将服务器设置为只读或设置
为可以安全写入
secure_file_priv的目录来防止。SELECT
© Mysql 中文网
