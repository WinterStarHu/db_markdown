# DROP INDEX

DROP INDEX
版本：
纠错本页面
搜索
目录导航
❮
❯
DROP INDEXDROP INDEX — 移除索引大纲
DROP INDEX [ CONCURRENTLY ] [ IF EXISTS ] name [, ...] [ CASCADE | RESTRICT ]
描述
DROP INDEX从数据库系统中
移除一个已有的索引。要执行这个命令，你必须是该索引的拥
有者。
参数CONCURRENTLY
删除索引并且不阻塞在索引基表上的并发选择、插入、更新和删除操作。一个
普通的DROP INDEX会要求该表上的排他锁，这样会阻塞
其他访问直至索引删除完成。通过这个选项，该命令会等待直至冲突事务完成。
在使用这个选项时有一些需要注意的事项。只能指定一个索引名称，并且不支
持CASCADE选项（因此，一个支持UNIQUE或者
PRIMARY KEY约束的索引不能以这种方式删除）。还有，常规
的DROP INDEX命令可以在一个事务块内执行，而
DROP INDEX CONCURRENTLY不能。
最后，不能使用此选项删除分区表上的索引。
对于临时表，DROP INDEX始终是非并发的，因为没有其他会话可以访问它们，而且非并发的索引删除代价更小。
IF EXISTS
如果该索引不存在则不要抛出错误，而是发出一个通知。
name
要移除的索引名称（可以是模式限定的）。
CASCADE
自动删除依赖于该索引的对象，然后删除所有
依赖于那些对象的对象（见第 5.15 节）。
RESTRICT
如果有任何对象依赖于该索引，则拒绝删除它。这是默认值。
示例
这个命令将移除索引title_idx：
DROP INDEX title_idx;
兼容性
DROP INDEX是一个
PostgreSQL语言扩展。在
SQL标准中没有提供索引。
另请参阅CREATE INDEX上一页 上一级 下一页DROP GROUP 起始页 DROP LANGUAGE
