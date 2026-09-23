# 17.4. 使用Meson进行构建和安装

17.4. 使用Meson进行构建和安装
版本：
纠错本页面
搜索
目录导航
❮
❯
17.4. 使用Meson进行构建和安装 #17.4.1. 简版17.4.2. 安装过程17.4.3. meson setup 选项17.4.4. meson 构建目标17.4.1. 简版 #
meson setup build --prefix=/usr/local/pgsql
cd build
ninja
su
ninja install
adduser postgres
mkdir -p /usr/local/pgsql/data
chown postgres /usr/local/pgsql/data
su - postgres
/usr/local/pgsql/bin/initdb -D /usr/local/pgsql/data
/usr/local/pgsql/bin/pg_ctl -D /usr/local/pgsql/data -l logfile start
/usr/local/pgsql/bin/createdb test
/usr/local/pgsql/bin/psql test
详细版本请参阅本章节的其余部分。
17.4.2. 安装过程 #配置
安装过程的第一步是为您的系统配置构建树并选择您想要的选项。
要创建和配置构建目录，您可以从meson setup命令开始。
meson setup build
setup命令需要一个builddir和一个srcdir
参数。如果没有提供srcdir，Meson将根据当前目录和
meson.build的位置推断出srcdir。
builddir是必需的。
运行meson setup会加载构建配置文件并设置构建目录。
此外，您还可以向Meson传递多个构建选项。一些常用选项在后续部分中提到。
例如：
# configure with a different installation prefix
meson setup build --prefix=/home/user/pg-install
# configure to generate a debug build
meson setup build --buildtype=debug
# configure to build with OpenSSL support
meson setup build -Dssl=openssl
设置构建目录是一个一次性的步骤。在新构建之前重新配置时，您可以简单地使用
meson configure命令
meson configure -Dcassert=true
meson configure的常用命令行选项在
第 17.4.3 节中进行了说明。
构建
默认情况下，Meson 使用 Ninja 构建工具。要使用 Meson 从源代码
构建 PostgreSQL，您只需在构建目录中使用
ninja 命令。
ninja
Ninja 会自动检测您计算机中的 CPU 数量，并相应地进行并行化。您可以通过
命令行参数 -j 来覆盖使用的并行进程数量。
需要注意的是，在初始配置步骤之后，ninja 是您编译时唯一需要
输入的命令。无论您如何更改源代码树（除非将其移动到一个完全新的位置），Meson
都会检测到更改并相应地重新生成自身。这在您有多个构建目录时尤其方便。通常其中
一个用于开发（“调试”构建），而其他的仅偶尔使用（例如“静态分析”构建）。任何
配置都可以通过切换到相应的目录并运行 Ninja 来构建。
如果您想使用 ninja 以外的后端进行构建，可以使用
--backend 选项通过 configure 选择您想要使用的后端，
然后使用 meson compile 进行构建。要了解有关这些后端
和您可以提供给 ninja 的其他参数的更多信息，可以参考
Meson 文档。
回归测试
如果您想在安装之前测试新构建的服务器，
您可以在此时运行回归测试。回归测试是一套测试套件，
用于验证PostgreSQL是否在您的机器上
按照开发人员预期的方式运行。输入：
meson test
（这不能以 root 用户身份运行；请以非特权用户身份执行。）
请参阅第 31 章以获取有关解释测试结果的详细信息。
您可以通过再次执行相同的命令在任何时候重复此测试。
要针对正在运行的 postgres 实例运行 pg_regress 和 pg_isolation_regress 测试，
请将 --setup running 作为 meson test
的参数指定。
安装文件注意
如果您要升级现有系统，请务必阅读第 18.6 节，其中包含有关升级集簇的说明。
一旦PostgreSQL构建完成，您可以通过简单运行
ninja install命令来安装它。
ninja install
这将把文件安装到步骤 1中指定的目录中。
确保您具有写入该区域的适当权限。您可能需要以root用户身份执行此步骤。
或者，您可以提前创建目标目录并安排授予适当的权限。
标准安装提供了客户端应用程序开发所需的所有头文件，
以及服务器端程序开发所需的头文件，例如用C语言编写的自定义函数或数据类型。
ninja install 应该适用于大多数情况，但如果您希望使用更多选项
（例如 --quiet 来抑制额外输出），您也可以使用
meson install 代替。您可以在 Meson 文档中了解更多关于
meson install
及其选项的信息。
卸载：.
要撤销安装，可以使用ninja uninstall命令。
清理：.
安装完成后，您可以通过使用ninja clean命令从源代码树中
删除生成的文件来释放磁盘空间。
17.4.3. meson setup 选项 #
meson setup的命令行选项解释如下。
此列表并不详尽（使用meson configure --help
可以获取更完整的列表）。这里未涵盖的选项适用于高级用例，
并记录在标准Meson
文档中。这些参数也可以与meson
setup一起使用。
17.4.3.1. 安装位置 #
这些选项控制ninja install（或meson install）将文件放置
的位置。--prefix选项（示例
第 17.4.1 节) 对于大多数情况已经足够。
如果您有特殊需求，可以使用本节中描述的其他选项来自定义安装子目录。
但请注意，改变不同子目录的相对位置可能会导致安装无法重新定位，
这意味着您在安装后将无法移动它。
（man和doc的位置不受此限制的影响。）
对于可重新定位的安装，您可能需要使用稍后描述的-Drpath=false选项。
--prefix=PREFIX #
将所有文件安装到目录PREFIX下，而不是
/usr/local/pgsql（在基于Unix的系统上）或
current drive letter:/usr/local/pgsql
（在Windows上）。实际的文件将被安装到不同的子目录中；不会有文件
直接安装到PREFIX目录中。
--bindir=DIRECTORY #
指定可执行程序的目录。默认值是PREFIX/bin。
--sysconfdir=DIRECTORY #
设置各种配置文件的目录，默认为PREFIX/etc。
--libdir=DIRECTORY #
设置安装库和动态可加载模块的位置。默认值是
PREFIX/lib。
--includedir=DIRECTORY #
设置 C 和 C++ 头文件的安装目录。默认是PREFIX/include。
--datadir=DIRECTORY #
设置已安装程序使用的只读数据文件的目录。默认值是
PREFIX/share。请注意，这与您的数据库文件
将被放置的位置无关。
--localedir=DIRECTORY #
设置安装区域设置数据的目录，特别是消息翻译目录文件。默认值是
DATADIR/locale。
--mandir=DIRECTORY #
随PostgreSQL产品附带的手册页将安装在此目录下，
它们各自的manx子目录中。
默认值是DATADIR/man。
注意
为了让PostgreSQL能够安装在一些共享的安装位置（例如/usr/local/include），
同时又不至于和系统其他部分产生名字空间干扰，我们特别做了一些处理。 首先，安装脚本会自动给datadir、
sysconfdir和docdir后面附加上“/postgresql”字符串，
除非展开的完整路径名已经包含字符串“postgres”或者“pgsql”。
例如，如果你选择/usr/local作为前缀，那么文档将安装在/usr/local/doc/postgresql，
但如果前缀是/opt/postgres，那么它将被放到/opt/postgres/doc。
客户接口的公共 C 头文件安装到了includedir，并且是名字空间无关的。
内部的头文件和服务器头文件都安装在includedir下的私有目录中。
参考每种接口的文档获取关于如何访问头文件的信息。最后，如果合适，那么也会在libdir下创建一个私有的子目录用于动态可装载的模块。
17.4.3.2. PostgreSQL 特性 #
本节中描述的选项使得可以构建各种可选的
PostgreSQL功能。
其中大多数需要额外的软件，如
第 17.1 节中所述，并且如果找到所需的软件，
将会自动启用。您可以通过手动将这些功能设置为
enabled来强制启用它们，或者设置为
disabled来不使用它们进行构建，从而更改此行为。
要指定 PostgreSQL 特定的选项，选项的名称必须以-D为前缀。
-Dnls={ auto | enabled | disabled } #
启用或禁用本地语言支持（NLS），即以非英语的语言显示
程序消息的能力。默认值为自动，如果找到Gettext API
的实现，将会自动启用。
-Dplperl={ auto | enabled | disabled } #
构建PL/Perl服务器端语言。
默认值为自动。
-Dplpython={ auto | enabled | disabled } #
构建PL/Python服务器端语言。
默认值为自动。
-Dpltcl={ auto | enabled | disabled } #
构建PL/Tcl服务器端语言。
默认值为自动。
-Dtcl_version=TCL_VERSION #
指定构建PL/Tcl时使用的Tcl版本。
-Dicu={ auto | enabled | disabled } #
支持ICU库的构建，
启用ICU排序功能（参见第 23.2 节）。默认值为自动，并且需要安装
ICU4C软件包。当前所需的最低
ICU4C版本为4.2。
-Dllvm={ auto | enabled | disabled } #
构建支持基于LLVM的
JIT编译（请参阅第 30 章）。
这需要安装LLVM库。
当前所需的最低版本为14。默认情况下禁用。
llvm-config
将被用来找到所需的编译选项。
llvm-config，然后
llvm-config-$version（适用于所有支持的版本），
将在您的PATH中被搜索。如果这不能
找到所需的程序，请使用LLVM_CONFIG来指定
正确的llvm-config的路径。
-Dlz4={ auto | enabled | disabled } #
使用LZ4压缩支持进行构建。
默认值为自动。
-Dzstd={ auto | enabled | disabled } #
使用Zstandard压缩支持进行构建。
默认值为自动。
-Dssl={ auto | LIBRARY }
#
构建支持SSL（加密）连接的功能。
唯一支持的LIBRARY是
openssl。这需要安装
OpenSSL软件包。构建时会检查所需的头文件和库，
以确保您的OpenSSL安装在继续之前是足够的。
此选项的默认值是自动。
-Dgssapi={ auto | enabled | disabled } #
构建支持GSSAPI认证的功能。需要安装MIT Kerberos以支持GSSAPI。在许多系统上，
GSSAPI系统（MIT Kerberos安装的一部分）并未安装在默认搜索的位置（例如，
/usr/include，/usr/lib）。
在这些情况下，PostgreSQL将查询pkg-config以检测所需的编译
器和链接器选项。默认值为自动。meson configure将在继续
之前检查所需的头文件和库，以确保您的GSSAPI安装足够。
-Dldap={ auto | enabled | disabled } #
构建时使用
LDAP
支持身份验证和连接参数查找（请参阅
第 32.18 节 和
第 20.10 节 了解更多信息）。在 Unix 系统上，
这需要安装 OpenLDAP 软件包。在 Windows 系统上，
使用默认的 WinLDAP 库。默认值为自动。
meson configure 将检查所需的头文件和库，
以确保您的 OpenLDAP 安装在继续之前是足够的。
-Dpam={ auto | enabled | disabled } #
使用PAM
（可插拔认证模块）支持。默认值为自动。
-Dbsd_auth={ auto | enabled | disabled } #
构建时支持BSD认证。（BSD认证框架目前仅在OpenBSD上可用。）默认值为自动。
-Dsystemd={ auto | enabled | disabled } #
支持systemd
服务通知的构建。如果服务器是在systemd下启动，
则这能改善集成，但在其他情况下没有影响；详见第 18.3 节。默认值为auto。需要安装libsystemd及相关头文件
才能使用此选项。
-Dbonjour={ auto | enabled | disabled } #
构建支持Bonjour自动服务发现。默认值为自动，并且需要操作系统中
的Bonjour支持。推荐在macOS上使用。
-Duuid=LIBRARY #
构建uuid-ossp模块（该模块提供生成UUID的功能），
使用指定的UUID库。
LIBRARY必须是以下之一：
none表示不构建uuid模块。这是默认设置。
bsd用于使用FreeBSD和其他一些基于BSD的系统中
提供的UUID功能。
e2fs使用由e2fsprogs项目创建的UUID库；
该库存在于大多数Linux系统和macOS中，并且也可以用于其他平台。
ossp使用OSSP UUID库
-Dlibcurl={ auto | enabled | disabled } #
构建支持libcurl的OAuth 2.0客户端流程。
此功能需要libcurl版本7.61.0或更高版本。
使用此选项构建时，将检查所需的头文件
和库，以确保您的Curl
安装足够，然后再继续。此选项的默认值为自动。
-Dliburing={ auto | enabled | disabled } #
构建支持 liburing，启用 io_uring 对异步 I/O 的支持。
默认值为自动。
要使用位于非标准位置的 liburing 安装，您可以设置
pkg-config 相关的环境变量（请参阅其文档）。
-Dlibnuma={ auto | enabled | disabled } #
构建支持 libnuma 以实现基本的 NUMA 支持。
仅在实现了 libnuma 库的平台上受支持。
此选项的默认值为自动。
-Dlibxml={ auto | enabled | disabled } #
使用 libxml2 构建，启用 SQL/XML 支持。默认设置为
自动。此功能需要 libxml2 版本 2.6.23 或更高版本。
要使用位于非标准位置的 libxml2 安装，您可以设置与
pkg-config 相关的环境变量（请参阅其文档）。
-Dlibxslt={ auto | enabled | disabled } #
使用 libxslt 构建，启用
xml2
模块以执行 XML 的 XSL 转换。
-Dlibxml 也必须指定。默认为
自动。
-Dselinux={ auto | enabled | disabled } #
支持 SElinux 构建，启用 sepgsql
扩展。默认设置为自动。
17.4.3.3. Anti-Features #-Dreadline={ auto | enabled | disabled } #
允许使用Readline库（以及
libedit）。此选项默认为
自动，并在psql中启用命令行编辑和历史记录，
强烈推荐使用。
-Dlibedit_preferred={ true | false } #
将此设置为 true 会倾向于使用 BSD 许可的
libedit 库，而不是 GPL 许可的
Readline。此选项仅在您安装了两个库时才有意义；
默认值为 false，即使用 Readline。
-Dzlib={ auto | enabled | disabled } #
启用Zlib库的使用。
默认设置为自动，并启用对pg_dump、
pg_restore和pg_basebackup
中压缩归档的支持，推荐使用。
17.4.3.4. 构建过程详细信息 #--auto-features={ auto | enabled | disabled } #
设置此选项可以让您覆盖所有“auto”功能的值（如果找到所需的软件，
这些功能会自动启用）。当您希望一次性禁用或启用所有“optional”功能，
而无需手动设置每个功能时，这可能会很有用。此参数的默认值为auto。
--backend=BACKEND #
Meson 使用的默认后端是 ninja，这对于大多数使用场景来说已经足够。
但是，如果您想要与 Visual Studio 完全集成，可以将 BACKEND 设置为
vs。
-Dc_args=OPTIONS #
此选项可用于向 C 编译器传递额外的选项。
-Dc_link_args=OPTIONS #
此选项可用于向 C 链接器传递额外的选项。
-Dextra_include_dirs=DIRECTORIES #
DIRECTORIES 是一个以逗号分隔的目录列表，
这些目录将被添加到编译器搜索头文件的目录列表中。如果您在非标准
位置安装了可选软件包（例如 GNU Readline），
您需要使用此选项，并且可能还需要使用相应的
-Dextra_lib_dirs 选项。
示例: -Dextra_include_dirs=/opt/gnu/include,/usr/sup/include。
-Dextra_lib_dirs=DIRECTORIES #
DIRECTORIES 是一个以逗号分隔的目录列表，用于
搜索库文件。如果您在非标准位置安装了软件包，您可能需要使用此选项
（以及对应的 -Dextra_include_dirs 选项）。
示例: -Dextra_lib_dirs=/opt/gnu/lib,/usr/sup/lib。
-Dsystem_tzdata=DIRECTORY
#
PostgreSQL 包含其自己的时区数据库，
它是日期和时间操作所必需的。这个时区数据库实际上与许多操作系统
（如 FreeBSD、Linux 和 Solaris）提供的 IANA 时区数据库兼容，
因此再次安装它是多余的。当使用此选项时，系统提供的时区数据库
DIRECTORY 将代替 PostgreSQL 源代码
分发中包含的时区数据库。
DIRECTORY 必须指定为绝对路径。
/usr/share/zoneinfo 是某些操作系统上可能的目录。
请注意，安装程序不会检测不匹配或错误的时区数据。如果您使用此选项，
建议运行回归测试以验证您指定的时区数据是否能与
PostgreSQL 正常工作。
此选项主要面向熟悉其目标操作系统的二进制包分发者。使用此选项的
主要优点是，当许多本地夏令时规则发生变化时，PostgreSQL包无需升
级。另一个优点是，如果在安装过程中不需要构建时区数据库文件，则
PostgreSQL可以更简单地进行交叉编译。
-Dextra_version=STRING #
将STRING附加到PostgreSQL版本号中。例如，您可以使用
这个方法来标记从未发布的Git快照构建的二进制文件，
或者包含自定义补丁的额外版本字符串，例如git describe
标识符或分发包的发布编号。
-Drpath={ true | false } #
此选项默认设置为true。如果设置为false，
则不会标记PostgreSQL的可执行文件，
表明它们应在安装的库目录中搜索共享库（参见--libdir）。
在大多数平台上，此标记使用库目录的绝对路径，
因此如果您稍后重新定位安装，它将无效。
然而，您需要提供其他方法让可执行文件找到共享库。
通常，这需要配置操作系统的动态链接器以搜索库目录；
详情请参见第 17.5.1 节。
-DBINARY_NAME=PATH #
如果用于构建PostgreSQL（无论是否带有可选标志）的程序存储在非标准路径，
您可以手动将其指定给meson configure。支持的程序完整
列表可以通过运行meson configure找到。示例：
meson configure -DBISON=PATH_TO_BISON
17.4.3.5. 文档 #
请参阅第 J.2 节以了解构建文档所需的工具。
-Ddocs={ auto | enabled | disabled } #
启用以HTML和man格式构建文档。
默认设置为自动。
-Ddocs_pdf={ auto | enabled | disabled } #
启用以PDF格式生成文档。默认设置为自动。
-Ddocs_html_style={ simple | website } #
控制使用哪个CSS样式表。默认值是simple。
如果设置为website，HTML文档将引用
postgresql.org
的样式表。
17.4.3.6. 杂项 #-Dpgport=NUMBER #
将NUMBER设置为服务器和客户端的默认端口号。
默认值是5432。端口号可以在之后随时更改，但如果您在这里指定，
那么服务器和客户端将具有相同的默认编译值，这可能非常方便。
通常，选择非默认值的唯一合理原因是您打算在同一台机器上运行
多个PostgreSQL服务器。
-Dkrb_srvnam=NAME #
GSSAPI使用的Kerberos服务主体的默认名称。
postgres是默认值。通常没有必要更改此设置，
除非您正在为Windows环境构建，在这种情况下，它必须设置为
大写的POSTGRES。
-Dsegsize=SEGSIZE #
设置段大小，单位为GB。大型表会被分成多个操作系统文件，
每个文件的大小等于段大小。这可以避免许多平台上存在的文件大小限制问题。
默认的段大小为1GB，在所有支持的平台上都是安全的。如果您的操作系统支持
“大文件”（如今大多数都支持），您可以使用更大的段大小。这有助于
减少处理非常大的表时消耗的文件描述符数量。但请注意，不要选择超出您的平台
和您打算使用的文件系统支持的值。您可能希望使用的其他工具，例如
tar，也可能对可用的文件大小设置限制。
建议（虽然不是绝对必要）将此值设置为2的幂。
-Dblocksize=BLOCKSIZE #
设置块大小，单位为千字节。这是表中存储和I/O的单位。
默认值为8千字节，适用于大多数情况；但在特殊情况下，其他值可能会有用。
该值必须是1到32（千字节）之间的2的幂。
-Dwal_blocksize=BLOCKSIZE #
设置WAL 块大小，单位为千字节。这是 WAL 日志中存储和 I/O 的单
位。默认值为 8 千字节，适用于大多数情况；但在特殊情况下，其他值可能会有用。
该值必须是 1 到 64（千字节）之间的 2 的幂。
17.4.3.7. Developer Options #
本节中的大多数选项仅对开发或调试PostgreSQL
感兴趣。它们不建议用于生产构建，除了--debug，它在
您不幸遇到错误时启用详细错误报告可能会很有用。在支持DTrace的平台上，
-Ddtrace在生产中使用也可能是合理的。
在构建一个将在服务器内部开发代码的安装时，建议至少使用
--buildtype=debug 和 -Dcassert 选项。
--buildtype=BUILDTYPE #
此选项可用于指定要使用的构建类型；默认为
debugoptimized。如果您希望对调试符号和优化级别
进行比此选项提供的更精细的控制，可以参考
--debug 和 --optimization 标志。
通常使用以下构建类型：plain、debug、
debugoptimized和release。关于它们的更多信息可以在
Meson
文档中找到。
--debug #
编译所有程序和库时包含调试符号。这意味着您可以在调试器中运行程序以分析
问题。这会显著增加已安装可执行文件的大小，并且在非GCC编译器上通常还会
禁用编译器优化，从而导致运行变慢。然而，拥有这些符号对于处理可能出现的
任何问题非常有帮助。目前，如果您使用GCC，建议仅在生产环境安装中启用此
选项。但如果您正在进行开发工作或运行测试版本，则应始终启用它。
--optimization=LEVEL #
指定优化级别。LEVEL可以设置为{0,g,1,2,3,s}中的任意值。
--werror #
设置此选项会要求编译器将警告视为错误。这对于代码开发可能很有用。
-Dcassert={ true | false } #
启用断言检查功能，用于在服务器中测试许多
“不可能发生”的情况。这对于代码开发非常有价值，
但这些测试会显著降低服务器的速度。此外，启用这些测试并不一定
会增强服务器的稳定性！断言检查未按严重性分类，因此即使是相对
无害的错误，如果触发了断言失败，仍然会导致服务器重启。此选项
不推荐用于生产环境，但在开发工作或运行测试版时应启用。
-Dtap_tests={ auto | enabled | disabled } #
启用使用 Perl TAP 工具的测试。默认值为 auto，且需要安装 Perl 及 Perl 模块
IPC::Run。有关更多信息，请参见 第 31.4 节。
-DPG_TEST_EXTRA=TEST_SUITES #
启用额外的测试套件，这些测试默认情况下不运行，因为
在多用户系统上运行不安全，或需要特殊软件运行，或资源消耗大。
参数是一个以空格分隔的要启用的测试列表。有关详细信息，请参见
第 31.1.3 节。如果在运行测试时设置了
PG_TEST_EXTRA 环境变量，则会覆盖此设置时间选项。
-Db_coverage={ true | false } #
如果使用 GCC，所有程序和库都会使用代码覆盖率测试插装进行编译。运行时，
它们会在构建目录中生成包含代码覆盖率指标的文件。
See 第 31.5 节
了解更多信息。此选项仅适用于 GCC 以及进行开发工作时使用。
-Ddtrace={ auto | enabled | disabled } #
启用此功能会编译PostgreSQL，以支持动态跟踪工具DTrace。
详情请参见第 27.5 节。
要指向dtrace程序，可以设置DTRACE
选项。这通常是必要的，因为dtrace通常安装在
/usr/sbin下，而这可能不在您的PATH
中。
-Dinjection_points={ true | false } #
编译支持服务器中注入点的PostgreSQL。注入点允许在
预定义的代码路径中从服务器内部运行用户定义的代码。这有助于以受控方式测试
和调查并发场景。此选项默认情况下被禁用。详见第 36.10.14 节
。此选项仅供开发人员测试使用。
-Dsegsize_blocks=SEGSIZE_BLOCKS #
指定关系段的大小（以块为单位）。如果同时指定了
-Dsegsize和此选项，则以此选项为准。
此选项仅供开发人员使用，用于测试与段相关的代码。
17.4.4. meson 构建目标 #
可以使用ninja target来构建单个构建目标。
当未指定目标时，除了文档外的所有内容都会被构建。可以使用路径/文件名作为
target来构建单个构建产物。
17.4.4.1. Code Targets #all #
Build everything other than documentation
backend #
Build backend and related modules
bin #
Build frontend binaries
contrib #
Build contrib modules
pl #
Build procedural languages
17.4.4.2. Developer Targets #reformat-dat-files #
Rewrite catalog data files into standard format
expand-dat-files #
Expand all data files to include defaults
update-unicode #
Update unicode data to new version
17.4.4.3. Documentation Targets #html #
Build documentation in multi-page HTML format
man #
Build documentation in man page format
docs #
Build documentation in multi-page HTML and man page format
doc/src/sgml/postgres-A4.pdf #
Build documentation in PDF format, with A4 pages
doc/src/sgml/postgres-US.pdf #
Build documentation in PDF format, with US letter pages
doc/src/sgml/postgres.html #
Build documentation in single-page HTML format
alldocs #
Build documentation in all supported formats
17.4.4.4. Installation Targets #install #
Install postgres, excluding documentation
install-docs #
Install documentation in multi-page HTML and man page formats
install-html #
Install documentation in multi-page HTML format
install-man #
Install documentation in man page format
install-quiet #
Like "install", but installed files are not displayed
install-world #
Install postgres, including multi-page HTML and man page documentation
uninstall #
Remove installed files
17.4.4.5. Other Targets #clean #
Remove all build products
test #
Run all enabled tests (including contrib)
world #
Build everything, including documentation
help #
List important targets
上一页 上一级 下一页17.3. 使用Autoconf和Make进行构建和安装 起始页 17.5. 安装后设置
