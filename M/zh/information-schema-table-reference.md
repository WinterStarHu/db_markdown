# 26.2 INFORMATION_SCHEMA 表参考_MySQL 8.0 参考手册

26.2 INFORMATION_SCHEMA 表参考_MySQL 8.0 参考手册
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
26.1 简介
26.2 INFORMATION_SCHEMA 表参考
26.3 INFORMATION_SCHEMA 总表
26.4 INFORMATION_SCHEMA InnoDB 表
26.5 INFORMATION_SCHEMA线程池表
26.6 INFORMATION_SCHEMA 连接控制表
26.7 INFORMATION_SCHEMA MySQL 企业防火墙表
26.8 SHOW 语句的扩展
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
MySQL 8.0 参考手册  / 第 26 章 INFORMATION_SCHEMA 表  /
26.2 INFORMATION_SCHEMA 表参考
26.2 INFORMATION_SCHEMA 表参考
下表总结了所有可用的
INFORMATION_SCHEMA表格。有关更多详细信息，请参阅各个表的说明。
表 26.1 INFORMATION_SCHEMA 表
表名
描述
介绍
弃用
ADMINISTRABLE_ROLE_AUTHORIZATIONS
当前用户或角色的可授予用户或角色
8.0.19
APPLICABLE_ROLES
当前用户的适用角色
8.0.19
CHARACTER_SETS
可用字符集
CHECK_CONSTRAINTS
表和列 CHECK 约束
8.0.16
COLLATION_CHARACTER_SET_APPLICABILITY
适用于每个排序规则的字符集
COLLATIONS
每个字符集的排序规则
COLUMN_PRIVILEGES
在列上定义的权限
COLUMN_STATISTICS
列值的直方图统计
COLUMNS
每个表中的列
COLUMNS_EXTENSIONS
主要和次要存储引擎的列属性
8.0.21
CONNECTION_CONTROL_FAILED_LOGIN_ATTEMPTS
每个帐户的当前连续失败连接尝试次数
ENABLED_ROLES
当前会话中启用的角色
8.0.19
ENGINES
存储引擎属性
EVENTS
事件管理器事件
FILES
存储表空间数据的文件
INNODB_BUFFER_PAGE
InnoDB 缓冲池中的页面
INNODB_BUFFER_PAGE_LRU
InnoDB 缓冲池中页面的 LRU 排序
INNODB_BUFFER_POOL_STATS
InnoDB 缓冲池统计信息
INNODB_CACHED_INDEXES
InnoDB 缓冲池中每个索引缓存的索引页数
INNODB_CMP
与压缩 InnoDB 表相关的操作状态
INNODB_CMP_PER_INDEX
与压缩 InnoDB 表和索引相关的操作状态
INNODB_CMP_PER_INDEX_RESET
与压缩 InnoDB 表和索引相关的操作状态
INNODB_CMP_RESET
与压缩 InnoDB 表相关的操作状态
INNODB_CMPMEM
InnoDB 缓冲池中压缩页面的状态
INNODB_CMPMEM_RESET
InnoDB 缓冲池中压缩页面的状态
INNODB_COLUMNS
每个 InnoDB 表中的列
INNODB_DATAFILES
InnoDB file-per-table 和通用表空间的数据文件路径信息
INNODB_FIELDS
InnoDB 索引的关键列
INNODB_FOREIGN
InnoDB 外键元数据
INNODB_FOREIGN_COLS
InnoDB 外键列状态信息
INNODB_FT_BEING_DELETED
INNODB_FT_DELETED 表的快照
INNODB_FT_CONFIG
InnoDB 表 FULLTEXT 索引的元数据及相关处理
INNODB_FT_DEFAULT_STOPWORD
InnoDB FULLTEXT 索引的默认停用词列表
INNODB_FT_DELETED
从 InnoDB 表 FULLTEXT 索引中删除的行
INNODB_FT_INDEX_CACHE
InnoDB FULLTEXT 索引中新插入行的标记信息
INNODB_FT_INDEX_TABLE
用于处理针对 InnoDB 表 FULLTEXT 索引的文本搜索的倒排索引信息
INNODB_INDEXES
InnoDB 索引元数据
INNODB_METRICS
InnoDB 性能信息
INNODB_SESSION_TEMP_TABLESPACES
会话临时表空间元数据
8.0.13
INNODB_TABLES
InnoDB 表元数据
INNODB_TABLESPACES
InnoDB file-per-table、general 和 undo 表空间元数据
INNODB_TABLESPACES_BRIEF
每个表的简要文件、一般、撤消和系统表空间元数据
INNODB_TABLESTATS
InnoDB 表低级状态信息
INNODB_TEMP_TABLE_INFO
有关活动的用户创建的 InnoDB 临时表的信息
INNODB_TRX
活跃的 InnoDB 事务信息
INNODB_VIRTUAL
InnoDB 虚拟生成的列元数据
KEY_COLUMN_USAGE
哪些键列有约束
KEYWORDS
MySQL关键字
MYSQL_FIREWALL_USERS
帐户配置文件的防火墙内存数据
8.0.26
MYSQL_FIREWALL_WHITELIST
帐户配置文件白名单的防火墙内存数据
8.0.26
ndb_transid_mysql_connection_map
新开发银行交易信息
OPTIMIZER_TRACE
优化器跟踪活动产生的信息
PARAMETERS
存储例程参数和存储函数返回值
PARTITIONS
表分区信息
PLUGINS
插件信息
PROCESSLIST
有关当前正在执行的线程的信息
PROFILING
报表分析信息
REFERENTIAL_CONSTRAINTS
外键信息
RESOURCE_GROUPS
资源组信息
ROLE_COLUMN_GRANTS
当前启用的角色可用或授予的角色的列特权
8.0.19
ROLE_ROUTINE_GRANTS
当前启用的角色可用或授予的角色的例行特权
8.0.19
ROLE_TABLE_GRANTS
当前启用的角色可用或授予的角色的表权限
8.0.19
ROUTINES
存储例程信息
SCHEMA_PRIVILEGES
架构上定义的权限
SCHEMATA
架构信息
SCHEMATA_EXTENSIONS
架构选项
8.0.22
ST_GEOMETRY_COLUMNS
每个表中存储空间数据的列
ST_SPATIAL_REFERENCE_SYSTEMS
可用的空间参考系统
ST_UNITS_OF_MEASURE
ST_Distance() 可接受的单位
8.0.14
STATISTICS
表索引统计
TABLE_CONSTRAINTS
哪些表有约束
TABLE_CONSTRAINTS_EXTENSIONS
主要和次要存储引擎的表约束属性
8.0.21
TABLE_PRIVILEGES
在表上定义的权限
TABLES
表信息
TABLES_EXTENSIONS
主要和次要存储引擎的表属性
8.0.21
TABLESPACES
表空间信息
TABLESPACES_EXTENSIONS
主存储引擎的表空间属性
8.0.21
TP_THREAD_GROUP_STATE
线程池线程组状态
TP_THREAD_GROUP_STATS
线程池线程组统计
TP_THREAD_STATE
线程池线程信息
TRIGGERS
触发信息
USER_ATTRIBUTES
用户评论和属性
8.0.21
USER_PRIVILEGES
每个用户全局定义的权限
VIEW_ROUTINE_USAGE
视图中使用的存储函数
8.0.13
VIEW_TABLE_USAGE
视图中使用的表和视图
8.0.13
VIEWS
查看资料
© Mysql 中文网
