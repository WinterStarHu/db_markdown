# 2.9.2 源安装先决条件_MySQL 8.0 参考手册

2.9.2 源安装先决条件_MySQL 8.0 参考手册
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
2.9.2 源安装先决条件
2.9.2 源安装先决条件
从源代码安装 MySQL 需要几个开发工具。无论您使用标准源代码分发还是开发源代码树，都需要其中一些工具。其他工具要求取决于您使用的安装方法。
要从源安装 MySQL，无论安装方法如何，都必须满足以下系统要求：
CMake，用作所有平台上的构建框架。CMake可以从http://www.cmake.org下载。
一个很好的制作程序。尽管某些平台带有自己的make
实现，但强烈建议您使用 GNU
make 3.75 或更高版本。它可能已经作为gmake在您的系统上可用。GNU
make可从
http://www.gnu.org/software/make/获得。
从 MySQL 8.0.27 开始，MySQL 8.0 源代码允许使用 C++17 功能。为了在所有支持的平台上实现良好的 C++17 支持，以下最低编译器版本适用。
Linux：GCC 7.1 或 Clang 5
苹果电脑：XCode 10
索拉里斯：海湾合作委员会 10
Windows：Visual Studio 2019 更新 4
MySQL C API 需要 C++ 或 C99 编译器来编译。
需要一个 SSL 库来支持加密连接、随机数生成的熵以及其他与加密相关的操作。默认情况下，构建使用安装在主机系统上的 OpenSSL 库。要明确指定库，
WITH_SSL请在调用
CMake时使用该选项。有关其他信息，请参阅
第 2.9.6 节 “配置 SSL 库支持”。
Boost C++ 库是构建 MySQL 所必需的（但不是使用它）。MySQL 编译需要特定的 Boost 版本。通常，这是当前的 Boost 版本，但如果特定的 MySQL 源分发需要不同的版本，则配置过程会停止并显示一条消息，指示它需要的 Boost 版本。要获取 Boost 及其安装说明，请访问
官方网站。安装 Boost 后，通过在调用CMakeWITH_BOOST时定义选项来告诉构建系统 Boost 文件所在的位置
。例如：
cmake . -DWITH_BOOST=/usr/local/boost_version_number
根据需要调整路径以匹配您的安装。
ncurses
库
。
足够的空闲内存。如果在编译大型源文件时遇到
“ internal compiler error ”等问题，可能是你的内存太少了。如果在虚拟机上编译，请尝试增加内存分配。
如果您打算运行测试脚本，则需要 Perl。大多数类 Unix 系统都包含 Perl。在 Windows 上，您可以使用 ActiveState Perl 等版本。
要从标准源代码分发安装 MySQL，需要使用以下工具之一来解压缩分发文件：
对于.tar.gz压缩
的tar文件：GNUgunzip用于解压发行版和合理的
tar用于解压它。如果您的
tar程序支持该
z选项，它可以解压和解压缩文件。
GNU tar是众所周知的工作。一些操作系统提供的标准
tar无法解压 MySQL 发行版中的长文件名。您应该下载并安装 GNU
tar，或者如果可用，使用 GNU tar 的预安装版本。通常这在 GNU 或自由软件目录中以
gnutar、gtar或
tar的形式提供，例如/usr/sfw/bin或
/usr/local/bin。GNU
tar可从
http://www.gnu.org/software/tar/获得。
对于.zipZip 存档：
WinZip或其他可以读取
.zip文件的工具。
对于.rpmRPM 包：
用于构建发行版
的rpmbuild程序将其解包。
要从开发源代码树安装 MySQL，需要以下附加工具：
获取开发源码需要Git版本控制系统。GitHub 帮助
提供了在不同平台上下载和安装 Git 的说明。
MySQL于2014年9月正式加入GitHub，更多关于MySQL迁移到GitHub的信息可以参考MySQL Release Engineering博客的公告：
MySQL on GitHub
bison 2.1 或更高版本，可从
http://www.gnu.org/software/bison/获得。（不再支持版本 1。）尽可能使用最新版本的
bison；如果您遇到问题，请升级到更高版本，而不是恢复到早期版本。
bison可从
http://www.gnu.org/software/bison/获得。
bison适用于 Windows 的程序可以从
http://gnuwin32.sourceforge.net/packages/bison.htm下载。下载标有“ Complete package, excluding sources ”的包。在 Windows 上， bison的默认位置是C:\Program
Files\GnuWin32目录。由于目录名称中的空格，某些实用程序可能无法找到bison 。此外，如果路径中有空格，Visual Studio 可能会挂起。您可以通过安装到不包含空格的目录（例如C:\GnuWin32).
在 Solaris Express 上，除了bison之外还必须安装m4。m4可从http://www.gnu.org/software/m4/获得。
笔记
如果您必须安装任何程序，请修改您的
PATH环境变量以包含这些程序所在的任何目录。请参阅
第 4.2.9 节，“设置环境变量”。
如果您遇到问题并需要提交错误报告，请使用第 1.6 节“如何报告错误或问题”中的说明。
© Mysql 中文网
