# 32.17. 连接服务文件

32.17. 连接服务文件
版本：
纠错本页面
搜索
目录导航
❮
❯
32.17. 连接服务文件 #
连接服务文件允许将 libpq 连接参数与单个服务名称关联。然后可以使用 service 关键字在 libpq 连接字符串中指定该服务名称，并将使用相关设置。这允许在不需要重新编译使用 libpq 的应用程序的情况下修改连接参数。服务名称还可以使用 PGSERVICE 环境变量指定。
服务名称可以在每个用户的服务文件或系统范围的文件中定义。如果同一个服务名称存在于用户文件和系统文件中，
则用户文件优先。默认情况下，每个用户的服务文件名为~/.pg_service.conf。
在Microsoft Windows上，它的名称为%APPDATA%\postgresql\.pg_service.conf
（其中%APPDATA%指用户配置文件夹中的应用数据子目录）。
可以通过设置环境变量PGSERVICEFILE来指定不同的文件名。
系统范围的文件名为pg_service.conf。
默认情况下，在PostgreSQL安装的etc目录中寻找
（使用pg_config --sysconfdir来准确识别此目录）。可以通过设置环境变量
PGSYSCONFDIR来指定另一个目录，但不能指定不同的文件名。
或者服务文件使用一种“INI 文件”格式，其中小节名是服务名并且参数是连接参数。
列表见第 32.1.2 节。例如：
# comment
[mydb]
host=somehost
port=5433
user=admin
在PostgreSQL安装的share/pg_service.conf.sample中提供了一个例子文件。
从服务文件中获取的连接参数与从其他来源获取的参数相结合。
服务文件设置覆盖相应的环境变量，然后反过来可以由连接字符串中直接给出的值覆盖。
例如，使用上面的服务文件，连接字符串service=mydb port=5434将使用主机somehost，端口5434，
用户admin，以及由环境变量或内置默认所设置的其他参数。
上一页 上一级 下一页32.16. 密码文件 起始页 32.18. 连接参数的 LDAP 查找
