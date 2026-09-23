# 52.49. pg_shdescription

52.49. pg_shdescription
版本：
纠错本页面
搜索
目录导航
❮
❯
52.49. pg_shdescription #
目录pg_shdescription存储共享数据库对象的可选描述（注释）。
描述可以通过COMMENT命令操作，并且可以使用psql的\d命令来查看。
另请参阅pg_description，它对单个数据库中对象之间的依赖提供了相似的功能。
与大部分其他系统目录不同，pg_shdescription在整个集簇的所有数据库之间共享：在每个集簇中只有一个pg_shdescription的拷贝，而不是每个数据库一份。
表 52.49. pg_shdescription 列
列类型
描述
objoid oid
(references any OID column)
描述所属对象的OID
classoid oid
(references pg_class.oid)
对象所述的系统目录的OID
description text
作为该对象描述的任意文本
上一页 上一级 下一页52.48. pg_shdepend 起始页 52.50. pg_shseclabel
