# pg_controldata

pg_controldata
版本：
纠错本页面
搜索
目录导航
❮
❯
pg_controldatapg_controldata — 显示一个PostgreSQL数据库集簇的控制信息大纲pg_controldata [option] [[ -D  |   --pgdata ]datadir]描述
pg_controldata打印在initdb期间初始化的信息，例如目录版本。它也显示关于预写式日志和检查点处理的信息。这种信息是集簇范围的，并且不针对任何一个数据库。
这个工具只能由初始化集簇的用户运行，因为它要求对数据目录的读访问。你可以在命令行中指定数据目录，或者使用环境变量PGDATA。这个工具支持选项-V和--version，它们打印pg_controldata版本并退出。它也支持选项-?和--help，它们输出支持的参数。
环境PGDATA
默认的数据目录位置。
PG_COLOR
规定在诊断消息中是否使用颜色。可能的值为always、auto和never。
上一页 上一级 下一页pg_checksums 起始页 pg_createsubscriber
