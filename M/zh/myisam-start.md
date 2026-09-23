# 16.2.1 MyISAM 启动选项_MySQL 8.0 参考手册

16.2.1 MyISAM 启动选项_MySQL 8.0 参考手册
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
16.1 设置存储引擎
16.2 MyISAM 存储引擎
16.2.1 MyISAM 启动选项1
16.2.2 按键所需空间1
16.2.3 MyISAM 表存储格式1
16.2.4 MyISAM 表问题1
16.3 MEMORY存储引擎
16.4 CSV存储引擎
16.5 ARCHIVE存储引擎
16.6 BLACKHOLE存储引擎
16.7 MERGE存储引擎
16.8 联合存储引擎
16.9 示例存储引擎
16.10 其他存储引擎
16.11 MySQL存储引擎架构概述
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
MySQL 8.0 参考手册  / 第 16 章替代存储引擎  / 16.2 MyISAM 存储引擎  /
16.2.1 MyISAM 启动选项
16.2.1 MyISAM 启动选项
mysqld
的以下选项可用于更改MyISAM表的行为。有关其他信息，请参阅第 5.1.7 节，“服务器命令选项”。
表 16.3 MyISAM 选项和变量引用
姓名
命令行
选项文件
系统变量
状态变量
可变范围
动态的
bulk_insert_buffer_size
是的
是的
是的
两个都
是的
并发插入
是的
是的
是的
全球的
是的
延迟_密钥_写入
是的
是的
是的
全球的
是的
有_rtree_keys
是的
全球的
不
key_buffer_size
是的
是的
是的
全球的
是的
log-isam
是的
是的
myisam 块大小
是的
是的
myisam_data_pointer_size
是的
是的
是的
全球的
是的
myisam_max_sort_file_size
是的
是的
是的
全球的
是的
myisam_mmap_size
是的
是的
是的
全球的
不
myisam_recover_options
是的
是的
是的
全球的
不
myisam_repair_threads
是的
是的
是的
两个都
是的
myisam_sort_buffer_size
是的
是的
是的
两个都
是的
myisam_stats_method
是的
是的
是的
两个都
是的
myisam_use_mmap
是的
是的
是的
全球的
是的
tmp_table_size
是的
是的
是的
两个都
是的
以下系统变量影响
MyISAM表的行为。有关其他信息，请参阅
第 5.1.8 节，“服务器系统变量”。
bulk_insert_buffer_size
批量插入优化中使用的树缓存的大小。
笔记
这是每个线程的限制！
delay_key_write=ALL
不要在任何
MyISAM表的写入之间刷新键缓冲区。
笔记
如果这样做，
当表正在使用时，您不应该MyISAM从另一个程序（例如从另一个 MySQL 服务器或使用
myisamchk ）访问表。这样做有索引损坏的风险。使用
--external-locking并不能消除这种风险。
myisam_max_sort_file_size
MySQL 在重新创建MyISAM索引时（在REPAIR TABLE、
ALTER TABLE或
期间LOAD DATA）被允许使用的临时文件的最大大小。如果文件大小大于此值，则使用键缓存创建索引，速度较慢。该值以字节为单位给出。
myisam_recover_options=mode
设置崩溃
MyISAM表的自动恢复模式。
myisam_sort_buffer_size
设置恢复表时使用的缓冲区大小。
如果您
使用
系统变量集启动mysqld ，则会激活自动恢复。myisam_recover_options在这种情况下，当服务器打开一个
MyISAM表时，它会检查该表是否被标记为已崩溃，或者该表的打开计数变量是否不为 0，并且您是否在禁用外部锁定的情况下运行服务器。如果这些条件中的任何一个为真，则会发生以下情况：
服务器检查表是否有错误。
如果服务器发现错误，它会尝试进行快速表修复（通过排序而不重新创建数据文件）。
如果由于数据文件中的错误（例如，重复键错误）导致修复失败，服务器会重试，这次会重新创建数据文件。
如果修复仍然失败，服务器会再次尝试使用旧的修复选项方法（逐行写入，不排序）。此方法应该能够修复任何类型的错误并且对磁盘空间要求低。
如果恢复无法从以前完成的语句中恢复所有行并且您没有
FORCE在系统变量的值中
指定，则myisam_recover_options自动修复中止并在错误日志中显示一条错误消息：
Error: Couldn't repair table: test.g00pages
如果您指定FORCE，则会写入如下警告：
Warning: Found 344 of 354 rows when repairing ./test/g00pages
如果自动恢复值包括
BACKUP，恢复过程将创建名称为
tbl_name-datetime.BAK. 您应该有一个cron脚本，可以自动将这些文件从数据库目录移动到备份媒体。
© Mysql 中文网
