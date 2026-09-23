# 6.2.23 基于 SQL 的账户活动审计_MySQL 8.0 参考手册

6.2.23 基于 SQL 的账户活动审计_MySQL 8.0 参考手册
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
6.2.23 基于 SQL 的账户活动审计
6.2.23 基于 SQL 的账户活动审计
应用程序可以使用以下准则来执行将数据库活动与 MySQL 帐户相关联的基于 SQL 的审计。
MySQL 帐户对应于
mysql.user系统表中的行。当客户端成功连接时，服务器会根据此表中的特定行对客户端进行身份验证。该行中的User和
Host列值唯一标识账户，对应
账户名在SQL语句中的书写格式。
'user_name'@'host_name'
用于对客户端进行身份验证的帐户决定了客户端具有哪些权限。通常，
CURRENT_USER()可以调用该函数来确定这是客户端用户的哪个帐户。它的值由
帐户表行
的User和
Host列构成。user
但是，在某些情况下，该
CURRENT_USER()值不对应于客户端用户，而是对应于不同的帐户。这发生在权限检查不基于客户端帐户的上下文中：
SQL SECURITY DEFINER用特性
定义的存储例程（过程和函数）
SQL SECURITY DEFINER
用特性
定义的视图
触发器和事件
在那些上下文中，特权检查是针对
DEFINER帐户完成的，并且
CURRENT_USER()是指该帐户，而不是调用存储例程或视图或导致触发器激活的客户端的帐户。要确定调用用户，您可以调用该
USER()函数，该函数返回一个值，该值指示客户端提供的实际用户名和客户端连接的主机。但是，此值不一定直接对应于
user表中的帐户，因为该
USER()值从不包含通配符，而帐户值（由 返回
CURRENT_USER()）可能包含用户名和主机名通配符。
例如，一个空白的用户名匹配任何用户，因此一个帐户
''@'localhost'允许客户端以匿名用户的身份从本地主机以任何用户名连接。在这种情况下，如果客户端user1从本地主机连接，USER()并
CURRENT_USER()返回不同的值：
mysql> SELECT USER(), CURRENT_USER();
+-----------------+----------------+
| USER()          | CURRENT_USER() |
+-----------------+----------------+
| user1@localhost | @localhost     |
+-----------------+----------------+
帐户的主机名部分也可以包含通配符。如果主机名包含'%'or
'_'模式字符或使用网络掩码表示法，则该帐户可用于从多个主机连接的客户端，并且该CURRENT_USER()值不指示是哪一个。例如，该帐户
'user2'@'%.example.com'可用于
从域中user2的任何主机进行连接
。example.com如果user2
连接自remote.example.com,
USER()并
CURRENT_USER()返回不同的值：
mysql> SELECT USER(), CURRENT_USER();
+--------------------------+---------------------+
| USER()                   | CURRENT_USER()      |
+--------------------------+---------------------+
| user2@remote.example.com | user2@%.example.com |
+--------------------------+---------------------+
如果应用程序必须调用
USER()用户审计（例如，如果它从触发器内部进行审计）但也必须能够将USER()
值与user表中的帐户相关联，则有必要避免在
UserorHost列中包含通配符的帐户。具体来说，不允许User为空（这会创建一个匿名用户帐户），并且不允许在Host
值中使用模式字符或网络掩码符号。所有帐户都必须具有非空User
值和文字Host值。
对于前面的示例，
应该将''@'localhost'和
'user2'@'%.example.com'accounts 更改为不使用通配符：
RENAME USER ''@'localhost' TO 'user1'@'localhost';
RENAME USER 'user2'@'%.example.com' TO 'user2'@'remote.example.com';
如果user2必须能够从example.com域中的多个主机进行连接，则每个主机都应该有一个单独的帐户。
要从
CURRENT_USER()or
USER()值中提取用户名或主机名部分，请使用以下
SUBSTRING_INDEX()函数：
mysql> SELECT SUBSTRING_INDEX(CURRENT_USER(),'@',1);
+---------------------------------------+
| SUBSTRING_INDEX(CURRENT_USER(),'@',1) |
+---------------------------------------+
| user1                                 |
+---------------------------------------+
mysql> SELECT SUBSTRING_INDEX(CURRENT_USER(),'@',-1);
+----------------------------------------+
| SUBSTRING_INDEX(CURRENT_USER(),'@',-1) |
+----------------------------------------+
| localhost                              |
+----------------------------------------+
© Mysql 中文网
