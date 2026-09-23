# 52.53. pg_statistic_ext_data

52.53. pg_statistic_ext_data
版本：
纠错本页面
搜索
目录导航
❮
❯
52.53. pg_statistic_ext_data #
目录pg_statistic_ext_data保存扩展规划器统计信息的数据，这些统计信息在pg_statistic_ext中定义。
该目录的每一行对应于使用CREATE STATISTICS创建的一个统计信息对象。
通常，每个已分析的统计对象都有一个条目，其中stxdinherit =
false。如果表具有继承子项或分区，还会创建第二个条目，其中
stxdinherit = true。此行表示继承树上的统计对象，即，
您将看到的数据的统计信息
SELECT * FROM table*，
而stxdinherit = false行
表示
SELECT * FROM ONLY table的结果。
像pg_statistic一样，
pg_statistic_ext_data不应该对公众可读，因为内容可能被视为敏感。
（例如：列中最常见的值组合可能非常有趣。）
pg_stats_ext
是一个pg_statistic_ext_data上公开可读的视图，
（在与pg_statistic_ext连接后），
仅暴露当前用户拥有的表的信息。
表 52.53. pg_statistic_ext_data 列
列类型
描述
stxoid oid
(references pg_statistic_ext.oid)
包含此数据定义的扩展统计信息对象
stxdinherit bool
如果为 true，则统计信息包括子表中的值，而不仅仅是指定关系中的值
stxdndistinct pg_ndistinct
N-distinct 计数，序列化为 pg_ndistinct 类型
stxddependencies pg_dependencies
函数依赖统计信息，序列化为 pg_dependencies 类型
stxdmcv pg_mcv_list
MCV（最常见值）列表统计信息，序列化为 pg_mcv_list 类型
stxdexpr pg_statistic[]
每个表达式的统计信息，序列化为 pg_statistic 类型的数组
上一页 上一级 下一页52.52. pg_statistic_ext 起始页 52.54. pg_subscription
