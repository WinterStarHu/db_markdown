# DROP SUBSCRIPTION

DROP SUBSCRIPTION
版本：
纠错本页面
搜索
目录导航
❮
❯
DROP SUBSCRIPTIONDROP SUBSCRIPTION — 移除一个订阅大纲
DROP SUBSCRIPTION [ IF EXISTS ] name [ CASCADE | RESTRICT ]
说明
DROP SUBSCRIPTION 删除数据库集群中的一个订阅。
要执行此命令，用户必须是订阅的所有者。
DROP SUBSCRIPTION 不能在事务块内执行，如果该订阅关联了复制槽。
（你可以使用 ALTER SUBSCRIPTION 来取消该槽。）
参数name
要删除的订阅名称。
CASCADERESTRICT
这些关键字没有任何作用，因为订阅之上没有依赖关系。
注释
当删除与远程主机上的复制槽关联的订阅（正常状态）时，DROP SUBSCRIPTION
会连接到远程主机并尝试删除复制槽（以及任何剩余的表同步槽），作为其操作的一部分。
这是必要的，以便释放远程主机上为订阅分配的资源。如果失败，可能是因为远程主机无法访问，
或者远程复制槽无法删除、不存在或从未存在，DROP SUBSCRIPTION命令将失败。
要在这种情况下继续，首先通过执行
ALTER SUBSCRIPTION ... DISABLE禁用订阅，
然后通过执行
ALTER SUBSCRIPTION ... SET (slot_name = NONE)将其与复制槽解除关联。
之后，DROP SUBSCRIPTION将不再尝试对远程主机执行任何操作。
注意，如果远程复制槽仍然存在，则应手动删除它（以及任何相关的表同步槽）；
否则，它们将继续占用WAL，可能最终导致磁盘填满。另见
第 29.2.1 节.
如果订阅与复制槽相关联，那么不能在事务块内部执行DROP SUBSCRIPTION。
示例
删除一个订阅：
DROP SUBSCRIPTION mysub;
兼容性
DROP SUBSCRIPTION是一个PostgreSQL扩展。
另见CREATE SUBSCRIPTION, ALTER SUBSCRIPTION上一页 上一级 下一页DROP STATISTICS 起始页 DROP TABLE
