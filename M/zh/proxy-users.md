# 6.2.19 代理用户_MySQL 8.0 参考手册

6.2.19 代理用户_MySQL 8.0 参考手册
Skip to Main Content
Documentation
MySQL手册
MySQL企业版
工作台
InnoDB集群
MySQL NDB集群
连接器
Section Menu:
Documentation Home
MySQL 8.0 参考手册
前言和法律声明
第一章 一般信息
第 2 章安装和升级 MySQL
第 3 章教程
第 4 章 MySQL 程序
第 5 章 MySQL 服务器管理
第 6 章 安全
6.1 一般安全问题
6.2 访问控制和账户管理
6.2.1 账户用户名和密码1
6.2.2 MySQL提供的权限1
6.2.3 授权表1
6.2.4 指定账户名1
6.2.5 指定角色名称1
6.2.6 访问控制，第 1 阶段：连接验证1
6.2.7 访问控制，第 2 阶段：请求验证1
6.2.8 添加账号、分配权限、删除账号1
6.2.9 预留账户1
6.2.10 使用角色1
6.2.11 账户类别1
6.2.12 使用部分撤销的权限限制1
6.2.13 权限变更何时生效1
6.2.14 分配账户密码1
6.2.15 密码管理1
6.2.16 服务器对过期密码的处理1
6.2.17 可插拔认证1
6.2.18 多因素认证1
6.2.19 代理用户1
6.2.20 账户锁定1
6.2.21 设置账号资源限制1
6.2.22 MySQL连接问题排查1
6.2.23 基于 SQL 的账户活动审计1
6.3 使用加密连接
6.4 安全组件和插件
6.5 MySQL 企业数据屏蔽和去标识化
6.6 MySQL企业加密
6.7 SELinux
6.8 FIPS 支持
第 7 章备份与恢复
第8章优化
第9章语言结构
第 10 章字符集、排序规则、Unicode
第 11 章数据类型
第 12 章函数和运算符
第 13 章 SQL 语句
第14章MySQL数据字典
第 15 章 InnoDB 存储引擎
第 16 章替代存储引擎
第十七章复制
第十八章 组复制
第十九章MySQL Shell
第 20 章使用 MySQL 作为文档存储
第21章InnoDB Cluster
第 22 章 InnoDB 副本集
第 23 章 MySQL NDB Cluster 8.0
第24章分区
第25章存储对象
第 26 章 INFORMATION_SCHEMA 表
第 27 章 MySQL 性能模式
第 28 章 MySQL 系统模式
第 29 章连接器和 API
第30章MySQL企业版
第31章MySQL工作台
第 32 章 OCI 市场上的 MySQL
附录 A MySQL 8.0 常见问题解答
附录 B 错误信息和常见问题
附录 C 索引
MySQL 词汇表
MySQL 8.0 参考手册  / 第 6 章 安全  / 6.2 访问控制和账户管理  /
6.2.19 代理用户
6.2.19 代理用户
MySQL 服务器使用身份验证插件对客户端连接进行身份验证。验证给定连接的插件可能会请求将连接（外部）用户视为不同的用户以进行权限检查。这使外部用户成为第二个用户的代理；也就是说，承担第二个用户的特权：
外部用户是“代理用户”（可以冒充或成为另一个用户的用户）。
第二个用户是“代理用户”（其身份和权限可以由代理用户承担的用户）。
本节介绍代理用户功能的工作原理。有关身份验证插件的一般信息，请参阅
第 6.2.17 节，“可插入身份验证”。有关特定插件的信息，请参阅第 6.4.1 节，“身份验证插件”。有关编写支持代理用户的身份验证插件的信息，请参阅
在身份验证插件中实现代理用户支持。
代理用户支持要求简单代理用户示例防止直接登录到代理帐户授予和撤销 PROXY 特权默认代理用户默认代理用户和匿名用户冲突服务器支持代理用户映射代理用户系统变量
笔记
通过代理获得的一个管理好处是，DBA 可以设置一个具有一组特权的帐户，然后使多个代理用户拥有这些特权，而不必将特权单独分配给每个用户。作为代理用户的替代方案，DBA 可能会发现角色提供了一种合适的方式来将用户映射到特定的命名权限集。每个用户都可以被授予一个给定的单一角色，实际上，被授予适当的权限集。请参阅第 6.2.10 节，“使用角色”。
代理用户支持要求
对于给定身份验证插件的代理，必须满足以下条件：
代理必须由插件本身或代表插件的 MySQL 服务器支持。在后一种情况下，可能需要明确启用服务器支持；请参阅
代理用户映射的服务器支持。
外部代理用户的帐户必须设置为由插件进行身份验证。使用该
CREATE USER语句将帐户与身份验证插件相关联，或
ALTER USER更改其插件。
代理用户的帐户必须存在并且被授予代理用户所承担的特权。为此使用
CREATE USERand
GRANT语句。
通常情况下，代理用户配置为只能用于代理场景，不能用于直接登录。
代理用户帐户必须具有
PROXY代理帐户的权限。GRANT为此
使用
语句。
对于连接到代理帐户的客户端被视为代理用户，身份验证插件必须返回一个不同于客户端用户名的用户名，以指示代理帐户的用户名，该用户名定义代理将承担的权限用户。
或者，对于由服务器提供代理映射的插件，代理用户
PROXY由代理用户持有的权限确定。
代理机制只允许将外部客户端用户名映射到代理用户名。没有映射主机名的规定：
当客户端连接到服务器时，服务器根据客户端程序传递的用户名和客户端连接的主机来确定合适的帐户。
如果该帐户是代理帐户，服务器会尝试通过使用身份验证插件返回的用户名和代理帐户的主机名查找代理帐户的匹配项来确定适当的代理帐户。代理帐户中的主机名将被忽略。
简单代理用户示例
考虑以下帐户定义：
-- create proxy account
CREATE USER 'employee_ext'@'localhost'
IDENTIFIED WITH my_auth_plugin
AS 'my_auth_string';
-- create proxied account and grant its privileges;
-- use mysql_no_login plugin to prevent direct login
CREATE USER 'employee'@'localhost'
IDENTIFIED WITH mysql_no_login;
GRANT ALL
ON employees.*
TO 'employee'@'localhost';
-- grant to proxy account the
-- PROXY privilege for proxied account
GRANT PROXY
ON 'employee'@'localhost'
TO 'employee_ext'@'localhost';
当客户端employee_ext从本地主机连接时，MySQL 使用名为的插件
my_auth_plugin来执行身份验证。假设根据内容
并可能通过咨询某些外部身份验证系统my_auth_plugin，向服务器返回一个用户名。名称与 不同
，因此返回
作为对服务器的请求，将外部用户视为本地用户
，以便进行权限检查
。employee'my_auth_string'employeeemployee_extemployeeemployee_extemployee
在这种情况下，employee_ext是代理用户和employee被代理用户。
服务器
通过检查（代理用户）是否
具有（被代理用户）的
权限来
验证用户是否employee可以进行
代理身份验证。如果未授予此特权，则会发生错误。否则，
承担 的特权
。服务器根据授予的权限检查在客户端会话期间执行的语句
。在这种情况下，
可以访问
数据库中的表。
employee_extemployee_extPROXYemployeeemployee_extemployeeemployee_extemployeeemployee_extemployees
被代理的账户，employee使用
mysql_no_login认证插件来防止客户端使用该账户直接登录。（这假定安装了插件。有关说明，请参阅
第 6.4.1.9 节，“无登录可插入身份验证”。）有关保护代理帐户不被直接使用的替代方法，请参阅
防止直接登录到代理帐户。
当发生代理时，可以使用USER()
和CURRENT_USER()函数来查看连接用户（代理用户）和在当前会话期间其权限适用的帐户（被代理用户）之间的区别。对于刚刚描述的示例，这些函数返回这些值：
mysql> SELECT USER(), CURRENT_USER();
+------------------------+--------------------+
| USER()                 | CURRENT_USER()     |
+------------------------+--------------------+
| employee_ext@localhost | employee@localhost |
+------------------------+--------------------+
在CREATE USER创建代理用户帐户的IDENTIFIED
WITH语句中，命名支持代理的身份验证插件的子句后面可选地跟一个子句，该子句指定用户连接时服务器传递给插件的字符串。如果存在，该字符串提供的信息可帮助插件确定如何将代理（外部）客户端用户名映射到代理用户名。是否需要该子句取决于每个插件。如果是这样，身份验证字符串的格式取决于插件打算如何使用它。有关给定插件接受的身份验证字符串值的信息，请查阅给定插件的文档。
AS
'auth_string'AS
防止直接登录到代理帐户
代理账户通常仅供代理账户使用。也就是说，客户端使用代理帐户进行连接，然后映射到并承担适当的代理用户的权限。
有多种方法可以确保不能直接使用代理帐户：
将帐户与
mysql_no_login身份验证插件相关联。在这种情况下，该帐户在任何情况下都不能用于直接登录。这假定已安装插件。有关说明，请参阅
第 6.4.1.9 节，“无登录可插入身份验证”。
ACCOUNT LOCK创建帐户时
包括该选项。请参阅第 13.7.1.3 节，“CREATE USER 语句”。使用这种方法，还包括一个密码，这样如果以后解锁帐户，就无法在没有密码的情况下访问它。（如果validate_password启用该组件，则不允许创建没有密码的帐户，即使该帐户已锁定。请参阅
第 6.4.3 节，“密码验证组件”。）
使用密码创建帐户，但不要将密码告诉任何其他人。如果您不让任何人知道该帐户的密码，客户端将无法使用它直接连接到 MySQL 服务器。
授予和撤销 PROXY 特权
PROXY需要特权才能使外部用户能够连接并拥有另一个用户的特权
。要授予此特权，请使用该
GRANT语句。例如：
GRANT PROXY ON 'proxied_user' TO 'proxy_user';mysql.proxies_priv该语句在授权表
中创建一行
。
在连接时，proxy_user必须代表一个有效的外部身份验证的 MySQL 用户，并且
proxied_user必须代表一个有效的本地身份验证的用户。否则，连接尝试失败。
对应的REVOKE语法是：
REVOKE PROXY ON 'proxied_user' FROM 'proxy_user';
MySQLGRANT和
REVOKE语法扩展照常工作。例子：
-- grant PROXY to multiple accounts
GRANT PROXY ON 'a' TO 'b', 'c', 'd';
-- revoke PROXY from multiple accounts
REVOKE PROXY ON 'a' FROM 'b', 'c', 'd';
-- grant PROXY to an account and enable the account to grant
-- PROXY to the proxied account
GRANT PROXY ON 'a' TO 'd' WITH GRANT OPTION;
-- grant PROXY to default proxy account
GRANT PROXY ON 'a' TO ''@'';
在这些PROXY情况下可以授予特权：
由具有GRANT PROXY ... WITH GRANT
OPTIONfor
的用户proxied_user。
对于自身：对于帐户名的用户名和主机名部分，
proxied_user的值必须与
USER()完全匹配。CURRENT_USER()proxied_user
rootMySQL安装时创建
的初始账号，PROXY ... WITH GRANT
OPTION权限为''@''，即所有用户和所有主机。这可以
root设置代理用户，以及将设置代理用户的权限委托给其他帐户。例如，root可以这样做：
CREATE USER 'admin'@'localhost'
IDENTIFIED BY 'admin_password';
GRANT PROXY
ON ''@''
TO 'admin'@'localhost'
WITH GRANT OPTION;
这些语句创建了一个admin可以管理所有GRANT PROXY映射的用户。例如，admin可以这样做：
GRANT PROXY ON sally TO joe;
默认代理用户
要指定部分或所有用户应使用给定的身份验证插件进行连接，请创建一个具有空用户名和主机名的“空白”''@'' MySQL 帐户(如果与空白用户不同）。假设存在一个名为的插件ldap_auth，它实现了 LDAP 身份验证并将连接用户映射到开发人员或经理帐户。要在这些帐户上设置用户代理，请使用以下语句：
-- create default proxy account
CREATE USER ''@''
IDENTIFIED WITH ldap_auth
AS 'O=Oracle, OU=MySQL';
-- create proxied accounts; use
-- mysql_no_login plugin to prevent direct login
CREATE USER 'developer'@'localhost'
IDENTIFIED WITH mysql_no_login;
CREATE USER 'manager'@'localhost'
IDENTIFIED WITH mysql_no_login;
-- grant to default proxy account the
-- PROXY privilege for proxied accounts
GRANT PROXY
ON 'manager'@'localhost'
TO ''@'';
GRANT PROXY
ON 'developer'@'localhost'
TO ''@'';
现在假设客户端连接如下：
$> mysql --user=myuser --password ...
Enter password: myuser_password
服务器未发现myuser定义为 MySQL 用户，但由于存在''@''与客户端用户名和主机名匹配的空白用户帐户 ( )，因此服务器根据该帐户对客户端进行身份验证。服务器调用ldap_auth
身份验证插件并将myuser和
myuser_password作为用户名和密码传递给它。
如果ldap_auth插件在 LDAP 目录中发现 的myuser_password密码不正确myuser，则身份验证失败并且服务器拒绝连接。
如果密码正确，ldap_auth
发现myuser是开发者，则返回用户名developer给MySQL服务器，而不是myuser. 将与信号的客户端用户名不同的用户名返回给myuser
它应
myuser视为代理的服务器。服务器验证
''@''可以验证为
developer（因为''@''
有PROXY这样做的特权）并接受连接。会话以
被代理用户myuser的特权
继续进行。developer（这些权限应由 DBA 使用
GRANT语句设置，未显示。
USER()）
CURRENT_USER()函数返回这些值：
mysql> SELECT USER(), CURRENT_USER();
+------------------+---------------------+
| USER()           | CURRENT_USER()      |
+------------------+---------------------+
| myuser@localhost | developer@localhost |
+------------------+---------------------+
如果插件在 LDAP 目录中找到的
myuser是管理员，它将
manager作为用户名返回，并且会话继续具有代理用户
myuser的权限。managermysql> SELECT USER(), CURRENT_USER();
+------------------+-------------------+
| USER()           | CURRENT_USER()    |
+------------------+-------------------+
| myuser@localhost | manager@localhost |
+------------------+-------------------+
为简单起见，外部身份验证不能是多级的：在前面的示例中既没有考虑用于的凭据developer也没有考虑用于的凭据。manager但是，如果客户端尝试连接并直接作为
developer或manager
帐户进行身份验证，它们仍然会被使用，这就是为什么应该保护这些代理帐户免受直接登录的原因（请参阅
防止直接登录到代理帐户）。
默认代理用户和匿名用户冲突
如果您打算创建默认代理用户，请检查优先于默认代理用户
的其他现有“匹配任何用户”帐户，因为它们可以阻止该用户按预期工作。
在前面的讨论中，默认代理用户帐户
''在主机部分，匹配任何主机。如果设置默认代理用户，请注意检查是否存在具有相同用户部分和
'%'主机部分的非代理帐户，因为它
'%'也匹配任何主机，但优先于''服务器用于对帐户行进行排序的规则内部（参见
第 6.2.6 节，“访问控制，第 1 阶段：连接验证”）。
假设 MySQL 安装包括这两个帐户：
-- create default proxy account
CREATE USER ''@''
IDENTIFIED WITH some_plugin
AS 'some_auth_string';
-- create anonymous account
CREATE USER ''@'%'
IDENTIFIED BY 'anon_user_password';
第一个帐户 ( ''@'') 用作默认代理用户，用于验证不匹配更具体帐户的用户的连接。第二个帐户 ( ''@'%') 是一个匿名用户帐户，创建它可能是为了让没有自己帐户的用户能够匿名连接。
这两个帐户具有相同的用户部分 ( '')，匹配任何用户。每个帐户都有一个与任何主机匹配的主机部分。然而，在连接尝试的帐户匹配中有一个优先级，因为匹配规则将主机'%'排在前面''。对于不匹配任何更具体的帐户的帐户，服务器会尝试针对
''@'%'（匿名用户）而不是
''@''（默认代理用户）对它们进行身份验证。因此，永远不会使用默认代理帐户。
要避免此问题，请使用以下策略之一：
删除匿名帐户，使其不与默认代理用户冲突。
使用在匿名用户之前匹配的更具体的默认代理用户。例如，要仅允许
localhost代理连接，请使用
''@'localhost'：
CREATE USER ''@'localhost'
IDENTIFIED WITH some_plugin
AS 'some_auth_string';
此外，将任何GRANT PROXY
语句修改为名称''@'localhost'而不是''@''作为代理用户。
请注意，此策略可防止匿名用户连接来自localhost.
使用命名默认帐户而不是匿名默认帐户。有关此技术的示例，请参阅使用
authentication_windows插件的说明。请参阅
第 6.4.1.6 节，“Windows 可插入身份验证”。
创建多个代理用户，一个用于本地连接，一个用于“其他一切”（远程连接）。这在本地用户应具有与远程用户不同的权限时尤其有用。
创建代理用户：
-- create proxy user for local connections
CREATE USER ''@'localhost'
IDENTIFIED WITH some_plugin
AS 'some_auth_string';
-- create proxy user for remote connections
CREATE USER ''@'%'
IDENTIFIED WITH some_plugin
AS 'some_auth_string';
创建代理用户：
-- create proxied user for local connections
CREATE USER 'developer'@'localhost'
IDENTIFIED WITH mysql_no_login;
-- create proxied user for remote connections
CREATE USER 'developer'@'%'
IDENTIFIED WITH mysql_no_login;
授予每个代理帐户
PROXY相应代理帐户的权限：
GRANT PROXY
ON 'developer'@'localhost'
TO ''@'localhost';
GRANT PROXY
ON 'developer'@'%'
TO ''@'%';
最后，将适当的权限授予本地和远程代理用户（未显示）。
假设
some_plugin/
组合导致将客户端用户名映射到。本地连接匹配
代理用户，映射到
代理用户。远程连接匹配代理用户，映射到
代理用户。
'some_auth_string'some_plugindeveloper''@'localhost''developer'@'localhost'''@'%''developer'@'%'
服务器支持代理用户映射
一些身份验证插件为自己实现代理用户映射（例如，PAM 和 Windows 身份验证插件）。其他认证插件默认不支持代理用户。其中，一些可以请求 MySQL 服务器本身根据授予的代理权限映射代理用户：mysql_native_password，
sha256_password。如果
check_proxy_users启用了系统变量，则服务器会为发出此类请求的任何身份验证插件执行代理用户映射：
默认情况下，
check_proxy_users禁用，因此服务器不执行代理用户映射，即使对于请求服务器支持代理用户的身份验证插件也是如此。
如果check_proxy_users启用，可能还需要启用特定于插件的系统变量以利用服务器代理用户映射支持：
对于mysql_native_password插件，启用
mysql_native_password_proxy_users.
对于sha256_password插件，启用
sha256_password_proxy_users.
例如，要启用所有上述功能，请使用my.cnf文件中的这些行启动服务器：
[mysqld]
check_proxy_users=ON
mysql_native_password_proxy_users=ON
sha256_password_proxy_users=ON
假设已启用相关系统变量，像往常一样使用创建代理用户CREATE
USER，然后将其授予
PROXY其他单个帐户的权限，将其视为代理用户。当服务器收到代理用户的成功连接请求时，它会发现该用户具有PROXY
权限并使用它来确定正确的代理用户。
-- create proxy account
CREATE USER 'proxy_user'@'localhost'
IDENTIFIED WITH mysql_native_password
BY 'password';
-- create proxied account and grant its privileges;
-- use mysql_no_login plugin to prevent direct login
CREATE USER 'proxied_user'@'localhost'
IDENTIFIED WITH mysql_no_login;
-- grant privileges to proxied account
GRANT ...
ON ...
TO 'proxied_user'@'localhost';
-- grant to proxy account the
-- PROXY privilege for proxied account
GRANT PROXY
ON 'proxied_user'@'localhost'
TO 'proxy_user'@'localhost';
要使用代理帐户，请使用其名称和密码连接到服务器：
$> mysql -u proxy_user -p
Enter password: (enter proxy_user password here)
身份验证成功，服务器发现
proxy_user具有 的
PROXY权限
proxied_user，会话继续
proxy_user具有 的权限
proxied_user。
服务器执行的代理用户映射受以下限制：
即使PROXY
授予了相关权限，服务器也不会代理到匿名用户或从匿名用户代理。
当一个帐户被授予多个代理帐户的代理权限时，服务器代理用户映射是不确定的。因此，不鼓励向单个帐户授予多个代理帐户的代理权限。
代理用户系统变量
两个系统变量有助于跟踪代理登录过程：
proxy_userNULL：如果不使用代理，则此值为
。否则，它表示代理用户帐户。例如，如果客户端通过''@''
代理帐户进行身份验证，则此变量设置如下：
mysql> SELECT @@proxy_user;
+--------------+
| @@proxy_user |
+--------------+
| ''@''        |
+--------------+
external_user：有时身份验证插件可能会使用外部用户对 MySQL 服务器进行身份验证。例如，当使用 Windows 本机身份验证时，使用 Windows API 进行身份验证的插件不需要传递给它的登录 ID。但是，它仍然使用 Windows 用户 ID 进行身份验证。external_user插件可以使用只读会话变量将此外部用户 ID（或其前 512 个 UTF-8 字节）返回给服务器
。如果插件没有设置这个变量，它的值为
NULL.
© Mysql 中文网
