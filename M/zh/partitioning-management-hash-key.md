# 24.3.2 HASH和KEY分区的管理_MySQL 8.0 参考手册

24.3.2 HASH和KEY分区的管理_MySQL 8.0 参考手册
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
24.3.2 HASH和KEY分区的管理
24.3.2 HASH和KEY分区的管理
按散列或键分区的表在分区设置更改方面彼此非常相似，并且两者在许多方面与按范围或列表分区的表不同。出于这个原因，本节将讨论修改按散列或仅按键分区的表。有关添加和删除按范围或列表分区的表的分区的讨论，请参阅
第 24.3.1 节，“RANGE 和 LIST 分区的管理”。
您不能从按 或 分区的表中删除分区的方式与从按
或HASH分区的表中删除分区KEY的方式相同
。但是，您可以使用合并或
分区。假设
包含有关客户的数据的表分为 12 个分区，创建如下所示：
RANGELISTHASHKEYALTER TABLE ... COALESCE
PARTITIONclientsCREATE TABLE clients (
id INT,
fname VARCHAR(30),
lname VARCHAR(30),
signed DATE
)
PARTITION BY HASH( MONTH(signed) )
PARTITIONS 12;
要将分区数从 12 个减少到 8 个，请执行以下
ALTER
TABLE语句：
mysql> ALTER TABLE clients COALESCE PARTITION 4;
Query OK, 0 rows affected (0.02 sec)
COALESCE适用于按HASH、
KEY、LINEAR HASH或
分区的表LINEAR KEY。这是一个与上一个类似的示例，不同之处仅在于该表按以下方式分区
LINEAR KEY：
mysql> CREATE TABLE clients_lk (
->     id INT,
->     fname VARCHAR(30),
->     lname VARCHAR(30),
->     signed DATE
-> )
-> PARTITION BY LINEAR KEY(signed)
-> PARTITIONS 12;
Query OK, 0 rows affected (0.03 sec)
mysql> ALTER TABLE clients_lk COALESCE PARTITION 4;
Query OK, 0 rows affected (0.06 sec)
Records: 0  Duplicates: 0  Warnings: 0
后面COALESCE PARTITION的数字是要合并到剩余部分的分区数——换句话说，它是要从表中删除的分区数。
尝试删除比表中更多的分区会导致如下错误：
mysql> ALTER TABLE clients COALESCE PARTITION 18;
ERROR 1478 (HY000): Cannot remove all partitions, use DROP TABLE instead
要将
clients表的分区数从 12 增加到 18，请
ALTER TABLE ... ADD PARTITION按此处所示使用：
ALTER TABLE clients ADD PARTITION PARTITIONS 6;
© Mysql 中文网
