# 52.39. pg_proc

52.39. pg_proc
版本：
纠错本页面
搜索
目录导航
❮
❯
52.39. pg_proc #
目录pg_proc存放有关函数、过程、聚合函数以及窗口函数（共称为例程）的信息。更多信息请参考CREATE FUNCTION、CREATE PROCEDURE和第 36.3 节。
如果prokind显示该条目用于一个聚合函数，在pg_aggregate中应该有一个相匹配的行。
表 52.39. pg_proc 列
列类型
描述
oid oid
行标识符
proname name
函数的名称
pronamespace oid
(references pg_namespace.oid)
包含此函数的名字空间的OID
proowner oid
(references pg_authid.oid)
函数的拥有者
prolang oid
(references pg_language.oid)
实现语言或该函数的调用接口
procost float4
估计的执行代价（以cpu_operator_cost为单位）；如果proretset为真，这是每行返回的代价
prorows float4
估计的结果行数量（如果proretset为假，该值为0）
provariadic oid
(references pg_type.oid)
可变数组参数的元素的数据类型，或者如果函数没有可变参数则为0
prosupport regproc
(references pg_proc.oid)
对于该函数的计划器支持函数（参见第 36.11 节），如果没有则为零
prokind char
f表示普通函数，p表示过程，a表示聚集函数，w表示窗口函数
prosecdef bool
函数是一个安全性定义者（即，一个“setuid”函数）
proleakproof bool
该函数没有副作用，除返回值外不传递任何关于参数的信息。任何可能根据参数值抛出错误的函数都不是防泄漏的。
proisstrict bool
当任意调用参数为空时，函数返回空值。在那种情况下函数实际上根本不会被调用。非“strict”函数必须准备好处理空值输入。
proretset bool
函数返回一个集合（即，指定数据类型的多个值）
provolatile char
provolatile说明函数的结果是否仅依赖于其输入参数，或受外部因素影响。
值i表示“不变的”函数，它对于相同的输入总是输出相同的结果。
值s表示“稳定的”函数，它的结果（对于固定输入）在一次扫描内不会变化。
值v表示“不稳定的”函数，它的结果在任何时候都可能变化（使用v也表示函数具有副作用，因此对它们的调用无法得到优化）。
proparallel char
proparallel说明该函数在并行模式下是否能安全地运行。
对于能在并行模式下不受限制安全运行的函数，这列是s。
对于可以在并行模式下运行但是只限于由并行组的领导者执行的函数，这列是r。
对于在并行模式中不安全的函数，这列是u，这种函数的存在会强制一个顺序执行计划。
pronargs int2
输入参数的个数
pronargdefaults int2
具有默认值的参数个数
prorettype oid
(references pg_type.oid)
返回值的数据类型
proargtypes oidvector
(references pg_type.oid)
一个函数参数的数据类型的数组。
这只包括输入参数（含INOUT和VARIADIC参数），因此也表现了函数的调用特征。
proallargtypes oid[]
(references pg_type.oid)
一个函数参数的数据类型的数组。
这包括所有参数（含OUT和INOUT参数）。
但是，如果所有参数都是IN参数，这个域将为空。
注意下标是从1开始，而由于历史原因proargtypes的下标是从0开始。
proargmodes char[]
一个函数参数模式的数组。这里包括：
i表示IN参数，
o表示OUT参数，
b表示INOUT参数，
v表示VARIADIC参数，
t表示TABLE参数。
如果所有的参数都是IN参数，这个域将为null。
注意这里的下标对应着proallargtypes而不是proargtypes中的位置。
proargnames text[]
一个函数参数名字的数组。没有名字的参数在数组中设置为空字符串。如果没有一个参数有名字，这个域将为null。
注意这里的下标对应着proallargtypes而不是proargtypes中的位置。
proargdefaults pg_node_tree
默认值的表达式树（按照nodeToString()的表现方式）。
这是一个pronargdefaults元素的列表，对应于最后N个input参数（即最后N个proargtypes位置）。
如果没有一个参数具有默认值，这个域将为null。
protrftypes oid[]
(references pg_type.oid)
要应用转换的（来自函数的TRANSFORM子句）参数/结果数据类型的数组。如果没有则为null。
prosrc text
这个域告诉函数处理者如何调用该函数。它可能是针对解释型语言的真实源码、一个符号链接、一个文件名或任何其他东西，这取决于实现语言/调用约定。
probin text
关于如何调用函数的附加信息。其解释是与语言相关的。
prosqlbody pg_node_tree
预解析的SQL函数体。
当该体在SQL标准表示法中给出而不是作为一个字符串文本时，这个用于SQL语言函数。
其他情况下将为null。
proconfig text[]
函数对于运行时配置变量的本地设置值
proacl aclitem[]
访问权限；详见 第 5.8 节。
对于编译好的函数，包括内建的和动态载入的，prosrc包含了函数的C语言名字（链接符号）。
对于SQL语言函数，prosrc包含函数的源文本，如果它被指定为字符串文字；但是如果函数体被指定为SQL标准样式，prosrc是不使用的（通常是空字符串），而由prosqlbody包含预解析的定义。
所有其他已知的语言类型，prosrc包含函数的源文本。除了对于动态载入的C函数之外，probin为空，对于动态载入的C函数，它给定了包含该函数的共享库文件的名称。
上一页 上一级 下一页52.38. pg_policy 起始页 52.40. pg_publication
