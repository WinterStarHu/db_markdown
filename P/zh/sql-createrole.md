# CREATE ROLE

CREATE ROLE
版本：
纠错本页面
搜索
目录导航
❮
❯
CREATE ROLECREATE ROLE — 定义一个新的数据库角色大纲
CREATE ROLE name [ [ WITH ] option [ ... ] ]
其中 option 可以是：
SUPERUSER | NOSUPERUSER
| CREATEDB | NOCREATEDB
| CREATEROLE | NOCREATEROLE
| INHERIT | NOINHERIT
| LOGIN | NOLOGIN
| REPLICATION | NOREPLICATION
| BYPASSRLS | NOBYPASSRLS
| CONNECTION LIMIT connlimit
| [ ENCRYPTED ] PASSWORD 'password' | PASSWORD NULL
| VALID UNTIL 'timestamp'
| IN ROLE role_name [, ...]
| ROLE role_name [, ...]
| ADMIN role_name [, ...]
| SYSID uid
描述
CREATE ROLE向PostgreSQL数据库集簇增加一个新的角色。一个角色是一个实体，它可以拥有数据库对象并且拥有数据库特权。根据一个角色如何被使用，它可以被考虑成一个“用户”、一个“组”或者两者。有关管理用户和认证的信息可以参考第 21 章和第 20 章。要使用这个命令，你必须具有CREATEROLE特权或者成为一个数据库超级用户。
注意角色是定义在数据库集簇层面上的，并且因此在集簇中的所有数据库中都可用。
在创建角色时，可以立即将新创建的角色分配为现有角色的成员，
也可以将现有角色分配为新创建角色的成员。启用哪些初始角色
成员选项的规则在下面的IN ROLE、ROLE和
ADMIN子句中描述。GRANT命令在成员创建
过程中提供了细粒度的选项控制，并且可以在新角色创建后修改这些选项。
参数name
新角色的名称。
SUPERUSERNOSUPERUSER
这些子句决定新角色是否是一个“超级用户”，
它可以越过数据库内的所有访问限制。超级用户状态很危险并且只应该在确实
需要时才用。要创建一个新超级用户，你必须自己是一个超级用户。如果没有指定，
NOSUPERUSER是默认值。
CREATEDBNOCREATEDB
这些子句定义了角色创建数据库的能力。如果指定了
CREATEDB，则被定义的角色将被允许创建新数据库。
指定NOCREATEDB将拒绝角色创建数据库的能力。
如果未指定，NOCREATEDB是默认值。
只有超级用户角色或具有CREATEDB权限的角色
才能指定CREATEDB。
CREATEROLENOCREATEROLE
这些子句决定了一个角色是否被允许创建、修改、删除、评论以及更改其他角色的
安全标签。
有关此权限授予的功能的更多详细信息，请参见
角色创建。
如果未指定，默认值为NOCREATEROLE。
INHERITNOINHERIT
这会影响当此角色作为另一个角色的成员添加时的成员继承状态，
无论是在当前命令还是未来的命令中。具体来说，它控制使用
IN ROLE子句在此命令中添加的成员资格的继承状态，
以及在后续命令中使用ROLE子句时的继承状态。
它还用作使用GRANT命令将此角色作为成员添加时的
默认继承状态。如果未指定，INHERIT是默认值。
在PostgreSQL 16版本之前，
继承是一个角色级别的属性，用于控制该角色的所有运行时成员检查。
LOGINNOLOGIN
这些子句决定一个角色是否被允许登录，也就是在客户端连接期间该角色是否能被
给定为初始会话认证名称。一个具有LOGIN属性的角色可以被
考虑为一个用户。没有这个属性的角色对于管理数据库特权很有用，但是却不是
用户这个词的通常意义。如果没有指定，默认值是NOLOGIN，
不过当CREATE ROLE被通过
CREATE USER调用时默认值会是LOGIN。
REPLICATIONNOREPLICATION
这些子句决定了一个角色是否是复制角色。一个角色必须具有此属性
（或是超级用户）才能以复制模式（物理或逻辑复制）连接到服务器，
并且才能创建或删除复制槽。
拥有REPLICATION属性的角色是一个非常高权限的角色，
应仅用于实际用于复制的角色。如果未指定，
NOREPLICATION是默认值。
只有超级用户角色或具有REPLICATION的角色
才能指定REPLICATION。
BYPASSRLSNOBYPASSRLS
这些条款决定了一个角色是否绕过每个行级安全（RLS）策略。
NOBYPASSRLS 是默认值。只有超级用户角色或具有
BYPASSRLS 权限的角色可以指定 BYPASSRLS。
注意 pg_dump 将默认把row_security设置为OFF，
以确保一个表的所有内容被转储出来。如果运行 pg_dump 的用户不具有适当的权限，将会返回一个错误。
但是，超级用户和被转储表的拥有者总是可以绕过 RLS。
CONNECTION LIMIT connlimit
如果角色能登录，这指定该角色能建立多少并发连接。-1（默认值）表示无限制。注意这个限制仅针对于普通连接。预备事务和后台工作者连接都不受这一限制管辖。
[ ENCRYPTED ] PASSWORD 'password'PASSWORD NULL
设置角色的口令（口令只对具有LOGIN属性的角色有用，但是不管怎样你还是可以为没有该属性的角色定义一个口令）。如果你没有计划使用口令认证，你可以忽略这个选项。如果没有指定口令，口令将被设置为空并且该用户的口令认证总是会失败。也可以用PASSWORD NULL显式地写出一个空口令。
注意
指定一个空字符串也将把口令设置为空，但是在PostgreSQL版本10之前是不能这样做的。在早期的版本中，是否可以使用空字符串取决于认证方法和确切的版本，而libpq在任何情况下都将拒绝使用空字符串。为了避免混淆，应该避免指定空字符串。
口令总是以加密的方式存放在系统目录中。ENCRYPTED关键词没有实际效果，它只是为了向后兼容性而存在。加密的方法由配置参数password_encryption决定。如果当前的口令字符串已经是MD5加密或者SCRAM加密的格式，那么不管password_encryption的值是什么，口令字符串还是原样存储（因为系统无法解密以不同格式加密的口令字符串）。这种方式允许在转储/恢复时重载加密的口令。
警告
对 MD5 加密密码的支持已被弃用，并将在未来的
PostgreSQL 版本中移除。有关迁移到
其他密码类型的详细信息，请参阅 第 20.5 节。
VALID UNTIL 'timestamp'
VALID UNTIL子句设置一个日期和时间，在该时间点之后角色的密码将会失效。如果这个子句被忽略，那么密码将始终有效。
IN ROLE role_name
IN ROLE子句会使新角色自动作为指定现有角色的成员添加。
新的成员资格将启用SET选项，并禁用ADMIN
选项。除非指定了NOINHERIT选项，否则将启用
INHERIT选项。
ROLE role_name
ROLE子句会自动将一个或多个指定的现有角色添加为成员，
并启用SET选项。这实际上使新角色成为一个“组”。
在此子句中指定的具有角色级别INHERIT属性的角色将
在新成员资格中启用INHERIT选项。新成员资格将禁用
ADMIN选项。
ADMIN role_name
ADMIN子句与ROLE具有相同的效果，但指定的角色会作为新角色的成员
添加，并启用ADMIN，赋予它们将新角色的成员资格授予他人的权利。
SYSID uid
SYSID子句会被忽略，但为了向后兼容，仍然会接受它。
注释
使用ALTER ROLE来更改
角色的属性，以及使用DROP ROLE来移除角色。
所有用CREATE ROLE指定的属性可以被后来的ALTER ROLE命令所修改。
增加和移除组角色成员的最佳方式是使用
GRANT和
REVOKE。
VALID UNTIL子句只为一个密码而不是为一个角色本身定义了一个过期时间。特别地，当使用一个非基于密码认证的方法登录时，过期时间是不会被强制的。
这里定义的角色属性是不可继承的，也就是说，成为具有例如
CREATEDB的角色的成员，并不会允许该成员创建新数据库，
即使成员资格授予具有INHERIT选项。当然，如果成员资格
授予具有SET选项，成员角色将能够
SET ROLE到
createdb角色，然后创建一个新数据库。
由IN ROLE、ROLE和ADMIN
子句创建的成员资格将执行此命令的角色作为授予者。
INHERIT属性是用于向后兼容原因的默认值：在早前的PostgreSQL发布中，用户总是能够访问其所属组的所有特权。不过，NOINHERIT更加接近于 SQL 标准中指定的语义。
PostgreSQL包括一个程序createuser，它具有和CREATE ROLE相同的功能（事实上，它会调用这个命令），但是它可以从命令 shell 中运行。
CONNECTION LIMIT只被近似地强制，如果两个新会话在几乎相同时间被开始，而此时该角色只剩下刚好一个连接“槽”，两者可能都将失败。还有，该限制从不对超级用户强制。
用这个命令指定一个非加密密码时必须加以注意。该密码将以明文的形式传输到服务器，并且它也可能被记录在客户端命令历史或者服务器日志中。不过，命令createuser会传输加密的密码。还有，psql包含一个命令\password，它可以被用来安全地改变该密码。
示例
创建一个能够登录但没有密码的角色：
CREATE ROLE jonathan LOGIN;
创建一个有密码的角色：
CREATE USER davide WITH PASSWORD 'jw8s0F4';
（CREATE USER和CREATE ROLE完全相同，除了它隐含了LOGIN。）
创建一个角色，它的密码有效期截止到 2004 年底。在进入 2005 年第一秒时，该密码会失效。
CREATE ROLE miriam WITH LOGIN PASSWORD 'jw8s0F4' VALID UNTIL '2005-01-01';
创建一个能够创建数据库并管理角色的角色：
CREATE ROLE admin WITH CREATEDB CREATEROLE;
兼容性
CREATE ROLE语句在 SQL 标准中存在，但标准只要求语法
CREATE ROLE name [ WITH ADMIN role_name ]
多个初始管理员以及CREATE ROLE的所有其他选项都是PostgreSQL的扩展。
SQL 标准定义了用户和角色的概念，但它将它们视为不同的概念，并将定义用户的所有命令留给每种数据库实现来指定。在PostgreSQL中，我们选择将用户和角色统一为一种单一的实体。因此，角色比标准中拥有更多可选属性。
SQL标准指定的行为最接近于创建具有NOINHERIT选项的
PostgreSQL角色作为SQL标准用户，以及具有
INHERIT选项的PostgreSQL
角色作为SQL标准角色。
USER子句的行为与ROLE相同，但已被弃用：
USER role_name [, ...]
IN GROUP子句的行为与IN ROLE相同，但已被弃用：
IN GROUP role_name [, ...]
参见SET ROLE, ALTER ROLE, DROP ROLE, GRANT, REVOKE, createuser, createrole_self_grant上一页 上一级 下一页CREATE PUBLICATION 起始页 CREATE RULE
