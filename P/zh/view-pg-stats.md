# 53.29. pg_stats

53.29. pg_stats
版本：
纠错本页面
搜索
目录导航
❮
❯
53.29. pg_stats #
视图pg_stats提供对存储在pg_statistic目录中信息的访问。
此视图仅允许访问用户具有读取权限的表对应的pg_statistic行，
因此可以安全地允许对此视图进行公共读取访问。
pg_stats也旨在以比底层目录更易读的格式呈现信息—
但其模式必须在为pg_statistic定义新的槽类型时进行扩展。
表 53.29. pg_stats 列
列类型
描述
schemaname name
(引用 pg_namespace.nspname)
包含表的模式名称
tablename name
(引用 pg_class.relname)
表的名称
attname name
(引用 pg_attribute.attname)
被此行描述的列名
inherited bool
如果为 true，则此行包括来自子表的值，而不仅仅是指定表中的值
null_frac float4
列项中为空的比例
avg_width int4
列的条目的平均字节宽度
n_distinct float4
如果大于零，表示列中可区分值的估计个数。如果小于零，是可区分值个数除以行数的负值（当ANALYZE认为可区分值的数量会随着表增长而增加时采用负值的形式，而如果认为列具有固定数量的可选值时采用正值的形式）。例如，-1表示一个唯一列，即其中可区分值的个数等于行数。
most_common_vals anyarray
列中最常见值的列表。（如果没有任何值看起来比其他值更常见，则为NULL。）
most_common_freqs float4[]
最常见值的频率列表，即每个值的出现次数除以总行数。
（当most_common_vals为空时为NULL。）
histogram_bounds anyarray
将列的值划分为大致相等数量的组的值列表。
如果存在most_common_vals，则这些值会被从此直方图计算中省略。
（如果列数据类型没有<操作符，或者most_common_vals列表占据了整个数据集，则此列为NULL。）
correlation float4
物理行顺序与列值逻辑顺序之间的统计相关性。
其范围从-1到+1。当值接近-1或+1时，在列上的索引扫描被认为比接近0时的代价更低，因为这减少了对磁盘的随机访问。
（如果列数据类型没有<操作符，则此列为NULL。）
most_common_elems anyarray
在列值中最常出现的非空元素值的列表。（标量类型为NULL。）
most_common_elem_freqs float4[]
最常用元素值的频率列表，即包含至少一个给定值实例的行的比例。
每个元素的频率后面跟随两个或三个附加值；
这些是前面每个元素频率的最小值和最大值，以及可选的空元素频率。
（如果most_common_elems为空，则此列为NULL。）
elem_count_histogram float4[]
在列值中不同非空元素值计数的直方图，后面跟随不同非空元素的平均数。
（标量类型为NULL。）
range_length_histogram anyarray
非空且非NULL范围值的长度的直方图，适用于范围类型列。
（对于非范围类型则为NULL。）
此直方图使用subtype_diff范围函数计算，
无论范围边界是否包含。
range_empty_frac float4
列条目中值为空范围的比例。
（非范围类型为 NULL。）
range_bounds_histogram anyarray
非空且非空值范围的上下界直方图。（非范围类型为 NULL。）
这两个直方图表示为一个范围数组，其下界表示下界直方图，上界表示上界直方图。
数组字段中的条目最大数量可以通过逐列控制，使用ALTER
TABLE SET STATISTICS
命令，或者通过设置
default_statistics_target运行时参数来全局控制。
上一页 上一级 下一页53.28. pg_shmem_allocations_numa 起始页 53.30. pg_stats_ext
