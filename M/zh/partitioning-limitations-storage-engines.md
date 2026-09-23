# 24.6.2 与存储引擎相关的分区限制_MySQL 8.0 参考手册

24.6.2 与存储引擎相关的分区限制_MySQL 8.0 参考手册
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
24.6.1 分区键、主键和唯一键1
24.6.2 与存储引擎相关的分区限制1
24.6.3 与函数相关的分区限制1
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
MySQL 8.0 参考手册  / 第24章分区  / 24.6 分区的约束和限制  /
24.6.2 与存储引擎相关的分区限制
24.6.2 与存储引擎相关的分区限制
在 MySQL 8.0 中，分区支持实际上并不是由 MySQL 服务器提供的，而是由表存储引擎自己的或本机分区处理程序提供的。在 MySQL 8.0 中，只有InnoDB
和NDB存储引擎提供本机分区处理程序。这意味着不能使用除这些以外的任何其他存储引擎来创建分区表。（您必须使用带有
NDB存储引擎的 MySQL NDB Cluster 来创建
NDB表。）
InnoDB 存储引擎。
InnoDB外键和 MySQL 分区不兼容。分区
InnoDB表不能有外键引用，也不能有外键引用的列。InnoDB不能对具有外键或被外键引用的表进行分区。
ALTER
TABLE ... OPTIMIZE PARTITION不能与使用InnoDB. 而是对此类表使用
ALTER TABLE ... REBUILD PARTITIONand
ALTER TABLE ... ANALYZE PARTITION。有关详细信息，请参阅
第 13.1.9.1 节，“ALTER TABLE 分区操作”。
用户定义的分区和 NDB 存储引擎（NDB Cluster）。
分区方式KEY（包括
）是存储引擎LINEAR KEY支持的唯一分区类型
。NDB在 NDB Cluster 的正常情况下，不可能使用 [ LINEAR]以外的任何分区类型创建 NDB Cluster 表KEY，并且尝试这样做会失败并出现错误。
异常（不适用于生产）new ：可以通过将NDB Cluster SQL 节点上的系统变量设置为来覆盖此限制
ON。如果您选择这样做，您应该知道使用非分区类型的表[LINEAR] KEY在生产中不受支持。在这种情况下，您可以创建和使用分区类型不是KEY
或的表LINEAR KEY，但这样做的风险完全由您自己承担。
可以为
NDB表定义的最大分区数取决于集群中数据节点和节点组的数量、所使用的 NDB Cluster 软件的版本以及其他因素。有关详细信息，请参阅
NDB 和用户定义的分区。
表中每个分区可以存储的最大固定大小数据量NDB为 128 TB。以前，这是 16 GB。
CREATE TABLEALTER
TABLE不允许使用会导致用户分区
NDB表不满足以下两个要求中的一个或两个的语句，并且会失败并出现错误
：
该表必须具有明确的主键。
表的分区表达式中列出的所有列都必须是主键的一部分。
例外。
如果用户分区NDB表是使用空列列表（即使用
PARTITION BY KEY()或PARTITION BY
LINEAR KEY()）创建的，则不需要显式主键。
分区选择。
表不支持分区选择
NDB。有关详细信息，请参阅
第 24.5 节，“分区选择”。
升级分区表。
执行升级时，分区的表
KEY必须转储并重新加载。使用非存储引擎的分区表
InnoDB不能从MySQL 5.7或更早版本升级到MySQL 8.0或更高版本；您必须在升级之前
从这些表中删除分区ALTER TABLE ...
REMOVE PARTITIONING或将它们转换为
InnoDB使用。ALTER TABLE ...
ENGINE=INNODB
有关将MyISAM
表转换为 的信息InnoDB，请参阅
第 15.6.1.5 节，“将表从 MyISAM 转换为 InnoDB”。
© Mysql 中文网
