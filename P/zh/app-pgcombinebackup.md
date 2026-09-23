# pg_combinebackup

pg_combinebackup
版本：
纠错本页面
搜索
目录导航
❮
❯
pg_combinebackuppg_combinebackup — 从增量备份和依赖备份重建完整备份大纲pg_combinebackup [option...] [backup_directory...]描述
pg_combinebackup 用于从
增量备份及其依赖的早期备份中重建一个合成的完整备份。
指定命令行上所有必需的备份，顺序从最旧到最新。也就是说，第一个备份目录应是完整备份的路径，
最后一个应是您希望恢复的最终增量备份的路径。重建的备份将写入由
-o 选项指定的输出目录。
pg_combinebackup 将尝试验证您指定的备份是否构成一个合法的备份链，
从中可以重建正确的完整备份。然而，它并不用于帮助您跟踪哪些备份依赖于其他备份。
如果您删除了增量备份所依赖的一个或多个先前备份，您将无法恢复该增量备份。此外，
pg_combinebackup 仅尝试验证备份之间的关系是否正确，而不保证每个
单独备份的完整性；如需此功能，请使用
pg_verifybackup。
由于pg_combinebackup的输出是一个合成的完整备份，
它可以作为未来调用pg_combinebackup的输入。
合成的完整备份将在命令行中指定，代替用于重建它的备份链。
选项
-d--debug
在stderr上打印大量调试日志输出。
-k--link
使用硬链接而不是复制文件到合成备份。
合成备份的重建可能会更快（没有文件复制）
并且使用更少的磁盘空间，但在使用输出
目录时必须小心，因为对该目录的任何修改
（例如，启动服务器）也可能影响输入目录。同样，
对输入目录的更改（例如，在完整备份上
启动服务器）可能会影响输出目录。因此，最好在输入目录
仅是将在 pg_combinebackup 完成后
删除的副本时使用此选项。
要求输入备份和输出目录位于
同一文件系统中。
如果备份清单不可用或不包含正确类型的
校验和，仍然会创建硬链接，但文件也会
按块读取以进行校验和计算。
-n--dry-run
-n/--dry-run 选项指示
pg_combinebackup 计算将会执行的操作，
但实际上不会创建目标目录或任何输出文件。
该选项在与 --debug 结合使用时特别有用。
-N--no-sync
默认情况下，pg_combinebackup 会等待所有文件安全写入磁盘。
该选项使得 pg_combinebackup 在不等待的情况下返回，速度更快，
但这意味着后续的操作系统崩溃可能导致输出备份损坏。通常，该选项适用于测试，
但在创建生产环境时不应使用。
-o outputdir--output=outputdir
指定应写入合成完整备份的输出目录。目前，此参数是必需的。
-T olddir=newdir--tablespace-mapping=olddir=newdir
在备份过程中，将表空间从目录 olddir
重新定位到 newdir。olddir 是
命令行指定的最终备份中表空间的绝对路径，newdir 是
用于重建备份中表空间的绝对路径。如果任一路径中需要包含等号
(=)，请在其前加反斜杠。此选项可多次指定以处理多个表空间。
--clone
使用高效的文件克隆（在某些系统上也称为“reflinks”）代替将文件复制到新的数据目录，
这可以实现数据文件的几乎瞬时复制。
如果备份清单不可用或不包含正确类型的校验和，将使用文件克隆来复制文件，
但文件也会被逐块读取以计算校验和。
文件克隆仅在某些操作系统和文件系统上受支持。如果选择了该功能但不被支持，
pg_combinebackup 运行时将报错。目前，它在 Linux（内核
4.5 或更高版本）上支持 Btrfs 和 XFS（在支持 reflink 的文件系统上创建），以及
macOS 上的 APFS。
--copy
执行常规文件复制。这是默认设置。（另见
--copy-file-range、--clone 和
-k/--link。）
--copy-file-range
使用copy_file_range系统调用进行高效复制。在某些文件系统上，
这会产生类似于--clone的效果，共享物理磁盘块，而在其他文件系统上，
它可能仍然复制块，但通过优化路径完成。目前，该功能在Linux和FreeBSD上得到支持。
如果备份清单不可用或不包含正确类型的校验和，copy_file_range将被用来
复制文件，但文件也会被逐块读取以计算校验和。
--manifest-checksums=algorithm
像 pg_basebackup 一样，
pg_combinebackup 会在输出目录中写入备份清单。
此选项指定应应用于备份清单中每个文件的校验和算法。
目前，可用的算法有 NONE、
CRC32C、SHA224、
SHA256、SHA384 和
SHA512。默认值是 CRC32C。
--no-manifest
禁用备份清单的生成。如果未指定此选项，将会在输出目录中写入
重建备份的备份清单。
--sync-method=method
当设置为fsync（默认值）时，pg_combinebackup将递归打开并同步
备份目录中的所有文件。当使用纯格式时，文件搜索将遵循WAL目录和每个配置的表空间的符号链接。
在 Linux 上，可以使用 syncfs 来请求操作系统同步包含备份目录的整个文件系统。
当使用纯格式时，pg_combinebackup 还会同步包含 WAL 文件和每个表空间的文件系统。
有关使用 syncfs 时需要注意的事项，请参见
recovery_init_sync_method。
当使用--no-sync时，此选项无效。
-V--version
打印pg_combinebackup的版本并退出。
-?--help
显示关于 pg_combinebackup 命令行参数的帮助信息，并退出。
限制
pg_combinebackup 在写入输出目录时不会重新计算页面校验和。
因此，如果用于重建的任何备份是在禁用校验和的情况下进行的，但最终备份是在启用
校验和的情况下进行的，则生成的目录可能包含校验和无效的页面。
为了避免此问题，建议在使用 pg_checksums
更改集群的校验和状态后进行新的完整备份。
否则，您可以禁用然后可选地重新启用
pg_combinebackup 生成的目录上的校验和
以纠正该问题。
环境
此实用程序与大多数其他 PostgreSQL 实用程序一样，使用 libpq 支持的环境变量（见 第 32.15 节）。
环境变量 PG_COLOR 指定是否在诊断消息中使用颜色。可能的值是 always、auto 和
never。
另请参阅pg_basebackup上一页 上一级 下一页pgbench 起始页 pg_config
