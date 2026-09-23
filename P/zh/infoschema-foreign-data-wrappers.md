# 35.27. foreign_data_wrappers

35.27. foreign_data_wrappers
版本：
纠错本页面
搜索
目录导航
❮
❯
35.27. foreign_data_wrappers #
视图foreign_data_wrappers包含定义在当前数据库中的所有外部数据包装器。只有那些当前用户能够访问（作为拥有者或具有某些特权）的外部数据包装器才会被显示。
表 35.25. foreign_data_wrappers 列
列类型
描述
foreign_data_wrapper_catalog sql_identifier
包含该外部数据包装器的数据库名称（始终是当前数据库）
foreign_data_wrapper_name sql_identifier
外部数据包装器的名称
authorization_identifier sql_identifier
外部服务器拥有者的名称
library_name character_data
实现这个外部数据包装器的库文件名称
foreign_data_wrapper_language character_data
用于实现这个外部数据包装器的语言
上一页 上一级 下一页35.26. foreign_data_wrapper_options 起始页 35.28. foreign_server_options
