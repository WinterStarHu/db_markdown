# 52.46. pg_seclabel

52.46. pg_seclabel
版本：
纠错本页面
搜索
目录导航
❮
❯
52.46. pg_seclabel #
目录pg_seclabel存储数据库对象上的安全标签。
安全标签可以通过SECURITY LABEL命令进行操作。
更简单的查看安全标签的方法请见第 53.23 节。
同时请见pg_shseclabel，
它对集簇中共享的数据库对象的安全标签执行相似的功能。
表 52.46. pg_seclabel 列
列类型
描述
objoid oid
(引用任意OID列)
该安全标签所涉及对象的OID
classoid oid
(引用pg_class.oid)
该对象所在系统目录的OID
objsubid int4
对于一个在表列上的安全标签，这将是列号（objoid和classoid指表本身）。对于所有其他对象类型，本列为0。
provider text
与该标签相关的提供者标签。
label text
应用于该对象的安全标签。
上一页 上一级 下一页52.45. pg_rewrite 起始页 52.47. pg_sequence
