# 9.21. 聚合函数

9.21. 聚合函数
版本：
纠错本页面
搜索
目录导航
❮
❯
9.21. 聚合函数 #
聚合函数从一个输入值的集合计算出一个单一值。
内建的通用聚合函数在表 9.62中列出，而统计性聚合是在表 9.63中列出。
内建的组内有序集聚合函数在表 9.64中列出，而内建的组内假想集聚合在表 9.65中列出。
与聚合函数紧密相关的分组操作在表 9.66中列出。
第 4.2.7 节中会解释针对聚合函数的特殊语法考虑。额外的介绍信息请参考第 2.7 节。
支持部分模式的聚合函数具备参与各种优化的条件，例如并行聚合。
虽然下面所有的聚合函数都接受一个可选的
ORDER BY 子句（如 第 4.2.7 节 中所述），但该子句仅被添加到
输出受排序影响的聚合函数中。
表 9.62. 通用聚合函数
函数
描述
部分模式
any_value ( anyelement )
→ same as input type
从非空输入值中返回一个任意值。
Yes
array_agg ( anynonarray ORDER BY input_sort_columns )
→ anyarray
收集所有输入值，包括空值，组成一个数组。
Yes
array_agg ( anyarray ORDER BY input_sort_columns )
→ anyarray
将所有输入数组连接成一个维度高一维的数组。（输入数组必须具有相同的维度，
且不能为空或null。）
Yes
avg ( smallint )
→ numeric
avg ( integer )
→ numeric
avg ( bigint )
→ numeric
avg ( numeric )
→ numeric
avg ( real )
→ double precision
avg ( double precision )
→ double precision
avg ( interval )
→ interval
计算所有非空输入值的平均值（算术平均值）。
Yes
bit_and ( smallint )
→ smallint
bit_and ( integer )
→ integer
bit_and ( bigint )
→ bigint
bit_and ( bit )
→ bit
计算所有非空输入值的按位AND。
Yes
bit_or ( smallint )
→ smallint
bit_or ( integer )
→ integer
bit_or ( bigint )
→ bigint
bit_or ( bit )
→ bit
计算所有非空输入值的按位OR。
Yes
bit_xor ( smallint )
→ smallint
bit_xor ( integer )
→ integer
bit_xor ( bigint )
→ bigint
bit_xor ( bit )
→ bit
计算所有非空输入值的按位异或。
可用作一组无序的值集合的校验和。
Yes
bool_and ( boolean )
→ boolean
如果全部非空输入值都为真则返回真，否则返回假。
Yes
bool_or ( boolean )
→ boolean
如果任何非空输入值为真则返回真，否则返回假。
Yes
count ( * )
→ bigint
计算输入行的数量。
Yes
count ( "any" )
→ bigint
计算输入值不为空的输入行的数量。
Yes
every ( boolean )
→ boolean
这是对应bool_and的SQL标准的等效物。
Yes
json_agg ( anyelement ORDER BY input_sort_columns )
→ json
jsonb_agg ( anyelement ORDER BY input_sort_columns )
→ jsonb
收集所有输入值，包括空值，组成一个 JSON 数组。值会根据
to_json 或 to_jsonb 转换为 JSON。
No
json_agg_strict ( anyelement )
→ json
jsonb_agg_strict ( anyelement )
→ jsonb
收集所有输入值（跳过空值）到一个 JSON 数组中。值会根据
to_json 或 to_jsonb 转换为 JSON。
No
json_arrayagg (
[ value_expression ]
[ ORDER BY sort_expression ]
[ { NULL | ABSENT } ON NULL ]
[ RETURNING data_type [ FORMAT JSON [ ENCODING UTF8 ] ] ])
表现方式与 json_array 相同，但作为一个聚合函数，
因此它只接受一个 value_expression 参数。
如果指定了 ABSENT ON NULL，任何 NULL 值都会被省略。
如果指定了 ORDER BY，数组中的元素将按照该顺序出现，
而不是输入顺序。
SELECT json_arrayagg(v) FROM (VALUES(2),(1)) t(v)
→ [2, 1]
No
json_objectagg (
[ { key_expression { VALUE | ':' } value_expression } ]
[ { NULL | ABSENT } ON NULL ]
[ { WITH | WITHOUT } UNIQUE [ KEYS ] ]
[ RETURNING data_type [ FORMAT JSON [ ENCODING UTF8 ] ] ])
表现类似于 json_object，但作为一个聚合函数，
因此它只接受一个 key_expression 和一个
value_expression 参数。
SELECT json_objectagg(k:v) FROM (VALUES ('a'::text,current_date),('b',current_date + 1)) AS t(k,v)
→ { "a" : "2022-05-10", "b" : "2022-05-11" }
No
json_object_agg ( key
"any", value
"any"
ORDER BY input_sort_columns )
→ json
jsonb_object_agg ( key
"any", value
"any"
ORDER BY input_sort_columns )
→ jsonb
将所有键/值对收集到一个 JSON 对象中。键参数会被强制转换为文本；
值参数则根据 to_json 或 to_jsonb 进行转换。
值可以为 null，但键不能为空。
No
json_object_agg_strict (
key "any",
value "any" )
→ json
jsonb_object_agg_strict (
key "any",
value "any" )
→ jsonb
将所有键/值对收集到一个 JSON 对象中。键参数会被强制转换为文本；值参数
会根据 to_json 或 to_jsonb 进行转换。
key 不能为 null。如果 value 为 null，
则该条目会被跳过。
否
json_object_agg_unique (
key "any",
value "any" )
→ json
jsonb_object_agg_unique (
key "any",
value "any" )
→ jsonb
将所有键/值对收集到一个 JSON 对象中。键参数会被强制转换为文本；
值参数会根据 to_json 或 to_jsonb
进行转换。值可以为 null，但键不能为 null。如果存在重复的键，将会抛出错误。
否
json_object_agg_unique_strict (
key "any",
value "any" )
→ json
jsonb_object_agg_unique_strict (
key "any",
value "any" )
→ jsonb
将所有键/值对收集到一个 JSON 对象中。键参数会被强制转换为文本；值参数
会根据 to_json 或 to_jsonb 进行转换。
key 不能为 null。如果 value 为 null，
则该条目会被跳过。如果存在重复的键，则会抛出错误。
否
max ( see text )
→ same as input type
计算非 NULL 输入值的最大值。
可用于任何数字、字符串、日期/时间或枚举类型，
以及 bytea、inet、interval、
money、oid、pg_lsn、
tid、xid8，
以及包含可排序数据类型的数组和复合类型。
是
min ( see text )
→ same as input type
计算非 NULL 输入值的最小值。
可用于任何数字、字符串、日期/时间或枚举类型，
以及 bytea、inet、interval、
money、oid、pg_lsn、
tid、xid8，
以及包含可排序数据类型的数组和复合类型。
是
range_agg ( value
anyrange )
→ anymultirange
range_agg ( value
anymultirange )
→ anymultirange
计算非 NULL 输入值的并集。
No
range_intersect_agg ( value
anyrange )
→ anyrange
range_intersect_agg ( value
anymultirange )
→ anymultirange
计算非 NULL 输入值的交集。
No
string_agg ( value
text, delimiter text )
→ text
string_agg ( value
bytea, delimiter bytea
ORDER BY input_sort_columns )
→ bytea
将非空输入值连接成一个字符串。第一个值之后的每个值前面都加上对应的
delimiter（如果它不为空）。
是
sum ( smallint )
→ bigint
sum ( integer )
→ bigint
sum ( bigint )
→ numeric
sum ( numeric )
→ numeric
sum ( real )
→ real
sum ( double precision )
→ double precision
sum ( interval )
→ interval
sum ( money )
→ money
计算非空输入值的总和。
是
xmlagg ( xml ORDER BY input_sort_columns )
→ xml
连接所有非空的XML输入值（参见
第 9.15.1.8 节）。
No
应该注意的是，除了count之外，这些函数在没有选择行时返回空值。
特别地，行数的sum返回空，而不是预期的零，array_agg在没有输入行时返回空而不是空数组。
coalesce函数可以在必要时用零或空数组代替空。
聚合函数array_agg、
json_agg、jsonb_agg、
json_agg_strict、jsonb_agg_strict、
json_object_agg、jsonb_object_agg、
json_object_agg_strict、jsonb_object_agg_strict、
json_object_agg_unique、jsonb_object_agg_unique、
json_object_agg_unique_strict、
jsonb_object_agg_unique_strict、
string_agg和xmlagg，以及类似的用户定义
的聚合函数，会根据输入值的顺序生成有意义的不同结果值。默认情况下，
这种顺序是未指定的，但可以通过在聚合调用中编写
ORDER BY子句来控制，如
第 4.2.7 节中所示。
或者，通过从已排序的子查询中提供输入值通常也可以实现。例如：
SELECT xmlagg(x) FROM (SELECT x FROM test ORDER BY y DESC) AS tab;
请注意，如果外部查询级别包含额外的处理（例如连接），这种方法可能会失败，
因为这可能导致在计算聚合之前子查询的输出被重新排序。
注意
布尔聚合 bool_and 和 bool_or 对应于标准SQL聚合 every 和 any 或 some。
PostgreSQL 支持 every，但不支持 any 或 some，因为标准语法中存在模糊性：
SELECT b1 = ANY((SELECT b2 FROM t2 ...)) FROM t1 ...;
这里ANY可以被认为是引入子查询，或者是聚合函数，如果子查询返回一行布尔值。因此，不能为这些聚合提供标准名称。
注意
习惯使用其他SQL数据库管理系统的用户可能会对count聚合应用于整个表时的性能感到失望。一个类似下面的查询：
SELECT count(*) FROM sometable;
将需要与表大小成比例的工作：PostgreSQL将需要扫描整个表或包含表中所有行的索引。
表 9.63显示了统计分析中常用的聚合函数。
(这些被分离出来仅仅是为了避免使更常用的聚合列表混乱。)
显示为接受numeric_type的函数可用于所有类型smallint、integer、bigint、numeric、real和double precision。
在描述中提及N时，它意味着所有输入表达式都非空的输入行数。在所有情况下，如果计算没有意义，则返回null，例如当N为0时。
表 9.63. 用于统计的聚合函数
函数
描述
部分模式
corr ( Y double precision, X double precision )
→ double precision
计算相关系数。
Yes
covar_pop ( Y double precision, X double precision )
→ double precision
计算总体协方差。
Yes
covar_samp ( Y double precision, X double precision )
→ double precision
计算样本协方差。
Yes
regr_avgx ( Y double precision, X double precision )
→ double precision
计算自变量的平均值，sum(X)/N。
Yes
regr_avgy ( Y double precision, X double precision )
→ double precision
计算因变量的平均值，sum(Y)/N。
Yes
regr_count ( Y double precision, X double precision )
→ bigint
计算两个输入都非空的行数。
Yes
regr_intercept ( Y double precision, X double precision )
→ double precision
计算由(X，Y)对决定的最小二乘拟合的线性方程的y-截距。
Yes
regr_r2 ( Y double precision, X double precision )
→ double precision
计算相关系数的平方。
Yes
regr_slope ( Y double precision, X double precision )
→ double precision
计算由(X, Y)对决定的最小二乘拟合的线性方程的斜率。
Yes
regr_sxx ( Y double precision, X double precision )
→ double precision
计算自变量的“平方和”
sum(X^2) - sum(X)^2/N.
Yes
regr_sxy ( Y double precision, X double precision )
→ double precision
计算独立变量与因变量的“乘积和”，
sum(X*Y) - sum(X) * sum(Y)/N.
Yes
regr_syy ( Y double precision, X double precision )
→ double precision
计算因变量的“平方和”，
sum(Y^2) - sum(Y)^2/N.
Yes
stddev ( numeric_type )
→  double precision
for real or double precision,
otherwise numeric
这是stddev_samp的一个历史别称。
Yes
stddev_pop ( numeric_type )
→  double precision
for real or double precision,
otherwise numeric
计算输入值的总体标准差。
Yes
stddev_samp ( numeric_type )
→  double precision
for real or double precision,
otherwise numeric
计算输入值的样本标准差。
Yes
variance ( numeric_type )
→  double precision
for real or double precision,
otherwise numeric
这是 var_samp 的一个历史别称。
Yes
var_pop ( numeric_type )
→  double precision
for real or double precision,
otherwise numeric
计算输入值的总体方差（总体标准差的平方）。
Yes
var_samp ( numeric_type )
→  double precision
for real or double precision,
otherwise numeric
计算输入值的样本方差（样本标准差的平方）。
Yes
表 9.64显示了一些使用ordered-set aggregate语法的聚合函数。
这些函数有时被称为“inverse distribution”函数。
它们的聚合输入是通过ORDER BY引入的，它们还可以接受未聚合的direct argument，但只计算一次。
所有这些函数在其聚合的输入中都忽略空值。
对于使用fraction参数的函数，分数值必须在0到1之间；否则将抛出一个错误。但是，空fraction值简单地产生一个空结果。
表 9.64. 有序集聚合函数
函数
描述
部分模式
mode () WITHIN GROUP ( ORDER BY anyelement )
→ anyelement
计算mode，即聚合参数最频繁的值（如果有多个相同频繁的值，第一个可以任意选择）。聚合参数必须是可排序类型。
No
percentile_cont ( fraction double precision ) WITHIN GROUP ( ORDER BY double precision )
→ double precision
percentile_cont ( fraction double precision ) WITHIN GROUP ( ORDER BY interval )
→ interval
计算continuous percentile，该值对应于聚合参数值的有序集合中的指定fraction。
如果需要，这将在相邻的输入项之间插值。
No
percentile_cont ( fractions double precision[] ) WITHIN GROUP ( ORDER BY double precision )
→ double precision[]
percentile_cont ( fractions double precision[] ) WITHIN GROUP ( ORDER BY interval )
→ interval[]
计算多个连续的百分位数。结果是一个与fractions参数具有相同维数的数组，每个非空元素都被对应于该百分位的（可能插值的）值所替换。
No
percentile_disc ( fraction double precision ) WITHIN GROUP ( ORDER BY anyelement )
→ anyelement
计算离散百分位数，即聚合参数值的有序集合中的第一个值，该值在排序中的位置等于或超过指定的fraction。
聚合参数必须是可排序类型。
No
percentile_disc ( fractions double precision[] ) WITHIN GROUP ( ORDER BY anyelement )
→ anyarray
计算多个离散百分位数。结果是一个与fractions参数具有相同维数的数组，每个非空元素都被对应于该百分位的输入值替换。
聚合参数必须是可排序类型。
No
列在表 9.65中的每个“hypothetical-set”聚合都与第 9.22 节中定义的同名窗口函数相关联。
在每种情况下，聚合的结果都是相关的窗口函数将为由args构造的“hypothetical”行返回的值，如果将这样的行添加到sorted_args表示的已排序行组中。
对于这些函数中的每一个，args中给出的直接参数列表必须与sorted_args中给出的聚合参数的数量和类型匹配。
与大多数内置聚合不同，这些聚合不是严格的，也就是说它们不会删除包含空值的输入行。空值根据ORDER BY子句中指定的规则排序。
表 9.65. 假设集聚集函数
函数
描述
部分模式
rank ( args ) WITHIN GROUP ( ORDER BY sorted_args )
→ bigint
计算假设行的排名，包括间隔；也就是说，在它的对等组中第一行的行号。
No
dense_rank ( args ) WITHIN GROUP ( ORDER BY sorted_args )
→ bigint
计算假设行的排名，没有间隔；这个函数有效地计数对等组。
No
percent_rank ( args ) WITHIN GROUP ( ORDER BY sorted_args )
→ double precision
计算假设行的相对排名，也就是(rank - 1) / (总行数 - 1)。取值范围为 0 到 1（含）。
No
cume_dist ( args ) WITHIN GROUP ( ORDER BY sorted_args )
→ double precision
计算累积分布，也就是(前面或具有假设行的对等行数)/(总行数)。取值范围为 1/N 到 1。
No表 9.66. 分组操作
函数
描述
GROUPING ( group_by_expression(s) )
→ integer
返回一个位掩码以指示哪个GROUP BY表达式没有包含在当前分组集中。
位被分配给最右边的参数对应于最低有效位；如果对应的表达式包含在生成当前结果行的分组集的分组条件中，则每个位为0，如果不包含则为1。
表 9.66所示的分组操作与分组集(参见第 7.2.4 节)共同使用，以区分结果行。
GROUPING函数的参数实际上并不求值，但它们必须与相关查询级别的GROUP BY子句中给出的表达式完全匹配。例如:
=> SELECT * FROM items_sold;
make  | model | sales
-------+-------+-------
Foo   | GT    |  10
Foo   | Tour  |  20
Bar   | City  |  15
Bar   | Sport |  5
(4 rows)
=> SELECT make, model, GROUPING(make,model), sum(sales) FROM items_sold GROUP BY ROLLUP(make,model);
make  | model | grouping | sum
-------+-------+----------+-----
Foo   | GT    |        0 | 10
Foo   | Tour  |        0 | 20
Bar   | City  |        0 | 15
Bar   | Sport |        0 | 5
Foo   |       |        1 | 30
Bar   |       |        1 | 20
|       |        3 | 50
(7 rows)
在这里，前四行中的grouping值0表明这些已经正常分组，在两个分组列上。
值1表示model没有在倒数两行中分组，值3表示无论是make还是model都没有在最后一行中分组(因此，这是所有输入行的聚合)。
上一页 上一级 下一页9.20. 范围/多范围函数和运算符 起始页 9.22. 窗口函数
