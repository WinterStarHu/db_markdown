# DROP POLICY

DROP POLICY
版本：
纠错本页面
搜索
目录导航
❮
❯
DROP POLICYDROP POLICY — 从表中移除一条行级安全策略大纲
DROP POLICY [ IF EXISTS ] name ON table_name [ CASCADE | RESTRICT ]
说明
DROP POLICY从指定的表中移除该策略。注意，如果从一个表移除了最后一条策略，并且该表的行级安全性仍然通过ALTER TABLE启用，则将使用默认的否定策略。ALTER TABLE ... DISABLE ROW LEVEL SECURITY可以用来禁用一个表的行级安全性，无论该表是否存在策略。
参数IF EXISTS
如果该策略不存在也不抛出错误。这种情况下会发出一个通知。
name
要删除的策略名称。
table_name
该策略所在的表的名称（可选地被模式限定）。
CASCADERESTRICT
这些关键词不会产生任何效果，因为策略之上没有依赖关系。
示例
要在名为my_table的表上删除策略p1：
DROP POLICY p1 ON my_table;
兼容性
DROP POLICY是一种PostgreSQL扩展。
另见CREATE POLICY, ALTER POLICY上一页 上一级 下一页DROP OWNED 起始页 DROP PROCEDURE
