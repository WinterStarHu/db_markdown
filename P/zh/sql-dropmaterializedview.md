# DROP MATERIALIZED VIEW

DROP MATERIALIZED VIEW
版本：
纠错本页面
搜索
目录导航
❮
❯
DROP MATERIALIZED VIEWDROP MATERIALIZED VIEW — 移除物化视图大纲
DROP MATERIALIZED VIEW [ IF EXISTS ] name [, ...] [ CASCADE | RESTRICT ]
描述
DROP MATERIALIZED VIEW 删除一个
现有的物化视图。要执行这个命令，你必须是该物化视图的拥有者。
参数IF EXISTS
如果该物化视图不存在，则不要抛出错误，而是发出一个提示。
name
要移除的物化视图的名称（可以是模式限定的）。
CASCADE
自动删除依赖于该物化视图的对象（例如其他物化视图或常规视图），然后删除所有
依赖于那些对象的对象（见第 5.15 节）。
RESTRICT
如果有任何对象依赖于该物化视图，则拒绝删除它。这是默认值。
示例
这个命令将移除名为order_summary的物化视图：
DROP MATERIALIZED VIEW order_summary;
兼容性
DROP MATERIALIZED VIEW是一个
PostgreSQL扩展。
其他参考CREATE MATERIALIZED VIEW, ALTER MATERIALIZED VIEW, REFRESH MATERIALIZED VIEW上一页 上一级 下一页DROP LANGUAGE 起始页 DROP OPERATOR
