# 6.2.21 设置账号资源限制_MySQL 8.0 参考手册

6.2.21 设置账号资源限制_MySQL 8.0 参考手册
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
6.2.21 设置账号资源限制
6.2.21 设置账号资源限制
限制客户端使用 MySQL 服务器资源的一种方法是将全局
max_user_connections系统变量设置为非零值。这限制了任何给定帐户可以同时建立的连接数，但对客户端连接后可以执行的操作没有限制。此外，设置
max_user_connections不启用个人帐户的管理。MySQL 管理员对这两种类型的控制都很感兴趣。
为了解决这些问题，MySQL 允许对个人帐户使用这些服务器资源进行限制：
帐户每小时可以发出的查询数
一个账户每小时可以发布的更新数量
帐户每小时可以连接到服务器的次数
一个账号同时连接到服务器的数量
客户端可以发出的任何语句都计入查询限制。只有修改数据库或表的语句才计入更新限制。
此上下文中的“帐户”对应于mysql.user系统表中的一行。即，根据
适用于连接的表行中的User和
Host值评估连接。user例如，一个帐户
'usera'@'%.example.com'对应于user表中具有User
和Host值usera和
的行%.example.com，以允许
从域中usera的任何主机进行连接
。example.com在这种情况下，服务器将此行中的资源限制共同应用于usera来自域中任何主机的
所有连接，example.com因为所有此类连接都使用相同的帐户。
在 MySQL 5.0 之前，“帐户”是根据用户连接的实际主机进行评估的。可以通过使用该
--old-style-user-limits选项启动服务器来选择这种较旧的记帐方法。在这种情况下，如果usera同时从host1.example.com和
连接host2.example.com，服务器将帐户资源限制分别应用于每个连接。如果
usera再次从 连接
host1.example.com，服务器将对该连接以及来自该主机的现有连接应用限制。
笔记
该--old-style-user-limits
选项在 MySQL 8.0.30 中已弃用，并且可能会在 MySQL 的未来版本中删除。在 MySQL 8.0.30 或更高版本的命令行或选项文件中使用此选项会导致服务器发出警告。
要在帐户创建时为帐户建立资源限制，请使用该CREATE USER
语句。要修改现有帐户的限制，请使用
ALTER USER。提供一个
WITH子句，命名要限制的每个资源。每个限制的默认值为零（无限制）。例如，要创建一个可以访问
customer数据库的新帐户，但只能以有限的方式访问，请发出以下语句：
mysql> CREATE USER 'francis'@'localhost' IDENTIFIED BY 'frank'
->     WITH MAX_QUERIES_PER_HOUR 20
->          MAX_UPDATES_PER_HOUR 10
->          MAX_CONNECTIONS_PER_HOUR 5
->          MAX_USER_CONNECTIONS 2;
限制类型不需要全部在
WITH子句中命名，但那些命名的可以以任何顺序出现。每个每小时限制的值应该是一个表示每小时计数的整数。对于
MAX_USER_CONNECTIONS，限制是一个整数，表示帐户同时连接的最大数量。如果此限制设置为零，则全局
max_user_connections系统变量值确定同时连接的数量。如果max_user_connections也是零，则帐户没有限制。
要修改现有帐户的限制，请使用
ALTER USER语句。以下语句将查询限制更改为francis
100：
mysql> ALTER USER 'francis'@'localhost' WITH MAX_QUERIES_PER_HOUR 100;
该语句仅修改指定的限制值，并使帐户保持不变。
要删除限制，请将其值设置为零。例如，要取消每小时francis
可以连接多少次的限制，请使用以下语句：
mysql> ALTER USER 'francis'@'localhost' WITH MAX_CONNECTIONS_PER_HOUR 0;
如前所述，帐户的同时连接限制由
MAX_USER_CONNECTIONS限制和
max_user_connections系统变量确定。假设全局
max_user_connections值为 10 并且三个帐户具有如下指定的单独资源限制：
ALTER USER 'user1'@'localhost' WITH MAX_USER_CONNECTIONS 0;
ALTER USER 'user2'@'localhost' WITH MAX_USER_CONNECTIONS 5;
ALTER USER 'user3'@'localhost' WITH MAX_USER_CONNECTIONS 20;
user1连接限制为 10（全局
max_user_connections值），因为它的MAX_USER_CONNECTIONS限制为零。user2并且user3分别具有 5 和 20 的连接限制，因为它们具有非零MAX_USER_CONNECTIONS限制。
user服务器在该账户对应
的表行中存储该账户的资源限制
。、和
列存储每小时限制，max_questions列
存储限制。（请参阅
第 6.2.3 节，“授权表”。）
max_updatesmax_connectionsmax_user_connectionsMAX_USER_CONNECTIONS
当任何帐户对其任何资源的使用设置非零限制时，就会发生资源使用计数。
服务器运行时，它会计算每个帐户使用资源的次数。如果一个帐户在最后一个小时内达到其连接数限制，服务器将拒绝该帐户的进一步连接，直到该小时结束。同样，如果帐户达到查询或更新次数的限制，服务器将拒绝进一步的查询或更新，直到时间结束。在所有这些情况下，服务器都会发出相应的错误消息。
资源计数按帐户进行，而不是按客户进行。例如，如果您的帐户的查询限制为 50，则您不能通过与服务器同时建立两个客户端连接来将限制增加到 100。在两个连接上发出的查询一起计算。
可以为所有帐户全局重置当前每小时资源使用计数，也可以为给定帐户单独重置：
要将所有帐户的当前计数重置为零，请发出
FLUSH USER_RESOURCES声明。计数也可以通过重新加载授权表来重置（例如，使用FLUSH
PRIVILEGES语句或mysqladmin reload命令）。
通过再次设置其任何限制，可以将单个帐户的计数重置为零。指定一个等于当前分配给帐户的值的限制值。
每小时计数器重置不会影响
MAX_USER_CONNECTIONS限制。
服务器启动时，所有计数都从零开始。计数不会通过服务器重新启动进行。
对于限制，如果帐户当前已打开允许的最大连接数，则可能会出现边缘情况：如果服务器未完全处理断开连接，则MAX_USER_CONNECTIONS断开连接后快速连接可能会导致错误（ER_TOO_MANY_USER_CONNECTIONS或
）ER_USER_LIMIT_REACHED连接发生的时间。当服务器完成断开连接处理时，将再次允许另一个连接。
© Mysql 中文网
