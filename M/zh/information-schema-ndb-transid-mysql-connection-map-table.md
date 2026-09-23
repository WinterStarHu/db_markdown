# 26.3.18 INFORMATION_SCHEMA ndb_transid_mysql_connection_map 表_MySQL 8.0 参考手册

26.3.18 INFORMATION_SCHEMA ndb_transid_mysql_connection_map 表_MySQL 8.0 参考手册
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
26.3.1 INFORMATION_SCHEMA 通用表参考1
26.3.2 INFORMATION_SCHEMA ADMINISTRABLE_ROLE_AUTHORIZATIONS 表1
26.3.3 INFORMATION_SCHEMA APPLICABLE_ROLES 表1
26.3.4 INFORMATION_SCHEMA CHARACTER_SETS 表1
26.3.5 INFORMATION_SCHEMA CHECK_CONSTRAINTS 表1
26.3.6 INFORMATION_SCHEMA COLLATIONS 表1
26.3.7 INFORMATION_SCHEMA COLLATION_CHARACTER_SET_APPLICABILITY 表1
26.3.8 INFORMATION_SCHEMA COLUMNS 表1
26.3.9 INFORMATION_SCHEMA COLUMNS_EXTENSIONS 表1
26.3.10 INFORMATION_SCHEMA COLUMN_PRIVILEGES 表1
26.3.11 INFORMATION_SCHEMA COLUMN_STATISTICS 表1
26.3.12 INFORMATION_SCHEMA ENABLED_ROLES 表1
26.3.13 INFORMATION_SCHEMA 引擎表1
26.3.14 INFORMATION_SCHEMA 事件表1
26.3.15 INFORMATION_SCHEMA 文件表1
26.3.16 INFORMATION_SCHEMA KEY_COLUMN_USAGE 表1
26.3.17 INFORMATION_SCHEMA KEYWORDS 表1
26.3.18 INFORMATION_SCHEMA ndb_transid_mysql_connection_map 表1
26.3.19 INFORMATION_SCHEMA OPTIMIZER_TRACE 表1
26.3.20 INFORMATION_SCHEMA 参数表1
26.3.21 INFORMATION_SCHEMA 分区表1
26.3.22 INFORMATION_SCHEMA PLUGINS 表1
26.3.23 INFORMATION_SCHEMA PROCESSLIST 表1
26.3.24 INFORMATION_SCHEMA PROFILING 表1
26.3.25 INFORMATION_SCHEMA REFERENTIAL_CONSTRAINTS 表1
26.3.26 INFORMATION_SCHEMA RESOURCE_GROUPS 表1
26.3.27 INFORMATION_SCHEMA ROLE_COLUMN_GRANTS 表1
26.3.28 INFORMATION_SCHEMA ROLE_ROUTINE_GRANTS 表1
26.3.29 INFORMATION_SCHEMA ROLE_TABLE_GRANTS 表1
26.3.30 INFORMATION_SCHEMA ROUTINES 表1
26.3.31 INFORMATION_SCHEMA SCHEMATA 表1
26.3.32 INFORMATION_SCHEMA SCHEMATA_EXTENSIONS 表1
26.3.33 INFORMATION_SCHEMA SCHEMA_PRIVILEGES 表1
26.3.34 INFORMATION_SCHEMA 统计表1
26.3.35 INFORMATION_SCHEMA ST_GEOMETRY_COLUMNS 表1
26.3.36 INFORMATION_SCHEMA ST_SPATIAL_REFERENCE_SYSTEMS 表1
26.3.37 INFORMATION_SCHEMA ST_UNITS_OF_MEASURE 表1
26.3.38 INFORMATION_SCHEMA TABLES 表1
26.3.39 INFORMATION_SCHEMA TABLES_EXTENSIONS 表1
26.3.40 INFORMATION_SCHEMA TABLESPACES 表1
26.3.41 INFORMATION_SCHEMA TABLESPACES_EXTENSIONS 表1
26.3.42 INFORMATION_SCHEMA TABLE_CONSTRAINTS 表1
26.3.43 INFORMATION_SCHEMA TABLE_CONSTRAINTS_EXTENSIONS 表1
26.3.44 INFORMATION_SCHEMA TABLE_PRIVILEGES 表1
26.3.45 INFORMATION_SCHEMA 触发器表1
26.3.46 INFORMATION_SCHEMA USER_ATTRIBUTES 表1
26.3.47 INFORMATION_SCHEMA USER_PRIVILEGES 表1
26.3.48 INFORMATION_SCHEMA VIEWS 表1
26.3.49 INFORMATION_SCHEMA VIEW_ROUTINE_USAGE 表1
26.3.50 INFORMATION_SCHEMA VIEW_TABLE_USAGE 表1
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
MySQL 8.0 参考手册  / 第 26 章 INFORMATION_SCHEMA 表  / 26.3 INFORMATION_SCHEMA 总表  /
26.3.18 INFORMATION_SCHEMA ndb_transid_mysql_connection_map 表
26.3.18 INFORMATION_SCHEMA ndb_transid_mysql_connection_map 表
该ndb_transid_mysql_connection_map表提供了NDB事务、
NDB事务协调器和作为 API 节点附加到 NDB Cluster 的 MySQL 服务器之间的映射。在填充
NDB Cluster 信息数据库
的server_operations和
server_transactions表时使用此信息。ndbinfo
INFORMATION_SCHEMA姓名
SHOW姓名
评论
mysql_connection_id
MySQL 服务器连接 ID
node_id
事务协调器节点 ID
ndb_transid
NDB交易编号
与的mysql_connection_id输出中显示的连接或会话 ID 相同
SHOW PROCESSLIST。
没有SHOW与此表关联的语句。
这是一个非标准表，特定于 NDB Cluster。它是作为INFORMATION_SCHEMA插件实现的；您可以通过检查 的输出来验证它是否受支持
SHOW PLUGINS。如果
ndb_transid_mysql_connection_map启用了支持，则此语句的输出包括一个具有此名称、类型INFORMATION SCHEMA和状态的插件ACTIVE，如下所示（使用强调文本）：
mysql> SHOW PLUGINS;
+----------------------------------+--------+--------------------+---------+---------+
| Name                             | Status | Type               | Library | License |
+----------------------------------+--------+--------------------+---------+---------+
| binlog                           | ACTIVE | STORAGE ENGINE     | NULL    | GPL     |
| mysql_native_password            | ACTIVE | AUTHENTICATION     | NULL    | GPL     |
| sha256_password                  | ACTIVE | AUTHENTICATION     | NULL    | GPL     |
| caching_sha2_password            | ACTIVE | AUTHENTICATION     | NULL    | GPL     |
| sha2_cache_cleaner               | ACTIVE | AUDIT              | NULL    | GPL     |
| daemon_keyring_proxy_plugin      | ACTIVE | DAEMON             | NULL    | GPL     |
| CSV                              | ACTIVE | STORAGE ENGINE     | NULL    | GPL     |
| MEMORY                           | ACTIVE | STORAGE ENGINE     | NULL    | GPL     |
| InnoDB                           | ACTIVE | STORAGE ENGINE     | NULL    | GPL     |
| INNODB_TRX                       | ACTIVE | INFORMATION SCHEMA | NULL    | GPL     |
| INNODB_CMP                       | ACTIVE | INFORMATION SCHEMA | NULL    | GPL     |
...
| INNODB_SESSION_TEMP_TABLESPACES  | ACTIVE | INFORMATION SCHEMA | NULL    | GPL     |
| MyISAM                           | ACTIVE | STORAGE ENGINE     | NULL    | GPL     |
| MRG_MYISAM                       | ACTIVE | STORAGE ENGINE     | NULL    | GPL     |
| PERFORMANCE_SCHEMA               | ACTIVE | STORAGE ENGINE     | NULL    | GPL     |
| TempTable                        | ACTIVE | STORAGE ENGINE     | NULL    | GPL     |
| ARCHIVE                          | ACTIVE | STORAGE ENGINE     | NULL    | GPL     |
| BLACKHOLE                        | ACTIVE | STORAGE ENGINE     | NULL    | GPL     |
| ndbcluster                       | ACTIVE | STORAGE ENGINE     | NULL    | GPL     |
| ndbinfo                          | ACTIVE | STORAGE ENGINE     | NULL    | GPL     |
| ndb_transid_mysql_connection_map | ACTIVE | INFORMATION SCHEMA | NULL    | GPL     |
| ngram                            | ACTIVE | FTPARSER           | NULL    | GPL     |
| mysqlx_cache_cleaner             | ACTIVE | AUDIT              | NULL    | GPL     |
| mysqlx                           | ACTIVE | DAEMON             | NULL    | GPL     |
+----------------------------------+--------+--------------------+---------+---------+
47 rows in set (0.01 sec)
该插件默认启用。--ndb-transid-mysql-connection-map
您可以通过使用选项启动服务器来禁用它（或强制服务器不运行，除非插件启动）
。如果插件被禁用，状态显示
SHOW PLUGINS为
DISABLED。该插件无法在运行时启用或禁用。
虽然该表及其列的名称使用小写显示，但在 SQL 语句中引用它们时可以使用大写或小写。
要创建此表，MySQL 服务器必须是 NDB Cluster 发行版提供的二进制文件，或者是从NDB启用了存储引擎支持的 NDB Cluster 源构建的二进制文件。它在标准 MySQL 8.0 服务器中不可用。
© Mysql 中文网
