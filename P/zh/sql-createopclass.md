# CREATE OPERATOR CLASS

CREATE OPERATOR CLASS
版本：
纠错本页面
搜索
目录导航
❮
❯
CREATE OPERATOR CLASSCREATE OPERATOR CLASS — 定义一个新的操作符类大纲
CREATE OPERATOR CLASS name [ DEFAULT ] FOR TYPE data_type
USING index_method [ FAMILY family_name ] AS
{  OPERATOR strategy_number operator_name [ ( op_type, op_type ) ] [ FOR SEARCH | FOR ORDER BY sort_family_name ]
| FUNCTION support_number [ ( op_type [ , op_type ] ) ] function_name ( argument_type [, ...] )
| STORAGE storage_type
} [, ... ]
描述
CREATE OPERATOR CLASS 创建一个新的操作符类。
一个操作符类定义一种特定的数据类型如何与索引一起使用。操作符类指定某些操作符将为该数据类型和此索引方法填充特定角色或 “策略”。操作符类还指定在选择操作符类作为索引列时，索引方法要使用的支持函数。所有操作符类使用的操作符和函数必须在创建操作符类之前定义。
如果给出了一个模式名称，那么该操作符类会被创建在指定模式中。否则，它
会被创建在当前模式中。同一模式中的两个操作符类只有在用于不同的索引
方法时才可以具有相同的名称。
定义操作符类的用户将成为其拥有者。当前，创建用户必须是超级用户（这种
限制是因为错误的操作符类定义可能会混淆甚至崩溃服务器）。
CREATE OPERATOR CLASS 当前不会检查操作符
类定义是否包括该索引方法所要求的所有操作符和函数，也不会检查这些操作符
和函数是否构成一个自洽的集合。定义一个有效的操作符类是用户的责任。
相关的操作符类可以被组成操作符族。要把一个新的操作符类
加入到一个现有的族中，可以在CREATE OPERATOR
CLASS中指定FAMILY选项。如果没有这个选项，
新的类会被放到一个同名的族中（如果族不存在会创建该族）。
进一步的信息可参考第 36.16 节。
参数name
要创建的操作符类的名称。该名称可以被模式限定。
DEFAULT
如果存在，该操作符类将成为其数据类型的默认操作符类。对一种
特定的数据类型和索引方法至多有一个默认操作符类。
data_type
这个操作符类所用于的列数据类型。
index_method
这个操作符类所用于的索引方法的名称。
family_name
要把这个操作符类加入其中的已有操作符族的名称。如果没有指定，
将使用一个同名操作符族（如果还不存在则创建该族）。
strategy_number
操作符类相关联的操作符的索引方法策略号。
operator_name
与该操作符类相关联的操作符的名称（可以被模式限定）。
op_type
在一个OPERATOR子句中，这表示该操作符的操作数数据
类型，或者用NONE来表示一个前缀操作符。操作数数据
类型可以在与操作符类的数据类型相同的一般情况下省略。
在一个FUNCTION子句中，这表示该函数要支持的操作数
数据类型，如果它与该函数的输入数据类型（对于 B-树比较函数和哈希
函数）或者操作符类的数据类型（对于 B-树排序支持函数、B-树相等图像
函数以及所有GiST、SP-GiST、GIN和BRIN操作符类中的函数）不同。这些
默认值是正确的，因此op_type
在FUNCTION子句中不必指定，除非是用于支持跨数据类型
比较的B-树排序支持函数。
sort_family_name
一个现有btree操作符族的名称（可以是模式限定的），
它描述与一种排序操作符相关联的排序顺序。
如果既没有指定FOR SEARCH也没有指定FOR ORDER BY，
则默认值为FOR SEARCH。
support_number
与该操作符类相关联的函数的索引方法支持函数编号。
function_name
一个用于该操作符类的索引方法支持函数的函数名称（可以是
模式限定的）。
argument_type
该函数的参数数据类型。
storage_type
实际存储在索引中的数据类型。通常这和列数据类型相同，但是有些
索引方法（当前有 GiST、GIN、SP-GiST 和 BRIN）允许它们不同。
除非索引方法允许使用不同的类型，STORAGE 子句必须
被省略。
如果data_type列被指定为anyarray，
那么storage_type可以被声明为anyelement
以指示索引条目是属于为每个特定索引创建的实际数组类型的元素类型的成员。
OPERATOR、FUNCTION和STORAGE
子句可以以任何顺序出现。
备注
因为索引机制在使用函数之前不检查它们的权限，将一个函数或者操作符包括在
一个操作符类中相当于在其上授予公共执行权限。这对操作符类中很有用的函数
来说通常不成问题。
操作符不应该用 SQL 函数定义。SQL 函数很有可能会被内联到调用查询中，这
会妨碍优化器识别该查询匹配一个索引。
示例
下面的例子为数据类型_int4（int4数组）
定义了一个 GiST 索引操作符。完整的例子请见
intarray模块。
CREATE OPERATOR CLASS gist__int_ops
DEFAULT FOR TYPE _int4 USING gist AS
OPERATOR        3       &&,
OPERATOR        6       = (anyarray, anyarray),
OPERATOR        7       @>,
OPERATOR        8       <@,
OPERATOR        20      @@ (_int4, query_int),
FUNCTION        1       g_int_consistent (internal, _int4, smallint, oid, internal),
FUNCTION        2       g_int_union (internal, internal),
FUNCTION        3       g_int_compress (internal),
FUNCTION        4       g_int_decompress (internal),
FUNCTION        5       g_int_penalty (internal, internal, internal),
FUNCTION        6       g_int_picksplit (internal, internal),
FUNCTION        7       g_int_same (_int4, _int4, internal);
兼容性
CREATE OPERATOR CLASS 是一种
PostgreSQL 扩展。在 SQL 标准中没有
CREATE OPERATOR CLASS 语句。
另见ALTER OPERATOR CLASS, DROP OPERATOR CLASS, CREATE OPERATOR FAMILY, ALTER OPERATOR FAMILY上一页 上一级 下一页CREATE OPERATOR 起始页 CREATE OPERATOR FAMILY
