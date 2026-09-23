# ALTER CONVERSION

ALTER CONVERSION
版本：
纠错本页面
搜索
目录导航
❮
❯
ALTER CONVERSIONALTER CONVERSION — 更改转换的定义大纲
ALTER CONVERSION name RENAME TO new_name
ALTER CONVERSION name OWNER TO { new_owner | CURRENT_ROLE | CURRENT_USER | SESSION_USER }
ALTER CONVERSION name SET SCHEMA new_schema
描述
ALTER CONVERSION 更改转换的定义。
您必须拥有该转换才能使用 ALTER CONVERSION。
要更改所有者，您必须能够 SET ROLE 为新的所有者角色，
并且该角色必须对转换的模式具有 CREATE 权限。
（这些限制确保更改所有者不会执行您通过删除和重新创建转换无法完成的操作。
然而，超级用户仍然可以更改任何转换的所有权。）
参数name
一个现有转换的名称（可选的模式限定）。
new_name
转换的新名称。
new_owner
转换的新拥有者。
new_schema
转换的新模式。
示例
要把转换iso_8859_1_to_utf8重命名为latin1_to_unicode：
ALTER CONVERSION iso_8859_1_to_utf8 RENAME TO latin1_to_unicode;
要把转换iso_8859_1_to_utf8的拥有者改成joe：
ALTER CONVERSION iso_8859_1_to_utf8 OWNER TO joe;
兼容性
在 SQL 标准中没有ALTER CONVERSION语句。
参见其他CREATE CONVERSION, DROP CONVERSION上一页 上一级 下一页ALTER COLLATION 起始页 ALTER DATABASE
