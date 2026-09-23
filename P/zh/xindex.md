# 36.16. 索引的接口扩展

36.16. 索引的接口扩展
版本：
纠错本页面
搜索
目录导航
❮
❯
36.16. 索引的接口扩展 #36.16.1. 索引方法和操作符类36.16.2. 索引方法策略36.16.3. 索引方法支持例程36.16.4. 示例36.16.5. 操作符类和操作符族36.16.6. 操作符类上的系统依赖36.16.7. 排序操作符36.16.8. 操作符类的特性
迄今为止已经描述的过程让我们能够定义新的类型、新的函数以及新的操作符。
但是，我们还不能在一种新数据类型的列上定义索引。要做这件事情，我们必须为新数据类型定义一个操作符类。
在这一小节稍后的部分，我们将用一个例子阐述这部分内容：一个用于 B-树索引方法的操作符类，它以绝对值的升序存储和排序复数。
操作符类可以被分组成操作符族来体现语义兼容的类之间的联系。
当只涉及到一种单一数据类型时，一个操作符类就足矣。因此我们将先把重点放在这种情况上，然后再回到操作符族。
36.16.1. 索引方法和操作符类 #
操作符类与索引访问方法相关联，例如
B-树
或 GIN。可以使用
CREATE ACCESS METHOD 定义自定义索引访问方法。详见
第 63 章。
一个索引方法的例程并不直接了解它将要操作的数据类型。
而是由一个操作符类标识索引方法用来操作一种特定数据类型的一组操作。
之所以被称为操作符类是因为它们指定的一件事情就是可以被用于一个索引的WHERE子句操作符集合（即，能被转换成一个索引扫描条件）。
一个操作符类也能指定一些索引方法内部操作所需的支持函数，这些过程不能直接对应于能用于索引的任何WHERE子句操作符。
可以为相同的数据类型和索引方法定义多个操作符类。通过这种方式，可以为一种数据类型定义多个索引语义集合。
例如，一个B-树索引要求在它要操作的每一种数据类型上都定义一个排序顺序。
对一种复数数据类型来说，拥有一个可以根据复数绝对值排序的 B-树操作符类和另一个可以根据实数部分排序的操作符类可能会有用。
典型地，其中一个操作符类将被认为是最常用的并且将被标记为那种数据类型和索引方法的默认操作符类。
相同的操作符类名称可以被用于多个不同的索引方法（例如，B-树和哈希索引方法都有名为int4_ops的操作符类），但是每个这样的类都是一个独立实体并且必须单独定义。
36.16.2. 索引方法策略 #
与一个操作符类关联的操作符通过“策略号”标识，它被用来标识每个操作符在其操作符类中的语义。例如，B-树在键上施行了一种严格的顺序（较小到较大），因此“小于”和“大于等于”这样的操作符就是B-树所感兴趣的。因为PostgreSQL允许用户定义操作符，PostgreSQL不能看着一个操作符（如<和>=）的名字并且说出它是哪一种比较。取而代之的是，索引方法定义了一个“策略”集合，它们可以被看成是广义的操作符。每个操作符类会说明对于一种特定的数据类型究竟是哪个实际的操作符对应于每一种策略以及该索引语义的解释。
B-树索引方法定义了五种策略，如表 36.3所示。
表 36.3. B-树策略操作策略号小于1小于或等于2等于3大于等于4大于5
哈希索引只支持等值比较，因此它们只使用一种策略，如表 36.4所示。
表 36.4. 哈希策略操作策略编号等于1
GiST 索引更加灵活：它们根本没有一个固定的策略集合。取而代之的是，每一个特定 GiST 操作符类的“consistency”支持例程会负责解释策略号。例如，一些内建的 GiST 索引操作符类索引二维几何对象，它们提供表 36.5中所示的“R-树”策略。其中四个是真正的二维测试（重叠、相同、包含、被包含），其中四个只考虑 X 方向，其他四个提供 Y 方向上的相同测试。
表 36.5. GiST 二维“R-树” 策略操作策略号左参数严格位于右参数的左边1左参数不会延伸到右参数的右边2重叠3左参数不会延伸到右参数的左边4左参数严格位于右参数的右边5相同6包含7被包含8不会延伸到高于9严格低于10严格高于11不会延伸到低于12
SP-GiST 索引在灵活性上与 GiST 索引相似：它们没有一个固定的策略集合。取而代之的是，每一个操作符类的支持例程负责根据该操作符类的定义解释策略号。例如，被内建操作符类用于点的策略号如表 36.6中所示。
表 36.6. SP-GiST 点策略操作策略编号左参数严格地位于右参数的左侧1左参数严格地位于右参数的右侧5相同6被包含于8严格低于10严格高于11
GIN 索引与 GiST 和 SP-GiST 索引类似，它们也没有一个固定的策略集合。取而代之的是，每一个操作符类的支持例程负责根据该操作符类的定义解释策略编号。例如，被内建操作符类用于数组的策略编号如表 36.7所示。
表 36.7. GIN 数组策略操作策略号重叠1包含2被包含3等于4
在没有固定的策略集合这一点上，BRIN 索引和 GiST、SP-GiST 和 GIN 索引是类似的。每一个操作符类的支持函数会根据操作符类的定义解释策略编号。例如，表 36.8中展示了内建的Minmax操作符类所使用的策略编号。  表 36.8. BRIN 最小最大策略操作策略编号小于1小于等于2等于3大于等于4大于5
注意上文列出的所有操作符都返回布尔值。实际上，所有作为索引方法搜索操作符定义的操作符必须返回类型boolean，因为它们必须出现在一个WHERE子句的顶层来与一个索引一起使用（某些索引访问方法还支持排序操作符，它们通常不返回布尔值，这种特性在第 36.16.7 节中讨论）。
36.16.3. 索引方法支持例程 #
对于系统来说只有策略信息通常不足以断定如何使用一种索引。实际上，为了能工作，索引方法还要求额外的支持例程。例如，B-树索引方法必须能比较两个键并且决定其中一个是否大于、等于或小于另一个。类似地，哈希索引方法必须能够为键值计算哈希码。这些操作并不对应在 SQL 命令的条件中使用的操作符。它们是索引方法在内部使用的管理例程。
与策略一样，操作符类会标识哪些函数应该为一种给定的数据类型扮演这些角色以及相应的语义解释。索引方法定义它需要的函数集合，而操作符类则会通过为函数分配由索引方法说明的“支持函数号”来标识正确的函数。
此外，一些 opclass 允许用户指定控制其行为的参数。每个内置索引访问方法都有一个可选的
options支持函数，它定义了一组特定于 opclass 的参数。
如表 36.9所示， B-树要求一个比较支持函数，并且允许在操作符类作者的选项中提供四个额外的支持函数。这些支持函数的要求在第 65.1.3 节中会进一步解释。
表 36.9. B-树支持函数函数支持号
比较两个键并返回一个小于零、等于零或大于零的整数，它表示第一个键小于、等于或者大于第二个键。
1
返回C可调用的排序支持函数的地址（可选）。
2
将一个测试值与一个基础值加上/减去一个偏移量的结果进行比较，根据比较的结果返回真或假（可选）
3
确定使用运算符类应用 btree 去重优化的索引是否安全（可选）
4
定义特定于此运算符类的选项（可选）
5
返回可供 C 调用的跳过支持函数的地址（可选）
6
如表 36.10所示，哈希索引要求一个支持函数，并且允许在操作符类作者的选项中提供两个额外的支持函数。
表 36.10. 哈希支持函数函数支持编号为一个键计算32位哈希值1
给定一个64位salt，计算一个键的64位哈希值。如果salt为0，结果的低32位必须匹配会由函数1计算出来的值（可选）
2
定义特定于此运算符类的选项（可选）
3
GiST 索引有十二个支持函数，其中七个是可选的，
如 表 36.11 所示。
（有关更多信息，请参见 第 65.2 节。）
表 36.11. GiST 支持函数函数描述支持编号consistent判断键是否满足查询修饰符1union计算一组键的并集2compress计算一个要被索引的键或值的压缩表示（可选）3decompress计算一个压缩键的解压表达（可选）4penalty计算把新键插入到带有给定子树键的子树中带来的罚值5picksplit判断一个页面中的哪些项要被移动到新页面中并计算结果页面的联合键6same比较两个键并在它们相等时返回真7distance判断键到查询值的距离（可选）8fetch为只用索引扫描计算一个压缩键的原始表达（可选）9options定义特定于此运算符类的选项（可选）10sortsupport提供一个用于快速索引构建的排序比较器（可选）11translate_cmptype将比较类型转换为运算符类使用的策略编号
（可选）12
如表 36.12所示，SP-GiST 索引有六个支持函数，其中一个是可选的（详见第 65.3 节）。
表 36.12. SP-GiST 支持函数函数描述支持编号config提供有关该操作符类的基本信息1choose判断如何将一个新值插入到一个内元组中2picksplit判断如何划分一组值3inner_consistent判断对于一个查询需要搜索哪一个子划分4leaf_consistent判断键是否满足查询条件5options定义特定于此运算符类的选项（可选）6
如表 36.13所示，GIN 索引有七个支持函数，其中四个是可选的（详见第 65.4 节）。
表 36.13. GIN 支持函数函数描述支持编号compare
比较两个键并返回一个小于零、等于零或大于零的整数，表示第一个键小于、等于或大于第二个键
1extractValue从一个要被索引的值中提取键2extractQuery从一个查询条件中提取键3consistent
判断值是否匹配查询条件（布尔变体）（如果支持函数 6 存在则是可选）
4comparePartial
比较来自查询的部分键和来自索引的键，并返回一个小于零、等于零或大于零的整数，表示 GIN 是否应该忽略该索引项、将该项视为匹配或停止索引扫描（可选）
5triConsistent
判断值是否匹配查询条件（三元变体）（如果支持函数 4 存在则是可选）
6options
定义特定于此运算符类的选项（可选）
7
如表 36.14中所示，BRIN 索引具有五个基本的支持函数，其中一个是可选的。
某些版本的基本功能需要提供额外的支持函数（更多信息请见第 65.5.3 节）。
表 36.14. BRIN 支持函数函数描述支持编号opcInfo
返回描述被索引列的摘要数据的内部信息
1add_value向一个现有的摘要索引元组添加一个新值2consistent判断值是否匹配查询条件3union
计算两个摘要元组的并集
4options
定义特定于此运算符类的选项（可选）
5
和搜索操作符不同，支持函数返回特定索引方法所期望的数据类型，例如在 B 树的比较函数中是一个有符号整数。每个支持函数的参数数量和类型也取决于索引方法。对于 B 树和哈希，比较和哈希支持函数和包括在操作符类中的操作符接收一样的输入数据类型，但是大部分 GiST、SP-GiST、GIN 和 BRIN 支持函数则不是这样。
36.16.4. 示例 #
现在我们已经看过了基本思想，这里是创建一个新操作符类的例子（可以在源代码的src/tutorial/complex.c和src/tutorial/complex.sql中找到这个例子）。该操作符类封装了以绝对值顺序排序复数的操作符，因此我们为它取名为complex_abs_ops。首先，我们需要一个操作符集合。定义操作符的过程已经在第 36.14 节中讨论过。对于一个 B-树上的操作符类，我们需要的操作符有：
绝对值小于（策略 1）绝对值小于等于（策略 2）绝对值等于（策略 3）绝对值大于等于（策略 4）绝对值大于（策略 5）
定义一个比较操作符的相关集合最不容易出错的方式是，先编写 B-树比较支持函数，然后编写该支持函数的包装器函数。这降低了极端情况下得到不一致结果的几率。遵照这种方法，我们首先编写：
#define Mag(c)  ((c)->x*(c)->x + (c)->y*(c)->y)
static int
complex_abs_cmp_internal(Complex *a, Complex *b)
{
double      amag = Mag(a),
bmag = Mag(b);
if (amag < bmag)
return -1;
if (amag > bmag)
return 1;
return 0;
}
现在小于函数看起来像这样：
PG_FUNCTION_INFO_V1(complex_abs_lt);
Datum
complex_abs_lt(PG_FUNCTION_ARGS)
{
Complex    *a = (Complex *) PG_GETARG_POINTER(0);
Complex    *b = (Complex *) PG_GETARG_POINTER(1);
PG_RETURN_BOOL(complex_abs_cmp_internal(a, b) < 0);
}
其他四个函数的区别只在于它们如何比较内部函数的结果与 0。
接下来我们基于这些函数声明 SQL 的函数和操作符：
CREATE FUNCTION complex_abs_lt(complex, complex) RETURNS bool
AS 'filename', 'complex_abs_lt'
LANGUAGE C IMMUTABLE STRICT;
CREATE OPERATOR < (
leftarg = complex, rightarg = complex, procedure = complex_abs_lt,
commutator = > , negator = >= ,
restrict = scalarltsel, join = scalarltjoinsel
);
指定正确的交换子和求反器操作符很重要，合适的限制和连接选择度函数也是一样，否则优化器将无法有效地利用索引。
其他值得注意的事情：
只能有一个操作符被命名为=且两个操作数都为类型complex。在这种情况下，我们对于complex没有任何其他操作符=。但是如果我们是在构建一种实际的数据类型，我们可能想让=成为复数的普通等值操作（而不是绝对值的相等）。这样，我们需要为complex_abs_eq使用某种其他的操作符名称。
尽管PostgreSQL能够处理具有相同 SQL 名称的函数（只要它们具有不同的参数数据类型），但 C 只能处理具有给定名称的一个全局函数。因此，我们不能简单地把 C 函数命名为abs_eq之类的东西。通常，在 C 函数名中包括数据类型的名称是一种好习惯，这样就不会与其他数据类型的函数发生冲突。
我们可以让函数也具有abs_eq这样的 SQL 名称，而依靠PostgreSQL通过参数数据类型来区分它和其他同名 SQL 函数。为了保持例子的简洁，我们这里让 C 级别和 SQL 级别的函数具有相同的名称。
下一步是注册 B-树所要求的支持例程。实现支持例程的 C 代码例子在包含操作符函数的同一文件中。我们这样来声明该函数：
CREATE FUNCTION complex_abs_cmp(complex, complex)
RETURNS integer
AS 'filename'
LANGUAGE C IMMUTABLE STRICT;
现在我们已经有了所需的操作符和支持例程，就可以最终创建操作符类：
CREATE OPERATOR CLASS complex_abs_ops
DEFAULT FOR TYPE complex USING btree AS
OPERATOR        1       < ,
OPERATOR        2       <= ,
OPERATOR        3       = ,
OPERATOR        4       >= ,
OPERATOR        5       > ,
FUNCTION        1       complex_abs_cmp(complex, complex);
做好了！现在应该可以在complex列上创建并且使用 B-树索引了。
我们可以把操作符项写得更繁琐，像这样：
OPERATOR        1       < (complex, complex) ,
但是当操作符操作的数据类型和正在定义的操作符类所服务的数据类型相同时可以不用这么做。
上述例子假定这个新操作符类是complex数据类型的默认 B-树操作符类。如果不是这样，只需要省去关键词DEFAULT。
36.16.5. 操作符类和操作符族 #
到目前为止，我们暗地里假设一个操作符类只处理一种数据类型。虽然在一个特定的索引列中必定只有一种数据类型，但是把被索引列与一种不同数据类型的值比较的索引操作通常也很有用。还有，如果与一种操作符类相关的跨数据类型操作符有用，通常情况是其他数据类型也有其自身相关的操作符类。在相关的类之间建立起明确的联系会很有用，因为这可以帮助规划器进行 SQL 查询优化（尤其是对于 B-树操作符类，因为规划器包含了大量有关如何使用它们的知识）。
为了处理这些需求，PostgreSQL使用了操作符族的概念。一个操作符族包含一个或者多个操作符类，并且也能包含属于该族整体而不属于该族中任何单一类的可索引操作符和相应的支持函数。我们说这样的操作符和函数是“松散地”存在于该族中，而不是被绑定在一个特定的类中。通常每个操作符类包含单一数据类型的操作符，而跨数据类型操作符则松散地存在于操作符族中。
一个操作符族中的所有操作符和函数必须具有兼容的语义，其中的兼容性要求由索引方法设定。你可能因此而奇怪为什么要这么麻烦地把族的特定子集单另出来成为操作符类，并且实际上（由于很多原因）这种划分与操作符之间没有什么直接的关联，只有操作符族才是实际的分组。定义操作符类的原因是，它们指定了特定索引对操作符族的依赖程度。如果一个索引使用着一个操作符类，那么不删除该索引是不能删除该操作符类的 — 但是操作符族的其他部分（即其他操作符类和松散的操作符）可以被删除。因此，一个操作符类应该包含一个索引在特定数据类型上正常工作所需要的最小操作符和函数集合，而相关但不关键的操作符可以作为操作符族的松散成员被加入。
作为一个例子，PostgreSQL有一个内置的B-tree操作符族integer_ops，其中包括操作符类int8_ops、int4_ops和int2_ops，分别用于bigint（int8）、integer（int4）和smallint（int2）列的索引。该族还包含跨数据类型的比较运算符，允许这几种类型中的任意两种进行比较，因此可以使用另一种类型的比较值来搜索其中一种类型的索引。该族可以通过以下定义进行复制：
CREATE OPERATOR FAMILY integer_ops USING btree;
CREATE OPERATOR CLASS int8_ops
DEFAULT FOR TYPE int8 USING btree FAMILY integer_ops AS
-- standard int8 comparisons
OPERATOR 1 < ,
OPERATOR 2 <= ,
OPERATOR 3 = ,
OPERATOR 4 >= ,
OPERATOR 5 > ,
FUNCTION 1 btint8cmp(int8, int8) ,
FUNCTION 2 btint8sortsupport(internal) ,
FUNCTION 3 in_range(int8, int8, int8, boolean, boolean) ,
FUNCTION 4 btequalimage(oid) ,
FUNCTION 6 btint8skipsupport(internal) ;
CREATE OPERATOR CLASS int4_ops
DEFAULT FOR TYPE int4 USING btree FAMILY integer_ops AS
-- standard int4 comparisons
OPERATOR 1 < ,
OPERATOR 2 <= ,
OPERATOR 3 = ,
OPERATOR 4 >= ,
OPERATOR 5 > ,
FUNCTION 1 btint4cmp(int4, int4) ,
FUNCTION 2 btint4sortsupport(internal) ,
FUNCTION 3 in_range(int4, int4, int4, boolean, boolean) ,
FUNCTION 4 btequalimage(oid) ,
FUNCTION 6 btint4skipsupport(internal) ;
CREATE OPERATOR CLASS int2_ops
DEFAULT FOR TYPE int2 USING btree FAMILY integer_ops AS
-- standard int2 comparisons
OPERATOR 1 < ,
OPERATOR 2 <= ,
OPERATOR 3 = ,
OPERATOR 4 >= ,
OPERATOR 5 > ,
FUNCTION 1 btint2cmp(int2, int2) ,
FUNCTION 2 btint2sortsupport(internal) ,
FUNCTION 3 in_range(int2, int2, int2, boolean, boolean) ,
FUNCTION 4 btequalimage(oid) ,
FUNCTION 6 btint2skipsupport(internal) ;
ALTER OPERATOR FAMILY integer_ops USING btree ADD
-- cross-type comparisons int8 vs int2
OPERATOR 1 < (int8, int2) ,
OPERATOR 2 <= (int8, int2) ,
OPERATOR 3 = (int8, int2) ,
OPERATOR 4 >= (int8, int2) ,
OPERATOR 5 > (int8, int2) ,
FUNCTION 1 btint82cmp(int8, int2) ,
-- cross-type comparisons int8 vs int4
OPERATOR 1 < (int8, int4) ,
OPERATOR 2 <= (int8, int4) ,
OPERATOR 3 = (int8, int4) ,
OPERATOR 4 >= (int8, int4) ,
OPERATOR 5 > (int8, int4) ,
FUNCTION 1 btint84cmp(int8, int4) ,
-- cross-type comparisons int4 vs int2
OPERATOR 1 < (int4, int2) ,
OPERATOR 2 <= (int4, int2) ,
OPERATOR 3 = (int4, int2) ,
OPERATOR 4 >= (int4, int2) ,
OPERATOR 5 > (int4, int2) ,
FUNCTION 1 btint42cmp(int4, int2) ,
-- cross-type comparisons int4 vs int8
OPERATOR 1 < (int4, int8) ,
OPERATOR 2 <= (int4, int8) ,
OPERATOR 3 = (int4, int8) ,
OPERATOR 4 >= (int4, int8) ,
OPERATOR 5 > (int4, int8) ,
FUNCTION 1 btint48cmp(int4, int8) ,
-- cross-type comparisons int2 vs int8
OPERATOR 1 < (int2, int8) ,
OPERATOR 2 <= (int2, int8) ,
OPERATOR 3 = (int2, int8) ,
OPERATOR 4 >= (int2, int8) ,
OPERATOR 5 > (int2, int8) ,
FUNCTION 1 btint28cmp(int2, int8) ,
-- cross-type comparisons int2 vs int4
OPERATOR 1 < (int2, int4) ,
OPERATOR 2 <= (int2, int4) ,
OPERATOR 3 = (int2, int4) ,
OPERATOR 4 >= (int2, int4) ,
OPERATOR 5 > (int2, int4) ,
FUNCTION 1 btint24cmp(int2, int4) ,
-- cross-type in_range functions
FUNCTION 3 in_range(int4, int4, int8, boolean, boolean) ,
FUNCTION 3 in_range(int4, int4, int2, boolean, boolean) ,
FUNCTION 3 in_range(int2, int2, int8, boolean, boolean) ,
FUNCTION 3 in_range(int2, int2, int4, boolean, boolean) ;
注意，这一定义“重载”了运算符策略和支持函数编号：每个编号在该族中出现多次。只要每个特定编号的实例具有不同的输入数据类型，这种情况是允许的。输入类型都等于运算符类输入类型的实例是该运算符类的主要运算符和支持函数，在大多数情况下应作为运算符类的一部分声明，而不是作为该族的松散成员。
如第 65.1.2 节中的细节所述，在一个B-树操作符族中，所有该族中的操作符必须以兼容的方式排序。对该族中的每一个操作符都必须有一个与该操作符具有相同的两个输入数据类型的支持函数。我们推荐让操作符族保持完整，即对每一种数据类型的组合都应该包括所有的操作符。每个操作符类只应该包括非跨类型操作符和用于其数据类型的支持函数。
为了构建一个多数据类型的哈希操作符族，必须为该族支持的每一种数据类型创建相兼容的哈希支持函数。这里的兼容性是指这些函数对于任意两个被该族中等值操作符认为相等的值会保证返回相同的哈希码，即便这些值具有不同的类型时也是如此。当这些类型具有不同的物理表示时，这通常难以实现，但是在某些情况下是可以做到的。此外，将该操作符族中一种数据类型的值通过隐式或者二进制强制造型转换成该族中另一种数据类型时，不应该改变所计算出的哈希值。注意每种数据类型只有一个支持函数，而不是每个等值操作符一个。我们推荐让操作符族保持完整，即对每一种数据类型的组合提供一个等值操作符。每个操作符类只应该包括非跨类型等值操作符和用于其数据类型的支持函数。
GiST、SP-GiST和GIN索引没有任何明显的跨数据类型操作的概念。它们所支持的操作符集合就是一个给定操作符类能够处理的主要支持函数。
在 BRIN 中，需求取决于提供操作符类的框架。对于基于minmax的操作符类，必要的行为和 B-树操作符族相同：族中的所有操作符必须以兼容的方式排序，并且转换不能改变相关的排序顺序。
注意
在PostgreSQL 8.3 之前，没有操作符族的概念，因此要在索引中使用的任何跨数据类型操作符必须被直接绑定到该索引的操作符类中。虽然这种方法仍然有效，但是已被废弃，因为它会让索引的依赖过于广泛，还因为当两种数据类型都在同一操作符族中有操作符时，规划器可以更有效地处理跨数据类型比较。
36.16.6. 操作符类上的系统依赖 #
PostgreSQL使用操作符类来以更多方式推断操作符的属性，而不仅仅是它们是否能被用于索引。因此，即便不准备对你的数据类型的列建立索引，也可能想要创建操作符类。
特别地，ORDER BY和DISTINCT等 SQL 特性要求对值的比较和排序。为了在用户定义的数据类型上实现这些特性，PostgreSQL会为数据类型查找默认 B-树操作符类。这个操作符类的“equals”成员定义了用于GROUP BY和DISTINCT的值的等值概念，而该操作符类施加的排序顺序定义了默认的ORDER BY顺序。
如果一种数据类型没有默认的 B-树操作符类，系统将查找默认的哈希操作符类。但由于这类操作符类只提供等值，所以它只能支持分组而不能支持排序。
在一种数据类型没有默认操作符类时，如果尝试对该数据类型使用这些 SQL 特性，你将得到类似“could not identify an ordering operator”（无法标识排序操作符）的错误。
注意
在版本 7.4 以前的PostgreSQL中，排序和分组操作将隐式地使用名为=、<以及>的操作符。新的依赖于默认操作符类的行为避免了对具有特定名字的操作符行为作出任何假设。
通过在一个USING选项中指定一个非默认B-树操作符类的小于操作符，可以使用该操作符进行排序，例如
SELECT * FROM mytable ORDER BY somecol USING ~<~;
或者，在USING中指定该操作符类的大于操作符可以选择降序的排序。
用户定义类型的数组的比较还依赖于该类型的默认B-树操作符类所定义的语义。如果没有默认的B-树操作符类，但有一个默认的哈希操作符类，则支持数组的相等比较，但不支持顺序的比较。
另一种要求更多数据类型相关知识的SQL特性是窗口函数（见第 4.2.8 节）的RANGE offset PRECEDING/FOLLOWING帧选项。对于这样的一个查询
SELECT sum(x) OVER (ORDER BY x RANGE BETWEEN 5 PRECEDING AND 10 FOLLOWING)
FROM mytable;
不足以了解如何用x进行排序，数据库还必须理解如何对当前行的x值“减5”或者“加10”以标识当前窗口帧的边界。把得到的边界与其他行的x值用B-树操作符类提供的比较操作符（定义了ORDER BY顺序）进行比较是可能的 — 但是加和减操作符并不是该操作符类的一部分，因此应该用哪些操作符呢？硬编码的选择是不切实际的，因为不同的排序顺序（不同的B-树操作符）可能需要不同的行为。因此，一个B-树操作符类可以指定一个in_range支持函数，它封装有对排序顺序有意义的加和减行为。如果有多种数据类型可以用作RANGE子句中的偏移量，甚至可以提供多个in_range支持函数。如果与窗口的ORDER BY子句关联的B-树操作符类没有一个匹配的in_range支持函数，则不支持RANGE offset PRECEDING/FOLLOWING选项。
另一个要点是，出现在一个哈希操作符族中的操作符是哈希连接、哈希聚集和相关优化的候选。这些情况下哈希操作符族就是至关重要的，因为它标识了要使用的哈希函数。
36.16.7. 排序操作符 #
有些索引访问方法（当前只有 GiST和SP-GiST）支持排序操作符的概念。到目前为止我们所讨论的都是搜索操作符。搜索索引时，会用搜索操作符来寻找所有满足
WHERE
indexed_column
operator
constant
的行。注意被返回的匹配行的顺序是没有任何保证的。相反，一个排序操作符并不限制能被返回的行集合，而是决定它们的顺序。扫描索引时，会使用排序操作符来以
ORDER BY
indexed_column
operator
constant
所表示的顺序返回行。这样定义排序操作符的原因是，如果该操作符能度量距离，它就能支持最近邻搜索。例如，这样的一个查询
SELECT * FROM places ORDER BY location <-> point '(101,456)' LIMIT 10;
寻找离一个给定目标点最近的十个位置。位置列上的 GiST 索引可以有效地完成这个查询，因为<->是一个排序操作符。
搜索操作符必须返回布尔结果，排序操作符通常返回某种其他类型，例如浮点、数字或者距离。这种类型通常不同于被索引的数据类型。为了避免硬编码有关不同数据类型行为的假设，需要定义一个排序操作符来提名一个 B-树操作符族指定结果数据类型的排序顺序。正如我们在前一节介绍的，B-树操作符族定义了PostgreSQL的顺序概念，因此这是一种自然的表达。由于点<->操作符返回float8，可以在一个操作符类创建命令中这样指定它：
OPERATOR 15    <-> (point, point) FOR ORDER BY float_ops
其中float_ops是包括float8上操作的内建操作符族。这种声明说明该索引能够以<->操作符的递增值顺序返回行。
36.16.8. 操作符类的特性 #
有两个操作符类的特性我们还没有讨论，主要是因为它们对于最常用的索引方法不太有用。
通常，把一个操作符声明为一个操作符类（或操作符族）的成员意味着该索引方法能够使用该操作符准确地检索满足WHERE条件的行集。例如：
SELECT * FROM table WHERE integer_column < 4;
恰好可以被该整数列上一个 B-树索引满足。但是也有情况下索引只是作为匹配行的非精确向导。例如，如果一个 GiST 索引只存储几何对象的边界框，那么它无法精确地满足测试非矩形对象（如多边形）之间相交的WHERE条件。但是我们可以使用该索引来寻找边界框与目标对象的边界框相交的对象，并且只在通过该索引找到的对象上做精确的相交测试。如果适用于这种场景，该索引被称为对该操作符是“有损的”。有损索引搜索通过在一行可能满足或者不满足该查询条件时返回一个recheck标志来实现。核心系统将接着在检索到的行上测试原始查询条件来看它是否应该被作为一个合法匹配返回。如果索引被保证能返回所有所需的行外加一些额外的行，这种方法就能有效，因为那些额外的行可以通过执行原始的操作符调用来消除。支持有损搜索的索引方法（当前有 GiST、SP-GiST 和 GIN）允许个别操作符类的支持函数设置 recheck 标志，因此这也是一种操作符类的重要特性。
再次考虑在索引中只存储复杂对象（如多边形）的边界框的情况。在这种情况下，把整个多边形存储在索引项中没有很大价值 — 我们也可以只存储一个更简单的box类型对象。这种情况通过CREATE OPERATOR CLASS中的STORAGE选项表示：
CREATE OPERATOR CLASS polygon_ops
DEFAULT FOR TYPE polygon USING gist AS
...
STORAGE box;
当前，只有 GiST、SP-GiST、GIN 和 BRIN 索引方法支持不同于列数据类型的STORAGE类型。在使用STORAGE时，GiST 的支持例程compress和decompress必须处理数据类型转换。SP-GiST 同样需要 compress 支持函数来转换为存储类型（当存储类型不同时）； 如果 SP-GiST opclass 也支持检索数据，则反向转换必须由 consistent 函数处理。在 GIN 中，STORAGE类型标识“key”值的类型，它通常不同于被索引列的类型 — 例如，一个用于整数数组列的操作符类可能具有整数键值。GIN 的支持例程extractValue和extractQuery负责从被索引值中抽取键。BRIN 类似于 GIN：STORAGE类型标识被存储的摘要值的类型，而操作符类的支持过程负责正确解释摘要值。
上一页 上一级 下一页36.15. 操作符优化信息 起始页 36.17. 打包相关对象到扩展中
