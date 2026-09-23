# REVOKE

REVOKE
版本：
纠错本页面
搜索
目录导航
❮
❯
REVOKEREVOKE — 移除访问权限大纲
REVOKE [ GRANT OPTION FOR ]
{ { SELECT | INSERT | UPDATE | DELETE | TRUNCATE | REFERENCES | TRIGGER | MAINTAIN }
[, ...] | ALL [ PRIVILEGES ] }
ON { [ TABLE ] table_name [, ...]
| ALL TABLES IN SCHEMA schema_name [, ...] }
FROM role_specification [, ...]
[ GRANTED BY role_specification ]
[ CASCADE | RESTRICT ]
REVOKE [ GRANT OPTION FOR ]
{ { SELECT | INSERT | UPDATE | REFERENCES } ( column_name [, ...] )
[, ...] | ALL [ PRIVILEGES ] ( column_name [, ...] ) }
ON [ TABLE ] table_name [, ...]
FROM role_specification [, ...]
[ GRANTED BY role_specification ]
[ CASCADE | RESTRICT ]
REVOKE [ GRANT OPTION FOR ]
{ { USAGE | SELECT | UPDATE }
[, ...] | ALL [ PRIVILEGES ] }
ON { SEQUENCE sequence_name [, ...]
| ALL SEQUENCES IN SCHEMA schema_name [, ...] }
FROM role_specification [, ...]
[ GRANTED BY role_specification ]
[ CASCADE | RESTRICT ]
REVOKE [ GRANT OPTION FOR ]
{ { CREATE | CONNECT | TEMPORARY | TEMP } [, ...] | ALL [ PRIVILEGES ] }
ON DATABASE database_name [, ...]
FROM role_specification [, ...]
[ GRANTED BY role_specification ]
[ CASCADE | RESTRICT ]
REVOKE [ GRANT OPTION FOR ]
{ USAGE | ALL [ PRIVILEGES ] }
ON DOMAIN domain_name [, ...]
FROM role_specification [, ...]
[ GRANTED BY role_specification ]
[ CASCADE | RESTRICT ]
REVOKE [ GRANT OPTION FOR ]
{ USAGE | ALL [ PRIVILEGES ] }
ON FOREIGN DATA WRAPPER fdw_name [, ...]
FROM role_specification [, ...]
[ GRANTED BY role_specification ]
[ CASCADE | RESTRICT ]
REVOKE [ GRANT OPTION FOR ]
{ USAGE | ALL [ PRIVILEGES ] }
ON FOREIGN SERVER server_name [, ...]
FROM role_specification [, ...]
[ GRANTED BY role_specification ]
[ CASCADE | RESTRICT ]
REVOKE [ GRANT OPTION FOR ]
{ EXECUTE | ALL [ PRIVILEGES ] }
ON { { FUNCTION | PROCEDURE | ROUTINE } function_name [ ( [ [ argmode ] [ arg_name ] arg_type [, ...] ] ) ] [, ...]
| ALL { FUNCTIONS | PROCEDURES | ROUTINES } IN SCHEMA schema_name [, ...] }
FROM role_specification [, ...]
[ GRANTED BY role_specification ]
[ CASCADE | RESTRICT ]
REVOKE [ GRANT OPTION FOR ]
{ USAGE | ALL [ PRIVILEGES ] }
ON LANGUAGE lang_name [, ...]
FROM role_specification [, ...]
[ GRANTED BY role_specification ]
[ CASCADE | RESTRICT ]
REVOKE [ GRANT OPTION FOR ]
{ { SELECT | UPDATE } [, ...] | ALL [ PRIVILEGES ] }
ON LARGE OBJECT loid [, ...]
FROM role_specification [, ...]
[ GRANTED BY role_specification ]
[ CASCADE | RESTRICT ]
REVOKE [ GRANT OPTION FOR ]
{ { SET | ALTER SYSTEM } [, ...] | ALL [ PRIVILEGES ] }
ON PARAMETER configuration_parameter [, ...]
FROM role_specification [, ...]
[ GRANTED BY role_specification ]
[ CASCADE | RESTRICT ]
REVOKE [ GRANT OPTION FOR ]
{ { CREATE | USAGE } [, ...] | ALL [ PRIVILEGES ] }
ON SCHEMA schema_name [, ...]
FROM role_specification [, ...]
[ GRANTED BY role_specification ]
[ CASCADE | RESTRICT ]
REVOKE [ GRANT OPTION FOR ]
{ CREATE | ALL [ PRIVILEGES ] }
ON TABLESPACE tablespace_name [, ...]
FROM role_specification [, ...]
[ GRANTED BY role_specification ]
[ CASCADE | RESTRICT ]
REVOKE [ GRANT OPTION FOR ]
{ USAGE | ALL [ PRIVILEGES ] }
ON TYPE type_name [, ...]
FROM role_specification [, ...]
[ GRANTED BY role_specification ]
[ CASCADE | RESTRICT ]
REVOKE [ { ADMIN | INHERIT | SET } OPTION FOR ]
role_name [, ...] FROM role_specification [, ...]
[ GRANTED BY role_specification ]
[ CASCADE | RESTRICT ]
其中 role_specification 可以是：
[ GROUP ] role_name
| PUBLIC
| CURRENT_ROLE
| CURRENT_USER
| SESSION_USER
描述
REVOKE命令收回之前从一个或多个角色
授予的特权。关键词PUBLIC指的是隐式定义的所有角色的组。
特权类型的含义见GRANT命令的描述。
注意任何特定角色拥有的特权包括直接授予给它的特权、从它作为其成员的
角色中得到的特权以及授予给PUBLIC的特权。因此，
从PUBLIC收回SELECT特权并不一定会意味
着所有角色都会失去在该对象上的SELECT特权：那些直接被授
予的或者通过另一个角色被授予的角色仍然会拥有它。类似地，从一个用户
收回SELECT后，如果PUBLIC或者另一个
成员角色仍有SELECT权利，该用户还是可以使用
SELECT。
如果指定了GRANT OPTION FOR，只会回收该特权
的授予选项，特权本身不被回收。否则，特权及其授予选项都会被回收。
如果一个用户持有一个带有授予选项的特权并且把它授予给了其他用户，
那么被那些其他用户持有的该特权被称为依赖特权。如果第一个用户持有
的该特权或者授予选项正在被收回且存在依赖特权，指定
CASCADE可以连带回收那些依赖特权，不指定则会
导致回收动作失败。这种递归回收只影响通过可追溯到该
REVOKE命令的主体的用户链授予的特权。因此，
如果该特权经由其他用户授予给受影响用户，受影响用户可能实际上还
保留有该特权。
在回收一个表上的特权时，也会在该表的每一个列上自动回收对应的列
特权（如果有）。另一方面，如果一个角色已经被授予一个表上的
特权，那么从个别的列上回收同一个特权将不会生效。
当撤销角色的成员资格时，GRANT OPTION被称为
ADMIN OPTION，但行为类似。
请注意，在PostgreSQL 16之前的版本中，
对角色成员资格的授权未跟踪相关的依赖权限，
因此CASCADE对角色成员资格没有效果。
现在情况已不再如此。
另请注意，此命令形式不允许在
role_specification中使用噪声词
GROUP。
就像可以从现有角色授予中移除ADMIN OPTION一样，也可以撤销
INHERIT OPTION或SET OPTION。这相当于将相应选
项的值设置为FALSE。
Notes
用户只能回收由其直接授出的特权。例如，如果用户 A 已经把一个带有
授予选项的特权授予给了用户 B，并且用户 B 接着把它授予给了用户 C，
那么用户 A 无法直接从 C 收回该特权。相反，用户 A 可以从用户 B 收回
该授予选项并且使用CASCADE选项，这样该特权会被
依次从用户 C 回收。对于另一个例子，如果 A 和 B 都把同一个特权授予
给 C，A 能够收回他们自己的授权但不能收回 B 的授权，因此 C 实际上
仍将拥有该特权。
当一个对象的非拥有者尝试REVOKE该对象上的特权时，
如果该用户在该对象上什么特权都不拥有，该命令会立刻失败。只要有某个
特权可用，该命令将继续，但是它只会收回那些它具有授予选项的特权。
如果没有持有授予选项，REVOKE ALL PRIVILEGES形式
将发出一个警告，而其他形式在没有持有该命令中特别提到的任何特权的
授予选项时就会发出警告（原则上，这些语句也适用于对象拥有者，但是
由于拥有者总是被认为持有所有授予选项，这些情况永远不会发生）。
如果超级用户选择执行GRANT或REVOKE
命令，该命令将以受影响对象所有者的身份执行。（由于角色没有所有者，
在GRANT角色成员资格的情况下，该命令将以引导超级用户
的身份执行。）由于所有权限最终都来自对象所有者（可能通过授予选项链
间接获得），超级用户可以撤销所有权限，但这可能需要如上所述使用
CASCADE。
REVOKE也可以由一个并非受影响对象的拥有者的角色
完成，但是该角色应该是一个拥有该对象的角色的成员或者是一个在该对象
上拥有特权的WITH GRANT OPTION的角色的成员。
在这种情况下，该命令就好像被实际拥有该对象或者特权的
WITH GRANT OPTION的包含角色发出的一样被执行。
例如，如果表t1被角色g1拥有，而u1
是g1的一个成员，那么u1能收回t1
上被记录为由g1授予的特权。这会包括由u1
以及由角色g1的其他成员完成的授予。
如果执行REVOKE的角色持有通过多于一条角色成员
关系路径间接得到的特权，其中哪一条包含将被用于执行该命令的
角色是没有被指明的。在这种情况下，最好使用
SET ROLE成为你想作为其身份执行
REVOKE的特定角色。如果无法做到这一点
可能会导致收回超过你预期的特权，或者根本收回不了任何东西。
关于特定权限类型的更多信息请参见 第 5.8 节 , 以及如何检查对象的权限。
示例
从 public 收回表films上的插入特权：
REVOKE INSERT ON films FROM PUBLIC;
从用户manuel收回视图
kinds上的所有特权：
REVOKE ALL PRIVILEGES ON kinds FROM manuel;
注意这实际上意味着“收回所有我授予的特权”。
从用户joe收回角色admins中的成员关系：
REVOKE admins FROM joe;
兼容性
GRANT命令的兼容性注解同样适用于
REVOKE。根据标准，关键词
RESTRICT或CASCADE
是必要的，但是PostgreSQL默认假定为
RESTRICT。
其他GRANT, ALTER DEFAULT PRIVILEGES上一页 上一级 下一页RESET 起始页 ROLLBACK
