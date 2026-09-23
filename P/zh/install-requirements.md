# 17.1. 要求

17.1. 要求
版本：
纠错本页面
搜索
目录导航
❮
❯
17.1. 要求 #
一般来说，一个现代的与Unix兼容的平台应该能够运行
PostgreSQL。
在发布时经过特定测试的平台在第 17.6 节
中进行了描述。
构建PostgreSQL需要以下软件包：
GNU make版本3.81或更新版本是必需的；其他
make程序或较旧的GNU make版本将无法工作。
(GNU make有时会以
名称gmake安装。)要测试GNU
make，请输入：
make --version
另外，PostgreSQL可以使用
Meson构建。这是
在Windows上使用Visual Studio构建
PostgreSQL的唯一选项。对于其他平台，
使用Meson目前是实验性的。如果
您选择使用Meson，则不需要
GNU make，但下面的
其他要求仍然适用。
Meson的最低要求版本是0.54。
您需要一个ISO/ANSI C 编译器（至少
兼容 C99）。推荐使用最新版本的GCC，但
PostgreSQL已知可以使用来自不同厂商的多种
编译器进行构建。
tar 是解压源代码分发包所需的工具，
另外还需要 gzip 或 bzip2。
Flex 和 Bison 是
必需的。其他 lex 和
yacc 程序不能使用。
Bison 至少需要版本 2.3。
Perl 5.14 或更高版本在构建过程中以及运行某些测试套件时是必需的。
（此要求与构建 PL/Perl 的要求是分开的；详见下文。）
默认情况下使用GNUReadline库。
它允许psql（PostgreSQL命令行SQL解释器）记住
您输入的每个命令，并允许您使用箭头键来回忆和编辑之前的命令。
这非常有帮助，并且强烈推荐使用。如果您不想使用它，则必须为
configure指定--without-readline选项。
作为替代方案，您通常可以使用BSD许可的libedit库，
它最初是在NetBSD上开发的。
libedit库与GNU
Readline兼容，并且在找不到
libreadline时，或者使用
--with-libedit-preferred作为
configure的选项时会被使用。
如果您使用基于软件包的Linux发行版，请注意，您需要同时安装
readline和readline-devel软件包，
如果它们在您的发行版中是分开的。
默认使用zlib压缩库。如果您不想使用它，
则必须为configure指定--without-zlib
选项。使用此选项会禁用pg_dump和
pg_restore中对压缩归档的支持。
默认使用ICU库。如果您不想使用它，则必须为configure
指定--without-icu选项。使用此选项会禁用对ICU排序功能
的支持（请参见第 23.2 节）。
ICU支持需要安装ICU4C软件包。当前所需的
ICU4C最低版本是4.2。
默认情况下，
pkg-config
将被用来找到所需的编译选项。这适用于
ICU4C版本4.6及更高版本。
对于旧版本，或者如果pkg-config不可用，
可以将变量ICU_CFLAGS和
ICU_LIBS指定给
configure，例如以下示例：
./configure ... ICU_CFLAGS='-I/some/where/include' ICU_LIBS='-L/some/where/lib -licui18n -licuuc -licudata'
（如果ICU4C位于编译器的默认搜索路径中，
那么您仍然需要指定非空字符串以避免使用
pkg-config，例如，
ICU_CFLAGS=' '。）
以下软件包是可选的。它们在默认配置中不是必需的，但在启用某些构建选项时是必需的，如下所述：
要构建服务器编程语言
PL/Perl，您需要一个完整的
Perl安装，包括
libperl库和头文件。
最低要求的版本是Perl 5.14。
由于PL/Perl将是一个共享库，
libperl库在大多数平台上也必须是一个共享库。
这似乎是最近Perl版本中的默认设置，
但在早期版本中并非如此，无论如何，这取决于在您站点安装
Perl 的人所做的选择。如果选择构建
PL/Perl但无法找到共享的
libperl，configure将会失败。
在这种情况下，您将不得不手动重新构建和安装
Perl，以便能够构建
PL/Perl。在
Perl的配置过程中，请请求一个共享库。
如果您打算更多地使用PL/Perl，您应该确保Perl安装是使用usemultiplicity选项构建的（perl -V将显示是否是这种情况）。
要构建 PL/Python 服务器编程
语言，您需要一个包含头文件和
sysconfig 模块的 Python
安装。最低支持版本为 Python 3.6.8。
由于PL/Python将是一个共享库，
libpython库在大多数平台上也必须是一个共享库。这在默认的
Python源码构建的安装中并非如此，但在许多操作系统
发行版中提供了一个共享库。configure如果选择构建
PL/Python但找不到共享的libpython，将会失败。
这可能意味着您需要安装额外的软件包或重新构建（部分）Python安装以提供这个共享库。
在从源代码构建时，使用Python的configure命令带上--enable-shared标志。
要构建PL/Tcl过程语言，您当然需要安装Tcl。
最低要求的版本是Tcl 8.4。
要启用本地语言支持（NLS），也就是能够以非英语的语言显示
程序的消息，您需要一个Gettext API
的实现。一些操作系统内置了此功能（例如，Linux、NetBSD、
Solaris），对于其他系统，您可以从
https://www.gnu.org/software/gettext/下载一个附加包。
如果您使用的是GNU C 库中的Gettext
实现，那么您还需要GNU Gettext包来获取一些实用程序。
对于其他实现，您则不需要它。
如果您想支持加密的客户端连接，则需要 OpenSSL。
OpenSSL 还用于在没有
/dev/urandom 的平台上生成随机数（除了 Windows）。
最低要求版本为 1.1.1。
此外，使用 OpenSSL 兼容层支持
LibreSSL。最低要求版本为 3.4（来自
OpenBSD 版本 7.0）。
您需要MIT Kerberos（用于GSSAPI），
OpenLDAP，和/或PAM，
如果您想支持使用这些服务进行身份验证。
您需要 Curl 来构建一个可选模块，
该模块实现客户端应用程序的 OAuth 设备
授权流程。
如果您想要支持使用该方法对数据进行压缩，您需要LZ4；请参见
default_toast_compression和
wal_compression。
如果您想要支持使用该方法对数据进行压缩，您需要Zstandard；请参见wal_compression。
最低要求版本为1.4.0。
要构建PostgreSQL文档，需要满足一组单独的要求；请参见第 J.2 节。
如果你需要获取GNU包，你可以在你的本地GNU镜像站点（查看 https://www.gnu.org/prep/ftp
的列表）或在ftp://ftp.gnu.org/gnu/找到它。
上一页 上一级 下一页第 17 章 从源代码安装 起始页 17.2. 获取源码
