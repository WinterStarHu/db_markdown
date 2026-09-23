# 35.30. foreign_table_options

35.30. foreign_table_options
版本：
纠错本页面
搜索
目录导航
❮
❯
35.30. foreign_table_options #
视图foreign_table_options包含为当前数据库中外部表定义的所有选项。只有那些当前用户能够访问（作为拥有者或具有某些特权）的外部表才会被显示。
表 35.28. foreign_table_options 列
列类型
描述
foreign_table_catalog sql_identifier
包含该外部表的数据库名称（始终是当前数据库）
foreign_table_schema sql_identifier
包含该外部表的模式名称
foreign_table_name sql_identifier
外部表的名称
option_name sql_identifier
选项名称
option_value character_data
选项的值
上一页 上一级 下一页35.29. foreign_servers 起始页 35.31. foreign_tables
