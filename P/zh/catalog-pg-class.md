# 52.11. pg_class

52.11. pg_class
版本：
纠错本页面
搜索
目录导航
❮
❯
52.11. pg_class #
目录pg_class描述了具有列或与表类似的其他对象。这包括索引（但请参见pg_index）、序列（但请参见pg_sequence）、视图、物化视图、复合类型和TOAST表；请参见relkind。
在下面，当我们指的是所有这些类型的对象时，我们称之为“关系”。并非所有pg_class的列对所有关系类型都有意义。
表 52.11. pg_class Columns
列类型
描述
oid oid
行标识符
relname name
表、索引、视图等的名称
relnamespace oid
(references pg_namespace.oid)
包含该关系的命名空间的OID
reltype oid
(references pg_type.oid)
可能存在的表行类型所对应数据类型的OID；对索引、序列和toast表为0，这些没有pg_type项
reloftype oid
(references pg_type.oid)
对于有类型的表，为底层组合类型的OID；对于其他所有关系为0
relowner oid
(references pg_authid.oid)
关系的拥有者
relam oid
(引用自 pg_am.oid)
用于访问此表或索引的访问方法。如果关系是序列或没有磁盘文件，
则无意义，除非是分区表，在这种情况下，如果设置了该值，
它在确定分区的访问方法时优先于default_table_access_method，
当创建命令中未指定访问方法时，使用该值。
relfilenode oid
该关系的磁盘文件的名字，0表示这是一个“映射”关系，其磁盘文件名取决于低层状态
reltablespace oid
(引用自 pg_tablespace.oid)
存储此关系的表空间。
如果为零，则暗示使用数据库的默认表空间。
如果关系没有磁盘文件，则没有意义，
除了分区表，其中这是在创建命令中未指定时将创建分区的表空间。
relpages int4
该表磁盘表示的尺寸，以页面计（页面尺寸为BLCKSZ）。这只是一个由规划器使用的估计值。
它被VACUUM、ANALYZE以及一些DDL命令（如CREATE INDEX）所更新。
reltuples float4
表中的存活行数。这只是一个由规划器使用的估计值。
它被VACUUM、ANALYZE以及一些DDL命令（如CREATE INDEX）所更新。
如果该表从未被清理或分析，包含-1的reltuples表示行数是未知的。
relallvisible int4
在表的可见性映射表中被标记为全可见的页数。这只是一个由规划器使用的估计值。
它被VACUUM、ANALYZE以及一些DDL命令，如CREATE INDEX所更新。
relallfrozen int4
在表的可见性映射中被标记为全冻结的页面数。这只是用于触发自动清理的估计值。
也可与 relallvisible 配合使用，用于安排手动
清理和调整vacuum 的冻结行为。
由 VACUUM、
ANALYZE
以及少数 DDL 命令（如
CREATE INDEX）更新。
reltoastrelid oid
(引用自 pg_class.oid)
与该表相关联的TOAST表的OID，如果没有则为零。TOAST表将大属性“线外”存储在一个二级表中。
relhasindex bool
如果这是一个表并且其上建有（或最近建有）任何索引则为真
relisshared bool
如果该表在集簇中的所有数据库间共享则为真。只有某些系统目录（如pg_database）是共享的。
relpersistence char
p = 永久表/序列, u = 无日志表/序列,
t = 临时表/序列
relkind char
r = 普通表,
i = 索引,
S = 序列,
t = TOAST表,
v = 视图,
m = 物化视图,
c = 组合类型,
f = 外部表,
p = 分区表,
I = 分区索引
relnatts int2
关系中用户列的数目（系统列不计算在内）。在pg_attribute中必须有这么多对应的项。
另请参阅pg_attribute.attnum。
relchecks int2
表上CHECK约束的数目，参见pg_constraint目录
relhasrules bool
如果表有（或曾有）规则则为真，参见pg_rewrite目录
relhastriggers bool
如果表有（或曾有）触发器则为真，参见
pg_trigger目录
relhassubclass bool
如果表或索引有（或曾经有过）任何继承子类或分区，则为真
relrowsecurity bool
如果表上启用了行级安全性，则为真，参见
pg_policy目录
relforcerowsecurity bool
如果行级安全性（启用时）也适用于表拥有者，则为真，参见
pg_policy目录
relispopulated bool
如果表已被填充，则为真（对于所有关系该列都为真，但对于某些物化视图却不是）
relreplident char
用来为行形成“replica identity”的列：
d = 默认（主键，如果存在），
n = 无，
f = 所有列，
i = 索引的indisreplident被设置（如果使用的索引已被删除，则与无相同）
relispartition bool
如果表或索引是一个分区，则为真
relrewrite oid
(references pg_class.oid)
对于在要求表重写的DDL操作期间被写入的新关系，这个域包含原始关系的OID；否则为零。
那种状态仅在内部可见，对于一个用户可见的关系，这个域应该从不包含不是零的值。
relfrozenxid xid
在此之前的所有事务ID在表中已经被替换为一个永久的（“冻结的”）事务ID。
这用于跟踪表是否需要被清理，以便阻止事务ID回卷或者允许pg_xact被收缩。
如果该关系不是一个表，则为0（InvalidTransactionId）。
relminmxid xid
在此之前的多事务ID在表中已经被替换为一个事务ID。这被用于跟踪表是否需要被清理，以阻止
多事务ID回卷或者允许pg_multixact被收缩。如果关系不是一个表则
为零（InvalidMultiXactId）。
relacl aclitem[]
访问权限；更多信息参见第 5.8 节
reloptions text[]
访问方法相关的选项，以“keyword=value”字符串形式
relpartbound pg_node_tree
如果表是一个分区（见relispartition），
分区边界的内部表示
pg_class中的一些布尔标志以懒惰的方式维护：在正确状态时它们被保证为真，但是当条件不再为真时它们并不会被立刻重置为假。
例如，relhasindex由CREATE INDEX设置，但它从不会被DROP INDEX清除。
作为替代，VACUUM会在找到无索引表后清除其relhasindex。
这种安排避免了竞争条件并且提高了并发性。
上一页 上一级 下一页52.10. pg_cast 起始页 52.12. pg_collation
