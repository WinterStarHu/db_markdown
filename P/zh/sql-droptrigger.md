# DROP TRIGGER

DROP TRIGGER
版本：
纠错本页面
搜索
目录导航
❮
❯
DROP TRIGGERDROP TRIGGER — 移除触发器大纲
DROP TRIGGER [ IF EXISTS ] name ON table_name [ CASCADE | RESTRICT ]
描述
DROP TRIGGER 移除一个现有的触发器定义。
要执行这个命令，当前用户必须是触发器基表的拥有者。
参数IF EXISTS
如果该触发器不存在则不要抛出错误，而是发出提示。
name
要移除的触发器名称。
table_name
定义了该触发器的表的名称（可以是模式限定的）。
CASCADE
自动删除依赖于该触发器的对象，然后删除所有
依赖于那些对象的对象（见第 5.15 节）。
RESTRICT
如果有任何对象依赖于该触发器，则拒绝删除它。这是默认值。
示例
销毁表films上的触发器
if_dist_exists：
DROP TRIGGER if_dist_exists ON films;
兼容性
DROP TRIGGER语句在
PostgreSQL中与 SQL 标准不
兼容。在 SQL 标准中，触发器名称不是表的局部，因此其
命令是简单的DROP TRIGGER
name。
另见CREATE TRIGGER上一页 上一级 下一页DROP TRANSFORM 起始页 DROP TYPE
