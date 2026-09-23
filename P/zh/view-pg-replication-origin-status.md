# 53.19. pg_replication_origin_status

53.19. pg_replication_origin_status
版本：
纠错本页面
搜索
目录导航
❮
❯
53.19. pg_replication_origin_status #
pg_replication_origin_status视图包含关于某个源的重放进度信息。
有关复制源的更多信息，请参见第 48 章。
表 53.19. pg_replication_origin_status 列
列类型
描述
local_id oid
(references pg_replication_origin.roident)
内部节点标识符
external_id text
(references pg_replication_origin.roname)
外部节点标识符
remote_lsn pg_lsn
源节点的 LSN，到此位置的数据已被复制。
local_lsn pg_lsn
这个节点的 LSN，remote_lsn已经被复制。使用异步提交时，在将数据持久化到磁盘前用它来刷新提交记录。
上一页 上一级 下一页53.18. pg_publication_tables 起始页 53.20. pg_replication_slots
