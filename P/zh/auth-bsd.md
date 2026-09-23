# 20.14. BSD 认证

20.14. BSD 认证
版本：
纠错本页面
搜索
目录导航
❮
❯
20.14. BSD 认证 #
这种认证方法操作起来类似于password，不过它使用 BSD 认证来验证密码。BSD 认证只被用来验证用户名/密码对。因此，在 BSD 认证可以被用于认证之前，用户的角色必须已经存在于数据库中。BSD 认证框架当前只在 OpenBSD 上可用。
PostgreSQL中的 BSD 认证使用auth-postgresql登录类型，如果login.conf中定义了postgresql登录类，就会用它来认证。默认情况下这种登录类不存在，PostgreSQL将使用默认的登录类。
注意
要使用 BSD 认证，PostgreSQL 用户账号（也就是运行服务器的操作系统用户）必须首先被加入到auth组中。在 OpenBSD 系统上默认存在auth组。
上一页 上一级 下一页20.13. PAM 认证 起始页 20.15. OAuth 授权/认证
