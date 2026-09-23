# 9.20. 范围/多范围函数和运算符

9.20. 范围/多范围函数和运算符
版本：
纠错本页面
搜索
目录导航
❮
❯
9.20. 范围/多范围函数和运算符 #
范围类型的概述可参见 第 8.17 节 。
表 9.58 显示了范围类型的专用操作符。
表 9.59 显示了多范围类型的专用操作符。
除此之外，表 9.1 中所示的常用比较操作符也适用于范围类型和多范围类型。
比较操作符首先按范围下界排序，只有当它们相等时才比较上界。
多范围操作符比较每个范围直到某一个不相等。
这通常不会导致有用的总体排序，但提供的操作符允许在范围上构造唯一索引。
表 9.58. 范围操作符
操作符
描述
示例
anyrange @> anyrange
→ boolean
第一个范围中包含第二个范围吗?
int4range(2,4) @> int4range(2,3)
→ t
anyrange @> anyelement
→ boolean
范围是否包含元素?
'[2011-01-01,2011-03-01)'::tsrange @> '2011-01-10'::timestamp
→ t
anyrange <@ anyrange
→ boolean
第一个范围包含在第二个范围中吗?
int4range(2,4) <@ int4range(1,7)
→ t
anyelement <@ anyrange
→ boolean
元素是否包含在范围内?
42 <@ int4range(1,7)
→ f
anyrange && anyrange
→ boolean
范围是否重叠，也就是说，是否有相同的元素?
int8range(3,7) && int8range(4,12)
→ t
anyrange << anyrange
→ boolean
第一个范围是否严格地在第二个范围的左侧?
int8range(1,10) << int8range(100,110)
→ t
anyrange >> anyrange
→ boolean
第一个范围是否严格地在第二个范围的右侧?
int8range(50,60) >> int8range(20,30)
→ t
anyrange &< anyrange
→ boolean
第一个范围是否没有扩展到第二个范围的右侧?
int8range(1,20) &< int8range(18,20)
→ t
anyrange &> anyrange
→ boolean
第一个范围是否没有扩展到第二个范围的左侧?
int8range(7,20) &> int8range(5,10)
→ t
anyrange -|- anyrange
→ boolean
范围是相邻的吗？
numrange(1.1,2.2) -|- numrange(2.2,3.3)
→ t
anyrange + anyrange
→ anyrange
计算范围的并集。范围必须重叠或相邻，这样的并集就是一个单一的范围（但请参见range_merge()）。
numrange(5,15) + numrange(10,20)
→ [5,20)
anyrange * anyrange
→ anyrange
计算范围的交集。
int8range(5,15) * int8range(10,20)
→ [10,15)
anyrange - anyrange
→ anyrange
计算范围的差异。第二个范围必须不能包含在第一个范围中，以使差异不是一个单一的范围。
int8range(5,15) - int8range(10,20)
→ [5,10)
表 9.59. 多范围操作符
操作符
描述
例子
anymultirange @> anymultirange
→ boolean
第一个多范围是否包含第二个？
'{[2,4)}'::int4multirange @> '{[2,3)}'::int4multirange
→ t
anymultirange @> anyrange
→ boolean
多范围是否包含范围？
'{[2,4)}'::int4multirange @> int4range(2,3)
→ t
anymultirange @> anyelement
→ boolean
多范围是否包含元素？
'{[2011-01-01,2011-03-01)}'::tsmultirange @> '2011-01-10'::timestamp
→ t
anyrange @> anymultirange
→ boolean
范围是否包含多范围？
'[2,4)'::int4range @> '{[2,3)}'::int4multirange
→ t
anymultirange <@ anymultirange
→ boolean
第一个多范围是否被第二个所包含？
'{[2,4)}'::int4multirange <@ '{[1,7)}'::int4multirange
→ t
anymultirange <@ anyrange
→ boolean
多范围是否被范围所包含？
'{[2,4)}'::int4multirange <@ int4range(1,7)
→ t
anyrange <@ anymultirange
→ boolean
范围是否被多范围所包含？
int4range(2,4) <@ '{[1,7)}'::int4multirange
→ t
anyelement <@ anymultirange
→ boolean
元素是否包含在多范围内？
4 <@ '{[1,7)}'::int4multirange
→ t
anymultirange && anymultirange
→ boolean
多范围是否重叠，也就是说，有任何共同的元素？
'{[3,7)}'::int8multirange && '{[4,12)}'::int8multirange
→ t
anymultirange && anyrange
→ boolean
多范围是否与范围重叠？
'{[3,7)}'::int8multirange && int8range(4,12)
→ t
anyrange && anymultirange
→ boolean
范围是否与多范围重叠？
int8range(3,7) && '{[4,12)}'::int8multirange
→ t
anymultirange << anymultirange
→ boolean
第一个多范围是否严格在第二个的左边？
'{[1,10)}'::int8multirange << '{[100,110)}'::int8multirange
→ t
anymultirange << anyrange
→ boolean
多范围是否严格在范围的左边？
'{[1,10)}'::int8multirange << int8range(100,110)
→ t
anyrange << anymultirange
→ boolean
范围是否严格在多范围的左边？
int8range(1,10) << '{[100,110)}'::int8multirange
→ t
anymultirange >> anymultirange
→ boolean
第一个多范围是否严格在第二个的右边？
'{[50,60)}'::int8multirange >> '{[20,30)}'::int8multirange
→ t
anymultirange >> anyrange
→ boolean
多范围是否严格在范围的右边？
'{[50,60)}'::int8multirange >> int8range(20,30)
→ t
anyrange >> anymultirange
→ boolean
范围是否严格在多范围的右边？
int8range(50,60) >> '{[20,30)}'::int8multirange
→ t
anymultirange &< anymultirange
→ boolean
第一个多范围是否不扩展到第二个的右边？
'{[1,20)}'::int8multirange &< '{[18,20)}'::int8multirange
→ t
anymultirange &< anyrange
→ boolean
多范围是否不扩展到范围的右边？
'{[1,20)}'::int8multirange &< int8range(18,20)
→ t
anyrange &< anymultirange
→ boolean
范围不扩展到多范围的右边吗?
int8range(1,20) &< '{[18,20)}'::int8multirange
→ t
anymultirange &> anymultirange
→ boolean
第一个多范围不扩展到第二个的左边吗?
'{[7,20)}'::int8multirange &> '{[5,10)}'::int8multirange
→ t
anymultirange &> anyrange
→ boolean
多范围不扩展到范围的左边吗?
'{[7,20)}'::int8multirange &> int8range(5,10)
→ t
anyrange &> anymultirange
→ boolean
范围不扩展到多范围的左边吗?
int8range(7,20) &> '{[5,10)}'::int8multirange
→ t
anymultirange -|- anymultirange
→ boolean
多范围是相邻的吗?
'{[1.1,2.2)}'::nummultirange -|- '{[2.2,3.3)}'::nummultirange
→ t
anymultirange -|- anyrange
→ boolean
多范围与范围是相邻的吗？
'{[1.1,2.2)}'::nummultirange -|- numrange(2.2,3.3)
→ t
anyrange -|- anymultirange
→ boolean
范围与多范围是相邻的吗？
numrange(1.1,2.2) -|- '{[2.2,3.3)}'::nummultirange
→ t
anymultirange + anymultirange
→ anymultirange
计算多范围的并集。多范围不需要重叠或相邻。
'{[5,10)}'::nummultirange + '{[15,20)}'::nummultirange
→ {[5,10), [15,20)}
anymultirange * anymultirange
→ anymultirange
计算多范围的交集。
'{[5,15)}'::int8multirange * '{[10,20)}'::int8multirange
→ {[10,15)}
anymultirange - anymultirange
→ anymultirange
计算多范围的差异。
'{[5,20)}'::int8multirange - '{[10,15)}'::int8multirange
→ {[5,10), [15,20)}
当涉及一个空范围或多范围时，左部/右部/相邻操作符总是返回假；即一个空范围被认为不在任何其他范围前面或者后面。
在其他地方，空范围和多范围被视为加法单位：与空值的任何交集都是它自己。
任何减去空值的都是它自己。
空的多范围与空的范围具有完全相同的点。
每个范围都包含空范围。
每个多范围包含任意多个空范围。
范围交集和差异操作符将失败，如果结果范围需要包含两个不相交的子范围，因为这样的范围无法表示。
有用于交集和差分的单独运算符，可接受多范围参数并返回多范围，即使它们的参数不相交也不会失败。
因此，如果需要对可能不相交的范围进行交集或差异操作，你可以通过首先将范围转换为多范围来避免错误。
表 9.60 显示可用于范围类型的函数。
表 9.61 显示可用于多范围类型的函数。
表 9.60. 范围函数
函数
描述
示例
lower ( anyrange )
→ anyelement
提取范围的下界（如果范围为空或没有下界，则为NULL）。
lower(numrange(1.1,2.2))
→ 1.1
upper ( anyrange )
→ anyelement
提取范围的上限（如果范围为空或没有上限，则为NULL）。
upper(numrange(1.1,2.2))
→ 2.2
isempty ( anyrange )
→ boolean
范围为空吗？
isempty(numrange(1.1,2.2))
→ f
lower_inc ( anyrange )
→ boolean
范围的下界是否包含在内？
lower_inc(numrange(1.1,2.2))
→ t
upper_inc ( anyrange )
→ boolean
范围的上界是否包含在内？
upper_inc(numrange(1.1,2.2))
→ f
lower_inf ( anyrange )
→ boolean
该范围是否没有下界？（下界为-Infinity时返回false。）
lower_inf('(,)'::daterange)
→ t
upper_inf ( anyrange )
→ boolean
该范围是否没有上界？（上界为Infinity时返回false。）
upper_inf('(,)'::daterange)
→ t
range_merge ( anyrange, anyrange )
→ anyrange
计算包含两个给定范围的最小范围。
range_merge('[1,2)'::int4range, '[3,4)'::int4range)
→ [1,4)
表 9.61. 多范围函数
函数
描述
示例
lower ( anymultirange )
→ anyelement
提取多范围的下界（如果多范围为空或没有下界，则返回 NULL）。
lower('{[1.1,2.2)}'::nummultirange)
→ 1.1
upper ( anymultirange )
→ anyelement
提取多范围的上限（如果多范围为空或没有上限，则返回 NULL）。
upper('{[1.1,2.2)}'::nummultirange)
→ 2.2
isempty ( anymultirange )
→ boolean
多范围是否为空？
isempty('{[1.1,2.2)}'::nummultirange)
→ f
lower_inc ( anymultirange )
→ boolean
多范围的下界是否包括？
lower_inc('{[1.1,2.2)}'::nummultirange)
→ t
upper_inc ( anymultirange )
→ boolean
多范围的上界是否包括？
upper_inc('{[1.1,2.2)}'::nummultirange)
→ f
lower_inf ( anymultirange )
→ boolean
这个多范围是否没有下界？（下界为 -Infinity 时返回 false。）
lower_inf('{(,)}'::datemultirange)
→ t
upper_inf ( anymultirange )
→ boolean
多范围是否没有上界？（上界为Infinity时返回false。）
upper_inf('{(,)}'::datemultirange)
→ t
range_merge ( anymultirange )
→ anyrange
计算包含整个多范围的最小范围。
range_merge('{[1,2), [3,4)}'::int4multirange)
→ [1,4)
multirange ( anyrange )
→ anymultirange
返回仅包含给定范围的多范围。
multirange('[1,2)'::int4range)
→ {[1,2)}
unnest ( anymultirange )
→ setof anyrange
将多范围展开为按升序排列的一组范围。
unnest('{[1,2), [3,4)}'::int4multirange)
→
[1,2)
[3,4)
lower_inc、upper_inc、lower_inf和upper_inf函数对空范围或多范围都返回假。
上一页 上一级 下一页9.19. 数组函数和操作符 起始页 9.21. 聚合函数
