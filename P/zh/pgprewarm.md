# F.30. pg_prewarm — 将关系数据预加载到缓冲区缓存中

F.30. pg_prewarm — 将关系数据预加载到缓冲区缓存中
版本：
纠错本页面
搜索
目录导航
❮
❯
F.30. pg_prewarm — 将关系数据预加载到缓冲区缓存中 #F.30.1. 函数F.30.2. 配置参数F.30.3. 作者
pg_prewarm模块提供一种方便的方法将关系
数据载入到操作系统缓冲区或者
PostgreSQL缓冲区。可以使用pg_prewarm函数手动执行预热，或者通过在shared_preload_libraries中包括pg_prewarm来自动执行预热。在后一种情况中，系统将运行一个后台工作者，它会周期性地将共享内存中的内容记录在一个名为autoprewarm.blocks的文件中，并且在重新启动后用两个后台工作者重新载入那些块。
F.30.1. 函数 #
pg_prewarm(regclass, mode text default 'buffer', fork text default 'main',
first_block int8 default null,
last_block int8 default null) RETURNS int8
第一个参数是要预热的关系。第二个参数是要使用的预热方法，下文将会
进一步讨论。第三个参数是要被预热的关系分叉，通常是main。
第四个参数是要预热的第一个块号（NULL也被接受，它等同于
零）。第五个参数是要预热的最后一个块号（NULL
表示预热到关系的最后一个块）。返回值是被预热的块数。
有三种可用的预热方法。prefetch会向操作系统发出异步
预取请求（如果支持异步预取），不支持异步预取则抛出一个错误。
read会读取请求范围的块。与prefetch
不同，它是同步的并且在所有平台上都被支持，但是可能较慢。
buffer会把请求范围的块读入到数据库的缓冲区。
注意使用任意一种方法尝试预热比能缓存的数量更多的块 — 使用
prefetch或者read（由 OS）或者使用
buffer（由PostgreSQL
） — 将很可能导致高编号块被读入时低编号的块从缓冲区中逐出的情况。
被预热的数据也不享受对缓冲区替换的特别保护，因此其他系统活动可能会在刚刚
被预热的块被读入后很快就将它们逐出。反过来，预热也可能把其他数据逐出缓存。
由于这些原因，预热通常在启动时最有用，那时缓冲区大部分都为空。
autoprewarm_start_worker() RETURNS void
启动主要的 autoprewarm 工作者。这个过程通常会自动发生，但如果在服务器启动时没有配置自动预热，并且您希望在稍后启动工作者，则这个函数非常有用。
autoprewarm_dump_now() RETURNS int8
立即更新 autoprewarm.blocks。如果 autoprewarm 工作者没有运行，但您预计在下一次重启后会运行它，则这个函数可能会很有用。返回值是写入到 autoprewarm.blocks 中的记录数。
F.30.2. 配置参数 #
pg_prewarm.autoprewarm (boolean)
控制服务器是否应该运行 autoprewarm 工作者。默认情况下该参数为开启。这个参数只能在服务器启动时设置。
pg_prewarm.autoprewarm_interval (integer)
这是更新autoprewarm.blocks的间隔。默认是300秒。如果设置为0，该文件将不会以常规的间隔方式转储，而是只在服务器关闭时转储。
这些参数必须在postgresql.conf中设置。
典型用法可能是：
# postgresql.conf
shared_preload_libraries = 'pg_prewarm'
pg_prewarm.autoprewarm = true
pg_prewarm.autoprewarm_interval = 300s
F.30.3. 作者 #
Robert Haas <rhaas@postgresql.org>
上一页 上一级 下一页F.29. pg_overexplain — 允许 EXPLAIN 输出更多细节 起始页 F.31. pgrowlocks — 显示表的行锁定信息
