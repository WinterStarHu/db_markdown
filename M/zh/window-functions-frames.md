# 12.21.3 窗口函数框架规范_MySQL 8.0 参考手册

12.21.3 窗口函数框架规范_MySQL 8.0 参考手册
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
12.21.3 窗口函数框架规范
12.21.3 窗口函数框架规范
与窗口函数一起使用的窗口的定义可以包括 frame 子句。框架是当前分区的子集，框架子句指定如何定义子集。
框架是相对于当前行确定的，这使得框架能够根据当前行在其分区内的位置在分区内移动。例子：
通过将帧定义为从分区开始到当前行的所有行，您可以计算每行的运行总计。
通过将帧定义为
N当前行任一侧的扩展行，您可以计算滚动平均值。
以下查询演示了如何使用移动帧来计算每组按时间排序的
level值的运行总计，以及根据当前行和紧接其前后的行计算的滚动平均值：
mysql> SELECT
time, subject, val,
SUM(val) OVER (PARTITION BY subject ORDER BY time
ROWS UNBOUNDED PRECEDING)
AS running_total,
AVG(val) OVER (PARTITION BY subject ORDER BY time
ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING)
AS running_average
FROM observations;
+----------+---------+------+---------------+-----------------+
| time     | subject | val  | running_total | running_average |
+----------+---------+------+---------------+-----------------+
| 07:00:00 | st113   |   10 |            10 |          9.5000 |
| 07:15:00 | st113   |    9 |            19 |         14.6667 |
| 07:30:00 | st113   |   25 |            44 |         18.0000 |
| 07:45:00 | st113   |   20 |            64 |         22.5000 |
| 07:00:00 | xh458   |    0 |             0 |          5.0000 |
| 07:15:00 | xh458   |   10 |            10 |          5.0000 |
| 07:30:00 | xh458   |    5 |            15 |         15.0000 |
| 07:45:00 | xh458   |   30 |            45 |         20.0000 |
| 08:00:00 | xh458   |   25 |            70 |         27.5000 |
+----------+---------+------+---------------+-----------------+
对于running_average列，在第一个之前或最后一个之后没有框架行。在这些情况下，AVG()计算可用行的平均值。
用作窗口函数的聚合函数对当前行框架中的行进行操作，这些非聚合窗口函数也是如此：
FIRST_VALUE()
LAST_VALUE()
NTH_VALUE()
标准 SQL 规定，对整个分区进行操作的窗口函数不应有 frame 子句。MySQL 允许为此类函数使用 frame 子句，但会忽略它。即使指定了帧，这些函数也会使用整个分区：
CUME_DIST()
DENSE_RANK()
LAG()
LEAD()
NTILE()
PERCENT_RANK()
RANK()
ROW_NUMBER()
frame 子句（如果给定）具有以下语法：
frame_clause:
frame_units frame_extent
frame_units:
{ROWS | RANGE}
在没有框架子句的情况下，默认框架取决于ORDER BY子句是否存在，如本节后面所述。
该frame_units值表示当前行和框架行之间的关系类型：
ROWS：框架由开始和结束行位置定义。偏移量是行号与当前行号的差异。
RANGE：框架由值范围内的行定义。偏移量是行值与当前行值的差异。
该frame_extent值表示帧的起点和终点。您可以仅指定帧的开始（在这种情况下，当前行隐含地结束）或用于BETWEEN指定两个帧端点：
frame_extent:
{frame_start | frame_between}
frame_between:
BETWEEN frame_start AND frame_end
frame_start, frame_end: {
CURRENT ROW
| UNBOUNDED PRECEDING
| UNBOUNDED FOLLOWING
| expr PRECEDING
| expr FOLLOWING
}
使用BETWEEN语法，
frame_start不得晚于
frame_end.
允许的frame_start和
frame_end值具有以下含义：
CURRENT ROW：对于ROWS，边界是当前行。对于RANGE，界限是当前行的对等点。
UNBOUNDED PRECEDING：边界是第一个分区行。
UNBOUNDED FOLLOWING：边界是最后一个分区行。
expr
PRECEDING：对于ROWS，边界是expr当前行之前的行。对于RANGE，边界是值等于当前行值减去 的行
expr；如果当前行值为
NULL，则边界是该行的对等项。
对于expr
PRECEDING(and
expr
FOLLOWING)，expr可以是?参数标记（用于准备语句）、非负数字文字或形式的时间间隔。对于
表达式，
指定非负区间值，并且是一个关键字，指示应解释值的单位。（有关允许
的说明符的详细信息，请参阅第 12.7 节“日期和时间函数”中的
函数说明。）
INTERVAL
val
unitINTERVALvalunitunitsDATE_ADD()
RANGE在数字或时间
上分别expr需要ORDER
BY数字或时间表达式。
expr
PRECEDINGvalid和
expr FOLLOWING
indicators
的例子：10 PRECEDING
INTERVAL 5 DAY PRECEDING
5 FOLLOWING
INTERVAL '2:30' MINUTE_SECOND FOLLOWING
expr
FOLLOWING：对于ROWS，边界是expr当前行之后的行。对于RANGE，边界是值等于当前行值加上 的行
expr；如果当前行值为
NULL，则边界是该行的对等项。
有关 的允许值expr，请参阅 的说明expr
PRECEDING。
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
在没有框架子句的情况下，默认框架取决于是否存在ORDER BY子句：
With ：默认帧包括从分区开始到当前行的行，包括当前行的所有对等点（根据
子句ORDER BY等于当前行的行）。ORDER BY默认值等同于此框架规范：
RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
没有ORDER BY：默认框架包括所有分区行（因为没有ORDER
BY，所有分区行都是对等的）。默认值等同于此框架规范：
RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
由于默认框架因 的存在与否而异ORDER BY，添加ORDER
BY到查询以获得确定性结果可能会改变结果。（例如，由 生成的值
SUM()可能会改变。）要获得相同的结果但按 排序ORDER BY，请提供要使用的显式框架规范，无论是否ORDER BY存在。
当当前行值为 时，框架规范的含义可能不明显NULL。假设是这种情况，这些示例说明了各种框架规范如何应用：
ORDER BY X ASC RANGE BETWEEN 10 FOLLOWING AND 15
FOLLOWING
该框架开始于NULL并停止于
NULL，因此仅包含值为 的行
NULL。
ORDER BY X ASC RANGE BETWEEN 10 FOLLOWING AND
UNBOUNDED FOLLOWING
帧开始于NULL分区的末尾并停止于分区的末尾。因为ASC排序将NULL值放在第一位，所以框架就是整个分区。
ORDER BY X DESC RANGE BETWEEN 10 FOLLOWING AND
UNBOUNDED FOLLOWING
帧开始于NULL分区的末尾并停止于分区的末尾。因为DESC排序将NULL值放在最后，所以框架只是NULL值。
ORDER BY X ASC RANGE BETWEEN 10 PRECEDING AND
UNBOUNDED FOLLOWING
帧开始于NULL分区的末尾并停止于分区的末尾。因为ASC排序将NULL值放在第一位，所以框架就是整个分区。
ORDER BY X ASC RANGE BETWEEN 10 PRECEDING AND 10
FOLLOWING
该框架开始于NULL并停止于
NULL，因此仅包含值为 的行
NULL。
ORDER BY X ASC RANGE BETWEEN 10 PRECEDING AND 1
PRECEDING
该框架开始于NULL并停止于
NULL，因此仅包含值为 的行
NULL。
ORDER BY X ASC RANGE BETWEEN UNBOUNDED PRECEDING
AND 10 FOLLOWING
该帧从分区的开头开始，并在值为 的行处停止NULL。因为
ASC排序将NULL
值放在首位，所以框架只是NULL
值。
© Mysql 中文网
