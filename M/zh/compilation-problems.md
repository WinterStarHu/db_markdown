# 2.9.8 处理编译MySQL的问题_MySQL 8.0 参考手册

2.9.8 处理编译MySQL的问题_MySQL 8.0 参考手册
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
B.3.1 如何确定导致问题的原因
B.3.2 使用 MySQL 程序时的常见错误
B.3.3 管理相关问题
B.3.4 查询相关问题
B.3.5 优化器相关问题
B.3.6 表定义相关问题
B.3.7 MySQL 中的已知问题
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
2.9.8 处理编译MySQL的问题
2.9.8 处理编译MySQL的问题
许多问题的解决方案涉及重新配置。如果重新配置，请注意以下事项：
如果CMake在之前运行之后运行，它可能会使用在之前调用期间收集的信息。此信息存储在
CMakeCache.txt. 当
CMake启动时，它会查找该文件并读取其内容（如果它存在），前提是信息仍然正确。当您重新配置时，该假设无效。
每次运行CMake时，都必须再次运行
make以重新编译。但是，您可能希望先从以前的构建中删除旧的目标文件，因为它们是使用不同的配置选项编译的。
为防止使用旧的目标文件或配置信息，请在重新运行
CMake之前运行以下命令：
在 Unix 上：
$> make clean
$> rm CMakeCache.txt
在 Windows 上：
$> devenv MySQL.sln /clean
$> del CMakeCache.txt
如果您在源代码树之外构建，请在重新运行CMake之前删除并重新创建您的构建目录。有关在源代码树之外构建的说明，请参阅
如何使用 CMake 构建 MySQL 服务器。
在某些系统上，由于系统包含文件的差异，可能会出现警告。以下列表描述了在编译 MySQL 时发现的最常出现的其他问题：
要定义要使用的 C 和 C++ 编译器，您可以定义
CC和CXX环境变量。例如：
$> CC=gcc
$> CXX=g++
$> export CC CXX
要指定您自己的 C 和 C++ 编译器标志，请使用
CMAKE_C_FLAGS和
CMAKE_CXX_FLAGSCMake 选项。请参阅编译器标志。
要查看可能需要指定的标志，请
使用
和
选项
调用mysql_config 。--cflags--cxxflags
要查看在编译阶段执行了哪些命令，请在使用CMake配置 MySQL 后，运行
make VERBOSE=1而不仅仅是
make。
如果编译失败，请检查该
MYSQL_MAINTAINER_MODE选项是否开启。此模式会导致编译器警告变成错误，因此禁用它可能会使编译继续进行。
如果您的编译失败并出现以下任何错误，您必须将您的
make版本升级到 GNU make：
make: Fatal error in reader: Makefile, line 18:
Badly formed macro assignment
或者：
make: file `Makefile' line 18: Must be a separator (:
或者：
pthread.h: No such file or directory
众所周知，Solaris 和 FreeBSD 的
make程序很麻烦。
已知
GNU make 3.75 可以工作。
该sql_yacc.cc文件是从生成的
sql_yacc.yy。通常情况下，构建过程不需要创建sql_yacc.cc
，因为 MySQL 自带了一个预生成的副本。但是，如果您确实需要重新创建它，则可能会遇到此错误：
"sql_yacc.yy", line xxx fatal: default action causes potential...
这表明您的yacc版本有缺陷。您可能需要安装最新版本的
bison（
yacc的 GNU 版本）并改用它。
早于 1.75
的bison版本可能会报告此错误：sql_yacc.yy:#####: fatal error: maximum table size (32767) exceeded
实际上并没有超过最大表大小；该错误是由旧版本的bison中的错误引起的。
有关获取或更新工具的信息，请参阅第 2.9 节“从源代码安装 MySQL”中的系统要求。
© Mysql 中文网
