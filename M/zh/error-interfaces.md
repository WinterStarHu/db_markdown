# B.2 错误信息接口_MySQL 8.0 参考手册

B.2 错误信息接口_MySQL 8.0 参考手册
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
第30章MySQL企业版
第31章MySQL工作台
第 32 章 OCI 市场上的 MySQL
附录 A MySQL 8.0 常见问题解答
附录 B 错误信息和常见问题
B.1 错误消息来源和元素
B.2 错误信息接口
B.3 问题和常见错误
附录 C 索引
MySQL 词汇表
MySQL 8.0 参考手册  / 附录 B 错误信息和常见问题  /
B.2 错误信息接口
B.2 错误信息接口
错误消息可能源自服务器端或客户端，每条错误消息都包含错误代码、SQLSTATE 值和消息字符串，如
第 B.1 节“错误消息来源和元素”中所述。有关服务器端、客户端和全局（在服务器和客户端之间共享）错误的列表，请参阅MySQL 8.0 错误消息参考。
对于程序内部的错误检查，请使用错误代码编号或符号，而不是错误消息字符串。消息字符串不会经常更改，但这是可能的。此外，如果数据库管理员更改了语言设置，则会影响消息字符串的语言；参见第 10.12 节，“设置错误消息语言”。
MySQL 中的错误信息可在服务器错误日志、SQL 级别、客户端程序和命令行中获得。
错误日志SQL 错误消息接口客户端错误消息接口命令行错误消息接口
错误日志
在服务器端，一些消息用于错误日志。有关配置服务器在何处以及如何写入日志的信息，请参阅第 5.4.2 节，“错误日志”。
其他服务器错误消息旨在发送到客户端程序，并且如
客户端错误消息接口中所述可用。
特定错误代码所在的范围决定了服务器是将错误消息写入错误日志还是发送给客户端。有关这些范围的信息，请参阅
错误代码范围。
SQL 错误消息接口
在SQL层面，MySQL中错误信息的来源有几种：
SQL 语句警告和错误信息可通过SHOW WARNINGSand
SHOW ERRORS语句获得。warning_count系统变量指示错误、警告和注释的数量（如果禁用系统变量，则不包括注释
）
sql_notes。系统
error_count变量指示错误数。它的值不包括警告和注释。
该GET DIAGNOSTICS语句可用于检查诊断区域中的诊断信息。请参阅第 13.6.7.3 节，“GET DIAGNOSTICS 语句”。
SHOW SLAVE STATUS语句输出包括有关副本服务器上发生的复制错误的信息。
SHOW ENGINE
INNODB STATUSCREATE TABLE如果表的语句
InnoDB失败
，语句输出包括有关最近外键错误的信息
。
客户端错误消息接口
客户端程序从两个来源接收错误：
源自 MySQL 客户端库中客户端的错误。
源自服务器端并由服务器发送到客户端的错误。这些在客户端库中接收，这使得它们可用于主机客户端程序。
特定错误代码所在的范围决定了它是来自客户端库还是客户端从服务器接收到的。有关这些范围的信息，请参阅错误代码范围。
无论错误是来自客户端库还是从服务器接收到的错误，MySQL客户端程序通过调用客户端库中的C API函数来获取错误代码、SQLSTATE值、消息字符串和其他相关信息：
mysql_errno()返回 MySQL 错误代码。
mysql_sqlstate()返回 SQLSTATE 值。
mysql_error()返回消息字符串。
mysql_stmt_errno(),
mysql_stmt_sqlstate(), 和
mysql_stmt_error()是准备好的语句对应的误差函数。
mysql_warning_count()
返回最近语句的错误、警告和注释数。
有关客户端库错误函数的说明，请参阅
MySQL 8.0 C API 开发人员指南。
MySQL 客户端程序可能以不同的方式响应错误。客户端可能会显示错误消息，以便用户可以采取纠正措施，在内部尝试解决或重试失败的操作，或采取其他措施。例如，（使用
mysql客户端），无法连接到服务器可能会导致此消息：
$> mysql -h no-such-host
ERROR 2005 (HY000): Unknown MySQL server host 'no-such-host' (-2)
命令行错误消息接口
perror程序从命令行提供有关错误号的信息
。请参阅
第 4.8.2 节，“perror — 显示 MySQL 错误消息信息”。
$> perror 1231
MySQL error code MY-001231 (ER_WRONG_VALUE_FOR_VAR): Variable '%-.64s'
can't be set to the value of '%-.200s'
对于 MySQL NDB Cluster 错误，请使用ndb_perror。请参阅第 23.5.16 节，“ndb_perror — 获取 NDB 错误消息信息”。
$> ndb_perror 323
NDB error code 323: Invalid nodegroup id, nodegroup already existing:
Permanent error: Application error
© Mysql 中文网
