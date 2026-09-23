# 9.2. 比较函数和操作符

9.2. 比较函数和操作符
版本：
纠错本页面
搜索
目录导航
❮
❯
9.2. 比较函数和操作符 #
常见的比较操作符都可用，如表 9.1所示。
表 9.1. 比较操作符操作符描述
datatype < datatype
→ boolean
小于
datatype > datatype
→ boolean
大于
datatype <= datatype
→ boolean
小于等于
datatype >= datatype
→ boolean
大于等于
datatype = datatype
→ boolean
等于
datatype <> datatype
→ boolean
不等于
datatype != datatype
→ boolean
不等于注意
<> 是 “not equal” 的标准SQL符号。
!= 是一个别名，在解析的早期阶段被转换为 <>。
因此，它不可能实现 != 和 <> 操作符以做不同的事情。
这些比较操作符适用于所有具有自然排序的内置数据类型，包括数字、字符串和日期/时间类型。
此外，如果它们的组件数据类型具有可比性，则可以比较数组、复合类型和范围。
通常也可以比较相关数据类型的值；例如integer > bigint 将起作用。
这种情况的某些实例直接由“cross-type”比较操作符实现，但是，如果没有这种操作符，解析器将把不太通用的类型强制为更通用的类型，并应用后者的比较操作符。
如上所示，所有比较操作符都是二元操作符，返回boolean类型的值。
因此，类似1 < 2 < 3的表达式是无效的（因为没有<操作符与3进行布尔值比较）。
使用下面显示的BETWEEN谓词执行范围测试。
如表 9.2所示，也有一些比较谓词。它们的行为和操作符很像，但是具有SQL标准所要求的特殊语法。
表 9.2. 比较谓词
谓词
描述
示例
datatype BETWEEN datatype AND datatype
→ boolean
之间（包括范围端点）。
2 BETWEEN 1 AND 3
→ t
2 BETWEEN 3 AND 1
→ f
datatype NOT BETWEEN datatype AND datatype
→ boolean
不在之间（BETWEEN的否定）。
2 NOT BETWEEN 1 AND 3
→ f
datatype BETWEEN SYMMETRIC datatype AND datatype
→ boolean
之间，在对两个端点值排序之后。
2 BETWEEN SYMMETRIC 3 AND 1
→ t
datatype NOT BETWEEN SYMMETRIC datatype AND datatype
→ boolean
不在之间，在对两个端点值排序之后。
2 NOT BETWEEN SYMMETRIC 3 AND 1
→ f
datatype IS DISTINCT FROM datatype
→ boolean
不相等，将空(null)视为可比值。
1 IS DISTINCT FROM NULL
→ t (而不是 NULL)
NULL IS DISTINCT FROM NULL
→ f (而不是 NULL)
datatype IS NOT DISTINCT FROM datatype
→ boolean
相等，将空(null)视为可比值。
1 IS NOT DISTINCT FROM NULL
→ f (而不是 NULL)
NULL IS NOT DISTINCT FROM NULL
→ t (而不是 NULL)
datatype IS NULL
→ boolean
测试值是否为空。
1.5 IS NULL
→ f
datatype IS NOT NULL
→ boolean
测试值是否不为空。
'null' IS NOT NULL
→ t
datatype ISNULL
→ boolean
测试值是否为空（非标准语法）。
datatype NOTNULL
→ boolean
测试值是否不为空（非标准语法）。
boolean IS TRUE
→ boolean
测试布尔表达式是否为真。
true IS TRUE
→ t
NULL::boolean IS TRUE
→ f (而不是 NULL)
boolean IS NOT TRUE
→ boolean
测试布尔表达式是否为假或未知。
true IS NOT TRUE
→ f
NULL::boolean IS NOT TRUE
→ t (而不是 NULL)
boolean IS FALSE
→ boolean
测试布尔表达式是否为假。
true IS FALSE
→ f
NULL::boolean IS FALSE
→ f (而不是 NULL)
boolean IS NOT FALSE
→ boolean
测试布尔表达式是否为真或未知。
true IS NOT FALSE
→ t
NULL::boolean IS NOT FALSE
→ t (而不是 NULL)
boolean IS UNKNOWN
→ boolean
测试布尔表达式是否为未知。
true IS UNKNOWN
→ f
NULL::boolean IS UNKNOWN
→ t (而不是 NULL)
boolean IS NOT UNKNOWN
→ boolean
测试布尔表达式是否为真或假。
true IS NOT UNKNOWN
→ t
NULL::boolean IS NOT UNKNOWN
→ f (而不是 NULL)
BETWEEN谓词可以简化范围测试：
a BETWEEN x AND y
等效于
a >= x AND a <= y
注意BETWEEN认为终点值是包含在范围内的。
BETWEEN SYMMETRIC 就像BETWEEN，除了没有要求AND的左边的参数小于或等于右边的参数。
如果不是的话，这两个参数将自动交换，因此总是隐含一个非空范围。
BETWEEN的各种变量都是以普通比较操作符的方式实现的，因此适用于任何可以比较的数据类型。
注意
在BETWEEN语法中使用AND会与使用AND作为逻辑操作符产生歧义。
为了解决这个问题，只允许有限的一组表达类型作为BETWEEN子句的第二个参数。
如果您需要在BETWEEN中写一个更复杂的子表达式，在子表达式两边写上圆括号。
当有一个输入为空时，普通的比较操作符会得到空（表示“未知”），而不是真或假。例如，7 = NULL得到空，7 <> NULL也一样。如果这种行为不合适，可以使用IS [ NOT ] DISTINCT FROM谓词：
a IS DISTINCT FROM b
a IS NOT DISTINCT FROM b
对于非空输入，IS DISTINCT FROM和<>操作符一样。不过，如果两个输入都为空，它会返回假。而如果只有一个输入为空，它会返回真。类似地，IS NOT DISTINCT FROM对于非空输入的行为与=相同，但是当两个输入都为空时它返回真，并且当只有一个输入为空时返回假。因此，这些谓词实际上把空值当作一种普通数据值而不是“unknown”。
要检查一个值是否为空，使用下面的谓词：
expression IS NULL
expression IS NOT NULL
或者等效，但并不标准的谓词：
expression ISNULL
expression NOTNULL
不要写expression = NULL，因为NULL是不“等于”NULL的。（空值表示一个未知的值，因此我们无法知道两个未知的值是否相等。）
提示
有些应用可能要求表达式expression = NULL在expression得出空值时返回真。我们强烈建议这样的应用修改成遵循 SQL 标准。但是，如果这样修改不可能完成，那么我们可以使用配置变量transform_null_equals。如果打开它，PostgreSQL将把x = NULL子句转换成x IS NULL。
如果expression是行值，那么当行表达式本身为null或所有行的字段均为null时，
IS NULL为真，而当行表达式本身非null且所有行的字段均非null时，
IS NOT NULL为真。由于这种行为，IS NULL和
IS NOT NULL对于行值表达式不总是返回相反的结果；特别是，包含null和非null字段的
行值表达式对这两个测试都会返回假。例如：
SELECT ROW(1,2.5,'this is a test') = ROW(1, 3, 'not the same');
SELECT ROW(table.*) IS NULL FROM table;  -- 检测全为null的行
SELECT ROW(table.*) IS NOT NULL FROM table;  -- 检测全非null的行
SELECT NOT(ROW(table.*) IS NOT NULL) FROM TABLE; -- 检测行中至少有一个null
在某些情况下，可能更倾向于写row IS DISTINCT FROM NULL
或row IS NOT DISTINCT FROM NULL，这将仅检查整体行值是否为null，
而不对行字段进行任何额外测试。
布尔值也可以使用下列谓词进行测试：
boolean_expression IS TRUE
boolean_expression IS NOT TRUE
boolean_expression IS FALSE
boolean_expression IS NOT FALSE
boolean_expression IS UNKNOWN
boolean_expression IS NOT UNKNOWN
这些谓词将总是返回真或假，从来不返回空值，即使操作数是空也如此。空值输入被当做逻辑值“未知”。 请注意实际上IS UNKNOWN和IS NOT UNKNOWN分别与IS NULL和IS NOT NULL相同， 只是输入表达式必须是布尔类型。
如表 9.3中所示，也有一些比较相关的函数可用。
表 9.3. 比较函数
函数
描述
示例
num_nonnulls ( VARIADIC "any" )
→ integer
返回非空参数的数量。
num_nonnulls(1, NULL, 2)
→ 2
num_nulls ( VARIADIC "any" )
→ integer
返回空参数的数量。
num_nulls(1, NULL, 2)
→ 1
上一页 上一级 下一页9.1. 逻辑操作符 起始页 9.3. 数学函数和运算符
