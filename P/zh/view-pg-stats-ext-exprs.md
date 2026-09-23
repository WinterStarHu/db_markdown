# 53.31. pg_stats_ext_exprs

53.31. pg_stats_ext_exprs
版本：
纠错本页面
搜索
目录导航
❮
❯
53.31. pg_stats_ext_exprs #
视图pg_stats_ext_exprs提供对扩展统计对象中包含的所有表达式信息的访问，
结合存储在pg_statistic_ext
和pg_statistic_ext_data
目录中的信息。此视图仅允许访问用户拥有的
pg_statistic_ext和pg_statistic_ext_data
表对应的行，因此可以安全地允许对此视图进行公共读访问。
pg_stats_ext_exprs也旨在以比底层目录更易读的格式呈现信息—
但其模式必须在pg_statistic_ext中的统计结构更改时进行扩展。
表 53.31. pg_stats_ext_exprs 列
列类型
描述
schemaname name
(references pg_namespace.nspname)
包含表的模式名称
tablename name
(references pg_class.relname)
统计对象定义的表的名称
statistics_schemaname name
(references pg_namespace.nspname)
包含扩展统计对象的模式名称
statistics_name name
(参考 pg_statistic_ext.stxname)
扩展统计对象的名称
statistics_owner name
(参考 pg_authid.rolname)
扩展统计对象的拥有者
expr text
扩展统计对象中包含的表达式
inherited bool
(引用 pg_statistic_ext_data.stxdinherit)
如果为真，则统计信息包括子表中的值，而不仅仅是指定关系中的值
null_frac float4
表达式条目为空的比例
avg_width int4
表达式条目的平均宽度，以字节表示
n_distinct float4
如果大于零，表达式中不同值的估算数量。如果小于零，不同值的数量的负值被行数除。
(当ANALYZE相信不同值的数量可能随着表的增长而增加时，使用负数形式；当表达式看起来有固定数量的可能值时，使用正数形式。)例如，-1表示不同值的数量与行数相同的唯一表达式。
most_common_vals anyarray
表达式中最常见值的列表（如果没有值看起来比任何其他值更常见则为空）
most_common_freqs float4[]
最常用值的频率列表，即每一个常用值的出现次数除以总行数。
(如果most_common_vals为空，则此列为空。)
histogram_bounds anyarray
一列表值，将表达式的值分为大致相等的组。该值在
most_common_vals中，如果存在，将从这个直方图计算中省略。
（如果表达式的数据类型不具有<操作符或者如果
most_common_vals列表占了全部整体的比例，这个表达式为空。）
correlation float4
表达式的值的物理行排序和逻辑排序之间的统计相关性。这个范围从-1到+1。
当该值接近-1或+1时，对表达式的索引扫描预计要比接近零的时候更便宜，
因为减少了对磁盘的随机访问。(如果表达式的数据类型没有<操作符，则该表达式为空。)
most_common_elems anyarray
与表达式的值一起最常出现的非空元素值的列表。(标量类型时为空)
most_common_elem_freqs float4[]
最常用元素值的频度列表，即含有至少一个给定值实例的行的分数。
在每个元素的频度之后有二至三个附加值，它们是每个元素频度的最小和最大值，
以及可选的空元素的频度。(如果most_common_elems为空，则此列为空。)
elem_count_histogram float4[]
表达式值的不同非空元素值的计数的直方图，后面跟着不同非空元素的平均数量。(标量类型时为空)
数组字段中的条目数最大值可以通过逐列控制，使用ALTER
TABLE SET STATISTICS命令，或者通过设置
default_statistics_target运行时参数来全局控制。
上一页 上一级 下一页53.30. pg_stats_ext 起始页 53.32. pg_tables
