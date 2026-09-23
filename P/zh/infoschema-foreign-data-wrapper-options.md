# 35.26. foreign_data_wrapper_options

35.26. foreign_data_wrapper_options
版本：
纠错本页面
搜索
目录导航
❮
❯
35.26. foreign_data_wrapper_options #
视图foreign_data_wrapper_options包含为当前数据库中外部数据包装器定义的所有选项。只有那些当前用户能够访问（作为拥有者或具有某些特权）的外部数据包装器被显示。
表 35.24. foreign_data_wrapper_options 列
列类型
描述
foreign_data_wrapper_catalog sql_identifier
该外部数据包装器所在的数据库名称（始终是当前数据库）
foreign_data_wrapper_name sql_identifier
该外部数据包装器的名称
option_name sql_identifier
选项名称
option_value character_data
该选项的值
上一页 上一级 下一页35.25. enabled_roles 起始页 35.27. foreign_data_wrappers
