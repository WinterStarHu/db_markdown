# 19.18. 短选项

19.18. 短选项
版本：
纠错本页面
搜索
目录导航
❮
❯
19.18. 短选项 #
为了方便起见，系统中还为一些参数提供了单字母的命令行选项开关。它们在表 19.5中描述。其中一些选项是由于历史原因而存在，并且它们作为一个单字母选项存在并不表示它们会被大量使用。
表 19.5. 短选项键短选项等效-B xshared_buffers = x-d xlog_min_messages = DEBUGx-edatestyle = euro
-fb, -fh, -fi,
-fm, -fn, -fo,
-fs, -ft
enable_bitmapscan = off,
enable_hashjoin = off,
enable_indexscan = off,
enable_mergejoin = off,
enable_nestloop = off,
enable_indexonlyscan = off,
enable_seqscan = off,
enable_tidscan = off
-Ffsync = off-h xlisten_addresses = x-ilisten_addresses = '*'-k xunix_socket_directories = x-lssl = on-N xmax_connections = x-Oallow_system_table_mods = on-p xport = x-Pignore_system_indexes = on-slog_statement_stats = on-S xwork_mem = x-tpa, -tpl, -telog_parser_stats = on,
log_planner_stats = on,
log_executor_stats = on-W xpost_auth_delay = x上一页 上一级 下一页19.17. 开发者选项 起始页 第 20 章 客户端认证
