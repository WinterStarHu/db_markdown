# 2.9.5 使用开发源树安装MySQL_MySQL 8.0 参考手册

2.9.5 使用开发源树安装MySQL_MySQL 8.0 参考手册
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
2.9.5 使用开发源树安装MySQL
2.9.5 使用开发源树安装MySQL
本节介绍如何从托管在
GitHub 上的最新开发源代码安装 MySQL 。要从此存储库托管服务获取 MySQL 服务器源代码，您可以设置本地 MySQL Git 存储库。
在GitHub 上，可以在MySQL页面上找到 MySQL Server 和其他 MySQL 项目
。MySQL Server 项目是一个单一的存储库，其中包含多个 MySQL 系列的分支。
MySQL于2014年9月正式加入GitHub，更多关于MySQL迁移到GitHub的信息可以参考MySQL Release Engineering博客的公告：
MySQL on GitHub
从开发源安装的先决条件设置 MySQL Git 存储库
从开发源安装的先决条件
要从开发源树安装 MySQL，您的系统必须满足
第 2.9.2 节“源安装先决条件”中列出的工具要求。
设置 MySQL Git 存储库
要在您的计算机上设置 MySQL Git 存储库：
将 MySQL Git 存储库克隆到您的计算机。以下命令将 MySQL Git 存储库克隆到名为mysql-server. 初始下载可能需要一些时间才能完成，具体取决于您的连接速度。
~$ git clone https://github.com/mysql/mysql-server.git
Cloning into 'mysql-server'...
remote: Counting objects: 1198513, done.
remote: Total 1198513 (delta 0), reused 0 (delta 0), pack-reused 1198513
Receiving objects: 100% (1198513/1198513), 1.01 GiB | 7.44 MiB/s, done.
Resolving deltas: 100% (993200/993200), done.
Checking connectivity... done.
Checking out files: 100% (25510/25510), done.
克隆操作完成后，本地 MySQL Git 存储库的内容将类似于以下内容：
~$ cd mysql-server
~/mysql-server$ ls
client             extra                mysys              storage
cmake              include              packaging          strings
CMakeLists.txt     INSTALL              plugin             support-files
components         libbinlogevents      README             testclients
config.h.cmake     libbinlogstandalone  router             unittest
configure.cmake    libmysql             run_doxygen.cmake  utilities
Docs               libservices          scripts            VERSION
Doxyfile-ignored   LICENSE              share              vio
Doxyfile.in        man                  sql                win
doxygen_resources  mysql-test           sql-common
使用git branch -r命令查看 MySQL 存储库的远程跟踪分支。
~/mysql-server$ git branch -r
origin/5.5
origin/5.6
origin/5.7
origin/8.0
origin/HEAD -> origin/8.0
origin/cluster-7.2
origin/cluster-7.3
origin/cluster-7.4
origin/cluster-7.5
origin/cluster-7.6
要查看在本地存储库中签出的分支，请发出git branch命令。克隆 MySQL Git 存储库时，会自动检出最新的 MySQL GA 分支。星号标识活动分支。
~/mysql-server$ git branch
* 8.0
要签出较早的 MySQL 分支，请运行git checkout命令，并指定分支名称。例如，要检查 MySQL 5.7 分支：
~/mysql-server$ git checkout 5.7
Checking out files: 100% (9600/9600), done.
Branch 5.7 set up to track remote branch 5.7 from origin.
Switched to a new branch '5.7'
要获取在初始设置 MySQL Git 存储库后所做的更改，请切换到要更新的分支并发出git pull命令：
~/mysql-server$ git checkout 8.0
~/mysql-server$ git pull
要检查提交历史，请使用以下git
log选项：
~/mysql-server$ git log
您还可以在 GitHub MySQL
站点上浏览提交历史记录和源代码。
如果您看到有疑问的更改或代码，请在
MySQL Community Slack上提问。有关贡献补丁的信息，请参阅
贡献 MySQL 服务器。
在克隆了 MySQL Git 存储库并签出要构建的分支后，您可以从源代码构建 MySQL Server。第 2.9.4 节“使用标准源代码分发安装 MySQL”中提供了说明，只是您跳过了有关获取和解压缩分发的部分。
在生产机器上从分发源树安装构建时要小心。安装命令可能会覆盖您的实时发布安装。如果您已经安装了 MySQL 并且不想覆盖它，请使用与您的生产服务器所使用的不同的 、 和 选项值
运行
CMake
。有关防止多个服务器相互干扰的其他信息，请参阅
第 5.8 节，“在一台机器上运行多个 MySQL 实例”。
CMAKE_INSTALL_PREFIXMYSQL_TCP_PORTMYSQL_UNIX_ADDR
努力使用您的新安装。例如，尝试让新功能崩溃。首先运行make test。请参阅MySQL 测试套件。
© Mysql 中文网
