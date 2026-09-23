# 52.59. pg_ts_config

52.59. pg_ts_config
版本：
纠错本页面
搜索
目录导航
❮
❯
52.59. pg_ts_config #
pg_ts_config目录包含表示文本搜索配置的条目。一个配置指定了一个特定的文本搜索解析器和一个用于解析器输出记号类型的字典列表。解析器在pg_ts_config项中显示，但记号到字典的映射由pg_ts_config_map中的辅助项定义。
PostgreSQL的文本搜索特性在第 12 章中有更详尽的描述。
表 52.59. pg_ts_config 列
列类型
描述
oid oid
行标识符
cfgname name
文本搜索配置名
cfgnamespace oid
(references pg_namespace.oid)
包含该配置的命名空间的OID
cfgowner oid
(references pg_authid.oid)
配置的拥有者
cfgparser oid
(references pg_ts_parser.oid)
该配置的文本搜索解析器的OID
上一页 上一级 下一页52.58. pg_trigger 起始页 52.60. pg_ts_config_map
