# 29.12. 配置设置

29.12. 配置设置
版本：
纠错本页面
搜索
目录导航
❮
❯
29.12. 配置设置 #29.12.1. 发布者29.12.2. 订阅者
逻辑复制需要设置多个配置选项。这些选项仅在复制的一侧相关。
29.12.1. 发布者 #
wal_level 必须设置为
logical。
max_replication_slots
必须设置为至少等于预期连接的订阅数量，加上一些用于表同步的预留。
逻辑复制槽也受
idle_replication_slot_timeout 的影响。
max_wal_senders
应该设置为至少与
max_replication_slots相同，加上同时连接的物理
副本的数量。
逻辑复制的 walsender 也会受到
wal_sender_timeout
的影响。
29.12.2. 订阅者 #
max_active_replication_origins
必须设置为至少将要添加到
max_active_replication_origins的订阅数量，加上一些用于表同步的保留。
max_logical_replication_workers
必须设置为至少等于订阅的数量（用于领导者应用工作者），
另外还需要为表同步工作者和并行应用工作者预留一些。
max_worker_processes
可能需要调整以适应复制工作者，至少为
(max_logical_replication_workers
+ 1)。请注意，一些扩展和并行查询也会从
max_worker_processes中占用工作者槽位。
max_sync_workers_per_subscription
控制订阅初始化期间或添加新表时初始数据复制的并行度。
max_parallel_apply_workers_per_subscription
控制使用订阅参数
streaming = parallel时，对进行中的事务流式传输的并行度。
逻辑复制工作者也会受到
wal_receiver_timeout、
wal_receiver_status_interval 和
wal_retrieve_retry_interval 的影响。
上一页 上一级 下一页29.11. 安全性 起始页 29.13. 升级
