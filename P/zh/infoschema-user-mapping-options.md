# 35.61. user_mapping_options

35.61. user_mapping_options
版本：
纠错本页面
搜索
目录导航
❮
❯
35.61. user_mapping_options #
视图user_mapping_options包含在当前数据库中为用户映射定义的所有选项。只有那些当前用户能够访问其相应外部服务器（作为拥有者或具有某些特权）的用户映射才会被显示。
表 35.59. user_mapping_options 列
列类型
描述
authorization_identifier sql_identifier
被映射的用户名称，或者如果映射是公共的则为PUBLIC
foreign_server_catalog sql_identifier
这个映射所使用的外部服务器所在的数据库名称（始终是当前数据库）
foreign_server_name sql_identifier
这个映射所使用的外部服务器的名称
option_name sql_identifier
选项名称
option_value character_data
选项的值。除非当前用户是被映射的用户，或者映射是PUBLIC并且当前用户是服务器拥有者，或者当前用户是超级用户，否则这一列将显示为空。这样做的目的是保护作为用户映射选项存储的密码信息。
上一页 上一级 下一页35.60. user_defined_types 起始页 35.62. user_mappings
