# 52.28. pg_init_privs

52.28. pg_init_privs
版本：
纠错本页面
搜索
目录导航
❮
❯
52.28. pg_init_privs #
目录pg_init_privs记录系统中对象的初始权限。数据库中每一个具有非默认（非NULL）初始权限集合的对象都有一个条目在其中。
对象可以在系统初始化（initdb）时获得其初始权限，也可以在CREATE EXTENSION期间创建该对象并且在扩展脚本中用GRANT来设置对象的初始权限。
注意系统将自动处理扩展脚本执行期间对权限的记录，扩展的作者们只需要在他们的脚本中使用GRANT以及REVOKE语句以便权限被记录下来。
privtype列表示初始权限是被initdb设置还是在一次CREATE EXTENSION命令期间被设置。
具有被initdb设置的初始权限的对象的条目中privtype是'i'，而具有被CREATE EXTENSION设置的初始权限的对象的条目中privtype为'e'。
表 52.28. pg_init_privs 列
列类型
描述
objoid oid
(参考任何 OID 列)
指定对象的 OID
classoid oid
(references pg_class.oid)
对象所在的系统目录的 OID
objsubid int4
对于一个表列，这里是列编号（objoid和classoid指向表本身）。对于所有其他对象类型，这列为零。
privtype char
定义这个对象初始特权类型的代码；见文字说明
initprivs aclitem[]
初始的访问权限；详见第 5.8 节
上一页 上一级 下一页52.27. pg_inherits 起始页 52.29. pg_language
