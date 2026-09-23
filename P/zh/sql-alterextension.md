# ALTER EXTENSION

ALTER EXTENSION
版本：
纠错本页面
搜索
目录导航
❮
❯
ALTER EXTENSIONALTER EXTENSION —
更改扩展的定义
大纲
ALTER EXTENSION name UPDATE [ TO new_version ]
ALTER EXTENSION name SET SCHEMA new_schema
ALTER EXTENSION name ADD member_object
ALTER EXTENSION name DROP member_object
其中 member_object 是：
ACCESS METHOD object_name |
AGGREGATE aggregate_name ( aggregate_signature ) |
CAST (source_type AS target_type) |
COLLATION object_name |
CONVERSION object_name |
DOMAIN object_name |
EVENT TRIGGER object_name |
FOREIGN DATA WRAPPER object_name |
FOREIGN TABLE object_name |
FUNCTION function_name [ ( [ [ argmode ] [ argname ] argtype [, ...] ] ) ] |
MATERIALIZED VIEW object_name |
OPERATOR operator_name (left_type, right_type) |
OPERATOR CLASS object_name USING index_method |
OPERATOR FAMILY object_name USING index_method |
[ PROCEDURAL ] LANGUAGE object_name |
PROCEDURE procedure_name [ ( [ [ argmode ] [ argname ] argtype [, ...] ] ) ] |
ROUTINE routine_name [ ( [ [ argmode ] [ argname ] argtype [, ...] ] ) ] |
SCHEMA object_name |
SEQUENCE object_name |
SERVER object_name |
TABLE object_name |
TEXT SEARCH CONFIGURATION object_name |
TEXT SEARCH DICTIONARY object_name |
TEXT SEARCH PARSER object_name |
TEXT SEARCH TEMPLATE object_name |
TRANSFORM FOR type_name LANGUAGE lang_name |
TYPE object_name |
VIEW object_name
并且 aggregate_signature 是：
* |
[ argmode ] [ argname ] argtype [ , ... ] |
[ [ argmode ] [ argname ] argtype [ , ... ] ] ORDER BY [ argmode ] [ argname ] argtype [ , ... ]
描述
ALTER EXTENSION更改已安装扩展的定义。
有几种子形式：
UPDATE
这种形式将扩展更新到一个新版本。扩展必须提供一个适当的更新
脚本（或一系列脚本）来将当前已安装的版本修改为所请求的版本。
SET SCHEMA
这种形式将扩展的对象移动到另一个模式中。扩展必须是可重定位的，才能使该命令成功。
ADD member_object
这种形式将一个现有的对象添加到扩展中。这主要在扩展更新脚本中有用。
该对象随后将被视为扩展的成员；特别是，它只能通过删除扩展来删除。
DROP member_object
这种形式从扩展中移除一个成员对象。这主要在扩展更新脚本中有用。
该对象不会被删除，只是与扩展解除关联。
有关这些操作的更多信息，请参见第 36.17 节。
要使用ALTER EXTENSION，你必须拥有该扩展。
ADD/DROP形式还要求拥有被添加/删除对象的所有权。
参数
name
已安装扩展的名称。
new_version
期望的扩展新版本。这可以写成标识符或字符串文字。如果未指定，
ALTER EXTENSION UPDATE将尝试更新到扩展控制文件中
显示的默认版本。
new_schema
扩展的新模式。
object_nameaggregate_namefunction_nameoperator_nameprocedure_nameroutine_name
要添加到或从扩展中移除的对象的名称。表、聚合、域、外部表、函数、
操作符、操作符类、操作符族、过程、例程、序列、文本搜索对象、
类型和视图的名称可以被模式限定。
source_type
转换的源数据类型的名称。
target_type
转换的目标数据类型的名称。
argmode
函数、过程或聚合参数的模式：IN、OUT、
INOUT或VARIADIC。如果省略，默认值为
IN。注意，ALTER EXTENSION并不真正关心
OUT参数，因为只需要输入参数来确定函数的身份。
因此，列出IN、INOUT和
VARIADIC参数即可。
argname
函数、过程或聚合参数的名称。注意，
ALTER EXTENSION并不真正关心参数名称，因为
只需要参数的数据类型来确定函数的身份。
argtype
函数、过程或聚合参数的数据类型。
left_typeright_type
操作符参数的数据类型（可以用模式限定）。对于前缀操作符的缺失参数
可以写NONE。
PROCEDURAL
这是一个噪声词。
type_name
转换的数据类型的名称。
lang_name
转换的语言的名称。
示例
将hstore扩展更新到版本 2.0：
ALTER EXTENSION hstore UPDATE TO '2.0';
将hstore扩展的模式更改为utils：
ALTER EXTENSION hstore SET SCHEMA utils;
要向hstore扩展添加一个现有函数：
ALTER EXTENSION hstore ADD FUNCTION populate_record(anyelement, hstore);
兼容性
ALTER EXTENSION是一个PostgreSQL
扩展。
另见CREATE EXTENSION, DROP EXTENSION上一页 上一级 下一页ALTER EVENT TRIGGER 起始页 ALTER FOREIGN DATA WRAPPER
