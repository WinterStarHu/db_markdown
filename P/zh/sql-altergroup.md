# ALTER GROUP

ALTER GROUP
版本：
纠错本页面
搜索
目录导航
❮
❯
ALTER GROUPALTER GROUP — 更改角色名称或成员关系大纲
ALTER GROUP role_specification ADD USER user_name [, ... ]
ALTER GROUP role_specification DROP USER user_name [, ... ]
其中 role_specification 可以是：
role_name
| CURRENT_ROLE
| CURRENT_USER
| SESSION_USER
ALTER GROUP group_name RENAME TO new_name
描述
ALTER GROUP更改用户组的属性。
这是一个被废弃的命令，不过为了向后兼容还是会被接受，因为组（以及用户）
已经被更一般的角色概念替代了。
前两种变体将用户添加到组中或将其从组中移除。（任何角色都可以在此
目的中扮演“用户”或“组”的角色。）这些变体
实际上等效于授予或撤销以“组”命名的角色的成员资格；因此，
首选的方法是使用
GRANT或
REVOKE。请注意，
GRANT和REVOKE具有此命令不可用的
其他选项，例如授予和撤销ADMIN OPTION的能力，以及
指定授予者的能力。
第三种变体会更改该组的名称。这恰好等效于用ALTER ROLE
重命名该角色。
参数group_name
要修改的组（角色）的名称。
user_name
要被加入到该组或者从该组移除的用户（角色）。这些用户必须已经存在，
ALTER GROUP不会创建或删除用户。
new_name
该组的新名称。
示例
向一个组增加用户：
ALTER GROUP staff ADD USER karl, john;
从一个组移除用户：
ALTER GROUP workers DROP USER beth;
兼容性
在 SQL 标准中没有ALTER GROUP语句。
另见GRANT, REVOKE, ALTER ROLE上一页 上一级 下一页ALTER FUNCTION 起始页 ALTER INDEX
