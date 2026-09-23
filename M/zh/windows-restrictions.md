# 2.3.7 Windows 平台限制_MySQL 8.0 参考手册

2.3.7 Windows 平台限制_MySQL 8.0 参考手册
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
2.3.7 Windows 平台限制
2.3.7 Windows 平台限制
以下限制适用于在 Windows 平台上使用 MySQL：
进程内存
在 Windows 32 位平台上，默认情况下不可能在单个进程中使用超过 2GB 的 RAM，包括 MySQL。这是因为 Windows 32 位的物理地址限制为 4GB，Windows 中的默认设置是在内核 (2GB) 和用户/应用程序 (2GB) 之间拆分虚拟地址空间。
某些版本的 Windows 具有启动时间设置，可通过减少内核应用程序来启用更大的应用程序。或者，要使用超过 2GB 的空间，请使用 64 位版本的 Windows。
文件系统别名
使用MyISAM表时，您不能在 Windows 中使用别名链接到另一个卷上的数据文件，然后再链接回主要的 MySQL
datadir位置。
此工具通常用于将数据和索引文件移动到 RAID 或其他快速解决方案。
端口数量有限
Windows 系统有大约 4,000 个端口可用于客户端连接，并且在端口上的连接关闭后，需要两到四分钟才能重新使用该端口。在客户端以高速率连接和断开服务器的情况下，在关闭的端口再次可用之前，所有可用端口都可能用完。如果发生这种情况，MySQL 服务器似乎没有响应，即使它正在运行。端口也可能被机器上运行的其他应用程序使用，在这种情况下，MySQL 可用的端口数量较少。
有关此问题的更多信息，请参阅
https://support.microsoft.com/kb/196271。
DATA DIRECTORY和
INDEX DIRECTORY
如第 15.6.1.2 节“在外部创建表”中所述，Windows 仅
支持该语句
的DATA DIRECTORY子句
。对于
和其他存储引擎，
在 Windows 和任何其他具有非功能性调用
的平台上将忽略 for 的和子句。CREATE TABLEInnoDBMyISAMDATA DIRECTORYINDEX
DIRECTORYCREATE
TABLErealpath()
DROP
DATABASE
您不能删除另一个会话正在使用的数据库。
不区分大小写的名称
文件名在 Windows 上不区分大小写，因此 MySQL 数据库和表名在 Windows 上也不区分大小写。唯一的限制是数据库和表名必须在整个给定语句中使用相同的大小写指定。请参阅第 9.2.3 节，“标识符区分大小写”。
目录和文件名
在 Windows 上，MySQL 服务器仅支持与当前 ANSI 代码页兼容的目录和文件名。例如，以下日文目录名称在西方语言环境（代码页 1252）中不起作用：
datadir="C:/私たちのプロジェクトのデータ"
同样的限制也适用于 SQL 语句中引用的目录和文件名，例如LOAD DATA.
路径\名分隔符
Windows中路径名的组成部分是用字符分隔的
\，在MySQL中也是转义字符。如果您使用LOAD
DATAor
，请使用带有字符
SELECT ... INTO
OUTFILE的 Unix 样式文件名
：/mysql> LOAD DATA INFILE 'C:/tmp/skr.txt' INTO TABLE skr;
mysql> SELECT * INTO OUTFILE 'C:/tmp/skr.txt' FROM skr;
或者，您必须将\
字符加倍：
mysql> LOAD DATA INFILE 'C:\\tmp\\skr.txt' INTO TABLE skr;
mysql> SELECT * INTO OUTFILE 'C:\\tmp\\skr.txt' FROM skr;
管道问题
管道在 Windows 命令行提示符下无法可靠地工作。如果管道包含字符
^Z/ CHAR(24)，Windows 认为它​​遇到了文件结尾并中止程序。
当您尝试按如下方式应用二进制日志时，这主要是一个问题：
C:\> mysqlbinlog binary_log_file | mysql --user=root
如果您在应用日志时遇到问题并怀疑是因为^Z/
CHAR(24)字符，您可以使用以下解决方法：
C:\> mysqlbinlog binary_log_file --result-file=/tmp/bin.sql
C:\> mysql --user=root --execute "source /tmp/bin.sql"
后一个命令也可用于可靠地读取任何可能包含二进制数据的 SQL 文件。
© Mysql 中文网
