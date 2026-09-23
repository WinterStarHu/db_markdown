# E.2. 版本 18.2

E.2. 版本 18.2
版本：
纠错本页面
搜索
目录导航
❮
❯
E.2. 版本 18.2 #E.2.1. 迁移到版本 18.2E.2.2. 变更发布日期：. 2026-02-12
此版本包含来自 18.1 的各种修复。
有关主要版本 18 中新功能的信息，请参见
第 E.4 节。
E.2.1. 迁移到版本 18.2 #
对于运行 18.X 的用户，不需要进行转储/恢复。
然而，如果您在 ltree 列上有任何索引，
更新后可能需要重新索引它们。请参见下面的第六个变更日志条目。
E.2.2. 变更 #
防止 oidvector/int2vector 的意外维度
（Tom Lane）
§
这些数据类型预计是包含
无 NULL 的一维数组，但存在允许违反这些
预期的类型转换路径。对一些依赖于
这些预期而未进行验证的函数添加检查，可能会因此出现异常行为。
PostgreSQL 项目感谢
Altan Birler 报告此问题。
（CVE-2026-2003）
加强选择性估算器，以防止其附加到接受
意外数据类型的运算符（Tom Lane）
§
§
contrib/intarray 包含一个选择性
估算函数，该函数可能被滥用以执行任意代码，
因为它没有检查其输入是否为
预期的数据类型。第三方扩展应检查类似
的风险，并使用 intarray 现在使用的技术添加防御。
由于此类扩展修复需要时间，我们现在要求超级用户
权限才能将非内置选择性估算器附加到运算符。
PostgreSQL 项目感谢
Daniel Firer，作为 zeroday.cloud 的一部分，报告了此问题。
（CVE-2026-2004）
修复 contrib/pgcrypto 的
PGP 解密函数中的缓冲区溢出问题（Michael Paquier）
§
使用过长的会话密钥解密精心构造的消息导致了
缓冲区溢出，后果严重，可能导致任意代码
执行。
PostgreSQL 项目感谢
Team Xint Code，作为 zeroday.cloud 的一部分，报告了此问题。
（CVE-2026-2005）
修复多字节字符长度的验证不足问题
（Thomas Munro，Noah Misch）
§
§
§
§
§
§
各种错误允许攻击者通过发出精心构造的 SQL
来溢出字符串缓冲区，后果严重，可能导致任意代码
执行。修复后，应用程序可能会
观察到 “编码的无效字节序列” 错误
当字符串函数处理存储在数据库中的无效文本时。
PostgreSQL 项目感谢 Paul Gerste
和 Moritz Sanft，作为 zeroday.cloud 的一部分，报告了此
问题。
（CVE-2026-2006）
加强 contrib/pg_trgm 对字符串小写行为变化的
保护（Heikki Linnakangas）
§
§
修复由于某些区域设置中小写字符串可能产生的字符数
（而不是字节）超过原始字符数而导致的潜在缓冲区溢出。
这种行为在版本 18 中是新的，错误也是如此。
PostgreSQL 项目感谢
Heikki Linnakangas 报告了此问题。
（CVE-2026-2007）
修复 contrib/ltree 中不一致的大小写不敏感匹配
（Jeff Davis）
§
§
ltree 中与索引相关的例程使用了
与主运算符不同的大小写折叠实现。
只有在默认排序提供者为 libc 且编码为单字节时，它们的行为才是等效的。
为了解决此问题，请更改代码以使用数据库的
默认排序进行大小写折叠。
此更改将要求重新索引 ltree 列上的索引
（无论索引访问方法如何），除非数据库使用 libc 作为排序提供者且其编码为单字节。
否则，搜索此类索引将无法找到相关条目。
当使用 ALTER TABLE ... ADD CONSTRAINT 添加
显式名称的非空约束时，如果列已经标记为 NOT NULL，
则要求提供的名称与现有约束名称匹配
（Álvaro Herrera，Srinath Reddy Sadipiralla）
§
不允许在子查询中引用 CTE 来确定聚合函数的语义
级别（Tom Lane）
§
此更改撤销了两个小版本之前所做的更改，如果子查询引用了
一个低于标准 SQL 规则所分配给基于包含列引用和聚合的
聚合的语义级别的 CTE，则会抛出错误。尝试的修复结果
导致了自身的问题，目前尚不清楚该如何处理。由于 SQL
标准完全不允许在聚合内使用子查询，因此将此类情况视为
错误似乎是足够的。
修复 CTE 查询中 MERGE 的触发器过渡表捕获
（Dean Rasheed）
§
当执行包含 MERGE 和其他 DML 操作的
数据修改 CTE 查询时，如果该表具有语句级 AFTER
触发器，则传递给触发器的过渡表将不包括受 MERGE
影响的行，仅包括受其他操作影响的行。
修复属于非关系范围表条目的行标记的错误修剪，例如子查询
（Dean Rasheed）
§
如果提议的行更新需要通过 EvalPlanQual 重新检查进行修改，
则会导致不正确的结果，因为可能会发生对该行的并发更新。
修复当更新或删除的分区目标表的所有子表都被修剪时的失败
（Amit Langote）
§
在这种情况下，执行器可能会报告 “找不到垃圾 ctid 列”
错误，即使实际上不需要执行任何操作。
修复数组下标内子查询的表达式评估错误（Andres Freund）
§
修复非确定性排序规则下的文本子字符串搜索（Laurenz Albe）
§
当使用非确定性排序规则时，我们未能检测到在搜索字符串的
最后位置发生的匹配。
当查询包含重复的窗口函数调用时，避免可能的规划器失败
（Meng Zhang, David Rowley）
§
对此类调用的去重混淆可能导致错误，例如 “窗口函数
winref 2 被分配给窗口聚合 winref 1”。
修复与返回集合的函数和分组集相关的规划器错误
（Richard Guo）
§
在构造 ProjectSet 计划节点时，规划器未能检测到涉及分组
表达式的子表达式已经由输入计划计算。这导致了低效的计划
或错误，例如 “在子计划目标列表中找不到变量”。
当子查询的分组子句包含易变或返回集合的函数时，避免不
正确的优化（Richard Guo）
§
规划器愿意下推引用此分组列的外部查询限制，这导致由于
多次评估易变函数而产生不正确的行为，或由于将返回集
的函数引入到子查询的 WHERE/HAVING
子句中而导致错误。
在搜索表达式的统计信息时查看 PlaceHolderVar 节点
（Richard Guo）
§
此更改允许规划器找到从子查询中提取或用于 GROUP
BY 的表达式的相关统计信息，避免回退到默认估计。
（可以说，我们应该调整任何找到的统计信息，以考虑值为
NULL 的概率增加，但我们从未对普通 Vars 做过类似的事情。）
尽管此限制较旧，但 PostgreSQL 版本 18
的更改使 PlaceHolderVars 比以前更常见，因此进行此更改以
避免在受影响的情况下计划回归。
在匹配表达式到索引时查看无操作的 PlaceHolderVar 节点
（Richard Guo）
§
因为 PostgreSQL 版本 18 在更多情况下使用
PlaceHolderVars，某些以前可以使用索引的查询未能做到这一点。
添加逻辑以防止这种回归。
修复规划器将 OR 子句转换为
ScalarArrayOp 索引条件的问题（Tender Wang, Tom Lane）
§
代码未正确处理 RelabelType 节点，可能生成无效的表达式
或未能执行有效的转换。
即使索引的谓词暗示 WHERE 子句的真实性，也允许对部分哈希
索引进行索引扫描（Tom Lane）
§
通常我们会删除由谓词暗示的 WHERE 子句，因为测试它是
没有意义的；它必须对每个索引条目都成立。然而，这可能会
阻止创建索引扫描计划，如果索引是需要在主索引键上有
WHERE 子句的类型，如哈希索引。考虑此类索引时，不要删除
隐含子句。
不为未记录的 BRIN 索引发出 WAL（Kirill Reshke）
§
一条很少被采用的代码路径错误地发出了与 BRIN 索引相关的
WAL 记录，即使该索引被标记为未记录。崩溃恢复将无法重放
该记录，并抱怨文件已存在。
在并行 GIN 索引构建中使用正确的排序函数（Tomas Vondra）
§
并行代码使用了默认的排序运算符（由列数据类型的 btree
opclass 决定），而应该使用 GIN opclass 指定的排序函数（如果有）。
如果数据类型没有 btree opclass，这将导致失败；如果 opclass
指定的排序函数与 btree opclass 不一致，则会导致无效的索引。
防止截断仍然被未读的 NOTIFY 消息所需的 CLOG
（Joel Jacobson, Heikki Linnakangas）
§
§
§
此修复防止在后端缓慢吸收 NOTIFY 消息时出现
“无法访问事务状态” 错误。
在处理 NOTIFY 消息时，将发生的错误提升为 FATAL，
即关闭连接（Heikki Linnakangas）
§
以前，如果后端在接收 NOTIFY 消息时发生错误，
它会跳过该消息，向客户端报告错误，然后继续处理。
然而，这种行为存在很多问题。一个主要问题是客户端无法
确定通知是否丢失，当然也无法知道其中的内容。
根据应用程序逻辑，错过通知可能会导致应用程序卡住等待。
此外，任何剩余的消息都不会被处理，直到有人发送新的
NOTIFY。
此外，如果在接收 NOTIFY 信号时连接处于空闲状态，
任何错误都会因无关的原因而提升为 FATAL。
因此，我们选择在所有情况下都这样做，以保持一致性并向
应用程序提供明确的信号，表明它可能错过了一些通知。
在计算查询 ID 哈希时考虑分组表达式
(Jian He)
§
之前，两个查询除了 GROUP BY 表达式不同外是相同的，
会被 contrib/pg_stat_statements 和其他查询 ID 的用户合并。
修复在并发更新时 EXPLAIN ANALYZE MERGE 中
更新计数错误的问题 (Dean Rasheed)
§
这种情况导致 EXPLAIN 输出中“跳过”的元组计数不正确，
或在启用断言的构建中导致断言失败。
修复在锁定元组时跟随更新链中的错误 (Jasper Smit)
§
该代码路径未能检查更新链中第一个新元组的 xmin，
如果原始更新者中止并且空间被 VACUUM 立即回收并重新使用，
则可能会锁定无关的元组。
这可能导致意外的事务延迟或死锁。
还观察到与识别错误元组相关的错误。
修复对大表增量备份的错误处理 (Robert Haas, Oleg Tkachenko)
§
如果一个超过 1GB（或一般来说，安装的段大小）的表在基础备份和增量备份之间
被 VACUUM 截断，pg_combinebackup
可能会因“截断块长度超过段大小”的错误而失败。
这阻止了增量备份的恢复。
修复由于尝试在已经取消映射的共享内存段中释放锁而导致的后端进程崩溃
(Rahila Syed)
§
修复异步 I/O 代码中的竞争条件 (Andres Freund)
§
异步 I/O 操作的结果代码在获取之前可能被覆盖。
防止崩溃后多事务日志的不正确截断 (Heikki Linnakangas)
§
修复 pg_stat_get_backend_activity() 的结果可能被错误编码的问题
(Chao Li)
§
持有会话活动字符串的共享内存缓冲区可能以不完整的多字节字符结束。
读取者应该截断任何这样的不完整字符，但此函数未能做到这一点。
防止递归内存上下文日志记录 (Fujii Masao)
§
不断请求内存上下文日志记录的信号流可能导致日志记录代码的递归执行，
理论上可能导致堆栈溢出。
修复重新初始化并行执行上下文时的内存上下文使用问题
(Jakub Wartak, Jeevan Chalke)
§
此错误可能导致崩溃，因为一个附属数据结构的生命周期比并行上下文短。
目前尚不清楚仅使用核心 PostgreSQL 是否会遇到此问题，但我们收到
扩展中的故障报告。
创建新 multixid 时设置下一个 multixid 的偏移量，以消除在边缘情况下所需的等待循环
(Andrey Borodin)
§
§
之前的逻辑可能会卡住，等待一个永远不会发生的更新。
避免多次重写数据修改的 CTE (Bernice Southey,
Dean Rasheed)
§
以前，当更新一个可自动更新的视图或带有规则的关系时，
如果原始查询有任何数据修改的 CTE，重写器会由于递归多次重写这些 CTE。
这效率低下，并且如果 CTE 包含对始终生成的列的更新，可能会产生错误。
允许重试初始化 DSM 注册表条目
(Nathan Bossart)
§
如果我们在初始化动态共享内存条目的过程中失败，
允许下一次尝试使用该条目重试初始化。
之前该条目会保持在一个永久失败的状态。
避免在页面被换出时 NUMA 状态视图失败
(Tomas Vondra)
§
避免在使用旧版本 libnuma 查询 NUMA 页面状态时出现
“操作不允许” 错误 (Tomas Vondra)
§
如果 WAL 不存在到检查点记录指示的重做点，则恢复失败
(Nitin Jadhav)
§
在开始恢复之前添加显式检查，以确保不会造成损害并提供有用的错误信息。之前，在这种情况下，恢复可能会崩溃或损坏数据库。
在 ALTER PUBLICATION 期间避免对源查询树进行修改 (Sunil S)
§
这个错误的明显影响是，查询的事件触发器只会看到第一个 publish 选项，即使指定了多个选项。如果这样的查询被设置为预处理语句，重新执行也会出现问题。
将在 CREATE SUBSCRIPTION ... CONNECTION 中指定的连接选项传递给发布者的 walsender (Fujii Masao)
§
在此修复之前，options 连接选项（如果有）被忽略，因此例如阻止在 walsender 会话中设置自定义服务器参数值。原本是希望这样工作的，但在 PostgreSQL 版本 15 的重构中破坏了这一点，因此恢复之前的行为。
防止新创建或新同步的复制槽失效 (Zhijie Hou)
§
§
§
与并发检查点的竞争条件可能导致需要的 WAL 被移除，从而使复制槽立即被标记为无效。
修复计算复制槽所需 xmin 的竞争条件 (Zhijie Hou)
§
这可能导致错误 “无法构建初始槽快照，因为最旧的安全 xid 跟随快照的 xmin”。
在逻辑复制订阅的初始同步期间，在开始复制数据之前提交添加 pg_replication_origin 条目 (Zhijie Hou)
§
之前，如果复制步骤失败，新的 pg_replication_origin 条目将因事务回滚而丢失。这导致共享内存中的状态不一致。
在并行工作者应用失败后，不要推进逻辑复制进度 (Zhijie Hou)
§
之前的行为允许事务被订阅者丢失。
修复逻辑复制槽同步工作进程以正确处理 LOCK_TIMEOUT 信号 (Zhijie Hou)
§
之前，超时信号实际上被忽略。
修复在重启流复制服务器时可能出现的 “意外数据超出 EOF”
的故障（Anthonin Bonnefoy）
§
修复 SQL/JSON 路径类型不匹配的错误报告（Jian He）
§
该代码可能会产生 “cache lookup failed for type 0”
错误，而不是关于路径表达式类型不正确的预期投诉。
修复解析分区范围边界时列位置的错误跟踪（myzhen）
§
这可能导致在关于将分区边界值转换为
列的数据类型的错误消息中引用错误的列名。
修复错误消息中的各种小错误（Man Zeng, Tianchen Zhang）
§
§
§
§
§
例如，关于备份清单中时间线编号不匹配的错误报告
显示了起始时间线编号，而应该显示结束时间线编号。
修复在使用 LLVM 版本 17 或更高版本进行 JIT 编译时
无法执行函数内联的问题（Anthonin Bonnefoy）
§
调整我们的 JIT 代码以与 LLVM 21 一起工作（Holger Hoffstätte）
§
之前的编码在 aarch64 机器上无法编译。
修复 aarch64 特定代码以与旧的 (RHEL7 时代) 系统
头文件一起构建（Tom Lane）
§
§
修复 io_uring_queue_init_mem() 的
不正确配置探测（Masahiko Sawada）
§
该错误导致在基于 autotools 的构建中无法优化异步 I/O
缓冲区分配，尽管在使用 meson 构建时代码可以正常工作。
该遗漏的主要影响是后端进程退出速度比必要的要慢。
添加新的服务器参数 file_extend_method 以
控制使用 posix_fallocate()（Thomas Munro）
§
PostgreSQL 版本 16 及更高版本将
使用 posix_fallocate()，如果平台提供
它，以扩展关系文件。然而，已报告此功能与某些文件系统
的兼容性较差：使用 posix_fallocate() 会禁用
BTRFS 压缩，并且 XFS 在较旧的 Linux 内核版本中可能会产生
虚假的 ENOSPC 错误。为提供解决方法，引入
这个新的服务器参数。将 file_extend_method
设置为 write_zeros 将使服务器返回到
通过写入零块来扩展文件的旧方法。
在 Windows 上支持 open() 的 O_CLOEXEC
标志 (Bryan Green, Thomas Munro)
§
§
§
使这个标志在 POSIX 平台上工作，以便我们
不会将文件句柄泄漏到子进程中，例如 COPY
TO/FROM PROGRAM。虽然这种泄漏并没有造成太多
问题，但似乎并不理想。
修复在 Solaris 可执行文件中解析长选项时的失败
（使用 meson 构建）（Tom Lane）
§
支持 GNU/Hurd 上的进程标题更改（Michael Banck）
§
修复 psql 的选项值
的选项补全功能（Yugo Nagata）
§
在 psql 命令提示符中，
当没有服务器连接时，不显示 %P（管道状态）的值
（Chao Li）
§
这使得 %P 的行为类似于其他提示转义
序列，其值依赖于活动连接。
修复 pg_dump 收集
序列值的逻辑（Nathan Bossart）
§
§
如果序列在转储时被并发删除，pg_dump
将失败，即使该序列不在要转储的数据库对象中。此外，
如果调用用户缺乏读取序列值的权限，pg_dump
将发出不正确的值，而不是按预期失败。
修复 pg_dump 对
oauth_validator_libraries 值的潜在错误引用
（ChangAo Chen）
§
pg_dump 如果需要转储此设置的值，
则应用了错误的引用规则。
避免在二进制升级模式下 pg_dump 的断言失败
（Vignesh C）
§
在对象排序代码中未能处理订阅关系对象触发了断言，
尽管在生产构建中没有严重的不良影响。
修复在管道模式下使用多个 \syncpipeline 命令时
pgbench 的错误处理（Yugo Nagata）
§
如果在查询错误后遇到多个 \syncpipeline 命令，
pgbench 将报告 “无法退出管道模式”，
或在启用断言的构建中触发断言失败。
使 pg_resetwal 在更改 OldestXID 时打印更新后的值
（Heikki Linnakangas）
§
它已经为每个可以更改的变量执行了此操作。
使 pg_resetwal 允许将下一个
multixact xid 设置为 0 或将下一个 multixact 偏移设置为 UINT32_MAX（Maxim
Orlov）
§
这些是有效值，因此拒绝它们是不正确的。在最坏的情况下，
如果在 multixact 包装点时尝试 pg_upgrade，则升级将失败。
在 contrib/amcheck 中，使用正确的快照
进行 btree 索引父检查（Mihail Nikalayeu）
§
§
之前的编码在检查使用 CREATE INDEX CONCURRENTLY 创建的索引时
导致了虚假错误。
修复 contrib/amcheck 以正确处理
“半死” btree 索引页面（Heikki Linnakangas）
§
amcheck 期望这样的页面有一个父下行链接，
但实际上没有，导致关于 “父键与子高键不匹配” 的虚假错误报告。
修复 contrib/amcheck 以正确处理
不完整的 btree 根页面拆分（Heikki Linnakangas）
§
amcheck 可能会报告关于 “块不是实际根” 的虚假错误。
修复 contrib/pg_buffercache 中的过度内存分配（David Geier）
§
该代码为 NUMA 页面状态分配了两倍于所需的内存。
修复 contrib/intarray 的选择性估算器中的边缘情况整数溢出
对于 @@（Chao Li）
§
这可能导致在涉及最大整数值的情况下产生较差的选择性估计。
修复 contrib/ltree 中的多字节编码问题
（Jeff Davis）
§
之前的编码可能会将不完整的多字节字符传递给
lower()，这可能导致不正确的
行为。
避免在 contrib/pg_stat_statements 中崩溃，
当 IN 列表同时包含常量和
非常量表达式时（Sami Imseih）
§
将时区数据文件更新为 tzdata
版本 2025c（Tom Lane）
§
唯一的变化是在 Baja California 的 1976 年之前的时间戳
的历史数据中。
上一页 上一级 下一页E.1. 版本 18.3 起始页 E.3. 版本 18.1
