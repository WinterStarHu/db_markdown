# 35.5. applicable_roles

35.5. applicable_roles
版本：
纠错本页面
搜索
目录导航
❮
❯
35.5. applicable_roles #
视图 applicable_roles 识别当前用户可以使用其特权的所有角色。这意味着有某种角色授权链从当前用户到讨论中的角色。当前用户本身也是一个可应用的角色。可应用的角色的集合通常用于权限检查。
表 35.3. applicable_roles 列
列类型
描述
grantee sql_identifier
授予此角色成员的角色名称（可以是当前用户，或在嵌套角色成员的情况下不同的角色）
role_name sql_identifier
角色的名称
is_grantable yes_or_no
如果被授权人在角色上有管理选项则为YES，如果没有则为NO
上一页 上一级 下一页35.4. administrable_role_​authorizations 起始页 35.6. attributes
