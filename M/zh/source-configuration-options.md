# 2.9.7 MySQL 源配置选项_MySQL 8.0 参考手册

2.9.7 MySQL 源配置选项_MySQL 8.0 参考手册
Skip to Main Content
Documentation
MySQL手册
MySQL企业版
工作台
InnoDB集群
MySQL NDB集群
连接器
Section Menu:
Documentation Home
MySQL 8.0 参考手册
前言和法律声明
第一章 一般信息
第 2 章安装和升级 MySQL
2.1 一般安装指南
2.2 使用通用二进制文件在 Unix/Linux 上安装 MySQL
2.3 在 Microsoft Windows 上安装 MySQL
2.4 在 macOS 上安装 MySQL
2.5 在 Linux 上安装 MySQL
2.6 使用坚不可摧的Linux网络（ULN）安装MySQL
2.7 在 Solaris 上安装 MySQL
2.8 在 FreeBSD 上安装 MySQL
2.9 从源码安装MySQL
2.9.1 源码安装方式1
2.9.2 源安装先决条件1
2.9.3 MySQL源码安装布局1
2.9.4 使用标准源代码分发安装 MySQL1
2.9.5 使用开发源树安装MySQL1
2.9.6 配置 SSL 库支持1
2.9.7 MySQL 源配置选项1
2.9.8 处理编译MySQL的问题1
2.9.9 MySQL配置和第三方工具1
2.9.10 生成MySQL Doxygen文档内容1
2.10 安装后设置和测试
2.11 升级MySQL
2.12 降级MySQL
2.13 Perl 安装注意事项
第 3 章教程
第 4 章 MySQL 程序
第 5 章 MySQL 服务器管理
第 6 章 安全
第 7 章备份与恢复
第8章优化
第9章语言结构
第 10 章字符集、排序规则、Unicode
第 11 章数据类型
第 12 章函数和运算符
第 13 章 SQL 语句
第14章MySQL数据字典
第 15 章 InnoDB 存储引擎
第 16 章替代存储引擎
第十七章复制
第十八章 组复制
第十九章MySQL Shell
第 20 章使用 MySQL 作为文档存储
第21章InnoDB Cluster
第 22 章 InnoDB 副本集
第 23 章 MySQL NDB Cluster 8.0
第24章分区
第25章存储对象
第 26 章 INFORMATION_SCHEMA 表
第 27 章 MySQL 性能模式
第 28 章 MySQL 系统模式
第 29 章连接器和 API
第30章MySQL企业版
第31章MySQL工作台
第 32 章 OCI 市场上的 MySQL
附录 A MySQL 8.0 常见问题解答
附录 B 错误信息和常见问题
附录 C 索引
MySQL 词汇表
MySQL 8.0 参考手册  / 第 2 章安装和升级 MySQL  / 2.9 从源码安装MySQL  /
2.9.7 MySQL 源配置选项
2.9.7 MySQL 源配置选项
CMake程序提供了对如何配置 MySQL 源代码分发的大量控制
。通常，您使用
CMake命令行上的选项来执行此操作。有关CMake支持的选项的信息，请在顶级源目录中运行以下任一命令：
cmake . -LH
ccmake .
您还可以使用某些环境变量影响CMake 。请参阅
第 4.9 节，“环境变量”。
对于布尔选项，该值可以指定为 1 或
ON启用该选项，或指定为 0 或
OFF禁用该选项。
许多选项配置可以在服务器启动时覆盖的编译时默认值。例如，
配置默认安装基本目录位置、TCP/IP 端口号和 Unix 套接字文件的 、 和 选项可以在服务器启动时使用CMAKE_INSTALL_PREFIXmysqld
MYSQL_TCP_PORT的
、和
选项
进行
更改。在适用的情况下，配置选项说明指示相应的mysqld
启动选项。
MYSQL_UNIX_ADDR--basedir--port--socket
以下部分提供了有关
CMake选项的更多信息。
CMake 选项参考常规选项安装布局选项存储引擎选项功能选项编译器标志用于编译 NDB Cluster 的 CMake 选项
CMake 选项参考
下表显示了可用的CMake
选项。在该Default列中，
PREFIX代表
CMAKE_INSTALL_PREFIX选项的值，它指定安装基目录。此值用作多个安装子目录的父位置。
表 2.14 MySQL 源配置选项参考（CMake）
格式
描述
默认
介绍
删除
ADD_GDB_INDEX
是否启用在二进制文件中生成 .gdb_index 部分
8.0.18
BUILD_CONFIG
使用与官方版本相同的构建选项
BUNDLE_RUNTIME_LIBRARIES
将运行时库与适用于 Windows 的服务器 MSI 和 Zip 包捆绑在一起
OFF
CMAKE_BUILD_TYPE
要生成的构建类型
RelWithDebInfo
CMAKE_CXX_FLAGS
C++ 编译器的标志
CMAKE_C_FLAGS
C 编译器的标志
CMAKE_INSTALL_PREFIX
安装基目录
/usr/local/mysql
COMPILATION_COMMENT
编译环境评论
COMPILATION_COMMENT_SERVER
关于mysqld使用的编译环境的评论
8.0.14
COMPRESS_DEBUG_SECTIONS
压缩二进制可执行文件的调试部分
OFF
8.0.22
CPACK_MONOLITHIC_INSTALL
打包构建是否产生单个文件
OFF
DEFAULT_CHARSET
默认服务器字符集
utf8mb4
DEFAULT_COLLATION
默认服务器排序规则
utf8mb4_0900_ai_ci
DISABLE_PSI_COND
排除性能模式条件检测
OFF
DISABLE_PSI_DATA_LOCK
排除性能架构数据锁定检测
OFF
DISABLE_PSI_ERROR
排除性能架构服务器错误检测
OFF
DISABLE_PSI_FILE
排除性能架构文件检测
OFF
DISABLE_PSI_IDLE
排除 Performance Schema 空闲检测
OFF
DISABLE_PSI_MEMORY
排除性能模式内存检测
OFF
DISABLE_PSI_METADATA
排除性能模式元数据检测
OFF
DISABLE_PSI_MUTEX
排除性能模式互斥检测
OFF
DISABLE_PSI_PS
排除性能模式准备好的语句
OFF
DISABLE_PSI_RWLOCK
排除性能模式 rwlock 检测
OFF
DISABLE_PSI_SOCKET
排除性能模式套接字检测
OFF
DISABLE_PSI_SP
排除 Performance Schema 存储的程序检测
OFF
DISABLE_PSI_STAGE
排除 Performance Schema 阶段检测
OFF
DISABLE_PSI_STATEMENT
排除 Performance Schema 语句检测
OFF
DISABLE_PSI_STATEMENT_DIGEST
排除 Performance Schema statements_digest 检测
OFF
DISABLE_PSI_TABLE
排除性能架构表检测
OFF
DISABLE_PSI_THREAD
排除性能模式线程检测
OFF
DISABLE_PSI_TRANSACTION
排除性能模式事务检测
OFF
DISABLE_SHARED
不构建共享库，编译依赖于位置的代码
OFF
8.0.18
DOWNLOAD_BOOST
是否下载Boost库
OFF
DOWNLOAD_BOOST_TIMEOUT
下载 Boost 库的超时秒数
600
ENABLED_LOCAL_INFILE
是否为LOAD DATA启用LOCAL
OFF
ENABLED_PROFILING
是否启用查询分析代码
ON
ENABLE_DOWNLOADS
是否下载可选文件
OFF
8.0.26
ENABLE_EXPERIMENTAL_SYSVARS
是否启用实验性 InnoDB 系统变量
OFF
ENABLE_GCOV
是否包含 gcov 支持
ENABLE_GPROF
启用 gprof（仅限优化的 Linux 版本）
OFF
FORCE_INSOURCE_BUILD
是否强制源代码构建
OFF
8.0.14
FORCE_UNSUPPORTED_COMPILER
是否允许不支持的编译器
OFF
FPROFILE_GENERATE
是否生成配置文件引导的优化数据
OFF
8.0.19
FPROFILE_USE
是否使用配置文件引导的优化数据
OFF
8.0.19
HAVE_PSI_MEMORY_INTERFACE
为过度对齐类型的动态存储中使用的内存分配函数启用性能模式内存跟踪模块
OFF
8.0.26
IGNORE_AIO_CHECK
使用-DBUILD_CONFIG=mysql_release，忽略libaio检查
OFF
INSTALL_BINDIR
用户可执行文件目录
PREFIX/bin
INSTALL_DOCDIR
文档目录
PREFIX/docs
INSTALL_DOCREADMEDIR
自述文件目录
PREFIX
INSTALL_INCLUDEDIR
头文件目录
PREFIX/include
INSTALL_INFODIR
信息文件目录
PREFIX/docs
INSTALL_LAYOUT
选择预定义的安装布局
STANDALONE
INSTALL_LIBDIR
库文件目录
PREFIX/lib
INSTALL_MANDIR
手册页目录
PREFIX/man
INSTALL_MYSQLKEYRINGDIR
keyring_file 插件数据文件的目录
platform specific
INSTALL_MYSQLSHAREDIR
共享数据目录
PREFIX/share
INSTALL_MYSQLTESTDIR
mysql测试目录
PREFIX/mysql-test
INSTALL_PKGCONFIGDIR
mysqlclient.pc pkg-config 文件的目录
INSTALL_LIBDIR/pkgconfig
INSTALL_PLUGINDIR
插件目录
PREFIX/lib/plugin
INSTALL_PRIV_LIBDIR
安装私有库目录
8.0.18
INSTALL_SBINDIR
服务器可执行目录
PREFIX/bin
INSTALL_SECURE_FILE_PRIVDIR
secure_file_priv 默认值
platform specific
INSTALL_SHAREDIR
aclocal/mysql.m4 安装目录
PREFIX/share
INSTALL_STATIC_LIBRARIES
是否安装静态库
ON
INSTALL_SUPPORTFILESDIR
额外的支持文件目录
PREFIX/support-files
LINK_RANDOMIZE
是否随机化 mysqld 二进制文件中的符号顺序
OFF
LINK_RANDOMIZE_SEED
LINK_RANDOMIZE 选项的种子值
mysql
MAX_INDEXES
每个表的最大索引
64
MEMCACHED_HOME
内存缓存路径；过时的
[none]
8.0.23
MUTEX_TYPE
InnoDB 互斥量类型
event
MYSQLX_TCP_PORT
X 插件使用的 TCP/IP 端口号
33060
MYSQLX_UNIX_ADDR
X 插件使用的 Unix 套接字文件
/tmp/mysqlx.sock
MYSQL_DATADIR
数据目录
MYSQL_MAINTAINER_MODE
是否开启MySQL maintainer-specific开发环境
OFF
MYSQL_PROJECT_NAME
Windows/macOS 项目名称
MySQL
MYSQL_TCP_PORT
TCP/IP 端口号
3306
MYSQL_UNIX_ADDR
Unix套接字文件
/tmp/mysql.sock
NDB_UTILS_LINK_DYNAMIC
使 NDB 工具动态链接到 ndbclient
8.0.22
ODBC_INCLUDES
ODBC 包含目录
ODBC_LIB_DIR
ODBC库目录
OPTIMIZER_TRACE
是否支持优化器跟踪
REPRODUCIBLE_BUILD
格外小心地创建独立于构建位置和时间的构建结果
SHOW_SUPPRESSED_COMPILER_WARNING
是否显示抑制的编译器警告，并且不会因 -Werror 而失败。
OFF
8.0.30
SYSCONFDIR
选项文件目录
SYSTEMD_PID_DIR
systemd 下 PID 文件的目录
/var/run/mysqld
SYSTEMD_SERVICE_NAME
systemd下MySQL服务名称
mysqld
TMPDIR
tmpdir 默认值
USE_LD_GOLD
是否使用 GNU gold 链接器
ON
USE_LD_LLD
是否使用llvm lld链接器
ON
8.0.16
WIN_DEBUG_NO_INLINE
是否禁用函数内联
OFF
WITHOUT_SERVER
不搭建服务器
OFF
WITHOUT_xxx_STORAGE_ENGINE
从构建中排除存储引擎 xxx
WITH_ANT
用于构建 GCS Java 包装器的 Ant 路径
WITH_ASAN
启用 AddressSanitizer
OFF
WITH_ASAN_SCOPE
启用 AddressSanitizer -fsanitize-address-use-after-scope Clang 标志
OFF
WITH_AUTHENTICATION_CLIENT_PLUGINS
如果构建了任何相应的服务器身份验证插件，则自动启用
8.0.26
WITH_AUTHENTICATION_LDAP
LDAP认证插件无法搭建是​​否报错
OFF
WITH_AUTHENTICATION_PAM
构建 PAM 身份验证插件
OFF
WITH_AWS_SDK
Amazon Web Services 软件开发工具包的位置
WITH_BOOST
Boost 库源的位置
WITH_BUILD_ID
在 Linux 系统上，生成唯一的构建 ID
ON
8.0.31
WITH_BUNDLED_LIBEVENT
构建 ndbmemcache 时使用捆绑的 libevent；过时的
ON
8.0.23
WITH_BUNDLED_MEMCACHED
构建 ndbmemcache 时使用捆绑的 memcached；过时的
ON
8.0.23
WITH_CLASSPATH
为 Java 构建 MySQL Cluster Connector 时使用的类路径。默认为空字符串。
WITH_CLIENT_PROTOCOL_TRACING
构建客户端协议跟踪框架
ON
WITH_CURL
curl 库的位置
WITH_DEBUG
是否包括调试支持
OFF
WITH_DEFAULT_COMPILER_OPTIONS
是否使用默认的编译器选项
ON
WITH_DEFAULT_FEATURE_SET
是否使用默认特征集
ON
8.0.22
WITH_EDITLINE
使用哪个 libedit/editline 库
bundled
WITH_ERROR_INSERT
在 NDB 存储引擎中启用错误注入。不应用于构建用于生产的二进制文件。
OFF
WITH_FIDO
FIDO 库支持的类型
bundled
8.0.27
WITH_GMOCK
googlemock 分发路径
8.0.26
WITH_ICU
ICU 支持类型
bundled
WITH_INNODB_EXTRA_DEBUG
是否包括对 InnoDB 的额外调试支持。
OFF
WITH_INNODB_MEMCACHED
是否生成 memcached 共享库。
OFF
WITH_JEMALLOC
是否链接-ljemalloc
OFF
8.0.16
WITH_KEYRING_TEST
构建密钥环测试程序
OFF
WITH_LIBEVENT
使用哪个 libevent 库
bundled
WITH_LIBWRAP
是否包括 libwrap (TCP wrappers) 支持
OFF
WITH_LOCK_ORDER
是否启用 LOCK_ORDER 工具
OFF
8.0.17
WITH_LSAN
是否运行 LeakSanitizer，不运行 AddressSanitizer
OFF
8.0.16
WITH_LTO
启用链接时间优化器
OFF
8.0.13
WITH_LZ4
LZ4 库支持的类型
bundled
WITH_LZMA
LZMA 库支持的类型
bundled
8.0.16
WITH_MECAB
编译 MeCab
WITH_MSAN
启用 MemorySanitizer
OFF
WITH_MSCRT_DEBUG
启用 Visual Studio CRT 内存泄漏跟踪
OFF
WITH_MYSQLX
是否禁用 X 协议
ON
WITH_NDB
构建 MySQL NDB 集群
OFF
8.0.31
WITH_NDBAPI_EXAMPLES
构建 API 示例程序
OFF
WITH_NDBCLUSTER
构建 NDB 存储引擎
OFF
WITH_NDBCLUSTER_STORAGE_ENGINE
供内部使用；可能无法在所有情况下都按预期工作；用户应该改用 WITH_NDBCLUSTER
ON
WITH_NDBMTD
构建多线程数据节点。
ON
WITH_NDB_DEBUG
生成用于测试或故障排除的调试版本。
OFF
WITH_NDB_JAVA
启用 Java 和 ClusterJ 支持的构建。默认启用。仅在 MySQL 集群中受支持。
ON
WITH_NDB_PORT
使用此选项构建的管理服务器使用的默认端口。如果未使用此选项来构建它，则管理服务器的默认端口为 1186。
[none]
WITH_NDB_TEST
包括 NDB API 测试程序。
OFF
WITH_NUMA
设置 NUMA 内存分配策略
WITH_PACKAGE_FLAGS
对于通常用于 RPM/DEB 包的标志，是否将它们添加到这些平台上的独立构建中
8.0.26
WITH_PLUGIN_NDBCLUSTER
供内部使用；可能无法在所有情况下都按预期工作。用户应该改用 WITH_NDBCLUSTER 或 WITH_NDB
8.0.13
8.0.31
WITH_PROTOBUF
使用哪个 Protocol Buffers 包
bundled
WITH_RAPID
是否构建快速开发周期插件
ON
WITH_RAPIDJSON
RapidJSON 支持的类型
bundled
8.0.13
WITH_RE2
RE2 库支持的类型
bundled
8.0.18
WITH_ROUTER
是否构建MySQL Router
ON
8.0.16
WITH_SSL
SSL 支持类型
system
WITH_SYSTEMD
启用系统支持文件的安装
OFF
WITH_SYSTEMD_DEBUG
启用额外的系统调试信息
OFF
8.0.22
WITH_SYSTEM_LIBS
设置未明确设置的库选项的系统值
OFF
WITH_TCMALLOC
是否链接-ltcmalloc
OFF
8.0.22
WITH_TEST_TRACE_PLUGIN
构建测试协议跟踪插件
OFF
WITH_TSAN
启用 ThreadSanitizer
OFF
WITH_UBSAN
启用未定义的行为消毒器
OFF
WITH_UNIT_TESTS
使用单元测试编译 MySQL
ON
WITH_UNIXODBC
启用 unixODBC 支持
OFF
WITH_VALGRIND
是否在 Valgrind 头文件中编译
OFF
WITH_WIN_JEMALLOC
包含 jemalloc.dll 的目录路径
8.0.29
WITH_ZLIB
zlib 支持的类型
bundled
WITH_ZSTD
zstd 支持的类型
bundled
8.0.18
WITH_xxx_STORAGE_ENGINE
静态编译存储引擎xxx到服务器
常规选项
-DBUILD_CONFIG=mysql_release
此选项使用 Oracle 使用的相同构建选项配置源分发，以生成官方 MySQL 版本的二进制分发。
-DWITH_BUILD_ID=bool
在 Linux 系统上，生成一个唯一的构建 ID，用作
build_id系统变量的值并在启动时写入 MySQL 服务器日志。将此选项设置OFF为禁用此功能。
MySQL 8.0.31新增；对 Linux 以外的平台没有影响。
-DBUNDLE_RUNTIME_LIBRARIES=bool
是否将运行时库与 Windows 的服务器 MSI 和 Zip 包捆绑在一起。
-DCMAKE_BUILD_TYPE=type
要生成的构建类型：
RelWithDebInfo：启用优化并生成调试信息。这是默认的 MySQL 构建类型。
Release：启用优化但省略调试信息以减小构建大小。此构建类型是在 MySQL 8.0.13 中添加的。
Debug：禁用优化并生成调试信息。WITH_DEBUG
如果启用该选项，也会使用此构建类型。也就是说，
-DWITH_DEBUG=1与 具有相同的效果
-DCMAKE_BUILD_TYPE=Debug。
-DCPACK_MONOLITHIC_INSTALL=bool
此选项会影响make package操作是生成多个安装包文件还是单个文件。如果禁用，该操作会生成多个安装包文件，如果您只想安装完整 MySQL 安装的一个子集，这可能很有用。如果启用，它会生成一个文件来安装所有内容。
-DFORCE_INSOURCE_BUILD=bool
定义是否强制进行源内构建。建议使用外源构建，因为它们允许来自同一源的多个构建，并且可以通过删除构建目录来快速执行清理。要强制进行源内构建，请使用
-DFORCE_INSOURCE_BUILD=ON.
安装布局选项
该CMAKE_INSTALL_PREFIX选项表示基本安装目录。具有指示组件位置的形式名称的其他选项
是相对于前缀解释的，它们的值是相对路径名。它们的值不应包含前缀。
INSTALL_xxx
-DCMAKE_INSTALL_PREFIX=dir_name
安装基目录。
该值可以在服务器启动时使用
--basedir选项设置。
-DINSTALL_BINDIR=dir_name
在哪里安装用户程序。
-DINSTALL_DOCDIR=dir_name
在哪里安装文档。
-DINSTALL_DOCREADMEDIR=dir_name
安装README文件的位置。
-DINSTALL_INCLUDEDIR=dir_name
在哪里安装头文件。
-DINSTALL_INFODIR=dir_name
安装信息文件的位置。
-DINSTALL_LAYOUT=name
选择预定义的安装布局：
STANDALONE: 与用于
.tar.gz和
.zip包的布局相同。这是默认设置。
RPM: 类似于 RPM 包的布局。
SVR4：Solaris 包布局。
DEB: DEB 包布局（实验）。
您可以选择预定义的布局，但可以通过指定其他选项来修改各个组件的安装位置。例如：
cmake . -DINSTALL_LAYOUT=SVR4 -DMYSQL_DATADIR=/var/mysql/data
该INSTALL_LAYOUT值确定 、 和系统变量的
secure_file_priv默认
keyring_encrypted_file_data值keyring_file_data
。请参阅第 5.1.8 节“服务器系统变量”和
第 6.4.4.19 节“密钥环系统变量”中对这些变量的描述
。
-DINSTALL_LIBDIR=dir_name
安装库文件的位置。
-DINSTALL_MANDIR=dir_name
在哪里安装手册页。
-DINSTALL_MYSQLKEYRINGDIR=dir_path
用作
keyring_file插件数据文件位置的默认目录。默认值是特定于平台的，取决于CMake选项的值；参见
第 5.1.8 节“服务器系统变量”中系统变量的描述。
INSTALL_LAYOUT
keyring_file_data
-DINSTALL_MYSQLSHAREDIR=dir_name
安装共享数据文件的位置。
-DINSTALL_MYSQLTESTDIR=dir_name
mysql-test
安装目录
在哪里。要禁止安装此目录，请将该选项显式设置为空值 ( -DINSTALL_MYSQLTESTDIR=)。
-DINSTALL_PKGCONFIGDIR=dir_name
安装
供pkg-configmysqlclient.pc使用的文件
的目录。默认值为
，除非
以 结尾
，在这种情况下首先删除。
INSTALL_LIBDIR/pkgconfigINSTALL_LIBDIR/mysql
-DINSTALL_PLUGINDIR=dir_name
插件目录的位置。
该值可以在服务器启动时使用
--plugin_dir选项设置。
-DINSTALL_PRIV_LIBDIR=dir_name
动态库目录的位置。
默认位置：RPM =
/usr/lib64/mysql/private/、DEB =
/usr/lib/mysql/private/和 TAR =
lib/private/。
这个选项是在 MySQL 8.0.18 中添加的。
对于 Protobuf：因为这是一个私有位置，加载程序（例如 Linux 上的 ld-linux.so）可能无法在
libprotobuf.so没有帮助的情况下找到文件。为了引导加载程序，RPATH将值
$ORIGIN/../$INSTALL_PRIV_LIBDIR添加到 mysqld 和 mysqlxtest。这适用于大多数情况，但在使用资源组功能时，mysqld是
setsuid，然后加载程序忽略
RPATH其中包含
$ORIGIN. 为了克服这个问题，在 mysqld 的 DEB 和 RPM 变体中设置了一个明确的目录完整路径，因为目标目的地是已知的。对于 tarball 安装，
需要使用patchelf之类的工具修补 mysqld 。
-DINSTALL_SBINDIR=dir_name
在哪里安装mysqld服务器。
-DINSTALL_SECURE_FILE_PRIVDIR=dir_name
secure_file_priv系统变量
的默认值
。默认值是特定于平台的，取决于
CMake选项的值；参见
第 5.1.8 节“服务器系统变量”中系统变量的描述。
INSTALL_LAYOUT
secure_file_priv
-DINSTALL_SHAREDIR=dir_name
在哪里安装aclocal/mysql.m4。
-DINSTALL_STATIC_LIBRARIES=bool
是否安装静态库。默认值为
ON。如果设置为OFF，则不会安装这些库：
libmysqlclient.a,
libmysqlservices.a。
-DINSTALL_SUPPORTFILESDIR=dir_name
在哪里安装额外的支持文件。
-DLINK_RANDOMIZE=bool
是否随机化
mysqld二进制文件中符号的顺序。默认值为
OFF。此选项应仅为调试目的而启用。
-DLINK_RANDOMIZE_SEED=val
选项的种子值
LINK_RANDOMIZE。该值是一个字符串。默认为mysql，任意选择。
-DMYSQL_DATADIR=dir_name
MySQL 数据目录的位置。
该值可以在服务器启动时使用
--datadir选项设置。
-DODBC_INCLUDES=dir_name
ODBC 的位置包括目录，并且可以在配置连接器/ODBC 时使用。
-DODBC_LIB_DIR=dir_name
ODBC 库目录的位置，可以在配置连接器/ODBC 时使用。
-DSYSCONFDIR=dir_name
默认my.cnf选项文件目录。
这个位置不能在服务器启动时设置，但你可以使用选项用给定的选项文件启动服务器
，其中是文件的完整路径名。
--defaults-file=file_namefile_name
-DSYSTEMD_PID_DIR=dir_name
当 MySQL 由 systemd 管理时，在其中创建 PID 文件的目录的名称。默认是
/var/run/mysqld; 这可能会根据
INSTALL_LAYOUT值隐式更改。
除非
WITH_SYSTEMD启用，否则将忽略此选项。
-DSYSTEMD_SERVICE_NAME=name
当 MySQL 由 systemd 管理时要使用的 MySQL 服务的名称。默认是mysqld; 这可能会根据
INSTALL_LAYOUT值隐式更改。
除非
WITH_SYSTEMD启用，否则将忽略此选项。
-DTMPDIR=dir_name
用于
tmpdir系统变量的默认位置。如果未指定，则该值默认为
P_tmpdirin
<stdio.h>。
存储引擎选项
存储引擎构建为插件。您可以将插件构建为静态模块（编译到服务器中）或动态模块（构建为必须使用INSTALL PLUGIN
语句或--plugin-load
选项安装到服务器中才能使用的动态库）。某些插件可能不支持静态或动态构建。
、InnoDB、
MyISAM、
MERGE和
engines 是必需MEMORY的
CSV（总是编译到服务器中）并且不需要显式安装。
要将存储引擎静态编译到服务器中，请使用
. 一些允许的值是
、、
和。例子：
-DWITH_engine_STORAGE_ENGINE=1engineARCHIVEBLACKHOLEEXAMPLEFEDERATED-DWITH_ARCHIVE_STORAGE_ENGINE=1
-DWITH_BLACKHOLE_STORAGE_ENGINE=1
要构建支持 NDB Cluster 的 MySQL，请使用该
WITH_NDB选项。（NDB 8.0.30 及更早版本：使用
WITH_NDBCLUSTER。）
笔记
没有 Performance Schema 支持就无法编译。如果希望在没有特定类型的检测的情况下进行编译，可以使用以下
CMake选项来完成：
DISABLE_PSI_COND
DISABLE_PSI_DATA_LOCK
DISABLE_PSI_ERROR
DISABLE_PSI_FILE
DISABLE_PSI_IDLE
DISABLE_PSI_MEMORY
DISABLE_PSI_METADATA
DISABLE_PSI_MUTEX
DISABLE_PSI_PS
DISABLE_PSI_RWLOCK
DISABLE_PSI_SOCKET
DISABLE_PSI_SP
DISABLE_PSI_STAGE
DISABLE_PSI_STATEMENT
DISABLE_PSI_STATEMENT_DIGEST
DISABLE_PSI_TABLE
DISABLE_PSI_THREAD
DISABLE_PSI_TRANSACTION
例如，要在没有互斥检测的情况下进行编译，请使用该
-DDISABLE_PSI_MUTEX=1选项配置 MySQL。
要从构建中排除存储引擎，请使用
. 例子：
-DWITH_engine_STORAGE_ENGINE=0-DWITH_ARCHIVE_STORAGE_ENGINE=0
-DWITH_EXAMPLE_STORAGE_ENGINE=0
-DWITH_FEDERATED_STORAGE_ENGINE=0
也可以使用
（但
首选）从构建中排除存储引擎。例子：
-DWITHOUT_engine_STORAGE_ENGINE=1-DWITH_engine_STORAGE_ENGINE=0-DWITHOUT_ARCHIVE_STORAGE_ENGINE=1
-DWITHOUT_EXAMPLE_STORAGE_ENGINE=1
-DWITHOUT_FEDERATED_STORAGE_ENGINE=1
如果给定存储引擎既未
指定也未
指定，则该引擎将构建为共享模块，或者如果无法构建为共享模块则将其排除。
-DWITH_engine_STORAGE_ENGINE-DWITHOUT_engine_STORAGE_ENGINE
功能选项
-DADD_GDB_INDEX=bool
此选项确定是否启用
.gdb_index二进制文件中的部分生成，这使得将它们加载到调试器中更快。默认情况下禁用该选项。使用lld链接器，并被禁用 如果使用
lld或 GNU gold以外的链接器，它没有任何效果。
这个选项是在 MySQL 8.0.18 中添加的。
-DCOMPILATION_COMMENT=string
关于编译环境的描述性注释。从 MySQL 8.0.14 开始，mysqld使用
COMPILATION_COMMENT_SERVER. 其他程序继续使用
COMPILATION_COMMENT。
-DCOMPRESS_DEBUG_SECTIONS=bool
是否压缩二进制可执行文件的调试部分（仅限 Linux）。压缩可执行调试部分可以在构建过程中以额外的 CPU 时间为代价节省空间。
默认值为OFF。如果未显式设置此选项但设置了
COMPRESS_DEBUG_SECTIONS环境变量，则该选项将从该变量中获取其值。
这个选项是在 MySQL 8.0.22 中添加的。
-DCOMPILATION_COMMENT_SERVER=string
关于mysqld使用的编译环境的描述性注释（例如，设置
version_comment系统变量）。这个选项是在 MySQL 8.0.14 中添加的。在 8.0.14 之前，服务器使用
COMPILATION_COMMENT.
-DDEFAULT_CHARSET=charset_name
服务器字符集。默认情况下，MySQL 使用
utf8mb4字符集。
charset_name可能是以下
之一
binary,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,, armscii8_
ascii_ big5_
cp1250_ cp1251_
cp1256_ cp1257_
cp850_ cp852_
cp866_ cp932_
dec8_ eucjpms_
euckr_ gb2312_
gbk_ geostd8_
greek_ hebrew_
hp8_ keybcs2_
koi8r_ koi8u_
latin1_ latin2_
latin5_ latin7_
macce_ macroman_
sjis_ swe7_
tis620_ ucs2_
ujis_ utf8mb3_
utf8mb4utf16utf16leutf32.
该值可以在服务器启动时使用
--character_set_server
选项设置。
-DDEFAULT_COLLATION=collation_name
服务器整理。默认情况下，MySQL 使用
utf8mb4_0900_ai_ci. 使用该
SHOW COLLATION语句确定每个字符集可用的归类。
该值可以在服务器启动时使用
--collation_server选项设置。
-DDISABLE_PSI_COND=bool
是否排除性能模式条件检测。默认是OFF
（包括）。
-DDISABLE_PSI_FILE=bool
是否排除性能模式文件检测。默认是OFF
（包括）。
-DDISABLE_PSI_IDLE=bool
是否排除 Performance Schema 空闲检测。默认是OFF
（包括）。
-DDISABLE_PSI_MEMORY=bool
是否排除性能模式内存检测。默认是OFF
（包括）。
-DDISABLE_PSI_METADATA=bool
是否排除性能模式元数据检测。默认是OFF
（包括）。
-DDISABLE_PSI_MUTEX=bool
是否排除 Performance Schema 互斥检测。默认是OFF
（包括）。
-DDISABLE_PSI_RWLOCK=bool
是否排除 Performance Schema rwlock 检测。默认是OFF
（包括）。
-DDISABLE_PSI_SOCKET=bool
是否排除 Performance Schema 套接字检测。默认是OFF
（包括）。
-DDISABLE_PSI_SP=bool
是否排除 Performance Schema 存储的程序检测。默认是OFF
（包括）。
-DDISABLE_PSI_STAGE=bool
是否排除 Performance Schema 阶段检测。默认是OFF
（包括）。
-DDISABLE_PSI_STATEMENT=bool
是否排除 Performance Schema 语句检测。默认是OFF
（包括）。
-DDISABLE_PSI_STATEMENT_DIGEST=bool
是否排除 Performance Schema statement_digest 检测。默认是OFF
（包括）。
-DDISABLE_PSI_TABLE=bool
是否排除 Performance Schema 表检测。默认是OFF
（包括）。
-DDISABLE_SHARED=bool
是否禁用构建共享库和编译依赖于位置的代码。默认是
OFF（编译与位置无关的代码）。
此选项未使用，已在 MySQL 8.0.18 中删除。
-DDISABLE_PSI_PS=bool
排除性能模式准备语句实例检测。默认是OFF
（包括）。
-DDISABLE_PSI_THREAD=bool
排除性能架构线程检测。默认是OFF（包括）。
只在没有任何检测的情况下构建时禁用线程，因为其他检测依赖于线程。
-DDISABLE_PSI_TRANSACTION=bool
排除性能模式事务检测。默认是OFF（包括）。
-DDISABLE_PSI_DATA_LOCK=bool
排除性能架构数据锁定检测。默认是OFF（包括）。
-DDISABLE_PSI_ERROR=bool
排除性能模式服务器错误检测。默认是OFF（包括）。
-DDOWNLOAD_BOOST=bool
是否下载Boost库。默认值为
OFF。
有关使用 Boost 的更多讨论，请参阅WITH_BOOST选项。
-DDOWNLOAD_BOOST_TIMEOUT=seconds
下载 Boost 库的超时秒数。默认值为 600 秒。
有关使用 Boost 的更多讨论，请参阅WITH_BOOST选项。
-DENABLE_DOWNLOADS=bool
是否下载可选文件。例如，启用此选项后，CMake会下载测试套件用于运行单元测试的 Google Test 发行版，或构建 GCS Java 包装器所需的 Ant 和 JUnit。
从 MySQL 8.0.26 开始，MySQL 源代码分发捆绑了 Google Test 源代码，用于运行基于 Google Test 的单元测试。因此，从那个版本开始，
WITH_GMOCK和
CMake选项被删除，如果指定则被忽略。
ENABLE_DOWNLOADS
-DENABLE_EXPERIMENTAL_SYSVARS=bool
是否启用实验InnoDB
系统变量。实验系统变量适用于从事 MySQL 开发的人员，只能在开发或测试环境中使用，并且可能会在未来的 MySQL 版本中删除，恕不另行通知。有关实验系统变量的信息，请参阅
/storage/innobase/handler/ha_innodb.cc
MySQL 源代码树。可以通过搜索
“ PLUGIN_VAR_EXPERIMENTAL ”来识别实验系统变量。
-DWITHOUT_SERVER=bool
是否在没有 MySQL Server 的情况下构建。默认为 OFF，即构建服务器。
这被认为是一个实验性的选择；最好与服务器一起构建。
-DENABLE_GCOV=bool
是否包含 gcov 支持（仅限 Linux）。
-DENABLE_GPROF=bool
是否启用gprof（仅限优化的 Linux 版本）。
-DENABLED_LOCAL_INFILE=bool
此选项控制 MySQL 客户端库的内置默认
LOCAL功能。因此，没有明确安排的客户端LOCAL根据
ENABLED_LOCAL_INFILEMySQL 构建时指定的设置禁用或启用功能。
默认情况下，MySQL 二进制发行版中的客户端库在编译时
ENABLED_LOCAL_INFILE禁用。如果您从源代码编译 MySQL，请
ENABLED_LOCAL_INFILE根据未做出明确安排的客户端是否应LOCAL分别禁用或启用功能来将其配置为禁用或启用。
ENABLED_LOCAL_INFILE控制客户端LOCAL
功能的默认值。对于服务器，
local_infile系统变量控制服务器端的LOCAL
能力。要显式地使服务器拒绝或允许LOAD DATA
LOCAL语句（无论客户端程序和库在构建时或运行时如何配置） ，分别以
禁用或启用的
方式启动mysqld 。也可以在运行时设置。请参阅
第 6.1.6 节，“LOAD DATA LOCAL 的安全注意事项”。
local_infilelocal_infile
-DENABLED_PROFILING=bool
是否启用查询分析代码（对于
SHOW PROFILEand
SHOW PROFILES语句）。
-DFORCE_UNSUPPORTED_COMPILER=bool
默认情况下，CMake检查支持的编译器的最低版本：Visual Studio 2015 (Windows)；GCC 4.8 或 Clang 3.4 (Linux)；Developer Studio 12.5（Solaris 服务器）；Developer Studio 12.4 或 GCC 4.8（Solaris 客户端库）；Clang 3.6 (macOS)、Clang 3.4 (FreeBSD)。要禁用此检查，请使用
-DFORCE_UNSUPPORTED_COMPILER=ON.
-DSHOW_SUPPRESSED_COMPILER_WARNINGS=bool
显示抑制的编译器警告，并且不会因 -Werror 而失败。默认为关闭。
这个选项是在 MySQL 8.0.30 中添加的。
-DFPROFILE_GENERATE=bool
是否生成配置文件引导优化 (PGO) 数据。此选项可用于通过 GCC 试验 PGO。有关使用和
的信息，请参阅cmake/fprofile.cmakeMySQL 源代码分发中的文件
。这些选项已经通过 GCC 8 和 9 进行了测试。
FPROFILE_GENERATEFPROFILE_USE
这个选项是在 MySQL 8.0.19 中添加的。
-DFPROFILE_USE=bool
是否使用配置文件引导优化 (PGO) 数据。此选项可用于通过 GCC 试验 PGO。有关使用和
的信息，请参阅cmake/fprofile.cmakeMySQL 源代码分发中的文件
。这些选项已经通过 GCC 8 和 9 进行了测试。
FPROFILE_GENERATEFPROFILE_USE
启用FPROFILE_USE还会启用WITH_LTO.
这个选项是在 MySQL 8.0.19 中添加的。
-DHAVE_PSI_MEMORY_INTERFACE=bool
是否为过对齐类型的动态存储中使用
的内存分配函数（库函数）启用性能模式内存跟踪模块。ut::aligned_name
-DIGNORE_AIO_CHECK=bool
如果
-DBUILD_CONFIG=mysql_release
在 Linux 上给出了该选项，则libaio
默认情况下必须链接库。如果您没有
libaio或不想安装它，您可以通过指定
-DIGNORE_AIO_CHECK=1.
-DMAX_INDEXES=num
每个表的最大索引数。默认值为 64。最大值为 255。小于 64 的值将被忽略，并使用默认值 64。
-DMYSQL_MAINTAINER_MODE=bool
是否启用 MySQL 维护者特定的开发环境。如果启用，此选项会导致编译器警告变为错误。
-DMUTEX_TYPE=type
所使用的互斥量类型InnoDB。选项包括：
event: 使用事件互斥锁。这是默认值和原始InnoDB
互斥量实现。
sys: 在 UNIX 系统上使用 POSIX 互斥体。在 Windows 上使用CRITICAL_SECTION对象（如果可用）。
futex: 使用 Linux futexes 而不是条件变量来调度等待线程。
-DMYSQLX_TCP_PORT=port_num
X 插件侦听 TCP/IP 连接的端口号。默认值为 33060。
该值可以在服务器启动时使用
mysqlx_port系统变量设置。
-DMYSQLX_UNIX_ADDR=file_name
服务器侦听 X 插件套接字连接的 Unix 套接字文件路径。这必须是绝对路径名。默认值为/tmp/mysqlx.sock。
该值可以在服务器启动时使用
mysqlx_port系统变量设置。
-DMYSQL_PROJECT_NAME=name
对于 Windows 或 macOS，要合并到项目文件名中的项目名称。
-DMYSQL_TCP_PORT=port_num
服务器侦听 TCP/IP 连接的端口号。默认值为 3306。
该值可以在服务器启动时使用
--port选项设置。
-DMYSQL_UNIX_ADDR=file_name
服务器侦听套接字连接的 Unix 套接字文件路径。这必须是绝对路径名。默认值为/tmp/mysql.sock。
该值可以在服务器启动时使用
--socket选项设置。
-DOPTIMIZER_TRACE=bool
是否支持优化器跟踪。请参阅
MySQL 内部结构：跟踪优化器。
-DREPRODUCIBLE_BUILD=bool
对于 Linux 系统上的构建，此选项控制是否要格外小心地创建独立于构建位置和时间的构建结果。
这个选项是在 MySQL 8.0.11 中添加的。从 MySQL 8.0.12 开始，它默认ON用于
RelWithDebInfo构建。
-DUSE_LD_GOLD=bool
GNU黄金链接器支持在 v8.0.31 中被移除；此 CMake 选项也已删除。
如果可用且未明确禁用， CMake会导致构建过程与 GNU gold链接器链接。要禁用此链接器，请指定该
-DUSE_LD_GOLD=OFF选项。
-DUSE_LD_LLD=bool
如果可用且未明确禁用， CMake会导致构建过程与 Clang 的llvm  lld链接器链接。要禁用此链接器，请指定该
-DUSE_LD_LLD=OFF选项。
这个选项是在 MySQL 8.0.16 中添加的。
-DWIN_DEBUG_NO_INLINE=bool
是否在 Windows 上禁用函数内联。默认为关闭（启用内联）。
-DWITH_ANT=path_name
设置 Ant 的路径，在构建 GCS Java 包装器时需要。WITH_BOOST以与现有CMake 选项类似的方式工作
。设置
WITH_ANT为保存 Ant tarball 或已解压的归档文件的目录路径。当
WITH_ANT未设置或设置为特殊值system时，构建假定二进制ant存在于
$PATH.
-DWITH_ASAN=bool
是否为支持它的编译器启用 AddressSanitizer。默认关闭。
-DWITH_ASAN_SCOPE=bool
是否为 use-after-scope 检测启用 AddressSanitizer
-fsanitize-address-use-after-scopeClang 标志。默认关闭。要使用此选项，-DWITH_ASAN
还必须启用。
-DWITH_AUTHENTICATION_CLIENT_PLUGINS=bool
如果构建了任何相应的服务器身份验证插件，则会自动启用此选项。因此，它的值取决于其他CMake选项，不应明确设置。
这个选项是在 MySQL 8.0.26 中添加的。
-DWITH_AUTHENTICATION_LDAP=bool
LDAP认证插件无法构建时是否报错：
如果禁用此选项（默认设置），则在找到所需的头文件和库时构建 LDAP 插件。如果不是，
CMake会显示一条关于它的注释。
如果启用此选项，则找不到所需的头文件和库会导致
CMake产生错误，从而阻止构建服务器。
-DWITH_AUTHENTICATION_PAM=bool
是否为包含此插件的源树构建 PAM 身份验证插件。（请参阅
第 6.4.1.5 节，“PAM 可插入身份验证”。）如果指定了此选项并且无法编译插件，则构建失败。
-DWITH_AWS_SDK=path_name
Amazon Web Services 软件开发工具包的位置。
-DWITH_BOOST=path_name
构建 MySQL 需要 Boost 库。这些
CMake选项可以控制库源位置，以及是否自动下载：
-DWITH_BOOST=path_name
指定 Boost 库目录位置。也可以通过设置BOOST_ROOT或
WITH_BOOST环境变量来指定 Boost 位置。
-DWITH_BOOST=system也是允许的，表示正确版本的 Boost 安装在标准位置的编译主机上。在这种情况下，使用已安装的 Boost 版本，而不是 MySQL 源代码分发中包含的任何版本。
-DDOWNLOAD_BOOST=bool
指定如果 Boost 源不在指定位置，是否下载它。默认值为
OFF。
-DDOWNLOAD_BOOST_TIMEOUT=seconds
下载 Boost 库的超时秒数。默认值为 600 秒。
例如，如果您通常构建 MySQL 并将对象输出放在bldMySQL 源代码树的子目录中，则可以像这样使用 Boost 构建：
mkdir bld
cd bld
cmake .. -DDOWNLOAD_BOOST=ON -DWITH_BOOST=$HOME/my_boost
这会导致将 Boost 下载到
my_boost您的主目录下的目录中。如果所需的 Boost 版本已经存在，则不进行下载。如果所需的 Boost 版本发生变化，则会下载较新的版本。
如果本地已经安装了 Boost 并且您的编译器会自行找到 Boost 头文件，则可能不需要指定前面的CMake
选项。但是，如果MySQL需要的Boost版本发生变化，而本地安装的版本还没有升级，则可能会出现构建问题。使用
CMake选项应该可以成功构建。
有了上面的允许Boost下载到指定位置的设置，当所需的Boost版本发生变化时，你需要删除bld文件夹，重新创建它，并再次执行cmake步骤。否则，新的 Boost 版本可能无法下载，并且编译可能会失败。
-DWITH_CLIENT_PROTOCOL_TRACING=bool
是否将客户端协议跟踪框架构建到客户端库中。默认情况下，此选项已启用。
有关编写协议跟踪客户端插件的信息，请参阅编写协议跟踪插件。
另请参阅
WITH_TEST_TRACE_PLUGIN选项。
-DWITH_CURL=curl_type
curl库
的位置。curl_type可以是
system（使用系统
curl库）或 curl 库的路径
名。
-DWITH_DEBUG=bool
是否包括调试支持。
使用调试支持配置 MySQL 使您能够--debug="d,parser_debug"
在启动服务器时使用该选项。这会导致用于处理 SQL 语句的 Bison 解析器将解析器跟踪转储到服务器的标准错误输出。通常，此输出会写入错误日志。
存储引擎的同步调试检查在InnoDB
下面定义，
UNIV_DEBUG并且在使用该
WITH_DEBUG选项编译调试支持时可用。编译调试支持时，
innodb_sync_debug
配置选项可用于启用或禁用
InnoDB同步调试检查。
启用WITH_DEBUG还会启用调试同步。该设施用于测试和调试。编译时，Debug Sync 在运行时默认处于禁用状态。要启用它，
请使用
选项启动mysqld ，其中超时值大于 0。（默认值为 0，禁用调试同步。）成为各个同步点的默认超时。
--debug-sync-timeout=NNNInnoDB
当使用该
WITH_DEBUG选项
编译调试支持时，存储引擎的
同步调试检查可用。
有关调试同步工具的描述以及如何使用同步点，请参阅
MySQL 内部结构：测试同步。
-DWITH_DEFAULT_FEATURE_SET=bool
是否使用来自
cmake/build_configurations/feature_set.cmake. 该选项在 MySQL 8.0.22 中被移除。
-DWITH_EDITLINE=value
使用哪个libedit/editline
库。允许的值为
bundled（默认值）和
system.
-DWITH_FIDO=fido_type
authentication_fido身份验证插件是使用 FIDO 库实现的（请参阅
第6.4.1.11 节，“FIDO 可插入身份验证”）。该
WITH_FIDO选项表示 FIDO 支持的来源：
bundled: 使用发行版捆绑的 FIDO 库。这是默认值。
从 MySQL 8.0.30 开始，MySQL 包含
fido2版本 1.8.0。（以前的版本使用fido21.5.0）。
system：使用系统FIDO库。
这个选项是在 MySQL 8.0.27 中添加的。
-DWITH_GMOCK=path_name
googlemock 发行版的路径，用于基于 Google 测试的单元测试。选项值是分发 Zip 文件的路径。或者，将
WITH_GMOCK环境变量设置为路径名。也可以使用
-DENABLE_DOWNLOADS=1, 以便
CMake从 GitHub 下载分发版。
如果您在没有基于 Google Test 的单元测试的情况下构建 MySQL（通过不配置
WITH_GMOCK），
CMake会显示一条消息，指示如何下载它。
从 MySQL 8.0.26 开始，MySQL 源代码分发捆绑了 Google Test 源代码，用于运行基于 Google Test 的单元测试。因此，从那个版本开始，
WITH_GMOCK和
CMake选项被删除，如果指定则被忽略。
ENABLE_DOWNLOADS
-DWITH_ICU={icu_type|path_name}
MySQL 使用 International Components for Unicode (ICU) 来支持正则表达式操作。该
WITH_ICU选项指示要包含的 ICU 支持类型或要使用的 ICU 安装的路径名。
icu_type可以是以下值之一：
bundled：使用与发行版捆绑在一起的 ICU 库。这是默认设置，也是 Windows 唯一支持的选项。
system: 使用系统 ICU 库。
path_name是要使用的 ICU 安装的路径名。这可能比使用icu_type值更可取，
system因为它可以防止 CMake 检测和使用系统上安装的较旧或不正确的 ICU 版本。（另一种允许做同样事情的方法是设置WITH_ICU
为system并将
CMAKE_PREFIX_PATH选项设置为
path_name。）
-DWITH_INNODB_EXTRA_DEBUG=bool
是否包含额外的 InnoDB 调试支持。
启用WITH_INNODB_EXTRA_DEBUG会打开额外的 InnoDB 调试检查。此选项只能在启用时WITH_DEBUG启用。
-DWITH_INNODB_MEMCACHED=bool
是否生成 memcached 共享库（libmemcached.so和
innodb_engine.so）。
-DWITH_JEMALLOC=bool
是否与-ljemalloc. 如果启用，内置malloc()、
calloc()、realloc()和free()例程将被禁用。默认值为OFF。
WITH_JEMALLOC并且
WITH_TCMALLOC是互斥的。
这个选项是在 MySQL 8.0.16 中添加的。
-DWITH_WIN_JEMALLOC=string
在 Windows 上，将路径传递到包含
jemalloc.dll启用 jemalloc 功能的目录。构建系统复制
到与和/或
jemalloc.dll相同的目录，
并将其用于内存管理操作。如果未找到或未导出所需函数，则使用标准内存函数。INFORMATION 级别的日志消息记录是否找到并使用了 jemalloc。
mysqld.exemysqld-debug.exejemalloc.dll
为 Windows 的官方 MySQL 二进制文件启用此选项。
这个选项是在 MySQL 8.0.29 中添加的。
-DWITH_KEYRING_TEST=bool
keyring_file是否构建插件
附带的测试程序
。默认值为
OFF。测试文件源代码位于plugin/keyring/keyring-test
目录中。
-DWITH_LIBEVENT=string
使用哪个libevent库。允许的值为bundled(default) 和
system. 在 MySQL 8.0.21 之前，如果指定system，则系统
libevent库如果存在则使用，否则会出错。MySQL 8.0.21及以后版本，如果
system指定了，找不到系统
libevent库，不管怎样都会报错，
libevent不使用bundled。
memcached、X 插件和 MySQL 路由器
需要
该libevent库
。InnoDB
-DWITH_LIBWRAP=bool
是否包含libwrap（TCP 包装器）支持。
-DWITH_LOCK_ORDER=bool
是否启用 LOCK_ORDER 工具。默认情况下，此选项被禁用并且服务器构建不包含任何工具。如果启用了工具，则 LOCK_ORDER 工具可用并且可以按照第 5.9.3 节“LOCK_ORDER 工具”中的描述使用。
笔记
WITH_LOCK_ORDER
启用
该选项后，MySQL 构建需要flex程序。
这个选项是在 MySQL 8.0.17 中添加的。
-DWITH_LSAN=bool
是否运行 LeakSanitizer，没有 AddressSanitizer。默认值为OFF。
这个选项是在 MySQL 8.0.16 中添加的。
-DWITH_LTO=bool
是否启用链接时优化器（如果编译器支持）。OFF除非
已启用，否则默认FPROFILE_USE为启用。
这个选项是在 MySQL 8.0.13 中添加的。
-DWITH_LZ4=lz4_type
该WITH_LZ4选项表示zlib支持的来源：
bundled：使用
lz4与发行版捆绑在一起的库。这是默认设置。
system: 使用系统
lz4库。如果
WITH_LZ4设置为此值，则不会构建lz4_decompress实用程序。在这种情况下，
可以改用
系统lz4命令。
-DWITH_LZMA=lzma_type
要包含的 LZMA 库支持类型。
lzma_type可以是以下值之一：
bundled：使用与发行版捆绑在一起的 LZMA 库。这是默认值。
system: 使用系统 LZMA 库。
该选项在 MySQL 8.0.16 中被移除。
-DWITH_MECAB={disabled|system|path_name}
使用此选项编译 MeCab 解析器。如果您已将 MeCab 安装到其默认安装目录，请将
-DWITH_MECAB=system. 该
system选项适用于使用本机包管理实用程序从源代码或二进制文件执行的 MeCab 安装。如果将 MeCab 安装到自定义安装目录，请指定 MeCab 安装路径。例如，
-DWITH_MECAB=/opt/mecab。如果该
system选项不起作用，则指定 MeCab 安装路径应该在所有情况下都有效。
有关相关信息，请参阅
第 12.10.9 节，“MeCab 全文解析器插件”。
-DWITH_MSAN=bool
是否为支持它的编译器启用 MemorySanitizer。默认关闭。
要使此选项在启用时生效，所有链接到 MySQL 的库也必须在启用该选项的情况下进行编译。
-DWITH_MSCRT_DEBUG=bool
是否启用 Visual Studio CRT 内存泄漏跟踪。默认值为OFF。
-DWITH_MYSQLX=bool
是否构建支持 X 插件。默认
ON。请参阅第 20 章，使用 MySQL 作为文档存储。
-DWITH_NUMA=bool
显式设置 NUMA 内存分配策略。
CMakeWITH_NUMA根据当前平台是否NUMA
支持设置默认
值。对于不支持 NUMA 的平台，
CMake的行为如下：
没有 NUMA 选项（正常情况），
CMake正常继续，只产生这个警告：NUMA library missing or required version not available
使用-DWITH_NUMA=ON，
CMake中止并出现此错误：NUMA 库丢失或所需版本不可用
-DWITH_PACKAGE_FLAGS=bool
对于通常用于 RPM 和 Debian 软件包的标志，是否将它们添加到这些平台上的独立构建中。默认是非ON调试构建。
这个选项是在 MySQL 8.0.26 中添加的。
-DWITH_PROTOBUF=protobuf_type
使用哪个 Protocol Buffers 包。
protobuf_type可以是以下值之一：
bundled：使用与发行版捆绑在一起的软件包。这是默认值。可选择用于
INSTALL_PRIV_LIBDIR修改动态 Protobuf 库目录。
system：使用系统上安装的包。
其他值将被忽略，回退到
bundled.
-DWITH_RAPID=bool
是否构建快速开发周期插件。启用后，将rapid在包含这些插件的构建树中创建一个目录。禁用时，不会rapid在构建树中创建目录。默认为ON，除非该
rapid目录已从源代码树中删除，在这种情况下默认变为
OFF.
-DWITH_RAPIDJSON=rapidjson_type
要包含的 RapidJSON 库支持的类型。
rapidjson_type可以是以下值之一：
bundled：使用与发行版捆绑在一起的 RapidJSON 库。这是默认值。
system: 使用系统 RapidJSON 库。需要 1.1.0 或更高版本。
这个选项是在 MySQL 8.0.13 中添加的。
-DWITH_RE2=re2_type
要包含的 RE2 库支持类型。
re2_type可以是以下值之一：
bundled：使用与发行版捆绑在一起的 RE2 库。这是默认值。
system: 使用系统 RE2 库。
从 MySQL 8.0.18 开始，MySQL 不再使用 RE2 库，并且删除了该选项。
-DWITH_ROUTER=bool
是否构建 MySQL Router。默认值为
ON。
这个选项是在 MySQL 8.0.16 中添加的。
-DWITH_SSL={ssl_type| path_name}
为了支持加密连接、随机数生成的熵和其他与加密相关的操作，MySQL 必须使用 SSL 库构建。此选项指定要使用的 SSL 库。
ssl_type可以是以下值之一：
system: 使用系统 OpenSSL 库。这是默认值。
在 macOS 和 Windows 上，使用
system将 MySQL 配置为构建，就像调用 CMake 并
path_name指向手动安装的 OpenSSL 库一样。这是因为它们没有系统 SSL 库。在 macOS 上，
brew install openssl安装到/usr/local/opt/openssl以便system可以找到它。在 Windows 上，它检查
%ProgramFiles%/OpenSSL、
%ProgramFiles%/OpenSSL-Win32、
%ProgramFiles%/OpenSSL-Win64、
C:/OpenSSL,
C:/OpenSSL-Win32和
C:/OpenSSL-Win64。
yes: 这是 的同义词
system。
openssl[\d]：使用备用 OpenSSL 系统包，例如
EL7 上的openssl11或
EL8 上的openssl3。在 v8.0.30 中添加了支持。
身份验证插件（例如 LDAP 和 Kerberos）被禁用，因为它们不支持这些替代版本的 OpenSSL。
path_name是要使用的 OpenSSL 安装的路径名。这可能比使用ssl_type值更可取，system因为它可以防止 CMake 检测和使用系统上安装的较旧或不正确的 OpenSSL 版本。（另一种允许做同样事情的方法是设置
WITH_SSL为system
并将CMAKE_PREFIX_PATH选项设置为
path_name。）
有关配置 SSL 库的其他信息，请参阅
第 2.9.6 节，“配置 SSL 库支持”。
-DWITH_SYSTEMD=bool
是否启用系统支持文件的安装。默认情况下，此选项被禁用。启用后，会安装 systemd 支持文件，
但不会安装mysqld_safe和 System V 初始化脚本等脚本。在 systemd 不可用的平台上，启用
WITH_SYSTEMD会导致CMake出错。
有关使用 systemd 的更多信息，请参阅
第 2.5.9 节，“使用 systemd 管理 MySQL 服务器”。该部分还包括有关指定先前在
[mysqld_safe]选项组中指定的选项的信息。因为
在使用 systemd 时没有安装mysqld_safe，所以必须以其他方式指定此类选项。
-DWITH_SYSTEM_LIBS=bool
此选项用作“保护伞”选项，用于设置
以下
任何
system未明确设置
的
CMake选项
的
值
：
WITH_CURL、、、、、、、、、、、、、
。
WITH_EDITLINEWITH_FIDOWITH_ICUWITH_LIBEVENTWITH_LZ4WITH_LZMAWITH_PROTOBUFWITH_RE2WITH_SSLWITH_ZSTD
WITH_ZLIB在 v8.0.30 之前包含在此处。
-DWITH_SYSTEMD_DEBUG=bool
是否为使用 systemd 运行 MySQL 的平台生成额外的 systemd 调试信息。默认值为OFF。
这个选项是在 MySQL 8.0.22 中添加的。
-DWITH_TCMALLOC=bool
是否与-ltcmalloc. 如果启用，内置malloc()、
calloc()、realloc()和free()例程将被禁用。默认值为OFF。
WITH_TCMALLOC并且
WITH_JEMALLOC是互斥的。
这个选项是在 MySQL 8.0.22 中添加的。
-DWITH_TEST_TRACE_PLUGIN=bool
是否构建测试协议跟踪客户端插件（请参阅
使用测试协议跟踪插件）。默认情况下，此选项被禁用。除非启用该选项，否则启用该选项无效
WITH_CLIENT_PROTOCOL_TRACING
。如果 MySQL 配置为启用两个选项，则libmysqlclient客户端库将使用内置的测试协议跟踪插件构建，并且所有标准 MySQL 客户端都会加载该插件。但是，即使启用了测试插件，默认情况下也没有效果。使用环境变量提供对插件的控制；请参阅
使用测试协议跟踪插件。
笔记
如果您想使用自己的协议跟踪插件，请
不要启用该
WITH_TEST_TRACE_PLUGIN
选项，因为一次只能加载一个这样的插件，并且尝试加载第二个插件时会发生错误。如果您已经在启用测试协议跟踪插件的情况下构建了 MySQL 以查看其工作原理，则必须在没有它的情况下重建 MySQL，然后才能使用您自己的插件。
有关编写跟踪插件的信息，请参阅
编写协议跟踪插件。
-DWITH_TSAN=bool
是否为支持它的编译器启用 ThreadSanitizer。默认关闭。
-DWITH_UBSAN=bool
是否为支持它的编译器启用 Undefined Behavior Sanitizer。默认关闭。
-DWITH_UNIT_TESTS={ON|OFF}
如果启用，使用单元测试编译 MySQL。除非未编译服务器，否则默认值为 ON。
-DWITH_UNIXODBC=1
为连接器/ODBC 启用 unixODBC 支持。
-DWITH_VALGRIND=bool
是否在 Valgrind 头文件中编译，这将 Valgrind API 暴露给 MySQL 代码。默认值为
OFF。
要生成 Valgrind 感知调试版本，
-DWITH_VALGRIND=1通常与-DWITH_DEBUG=1. 请参阅
构建调试配置。
-DWITH_ZLIB=zlib_type
某些功能要求服务器构建有压缩库支持，例如
COMPRESS()和
UNCOMPRESS()函数，以及客户端/服务器协议的压缩。该
WITH_ZLIB选项表示zlib支持的来源：
从 MySQL 8.0.30 开始，支持的最低zlib版本是 1.2.12。
bundled：使用
zlib与发行版捆绑在一起的库。这是默认设置。
system: 使用系统
zlib库。如果
WITH_ZLIB设置为此值，则不会构建zlib_decompress实用程序。在这种情况下，可以改用
系统openssl zlib命令。
-DWITH_ZSTD=zstd_type
使用该zstd
算法的连接压缩（请参阅
第 4.2.8 节，“连接压缩控制”）要求服务器构建有zstd
库支持。该WITH_ZSTD
选项表示zstd
支持的来源：
bundled：使用
zstd与发行版捆绑在一起的库。这是默认设置。
system: 使用系统
zstd库。
这个选项是在 MySQL 8.0.18 中添加的。
编译器标志
-DCMAKE_C_FLAGS="flags“
C 编译器的标志。
-DCMAKE_CXX_FLAGS="flags“
C++ 编译器的标志。
-DWITH_DEFAULT_COMPILER_OPTIONS=bool
是否使用来自
cmake/build_configurations/compiler_options.cmake.
笔记
所有优化标志均由 MySQL 构建团队精心选择和测试。覆盖它们可能会导致意外结果，风险由您自行承担。
要指定您自己的 C 和 C++ 编译器标志，对于不影响优化的标志，请使用
CMAKE_C_FLAGS和
CMAKE_CXX_FLAGSCMake 选项。
在提供您自己的编译器标志时，您可能还想指定CMAKE_BUILD_TYPE。
例如，要在 64 位 Linux 机器上创建 32 位发布版本，请执行以下操作：
mkdir bld
cd bld
cmake .. -DCMAKE_C_FLAGS=-m32 \
-DCMAKE_CXX_FLAGS=-m32 \
-DCMAKE_BUILD_TYPE=RelWithDebInfo
如果设置影响优化的标志 ( )，则必须设置
和/或
选项，其中对应于值。要为默认构建类型 ( )
指定不同的优化，请设置和
选项。例如，要在 Linux 上使用和使用调试符号进行编译，请执行以下操作：
-OnumberCMAKE_C_FLAGS_build_typeCMAKE_CXX_FLAGS_build_typebuild_typeCMAKE_BUILD_TYPERelWithDebInfoCMAKE_C_FLAGS_RELWITHDEBINFOCMAKE_CXX_FLAGS_RELWITHDEBINFO-O3cmake .. -DCMAKE_C_FLAGS_RELWITHDEBINFO="-O3 -g" \
-DCMAKE_CXX_FLAGS_RELWITHDEBINFO="-O3 -g"
用于编译 NDB Cluster 的 CMake 选项
以下选项用于构建具有 NDB Cluster 支持的 MySQL 8.0 源。
-DMEMCACHED_HOME=dir_name
NDBNDB 8.0.23 中删除了对 memcached 的支持；因此，此选项不再支持NDB在此版本或更高版本中构建。
-DNDB_UTILS_LINK_DYNAMIC={ON|OFF}
控制 NDB 实用程序（例如
ndb_drop_table ）是
ndbclient静态链接（OFF）还是动态链接（ON）；OFF（静态链接）是默认值。通常在构建这些文件时使用静态链接以避免出现问题
LD_LIBRARY_PATH，或者在ndbclient安装多个版本时使用。此选项旨在用于创建 Docker 映像以及可能的其他情况，在这些情况下，目标环境受到精确控制并且希望减小映像大小。
在 NDB 8.0.22 中添加。
-DWITH_BUNDLED_LIBEVENT={ON|OFF}
NDBNDB 8.0.23 中删除了对 memcached 的支持；因此，此选项不再支持NDB在此版本或更高版本中构建。
-DWITH_BUNDLED_MEMCACHED={ON|OFF}
NDBNDB 8.0.23 中删除了对 memcached 的支持；因此，此选项不再支持NDB在此版本或更高版本中构建。
-DWITH_CLASSPATH=path
设置用于构建 NDB Cluster Connector for Java 的类路径。默认为空。如果使用此选项，则忽略该选项
-DWITH_NDB_JAVA=OFF。
-DWITH_ERROR_INSERT={ON|OFF}
在
NDB内核中启用错误注入。仅供测试；不适用于构建生产二进制文件。默认值为OFF。
-DWITH_NDB={ON|OFF}
构建 MySQL NDB 集群；构建 NDB 插件和所有 NDB 程序。
在 NDB 8.0.31 中添加。
-DWITH_NDBAPI_EXAMPLES={ON|OFF}
在
storage/ndb/ndbapi-examples/.
-DWITH_NDBCLUSTER_STORAGE_ENGINE={ON|OFF}
NDB 8.0.30 及更早版本：仅供内部使用；可能并不总是按预期工作。NDB要在支持下
构建
WITH_NDBCLUSTER改用。
NDB 8.0.31 及更高版本：（仅）控制ndbcluster插件是否包含在构建中；WITH_NDB自动启用此选项，因此建议您改用它WITH_NDB。
-DWITH_NDBCLUSTER={ON|OFF}
构建并链接以支持
mysqldNDB中的存储引擎
。
此选项在 NDB 8.0.31 中已弃用，最终将被删除；改用WITH_NDB
。
-DWITH_NDBMTD={ON|OFF}
构建多线程数据节点可执行文件
ndbmtd。默认值为
ON。
-DWITH_NDB_DEBUG={ON|OFF}
启用构建 NDB Cluster 二进制文件的调试版本。默认关闭。
-DWITH_NDB_JAVA={ON|OFF}
使用 Java 支持构建 NDB Cluster，包括
ClusterJ.
默认情况下此选项为 ON。如果您不希望使用 Java 支持编译 NDB Cluster，则必须通过
-DWITH_NDB_JAVA=OFF在运行
CMake时指定来显式禁用它。否则，如果找不到 Java，构建配置将失败。
-DWITH_NDB_PORT=port
导致构建的 NDB Cluster 管理服务器（ndb_mgmd）默认使用它
port。如果未设置此选项，生成的管理服务器默认会尝试使用端口 1186。
-DWITH_NDB_TEST={ON|OFF}
如果启用，包括一组 NDB API 测试程序。默认为关闭。
-DWITH_PLUGIN_NDBCLUSTER={ON|OFF}
仅限内部使用; 可能并不总是按预期工作。这个选项在 NDB 8.0.31 中被移除；改用它
WITH_NDB来构建 MySQL 集群。（NDB 8.0.30 及更早版本：使用WITH_NDBCLUSTER。）
© Mysql 中文网
