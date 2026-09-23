# ALTER FUNCTION

ALTER FUNCTION
版本：
纠错本页面
搜索
目录导航
❮
❯
ALTER FUNCTIONALTER FUNCTION — 更改函数的定义大纲
ALTER FUNCTION name [ ( [ [ argmode ] [ argname ] argtype [, ...] ] ) ]
action [ ... ] [ RESTRICT ]
ALTER FUNCTION name [ ( [ [ argmode ] [ argname ] argtype [, ...] ] ) ]
RENAME TO new_name
ALTER FUNCTION name [ ( [ [ argmode ] [ argname ] argtype [, ...] ] ) ]
OWNER TO { new_owner | CURRENT_ROLE | CURRENT_USER | SESSION_USER }
ALTER FUNCTION name [ ( [ [ argmode ] [ argname ] argtype [, ...] ] ) ]
SET SCHEMA new_schema
ALTER FUNCTION name [ ( [ [ argmode ] [ argname ] argtype [, ...] ] ) ]
[ NO ] DEPENDS ON EXTENSION extension_name
其中 action 是以下之一：
CALLED ON NULL INPUT | RETURNS NULL ON NULL INPUT | STRICT
IMMUTABLE | STABLE | VOLATILE
[ NOT ] LEAKPROOF
[ EXTERNAL ] SECURITY INVOKER | [ EXTERNAL ] SECURITY DEFINER
PARALLEL { UNSAFE | RESTRICTED | SAFE }
COST execution_cost
ROWS result_rows
SUPPORT support_function
SET configuration_parameter { TO | = } { value | DEFAULT }
SET configuration_parameter FROM CURRENT
RESET configuration_parameter
RESET ALL
描述
ALTER FUNCTION更改函数的定义。
您必须拥有该函数才能使用ALTER FUNCTION。
要更改函数的模式，您还必须拥有新模式的CREATE
权限。要更改所有者，您必须能够SET ROLE
为新的所有者角色，并且该角色必须拥有函数模式的
CREATE权限。（这些限制确保更改所有者不会
执行您通过删除和重新创建函数无法完成的操作。
然而，超级用户仍然可以更改任何函数的所有权。）
参数name
一个现有函数的名称（可以被模式限定）。如果没有指定参数列表，
则该名称必须在它的模式中唯一。
argmode
一个参数的模式：IN、OUT、
INOUT或者VARIADIC。如果被忽略，默认为
IN。注意ALTER FUNCTION
并不真正关心OUT参数，因为在决定函数的身份时只需要输
入参数。因此列出IN、INOUT以及
VARIADIC参数就可以。
argname
一个参数的名称。注意ALTER FUNCTION
并不真正关心参数名称，因为在确定函数的身份时只需要参数的数据类型。
argtype
该函数的参数（如果有）的数据类型（可以被模式限定）。
new_name
该函数的新名称。
new_owner
该函数的新拥有者。注意如果该函数被标记为
SECURITY DEFINER，它的后续执行将会使用新拥有者。
new_schema
该函数的新模式。
DEPENDS ON EXTENSION extension_nameNO DEPENDS ON EXTENSION extension_name
这个形式标记函数依赖于扩展，或者如果指定NO则不再依赖于该扩展。
当一个函数被标记为依赖于一个扩展时，即使没有指定CASCADE，当扩展被删除时该函数也会被删除。
一个函数可以依赖于多个扩展，当这些扩展中的任何一个被删除时，该函数也会被删除。
CALLED ON NULL INPUTRETURNS NULL ON NULL INPUTSTRICTCALLED ON NULL INPUT将该函数改为在某些
或者全部参数为空值时可以被调用。
RETURNS NULL ON NULL INPUT或者
STRICT将该函数改为只要任一参数为空值就不被调用而
是自动假定一个空值结果。详见CREATE FUNCTION。
IMMUTABLESTABLEVOLATILE
更改该函数的稳定性为指定的设置。详见
CREATE FUNCTION。
[ EXTERNAL ] SECURITY INVOKER[ EXTERNAL ] SECURITY DEFINER
更改该函数是否为安全性定义者。关键词EXTERNAL
为了符合 SQL，它会被忽略。关于这项能力的详情请见
CREATE FUNCTION。
PARALLEL
更改该函数是否被认为对并行安全。详见
CREATE FUNCTION。
LEAKPROOF
更改该函数是否被认为是防泄漏的。关于这项能力的详情请见
CREATE FUNCTION。
COST execution_cost
更改该函数的估计执行成本。详见CREATE FUNCTION。
ROWS result_rows
更改一个集合返回函数的估计返回行数。详见
CREATE FUNCTION。
SUPPORT support_function
设置或更改用于此函数的计划器支持函数。详见第 36.11 节，你必须是超级用户才能使用此选项。
此选项不能用于完全删除支持函数，因为它必须命名新的支持函数。
如果需要这样做，可以使用CREATE OR REPLACE FUNCTION。
configuration_parametervalue
当该函数被调用时，要对一个配置参数做出增加或者更改的赋值。如果
value是DEFAULT
或者使用等价的RESET，该函数本地的设置将会被
移除，这样该函数会使用其环境中存在的值执行。使用RESET
ALL可以清除所有函数本地的设置。
SET FROM CURRENT把ALTER FUNCTION
执行时该参数的当前值保存为进入
该函数时要应用的值。
有关允许的参数名称和值可详见SET以及
第 19 章。
RESTRICT
为了符合 SQL 标准而被忽略。
示例
要把用于类型integer的函数sqrt
重命名为square_root：
ALTER FUNCTION sqrt(integer) RENAME TO square_root;
要把用于类型integer的函数sqrt
的拥有者改为joe：
ALTER FUNCTION sqrt(integer) OWNER TO joe;
要把用于类型integer的函数sqrt
的模式改为maths：
ALTER FUNCTION sqrt(integer) SET SCHEMA maths;
要把类型integer的函数sqrt
标记为依赖于扩展mathlib：
ALTER FUNCTION sqrt(integer) DEPENDS ON EXTENSION mathlib;
要调整一个函数的自动搜索路径：
ALTER FUNCTION check_password(text) SET search_path = admin, pg_temp;
要禁止一个函数的search_path的自动设置：
ALTER FUNCTION check_password(text) RESET search_path;
该函数将用其调用者使用的搜索路径来执行。
兼容性
这个语句部分兼容 SQL 标准中的ALTER
FUNCTION语句。该标准允许修改一个函数的更多属性，但不提供
重命名一个函数、标记一个函数为安全性定义者、为一个函数附加配置参
数值或者更改一个函数的拥有者、模式或者稳定性等功能。该标准还要求
RESTRICT关键字，它在PostgreSQL
中是可选的。
另见CREATE FUNCTION, DROP FUNCTION, ALTER PROCEDURE, ALTER ROUTINE上一页 上一级 下一页ALTER FOREIGN TABLE 起始页 ALTER GROUP
