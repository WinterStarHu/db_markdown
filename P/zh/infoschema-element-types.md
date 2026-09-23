# 35.24. element_types

35.24. element_types
版本：
纠错本页面
搜索
目录导航
❮
❯
35.24. element_types #
视图element_types包含数组元素的数据类型描述符。当一个表列、组合类型属性、域、函数参数或函数返回值被定义为一种数组类型，相应的信息模式视图只在列data_type中包含ARRAY。要获得该数组元素类型的信息，你可以连接该相应的视图和这个视图。例如，要显示一个表的列及其数据类型和数组元素类型，你可以：
SELECT c.column_name, c.data_type, e.data_type AS element_type
FROM information_schema.columns c LEFT JOIN information_schema.element_types e
ON ((c.table_catalog, c.table_schema, c.table_name, 'TABLE', c.dtd_identifier)
= (e.object_catalog, e.object_schema, e.object_name, e.object_type, e.collection_type_identifier))
WHERE c.table_schema = '...' AND c.table_name = '...'
ORDER BY c.ordinal_position;
这个视图只包括当前用户能够访问的对象（作为拥有者或具有某些特权）。
表 35.22. element_types 列
列类型
描述
object_catalog sql_identifier
包含使用被描述的数组的对象的数据库名称（总是当前数据库）
object_schema sql_identifier
包含使用被描述的数组的对象的模式名称
object_name sql_identifier
使用被描述的数组的对象名称
object_type character_data
使用被描述的数组的对象的类型：TABLE（被一个表列使用的数组）、USER-DEFINED TYPE（被组合类型的一个属性使用的数组）、DOMAIN（被域使用的数组）、ROUTINE（被函数的一个参数或返回数据类型使用的数组）。
collection_type_identifier sql_identifier
被描述的数组的数据类型描述符的标识符。使用此标识符与其他信息模式视图的dtd_identifier列连接。
data_type character_data
如果数组元素的数据类型是内建类型，这里是数组元素的数据类型，否则为USER-DEFINED（在那种情况下，该类型在udt_name和相关列中被标识）。
character_maximum_length cardinal_number
总是为空，因为这种信息不适用于PostgreSQL中的数组元素数据类型
character_octet_length cardinal_number
总是为空，因为这种信息不适用于PostgreSQL中的数组元素数据类型
character_set_catalog sql_identifier
应用于一个PostgreSQL中不可用的特性
character_set_schema sql_identifier
应用于一个PostgreSQL中不可用的特性
character_set_name sql_identifier
应用于一个PostgreSQL中不可用的特性
collation_catalog sql_identifier
包含元素类型排序规则的数据库名称（总是当前数据库），如果默认或该元素的数据类型是不可排序的则为空
collation_schema sql_identifier
包含元素类型排序规则的模式名称，若为默认或该元素的数据类型是不可排序的则为空
collation_name sql_identifier
元素类型的排序规则名，若为默认或该元素的数据类型是不可排序的则为空
numeric_precision cardinal_number
总是为空，因为这种信息不适用于PostgreSQL中的数组元素数据类型
numeric_precision_radix cardinal_number
总是为空，因为这种信息不适用于PostgreSQL中的数组元素数据类型
numeric_scale cardinal_number
总是为空，因为这种信息不适用于PostgreSQL中的数组元素数据类型
datetime_precision cardinal_number
总是为空，因为这种信息不适用于PostgreSQL中的数组元素数据类型
interval_type character_data
总是为空，因为这种信息不适用于PostgreSQL中的数组元素数据类型
interval_precision cardinal_number
总是为空，因为这种信息不适用于PostgreSQL中的数组元素数据类型
udt_catalog sql_identifier
元素的数据类型所在的数据库名称（始终是当前数据库）
udt_schema sql_identifier
定义元素的数据类型的模式名称
udt_name sql_identifier
元素的数据类型名称
scope_catalog sql_identifier
应用于一个PostgreSQL中不可用的特性
scope_schema sql_identifier
应用于一个PostgreSQL中不可用的特性
scope_name sql_identifier
应用于一个PostgreSQL中不可用的特性
maximum_cardinality cardinal_number
总是空，因为数组在PostgreSQL中总是有无限的最大势
dtd_identifier sql_identifier
该元素的数据类型描述符的标识符。当前没有用。
上一页 上一级 下一页35.23. domains 起始页 35.25. enabled_roles
