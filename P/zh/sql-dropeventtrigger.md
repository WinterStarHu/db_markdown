# DROP EVENT TRIGGER

DROP EVENT TRIGGER
版本：
纠错本页面
搜索
目录导航
❮
❯
DROP EVENT TRIGGERDROP EVENT TRIGGER — 移除事件触发器大纲
DROP EVENT TRIGGER [ IF EXISTS ] name [ CASCADE | RESTRICT ]
描述
DROP EVENT TRIGGER 移除一个已有的
事件触发器。要执行这个命令，当前用户必须是事件触发器的拥有者。
参数IF EXISTS
如果该事件触发器不存在，则不要抛出错误，而是发出提示。
name
要移除的事件触发器的名称。
CASCADE
自动删除依赖于该触发器的对象，然后删除所有
依赖于那些对象的对象（见第 5.15 节）。
RESTRICT
如果有任何对象依赖于该触发器，则拒绝删除它。这是
默认值。
示例
销毁触发器snitch：
DROP EVENT TRIGGER snitch;
兼容性
在 SQL 标准中没有DROP EVENT TRIGGER语句。
其他参考CREATE EVENT TRIGGER, ALTER EVENT TRIGGER上一页 上一级 下一页DROP DOMAIN 起始页 DROP EXTENSION
