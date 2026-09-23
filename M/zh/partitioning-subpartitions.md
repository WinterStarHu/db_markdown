# 24.2.6 子分区_MySQL 8.0 参考手册

24.2.6 子分区_MySQL 8.0 参考手册
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
24.2.6 子分区
24.2.6 子分区
子分区（也称为
复合分区）是分区表中每个分区的进一步划分。考虑以下
CREATE TABLE语句：
CREATE TABLE ts (id INT, purchased DATE)
PARTITION BY RANGE( YEAR(purchased) )
SUBPARTITION BY HASH( TO_DAYS(purchased) )
SUBPARTITIONS 2 (
PARTITION p0 VALUES LESS THAN (1990),
PARTITION p1 VALUES LESS THAN (2000),
PARTITION p2 VALUES LESS THAN MAXVALUE
);
表ts有 3 个RANGE
分区。这些分区p0中的每一个—— p1、 和—— 都p2进一步分为 2 个子分区。实际上，整个表被划分为多个
3 * 2 = 6分区。但是，由于PARTITION BY RANGE子句的作用，前 2 个只存储列中值小于 1990 的那些记录purchased。
可以对按
RANGE或分区的表进行子分区LIST。子分区可以使用HASH或
KEY分区。这也称为
复合分区。
笔记
SUBPARTITION BY HASH和
通常分别遵循与和
SUBPARTITION BY KEY相同的语法规则。一个例外是（与 不同）当前不支持默认列，因此必须指定用于此目的的列，即使该表具有显式主键。这是一个我们正在努力解决的已知问题；有关更多信息和示例，
请参阅
子分区问题。PARTITION BY HASHPARTITION BY KEYSUBPARTITION BY
KEYPARTITION BY KEY
也可以使用
SUBPARTITION子句显式定义子分区以指定各个子分区的选项。例如，创建与ts前面示例中所示相同的表的更详细的方式是：
CREATE TABLE ts (id INT, purchased DATE)
PARTITION BY RANGE( YEAR(purchased) )
SUBPARTITION BY HASH( TO_DAYS(purchased) ) (
PARTITION p0 VALUES LESS THAN (1990) (
SUBPARTITION s0,
SUBPARTITION s1
),
PARTITION p1 VALUES LESS THAN (2000) (
SUBPARTITION s2,
SUBPARTITION s3
),
PARTITION p2 VALUES LESS THAN MAXVALUE (
SUBPARTITION s4,
SUBPARTITION s5
)
);
此处列出了一些需要注意的句法项目：
每个分区必须具有相同数量的子分区。
如果您
SUBPARTITION在分区表的任何分区上显式定义任何子分区，则必须全部定义它们。换句话说，以下语句失败：
CREATE TABLE ts (id INT, purchased DATE)
PARTITION BY RANGE( YEAR(purchased) )
SUBPARTITION BY HASH( TO_DAYS(purchased) ) (
PARTITION p0 VALUES LESS THAN (1990) (
SUBPARTITION s0,
SUBPARTITION s1
),
PARTITION p1 VALUES LESS THAN (2000),
PARTITION p2 VALUES LESS THAN MAXVALUE (
SUBPARTITION s2,
SUBPARTITION s3
)
);
即使使用 ，该语句仍然会失败
SUBPARTITIONS 2。
每个SUBPARTITION子句必须（至少）包含子分区的名称。否则，您可以为子分区设置任何所需的选项或允许它采用该选项的默认设置。
子分区名称在整个表中必须是唯一的。例如，以下CREATE
TABLE语句是有效的：
CREATE TABLE ts (id INT, purchased DATE)
PARTITION BY RANGE( YEAR(purchased) )
SUBPARTITION BY HASH( TO_DAYS(purchased) ) (
PARTITION p0 VALUES LESS THAN (1990) (
SUBPARTITION s0,
SUBPARTITION s1
),
PARTITION p1 VALUES LESS THAN (2000) (
SUBPARTITION s2,
SUBPARTITION s3
),
PARTITION p2 VALUES LESS THAN MAXVALUE (
SUBPARTITION s4,
SUBPARTITION s5
)
);
© Mysql 中文网
