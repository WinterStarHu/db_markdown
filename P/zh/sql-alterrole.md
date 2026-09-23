# ALTER ROLE

ALTER ROLE
版本：
纠错本页面
搜索
目录导航
❮
❯
ALTER ROLEALTER ROLE — 更改数据库角色大纲
ALTER ROLE role_specification [ WITH ] option [ ... ]
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
ALTER ROLE name RENAME TO new_name
ALTER ROLE { role_specification | ALL } [ IN DATABASE database_name ] SET configuration_parameter { TO | = } { value | DEFAULT }
ALTER ROLE { role_specification | ALL } [ IN DATABASE database_name ] SET configuration_parameter FROM CURRENT
ALTER ROLE { role_specification | ALL } [ IN DATABASE database_name ] RESET configuration_parameter
ALTER ROLE { role_specification | ALL } [ IN DATABASE database_name ] RESET ALL
其中 role_specification 可以是：
role_name
| CURRENT_ROLE
| CURRENT_USER
| SESSION_USER
描述
ALTER ROLE 更改一个
PostgreSQL 角色的属性。
该命令在概要中列出的第一个变体可以更改许多可在
CREATE ROLE中指定的角色属性。
（涵盖了所有可能的属性，除了没有添加或删除成员资格的选项；请使用
GRANT和
REVOKE来完成此操作。）
命令中未提及的属性将保留其先前设置。
数据库超级用户可以更改任何角色的这些设置，除了更改
SUPERUSER属性的
引导超级用户。
拥有CREATEROLE权限的非超级用户角色可以更改大多数这些属性，
但仅限于他们被授予ADMIN OPTION的非超级用户和非复制角色。
非超级用户不能更改SUPERUSER属性，并且只有在他们自身拥有
相应属性时，才能更改CREATEDB、REPLICATION和
BYPASSRLS属性。
普通角色只能更改自己的密码。
第二种变体更改了角色的名称。
数据库超级用户可以重命名任何角色。
拥有CREATEROLE权限的角色可以重命名他们被授予
ADMIN OPTION权限的非超级用户角色。
当前会话用户不能被重命名。
（如果需要这样做，请以不同的用户身份连接。）
由于MD5加密的密码使用角色名称作为加密盐，
重命名角色会清除其密码，如果密码是MD5加密的。
其余的变体用于更改一个角色的配置变量的会话默认值，可以为所有数据库设置，或者
只为IN DATABASE中指定的数据库设置。如果指定的是
ALL而不是一个角色名，将会为所有角色更改该设置。把
ALL和IN DATABASE一起使用实际上和使用命
令ALTER DATABASE ... SET ...相同。
只要角色后续开始一个新会话，指定的值将会成为该会话的默认值，并且会覆盖
postgresql.conf中存在的值或者从
postgres命令行收到的值。这只在登录时发生，执行
SET ROLE或者
SET SESSION AUTHORIZATION不会导致新的配置值被设置。
对于所有数据库设置的值会被附加到一个角色的数据库相关的设置所覆盖。特定数据库
或角色的设置会覆盖为所有角色所作的设置。
超级用户可以更改任何人的会话默认值。具有
CREATEROLE权限的角色可以更改其被授予
ADMIN OPTION权限的非超级用户角色的默认值。
普通角色只能为自己设置默认值。
某些配置变量无法通过这种方式设置，或者只能在超级用户发出命令时
设置。只有超级用户可以更改所有数据库中所有角色的设置。
参数name #
要对其属性进行修改的角色的名称。
CURRENT_ROLECURRENT_USER #
修改当前用户而不是一个显式标识的角色。
SESSION_USER #
修改当前会话用户而不是一个显式标识的角色。
SUPERUSERNOSUPERUSERCREATEDBNOCREATEDBCREATEROLENOCREATEROLEINHERITNOINHERITLOGINNOLOGINREPLICATIONNOREPLICATIONBYPASSRLSNOBYPASSRLSCONNECTION LIMIT connlimit[ ENCRYPTED ] PASSWORD 'password'PASSWORD NULLVALID UNTIL 'timestamp' #
这些子句修改原来由CREATE ROLE
设置的属性。更多信息请见
CREATE ROLE参考页。
new_name #
该角色的新名称。
database_name #
要在其中设置该配置变量的数据库名称。
configuration_parametervalue #
把这个角色的指定配置参数的会话默认值设置为给定值。如果
value为DEFAULT
或者等效地使用了RESET，角色相关的变量
设置会被移除，这样该角色将会在新会话中继承系统范围的默认
设置。使用RESET ALL可清除所有角色相关的
设置。SET FROM CURRENT可以把会话中该参数的
当前值保存为角色相关的值。如果指定了
IN DATABASE，只会为给定的角色和数据库
设置或者移除该配置参数。
角色相关的变量设置只在登录时生效，
SET ROLE以及
SET SESSION AUTHORIZATION不会处理角色
相关的变量设置。
关于允许的参数名称和值详见SET和
第 19 章。
注释
使用CREATE ROLE添加新角色，使用
DROP ROLE移除一个角色。
ALTER ROLE无法更改一个角色的成员关系。
可以使用GRANT和
REVOKE来实现。
在使用这个命令指定一个未加密密码时要多加小心。该密码将会以明文
传送到服务器，并且它还可能会被记录在客户端的命令历史或者服务器
日志中。psql包含了一个命令
\password，它可以被用来更改一个角色
的密码而不暴露明文密码。
也可以把一个会话默认值绑定到一个指定的数据库而不是一个角色，详见
ALTER DATABASE。如果出现冲突，数据库角色相关
的设置会覆盖角色相关的设置，角色相关的又会覆盖数据库相关的设置。
示例
更改一个角色的密码：
ALTER ROLE davide WITH PASSWORD 'hu8jmn3';
移除一个角色的密码：
ALTER ROLE davide WITH PASSWORD NULL;
更改一个密码的失效日期，指定该密码应该在 2015 年 5 月 4 日中午
（在一个比UTC快 1 小时的时区）过期：
ALTER ROLE chris VALID UNTIL 'May 4 12:00:00 2015 +1';
让一个密码永远有效：
ALTER ROLE fred VALID UNTIL 'infinity';
赋予一个角色管理其他角色和创建新数据库的能力:
ALTER ROLE miriam CREATEROLE CREATEDB;
为一个角色指定
maintenance_work_mem参数的非默认设置：
ALTER ROLE worker_bee SET maintenance_work_mem = 100000;
为一个角色指定
client_min_messages参数的数据库特定的非
默认设置：
ALTER ROLE fred IN DATABASE devel SET client_min_messages = DEBUG;
兼容性
ALTER ROLE语句是一个
PostgreSQL扩展。
另见CREATE ROLE, DROP ROLE, ALTER DATABASE, SET上一页 上一级 下一页ALTER PUBLICATION 起始页 ALTER ROUTINE
