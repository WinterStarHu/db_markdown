# DROP EXTENSION

DROP EXTENSION
版本：
纠错本页面
搜索
目录导航
❮
❯
DROP EXTENSIONDROP EXTENSION — 移除扩展大纲
DROP EXTENSION [ IF EXISTS ] name [, ...] [ CASCADE | RESTRICT ]
描述
DROP EXTENSION 从数据库中移除扩展。
删除一个扩展会导致其成员对象，以及其他明确依赖的例程（参见ALTER ROUTINE，
依赖于扩展extension_name的操作）也会被删除。
你必须拥有扩展才能使用DROP EXTENSION。
参数IF EXISTS
如果该扩展不存在则不要抛出错误，而是发出提示。
name
一个已安装扩展的名称。
CASCADE
自动删除依赖于该扩展的对象，然后删除所有
依赖于那些对象的对象（见第 5.15 节）。
RESTRICT
此选项可防止指定的扩展被删除，即使其他对象（除了这些扩展、
它们的成员及其显式依赖的例程）依赖于它们。这是默认设置。
示例
要从当前数据库移除扩展hstore：
DROP EXTENSION hstore;
如果hstore的任何对象在该数据库中
正在使用，例如有一个表的列是hstore类型，这个
命令都将会失败。加上CASCADE选项可以强制
把这些依赖对象也移除。
兼容性
DROP EXTENSION是一个
PostgreSQL扩展。
其他参考CREATE EXTENSION, ALTER EXTENSION上一页 上一级 下一页DROP EVENT TRIGGER 起始页 DROP FOREIGN DATA WRAPPER
