# 52.45. pg_rewrite

52.45. pg_rewrite
版本：
纠错本页面
搜索
目录导航
❮
❯
52.45. pg_rewrite #
目录pg_rewrite存储表和视图的重写规则。
表 52.45. pg_rewrite 列
列类型
描述
oid oid
行标识符
rulename name
规则名称
ev_class oid
(references pg_class.oid)
该规则适用的表
ev_type char
该规则适用的事件类型： 1 = SELECT, 2 = UPDATE, 3 = INSERT, 4 = DELETE
ev_enabled char
控制在哪种session_replication_role模式中触发该规则。
O = 规则在“origin”和“local”模式触发，
D = 规则被禁用，
R = 规则在“replica”模式触发，
A = 规则总是被触发。
is_instead bool
为真表示是一个INSTEAD规则
ev_qual pg_node_tree
规则条件的表达式树（按照nodeToString()的表现形式）
ev_action pg_node_tree
规则动作的查询树（按照nodeToString()的表现形式）
注意
如果一个表在这个目录中有任何规则，pg_class.relhasrules必须为真。
上一页 上一级 下一页52.44. pg_replication_origin 起始页 52.46. pg_seclabel
