# 52.2. pg_aggregate

52.2. pg_aggregate
版本：
纠错本页面
搜索
目录导航
❮
❯
52.2. pg_aggregate #
目录pg_aggregate存储关于聚合函数的信息。
聚合函数是对一个数值集合（典型的是每个匹配查询条件的行中的同一个列的值）进行操作的函数，它返回从这些值中计算出的一个数值。
典型的聚合函数是 sum、count和max。
pg_aggregate里的每个项都是一个pg_proc项的扩展。
pg_proc项记载该聚合的名字、输入和输出数据类型，以及其他一些和普通函数类似的信息。
表 52.2. pg_aggregate 列
列类型
描述
aggfnoid regproc
(references pg_proc.oid)
聚合函数的pg_proc OID
aggkind char
聚合类型：
n 表示 “普通” 聚合,
o 表示 “有序集” 聚合, 或
h 表示 “假想集” 聚合
aggnumdirectargs int2
一个有序集或者假想集聚合的直接（非聚合）参数的数量，一个可变数组算作一个参数。
如果等于pronargs，该聚合必定是可变的并且该可变数组描述聚合参数以及最终直接参数。
对于普通聚合总是为零。
aggtransfn regproc
(references pg_proc.oid)
转换函数
aggfinalfn regproc
(references pg_proc.oid)
最终函数（如果没有则为零）
aggcombinefn regproc
(references pg_proc.oid)
结合函数（如果没有则为零）
aggserialfn regproc
(references pg_proc.oid)
序列化函数（如果没有则为零）
aggdeserialfn regproc
(references pg_proc.oid)
反序列化函数（如果没有则为零）
aggmtransfn regproc
(references pg_proc.oid)
用于移动聚合模式的向前转移函数（如果没有则为零）
aggminvtransfn regproc
(references pg_proc.oid)
用于移动聚合模式的反向转移函数（如果没有则为零）
aggmfinalfn regproc
(references pg_proc.oid)
用于移动聚合模式的最终函数（如果没有则为零）
aggfinalextra bool
True 将额外的虚拟参数传递给 aggfinalfn
aggmfinalextra bool
True 将额外的虚拟参数传递给 aggmfinalfn
aggfinalmodify char
aggfinalfn 是否修改过渡状态值：
如果是只读则为r ,
如果不能在aggfinalfn之后应用aggtransfn则为s,
或者如果它修改该值则为w
aggmfinalmodify char
和aggfinalmodify类似，但是用于aggmfinalfn
aggsortop oid
(references pg_operator.oid)
相关联的排序操作符（如果没有则为0）
aggtranstype oid
(references pg_type.oid)
聚合函数的内部过渡（状态）数据的数据类型
aggtransspace int4
过渡状态数据的近似平均大小（字节），或者为零表示使用默认估算值
aggmtranstype oid
(references pg_type.oid)
聚合函数用于移动聚合模式的内部过渡（状态）数据的数据类型（如果没有则为零）
aggmtransspace int4
移动聚合模式的过渡状态数据的近似平均大小（字节），或者为零表示使用默认估算值
agginitval text
过渡状态的初始值。这是一个文本字段，包含初始值的外部字符串表现形式。如果该字段为空，则过渡状态值从空值开始。
aggminitval text
用于移动聚合模式的转移状态初值。这是一个文本字段，它包含了以其外部字符串表示形式表达的初值。
如果这个字段为空，则转移状态值从空值开始。
新的聚集函数可通过CREATE AGGREGATE命令注册。
更多关于编写聚集函数以及转移函数的含义等信息请参见第 36.12 节。
上一页 上一级 下一页52.1. 概述 起始页 52.3. pg_am
