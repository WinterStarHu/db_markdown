# 65.2. GiST 索引

65.2. GiST 索引
版本：
纠错本页面
搜索
目录导航
❮
❯
65.2. GiST 索引 #65.2.1. 简介65.2.2. 内建操作符类65.2.3. 可扩展性65.2.4. 实现65.2.5. 示例65.2.1. 简介 #
GiST表示通用搜索树。它是一种平衡的树结构的访问方法，它作为一种模板可以用来实现任意索引模式。B 树、R 树和很多其他索引模式都可以在GiST中实现。
GiST的一个优势是它允许自定义数据类型的领域专家使用合适的访问方法开发自定义数据类型，而不是让数据库专家来开发。
这里的一些信息是来自加州大学伯克利分校的 GiST 索引项目网站和 Marcel Kornacker 的学位论文Access Methods for Next-Generation Database Systems。PostgreSQL中的GiST实现主要由 Teodor Sigaev 和 Oleg Bartunov 维护，在他们的网站上有更多信息。
65.2.2. 内建操作符类 #
PostgreSQL核心发布中包括如表 65.1中所示的GiST操作符类（附录 F中描述的一些可选模块提供了额外的GiST操作符类）。
表 65.1. 内建GiST操作符类名称可索引操作符排序操作符box_ops<< (box, box)<-> (box, point)&< (box, box)&& (box, box)&> (box, box)>> (box, box)~= (box, box)@> (box, box)<@ (box, box)&<| (box, box)<<| (box, box)|>> (box, box)|&> (box, box)circle_ops<< (circle, circle)<-> (circle, point)&< (circle, circle)&> (circle, circle)>> (circle, circle)<@ (circle, circle)@> (circle, circle)~= (circle, circle)&& (circle, circle)|>> (circle, circle)<<| (circle, circle)&<| (circle, circle)|&> (circle, circle)inet_ops<< (inet, inet) <<= (inet, inet)>> (inet, inet)>>= (inet, inet)= (inet, inet)<> (inet, inet)< (inet, inet)<= (inet, inet)> (inet, inet)>= (inet, inet)&& (inet, inet)multirange_ops= (anymultirange, anymultirange) && (anymultirange, anymultirange)&& (anymultirange, anyrange)@> (anymultirange, anyelement)@> (anymultirange, anymultirange)@> (anymultirange, anyrange)<@ (anymultirange, anymultirange)<@ (anymultirange, anyrange)<< (anymultirange, anymultirange)<< (anymultirange, anyrange)>> (anymultirange, anymultirange)>> (anymultirange, anyrange)&< (anymultirange, anymultirange)&< (anymultirange, anyrange)&> (anymultirange, anymultirange)&> (anymultirange, anyrange)-|- (anymultirange, anymultirange)-|- (anymultirange, anyrange)point_ops|>> (point, point)<-> (point, point)<< (point, point)>> (point, point)<<| (point, point)~= (point, point)<@ (point, box)<@ (point, polygon)<@ (point, circle)poly_ops<< (polygon, polygon)<-> (polygon, point)&< (polygon, polygon)&> (polygon, polygon)>> (polygon, polygon)<@ (polygon, polygon)@> (polygon, polygon)~= (polygon, polygon)&& (polygon, polygon)<<| (polygon, polygon)&<| (polygon, polygon)|&> (polygon, polygon)|>> (polygon, polygon)range_ops= (anyrange, anyrange) && (anyrange, anyrange)&& (anyrange, anymultirange)@> (anyrange, anyelement)@> (anyrange, anyrange)@> (anyrange, anymultirange)<@ (anyrange, anyrange)<@ (anyrange, anymultirange)<< (anyrange, anyrange)<< (anyrange, anymultirange)>> (anyrange, anyrange)>> (anyrange, anymultirange)&< (anyrange, anyrange)&< (anyrange, anymultirange)&> (anyrange, anyrange)&> (anyrange, anymultirange)-|- (anyrange, anyrange)-|- (anyrange, anymultirange)tsquery_ops<@ (tsquery, tsquery) @> (tsquery, tsquery)tsvector_ops@@ (tsvector, tsquery)
由于历史原因，inet_ops操作符类不是类型inet和cidr的默认操作符类。要使用它，需要在CREATE INDEX中指明操作符类的名称，例如
CREATE INDEX ON my_table USING GIST (my_inet_column inet_ops);
65.2.3. 可扩展性 #
在传统上，实现一种新的索引访问方法意味着很多困难的工作。开发者必须要理解数据库的内部工作，例如锁管理器和预写式日志。GiST接口有一个高层的抽象，要求访问方法实现者只实现要被访问的数据类型的语义。GiST层本身会处理并发、日志和对树结构的搜索。
这种可扩展性不应该与其他标准搜索树对于它们所处理的数据上的可扩展性混淆。例如，PostgreSQL支持可扩展的 B 树和哈希索引。也就是说你可以用PostgreSQL在任何你想要的数据类型上构建一个 B 树或哈希。但是 B 树只支持范围谓词（<、=、>），而哈希索引只支持等值查询。
这样如果你用一个PostgreSQL的 B 树索引一个图像集合，你只能发出例如“imagex 等于 imagey 吗”、“imagex 小于 imagey 吗”以及“imagex 大于 imagey 吗”的查询。取决于你如何在这种上下文中定义“等于”、“小于”和“大于”，这可能会有用。但是，通过使用一个基于GiST的索引，你可以创建提问领域相关问题的方法，可能是“找所有马的图片”或者“找所有曝光过度的图片”。
建立一个GiST访问方法并让其运行的所有工作是实现几个用户定义的方法，它们定义了树中键的行为。当然这些方法必须相当特别来支持特别的查询，但是对于所有标准查询（B 树、R 树等）它们相对直接。简而言之，GiST在可扩展性之上结合了通用性、代码重用和一个干净的接口。
一个 GiST 的索引运算符类必须提供五种方法，七种方法是可选的。
索引的正确性通过正确实现 same、consistent
和 union 方法来确保，而索引的效率（大小和速度）将取决于
penalty 和 picksplit 方法。
两个可选方法是 compress 和
decompress，它们允许索引具有与其索引的数据不同类型的内部树数据。
叶子节点应为被索引数据类型，而其他树节点可以是任何 C 结构（但
您仍然必须遵循 PostgreSQL 数据类型规则，
有关可变大小数据，请参见 varlena）。如果树的
内部数据类型在 SQL 级别存在，则可以使用 STORAGE 选项
的 CREATE OPERATOR CLASS 命令。
可选的第八种方法是 distance，如果运算符类希望支持有序扫描
（最近邻搜索），则需要此方法。可选的第九种方法 fetch 是
如果运算符类希望支持仅索引扫描，则需要此方法，除非省略 compress 方法。
可选的第十种方法 options 是如果运算符类具有
用户指定的参数，则需要此方法。
可选的第十一种方法 sortsupport 用于加速构建 GiST 索引。
可选的第十二种方法 stratnum 用于将比较类型（来自
src/include/access/cmptype.h）转换为运算符类使用的策略编号。
这使得核心代码能够查找时间约束索引的运算符。
consistent
给定一个索引项 p 和一个查询值 q，
这个函数决定该索引项是否与该查询 “一致”，就是说：是否该索引项表示的行使得谓词
“indexed_column
indexable_operator q” 为真？对于一个叶子索引项，这等效于测试索引条件；而对于一个内部树结点，这会决定是否需要扫描由该树结点表示的索引子树。当结果为 true 时，还必须返回一个 recheck 标志。这指示该谓词一定为真或者只是可能为真。如果 recheck = false 那么该索引已经完全测试过该谓词条件，而如果 recheck = true 则该行只是一个候选匹配。在那种情况下，系统将根据实际的行值自动评估 indexable_operator 来看它是否真的是一个匹配。这允许 GiST 同时支持有损和无损的索引结构。
该函数的 SQL 声明必须看起来像这样：
CREATE OR REPLACE FUNCTION my_consistent(internal, data_type, smallint, oid, internal)
RETURNS bool
AS 'MODULE_PATHNAME'
LANGUAGE C STRICT;
在 C 模块中匹配的代码则应该遵循这样的框架：
PG_FUNCTION_INFO_V1(my_consistent);
Datum
my_consistent(PG_FUNCTION_ARGS)
{
GISTENTRY  *entry = (GISTENTRY *) PG_GETARG_POINTER(0);
data_type  *query = PG_GETARG_DATA_TYPE_P(1);
StrategyNumber strategy = (StrategyNumber) PG_GETARG_UINT16(2);
/* Oid subtype = PG_GETARG_OID(3); */
bool       *recheck = (bool *) PG_GETARG_POINTER(4);
data_type  *key = DatumGetDataType(entry->key);
bool        retval;
/*
* 根据策略、键和查询确定返回值。
*
* 使用 GIST_LEAF(entry) 可以了解当前函数是在索引树的哪里被调用，
* 这在支持例如 = 操作符时很方便（可以在非叶子节点中检查非空 union()
* 以及在叶子节点中检查等值）。
*/
*recheck = true;        /* 如果检查是准确的则返回 false */
PG_RETURN_BOOL(retval);
}
这里，key 是该索引中的一个元素而 query 是在该索引中查找的值。StrategyNumber 参数指示在你的操作符类中哪个操作符被应用 — 它匹配 CREATE OPERATOR CLASS 命令中的操作符编号之一。
取决于在操作符类中包含着哪些操作符，query 的数据类型可能随着操作符而变化，因为它可能是该操作符右手边的任何类型，而这种类型可能和出现在其左手边的被索引数据类型不同（上面的代码框架假定只有一种类型；如果不是这样，取 query 参数值的方式可能必须取决于操作符）。
我们推荐让 consistent 函数的 SQL 声明对 query 参数使用操作符类的被索引数据类型，即便实际类型可能是其他依赖于操作符的类型也是如此。
union
这个方法合并树中的信息。给定一组项，这个函数产生一个新的索引项，它表示所有给定的项。
该函数的 SQL 声明必须看起来像这样：
CREATE OR REPLACE FUNCTION my_union(internal, internal)
RETURNS storage_type
AS 'MODULE_PATHNAME'
LANGUAGE C STRICT;
在 C 模块中匹配的代码则应该遵循这样的框架：
PG_FUNCTION_INFO_V1(my_union);
Datum
my_union(PG_FUNCTION_ARGS)
{
GistEntryVector *entryvec = (GistEntryVector *) PG_GETARG_POINTER(0);
GISTENTRY  *ent = entryvec->vector;
data_type  *out,
*tmp,
*old;
int         numranges,
i = 0;
numranges = entryvec->n;
tmp = DatumGetDataType(ent[0].key);
out = tmp;
if (numranges == 1)
{
out = data_type_deep_copy(tmp);
PG_RETURN_DATA_TYPE_P(out);
}
for (i = 1; i < numranges; i++)
{
old = out;
tmp = DatumGetDataType(ent[i].key);
out = my_union_implementation(out, tmp);
}
PG_RETURN_DATA_TYPE_P(out);
}
如你所见，在这个框架中我们处理一种数据类型 union(X, Y, Z) = union(union(X, Y), Z)。通过在这个 GiST 支持方法中实现正确的联合算法，支持不是这种情况的数据类型足够简单。
union 函数的结果必须是该索引的存储类型的一个值，它可能与被索引列的类型不同，也可能相同。union 函数应该返回一个指针指向新 palloc() 的内存。不能照原样返回输入值，即使没有类型改变也不能。
如上所示，union函数的第一个internal参数实际上是一个GistEntryVector指针。第二个参数是一个指向整数变量的指针，它可以被忽略。（过去要求union函数将其结果值的大小存储在这个变量中，但现在这已不再必要。）
compress
把数据项转换成适合于一个索引页面中物理存储的格式。如果compress方法被省略，数据项会被不加修改地存储在索引中。
该函数的SQL声明必须看起来像这样：
CREATE OR REPLACE FUNCTION my_compress(internal)
RETURNS internal
AS 'MODULE_PATHNAME'
LANGUAGE C STRICT;
在 C 模块中匹配的代码则应该遵循这样的框架：
PG_FUNCTION_INFO_V1(my_compress);
Datum
my_compress(PG_FUNCTION_ARGS)
{
GISTENTRY  *entry = (GISTENTRY *) PG_GETARG_POINTER(0);
GISTENTRY  *retval;
if (entry->leafkey)
{
/* 用一个压缩版本替换 entry->key */
compressed_data_type *compressed_data = palloc(sizeof(compressed_data_type));
/* 从 entry->key ... 填充 *compressed_data */
retval = palloc(sizeof(GISTENTRY));
gistentryinit(*retval, PointerGetDatum(compressed_data),
entry->rel, entry->page, entry->offset, FALSE);
}
else
{
/* 通常我们不需要对非叶子项做任何事情 */
retval = entry;
}
PG_RETURN_POINTER(retval);
}
当然，为了压缩你的叶节点，你必须把compressed_data_type改编成你正在转换到的指定类型。
decompress
将一个数据项的存储表达转换成该操作符类中其他GiST方法能够操纵的格式。如果decompress方法被省略，则假设其他GiST方法能够直接在存储的数据格式上工作。（decompress不一定要是compress方法的逆操作，特别是如果compress是有损的，那么decompress是不可能准确地重构原始数据的。decompress也不一定与fetch等效，因为其他GiST方法可能不需要数据的完整重构。）
该函数的SQL声明必须看起来像这样：
CREATE OR REPLACE FUNCTION my_decompress(internal)
RETURNS internal
AS 'MODULE_PATHNAME'
LANGUAGE C STRICT;
在 C 模块中匹配的代码则应该遵循这样的框架：
PG_FUNCTION_INFO_V1(my_decompress);
Datum
my_decompress(PG_FUNCTION_ARGS)
{
PG_RETURN_POINTER(PG_GETARG_POINTER(0));
}
上述框架适合于不需要解压的情况。（但是，将该方法一并省去当然更加容易，并且在这种情况下推荐这样做。）
penalty
返回一个值，它指示在树的一个特定分支插入新项的“代价”。项将被插入到树中具有最小penalty的路径中。penalty返回的值应该为非负。如果一个负值被返回，它将被当作零来处理。
该函数的SQL声明必须看起来像这样：
CREATE OR REPLACE FUNCTION my_penalty(internal, internal, internal)
RETURNS internal
AS 'MODULE_PATHNAME'
LANGUAGE C STRICT;  -- in some cases penalty functions need not be strict
在 C 模块中匹配的代码则应该遵循这样的框架：
PG_FUNCTION_INFO_V1(my_penalty);
Datum
my_penalty(PG_FUNCTION_ARGS)
{
GISTENTRY  *origentry = (GISTENTRY *) PG_GETARG_POINTER(0);
GISTENTRY  *newentry = (GISTENTRY *) PG_GETARG_POINTER(1);
float      *penalty = (float *) PG_GETARG_POINTER(2);
data_type  *orig = DatumGetDataType(origentry->key);
data_type  *new = DatumGetDataType(newentry->key);
*penalty = my_penalty_implementation(orig, new);
PG_RETURN_POINTER(penalty);
}
由于历史原因，penalty函数不只是返回一个float结果，而是必须把该值存储在由第三个参数指定的位置。虽然传回该参数的地址符合惯例，但返回值本身可以被忽略。
penalty函数对于索引的良好性能是至关重要的。在插入时，当要选择在树中的哪个位置加入新项时，这个函数有助于决定应该顺着哪个分支进行。在查询时，索引越平衡，查找越快速。
picksplit
当需要一次索引页面分裂时，这个函数决定在该页面上哪些项会留在旧页面上，以及哪些项会移动到新页面上。
该函数的SQL声明必须看起来像这样：
CREATE OR REPLACE FUNCTION my_picksplit(internal, internal)
RETURNS internal
AS 'MODULE_PATHNAME'
LANGUAGE C STRICT;
在 C 模块中匹配的代码则应该遵循这样的框架：
PG_FUNCTION_INFO_V1(my_picksplit);
Datum
my_picksplit(PG_FUNCTION_ARGS)
{
GistEntryVector *entryvec = (GistEntryVector *) PG_GETARG_POINTER(0);
GIST_SPLITVEC *v = (GIST_SPLITVEC *) PG_GETARG_POINTER(1);
OffsetNumber maxoff = entryvec->n - 1;
GISTENTRY  *ent = entryvec->vector;
int         i,
nbytes;
OffsetNumber *left,
*right;
data_type  *tmp_union;
data_type  *unionL;
data_type  *unionR;
GISTENTRY **raw_entryvec;
maxoff = entryvec->n - 1;
nbytes = (maxoff + 1) * sizeof(OffsetNumber);
v->spl_left = (OffsetNumber *) palloc(nbytes);
left = v->spl_left;
v->spl_nleft = 0;
v->spl_right = (OffsetNumber *) palloc(nbytes);
right = v->spl_right;
v->spl_nright = 0;
unionL = NULL;
unionR = NULL;
/* 初始化裸的项向量。 */
raw_entryvec = (GISTENTRY **) malloc(entryvec->n * sizeof(void *));
for (i = FirstOffsetNumber; i <= maxoff; i = OffsetNumberNext(i))
raw_entryvec[i] = &(entryvec->vector[i]);
for (i = FirstOffsetNumber; i <= maxoff; i = OffsetNumberNext(i))
{
int         real_index = raw_entryvec[i] - entryvec->vector;
tmp_union = DatumGetDataType(entryvec->vector[real_index].key);
Assert(tmp_union != NULL);
/*
* 选择在哪里放置索引项并且相应地更新 unionL 和 unionR。
* 把项追加到 v->spl_left 或者 v->spl_right，并且设置好计数器。
*/
if (my_choice_is_left(unionL, curl, unionR, curr))
{
if (unionL == NULL)
unionL = tmp_union;
else
unionL = my_union_implementation(unionL, tmp_union);
*left = real_index;
++left;
++(v->spl_nleft);
}
else
{
/*
* 和在右边的过程相同
*/
}
}
v->spl_ldatum = DataTypeGetDatum(unionL);
v->spl_rdatum = DataTypeGetDatum(unionR);
PG_RETURN_POINTER(v);
}
注意picksplit函数的结果通过修改传入的v结构来传递。尽管传回v的地址符合惯例，但返回值本身可以被忽略。
和penalty一样，picksplit函数对于索引的良好性能至关重要。设计合适的penalty和picksplit实现是实现高性能GiST索引的挑战所在。
same
如果两个索引项相同则返回真，否则返回假（一个“索引项”是该索引的存储类型的一个值，而不一定是原始被索引列类型的值）。
该函数的SQL声明必须看起来像这样：
CREATE OR REPLACE FUNCTION my_same(storage_type, storage_type, internal)
RETURNS internal
AS 'MODULE_PATHNAME'
LANGUAGE C STRICT;
在 C 模块中匹配的代码则应该遵循这样的框架：
PG_FUNCTION_INFO_V1(my_same);
Datum
my_same(PG_FUNCTION_ARGS)
{
prefix_range *v1 = PG_GETARG_PREFIX_RANGE_P(0);
prefix_range *v2 = PG_GETARG_PREFIX_RANGE_P(1);
bool       *result = (bool *) PG_GETARG_POINTER(2);
*result = my_eq(v1, v2);
PG_RETURN_POINTER(result);
}
由于历史原因，same函数不只返回一个布尔结果。相反它必须把该标志存储在第三个参数指示的位置。尽管传回该参数的地址符合惯例，但返回值本身可以被忽略。
distance
给定一个索引项p和一个查询值q，这个函数决定索引项与查询值之间的“距离”。如果操作符类包含任何排序操作符，就必须提供这个函数。一个使用排序操作符的查询将首先返回具有最小“距离”值的索引项，因此结果必须与操作符的语义一致。对于一个叶索引项，结果只表示到索引项的距离；对于一个内部树节点，结果必须是任何子项可能具有的最小距离。
该函数的SQL声明必须看起来像这样：
CREATE OR REPLACE FUNCTION my_distance(internal, data_type, smallint, oid, internal)
RETURNS float8
AS 'MODULE_PATHNAME'
LANGUAGE C STRICT;
在 C 模块中匹配的代码则应该遵循这样的框架：
PG_FUNCTION_INFO_V1(my_distance);
Datum
my_distance(PG_FUNCTION_ARGS)
{
GISTENTRY  *entry = (GISTENTRY *) PG_GETARG_POINTER(0);
data_type  *query = PG_GETARG_DATA_TYPE_P(1);
StrategyNumber strategy = (StrategyNumber) PG_GETARG_UINT16(2);
/* Oid subtype = PG_GETARG_OID(3); */
/* bool *recheck = (bool *) PG_GETARG_POINTER(4); */
data_type  *key = DatumGetDataType(entry->key);
double      retval;
/*
* determine return value as a function of strategy, key and query.
*/
PG_RETURN_FLOAT8(retval);
}
distance函数的参数与consistent函数的参数相同。
在决定距离时允许有某种近似，只要结果不要超过该项的实际距离就可以。因此，例如在几何应用中到一个外包盒的距离就足够了。对于一个内部树节点，返回的距离不能超过到其任意一个子节点的距离。如果返回的距离不准确，该函数必须设置*recheck为真（这对于内部树节点是不必要的，对于它们，计算总是被假定为不准确）。在这种情况下，执行器将在从堆中取出元组后计算精确的距离，并且在必要时记录这些元组。
如果距离函数对任意叶子节点都返回*recheck = true，初始的排序操作符的返回类型必须是float8或者float4，并且距离函数的结果值必须能和初始排序操作符的结果进行比较，因为执行器将使用距离函数结果和重新计算的排序操作符结果进行排序。否则，该距离函数的结果值可以是任意有限的float8值，只要这些结果值的相对顺序匹配该排序操作符返回的顺序（在内部会使用无穷以及负无穷来处理空值等情况，因此我们不推荐distance函数返回这些值）。
fetch
为只用索引的扫描将一个数据项压缩过的索引表达转换成原始的数据类型。被返回的数据必须是原始被索引值的一份准确的、非有损的拷贝。
该函数的SQL声明必须看起来像这样：
CREATE OR REPLACE FUNCTION my_fetch(internal)
RETURNS internal
AS 'MODULE_PATHNAME'
LANGUAGE C STRICT;
参数是一个指向GISTENTRY结构的指针。在项上，它的key域包含一个压缩形式的非-NULL 叶子数据。返回值是另一个GISTENTRY结构，其key域包含同一数据的原始的未压缩形式。如果操作符类的压缩函数不对叶子项做任何事情，fetch方法可以原样返回参数。或者，如果该opclass没有一个压缩函数，则fetch方法也可以被省略，因为它必须是一个空操作。
C 模块中相应的代码可能会遵循下面的框架：
PG_FUNCTION_INFO_V1(my_fetch);
Datum
my_fetch(PG_FUNCTION_ARGS)
{
GISTENTRY  *entry = (GISTENTRY *) PG_GETARG_POINTER(0);
input_data_type *in = DatumGetPointer(entry->key);
fetched_data_type *fetched_data;
GISTENTRY  *retval;
retval = palloc(sizeof(GISTENTRY));
fetched_data = palloc(sizeof(fetched_data_type));
/*
* 将 'fetched_data' 转换成原始数据类型的一个 Datum。
*/
/* 从 fetched_data 填充 *retval。 */
gistentryinit(*retval, PointerGetDatum(converted_datum),
entry->rel, entry->page, entry->offset, FALSE);
PG_RETURN_POINTER(retval);
}
如果该压缩方法对于叶子项是有损的，操作符类就不能支持只用索引的扫描，并且不能定义fetch函数。
options
允许定义控制操作符类行为的用户可见参数。
该函数的SQL声明必须看起来如下所示：
CREATE OR REPLACE FUNCTION my_options(internal)
RETURNS void
AS 'MODULE_PATHNAME'
LANGUAGE C STRICT;
向函数传递一个指向local_relopts结构体的指针，该结构体需要用一组特定于操作符类的选项来填充。
可以使用PG_HAS_OPCLASS_OPTIONS() 和 PG_GET_OPCLASS_OPTIONS()宏从其他支持函数访问这些选项。
以下是 my_options() 的示例实现和其他支持函数中参数的使用：
typedef enum MyEnumType
{
MY_ENUM_ON,
MY_ENUM_OFF,
MY_ENUM_AUTO
} MyEnumType;
typedef struct
{
int32   vl_len_;    /* varlena header (do not touch directly!) */
int     int_param;  /* 整数参数 */
double  real_param; /* 实数参数 */
MyEnumType enum_param; /* 枚举参数 */
int     str_param;  /* 字符串参数 */
} MyOptionsStruct;
/* 枚举值的字符串表示 */
static relopt_enum_elt_def myEnumValues[] =
{
{"on", MY_ENUM_ON},
{"off", MY_ENUM_OFF},
{"auto", MY_ENUM_AUTO},
{(const char *) NULL}   /* 列表终止符 */
};
static char *str_param_default = "default";
/*
* 示例验证器：检查字符串长度不超过 8 字节。
*/
static void
validate_my_string_relopt(const char *value)
{
if (strlen(value) > 8)
ereport(ERROR,
(errcode(ERRCODE_INVALID_PARAMETER_VALUE),
errmsg("str_param 最多只能为 8 字节")));
}
/*
* 示例填充器：将字符转换为小写。
*/
static Size
fill_my_string_relopt(const char *value, void *ptr)
{
char   *tmp = str_tolower(value, strlen(value), DEFAULT_COLLATION_OID);
int     len = strlen(tmp);
if (ptr)
strcpy(ptr, tmp);
pfree(tmp);
return len + 1;
}
PG_FUNCTION_INFO_V1(my_options);
Datum
my_options(PG_FUNCTION_ARGS)
{
local_relopts *relopts = (local_relopts *) PG_GETARG_POINTER(0);
init_local_reloptions(relopts, sizeof(MyOptionsStruct));
add_local_int_reloption(relopts, "int_param", "整数参数",
100, 0, 1000000,
offsetof(MyOptionsStruct, int_param));
add_local_real_reloption(relopts, "real_param", "实数参数",
1.0, 0.0, 1000000.0,
offsetof(MyOptionsStruct, real_param));
add_local_enum_reloption(relopts, "enum_param", "枚举参数",
myEnumValues, MY_ENUM_ON,
"有效值为：\"on\"、\"off\" 和 \"auto\"。",
offsetof(MyOptionsStruct, enum_param));
add_local_string_reloption(relopts, "str_param", "字符串参数",
str_param_default,
&validate_my_string_relopt,
&fill_my_string_relopt,
offsetof(MyOptionsStruct, str_param));
PG_RETURN_VOID();
}
PG_FUNCTION_INFO_V1(my_compress);
Datum
my_compress(PG_FUNCTION_ARGS)
{
int     int_param = 100;
double  real_param = 1.0;
MyEnumType enum_param = MY_ENUM_ON;
char   *str_param = str_param_default;
/*
* 通常，当运算符类包含 'options' 方法时，选项总是
* 传递给支持函数。然而，如果您将 'options' 方法添加到
* 现有运算符类，则之前定义的索引没有选项，因此
* 需要进行检查。
*/
if (PG_HAS_OPCLASS_OPTIONS())
{
MyOptionsStruct *options = (MyOptionsStruct *) PG_GET_OPCLASS_OPTIONS();
int_param = options->int_param;
real_param = options->real_param;
enum_param = options->enum_param;
str_param = GET_STRING_RELOPTION(options, str_param);
}
/* 支持函数的其余实现 */
}
由于GiST中的键表示是灵活的，它可能依赖于用户指定的参数。
例如，可以指定键签名的长度。示例可参见gtsvector_options()。
sortsupport
返回一个比较器函数来排序数据，以保留局部性的方式。
它被CREATE INDEX和REINDEX命令使用。
创建索引的质量取决于比较器函数确定的排序顺序在多大程度上保留了输入的局部性。
sortsupport方法是可选的。
如果它没有被提供，CREATE INDEX命令通过使用penalty 和 picksplit 函数把每个元组插入到树来构建索引，这要慢得多。
函数的 SQL 声明必须看起来像这样：
CREATE OR REPLACE FUNCTION my_sortsupport(internal)
RETURNS void
AS 'MODULE_PATHNAME'
LANGUAGE C STRICT;
参数指向SortSupport结构。
至少，函数必须填写它的比较器字段。
比较器有三个参数：两个要进行比较的Datum，还有一个指向SortSupport结构的指针。
Datum是两个索引值，以它们在索引中存储的格式；也就是说，以compress方法返回的格式。
完整的API在src/include/utils/sortsupport.h中定义。
C模块中的匹配代码可以遵循下述这样的框架:
PG_FUNCTION_INFO_V1(my_sortsupport);
static int
my_fastcmp(Datum x, Datum y, SortSupport ssup)
{
/* establish order between x and y by computing some sorting value z */
int z1 = ComputeSpatialCode(x);
int z2 = ComputeSpatialCode(y);
return z1 == z2 ? 0 : z1 > z2 ? 1 : -1;
}
Datum
my_sortsupport(PG_FUNCTION_ARGS)
{
SortSupport ssup = (SortSupport) PG_GETARG_POINTER(0);
ssup->comparator = my_fastcmp;
PG_RETURN_VOID();
}
translate_cmptype
给定来自 src/include/access/cmptype.h 的 CompareType 值，返回此运算符类用于匹配功能的策略编号。
如果运算符类没有匹配策略，则该函数应返回 InvalidStrategy。
这用于时间索引约束（即 PRIMARY
KEY 和 UNIQUE）。如果运算符类
提供此函数并且它返回 COMPARE_EQ 的结果，
则可以在索引约束的非 WITHOUT OVERLAPS 部分使用。
此支持函数对应于索引访问方法回调函数 amtranslatecmptype（见 第 63.2 节）。amtranslatecmptype
对于 GiST 索引的回调函数仅调用相应运算符族的
translate_cmptype 支持函数，因为 GiST 索引访问方法本身没有固定的策略编号。
函数的 SQL 声明必须如下所示：
CREATE OR REPLACE FUNCTION my_translate_cmptype(integer)
RETURNS smallint
AS 'MODULE_PATHNAME'
LANGUAGE C STRICT;
运算符族注册必须如下所示：
ALTER OPERATOR FAMILY my_opfamily USING gist ADD
FUNCTION 12 ("any", "any") my_translate_cmptype(int);
C 模块中的匹配代码可以遵循以下框架：
PG_FUNCTION_INFO_V1(my_translate_cmptype);
Datum
my_translate_cmptype(PG_FUNCTION_ARGS)
{
CompareType cmptype = PG_GETARG_INT32(0);
StrategyNumber ret = InvalidStrategy;
switch (cmptype)
{
case COMPARE_EQ:
ret = BTEqualStrategyNumber;
}
PG_RETURN_UINT16(ret);
}
一个翻译函数由 PostgreSQL 提供：
gist_translate_cmptype_common 适用于使用
RT*StrategyNumber 常量的运算符类。
btree_gist 扩展定义了第二个翻译函数，
gist_translate_cmptype_btree，适用于使用
BT*StrategyNumber 常量的运算符类。
所有的 GiST 支持方法通常都在一个短暂存在的内存上下文中被调用；就是说，每个元组被处理之后CurrentMemoryContext将被重置。因此没有必要操心释放你 palloc 的所有东西。但是，在某些情况下，一个支持方法在重复调用之间缓存数据是有用的。要这样做，将这些长期生存的数据分配在fcinfo->flinfo->fn_mcxt中，并且在fcinfo->flinfo->fn_extra中保持一个到它的指针。这种数据将在索引操作期间都存在（例如一次 GiST 索引扫描、索引构建或索引元组插入）。注意当替换一个fn_extra值时要释放之前的值，否则在操作期间该泄露会累积。
65.2.4. 实现 #65.2.4.1. GiST 索引构建方法 #
构建GiST索引最简单的方法就是插入全部条目，一个接一个。
对大的索引这个会趋向于变慢，因为如果索引元组是分散地跨越索引，并且索引大到缓存容不下的时候，将会需要大量随机I/O。
PostgreSQL支持两个可供选择的方法以供GiST索引的初始化构建：sorted 和 buffered 方法。
排序方法仅在用于索引的每个操作类提供sortsupport函数的时候有效，就像第 65.2.3 节中所描述的。
如果满足，这个方法通常是最好的，所以它是默认使用的。
缓冲方法不直接立刻插入元组到索引。
它能明显减少非排序数据集所需要的随机I/O的数量。
对于良好排序的数据集，这个收益很小甚至不存在，因为那时只有少数页面会接收新元组，并且那些页面也适合缓存，即便整个索引不能放在缓存中。
缓冲方法比简单的方法需要更频繁地调用penalty，这样会消耗额外的CPU资源。
另外，缓冲需要临时磁盘空间，最大为结果索引的尺寸。
缓冲也可能影响结果索引的质量，不管是正向还是负向。
这种影响取决于多种因素，如输入数据的分布和操作符类的实现。
如果排序不可能，则默认情况下，当索引尺寸达到effective_cache_size时，一个 GiST 索引构建会切换到缓冲方法。
缓冲可以通过 CREATE INDEX 命令的buffering参数手动强制或阻止。
默认行为对大部分情况是好的，但是如果输入数据是排序好的，关闭缓冲特性可能会加速构建过程。
65.2.5. 示例 #
PostgreSQL源码包包括了多个用GiST实现的索引方法的例子。核心系统当前提供文本搜索支持（用于tsvector和tsquery的索引）以及用于一些内建几何数据类型（src/backend/access/gist/gistproc.c）的 R 树等效功能。下列contrib模块也包含GiST操作符类：
btree_gist多种数据类型的 B 树等效功能cube多维立方体的索引hstore存储键值对的模块intarray一维 int4 值数组的 RD 树ltree树状结构的索引pg_trgm使用 trigram 匹配的文本相似性seg索引“float ranges”
上一页 上一级 下一页65.1. B-树索引 起始页 65.3. SP-GiST索引
