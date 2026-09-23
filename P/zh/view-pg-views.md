# 53.37. pg_views

53.37. pg_views
版本：
纠错本页面
搜索
目录导航
❮
❯
53.37. pg_views #
视图pg_views提供了对数据库中每个视图的有用信息的访问。
表 53.37. pg_views 列
列类型
描述
schemaname name
(references pg_namespace.nspname)
包含视图的模式名
viewname name
(参考 pg_class.relname)
视图名称
viewowner name
(references pg_authid.rolname)
视图拥有者的名字
definition text
视图定义（一个重构的SELECT查询）
上一页 上一级 下一页53.36. pg_user_mappings 起始页 53.38. pg_wait_events
