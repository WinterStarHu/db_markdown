# 8.3.8 InnoDB和MyISAM索引统计收集_MySQL 8.0 参考手册

8.3.8 InnoDB和MyISAM索引统计收集_MySQL 8.0 参考手册
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
8.1 优化概述
8.2 优化SQL语句
8.3 优化和索引
8.3.1 MySQL如何使用索引1
8.3.2 主键优化1
8.3.3 空间索引优化1
8.3.4 外键优化1
8.3.5 列索引1
8.3.6 多列索引1
8.3.7 验证索引使用1
8.3.8 InnoDB和MyISAM索引统计收集1
8.3.9 B-Tree和哈希索引的比较1
8.3.10 索引扩展的使用1
8.3.11 优化器使用生成的列索引1
8.3.12 不可见索引1
8.3.13 降序索引1
8.3.14 从 TIMESTAMP 列进行索引查找1
8.4 优化数据库结构
8.5 优化 InnoDB 表
8.6 优化 MyISAM 表
8.7 优化 MEMORY 表
8.8 了解查询执行计划
8.9 控制查询优化器
8.10 缓冲和缓存
8.11 优化锁定操作
8.12 优化MySQL服务器
8.13 测量性能（基准测试）
8.14 查看服务器线程（进程）信息
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
MySQL 8.0 参考手册  / 第8章优化  / 8.3 优化和索引  /
8.3.8 InnoDB和MyISAM索引统计收集
8.3.8 InnoDB和MyISAM索引统计收集
存储引擎收集有关表的统计信息以供优化器使用。表统计是基于值组的，其中值组是一组具有相同键前缀值的行。出于优化器的目的，一个重要的统计数据是平均值组大小。
MySQL 通过以下方式使用平均值组大小：
ref估计每次访问
必须读取多少行
估计一个partial join产生了多少行，也就是一个操作产生的行数
(...) JOIN tbl_name ON tbl_name.key = expr
随着索引的平均值组大小的增加，索引对于这两个目的的用处减少，因为每次查找的平均行数增加：为了使索引有利于优化目的，最好每个索引值都以较小的目标为目标表中的行数。当给定的索引值产生大量行时，索引的用处不大，MySQL 也不太可能使用它。
平均值组大小与表基数有关，表基数是值组的数量。该
SHOW INDEX语句显示基于 的基数值N/S，其中
N是表中的行数，S是平均值组大小。该比率在表中产生近似数量的值组。
对于基于<=>比较运算符的连接，NULL与任何其他值没有区别对待：NULL <=> NULL，就像任何其他
.
N <=>
NN
但是，对于基于=运算符的连接，
NULL与非NULL值不同：
当
或
（或两者）为
时不为真。这会影响
对以下形式比较的访问： 如果当前值为 ，则MySQL 不会访问该表
，因为比较不可能为真。
expr1 =
expr2expr1expr2NULLreftbl_name.key =
exprexprNULL
对于=比较，表中有多少NULL个值并不重要。出于优化目的，相关值是非NULL值组的平均大小。但是，MySQL 当前不支持收集或使用该平均大小。
对于InnoDB和表，您可以分别通过和
系统变量MyISAM
对表统计信息的收集进行一些控制
。这些变量具有三个可能的值，它们的区别如下：
innodb_stats_methodmyisam_stats_method
当变量设置为 时nulls_equal，所有NULL值都被视为相同（即，它们都形成一个值组）。
如果NULL值组大小远高于平均非NULL值组大小，则此方法会使平均值组大小向上倾斜。这使得索引在优化器看来不如它对查找非NULL值的连接真正有用。因此，该
方法可能会导致优化器在应该访问时
nulls_equal不使用索引
。ref
当变量设置为 时
nulls_unequal，NULL
值不被视为相同。相反，每个
NULL值形成一个单独的大小为 1 的值组。
如果您有很多NULL值，此方法会向下倾斜平均值组大小。如果非值组的平均NULL大小很大，将NULL每个值计为大小为 1 的组会导致优化器高估查找非值的连接的索引NULL
值。因此，当其他方法可能更好时
，该nulls_unequal
方法可能会导致优化器使用此索引进行
查找。ref
当变量设置为 时
nulls_ignored，NULL
值将被忽略。
如果您倾向于使用许多使用
<=>rather than的联接=，
NULL则值在比较中并不特殊，并且一个NULL等于另一个。在这种情况下，nulls_equal是合适的统计方法。
系统innodb_stats_method变量具有全局值；系统
myisam_stats_method变量具有全局值和会话值。设置全局值会影响来自相应存储引擎的表的统计信息收集。设置会话值仅影响当前客户端连接的统计信息收集。这意味着您可以强制使用给定的方法重新生成表的统计信息，而不会通过将会话值设置为
myisam_stats_method.
要重新生成MyISAM表统计信息，您可以使用以下任何一种方法：
执行myisamchk --stats_method= method_name
--analyze
更改表使其统计信息过时（例如插入一行然后删除），然后设置
myisam_stats_method并发出ANALYZE TABLE
语句
关于使用
innodb_stats_methodand
的一些注意事项myisam_stats_method：
您可以强制显式收集表统计信息，如前所述。但是，MySQL 也可以自动收集统计信息。例如，如果在对表执行语句的过程中，其中一些语句修改了表，MySQL 可能会收集统计信息。（例如，这可能发生在批量插入或删除或某些
ALTER TABLE语句中。）如果发生这种情况，将使用任何值
innodb_stats_method或
myisam_stats_method当时有。因此，如果您使用一种方法收集统计信息，但是当稍后自动收集表的统计信息时系统变量设置为另一种方法，则使用另一种方法。
无法判断使用哪种方法为给定表生成统计信息。
这些变量仅适用于InnoDB和
MyISAM表。其他存储引擎只有一种收集表统计信息的方法。通常它更接近nulls_equal方法。
© Mysql 中文网
