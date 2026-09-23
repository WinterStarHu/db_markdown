# F.1. amcheck — 用于验证表和索引一致性的工具

F.1. amcheck — 用于验证表和索引一致性的工具
版本：
纠错本页面
搜索
目录导航
❮
❯
F.1. amcheck — 用于验证表和索引一致性的工具 #F.1.1. 函数F.1.2. 可选的heapallindexed验证F.1.3. 有效地使用amcheckF.1.4. 修复损坏
amcheck 模块提供的函数让用户验证关系结构的逻辑一致性。
B-树检查函数验证特定关系表示结构中的各种不变量。访问方法函数在索引扫描和其他重要操作中的正确性依赖于这些不变量始终成立。
例如，某些函数会验证所有 B-树页面中的条目是否按“逻辑”顺序排列（例如，对于基于text的 B-树索引，索引元组应按词汇排序顺序排列）。
如果该不变量以某种方式未能保持，我们可以预期受影响页面上的二分查找会错误地引导索引扫描，导致 SQL 查询返回错误结果。
如果结构看起来有效，则不会引发错误。在运行这些检查函数时，search_path会临时更改为pg_catalog,
pg_temp。
验证过程采用索引扫描自身使用的同种过程来执行，这些过程可能是用户定义的操作符类代码。
例如，B-树索引验证依赖于由一个或多个 B-树支持函数 1 例程构成的比较。操作符类支持函数的详情请见第 36.16.3 节。
不像通过提示错误来报告损坏的 B-树检查函数，堆检查函数verify_heapam检查表并尝试返回一组行，每次检测到损坏就返回一行。
尽管如此，如果verify_heapam依赖的工具本身已损坏，则函数可能无法继续，并且可能会引发错误。
执行amcheck函数的权限可以授予非超级用户，但在授予权限之前，应该仔细考虑数据的安全和隐私问题。
尽管这些函数生成的损坏报告侧重于数据的结构和发现的损坏性质，而不是被损坏数据的内容，
但获得执行这些函数权限的攻击者——尤其是当攻击者还能主动触发损坏时——
也许可以从这些消息中推断出数据本身的某些信息。
F.1.1. 函数 #
bt_index_check(index regclass, heapallindexed boolean, checkunique boolean) returns void
bt_index_check 测试其目标，一个 B-Tree 索引，是否遵守各种不变条件。用法示例：
test=# SELECT bt_index_check(index => c.oid, heapallindexed => i.indisunique),
c.relname,
c.relpages
FROM pg_index i
JOIN pg_opclass op ON i.indclass[0] = op.oid
JOIN pg_am am ON op.opcmethod = am.oid
JOIN pg_class c ON i.indexrelid = c.oid
JOIN pg_namespace n ON c.relnamespace = n.oid
WHERE am.amname = 'btree' AND n.nspname = 'pg_catalog'
-- 不检查临时表，这些表可能来自另一个会话：
AND c.relpersistence != 't'
-- 当省略此项时，函数可能会抛出错误：
AND c.relkind = 'i' AND i.indisready AND i.indisvalid
ORDER BY c.relpages DESC LIMIT 10;
bt_index_check |             relname             | relpages
----------------+---------------------------------+----------
| pg_depend_reference_index       |       43
| pg_depend_depender_index        |       40
| pg_proc_proname_args_nsp_index  |       31
| pg_description_o_c_o_index      |       21
| pg_attribute_relid_attnam_index |       14
| pg_proc_oid_index               |       10
| pg_attribute_relid_attnum_index |        9
| pg_amproc_fam_proc_index        |        5
| pg_amop_opr_fam_index           |        5
| pg_amop_fam_strat_index         |        5
(10 rows)
这个示例展示了一个会话，该会话对数据库 “test” 中的 10 个最大目录索引进行验证。对于唯一索引，要求验证堆元组是否作为索引元组存在。由于没有错误被抛出，所有被测试的索引似乎都是逻辑一致的。自然，这个查询可以很容易地更改为对数据库中每个支持验证的索引调用 bt_index_check。
bt_index_check 会在目标索引及其所属的堆关系上获取一个 AccessShareLock。这种锁模式与简单的 SELECT 语句在关系上获取的锁模式相同。
bt_index_check 不会验证跨子/父关系的不变量，但会在 heapallindexed 为 true 时，验证所有堆元组是否作为索引元组存在于索引中。
当 checkunique 为 true 时，bt_index_check 会检查唯一索引中重复条目中最多只有一个是可见的。当在生产环境中需要对损坏进行轻量级测试时，使用 bt_index_check 通常在验证的彻底性与限制对应用性能和可用性影响之间提供了最佳的权衡。
bt_index_parent_check(index regclass, heapallindexed boolean, rootdescend boolean, checkunique boolean) returns void
bt_index_parent_check 测试其目标，一个 B-Tree 索引，是否遵守各种不变条件。可选地，当 heapallindexed 参数为 true 时，函数会验证索引中应包含的所有堆元组的存在。当 checkunique 为 true 时，bt_index_parent_check 会检查唯一索引中重复条目中最多只有一个是可见的。当可选的 rootdescend 参数为 true 时，验证会通过从根页重新搜索每个元组，在叶子层重新定位元组。bt_index_parent_check 可以执行的检查是 bt_index_check 可执行检查的超集。bt_index_parent_check 可被视为 bt_index_check 的更彻底版本：与 bt_index_check 不同，bt_index_parent_check 还检查跨父子关系的不变条件，包括检查索引结构中是否存在缺失的下行链接。bt_index_parent_check 遵循一般约定，如果发现逻辑不一致或其他问题，则会引发错误。
ShareLock 是 bt_index_parent_check 对目标索引的要求（对堆关系也会获取一个 ShareLock）。这些锁阻止来自 INSERT、UPDATE 和 DELETE 命令的并发数据修改。这些锁同时防止底层关系被并发的 VACUUM 以及其他工具命令处理。注意该函数只在其运行期间而不是整个事务期间持有锁。
bt_index_parent_check 的额外验证更有可能检测到各种病理情况。这些情况可能涉及到被检查的索引使用的 B-Tree 操作类的错误实现，或者假设性地底层 B-Tree 索引访问方法代码中未发现的 bug。请注意，与 bt_index_check 不同，当启用热备模式（即在只读物理副本上）时，不能使用 bt_index_parent_check。
gin_index_check(index regclass) returns void
gin_index_check 测试目标 GIN 索引的父子元组关系是否一致
（没有父元组需要元组调整），以及页面图是否遵守平衡树不变量（内部页面只引用
叶子页面或只引用内部页面）。
提示
bt_index_check 和 bt_index_parent_check 都输出关于验证过程的日志信息，在DEBUG1 和 DEBUG2 严重性级别。 这些消息提供关于验证过程的详细信息，或许对PostgreSQL的开发人员有作用。高级用户也许会发现这些信息很有帮助，因为它提供了额外的上下文，以便在验证实际检测到不一致时使用。运行：
SET client_min_messages = DEBUG1;
在运行验证查询之前的交互式psql会话中，将显示有关验证进度的消息，并具有可管理级别的详细信息。
verify_heapam(relation regclass,
on_error_stop boolean,
check_toast boolean,
skip text,
startblock bigint,
endblock bigint,
blkno OUT bigint,
offnum OUT integer,
attnum OUT integer,
msg OUT text)
returns setof record
检查表、序列或物化视图的结构损坏，其中关系中的页面包含格式无效的数据，
以及逻辑损坏，其中页面在结构上有效但与集簇的其余部分不一致。
下述可选参数是可识别的：
on_error_stop
如果为真，则损坏检查将在被发现有任何损坏的第一个块的末尾停止。
默认为假。
check_toast
如果为真，toasted值根据目标关系的TOAST表进行检查。
这个选项已知是缓慢的。而且，如果toast表或它的索引损坏了，根据toast值检查它可能会使服务器宕机，虽然在一些情况下仅是产生一个错误。
默认为假(false)。
skip
如果不是 none，损坏检查会根据规定忽略被标示为全部可见或全部冻结的块。
有效的选项为 all-visible、all-frozen 和 none。
默认为 none。
startblock
如果已指定，则损坏检查从指定的块开始，忽略前面所有的块。指定 startblock 超出目标表的块的范围是一个错误。
默认情况下，检查从第一个块开始。
endblock
如果已指定，损坏检查在指定的块结束，忽略所有剩余的块。指定 endblock 超出目标表的块的范围是一个错误。
默认情况下，所有块都被检查。
对每个检测到的损坏情况， verify_heapam 返回一行包含下述列：
blkno
包含损坏页的块编号。
offnum
损坏元组的 OffsetNumber。
attnum
如果损坏是特定于某列而不是整个元组，则为元组中损坏列的属性号。
msg
描述检测到的问题的消息。
F.1.2. 可选的heapallindexed验证 #
当 heapallindexed 参数为 B-Tree 验证函数的
true 时，将对与目标索引关系关联的表执行额外的验证阶段。
该阶段包括一个“模拟”的 CREATE INDEX CONCURRENTLY
操作，通过临时的内存摘要结构（在验证的基本第一阶段需要时构建）来检查所有
假设的新索引元组的存在性。该摘要结构对目标索引中找到的每个元组进行
“指纹”识别。heapallindexed
验证背后的高层原则是：等价于现有目标索引的新索引必须只包含能在现有结构中
找到的条目。
额外的heapallindexed阶段会增加明显的开销：验证的时间通常将会延长几倍。不过，在执行heapallindexed验证时，所要求的关系级锁没有变化。
这一汇总结构的尺寸以maintenance_work_mem为界。为了确保对于每个堆元组应该存在于索引中这一检测有不超过2%的失效概率能检测到不一致，每个元组需要大约2个字节的内存。因为每个元组可用的内存变少，错失一处不一致的概率就会慢慢增加。这种方法显著地限制了验证的开销，但仅仅略微降低了检测到问题的概率，对于将验证当作例行维护任务的安装来说更是如此。对于每一次新的验证尝试，任何单一的缺失或者畸形元组都有新的机会被检测到。
F.1.3. 有效地使用amcheck #
amcheck 能有效检测数据校验和
无法捕捉到的各类故障模式，包括：
由不正确的操作符类实现导致的结构不一致。
这包括操作系统排序规则的比较规则发生变化所引起的问题。可排序类型（如
text）的数据项比较必须是不可变的（就像所有用于 B-Tree
索引扫描的比较一样），这意味着操作系统排序规则绝不能改变。虽然很少见，
但操作系统排序规则的更新可能导致这类问题。更常见的情况是主服务器与备服务器
之间排序规则顺序不一致，这可能是因为所使用的操作系统主要
版本不一致。此类不一致通常只会在备服务器上出现，因此通常只能在备服务器上检测到。
如果出现此类问题，不一定会影响使用受影响排序规则排序的每个索引，
因为被索引的值可能恰好具有相同的绝对顺序，
与行为不一致无关。有关 PostgreSQL
如何使用操作系统本地化和排序规则的更多详情，请参阅
第 23.1 节 和 第 23.2 节。
索引与被索引的堆关系之间的结构不一致（在执行
heapallindexed 验证时）。
正常操作期间不会对索引与其堆关系进行交叉检查。堆损坏的症状可能非常隐蔽。
底层 PostgreSQL 访问方法代码、排序代码或事务管理代码中
存在的假设性未发现漏洞所导致的损坏。
对索引结构完整性的自动验证在对新的或拟议的 PostgreSQL
功能进行一般测试时发挥着重要作用，这些功能可能会引入逻辑不一致性。对表结构
及相关可见性和事务状态信息的验证也起着类似作用。一个明显的测试策略是在运行
标准回归测试时持续调用 amcheck 函数。运行测试的详细信息
请参阅 第 31.1 节。
当数据校验和被禁用时，文件系统或存储子系统出现故障。
请注意，如果访问块时只有共享缓冲区命中，amcheck
在验证时检查的是共享内存缓冲区中表示的页面。因此，amcheck
不一定在验证时检查从文件系统读取的数据。请注意，当启用校验和时，
如果将损坏的块读入缓冲区，amcheck 可能会因校验和失败而报错。
由故障 RAM 或更广泛的内存子系统导致的损坏。
PostgreSQL 不防范可纠正的内存错误，假定您将使用符合
行业标准纠错码（ECC）或更强保护的 RAM。但是，ECC 内存通常只能免疫单比特错误，
不应假定其能提供绝对的内存损坏防护。
执行 heapallindexed 验证时，通常会大大提高检测单比特错误的
概率，因为会进行严格的二进制相等性测试，并对堆中的被索引属性进行测试。
由于有故障的存储硬件，或者关系文件被不相关的软件覆盖或修改，可能会发生结构损坏。
这类损坏也可以通过数据页校验和来检测。
格式正确、内部一致并且相对于其内部校验和正确的关系页依然可能包含逻辑损坏。
因此，这类损坏不能被checksums所检测到。
例如包括主表中的toasted值在toast表中缺少相应的条目，以及主表中具有比数据库或集簇中最古老的有效Transaction ID更旧的Transaction ID的元组。
在生产系统中已经观察到多个导致逻辑损坏的原因，包括PostgreSQL服务器软件中的缺陷、错误且考虑不周的备份和恢复工具，以及用户错误。
在实时生产环境中，损坏关系是最令人担忧的，而这样的环境中是最不欢迎高风险活动的。
基于此原因，设计了verify_heapam以在无过度风险的情况下诊断损坏。
它不能保证防止后端崩溃的所有原因，因为在严重损坏的系统上，即使执行调用查询也可能不安全。
执行对catalog tables的访问，如果目录自身损坏了，也可能会出现问题。
通常，amcheck仅能证明损坏的存在，但它无法证明损坏不存在。
F.1.4. 修复损坏 #
amcheck没有产生与损坏相关的错误绝不应该被当做假阳性。amcheck会在（定义上）应该绝不会发生的情况中抛出错误，因此常常需要对amcheck错误进行仔细分析。
对于amcheck检测到的问题没有一般性的修复方法。应该寻找产生不变条件违背的根本原因。在诊断amcheck检测到的损坏时，pageinspect可能会扮演一个非常有用的角色。REINDEX在修复损坏过程中可能无法起到效果。
上一页 上一级 下一页附录 F. 附加提供的模块和扩展 起始页 F.2. auth_delay — 认证失败时的暂停
