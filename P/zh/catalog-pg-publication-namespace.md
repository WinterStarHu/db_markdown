# 52.41. pg_publication_namespace

52.41. pg_publication_namespace
版本：
纠错本页面
搜索
目录导航
❮
❯
52.41. pg_publication_namespace #
目录pg_publication_namespace包含数据库中模式和出版物之间的映射。这是一个多对多的映射。
表 52.41. pg_publication_namespace 列
列类型
描述
oid oid
行标识符
pnpubid oid
(references pg_publication.oid)
对出版物的引用
pnnspid oid
(references pg_namespace.oid)
对模式的引用
上一页 上一级 下一页52.40. pg_publication 起始页 52.42. pg_publication_rel
