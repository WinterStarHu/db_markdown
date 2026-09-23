# 32.18. 连接参数的 LDAP 查找

32.18. 连接参数的 LDAP 查找
版本：
纠错本页面
搜索
目录导航
❮
❯
32.18. 连接参数的 LDAP 查找 #
如果libpq已经在编译时打开了 LDAP 支持（configure的选项--with-ldap），就可以通过 LDAP 从一个中央服务器检索host或dbname之类的连接参数。这样做的好处是如果一个数据库的连接参数改变，不需要在所有的客户端机器上更新连接信息。
LDAP连接参数查找使用连接服务文件pg_service.conf（参见第 32.17 节）。
在pg_service.conf段落中以ldap://开头的行将被识别为LDAP URL，并执行LDAP查询。
结果必须是一组keyword = value对，将用于设置连接选项。
URL必须符合RFC 1959的形式为
ldap://[hostname[:port]]/search_base?attribute?search_scope?filter
其中hostname默认为localhost，port默认为389。
一次成功的 LDAP 查找后，pg_service.conf的处理被终止。但是如果联系不上 LDAP 则会继续处理pg_service.conf。这就提供了后手，可以加入更多指向不同 LDAP 服务器的 LDAP URL 行、经典的keyword = value对或者默认连接选项。如果你宁愿在这种情况下得到一个错误消息，在该 LDAP URL 之后增加一个语法错误的行。
一个和 LDIF 文件一起创建的 LDAP 条目实例
version:1
dn:cn=mydatabase,dc=mycompany,dc=com
changetype:add
objectclass:top
objectclass:device
cn:mydatabase
description:host=dbserver.mycompany.com
description:port=5439
description:dbname=mydb
description:user=mydb_user
description:sslmode=require
可以用下面的 LDAP URL 查询：
ldap://ldap.mycompany.com/dc=mycompany,dc=com?description?one?(cn=mydatabase)
你也可以将常规的服务文件条目和 LDAP 查找混合。pg_service.conf中一节的完整例子：
# 只有主机和端口存储在LDAP中，显式指定dbname和user。
[customerdb]
dbname=customer
user=appuser
ldap://ldap.acme.com/cn=dbserver,cn=hosts?pgconnectinfo?base?(objectclass=*)
上一页 上一级 下一页32.17. 连接服务文件 起始页 32.19. SSL 支持
