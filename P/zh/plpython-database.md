# 44.6. 数据库访问

44.6. 数据库访问
版本：
纠错本页面
搜索
目录导航
❮
❯
44.6. 数据库访问 #44.6.1. 数据库访问函数44.6.2. 捕捉错误
PL/Python 语言模块会自动导入一个被称为plpy的 Python 模块。这个模块中的函数和常量在 Python 代码中可以用plpy.foo这样的方式访问。
44.6.1. 数据库访问函数 #
plpy模块提供了几个函数来执行数据库命令：
plpy.execute(query [, limit])
用一个查询字符串和一个可选的行限制参数调用plpy.execute会让该查询运行并且其结果会被以一个结果对象返回。
如果指定了limit并且大于零，则plpy.execute检索最多limit行，就像查询包含LIMIT子句一样。省略limit或将其指定为零将导致没有行限制。
结果对象模拟一个列表或者字典对象。可以用行号和列名来访问结果对象。例如：
rv = plpy.execute("SELECT * FROM my_table", 5)
会从my_table中返回 5 行。如果my_table有一列是my_column，可以这样来访问它：
foo = rv[i]["my_column"]
可以用内建的len函数获得返回的行数。
结果对象有这些额外的方法：
nrows()
返回被该命令处理的行数。注意这不一定与返回的行数相同。例如，UPDATE命令将会设置这个值但是不返回任何行（除非使用RETURNING）。
status()
SPI_execute()的返回值。
colnames()coltypes()coltypmods()
分别返回一个列名列表、列类型 OID 列表以及列的类型相关的类型修饰符列表。
在来自于不产生结果集合的命令的结果对象上调用这些方法会产生异常，例如不带RETURNING的UPDATE或者DROP TABLE。但是在包含的行数为零的结果集合上使用这些方法是可以的。
__str__()
也定义了标准的__str__方法，例如可以使用plpy.debug(rv)来调试查询执行结果。
结果对象可以被修改。
注意调用plpy.execute将会导致整个结果集被读入到内存中。只有当确信结果集相对比较小时才应使用这个函数。在获取大型结果时，如果不想冒着耗尽内存的风险，应使用plpy.cursor而不是plpy.execute。
plpy.prepare(query [, argtypes])plpy.execute(plan [, arguments [, limit]])
plpy.prepare为一个查询准备执行计划。它的参数是一个查询字符串和一个参数类型列表（如果查询中有参数引用）。例如：
plan = plpy.prepare("SELECT last_name FROM my_users WHERE first_name = $1", ["text"])
text是要为$1传递的变量的类型。如果不想给查询传递任何参数，第二个参数就是可选的。
在准备好一个语句后，可以使用函数plpy.execute的一种变体来运行它：
rv = plpy.execute(plan, ["name"], 5)
把计划作为第一个参数传递（而不是查询字符串），并且把要替换到查询中的值列表作为第二个参数传递。如果查询不需要任何参数，则第二个参数是可选的。和前面一样，第三个参数是可选的，它用来指定行数限制。
另外，你可以在计划对象上调用execute方法：
rv = plan.execute(["name"], 5)
查询参数以及结果行字段会按照第 44.2 节中所述在 PostgreSQL 和 Python 数据类型之间转换。
当您使用PL/Python模块准备计划时，它会自动保存。阅读SPI文档（第 45 章）以了解这意味着什么。
为了在函数调用之间有效地使用这个功能，需要使用其中一个持久存储字典SD或GD（参见第 44.3 节）。例如：
CREATE FUNCTION usesavedplan() RETURNS trigger AS $$
if "plan" in SD:
plan = SD["plan"]
else:
plan = plpy.prepare("SELECT 1")
SD["plan"] = plan
# rest of function
$$ LANGUAGE plpython3u;
plpy.cursor(query)plpy.cursor(plan [, arguments])
plpy.cursor函数接受和plpy.execute相同的参数（行数限制除外）并且返回一个游标对象，它允许以较小的块来处理大型结果集。和plpy.execute一样，既可以使用一个查询字符串，也可以使用带有参数列表的计划对象，或者cursor函数可以作为计划对象的一个方法来调用。
游标对象提供了一种fetch方法，它接受一个整数参数并返回一个结果对象。每次调用fetch，返回的对象将包含下一批行，行数不会超过参数值。一旦所有的行都被消耗掉，fetch会开始返回一个空的结果对象。游标对象也提供一种迭代器接口，它一次返回一行直到所有行被耗尽。用这种方法取得的数据不会被作为结果对象返回，而是以字典的形式返回，每一个字典对应于一个结果行。
从一个大表中处理数据的两种方式示例是：
CREATE FUNCTION count_odd_iterator() RETURNS integer AS $$
odd = 0
for row in plpy.cursor("select num from largetable"):
if row['num'] % 2:
odd += 1
return odd
$$ LANGUAGE plpython3u;
CREATE FUNCTION count_odd_fetch(batch_size integer) RETURNS integer AS $$
odd = 0
cursor = plpy.cursor("select num from largetable")
while True:
rows = cursor.fetch(batch_size)
if not rows:
break
for row in rows:
if row['num'] % 2:
odd += 1
return odd
$$ LANGUAGE plpython3u;
CREATE FUNCTION count_odd_prepared() RETURNS integer AS $$
odd = 0
plan = plpy.prepare("select num from largetable where num % $1 <> 0", ["integer"])
rows = list(plpy.cursor(plan, [2]))  # or: = list(plan.cursor([2]))
return len(rows)
$$ LANGUAGE plpython3u;
游标会被自动释放。但是如果想要显式地释放游标所持有的所有资源，可使用close方法。一旦被关闭，就再也不能从游标中取得数据。
提示
不要把plpy.cursor创建的游标对象与Python Database API specification定义的 DB-API 游标弄混。除了名字之外，它们之间没有任何共同点。
44.6.2. 捕捉错误 #
访问数据库的函数可能会遇到错误，这将导致它们中止并引发异常。
plpy.execute和
plpy.prepare都可以引发plpy.SPIError的子类实例，
默认情况下会终止函数。
这个错误可以像处理其他Python异常一样处理，使用try/except结构。
例如：
CREATE FUNCTION try_adding_joe() RETURNS text AS $$
try:
plpy.execute("INSERT INTO users(username) VALUES ('joe')")
except plpy.SPIError:
return "something went wrong"
else:
return "Joe added"
$$ LANGUAGE plpython3u;
抛出的异常的实际类对应于导致错误的特定条件。参考表 A.1以获取可能条件的列表。
模块plpy.spiexceptions为每个PostgreSQL条件定义了一个异常类，
从条件名称派生它们的名称。例如，division_by_zero变成DivisionByZero，
unique_violation变成UniqueViolation，fdw_error变成
FdwError，依此类推。每个异常类都继承自SPIError。这种分离使得更容易处理特定错误，
例如：
CREATE FUNCTION insert_fraction(numerator int, denominator int) RETURNS text AS $$
from plpy import spiexceptions
try:
plan = plpy.prepare("INSERT INTO fractions (frac) VALUES ($1 / $2)", ["int", "int"])
plpy.execute(plan, [numerator, denominator])
except spiexceptions.DivisionByZero:
return "denominator cannot equal zero"
except spiexceptions.UniqueViolation:
return "already have that fraction"
except plpy.SPIError as e:
return "other error, SQLSTATE %s" % e.sqlstate
else:
return "fraction inserted"
$$ LANGUAGE plpython3u;
请注意，由于plpy.spiexceptions模块中的所有异常都继承自SPIError，
处理它的except子句将捕获任何数据库访问错误。
作为另一种处理不同错误情况的方法，可以捕捉SPIError异常并且在except块中通过查看异常对象的sqlstate属性来判断错误情况。这种属性是包含着“SQLSTATE”错误代码的一个字符串值。这种方法提供了近乎相同的功能
上一页 上一级 下一页44.5. 触发器函数 起始页 44.7. 显式子事务
