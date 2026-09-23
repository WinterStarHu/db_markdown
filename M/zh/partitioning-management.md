# 24.3 分区管理_MySQL 8.0 参考手册

24.3 分区管理_MySQL 8.0 参考手册
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
MySQL 8.0 参考手册  / 第24章分区  /
24.3 分区管理
24.3 分区管理
24.3.1 RANGE 和 LIST 分区的管理24.3.2 HASH和KEY分区的管理24.3.3 与表交换分区和子分区24.3.4 分区维护24.3.5 获取分区信息
有多种使用 SQL 语句修改分区表的方法；ALTER
TABLE可以使用语句的分区扩展来添加、删除、重新定义、合并或拆分现有分区
。还有一些方法可以获取有关分区表和分区的信息。我们将在接下来的部分中讨论这些主题。
有关由RANGE或
分区的表中的分区管理的信息LIST，请参阅
第 24.3.1 节，“RANGE 和 LIST 分区的管理”。
有关管理HASH和
KEY分区的讨论，请参阅
第 24.3.2 节，“管理 HASH 和 KEY 分区”。
有关MySQL 8.0 中提供的用于获取有关分区表和分区的信息的机制的讨论，
请参阅第 24.3.5 节，“获取有关分区的信息”。
有关对分区执行维护操作的讨论，请参阅第 24.3.4 节，“分区维护”。
笔记
分区表的所有分区必须具有相同数量的子分区；一旦创建了表，就不可能更改子分区。
要改变表的分区方案，只需要使用
ALTER
TABLE带
partition_options选项的语句，其语法与CREATE
TABLE创建分区表时使用的语句相同；此选项（也）始终以关键字开头PARTITION
BY。假设使用以下
CREATE TABLE语句创建一个按范围分区的表：
CREATE TABLE trb3 (id INT, name VARCHAR(50), purchased DATE)
PARTITION BY RANGE( YEAR(purchased) ) (
PARTITION p0 VALUES LESS THAN (1990),
PARTITION p1 VALUES LESS THAN (1995),
PARTITION p2 VALUES LESS THAN (2000),
PARTITION p3 VALUES LESS THAN (2005)
);id要重新分区此表，以便使用列值作为键的基础，将其
按键分成两个分区，您可以使用以下语句：ALTER TABLE trb3 PARTITION BY KEY(id) PARTITIONS 2;
这对表的结构具有与删除表并使用重新创建表相同的效果CREATE TABLE trb3
PARTITION BY KEY(id) PARTITIONS 2;。
ALTER TABLE ... ENGINE = ...仅更改表使用的存储引擎，并保持表的分区方案不变。仅当目标存储引擎提供分区支持时，该语句才会成功。您可以使用
ALTER TABLE ... REMOVE PARTITIONING删除表的分区；参见第 13.1.9 节，“ALTER TABLE 语句”。
重要的
在给定的语句中只能使用单个PARTITION BY, ADD
PARTITION, DROP PARTITION,
REORGANIZE PARTITION或COALESCE
PARTITION子句
ALTER
TABLE。如果您（例如）希望删除分区并重新组织表的剩余分区，则必须在两个单独的
ALTER
TABLE语句中执行此操作（一个使用DROP
PARTITION，然后第二个使用
REORGANIZE PARTITION）。
您可以使用 删除一个或多个选定分区中的所有行
ALTER TABLE ...
TRUNCATE PARTITION。
© Mysql 中文网
