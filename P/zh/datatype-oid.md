# 8.19. 对象标识符类型

8.19. 对象标识符类型
版本：
纠错本页面
搜索
目录导航
❮
❯
8.19. 对象标识符类型 #
对象标识符（OID）被PostgreSQL用来在内部作为多个系统表的主键。
类型oid表示一个对象标识符。
也有多个oid的别名类型分别被命名为regsomething。
表 8.26显示了一个概览。
oid类型目前被实现为一个无符号4字节整数。
因此，在大型数据库中它并不足以提供数据库范围内的唯一性，甚至在一些大型的表中也无法提供表范围内的唯一性。
oid类型本身除了比较之外只有很少的操作。不过，它可以被转换成整数，并且接着可以使用标准的整数操作符进行操纵（这样做时要注意有符号和无符号之间可能出现的混乱）。
OID的别名类型除了特定的输入和输出例程之外没有别的操作。这些例程可以接受并显示系统对象的符号名，而不是类型oid使用的原始数字值。别名类型使查找对象的OID值变得简单。例如，要检查与一个表mytable有关的pg_attribute行，你可以写：
SELECT * FROM pg_attribute WHERE attrelid = 'mytable'::regclass;
而不是：
SELECT * FROM pg_attribute
WHERE attrelid = (SELECT oid FROM pg_class WHERE relname = 'mytable');
虽然从它本身看起来并没有那么糟，它仍然被过度简化了。如果有多个名为mytable的表存在于不同的模式中，就可能需要一个更复杂的子选择来选择正确的OID。regclass输入转换器会根据模式路径设置处理表查找，并且因此它会自动地完成这种“正确的事情”。类似地，对于一个数字OID的符号化显示可以很方便地通过将表OID转换成regclass来实现。
表 8.26. 对象标识符类型名字引用描述值示例oid任意数字对象标识符564182regclasspg_class关系名称pg_typeregcollationpg_collation排序规则名称"POSIX"regconfigpg_ts_config文本搜索配置englishregdictionarypg_ts_dict文本搜索字典simpleregnamespacepg_namespace命名空间名称pg_catalogregoperpg_operator操作符名称+regoperatorpg_operator带参数类型的操作符*(integer,​integer)
or -(NONE,​integer)regprocpg_proc函数名称sumregprocedurepg_proc带参数类型的函数sum(int4)regrolepg_authid角色名称smitheeregtypepg_type数据类型名称integer
按命名空间分组的对象的所有OID别名类型都接受模式限定名称，如果在当前搜索路径中找不到未经限定的对象，则将在输出中显示模式限定名称。例如，myschema.mytable是regclass的可接受输入（如果存在这样的表）。该值可能输出为myschema.mytable，或仅为mytable，具体取决于当前搜索路径。regproc和regoper别名类型将只接受唯一（未重载）的输入名称，因此它们的用途有限；对于大多数用途，regprocedure或regoperator更合适。对于regoperator，通过为未使用的操作数写入NONE来标识一元操作符。
这些类型的输入函数允许标记之间使用空格，并将大写字母折叠为小写字母，双引号除外；这样做是为了使语法规则类似于在SQL中编写对象名的方式。相反，如果需要使输出成为有效的SQL标识符，输出函数将使用双引号。例如，一个名为Foo（大写F）且有两个整数参数的函数的OID可以输入为' "Foo" ( int, integer ) '::regprocedure。输出看起来像"Foo"(integer,integer)。函数名和参数类型名也可以是模式限定的。
许多内置的PostgreSQL函数接受表的OID或其他类型的数据库对象，为了方便起见，将其声明为采用regclass（或适当的OID别名类型）。这意味着你不必手动查找对象的OID，只需将其名称作为字符串文字输入即可。例如，nextval(regclass)函数接受序列关系的OID，因此你可以这样调用它：
nextval('foo')              按顺序操作foo
nextval('FOO')              同上
nextval('"Foo"')            按顺序操作Foo
nextval('myschema.foo')     操作于myschema.foo
nextval('"myschema".foo')   同上
nextval('foo')              查找搜索路径为foo
注意
当你将此类函数的参数编写为未经修饰的文字字符串时，它将成为regclass（或适当类型）类型的常量。
由于这实际上只是一个OID，因此它将跟踪最初标识的对象，哪怕他后来进行了重命名，模式重新分配等。这种 “早期绑定”行为通常适用于列默认值和视图中的对象引用。但有时你可能需要“后期绑定”在运行时解析对象引用。要获取后期绑定行为，请强制将常量存储为text常量，而不是regclass：
nextval('foo'::text)      foo运行时被查找
to_regclass()函数及其同级函数也可用于执行运行时查找。请参见 表 9.76。
使用regclass的另一个实际示例是查找information_schema视图中列出的表的OID，这些视图不直接提供此类OID。例如，你可能希望调用pg_relation_size()函数，这需要表OID。考虑到上述规则，正确的方法是：
SELECT table_schema, table_name,
pg_relation_size((quote_ident(table_schema) || '.' ||
quote_ident(table_name))::regclass)
FROM information_schema.tables
WHERE ...
quote_ident()函数将负责在需要时将标识符加上双引号。看起来更容易的
SELECT pg_relation_size(table_name)
FROM information_schema.tables
WHERE ...
是不建议使用的，因为对于搜索路径之外的表或名称需要引号的表，它将失败。
大多数OID别名类型的另一个特性是创建依赖项。如果这些类型中的一个常量出现在存储的表达式（如一个列的默认表达式或视图）中，它将创建对引用对象的依赖关系。例如，如果列具有默认表达式nextval('my_seq'::regclass)，PostgreSQL知道默认表达式取决于序列my_seq，因此系统只允许在首先删除默认表达式的情况下才能删除序列。nextval('my_seq'::text)的替代方法不会创建依赖项。（regrole是此属性的例外。存储表达式中不允许使用此类型的常量。）
系统使用的另一种标识符类型是xid，即事务
（缩写为xact）标识符。这是系统列
xmin和xmax的数据类型。
事务标识符是32位的数量。在某些情况下，会使用64位的变体
xid8。与xid值不同，xid8值严格
单调递增，并且在数据库集群的生命周期内不能被重用。
有关更多详细信息，请参见第 67.1 节。
系统使用的第三种标识符类型是cid，或者称为命令标识符。这是系统列cmin和cmax使用的数据类型。命令标识符也是32位量。
系统使用的最后一种标识符类型是tid，或者称为元组标识符（行标识符）。这是系统列ctid使用的数据类型。一个元组ID是一个（块号，块内元组索引）对，它标识了行在其表中的物理位置。
（这些系统列在第 5.6 节中有进一步的解释。）
上一页 上一级 下一页8.18. 域类型 起始页 8.20. pg_lsn 类型
