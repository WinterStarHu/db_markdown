# 2.7 在 Solaris 上安装 MySQL_MySQL 8.0 参考手册

2.7 在 Solaris 上安装 MySQL_MySQL 8.0 参考手册
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
2.7.1 使用 Solaris PKG 在 Solaris 上安装 MySQL1
2.8 在 FreeBSD 上安装 MySQL
2.9 从源码安装MySQL
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
MySQL 8.0 参考手册  / 第 2 章安装和升级 MySQL  /
2.7 在 Solaris 上安装 MySQL
2.7 在 Solaris 上安装 MySQL
2.7.1 使用 Solaris PKG 在 Solaris 上安装 MySQL
笔记
MySQL 8.0 支持 Solaris 11.4 及更高版本
Solaris 上的 MySQL 有多种不同的格式。
有关使用本机 Solaris PKG 格式安装的信息，请参阅第 2.7.1 节，“使用 Solaris PKG 在 Solaris 上安装 MySQL”。
要使用标准tar二进制安装，请使用第 2.2 节“使用通用二进制文件在 Unix/Linux 上安装 MySQL”中提供的说明。查看本节末尾的说明和提示，了解您在安装之前或之后可能需要的 Solaris 特定说明。
笔记
MySQL 5.7 依赖于 Oracle Developer Studio Runtime Libraries；但这不适用于 MySQL 8.0。
要以 tarball 或 PKG 格式获取适用于 Solaris 的二进制 MySQL 发行版，
请访问https://mysql.net.cn/downloads/mysql/8.0.html。
在 Solaris 上安装和使用 MySQL 时需要注意的其他注意事项：
如果要将 MySQL 与mysql用户和组一起使用，请使用groupadd和
useradd命令：
groupadd mysql
useradd -g mysql -s /bin/false mysql
如果在 Solaris 上使用二进制 tarball 分发安装 MySQL，因为 Solaris tar无法处理长文件名，请使用 GNU tar
( gtar ) 解压分发。如果您的系统上没有 GNU tar，请使用以下命令安装它：
pkg install archiver/gnu-tar您应该使用该选项
挂载您打算在其上存储
InnoDB文件的
任何文件系统。forcedirectio（默认情况下，不使用此选项进行安装。）如果不这样做，则InnoDB
在该平台上使用存储引擎时会导致性能显着下降。
如果您希望 MySQL 自动启动，您可以复制
support-files/mysql.server并
/etc/init.d创建一个指向它的符号链接，名为/etc/rc3.d/S99mysql.server.
如果太多进程尝试快速连接到
mysqld，您应该会在 MySQL 日志中看到此错误：
Error in accept: Protocol error
您可以尝试使用该
--back_log=50选项启动服务器作为解决方法。
要在 Solaris 上配置核心文件的生成，您应该使用coreadm命令。由于在应用程序上生成核心的安全隐患
setuid()，默认情况下，Solaris 不支持setuid()
程序上的核心文件。但是，您可以使用coreadm修改此行为
。如果
setuid()为当前用户启用核心文件，它们将使用模式 600 生成并归超级用户所有。
© Mysql 中文网
