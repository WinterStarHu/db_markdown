# 27.3 性能模式启动配置_MySQL 8.0 参考手册

27.3 性能模式启动配置_MySQL 8.0 参考手册
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
第十九章MySQL Shell
第 20 章使用 MySQL 作为文档存储
第21章InnoDB Cluster
第 22 章 InnoDB 副本集
第 23 章 MySQL NDB Cluster 8.0
第24章分区
第25章存储对象
第 26 章 INFORMATION_SCHEMA 表
第 27 章 MySQL 性能模式
27.1 性能模式快速入门
27.2 性能模式构建配置
27.3 性能模式启动配置
27.4 性能模式运行时配置
27.5 性能模式查询
27.6 性能模式工具命名约定
27.7 性能模式状态监控
27.8 性能模式原子和分子事件
27.9 当前和历史事件的性能模式表
27.10 性能模式语句摘要和采样
27.11 性能模式总表特征
27.12 性能模式表描述
27.13 性能模式选项和变量引用
27.14 性能模式命令选项
27.15 性能模式系统变量
27.16 性能模式状态变量
27.17性能模式内存分配模型
27.18 性能模式和插件
27.19 使用性能模式诊断问题
27.20 性能模式的限制
第 28 章 MySQL 系统模式
第 29 章连接器和 API
第30章MySQL企业版
第31章MySQL工作台
第 32 章 OCI 市场上的 MySQL
附录 A MySQL 8.0 常见问题解答
附录 B 错误信息和常见问题
附录 C 索引
MySQL 词汇表
MySQL 8.0 参考手册  / 第 27 章 MySQL 性能模式  /
27.3 性能模式启动配置
27.3 性能模式启动配置
要使用 MySQL Performance Schema，必须在服务器启动时启用它以启用事件收集。
默认情况下启用性能模式。要显式启用或禁用它，请将
performance_schema变量设置为适当的值来启动服务器。例如，在服务器my.cnf文件中使用这些行：
[mysqld]
performance_schema=ON
如果服务器在 Performance Schema 初始化期间无法分配任何内部缓冲区，则 Performance Schema 将自身禁用并设置
performance_schema为
OFF，并且服务器在没有检测的情况下运行。
性能模式还允许在服务器启动时配置仪器和消费者。
要在服务器启动时控制仪器，请使用以下形式的选项：
--performance-schema-instrument='instrument_name=value'
这里，instrument_name是一个仪器名称，例如wait/synch/mutex/sql/LOCK_open，value是以下值之一：
OFF, FALSE, 或
0: 禁用仪器
ON, TRUE, 或
1: 启用仪器并计时
COUNTED：启用并计算（而不是时间）仪器
每个
--performance-schema-instrument
选项只能指定一个仪器名称，但可以给出该选项的多个实例以配置多个仪器。此外，仪器名称中允许使用模式来配置与模式匹配的仪器。要将所有条件同步工具配置为启用和计数，请使用此选项：
--performance-schema-instrument='wait/synch/cond/%=COUNTED'
要禁用所有仪器，请使用此选项：
--performance-schema-instrument='%=OFF'
例外：memory/performance_schema/%
仪器是内置的，不能在启动时禁用。
较长的乐器名称字符串优先于较短的模式名称，无论顺序如何。有关指定模式以选择工具的信息，请参阅
第 27.4.9 节，“为过滤操作命名工具或消费者”。
无法识别的仪器名称将被忽略。稍后安装的插件可能会创建仪器，此时名称会被识别和配置。
要在服务器启动时控制消费者，请使用以下形式的选项：
--performance-schema-consumer-consumer_name=value
这里，consumer_name是消费者名称，例如events_waits_history，
value是以下值之一：
OFF, FALSE, or
0：不为消费者收集事件
ON, TRUE, or
1: 为消费者收集事件
例如，要启用events_waits_history
消费者，请使用此选项：
--performance-schema-consumer-events-waits-history=ON
可以通过检查该
setup_consumers表找到允许的消费者名称。不允许使用图案。表中的消费者名称
setup_consumers使用下划线，但对于启动时设置的消费者，名称中的破折号和下划线是等效的。
性能模式包括几个提供配置信息的系统变量：
mysql> SHOW VARIABLES LIKE 'perf%';
+--------------------------------------------------------+---------+
| Variable_name                                          | Value   |
+--------------------------------------------------------+---------+
| performance_schema                                     | ON      |
| performance_schema_accounts_size                       | 100     |
| performance_schema_digests_size                        | 200     |
| performance_schema_events_stages_history_long_size     | 10000   |
| performance_schema_events_stages_history_size          | 10      |
| performance_schema_events_statements_history_long_size | 10000   |
| performance_schema_events_statements_history_size      | 10      |
| performance_schema_events_waits_history_long_size      | 10000   |
| performance_schema_events_waits_history_size           | 10      |
| performance_schema_hosts_size                          | 100     |
| performance_schema_max_cond_classes                    | 80      |
| performance_schema_max_cond_instances                  | 1000    |
...
该performance_schema变量是ONorOFF以指示性能模式是启用还是禁用。其他变量指示表大小（行数）或内存分配值。
笔记
启用性能模式后，性能模式实例的数量可能会在很大程度上影响服务器内存占用。性能模式自动缩放许多参数以仅在需要时使用内存；参见
第 27.17 节，“性能模式内存分配模型”。
要更改 Performance Schema 系统变量的值，请在服务器启动时设置它们。例如，将以下行放入
my.cnf文件中以更改等待事件历史表的大小：
[mysqld]
performance_schema
performance_schema_events_waits_history_size=20
performance_schema_events_waits_history_long_size=15000
如果未明确设置，性能模式会在服务器启动时自动调整其几个参数的值。例如，它以这种方式调整控制事件等待表大小的参数。Performance Schema 增量分配内存，将其内存使用扩展到实际服务器负载，而不是在服务器启动期间分配它需要的所有内存。因此，根本不需要设置许多大小调整参数。要查看哪些参数是自动调整大小或自动缩放的，请使用mysqld --verbose --help并检查选项描述，或参阅
第 27.15 节，“性能模式系统变量”。
对于服务器启动时未设置的每个自动调整参数，性能模式根据以下系统值确定如何设置其值，这些值被视为
有关如何配置 MySQL 服务器
的“提示” ：max_connections
open_files_limit
table_definition_cache
table_open_cache
要覆盖给定参数的自动调整大小或自动缩放，请在启动时将其设置为 −1 以外的值。在这种情况下，性能模式为其分配指定的值。
在运行时，SHOW VARIABLES显示自动调整参数设置的实际值。自动缩放的参数显示值为 −1。
如果 Performance Schema 被禁用，它的 autosized 和 autoscaled 参数保持设置为 -1 并
SHOW VARIABLES显示 -1。
© Mysql 中文网
