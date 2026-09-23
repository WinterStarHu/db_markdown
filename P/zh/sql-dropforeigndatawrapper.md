# DROP FOREIGN DATA WRAPPER

DROP FOREIGN DATA WRAPPER
版本：
纠错本页面
搜索
目录导航
❮
❯
DROP FOREIGN DATA WRAPPERDROP FOREIGN DATA WRAPPER — 移除一个外部数据包装器大纲
DROP FOREIGN DATA WRAPPER [ IF EXISTS ] name [, ...] [ CASCADE | RESTRICT ]
描述
DROP FOREIGN DATA WRAPPER
移除一个已有的外部数据包装器。要执行这个命令，当前用户
必须是该外部数据包装器的拥有者。
参数IF EXISTS
如果该外部数据包装器不存在则不要抛出错误，而是发出一个提示。
name
一个现有外部数据包装器的名称。
CASCADE
自动删除依赖于该外部数据包装器的对象（例如外部表和服务器），然后删除所有
依赖于那些对象的对象（见第 5.15 节）。
RESTRICT
如果有任何对象依赖于该外部数据包装器，则拒绝删除它。这是默认值。
示例
删除外部数据包装器dbi：
DROP FOREIGN DATA WRAPPER dbi;
兼容性
DROP FOREIGN DATA WRAPPER符合 ISO/IEC
9075-9 (SQL/MED)。IF EXISTS子句
是一个PostgreSQL扩展。
另见CREATE FOREIGN DATA WRAPPER, ALTER FOREIGN DATA WRAPPER上一页 上一级 下一页DROP EXTENSION 起始页 DROP FOREIGN TABLE
