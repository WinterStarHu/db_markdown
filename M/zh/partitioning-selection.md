# 24.5 分区选择_MySQL 8.0 参考手册

24.5 分区选择_MySQL 8.0 参考手册
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
24.5 分区选择
24.5 分区选择
WHERE支持为匹配给定条件
的行显式选择分区和子分区。分区选择类似于分区修剪，因为只检查特定分区是否匹配，但在两个关键方面有所不同：
要检查的分区由语句的发布者指定，不像分区修剪是自动的。
虽然分区修剪仅适用于查询，但查询和许多 DML 语句都支持显式选择分区。
此处列出了支持显式分区选择的 SQL 语句：
SELECT
DELETE
INSERT
REPLACE
UPDATE
LOAD DATA.
LOAD XML.
本节的其余部分讨论显式分区选择，因为它通常适用于刚刚列出的语句，并提供一些示例。
显式分区选择是使用
PARTITION选项实现的。对于所有支持的语句，此选项使用此处显示的语法：
PARTITION (partition_names)
partition_names:
partition_name, ...
此选项始终跟在一个或多个分区所属的表的名称之后。
partition_names是要使用的分区或子分区的逗号分隔列表。此列表中的每个名称必须是指定表的现有分区或子分区的名称；如果未找到任何分区或子分区，则该语句将失败并出现错误（分区 ' partition_name' 不存在）。命名的分区和子分区
partition_names可以按任何顺序列出，并且可以重叠。
使用该PARTITION选项时，仅检查列出的分区和子分区以查找匹配行。此选项可用于SELECT
语句中以确定哪​​些行属于给定分区。考虑一个名为 的分区表employees，使用此处显示的语句创建和填充：
SET @@SQL_MODE = '';
CREATE TABLE employees  (
id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
fname VARCHAR(25) NOT NULL,
lname VARCHAR(25) NOT NULL,
store_id INT NOT NULL,
department_id INT NOT NULL
)
PARTITION BY RANGE(id)  (
PARTITION p0 VALUES LESS THAN (5),
PARTITION p1 VALUES LESS THAN (10),
PARTITION p2 VALUES LESS THAN (15),
PARTITION p3 VALUES LESS THAN MAXVALUE
);
INSERT INTO employees VALUES
('', 'Bob', 'Taylor', 3, 2), ('', 'Frank', 'Williams', 1, 2),
('', 'Ellen', 'Johnson', 3, 4), ('', 'Jim', 'Smith', 2, 4),
('', 'Mary', 'Jones', 1, 1), ('', 'Linda', 'Black', 2, 3),
('', 'Ed', 'Jones', 2, 1), ('', 'June', 'Wilson', 3, 1),
('', 'Andy', 'Smith', 1, 3), ('', 'Lou', 'Waters', 2, 4),
('', 'Jill', 'Stone', 1, 4), ('', 'Roger', 'White', 3, 2),
('', 'Howard', 'Andrews', 1, 2), ('', 'Fred', 'Goldberg', 3, 3),
('', 'Barbara', 'Brown', 2, 3), ('', 'Alice', 'Rogers', 2, 2),
('', 'Mark', 'Morgan', 3, 3), ('', 'Karen', 'Cole', 3, 2);
您可以看到哪些行存储在分区中，
p1如下所示：
mysql> SELECT * FROM employees PARTITION (p1);
+----+-------+--------+----------+---------------+
| id | fname | lname  | store_id | department_id |
+----+-------+--------+----------+---------------+
|  5 | Mary  | Jones  |        1 |             1 |
|  6 | Linda | Black  |        2 |             3 |
|  7 | Ed    | Jones  |        2 |             1 |
|  8 | June  | Wilson |        3 |             1 |
|  9 | Andy  | Smith  |        1 |             3 |
+----+-------+--------+----------+---------------+
5 rows in set (0.00 sec)
结果与查询得到的结果相同SELECT *
FROM employees WHERE id BETWEEN 5 AND 9。
要从多个分区获取行，请以逗号分隔列表的形式提供它们的名称。例如，SELECT * FROM
employees PARTITION (p1, p2)返回分区中的所有行p1，p2同时排除其余分区中的行。
PARTITION可以使用将结果限制为一个或多个所需分区
的选项来重写针对分区表的任何有效查询。您可以使用
WHERE条件ORDER BY
和LIMIT选项等。您还可以将聚合函数与HAVING和
GROUP BY选项一起使用。employees当在先前定义
的表上运行时，以下每个查询都会产生有效结果
：mysql> SELECT * FROM employees PARTITION (p0, p2)
->     WHERE lname LIKE 'S%';
+----+-------+-------+----------+---------------+
| id | fname | lname | store_id | department_id |
+----+-------+-------+----------+---------------+
|  4 | Jim   | Smith |        2 |             4 |
| 11 | Jill  | Stone |        1 |             4 |
+----+-------+-------+----------+---------------+
2 rows in set (0.00 sec)
mysql> SELECT id, CONCAT(fname, ' ', lname) AS name
->     FROM employees PARTITION (p0) ORDER BY lname;
+----+----------------+
| id | name           |
+----+----------------+
|  3 | Ellen Johnson  |
|  4 | Jim Smith      |
|  1 | Bob Taylor     |
|  2 | Frank Williams |
+----+----------------+
4 rows in set (0.06 sec)
mysql> SELECT store_id, COUNT(department_id) AS c
->     FROM employees PARTITION (p1,p2,p3)
->     GROUP BY store_id HAVING c > 4;
+---+----------+
| c | store_id |
+---+----------+
| 5 |        2 |
| 5 |        3 |
+---+----------+
2 rows in set (0.00 sec)
使用分区选择的语句可以与使用任何支持的分区类型的表一起使用。[LINEAR] HASH当使用或
分区创建表[LINEAR] KEY且未指定分区名称时，MySQL 自动将分区命名为p0, p1,
p2, ...,
，其中
是分区数。对于未显式命名的子分区，MySQL 会自动为每个分区中的子分区分配
名称
,
,
, ...,
，其中是子分区的数量。针对此表执行时
pN-1NpXpXsp0pXsp1pXsp2pXspM-1MSELECT（或其他允许显式分区选择的 SQL 语句），您可以在PARTITION选项中使用这些生成的名称，如下所示：
mysql> CREATE TABLE employees_sub  (
->     id INT NOT NULL AUTO_INCREMENT,
->     fname VARCHAR(25) NOT NULL,
->     lname VARCHAR(25) NOT NULL,
->     store_id INT NOT NULL,
->     department_id INT NOT NULL,
->     PRIMARY KEY pk (id, lname)
-> )
->     PARTITION BY RANGE(id)
->     SUBPARTITION BY KEY (lname)
->     SUBPARTITIONS 2 (
->         PARTITION p0 VALUES LESS THAN (5),
->         PARTITION p1 VALUES LESS THAN (10),
->         PARTITION p2 VALUES LESS THAN (15),
->         PARTITION p3 VALUES LESS THAN MAXVALUE
-> );
Query OK, 0 rows affected (1.14 sec)
mysql> INSERT INTO employees_sub   # reuse data in employees table
->     SELECT * FROM employees;
Query OK, 18 rows affected (0.09 sec)
Records: 18  Duplicates: 0  Warnings: 0
mysql> SELECT id, CONCAT(fname, ' ', lname) AS name
->     FROM employees_sub PARTITION (p2sp1);
+----+---------------+
| id | name          |
+----+---------------+
| 10 | Lou Waters    |
| 14 | Fred Goldberg |
+----+---------------+
2 rows in set (0.00 sec)
您还可以在语句的一部分
使用PARTITION选项
，如下所示：
SELECTINSERT ...
SELECTmysql> CREATE TABLE employees_copy LIKE employees;
Query OK, 0 rows affected (0.28 sec)
mysql> INSERT INTO employees_copy
->     SELECT * FROM employees PARTITION (p2);
Query OK, 5 rows affected (0.04 sec)
Records: 5  Duplicates: 0  Warnings: 0
mysql> SELECT * FROM employees_copy;
+----+--------+----------+----------+---------------+
| id | fname  | lname    | store_id | department_id |
+----+--------+----------+----------+---------------+
| 10 | Lou    | Waters   |        2 |             4 |
| 11 | Jill   | Stone    |        1 |             4 |
| 12 | Roger  | White    |        3 |             2 |
| 13 | Howard | Andrews  |        1 |             2 |
| 14 | Fred   | Goldberg |        3 |             3 |
+----+--------+----------+----------+---------------+
5 rows in set (0.00 sec)
分区选择也可以与连接一起使用。假设我们使用此处显示的语句创建并填充两个表：
CREATE TABLE stores (
id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
city VARCHAR(30) NOT NULL
)
PARTITION BY HASH(id)
PARTITIONS 2;
INSERT INTO stores VALUES
('', 'Nambucca'), ('', 'Uranga'),
('', 'Bellingen'), ('', 'Grafton');
CREATE TABLE departments  (
id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
name VARCHAR(30) NOT NULL
)
PARTITION BY KEY(id)
PARTITIONS 2;
INSERT INTO departments VALUES
('', 'Sales'), ('', 'Customer Service'),
('', 'Delivery'), ('', 'Accounting');
您可以从连接中的任何或所有表中显式选择分区（或子分区，或两者）。（
PARTITION用于从给定表中选择分区的选项紧跟在表名之后，在所有其他选项之前，包括任何表别名。）例如，以下查询获取所有员工的姓名、员工 ID、部门和城市在 Nambucca 和 Bellingen（表格的分区）的任何一个城市的商店的销售或交付部门（表格的分区
）p1工作
的人：
departmentsp0storesmysql> SELECT
->     e.id AS 'Employee ID', CONCAT(e.fname, ' ', e.lname) AS Name,
->     s.city AS City, d.name AS department
-> FROM employees AS e
->     JOIN stores PARTITION (p1) AS s ON e.store_id=s.id
->     JOIN departments PARTITION (p0) AS d ON e.department_id=d.id
-> ORDER BY e.lname;
+-------------+---------------+-----------+------------+
| Employee ID | Name          | City      | department |
+-------------+---------------+-----------+------------+
|          14 | Fred Goldberg | Bellingen | Delivery   |
|           5 | Mary Jones    | Nambucca  | Sales      |
|          17 | Mark Morgan   | Bellingen | Delivery   |
|           9 | Andy Smith    | Nambucca  | Delivery   |
|           8 | June Wilson   | Bellingen | Sales      |
+-------------+---------------+-----------+------------+
5 rows in set (0.00 sec)
有关 MySQL 中连接的一般信息，请参阅
第 13.2.10.2 节，“JOIN 子句”。
当该PARTITION选项与
DELETE语句一起使用时，仅检查使用该选项列出的那些分区（和子分区，如果有的话）以查找要删除的行。任何其他分区都将被忽略，如下所示：
mysql> SELECT * FROM employees WHERE fname LIKE 'j%';
+----+-------+--------+----------+---------------+
| id | fname | lname  | store_id | department_id |
+----+-------+--------+----------+---------------+
|  4 | Jim   | Smith  |        2 |             4 |
|  8 | June  | Wilson |        3 |             1 |
| 11 | Jill  | Stone  |        1 |             4 |
+----+-------+--------+----------+---------------+
3 rows in set (0.00 sec)
mysql> DELETE FROM employees PARTITION (p0, p1)
->     WHERE fname LIKE 'j%';
Query OK, 2 rows affected (0.09 sec)
mysql> SELECT * FROM employees WHERE fname LIKE 'j%';
+----+-------+-------+----------+---------------+
| id | fname | lname | store_id | department_id |
+----+-------+-------+----------+---------------+
| 11 | Jill  | Stone |        1 |             4 |
+----+-------+-------+----------+---------------+
1 row in set (0.00 sec)p0只删除分区中
p1符合WHERE
条件
的两行。从第二次运行的结果中可以看出，
SELECT表中仍有一行与WHERE
条件匹配，但位于不同的分区 ( p2) 中。
UPDATE使用显式分区选择的语句以相同的方式运行；在确定要更新的行时，仅考虑该选项引用的分区中PARTITION的行，如执行以下语句所示：
mysql> UPDATE employees PARTITION (p0)
->     SET store_id = 2 WHERE fname = 'Jill';
Query OK, 0 rows affected (0.00 sec)
Rows matched: 0  Changed: 0  Warnings: 0
mysql> SELECT * FROM employees WHERE fname = 'Jill';
+----+-------+-------+----------+---------------+
| id | fname | lname | store_id | department_id |
+----+-------+-------+----------+---------------+
| 11 | Jill  | Stone |        1 |             4 |
+----+-------+-------+----------+---------------+
1 row in set (0.00 sec)
mysql> UPDATE employees PARTITION (p2)
->     SET store_id = 2 WHERE fname = 'Jill';
Query OK, 1 row affected (0.09 sec)
Rows matched: 1  Changed: 1  Warnings: 0
mysql> SELECT * FROM employees WHERE fname = 'Jill';
+----+-------+-------+----------+---------------+
| id | fname | lname | store_id | department_id |
+----+-------+-------+----------+---------------+
| 11 | Jill  | Stone |        2 |             4 |
+----+-------+-------+----------+---------------+
1 row in set (0.00 sec)
同样，当PARTITION与 一起使用时
DELETE，仅检查分区中的行或分区列表中指定的分区是否删除。
对于插入行的语句，行为的不同之处在于未能找到合适的分区会导致语句失败。对于INSERTand
REPLACE语句都是如此，如下所示：
mysql> INSERT INTO employees PARTITION (p2) VALUES (20, 'Jan', 'Jones', 1, 3);
ERROR 1729 (HY000): Found a row not matching the given partition set
mysql> INSERT INTO employees PARTITION (p3) VALUES (20, 'Jan', 'Jones', 1, 3);
Query OK, 1 row affected (0.07 sec)
mysql> REPLACE INTO employees PARTITION (p0) VALUES (20, 'Jan', 'Jones', 3, 2);
ERROR 1729 (HY000): Found a row not matching the given partition set
mysql> REPLACE INTO employees PARTITION (p3) VALUES (20, 'Jan', 'Jones', 3, 2);
Query OK, 2 rows affected (0.09 sec)InnoDB对于使用存储引擎
将多行写入分区表的语句：如果VALUES无法将以下列表中的任何行写入
partition_names列表中指定的分区之一，则整个语句将失败并且不会写入任何行。INSERT以下示例中的语句显示了这一点
，重用了employees之前创建的表：
mysql> ALTER TABLE employees
->     REORGANIZE PARTITION p3 INTO (
->         PARTITION p3 VALUES LESS THAN (20),
->         PARTITION p4 VALUES LESS THAN (25),
->         PARTITION p5 VALUES LESS THAN MAXVALUE
->     );
Query OK, 6 rows affected (2.09 sec)
Records: 6  Duplicates: 0  Warnings: 0
mysql> SHOW CREATE TABLE employees\G
*************************** 1. row ***************************
Table: employees
Create Table: CREATE TABLE `employees` (
`id` int(11) NOT NULL AUTO_INCREMENT,
`fname` varchar(25) NOT NULL,
`lname` varchar(25) NOT NULL,
`store_id` int(11) NOT NULL,
`department_id` int(11) NOT NULL,
PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8mb4
/*!50100 PARTITION BY RANGE (id)
(PARTITION p0 VALUES LESS THAN (5) ENGINE = InnoDB,
PARTITION p1 VALUES LESS THAN (10) ENGINE = InnoDB,
PARTITION p2 VALUES LESS THAN (15) ENGINE = InnoDB,
PARTITION p3 VALUES LESS THAN (20) ENGINE = InnoDB,
PARTITION p4 VALUES LESS THAN (25) ENGINE = InnoDB,
PARTITION p5 VALUES LESS THAN MAXVALUE ENGINE = InnoDB) */
1 row in set (0.00 sec)
mysql> INSERT INTO employees PARTITION (p3, p4) VALUES
->     (24, 'Tim', 'Greene', 3, 1),  (26, 'Linda', 'Mills', 2, 1);
ERROR 1729 (HY000): Found a row not matching the given partition set
mysql> INSERT INTO employees PARTITION (p3, p4, p5) VALUES
->     (24, 'Tim', 'Greene', 3, 1),  (26, 'Linda', 'Mills', 2, 1);
Query OK, 2 rows affected (0.06 sec)
Records: 2  Duplicates: 0  Warnings: 0
前面的
INSERT语句和
REPLACE写入多行的语句都是正确的。
对于使用提供自动分区的存储引擎的表，例如
NDB.
© Mysql 中文网
