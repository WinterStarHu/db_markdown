# 53.12. pg_indexes

53.12. pg_indexes
版本：
纠错本页面
搜索
目录导航
❮
❯
53.12. pg_indexes #
视图 pg_indexes 提供了有关数据库中每个索引的有用信息。
表 53.12. pg_indexes 列
列类型
描述
schemaname name
(参考 pg_namespace.nspname)
包含表和索引的模式名
tablename name
(参考 pg_class.relname)
此索引的基表的名字
indexname name
(参考 pg_class.relname)
索引名
tablespace name
(参考 pg_tablespace.spcname)
包含索引的表空间名（如果是数据库的默认值则为空）
indexdef text
索引定义（重构的 CREATE INDEX
命令）
上一页 上一级 下一页53.11. pg_ident_file_mappings 起始页 53.13. pg_locks
