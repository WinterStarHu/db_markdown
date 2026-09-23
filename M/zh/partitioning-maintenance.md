# 24.3.4 分区维护_MySQL 8.0 参考手册

24.3.4 分区维护_MySQL 8.0 参考手册
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
24.3.4 分区维护
24.3.4 分区维护
可以使用专用于此类目的的 SQL 语句对分区表执行许多表和分区维护任务。
分区表的表维护可以使用分区表支持的语句CHECK TABLE、
OPTIMIZE TABLE、
ANALYZE TABLE和
来完成REPAIR TABLE。
您可以使用许多扩展来
ALTER
TABLE直接在一个或多个分区上执行这种类型的操作，如下表所述：
重建分区。
重建分区；这与删除存储在分区中的所有记录，然后重新插入它们具有相同的效果。这对于碎片整理很有用。
例子：
ALTER TABLE t1 REBUILD PARTITION p0, p1;优化分区。
如果您从分区中删除了大量行，或者如果您对具有可变长度行（即具有 、 或 列）的分区表进行了多次更改，则VARCHAR可以
BLOB使用
TEXT回收
ALTER
TABLE ... OPTIMIZE PARTITION任何未使用的空间并进行碎片整理分区数据文件。
例子：
ALTER TABLE t1 OPTIMIZE PARTITION p0, p1;
在给定分区上使用OPTIMIZE PARTITION等同于在该分区上运行CHECK
PARTITION、ANALYZE PARTITION和REPAIR PARTITION。
一些 MySQL 存储引擎，包括
InnoDB，不支持每分区优化；在这些情况下，
ALTER
TABLE ... OPTIMIZE PARTITION分析并重建整个表，并导致发出适当的警告。（Bug #11751825，Bug #42822）使用ALTER TABLE
... REBUILD PARTITIONandALTER TABLE ...
ANALYZE PARTITION来避免这个问题。
分析分区。
这会读取并存储分区的密钥分布。
例子：
ALTER TABLE t1 ANALYZE PARTITION p3;修复分区。
这将修复损坏的分区。
例子：
ALTER TABLE t1 REPAIR PARTITION p0,p1;
通常，REPAIR PARTITION当分区包含重复键错误时失败。您可以使用
ALTER
IGNORE TABLE此选项，在这种情况下，由于存在重复键而无法移动的所有行都将从分区中删除（错误 #16900947）。
检查分区。
您可以使用CHECK TABLE与非分区表相同的方式来检查分区是否有错误。
例子：
ALTER TABLE trb3 CHECK PARTITION p1;
该语句告诉您p1表分区中
的数据或索引是否t1已损坏。如果是这种情况，请使用
ALTER
TABLE ... REPAIR PARTITION修复分区。
通常，CHECK PARTITION当分区包含重复键错误时失败。您可以
ALTER
IGNORE TABLE与此选项一起使用，在这种情况下，语句会返回分区中发现重复键违规的每一行的内容。仅报告表的分区表达式中列的值。（漏洞 #16900947）
刚刚显示的列表中的每个语句还支持关键字ALL代替分区名称列表。UsingALL导致该语句作用于表中的所有分区。
您还可以使用截断分区
ALTER TABLE ...
TRUNCATE PARTITION。该语句可用于从一个或多个分区中删除所有行，其方式与TRUNCATE TABLE从表中删除所有行的方式大致相同。
ALTER TABLE ...
TRUNCATE PARTITION ALL截断表中的所有分区。
© Mysql 中文网
