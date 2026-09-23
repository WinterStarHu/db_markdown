# 63.2. 索引访问方法函数

63.2. 索引访问方法函数
版本：
纠错本页面
搜索
目录导航
❮
❯
63.2. 索引访问方法函数 #
索引访问方法必须在IndexAmRoutine中提供的索引构造和维护函数有：
IndexBuildResult *
ambuild (Relation heapRelation,
Relation indexRelation,
IndexInfo *indexInfo);
构建一个新的索引。索引关系已经在物理上创建，但目前为空。
必须用访问方法所需的固定数据填充它，以及表中所有已存在元组的条目。
通常，ambuild函数会调用table_index_build_scan()来扫描表中
已存在的元组，并计算需要插入索引的键值。
该函数必须返回一个palloc分配的结构体，包含有关新索引的统计信息。
amcanbuildparallel标志指示访问方法是否支持并行索引构建。
当设置为true时，系统将尝试为构建分配并行工作者。
仅支持非并行索引构建的访问方法应将此标志保持为false。
void
ambuildempty (Relation indexRelation);
构建一个空索引，并将其写入给定关系的初始化分叉中（INIT_FORKNUM）。
该方法仅在不记录日志的索引上调用；写入初始化分叉的空索引将在每次服务器重启时
被复制到主关系分叉中。
bool
aminsert (Relation indexRelation,
Datum *values,
bool *isnull,
ItemPointer heap_tid,
Relation heapRelation,
IndexUniqueCheck checkUnique,
bool indexUnchanged,
IndexInfo *indexInfo);
向现有索引插入一个新元组。values和isnull数组给出需要被索引的键值，而heap_tid是要被索引的 TID。
如果该访问方法支持唯一索引（它的amcanunique标志为真），那么checkUnique指示要执行的唯一性检查类型。
这根据唯一约束是否为可推迟的而变化，详见第 63.5 节。
通常在执行唯一性检查时访问方法仅需要heapRelation参数（因为那时它将不得不到堆中验证元组的存活性）。
indexUnchanged布尔值提供了有关要索引的元组性质的提示。当它为真时，该元组是索引中某个现有元组的副本。
新元组是逻辑上未更改的后继MVCC元组版本。当发生不修改索引覆盖的任何列但仍需要索引中的新版本的UPDATE时会发生这种情况。
索引AM可以使用此提示来决定在许多相同逻辑行的版本累积的索引部分应用自底向上的索引删除。请注意，更新非键列或仅出现在部分索引谓词中的列不会影响indexUnchanged的值。
核心代码使用低开销方法确定每个元组的indexUnchanged值，允许出现假阳性和假阴性。索引AM不得将indexUnchanged视为有关元组可见性或版本控制的权威信息来源。
该函数的布尔结果值仅在checkUnique为UNIQUE_CHECK_PARTIAL时才有意义。这种情况下一个“真”结果意味着这个新项是已知唯一的，反之“假”结果意味着它可能不是唯一的（并且一个延迟的唯一性检查必须是预定的）。对于其他情况，建议使用一个常量“假”结果。
有些索引可能不会索引所有元组。如果元组不被索引，aminsert应该仅返回而什么都不做。
如果索引AM希望在SQL语句中的连续索引插入操作之间缓存数据，
它可以在indexInfo->ii_Context中分配空间，
并将指向数据的指针存储在indexInfo->ii_AmCache中
（初始值为NULL）。如果除了内存之外的资源需要在索引插入后释放，
可以提供aminsertcleanup，该函数将在释放内存之前调用。
void
aminsertcleanup (Relation indexRelation,
IndexInfo *indexInfo);
清理在连续插入过程中维护的状态，存储于indexInfo->ii_AmCache中。
当数据需要额外的清理步骤（例如，释放固定的缓冲区）时，这非常有用，
而仅仅释放内存是不够的。
IndexBulkDeleteResult *
ambulkdelete (IndexVacuumInfo *info,
IndexBulkDeleteResult *stats,
IndexBulkDeleteCallback callback,
void *callback_state);
从索引中删除元组。这是一个“批量删除”操作，它的意图是通过扫描整个索引并检查每个项看它是否需要被删除。
被传递进来的callback函数必须被调用（调用风格是：callback(TID, callback_state) returns bool）来判断任何其引用的 TID 标识的索引项是否需要删除。必须返回 NULL 或者是一个 palloc 过的、 包含删除操作效果的统计信息的结构。如果不需要向amvacuumcleanup传递信息，返回 NULL 也是 OK 的。
由于maintenance_work_mem被限制，在删除多行的时候ambulkdelete可能需要被调用多次。stats参数是对这个索引上一次调用的结果（在一个VACUUM操作中第一次调用时是 NULL）。这将允许 AM 在整个操作过程中积累统计信息。典型的，如果被传递的stats非空，ambulkdelete将会修改并返回相同的结构。
IndexBulkDeleteResult *
amvacuumcleanup (IndexVacuumInfo *info,
IndexBulkDeleteResult *stats);
在一个VACUUM操作（零个或更多次ambulkdelete调用）后清空。虽然不必做任何返回索引统计信息之外的事情，但是它可能执行批量清理，例如回收空索引页面。stats是最后一次ambulkdelete 调用返回的东西或者 NULL（如果没有元组需要删除而未调用ambulkdelete）。如果结果不是 NULL，那么它必须是一个已经被 palloc 的结构。它包含的统计信息将用于更新pg_class并且由VACUUM报告（如果给出了VERBOSE）。如果索引在VACUUM操作期间根本没有改变，那么返回 NULL 也是可以的，否则必须返回正确的统计信息。
amvacuumcleanup将也会在一个ANALYZE操作结束时被调用。这种情况中stats总是 NULL 并且任何返回值都将会被忽略。这种情况可以通过检测info->analyze_only来区分。我们建议，在这样的调用中访问方法除了做插入后的清理之外什么也不做，并且那是仅仅是在一个自动清理工作者进程中。
bool
amcanreturn (Relation indexRelation, int attno);
通过返回型为一个IndexTuple的索引项的被索引列值，检查索引是否能在给定列上支持只用索引的扫描。属性编号从 1 开始编号，即第一列的 attno 是 1。如果支持返回 true，否则返回 false。
对于包含列（如果支持），此函数将始终返回 true，因为包含列不能被检索是没有意义的。
如果访问方法完全不支持只用索引的扫描，其IndexAmRoutine结构中的amcanreturn域可以被设置为 NULL。
void
amcostestimate (PlannerInfo *root,
IndexPath *path,
double loop_count,
Cost *indexStartupCost,
Cost *indexTotalCost,
Selectivity *indexSelectivity,
double *indexCorrelation,
double *indexPages);
估计一次索引扫描的开销。这个函数在下面的第 63.6 节中有完整的讨论。
int
amgettreeheight (Relation rel);
计算树形索引的高度。此信息提供给
amcostestimate 函数中的
path->indexinfo->tree_height，可用于支持
成本估算。结果不会在其他地方使用，因此此
函数实际上可以用于计算成本估算函数可能想要了解的
关于索引的任何类型的数据（适合整数）。如果计算代价高，
将结果缓存为 RelationData.rd_amcache 的一部分可能会有用。
bytea *
amoptions (ArrayType *reloptions,
bool validate);
分析和验证一个索引的 reloptions 数组。仅当一个索引存在非空 reloptions 数组时才会被调用。reloptions是一个text数组，包含name=value形式的项。 该函数应当构建一个bytea值，该值将被拷贝进索引的 relcache 项的rd_options域。bytea值的数据内容是开放由访问方法定义的， 大部分的标准访问方法都使用StdRdOptions结构。当validate为真时，如果任何一个选项都不可识别或者含有非法值，该函数都应当报告一个适当的错误消息；当validate为假时，非法项应该被安静地忽略（当正在载入的选项已经在pg_catalog中时， validate为假；仅在访问方法已经改变了选项的规则时才可能找到非法项，并且在此情况下忽略废弃的项是合适的）。如果想要默认行为，那么返回 NULL 也可以。
bool
amproperty (Oid index_oid, int attno,
IndexAMProperty prop, const char *propname,
bool *res, bool *isnull);
amproperty方法允许索引访问方法覆盖pg_index_column_has_property和相关函数的默认行为。如果访问方法对于索引属性查询没有特殊的行为，其IndexAmRoutine结构的amproperty字段可以被设置为 NULL。否则，对于pg_indexam_has_property调用会使用均为 0 的index_oid和attno参数来调用amproperty方法；对于pg_index_has_property调用会使用有效的index_oid和为 0 的attno参数来调用amproperty方法；对于pg_index_column_has_property调用会使用有效的index_oid以及大于零的attno参数来调用amproperty方法。prop是用于标识被测试属性的枚举值，而propname是原始的属性名称字符串。如果核心代码不能识别该属性名称，则prop为AMPROP_UNKNOWN。访问方法可以通过检查propname是否匹配（为与核心代码一致，使用pg_strcasecmp来匹配）来定义自定义属性名称；对于核心代码已知的名称，最好检查prop。
如果amproperty方法返回true则表示它已经确定了属性测试的结果：它必定会设置*res为要返回的布尔值，如果要返回 NULL 则设置*isnull为true（两个被引用的变量在调用之前要被初始化为false）。如果amproperty方法返回false则核心代码将会用其通常的逻辑来确定属性测试的结果。
支持排序操作符的访问方法应该实现AMPROP_DISTANCE_ORDERABLE属性测试，因为核心代码不知道如何做该测试并且会返回 NULL。如果有比打开索引并调用amcanreturn（这是核心代码的默认行为）更廉价的方法来做AMPROP_RETURNABLE测试，最好也实现它。默认行为应该对所有其他标准属性是符合要求的。
char *
ambuildphasename (int64 phasenum);
返回给定构建阶段编号的文本名称。
阶段编号是在通过pgstat_progress_update_param接口构建索引期间报告的。
然后阶段名称在pg_stat_progress_create_index视图中公开。
bool
amvalidate (Oid opclassoid);
只要访问方法能够，为指定的操作符类验证系统目录项。例如，这可能包括所有所需支持函数的提供测试。如果该 opclass 不合法，amvalidate函数必须返回假。所存在的问题应由ereport消息报告，通常情况下在 INFO 级。
void
amadjustmembers (Oid opfamilyoid,
Oid opclassoid,
List *operators,
List *functions);
访问方法在合理可能的情况下验证提议的新运算符族的运算符和函数成员，并在默认值不足时设置依赖类型。这在执行期间CREATE OPERATOR CLASS调用 ALTER OPERATOR FAMILY ADD；在后一种情况下，opclassoid是InvalidOid。List参数是amapi.h中定义的OpFamilyMember结构的列表。
此函数执行的测试通常是由amvalidate执行的测试的子集，因为amadjustmembers不能假设观察到所有成员集。例如，验证支持函数调用的形式是合理的，但不能验证是否提供了所有必需的支持函数。任何问题都会导致错误。
OpFamilyMember结构的依赖字段在CREATE OPERATOR CLASS的情况下由核心代码初始化为对opclass的硬依赖；在ALTER OPERATOR FAMILY ADD的情况下初始化为对opfamily的软依赖。如果其他行为更合适，amadjustmembers可以调整这些字段。例如，GIN、GiST和SP-GiST等索引类型总是将运算符成员设置为对opfamily的软依赖，因为运算符与opclass之间的连接在这些索引类型中相对较弱；因此，允许运算符成员自由添加和删除是合理的。可选的支持函数通常也会被赋予软依赖，以便在必要时可以将其删除。
当然，索引的目的是支持扫描那些匹配一个可索引WHERE条件的元组，常常也被称为限定词或扫描键。索引扫描的语义在下面的第 63.3 节中有完整的描述。一个索引访问方法可以支持“普通”索引扫描、“位图”索引扫描或者两者。一个索引访问方法必须或可能提供的与扫描相关的函数是：
IndexScanDesc
ambeginscan (Relation indexRelation,
int nkeys,
int norderbys);
为一个索引扫描做准备。nkeys和norderbys参数说明要被用在扫描中的条件和排序操作符的数目，它们可以用于空间分配目的。注意扫描键的实际值还没有被提供。结果必须是一个 palloc 过的结构。由于实现的原因，索引访问方法必须通过调用RelationGetIndexScan()来创建这个结构。在大多数情况下，ambeginscan除了做这个调用和获取锁之外不会做很多工作，索引扫描启动中有趣的部分在amrescan中。
void
amrescan (IndexScanDesc scan,
ScanKey keys,
int nkeys,
ScanKey orderbys,
int norderbys);
开始或者重新开始一个索引扫描，可能使用的是一个新的扫描键（要想使用之前传递的键重新开始，给keys和/或orderbys传递 NULL）。请注意，使用的键或排序操作符的个数不能大于传递给ambeginscan的个数。实际上这个重新开始特性的使用场景是：在一个嵌套循环连接选取了一个新的 outer 元组时，因此需要一个新的键比较值，但扫描键结构仍然保持相同。
bool
amgettuple (IndexScanDesc scan,
ScanDirection direction);
在给定扫描中取下一个元组，向给定方向移动（在索引中向前或者向后）。如果取到了元组，则返回 true，如果没有匹配的元组，则返回 false。在 true 的情况下，该元组的 TID 被存储在scan结构中。请注意“成功”只意味着索引包含一个匹配扫描键的项，并不意味着该元组仍然在堆中存在，或者能够通过调用者的快照测试。在成功时，amgettuple也必须把scan->xs_recheck设置成 true 或者 false。false 意味着它确定索引项匹配扫描键。true 意味着它并不确定，而且必须在取得堆元组之后对它重新检查扫描键表示的条件。这条规定支持“有损的”索引操作符。注意重新检查仅仅对扫描条件扩展；一个部分索引谓语（如果有）从不被amgettuple调用者重新检查。
如果索引支持只用索引扫描（即amcanreturn对其任何一列返回 true），则在成功时 AM 也必须检查scan->xs_want_itup，并且如果检查为真它必须返回索引项的原始被索引数据。amcanreturn返回 false 的列可以作为 null 返回。该数据的返回形式可以是一个存储在scan->xs_itup中的IndexTuple指针外加元组描述符scan->xs_itupdesc，或者是一个存储在scan->xs_hitup中的HeapTuple指针外加元组描述符scan->xs_hitupdesc（在重构可能无法放在一个IndexTuple中的数据时，应该使用后一种格式）。不管是哪种形式，访问方法应该负责管理好指针引用的数据。至少在为扫描下一次调用amgettuple、amrescan或amendscan之前，该数据必须是完好的。
如果访问方法支持“普通”索引扫描，只需要提供amgettuple函数。如果不支持，它的IndexAmRoutine结构的amgettuple域必须被设置为 NULL。
int64
amgetbitmap (IndexScanDesc scan,
TIDBitmap *tbm);
在给定扫描中取所有元组并且把它们添加到调用者提供的TIDBitmap中（即，把元组 ID 的集合 OR 到已经存在于位图中的东西里面）。返回被取得的元组的数量（这可能仅仅是一个近似计数，例如一些 AM 不会去重）。在把元组 ID 插入到位图时，amgetbitmap可以指明对指定元组 ID 要求重新检查扫描条件。这与amgettuple的xs_recheck输出参数类似。注意：在当前的实现中，这个特性的支持是和对位图本身有损存储的支持合并在一起的，并且调用者会对可重新检查的元组检查扫描条件和部分索引谓词（如果有）。但是，那不会总是真的。amgetbitmap和amgettuple不能被用于同一个索引扫描；正如第 63.3 节中所解释的，在使用amgetbitmap时也有其他的限制条件。
如果访问方法支持“bitmap”索引扫描，则仅需要提供amgetbitmap函数。如果不支持，它的IndexAmRoutine结构中的amgetbitmap域必须被设置为 NULL。
void
amendscan (IndexScanDesc scan);
结束扫描并释放资源。不应该释放scan结构本身，但访问方法内部使用的任何锁或者 pin 都应该被释放，以及ambeginscan和其他扫描相关函数分配的任何其他内存。
void
ammarkpos (IndexScanDesc scan);
标记当前扫描位置。访问方法只需要支持每个扫描里面有一个被记住的扫描位置。
ammarkpos函数只有在访问方法支持有序扫描时才需要提供。如果不支持，则访问方法的ammarkpos域可以设置为 NULL。
void
amrestrpos (IndexScanDesc scan);
将扫描恢复到最近标记的位置。
amrestrpos函数只有在访问方法支持有序扫描时才需要提供。如果不支持，则访问方法的amrestrpos域可以设置为 NULL。
除了支持普通的索引扫描之外，某些类型的索引可能希望支持并行索引扫描，这种方式允许多个后端合作来执行一次索引扫描。索引访问方法应该安排好各种事情，这样每个参与合作的进程才能返回原本会由普通非并行索引扫描执行得到的元组的一个子集，但是得到的那些子集的并集应该等于普通非并行索引扫描得到的元组集合。此外，虽然不需要并行扫描返回的元组有任何全局顺序，但每个参与合作的后端中返回的元组子集的顺序必须匹配所要求的顺序。必须实现下列函数才能支持并行索引扫描：
Size
amestimateparallelscan (Relation indexRelation,
int nkeys,
int norderbys);
估算并返回访问方法执行并行扫描所需的动态共享内存字节数。 （此数字是额外的，不是替代 ParallelIndexScanDescData 中需要的 AM 独立数据的空间。）
nkeys 和 norderbys 参数表示将在扫描中使用的限定符和排序操作符的数量；相同的值将传递给 amrescan。注意，扫描键的实际值尚未提供。
对于不支持并行扫描或者额外存储需求的字节数为零的访问方法，无需实现这个函数。
void
aminitparallelscan (void *target);
在一次并行扫描的开头将调用这个函数来初始化动态共享内存。target将指向一段动态共享内存空间，其大小至少为之前amestimateparallelscan返回的字节数，并且这个函数可以使用这部分空间来存放它希望存放的任何数据。
对于不支持并行扫描或者不要求初始化共享内存空间的情况，无需实现这个函数。
void
amparallelrescan (IndexScanDesc scan);
如果实现了这个函数，当并行索引扫描必须被重启时，将会调用这个函数。它应该重置由aminitparallelscan建立的任何共享状态，这样扫描将会被重头重新开始。
CompareType
amtranslatestrategy (StrategyNumber strategy, Oid opfamily, Oid opcintype);
StrategyNumber
amtranslatecmptype (CompareType cmptype, Oid opfamily, Oid opcintype);
如果实现了这些函数，规划器和执行器将调用它们
以在固定的 CompareType 值和访问方法使用的特定
策略编号之间进行转换。这些函数可以由实现类似于
内置 btree 或哈希访问方法功能的访问方法实现，通过实现这些
转换，系统可以了解访问方法操作的语义，并可以在
各种地方用它们替代 btree 或哈希索引。如果访问方法的功能
与这些内置访问方法不相似，则不需要实现这些函数。
如果未实现这些函数，访问方法将在某些规划器和执行器决策中被忽略，
但在其他方面仍然完全功能。
上一页 上一级 下一页63.1. 索引的基本 API 结构 起始页 63.3. 索引扫描
