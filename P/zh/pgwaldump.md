# pg_waldump

pg_waldump
版本：
纠错本页面
搜索
目录导航
❮
❯
pg_waldumppg_waldump — 以人类可读的形式显示一个PostgreSQL
数据库集群的预写式日志大纲pg_waldump [option...] [startseg [endseg]]描述
pg_waldump显示预写式日志（WAL），它主要
用于调试或教育目的。
这个工具只能由安装该服务器的用户运行，因为它要求对数据目录的只读访问。
选项
以下命令行选项控制输出的位置和格式：
startseg
从指定的WAL段文件开始读取。这隐式地确定了将搜索文件的路径，
以及要使用的时间线。
endseg
在读取指定的WAL段文件后停止。
-b--bkp-details
输出有关备份块的详细信息。
-B block--block=block
仅显示修改给定块的记录。关系还必须提供--relation或
-R。
-e end--end=end
在指定的WAL位置停止读取，而不是读取到日志流的末尾。
-f--follow
在到达有效WAL的末尾后，每秒轮询一次，直到新的WAL出现。
-F fork--fork=fork
仅显示修改给定分支中块的记录。有效值为main表示主分支，
fsm表示空闲空间映射，
vm表示可见性映射，
以及init表示初始化分支。
-n limit--limit=limit
显示指定数量的记录，然后停止。
-p path--path=path
指定一个目录用于搜索WAL段文件，或者一个包含这些文件的
pg_wal子目录的目录。默认情况下，会在当前
目录、当前目录的pg_wal子目录以及
PGDATA的pg_wal子目录中搜索。
-q--quiet
不要打印任何输出，除非出现错误。当您想知道一系列WAL记录是否可以成功解析，但不关心记录内容时，此选项可能很有用。
-r rmgr--rmgr=rmgr
仅显示由指定资源管理器生成的记录。您可以多次指定该选项以选择多个资源管理器。
如果list作为名称传递，则打印有效资源管理器名称列表，并退出。
扩展可能定义自定义资源管理器，但
pg_waldump不会加载扩展模块，因此不会识别自定义
资源管理器的名称。相反，您可以将自定义资源管理器指定为
custom###，其中
###是三位数的资源管理器ID。
这种形式的名称将始终被视为有效。
-R tblspc/db/rel--relation=tblspc/db/rel
仅显示修改给定关系中的块的记录。关系由表空间OID、数据库OID和relfilenode以斜杠分隔指定，例如1234/12345/12345。
这与程序输出中关系使用的格式相同。
-s start--start=start
开始读取的WAL位置。默认情况下，从找到的最早文件中找到的第一个有效
WAL记录开始读取。
-t timeline--timeline=timeline
要读取WAL记录的时间线。默认情况下，如果指定了
startseg的值，则使用该值；否则，默认值为1。
该值可以用十进制或十六进制指定，例如17或
0x11。
-V--version
打印pg_waldump的版本并退出。
-w--fullpage
仅显示包含完整页面图像的记录。
-x xid--xid=xid
仅显示标记有给定事务ID的记录。
-z--stats[=record]
显示摘要统计信息（记录数量和大小以及全页图像），而不是单个记录。可选择
生成每个记录而不是每个rmgr的统计信息。
如果pg_waldump被信号SIGINT
(Control+C)终止，
则计算的统计摘要显示到终止点。此操作在Windows上不受支持。
--save-fullpage=save_path
将WAL记录中找到的完整页面图像保存到
save_path目录中。保存的图像
受与显示的记录相同的过滤和限制条件的约束。
全页图像保存为以下文件名格式：
TIMELINE-LSN.
RELTABLESPACE.DATOID.
RELNODE.BLKNO_
FORK
文件名由以下部分组成：
组件描述TIMELINE记录所在的WAL段文件的时间线，格式为一个8字符的十六进制
数字%08XLSN包含此图像的记录的LSN，格式为两个8字符的
十六进制数字%08X-%08XRELTABLESPACE块的表空间OIDDATOID块的数据库OIDRELNODE块的文件节点BLKNO块的块号FORK
全页图像来源的分叉名称，例如main、
fsm、vm或init。
-?--help
显示关于pg_waldump命令行参数的帮助信息，并退出。
环境PGDATA
数据目录；另请参阅 -p 选项。
PG_COLOR
规定在诊断消息中是否使用颜色。可能的值为always、auto和never。
注释
当服务器正在运行时可能会给出错误的结果。
只有指定的时间线会被显示（如果没有指定，则显示默认时间线）。
其他时间线上的记录会被忽略。
pg_waldump不能读取具有后缀.partial
的WAL文件。如果需要读取那些文件，需要从文件名中移除
.partial后缀。
另见第 28.6 节上一页 上一级 下一页pg_upgrade 起始页 pg_walsummary
