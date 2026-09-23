# DROP SEQUENCE

DROP SEQUENCE
版本：
纠错本页面
搜索
目录导航
❮
❯
DROP SEQUENCEDROP SEQUENCE — 移除序列大纲
DROP SEQUENCE [ IF EXISTS ] name [, ...] [ CASCADE | RESTRICT ]
描述
DROP SEQUENCE 移除序列生成器。一个序列只能被其拥有者或超级用户删除。
参数IF EXISTS
如果该序列不存在则不要抛出错误，而是发出提示。
name
一个序列的名称（可以是模式限定的）。
CASCADE
自动删除依赖于该序列的对象，然后删除所有
依赖于那些对象的对象（见第 5.15 节）。
RESTRICT
如果有任何对象依赖于该序列，则拒绝删除它。这是默认值。
示例
要移除序列serial：
DROP SEQUENCE serial;
兼容性
DROP SEQUENCE符合
SQL标准，不过该标准只允许每个命令中删除一个
序列，并且除了IF EXISTS选项，该选项是一个
PostgreSQL扩展。
另见CREATE SEQUENCE, ALTER SEQUENCE上一页 上一级 下一页DROP SCHEMA 起始页 DROP SERVER
