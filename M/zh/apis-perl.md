# 29.9 MySQL Perl API_MySQL 8.0 参考手册

29.9 MySQL Perl API_MySQL 8.0 参考手册
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
29.1 MySQL 连接器/C++
29.2 MySQL连接器/J
29.3 MySQL 连接器/NET
29.4 MySQL 连接器/ODBC
29.5 MySQL 连接器/Python
29.6 MySQL 连接器/Node.js
29.7 MySQL C API
29.8 MySQL PHP API
29.9 MySQL Perl API
29.10 MySQL Python API
29.11 MySQL Ruby API
29.12 MySQL Tcl API
29.13 MySQL埃菲尔包装器
第30章MySQL企业版
第31章MySQL工作台
第 32 章 OCI 市场上的 MySQL
附录 A MySQL 8.0 常见问题解答
附录 B 错误信息和常见问题
附录 C 索引
MySQL 词汇表
MySQL 8.0 参考手册  / 第 29 章连接器和 API  /
29.9 MySQL Perl API
29.9 MySQL Perl API
PerlDBI模块为数据库访问提供了一个通用接口。您可以编写无需更改即可与许多不同数据库引擎一起工作的 DBI 脚本。要将 DBI 与 MySQL 一起使用，请安装以下内容：
DBI模块
。DBD::mysql模块
。这是 Perl 的数据库驱动程序 (DBD) 模块。
（可选）您要访问的任何其他类型的数据库服务器的 DBD 模块。
Perl DBI 是推荐的 Perl 接口。它取代了一个名为 的旧接口mysqlperl，该接口应该被视为已过时。
这些部分包含有关将 Perl 与 MySQL 一起使用以及在 Perl 中编写 MySQL 应用程序的信息：
有关 Perl DBI 支持的安装说明，请参阅
第 2.13 节 “Perl 安装说明”。
有关从选项文件读取选项的示例，请参阅
第 5.8.4 节，“在多服务器环境中使用客户端程序”。
有关安全编码提示，请参阅
第 6.1.1 节“安全指南”。
有关调试提示，请参阅第 5.9.1.4 节，“在 gdb 下调试 mysqld”。
对于一些特定于 Perl 的环境变量，请参阅
第 4.9 节，“环境变量”。
有关在 macOS 上运行的注意事项，请参阅
第 2.4 节，“在 macOS 上安装 MySQL”。
有关引用字符串文字的方法，请参阅
第 9.1.1 节，“字符串文字”。
DBI 信息可通过命令行、在线或印刷形式获得：
安装DBI和
DBD::mysql模块后，您可以在命令行中使用以下命令获取有关它们的信息
perldoc：
$> perldoc DBI
$> perldoc DBI::FAQ
$> perldoc DBD::mysql
您还可以使用pod2man、
pod2html等将此信息转换为其他格式。
有关 Perl DBI 的联机信息，请访问 DBI 网站
http://dbi.perl.org/。该网站拥有一个通用的 DBI 邮件列表。
对于印刷信息，官方 DBI 书籍是
Programming the Perl DBI（Alligator Descartes 和 Tim Bunce，O'Reilly & Associates，2000）。有关本书的信息可在 DBI 网站
http://dbi.perl.org/上获得。
© Mysql 中文网
