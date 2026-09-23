# 52.40. pg_publication

52.40. pg_publication
版本：
纠错本页面
搜索
目录导航
❮
❯
52.40. pg_publication #
目录pg_publication包含数据库中创建的所有发布。更多关于发布的内容请见第 29.1 节。
表 52.40. pg_publication 列
列类型
描述
oid oid
行标识符
pubname name
发布的名称
pubowner oid
(references pg_authid.oid)
发布的拥有者
puballtables bool
如果为真，这个publication自动包括数据库中的所有表，包括未来将会创建的任何表。
pubinsert bool
如果为真，INSERT操作会为publication中的表复制。
pubupdate bool
如果为真，UPDATE操作会为publication中的表复制。
pubdelete bool
如果为真，DELETE操作会为publication中的表复制。
pubtruncate bool
如果为真，TRUNCATE操作会为publication中的表复制。
pubviaroot bool
如果为真，叶分区上的操作将使用publication中提及的顶层分区祖先的标识和模式进行复制，而不是使用其自己的标识和模式。
pubgencols char
控制在没有发布列列表时如何处理生成列复制：
n = 不复制发布关联表中的生成列，
s = 复制发布关联表中的存储型生成列。
上一页 上一级 下一页52.39. pg_proc 起始页 52.41. pg_publication_namespace
