# 4.5.1 mysql——MySQL 命令行客户端_MySQL 8.0 参考手册

4.5.1 mysql——MySQL 命令行客户端_MySQL 8.0 参考手册
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
4.5.1 mysql——MySQL 命令行客户端1
4.5.2 mysqladmin——一个 MySQL 服务器管理程序1
4.5.3 mysqlcheck——表维护程序1
4.5.4 mysqldump——数据库备份程序1
4.5.5 mysqlimport——一个数据导入程序1
4.5.6 mysqlpump——数据库备份程序1
4.5.7 mysqlshow——显示数据库、表和列信息1
4.5.8 mysqlslap — 负载仿真客户端1
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
MySQL 8.0 参考手册  / 第 4 章 MySQL 程序  / 4.5 客户端程序  /
4.5.1 mysql——MySQL 命令行客户端
4.5.1 mysql——MySQL 命令行客户端
4.5.1.1 mysql 客户端选项4.5.1.2 mysql客户端命令4.5.1.3 mysql 客户端日志记录4.5.1.4 mysql客户端服务器端帮助4.5.1.5 从文本文件执行 SQL 语句4.5.1.6 mysql客户端提示
mysql是一个简单的 SQL shell，具有输入行编辑功能。它支持交互式和非交互式使用。当以交互方式使用时，查询结果以 ASCII 表格式显示。当以非交互方式使用时（例如，作为过滤器），结果以制表符分隔的格式显示。可以使用命令选项更改输出格式。
如果您因大型结果集的内存不足而遇到问题，请使用该--quick选项。这会强制mysql一次从服务器检索一行结果，而不是检索整个结果集并在显示之前将其缓冲在内存中。这是通过使用
mysql_use_result()客户端/服务器库中的 C API 函数而不是
mysql_store_result().
笔记
或者，MySQL Shell 提供对 X DevAPI 的访问。详情请参见MySQL Shell 8.0。
使用mysql非常简单。从命令解释器的提示中调用它，如下所示：
mysql db_name
或者：
mysql --user=user_name --password db_name
在这种情况下，您需要输入密码以响应mysql显示的提示：
Enter password: your_password
然后键入一条 SQL 语句，以 、 或 结束;，
\g然后\G按 Enter 键。
如果有当前语句，则键入Control+C会中断当前语句，否则会取消任何部分输入行。
您可以像这样在脚本文件（批处理文件）中执行 SQL 语句：
mysql db_name < script.sql > output.tab
在 Unix 上，mysql客户端将交互执行的语句记录到历史文件中。请参阅
第 4.5.1.3 节，“mysql 客户端日志记录”。
© Mysql 中文网
