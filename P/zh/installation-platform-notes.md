# 17.7. 平台特定说明

17.7. 平台特定说明
版本：
纠错本页面
搜索
目录导航
❮
❯
17.7. 平台特定说明 #17.7.1. Cygwin17.7.2. macOS17.7.3. MinGW17.7.4. Solaris17.7.5. Visual Studio
这一节提供了关于 PostgreSQL 安装和设置的附加平台特定问题。确保阅读安装指导，特别是第 17.1 节。同样，检查关于回归测试结果解释的第 31 章。
这里没有覆盖的平台不存在平台相关的安装问题。
17.7.1. Cygwin #
PostgreSQL 可以使用 Cygwin（一个类似 Linux 的 Windows 环境）构建，
但该方法不如原生 Windows 构建，且不再推荐在 Cygwin 下运行服务器。
从源代码构建时，请按照类Unix风格的安装程序进行操作（即，
./configure; make；等等），注意以下与Cygwin相关的
特殊差异：
设置路径以优先使用Cygwin的bin目录，而不是Windows的工具。这将有助于
防止编译问题。
adduser命令不受支持；请使用Windows上的适当用户管理
应用程序。否则，跳过此步骤。
su命令不受支持；请使用ssh在Windows上模拟su。否则，
跳过此步骤。
OpenSSL不受支持。
启动cygserver以支持共享内存。为此，请输入命令
/usr/sbin/cygserver &。此程序需要在您启动
PostgreSQL服务器或初始化数据库集群
(initdb)时运行。默认的
cygserver配置可能需要更改（例如，增加
SEMMNS）以防止PostgreSQL因系统资源不足而失败。
在某些使用非C语言环境的系统上，构建可能会失败。为了解决此问题，
在构建之前通过执行export LANG=C.utf8将语言环境
设置为C，并在安装PostgreSQL后将其恢复为之前的设置。
并行回归测试（make check）可能会由于
listen()积压队列溢出而生成虚假的回归测试失败，
这会导致连接被拒绝错误或挂起。您可以通过如下方式使用make变量
MAX_CONNECTIONS限制连接数：
make MAX_CONNECTIONS=5 check
（在某些系统上，您最多可以有大约10个同时连接。）
可以把cygserver和PostgreSQL服务器安装为 Windows NT 服务。关于如何这样做的信息，请参考包含在 Cygwin 上 PostgreSQL 二进制包中的README文档。它被安装在目录/usr/share/doc/Cygwin中。
17.7.2. macOS #
在 macOS源码构建PostgreSQL
，你需要安装Apple的命令行开发工具，这可以通过
xcode-select --install
（请注意，将出现一个 GUI 对话窗口以供确认）。您可以选择安装或不安装 Xcode。
在最新的macOS版本中，有必要将“sysroot”
路径嵌入用于查找某些系统头文件的include选项中。这导致configure
脚本的输出会有所不同，具体取决于在configure期间使用的SDK版本。
在简单的情况下，这应该不会造成任何问题，但是，如果您要尝试在与构建服务器代码不同
的计算机上构建扩展程序，则可能需要强制使用其他sysroot路径。为此，需要设置
PG_SYSROOT，例如：
make PG_SYSROOT=/desired/path all
要在您的计算机上找到合适的路径，请运行
xcrun --show-sdk-path
请注意，实际上不建议使用与构建核心服务器不同的sysroot版本构建扩展。
在最坏的情况下，它可能导致难以调试的ABI不一致。
您还可以在配置时选择非默认的sysroot路径，通过在
configure中指定PG_SYSROOT：
./configure ... PG_SYSROOT=/desired/path
这主要是对其他一些macOS版本进行交叉编译的时候有用。不能保证产生的可执行文件能在当前主机上运行。
要完全禁止该选项-isysroot，使用
./configure ... PG_SYSROOT=none
(任何不存在的路径名都可以使用)。如果您想用一个非苹果的编译器来构建，这可能是有用的，但要注意这种情况没有被PostgreSQL的开发者测试或支持。
macOS的“系统完整性保护”（SIP）
功能破坏了make check，因为它阻止通过
设置所需的DYLD_LIBRARY_PATH传递给被测试的可执行文件。
您可以通过在make check之前执行make install来解决此问题。
不过，大多数PostgreSQL开发人员关闭了SIP。
17.7.3. MinGW #
Windows上的PostgreSQL可以使用MinGW构建，这是一个类Unix的构建
环境。建议使用MSYS2环境进行此操作，并安装任何先决条件包。
17.7.3.1. 收集崩溃转储 #
如果 PostgreSQL 在 Windows 上崩溃，它有能力产生minidumps，这可以被用来追踪崩溃发生的原因，这与 Unix 上的核心转储相似。这些转储可以被使用Windows Debugger Tools或Visual Studio读取。要启用在 Windows 上的转储生成，可在集簇数据目录下创建一个名为crashdumps的子目录。转储将被写入到这个目录，转储的名字基于崩溃进程的标识符和崩溃的当前时间来确定。
17.7.4. Solaris #
PostgreSQL 在 Solaris 上得到了很好的支持。你的操作系统越新，你将会碰到更少的问题。
17.7.4.1. 所需工具 #
你可以使用 GCC 或 Sun 的编译器套件进行编译。为了更好的代码优化，我们强烈推荐在 SPARC 架构下使用 Sun 的编译器。如果你正在使用 Sun 的编译器，注意不要选择/usr/ucb/cc；而是使用/opt/SUNWspro/bin/cc。
你可以从https://www.oracle.com/technetwork/server-storage/solarisstudio/downloads/下载 Sun Studio。很多 GNU 工具都被整合到了 Solaris 10，或者它们在 Solaris companion CD 中。如果你需要用于老版本 Solaris 的包，你可以在http://www.sunfreeware.com找到这些工具。如果你想要源码，在https://www.gnu.org/prep/ftp上找找。
17.7.4.2. configure 抱怨一个失败的测试程序 #
如果configure抱怨一个失败的测试程序，可能的情况是运行时链接器无法找到某些库，可能是libz、libreadline或某些其他非标准库如libssl。要向它指出正确的位置，在configure命令行上设置LDFLAGS环境变量，例如：
configure ... LDFLAGS="-R /usr/sfw/lib:/opt/sfw/lib:/usr/local/lib"
更多信息可见ld手册页。
17.7.4.3. 为最优性能编译 #
在 SPARC 架构上，我们强烈推荐使用 Sun Studio来编译。尝试使用-xO5优化标志来生成显著更快的二进制。不要使用任何修改浮点操作和errno处理（例如-fast）行为的标志。
如果你没有理由要使用 SPARC 上的 64 位二进制，最好用 32 位版本。64 位操作较慢并且 64 位二进制比其 32 位变体要慢。另一方面，AMD64 CPU 家族上的32 位代码不是原生的，所以在那个 CPU 族中 32 位代码要明显地更慢。
17.7.4.4. 用 DTrace 来跟踪 PostgreSQL #
是的，可以使用 DTrace。详见第 27.5 节。
如果你看到postgres可执行程序的链接中断并且报出下面的错误消息：
Undefined                       first referenced
symbol                             in file
AbortTransaction                    utils/probes.o
CommitTransaction                   utils/probes.o
ld: fatal: Symbol referencing errors. No output written to postgres
collect2: ld returned 1 exit status
make: *** [postgres] Error 1
说明你的 DTrace 安装太旧，无法处理静态函数中的探测。你需要 Solaris 10u4 或更新的版本以使用DTrace。
17.7.5. Visual Studio #
建议大多数用户下载适用于 Windows 的二进制发行版，该版本作为图形安装包
可从 PostgreSQL 网站的
https://www.postgresql.org/download/ 获取。仅建议开发
PostgreSQL 或扩展的人员从源代码构建。
可以使用 Meson 构建带有 Visual Studio 的 Windows 版 PostgreSQL，详见
第 17.4 节。
原生 Windows 版本要求 Windows 10 或更高版本的 32 位或 64 位系统。
psql的本机构建不支持命令行编辑。
Cygwin构建支持命令行编辑，
因此在Windows上需要交互式使用psql时应使用它。
PostgreSQL 可以使用微软的 Visual C++ 编译器套件进行构建。这些编译器可以来自
Visual Studio、Visual Studio Express 或某些版本的
Microsoft Windows SDK。如果您还没有设置好
Visual Studio 环境，最简单的方法是使用
Visual Studio 2022 中的编译器，或者使用
Windows SDK 10 中的编译器，这两者都是微软免费提供的下载。
使用微软编译器套件可以构建 32 位和 64 位版本。
32 位 PostgreSQL 可以使用
Visual Studio 2015 到
Visual Studio 2022，
以及独立的 Windows SDK 10 及以上版本进行构建。
64 位 PostgreSQL 支持使用
Microsoft Windows SDK 10 及以上版本或
Visual Studio 2015 及以上版本进行构建。
如果您的构建环境未附带支持版本的
Microsoft Windows SDK，建议您升级到最新版本（当前版本为 10），
可从 https://www.microsoft.com/download 下载。
你必须始终包含 SDK 的
Windows 头文件和库部分。
如果你安装了Windows SDK，
包含了Visual C++ 编译器，
你不需要Visual Studio来构建。
注意，从版本 8.0a 起，Windows SDK 不再附带完整的命令行构建环境。
17.7.5.1. 要求 #
在 Windows 上构建 PostgreSQL 需要以下附加产品。
Strawberry Perl
需要 Strawberry Perl 来运行构建生成脚本。MinGW
或 Cygwin Perl 将无法工作。它还必须在 PATH 中。
二进制文件可以从
https://strawberryperl.com 下载。
Bison 和
Flex
Bison 和
Flex 的二进制文件可以从 https://github.com/lexxmark/winflexbison 下载。
以下附加产品不是入门所必需的，但构建完整软件包时是必需的。
Magicsplat Tcl
构建PL/Tcl所必需。
可从以下网址下载二进制文件：
https://www.magicsplat.com/tcl-installer/index.html。
Diff
运行回归测试需要使用 Diff，可以从
http://gnuwin32.sourceforge.net 下载。
Gettext
Gettext 是构建带有 NLS 支持所必需的，可以从
http://gnuwin32.sourceforge.net 下载。请注意，二进制文件、
依赖项和开发文件都是必需的。
MIT Kerberos
需要支持 GSSAPI 认证。MIT Kerberos 可以从
https://web.mit.edu/Kerberos/dist/index.html 下载。
libxml2 和
libxslt
需要支持XML。二进制文件可以从
https://zlatkovic.com/pub/libxml下载，或者从
http://xmlsoft.org获取源码。请注意，libxml2需要iconv，
该组件可从相同的下载地址获得。
LZ4
支持LZ4压缩所必需。
二进制文件和源码可以从
https://github.com/lz4/lz4/releases下载。
Zstandard
支持Zstandard压缩所必需。
二进制文件和源代码可从
https://github.com/facebook/zstd/releases下载。
OpenSSL
需要支持SSL。二进制文件可以从
https://slproweb.com/products/Win32OpenSSL.html
下载，或者从
https://www.openssl.org
获取源代码。
ossp-uuid
仅在支持UUID-OSSP时需要（仅限贡献模块）。源代码可以从
http://www.ossp.org/pkg/lib/uuid/下载。
Python
构建PL/Python所必需。二进制文件可以从
https://www.python.org下载。
zlib
需要支持pg_dump和pg_restore中的压缩功能。
二进制文件可以从https://www.zlib.net下载。
17.7.5.2. 针对64位Windows的特殊考虑 #
PostgreSQL 仅在 64 位 Windows 上为 x64 架构构建。
在同一个构建树中混合使用 32 位和 64 位版本是不支持的。构建系统会自动检测当前
运行环境是 32 位还是 64 位，并据此构建 PostgreSQL。因此，构建之前启动正确的命
令提示符非常重要。
要使用服务器端的第三方库，例如 Python 或
OpenSSL，该库 必须 也是
64 位的。不支持在 64 位服务器上加载 32 位库。PostgreSQL 支持的几个第三方库
可能仅有 32 位版本，在这种情况下，它们不能与 64 位 PostgreSQL 一起使用。
17.7.5.3. 收集崩溃转储 #
如果 PostgreSQL 在 Windows 上崩溃，它有能力产生 minidumps，这可以用来追踪崩溃发生的原因，这与 Unix 上的核心转储相似。这些转储可以使用 Windows Debugger Tools 或 Visual Studio 读取。要启用在 Windows 上的转储生成，可在集簇数据目录下创建一个名为 crashdumps 的子目录。转储将被写入到这个目录，转储的名字基于崩溃进程的标识符和崩溃的当前时间来确定。
上一页 上一级 下一页17.6. 平台支持 起始页 第 18 章 服务器设置和操作
