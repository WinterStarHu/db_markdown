# 35.14. column_options

35.14. column_options
版本：
纠错本页面
搜索
目录导航
❮
❯
35.14. column_options #
视图column_options包含当前数据库中外部表列定义的所有选项。只有当前用户能够访问（作为拥有者或具有某些特权）的那些外部表列才会被显示。
表 35.12. column_options 列
列类型
描述
table_catalog sql_identifier
包含该外部表的数据库名称（始终是当前数据库）
table_schema sql_identifier
包含该外部表的模式名称
table_name sql_identifier
外部表名称
column_name sql_identifier
列名称
option_name sql_identifier
选项名称
option_value character_data
该选项的值
上一页 上一级 下一页35.13. column_domain_usage 起始页 35.15. column_privileges
