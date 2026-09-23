# 2.10.1 初始化数据目录_MySQL 8.0 参考手册

2.10.1 初始化数据目录_MySQL 8.0 参考手册
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
2.3.1 MySQL 在Microsoft Windows 上的安装布局1
2.3.2 选择安装包1
2.3.3 Windows 版 MySQL 安装程序1
2.3.4 使用 noinstall ZIP 存档在 Microsoft Windows 上安装 MySQL1
2.3.5 Microsoft Windows MySQL 服务器安装故障排除1
2.3.6 Windows 安装后程序1
2.10.1 初始化数据目录
2.10.2 启动服务器
2.10.3 测试服务器
2.10.4 保护初始 MySQL 帐户
2.10.5 自动启动和停止MySQL
2.3.7 Windows 平台限制1
2.4 在 macOS 上安装 MySQL
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
MySQL 8.0 参考手册  / 第 2 章安装和升级 MySQL  / 2.3 在 Microsoft Windows 上安装 MySQL  / 2.3.6 Windows 安装后程序  /
2.10.1 初始化数据目录
2.10.1 初始化数据目录
MySQL安装完成后，必须初始化data目录，包括mysql系统schema中的表：
对于某些 MySQL 安装方法，数据目录初始化是自动的，如
第 2.10 节“安装后设置和测试”中所述。
对于其他安装方法，您必须手动初始化数据目录。这些包括在 Unix 和类 Unix 系统上从通用二进制和源代码分发安装，以及在 Windows 上从 ZIP 存档包安装。
本节介绍如何为数据目录初始化不是自动的MySQL 安装方法手动初始化数据目录。有关启用测试服务器是否可访问和正常工作的一些建议命令，请参阅第 2.10.3 节，“测试服务器”。
笔记
在 MySQL 8.0 中，默认的认证插件由 改为
mysql_native_password，
caching_sha2_password默认
'root'@'localhost'使用管理账户caching_sha2_password。如果您希望该root帐户使用以前的默认身份验证插件 ( mysql_native_password)，请参阅
caching_sha2_password 和根管理帐户。
数据目录初始化概述数据目录初始化过程数据目录初始化期间的服务器操作初始化后 root 密码分配
数据目录初始化概述
在此处显示的示例中，服务器旨在在mysql登录帐户的用户 ID 下运行。如果该帐户不存在，请创建该帐户（请参阅
创建 mysql 用户和组），或者替换您计划用于运行服务器的不同现有登录帐户的名称。
将位置更改为 MySQL 安装的顶级目录，这通常是
/usr/local/mysql（根据需要调整系统的路径名）：
cd /usr/local/mysql
在此目录中，您可以找到多个文件和子目录，包括bin
包含服务器以及客户端和实用程序的子目录。
secure_file_priv系统变量限制对特定目录的导入和导出操作
。创建一个目录，其位置可以指定为该变量的值：
mkdir mysql-files
将目录用户和组所有权授予
mysql用户和mysql
组，并适当设置目录权限：
chown mysql:mysql mysql-files
chmod 750 mysql-files
使用服务器初始化数据目录，包括mysql包含初始 MySQL 授权表的模式，这些授权表确定如何允许用户连接到服务器。例如：
bin/mysqld --initialize --user=mysql
有关该命令的重要信息，尤其是有关您可能使用的命令选项的信息，请参阅
数据目录初始化过程。有关服务器如何执行初始化的详细信息，请参阅
数据目录初始化期间的服务器操作。
通常，数据目录初始化只需要在您第一次安装 MySQL 后完成。（对于现有安装的升级，请执行升级过程；请参阅
第 2.11 节，“升级 MySQL”。）但是，初始化数据目录的命令不会覆盖任何现有的mysql模式表，因此在任何情况下运行都是安全的.
如果要部署自动支持安全连接的服务器，请使用
mysql_ssl_rsa_setup实用程序创建默认 SSL 和 RSA 文件：
bin/mysql_ssl_rsa_setup
有关详细信息，请参阅
第 4.4.3 节，“mysql_ssl_rsa_setup — 创建 SSL/RSA 文件”。
在没有任何选项文件的情况下，服务器以其默认设置启动。（请参阅
第 5.1.2 节，“服务器配置默认值”。）要明确指定 MySQL 服务器在启动时应使用的选项，请将它们放在一个选项文件中，例如
/etc/my.cnf或
/etc/mysql/my.cnf. （参见
第 4.2.2.2 节，“使用选项文件”。）例如，您可以使用选项文件来设置
secure_file_priv系统变量。
要安排 MySQL 在系统启动时无需手动干预即可启动，请参阅第 2.10.5 节，“自动启动和停止 MySQL”。
数据目录初始化在模式中创建时区表mysql但不填充它们。为此，请使用
第 5.1.15 节，“MySQL 服务器时区支持”中的说明。
数据目录初始化过程
将位置更改为 MySQL 安装的顶级目录，这通常是
/usr/local/mysql（根据需要调整系统的路径名）：
cd /usr/local/mysql
要初始化数据目录，
请使用
或
选项调用mysqld，具体取决于您是希望服务器为
帐户生成随机初始密码，还是创建没有密码的帐户：
--initialize--initialize-insecure'root'@'localhost'
用于--initialize“
默认安全”安装（即包括生成随机初始
root密码）。在这种情况下，密码被标记为已过期，您必须选择一个新密码。
使用--initialize-insecure，不会root生成密码。这是不安全的；假设您打算在将服务器投入生产使用之前及时为帐户分配密码。
有关分配新
'root'@'localhost'密码的说明，请参阅
初始化后 root 密码分配。
笔记
服务器将任何消息（包括任何初始密码）写入其标准错误输出。这可能会被重定向到错误日志，所以如果您没有在屏幕上看到消息，请查看那里。有关错误日志的信息，包括它所在的位置，请参阅第 5.4.2 节，“错误日志”。
在 Windows 上，使用该--console
选项将消息定向到控制台。
在 Unix 和类 Unix 系统上，数据库目录和文件由
mysql登录帐户拥有很重要，这样当您稍后运行服务器时，服务器才能对它们进行读写访问。为确保这一点，从系统
帐户
启动mysqld并包含如下所示的选项：
root--userbin/mysqld --initialize --user=mysql
bin/mysqld --initialize-insecure --user=mysql
或者，以 身份登录时执行mysqldmysql，在这种情况下，您可以省略
--user命令中的选项。
在 Windows 上，使用以下命令之一：
bin\mysqld --initialize --console
bin\mysqld --initialize-insecure --console
笔记
如果缺少所需的系统库，数据目录初始化可能会失败。例如，您可能会看到如下错误：
bin/mysqld: error while loading shared libraries:
libnuma.so.1: cannot open shared object file:
No such file or directory
如果发生这种情况，您必须手动或使用系统的包管理器安装缺少的库。然后重试数据目录初始化命令。
可能需要指定其他选项，例如
--basediror
--datadir如果
mysqld无法识别安装目录或数据目录的正确位置。例如（在一行中输入命令）：
bin/mysqld --initialize --user=mysql
--basedir=/opt/mysql/mysql
--datadir=/opt/mysql/mysql/data
或者，将相关的选项设置放在一个选项文件中，并将该文件的名称传递给
mysqld。对于 Unix 和类 Unix 系统，假设选项文件名为
/opt/mysql/mysql/etc/my.cnf. 将这些行放在文件中：
[mysqld]
basedir=/opt/mysql/mysql
datadir=/opt/mysql/mysql/data
然后按如下方式调用mysqld（在带有选项的单行中输入命令
--defaults-file）：
bin/mysqld --defaults-file=/opt/mysql/mysql/etc/my.cnf
--initialize --user=mysql
在 Windows 上，假设C:\my.ini包含这些行：
[mysqld]
basedir=C:\\Program Files\\MySQL\\MySQL Server 8.0
datadir=D:\\MySQLdata
然后按如下方式调用mysqld（在带有选项的单行中输入命令
--defaults-file）：
bin\mysqld --defaults-file=C:\my.ini
--initialize --console
数据目录初始化期间的服务器操作
笔记
服务器执行的数据目录初始化序列不能替代
mysql_secure_installation和
mysql_ssl_rsa_setup执行的操作。请参阅
第 4.4.2 节，“mysql_secure_installation - 提高 MySQL 安装安全性”和
第 4.4.3 节，“mysql_ssl_rsa_setup - 创建 SSL/RSA 文件”。
当使用
--initializeor
--initialize-insecure选项调用时，
mysqld在数据目录初始化序列中执行以下操作：
服务器检查数据目录是否存在，如下所示：
如果不存在数据目录，则服务器创建它。
如果数据目录存在但不为空（即它包含文件或子目录），则服务器会在产生错误消息后退出：
[ERROR] --initialize specified but the data directory exists. Aborting.
在这种情况下，删除或重命名数据目录并重试。
如果每个条目的名称都以句点 ( ) 开头，则允许现有数据目录为非空.。
在数据目录中，服务器创建
mysql系统模式及其表，包括数据字典表、授权表、时区表和服务器端帮助表。参见
第 5.3 节，“mysql 系统模式”。
服务器初始化管理表所需的
系统表空间和相关数据结构InnoDB。
笔记
在mysqld设置
InnoDB
系统表空间后，表空间特性的某些更改需要设置一个全新的
实例。符合条件的更改包括系统表空间中第一个文件的文件名和撤消日志的数量。如果不想使用默认值，请确保
在运行
mysqld之前innodb_data_file_path和
配置参数的设置在 MySQL配置文件innodb_log_file_size
中就位
. 还要确保根据需要指定影响InnoDB文件创建和位置的其他参数，例如
innodb_data_home_dir和
innodb_log_group_home_dir.
如果这些选项在您的配置文件中但该文件不在 MySQL 默认读取的位置，
请在运行mysqld--defaults-extra-file
时使用该选项指定文件位置。
服务器创建'root'@'localhost'
超级用户帐户和其他保留帐户（请参阅
第 6.2.9 节，“保留帐户”）。一些保留帐户被锁定，不能被客户使用，但
'root'@'localhost'用于管理用途，您应该为其分配一个密码。
服务器对
'root'@'localhost'帐户密码的操作取决于您如何调用它：
使用--initializebut not
--initialize-insecure，服务器生成一个随机密码，将其标记为已过期，并写入一条显示密码的消息：
[Warning] A temporary password is generated for root@localhost:
iTag*AfrH5ej
使用
--initialize-insecure, （使用或不使用
--initialize因为
--initialize-insecure
暗示--initialize），服务器不会生成密码或将其标记为已过期，并写入一条警告消息：
[Warning] root@localhost is created with an empty password ! Please
consider switching off the --initialize-insecure option.
有关分配新
'root'@'localhost'密码的说明，请参阅
初始化后 root 密码分配。
服务器填充用于该HELP语句的服务器端帮助表（请参阅
第 13.8.3 节，“帮助语句”）。服务器不填充时区表。要手动执行此操作，请参阅
第 5.1.15 节，“MySQL 服务器时区支持”。
如果init_file给定系统变量来命名 SQL 语句文件，则服务器将执行文件中的语句。此选项使您能够执行自定义引导序列。
当服务器在引导程序模式下运行时，一些功能不可用，限制了文件中允许的语句。这些包括与帐户管理（例如CREATE
USER或GRANT）、复制和全局事务标识符相关的语句。
服务器退出。
初始化后 root 密码分配
通过使用--initialize或
--initialize-insecure启动服务器来初始化数据目录后，正常启动服务器（即，没有这些选项中的任何一个）并为'root'@'localhost'帐户分配一个新密码：
启动服务器。有关说明，请参阅
第 2.10.2 节 “启动服务器”。
连接到服务器：
如果您使用--initialize
但未
--initialize-insecure初始化数据目录，请连接到服务器
root：
mysql -u root -p
然后，在出现密码提示时，输入服务器在初始化过程中生成的随机密码：
Enter password: (enter the random root password here)
如果您不知道此密码，请查看服务器错误日志。
如果您用于
初始化数据目录，则无需密码即可
--initialize-insecure连接到服务器
：rootmysql -u root --skip-password
连接后，使用ALTER
USER语句分配新
root密码：
ALTER USER 'root'@'localhost' IDENTIFIED BY 'root-password';
另见第 2.10.4 节，“保护初始 MySQL 帐户”。
笔记
尝试连接到主机127.0.0.1
通常会解析为该localhost帐户。但是，如果服务器在
skip_name_resolve启用的情况下运行，则会失败。如果您打算这样做，请确保存在可以接受连接的帐户。例如，为了能够
root使用
--host=127.0.0.1或
进行连接--host=::1，请创建以下帐户：
CREATE USER 'root'@'127.0.0.1' IDENTIFIED BY 'root-password';
CREATE USER 'root'@'::1' IDENTIFIED BY 'root-password';
可以将这些语句放在一个文件中以使用init_file
系统变量执行，如
数据目录初始化期间的服务器操作中所述。
© Mysql 中文网
