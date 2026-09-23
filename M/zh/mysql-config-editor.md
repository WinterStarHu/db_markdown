# 4.6.7 mysql_config_editor — MySQL 配置实用程序_MySQL 8.0 参考手册

4.6.7 mysql_config_editor — MySQL 配置实用程序_MySQL 8.0 参考手册
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
4.5 客户端程序
4.6 管理和实用程序
4.6.1 ibd2sdi — InnoDB 表空间 SDI 提取实用程序1
4.6.2 innochecksum — 离线 InnoDB 文件校验和工具1
4.6.3 myisam_ftdump——显示全文索引信息1
4.6.4 myisamchk — MyISAM 表维护实用程序1
4.6.5 myisamlog——显示MyISAM日志文件内容1
4.6.6 myisampack——生成压缩的、只读的 MyISAM 表1
4.6.7 mysql_config_editor — MySQL 配置实用程序1
4.6.8 mysql_migrate_keyring — 密钥环密钥迁移实用程序1
4.6.9 mysqlbinlog — 处理二进制日志文件的实用程序1
4.6.10 mysqldumpslow——总结慢查询日志文件1
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
MySQL 8.0 参考手册  / 第 4 章 MySQL 程序  / 4.6 管理和实用程序  /
4.6.7 mysql_config_editor — MySQL 配置实用程序
4.6.7 mysql_config_editor — MySQL 配置实用程序
mysql_config_editor实用程序使您能够将身份验证凭据存储
在名为.mylogin.cnf. 文件位置在 Windows 上是%APPDATA%\MySQL目录，在非 Windows 系统上是当前用户的主目录。稍后 MySQL 客户端程序可以读取该文件以获得连接到 MySQL 服务器的身份验证凭据。
登录路径文件的未混淆格式.mylogin.cnf
由选项组组成，类似于其他选项文件。中的每个选项组
.mylogin.cnf都称为“登录路径”，
这是一个只允许某些选项的组：host、user、
password和。将登录路径选项组视为一组选项，这些选项指定要连接到哪个 MySQL 服务器以及要以哪个帐户进行身份验证。这是一个未混淆的示例：
portsocket[client]
user = mydefaultname
password = mydefaultpass
host = 127.0.0.1
[mypath]
user = myothername
password = myotherpass
host = localhost
当您调用客户端程序连接到服务器时，客户端.mylogin.cnf会与其他选项文件一起使用。它的优先级高于其他选项文件，但低于在客户端命令行上明确指定的选项。有关选项文件使用顺序的信息，请参阅第 4.2.2.2 节，“使用选项文件”。
要指定备用登录路径文件名，请设置
MYSQL_TEST_LOGIN_FILE环境变量。该变量被
mysql_config_editor、标准 MySQL 客户端（mysql、
mysqladmin等）和
mysql-test-run.pl测试实用程序识别。
程序在登录路径文件中使用组，如下所示：
mysql_config_editorclient默认情况下
在登录路径上运行，
选项来明确指示要使用的登录路径。
--login-path=name
如果没有--login-path
选项，客户端程序会从登录路径文件中读取与从其他选项文件中读取的选项组相同的选项组。考虑这个命令：
mysql
默认情况下，mysql客户端从其他选项文件中读取
[client]和[mysql]
组，因此它也从登录路径文件中读取它们。
通过一个--login-path选项，客户端程序还可以从登录路径文件中读取指定的登录路径。从其他选项文件读取的选项组保持不变。考虑这个命令：
mysql --login-path=mypathmysql客户端
从其他选项文件中读取
[client]和，
以及
从登录路径文件中
读取, , 和 。[mysql][client][mysql][mypath]
即使使用该
--no-defaults选项，客户端程序也会读取登录路径文件。这允许以比在命令行上更安全的方式指定密码，即使
--no-defaults存在。
mysql_config_editor混淆了
.mylogin.cnf文件，因此它不能作为明文读取，并且当客户端程序未混淆时，它的内容仅在内存中使用。通过这种方式，密码可以以非明文格式存储在文件中并在以后使用，而无需在命令行或环境变量中公开。mysql_config_editor提供了一个
print用于显示登录路径文件内容的命令，但即使在这种情况下，密码值也会被屏蔽，以免以其他用户可以看到的方式出现。
mysql_config_editor
使用的混淆
可防止密码
.mylogin.cnf以明文形式出现，并通过防止无意中暴露密码来提供安全措施。例如，如果您
my.cnf在屏幕上显示一个常规的未混淆的选项文件，那么它包含的任何密码都是可见的，任何人都可以看到。对于
.mylogin.cnf，情况并非如此，但使用的混淆不太可能阻止坚定的攻击者，您不应认为它牢不可破。可以在您的计算机上获得系统管理权限以访问您的文件的用户可以.mylogin.cnf
通过一些努力来解密文件。
登录路径文件必须对当前用户可读可写，且其他用户不可访问。否则，
mysql_config_editor忽略它，客户端程序也不使用它。
像这样调用mysql_config_editor：
mysql_config_editor [program_options] command [command_options]
如果登录路径文件不存在，
mysql_config_editor会创建它。
命令参数如下：
program_options由一般的mysql_config_editor选项组成。
command指示对.mylogin.cnf登录路径文件执行的操作。例如，set将登录路径写入文件，remove删除登录路径，并print显示登录路径内容。
command_options指示特定于命令的任何其他选项，例如登录路径名称和要在登录路径中使用的值。
命令名称在程序参数集中的位置很重要。例如，这些命令行具有相同的参数，但产生不同的结果：
mysql_config_editor --help set
mysql_config_editor set --help
第一个命令行显示一般的
mysql_config_editor帮助消息，并忽略该set命令。第二个命令行显示特定于该set
命令的帮助消息。
假设您要建立一个client
定义默认连接参数的登录路径，以及一个额外的登录路径remote，用于连接到 MySQL 服务器 host
remote.example.com。您要按以下方式登录：
默认情况下，使用用户名和密码访问本地localuser服务器
localpass
使用用户名和密码访问远程
remoteuser服务器
remotepass
要在文件中设置登录路径
.mylogin.cnf，请使用以下
set命令。在一行中输入每个命令，并在出现提示时输入相应的密码：
$> mysql_config_editor set --login-path=client
--host=localhost --user=localuser --password
Enter password: enter password "localpass" here
$> mysql_config_editor set --login-path=remote
--host=remote.example.com --user=remoteuser --password
Enter password: enter password "remotepass" here
mysql_config_editor默认使用
client登录路径，因此
--login-path=client可以在第一个命令中省略该选项而不改变其效果。
要查看mysql_config_editor写入
.mylogin.cnf文件的内容，请使用以下
print命令：
$> mysql_config_editor print --all
[client]
user = localuser
password = *****
host = localhost
[remote]
user = remoteuser
password = *****
host = remote.example.com
该print命令将每个登录路径显示为一组行，这些行以方括号中指示登录路径名称的组标题开头，后跟登录路径的选项值。密码值被屏蔽并且不显示为明文。
如果不指定--all显示所有登录路径或
显示命名登录路径，则该命令默认显示登录路径（如果有）。
--login-path=nameprintclient
如前面的示例所示，登录路径文件可以包含多个登录路径。通过这种方式，
mysql_config_editor可以很容易地设置多个“个性”以连接到不同的 MySQL 服务器，或者使用不同的帐户连接到给定的服务器。--login-path当您调用客户端程序时，稍后可以使用该选项按名称选择其中任何一个。例如，要连接到远程服务器，请使用以下命令：
mysql --login-path=remote
在这里，mysql从其他选项文件中读取
[client]和[mysql]
选项组
[client]，并从登录路径文件中
读取[mysql]、 和
组。[remote]
要连接到本地服务器，请使用以下命令：
mysql --login-path=client
因为mysql默认读取的是
client和mysql登录路径，所以
--login-path在这种情况下该选项不添加任何内容。该命令等效于此命令：
mysql
从登录路径文件中读取的选项优先于从其他选项文件中读取的选项。从登录路径文件中稍后出现的登录路径组中读取的选项优先于从文件中较早出现的组中读取的选项。
mysql_config_editor按照您创建它们的顺序将登录路径添加到登录路径文件，因此您应该先创建更通用的登录路径，然后再创建更具体的路径。如果您需要在文件中移动登录路径，您可以删除它，然后重新创建它以将其添加到末尾。例如，
client登录路径更通用，因为所有客户端程序都读取它，而
mysqldump登录路径仅由
mysqldump读取。后面指定的选项会覆盖前面指定的选项，因此按顺序放置登录路径client，mysqldump
使mysqldump特定的选项能够覆盖client选项。
当您使用set带有
mysql_config_editor的命令来创建登录路径时，您不需要指定所有可能的选项值（主机名、用户名、密码、端口、套接字）。只有那些给定的值才会写入路径。当您调用客户端路径连接到 MySQL 服务器时，可以在其他选项文件或命令行中指定以后需要的任何缺失值。在命令行上指定的任何选项都会覆盖在登录路径文件或其他选项文件中指定的选项。例如，如果remote登录路径中的凭据也适用于主机remote2.example.com，请像这样连接到该主机上的服务器：
mysql --login-path=remote --host=remote2.example.com
mysql_config_editor 一般选项
mysql_config_editor支持以下常规选项，可以在命令行上命名的任何命令之前使用这些选项。有关命令特定选项的描述，请参阅mysql_config_editor 命令和命令特定选项。
表 4.20 mysql_config_editor 一般选项
选项名称
描述
--调试
写调试日志
- 帮助
显示帮助信息并退出
--冗长
详细模式
- 版本
显示版本信息并退出
--help,
-?
显示一般帮助信息并退出。
要查看特定于命令的帮助消息，请
按如下
方式调用mysql_config_editorcommand ，其中是除以下命令之外的命令
help：
mysql_config_editor command --help
--debug[=debug_options],
-# debug_options
写调试日志。典型的
debug_options字符串是
. 默认值为
。
d:t:o,file_named:t:o,/tmp/mysql_config_editor.trace
仅当 MySQL 是使用
WITH_DEBUG. Oracle 提供的 MySQL 发布二进制文件不是
使用此选项构建的。
--verbose,
-v
详细模式。打印有关程序功能的更多信息。如果操作没有达到您预期的效果，此选项可能有助于诊断问题。
--version,
-V
显示版本信息并退出。
mysql_config_editor 命令和特定于命令的选项
本节描述允许的
mysql_config_editor命令，以及对于每个命令，在命令行上的命令名称后允许的特定于命令的选项。
此外，mysql_config_editor支持可以在任何命令之前使用的通用选项。有关这些选项的描述，请参阅
mysql_config_editor 常规选项。
mysql_config_editor支持这些命令：
help
显示一般帮助信息并退出。此命令不采用以下选项。
要查看特定于命令的帮助消息，请
按如下
方式调用mysql_config_editorcommand ，其中是除以下命令之外的命令
help：
mysql_config_editor command --help
print
[options]
以未混淆的形式打印登录路径文件的内容，但密码显示为
*****.
client如果没有指定登录路径，则
默认登录路径名称。如果同时给出--all和
--login-path，
--all则优先。
该print命令允许在命令名称后使用这些选项：
--help,-?
显示print
命令的帮助消息并退出。
要查看一般帮助消息，请使用
mysql_config_editor --help。
--all
打印登录路径文件中所有登录路径的内容。
--login-path=name,
-G name
打印指定登录路径的内容。
remove
[options]
从登录路径文件中删除登录路径，或通过从中删除选项来修改登录路径。
此命令仅从登录路径中删除使用--host、
--password、--port、
--socket和选项指定的--user
选项。如果没有给出这些选项，则
remove删除整个登录路径。例如，此命令仅从登录路径中删除user
选项mypath而不是整个mypath登录路径：
mysql_config_editor remove --login-path=mypath --user
此命令删除整个mypath
登录路径：
mysql_config_editor remove --login-path=mypath
该remove命令允许在命令名称后使用这些选项：
--help,-?
显示remove
命令的帮助消息并退出。
要查看一般帮助消息，请使用
mysql_config_editor --help。
--host,-h
从登录路径中删除主机名。
--login-path=name,
-G name
要删除或修改的登录路径。client如果未给出此选项，则
默认登录路径名。
--password,-p
从登录路径中删除密码。
--port,-P
从登录路径中删除 TCP/IP 端口号。
--socket,-S
从登录路径中删除 Unix 套接字文件名。
--user,-u
从登录路径中删除用户名。
--warn,-w
如果命令尝试删除默认登录路径 ( client)
--login-path=client但未指定，则警告并提示用户进行确认。默认情况下启用此选项；用于
--skip-warn禁用它。
reset
[options]
清空登录路径文件的内容。
该reset命令允许在命令名称后使用这些选项：
--help,-?
显示reset
命令的帮助消息并退出。
要查看一般帮助消息，请使用
mysql_config_editor --help。
set [options]
将登录路径写入登录路径文件。
--host此命令仅将使用、
--password、--port、
--socket和选项
指定的选项写入登录路径--user
。如果没有给出这些选项，
mysql_config_editor将登录路径写入一个空组。
该set命令允许在命令名称后使用这些选项：
--help,-?
显示set
命令的帮助消息并退出。
要查看一般帮助消息，请使用
mysql_config_editor --help。
--host=host_name,
-h host_name
要写入登录路径的主机名。
--login-path=name,
-G name
要创建的登录路径。client如果未给出此选项，则
默认登录路径名
。
--password,-p
提示输入密码以写入登录路径。mysql_config_editor显示提示后
，输入密码并回车。为了防止其他用户看到密码，
mysql_config_editor不回显它。
要指定空密码，请在出现密码提示时按 Enter。写入登录路径文件的结果登录路径包括如下一行：
password =
--port=port_num,
-P port_num
要写入登录路径的 TCP/IP 端口号。
--socket=file_name,
-S file_name
要写入登录路径的 Unix 套接字文件名。
--user=user_name,
-u user_name
要写入登录路径的用户名。
--warn,-w
如果该命令试图覆盖现有的登录路径，则警告并提示用户进行确认。默认情况下启用此选项；用于
--skip-warn禁用它。
© Mysql 中文网
