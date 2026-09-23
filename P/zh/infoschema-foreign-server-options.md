# 35.28. foreign_server_options

35.28. foreign_server_options
版本：
纠错本页面
搜索
目录导航
❮
❯
35.28. foreign_server_options #
视图foreign_server_options包含为当前数据库中外部服务器定义的所有选项。只有那些当前用户能够访问（作为拥有者或具有某些特权）的外部服务器才会被显示。
表 35.26. foreign_server_options 列
列类型
描述
foreign_server_catalog sql_identifier
该外部服务器所在的数据库名称（总是当前数据库）
foreign_server_name sql_identifier
外部服务器的名称
option_name sql_identifier
选项名称
option_value character_data
选项的值
上一页 上一级 下一页35.27. foreign_data_wrappers 起始页 35.29. foreign_servers
