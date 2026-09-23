# DROP DOMAIN

DROP DOMAIN
版本：
纠错本页面
搜索
目录导航
❮
❯
DROP DOMAINDROP DOMAIN — 删除一个域大纲
DROP DOMAIN [ IF EXISTS ] name [, ...] [ CASCADE | RESTRICT ]
描述
DROP DOMAIN 删除一个域。只有域的拥有者
才能移除它。
参数IF EXISTS
如果该域不存在则不要抛出错误，而是发出一个提示。
name
一个现有域的名称（可以是模式限定的）。
CASCADE
自动删除依赖于该域的对象（例如表列），并依次删除所有
依赖于那些对象的对象（见第 5.15 节）。
RESTRICT
如果有任何对象依赖于该域，则拒绝删除它。这是默认行为。
示例
要移除域box：
DROP DOMAIN box;
兼容性
此命令符合 SQL 标准，除了IF EXISTS选项，该选项
是一个PostgreSQL扩展。
另见CREATE DOMAIN, ALTER DOMAIN上一页 上一级 下一页DROP DATABASE 起始页 DROP EVENT TRIGGER
