# 20.2. 用户名称映射

20.2. 用户名称映射
版本：
纠错本页面
搜索
目录导航
❮
❯
20.2. 用户名称映射 #
当使用像 Ident 或者 GSSAPI 之类的外部认证系统时，发起连接的操作系统用户名可能不同于要被使用的数据库用户（角色）。在这种情况下，一个用户名映射可被用来把操作系统用户名映射到数据库用户。要使用用户名映射，在pg_hba.conf的选项域指定map=map-name。此选项支持所有接收外部用户名的认证方法。由于不同的连接可能需要不同的映射，在pg_hba.conf中的map-name参数中指定要被使用的映射名，用以指示哪个映射用于每个个体连接。
用户名映射在 ident 映射文件中定义，默认情况下该文件名为
pg_ident.conf
并存储在集群的数据目录中。（不过，也可以将映射文件放置在其他位置；
请参阅ident_file配置参数。）
ident 映射文件包含以下通用格式的行：
map-name system-username database-username
include file
include_if_exists file
include_dir directory
注释、空白和行续接的处理方式与pg_hba.conf中的处理方式相同。
map-name是一个任意名称，用于在
pg_hba.conf中引用此映射。其他两个字段分别指定
一个操作系统用户名和一个匹配的数据库用户名。相同的
map-name可以重复使用，以在单个映射中指定多个用户映射。
至于pg_hba.conf，此文件中的行可以是包含指令，
遵循相同的规则。
在启动以及主服务器进程收到SIGHUP信号时，pg_ident.conf文件会被读取。
如果你在活动的系统上编辑了该文件，你将需要通知 postmaster（使用pg_ctl reload,调用SQL函数pg_reload_conf(), 或用kill -HUP）重新读取文件。
系统视图
pg_ident_file_mappings
可以帮助预先测试对pg_ident.conf文件的更改，或者在加载文件后未产生预期效果时诊断问题。
视图中具有非空error字段的行表示文件相应行中存在问题。
对于一个给定的操作系统用户可以对应多少个数据库用户，以及反之，均没有限制。
因此，映射中的条目应被理解为“此操作系统用户被允许以此数据库用户身份连接”，
而不是暗示它们是等价的。如果有任何映射条目将从外部认证系统获取的用户名与用户请求
连接的数据库用户名配对，则连接将被允许。值all可以用作
database-username，以指定如果
system-username匹配，则此用户被允许以任何现有的数据库用户身份
登录。引用all会使该关键字失去其特殊含义。
如果database-username以+字符开头，那么操作系统用户
可以以属于该角色的任何用户身份登录，这类似于在pg_hba.conf中以
+开头的用户名的处理方式。因此，+标记的含义是
“匹配直接或间接属于该角色的任何角色”，而没有+标记的
名称仅匹配特定的角色。引用以+开头的用户名会使+
失去其特殊含义。
如果 system-username 字段以斜杠（/）
开头，则该字段的其余部分将被视为正则表达式（有关
PostgreSQL 正则表达式语法的详情，请参阅
第 9.7.3.1 节）。正则表达式可以包含一个捕获组
（即带括号的子表达式）。与该捕获组匹配的系统用户名部分可以在
database-username 字段中用 \1
（反斜杠-1）引用，这样可以在一行中映射多个用户名，对于简单语法替换特别有用。
例如，以下条目：
mymap   /^(.*)@mydomain\.com$      \1
mymap   /^(.*)@otherdomain\.com$   guest
将删除系统用户名以 @mydomain.com 结尾的用户的域名部分，
并允许系统名以 @otherdomain.com 结尾的任何用户以
guest 身份登录。
对包含 \1 的 database-username
加引号不会使 \1 失去其特殊含义。
如果 database-username 字段以斜杠（/）
开头，则该字段的其余部分将被视为正则表达式。当
database-username 字段为正则表达式时，
不能在其中使用 \1 来引用
system-username 字段中的捕获组。
提示
记住在默认情况下，一个正则表达式可以只匹配字符串的一部分。通常，使用^和$来强制匹配整个系统用户名，如上例所示，是明智的。
例 20.2中展示了一个可以联合pg_hba.conf文件（例 20.1）使用的pg_ident.conf文件。在这个例子中，对于任何登入到 192.168 网络上的一台机器的用户，如果该用户没有操作系统用户名bryanh、ann或robert，则他不会被授予访问权限。只有当 Unix 用户robert尝试作为PostgreSQL用户bob（而不是作为robert或其他人）连接时，他才被允许访问。ann只被允许作为ann连接。用户bryanh被允许以bryanh或者guest1连接。
例 20.2. 一个示例 pg_ident.conf 文件
# MAPNAME       SYSTEM-USERNAME         PG-USERNAME
omicron         bryanh                  bryanh
omicron         ann                     ann
# bob 在这些机器上有用户名 robert
omicron         robert                  bob
# bryanh 也可以作为 guest1 连接
omicron         bryanh                  guest1
上一页 上一级 下一页20.1. pg_hba.conf 文件 起始页 20.3. 认证方法
