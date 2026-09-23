# 9.2.2 标识符限定符_MySQL 8.0 参考手册

9.2.2 标识符限定符_MySQL 8.0 参考手册
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
9.1 文字值
9.2 模式对象名称
9.2.1 标识符长度限制1
9.2.2 标识符限定符1
9.2.3 标识符区分大小写1
9.2.4 标识符到文件名的映射1
9.2.5 函数名解析解析1
9.3 关键字和保留字
9.4 用户自定义变量
9.5 表达式
9.6 查询属性
9.7 评论
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
MySQL 8.0 参考手册  / 第9章语言结构  / 9.2 模式对象名称  /
9.2.2 标识符限定符
9.2.2 标识符限定符
对象名称可能是不合格的或合格的。在名称解释明确的上下文中允许使用非限定名称。限定名称至少包含一个限定符，用于通过覆盖默认上下文或提供缺失的上下文来阐明解释性上下文。
例如，此语句使用非限定名称创建一个表t1：
CREATE TABLE t1 (i INT);
因为t1不包含指定数据库的限定符，所以语句在默认数据库中创建表。如果没有默认数据库，则会发生错误。
此语句使用限定名称创建一个表
db1.t1：
CREATE TABLE db1.t1 (i INT);
因为db1.t1包含数据库限定符
db1，所以该语句
t1在名为的数据库
中创建db1，而不考虑默认数据库。如果没有默认数据库，则必须指定限定符。如果存在默认数据库，则可以指定限定符以指定与默认不同的数据库，或者如果默认与指定的数据库相同则使数据库显
式。
限定符具有以下特征：
非限定名称由单个标识符组成。限定名称由多个标识符组成。
多部分名称的组成部分必须用句点 ( .) 字符分隔。多部分名称的初始部分充当限定符，影响解释最终标识符的上下文。
限定符字符是一个单独的标记，不需要与关联的标识符相邻。例如，
tbl_name.col_name和
tbl_name . col_name是等价的。
如果多部分名称的任何组成部分需要引用，请单独引用它们而不是引用整个名称。例如，写
`my-table`.`my-column`，而不是
`my-table.my-column`。
限定名称中句点后的保留字必须是标识符，因此在该上下文中不需要引用它。
对象名称允许的限定符取决于对象类型：
数据库名称是完全限定的，不带限定符：
CREATE DATABASE db1;
可以为表、视图或存储的程序名称提供数据库名称限定符。CREATE语句
中非限定名称和限定名称的示例：CREATE TABLE mytable ...;
CREATE VIEW myview ...;
CREATE PROCEDURE myproc ...;
CREATE FUNCTION myfunc ...;
CREATE EVENT myevent ...;
CREATE TABLE mydb.mytable ...;
CREATE VIEW mydb.myview ...;
CREATE PROCEDURE mydb.myproc ...;
CREATE FUNCTION mydb.myfunc ...;
CREATE EVENT mydb.myevent ...;
触发器与表相关联，因此任何限定符都适用于表名：
CREATE TRIGGER mytrigger ... ON mytable ...;
CREATE TRIGGER mytrigger ... ON mydb.mytable ...;
可以为列名指定多个限定符以指示引用它的语句中的上下文，如下表所示。
列参考
意义
col_name
语句中使用的任何表中的列col_name包含该名称的列
tbl_name.col_name
默认数据库col_name表
中的列tbl_name
db_name.tbl_name.col_name
来自数据库
col_name表
的列tbl_namedb_name
换句话说，一个列名可以被赋予一个表名限定符，它本身可以被赋予一个数据库名限定符。SELECT语句
中非限定和限定列引用的示例：SELECT c1 FROM mytable
WHERE c2 > 100;
SELECT mytable.c1 FROM mytable
WHERE mytable.c2 > 100;
SELECT mydb.mytable.c1 FROM mydb.mytable
WHERE mydb.mytable.c2 > 100;
您不需要在语句中为对象引用指定限定符，除非非限定引用不明确。假设该列c1仅出现在 table 中
t1，c2仅出现在
t2, 并且c同时出现在
t1和中t2。任何非限定引用c在引用两个表的语句中都是不明确的，必须限定为
t1.c或t2.c指示您指的是哪个表：
SELECT c1, c2, t1.c FROM t1 INNER JOIN t2
WHERE t2.c > 100;
类似地，要在同一语句中从数据库中的表和数据库中的表
t中检索，必须限定表引用：对于对这些表中的列的引用，仅对同时出现在两个表中的列名需要限定符。假设该列仅出现在 table 中
，仅出现在
, 并且同时出现在
和中。在这种情况下，是不明确的，必须是合格的，但不一定是：
db1tdb2c1db1.tc2db2.tcdb1.tdb2.tcc1c2SELECT c1, c2, db1.t.c FROM db1.t INNER JOIN db2.t
WHERE db2.t.c > 100;
表别名使限定的列引用可以更简单地编写：
SELECT c1, c2, t1.c FROM db1.t AS t1 INNER JOIN db2.t AS t2
WHERE t2.c > 100;
© Mysql 中文网
