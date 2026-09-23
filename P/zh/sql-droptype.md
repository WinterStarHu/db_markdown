# DROP TYPE

DROP TYPE
版本：
纠错本页面
搜索
目录导航
❮
❯
DROP TYPEDROP TYPE — 移除数据类型大纲
DROP TYPE [ IF EXISTS ] name [, ...] [ CASCADE | RESTRICT ]
描述
DROP TYPE 移除用户定义的数据类型。
只有类型的拥有者才能移除它。
参数IF EXISTS
如果该类型不存在则不要抛出错误，而是发出提示。
name
要移除的数据类型的名称（可以是模式限定的）。
CASCADE
自动删除依赖于该类型的对象（例如表列、函数和操作符），然后删除所有
依赖于那些对象的对象（见第 5.15 节）。
RESTRICT
如果有任何对象依赖于该类型，则拒绝删除它。这是默认值。
示例
要移除数据类型box：
DROP TYPE box;
兼容性
这个命令类似于 SQL 标准中的对应命令，但IF EXISTS选项
是一个PostgreSQL扩展。但要注意
PostgreSQL中
CREATE TYPE命令的很大部分以及数据类型
扩展机制都与 SQL 标准不同。
另见ALTER TYPE, CREATE TYPE上一页 上一级 下一页DROP TRIGGER 起始页 DROP USER
