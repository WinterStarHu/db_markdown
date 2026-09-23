# CREATE AGGREGATE

CREATE AGGREGATE
版本：
纠错本页面
搜索
目录导航
❮
❯
CREATE AGGREGATECREATE AGGREGATE — 定义一个新的聚合函数大纲
CREATE [ OR REPLACE ] AGGREGATE name ( [ argmode ] [ argname ] arg_data_type [ , ... ] ) (
SFUNC = sfunc,
STYPE = state_data_type
[ , SSPACE = state_data_size ]
[ , FINALFUNC = ffunc ]
[ , FINALFUNC_EXTRA ]
[ , FINALFUNC_MODIFY = { READ_ONLY | SHAREABLE | READ_WRITE } ]
[ , COMBINEFUNC = combinefunc ]
[ , SERIALFUNC = serialfunc ]
[ , DESERIALFUNC = deserialfunc ]
[ , INITCOND = initial_condition ]
[ , MSFUNC = msfunc ]
[ , MINVFUNC = minvfunc ]
[ , MSTYPE = mstate_data_type ]
[ , MSSPACE = mstate_data_size ]
[ , MFINALFUNC = mffunc ]
[ , MFINALFUNC_EXTRA ]
[ , MFINALFUNC_MODIFY = { READ_ONLY | SHAREABLE | READ_WRITE } ]
[ , MINITCOND = minitial_condition ]
[ , SORTOP = sort_operator ]
[ , PARALLEL = { SAFE | RESTRICTED | UNSAFE } ]
)
CREATE [ OR REPLACE ] AGGREGATE name ( [ [ argmode ] [ argname ] arg_data_type [ , ... ] ]
ORDER BY [ argmode ] [ argname ] arg_data_type [ , ... ] ) (
SFUNC = sfunc,
STYPE = state_data_type
[ , SSPACE = state_data_size ]
[ , FINALFUNC = ffunc ]
[ , FINALFUNC_EXTRA ]
[ , FINALFUNC_MODIFY = { READ_ONLY | SHAREABLE | READ_WRITE } ]
[ , INITCOND = initial_condition ]
[ , PARALLEL = { SAFE | RESTRICTED | UNSAFE } ]
[ , HYPOTHETICAL ]
)
或者旧的语法
CREATE [ OR REPLACE ] AGGREGATE name (
BASETYPE = base_type,
SFUNC = sfunc,
STYPE = state_data_type
[ , SSPACE = state_data_size ]
[ , FINALFUNC = ffunc ]
[ , FINALFUNC_EXTRA ]
[ , FINALFUNC_MODIFY = { READ_ONLY | SHAREABLE | READ_WRITE } ]
[ , COMBINEFUNC = combinefunc ]
[ , SERIALFUNC = serialfunc ]
[ , DESERIALFUNC = deserialfunc ]
[ , INITCOND = initial_condition ]
[ , MSFUNC = msfunc ]
[ , MINVFUNC = minvfunc ]
[ , MSTYPE = mstate_data_type ]
[ , MSSPACE = mstate_data_size ]
[ , MFINALFUNC = mffunc ]
[ , MFINALFUNC_EXTRA ]
[ , MFINALFUNC_MODIFY = { READ_ONLY | SHAREABLE | READ_WRITE } ]
[ , MINITCOND = minitial_condition ]
[ , SORTOP = sort_operator ]
)
描述
CREATE AGGREGATE定义一个新的聚合函数。CREATE OR REPLACE AGGREGATE将定义新的聚合函数或替换现有定义。
在发布中已经包括了一些基本的和常用的聚合函数；它们的文档请见第 9.21 节。
如果要定义一个新类型或者需要一个还没有被提供的聚合函数，那么CREATE AGGREGATE就可以被用来提供想要的特性。
在替换现有定义时，参数类型、结果类型和直接参数的数量可能不会更改。
此外，新定义的类型（普通聚合、有序集聚合或假设集聚合）必须与旧定义相同。
如果给定了一个模式名（例如CREATE AGGREGATE
myschema.myagg ...），那么该聚合会被创建在指定的模式中。否则它
会被创建在当前模式中。
一个聚合函数需要用它的名称和输入数据类型标识。同一个模式中的两个聚合
可以具有相同的名称，只要它们在不同的输入类型上操作就可以。一个聚合的名称
和输入数据类型必须与同一模式中的每一个普通函数区分开。这种行为与普通函
数名的重载完全一样（见CREATE FUNCTION）。
一个简单的聚合函数由一个或两个普通函数组成：
一个状态转移函数
sfunc，和一个可选的最终
计算函数
ffunc。
它们被这样使用：
sfunc( internal-state, next-data-values ) ----> next-internal-state
ffunc( internal-state ) ----> aggregate-value
PostgreSQL创建一个数据类型
stype的临时变量来
保存聚合的当前内部状态。对每一个输入行，聚合参数值会被计算并且状态
转移函数会被调用，它用当前状态值和新参数值计算一个新的内部状态值。
等所有行都被处理完后，最终函数会被调用一次来计算该聚合的返回值。如果
没有最终函数，则最终的状态值会被返回。
一个聚合函数可以提供一个初始条件，即一个用于内部状态值的初始值。它被
作为一个类型text的值指定并且存储在数据库中，但是它必须
是状态值数据类型的一个常量的合法外部表示。如果没有提供，则状态值从空值
开始。
如果状态转移函数被声明为“strict”，那么不能用空值输入来
调用它。如果有这种转移函数，聚合将按照下面的行为执行。带有任何空值的
行会被忽略（函数不被调用并且之前的状态值被保持）。如果初始状态值就是
空值，那么碰到第一个没有空值的行时，状态值会被替换成第一个参数值，并且
对于每一个后续的没有空值的行都会调用该转移函数。这对实现
max这样的聚合很方便。注意只有当
state_data_type
和第一个
arg_data_type相同时，
这种行为才可用。当这些类型不同时，你必须提供一个非空初始条件或者使用
一个非严格转移函数。
如果状态转移函数不是严格的，那么在碰到每个输入行时都将会调用它，并且
它必须自行处理空值输入和空状态值。这允许聚合的作者完全控制该聚合如何
处理空值。
如果最终函数被声明为“strict”，那么当最终状态值为空时将
不会调用它，而是自动地返回一个空结果（当然，这只是严格函数的普通行为）。
在任何情况下最终函数都可以返回一个空值。例如，avg的最终函数会在看到零个
输入行时返回空。
有时候把最终函数声明成不仅采用状态值还采用对应于聚合输入值的额外参数
是有用的。这样做的主要原因是，如果最终函数是多态的，那么状态值的数据
类型将不适合于用来确定结果类型。这些额外的参数总是以 NULL 形式传递
（因此使用FINALFUNC_EXTRA选项时，最终函数不能是严格的），
但尽管如此它们都是合法参数。例如，最终函数可以利用
get_fn_expr_argtype来标识当前调用中的实际参数类型。
如第 36.12.1 节中所述，一个聚合可以
选择支持moving-aggregate mode。这要求指定
MSFUNC、MINVFUNC以及
MSTYPE参数，并且参数MSSPACE、
MFINALFUNC、MFINALFUNC_EXTRA
和MINITCOND是可选的。除了MINVFUNC，
这些参数的工作都和对应的不带M的简单聚合参数相似，它们
定义了包括一个逆向转移函数的聚合的一种独立实现。
在参数列表中带有ORDER BY的语法会创建一种被称为
有序集聚集的特殊聚集类型。如果指定了
HYPOTHETICAL，则会创建一个
假想集聚集。这些聚集以依赖排序的方法在排好序
的值上操作，因此指定一个输入排序顺序是调用过程的重要一环。还有，它们
可以有直接参数，这类参数只对每次聚集计算一次，而不是对
每一个输入行计算一次。假想集聚集是有序集聚集的一个子类，其中一些直接
参数要求在数量和类型上都匹配被聚集的参数列。这允许这些直接参数的值被
当做一个附加的“假想”行被加入到聚集输入行的集合中。
如第 36.12.4 节中所示，一个聚集可以支持
部分聚集。这要求指定COMBINEFUNC参数。
如果state_data_type
为internal，通常也可以提供SERIALFUNC和
DESERIALFUNC参数，这样可以让并行聚集成为可能。注意，
该聚集还必须被标记为PARALLEL SAFE以启用并行聚集。
行为与MIN或MAX相似的聚集有时可以通过
直接查看一个索引而不是扫描每一个输入行来优化。如果这个聚集可以被这样
优化，请通过指定一个排序操作符来指出。基本要求是，该
聚集必须得出由该操作符产生的排序顺序中的第一个元素，换句话说：
SELECT agg(col) FROM tab;
必须等价于：
SELECT col FROM tab ORDER BY col USING sortop LIMIT 1;
进一步的假定是该聚集忽略空输入，并且当且仅当没有非空输入时它才会返回
一个空结果。通常，一种数据类型的<操作符是
MIN的合适的排序操作符，而>是
MAX的合适的排序操作符。注意，除非指定的操作符是一个
B-树索引操作符类的“小于”或者“大于”
策略成员，优化将永远不会产生实际效果。
要能够创建一个聚集函数，你必须具有参数类型、状态类型和返回类型上的
USAGE特权，还有在支持函数上的
EXECUTE特权。
参数name
要创建的聚集函数的名称（可以是模式限定的）。
argmode
一个参数的模式：IN或VARIADIC。
（聚集函数不支持OUT参数。）如果忽略，默认值是IN。
只有最后一个参数能被标记为VARIADIC。
argname
一个参数的名称。当前这只用于文档的目的。如果被忽略，该参数就没有名称。
arg_data_type
这个聚合函数操作的一个输入数据类型。要创建一个零参数的聚合函数，可以
写一个*来替代参数说明的列表（这类聚合的一个例子是
count(*)）。
base_type
在CREATE AGGREGATE的旧语法中，输入数据类型是由
一个basetype参数指定而不是写在聚合名之后。注意这种语法
只允许一个输入参数。要用这种语法定义一个零参数的聚合函数，把
basetype指定为"ANY"（不是*）。
有序聚合不能用旧语法定义。
sfunc
要为每一个输入行调用的状态转移函数名。对于一个正常的
N-参数的聚合函数，
sfunc必须接收
N+1 个参数，
第一个参数的类型是state_data_type而其余的参数匹配
该聚合被声明的输入数据类型。该函数必须返回一个类型为
state_data_type
的值。这个函数会采用当前的状态值以及当前的输入数据值，并且返回下一个
状态值。
对于有序集（包括假想集）聚合，状态转移函数只接收当前的状态值和聚合参数，
但无需直接参数。否则它就和其他转移函数一样了。
state_data_type
聚合的状态值的数据类型。
state_data_size
聚合的状态值的近似平均尺寸（以字节计）。如果这个参数被忽略或者为零，
将使用一个基于state_data_type的默认估计值。规划器
使用这个值来估计一个分组聚合查询所需的内存。
ffunc
最终函数的名称，该函数在所有输入行都被遍历之后被调用来计算聚合的结果。
对于一个常规聚合，这个函数必须只接受一个类型为state_data_type的单一参数。该聚合
的返回数据类型被定义为这个函数的返回类型。如果没有指定
ffunc，则结束状态值
被用作聚合的结果，并且返回类型为state_data_type。
对于有序集（包括假想集）聚合，最终函数不仅接收最终状态值，还会接收所
有直接参数的值。
如果指定了FINALFUNC_EXTRA，则除了最终状态值和任何直接
参数之外，最终函数还接收额外的对应于该聚合的常规（聚合）参数的 NULL 值。
这主要用于在定义了一个多态聚合时允许正确地决定聚合的结果类型。
FINALFUNC_MODIFY = { READ_ONLY | SHAREABLE | READ_WRITE }
此选项指定最终函数是否为不会修改参数的纯函数。READ_ONLY表示它不会修改；其他两个值表示它可能会更改过渡状态值。请参见Notes 以获取更多详细信息。除了有序集合的聚合使用默认值READ_WRITE，其他默认值均为READ_ONLY。
combinefunc
combinefunc函数可以被
有选择地指定以允许聚合函数支持部分聚合。如果提供这个函数，
combinefunc必须组合两个
state_data_type值，每一个
都包含在输入值某个子集上的聚合结果，它会产生一个新的
state_data_type来表示在
两个输入集上的聚合结果。这个函数可以被看做是一个
sfunc，和后者在一个个体
输入行上操作并且把它加到运行聚合状态上不同，这个函数是把另一个聚合状态加
到运行状态上。
combinefunc必须被声明为
有两个state_data_type参数
并且返回一个state_data_type
值。这个函数可以有选择性地被标记为“strict”。在被标记的情况下，
当任何一个输入状态为空时，将不会调用该函数，而是把另一个状态当作正确的结果。
对于state_data_type为
internal的聚合函数，
combinefunc不能为
strict。这种情况下，
combinefunc必须确保
正确地处理空状态并且被返回的状态能被恰当地存储在聚合内存上下文中。
serialfunc
state_data_type为
internal的一个聚合函数可以参与到并行聚集中，当且仅当它具有一个
serialfunc函数，该函数
必须把聚合状态序列化成一个bytea值以传送给另一个进程。这个函数
必须有一个单一的internal类型参数并且返回类型bytea。
相应地也需要一个deserialfunc。
deserialfunc
把一个之前序列化后的聚合状态反序列化为
state_data_type。这个函数
必须有两个类型分别为bytea和internal的参数，并且产生
一个类型internal的结果（注意：第二个类型为internal的
参数是无用的，但是为了类型安全的原因还是要求有该参数）。
initial_condition
状态值的初始设置。这必须是以数据类型state_data_type能够接受的形式出现
的一个字符串常量。如果没有指定，状态值会从空值开始。
msfunc
前向状态转移函数的名称，在移动聚集模式中会为每个输入行调用这个函数。它
非常像常规的转移函数，不过它的第一个参数和结果类型是
mstate_data_type，这可能与
state_data_type不同。
minvfunc
在移动聚集模式中用到的逆向状态转移函数的名称。这个函数与
msfunc具有相同的参数和结果类型，但是它被用于从当前聚集
状态中移除一个值，而不是向其中增加一个值。逆向转移函数必须具有和前向状态
转移函数相同的严格性属性。
mstate_data_type
使用移动聚集模式时，用于聚集状态值的数据类型。
mstate_data_size
使用移动聚集模式时，聚集状态值的近似平均尺寸（以字节计）。它的作用和
state_data_size相同。
mffunc
使用移动聚集模式时用到的最终函数名称，当所有输入行都被遍历后会调用它来
计算聚集的结果。它的工作和ffunc一样，但是它的第一个参
数类型是mstate_data_type并且额外的空参数要通过书写
MFINALFUNC_EXTRA来指定。mffunc
或者mstate_data_type决定的聚集结果类型必须匹配由聚集
的常规实现所确定的类型。
MFINALFUNC_MODIFY = { READ_ONLY | SHAREABLE | READ_WRITE }
此选项类似于FINALFUNC_MODIFY，只是它描述了移动聚集最终函数的行为。
minitial_condition
使用移动聚合模式时，状态值的初始设置。它的作用和
initial_condition一样。
sort_operator
一个MIN-类或者MAX-类聚集的相关
排序操作符。这只是一个操作符名称（可能被模式限定）。这个操作符被
假定为具有和该聚集（必须是一个单一参数的常规聚集）相同的输入数据
类型。
PARALLEL = { SAFE | RESTRICTED | UNSAFE }
PARALLEL SAFE、PARALLEL
RESTRICTED和PARALLEL UNSAFE的含义和
CREATE FUNCTION中的相同。如果一个聚集被标记为
PARALLEL UNSAFE（默认）或者
PARALLEL RESTRICTED，将不会考虑将它并行化。注意
规划器不会参考聚集的支持函数的并行安全性标记，它只会考虑聚集本身
的这类标记。
HYPOTHETICAL
只用于有序集聚集，这个标志指定聚集参数会被根据假想集聚集的要求进行处理：
即后面的直接参数必须匹配聚集（WITHIN GROUP）参数的数据
类型。HYPOTHETICAL标志在运行时没有任何效果，它只在
命令解析期间对确定数据类型和聚集参数的排序规则有用。
CREATE AGGREGATE的参数可以用任意顺序书写，
而无需遵照以上说明的顺序。
注释
在指定支持函数名的参数中，如果需要你可以写一个模式名，例如
SFUNC = public.sum。在这里不能写参数类型 — 支持函数
的参数类型是根据其他参数决定的。
通常，PostgreSQL函数是被期望为不修改输入值的真函数。然而，一个聚合迁移函数在聚合上下文中使用时被允许作弊并修改其迁移状态参数。因为与每次创建一个迁移状态的新拷贝相比，这样可以提供实质的性能提升。
同样，虽然人们一般不期望聚合最终函数修改它的输入值，但有时回避修改迁移状态参数是不切实际的。这种行为必须使用FINALFUNC_MODIFY参数声明。READ_WRITE值表示最终函数以某种未指定的方式修改了迁移状态值。这个值防止将聚合用作窗口函数，并且还可以防止因共用相同的输入值和迁移函数的聚合调用而合并迁移状态。SHAREABLE值表示过渡函数不能在最终函数之后使用，但多重最终函数调用可以对最终的迁移状态值执行调用。这个值阻止将聚合用作窗口函数，但允许合并过渡状态。（也就是说，此处所关注的优化不是重复地使用相同的最终函数，而是把不同的最终函数应用到相同的最终迁移状态值。只要所有最终函数都没有标记为READ_WRITE就被允许。）
如果一个聚合支持移动聚合模式，当该聚合被用于一个具有移动帧起点（即帧起点模式不是UNBOUNDED PRECEDING）的窗口函数时，它将提升计算效率。在概念上，当从底部进入窗口帧时前向转移函数会把输入值加到聚合的状态上，而逆向转移函数会在从顶部离开帧时再次移除输入值。因此，当值被移除时，它们总是按照被加入的相同顺序被移除。无论何时调用逆向转移函数，它都将因此接收最近增加但是还未被移除的参数值。逆向转移函数可以假定在它移除最旧的行之后至少有一行保留在当前状态中（当情况不是这样时，窗口函数机制会简单地开始一次新的聚合，而不是使用逆向转移函数）。
用于移动聚合模式的前向转移函数不允许返回 NULL 作为新的状态值。如果逆向转移函数返回 NULL，这表明逆向函数无法为这个特定的输入逆转状态计算，因此该聚合计算必须从当前帧的开始位置重新计算。在一些少见的情况下，逆转正在计算中的状态值是不切实际的，这种约定可以允许在此类情形中使用移动聚合模式。
如果没有提供移动聚合实现，聚合仍然可以被用于移动帧，但是只要帧起点移动，PostgreSQL都将会重新计算整个聚合。注意不管聚合有没有支持移动聚合模式，PostgreSQL都能处理一个移动帧结束而无需重新计算，这可以通过增加新值到聚合状态完成。这就是为什么使用聚合作为窗口函数需要最终函数只读的原因：最终函数不能破坏聚合的状态值，这样即使已经为一组帧边界得到了一个聚合结果值，该聚合也能继续下去。
有序集聚合的语法允许为最后一个直接参数以及最后一个聚合（WITHIN GROUP）参数指定VARIADIC。但是，当前的实现限制只能以两种方式使用VARIADIC。第一种，有序集聚合只能使用VARIADIC "any"，不能使用其他可变数组类型。第二种，如果最后一个直接参数是VARIADIC "any"，那么只能有一个聚合参数并且它也必须是VARIADIC "any"（在系统目录中使用的表示中，这两个参数会被合并为一个单一的VARIADIC "any"项，因为pg_proc无法表示具有超过一个VARIADIC参数的函数）。如果该聚合是一个假想集聚合，匹配VARIADIC "any"参数的直接参数就是假想参数。任何在前面的参数表示额外的直接参数，它们不被约束为需要匹配聚合参数。
当前，有序集聚合无须支持移动聚合模式，因为它们不能被用作窗口函数。
部分（包括并行）聚合当前不被有序集聚合支持。此外，包含DISTINCT或ORDER BY子句的聚合调用将不会使用部分聚合，因为在部分聚合时无法支持那些语义。
示例
见第 36.12 节。
兼容性
CREATE AGGREGATE是一种
PostgreSQL的语言扩展。SQL标准没有提供
用户定义的聚合函数。
另见ALTER AGGREGATE, DROP AGGREGATE上一页 上一级 下一页CREATE ACCESS METHOD 起始页 CREATE CAST
