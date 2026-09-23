# 52.32. pg_namespace

52.32. pg_namespace
版本：
纠错本页面
搜索
目录导航
❮
❯
52.32. pg_namespace #
目录pg_namespace存储命名空间。命名空间是SQL模式之下的结构：每个命名空间拥有一个独立的表、类型等的集合，且其中没有名称冲突。
表 52.32. pg_namespace 列
列类型
描述
oid oid
行标识符
nspname name
命名空间的名称
nspowner oid
(references pg_authid.oid)
命名空间的拥有者
nspacl aclitem[]
访问权限；详见第 5.8 节获取详细信息
上一页 上一级 下一页52.31. pg_largeobject_metadata 起始页 52.33. pg_opclass
