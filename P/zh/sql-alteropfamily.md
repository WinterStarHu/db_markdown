# ALTER OPERATOR FAMILY

ALTER OPERATOR FAMILY
版本：
纠错本页面
搜索
目录导航
❮
❯
ALTER OPERATOR FAMILYALTER OPERATOR FAMILY — 更改操作符族的定义大纲
ALTER OPERATOR FAMILY name USING index_method ADD
{  OPERATOR strategy_number operator_name ( op_type, op_type )
[ FOR SEARCH | FOR ORDER BY sort_family_name ]
| FUNCTION support_number [ ( op_type [ , op_type ] ) ]
function_name [ ( argument_type [, ...] ) ]
} [, ... ]
ALTER OPERATOR FAMILY name USING index_method DROP
{  OPERATOR strategy_number ( op_type [ , op_type ] )
| FUNCTION support_number ( op_type [ , op_type ] )
} [, ... ]
ALTER OPERATOR FAMILY name USING index_method
RENAME TO new_name
ALTER OPERATOR FAMILY name USING index_method
OWNER TO { new_owner | CURRENT_ROLE | CURRENT_USER | SESSION_USER }
ALTER OPERATOR FAMILY name USING index_method
SET SCHEMA new_schema
描述
ALTER OPERATOR FAMILY更改操作符族的定义。你可以增加操作符
和支持函数到该族中，移除它们，或者更改该族的名称或拥有者。
当用ALTER OPERATOR FAMILY向一个族中添加操作符和支持函数时，
它们并不是该族内任何特定操作符类的一部分，而只是“松散”地存在于
该族中。这表示这些操作符和函数与该族的语义兼容，但并不是任何特定索引
正确功能所必需的。（所需的操作符和函数应该作为操作符类的一部分声明，见
CREATE OPERATOR CLASS。）PostgreSQL允许
一个族的松散成员在任何时候被删除，但操作符类的成员在删除之前必须先删除
整个类及其依赖的索引。通常，单一数据类型的操作符和函数是操作符类的一部分，
因为它们需要支持特定数据类型的索引，而跨数据类型的操作符和函数则作为
该族的松散成员。
要使用ALTER OPERATOR FAMILY，你必须是超级用户（此限制是
因为错误的操作符族定义可能会混淆或甚至使服务器崩溃）。
ALTER OPERATOR FAMILY目前不检查操作符族定义是否包括索引方法
所需的所有操作符和函数，也不检查操作符和函数是否形成一个自洽的集合。
定义一个有效的操作符族是用户的责任。
进一步的信息请参考第 36.16 节。
参数name
一个现有操作符族的名称（可以是模式限定的）。
index_method
这个操作符族所应用的索引方法的名称。
strategy_number
与该操作符族相关的一个操作符的索引方法策略号。
operator_name
与该操作符族相关的一个操作符的名称（可以是模式限定的）。
op_type
在一个OPERATOR子句中指定该操作符的操作数数据类型，
或者用NONE来表示一个前缀操作符。不同于
CREATE OPERATOR CLASS中类似的语法，操作数数据
类型总是必须被指定。
在一个ADD FUNCTION子句中指定该函数意图支持的操作数
数据类型（如果不同于该函数的输入数据类型）。对于 B-树比较函数和哈希
函数，不必指定op_type，因为该函数的输入数据类型
总是正确的。对于B树排序支持功能，B树相等的图像函数以及GiST，SP-GiST和
GIN运算符类中的所有函数，必须指定要与该函数一起使用的操作数数据类型。
在一个DROP FUNCTION子句中，必须指定该函数要支持的操作数数据类型。
sort_family_name
一个现有btree操作符族的名称（可能是模式限定的），
它描述与一个排序操作符相关的排序顺序。
如果既没有指定FOR SEARCH也没有指定FOR ORDER BY，
默认值是FOR SEARCH。
support_number
一个与该操作符族相关的函数的索引方法支持函数编号。
function_name
作为该操作符族的一种索引方法支持函数的函数名称（可以是模式限定的）。
如果没有指定参数列表，则该名称必须在其模式中唯一。
argument_type
该函数的参数数据类型。
new_name
该操作符族的新名称。
new_owner
该操作符族的新拥有者。
new_schema
操作符族的新模式。
OPERATOR 和 FUNCTION 子句可以以任何顺序出现。
注释
注意 DROP 语法只通过策略或支持号以及输入数据类型指定该
操作符族中的 “slot”。占用这个槽的操作符或函数的名称不会被提及。
另外，对于 DROP FUNCTION，要指定的类型是该函数意图支持
的输入数据类型；对于 GiST、SP-GiST 和 GIN 索引，这可能与该函数的实际
输入参数类型无关。
因为索引机制在使用函数之前不会检查其上的访问权限，包括一个操作符族中的
函数或操作符都等同于授予了其上的公共执行权限。这对于操作符族中很有用的
这类函数来说，这通常不成问题。
操作符不应由 SQL 函数定义。一个 SQL 函数很可能被内联到调用查询中，这将
阻止优化器识别出该查询匹配一个索引。
示例
下列示例命令为一个操作符族增加跨数据类型的操作符和支持函数，该操
作符族已经包含用于数据类型 int4 和 int2 的 B-树
操作符类。
ALTER OPERATOR FAMILY integer_ops USING btree ADD
-- int4 vs int2
OPERATOR 1 < (int4, int2) ,
OPERATOR 2 <= (int4, int2) ,
OPERATOR 3 = (int4, int2) ,
OPERATOR 4 >= (int4, int2) ,
OPERATOR 5 > (int4, int2) ,
FUNCTION 1 btint42cmp(int4, int2) ,
-- int2 vs int4
OPERATOR 1 < (int2, int4) ,
OPERATOR 2 <= (int2, int4) ,
OPERATOR 3 = (int2, int4) ,
OPERATOR 4 >= (int2, int4) ,
OPERATOR 5 > (int2, int4) ,
FUNCTION 1 btint24cmp(int2, int4) ;
再次移除这些条目：
ALTER OPERATOR FAMILY integer_ops USING btree DROP
-- int4 vs int2
OPERATOR 1 (int4, int2) ,
OPERATOR 2 (int4, int2) ,
OPERATOR 3 (int4, int2) ,
OPERATOR 4 (int4, int2) ,
OPERATOR 5 (int4, int2) ,
FUNCTION 1 (int4, int2) ,
-- int2 vs int4
OPERATOR 1 (int2, int4) ,
OPERATOR 2 (int2, int4) ,
OPERATOR 3 (int2, int4) ,
OPERATOR 4 (int2, int4) ,
OPERATOR 5 (int2, int4) ,
FUNCTION 1 (int2, int4) ;
兼容性
在 SQL 标准中没有
ALTER OPERATOR FAMILY语句。
其他CREATE OPERATOR FAMILY, DROP OPERATOR FAMILY, CREATE OPERATOR CLASS, ALTER OPERATOR CLASS, DROP OPERATOR CLASS上一页 上一级 下一页ALTER OPERATOR CLASS 起始页 ALTER POLICY
