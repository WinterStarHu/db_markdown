# 35.29. foreign_servers

35.29. foreign_servers
版本：
纠错本页面
搜索
目录导航
❮
❯
35.29. foreign_servers #
视图foreign_servers包含当前数据库中定义的所有外部服务器。只有那些当前用户能够访问（作为拥有者或具有某些特权）的外部服务器才会被显示。
表 35.27. foreign_servers 列
列类型
描述
foreign_server_catalog sql_identifier
外部服务器所在的数据库名称（总是当前数据库）
foreign_server_name sql_identifier
外部服务器的名称
foreign_data_wrapper_catalog sql_identifier
包含被该外部服务器使用的外部数据包装器的数据库名称（始终是当前数据库）
foreign_data_wrapper_name sql_identifier
被该外部服务器使用的外部数据包装器的名称
foreign_server_type character_data
外部服务器类型信息，如果在创建时指定
foreign_server_version character_data
外部服务器版本信息，如果在创建时指定
authorization_identifier sql_identifier
外部服务器拥有者的名称
上一页 上一级 下一页35.28. foreign_server_options 起始页 35.30. foreign_table_options
