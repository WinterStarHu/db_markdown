# ALTER RULE

ALTER RULE
版本：
纠错本页面
搜索
目录导航
❮
❯
ALTER RULEALTER RULE — 更改规则的定义大纲
ALTER RULE name ON table_name RENAME TO new_name
描述
ALTER RULE更改现有规则的属性。当前，唯一可用的
动作是更改规则的名称。
要使用ALTER RULE，你必须拥有该规则适用的表或视图。
参数name
要更改的一条现有规则的名称。
table_name
该规则适用的表或视图的名称（可以是模式限定的）。
new_name
该规则的新名称。
示例
要重命名一条现有的规则：
ALTER RULE notify_all ON emp RENAME TO notify_me;
兼容性
ALTER RULE是一种
PostgreSQL的语言扩展，整个查询重写系统也是。
另见CREATE RULE, DROP RULE上一页 上一级 下一页ALTER ROUTINE 起始页 ALTER SCHEMA
