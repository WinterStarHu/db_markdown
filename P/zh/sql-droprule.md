# DROP RULE

DROP RULE
版本：
纠错本页面
搜索
目录导航
❮
❯
DROP RULEDROP RULE — 移除重写规则大纲
DROP RULE [ IF EXISTS ] name ON table_name [ CASCADE | RESTRICT ]
描述
DROP RULE 删除重写规则。
参数IF EXISTS
如果该规则不存在，则不要抛出错误，而是发出提示。
name
要删除的规则名称。
table_name
该规则适用的表或视图的名称（可以是模式限定的）。
CASCADE
自动删除依赖于该规则的对象，然后删除所有
依赖于那些对象的对象（见第 5.15 节）。
RESTRICT
如果有任何对象依赖于该规则，则拒绝删除它。这是默认值。
示例
要删除重写规则newrule：
DROP RULE newrule ON mytable;
兼容性
DROP RULE是一个
PostgreSQL语言扩展，整个
查询重写系统也是这样。
其他参考CREATE RULE, ALTER RULE上一页 上一级 下一页DROP ROUTINE 起始页 DROP SCHEMA
