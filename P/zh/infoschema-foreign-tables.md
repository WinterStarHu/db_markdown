# 35.31. foreign_tables

35.31. foreign_tables
版本：
纠错本页面
搜索
目录导航
❮
❯
35.31. foreign_tables #
视图foreign_tables包含当前数据库中定义的所有外部表。只有当前用户能够访问的外部表（作为拥有者或具有某些特权）才会被显示。
表 35.29. foreign_tables 列
列类型
描述
foreign_table_catalog sql_identifier
该外部表所在的数据库名称（始终是当前数据库）
foreign_table_schema sql_identifier
包含该外部表的模式名称
foreign_table_name sql_identifier
外部表的名称
foreign_server_catalog sql_identifier
该外部服务器所在的数据库名称（始终是当前数据库）
foreign_server_name sql_identifier
外部服务器的名称
上一页 上一级 下一页35.30. foreign_table_options 起始页 35.32. key_column_usage
