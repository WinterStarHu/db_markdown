# 8.8.1 使用 EXPLAIN 优化查询_MySQL 8.0 参考手册

8.8.1 使用 EXPLAIN 优化查询_MySQL 8.0 参考手册
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
8.8.1 使用 EXPLAIN 优化查询
8.8.1 使用 EXPLAIN 优化查询
该EXPLAIN语句提供了有关 MySQL 如何执行语句的信息：
EXPLAIN适用于
SELECT,
DELETE,
INSERT,
REPLACE, 和
UPDATE语句。
当EXPLAIN与可解释的语句一起使用时，MySQL 会显示来自优化器的有关语句执行计划的信息。也就是说，MySQL 解释了它将如何处理该语句，包括有关表如何连接以及连接顺序的信息。有关使用
EXPLAIN获取执行计划信息的信息，请参阅第 8.8.2 节，“EXPLAIN 输出格式”。
当EXPLAIN与
而不是可解释的语句一起使用时，它显示在命名连接中执行的语句的执行计划。请参阅第 8.8.4 节，“获取命名连接的执行计划信息”。
FOR CONNECTION
connection_id
对于SELECT语句，
EXPLAIN生成可​​以使用显示的附加执行计划信息
SHOW WARNINGS。请参阅
第 8.8.3 节，“扩展 EXPLAIN 输出格式”。
EXPLAIN对于检查涉及分区表的查询很有用。请参阅
第 24.3.5 节，“获取有关分区的信息”。
该FORMAT选项可用于选择输出格式。TRADITIONAL以表格格式显示输出。如果没有
FORMAT选项，这是默认值。
JSONformat 以 JSON 格式显示信息。
在 的帮助下EXPLAIN，您可以看到应该在何处向表添加索引，以便通过使用索引查找行来更快地执行语句。您还可以使用它
EXPLAIN来检查优化器是否以最佳顺序连接表。要提示优化器使用与表在语句中的命名顺序相对应的连接顺序，请
以而不是仅以.SELECT开始语句。（请参阅
第 13.2.10 节，“SELECT 语句”。）但是，
可能会阻止使用索引，因为它禁用了半连接转换。看
SELECT STRAIGHT_JOINSELECTSTRAIGHT_JOIN第 8.2.2.1 节，“使用半连接转换优化 IN 和 EXISTS 子查询谓词”。
优化器跟踪有时可能会提供与EXPLAIN. 但是，优化器跟踪格式和内容可能会因版本而异。有关详细信息，请参阅
MySQL 内部结构：跟踪优化器。
如果您遇到索引在您认为应该使用时未被使用的问题，请运行ANALYZE
TABLE以更新表统计信息，例如键的基数，这可能会影响优化器所做的选择。请参阅
第 13.7.3.1 节，“ANALYZE TABLE 语句”。
笔记
EXPLAIN也可用于获取有关表中列的信息。
是和
的同义词。有关详细信息，请参阅第 13.8.1 节，“DESCRIBE 语句”和
第 13.7.7.5 节，“SHOW COLUMNS 语句”。
EXPLAIN
tbl_nameDESCRIBE
tbl_nameSHOW COLUMNS FROM
tbl_name
© Mysql 中文网
