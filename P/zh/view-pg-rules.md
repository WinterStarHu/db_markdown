# 53.22. pg_rules

53.22. pg_rules
版本：
纠错本页面
搜索
目录导航
❮
❯
53.22. pg_rules #
视图 pg_rules 提供了有关查询重写规则的有用信息。
表 53.22. pg_rules 列
列类型
描述
schemaname name
(参考 pg_namespace.nspname)
包含表的模式名称
tablename name
(references pg_class.relname)
规则适用的表名
rulename name
(references pg_rewrite.rulename)
规则名
definition text
规则定义（创建命令的重构）
视图pg_rules排除了视图和物化视图的ON SELECT规则；
这些规则可以在pg_views和
pg_matviews中看到。
上一页 上一级 下一页53.21. pg_roles 起始页 53.23. pg_seclabels
