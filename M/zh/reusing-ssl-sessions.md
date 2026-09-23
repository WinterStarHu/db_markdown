# 6.3.5 重用 SSL 会话_MySQL 8.0 参考手册

6.3.5 重用 SSL 会话_MySQL 8.0 参考手册
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
6.3 使用加密连接
6.3.1 配置 MySQL 使用加密连接1
6.3.2 加密连接 TLS 协议和密码1
6.3.3 创建 SSL 和 RSA 证书和密钥1
6.3.4 使用 SSH 从 Windows 远程连接到 MySQL1
6.3.5 重用 SSL 会话1
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
MySQL 8.0 参考手册  / 第 6 章 安全  / 6.3 使用加密连接  /
6.3.5 重用 SSL 会话
6.3.5 重用 SSL 会话
从 MySQL 8.0.29 开始，MySQL 客户端程序可以选择恢复先前的 SSL 会话，前提是服务器在其运行时缓存中有该会话。本节描述有利于 SSL 会话重用的条件、用于管理和监视会话缓存的服务器变量，以及用于存储和重用会话数据的客户端命令行选项。
用于 SSL 会话重用的服务器端运行时配置和监控SSL 会话重用的客户端配置
每个完整的 TLS 交换在计算和网络开销方面都可能是昂贵的，如果使用 TLSv1.3 则成本会更低。通过从已建立的会话中提取会话票证，然后在建立下一个连接时提交该票证，如果可以重用会话，则总体成本会降低。例如，考虑拥有可以打开多个连接并更快生成的网页的好处。
通常，在 SSL 会话可以重用之前必须满足以下条件：
服务器必须将其会话缓存保存在内存中。
服务器端会话缓存超时不得已过期。
每个客户端都必须维护活动会话的缓存并确保其安全。
C 应用程序可以使用 C API 功能为加密连接启用会话重用（请参阅
SSL 会话重用）。
用于 SSL 会话重用的服务器端运行时配置和监控
为了创建初始 TLS 上下文，服务器使用上下文相关的系统变量在启动时具有的值。为了公开上下文值，服务器还初始化一组相应的状态变量。下表显示了定义服务器的运行时会话缓存的系统变量和公开当前活动会话缓存值的相应状态变量。
表 6.15 会话重用的系统和状态变量
系统变量名称
对应的状态变量名
ssl_session_cache_mode
Ssl_session_cache_mode
ssl_session_cache_timeout
Ssl_session_cache_timeout
笔记
当
ssl_session_cache_mode服务器变量的值为时ON，即默认模式，
Ssl_session_cache_mode
状态变量的值为SERVER。
SSL 会话缓存变量适用于
mysql_main和mysql_admin
TLS 通道。它们的值也作为性能模式
tls_channel_status表中的属性公开，以及任何其他活动 TLS 上下文的属性。
要在运行时重新配置 SSL 会话缓存，请使用以下过程：
将每个应更改为新值的与缓存相关的系统变量设置为新值。例如，将缓存超时值从默认值（300 秒）更改为 600 秒：
mysql> SET GLOBAL ssl_session_cache_timeout = 600;
由于重新配置过程的工作方式，每对系统和状态变量的成员可能暂时具有不同的值。
mysql> SHOW VARIABLES LIKE 'ssl_session_cache_timeout';
+---------------------------+-------+
| Variable_name             | Value |
+---------------------------+-------+
| ssl_session_cache_timeout | 600   |
+---------------------------+-------+
1 row in set (0.00 sec)
mysql> SHOW STATUS LIKE 'Ssl_session_cache_timeout';
+---------------------------+-------+
| Variable_name             | Value |
+---------------------------+-------+
| Ssl_session_cache_timeout | 300   |
+---------------------------+-------+
1 row in set (0.00 sec)
有关设置变量值的其他信息，请参阅系统变量分配。
执行ALTER INSTANCE RELOAD
TLS。此语句根据缓存相关系统变量的当前值重新配置活动 TLS 上下文。它还设置与缓存相关的状态变量以反映新的活动缓存值。该语句需要CONNECTION_ADMIN
特权。
mysql> ALTER INSTANCE RELOAD TLS;
Query OK, 0 rows affected (0.01 sec)
mysql> SHOW VARIABLES LIKE 'ssl_session_cache_timeout';
+---------------------------+-------+
| Variable_name             | Value |
+---------------------------+-------+
| ssl_session_cache_timeout | 600   |
+---------------------------+-------+
1 row in set (0.00 sec)
mysql> SHOW STATUS LIKE 'Ssl_session_cache_timeout';
+---------------------------+-------+
| Variable_name             | Value |
+---------------------------+-------+
| Ssl_session_cache_timeout | 600   |
+---------------------------+-------+
1 row in set (0.00 sec)
执行后建立的新连接
ALTER INSTANCE RELOAD TLS使用新的 TLS 上下文。现有连接不受影响。
SSL 会话重用的客户端配置
所有 MySQL 客户端程序都能够为与同一服务器建立的新加密连接重用先前的会话，前提是您在原始连接仍处于活动状态时存储了会话数据。会话数据存储到一个文件中，您在再次调用客户端时指定该文件。
要存储和重用 SSL 会话数据，请使用以下过程：
调用mysql与运行 MySQL 8.0.29 或更高版本的服务器建立加密连接。
使用ssl_session_data_print命令指定一个文件的路径，您可以在其中安全地存储当前活动的会话数据。例如：
mysql> ssl_session_data_print ~/private-dir/session.txt
会话数据以空终止的、PEM 编码的 ANSI 字符串的形式获得。如果省略路径和文件名，字符串将打印到标准输出。
在命令解释器的提示符下，调用任何 MySQL 客户端程序以建立与同一服务器的新加​​密连接。要重用会话数据，请指定
--ssl-session-data
命令行选项和文件参数。
例如，使用
mysql建立一个新连接：
mysql -u admin -p --ssl-session-data=~/private-dir/session.txt
然后是 mysqlshow客户端：
mysqlshow -u admin -p --ssl-session-data=~/private-dir/session.txt
Enter password: *****
+--------------------+
|     Databases      |
+--------------------+
| information_schema |
| mysql              |
| performance_schema |
| sys                |
| world              |
+--------------------+
在每个示例中，客户端在与同一服务器建立新连接时尝试恢复原始会话。
要确认mysql是否重用了会话，请查看status
命令的输出。如果当前活动的mysql
连接确实恢复了会话，则状态信息包括SSL session reused: true.
除了mysql和
mysqlshow之外，SSL 会话重用还适用于
mysqladmin、mysqlbinlog、
mysqlcheck、mysqldump、
mysqlimport、mysqlpump、
mysqlslap、mysqltest、
mysql_migrate_keyring、
mysql_secure_installation和
mysql_upgrade。
有几种情况可能会阻止成功检索会话数据。例如，如果会话未完全连接，则它不是 SSL 会话，服务器尚未发送会话数据，或者 SSL 会话根本不可重用。即使会话数据存储正确，服务器的会话缓存也可能超时。--ssl-session-data无论什么原因，如果您指定但会话无法重用，默认情况下会返回错误
。例如：
mysqlshow -u admin -p --ssl-session-data=~/private-dir/session.txt
Enter password: *****
ERROR:
--ssl-session-data specified but the session was not reused.
要抑制错误消息，并通过静默创建新会话来建立连接，
--ssl-session-data-continue-on-failed-reuse
请在命令行上指定，连同
--ssl-session-data. 如果服务器的缓存超时已过期，您可以将会话数据再次存储到同一个文件中。可以延长默认服务器缓存超时（请参阅
服务器端运行时配置和监视 SSL 会话重用）。
© Mysql 中文网
