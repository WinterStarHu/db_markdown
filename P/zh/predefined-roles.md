# 21.5. 预定义角色

21.5. 预定义角色
版本：
纠错本页面
搜索
目录导航
❮
❯
21.5. 预定义角色 #
PostgreSQL 提供了一组预定义角色，
这些角色提供对某些常用特权功能和信息的访问。管理员（包括
拥有 CREATEROLE 权限的角色）可以将这些角色
GRANT 给用户和/或他们环境中的其他角色，
从而为这些用户提供对指定功能和信息的访问。例如：
GRANT pg_signal_backend TO admin_user;
警告
授予这些角色时应谨慎，以确保它们仅在需要的地方使用，并且
理解这些角色授予对特权信息的访问。
预定义角色如下所述。
请注意，未来每个角色的具体权限可能会随着附加功能的添加而变化。
管理员应监控发布说明以获取更改信息。
pg_checkpoint #
pg_checkpoint 允许执行
CHECKPOINT 命令。
pg_create_subscription #
pg_create_subscription 允许具有
CREATE 权限的用户在数据库中发出
CREATE SUBSCRIPTION。
pg_database_owner #
pg_database_owner 始终只有一个隐式成员：
当前数据库的拥有者。它不能被授予任何角色的成员资格，
也没有角色可以被授予成员资格到 pg_database_owner。
然而，像其他任何角色一样，它可以拥有对象并接收访问权限的授予。
因此，一旦 pg_database_owner 在模板数据库中拥有权限，
从该模板实例化的每个数据库的拥有者将拥有这些权限。
最初，该角色拥有 public 模式，因此每个数据库的拥有者
管理该模式的本地使用。
pg_maintain #
pg_maintain 允许执行
VACUUM,
ANALYZE,
CLUSTER,
REFRESH MATERIALIZED VIEW,
REINDEX,
和 LOCK TABLE 在所有
关系上，就像拥有这些对象的 MAINTAIN 权限一样。
pg_monitorpg_read_all_settingspg_read_all_statspg_stat_scan_tables #
这些角色旨在允许管理员轻松配置角色，以便监控数据库服务器。
它们授予一组常见权限，允许角色读取各种有用的配置设置、统计信息
和其他通常限制给超级用户的系统信息。
pg_monitor 允许读取/执行各种监控视图和函数。
该角色是 pg_read_all_settings、
pg_read_all_stats 和
pg_stat_scan_tables 的成员。
pg_read_all_settings 允许读取所有配置变量，
即使那些通常仅对超级用户可见的变量。
pg_read_all_stats 允许读取所有 pg_stat_* 视图
并使用各种与统计相关的扩展，即使那些通常仅对超级用户可见的。
pg_stat_scan_tables 允许执行监控
函数，这些函数可能会对表获取 ACCESS SHARE 锁，
可能会持续很长时间（例如，pgrowlocks(text)
在 pgrowlocks 扩展中）。
pg_read_all_datapg_write_all_data #
pg_read_all_data 允许读取所有数据（表、
视图、序列），就像对这些对象拥有 SELECT
权限以及对所有模式拥有 USAGE 权限一样。此
角色不会绕过行级安全（RLS）策略。如果正在使用 RLS，管理员
可能希望在授予此角色的角色上设置 BYPASSRLS。
pg_write_all_data 允许写入所有数据（表、
视图、序列），就像对这些对象拥有 INSERT、
UPDATE 和 DELETE 权限一样，
并且对所有模式拥有 USAGE 权限。此角色不会
绕过行级安全（RLS）策略。如果正在使用 RLS，管理员可能希望
在授予此角色的角色上设置 BYPASSRLS。
pg_read_server_filespg_write_server_filespg_execute_server_program #
这些角色旨在允许管理员拥有可信但非超级用户的角色，
这些角色能够以数据库运行的用户身份访问文件并在数据库
服务器上运行程序。它们在直接访问文件时绕过所有数据库
级权限检查，并且可能被用来获得超级用户级别的访问权限。
因此，在将这些角色授予用户时应格外小心。
pg_read_server_files 允许使用
COPY 和其他文件访问函数从数据库可以
访问的服务器上的任何位置读取文件。
pg_write_server_files 允许使用
COPY 和其他文件访问函数向数据库可以
访问的服务器上的任何位置写入文件。
pg_execute_server_program 允许以数据库
运行的用户身份在数据库服务器上执行程序，使用
COPY 和其他允许执行服务器端程序的
函数。
pg_signal_autovacuum_worker #
pg_signal_autovacuum_worker 允许向
autovacuum 工作进程发送信号，以取消当前表的清理或
终止其会话。请参见 第 9.28.2 节。
pg_signal_backend #
pg_signal_backend 允许向另一个后端发送
信号，以取消查询或终止其会话。请注意，此角色不允许
向超级用户拥有的后端发送信号。请参见
第 9.28.2 节。
pg_use_reserved_connections #
pg_use_reserved_connections 允许使用通过
reserved_connections 保留的连接槽。
上一页 上一级 下一页21.4. 删除角色 起始页 21.6. 函数安全性
