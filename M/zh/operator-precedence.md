# 12.4.1 运算符优先级_MySQL 8.0 参考手册

12.4.1 运算符优先级_MySQL 8.0 参考手册
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
12.4.1 运算符优先级1
12.4.2 比较函数和运算符1
12.4.3 逻辑运算符1
12.4.4 赋值运算符1
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
MySQL 8.0 参考手册  / 第 12 章函数和运算符  / 12.4 运营商  /
12.4.1 运算符优先级
12.4.1 运算符优先级
运算符优先级如下表所示，从最高优先级到最低优先级。一起显示在一行上的运算符具有相同的优先级。
INTERVAL
BINARY, COLLATE
!
- (unary minus), ~ (unary bit inversion)
^
*, /, DIV, %, MOD
-, +
<<, >>
&
|
= (comparison), <=>, >=, >, <=, <, <>, !=, IS, LIKE, REGEXP, IN, MEMBER OF
BETWEEN, CASE, WHEN, THEN, ELSE
NOT
AND, &&
XOR
OR, ||
= (assignment), :=
的优先级=取决于它是用作比较运算符 ( =) 还是用作赋值运算符 ( =)。当用作比较运算符时，它与
<=>,
>=,
>,
<=,
<,
<>,
!=,
IS,
LIKE,
REGEXP, 和
具有相同的优先级IN()。当用作赋值运算符时，它的优先级与
:=.
第 13.7.6.1 节，“SET Syntax for Variable Assignment”和
第 9.4 节，“User-Defined Variables”，解释了 MySQL 如何确定对=应该适用。
对于在表达式中以相同优先级出现的运算符，求值从左到右进行，但赋值从右到左求值除外。
某些运算符的优先级和含义取决于 SQL 模式：
默认情况下，||
是逻辑OR运算符。PIPES_AS_CONCAT启用后，
||是字符串连接，优先级介于
和
^一元运算符之间。
默认情况下，!
优先级高于NOT. 与
HIGH_NOT_PRECEDENCE
enabled，!具有
NOT相同的优先级。
请参阅第 5.1.11 节，“服务器 SQL 模式”。
运算符的优先级决定表达式中项的求值顺序。要显式覆盖此顺序和组术语，请使用括号。例如：
mysql> SELECT 1+2*3;
-> 7
mysql> SELECT (1+2)*3;
-> 9
© Mysql 中文网
