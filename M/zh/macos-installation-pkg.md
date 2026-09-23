# 2.4.2 在 macOS 上使用原生包安装 MySQL_MySQL 8.0 参考手册

2.4.2 在 macOS 上使用原生包安装 MySQL_MySQL 8.0 参考手册
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
2.4.2 在 macOS 上使用原生包安装 MySQL
2.4.2 在 macOS 上使用原生包安装 MySQL
该软件包位于磁盘映像 ( .dmg) 文件内，您首先需要通过在 Finder 中双击其图标来装载该文件。然后它应该挂载图像并显示其内容。
笔记
在继续安装之前，请务必使用 MySQL 管理器应用程序（在 macOS 服务器上）、首选项窗格或
命令行上的
mysqladmin shutdown停止所有正在运行的 MySQL 服务器实例。
使用包安装程序安装 MySQL：
下载包含 MySQL 包安装程序
的磁盘映像 ( .dmg) 文件（社区版本可
在此处获得）。双击该文件以装载磁盘映像并查看其内容。
双击磁盘中的 MySQL 安装程序包。它是根据您下载的 MySQL 版本命名的。例如，对于 MySQL 服务器 8.0.31，它可能被命名为
。
mysql-8.0.31-macos-10.13-x86_64.pkg
初始向导介绍屏幕引用要安装的 MySQL 服务器版本。单击
继续以开始安装。
MySQL 社区版显示了相关 GNU 通用公共许可证的副本。单击继续
，然后单击同意继续。
在Installation Type页面中，您可以单击Install以使用所有默认值执行安装向导，单击
Customize以更改要安装的组件（MySQL 服务器、MySQL Test、Preference Pane、Launchd Support——默认情况下启用除 MySQL Test 之外的所有组件） .
笔记
尽管更改安装位置
选项可见，但无法更改安装位置。
图 2.13 MySQL 包安装程序向导：安装类型
图 2.14 MySQL 包安装程序向导：自定义
单击安装以安装 MySQL 服务器。如果升级当前的 MySQL 服务器安装，安装过程到此结束，否则按照向导的附加配置步骤进行新的 MySQL 服务器安装。
成功安装新的 MySQL 服务器后，通过选择密码的默认加密类型完成配置步骤，定义 root 密码，并在启动时启用（或禁用）MySQL 服务器。
MySQL 8.0默认的密码机制是
caching_sha2_password（Strong），这一步可以修改为
mysql_native_password（Legacy）。
图 2.15 MySQL 包安装程序向导：选择密码加密类型
选择旧密码机制会将生成的 launchd 文件更改为设置
--default_authentication_plugin=mysql_native_password
在ProgramArguments. 选择强密码加密不会设置
--default_authentication_plugin，因为使用默认的 MySQL 服务器值，即
caching_sha2_password.
为 root 用户定义一个密码，并在配置步骤完成后切​​换是否启动 MySQL 服务器。
图 2.16 MySQL 包安装程序向导：定义根密码
摘要是最后一步，它引用了成功且完整的 MySQL 服务器安装。
关闭向导。
图 2.17 MySQL 包安装程序向导：摘要
MySQL 服务器现已安装。如果您选择不启动 MySQL，则从命令行使用 launchctl 或使用 MySQL 首选项面板单击“开始”来启动 MySQL。有关其他信息，请参阅第 2.4.3 节“安装和使用 MySQL 启动守护程序”和
第 2.4.4 节“安装和使用 MySQL 首选项面板”。使用 MySQL 首选项面板或 launchd 将 MySQL 配置为在启动时自动启动。
使用包安装程序安装时，文件将安装到/usr/local
与安装版本和平台名称相匹配的目录中。例如，安装程序文件
使用符号链接
将 MySQL 安装
到. 下表显示了此 MySQL 安装目录的布局。
mysql-8.0.31-macos10.15-x86_64.dmg/usr/local/mysql-8.0.31-macos10.15-x86_64/
/usr/local/mysql
笔记
macOS 安装过程不会创建或安装样本my.cnfMySQL 配置文件。
表 2.7 macOS 上的 MySQL 安装布局
目录
目录内容
bin
mysqld服务器、客户端和实用程序
data
日志文件，数据库，
/usr/local/mysql/data/mysqld.local.err
默认错误日志在哪里
docs
帮助文档，例如发行说明和构建信息
include
包含（头）文件
lib
图书馆
man
Unix 手册页
mysql-test
MySQL 测试套件（使用安装程序包 (DMG) 时，在安装过程中默认禁用“MySQL 测试”）
share
杂项支持文件，包括错误消息
dictionary.txt、和重写器 SQL
support-files
支持脚本，例如mysqld_multi.server、
mysql.server和
mysql-log-rotate。
/tmp/mysql.sock
MySQL Unix 套接字的位置
© Mysql 中文网
