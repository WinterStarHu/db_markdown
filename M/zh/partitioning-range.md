# 24.2.1 范围分区_MySQL 8.0 参考手册

24.2.1 范围分区_MySQL 8.0 参考手册
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
24.2.1 范围分区1
24.2.2 列表分区1
24.2.3 列分区1
24.2.4 哈希分区1
24.2.5 KEY分区1
24.2.6 子分区1
24.2.7 MySQL分区如何处理NULL1
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
MySQL 8.0 参考手册  / 第24章分区  / 24.2 分区类型  /
24.2.1 范围分区
24.2.1 范围分区
按范围分区的表的分区方式是，每个分区都包含分区表达式值位于给定范围内的行。范围应连续但不重叠，并使用
VALUES LESS THAN运算符定义。对于接下来的几个示例，假设您正在创建一个如下表来保存 20 家音像连锁店的人员记录，编号为 1 到 20：
CREATE TABLE employees (
id INT NOT NULL,
fname VARCHAR(30),
lname VARCHAR(30),
hired DATE NOT NULL DEFAULT '1970-01-01',
separated DATE NOT NULL DEFAULT '9999-12-31',
job_code INT NOT NULL,
store_id INT NOT NULL
);
笔记
此处使用的employees表没有主键或唯一键。虽然示例按照当前讨论的目的进行工作，但您应该记住，表在实践中极有可能具有主键、唯一键或两者，并且分区列的允许选择取决于用于这些的列钥匙，如果有的话。有关这些问题的讨论，请参阅
第 24.6.1 节，“分区键、主键和唯一键”。
根据您的需要，可以通过多种方式按范围对该表进行分区。一种方法是使用
store_id列。例如，您可能决定通过添加
PARTITION BY RANGE如下所示的子句来以 4 种方式对表进行分区：
CREATE TABLE employees (
id INT NOT NULL,
fname VARCHAR(30),
lname VARCHAR(30),
hired DATE NOT NULL DEFAULT '1970-01-01',
separated DATE NOT NULL DEFAULT '9999-12-31',
job_code INT NOT NULL,
store_id INT NOT NULL
)
PARTITION BY RANGE (store_id) (
PARTITION p0 VALUES LESS THAN (6),
PARTITION p1 VALUES LESS THAN (11),
PARTITION p2 VALUES LESS THAN (16),
PARTITION p3 VALUES LESS THAN (21)
);
在此分区方案中，与在商店 1 到 5 工作的员工对应的所有行都存储在 partition
p0中，在商店 6 到 10 工作的员工都存储在 partitionp1中，依此类推。每个分区按从低到高的顺序定义。这是PARTITION BY RANGE语法的要求；在这方面，您可以将其视为类似于 C 或 Java 中的一系列
if ... elseif ...语句。
很容易确定包含数据的新行
(72, 'Mitchell', 'Wilson', '1998-06-25', NULL,
13)已插入到分区p2中，但是当您的连锁店添加第 21家商店时会发生什么？在这种方案下，没有规则覆盖store_id
大于20的行，所以会出现错误，因为服务器不知道放在哪里。您可以通过在语句中使用“ catchall ” VALUES LESS
THAN子句来防止这种情况发生，该子句CREATE
TABLE提供大于明确命名的最高值的所有值：
CREATE TABLE employees (
id INT NOT NULL,
fname VARCHAR(30),
lname VARCHAR(30),
hired DATE NOT NULL DEFAULT '1970-01-01',
separated DATE NOT NULL DEFAULT '9999-12-31',
job_code INT NOT NULL,
store_id INT NOT NULL
)
PARTITION BY RANGE (store_id) (
PARTITION p0 VALUES LESS THAN (6),
PARTITION p1 VALUES LESS THAN (11),
PARTITION p2 VALUES LESS THAN (16),
PARTITION p3 VALUES LESS THAN MAXVALUE
);
（与本章中的其他示例一样，我们假设默认存储引擎是InnoDB.）
笔记
在找不到匹配值时避免错误的另一种方法是使用IGNORE关键字作为
INSERT语句的一部分。有关示例，请参阅第 24.2.2 节，“LIST 分区”。另请参阅
第 13.2.6 节，“INSERT 语句”，了解有关
IGNORE.
MAXVALUE表示始终大于最大可能整数值的整数值（在数学语言中，它用作
最小上限）。现在，store_id列值大于或等于 16（定义的最大值）的任何行都存储在 partition 中p3。在未来的某个时刻——当商店数量增加到 25、30 或更多时——你可以使用一条
ALTER
TABLE语句为商店 21-25、26-30 等添加新分区（参见
第 24.3 节，“分区管理”，了解如何执行此操作的详细信息）。
以几乎相同的方式，您可以根据员工职务代码（即，根据
job_code列值的范围）对表进行分区。例如——假设两位数的职位代码用于普通（店内）员工，三位数的代码用于办公室和支持人员，四位数的代码用于管理职位——您可以创建分区表使用以下语句：
CREATE TABLE employees (
id INT NOT NULL,
fname VARCHAR(30),
lname VARCHAR(30),
hired DATE NOT NULL DEFAULT '1970-01-01',
separated DATE NOT NULL DEFAULT '9999-12-31',
job_code INT NOT NULL,
store_id INT NOT NULL
)
PARTITION BY RANGE (job_code) (
PARTITION p0 VALUES LESS THAN (100),
PARTITION p1 VALUES LESS THAN (1000),
PARTITION p2 VALUES LESS THAN (10000)
);
在这种情况下，所有与店内员工相关的行都将存储在分区中p0，与办公室和支持人员相关的行存储在分区中p1，与经理相关的行存储在分区中p2。
也可以在VALUES LESS
THAN子句中使用表达式。但是，MySQL 必须能够将表达式的返回值作为LESS
THAN( <) 比较的一部分进行评估。
您可以使用基于两
DATE列之一的表达式，而不是根据商店编号拆分表数据。例如，假设您希望根据每位员工离开公司的年份进行分区；即 的值
YEAR(separated)。CREATE TABLE此处显示了实现此类分区方案的语句
示例
：CREATE TABLE employees (
id INT NOT NULL,
fname VARCHAR(30),
lname VARCHAR(30),
hired DATE NOT NULL DEFAULT '1970-01-01',
separated DATE NOT NULL DEFAULT '9999-12-31',
job_code INT,
store_id INT
)
PARTITION BY RANGE ( YEAR(separated) ) (
PARTITION p0 VALUES LESS THAN (1991),
PARTITION p1 VALUES LESS THAN (1996),
PARTITION p2 VALUES LESS THAN (2001),
PARTITION p3 VALUES LESS THAN MAXVALUE
);
在此方案中，对于所有在 1991 年之前离职的员工，行存储在分区中p0；对于那些在 1991 年至 1995 年期间离开的人，在p1; 对于那些在 1996 年到 2000 年间离开的人，在
p2; 对于 2000 年后离开的任何工人，在p3.
也可以
使用函数根据列
RANGE的值按 对
表进行分区，如本例所示：
TIMESTAMPUNIX_TIMESTAMP()CREATE TABLE quarterly_report_status (
report_id INT NOT NULL,
report_status VARCHAR(20) NOT NULL,
report_updated TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
)
PARTITION BY RANGE ( UNIX_TIMESTAMP(report_updated) ) (
PARTITION p0 VALUES LESS THAN ( UNIX_TIMESTAMP('2008-01-01 00:00:00') ),
PARTITION p1 VALUES LESS THAN ( UNIX_TIMESTAMP('2008-04-01 00:00:00') ),
PARTITION p2 VALUES LESS THAN ( UNIX_TIMESTAMP('2008-07-01 00:00:00') ),
PARTITION p3 VALUES LESS THAN ( UNIX_TIMESTAMP('2008-10-01 00:00:00') ),
PARTITION p4 VALUES LESS THAN ( UNIX_TIMESTAMP('2009-01-01 00:00:00') ),
PARTITION p5 VALUES LESS THAN ( UNIX_TIMESTAMP('2009-04-01 00:00:00') ),
PARTITION p6 VALUES LESS THAN ( UNIX_TIMESTAMP('2009-07-01 00:00:00') ),
PARTITION p7 VALUES LESS THAN ( UNIX_TIMESTAMP('2009-10-01 00:00:00') ),
PARTITION p8 VALUES LESS THAN ( UNIX_TIMESTAMP('2010-01-01 00:00:00') ),
PARTITION p9 VALUES LESS THAN (MAXVALUE)
);TIMESTAMP不允许
任何其他涉及值的表达式
。（参见缺陷 #42849。）
当满足以下一个或多个条件时，范围分区特别有用：
您想要或需要删除“旧”数据。如果您正在为该
employees表使用之前显示的分区方案，您可以简单地使用
ALTER TABLE employees DROP PARTITION p0;
删除与 1991 年之前停止为公司工作的员工相关的所有行。（参见
第 13.1.9 节，“ALTER TABLE 语句”和
第 24.3 节, “分区管理”，了解更多信息。）对于具有大量行的表，这比运行
DELETE诸如
DELETE FROM employees WHERE YEAR(separated) <=
1990;.
您想要使用包含日期或时间值的列，或者包含来自其他一些系列的值的列。
您经常运行直接依赖于用于对表进行分区的列的查询。例如，当执行诸如 之类的查询时
EXPLAIN SELECT
COUNT(*) FROM employees WHERE separated BETWEEN '2000-01-01'
AND '2000-12-31' GROUP BY store_id;，MySQL 可以快速确定只p2
需要扫描分区，因为其余分区不能包含任何满足该WHERE
子句的记录。有关如何完成此操作的更多信息，
请参阅第 24.4 节，“分区修剪” 。
这种类型的分区的一个变体是RANGE
COLUMNS分区。分区依据RANGE
COLUMNS可以使用多个列来定义分区范围，分区范围既适用于行在分区中的放置，也适用于在执行分区修剪时确定包含或排除特定分区。有关详细信息，请参阅第 24.2.3.1 节，“RANGE COLUMNS 分区”。
基于时间间隔的分区方案。
如果你希望在 MySQL 8.0 中实现基于范围或时间间隔的分区方案，你有两个选择：
按 对表进行RANGE分区，对于分区表达式，使用对 、 或 列进行操作
DATE并
TIME返回
DATETIME整数值的函数，如下所示：
CREATE TABLE members (
firstname VARCHAR(25) NOT NULL,
lastname VARCHAR(25) NOT NULL,
username VARCHAR(16) NOT NULL,
email VARCHAR(35),
joined DATE NOT NULL
)
PARTITION BY RANGE( YEAR(joined) ) (
PARTITION p0 VALUES LESS THAN (1960),
PARTITION p1 VALUES LESS THAN (1970),
PARTITION p2 VALUES LESS THAN (1980),
PARTITION p3 VALUES LESS THAN (1990),
PARTITION p4 VALUES LESS THAN MAXVALUE
);
在 MySQL 8.0 中，还可以使用函数根据列
RANGE的值对
表进行分区，如本例所示：
TIMESTAMPUNIX_TIMESTAMP()CREATE TABLE quarterly_report_status (
report_id INT NOT NULL,
report_status VARCHAR(20) NOT NULL,
report_updated TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
)
PARTITION BY RANGE ( UNIX_TIMESTAMP(report_updated) ) (
PARTITION p0 VALUES LESS THAN ( UNIX_TIMESTAMP('2008-01-01 00:00:00') ),
PARTITION p1 VALUES LESS THAN ( UNIX_TIMESTAMP('2008-04-01 00:00:00') ),
PARTITION p2 VALUES LESS THAN ( UNIX_TIMESTAMP('2008-07-01 00:00:00') ),
PARTITION p3 VALUES LESS THAN ( UNIX_TIMESTAMP('2008-10-01 00:00:00') ),
PARTITION p4 VALUES LESS THAN ( UNIX_TIMESTAMP('2009-01-01 00:00:00') ),
PARTITION p5 VALUES LESS THAN ( UNIX_TIMESTAMP('2009-04-01 00:00:00') ),
PARTITION p6 VALUES LESS THAN ( UNIX_TIMESTAMP('2009-07-01 00:00:00') ),
PARTITION p7 VALUES LESS THAN ( UNIX_TIMESTAMP('2009-10-01 00:00:00') ),
PARTITION p8 VALUES LESS THAN ( UNIX_TIMESTAMP('2010-01-01 00:00:00') ),
PARTITION p9 VALUES LESS THAN (MAXVALUE)
);
在 MySQL 8.0 中，
TIMESTAMP不允许任何其他涉及值的表达式。（参见缺陷 #42849。）
笔记
也可以在 MySQL 8.0 中
UNIX_TIMESTAMP(timestamp_column)
用作分区表达式，用于按 分区的表LIST。然而，这样做通常是不切实际的。
按 对表进行分区RANGE COLUMNS，使用DATE或
DATETIME列作为分区列。例如，
可以直接members使用列来定义表
joined，如下所示：
CREATE TABLE members (
firstname VARCHAR(25) NOT NULL,
lastname VARCHAR(25) NOT NULL,
username VARCHAR(16) NOT NULL,
email VARCHAR(35),
joined DATE NOT NULL
)
PARTITION BY RANGE COLUMNS(joined) (
PARTITION p0 VALUES LESS THAN ('1960-01-01'),
PARTITION p1 VALUES LESS THAN ('1970-01-01'),
PARTITION p2 VALUES LESS THAN ('1980-01-01'),
PARTITION p3 VALUES LESS THAN ('1990-01-01'),
PARTITION p4 VALUES LESS THAN MAXVALUE
);
笔记
不支持使用
DATE或
以外的日期或时间类型的分区列。
DATETIMERANGE COLUMNS
© Mysql 中文网
