# 2.3.5 Microsoft Windows MySQL 服务器安装故障排除_MySQL 8.0 参考手册

2.3.5 Microsoft Windows MySQL 服务器安装故障排除_MySQL 8.0 参考手册
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
2.1 一般安装指南
2.2 使用通用二进制文件在 Unix/Linux 上安装 MySQL
2.3 在 Microsoft Windows 上安装 MySQL
2.3.1 MySQL 在Microsoft Windows 上的安装布局1
2.3.2 选择安装包1
2.3.3 Windows 版 MySQL 安装程序1
2.3.4 使用 noinstall ZIP 存档在 Microsoft Windows 上安装 MySQL1
2.3.5 Microsoft Windows MySQL 服务器安装故障排除1
2.3.6 Windows 安装后程序1
2.3.7 Windows 平台限制1
2.4 在 macOS 上安装 MySQL
2.5 在 Linux 上安装 MySQL
2.6 使用坚不可摧的Linux网络（ULN）安装MySQL
2.7 在 Solaris 上安装 MySQL
2.8 在 FreeBSD 上安装 MySQL
2.9 从源码安装MySQL
2.10 安装后设置和测试
2.11 升级MySQL
2.12 降级MySQL
2.13 Perl 安装注意事项
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
MySQL 8.0 参考手册  / 第 2 章安装和升级 MySQL  / 2.3 在 Microsoft Windows 上安装 MySQL  /
2.3.5 Microsoft Windows MySQL 服务器安装故障排除
2.3.5 Microsoft Windows MySQL 服务器安装故障排除
首次安装和运行 MySQL 时，您可能会遇到某些阻止 MySQL 服务器启动的错误。本节帮助您诊断和纠正其中的一些错误。
解决服务器问题时的第一个资源是
错误日志。MySQL 服务器使用错误日志来记录与阻止服务器启动的错误相关的信息。错误日志位于文件中
指定的数据目录my.ini中。默认数据目录位置是C:\Program Files\MySQL\MySQL
Server 8.0\data，或者
C:\ProgramData\Mysql在 Windows 7 和 Windows Server 2008 上。C:\ProgramData默认情况下该目录是隐藏的。您需要更改文件夹选项才能查看目录和内容。有关错误日志和了解内容的更多信息，请参阅第 5.4.2 节“错误日志”。
有关可能出现的错误的信息，另请参阅 MySQL 服务启动时显示的控制台消息。将mysqld安装为服务后，从命令行使用SC START
mysqld_service_name或
NET START
mysqld_service_name命令
查看有关将 MySQL 服务器作为服务启动的任何错误消息。请参阅
第 2.3.4.8 节，“将 MySQL 作为 Windows 服务启动”。
以下示例显示了您在首次安装 MySQL 和启动服务器时可能遇到的其他常见错误消息：
如果 MySQL 服务器找不到mysql
权限数据库或其他关键文件，它会显示以下消息：
System error 1067 has occurred.
Fatal error: Can't open and lock privilege tables:
Table 'mysql.user' doesn't exist
当 MySQL 基本目录或数据目录安装在与默认位置不同的位置（分别为
C:\Program Files\MySQL\MySQL
Server 8.0和）时，通常会出现这些消息。C:\Program
Files\MySQL\MySQL Server 8.0\data
当 MySQL 升级并安装到新位置，但配置文件未更新以反映新位置时，可能会发生这种情况。此外，新旧配置文件可能会发生冲突。升级 MySQL 时一定要删除或重命名任何旧的配置文件。
如果您已将 MySQL 安装到目录以外的目录
C:\Program Files\MySQL\MySQL Server
8.0，请确保 MySQL 服务器通过使用配置 ( my.ini) 文件知道这一点。将
my.ini文件放在您的 Windows 目录中，通常是C:\WINDOWS. 要根据环境变量的值确定其确切位置，请WINDIR
从命令提示符发出以下命令：
C:\> echo %WINDIR%
您可以使用任何文本编辑器（例如记事本）创建或修改选项文件。例如，如果 MySQL 安装在
E:\mysql并且数据目录是
D:\MySQLdata，您可以创建选项文件并设置一个[mysqld]部分来指定basedir和
datadir选项的值：
[mysqld]
# set basedir to your installation path
basedir=E:/mysql
# set datadir to the location of your data directory
datadir=D:/MySQLdata
Microsoft Windows 路径名在选项文件中使用（正向）斜杠而不是反斜杠指定。如果您确实使用反斜杠，请将它们加倍：
[mysqld]
# set basedir to your installation path
basedir=C:\\Program Files\\MySQL\\MySQL Server 8.0
# set datadir to the location of your data directory
datadir=D:\\MySQLdata
在选项文件值中使用反斜杠的规则在第 4.2.2.2 节“使用选项文件”中给出。
如果更改datadirMySQL 配置文件中的值，则必须在重新启动 MySQL 服务器之前移动现有 MySQL 数据目录的内容。
请参见第 2.3.4.2 节，“创建选项文件”。
如果您在没有先停止和删除现有 MySQL 服务并使用 MySQL 安装程序安装 MySQL 的情况下重新安装或升级 MySQL，您可能会看到此错误：
Error: Cannot create Windows service for MySql. Error: 0
当配置向导尝试安装该服务并找到同名的现有服务时，就会发生这种情况。
mysql此问题的一种解决方案是在使用配置向导时
选择服务名称以外的服务名称。这样可以正确安装新服务，但保留过时的服务。虽然这无害，但最好删除不再使用的旧服务。
要永久删除旧mysql
服务，请在命令行上以具有管理权限的用户身份执行以下命令：
C:\> SC DELETE mysql
[SC] DeleteService SUCCESS
如果该SC实用程序不适用于您的 Windows 版本，请从http://www.microsoft.com/windows2000/techinfo/reskit/tools/existing/delsrv-o.aspdelsrv下载该
实用程序
并使用语法。
delsrv mysql
© Mysql 中文网
