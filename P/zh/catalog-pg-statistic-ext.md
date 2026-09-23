# 52.52. pg_statistic_ext

52.52. pg_statistic_ext
版本：
纠错本页面
搜索
目录导航
❮
❯
52.52. pg_statistic_ext #
目录pg_statistic_ext包含了扩展的规划器统计信息的定义。
这个目录中的每一行对应于一个用CREATE STATISTICS创建的统计信息对象。
表 52.52. pg_statistic_ext 列
列类型
描述
oid oid
行标识符
stxrelid oid
(references pg_class.oid)
包含该对象所描述的列的表
stxname name
统计信息对象的名称
stxnamespace oid
(references pg_namespace.oid)
包含该统计信息对象的命名空间的OID
stxowner oid
(references pg_authid.oid)
统计信息对象的拥有者
stxkeys int2vector
(references pg_attribute.attnum)
一个属性编号的数组，表示哪些表列被该统计信息对象覆盖；
例如值1 3表示第一个和第三个表列被覆盖
stxstattarget int2
stxstattarget 控制由
ANALYZE 为该统计对象
累积的统计信息的详细程度。值为零表示不应收集统计信息。
空值表示使用被引用列的统计目标中的最大值（如果设置了），
或系统默认的统计目标。stxstattarget 的正值
决定要收集的“最常见值”的目标数量。
stxkind char[]
包含被启用统计类型代码的数组，可用的值有：
d表示n-distinct统计信息，
f表示函数依赖统计信息，
m表示最常见值（MCV）列表的统计信息，以及
e表示表达式的统计信息
stxexprs pg_node_tree
对于不是简单列引用的统计信息对象属性的表达式树（在 nodeToString() 中表现）
这是一个每个表达式一个元素的清单。
如果所有统计信息对象属性都是简单引用，则为空。
pg_statistic_ext条目在CREATE STATISTICS期间完全填充，但是实际的统计值并不会在此时计算。
后续的ANALYZE命令计算所需的值，并在pg_statistic_ext_data目录中填充条目。
上一页 上一级 下一页52.51. pg_statistic 起始页 52.53. pg_statistic_ext_data
