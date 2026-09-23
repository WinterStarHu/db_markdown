# 6.2.16 服务器对过期密码的处理_MySQL 8.0 参考手册

6.2.16 服务器对过期密码的处理_MySQL 8.0 参考手册
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
6.2.16 服务器对过期密码的处理
6.2.16 服务器对过期密码的处理
MySQL 提供密码过期功能，使数据库管理员能够要求用户重置密码。密码可以手动过期，也可以根据自动过期策略（请参阅
第 6.2.15 节，“密码管理”）。
该ALTER USER语句启用帐户密码过期。例如：
ALTER USER 'myuser'@'localhost' PASSWORD EXPIRE;
对于使用密码过期帐户的每个连接，服务器要么断开客户端连接，要么将客户端限制为“沙盒模式”，在该模式下，服务器只允许客户端执行重置过期密码所需的操作。服务器采取何种操作取决于客户端和服务器设置，如后所述。
如果服务器断开客户端连接，它会返回一个
ER_MUST_CHANGE_PASSWORD_LOGIN
错误：
$> mysql -u myuser -p
Password: ******
ERROR 1862 (HY000): Your password has expired. To log in you must
change it using a client that supports expired passwords.
如果服务器将客户端限制为沙盒模式，则在客户端会话中允许执行以下操作：
ALTER USER客户端可以使用或
重置账户密码
SET PASSWORD。完成后，服务器恢复会话的正常访问，以及使用该帐户的后续连接。
笔记
虽然可以通过将过期的密码设置为当前值来“重置”该密码，但作为一种好的策略，最好选择一个不同的密码。DBA 可以通过建立适当的密码重用策略来强制禁止重用。请参阅
密码重用政策。
在 MySQL 8.0.27 之前，客户端可以使用该
SET
语句。从 MySQL 8.0.27 开始，不再允许这样做。
对于会话中不允许的任何操作，服务器返回ER_MUST_CHANGE_PASSWORD
错误：
mysql> USE performance_schema;
ERROR 1820 (HY000): You must reset your password using ALTER USER
statement before executing this statement.
mysql> SELECT 1;
ERROR 1820 (HY000): You must reset your password using ALTER USER
statement before executing this statement.
这是
mysql客户端的交互式调用通常发生的情况，因为默认情况下此类调用处于沙盒模式。要恢复正常功能，请选择一个新密码。
对于mysql
客户端的非交互式调用（例如，在批处理模式下），如果密码过期，服务器通常会断开客户端连接。要允许非交互式mysql调用保持连接以便可以更改密码（使用沙盒模式中允许的语句），请将
--connect-expired-password选项添加到mysql命令。
如前所述，服务器是断开密码过期客户端的连接还是将其限制为沙盒模式取决于客户端和服务器设置的组合。以下讨论描述了相关设置以及它们如何交互。
笔记
此讨论仅适用于密码过期的帐户。如果客户端使用未过期的密码进行连接，则服务器会正​​常处理客户端。
在客户端，给定的客户端指示它是否可以处理过期密码的沙箱模式。对于使用 C 客户端库的客户端，有两种方法可以做到这一点：
在连接之前
将MYSQL_OPT_CAN_HANDLE_EXPIRED_PASSWORDS标志
传递
给：mysql_options()bool arg = 1;
mysql_options(mysql,
MYSQL_OPT_CAN_HANDLE_EXPIRED_PASSWORDS,
&arg);
这是在mysql
客户端中
使用的技术，MYSQL_OPT_CAN_HANDLE_EXPIRED_PASSWORDS如果以交互方式调用或使用
--connect-expired-password
选项，则启用该技术。
在连接时
将CLIENT_CAN_HANDLE_EXPIRED_PASSWORDS标志
传递
给：mysql_real_connect()MYSQL mysql;
mysql_init(&mysql);
if (!mysql_real_connect(&mysql,
host, user, password, db,
port, unix_socket,
CLIENT_CAN_HANDLE_EXPIRED_PASSWORDS))
{
... handle error ...
}
其他 MySQL 连接器有自己的约定来指示准备好处理沙盒模式。请参阅您感兴趣的连接器的文档。
在服务器端，如果客户端指示它可以处理过期密码，则服务器会将其置于沙盒模式。
如果客户端未指示它可以处理过期密码（或使用无法指示的旧版本客户端库），则服务器操作取决于
disconnect_on_expired_password
系统变量的值：
如果
disconnect_on_expired_password
启用（默认），服务器将断开与客户端的连接并
ER_MUST_CHANGE_PASSWORD_LOGIN
出错。
如果
disconnect_on_expired_password
禁用，服务器会将客户端置于沙盒模式。
© Mysql 中文网
