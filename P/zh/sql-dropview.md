# DROP VIEW

DROP VIEW
版本：
纠错本页面
搜索
目录导航
❮
❯
DROP VIEWDROP VIEW — 移除视图大纲
DROP VIEW [ IF EXISTS ] name [, ...] [ CASCADE | RESTRICT ]
描述
DROP VIEW 删除一个现有的视图。要执行
这个命令你必须是该视图的拥有者。
参数IF EXISTS
如果该视图不存在则不要抛出错误，而是发出提示。
name
要移除的视图的名称（可以是模式限定的）。
CASCADE
自动删除依赖于该视图的对象（例如其他视图），并且删除所有
依赖于那些对象的对象（见第 5.15 节）。
RESTRICT
如果有任何对象依赖于该视图，则拒绝删除它。这是默认行为。
示例
这个命令将移除名为kinds的视图：
DROP VIEW kinds;
兼容性
这个命令符合 SQL 标准，不过该标准只允许在每个命令中删除一个视图
，并且IF EXISTS选项是一个
PostgreSQL扩展。
另见ALTER VIEW, CREATE VIEW上一页 上一级 下一页DROP USER MAPPING 起始页 END
