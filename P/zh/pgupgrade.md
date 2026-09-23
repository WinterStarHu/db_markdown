# pg_upgrade

pg_upgrade
版本：
纠错本页面
搜索
目录导航
❮
❯
pg_upgradepg_upgrade — 升级 PostgreSQL 服务器实例大纲pg_upgrade  -b   oldbindir  [-B newbindir]  -d   oldconfigdir   -D   newconfigdir  [option...]描述
pg_upgrade（以前称为 pg_migrator）允许将存储在
PostgreSQL 数据文件中的数据升级到更高版本的 PostgreSQL
主版本，而无需通常为主版本升级所需的数据转储/恢复，例如，从 12.14 升级到 13.10 或从 14.9 升级到 15.5。
对于小版本升级，例如从 12.7 升级到 12.8 或从 14.1 升级到 14.5，则不需要。
PostgreSQL 主发行版本通常会加入新的特性，这些新特性常常会更改系统表的
布局，但是内部数据存储格式很少会改变。pg_upgrade
使用这一事实来通过创建新系统表并重用旧的用户数据文件来执行快速升级。
如果未来的主发行版本更改了数据存储格式，导致旧数据格式不可读，那么
pg_upgrade 将无法用于此类升级。（社区将努力避免这种情况）。
pg_upgrade 会尽力（例如通过检查兼容的编译时设
置）确保新旧集簇在二进制上也是兼容的，包括 32/64 位二进制。保持
外部模块也是二进制兼容的也很重要，不过
pg_upgrade 无法检查这一点。
pg_upgrade 支持从 9.2.X 及更高版本升级到当前
主要版本的 PostgreSQL，包括快照和测试版发布。
警告
升级集群会导致目标执行源超级用户选择的任意代码。确保在升级前
源超级用户是可信的。
选项
pg_upgrade 接受以下命令行参数：
-b bindir--old-bindir=bindir旧的 PostgreSQL 可执行文件目录；
环境变量 PGBINOLD-B bindir--new-bindir=bindir新的 PostgreSQL 可执行文件目录；默认为 pg_upgrade 所在的目录；
环境变量 PGBINNEW-c--check仅检查集群，不更改任何数据-d configdir--old-datadir=configdir旧数据库集群配置目录；环境变量
PGDATAOLD-D configdir--new-datadir=configdir新的数据库集群配置目录；环境变量
PGDATANEW-j njobs--jobs=njobs同时连接和进程/线程的数量
-k--link使用硬链接而不是将文件复制到新的集簇-N--no-sync
默认情况下，pg_upgrade将等待升级后集簇的所有文件安全写入磁盘。
此选项使pg_upgrade在不等待的情况下返回，这样更快，但意味着随后的操作系统崩溃可能会导致数据目录损坏。
通常，此选项对于测试很有用，但不应在生产安装中使用。
-o options--old-options options要直接传递给旧的postgres命令的选项；多个选项调用会被追加-O options--new-options options要直接传递给新的postgres命令的选项；多个选项调用会被追加-p port--old-port=port旧的集簇端口号；环境变量PGPORTOLD-P port--new-port=port新的集簇端口号；环境变量PGPORTNEW-r--retain即使成功完成后也保留SQL和日志文件-s dir--socketdir=dir用于升级期间的postmaster套接字的目录；
默认为当前工作目录；环境变量PGSOCKETDIR-U username--username=username集群的安装用户名称；环境变量PGUSER-v--verbose启用详细的内部日志记录-V--version显示版本信息，然后退出--clone
使用高效的文件克隆（有些系统上也称为“reflinks”）而不是将文件复制到新的集群中。
这可以实现几乎瞬间复制数据文件，提供-k/-–link的速度优势，
同时保持原有集群的完整性。
文件克隆仅在某些操作系统和文件系统上受支持。如果选择了但不受支持，pg_upgrade运行将出错。目前，在Linux（内核4.5或更高版本）上支持Btrfs和XFS（在启用reflink支持的文件系统上创建），以及在macOS上支持APFS。
--copy
将文件复制到新集群。这是默认设置。（另见
--link、--clone、
--copy-file-range 和 --swap。）
--copy-file-range
使用copy_file_range系统调用进行高效复制。在某些文件系统上，
这会产生类似于--clone的效果，共享物理磁盘块，而在其他文件系统上，
它可能仍然复制块，但通过优化路径完成。目前，该功能在Linux和FreeBSD上得到支持。
--no-statistics
不要将旧集群的统计信息恢复到新集群中。
--set-char-signedness=option
手动设置新集群的默认字符符号性。可能的值为
signed 和 unsigned。
在 C 语言中，char 类型的默认符号性
（当未明确指定时）在不同平台上有所不同。例如，
char 在 x86 CPU 上默认为 signed char，
而在 ARM CPU 上默认为 unsigned char。
从 PostgreSQL 18 开始，数据库集群
维护自己的默认字符符号性设置，这可以用于
确保在具有不同默认字符符号性的多个平台上行为一致。默认情况下，
pg_upgrade 在从现有集群升级时保留
字符符号性设置。然而，当从 PostgreSQL 17
或更早版本升级时，pg_upgrade 采用
构建时平台的字符符号性。
此选项允许您显式设置新集群的默认字符符号性，覆盖任何继承的值。
该选项相关的两个特定场景是：
如果您计划在升级后迁移到不同的平台，则不应使用此选项。
在这种情况下，默认行为是正确的。相反，在原始平台上执行
升级而不使用此标志，然后在之后迁移集群。这是推荐的最安全
的方法。
如果您已经将集群迁移到具有不同字符符号性的平台（例如，
从基于 x86 的系统迁移到基于 ARM 的系统），则应使用此选项
指定与原始平台默认字符符号性匹配的符号性。此外，在迁移数据
文件和运行 pg_upgrade 之间，务必不要修改
任何数据文件。pg_upgrade 应该是启动新平台上
集群的第一项操作。
--swap
将数据目录从旧集群移动到新集群。
然后，用为新集群生成的目录文件替换目录文件。
此模式在许多关系的集群上可以超越 --link、
--clone、--copy 和
--copy-file-range，尤其是在关系较多的集群上。
然而，此模式会在旧集群中创建许多垃圾文件，如果使用
--sync-method=syncfs，可能会延长文件同步步骤。
因此，建议在使用 --swap 时使用
--sync-method=fsync。
此外，一旦文件传输步骤开始，旧集群将被破坏性修改，因此将不再安全
启动。有关详细信息，请参见 步骤 17。
--sync-method=method
当设置为 fsync（默认值）时，pg_upgrade 将递归打开并同步升级集群数据目录中的所有文件。
对文件的搜索将遵循 WAL 目录和每个配置表空间的符号链接。
在 Linux 上，可以使用 syncfs 来请求操作系统同步包含升级集群数据目录、
其 WAL 文件以及每个表空间的整个文件系统。有关使用 syncfs 时需注意的
注意事项，请参见 recovery_init_sync_method。
当使用--no-sync时，此选项无效。
-?--help显示帮助信息，然后退出
使用
下面是用pg_upgrade执行一次升级的步骤：
注意
升级 逻辑复制集群
的步骤在此不作介绍；
详情请参考 第 29.13 节。
可选地移动旧集簇
如果你在使用一个与版本相关的安装目录（例如
/opt/PostgreSQL/18），你就不需要移动旧的集簇。
图形化的安装程序会使用版本相关的安装目录。
如果你的安装目录不是版本相关的（例如/usr/local/pgsql），
就有必要移动当前的 PostgreSQL 安装目录，以免它干扰新的
PostgreSQL安装。一旦当前的
PostgreSQL服务器被关闭，就可以安全地重命名
PostgreSQL 安装目录。假设旧目录是
/usr/local/pgsql，你可以这样：
mv /usr/local/pgsql /usr/local/pgsql.old
来重命名该目录。
对于源码安装，编译新版本
用兼容旧集簇的configure标记编译新的
PostgreSQL 源码。在开始升级之前，pg_upgrade
将检查pg_controldata来确保所有设置是兼容的。
安装新的 PostgreSQL 二进制文件
安装新服务器的二进制文件和支持文件。pg_upgrade
会被包含在默认的安装中。
对于源码安装，如果你希望把新服务器安装在一个自定义的位置，
可以使用prefix变量：
make prefix=/usr/local/pgsql.new install
初始化新的 PostgreSQL 集簇
使用initdb初始化新集簇。这里也要使用与
旧集簇相兼容的initdb标志。许多预编译的
安装程序会自动执行这个步骤。这里没有必要启动新集簇。
安装扩展共享对象文件
许多扩展和自定义模块，无论是来自contrib或其他源，使用共享对象文件（或DLL），例如，pgcrypto.so。如果旧集群使用过这些，匹配新服务器二进制的共享对象文件，必须安装在新集群中，通常是通过操作系统命令。不要加载模式定义，例如CREATE EXTENSION pgcrypto，因为这些将从旧集群复制。如果扩展更新是可用的，pg_upgrade将报告这一点，并创建一个脚本，可以稍后运行来更新它们。
复制自定义全文检索文件
从旧集群向新集群复制任何自定义全文检索文件（词典、同义词、词库、停用词）。
调整认证
pg_upgrade将会多次连接到旧服务器和新服务器，因此你可能想要在pg_hba.conf中把认证设置成peer或者使用一个~/.pgpass文件（见第 32.16 节）。
停止两个服务器
确保两个数据库服务器都已停止，在Unix上，例如：
pg_ctl -D /opt/PostgreSQL/12 stop
pg_ctl -D /opt/PostgreSQL/18 stop
或者在Windows上，使用正确的服务名称：
NET STOP postgresql-12
NET STOP postgresql-18
流复制和日志传送备用服务器必须在此关闭期间运行，以便它们接收所有更改。
为备用服务器升级做准备
如果您正在使用第步骤 11节中概述的方法升级备用服务器，请通过运行pg_controldata命令检查旧的备用服务器和主服务器集群是否同步。
确保所有集群中“最新检查点位置”的值匹配。此外，请确保在新的主服务器集群的postgresql.conf文件中未将wal_level设置为minimal。
运行 pg_upgrade
始终运行新服务器的 pg_upgrade 二进制文件，而不是旧的。
pg_upgrade 需要指定旧集群和新集群的
数据和可执行文件 (bin) 目录。您还可以指定
用户和端口值，以及是否希望将数据文件链接、克隆或交换
而不是默认的复制行为。
如果您使用链接模式，升级将会更快（没有文件
复制）并且使用更少的磁盘空间，但一旦您在升级后
启动新集群，您将无法访问旧集群。链接模式还
要求旧集群和新集群的数据目录位于
同一文件系统中。（表空间和 pg_wal 可以位于
不同的文件系统中。）
克隆模式提供相同的速度和磁盘空间优势，但
一旦启动新集群，不会导致旧集群无法使用。克隆模式
还要求旧数据目录和新数据目录位于同一文件系统中。
此模式仅在某些操作系统和文件系统上可用。
如果有很多关系，交换模式可能是最快的，但一旦文件传输步骤开始，
您将无法访问旧集群。
交换模式还要求旧集群和新集群的数据目录位于
同一文件系统中。
将 --jobs 设置为 2 或更高值允许 pg_upgrade
并行处理多个数据库和表空间。一个好的起始
点是机器上的 CPU 核心数。此选项可以
大幅减少多数据库和
多表空间服务器的升级时间。
对于 Windows 用户，您必须以管理员账户登录，
然后使用带引号的目录运行 pg_upgrade，例如：
pg_upgrade.exe
--old-datadir "C:/Program Files/PostgreSQL/12/data"
--new-datadir "C:/Program Files/PostgreSQL/18/data"
--old-bindir "C:/Program Files/PostgreSQL/12/bin"
--new-bindir "C:/Program Files/PostgreSQL/18/bin"
启动后，pg_upgrade 将验证两个集群是否兼容
然后进行升级。您可以使用 pg_upgrade --check
仅执行检查，即使旧服务器仍在
运行。 pg_upgrade --check 还将概述您在升级后
需要进行的任何手动调整。如果您
将使用链接、克隆、复制文件范围或交换模式，您
应该使用选项 --link、--clone、
--copy-file-range 或 --swap 与
--check 一起启用模式特定的检查。
pg_upgrade 需要在当前目录中具有写权限。
显然，没有人可以在升级期间访问这些集簇。pg_upgrade
默认会在端口 50432 上运行服务器来避免意外的客户端连接。在做升级时，
可以对两个集簇使用相同的端口号，因为新旧集簇不会同时运行。不过，
在检查一个旧的运行中服务器时，新旧端口号必须不同。
如果在恢复数据库模式时发生错误，pg_upgrade将会退出
并且你必须按照下文步骤 17中所说的恢复
旧集簇。要再次尝试pg_upgrade，你将需要修改
旧集簇，这样 pg_upgrade 模式会成功恢复。如果问题是一个
contrib模块，
你可能需要从旧集簇中卸载该模块并在升级后重新安装到新集簇中，不过
这样做的前提是该模块没有被用来存储用户数据。
升级流复制和日志传送后备服务器
如果使用链接模式并且有流复制（见第 26.2.5 节）或者日志
传送（见第 26.2 节）后备服务器，你可以遵照下面的
步骤对它们进行快速的升级。你将不用在这些后备服务器上运行
pg_upgrade，而是在主服务器上运行rsync。
到这里还不要启动任何服务器。
如果你没有使用链接模式、没有或不想使用rsync或者想用一种更容易的解决方案，请跳过这一节中的过程并在pg_upgrade完成并且新的主集簇开始运行后重建后备服务器。
在后备服务器上安装新的 PostgreSQL 二进制文件
确保新的二进制和支持文件安装在所有后备服务器上。
确保新的后备机数据目录不存在
确保新的后备机数据目录不存在或为空。如果
运行过initdb，请删除后备服务器的新数据目录。
安装扩展共享对象文件
在新的后备机上安装和新的主集簇中相同的扩展共享对象文件。
停止后备服务器
如果后备服务器仍在运行，现在使用上述指令停止它们。
保存配置文件
从旧后备机的配置目录保存任何需要保留的配置文件，例如
postgresql.conf（以及它包含的任何文件）、
postgresql.auto.conf、pg_hba.conf，
因为这些文件在下一步中会被重写或移除。
运行rsync
使用链接模式时，可以使用rsync快速升级备用服务器。
为此，从主服务器上位于旧数据库集群和新数据库集群目录之上的某个目录，
对每个备用服务器在主服务器上运行以下命令：
rsync --archive --delete --hard-links --size-only --no-inc-recursive old_cluster new_cluster remote_dir
其中，old_cluster和new_cluster是相对于主服务器当前目录的路径，
而remote_dir是备用服务器上位于旧集群和新集群目录之上的路径。
主服务器和备用服务器上指定目录下的目录结构必须匹配。有关指定远程目录的详细信息，
请参阅rsync手册页，例如：
rsync --archive --delete --hard-links --size-only --no-inc-recursive /opt/PostgreSQL/12 \
/opt/PostgreSQL/18 standby.example.com:/opt/PostgreSQL
您可以使用rsync的--dry-run选项验证命令的执行效果。
虽然rsync必须至少在一个备用服务器上由主服务器运行，
但也可以在已升级的备用服务器上运行rsync以升级其他备用服务器，
只要该已升级的备用服务器尚未启动。
这个命令所做的事情是记录由pg_upgrade的链接模式创建的链接，它们连接主服务器上新旧集簇中的文件。该命令接下来在备用服务器的旧集簇中寻找匹配的文件并为它们在该备用的新集簇中创建链接。主服务器上没有被链接的文件会被从主服务器拷贝到备用服务器（通常都很小）。这提供了快速的备用服务器升级。不幸的是，rsync会不必要地拷贝与临时表和不做日志表相关的文件，因为这些文件通常在备用服务器上不存在。
如果您有表空间，您需要为每个表空间目录运行类似的
rsync命令，例如：
rsync --archive --delete --hard-links --size-only --no-inc-recursive /vol1/pg_tblsp/PG_12_201909212 \
/vol1/pg_tblsp/PG_18_202307071 standby.example.com:/vol1/pg_tblsp
如果您将pg_wal重新定位到数据目录之外，
也必须对这些目录运行rsync。
配置流复制和日志传送备用服务器
配置用于日志传送的服务器。（您无需运行
pg_backup_start() 和 pg_backup_stop()，
也无需进行文件系统备份，因为备用服务器仍与主服务器同步。）如果旧主服务器版本低于17.0，
则主服务器上的插槽不会复制到新的备用服务器，因此必须手动重新创建旧备用服务器上的所有插槽。
如果旧主服务器版本为17.0或更高版本，则只有主服务器上的逻辑插槽会复制到新的备用服务器，
但旧备用服务器上的其他插槽不会复制，因此必须手动重新创建。
恢复 pg_hba.conf
如果您修改了pg_hba.conf，则要将其恢复到原始的设置。
也可能需要调整新集簇中的其他配置文件来匹配旧集簇，例如
postgresql.conf（以及它包含的任何文件）和
postgresql.auto.conf。
启动新服务器
现在可以安全地启动新的服务器，并且可以接着启动任何
rsync过的备用服务器。
升级后处理
如果需要做任何升级后处理，pg_upgrade 将在完成后发出警告。它也将
生成必须由管理员运行的脚本文件。这些脚本文件将连接到每一个需要做
升级后处理的数据库。每一个脚本应该这样运行：
psql --username=postgres --file=script.sql postgres
这些脚本可以以任何顺序运行并且在运行之后立即删除。
小心
通常在重建脚本运行完成之前访问重建脚本中引用的表是不安全的，这样做
可能会得到不正确的结果或者很差的性能。没有在重建脚本中引用的表可以
随时被访问。
统计信息
除非指定了 --no-statistics 选项，
pg_upgrade 将从旧集群转移大部分优化器统计信息
到新集群。这并不转移
所有统计信息，例如那些通过
CREATE STATISTICS 显式创建的、
扩展添加的自定义统计信息，或由累积统计系统收集的统计信息。
因为并非所有统计信息都由
pg_upgrade 转移，您将在升级结束时被指示运行命令以
重新生成该信息。您可能需要
设置连接参数以匹配您的新集群。
首先，使用
vacuumdb --all --analyze-in-stages --missing-stats-only
快速生成没有任何关系的最小优化器统计信息。
然后，使用 vacuumdb --all --analyze-only 确保
所有关系都有更新的累积统计信息以触发 VACUUM 和
ANALYZE。对于这两个命令，使用 --jobs 可以加快
速度。
如果 vacuum_cost_delay 设置为非零
值，可以通过使用 PGOPTIONS 来覆盖以加快统计信息生成，
例如，PGOPTIONS='-c
vacuum_cost_delay=0' vacuumdb ...。
删除旧集簇
一旦你对升级表示满意，你就可以通过运行
pg_upgrade完成时提到的脚本来删除旧集簇的
数据目录（如果在旧数据目录中有用户定义的表空间就不可能实现自动删除）。
你也可以删除旧安装目录（例如bin、share）。
恢复到旧集簇
如果在运行 pg_upgrade 后，您希望恢复到旧集群，
有几种选择：
如果使用了 --check 选项，旧集群
未被修改；可以重新启动。
如果既没有使用 --link 也没有使用 --swap，
旧集群未被修改；可以重新启动。
如果使用了 --link 选项，数据
文件可能在旧集群和新集群之间共享：
如果 pg_upgrade 在链接开始之前中止，
旧集群未被修改；可以重新启动。
如果您没有启动新集群，旧
集群未被修改，除了在链接开始时，.old 后缀被附加到
$PGDATA/global/pg_control。要重用旧集群，
请从 $PGDATA/global/pg_control 中删除 .old 后缀；
然后您可以重新启动旧集群。
如果您启动了新集群，它已写入共享文件，
使用旧集群是不安全的。在这种情况下，旧集群需要从备份恢复。
如果使用了 --swap 选项，旧集群可能
被破坏性修改：
如果 pg_upgrade 在报告旧集群
不再安全启动之前中止，旧集群未被修改；可以重新启动。
如果 pg_upgrade 已报告旧集群
不再安全启动，旧集群已被破坏性修改。在这种情况下，旧集群需要从备份恢复。
环境
一些环境变量可用于为命令行选项提供默认值：
PGBINOLD
旧的 PostgreSQL 可执行文件目录；选项
-b/--old-bindir。
PGBINNEW
新的 PostgreSQL 可执行文件目录；选项
-B/--new-bindir。
PGDATAOLD
旧数据库集群配置目录；选项
-d/--old-datadir。
PGDATANEW
新数据库集群配置目录；选项
-D/--new-datadir。
PGPORTOLD
旧集群端口号；选项
-p/--old-port。
PGPORTNEW
新集群端口号；选项
-P/--new-port。
PGSOCKETDIR
升级期间用于 postmaster 套接字的目录；选项
-s/--socketdir。
PGUSER
集群的安装用户名；选项
-U/--username。
注意事项
pg_upgrade创建各种工作文件，例如模式转储，存储在新集群目录中的pg_upgrade_output.d中。
每次运行都会创建一个新的子目录，以ISO 8601格式化的时间戳命名（%Y%m%dT%H%M%S），其中存储了所有生成的文件。
如果pg_upgrade成功完成，则pg_upgrade_output.d及其包含的文件将被自动删除；
但如果出现问题，则那里的文件可能提供有用的调试信息。
pg_upgrade在新旧数据目录中启动短期的postmasters。临时 Unix 套接字文件用于与这些postmasters通信，默认情况下，在当前工作目录中进行。
在某些情况下，当前目录的路径名称可能太长，无法成为有效的套接字名称。这种情况下你可以使用-s选项将套接字文件放在某些具有较短路径名称的目录中。
为了安全原因，请确保该目录不可被任何其他用户读取或写入。（这在 Windows 上不受支持。）
如果失败、重建和重新索引会影响你的安装，pg_upgrade
将会报告这些情况。用来重建表和索引的升级后脚本将会自动被建立。
如果你正在尝试自动升级很多集簇，你应该发现具有相同数据库模式的集簇
对所有集簇升级都要求同样的升级后步骤，这是因为升级后步骤是基于数据
库模式而不是用户数据。
对于部署测试，创建一个只有模式的旧集簇副本，在其中插入假数据并升级。
pg_upgrade不支持包含使用这些reg* OID-引用系统数据类型的表列的数据库的升级：
regcollationregconfigregdictionaryregnamespaceregoperregoperatorregprocregprocedure
(regclass, regrole, 和 regtype 可以升级。)
如果你想要使用链接模式并且你不想让你的旧集簇在新集簇启动时被修改，考虑使用克隆模式。
如果克隆模式不可用，可以复制一份旧集簇并且在副本上以链接模式进行升级。要创建旧集簇的一
份合法拷贝，可以在服务器运行时使用rsync创建旧集簇的
一份脏拷贝，然后关闭旧服务器并且再次运行rsync --checksum
把更改更新到该拷贝以让其一致（--checksum是必要的，因为
rsync在判断文件修改时间的更改时的精度只能到秒级）。如
第 25.3.4 节中所述，你可能想要排除
一些文件，例如postmaster.pid。如果你的文件系统支持文
件系统快照或者 copy-on-write 文件副本，你可以使用它们来创建旧集簇和
表空间的一个备份，不过快照和副本必须被同时创建或者在数据库服务器关闭
期间被创建。
另见initdb, pg_ctl, pg_dump, postgres上一页 上一级 下一页pg_test_timing 起始页 pg_waldump
