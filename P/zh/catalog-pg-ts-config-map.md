# 52.60. pg_ts_config_map

52.60. pg_ts_config_map
版本：
纠错本页面
搜索
目录导航
❮
❯
52.60. pg_ts_config_map #
pg_ts_config_map目录包含的项展示了对于每一个文本搜索配置的每一种输出记号类型，有哪些文本搜索字典可供查询以及以何种顺序。
PostgreSQL的文本搜索特性在第 12 章中有更详尽的描述。
表 52.60. pg_ts_config_map Columns
列类型
描述
mapcfg oid
(references pg_ts_config.oid)
拥有该映射项的pg_ts_config项的OID
maptokentype int4
由配置的分析器发出的记号类型
mapseqno int4
查询该项的顺序（mapseqno值小的优先）
mapdict oid
(references pg_ts_dict.oid)
要查询的文本搜索字典的OID
上一页 上一级 下一页52.59. pg_ts_config 起始页 52.61. pg_ts_dict
