# initdb

initdb
版本：
纠错本页面
搜索
目录导航
❮
❯
initdbinitdb — 创建一个新的PostgreSQL数据库集群大纲initdb [option...]  [ --pgdata  |   -D ] directory 描述
initdb 创建了一个新的
PostgreSQL 数据库集簇。
创建数据库集群包括创建
目录，这些目录是
集群数据存储的地方，生成共享目录表（属于整个集群而不是任何特定数据库的表），
并创建postgres、template1和
template0数据库。
postgres数据库是一个默认数据库，供用户、工具和第三方应用程序使用。
template1和template0是
用作源数据库的，稍后由CREATE DATABASE命令复制。
template0不应被修改，但您可以向template1添加对象，
默认情况下，这些对象会被复制到稍后创建的数据库中。有关更多详细信息，请参阅
第 22.3 节。
尽管initdb将尝试创建指定的数据目录，但如果想要的数据目录的父目录被根用户拥有，它可能没有权限。要在这样一种设置中初始化，作为 root 创建一个空数据目录，然后使用chown将该目录赋予给数据库用户账户，再然后su成为该数据库用户并运行initdb。
initdb必须以将拥有该服务器进程的用户运行，因为该服务器需要访问initdb创建的文件和目录。因为该服务器不能作为 root 运行，你不能以 root 运行initdb（事实上它会拒绝这样做）。
由于安全原因，由initdb创建的新集簇默认将只能由集簇拥有者访问。--allow-group-access选项允许与集簇拥有者同组的任何用户读取集簇中的文件。这对非特权用户执行备份很有用。
initdb 初始化了数据库集群的默认区域设置和字符集编码。
这些也可以在创建每个数据库时单独设置。initdb 确定了
模板数据库的这些设置，这些设置将作为所有其他数据库的默认值。
默认情况下，initdb 使用区域设置提供程序
libc（参见 第 23.1.4 节）。该
libc 区域设置提供程序从环境中获取区域设置，并根据
区域设置确定编码。
要为集群选择不同的区域设置，请使用选项
--locale。此外，还有单独的选项
--lc-* 和 --icu-locale（见下文）来
为各个区域设置类别设置值。请注意，不同区域设置类别的不一致
设置可能会导致无意义的结果，因此应谨慎使用。
或者，可以通过指定--locale-provider=icu，让initdb
使用ICU库来提供区域设置服务。服务器必须支持ICU。要选择要应用的特定ICU区域ID，
请使用选项--icu-locale。请注意，由于实现原因以及支持遗留代码，
当使用ICU区域设置提供程序时，initdb仍然会选择并初始化libc
区域设置。
当initdb运行时，它会打印出所选择的区域设置。如果您有复杂的要求或指定了多个选项，
建议检查结果是否符合预期。
更多有关区域设置的详细信息可以在第 23.1 节中找到。
要修改默认编码，使用--encoding。更多详细信息可以在第 23.3 节中找到。
选项
-A authmethod--auth=authmethod #
这个选项指定了用于pg_hba.conf（host和local行）中使用的本地用户的默认身份验证方法。
有关有效值的概述，请参阅第 20.1 节。
initdb将使用指定的身份验证方法为非复制连接和复制连接预填充pg_hba.conf条目。
不要使用trust，除非您信任系统上的所有本地用户。trust是为了安装方便而默认设置的。
--auth-host=authmethod #
该选项指定了通过TCP/IP连接在pg_hba.conf（host行）中使用的本地用户的身份验证方法。
--auth-local=authmethod #
这个选项指定了本地用户通过Unix域套接字连接在pg_hba.conf
（local行）中使用的身份验证方法。
-D directory--pgdata=directory #
此选项指定应存储数据库集群的目录。这是
initdb所需的唯一信息，但您可以通过设置
PGDATA环境变量来避免手动输入，这样会更方便，
因为数据库服务器(postgres)稍后可以通过
相同的变量找到数据目录。
-E encoding--encoding=encoding #
选择模板数据库的编码。这也将是您之后创建的任何数据库的默认编码，
除非您在创建时覆盖它。PostgreSQL服务器支持的字符集
在第 23.3.1 节中进行了描述。
默认情况下，模板数据库的编码是从区域设置中派生的。如果指定了
--no-locale（或者等效地，如果区域设置是
C或POSIX），那么对于ICU提供程序，
默认编码是UTF8，而对于libc提供程序，
默认编码是SQL_ASCII。
-g--allow-group-access #
允许与集群所有者在同一组中的用户读取由initdb创建的所有集群文件。
此选项在Windows上被忽略，因为它不支持POSIX风格的组权限。
--icu-locale=locale #
指定使用ICU提供程序时的ICU语言环境。语言环境支持在
第 23.1 节中描述。
--icu-rules=rules #
指定附加的排序规则以自定义默认排序的行为。这仅支持ICU。
-k--data-checksums #
在数据页面上使用校验和，以帮助检测 I/O 系统可能导致的
数据损坏，这种损坏通常是无声的。默认情况下启用此功能；
使用 --no-data-checksums 来禁用
校验和。
启用校验和可能会带来小幅的性能损失。如果设置了校验和，
则会为所有对象（在所有数据库中）计算校验和。所有校验和
失败将会在
pg_stat_database 视图中报告。
有关详细信息，请参见 第 28.2 节。
--locale=locale #
设置数据库集群的默认语言环境。如果未指定此选项，则语言环境将从initdb运行的环境继承。
语言环境支持在第 23.1 节中描述。
如果 --locale-provider 为 builtin，
则必须指定 --locale 或 --builtin-locale，
并将其设置为 C、C.UTF-8
或 PG_UNICODE_FAST。
--lc-collate=locale--lc-ctype=locale--lc-messages=locale--lc-monetary=locale--lc-numeric=locale--lc-time=locale #
类似于--locale，但仅在指定的类别中设置语言环境。
--no-locale #
等同于--locale=C。
--builtin-locale=locale #
指定使用内置提供程序时的区域设置名称。区域设置支持详见
第 23.1 节。
--locale-provider={builtin|libc|icu} #
此选项为新集群中创建的数据库设置区域设置提供程序。它可以在随后创建新数据库时通过
CREATE DATABASE命令覆盖。默认值是libc
（参见第 23.1.4 节）。
--no-data-checksums #
不要启用数据校验和。
--pwfile=filename #
使initdb从文件中读取引导超级用户的密码。文件的第一行
被视为密码。
-T config--text-search-config=config #
设置默认的文本搜索配置。
有关更多信息，请参见default_text_search_config。
-U username--username=username #
设置
引导超级用户
的用户名。默认情况下，这将设置为运行
initdb
的操作系统用户的名称。
-W--pwprompt #
使initdb提示输入密码以提供给引导超级用户。
如果您不打算使用密码认证，这并不重要。否则，在设置密码之前，
您将无法使用密码认证。
-X directory--waldir=directory #
这个选项指定了预写日志应该存储的目录。
--wal-segsize=size #
设置WAL段大小，单位为兆字节。这是WAL日志中每个单独文件的大小。
默认大小为16兆字节。该值必须是1到1024（兆字节）之间的2的幂。此选项只能在初始化期间设置，
以后不能更改。
调整这个大小可能是有用的，以控制WAL日志传送或归档的粒度。此外，在具有大量WAL的数据库中，每个目录中的WAL文件数量之多可能会成为性能和管理问题。增加WAL文件大小将减少WAL文件数量。
其他较少使用的选项也可用：
-c name=value--set name=value #
强制在initdb期间将服务器参数name设置为
value，并且还将该设置安装到生成的postgresql.conf文件中，
以便在将来的服务器运行期间应用该设置。此选项可以多次指定以设置多个参数。
当环境导致服务器无法使用默认参数启动时，此选项尤其有用。
-d--debug #
打印来自引导后端的调试输出以及一些对普通用户兴趣较小的其他消息。
引导后端是程序initdb用来创建目录表的。
该选项会生成大量极其枯燥的输出。
--discard-caches #
以 debug_discard_caches=1 选项运行引导后端。
这会花费很长时间，仅适用于深入调试。
-L directory #
指定initdb应在哪里查找其输入文件以初始化数据库集群。
通常不需要这样做。如果需要明确指定它们的位置，系统会通知您。
-n--no-clean #
默认情况下，当initdb
发现错误导致无法完全创建数据库集群时，它会删除在发现无法完成任务之前可能创建的任何文件。
此选项禁止清理操作，因此对于调试非常有用。
-N--no-sync #
默认情况下，initdb将等待所有文件被安全写入磁盘。
此选项导致initdb在不等待的情况下返回，这样更快，
但意味着随后的操作系统崩溃可能会使数据目录损坏。通常，此选项在测试时很有用，
但在创建生产安装时不应使用。
--no-sync-data-files #
默认情况下，initdb 会安全地将所有数据库文件
写入磁盘。此选项指示 initdb 跳过
同步单个数据库目录中的所有文件、数据库目录本身以及表空间目录，
即 base 子目录中的所有内容以及任何其他
表空间目录。其他文件，例如 pg_wal 和
pg_xact 中的文件，仍将被同步，除非
还指定了 --no-sync 选项。
请注意，如果 --no-sync-data-files 与
--sync-method=syncfs 一起使用，则上述某些或
所有文件和目录将被同步，因为 syncfs 处理整个
文件系统。
此选项主要用于工具的内部使用，这些工具单独确保跳过的
文件被同步到磁盘。
--no-instructions #
默认情况下，initdb会在输出的末尾写入启动集群的说明。
此选项会导致省略这些说明。这主要是为了供将initdb包装在特定平台行为中的工具使用，
在那些说明可能不正确的情况下。
-s--show #
显示内部设置并退出，不执行其他操作。 这可用于调试
initdb安装过程。
--sync-method=method #
当设置为fsync（默认值）时，initdb将递归打开并同步数据目录中的所有文件。
对文件的搜索将遵循符号链接到WAL目录和每个配置的表空间。
在 Linux 上，可以使用 syncfs 来请求操作系统同步包含数据目录、
WAL 文件和每个表空间的整个文件系统。有关使用 syncfs 时需注意的
注意事项，请参见 recovery_init_sync_method。
当使用--no-sync时，此选项无效。
-S--sync-only #
安全地将所有数据库文件写入磁盘并退出。这不执行任何正常的initdb操作。
通常，此选项对于在将fsync从off更改为on后确保可靠恢复很有用。
其他选项:
-V-–version #
打印initdb版本并退出。
-?-–help #
显示关于initdb命令行参数的帮助信息，并退出。
环境PGDATA #
指定数据库集簇应该被存放的目录，可以使用-D选项覆盖。
PG_COLOR #
规定在诊断消息中是否使用颜色。可能的值为always、auto和
never。
TZ #
指定创建的数据库集簇的默认时区。值应该是一个完整的时区名称（见第 8.5.3 节）。
备注
initdb可以通过pg_ctl initdb来调用。
另请参阅pg_ctl, postgres, 第 20.1 节上一页 上一级 下一页PostgreSQL 服务器应用程序 起始页 pg_archivecleanup
