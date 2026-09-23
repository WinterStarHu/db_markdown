# 2.11.12 升级故障处理_MySQL 8.0 参考手册

2.11.12 升级故障处理_MySQL 8.0 参考手册
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
2.10 安装后设置和测试
2.11 升级MySQL
2.11.1 开始之前1
2.11.2 升级路径1
2.11.3 MySQL升级过程升级了什么1
2.11.4 MySQL 8.0 的变化1
2.11.5 准备升级安装1
2.11.6 在 Unix/Linux 上升级 MySQL 二进制或基于包的安装1
2.11.7 使用 MySQL Yum 仓库升级 MySQL1
2.11.8 使用MySQL APT Repository升级MySQL1
2.11.9 使用 MySQL SLES 存储库升级 MySQL1
2.11.10 Windows 升级MySQL1
2.11.11 升级MySQL的Docker安装1
2.11.12 升级故障处理1
2.11.13 重建或修复表或索引1
2.11.14 复制MySQL数据库到另一台机器1
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
MySQL 8.0 参考手册  / 第 2 章安装和升级 MySQL  / 2.11 升级MySQL  /
2.11.12 升级故障处理
2.11.12 升级故障处理
.frm表文件和
数据字典
之间的 MySQL 5.7 实例模式不匹配InnoDB可能导致升级到 MySQL 8.0 失败。这种不匹配可能是由于.frm文件损坏造成的。要解决此问题，请转储并还原受影响的表，然后再尝试升级。
如果出现问题，例如新的
mysqld服务器没有启动，请确认您没有my.cnf以前安装的旧文件。您可以使用
--print-defaults选项（例如mysqld --print-defaults）进行检查。如果此命令显示程序名称以外的任何内容，则您有一个my.cnf影响服务器或客户端操作的活动文件。
如果在升级后，您在编译客户端程序时遇到问题，例如Commands out of
sync或意外的核心转储，您可能在编译程序时使用了旧的头文件或库文件。在这种情况下，请检查
mysql.h文件和
libmysqlclient.a库的日期以验证它们是否来自新的 MySQL 发行版。如果没有，请使用新的头文件和库重新编译您的程序。libmysqlclient.so.20如果库的主要版本号已更改（例如，从到
libmysqlclient.so.21）
，则针对共享客户端库编译的程序也可能需要重新编译
。
如果您创建了一个具有给定名称的可加载函数并将 MySQL 升级到一个实现了具有相同名称的新内置函数的版本，则该可加载函数将变得不可访问。要更正此问题，请使用DROP
FUNCTION删除可加载函数，然后使用
CREATE FUNCTION重新创建具有不同的非冲突名称的可加载函数。如果新版本的 MySQL 实现了一个与现有存储函数同名的内置函数，情况也是如此。有关描述服务器如何解释对不同类型函数的引用的规则，
请参见第 9.2.5 节，“函数名称解析和解析” 。
如果升级到 MySQL 8.0 由于第 2.11.5 节“准备升级安装”中列出的任何问题而失败，服务器将恢复对数据目录的所有更改。在这种情况下，删除所有重做日志文件并在现有数据目录上重新启动 MySQL 5.7 服务器以解决错误。默认情况下，重做日志文件 ( ib_logfile*) 驻留在 MySQL 数据目录中。修复错误后，在
innodb_fast_shutdown=0再次尝试升级之前执行缓慢关闭（通过设置）。
© Mysql 中文网
