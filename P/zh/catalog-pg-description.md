# 52.19. pg_description

52.19. pg_description
版本：
纠错本页面
搜索
目录导航
❮
❯
52.19. pg_description #
目录pg_description存储对每一个数据库对象可选的描述（注释）。
描述可以通过COMMENT操作，并可使用psql的\d命令查看。
在pg_description的初始内容中提供了很多内建系统对象的描述。
参见pg_shdescription，它对在一个数据库集簇中共享的对象的描述提供了相似的功能。
表 52.19. pg_description 列
列类型
描述
objoid oid
(references any OID column)
描述所属对象的OID
classoid oid
(references pg_class.oid)
对象所述的系统目录的OID
objsubid int4
对于一个表列上的一个注释，这里是列号（objoid和classoid指表本身）。对所有其他对象类型，此列为0。
description text
作为该对象描述的任意文本
上一页 上一级 下一页52.18. pg_depend 起始页 52.20. pg_enum
