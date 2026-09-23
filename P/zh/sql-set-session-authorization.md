# SET SESSION AUTHORIZATION

SET SESSION AUTHORIZATION
版本：
纠错本页面
搜索
目录导航
❮
❯
SET SESSION AUTHORIZATIONSET SESSION AUTHORIZATION — 设置当前会话的会话用户标识符和当前用户标识符大纲
SET [ SESSION | LOCAL ] SESSION AUTHORIZATION user_name
SET [ SESSION | LOCAL ] SESSION AUTHORIZATION DEFAULT
RESET SESSION AUTHORIZATION
描述
这个命令把当前 SQL 会话的会话用户标识符和当前用户标识符设置为
user_name。用户名可以被写成一个标识符或者一个字符串。
例如，可以使用这个命令临时成为一个无特权用户并且稍后切换回来成为一个超级用户。
会话用户标识符初始时被设置为客户端提供的（可能已认证的）用户名。
当前用户标识符通常等于会话用户标识符，但是可能在
SECURITY DEFINER函数和类似机制的环境中临时更改。
也可以用SET ROLE更改它。当前用户标识符与
权限检查相关。
会话用户标识符只有在初始会话用户（即认证用户）具有超级用户权限时才能更改。
否则，只有在指定了认证用户名的情况下，命令才会被接受。
SESSION和LOCAL修饰符发挥的作用和常规
SET命令一样。
DEFAULT和RESET形式把会话用户标识符和
当前用户标识符重置为最初的已认证用户名。这些形式可以由任何用户执行。
注释
SET SESSION AUTHORIZATION不能在一个
SECURITY DEFINER函数中使用。
示例
SELECT SESSION_USER, CURRENT_USER;
session_user | current_user
--------------+--------------
peter        | peter
SET SESSION AUTHORIZATION 'paul';
SELECT SESSION_USER, CURRENT_USER;
session_user | current_user
--------------+--------------
paul         | paul
兼容性
SQL 标准允许一些其他表达式出现在文本
user_name的位置上，但是实际上这些
选项并不重要。PostgreSQL允许标
识符语法（"username"），而 SQL 标准不允许。
SQL 不允许在事务中使用这个命令，而
PostgreSQL并不做此限
制，因为并没有理由需要这样做。和RESET语法
一样，SESSION和
LOCAL修饰符是一种
PostgreSQL扩展。
标准把执行这个命令所需的特权留给实现定义。
另请参阅SET ROLE上一页 上一级 下一页SET ROLE 起始页 SET TRANSACTION
