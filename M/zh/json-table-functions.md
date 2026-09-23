# 12.18.6 JSON 表函数_MySQL 8.0 参考手册

12.18.6 JSON 表函数_MySQL 8.0 参考手册
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
12.17.1 空间函数参考1
12.17.2 空间函数的参数处理1
12.17.3 从 WKT 值创建几何值的函数1
12.17.4 从 WKB 值创建几何值的函数1
12.17.5 创建几何值的 MySQL 特定函数1
12.17.6 几何格式转换函数1
12.17.7 几何属性函数1
12.17.8 空间算子函数1
12.17.9 测试几何对象之间空间关系的函数1
12.17.10 空间 Geohash 函数1
12.17.11 空间 GeoJSON 函数1
12.18.1 JSON函数参考
12.18.2 创建 JSON 值的函数
12.18.3 搜索 JSON 值的函数
12.18.4 修改 JSON 值的函数
12.18.5 返回 JSON 值属性的函数
12.18.6 JSON 表函数
12.18.7 JSON 模式验证函数
12.18.8 JSON 实用函数
12.17.12 空间聚合函数1
12.17.13 空间便利功能1
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
MySQL 8.0 参考手册  / 第 12 章函数和运算符  / 12.17空间分析函数  / 12.17.11 空间 GeoJSON 函数  /
12.18.6 JSON 表函数
12.18.6 JSON 表函数
本部分包含有关将 JSON 数据转换为表格数据的 JSON 函数的信息。MySQL 8.0 支持这样一种功能，JSON_TABLE().
JSON_TABLE(expr,
path COLUMNS
(column_list) [AS]
alias)
从 JSON 文档中提取数据并将其作为具有指定列的关系表返回。此函数的完整语法如下所示：
JSON_TABLE(
expr,
path COLUMNS (column_list)
)   [AS] alias
column_list:
column[, column][, ...]
column:
name FOR ORDINALITY
|  name type PATH string path [on_empty] [on_error]
|  name type EXISTS PATH string path
|  NESTED [PATH] path COLUMNS (column_list)
on_empty:
{NULL | DEFAULT json_string | ERROR} ON EMPTY
on_error:
{NULL | DEFAULT json_string | ERROR} ON ERROR
expr：这是一个返回 JSON 数据的表达式。这可以是常量 ( '{"a":1}')、列（ ，在子句之前指定
的t1.json_data给定表
）或函数调用 ( )。
t1JSON_TABLE()FROMJSON_EXTRACT(t1.json_data,'$.post.comments')
path：JSON路径表达式，应用于数据源。我们将匹配路径的 JSON 值称为行源；这用于生成一行关系数据。该COLUMNS
子句评估行源，在行源中查找特定的 JSON 值，并将这些 JSON 值作为关系数据行的各个列中的 SQL 值返回。
alias是必需
的。适用表别名的常用规则（请参阅第 9.2 节，“模式对象名称”）。
从 MySQL 8.0.27 开始，此函数以不区分大小写的方式比较列名。
JSON_TABLE()支持四种类型的列，如下表所述：
name FOR
ORDINALITY：此类型枚举
COLUMNS子句中的行；column named
name是一个计数器，类型为
UNSIGNED INT，初始值为1。这相当于
AUTO_INCREMENT在
CREATE TABLE语句中指定一列，可以用于区分NESTED [PATH]
子句生成的多行具有相同值的父行。
name
type PATH
string_path
[on_empty]
[on_error]：这种类型的列用于提取指定的值
string_path。
type是 MySQL 标量数据类型（也就是说，它不能是对象或数组）。
JSON_TABLE()将数据提取为 JSON，然后使用适用于 MySQL 中 JSON 数据的常规自动类型转换将其强制转换为列类型。缺失值会触发on_empty子句。保存对象或数组会触发可选
on error子句；当从保存为 JSON 的值到表列的强制转换过程中发生错误时，也会发生这种情况，例如尝试将字符串保存
'asd'到整数列。
name
type EXISTS PATH
path：如果 指定的位置存在任何数据，则此列返回 1，否则返回
path0。
type可以是任何有效的 MySQL 数据类型，但通常应指定为
INT.
NESTED [PATH] path COLUMNS
(column_list)：这会将 JSON 数据中的嵌套对象或数组与来自父对象或数组的 JSON 值展平为一行。使用多个PATH选项允许将 JSON 值从多个嵌套级别投影到单个行中。
是相对于的path父路径行路径JSON_TABLE()，或者在NESTED [PATH]嵌套路径的情况下父子句的路径。
on empty，如果指定，确定
JSON_TABLE()在数据丢失的情况下做什么（取决于类型）。NESTED PATH当子句没有匹配项并NULL为其生成补充行时，也会在子句中的列上触发此子句。on empty采用以下值之一：
NULL ON EMPTY：该列设置为
NULL；这是默认行为。
DEFAULT json_string ON
EMPTY：提供
json_string的被解析为JSON，只要它是有效的，并存储而不是缺失值。列类型规则也适用于默认值。
ERROR ON EMPTY: 抛出错误。
如果使用，on_error则采用以下值之一以及相应的结果，如下所示：
NULL ON ERROR：该列设置为
NULL；这是默认行为。
DEFAULT json string ON
ERROR:json_string被解析为 JSON（前提是它有效）并存储而不是对象或数组。
ERROR ON ERROR: 抛出错误。
NULL ON ERROR在 MySQL 8.0.20 之前，如果指定或
DEFAULT ... ON ERROR暗示
发生类型转换错误，则会引发警告。在 MySQL 8.0.20 及更高版本中，情况不再如此。（缺陷号 30628330）
以前，可以按任一顺序指定ON EMPTY
和ON ERROR子句。这与 SQL 标准背道而驰，SQL 标准规定ON
EMPTY，如果指定，则必须在任何ON
ERROR子句之前。为此，从 MySQL 8.0.20 开始，不推荐使用ON ERRORbefore指定ON
EMPTY；尝试这样做会导致服务器发出警告。期望在未来版本的 MySQL 中删除对非标准语法的支持。
当保存到列的值被截断时，例如在列中保存 3.14159，将独立于任何选项DECIMAL(10,1)发出警告。ON
ERROR当多个值在单个语句中被截断时，警告只会发出一次。
在 MySQL 8.0.21 之前，当传递给此函数的表达式和路径解析为 JSON null 时，会JSON_TABLE()
引发错误。在 MySQL 8.0.21 及更高版本中，它会
NULL根据 SQL 标准在这种情况下返回 SQL，如下所示（错误 #31345503，错误 #99557）：
mysql> SELECT *
->   FROM
->     JSON_TABLE(
->       '[ {"c1": null} ]',
->       '$[*]' COLUMNS( c1 INT PATH '$.c1' ERROR ON ERROR )
->     ) as jt;
+------+
| c1   |
+------+
| NULL |
+------+
1 row in set (0.00 sec)
以下查询演示了ON
EMPTYand的使用ON ERROR。对于 path对应的行{"b":1}是空的
"$.a"，尝试另存
[1,2]为标量会产生错误；这些行在显示的输出中突出显示。
mysql> SELECT *
-> FROM
->   JSON_TABLE(
->     '[{"a":"3"},{"a":2},{"b":1},{"a":0},{"a":[1,2]}]',
->     "$[*]"
->     COLUMNS(
->       rowid FOR ORDINALITY,
->       ac VARCHAR(100) PATH "$.a" DEFAULT '111' ON EMPTY DEFAULT '999' ON ERROR,
->       aj JSON PATH "$.a" DEFAULT '{"x": 333}' ON EMPTY,
->       bx INT EXISTS PATH "$.b"
->     )
->   ) AS tt;
+-------+------+------------+------+
| rowid | ac   | aj         | bx   |
+-------+------+------------+------+
|     1 | 3    | "3"        |    0 |
|     2 | 2    | 2          |    0 |
|     3 | 111  | {"x": 333} |    1 |
|     4 | 0    | 0          |    0 |
|     5 | 999  | [1, 2]     |    0 |
+-------+------+------------+------+
5 rows in set (0.00 sec)
列名受管理表列名的通常规则和限制的约束。请参阅第 9.2 节，“模式对象名称”。
检查所有 JSON 和 JSON 路径表达式的有效性；任一类型的无效表达式都会导致错误。
path前面
关键字
的每个匹配都COLUMNS映射到结果表中的单独一行。例如，以下查询给出此处显示的结果：
mysql> SELECT *
-> FROM
->   JSON_TABLE(
->     '[{"x":2,"y":"8"},{"x":"3","y":"7"},{"x":"4","y":6}]',
->     "$[*]" COLUMNS(
->       xval VARCHAR(100) PATH "$.x",
->       yval VARCHAR(100) PATH "$.y"
->     )
->   ) AS  jt1;
+------+------+
| xval | yval |
+------+------+
| 2    | 8    |
| 3    | 7    |
| 4    | 6    |
+------+------+
该表达式"$[*]"匹配数组的每个元素。您可以通过修改路径来过滤结果中的行。例如，使用"$[1]"将提取限制为用作源的 JSON 数组的第二个元素，如下所示：
mysql> SELECT *
-> FROM
->   JSON_TABLE(
->     '[{"x":2,"y":"8"},{"x":"3","y":"7"},{"x":"4","y":6}]',
->     "$[1]" COLUMNS(
->       xval VARCHAR(100) PATH "$.x",
->       yval VARCHAR(100) PATH "$.y"
->     )
->   ) AS  jt1;
+------+------+
| xval | yval |
+------+------+
| 3    | 7    |
+------+------+
在列定义中，"$"将整个匹配项传递给该列；"$.x"并
"$.y"仅传递对应于该匹配项中的键x和的值。y有关详细信息，请参阅
JSON 路径语法。
NESTED PATH（或简单地
NESTED;是可选的）为它所属PATH的子句中的每个匹配项生成一组记录
。COLUMNS如果没有匹配项，则嵌套路径的所有列都设置为
NULL。这实现了最顶层子句和 之间的外部连接NESTED [PATH]。可以通过在子句中应用合适的条件来模拟内部联接
WHERE，如下所示：
mysql> SELECT *
-> FROM
->   JSON_TABLE(
->     '[ {"a": 1, "b": [11,111]}, {"a": 2, "b": [22,222]}, {"a":3}]',
->     '$[*]' COLUMNS(
->             a INT PATH '$.a',
->             NESTED PATH '$.b[*]' COLUMNS (b INT PATH '$')
->            )
->    ) AS jt
-> WHERE b IS NOT NULL;
+------+------+
| a    | b    |
+------+------+
|    1 |   11 |
|    1 |  111 |
|    2 |   22 |
|    2 |  222 |
+------+------+NESTED [PATH]同级嵌套路径——即同一子句中的
两个或多个实例
COLUMNS——一个接一个地处理，一次一个。当一个嵌套路径生成记录时，任何同级嵌套路径表达式的列都设置为
NULL。这意味着单个包含子句中单个匹配项的记录总数
是修饰符COLUMNS生成的所有记录的总和，而不是其乘积NESTED [PATH]
，如下所示：
mysql> SELECT *
-> FROM
->   JSON_TABLE(
->     '[{"a": 1, "b": [11,111]}, {"a": 2, "b": [22,222]}]',
->     '$[*]' COLUMNS(
->         a INT PATH '$.a',
->         NESTED PATH '$.b[*]' COLUMNS (b1 INT PATH '$'),
->         NESTED PATH '$.b[*]' COLUMNS (b2 INT PATH '$')
->     )
-> ) AS jt;
+------+------+------+
| a    | b1   | b2   |
+------+------+------+
|    1 |   11 | NULL |
|    1 |  111 | NULL |
|    1 | NULL |   11 |
|    1 | NULL |  111 |
|    2 |   22 | NULL |
|    2 |  222 | NULL |
|    2 | NULL |   22 |
|    2 | NULL |  222 |
+------+------+------+
列FOR ORDINALITY枚举子句产生的记录COLUMNS，可用于区分嵌套路径的父记录，尤其是当父记录中的值相同时，如下所示：
mysql> SELECT *
-> FROM
->   JSON_TABLE(
->     '[{"a": "a_val",
'>       "b": [{"c": "c_val", "l": [1,2]}]},
'>     {"a": "a_val",
'>       "b": [{"c": "c_val","l": [11]}, {"c": "c_val", "l": [22]}]}]',
->     '$[*]' COLUMNS(
->       top_ord FOR ORDINALITY,
->       apath VARCHAR(10) PATH '$.a',
->       NESTED PATH '$.b[*]' COLUMNS (
->         bpath VARCHAR(10) PATH '$.c',
->         ord FOR ORDINALITY,
->         NESTED PATH '$.l[*]' COLUMNS (lpath varchar(10) PATH '$')
->         )
->     )
-> ) as jt;
+---------+---------+---------+------+-------+
| top_ord | apath   | bpath   | ord  | lpath |
+---------+---------+---------+------+-------+
|       1 |  a_val  |  c_val  |    1 | 1     |
|       1 |  a_val  |  c_val  |    1 | 2     |
|       2 |  a_val  |  c_val  |    1 | 11    |
|       2 |  a_val  |  c_val  |    2 | 22    |
+---------+---------+---------+------+-------+
源文档包含两个元素的数组；这些元素中的每一个都产生两行。apath和的值
bpath在整个结果集中都是相同的；这意味着它们不能用于确定lpath值是否来自相同或不同的父母。该ord
列的值与等于 1 的记录集保持相同
top_ord，因此这两个值来自单个对象。其余两个值来自不同的对象，因为它们在
ord列中具有不同的值。
通常，您不能连接依赖于同一FROM子句中前面表的列的派生表。根据 SQL 标准，MySQL 对表函数进行了例外处理；这些被认为是横向派生表，即使在尚不支持该
LATERAL关键字的 MySQL 版本（8.0.13 及更早版本）中也是如此。在LATERAL支持的版本（8.0.14 及更高版本）中，它是隐式的，因此之前也是不允许
JSON_TABLE()的，也是根据标准。
假设您t1使用此处显示的语句创建并填充了一个表：
CREATE TABLE t1 (c1 INT, c2 CHAR(1), c3 JSON);
INSERT INTO t1 () VALUES
ROW(1, 'z', JSON_OBJECT('a', 23, 'b', 27, 'c', 1)),
ROW(1, 'y', JSON_OBJECT('a', 44, 'b', 22, 'c', 11)),
ROW(2, 'x', JSON_OBJECT('b', 1, 'c', 15)),
ROW(3, 'w', JSON_OBJECT('a', 5, 'b', 6, 'c', 7)),
ROW(5, 'v', JSON_OBJECT('a', 123, 'c', 1111))
;
然后您可以执行连接，例如这个连接，它
JSON_TABLE()充当派生表，同时它引用先前引用的表中的列：
SELECT c1, c2, JSON_EXTRACT(c3, '$.*')
FROM t1 AS m
JOIN
JSON_TABLE(
m.c3,
'$.*'
COLUMNS(
at VARCHAR(10) PATH '$.a' DEFAULT '1' ON EMPTY,
bt VARCHAR(10) PATH '$.b' DEFAULT '2' ON EMPTY,
ct VARCHAR(10) PATH '$.c' DEFAULT '3' ON EMPTY
)
) AS tt
ON m.c1 > tt.at;
尝试将LATERAL关键字与此查询一起使用会引发ER_PARSE_ERROR。
© Mysql 中文网
