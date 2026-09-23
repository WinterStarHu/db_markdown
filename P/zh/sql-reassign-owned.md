# REASSIGN OWNED

REASSIGN OWNED
版本：
纠错本页面
搜索
目录导航
❮
❯
REASSIGN OWNEDREASSIGN OWNED — 更改数据库角色拥有的数据库对象的拥有关系大纲
REASSIGN OWNED BY { old_role | CURRENT_ROLE | CURRENT_USER | SESSION_USER } [, ...]
TO { new_role | CURRENT_ROLE | CURRENT_USER | SESSION_USER }
描述
REASSIGN OWNED指示系统把
old_roles拥有
的任何数据库对象的拥有关系更改为
new_role。
参数old_role
角色的名称。当前数据库中该角色拥有的所有对象，以及
所有共享对象（数据库、表空间）的所有权都将被重新赋予给
new_role。
new_role
将成为受影响对象的新拥有者的角色名称。
注释
REASSIGN OWNED经常被用来为移除一个
或多个角色做准备。因为REASSIGN
OWNED不影响其他数据库中的对象，通常需要在包含有
被删除的角色所拥有的对象的每个数据库中都执行这个命令。
REASSIGN OWNED同时要求源角色和目标
角色的成员资格。
DROP OWNED命令是一个替代方案，
它简单地删除一个或多个角色所拥有的所有数据库对象。
REASSIGN OWNED命令不会影响授予给old_roles的在它们不拥有的对象上的任何特权。
同样，它不会影响ALTER DEFAULT PRIVILEGES创建的默认特权。DROP OWNED可以回收这些特权。
更多讨论请见第 21.4 节。
兼容性
REASSIGN OWNED命令是一种
PostgreSQL扩展。
另请参见DROP OWNED, DROP ROLE, ALTER DATABASE上一页 上一级 下一页PREPARE TRANSACTION 起始页 REFRESH MATERIALIZED VIEW
