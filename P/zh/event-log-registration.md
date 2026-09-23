# 18.12. 在Windows上注册事件日志

18.12. 在Windows上注册事件日志
版本：
纠错本页面
搜索
目录导航
❮
❯
18.12. 在Windows上注册事件日志 #
要为操作系统注册一个Windows 事件日志库，发出这个命令：
regsvr32 pgsql_library_directory/pgevent.dll
这会创建被事件查看器使用的注册表项，默认事件源命名为PostgreSQL。
要指定一个不同的事件源名称（见event_source），使用/n和/i选项：
regsvr32 /n /i:event_source_name pgsql_library_directory/pgevent.dll
要从操作系统注销事件日志库，发出这个命令：
regsvr32 /u [/i:event_source_name] pgsql_library_directory/pgevent.dll
注意
要启用数据库服务器中的事件日志，在postgresql.conf中修改log_destination以包括eventlog。
上一页 上一级 下一页18.11. 使用SSH隧道的安全 TCP/IP 连接 起始页 第 19 章 服务器配置
