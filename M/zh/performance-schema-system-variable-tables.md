# 27.12.14 性能模式系统变量表_MySQL 8.0 参考手册

27.12.14 性能模式系统变量表_MySQL 8.0 参考手册
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
27.12.1 性能模式表参考1
27.12.2 性能模式设置表1
27.12.3 性能模式实例表1
27.12.4 性能模式等待事件表1
27.12.5 性能模式阶段事件表1
27.12.6 性能模式语句事件表1
27.12.7 性能模式事务表1
27.12.8 性能模式连接表1
27.12.9 性能模式连接属性表1
27.12.10 性能模式用户定义的变量表1
27.12.11 性能模式复制表1
27.12.12 Performance Schema NDB 集群表1
27.12.13 性能模式锁表1
27.12.14 性能模式系统变量表1
27.12.14.1 性能模式 persisted_variables 表
27.12.14.2 性能模式 variables_info 表
27.12.15 性能模式状态变量表1
27.12.16 性能模式线程池表1
27.12.17 性能模式防火墙表1
27.12.18 性能模式密钥环表1
27.12.19 性能模式克隆表1
27.12.20 性能模式汇总表1
27.12.21 性能模式杂表1
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
MySQL 8.0 参考手册  / 第 27 章 MySQL 性能模式  / 27.12 性能模式表描述  /
27.12.14 性能模式系统变量表
27.12.14 性能模式系统变量表
27.12.14.1 性能模式 persisted_variables 表27.12.14.2 性能模式 variables_info 表
MySQL 服务器维护许多指示其配置方式的系统变量（请参阅
第 5.1.8 节，“服务器系统变量”）。这些性能模式表中提供了系统变量信息：
global_variables：全局系统变量。只需要全局值的应用程序应该使用此表。
session_variables：当前会话的系统变量。需要其自己的会话的所有系统变量值的应用程序应使用此表。它包括其会话的会话变量，以及没有会话对应项的全局变量的值。
variables_by_thread：每个活动会话的会话系统变量。想要了解特定会话的会话变量值的应用程序应该使用此表。它仅包含会话变量，由线程 ID 标识。
persisted_variablesmysqld-auto.cnf
：为存储持久全局系统变量设置的文件提供 SQL 接口。请参阅
第 27.12.14.1 节，“性能模式 persisted_variables 表”。
variables_info：为每个系统变量显示最近设置它的来源及其值的范围。请参阅
第 27.12.14.2 节，“性能模式 variables_info 表”。
SENSITIVE_VARIABLES_OBSERVER
需要权限才能查看这些表中敏感系统变量的值
。
会话变量表 ( session_variables,
variables_by_thread) 仅包含活动会话的信息，不包含终止会话的信息。
global_variables和
session_variables表有以下列
：
VARIABLE_NAME
系统变量名称。
VARIABLE_VALUE
系统变量值。对于
global_variables，此列包含全局值。对于
session_variables，此列包含对当前会话有效的变量值。
global_variables和
表具有
以下session_variables索引：
VARIABLE_NAME( )
上的主键
该variables_by_thread表有以下列：
THREAD_ID
定义系统变量的会话的线程标识符。
VARIABLE_NAME
系统变量名称。
VARIABLE_VALUE
列命名的会话的会话变量值
THREAD_ID。
该variables_by_thread表具有以下索引：
THREAD_ID( ,
VARIABLE_NAME)
上的主键
该variables_by_thread表仅包含有关前台线程的系统变量信息。如果不是所有线程都由性能模式检测，则此表会丢失一些行。在这种情况下，
Performance_schema_thread_instances_lost
状态变量大于零。
TRUNCATE TABLEPerformance Schema 系统变量表不支持。
© Mysql 中文网
