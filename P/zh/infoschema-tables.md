# 35.54. tables

35.54. tables
版本：
纠错本页面
搜索
目录导航
❮
❯
35.54. tables #
视图tables包含定义在当前数据库中的所有表和视图。只有那些当前用户能够访问（作为拥有者或具有某些特权）的表和视图才会被显示。
表 35.52. tables 列
列类型
描述
table_catalog sql_identifier
包含该表的数据库名称（始终是当前数据库）
table_schema sql_identifier
包含该表的模式名称
table_name sql_identifier
表的名称
table_type character_data
该表的类型：BASE TABLE表示一个持久的基本表（常见表类型），VIEW表示一个视图，FOREIGN表示一个外部表，或LOCAL TEMPORARY表示一个临时表
self_referencing_column_name sql_identifier
应用于一个PostgreSQL中不可用的特性
reference_generation character_data
应用于一个PostgreSQL中不可用的特性
user_defined_type_catalog sql_identifier
如果该表是一个有类型的表，则是包含其底层数据类型的数据库名称（始终是当前数据库），否则为空。
user_defined_type_schema sql_identifier
如果该表是一个有类型的表，则是包含其底层数据类型的模式名称，否则为空。
user_defined_type_name sql_identifier
如果该表是一个有类型的表，则是其底层数据类型的名称，否则为null。
is_insertable_into yes_or_no
YES 如果该表能够被插入，NO 如果不能（基本表总是能被插入，而视图则不一定。）
is_typed yes_or_no
YES 如果该表是一个有类型的表，NO 如果不是
commit_action character_data
尚未实现
上一页 上一级 下一页35.53. table_privileges 起始页 35.55. transforms
