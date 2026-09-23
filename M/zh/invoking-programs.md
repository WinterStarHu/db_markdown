# 4.2.1 调用MySQL程序_MySQL 8.0 参考手册

4.2.1 调用MySQL程序_MySQL 8.0 参考手册
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
4.2.1 调用MySQL程序
4.2.1 调用MySQL程序
要从命令行（即从您的 shell 或命令提示符）调用 MySQL 程序，请输入程序名称，后跟任何选项或其他参数，以指示程序执行您希望它执行的操作。以下命令显示了一些示例程序调用。$>代表命令解释器的提示符；它不是您键入内容的一部分。您看到的特定提示取决于您的命令解释器。典型的提示是$针对
sh、ksh或
bash、%针对
csh或tcsh以及
C:\>针对 Windows
command.com或cmd.exe
命令解释器。
$> mysql --user=root test
$> mysqladmin extended-status variables
$> mysqlshow --help
$> mysqldump -u root personnel-以单破折号或双破折号 ( , )
开头的参数--指定程序选项。选项通常指示程序应与服务器建立的连接类型或影响其操作模式。选项语法在第 4.2.2 节“指定程序选项”中进行了描述。
非选项参数（没有前导破折号的参数）为程序提供附加信息。例如，
mysql程序将第一个非选项参数解释为数据库名称，因此该命令mysql
--user=root test表明您要使用该
test数据库。
后面描述各个程序的部分指出程序支持哪些选项，并描述任何附加的非选项参数的含义。
一些选项对于许多程序是通用的。其中最常用的是
指定连接参数的--host(or -h)、
--user(or -u) 和--password(or
) 选项。-p它们指示运行 MySQL 服务器的主机，以及您的 MySQL 帐户的用户名和密码。所有 MySQL 客户端程序都理解这些选项；它们使您能够指定要连接到哪个服务器以及要在该服务器上使用的帐户。其他连接选项是
--port（或-P）指定 TCP/IP 端口号和
--socket（或-S) 来指定 Unix 上的 Unix 套接字文件（或 Windows 上的命名管道名称）。有关指定连接选项的选项的更多信息，请参阅第 4.2.4 节，“使用命令选项连接到 MySQL 服务器”。
您可能会发现有必要使用安装目录的路径名来调用 MySQL 程序bin。如果每当您尝试从该目录以外的任何目录运行 MySQL 程序时
收到“找不到程序”错误，则可能是这种情况
bin。为了更方便地使用MySQL，您可以将
bin目录的路径名添加到您的PATH
环境变量设置中。这使您能够通过仅键入程序名称而不是其整个路径名来运行程序。例如，如果
安装了
mysql ，您可以通过调用mysql/usr/local/mysql/bin来运行该程序，并且没有必要将其调用为
/usr/local/mysql/bin/mysql。
有关设置PATH变量的说明，请参阅命令解释器的文档。设置环境变量的语法是特定于解释器的。（一些信息在
第 4.2.9 节“设置环境变量”中给出。）修改PATH设置后，在 Windows 上打开一个新的控制台窗口或在 Unix 上重新登录以使设置生效。
© Mysql 中文网
