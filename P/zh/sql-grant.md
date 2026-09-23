# GRANT

GRANT
版本：
纠错本页面
搜索
目录导航
❮
❯
GRANTGRANT — 定义访问权限大纲
GRANT { { SELECT | INSERT | UPDATE | DELETE | TRUNCATE | REFERENCES | TRIGGER | MAINTAIN }
[, ...] | ALL [ PRIVILEGES ] }
ON { [ TABLE ] table_name [, ...]
| ALL TABLES IN SCHEMA schema_name [, ...] }
TO role_specification [, ...] [ WITH GRANT OPTION ]
[ GRANTED BY role_specification ]
GRANT { { SELECT | INSERT | UPDATE | REFERENCES } ( column_name [, ...] )
[, ...] | ALL [ PRIVILEGES ] ( column_name [, ...] ) }
ON [ TABLE ] table_name [, ...]
TO role_specification [, ...] [ WITH GRANT OPTION ]
[ GRANTED BY role_specification ]
GRANT { { USAGE | SELECT | UPDATE }
[, ...] | ALL [ PRIVILEGES ] }
ON { SEQUENCE sequence_name [, ...]
| ALL SEQUENCES IN SCHEMA schema_name [, ...] }
TO role_specification [, ...] [ WITH GRANT OPTION ]
[ GRANTED BY role_specification ]
GRANT { { CREATE | CONNECT | TEMPORARY | TEMP } [, ...] | ALL [ PRIVILEGES ] }
ON DATABASE database_name [, ...]
TO role_specification [, ...] [ WITH GRANT OPTION ]
[ GRANTED BY role_specification ]
GRANT { USAGE | ALL [ PRIVILEGES ] }
ON DOMAIN domain_name [, ...]
TO role_specification [, ...] [ WITH GRANT OPTION ]
[ GRANTED BY role_specification ]
GRANT { USAGE | ALL [ PRIVILEGES ] }
ON FOREIGN DATA WRAPPER fdw_name [, ...]
TO role_specification [, ...] [ WITH GRANT OPTION ]
[ GRANTED BY role_specification ]
GRANT { USAGE | ALL [ PRIVILEGES ] }
ON FOREIGN SERVER server_name [, ...]
TO role_specification [, ...] [ WITH GRANT OPTION ]
[ GRANTED BY role_specification ]
GRANT { EXECUTE | ALL [ PRIVILEGES ] }
ON { { FUNCTION | PROCEDURE | ROUTINE } routine_name [ ( [ [ argmode ] [ arg_name ] arg_type [, ...] ] ) ] [, ...]
| ALL { FUNCTIONS | PROCEDURES | ROUTINES } IN SCHEMA schema_name [, ...] }
TO role_specification [, ...] [ WITH GRANT OPTION ]
[ GRANTED BY role_specification ]
GRANT { USAGE | ALL [ PRIVILEGES ] }
ON LANGUAGE lang_name [, ...]
TO role_specification [, ...] [ WITH GRANT OPTION ]
[ GRANTED BY role_specification ]
GRANT { { SELECT | UPDATE } [, ...] | ALL [ PRIVILEGES ] }
ON LARGE OBJECT loid [, ...]
TO role_specification [, ...] [ WITH GRANT OPTION ]
[ GRANTED BY role_specification ]
GRANT { { SET | ALTER SYSTEM } [, ... ] | ALL [ PRIVILEGES ] }
ON PARAMETER configuration_parameter [, ...]
TO role_specification [, ...] [ WITH GRANT OPTION ]
[ GRANTED BY role_specification ]
GRANT { { CREATE | USAGE } [, ...] | ALL [ PRIVILEGES ] }
ON SCHEMA schema_name [, ...]
TO role_specification [, ...] [ WITH GRANT OPTION ]
[ GRANTED BY role_specification ]
GRANT { CREATE | ALL [ PRIVILEGES ] }
ON TABLESPACE tablespace_name [, ...]
TO role_specification [, ...] [ WITH GRANT OPTION ]
[ GRANTED BY role_specification ]
GRANT { USAGE | ALL [ PRIVILEGES ] }
ON TYPE type_name [, ...]
TO role_specification [, ...] [ WITH GRANT OPTION ]
[ GRANTED BY role_specification ]
GRANT role_name [, ...] TO role_specification [, ...]
[ WITH { ADMIN | INHERIT | SET } { OPTION | TRUE | FALSE } ]
[ GRANTED BY role_specification ]
其中 role_specification 可以是：
[ GROUP ] role_name
| PUBLIC
| CURRENT_ROLE
| CURRENT_USER
| SESSION_USER
描述
GRANT命令有两个基本变体：一个是在数据库对象（表、列、视图、外部表、序列、数据库、外部数据包装器、外部服务器、函数、过程、过程语言、大对象、配置参数、模式、表空间或类型）上授予权限，另一个是授予角色的成员资格。这些变体在许多方面都很相似，但它们有足够的不同之处，需要分别描述。
在数据库对象上 GRANT
这种GRANT命令的变体将一个数据库对象上的指定特权交给一个或多个角色。如果有一些已经被授予，这些特权会被加入到它们之中。
关键词PUBLIC指示特权要被授予给所有角色，包括那些可能稍后会被创建的角色。PUBLIC可以被认为是一个被隐式定义的总是包含所有角色的组。任何特定角色都将具有直接授予给它的特权、授予给它作为成员所在的任何角色的特权以及被授予给PUBLIC的特权。
如果指定了WITH GRANT OPTION，特权的接收者可以接着把它授予给其他人。没有授权选项，接收者就不能这样做。授权选项不能被授予给PUBLIC。
如果指定了GRANTED BY，指定的授予者必须是当前用户。这个子句当前在这里出现仅是为了SQL兼容性。
没有必要把权限授予给一个对象的拥有者（通常就是创建该对象的用户），
因为拥有者默认具有所有的特权（不过拥有者可能为了安全选择撤回一些
自己的特权）。
删除一个对象或者以任何方式修改其定义的权力是不被当作一个可授予特权的，它被固化在拥有者中，并且不能被授予和撤回（不过，相似的效果可以通过授予或者撤回在拥有该对象的角色中的成员关系来实现，见下文）。拥有者也隐式地拥有该对象的所有授权选项。
可能的权限包括：
SELECTINSERTUPDATEDELETETRUNCATEREFERENCESTRIGGERCREATECONNECTTEMPORARYEXECUTEUSAGESETALTER SYSTEMMAINTAIN
特定类型的权限，如 第 5.8 节 中定义。
TEMP
TEMPORARY 的另一种拼写。
ALL PRIVILEGES
授予对象类型可用的所有权限。PRIVILEGES关键字在
PostgreSQL 中是可选的，但在严格的 SQL 中是必需的。
FUNCTION语法适用于简单函数、聚合函数和窗口函数，但不适用于过程；对过程使用PROCEDURE。
或者，使用ROUTINE来引用函数、聚合函数、窗口函数或过程而不管其精确类型。
还有一个选项，可以在一个或多个模式中对所有相同类型的对象授予特权。此功能当前仅支持表、序列、函数和过程。
ALL TABLES也会影响视图和外表，就像特定对象 GRANT命令。
ALL FUNCTIONS也会影响聚合和窗口函数，但不影响过程，就像特定对象GRANT命令一样。
使用 ALL ROUTINES 来包括过程。
角色上的 GRANT
此GRANT命令的变体将角色的成员资格授予一个或多个其他角色，
并修改成员资格选项SET、INHERIT和
ADMIN；详见第 21.3 节。角色的成员资格
很重要，因为它可能允许将授予角色的权限传递给其每个成员，并可能还允许对
角色本身进行更改。然而，实际授予的权限取决于与授予相关的选项。要修改现有
成员资格的选项，只需指定具有更新选项值的成员资格。
下面描述的每个选项都可以设置为TRUE或FALSE。
关键字OPTION被接受为TRUE的同义词，
因此WITH ADMIN OPTION是WITH ADMIN TRUE
的同义词。在更改现有成员资格时，省略某个选项会导致保留当前值。
ADMIN选项允许成员将角色的成员资格授予他人，
并且也可以撤销角色的成员资格。如果没有ADMIN选项，普通用户
无法执行这些操作。一个角色不会被认为对自身拥有
WITH ADMIN OPTION。数据库超级用户可以将任
何角色的成员资格授予或撤销给任何人。此选项默认为
FALSE。
INHERIT选项控制新成员资格的继承状态；
请参阅第 21.3 节了解继承的详细信息。
如果设置为TRUE，则新成员将从授予的角色继承。
如果设置为FALSE，则新成员不会继承。
如果在创建新角色成员资格时未指定，则默认为新成员的继承属性。
如果SET选项被设置为TRUE，则允许成员使用
SET ROLE
命令切换到被授予的角色。如果一个角色是另一个角色的间接成员，
它只能在每个授予链中都具有SET TRUE的情况下，
使用SET ROLE切换到该角色。
此选项的默认值为TRUE。
要创建由另一个角色拥有的对象或将现有对象的所有权赋予另一个角色，
您必须具有将角色设置为SET ROLE的能力；否则，
像ALTER ... OWNER TO或CREATE DATABASE ...
OWNER这样的命令将会失败。然而，一个继承了某角色权限但
无法将角色设置为SET ROLE的用户，可能通过操作
由该角色拥有的现有对象（例如，他们可以重新定义一个现有函数使其
充当特洛伊木马）来获得对该角色的完全访问权限。因此，如果一个角色
的权限是可继承的，但不应通过SET ROLE访问，
那么它不应该拥有任何SQL对象。
如果指定了GRANTED BY，则记录的授权将被视为由指定的角色完成。
用户只有在拥有该角色的权限时，才能将授权归因于另一个角色。记录为授权者的
角色必须对目标角色拥有ADMIN OPTION，除非它是引导超级用户。
当授权记录为由引导超级用户以外的授权者完成时，它依赖于授权者继续拥有对该
角色的ADMIN OPTION；因此，如果ADMIN OPTION
被撤销，则依赖的授权也必须被撤销。
和特权的情况不同，一个角色中的成员关系不能被授予PUBLIC。还要注意
这种形式的命令不允许role_specification
中的噪声词GROUP。
注释
REVOKE命令被用来撤回访问特权。
从PostgreSQL 8.1 开始，用户和组的概念已经被统一到一种单一类型的实体（被称为一个角色）。因此不再需要使用关键词GROUP来标识一个被授权者是一个用户或者一个组。在该命令中仍然允许GROUP，但是它只是一个噪音词。
如果一个用户持有特定列或者其所在的整个表的特权，
该用户可以在该列上执行SELECT、
INSERT等命令。在表层面上授予特权
然后对一列撤回该特权将不会按照你希望的运作：
表级别的授权不会受到列级别操作的影响。
当一个对象的非拥有者尝试GRANT特权
在该对象上时，如果该用户在该对象上什么特权都不拥有，该命令将立刻失败。只要有一些特权可用，该命令将继续，但是它将只授予那些用户具有授权选项的特权。如果不持有授权选项，GRANT ALL PRIVILEGES形式将发出一个警告消息。而如果不持有命令中特别提到的任何特权的授权选项，其他形式将会发出一个警告（原则上这些语句也适用于对象拥有者，但是由于拥有者总是被视为持有所有授权选项，因此这种情况不会发生）。
需要注意的是，数据库超级用户可以访问所有对象而不管对象特权的设置。这可与 Unix 系统中的root权力相提并论。对于root来说，除非绝对必要，使用一个超级用户来操作是不明智的。
如果超级用户选择执行GRANT或REVOKE
命令，该命令将以受影响对象所有者的身份执行。特别是，通过
此类命令授予的权限将显示为由对象所有者授予。
（对于角色成员资格，成员资格似乎是由引导超级用户授予的。）
GRANT以及REVOKE也可以由一个不是受影响对象拥有者的角色完成，不过该角色是拥有该对象的角色的一个成员，或者是在该对象上持有特权的WITH GRANT OPTION的角色的一个成员。在这种情况下，特权将被记录为由实际拥有该对象的角色授予或者是由持有特权的WITH GRANT OPTION的角色授予。例如，如果表t1被角色g1拥有，u1是它的一个成员，那么u1可以把t1上的特权授予给u2，但是那些特权将好像是直接由g1授予的。角色g1的任何其他成员可以稍后撤回它们。
如果执行GRANT的角色间接地通过多于一条角色成员关系路径持有所需的特权，将不会指定哪一个包含它的角色将被记录为完成了该授权。在这样的情况下，最好使用SET ROLE来成为你想用其做GRANT的特定角色。
授予一个表上的权限不会自动地扩展权限给该表使用的任何序列，包括绑定在SERIAL列上的序列。序列上的权限必须单独设置。
有关特定的特权类型以及如何检查对象特权的更多信息，请参见第 5.8 节。
示例
把表films上的插入特权授予给所有用户：
GRANT INSERT ON films TO PUBLIC;
把视图kinds上的所有可用特权授予给用户manuel：
GRANT ALL PRIVILEGES ON kinds TO manuel;
注意虽然上述语句被一个超级用户或者kinds的拥有者执行时确实会授予所有特权，但是当由其他人执行时将只会授予那些执行者拥有授权选项的权限。
把角色admins中的成员关系授予给用户joe：
GRANT admins TO joe;
兼容性
根据 SQL 标准，ALL PRIVILEGES中的PRIVILEGES关键词是必须的。SQL 标准不支持在每个命令中设置超过一个对象上的权限。
PostgreSQL允许一个对象拥有者
撤回他们拥有的普通特权：例如，一个表拥有者可以通过撤回其自身拥有
的INSERT、UPDATE、DELETE
和TRUNCATE特权让该表对他们自己只读。根据 SQL 标准
这是不可能发生的。原因在于PostgreSQL
认为拥有者的特权是由拥有者授予给他们自己的，因此他们也能够撤回这些特权。
在 SQL 标准中，拥有者的特权是由一个假设的实体“_SYSTEM”所授予。
由于不是“_SYSTEM”，拥有者就不能撤回这些权利。
根据 SQL 标准，授权选项可以被授予给PUBLIC， PostgreSQL 只支持把授权选项授予给角色。
SQL标准允许GRANTED BY选项仅指定CURRENT_USER或CURRENT_ROLE。
其他的变体是PostgreSQL扩展。
SQL 标准提供了其他对象类型上的USAGE特权：字符集、排序规则、翻译。
在 SQL 标准中，序列只有一个USAGE特权，它控制NEXT VALUE FOR表达式的使用，该表达式等效于 PostgreSQL 中的函数nextval。序列的特权SELECT和UPDATE是 PostgreSQL 扩展。应用序列的USAGE特权到currval函数也是一个 PostgreSQL 扩展（该函数本身也是）。
数据库、表空间、模式、语言和配置参数上的权限是PostgreSQL的扩展。
参见REVOKE, ALTER DEFAULT PRIVILEGES上一页 上一级 下一页FETCH 起始页 IMPORT FOREIGN SCHEMA
