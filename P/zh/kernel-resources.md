# 18.4. 管理内核资源

18.4. 管理内核资源
版本：
纠错本页面
搜索
目录导航
❮
❯
18.4. 管理内核资源 #18.4.1. 共享内存和信号量18.4.2. systemd RemoveIPC18.4.3. 资源限制18.4.4. Linux 内存过量使用18.4.5. Linux 大页面
PostgreSQL有时会耗尽操作系统的各种资源限制，当同一个系统上运行着多个拷贝的服务器或在一个非常大的安装中时尤其如此。本节解释了PostgreSQL使用的内核资源以及你可以采取的用于解决内核资源消耗相关问题的步骤。
18.4.1. 共享内存和信号量 #
PostgreSQL需要操作系统提供进程间通信(IPC)特性，
特别是共享内存和信号量。Unix驱动的系统通常提供
“System V” IPC、
“POSIX” IPC，或者两者都有。
Windows有它自己的这些功能的实现，这里不讨论。
默认情况下，PostgreSQL分配很少量的System V共享内存，以及大量的匿名mmap共享内存。
或者，可以使用单个大型System V共享内存区域（参见 shared_memory_type）。
另外，在服务器启动时会创建大量信号量，这些信号量可以是System V或POSIX风格。目前，POSIX信号量用于Linux和FreeBSD系统，而其他平台则使用System V信号量。
System V IPC特性通常受系统范围分配限制的约束。
当PostgreSQL超出了这些限制之一时，服务器会拒绝启动并且留下一条有指导性的错误消息，其中描述了问题以及应该怎么做（另见 第 18.3.1 节）。相关的内核参数在不同系统之间的命名方式一致，表 18.1给出了一个概述。不过，设置它们的方法却多种多样。下面给出了对于某些平台的建议：
表 18.1. System V IPC 参数名称描述运行一个PostgreSQL实例所需的值SHMMAX共享内存段的最大尺寸（字节）至少 1kB，但是默认值通常要高得多SHMMIN共享内存段的最小尺寸（字节）1SHMALL可用共享内存的总量（字节或页面）如果是字节，同SHMMAX；如果是页面，
为ceil(SHMMAX/PAGE_SIZE)，加上其他应用程序的空间SHMSEG每个进程的最大共享内存段数目只需要 1 段，但是默认值要高得多SHMMNI系统范围内的最大共享内存段数目像SHMSEG加上其他应用的空间SEMMNI信号量标识符的最大数量（即，集合）至少 ceil(num_os_semaphores / 16) 加上其他应用的空间SEMMNS系统范围内的信号量最大数量ceil(num_os_semaphores / 16) * 17 加上其他应用的空间SEMMSL每个集合的信号量最大数量至少 17SEMMAP信号量映射中的项数见文本SEMVMX信号量的最大值至少 1000 （默认值通常是 32767，如非必要不要更改）
PostgreSQL要求少量字节的 System V 共享内存（在 64 位平台上通常是 48 字节）用于每一个服务器拷贝。在大多数现代操作系统上，这个量很容易得到。
但是，如果你运行了很多个服务器副本，或者显式配置服务器以使用大量 System V 共享内存(参见 shared_memory_type 和 dynamic_shared_memory_type)，
可能需要增加SHMALL（系统范围内 System V 共享内存的总量）。注意在很多系统上SHMALL是以页面而不是字节来度量。
不太可能出问题的是共享内存段的最小尺寸（SHMMIN），对PostgreSQL来说应该最多大约是 32 字节（通常只是1）。而系统范围（SHMMNI）或每个进程（SHMSEG）的最大共享内存段数目不太可能会导致问题，除非你的系统把它们设成零。
使用 System V 信号量时，PostgreSQL 每个允许的连接
(max_connections)、允许的 autovacuum 工作进程
(autovacuum_worker_slots), 允许的 WAL 发送进程
(max_wal_senders), 允许的后台
进程 (max_worker_processes) 等，每 16 个集合使用一个信号量。
运行时计算的参数 num_os_semaphores
报告所需的信号量数量。可以在启动服务器之前通过
postgres 命令查看此参数，例如：
$ postgres -D $PGDATA -C num_os_semaphores
每组 16 个信号量还将包含第 17 个信号量，该信号量包含一个 “魔数”，
用于检测与其他应用程序使用的信号量集合的冲突。系统中信号量的最大数量
由 SEMMNS 设置，因此必须至少与 num_os_semaphores
一样高，并且每组 16 个所需信号量额外加一个（请参见 表 18.1 中的公式）。参数 SEMMNI
确定系统中可以同时存在的信号量集合的数量限制。因此，该参数必须至少为
ceil(num_os_semaphores / 16)。
降低允许的连接数量是对故障的临时解决方法，
这些故障通常会令人困惑地表述为 “设备上没有剩余空间”，来自函数 semget。
在某些情况下可能还有必要增大SEMMAP，使之至少与SEMMNS相近。如果系统有这个参数(很多系统没有)，这个参数定义信号量资源映射的尺寸，在其中每个连续的可用信号量块都需要一项。 每当一个信号量集合被释放，那么它要么会被加入到该与被释放块相邻的一个现有项，或者它会被注册在一个新映射项中。如果映射被填满，被释放的信号量将丢失（直到重启）。因此信号量空间的碎片时间长了会导致可用的信号量比应有的信号量少。
与“semaphore undo”有关的其他各种设置，如SEMMNU和SEMUME
不会影响PostgreSQL。
使用 POSIX 信号量时，所需的信号量数量与 System V 相同，
即每个允许的连接 (max_connections)、允许的 autovacuum 工作进程
(autovacuum_worker_slots), 允许的 WAL 发送进程
(max_wal_senders), 允许的后台
进程 (max_worker_processes) 等。
在首选此选项的平台上，POSIX 信号量的数量没有特定的内核限制。
FreeBSD
默认共享内存设置通常就足够了，除非您已将 shared_memory_type 设置为 sysv。 在此平台上不使用 System V 信号量。
可以使用sysctl或loader接口来改变默认IPC配置。下列参数可以使用sysctl设置：
# sysctl kern.ipc.shmall=32768
# sysctl kern.ipc.shmmax=134217728
要让这些设置在重启之后也保持，请修改/etc/sysctl.conf。
如果您已将 shared_memory_type 设置为 sysv，您可能还想配置您的内核以将 System V 共享内存锁定到 RAM 中并防止它被调出以进行交换。 这可以使用 sysctl 设置 kern.ipc.shm_use_phys 来完成。
如果在 FreeBSD jail 中运行，您应该将它的 sysvshm 参数设置为 new，这样它就有自己独立的 System V 共享内存命名空间。 （在 FreeBSD 11.0 之前，有必要从 jail 启用对主机 IPC 命名空间的共享访问，并采取措施避免冲突。）
NetBSD
默认的共享内存设置通常足够好，除非您将 shared_memory_type 设置为 sysv。
但是，您需要增加 kern.ipc.semmni
和 kern.ipc.semmns，
因为 NetBSD 的默认设置
对这些来说太小而无法使用。
可以使用 sysctl 调整 IPC 参数，例如：
# sysctl -w kern.ipc.semmni=100
要使这些设置在重新启动后保持不变，请修改 /etc/sysctl.conf。
如果您已将 shared_memory_type 设置为 sysv，您可能还想配置您的内核以将 System V 共享内存锁定到 RAM 中并防止它被调出以进行交换。 这可以使用 sysctl 设置 kern.ipc.shm_use_phys 来完成。
OpenBSD
默认的共享内存设置通常足够好，除非您将 shared_memory_type 设置为 sysv。
但是，您需要增加 kern.seminfo.semmni
和 kern.seminfo.semmns，
因为 OpenBSD 的默认设置
对这些来说太小而无法使用。
可以使用 sysctl 调整 IPC 参数，例如：
# sysctl kern.seminfo.semmni=100
要使这些设置在重新启动后保持不变，请修改 /etc/sysctl.conf。
Linux
默认的共享内存设置通常已经足够好了，除非您将shared_memory_type设置为sysv，
即使这样，也只适用于低默认值的旧内核版本。System V信号量不在此平台上使用。
共享内存大小设置可以通过sysctl界面更改。例如，允许 16 GB：
$ sysctl -w kernel.shmmax=17179869184
$ sysctl -w kernel.shmall=4194304
要使这些设置在重新启动时保持不变，请参见/etc/sysctl.conf。
macOS
默认共享内存和信号量设置通常就足够了，除非您已将 shared_memory_type 设置为 sysv。
在 macOS 中配置共享内存的推荐方法是创建一个名为/etc/sysctl.conf的文件，其中包含这样的变量赋值：
kern.sysv.shmmax=4194304
kern.sysv.shmmin=1
kern.sysv.shmmni=32
kern.sysv.shmseg=8
kern.sysv.shmall=1024
注意在某些 macOS 版本中，所有五个共享内存参数必须在/etc/sysctl.conf中设置，否则值将会被忽略。
SHMMAX 只能设置为 4096 的倍数。
在这个平台上，SHMALL以 4 kB 的页面度量。
可以使用 sysctl 动态更改除 SHMMNI 之外的所有内容。但是最好还是通过/etc/sysctl.conf来设置你喜欢的值，这样重启之后这些值就可以被保持。
Solarisillumos
默认的共享内存和信号量设置对于大多数 PostgreSQL 应用程序来说通常已经足够了。Solaris 现在将SHMMAX的默认值设置为系统 RAM的四分之一。要进一步调整这个设置，使用与postgres用户有关的一个项目设置。例如，以root运行下列命令：
projadd -c "PostgreSQL DB User" -K "project.max-shm-memory=(privileged,8GB,deny)" -U postgres -G postgres user.postgres
这个命令增加user.postgres项目并且将用于postgres用户的最大共享内存设置为 8GB，并且在下次用户登录进来时或重启PostgreSQL（不是重新载入）时生效。上述假定PostgreSQL是由postgres组中的postgres用户所运行。不需要重新启动服务器。
对于将有大量连接的数据库服务器，我们推荐的其他内核设置修改是：
project.max-shm-ids=(priv,32768,deny)
project.max-sem-ids=(priv,4096,deny)
project.max-msg-ids=(priv,4096,deny)
此外，如果你正在在一个区中运行PostgreSQL，你可能也需要提升该区的资源使用限制。更多关于projects 和prctl的信息请见System Administrator's Guide中的 "Chapter2:  Projects and Tasks"。
18.4.2. systemd RemoveIPC #
如果正在使用systemd，则必须注意IPC资源（包括共享内存）
不会被操作系统过早删除。从源代码安装PostgreSQL时，这尤其值得关注。
PostgreSQL发布包的用户不太可能受到影响，因为postgres用户通常是作为系统用户创建的。
RemoveIPC设置在logind.conf中控制当用户完全退出时
是否移除IPC对象。系统用户免除。此设置在默认的systemd中默认为on，
但某些操作系统发行版默认为关闭。
当此设置打开时，典型的观察效果是用于并行查询执行的共享内存对象在明显随机的时间被删除，
导致在尝试打开和删除它们时出现错误和警告，例如
WARNING:  could not remove shared memory segment "/PostgreSQL.1450751626": No such file or directory
不同类型的IPC对象（共享内存与信号量，System V与POSIX）在systemd
中略有不同，因此可能会发现某些IPC资源不会像其他IPC资源一样被删除。
但依靠这些微妙的差异是不可取的。
“注销用户”可能会作为维护工作的一部分发生，或者当管理员以
postgres用户或类似名称登录时手动发生，所以通常难以防止。
什么是“系统用户”是由/etc/login.defs中的
SYS_UID_MAX设置在systemd编译时确定的。
打包和部署脚本应该小心，通过使用useradd -r、
adduser --system或等价物来创建postgres用户作为系统用户。
或者，如果用户帐户创建不正确或无法更改，建议设置
RemoveIPC=no
在/etc/systemd/logind.conf或其他适当的配置文件中。
小心
至少要确保这两件事中的一件，否则PostgreSQL服务器将非常不可靠。
18.4.3. 资源限制 #
Unix类操作系统强制了许多种资源限制，这些限制可能干扰你的PostgreSQL服务器的操作。尤其重要的是对每个用户的进程数目的限制、每个进程打开文件数目的限制以及每个进程可用的内存的限制。这些限制中每个都有一个“硬”限制和一个“软”限制。实际使用的是软限制，但用户可以自己修改成最大为硬限制的数目。而硬限制只能由root用户修改。系统调用setrlimit负责设置这些参数。 shell的内建命令ulimit（Bourne shells）或limit（csh）被用来从命令行控制资源限制。 在 BSD 衍生的系统上，/etc/login.conf文件控制在登录期间设置的各种资源限制。详见操作系统文档。相关的参数是maxproc、openfiles和datasize。例如：
default:\
...
:datasize-cur=256M:\
:maxproc-cur=256:\
:openfiles-cur=256:\
...
（-cur是软限制。增加-max可设置硬限制）。
内核还可以对一些资源，设置系统范围的限制。
在Linux上，内核参数
fs.file-max确定内核支持的最大打开文件数。
可以使用sysctl -w fs.file-max=N来更改它。
要使设置在重新启动后保持不变，在/etc/sysctl.conf中添加一个赋值。
每个进程的文件上限在内核编译时固定；请参阅
/usr/src/linux/Documentation/proc.txt获取更多信息。
PostgreSQL服务器为每个连接都使用一个进程，所以你应该至少和允许的连接同样多的进程，再加上系统其他部分所需要的进程数目。通常这个并不是什么问题，但如果你在一台机器上运行多个服务器，资源使用可能就会紧张。
打开文件的出厂默认限制通常设置为“socially friendly”的值，它允许许多用户在一台机器上共存，而不会导致不成比例的系统资源使用。如果你在一台机器上运行许多服务器，这也许就是你想要的，但是在专门的服务器上，你可能需要提高这个限制。
在另一方面，一些系统允许独立的进程打开非常多的文件；如果不止几个进程这么干，那系统范围的限制就很容易被超过。如果你发现这样的现象，并且不想修改系统范围的限制，你就可以设置PostgreSQL的 max_files_per_process配置参数来限制打开文件数的消耗。
另一个在支持大量客户端连接时可能需要关注的内核限制是最大套接字连接队列长度。如果在非常短的时间内到达的连接请求超过了这个数量，一些请求可能会在PostgreSQL服务器能够处理这些请求之前被拒绝，这些客户端会收到一些无帮助的连接失败错误，例如“资源暂时不可用”或“连接被拒绝”。在许多平台上，默认的队列长度限制是128。要提高这个限制，可以通过sysctl调整相应的内核参数，然后重启PostgreSQL服务器。这个参数在不同系统中的名称有所不同，例如在Linux上是net.core.somaxconn，在较新的FreeBSD上是kern.ipc.soacceptqueue，而在macOS和其他BSD变种上是kern.ipc.somaxconn。
18.4.4. Linux 内存过量使用 #
Linux上默认的虚拟内存行为对PostgreSQL不是最优的。
由于内核实现内存过量使用的方法，如果PostgreSQL或其他进程的内存要求导致系统用光虚拟内存，那么内核可能会终止PostgreSQL的 postmaster 进程（主管服务器进程）。
如果发生了这样的事情，你会看到像下面这样的内核消息（参考你的系统文档和配置，看看在哪里能看到这样的消息）：
Out of Memory: Killed process 12345 (postgres).
这表明postgres进程因为内存压力而被终止了。尽管现有的数据库连接将继续正常运转，但是新的连接将无法被接受。要想恢复，PostgreSQL需要被重启。
一种避免这个问题的方法是在一台你确信其他进程不会耗尽内存的机器上运行PostgreSQL。 如果内存资源紧张，增加操作系统的交换空间可以帮助避免这个问题，因为内存不足（OOM）杀手（即终止进程这种行为）只有当物理内存和交换空间都被用尽时才会被调用。
如果PostgreSQL本身是导致系统内存耗尽的原因，你可以通过改变你的配置来避免该问题。在某些情况下，降低内存相关的配置参数可能有所帮助，特别是shared_buffers、work_mem和hash_mem_multiplier。在其他情况下，允许太多连接到数据库服务器本身也可能导致该问题。在很多情况下，最好减小max_connections并且转而利用外部连接池软件。
可以修改内核的行为，这样它将不会“过量使用”内存。尽管此设置不会阻止OOM 杀手被调用，但它可以显著地降低其可能性并且将因此得到更鲁棒的系统行为。这可以通过用sysctl选择严格的过量使用模式来实现：
sysctl -w vm.overcommit_memory=2
或者在/etc/sysctl.conf中放置一个等效的项。你可能还希望修改相关的设置vm.overcommit_ratio。 详细信息请参阅内核文档的https://www.kernel.org/doc/Documentation/vm/overcommit-accounting文件。
另一种方法，可以在修改或不修改vm.overcommit_memory的情况下使用，
是为postmaster进程设置特定的OOM分数调整值为-1000，
从而保证它不会成为OOM杀手的目标。最简单的方法是在
echo -1000 > /proc/self/oom_score_adj
命令中执行此操作，并将其放在PostgreSQL启动脚本中，
紧接着调用postgres之前。
请注意，此操作必须以root身份执行，否则将不起作用；
因此，使用一个由root拥有的启动脚本是最简单的方式。如果您这样做，
您还应该在启动脚本中调用postgres之前设置以下环境变量：
export PG_OOM_ADJUST_FILE=/proc/self/oom_score_adj
export PG_OOM_ADJUST_VALUE=0
这些设置将使postmaster子进程以正常的零OOM分数调整运行，
这样在需要时OOM杀手仍然可以将其作为目标。如果您希望子进程以其他
OOM分数调整运行，可以为PG_OOM_ADJUST_VALUE使用其他值。
（PG_OOM_ADJUST_VALUE也可以省略，在这种情况下它默认为零。）
如果您不设置PG_OOM_ADJUST_FILE，子进程将以与postmaster相同的
OOM分数调整运行，这是不明智的，因为整个重点是确保postmaster具有优先设置。
18.4.5. Linux 大页面 #
使用大页可以减少使用大块连续内存时的开销，例如
PostgreSQL，特别是在使用较大的
shared_buffers值时。要在
PostgreSQL中使用此功能，您需要一个内核，
其中包含CONFIG_HUGETLBFS=y和
CONFIG_HUGETLB_PAGE=y。您还需要配置操作系统以提供
足够数量的所需大小的大页。运行时计算的参数
shared_memory_size_in_huge_pages报告所需的大页数量。
在启动服务器之前，可以通过以下postgres命令查看此参数：
$ postgres -D $PGDATA -C shared_memory_size_in_huge_pages
3170
$ grep ^Hugepagesize /proc/meminfo
Hugepagesize:       2048 kB
$ ls /sys/kernel/mm/hugepages
hugepages-1048576kB  hugepages-2048kB
在此示例中，默认大小为2MB，但您也可以通过
huge_page_size显式请求2MB或1GB，
以适应shared_memory_size_in_huge_pages
计算的页数。
虽然在此示例中我们至少需要3170个大页，
但如果机器上的其他程序也需要大页，则更大的设置会更合适。
我们可以通过以下方式设置：
# sysctl -w vm.nr_hugepages=3170
不要忘记将此设置添加到/etc/sysctl.conf，
以便在重启后重新应用。对于非默认的大页大小，
我们可以改用以下方式：
# echo 3170 > /sys/kernel/mm/hugepages/hugepages-2048kB/nr_hugepages
还可以通过内核参数（如hugepagesz=2M hugepages=3170）
在启动时提供这些设置。
有时候内核在分片期间会无法立即分配想要数量的大页面，所以可能有必要重复该命令或者重新启动。
（在重新启动之后，应立即将大部分机器的内存转换为大页面。）
要验证大页面对给出大小的分配情况，请使用：
$ cat /sys/kernel/mm/hugepages/hugepages-2048kB/nr_hugepages
可能还需要赋予数据库服务器的操作系统用户权限，让他能通过sysctl
设置vm.hugetlb_shm_group以使用大页面，
和/或赋予使用ulimit -l锁定内存的权限。
PostgreSQL中大页面的默认行为是尽可能使用它们，用系统的默认大页面大小，并且在失败时转回到正常页面。
要强制使用大页面，你可以在postgresql.conf中把huge_pages设置成on。
注意此设置下如果没有足够的大页面可用，PostgreSQL将会启动失败。
Linux大页面特性的详细描述可见https://www.kernel.org/doc/Documentation/vm/hugetlbpage.txt.
上一页 上一级 下一页18.3. 启动数据库服务器 起始页 18.5. 关闭服务器
