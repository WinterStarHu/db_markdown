# 29.7. 冲突

29.7. 冲突
版本：
纠错本页面
搜索
目录导航
❮
❯
29.7. 冲突 #
逻辑复制的行为类似于正常的 DML 操作，因为
即使数据在订阅节点上被本地更改，数据也会被更新。
如果传入的数据违反了任何约束，复制将会
停止。这被称为 冲突。在
复制 UPDATE 或 DELETE
操作时，缺失的数据也被视为
冲突，但不会导致错误，这样的
操作将被简单跳过。
额外的日志记录被触发，冲突统计信息被收集（显示在
pg_stat_subscription_stats 视图中）
在以下 冲突 情况下：
insert_exists #
插入一行违反 NOT DEFERRABLE
唯一约束的行。请注意，为了记录冲突键的来源和提交
时间戳详细信息，track_commit_timestamp
应在订阅者上启用。在这种情况下，将引发错误，直到
冲突被手动解决。
update_origin_differs #
更新一行，该行之前由另一个来源修改。
请注意，只有在 track_commit_timestamp
在订阅者上启用时，才能检测到此冲突。目前，无论
本地行的来源如何，更新始终会被应用。
update_exists #
更新的行的值违反了 NOT DEFERRABLE
唯一约束。请注意，为了记录冲突键的来源和提交
时间戳详细信息，track_commit_timestamp
应在订阅者上启用。在这种情况下，将引发错误，直到
冲突被手动解决。请注意，当更新一个
分区表时，如果更新的行值满足另一个分区
约束，导致该行被插入到一个新分区中，
如果新行违反 NOT DEFERRABLE 唯一约束，
则可能会出现 insert_exists 冲突。
update_missing #
要更新的行未找到。在这种情况下，更新将被
简单跳过。
delete_origin_differs #
删除一行，该行之前由另一个来源修改。请注意
只有在 track_commit_timestamp
在订阅者上启用时，才能检测到此冲突。目前，无论
本地行的来源如何，删除始终会被应用。
delete_missing #
要删除的行未找到。在这种情况下，删除将被
简单跳过。
multiple_unique_conflicts #
插入或更新一行违反多个
NOT DEFERRABLE 唯一约束。请注意，为了记录
冲突键的来源和提交时间戳详细信息，请确保
track_commit_timestamp
在订阅者上启用。在这种情况下，将引发错误，直到
冲突被手动解决。
请注意，还有其他冲突场景，例如排除约束
违反。目前，我们在日志中不提供它们的额外详细信息。
逻辑复制冲突的日志格式如下：
LOG:  检测到关系 "schemaname.tablename" 的冲突： conflict=conflict_type
DETAIL:  detailed_explanation。
{detail_values [; ... ]}。
其中 detail_values 是以下之一：
键 (column_name [, ...])=(column_value [, ...])
现有本地行 [(column_name [, ...])=](column_value [, ...])
远程行 [(column_name [, ...])=](column_value [, ...])
副本标识 {(column_name [, ...])=(column_value [, ...]) | full [(column_name [, ...])=](column_value [, ...])}
日志提供以下信息：
LOG
schemaname.tablename
标识了涉及冲突的本地关系。
conflict_type 是发生的冲突类型
（例如，insert_exists、update_exists）。
DETAIL
detailed_explanation 包括
修改现有本地行的事务的来源、事务 ID 和提交时间戳（如果可用）。
键 部分包括违反唯一约束的本地行的键值，
适用于 insert_exists、update_exists 或
multiple_unique_conflicts 冲突。
现有本地行 部分包括本地行，如果其来源与
远程行不同，适用于 update_origin_differs 或
delete_origin_differs 冲突，或者如果键值与
远程行冲突，适用于 insert_exists、update_exists 或
multiple_unique_conflicts 冲突。
远程行 部分包括导致冲突的远程插入或更新操作的新行。
请注意，对于更新操作，如果新行的列值未更改且被 TOAST，
则该值将为 NULL。
副本标识 部分包括用于查找要更新或删除的现有本地行的副本标识键值。
如果本地关系标记为
REPLICA IDENTITY FULL，则可能包括完整行值。
column_name 是列名。
对于 现有本地行、远程行 和
副本标识全 情况，只有在用户缺乏访问表中所有列的权限时，
列名才会被记录。如果列名存在，它们将按与相应列值相同的顺序出现。
column_value 是列值。
大列值被截断为 64 字节。
请注意，在 multiple_unique_conflicts 冲突的情况下，
将生成多个 detailed_explanation
和 detail_values 行，
每行详细说明与不同唯一约束相关的冲突信息。
逻辑复制操作是以拥有订阅的角色的权限执行的。目标表上的权限失败将导致复制冲突，
同样，目标表上启用的行级安全性也会导致冲突，
而不考虑订阅所有者是否受到任何策略通常会拒绝正在复制的INSERT、
UPDATE、DELETE或TRUNCATE。
对行级安全性的这种限制可能在未来版本的PostgreSQL中取消。
产生错误的冲突将停止复制；必须由用户手动解决。有关冲突的详细信息可以在
订阅者的服务器日志中找到。
解决方案可以通过更改订阅者上的数据或权限来实现，以避免与传入更改冲突，或者通过跳过
与现有数据冲突的事务来实现。当冲突产生错误时，复制将不会继续，逻辑复制工作进程将
向订阅者的服务器日志发出以下类型的消息：
ERROR:  conflict detected on relation "public.test": conflict=insert_exists
DETAIL:  Key already exists in unique index "t_pkey", which was modified locally in transaction 740 at 2024-06-26 10:47:04.727375+08.
Key (c)=(1); existing local row (1, 'local'); remote row (1, 'remote').
CONTEXT:  processing remote data for replication origin "pg_16395" during "INSERT" for replication target relation "public.test" in transaction 725 finished at 0/14C0378
包含违反约束的更改的事务的 LSN 和复制源名称可以在服务器日志中找到（在上述情况下，LSN 0/14C0378 和
复制源 pg_16395）。可以通过使用
ALTER SUBSCRIPTION ... SKIP
跳过产生冲突的事务，使用完成的 LSN
（即，LSN 0/14C0378）。完成的 LSN 可以是事务在发布者上提交或准备的 LSN。或者，也可以通过调用
pg_replication_origin_advance() 函数来跳过事务。
在使用此函数之前，订阅需要暂时禁用，
可以通过
ALTER SUBSCRIPTION ... DISABLE 或者，订阅可以与
disable_on_error
选项一起使用。然后，您可以使用 pg_replication_origin_advance()
函数与 node_name（即，pg_16395）
和完成 LSN 的下一个 LSN（即，0/14C0379）。可以在
pg_replication_origin_status 系统视图中查看当前源的位置。
请注意，跳过整个事务包括跳过可能不违反任何约束的更改。这可能会导致订阅者
不一致。
有关冲突行的其他详细信息，例如它们的来源和
提交时间戳，可以在日志的 DETAIL 行中查看。但请注意，只有在
track_commit_timestamp
在订阅者上启用时，此信息才可用。用户可以使用此信息来决定
是保留本地更改还是采用远程更改。例如，上述日志中的 DETAIL 行表明
现有行是在本地修改的。用户可以手动执行远程更改胜出。
当
streaming
模式为parallel时，失败事务的完成 LSN 可能不会被记录。
在这种情况下，可能需要将流模式更改为on或off，
并再次引发相同的冲突，以便将失败事务的完成 LSN 写入服务器日志。
有关完成 LSN 的用法，请参阅ALTER SUBSCRIPTION ...
SKIP。
上一页 上一级 下一页29.6. 生成列复制 起始页 29.8. 限制
