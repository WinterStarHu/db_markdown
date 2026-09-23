# 18.6.1 连接安全管理通信栈_MySQL 8.0 参考手册

18.6.1 连接安全管理通信栈_MySQL 8.0 参考手册
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
18.1 组复制背景
18.2 开始
18.3 要求和限制
18.4 监控组复制
18.5 组复制操作
18.6 组复制安全
18.6.1 连接安全管理通信栈1
18.6.2 使用安全套接字层 (SSL) 保护组通信连接1
18.6.3 保护分布式恢复连接1
18.6.4 群组复制IP地址权限1
18.7 组复制性能和故障排除
18.8 升级组复制
18.9 组复制系统变量
18.10 常见问题
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
MySQL 8.0 参考手册  / 第十八章 组复制  / 18.6 组复制安全  /
18.6.1 连接安全管理通信栈
18.6.1 连接安全管理通信栈
从 MySQL 8.0.27 开始，组复制可以通过以下方法之一保护成员之间的组通信连接：
使用其自己的安全协议实现，包括 TLS/SSL 和对传入组通信系统 (GCS) 连接使用白名单。这是 MySQL 8.0.26 及更早版本的唯一选项。
使用 MySQL 服务器自己的连接安全性代替 Group Replication 的实现。使用 MySQL 协议意味着可以使用标准的用户身份验证方法来授予（或撤销）对组的访问权限，而不是允许列表，并且服务器协议的最新功能始终在发布时可用。这个选项从 MySQL 8.0.27 开始可用。
通过将系统变量设置
group_replication_communication_stack
为XCOM使用 Group Replication 自己的实现（这是默认选择）或
MYSQL使用 MySQL 服务器的连接安全性来做出选择。
复制组需要以下额外配置才能使用 MySQL 通信堆栈。当您从使用 XCom 通信堆栈切换到您的组的 MySQL 通信堆栈时，确保满足所有这些要求尤为重要。
MySQL 通信堆栈的组复制要求
由系统变量为每个组成员配置的网络地址
group_replication_local_address
必须设置为 MySQL 服务器正在侦听的 IP 地址和端口之一，由
bind_address服务器的系统变量指定。每个成员的 IP 地址和端口的组合在组中必须是唯一的。建议将
group_replication_group_seeds
每个组成员的系统变量配置为包含所有组成员的所有本地地址。
MySQL 通信栈支持网络命名空间，XCom 通信栈不支持。如果网络命名空间与组成员 ( ) 的组复制本地地址一起使用，则group_replication_local_address必须使用
CHANGE REPLICATION SOURCE TO
语句为每个组成员配置这些地址。此外，
report_host必须设置每个组成员的服务器系统变量以报告命名空间。所有组成员必须使用相同的命名空间，以避免分布式恢复期间地址解析可能出现的问题。
必须将
group_replication_ssl_mode
系统变量设置为组通信所需的设置。此系统变量控制是否为组通信启用或禁用 TLS/SSL。对于 MySQL 8.0.26 及更早版本，TLS/SSL 配置始终取自服务器的 SSL 设置；对于 MySQL 8.0.27 及更高版本，当使用 MySQL 通信堆栈时，TLS/SSL 配置取自 Group Replication 的分布式恢复设置。此设置对所有组成员都应该相同，以避免潜在的冲突。
--ssl或
--skip-ssl
服务器选项和
服务器系统变量
的设置require_secure_transport
在所有组成员上都应该相同，以避免潜在的冲突。如果
group_replication_ssl_mode设置为REQUIRED,
VERIFY_CA, 或
VERIFY_IDENTITY, 使用
--ssland
require_secure_transport=ON。如果group_replication_ssl_mode
设置为DISABLED，则使用
require_secure_transport=OFF。
如果为组通信启用了 TLS/SSL，则必须配置用于保护分布式恢复的组复制设置（如果它们尚未到位），或者如果它们已经到位则进行验证。MySQL 通信堆栈不仅将这些设置用于成员到成员的分布式恢复连接，还用于一般组通信中的 TLS/SSL 配置。
group_replication_recovery_use_ssl
和其他group_replication_recovery_*
系统变量在
第 18.6.3.2 节“用于分布式恢复的安全套接字层 (SSL) 连接”中进行了解释。
Group Replication allowlist在group使用MySQL通信栈时不使用，所以
group_replication_ip_allowlist
和
group_replication_ip_whitelist
系统变量被忽略，不需要配置。
Group Replication 用于分布式恢复的复制用户帐户，如使用
CHANGE REPLICATION SOURCE TO
语句配置的那样，在设置 Group Replication 连接时用于 MySQL 通信堆栈的身份验证。此用户帐户对所有组成员都是相同的，必须授予以下权限：
GROUP_REPLICATION_STREAM. 用户帐户需要此权限才能使用 MySQL 通信堆栈为组复制建立连接。
CONNECTION_ADMIN. 需要此权限，以便在涉及的服务器之一处于离线模式时，组复制连接不会终止。如果在没有此权限的情况下使用 MySQL 通信堆栈，则将处于离线模式的成员从组中驱逐。
这些是
所有复制用户帐户必须具有的特权之外的特权（请参阅
REPLICATION SLAVE第
18.2.1.3 节，“分布式恢复的用户凭据”）。添加新权限时，请确保通过在发出语句
之前
和之后发出来跳过每个组成员的二进制日志记录，以便本地事务不会干扰重新启动组复制。
BACKUP_ADMINSET
SQL_LOG_BIN=0GRANTSET SQL_LOG_BIN=1
group_replication_communication_stack
实际上是组范围的配置设置，并且所有组成员的设置必须相同。但是，这不受组复制自己对组范围配置设置的检查的监管。与组中其他成员具有不同值的成员根本无法与其他成员通信，因为通信协议不兼容，因此它无法交换有关其配置设置的信息。
这意味着虽然系统变量的值可以在 Group Replication 运行时更改，并在您对组成员重新启动 Group Replication 后生效，但在更改所有成员的设置之前，该成员仍然无法重新加入组。因此，您必须在所有成员上停止组复制并更改所有成员的系统变量值，然后才能重新启动组。因为所有成员都已停止，所以需要完全重新启动组（由服务器引导
group_replication_bootstrap_group=ON）才能使值更改生效。当组成员停止时，您可以对组成员的设置进行其他必要的更改。
对于正在运行的组，请按照以下过程更改值
group_replication_communication_stack
和其他所需设置，以将组从 XCom 通信堆栈迁移到 MySQL 通信堆栈，或从 MySQL 通信堆栈迁移到 XCom 通信堆栈：
STOP GROUP_REPLICATION
使用语句
停止每个组成员的组复制
。最后停止主要成员，这样您就不会触发新的主要选举并且必须等待它完成。
在每个组成员上，将系统变量设置
group_replication_communication_stack
为新的通信堆栈，MYSQL或
XCOM视情况而定。您可以通过编辑 MySQL 服务器配置文件（通常
my.cnf在 Linux 和 Unix 系统或
my.iniWindows 系统上命名）或使用
SET语句来完成此操作。例如：
SET PERSIST group_replication_communication_stack="MYSQL";
如果您正在将复制组从 XCom 通信堆栈（默认）迁移到 MySQL 通信堆栈，则在每个组成员上，将所需的系统变量配置或重新配置为适当的设置，如上面的清单中所述。例如，
group_replication_local_address
系统变量必须设置为 MySQL 服务器正在侦听的 IP 地址和端口之一。还可以使用CHANGE
REPLICATION SOURCE TO语句配置任何网络命名空间。
如果您正在将复制组从 XCom 通信堆栈（默认）迁移到 MySQL 通信堆栈，则在每个组成员上，发出
GRANT语句以授予复制用户帐户
GROUP_REPLICATION_STREAM和
CONNECTION_ADMIN权限。您需要使组成员脱离组复制停止时应用的只读状态。还要确保通过在发出语句
SET SQL_LOG_BIN=0之前和之后发出来跳过每个组成员的二进制日志记录，以便本地事务不会干扰重新启动组复制。例如：
GRANTSET SQL_LOG_BIN=1SET GLOBAL SUPER_READ_ONLY=OFF;
SET SQL_LOG_BIN=0;
GRANT GROUP_REPLICATION_STREAM ON *.* TO rpl_user@'%';
GRANT CONNECTION_ADMIN ON *.* TO rpl_user@'%';
SET SQL_LOG_BIN=1;
如果要将复制组从 MySQL 通信堆栈迁移回 XCom 通信堆栈，则在每个组成员上，将上面列出的要求中的系统变量重新配置为适合 XCom 通信堆栈的设置。
第 18.9 节，“组复制系统变量”列出了系统变量及其默认值和 XCom 通信堆栈的要求。
笔记
XCom 通信堆栈不支持网络命名空间，因此组复制本地地址（group_replication_local_address
系统变量）不能使用这些。通过发布CHANGE REPLICATION SOURCE
TO声明取消设置。
当您返回 XCom 通信堆栈时，由
group_replication_recovery_use_ssl
和其他
group_replication_recovery_*系统变量指定的设置不用于保护组通信。相反，Group Replication 系统变量
group_replication_ssl_mode
用于激活 SSL 用于组通信连接并指定连接的安全模式，其余配置取自服务器的 SSL 配置。有关详细信息，请参阅
第 18.6.2 节，“使用安全套接字层 (SSL) 保护组通信连接”。
要重新启动组，请按照
第 18.5.2 节“重新启动组”中的过程进行操作，该过程解释了如何安全地引导已执行和验证事务的组。必须由服务器进行引导
group_replication_bootstrap_group=ON
以更改通信堆栈，因为必须关闭所有成员。
成员现在使用新的通信堆栈相互连接。任何已
group_replication_communication_stack
设置（或默认，在 XCom 的情况下）到以前的通信堆栈的服务器不再能够加入该组。需要注意的是，因为 Group Replication 甚至看不到加入尝试，所以它不会检查并拒绝带有错误消息的加入成员。相反，当先前的通信堆栈放弃尝试联系新通信堆栈时，尝试的加入会无提示地失败。
© Mysql 中文网
