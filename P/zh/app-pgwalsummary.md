# pg_walsummary

pg_walsummary
版本：
纠错本页面
搜索
目录导航
❮
❯
pg_walsummarypg_walsummary — 打印 WAL 摘要文件的内容大纲pg_walsummary [option...] [file...]描述
pg_walsummary 用于打印 WAL 汇总文件的内容。这些二进制文件位于数据目录的
pg_wal/summaries 子目录中，可以使用此工具将其转换为文本。通常不需要这样做，
因为 WAL 汇总文件主要用于支持
增量备份，
但这可能对调试有用。
WAL 摘要文件按表空间 OID、关系 OID 和关系分叉进行索引。对于每个关系分叉，
它存储了在文件总结的范围内由 WAL 修改的块列表。它还可以存储一个“限制块”，
如果关系分叉是在相关 WAL 范围内创建或截断的，则该值为 0，否则为关系分叉
被截断到的最短长度。如果关系分叉未在相关 WAL 范围内被创建、删除或截断，
则限制块未定义或为无限，且该工具不会打印该值。
选项
-i--individual
默认情况下，pg_walsummary为每个一个或多个连续修改块的范围
打印一行输出。这可以使输出简洁得多，因为一个从 0 到 999 所有块都被修改的关系
只会产生一行输出，而不是 1000 行单独的输出。此选项请求为每个修改的块输出
单独的一行。
-q--quiet
不打印任何输出，除非有错误。这在你想知道 WAL 摘要文件是否能成功解析但不关心
内容时非常有用。
-V--version
显示版本信息，然后退出。
-?--help
显示关于 pg_walsummary 命令行参数的帮助信息，然后退出。
环境
环境变量PG_COLOR指定是否在诊断消息中使用颜色。
可能的值是always、auto和
never。
另请参阅pg_basebackup, pg_combinebackup上一页 上一级 下一页pg_waldump 起始页 postgres
