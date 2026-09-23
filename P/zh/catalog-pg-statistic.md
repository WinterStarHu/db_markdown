# 52.51. pg_statistic

52.51. pg_statistic
版本：
纠错本页面
搜索
目录导航
❮
❯
52.51. pg_statistic #
目录pg_statistic存储有关数据库内容的统计数据。
其中的项由ANALYZE创建，查询规划器会使用这些数据来进行查询规划。
注意所有的统计数据天然就是近似的，即使它是最新的。
通常，每个已分析的表列都有一个条目，其中stainherit = false。
如果表具有继承子项或分区，则还会创建第二个条目，其中stainherit = true。
此行表示继承树上列的统计信息，即您可以通过SELECT column FROM table*看到的数据的统计信息，
而stainherit = false行表示SELECT column FROM ONLY table的结果。
pg_statistic也存储关于索引表达式值的统计数据，就好像它们是真正的数据列；特别是starelid引用了索引。
对一个普通非表达式索引列不会创建项，因为它将是底层表列的项的冗余。当前，索引表达式的项都具有stainherit = false。
因为不同类型的统计信息适用于不同类型的数据，pg_statistic被设计成不太在意自己存储的是什么类型的统计。
只有极为常用的统计信息（比如NULL的含量）才在pg_statistic里给予专用的字段。其他所有东西都存储在“槽位”中，而槽位是一组相关的列，
它们的内容用槽位中的一个列里的代码表示。更详细的信息请参阅src/include/catalog/pg_statistic.h。
pg_statistic不应该是公共可读的，因为即使是一个表内容的统计性信息也可能被认为是敏感的（例子：一个薪水列的最大和最小值可能是非常有趣的）。
pg_stats是pg_statistic上的一个公共可读的视图，它只会显示出当前用户可读的表的信息。
表 52.51. pg_statistic 列
列类型
描述
starelid oid
(references pg_class.oid)
被描述列所属的表或索引
staattnum int2
(references pg_attribute.attnum)
被描述列的编号
stainherit bool
如果为 true，则统计信息包括子表中的值，而不仅仅是指定关系中的值
stanullfrac float4
列的项为空的比例
stawidth int4
非空项的平均存储宽度，以字节计
stadistinct float4
列中非空唯一值的数目。一个大于零的值是唯一值的真正数目。
一个小于零的值是表中行数的乘数的负值；例如，对于一个 80% 的值为非空且每个非空值平均出现两次的列，可以表示为 stadistinct = -0.4。一个零值表示唯一值的数目未知。
stakindN int2
一个代码，表示存储在 pg_statistic 行中第 N 个 “槽位” 的统计类型。
staopN oid
(references pg_operator.oid)
一个用于生成存储在第 N 个 “槽位” 的统计信息的操作符。
例如，一个柱面图槽位会用 < 操作符，该操作符定义了该数据的排序顺序。
如果统计类型不需要操作符则为零。
stacollN oid
(references pg_collation.oid)
排序规则用于导出存储在第N个“槽”中的统计信息。
例如，可排序列的直方图槽将显示定义数据排序顺序的排序规则。对于不可排序数据，为零。
stanumbersN float4[]
第N个“槽”的数值统计， 如果该槽不涉及数值类型则为null
stavaluesN anyarray
第N个“槽”的列数据值，如果该槽不存储任何数据值则为null。
每个数组的元素值实际上都是指定列的数据类型或者是一个相关类型（如数组元素类型），
因此，除了把这些列的类型定义成anyarray之外别无他法。
上一页 上一级 下一页52.50. pg_shseclabel 起始页 52.52. pg_statistic_ext
