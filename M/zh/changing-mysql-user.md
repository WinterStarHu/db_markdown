# 6.1.5 如何以普通用户运行MySQL_MySQL 8.0 参考手册

6.1.5 如何以普通用户运行MySQL_MySQL 8.0 参考手册
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
第 5 章 MySQL 服务器管理
第 6 章 安全
6.1 一般安全问题
6.1.1 安全指南1
6.1.2 保证密码安全1
6.1.3 使 MySQL 免受攻击1
6.1.4 安全相关的 mysqld 选项和变量1
6.1.5 如何以普通用户运行MySQL1
6.1.6 LOAD DATA LOCAL 的安全注意事项1
6.1.7 客户端编程安全指南1
6.2 访问控制和账户管理
6.3 使用加密连接
6.4 安全组件和插件
6.5 MySQL 企业数据屏蔽和去标识化
6.6 MySQL企业加密
6.7 SELinux
6.8 FIPS 支持
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
MySQL 8.0 参考手册  / 第 6 章 安全  / 6.1 一般安全问题  /
6.1.5 如何以普通用户运行MySQL
6.1.5 如何以普通用户运行MySQL
在 Windows 上，您可以使用普通用户帐户将服务器作为 Windows 服务运行。
在 Linux 上，对于使用 MySQL 存储库或 RPM 包执行的安装，MySQL 服务器mysqld应由本地mysql操作系统用户启动。作为 MySQL 存储库的一部分包含的初始化脚本不支持由另一个操作系统用户启动。
在 Unix（或 Linux，用于使用
tar.gz包执行的安装）上，MySQL 服务器
mysqld可以由任何用户启动和运行。root但是，出于安全原因，您应该避免以 Unix 用户身份运行服务器
。要更改
mysqld以作为普通的非特权 Unix 用户运行user_name，您必须执行以下操作：
如果服务器正在运行，请将其停止（使用mysqladmin shutdown）。
更改数据库目录和文件，以便
user_name有权在其中读取和写入文件（您可能需要以 Unix
root用户身份执行此操作）：
$> chown -R user_name /path/to/mysql/datadir
如果不这样做，服务器在运行时将无法访问数据库或表user_name。
如果 MySQL 数据目录中的目录或文件是符号链接，则chown -R可能不会为您遵循符号链接。如果没有，您还必须点击这些链接并更改它们指向的目录和文件。
以用户身份启动服务器user_name。另一种选择是以Unix用户身份启动mysqldroot并使用该
选项。mysqld启动，然后在接受任何连接之前
切换为以 Unix 用户身份运行。--user=user_nameuser_name
要在系统启动时自动以给定用户身份启动服务器，请通过将
user选项添加到
选项文件[mysqld]组
/etc/my.cnf或
my.cnf服务器数据目录中的选项文件来指定用户名。例如：
[mysqld]
user=user_name
如果您的 Unix 机器本身不安全，您应该root在授权表中为 MySQL 帐户分配密码。否则，任何在该机器上拥有登录帐户的用户都可以运行带
选项的mysql--user=root客户端并执行任何操作。（在任何情况下，为 MySQL 帐户分配密码是个好主意，但当服务器主机上存在其他登录帐户时尤其如此。）请参阅
第 2.10.4 节，“保护初始 MySQL 帐户”。
© Mysql 中文网
