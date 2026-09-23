# ALTER DEFAULT PRIVILEGES

ALTER DEFAULT PRIVILEGES
版本：
纠错本页面
搜索
目录导航
❮
❯
ALTER DEFAULT PRIVILEGESALTER DEFAULT PRIVILEGES — 定义默认访问权限大纲
ALTER DEFAULT PRIVILEGES
[ FOR { ROLE | USER } target_role [, ...] ]
[ IN SCHEMA schema_name [, ...] ]
abbreviated_grant_or_revoke
其中 abbreviated_grant_or_revoke 是以下之一：
GRANT { { SELECT | INSERT | UPDATE | DELETE | TRUNCATE | REFERENCES | TRIGGER | MAINTAIN }
[, ...] | ALL [ PRIVILEGES ] }
ON TABLES
TO { [ GROUP ] role_name | PUBLIC } [, ...] [ WITH GRANT OPTION ]
GRANT { { USAGE | SELECT | UPDATE }
[, ...] | ALL [ PRIVILEGES ] }
ON SEQUENCES
TO { [ GROUP ] role_name | PUBLIC } [, ...] [ WITH GRANT OPTION ]
GRANT { EXECUTE | ALL [ PRIVILEGES ] }
ON { FUNCTIONS | ROUTINES }
TO { [ GROUP ] role_name | PUBLIC } [, ...] [ WITH GRANT OPTION ]
GRANT { USAGE | ALL [ PRIVILEGES ] }
ON TYPES
TO { [ GROUP ] role_name | PUBLIC } [, ...] [ WITH GRANT OPTION ]
GRANT { { USAGE | CREATE }
[, ...] | ALL [ PRIVILEGES ] }
ON SCHEMAS
TO { [ GROUP ] role_name | PUBLIC } [, ...] [ WITH GRANT OPTION ]
GRANT { { SELECT | UPDATE }
[, ...] | ALL [ PRIVILEGES ] }
ON LARGE OBJECTS
TO { [ GROUP ] role_name | PUBLIC } [, ...] [ WITH GRANT OPTION ]
REVOKE [ GRANT OPTION FOR ]
{ { SELECT | INSERT | UPDATE | DELETE | TRUNCATE | REFERENCES | TRIGGER | MAINTAIN }
[, ...] | ALL [ PRIVILEGES ] }
ON TABLES
FROM { [ GROUP ] role_name | PUBLIC } [, ...]
[ CASCADE | RESTRICT ]
REVOKE [ GRANT OPTION FOR ]
{ { USAGE | SELECT | UPDATE }
[, ...] | ALL [ PRIVILEGES ] }
ON SEQUENCES
FROM { [ GROUP ] role_name | PUBLIC } [, ...]
[ CASCADE | RESTRICT ]
REVOKE [ GRANT OPTION FOR ]
{ EXECUTE | ALL [ PRIVILEGES ] }
ON { FUNCTIONS | ROUTINES }
FROM { [ GROUP ] role_name | PUBLIC } [, ...]
[ CASCADE | RESTRICT ]
REVOKE [ GRANT OPTION FOR ]
{ USAGE | ALL [ PRIVILEGES ] }
ON TYPES
FROM { [ GROUP ] role_name | PUBLIC } [, ...]
[ CASCADE | RESTRICT ]
REVOKE [ GRANT OPTION FOR ]
{ { USAGE | CREATE }
[, ...] | ALL [ PRIVILEGES ] }
ON SCHEMAS
FROM { [ GROUP ] role_name | PUBLIC } [, ...]
[ CASCADE | RESTRICT ]
REVOKE [ GRANT OPTION FOR ]
{ { SELECT | UPDATE }
[, ...] | ALL [ PRIVILEGES ] }
ON LARGE OBJECTS
FROM { [ GROUP ] role_name | PUBLIC } [, ...]
[ CASCADE | RESTRICT ]
描述
ALTER DEFAULT PRIVILEGES允许您设置将来创建的对象
所适用的权限。（它不会影响已存在对象的权限。）权限可以全局设置
（即，对当前数据库中创建的所有对象），或者仅针对在指定模式中创
建的对象。
虽然您可以更改自己的默认权限以及您所属角色的默认权限，但在对象创建
时，新对象的权限仅受当前角色的默认权限影响，而不会继承当前角色所属
的任何角色的权限。
如第 5.8 节中所述，用于任何对象类型的默认权限通常会把所有可授予的权限授予给对象拥有者，并且也可能授予一些权限给PUBLIC。不过，这种行为可以通过使用ALTER DEFAULT PRIVILEGES修改全局默认权限来改变。
目前，
只有模式、表（包括视图和外部表）、序列、函数、类型（包括域）和大对象的权限
可以被更改。  对于此命令，函数包括聚合和过程。
在此命令中，FUNCTIONS 和 ROUTINES 是等效的。
（ROUTINES 是今后作为函数和过程的标准术语。
在早期的 PostgreSQL 版本中，只允许使用 FUNCTIONS 一词。
不可能单独为函数和过程设置默认权限。）
每个模式规定的默认权限将添加到特定对象类型的全局默认权限的内容中。
这意味着你不能撤销每个模式的权限，如果它们已经被全局授予（默认情况下，或者根据以前未规定模式的ALTER DEFAULT PRIVILEGES命令）。
每个模式的REVOKE仅用于反转以前每个模式GRANT的影响。
参数target_role
更改由target_role创建的对象的默认权限，
如果未指定，则为当前角色。
schema_name
现有模式的名称。如果指定，则默认权限
会被更改为在该模式中稍后创建的对象。
如果省略 IN SCHEMA，则全局默认权限会被更改。
在为模式和大对象设置权限时，不允许使用 IN SCHEMA，
因为模式不能嵌套，而大对象不属于任何模式。
role_name
要为其授予或者收回权限的一个现有角色的名称。这个参数以及所有abbreviated_grant_or_revoke中的其他参数会按照GRANT或者REVOKE中描述的方式运作，不过这里是为一整类的对象而不是特别指定的对象设置权限。
注意事项
使用psql的\ddp命令可以获得关于默认权限的现有分配信息。
权限显示的含义和第 5.8 节中的\dp描述的相同。
如果你希望删除一个默认权限被修改的角色，有必要撤销其默认权限上的改变或者使用DROP OWNED BY来为该角色去除默认权限项。
示例
为你后续在模式myschema中创建的所有表（和视图）授予 SELECT 特权，并且也允许角色webuser向它们插入数据：
ALTER DEFAULT PRIVILEGES IN SCHEMA myschema GRANT SELECT ON TABLES TO PUBLIC;
ALTER DEFAULT PRIVILEGES IN SCHEMA myschema GRANT INSERT ON TABLES TO webuser;
撤销上面的动作，因此后续创建的表不会有任何比正常更多的权限：
ALTER DEFAULT PRIVILEGES IN SCHEMA myschema REVOKE SELECT ON TABLES FROM PUBLIC;
ALTER DEFAULT PRIVILEGES IN SCHEMA myschema REVOKE INSERT ON TABLES FROM webuser;
为后续由角色admin创建的所有函数移除通常在函数上会授予的公共 EXECUTE 权限：
ALTER DEFAULT PRIVILEGES FOR ROLE admin REVOKE EXECUTE ON FUNCTIONS FROM PUBLIC;
但是注意你不能使用限制为单个模式的命令来实现该效果。
此命令不起作用，除非它撤消匹配的GRANT：
ALTER DEFAULT PRIVILEGES IN SCHEMA public REVOKE EXECUTE ON FUNCTIONS FROM PUBLIC;
这是因为每个模式的默认特权只能向全局设置添加特权，而不能移除它授予的特权。
兼容性
在 SQL 标准中没有ALTER DEFAULT PRIVILEGES语句。
参见GRANT, REVOKE上一页 上一级 下一页ALTER DATABASE 起始页 ALTER DOMAIN
