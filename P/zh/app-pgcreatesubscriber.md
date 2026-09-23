# pg_createsubscriber

pg_createsubscriber
版本：
纠错本页面
搜索
目录导航
❮
❯
pg_createsubscriberpg_createsubscriber — 将物理副本转换为新的逻辑副本大纲pg_createsubscriber [option...]  { -d  |   --database }dbname { -D   |   --pgdata }datadir { -P  |   --publisher-server }connstr 描述
pg_createsubscriber 创建一个新的逻辑副本，来源于物理备用服务器。
指定数据库中的所有表都包含在逻辑复制设置中。
每个数据库都会创建一对发布和订阅对象。该命令必须在目标服务器上运行。
运行成功后，目标服务器的状态类似于一个全新的逻辑复制设置。逻辑复制设置与
pg_createsubscriber 之间的主要区别在于数据同步的方式。
pg_createsubscriber 不会复制初始表数据。它只执行同步阶段，
确保每个表都达到同步状态。
pg_createsubscriber 主要针对大型数据库系统，因为在逻辑复制设置中，
大部分时间都花费在初始数据复制上。此外，长时间同步数据的一个副作用通常是需要应用大量
变更（这些变更是在初始数据复制期间产生的），这进一步延长了逻辑副本可用的时间。对于较小的
数据库，建议通过初始数据同步来设置逻辑复制。详情请参见
CREATE SUBSCRIPTION
copy_data 选项。
选项
pg_createsubscriber 接受以下命令行参数：
-a--all
在目标服务器上为每个数据库创建一个订阅。例外情况是模板数据库和不允许连接的数据库。
要发现所有数据库的列表，请使用在 --publisher-server
连接字符串中指定的数据库名称连接到源服务器，或者如果未指定，将使用
postgres 数据库，如果该数据库不存在，将使用
template1。
当指定此选项时，将使用自动生成的订阅、出版物和复制槽名称。
此选项不能与 --database、--publication、
--replication-slot 或 --subscription 一起使用。
-d dbname--database=dbname
要在其中创建订阅的数据库名称。可以通过编写多个 -d
开关来选择多个数据库。此选项不能与 -a 一起使用。
如果未提供 -d 选项，则将从 -P 选项中获取数据库名称。
如果在 -d 选项或 -P 选项中都未指定数据库名称，并且未指定
-a 选项，则将报告错误。
-D directory--pgdata=directory
目标目录，包含来自物理副本的集簇目录。
-n--dry-run
除了实际修改目标目录之外，执行所有操作。
-p port--subscriber-port=port
目标服务器监听连接的端口号。默认情况下，目标服务器运行在50432端口，
以避免意外的客户端连接。
-P connstr--publisher-server=connstr
连接到发布者的连接字符串。详情请参见 第 32.1.1 节。
-s dir--socketdir=dir
用于目标服务器上 postmaster 套接字的目录。默认是当前目录。
-t seconds--recovery-timeout=seconds
恢复结束的最大等待秒数。设置为 0 表示禁用。默认值为 0。
-T--enable-two-phase
启用 two_phase
提交以进行订阅。当指定多个数据库时，此选项适用于在这些数据库上创建的所有订阅。
默认值为 false。
-U username--subscriber-username=username
连接到目标服务器时使用的用户名。默认为当前操作系统用户名称。
-v--verbose
启用详细模式。 这将使
pg_createsubscriber 输出进度消息和有关每个步骤的详细信息到标准错误。
重复使用该选项会导致更多调试级别的消息出现在标准错误中。
--clean=objtype
从目标服务器上指定的数据库中删除指定类型的所有对象。
publications:
为此订阅者建立的 FOR ALL TABLES 出版物将始终被删除；
指定此对象类型会导致从源服务器复制的所有其他出版物也被删除。
选择要删除的对象会被单独记录，包括在 --dry-run 期间。
没有机会影响或停止所选对象的删除，因此请考虑使用
pg_dump 对它们进行备份。
--config-file=filename
使用指定的主服务器配置文件作为目标数据目录。pg_createsubscriber内部使用
pg_ctl命令来启动和停止目标服务器。它允许您指定实际的
postgresql.conf配置文件（如果它存储在数据目录之外）。
--publication=name
用于设置逻辑复制的出版物名称。可以通过编写多个
--publication 开关来指定多个出版物。
出版物名称的数量必须与指定数据库的数量匹配，否则将报告错误。
多个出版物名称开关的顺序必须与数据库开关的顺序匹配。
如果未指定此选项，则将为出版物名称分配一个生成的名称。此选项不能与
--all 一起使用。
--replication-slot=name
用于设置逻辑复制的复制槽名称。可以通过编写多个
--replication-slot 开关来指定多个复制槽。
复制槽名称的数量必须与指定数据库的数量匹配，否则将报告错误。
多个复制槽名称开关的顺序必须与数据库开关的顺序匹配。
如果未指定此选项，则将订阅名称分配给复制槽名称。此选项不能与
--all 一起使用。
--subscription=name
用于设置逻辑复制的订阅名称。可以通过编写多个
--subscription 开关来指定多个订阅。
订阅名称的数量必须与指定数据库的数量匹配，否则将报告错误。
多个订阅名称开关的顺序必须与数据库开关的顺序匹配。
如果未指定此选项，则将为订阅名称分配一个生成的名称。此选项不能与
--all 一起使用。
-V--version
打印pg_createsubscriber的版本并退出。
-?--help
显示关于pg_createsubscriber命令行参数的帮助信息，
然后退出。
笔记先决条件
有一些先决条件需要满足，才能使
pg_createsubscriber 将目标服务器转换为逻辑副本。
如果这些条件未满足，将会报告错误。源服务器和目标服务器必须与
pg_createsubscriber 具有相同的主版本号。指定的目标数据
目录必须与源数据目录具有相同的系统标识符。为目标数据目录指定的数据库用户必须
具有创建订阅和使用pg_replication_origin_advance()的权限。
目标服务器必须用作物理备用。目标服务器必须配置 max_active_replication_origins 和 max_logical_replication_workers 的值大于或等于指定数据库的数量。
目标服务器必须配置 max_worker_processes 的值大于指定数据库的数量。
目标服务器必须接受本地连接。如果您计划使用 --enable-two-phase 开关，
则还需要适当地设置 max_prepared_transactions。
源服务器必须接受来自目标服务器的连接。源服务器不得处于恢复状态。源服务器必须将
wal_level 设置为 logical。源服务器必须将
max_replication_slots 配置为大于或等于指定数据库数量加上现有复制
插槽数量的值。源服务器必须将 max_wal_senders 配置为大于或等于
指定数据库数量和现有 WAL 发送进程数量的值。
警告
如果 pg_createsubscriber 在目标服务器提升后失败，
则数据目录很可能处于无法恢复的状态。在这种情况下，建议创建一个新的备用服务器。
pg_createsubscriber 通常在转换过程中以不同的连接设置启动目标
服务器。因此，连接到目标服务器应该会失败。
由于 DDL 命令不会被逻辑复制复制，因此在运行
pg_createsubscriber 时，避免执行更改数据库模式的 DDL 命令。
如果目标服务器已经转换为逻辑副本，DDL 命令可能不会被复制，这可能会导致错误。
如果 pg_createsubscriber 在处理时失败，源服务器上创建的对象（发布、复制槽）将被移除。
如果目标服务器无法连接到源服务器，移除操作可能会失败。在这种情况下，会有警告信息提示剩余的对象。
如果目标服务器正在运行，它将被停止。
如果复制使用的是 primary_slot_name，则在逻辑复制设置完成后，
它将从源服务器中移除。
如果目标服务器是同步副本，主服务器上的事务提交可能会在运行
pg_createsubscriber 时等待复制完成。
除非指定 --enable-two-phase 开关，
pg_createsubscriber 将设置逻辑复制，禁用两阶段提交。
这意味着任何准备好的事务将在 COMMIT PREPARED 时复制，而无需提前准备。
设置完成后，您可以手动删除并重新创建订阅，
启用 two_phase
选项。
pg_createsubscriber 使用 pg_resetwal 更改系统标识符。
它可以避免目标服务器可能使用源服务器的 WAL 文件的情况。如果目标服务器有备用，
复制将中断，应创建一个新的备用服务器。
如果缺少所需的 WAL 文件，可能会发生复制失败。为防止这种情况，源服务器必须将
max_slot_wal_keep_size 设置为 -1，以确保所需的 WAL 文件不会被提前删除。
如何工作
基本思路是从源服务器设置一个复制起点，并建立一个逻辑复制从该点开始：
使用指定的命令行选项启动目标服务器。如果目标服务器已经在运行，
pg_createsubscriber 将会以错误终止。
检查目标服务器是否可以转换。对源服务器也有一些检查。如果任何先决条件未满足，
pg_createsubscriber 将以错误终止。
在源服务器上为每个指定的数据库创建发布和复制槽。每个发布都使用
FOR ALL
TABLES 创建。如果未指定 --publication 选项，
则发布的名称模式如下：
“pg_createsubscriber_%u_%x”（参数：数据库
oid，随机数 int）。如果未指定
--replication-slot 选项，则复制槽的名称模式如下：
“pg_createsubscriber_%u_%x”（参数：数据库
oid，随机数 int）。这些复制槽将在
后续步骤中由订阅使用。最后的复制槽 LSN 用作 recovery_target_lsn
参数中的停止点，并被订阅用作复制的起始点。它保证不会丢失任何事务。
将恢复参数写入目标数据目录并重启目标服务器。它指定了一个写前日志位置的LSN（
recovery_target_lsn），恢复将进行到该位置。它还指定了
promote作为服务器在达到恢复目标后应采取的操作。额外的
恢复参数被添加以避免恢复过程中的
意外行为，例如一旦达到一致状态就结束恢复（WAL应应用到复制起始位置）以及可能导致失败的多个恢复目标。
该步骤在服务器结束备用模式并接受读写事务时完成。如果设置了
--recovery-timeout选项，pg_createsubscriber将在恢复未在指定秒数内结束时终止。
为目标服务器上的每个指定数据库创建一个订阅。
如果未指定--subscription选项，订阅的名称模式如下：
“pg_createsubscriber_%u_%x”（参数：
数据库oid，随机数int）。
它不会从源服务器复制现有数据。它也不会创建复制槽。
相反，它使用之前步骤中创建的复制槽。订阅已创建，但尚未启用。
原因是必须将复制进度设置到复制起点，才能开始复制。
删除目标服务器上那些因创建时间早于复制起始位置而被复制的发布。它在订阅者端无用。
将复制进度设置为每个订阅的复制起始点。当目标服务器启动恢复过程时，
它会追赶到复制起始点。这是作为每个订阅初始复制位置使用的精确LSN。
复制源名称是在创建订阅时获取的。复制源名称和复制起始点用于
pg_replication_origin_advance()
来设置初始复制位置。
为目标服务器上的每个指定数据库启用订阅。订阅将从复制起始点开始应用事务。
如果备用服务器正在使用primary_slot_name，它从现在起就没有用了，
因此请将其删除。
如果备用服务器包含故障转移复制槽，它们将无法再同步，因此请将其删除。
更新目标服务器上的系统标识符。运行pg_resetwal来修改系统标识符。
目标服务器根据pg_resetwal的要求被停止。
示例
要从物理副本 foo 创建数据库 hr 和
finance 的逻辑副本：
$ pg_createsubscriber -D /usr/local/pgsql/data -P "host=foo" -d hr -d finance
另请参阅pg_basebackup上一页 上一级 下一页pg_controldata 起始页 pg_ctl
