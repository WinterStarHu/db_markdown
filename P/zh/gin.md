# 65.4. GIN 索引

65.4. GIN 索引
版本：
纠错本页面
搜索
目录导航
❮
❯
65.4. GIN 索引 #65.4.1. 简介65.4.2. 内置操作符类65.4.3. 可扩展性65.4.4. 实现65.4.5. GIN 提示和技巧65.4.6. 限制65.4.7. 示例65.4.1. 简介 #
GIN意思是通用倒排索引。GIN被设计为处理被索引项为组合值的情况，并且这种索引所处理的查询需要搜索出现在组合项中的元素值。例如，项可以是文档，并且查询可以是搜索包含指定词的文档。
我们使用词项来表示要被索引的一个组合值，并且用词键来表示一个元素值。GIN总是存储和搜索键，而不是项值本身。
一个GIN索引存储一个（键，位置列表）对的集合，这里一个posting list是键在其中出现的一个行 ID 的集合。相同的行 ID 可以出现在多个位置列表中，因为一个项可以包含多于一个键。每个键值只被存储一次，因此对于同一个键出现多次的情况，一个GIN索引是非常紧凑的。
GIN访问方法代码不需要知道它所加速的具体操作，从这个意义上来说，GIN是通用的。相反，它使用为特定数据类型定义的自定义策略。策略定义如何从被索引项和查询条件中抽取键，并且如何决定一个包含查询中某些键值的行是否真正满足查询。
GIN的一个优点是它允许由数据类型的领域专家开发有合适访问方法的自定义数据类型，而不是让一个数据库专家来做这件事。在这一点上很像GiST。
PostgreSQL中的GIN实现主要由 Teodor Sigaev 和 Oleg Bartunov 维护。在他们的网站上有更多关于GIN的信息。
65.4.2. 内置操作符类 #
PostgreSQL的核心发布包括表 65.3
中所示的GIN操作符类（附录 F中描述的一些
可选模块提供了额外的GIN操作符类）。
表 65.3. 内置GIN操作符类NameIndexable Operatorsarray_ops&& (anyarray,anyarray)@> (anyarray,anyarray)<@ (anyarray,anyarray)= (anyarray,anyarray)jsonb_ops@> (jsonb,jsonb)@? (jsonb,jsonpath)@@ (jsonb,jsonpath)? (jsonb,text)?| (jsonb,text[])?& (jsonb,text[])jsonb_path_ops@> (jsonb,jsonb)@? (jsonb,jsonpath)@@ (jsonb,jsonpath)tsvector_ops@@ (tsvector,tsquery)
在两种用于类型jsonb的操作符类中，jsonb_ops是默认项。
jsonb_path_ops支持较少的操作符，但为那些操作符提供了更好的性能。
详见第 8.14.4 节。
65.4.3. 可扩展性 #
GIN接口有一个高层次的抽象，要求访问方法实现者只需要实现数据类型被访问的语义。GIN层本身会处理并发、日志和搜索树结构的事务。
要让一个GIN访问方法工作起来所要做的全部事情就是实现一些用户定义的方法，它们定义了树中键的行为以及键、被索引项以及可索引查询之间的关系。简而言之，GIN的可扩展性结合了通用性、代码重用和一个干净的接口。
一个用于GIN的操作符类必须提供的两种方法是：
Datum *extractValue(Datum itemValue, int32 *nkeys,
bool **nullFlags)
给定一个要被索引的项，返回一个 palloc 过的键的数组。被返回的键的数量必须被存储在*nkeys中。如果键中的任意一个可能为空，还要 palloc 一个*nkeys 个bool域的数组，将它的地址存储在*nullFlags中，并且根据需要设置这些空值标志。如果所有的键都非空，*nullFlags可以被留成NULL（其初始值）。如果该项不包含键，返回值可以为NULL。
Datum *extractQuery(Datum query, int32 *nkeys,
StrategyNumber n, bool **pmatch, Pointer **extra_data,
bool **nullFlags, int32 *searchMode)
给定一个要被查询的值，返回一个 palloc 过的键的数组。即query是一个可索引操作符（左手边是被索引列）的右手边的值。n是操作符类中操作符的策略号（见第 36.16.2 节）。通常，extractQuery将需要参考n来判断query的数据类型以及它应该用什么方法来抽取键值。被返回的键的数量必须被存储在*nkeys中。如果键中的任意一个可能为空，还要 palloc 一个*nkeys 个bool域的数组，将它的地址存储在*nullFlags中，并且根据需要设置这些空值标志。如果所有的键都非空，*nullFlags可以被留成NULL（其初始值）。如果该项不包含键，返回值可以为NULL。
searchMode是一个输出参数，它允许extractQuery指定有关搜索如何被完成的细节。如果*searchMode被设置为GIN_SEARCH_MODE_DEFAULT（这是在被调用之前它被初始化的值），只有那些匹配至少一个被返回键的项才会被考虑作为候选匹配。如果*searchMode被设置为GIN_SEARCH_MODE_INCLUDE_EMPTY，那么除了至少包含一个匹配键的项之外，根本不包含键的项也被考虑作为候选匹配（例如，这种模式对于实现“是...的子集”操作符有用）。如果*searchMode被设置为GIN_SEARCH_MODE_ALL，那么索引中所有非空项都被考虑作为候选匹配，不管它们是否匹配被返回的键（这种模式比其他两种选择要慢很多，但是它对于正确实现极端情况可能是必要的。需要这种模式的操作符在大部分情况下可能并不是一个 GIN 操作符类的好选择）。用于设置这个模式的符号被定义在access/gin.h中。
pmatch是一个输出参数，它用于在部分匹配被支持时使用。要用它，extractQuery必须分配一个*nkeys个布尔值的数组，并且把它的地址存储在*pmatch中。如果一个键要求部分匹配，该数组的对应元素应该被设置为 TRUE，否则设置为 FALSE。如果*pmatch被设置为NULL，则 GIN 假定不需要部分匹配。在调用前，该变量被初始化为NULL，这样这个参数可以简单地被不支持部分匹配的操作符类忽略。
extra_data是一个输出参数，它允许extractQuery传递额外数据给consistent和comparePartial方法。要用它，extractQuery必须分配一个*nkeys个指针的数组，并且把它的地址存储在*extra_data中，然后把任何它想存储的东西存到单个指针中。在调用前该变量被初始化为NULL，这样这个参数可以简单地被不需要额外数据的操作符类忽略。如果*extra_data被设置，整个数组被传递给consistent方法，并且适当的元素会被传递给comparePartial方法。
一个操作符类必须提供一个函数检查一个被索引的项是否匹配查询。有两种形式，
一个布尔函数consistent，以及一个三元函数triConsistent。
triConsistent覆盖了两者的功能，因此提供triConsistent一个足矣。但是，
如果布尔变体的计算代价要更低，两者都提供就会有好处。如果只提供布尔变体，
一些基于在取得所有键之前拒绝索引项的优化将会被禁用。
bool consistent(bool check[], StrategyNumber n, Datum query,
int32 nkeys, Pointer extra_data[], bool *recheck,
Datum queryKeys[], bool nullFlags[])
如果一个被索引项满足（如果重新检查指示被返回，则表示可能满足）有策略号n的查询操作符，则返回 TRUE。这个函数并没有直接访问被索引项的值，因为GIN没有显式存储项。可用的是关于哪些从查询抽取出的键值出现在一个给定被索引项中的知识。check数组的长度是nkeys，它和前面由extractQuery为这个查询数据返回的键的数目相同。
如果被索引项包含一个查询键，那么check数组的对应元素为 TRUE，即如果 (check[i] == TRUE) ，则extractQuery结果数组的第 i 个键存在于被索引项中。在consistent方法需要参考原始query数据的情况中，它会被传递进来，前面由extractQuery返回的queryKeys[]和nullFlags[]数组也一样。extra_data是由extractQuery返回的额外数据数组，如果没有额外数据则为NULL。
当extractQuery在queryKeys[]中返回一个空值键时，如果被索引项包含一个空值键则对应的check[]元素为 TRUE。即，check[]的语义类似IS NOT DISTINCT FROM。如果consistent函数需要说出一个常规值匹配和一个空值匹配之间的区别，它可以检查对应的nullFlags[]元素。
在成功时，如果堆元组需要根据查询操作符被重新检查，则*recheck应该被设置为 TRUE，或者如果索引测试是准确的则设置为 FALSE。即，一个 FALSE 返回值保证堆元组不匹配查询；一个 TRUE 返回值以及设置为 FALSE 的*recheck保证堆元组匹配查询；并且一个 TRUE 返回值和设置为 TRUE 的*recheck表示堆元组可能匹配查询，因此它需要被取出并且通过在原始的被索引项上计算查询操作符来重新检查。
GinTernaryValue triConsistent(GinTernaryValue check[], StrategyNumber n, Datum query,
int32 nkeys, Pointer extra_data[],
Datum queryKeys[], bool nullFlags[])
triConsistent类似于consistent，
但和check[]中的布尔值不同，对每个键有三种可能值：
GIN_TRUE、GIN_FALSE和GIN_MAYBE。
GIN_FALSE和GIN_TRUE具有和常规布尔值相同的含义，
而GIN_MAYBE意味着键的存在未知。当GIN_MAYBE值出现时，
如果项必定匹配（不管该索引项是否包含对应的查询键），该函数应该只返回GIN_TRUE。
同样地，如果项必定不匹配（不管它是否包含GIN_MAYBE），
该函数必须只返回GIN_FALSE。
如果结果依赖于GIN_MAYBE项，即无法根据已知查询键确认或拒绝匹配，
该函数必须返回GIN_MAYBE。
当在check向量中没有GIN_MAYBE值时，
GIN_MAYBE返回值等效于在布尔函数consistent中设置
recheck标志等效。
此外，GIN必须有方法能排序存储在索引中的键值。操作符类可以通过指定一种比较方法来定义排序顺序：
int compare(Datum a, Datum b)
比较两个键（不是被索引项！）并且返回一个整数，该整数为小于零、等于零或者大于零分别表示第一个键小于、等于或者大于第二个键。空值键绝不会被传递给这个函数。
或者，如果操作符类不提供compare方法，GIN将查看索引键数据类型的默认btree操作符类，并且使用它的比较函数。推荐为只用于一种数据类型的GIN操作符类指定这个比较函数，因为查找btree操作符类需要消耗一些周期。不过，多态的GIN操作符类（例如array_ops）通常无法指定单一的比较函数。
一个用于GIN的操作符类可以选择性的提供下列方法：
int comparePartial(Datum partial_key, Datum key, StrategyNumber n,
Pointer extra_data)
比较一个部分匹配键和一个索引键。返回一个整数，其符号指示结果：小于零表示索引键不匹配查询，但是索引扫描应该继续；零表示索引键匹配查询；大于零表示索引扫描应该停止，因为没有更多可能的匹配。产生该部分匹配查询的操作符的策略号n将被提供，可以通过其语义决定什么时候结束扫描。还有，extra_data是由extractQuery产生的额外数据数组中的对应元素，如果没有则为NULL。空值不会被传递给这个函数。
void options(local_relopts *relopts)
定义一组用户可见的参数以控制操作符类的行为。
options 函数传递一个指针到一个local_relopts结构，该结构需要用一组特定的操作符类的选项来填充。
该选项可以使用PG_HAS_OPCLASS_OPTIONS()和PG_GET_OPCLASS_OPTIONS()宏，从其他支持的函数进行访问。
由于索引值的键提取和键在GIN中的表示都是灵活的，它们可能取决于用户指定的参数。
要支持“部分匹配”查询，一个操作符类必须提供comparePartial方法，并且它的extractQuery方法必须在遇到一个部分匹配查询时设置pmatch参数。详见第 65.4.4.2 节。
上面提到的多个Datum值的实际数据类型随着操作符类而变化。
被传递给extractValue的项值总是操作符类的输入类型，
并且所有的键值必须是类的STORAGE类型。被传递给extractQuery、
consistent和triConsistent的query
参数是由该策略号标识的类成员操作符的右手边输入类型。
这不需要和被索引类型相同，只要正确类型的键值能从其中被抽取出来。不过，
推荐这三个支持函数的 SQL 声明对query参数使用操作符类的被
索引数据类型，即便实际类型可能是某种其他依赖于操作符的东西时也应如此。
65.4.4. 实现 #
在内部，一个GIN索引包含一个在键上构建的 B 树索引，其中每一个键是一个或者多个被索引项的一个元素（例如，数组的一个成员），并且叶子页中的每一个元组包含一个指向堆指针 B 树的指针（一个“位置树”）或者一个堆指针的简单列表（“位置列表”），只有位置列表小到能够和键值一起放入索引时才使用后一种形式。
图 65.1举例说明了这些GIN索引的组件。
自PostgreSQL 9.1 起，空键值可以被包括在索引中。同样，用于为空或者根据extractValue不包含键的被索引项的占位符空值也被包括在索引中。这允许实现应该找到空项的搜索。
多列GIN索引可以通过在组合值（列号，键值）上建立一个单一 B 树实现。不同列的键值可以是不同类型。
图 65.1. GIN内部65.4.4.1. GIN快速更新技术 #
更新GIN索引往往会很慢，由于反向索引的固有特性：
插入或更新一个heap row会导致许多项目插入到索引中（每个索引键从索引项目中提取一个）。
GIN能够通过将新的tuple插入临时的未排序的待处理条目列表来延迟大部分工作。
当表被清理或自动分析时，或者gin_clean_pending_list函数被调用时，
又或者待处理列表变得大于gin_pending_list_limit时，
使用在初始索引建立期间使用的相同批次插入技术将项目移动到主要的GIN数据结构中。
即使考虑到额外的清理开销，这也显著加快了GIN索引更新速度。
此外，后台进程可以执行这种开销工作，而不是前端查询处理来完成。
这种方式的主要缺点是搜索必须在搜索普通索引之外扫描待处理条目的列表，并且因此一个大型的待处理条目列表会显著地拖慢搜索。另一个缺点是，虽然大部分更新变快了，一次导致待处理列表变得“太大”的更新将导致一次立即清理循环并且因此会比其他更新慢很多。正确使用自动清理可以把这些问题的影响变得最小。
如果一致的响应时间比更新速度更重要，可以通过为一个GIN索引关闭fastupdate存储参数来禁用对待处理条目的使用。详见CREATE INDEX。
65.4.4.2. 部分匹配算法 #
GIN 可以支持“部分匹配”查询，在其中查询不能判断一个或多个键的精确匹配，但是可以确定落在键值（在compare支持方法决定的键排序顺序中）的一个合理的狭窄范围内的可能匹配。extractQuery方法，不会返回一个要被精确匹配的键值，而是返回一个作为要被搜索范围下界的键值，并且将pmatch标志设置为真。然后键范围将被使用comparePartial方法扫描。comparePartial必须对于一个匹配的索引键返回零，对于一个不匹配但仍在要被搜索的范围内的返回小于零，对于超过被搜索范围的索引键返回大于零。
65.4.5. GIN 提示和技巧 #创建 vs. 插入
插入到一个GIN索引可能会很慢，因为为一个项可能需要插入很多键。因此，对于一个表的批量插入，我们建议删除 GIN 索引，然后在完成批量插入后重建它。
当 GIN 启用 fastupdate 时
(参见 第 65.4.4.1 节 ), 惩罚比其他情况要小。但是对于非常大的更新，删除并重新创建索引可能仍然是最好的。
maintenance_work_mem
一个GIN索引的建立时间对maintenance_work_mem设置很敏感；它不值得在索引创建期间节省工作内存。
gin_pending_list_limit
在向一个已有的开启了fastupdate的GIN
中进行插入时，系统将在待处理项列表增长到超过gin_pending_list_limit
时清理该列表。为了避免在观测到的响应时间上出现波动，让待处理列表清理操作
在后台进行（即通过 autovacuum）比较好。可以通过增加gin_pending_list_limit
或者让 autovacuum 更激进来避免前台的清理操作。不过，增大清理操作的
阈值意味着如果一次前台清理发生，它将需要更长的时间。
可以通过改变存储参数为每个 GIN 索引覆盖它所用的gin_pending_list_limit，
这样允许每个 GIN 索引拥有自己的清理阈值。例如，可以只为被大量更新的 GIN 索引增加
该阈值，而对其他的索引减小该阈值。
gin_fuzzy_search_limit
开发GIN索引的主要目的是在PostgreSQL中创建对高可扩展全文搜索的支持，并且一次全文搜索返回一个非常大的结果集也是很常见的情况。此外，当查询包含非常频繁的词时情况也是如此，因此大结果集不是非常有用。因为从磁盘读取很多元组并且对它们排序可能会花费很多时间，这对于生产环境来说是不可接受的（注意索引搜索本身是很快的）。
为了能够控制这类查询的执行，GIN对于返回的行数有一个可配置的软上限：gin_fuzzy_search_limit配置参数。默认它被设置为0（意为无限制）。如果设置了一个非零限制，那么被返回的集合是整个结果集的一个子集，并且是随机选择的。
“软”意味着被返回结果的实际数量可以与指定的限制不同，这取决于查询和系统随机数生成器的质量。
根据经验，在数千级别的值（如5000 — 20000）比较好。
65.4.6. 限制 #
GIN假定可索引操作符是严格的。这意味着对于一个空项值，extractValue将根本不会被调用（相反，一个占位符索引项将被自动创建），并且在一个空查询值上也不会调用extractQuery（相反，该查询被假定为不可满足的）。不过注意，在一个非空组合项或查询值中的空键值是被支持的。
65.4.7. 示例 #
PostgreSQL的核心发布中包括之前表 65.3展示的GIN操作符类。下列contrib模块也包含GIN操作符类：
btree_gin多种数据类型的B树等效功能hstore存储键值对的模块intarrayint[]的增强支持pg_trgm使用trigram匹配的文本相似性
上一页 上一级 下一页65.3. SP-GiST索引 起始页 65.5. BRIN 索引
