# F.43. tablefunc — 返回表的函数（crosstab及其他）

F.43. tablefunc — 返回表的函数（crosstab及其他）
版本：
纠错本页面
搜索
目录导航
❮
❯
F.43. tablefunc — 返回表的函数（crosstab及其他） #F.43.1. 所提供的函数F.43.2. 作者
tablefunc模块包括多个返回表（也就是多行）的函数。这些函数既有其自身的用途，也可以作为如何编写返回多行的 C 函数的例子。
这个模块被认为是“可信的”，也就是说，它可以由对当前数据库具有CREATE权限的非超级用户安装。
F.43.1. 所提供的函数 #
表 F.33总结了tablefunc模块提供的函数。
表 F.33. tablefunc 函数
函数
描述
normal_rand ( numvals integer, mean float8, stddev float8 )
→ setof float8
产生一组正态分布的随机值。
crosstab ( sql text )
→ setof record
生成一个“数据透视表”，其中包含行名称和 N 列值，其中 N 由调用查询中指定的行类型决定。
crosstabN ( sql text )
→ setof table_crosstab_N
产生一个包含行名称外加N个值列的“数据透视表”。crosstab2、crosstab3和crosstab4是被预定义的，但你可以按照下文所述创建额外的crosstabN函数。
crosstab ( source_sql text, category_sql text )
→ setof record
产生一个“数据透视表”，其值列由第二个查询指定。
crosstab ( sql text, N integer )
→ setof record
crosstab(text)的废弃版本。参数N现在被忽略，因为值列的数量总是由调用查询所决定。
connectby ( relname text, keyid_fld text, parent_keyid_fld text
[, orderby_fld text ], start_with text, max_depth integer
[, branch_delim text ] )
→ setof record
产生一个层次树结构的表达。
F.43.1.1. normal_rand #
normal_rand(int numvals, float8 mean, float8 stddev) returns setof float8
normal_rand产生一组正态分布随机值（高斯分布）。
numvals是从该函数返回的值的数量。mean是值的正态分布的均值，而stddev是值的正态分布的标准偏差。
例如，这个调用请求1000个值，它们具有均值5和标准偏差3：
test=# SELECT * FROM normal_rand(1000, 5, 3);
normal_rand
----------------------
1.56556322244898
9.10040991424657
5.36957140345079
-0.369151492880995
0.283600703686639
.
.
.
4.82992125404908
9.71308014517282
2.49639286969028
(1000 rows)
F.43.1.2. crosstab(text) #
crosstab(text sql)
crosstab(text sql, int N)
crosstab函数用于生成“pivot”显示，其中数据横向列出，而不是纵向列出。例如，我们可能有这样的数据
row1    val11
row1    val12
row1    val13
...
row2    val21
row2    val22
row2    val23
...
而我们希望显示成这样
row1    val11   val12   val13   ...
row2    val21   val22   val23   ...
...
crosstab函数接受一个文本参数，该参数是一个SQL查询，生成以第一种方式格式化的原始数据，并生成以第二种方式格式化的表。
sql参数是一个生成数据源集合的SQL语句。该语句必须返回一个row_name列、一个category列和一个value列。N是一个废弃参数，即使提供也会被忽略（之前这必须匹配输出值列的数量，但现在由调用查询决定）。
例如，所提供的查询可能会产生这样的一个集合：
row_name    cat    value
----------+-------+-------
row1      cat1    val1
row1      cat2    val2
row1      cat3    val3
row1      cat4    val4
row2      cat1    val5
row2      cat2    val6
row2      cat3    val7
row2      cat4    val8
crosstab函数被声明为返回setof record，
因此输出列的实际名称和类型必须定义在调用的SELECT语句的FROM子句中，例如：
SELECT * FROM crosstab('...') AS ct(row_name text, category_1 text, category_2 text);
这个例子产生这样一个集合：
<== value  columns  ==>
row_name   category_1   category_2
----------+------------+------------
row1        val1         val2
row2        val5         val6
FROM子句必须把输出定义为一个row_name列
（具有 SQL 查询的第一个结果列的相同数据类型），其后跟随着 N 个value列
（都具有 SQL 查询的第三个结果列的相同数据类型）。你可以按照你的意愿设置任意多的输出值列。
而输出列的名称取决于你。
crosstab函数为具有相同row_name值的
输入行的每一个连续分组产生一个输出行。它使用来自这些行的value字段
从左至右填充输出的value列。如果一个分组中的行比输出value列少，
多余的输出列将被用空值填充。如果行更多，则多余的输入行会被跳过。
事实上，SQL 查询应该总是指定ORDER BY 1,2来保证输入行被正确地排序，
也就是说具有相同row_name的值会被放在一起并且在行内
被正确地排序。注意crosstab本身并不关注查询结果的第二列，它放在那里
只是为了被排序，以便控制出现在页面上的第三列值的顺序。
这是一个完整的例子：
CREATE TABLE ct(id SERIAL, rowid TEXT, attribute TEXT, value TEXT);
INSERT INTO ct(rowid, attribute, value) VALUES('test1','att1','val1');
INSERT INTO ct(rowid, attribute, value) VALUES('test1','att2','val2');
INSERT INTO ct(rowid, attribute, value) VALUES('test1','att3','val3');
INSERT INTO ct(rowid, attribute, value) VALUES('test1','att4','val4');
INSERT INTO ct(rowid, attribute, value) VALUES('test2','att1','val5');
INSERT INTO ct(rowid, attribute, value) VALUES('test2','att2','val6');
INSERT INTO ct(rowid, attribute, value) VALUES('test2','att3','val7');
INSERT INTO ct(rowid, attribute, value) VALUES('test2','att4','val8');
SELECT *
FROM crosstab(
'select rowid, attribute, value
from ct
where attribute = ''att2'' or attribute = ''att3''
order by 1,2')
AS ct(row_name text, category_1 text, category_2 text, category_3 text);
row_name | category_1 | category_2 | category_3
----------+------------+------------+------------
test1    | val2       | val3       |
test2    | val6       | val7       |
(2 rows)
你可以避免总是要写出一个FROM子句来定义输出列，
方法是设置一个在其定义中硬编码所期望的输出行类型的自定义crosstab函数。
这会在下一节中描述。另一种可能性是在一个视图定义中嵌入所需的FROM子句。
注意
另见psql中的
\crosstabview
命令，它提供了和crosstab()类似的功能。
F.43.1.3. crosstabN(text) #
crosstabN(text sql)
crosstabN系列函数是如何为普通crosstab
函数设置自定义包装器的例子，这样你不需要在调用的SELECT查询中
写出列名和类型。tablefunc模块包括crosstab2、
crosstab3以及crosstab4，它们的输出行类型被定义为：
CREATE TYPE tablefunc_crosstab_N AS (
row_name TEXT,
category_1 TEXT,
category_2 TEXT,
.
.
.
category_N TEXT
);
因此，当输入查询产生类型为text的列row_name和value
并且想要 2、3 或 4 个输出值列时，这些函数可以被直接使用。在所有其他方法中，它们的行为都和上面的
一般crosstab函数完全相同。
例如，前一节给出的例子也可以这样来做
SELECT *
FROM crosstab3(
'select rowid, attribute, value
from ct
where attribute = ''att2'' or attribute = ''att3''
order by 1,2');
这些函数主要是出于举例的目的而提供。你可以基于底层的crosstab()函数
创建你自己的返回类型和函数。有两种方法来做：
与contrib/tablefunc/tablefunc--1.0.sql中相似，创建一个组合类型来描述所期望的输出列。
然后定义一个唯一的函数名，它接受一个text参数并且返回setof your_type_name，但是链接到同样的
底层crosstab C 函数。例如，如果你的源数据产生为text类型的行名称，并且值是float8，
并且你想要 5 个值列：
CREATE TYPE my_crosstab_float8_5_cols AS (
my_row_name text,
my_category_1 float8,
my_category_2 float8,
my_category_3 float8,
my_category_4 float8,
my_category_5 float8
);
CREATE OR REPLACE FUNCTION crosstab_float8_5_cols(text)
RETURNS setof my_crosstab_float8_5_cols
AS '$libdir/tablefunc','crosstab' LANGUAGE C STABLE STRICT;
使用OUT参数来隐式定义返回类型。同样的例子也可以这样来做：
CREATE OR REPLACE FUNCTION crosstab_float8_5_cols(
IN text,
OUT my_row_name text,
OUT my_category_1 float8,
OUT my_category_2 float8,
OUT my_category_3 float8,
OUT my_category_4 float8,
OUT my_category_5 float8)
RETURNS setof record
AS '$libdir/tablefunc','crosstab' LANGUAGE C STABLE STRICT;
F.43.1.4. crosstab(text, text) #
crosstab(text source_sql, text category_sql)
crosstab的单一参数形式的主要限制是它把一个组中的所有值都视作相似，
并且把每一个值插入到第一个可用的列中。如果你想要值列对应于特定的数据分类，并且
某些分组可能没有关于某些分类的数据，这样的形式就无法工作。crosstab的双参数形式
通过提供一个对应于输出列的显式分类列表来处理这种情况。
source_sql是一个产生源数据集的 SQL 语句。这个语句必须返回一个
row_name列、一个category列以及一个value列。
也可以有一个或者多个“extra”列。row_name列必须是第一个。
category和value列必须是按照这个顺序的最后两个列。
row_name和category之间的任何列都被视作“extra”。
对于具有相同row_name值的所有行，其“extra”列都应该相同。
例如，source_sql可能产生一组这样的东西：
SELECT row_name, extra_col, cat, value FROM foo ORDER BY 1;
row_name    extra_col   cat    value
----------+------------+-----+---------
row1         extra1    cat1    val1
row1         extra1    cat2    val2
row1         extra1    cat4    val4
row2         extra2    cat1    val5
row2         extra2    cat2    val6
row2         extra2    cat3    val7
row2         extra2    cat4    val8
category_sql是一个产生分类集合的 SQL 语句。这个语句必须只返回一列。
它必须产生至少一行，否则会生成一个错误。还有，它不能产生重复值，否则会生成一个错误。category_sql可能是这样的：
SELECT DISTINCT cat FROM foo ORDER BY 1;
cat
-------
cat1
cat2
cat3
cat4
crosstab函数被声明为返回setof record，这样输出列的实际名称和类型
就必须在调用的SELECT语句的FROM子句中被定义，例如：
SELECT * FROM crosstab('...', '...')
AS ct(row_name text, extra text, cat1 text, cat2 text, cat3 text, cat4 text);
这将产生这样的结果：
<==  value  columns   ==>
row_name   extra   cat1   cat2   cat3   cat4
---------+-------+------+------+------+------
row1     extra1  val1   val2          val4
row2     extra2  val5   val6   val7   val8
FROM子句必须定义正确数量的输出列以及正确的数据类型。如果在source_sql
查询的结果中有N列，其中的前N-2 列必须匹配前N-2
个输出列。剩余的输出列必须具有source_sql查询结果的最后一列的类型，并且它们的数量
必须正好和category_sql查询结果中的行数相同。
crosstab函数为具有相同row_name值的输入行形成的每一个连续分组
产生一个输出行。输出的row_name列外加任意一个“extra”列都是从分组的
第一行复制而来。输出的value列被使用具有匹配的category值的行中的
value字段填充。如果一行的category不匹配category_sql
查询的任何输出，它的value会被忽略。匹配的分类不出现于分组中任何输出行中的
输出列会被用空值填充。
事实上，source_sql查询应该总是指定ORDER BY 1来保证
具有相同row_name的值会被放在一起。但是，一个分组内分类的顺序并不重要。
还有，确保category_sql查询的输出的顺序与指定的输出列顺序匹配是非常重要的。
这里有两个完整的例子：
create table sales(year int, month int, qty int);
insert into sales values(2007, 1, 1000);
insert into sales values(2007, 2, 1500);
insert into sales values(2007, 7, 500);
insert into sales values(2007, 11, 1500);
insert into sales values(2007, 12, 2000);
insert into sales values(2008, 1, 1000);
select * from crosstab(
'select year, month, qty from sales order by 1',
'select m from generate_series(1,12) m'
) as (
year int,
"Jan" int,
"Feb" int,
"Mar" int,
"Apr" int,
"May" int,
"Jun" int,
"Jul" int,
"Aug" int,
"Sep" int,
"Oct" int,
"Nov" int,
"Dec" int
);
year | Jan  | Feb  | Mar | Apr | May | Jun | Jul | Aug | Sep | Oct | Nov  | Dec
------+------+------+-----+-----+-----+-----+-----+-----+-----+-----+------+------
2007 | 1000 | 1500 |     |     |     |     | 500 |     |     |     | 1500 | 2000
2008 | 1000 |      |     |     |     |     |     |     |     |     |      |
(2 rows)
CREATE TABLE cth(rowid text, rowdt timestamp, attribute text, val text);
INSERT INTO cth VALUES('test1','01 March 2003','temperature','42');
INSERT INTO cth VALUES('test1','01 March 2003','test_result','PASS');
INSERT INTO cth VALUES('test1','01 March 2003','volts','2.6987');
INSERT INTO cth VALUES('test2','02 March 2003','temperature','53');
INSERT INTO cth VALUES('test2','02 March 2003','test_result','FAIL');
INSERT INTO cth VALUES('test2','02 March 2003','test_startdate','01 March 2003');
INSERT INTO cth VALUES('test2','02 March 2003','volts','3.1234');
SELECT * FROM crosstab
(
'SELECT rowid, rowdt, attribute, val FROM cth ORDER BY 1',
'SELECT DISTINCT attribute FROM cth ORDER BY 1'
)
AS
(
rowid text,
rowdt timestamp,
temperature int4,
test_result text,
test_startdate timestamp,
volts float8
);
rowid |          rowdt           | temperature | test_result |      test_startdate      | volts
-------+--------------------------+-------------+-------------+--------------------------+--------
test1 | Sat Mar 01 00:00:00 2003 |          42 | PASS        |                          | 2.6987
test2 | Sun Mar 02 00:00:00 2003 |          53 | FAIL        | Sat Mar 01 00:00:00 2003 | 3.1234
(2 rows)
你可以创建预定义的函数来避免在每个查询中都必须写出结果列的名称和类型。请参考前一节中的例子。
用于这种形式的crosstab的底层 C 函数被命名为crosstab_hash。
F.43.1.5. connectby #
connectby(text relname, text keyid_fld, text parent_keyid_fld
[, text orderby_fld ], text start_with, int max_depth
[, text branch_delim ])
connectby函数产生存储在一个表中的层次数据的显示。该表必须具有一个用以
唯一标识行的键域，以及一个父键域用来引用其父亲（如果有）。connectby能
显示从任意行开始向下的子树。
表 F.34解释了参数。
表 F.34. connectby 参数参数描述relname源关系的名称keyid_fld键字段的名称parent_keyid_fld父键字段的名称orderby_fld用于排序兄弟的字段名称（可选）start_with起始行的键值max_depth要向下的最大深度，零表示无限深度branch_delim在分支输出中用于分隔键的字符串（可选）
键域和父键域可以是任意数据类型，但是它们必须是同一类型。
注意start_with值必须作为一个文本字符串被输入，而不管键域的类型如何。
connectby函数被声明为返回setof record，因此输出列的实际名称和类型
就必须在调用的SELECT语句的FROM子句中被定义，例如：
SELECT * FROM connectby('connectby_tree', 'keyid', 'parent_keyid', 'pos', 'row2', 0, '~')
AS t(keyid text, parent_keyid text, level int, branch text, pos int);
前两个输出列用于当前行的键和其父行的键，它们必须匹配该表的键域的类型。第三个输出列是该树中的深度，
并且必须是类型integer。如果给定了一个branch_delim参数，下一个输出列
就是分支显示并且必须是类型text。最后，如果给出了一个orderby_fld参数，
最后一个输出列是一个序号，并且必须是类型integer。
“branch”输出列显示了用于到达当前行的由键构成的路径。键之间用指定的branch_delim
字符串分隔。如果不需要分支显示，可以在输出列列表中忽略branch_delim参数和分支列。
如果同一父键的子女之间的顺序很重要，可以包括orderby_fld参数以指定用哪个字段对兄弟排序。
这个字段可以是任何可排序数据类型。当且仅当orderby_fld被指定时，输出列列表必须包括一个
最终的整数序号列。
表示表和字段名的参数会被原样复制到connectby内部生成的 SQL 查询中。
因此，如果名称是大小写混合或者包含特殊字符，应包括双引号。你也可能需要用模式限定表名。
在大型表中，除非在父键字段上有索引，否则性能会很差。
branch_delim字符串不出现在任何键值中是很重要的，否则connectby可能会错误地
报告一个无限递归错误。注意如果没有提供branch_delim，将用一个默认值~来进行递归检测。
这里是一个例子：
CREATE TABLE connectby_tree(keyid text, parent_keyid text, pos int);
INSERT INTO connectby_tree VALUES('row1',NULL, 0);
INSERT INTO connectby_tree VALUES('row2','row1', 0);
INSERT INTO connectby_tree VALUES('row3','row1', 0);
INSERT INTO connectby_tree VALUES('row4','row2', 1);
INSERT INTO connectby_tree VALUES('row5','row2', 0);
INSERT INTO connectby_tree VALUES('row6','row4', 0);
INSERT INTO connectby_tree VALUES('row7','row3', 0);
INSERT INTO connectby_tree VALUES('row8','row6', 0);
INSERT INTO connectby_tree VALUES('row9','row5', 0);
-- 带有分支，但没有 orderby_fld （不保证结果的顺序）
SELECT * FROM connectby('connectby_tree', 'keyid', 'parent_keyid', 'row2', 0, '~')
AS t(keyid text, parent_keyid text, level int, branch text);
keyid | parent_keyid | level |       branch
-------+--------------+-------+---------------------
row2  |              |     0 | row2
row4  | row2         |     1 | row2~row4
row6  | row4         |     2 | row2~row4~row6
row8  | row6         |     3 | row2~row4~row6~row8
row5  | row2         |     1 | row2~row5
row9  | row5         |     2 | row2~row5~row9
(6 rows)
-- 没有分支，也没有 orderby_fld （不保证结果的顺序）
SELECT * FROM connectby('connectby_tree', 'keyid', 'parent_keyid', 'row2', 0)
AS t(keyid text, parent_keyid text, level int);
keyid | parent_keyid | level
-------+--------------+-------
row2  |              |     0
row4  | row2         |     1
row6  | row4         |     2
row8  | row6         |     3
row5  | row2         |     1
row9  | row5         |     2
(6 rows)
-- 有分支，有 orderby_fld （注意 row5 在 row4 前面）
SELECT * FROM connectby('connectby_tree', 'keyid', 'parent_keyid', 'pos', 'row2', 0, '~')
AS t(keyid text, parent_keyid text, level int, branch text, pos int);
keyid | parent_keyid | level |       branch        | pos
-------+--------------+-------+---------------------+-----
row2  |              |     0 | row2                |   1
row5  | row2         |     1 | row2~row5           |   2
row9  | row5         |     2 | row2~row5~row9      |   3
row4  | row2         |     1 | row2~row4           |   4
row6  | row4         |     2 | row2~row4~row6      |   5
row8  | row6         |     3 | row2~row4~row6~row8 |   6
(6 rows)
-- 没有分支，有 orderby_fld （注意 row5 在 row4 前面）
SELECT * FROM connectby('connectby_tree', 'keyid', 'parent_keyid', 'pos', 'row2', 0)
AS t(keyid text, parent_keyid text, level int, pos int);
keyid | parent_keyid | level | pos
-------+--------------+-------+-----
row2  |              |     0 |   1
row5  | row2         |     1 |   2
row9  | row5         |     2 |   3
row4  | row2         |     1 |   4
row6  | row4         |     2 |   5
row8  | row6         |     3 |   6
(6 rows)
F.43.2. 作者 #
Joe Conway
上一页 上一级 下一页F.42. sslinfo — 获取客户端SSL信息 起始页 F.44. tcn — 一个触发函数，用于通知监听者表内容的更改
