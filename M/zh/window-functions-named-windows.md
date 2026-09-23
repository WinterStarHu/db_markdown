# 12.21.4 命名窗口_MySQL 8.0 参考手册

12.21.4 命名窗口_MySQL 8.0 参考手册
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
12.1 内置函数和操作符参考
12.2 可加载函数参考
12.3 表达式求值中的类型转换
12.4 运营商
12.5 流量控制函数
12.6 数值函数和运算符
12.7 日期和时间函数
12.8 字符串函数和运算符
12.9 MySQL 使用什么日历？
12.10 全文搜索功能
12.11 转换函数和运算符
12.12 XML函数
12.13 位函数和运算符
12.14 加密和压缩函数
12.15 锁定函数
12.16 信息函数
12.17空间分析函数
12.18 JSON函数
12.19 与全局事务标识符（GTID）一起使用的函数
12.20聚合函数
12.21 窗口函数
12.21.1 窗口函数说明1
12.21.2 窗口函数概念和语法1
12.21.3 窗口函数框架规范1
12.21.4 命名窗口1
12.21.5 窗口函数限制1
12.22性能模式函数
12.23 内部函数
12.24 辅助功能
12.25 精密数学
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
MySQL 8.0 参考手册  / 第 12 章函数和运算符  / 12.21 窗口函数  /
12.21.4 命名窗口
12.21.4 命名窗口
可以定义窗口并为其指定名称，以便在OVER子句中引用它们。为此，请使用
WINDOW子句。如果出现在查询中，则该
WINDOW子句位于HAVING和ORDER BY
子句的位置之间，并具有以下语法：
WINDOW window_name AS (window_spec)
[, window_name AS (window_spec)] ...
对于每个窗口定义，
window_name是窗口名称，并且
window_spec是
OVER子句括号之间给出的相同类型的窗口规范，如
第 12.21.2 节，“窗口函数概念和语法”中所述：
window_spec:
[window_name] [partition_clause] [order_clause] [frame_clause]
子句对于多个子句将以其他方式定义同一窗口WINDOW的查询很有用。相反，您可以定义窗口一次，给它一个名称，然后在子句OVER中引用该名称
。OVER考虑这个查询，它多次定义同一个窗口：
SELECT
val,
ROW_NUMBER() OVER (ORDER BY val) AS 'row_number',
RANK()       OVER (ORDER BY val) AS 'rank',
DENSE_RANK() OVER (ORDER BY val) AS 'dense_rank'
FROM numbers;
通过使用
一次定义窗口并在
子句
WINDOW中按名称引用窗口，可以更简单地编写查询：OVERSELECT
val,
ROW_NUMBER() OVER w AS 'row_number',
RANK()       OVER w AS 'rank',
DENSE_RANK() OVER w AS 'dense_rank'
FROM numbers
WINDOW w AS (ORDER BY val);
命名窗口还可以更轻松地试验窗口定义以查看对查询结果的影响。您只需要修改
WINDOW子句中的窗口定义，而不是多个
OVER子句定义。
如果OVER子句使用rather than ，则可以通过添加其他子句来修改命名窗口。例如，此查询定义了一个包含分区的窗口，并在
子句中使用以不同方式修改窗口：
OVER
(window_name ...)OVER
window_nameORDER BYOVERSELECT
DISTINCT year, country,
FIRST_VALUE(year) OVER (w ORDER BY year ASC) AS first,
FIRST_VALUE(year) OVER (w ORDER BY year DESC) AS last
FROM sales
WINDOW w AS (PARTITION BY country);OVER子句只能向命名窗口添加属性，而不能修改它们
。如果命名窗口定义包含分区、排序或框架属性，则
OVER引用窗口名称的子句不能也包含相同类型的属性，否则会发生错误：
这种构造是允许的，因为窗口定义和引用OVER子句不包含相同类型的属性：
OVER (w ORDER BY country)
... WINDOW w AS (PARTITION BY country)
不允许使用此构造，因为该
OVER子句指定PARTITION
BY了一个已具有的命名窗口
PARTITION BY：
OVER (w PARTITION BY year)
... WINDOW w AS (PARTITION BY country)
命名窗口的定义本身可以以
window_name. 在这种情况下，允许向前和向后引用，但不允许循环：
这是允许的；它包含向前和向后引用但没有循环：
WINDOW w1 AS (w2), w2 AS (), w3 AS (w1)
这是不允许的，因为它包含一个循环：
WINDOW w1 AS (w2), w2 AS (w3), w3 AS (w1)
© Mysql 中文网
