# 52.50. pg_shseclabel

52.50. pg_shseclabel
版本：
纠错本页面
搜索
目录导航
❮
❯
52.50. pg_shseclabel #
目录pg_shseclabel存储共享数据库对象上的安全标签。
安全标签可以通过SECURITY LABEL命令操纵。
更简单的查看安全标签的方式请见第 53.23 节。
另请参阅pg_seclabel，它对单个数据库中对象的安全标签提供了相似的功能。
与大部分其他系统目录不同，pg_shseclabel在整个集簇的所有数据库之间共享：在每个集簇中只有一个pg_shseclabel的拷贝，而不是每个数据库一份。
表 52.50. pg_shseclabel Columns
列类型
描述
objoid oid
(参考任意OID列)
该安全标签所涉及对象的OID
classoid oid
(references pg_class.oid)
对象所述的系统目录的OID
provider text
与该标签相关的标签提供者。
label text
应用于该对象的安全标签。
上一页 上一级 下一页52.49. pg_shdescription 起始页 52.51. pg_statistic
