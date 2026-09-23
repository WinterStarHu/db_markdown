# pg_test_fsync

pg_test_fsync
版本：
纠错本页面
搜索
目录导航
❮
❯
pg_test_fsyncpg_test_fsync — 为PostgreSQL判断最快的 wal_sync_method大纲pg_test_fsync [option...]描述
pg_test_fsync是想告诉你在特定的系统上，哪一种
wal_sync_method最快，还可以在发生认定的 I/O
问题时提供诊断信息。不过，pg_test_fsync
显示的区别可能不会在真实的数据库吞吐量上产生显著的区别，特别是由于
很多数据库服务器被它们的预写日志限制了速度。
pg_test_fsync为
wal_sync_method报告以微秒计的平均文件同步操作时间，
也能被用来提示用于优化commit_delay值的方法。
选项
pg_test_fsync接受下列命令行选项：
-f--filename
指定要写入测试数据到其中的文件名。这个文件必须位于和
pg_wal目录所在或者将被放置的同一个文件系统中（
pg_wal包含WAL文件）。默认是当前
目录中的pg_test_fsync.out。
-s--secs-per-test
指定每次测试的秒数。每个测试的时间越长，测试的精度就越高，但是
它需要更多时间来运行。默认是 5 秒，这允许程序在 2 分钟以内完成。
-V--version
打印pg_test_fsync版本并且退出。
-?--help
显示有关pg_test_fsync命令行参数的帮助并且退出。
环境
环境变量PG_COLOR指定是否在诊断消息中使用颜色。可能的值为
always、auto 和
never。
另请参见postgres上一页 上一级 下一页pg_rewind 起始页 pg_test_timing
