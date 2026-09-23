# 2.11.10 Windows 升级MySQL_MySQL 8.0 参考手册

2.11.10 Windows 升级MySQL_MySQL 8.0 参考手册
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
2.11.10 Windows 升级MySQL
2.11.10 Windows 升级MySQL
在 Windows 上升级 MySQL 有两种方法：
使用 MySQL 安装程序
使用 Windows ZIP 存档分发
您选择的方法取决于现有安装的执行方式。在继续之前，请查看
第 2.11 节“升级 MySQL”以获取有关升级 MySQL 的非特定于 Windows 的其他信息。
笔记
无论您选择哪种方法，请务必在执行升级之前备份当前的 MySQL 安装。请参阅
第 7.2 节，“数据库备份方法”。
不支持在非 GA 版本之间升级（或从非 GA 版本升级到 GA 版本）。非 GA 版本中发生了重大的开发更改，您可能会遇到兼容性问题或服务器启动问题。
笔记
MySQL Installer 不支持
社区版本和
商业版本之间的升级。如果您需要这种类型的升级，请使用
ZIP 存档方法执行。
使用 MySQL Installer 升级 MySQL
当当前服务器安装是使用它执行的并且升级是在当前版本系列中时，使用 MySQL Installer 执行升级是最好的方法。MySQL Installer 不支持版本系列之间的升级，例如从 5.7 到 8.0，并且它不提供升级指示器来提示您升级。有关在版本系列之间升级的说明，请参阅
使用 Windows ZIP 分发升级 MySQL。
要使用 MySQL Installer 执行升级：
启动 MySQL 安装程序。
在仪表板中，单击目录以将最新更改下载到目录。仅当仪表板在服务器版本号旁边显示一个箭头时，才能升级已安装的服务器。
单击升级。所有具有较新版本的产品现在都显示在列表中。
笔记
MySQL Installer 取消选择同一版本系列中里程碑版本（Pre-Release）的服务器升级选项。此外，它还会显示警告以指示不支持升级，识别继续操作的风险，并提供手动执行升级的步骤摘要。您可以重新选择服务器升级并自行承担风险。
取消选择除 MySQL 服务器产品以外的所有产品，除非您此时打算升级其他产品，然后单击
Next。
单击执行开始下载。下载完成后，单击
下一步开始升级操作。
升级到 MySQL 8.0.16 及更高版本可能会显示一个选项来跳过系统表的升级检查和过程。有关此选项的更多信息，请参阅
重要的服务器升级条件。
配置服务器。
使用 Windows ZIP 分发升级 MySQL
要使用 Windows ZIP 存档分发执行升级：
从https://mysql.net.cn/downloads/
下载最新的 MySQL Windows ZIP Archive 发行版。
如果服务器正在运行，请将其停止。如果服务器作为服务安装，请在命令提示符下使用以下命令停止该服务：
C:\> SC STOP mysqld_service_name
或者，使用NET STOP
mysqld_service_name 。
如果您没有将 MySQL 服务器作为服务运行，请使用
mysqladmin将其停止。例如，在从 MySQL 5.7 升级到 8.0 之前，使用MySQL 5.7 中的mysqladmin，如下所示：
C:\> "C:\Program Files\MySQL\MySQL Server 5.7\bin\mysqladmin" -u root shutdown
笔记
如果 MySQLroot用户帐户有密码，请使用该
选项调用mysqladmin-p ，并在出现提示时输入密码。
提取 ZIP 存档。您可以覆盖现有的 MySQL 安装（通常位于
C:\mysql），或将其安装到不同的目录，例如C:\mysql8. 建议覆盖现有安装。
重新启动服务器。例如，
如果您将 MySQL 作为服务运行
，则使用SC START
mysqld_service_name 或
NET START
命令，否则直接调用mysqld_service_name mysqld。
在 MySQL 8.0.16 之前，以管理员身份运行mysql_upgrade
以检查您的表，必要时尝试修复它们，并在授权表发生更改时更新它们，以便您可以利用任何新功能。请参阅第 4.4.5 节，“mysql_upgrade — 检查和升级 MySQL 表”。从 MySQL 8.0.16 开始，不需要此步骤，因为服务器执行以前由
mysql_upgrade处理的所有任务。
如果您遇到错误，请参阅
第 2.3.5 节，“Microsoft Windows MySQL 服务器安装故障排除”。
© Mysql 中文网
