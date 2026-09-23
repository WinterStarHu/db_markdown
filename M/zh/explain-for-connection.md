# 8.8.4 获取命名连接的执行计划信息_MySQL 8.0 参考手册

8.8.4 获取命名连接的执行计划信息_MySQL 8.0 参考手册
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
8.1 优化概述
8.2 优化SQL语句
8.3 优化和索引
8.4 优化数据库结构
8.5 优化 InnoDB 表
8.6 优化 MyISAM 表
8.7 优化 MEMORY 表
8.8 了解查询执行计划
8.8.1 使用 EXPLAIN 优化查询1
8.8.2 EXPLAIN 输出格式1
8.8.3 扩展的 EXPLAIN 输出格式1
8.8.4 获取命名连接的执行计划信息1
8.8.5 估计查询性能1
8.9 控制查询优化器
8.10 缓冲和缓存
8.11 优化锁定操作
8.12 优化MySQL服务器
8.13 测量性能（基准测试）
8.14 查看服务器线程（进程）信息
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
MySQL 8.0 参考手册  / 第8章优化  / 8.8 了解查询执行计划  /
8.8.4 获取命名连接的执行计划信息
8.8.4 获取命名连接的执行计划信息
要获取在命名连接中执行的可解释语句的执行计划，请使用以下语句：
EXPLAIN [options] FOR CONNECTION connection_id;
EXPLAIN FOR CONNECTION返回EXPLAIN当前用于在给定连接中执行查询的信息。由于数据（和支持统计数据）的更改，它可能会产生与
EXPLAIN在等效查询文本上运行不同的结果。这种行为差异可用于诊断更多瞬态性能问题。例如，如果您在一个会话中运行一条需要很长时间才能完成的语句，那么EXPLAIN FOR
CONNECTION在另一个会话中使用它可能会产生有关延迟原因的有用信息。
connection_id是从
INFORMATION_SCHEMA
PROCESSLIST表或
SHOW PROCESSLIST语句中获取的连接标识符。如果您有PROCESS权限，您可以为任何连接指定标识符。否则，您可以仅为自己的连接指定标识符。在所有情况下，您都必须有足够的权限来解释指定连接上的查询。
如果命名连接没有执行语句，则结果为空。否则，EXPLAIN FOR CONNECTION
仅当在命名连接中执行的语句是可解释的时才适用。这包括
SELECT、
DELETE、
INSERT、
REPLACE和
UPDATE。（但是，
EXPLAIN FOR CONNECTION不适用于准备好的语句，甚至是那些类型的准备好的语句。）
如果命名连接正在执行可解释的语句，则输出是您通过
EXPLAIN在语句本身上使用而获得的内容。
如果命名连接正在执行无法解释的语句，则会发生错误。例如，您不能为当前会话命名连接标识符，因为
EXPLAIN无法解释：
mysql> SELECT CONNECTION_ID();
+-----------------+
| CONNECTION_ID() |
+-----------------+
|             373 |
+-----------------+
1 row in set (0.00 sec)
mysql> EXPLAIN FOR CONNECTION 373;
ERROR 1889 (HY000): EXPLAIN FOR CONNECTION command is supported
only for SELECT/UPDATE/INSERT/DELETE/REPLACECom_explain_other状态变量指示执行的
语句EXPLAIN FOR
CONNECTION数。
© Mysql 中文网
