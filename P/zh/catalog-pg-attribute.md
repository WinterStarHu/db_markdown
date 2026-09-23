# 52.7. pg_attribute

52.7. pg_attribute
版本：
纠错本页面
搜索
目录导航
❮
❯
52.7. pg_attribute #
目录pg_attribute存储有关表列的信息。数据库中的每一个表的每一个列都恰好在pg_attribute中有一行。
（这其中也会有索引的属性项，并且事实上所有对象都具有pg_class项。）
术语属性等同于列，这里使用它只是出于历史原因。
表 52.7. pg_attribute 列
列类型
描述
attrelid oid
(references pg_class.oid)
此列所属的表
attname name
列名称
atttypid oid
(references pg_type.oid)
此列的数据类型（删除的列为零）
attlen int2
本列类型的pg_type.typlen一个拷贝
attnum int2
列的编号。普通列从1开始向上编号。系统列，如ctid，则拥有（任意）负值编号。
atttypmod int4
atttypmod记录了在表创建时提供的类型相关数据（例如一个varchar列的最大长度）。
它会被传递给类型相关的输入函数和长度强制函数。对于那些不需要atttypmod的类型，这个值通常为-1。
attndims int2
如果列是数组类型，则表示维度数量；否则为0。
（目前，数组的维度数量没有强制要求，因此任何非零值实际上都意味着“这是一个数组”。）
attbyval bool
该列类型的pg_type.typbyval的一个拷贝
attalign char
该列类型的pg_type.typalign的一个拷贝
attstorage char
通常是该列类型的pg_type.typstorage的一个拷贝。
对于可TOAST的数据类型，这可以在列创建后被修改以控制存储策略。
attcompression char
该列当前的压缩方法。通常为'\0'以指定使用当前默认设置（参见 default_toast_compression）。
否则，'p'选择pglz压缩，而'l'选择LZ4压缩。
但是，当attstorage不允许压缩时，该字段将被忽略。
attnotnull bool
该列具有（可能无效的）非空约束。
atthasdef bool
该列有一个默认表达式或生成表达式，在此情况下在pg_attrdef目录中会有一个对应项来真正定义该表达式。
（检查attgenerated以确定这是默认还是生成表达式。）
atthasmissing bool
该列在行中完全缺失时会用到这个列的值，如果在行创建之后增加一个有非易失DEFAULT值的列，就会发生这种情况。
实际使用的值被存放在attmissingval列中。
attidentity char
如果是一个零字节（''），则不是一个标识列。
否则，a = 总是生成，d = 默认生成。
attgenerated char
如果是零字节（''），则不是生成列。
否则，s = 存储型，v = 虚拟型。
存储型生成列像普通列一样物理存储；虚拟型生成列物理上存储为空值，
实际值在运行时计算。
attisdropped bool
该列被删除且不再有效。一个删除的列仍然物理存在于表中，但是会被分析器忽略并因此无法通过SQL访问。
attislocal bool
该列是由关系本地定义的。注意一个列可以同时是本地定义和继承的。
attinhcount int2
此列具有的直接祖先数量。具有非零祖先数量的列不能被删除或重命名。
attcollation oid
(references pg_collation.oid)
该列的定义排序规则，如果该列不是一个可排序数据类型则为0。
attstattarget int2
attstattarget 控制该列由
ANALYZE
累积的统计信息的详细程度。零值表示不应收集统计信息。
空值表示使用系统默认的统计目标。正值的具体含义取决于数据类型。
对于标量数据类型，attstattarget 是
要收集的“最常见值”的目标数量，也是要创建的直方图区间数的目标。
attacl aclitem[]
列级访问权限，如果此列上已有特别授予的权限
attoptions text[]
属性级选项，以“keyword=value”形式的字符串
attfdwoptions text[]
属性级的外部数据包装器选项，以“keyword=value”形式的字符串
attmissingval anyarray
这个列中是一个含有一个元素的数组，其中的值被用于该列在行中完全缺失时，如果在行创建之后增加一个有非易失DEFAULT值的列，就会发生这种情况。
只有当atthasmissing为真时才使用这个值。如果没有值则该列为null。
在一个被删除的列的pg_attribute的项中，atttypid被重置为0，但attlen以及其他从pg_type拷贝的域仍然有效。
这种安排用于处理一种情况，即被删除列的数据类型后来被删除，并且因此不再有相应的pg_type行。
attlen和其他域可以被用来解释表的一行的内容。
上一页 上一级 下一页52.6. pg_attrdef 起始页 52.8. pg_authid
