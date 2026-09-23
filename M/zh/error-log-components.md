# 5.5.3 错误日志组件_MySQL 8.0 参考手册

5.5.3 错误日志组件_MySQL 8.0 参考手册
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
5.2 MySQL数据目录
5.3 mysql系统架构
5.4 MySQL 服务器日志
5.5 MySQL组件
5.5.1 安装和卸载组件1
5.5.2 获取组件信息1
5.5.3 错误日志组件1
5.5.4 查询属性组件1
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
MySQL 8.0 参考手册  / 第 5 章 MySQL 服务器管理  / 5.5 MySQL组件  /
5.5.3 错误日志组件
5.5.3 错误日志组件
本节介绍各个错误日志组件的特征。有关配置错误日志记录的一般信息，请参阅第 5.4.2 节，“错误日志”。
日志组件可以是过滤器或接收器：
过滤器处理日志事件，以添加、删除或修改事件字段，或完全删除事件。生成的事件传递到已启用组件列表中的下一个日志组件。
接收器是日志事件的目的地（写入器）。通常，接收器将日志事件处理成具有特定格式的日志消息，并将这些消息写入其关联的输出，例如文件或系统日志。sink 也可以写入 Performance Schema
error_log表；参见
第 27.12.21.1 节，“error_log 表”。事件未经修改地传递到已启用组件列表中的下一个日志组件（即，尽管接收器格式化事件以生成输出消息，但它不会在事件在内部传递到下一个组件时修改事件）。
log_error_services系统变量值列出启用的日志组件
。未在列表中命名的组件被禁用。从 MySQL 8.0.30 开始，
log_error_services如果尚未加载错误日志组件，也会隐式加载它们。有关详细信息，请参阅
第 5.4.2.1 节，“错误日志配置”。
以下部分描述了各个日志组件，按组件类型分组：
过滤错误日志组件接收器错误日志组件
组件描述包括以下类型的信息：
组件名称和预期用途。
组件是内置的还是必须加载的。INSTALL COMPONENT对于可加载组件，描述指定使用和
UNINSTALL COMPONENT语句显式加载或卸载组件时要使用的 URN
。隐式加载错误日志组件只需要组件名称。有关详细信息，请参阅
第 5.4.2.1 节，“错误日志配置”。
该组件是否可以在值中多次列出
log_error_services。
对于接收器组件，组件将输出写入的目标。
对于接收器组件，它是否支持性能模式error_log
表的接口。
过滤错误日志组件
错误日志过滤器组件实现错误日志事件的过滤。如果没有启用过滤器组件，则不会发生过滤。
任何已启用的过滤器组件只会影响值后面列出的组件的日志事件
log_error_services。特别是，对于任何
log_error_services过滤器组件之前列出的任何日志接收器组件，都不会发生日志事件过滤。
log_filter_internal 组件
log_error_verbosity用途：结合和
log_error_suppression_list
系统变量
，实现基于日志事件优先级和错误码的过滤
。请参阅
第 5.4.2.5 节，“基于优先级的错误日志过滤 (log_filter_internal)”。
URN：该组件是内置的，不需要加载。
允许多次使用：否。
如果log_filter_internal被禁用，
log_error_verbosity则
log_error_suppression_list没有任何效果。
log_filter_dragnet 组件
用途：根据
dragnet.log_error_filter_rules
系统变量设置定义的规则实现过滤。请参阅
第 5.4.2.6 节，“基于规则的错误日志过滤 (log_filter_dragnet)”。
瓮：file://component_log_filter_dragnet
允许多次使用：否。
接收器错误日志组件
错误日志接收器组件是实现错误日志输出的编写器。如果没有开启sink组件，则不会有日志输出。
一些接收器组件描述引用默认错误日志目标。这是控制台或文件，由系统变量的值指示log_error
，如
第 5.4.2.2 节“默认错误日志目标配置”中所述确定。
log_sink_internal 组件
目的：实现传统的错误日志消息输出格式。
URN：该组件是内置的，不需要加载。
允许多次使用：否。
输出目的地：写入默认错误日志目的地。
性能模式支持：写入
error_log表。提供一个解析器，用于读取由以前的服务器实例创建的错误日志文件。
log_sink_json 组件
目的：实现 JSON 格式的错误记录。请参阅
第 5.4.2.7 节，“以 JSON 格式记录错误”。
瓮：file://component_log_sink_json
允许多次使用：是的。
log_error输出目的地：此接收器根据系统变量
给出的默认错误日志目的地确定其输出目的地
：
如果log_error命名一个文件，接收器基于该文件名的输出文件命名，加上一个数字
后缀，从 00 开始。例如，如果
是
，则值中命名的连续实例
写入
，
等等。
.NN.jsonNNlog_errorfile_namelog_sink_jsonlog_error_servicesfile_name.00.jsonfile_name.01.json
如果log_error是
stderr，接收器将写入控制台。如果log_sink_json在值中多次命名
log_error_services
，它们都会写入控制台，这可能没有用。
性能模式支持：写入
error_log表。提供一个解析器，用于读取由以前的服务器实例创建的错误日志文件。
log_sink_syseventlog 组件
目的：实现错误记录到系统日志。syslog这是 Windows、 Unix 和类 Unix 系统上的事件日志。请参阅
第 5.4.2.8 节，“错误记录到系统日志”。
瓮：
file://component_log_sink_syseventlog
允许多次使用：否。
输出目的地：写入系统日志。不使用默认错误日志目标。
性能模式支持：不写入
error_log表。不提供用于读取以前服务器实例创建的错误日志文件的解析器。
log_sink_test 组件
目的：用于内部编写测试用例，不用于生产。
瓮：file://component_log_sink_test
接收器属性（例如是否允许多次使用和输出目标）未指定，
log_sink_test因为如前所述，它供内部使用。因此，其行为随时可能发生变化。
© Mysql 中文网
