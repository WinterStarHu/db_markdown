# 12.21.1 窗口函数说明_MySQL 8.0 参考手册

12.21.1 窗口函数说明_MySQL 8.0 参考手册
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
12.21.1 窗口函数说明
12.21.1 窗口函数说明
本节介绍非聚合窗口函数，对于查询中的每一行，使用与该行相关的行执行计算。大多数聚合函数也可以用作窗口函数；请参阅第 12.20.1 节，“聚合函数说明”。
有关窗口函数使用信息和示例，以及OVER子句、窗口、分区、框架和对等项等术语的定义，请参阅
第 12.21.2 节，“窗口函数概念和语法”。
表 12.26 窗口函数
姓名
描述
CUME_DIST()
累计分配值
DENSE_RANK()
当前行在其分区内的排名，没有间隙
FIRST_VALUE()
窗口框架第一行的参数值
LAG()
分区内滞后当前行的行的参数值
LAST_VALUE()
窗口框架最后一行的参数值
LEAD()
分区内当前行前导行的参数值
NTH_VALUE()
来自窗口框架第 N 行的参数值
NTILE()
当前行在其分区内的桶号。
PERCENT_RANK()
百分比排名值
RANK()
当前行在其分区内的排名，有间隙
ROW_NUMBER()
其分区内的当前行数
在以下函数描述中，
over_clause代表
第 12.21.2 节“窗口函数概念和语法”OVER中描述的子句
。某些窗口函数允许使用一个子句来指定在计算结果时如何处理值。该条款是可选的。它是 SQL 标准的一部分，但 MySQL 实现仅允许
（这也是默认设置）。这意味着在计算结果时会考虑值。已解析，但会产生错误。
null_treatmentNULLRESPECT NULLSNULLIGNORE NULLS
CUME_DIST()
over_clause
返回一组值中某个值的累积分布；即，分区值小于或等于当前行中的值的百分比。这表示窗口分区的窗口排序中当前行之前或对等的行数除以窗口分区中的总行数。返回值范围从 0 到 1。
此函数应与ORDER
BY将分区行排序为所需顺序一起使用。如果没有ORDER BY，所有行都是对等行并且具有值
N/ N= 1，其中N是分区大小。
over_clause如
第 12.21.2 节，“窗口函数概念和语法”中所述。
以下查询针对
val列中的
CUME_DIST()值集显示每一行的值，以及类似
PERCENT_RANK()函数返回的百分比排名值。作为参考，查询还使用以下方式显示行号
ROW_NUMBER()：
mysql> SELECT
val,
ROW_NUMBER()   OVER w AS 'row_number',
CUME_DIST()    OVER w AS 'cume_dist',
PERCENT_RANK() OVER w AS 'percent_rank'
FROM numbers
WINDOW w AS (ORDER BY val);
+------+------------+--------------------+--------------+
| val  | row_number | cume_dist          | percent_rank |
+------+------------+--------------------+--------------+
|    1 |          1 | 0.2222222222222222 |            0 |
|    1 |          2 | 0.2222222222222222 |            0 |
|    2 |          3 | 0.3333333333333333 |         0.25 |
|    3 |          4 | 0.6666666666666666 |        0.375 |
|    3 |          5 | 0.6666666666666666 |        0.375 |
|    3 |          6 | 0.6666666666666666 |        0.375 |
|    4 |          7 | 0.8888888888888888 |         0.75 |
|    4 |          8 | 0.8888888888888888 |         0.75 |
|    5 |          9 |                  1 |            1 |
+------+------------+--------------------+--------------+
DENSE_RANK()
over_clause
返回当前行在其分区内的排名，没有间隙。同行被视为关系并获得相同的排名。此函数为对等组分配连续的等级；结果是大小大于 1 的组不会产生不连续的等级数。有关示例，请参阅RANK()功能说明。
此函数应与ORDER
BY将分区行排序为所需顺序一起使用。没有ORDER BY，所有行都是对等的。
over_clause如
第 12.21.2 节，“窗口函数概念和语法”中所述。
FIRST_VALUE(expr)
[ null_treatment]
over_clause
expr从窗口框架的第一行
返回值。
over_clause如
第 12.21.2 节，“窗口函数概念和语法”中所述。
null_treatment如介绍部分所述。
以下查询演示
FIRST_VALUE()、
LAST_VALUE()和 的两个实例NTH_VALUE()：
mysql> SELECT
time, subject, val,
FIRST_VALUE(val)  OVER w AS 'first',
LAST_VALUE(val)   OVER w AS 'last',
NTH_VALUE(val, 2) OVER w AS 'second',
NTH_VALUE(val, 4) OVER w AS 'fourth'
FROM observations
WINDOW w AS (PARTITION BY subject ORDER BY time
ROWS UNBOUNDED PRECEDING);
+----------+---------+------+-------+------+--------+--------+
| time     | subject | val  | first | last | second | fourth |
+----------+---------+------+-------+------+--------+--------+
| 07:00:00 | st113   |   10 |    10 |   10 |   NULL |   NULL |
| 07:15:00 | st113   |    9 |    10 |    9 |      9 |   NULL |
| 07:30:00 | st113   |   25 |    10 |   25 |      9 |   NULL |
| 07:45:00 | st113   |   20 |    10 |   20 |      9 |     20 |
| 07:00:00 | xh458   |    0 |     0 |    0 |   NULL |   NULL |
| 07:15:00 | xh458   |   10 |     0 |   10 |     10 |   NULL |
| 07:30:00 | xh458   |    5 |     0 |    5 |     10 |   NULL |
| 07:45:00 | xh458   |   30 |     0 |   30 |     10 |     30 |
| 08:00:00 | xh458   |   25 |     0 |   25 |     10 |     30 |
+----------+---------+------+-------+------+--------+--------+
每个函数都使用当前帧中的行，根据显示的窗口定义，这些行从第一个分区行扩展到当前行。对于
NTH_VALUE()调用，当前帧并不总是包含请求的行；在这种情况下，返回值为NULL。
LAG(expr [,
N[,
default]])
[ null_treatment]
over_clause
从其分区内expr滞后（先于）当前行的
行
返回值。N如果没有这样的行，则返回值为
default。例如，如果
N是 3，则返回值为
default前两行。如果缺少N或
default，则默认值分别为 1 和NULL。
N必须是文字非负整数。如果N为 0，
expr则对当前行进行评估。
从 MySQL 8.0.22 开始，N
不能NULL. 此外，它现在必须是 到 范围内的整数1，
包括以下任何形式：
263
无符号整数常量文字
位置参数标记 ( ?)
用户定义的变量
存储例程中的局部变量
over_clause如
第 12.21.2 节，“窗口函数概念和语法”中所述。
null_treatment如介绍部分所述。
LAG()（和类似的
LEAD()功能）通常用于计算行之间的差异。以下查询显示了一组按时间排序的观察结果，对于每个观察结果，相邻行中的LAG()和
LEAD()值，以及当前行和相邻行之间的差异：
mysql> SELECT
t, val,
LAG(val)        OVER w AS 'lag',
LEAD(val)       OVER w AS 'lead',
val - LAG(val)  OVER w AS 'lag diff',
val - LEAD(val) OVER w AS 'lead diff'
FROM series
WINDOW w AS (ORDER BY t);
+----------+------+------+------+----------+-----------+
| t        | val  | lag  | lead | lag diff | lead diff |
+----------+------+------+------+----------+-----------+
| 12:00:00 |  100 | NULL |  125 |     NULL |       -25 |
| 13:00:00 |  125 |  100 |  132 |       25 |        -7 |
| 14:00:00 |  132 |  125 |  145 |        7 |       -13 |
| 15:00:00 |  145 |  132 |  140 |       13 |         5 |
| 16:00:00 |  140 |  145 |  150 |       -5 |       -10 |
| 17:00:00 |  150 |  140 |  200 |       10 |       -50 |
| 18:00:00 |  200 |  150 | NULL |       50 |      NULL |
+----------+------+------+------+----------+-----------+
在示例中，LAG()和
LEAD()调用分别使用默认
值 1
N和
。
defaultNULL
第一行显示当 没有前一行时会发生什么LAG()： 函数返回default值（在本例中为NULL）。当没有下一行时，最后一行显示相同的内容
LEAD()。
LAG()并且
LEAD()还用于计算总和而不是差异。考虑这个数据集，它包含斐波那契数列的前几个数字：
mysql> SELECT n FROM fib ORDER BY n;
+------+
| n    |
+------+
|    1 |
|    1 |
|    2 |
|    3 |
|    5 |
|    8 |
+------+
以下查询显示
与当前行相邻的行的LAG()和
值。LEAD()它还使用这些函数将前后行的值添加到当前行值。效果是生成斐波那契数列中的下一个数字，以及之后的下一个数字：
mysql> SELECT
n,
LAG(n, 1, 0)      OVER w AS 'lag',
LEAD(n, 1, 0)     OVER w AS 'lead',
n + LAG(n, 1, 0)  OVER w AS 'next_n',
n + LEAD(n, 1, 0) OVER w AS 'next_next_n'
FROM fib
WINDOW w AS (ORDER BY n);
+------+------+------+--------+-------------+
| n    | lag  | lead | next_n | next_next_n |
+------+------+------+--------+-------------+
|    1 |    0 |    1 |      1 |           2 |
|    1 |    1 |    2 |      2 |           3 |
|    2 |    1 |    3 |      3 |           5 |
|    3 |    2 |    5 |      5 |           8 |
|    5 |    3 |    8 |      8 |          13 |
|    8 |    5 |    0 |     13 |           8 |
+------+------+------+--------+-------------+
生成初始斐波那契数集的一种方法是使用递归公用表表达式。有关示例，请参阅
斐波那契数列生成。
从 MySQL 8.0.22 开始，您不能为该函数的行参数使用负值。
LAST_VALUE(expr)
[ null_treatment]
over_clause
expr从窗口框架的最后一行
返回值。
over_clause如
第 12.21.2 节，“窗口函数概念和语法”中所述。
null_treatment如介绍部分所述。
有关示例，请参阅
FIRST_VALUE()功能说明。
LEAD(expr [,
N[,
default]])
[ null_treatment]
over_clause
从其分区内expr的行前导（跟随）当前行的
行
返回值。N如果没有这样的行，则返回值为
default。例如，如果
N是 3，则返回值为
default最后两行。如果
缺少N或
default，则默认值分别为 1 和NULL。
N必须是文字非负整数。如果N为 0，
expr则对当前行进行评估。
从 MySQL 8.0.22 开始，N
不能NULL. 此外，它现在必须是 到 范围内的整数1，
包括以下任何形式：
263
无符号整数常量文字
位置参数标记 ( ?)
用户定义的变量
存储例程中的局部变量
over_clause如
第 12.21.2 节，“窗口函数概念和语法”中所述。
null_treatment如介绍部分所述。
有关示例，请参阅LAG()
功能说明。
在 MySQL 8.0.22 及更高版本中，不允许对此函数的行参数使用负值。
NTH_VALUE(expr,
N)
[ from_first_last] [ null_treatment]
over_clause
expr从N窗口框架的第 - 行
返回值。如果没有这样的行，则返回值为
NULL。
N必须是文字正整数。
from_first_last是 SQL 标准的一部分，但 MySQL 实现仅允许
FROM FIRST（这也是默认设置）。这意味着计算从窗口的第一行开始。FROM LAST已解析，但会产生错误。FROM
LAST要获得与（从窗口的最后一行开始计算）相同的效果，请使用ORDER BY倒序排序。
over_clause如
第 12.21.2 节，“窗口函数概念和语法”中所述。
null_treatment如介绍部分所述。
有关示例，请参阅
FIRST_VALUE()功能说明。
在 MySQL 8.0.22 及更高版本中，您不能使用
NULL此函数的行参数。
NTILE(N)
over_clause
将分区划分为N组（桶），为分区中的每一行分配其桶号，并返回其分区内当前行的桶号。例如，如果
N是 4，
NTILE()则将行分成四个桶。如果N是 100，
NTILE()则将行分成 100 个桶。
N必须是文字正整数。桶号返回值范围从 1 到
N.
从 MySQL 8.0.22 开始，N
不能NULL. 此外，它必须是 到 范围内的整数1，
包括以下任何形式：
263
无符号整数常量文字
位置参数标记 ( ?)
用户定义的变量
存储例程中的局部变量
此函数应与ORDER
BY将分区行排序为所需顺序一起使用。
over_clause如
第 12.21.2 节，“窗口函数概念和语法”中所述。
对于列中的值集，以下查询显示
val将行分成两组或四组所产生的百分位数值。作为参考，查询还使用以下方式显示行号
ROW_NUMBER()：
mysql> SELECT
val,
ROW_NUMBER() OVER w AS 'row_number',
NTILE(2)     OVER w AS 'ntile2',
NTILE(4)     OVER w AS 'ntile4'
FROM numbers
WINDOW w AS (ORDER BY val);
+------+------------+--------+--------+
| val  | row_number | ntile2 | ntile4 |
+------+------------+--------+--------+
|    1 |          1 |      1 |      1 |
|    1 |          2 |      1 |      1 |
|    2 |          3 |      1 |      1 |
|    3 |          4 |      1 |      2 |
|    3 |          5 |      1 |      2 |
|    3 |          6 |      2 |      3 |
|    4 |          7 |      2 |      3 |
|    4 |          8 |      2 |      4 |
|    5 |          9 |      2 |      4 |
+------+------------+--------+--------+
从 MySQL 8.0.22 开始，
NTILE(NULL)不再允许该构造。
PERCENT_RANK()
over_clause
返回分区值小于当前行中值的百分比，不包括最大值。返回值范围从 0 到 1，表示行相对排名，根据此公式计算得出，其中rank是行排名，
rows是分区行数：
(rank - 1) / (rows - 1)
此函数应与ORDER
BY将分区行排序为所需顺序一起使用。没有ORDER BY，所有行都是对等的。
over_clause如
第 12.21.2 节，“窗口函数概念和语法”中所述。
有关示例，请参阅
CUME_DIST()功能说明。
RANK()
over_clause
返回当前行在其分区内的排名，有间隙。同行被视为关系并获得相同的排名。如果存在大于一个的组，则此函数不会为对等组分配连续的等级；结果是不连续的排名数字。
此函数应与ORDER
BY将分区行排序为所需顺序一起使用。没有ORDER BY，所有行都是对等的。
over_clause如
第 12.21.2 节，“窗口函数概念和语法”中所述。
以下查询显示 和 之间的区别
RANK()，前者生成带间隙的排名DENSE_RANK()，后者生成无间隙的排名。该查询显示列中一组值的每个成员的排名值
val，其中包含一些重复值。RANK()为对等体（重复项）分配相同的排名值，下一个更大的值的排名高出对等体的数量减一。DENSE_RANK()也为对等点分配相同的排名值，但下一个更高的值有更高的排名。作为参考，查询还使用以下方式显示行号
ROW_NUMBER()：
mysql> SELECT
val,
ROW_NUMBER() OVER w AS 'row_number',
RANK()       OVER w AS 'rank',
DENSE_RANK() OVER w AS 'dense_rank'
FROM numbers
WINDOW w AS (ORDER BY val);
+------+------------+------+------------+
| val  | row_number | rank | dense_rank |
+------+------------+------+------------+
|    1 |          1 |    1 |          1 |
|    1 |          2 |    1 |          1 |
|    2 |          3 |    3 |          2 |
|    3 |          4 |    4 |          3 |
|    3 |          5 |    4 |          3 |
|    3 |          6 |    4 |          3 |
|    4 |          7 |    7 |          4 |
|    4 |          8 |    7 |          4 |
|    5 |          9 |    9 |          5 |
+------+------------+------+------------+
ROW_NUMBER()
over_clause
返回其分区中当前行的编号。行号范围从 1 到分区行数。
ORDER BY影响行编号的顺序。如果没有ORDER BY，行编号是不确定的。
ROW_NUMBER()为同龄人分配不同的行号。要为对等点分配相同的值，请使用
RANK()或
DENSE_RANK()。有关示例，请参阅RANK()功能说明。
over_clause如
第 12.21.2 节，“窗口函数概念和语法”中所述。
© Mysql 中文网
