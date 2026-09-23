# 26.4.6 INFORMATION_SCHEMA INNODB_CMP 和 INNODB_CMP_RESET 表_MySQL 8.0 参考手册

26.4.6 INFORMATION_SCHEMA INNODB_CMP 和 INNODB_CMP_RESET 表_MySQL 8.0 参考手册
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
26.4.1 INFORMATION_SCHEMA InnoDB 表参考1
26.4.2 INFORMATION_SCHEMA INNODB_BUFFER_PAGE 表1
26.4.3 INFORMATION_SCHEMA INNODB_BUFFER_PAGE_LRU 表1
26.4.4 INFORMATION_SCHEMA INNODB_BUFFER_POOL_STATS 表1
26.4.5 INFORMATION_SCHEMA INNODB_CACHED_INDEXES 表1
26.4.6 INFORMATION_SCHEMA INNODB_CMP 和 INNODB_CMP_RESET 表1
26.4.7 INFORMATION_SCHEMA INNODB_CMPMEM 和 INNODB_CMPMEM_RESET 表1
26.4.8 INFORMATION_SCHEMA INNODB_CMP_PER_INDEX 和 INNODB_CMP_PER_INDEX_RESET 表1
26.4.9 INFORMATION_SCHEMA INNODB_COLUMNS 表1
26.4.10 INFORMATION_SCHEMA INNODB_DATAFILES 表1
26.4.11 INFORMATION_SCHEMA INNODB_FIELDS 表1
26.4.12 INFORMATION_SCHEMA INNODB_FOREIGN 表1
26.4.13 INFORMATION_SCHEMA INNODB_FOREIGN_COLS 表1
26.4.14 INFORMATION_SCHEMA INNODB_FT_BEING_DELETED 表1
26.4.15 INFORMATION_SCHEMA INNODB_FT_CONFIG 表1
26.4.16 INFORMATION_SCHEMA INNODB_FT_DEFAULT_STOPWORD 表1
26.4.17 INFORMATION_SCHEMA INNODB_FT_DELETED 表1
26.4.18 INFORMATION_SCHEMA INNODB_FT_INDEX_CACHE 表1
26.4.19 INFORMATION_SCHEMA INNODB_FT_INDEX_TABLE 表1
26.4.20 INFORMATION_SCHEMA INNODB_INDEXES 表1
26.4.21 INFORMATION_SCHEMA INNODB_METRICS 表1
26.4.22 INFORMATION_SCHEMA INNODB_SESSION_TEMP_TABLESPACES 表1
26.4.23 INFORMATION_SCHEMA INNODB_TABLES 表1
26.4.24 INFORMATION_SCHEMA INNODB_TABLESPACES 表1
26.4.25 INFORMATION_SCHEMA INNODB_TABLESPACES_BRIEF 表1
26.4.26 INFORMATION_SCHEMA INNODB_TABLESTATS 视图1
26.4.27 INFORMATION_SCHEMA INNODB_TEMP_TABLE_INFO 表1
26.4.28 INFORMATION_SCHEMA INNODB_TRX 表1
26.4.29 INFORMATION_SCHEMA INNODB_VIRTUAL 表1
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
MySQL 8.0 参考手册  / 第 26 章 INFORMATION_SCHEMA 表  / 26.4 INFORMATION_SCHEMA InnoDB 表  /
26.4.6 INFORMATION_SCHEMA INNODB_CMP 和 INNODB_CMP_RESET 表
26.4.6 INFORMATION_SCHEMA INNODB_CMP 和 INNODB_CMP_RESET 表
INNODB_CMP和
INNODB_CMP_RESET表提供与
压缩
InnoDB表
相关的操作
的状态信息。INNODB_CMP和
INNODB_CMP_RESET表有以下列
：
PAGE_SIZE
以字节为单位的压缩页面大小。
COMPRESS_OPS
大小的 B 树页面
PAGE_SIZE被压缩的次数。每当创建空页面或未压缩修改日志的空间用完时，都会压缩页面。
COMPRESS_OPS_OK
大小为 B 树页面的
PAGE_SIZE成功压缩次数。此计数不应超过
COMPRESS_OPS.
COMPRESS_TIME
用于尝试压缩大小为 的 B 树页面的总时间（以秒为单位）PAGE_SIZE。
UNCOMPRESS_OPS
size 的 B 树页面
PAGE_SIZE被解压缩的次数。每当压缩失败或当缓冲池中不存在未压缩页面时首次访问时，B 树页面将被解压缩。
UNCOMPRESS_TIME
用于解压缩大小为 的 B 树页面的总时间（以秒为单位）PAGE_SIZE。
例子
mysql> SELECT * FROM INFORMATION_SCHEMA.INNODB_CMP\G
*************************** 1. row ***************************
page_size: 1024
compress_ops: 0
compress_ops_ok: 0
compress_time: 0
uncompress_ops: 0
uncompress_time: 0
*************************** 2. row ***************************
page_size: 2048
compress_ops: 0
compress_ops_ok: 0
compress_time: 0
uncompress_ops: 0
uncompress_time: 0
*************************** 3. row ***************************
page_size: 4096
compress_ops: 0
compress_ops_ok: 0
compress_time: 0
uncompress_ops: 0
uncompress_time: 0
*************************** 4. row ***************************
page_size: 8192
compress_ops: 86955
compress_ops_ok: 81182
compress_time: 27
uncompress_ops: 26828
uncompress_time: 5
*************************** 5. row ***************************
page_size: 16384
compress_ops: 0
compress_ops_ok: 0
compress_time: 0
uncompress_ops: 0
uncompress_time: 0
笔记
使用这些表来衡量
数据库
InnoDB中表
压缩的有效性。
您必须具有PROCESS
查询此表的权限。
使用INFORMATION_SCHEMA
COLUMNS表或
SHOW COLUMNS语句查看有关此表的列的其他信息，包括数据类型和默认值。
有关使用信息，请参阅
第 15.9.1.4 节，“在运行时监视 InnoDB 表压缩”和
第 15.15.1.3 节，“使用压缩信息模式表”。有关InnoDB表压缩的一般信息，请参阅第 15.9 节，“InnoDB 表和页面压缩”。
© Mysql 中文网
