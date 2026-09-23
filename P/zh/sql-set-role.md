# SET ROLE

SET ROLE
版本：
纠错本页面
搜索
目录导航
❮
❯
SET ROLESET ROLE — 设置当前会话的用户标识符大纲
SET [ SESSION | LOCAL ] ROLE role_name
SET [ SESSION | LOCAL ] ROLE NONE
RESET ROLE
描述
此命令将当前 SQL 会话的用户标识符设置为 role_name。角色名称可以写成标识符或字符串字面量。
在执行 SET ROLE 后，SQL 命令的权限检查将视为指定的角色是最初登录的用户。
注意，SET ROLE 和 SET SESSION AUTHORIZATION 是例外；
这些命令的权限检查分别继续使用当前会话用户和初始会话用户（即 认证用户）。
当前会话用户必须具有指定的 SET 选项，针对
role_name，可以是直接
拥有，也可以通过带有 SET 选项的成员关系链间接
拥有。
（如果会话用户是超级用户，则可以选择任何角色。）
SESSION 和 LOCAL 修饰符发挥的作用和常规的 SET 命令一样。
SET ROLE NONE 设置当前用户标识符为当前会话用户标识符，由 session_user 返回。
RESET ROLE 设置当前用户标识符为由 command-line options、ALTER ROLE 或 ALTER DATABASE 指定的连接时间设定，如果存在这样的设置的话。
否则，RESET ROLE 设置当前用户标识符为当前会话用户标识符。
这些形式可以由任何用户执行。
注释
使用此命令，可以添加权限或限制自己的权限。如果会话用户角色被授予
WITH INHERIT TRUE，它会自动拥有每个此类角色的所有权限。
在这种情况下，SET ROLE实际上会删除除目标角色直接
拥有或继承的权限之外的所有权限。另一方面，如果会话用户角色被授予
WITH INHERIT FALSE，则默认情况下无法访问被授予角色的
权限。然而，如果角色被授予WITH SET TRUE，会话用户
可以使用SET ROLE来放弃直接分配给会话用户的权限，
而是获取指定角色可用的权限。如果角色被授予WITH INHERIT
FALSE, SET FALSE，那么无论是否使用SET ROLE，
都无法行使该角色的权限。
SET ROLE的效果堪比
SET SESSION AUTHORIZATION，但是涉及的特权检查
完全不同。还有，SET SESSION AUTHORIZATION决定
后来的SET ROLE命令可以使用哪些角色，不过用
SET ROLE更改角色并不会改变后续
SET ROLE能够使用的角色集。
SET ROLE不会处理角色的ALTER ROLE设置指定的会话变量；
这只在登录期间发生。
SET ROLE不能在一个
SECURITY DEFINER函数中使用。
示例
SELECT SESSION_USER, CURRENT_USER;
session_user | current_user
--------------+--------------
peter        | peter
SET ROLE 'paul';
SELECT SESSION_USER, CURRENT_USER;
session_user | current_user
--------------+--------------
peter        | paul
兼容性
PostgreSQL允许标识符
语法（"rolename"），而 SQL 标准要求
角色名被写成字符串文字。SQL 不允许在事务中使用这个命令，而
PostgreSQL并不做此限制，因为并没有原因需要这样做。
SESSION和LOCAL修饰符是一种
PostgreSQL扩展，RESET语法也是如此。
另见SET SESSION AUTHORIZATION上一页 上一级 下一页SET CONSTRAINTS 起始页 SET SESSION AUTHORIZATION
