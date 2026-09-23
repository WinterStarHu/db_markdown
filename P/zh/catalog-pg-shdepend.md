# 52.48. pg_shdepend

52.48. pg_shdepend
版本：
纠错本页面
搜索
目录导航
❮
❯
52.48. pg_shdepend #
目录pg_shdepend记录数据库对象和共享对象之间的依赖关系，例如角色。这些信息使得PostgreSQL可以确保对象在被删除时没有被其他对象引用。
另请参阅pg_depend，它对单个数据库中对象之间的依赖提供了相似的功能。
与大部分其他系统目录不同，pg_shdepend在整个集簇的所有数据库之间共享：在每个集簇中只有一个pg_shdepend的拷贝，而不是每个数据库一份。
表 52.48. pg_shdepend 列
列类型
描述
dbid oid
(references pg_database.oid)
依赖对象所在数据库的OID，或者对于共享对象为零
classid oid
(references pg_class.oid)
依赖对象所在系统目录的OID
objid oid
(references any OID column)
特定依赖对象的OID
objsubid int4
对于一个表列，这将是列号（objid和classid指向表本身）。对于所有其他对象类型，该列值为零。
refclassid oid
(references pg_class.oid)
被引用对象所在的系统目录的OID（必须是一个共享的目录）
refobjid oid
(references any OID column)
指定被引用对象的OID
deptype char
定义此依赖关系语义的一个代码；见文本
在所有情况下，pg_shdepend 条目表明，
在不删除依赖对象的情况下无法删除被引用对象。但有几种由
deptype 标识的子类型：
SHARED_DEPENDENCY_OWNER (o)
被引用对象（必须是角色）是依赖对象的所有者。
SHARED_DEPENDENCY_ACL (a)
被引用对象（必须是角色）出现在依赖对象的 ACL 中。
（对象所有者不会有 SHARED_DEPENDENCY_ACL 条目，
因为所有者已有 SHARED_DEPENDENCY_OWNER 条目。）
SHARED_DEPENDENCY_INITACL (i)
被引用对象（必须是角色）出现在依赖对象的
pg_init_privs
条目中。
SHARED_DEPENDENCY_POLICY (r)
被引用对象（必须是角色）被作为依赖策略对象的目标提及。
SHARED_DEPENDENCY_TABLESPACE (t)
被引用对象（必须是表空间）被作为无存储关系的表空间提及。
未来可能需要其他依赖类型。特别注意，当前定义仅支持角色和表空间作为被引用对象。
与pg_depend目录中一样，在initdb期间创建的大多数对象被视为“固定（pinned）”。
在pg_shdepend中不会有任何条目，这些条目将使一个被固定（pinned）的对象成为被引用或依赖的对象。
上一页 上一级 下一页52.47. pg_sequence 起始页 52.49. pg_shdescription
