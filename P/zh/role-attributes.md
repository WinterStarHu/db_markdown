# 21.2. 角色属性

21.2. 角色属性
版本：
纠错本页面
搜索
目录导航
❮
❯
21.2. 角色属性 #
数据库角色可以具有多个属性，定义其特权并与客户端认证系统交互。
login privilege
只有具有LOGIN属性的角色才能用作数据库连接的初始角色名称。
具有LOGIN属性的角色可以被视为“数据库用户”的同义词。
要创建具有登录权限的角色，请使用以下任一方法：
CREATE ROLE name LOGIN;
CREATE USER name;
（CREATE USER等同于CREATE ROLE，
但CREATE USER默认包含LOGIN，而CREATE ROLE不包含。）
superuser status
数据库超级用户绕过所有权限检查，除了登录权限。这是一个危险的特权，不应该随意使用；最好将大部分工作作为一个不是超级用户的角色来完成。
要创建一个新的数据库超级用户，使用CREATE ROLE name SUPERUSER。您必须以已经是超级用户的角色来执行此操作。
database creation
角色必须明确获得权限才能创建数据库（超级用户除外，因为他们可以绕过所有权限检查）。
要创建这样的角色，请使用CREATE ROLE name CREATEDB。
角色创建
必须明确授予一个角色创建更多角色的权限（超级用户除外，
因为超级用户绕过了所有权限检查）。要创建这样的角色，请使用
CREATE ROLE name CREATEROLE。
拥有CREATEROLE权限的角色可以更改和删除已通过
ADMIN选项授予CREATEROLE用户的角色。
当一个非超级用户的CREATEROLE用户创建新角色时，
这种授予会自动发生，因此默认情况下，
CREATEROLE用户可以更改和删除他们创建的角色。
更改角色包括使用ALTER ROLE可以进行的大多数更改，
例如更改密码。它还包括可以使用COMMENT和
SECURITY LABEL命令对角色进行的修改。
然而，CREATEROLE并不包含创建SUPERUSER角色的能力，
也不包含对已经存在的SUPERUSER角色的任何控制权。
此外，CREATEROLE也不包含创建REPLICATION用户的权力，
也不能授予或撤销REPLICATION特权，也不能修改这些用户的角色属性。
然而，它允许在REPLICATION角色上使用ALTER ROLE ... SET和ALTER ROLE ... RENAME，以及使用COMMENT ON ROLE、SECURITY LABEL ON ROLE和DROP ROLE。
最后，CREATEROLE也不授予授予或撤销BYPASSRLS特权的能力。
启动复制
一个角色必须明确被授予权限来启动流复制（除了超级用户，因为他们可以绕过所有权限检查）。
用于流复制的角色必须也具有LOGIN权限。要创建这样的角色，使用
CREATE ROLE name REPLICATION
LOGIN。
密码
密码仅在客户端身份验证方法要求用户在连接到数据库时提供密码时才有意义。
password和md5身份验证方法都使用密码。
数据库密码与操作系统密码分开。在角色创建时指定密码为
CREATE ROLE
name PASSWORD 'string'。
权限继承
一个角色默认会继承其成员角色的权限。然而，要创建一个默认不继承权限的
角色，可以使用CREATE ROLE name
NOINHERIT。或者，可以通过使用WITH INHERIT TRUE
或WITH INHERIT FALSE来为单个授权覆盖继承设置。
绕过行级安全性
一个角色必须明确获得权限来绕过每个行级安全（RLS）策略（除了超级用户，因为他们可以绕过所有权限检查）。
要创建这样一个角色，请使用CREATE ROLE name BYPASSRLS作为超级用户。
连接限制
连接限制可以指定一个角色可以建立多少并发连接。
-1（默认值）表示没有限制。在创建角色时指定连接限制，使用
CREATE ROLE name CONNECTION LIMIT 'integer'。
角色的属性可以在创建后使用ALTER ROLE进行修改。
查看有关CREATE ROLE和ALTER ROLE命令的参考页面以获取详细信息。
对于第 19 章中描述的运行时配置设置，一个角色也可以有角色相关的默认值。例如，如果出于某些原因你希望在每次连接时禁用索引扫描（提示：不是好主意），你可以使用：
ALTER ROLE myname SET enable_indexscan TO off;
这将保存设置（但是不会立刻设置它）。在这个角色的后续连接中，它就表现得像在会话开始之前执行过SET enable_indexscan TO off。你也可以在会话期间改变该设置，它将只是作为默认值。要移除一个角色相关的默认设置，使用ALTER ROLE rolename RESET varname。注意附加到没有LOGIN权限的角色的角色相关默认值相当无用，因为它们从不会被调用。
当非超级用户使用CREATEROLE权限创建角色时，创建的角色会自动
授予回创建该角色的用户，就好像引导超级用户执行了命令
GRANT created_user TO creating_user WITH ADMIN TRUE, SET FALSE,
INHERIT FALSE一样。由于CREATEROLE用户只有在对现有角色
拥有ADMIN OPTION时才能行使特殊权限，因此该授权刚好允许
CREATEROLE用户管理他们创建的角色。然而，因为该角色是以
INHERIT FALSE, SET FALSE创建的，CREATEROLE用户
不会继承该角色的权限，也不能使用SET ROLE访问该角色的权限。
但是，由于任何拥有某角色ADMIN OPTION的用户都可以将该角色的
成员资格授予其他用户，CREATEROLE用户可以通过简单地将该角色
以INHERIT和/或SET选项授予自己来获得访问权限。
因此，权限默认不继承且默认不授予SET ROLE是防止意外的保护措施，
而非安全特性。还要注意，因为该自动授权是由引导超级用户授予的，CREATEROLE
用户无法移除或更改；不过，任何超级用户都可以撤销、修改该授权，和/或向其他
CREATEROLE用户发出额外的此类授权。任何时刻拥有某角色
ADMIN OPTION的CREATEROLE用户都可以管理该角色。
上一页 上一级 下一页21.1. 数据库角色 起始页 21.3. 角色成员资格
