# pg_verifybackup

pg_verifybackup
版本：
纠错本页面
搜索
目录导航
❮
❯
pg_verifybackuppg_verifybackup — 验证PostgreSQL集群的基础备份的完整性大纲pg_verifybackup [option...]描述
pg_verifybackup 用于检查使用
pg_basebackup 生成的数据库集群备份的完整性，
该备份与在备份时由服务器生成的
backup_manifest 进行对比。备份可以存储为 "plain" 或 "tar"
格式；这包括使用 pg_basebackup 支持的任何算法
压缩的 tar 格式备份。然而，目前，
WAL 验证仅支持 plain 格式备份。因此，如果备份
存储为 tar 格式，则应使用
-n, --no-parse-wal 选项。
需要注意的是，由pg_verifybackup执行的验证不包括也不可能包括运行中的服务器在尝试使用备份时执行的所有检查。
即使使用此工具，也应执行测试还原，并验证生成的数据库是否按预期工作，以及它们是否包含正确的数据。但是，pg_verifybackup可以检测到由于存储问题或用户错误而经常出现的许多问题。
备份验证分为四个阶段。首先，pg_verifybackup读取
backup_manifest文件。如果该文件不存在、无法读取、
格式错误、与备份目录中的pg_control系统标识符不匹配，
或者未通过其自身内部校验和验证，pg_verifybackup将以致命错误
终止。
其次，pg_verifybackup 将尝试验证当前存储在磁盘上的数据文件是否与服务器打算发送的数据文件完全相同，下面将介绍一些例外情况。 除了少数例外，额外和丢失的文件将被检测到。此步骤将忽略 postgresql.auto.conf、standby.signal 和 recovery.signal 的存在与否或对其的任何修改，因为预计这些文件可能是在备份过程中创建或修改的。它也不会抱怨目标目录中的 backup_manifest 文件或 pg_wal 中的任何内容，即使这些文件不会列在备份清单中。只检查文件；不验证目录的存在与否，除非间接验证：如果目录丢失，则它应该包含的任何文件也必然会丢失。
接下来，pg_verifybackup将对所有文件进行校验和计算，将校验和与清单中的值进行比较，并对计算出的校验和与清单中存储的校验和不匹配的任何文件发出错误。对于在上一步中产生错误的任何文件，不执行此步骤，因为已知这些文件存在问题。在上一步中被忽略的文件在此步骤中也被忽略。
最后，pg_verifybackup 将使用清单来验证恢复备份所需的预写式日志记录是否存在，并且它们可以被读取和解析。 backup_manifest 包含有关需要哪些预写式日志记录的信息，并且 pg_verifybackup 将使用该信息来调用 pg_waldump 来解析这些预写式日志记录。 --quiet 标志将被使用，因此 pg_waldump 只会报告错误，而不会产生任何其他输出。虽然这种级别的验证足以检测明显的问题，例如丢失的文件或内部校验和不匹配的问题，但它们还不足以检测尝试恢复时可能出现的所有问题。例如，此方法无法检测到产生具有正确校验和但指定无意义操作的预写式日志记录的服务器错误。
请注意，如果存在不需要恢复备份的额外 WAL 文件，则此工具不会检查它们，尽管可以为此使用单独的 pg_waldump 调用。 另请注意，WAL 验证是特定于版本的：您必须使用 pg_verifybackup 的版本，因此是 pg_waldump 的版本，它与正在检查的备份有关。 相比之下，数据文件完整性检查应适用于生成 backup_manifest 文件的任何版本的服务器。
选项
pg_verifybackup 接受以下命令行参数：
-e--exit-on-error
一旦检测到备份问题，立即退出。如果未指定此选项，
pg_verifybackup 将继续检查备份，即使在检测到问题后，
并将报告所有检测到的问题作为错误。
-F format--format=format
指定备份的格式。format
可以是以下之一：
pplain
备份由与源服务器的数据目录和表空间具有相同布局的
普通文件组成。
ttar
备份由 tar 文件组成，这些文件可能被压缩。有效的
备份包括名为 base.tar 的主数据目录，
名为 pg_wal.tar 的 WAL 文件，以及
每个表空间的单独 tar 文件，文件名与表空间的 OID 相同。
如果备份被压缩，则相关的压缩扩展将添加到
每个文件名的末尾。
-i path--ignore=path
在比较实际存在于备份中的数据文件列表与
backup_manifest 文件中列出的文件时，忽略指定的文件或目录，
该路径应表示为相对路径名。如果指定了目录，则此选项会影响
从该位置根源的整个子树。如果相对路径名与指定的路径名匹配，
则关于额外文件、缺失文件、文件大小差异或校验和不匹配的投诉将被抑制。
此选项可以多次指定。
-m path--manifest-path=path
使用指定路径下的清单文件，而不是位于备份目录根部的文件。
-n--no-parse-wal
不要尝试解析从此备份恢复所需的预写日志数据。
-P--progress
启用进度报告。开启此选项将在验证校验和时提供进度报告。
此选项不能与选项 --quiet 一起使用。
-q--quiet
在备份成功验证时不打印任何内容。
-s--skip-checksums
不验证数据文件的校验和。文件的存在或缺失以及这些文件的大小仍将被检查。
这要快得多，因为不需要读取文件本身。
-w path--wal-directory=path
尝试解析存储在指定目录中的 WAL 文件，而不是在
pg_wal 中。如果备份存储在与 WAL 存档不同的位置，这可能会很有用。
其他选项也可用：
-V--version
打印 pg_verifybackup 版本并退出。
-?--help
显示有关 pg_verifybackup 命令行参数的帮助，然后退出。
示例
要在 mydbserver 上创建服务器的基本备份并验证备份的完整性：
$ pg_basebackup -h mydbserver -D /usr/local/pgsql/data
$ pg_verifybackup /usr/local/pgsql/data
要在 mydbserver 上创建服务器的基本备份，将清单移动到备份目录之外的某个位置，并验证备份：
$ pg_basebackup -h mydbserver -D /usr/local/pgsql/backup1234
$ mv /usr/local/pgsql/backup1234/backup_manifest /my/secure/location/backup_manifest.1234
$ pg_verifybackup -m /my/secure/location/backup_manifest.1234 /usr/local/pgsql/backup1234
要在忽略手动添加到备份目录的文件的同时验证备份，并跳过校验和验证：
$ pg_basebackup -h mydbserver -D /usr/local/pgsql/data
$ edit /usr/local/pgsql/data/note.to.self
$ pg_verifybackup --ignore=note.to.self --skip-checksums /usr/local/pgsql/data
另见pg_basebackup上一页 上一级 下一页pg_restore 起始页 psql
