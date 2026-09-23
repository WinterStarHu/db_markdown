# 2.9.4 使用标准源代码分发安装 MySQL_MySQL 8.0 参考手册

2.9.4 使用标准源代码分发安装 MySQL_MySQL 8.0 参考手册
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
2.9.4 使用标准源代码分发安装 MySQL
2.9.4 使用标准源代码分发安装 MySQL
从标准源代码分发安装 MySQL：
验证您的系统是否满足第 2.9.2 节“源安装先决条件”中列出的工具要求。
使用第 2.1.3 节“如何获取 MySQL”
中的说明获取分发文件
。
使用本节中的说明配置、构建和安装分发版。
使用第 2.10 节“安装后设置和测试”
中的说明执行安装后过程
。
MySQL在所有平台上都使用CMake作为构建框架。此处给出的说明应该使您能够生成工作安装。有关使用CMake构建 MySQL 的其他信息，请参阅
如何使用 CMake 构建 MySQL 服务器。
如果您从源 RPM 开始，请使用以下命令制作您可以安装的二进制 RPM。如果您没有
rpmbuild，请改用rpm。
$> rpmbuild --rebuild --clean MySQL-VERSION.src.rpm
结果是您安装的一个或多个二进制 RPM 包，如第 2.5.4 节“使用来自 Oracle 的 RPM 包在 Linux 上安装 MySQL”中所述。
从压缩的tar文件或 Zip 存档源分发
安装的顺序
类似于从通用二进制分发安装的过程（请参阅第 2.2 节，“使用通用二进制文件在 Unix/Linux 上安装 MySQL”），除了它用于所有平台，包括配置和编译发行版的步骤。例如，对于 Unix 上的压缩
tar文件源分发，基本安装命令序列如下所示：
# Preconfiguration setup
$> groupadd mysql
$> useradd -r -g mysql -s /bin/false mysql
# Beginning of source-build specific instructions
$> tar zxvf mysql-VERSION.tar.gz
$> cd mysql-VERSION
$> mkdir bld
$> cd bld
$> cmake ..
$> make
$> make install
# End of source-build specific instructions
# Postinstallation setup
$> cd /usr/local/mysql
$> mkdir mysql-files
$> chown mysql:mysql mysql-files
$> chmod 750 mysql-files
$> bin/mysqld --initialize --user=mysql
$> bin/mysql_ssl_rsa_setup
$> bin/mysqld_safe --user=mysql &
# Next command is optional
$> cp support-files/mysql.server /etc/init.d/mysql.server
下面显示了源构建特定说明的更详细版本。
笔记
此处显示的过程不会为 MySQL 帐户设置任何密码。执行该过程后，继续
第 2.10 节“安装后设置和测试”，进行安装后设置和测试。
执行预配置设置获取并解压分发配置分布构建分布安装发行版执行安装后设置
执行预配置设置
在 Unix 上，设置mysql用于运行和执行 MySQL 服务器的用户和组，并拥有数据库目录。有关详细信息，请参阅
创建 mysql 用户和组。然后以用户身份执行以下步骤mysql
，除非另有说明。
获取并解压分发
选择要将分发包解压到的目录，并将位置更改为该目录。
使用第 2.1.3 节“如何获取 MySQL”
中的说明获取分发文件
。
将发行版解压到当前目录：
要解压缩压缩的tar文件，
tar可以解压缩和解压缩发行版，如果它有z选项支持：
$> tar zxvf mysql-VERSION.tar.gz
如果您的tar不
z支持选项，请使用
gunzip解压发行版并
使用tar解压：
$> gunzip < mysql-VERSION.tar.gz | tar xvf -
或者，CMake可以解压缩和解包分发：
$> cmake -E tar zxvf mysql-VERSION.tar.gz
要解压缩 Zip 存档，请使用WinZip或其他可以读取.zip文件的工具。
解压缩分发文件会创建一个名为
.
mysql-VERSION
配置分布
将位置更改为解压缩分发的顶级目录：
$> cd mysql-VERSION
在源代码树之外构建以保持树的清洁。如果顶级源目录在您当前的工作目录下命名
，您可以在同级mysql-src命名的目录中构建
。bld创建目录并转到那里：
$> mkdir bld
$> cd bld
配置构建目录。最小配置命令不包括覆盖配置默认值的选项：
$> cmake ../mysql-src
构建目录不需要在源代码树之外。例如，您可以在
bld顶级源代码树下命名的目录中构建。为此，从mysql-src您当前的工作目录开始，创建该目录
bld，然后转到那里：
$> mkdir bld
$> cd bld
配置构建目录。最小配置命令不包括覆盖配置默认值的选项：
$> cmake ..
如果您在同一级别有多个源代码树（例如，构建多个版本的 MySQL），则第二种策略可能更有优势。第一种策略将所有构建目录置于同一级别，这要求您为每个目录选择一个唯一的名称。使用第二种策略，您可以为每个源代码树中的构建目录使用相同的名称。以下说明采用第二种策略。
在 Windows 上，指定开发环境。例如，以下命令分别为 32 位或 64 位构建配置 MySQL：
$> cmake .. -G "Visual Studio 12 2013"
$> cmake .. -G "Visual Studio 12 2013 Win64"
在 macOS 上，要使用 Xcode IDE：
$> cmake .. -G Xcode
运行cmake时，您可能希望向命令行添加选项。这里有些例子：
-DBUILD_CONFIG=mysql_release：使用 Oracle 使用的相同构建选项配置源代码，以生成官方 MySQL 版本的二进制分发版。
-DCMAKE_INSTALL_PREFIX=dir_name：配置分发以在特定位置安装。
-DCPACK_MONOLITHIC_INSTALL=1: 导致make package生成单个安装文件而不是多个文件。
-DWITH_DEBUG=1：构建具有调试支持的发行版。
有关更广泛的选项列表，请参阅
第 2.9.7 节，“MySQL 源配置选项”。
要列出配置选项，请使用以下命令之一：
$> cmake .. -L   # overview
$> cmake .. -LH  # overview with help text
$> cmake .. -LAH # all params with help text
$> ccmake ..     # interactive display
如果CMake失败，您可能需要通过使用不同的选项再次运行它来重新配置。如果重新配置，请注意以下事项：
如果CMake在之前运行之后运行，它可能会使用在之前调用期间收集的信息。此信息存储在
CMakeCache.txt. 当
CMake启动时，它会查找该文件并读取其内容（如果它存在），前提是信息仍然正确。当您重新配置时，该假设无效。
每次运行CMake时，都必须再次运行
make以重新编译。但是，您可能希望先从以前的构建中删除旧的目标文件，因为它们是使用不同的配置选项编译的。
为防止使用旧的对象文件或配置信息，请在重新运行CMake之前在 Unix 的构建目录中运行这些命令：
$> make clean
$> rm CMakeCache.txt
或者，在 Windows 上：
$> devenv MySQL.sln /clean
$> del CMakeCache.txt
在
MySQL Community Slack上询问之前，检查
CMakeFiles目录中的文件以获取有关失败的有用信息。要提交错误报告，请使用第 1.6 节“如何报告错误或问题”中的说明。
构建分布
在 Unix 上：
$> make
$> make VERBOSE=1
第二个命令设置VERBOSE为显示每个编译源的命令。
在您使用 GNU make并且它已安装为
gmake的系统上
使用gmake代替。
在 Windows 上：
$> devenv MySQL.sln /build RelWithDebInfo
如果您已进入编译阶段，但未构建分发版，请参阅
第 2.9.8 节“处理编译 MySQL 的问题”以获得帮助。如果这不能解决问题，请使用第 1.6 节“如何报告错误或问题”中给出的说明将其输入我们的错误数据库。如果您已经安装了所需工具的最新版本，并且它们在尝试处理我们的配置文件时崩溃，请同时报告。但是，如果您遇到command not
found所需工具的错误或类似问题，请不要报告。相反，请确保安装了所有必需的工具并且PATH正确设置了变量，以便您的 shell 可以找到它们。
安装发行版
在 Unix 上：
$> make install
这会将文件安装在配置的安装目录下（默认情况下为/usr/local/mysql）。您可能需要以root.
要在特定目录中安装，请在
DESTDIR命令行中添加一个参数：
$> make install DESTDIR="/opt/mysql"
或者，生成您可以安装在您喜欢的位置的安装包文件：
$> make package
此操作会生成一个或多个.tar.gz
文件，这些文件可以像通用二进制分发包一样安装。请参阅第 2.2 节，“使用通用二进制文件在 Unix/Linux 上安装 MySQL”。如果您使用 运行
CMake，
-DCPACK_MONOLITHIC_INSTALL=1该操作会生成一个文件。否则，它会生成多个文件。
在 Windows 上，生成数据目录，然后创建一个
.zip存档安装包：
$> devenv MySQL.sln /build RelWithDebInfo /project initial_database
$> devenv MySQL.sln /build RelWithDebInfo /project package
您可以将生成的.zip存档安装在您喜欢的位置。请参阅第 2.3.4 节，“使用
noinstallZIP 存档在 Microsoft Windows 上安装 MySQL”。
执行安装后设置
安装过程的其余部分包括设置配置文件、创建核心数据库和启动 MySQL 服务器。有关说明，请参阅
第 2.10 节 “安装后设置和测试”。
笔记
MySQL 授权表中列出的帐户最初没有密码。启动服务器后，您应该使用第 2.10 节“安装后设置和测试”中的说明为它们设置密码
。
© Mysql 中文网
