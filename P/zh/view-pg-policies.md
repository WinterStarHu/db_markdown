# 53.15. pg_policies

53.15. pg_policies
版本：
纠错本页面
搜索
目录导航
❮
❯
53.15. pg_policies #
视图pg_policies提供了有关数据库中每个行级安全策略的有用信息。
表 53.15. pg_policies 列
列类型
描述
schemaname name
(参考 pg_namespace.nspname)
包含策略所在表的模式的名称
tablename name
(参考 pg_class.relname)
策略所在表的名称
policyname name
(参考 pg_policy.polname)
策略名称
permissive text
策略是宽松的还是限制性的？
roles name[]
这个策略适用的角色
cmd text
这个策略适用的命令类型
qual text
作为这个策略适用的查询的安全屏障条件增加的表达式
with_check text
作为尝试向该表增加行的查询的 WITH CHECK 条件增加的表达式
上一页 上一级 下一页53.14. pg_matviews 起始页 53.16. pg_prepared_statements
