# 52.13. pg_constraint

52.13. pg_constraint
版本：
纠错本页面
搜索
目录导航
❮
❯
52.13. pg_constraint #
系统目录 pg_constraint 存储表上的检查约束、非空约束、
主键约束、唯一约束、外键约束和排除约束。（列约束没有特殊处理。每个列约束
都等价于某个表约束。）
用户定义的约束触发器（使用CREATE CONSTRAINT TRIGGER创建）也会在这个表中产生一项。
域上的检查约束也存储在这里。
表 52.13. pg_constraint Columns
列类型
描述
oid oid
行标识符
conname name
约束名称（不一定唯一！）
connamespace oid
(references pg_namespace.oid)
包含此约束的命名空间的OID
contype char
c = 检查约束，
f = 外键约束，
n = 非空约束，
p = 主键约束，
u = 唯一约束，
t = 约束触发器，
x = 排除约束
condeferrable bool
该约束是否可延迟？
condeferred bool
该约束是否默认被延迟？
conenforced bool
该约束是否被强制执行？
convalidated bool
该约束是否已通过验证？
conrelid oid
(references pg_class.oid)
该约束所在的表，如果不是表约束则为零
contypid oid
(references pg_type.oid)
该约束所在的域，如果不是域约束则为零
conindid oid
(references pg_class.oid)
如果该约束是唯一、主键、外键或排除约束，此列表示支持该约束的索引，否则为零
conparentid oid
(references pg_constraint.oid)
如果这是一个分区中的约束，则是父分区表中对应的约束；否则为零
confrelid oid
(references pg_class.oid)
如果此约束是一个外键，此列为被引用的表，否则为零
confupdtype char
外键更新动作代码：
a = 无动作，
r = 限制，
c = 级联，
n = 置空，
d = 置为默认值
confdeltype char
外键删除动作代码：
a = 无动作，
r = 限制，
c = 级联，
n = 置空，
d = 置为默认值
confmatchtype char
外键匹配类型：
f = 完全，
p = 部分，
s = 简单
conislocal bool
此约束是定义在关系本地。注意一个约束可以同时是本地定义和继承。
coninhcount int2
此约束具有的直接继承祖先的数量。
一个具有非零祖先数量的约束不能被删除或重命名。
connoinherit bool
为真表示此约束被定义在关系本地。它是一个不可继承的约束。
conperiod bool
该约束使用 WITHOUT OVERLAPS（用于主键和唯一约束）
或 PERIOD（用于外键）定义。
conkey int2[]
(references pg_attribute.attnum)
如果是一个表约束（包括外键，但不包括约束触发器），此列是被约束列的列表
confkey int2[]
(references pg_attribute.attnum)
如果是一个外键，此列是被引用列的列表
conpfeqop oid[]
(references pg_operator.oid)
如果是一个外键，此列是用于PK = FK比较的等值操作符的列表
conppeqop oid[]
(references pg_operator.oid)
如果是一个外键，此列是用于PK = PK比较的等值操作符的列表
conffeqop oid[]
(references pg_operator.oid)
如果是一个外键，此列是用于FK = FK比较的等值操作符的列表
confdelsetcols int2[]
(references pg_attribute.attnum)
如果外键具有SET NULL或SET
DEFAULT删除操作，则将更新的列。
如果为空，则将更新所有引用列。
conexclop oid[]
(references pg_operator.oid)
若为排除约束或 WITHOUT OVERLAPS 主键/唯一约束，
则为每列排除操作符的列表。
conbin pg_node_tree
如果是一个检查约束，此列是表达式的一个内部表示。建议使用 pg_get_constraintdef() 来提取检查约束的定义。
在一个排他约束的情况下， conkey 只对约束元素是单一列引用时有用。
对于其他情况，conkey 为0且必须查阅相关索引来发现被约束的表达式。
（对于索引，conkey 因此和pg_index.indkey 具有相同的内容。）
注意
pg_class.relchecks 需要和每个关系在此目录中的检查约束数量保持一致。
上一页 上一级 下一页52.12. pg_collation 起始页 52.14. pg_conversion
