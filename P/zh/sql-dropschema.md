# DROP SCHEMA

DROP SCHEMA
版本：
纠错本页面
搜索
目录导航
❮
❯
DROP SCHEMADROP SCHEMA — 移除一个模式大纲
DROP SCHEMA [ IF EXISTS ] name [, ...] [ CASCADE | RESTRICT ]
描述
DROP SCHEMA从数据库中移除模式。
一个模式只能由其拥有者或超级用户删除。注意即使拥有者不拥有
该模式中的某些对象，也能删除该模式（以及所有含有的对象）。
参数IF EXISTS
如果该模式不存在则不要抛出错误，而是发出提示。
name
一个模式的名称。
CASCADE
自动删除包含在该模式中的对象（表、函数等），并删除所有
依赖于这些对象的对象（见第 5.15 节）。
RESTRICT
如果该模式含有任何对象，则拒绝删除它。这是默认值。
注释
使用CASCADE选项可能会使这条命令移除除
指定模式之外的其他模式中的对象。
示例
要从数据库中移除模式mystuff及其中
所包含的对象：
DROP SCHEMA mystuff CASCADE;
兼容性
DROP SCHEMA完全符合 SQL 标准，
不过该标准只允许在每个命令中删除一个模式，并且除了
IF EXISTS选项，该选项是一个
PostgreSQL扩展。
另见ALTER SCHEMA, CREATE SCHEMA上一页 上一级 下一页DROP RULE 起始页 DROP SEQUENCE
