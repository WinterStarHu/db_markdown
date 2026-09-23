# 2.4.1 macOS 安装MySQL 一般注意事项_MySQL 8.0 参考手册

2.4.1 macOS 安装MySQL 一般注意事项_MySQL 8.0 参考手册
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
2.4.1 macOS 安装MySQL 一般注意事项1
2.4.2 在 macOS 上使用原生包安装 MySQL1
2.4.3 安装和使用MySQL Launch Daemon1
2.4.4 安装和使用 MySQL 首选项面板1
2.5 在 Linux 上安装 MySQL
2.6 使用坚不可摧的Linux网络（ULN）安装MySQL
2.7 在 Solaris 上安装 MySQL
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
MySQL 8.0 参考手册  / 第 2 章安装和升级 MySQL  / 2.4 在 macOS 上安装 MySQL  /
2.4.1 macOS 安装MySQL 一般注意事项
2.4.1 macOS 安装MySQL 一般注意事项
您应该牢记以下问题和注意事项：
其他 MySQL 安装：安装过程无法通过 Homebrew 等包管理器识别 MySQL 安装。安装和升级过程是针对我们提供的MySQL包。如果存在其他安装，请考虑在执行此安装程序之前停止它们以避免端口冲突。
Homebrew：例如，如果您使用 Homebrew 将 MySQL Server 安装到其默认位置，则 MySQL 安装程序将安装到不同的位置并且不会从 Homebrew 升级版本。在这种情况下，您最终会安装多个 MySQL，默认情况下，它们会尝试使用相同的端口。运行本安装程序前先停止其他MySQL Server实例，如执行brew services stop mysql停止Homebrew的MySQL服务。
Launchd：安装了一个 launchd 守护进程，它可以改变 MySQL 配置选项。如果需要考虑编辑它，请参阅下面的文档以获取更多信息。此外，macOS 10.10 删除了启动项支持以支持 launchd 守护进程。macOS系统偏好设置下的可选 MySQL 偏好设置面板使用 launchd 守护进程。
用户：您可能需要（或想要）创建一个特定的mysql用户来拥有 MySQL 目录和数据。您可以通过
Directory Utility执行此操作，并且该
mysql用户应该已经存在。为了在单用户模式下使用，文件中
_mysql应该已经存在一个条目（注意下划线前缀）
/etc/passwd
数据：因为 MySQL 包安装程序将 MySQL 内容安装到特定于版本和平台的目录中，您可以使用它在版本之间升级和迁移数据库。您需要将data目录从旧版本复制到新版本，或者指定一个替代
datadir值来设置数据目录的位置。默认情况下，MySQL 目录安装在/usr/local/.
别名：您可能希望将别名添加到 shell 的资源文件中，以便更容易地从命令行访问常用程序，例如mysql
和mysqladmin 。bash的语法是：
alias mysql=/usr/local/mysql/bin/mysql
alias mysqladmin=/usr/local/mysql/bin/mysqladmin
对于tcsh，使用：
alias mysql /usr/local/mysql/bin/mysql
alias mysqladmin /usr/local/mysql/bin/mysqladmin
更好的是，添加/usr/local/mysql/bin到您的PATH环境变量中。您可以通过为您的 shell 修改适当的启动文件来做到这一点。有关详细信息，请参阅第 4.2.1 节，“调用 MySQL 程序”。
删除：从以前的安装中复制 MySQL 数据库文件并成功启动新服务器后，您应该考虑删除旧的安装文件以节省磁盘空间。此外，您还应该删除位于
.
/Library/Receipts/mysql-VERSION.pkg
© Mysql 中文网
