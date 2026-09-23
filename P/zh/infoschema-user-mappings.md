# 35.62. user_mappings

35.62. user_mappings
版本：
纠错本页面
搜索
目录导航
❮
❯
35.62. user_mappings #
视图user_mappings包含定义在当前数据库中的所有用户映射。只有当前用户能够访问其对应外部服务器（作为拥有者或具有某些特权）的用户映射才会被显示。
表 35.60. user_mappings 列
列类型
描述
authorization_identifier sql_identifier
被映射的用户名称，或PUBLIC如果映射是公共的
foreign_server_catalog sql_identifier
这个映射所使用的外部服务器所在的数据库名称（总是当前数据库）
foreign_server_name sql_identifier
这个映射所使用的外部服务器的名称
上一页 上一级 下一页35.61. user_mapping_options 起始页 35.63. view_column_usage
