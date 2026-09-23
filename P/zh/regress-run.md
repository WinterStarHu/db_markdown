# 31.1. 运行测试

31.1. 运行测试
版本：
纠错本页面
搜索
目录导航
❮
❯
31.1. 运行测试 #31.1.1. 在临时安装上运行测试31.1.2. 在一个现有安装上运行测试31.1.3. 附加测试套件31.1.4. 区域和编码31.1.5. 自定义服务器设置31.1.6. 额外测试
回归测试可以针对已经安装并运行的服务器进行，也可以在构建树中使用临时
安装进行。此外，测试有“并行”模式和“顺序”模式。
顺序方法是单独运行每个测试脚本，而并行方法会启动多个服务器进程以并行
运行一组测试。并行测试增加了对进程间通信和锁定正常工作的信心。即使在
“并行”模式下，有些测试也可能需要顺序运行，这是由测试本身
的要求决定的。
31.1.1. 在临时安装上运行测试 #
要在构建之后但安装之前运行并行回归测试，请输入：
make check
在顶级目录中。（或者您可以切换到
src/test/regress并在那里运行命令。）
并行运行的测试以“+”为前缀，顺序运行的测试以
“-”为前缀。
最后，您应该会看到类似以下内容：
# 所有 213 个测试通过。
或者是关于哪些测试失败的说明。在假设
“失败”代表严重问题之前，请参阅下面的
第 31.2 节。
因为这种测试方法运行一个临时服务器，如果你作为超级用户进行了编译，它将无法工作，因为服务器无法以超级用户身份启动。我们推荐的过程是不要作为超级用户编译，或者在完成安装后执行测试。
如果你已经配置PostgreSQL安装到一个已经存在有旧的PostgreSQL安装的位置，并且你在安装新版本前执行了make check，你可能会发现测试会因为新程序尝试使用已经安装的共享库而失败（典型特征是抱怨未定义的符号）。如果你希望在覆盖旧安装之前运行测试，你将需要使用configure --disable-rpath编译。但是我们不推荐为最终安装使用这个选项。
并行回归测试会在你的用户 ID 下启动相当多的进程。当前，最大并发量是二十个并行测试脚本，这意味着四十个进程：对每一个测试脚本有一个服务器进程和一个psql进程。因此如果你的系统对每个用户的进程数有强制限制，确保这个限制至少是五十，否则你将在并行测试中遇到随机失败。如果你没有权利提升该限制，你可以通过设置MAX_CONNECTIONS参数来降低并发度。例如：
make MAX_CONNECTIONS=10 check
会并发运行不超过十个测试。
31.1.2. 在一个现有安装上运行测试 #
要在安装后运行测试（见第 17 章），初始化一个数据目录并且按照第 18 章所解释的启动服务器，然后输入：
make installcheck
或者进行一次并行测试：
make installcheck-parallel
该测试将期望联系在本地主机和默认端口号上的服务器（除非通过PGHOST和PGPORT环境变量覆盖）。该测试将在一个名为regression的数据库中运行，任何以该名称存在的数据库将被删除。
该测试还将短暂地创建一些集簇范围内的对象，例如角色、表空间和订阅。这些对象的名称都会以regress_开始。在实际具有以这种方式命名的全局对象的安装中使用installcheck模式时要格外小心。
31.1.3. 附加测试套件 #
make check和make installcheck命令只运行“核心”回归测试，这只测试PostgreSQL服务器的内建功能。源代码发布包含许多额外的测试套件，它们中的大部分用于测试附加功能，例如可选的过程语言。
要运行将被编译模块的所有测试套件（包括核心测试），在编译树的顶端输入这些命令之一：
make check-world
make installcheck-world
这些命令分别在临时服务器或已经安装好的服务器上运行测试（与之前介绍的make check和make installcheck类似）。
其他的考虑与之前为每种方法解释的相同。注意make check-world为每一个受测模块建立一个独立的实例（临时数据目录），因此它比make installcheck-world需要更多的时间和磁盘空间。
在具有多个 CPU 内核且没有严格操作系统限制的现代计算机上，你可以通过并行化使操作速度大大加快。
大多数 PostgreSQL 开发人员实际用于运行所有测试的方法类似于这样
make check-world -j8 >/dev/null
通过-j限制接近或略高于可用内核数。当你只是想验证成功时，放弃stdout消除那些没有意义的闲杂信息。
（如果发生故障，stderr消息通常足以确定要查找的位置。）
你也可以通过在编译树适当的子目录中输入make check或make installcheck来运行个体的测试套件。记住make installcheck假设你已经安装了相关模块，而不仅仅是核心服务器。
可以以这种方法调用的额外测试包括：
可选过程语言的回归测试。这些位于src/pl之下。
contrib模块的回归测试，位于contrib。不是所有的contrib模块都有测试。
接口库的回归测试，位于src/interfaces/libpq/test和
src/interfaces/ecpg/test。
位于src/test/authentication的核心支持的身份验证方法的测试。（更多身份验证相关的测试请参阅下文。）
并发会话行为的压力测试，位于src/test/isolation。
崩溃恢复和物理复制的测试，位于src/test/recovery。
逻辑复制的测试，位于src/test/subscription。
客户端程序的测试，位于src/bin下。
在使用installcheck模式时，这些测试将建立并销毁名字包括regression的测试数据库，例如pl_regression或contrib_regression。请注意使用installcheck模式，对于安装时以这种方式命名的任何非测试数据库。
其中一些辅助测试套件使用的TAP基础结构在第 31.4 节中解释。只有在PostgreSQL使用选项--enable-tap-tests配置时，基于TAP的测试才能被运行。推荐在开发时使用这种方式，但如果没有合适的Perl安装可用也可以忽略。
一些测试套件默认情况下不会运行，原因可能是它们在多用户系统上不安全，或者需要特殊软件，或者资源消耗较大。您可以通过设置make或环境变量PG_TEST_EXTRA为以空格分隔的列表来决定额外运行哪些测试套件，例如：
make check-world PG_TEST_EXTRA='kerberos ldap ssl load_balance libpq_encryption'
当前支持以下值：
kerberos
在 src/test/kerberos 下运行测试套件。 这
需要一个 MIT Kerberos 安装并打开 TCP/IP 监听套接字。
ldap
在 src/test/ldap 下运行测试套件。 这
需要一个 OpenLDAP 安装并打开
TCP/IP 监听套接字。
libpq_encryption
运行测试 src/interfaces/libpq/t/005_negotiate_encryption.pl。
这会打开 TCP/IP 监听套接字。如果 PG_TEST_EXTRA
还包括 kerberos，则启用需要
MIT Kerberos 安装的附加测试。
load_balance
运行测试 src/interfaces/libpq/t/004_load_balance_dns.pl。
这需要编辑系统 hosts 文件并
打开 TCP/IP 监听套接字。
oauth
在 src/test/modules/oauth_validator 下运行测试套件。
这会为运行 HTTPS 的测试服务器打开 TCP/IP 监听套接字。
regress_dump_restore
在 src/bin/pg_upgrade/t/002_pg_upgrade.pl 中运行
额外的测试套件，该测试套件通过 pg_dump/
pg_restore 循环回归数据库。默认情况下未启用，
因为它资源消耗较大。
sepgsql
在 contrib/sepgsql 下运行测试套件。 这
需要以特定方式设置的 SELinux 环境；请参见
第 F.40.3 节。
ssl
在 src/test/ssl 下运行测试套件。 这会打开 TCP/IP 监听套接字。
wal_consistency_checking
在运行某些测试时使用 wal_consistency_checking=all
在 src/test/recovery 下。默认情况下未启用，
因为它资源消耗较大。
xid_wraparound
在 src/test/modules/xid_wraparound 下运行测试套件。
默认情况下未启用，因为它消耗资源较多。
测试当前构建配置不支持的功能，即使它们在
PG_TEST_EXTRA 中提到，也不会运行。
此外，在 src/test/modules 中的测试，将由 make check-world 而不是 make installcheck-world 运行。
这是因为它们安装非生产扩展，或者具有其他被认为不适合生产安装的副作用。
如果你愿意，你可以在这些子目录中使用 make install 和 make installcheck，但不建议使用非测试服务器执行此操作。
31.1.4. 区域和编码 #
默认情况下，测试使用的临时安装将使用在当前环境中定义的区域和由 initdb 决定的相应数据库编码。通过设置适当的环境变量来测试不同的区域是有用的，例如：
make check LANG=C
make check LC_COLLATE=en_US.utf8 LC_CTYPE=fr_CA.utf8
由于实现的原因，为此目的设置 LC_ALL 不能工作，所有其他区域相关的环境变量都可以工作。
在对一个现有安装测试时，区域由现有数据库集簇决定并且不能为测试而独立设置。
你也可以通过设置变量ENCODING来显式地选择数据库编码，例如：
make check LANG=C ENCODING=EUC_JP
这样设置数据库编码通常只对区域为 C 有意义；否则编码将自动从区域选择，并且指定一个不匹配区域的编码将会导致错误。
不管测试是针对临时安装还是已有安装，数据库编码都可以被设置，然而在后一种情况中它必须与安装的区域相兼容。
31.1.5. 自定义服务器设置 #
运行测试套件时，有多种方法可以使用自定义服务器设置。这样做可以启用额外的日志记录，
调整资源限制，或启用额外的运行时检查，例如debug_discard_caches。
但请注意，并非所有测试都能在任意设置下顺利通过。
额外的选项可以通过环境变量PG_TEST_INITDB_EXTRA_OPTS传递给在测试设置期间
内部运行的各种initdb命令。例如，要启用校验和并使用自定义的WAL段大小和
work_mem设置运行测试，请使用：
make check PG_TEST_INITDB_EXTRA_OPTS='-k --wal-segsize=4 -c work_mem=50MB'
对于核心回归测试套件和其他由pg_regress驱动的测试，
也可以在PGOPTIONS环境变量中设置自定义运行时服务器
配置（针对允许此操作的设置），例如：
make check PGOPTIONS="-c debug_parallel_query=regress -c work_mem=50MB"
（这利用了libpq提供的功能；详情请参见options。）
在针对临时安装运行时，也可以通过提供预先编写的postgresql.conf来设置自定义配置：
echo 'log_checkpoints = on' > test_postgresql.conf
echo 'work_mem = 50MB' >> test_postgresql.conf
make check EXTRA_REGRESS_OPTS="--temp-config=test_postgresql.conf"
31.1.6. 额外测试 #
核心回归测试套件包含一些默认情况下不被运行的测试文件，因为它们可能是平台相关的或者需要很长时间来运行。你可以通过设置变量EXTRA_TESTS来运行这些或其他额外测试文件。例如，要运行numeric_big测试：
make check EXTRA_TESTS=numeric_big
上一页 上一级 下一页第 31 章 回归测试 起始页 31.2. 测试评估
