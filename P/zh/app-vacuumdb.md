# vacuumdb

vacuumdb
版本：
纠错本页面
搜索
目录导航
❮
❯
vacuumdbvacuumdb — 对一个PostgreSQL数据库进行垃圾收集和分析大纲vacuumdb [connection-option...] [option...]
[
-t  |   --table
table
[( column [,...] )]
]
...  [
dbname  |   -a  |   --all
]vacuumdb [connection-option...] [option...]
[
-n  |   --schema
schema
]
...  [
dbname  |   -a  |   --all
]vacuumdb [connection-option...] [option...]
[
-N  |   --exclude-schema
schema
]
...  [
dbname  |   -a  |   --all
]描述
vacuumdb是用于清理一个PostgreSQL数据库的工具。vacuumdb也将产生由PostgreSQL查询优化器所使用的内部统计信息。
vacuumdb是 SQL 命令VACUUM的一个包装器。
在通过这个工具和其他方法访问服务器来清理和分析数据库之间没有实质性的区别。
选项
vacuumdb接受以下命令行参数:
-a--all
清理所有数据库。
--buffer-usage-limit size
指定
缓冲区访问策略
的环形缓冲区大小，用于一次vacuumdb
的调用。此大小用于计算作为该策略一部分将被重用的共享缓冲区数量。
请参阅VACUUM。
[-d] dbname[--dbname=]dbname
指定要清理或分析的数据库名称，当未使用-a/--all时。
如果未指定，则从环境变量PGDATABASE中读取数据库名称。
如果未设置该变量，则使用连接指定的用户名。
dbname可以是一个连接字符串。
如果是这样，连接字符串参数将覆盖任何冲突的命令行选项。
--disable-page-skipping
禁用根据可见性图内容跳过页面。
-e--echo
回显vacuumdb生成并发送到服务器的命令。
-f--full
执行“完全”清理。
-F--freeze
“积极地”冻结元组。
--force-index-cleanup
始终删除指向无效元组的索引条目。
-j njobs--jobs=njobs
并行运行njobs命令来执行vacuum或analyze命令。
该选项可能会减少处理时间，但也会增加数据库服务器的负载。
vacuumdb将打开njobs个连接到数据库，
因此请确保您的max_connections设置足够高，以容纳所有连接。
请注意，如果将此模式与-f（FULL）选项一起使用，
在处理某些系统目录时可能会导致死锁故障。
--min-mxid-age mxid_age
只对具有至少mxid_age的多重事务ID年龄的表执行vacuum或analyze命令。
此设置对于优先处理表以防止多重事务ID环绕（参见第 24.1.5.1 节）非常有用。
对于此选项，关系的多重事务ID年龄是主关系及其关联的TOAST表的年龄中的最大值，如果存在的话。
由于vacuumdb发出的命令也将在必要时处理关系的TOAST表，因此不需要单独考虑。
--min-xid-age xid_age
只对事务ID年龄至少为xid_age的表执行vacuum或analyze命令。
此设置对于优先处理表以防止事务ID环绕（参见第 24.1.5 节）非常有用。
对于此选项而言，关系的事务ID年龄是主关系及其关联的TOAST表的年龄中的最大值，如果存在的话。
由于vacuumdb发出的命令也会在必要时处理关系的TOAST表，因此不需要单独考虑。
--missing-stats-only
仅分析缺少列、索引表达式或扩展统计对象统计信息的关系。
当与 --analyze-in-stages 一起使用时，此选项防止
vacuumdb 暂时用生成的低统计目标替换现有统计信息，
从而避免瞬时较差的查询优化器选择。
此选项只能与 --analyze-only 或 --analyze-in-stages 一起使用。
请注意 --missing-stats-only 需要
SELECT 权限在
pg_statistic
和
pg_statistic_ext_data 上，
这些权限默认仅限于超级用户。
-n schema--schema=schema
仅清理或分析
schema中的所有表。可以通过编写多个
-n开关来清理多个模式。
-N schema--exclude-schema=schema
不要清理或分析
schema中的任何表。可以通过编写多个
-N开关来排除多个模式。
--no-index-cleanup
不要删除指向无效元组的索引条目。
--no-process-main
跳过主要关系。
--no-process-toast
跳过与要清理的表相关联的 TOAST 表，如果有的话。
--no-truncate
不要在表末尾截断空白页。
-P parallel_workers--parallel=parallel_workers
指定并行清理的并行工作者数量。
这允许清理利用多个 CPU 来处理索引。
参见VACUUM。
-q--quiet
不显示进度消息。
--skip-locked
跳过无法立即锁定进行处理的关系。
-t table [ (column [,...]) ]--table=table [ (column [,...]) ]
仅清理或分析table。
列名只能与--analyze或--analyze-only选项一起指定。
通过写多个-t开关，可以对多个表进行清理。
提示
如果您指定了列，可能需要从shell中转义括号。(请参见下面的示例。)
-v--verbose
在处理过程中打印详细信息。
-V--version
打印vacuumdb版本并退出。
-z--analyze
也计算用于优化器的统计信息。
-Z--analyze-only
仅为优化器计算统计信息（不执行清理）。
--analyze-in-stages
仅为优化器计算统计信息（不执行清理），类似于--analyze-only。
运行三个分析阶段；第一个阶段使用最低可能的统计目标（参见default_statistics_target）
更快地生成可用的统计信息，随后的阶段构建完整的统计信息。
此选项仅在分析当前没有统计信息或完全不正确的数据库时才有用，例如如果它是从恢复的转储文件或通过pg_upgrade新填充的。
请注意，在具有现有统计信息的数据库中运行此选项可能会导致查询优化器选择在早期阶段的低统计目标下变得短暂更差。
-?--help
显示关于vacuumdb命令行参数的帮助信息，并退出。
vacuumdb 也接受以下用于连接参数的命令行参数：
-h host-−host=host
指定服务器运行所在机器的主机名。如果值以斜杠开头，则用作
Unix 域套接字的目录。
-p port-−port=port
指定服务器监听连接的 TCP 端口或本地 Unix 域套接字文件扩展名。
-U username-−username=username
用于连接的用户名。
-w-−no-password
永不提示输入密码。如果服务器要求密码认证且没有通过
其他方式（如.pgpass文件）提供密码，
连接尝试将失败。此选项在批处理作业和脚本中很有用，
因为没有用户输入密码。
-W-−password
强制vacuumdb在连接数据库前提示输入密码。
该选项通常不是必需的，因为vacuumdb会在服务器
需要密码认证时自动提示输入密码。但vacuumdb会
先尝试连接，发现服务器需要密码后才提示，这会浪费一次连接尝试。
在某些情况下，输入-W可以避免额外的连接尝试。
-−maintenance-db=dbname
当使用-a/-−all时，连接到此数据库以获取
需要清理的数据库列表。如果未指定，则使用postgres数据库，
如果该数据库不存在，则使用template1。这可以是一个
连接字符串。如果是，连接字符串参数
会覆盖任何冲突的命令行选项。此外，除数据库名外的连接字符串参数
会在连接其他数据库时重用。
环境PGDATABASEPGHOSTPGPORTPGUSER
默认连接参数
PG_COLOR
规定在诊断消息中是否使用颜色。可能的值为always、auto和never。
和大部分其他PostgreSQL工具相似，这个工具也使用libpq（见第 32.15 节）支持的环境变量。
诊断
在遇到困难时，可以在VACUUM和psql中找潜在问题和错误消息的讨论。数据库服务器必须运行在目标主机上。同样，任何libpq前端库使用的默认连接设置和环境变量都将适用于此。
示例
要清理数据库test：
$ vacuumdb test
要清理和为优化器分析一个名为bigdb的数据库：
$ vacuumdb --analyze bigdb
要清理在名为xyzzy的数据库中的一个表foo，并为优化器分析该表的bar列：
$ vacuumdb --analyze --verbose --table='foo(bar)' xyzzy
要清理数据库中名为xyzzy的foo和bar模式中的所有表：
$ vacuumdb --schema='foo' --schema='bar' xyzzy
另请参阅VACUUM上一页 上一级 下一页reindexdb 起始页 PostgreSQL 服务器应用程序
