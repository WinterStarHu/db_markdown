# 24.4 分区修剪_MySQL 8.0 参考手册

24.4 分区修剪_MySQL 8.0 参考手册
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
24.1 MySQL分区概述
24.2 分区类型
24.3 分区管理
24.4 分区修剪
24.5 分区选择
24.6 分区的约束和限制
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
MySQL 8.0 参考手册  / 第24章分区  /
24.4 分区修剪
24.4 分区修剪
称为分区修剪的优化基于一个相对简单的概念，可以描述为“不扫描没有匹配值的分区”。假设一个分区表
t1是由这个语句创建的：
CREATE TABLE t1 (
fname VARCHAR(50) NOT NULL,
lname VARCHAR(50) NOT NULL,
region_code TINYINT UNSIGNED NOT NULL,
dob DATE NOT NULL
)
PARTITION BY RANGE( region_code ) (
PARTITION p0 VALUES LESS THAN (64),
PARTITION p1 VALUES LESS THAN (128),
PARTITION p2 VALUES LESS THAN (192),
PARTITION p3 VALUES LESS THAN MAXVALUE
);
假设您希望从
SELECT如下语句中获取结果：
SELECT fname, lname, region_code, dob
FROM t1
WHERE region_code > 125 AND region_code < 130;
很容易看出，应该返回的行都不在分区p0或
p3; 也就是说，我们只需要在分区中搜索
p1并p2找到匹配的行。通过限制搜索，与扫描表中的所有分区相比，可以花费更少的时间和精力来查找匹配行。这种“切掉”不需要的分区称为
修剪。当优化器可以在执行此查询时使用分区修剪时，查询的执行速度可能比针对包含相同列定义和数据的非分区表的相同查询快一个数量级。
WHERE只要条件可以减少为以下两种情况之一，
优化器就可以执行修剪
：
partition_column =
constant
partition_column IN
(constant1,
constant2, ...,
constantN)
在第一种情况下，优化器简单地计算给定值的分区表达式，确定哪个分区包含该值，并仅扫描该分区。在许多情况下，等号可以替换为另一种算术比较，包括<、>、
<=、>=和
<>。BETWEEN在子句中使用的一些查询
WHERE也可以利用分区修剪。请参阅本节后面的示例。
在第二种情况下，优化器为列表中的每个值计算分区表达式，创建一个匹配分区列表，然后只扫描这个分区列表中的分区。
SELECT,
DELETE, 和
UPDATE语句支持分区修剪。一条INSERT语句也只访问每个插入行的一个分区；HASH即使对于由or
分区的表也是如此，KEY尽管这目前没有显示在EXPLAIN.
修剪也可以应用于短范围，优化器可以将其转换为等效的值列表。例如，在前面的示例中，WHERE子句可以转换为WHERE region_code IN (126, 127, 128,
129). 然后优化器可以确定列表中的前两个值在 partition 中找到
p1，其余两个值在 partition
p2中，并且其他分区不包含相关值，因此不需要搜索匹配行。
对于使用或分区
WHERE的表，优化器还可以针对涉及在多列上进行上述类型比较的条件
进行剪枝
。RANGE COLUMNSLIST
COLUMNS
只要分区表达式包含一个等式或可以归约为一组等式的范围，或者当分区表达式表示递增或递减关系时，就可以应用这种类型的优化。当分区表达式使用
or
函数时，修剪也可以应用于在
DATEor
列上分区的表。当分区表达式使用该函数
时，也可以对此类表应用修剪。DATETIMEYEAR()TO_DAYS()TO_SECONDS()
假设按列t2分区的
表DATE是使用此处显示的语句创建的：
CREATE TABLE t2 (
fname VARCHAR(50) NOT NULL,
lname VARCHAR(50) NOT NULL,
region_code TINYINT UNSIGNED NOT NULL,
dob DATE NOT NULL
)
PARTITION BY RANGE( YEAR(dob) ) (
PARTITION d0 VALUES LESS THAN (1970),
PARTITION d1 VALUES LESS THAN (1975),
PARTITION d2 VALUES LESS THAN (1980),
PARTITION d3 VALUES LESS THAN (1985),
PARTITION d4 VALUES LESS THAN (1990),
PARTITION d5 VALUES LESS THAN (2000),
PARTITION d6 VALUES LESS THAN (2005),
PARTITION d7 VALUES LESS THAN MAXVALUE
);
使用以下语句t2可以使用分区修剪：
SELECT * FROM t2 WHERE dob = '1982-06-23';
UPDATE t2 SET region_code = 8 WHERE dob BETWEEN '1991-02-15' AND '1997-04-25';
DELETE FROM t2 WHERE dob >= '1984-06-21' AND dob <= '1999-06-21'
在最后一条语句的情况下，优化器还可以执行以下操作：
查找包含范围低端的分区。
YEAR('1984-06-21')产生1984在分区中找到
的值d3。
查找包含范围高端的分区。
YEAR('1999-06-21')评估为
1999，它在分区中找到
d5。
只扫描这两个分区和它们之间的任何分区。
在这种情况下，这意味着只
扫描分区d3、d4和
。d5其余分区可以安全地忽略（并被忽略）。
重要的
在针对分区表的语句的条件中引用的无效DATE和DATETIME
值WHERE被视为
NULL. 这意味着诸如 之类的查询
不会返回任何值（请参阅错误 #40972）。
SELECT * FROM
partitioned_table WHERE
date_column <
'2008-12-00'
到目前为止，我们只查看了使用
RANGE分区的示例，但剪枝也可以应用于其他分区类型。
考虑一个按 分区的表LIST，其中分区表达式递增或递减，例如t3此处显示的表。（在此示例中，为简洁起见，我们假设该
region_code列的值限制在 1 到 10 之间（含 1 和 10）。）
CREATE TABLE t3 (
fname VARCHAR(50) NOT NULL,
lname VARCHAR(50) NOT NULL,
region_code TINYINT UNSIGNED NOT NULL,
dob DATE NOT NULL
)
PARTITION BY LIST(region_code) (
PARTITION r0 VALUES IN (1, 3),
PARTITION r1 VALUES IN (2, 5, 8),
PARTITION r2 VALUES IN (4, 9),
PARTITION r3 VALUES IN (6, 7, 10)
);
对于诸如SELECT * FROM t3 WHERE
region_code BETWEEN 1 AND 3之类的语句，优化器确定在哪些分区中找到值 1、2 和 3（r0和r1）并跳过其余的（r2和r3）。
对于按HASHor
分区的表，在子句对分区表达式中使用的列使用简单关系[LINEAR] KEY的情况下，也可以进行分区修剪。考虑这样创建的表：
WHERE=CREATE TABLE t4 (
fname VARCHAR(50) NOT NULL,
lname VARCHAR(50) NOT NULL,
region_code TINYINT UNSIGNED NOT NULL,
dob DATE NOT NULL
)
PARTITION BY KEY(region_code)
PARTITIONS 8;
可以修剪将列值与常量进行比较的语句：
UPDATE t4 WHERE region_code = 7;
修剪也可以用于短距离，因为优化器可以将这些条件转化为IN
关系。例如，使用与t4
之前定义的相同的表，可以修剪诸如此类的查询：
SELECT * FROM t4 WHERE region_code > 2 AND region_code < 6;
SELECT * FROM t4 WHERE region_code BETWEEN 3 AND 5;
在这两种情况下，WHERE优化器都会将子句转换为WHERE region_code IN
(3, 4, 5).
重要的
仅当范围大小小于分区数时才使用此优化。考虑这个声明：
DELETE FROM t4 WHERE region_code BETWEEN 4 AND 12;
子句中的范围WHERE涵盖 9 个值（4、5、6、7、8、9、10、11、12），但t4只有 8 个分区。这意味着DELETE
不能修剪。
当表按HASHor
分区时[LINEAR] KEY，修剪只能用于整数列。例如，此语句不能使用修剪，因为dob它是一
DATE列：
SELECT * FROM t4 WHERE dob >= '2001-04-14' AND dob <= '2005-10-15';
但是，如果表在列中存储年份值
，则可以修剪
INT具有的查询
。WHERE year_col >= 2001 AND year_col <=
2005
使用提供自动分区的存储引擎的表，例如NDBMySQL Cluster 使用的存储引擎，如果它们被显式分区，则可以被修剪。
© Mysql 中文网
