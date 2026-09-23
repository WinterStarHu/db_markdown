# 52.47. pg_sequence

52.47. pg_sequence
版本：
纠错本页面
搜索
目录导航
❮
❯
52.47. pg_sequence #
目录pg_sequence包含有关序列的信息。
一些序列的信息（例如名称和模式）放在pg_class中。
表 52.47. pg_sequence Columns
列类型
描述
seqrelid oid
(references pg_class.oid)
该序列的pg_class项的OID
seqtypid oid
(references pg_type.oid)
序列的数据类型
seqstart int8
序列的起始值
seqincrement int8
序列的增量值
seqmax int8
序列的最大值
seqmin int8
序列的最小值
seqcache int8
序列的缓存大小
seqcycle bool
序列是否循环
上一页 上一级 下一页52.46. pg_seclabel 起始页 52.48. pg_shdepend
