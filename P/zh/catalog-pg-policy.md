# 52.38. pg_policy

52.38. pg_policy
版本：
纠错本页面
搜索
目录导航
❮
❯
52.38. pg_policy #
目录pg_policy存储着表的行级安全性策略。
一个策略包括它适用于的命令种类（可能适用于所有命令）、它适用于的角色、
被作为安全屏障条件增加到包括该表的查询的表达式，以及被作为
WITH CHECK选项增加到尝试向表增加新记录的查询的表达式。
表 52.38. pg_policy 列
列类型
描述
oid oid
行标识符
polname name
策略的名称
polrelid oid
(references pg_class.oid)
策略适用的表
polcmd char
策略适用的命令类型：
r 表示 SELECT,
a 表示 INSERT,
w 表示 UPDATE,
d 表示 DELETE,
* 表示所有命令类型
polpermissive bool
策略是宽松的还是限制性的？
polroles oid[]
(references pg_authid.oid)
策略适用的角色；零意味着PUBLIC（通常在数组中单独出现）
polqual pg_node_tree
被作为安全屏障条件增加到使用该表的查询的表达式树
polwithcheck pg_node_tree
被作为WITH CHECK条件增加到尝试向表增加行的查询的表达式树
注意
存储在pg_policy中的策略只有在它们所适用的表的pg_class.relrowsecurity被设置时才生效。
上一页 上一级 下一页52.37. pg_partitioned_table 起始页 52.39. pg_proc
