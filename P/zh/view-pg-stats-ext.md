# 53.30. pg_stats_ext

53.30. pg_stats_ext
版本：
纠错本页面
搜索
目录导航
❮
❯
53.30. pg_stats_ext #
视图pg_stats_ext提供对数据库中每个扩展统计对象的信息的访问，
结合存储在pg_statistic_ext和
pg_statistic_ext_data目录中的信息。
此视图仅允许访问用户拥有的pg_statistic_ext
和pg_statistic_ext_data的行，
因此可以安全地允许对此视图进行公共读访问。
pg_stats_ext也旨在以比底层目录更易读的格式呈现信息
— 代价是每当添加新类型的扩展统计信息到pg_statistic_ext时，必须扩展其模式。
表 53.30. pg_stats_ext 列
列类型
描述
schemaname name
(参考 pg_namespace.nspname)
包含表的模式名称
tablename name
(references pg_class.relname)
表的名称
statistics_schemaname name
(references pg_namespace.nspname)
包含扩展统计信息对象的模式名称
statistics_name name
(references pg_statistic_ext.stxname)
扩展统计信息对象的名称
statistics_owner name
(references pg_authid.rolname)
扩展统计信息对象的拥有者
attnames name[]
(references pg_attribute.attname)
包含在扩展统计信息对象中的列名称
exprs text[]
包含在扩展统计信息对象中的表达式
kinds char[]
为此记录启用的扩展统计信息对象的类型
inherited bool
(引用 pg_statistic_ext_data.stxdinherit)
如果为真，则统计信息包括子表中的值，而不仅仅是指定关系中的值
n_distinct pg_ndistinct
列值组合的N-不同计数。如果大于零，则为组合中不同值的估计数量。如果小于零，则为不同值数量的负数除以行数。
（当ANALYZE 认为随着表的增长不同值的数量可能会增加时，使用负数形式；当该列似乎具有固定数量的可能值时，则使用正数形式。）
例如，-1表示列的唯一组合，其中不同组合的数量与行数相同。
dependencies pg_dependencies
功能依赖关系统计信息
most_common_vals text[]
列中值的最常见组合的列表（如果没有组合看上去比其他的更常见，则为空。）
most_common_val_nulls bool[]
值最常见组合的NULL标志的列表（当most_common_vals为空时，为空。）
most_common_freqs float8[]
最常见组合的频率的列表，即每个出现的数量除以行的总数（当most_common_vals为空时，为空）
most_common_base_freqs float8[]
最常见组合的基本频率的列表，即每个值频率的乘积。（当most_common_vals为空时，为空。）
数组字段中的条目数最大值可以通过逐列控制，使用ALTER
TABLE SET STATISTICS命令，或者通过设置
default_statistics_target运行时参数来全局控制。
上一页 上一级 下一页53.29. pg_stats 起始页 53.31. pg_stats_ext_exprs
