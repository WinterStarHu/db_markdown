# 52.64. pg_type

52.64. pg_type
版本：
纠错本页面
搜索
目录导航
❮
❯
52.64. pg_type #
目录pg_type存储有关数据类型的信息。
基本类型和枚举类型（标量类型）使用CREATE TYPE创建，而域使用CREATE DOMAIN创建。
数据库中的每一个表都会有一个自动创建的组合类型，用于表示表的行结构。
也可以使用CREATE TYPE AS创建组合类型。
表 52.64. pg_type 列
列类型
描述
oid oid
行标识符
typname name
数据类型名称
typnamespace oid
(references pg_namespace.oid)
包含此类型的命名空间的OID
typowner oid
(references pg_authid.oid)
类型的拥有者
typlen int2
对于一个固定尺寸的类型，typlen是该类型内部表示的字节数。
对于一个变长类型，typlen为负值。
-1表示一个“varlena”类型（具有长度字），-2表示一个以空字符结尾的C字符串。
typbyval bool
typbyval判断内部例程传递这个类型的数值时是通过传值还是传引用。
如果typlen不是1、2或4（或者在Datum为8字节的机器上为8），因此typbyval最好是假。
变长类型总是传引用。注意即使长度允许传值， typbyval也可以为假。
typtype char
typtype可以是：
b表示一个基类，
c表示一个组合类型（例如一个表的行类型），
d表示一个域，
e表示一个枚举类型，
p表示一个伪类型，
r表示一个范围类型，或
m表示一个多范围类型。
另请参阅typrelid和typbasetype。
typcategory char
typcategory是一种任意的数据类型分类，它被分析器用来决定哪种隐式转换“优先”。
参见表 52.65。
typispreferred bool
如果此类型在它的typcategory中是一个优先的转换目标，此列为真。
typisdefined bool
如果此类型已被定义则为真，如果此类型只是一个表示还未定义类型的占位符则为假。
当typisdefined为假，除了类型名称、命名空间和OID之外什么都不能被依赖。
typdelim char
在分析数组输入时，分隔两个此类型值的字符。注意该分隔符是与数组元素数据类型相关联的，而不是与数组的数据类型关联。
typrelid oid
(references pg_class.oid)
如果这是一个复合类型（见typtype），那么这个列指向pg_class中定义对应表的项
（对于自由存在的复合类型，pg_class项并不表示一个表，但不管怎样该类型的pg_attribute项需要链接到它）。
对非复合类型此列为零。
typsubscript regproc
(references pg_proc.oid)
下标处理函数的OID，如果该类型不支持下标则为零。
“true”数组类型的类型有typsubscript = array_subscript_handler，但是其他类型可能有其他的处理函数以实现特定的下标行为。
typelem oid
(references pg_type.oid)
如果typelem不为零，则它标识pg_type中的另一行，定义由下标产生的类型。如果typsubscript为零，则该项应为零。
但是，当typsubscript不为零时，它也可以为零，如果处理函数不需要typelem来决定下标结果类型。
注意typelem依赖被认为是表示该类型中的元素类型的物理包含；所以这个元素类型上的DDL变更可能会受到该类型存在的限制。
typarray oid
(references pg_type.oid)
如果typarray不为零，则它标识pg_type中的另一行，这一行是一个“true”数组类型，将此类型作为元素。
typinput regproc
(references pg_proc.oid)
输入转换函数（文本格式）
typoutput regproc
(references pg_proc.oid)
输出转换函数（文本格式）
typreceive regproc
(references pg_proc.oid)
输入转换函数（二进制格式），如果没有则为零
typsend regproc
(references pg_proc.oid)
输出转换函数（二进制格式），如果没有则为零
typmodin regproc
(references pg_proc.oid)
类型修改器输入函数，如果类型不支持修改器则为零
typmodout regproc
(参考 pg_proc.oid)
类型修改器输出函数，或为零以使用标准格式
typanalyze regproc
(参考 pg_proc.oid)
自定义ANALYZE函数，或为零以使用标准函数
typalign char
typalign是当存储此类型值时要求的对齐性质。
它应用于磁盘存储以及该值在 PostgreSQL内部的大多数表现形式。
如果数值是连续存放的，比如在磁盘上的一个完整行，在这种类型的数据前会插入填充，这样它就可以按照指定边界存储。
对齐引用是该序列中第一个数据的开头。
可能的值为：
c = char对齐，即不需要对齐。s = short对齐（在大部分机器上为2字节）。i = int对齐（在大部分机器上为4字节）。d = double对齐（在很多机器上为8字节，但绝不是全部）。
typstorage char
typstorage说明对于变长类型（typlen = -1），
该类型是否准备好进行TOAST，以及该类型属性的默认策略应是什么。
可能的值是：
p (普通的): 值必须始终以普通方式存储
(非varlena类型总是使用这个值)。
e (外部的): 值可以存储在一个次要 “TOAST” 关系中
(如果有一个关系, 参见pg_class.reltoastrelid)。
m (主要的): 值可以被压缩并内联存储。
x (扩展的): 值可以被压缩和/或移动到次要关系。
x是可进行TOAST的类型的常用选择。
注意m值也可以被移动到二级存储，但只能作为最后一种方案
（e和x值会先被移动）。
typnotnull bool
typnotnull表示类型上的一个非空约束。只用于域。
typbasetype oid
(参考 pg_type.oid)
如果这是一个域（见typtype），则typbasetype标识这个域基于的类型。如果此类型不是一个域则为0。
typtypmod int4
域使用typtypmod来记录被应用于它们基类型的typmod
（如果基类型不使用typmod，则为-1）。如果此类型不是一个域则为-1。
typndims int4
对于一个数组上的域，typndims是数组维度数（即，typbasetype是一个数组类型）。
除数组类型上的域之外的类型的此列为0。
typcollation oid
(references pg_collation.oid)
typcollation指定此类型的排序规则。如果类型不支持排序规则，此列为0。
一个支持排序规则的基类型此处会有一个非零值，典型值为DEFAULT_COLLATION_OID。
可排序类型上的域可以有一个不同于其基类型的排序规则OID，如果为该域指定了一个排序规则OID的话。
typdefaultbin pg_node_tree
如果typdefaultbin为非空，那么它是该类型默认表达式的nodeToString()表现形式。这个列只用于域。
typdefault text
如果某类型没有相关默认值，那么typdefault为空。如果typdefaultbin不为空，
typdefault必须包含一个typdefaultbin所指的默认表达式的人类可读的版本。
如果typdefaultbin为空但typdefault不为空，则typdefault是该类型默认值的外部表现形式，
它可以被交给该类型的输入转换器来产生一个常量。
typacl aclitem[]
访问权限；另请参阅第 5.8 节以获取详细信息
注意
对于系统表中使用的固定宽度类型，关键的是在pg_type定义的大小和对齐与编译器在表示表行的结构中布局列的方式一致。
表 52.65列出了typcategory的系统定义值。任何未来对此列表的增加都将是大写ASCII字母。所有其他ASCII字符都保留给用户定义的类别。
表 52.65. typcategory 代码编码类别A数组类型B布尔类型C复合类型D日期/时间类型E枚举类型G几何类型I网络地址类型N数值类型P伪类型R范围类型S字符串类型T时间跨度类型U用户定义类型V位字符串类型Xunknown typeZ内部使用类型上一页 上一级 下一页52.63. pg_ts_template 起始页 52.65. pg_user_mapping
