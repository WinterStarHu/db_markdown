# 53.32. pg_tables

53.32. pg_tables
版本：
纠错本页面
搜索
目录导航
❮
❯
53.32. pg_tables #
视图pg_tables提供了对数据库中每个表的有用信息的访问。
表 53.32. pg_tables 列
列类型
描述
schemaname name
(引用 pg_namespace.nspname)
包含表的模式名称
tablename name
(引用 pg_class.relname)
表的名称
tableowner name
(引用 pg_authid.rolname)
表拥有者的名字
tablespace name
(引用 pg_tablespace.spcname)
包含表的表空间的名字（如果使用数据库的默认表空间，此列为空）
hasindexes bool
(引用 pg_class.relhasindex)
如果表有（或最近有过）任何索引，此列为真
hasrules bool
(references pg_class.relhasrules)
如果表有（或曾经有过）规则，此列为真
hastriggers bool
(references pg_class.relhastriggers)
如果表有（或曾经有过）触发器，此列为真
rowsecurity bool
(references pg_class.relrowsecurity)
如果表上启用了行安全性，则为真
上一页 上一级 下一页53.31. pg_stats_ext_exprs 起始页 53.33. pg_timezone_abbrevs
