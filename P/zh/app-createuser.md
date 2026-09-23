# createuser

createuser
版本：
纠错本页面
搜索
目录导航
❮
❯
createusercreateuser — 定义一个新的PostgreSQL用户账户大纲createuser [connection-option...] [option...] [username]描述
createuser 创建一个新的PostgreSQL用户（或者更准确些，是一个角色）。只有超级用户和具有CREATEROLE特权的用户才能创建新用户，因此createuser必须被可以以超级用户身份连接或具有CREATEROLE特权的用户调用。
如果您希望创建具有SUPERUSER、
REPLICATION或BYPASSRLS权限的角色，
您必须以超级用户身份连接，而不仅仅是具有
CREATEROLE权限。
成为超级用户意味着能够绕过数据库中的所有访问权限检查，
因此不应轻易授予超级用户访问权限。
CREATEROLE还赋予
非常广泛的权限。
createuser 是 SQL 命令 CREATE ROLE 的一个包装器。在通过这个工具和其他方法访问服务器来创建用户之间没有实质性的区别。
选项
createuser 接受以下命令行参数：
username
指定要创建的PostgreSQL用户的名称。
此名称必须与此PostgreSQL安装中的所有其他角色不同。
-a role--with-admin=role
指定一个现有角色，该角色将自动作为新角色的成员添加，并具有管理员选项，
赋予其将新角色的成员资格授予他人的权限。可以通过编写多个
-a开关来指定多个现有角色。
-c number--connection-limit=number
为新用户设置最大连接数。默认情况下不设置限制。
-d--createdb
新用户将被允许创建数据库。
-D--no-createdb
新用户将不被允许创建数据库。这是默认设置。
-e--echo
回显createuser生成并发送到服务器的命令。
-E--encrypted
这个选项已经过时，但仍然被接受以保持向后兼容性。
-g role--member-of=role--role=role（已弃用）
指定新角色应自动添加为指定现有角色的成员。可以通过编写多个
-g开关来指定多个现有角色。
-i--inherit
新角色将自动继承其成员角色的权限。
这是默认值。
-I--no-inherit
新角色不会自动继承其成员角色的权限。
--interactive
如果在命令行上没有指定用户名，则提示用户输入，并提示用户选择以下选项之一：
-d/-D，
-r/-R，-s/-S，
这些选项在命令行上没有指定。（这是 PostgreSQL 9.1 版本之前的默认行为。）
-l--login
新用户将被允许登录（也就是说，用户名可以作为初始会话用户标识符）。
这是默认值。
-L--no-login
新用户将不被允许登录。
（没有登录权限的角色仍然可以作为管理数据库权限的手段。）
-m role--with-member=role
指定一个现有的角色，该角色将自动作为新角色的成员添加。
可以通过编写多个-m开关来指定多个现有角色。
-P--pwprompt
如果提供了，createuser将提示输入新用户的密码。
如果您不打算使用密码验证，则这不是必需的。
-r--createrole
新用户将被允许创建、修改、删除、评论，以及更改其他角色的安全标签；
也就是说，该用户将拥有CREATEROLE权限。
有关此权限授予的功能的更多详细信息，请参见
角色创建。
-R--no-createrole
新用户将不被允许创建新角色。这是默认。
-s--superuser
新用户将成为超级用户。
-S--no-superuser
新用户将不会是超级用户。这是默认。
-v timestamp--valid-until=timestamp
设置一个日期和时间，在此之后该角色的密码将不再有效。
默认情况下，不设置密码过期日期。
-V--version
打印createuser版本并退出。
--bypassrls
新用户将绕过每个行级安全（RLS）策略。
--no-bypassrls
新用户不会绕过行级安全（RLS）策略。这是默认。
--replication
新用户将拥有REPLICATION权限，这在CREATE ROLE文档中有更详细的描述。
--no-replication
新用户将不会拥有REPLICATION权限，该权限在
CREATE ROLE的文档中有更详细的描述。这是默认设置。
-?--help
显示有关createuser命令行参数的帮助信息，并退出。
createuser也接受下列命令行参数作为连接参数：
-h host---host=host
指定运行服务器的机器的主机名。如果该值以一个斜线开始，它被用作 Unix 域套接字的目录。
-p port---port=port
指定服务器正在监听连接的 TCP 端口或本地 Unix 域套接字文件扩展。
-U username---username=username
要作为哪个用户连接（不是要创建的用户名）。
-w---no-password
从不发出一个口令提示。如果服务器要求口令认证并且没有其他方式提供口令（例如一个.pgpass文件），那儿连接尝试将失败。这个选项对于批处理任务和脚本有用，因为在其中没有一个用户来输入口令。
-W---password
强制createuser在连接到一个数据库之前提示要求一个口令（用来连接到服务器，而不是新用户的口令）。
这个选项不是必不可少的，因为如果服务器要求口令认证，createuser将自动提示要求一个口令。但是，createuser将浪费一次连接尝试来发现服务器想要一个口令。在某些情况下值得用-W来避免额外的连接尝试。
环境PGHOSTPGPORTPGUSER
默认连接参数
PG_COLOR
规定在诊断消息中是否使用颜色。可能的值为 always，
auto和never。
和大部分其他PostgreSQL工具相似，这个工具也使用libpq支持的环境变量（见第 32.15 节）。
诊断
在遇到困难时，可以在CREATE ROLE和psql中找潜在问题和错误消息的讨论。数据库服务器必须运行在目标主机上。同样，任何libpq前端库使用的默认连接设置和环境变量都将适用于此。
示例
要在默认数据库服务器上创建一个用户joe：
$ createuser joe
要在默认数据库服务器上创建一个用户joe并提示要求一些额外属性：
$ createuser --interactive joe
Shall the new role be a superuser? (y/n) n
Shall the new role be allowed to create databases? (y/n) n
Shall the new role be allowed to create more new roles? (y/n) n
要使用在主机eden、端口5000上的服务器创建同一个用户joe，并带有显式指定的属性，看看下面的命令：
$ createuser -h eden -p 5000 -S -D -R -e joe
CREATE ROLE joe NOSUPERUSER NOCREATEDB NOCREATEROLE INHERIT LOGIN;
要将用户joe创建为超级用户，并立即分配密码：
$ createuser -P -s -e joe
输入新角色的密码: xyzzy
再次输入: xyzzy
CREATE ROLE joe PASSWORD 'SCRAM-SHA-256$4096:44560wPMLfjqiAzyPDZ/eQ==$4CA054rZlSFEq8Z3FEhToBTa2X6KnWFxFkPwIbKoDe0=:L/nbSZRCjp6RhOhKK56GoR1zibCCSePKshCJ9lnl3yw=' SUPERUSER CREATEDB CREATEROLE INHERIT LOGIN NOREPLICATION NOBYPASSRLS;
在上面的示例中，新密码在输入时实际上不会回显，
但我们为了清晰显示了输入的内容。如您所见，密码在发送到客户端之前被加密。
另请参阅dropuser, CREATE ROLE, createrole_self_grant上一页 上一级 下一页createdb 起始页 dropdb
