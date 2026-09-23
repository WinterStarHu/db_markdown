# 13.2.10 SELECT 语句_MySQL 8.0 参考手册

13.2.10 SELECT 语句_MySQL 8.0 参考手册
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
13.2.10.1 SELECT ... INTO 语句
13.2.10.2 JOIN 子句
13.2.10.3 UNION 子句
13.2.10.4 INTERSECT 子句
13.2.10.5 EXCEPT 子句
13.2.10.6 带括号的查询表达式
13.2.11 子查询1
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
13.2.10 SELECT 语句
13.2.10 SELECT 语句
13.2.10.1 SELECT ... INTO 语句13.2.10.2 JOIN 子句13.2.10.3 UNION 子句13.2.10.4 INTERSECT 子句13.2.10.5 EXCEPT 子句13.2.10.6 带括号的查询表达式
SELECT
[ALL | DISTINCT | DISTINCTROW ]
[HIGH_PRIORITY]
[STRAIGHT_JOIN]
[SQL_SMALL_RESULT] [SQL_BIG_RESULT] [SQL_BUFFER_RESULT]
[SQL_NO_CACHE] [SQL_CALC_FOUND_ROWS]
select_expr [, select_expr] ...
[into_option]
[FROM table_references
[PARTITION partition_list]]
[WHERE where_condition]
[GROUP BY {col_name | expr | position}, ... [WITH ROLLUP]]
[HAVING where_condition]
[WINDOW window_name AS (window_spec)
[, window_name AS (window_spec)] ...]
[ORDER BY {col_name | expr | position}
[ASC | DESC], ... [WITH ROLLUP]]
[LIMIT {[offset,] row_count | row_count OFFSET offset}]
[into_option]
[FOR {UPDATE | SHARE}
[OF tbl_name [, tbl_name] ...]
[NOWAIT | SKIP LOCKED]
| LOCK IN SHARE MODE]
[into_option]
into_option: {
INTO OUTFILE 'file_name'
[CHARACTER SET charset_name]
export_options
| INTO DUMPFILE 'file_name'
| INTO var_name [, var_name] ...
}
SELECT用于检索从一个或多个表中选择的行，并且可以包括
UNION操作和子查询。从MySQL 8.0.31开始，
INTERSECT也
EXCEPT支持操作。、UNION和
运算符将在本节后面进行更详细的描述INTERSECT。EXCEPT另见第 13.2.11 节，“子查询”。
SELECT语句可以以子句开头，
以WITH定义可在
SELECT. 请参阅第 13.2.15 节，“WITH（公用表表达式）”。
最常用的
SELECT语句子句是：
每个都select_expr表示您要检索的列。必须至少有一个
select_expr。
table_references指示要从中检索行的一个或多个表。它的语法在第 13.2.10.2 节，“JOIN 子句”中描述。
SELECTPARTITION支持使用带有分区列表或子分区（或两者）
的子句的显式分区选择，这些子句跟在 a 中的表名之后table_reference（请参阅
第 13.2.10.2 节，“JOIN 子句”）。在这种情况下，仅从列出的分区中选择行，而忽略表的任何其他分区。有关更多信息和示例，请参阅
第 24.5 节，“分区选择”。
该WHERE子句（如果给定）指示要选择行必须满足的一个或多个条件。
where_condition是一个表达式，对于要选择的每一行计算结果为真。如果没有
WHERE子句，该语句将选择所有行。
在WHERE表达式中，您可以使用 MySQL 支持的任何函数和运算符，但聚合（组）函数除外。请参阅
第 9.5 节，“表达式”和
第 12 章，函数和运算符。
SELECT也可用于检索在未引用任何表的情况下计算的行。
例如：
mysql> SELECT 1 + 1;
-> 2
在没有引用表的情况下，您可以指定DUAL为虚拟表名：
mysql> SELECT 1 + 1 FROM DUAL;
-> 2
DUAL纯粹是为了方便那些要求所有SELECT
语句都应该有FROM并且可能还有其他子句的人。MySQL 可能会忽略这些子句。FROM DUAL如果没有引用表，则
MySQL 不需要
。
通常，使用的子句必须完全按照语法描述中显示的顺序给出。例如，
HAVING子句必须位于任何子句之后
GROUP BY和任何子句之前ORDER
BY。该INTO子句（如果存在）可以出现在语法描述指示的任何位置，但在给定语句中只能出现一次，不能出现在多个位置。有关 的更多信息
INTO，请参阅第 13.2.10.1 节，“SELECT ... INTO 语句”。
术语列表select_expr包含指示要检索哪些列的选择列表。术语指定列或表达式，或者可以使用
*-shorthand：
只包含一个非限定的选择列表
*可以用作从所有表中选择所有列的速记：
SELECT * FROM t1 INNER JOIN t2 ...
tbl_name.*可以用作限定速记来从命名表中选择所有列：
SELECT t1.*, t2.* FROM t1 INNER JOIN t2 ...
如果一个表有不可见的列，*不要
tbl_name.*包含它们。要包含在内，必须明确引用不可见的列。
对选择列表中的其他项目使用不合格*可能会产生分析错误。例如：
SELECT id, * FROM t1
为避免此问题，请使用合格的
tbl_name.*
参考：
SELECT id, t1.* FROM t1tbl_name.*
对选择列表中的每个表
使用限定
引用：SELECT AVG(score), t1.* FROM t1 ...
以下列表提供了有关其他
SELECT条款的附加信息：
select_expr可以使用 给
A一个别名。别名用作表达式的列名，可用于
、或
子句中。例如：
AS
alias_nameGROUP BYORDER BYHAVINGSELECT CONCAT(last_name,', ',first_name) AS full_name
FROM mytable ORDER BY full_name;当使用标识符为 a 别名时，
该AS关键字是可选
的。select_expr前面的例子可以这样写：
SELECT CONCAT(last_name,', ',first_name) full_name
FROM mytable ORDER BY full_name;
然而，因为AS是可选的，如果您忘记了两个
select_expr表达式之间的逗号，就会出现一个微妙的问题：MySQL 将第二个解释为别名。例如，在以下语句中，columnb被视为别名：
SELECT columna columnb FROM mytable;AS出于这个原因，在指定列别名时养成显式
使用的习惯是很好的做法。
不允许在子句中引用列别名
WHERE，因为在执行子句时列值可能尚未确定WHERE
。请参阅第 B.3.4.4 节，“列别名的问题”。
该子句指示要从中检索行的一个或多个表。如果您命名多个表，则您正在执行连接。有关连接语法的信息，请参阅第 13.2.10.2 节，“JOIN 子句”。对于每个指定的表，您可以选择指定一个别名。
FROM
table_referencestbl_name [[AS] alias] [index_hint]
索引提示的使用为优化器提供了有关如何在查询处理期间选择索引的信息。有关指定这些提示的语法的描述，请参阅
第 8.9.4 节，“索引提示”。
您可以使用
另一种方法来强制 MySQL 更喜欢键扫描而不是表扫描。请参阅
第 5.1.8 节，“服务器系统变量”。
SET
max_seeks_for_key=value
您可以将默认数据库中的表引用为
tbl_name或
db_name。tbl_name
明确指定数据库。您可以将列称为
col_name,
tbl_name。col_name, 或者
db_name. tbl_name. col_name. 您无需指定tbl_name或
db_name。tbl_name
列引用的前缀，除非引用不明确。有关需要更明确的列引用形式的歧义示例，
请参见第 9.2.2 节，“标识符限定符” 。
可以使用
或
为表引用起别名。这些语句是等价的：
tbl_name AS
alias_nametbl_name alias_nameSELECT t1.name, t2.salary FROM employee AS t1, info AS t2
WHERE t1.name = t2.name;
SELECT t1.name, t2.salary FROM employee t1, info t2
WHERE t1.name = t2.name;
可以使用列名、列别名或列位置在ORDER BY和子句
中引用为输出选择的
列。GROUP BY列位置是整数并以 1 开头：
SELECT college, region, seed FROM tournament
ORDER BY region, seed;
SELECT college, region AS r, seed AS s FROM tournament
ORDER BY r, s;
SELECT college, region, seed FROM tournament
ORDER BY 2, 3;
要以相反的顺序排序，请将（降序）关键字添加到您作为排序依据DESC
的子句中的列的名称
。ORDER BY默认为升序；这可以使用ASC关键字明确指定。
如果ORDER BY出现在带括号的查询表达式中并且也应用于外部查询，则结果是未定义的，并且可能会在未来版本的 MySQL 中发生变化。
不推荐使用列位置，因为该语法已从 SQL 标准中删除。
在 MySQL 8.0.13 之前，MySQL 支持非标准语法扩展，允许显式ASC或
列DESC指示符GROUP
BY。MySQL 8.0.12及以后版本支持
ORDER BYwith分组功能，不再需要使用该扩展。（Bug #86312，Bug #26073525）这也意味着您可以在使用时对任意一列或多列进行排序GROUP BY，如下所示：
SELECT a, b, COUNT(c) AS t FROM test_table GROUP BY a,b ORDER BY a,t DESC;
从 MySQL 8.0.13 开始，GROUP BY不再支持扩展：ASC或者
不允许列的
DESC指示符。GROUP
BY
当您使用ORDER BY或GROUP
BY对 a 中的列进行排序时
，服务器仅使用系统变量
SELECT指示的初始字节数对值进行排序
。max_sort_length
MySQL 扩展了使用以允许选择子句GROUP BY中未提及的字段。GROUP
BY如果您没有从查询中获得预期的结果，请阅读
第 12.20 节“聚合函数”GROUP BY中
的说明。
GROUP BY允许WITH
ROLLUP修饰符。请参阅
第 12.20.2 节，“GROUP BY 修饰符”。
以前，不允许ORDER
BY在具有WITH
ROLLUP修饰符的查询中使用。这个限制从 MySQL 8.0.12 开始解除。请参阅第 12.20.2 节，“GROUP BY 修饰符”。
该HAVING子句与
WHERE子句一样，指定选择条件。该WHERE子句指定选择列表中列的条件，但不能引用聚合函数。该HAVING子句指定组的条件，通常由该
GROUP BY子句构成。查询结果只包含满足HAVING
条件的组。（如果不GROUP BY存在，所有行隐含地形成一个聚合组。）
该HAVING子句几乎最后应用，就在项目发送给客户端之前，没有优化。（LIMIT在 之后应用
HAVING。）
SQL 标准要求HAVING必须仅引用GROUP BY
子句中的列或聚合函数中使用的列。但是，MySQL 支持对此行为的扩展，并允许
HAVING引用列表中的
SELECT列和外部子查询中的列。
如果HAVING子句引用的列不明确，则会出现警告。在以下语句中，col2是不明确的，因为它既用作别名又用作列名：
SELECT COUNT(col1) AS col2 FROM t GROUP BY col2 HAVING col2 = 2;
优先考虑标准 SQL 行为，因此如果
在选择列列表HAVING中同时使用列名称
GROUP BY和作为别名列，则优先考虑列中的
GROUP BY列。
不要HAVING用于应该在WHERE子句中的项目。例如，不要写以下内容：
SELECT col_name FROM tbl_name HAVING col_name > 0;
改为这样写：
SELECT col_name FROM tbl_name WHERE col_name > 0;
该HAVING子句可以引用聚合函数，但该WHERE子句不能：
SELECT user, MAX(salary) FROM users
GROUP BY user HAVING MAX(salary) > 10;
（这在某些旧版本的 MySQL 中不起作用。）
MySQL 允许重复的列名。也就是说，可以有多个select_expr同名的。这是对标准 SQL 的扩展。因为 MySQL 也允许GROUP BY和
HAVING引用
select_expr值，这会导致歧义：
SELECT 12 AS a, a FROM t GROUP BY a;
在该语句中，两列的名称都是
a. 为确保使用正确的列进行分组，请为每个使用不同的名称
select_expr。
该WINDOW子句（如果存在）定义可由窗口函数引用的命名窗口。有关详细信息，请参阅第 12.21.4 节，“命名窗口”。
ORDER BYMySQL通过在
select_expr值中搜索，然后在子句中的表的列中搜索来
解析子句中的不合格列或别名引用
FROM。对于GROUP BYorHAVING
子句，它在搜索
值FROM之前先搜索子句。select_expr（对于GROUP BY和
HAVING，这不同于使用与 for 相同规则的 MySQL 5.0 之前的行为ORDER
BY。）
该LIMIT子句可用于限制
SELECT语句返回的行数。
LIMIT接受一个或两个数字参数，它们必须都是非负整数常量，但以下情况除外：
在准备好的语句中，LIMIT
可以使用?
占位符标记指定参数。
在存储的程序中，LIMIT
可以使用整数值例程参数或局部变量来指定参数。
有两个参数，第一个参数指定要返回的第一行的偏移量，第二个参数指定要返回的最大行数。初始行的偏移量为 0（不是 1）：
SELECT * FROM tbl LIMIT 5,10;  # Retrieve rows 6-15
要检索从某个偏移量到结果集末尾的所有行，您可以为第二个参数使用一些较大的数字。此语句检索从第 96 行到最后一行的所有行：
SELECT * FROM tbl LIMIT 95,18446744073709551615;
使用一个参数，该值指定从结果集开头返回的行数：
SELECT * FROM tbl LIMIT 5;     # Retrieve first 5 rows
换句话说，相当于.
LIMIT
row_countLIMIT 0,
row_count
对于准备好的语句，您可以使用占位符。以下语句从表中返回一行
tbl：
SET @a=1;
PREPARE STMT FROM 'SELECT * FROM tbl LIMIT ?';
EXECUTE STMT USING @a;
以下语句返回表中的第二行到第六行tbl：
SET @skip=1; SET @numrows=5;
PREPARE STMT FROM 'SELECT * FROM tbl LIMIT ?, ?';
EXECUTE STMT USING @skip, @numrows;
为了与 PostgreSQL 兼容，MySQL 也支持该
语法。
LIMIT row_count OFFSET
offset
如果LIMIT出现在带括号的查询表达式中并且也应用于外部查询，则结果是未定义的，并且可能会在未来版本的 MySQL 中发生变化。
的SELECT ...
INTO形式SELECT
使查询结果可以写入文件或存储在变量中。有关详细信息，请参阅
第 13.2.10.1 节，“SELECT ... INTO 语句”。
如果FOR UPDATE与使用页锁或行锁的存储引擎一起使用，则查询检查的行将被写锁定，直到当前事务结束。
您不能将FOR UPDATE用作语句的一部分，
SELECT例如
. （如果您尝试这样做，该语句将被拒绝并显示错误
Can't update table ' ' while ' ' is being created。）
CREATE
TABLE new_table SELECT ... FROM
old_table ...old_tablenew_table
FOR SHARE并LOCK IN SHARE
MODE设置允许其他事务读取检查的行但不允许更新或删除它们的共享锁。
FOR SHARE并且LOCK IN SHARE
MODE是等价的。但是，FOR
SHARE与 一样FOR UPDATE，支持
NOWAIT、SKIP LOCKED和
选项。是 的替代品
，但仍可用于向后兼容。
OF tbl_nameFOR SHARELOCK IN SHARE MODELOCK IN
SHARE MODE
NOWAIT导致FOR
UPDATEorFOR SHARE查询立即执行，如果由于另一个事务持有锁而无法获得行锁，则返回错误。
SKIP LOCKED导致FOR
UPDATEorFOR SHARE查询立即执行，排除结果集中被另一个事务锁定的行。
NOWAIT和SKIP LOCKED
选项对于基于语句的复制是不安全的。
笔记
跳过锁定行的查询返回不一致的数据视图。SKIP LOCKED因此不适合一般事务性工作。但是，当多个会话访问同一个类似队列的表时，它可用于避免锁争用。
OF tbl_name对命名表
应用FOR UPDATE和查询。FOR
SHARE例如：
SELECT * FROM t1, t2 FOR SHARE OF t1 FOR UPDATE OF t2;省略
时，查询块引用的所有表都将被锁定
。因此，
在不与另一个锁定子句组合的情况下使用锁定子句会返回错误。在多个锁定子句中指定同一个表会返回错误。如果在语句中将别名指定为表名，则
锁定子句只能使用别名。如果语句没有明确指定别名，锁定子句可能只指定实际的表名。
OF tbl_nameOF tbl_nameSELECTSELECT
有关FOR UPDATE和
的更多信息FOR SHARE，请参阅
第 15.7.2.4 节，“锁定读取”。有关其他信息NOWAIT和SKIP
LOCKED选项，请
参阅使用 NOWAIT 和 SKIP LOCKED 锁定读取并发。
在SELECT关键字之后，您可以使用一些影响语句操作的修饰符。HIGH_PRIORITY、
STRAIGHT_JOIN和以开头的修饰符
SQL_是 MySQL 对标准 SQL 的扩展。
和
修饰符指定是否应返回重复行
ALL。（默认值）指定应返回所有匹配行，包括重复项。
指定从结果集中删除重复行。同时指定两个修饰符是错误的。是的同义词
。
DISTINCTALLDISTINCTDISTINCTROWDISTINCT
在 MySQL 8.0.12 及更高版本中，DISTINCT可以与也使用WITH
ROLLUP. （漏洞 #87450，漏洞 #26640100）
HIGH_PRIORITYSELECT比更新表的语句具有更高的
优先级。您应该仅将此用于非常快且必须立即完成的查询。SELECT HIGH_PRIORITY即使有更新语句等待表释放，在表被锁定以供读取时发出的
查询也会运行。这只会影响仅使用表级锁定的存储引擎（例如MyISAM、MEMORY和MERGE）。
HIGH_PRIORITY不能与
SELECT属于 a 的语句一起使用UNION。
STRAIGHT_JOIN强制优化器按照它们在
FROM子句中列出的顺序连接表。如果优化器以非最佳顺序连接表，您可以使用它来加速查询。
STRAIGHT_JOIN也可以用在
table_references列表中。请参阅
第 13.2.10.2 节，“JOIN 子句”。
STRAIGHT_JOIN不适用于优化器视为
const或
表的任何system表。这样的表产生单行，在查询执行的优化阶段被读取，并且在查询执行继续之前对其列的引用被替换为适当的列值。这些表最先出现在 显示的查询计划中EXPLAIN。请参阅
第 8.8.1 节，“使用 EXPLAIN 优化查询”。此例外可能不适用于在外部联接的 - 补充侧使用的const或
system表（即， a 的右侧表或 a 的左侧表）。
NULLLEFT
JOINRIGHT
JOIN
SQL_BIG_RESULTor
SQL_SMALL_RESULT可以与
GROUP BYorDISTINCT一起使用，分别告诉优化器结果集有很多行或很小。对于，如果创建了基于磁盘的临时表，则 MySQL 会直接使用它们，并且更喜欢使用元素SQL_BIG_RESULT上带有键的临时表进行排序。GROUP BY对于
SQL_SMALL_RESULT，MySQL 使用内存中的临时表来存储结果表，而不是使用排序。这通常不需要。
SQL_BUFFER_RESULT强制将结果放入临时表中。这有助于 MySQL 尽早释放表锁，并在需要很长时间才能将结果集发送到客户端的情况下提供帮助。该修饰符只能用于顶级SELECT
语句，不能用于子查询或后续
UNION。
SQL_CALC_FOUND_ROWS告诉 MySQL 计算结果集中有多少行，忽略任何LIMIT子句。然后可以使用 检索行数SELECT
FOUND_ROWS()。请参阅
第 12.16 节，“信息功能”。
笔记
从
MySQL 8.0.17 开始，不推荐使用SQL_CALC_FOUND_ROWS查询修饰符和伴随函数；FOUND_ROWS()希望它们在未来版本的 MySQL 中被删除。FOUND_ROWS()有关替代策略的信息，
请参阅
说明。
SQL_CACHE和
修饰符
在SQL_NO_CACHEMySQL 8.0 之前与查询缓存一起使用。MySQL 8.0 中删除了查询缓存。修改器
SQL_CACHE也被删除了。
SQL_NO_CACHE已弃用，无效；希望在未来的 MySQL 版本中将其删除。
© Mysql 中文网
