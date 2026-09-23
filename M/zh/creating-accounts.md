# 6.2.8 添加账号、分配权限、删除账号_MySQL 8.0 参考手册

6.2.8 添加账号、分配权限、删除账号_MySQL 8.0 参考手册
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
6.2 访问控制和账户管理
6.2.1 账户用户名和密码1
6.2.2 MySQL提供的权限1
6.2.3 授权表1
6.2.4 指定账户名1
6.2.5 指定角色名称1
6.2.6 访问控制，第 1 阶段：连接验证1
6.2.7 访问控制，第 2 阶段：请求验证1
6.2.8 添加账号、分配权限、删除账号1
6.2.9 预留账户1
6.2.10 使用角色1
6.2.11 账户类别1
6.2.12 使用部分撤销的权限限制1
6.2.13 权限变更何时生效1
6.2.14 分配账户密码1
6.2.15 密码管理1
6.2.16 服务器对过期密码的处理1
6.2.17 可插拔认证1
6.2.18 多因素认证1
6.2.19 代理用户1
6.2.20 账户锁定1
6.2.21 设置账号资源限制1
6.2.22 MySQL连接问题排查1
6.2.23 基于 SQL 的账户活动审计1
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
MySQL 8.0 参考手册  / 第 6 章 安全  / 6.2 访问控制和账户管理  /
6.2.8 添加账号、分配权限、删除账号
6.2.8 添加账号、分配权限、删除账号
要管理 MySQL 帐户，请使用专用于该目的的 SQL 语句：
CREATE USER并
DROP USER创建和删除帐户。
GRANT并
REVOKE为帐户分配权限和撤销权限。
SHOW GRANTS显示帐户权限分配。
帐户管理语句导致服务器对基础授权表进行适当的修改，这在第 6.2.3 节，“授权表”中讨论。
笔记
INSERT不鼓励使用、
UPDATE或
等语句直接修改授权表
，DELETE这样做的风险由您自行承担。服务器可以自由地忽略由于此类修改而变得畸形的行。
对于任何修改授权表的操作，服务器都会检查该表是否具有预期的结构，如果没有则产生错误。要将表更新为预期的结构，请执行 MySQL 升级过程。请参阅
第 2.11 节，“升级 MySQL”。
创建帐户的另一种选择是使用 GUI 工具 MySQL Workbench。此外，一些第三方程序提供了 MySQL 帐户管理功能。phpMyAdmin就是这样一个程序。
本节讨论以下主题：
创建帐户和授予权限检查帐户权限和属性撤销账户权限删除帐户
有关此处讨论的语句的更多信息，请参阅第 13.7.1 节，“账户管理语句”。
创建帐户和授予权限
以下示例显示如何使用
mysql客户端程序设置新帐户。这些示例假定 MySQLroot
帐户具有CREATE USER
它授予其他帐户的特权和所有特权。
在命令行中，以 MySQL
root用户身份连接到服务器，并在密码提示符处提供适当的密码：
$> mysql -u root -p
Enter password: (enter root password here)
连接到服务器后，您可以添加新帐户。以下示例使用CREATE USER
和GRANT语句设置四个帐户（在您看到
的地方，替换为适当的密码）：
'password'CREATE USER 'finley'@'localhost'
IDENTIFIED BY 'password';
GRANT ALL
ON *.*
TO 'finley'@'localhost'
WITH GRANT OPTION;
CREATE USER 'finley'@'%.example.com'
IDENTIFIED BY 'password';
GRANT ALL
ON *.*
TO 'finley'@'%.example.com'
WITH GRANT OPTION;
CREATE USER 'admin'@'localhost'
IDENTIFIED BY 'password';
GRANT RELOAD,PROCESS
ON *.*
TO 'admin'@'localhost';
CREATE USER 'dummy'@'localhost';
这些语句创建的帐户具有以下属性：
两个帐户的用户名为finley。两者都是超级用户帐户，具有执行任何操作的完全全局权限。该'finley'@'localhost'
帐户只能在从本地主机连接时使用。该'finley'@'%.example.com'
帐户'%'在主机部分使用通配符，因此可用于从
example.com域中的任何主机进行连接。
'finley'@'localhost'如果 有一个匿名用户帐户，则
该帐户是必需的localhost。如果没有该
帐户，则该匿名用户帐户在从本地主机连接
'finley'@'localhost'时优先
，并被视为匿名用户。这样做的原因是匿名用户帐户具有比帐户更具体的列值
，因此在表排序顺序中更靠前。（有关表排序的信息，请参阅第 6.2.6 节“访问控制，第 1 阶段：连接验证”。）
finleyfinleyHost'finley'@'%'useruser
该'admin'@'localhost'帐户只能用于admin从本地主机连接。它被授予全局
RELOAD和
PROCESS管理权限。这些权限使
admin用户能够执行
mysqladmin reload、mysqladmin refresh和mysqladmin flush-xxx命令，以及mysqladmin processlist。没有授予访问任何数据库的权限。GRANT您可以使用语句
添加此类权限
。
该'dummy'@'localhost'帐户没有密码（不安全，不推荐）。此帐户只能用于从本地主机连接。不授予任何特权。假定您使用
GRANT语句向帐户授予特定权限。
前面的示例在全局级别授予权限。下一个示例创建三个帐户并授予他们较低级别的访问权限；也就是说，针对特定的数据库或数据库中的对象。每个帐户都有一个用户名
custom，但主机名部分不同：
CREATE USER 'custom'@'localhost'
IDENTIFIED BY 'password';
GRANT ALL
ON bankaccount.*
TO 'custom'@'localhost';
CREATE USER 'custom'@'host47.example.com'
IDENTIFIED BY 'password';
GRANT SELECT,INSERT,UPDATE,DELETE,CREATE,DROP
ON expenses.*
TO 'custom'@'host47.example.com';
CREATE USER 'custom'@'%.example.com'
IDENTIFIED BY 'password';
GRANT SELECT,INSERT,UPDATE,DELETE,CREATE,DROP
ON customer.addresses
TO 'custom'@'%.example.com';
这三个帐户可以使用如下：
该'custom'@'localhost'帐户具有访问数据库的所有数据库级权限
bankaccount。该帐户只能用于从本地主机连接到服务器。
该'custom'@'host47.example.com'帐户具有访问数据库的特定数据库级权限
expenses。该帐户只能用于从主机连接到服务器
host47.example.com。
该'custom'@'%.example.com'帐户具有特定的表级权限，可以
从域中的任何主机访问数据库
addresses中的表
。由于在帐户名的主机部分
使用通配符，该帐户可用于从域中的所有计算机连接到服务器。customerexample.com%
检查帐户权限和属性
要查看帐户的权限，请使用
SHOW GRANTS：
mysql> SHOW GRANTS FOR 'admin'@'localhost';
+-----------------------------------------------------+
| Grants for admin@localhost                          |
+-----------------------------------------------------+
| GRANT RELOAD, PROCESS ON *.* TO `admin`@`localhost` |
+-----------------------------------------------------+
要查看帐户的非特权属性，请使用
SHOW CREATE USER：
mysql> SET print_identified_with_as_hex = ON;
mysql> SHOW CREATE USER 'admin'@'localhost'\G
*************************** 1. row ***************************
CREATE USER for admin@localhost: CREATE USER `admin`@`localhost`
IDENTIFIED WITH 'caching_sha2_password'
AS 0x24412430303524301D0E17054E2241362B1419313C3E44326F294133734B30792F436E77764270373039612E32445250786D43594F45354532324B6169794F47457852796E32
REQUIRE NONE PASSWORD EXPIRE DEFAULT ACCOUNT UNLOCK
PASSWORD HISTORY DEFAULT
PASSWORD REUSE INTERVAL DEFAULT
PASSWORD REQUIRE CURRENT DEFAULT
启用
print_identified_with_as_hex
系统变量（从 MySQL 8.0.17 开始可用）会导致
SHOW CREATE USER将包含不可打印字符的哈希值显示为十六进制字符串而不是常规字符串文字。
撤销账户权限
要撤销帐户权限，请使用该
REVOKE语句。权限可以在不同级别撤销，就像它们可以在不同级别授予一样。
撤销全局权限：
REVOKE ALL
ON *.*
FROM 'finley'@'%.example.com';
REVOKE RELOAD
ON *.*
FROM 'admin'@'localhost';
撤销数据库级权限：
REVOKE CREATE,DROP
ON expenses.*
FROM 'custom'@'host47.example.com';
撤销表级权限：
REVOKE INSERT,UPDATE,DELETE
ON customer.addresses
FROM 'custom'@'%.example.com';
要检查权限撤销的效果，请使用
SHOW GRANTS：
mysql> SHOW GRANTS FOR 'admin'@'localhost';
+---------------------------------------------+
| Grants for admin@localhost                  |
+---------------------------------------------+
| GRANT PROCESS ON *.* TO `admin`@`localhost` |
+---------------------------------------------+
删除帐户
要删除帐户，请使用该DROP
USER语句。例如，要删除之前创建的一些帐户：
DROP USER 'finley'@'localhost';
DROP USER 'finley'@'%.example.com';
DROP USER 'admin'@'localhost';
DROP USER 'dummy'@'localhost';
© Mysql 中文网
