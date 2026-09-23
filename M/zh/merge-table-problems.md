# 16.7.2 MERGE 表问题_MySQL 8.0 参考手册

16.7.2 MERGE 表问题_MySQL 8.0 参考手册
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
MySQL 8.0 参考手册  / 第 16 章替代存储引擎  / 16.7 MERGE存储引擎  /
16.7.2 MERGE 表问题
16.7.2 MERGE 表问题
以下是MERGE
表的已知问题：
在 5.1.23 之前的 MySQL 服务器版本中，可以使用非临时子 MyISAM 表创建临时合并表。
从 5.1.23 版本开始，MERGE children 通过父表被锁定。如果父母是临时的，它没有被锁定，因此孩子们也没有被锁定。并行使用 MyISAM 表会损坏它们。
如果您使用ALTER TABLE将MERGE表更改为另一个存储引擎，则到基础表的映射将丢失。相反，底层MyISAM表中的行被复制到更改后的表中，然后该表使用指定的存储引擎。
表的INSERT_METHOD表选项
MERGE指示要使用哪个基础
MyISAM表来插入到
MERGE表中。但是，
在至少有一行直接插入到表中之前，对该表使用AUTO_INCREMENTtable 选项对
MyISAM插入到表中没有影响
。
MERGEMyISAM
一个MERGE表不能维护整个表的唯一性约束。当您执行 时
INSERT，数据进入第一个或最后一个MyISAM表（由INSERT_METHOD选项确定）。MySQL 确保唯一键值在该
MyISAM表中保持唯一，但不会在集合中的所有基础表中保持唯一。
由于MERGE引擎无法对基础表集强制执行唯一性，因此
REPLACE无法按预期工作。两个关键事实是：
REPLACE只能在它要写入的基础表中检测唯一键违规（由
INSERT_METHOD选项确定）。这不同于MERGE表本身的违规行为。
如果REPLACE检测到唯一键违规，它只会更改它正在写入的基础表中的相应行；即，第一个或最后一个表，由
INSERT_METHOD选项确定。
类似的考虑适用于
INSERT
... ON DUPLICATE KEY UPDATE。
MERGE表不支持分区。也就是说，您不能对表进行分区MERGE
，也不能对MERGE表的任何基础MyISAM表进行分区。
您不应该在没有子句的情况下使用,
, , , , 或
ANALYZE
TABLE在REPAIR TABLE映射
OPTIMIZE TABLE到
ALTER TABLE打开
DROP TABLE表
中的任何表上使用
。如果这样做，该表可能仍会引用原始表并产生意外结果。要解决此问题，请在执行任何指定操作之前
通过发出
语句来确保没有
表保持打开状态。DELETEWHERETRUNCATE TABLEMERGEMERGEMERGEFLUSH TABLESMERGE意外结果包括对表的操作报告表损坏
的可能性。如果这发生在对基础表进行的命名操作之一之后MyISAM，则损坏消息是虚假的。要处理此问题，
FLUSH TABLES请在修改MyISAM表后发出一条语句。
DROP TABLEon a table that is in use by a MERGEtable在Windows上不起作用，因为MERGE存储引擎的表映射对MySQL的上层是隐藏的。Windows 不允许删除打开的文件，因此您首先必须刷新所有MERGE表（使用
FLUSH TABLES）或删除
MERGE表，然后再删除表。
在访问表时检查表的定义MyISAM和
MERGE表（例如，作为
SELECTor
INSERT语句的一部分）。这些检查通过比较列顺序、类型、大小和相关索引来确保表的定义和父
MERGE表定义匹配。如果表之间存在差异，则返回错误且语句失败。因为这些检查是在打开表时进行的，所以对单个表定义的任何更改（包括列更改、列排序和引擎更改）都会导致语句失败。
MERGE表及其基础表
中的索引顺序应相同。如果您使用
ALTER TABLE向
UNIQUE表中使用的
MERGE表添加索引，然后使用
在表ALTER TABLE上添加非唯一索引，MERGE如果基础表中已经存在非唯一索引，则索引顺序对于表是不同的。（发生这种情况是因为
ALTER TABLE将
UNIQUE索引放在非唯一索引之前以便于快速检测重复键。）因此，对具有此类索引的表的查询可能会返回意外结果。
如果遇到类似ERROR 1017 (HY000): Can't find file: ' tbl_name.MRG' (errno: 2)的错误信息，一般说明部分底层表没有使用MyISAM
存储引擎。确认所有这些表都是
MyISAM.
表中的最大行数MERGE为 2 64（~1.844E+19；与MyISAM表相同）。不可能将多个MyISAM表合并到一个
MERGE行数超过此数量的表中。
目前已知将不同行格式
的基础MyISAM表与父表一起使用会失败。MERGE请参见错误 #32364。
生效时
不能更改非临时
MERGE表的联合列表。LOCK
TABLES以下
不起作用：
CREATE TABLE m1 ... ENGINE=MRG_MYISAM ...;
LOCK TABLES t1 WRITE, t2 WRITE, m1 WRITE;
ALTER TABLE m1 ... UNION=(t1,t2) ...;
但是，您可以使用临时
MERGE表来执行此操作。
您不能使用 来创建MERGE表
CREATE ... SELECT，既不能作为临时
MERGE表，也不能作为非
临时MERGE表。例如：
CREATE TABLE m1 ... ENGINE=MRG_MYISAM ... SELECT ...;
尝试这样做会导致错误：
tbl_nameis not BASE
TABLE。
在某些情况下，如果基础表包含或
列，则基础表和基础表PACK_KEYS之间的不同表选项值MERGE会导致意外结果。作为解决方法，使用
以确保所有涉及的表都具有相同的值。（缺陷号 50646）
CHARBINARYALTER TABLEPACK_KEYS
© Mysql 中文网
