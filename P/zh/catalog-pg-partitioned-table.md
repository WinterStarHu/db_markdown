# 52.37. pg_partitioned_table

52.37. pg_partitioned_table
版本：
纠错本页面
搜索
目录导航
❮
❯
52.37. pg_partitioned_table #
目录pg_partitioned_table存放有关表如何被分区的信息。
表 52.37. pg_partitioned_table 列
列类型
描述
partrelid oid
(references pg_class.oid)
这个分区表的pg_class项的OID
partstrat char
分区策略；h = 哈希分区表，
l = 列表分区表，r = 范围分区表
partnatts int2
分区键中的列数
partdefid oid
(references pg_class.oid)
这个分区表的默认分区的pg_class项的OID，如果这个分区表没有默认分区则为零。
partattrs int2vector
(references pg_attribute.attnum)
这是一个长度为partnatts值的数组，它指示哪些表列是分区键的组成部分。
例如，值1 3表示第一个和第三个表列组成了分区键。这个数组中的零表示对应的分区键列是一个表达式而不是简单的列引用。
partclass oidvector
(references pg_opclass.oid)
对于分区键中的每一个列，这个域包含要使用的操作符类的OID。
详见pg_opclass。
partcollation oidvector
(references pg_collation.oid)
对于分区键中的每一个列，这个域包含要用于分区的排序规则的OID，如果该列不是一种可排序数据类型则为零。
partexprs pg_node_tree
非简单列引用的分区键列的表达式树（以nodeToString()的表达方式）。
这是一个列表，partattrs中每一个零项都有一个元素。如果所有分区键列都是简单引用，则该值为NULL。
上一页 上一级 下一页52.36. pg_parameter_acl 起始页 52.38. pg_policy
