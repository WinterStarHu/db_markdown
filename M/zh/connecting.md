# 4.2.4 使用命令选项连接到 MySQL 服务器_MySQL 8.0 参考手册

4.2.4 使用命令选项连接到 MySQL 服务器_MySQL 8.0 参考手册
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
4.2.1 调用MySQL程序1
4.2.2 指定程序选项1
4.2.3 连接服务器的命令选项1
4.2.4 使用命令选项连接到 MySQL 服务器1
4.2.5 使用类似 URI 的字符串或键值对连接到服务器1
4.2.6 使用 DNS SRV 记录连接到服务器1
4.2.7 连接传输协议1
4.2.8 连接压缩控制1
4.2.9 设置环境变量1
4.3 服务器和服务器启动程序
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
MySQL 8.0 参考手册  / 第 4 章 MySQL 程序  / 4.2 使用 MySQL 程序  /
4.2.4 使用命令选项连接到 MySQL 服务器
4.2.4 使用命令选项连接到 MySQL 服务器
本节描述使用命令行选项指定如何为
mysql或mysqldump等客户端建立与 MySQL 服务器的连接。有关使用类似 URI 的连接字符串或键值对建立连接的信息，对于 MySQL Shell 等客户端，请参阅
第 4.2.5 节，“使用类似 URI 的字符串或键值对连接到服务器”。有关无法连接的其他信息，请参阅
第 6.2.22 节，“连接到 MySQL 的故障排除”。
对于连接到 MySQL 服务器的客户端程序，它必须使用正确的连接参数，例如运行服务器的主机的名称以及您的 MySQL 帐户的用户名和密码。每个连接参数都有一个默认值，但您可以根据需要使用在命令行或选项文件中指定的程序选项覆盖默认值。
此处的示例使用mysql客户端程序，但原理适用于其他客户端，例如
mysqldump、mysqladmin或
mysqlshow。
此命令在不指定任何显式连接参数的情况
下调用mysql ：mysql
因为没有参数选项，所以默认值适用：
默认主机名是localhost. 在 Unix 上，这具有特殊的含义，如后所述。
默认用户名ODBC在 Windows 上或在 Unix 上是您的 Unix 登录名。
没有密码被发送，因为既没有
--password也没有
-p给出。
对于mysql，第一个非选项参数被视为默认数据库的名称。因为没有这个参数，所以mysql不选择默认数据库。
要明确指定主机名和用户名以及密码，请在命令行上提供适当的选项。要选择默认数据库，请添加数据库名称参数。例子：
mysql --host=localhost --user=myname --password=password mydb
mysql -h localhost -u myname -ppassword mydb
对于密码选项，密码值是可选的：
如果您使用--passwordor
-p选项并指定密码值，则or
和后面的密码
之间
不能有空格。--password=-p
如果您使用--password或
-p但未指定密码值，则客户端程序会提示您输入密码。输入密码时不会显示密码。这比在命令行上提供密码更安全，后者可能会让您系统上的其他用户通过执行诸如ps之类的命令来查看密码行。请参阅
第 6.1.2.1 节，“密码安全的最终用户指南”。
要明确指定没有密码并且客户端程序不应提示输入密码，请使用该
--skip-password
选项。
正如刚才提到的，在命令行中包含密码值存在安全风险。为避免此风险，请指定
不带任何以下密码值
的--password或选项：-pmysql --host=localhost --user=myname --password mydb
mysql -h localhost -u myname -p mydb
当--passwordor
-p选项没有密码值时，客户端程序打印提示并等待您输入密码。（在这些示例中，mydb不被
解释为密码，因为它与前面的密码选项之间用空格隔开。）
在某些系统上，MySQL 用来提示输入密码的库例程会自动将密码限制为八个字符。该限制是系统库的属性，而不是 MySQL。在内部，MySQL 对密码的长度没有任何限制。要解决受其影响的系统的限制，请在选项文件中指定您的密码（请参阅
第 4.2.2.2 节，“使用选项文件”）。另一种解决方法是将 MySQL 密码更改为八个或更少字符的值，但缺点是较短的密码往往不太安全。
客户端程序确定要建立的连接类型如下：
如果主机未指定或为
localhost，则会连接到本地主机：
在 Windows 上，如果服务器启动时
shared_memory启用了支持共享内存连接的系统变量，则客户端使用共享内存进行连接。
在 Unix 上，MySQL 程序对主机名
localhost进行特殊处理，与其他基于网络的程序相比，其处理方式可能与您所期望的不同：客户端使用 Unix 套接字文件进行连接。--socket
选项或环境变量可MYSQL_UNIX_PORT
用于指定套接字名称。
在 Windows 上，如果host是.
（句点），或 TCP/IP 未启用
--socket且未指定或主机为空，则客户端使用命名管道连接，如果服务器启动时
named_pipe启用了支持命名管道连接的系统变量. 如果不支持命名管道连接，或者如果建立连接的用户不是
named_pipe_full_access_group
系统变量指定的 Windows 组的成员，则会发生错误。
否则，连接使用 TCP/IP。
该--protocol选项使您能够使用特定的传输协议，即使其他选项通常会导致使用不同的协议。也就是说，
--protocol明确指定传输协议并覆盖前面的规则，即使对于
localhost.
仅使用或检查与所选传输协议相关的连接选项。其他连接选项将被忽略。例如，
--host=localhost在 Unix 上，客户端尝试使用 Unix 套接字文件连接到本地服务器，即使给出了--port或
-P选项来指定 TCP/IP 端口号。
要确保客户端与本地服务器建立 TCP/IP 连接，请使用--host或
-h指定主机名值
127.0.0.1（而不是
localhost），或者本地服务器的 IP 地址或名称。您还可以localhost通过使用该
--protocol=TCP选项明确指定传输协议，即使对于 ，也是如此。例子：
mysql --host=127.0.0.1
mysql --protocol=TCP
如果服务器配置为接受 IPv6 连接，则客户端可以使用 IPv6 通过 IPv6 连接到本地服务器
--host=::1。请参阅
第 5.1.13 节，“IPv6 支持”。
在 Windows 上，要强制 MySQL 客户端使用命名管道连接，请指定--pipe或
--protocol=PIPE选项，或指定
.（句点）作为主机名。如果服务器不是在named_pipe
启用支持命名管道连接的系统变量的情况下启动的，或者如果建立连接的用户不是
named_pipe_full_access_group
系统变量指定的 Windows 组的成员，则会发生错误。--socket如果您不想使用默认管道名称，
请使用该
选项指定管道名称。
与远程服务器的连接使用 TCP/IP。此命令remote.example.com使用默认端口号 (3306) 连接到运行的服务器：
mysql --host=remote.example.com
要明确指定端口号，请使用
--portor-P
选项：
mysql --host=remote.example.com --port=13306
您也可以指定用于连接到本地服务器的端口号。然而，如前所述，
localhost在 Unix 上的连接默认使用套接字文件，因此除非您如前所述强制建立 TCP/IP 连接，否则任何指定端口号的选项都将被忽略。
对于此命令，程序使用 Unix 上的套接字文件并
--port忽略该选项：
mysql --port=13306 --host=localhost
要使用端口号，请强制建立 TCP/IP 连接。例如，以下列任一方式调用程序：
mysql --port=13306 --host=127.0.0.1
mysql --port=13306 --protocol=TCP
有关控制客户端程序如何与服务器建立连接的选项的其他信息，请参阅
第 4.2.3 节，“用于连接到服务器的命令选项”。
每次调用客户端程序时，都可以指定连接参数而无需在命令行中输入它们：
[client]在选项文件的部分
指定连接参数
。该文件的相关部分可能如下所示：
[client]
host=host_name
user=user_name
password=password
有关详细信息，请参阅第 4.2.2.2 节，“使用选项文件”。
一些连接参数可以使用环境变量指定。例子：
要为mysql
指定主机，请使用
MYSQL_HOST.
在 Windows 上，要指定 MySQL 用户名，请使用
USER.
有关支持的环境变量的列表，请参阅
第 4.9 节，“环境变量”。
© Mysql 中文网
