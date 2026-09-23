# 15.6.6 撤消日志_MySQL 8.0 参考手册

15.6.6 撤消日志_MySQL 8.0 参考手册
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
15.1 InnoDB简介
15.2 InnoDB 和 ACID 模型
15.3 InnoDB 多版本
15.4 InnoDB架构
15.5 InnoDB 内存结构
15.6 InnoDB 磁盘结构
15.6.1 表格1
15.6.2 索引1
15.6.3 表空间1
15.6.4 双写缓冲区1
15.6.5 重做日志1
15.6.6 撤消日志1
15.7 InnoDB 锁定和事务模型
15.8 InnoDB配置
15.9 InnoDB 表和页压缩
15.10 InnoDB 行格式
15.11 InnoDB磁盘I/O和文件空间管理
15.12 InnoDB和在线DDL
15.13 InnoDB静态数据加密
15.14 InnoDB 启动选项和系统变量
15.15 InnoDB INFORMATION_SCHEMA 表
15.16 InnoDB 与 MySQL 性能模式的集成
15.17 InnoDB 监视器
15.18 InnoDB备份与恢复
15.19 InnoDB和MySQL复制
15.20 InnoDB 内存缓存插件
15.21 InnoDB 故障排除
15.22 InnoDB 限制
15.23 InnoDB 限制和限制
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
MySQL 8.0 参考手册  / 第 15 章 InnoDB 存储引擎  / 15.6 InnoDB 磁盘结构  /
15.6.6 撤消日志
15.6.6 撤消日志
撤消日志是与单个读写事务关联的撤消日志记录的集合。撤消日志记录包含有关如何撤消事务对聚集索引
记录的最新更改的信息。如果另一个事务需要将原始数据视为一致读取操作的一部分，则未修改的数据将从撤消日志记录中检索。撤消日志存在于
撤消日志段中，而撤消日志段包含在
回滚段中。回滚段位于
撤消表空间和全局临时表空间中。
驻留在全局临时表空间中的撤消日志用于修改用户定义的临时表中数据的事务。这些撤消日志不会重做日志，因为它们不是崩溃恢复所必需的。它们仅用于服务器运行时的回滚。这种类型的撤消日志通过避免重做日志 I/O 来提高性能。
有关撤消日志的静态数据加密的信息，请参阅
撤消日志加密。
每个撤消表空间和全局临时表空间各自最多支持 128 个回滚段。该
innodb_rollback_segments变量定义回滚段的数量。
一个回滚段支持的事务数取决于回滚段中的undo槽数和每个事务需要的undo日志数。回滚段中撤消槽的数量根据
InnoDB页面大小而不同。
InnoDB 页面大小
回滚段中的撤消槽数（InnoDB 页面大小 / 16）
4096 (4KB)
256
8192 (8KB)
512
16384 (16KB)
1024
32768 (32KB)
2048
65536 (64KB)
4096
事务最多分配四个撤消日志，一个用于以下操作类型：
INSERT对用户定义表的操作
UPDATE和
DELETE对用户定义表的操作
INSERT对用户定义的临时表的操作
UPDATE和
DELETE对用户定义的临时表的操作
根据需要分配撤消日志。例如，对常规表和临时表执行INSERT、
UPDATE和
DELETE操作的事务需要完整分配四个撤消日志。仅对常规表执行
INSERT操作的事务需要单个撤消日志。
对常规表执行操作的事务从分配的撤消表空间回滚段中分配撤消日志。对临时表执行操作的事务从分配的全局临时表空间回滚段分配撤消日志。
分配给事务的撤消日志在其持续时间内保持附加到事务。例如，分配给对常规表进行INSERT
操作的事务的撤消日志用于该事务对常规表执行的所有
INSERT操作。
考虑到上述因素，可以使用以下公式来估计InnoDB能够支持的并发读写事务数。
笔记
InnoDB在达到能够支持
的并发读写事务数之前，可能会遇到并发事务限制错误。当分配给事务的回滚段用完撤消槽时会发生这种情况。在这种情况下，请尝试重新运行事务。
事务对临时表进行操作时，能够支持的并发读写事务
InnoDB数受分配给全局临时表空间的回滚段数的限制，默认为128。
如果每个事务执行一个
或一个
或
操作，则能够支持
的并发读写事务数
为：INSERT
UPDATEDELETEInnoDB(innodb_page_size / 16) * innodb_rollback_segments * number of undo tablespaces
如果每个事务执行
and和or
操作
，则能够支持
的并发读写事务数
为：INSERT
UPDATEDELETEInnoDB(innodb_page_size / 16 / 2) * innodb_rollback_segments * number of undo tablespaces
如果每个事务对临时表进行
操作，则能够支持
INSERT的并发读写事务数
为：InnoDB(innodb_page_size / 16) * innodb_rollback_segments
如果每个事务对临时表执行
and和or
操作
，则能够支持
的并发读写事务数
为：INSERT
UPDATEDELETEInnoDB(innodb_page_size / 16 / 2) * innodb_rollback_segments
© Mysql 中文网
