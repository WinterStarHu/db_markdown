# CREATE TRANSFORM

CREATE TRANSFORM
版本：
纠错本页面
搜索
目录导航
❮
❯
CREATE TRANSFORMCREATE TRANSFORM — 定义一个新的转换大纲
CREATE [ OR REPLACE ] TRANSFORM FOR type_name LANGUAGE lang_name (
FROM SQL WITH FUNCTION from_sql_function_name [ (argument_type [, ...]) ],
TO SQL WITH FUNCTION to_sql_function_name [ (argument_type [, ...]) ]
);
描述
CREATE TRANSFORM定义一种新的转换。
CREATE OR REPLACE TRANSFORM将
创建一种新的转换或者替换现有的定义。
一种转换指定了如何把一种数据类型适配到一种过程语言。例如，在用
PL/Python 编写一个使用hstore类型的函数时，PL/Python
没有关于如何在 Python 环境中表示hstore值的先验知识。
语言的实现通常默认会使用文本表示，但是在一些时候这很不方便，例如
有时可能用一个关联数组或者列表更合适。
一种转换指定了两个函数：
一个“from SQL”函数负责将类型从 SQL 环境转换到语言。
这个函数将在该语言编写的一个函数的参数上调用。
一个“to SQL”函数负责将类型从语言转换到 SQL 环境。这
个函数将在该语言编写的一个函数的返回值上调用。
没有必要同时提供这些函数。如果有一种没有被指定，将在必要时使用与语言相
关的默认行为（为了完全阻止在一个方向上发生转换，你也可以写一个总是报错
的转换函数）。
要创建一种转换，你必须拥有该类型并且具有该类型上的
USAGE特权，拥有该语言上的
USAGE特权，并且拥有 from-SQL 和 to-SQL 函数（如果
指定了）及其上的EXECUTE特权。
参数type_name
该转换的数据类型的名称。
lang_name
该转换的语言名称。
from_sql_function_name[(argument_type [, ...])]
将该类型从 SQL 环境转换到该语言的函数名。它必须接受一个
internal类型的参数并且返回类型internal。
实参将是该转换所适用的类型，并且该函数也应该被写成认为它是那种类型（
但是不允许声明一个返回internal但没有至少一个
internal类型参数的 SQL 层函数）。实际的返回值将与
语言的实现相关。如果没有指定参数列表，则函数名在该模式中必须唯一。
to_sql_function_name[(argument_type [, ...])]
将该类型从语言转换到 SQL 环境的函数名。它必须接受一个
internal类型的参数并且返回该转换所适用的类型。实参值
将与语言的实现相关。如果没有指定参数列表，则函数名在该模式中必须唯一。
注意事项
使用DROP TRANSFORM移除转换。
示例
要为类型hstore和语言plpython3u创建转换器，首先设置类型和语言：
CREATE TYPE hstore ...;
CREATE EXTENSION plpython3u;
然后创建必要的函数：
CREATE FUNCTION hstore_to_plpython(val internal) RETURNS internal
LANGUAGE C STRICT IMMUTABLE
AS ...;
CREATE FUNCTION plpython_to_hstore(val internal) RETURNS hstore
LANGUAGE C STRICT IMMUTABLE
AS ...;
最后创建连接它们的转换器：
CREATE TRANSFORM FOR hstore LANGUAGE plpython3u (
FROM SQL WITH FUNCTION hstore_to_plpython(internal),
TO SQL WITH FUNCTION plpython_to_hstore(internal)
);
在实践中，这些命令将被包装在一个扩展中。
contrib小节包含了一些提供转换的扩展，
它们可以作为实际的例子。
兼容性
这种形式的CREATE TRANSFORM是一种
PostgreSQL扩展。在
SQL标准中有一个CREATE
TRANSFORM命令，但是它是用于把数据类型适配到
客户端语言。该用法不受
PostgreSQL支持。
其他
CREATE FUNCTION,
CREATE LANGUAGE,
CREATE TYPE,
DROP TRANSFORM
上一页 上一级 下一页CREATE TEXT SEARCH TEMPLATE 起始页 CREATE TRIGGER
