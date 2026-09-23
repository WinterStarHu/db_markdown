# 24.2.5 KEY分区_MySQL 8.0 参考手册

24.2.5 KEY分区_MySQL 8.0 参考手册
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
24.2.5 KEY分区
24.2.5 KEY分区
按键分区类似于按散列分区，不同之处在于散列分区使用用户定义的表达式，用于键分区的散列函数由 MySQL 服务器提供。NDB Cluster
MD5()用于此目的；对于使用其他存储引擎的表，服务器使用自己的内部散列函数。
的语法规则CREATE TABLE ... PARTITION BY
KEY类似于创建按哈希分区的表的语法规则。此处列出了主要差异：
KEY被使用而不是
HASH。
KEY只接受零个或多个列名的列表。任何用作分区键的列都必须包含部分或全部表的主键（如果表有主键）。如果没有将列名指定为分区键，则使用表的主键（如果有的话）。例如，以下
CREATE TABLE语句在 MySQL 8.0 中有效：
CREATE TABLE k1 (
id INT NOT NULL PRIMARY KEY,
name VARCHAR(20)
)
PARTITION BY KEY()
PARTITIONS 2;
如果没有主键但有唯一键，则使用唯一键作为分区键：
CREATE TABLE k1 (
id INT NOT NULL,
name VARCHAR(20),
UNIQUE KEY (id)
)
PARTITION BY KEY()
PARTITIONS 2;
但是，如果唯一键列未定义为
NOT NULL，则前面的语句将失败。
在这两种情况下，分区键都是
id列，即使它没有显示在表的输出SHOW CREATE
TABLE或表的
PARTITION_EXPRESSION列中
INFORMATION_SCHEMA.PARTITIONS
。
与其他分区类型的情况不同，用于分区的列KEY不限于整数或NULL值。例如，以下CREATE
TABLE语句是有效的：
CREATE TABLE tm1 (
s1 CHAR(32) PRIMARY KEY
)
PARTITION BY KEY(s1)
PARTITIONS 10;如果要指定不同的分区类型，则
前面的语句将无效。（在这种情况下，简单地使用PARTITION BY
KEY()也是有效的并且与 具有相同的效果PARTITION BY KEY(s1)，因为
s1是表的主键。）
有关此问题的更多信息，请参阅
第 24.6 节，“分区的约束和限制”。
分区键不支持具有索引前缀的列。这意味着 、
CHAR、
VARCHAR和
BINARY列
VARBINARY可以在分区键中使用，只要它们不使用前缀；因为必须为
BLOBand
指定前缀TEXT索引定义中的列，不可能在分区键中使用这两种类型的列。在 MySQL 8.0.21 之前，在创建、更改或升级分区表时允许使用前缀的列，即使它们不包含在表的分区键中；在 MySQL 8.0.21 及更高版本中，这种允许行为已被弃用，并且当使用一个或多个此类列时，服务器会显示适当的警告或错误。有关更多信息和示例，
请参阅
键分区不支持的列索引前缀。
笔记
使用NDB存储引擎的表由 隐式分区
KEY，使用表的主键作为分区键（与其他 MySQL 存储引擎一样）。如果 NDB Cluster 表没有显式主键，则存储引擎为每个 NDB Cluster 表生成的“隐藏”NDB主键
用作分区键。
如果为
NDB表定义显式分区方案，则该表必须具有显式主键，并且分区表达式中使用的任何列都必须是该键的一部分。但是，如果表使用“空”分区表达式——即PARTITION BY
KEY()没有列引用——则不需要显式主键。
您可以使用ndb_desc实用程序（带有
-p选项）
观察此分区
。
重要的
对于键分区表，您不能执行
ALTER TABLE DROP PRIMARY KEY，因为这样做会产生错误ERROR 1466 (HY000): Field in list of fields for partition function not found in table。对于由 ;分区的 NDB Cluster 表来说，这不是问题KEY；在这种情况下，表将使用“隐藏”主键作为表的新分区键进行重组
。请参阅第 23 章，MySQL NDB Cluster 8.0。
也可以通过线性键对表进行分区。这是一个简单的例子：
CREATE TABLE tk (
col1 INT NOT NULL,
col2 CHAR(5),
col3 DATE
)
PARTITION BY LINEAR KEY (col1)
PARTITIONS 3;LINEAR关键字对分区的影响与对
KEY分区
的影响相同HASH，分区号是使用二次幂算法而不是模运算得出的。有关此算法及其含义的描述，
请参阅第 24.2.4.1 节，“线性散列分区” 。
© Mysql 中文网
