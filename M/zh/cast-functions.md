# 12.11 转换函数和运算符_MySQL 8.0 参考手册

12.11 转换函数和运算符_MySQL 8.0 参考手册
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
MySQL 8.0 参考手册  / 第 12 章函数和运算符  /
12.11 转换函数和运算符
12.11 转换函数和运算符
表 12.15 转换函数和运算符
姓名
描述
弃用
BINARY
将字符串转换为二进制字符串
8.0.27
CAST()
将值转换为特定类型
CONVERT()
将值转换为特定类型
转换函数和运算符可以将值从一种数据类型转换为另一种数据类型。
Cast 函数和运算符说明字符集转换字符串比较的字符集转换空间类型的转换操作Cast 操作的其他用途
Cast 函数和运算符说明
BINARY
expr
运算符将BINARY表达式转换为二进制字符串（具有
binary字符集和
binary排序规则的字符串）。for 的一个常见用途
BINARY是强制使用数字字节值而不是逐个字符地逐字节进行字符串比较。BINARY运算符还会导致比较中的尾随空格很重要。
有关字符集排序规则与非二进制字符集排序规则之间差异的信息
，
binary请
参阅第 10.8.5 节，“二进制排序规则与 _bin 排序规则的比较”。
binary_bin
该BINARY运算符从 MySQL 8.0.27 开始被弃用，您应该期望在未来版本的 MySQL 中将其删除。改用CAST(... AS
BINARY)。
mysql> SELECT 'a' = 'A';
-> 1
mysql> SELECT BINARY 'a' = 'A';
-> 0
mysql> SELECT 'a' = 'a ';
-> 1
mysql> SELECT BINARY 'a' = 'a ';
-> 0
在比较中，BINARY影响整个操作；它可以在具有相同结果的任一操作数之前给出。
要将字符串表达式转换为二进制字符串，这些结构是等效的：
CONVERT(expr USING BINARY)
CAST(expr AS BINARY)
BINARY expr
如果一个值是一个字符串字面量，它可以指定为一个二进制字符串而不用使用
_binary字符集引入器转换它：
mysql> SELECT 'a' = 'A';
-> 1
mysql> SELECT _binary 'a' = 'A';
-> 0
有关介绍人的信息，请参阅
第 10.3.8 节，“字符集介绍人”。
表达式中的BINARY运算符在效果上不同于
BINARY字符列定义中的属性。对于用
BINARY属性定义的字符列，MySQL 分配表默认字符集和该字符集的二进制 ( _bin) 排序规则。每个非二进制字符集都有一个_bin
排序规则。例如，如果表默认字符集是utf8mb4，则这两个列定义是等效的：
CHAR(10) BINARY
CHAR(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin在、
或
列CHARACTER SET binary的定义中
使用会导致该列被视为相应的二进制字符串数据类型。例如，下面的定义对是等价的：
CHARVARCHARTEXTCHAR(10) CHARACTER SET binary
BINARY(10)
VARCHAR(10) CHARACTER SET binary
VARBINARY(10)
TEXT CHARACTER SET binary
BLOB
如果BINARY从mysql客户端中调用，则二进制字符串使用十六进制表示法显示，具体取决于--binary-as-hex. 有关该选项的更多信息，请参阅
第 4.5.1 节，“mysql — MySQL 命令行客户端”。
CAST(expr AS
type [ARRAY])
CAST(timestamp_value
AT TIME ZONE timezone_specifier
AS
DATETIME[(precision)])
timezone_specifier: [INTERVAL] '+00:00' | '世界标准时间'
使用
语法，
函数采用任何类型的表达式并生成指定类型的结果值。这个操作也可以表示为
，是等价的。如果是
，则返回
。
CAST(expr AS
typeCAST()CONVERT(expr,
type)exprNULLCAST()NULL
这些type值是允许的：
BINARY[(N)]
生成
VARBINARY数据类型为 string 的字符串，但当表达式
expr为空（零长度）时，结果类型为BINARY(0). 如果给出了可选长度N，则
导致转换使用不超过
参数的字节数。短于字节的值用字节填充到长度为. 如果可选长度BINARY(N)NN0x00NN没有给出，MySQL 计算表达式的最大长度。如果提供或计算的长度大于内部阈值，则结果类型为
BLOB. 如果长度仍然太长，则结果类型为LONGBLOB.
有关转换为如何
BINARY影响比较的描述，请参阅
第 11.3.3 节，“BINARY 和 VARBINARY 类型”。
CHAR[(N)]
[charset_info]
生成具有
VARCHAR数据类型的字符串。除了当表达式expr
为空（零长度）时，结果类型为
CHAR(0). 如果给出了可选长度
N，则
导致强制转换使用不超过
参数的字符。对于比字符短的值，不会进行填充
。如果未给出可选长度，MySQL 将根据表达式计算最大长度。如果提供或计算的长度大于内部阈值，则结果类型为
CHAR(N)NNNTEXT. 如果长度仍然太长，则结果类型为LONGTEXT.
如果没有charset_info子句，
CHAR则生成具有默认字符集的字符串。要明确指定字符集，
charset_info允许使用以下值：
CHARACTER SET
charset_name：生成具有给定字符集的字符串。
ASCII: 的简写
CHARACTER SET latin1。
UNICODE: 的简写
CHARACTER SET ucs2。
在所有情况下，字符串都具有字符集默认排序规则。
DATE
产生一个DATE值。
DATETIME[(M)]
产生一个DATETIME
值。如果给出可选M
值，则它指定小数秒精度。
DECIMAL[(M[,D])]
产生一个DECIMAL值。如果给出可选的M和
D值，它们指定最大位数（精度）和小数点后的位数（比例）。如果D省略，则假定为 0。如果M省略，则假定为 10。
DOUBLE
产生一个DOUBLE结果。在 MySQL 8.0.17 中添加。
FLOAT[(p)]
如果未指定精度p，则生成 type 的结果
FLOAT。如果
p提供且 0 <= < p<= 24，则结果的类型为FLOAT. 如果 25 <=
p<= 53，则结果的类型为DOUBLE。如果
p< 0 或
p> 53，则返回错误。在 MySQL 8.0.17 中添加。
JSON
产生一个JSON值。有关值JSON与其他类型之间的值转换规则的详细信息，请参阅JSON 值的比较和排序。
NCHAR[(N)]
与 类似CHAR，但会生成具有国家字符集的字符串。请参阅
第 10.3.7 节，“国家字符集”。
与 不同CHAR，NCHAR
不允许指定尾随字符集信息。
REAL
产生类型的结果
REAL。这实际上是
FLOAT如果
REAL_AS_FLOAT启用了 SQL 模式；否则结果是类型
DOUBLE。
SIGNED [INTEGER]
产生一个带符号的BIGINT
值。
spatial_type
从 MySQL 8.0.24 开始，
CAST()支持
CONVERT()将几何值从一种空间类型转换为另一种空间类型的某些组合。有关详细信息，请参阅
空间类型的转换操作。
TIME[(M)]
产生一个TIME值。如果给出可选M值，则它指定小数秒精度。
UNSIGNED [INTEGER]
产生一个无符号
BIGINT值。
YEAR
产生一个YEAR值。在 MySQL 8.0.22 中添加。这些规则控制转换为
YEAR：
对于 1901-2155 范围内的四位数字，或者可以解释为该范围内的四位数字的字符串，返回相应的YEAR值。
对于由一位或两位数字组成的数字，或者对于可以解释为此类数字的字符串，返回YEAR值如下：
如果数字在 1-69 范围内，则加上 2000 并返回总和。
如果数字在 70-99 范围内，则加上 1900 并返回总和。
对于计算结果为 0 的字符串，返回 2000。
对于数字 0，返回 0。
对于DATE、
DATETIME或
TIMESTAMP值，返回值的YEAR一部分。对于TIME
值，返回当前年份。
如果不指定
TIME参数的类型，您可能会得到与预期不同的结果，如下所示：
mysql> SELECT CAST("11:35:00" AS YEAR), CAST(TIME "11:35:00" AS YEAR);
+--------------------------+-------------------------------+
| CAST("11:35:00" AS YEAR) | CAST(TIME "11:35:00" AS YEAR) |
+--------------------------+-------------------------------+
|                     2011 |                          2021 |
+--------------------------+-------------------------------+
如果参数的类型为
DECIMAL、
DOUBLE、
DECIMAL或
REAL，则将值四舍五入为最接近的整数，然后尝试YEAR使用整数值的规则将该值转换为，如下所示：
mysql> SELECT CAST(1944.35 AS YEAR), CAST(1944.50 AS YEAR);
+-----------------------+-----------------------+
| CAST(1944.35 AS YEAR) | CAST(1944.50 AS YEAR) |
+-----------------------+-----------------------+
|                  1944 |                  1945 |
+-----------------------+-----------------------+
mysql> SELECT CAST(66.35 AS YEAR), CAST(66.50 AS YEAR);
+---------------------+---------------------+
| CAST(66.35 AS YEAR) | CAST(66.50 AS YEAR) |
+---------------------+---------------------+
|                2066 |                2067 |
+---------------------+---------------------+
类型的参数
GEOMETRY不能转换为YEAR。
对于无法成功转换为 的值
YEAR，返回
NULL。
包含必须在转换前截断的非数字字符的字符串值会引发警告，如下所示：
mysql> SELECT CAST("1979aaa" AS YEAR);
+-------------------------+
| CAST("1979aaa" AS YEAR) |
+-------------------------+
|                    1979 |
+-------------------------+
1 row in set, 1 warning (0.00 sec)
mysql> SHOW WARNINGS;
+---------+------+-------------------------------------------+
| Level   | Code | Message                                   |
+---------+------+-------------------------------------------+
| Warning | 1292 | Truncated incorrect YEAR value: '1979aaa' |
+---------+------+-------------------------------------------+
在 MySQL 8.0.17 及更高版本中，
InnoDB允许使用附加ARRAY关键字在数组上创建多值索引JSON
作为CREATE
INDEX、CREATE
TABLE和ALTER
TABLE语句的一部分。ARRAY不支持，除非用于在这些语句之一中创建多值索引，在这种情况下它是必需的。被索引的列必须是 类型的列
JSON。对于ARRAY，
type以下
AS关键字可以指定 支持的任何类型CAST()，但BINARY、JSON和
YEAR. 有关语法信息和示例以及其他相关信息，请参阅
多值索引。
笔记
CONVERT()，不像
CAST()，不
支持多值索引创建或ARRAY关键字。
从 MySQL 8.0.22 开始，CAST()
支持使用运算符检索
TIMESTAMPUTC 中的值AT TIMEZONE。唯一支持的时区是 UTC；这可以指定为 或'+00:00'之一
'UTC'。此语法支持的唯一返回类型是DATETIME，带有 0 到 6（含）范围内的可选精度说明符。
TIMESTAMP还支持使用时区偏移量的值。
mysql> SELECT @@system_time_zone;
+--------------------+
| @@system_time_zone |
+--------------------+
| EDT                |
+--------------------+
1 row in set (0.00 sec)
mysql> CREATE TABLE TZ (c TIMESTAMP);
Query OK, 0 rows affected (0.41 sec)
mysql> INSERT INTO tz VALUES
->     ROW(CURRENT_TIMESTAMP),
->     ROW('2020-07-28 14:50:15+1:00');
Query OK, 1 row affected (0.08 sec)
mysql> TABLE tz;
+---------------------+
| c                   |
+---------------------+
| 2020-07-28 09:22:41 |
| 2020-07-28 09:50:15 |
+---------------------+
2 rows in set (0.00 sec)
mysql> SELECT CAST(c AT TIME ZONE '+00:00' AS DATETIME) AS u FROM tz;
+---------------------+
| u                   |
+---------------------+
| 2020-07-28 13:22:41 |
| 2020-07-28 13:50:15 |
+---------------------+
2 rows in set (0.00 sec)
mysql> SELECT CAST(c AT TIME ZONE 'UTC' AS DATETIME(2)) AS u FROM tz;
+------------------------+
| u                      |
+------------------------+
| 2020-07-28 13:22:41.00 |
| 2020-07-28 13:50:15.00 |
+------------------------+
2 rows in set (0.00 sec)
如果您使用'UTC'这种形式的时区说明符CAST()，并且服务器引发诸如Unknown or incorrect time zone: 'UTC' 之类的错误，您可能需要安装 MySQL 时区表（请参阅
填充时区表）。
AT TIME ZONE不支持
ARRAY关键字，且不受CONVERT()函数支持。
CONVERT(expr
USING transcoding_name)
CONVERT(expr,type)
CONVERT(expr
USING transcoding_name)
是标准的 SQL 语法。的非USING
形式CONVERT()是 ODBC 语法。无论使用何种语法，函数都会返回
NULLif expr
is NULL。
CONVERT(expr
USING transcoding_name)
在不同字符集之间转换数据。在MySQL中，转码名称与对应的字符集名称相同。例如，此语句将'abc'默认字符集中的字符串转换为字符集中对应的字符串
utf8mb4：
SELECT CONVERT('abc' USING utf8mb4);
CONVERT(expr,
type)syntax (without
USING) 采用表达式和
type指定结果类型的值，并生成指定类型的结果值。这个操作也可以表示为
，是等价的。有关详细信息，请参阅 的说明
。
CAST(expr AS
type)CAST()
笔记
在 MySQL 8.0.28 之前，此函数有时允许将
BINARY值无效转换为非二进制字符集。当CONVERT()
用作索引生成列的表达式的一部分时，这可能会导致从以前版本的 MySQL 升级后索引损坏。有关如何处理这种情况的信息，
请参阅
SQL Changes 。
字符集转换
CONVERT()with
USING子句在字符集之间转换数据：
CONVERT(expr USING transcoding_name)
在MySQL中，转码名称与对应的字符集名称相同。
例子：
SELECT CONVERT('test' USING utf8mb4);
SELECT CONVERT(_latin1'Müller' USING utf8mb4);
INSERT INTO utf8mb4_table (utf8mb4_column)
SELECT CONVERT(latin1_column USING utf8mb4) FROM latin1_table;
要在字符集之间转换字符串，您还可以使用
语法（不带
）或
，它们是等效的：
CONVERT(expr,
type)USINGCAST(expr AS
type)CONVERT(string, CHAR[(N)] CHARACTER SET charset_name)
CAST(string AS CHAR[(N)] CHARACTER SET charset_name)
例子：
SELECT CONVERT('test', CHAR CHARACTER SET utf8mb4);
SELECT CAST('test' AS CHAR CHARACTER SET utf8mb4);
如果您像刚才显示的那样指定，则结果的字符集和排序规则是
默认排序规则。如果省略，则结果的字符集和排序
规则由确定默认连接字符集和排序规则的和
系统变量定义（请参阅第 10.4 节，“连接字符集和排序规则”）。
CHARACTER SET
charset_namecharset_namecharset_nameCHARACTER SET
charset_namecharacter_set_connectioncollation_connection或
调用中COLLATE不允许
使用子句，但您可以将其应用于函数结果。例如，这些是合法的：
CONVERT()CAST()SELECT CONVERT('test' USING utf8mb4) COLLATE utf8mb4_bin;
SELECT CONVERT('test', CHAR CHARACTER SET utf8mb4) COLLATE utf8mb4_bin;
SELECT CAST('test' AS CHAR CHARACTER SET utf8mb4) COLLATE utf8mb4_bin;
但这些是非法的：
SELECT CONVERT('test' USING utf8mb4 COLLATE utf8mb4_bin);
SELECT CONVERT('test', CHAR CHARACTER SET utf8mb4 COLLATE utf8mb4_bin);
SELECT CAST('test' AS CHAR CHARACTER SET utf8mb4 COLLATE utf8mb4_bin);
对于字符串文字，另一种指定字符集的方法是使用字符集介绍器。在前面的示例中是介绍人的实例_latin1
。_latin2与
CAST(), 或
CONVERT()等将字符串从一种字符集转换为另一种字符集的转换函数不同，引入符将字符串文字指定为具有特定字符集，不涉及转换。有关详细信息，请参阅
第 10.3.8 节，“字符集介绍人”。
字符串比较的字符集转换
通常，您不能以
BLOB不区分大小写的方式比较值或其他二进制字符串，因为二进制字符串使用的
binary字符集与字母大小写的概念没有排序规则。要执行不区分大小写的比较，首先使用
CONVERT()or
CAST()函数将值转换为非二进制字符串。结果字符串的比较使用它的排序规则。例如，如果转换结果排序规则不区分大小写，
LIKE则操作不区分大小写。对于以下操作也是如此，因为默认utf8mb4排序规则 ( utf8mb4_0900_ai_ci) 不区分大小写：
SELECT 'A' LIKE CONVERT(blob_col USING utf8mb4)
FROM tbl_name;
要为转换后的字符串指定特定的排序规则，请COLLATE在调用后使用一个子句
CONVERT()：
SELECT 'A' LIKE CONVERT(blob_col USING utf8mb4) COLLATE utf8mb4_unicode_ci
FROM tbl_name;
要使用不同的字符集，请将其名称替换为
utf8mb4前面的语句（并且类似地使用不同的归类）。
CONVERT()并且
CAST()可以更普遍地用于比较以不同字符集表示的字符串。例如，比较这些字符串会导致错误，因为它们具有不同的字符集：
mysql> SET @s1 = _latin1 'abc', @s2 = _latin2 'abc';
mysql> SELECT @s1 = @s2;
ERROR 1267 (HY000): Illegal mix of collations (latin1_swedish_ci,IMPLICIT)
and (latin2_general_ci,IMPLICIT) for operation '='
将其中一个字符串转换为与另一个字符串兼容的字符集可以使比较无误地进行：
mysql> SELECT @s1 = CONVERT(@s2 USING latin1);
+---------------------------------+
| @s1 = CONVERT(@s2 USING latin1) |
+---------------------------------+
|                               1 |
+---------------------------------+
字符集转换在二进制字符串的字母大小写转换之前也很有用。
LOWER()并且
UPPER()在直接应用于二进制字符串时无效，因为字母大小写的概念不适用。要执行二进制字符串的字母大小写转换，首先使用适合字符串中存储的数据的字符集将其转换为非二进制字符串：
mysql> SET @str = BINARY 'New York';
mysql> SELECT LOWER(@str), LOWER(CONVERT(@str USING utf8mb4));
+-------------+------------------------------------+
| LOWER(@str) | LOWER(CONVERT(@str USING utf8mb4)) |
+-------------+------------------------------------+
| New York    | new york                           |
+-------------+------------------------------------+
请注意，如果您将BINARY、
CAST()或
CONVERT()应用于索引列，MySQL 可能无法有效地使用索引。
空间类型的转换操作
从 MySQL 8.0.24 开始，CAST()支持
CONVERT()将几何值从一种空间类型转换为另一种空间类型的某些组合。以下列表显示了允许的类型组合，其中“ MySQL 扩展”指定在 MySQL 中实现的转换超出了SQL/MM 标准中定义的转换：
从Point到：
MultiPoint
GeometryCollection
从LineString到：
Polygon（MySQL 扩展）
MultiPoint（MySQL 扩展）
MultiLineString
GeometryCollection
从Polygon到：
LineString（MySQL 扩展）
MultiLineString（MySQL 扩展）
MultiPolygon
GeometryCollection
从MultiPoint到：
Point
LineString（MySQL 扩展）
GeometryCollection
从MultiLineString到：
LineString
Polygon（MySQL 扩展）
MultiPolygon（MySQL 扩展）
GeometryCollection
从MultiPolygon到：
Polygon
MultiLineString（MySQL 扩展）
GeometryCollection
从GeometryCollection到：
Point
LineString
Polygon
MultiPoint
MultiLineString
MultiPolygon
在空间转换中，GeometryCollection和
GeomCollection是同一结果类型的同义词。
某些条件适用于所有空间类型转换，而某些条件仅在转换结果具有特定空间类型时适用。有关
“良构几何”等术语的信息，请参阅
第 11.4.4 节，“几何的良构性和有效性”。
空间投射的一般条件投射到点的条件转换为 LineString 的条件转换为多边形的条件投射到 MultiPoint 的条件转换为 MultiLineString 的条件转换为 MultiPolygon 的条件转换为 GeometryCollection 的条件
空间投射的一般条件
这些条件适用于所有空间投射，无论结果类型如何：
强制转换的结果与要强制转换的表达式位于同一个 SRS 中。
空间类型之间的转换不会改变坐标值或顺序。
如果要转换的表达式是NULL，则函数结果是NULL。
不允许
使用JSON_VALUE()带有指定空间类型的子句的函数
转换为空间类型
。RETURNINGARRAY不允许转换为空间类型
。
如果允许空间类型组合但要转换的表达式不是语法上格式正确的几何图形，
ER_GIS_INVALID_DATA则会发生错误。
如果允许空间类型组合，但要转换的表达式是未定义空间参考系统 (SRS) 中语法上格式正确的几何图形，
ER_SRS_NOT_FOUND则会发生错误。
如果要转换的表达式具有地理 SRS 但经度或纬度超出范围，则会发生错误：
如果经度值不在 (−180, 180] 范围内，
ER_GEOMETRY_PARAM_LONGITUDE_OUT_OF_RANGE
则会发生错误。
如果纬度值不在 [−90, 90] 范围内，
ER_GEOMETRY_PARAM_LATITUDE_OUT_OF_RANGE
则会发生错误。
显示的范围以度为单位。如果 SRS 使用另一个单位，则范围使用其单位中的相应值。由于浮点运算，确切的范围限制略有偏差。
投射到点的条件
当转换结果类型为Point时，以下条件适用：
如果要转换的表达式是类型为 的格式正确的几何
Point，则函数结果为
Point。
如果要转换的表达式是
MultiPoint包含单个
的格式正确的几何类型Point，则函数结果为
Point。如果表达式包含多个Point，
ER_INVALID_CAST_TO_GEOMETRY
则会发生错误。
如果要转换的表达式是
GeometryCollection仅包含单个的格式正确的几何类型Point，则函数结果为
Point。如果表达式为空、包含多个Point或包含其他几何类型，
ER_INVALID_CAST_TO_GEOMETRY
则会发生错误。
如果要转换的表达式是Point,
MultiPoint,
以外类型的格式正确的几何GeometryCollection，
ER_INVALID_CAST_TO_GEOMETRY
则会发生错误。
转换为 LineString 的条件
当转换结果类型为LineString时，以下条件适用：
如果要转换的表达式是类型为 的格式正确的几何
LineString，则函数结果为
LineString。
如果要转换的表达式是
Polygon没有内环的格式正确的几何类型，则函数结果是LineString
包含外环点的相同顺序的。如果表达式有内环，
ER_INVALID_CAST_TO_GEOMETRY
则会发生错误。
如果要转换的表达式是一个格式正确的几何类型，
其类型MultiPoint至少包含两个点，则函数结果是
LineString包含
MultiPoint按它们在表达式中出现的顺序排列的点。如果表达式仅包含一个
Point，
ER_INVALID_CAST_TO_GEOMETRY
则会发生错误。
如果要转换的表达式是
MultiLineString包含单个
的格式正确的几何类型LineString，则函数结果为
LineString。如果表达式包含多个LineString，
ER_INVALID_CAST_TO_GEOMETRY
则会发生错误。
如果要转换的表达式是格式正确的几何类型
GeometryCollection，仅包含一个LineString，则函数结果为LineString。如果表达式为空、包含多个LineString或包含其他几何类型，
ER_INVALID_CAST_TO_GEOMETRY
则会发生错误。
LineString如果要转换的表达式是,
Polygon, MultiPoint,
MultiLineString, 或
以外类型的格式正确的几何，GeometryCollection则会
ER_INVALID_CAST_TO_GEOMETRY
发生错误。
转换为多边形的条件
当转换结果类型为Polygon时，以下条件适用：
如果要转换的表达式是一个格式正确
LineString的环类型几何（即起点和终点相同），则函数结果为 a
Polygon外环由LineString相同顺序的点组成. 如果表达式不是环，
ER_INVALID_CAST_TO_GEOMETRY
则会发生错误。如果环的顺序不正确（外环必须逆时针），
ER_INVALID_CAST_POLYGON_RING_DIRECTION
就会发生错误。
如果要转换的表达式是类型为 的格式正确的几何
Polygon，则函数结果为
Polygon。
如果要转换的表达式是一个格式正确的几何类型
MultiLineString，其中所有元素都是环，则函数结果是 a Polygon
，第一个LineString作为外环，任何其他LineString值作为内环。如果表达式的任何元素不是环，
ER_INVALID_CAST_TO_GEOMETRY
则会发生错误。如果任何环的顺序不正确（外环必须逆时针，内环必须顺时针），
ER_INVALID_CAST_POLYGON_RING_DIRECTION
就会发生错误。
如果要转换的表达式是
MultiPolygon包含单个
的格式正确的几何类型Polygon，则函数结果为
Polygon。如果表达式包含多个Polygon，
ER_INVALID_CAST_TO_GEOMETRY
则会发生错误。
如果要转换的表达式是
GeometryCollection仅包含单个的格式正确的几何类型Polygon，则函数结果为Polygon。如果表达式为空、包含多个Polygon或包含其他几何类型，
ER_INVALID_CAST_TO_GEOMETRY
则会发生错误。
LineString如果要转换的表达式是,
Polygon,
MultiLineString,
MultiPolygon, 或
以外类型的格式正确的几何，GeometryCollection则会
ER_INVALID_CAST_TO_GEOMETRY
发生错误。
投射到 MultiPoint 的条件
当转换结果类型为MultiPoint时，以下条件适用：
如果要转换的表达式是 type 的格式正确的几何图形
Point，则函数结果是
MultiPoint包含它
Point作为其唯一元素的 。
如果要转换的表达式是类型为 的格式正确的几何图形
LineString，则函数结果是
MultiPoint包含
LineString相同顺序的点的 。
如果要转换的表达式是类型为 的格式正确的几何
MultiPoint，则函数结果为
MultiPoint。
如果要转换的表达式是
GeometryCollection仅包含点的格式正确的几何类型，则函数结果是
MultiPoint包含这些点的 。如果GeometryCollection为空或包含其他几何类型，
ER_INVALID_CAST_TO_GEOMETRY
则会发生错误。
Point如果要转换的表达式是、
LineString、
MultiPoint或
以外类型的格式正确的几何，GeometryCollection则会
ER_INVALID_CAST_TO_GEOMETRY
发生错误。
转换为 MultiLineString 的条件
当转换结果类型为MultiLineString时，以下条件适用：
如果要转换的表达式是 type 的格式正确的几何图形
LineString，则函数结果是
MultiLineString包含它
LineString作为其唯一元素的 。
如果要转换的表达式是一个格式正确的几何类型
Polygon，则函数结果是一个
MultiLineString包含的外环Polygon作为其第一个元素，任何内环作为附加元素，按照它们在表达式中出现的顺序。
如果要转换的表达式是类型为 的格式正确的几何
MultiLineString，则函数结果为MultiLineString。
如果要转换的表达式是一个格式正确的几何类型，
其类型MultiPolygon只包含没有内环的多边形，则函数结果是
MultiLineString包含多边形环，它们按照它们在表达式中出现的顺序排列。如果表达式包含任何带内环的多边形，
ER_WRONG_PARAMETERS_TO_STORED_FCT
则会发生错误。
如果要转换的表达式是
GeometryCollection仅包含线串的格式正确的几何类型，则函数结果为
MultiLineString包含这些线串的 。如果表达式为空或包含其他几何类型，
ER_INVALID_CAST_TO_GEOMETRY
则会发生错误。
LineString如果要转换的表达式是,
Polygon,
MultiLineString,
MultiPolygon, 或
以外类型的格式正确的几何，GeometryCollection则会
ER_INVALID_CAST_TO_GEOMETRY
发生错误。
转换为 MultiPolygon 的条件
当转换结果类型为MultiPolygon时，以下条件适用：
如果要转换的表达式是一个格式正确的几何类型
Polygon，则函数结果是一个
MultiPolygon包含
Polygon作为其唯一元素的。
如果要转换的表达式是一个格式正确的几何类型
MultiLineString，其中所有元素都是环，则函数结果是一个
MultiPolygon包含 a
Polygon的表达式的每个元素只有一个外环。如果任何元素不是环，
ER_INVALID_CAST_TO_GEOMETRY
则会发生错误。如果任何环的顺序不正确（外环必须逆时针旋转），
ER_INVALID_CAST_POLYGON_RING_DIRECTION
就会发生错误。
如果要转换的表达式是类型为 的格式正确的几何
MultiPolygon，则函数结果为
MultiPolygon。
如果要转换的表达式是
GeometryCollection仅包含多边形的格式正确的几何类型，则函数结果是
MultiPolygon包含这些多边形的 。如果表达式为空或包含其他几何类型，
ER_INVALID_CAST_TO_GEOMETRY
则会发生错误。
Polygon如果要转换的表达式是、
MultiLineString、
MultiPolygon或
以外类型的格式正确的几何，GeometryCollection则会
ER_INVALID_CAST_TO_GEOMETRY
发生错误。
转换为 GeometryCollection 的条件
当转换结果类型为
GeometryCollection时，以下条件适用：
GeometryCollection并且
GeomCollection是相同结果类型的同义词。
如果要转换的表达式是 type 的格式正确的几何图形
Point，则函数结果是
GeometryCollection包含它
Point作为其唯一元素的 。
如果要转换的表达式是 type 的格式正确的几何图形
LineString，则函数结果是
GeometryCollection包含它
LineString作为其唯一元素的 。
如果要转换的表达式是 type 的格式正确的几何图形
Polygon，则函数结果是
GeometryCollection包含它
Polygon作为其唯一元素的 。
如果要转换的表达式是类型为 的格式正确的几何图形
MultiPoint，则函数结果是
GeometryCollection包含按它们在表达式中出现的顺序排列的点。
如果要转换的表达式是 type 的格式正确的几何图形
MultiLineString，则函数结果是
GeometryCollection包含按它们在表达式中出现的顺序排列的线串。
如果要转换的表达式是类型为 的格式正确的几何图形
MultiPolygon，则函数结果是
GeometryCollection包含元素的元素，这些元素MultiPolygon按照它们在表达式中出现的顺序排列。
如果要转换的表达式是类型为 的格式正确的几何
GeometryCollection，则函数结果为GeometryCollection。
Cast 操作的其他用途
CREATE TABLE ...
SELECT强制转换函数对于在语句
中创建具有特定类型的列很有用
：mysql> CREATE TABLE new_table SELECT CAST('2000-01-01' AS DATE) AS c1;
mysql> SHOW CREATE TABLE new_table\G
*************************** 1. row ***************************
Table: new_table
Create Table: CREATE TABLE `new_table` (
`c1` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4
强制转换函数对于按
ENUM词法顺序对列进行排序很有用。ENUM通常，使用内部数值对列进行排序。将值转换
CHAR为词法排序结果：
SELECT enum_col FROM tbl_name ORDER BY CAST(enum_col AS CHAR);
CAST()如果将结果用作更复杂的表达式（例如 .）的一部分，也会更改结果
CONCAT('Date: ',CAST(NOW() AS
DATE))。
对于时间值，几乎不需要使用
CAST()不同格式的数据来提取。相反，请使用诸如
EXTRACT()、
DATE_FORMAT()或
之类的函数TIME_FORMAT()。请参阅
第 12.7 节，“日期和时间函数”。
要将字符串转换为数字，通常在数字上下文中使用字符串值就足够了：
mysql> SELECT 1+'1';
-> 2
对于默认情况下为二进制字符串的十六进制和位文字也是如此：
mysql> SELECT X'41', X'41'+0;
-> 'A', 65
mysql> SELECT b'1100001', b'1100001'+0;
-> 'a', 97
算术运算中使用的字符串在表达式求值期间转换为浮点数。
字符串上下文中使用的数字转换为字符串：
mysql> SELECT CONCAT('hello you ',2);
-> 'hello you 2'
有关将数字隐式转换为字符串的信息，请参阅第 12.3 节，“表达式求值中的类型转换”。
MySQL 支持带符号和无符号 64 位值的算术。对于其中一个操作数是无符号整数的数字运算符（例如
+or
），默认情况下结果是无符号的（请参阅第 12.6.1 节，“算术运算符”）。要覆盖它，请使用or
cast 运算符分别将值转换为有符号或无符号的 64 位整数。
-SIGNEDUNSIGNEDmysql> SELECT 1 - 2;
-> -1
mysql> SELECT CAST(1 - 2 AS UNSIGNED);
-> 18446744073709551615
mysql> SELECT CAST(CAST(1 - 2 AS UNSIGNED) AS SIGNED);
-> -1
如果任一操作数是浮点值，则结果是浮点值并且不受前面规则的影响。（在此上下文中，DECIMAL列值被视为浮点值。）
mysql> SELECT CAST(1 AS UNSIGNED) - 2.0;
-> -1.0
SQL 模式会影响转换操作的结果（请参阅
第 5.1.11 节，“服务器 SQL 模式”）。例子：
用于将“零”日期字符串转换为日期，CONVERT()并
在启用 SQL 模式
时CAST()返回
NULL并产生警告
。NO_ZERO_DATE
对于整数减法，如果
NO_UNSIGNED_SUBTRACTION
启用了SQL模式，即使任何操作数是无符号的，减法结果也是有符号的。
© Mysql 中文网
