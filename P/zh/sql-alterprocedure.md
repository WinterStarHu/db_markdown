# ALTER PROCEDURE

ALTER PROCEDURE
版本：
纠错本页面
搜索
目录导航
❮
❯
ALTER PROCEDUREALTER PROCEDURE — 更改过程的定义大纲
ALTER PROCEDURE name [ ( [ [ argmode ] [ argname ] argtype [, ...] ] ) ]
action [ ... ] [ RESTRICT ]
ALTER PROCEDURE name [ ( [ [ argmode ] [ argname ] argtype [, ...] ] ) ]
RENAME TO new_name
ALTER PROCEDURE name [ ( [ [ argmode ] [ argname ] argtype [, ...] ] ) ]
OWNER TO { new_owner | CURRENT_ROLE | CURRENT_USER | SESSION_USER }
ALTER PROCEDURE name [ ( [ [ argmode ] [ argname ] argtype [, ...] ] ) ]
SET SCHEMA new_schema
ALTER PROCEDURE name [ ( [ [ argmode ] [ argname ] argtype [, ...] ] ) ]
[ NO ] DEPENDS ON EXTENSION extension_name
其中 action 是下列之一：
[ EXTERNAL ] SECURITY INVOKER | [ EXTERNAL ] SECURITY DEFINER
SET configuration_parameter { TO | = } { value | DEFAULT }
SET configuration_parameter FROM CURRENT
RESET configuration_parameter
RESET ALL
描述
ALTER PROCEDURE 更改过程的定义。
您必须拥有该过程才能使用 ALTER PROCEDURE。
要更改过程的模式，您还必须对新模式具有 CREATE
权限。
要更改所有者，您必须能够 SET ROLE 为新的所有者角色，
并且该角色必须对过程的模式具有 CREATE
权限。
（这些限制确保更改所有者不会做任何您通过删除和重新创建过程
无法完成的事情。然而，超级用户仍然可以更改任何过程的所有权。）
参数name
一个现有的过程的名字（可以被模式限定）。如果没有指定参数列表，这个名字必须在其模式中唯一。
argmode
参数的模式：IN, OUT,
INOUT, 或VARIADIC。如果省略，默认是IN。
argname
参数的名字。注意ALTER PROCEDURE实际上并不关心参数名，因为仅有参数的数据类型被用来确定过程的身份。
argtype
如果该过程有参数，这是参数的数据类型（可以被模式限定）。
有关如何使用参数数据类型来查找过程的详细信息，参见DROP PROCEDURE。
new_name
该过程的新名称。
new_owner
该过程的新拥有者。注意，如果该过程被标记为SECURITY DEFINER，接下来它将作为新拥有者执行。
new_schema
该过程的新模式。
extension_name
这个形式标记了过程是否依赖于扩展，如果指定了NO，则不再依赖于扩展。
当扩展被删除时，标记为依赖于扩展的过程也会被删除，即使没有指定级联。
一个过程可以依赖于多个扩展，当其中任何一个扩展被删除时，该过程将被删除。
[ EXTERNAL ] SECURITY INVOKER[ EXTERNAL ] SECURITY DEFINER
更改该过程是否为安全性定义器。关键词EXTERNAL由于SQL符合性的原因被忽略。更多有关此功能的信息请见CREATE PROCEDURE。
configuration_parametervalue
增加或者更改在调用该过程时，要对一个配置参数做的赋值。如果value是DEFAULT或者等效的值，则会使用RESET，过程本地的设置会被移除，这样该过程的执行就会使用其所处环境中的值。使用RESET ALL可以清除所有的过程本地设置。SET FROM CURRENT会把ALTER PROCEDURE执行时该参数的当前值保存为进入该过程时要被应用的值。
关于允许的参数名和参数值的更多信息请见SET和第 19 章。
RESTRICT
为了符合SQL标准会被忽略。
示例
要重命名具有两个integer类型参数的过程insert_data为insert_record：
ALTER PROCEDURE insert_data(integer, integer) RENAME TO insert_record;
要把具有两个integer类型参数的过程insert_data的拥有者改为joe：
ALTER PROCEDURE insert_data(integer, integer) OWNER TO joe;
要把具有两个integer类型参数的过程insert_data的方案改为accounting：
ALTER PROCEDURE insert_data(integer, integer) SET SCHEMA accounting;
把过程insert_data(integer, integer)标记为依赖于扩展myext：
ALTER PROCEDURE insert_data(integer, integer) DEPENDS ON EXTENSION myext;
要调整一个过程自动设置的搜索路径：
ALTER PROCEDURE check_password(text) SET search_path = admin, pg_temp;
要为一个过程禁用search_path的自动设置：
ALTER PROCEDURE check_password(text) RESET search_path;
现在这个过程将用其调用者所使用的任何搜索路径执行。
兼容性
这个语句与SQL标准中的ALTER PROCEDURE语句部分兼容。标准允许修改一个过程的更多属性，但是不提供重命名过程、让过程成为安全性定义器、为过程附加配置参数值或者更改过程的拥有者、模式或者可变性的能力。标准还要求RESTRICT关键字，而它在PostgreSQL中是可选的。
另见CREATE PROCEDURE, DROP PROCEDURE, ALTER FUNCTION, ALTER ROUTINE上一页 上一级 下一页ALTER POLICY 起始页 ALTER PUBLICATION
