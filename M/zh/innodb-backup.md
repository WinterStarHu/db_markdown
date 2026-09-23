# 15.18.1 InnoDB 备份_MySQL 8.0 参考手册

15.18.1 InnoDB 备份_MySQL 8.0 参考手册
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
15.18.1 InnoDB 备份1
15.18.2 InnoDB 恢复1
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
MySQL 8.0 参考手册  / 第 15 章 InnoDB 存储引擎  / 15.18 InnoDB备份与恢复  /
15.18.1 InnoDB 备份
15.18.1 InnoDB 备份
安全数据库管理的关键是定期备份。根据您的数据量、MySQL 服务器数量和数据库工作负载，您可以单独或组合使用这些备份技术：
使用MySQL Enterprise Backup进行热备份；
在 MySQL 服务器关闭时通过复制文件进行
冷备份；使用
mysqldump进行逻辑备份，用于较小的数据量或记录模式对象的结构。冷热备份是
复制实际数据文件的物理备份， mysqld服务器可以直接使用这些文件
进行更快的恢复。
使用MySQL Enterprise Backup是备份InnoDB数据的推荐方法。
笔记
InnoDB不支持使用第三方备份工具恢复的数据库。
热备份
mysqlbackup命令是 MySQL Enterprise Backup 组件
的一部分，可让您备份正在运行的 MySQL 实例（包括InnoDB表），同时生成一致的数据库快照，同时最大限度地减少操作中断。当mysqlbackup正在复制
InnoDB表时，对表的读写
InnoDB可以继续。MySQL Enterprise Backup 还可以创建压缩备份文件，并备份表和数据库的子集。配合MySQL二进制日志，用户可以进行时间点恢复。MySQL Enterprise Backup 是 MySQL Enterprise 订阅的一部分。有关详细信息，请参阅第 30.2 节，“MySQL 企业备份概述”。
冷备份
如果可以关闭 MySQL 服务器，则可以进行物理备份，其中包含用于
InnoDB管理其表的所有文件。使用以下过程：
执行 MySQL 服务器的缓慢关闭，并确保它停止时没有错误。
将所有InnoDB数据文件（ibdata文件和
.ibd文件）复制到安全的地方。
将所有InnoDB重做日志文件（
MySQL 8.0.30 及更高
版本中的文件或早期版本中的文件）复制到安全位置。
#ib_redoNib_logfile
将您my.cnf的一个或多个配置文件复制到一个安全的地方。
使用 mysqldump 进行逻辑备份
除了物理备份之外，建议您通过使用
mysqldump转储表来定期创建逻辑备份。二进制文件可能会在您不注意的情况下损坏。转储的表存储在人类可读的文本文件中，因此更容易发现表损坏。此外，由于格式更简单，严重数据损坏的可能性更小。mysqldump
还有一个--single-transaction
选项可以在不锁定其他客户端的情况下制作一致的快照。请参阅第 7.3.1 节，“建立备份策略”。
复制与InnoDB表一起工作，因此您可以使用 MySQL 复制功能在需要高可用性的数据库站点上保留数据库的副本。请参阅
第 15.19 节，“InnoDB 和 MySQL 复制”。
© Mysql 中文网
