# F.37. pg_walinspect — 低级 WAL 检查

F.37. pg_walinspect — 低级 WAL 检查
版本：
纠错本页面
搜索
目录导航
❮
❯
F.37. pg_walinspect — 低级 WAL 检查 #F.37.1. 通用函数F.37.2. Author
pg_walinspect模块提供了SQL函数，允许您检查运行中的PostgreSQL数据库集群的预写式日志的内容，这对于调试、分析、报告或教育目的非常有用。它类似于pg_waldump，但是通过SQL而不是单独的实用程序访问。
本模块的所有功能都将使用服务器当前的时间线 ID 提供 WAL 信息。
注意
pg_walinspect 函数通常使用一个 LSN 参数调用，该参数指定感兴趣的已知
WAL 记录开始的位置。然而，一些函数，例如
pg_logical_emit_message，
返回刚插入的记录之后的 LSN。
提示
所有pg_walinspect函数显示在特定 LSN 范围内的记录信息时，
对于接受end_lsn参数（即使该参数超出了服务器当前
的 LSN）是宽松的。使用一个end_lsn
“来自未来”的值不会引发错误。
提供值FFFFFFFF/FFFFFFFF（最大有效
pg_lsn值）作为end_lsn
参数可能会很方便。这相当于提供一个与服务器当前
LSN 匹配的end_lsn参数。
默认情况下，这些函数的使用仅限于超级用户和pg_read_server_files角色的成员。
超级用户可以使用GRANT授予其他用户访问权限。
F.37.1. 通用函数 #
pg_get_wal_record_info(in_lsn pg_lsn) returns record
#
获取位于或在in_lsn参数之后的WAL记录信息。例如：
postgres=# SELECT * FROM pg_get_wal_record_info('0/E419E28');
-[ RECORD 1 ]----+-------------------------------------------------
start_lsn        | 0/E419E28
end_lsn          | 0/E419E68
prev_lsn         | 0/E419D78
xid              | 0
resource_manager | Heap2
record_type      | VACUUM
record_length    | 58
main_data_length | 2
fpi_length       | 0
description      | nunused: 5, unused: [1, 2, 3, 4, 5]
block_ref        | blkref #0: rel 1663/16385/1249 fork main blk 364
如果in_lsn不在WAL记录的开头，则会显示有关下一个有效
WAL记录的信息。如果没有下一个有效的WAL记录，该函数将引发错误。
pg_get_wal_records_info(start_lsn pg_lsn, end_lsn pg_lsn)
returns setof record
#
获取从start_lsn到end_lsn
之间所有有效WAL记录的信息。每条WAL记录返回一行。例如：
postgres=# SELECT * FROM pg_get_wal_records_info('0/1E913618', '0/1E913740') LIMIT 1;
-[ RECORD 1 ]----+--------------------------------------------------------------
start_lsn        | 0/1E913618
end_lsn          | 0/1E913650
prev_lsn         | 0/1E9135A0
xid              | 0
resource_manager | Standby
record_type      | RUNNING_XACTS
record_length    | 50
main_data_length | 24
fpi_length       | 0
description      | nextXid 33775 latestCompletedXid 33774 oldestRunningXid 33775
block_ref        |
如果start_lsn不可用，该函数会引发错误。
pg_get_wal_block_info(start_lsn pg_lsn, end_lsn pg_lsn, show_data boolean DEFAULT true) returns setof record
#
获取从所有有效的WAL记录中每个块引用的信息，这些记录位于
start_lsn和end_lsn
之间，并包含一个或多个块引用。每个WAL记录的每个块引用返回一行。
例如：
postgres=# SELECT * FROM pg_get_wal_block_info('0/1230278', '0/12302B8');
-[ RECORD 1 ]-----+-----------------------------------
start_lsn         | 0/1230278
end_lsn           | 0/12302B8
prev_lsn          | 0/122FD40
block_id          | 0
reltablespace     | 1663
reldatabase       | 1
relfilenode       | 2658
relforknumber     | 0
relblocknumber    | 11
xid               | 341
resource_manager  | Btree
record_type       | INSERT_LEAF
record_length     | 64
main_data_length  | 2
block_data_length | 16
block_fpi_length  | 0
block_fpi_info    |
description       | off: 46
block_data        | \x00002a00070010402630000070696400
block_fpi_data    |
此示例涉及一个仅包含一个块引用的WAL记录，但许多WAL记录包含多个块
引用。由pg_get_wal_block_info输出的行保证具有
唯一的start_lsn和
block_id值的组合。
这里显示的大部分信息与pg_get_wal_records_info在给定相同参数时
的输出相匹配。然而，pg_get_wal_block_info将每个WAL记录中的信息
以展开的形式解嵌，通过为每个块引用输出一行来实现，因此某些细节是在块引用级别
而不是整个记录级别进行跟踪的。这种结构对于跟踪单个块随时间变化的查询非常有用。
请注意，没有块引用的记录（例如，COMMIT WAL记录）将不会返回
任何行，因此pg_get_wal_block_info实际上可能返回的行数
少于pg_get_wal_records_info。
reltablespace、
reldatabase和
relfilenode参数引用
pg_tablespace.oid、
pg_database.oid和
pg_class.relfilenode，
分别对应。relforknumber
字段是块引用中关系的分叉编号；详情请参见common/relpath.h。
提示
pg_filenode_relation 函数（参见
表 9.103）可以帮助您确定
在原始执行期间修改了哪个关系。
客户端可以避免物化块数据的开销。这可能会显著加快函数执行速度。
当show_data设置为false时，
block_data和block_fpi_data
的值会被省略（也就是说，block_data和
block_fpi_data的OUT参数在返回的
所有行中都是NULL）。显然，这种优化仅适用于块数据
不是真正需要的查询。
如果start_lsn不可用，该函数会引发错误。
pg_get_wal_stats(start_lsn pg_lsn, end_lsn pg_lsn, per_record boolean DEFAULT false)
returns setof record
#
获取从start_lsn到
end_lsn之间所有有效WAL记录的统计信息。
默认情况下，它会按每个resource_manager
类型返回一行。当per_record设置为
true时，它会按每个
record_type返回一行。
例如：
postgres=# SELECT * FROM pg_get_wal_stats('0/1E847D00', '0/1E84F500')
WHERE count > 0 AND
"resource_manager/record_type" = 'Transaction'
LIMIT 1;
-[ RECORD 1 ]----------------+-------------------
resource_manager/record_type | Transaction
count                        | 2
count_percentage             | 8
record_size                  | 875
record_size_percentage       | 41.23468426013195
fpi_size                     | 0
fpi_size_percentage          | 0
combined_size                | 875
combined_size_percentage     | 2.8634072910530795
如果start_lsn不可用，该函数会引发错误。
F.37.2. Author #
Bharath Rupireddy <bharath.rupireddyforpostgres@gmail.com>
上一页 上一级 下一页F.36. pg_visibility — 可见性映射信息和工具 起始页 F.38. postgres_fdw —
访问存储在外部PostgreSQL
服务器中的数据
