# 24.2.3 列分区_MySQL 8.0 参考手册

24.2.3 列分区_MySQL 8.0 参考手册
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
24.2.3.1 范围列分区
24.2.3.2 LIST COLUMNS 分区
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
24.2.3 列分区
24.2.3 列分区
24.2.3.1 范围列分区24.2.3.2 LIST COLUMNS 分区
接下来的两节讨论
COLUMNS
partitioning，它们是
RANGE和LIST
partitioning 的变体。COLUMNS分区允许在分区键中使用多个列。为了在分区中放置行以及确定要在分区修剪中检查哪些分区以匹配行，所有这些列都被考虑在内。
此外，RANGE COLUMNS分区和LIST COLUMNS分区都支持使用非整数列来定义值范围或列表成员。允许的数据类型如下表所示：
所有整数类型：TINYINT、
SMALLINT、
MEDIUMINT、
INT
( INTEGER) 和
BIGINT. （这与按 和 分区相同RANGE。
LIST）
不支持将
其他数值数据类型（例如
DECIMAL或
）用作分区列。FLOAT
DATE和
DATETIME。
不支持使用与日期或时间相关的其他数据类型的列作为分区列。
以下字符串类型：
CHAR、
VARCHAR、
BINARY和
VARBINARY。
TEXT不
BLOB支持将列用作分区列。
RANGE COLUMNS接下来两节中的分区和
分区
的讨论LIST COLUMNS假定您已经熟悉 MySQL 5.1 及更高版本支持的基于范围和列表的分区；有关这些的更多信息，请分别参见
第 24.2.1 节，“RANGE 分区”和
第 24.2.2 节，“LIST 分区”。
© Mysql 中文网
