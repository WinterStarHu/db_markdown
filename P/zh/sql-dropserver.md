# DROP SERVER

DROP SERVER
版本：
纠错本页面
搜索
目录导航
❮
❯
DROP SERVERDROP SERVER — 移除一个外部服务器描述符大纲
DROP SERVER [ IF EXISTS ] name [, ...] [ CASCADE | RESTRICT ]
描述
DROP SERVER 移除一个现有的外部服务器
描述符。要执行这个命令，当前用户必须是该服务器的拥有者。
参数IF EXISTS
如果该服务器不存在则不要抛出错误，而是发出一个提示。
name
一个现有服务器的名称。
CASCADE
自动删除依赖于该服务器的对象（例如用户映射），然后删除所有
依赖于那些对象的对象（见第 5.15 节）。
RESTRICT
如果有任何对象依赖于该服务器，则拒绝删除它。这是默认值。
示例
如果服务器foo存在，则删除它：
DROP SERVER IF EXISTS foo;
兼容性
DROP SERVER符合 ISO/IEC 9075-9
(SQL/MED)。IF EXISTS子句是一个
PostgreSQL扩展。
另见CREATE SERVER, ALTER SERVER上一页 上一级 下一页DROP SEQUENCE 起始页 DROP STATISTICS
