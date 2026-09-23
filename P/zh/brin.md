# 65.5. BRIN 索引

65.5. BRIN 索引
版本：
纠错本页面
搜索
目录导航
❮
❯
65.5. BRIN 索引 #65.5.1. 简介65.5.2. 内建操作符类65.5.3. 可扩展性65.5.1. 简介 #
BRIN 代表块范围索引。
BRIN 旨在处理非常大的表，其中某些列与它们在表中的物理位置具有某种自然相关性。
BRIN 以 block ranges
(或 “page ranges”)为单位工作。
块范围是表中物理上相邻的一组页面；对于每个块范围，索引会存储一些摘要信息。
例如，一个存储商店销售订单的表可能有一个日期列，表示每个订单的下单日期，大多数情况下较早的订单条目也会在表中较早出现；
一个存储邮政编码列的表可能会自然地将同一城市的所有邮政编码分组在一起。
BRIN 索引可以通过常规的位图索引扫描满足查询，并且将会返回每个范围中所有页面
中的所有元组，如果索引中存储的摘要信息与查询条件 一致。
查询执行器负责再次检查这些元组并抛弃那些不匹配查询条件的元组 — 换句话说，这些
索引是有损的。由于一个 BRIN 索引很小，扫描这种索引虽然比使用顺序扫描多出了一点点开销，但是可能会避免扫描
表中很多已知不包含匹配元组的部分。
一个 BRIN 索引将存储的特定数据以及该索引将能
满足的特定查询，都依赖于为该索引的每一列所选择的操作符类。具有线性
排序顺序的数据类型的操作符类可以存储在每个块范围内的最小和最大
值，例如几何类型可能会存储在块范围内的所有对象的外包盒。
块范围的尺寸在索引创建时由 pages_per_range 存储参数决定。
索引项的数量将等于该关系的尺寸（以页面计）除以为
pages_per_range 选择的值。因此，该值越小，索引会变得越大
（因为需要存储更多索引项），但是与此同时存储的摘要数据可以更加精确并
且在索引扫描期间可以跳过更多数据块。
65.5.1.1. 索引维护 #
在创建时，所有现有的堆页面都会被扫描，并为每个范围创建一个摘要索引元组，包括可能不完整的范围在内。
随着新页面被填充数据，已经被总结的页面范围将导致摘要信息被更新，使用新元组的数据。
当创建一个新页面，不在最后总结的范围内时，新页面所属的范围不会自动获得一个摘要元组；
这些元组保持未总结状态，直到稍后调用总结运行，为该范围创建初始摘要。
有几种方法可以触发页面范围的初始摘要。如果表被手动或通过
autovacuum进行了清理，所有现有的未摘要的
页面范围都会被摘要。
另外，如果索引的
autosummarize参数被启用（默认情况下未启用），
那么每当数据库中运行自动清理（autovacuum）时，将对所有已填充的未摘要的页面范围进行摘要处理，
无论表本身是否由自动清理（autovacuum）处理；请参见下文。
最后，可以使用以下函数（当这些函数运行时，search_path会临时更改为
pg_catalog, pg_temp）：
brin_summarize_new_values(regclass)
用于汇总所有未汇总的范围；
brin_summarize_range(regclass, bigint)
用于仅汇总包含给定页面的范围（如果该范围尚未汇总）。
当启用自动摘要时，会向autovacuum发送请求，以在检测到下一个块范围的第一页的第一项插入时执行有针对性的摘要，
在同一数据库中的下一个自动清理（autovacuum）工作完成后执行。如果请求队列已满，则不记录请求，并向服务器日志发送消息:
LOG:  request for BRIN range summarization for index "brin_wi_idx" page 128 was not recorded
当发生这种情况时，范围将保持未摘要状态，直到表上的下一个常规清理运行，或者调用上述函数之一。
相反，可以使用brin_desummarize_range(regclass, bigint)函数对范围进行反汇总，
当索引元组不再是一个很好的表示，因为现有值已经改变时，这是很有用的。
有关详细信息，请参见第 9.28.8 节。
65.5.2. 内建操作符类 #
核心PostgreSQL发布包括了
表 65.4中所示的
BRIN操作符类。
minmax操作符类存储范围内被索引列中出现的最小和最大值。
inclusion操作符类存储包括范围内被索引列中值的一个值。
bloom操作符类对范围内的所有值构建一个布隆过滤器。
minmax-multi操作符类存储多个最小和最大值，表示范围内出现在索引列中的值。
表 65.4. 内置 BRIN 操作符类名称可索引操作符bit_minmax_ops= (bit,bit)< (bit,bit)> (bit,bit)<= (bit,bit)>= (bit,bit)box_inclusion_ops@> (box,point)<< (box,box)&< (box,box)&> (box,box)>> (box,box)<@ (box,box)@> (box,box)~= (box,box)&& (box,box)<<| (box,box)&<| (box,box)|&> (box,box)|>> (box,box)bpchar_bloom_ops= (character,character)bpchar_minmax_ops= (character,character)< (character,character)<= (character,character)> (character,character)>= (character,character)bytea_bloom_ops= (bytea,bytea)bytea_minmax_ops= (bytea,bytea)< (bytea,bytea)<= (bytea,bytea)> (bytea,bytea)>= (bytea,bytea)char_bloom_ops= ("char","char")char_minmax_ops= ("char","char")< ("char","char")<= ("char","char")> ("char","char")>= ("char","char")date_bloom_ops= (date,date)date_minmax_ops= (date,date)< (date,date)<= (date,date)> (date,date)>= (date,date)date_minmax_multi_ops= (date,date)< (date,date)<= (date,date)> (date,date)>= (date,date)float4_bloom_ops= (float4,float4)float4_minmax_ops= (float4,float4)< (float4,float4)> (float4,float4)<= (float4,float4)>= (float4,float4)float4_minmax_multi_ops= (float4,float4)< (float4,float4)> (float4,float4)<= (float4,float4)>= (float4,float4)float8_bloom_ops= (float8,float8)float8_minmax_ops= (float8,float8)< (float8,float8)<= (float8,float8)> (float8,float8)>= (float8,float8)float8_minmax_multi_ops= (float8,float8)< (float8,float8)<= (float8,float8)> (float8,float8)>= (float8,float8)inet_inclusion_ops<< (inet,inet)<<= (inet,inet)>> (inet,inet)>>= (inet,inet)= (inet,inet)&& (inet,inet)inet_bloom_ops= (inet,inet)inet_minmax_ops= (inet,inet)< (inet,inet)<= (inet,inet)> (inet,inet)>= (inet,inet)inet_minmax_multi_ops= (inet,inet)< (inet,inet)<= (inet,inet)> (inet,inet)>= (inet,inet)int2_bloom_ops= (int2,int2)int2_minmax_ops= (int2,int2)< (int2,int2)> (int2,int2)<= (int2,int2)>= (int2,int2)int2_minmax_multi_ops= (int2,int2)< (int2,int2)> (int2,int2)<= (int2,int2)>= (int2,int2)int4_bloom_ops= (int4,int4)int4_minmax_ops= (int4,int4)< (int4,int4)> (int4,int4)<= (int4,int4)>= (int4,int4)int4_minmax_multi_ops= (int4,int4)< (int4,int4)> (int4,int4)<= (int4,int4)>= (int4,int4)int8_bloom_ops= (bigint,bigint)int8_minmax_ops= (bigint,bigint)< (bigint,bigint)> (bigint,bigint)<= (bigint,bigint)>= (bigint,bigint)int8_minmax_multi_ops= (bigint,bigint)< (bigint,bigint)> (bigint,bigint)<= (bigint,bigint)>= (bigint,bigint)interval_bloom_ops= (interval,interval)interval_minmax_ops= (interval,interval)< (interval,interval)<= (interval,interval)> (interval,interval)>= (interval,interval)interval_minmax_multi_ops= (interval,interval)< (interval,interval)<= (interval,interval)> (interval,interval)>= (interval,interval)macaddr_bloom_ops= (macaddr,macaddr)macaddr_minmax_ops= (macaddr,macaddr)< (macaddr,macaddr)<= (macaddr,macaddr)> (macaddr,macaddr)>= (macaddr,macaddr)macaddr_minmax_multi_ops= (macaddr,macaddr)< (macaddr,macaddr)<= (macaddr,macaddr)> (macaddr,macaddr)>= (macaddr,macaddr)macaddr8_bloom_ops= (macaddr8,macaddr8)macaddr8_minmax_ops= (macaddr8,macaddr8)< (macaddr8,macaddr8)<= (macaddr8,macaddr8)> (macaddr8,macaddr8)>= (macaddr8,macaddr8)macaddr8_minmax_multi_ops= (macaddr8,macaddr8)< (macaddr8,macaddr8)<= (macaddr8,macaddr8)> (macaddr8,macaddr8)>= (macaddr8,macaddr8)name_bloom_ops= (name,name)name_minmax_ops= (name,name)< (name,name)<= (name,name)> (name,name)>= (name,name)numeric_bloom_ops= (numeric,numeric)numeric_minmax_ops= (numeric,numeric)< (numeric,numeric)<= (numeric,numeric)> (numeric,numeric)>= (numeric,numeric)numeric_minmax_multi_ops= (numeric,numeric)< (numeric,numeric)<= (numeric,numeric)> (numeric,numeric)>= (numeric,numeric)oid_bloom_ops= (oid,oid)oid_minmax_ops= (oid,oid)< (oid,oid)> (oid,oid)<= (oid,oid)>= (oid,oid)oid_minmax_multi_ops= (oid,oid)< (oid,oid)> (oid,oid)<= (oid,oid)>= (oid,oid)pg_lsn_bloom_ops= (pg_lsn,pg_lsn)pg_lsn_minmax_ops= (pg_lsn,pg_lsn)< (pg_lsn,pg_lsn)> (pg_lsn,pg_lsn)<= (pg_lsn,pg_lsn)>= (pg_lsn,pg_lsn)pg_lsn_minmax_multi_ops= (pg_lsn,pg_lsn)< (pg_lsn,pg_lsn)> (pg_lsn,pg_lsn)<= (pg_lsn,pg_lsn)>= (pg_lsn,pg_lsn)range_inclusion_ops= (anyrange,anyrange)< (anyrange,anyrange)<= (anyrange,anyrange)>= (anyrange,anyrange)> (anyrange,anyrange)&& (anyrange,anyrange)@> (anyrange,anyelement)@> (anyrange,anyrange)<@ (anyrange,anyrange)<< (anyrange,anyrange)>> (anyrange,anyrange)&< (anyrange,anyrange)&> (anyrange,anyrange)-|- (anyrange,anyrange)text_bloom_ops= (text,text)text_minmax_ops= (text,text)< (text,text)<= (text,text)> (text,text)>= (text,text)tid_bloom_ops= (tid,tid)tid_minmax_ops= (tid,tid)< (tid,tid)> (tid,tid)<= (tid,tid)>= (tid,tid)tid_minmax_multi_ops= (tid,tid)< (tid,tid)> (tid,tid)<= (tid,tid)>= (tid,tid)timestamp_bloom_ops= (timestamp,timestamp)timestamp_minmax_ops= (timestamp,timestamp)< (timestamp,timestamp)<= (timestamp,timestamp)> (timestamp,timestamp)>= (timestamp,timestamp)timestamp_minmax_multi_ops= (timestamp,timestamp)< (timestamp,timestamp)<= (timestamp,timestamp)> (timestamp,timestamp)>= (timestamp,timestamp)timestamptz_bloom_ops= (timestamptz,timestamptz)timestamptz_minmax_ops= (timestamptz,timestamptz)< (timestamptz,timestamptz)<= (timestamptz,timestamptz)> (timestamptz,timestamptz)>= (timestamptz,timestamptz)timestamptz_minmax_multi_ops= (timestamptz,timestamptz)< (timestamptz,timestamptz)<= (timestamptz,timestamptz)> (timestamptz,timestamptz)>= (timestamptz,timestamptz)time_bloom_ops= (time,time)time_minmax_ops= (time,time)< (time,time)<= (time,time)> (time,time)>= (time,time)time_minmax_multi_ops= (time,time)< (time,time)<= (time,time)> (time,time)>= (time,time)timetz_bloom_ops= (timetz,timetz)timetz_minmax_ops= (timetz,timetz)< (timetz,timetz)<= (timetz,timetz)> (timetz,timetz)>= (timetz,timetz)timetz_minmax_multi_ops= (timetz,timetz)< (timetz,timetz)<= (timetz,timetz)> (timetz,timetz)>= (timetz,timetz)uuid_bloom_ops= (uuid,uuid)uuid_minmax_ops= (uuid,uuid)< (uuid,uuid)> (uuid,uuid)<= (uuid,uuid)>= (uuid,uuid)uuid_minmax_multi_ops= (uuid,uuid)< (uuid,uuid)> (uuid,uuid)<= (uuid,uuid)>= (uuid,uuid)varbit_minmax_ops= (varbit,varbit)< (varbit,varbit)> (varbit,varbit)<= (varbit,varbit)>= (varbit,varbit)65.5.2.1. 操作符类参数 #
一些内置操作符类允许指定参数，以便控制操作符类的行为。
每个操作符类都有自己允许的参数集。
只有bloom 和 minmax-multi操作符类允许指定参数：
bloom 操作符类接受这些参数：
n_distinct_per_range
定义块范围内不同的非空值的估计数量，由BRIN 布隆索引使用，用于确定布隆过滤器的大小。
它的行为类似于ALTER TABLE的n_distinct选项。
当设置为正值时，每个块范围假定包含该数量的不同的非空值。
当设置为负值时，该值必须大于或等于-1，不同的非空值的数量假定与块范围内的元组的最大可能数量（大约每个块290行）成线性增长。
默认值是-0.1，不同的非空值的最小数量是16。
false_positive_rate
定义由BRIN 布隆索引使用的预期假阳性率，用于确定布隆过滤器的大小。
值必须在0.0001和0.25之间。默认值为0.01，即1%的假阳性率。
minmax-multi 操作符类接受这些参数：
values_per_range
定义由BRIN minmax索引所存储的值的最大数量，以汇总块的范围。每个值可以表示一个点，或者表示区间的边界。值必须介于8和256之间，默认值为32。
65.5.3. 可扩展性 #
BRIN接口具有高层的抽象，要求访问方法实现者只需实现被访问的数据类型的语义。BRIN层本身会负责并发、日志以及对索引结构的搜索。
让一种BRIN访问方法能够工作要做的全部事情是实现几个用户定义的方法，它们定义存储在索引中的摘要值的行为以及它们和扫描键的交互。简而言之，BRIN很好地把可扩展性和通用性、代码重用以及干净的接口结合在了一起。
BRIN的一个操作符类必须提供四种方法：
BrinOpcInfo *opcInfo(Oid type_oid)
返回有关被索引列的摘要数据的内部信息。返回值必须指向一个已经 palloc 的BrinOpcInfo，该结构的定义是：
typedef struct BrinOpcInfo
{
/* 这个 opclass 的一个索引列中存储的列数 */
uint16      oi_nstored;
/* 该 opclass 私有用途的不透明指针 */
void       *oi_opaque;
/* 被存储列的类型缓冲项 */
TypeCacheEntry *oi_typcache[FLEXIBLE_ARRAY_MEMBER];
} BrinOpcInfo;
BrinOpcInfo.oi_opaque可以被操作符类例程用来在索引扫描期间在支持函数之间传递信息。
bool consistent(BrinDesc *bdesc, BrinValues *column,
ScanKey *keys, int nkeys)
返回是否所有的ScanKey条目和一个范围的被索引值一致。使用的属性编号作为扫描键的一部分传递。一个属性的多个扫描键可以被传递一次；条目的数量由nkeys参数决定。
bool consistent(BrinDesc *bdesc, BrinValues *column,
ScanKey key)
返回 ScanKey 是否和一个范围的被索引值一致。要使用的索引号作为扫描键的一部分传递。这是consistent函数的一个较古老的向后兼容的变体。
bool addValue(BrinDesc *bdesc, BrinValues *column,
Datum newval, bool isnull)
给定一个索引元组和一个被索引值，修改该元组的指示属性让该元组能额外地表示新的值。如果对该元组做出了任何修改，就返回true。
bool unionTuples(BrinDesc *bdesc, BrinValues *a,
BrinValues *b)
联合两个索引元组。给定两个索引元组，修改第一个的指示属性让它能表示两个元组。第二个元组不会被修改。
一个BRIN的操作符类可以选择指定如下方法:
void options(local_relopts *relopts)
定义一组控制操作符类行为的用户可见参数。
options函数传递一个指针到local_relopts结构，其需要用一组操作符类指定选项填充。该选项也可以从其他支持的函数来访问，通过使用PG_HAS_OPCLASS_OPTIONS()和PG_GET_OPCLASS_OPTIONS()宏。
由于索引值的键提取和BRIN中的键表达都是灵活的，它们可以取决于用户指定的参数。
核心发布中包括了对四种类型的操作符类的支持：minmax, minmax-multi, inclusion 和 bloom。发布中也酌情为核心中的数据类型提供了使用它们的操作符类定义。用户可以用等效的定义为其他数据类型定义额外的操作符类，而不需要编写任何源代码，只需要声明一些适当的目录项就足够了。注意有关操作符策略的语义的假设是嵌在支持函数的源代码中的。
实现完全不同的语义的操作符类也是可能的，只要提供上述的四个主要支持函数的实现。注意在主要发行版之间的向后兼容性是不被保证的：例如，在以后的发行中可能要求额外的支持函数。
要为一种实现了线性有序集的数据类型编写一个操作符类，可以使用 minmax 支持函数配上对应的操作符（如表 65.5所示）。所有的操作符类成员（函数和操作符）都是强制性的。
表 65.5. Minmax 操作符类的函数和支持编号操作符类成员对象支持函数 1内部函数 brin_minmax_opcinfo()支持函数 2内部函数 brin_minmax_add_value()支持函数 3内部函数 brin_minmax_consistent()支持函数 4内部函数 brin_minmax_union()操作符策略 1小于操作符操作符策略 2小于等于操作符操作符策略 3等于操作符操作符策略 4大于等于操作符操作符策略 5大于操作符
要为值被包括在另一种类型的复杂数据类型编写操作符类，可以使用包含支持函数配上相应的操作符（如
表 65.6所示）。它只要求一个
可用任何语言编写的附加函数。可以定义更多函数来提供额外的功能。所有的
操作符都是可选的。如该表中的依赖性所示，某些操作符需要其他操作符。
表 65.6. 包含操作符类的函数和支持编号操作符类成员对象依赖性支持函数 1内部函数 brin_inclusion_opcinfo() 支持函数 2内部函数 brin_inclusion_add_value() 支持函数 3内部函数 brin_inclusion_consistent() 支持函数 4内部函数 brin_inclusion_union() 支持函数 11合并两个元素的函数 支持函数 12可选函数，检查两个元素是否可以合并 支持函数 13可选函数，检查一个元素是否包含在另一个中 支持函数 14可选函数，检查一个元素是否为空 操作符策略 1位于左边的操作符 left-of操作符策略 4操作符策略 2操作符不扩展到右边的 does-not-extend-to-the-right-of操作符策略 5操作符策略 3重叠操作符 操作符策略 4不超过左边的操作符操作符策略 1操作符策略 5位于右边的操作符操作符策略 2操作符策略 6, 18相同或等于的操作符操作符策略 7操作符策略 7, 16, 24, 25包含或等于的操作符 操作符策略 8, 26, 27被包含或等于的操作符操作符策略 3操作符策略 9不超过上边的操作符操作符策略 11操作符策略 10位于下边的操作符操作符策略 12Operator Strategy 11操作符在上面 is-above操作符策略 9操作符策略 12操作符不超过下面 does-not-extend-below操作符策略 10操作符策略 20小于操作符操作符策略 5操作符策略 21小于等于操作符操作符策略 5操作符策略 22大于操作符操作符策略 1操作符策略 23大于等于操作符操作符策略 1
支持函数编号 1 至 10 被保留给 BRIN 的内部函数，因此 SQL 层面的函数从
编号 11 开始。支持函数编号 11 是用于构建该索引的主要函数。它应该接
受两个具有和操作符类相同数据类型的参数并且返回它们的并集。如果
inclusion 操作符类定义时用了STORAGE参数，则它可以存储具有
不同数据类型的并集值。该并集函数的返回值应该匹配
STORAGE的数据类型。
支持函数编号 12 和 14 被提供用来支持内建数据类型的不规则性。函数编号
12 被用来支持来自不同地址族的不能合并的网络地址。函数编号 14 被用来
支持空范围。函数编号 13 是可选的，但是我们推荐提供它。它允许在新值
被传递给并集函数前对其进行检查。因为 BRIN 框架在并集没有改变时可以
跳过某些操作，所以使用这个函数可以提升索引性能。
为仅实现相等运算符并且支持哈希的数据类型编写运算符类，可以将bloom支持过程与相应的操作符一起使用，就像 表 65.7中所列出的。
所有的操作符类成员（过程和操作符）都是强制性的。
表 65.7. 布隆操作符类的过程和支持编号操作符类成员对象支持过程 1internal function brin_bloom_opcinfo()支持过程 2internal function brin_bloom_add_value()支持过程 3internal function brin_bloom_consistent()支持过程 4internal function brin_bloom_union()支持过程 5internal function brin_bloom_options()支持过程 11计算元素哈希的函数操作符策略 1相等操作符
支持过程编号1-10是为BRIN内部函数保留的，因此SQL级别的函数从编号11开始。
支持函数编号11是构建索引所需要的主函数。
它可以接受一个与操作符类具有相同数据类型的参数，并返回值的哈希。
minmax-multi操作符类也适用于实现完全有序集的数据类型，也可以看作是minmax操作符类的简单扩展。
minmax操作符类将每个块范围的值汇总到单个连续的区间中，而minmax-multi则允许将值汇总到多个更小的区间中，以提升离群值的处理。
可以将minmax-multi支持过程与相应的操作符一起使用，如表 65.8中所示。
所有操作符类成员（过程和操作符）都是强制性的。
表 65.8. minmax-multi操作符类的过程和支持编号操作符类成员对象支持过程 1内部函数 brin_minmax_multi_opcinfo()支持过程 2内部函数 brin_minmax_multi_add_value()支持过程 3内部函数 brin_minmax_multi_consistent()支持过程 4内部函数 brin_minmax_multi_union()支持过程 5内部函数 brin_minmax_multi_options()支持过程 11计算两个值之间距离的函数（范围的长度）操作符策略 1小于操作符操作符策略 2小于等于操作符操作符策略 3等于操作符操作符策略 4大于等于操作符操作符策略 5大于操作符
minmax 和 inclusion 操作符类都支持跨数据类型操作符，不过如果要支持
会让依赖性变得更加复杂。minmax 操作符类要求用具有相同数据类型的
参数来定义一个完整的操作符集合。它允许通过定义额外的操作符集合来
支持其他的数据类型。如
表 65.6中所示，
inclusion 操作符类的操作符策略是依赖于另一种操作符策略的（或者和它们
自身相同的操作符策略）。它们要求定义依赖性操作符时，把
STORAGE数据类型作为左侧参数并且让其他支持的数据类型
作为右侧的参数。minmax 的例子可见
float4_minmax_ops，inclusion 的例子是
box_inclusion_ops。
上一页 上一级 下一页65.4. GIN 索引 起始页 65.6. 哈希索引
