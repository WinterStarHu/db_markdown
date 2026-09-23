# 53.14. pg_matviews

53.14. pg_matviews
版本：
纠错本页面
搜索
目录导航
❮
❯
53.14. pg_matviews #
视图 pg_matviews 提供了对数据库中每个物化视图的有用信息的访问。
表 53.14. pg_matviews 列
列类型
描述
schemaname name
(references pg_namespace.nspname)
包含物化视图的模式的名称
matviewname name
(references pg_class.relname)
物化视图的名称
matviewowner name
(references pg_authid.rolname)
物化视图拥有者的名称
tablespace name
(references pg_tablespace.spcname)
包含物化视图的表空间名称（如果使用数据库默认表空间则为空）
hasindexes bool
如果物化视图有（或最近有过）任何索引，则此列为真
ispopulated bool
如果物化视图当前已填充，则此列为真
definition text
物化视图的定义（一个重构的SELECT查询）
上一页 上一级 下一页53.13. pg_locks 起始页 53.15. pg_policies
