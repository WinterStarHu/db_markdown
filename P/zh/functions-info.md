# 9.27. 系统信息函数和运算符

9.27. 系统信息函数和运算符
版本：
纠错本页面
搜索
目录导航
❮
❯
9.27. 系统信息函数和运算符 #9.27.1. 会话信息函数9.27.2. 访问权限查询函数9.27.3. 模式可见性查询函数9.27.4. 系统目录信息函数9.27.5. 对象信息和定位函数9.27.6. 注释信息函数9.27.7. 数据有效性检查函数9.27.8. 事务 ID 和快照信息函数9.27.9. 已提交事务信息函数9.27.10. 控制数据函数9.27.11. 版本信息函数9.27.12. WAL 汇总信息函数
本节中描述的函数用于获取有关PostgreSQL安装的各种信息。
9.27.1. 会话信息函数 #
表 9.71展示了多个可以提取会话和系统信息的函数。
除了本节列出的函数外，还有许多与统计系统相关的函数，这些函数也提供系统信息。有关更多信息，请参见第 27.2.26 节。
表 9.71. 会话信息函数
函数
描述
current_catalog
→ name
current_database ()
→ name
返回当前数据库的名称。(在SQL标准中数据库被称为“catalogs”，因此current_catalog是该标准的拼写方式。)
current_query ()
→ text
返回当前所执行查询的文本，由客户端提交的(可能包含一个以上的语句)。
current_role
→ name
这等同于 current_user。
current_schema
→ name
current_schema ()
→ name
返回在搜索路径中的第一个模式的名称(如果搜索路径为空则返回空值)。
这个模式将用于没有指定目标模式就创建的任何表或其他已命名对象。
current_schemas ( include_implicit boolean )
→ name[]
返回当前在有效搜索路径中的所有模式的名称的数组，以优先级顺序。
(当前 search_path设置中与已存在的、可搜索模式不相符的项将被省略。)
如果布尔参数为true，则类似pg_catalog的隐式搜索的系统模式将包含在结果中。
current_user
→ name
返回当前执行上下文的用户名。
inet_client_addr ()
→ inet
返回当前客户端的IP地址，如果当前连接是通过Unix-域套接字则返回NULL。
inet_client_port ()
→ integer
返回当前客户端的IP端口号，如果当前连接是通过Unix域套接字则返回NULL。
inet_server_addr ()
→ inet
返回服务器接受当前连接的IP地址，如果当前连接是通过Unix域套接字则返回NULL。
inet_server_port ()
→ integer
返回服务器接受当前连接的IP端口号，如果当前连接是通过Unix域套接字则返回NULL。
pg_backend_pid ()
→ integer
返回附加到当前会话的服务器进程的进程ID。
pg_blocking_pids ( integer )
→ integer[]
返回阻止服务器进程的会话的进程ID数组，该进程ID与指定的进程ID一起获取锁，如果没有这样的服务器进程或者没有被阻塞，则返回一个空数组。
如果一个服务器进程持有一个与被阻塞进程的锁请求冲突的锁（硬阻塞），或者正在等待一个与被阻塞进程的锁请求冲突并且在等待队列中位于其前面的锁（软阻塞），那么这个服务器进程就会阻塞另一个服务器进程。
当使用并行查询时结果总是列出客户端可见的进程ID（即pg_backend_pid的结果），即使实际的锁是由子工作进程持有或等待的。
因此，结果中可能存在重复的PID。还要注意当准备好的事务持有冲突锁时，它将用零进程ID表示。
频繁调用这个函数可能会对数据库性能产生一些影响，因为它需要在短时间内独占访问锁管理器的共享状态。
pg_conf_load_time ()
→ timestamp with time zone
返回服务器配置文件最后加载的时间。如果当前会话当时是活跃的，那么这将是会话本身重新读取配置文件的时间（因此在不同的会话中读取会稍有不同）。
否则，就是postmaster进程重新读取配置文件的时间。
pg_current_logfile ( [ text ] )
→ text
返回当前由日志收集器使用的日志文件的路径名。该路径包括
log_directory目录和单个日志文件名。如果日志收集器被禁用，
结果为NULL。当存在多个日志文件且格式各不相同时，
pg_current_logfile在无参数调用时返回按顺序列表中
首个格式的文件路径：stderr、csvlog、
jsonlog。如果没有任何日志文件符合这些格式，则返回
NULL。
要请求特定日志文件格式的信息，请将csvlog、
jsonlog或stderr作为可选参数的值。
如果请求的日志格式未在log_destination中配置，
结果为NULL。
结果反映了current_logfiles文件的内容。
默认情况下，此函数仅限超级用户和具有pg_monitor角色权限的角色使用，
但其他用户也可以被授予EXECUTE权限来运行该函数。
pg_get_loaded_modules ()
→ setof record
( module_name text,
version text,
file_name text )
返回当前服务器会话中加载的可加载模块的列表。
module_name 和 version 字段为 NULL，
除非模块作者使用 PG_MODULE_MAGIC_EXT 宏提供了值。
file_name 字段给出模块的文件名（共享库）。
pg_my_temp_schema ()
→ oid
返回当前会话的临时模式的OID，如果没有则返回0（因为它没有创建任何临时表）。
pg_is_other_temp_schema ( oid )
→ boolean
如果给定的OID是另一个会话的临时模式的OID则返回真。（这可能是有用的，例如，在目录显示中排除其他会话的临时表。）
pg_jit_available ()
→ boolean
返回真，如果JIT编译器扩展可用（参见第 30 章），并且jit配置参数设置为on。
pg_numa_available ()
→ boolean
返回真，如果服务器已编译支持NUMA。
pg_listening_channels ()
→ setof text
返回当前会话正在侦听的异步通知通道的名称集。
pg_notification_queue_usage ()
→ double precision
返回当前被等待处理的通知所占用的异步通知队列最大尺寸的分数（0–1）。更多信息请参见LISTEN和NOTIFY。
pg_postmaster_start_time ()
→ timestamp with time zone
返回服务器启动时的时间。
pg_safe_snapshot_blocking_pids ( integer )
→ integer[]
返回一个进程ID数组，该进程ID是阻塞服务器进程获取安全快照的会话的进程ID数组，如果没有这样的服务器进程或者没有阻塞，则返回一个空数组。
运行SERIALIZABLE事务的会话会阻止SERIALIZABLE READ ONLY DEFERRABLE事务获取快照，直到后者确定可以安全地避免获取谓词锁。
关于可序列化和可延迟事务的更多信息，请参见第 13.2.3 节。
频繁调用这个函数可能会对数据库性能产生一些影响，因为它需要在短时间内访问谓词锁管理器的共享状态。
pg_trigger_depth ()
→ integer
返回当前嵌套层次的PostgreSQL触发器（如果没有调用则为0，直接或间接，从一个触发器内部开始）。
session_user
→ name
返回会话用户名。
system_user
→ text
返回用户在身份验证周期中提供的身份验证方法和身份（如果有），
在分配数据库角色之前。它表示为
auth_method:identity，如果用户尚未通过身份验证
（例如使用了
信任身份验证），则表示为
NULL。
user
→ name
这相当于 current_user。
注意
current_catalog、current_role、current_schema、current_user、session_user和user在SQL里有特殊的语法状态：它们被调用时结尾不要跟着括号。
在 PostgreSQL 中，括号可以有选择性地被用于current_schema，但是不能和其他的一起用。
session_user通常是发起当前数据库连接的用户，不过超级用户可以用SET SESSION AUTHORIZATION修改这个设置。
current_user是用于权限检查的用户标识。通常，它等于会话用户，但是可以被SET ROLE改变。
它也会在函数执行的过程中随着属性SECURITY DEFINER的改变而改变。
在 Unix 的说法里，会话用户是“真实用户”，而当前用户是“有效用户”。
current_role和user是current_user的同义词（SQL标准在current_role和current_user之间做了区分，但PostgreSQL不区分，因为它把用户和角色统一成了一种实体）。
9.27.2. 访问权限查询函数 #
表 9.72列出那些允许编程查询对象访问权限的函数。参阅第 5.8 节获取更多有关权限的信息。
在这些函数中，可以通过名称或OID (pg_authid.oid)指定被查询权限的用户，或者如果名称被指定为public，则检查PUBLIC伪角色的权限。
同样，user参数可以完全省略，在这种情况下，假设为current_user。被查询的对象也可以通过名称或OID来指定。
通过名称指定时，可以包含相关的模式名称。感兴趣的访问权限由一个文本字符串指定，它必须计算为对象类型的一个适当的权限关键字(例如，SELECT)。
还可以将WITH GRANT OPTION添加到权限类型中，以测试该权限是否由授予选项持有。
同样，可以用逗号分隔列出多个权限类型，在这种情况下，如果所列出的权限中有任何一个被持有，结果将为真。
(权限字符串的大小写不重要，权限名之间允许有额外的空格，但在权限名中不允许。)一些例子:
SELECT has_table_privilege('myschema.mytable', 'select');
SELECT has_table_privilege('joe', 'mytable', 'INSERT, SELECT WITH GRANT OPTION');
表 9.72. 访问权限查询函数
函数
描述
has_any_column_privilege (
[ user name or oid, ]
table text or oid,
privilege text )
→ boolean
用户是否对表的任何列有权限?
如果对整个表持有权限，或者对至少一个列有列级的权限授予，则会成功。
允许的权限类型为
SELECT, INSERT,
UPDATE, 和 REFERENCES。
has_column_privilege (
[ user name or oid, ]
table text or oid,
column text or smallint,
privilege text )
→ boolean
用户对指定的表列有权限吗?
如果对整个表持有权限，或者对列授予了列级别的权限，则会成功。
可以通过名称或属性编号(pg_attribute.attnum)指定列。
允许的权限类型为SELECT, INSERT, UPDATE, 和 REFERENCES。
has_database_privilege (
[ user name or oid, ]
database text or oid,
privilege text )
→ boolean
用户对数据库有权限吗?
允许的权限类型为
CREATE,
CONNECT,
TEMPORARY, 和
TEMP (相当于
TEMPORARY)。
has_foreign_data_wrapper_privilege (
[ user name or oid, ]
fdw text or oid,
privilege text )
→ boolean
用户是否拥有外部数据包装的权限?
唯一允许的权限类型是USAGE。
has_function_privilege (
[ user name or oid, ]
function text or oid,
privilege text )
→ boolean
用户对函数有权限吗?
唯一允许的权限类型是EXECUTE。
当通过名称而不是OID指定函数时，允许的输入与regprocedure数据类型相同(参见第 8.19 节)。一个例子为：
SELECT has_function_privilege('joeuser', 'myfunc(int, text)', 'execute');
has_language_privilege (
[ user name or oid, ]
language text or oid,
privilege text )
→ boolean
用户对语言有特权吗？唯一允许的特权类型是USAGE。
has_largeobject_privilege (
[ user name or oid, ]
largeobject oid,
privilege text )
→ boolean
用户是否具有大对象的权限？
允许的权限类型为SELECT和UPDATE。
has_parameter_privilege (
[ user name or oid, ]
parameter text,
privilege text )
→ boolean
用户是否具有配置参数的权限？
参数名称不区分大小写。
允许的权限类型为SET和ALTER SYSTEM。
has_schema_privilege (
[ user name or oid, ]
schema text or oid,
privilege text )
→ boolean
用户对模式有特权吗？允许的特权类型是CREATE和USAGE。
has_sequence_privilege (
[ user name or oid, ]
sequence text or oid,
privilege text )
→ boolean
用户是否有序列的特权？
允许的权限类型为USAGE、SELECT和UPDATE。
has_server_privilege (
[ user name or oid, ]
server text or oid,
privilege text )
→ boolean
用户是否对外部服务器有特权？唯一允许的特权类型是USAGE。
has_table_privilege (
[ user name or oid, ]
table text or oid,
privilege text )
→ boolean
用户是否拥有表的权限？
允许的权限类型包括SELECT、INSERT、
UPDATE、DELETE、
TRUNCATE、REFERENCES、
TRIGGER和MAINTAIN。
has_tablespace_privilege (
[ user name or oid, ]
tablespace text or oid,
privilege text )
→ boolean
用户对表空间有特权吗？唯一允许的特权类型是CREATE。
has_type_privilege (
[ user name or oid, ]
type text or oid,
privilege text )
→ boolean
用户对数据类型有特权吗？唯一允许的特权类型是 USAGE。
当通过名称而不是OID指定类型时，允许的输入与regtype数据类型相同（参见第 8.19 节）。
pg_has_role (
[ user name or oid, ]
role text or oid,
privilege text )
→ boolean
用户是否对角色具有权限？
允许的权限类型包括
MEMBER、USAGE和SET。
MEMBER表示直接或间接地成为该角色的成员，
而不考虑可能授予的具体权限。
USAGE表示是否可以立即使用该角色的权限，
而无需执行SET ROLE，
SET表示是否可以使用SET ROLE
命令切换到该角色。
WITH ADMIN OPTION或WITH GRANT
OPTION可以添加到这些权限类型中的任何一个，
以测试是否持有ADMIN权限（这六种拼写测试相同的内容）。
此函数不允许将user设置为
public的特殊情况，
因为PUBLIC伪角色永远不能成为真实角色的成员。
row_security_active (
table text or oid )
→ boolean
在当前用户和当前环境的上下文中，指定表的行级安全是活动的吗？
表 9.73 显示了aclitem类型的可用操作符，它是访问权限的目录表示。
有关如何读取访问权限值的信息，请参阅 第 5.8 节。
表 9.73. aclitem 操作符
操作符
描述
示例
aclitem = aclitem
→ boolean
aclitem相等吗？（注意，aclitem类型缺少比较操作符的通常集合；它只有相等。
反而言之，aclitem数组只能进行相等比较。）
'calvin=r*w/hobbes'::aclitem = 'calvin=r*w*/hobbes'::aclitem
→ f
aclitem[] @> aclitem
→ boolean
数组是否包含指定的特权？（如果有一个数组条目与aclitem的被授权人和授予人相匹配，并且至少具有特权的指定集，则此选项为真。）
'{calvin=r*w/hobbes,hobbes=r*w*/postgres}'::aclitem[] @> 'calvin=r*/hobbes'::aclitem
→ t
aclitem[] ~ aclitem
→ boolean
这是@>的已弃用别名。
'{calvin=r*w/hobbes,hobbes=r*w*/postgres}'::aclitem[] ~ 'calvin=r*/hobbes'::aclitem
→ t
表 9.74 显示了一些额外的函数来管理aclitem类型。
表 9.74. aclitem 函数
函数
描述
acldefault (
type "char",
ownerId oid )
→ aclitem[]
构造一个 aclitem 数组，保存属于
OID 为 ownerId 的角色的类型为
type 的对象的默认访问权限。
这表示当对象的 ACL 条目为 null 时将假定的访问权限。
（默认访问权限在 第 5.8 节 中描述。）
type 参数必须是以下之一：
'c' 表示 COLUMN，
'r' 表示 TABLE 和类似表的对象，
's' 表示 SEQUENCE，
'd' 表示 DATABASE，
'f' 表示 FUNCTION 或 PROCEDURE，
'l' 表示 LANGUAGE，
'L' 表示 LARGE OBJECT，
'n' 表示 SCHEMA，
'p' 表示 PARAMETER，
't' 表示 TABLESPACE，
'F' 表示 FOREIGN DATA WRAPPER，
'S' 表示 FOREIGN SERVER，
或
'T' 表示 TYPE 或 DOMAIN。
aclexplode ( aclitem[] )
→ setof record
( grantor oid,
grantee oid,
privilege_type text,
is_grantable boolean )
返回aclitem数组作为一组行。
如果被授予者是伪角色PUBLIC，则在被授予者列中表示为零。
每个授予的权限表示为SELECT、INSERT等
（请参阅表 5.1以获取完整列表）。
请注意，每个权限被分解为单独的一行，因此在权限类型
列中仅出现一个关键字。
makeaclitem (
grantee oid,
grantor oid,
privileges text,
is_grantable boolean )
→ aclitem
构造一个具有给定属性的aclitem。
privileges是一个以逗号分隔的权限名称列表，
例如SELECT、INSERT等，这些权限
都会在结果中设置。（权限字符串的大小写不敏感，并且在权限名称之间
允许有额外的空格，但在权限名称内部不允许。）
9.27.3. 模式可见性查询函数 #
表 9.75展示了决定某个特定对象在当前模式搜索路径中可见的函数。
例如，如果一个表所在的模式在当前搜索路径中，并且在它之前没有出现过相同的名字，这个表就被说是可见的。
这等价于在语句中表可以被用名称引用而不加显式的模式限定。因此，要列出所有可见表的名字：
SELECT relname FROM pg_class WHERE pg_table_is_visible(oid);
对于函数和操作符，如果路径前面没有相同名称和参数数据类型的对象，那么搜索路径中的对象就是可见的。
对于操作符类和操作符族，要考虑名称和关联的索引访问方法。
表 9.75. 模式可见性查询函数
函数
描述
pg_collation_is_visible ( collation oid )
→ boolean
排序规则在搜索路径中可见吗？
pg_conversion_is_visible ( conversion oid )
→ boolean
转换在搜索路径中可见吗？
pg_function_is_visible ( function oid )
→ boolean
函数在搜索路径中可见吗？(这也适用于过程和聚合。)
pg_opclass_is_visible ( opclass oid )
→ boolean
操作符类在搜索路径中可见吗？
pg_operator_is_visible ( operator oid )
→ boolean
操作符在搜索路径中可见吗？
pg_opfamily_is_visible ( opclass oid )
→ boolean
操作符族在搜索路径中可见吗？
pg_statistics_obj_is_visible ( stat oid )
→ boolean
统计对象在搜索路径中可见吗？
pg_table_is_visible ( table oid )
→ boolean
表在搜索路径中可见吗？(这适用于所有类型的关系，包括视图、物化视图、索引、序列和外部表。)
pg_ts_config_is_visible ( config oid )
→ boolean
文本搜索配置在搜索路径中可见吗？
pg_ts_dict_is_visible ( dict oid )
→ boolean
文本搜索字典在搜索路径中可见吗？
pg_ts_parser_is_visible ( parser oid )
→ boolean
文本搜索解析器在搜索路径中可见吗？
pg_ts_template_is_visible ( template oid )
→ boolean
文本搜索模板在搜索路径中可见吗？
pg_type_is_visible ( type oid )
→ boolean
类型（或域）在搜索路径中可见吗？
所有这些函数都要求用对象 OID 来标识将被检查的对象。如果你想用名称来测试一个对象，使用 OID 别名类型（regclass、regtype、regprocedure、regoperator、regconfig或regdictionary）将会很方便。例如：
SELECT pg_type_is_visible('myschema.widget'::regtype);
注意以这种方式测试一个非模式限定的类型名没什么意义 — 如果该名称完全能被识别，它必须是可见的。
9.27.4. 系统目录信息函数 #
表 9.76 列出从系统目录中提取信息的函数。
表 9.76. 系统目录信息函数
函数
描述
format_type ( type oid, typemod integer )
→ text
返回由其类型 OID 及可能的类型修饰符标识的数据类型的 SQL 名称。若无特定修饰符，
则类型修饰符传入 NULL。
pg_basetype ( regtype )
→ regtype
返回由其类型 OID 标识的域的基类型的 OID。如果参数是非域类型的 OID，
则原样返回该参数。如果参数不是有效的类型 OID，则返回 NULL。
如果存在域依赖链，则会递归查找基类型。
假设 CREATE DOMAIN mytext AS text：
pg_basetype('mytext'::regtype)
→ text
pg_char_to_encoding ( encoding name )
→ integer
将提供的编码名称转换为表示在某些系统目录表中使用的内部标识符的整数。
如果提供了未知的编码名称，则返回-1。
pg_encoding_to_char ( encoding integer )
→ name
将在某些系统目录表中用作编码内部标识符的整数转换为可读的字符串。
如果提供了无效的编码编号，则返回空字符串。
pg_get_catalog_foreign_keys ()
→ setof record
( fktable regclass,
fkcols text[],
pktable regclass,
pkcols text[],
is_array boolean,
is_opt boolean )
返回一组记录，描述存在于PostgreSQL系统目录中的外键关系。
fktable 列包含引用目录的名称，fkcols列包含引用列的名称。
类似地，pktable列包含被引用目录的名称，而pkcols列包含被引用列的名称。
如果is_array为真，则最后一个引用列是一个数组，其每个元素都应该与引用目录中的某个条目匹配。
如果is_opt为真，则允许引用列包含零而不是有效引用。
pg_get_constraintdef ( constraint oid [, pretty boolean ] )
→ text
重构约束的创建命令。(这是一个反编译的重构，而不是命令的原始文本。)
pg_get_expr ( expr pg_node_tree, relation oid [, pretty boolean ] )
→ text
反编译存储在系统目录中的表达式的内部形式，例如列的默认值。
如果表达式可能包含变量，则指定它们所指向的关系的OID作为第二个参数；如果没有预期的变量，传递零就可以了。
pg_get_functiondef ( func oid )
→ text
重构函数或过程的创建命令。(这是一个反编译的重构，而不是命令的原始文本。)
结果是一个完整的CREATE OR REPLACE FUNCTION 或 CREATE OR REPLACE PROCEDURE语句。
pg_get_function_arguments ( func oid )
→ text
重新构造函数或过程的参数列表，以其在 CREATE FUNCTION里面需要出现的形式(包括默认值)。
pg_get_function_identity_arguments ( func oid )
→ text
重新构造标识函数或过程所需的参数列表，以其应出现在ALTER FUNCTION等命令中的形式。这个表单省略默认值。
pg_get_function_result ( func oid )
→ text
重构函数的RETURNS子句，以其需要出现在CREATE FUNCTION中的形式。对于过程，返回NULL。
pg_get_indexdef ( index oid [, column integer, pretty boolean ] )
→ text
重构针对索引的创建命令。(这是一个反编译的重构，而不是命令的原始文本。)如果提供了column而且不为零，则只重构该列的定义。
pg_get_keywords ()
→ setof record
( word text,
catcode "char",
barelabel boolean,
catdesc text,
baredesc text )
返回一组描述服务器识别的SQL关键字的记录。word列包含关键字。
catcode列包含一个类别代码:U表示无保留关键字，C表示可以是列名的关键字，T表示可以是类型或函数名的关键字，或者R表示完全保留关键字。
如果关键字可以在SELECT列表中用作“bare”列标签，则barelabel列包含true，否则包含false，如果它只能在AS之后使用。
catdesc列包含可能本地化的字符串，描述关键字的类别。
baredesc列包含可能本地化的字符串，描述关键字的列标签状态。
pg_get_partition_constraintdef ( table oid )
→ text
重构分区约束的定义。(这是反编译的重构，而不是命令的原始文本。)
pg_get_partkeydef ( table oid )
→ text
重构分区表的分区键定义，以其在PARTITION BY子句中的形式呈现，如CREATE TABLE中所示。(这是一个反编译的重构，而不是命令的原始文本。)
pg_get_ruledef ( rule oid [, pretty boolean ] )
→ text
重构针对规则的创建命令。(这是一个反编译的重构，而不是命令的原始文本。)
pg_get_serial_sequence ( table text, column text )
→ text
返回与列相关联的序列名称，如果没有序列与该列相关联则返回NULL。如果列是标识列，则关联序列是在内部为该列创建的序列。
对于使用一种串行类型(serial, smallserial, bigserial)创建的列，它是为该串行列定义创建的序列。
在后一种情况下，可以使用ALTER SEQUENCE OWNED BY修改或删除关联。(这个函数可能应该被称为pg_get_owned_sequence;它的当前名称反映了它在历史上曾与串行类型的列一起使用。)
第一个参数是具有可选模式的表名，第二个参数是列名。由于第一个参数可能包含模式名和表名，因此按照通常的SQL规则解析它，这意味着默认情况下它是小写的。
第二个参数只是一个列名，按照字面来处理，因此保留了它的大小写。结果经过了适当的格式化，可以传递给序列函数(参见第 9.17 节)。
典型的用法是读取序列的当前值以获取标识或串行列，示例如下:
SELECT currval(pg_get_serial_sequence('sometable', 'id'));
pg_get_statisticsobjdef ( statobj oid )
→ text
重构针对扩展统计对象的创建命令。(这是一个反编译的重构，而不是命令的原始文本。)
pg_get_triggerdef ( trigger oid [, pretty boolean ] )
→ text
重构触发器的创建命令。(这是一个反编译的重构，而不是命令的原始文本。)
pg_get_userbyid ( role oid )
→ name
根据OID返回角色的名称。
pg_get_viewdef ( view oid [, pretty boolean ] )
→ text
重构视图或物化视图的底层SELECT命令。(这是一个反编译的重构，而不是命令的原始文本。)
pg_get_viewdef ( view oid, wrap_column integer )
→ text
重构视图或物化视图的底层SELECT命令。(这是一个反编译的重构，而不是命令的原始文本。)在这种形式的函数中，总是启用美观打印，并对长行进行换行，以尽量使它们小于指定的列数。
pg_get_viewdef ( view text [, pretty boolean ] )
→ text
根据视图的文本名称而不是它的OID，重构视图或物化视图的底层SELECT命令。(这是弃用;请使用OID变体。)
pg_index_column_has_property ( index regclass, column integer, property text )
→ boolean
测试一个索引列是否具有命名属性。常用索引列属性列在表 9.77中。(注意，扩展访问方法可以为其索引定义额外的属性名。)如果属性名未知或不适用于特定对象，或者OID或列号不能识别有效的对象，则返回NULL。
pg_index_has_property ( index regclass, property text )
→ boolean
测试一个索引是否具有命名属性。常用索引属性列在表 9.78中。(注意，扩展访问方法可以为其索引定义额外的属性名。)如果属性名未知或不适用于特定对象，或者OID不能识别有效的对象，则返回NULL。
pg_indexam_has_property ( am oid, property text )
→ boolean
测试索引访问方法是否具有命名属性。访问方法属性如表 9.79所示。如果属性名未知或不适用于特定对象，或者OID不能识别有效的对象，则返回NULL。
pg_options_to_table ( options_array text[] )
→ setof record
( option_name text,
option_value text )
返回源自pg_class.reloptions 或 pg_attribute.attoptions的值表示的存储选项集。
pg_settings_get_flags ( guc text )
→ text[]
返回与给定GUC相关联的标志数组，如果不存在则返回NULL。
如果GUC存在但没有要显示的标志，则结果为空数组。
仅公开列出在表 9.80中最有用的标志。
pg_tablespace_databases ( tablespace oid )
→ setof oid
返回具有存储在指定表空间中的对象的数据库的OIDs集。
如果这个函数返回了任何行，那么表空间就不是空的，且不能被删除。
要识别填充表空间的特定对象，需要连接到由pg_tablespace_databases标识的数据库，并查询它们的pg_class目录。
pg_tablespace_location ( tablespace oid )
→ text
返回表空间所在的文件系统路径。
pg_typeof ( "any" )
→ regtype
返回传入值的数据类型的OID。 这对于故障排除或动态构造
SQL查询非常有用。该函数声明为返回regtype，这是一种OID别名类型（参见
第 8.19 节）；这意味着它在比较时与OID相同，
但显示为类型名称。
pg_typeof(33)
→ integer
COLLATION FOR ( "any" )
→ text
返回传入值的排序规则名称。该值会被加引号并在必要时加上模式限定。
如果未能为参数表达式推导出排序规则，则返回NULL。
如果参数不是可排序的数据类型，则会引发错误。
collation for ('foo'::text)
→ "default"
collation for ('foo' COLLATE "de_DE")
→ "de_DE"
to_regclass ( text )
→ regclass
将文本形式的关系名称转换为其OID。类似的结果可以通过将字符串转换为
类型regclass（参见第 8.19 节）来获得；然而，
如果未找到名称，此函数将返回NULL，而不是抛出错误。
to_regcollation ( text )
→ regcollation
将文本的排序规则名称转换为其OID。通过将字符串转换为
regcollation类型（参见第 8.19 节）可以获得类似的结果；
然而，如果未找到名称，此函数将返回NULL而不是抛出错误。
to_regnamespace ( text )
→ regnamespace
将文本模式名称转换为其OID。类似的结果可以通过将字符串转换为
类型regnamespace（参见第 8.19 节）来获得；然而，
如果未找到名称，此函数将返回NULL，而不是抛出错误。
to_regoper ( text )
→ regoper
将文本形式的操作符名称转换为其OID。类似的结果可以通过将字符串
转换为regoper类型来实现（参见
第 8.19 节）；然而，如果名称未找到或存在歧义，
此函数将返回NULL而不是抛出错误。
to_regoperator ( text )
→ regoperator
将带有参数类型的文本操作符名称转换为其OID。类似的结果可以通过将字符串
转换为regoperator类型（参见
第 8.19 节）来获得；然而，如果未找到名称，
此函数将返回NULL而不是抛出错误。
to_regproc ( text )
→ regproc
将文本形式的函数或过程名称转换为其OID。通过将字符串转换为
regproc类型（参见第 8.19 节）可以获得类似的结果；
然而，如果名称未找到或存在歧义，此函数将返回NULL，
而不是抛出错误。
to_regprocedure ( text )
→ regprocedure
将带有参数类型的文本函数或过程名称转换为其OID。类似的结果可以通过将字符串
转换为类型regprocedure（参见
第 8.19 节）来获得；然而，如果未找到名称，此函数将返回
NULL，而不是抛出错误。
to_regrole ( text )
→ regrole
将文本形式的角色名称转换为其OID。类似的结果可以通过将字符串
转换为regrole类型来获得（参见
第 8.19 节）；然而，如果未找到名称，此函数
将返回NULL，而不是抛出错误。
to_regtype ( text )
→ regtype
解析一段文本字符串，从中提取一个潜在的类型名称，
并将该名称转换为类型OID。字符串中的语法错误将导致错误；
但如果字符串是语法上有效的类型名称，只是未在目录中找到，
结果将是NULL。通过将字符串强制转换为
regtype类型（参见第 8.19 节）
也会得到类似结果，只是后者会因未找到名称而抛出错误。
to_regtypemod ( text )
→ integer
解析一段文本字符串，从中提取潜在的类型名称，并翻译其类型修饰符（如果有）。
字符串中的语法错误将导致错误；但如果字符串是语法上有效的类型名称，
但未在目录中找到，则结果为NULL。如果没有类型修饰符，
结果为-1。
to_regtypemod可以与
to_regtype结合使用，生成适合
format_type的输入，从而使表示类型名称的字符串
得以规范化。
format_type(to_regtype('varchar(32)'), to_regtypemod('varchar(32)'))
→ character varying(32)
大多数重构(反编译)数据库对象的函数都有一个可选的 pretty标志，如果为true，结果将被“pretty-printed”。
美观打印会抑制不必要的圆括号，并为易读性增加空格。
美观打印的格式可读性更好，但是默认格式更有可能被PostgreSQL的未来版本以同样的方式解释；
因此，避免为转储目的使用美观打印的输出。为pretty参数传递false会产生与省略参数相同的结果。
表 9.77. 索引列属性名称描述asc在向前扫描时列是按照升序排列吗？
desc在向前扫描时列是按照降序排列吗？
nulls_first在向前扫描时列排序会把空值排在前面吗？
nulls_last在向前扫描时列排序会把空值排在最后吗？
orderable列具有已定义的排序顺序吗？
distance_orderable列能否通过一个“distance”操作符，例如ORDER BY col <-> constant，有序地扫描？
returnable列值是否可以通过一次只用索引的扫描返回？
search_array列是否天然支持col = ANY(array)搜索？
search_nulls列是否支持IS NULL和IS NOT NULL搜索？
表 9.78. 索引属性名称描述clusterable索引是否可以用于CLUSTER命令？
index_scan索引是否支持普通（非位图）扫描？
bitmap_scan索引是否支持位图扫描？
backward_scan在扫描中扫描方向能否被更改（为了支持游标上无需物化的FETCH BACKWARD）？
表 9.79. 索引访问方法属性名称描述can_order访问方法是否支持ASC、DESC以及CREATE INDEX中的相关关键词？
can_unique访问方法是否支持唯一索引？
can_multi_col访问方法是否支持多列索引？
can_exclude访问方法是否支持排除约束？
can_include访问方法是否支持CREATE INDEX的INCLUDE子句？
表 9.80. GUC标志标志描述EXPLAIN带有此标志的参数包含在EXPLAIN (SETTINGS)命令中。NO_SHOW_ALL带有此标志的参数将被排除在SHOW ALL命令之外。NO_RESET带有此标志的参数不支持RESET命令。NO_RESET_ALL带有此标志的参数将被排除在RESET ALL命令之外。NOT_IN_SAMPLE带有此标志的参数默认情况下不包含在postgresql.conf中。
RUNTIME_COMPUTED具有此标志的参数是在运行时计算的参数。9.27.5. 对象信息和定位函数 #
表 9.81列出了与数据库对象
标识和定位有关的函数。
表 9.81. 对象信息和定位函数
函数
描述
pg_get_acl ( classid oid, objid oid, objsubid integer )
→ aclitem[]
返回由目录 OID、对象 OID 和子对象 ID 指定的数据库对象的 ACL。
对于未定义的对象，此函数返回 NULL 值。
pg_describe_object ( classid oid, objid oid, objsubid integer )
→ text
返回由目录OID、对象OID和子对象ID（例如表中的列号）标识的数据库对象的文本描述；当引用整个对象时，子对象ID为0。
这个描述是人类可读的，并且可以根据服务器配置进行翻译。这对于决定pg_depend目录中引用的对象的标识特别有用。
此函数对于未定义的对象返回NULL值。
pg_identify_object ( classid oid, objid oid, objsubid integer )
→ record
( type text,
schema text,
name text,
identity text )
返回包含足够信息的行以唯一标识由目录OID、对象OID和子对象ID指定的数据库对象。
这些信息是为了机器可读的，永远不会被翻译。
type标识数据库对象的类型；
schema是对象所属的模式名，NULL表示不属于模式的对象类型；
name是对象的名称，如果有必要，用引号括起来，如果名称（随着模式名称，如果相关）足以唯一地标识对象，否则为NULL；
identity是完整的对象标识，其精确格式依赖于对象类型，格式中的每个名称都是模式限定的，并在必要时用引号括起来。
未定义的对象由NULL值标识。
pg_identify_object_as_address ( classid oid, objid oid, objsubid integer )
→ record
( type text,
object_names text[],
object_args text[] )
返回包含足够信息的行以唯一标识由目录OID、对象OID和子对象ID指定的数据库对象。
返回的信息独立于当前服务器，也就是说，它可以用于标识另一个服务器中具有相同名称的对象。
type标识数据库对象的类型；object_names和object_args是文本数组，它们一起构成对对象的引用。
这三个值可以传递给pg_get_object_address以获得对象的内部地址。
pg_get_object_address ( type text, object_names text[], object_args text[] )
→ record
( classid oid,
objid oid,
objsubid integer )
返回包含足够信息的行以唯一标识由类型代码、对象名称和参数数组指定的数据库对象。
返回的值将在系统目录中使用，例如pg_depend；它们可以传递给其他系统函数，比如 pg_describe_object或pg_identify_object。
classid是包含该对象的系统目录的OID；objid是对象本身的OID，objsubid是子对象的ID，如果没有则为零。
这个函数是pg_identify_object_as_address的反向函数。
未定义的对象以NULL值标识。
pg_get_acl 对于检索和检查与数据库对象相关的权限非常有用，
而无需查看特定的目录。例如，要检索当前数据库中对象的所有授权权限：
postgres=# SELECT
(pg_identify_object(s.classid,s.objid,s.objsubid)).*,
pg_catalog.pg_get_acl(s.classid,s.objid,s.objsubid) AS acl
FROM pg_catalog.pg_shdepend AS s
JOIN pg_catalog.pg_database AS d
ON d.datname = current_database() AND
d.oid = s.dbid
JOIN pg_catalog.pg_authid AS a
ON a.oid = s.refobjid AND
s.refclassid = 'pg_authid'::regclass
WHERE s.deptype = 'a';
-[ RECORD 1 ]-----------------------------------------
type     | table
schema   | public
name     | testtab
identity | public.testtab
acl      | {postgres=arwdDxtm/postgres,foo=r/postgres}
9.27.6. 注释信息函数 #
表 9.82中展示的函数提取之前通过COMMENT命令存储的注释。如果对指定参数找不到注释，则返回空值。
表 9.82. 注释信息函数
函数
描述
col_description ( table oid, column integer )
→ text
返回表列的注释，该注释由该表的OID和列号指定。
(obj_description不能用于表列，因为列没有自己的OID。)
obj_description ( object oid, catalog name )
→ text
返回OID指定的数据库对象的注释和包含该对象的系统目录的名称。
例如，obj_description(123456, 'pg_class')将检索OID为123456的表的注释。
obj_description ( object oid )
→ text
返回仅由其OID指定的数据库对象的注释。
这已被弃用，因为无法保证OIDs在不同的系统目录中是唯一的；因此，可能会返回错误的注释。
shobj_description ( object oid, catalog name )
→ text
返回共享数据库对象的注释，该对象由其OID和包含的系统目录的名称指定。
这与obj_description类似，只是它用于检索共享对象（也就是数据库、角色和表空间）上的注释。
有些系统目录对每个集群中的所有数据库都是全局的，其中对象的描述也全局存储。
9.27.7. 数据有效性检查函数 #
在表 9.83中显示的函数对于检查
提议输入数据的有效性可能很有帮助。
表 9.83. 数据有效性检查函数
函数
描述
示例
pg_input_is_valid (
string text,
type text
)
→ boolean
测试给定的字符串是否是指定数据类型的有效输入，
返回true或false。
只有当数据类型的输入函数已更新为将无效输入报告为
“软”错误时，此函数才能按预期工作。
否则，无效输入将中止事务，就像字符串直接被转换为该类型一样。
pg_input_is_valid('42', 'integer')
→ t
pg_input_is_valid('42000000000', 'integer')
→ f
pg_input_is_valid('1234.567', 'numeric(7,4)')
→ f
pg_input_error_info (
string text,
type text
)
→ record
( message text,
detail text,
hint text,
sql_error_code text )
测试给定的string是否为指定数据类型的有效输入；如果不是，
返回本应抛出的错误详情。如果输入有效，结果为NULL。输入参数与
pg_input_is_valid相同。
只有当数据类型的输入函数已更新为将无效输入报告为
“软”错误时，此函数才能按预期工作。否则，无效输入将中止
事务，就像字符串被直接转换为该类型一样。
SELECT * FROM pg_input_error_info('42000000000', 'integer')
→
message                        | detail | hint | sql_error_code
------------------------------------------------------+--------+------+----------------
value "42000000000" is out of range for type integer |        |      | 22003
9.27.8. 事务 ID 和快照信息函数 #
表 9.84
中展示的函数以一种可导出的形式提供了服务器事务信息。 这些函数的主要
用途是判断在两个快照之间哪些事务被提交。
表 9.84. 事务 ID 和快照信息函数
函数
描述
age  ( xid )
→ integer
返回提供的事务 ID 与当前事务计数器之间的事务数量。
mxid_age  ( xid )
→ integer
返回提供的多事务 ID 与当前多事务计数器之间的多事务 ID 数量。
pg_current_xact_id ()
→ xid8
返回当前事务的ID。如果当前事务尚未拥有ID（因为它尚未执行任何数据库更新），
则会分配一个新的ID；有关详细信息，请参阅第 67.1 节。
如果在子事务中执行，此函数将返回顶层事务的ID；有关详细信息，请参阅
第 67.3 节。
pg_current_xact_id_if_assigned ()
→ xid8
返回当前事务的ID，或者NULL（如果尚未分配ID）。
（如果事务可能是只读的，最好使用此变体，以避免不必要的XID消耗。）
如果在子事务中执行，这将返回顶层事务ID。
pg_xact_status ( xid8 )
→ text
报告最近的事务的提交状态。如果事务为最近的，系统会保留事务的提交状态，则结果是 in progress、committed或aborted。
如果该事务的时间足够久，并且系统中没有对该事务的引用，而且提交状态信息已经被丢弃，则结果为NULL。
应用可以使用此函数，例如，确定在进行COMMIT时，应用程序和数据库服务器断开连接后，它们的事务是已提交还是中止。
注意，准备好的事务报告为in progress的事务;如果应用需要确定一个事务ID是否属于一个准备好的事务，则必须检查pg_prepared_xacts。
pg_current_snapshot ()
→ pg_snapshot
返回当前的快照，一种数据结构，
显示当前正在进行的事务ID。
快照中仅包含顶层事务ID；子事务ID不会显示；
详情请参见第 67.3 节。
pg_snapshot_xip ( pg_snapshot )
→ setof xid8
返回快照中包含的正在进行的事务ID集。
pg_snapshot_xmax ( pg_snapshot )
→ xid8
返回快照的xmax。
pg_snapshot_xmin ( pg_snapshot )
→ xid8
返回快照的xmin。
pg_visible_in_snapshot ( xid8, pg_snapshot )
→ boolean
判断给定的事务ID是否可见，依据此快照（即，该事务是否在快照
生成之前完成）。请注意，此函数无法为子事务ID（subxid）提供正确的答案；有关详细
信息，请参阅第 67.3 节。
pg_get_multixact_members ( multixid xid )
→ setof record
( xid xid,
mode text )
返回指定 multixact ID 的每个成员的事务 ID 和锁模式。
锁模式 forupd、fornokeyupd、sh 和
keysh 分别对应于行级锁
FOR UPDATE、FOR NO KEY UPDATE、
FOR SHARE 和 FOR KEY SHARE，如
第 13.3.2 节 中所述。还有两种模式特定于 multixacts：
nokeyupd，用于不修改键列的更新，以及
upd，用于修改键列的更新或删除。
内部事务 ID 类型 xid 为 32 位宽，并在每 40 亿个事务后回绕。
然而，表 9.84 中显示的函数，除了
age、mxid_age 和
pg_get_multixact_members，使用的是
64 位类型 xid8，在安装期间不会回绕，并且可以在需要时通过类型转换
转换为 xid；有关详细信息，请参见 第 67.1 节。
数据类型 pg_snapshot 存储有关特定时刻事务 ID 可见性的信息。
其组成部分在 表 9.85 中描述。
pg_snapshot 的文本表示为
xmin:xmax:xip_list。
例如 10:20:10,14,15 表示
xmin=10, xmax=20, xip_list=10, 14, 15。
表 9.85. 快照组件名称描述xmin
仍然处于活动状态的最低事务 ID。所有小于 xmin 的事务 ID 要么提交且可见，要么回滚并死亡。
xmax
比最高完成的事务 ID 还高出一个值。所有大于或等于 xmax 的事务 ID 到快照时还没有完成，因此不可见。
xip_list
快照时正在进行的事务。一个事务 ID 满足 xmin <=
X < xmax 且不在此列表中，
则该事务在快照时已完成，因此根据其提交状态，要么是可见的，
要么是无效的。此列表不包括子事务（subxids）的事务 ID。
在 PostgreSQL 13 以前的版本中，没有 xid8 类型，因此提供了这些函数的变体，使用 bigint 表示 64 位 XID，并相应地提供不同的快照数据类型 txid_snapshot。
这些旧的函数在它们的名字中有 txid。
它们仍然支持向后兼容性，但可能会从未来的版本中删除。参见 表 9.86。
表 9.86. 已弃用的事务ID和快照信息函数
函数
描述
txid_current ()
→ bigint
参见 pg_current_xact_id().
txid_current_if_assigned ()
→ bigint
参见 pg_current_xact_id_if_assigned().
txid_current_snapshot ()
→ txid_snapshot
参见 pg_current_snapshot().
txid_snapshot_xip ( txid_snapshot )
→ setof bigint
参见 pg_snapshot_xip().
txid_snapshot_xmax ( txid_snapshot )
→ bigint
参见 pg_snapshot_xmax().
txid_snapshot_xmin ( txid_snapshot )
→ bigint
参见 pg_snapshot_xmin().
txid_visible_in_snapshot ( bigint, txid_snapshot )
→ boolean
参见 pg_visible_in_snapshot().
txid_status ( bigint )
→ text
参见 pg_xact_status().
9.27.9. 已提交事务信息函数 #
表 9.87
中显示的函数提供了有关过去事务提交时间的信息。它们仅在启用
track_commit_timestamp配置选项时才提供有用的数据，
并且仅适用于在启用该选项后提交的事务。提交时间戳信息会在清理过程中
定期移除。
表 9.87. 已提交事务信息函数
函数
描述
pg_xact_commit_timestamp ( xid )
→ timestamp with time zone
返回事务的提交时间戳。
pg_xact_commit_timestamp_origin ( xid )
→ record
( timestamp timestamp with time zone,
roident oid)
返回事务的提交时间戳和复制源。
pg_last_committed_xact ()
→ record
( xid xid,
timestamp timestamp with time zone,
roident oid )
返回最近提交的事务的事务ID、提交时间戳和复制源。
9.27.10. 控制数据函数 #
表 9.88
中所展示的函数能打印initdb期间初始化的信息，例如目录版本。
它们也能显示有关预写式日志和检查点处理的信息。这些信息是集簇范围内的，
不与任何特定的一个数据库相关。这些函数提供大致相同的信息，
对于同一种来源，就像pg_controldata应用。
表 9.88. 控制数据函数
函数
描述
pg_control_checkpoint ()
→ record
返回有关当前检查点状态的信息，如 表 9.89所展示。
pg_control_system ()
→ record
返回有关当前控制文件状态的信息，如 表 9.90所展示。
pg_control_init ()
→ record
返回有关集群初始化状态的信息，如 表 9.91所展示。
pg_control_recovery ()
→ record
返回有关恢复状态的信息，如 表 9.92所展示。
表 9.89. pg_control_checkpoint 输出列列名称数据类型checkpoint_lsnpg_lsnredo_lsnpg_lsnredo_wal_filetexttimeline_idintegerprev_timeline_idintegerfull_page_writesbooleannext_xidtextnext_oidoidnext_multixact_idxidnext_multi_offsetxidoldest_xidxidoldest_xid_dbidoidoldest_active_xidxidoldest_multi_xidxidoldest_multi_dbidoidoldest_commit_ts_xidxidnewest_commit_ts_xidxidcheckpoint_time时间戳带时区表 9.90. pg_control_system 输出列列名称数据类型pg_control_versionintegercatalog_version_nointegersystem_identifierbigintpg_control_last_modifiedtimestamp with time zone表 9.91. pg_control_init 输出列列名称数据类型max_data_alignmentintegerdatabase_block_sizeintegerblocks_per_segmentintegerwal_block_sizeintegerbytes_per_wal_segmentintegermax_identifier_lengthintegermax_index_columnsintegermax_toast_chunk_sizeintegerlarge_object_chunk_sizeintegerfloat8_pass_by_valuebooleandata_page_checksum_versionintegerdefault_char_signednessboolean表 9.92. pg_control_recovery 输出列列名称数据类型min_recovery_end_lsnpg_lsnmin_recovery_end_timelineintegerbackup_start_lsnpg_lsnbackup_end_lsnpg_lsnend_of_backup_record_requiredboolean9.27.11. 版本信息函数 #
显示在表 9.93中的函数打印版本信息。
表 9.93. 版本信息函数
函数
描述
version ()
→ text
返回描述PostgreSQL服务器的版本的字符串。
你还可以从 server_version中获得此信息，或者对于机器可读的版本，使用server_version_num。
软件开发人员应该使用server_version_num(从8.2起可用)或PQserverVersion，而不是解析文本版本。
unicode_version ()
→ text
返回一个字符串，表示PostgreSQL使用的Unicode版本。
icu_unicode_version ()
→ text
返回一个表示 ICU 使用的 Unicode 版本的字符串，如果服务器是使用 ICU 支持构建的；
否则返回 NULL 9.27.12. WAL 汇总信息函数 #
The functions shown in 表 9.94
print information about the status of WAL summarization.
See summarize_wal.
表 9.94. WAL 汇总信息函数
函数
描述
pg_available_wal_summaries ()
→ setof record
( tli bigint,
start_lsn pg_lsn,
end_lsn pg_lsn )
返回数据目录中存在的WAL摘要文件的信息，位于pg_wal/summaries目录下。
每个WAL摘要文件对应返回一行。每个文件总结了指定TLI范围内指定LSN范围的WAL。
该函数可能有助于确定服务器上是否存在足够的WAL摘要，以基于某个已知起始LSN的
先前备份执行增量备份。
pg_wal_summary_contents ( tli bigint, start_lsn pg_lsn, end_lsn pg_lsn )
→ setof record
( relfilenode oid,
reltablespace oid,
reldatabase oid,
relforknumber smallint,
relblocknumber bigint,
is_limit_block boolean )
返回有关单个 WAL 汇总文件内容的信息，该文件由 TLI 以及起始和结束 LSN
标识。每一行中 is_limit_block 为 false 表示由剩余输出列
标识的块在此文件汇总的记录范围内至少被一个 WAL 记录修改。每一行中
is_limit_block 为 true 表示 (a) 关系分叉在相关 WAL 记录
范围内被截断到 relblocknumber 指定的长度，或 (b) 关系分叉
在相关 WAL 记录范围内被创建或删除；在这种情况下，relblocknumber
将为零。
pg_get_wal_summarizer_state ()
→ record
( summarized_tli bigint,
summarized_lsn pg_lsn,
pending_lsn pg_lsn,
summarizer_pid int )
返回有关 WAL 汇总器进度的信息。如果自实例启动以来 WAL 汇总器
从未运行过，则 summarized_tli 和
summarized_lsn 分别为 0 和
0/0；否则，它们将是写入磁盘的最后一个 WAL
汇总文件的 TLI 和结束 LSN。如果 WAL 汇总器当前正在运行，
pending_lsn 将是其已消费的最后一条记录的结束
LSN，该值必须始终大于或等于 summarized_lsn；
如果 WAL 汇总器未运行，则该值将等于
summarized_lsn。summarizer_pid 是
WAL 汇总器进程的 PID（如果正在运行），否则为 NULL。
作为特殊例外，如果在 wal_level=minimal 生成的
WAL 上运行，WAL 汇总器将拒绝生成 WAL 汇总文件，因为此类汇总
用作增量备份的基础是不安全的。在这种情况下，上述字段将继续
递增，仿佛正在生成汇总，但不会写入任何内容到磁盘。一旦汇总器
达到 wal_level 设置为 replica
或更高级别时生成的 WAL，它将恢复写入汇总到磁盘。
上一页 上一级 下一页9.26. 集合返回函数 起始页 9.28. 系统管理函数
