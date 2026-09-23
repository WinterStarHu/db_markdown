# 13.2.11 子查询_MySQL 8.0 参考手册

13.2.11 子查询_MySQL 8.0 参考手册
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
13.1 数据定义语句
13.2 数据操作语句
13.2.1 CALL 语句1
13.2.2 删除语句1
13.2.3 DO 声明1
13.2.4 HANDLER 语句1
13.2.5 导入表语句1
13.2.6 插入语句1
13.2.7 加载数据语句1
13.2.8 加载 XML 语句1
13.2.9 REPLACE 语句1
13.2.10 SELECT 语句1
13.2.11 子查询1
13.2.11.1 子查询作为标量操作数
13.2.11.2 使用子查询进行比较
13.2.11.3 带有 ANY、IN 或 SOME 的子查询
13.2.11.4 带有 ALL 的子查询
13.2.11.5 行子查询
13.2.11.6 带有 EXISTS 或 NOT EXISTS 的子查询
13.2.11.7 相关子查询
13.2.11.8 派生表
13.2.11.9 横向派生表
13.2.11.10 子查询错误
13.2.11.11 优化子查询
13.2.11.12 对子查询的限制
13.2.12 TABLE 语句1
13.2.13 更新语句1
13.2.14 VALUES 语句1
13.2.15 WITH（公用表表达式）1
13.2.12 集合操作1
13.3 事务和锁定语句
13.4 复制语句
13.5 准备好的语句
13.6 复合语句语法
13.7 数据库管理语句
13.8 效用语句
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
MySQL 8.0 参考手册  / 第 13 章 SQL 语句  / 13.2 数据操作语句  /
13.2.11 子查询
13.2.11 子查询
13.2.11.1 子查询作为标量操作数13.2.11.2 使用子查询进行比较13.2.11.3 带有 ANY、IN 或 SOME 的子查询13.2.11.4 带有 ALL 的子查询13.2.11.5 行子查询13.2.11.6 带有 EXISTS 或 NOT EXISTS 的子查询13.2.11.7 相关子查询13.2.11.8 派生表13.2.11.9 横向派生表13.2.11.10 子查询错误13.2.11.11 优化子查询13.2.11.12 对子查询的限制
子查询是SELECT另一个语句中的一个语句。
支持 SQL 标准要求的所有子查询形式和操作，以及一些 MySQL 特定的功能。
下面是一个子查询的例子：
SELECT * FROM t1 WHERE column1 = (SELECT column1 FROM t2);
在此示例中，SELECT * FROM t1 ...是
外部查询（或外部语句），并且(SELECT column1 FROM
t2)是子查询。我们说子查询嵌套在外层查询中，实际上可以将子查询嵌套在其他子查询中，嵌套到相当深的深度。子查询必须始终出现在括号内。
子查询的主要优点是：
它们允许结构化的查询，以便可以隔离语句的每个部分。
它们提供了执行操作的替代方法，否则这些操作将需要复杂的连接和联合。
许多人发现子查询比复杂的连接或联合更具可读性。的确，正是子查询的创新让人们产生了将早期的 SQL 称为
“结构化查询语言”的最初想法。”
下面是一个示例语句，显示了 SQL 标准指定并在 MySQL 中支持的子查询语法的要点：
DELETE FROM t1
WHERE s11 > ANY
(SELECT COUNT(*) /* no hint */ FROM t2
WHERE NOT EXISTS
(SELECT * FROM t3
WHERE ROW(5*t2.s1,77)=
(SELECT 50,11*s1 FROM t4 UNION SELECT 50,77 FROM
(SELECT * FROM t5) AS t5)));
子查询可以返回标量（单个值）、单行、单列或表（一列或多列的一行或多行）。这些称为标量、列、行和表子查询。返回特定类型结果的子查询通常只能在特定上下文中使用，如以下部分所述。
对可以使用子查询的语句类型几乎没有限制。子查询可以包含许多普通查询可以包含的关键字或子句
SELECT：
、、、、、连接DISTINCT、索引提示、GROUP BY构造
ORDER BY、注释、函数等。
LIMITUNION
从 MySQL 8.0.19 开始，子查询中可以使用TABLE
and语句。VALUES使用的子查询
VALUES通常是更详细的子查询版本，可以使用集合表示法或 withSELECT或
TABLE语法更紧凑地重写；假设该表
ts是使用语句创建的
CREATE TABLE
ts VALUES ROW(2), ROW(4), ROW(6)，此处显示的语句都是等效的：
SELECT * FROM tt
WHERE b > ANY (VALUES ROW(2), ROW(4), ROW(6));
SELECT * FROM tt
WHERE b > ANY (2, 4, 6);
SELECT * FROM tt
WHERE b > ANY (SELECT * FROM ts);
SELECT * FROM tt
WHERE b > ANY (TABLE ts);
子查询的示例TABLE显示在以下部分中。
子查询的外部语句可以是以下任何一项：
SELECT、
INSERT、
UPDATE、
DELETE、
SET或
DO。
有关优化器如何处理子查询的信息，请参阅
第 8.2.2 节，“优化子查询、派生表、视图引用和公用表表达式”。有关子查询使用限制的讨论，包括某些形式的子查询语法的性能问题，请参阅
第 13.2.11.12 节，“子查询限制”。
© Mysql 中文网
