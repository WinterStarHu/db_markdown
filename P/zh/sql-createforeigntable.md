# CREATE FOREIGN TABLE

CREATE FOREIGN TABLE
版本：
纠错本页面
搜索
目录导航
❮
❯
CREATE FOREIGN TABLECREATE FOREIGN TABLE — 定义一个新的外部表大纲
CREATE FOREIGN TABLE [ IF NOT EXISTS ] table_name ( [
{ column_name data_type [ OPTIONS ( option 'value' [, ... ] ) ] [ COLLATE collation ] [ column_constraint [ ... ] ]
| table_constraint
| LIKE source_table [ like_option ... ] }
[, ... ]
] )
[ INHERITS ( parent_table [, ... ] ) ]
SERVER server_name
[ OPTIONS ( option 'value' [, ... ] ) ]
CREATE FOREIGN TABLE [ IF NOT EXISTS ] table_name
PARTITION OF parent_table [ (
{ column_name [ WITH OPTIONS ] [ column_constraint [ ... ] ]
| table_constraint }
[, ... ]
) ]
{ FOR VALUES partition_bound_spec | DEFAULT }
SERVER server_name
[ OPTIONS ( option 'value' [, ... ] ) ]
其中 column_constraint 是：
[ CONSTRAINT constraint_name ]
{ NOT NULL [ NO INHERIT ] |
NULL |
CHECK ( expression ) [ NO INHERIT ] |
DEFAULT default_expr |
GENERATED ALWAYS AS ( generation_expr ) [ STORED | VIRTUAL ] }
[ ENFORCED | NOT ENFORCED ]
并且 table_constraint 是：
[ CONSTRAINT constraint_name ]
{  NOT NULL column_name [ NO INHERIT ] |
CHECK ( expression ) [ NO INHERIT ] }
[ ENFORCED | NOT ENFORCED ]
并且 like_option 是：
{ INCLUDING | EXCLUDING } { COMMENTS | CONSTRAINTS | DEFAULTS | GENERATED | STATISTICS | ALL }
并且 partition_bound_spec 是：
IN ( partition_bound_expr [, ...] ) |
FROM ( { partition_bound_expr | MINVALUE | MAXVALUE } [, ...] )
TO ( { partition_bound_expr | MINVALUE | MAXVALUE } [, ...] ) |
WITH ( MODULUS numeric_literal, REMAINDER numeric_literal )
描述
CREATE FOREIGN TABLE在当前数据库中创建
一个新的外部表。该表将由发出这个命令的用户所拥有。
如果给定了模式名称（例如，CREATE FOREIGN TABLE
myschema.mytable ...），那么表将在指定的模式中创建。否则，它将在当前模式中创建。
外部表的名称必须与同一模式中的任何其他关系（表、序列、索引、视图、物化视图或外部表）的名称不同。
CREATE FOREIGN TABLE还将自动创建
一个数据类型来表示该外部表行相应的组合类型。因此，外部表不能和
同一个模式中任何现有的数据类型同名。
如果指定了PARTITION OF子句，
则该表被创建为具有指定边界的parent_table的分区。
要创建一个外部表，你必须具有该外部服务器上的USAGE
特权，以及该表中用到的所有列类型上的USAGE特权。
参数IF NOT EXISTS
已经存在同名关系时不要抛出错误。这种情况下会发出一个提示。注意，
并不保证已经存在的关系与将要创建的那一个相似。
table_name
要创建的表的名称（可以被模式限定）。
column_name
要在新表中创建的列名。
data_type
该列的数据类型。可以包括数组指示符。更多
PostgreSQL支持的数据类型可见第 8 章。
COLLATE collation
COLLATE子句为该列（必须是一个可排序的数据类型）
赋予一个排序规则。如果没有指定，则会使用该列的数据类型的默认
排序规则。
INHERITS ( parent_table [, ... ] )
可选的INHERITS子句指定了一个表的列表，新的外部表
会自动从中继承所有列。父表可以是普通表或者外部表。详见
CREATE TABLE的类似形式。
PARTITION OF parent_table { FOR VALUES partition_bound_spec | DEFAULT }
此语句可以用来将外部表创建为父表的一个指定区间的分区表。
详见CREATE TABLE的类似形式。
注意如果父表存在UNIQUE类型的索引时，当前是不允许将外部表
创建为该父表的分区表。（另见
ALTER TABLE ATTACH PARTITION。）
LIKE source_table [ like_option ... ]
LIKE子句指定新表将从哪一个表自动地复制所有的列名、数据类型以及它们的非空约束。
和INHERITS不同，新表和原始表在创建完成之后是完全分离的。对原始表的更改将不会被应用到新表，并且不可能在原始表的扫描中包括新表的数据。
同样与INHERITS不同，用LIKE拷贝的列和约束不会和相似的命名列及约束融合。如果显式指定了相同的名称或者在另一个LIKE子句中指定了相同的名称，将会发出一个错误。
可选的 like_option 子句指定
要复制的原始表的附加属性。指定
INCLUDING 会复制该属性，指定
EXCLUDING 会省略该属性。
EXCLUDING 是默认值。如果对同一类型的对象进行了多次指定，
则使用最后一个。可用的选项有：
INCLUDING COMMENTS
复制的列和约束的注释将被复制。默认行为是排除注释，
导致新表中的复制列和约束没有注释。
INCLUDING CONSTRAINTS
CHECK 约束将被复制。列约束和表约束之间没有区别。
非空约束总是会复制到新表中。
INCLUDING DEFAULTS
复制列定义的默认表达式将被复制。否则，默认表达式不会被复制，
导致新表中的复制列具有 NULL 默认值。请注意，复制调用数据库修改函数的默认值，
例如 nextval，可能会在原始表和新表之间创建功能链接。
INCLUDING GENERATED
复制列定义的任何生成表达式将被复制。默认情况下，新列将是常规基础列。
INCLUDING STATISTICS
扩展统计信息将被复制到新表中。
INCLUDING ALL
INCLUDING ALL 是选择所有可用单个选项的简写形式。
（在 INCLUDING ALL 后编写单独的 EXCLUDING 子句以选择所有但某些特定选项可能会很有用。）
CONSTRAINT constraint_name
一个可选的用于列或者表约束的名字。如果该约束被违背，这个约束名字会
出现在错误消息中，这样col must be positive这种约束名就
可以被用来与客户端应用交流有用的约束信息（指定包含空格的约束名需要
使用双引号）。如果没有指定约束名，系统会自动生成一个。
NOT NULL [ NO INHERIT ]
该列不允许包含空值。
被标记为NO INHERIT的约束将不会传播到子表。
NULL
该列可以包含空值，这是默认值。
提供这个子句只是为了兼容非标准的 SQL 数据库。在新的应用中
不鼓励使用它。
CHECK ( expression ) [ NO INHERIT ]
CHECK子句指定一个产生布尔结果的表达式，该外部表
中的每一行都应该满足该表达式。也就是说，对于该外部表中所有的行，
这个表达式应该产生 TRUE 或 UNKNOWN，而不能产生 FALSE。被
作为列约束指定的检查约束应该只引用该列的值，而出现在表约束中的
表达式可以引用多列。
当前，CHECK表达式不能包含子查询，也不能
引用除当前行的列之外的其他变量。可以引用系统列
tableoid，但是不能引用其他系统列。
被标记为NO INHERIT的约束将不会传播到子表。
DEFAULT
default_expr
DEFAULT子句为包含它的列定义赋予一个默认数据值。该
值是任意不包含变量的表达式（不允许子查询和对当前表中其他列的交叉
引用）。默认值表达式的数据类型必须匹配列的数据类型。
默认值表达式将被用在任何没有指定列值的插入操作中。如果一列没有
默认值，则默认值为 null。
GENERATED ALWAYS AS ( generation_expr ) [ STORED | VIRTUAL ]
该子句创建一个生成列。此列不能写入，
只能在读取时返回所指定的表达式的值。
当指定 VIRTUAL 时，该列将在读取时计算。
（外部数据包装器会将其视为新行中的 null 值，并可能选择将其存储为
null 值或完全忽略它。）当指定 STORED 时，该列将在
写入时计算。（计算值将呈现给外部数据包装器进行存储，并且在读取时
必须返回。）VIRTUAL 是默认值。
生成表达式可以引用表中的其他列，但不能引用其他生成列。
所使用的函数和操作符必须是不可变的。不能引用其他表。
server_name
要用于该外部表的一个现有外部服务器的名称。有关定义一个服务器
的细节，可以参考CREATE SERVER。
OPTIONS ( option 'value' [, ...] )
要与新外部表或者它的一个列相关联的选项。被允许的选项名称和值是
与每一个外部数据包装器相关的，并且它们会被该外部数据包装器的验证器
函数验证。不允许重复的选项名称（不过一个表选项和一个列选项重名是
可以的）。
注释
PostgreSQL核心系统不会强制外部表上的约束（
例如CHECK或NOT NULL子句），大部分外部
数据包装器也不会尝试强制它们。也就是说，这类约束会被简单地认为保持
为真。这种强制其实没什么意义，因为它只适用于通过该外部表插入或者更
新的行，而对通过其他方式修改的行（例如直接在远程服务器上修改）没有
作用。附着在外部表上的约束应该表示由外部服务器强制的一个约束。
有些特殊目的的外部数据包装器可能是它们所访问的数据的唯一一种访问
机制，在那种情况下让外部数据包装器自己来执行约束强制可能是合适的。
但是不应该假设包装器会这样做，除非它的文档说它会。
虽然PostgreSQL不会尝试对外部表强制执行约束，
但它假定它们在查询优化方面是正确的。如果外部表中存在不符合声明约束的可见行，
对表的查询可能会产生错误或不正确的答案。用户有责任确保约束定义与现实匹配。
小心
当外部表作为分区表的一个分区时，存在一个隐含约束，即其内容必须满足分区规则。
再次强调，用户有责任确保这一点，最好的方法是在远程服务器上安装匹配的约束。
在包含外部表分区的分区表中，更改分区键值的UPDATE可能会导致一行从本地分区移动到外部表分区，
前提是外部数据包装器支持元组路由。然而，目前无法将一行从外部表分区移动到另一个分区。
一个需要这样做的UPDATE将由于分区约束而失败，假设远程服务器正确执行了该约束。
类似的要点也适用于生成列。存储生成列在本地PostgreSQL
服务器发生插入或更新时进行计算，并将计算结果传递给外部数据包装器，由外部数据
包装器负责把结果写到外部数据存储中，但是并不强制要求查询外部表时返回的生成列
的值一定是与生成表达式一致。
总而言之，此行为可能导致查询到不正确的结果。
示例
创建外部表films，通过服务器film_server访问它：
CREATE FOREIGN TABLE films (
code        char(5) NOT NULL,
title       varchar(40) NOT NULL,
did         integer NOT NULL,
date_prod   date,
kind        varchar(10),
len         interval hour to minute
)
SERVER film_server;
创建外部表measurement_y2016m07，通过服务器
server_07访问它，作为范围分区表measurement
的分区：
CREATE FOREIGN TABLE measurement_y2016m07
PARTITION OF measurement FOR VALUES FROM ('2016-07-01') TO ('2016-08-01')
SERVER server_07;
兼容性
CREATE FOREIGN TABLE 命令在很大程度上符合
SQL 标准；然而，与
CREATE TABLE
一样，允许使用 NULL 约束和零列外部表。
指定列默认值的能力也是
PostgreSQL 的扩展。表继承的形式
由 PostgreSQL 定义，是非标准的。
该命令支持的 LIKE 子句也是
非标准的。
另见ALTER FOREIGN TABLE, DROP FOREIGN TABLE, CREATE TABLE, CREATE SERVER, IMPORT FOREIGN SCHEMA上一页 上一级 下一页CREATE FOREIGN DATA WRAPPER 起始页 CREATE FUNCTION
