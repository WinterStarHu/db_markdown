# ALTER ROUTINE

ALTER ROUTINE
版本：
纠错本页面
搜索
目录导航
❮
❯
ALTER ROUTINEALTER ROUTINE — 更改例程的定义大纲
ALTER ROUTINE name [ ( [ [ argmode ] [ argname ] argtype [, ...] ] ) ]
action [ ... ] [ RESTRICT ]
ALTER ROUTINE name [ ( [ [ argmode ] [ argname ] argtype [, ...] ] ) ]
RENAME TO new_name
ALTER ROUTINE name [ ( [ [ argmode ] [ argname ] argtype [, ...] ] ) ]
OWNER TO { new_owner | CURRENT_ROLE | CURRENT_USER | SESSION_USER }
ALTER ROUTINE name [ ( [ [ argmode ] [ argname ] argtype [, ...] ] ) ]
SET SCHEMA new_schema
ALTER ROUTINE name [ ( [ [ argmode ] [ argname ] argtype [, ...] ] ) ]
[ NO ] DEPENDS ON EXTENSION extension_name
其中 action 是下列之一：
IMMUTABLE | STABLE | VOLATILE
[ NOT ] LEAKPROOF
[ EXTERNAL ] SECURITY INVOKER | [ EXTERNAL ] SECURITY DEFINER
PARALLEL { UNSAFE | RESTRICTED | SAFE }
COST execution_cost
ROWS result_rows
SET configuration_parameter { TO | = } { value | DEFAULT }
SET configuration_parameter FROM CURRENT
RESET configuration_parameter
RESET ALL
描述
ALTER ROUTINE更改例程的定义，它可以是聚集函数、普通函数或者过程。参数的描述、更多的例子以及进一步的细节请参考ALTER AGGREGATE、ALTER FUNCTION以及ALTER PROCEDURE。
示例
将类型integer的例程foo重命名为foobar：
ALTER ROUTINE foo(integer) RENAME TO foobar;
不管foo是聚集、函数还是过程，这个命令都能使用。
兼容性
这个语句与SQL标准中的ALTER ROUTINE语句部分兼容。更多细节请参考ALTER FUNCTION和ALTER PROCEDURE。允许例程名称引用聚合函数是一种PostgreSQL的扩展。
另见ALTER AGGREGATE, ALTER FUNCTION, ALTER PROCEDURE, DROP ROUTINE
注意没有CREATE ROUTINE命令。
上一页 上一级 下一页ALTER ROLE 起始页 ALTER RULE
