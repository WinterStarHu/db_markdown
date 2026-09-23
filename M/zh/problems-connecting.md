# 6.2.22 MySQL连接问题排查_MySQL 8.0 参考手册

6.2.22 MySQL连接问题排查_MySQL 8.0 参考手册
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
6.2 访问控制和账户管理
6.2.1 账户用户名和密码1
6.2.2 MySQL提供的权限1
6.2.3 授权表1
6.2.4 指定账户名1
6.2.5 指定角色名称1
6.2.6 访问控制，第 1 阶段：连接验证1
6.2.7 访问控制，第 2 阶段：请求验证1
6.2.8 添加账号、分配权限、删除账号1
6.2.9 预留账户1
6.2.10 使用角色1
6.2.11 账户类别1
6.2.12 使用部分撤销的权限限制1
6.2.13 权限变更何时生效1
6.2.14 分配账户密码1
6.2.15 密码管理1
6.2.16 服务器对过期密码的处理1
6.2.17 可插拔认证1
6.2.18 多因素认证1
6.2.19 代理用户1
6.2.20 账户锁定1
6.2.21 设置账号资源限制1
6.2.22 MySQL连接问题排查1
6.2.23 基于 SQL 的账户活动审计1
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
MySQL 8.0 参考手册  / 第 6 章 安全  / 6.2 访问控制和账户管理  /
6.2.22 MySQL连接问题排查
6.2.22 MySQL连接问题排查
如果您在尝试连接到 MySQL 服务器时遇到问题，以下各项描述了您可以采取的一些措施来解决问题。
确保服务器正在运行。如果不是，则客户端无法连接到它。例如，如果尝试连接到服务器失败并显示如下消息之一，一个原因可能是服务器未运行：
$> mysql
ERROR 2003: Can't connect to MySQL server on 'host_name' (111)
$> mysql
ERROR 2002: Can't connect to local MySQL server through socket
'/tmp/mysql.sock' (111)
可能是服务器正在运行，但您正尝试使用与服务器侦听的不同的 TCP/IP 端口、命名管道或 Unix 套接字文件进行连接。要在调用客户端程序时更正此问题，请指定一个
--port选项以指示正确的端口号，或
指定一个--socket选项以指示正确的命名管道或 Unix 套接字文件。要找出套接字文件在哪里，可以使用以下命令：
$> netstat -ln | grep mysql
确保服务器未配置为忽略网络连接或（如果您尝试远程连接）未配置为仅在其网络接口上本地侦听。如果服务器在skip_networking
启用系统变量的情况下启动，则不接受任何 TCP/IP 连接。如果服务器启动时
bind_address系统变量设置为127.0.0.1，则它仅在环回接口上本地侦听 TCP/IP 连接，不接受远程连接。
检查以确保没有防火墙阻止对 MySQL 的访问。您的防火墙可能会根据正在执行的应用程序或 MySQL 用于通信的端口号（默认为 3306）进行配置。在 Linux 或 Unix 下，检查您的 IP 表（或类似的）配置以确保端口未被阻止。在 Windows 下，ZoneAlarm 或 Windows 防火墙等应用程序可能需要配置为不阻止 MySQL 端口。
必须正确设置授权表，以便服务器可以使用它们进行访问控制。对于某些发行版类型（例如 Windows 上的二进制发行版，或 Linux 上的 RPM 和 DEB 发行版），安装过程会初始化 MySQL 数据目录，包括
mysql包含授权表的系统数据库。对于不这样做的发行版，您必须手动初始化数据目录。有关详细信息，请参阅
第 2.10 节 “安装后设置和测试”。
要确定是否需要初始化授权表，请mysql在数据目录下查找目录。（数据目录通常命名为
data或var并且位于您的 MySQL 安装目录下。）确保您user.MYD在mysql数据库目录中有一个名为的文件。如果不是，则初始化数据目录。这样做并启动服务器后，您应该能够连接到服务器。
全新安装后，如果您尝试root不使用密码登录服务器，您可能会收到以下错误消息。
$> mysql -u root
ERROR 1045 (28000): Access denied for user 'root'@'localhost' (using password: NO)
这意味着在安装期间已经分配了 root 密码并且必须提供它。请参阅
第 2.10.4 节，“保护初始 MySQL 帐户的安全”，了解密码的不同分配方式，以及在某些情况下如何找到它。如果您需要重置根密码，请参阅第 B.3.3.2 节“如何重置根密码”中的说明。找到或重置密码后，
root使用
--password（或
-p）选项再次登录：
$> mysql -u root -p
Enter password:root但是，如果您使用mysqld --initialize-insecure初始化了 MySQL
，服务器将让您无需使用密码即可连接
（有关详细信息，请参阅
第 2.10.1 节“初始化数据目录”）。这是一个安全风险，所以你应该为
root帐户设置密码；有关说明，请参阅
第 2.10.4 节，“保护初始 MySQL 帐户”。
如果您已将现有的 MySQL 安装更新到更新版本，您是否执行了 MySQL 升级程序？如果没有，请这样做。添加新功能时，授权表的结构偶尔会发生变化，因此在升级后，您应该始终确保您的表具有当前结构。有关说明，请参阅第 2.11 节，“升级 MySQL”。
如果客户端程序在尝试连接时收到以下错误消息，则意味着服务器需要比客户端能够生成的格式更新的密码：
$> mysql
Client does not support authentication protocol requested
by server; consider upgrading MySQL client
请记住，客户端程序使用在选项文件或环境变量中指定的连接参数。如果您未在命令行中指定客户端程序似乎发送了不正确的默认连接参数，请检查任何适用的选项文件和您的环境。例如，如果Access
denied在没有任何选项的情况下运行客户端时得到，请确保您没有在任何选项文件中指定旧密码！
您可以通过使用选项调用客户端程序来抑制选项文件的使用
--no-defaults。例如：
$> mysqladmin --no-defaults -u root version客户端使用的选项文件在第 4.2.2.2 节“使用选项文件”
中列出
。环境变量在第 4.9 节“环境变量”中列出。
如果您收到以下错误，则表示您使用的root密码不正确：
$> mysqladmin -u root -pxxxx ver
Access denied for user 'root'@'localhost' (using password: YES)
如果即使您没有指定密码也会出现上述错误，则表示您在某些选项文件中列出的密码不正确。尝试
--no-defaults上一项中描述的选项。
有关更改密码的信息，请参阅
第 6.2.14 节“分配帐户密码”。
如果您丢失或忘记了root
密码，请参阅第 B.3.3.2 节“如何重置根密码”。
localhost是本地主机名的同义词，如果您没有明确指定主机，它也是客户端尝试连接的默认主机。
您可以使用一个--host=127.0.0.1
选项来明确命名服务器主机。这会导致到本地mysqld
服务器的 TCP/IP 连接。您还可以通过指定一个
--host使用本地主机的实际主机名的选项来使用 TCP/IP。在这种情况下，必须在user服务器主机上的表行中指定主机名，即使您在与服务器相同的主机上运行客户端程序也是如此。
错误消息会告诉您您尝试以谁的Access denied身份登录、您尝试连接的客户端主机以及您是否使用了密码。通常，表中应该有一行
user与错误消息中给出的主机名和用户名完全匹配。例如，如果您收到包含 的错误消息
using password: NO，则表示您尝试在没有密码的情况下登录。
如果您Access denied在尝试使用 连接到数据库时遇到错误，则表可能有问题。通过执行并发出以下 SQL 语句来检查：
mysql -u
user_nameusermysql -u root mysqlSELECT * FROM user;
结果应包括一行，其中的
Host和User列与您的客户端的主机名和您的 MySQL 用户名相匹配。
如果您尝试从运行 MySQL 服务器的主机以外的主机连接时出现以下错误，则意味着user
表中没有任何行具有Host与客户端主机匹配的值：
Host ... is not allowed to connect to this MySQL server
您可以通过为尝试连接时使用的客户端主机名和用户名的组合设置一个帐户来解决此问题。
如果您不知道要连接的机器的 IP 地址或主机名，您应该在表中放置一行
'%'作为Host列值user。尝试从客户端计算机连接后，使用SELECT
USER()查询来查看您实际上是如何连接的。然后'%'将
user表行中的 更改为日志中显示的实际主机名。否则，您的系统将不安全，因为它允许来自任何主机的给定用户名的连接。
在 Linux 上，可能发生此错误的另一个原因是您使用的二进制 MySQL 版本是使用与您正在使用的版本不同的glibc库版本编译的。在这种情况下，您应该升级您的操作系统或glibc，或者下载一个 MySQL 版本的源代码分发并自行编译。源 RPM 通常很容易编译和安装，所以这不是大问题。
如果您在尝试连接时指定了主机名，但收到主机名未显示或者是 IP 地址的错误消息，这意味着 MySQL 服务器在尝试将客户端主机的 IP 地址解析为一个名字：
$> mysqladmin -u root -pxxxx -h some_hostname ver
Access denied for user 'root'@'' (using password: YES)
如果您尝试连接 asroot并收到以下错误，这意味着您在
user表中没有User
列值为 的行，'root'并且
mysqld无法为您的客户端解析主机名：
Access denied for user ''@'unknown'
这些错误表明存在 DNS 问题。要修复它，请执行
mysqladmin flush-hosts以重置内部 DNS 主机缓存。请参阅第 5.1.12.3 节，“DNS 查找和主机缓存”。
一些永久的解决方案是：
确定您的 DNS 服务器有什么问题并修复它。
在 MySQL 授权表中指定 IP 地址而不是主机名。
/etc/hosts在 Unix 或
\windows\hostsWindows
上
为客户端机器名称输入一个条目
。在
启用系统变量
的情况下
启动mysqld 。skip_name_resolve使用该
选项
启动mysqld 。--skip-host-cache
在 Unix 上，如果您在同一台机器上运行服务器和客户端，请连接到localhost. 对于与 的连接localhost，MySQL 程序会尝试使用 Unix 套接字文件连接到本地服务器，除非指定连接参数以确保客户端建立 TCP/IP 连接。有关详细信息，请参阅
第 4.2.4 节，“使用命令选项连接到 MySQL 服务器”。
在 Windows 上，如果您在同一台机器上运行服务器和客户端，并且服务器支持命名管道连接，请连接到主机名.
（句点）。连接.使用命名管道而不是 TCP/IP。
如果mysql -u root有效但
结果是（本地主机的实际主机名在哪里
），您可能在表中没有正确的主机名。这里的一个常见问题是表行中的值
指定了一个不合格的主机名，但您系统的名称解析例程返回一个完全合格的域名（反之亦然）。例如，如果您在
表中有一行主机，但您的 DNS 告诉 MySQL 您的主机名是，则该行不起作用。尝试向
表中添加一行，其中包含主机的 IP 地址作为mysql
-h your_hostname -u rootAccess deniedyour_hostnameuserHostuser'pluto'user'pluto.example.com'userHost列值。
（或者，您可以使用包含通配符（例如，
）user的值向表中添加一行
。但是，使用以
结尾的值
是不安全的，
不推荐使用！）
Host'pluto.%'Host%
如果有效但
无效，则您尚未授予给定用户对名为 的数据库的访问权限。
mysql -u
user_namemysql -u user_name
some_dbsome_db
如果在服务器主机上执行时有效，但在远程客户端主机上执行时不起作用，则您尚未启用从远程主机为给定用户名访问服务器的权限。
mysql -u
user_namemysql -h
host_name -u
user_name
如果您无法弄清楚为什么会得到Access
denied，请从user
表中删除所有具有Host包含通配符的值的行（包含'%'
或'_'字符的行）。一个非常常见的错误是插入一个带有
Host='%'和
User=的新行，认为这可以让您指定
从同一台机器连接。这不起作用的原因是默认权限包含带有
=和
=的行。因为该行的值
比
'some_user'localhostHost'localhost'User''Host'localhost''%'，当从 ! 连接时，它优先于新行使用localhost！正确的过程是使用=和
=插入第二行，或者使用
Host='localhost'和
User=删除该行
。删除该行后，请记住发出一条语句以重新加载授权表。另见第 6.2.6 节，“访问控制，第 1 阶段：连接验证”。
'some_user'Host'localhost'User''FLUSH
PRIVILEGES
如果您能够连接到 MySQL 服务器，但
Access denied每当您发出
SELECT ... INTO
OUTFILEorLOAD DATA
语句时都会收到一条消息，则user表中的行没有FILE启用权限。
如果您直接更改授权表（例如，通过使用
INSERT、
UPDATE或
DELETE语句）并且您的更改似乎被忽略，请记住您必须执行
FLUSH PRIVILEGES语句或
mysqladmin flush-privileges命令以使服务器重新加载权限表。否则，直到下次重新启动服务器时，您的更改才会生效。请记住，在
root使用
UPDATE语句更改密码后，直到刷新权限后才需要指定新密码，因为服务器直到那时才知道您已更改密码。
如果您的权限似乎在会话中间发生了变化，则可能是 MySQL 管理员更改了它们。重新加载授权表会影响新的客户端连接，但它也会影响现有连接，如第 6.2.13 节，“权限更改何时生效”中所述。
如果您在使用 Perl、PHP、Python 或 ODBC 程序时遇到问题，请尝试使用或连接到服务器。如果您能够使用mysql客户端进行连接，则问题出在您的程序上，而不是访问权限上。（和密码之间没有空格；您也可以使用
语法指定密码。如果您使用没有密码值的
或
选项，MySQL 会提示您输入密码。）
mysql -u
user_name
db_namemysql
-u user_name
-ppassword
db_name-p--password=password-p--password
出于测试目的，使用该选项启动mysqld
服务器
。--skip-grant-tables然后你可以更改MySQL授权表并使用
SHOW GRANTS语句来检查你的修改是否达到了预期的效果。当您对更改感到满意时，执行mysqladmin flush-privileges告诉
mysqld服务器重新加载权限。这使您无需停止并重新启动服务器即可开始使用新的授权表内容。
如果其他一切都失败了，请
使用调试选项（例如，
）启动mysqld--debug=d,general,query服务器。这将打印有关尝试连接的主机和用户信息，以及有关发出的每个命令的信息。请参阅
第 5.9.4 节，“DBUG 包”。
如果您对 MySQL 授权表有任何其他问题并在
MySQL Community Slack上询问，请始终提供 MySQL 授权表的转储。您可以使用mysqldump mysql命令转储表。要提交错误报告，请参阅第 1.6 节“如何报告错误或问题”中的说明。在某些情况下，您可能需要重新启动mysqld--skip-grant-tables才能
运行
mysqldump。
© Mysql 中文网
