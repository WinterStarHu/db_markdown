# 44.2. 数据值

44.2. 数据值
版本：
纠错本页面
搜索
目录导航
❮
❯
44.2. 数据值 #44.2.1. 数据类型映射44.2.2. Null, None44.2.3. 数组、列表44.2.4. 复合类型44.2.5. 集合返回函数
一般来讲，PL/Python 的目标是提供在 PostgreSQL 和 Python 世界之间的一种“自然的”映射。这包括下面介绍的数据映射规则。
44.2.1. 数据类型映射 #
当调用PL/Python函数时，其参数将从其PostgreSQL数据类型转换为相应的Python类型：
PostgreSQL boolean 被转换为 Python bool。
PostgreSQL smallint、int、bigint
和 oid 被转换为 Python int。
PostgreSQL real 和 double 被转换为
Python float。
PostgreSQL numeric 被转换为
Python Decimal。如果可用，此类型将从
cdecimal 包中导入。
否则，
将使用标准库中的 decimal.Decimal。在性能上，
cdecimal 明显快于 decimal。
然而，在Python 3.3及更高版本中，
cdecimal 已经整合到标准库中，以 decimal 的名称存在，
因此不再有任何区别。
PostgreSQL bytea 被转换为 Python bytes。
所有其他数据类型，包括PostgreSQL字符串类型，
都被转换为 Python str（与所有Python字符串一样，都是Unicode）。
对于非标量数据类型，请参见下文。
当PL/Python函数返回时，其返回值将根据以下方式转换为函数声明的PostgreSQL返回数据类型：
当PostgreSQL返回类型为boolean时，返回值将根据Python规则进行真值评估。
即，0和空字符串为假，但值为'f'为真。
当PostgreSQL返回类型为bytea时，返回值将使用相应的Python内置函数转换为Python bytes，
然后将结果转换为bytea。
对于所有其他PostgreSQL返回类型，返回值将使用Python内置函数str转换为字符串，
然后将结果传递给PostgreSQL数据类型的输入函数。
（如果Python值为float，则使用repr内置函数进行转换，而不是str，
以避免精度丢失。）
当字符串传递给PostgreSQL时，会自动转换为PostgreSQL服务器编码。
对于非标量数据类型，请参见下文。
请注意，声明的PostgreSQL返回类型与实际返回对象的Python数据类型之间的逻辑不匹配不会被标记；
无论如何，值都将被转换。
44.2.2. Null, None #
如果在PL/Python中传递了一个SQL空值给一个函数，参数值将在Python中显示为None。
例如，pymax函数的定义如第 44.1 节中所示，对于空输入将返回错误的答案。
我们可以在函数定义中添加STRICT，让PostgreSQL做一些更合理的事情：
如果传递了空值，函数将根本不会被调用，而只会自动返回一个空结果。另外，我们可以在函数体中检查空输入：
CREATE FUNCTION pymax (a integer, b integer)
RETURNS integer
AS $$
if (a is None) or (b is None):
return None
if a > b:
return a
return b
$$ LANGUAGE plpython3u;
如上所示，要从PL/Python函数中返回一个SQL空值，返回值为None。无论函数是否严格，都可以这样做。
44.2.3. 数组、列表 #
SQL数组值作为Python列表传入PL/Python。要从PL/Python函数中返回SQL数组值，
返回一个Python列表：
CREATE FUNCTION return_arr()
RETURNS int[]
AS $$
return [1, 2, 3, 4, 5]
$$ LANGUAGE plpython3u;
SELECT return_arr();
return_arr
-------------
{1,2,3,4,5}
(1 row)
多维数组作为嵌套的Python列表传入PL/Python。例如，2维数组是一个列表的列表。
当从PL/Python函数中返回多维SQL数组时，每个级别的内部列表必须大小相同。例如：
CREATE FUNCTION test_type_conversion_array_int4(x int4[]) RETURNS int4[] AS $$
plpy.info(x, type(x))
return x
$$ LANGUAGE plpython3u;
SELECT * FROM test_type_conversion_array_int4(ARRAY[[1,2,3],[4,5,6]]);
INFO:  ([[1, 2, 3], [4, 5, 6]], <type 'list'>)
test_type_conversion_array_int4
---------------------------------
{{1,2,3},{4,5,6}}
(1 row)
其他Python序列，如元组，在与PostgreSQL版本9.6及以下版本向后兼容时也被接受，
当时不支持多维数组。然而，它们始终被视为一维数组，因为它们与复合类型模糊不清。
出于同样的原因，当复合类型在多维数组中使用时，必须用元组表示，而不是列表。
请注意，在Python中，字符串是序列，可能会产生一些不良影响，这可能对Python程序员来说很熟悉：
CREATE FUNCTION return_str_arr()
RETURNS varchar[]
AS $$
return "hello"
$$ LANGUAGE plpython3u;
SELECT return_str_arr();
return_str_arr
----------------
{h,e,l,l,o}
(1 row)
44.2.4. 复合类型 #
复合类型参数作为Python映射传递给函数。映射的元素名称是复合类型的属性名称。
如果传递的行中的属性具有空值，则在映射中具有值None。这里是一个示例：
CREATE TABLE employee (
name text,
salary integer,
age integer
);
CREATE FUNCTION overpaid (e employee)
RETURNS boolean
AS $$
if e["salary"] > 200000:
return True
if (e["age"] < 30) and (e["salary"] > 100000):
return True
return False
$$ LANGUAGE plpython3u;
有多种方法可以从Python函数返回行或复合类型。以下示例假设我们有：
CREATE TYPE named_value AS (
name   text,
value  integer
);
复合结果可以作为以下之一返回：
序列类型（元组或列表，但不是集合，因为它不可索引）
返回的序列对象必须具有与复合结果类型字段相同数量的项。索引为0的项分配给复合类型的第一个字段，1分配给第二个字段，依此类推。例如：
CREATE FUNCTION make_pair (name text, value integer)
RETURNS named_value
AS $$
return ( name, value )
# 或者作为列表返回：return [ name, value ]
$$ LANGUAGE plpython3u;
要为任何列返回SQL空值，请在相应位置插入None。
当返回复合类型的数组时，不能将其作为列表返回，因为Python列表表示复合类型还是另一个数组维度是模棱两可的。
映射（字典）
每个结果类型列的值从具有列名作为键的映射中检索。例如：
CREATE FUNCTION make_pair (name text, value integer)
RETURNS named_value
AS $$
return { "name": name, "value": value }
$$ LANGUAGE plpython3u;
任何额外的字典键/值对都将被忽略。缺少的键将被视为错误。
要为任何列返回SQL空值，请使用相应的列名作为键插入None。
对象（提供方法__getattr__的任何对象）
这与映射相同。例如：
CREATE FUNCTION make_pair (name text, value integer)
RETURNS named_value
AS $$
class named_value:
def __init__ (self, n, v):
self.name = n
self.value = v
return named_value(name, value)
# or simply
class nv: pass
nv.name = name
nv.value = value
return nv
$$ LANGUAGE plpython3u;
支持带OUT参数的函数。例如：
CREATE FUNCTION multiout_simple(OUT i integer, OUT j integer) AS $$
return (1, 2)
$$ LANGUAGE plpython3u;
SELECT * FROM multiout_simple();
过程的输出参数以相同的方式传回。例如:
CREATE PROCEDURE python_triple(INOUT a integer, INOUT b integer) AS $$
return (a * 3, b * 3)
$$ LANGUAGE plpython3u;
CALL python_triple(5, 10);
44.2.5. 集合返回函数 #
一个PL/Python函数也可以返回标量或复合类型的集合。
有几种方法可以实现这一点，因为返回的对象在内部会被转换为一个迭代器。
以下示例假设我们有一个复合类型：
CREATE TYPE greeting AS (
how text,
who text
);
可以通过以下方式返回集合结果：
序列类型（元组、列表、集合）
CREATE FUNCTION greet (how text)
RETURNS SETOF greeting
AS $$
# 返回包含列表的元组作为复合类型
# 所有其他组合也可以工作
return ( [ how, "World" ], [ how, "PostgreSQL" ], [ how, "PL/Python" ] )
$$ LANGUAGE plpython3u;
迭代器（任何提供__iter__和
__next__方法的对象）
CREATE FUNCTION greet (how text)
RETURNS SETOF greeting
AS $$
class producer:
def __init__ (self, how, who):
self.how = how
self.who = who
self.ndx = -1
def __iter__ (self):
return self
def __next__(self):
self.ndx += 1
if self.ndx == len(self.who):
raise StopIteration
return ( self.how, self.who[self.ndx] )
return producer(how, [ "World", "PostgreSQL", "PL/Python" ])
$$ LANGUAGE plpython3u;
生成器（yield）
CREATE FUNCTION greet (how text)
RETURNS SETOF greeting
AS $$
for who in [ "World", "PostgreSQL", "PL/Python" ]:
yield ( how, who )
$$ LANGUAGE plpython3u;
支持带OUT参数的返回集函数（使用RETURNS SETOF record）。
例如：
CREATE FUNCTION multiout_simple_setof(n integer, OUT integer, OUT integer) RETURNS SETOF record AS $$
return [(1, 2)] * n
$$ LANGUAGE plpython3u;
SELECT * FROM multiout_simple_setof(3);
上一页 上一级 下一页44.1. PL/Python 函数 起始页 44.3. 共享数据
