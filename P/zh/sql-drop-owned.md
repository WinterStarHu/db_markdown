# DROP OWNED

DROP OWNED
版本：
纠错本页面
搜索
目录导航
❮
❯
DROP OWNEDDROP OWNED — 移除数据库角色拥有的数据库对象大纲
DROP OWNED BY { name | CURRENT_ROLE | CURRENT_USER | SESSION_USER } [, ...] [ CASCADE | RESTRICT ]
说明
DROP OWNED 删除当前数据库中由指定角色拥有的所有对象。
对当前数据库中的对象或共享对象（数据库、表空间、配置参数）授予给定角色的任何权限也将被撤销。
参数name
将被删除对象并且其权限将被撤销的角色的名称。
CASCADE
自动删除依赖于受影响对象的对象，然后删除所有依赖于那些对象的对象
（见 第 5.15 节）。
RESTRICT
如果有任何其他数据库对象依赖于一个受影响的对象，则拒绝删除这个受影响角色所拥有的对象。这是默认。
注释
DROP OWNED常常被用来为移除一个或多个角色做准备。因为DROP OWNED只影响当前数据库中的对象，通常有必要在包含将被移除角色拥有对象的每一个数据库中都执行这个命令。
使用CASCADE选项可能导致这个命令递归到其他用户所拥有的对象。
REASSIGN OWNED命令是另一种选择，它可以把一个或多个角色所拥有的所有数据库对象重新授予给其他角色。不过，REASSIGN OWNED不处理其他对象的权限。
角色所拥有的数据库和表空间将不会被移除。
更多讨论请见第 21.4 节。
兼容性
DROP OWNED命令是一个PostgreSQL扩展。
另见REASSIGN OWNED, DROP ROLE上一页 上一级 下一页DROP OPERATOR FAMILY 起始页 DROP POLICY
