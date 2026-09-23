# 24.3.1 RANGE 和 LIST 分区的管理_MySQL 8.0 参考手册

24.3.1 RANGE 和 LIST 分区的管理_MySQL 8.0 参考手册
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
24.3.1 RANGE 和 LIST 分区的管理1
24.3.2 HASH和KEY分区的管理1
24.3.3 与表交换分区和子分区1
24.3.4 分区维护1
24.3.5 获取分区信息1
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
MySQL 8.0 参考手册  / 第24章分区  / 24.3 分区管理  /
24.3.1 RANGE 和 LIST 分区的管理
24.3.1 RANGE 和 LIST 分区的管理
范围和列表分区的添加和删除以类似的方式处理，因此我们在本节中讨论这两种分区的管理。有关使用按散列或键分区的表的信息，请参阅
第 24.3.2 节，“管理 HASH 和 KEY 分区”。
可以使用
带有选项的语句来完成从按 eitherRANGE或 by
分区的表中删除分区
。假设您创建了一个按范围分区的表，然后使用以下and
语句填充了 10 条记录：
LISTALTER
TABLEDROP
PARTITIONCREATE
TABLEINSERTmysql> CREATE TABLE tr (id INT, name VARCHAR(50), purchased DATE)
->     PARTITION BY RANGE( YEAR(purchased) ) (
->         PARTITION p0 VALUES LESS THAN (1990),
->         PARTITION p1 VALUES LESS THAN (1995),
->         PARTITION p2 VALUES LESS THAN (2000),
->         PARTITION p3 VALUES LESS THAN (2005),
->         PARTITION p4 VALUES LESS THAN (2010),
->         PARTITION p5 VALUES LESS THAN (2015)
->     );
Query OK, 0 rows affected (0.28 sec)
mysql> INSERT INTO tr VALUES
->     (1, 'desk organiser', '2003-10-15'),
->     (2, 'alarm clock', '1997-11-05'),
->     (3, 'chair', '2009-03-10'),
->     (4, 'bookcase', '1989-01-10'),
->     (5, 'exercise bike', '2014-05-09'),
->     (6, 'sofa', '1987-06-05'),
->     (7, 'espresso maker', '2011-11-22'),
->     (8, 'aquarium', '1992-08-04'),
->     (9, 'study desk', '2006-09-16'),
->     (10, 'lava lamp', '1998-12-25');
Query OK, 10 rows affected (0.05 sec)
Records: 10  Duplicates: 0  Warnings: 0
您可以看到应该将哪些项目插入到分区
p2中，如下所示：
mysql> SELECT * FROM tr
->     WHERE purchased BETWEEN '1995-01-01' AND '1999-12-31';
+------+-------------+------------+
| id   | name        | purchased  |
+------+-------------+------------+
|    2 | alarm clock | 1997-11-05 |
|   10 | lava lamp   | 1998-12-25 |
+------+-------------+------------+
2 rows in set (0.00 sec)
您还可以使用分区选择获取此信息，如下所示：
mysql> SELECT * FROM tr PARTITION (p2);
+------+-------------+------------+
| id   | name        | purchased  |
+------+-------------+------------+
|    2 | alarm clock | 1997-11-05 |
|   10 | lava lamp   | 1998-12-25 |
+------+-------------+------------+
2 rows in set (0.00 sec)
有关详细信息，请参阅第 24.5 节，“分区选择”。
要删除名为 的分区p2，请执行以下命令：
mysql> ALTER TABLE tr DROP PARTITION p2;
Query OK, 0 rows affected (0.03 sec)
笔记
NDBCLUSTER存储引擎不ALTER TABLE ... DROP
PARTITION支持
. ALTER
TABLE但是，它确实支持本章中描述
的其他与分区相关的扩展
。
记住这一点非常重要，当您删除一个分区时，您也会删除存储在该分区中的所有数据。通过重新运行之前的SELECT
查询，您可以看到情况是这样的：
mysql> SELECT * FROM tr WHERE purchased
-> BETWEEN '1995-01-01' AND '1999-12-31';
Empty set (0.00 sec)
笔记
DROP PARTITION由原生分区就地 API 支持，可以与
ALGORITHM={COPY|INPLACE}. DROP
PARTITIONwithALGORITHM=INPLACE
删除存储在分区中的数据并删除分区。但是，DROP PARTITION使用
ALGORITHM=COPY或
old_alter_table=ON重建分区表并尝试将数据从删除的分区移动到具有兼容
PARTITION ... VALUES定义的另一个分区。无法移动到另一个分区的数据将被删除。
因此，您必须先拥有
DROP表的权限，然后才能ALTER TABLE ... DROP
PARTITION在该表上执行。
如果您希望在保留表定义及其分区方案的同时从所有分区中删除所有数据，请使用该TRUNCATE TABLE语句。（请参阅第 13.1.37 节，“TRUNCATE TABLE 语句”。）
如果您打算在
不丢失数据的情况下更改表的分区，请ALTER
TABLE ... REORGANIZE PARTITION改用。有关的信息
，请参见下文或第 13.1.9 节“ALTER TABLE 语句”REORGANIZE PARTITION。
如果您现在执行一条SHOW CREATE
TABLE语句，您可以看到表的分区结构发生了怎样的变化：
mysql> SHOW CREATE TABLE tr\G
*************************** 1. row ***************************
Table: tr
Create Table: CREATE TABLE `tr` (
`id` int(11) DEFAULT NULL,
`name` varchar(50) DEFAULT NULL,
`purchased` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1
/*!50100 PARTITION BY RANGE ( YEAR(purchased))
(PARTITION p0 VALUES LESS THAN (1990) ENGINE = InnoDB,
PARTITION p1 VALUES LESS THAN (1995) ENGINE = InnoDB,
PARTITION p3 VALUES LESS THAN (2005) ENGINE = InnoDB,
PARTITION p4 VALUES LESS THAN (2010) ENGINE = InnoDB,
PARTITION p5 VALUES LESS THAN (2015) ENGINE = InnoDB) */
1 row in set (0.00 sec)purchased当您将列值介于
'1995-01-01'和
之间
的新行插入到已更改的表中时
'2004-12-31'，这些行将存储在 partition 中p3。您可以按如下方式验证这一点：
mysql> INSERT INTO tr VALUES (11, 'pencil holder', '1995-07-12');
Query OK, 1 row affected (0.00 sec)
mysql> SELECT * FROM tr WHERE purchased
-> BETWEEN '1995-01-01' AND '2004-12-31';
+------+----------------+------------+
| id   | name           | purchased  |
+------+----------------+------------+
|    1 | desk organiser | 2003-10-15 |
|   11 | pencil holder  | 1995-07-12 |
+------+----------------+------------+
2 rows in set (0.00 sec)
mysql> ALTER TABLE tr DROP PARTITION p3;
Query OK, 0 rows affected (0.03 sec)
mysql> SELECT * FROM tr WHERE purchased
-> BETWEEN '1995-01-01' AND '2004-12-31';
Empty set (0.00 sec)ALTER TABLE ... DROP PARTITION服务器不会像等效
DELETE查询
那样报告
从表中删除的行数
。
删除LIST分区使用与删除分区完全相同的ALTER TABLE ... DROP PARTITION语法RANGE。但是，这对您之后使用该表的影响有一个重要区别：您不能再将具有定义已删除分区的值列表中包含的任何值的任何行插入到表中。（有关
示例，
请参见第 24.2.2 节，“LIST 分区” 。）
要将新的范围或列表分区添加到以前分区的表中，请使用该ALTER TABLE ... ADD PARTITION
语句。对于按 分区的表
RANGE，这可用于将新范围添加到现有分区列表的末尾。假设您有一个分区表，其中包含您组织的成员资格数据，其定义如下：
CREATE TABLE members (
id INT,
fname VARCHAR(25),
lname VARCHAR(25),
dob DATE
)
PARTITION BY RANGE( YEAR(dob) ) (
PARTITION p0 VALUES LESS THAN (1980),
PARTITION p1 VALUES LESS THAN (1990),
PARTITION p2 VALUES LESS THAN (2000)
);
进一步假设会员的最低年龄为 16 岁。随着日历接近 2015 年底，您意识到您必须很快准备好接纳 2000 年（及之后）出生的会员。您可以修改该members表以容纳 2000 年至 2010 年出生的新成员，如下所示：
ALTER TABLE members ADD PARTITION (PARTITION p3 VALUES LESS THAN (2010));
对于按范围分区的表，您只能
ADD PARTITION将新分区添加到分区列表的高端。尝试以这种方式在现有分区之间或之前添加新分区会导致错误，如下所示：
mysql> ALTER TABLE members
>     ADD PARTITION (
>     PARTITION n VALUES LESS THAN (1970));
ERROR 1463 (HY000): VALUES LESS THAN value must be strictly »
increasing for each partition
您可以通过将第一个分区重新组织成两个新的分区来解决这个问题，这两个分区在它们之间划分范围，如下所示：
ALTER TABLE members
REORGANIZE PARTITION p0 INTO (
PARTITION n0 VALUES LESS THAN (1970),
PARTITION n1 VALUES LESS THAN (1980)
);
使用SHOW CREATE TABLE可以看到该ALTER TABLE语句达到了预期的效果：
mysql> SHOW CREATE TABLE members\G
*************************** 1. row ***************************
Table: members
Create Table: CREATE TABLE `members` (
`id` int(11) DEFAULT NULL,
`fname` varchar(25) DEFAULT NULL,
`lname` varchar(25) DEFAULT NULL,
`dob` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1
/*!50100 PARTITION BY RANGE ( YEAR(dob))
(PARTITION n0 VALUES LESS THAN (1970) ENGINE = InnoDB,
PARTITION n1 VALUES LESS THAN (1980) ENGINE = InnoDB,
PARTITION p1 VALUES LESS THAN (1990) ENGINE = InnoDB,
PARTITION p2 VALUES LESS THAN (2000) ENGINE = InnoDB,
PARTITION p3 VALUES LESS THAN (2010) ENGINE = InnoDB) */
1 row in set (0.00 sec)
另见第 13.1.9.1 节，“ALTER TABLE 分区操作”。
您还可以使用ALTER TABLE ... ADD
PARTITION向按 分区的表添加新分区LIST。假设
使用以下语句
tt定义了
一个表：CREATE TABLECREATE TABLE tt (
id INT,
data INT
)
PARTITION BY LIST(data) (
PARTITION p0 VALUES IN (5, 10, 15),
PARTITION p1 VALUES IN (6, 12, 18)
);
您可以添加一个新分区来存储具有
data列值7、
14和的行，21如下所示：
ALTER TABLE tt ADD PARTITION (PARTITION p2 VALUES IN (7, 14, 21));
请记住，您不能添加
LIST包含任何已包含在现有分区的值列表中的值的新分区。如果您尝试这样做，则会出现错误：
mysql> ALTER TABLE tt ADD PARTITION
>     (PARTITION np VALUES IN (4, 8, 12));
ERROR 1465 (HY000): Multiple definition of same constant »
in list partitioning
因为具有data列值
的任何行12都已分配给分区
p1，所以您不能在tt包含12
在其值列表中的表上创建新分区。为此，您可以先删除
p1，然后添加np，然后再添加p1一个修改过的定义。但是，如前所述，这会导致存储在其中的所有数据丢失p1— 通常情况下，这并不是您真正想要做的。另一种解决方案似乎是使用新分区制作表的副本并将数据复制到其中使用
CREATE TABLE ...
SELECT ...，然后删除旧表并重命名新表，但这在处理大量数据时可能非常耗时。在需要高可用性的情况下，这也可能不可行。
您可以在单个ALTER TABLE
... ADD PARTITION语句中添加多个分区，如下所示：
CREATE TABLE employees (
id INT NOT NULL,
fname VARCHAR(50) NOT NULL,
lname VARCHAR(50) NOT NULL,
hired DATE NOT NULL
)
PARTITION BY RANGE( YEAR(hired) ) (
PARTITION p1 VALUES LESS THAN (1991),
PARTITION p2 VALUES LESS THAN (1996),
PARTITION p3 VALUES LESS THAN (2001),
PARTITION p4 VALUES LESS THAN (2005)
);
ALTER TABLE employees ADD PARTITION (
PARTITION p5 VALUES LESS THAN (2010),
PARTITION p6 VALUES LESS THAN MAXVALUE
);
幸运的是，MySQL 的分区实现提供了在不丢失数据的情况下重新定义分区的方法。让我们首先看几个涉及RANGE
分区的简单示例。回想一下members现在定义的表，如下所示：
mysql> SHOW CREATE TABLE members\G
*************************** 1. row ***************************
Table: members
Create Table: CREATE TABLE `members` (
`id` int(11) DEFAULT NULL,
`fname` varchar(25) DEFAULT NULL,
`lname` varchar(25) DEFAULT NULL,
`dob` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1
/*!50100 PARTITION BY RANGE ( YEAR(dob))
(PARTITION n0 VALUES LESS THAN (1970) ENGINE = InnoDB,
PARTITION n1 VALUES LESS THAN (1980) ENGINE = InnoDB,
PARTITION p1 VALUES LESS THAN (1990) ENGINE = InnoDB,
PARTITION p2 VALUES LESS THAN (2000) ENGINE = InnoDB,
PARTITION p3 VALUES LESS THAN (2010) ENGINE = InnoDB) */
1 row in set (0.00 sec)
假设您想要将代表 1960 年之前出生的成员的所有行移动到一个单独的分区中。正如我们已经看到的，这不能使用
ALTER
TABLE ... ADD PARTITION. 但是，您可以使用另一个与分区相关的扩展
ALTER
TABLE来完成此操作：
ALTER TABLE members REORGANIZE PARTITION n0 INTO (
PARTITION s0 VALUES LESS THAN (1960),
PARTITION s1 VALUES LESS THAN (1970)
);
实际上，此命令将分区拆分p0
为两个新分区s0和
s1. 它还
p0根据两个子句中包含的规则将存储的数据移动到新分区中PARTITION ... VALUES
...，以便s0仅
包含那些YEAR(dob)小于 1960 的记录，并
s1包含那些
YEAR(dob)大于或等于 1960 但小于 1960的行比 1970 年。
子句也可REORGANIZE PARTITION用于合并相邻分区。您可以反转上一条语句对members
表的影响，如下所示：
ALTER TABLE members REORGANIZE PARTITION s0,s1 INTO (
PARTITION p0 VALUES LESS THAN (1970)
);
使用 拆分或合并分区时不会丢失数据
REORGANIZE PARTITION。在执行上述语句时，MySQL 将存储在分区中的所有记录移动s0到s1分区p0中。
的一般语法REORGANIZE PARTITION
如下所示：
ALTER TABLE tbl_name
REORGANIZE PARTITION partition_list
INTO (partition_definitions);
这里，tbl_name是分区表的名称，partition_list
是一个以逗号分隔的要更改的一个或多个现有分区的名称列表。
partition_definitions是一个以逗号分隔的新分区定义列表，它遵循与 中使用的
partition_definitions列表
相同的规则CREATE TABLE。在使用REORGANIZE
PARTITION. 例如，您可以将members表的所有四个分区重组为两个，如下所示：
ALTER TABLE members REORGANIZE PARTITION p0,p1,p2,p3 INTO (
PARTITION m0 VALUES LESS THAN (1980),
PARTITION m1 VALUES LESS THAN (2000)
);
您还可以使用REORGANIZE PARTITIONwith 分区的表LIST。让我们回到向列表分区tt表添加新分区并失败的问题，因为新分区的值已经存在于现有分区之一的值列表中。我们可以通过添加一个只包含不冲突值的分区来处理这个问题，然后重组新分区和现有分区，以便将存储在现有分区中的值现在移动到新分区中：
ALTER TABLE tt ADD PARTITION (PARTITION np VALUES IN (4, 8));
ALTER TABLE tt REORGANIZE PARTITION p1,np INTO (
PARTITION p1 VALUES IN (6, 18),
PARTITION np VALUES in (4, 8, 12)
);以下是使用orALTER TABLE ... REORGANIZE PARTITION分区的表重新分区
时要记住的一些要点
：
RANGELIST
用于确定新分区方案的选项遵循与用于语句
PARTITION的规则相同的规则。CREATE
TABLE
新的RANGE分区方案不能有任何重叠范围；新的LIST
分区方案不能有任何重叠的值集。
列表中的分区组合
partition_definitions应与
partition_list.
例如，分区p1和
一起涵盖了本节中用作示例p2的表中的 1980 年到 1999 年。members这两个分区的任何重组都应涵盖相同的年份范围。
对于按 分区的表RANGE，您只能重组相邻的分区；您不能跳过范围分区。
例如，您不能
members使用以开头的语句重组示例表，ALTER TABLE members REORGANIZE PARTITION p0,p2
INTO ...因为p0涵盖了 1970 年之前p2的年份以及从 1990 年到 1999 年（含）的年份，因此这些不是相邻的分区。p1
（在这种情况下
你不能跳过分区。）
您不能使用REORGANIZE PARTITION更改表使用的分区类型（例如，您不能将RANGE
分区更改为HASH分区或相反）。您也不能使用此语句更改分区表达式或列。要在不删除和重新创建表的情况下完成这些任务中的任何一个，您可以使用
ALTER
TABLE ... PARTITION BY ...，如下所示：
ALTER TABLE members
PARTITION BY HASH( YEAR(dob) )
PARTITIONS 8;
© Mysql 中文网
