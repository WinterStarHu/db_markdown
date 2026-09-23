# 27.12.12 Performance Schema NDB 集群表_MySQL 8.0 参考手册

27.12.12 Performance Schema NDB 集群表_MySQL 8.0 参考手册
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
27.12.12.1 ndb_sync_pending_objects 表
27.12.12.2 ndb_sync_excluded_objects 表
27.12.13 性能模式锁表1
27.12.14 性能模式系统变量表1
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
27.12.12 Performance Schema NDB 集群表
27.12.12 Performance Schema NDB 集群表
27.12.12.1 ndb_sync_pending_objects 表27.12.12.2 ndb_sync_excluded_objects 表
下表显示了与NDBCLUSTER存储引擎相关的所有 Performance Schema 表。
表 27.3 Performance Schema NDB 表
表名
描述
介绍
ndb_sync_excluded_objects
无法同步的 NDB 对象
8.0.21
ndb_sync_pending_objects
等待同步的 NDB 对象
8.0.21
从 NDB 8.0.16 开始，自动同步
NDB尝试自动检测和同步 NDB Cluster 的内部字典和 MySQL 服务器的数据字典之间元数据中的所有不匹配。默认情况下，这是在系统变量确定的固定时间间隔内在后台完成的
ndb_metadata_check_interval
，除非使用禁用
ndb_metadata_check或设置覆盖
ndb_metadata_sync。在 NDB 8.0.21 之前，用户可以轻松访问的有关此过程的唯一信息是以日志消息和可用对象计数的形式（从 NDB 8.0.18 开始）作为状态变量
Ndb_metadata_detected_count，
Ndb_metadata_synced_count和
Ndb_metadata_excluded_count
（在 NDB 8.0.22 之前，这个变量被命名为
Ndb_metadata_blacklist_size）。从 NDB 8.0.21 开始，有关自动同步当前状态的更多详细信息由充当 NDB Cluster 中 SQL 节点的 MySQL 服务器在这两个 Performance Schema 表中公开：
ndb_sync_pending_objects：显示字典与MySQL数据字典NDB
不匹配的数据库对象信息。NDB尝试同步此类对象时，NDB从等待同步的队列和此表中删除对象，并尝试协调不匹配。NDB如果对象的同步由于临时错误而失败，则在下次执行不匹配检测时将其拾取并添加回队列（和此表） ；如果尝试由于永久性错误而失败，则将对象添加到
ndb_sync_excluded_objects
表中。
ndb_sync_excluded_objects：显示由于不匹配导致的永久性错误导致自动同步失败的数据库对象的信息NDB
，如果没有手动干预就无法协调这些错误；这些对象被列入黑名单，在完成之前不会再次考虑进行不匹配检测。
只有当MySQL 为存储引擎
启用了支持时，表ndb_sync_pending_objects和
ndb_sync_excluded_objects表才会出现
。NDBCLUSTER
这些表在以下两节中有更详细的描述。
© Mysql 中文网
