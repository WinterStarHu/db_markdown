# 17.3. 使用Autoconf和Make进行构建和安装

17.3. 使用Autoconf和Make进行构建和安装
版本：
纠错本页面
搜索
目录导航
❮
❯
17.3. 使用Autoconf和Make进行构建和安装 #17.3.1. 简单版17.3.2. 安装过程17.3.3. configure 选项17.3.4. configure 环境变量17.3.1. 简单版 #
./configure
make
su
make install
adduser postgres
mkdir -p /usr/local/pgsql/data
chown postgres /usr/local/pgsql/data
su - postgres
/usr/local/pgsql/bin/initdb -D /usr/local/pgsql/data
/usr/local/pgsql/bin/pg_ctl -D /usr/local/pgsql/data -l logfile start
/usr/local/pgsql/bin/createdb test
/usr/local/pgsql/bin/psql test
详细版本是本章节的其余部分。
17.3.2. 安装过程 #配置
安装过程的第一步就是为你的系统配置源代码树并选择你喜欢的选项。这个工作是通过运行configure脚本实现的，对于默认安装，你只需要简单地输入：
./configure
该脚本将运行一些测试来决定各种系统相关的变量，并检测你的操作系统的特殊设置，最后将在编译树中创建一些文件以记录它找到了什么。
如果你想保持编译目录与原始源文件分开，你也可以在一个源码树之外的目录中运行configure，然后在那里构建。这个过程被称为VPATH编译。做法如下：
mkdir build_dir
cd build_dir
/path/to/source/tree/configure [options go here]
make
默认设置将编译服务器和工具，以及所有只需要 C 编译器的客户端应用程序和接口。默认情况下，所有文件将安装到/usr/local/pgsql。
您可以通过向configure提供一个或多个命令行选项来自定义构建和安装过程。通常，您会自定义安装位置或构建的一组可选功能。configure有大量的选项，在第 17.3.3 节中有描述。
此外，configure响应某些环境变量，如第 17.3.4 节中所述。这些提供了自定义配置的其他方法。
Build
要开始构建，请键入：
make
make all
（记得使用GNU make。）
构建将需要几分钟时间，具体取决于您的硬件。
如果您想构建可以构建的所有内容，包括文档（HTML 和手册页）和附加模块（contrib），请改为键入：
make world
如果您想构建可以构建的所有内容，包括附加模块（contrib），但不包括文档，请改为键入：
make world-bin
如果要从另一个 makefile 调用构建而不是手动调用，则必须取消设置MAKELEVEL或将其设置为零，例如：
build-postgresql:
$(MAKE) -C postgresql MAKELEVEL=0 all
不这样做可能会导致奇怪的错误消息，通常是关于缺少头文件。
回归测试
如果您想在安装之前测试新构建的服务器，您可以在此时运行回归测试。
回归测试是一个测试套件，用于验证PostgreSQL
是否以开发人员期望的方式在您的机器上运行。输入：
make check
（这不会以 root 身份运行；以非特权用户身份进行。）有关解释测试结果的详细信息，
请参阅第 31 章。您可以在以后的任何时间通过发出相同的命令重复此测试。
安装文件注意
如果您要升级现有系统，请务必阅读第 18.6 节，其中包含有关升级集簇的说明。
要安装PostgreSQL，请输入：
make install
这会将文件安装到步骤 1中指定的目录中。
确保您具有写入该区域的适当权限。通常，您需要以 root 身份执行此步骤。
或者，您可以提前创建目标目录并安排授予适当的权限。
要安装文档（HTML 和手册页），请输入：
make install-docs
如果您构建了上面的世界，请输入：
make install-world
这也会安装文档。
如果您构建了除上述文档之外的所有内容，请输入：
make install-world-bin
您可以使用make install-strip而不是
make install来剥离安装的可执行文件和库。这将节省一些空间。
如果您使用调试支持构建，剥离将有效地移除调试支持，因此只有在不再需要调试时才应该这样做。
install-strip试图做一个合理的工作来节省空间，
但它不知道如何从可执行文件中去除每个不需要的字节，所以如果您想节省所有的磁盘空间，
您将不得不做手工工作。
标准安装提供客户端应用程序开发以及服务器端程序开发所需的所有头文件，例如用 C 编写的自定义函数或数据类型。
仅客户端安装：.
如果只想安装客户端应用程序和接口库，则可以使用以下命令：
make -C src/bin install
make -C src/include install
make -C src/interfaces install
make -C doc install
src/bin有一些仅供服务器使用的二进制文件，但它们很小。
卸载：.
要撤消安装，请使用命令make uninstall。但是，这不会删除任何创建的目录。
清理：.
安装后，您可以通过使用命令make clean从源树中删除构建的文件来释放磁盘空间。
这将保留configure程序生成的文件，以便您稍后可以使用make重建所有内容。
要将源树重置为分发时的状态，请使用make distclean。如果要在同一源树中为多个平台构建，
则必须执行此操作并为每个平台重新配置。（或者，为每个平台使用单独的构建树，以便源树保持不变。）
如果您执行构建然后发现您的configure选项错误，或者如果您更改了configure调查的任何内容（例如，软件升级），那么在重新配置和重建之前执行make distclean是个好主意。没有这个，您对配置选择的更改可能不会传播到它们需要的任何地方。
17.3.3. configure 选项 #
configure的命令行选项解释如下。这个列表并不详尽（使用./configure --help
来获得一个）。此处未涵盖的选项适用于交叉编译等高级用例，并记录在标准Autoconf文档中。
17.3.3.1. 安装位置 #
这些选项控制make install将放置文件的位置。
--prefix选项在大多数情况下就足够了。
如果您有特殊需要，可以使用本节中描述的其他选项自定义安装子目录。 但是请注意，更改不同子目录的相对位置可能会使安装不可重定位，这意味着您将无法在安装后移动它。
（man和doc位置不受此限制的影响。）
对于可重定位安装，您可能需要使用--disable-rpath选项稍后描述。
--prefix=PREFIX #
把所有文件装在目录PREFIX中而不是/usr/local/pgsql中。实际的文件会安装到数个子目录中；没有一个文件会直接安装到PREFIX目录里。
--exec-prefix=EXEC-PREFIX #
你可以把体系相关的文件安装到一个不同的前缀下（EXEC-PREFIX），而不是PREFIX中设置的地方。这样做可以比较方便地在不同主机之间共享体系无关的文件。如果你省略这些，那么EXEC-PREFIX就会被设置为等于PREFIX，并且体系相关和体系无关的文件都会安装到同一棵目录树下，这也可能是你想要的。
--bindir=DIRECTORY #
为可执行程序指定目录。默认是EXEC-PREFIX/bin，通常也就是/usr/local/pgsql/bin。
--sysconfdir=DIRECTORY #
用于各种配置文件的目录，默认为PREFIX/etc。
--libdir=DIRECTORY #
设置安装库和动态加载模块的目录。默认是EXEC-PREFIX/lib。
--includedir=DIRECTORY #
设置 C 和 C++ 头文件的安装目录。默认是PREFIX/include。
--datarootdir=DIRECTORY #
设置多种只读数据文件的根目录。这只为后面的某些选项设置默认值。默认是PREFIX/share。
--datadir=DIRECTORY #
设置被安装的程序使用的只读数据文件的目录。默认值为DATAROOTDIR。注意这与数据库文件的放置位置无关。
--localedir=DIRECTORY #
设置安装区域数据的目录，特别是消息翻译目录文件。默认值为DATAROOTDIR/locale。
--mandir=DIRECTORY #
PostgreSQL自带的手册页将安装到这个目录，它们被安装在相应的manx子目录里。默认是DATAROOTDIR/man。
--docdir=DIRECTORY #
设置安装文档文件的根目录，“man”页不包含在内。这只为后续选项设置默认值。这个选项的默认值为DATAROOTDIR/doc/postgresql。
--htmldir=DIRECTORY #
PostgreSQL的 HTML 格式文档将被安装在这个目录中。默认值为DATAROOTDIR。
注意
为了让PostgreSQL能够安装在一些共享的安装位置（例如/usr/local/include），同时又不至于与系统其他部分产生名字空间干扰，我们特别做了一些处理。首先，安装脚本会自动给datadir、sysconfdir和docdir后面附加上“/postgresql”字符串，除非展开的完整路径名已经包含字符串“postgres”或者“pgsql”。例如，如果你选择/usr/local作为前缀，那么文档将安装在/usr/local/doc/postgresql，但如果前缀是/opt/postgres，那么它将被放到/opt/postgres/doc。客户端接口的公共 C 头文件安装到了includedir，并且是名字空间无关的。内部的头文件和服务器头文件都安装在includedir下的私有目录中。参考每种接口的文档获取关于如何访问头文件的信息。最后，如果合适，那么也会在libdir下创建一个私有的子目录用于动态可装载的模块。
17.3.3.2. PostgreSQL 特性 #
本节中描述的选项支持构建默认情况下未构建的各种PostgreSQL特性。
其中大部分是非默认的，只是因为它们需要额外的软件，如第 17.1 节中所述。
--enable-nls[=LANGUAGES] #
打开本地语言支持（NLS），也就是以非英文显示程序消息的能力。
LANGUAGES是一个空格分隔的语言代码列表，表示你想支持的语言。
例如--enable-nls='de fr'。（你提供的列表和实际支持的列表之间的交集将会自动计算出来。）
如果你没有声明一个列表，那么就会安装所有可用的翻译。
要使用这个选项，你需要一个Gettext API的实现。
--with-perl #
构建PL/Perl服务器端编程语言。
--with-python #
构建PL/Python服务器端编程语言。
--with-tcl #
构建PL/Tcl服务器端编程语言。
--with-tclconfig=DIRECTORY #
Tcl安装文件tclConfig.sh，其中包含编译与Tcl接口的模块所需的配置信息。
该文件通常可以自动地在一个众所周知的位置找到，但是如果你需要一个不同版本的Tcl，
你可以指定在其中查找tclConfig.sh的目录。
--with-llvm #
构建支持基于 LLVM 的
JIT 编译（请参见 第 30 章）。这
需要安装 LLVM 库。
目前 LLVM 的最低版本要求为 14。
llvm-config
将用于查找所需的编译选项。
llvm-config 将在您的
PATH 中搜索。如果找不到所需的程序，
请使用 LLVM_CONFIG 指定正确的
llvm-config 路径。例如
./configure ... --with-llvm LLVM_CONFIG='/path/to/llvm/bin/llvm-config'
LLVM 支持需要兼容的 clang 编译器
（必要时使用 CLANG 环境变量指定）和有效的 C++
编译器（必要时使用 CXX 环境变量指定）。
--with-lz4 #
使用 LZ4 压缩支持构建。
--with-zstd #
使用 Zstandard 压缩支持构建。
--with-ssl=LIBRARY
#
构建支持 SSL（加密）连接。唯一支持的
LIBRARY 是 openssl，
用于 OpenSSL 和
LibreSSL。这需要安装
OpenSSL 包。
configure 将检查所需的
头文件和库，以确保您的
OpenSSL 安装足够
后再继续。
--with-openssl #
相当于以前的 --with-ssl=openssl。
--with-gssapi #
构建支持GSSAPI认证的功能。需要安装MIT Kerberos以支持GSSAPI。在许多系统上，
GSSAPI系统（MIT Kerberos安装的一部分）并未安装在默认搜索的位置（例如，
/usr/include，/usr/lib），因此您必须
使用选项--with-includes和--with-libraries
来配合此选项。configure将在继续之前检查所需的头文件和
库，以确保您的GSSAPI安装足够完善。
--with-ldap #
为认证和连接参数查找编译LDAP支持
（详见第 32.18 节和第 20.10 节）。在 Unix 上，这需要安装OpenLDAP包。在 Windows 上将使用默认的WinLDAP库。configure将检查所需的头文件和库，以确保您的OpenLDAP安装足够完善。
--with-pam #
使用PAM（可插拔认证模块）支持构建。
--with-bsd-auth #
使用 BSD 身份验证支持构建。（BSD 身份验证框架目前仅在 OpenBSD 上可用。）
--with-systemd #
支持systemd服务通知的构建。
如果服务器在systemd下启动，这将改善集成，但对其他情况无影响；
详情请参见第 18.3 节。使用此选项需要安装libsystemd及相关头文件。
--with-bonjour #
构建支持 Bonjour 自动服务发现。这需要您的操作系统支持 Bonjour。推荐在 macOS 上使用。
--with-uuid=LIBRARY #
使用指定的 UUID 库编译uuid-ossp模块（提供生成 UUID 的函数）。
LIBRARY必须是下列之一：
使用bsd来使用在FreeBSD和其他一些基于BSD的系统中找到的UUID函数
e2fs，用来使用e2fsprogs项目创建的 UUID 库，
这个库出现在大部分的 Linux 系统和 macOS 中，并且也能获得用于其他平台的
版本
ossp，用来使用OSSP UUID library
--with-ossp-uuid #
--with-uuid=ossp的已废弃的等效选项。
--with-libcurl #
构建支持 libcurl 的 OAuth 2.0 客户端流程。
该功能需要 libcurl 版本 7.61.0 或更高版本。
使用此功能将检查所需的头文件
和库，以确保您的 curl
安装足够后再继续。
--with-libnuma #
构建支持 libnuma 的基本 NUMA 支持。
仅在实现了 libnuma 库的平台上支持。
--with-liburing #
构建支持 liburing，启用 io_uring 对异步 I/O 的支持。
为了检测所需的编译器和链接器选项，PostgreSQL 将
查询 pkg-config。
要使用位于非标准位置的 liburing 安装，您可以设置
pkg-config 相关的环境变量（请参阅其文档）。
--with-libxml #
使用 libxml2 构建，启用 SQL/XML 支持。此功能需要 Libxml2 版本 2.6.23 或更高版本。
为了检测所需的编译器和链接器选项，PostgreSQL 将查询pkg-config，如果它已安装并且知道 libxml2。
否则，libxml2 安装的程序xml2-config将在找到时使用。
首选使用pkg-config，因为它可以更好地处理多架构安装。
要使用位于不寻常位置的 libxml2 安装，您可以设置与pkg-config相关的环境变量（请参阅其文档），或将环境变量XML2_CONFIG设置为指向
属于 libxml2 安装的xml2-config程序，或设置变量XML2_CFLAGS
和XML2_LIBS。（如果安装了pkg-config，那么要覆盖它的 libxml2 位置的想法，您必须设置XML2_CONFIG或同时设置XML2_CFLAGS和XML2_LIBS到非空字符串。）
--with-libxslt #
使用 libxslt 构建，使xml2模块能够执行 XML 的 XSL 转换。
--with-libxml也必须指定。
--with-selinux #
支持 SElinux 构建，启用sepgsql扩展。
17.3.3.3. Anti-Features #
本节中描述的选项允许禁用默认构建的某些PostgreSQL功能，
但如果所需的软件或系统功能不可用，则可能需要关闭这些功能。除非确实有必要，否则不建议使用这些选项。
--without-icu #
不支持ICU库的构建，
禁用 ICU 排序功能（参见第 23.2 节）。
--without-readline #
防止使用Readline库（以及libedit）。此选项禁用psql中的命令行编辑和历史记录。
--with-libedit-preferred #
赞成使用BSD许可的libedit库而不是GPL许可的Readline。仅当您安装了两个库时，此选项才有意义；这种情况下的默认设置是使用Readline。
--without-zlib #
防止使用Zlib库。这将禁用对pg_dump和pg_restore中压缩档案的支持。
17.3.3.4. 构建过程详细信息 #--with-includes=DIRECTORIES #
DIRECTORIES是一个以冒号分隔的目录列表，这些目录将被添加到编译器搜索头文件的列表中。如果您在非标准位置安装了可选包（例如GNUReadline），则必须使用此选项，并且可能还必须使用相应的--with-libraries选项。
例子：--with-includes=/opt/gnu/include:/usr/sup/include。
--with-libraries=DIRECTORIES #
DIRECTORIES是用于搜索库的以冒号分隔的目录列表。如果您在非标准位置安装了软件包，您可能必须使用此选项（以及相应的--with-includes选项）。
例子：--with-libraries=/opt/gnu/lib:/usr/sup/lib。
--with-system-tzdata=DIRECTORY
#
PostgreSQL包含它自己的时区数据库，它被用于日期和时间操作。这个时区数据库实际上是和 IANA 时区数据库相兼容的，后者在很多操作系统如 FreeBSD、Linux和 Solaris上都有提供，因此再次安装它可能是冗余的。当这个选项被使用时，将使用DIRECTORY中系统提供的时区数据库，而不是包括在 PostgreSQL 源码发布中的时区数据库。DIRECTORY必须被指定为一个绝对路径。/usr/share/zoneinfo在某些操作系统上是一个很有可能的路径。注意安装例程将不会检测不匹配或错误的时区数据。如果你使用这个选项，建议你运行回归测试来验证你指定的时区数据能正常地工作在PostgreSQL中。
这个选项主要针对那些很了解他们的目标操作系统的二进制包发布者。使用这个选项的主要优点是不管何时当众多本地夏令时规则之一改变时，PostgreSQL 包不需要被升级。另一个优点是如果时区数据库文件在安装时不需要被编译，PostgreSQL 可以被更直接地交叉编译。
--with-extra-version=STRING #
将STRING附加到 PostgreSQL 版本号。您可以使用它来标记从未发布的 Git 快照构建的二进制文件或包含带有额外版本字符串的自定义补丁，例如git describe标识符或分发包版本号。
--disable-rpath #
不要标记PostgreSQL的可执行文件以表明它们应该在安装的库目录中搜索共享库（请参阅--libdir）。在大多数平台上，此标记使用库目录的绝对路径，因此如果您稍后重新定位安装将无济于事。但是，您随后需要为可执行文件提供一些其他方式来查找共享库。通常这需要配置操作系统的动态链接器来搜索库目录；有关更多详细信息，请参阅第 17.5.1 节。
17.3.3.5. 杂项 #
使用--with-pgport调整默认端口号是相当常见的，尤其是对于测试版本。本节中的其他选项仅建议高级用户使用。
--with-pgport=NUMBER #
将NUMBER设置为服务器和客户端的默认端口号。默认为 5432。
以后可以随时更改端口，但是如果您在此处指定它，那么服务器和客户端都将编译相同的默认值，这会非常方便。
通常选择非默认值的唯一理由是如果您打算在同一台机器上运行多个PostgreSQL服务器。
--with-krb-srvnam=NAME #
GSSAPI 使用的 Kerberos 服务主体的默认名称。postgres是默认值。
通常没有理由更改它，除非您是为 Windows 环境构建的，在这种情况下，它必须设置为大写POSTGRES。
--with-segsize=SEGSIZE #
设置segment size，以千兆字节为单位。大表被分成多个操作系统文件，每个文件的大小等于段的大小。
这避免了许多平台上存在的文件大小限制问题。默认段大小 1 GB 在所有支持的平台上都是安全的。
如果您的操作系统支持“largefile”（现在大多数都支持），您可以使用更大的段大小。
这有助于减少处理非常大的表时消耗的文件描述符的数量。但请注意不要选择大于您的平台和您打算使用的文件系统支持的值。
您可能希望使用的其他工具，例如tar，也可以设置可用文件大小的限制。
建议（虽然不是绝对要求）此值是 2 的幂。
请注意，更改此值会破坏磁盘数据库兼容性，这意味着您不能使用pg_upgrade升级到具有不同段大小。
--with-blocksize=BLOCKSIZE #
设置block size，以千字节为单位。这是表中的存储和 I/O 单元。
默认值为 8 KB，适用于大多数情况；但其他值在特殊情况下可能有用。
该值必须是 1 到 32（千字节）之间的 2 的幂。
请注意，更改此值会破坏磁盘数据库兼容性，这意味着您不能使用pg_upgrade升级到具有不同块大小的构建。
--with-wal-blocksize=BLOCKSIZE #
设置WAL block size，以千字节为单位。这是 WAL 日志中的存储和 I/O 单元。
默认值为 8 KB，适用于大多数情况；但其他值在特殊情况下可能有用。该值必须是 1 到 64（千字节）之间的 2 的幂。
请注意，更改此值会破坏磁盘数据库兼容性，这意味着您不能使用pg_upgrade升级到具有不同 WAL 块大小的构建。
17.3.3.6. Developer Options #
本节中的大多数选项仅适用于开发或调试PostgreSQL。
除了--enable-debug之外，不建议将它们用于生产版本，这对于在遇到错误的不幸事件中启用详细的错误报告非常有用。
在支持 DTrace 的平台上，在生产中使用--enable-dtrace也可能是合理的。
在构建将用于在服务器内部开发代码的安装时，建议至少使用选项--enable-debug
和--enable-cassert。
--enable-debug #
把所有程序和库以带有调试符号的方式编译。这意味着你可以通过一个调试器运行程序来分析问题。 这样做显著增大了最后安装的可执行文件的大小，并且在非 GCC 的编译器上，这么做通常还要关闭编译器优化，这些都导致速度的下降。但是，如果有这些符号的话，就可以非常有效地帮助定位可能发生问题的位置。目前，我们只是在你使用 GCC 的情况下才建议在生产安装中使用这个选项。但是如果你正在进行开发工作，或者正在使用 beta 版本，那么你就应该总是打开它。
--enable-cassert #
打开在服务器中的assertion检查，它会检查许多“不可能发生”的条件。它对于代码开发的用途而言是无价之宝，不过这些测试可能会显著地降低服务器的速度。并且，打开这个测试不会提高你的系统的稳定性！这些断言检查并不是按照严重性分类的，因此一些相对无害的小故障也可能导致服务器重启 — 只要它触发了一次断言失败。目前，我们不推荐在生产环境中使用这个选项，但是如果你在做开发或者在使用 beta 版本的时候应该打开它。
--enable-tap-tests #
启用使用 Perl TAP 工具的测试。这需要安装 Perl 及 Perl 模块
IPC::Run。更多信息请参见 第 31.4 节。
--enable-depend #
打开自动依赖性跟踪。如果打开这个选项，那么制作文件（makefile）将设置为在任何头文件被修改的时候都将重新编译所有受影响的目标文件。如果你在做开发的工作，那么这个选项很有用，但是如果你只是想编译一次并且安装，那么这就是浪费时间。目前，这个选项只对 GCC 有用。
--enable-coverage #
如果使用 GCC，所有程序和库都会编译时加入代码覆盖率测试的插桩。运行时，它们会在构建目录生成包含代码覆盖率指标的文件。详见 第 31.5 节了解更多信息。此选项仅适用于 GCC 以及开发工作时使用。
--enable-profiling #
如果使用 GCC，则会编译所有程序和库，以便对其进行分析。在后端退出时，将创建一个子目录，其中包含包含配置文件数据的gmon.out文件。此选项仅用于 GCC 和进行开发工作时。
--enable-dtrace #
编译支持动态追踪工具DTrace的PostgreSQL。详情请参见第 27.5 节。
要指向dtrace程序，必须设置环境变量DTRACE。这通常是必需的，因为dtrace通常被安装在/usr/sbin中，该路径可能不在你的PATH中。
dtrace程序的附加命令行选项可以在环境变量DTRACEFLAGS中指定。在 Solaris 上，要在一个64位二进制中包括 DTrace，你必须指定DTRACEFLAGS="-64"。例如，使用 GCC 编译器：
./configure CC='gcc -m64' --enable-dtrace DTRACEFLAGS='-64' ...
使用 Sun 的编译器：
./configure CC='/opt/SUNWspro/bin/cc -xtarget=native64' --enable-dtrace DTRACEFLAGS='-64' ...
--enable-injection-points #
编译支持服务器中注入点的PostgreSQL。注入点允许在预定义的代码路径中
从服务器内部运行用户定义的代码。这有助于以受控方式测试和调查并发场景。此选项默认禁用。
详情请参见第 36.10.14 节。此选项仅供开发人员测试使用。
--with-segsize-blocks=SEGSIZE_BLOCKS #
指定关系段的大小（以块为单位）。如果同时指定了
--with-segsize和此选项，则以此选项为准。
此选项仅供开发人员使用，用于测试与段相关的代码。
17.3.4. configure 环境变量 #
除了上面描述的普通命令行选项之外，configure响应许多环境变量。
您可以在configure命令行上指定环境变量，例如：
./configure CC=/opt/bin/gcc CFLAGS='-O2 -pipe'
在这种用法中，环境变量与命令行选项几乎没有什么不同。 您还可以预先设置此类变量：
export CC=/opt/bin/gcc
export CFLAGS='-O2 -pipe'
./configure
这种用法很方便，因为许多程序的配置脚本以类似的方式响应这些变量。
这些环境变量中最常用的是CC和CFLAGS。如果您喜欢用与configure选取的不同的 C 编译器，那么您可以将环境变量CC设置为您选择的程序。默认时，只要gcc可以使用，configure将选择它，或者是该平台的默认（通常是cc）。类似地，您可以用CFLAGS变量覆盖默认编译器标志。
以下是可以通过这种方式设置的重要变量列表：
BISON #
Bison程序
CC #
C编译器
CFLAGS #
传递给C编译器的选项
CLANG #
用于处理源代码的clang程序的路径，在使用--with-llvm编译时进行内联处理
CPP #
C预处理器
CPPFLAGS #
传递给C预处理器的选项
CXX #
C++编译器
CXXFLAGS #
传递给C++编译器的选项
DTRACE #
dtrace程序的位置
DTRACEFLAGS #
传递给dtrace程序的选项
FLEX #
Flex程序
LDFLAGS #
用于链接可执行文件或共享库时使用的选项
LDFLAGS_EX #
仅用于链接可执行文件的附加选项
LDFLAGS_SL #
仅用于链接共享库的附加选项
LLVM_CONFIG #
llvm-config程序用于定位LLVM安装位置
MSGFMT #
msgfmt程序用于本地语言支持
PERL #
Perl解释器程序。这将用于确定构建PL/Perl所需的依赖关系。默认值为
perl。
PYTHON #
Python解释器程序。这将用于确定构建PL/Python所需的依赖关系。如果未设置此项，
则按照以下顺序进行探测：python3 python。
TCLSH #
Tcl解释器程序。这将用于确定构建PL/Tcl的依赖关系。
如果未设置此项，则按照以下顺序进行探测：tclsh tcl tclsh8.6 tclsh86 tclsh8.5 tclsh85
tclsh8.4 tclsh84。
XML2_CONFIG #
xml2-config程序用于定位libxml2安装位置。
有时在 configure 选择的选项后添加编译器标志是有用的。
一个重要的例子是 gcc 的 -Werror 选项
不能包含在传递给 configure 的 CFLAGS 中，
因为这会破坏 configure 的许多内置测试。
要添加这样的标志，请在运行 make 时将它们包含在
COPT 环境变量中。COPT 的内容将添加到
CFLAGS、CXXFLAGS 和 LDFLAGS
选项中，这些选项由 configure 设置。
例如，您可以执行
make COPT='-Werror'
或
export COPT='-Werror'
make
注意
如果使用GCC，最好使用至少-O1的优化级别来编译，因为不使用优化（-O0）会禁用某些重要的编译器警告（例如使用未经初始化的变量）。但是，非零的优化级别会使调试更复杂，因为在编译好的代码中步进通常将不能和源代码行一一对应。如果你在尝试调试优化过的代码时觉得困惑，将感兴趣的特定文件使用-O0编译。一种简单的方式是传递一个选项给make：make PROFILE=-O0 file.o。
COPT和PROFILE环境变量同样由PostgreSQL
makefile实际处理。要使用哪个是一个偏好问题，但是开发者的共同习惯是将
PROFILE用于一次性的标识调整，而始终保持设置COPT。
上一页 上一级 下一页17.2. 获取源码 起始页 17.4. 使用Meson进行构建和安装
