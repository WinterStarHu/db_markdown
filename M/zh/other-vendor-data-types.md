# 11.9 使用来自其他数据库引擎的数据类型_MySQL 8.0 参考手册

11.9 使用来自其他数据库引擎的数据类型_MySQL 8.0 参考手册
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
11.1 数值数据类型
11.2 日期和时间数据类型
11.3 字符串数据类型
11.4 空间数据类型
11.5 JSON数据类型
11.6 数据类型默认值
11.7 数据类型存储要求
11.8 为列选择正确的类型
11.9 使用来自其他数据库引擎的数据类型
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
MySQL 8.0 参考手册  / 第 11 章数据类型  /
11.9 使用来自其他数据库引擎的数据类型
11.9 使用来自其他数据库引擎的数据类型
为了便于使用为其他供应商的 SQL 实现编写的代码，MySQL 映射数据类型，如下表所示。这些映射使得将表定义从其他数据库系统导入 MySQL 变得更加容易。
其他供应商类型
MySQL类型
BOOL
TINYINT
BOOLEAN
TINYINT
CHARACTER VARYING(M)
VARCHAR(M)
FIXED
DECIMAL
FLOAT4
FLOAT
FLOAT8
DOUBLE
INT1
TINYINT
INT2
SMALLINT
INT3
MEDIUMINT
INT4
INT
INT8
BIGINT
LONG VARBINARY
MEDIUMBLOB
LONG VARCHAR
MEDIUMTEXT
LONG
MEDIUMTEXT
MIDDLEINT
MEDIUMINT
NUMERIC
DECIMAL
数据类型映射发生在表创建时，之后原始类型规范将被丢弃。如果您使用其他供应商使用的类型创建表，然后发出
语句，MySQL 会使用等效的 MySQL 类型报告表结构。例如：
DESCRIBE tbl_namemysql> CREATE TABLE t (a BOOL, b FLOAT8, c LONG VARCHAR, d NUMERIC);
Query OK, 0 rows affected (0.00 sec)
mysql> DESCRIBE t;
+-------+---------------+------+-----+---------+-------+
| Field | Type          | Null | Key | Default | Extra |
+-------+---------------+------+-----+---------+-------+
| a     | tinyint(1)    | YES  |     | NULL    |       |
| b     | double        | YES  |     | NULL    |       |
| c     | mediumtext    | YES  |     | NULL    |       |
| d     | decimal(10,0) | YES  |     | NULL    |       |
+-------+---------------+------+-----+---------+-------+
4 rows in set (0.01 sec)
© Mysql 中文网
