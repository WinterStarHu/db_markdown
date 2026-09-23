# 18.9 组复制系统变量_MySQL 8.0 参考手册

18.9 组复制系统变量_MySQL 8.0 参考手册
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
MySQL 8.0 参考手册  / 第十八章 组复制  /
18.9 组复制系统变量
18.9 组复制系统变量
本节列出了特定于 Group Replication 插件的系统变量。每个配置选项都以“”为前缀group_replication。
组复制组成员上的一些系统变量，包括一些组复制特定的系统变量和一些通用系统变量，是组范围的配置设置。这些系统变量必须在所有组成员上具有相同的值，并且需要完全重新启动组（由服务器引导
group_replication_bootstrap_group=ON）才能使值更改生效。有关重新启动每个成员都已停止的组的说明，请参阅
第 18.5.2 节，“重新启动组”。
如果运行组为组范围的配置设置设置了值，并且加入成员为该系统变量设置了不同的值，则加入成员不能加入组，直到值更改为匹配。如果群组为其中一个系统变量设置了值，而加入的成员不支持该系统变量，则无法加入群组。
以下系统变量是组范围的配置设置：
group_replication_single_primary_mode
group_replication_enforce_update_everywhere_checks
group_replication_gtid_assignment_block_size
group_replication_view_change_uuid
group_replication_paxos_single_leader
group_replication_communication_stack
（Group Replication自身检查不监管的特殊情况，详见系统变量说明）
default_table_encryption
lower_case_table_names
transaction_write_set_extraction
（从 MySQL 8.0.26 开始弃用）
Group Replication 正在运行时，无法通过常规方法更改 Group-wide 配置设置。但是，从 MySQL 8.0.16 开始，您可以使用
group_replication_switch_to_single_primary_mode()
和
函数
在组仍在运行时group_replication_switch_to_multi_primary_mode()
更改 和 的值
group_replication_single_primary_mode
。
group_replication_enforce_update_everywhere_checks有关详细信息，请参阅
第 18.5.1.2 节，“更改组的模式”。
组复制的大多数系统变量在不同的组成员上可以有不同的值。对于以下系统变量，建议在一个组的所有成员上设置相同的值，以避免不必要的事务回滚、消息传递失败或消息恢复失败：
group_replication_auto_increment_increment
group_replication_communication_max_message_size
group_replication_compression_threshold
group_replication_message_cache_size
group_replication_transaction_size_limit
Group Replication 的大多数系统变量被描述为动态的，它们的值可以在服务器运行时更​​改。STOP GROUP_REPLICATION但是，在大多数情况下，更改仅在您使用语句后跟语句停止并重新启动组成员上的组复制后生效
START GROUP_REPLICATION
。对以下系统变量的更改无需停止并重新启动 Group Replication 即可生效：
group_replication_advertise_recovery_endpoints
group_replication_autorejoin_tries
group_replication_consistency
group_replication_exit_state_action
group_replication_flow_control_applier_threshold
group_replication_flow_control_certifier_threshold
group_replication_flow_control_hold_percent
group_replication_flow_control_max_commit_quota
group_replication_flow_control_member_quota_percent
group_replication_flow_control_min_quota
group_replication_flow_control_min_recovery_quota
group_replication_flow_control_mode
group_replication_flow_control_period
group_replication_flow_control_release_percent
group_replication_force_members
group_replication_ip_allowlist
group_replication_ip_whitelist
group_replication_member_expel_timeout
group_replication_member_weight
group_replication_transaction_size_limit
group_replication_unreachable_majority_timeout
当您更改任何 Group Replication 系统变量的值时，请记住，如果某个点上的 Group Replication 通过
STOP
GROUP_REPLICATION语句或系统关闭立即停止在每个成员上，则必须通过引导重新启动该组，就像它正在第一次开始。有关安全执行此操作的说明，请参阅
第 18.5.2 节，“重新启动组”。对于组范围的配置设置，这是必需的，但如果您要更改其他设置，请尝试确保至少有一个成员始终在运行。
重要的
如果将组复制的许多系统变量作为命令行参数传递给服务器，则在服务器启动期间不会完全验证它们。这些系统变量包括
group_replication_group_name、
group_replication_single_primary_mode、
group_replication_force_members、SSL 变量和流量控制系统变量。它们仅在服务器启动后才得到充分验证。
START GROUP_REPLICATION
在发出语句
之前，不会验证为组成员指定 IP 地址或主机名的组复制系统变量。Group Replication 的 Group Communication System (GCS) 直到那时才可用于验证值。
Group Replication 插件特有的系统变量如下：
group_replication_advertise_recovery_endpoints
命令行格式
--group-replication-advertise-recovery-endpoints=value
介绍
8.0.21
系统变量
group_replication_advertise_recovery_endpoints
范围
全球的
动态的
是的
SET_VAR提示适用
不
类型
细绳
默认值
DEFAULT
可以在组复制运行时更改此系统变量的值。更改立即对成员生效。但是，已经收到系统变量先前值的加入成员继续使用该值。只有在值更改后加入的成员才会收到新值。
group_replication_advertise_recovery_endpoints
指定加入成员如何建立与现有成员的连接以进行分布式恢复的状态传输。该连接用于远程克隆操作和来自捐赠者二进制日志的状态传输。
默认设置为DEFAULT，表示加入成员使用现有成员的标准 SQL 客户端连接，由 MySQL 服务器
hostname和
port系统变量指定。report_port如果系统变量指定了另一个端口号，则使用该端口号
。Performance Schema 表
在和
字段中replication_group_members显示此连接的地址和端口号
。这是组成员在 MySQL 8.0.20 及之前的版本中的行为。
MEMBER_HOSTMEMBER_PORT
代替DEFAULT，您可以指定一个或多个分布式恢复端点，现有成员向加入成员公布这些端点以供他们使用。提供分布式恢复端点让管理员能够独立于与组成员的常规 MySQL 客户端连接来控制分布式恢复流量。加入成员按照列表中指定的顺序依次尝试每个端点。
将分布式恢复端点指定为以逗号分隔的 IP 地址和端口号列表，例如：
group_replication_advertise_recovery_endpoints= "127.0.0.1:3306,127.0.0.1:4567,[::1]:3306,localhost:3306"
IPv4 和 IPv6 地址和主机名可以任意组合使用。必须在方括号中指定 IPv6 地址。主机名必须解析为本地 IP 地址。不能使用通配符地址格式，也不能指定空列表。请注意，标准 SQL 客户端连接不会自动包含在分布式恢复端点列表中。如果要将其用作端点，则必须将其显式包含在列表中。
有关如何选择 IP 地址和端口作为分布式恢复端点以及加入成员如何使用它们的详细信息，请参阅
第 18.5.4.1.1 节，“为分布式恢复端点选择地址”。要求汇总如下：
不必为 MySQL 服务器配置 IP 地址，但必须将它们分配给服务器。
port必须使用、
report_port或
admin_port系统变量
为 MySQL 服务器配置端口。
如果使用，复制用户需要适当的权限才能进行分布式恢复
admin_port。
不需要将 IP 地址添加到
group_replication_ip_allowlist
or
group_replication_ip_whitelist
系统变量指定的组复制白名单中。
连接的 SSL 要求由group_replication_recovery_ssl_*
选项指定。
group_replication_allow_local_lower_version_join
命令行格式
--group-replication-allow-local-lower-version-join[={OFF|ON}]
系统变量
group_replication_allow_local_lower_version_join
范围
全球的
动态的
是的
SET_VAR提示适用
不
类型
布尔值
默认值
OFF
该系统变量的值可以在 Group Replication 运行时更改，但更改仅在您停止并重新启动组成员上的 Group Replication 后生效。
group_replication_allow_local_lower_version_join
允许当前服务器加入该组，即使它运行的 MySQL 服务器版本低于该组。使用默认设置OFF，如果服务器运行的版本低于现有组成员，则不允许它们加入复制组。此标准策略确保组中的所有成员都能够交换消息和应用事务。请注意，运行 MySQL 8.0.17 或更高版本的成员在检查其兼容性时会考虑发布的补丁版本。运行 MySQL 8.0.16 或更低版本，或 MySQL 5.7 的成员，只考虑主要版本。
仅在以下场景
设置
group_replication_allow_local_lower_version_join
为：ON
为了提高组的容错能力，必须在紧急情况下向组中添加服务器，并且只有旧版本可用。
您想要回滚一个或多个复制组成员的升级而不关闭整个组并再次引导它。
警告
将此选项设置为ON不会使新成员与该组兼容，并允许它加入该组，而无需任何保护措施来防止现有成员的不兼容行为。为保证新成员的正确操作，请注意以下两点：
在运行较低版本的服务器加入组之前，停止对该服务器的所有写入。
从运行较低版本的服务器加入组的点开始，停止对组中其他服务器的所有写入。
如果没有这些预防措施，运行较低版本的服务器很可能会遇到困难并因错误而终止。
group_replication_auto_increment_increment
命令行格式
--group-replication-auto-increment-increment=#
系统变量
group_replication_auto_increment_increment
范围
全球的
动态的
是的
SET_VAR提示适用
不
类型
整数
默认值
7
最小值
1
最大值
65535
该系统变量应该对所有组成员具有相同的值。当组复制正在运行时，您不能更改此系统变量的值。您必须停止组复制，更改系统变量的值，然后在每个组成员上重新启动组复制。在此过程中，允许系统变量的值在组成员之间不同，但可能会回滚组成员上的某些事务。
group_replication_auto_increment_increment
确定在此服务器实例上执行的事务的自动递增列的连续值之间的间隔。添加一个间隔可以避免为组成员的写入选择重复的自动增量值，这会导致事务回滚。默认值 7 表示可用值的数量与复制组允许的最大大小（9 个成员）之间的平衡。如果您的组有更多或更少的成员，您可以在组复制开始之前设置此系统变量以匹配组成员的预期数量。
重要的
设置
在
时group_replication_auto_increment_increment
无效
。
group_replication_single_primary_modeON
当在服务器实例上启动组复制时，服务器系统变量的
auto_increment_increment值更改为该值，服务器系统变量的值auto_increment_offset
更改为服务器ID。当 Group Replication 停止时，更改将恢复。只有当每个更改的默认值为 1时，才会进行和恢复这些更改auto_increment_increment。
auto_increment_offset如果它们的值已经从默认值修改，组复制不会更改它们。在 MySQL 8.0 中，Group Replication 为单主模式时，系统变量也不会被修改，只有一台服务器写入。
group_replication_autorejoin_tries
命令行格式
--group-replication-autorejoin-tries=#
介绍
8.0.16
系统变量
group_replication_autorejoin_tries
范围
全球的
动态的
是的
SET_VAR提示适用
不
类型
整数
默认值（≥ 8.0.21）
3
默认值（≤ 8.0.20）
0
最小值
0
最大值
2016
这个系统变量的值可以在 Group Replication 运行时更改，并且更改会立即生效。当出现需要行为的问题时，将读取系统变量的当前值。
group_replication_autorejoin_triesgroup_replication_unreachable_majority_timeout
指定成员在被开除或在达到设置
之前无法联系到大多数组时自动重新加入组的尝试次数
。当达到成员的驱逐或无法到达的多数超时时，它会尝试重新加入（使用当前插件选项值），然后继续进行进一步的自动重新加入尝试，直到指定的尝试次数。自动重新加入尝试失败后，成员将等待 5 分钟才能进行下一次尝试。如果在没有成员重新加入或停止的情况下用完了指定的尝试次数，则成员继续执行
group_replication_exit_state_action
系统变量指定的操作。
直到 MySQL 8.0.20，默认设置为 0，表示成员不会尝试自动重新加入。从 MySQL 8.0.21 开始，默认设置为 3，这意味着成员会自动尝试 3 次重新加入组，每次间隔 5 分钟。您最多可以指定 2016 次尝试。
在自动重新加入尝试期间和之间，成员保持超级只读模式并且不接受写入，但仍然可以在成员上进行读取，随着时间的推移，过时读取的可能性越来越大。如果您不能容忍任何时间段的过时读取的可能性，请设置
group_replication_autorejoin_tries
为 0。有关自动重新加入功能的更多信息，以及为此选项选择值时的注意事项，请参阅
第 18.7.7.3 节，“自动重新加入” .
group_replication_bootstrap_group
命令行格式
--group-replication-bootstrap-group[={OFF|ON}]
系统变量
group_replication_bootstrap_group
范围
全球的
动态的
是的
SET_VAR提示适用
不
类型
布尔值
默认值
OFF
group_replication_bootstrap_group
配置此服务器以引导组。该系统变量只能在一台服务器上设置，并且只能在第一次启动组或重新启动整个组时设置。引导组后，将此选项设置为OFF。它应该在OFF动态和配置文件中设置。在组运行时启动两台服务器或使用此选项设置重新启动一台服务器可能会导致人为的裂脑情况，即引导两个具有相同名称的独立组。
有关首次引导组的说明，请参阅
第 18.2.1.5 节，“引导组”。有关安全引导已执行和验证事务的组的说明，请参阅
第 18.5.2 节，“重新启动组”。
group_replication_clone_threshold
命令行格式
--group-replication-clone-threshold=#
介绍
8.0.17
系统变量
group_replication_clone_threshold
范围
全球的
动态的
是的
SET_VAR提示适用
不
类型
整数
默认值
9223372036854775807
最小值
1
最大值
9223372036854775807
单元
交易
该系统变量的值可以在 Group Replication 运行时更改，但更改仅在您停止并重新启动组成员上的 Group Replication 后生效。
group_replication_clone_threshold
指定现有成员（捐赠者）和加入成员（接收者）之间的交易差距，作为交易的数量，触发使用远程克隆操作在分布式恢复过程中将状态转移到加入成员。如果加入成员和合适的捐赠者之间的事务差距超过阈值，Group Replication 将通过远程克隆操作开始分布式恢复。如果事务间隙低于阈值，或者如果远程克隆操作在技术上不可行，则组复制直接从捐赠者的二进制日志进行状态传输。
警告
不要
group_replication_clone_threshold
在活动组中使用低设置。如果在进行远程克隆操作的过程中，组内发生了超过阈值的事务数，则加入成员在重启后会再次触发远程克隆操作，并且可以无限继续下去。为避免这种情况，请确保将阈值设置为高于远程克隆操作期间您预计在组中发生的事务数。
要使用此功能，必须预先设置捐赠者和加入成员以支持克隆。有关说明，请参阅
第 18.5.4.2 节，“为分布式恢复克隆”。执行远程克隆操作时，Group Replication 会为您管理它，包括所需的服务器重启（前提是
group_replication_start_on_boot=ON
已设置）。如果没有，您必须手动重新启动服务器。远程克隆操作会替换加入成员上的现有数据字典，但是如果加入成员具有其他组成员上不存在的其他事务，则组复制会检查并且不会继续，因为这些事务将被克隆操作删除。
默认设置（这是 GTID 中事务的最大允许序列号）意味着实际上总是尝试从捐赠者的二进制日志传输状态，而不是克隆。但是，请注意，如果无法从捐助者的二进制日志传输状态，那么组复制总是尝试执行克隆操作，而不管您的阈值如何，例如因为加入成员所需的事务在任何现有的二进制日志中都不可用群成员。如果您根本不想在复制组中使用克隆，请不要在成员上安装克隆插件。
group_replication_communication_debug_options
命令行格式
--group-replication-communication-debug-options=value
系统变量
group_replication_communication_debug_options
范围
全球的
动态的
是的
SET_VAR提示适用
不
类型
细绳
默认值
GCS_DEBUG_NONE
有效值
GCS_DEBUG_NONEGCS_DEBUG_BASICGCS_DEBUG_TRACEXCOM_DEBUG_BASICXCOM_DEBUG_TRACEGCS_DEBUG_ALL
该系统变量的值可以在 Group Replication 运行时更改，但更改仅在您停止并重新启动组成员上的 Group Replication 后生效。
group_replication_communication_debug_options
配置调试消息的级别以提供不同的组复制组件，例如组通信系统 (GCS) 和组通信引擎（XCom，一种 Paxos 变体）。调试信息存储在
GCS_DEBUG_TRACE数据目录下的文件中。
可以组合指定为字符串的可用选项集。以下选项可用：
GCS_DEBUG_NONE禁用 GCS 和 XCom 的所有调试级别。
GCS_DEBUG_BASIC在 GCS 中启用基本调试信息。
GCS_DEBUG_TRACE在 GCS 中启用跟踪信息。
XCOM_DEBUG_BASIC在 XCom 中启用基本调试信息。
XCOM_DEBUG_TRACE在 XCom 中启用跟踪信息。
GCS_DEBUG_ALL为 GCS 和 XCom 启用所有调试级别。
将调试级别设置为GCS_DEBUG_NONE
仅在没有任何其他选项的情况下有效。将调试级别设置为GCS_DEBUG_ALL
覆盖所有其他选项。
group_replication_communication_max_message_size
命令行格式
--group-replication-communication-max-message-size=#
介绍
8.0.16
系统变量
group_replication_communication_max_message_size
范围
全球的
动态的
是的
SET_VAR提示适用
不
类型
整数
默认值
10485760
最小值
0
最大值
1073741824
单元
字节
该系统变量应该对所有组成员具有相同的值。当组复制正在运行时，您不能更改此系统变量的值。您必须停止组复制，更改系统变量的值，然后在每个组成员上重新启动组复制。在此过程中，允许系统变量的值在组成员之间不同，但可能会回滚组成员上的某些事务。
group_replication_communication_max_message_size
指定组复制通信的最大消息大小。大于此大小的消息会自动拆分为单独发送的片段，并由收件人重新组合。有关详细信息，请参阅
第 18.7.5 节，“消息碎片”。
默认情况下设置的最大消息大小为 10485760 字节 (10 MiB)，这意味着在 MySQL 8.0.16 版本中默认使用碎片。最大允许值与
replica_max_allowed_packet和
slave_max_allowed_packet系统变量的最大值相同，为 1073741824 字节 (1 GB)。的设置
group_replication_communication_max_message_size
必须小于
replica_max_allowed_packet或
slave_max_allowed_packet
设置，因为应用程序线程无法处理大于最大允许数据包大小的消息片段。要关闭碎片，请为 指定一个零值
group_replication_communication_max_message_size。
一个复制组的成员要使用分片，该组的通信协议版本必须是MySQL 8.0.16或以上。使用该
group_replication_get_communication_protocol()
功能可以查看群组的通讯协议版本。如果正在使用较低版本，则组成员不会对消息进行分段。如果所有群组成员都支持，您可以使用该
group_replication_set_communication_protocol()
功能将群组的通信协议设置为更高版本。有关详细信息，请参阅第 18.5.1.4 节，“设置组的通信协议版本”。
group_replication_communication_stack
介绍
8.0.27
系统变量
group_replication_communication_stack
范围
全球的
动态的
不
SET_VAR提示适用
不
类型
细绳
默认值
XCOM
有效值
XCOMMYSQL
笔记
这个系统变量实际上是一个组范围的配置设置，需要完全重启复制组才能使更改生效。
group_replication_communication_stack
指定是使用XCom通信栈还是MySQL通信栈来建立成员之间的群组通信连接。XCom 通信堆栈是 Group Replication 自己的实现，在 MySQL 8.0.27 之前的版本中始终使用，并且不支持身份验证或网络名称空间。MySQL 通信堆栈是 MySQL 服务器的本机实现，支持身份验证和网络命名空间，并可在发布后立即访问新的安全功能。一个组的所有成员必须使用相同的通信栈。
当您使用 MySQL 的通信堆栈代替 XCom 时，MySQL 服务器使用自己的身份验证和加密协议在组成员之间建立每个连接。
设置组使用MySQL的通信栈时需要额外配置；参见
第 18.6.1 节，“用于连接安全管理的通信堆栈”。
group_replication_communication_stack
实际上是组范围的配置设置，并且所有组成员的设置必须相同。但是，这不受组复制自己对组范围配置设置的检查的监管。与组中其他成员具有不同值的成员根本无法与其他成员通信，因为通信协议不兼容，因此它无法交换有关其配置设置的信息。
这意味着虽然系统变量的值可以在 Group Replication 运行时更改，并在您对组成员重新启动 Group Replication 后生效，但在更改所有成员的设置之前，该成员仍然无法重新加入组。因此，您必须在所有成员上停止组复制并更改所有成员的系统变量值，然后才能重新启动组。因为所有成员都已停止，所以需要完全重新启动组（由服务器引导
group_replication_bootstrap_group=ON）才能使值更改生效。有关从一个通信堆栈迁移到另一个通信堆栈的说明，请参阅第 18.6.1 节，“用于连接安全管理的通信堆栈”。
group_replication_components_stop_timeout
命令行格式
--group-replication-components-stop-timeout=#
系统变量
group_replication_components_stop_timeout
范围
全球的
动态的
是的
SET_VAR提示适用
不
类型
整数
默认值（≥ 8.0.27）
300
默认值（≤ 8.0.26）
31536000
最小值
2
最大值
31536000
单元
秒
该系统变量的值可以在 Group Replication 运行时更改，但更改只有在您停止并重新启动组成员上的 Group Replication 后才会生效。
group_replication_components_stop_timeout
指定 Group Replication 在关闭时等待其每个模块完成正在进行的进程的时间（以秒为单位）。组件超时在发出
STOP GROUP_REPLICATION语句后应用，这在服务器重新启动或自动重新加入期间自动发生。
超时用于解决Group Replication组件无法正常停止的情况，如果成员在处于错误状态时被驱逐出组，或者当MySQL Enterprise Backup等进程持有全局锁时，可能会发生这种情况在成员的表上。在这种情况下，成员无法停止应用程序线程或完成分布式恢复过程以重新加入。
STOP GROUP_REPLICATION在情况得到解决（例如，通过释放锁）或组件超时到期并且模块关闭（无论其状态如何）之前不会完成。
在 MySQL 8.0.27 之前，默认组件超时为 31536000 秒，即 365 天。使用此设置，组件超时在上述情况下无济于事，因此建议使用较低的设置。从 MySQL 8.0.27 开始，默认值为 300 秒，因此如果在此时间之前情况未解决，Group Replication 组件将在 5 分钟后停止，允许成员重新启动并重新加入。
group_replication_compression_threshold
命令行格式
--group-replication-compression-threshold=#
系统变量
group_replication_compression_threshold
范围
全球的
动态的
是的
SET_VAR提示适用
不
类型
整数
默认值
1000000
最小值
0
最大值
4294967295
单元
字节
该系统变量应该对所有组成员具有相同的值。可以在组复制运行时更改此系统变量的值。在停止并重新启动成员上的组复制后，更改将对每个组成员生效。在此过程中，允许系统变量的值在群组成员之间不同，但消息传递对所有成员的效率并不相同。
group_replication_compression_threshold
指定以字节为单位的阈值，超过该阈值将对组成员之间发送的消息应用压缩。如果此系统变量设置为零，则禁用压缩。
Group Replication 使用 LZ4 压缩算法来压缩组中发送的消息。请注意，LZ4 压缩算法支持的最大输入大小为 2113929216 字节。此限制低于
group_replication_compression_threshold
系统变量的最大可能值，该值与 XCom 接受的最大消息大小相匹配。使用 LZ4 压缩算法时，不要为 设置大于 2113929216 字节的值
group_replication_compression_threshold，因为启用消息压缩时无法提交超过此大小的事务。
有关详细信息，请参阅
第 18.7.4 节，“消息压缩”。
group_replication_consistency
命令行格式
--group-replication-consistency=value
介绍
8.0.14
系统变量
group_replication_consistency
范围
全局，会话
动态的
是的
SET_VAR提示适用
不
类型
枚举
默认值
EVENTUAL
有效值
EVENTUALBEFORE_ON_PRIMARY_FAILOVERBEFOREAFTERBEFORE_AND_AFTER
可以在组复制运行时更改此系统变量的值。
group_replication_consistency
是服务器系统变量而不是组复制插件特定变量，因此更改生效不需要重新启动组复制。更改系统变量的会话值立即生效，更改全局值对更改后启动的新会话生效。更改此系统变量的
GROUP_REPLICATION_ADMIN全局设置需要特权。
group_replication_consistency
控制一个组提供的事务一致性保证。您可以全局或按事务配置一致性。
group_replication_consistency
还配置单个主组中新选出的主节点使用的防护机制。对于只读 (RO) 和读写 (RW) 事务，必须考虑变量的影响。以下列表显示了此变量的可能值，以增加事务一致性保证的顺序：
EVENTUAL
RO 和 RW 事务都不会在执行前等待前面的事务被应用。这是添加此变量之前 Group Replication 的行为。RW 交易不会等待其他成员申请交易。这意味着交易可以在其他成员之前在一个成员上外部化。这也意味着在发生主节点故障转移时，新的主节点可以在之前的主节点事务全部应用之前接受新的 RO 和 RW 事务。RO 事务可能导致值过时，RW 事务可能由于冲突导致回滚。
BEFORE_ON_PRIMARY_FAILOVER
新的 RO 或 RW 事务与新选出的主节点正在应用来自旧主节点的积压将被保留（不应用）直到任何积压被应用。这确保了当发生主节点故障转移时，无论有意还是无意，客户端始终看到主节点上的最新值。这保证了一致性，但意味着客户端必须能够在应用积压的情况下处理延迟。通常这种延迟应该是最小的，但确实取决于积压的大小。
BEFORE
RW 事务在应用之前等待所有前面的事务完成。RO 事务在执行之前等待所有前面的事务完成。这通过仅影响事务的延迟来确保此事务读取最新值。通过确保仅在 RO 事务上使用同步，这减少了每个 RW 事务上同步的开销。此一致性级别还包括 . 提供的一致性保证
BEFORE_ON_PRIMARY_FAILOVER。
AFTER
RW 事务等待直到它的更改已应用到所有其他成员。此值对 RO 事务没有影响。此模式确保当在本地成员上提交事务时，任何后续事务都会读取写入的值或任何组成员上的更新值。将此模式与主要用于 RO 操作的组一起使用，以确保应用的 RW 事务在提交后随处应用。您的应用程序可以使用它来确保后续读取获取最新数据，其中包括最新写入。这减少了每个 RO 事务同步的开销，通过确保仅在 RW 事务上使用同步。此一致性级别还包括由
BEFORE_ON_PRIMARY_FAILOVER.
BEFORE_AND_AFTER
RW 事务等待 1) 所有前面的事务在应用之前完成，以及 2) 直到它的更改被应用到其他成员。RO 事务在执行之前等待所有前面的事务完成。此一致性级别还包括 . 提供的一致性保证
BEFORE_ON_PRIMARY_FAILOVER。
有关详细信息，请参阅
第 18.5.3 节，“事务一致性保证”。
group_replication_enforce_update_everywhere_checks
命令行格式
--group-replication-enforce-update-everywhere-checks[={OFF|ON}]
系统变量
group_replication_enforce_update_everywhere_checks
范围
全球的
动态的
是的
SET_VAR提示适用
不
类型
布尔值
默认值
OFF
笔记
此系统变量是组范围的配置设置，需要完全重新启动复制组才能使更改生效。
group_replication_enforce_update_everywhere_checks
为所有地方的多主更新启用或禁用严格的一致性检查。默认情况下禁用检查。在单主模式下，必须在所有组成员上禁用此选项。在多主模式下，启用此选项时，将按如下方式检查语句以确保它们与多主模式兼容：
如果一个事务在
SERIALIZABLE隔离级别下执行，那么它的提交在与组同步时会失败。
如果事务针对具有带级联约束的外键的表执行，则事务在与组同步时无法提交。
此系统变量是组范围的配置设置。它必须在所有组成员上具有相同的值，在组复制运行时不能更改，并且需要完全重新启动组（服务器引导
group_replication_bootstrap_group=ON）才能使值更改生效。有关安全引导已执行和验证事务的组的说明，请参阅
第 18.5.2 节，“重新启动组”。
如果组为此系统变量设置了值，并且加入成员为系统变量设置了不同的值，则加入成员不能加入组，直到值更改为匹配。如果群成员对该系统变量设置了值，而加入的成员不支持该系统变量，则无法加入该群。
从 MySQL 8.0.16 开始，您可以使用
group_replication_switch_to_single_primary_mode()
和
group_replication_switch_to_multi_primary_mode()
函数在组仍在运行时更改此系统变量的值。有关详细信息，请参阅
第 18.5.1.2 节，“更改组的模式”。
group_replication_exit_state_action
命令行格式
--group-replication-exit-state-action=value
介绍
8.0.12
系统变量
group_replication_exit_state_action
范围
全球的
动态的
是的
SET_VAR提示适用
不
类型
枚举
默认值（≥ 8.0.16）
READ_ONLY
默认值（≥ 8.0.12，≤ 8.0.15）
ABORT_SERVER
有效值 (≥ 8.0.18)
ABORT_SERVEROFFLINE_MODEREAD_ONLY
有效值（≥ 8.0.12，≤ 8.0.17）
ABORT_SERVERREAD_ONLY
这个系统变量的值可以在 Group Replication 运行时更改，并且更改会立即生效。当出现需要行为的问题时，将读取系统变量的当前值。
group_replication_exit_state_action
配置当此服务器实例无意中离开组时组复制的行为方式，例如在遇到应用程序错误之后，或者在失去多数的情况下，或者当组的另一个成员由于怀疑超时而将其驱逐时。成员在失去多数的情况下离开群的超时时间由
group_replication_unreachable_majority_timeout
系统变量设置，怀疑的超时时间由
group_replication_member_expel_timeout
系统变量。请注意，被开除的组成员在重新连接到组之前并不知道自己被开除了，因此只有在该成员设法重新连接或者该成员对自己产生怀疑并开除自己时才会执行指定的操作。
当组成员因怀疑超时或失去多数而被开除时，如果该成员
group_replication_autorejoin_tries
设置了系统变量以指定自动重新加入尝试的次数，则它首先在超级只读模式下进行指定次数的尝试, 然后执行由 指定的操作
group_replication_exit_state_action。如果出现应用程序错误，则不会进行自动重新加入尝试，因为这些是不可恢复的。
当
group_replication_exit_state_action
设置为 时READ_ONLY，如果成员无意中退出组或用尽其自动重新加入尝试，实例将 MySQL 切换到超级只读模式（通过将系统变量设置super_read_only
为ON）。READ_ONLY退出操作是引入系统变量之前 MySQL 8.0 版本的行为，并从 MySQL 8.0.16 开始再次成为默认行为
。
当
group_replication_exit_state_action
设置为 时OFFLINE_MODE，如果成员无意中退出组或用尽其自动重新加入尝试，则实例将 MySQL 切换到离线模式（通过将系统变量设置offline_mode为
ON）。在这种模式下，连接的客户端用户在他们的下一个请求时断开连接并且不再接受连接，具有
CONNECTION_ADMIN特权（或已弃用SUPER特权）的客户端用户除外。Group Replication 还将系统变量设置
super_read_only为
ON，因此客户端无法进行任何更新，即使它们已连接到
CONNECTION_ADMIN或
SUPER特权。这
OFFLINE_MODEMySQL 8.0.18 提供退出操作。
当
group_replication_exit_state_action
设置为 时ABORT_SERVER，如果成员无意中退出组或用尽其自动重新加入尝试，实例将关闭 MySQL。当系统变量被添加到 MySQL 8.0.15 时，此设置是 MySQL 8.0.12 的默认设置。
重要的
如果在成员成功加入组之前发生故障，则不执行指定的退出操作。如果在本地配置检查期间出现故障，或者加入成员的配置与组的配置不匹配，就会出现这种情况。在这些情况下，
super_read_only系统变量保留其原始值，继续接受连接，并且服务器不会关闭 MySQL。为了保证在Group Replication没有启动的情况下，服务器无法接受更新，因此我们建议
super_read_only=ON在启动时在服务器的配置文件中设置，Group Replication改为OFF成功启动后在主要成员上。当服务器配置为在服务器启动时启动 Group Replication ( ) 时，此保护措施尤为重要，但在使用命令
group_replication_start_on_boot=ON手动启动 Group Replication 时也很有用。START
GROUP_REPLICATION
有关使用此选项的更多信息，以及执行退出操作的情况的完整列表，请参阅
第 18.7.7.4 节，“退出操作”。
group_replication_flow_control_applier_threshold
命令行格式
--group-replication-flow-control-applier-threshold=#
系统变量
group_replication_flow_control_applier_threshold
范围
全球的
动态的
是的
SET_VAR提示适用
不
类型
整数
默认值
25000
最小值
0
最大值
2147483647
单元
交易
这个系统变量的值可以在 Group Replication 运行时更改，并且更改会立即生效。
group_replication_flow_control_applier_threshold
指定应用程序队列中触发流量控制的等待事务数。
group_replication_flow_control_certifier_threshold
命令行格式
--group-replication-flow-control-certifier-threshold=#
系统变量
group_replication_flow_control_certifier_threshold
范围
全球的
动态的
是的
SET_VAR提示适用
不
类型
整数
默认值
25000
最小值
0
最大值
2147483647
单元
交易
这个系统变量的值可以在 Group Replication 运行时更改，并且更改会立即生效。
group_replication_flow_control_certifier_threshold
指定验证者队列中触发流控制的等待事务数。
group_replication_flow_control_hold_percent
命令行格式
--group-replication-flow-control-hold-percent=#
系统变量
group_replication_flow_control_hold_percent
范围
全球的
动态的
是的
SET_VAR提示适用
不
类型
整数
默认值
10
最小值
0
最大值
100
单元
百分比
这个系统变量的值可以在 Group Replication 运行时更改，并且更改会立即生效。
group_replication_flow_control_hold_percent
定义组配额的百分比未使用以允许流量控制下的集群赶上积压。值为 0 意味着配额的任何部分都没有保留用于赶上工作积压。
group_replication_flow_control_max_commit_quota
命令行格式
--group-replication-flow-control-max-commit-quota=#
系统变量
group_replication_flow_control_max_commit_quota
范围
全球的
动态的
是的
SET_VAR提示适用
不
类型
整数
默认值
0
最小值
0
最大值
2147483647
这个系统变量的值可以在 Group Replication 运行时更改，并且更改会立即生效。
group_replication_flow_control_max_commit_quota
定义组的最大流量控制配额，或启用流量控制时任何时期的最大可用配额。值为 0 表示没有设置最大配额。该系统变量的值不能小于
group_replication_flow_control_min_quota
和
group_replication_flow_control_min_recovery_quota。
group_replication_flow_control_member_quota_percent
命令行格式
--group-replication-flow-control-member-quota-percent=#
系统变量
group_replication_flow_control_member_quota_percent
范围
全球的
动态的
是的
SET_VAR提示适用
不
类型
整数
默认值
0
最小值
0
最大值
100
单元
百分比
这个系统变量的值可以在 Group Replication 运行时更改，并且更改会立即生效。
group_replication_flow_control_member_quota_percent
定义一个成员在计算配额时应该假设自己可用的配额百分比。值为 0 表示配额应在上一时期的写入者成员之间平均分配。
group_replication_flow_control_min_quota
命令行格式
--group-replication-flow-control-min-quota=#
系统变量
group_replication_flow_control_min_quota
范围
全球的
动态的
是的
SET_VAR提示适用
不
类型
整数
默认值
0
最小值
0
最大值
2147483647
这个系统变量的值可以在 Group Replication 运行时更改，并且更改会立即生效。
group_replication_flow_control_min_quota
控制可以分配给成员的最低流量控制配额，与上一周期执行的计算的最小配额无关。值为 0 意味着没有最小配额。该系统变量的值不能大于
group_replication_flow_control_max_commit_quota。
group_replication_flow_control_min_recovery_quota
命令行格式
--group-replication-flow-control-min-recovery-quota=#
系统变量
group_replication_flow_control_min_recovery_quota
范围
全球的
动态的
是的
SET_VAR提示适用
不
类型
整数
默认值
0
最小值
0
最大值
2147483647
这个系统变量的值可以在 Group Replication 运行时更改，并且更改会立即生效。
group_replication_flow_control_min_recovery_quota
控制由于组中另一个正在恢复的成员而可以分配给成员的最低配额，与上一期间执行的计算的最小配额无关。值为 0 意味着没有最小配额。该系统变量的值不能大于
group_replication_flow_control_max_commit_quota。
group_replication_flow_control_mode
命令行格式
--group-replication-flow-control-mode=value
系统变量
group_replication_flow_control_mode
范围
全球的
动态的
是的
SET_VAR提示适用
不
类型
枚举
默认值
QUOTA
有效值
DISABLEDQUOTA
这个系统变量的值可以在 Group Replication 运行时更改，并且更改会立即生效。
group_replication_flow_control_mode
指定用于流量控制的模式。
group_replication_flow_control_period
命令行格式
--group-replication-flow-control-period=#
系统变量
group_replication_flow_control_period
范围
全球的
动态的
是的
SET_VAR提示适用
不
类型
整数
默认值
1
最小值
1
最大值
60
单元
秒
这个系统变量的值可以在 Group Replication 运行时更改，并且更改会立即生效。
group_replication_flow_control_period
定义流量控制迭代之间等待的秒数，其中发送流量控制消息并运行流量控制管理任务。
group_replication_flow_control_release_percent
命令行格式
--group-replication-flow-control-release-percent=#
系统变量
group_replication_flow_control_release_percent
范围
全球的
动态的
是的
SET_VAR提示适用
不
类型
整数
默认值
50
最小值
0
最大值
1000
单元
百分比
这个系统变量的值可以在 Group Replication 运行时更改，并且更改会立即生效。
group_replication_flow_control_release_percent
定义当流量控制不再需要限制写入者成员时应如何释放组配额，该百分比是每个流量控制周期的配额增加量。值为 0 意味着一旦流量控制阈值在限制范围内，配额将在单个流量控制迭代中释放。该范围允许配额最多以当前配额的 10 倍释放，因为这允许更大程度的适应，主要是在流量控制周期较大且配额非常小的情况下。
group_replication_force_members
命令行格式
--group-replication-force-members=value
系统变量
group_replication_force_members
范围
全球的
动态的
是的
SET_VAR提示适用
不
类型
细绳
此系统变量用于强制新的组成员身份。这个系统变量的值可以在 Group Replication 运行时更改，并且更改会立即生效。您只需为要保留在组中的组成员之一设置系统变量的值。有关您可能需要强制新组成员资格的情况的详细信息，以及使用此系统变量时要遵循的过程，请参阅
第 18.7.8 节，“处理网络分区和仲裁丢失”。
group_replication_force_members
将对等地址列表指定为逗号分隔列表，例如
host1:port1, host2:port2。任何未包含在列表中的现有成员都不会收到该组的新视图并被阻止。对于要继续作为成员的每个现有成员，您必须包括 IP 地址或主机名和端口，因为它们在
group_replication_local_address
每个成员的系统变量中给出。必须在方括号中指定 IPv6 地址。例如：
"198.51.100.44:33061,[2001:db8:85a3:8d3:1319:8a2e:370:7348]:33061,example.org:33061"
Group Replication (XCom) 的组通信引擎检查提供的 IP 地址格式是否有效，并检查您是否没有包括任何当前无法访问的组成员。否则，新配置不会得到验证，因此您必须小心只包含可访问的组成员的在线服务器。列表中任何不正确的值或无效的主机名都可能导致组被无效配置阻止。
在强制执行新的成员资格配置之前，务必确保要排除的服务器已关闭。如果不是，请在继续之前将其关闭。仍然在线的组成员可以自动形成新的配置，如果这已经发生，强制进一步的新配置可能会为组造成人为的裂脑情况。
在使用
group_replication_force_members
系统变量成功强制新的组成员身份并解除对组的阻止后，请确保清除系统变量。
group_replication_force_members
必须为空才能发出START
GROUP_REPLICATION语句。
group_replication_group_name
命令行格式
--group-replication-group-name=value
系统变量
group_replication_group_name
范围
全球的
动态的
是的
SET_VAR提示适用
不
类型
细绳
Group Replication 运行时无法更改此系统变量的值。
group_replication_group_name
指定此服务器实例所属组的名称，必须是有效的 UUID。此 UUID 构成 GTID 的一部分，当组成员从客户端接收到的事务以及组成员内部生成的视图更改事件被写入二进制日志时使用。
重要的
必须使用唯一的 UUID。
group_replication_group_seeds
命令行格式
--group-replication-group-seeds=value
系统变量
group_replication_group_seeds
范围
全球的
动态的
是的
SET_VAR提示适用
不
类型
细绳
该系统变量的值可以在 Group Replication 运行时更改，但更改仅在您停止并重新启动组成员上的 Group Replication 后生效。
group_replication_group_seeds
是一个组成员列表，加入成员可以连接到该列表以获取所有当前组成员的详细信息。加入成员使用这些详细信息来选择并连接到组成员以获得与组同步所需的数据。该列表由每个包含的种子成员的单个内部网络地址或主机名组成，如种子成员的
group_replication_local_address
系统变量（不是种子成员的 SQL 客户端连接，由 MySQL 服务器
hostname和
port系统变量指定）中配置的那样。种子成员的地址指定为逗号分隔列表，例如
host1:port1,host2:port2. 必须在方括号中指定 IPv6 地址。例如：
group_replication_group_seeds= "198.51.100.44:33061,[2001:db8:85a3:8d3:1319:8a2e:370:7348]:33061, example.org:33061"
请注意，您为此变量指定的值只有START
GROUP_REPLICATION在发出声明并且群组通信系统 (GCS) 可用后才会生效。
通常此列表包含组的所有成员，但您可以选择组成员的子集作为种子。该列表必须包含至少一个有效的成员地址。启动组复制时会验证每个地址。如果列表中不包含任何有效的成员地址，则发布
START GROUP_REPLICATION失败。
当服务器加入复制组时，它会尝试连接到其
group_replication_group_seeds
系统变量中列出的第一个种子成员。如果连接被拒绝，加入成员将尝试按顺序连接到列表中的每个其他种子成员。如果加入成员连接到种子成员但结果没有被添加到复制组（例如，因为种子成员在其白名单中没有加入成员的地址并关闭连接），加入成员继续按顺序尝试列表中剩余的种子成员。
加入成员必须使用种子成员在
group_replication_group_seeds
选项中公布的相同协议（IPv4 或 IPv6）与种子成员通信。出于组复制的 IP 地址权限的目的，种子成员的白名单必须包括种子成员提供的协议的加入成员的 IP 地址，或解析为该协议地址的主机名。除了加入成员的地址或主机名之外，还必须设置并允许此地址或主机名
group_replication_local_address
如果该地址的协议与种子成员的广告协议不匹配。如果加入成员没有适当协议的允许地址，则拒绝其连接尝试。有关详细信息，请参阅
第 18.6.4 节，“组复制 IP 地址权限”。
group_replication_gtid_assignment_block_size
命令行格式
--group-replication-gtid-assignment-block-size=#
系统变量
group_replication_gtid_assignment_block_size
范围
全球的
动态的
是的
SET_VAR提示适用
不
类型
整数
默认值
1000000
最小值
1
最大值（64 位平台）
9223372036854775807
最大值（32 位平台）
4294967295
笔记
此系统变量是组范围的配置设置，需要完全重新启动复制组才能使更改生效。
group_replication_gtid_assignment_block_size
指定为每个组成员保留的连续 GTID 的数量。每个成员消耗自己的块并在需要时保留更多。
此系统变量是组范围的配置设置。它必须在所有组成员上具有相同的值，在组复制运行时不能更改，并且需要完全重新启动组（服务器引导
group_replication_bootstrap_group=ON）才能使值更改生效。有关安全引导已执行和验证事务的组的说明，请参阅
第 18.5.2 节，“重新启动组”。
如果组为此系统变量设置了值，并且加入成员为系统变量设置了不同的值，则加入成员不能加入组，直到值更改为匹配。如果群成员对该系统变量设置了值，而加入的成员不支持该系统变量，则无法加入该群。
group_replication_ip_allowlist
命令行格式
--group-replication-ip-allowlist=value
介绍
8.0.22
系统变量
group_replication_ip_allowlist
范围
全球的
动态的
是的
SET_VAR提示适用
不
类型
细绳
默认值
AUTOMATIC
group_replication_ip_allowlist
可以从 MySQL 8.0.22 开始替换
group_replication_ip_whitelist. 从 MySQL 8.0.24 开始，可以在 Group Replication 运行时更改此系统变量的值，并且更改会立即在成员上生效。
group_replication_ip_allowlist
指定允许哪些主机连接到该组。当 XCom 通信堆栈用于组 ( group_replication_communication_stack=XCOM) 时，白名单用于控制对组的访问。当 MySQL 通信堆栈用于组 ( group_replication_communication_stack=MYSQL) 时，用户身份验证用于控制对组的访问，并且不使用允许列表，如果设置则忽略。
您为每个组成员指定的地址
group_replication_local_address
必须在复制组中的其他服务器上被允许。请注意，您为此变量指定的值只有START
GROUP_REPLICATION在发出声明并且群组通信系统 (GCS) 可用后才会生效。
默认情况下，此系统变量设置为
AUTOMATIC，它允许来自主机上活动的私有子网的连接。Group Replication (XCom) 的组通信引擎自动扫描主机上的活动接口，并识别那些地址位于私有子网上的接口。这些地址以及
localhostIPv4 和（来自 MySQL 8.0.14）IPv6 的 IP 地址用于创建组复制白名单。有关自动允许地址范围的列表，请参阅
第 18.6.4 节，“组复制 IP 地址权限”。
私有地址的自动白名单不能用于来自私有网络外部服务器的连接。对于位于不同计算机上的服务器实例之间的组复制连接，您必须提供公共 IP 地址并将这些地址指定为显式允许列表。如果您为白名单指定任何条目，则不会自动添加私有地址，因此如果您使用其中任何一个，则必须明确指定它们。localhostIP 地址是自动添加
的。
作为
group_replication_ip_allowlist
选项的值，您可以指定以下任意组合：
IPv4 地址（例如，
198.51.100.44）
带有 CIDR 表示法的 IPv4 地址（例如，
192.0.2.21/24）
IPv6 地址，来自 MySQL 8.0.14（例如，
2001:db8:85a3:8d3:1319:8a2e:370:7348）
带有 CIDR 表示法的 IPv6 地址，来自 MySQL 8.0.14（例如，2001:db8:85a3:8d3::/64）
主机名（例如，example.org）
带有 CIDR 表示法的主机名（例如，
www.example.com/24）
在 MySQL 8.0.14 之前，主机名只能解析为 IPv4 地址。从 MySQL 8.0.14 开始，主机名可以解析为 IPv4 地址、IPv6 地址或两者。如果主机名同时解析为 IPv4 和 IPv6 地址，则 IPv4 地址始终用于组复制连接。您可以将 CIDR 表示法与主机名或 IP 地址结合使用，以允许具有特定网络前缀的 IP 地址块，但请确保指定子网中的所有 IP 地址都在您的控制之下。
必须用逗号分隔白名单中的每个条目。例如：
"192.0.2.21/24,198.51.100.44,203.0.113.0/24,2001:db8:85a3:8d3:1319:8a2e:370:7348,example.org,www.example.com/24"group_replication_group_seeds
如果该组的任何种子成员在加入成员具有 IPv4 时
在选项中列出
了 IPv6 地址group_replication_local_address，反之亦然，您还必须为加入成员提供的协议设置并允许替代地址种子成员（或解析为该协议地址的主机名）。有关详细信息，请参阅
第 18.6.4 节，“组复制 IP 地址权限”。
可以根据您的安全要求为不同的组成员配置不同的白名单，例如，为了将不同的子网分开。但是，这可能会在重新配置组时导致问题。如果您没有特定的安全要求来执行其他操作，请对组的所有成员使用相同的白名单。有关详细信息，请参阅第 18.6.4 节，“组复制 IP 地址权限”。
对于主机名，仅当另一台服务器发出连接请求时才会进行名称解析。无法解析的主机名不会被考虑用于白名单验证，并且警告消息会写入错误日志。对已解析的主机名进行前向确认反向 DNS (FCrDNS) 验证。
警告
主机名本质上不如白名单中的 IP 地址安全。FCrDNS 验证提供了良好的保护级别，但可能会受到某些类型的攻击。仅在绝对必要时才在允许列表中指定主机名，并确保用于名称解析的所有组件（例如 DNS 服务器）都在您的控制之下。您还可以使用主机文件在本地实现名称解析，以避免使用外部组件。
group_replication_ip_whitelist
命令行格式
--group-replication-ip-whitelist=value
弃用
8.0.22
系统变量
group_replication_ip_whitelist
范围
全球的
动态的
是的
SET_VAR提示适用
不
类型
细绳
默认值
AUTOMATIC
从 MySQL 8.0.22 开始，
group_replication_ip_whitelist
已弃用，
group_replication_ip_allowlist
可用于替换它。对于这两个系统变量，默认值为AUTOMATIC.
在 Group Replication 启动时，如果其中一个系统变量已设置为用户定义的值而另一个尚未设置，则使用更改后的值。如果两个系统变量都已设置为用户定义的值，
group_replication_ip_allowlist
则使用的值。
如果在组复制运行时更改
group_replication_ip_whitelist
or
的值group_replication_ip_allowlist
，这在 MySQL 8.0.24 中是可能的，则两个变量都没有优先级。
新系统变量的工作方式与旧系统变量相同，只是术语发生了变化。给出的行为描述
group_replication_ip_allowlist
适用于旧系统变量和新系统变量。
group_replication_local_address
命令行格式
--group-replication-local-address=value
系统变量
group_replication_local_address
范围
全球的
动态的
是的
SET_VAR提示适用
不
类型
细绳
该系统变量的值可以在 Group Replication 运行时更改，但更改仅在您停止并重新启动组成员上的 Group Replication 后生效。
group_replication_local_address
设置成员为来自其他成员的连接提供的网络地址，指定为
host:port格式化字符串。该地址必须可以被该组的所有成员访问，因为它被组通信引擎用于组复制（XCom，一种 Paxos 变体），用于远程 XCom 实例之间的 TCP 通信。如果您正在使用 MySQL 通信堆栈在成员之间建立组通信连接 ( group_replication_communication_stack
= MYSQL)，则该地址必须是 MySQL 服务器正在侦听的 IP 地址和端口之一，由
bind_address服务器的系统变量指定。
警告
不要使用此地址查询或管理成员上的数据库。这不是 SQL 客户端连接主机和端口。
您在其中指定的地址或主机名
group_replication_local_address
被组复制用作复制组内组成员的唯一标识符。只要主机名或 IP 地址都不同，就可以为复制组的所有成员使用相同的端口，只要端口都不同，就可以为所有成员使用相同的主机名或 IP 地址。推荐的端口
group_replication_local_address
是 33061。请注意，您为此变量指定的值在START
GROUP_REPLICATION发出语句并且组通信系统 (GCS) 可用之前不会生效。
配置的网络地址
group_replication_local_address
必须可由所有组成员解析。例如，如果每个服务器实例位于具有固定网络地址的不同机器上，您可以使用机器的 IP 地址，例如 10.0.0.1。如果使用主机名，则必须使用完全限定名称，并确保它可通过 DNS、正确配置的/etc/hosts文件或其他名称解析过程进行解析。从 MySQL 8.0.14 开始，可以使用 IPv6 地址（或解析到它们的主机名）以及 IPv4 地址。必须在方括号中指定 IPv6 地址，以便区分端口号，例如：
group_replication_local_address= "[2001:db8:85a3:8d3:1319:8a2e:370:7348]:33061"
如果指定为服务器实例的组复制本地地址的主机名同时解析为 IPv4 和 IPv6 地址，则 IPv4 地址始终用于组复制连接。有关对 IPv6 网络的组复制支持以及混合使用 IPv4 的成员和使用 IPv6 的成员的复制组的更多信息，请参阅
第 18.5.5 节，“支持 IPv6 以及混合 IPv6 和 IPv4 组”。
如果您正在使用 XCom 通信堆栈在成员之间建立组通信连接（group_replication_communication_stack =
XCOM），则必须将您为每个组成员指定的地址
group_replication_local_address
添加到列表中
group_replication_ip_allowlist
（来自 MySQL 8.0.22）或
group_replication_ip_whitelist
（对于 MySQL 8.0.21 及更早版本）复制组中其他服务器上的系统变量。当 XCom 通信堆栈用于组时，白名单用于控制对组的访问。当 MySQL 通信堆栈用于组时，用户身份验证用于控制对组的访问，并且不使用白名单，如果设置，则忽略。请注意，如果该组的任何种子成员在具有 IPv6 地址的选项中列出，而
group_replication_group_seeds
该成员具有 IPv4
group_replication_local_address，反之亦然，您还必须为所需的协议（或解析为该协议地址的主机名）设置并允许该成员的替代地址。有关详细信息，请参阅
第 18.6.4 节，“组复制 IP 地址权限”。
group_replication_member_expel_timeout
命令行格式
--group-replication-member-expel-timeout=#
介绍
8.0.13
系统变量
group_replication_member_expel_timeout
范围
全球的
动态的
是的
SET_VAR提示适用
不
类型
整数
默认值（≥ 8.0.21）
5
默认值（≤ 8.0.20）
0
最小值
0
最大值 (≥ 8.0.14)
3600
最大值（≤ 8.0.13）
31536000
单元
秒
这个系统变量的值可以在 Group Replication 运行时更改，并且更改会立即生效。每当 Group Replication 检查超时时，都会读取系统变量的当前值。一个组的所有成员都不必具有相同的设置，但建议这样做以避免意外的开除。
group_replication_member_expel_timeout
指定组复制组成员在创建怀疑后等待的时间（以秒为单位），然后将怀疑失败的成员从组中驱逐出去。在产生怀疑之前的最初 5 秒检测期不计入此时间。MySQL 8.0.20及以上版本
group_replication_member_expel_timeout
默认为0，即没有等待期，5秒检测期结束后，疑似会员将立即被驱逐。从 MySQL 8.0.21 开始，该值默认为 5，这意味着在 5 秒检测期后的 5 秒内，可疑成员将被驱逐。
更改组成员的值
group_replication_member_expel_timeout
会立即对该组成员的现有和未来怀疑生效。因此，您可以将此用作强制怀疑超时并驱逐可疑成员的方法，从而允许更改组配置。有关详细信息，请参阅
第 18.7.7.1 节，“驱逐超时”。
增加 的值
group_replication_member_expel_timeout
有助于避免在较慢或不太稳定的网络上进行不必要的驱逐，或者在预期的瞬时网络中断或机器减速的情况下。如果可疑成员在怀疑超时之前再次激活，它将应用其余组成员缓冲的所有消息并输入ONLINE状态，无需操作员干预。您可以指定最长为 3600 秒（1 小时）的超时值。请务必确保 XCom 的消息缓存足够大，以包含您指定时间段内的预期消息量，加上最初的 5 秒检测期，否则成员将无法重新连接。group_replication_message_cache_size
您可以使用系统变量调整缓存大小限制
。有关详细信息，请参阅
第 18.7.6 节，“XCom 缓存管理”。
如果超过超时，嫌疑成员将在怀疑超时后立即被驱逐。如果该成员能够恢复通信并收到它被驱逐的视图，并且该成员
group_replication_autorejoin_tries
设置了系统变量以指定自动重新加入尝试的次数，则它会继续进行指定次数的尝试以重新加入该组超级只读模式。如果成员没有指定任何自动重新加入尝试，或者如果它已经用尽了指定的尝试次数，它将遵循系统变量指定的操作
group_replication_exit_state_action。
有关使用该
group_replication_member_expel_timeout
设置的更多信息，请参阅
第 18.7.7.1 节，“驱逐超时”。有关避免在此系统变量不可用时不必要的驱逐的替代缓解策略，请参阅
第 18.3.2 节，“组复制限制”。
group_replication_member_weight
命令行格式
--group-replication-member-weight=#
系统变量
group_replication_member_weight
范围
全球的
动态的
是的
SET_VAR提示适用
不
类型
整数
默认值
50
最小值
0
最大值
100
单元
百分比
这个系统变量的值可以在 Group Replication 运行时更改，并且更改会立即生效。当发生故障转移情况时，系统变量的当前值被读取。
group_replication_member_weight
指定可以分配给成员的百分比权重，以影响成员在故障转移时被选为主要成员的机会，例如，当现有主要成员离开单一主要组时。为成员分配数字权重以确保选出特定成员，例如在主要的计划维护期间或确保在发生故障转移时优先考虑某些硬件。
对于成员配置如下的组：
member-1: group_replication_member_weight=30, server_uuid=aaaa
member-2: group_replication_member_weight=40, server_uuid=bbbb
member-3: group_replication_member_weight=40, server_uuid=cccc
member-4: group_replication_member_weight=40, server_uuid=dddd
在选举新的初选期间，上述成员将被排序为member-2、
member-3、member-4和
member-1。这导致
member-2 在发生故障转移时被选为新的主节点。有关详细信息，请参阅
第 18.1.3.1 节，“单主模式”。
group_replication_message_cache_size
命令行格式
--group-replication-message-cache-size=#
介绍
8.0.16
系统变量
group_replication_message_cache_size
范围
全球的
动态的
是的
SET_VAR提示适用
不
类型
整数
默认值
1073741824 (1 GB)
最小值（64 位平台，≥ 8.0.21）
134217728 (128 MB)
最小值（64 位平台，≤ 8.0.20）
1073741824 (1 GB)
最小值（32 位平台，≥ 8.0.21）
134217728 (128 MB)
最小值（32 位平台，≤ 8.0.20）
1073741824 (1 GB)
最大值（64 位平台）
18446744073709551615 (16 EiB)
最大值（32 位平台）
315360004294967295 (4 GB)
单元
字节
该系统变量应该对所有组成员具有相同的值。可以在组复制运行时更改此系统变量的值。在停止并重新启动成员上的组复制后，更改将对每个组成员生效。在此过程中，允许系统变量的值在组成员之间不同，但成员可能在断开连接的情况下无法重新连接。
group_replication_message_cache_size
设置可用于组复制 (XCom) 的组通信引擎中消息缓存的最大内存量。XCom 消息缓存保存作为共识协议的一部分在组成员之间交换的消息（及其元数据）。在其他功能中，消息缓存用于在一段时间后无法与其他组成员通信后重新连接到组的成员恢复丢失的消息。
系统变量确定除了初始 5 秒检测期之外允许的
group_replication_member_expel_timeout
等待期（最多一小时），以便成员返回组而不是被驱逐。XCom消息缓存的大小应参考该时间段内消息的预期量来设置，使其包含会员成功返回所需的所有遗漏消息。到MySQL 8.0.20，默认只有5秒的检测期，但是从MySQL 8.0.21开始，默认是在5秒检测期之后有5秒的等待期，总时间为10秒.
考虑到 MySQL 服务器的其他缓存和对象池的大小，确保系统上有足够的内存可用于您选择的缓存大小限制。默认设置为 1073741824 字节 (1 GB)。最低设置也是 1 GB，最高为 MySQL 8.0.20。从 MySQL 8.0.21 开始，最小设置为 134217728 字节（128 MB），这使得可以在可用内存量有限且网络连接良好的主机上进行部署，以最大限度地减少组成员暂时失去连接的频率和持续时间. 请注意，使用的限制设置
group_replication_message_cache_size
仅适用于存储在缓存中的数据，并且缓存结构需要额外的 50 MB 内存。
缓存大小限制可以在运行时动态增加或减少。如果您降低缓存大小限制，XCom 将删除已确定和交付的最旧条目，直到当前大小低于限制。当当前无法访问的成员可能需要恢复的消息从消息缓存中删除时，组复制的组通信系统 (GCS) 会通过警告消息提醒您。有关调整消息缓存大小的更多信息，请参阅第 18.7.6 节，“XCom 缓存管理”。
group_replication_paxos_single_leader
命令行格式
--group-replication-paxos-single-leader[={OFF|ON}]
介绍
8.0.27
系统变量
group_replication_paxos_single_leader
范围
全球的
动态的
是的
SET_VAR提示适用
不
类型
布尔值
默认值
OFF
笔记
此系统变量是组范围的配置设置，需要完全重新启动复制组才能使更改生效。
group_replication_paxos_single_leader
从 MySQL 8.0.27 开始可用。当组处于单主模式时，它使组通信引擎能够与单个共识领导者一起运行。使用默认设置OFF，此行为被禁用，组中的每个成员都被用作领导者，这是此系统变量可用之前版本中的行为。当系统变量设置为ON时，群组通信引擎可以使用单个领导者来驱动共识。与单个共识领导者一起运行可以提高单主模式下的性能和弹性，尤其是当该组的某些次要成员当前无法访问时。有关详细信息，请参阅
第 18.7.3 节，“单一共识领导者”.
为了让群组通信引擎使用单一的共识领导者，群组的通信协议版本必须是MySQL 8.0.27或更高版本。使用该
group_replication_get_communication_protocol()
功能可以查看群组的通讯协议版本。如果正在使用较低版本，则该组不能使用此行为。如果所有群组成员都支持，您可以使用该
group_replication_set_communication_protocol()
功能将群组的通信协议设置为更高版本。有关详细信息，请参阅第 18.5.1.4 节，“设置组的通信协议版本”。
此系统变量是组范围的配置设置。它必须在所有组成员上具有相同的值，在组复制运行时不能更改，并且需要完全重新启动组（服务器引导
group_replication_bootstrap_group=ON）才能使值更改生效。有关安全引导已执行和验证事务的组的说明，请参阅
第 18.5.2 节，“重新启动组”。
如果组为此系统变量设置了值，并且加入成员为系统变量设置了不同的值，则加入成员不能加入组，直到值更改为匹配。如果群成员对该系统变量设置了值，而加入的成员不支持该系统变量，则无法加入该群。
WRITE_CONSENSUS_SINGLE_LEADER_CAPABLEPerformance Schema 表
中
的字段
replication_group_communication_information
显示该组是否支持使用单个领导者，即使
group_replication_paxos_single_leader
当前OFF在查询的成员上设置为。如果组启动时
group_replication_paxos_single_leader
设置为ON，并且其通信协议版本为 MySQL 8.0.27 或更高版本，则该字段设置为 1。
group_replication_poll_spin_loops
命令行格式
--group-replication-poll-spin-loops=#
系统变量
group_replication_poll_spin_loops
范围
全球的
动态的
是的
SET_VAR提示适用
不
类型
整数
默认值
0
最小值
0
最大值（64 位平台）
18446744073709551615
最大值（32 位平台）
4294967295
该系统变量的值可以在 Group Replication 运行时更改，但更改仅在您停止并重新启动组成员上的 Group Replication 后生效。
group_replication_poll_spin_loops
指定在线程等待更多传入网络消息之前，组通信线程等待通信引擎互斥锁释放的次数。
group_replication_recovery_complete_at
命令行格式
--group-replication-recovery-complete-at=value
系统变量
group_replication_recovery_complete_at
范围
全球的
动态的
是的
SET_VAR提示适用
不
类型
枚举
默认值
TRANSACTIONS_APPLIED
有效值
TRANSACTIONS_CERTIFIEDTRANSACTIONS_APPLIED
该系统变量的值可以在 Group Replication 运行时更改，但更改仅在您停止并重新启动组成员上的 Group Replication 后生效。
group_replication_recovery_complete_at
指定在从现有成员转移状态后处理缓存事务时在分布式恢复过程中应用的策略。您可以选择是在成员收到并验证其加入群组之前错过的所有交易后将其标记为在线 ( TRANSACTIONS_CERTIFIED)，还是仅在其收到、验证并应用这些交易后 ( ) 标记为在线TRANSACTIONS_APPLIED。
group_replication_recovery_compression_algorithms
命令行格式
--group-replication-recovery-compression-algorithms=value
介绍
8.0.18
系统变量
group_replication_recovery_compression_algorithms
范围
全球的
动态的
是的
SET_VAR提示适用
不
类型
放
默认值
uncompressed
有效值
zlibzstduncompressed
该系统变量的值可以在 Group Replication 运行时更改，但更改仅在您停止并重新启动组成员上的 Group Replication 后生效。
group_replication_recovery_compression_algorithms
指定组复制分布式恢复连接允许的压缩算法，用于从捐赠者的二进制日志进行状态传输。可用算法与
protocol_compression_algorithms
系统变量相同。有关更多信息，请参阅
第 4.2.8 节，“连接压缩控制”。
如果服务器已设置为支持克隆（请参阅第 18.5.4.2 节，“分布式恢复的克隆”）并且在分布式恢复期间使用了远程克隆操作，则
此设置不适用
。对于这种状态转移方法，克隆插件的
clone_enable_compression
设置适用。
group_replication_recovery_get_public_key
命令行格式
--group-replication-recovery-get-public-key[={OFF|ON}]
系统变量
group_replication_recovery_get_public_key
范围
全球的
动态的
是的
SET_VAR提示适用
不
类型
布尔值
默认值
OFF
该系统变量的值可以在 Group Replication 运行时更改，但更改仅在您停止并重新启动组成员上的 Group Replication 后生效。
group_replication_recovery_get_public_key
指定是否向源请求基于 RSA 密钥对的密码交换所需的公钥。如果
group_replication_recovery_public_key_path
设置为有效的公钥文件，则它优先于
group_replication_recovery_get_public_key. 如果您不使用 SSL 通过group_replication_recovery
通道 ( group_replication_recovery_use_ssl=ON) 进行分布式恢复，则此变量适用，并且组复制的复制用户帐户使用caching_sha2_password
插件进行身份验证（这是 MySQL 8.0 中的默认设置）。有关详细信息，请参阅
第 18.6.3.1.1 节，“使用缓存 SHA-2 身份验证插件复制用户”。
group_replication_recovery_public_key_path
命令行格式
--group-replication-recovery-public-key-path=file_name
系统变量
group_replication_recovery_public_key_path
范围
全球的
动态的
是的
SET_VAR提示适用
不
类型
文件名
默认值
NULL
该系统变量的值可以在 Group Replication 运行时更改，但更改仅在您停止并重新启动组成员上的 Group Replication 后生效。
group_replication_recovery_public_key_path
指定文件的路径名，该文件包含源所需的公钥副本，用于基于 RSA 密钥对的密码交换。该文件必须是 PEM 格式。如果
group_replication_recovery_public_key_path
设置为有效的公钥文件，则它优先于
group_replication_recovery_get_public_key. 如果您不使用 SSL 通过group_replication_recovery
通道进行分布式恢复（因此
group_replication_recovery_use_ssl
设置为OFF），并且组复制的复制用户帐户使用
caching_sha2_password插件（这是 MySQL 8.0 中的默认设置）或sha256_password
插件进行身份验证，则此变量适用。（对于sha256_password，设置
group_replication_recovery_public_key_path
仅适用于 MySQL 是使用 OpenSSL 构建的。）有关更多详细信息，请参阅
第 18.6.3.1.1 节，“使用缓存 SHA-2 身份验证插件复制用户”。
group_replication_recovery_reconnect_interval
命令行格式
--group-replication-recovery-reconnect-interval=#
系统变量
group_replication_recovery_reconnect_interval
范围
全球的
动态的
是的
SET_VAR提示适用
不
类型
整数
默认值
60
最小值
0
最大值
31536000
单元
秒
该系统变量的值可以在 Group Replication 运行时更改，但更改仅在您停止并重新启动组成员上的 Group Replication 后生效。
group_replication_recovery_reconnect_interval
指定当在组中找不到合适的供体以进行分布式恢复时，重新连接尝试之间的睡眠时间（以秒为单位）。
group_replication_recovery_retry_count
命令行格式
--group-replication-recovery-retry-count=#
系统变量
group_replication_recovery_retry_count
范围
全球的
动态的
是的
SET_VAR提示适用
不
类型
整数
默认值
10
最小值
0
最大值
31536000
该系统变量的值可以在 Group Replication 运行时更改，但更改仅在您停止并重新启动组成员上的 Group Replication 后生效。
group_replication_recovery_retry_count
指定正在加入的成员在放弃之前尝试连接到可用捐助者以进行分布式恢复的次数。
group_replication_recovery_ssl_ca
命令行格式
--group-replication-recovery-ssl-ca=value
系统变量
group_replication_recovery_ssl_ca
范围
全球的
动态的
是的
SET_VAR提示适用
不
类型
细绳
该系统变量的值可以在 Group Replication 运行时更改，但更改仅在您停止并重新启动组成员上的 Group Replication 后生效。
group_replication_recovery_ssl_ca
指定包含用于分布式恢复连接的受信任 SSL 证书颁发机构列表的文件的路径。
有关为分布式恢复配置 SSL 的信息，
请参阅
第 18.6.2 节“使用安全套接字层 (SSL) 保护组通信连接” 。
如果此服务器已设置为支持克隆（请参阅
第 18.5.4.2 节，“分布式恢复的克隆”），并且您已设置
group_replication_recovery_use_ssl
为ON，组复制会自动配置克隆 SSL 选项
clone_ssl_ca的设置以匹配您的设置
group_replication_recovery_ssl_ca。
当 MySQL 通信堆栈用于组 ( group_replication_communication_stack =
MYSQL) 时，此设置用于组通信连接的 TLS/SSL 配置，以及分布式恢复连接。
group_replication_recovery_ssl_capath
命令行格式
--group-replication-recovery-ssl-capath=value
系统变量
group_replication_recovery_ssl_capath
范围
全球的
动态的
是的
SET_VAR提示适用
不
类型
细绳
该系统变量的值可以在 Group Replication 运行时更改，但更改仅在您停止并重新启动组成员上的 Group Replication 后生效。
group_replication_recovery_ssl_capath
指定目录的路径，该目录包含用于分布式恢复连接的受信任的 SSL 证书颁发机构证书。
有关为分布式恢复配置 SSL 的信息，
请参阅
第 18.6.2 节“使用安全套接字层 (SSL) 保护组通信连接” 。
当 MySQL 通信堆栈用于组 ( group_replication_communication_stack =
MYSQL) 时，此设置用于组通信连接的 TLS/SSL 配置，以及分布式恢复连接。
group_replication_recovery_ssl_cert
命令行格式
--group-replication-recovery-ssl-cert=value
系统变量
group_replication_recovery_ssl_cert
范围
全球的
动态的
是的
SET_VAR提示适用
不
类型
细绳
该系统变量的值可以在 Group Replication 运行时更改，但更改仅在您停止并重新启动组成员上的 Group Replication 后生效。
group_replication_recovery_ssl_cert
指定用于为分布式恢复建立安全连接的 SSL 证书文件的名称。
有关为分布式恢复配置 SSL 的信息，
请参阅
第 18.6.2 节“使用安全套接字层 (SSL) 保护组通信连接” 。
如果此服务器已设置为支持克隆（请参阅
第 18.5.4.2 节，“分布式恢复的克隆”），并且您已设置
group_replication_recovery_use_ssl
为ON，组复制会自动配置克隆 SSL 选项
clone_ssl_cert的设置以匹配您的设置
group_replication_recovery_ssl_cert。
当 MySQL 通信堆栈用于组 ( group_replication_communication_stack =
MYSQL) 时，此设置用于组通信连接的 TLS/SSL 配置，以及分布式恢复连接。
group_replication_recovery_ssl_cipher
命令行格式
--group-replication-recovery-ssl-cipher=value
系统变量
group_replication_recovery_ssl_cipher
范围
全球的
动态的
是的
SET_VAR提示适用
不
类型
细绳
该系统变量的值可以在 Group Replication 运行时更改，但更改仅在您停止并重新启动组成员上的 Group Replication 后生效。
group_replication_recovery_ssl_cipher
指定 SSL 加密的允许密码列表。
有关为分布式恢复配置 SSL 的信息，
请参阅
第 18.6.2 节“使用安全套接字层 (SSL) 保护组通信连接” 。
当 MySQL 通信堆栈用于组 ( group_replication_communication_stack =
MYSQL) 时，此设置用于组通信连接的 TLS/SSL 配置，以及分布式恢复连接。
group_replication_recovery_ssl_crl
命令行格式
--group-replication-recovery-ssl-crl=value
系统变量
group_replication_recovery_ssl_crl
范围
全球的
动态的
是的
SET_VAR提示适用
不
类型
文件名
该系统变量的值可以在 Group Replication 运行时更改，但更改仅在您停止并重新启动组成员上的 Group Replication 后生效。
group_replication_recovery_ssl_crl
指定目录的路径，该目录包含包含证书吊销列表的文件。
有关为分布式恢复配置 SSL 的信息，
请参阅
第 18.6.2 节“使用安全套接字层 (SSL) 保护组通信连接” 。
当 MySQL 通信堆栈用于组 ( group_replication_communication_stack =
MYSQL) 时，此设置用于组通信连接的 TLS/SSL 配置，以及分布式恢复连接。
group_replication_recovery_ssl_crlpath
命令行格式
--group-replication-recovery-ssl-crlpath=value
系统变量
group_replication_recovery_ssl_crlpath
范围
全球的
动态的
是的
SET_VAR提示适用
不
类型
目录名称
该系统变量的值可以在 Group Replication 运行时更改，但更改仅在您停止并重新启动组成员上的 Group Replication 后生效。
group_replication_recovery_ssl_crlpath
指定目录的路径，该目录包含包含证书吊销列表的文件。
有关为分布式恢复配置 SSL 的信息，
请参阅
第 18.6.2 节“使用安全套接字层 (SSL) 保护组通信连接” 。
当 MySQL 通信堆栈用于组 ( group_replication_communication_stack =
MYSQL) 时，此设置用于组通信连接的 TLS/SSL 配置，以及分布式恢复连接。
group_replication_recovery_ssl_key
命令行格式
--group-replication-recovery-ssl-key=value
系统变量
group_replication_recovery_ssl_key
范围
全球的
动态的
是的
SET_VAR提示适用
不
类型
细绳
该系统变量的值可以在 Group Replication 运行时更改，但更改仅在您停止并重新启动组成员上的 Group Replication 后生效。
group_replication_recovery_ssl_key
指定用于建立安全连接的 SSL 密钥文件的名称。
有关为分布式恢复配置 SSL 的信息，
请参阅
第 18.6.2 节“使用安全套接字层 (SSL) 保护组通信连接” 。
如果此服务器已设置为支持克隆（请参阅
第 18.5.4.2 节，“分布式恢复的克隆”），并且您已设置
group_replication_recovery_use_ssl
为ON，组复制会自动配置克隆 SSL 选项
clone_ssl_key的设置以匹配您的设置
group_replication_recovery_ssl_key。
当 MySQL 通信堆栈用于组 ( group_replication_communication_stack =
MYSQL) 时，此设置用于组通信连接的 TLS/SSL 配置，以及分布式恢复连接。
group_replication_recovery_ssl_verify_server_cert
命令行格式
--group-replication-recovery-ssl-verify-server-cert[={OFF|ON}]
系统变量
group_replication_recovery_ssl_verify_server_cert
范围
全球的
动态的
是的
SET_VAR提示适用
不
类型
布尔值
默认值
OFF
该系统变量的值可以在 Group Replication 运行时更改，但更改仅在您停止并重新启动组成员上的 Group Replication 后生效。
group_replication_recovery_ssl_verify_server_cert
指定分布式恢复连接是否应检查捐赠者发送的证书中服务器的 Common Name 值。
有关为分布式恢复配置 SSL 的信息，
请参阅
第 18.6.2 节“使用安全套接字层 (SSL) 保护组通信连接” 。
当 MySQL 通信堆栈用于组 ( group_replication_communication_stack =
MYSQL) 时，此设置用于组通信连接的 TLS/SSL 配置，以及分布式恢复连接。
group_replication_recovery_tls_ciphersuites
命令行格式
--group-replication-recovery-tls-ciphersuites=value
介绍
8.0.19
系统变量
group_replication_recovery_tls_ciphersuites
范围
全球的
动态的
是的
SET_VAR提示适用
不
类型
细绳
默认值
NULL
该系统变量的值可以在 Group Replication 运行时更改，但更改仅在您停止并重新启动组成员上的 Group Replication 后生效。
group_replication_recovery_tls_ciphersuites
当 TLSv1.3 用于分布式恢复连接的连接加密时，指定一个或多个允许的密码套件的冒号分隔列表，并且此服务器实例是分布式恢复连接中的客户端，即加入成员。如果在使用 TLSv1.3 时将此系统变量设置为
NULL（如果未设置系统变量，则为默认设置），则允许默认启用的密码套件，如
第 6.3.2 节“加密连接 TLS”中所列协议和密码”. 如果此系统变量设置为空字符串，则不允许使用密码套件，因此不使用 TLSv1.3。此系统变量从 MySQL 8.0.19 开始可用。有关为分布式恢复配置 SSL 的信息，
请参阅
第 18.6.2 节，“使用安全套接字层 (SSL) 保护组通信连接” 。
当 MySQL 通信堆栈用于组 ( group_replication_communication_stack =
MYSQL) 时，此设置用于组通信连接的 TLS/SSL 配置，以及分布式恢复连接。
group_replication_recovery_tls_version
命令行格式
--group-replication-recovery-tls-version=value
介绍
8.0.19
系统变量
group_replication_recovery_tls_version
范围
全球的
动态的
是的
SET_VAR提示适用
不
类型
细绳
默认值（≥ 8.0.28）
TLSv1.2,TLSv1.3
默认值（≥ 8.0.19，≤ 8.0.27）
TLSv1,TLSv1.1,TLSv1.2,TLSv1.3
该系统变量的值可以在 Group Replication 运行时更改，但更改仅在您停止并重新启动组成员上的 Group Replication 后生效。
group_replication_recovery_tls_version
当此服务器实例是分布式恢复连接中的客户端（即加入成员）时，指定用于连接加密的一个或多个允许的 TLS 协议的逗号分隔列表。作为客户端（加入成员）和服务器（捐赠者）参与每个分布式恢复连接的组成员协商它们都设置为支持的最高协议版本。此系统变量可从 MySQL 8.0.19 获得。
当 MySQL 通信堆栈用于组 ( group_replication_communication_stack =
MYSQL) 时，此设置用于组通信连接的 TLS/SSL 配置，以及分布式恢复连接。
如果不设置该系统变量，
MySQL 8.0.27 及以下版本使用默认的“ TLSv1,TLSv1.1,TLSv1.2,TLSv1.3”
，从 MySQL 8.0.28 开始使用默认的“ TLSv1.2,TLSv1.3”。确保指定的协议版本是连续的，没有版本号从序列的中间跳过。
重要的
从 MySQL 8.0.28 开始，对 TLSv1 和 TLSv1.1 连接协议的支持已从 MySQL 服务器中删除。这些协议已从 MySQL 8.0.26 中弃用，但如果使用已弃用的 TLS 协议版本，MySQL 服务器客户端（包括充当客户端的组复制服务器实例）不会向用户返回警告。有关详细信息，请参阅
取消对 TLSv1 和 TLSv1.1 协议的支持
。
从 MySQL 8.0.16 开始，MySQL Server 支持 TLSv1.3 协议，前提是 MySQL Server 是使用 OpenSSL 1.1.1 编译的。服务器在启动时检查 OpenSSL 的版本，如果它低于 1.1.1，则从系统变量的默认值中删除 TLSv1.3。在这种情况下，默认
值为“ TLSv1,TLSv1.1,TLSv1.2”（包括 MySQL 8.0.27）和
“ TLSv1.2”（来自 MySQL 8.0.28）。
组复制支持 MySQL 8.0.18 的 TLSv1.3，支持 MySQL 8.0.19 的密码套件选择。有关详细信息，请参阅
第 18.6.2 节，“使用安全套接字层 (SSL) 保护组通信连接”
。
有关为分布式恢复配置 SSL 的信息，
请参阅
第 18.6.2 节“使用安全套接字层 (SSL) 保护组通信连接” 。
group_replication_recovery_use_ssl
命令行格式
--group-replication-recovery-use-ssl[={OFF|ON}]
系统变量
group_replication_recovery_use_ssl
范围
全球的
动态的
是的
SET_VAR提示适用
不
类型
布尔值
默认值
OFF
该系统变量的值可以在 Group Replication 运行时更改，但更改仅在您停止并重新启动组成员上的 Group Replication 后生效。
group_replication_recovery_use_ssl
指定组成员之间的组复制分布式恢复连接是否应使用 SSL。
有关为分布式恢复配置 SSL 的信息，
请参阅
第 18.6.2 节“使用安全套接字层 (SSL) 保护组通信连接” 。
如果此服务器已设置为支持克隆（请参阅
第 18.5.4.2 节，“分布式恢复的克隆”），并且您将此选项设置为ON，则组复制使用 SSL 进行远程克隆操作以及从捐赠者的二进制文件进行状态传输日志。如果将此选项设置为
OFF，Group Replication 不会将 SSL 用于远程克隆操作。
group_replication_recovery_zstd_compression_level
命令行格式
--group-replication-recovery-zstd-compression-level=#
介绍
8.0.18
系统变量
group_replication_recovery_zstd_compression_level
范围
全球的
动态的
是的
SET_VAR提示适用
不
类型
整数
默认值
3
最小值
1
最大值
22
该系统变量的值可以在 Group Replication 运行时更改，但更改仅在您停止并重新启动组成员上的 Group Replication 后生效。
group_replication_recovery_zstd_compression_level
指定用于使用
zstd压缩算法的组复制分布式恢复连接的压缩级别。允许的级别从 1 到 22，值越大表示压缩级别越高。默认
zstd压缩级别为 3。对于不使用zstd
压缩的分布式恢复连接，此变量无效。
有关更多信息，请参阅
第 4.2.8 节，“连接压缩控制”。
group_replication_single_primary_mode
命令行格式
--group-replication-single-primary-mode[={OFF|ON}]
系统变量
group_replication_single_primary_mode
范围
全球的
动态的
是的
SET_VAR提示适用
不
类型
布尔值
默认值
ON
笔记
此系统变量是组范围的配置设置，需要完全重新启动复制组才能使更改生效。
group_replication_single_primary_mode
指示该组自动选择一台服务器作为处理读/写工作负载的服务器。该服务器是主服务器，所有其他服务器都是辅助服务器。
此系统变量是组范围的配置设置。它必须在所有组成员上具有相同的值，在组复制运行时不能更改，并且需要完全重新启动组（服务器引导
group_replication_bootstrap_group=ON）才能使值更改生效。有关安全引导已执行和验证事务的组的说明，请参阅
第 18.5.2 节，“重新启动组”。
如果组为此系统变量设置了值，并且加入成员为系统变量设置了不同的值，则加入成员不能加入组，直到值更改为匹配。如果群成员对该系统变量设置了值，而加入的成员不支持该系统变量，则无法加入该群。
设置此变量会导致
忽略
ON任何设置
。group_replication_auto_increment_increment
在 MySQL 8.0.16 及更高版本中，您可以
在组仍在运行时使用group_replication_switch_to_single_primary_mode()
和
函数更改此系统变量的值。group_replication_switch_to_multi_primary_mode()有关详细信息，请参阅
第 18.5.1.2 节，“更改组的模式”。
group_replication_ssl_mode
命令行格式
--group-replication-ssl-mode=value
系统变量
group_replication_ssl_mode
范围
全球的
动态的
是的
SET_VAR提示适用
不
类型
枚举
默认值
DISABLED
有效值
DISABLEDREQUIREDVERIFY_CAVERIFY_IDENTITY
该系统变量的值可以在 Group Replication 运行时更改，但更改仅在您停止并重新启动组成员上的 Group Replication 后生效。
group_replication_ssl_mode设置组复制成员之间组通信连接的安全状态。可能的值如下：
禁用
建立未加密的连接（默认）。
必需的
如果服务器支持安全连接，则建立安全连接。
验证_CA
与 类似REQUIRED，但还根据配置的证书颁发机构 (CA) 证书验证服务器 TLS 证书。
验证身份
与 类似VERIFY_CA，但还要验证服务器证书是否与尝试连接的主机相匹配。
有关为组通信配置 SSL 的信息，
请参阅
第 18.6.2 节“使用安全套接字层 (SSL) 保护组通信连接” 。
group_replication_start_on_boot
命令行格式
--group-replication-start-on-boot[={OFF|ON}]
系统变量
group_replication_start_on_boot
范围
全球的
动态的
是的
SET_VAR提示适用
不
类型
布尔值
默认值
ON
该系统变量的值可以在 Group Replication 运行时更改，但更改仅在您停止并重新启动组成员上的 Group Replication 后生效。
group_replication_start_on_boot
指定服务器是否应在服务器启动期间自动启动组复制 ( ON) 或 ( OFF)。当您将此选项设置为 时ON，Group Replication 在远程克隆操作用于分布式恢复后自动重新启动。
要在服务器启动期间自动启动组复制，分布式恢复的用户凭据必须使用
CHANGE REPLICATION SOURCE TO|
存储在服务器上的复制元数据存储库中。CHANGE MASTER TO陈述。如果您希望在
START GROUP_REPLICATION
仅将用户凭据存储在内存中的语句中指定用户凭据，请确保将
group_replication_start_on_boot
其设置为OFF.
group_replication_tls_source
命令行格式
--group-replication-tls-source=value
介绍
8.0.21
系统变量
group_replication_tls_source
范围
全球的
动态的
是的
SET_VAR提示适用
不
类型
枚举
默认值
mysql_main
有效值
mysql_mainmysql_admin
该系统变量的值可以在 Group Replication 运行时更改，但更改仅在您停止并重新启动组成员上的 Group Replication 后生效。
group_replication_tls_source
指定组复制的 TLS 材料来源。
group_replication_transaction_size_limit
命令行格式
--group-replication-transaction-size-limit=#
系统变量
group_replication_transaction_size_limit
范围
全球的
动态的
是的
SET_VAR提示适用
不
类型
整数
默认值
150000000
最小值
0
最大值
2147483647
单元
字节
该系统变量应该对所有组成员具有相同的值。可以在组复制运行时更改此系统变量的值。更改立即对组成员生效，并从对该成员启动的下一个事务开始应用。在此过程中，允许系统变量的值在组成员之间不同，但某些交易可能会被拒绝。
group_replication_transaction_size_limit
配置复制组接受的最大事务大小（以字节为单位）。大于此大小的事务将由接收成员回滚，并且不会广播到组。大事务可能会导致复制组在内存分配方面出现问题，这可能导致系统变慢，或者在网络带宽消耗方面，这可能导致成员被怀疑失败，因为它正忙于处理大事务交易。
当此系统变量设置为 0 时，组接受的交易大小没有限制。从 MySQL 8.0 开始，此系统变量的默认设置为 150000000 字节（大约 143 MB）。根据您需要组容忍的最大消息大小调整此系统变量的值，请记住处理事务所花费的时间与其大小成正比。所有组成员的值
group_replication_transaction_size_limit
应该相同。有关大型事务的进一步缓解策略，请参阅
第 18.3.2 节，“组复制限制”。
group_replication_unreachable_majority_timeout
命令行格式
--group-replication-unreachable-majority-timeout=#
系统变量
group_replication_unreachable_majority_timeout
范围
全球的
动态的
是的
SET_VAR提示适用
不
类型
整数
默认值
0
最小值
0
最大值
31536000
单元
秒
这个系统变量的值可以在 Group Replication 运行时更改，并且更改会立即生效。当出现需要行为的问题时，将读取系统变量的当前值。
group_replication_unreachable_majority_timeout
指定遭受网络分区且无法连接到多数成员的成员在离开组之前等待的秒数。在一组 5 个服务器（S1、S2、S3、S4、S5）中，如果（S1、S2）和（S3、S4、S5）之间存在断开连接，则存在网络分区。第一组 (S1,S2) 现在处于少数状态，因为它无法联系超过一​​半的组。当大多数组（S3、S4、S5）保持运行时，少数组等待指定的时间重新连接网络。有关此场景的详细描述，请参阅
第 18.7.8 节，“处理网络分区和仲裁丢失”。
默认情况下，
group_replication_unreachable_majority_timeout
设置为 0，这意味着由于网络分区而发现自己处于少数的成员永远等待离开组。如果设置超时，当指定的时间过去后，少数派处理的所有未决事务将被回滚，少数派分区中的服务器将进入该
ERROR状态。如果会员有
group_replication_autorejoin_tries
系统变量设置为指定自动重新加入尝试的次数，它会在超级只读模式下继续进行指定次数的重新加入组的尝试。如果成员没有指定任何自动重新加入尝试，或者如果它已经用尽了指定的尝试次数，它将遵循系统变量指定的操作
group_replication_exit_state_action。
警告
当你有一个对称组时，例如只有两个成员（S0，S2），如果有网络分区并且没有多数，则在配置的超时后所有成员进入ERROR状态。
有关使用此选项的更多信息，请参阅
第 18.7.7.2 节，“无法到达的多数超时”。
group_replication_view_change_uuid
命令行格式
--group-replication-view-change-uuid=value
介绍
8.0.26
系统变量
group_replication_view_change_uuid
范围
全球的
动态的
是的
SET_VAR提示适用
不
类型
细绳
默认值
AUTOMATIC
笔记
此系统变量是组范围的配置设置，需要完全重新启动复制组才能使更改生效。
group_replication_view_change_uuid
指定一个替代 UUID，用作 GTID 中标识符的 UUID 部分，用于组生成的视图更改事件。替代 UUID 使这些内部生成的交易很容易与集团从客户那里收到的交易区分开来。如果您的设置允许在组之间进行故障转移，并且您需要识别和丢弃特定于备份组的事务，这将很有用。此系统变量的默认值为 ，这
AUTOMATIC意味着视图更改事件的 GTID 使用由
group_replication_group_name
系统变量，就像来自客户的交易一样。没有此系统变量的版本中的组成员被视为具有值AUTOMATIC。
备用 UUID 必须不同于
group_replication_group_name
系统变量指定的组名，并且必须不同于任何组成员的服务器 UUID。它也必须不同于 GTID 中使用的任何 UUID，GTID 应用于此拓扑中任何位置的复制通道上的匿名事务，使用
语句
的ASSIGN_GTIDS_TO_ANONYMOUS_TRANSACTIONS选项。CHANGE REPLICATION SOURCE
TO
此系统变量是组范围的配置设置。它必须在所有组成员上具有相同的值，在组复制运行时不能更改，并且需要完全重新启动组（服务器引导
group_replication_bootstrap_group=ON）才能使值更改生效。有关安全引导已执行和验证事务的组的说明，请参阅
第 18.5.2 节，“重新启动组”。
如果组为此系统变量设置了值，并且加入成员为系统变量设置了不同的值，则加入成员不能加入组，直到值更改为匹配。如果群成员对该系统变量设置了值，而加入的成员不支持该系统变量，则无法加入该群。
组复制状态变量
本节介绍提供有关组复制信息的状态变量。该变量具有以下含义：
group_replication_primary_member
当组在单主模式下运行时显示主要成员的 UUID。如果组在多主模式下运行，则显示空字符串。
警告
status 变量已被弃用，group_replication_primary_member
并计划在未来的版本中删除。
请参阅第 18.1.3.1.2 节，“查找主节点”。
© Mysql 中文网
