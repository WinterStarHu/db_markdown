# 29.3. 逻辑复制故障切换

29.3. 逻辑复制故障切换
版本：
纠错本页面
搜索
目录导航
❮
❯
29.3. 逻辑复制故障切换 #
为了允许订阅节点在发布节点宕机时继续从发布节点复制数据，必须有一个与发布节点对应的物理备用节点。
可以通过在创建订阅时指定 failover = true，将主服务器上对应订阅的逻辑槽同步到备用服务器。
详情请参见 第 47.2.3 节。
启用
failover
参数确保备用节点升级后这些订阅能够无缝切换，继续订阅新主服务器上的发布内容。
由于槽同步逻辑是异步复制的，因此在故障切换发生之前，必须确认复制槽已同步到备用服务器。
为确保故障切换成功，备用服务器必须领先于订阅者。可以通过配置
synchronized_standby_slots来实现。
为了确认备用服务器确实准备好进行故障转移以供特定订阅者使用，请按照以下步骤验证该订阅者所需的所有逻辑复制槽已同步到备用服务器：
在订阅节点上，使用以下 SQL 来识别哪些复制槽应该同步到我们计划提升的备用节点。此查询将返回与启用故障转移的订阅相关的复制槽。
/* sub # */ SELECT
array_agg(quote_literal(s.subslotname)) AS slots
FROM  pg_subscription s
WHERE s.subfailover AND
s.subslotname IS NOT NULL;
slots
-------
{'sub1','sub2','sub3'}
(1 row)
在订阅节点上，使用以下 SQL 来识别哪些表同步槽应该同步到我们计划提升的备用节点。此查询需要在每个包含启用故障转移的订阅的数据库上运行。请注意，只有在表复制完成后，表同步槽才应该同步到备用服务器
（参见 第 52.55 节）。
在其他情况下，我们不需要确保表同步槽被同步，因为它们将在这些情况下被删除或在新的主服务器上重新创建。
/* sub # */ SELECT
array_agg(quote_literal(slot_name)) AS slots
FROM
(
SELECT CONCAT('pg_', srsubid, '_sync_', srrelid, '_', ctl.system_identifier) AS slot_name
FROM pg_control_system() ctl, pg_subscription_rel r, pg_subscription s
WHERE r.srsubstate = 'f' AND s.oid = r.srsubid AND s.subfailover
);
slots
-------
{'pg_16394_sync_16385_7394666715149055164'}
(1 row)
检查上述识别的逻辑复制槽是否存在于备用服务器上，并且是否准备好进行故障转移。
/* standby # */ SELECT slot_name, (synced AND NOT temporary AND invalidation_reason IS NULL) AS failover_ready
FROM pg_replication_slots
WHERE slot_name IN
('sub1','sub2','sub3', 'pg_16394_sync_16385_7394666715149055164');
slot_name                                 | failover_ready
--------------------------------------------+----------------
sub1                                      | t
sub2                                      | t
sub3                                      | t
pg_16394_sync_16385_7394666715149055164   | t
(4 rows)
如果所有槽在备用服务器上都存在，并且上述 SQL 查询的结果
(failover_ready) 为真，则现有的订阅可以继续订阅新的主服务器上的出版物。
上述过程中的前两步是针对 PostgreSQL 订阅者的。建议在每个订阅节点上运行这些步骤，这些节点将在故障转移后由指定的备用节点提供服务，以获取完整的复制槽列表。然后可以在步骤 3 中验证此列表以确保故障转移准备就绪。
而非 PostgreSQL 订阅者可以使用他们自己的方法来识别各自订阅所使用的复制槽。
在某些情况下，例如在计划的故障转移期间，有必要确认所有订阅者，无论是 PostgreSQL 还是非 PostgreSQL，在故障转移到给定的备用服务器后将能够继续复制。在这种情况下，使用以下 SQL，而不是执行上述前两步，来识别主服务器上需要同步到计划提升的备用服务器的复制槽。此查询返回与所有启用故障转移的订阅相关的复制槽。
/* primary # */ SELECT array_agg(quote_literal(r.slot_name)) AS slots
FROM pg_replication_slots r
WHERE r.failover AND NOT r.temporary;
slots
-------
{'sub1','sub2','sub3', 'pg_16394_sync_16385_7394666715149055164'}
(1 row)
上一页 上一级 下一页29.2. 订阅 起始页 29.4. 行过滤器
