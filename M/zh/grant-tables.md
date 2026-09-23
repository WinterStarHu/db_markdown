# 6.2.3 授权表_MySQL 8.0 参考手册

6.2.3 授权表_MySQL 8.0 参考手册
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
6.2.3 授权表
6.2.3 授权表
系统mysql数据库包括几个授权表，其中包含有关用户帐户及其拥有的权限的信息。本节介绍这些表。有关系统数据库中其他表的信息，请参阅
第 5.3 节，“mysql 系统模式”。
此处的讨论描述了授权表的底层结构以及服务器在与客户端交互时如何使用它们的内容。但是，通常您不会直接修改授权表。当您使用帐户管理语句（例如 、 和 ）来设置帐户并控制每个帐户的可用权限时，会间接CREATE
USER发生GRANT修改
REVOKE。参见
第 13.7.1 节，“账户管理声明”。当您使用此类语句执行帐户操作时，服务器会代表您修改授权表。
笔记
INSERT不鼓励使用、
UPDATE或
等语句直接修改授权表
，DELETE这样做的风险由您自行承担。服务器可以自由地忽略由于此类修改而变得畸形的行。
对于任何修改授权表的操作，服务器都会检查该表是否具有预期的结构，如果没有则产生错误。要将表更新为预期的结构，请执行 MySQL 升级过程。请参阅
第 2.11 节，“升级 MySQL”。
授权表概述用户和数据库授权表tables_priv 和 columns_priv 授权表procs_priv 授权表proxies_priv 授权表global_grants 授权表default_roles 授权表role_edges 授权表password_history 授权表授予表范围列属性授予表权限列属性授予表并发
授权表概述
这些mysql数据库表包含授权信息：
user：用户帐户、静态全局权限和其他非权限列。
global_grants：动态全局权限。
db：数据库级权限。
tables_priv：表级权限。
columns_priv: 列级权限。
procs_priv: 存储过程和函数权限。
proxies_priv: 代理用户权限。
default_roles：默认用户角色。
role_edges：角色子图的边。
password_history: 密码更改历史。
有关静态和动态全局权限之间差异的信息，请参阅
静态与动态权限。）
在 MySQL 8.0 中，授权表使用
InnoDB存储引擎并且是事务性的。在 MySQL 8.0 之前，授权表使用
MyISAM存储引擎并且是非事务性的。授权表存储引擎的这种变化可以伴随改变账户管理语句的行为，例如
CREATE USER或
GRANT。以前，命名多个用户的帐户管理语句可能对某些用户成功而对其他用户失败。现在，每个语句都是事务性的，并且要么对所有指定用户成功，要么回滚，如果发生任何错误则无效。
每个授权表都包含范围列和权限列：
范围列确定表中每一行的范围；即，该行适用的上下文。例如，user表行的
Host值为User并且'h1.example.net'适用
'bob'于验证
h1.example.net指定用户名为 的客户端从主机到服务器的连接bob。类似地，
db表行的
Host、User和
Db列值为
'h1.example.net'，
'bob'并且'reports'
在bob从主机连接
h1.example.net以访问
reports数据库时应用。这
tables_priv和
columns_priv表包含范围列，指示每行适用的表或表/列组合。procs_priv范围列指示每行适用的存储例程
。
特权列表示表行授予哪些特权；也就是说，它允许执行哪些操作。服务器将各种授权表中的信息组合起来，形成对用户权限的完整描述。第 6.2.7 节，“访问控制，第 2 阶段：请求验证”，描述了这方面的规则。
此外，授权表可能包含用于范围或权限评估以外目的的列。
服务器以下列方式使用授权表：
表user范围列确定是拒绝还是允许传入连接。对于允许的连接，表中授予的任何权限都
user表示用户的静态全局权限。此表中授予的任何权限适用于服务器上的所有数据库。
警告
因为任何静态全局权限都被认为是所有数据库的权限，所以任何静态全局权限都使用户能够使用
SHOW DATABASES或通过检查SCHEMATA表来查看所有数据库名称INFORMATION_SCHEMA，但已通过部分撤销在数据库级别受到限制的数据库除外。
该global_grants表列出了当前分配给用户帐户的动态全局权限。对于每一行，范围列确定哪个用户具有特权列中指定的特权。
表db范围列确定哪些用户可以从哪些主机访问哪些数据库。特权列确定允许的操作。在数据库级别授予的权限适用于数据库和数据库中的所有对象，例如表和存储程序。
和表类似于
表tables_priv，
但更细粒度：它们适用于表和列级别，而不是数据库级别。在表级别授予的特权适用于表及其所有列。在列级别授予的权限仅适用于特定列。
columns_privdb
该procs_priv表适用于存储例程（存储过程和函数）。在例程级别授予的特权仅适用于单个过程或函数。
该proxies_priv表指示哪些用户可以充当其他用户的代理，以及用户是否可以将PROXY权限授予其他用户。
default_roles和
role_edges表包含有关角色关系
的信息。
该password_history表保留以前选择的密码以启用对密码重用的限制。请参阅第 6.2.15 节，“密码管理”。
服务器在启动时将授权表的内容读入内存。您可以通过发出FLUSH PRIVILEGES语句或执行mysqladmin flush-privileges或
mysqladmin reload命令告诉它重新加载表。授权表的更改生效，如
第 6.2.13 节“特权更改何时生效”中所述。
修改帐户时，最好验证您的更改是否具有预期效果。要检查给定帐户的权限，请使用该SHOW
GRANTS语句。例如，要确定授予用户名和主机名值为bob和
的帐户的权限pc84.example.com，请使用以下语句：
SHOW GRANTS FOR 'bob'@'pc84.example.com';
要显示帐户的非特权属性，请使用
SHOW CREATE USER：
SHOW CREATE USER 'bob'@'pc84.example.com';
用户和数据库授权表
服务器
在访问控制的第一阶段和第二阶段都使用数据库中的user和
db表（请参阅第 6.2 节，“访问控制和帐户管理”）。和表中的列
显示在此处。
mysqluserdb
表 6.4 user 和 db 表列
表名
user
db
范围列
Host
Host
User
Db
User
特权专栏
Select_priv
Select_priv
Insert_priv
Insert_priv
Update_priv
Update_priv
Delete_priv
Delete_priv
Index_priv
Index_priv
Alter_priv
Alter_priv
Create_priv
Create_priv
Drop_priv
Drop_priv
Grant_priv
Grant_priv
Create_view_priv
Create_view_priv
Show_view_priv
Show_view_priv
Create_routine_priv
Create_routine_priv
Alter_routine_priv
Alter_routine_priv
Execute_priv
Execute_priv
Trigger_priv
Trigger_priv
Event_priv
Event_priv
Create_tmp_table_priv
Create_tmp_table_priv
Lock_tables_priv
Lock_tables_priv
References_priv
References_priv
Reload_priv
Shutdown_priv
Process_priv
File_priv
Show_db_priv
Super_priv
Repl_slave_priv
Repl_client_priv
Create_user_priv
Create_tablespace_priv
Create_role_priv
Drop_role_priv
安全栏目
ssl_type
ssl_cipher
x509_issuer
x509_subject
plugin
authentication_string
password_expired
password_last_changed
password_lifetime
account_locked
Password_reuse_history
Password_reuse_time
Password_require_current
User_attributes
资源控制栏
max_questions
max_updates
max_connections
max_user_connections
表和
user列存储身份验证插件和凭证信息。
pluginauthentication_string
服务器使用在帐户行的列中命名的插件
plugin来验证帐户的连接尝试。
该plugin列必须是非空的。在启动时和运行时FLUSH
PRIVILEGES执行时，服务器会检查
user表行。对于任何包含空
plugin列的行，服务器都会将警告写入此表单的错误日志：
[Warning] User entry 'user_name'@'host_name' has an empty plugin
value. The user will be ignored and no one can login with this user
anymore.
要将插件分配给缺少插件的帐户，请使用该
ALTER USER语句。
该password_expired列允许 DBA 使帐户密码过期并要求用户重置其密码。默认password_expired值为'N'，但可以
'Y'使用ALTER
USER语句设置为。帐户密码过期后，该帐户在后续与服务器的连接中执行的所有操作都会导致错误，直到用户发出ALTER USER建立新帐户密码的语句。
笔记
虽然可以通过将过期的密码设置为当前值来“重置”该密码，但作为一种好的策略，最好选择一个不同的密码。DBA 可以通过建立适当的密码重用策略来强制禁止重用。请参阅
密码重用政策。
password_last_changed是一
TIMESTAMP列，指示上次更改密码的时间。该值NULL不仅适用于使用 MySQL 内置身份验证插件的帐户（mysql_native_password、
sha256_password或
caching_sha2_password）。该值适用
NULL于其他帐户，例如使用外部身份验证系统进行身份验证的帐户。
password_last_changed由
CREATE USER、
ALTER USER和
SET PASSWORD语句以及
GRANT创建帐户或更改帐户密码的语句更新。
password_lifetime表示帐号密码的有效期，以天为单位。如果密码已过有效期（使用该password_last_changed
列进行评估），则当客户端使用该帐户连接时，服务器会认为密码已过期。大于零的值
N意味着必须每天更改密码N
。值为 0 将禁用自动密码过期。如果值为NULL（默认值），则应用全局过期策略，如
default_password_lifetime
系统变量所定义。
account_locked指示帐户是否被锁定（请参阅第 6.2.20 节，“帐户锁定”）。
Password_reuse_history是
PASSWORD HISTORY账户或
NULL默认历史的选项值。
Password_reuse_time是
PASSWORD REUSE INTERVAL帐户选项的值，或NULL默认间隔。
Password_require_current(MySQL 8.0.13新增)对应PASSWORD
REQUIRE账户选项的值，如下表所示。
表 6.5 允许的 Password_require_current 值
Password_require_current 值
相应的 PASSWORD REQUIRE 选项
'Y'
PASSWORD REQUIRE CURRENT
'N'
PASSWORD REQUIRE CURRENT OPTIONAL
NULL
PASSWORD REQUIRE CURRENT DEFAULT
User_attributes（在 MySQL 8.0.14 中添加）是一个 JSON 格式的列，用于存储其他列中未存储的帐户属性。从 MySQL 8.0.21 开始，
INFORMATION_SCHEMA通过表公开这些属性USER_ATTRIBUTES。
该User_attributes列可能包含以下属性：
additional_password：辅助密码（如果有）。请参阅双重密码支持。
Restrictions：限制列表，如果有的话。通过部分撤销操作添加限制。属性值是一个元素数组，每个元素都有
Database和
Restrictions键，指示受限数据库的名称及其适用的限制（请参阅第 6.2.12 节，“使用部分撤销的权限限制”）。
Password_locking：登录失败跟踪和临时帐户锁定的条件（如果有）（请参阅登录失败跟踪和临时帐户锁定）。该
Password_locking属性根据and
语句的FAILED_LOGIN_ATTEMPTS
andPASSWORD_LOCK_TIME选项进行
更新。属性值是一个散列，其中包含
指示已为帐户指定的此类选项的值的键。
如果缺少某个键，则其值隐式为 0。如果某个键值隐式或显式为 0，则禁用相应的功能。这个属性是在 MySQL 8.0.19 中添加的。
CREATE USERALTER USERfailed_login_attemptspassword_lock_time_days
multi_factor_authentication:
mysql.user系统表中的行有一
plugin列表示身份验证插件。对于单因素身份验证，该插件是唯一的身份验证因素。对于双因素或三因素形式的多因素身份验证，该插件对应于第一个身份验证因素，但必须为第二个和第三个因素存储附加信息。该
multi_factor_authentication属性保存此信息。此属性是在 MySQL 8.0.27 中添加的。
该multi_factor_authentication值是一个数组，其中每个数组元素都是一个散列，使用这些属性描述身份验证因素：
plugin：身份验证插件的名称。
authentication_string：身份验证字符串值。
passwordless：一个标志，表示用户是否要在没有密码的情况下使用（使用安全令牌作为唯一的身份验证方法）。
requires_registration：定义用户帐户是否已注册安全令牌的标志。
第一个和第二个数组元素描述多因素身份验证因素 2 和 3。
如果没有应用属性，User_attributes则为
NULL.
示例：具有辅助密码和部分撤销数据库权限的帐户
在列值中
具有additional_password和
属性：Restrictionsmysql> SELECT User_attributes FROM mysql.User WHERE User = 'u'\G
*************************** 1. row ***************************
User_attributes: {"Restrictions":
[{"Database": "mysql", "Privileges": ["SELECT"]}],
"additional_password": "hashed_credentials"}
要确定存在哪些属性，请使用以下
JSON_KEYS()函数：
SELECT User, Host, JSON_KEYS(User_attributes)
FROM mysql.user WHERE User_attributes IS NOT NULL;
要提取特定属性，例如
Restrictions，请执行以下操作：
SELECT User, Host, User_attributes->>'$.Restrictions'
FROM mysql.user WHERE User_attributes->>'$.Restrictions' <> '';
以下是为 存储的信息类型的示例
multi_factor_authentication：
{
"multi_factor_authentication": [
{
"plugin": "authentication_ldap_simple",
"passwordless": 0,
"authentication_string": "ldap auth string",
"requires_registration": 0
},
{
"plugin": "authentication_fido",
"passwordless": 0,
"authentication_string": "",
"requires_registration": 1
}
]
}
tables_priv 和 columns_priv 授权表
在访问控制的第二阶段，服务器执行请求验证以确保每个客户端对其发出的每个请求都有足够的权限。除了
授权表，服务器还可以查询user涉及表的请求的表
。后面的表在表和列级别提供更精细的权限控制。它们具有下表中显示的列。
dbtables_privcolumns_priv
表 6.6 tables_priv 和 columns_priv 表列
表名
tables_priv
columns_priv
范围列
Host
Host
Db
Db
User
User
Table_name
Table_name
Column_name
特权专栏
Table_priv
Column_priv
Column_priv
其他专栏
Timestamp
Timestamp
Grantor
和
列分别设置为当前时间戳和
Timestamp值，但在其他方面未使用。
GrantorCURRENT_USER
procs_priv 授权表
为了验证涉及存储例程的请求，服务器可以查询procs_priv表，该表具有下表中显示的列。
表 6.7 procs_priv 表列
表名
procs_priv
范围列
Host
Db
User
Routine_name
Routine_type
特权专栏
Proc_priv
其他专栏
Timestamp
Grantor
该Routine_type列是一
ENUM列，其值为
'FUNCTION'或'PROCEDURE'
以指示该行引用的例程类型。此列允许为具有相同名称的函数和过程分别授予权限。
和Timestamp列Grantor
未使用。
proxies_priv 授权表
该proxies_priv表记录了有关代理帐户的信息。它有这些列：
Host, User: 代理账户；也就是说，具有
PROXY代理帐户权限的帐户。
Proxied_host,
Proxied_user: 代理帐户。
Grantor, Timestamp: 未使用。
With_grant：代理账号是否可以授权PROXY给其他账号。
对于能够将
PROXY权限授予其他帐户的帐户，它必须在
proxies_priv表中
有一行With_grant设置为 1，
Proxied_host并且
Proxied_user设置为指示可以授予权限的一个或多个帐户。例如，'root'@'localhost'在安装 MySQL 时创建的帐户在
proxies_priv表中有一行可以授予
PROXY权限
''@''，即所有用户和所有主机。这可以root设置代理用户，以及将设置代理用户的权限委托给其他帐户。请参阅第 6.2.19 节，“代理用户”。
global_grants 授权表
该global_grants表列出了当前分配给用户帐户的动态全局权限。该表有以下列：
USER, HOST: 授予权限的帐户的用户名和主机名。
PRIV: 特权名称。
WITH_GRANT_OPTION：该账号是否可以授予其他账号权限。
default_roles 授权表
该default_roles表列出了默认用户角色。它有这些列：
HOST, USER: 默认角色适用的账户或角色。
DEFAULT_ROLE_HOST,
DEFAULT_ROLE_USER: 默认角色。
role_edges 授权表
该role_edges表列出了角色子图的边。它有这些列：
FROM_HOST, FROM_USER：被授予角色的账户。
TO_HOST, TO_USER: 授予账户的角色。
WITH_ADMIN_OPTION: 该账户是否可以通过使用 向其他账户授予和撤销该角色WITH ADMIN OPTION。
password_history 授权表
该password_history表包含有关密码更改的信息。它有这些列：
Host, User: 发生密码更改的帐户。
Password_timestamp：密码更改发生的时间。
Password: 新密码哈希值。
该password_history表为每个帐户积累了足够数量的非空密码，以使 MySQL 能够针对帐户密码历史长度和重用间隔执行检查。当尝试更改密码时，会自动删除超出这两个限制的条目。
笔记
空密码不计入密码历史记录，可以随时重复使用。
如果一个帐户被重命名，它的条目被重命名以匹配。如果删除帐户或更改其身份验证插件，则会删除其条目。
授予表范围列属性
授权表中的范围列包含字符串。每个的默认值为空字符串。下表显示了每列中允许的字符数。
表 6.8 授权表范围列长度
列名
最大允许字符数
Host,Proxied_host
255（MySQL 8.0.17 之前为 60）
User,Proxied_user
32
Db
64
Table_name
64
Column_name
64
Routine_name
64
Host和Proxied_host
值在存储在授权表之前被转换为小写。
出于访问检查目的，比较
User、Proxied_user、
authentication_string、Db和Table_name值区分大小写。Host、
Proxied_host、Column_name和值的比较Routine_name不区分大小写。
授予表权限列属性
user和表
在db声明为 的单独列中列出每个权限
ENUM('N','Y') DEFAULT 'N'。换句话说，每个权限都可以禁用或启用，默认情况下是禁用的。
、tables_priv和
表将特权列声明为columns_priv列
。这些列中的值可以包含表控制的权限的任意组合。仅启用列值中列出的那些权限。
procs_privSET
表 6.9 集合类型权限列值
表名
列名
可能的集合元素
tables_priv
Table_priv
'Select', 'Insert', 'Update', 'Delete', 'Create', 'Drop',
'Grant', 'References', 'Index', 'Alter', 'Create View',
'Show view', 'Trigger'
tables_priv
Column_priv
'Select', 'Insert', 'Update', 'References'
columns_priv
Column_priv
'Select', 'Insert', 'Update', 'References'
procs_priv
Proc_priv
'Execute', 'Alter Routine', 'Grant'
只有user和
global_grants表指定管理权限，例如RELOAD、
SHUTDOWN和
SYSTEM_VARIABLES_ADMIN。管理操作是对服务器本身的操作，而不是特定于数据库的，因此没有理由在其他授权表中列出这些权限。因此，服务器只需查询user和
global_grants表即可确定用户是否可以执行管理操作。
该FILE权限也仅在user表中指定。它本身不是管理特权，但用户在服务器主机上读取或写入文件的能力与所访问的数据库无关。
授予表并发
从 MySQL 8.0.22 开始，为了允许对 MySQL 授权表进行并发 DML 和 DDL 操作，以前在 MySQL 授权表上获取行锁的读取操作将作为非锁定读取执行。作为对 MySQL 授权表的非锁定读取执行的操作包括：
SELECT语句和其他只读语句，它们通过连接列表和子查询从授权表中读取数据，包括
SELECT
... FOR SHARE使用任何事务隔离级别的语句。
使用任何事务隔离级别从授权表（通过连接列表或子查询）读取数据但不修改它们的 DML 操作。
如果在使用基于语句的复制时执行，从授权表读取数据时不再获取行锁的语句会报告警告。
使用 -binlog_format=mixed时，从授权表读取数据的 DML 操作将作为行事件写入二进制日志，以使操作对于混合模式复制是安全的。
SELECT ...
FOR SHARE从授权表中读取数据的语句会报告警告。使用该FOR SHARE子句，授权表不支持读锁。
从授权表读取数据并使用SERIALIZABLE
隔离级别执行的 DML 操作会报告警告。SERIALIZABLE授权表不支持
通常在使用隔离级别时获取的读取锁
。
© Mysql 中文网
