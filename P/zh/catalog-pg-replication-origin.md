# 52.44. pg_replication_origin

52.44. pg_replication_origin
版本：
纠错本页面
搜索
目录导航
❮
❯
52.44. pg_replication_origin #
pg_replication_origin目录包含所有已创建的复制源。更多复制源的信息请见第 48 章。
和大部分系统目录不同，pg_replication_origin在一个集簇的所有数据库之间共享：每个集簇只有一份pg_replication_origin拷贝，而不是每个数据库一份。
表 52.44. pg_replication_origin 列
列类型
描述
roident oid
一个唯一的集簇范围内标识符，用于复制源。应该绝不会脱离系统。
roname text
外部的用户定义的复制源名称。
上一页 上一级 下一页52.43. pg_range 起始页 52.45. pg_rewrite
