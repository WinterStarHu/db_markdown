# 4.3.3 mysql.server——MySQL服务器启动脚本_MySQL 8.0 参考手册

4.3.3 mysql.server——MySQL服务器启动脚本_MySQL 8.0 参考手册
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
第 3 章教程
第 4 章 MySQL 程序
4.1 MySQL程序概述
4.2 使用 MySQL 程序
4.3 服务器和服务器启动程序
4.3.1 mysqld——MySQL 服务器1
4.3.2 mysqld_safe — MySQL 服务器启动脚本1
4.3.3 mysql.server——MySQL服务器启动脚本1
4.3.4 mysqld_multi — 管理多个 MySQL 服务器1
4.4 安装相关程序
4.5 客户端程序
4.6 管理和实用程序
4.7 程序开发实用程序
4.8 杂项程序
4.9 环境变量
4.10 MySQL 中的 Unix 信号处理
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
MySQL 8.0 参考手册  / 第 4 章 MySQL 程序  / 4.3 服务器和服务器启动程序  /
4.3.3 mysql.server——MySQL服务器启动脚本
4.3.3 mysql.server——MySQL服务器启动脚本
Unix 和类 Unix 系统上的 MySQL 发行版包含一个名为mysql.server的脚本，它使用mysqld_safe启动 MySQL 服务器。它可以用于 Linux 和 Solaris 等使用 System V 风格的运行目录来启动和停止系统服务的系统。MySQL 的 macOS 启动项也使用它。
mysql.server是在 MySQL 源代码树中使用的脚本名称。安装的名称可能不同（例如， mysqld或
mysql）。在下面的讨论中，根据您的系统适当
调整名称mysql.server 。
笔记
对于某些 Linux 平台，从 RPM 或 Debian 软件包安装 MySQL 包括用于管理 MySQL 服务器启动和关闭的 systemd 支持。在这些平台上，
没有安装mysql.server和
mysqld_safe，因为它们是不必要的。有关详细信息，请参阅
第 2.5.9 节，“使用 systemd 管理 MySQL 服务器”。
要使用mysql.server脚本
手动启动或停止服务器，
请使用start或
stop参数
从命令行调用它：mysql.server start
mysql.server stop
mysql.server将位置更改为 MySQL 安装目录，然后调用
mysqld_safe。要以某个特定用户身份运行服务器，请将适当的user选项添加到[mysqld]全局
/etc/my.cnf选项文件的组中，如本节后面所示。（如果您在非标准位置安装了 MySQL 的二进制分发版，则可能必须编辑
mysql.server。修改它以在运行
mysqld_safe之前将位置更改为正确的目录。如果这样做，您修改后的mysql版本。服务器以后升级MySQL可能会被覆盖；复制您可以重新安装的编辑版本。）
mysql.server stop通过向服务器发送信号来停止服务器。您还可以通过执行mysqladmin shutdown手动停止服务器。
要在您的服务器上自动启动和停止 MySQL，您必须将启动和停止命令添加到
/etc/rc*文件中的适当位置：
如果您使用 Linux 服务器 RPM 包 ( ) 或本机 Linux 包安装，则
mysql.server脚本可能安装在名称为
或的目录中。有关 Linux RPM 包的更多信息，
请参阅第 2.5.4 节“使用来自 Oracle 的 RPM 包在 Linux 上安装 MySQL” 。MySQL-server-VERSION.rpm/etc/init.dmysqldmysql
如果您从源代码分发或使用不会自动安装
mysql.server的二进制分发格式安装 MySQL ，您可以手动安装脚本。它可以在
support-filesMySQL 安装目录下的目录或 MySQL 源代码树中找到。将脚本复制到/etc/init.d名为mysql的目录并使其可执行：
cp mysql.server /etc/init.d/mysql
chmod +x /etc/init.d/mysql
安装脚本后，激活它以在系统启动时运行所需的命令取决于您的操作系统。在 Linux 上，您可以使用chkconfig：
chkconfig --add mysql
在某些 Linux 系统上，以下命令似乎也是完全启用mysql
脚本所必需的：
chkconfig --level 345 mysql on
在 FreeBSD 上，启动脚本通常应该放在
/usr/local/etc/rc.d/. 安装
mysql.server脚本
/usr/local/etc/rc.d/mysql.server.sh以启用自动启动。rc(8)
手册页指出，只有当它们的基本名称与
*.shshell 文件名模式匹配时，才会执行此目录中的脚本。目录中存在的任何其他文件或目录都将被静默忽略。
作为上述设置的替代方案，某些操作系统还使用/etc/rc.local或
/etc/init.d/boot.local在启动时启动其他服务。要使用此方法启动 MySQL，请将如下命令附加到相应的启动文件：
/bin/sh -c 'cd /usr/local/mysql; ./bin/mysqld_safe --user=mysql &'
对于其他系统，请查阅您的操作系统文档以了解如何安装启动脚本。
mysql.server[mysql.server]从选项文件的和
[mysqld]部分读取选项
为了向后兼容，它还读取
[mysql_server]部分，但为了保持最新，您应该将这些部分重命名为
[mysql.server].
您可以在全局文件中为mysql.server
添加选项。/etc/my.cnf一个典型的
my.cnf文件可能如下所示：
[mysqld]
datadir=/usr/local/mysql/var
socket=/var/tmp/mysql.sock
port=3306
user=mysql
[mysql.server]
basedir=/usr/local/mysqlmysql.server脚本支持下表中显示的选项
。如果指定，它们
必须放在选项文件中，而不是命令行中。mysql.server仅支持
start和stop作为命令行参数。
表 4.7 mysql.server 选项-文件选项
选项名称
描述
类型
basedir
MySQL安装目录路径
目录名称
datadir
MySQL 数据目录的路径
目录名称
pid-file
服务器应在其中写入其进程 ID 的文件
文件名
service-startup-timeout
等待服务器启动多长时间
整数
basedir=dir_name
MySQL 安装目录的路径。
datadir=dir_name
MySQL 数据目录的路径。
pid-file=file_name
服务器应在其中写入其进程 ID 的文件的路径名。服务器在数据目录中创建文件，除非给出绝对路径名来指定不同的目录。
如果未给出此选项，则mysql.server
使用默认值
host_name.pid。传递给mysqld_safe的 PID 文件值
覆盖
[mysqld_safe]选项文件组中指定的任何值。因为
mysql.server读取
[mysqld]选项文件组而不是
[mysqld_safe]组，您可以确保
mysqld_safe在从mysql.server调用时获得与手动调用时相同的值，方法是在和
组
中放置相同的pid-file
设置。[mysqld_safe][mysqld]
service-startup-timeout=seconds
等待确认服务器启动的秒数。如果服务器没有在这段时间内启动，
mysql.server会出错退出。默认值为 900。值为 0 表示根本不等待启动。负值意味着永远等待（没有超时）。
© Mysql 中文网
