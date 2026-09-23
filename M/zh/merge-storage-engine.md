# 16.7 MERGE存储引擎_MySQL 8.0 参考手册

16.7 MERGE存储引擎_MySQL 8.0 参考手册
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
16.1 设置存储引擎
16.2 MyISAM 存储引擎
16.3 MEMORY存储引擎
16.4 CSV存储引擎
16.5 ARCHIVE存储引擎
16.6 BLACKHOLE存储引擎
16.7 MERGE存储引擎
16.7.1 MERGE 表的优点和缺点1
16.7.2 MERGE 表问题1
16.8 联合存储引擎
16.9 示例存储引擎
16.10 其他存储引擎
16.11 MySQL存储引擎架构概述
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
MySQL 8.0 参考手册  / 第 16 章替代存储引擎  /
16.7 MERGE存储引擎
16.7 MERGE存储引擎
16.7.1 MERGE 表的优点和缺点16.7.2 MERGE 表问题
MERGE存储引擎，也称为
引擎，是可以作为一个使用的相同表
的MRG_MyISAM集合
。“相同”是指所有的表都有相同的列数据类型和索引信息。您不能合并
列以不同顺序列出的表、相应列中的数据类型不完全相同或索引顺序不同的表。但是，可以使用myisampack压缩任何或所有表。请参阅
第 4.6.6 节，“myisampack — 生成压缩的只读 MyISAM 表”。这些表之间的差异无关紧要：
MyISAMMyISAMMyISAM
相应列和索引的名称可以不同。
表、列和索引的注释可以不同。
AVG_ROW_LENGTH、
MAX_ROWS或
等表格选项PACK_KEYS可能不同。
表的替代方案MERGE是分区表，它将单个表的分区存储在单独的文件中，并使某些操作能够更有效地执行。有关详细信息，请参阅第 24 章，分区。
当您创建一个MERGE表时，MySQL 会
.MRG在磁盘上创建一个文件，其中包含MyISAM应作为一个表使用的基础表的名称。表的表格式MERGE存储在MySQL数据字典中。基础表不必与MERGE
表位于同一数据库中。
您可以在
表格上使用SELECT、
DELETE、
UPDATE和
。您必须对映射到表的表
具有、
和
权限
。
INSERTMERGESELECTDELETEUPDATEMyISAMMERGE
笔记
使用MERGE表会带来以下安全问题：如果用户有权访问MyISAM
表t，则该用户可以创建一个
MERGE表m来访问t。但是，如果用户的权限随后被撤销，用户可以通过
t继续访问
。
tm
DROP TABLE与
MERGE表格
一起
使用只会删除MERGE规范。基础表不受影响。
要创建MERGE表，您必须指定一个
选项来指示要使用的表。您可以选择指定一个
选项来控制插入
表的方式。使用or
的值分别导致在第一个或最后一个基础表中进行插入。如果您未指定任何
选项，或者如果您指定它的值为，则不允许
插入到
表中，并且尝试这样做会导致错误。UNION=(list-of-tables)MyISAMINSERT_METHODMERGEFIRSTLASTINSERT_METHODNOMERGE
以下示例显示了如何创建MERGE
表：
mysql> CREATE TABLE t1 (
->    a INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
->    message CHAR(20)) ENGINE=MyISAM;
mysql> CREATE TABLE t2 (
->    a INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
->    message CHAR(20)) ENGINE=MyISAM;
mysql> INSERT INTO t1 (message) VALUES ('Testing'),('table'),('t1');
mysql> INSERT INTO t2 (message) VALUES ('Testing'),('table'),('t2');
mysql> CREATE TABLE total (
->    a INT NOT NULL AUTO_INCREMENT,
->    message CHAR(20), INDEX(a))
->    ENGINE=MERGE UNION=(t1,t2) INSERT_METHOD=LAST;
列在基础表中a被索引为 a ，但在表中没有。它在那里被索引但不是作为一个表，因为
表不能对基础表集强制唯一性。（类似地，
在基础表中具有索引的列应该在表中建立索引，而不是作为
索引。）
PRIMARY
KEYMyISAMMERGEPRIMARY KEYMERGEUNIQUEMERGEUNIQUE
创建MERGE表后，您可以使用它发出对整个表组进行操作的查询：
mysql> SELECT * FROM total;
+---+---------+
| a | message |
+---+---------+
| 1 | Testing |
| 2 | table   |
| 3 | t1      |
| 1 | Testing |
| 2 | table   |
| 3 | t2      |
+---+---------+
要将表重新映射MERGE到不同的表集合MyISAM，您可以使用以下方法之一：
DROP表MERGE并重新创建它。
用于更改基础表的列表。
ALTER TABLE tbl_name
UNION=(...)
也可以使用ALTER TABLE ...
UNION=()（即使用空
UNION子句）删除所有基础表。但是，在这种情况下，表实际上是空的并且插入失败，因为没有基础表来获取新行。这样的表可能用作使用 . 创建新MERGE表的模板CREATE
TABLE ... LIKE。
基础表定义和索引必须与表的定义紧密一致MERGE。MERGE
当打开作为表一部分的表时检查一致性，而不是在MERGE创建表时检查。如果任何表未通过一致性检查，则触发打开表的操作将失败。这意味着在
访问表MERGE时更改表的定义可能会导致失败
MERGE。应用于每个表的一致性检查是：
基础表和MERGE表的列数必须相同。
基础表和表中的列顺序
MERGE必须匹配。
MERGE此外，比较父表和基础表中
每个对应列的规范，并且必须满足这些检查：
基础表和表中的列类型
MERGE必须相同。
基础表和表中的列长度
MERGE必须相等。
基础表和
MERGE表的列可以是
NULL.
基础表必须至少具有与
MERGE表一样多的索引。基础表的索引可能比MERGE表多，但不能少。
笔记
MERGE存在一个已知问题，即同一列上的索引在表和基础表
中的顺序必须相同MyISAM。请参见缺陷 #33653。
每个索引都必须满足这些检查：
底层表和
MERGE表的索引类型必须相同。
基础表和表的索引定义中的索引部分（即复合索引中的多个列）的数量MERGE必须相同。
对于每个索引部分：
索引部分长度必须相等。
索引部分类型必须相等。
索引部分语言必须相等。
检查索引部分是否可以
NULL。
如果MERGE由于基础表的问题而无法打开或使用表，CHECK
TABLE则显示有关导致问题的表的信息。
其他资源
专用于MERGE存储引擎的论坛可在https://forums.mysql.com/list.php?93找到。
© Mysql 中文网
