# 65.3. SP-GiST索引

65.3. SP-GiST索引
版本：
纠错本页面
搜索
目录导航
❮
❯
65.3. SP-GiST索引 #65.3.1. 简介65.3.2. 内建操作符类65.3.3. 可扩展性65.3.4. 实现65.3.5. 示例65.3.1. 简介 #
SP-GiST是空间划分GiST的简称。SP-GiST支持划分搜索树，它们可用于开发许多各种不同的非平衡数据结构，例如四叉树、k-d树和基数树（trie）。这些结构的共同特征是它们反复地将搜索空间划分成大小不需要相等的分区。匹配这些划分规则的搜索将会很快。
这些常用的数据结构最初是为在内存中使用而设计的。在主存中，它们通常被设计为一组由指针链接的动态分配的节点。这对直接在磁盘上存储并不合适，因为这些指针链可能很长并且需要太多次的磁盘访问。相反，基于磁盘的数据结构应该具有高扇出来最小化 I/O。SP-GiST所提出的挑战是将搜索树节点映射到磁盘页面，这样即使是一次搜索会穿过很多节点，它也只需要访问很少的几个磁盘页面。
和GiST一样，SP-GiST也打算允许带有合适访问方法的自定义数据类型的开发，这种开发只需由该数据类型的领域专家参与，而不需要数据库专家的参与。
这里的一些信息是来自于普渡大学的 SP-GiST 索引项目网站。PostgreSQL中的SP-GiST实现主要由 Teodor Sigaev 和 Oleg Bartunov 维护，在他们的
网站上有更多信息。
65.3.2. 内建操作符类 #
PostgreSQL核心发布包括在
表 65.2中显示的SP-GiST操作符类。
表 65.2. 内置 SP-GiST 操作符类名称可索引操作符排序操作符box_ops<< (box,box)<-> (box,point)&< (box,box)&> (box,box)>> (box,box)<@ (box,box)@> (box,box)~= (box,box)&& (box,box)<<| (box,box)&<| (box,box)|&> (box,box)|>> (box,box)inet_ops<< (inet,inet) <<= (inet,inet)>> (inet,inet)>>= (inet,inet)= (inet,inet)<> (inet,inet)< (inet,inet)<= (inet,inet)> (inet,inet)>= (inet,inet)&& (inet,inet)kd_point_ops|>> (point,point)<-> (point,point)<< (point,point)>> (point,point)<<| (point,point)~= (point,point)<@ (point,box)poly_ops<< (polygon,polygon)<-> (polygon,point)&< (polygon,polygon)&> (polygon,polygon)>> (polygon,polygon)<@ (polygon,polygon)@> (polygon,polygon)~= (polygon,polygon)&& (polygon,polygon)<<| (polygon,polygon)&<| (polygon,polygon)|>> (polygon,polygon)|&> (polygon,polygon)quad_point_ops|>> (point,point)<-> (point,point)<< (point,point)>> (point,point)<<| (point,point)~= (point,point)<@ (point,box)range_ops= (anyrange,anyrange) && (anyrange,anyrange)@> (anyrange,anyelement)@> (anyrange,anyrange)<@ (anyrange,anyrange)<< (anyrange,anyrange)>> (anyrange,anyrange)&< (anyrange,anyrange)&> (anyrange,anyrange)-|- (anyrange,anyrange)text_ops= (text,text) < (text,text)<= (text,text)> (text,text)>= (text,text)~<~ (text,text)~<=~ (text,text)~>=~ (text,text)~>~ (text,text)^@ (text,text)
在用于类型point的两种操作符类中，quad_point_ops是默认值。kd_point_ops
支持相同的操作符，但使用不同的索引数据结构，在某些应用中可能提供更好的性能。
quad_point_ops、kd_point_ops 和 poly_ops 操作符类支持<->
排序操作符，允许在索引点或多边形数据集上进行k-最近邻(k-NN)搜索。
65.3.3. 可扩展性 #
SP-GiST提供了一个高抽象层次的接口，要求访问方法开发者仅实现与特定数据类型相关的方法。SP-GiST核心
负责高效的磁盘映射和树结构的搜索。它还处理并发和日志相关的考虑。
SP-GiST树的叶子元组通常包含与被索引列相同数据类型的值，尽管它们也可能包含被索引列的有损表示。
存储在根层的叶子元组将直接表示原始的被索引数据值，但较低层的叶子元组可能仅包含部分值，例如后缀。
在这种情况下，操作符类支持函数必须能够使用从内部元组中积累的信息重构原始值，这些内部元组是指在到达叶子层过程中经过的元组。
当SP-GiST索引与INCLUDE列一起建立时，那些列的值也存储在叶子元组里。
INCLUDE列不涉及SP-GiST操作符类，所以在此不更多讨论。
内部元组更加复杂，因为它们是搜索树的分支点。每一个内部元组包含一个或者更多个节点，节点表示一个具有相似叶子值的组。一个节点包含一个向下的链接，这个链接可以导向另一个较下层的内部元组，或者是由位于同一索引页面的叶子元组组成的一个短列表。每一个节点通常还有一个标签来描述它，例如，在一个 radix 树中节点标签可以是串值的下一个字符（或者，如果一种操作符类对于所有内部元组使用一个固定的节点集合，则它可以省略节点标签，见第 65.3.4.2 节）。可选地，一个内部元组可以有一个前缀值来描述它所有的成员。在一个 radix 树中前缀可以是所表示的串的公共前缀。前缀值并不一定非要是一个真正的前缀，它可以是操作符类需要的任何数据。例如，在一个四叉树中它可以存储用于划分四个象限的中心点。一个四叉树的内部元组则可以包含对应于围绕该中心点的象限的四个节点。
某些树算法要求当前元组所在层（或深度）的知识，因此SP-GiST核心为操作符类提供了机会以便在沿着树下降时管理层计数。当需要重组被表示的值时，这也可以为增量地重构过程提供支持，这还可以为沿着树下降时向下层传递附加数据（称为遍历值）提供支持。
注意
SP-GiST核心代码会关注空项。尽管SP-GiST索引确实可以存储被索引列中的空值，但这对索引操作符类代码是隐藏的：不会有空索引项或搜索条件会被传递给操作符类方法（我们假定SP-GiST操作符是严格的并且因此无法成功处理空值）。因此这里不会进一步讨论空值。
一个SP-GiST的索引操作符类必须提供五个用户定义的方法，并且两个是可选的。所有五个强制的方法都接受两个internal参数，其中第一个是一个指针，它指向一个包含用于支持方法的值的 C 结构。而第二个参数也是一个指针，它指向将放置输出值的 C 结构。其中四个强制的函数只返回void，因为它们的所有结果都出现在输出结构中。但是leaf_consistent会返回一个boolean结果。这些方法不能修改它们的输入结构的任何域。在所有情况下，调用用户定义的方法之前输出结构都被初始化为零。可选的第六个方法compress接受要被索引的datum作为唯一的参数并且返回适合于在叶子元组中物理存储的值。可选的第七个方法 options 接受一个指向 C 结构的 internal 指针，其中应放置 opclass 特定的参数，并返回 void。
五个强制的用户定义的方法是：
config
返回关于索引实现的静态信息，包括前缀和节点标签数据类型的OID。
这个函数的SQL声明必须看起来像这样：
CREATE FUNCTION my_config(internal, internal) RETURNS void ...
第一个参数是一个指向spgConfigIn C 结构的指针，包含该函数的输入数据。第二个参数是一个指向spgConfigOut C 结构的指针，函数必须将结果数据填充在其中。
typedef struct spgConfigIn
{
Oid         attType;        /* 要被索引的数据类型 */
} spgConfigIn;
typedef struct spgConfigOut
{
Oid         prefixType;     /* 内部元组前缀的数据类型 */
Oid         labelType;      /* 内部元组节点标签的数据类型 */
Oid         leafType;       /* 叶子元组值的数据类型 */
bool        canReturnData;  /* 操作符类能重构原始数据 */
bool        longValuesOK;   /* 操作符类能处理值 > 1 页 */
} spgConfigOut;
为了支持多态的索引操作符类，attType要被传入；对于普通固定数据类型的操作符类，它将总是取相同的值，因此可以被忽略。
对于不使用前缀的操作符类，prefixType可以被设置为VOIDOID。同样，对于不使用节点标签的操作符类，labelType可以被设置为VOIDOID。如果操作符类能够重构出原来提供的被索引值，则canReturnData应该被设置为真。只有当attType是变长的并且操作符类能够将长值通过反复的添加后缀分段时，longValuesOK才应当被设置为真（参见第 65.3.4.1 节）。
leafType应该匹配由操作符类的opckeytype目录条目定义的索引存储类型。
(注意opckeytype可以为零，意味着存储类型与操作符类的输入类型相同，这是最常见的情况。)
鉴于向后兼容的原因，config方法可以将leafType设置为其他值，并且该值将被使用；但这是不推荐的，因为索引内容会在目录中被错误地标识。
此外，它是允许保留leafType非初始化（零）；也就是说可以理解为从opckeytype派生的索引存储类型。
当attType和leafType不相同时，必须提供可选的compress方法。
方法compress负责把要被索引的数据从attType转换为leafType。
choose
为将一个新值插入到一个内部元组选择一种方法。
该函数的SQL声明必须看起来像这样：
CREATE FUNCTION my_choose(internal, internal) RETURNS void ...
第一个参数是一个指向spgChooseIn C 结构的指针，包含该函数的输入数据。第二个参数是一个指向spgChooseOut C 结构的指针，函数必须将结果数据填充在其中。
typedef struct spgChooseIn
{
Datum       datum;          /* 要被索引的原始数据 */
Datum       leafDatum;      /* 要被存储在叶子中的当前数据 */
int         level;          /* 当前层（从零计数） */
/* 来自当前内部元组的数据 */
bool        allTheSame;     /* tuple is marked all-the-same? */
bool        hasPrefix;      /* 元组有一个前缀？ */
Datum       prefixDatum;    /* 如果有，前缀值 */
int         nNodes;         /* 内部元组中的节点数目 */
Datum      *nodeLabels;     /* 节点标签值（如果没有为 NULL） */
} spgChooseIn;
typedef enum spgChooseResultType
{
spgMatchNode = 1,           /* 下降到现有节点 */
spgAddNode,                 /* 向内部元组增加一个节点 */
spgSplitTuple               /* 划分内部元组（修改它的前缀） */
} spgChooseResultType;
typedef struct spgChooseOut
{
spgChooseResultType resultType;     /* 动作代码，见上文 */
union
{
struct                  /* 用于spgMatchNode的结果 */
{
int         nodeN;      /* 下降到这个节点（索引从 0 开始） */
int         levelAdd;   /* 这次匹配增加的层 */
Datum       restDatum;  /* 新叶数据 */
}           matchNode;
struct                  /* 用于spgAddNode的结果 */
{
Datum       nodeLabel;  /* 新节点的标签 */
int         nodeN;      /* 在哪里插入它（索引从 0 开始） */
}           addNode;
struct                  /* 用于spgSplitTuple的结果 */
{
/* 来自有一个子元组的新上层内部元组的信息 */
bool        prefixHasPrefix;    /* 元组能有前缀吗？ */
Datum       prefixPrefixDatum;  /* 如果有，前缀值 */
int         prefixNNodes;       /* 节点的数目 */
Datum      *prefixNodeLabels;   /* 它们的标签（NULL表示无标签）*/
int         childNodeN;         /* 哪个节点有子元组 */
/* 来自放有所有旧节点的新下层内部元组的信息 */
bool        postfixHasPrefix;   /* 元组能有前缀吗？ */
Datum       postfixPrefixDatum; /* 如果有，前缀值 */
}           splitTuple;
}           result;
} spgChooseOut;
datum是要被插入到该索引中的spgConfigIn.attType类型的原始数据。leafDatum是一个spgConfigOut.leafType类型的值，它最初是方法compress应用到datum上的结果（如果提供了方法compress）或者是和datum相同的值（如果没有提供compress方法）。但是如果choose或picksplit改变了它，那么位于树的较低层的leafDatum值可能会改变。当插入搜索到达一个叶子页，leafDatum的当前值就会被存储在新创建的叶子元组中。level是当前内部元组的层次，根层是 0 。如果当前内部元组被标记为包含多个等价节点（见第 65.3.4.3 节），allTheSame为真。如果当前内部元组有一个前缀，hasPrefix为真，如果这样，prefixDatum为前缀值。nNodes是包含在内部元组中子节点的数量，并且nodeLabels是这些子节点的标签值的数组，如果没有标签则为 NULL。
choose函数能决定新值是匹配一个现有子节点，或是必须增加一个新的子节点，亦或是新值和元组的前缀不一致并且因此该内部元组必须被分裂来创建限制性更低的前缀。
如果新值匹配一个现有的子节点，将resultType设置为spgMatchNode。将nodeN设置为该节点在节点数组中的索引（从零开始）。将levelAdd设置为传到该节点导致的level增加，或者在操作符类不使用层数时将它置为零。如果操作符类没有把数据从一层修改到下一层，将restDatum设置为等于leafDatum，否则将它设置为在下一层用作leafDatum的被修改后的值。
如果必须增加一个新的子节点，将resultType设置为spgAddNode。将nodeLabel设置为在新节点中使用的标签，并将nodeN设置为插入该节点的位置在节点数组中的索引（从零开始）。在节点被增加之后，choose函数将被再次调用并使用修改后的内部元组，那时将会导致一个spgMatchNode结果。
如果新值和元组的前缀不一致，将resultType设置为spgSplitTuple。这个动作将所有现有的节点移动到一个新的下层内部元组，并且将现有的内部元组用一个新元组替换，该元组只有一个到那个新的下层内部元组的向下链接。将prefixHasPrefix设置为指示新的上层元组是否具有一个前缀，并且如果有前缀时设置prefixPrefixDatum为前缀值。这个新的前缀值必须比原来的值要足够宽松以便能够接受将被索引的新值。将prefixNNodes设置为新元组中所需的节点数，并且将prefixNodeLabels设置为一个已分配的保存它们的标签的数组，或者在不要求节点标签时设置为NULL。注意新上层元组的总尺寸必须不超过它所替换的元组的总尺寸，这限制了新前缀和新标签的长度。将childNodeN设置为将下链到新的下层内部元组的节点的索引（从零开始）。设置postfixHasPrefix表示新的下层内部元组是否应该有一个前缀，并且如果应该有前缀的情况下设置postfixPrefixDatum为前缀值。这两种前缀以及下链节点的标签（如果有）的组合必须具有与原始前缀相同的含义，因为没有机会修改被移动到新下层元组的节点标签，也不能更改任何子索引项。在该节点被分裂后，将再次用替换的内元组调用choose函数。如果spgSplitTuple动作没有创建出合适的节点，该调用可以返回一个spgAddNode结果。最终choose必须返回spgMatchNode以允许插入下降到下一层次中。
picksplit
决定如何在一组叶子元组上创建一个新的内部元组。
该函数的SQL声明必须看起来像这样：
CREATE FUNCTION my_picksplit(internal, internal) RETURNS void ...
第一个参数是一个指向spgPickSplitIn C 结构的指针，包含该函数的输入数据。第二个参数是一个指向spgPickSplitOut C 结构的指针，函数必须将结果数据填充在其中。
typedef struct spgPickSplitIn
{
int         nTuples;        /* 叶子元组的数量 */
Datum      *datums;         /* 它们的数据（长度为 nTuples 的数组） */
int         level;          /* 当前层次（从零开始计） */
} spgPickSplitIn;
typedef struct spgPickSplitOut
{
bool        hasPrefix;      /* 新内部元组应该有一个前缀吗？ */
Datum       prefixDatum;    /* 如果有，前缀值 */
int         nNodes;         /* 新内部元组的节点数 */
Datum      *nodeLabels;     /* 它们的标签（没有标签则为NULL） */
int        *mapTuplesToNodes;   /* 每一个叶子元组的节点索引 */
Datum      *leafTupleDatums;    /* 存储在每一个新叶子元组中的数据 */
} spgPickSplitOut;
nTuples是提供的叶子元组的数目。datums是它们的spgConfigOut.leafType类型的数据值的数组。level是所有这些叶子元组共享的当前层，它将成为新内部元组所在的层次。
将hasPrefix设置为指示新内部元组是否应该有前缀，并且如果有前缀则将prefixDatum设置成前缀值。将nNodes设置为新内部元组将包含的节点数目，并且将nodeLabels设置为它们的标签值的数组或者 NULL（如果节点不要求标签）。将mapTuplesToNodes设置为一个数组，该数组告诉每一个叶子元组应该被赋予的节点的索引（从零开始）。将leafTupleDatums设置为由将要被存储在新叶子元组中的值构成的一个数组（如果操作符类不将数据从一层修改到下一层，这些值将和输入的datums相同）。注意picksplit函数负责为nodeLabels、mapTuplesToNodes和leafTupleDatums数组进行 palloc。
如果提供了多于一个叶子元组，picksplit被寄望于将它们分类到多于一个节点中；否则不可能将叶子元组划分到多个页面，这也是这个操作的终极目的。因此，如果picksplit函数结束时把所有叶子元组放在同一个节点中，核心SP-GiST代码将覆盖该决定，并且生成一个内部元组，将叶子元组随机分配到多个相同标签的节点。这样一个元组被标记为allTheSame来表示发生了这种情况。choose和inner_consistent函数必须对这样的内部元组采取合适的处理。详见第 65.3.4.3 节。
picksplit只能在一种情况下被应用在单独一个叶子元组上，这种情况是config函数将longValuesOK设置为真并且提供了一个长于一页的输入。在这种情况下，该操作的要点是剥离一个前缀并且产生一个新的、较短的叶子数据值。这种调用将被重复直到产生一个足够短能够放入到一页的叶子数据。详见第 65.3.4.1 节。
inner_consistent
在树搜索过程中返回一组要跟随的节点（分支）。
该函数的SQL声明必须看起来像这样：
CREATE FUNCTION my_inner_consistent(internal, internal) RETURNS void ...
第一个参数是一个指向spgInnerConsistentIn C 结构的指针，包含该函数的输入数据。第二个参数是一个指向spgInnerConsistentOut C 结构的指针，函数必须将结果数据填充在其中。
typedef struct spgInnerConsistentIn
{
ScanKey     scankeys;       /* 操作符和比较值的数组 */
ScanKey     orderbys;       /* 排序运算符和比较值 */
int         nkeys;          /* 扫描键数组的长度 */
int         norderbys;      /* 排序数组的长度 */
Datum       reconstructedValue;     /* 在父节点中的重构值 */
void       *traversalValue; /* 操作符类相关的贯穿值 */
MemoryContext traversalMemoryContext;   /* 把新的贯穿值放在这里 */
int         level;          /* 当前层次（从零开始计） */
bool        returnData;     /* 是否必须返回原始数据？ */
/* 来自当前内元组的数据 */
bool        allTheSame;     /* 元组被标记为完全相同？ */
bool        hasPrefix;      /* 元组有前缀？ */
Datum       prefixDatum;    /* 如果有，前缀值 */
int         nNodes;         /* 内元组中的节点数 */
Datum      *nodeLabels;     /* 节点标签值（没有就是 NULL） */
} spgInnerConsistentIn;
typedef struct spgInnerConsistentOut
{
int         nNodes;         /* 要被访问的子节点数 */
int        *nodeNumbers;    /* 它们在节点数组中的索引 */
int        *levelAdds;      /* 为每个子节点要增加的层数 */
Datum      *reconstructedValues;    /* 相关的重构值 */
void      **traversalValues;        /* 操作符类相关的贯穿值 */
double    **distances;              /* 关联距离 */
} spgInnerConsistentOut;
长度为nkeys的数组scankeys描述了索引搜索条件。
这些条件用 AND 组合 — 只对满足所有条件的索引项感兴趣（注意，nkeys = 0 表示所有索引项满足该查询）。
通常一致函数只关心每个数组项的sk_strategy和sk_argument，它们分别给出了可索引操作符和比较值。
特别要说明的是，没有必要去检查sk_flags来看比较值是否为 NULL，因为 SP-GiST 的核心代码会过滤这样的条件。
数组orderbys，长度norderbys，以相同的方式描述排序运算符（如果有）。
reconstructedValue是用于父元组的重构值，在根层时或者如果inner_consistent函数没有在父层提供一个值时，它为(Datum) 0。
traversalValue是任意贯穿数据的指针，该数据由父索引元组上的上一次inner_consistent调用传递下来，在根层上这个指针为 NULL。
traversalMemoryContext是用于存放输出的贯穿值（见下文）的内存上下文。
level是当前内元组层次，根层是 0。
如果这个查询要求重构的数据，returnData是true。
如果config断言canReturnData，returnData只会是true。
如果当前的内元组被标记为“完全一样”，那么allTheSame为真。
在这种情况下，所有的节点都具有相同的标签（如果有），而且它们要么全部匹配该查询，要么一个都不匹配查询（见第 65.3.4.3 节）。
如果当前内元组包含一个前缀，则hasPrefix为真。
如果这样，prefixDatum就是该前缀的值。
nNodes是包含在内元组中的子节点的数量，nodeLabels是它们的标签值的数组。
当然如果节点没有标签，这个数组就为 NULL。
nNodes必须被设置为搜索需要访问的子节点数，并且nodeNumbers必须被设置为子节点索引的数组。
如果操作符类跟踪层次，把levelAdds设置成一个数组，其中说明了在下降到要被访问的每一个节点时需要增加的层数（通常这些增量对于所有节点都是相同的，但是并不一定如此，所以需要使用一个数组）。
如果需要值重构，将reconstructedValues设置为一个值的数组，这些值是为要被访问的每一个子节点构造的。
否则，把reconstructedValues留为NULL。
重构值假设为spgConfigOut.leafType类型。
(无论如何, 因为内核系统将不会对它们做什么，除了可能的拷贝它们，具有与leafType一样的typlen和typbyval属性对它们是足够的。
如果执行有序搜索，根据orderbys数组，设置distances为距离值数组。
（距离最短的节点将首先处理）。
否则，保留它为空。
如果想要把额外的带外信息（“遍历值”）向下传递给树搜索的较低层，可以把traversalValues设置成合适的遍历值的数组，其中每一个元素用于一个要被访问的子节点。
如果不需要传递额外的带外信息，则把traversalValues设置为 NULL。
注意，inner_consistent函数负责在当前内存上下文中分配nodeNumbers、levelAdds、distances、reconstructedValues和traversalValues数组。
不过，任何由traversalValues数组指向的输出遍历值应该在traversalMemoryContext中分配。
每一个遍历值必须是一个单独分配的块。
leaf_consistent
如果一个叶子元组满足一个查询则返回真。
该函数的SQL声明必须看起来像这样：
CREATE FUNCTION my_leaf_consistent(internal, internal) RETURNS bool ...
第一个参数是一个指向spgLeafConsistentIn C 结构的指针，包含该函数的输入数据。第二个参数是一个指向spgLeafConsistentOut C 结构的指针，函数必须将结果数据填充在其中。
typedef struct spgLeafConsistentIn
{
ScanKey     scankeys;       /* 操作符和比较值的数组 */
ScanKey     orderbys;       /* 排序运算符和比较值 */
int         nkeys;          /* 扫描键数组的长度 */
int         norderbys;      /* 排序数组的长度 */
Datum       reconstructedValue;     /* 在父节点重构的值 */
void       *traversalValue; /* 操作符类相关的遍历值 */
int         level;          /* 当前层次（从零开始计） */
bool        returnData;     /* 是否必须返回原始数据？ */
Datum       leafDatum;      /* 叶子元组中的数据 */
} spgLeafConsistentIn;
typedef struct spgLeafConsistentOut
{
Datum       leafValue;        /* 重构的原始数据，如果有 */
bool        recheck;          /* 如果操作符必须被重新检查则设为真 */
bool        recheckDistances; /* 如果距离必须被重新检查，设置为 true */
double     *distances;        /* 关联距离 */
} spgLeafConsistentOut;
长度为nkeys的数组scankeys描述了索引搜索条件。
这些条件用 AND 组合在一起 — 只有满足所有条件的索引项才满足该查询（注意nkeys = 0 表示所有的索引项都满足查询）。
通常 consistent 函数只关注每一个数组项的sk_strategy和sk_argument域，它们分别给出了可索引操作符和比较值。
特别是它无需检查sk_flags来检查比较值是否为 NULL，因为 SP-GiST 核心代码将过滤掉这类条件。
数组orderbys，长度norderbys，以相同的方式描述排序运算符。
reconstructedValue是为父元组重构的值，在根层或者当inner_consistent没有提供父层上的值时，它是(Datum) 0。
traversalValue是任意遍历数据的指针，该数据由父索引元组上的上一次inner_consistent调用传递下来，在根层上这个指针为 NULL。
level是当前的叶子元组所在的层次，根层为零。如果这个查询要求重构的数据，则returnData为true。
只有在config函数主张了canReturnData时才会如此。
leafDatum是存储在当前叶子元组中的spgConfigOut.leafType的键值。
如果叶子元组匹配查询，则该函数必须返回true，否则返回false。
在返回true的情况中，如果returnData为true，则leafValue必须被设置为最初为构建这个叶子元组提供的（spgConfigIn.attType类型）值。
还有，如果匹配是不确定的并且操作符必须被重新应用在实际堆元组上验证匹配，则recheck会被设置为true。
如果执行有序搜索，则根据orderbys数组设置distances为距离值数组。
否则，保留它为空。
如果至少有一个返回的距离不准确，则recheckDistances为 true。
在这种情况下，执行器将从堆中获取元组之后计算精确的距离，并根据需要重新排序元组。
可选的用户定义的方法是：
Datum compress(Datum in)
将数据项转换成一种适合索引的叶子元组中物理存储方式的格式。
它接受spgConfigIn.attType类型的值并且返回spgConfigOut.leafType类型的值。
输出值必须不包含线外的TOAST指针。
注意: compress 方法仅应用于被存储的值。
一致性方法接收查询scankeys未变化，没有使用compress转换。
options
定义一组控制运算符类行为的用户可见参数。
函数的 SQL 声明必须如下所示：
CREATE OR REPLACE FUNCTION my_options(internal)
RETURNS void
AS 'MODULE_PATHNAME'
LANGUAGE C STRICT;
该函数被传递一个指向 local_relopts 结构的指针，该结构需要填充一组特定于运算符类的选项。可以使用 PG_HAS_OPCLASS_OPTIONS() 和 PG_GET_OPCLASS_OPTIONS() 宏从其他支持函数访问这些选项。
由于 SP-GiST 中键的表示是灵活的，它可能取决于用户指定的参数。
所有的 SP-GiST 支持方法通常都在一个短期存在的内存上下文中被调用，即在处理完每一个元组后 CurrentMemoryContext 将被重置。因此并不需要操心 pfree 你 palloc 的任何东西（config 方法是一个特例：它应该避免泄漏内存。但是通常 config 方法只需要为传出的参数结构赋常数值）。
如果被索引的列是一种可排序的数据类型，索引的排序规则将被使用标准的 PG_GET_COLLATION() 机制传递给所有的支持方法。
65.3.4. 实现 #
这一节覆盖了实现细节以及 SP-GiST 操作符类的实现者需要知道的有用的技巧。
65.3.4.1. SP-GiST 限制 #
单独的叶子节点和内部节点必须能适合一个单一的索引页面（默认为 8kB）。因此，当索引值是一种变长数据类型时，长值只能由如 radix 树的方法所支持，树的每一层包含的前缀都足够短以适合一个页面，并且最终的叶子层包括的后缀也足够短以适合一个页面。如果操作符类准备好做这种事情，它应该将longValuesOK设置为true。否则，SP-GiST核心将拒绝任何要索引超过一个索引页面长度的值的请求。
同样，操作符类应该负责不要让内部元组增长到无法放在一个索引页面中。这限制了能在一个内部元组中使用的子节点的数目，以及一个前缀值的最大尺寸。
另一个限制是，当一个内部元组的节点指向一组叶子元组时，这些元组必须都在同一个索引页面中（这种设计是为了减少在这类元组构成链中进行定位的时间并且节省空间）。如果叶子元组集合增长到无法放在一个页面中，将执行一次分裂并且插入一个中间的内部元组。为此，新的内部元组必须把叶子值的集合划分成多于一个节点分组。如果操作符类的picksplit函数无法做到这一点，SP-GiST核心只能求助于第 65.3.4.3 节中所介绍的额外措施。
当longValuesOK为真，可以预期SP-GiST树的连续级别将吸收越来越多的信息到内部元组的前缀和节点标签中，使得所需的叶数据越来越小，这样最终就能放在一页上了。
为了防止从导致无限插入循环的操作符类中的错误，SP-GiST核心将抛出一个错误，如果choose方法调用的10个周期内叶数据没有变得更小。
65.3.4.2. SP-GiST 无节点标签 #
某些树算法对每个内部元组都使用一种固定的节点集合。例如，在一个四叉树中总是正好有四个节点对应于围绕内部元组中心点的四个象限。在这种情况下，代码总是通过编号来处理节点，而不需要显式的节点标签。要抑制节点标签（因而节省一些空间），picksplit函数可以为nodeLabels数组返回NULL，同样choose函数可以在一个spgSplitTuple动作期间为prefixNodeLabels数组返回NULL。这将会导致后续对choose和inner_consistent调用时nodeLabels也为 NULL。原则上，可以为同一个索引中的某些内部元组使用节点标签而对其他内部元组省略节点标签。
在处理具有无标签节点的内部元组时，让choose返回spgAddNode是一种错误，因为该节点集合在这种情况下被假定为固定的集合。
65.3.4.3. “All-the-Same” 内部元组 #
当picksplit无法把提供的叶子值划分成至少两个节点分类，SP-GiST核心能推翻操作符类的picksplit函数的结果。在发生这种情况时，会创建一个新的内部元组，其中有多个节点，每一个节点都有相同的标签（如果有标签），标签是由picksplit之前给一个节点用的，并且叶子值会被随机地划分给这些等效的节点中。该内部元组上会设置allTheSame标志以警告choose和inner_consistent函数该元组不具有它们所期望的节点集合。
在处理allTheSame元组时，choose函数的结果spgMatchNode会被解释为新值可以被赋值给任一等价的节点。核心代码将忽略提供的nodeN值并且随机地下降到其中一个节点（以便保持树平衡）。对choose来说，返回spgAddNode是一种错误，因为那会让节点不全部等效。如果要插入的值不匹配现有的节点，则必须使用spgSplitTuple动作。
在处理allTheSame元组时，为了继续索引搜索，inner_consistent函数应该返回全部节点或者不返回节点作为目标，因为这些节点都是等效的。根据inner_consistent函数对这些节点含义的假定程度，这可能会也可能不会要求任何处理特殊情况的代码。
65.3.5. 示例 #
如表 65.2中所述，PostgreSQL源代码发布包括多个用于SP-GiST的索引操作符类的示例。其代码可以查看src/backend/access/spgist/和src/backend/utils/adt/中的文件。
上一页 上一级 下一页65.2. GiST 索引 起始页 65.4. GIN 索引
