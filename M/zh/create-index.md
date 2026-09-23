# 13.1.15 CREATE INDEX 语句_MySQL 8.0 参考手册

13.1.15 CREATE INDEX 语句_MySQL 8.0 参考手册
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
13.1 数据定义语句
13.1.1 原子数据定义语句支持1
13.1.2 ALTER DATABASE 语句1
13.1.3 ALTER EVENT 语句1
13.1.4 ALTER FUNCTION 语句1
13.1.5 ALTER INSTANCE 语句1
13.1.6 ALTER LOGFILE GROUP 语句1
13.1.7 ALTER PROCEDURE 语句1
13.1.8 ALTER SERVER 语句1
13.1.9 ALTER TABLE 语句1
13.1.10 ALTER TABLESPACE 语句1
13.1.11 ALTER VIEW 语句1
13.1.12 CREATE DATABASE 语句1
13.1.13 CREATE EVENT 语句1
13.1.14 CREATE FUNCTION 语句1
13.1.15 CREATE INDEX 语句1
13.1.16 CREATE LOGFILE GROUP 语句1
13.1.17 CREATE PROCEDURE 和 CREATE FUNCTION 语句1
13.1.18 CREATE SERVER 语句1
13.1.19 CREATE SPATIAL REFERENCE SYSTEM 语句1
13.1.20 CREATE TABLE 语句1
13.1.21 CREATE TABLESPACE 语句1
13.1.22 CREATE TRIGGER 语句1
13.1.23 CREATE VIEW 语句1
13.1.24 DROP DATABASE 语句1
13.1.25 DROP EVENT 语句1
13.1.26 DROP FUNCTION 语句1
13.1.27 DROP INDEX 语句1
13.1.28 DROP LOGFILE GROUP 语句1
13.1.29 DROP PROCEDURE 和 DROP FUNCTION 语句1
13.1.30 DROP SERVER 语句1
13.1.31 DROP SPATIAL REFERENCE SYSTEM 语句1
13.1.32 DROP TABLE 语句1
13.1.33 DROP TABLESPACE 语句1
13.1.34 DROP TRIGGER 语句1
13.1.35 DROP VIEW 语句1
13.1.36 RENAME TABLE 语句1
13.1.37 TRUNCATE TABLE 语句1
13.2 数据操作语句
13.3 事务和锁定语句
13.4 复制语句
13.5 准备好的语句
13.6 复合语句语法
13.7 数据库管理语句
13.8 效用语句
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
MySQL 8.0 参考手册  / 第 13 章 SQL 语句  / 13.1 数据定义语句  /
13.1.15 CREATE INDEX 语句
13.1.15 CREATE INDEX 语句
CREATE [UNIQUE | FULLTEXT | SPATIAL] INDEX index_name
[index_type]
ON tbl_name (key_part,...)
[index_option]
[algorithm_option | lock_option] ...
key_part: {col_name [(length)] | (expr)} [ASC | DESC]
index_option: {
KEY_BLOCK_SIZE [=] value
| index_type
| WITH PARSER parser_name
| COMMENT 'string'
| {VISIBLE | INVISIBLE}
| ENGINE_ATTRIBUTE [=] 'string'
| SECONDARY_ENGINE_ATTRIBUTE [=] 'string'
}
index_type:
USING {BTREE | HASH}
algorithm_option:
ALGORITHM [=] {DEFAULT | INPLACE | COPY}
lock_option:
LOCK [=] {DEFAULT | NONE | SHARED | EXCLUSIVE}
通常，您在使用 . 创建表本身时在表上创建所有索引CREATE
TABLE。请参阅第 13.1.20 节，“CREATE TABLE 语句”。该指南对于表尤其重要，因为
InnoDB表中的主键决定了数据文件中行的物理布局。
CREATE INDEX使您能够向现有表添加索引。
CREATE INDEX映射到
ALTER TABLE创建索引的语句。请参阅第 13.1.9 节，“ALTER TABLE 语句”。
CREATE INDEX不能用于创建PRIMARY KEY; 改用
ALTER TABLE。有关索引的更多信息，请参阅第 8.3.1 节，“MySQL 如何使用索引”。
InnoDB支持虚拟列上的二级索引。有关详细信息，请参阅
第 13.1.20.9 节，“二级索引和生成的列”。
启用该innodb_stats_persistent
设置后，在该表上创建索引后运行该表
的ANALYZE
TABLE语句
。InnoDB
从 MySQL 8.0.17 开始，expr
forkey_part规范可以采用在列上创建多值索引的形式
。请参阅多值索引。
(CAST json_expression
AS type ARRAY)JSON
表单的索引规范
创建具有多个关键部分的索引。索引键值是通过连接给定键部分的值形成的。例如，
指定一个多列索引，其索引键由 、 和 中的
值组成
。
(key_part1,
key_part2, ...)(col1, col2, col3)col1col2col3key_part规范可以以 or 结尾，
以ASC指定DESC索引值是按升序还是降序存储。如果没有给出顺序说明符，则默认为升序。
ASC并且DESC不允许用于HASH索引。
ASC并且DESC也不支持多值索引。从 MySQL 8.0.12 开始，
ASC不允许DESC用于SPATIAL索引。
以下部分描述了该
CREATE INDEX声明的不同方面：
列前缀关键部分功能键部件唯一索引全文索引多值索引空间索引指数期权表格复制和锁定选项
列前缀关键部分
对于字符串列，可以创建仅使用列值前导部分的索引，使用
语法指定索引前缀长度：
col_name(length)
可以为
CHAR、
VARCHAR、
BINARY和
VARBINARYkey 部分指定前缀。
必须为
BLOB关键
TEXT部分指定
前缀。此外，
BLOB和
TEXT列只能为InnoDB、
MyISAM和BLACKHOLE
表编制索引。
前缀限制以字节为单位。但是，、 和语句中索引规范的前缀长度被解释为非二进制字符串类型（ 、 、 ）的字符数和二进制字符串类型（ 、
、
）
的
字节数。在为使用多字节字符集的非二进制字符串列指定前缀长度时，请考虑这一点。
CREATE
TABLEALTER TABLECREATE INDEXCHARVARCHARTEXTBINARYVARBINARYBLOB
前缀支持和前缀长度（在支持的情况下）取决于存储引擎。
例如，对于使用或
行格式的InnoDB
表，
前缀最长可达 767 个字节。
对于使用or
行格式的表，
前缀长度限制为 3072 字节
。对于表，前缀长度限制为 1000 字节。存储引擎不支持前缀（请参阅
第
23.2.7.6 节，“NDB Cluster 中不支持或缺少的功能”）。
REDUNDANTCOMPACTInnoDBDYNAMICCOMPRESSEDMyISAMNDB
如果指定的索引前缀超过最大列数据类型大小，CREATE INDEX则按如下方式处理索引：
对于非唯一索引，要么发生错误（如果启用了严格 SQL 模式），要么索引长度减少到位于最大列数据类型大小内并产生警告（如果未启用严格 SQL 模式）。
对于唯一索引，无论 SQL 模式如何，都会发生错误，因为减少索引长度可能会启用不满足指定唯一性要求的非唯一条目的插入。
此处显示的语句使用列的前 10 个字符创建索引name（假设它
name具有非二进制字符串类型）：
CREATE INDEX part_of_name ON customer (name(10));
如果列中的名称通常前 10 个字符不同，则使用此索引执行的查找应该不会比使用从整个
name列创建的索引慢很多。此外，为索引使用列前缀可以使索引文件小得多，这可以节省大量磁盘空间，还可以加快
INSERT操作速度。
功能键部件
“普通”索引索引列值或列值的前缀。例如，在下表中，给定t1行的索引条目包括完整
值和由其前 10 个字符组成的值
col1的前缀
：col2CREATE TABLE t1 (
col1 VARCHAR(10),
col2 VARCHAR(20),
INDEX (col1, col2(10))
);
MySQL 8.0.13 及更高版本支持索引表达式值而不是列或列前缀值的功能键部分。使用功能键部分可以对未直接存储在表中的值进行索引。例子：
CREATE TABLE t1 (col1 INT, col2 INT, INDEX func_index ((ABS(col1))));
CREATE INDEX idx1 ON t1 ((col1 + col2));
CREATE INDEX idx2 ON t1 ((col1 + col2), (col1 - col2), col1);
ALTER TABLE t1 ADD INDEX ((col1 * 40) DESC);
具有多个关键部分的索引可以混合使用非功能性和功能性关键部分。
ASC并DESC支持功能关键部件。
功能关键部件必须遵守以下规则。如果关键部分定义包含不允许的构造，则会发生错误。
在索引定义中，将表达式括在括号内以将它们与列或列前缀区分开来。例如，这是允许的；表达式括在括号内：
INDEX ((col1 + col2), (col3 - col4))
这会产生一个错误；表达式未括在括号中：
INDEX (col1 + col2, col3 - col4)
功能键部分不能仅由列名组成。例如，这是不允许的：
INDEX ((col1), (col2))
相反，将关键部分写为非功能性关键部分，不带括号：
INDEX (col1, col2)
功能键部分表达式不能引用列前缀。有关解决方法，请参阅
本节SUBSTRING()和
CAST()后面的讨论。
外键规范中不允许使用功能键部分。
对于CREATE
TABLE ... LIKE，目标表保留了原始表中的功能关键部分。
功能索引被实现为隐藏的虚拟生成列，这具有以下含义：
每个功能键部分都计入表列总数的限制；请参阅
第 8.4.7 节，“表列数和行大小的限制”。
功能键部分继承适用于生成列的所有限制。例子：
功能键部分只允许生成列允许的功能。
不允许使用子查询、参数、变量、存储函数和可加载函数。
有关适用限制的更多信息，请参阅
第 13.1.20.8 节，“CREATE TABLE 和生成的列”和
第 13.1.9.2 节，“ALTER TABLE 和生成的列”。
虚拟生成的列本身不需要存储。索引本身与任何其他索引一样占用存储空间。
UNIQUE支持包含功能键部分的索引。但是，主键不能包含功能键部分。主键需要存储生成列，但功能键部分实现为虚拟生成列，而不是存储生成列。
SPATIAL和FULLTEXT
索引不能有功能键部分。
如果表不包含主键，InnoDB
则自动将第一个UNIQUE NOT
NULL索引提升为主键。UNIQUE NOT NULL具有功能键部分
的索引不支持此功能。
如果存在重复索引，则非功能性索引会发出警告。包含功能关键部分的索引没有此功能。
要删除功能键部分引用的列，必须先删除索引。否则，会发生错误。
尽管非功能性关键部分支持前缀长度规范，但这对于功能性关键部分是不可能的。解决方案是使用
SUBSTRING()（或
CAST()，如本节后面所述）。SUBSTRING()对于包含要在查询中使用的函数的功能键部分
，WHERE子句必须包含
SUBSTRING()相同的参数。在以下示例中，只有第二个
SELECT能够使用索引，因为这是参数
SUBSTRING()与索引规范匹配的唯一查询：
CREATE TABLE tbl (
col1 LONGTEXT,
INDEX idx1 ((SUBSTRING(col1, 1, 10)))
);
SELECT * FROM tbl WHERE SUBSTRING(col1, 1, 9) = '123456789';
SELECT * FROM tbl WHERE SUBSTRING(col1, 1, 10) = '1234567890';
功能键部分可以索引无法以其他方式索引的值，例如JSON
值。但是，必须正确地完成此操作才能达到预期的效果。例如，此语法不起作用：
CREATE TABLE employees (
data JSON,
INDEX ((data->>'$.name'))
);
语法失败，因为：
运算符
->>
翻译成
.
JSON_UNQUOTE(JSON_EXTRACT(...))
JSON_UNQUOTE()返回数据类型为 的值
LONGTEXT，因此隐藏的生成列被分配相同的数据类型。
MySQL 无法索引LONGTEXT
键部分没有前缀长度的指定列，功能键部分不允许有前缀长度。
要索引该JSON列，您可以尝试使用CAST()如下函数：
CREATE TABLE employees (
data JSON,
INDEX ((CAST(data->>'$.name' AS CHAR(30))))
);
隐藏的生成列被分配了
VARCHAR(30)可以被索引的数据类型。但是这种方法在尝试使用索引时会产生一个新问题：
CAST()返回带有排序规则utf8mb4_0900_ai_ci（服务器默认排序规则）的字符串。
JSON_UNQUOTE()返回带有排序规则的字符串utf8mb4_bin
（硬编码）。
因此，前面表定义中的索引表达式
WHERE与以下查询中的子句表达式之间存在排序规则不匹配：
SELECT * FROM employees WHERE data->>'$.name' = 'James';
未使用索引，因为查询中的表达式与索引不同。为了支持功能关键部分的这种情况，优化器
CAST()会在查找要使用的索引时自动剥离，但前提是索引表达式的排序规则与查询表达式的排序规则相匹配。对于要使用的具有功能键部分的索引，以下两种解决方案中的任何一种都有效（尽管它们在效果上有所不同）：
解决方案 1. 为索引表达式分配与以下相同的排序规则JSON_UNQUOTE()：
CREATE TABLE employees (
data JSON,
INDEX idx ((CAST(data->>"$.name" AS CHAR(30)) COLLATE utf8mb4_bin))
);
INSERT INTO employees VALUES
('{ "name": "james", "salary": 9000 }'),
('{ "name": "James", "salary": 10000 }'),
('{ "name": "Mary", "salary": 12000 }'),
('{ "name": "Peter", "salary": 8000 }');
SELECT * FROM employees WHERE data->>'$.name' = 'James';->>运算符与 相同
JSON_UNQUOTE(JSON_EXTRACT(...))，
JSON_UNQUOTE()返回一个排序规则为 的
字符串utf8mb4_bin。因此比较区分大小写，只有一行匹配：
+------------------------------------+
| data                               |
+------------------------------------+
| {"name": "James", "salary": 10000} |
+------------------------------------+
解决方案 2. 在查询中指定完整的表达式：
CREATE TABLE employees (
data JSON,
INDEX idx ((CAST(data->>"$.name" AS CHAR(30))))
);
INSERT INTO employees VALUES
('{ "name": "james", "salary": 9000 }'),
('{ "name": "James", "salary": 10000 }'),
('{ "name": "Mary", "salary": 12000 }'),
('{ "name": "Peter", "salary": 8000 }');
SELECT * FROM employees WHERE CAST(data->>'$.name' AS CHAR(30)) = 'James';
CAST()返回一个带有 collat​​ion 的字符串
utf8mb4_0900_ai_ci，因此比较不区分大小写并且两行匹配：
+------------------------------------+
| data                               |
+------------------------------------+
| {"name": "james", "salary": 9000}  |
| {"name": "James", "salary": 10000} |
+------------------------------------+
请注意，虽然优化器支持CAST()使用索引生成的列自动剥离，但以下方法不起作用，因为它会在使用和不使用索引时产生不同的结果（错误#27337092）：
mysql> CREATE TABLE employees (
data JSON,
generated_col VARCHAR(30) AS (CAST(data->>'$.name' AS CHAR(30)))
);
Query OK, 0 rows affected, 1 warning (0.03 sec)
mysql> INSERT INTO employees (data)
VALUES ('{"name": "james"}'), ('{"name": "James"}');
Query OK, 2 rows affected, 1 warning (0.01 sec)
Records: 2  Duplicates: 0  Warnings: 1
mysql> SELECT * FROM employees WHERE data->>'$.name' = 'James';
+-------------------+---------------+
| data              | generated_col |
+-------------------+---------------+
| {"name": "James"} | James         |
+-------------------+---------------+
1 row in set (0.00 sec)
mysql> ALTER TABLE employees ADD INDEX idx (generated_col);
Query OK, 0 rows affected, 1 warning (0.03 sec)
Records: 0  Duplicates: 0  Warnings: 1
mysql> SELECT * FROM employees WHERE data->>'$.name' = 'James';
+-------------------+---------------+
| data              | generated_col |
+-------------------+---------------+
| {"name": "james"} | james         |
| {"name": "James"} | James         |
+-------------------+---------------+
2 rows in set (0.01 sec)
唯一索引
索引创建一个UNIQUE约束，使得索引中的所有值都必须不同。如果您尝试添加具有与现有行匹配的键值的新行，则会发生错误。如果为
UNIQUE索引中的列指定前缀值，则列值在前缀长度内必须是唯一的。UNIQUE
索引NULL允许包含NULL.
如果一个表有一个PRIMARY KEYor
UNIQUE NOT NULL索引，该索引由具有整数类型的单个列组成，您可以
_rowid在语句中使用引用索引列
SELECT，如下所示：
_rowidPRIMARY
KEY如果存在PRIMARY
KEY由单个整数列组成的列，则指该列。如果有一个PRIMARY KEY但它不是由单个整数列组成，
_rowid则不能使用。
否则，如果索引由单个整数列组成，则_rowid引用第一个索引中的列。UNIQUE NOT NULL如果第一个
UNIQUE NOT NULL索引不包含单个整数列，_rowid则不能使用。
全文索引
FULLTEXTInnoDB只有和
表支持索引，
MyISAM并且只能包含
CHAR、
VARCHAR和
TEXT列。索引总是发生在整个列上；不支持列前缀索引，如果指定，任何前缀长度都会被忽略。有关操作的详细信息，请参见
第 12.10 节，“全文搜索功能”。
多值索引
从 MySQL 8.0.17 开始，InnoDB支持多值索引。多值索引是在存储值数组的列上定义的二级索引。“
正常”索引对每个数据记录 (1:1) 有一个索引记录。多值索引可以为单个数据记录 (N:1) 具有多个索引记录。多值索引用于索引JSON数组。例如，在以下 JSON 文档中的邮政编码数组上定义的多值索引为每个邮政编码创建一个索引记录，每个索引记录引用相同的数据记录。
{
"user":"Bob",
"user_id":31,
"zipcode":[94477,94536]
}
创建多值索引
CREATE TABLE您可以在、
ALTER TABLE或
CREATE INDEX语句
中创建多值索引
。这需要CAST(... AS ...
ARRAY)在索引定义中使用，它将数组中相同类型的标量值转换JSON为 SQL 数据类型数组。然后使用 SQL 数据类型数组中的值透明地生成一个虚拟列；最后，在虚拟列上创建功能索引（也称为虚拟索引）。它是在构成多值索引的 SQL 数据类型数组中的值的虚拟列上定义的功能索引。
以下列表中的示例显示了可以在名为 的表的列zips上的数组$.zipcode上
创建多值索引的三种不同方式。在每种情况下，JSON 数组都转换为
整数值的 SQL 数据类型数组。
JSONcustinfocustomersUNSIGNED
CREATE TABLE只要：
CREATE TABLE customers (
id BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
modified DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
custinfo JSON,
INDEX zips( (CAST(custinfo->'$.zipcode' AS UNSIGNED ARRAY)) )
);
CREATE TABLE加上ALTER
TABLE：
CREATE TABLE customers (
id BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
modified DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
custinfo JSON
);
ALTER TABLE customers ADD INDEX zips( (CAST(custinfo->'$.zipcode' AS UNSIGNED ARRAY)) );
CREATE TABLE加上CREATE
INDEX：
CREATE TABLE customers (
id BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
modified DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
custinfo JSON
);
CREATE INDEX zips ON customers ( (CAST(custinfo->'$.zipcode' AS UNSIGNED ARRAY)) );
多值索引也可以定义为复合索引的一部分。此示例显示了一个复合索引，它包括两个单值部分（对于列id和
modified列）和一个多值部分（对于custinfo列）：
CREATE TABLE customers (
id BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
modified DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
custinfo JSON
);
ALTER TABLE customers ADD INDEX comp(id, modified,
(CAST(custinfo->'$.zipcode' AS UNSIGNED ARRAY)) );
一个复合索引中只能使用一个多值键部分。多值密钥部分可以相对于密钥的其他部分以任何顺序使用。换句话说，ALTER
TABLE刚才显示的语句可以使用
comp(id, (CAST(custinfo->'$.zipcode' AS UNSIGNED
ARRAY), modified))（或任何其他顺序）并且仍然有效。
使用多值索引
WHERE当在子句
中指定以下函数时，优化器使用多值索引来获取记录
：
MEMBER OF()
JSON_CONTAINS()
JSON_OVERLAPS()
customers我们可以通过使用以下
CREATE TABLEandINSERT
语句
创建和填充表来证明这一点
：mysql> CREATE TABLE customers (
->     id BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
->     modified DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
->     custinfo JSON
->     );
Query OK, 0 rows affected (0.51 sec)
mysql> INSERT INTO customers VALUES
->     (NULL, NOW(), '{"user":"Jack","user_id":37,"zipcode":[94582,94536]}'),
->     (NULL, NOW(), '{"user":"Jill","user_id":22,"zipcode":[94568,94507,94582]}'),
->     (NULL, NOW(), '{"user":"Bob","user_id":31,"zipcode":[94477,94507]}'),
->     (NULL, NOW(), '{"user":"Mary","user_id":72,"zipcode":[94536]}'),
->     (NULL, NOW(), '{"user":"Ted","user_id":56,"zipcode":[94507,94582]}');
Query OK, 5 rows affected (0.07 sec)
Records: 5  Duplicates: 0  Warnings: 0customers首先，我们对表
执行三个查询
，每个查询使用MEMBER OF()、
JSON_CONTAINS()和
JSON_OVERLAPS()，每个查询的结果如下所示：
mysql> SELECT * FROM customers
->     WHERE 94507 MEMBER OF(custinfo->'$.zipcode');
+----+---------------------+-------------------------------------------------------------------+
| id | modified            | custinfo                                                          |
+----+---------------------+-------------------------------------------------------------------+
|  2 | 2019-06-29 22:23:12 | {"user": "Jill", "user_id": 22, "zipcode": [94568, 94507, 94582]} |
|  3 | 2019-06-29 22:23:12 | {"user": "Bob", "user_id": 31, "zipcode": [94477, 94507]}         |
|  5 | 2019-06-29 22:23:12 | {"user": "Ted", "user_id": 56, "zipcode": [94507, 94582]}         |
+----+---------------------+-------------------------------------------------------------------+
3 rows in set (0.00 sec)
mysql> SELECT * FROM customers
->     WHERE JSON_CONTAINS(custinfo->'$.zipcode', CAST('[94507,94582]' AS JSON));
+----+---------------------+-------------------------------------------------------------------+
| id | modified            | custinfo                                                          |
+----+---------------------+-------------------------------------------------------------------+
|  2 | 2019-06-29 22:23:12 | {"user": "Jill", "user_id": 22, "zipcode": [94568, 94507, 94582]} |
|  5 | 2019-06-29 22:23:12 | {"user": "Ted", "user_id": 56, "zipcode": [94507, 94582]}         |
+----+---------------------+-------------------------------------------------------------------+
2 rows in set (0.00 sec)
mysql> SELECT * FROM customers
->     WHERE JSON_OVERLAPS(custinfo->'$.zipcode', CAST('[94507,94582]' AS JSON));
+----+---------------------+-------------------------------------------------------------------+
| id | modified            | custinfo                                                          |
+----+---------------------+-------------------------------------------------------------------+
|  1 | 2019-06-29 22:23:12 | {"user": "Jack", "user_id": 37, "zipcode": [94582, 94536]}        |
|  2 | 2019-06-29 22:23:12 | {"user": "Jill", "user_id": 22, "zipcode": [94568, 94507, 94582]} |
|  3 | 2019-06-29 22:23:12 | {"user": "Bob", "user_id": 31, "zipcode": [94477, 94507]}         |
|  5 | 2019-06-29 22:23:12 | {"user": "Ted", "user_id": 56, "zipcode": [94507, 94582]}         |
+----+---------------------+-------------------------------------------------------------------+
4 rows in set (0.00 sec)
接下来，我们运行EXPLAIN前三个查询中的每一个：
mysql> EXPLAIN SELECT * FROM customers
->     WHERE 94507 MEMBER OF(custinfo->'$.zipcode');
+----+-------------+-----------+------------+------+---------------+------+---------+------+------+----------+-------------+
| id | select_type | table     | partitions | type | possible_keys | key  | key_len | ref  | rows | filtered | Extra       |
+----+-------------+-----------+------------+------+---------------+------+---------+------+------+----------+-------------+
|  1 | SIMPLE      | customers | NULL       | ALL  | NULL          | NULL | NULL    | NULL |    5 |   100.00 | Using where |
+----+-------------+-----------+------------+------+---------------+------+---------+------+------+----------+-------------+
1 row in set, 1 warning (0.00 sec)
mysql> EXPLAIN SELECT * FROM customers
->     WHERE JSON_CONTAINS(custinfo->'$.zipcode', CAST('[94507,94582]' AS JSON));
+----+-------------+-----------+------------+------+---------------+------+---------+------+------+----------+-------------+
| id | select_type | table     | partitions | type | possible_keys | key  | key_len | ref  | rows | filtered | Extra       |
+----+-------------+-----------+------------+------+---------------+------+---------+------+------+----------+-------------+
|  1 | SIMPLE      | customers | NULL       | ALL  | NULL          | NULL | NULL    | NULL |    5 |   100.00 | Using where |
+----+-------------+-----------+------------+------+---------------+------+---------+------+------+----------+-------------+
1 row in set, 1 warning (0.00 sec)
mysql> EXPLAIN SELECT * FROM customers
->     WHERE JSON_OVERLAPS(custinfo->'$.zipcode', CAST('[94507,94582]' AS JSON));
+----+-------------+-----------+------------+------+---------------+------+---------+------+------+----------+-------------+
| id | select_type | table     | partitions | type | possible_keys | key  | key_len | ref  | rows | filtered | Extra       |
+----+-------------+-----------+------------+------+---------------+------+---------+------+------+----------+-------------+
|  1 | SIMPLE      | customers | NULL       | ALL  | NULL          | NULL | NULL    | NULL |    5 |   100.00 | Using where |
+----+-------------+-----------+------------+------+---------------+------+---------+------+------+----------+-------------+
1 row in set, 1 warning (0.01 sec)
刚刚显示的三个查询都不能使用任何键。
为了解决这个问题，我们可以在列（ ）中的zipcode数组上添加一个多值索引
，如下所示：
JSONcustinfomysql> ALTER TABLE customers
->     ADD INDEX zips( (CAST(custinfo->'$.zipcode' AS UNSIGNED ARRAY)) );
Query OK, 0 rows affected (0.47 sec)
Records: 0  Duplicates: 0  Warnings: 0
当我们再次运行前面的EXPLAIN语句时，我们现在可以观察到查询可以（并且确实）使用zips刚刚创建的索引：
mysql> EXPLAIN SELECT * FROM customers
->     WHERE 94507 MEMBER OF(custinfo->'$.zipcode');
+----+-------------+-----------+------------+------+---------------+------+---------+-------+------+----------+-------------+
| id | select_type | table     | partitions | type | possible_keys | key  | key_len | ref   | rows | filtered | Extra       |
+----+-------------+-----------+------------+------+---------------+------+---------+-------+------+----------+-------------+
|  1 | SIMPLE      | customers | NULL       | ref  | zips          | zips | 9       | const |    1 |   100.00 | Using where |
+----+-------------+-----------+------------+------+---------------+------+---------+-------+------+----------+-------------+
1 row in set, 1 warning (0.00 sec)
mysql> EXPLAIN SELECT * FROM customers
->     WHERE JSON_CONTAINS(custinfo->'$.zipcode', CAST('[94507,94582]' AS JSON));
+----+-------------+-----------+------------+-------+---------------+------+---------+------+------+----------+-------------+
| id | select_type | table     | partitions | type  | possible_keys | key  | key_len | ref  | rows | filtered | Extra       |
+----+-------------+-----------+------------+-------+---------------+------+---------+------+------+----------+-------------+
|  1 | SIMPLE      | customers | NULL       | range | zips          | zips | 9       | NULL |    6 |   100.00 | Using where |
+----+-------------+-----------+------------+-------+---------------+------+---------+------+------+----------+-------------+
1 row in set, 1 warning (0.00 sec)
mysql> EXPLAIN SELECT * FROM customers
->     WHERE JSON_OVERLAPS(custinfo->'$.zipcode', CAST('[94507,94582]' AS JSON));
+----+-------------+-----------+------------+-------+---------------+------+---------+------+------+----------+-------------+
| id | select_type | table     | partitions | type  | possible_keys | key  | key_len | ref  | rows | filtered | Extra       |
+----+-------------+-----------+------------+-------+---------------+------+---------+------+------+----------+-------------+
|  1 | SIMPLE      | customers | NULL       | range | zips          | zips | 9       | NULL |    6 |   100.00 | Using where |
+----+-------------+-----------+------------+-------+---------------+------+---------+------+------+----------+-------------+
1 row in set, 1 warning (0.01 sec)
多值索引可以定义为唯一键。如果定义为唯一键，则尝试插入多值索引中已存在的值会返回重复键错误。如果已经存在重复值，则尝试添加唯一的多值索引会失败，如下所示：
mysql> ALTER TABLE customers DROP INDEX zips;
Query OK, 0 rows affected (0.55 sec)
Records: 0  Duplicates: 0  Warnings: 0
mysql> ALTER TABLE customers
->     ADD UNIQUE INDEX zips((CAST(custinfo->'$.zipcode' AS UNSIGNED ARRAY)));
ERROR 1062 (23000): Duplicate entry '[94507, ' for key 'customers.zips'
mysql> ALTER TABLE customers
->     ADD INDEX zips((CAST(custinfo->'$.zipcode' AS UNSIGNED ARRAY)));
Query OK, 0 rows affected (0.36 sec)
Records: 0  Duplicates: 0  Warnings: 0
多值索引的特点
多值索引具有此处列出的其他特征：
影响多值索引的 DML 操作的处理方式与影响普通索引的 DML 操作的处理方式相同，唯一的区别是单个聚集索引记录可能有多个插入或更新。
可空性和多值索引：
如果多值键部分有一个空数组，则不会向索引添加任何条目，并且索引扫描无法访问数据记录。
如果多值键部分生成返回一个
NULL值，则将包含的单个条目
NULL添加到多值索引中。如果关键部分定义为NOT
NULL，则报错。
如果类型化数组列设置为
，则存储引擎存储包含指向数据记录
NULL的单个记录。NULL
JSON索引数组中不允许使用空值。如果任何返回值为
NULL，则将其视为 JSON null 并报告Invalid JSON value错误。
因为多值索引是虚拟列上的虚拟索引，所以它们必须遵守与虚拟生成列上的二级索引相同的规则。
不为空数组添加索引记录。
多值索引的限制和限制
多值索引受此处列出的限制和限制的约束：
每个多值索引只允许一个多值键部分。但是，CAST(... AS ...
ARRAY)表达式可以引用JSON文档中的多个数组，如下所示：
CAST(data->'$.arr[*][*]' AS UNSIGNED ARRAY)
在这种情况下，与 JSON 表达式匹配的所有值都作为单个平面数组存储在索引中。
具有多值键部分的索引不支持排序，因此不能用作主键。出于同样的原因，不能使用ASCorDESC
关键字来定义多值索引。
多值索引不能是覆盖索引。
多值索引的每条记录的最大值数取决于单个撤消日志页上可以存储的数据量，即 65221 字节（64K 减去 315 字节的开销），这意味着最大总数键值的长度也是 65221 字节。键的最大数量取决于各种因素，因此无法定义特定的限制。例如，测试显示多值索引允许每条记录有多达 1604 个整数键。达到限制时，将报告类似于以下内容的错误：ERROR 3905 (HY000): Exceeded max number of values per record for multi-valued index 'idx' by 1 value(s).
多值键部分中唯一允许的表达式类型是JSON
表达式。该表达式不需要引用插入到索引列中的 JSON 文档中的现有元素，但它本身必须在语法上有效。
由于同一聚集索引记录的索引记录分散在整个多值索引中，因此多值索引不支持范围扫描或仅索引扫描。
外键规范中不允许使用多值索引。
不能为多值索引定义索引前缀。
不能在 data cast as 上定义多值索引
BINARY（见CAST()函数说明）。
不支持在线创建多值索引，即操作使用
ALGORITHM=COPY. 请参阅
性能和空间要求。
多值索引不支持除以下两种字符集和排序规则组合之外的字符集和排序规则：
binary具有默认binary排序规则
的字符集utf8mb4具有默认utf8mb4_0900_as_cs排序规则
的字符集。
与
InnoDB表列上的其他索引一样，不能使用创建多值索引USING HASH；尝试这样做会导致警告：This storage engine does not support the HASH index algorithm, storage engine default was used instead。（USING BTREE照常支持。）
空间索引
、MyISAM、
和
存储引擎支持空间列InnoDB，
例如和
。（第 11.4 节，“空间数据类型”，描述了空间数据类型。）但是，对空间列索引的支持因引擎而异。空间列上的空间和非空间索引可根据以下规则使用。
NDBARCHIVEPOINTGEOMETRY
空间列上的空间索引具有以下特征：
仅适用于InnoDB和
MyISAM表。为其他存储引擎指定
SPATIAL INDEX会导致错误。
从 MySQL 8.0.12 开始，空间列
上的索引必须是SPATIAL
索引。因此，该SPATIAL关键字是可选的，但对于在空间列上创建索引是隐含的。
仅适用于单个空间列。不能在多个空间列上创建空间索引。
索引列必须是NOT NULL.
列前缀长度是被禁止的。每列的全宽都被索引。
主键或唯一索引不允许。
空间列上的非空间索引（使用 、 或 创建
INDEX）UNIQUE具有
PRIMARY KEY以下特征：
允许用于支持空间列的任何存储引擎，但ARCHIVE.
NULL除非索引是主键，否则
列可以。
非SPATIAL索引的索引类型取决于存储引擎。目前使用的是B-tree。
允许只对、
和
表
具有NULL
值的列。InnoDBMyISAMMEMORY
指数期权
在关键部分列表之后，可以给出索引选项。index_option值可以是以下任何一项
：
KEY_BLOCK_SIZE [=]
value
对于MyISAM表，
KEY_BLOCK_SIZE可选择指定用于索引键块的大小（以字节为单位）。该值被视为提示；如有必要，可以使用不同的尺寸。为单个索引定义指定的KEY_BLOCK_SIZE值会覆盖表级KEY_BLOCK_SIZE值。
KEY_BLOCK_SIZE在表的索引级别不支持InnoDB。请参阅第 13.1.20 节，“CREATE TABLE 语句”。
index_type
一些存储引擎允许您在创建索引时指定索引类型。例如：
CREATE TABLE lookup (id INT) ENGINE = MEMORY;
CREATE INDEX id_index ON lookup (id) USING BTREE;
表 13.1 “每个存储引擎的索引类型”
显示了不同存储引擎支持的允许索引类型值。在列出多个索引类型的情况下，如果没有给出索引类型说明符，则第一个是默认值。表中未列出的存储引擎不支持index_type
索引定义中的子句。
表 13.1 每个存储引擎的索引类型
存储引擎
允许的索引类型
InnoDB
BTREE
MyISAM
BTREE
MEMORY/HEAP
HASH,BTREE
NDB
HASH, BTREE(见正文注释)
该index_type子句不能用于FULLTEXT INDEXor （在 MySQL 8.0.12 之前）SPATIAL INDEX
规范。全文索引的实现依赖于存储引擎。空间索引作为 R 树索引实现。
如果您指定的索引类型对给定的存储引擎无效，但引擎可以使用另一种索引类型而不影响查询结果，则该引擎将使用可用的类型。解析器将其识别
RTREE为类型名称。从 MySQL 8.0.12 开始，这只允许用于SPATIAL
索引。在 8.0.12 之前，RTREE不能为任何存储引擎指定。
BTREE索引由
NDB存储引擎实现为 T 树索引。
笔记
对于NDB表列上的索引，USING只能为唯一索引或主键指定该选项。
USING HASH防止创建有序索引；否则，在表上创建唯一索引或主键NDB会自动导致创建有序索引和散列索引，每个索引都索引相同的列集。
对于包含表的一个或多个
NULL列的
唯一索引，NDB哈希索引只能用于查找文字值，这意味着
IS [NOT] NULL条件需要对表进行全扫描。一种解决方法是确保NULL
在此类表上使用一个或多个列的唯一索引始终以包含有序索引的方式创建；即USING HASH在创建索引时避免使用。
如果您指定的索引类型对给定的存储引擎无效，但引擎可以使用另一种索引类型而不影响查询结果，则该引擎将使用可用的类型。解析器识别
RTREE为类型名称，但目前无法为任何存储引擎指定。
笔记
在弃用子句之前
使用index_type选项；期望在未来的 MySQL 版本中删除在这个位置使用该选项的支持。如果
在前面和后面的位置都给出了一个选项，则应用最后一个选项。
ON
tbl_nameindex_type
TYPE type_name
被认为是 的同义词。但是，
是首选形式。
USING
type_nameUSING
下表显示了支持该
index_type选项的存储引擎的索引特征。
表 13.2 InnoDB 存储引擎索引特征
索引类
索引类型
存储空值
允许多个 NULL 值
IS NULL 扫描类型
IS NOT NULL 扫描类型
首要的关键
BTREE
不
不
不适用
不适用
独特的
BTREE
是的
是的
指数
指数
钥匙
BTREE
是的
是的
指数
指数
FULLTEXT
不适用
是的
是的
桌子
桌子
SPATIAL
不适用
不
不
不适用
不适用
表 13.3 MyISAM 存储引擎索引特征
索引类
索引类型
存储空值
允许多个 NULL 值
IS NULL 扫描类型
IS NOT NULL 扫描类型
首要的关键
BTREE
不
不
不适用
不适用
独特的
BTREE
是的
是的
指数
指数
钥匙
BTREE
是的
是的
指数
指数
FULLTEXT
不适用
是的
是的
桌子
桌子
SPATIAL
不适用
不
不
不适用
不适用
表 13.4 MEMORY 存储引擎索引特征
索引类
索引类型
存储空值
允许多个 NULL 值
IS NULL 扫描类型
IS NOT NULL 扫描类型
首要的关键
BTREE
不
不
不适用
不适用
独特的
BTREE
是的
是的
指数
指数
钥匙
BTREE
是的
是的
指数
指数
首要的关键
HASH
不
不
不适用
不适用
独特的
HASH
是的
是的
指数
指数
钥匙
HASH
是的
是的
指数
指数
表 13.5 NDB 存储引擎索引特征
索引类
索引类型
存储空值
允许多个 NULL 值
IS NULL 扫描类型
IS NOT NULL 扫描类型
首要的关键
BTREE
不
不
指数
指数
独特的
BTREE
是的
是的
指数
指数
钥匙
BTREE
是的
是的
指数
指数
首要的关键
HASH
不
不
表（见注1）
表（见注1）
独特的
HASH
是的
是的
表（见注1）
表（见注1）
钥匙
HASH
是的
是的
表（见注1）
表（见注1）
表注：
1.USING HASH防止创建隐式有序索引。
WITH PARSER
parser_name
此选项只能与
FULLTEXT索引一起使用。如果全文索引和搜索操作需要特殊处理，它会将解析器插件与索引相关联。
InnoDB并
MyISAM支持全文解析器插件。如果您有一个MyISAM
带有关联的全文解析器插件的表，您可以将该表转换为InnoDB使用
ALTER TABLE. 有关详细信息，请参阅
全文解析器插件和
编写全文解析器插件。
COMMENT
'string'
索引定义可以包括最多 1024 个字符的可选注释。
可以使用语句的
子句
MERGE_THRESHOLD
为各个索引配置 for 索引页。例如：
index_option
COMMENTCREATE INDEXCREATE TABLE t1 (id INT);
CREATE INDEX id_index ON t1 (id) COMMENT 'MERGE_THRESHOLD=40';MERGE_THRESHOLD如果在删除行或通过更新操作缩短行时
索引页的页满百分比低于该值，则InnoDB尝试将索引页与相邻索引页合并。默认
MERGE_THRESHOLD值为 50，这是以前硬编码的值。
MERGE_THRESHOLD也可以使用
CREATE TABLEand
ALTER TABLE语句在索引级别和表级别定义。有关详细信息，请参阅
第 15.8.11 节，“为索引页配置合并阈值”。
VISIBLE,INVISIBLE
指定索引可见性。默认情况下索引是可见的。优化器不使用不可见索引。索引可见性规范适用于主键以外的索引（显式或隐式）。有关详细信息，请参阅第 8.3.12 节，“不可见索引”。
ENGINE_ATTRIBUTE和
SECONDARY_ENGINE_ATTRIBUTE选项（自 MySQL 8.0.21 起可用）用于指定主存储引擎和辅助存储引擎的索引属性。这些选项保留供将来使用。
允许的值是包含有效
JSON文档或空字符串 ('') 的字符串文字。无效JSON被拒绝。
CREATE INDEX i1 ON t1 (c1) ENGINE_ATTRIBUTE='{"key":"value"}';
ENGINE_ATTRIBUTE并且
SECONDARY_ENGINE_ATTRIBUTE值可以无误地重复。在这种情况下，使用最后指定的值。
ENGINE_ATTRIBUTE和
SECONDARY_ENGINE_ATTRIBUTE值不会被服务器检查，也不会在表的存储引擎更改时被清除。
表格复制和锁定选项
ALGORITHMLOCK可以给出和子句来影响表的复制方法和在修改表的索引时读取和写入表的并发级别。它们的含义与
ALTER TABLE语句相同。有关详细信息，请参阅第 13.1.9 节，“ALTER TABLE 语句”
ALGORITHM=INPLACENDB Cluster使用与标准 MySQL 服务器
相同的语法支持在线操作
。有关更多信息，请参阅
第 23.6.11 节，“在 NDB Cluster 中使用 ALTER TABLE 进行在线操作”。
© Mysql 中文网
