# ALTER OPERATOR CLASS

ALTER OPERATOR CLASS
版本：
纠错本页面
搜索
目录导航
❮
❯
ALTER OPERATOR CLASSALTER OPERATOR CLASS — 更改操作符类的定义大纲
ALTER OPERATOR CLASS name USING index_method
RENAME TO new_name
ALTER OPERATOR CLASS name USING index_method
OWNER TO { new_owner | CURRENT_ROLE | CURRENT_USER | SESSION_USER }
ALTER OPERATOR CLASS name USING index_method
SET SCHEMA new_schema
描述
ALTER OPERATOR CLASS更改操作符类的定义。
您必须拥有操作符类的所有权才能使用ALTER OPERATOR CLASS。
要更改所有者，您必须能够SET ROLE为新的所有角色，
并且该角色必须对操作符类的模式具有CREATE
权限。
（这些限制确保更改所有者不会执行您无法通过删除和重新创建操作符类
来完成的操作。然而，超级用户仍然可以更改任何操作符类的所有权。）
参数name
一个现有操作符类的名称（可以是模式限定的）。
index_method
该操作符类所服务的索引方法的名称。
new_name
该操作符类的新名称。
new_owner
该操作符类的新拥有者。
new_schema
该操作符类的新模式。
兼容性
在 SQL 标准中没有 ALTER OPERATOR CLASS 语句。
另见CREATE OPERATOR CLASS, DROP OPERATOR CLASS, ALTER OPERATOR FAMILY上一页 上一级 下一页ALTER OPERATOR 起始页 ALTER OPERATOR FAMILY
