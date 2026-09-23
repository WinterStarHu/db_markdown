# 53.24. pg_sequences

53.24. pg_sequences
版本：
纠错本页面
搜索
目录导航
❮
❯
53.24. pg_sequences #
视图pg_sequences提供了对数据库中每个序列的有用信息的访问。
表 53.24. pg_sequences 列
列类型
描述
schemaname name
(references pg_namespace.nspname)
包含序列的模式名
sequencename name
(references pg_class.relname)
序列的名称
sequenceowner name
(references pg_authid.rolname)
序列的拥有者名称
data_type regtype
(references pg_type.oid)
序列的数据类型
start_value int8
序列的起始值
min_value int8
序列的最小值
max_value int8
序列的最大值
increment_by int8
序列的增量值
cycle bool
序列是否循环
cache_size int8
序列的缓存大小
last_value int8
最后写入磁盘的序列值。如果使用了缓存，该值可能大于从序列中分配
的最后一个值。
如果以下任意条件为真，last_value列将显示为null：
序列尚未被读取。
当前用户没有该序列的USAGE或SELECT权限。
该序列未记录日志且服务器为备用。
上一页 上一级 下一页53.23. pg_seclabels 起始页 53.25. pg_settings
