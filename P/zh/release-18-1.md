# E.3. 版本 18.1

E.3. 版本 18.1
版本：
纠错本页面
搜索
目录导航
❮
❯
E.3. 版本 18.1 #E.3.1. 迁移到版本 18.1E.3.2. 变更发布日期：. 2025-11-13
此版本包含来自 18.0 的各种修复。
有关主要版本 18 中新功能的信息，请参见
第 E.4 节.
E.3.1. 迁移到版本 18.1 #
对于运行 18.X 的用户，不需要进行转储/恢复。
E.3.2. 变更 #
检查在 CREATE STATISTICS 中对模式的
CREATE 权限（Jelte Fennema-Nio）
§
这个遗漏允许表的拥有者在任何模式中创建统计信息，
可能导致意外的命名冲突。
PostgreSQL 项目感谢
Jelte Fennema-Nio 报告此问题。
（CVE-2025-12817）
避免在 libpq 中的分配大小计算
中发生整数溢出（Jacob Champion）
§
libpq 中的几个地方在计算内存
分配所需大小时不够小心。足够大的输入可能导致
整数溢出，从而导致缓冲区大小不足，进而导致写入
超出缓冲区的末尾。
PostgreSQL 项目感谢 Aleksey
Solovev of Positive Technologies 报告此问题。
（CVE-2025-12818）
防止在 SQL/JSON 函数如 JSON_VALUE 中出现
“未识别的节点类型” 错误，当其具有包含
DEFAULT 子句的 COLLATE
表达式时（Jian He）
§
§
避免对不含变量的 HAVING 子句与分组集的错误优化
（Richard Guo）
§
§
不要在哈希右半连接中使用并行性（Richard Guo）
§
由于更新连接的共享哈希表时发生竞争条件，该情况无法可靠工作。
在创建有序追加计划时，避免可能的零除错误
（Richard Guo）
§
这个错误可能导致选择最便宜路径的错误，或者在调试构建中导致断言失败。
修复规划器在可以进行有序访问但不能进行索引仅扫描的索引类型上的失败
（Maxime Schoemans）
§
这个疏忽导致了类似 “索引仅扫描未返回数据” 的错误。该情况在任何内核索引类型中都不会出现，但一些扩展遇到了这个问题。
删除 btree 索引清理中的错误断言（Peter Geoghegan）
§
在并行 GIN 索引构建期间，避免可能的内存不足或 “无效的内存分配请求大小” 失败（Tomas Vondra）
§
确保 BRIN 自动汇总为需要快照的索引表达式提供快照
（Álvaro Herrera）
§
§
之前，自动汇总会在这些索引上失败，然后留下占位符索引元组，导致索引随着时间的推移而膨胀。
修复 BRIN 索引扫描中的整数溢出风险，当表包含接近 232 页时（Sunil S）
§
这个疏忽可能导致无限循环或扫描不需要的表页。
修复 JIT 生成的元组变形代码中存储值的错误零扩展（David Rowley）
§
当不使用 JIT 时，相应的代码执行符号扩展而不是零扩展，导致小整数数据类型的 Datum 表示不同。这个不一致在大多数情况下被掩盖，但已知在使用 Memoize 计划节点时会导致 “找不到备忘录表条目” 错误，并且可能还有其他症状。
修复处理哈希 GROUPING
SETS 查询时的罕见崩溃问题 (David Rowley)
§
修复哈希连接中选择哈希表大小的逻辑错误
(Tomas Vondra)
§
哈希连接有时使用的内存超过预期，或者未能
以有效的方式进行划分。
改进统计信息操作函数中的关系查找逻辑
(Nathan Bossart)
§
§
修复 pg_restore_relation_stats(),
pg_clear_relation_stats(),
pg_restore_attribute_stats() 和
pg_clear_attribute_stats() 在获取目标关系的锁之前检查
权限，而不是之后。
修复触发器的结果关系信息缓存的逻辑错误
(David Rowley, Amit Langote)
§
在分区的列集与其父分区表的列集不完全相同的情况下，
这种疏忽可能导致崩溃。
修复在分区表上进行 EvalPlanQual 重新检查时的崩溃问题
(David Rowley, Amit Langote)
§
修复 EvalPlanQual 对没有为 EPQ 准备替代本地连接计划的
外部或自定义连接的处理 (Masahiko
Sawada, Etsuro Fujita)
§
在这种情况下，外部或自定义访问方法应该正常调用，
但实际上并未发生，通常会导致崩溃。
避免在 DETACH
CONCURRENTLY 期间重复哈希分区约束
(Haiyang Li)
§
ALTER TABLE DETACH PARTITION CONCURRENTLY 被
编写为将分区约束的副本添加到现在已分离的分区。这是错误的，部分原因是
非并发的 DETACH 不会这样做，但主要是因为在哈希分区的情况下，
约束表达式包含对父表 OID 的引用。这在转储/恢复期间或如果在
DETACH 之后删除父表时会导致问题。在 v19 及以后的版本中，
我们将不再创建任何此类复制的约束。在发布的分支中，为了
最小化不可预见后果的风险，仅在哈希分区的情况下跳过添加复制约束。
不允许在分区键中使用生成列
(Jian He, Ashutosh Bapat)
§
这已经是不允许的，但检查遗漏了一些情况，例如列引用在整个行引用中是隐式的。
不允许在 COPY ... FROM
... WHERE 子句中使用生成列 (Peter Eisentraut, Jian He)
§
之前，尝试引用这样的列会导致不正确的行为或模糊的错误消息，
因为生成的列在进行 WHERE 过滤时尚未计算。
如果列具有非空约束但该约束被标记为无效，则防止将其设置为身份列
（Jian He）
§
身份列必须是非空的，但对此的检查遗漏了这个边缘情况。
避免在并行 VACUUM 中潜在的使用后释放问题（Kevin Oommen
Anish）
§
这个漏洞在标准构建中似乎没有后果，但理论上它是一个隐患。
修复 pg_temp 中统计对象的可见性检查
（Noah Misch）
§
位于临时模式中的统计对象不能在没有模式限定的情况下命名，
但 pg_statistics_obj_is_visible() 忽略了这一点，
可能会返回 “true”。因此，
像 pg_describe_object() 这样的函数可能
无法按预期对对象名称进行模式限定。
修复在数据库创建的 WAL 重放期间的轻微内存泄漏
（Nathan Bossart）
§
修复 pg_stat_replication 视图中复制延迟的错误报告
（Fujii Masao）
§
如果任何备用服务器的重放 LSN 停止前进，
write_lag
和 flush_lag 列最终将停止更新。
避免关于无效 primary_slot_name 设置的重复日志消息
（Fujii Masao）
§
避免在 synchronized_standby_slots 引用不存在的复制槽时发生故障
（Shlok Kyal）
§
在未能将复制槽的状态写入磁盘后，删除未完成的槽状态文件
（Michael Paquier）
§
之前，像磁盘空间不足这样的故障会导致留下一个临时的
state.tmp 文件。这是有问题的，因为它会阻止所有后续尝试
写入状态，要求手动干预以进行清理。
修复逻辑复制的并行应用工作线程中锁超时信号的错误处理
（Hayato Kuroda）
§
相同的信号编号被用于工作线程关闭和锁超时，导致混淆。
避免在从流式 WAL 源切换到归档 WAL 源时意外关闭 WAL 接收器
（Xuneng Zhou）
§
在时间线更改期间，备用服务器的 WAL 接收器应保持活动状态，
等待新的 WAL 流式启动点。相反，它反复关闭并立即重新启动，
这可能会混淆状态监控代码。
修复 pgoutput 逻辑解码插件中
维护的关系同步缓存中的使用后释放问题
（Vignesh C, Masahiko Sawada）
§
逻辑解码期间的错误可能导致同一会话中后续逻辑解码尝试崩溃。
该情况仅在通过 SQL 函数调用 pgoutput
时可达。
避免不必要的逻辑复制槽失效
（Bertrand Drouvot）
§
在区域设置中重新建立 C 排序的特例
（Jeff Davis）
§
这修复了在后端启动早期访问共享目录时的回归问题，
在选择数据库之前。尚不清楚这是否是任何核心
PostgreSQL 代码的问题，但一些扩展
已经损坏。
修复关于检查用户是否具有 Windows 管理员权限的失败消息的
错误打印（Bryan Green）
§
这段代码可能会崩溃或至少打印垃圾。
尽管没有报告此类情况，这表明这些系统调用失败的情况
极为罕见。
避免在尝试使用某些 libsanitizer 选项测试
PostgreSQL 时崩溃
（Emmanuel Sibi, Jacob Champion）
§
修复在 64 位 Windows 上调试构建中错误的内存上下文检查警告
（David Rowley）
§
正确处理 PL/pgSQL 赋值语句中的 GROUP BY DISTINCT
（Tom Lane）
§
解析器未能在此上下文中记录 DISTINCT 选项，
以至于该命令的行为就像是普通的 GROUP BY。
避免在 PL/Python 中处理 SQL 错误时泄漏内存
（Tom Lane）
§
这修复了我们之前小版本中引入的会话生命周期内存泄漏。
修复 libpq 在其 GSSAPI 逻辑中对
Windows 上与套接字相关的错误的处理（宁吴, 汤姆·莱恩）
§
使用 GSSAPI 加密/解密传输数据的代码未能正确识别
连接套接字上的错误条件，因为 Windows 的报告方式与
其他平台不同。这导致在 Windows 上无法建立此类连接。
修复对继承表列上非继承的非空约束的转储 (Dilip Kumar)
§
pg_dump 在从 v18 之前的服务器转储时
未能保留此类约束。
修复 pg_dump 对外键约束的排序
(Álvaro Herrera)
§
确保这些数据库对象的一致排序，正如其他对象类型
已经完成的那样。
修复 pg_dump 和
pg_restore 中数据压缩逻辑的各种错误
(Daniel Gustafsson, Tom Lane)
§
§
§
在多个地方缺少或不正确的错误检查，并且在大端硬件上
还存在可移植性问题。这些问题被忽视是因为这段代码
仅用于读取目录格式转储中的压缩 TOC 文件。
pg_dump 从不生成此类转储；该情况
只能通过在事后手动压缩 TOC 文件来达到，这是一种被支持的
操作，但非常不常见。
修复 pgbench 以在启动
COPY 操作时干净地报错 (Anthonin Bonnefoy)
§
pgbench 不打算支持这种情况，
但之前它进入了无限循环。
修复 pgbench 对多个错误的报告
(Yugo Nagata)
§
在两个连续的 PQgetResult 调用都失败的情况下，
pgbench 可能会报告错误的错误消息。
在 pgbench 中，修复关于管道模式
中错误的断言 (Yugo Nagata)
§
修复 pg_combinebackup 中的每个文件内存泄漏
(Tom Lane)
§
确保 contrib/pg_buffercache 函数可以被取消
(Satyanarayana Narlapuram, Yuhang Qiu)
§
§
某些代码路径能够长时间运行而不检查中断。
修复 contrib/pg_prewarm 对索引的权限检查
(Ayush Vatsa, Nathan Bossart)
§
§
pg_prewarm() 需要对要预热的关系具有 SELECT
权限。然而，由于索引没有自己的 SQL 权限，这导致非超级用户
无法预热索引。相反，检查索引表上的 SELECT
权限。
在 contrib/pg_stat_statements 中，避免
当两个或多个常量在 SQL 语句文本中标记为具有相同
位置时崩溃 (Sami Imseih, Dmitry Dolgov)
§
使 contrib/pgstattuple 对空或无效的索引页面
更加健壮 (Nitin Motiani)
§
将全零页面计为自由空间，并忽略根据页面的特殊空间大小检查
而无效的页面。btree 索引的代码已经将全零页面计为自由，
但哈希和 gist 代码会出错，这被发现不够用户友好。
同样，使这三种情况都同意忽略损坏的页面，而不是抛出错误。
加强我们的读写屏障宏以满足 Clang 的要求
(Thomas Munro)
§
我们假设 __atomic_thread_fence() 是一个
足够的屏障，可以防止 C 编译器重新排序其周围的内存
访问，但对于 Clang 来说，这似乎并不成立，
允许它为至少 RISC-V、MIPS 和 LoongArch 机器生成不正确的代码。
添加显式编译器屏障以修复此问题。
修复 PGXS 构建基础设施以支持为扩展构建
NLS po 文件 (Ryo Matsumura)
§
上一页 上一级 下一页E.2. 版本 18.2 起始页 E.4. 发布 18
