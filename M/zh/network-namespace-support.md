# 5.1.14 网络命名空间支持_MySQL 8.0 参考手册

5.1.14 网络命名空间支持_MySQL 8.0 参考手册
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
5.1 MySQL 服务器
5.1.1 配置服务器1
5.1.2 服务器配置默认值1
5.1.3 服务器配置验证1
5.1.4 服务器选项、系统变量、状态变量参考1
5.1.5 服务器系统变量引用1
5.1.6 服务器状态变量参考1
5.1.7 服务器命令选项1
5.1.8 服务器系统变量1
5.1.9 使用系统变量1
5.1.10 服务器状态变量1
5.1.11 服务器 SQL 模式1
5.1.12 连接管理1
5.1.13 IPv6 支持1
5.1.14 网络命名空间支持1
5.1.15 MySQL 服务器时区支持1
5.1.16 资源组1
5.1.17 服务器端帮助支持1
5.1.18 服务器跟踪客户端会话状态1
5.1.19 服务器关机流程1
5.2 MySQL数据目录
5.3 mysql系统架构
5.4 MySQL 服务器日志
5.5 MySQL组件
5.6 MySQL 服务器插件
5.7 MySQL 服务器可加载函数
5.8 在一台机器上运行多个MySQL实例
5.9 调试 MySQL
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
MySQL 8.0 参考手册  / 第 5 章 MySQL 服务器管理  / 5.1 MySQL 服务器  /
5.1.14 网络命名空间支持
5.1.14 网络命名空间支持
网络命名空间是来自主机系统的网络堆栈的逻辑副本。网络名称空间对于设置容器或虚拟环境很有用。每个名称空间都有自己的 IP 地址、网络接口、路由表等。默认或全局名称空间是主机系统物理接口所在的名称空间。
当 MySQL 连接跨命名空间时，特定于命名空间的地址空间可能会导致问题。例如，在容器或虚拟网络中运行的 MySQL 实例的网络地址空间可能与主机的地址空间不同。这可能会产生这样的现象，例如来自一个名称空间中的地址的客户端连接在 MySQL 服务器看来来自不同的地址，即使对于在同一台计算机上运行的客户端和服务器也是如此。假设两个进程都在具有 IP 地址203.0.113.10但使用不同命名空间的主机上运行。连接可能会产生如下结果：
$> mysql --user=admin --host=203.0.113.10 --protocol=tcp
mysql> SELECT USER();
+--------------------+
| USER()             |
+--------------------+
| admin@198.51.100.2 |
+--------------------+
在这种情况下，期望值USER()
为admin@203.0.113.10。如果发起连接的地址与显示的不符，则此类行为可能会导致难以正确分配帐户权限。
为了解决这个问题，MySQL 允许指定用于 TCP/IP 连接的网络命名空间，以便连接的两个端点使用商定的公共地址空间。
MySQL 8.0.22 及更高版本在实现它们的平台上支持网络命名空间。MySQL 中的支持适用于：
MySQL 服务器mysqld。
X插件。
mysql客户端和
mysqlxtest测试套件客户端。（不支持其他客户端。它们必须从它们要连接的服务器的网络名称空间内调用。）
定期复制。
Group Replication，仅在使用MySQL通信栈建立组通信连接时（从MySQL 8.0.27开始）。
以下部分描述了如何在 MySQL 中使用网络名称空间：
主机系统先决条件MySQL配置网络命名空间监控
主机系统先决条件
在 MySQL 中使用网络名称空间支持之前，必须满足以下主机系统先决条件：
主机操作系统必须支持网络命名空间。（例如，Linux。）
MySQL 使用的任何网络命名空间必须首先在主机系统上创建。
主机名解析必须由系统管理员配置以支持网络命名空间。
笔记
一个已知的限制是，在 MySQL 中，主机名解析不适用于特定于网络名称空间的主机文件中指定的名称。例如，如果文件red中指定了命名空间中主机名的地址，则/etc/netns/red/hosts
在服务器端和客户端绑定到该名称都会失败。解决方法是使用 IP 地址而不是主机名。
系统管理员必须
为支持网络名称空间（ mysqld、mysql、
mysqlxtest）
CAP_SYS_ADMIN的 MySQL 二进制文件启用操作系统权限。
重要的
启用CAP_SYS_ADMIN是一项安全敏感操作，因为它使进程能够执行除设置名称空间之外的其他特权操作。有关其效果的说明，请参阅
https://man7.org/linux/man-pages/man7/capabilities.7.html。
因为CAP_SYS_ADMIN必须由系统管理员显式启用，MySQL 二进制文件默认不启用网络命名空间支持。CAP_SYS_ADMIN系统管理员应该在启用之前
评估运行 MySQL 进程的安全隐患
。
以下示例中的说明设置了名为red和
的网络命名空间blue。您选择的名称可能不同，主机系统上的网络地址和接口也可能不同。
root以操作系统用户身份或通过在每个命令前加上sudo
来调用此处显示的
命令。例如，
如果您不是，要调用ip或setcaproot命令，请使用
sudo ip或sudo setcap。
要配置网络名称空间，请使用ip
命令。对于某些操作，ip命令必须在特定名称空间（必须已经存在）中执行。在这种情况下，像这样开始命令：
ip netns exec namespace_name
例如，此命令在
red命名空间内执行以启动环回接口：
ip netns exec red ip link set lo up
要添加名为red和
的命名空间blue，每个命名空间都有自己的虚拟以太网设备，用作命名空间和自己的环回接口之间的链接：
ip netns add red
ip link add veth-red type veth peer name vpeer-red
ip link set vpeer-red netns red
ip addr add 192.0.2.1/24 dev veth-red
ip link set veth-red up
ip netns exec red ip addr add 192.0.2.2/24 dev vpeer-red
ip netns exec red ip link set vpeer-red up
ip netns exec red ip link set lo up
ip netns add blue
ip link add veth-blue type veth peer name vpeer-blue
ip link set vpeer-blue netns blue
ip addr add 198.51.100.1/24 dev veth-blue
ip link set veth-blue up
ip netns exec blue ip addr add 198.51.100.2/24 dev vpeer-blue
ip netns exec blue ip link set vpeer-blue up
ip netns exec blue ip link set lo up
# if you want to enable inter-subnet routing...
sysctl net.ipv4.ip_forward=1
ip netns exec red ip route add default via 192.0.2.1
ip netns exec blue ip route add default via 198.51.100.1
名称空间之间的链接图如下所示：
red              global           blue
192.0.2.2   <=>  192.0.2.1
(vpeer-red)      (veth-red)
198.51.100.1 <=> 198.51.100.2
(veth-blue)      (vpeer-blue)
要检查存在哪些命名空间和链接：
ip netns list
ip link list
查看全局和命名空间的路由表：
ip route show
ip netns exec red ip route show
ip netns exec blue ip route show
要删除red和blue
链接和名称空间：
ip link del veth-red
ip link del veth-blue
ip netns del red
ip netns del blue
sysctl net.ipv4.ip_forward=0
为了使包含网络名称空间支持的 MySQL 二进制文件可以实际使用名称空间，您必须授予它们该
CAP_SYS_ADMIN功能。以下
setcap命令假定您已将位置更改为包含 MySQL 二进制文件的目录（根据需要调整系统的路径名）：
cd /usr/local/mysql/bin
为适当的二进制文件授予CAP_SYS_ADMIN能力：
setcap cap_sys_admin+ep ./mysqld
setcap cap_sys_admin+ep ./mysql
setcap cap_sys_admin+ep ./mysqlxtest
检查CAP_SYS_ADMIN能力：
$> getcap ./mysqld ./mysql ./mysqlxtest
./mysqld = cap_sys_admin+ep
./mysql = cap_sys_admin+ep
./mysqlxtest = cap_sys_admin+ep
要删除CAP_SYS_ADMIN功能：
setcap -r ./mysqld
setcap -r ./mysql
setcap -r ./mysqlxtest
重要的
如果重新安装之前应用
过 setcap的二进制文件，则必须再次使用
setcap。例如，如果您执行就地 MySQL 升级，则未能
CAP_SYS_ADMIN再次授予该功能会导致与名称空间相关的故障。服务器因尝试绑定到具有命名空间的地址而失败并出现此错误：
[ERROR] [MY-013408] [Server] setns() failed with error 'Operation not permitted'
使用该选项调用的客户端会
--network-namespace像这样失败：
ERROR: Network namespace error: Operation not permitted
MySQL配置
假设满足前面的主机系统先决条件，MySQL 可以为连接的侦听（入站）端配置服务器端命名空间，为连接的出站端配置客户端命名空间。
在服务器端，
bind_address、
admin_address和
mysqlx_bind_address系统变量具有扩展语法，用于指定网络名称空间以用于给定的 IP 地址或主机名，用于侦听传入连接。要为地址指定命名空间，请添加斜杠和命名空间名称。例如，服务器my.cnf文件可能包含以下行：
[mysqld]
bind_address = 127.0.1.1,192.0.2.2/red,198.51.100.2/blue
admin_address = 102.0.2.2/red
mysqlx_bind_address = 102.0.2.2/red
这些规则适用：
可以为 IP 地址或主机名指定网络命名空间。
不能为通配符 IP 地址指定网络命名空间。
对于给定的地址，网络名称空间是可选的。如果给定，则必须将其指定为
紧跟在地址之后的后缀。
/ns
没有
后缀的地址使用主机系统全局命名空间。因此全局命名空间是默认的。
/ns
带有
后缀的地址使用名为 的命名空间。
/nsns
主机系统必须支持网络命名空间，并且每个命名空间必须之前已经设置。命名不存在的名称空间会产生错误。
bind_address和（从 MySQL 8.0.21 开始）
mysqlx_bind_address接受多个逗号分隔地址的列表，变量值可以指定全局名称空间、命名名称空间或混合名称空间中的地址。
如果在服务器启动期间尝试使用命名空间时发生错误，则服务器不会启动。如果 X Plugin 在插件初始化过程中发生错误，无法绑定到任何地址，则插件的初始化序列将失败，服务器不会加载它。
在客户端，可以在这些上下文中指定网络名称空间：
对于mysql客户端和
mysqlxtest测试套件客户端，使用该
--network-namespace选项。例如：
mysql --host=192.0.2.2 --network-namespace=red
如果--network-namespace
省略该选项，则连接使用默认（全局）命名空间。
对于从副本服务器到源服务器的复制连接，使用CHANGE REPLICATION
SOURCE TO语句（从 MySQL 8.0.23 开始）或
CHANGE MASTER TO语句（在 MySQL 8.0.23 之前）并指定
NETWORK_NAMESPACE选项。例如：
CHANGE REPLICATION SOURCE TO
SOURCE_HOST = '192.0.2.2',
NETWORK_NAMESPACE = 'red';
如果NETWORK_NAMESPACE省略该选项，复制连接将使用默认（全局）命名空间。
以下示例设置了一个 MySQL 服务器，用于侦听全局、red和
blue命名空间中的连接，并显示如何配置从red和
blue命名空间连接的帐户。假定
已经创建
了red和命名空间，如主机系统先决条件中所示。
blue
配置服务器以侦听多个名称空间中的地址。将这些行放在服务器
my.cnf文件中并启动服务器：
[mysqld]
bind_address = 127.0.1.1,192.0.2.2/red,198.51.100.2/blue
该值告诉服务器监听
127.0.0.1全局命名空间中的环回地址、命名空间中的地址192.0.2.2和
命名空间中
red的地址
。
198.51.100.2blue
连接到全局命名空间中的服务器并创建有权从每个命名空间的地址空间中的地址进行连接的帐户：
$> mysql -u root -h 127.0.0.1 -p
Enter password: root_password
mysql> CREATE USER 'red_user'@'192.0.2.2'
IDENTIFIED BY 'red_user_password';
mysql> CREATE USER 'blue_user'@'198.51.100.2'
IDENTIFIED BY 'blue_user_password';
验证您是否可以连接到每个命名空间中的服务器：
$> mysql -u red_user -h 192.0.2.2 --network-namespace=red -p
Enter password: red_user_password
mysql> SELECT USER();
+--------------------+
| USER()             |
+--------------------+
| red_user@192.0.2.2 |
+--------------------+$> mysql -u blue_user -h 198.51.100.2 --network-namespace=blue -p
Enter password: blue_user_password
mysql> SELECT USER();
+------------------------+
| USER()                 |
+------------------------+
| blue_user@198.51.100.2 |
+------------------------+
笔记
您可能会看到来自 的不同结果
USER()，如果您的 DNS 配置为能够将地址解析为相应的主机名并且服务器未在
skip_name_resolve启用系统变量的情况下运行，则它可以返回包含主机名而不是 IP 地址的值.
您也可以尝试在没有选项的情况下调用mysql--network-namespace以查看连接尝试是否成功，如果成功，该USER()值将如何受到影响。
网络命名空间监控
出于复制监控目的，这些信息源有一列显示连接的适用网络名称空间：
性能模式
replication_connection_configuration
表。请参阅
第 27.12.11.1 节，“replication_connection_configuration 表”。
副本服务器连接元数据存储库。请参阅
第 17.2.4.2 节，“复制元数据存储库”。
（
SHOW
REPLICA STATUS或在 MySQL 8.0.22 之前
SHOW
SLAVE STATUS）语句。请参阅
第 13.7.7.35 节，“显示副本状态语句”。
© Mysql 中文网
