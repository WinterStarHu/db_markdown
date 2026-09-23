# pg_rewind

pg_rewind
版本：
纠错本页面
搜索
目录导航
❮
❯
pg_rewindpg_rewind — 将一个PostgreSQL数据目录与另一个从该目录中复制出来的数据目录同步大纲pg_rewind [option...]  { -D  |   --target-pgdata } directory { --source-pgdata=directory  |   --source-server=connstr } 描述
pg_rewind是用于在集簇的时间线分叉以后，同步一个 PostgreSQL 集簇和同一集簇的另一份拷贝的工具。一种典型的场景是在失效后让一个旧的主服务器重新上线，同时有一个备用机跟随着新的主机。
成功回放后，目标数据目录的状态类似于源数据目录的基本备份。与进行新的基本备份或使用rsync等工具不同，pg_rewind不需要比较或复制集群中未更改的关系块。仅复制现有关系文件中更改的块；所有其他文件（包括新的关系文件、配置文件和WAL段）都将被完整复制。因此，当数据库很大并且集群之间只有一小部分块不同时，回放操作比其他方法要快得多。
pg_rewind检查源集簇和目标集簇的时间线历史来判断它们在哪一点分叉，并且期望在目标集簇的pg_wal目录中找到 WAL 来返回到分叉点。分叉点可能会在目标时间线、源时间线或者它们的共同祖先上找到。在典型的失效场景中，目标集簇在分叉后很快就被关闭，这不是问题，但是如果目标集簇在分叉后已经运行了很长时间，旧的 WAL 文件可能已经不存在了。在这样的情况下，您可以手动将它们从WAL存档复制到pg_wal目录，或使用-c选项运行pg_rewind以自动从WAL存档检索它们。pg_rewind的使用并不限于失效的场景，例如一个备用服务器可能被提升、运行一些写事务，然后被回放再次成为一个备用。
在运行pg_rewind之后，需要完成WAL重放以使数据目录处于一致状态。当目标服务器再次启动时，它将进入归档恢复，并从分歧点之前的最后一个检查点重放源服务器中生成的所有 WAL。当pg_rewind被运行时有某些 WAL 在源服务器上不可用，并且因此无法被pg_rewind会话所复制，则在目标服务器被启动时必须让这些 WAL 可用。
这可以通过在目标数据目录中创建一个recovery.signal文件并且在postgresql.conf中配置适合的restore_command来实现。
pg_rewind要求目标服务器在 postgresql.conf 中启用
wal_log_hints 选项，或者在使用 initdb 初始化集群时启用数据校验和（默认）。
full_page_writes 也必须设置为 on，但默认情况下已启用。
警告：倒带时发生故障
如果在处理时pg_rewind失败，则目标的数据目录很可能不在可恢复的状态。在这种情况下，推荐创建一个新的备份。
由于 pg_rewind 完全从源复制配置文件，因此可能需要在重新启动目标服务器之前更正用于恢复的配置，特别是当目标服务器作为源的备用服务器重新引入时。如果在倒带操作完成后重新启动服务器但未配置恢复，则目标可能会再次与主服务器分离。
如果pg_rewind发现它无法直接写入的文件，它将立刻失败。例如当源服务器和目标服务器为只读的SSL密钥及证书使用相同的文件映射，就会发生这种情况。如果在目标服务器上存在这样的文件，推荐在运行pg_rewind之前移除它们。在倒带之后，一些这样的文件可能已经被从源服务器拷贝，这样就有必要移除已经拷贝的数据并且恢复到倒带之前使用的链接集合。
选项
pg_rewind接受以下命令行参数：
-D directory--target-pgdata=directory
此选项指定与源同步的目标数据目录。在运行pg_rewind之前，目标服务器必须干净地关闭。
--source-pgdata=directory
指定要与目标服务器同步的源服务器数据目录的文件系统路径。此选项要求源服务器被干净地关闭。
--source-server=connstr
指定一个libpq连接字符串，用于连接到源PostgreSQL服务器，以便将目标与之同步。
连接必须是一个普通（非复制）连接，具有足够权限执行pg_rewind在源服务器上使用的函数（有关详细信息，请参见备注部分）或超级用户角色。此选项要求源服务器正在运行并接受连接。
-R--write-recovery-conf
创建 standby.signal 并将连接
设置附加到 postgresql.auto.conf 中的输出
目录。只有在连接字符串或
环境变量 中明确指定了 dbname 时，dbname 才会被记录。
--source-server 是此选项的必需项。
-n--dry-run
除了实际修改目标目录之外，执行所有操作。
-N--no-sync
默认情况下，pg_rewind将等待所有文件安全写入磁盘。此选项导致pg_rewind在不等待的情况下返回，这样更快，但意味着随后的操作系统崩溃可能会导致数据目录损坏。通常，此选项对于测试很有用，但不应在生产安装中使用。
-P--progress
启用进度报告。打开此选项将在从源集群复制数据时提供一个近似的进度报告。
-c--restore-target-wal
使用目标集群配置中定义的restore_command来从WAL归档中检索WAL文件，
如果这些文件在pg_wal目录中不再可用。
--config-file=filename
使用指定的主服务器配置文件用于目标集群。这会影响pg_rewind，
当它在此集群上使用postgres命令进行倒带操作时
（在使用选项restore_command时
-c/--restore-target-wal和强制完成崩溃恢复时）。
--debug
打印详细的调试输出，主要用于开发人员调试pg_rewind。
--no-ensure-shutdown
pg_rewind要求在倒带之前目标服务器干净地关闭。
默认情况下，如果目标服务器没有干净地关闭，pg_rewind会启动目标服务器进入单用户模式，首先完成崩溃恢复，然后停止它。
通过传递此选项，pg_rewind会跳过此步骤，如果服务器没有干净地关闭，则立即报错。
用户应该自行处理这种情况。
--sync-method=method
当设置为fsync（默认值）时，pg_rewind将递归打开并同步数据目录中的所有文件。
对文件的搜索将遵循WAL目录和每个配置的表空间的符号链接。
在 Linux 上，可以使用 syncfs 来请求操作系统同步包含数据目录、
WAL 文件和每个表空间的整个文件系统。有关使用 syncfs 时需注意的
注意事项，请参见 recovery_init_sync_method。
当使用--no-sync时，此选项无效。
-V--version显示版本信息，然后退出。-?--help显示帮助，然后退出。
环境
在使用--source-server选项时，pg_rewind也使用libpq支持的环境变量（见第 32.15 节）。
环境变量PG_COLOR规定在诊断消息中是否使用颜色。可能的值为always、auto和never。
注释
当使用在线集簇作为源执行pg_rewind时，具有足够权限来执行pg_rewind在源集簇上使用的函数的角色可以用来代替超级用户。
这里介绍如何创建这样的角色，在这里命名rewind_user：
CREATE USER rewind_user LOGIN;
GRANT EXECUTE ON function pg_catalog.pg_ls_dir(text, boolean, boolean) TO rewind_user;
GRANT EXECUTE ON function pg_catalog.pg_stat_file(text, boolean) TO rewind_user;
GRANT EXECUTE ON function pg_catalog.pg_read_binary_file(text) TO rewind_user;
GRANT EXECUTE ON function pg_catalog.pg_read_binary_file(text, bigint, bigint, boolean) TO rewind_user;
工作原理
其基本思想是从源集簇拷贝所有文件系统级别的改变到目标集簇：
以源集簇的时间线历史从目标集簇分叉出来的点之前的最后一个检查点为起点，扫描目标集簇的WAL日志。对于每一个WAL记录，读取每一个被更改的数据块。这会得到在目标集簇中从源集簇被分支出去以后所有被更改过的数据块列表。如果某些WAL文件
不再可用，请尝试使用-c选项重新运行pg_rewind以在WAL存档中搜索丢失的文件。
使用直接的文件系统访问（--source-pgdata）或者SQL（--source-server），把所有那些更改过的块从源集簇拷贝到目标集簇。
关系文件现在的状态相当于源和目标的WAL时间线偏离点之前最后一个完成的检查点的时刻加上偏离点之后目标上更改的任何块的源上的当前状态。
复制所有其他文件，包括新的关系文件、WAL段、pg_xact和配置文件从源集簇到目标集簇。
类似于基本备份，目录pg_dynshmem/、pg_notify/、pg_replslot/、pg_serial/、pg_snapshots/、pg_stat_tmp/和pg_subtrans/的内容从源集簇复制的数据中省略。
文件backup_label、tablespace_map、pg_internal.init、postmaster.opts、postmaster.pid和.DS_Store以及任何以pgsql_tmp开头的文件或目录都被省略。
创建一个backup_label文件，在故障转移时创建的检查点处开始WAL重放，并将pg_control文件配置为最小一致性LSN，该LSN定义为从活动源回放时的pg_current_wal_insert_lsn()结果，或从停止的源回放时的最后一个检查点LSN。
启动目标时，PostgreSQL重放所有必需的WAL，从而使数据目录处于一致状态。
上一页 上一级 下一页pg_resetwal 起始页 pg_test_fsync
