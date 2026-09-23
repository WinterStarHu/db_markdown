# 9.5 表达式_MySQL 8.0 参考手册

9.5 表达式_MySQL 8.0 参考手册
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
9.1 文字值
9.2 模式对象名称
9.3 关键字和保留字
9.4 用户自定义变量
9.5 表达式
9.6 查询属性
9.7 评论
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
MySQL 8.0 参考手册  / 第9章语言结构  /
9.5 表达式
9.5 表达式
本节列出了表达式在 MySQL 中必须遵循的语法规则，并提供了有关表达式中可能出现的术语类型的其他信息。
表达式语法表达术语注释时间间隔
表达式语法
以下语法规则定义了 MySQL 中的表达式语法。此处显示的语法基于
sql/sql_yacc.yyMySQL 源代码分发文件中给出的语法。有关某些表达式术语的其他信息，请参阅表达式术语注释。
expr:
expr OR expr
| expr || expr
| expr XOR expr
| expr AND expr
| expr && expr
| NOT expr
| ! expr
| boolean_primary IS [NOT] {TRUE | FALSE | UNKNOWN}
| boolean_primary
boolean_primary:
boolean_primary IS [NOT] NULL
| boolean_primary <=> predicate
| boolean_primary comparison_operator predicate
| boolean_primary comparison_operator {ALL | ANY} (subquery)
| predicate
comparison_operator: = | >= | > | <= | < | <> | !=
predicate:
bit_expr [NOT] IN (subquery)
| bit_expr [NOT] IN (expr [, expr] ...)
| bit_expr [NOT] BETWEEN bit_expr AND predicate
| bit_expr SOUNDS LIKE bit_expr
| bit_expr [NOT] LIKE simple_expr [ESCAPE simple_expr]
| bit_expr [NOT] REGEXP bit_expr
| bit_expr
bit_expr:
bit_expr | bit_expr
| bit_expr & bit_expr
| bit_expr << bit_expr
| bit_expr >> bit_expr
| bit_expr + bit_expr
| bit_expr - bit_expr
| bit_expr * bit_expr
| bit_expr / bit_expr
| bit_expr DIV bit_expr
| bit_expr MOD bit_expr
| bit_expr % bit_expr
| bit_expr ^ bit_expr
| bit_expr + interval_expr
| bit_expr - interval_expr
| simple_expr
simple_expr:
literal
| identifier
| function_call
| simple_expr COLLATE collation_name
| param_marker
| variable
| simple_expr || simple_expr
| + simple_expr
| - simple_expr
| ~ simple_expr
| ! simple_expr
| BINARY simple_expr
| (expr [, expr] ...)
| ROW (expr, expr [, expr] ...)
| (subquery)
| EXISTS (subquery)
| {identifier expr}
| match_expr
| case_expr
| interval_expr
对于运算符优先级，请参阅
第 12.4.1 节，“运算符优先级”。某些运算符的优先级和含义取决于 SQL 模式：
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
表达术语注释
有关文字值语法，请参阅第 9.1 节，“文字值”。
有关标识符语法，请参阅第 9.2 节，“模式对象名称”。
变量可以是用户变量、系统变量，也可以是存储的程序局部变量或参数：
用户变量：第 9.4 节，“用户定义的变量”
系统变量：第 5.1.9 节，“使用系统变量”
存储的程序局部变量：
第 13.6.4.1 节，“局部变量 DECLARE 语句”
存储的程序参数：
第 13.1.17 节，“CREATE PROCEDURE 和 CREATE FUNCTION 语句”
param_marker?
与占位符的准备语句中使用的一样。请参阅
第 13.5.1 节，“PREPARE 语句”。
(subquery)
指示返回单个值的子查询；即，标量子查询。请参阅第 13.2.11.1 节，“子查询作为标量操作数”。
{identifier
expr}是 ODBC 转义语法并被接受用于 ODBC 兼容性。值为
expr。语法中的{和
}花括号应该按字面意思写；它们不是语法描述中其他地方使用的元语法。
match_expr表示一个
MATCH表达式。请参阅
第 12.10 节，“全文搜索功能”。
case_expr表示一个
CASE表达式。请参阅
第 12.5 节，“流量控制功能”。
interval_expr表示时间间隔。请参阅时间间隔。
时间间隔
interval_expr在表达式中表示时间间隔。间隔具有以下语法：
INTERVAL expr unit
expr代表一个数量。
unit代表解释数量的单位；它是一个说明符，例如
HOUR, DAY, 或
WEEK。INTERVAL关键字和说明符unit不区分大小写。
下表显示了
expr每个
unit值的参数的预期形式。
表 9.2 时间间隔表达式和单位参数
unit价值
预期expr格式
MICROSECOND
MICROSECONDS
SECOND
SECONDS
MINUTE
MINUTES
HOUR
HOURS
DAY
DAYS
WEEK
WEEKS
MONTH
MONTHS
QUARTER
QUARTERS
YEAR
YEARS
SECOND_MICROSECOND
'SECONDS.MICROSECONDS'
MINUTE_MICROSECOND
'MINUTES:SECONDS.MICROSECONDS'
MINUTE_SECOND
'MINUTES:SECONDS'
HOUR_MICROSECOND
'HOURS:MINUTES:SECONDS.MICROSECONDS'
HOUR_SECOND
'HOURS:MINUTES:SECONDS'
HOUR_MINUTE
'HOURS:MINUTES'
DAY_MICROSECOND
'DAYS HOURS:MINUTES:SECONDS.MICROSECONDS'
DAY_SECOND
'DAYS HOURS:MINUTES:SECONDS'
DAY_MINUTE
'DAYS HOURS:MINUTES'
DAY_HOUR
'DAYS HOURS'
YEAR_MONTH
'YEARS-MONTHS'
MySQL 允许
expr格式中的任何标点分隔符。表中显示的是建议的分隔符。
时间间隔用于某些函数，例如
DATE_ADD()和
DATE_SUB()：
mysql> SELECT DATE_ADD('2018-05-01',INTERVAL 1 DAY);
-> '2018-05-02'
mysql> SELECT DATE_SUB('2018-05-01',INTERVAL 1 YEAR);
-> '2017-05-01'
mysql> SELECT DATE_ADD('2020-12-31 23:59:59',
->                 INTERVAL 1 SECOND);
-> '2021-01-01 00:00:00'
mysql> SELECT DATE_ADD('2018-12-31 23:59:59',
->                 INTERVAL 1 DAY);
-> '2019-01-01 23:59:59'
mysql> SELECT DATE_ADD('2100-12-31 23:59:59',
->                 INTERVAL '1:1' MINUTE_SECOND);
-> '2101-01-01 00:01:00'
mysql> SELECT DATE_SUB('2025-01-01 00:00:00',
->                 INTERVAL '1 1:1:1' DAY_SECOND);
-> '2024-12-30 22:58:59'
mysql> SELECT DATE_ADD('1900-01-01 00:00:00',
->                 INTERVAL '-1 10' DAY_HOUR);
-> '1899-12-30 14:00:00'
mysql> SELECT DATE_SUB('1998-01-02', INTERVAL 31 DAY);
-> '1997-12-02'
mysql> SELECT DATE_ADD('1992-12-31 23:59:59.000002',
->            INTERVAL '1.999999' SECOND_MICROSECOND);
-> '1993-01-01 00:00:01.000001'
时间算术也可以在
与or
运算符INTERVAL一起使用的
表达式中执行：
+-date + INTERVAL expr unit
date - INTERVAL expr unit
INTERVAL expr
unit+
如果另一侧的表达式是日期或日期时间值，则允许在运算符的任一侧。对于
-运算符，
只允许在右侧使用，因为从间隔中减去日期或日期时间值没有意义。
INTERVAL expr
unitmysql> SELECT '2018-12-31 23:59:59' + INTERVAL 1 SECOND;
-> '2019-01-01 00:00:00'
mysql> SELECT INTERVAL 1 DAY + '2018-12-31';
-> '2019-01-01'
mysql> SELECT '2025-01-01' - INTERVAL 1 SECOND;
-> '2024-12-31 23:59:59'
该函数使用与or
EXTRACT()相同种类的unit说明符
，但从日期中提取部分而不是执行日期算术：
DATE_ADD()DATE_SUB()mysql> SELECT EXTRACT(YEAR FROM '2019-07-02');
-> 2019
mysql> SELECT EXTRACT(YEAR_MONTH FROM '2019-07-02 01:02:03');
-> 201907
时间间隔可以用在CREATE
EVENT语句中：
CREATE EVENT myevent
ON SCHEDULE AT CURRENT_TIMESTAMP + INTERVAL 1 HOUR
DO
UPDATE myschema.mytable SET mycol = mycol + 1;
如果指定的间隔值太短（不包括
unit关键字预期的所有间隔部分），MySQL 会假定您遗漏了间隔值的最左边部分。例如，如果您指定 a unitof
DAY_SECOND，则值 of
expr应包含天、小时、分钟和秒部分。如果您指定一个值，如
'1:10'，MySQL 假定缺少天和小时部分，并且该值表示分钟和秒。换句话说，'1:10' DAY_SECOND以等同于 的方式进行解释
'1:10' MINUTE_SECOND。这类似于 MySQL 解释的方式
TIME值表示经过的时间而不是一天中的时间。
expr被视为字符串，因此如果您使用 指定非字符串值，请小心
INTERVAL。例如，对于间隔说明符HOUR_MINUTE，“6/4”被视为 6 小时 4 分钟，而6/4计算结果为1.5000并被视为 1 小时 5000 分钟：
mysql> SELECT '6/4', 6/4;
-> 1.5000
mysql> SELECT DATE_ADD('2019-01-01', INTERVAL '6/4' HOUR_MINUTE);
-> '2019-01-01 06:04:00'
mysql> SELECT DATE_ADD('2019-01-01', INTERVAL 6/4 HOUR_MINUTE);
-> '2019-01-04 12:20:00'
为确保按照您的预期解释间隔值，
CAST()可以使用操作。要将6/4其视为 1 小时 5 分钟，请将其转换为
DECIMAL具有单个小数位的值：
mysql> SELECT CAST(6/4 AS DECIMAL(3,1));
-> 1.5
mysql> SELECT DATE_ADD('1970-01-01 12:00:00',
->                 INTERVAL CAST(6/4 AS DECIMAL(3,1)) HOUR_MINUTE);
-> '1970-01-01 13:05:00'
如果您在日期值中添加或减去包含时间部分的内容，结果将自动转换为日期时间值：
mysql> SELECT DATE_ADD('2023-01-01', INTERVAL 1 DAY);
-> '2023-01-02'
mysql> SELECT DATE_ADD('2023-01-01', INTERVAL 1 HOUR);
-> '2023-01-01 01:00:00'
如果您添加MONTH、
YEAR_MONTH或YEAR并且结果日期中有一天大于新月的最大天数，则该天将调整为新月的最大天数：
mysql> SELECT DATE_ADD('2019-01-30', INTERVAL 1 MONTH);
-> '2019-02-28'
日期算术运算需要完整的日期并且不适用于不完整的日期，例如
'2016-07-00'或格式错误的日期：
mysql> SELECT DATE_ADD('2016-07-00', INTERVAL 1 DAY);
-> NULL
mysql> SELECT '2005-03-32' + INTERVAL 1 MONTH;
-> NULL
© Mysql 中文网
