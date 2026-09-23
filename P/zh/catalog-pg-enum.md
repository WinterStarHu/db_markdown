# 52.20. pg_enum

52.20. pg_enum
版本：
纠错本页面
搜索
目录导航
❮
❯
52.20. pg_enum #
pg_enum目录包含每一个枚举类型的项，其中包括了值和标签。一个给定枚举值的内部表示实际上是它在pg_enum中的相关行的OID。
表 52.20. pg_enum 列
列类型
描述
oid oid
行标识符
enumtypid oid
(references pg_type.oid)
包含此枚举值的pg_type项的OID
enumsortorder float4
此枚举值在其枚举类型中的排序位置
enumlabel name
此枚举值的文本标签
pg_enum行的OID值遵循一种特殊的规则：即OID的数值被保证按照其枚举类型的排序顺序进行排序。即如果两个偶数OID属于同一枚举类型，较小的OID必然具有较小的enumsortorder值。奇数OID值不需要遵循排序顺序。这种规则使得枚举比较例程在很多常见情况下可以避免系统目录查找。创建和修改枚举类型的例程将尝试尽可能地为枚举值分配偶数OID。
当一个枚举类型被创建后，其成员会被分配排序位置1..n。但后面增加的成员可能会被分配负值或者分数值的enumsortorder。对于这些值的唯一要求是它们必须被正确地排序且唯一。
上一页 上一级 下一页52.19. pg_description 起始页 52.21. pg_event_trigger
