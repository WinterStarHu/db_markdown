# 35.25. enabled_roles

35.25. enabled_roles
版本：
纠错本页面
搜索
目录导航
❮
❯
35.25. enabled_roles #
视图enabled_roles标识当前“已启用的角色”。已启用的角色被递归地定义为：当前用户以及被授予给具有自动继承的已启用角色的所有角色。换句话说，就是当前用户是其直接或间接、自动继承成员的所有角色。
为了权限检查，“可应用角色”的集合被应用，它会比已启用角色的集合包含的角色范围更宽。因此通常使用视图applicable_roles要更好，applicable_roles视图的详情请见第 35.5 节。
表 35.23. enabled_roles 列
列类型
描述
role_name sql_identifier
角色的名称
上一页 上一级 下一页35.24. element_types 起始页 35.26. foreign_data_wrapper_options
