# F.28. pg_logicalinspect — 逻辑解码组件检查

F.28. pg_logicalinspect — 逻辑解码组件检查
版本：
纠错本页面
搜索
目录导航
❮
❯
F.28. pg_logicalinspect — 逻辑解码组件检查 #F.28.1. 函数F.28.2. 作者
pg_logicalinspect 模块提供 SQL 函数，
允许您检查逻辑解码组件的内容。它
允许检查正在运行的 PostgreSQL 数据库集群的
序列化逻辑快照，这对于调试或教育目的非常有用。
默认情况下，这些函数的使用仅限于超级用户和pg_read_server_files角色的成员。
超级用户可以使用GRANT授予其他用户访问权限。
F.28.1. 函数 #
pg_get_logical_snapshot_meta(filename text) returns record
#
获取位于服务器 pg_logical/snapshots 目录中的
快照文件的逻辑快照元数据。
filename 参数表示快照
文件名。
例如：
postgres=# SELECT * FROM pg_ls_logicalsnapdir();
-[ RECORD 1 ]+-----------------------
name         | 0-40796E18.snap
size         | 152
modification | 2024-08-14 16:36:32+00
postgres=# SELECT * FROM pg_get_logical_snapshot_meta('0-40796E18.snap');
-[ RECORD 1 ]--------
magic    | 1369563137
checksum | 1028045905
version  | 6
postgres=# SELECT ss.name, meta.* FROM pg_ls_logicalsnapdir() AS ss,
pg_get_logical_snapshot_meta(ss.name) AS meta;
-[ RECORD 1 ]-------------
name     | 0-40796E18.snap
magic    | 1369563137
checksum | 1028045905
version  | 6
如果 filename 不匹配快照文件，则
函数会引发错误。
pg_get_logical_snapshot_info(filename text) returns record
#
获取位于服务器 pg_logical/snapshots 目录中的
快照文件的逻辑快照信息。
filename 参数表示快照
文件名。
例如：
postgres=# SELECT * FROM pg_ls_logicalsnapdir();
-[ RECORD 1 ]+-----------------------
name         | 0-40796E18.snap
size         | 152
modification | 2024-08-14 16:36:32+00
postgres=# SELECT * FROM pg_get_logical_snapshot_info('0-40796E18.snap');
-[ RECORD 1 ]------------+-----------
state                    | consistent
xmin                     | 751
xmax                     | 751
start_decoding_at        | 0/40796AF8
two_phase_at             | 0/40796AF8
initial_xmin_horizon     | 0
building_full_snapshot   | f
in_slot_creation         | f
last_serialized_snapshot | 0/0
next_phase_at            | 0
committed_count          | 0
committed_xip            |
catchange_count          | 2
catchange_xip            | {751,752}
postgres=# SELECT ss.name, info.* FROM pg_ls_logicalsnapdir() AS ss,
pg_get_logical_snapshot_info(ss.name) AS info;
-[ RECORD 1 ]------------+----------------
name                     | 0-40796E18.snap
state                    | consistent
xmin                     | 751
xmax                     | 751
start_decoding_at        | 0/40796AF8
two_phase_at             | 0/40796AF8
initial_xmin_horizon     | 0
building_full_snapshot   | f
in_slot_creation         | f
last_serialized_snapshot | 0/0
next_phase_at            | 0
committed_count          | 0
committed_xip            |
catchange_count          | 2
catchange_xip            | {751,752}
如果 filename 不匹配快照文件，函数
会引发错误。
F.28.2. 作者 #
Bertrand Drouvot <bertranddrouvot.pg@gmail.com>
上一页 上一级 下一页F.27. pg_freespacemap — 检查空闲空间映射 起始页 F.29. pg_overexplain — 允许 EXPLAIN 输出更多细节
