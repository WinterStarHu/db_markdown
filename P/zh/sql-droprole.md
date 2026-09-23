# DROP ROLE

DROP ROLE
版本：
纠错本页面
搜索
目录导航
❮
❯
DROP ROLEDROP ROLE — 移除数据库角色大纲
DROP ROLE [ IF EXISTS ] name [, ...]
说明
DROP ROLE 删除指定的角色。
要删除超级用户角色，你必须自己是超级用户；
要删除非超级用户角色，你必须拥有CREATEROLE
权限，并且被授予该角色的ADMIN OPTION。
如果一个角色仍然在集簇中任何数据库中被引用，它就不能被移除，如果尝试移除将会抛出一个错误。
在删除该角色前，你必须删除（或者重新授予所有权）它所拥有的所有对象并且收回该角色在其他对象上的任何特权。
REASSIGN OWNED
和DROP OWNED命令可以用于这个目的。
更多讨论请见第 21.4 节。
不过，没有必要移除涉及该角色的角色成员关系。DROP ROLE会自动收回目标角色在其他角色中的成员关系以及其他角色在目标角色中的成员关系。其他角色不会被删除也不会被影响。
参数IF EXISTS
如果该角色不存在则不要抛出错误，而是发出一个通知。
name
要移除的角色名称。
注释
PostgreSQL包括一个具有和这个命令完全相同的功能（事实上，它会调用这个命令）的程序dropuser，但是该程序可以从命令行运行。
示例
要删除一个角色：
DROP ROLE jonathan;
兼容性
SQL标准定义了DROP ROLE，但是它只允许一次删除一个角色，并且它指定了和PostgreSQL不同的特权要求。
另请参见CREATE ROLE, ALTER ROLE, SET ROLE上一页 上一级 下一页DROP PUBLICATION 起始页 DROP ROUTINE
