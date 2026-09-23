# 52.31. pg_largeobject_metadata

52.31. pg_largeobject_metadata
版本：
纠错本页面
搜索
目录导航
❮
❯
52.31. pg_largeobject_metadata #
目录pg_largeobject_metadata保持着与大对象有关的元数据。真正的大对象数据被存储在pg_largeobject中。
表 52.31. pg_largeobject_metadata 列
列类型
描述
oid oid
行标识符
lomowner oid
(references pg_authid.oid)
大对象的拥有者
lomacl aclitem[]
访问权限；详见第 5.8 节获取详细信息
上一页 上一级 下一页52.30. pg_largeobject 起始页 52.32. pg_namespace
