# DROP FOREIGN TABLE

DROP FOREIGN TABLE
版本：
纠错本页面
搜索
目录导航
❮
❯
DROP FOREIGN TABLEDROP FOREIGN TABLE — 移除一个外部表大纲
DROP FOREIGN TABLE [ IF EXISTS ] name [, ...] [ CASCADE | RESTRICT ]
描述
DROP FOREIGN TABLE 移除一个外部表。
只有外部表的拥有者才能移除它。
参数IF EXISTS
如果该外部表不存在则不要抛出错误。
在这种情况下会发出一个提示。
name
要删除的外部表的名称（可以是模式限定的）。
CASCADE
自动删除依赖于该外部表的对象（例如视图），然后删除所有
依赖于那些对象的对象（见第 5.15 节）。
RESTRICT
如果有任何对象依赖于该外部表，则拒绝删除它。这是默认值。
示例
要销毁两个外部表 films 和
distributors：
DROP FOREIGN TABLE films, distributors;
兼容性
这个命令符合 ISO/IEC 9075-9 (SQL/MED)，不过该标准只允许每个命令
中删除一个外部表，并且除了IF EXISTS选项，该选项是一个
PostgreSQL扩展。
另见ALTER FOREIGN TABLE, CREATE FOREIGN TABLE上一页 上一级 下一页DROP FOREIGN DATA WRAPPER 起始页 DROP FUNCTION
