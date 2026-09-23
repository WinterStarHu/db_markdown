# 24.6.3 与函数相关的分区限制_MySQL 8.0 参考手册

24.6.3 与函数相关的分区限制_MySQL 8.0 参考手册
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
24.6.3 与函数相关的分区限制
24.6.3 与函数相关的分区限制
本节讨论 MySQL 分区中与分区表达式中使用的函数特别相关的限制。
分区表达式中只允许使用以下列表中显示的 MySQL 函数：
ABS()
CEILING()（参见
CEILING() 和 FLOOR()）
DATEDIFF()
DAY()
DAYOFMONTH()
DAYOFWEEK()
DAYOFYEAR()
EXTRACT()（参见
带有 WEEK 说明符的 EXTRACT() 函数）
FLOOR()（参见
CEILING() 和 FLOOR()）
HOUR()
MICROSECOND()
MINUTE()
MOD()
MONTH()
QUARTER()
SECOND()
TIME_TO_SEC()
TO_DAYS()
TO_SECONDS()
UNIX_TIMESTAMP()（有
TIMESTAMP专栏）
WEEKDAY()
YEAR()
YEARWEEK()
TO_DAYS()在 MySQL 8.0 中，
TO_SECONDS()、
YEAR()、 和
UNIX_TIMESTAMP()函数
支持分区剪枝。有关详细信息，请参阅
第 24.4 节，“分区修剪”。
天花板（）和地板（）。
这些函数中的每一个仅在传递给精确数字类型的参数时才返回整数，例如INTor 类型
之一DECIMAL。这意味着，例如，以下CREATE
TABLE语句因错误而失败，如下所示：
mysql> CREATE TABLE t (c FLOAT) PARTITION BY LIST( FLOOR(c) )(
->     PARTITION p0 VALUES IN (1,3,5),
->     PARTITION p1 VALUES IN (2,4,6)
-> );
ERROR 1490 (HY000): The PARTITION function returns the wrong type带有 WEEK 说明符的 EXTRACT() 函数。 EXTRACT()当用作 时，函数
返回的值
取决于
系统变量的值。因此，
当将单位指定为 时，不允许作为分区函数
。（漏洞 #54483）
EXTRACT(WEEK FROM
col)default_week_formatEXTRACT()WEEK有关这些函数的返回类型的更多信息，以及第 11.1 节，“数字数据类型” ，
请参见第 12.6.2 节，“数学函数” 。
© Mysql 中文网
