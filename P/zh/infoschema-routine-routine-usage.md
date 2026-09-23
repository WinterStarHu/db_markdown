# 35.42. routine_routine_usage

35.42. routine_routine_usage
版本：
纠错本页面
搜索
目录导航
❮
❯
35.42. routine_routine_usage #
视图routine_routine_usage标识出所有被另一个（或同一个）函数或过程使用的函数或过程，
无论是在SQL主体中还是在参数默认表达式中。（这仅适用于未引用的SQL主体，而不适用于引用的主体或其他语言中的函数。）
只有在被使用的函数由当前启用的角色拥有时，才会在此处包含一个条目。（对于使用函数，没有这样的限制。）
注意，视图中两个函数的条目都引用了例程的“specific”名称，
即使列名被使用的方式与关于例程的其他信息模式视图不一致。
这是根据SQL标准，尽管这是一个有争议的设计错误。
有关特定名称的更多信息，请参见第 35.45 节。
表 35.40. routine_routine_usage 列
列类型
描述
specific_catalog sql_identifier
包含使用函数的数据库的名称（总是当前数据库）
specific_schema sql_identifier
包含使用函数的模式的名称
specific_name sql_identifier
使用函数的 “specific name”。
routine_catalog sql_identifier
包含第一个函数使用的函数的数据库名称（总是当前数据库）
routine_schema sql_identifier
包含由第一个函数使用的函数的模式名称
routine_name sql_identifier
由第一个函数使用的函数的 “specific name”。
上一页 上一级 下一页35.41. routine_privileges 起始页 35.43. routine_sequence_usage
