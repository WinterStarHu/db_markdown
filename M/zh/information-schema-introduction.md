# 26.1 简介_MySQL 8.0 参考手册

26.1 简介_MySQL 8.0 参考手册
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
26.1 简介
26.2 INFORMATION_SCHEMA 表参考
26.3 INFORMATION_SCHEMA 总表
26.4 INFORMATION_SCHEMA InnoDB 表
26.5 INFORMATION_SCHEMA线程池表
26.6 INFORMATION_SCHEMA 连接控制表
26.7 INFORMATION_SCHEMA MySQL 企业防火墙表
26.8 SHOW 语句的扩展
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
MySQL 8.0 参考手册  / 第 26 章 INFORMATION_SCHEMA 表  /
26.1 简介
26.1 简介
INFORMATION_SCHEMA提供对数据库
元数据的访问，有关 MySQL 服务器的信息，例如数据库或表的名称、列的数据类型或访问权限。有时用于此信息的其他术语是
数据字典和
系统目录。
INFORMATION_SCHEMA 使用说明字符集注意事项INFORMATION_SCHEMA 作为 SHOW 语句的替代方案INFORMATION_SCHEMA 和权限性能注意事项标准注意事项INFORMATION_SCHEMA 参考部分中的约定相关信息
INFORMATION_SCHEMA 使用说明
INFORMATION_SCHEMA是每个 MySQL 实例中的一个数据库，存储有关 MySQL 服务器维护的所有其他数据库的信息的地方。该
INFORMATION_SCHEMA数据库包含几个只读表。它们实际上是视图，而不是基表，因此没有文件与它们相关联，并且您不能在它们上设置触发器。此外，不存在具有该名称的数据库目录。
虽然可以INFORMATION_SCHEMA通过语句选择为默认数据库USE
，但只能读取表的内容，不能对其进行
INSERT,
UPDATE, 或
DELETE操作。
以下是从 中检索信息的语句示例INFORMATION_SCHEMA：
mysql> SELECT table_name, table_type, engine
FROM information_schema.tables
WHERE table_schema = 'db5'
ORDER BY table_name;
+------------+------------+--------+
| table_name | table_type | engine |
+------------+------------+--------+
| fk         | BASE TABLE | InnoDB |
| fk2        | BASE TABLE | InnoDB |
| goto       | BASE TABLE | MyISAM |
| into       | BASE TABLE | MyISAM |
| k          | BASE TABLE | MyISAM |
| kurs       | BASE TABLE | MyISAM |
| loop       | BASE TABLE | MyISAM |
| pk         | BASE TABLE | InnoDB |
| t          | BASE TABLE | MyISAM |
| t2         | BASE TABLE | MyISAM |
| t3         | BASE TABLE | MyISAM |
| t7         | BASE TABLE | MyISAM |
| tables     | BASE TABLE | MyISAM |
| v          | VIEW       | NULL   |
| v2         | VIEW       | NULL   |
| v3         | VIEW       | NULL   |
| v56        | VIEW       | NULL   |
+------------+------------+--------+
17 rows in set (0.01 sec)
说明：该语句请求数据库中所有表的列表db5，仅显示三部分信息：表名、表类型和存储引擎。
从 MySQL 8.0.30 开始，关于生成的不可见主键的信息在所有
INFORMATION_SCHEMA描述表列、键或两者的表中默认可见，例如
COLUMNS和
STATISTICS表。如果您希望从从这些表中选择的查询中隐藏此类信息，您可以通过将
show_gipk_in_create_table_and_information_schema
服务器系统变量的值设置为 来实现OFF。有关详细信息，请参阅第 13.1.20.11 节，“生成的不可见主键”。
字符集注意事项
字符列（例如 ）的定义
通常TABLES.TABLE_NAME至少
为 64。MySQL 使用此字符集的默认排序规则 ( ) 对此类列进行所有搜索、排序、比较和其他字符串操作。
VARCHAR(N) CHARACTER SET
utf8mb3Nutf8mb3_general_ci
因为一些 MySQL 对象表示为文件，所以在
INFORMATION_SCHEMA字符串列中的搜索可能会受到文件系统区分大小写的影响。有关详细信息，请参阅第 10.8.7 节，“在 INFORMATION_SCHEMA 搜索中使用排序规则”。
INFORMATION_SCHEMA 作为 SHOW 语句的替代方案
该SELECT ... FROM INFORMATION_SCHEMA
语句旨在作为一种更一致的方式来提供对
SHOWMySQL 支持的各种语句（SHOW DATABASES、
SHOW TABLES等）提供的信息的访问。SELECT与以下相比，使用
具有以下优点SHOW：
它符合 Codd 的规则，因为所有访问都是在表上完成的。
您可以使用熟悉的
SELECT语句语法，只需要学习一些表名和列名。
实施者不必担心添加关键字。
您可以过滤、排序、连接INFORMATION_SCHEMA查询结果并将其转换为您的应用程序需要的任何格式，例如要解析的数据结构或文本表示形式。
这种技术与其他数据库系统的互操作性更强。例如，Oracle 数据库用户熟悉查询 Oracle 数据字典中的表。
因为SHOW熟悉并广泛使用，所以SHOW语句仍然作为替代。事实上，随着 的实现，如
第 26.8 节，“SHOW 语句的扩展”INFORMATION_SCHEMA中所述，有增强功能。
SHOW
INFORMATION_SCHEMA 和权限
对于大多数INFORMATION_SCHEMA表，每个 MySQL 用户都有权访问它们，但只能看到表中与用户具有适当访问权限的对象对应的行。在某些情况下（例如，表ROUTINE_DEFINITION中的列
INFORMATION_SCHEMA
ROUTINES），权限不足的用户会看到NULL。有些表有不同的权限要求；对于这些，在适用的表格描述中提到了要求。例如，InnoDB表（名称以 开头的表INNODB_）需要PROCESS权限。
相同的权限适用于从报表
中选择信息
INFORMATION_SCHEMA和查看相同的信息。SHOW在任何一种情况下，您都必须对某个对象具有某些权限才能查看有关它的信息。
性能注意事项
INFORMATION_SCHEMA从多个数据库中搜索信息的查询可能需要很长时间并影响性能。要检查查询的效率，您可以使用EXPLAIN. 有关使用EXPLAIN输出调整INFORMATION_SCHEMA查询的信息，请参阅
第 8.2.3 节，“优化 INFORMATION_SCHEMA 查询”。
标准注意事项
INFORMATION_SCHEMA
MySQL 中表结构
的实现遵循 ANSI/ISO SQL:2003 标准第 11 部分模式。我们的意图是大致符合 SQL:2003 核心特性 F021
基本信息模式。
SQL Server 2000（也遵循该标准）的用户可能会注意到一种强烈的相似性。然而，MySQL 省略了许多与我们的实现无关的列，并添加了 MySQL 特定的列。一个这样添加的列是
表ENGINE中的列
INFORMATION_SCHEMA
TABLES。
尽管其他 DBMS 使用各种名称，例如
syscat或system，但标准名称是INFORMATION_SCHEMA.
为了避免使用标准或 DB2、SQL Server 或 Oracle 中保留的任何名称，我们更改了一些标记为“ MySQL 扩展”的列的名称。（例如，我们
在
表中更改COLLATION为
。）请参阅本文末尾的保留字列表：
https ://web.archive.org/web/20070428032454/http://www.dbazine.com/db2 /db2-disarticles/gulutzan5。
TABLE_COLLATIONTABLES
INFORMATION_SCHEMA 参考部分中的约定
以下部分描述了 中的每个表和列INFORMATION_SCHEMA。对于每一列，有三部分信息：
“ INFORMATION_SCHEMAName ”
表示表中列的名称
INFORMATION_SCHEMA。这对应于标准 SQL 名称，除非
“备注”字段显示“ MySQL 扩展名。”
“SHOW名称”
表示最接近的
SHOW语句中的等效字段名称，如果有的话。
“备注”在适用的情况下提供额外信息。如果此字段为NULL，则表示该列的值始终为
NULL。如果此字段显示“ MySQL 扩展”，则该列是标准 SQL 的 MySQL 扩展。
许多部分指出什么SHOW
语句等效于从
SELECT中检索信息的a INFORMATION_SCHEMA。对于
SHOW显示默认数据库信息的语句（如果省略子句），通常可以通过向
从表
中检索信息的查询的子句添加条件来
选择默认数据库的信息。FROM
db_nameAND TABLE_SCHEMA = SCHEMA()WHEREINFORMATION_SCHEMA
相关信息
这些部分讨论其他
INFORMATION_SCHEMA与 - 相关的主题：
有关INFORMATION_SCHEMA
特定于InnoDB
存储引擎的表的信息：
第 26.4 节，“INFORMATION_SCHEMA InnoDB 表”
有关INFORMATION_SCHEMA
特定于线程池插件的表的信息：
第 26.5 节，“INFORMATION_SCHEMA 线程池表”
有关
插件
INFORMATION_SCHEMA
特定表的信息：第 26.6 节，“INFORMATION_SCHEMA 连接控制表”CONNECTION_CONTROL
有关
INFORMATION_SCHEMA数据库
的常见问题解答：第 A.7 节，“MySQL 8.0 FAQ：INFORMATION_SCHEMA”
INFORMATION_SCHEMA查询和优化器：第 8.2.3 节，“优化 INFORMATION_SCHEMA 查询”
排序规则对
INFORMATION_SCHEMA比较的影响：
第 10.8.7 节，“在 INFORMATION_SCHEMA 搜索中使用排序规则”
© Mysql 中文网
