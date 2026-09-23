# ALTER LARGE OBJECT

ALTER LARGE OBJECT
版本：
纠错本页面
搜索
目录导航
❮
❯
ALTER LARGE OBJECTALTER LARGE OBJECT — 更改大对象的定义大纲
ALTER LARGE OBJECT large_object_oid OWNER TO { new_owner | CURRENT_ROLE | CURRENT_USER | SESSION_USER }
描述
ALTER LARGE OBJECT更改大对象的定义。
您必须拥有大对象才能使用ALTER LARGE OBJECT。
要更改所有者，您还必须能够SET ROLE为新的所有者角色。
（但是，超级用户无论如何都可以更改任何大对象。）
目前，唯一的功能是分配一个新的所有者，因此这两个限制始终适用。
参数large_object_oid
要更改的大对象的 OID
new_owner
该大对象的新拥有者
兼容性
在 SQL 标准中没有ALTER LARGE OBJECT
语句。
另见第 33 章上一页 上一级 下一页ALTER LANGUAGE 起始页 ALTER MATERIALIZED VIEW
