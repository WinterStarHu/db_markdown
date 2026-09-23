# 8.6.3 优化 REPAIR TABLE 语句_MySQL 8.0 参考手册

8.6.3 优化 REPAIR TABLE 语句_MySQL 8.0 参考手册
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
8.1 优化概述
8.2 优化SQL语句
8.3 优化和索引
8.4 优化数据库结构
8.5 优化 InnoDB 表
8.6 优化 MyISAM 表
8.6.1 优化 MyISAM 查询1
8.6.2 MyISAM 表的批量数据加载1
8.6.3 优化 REPAIR TABLE 语句1
8.7 优化 MEMORY 表
8.8 了解查询执行计划
8.9 控制查询优化器
8.10 缓冲和缓存
8.11 优化锁定操作
8.12 优化MySQL服务器
8.13 测量性能（基准测试）
8.14 查看服务器线程（进程）信息
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
MySQL 8.0 参考手册  / 第8章优化  / 8.6 优化 MyISAM 表  /
8.6.3 优化 REPAIR TABLE 语句
8.6.3 优化 REPAIR TABLE 语句
REPAIR TABLE对于
MyISAM表类似于使用
myisamchk进行修复操作，并且应用一些相同的性能优化：
myisamchk有控制内存分配的变量。您可以通过设置这些变量来提高其性能，如
第 4.6.4.6 节“myisamchk 内存使用”。
对于REPAIR TABLE，同样的道理，但是因为修复是由服务器完成的，所以你设置的是服务器系统变量，而不是
myisamchk变量。此外，除了设置内存分配变量外，增加
myisam_max_sort_file_size
系统变量会增加修复使用更快的文件排序方法的可能性，并避免使用键缓存方法进行更慢的修复。在检查确保有足够的可用空间来保存表文件的副本后，将变量设置为系统的最大文件大小。包含原始表文件的文件系统中必须有可用空间。
假设使用以下选项设置其内存分配变量来完成myisamchk表修复操作：
--key_buffer_size=128M --myisam_sort_buffer_size=256M
--read_buffer_size=64M --write_buffer_size=64M
其中一些myisamchk变量对应于服务器系统变量：
myisamchk变量
系统变量
key_buffer_size
key_buffer_size
myisam_sort_buffer_size
myisam_sort_buffer_size
read_buffer_size
read_buffer_size
write_buffer_size
没有任何
每个服务器系统变量都可以在运行时设置，其中一些 ( myisam_sort_buffer_size,
read_buffer_size) 除了全局值外还有一个会话值。设置会话值将更改的影响限制在您当前的会话中，并且不会影响其他用户。更改仅全局变量 ( key_buffer_size,
myisam_max_sort_file_size) 也会影响其他用户。对于
key_buffer_size，您必须考虑到缓冲区是与这些用户共享的。例如，如果将myisamchk
key_buffer_size变量设置为 128MB，则可以设置相应的
key_buffer_size大于该值的系统变量（如果尚未设置得更大），以允许其他会话中的活动使用密钥缓冲区。但是，更改全局键缓冲区大小会使缓冲区无效，从而导致磁盘 I/O 增加并降低其他会话的速度。避免此问题的另一种方法是使用单独的键缓存，将要修复的表中的索引分配给它，并在修复完成时释放它。请参阅
第 8.10.2.2 节，“多个密钥缓存”。
根据前面的说明，REPAIR
TABLE可以进行如下操作，使用类似于myisamchk命令的设置。这里分配了一个单独的 128MB 密钥缓冲区，并且假定文件系统允许至少 100GB 的文件大小。
SET SESSION myisam_sort_buffer_size = 256*1024*1024;
SET SESSION read_buffer_size = 64*1024*1024;
SET GLOBAL myisam_max_sort_file_size = 100*1024*1024*1024;
SET GLOBAL repair_cache.key_buffer_size = 128*1024*1024;
CACHE INDEX tbl_name IN repair_cache;
LOAD INDEX INTO CACHE tbl_name;
REPAIR TABLE tbl_name ;
SET GLOBAL repair_cache.key_buffer_size = 0;
如果您打算更改全局变量，但只想在操作期间这样做，以REPAIR
TABLE尽量减少对其他用户的影响，请将其值保存在用户变量中，然后再恢复。例如：
SET @old_myisam_sort_buffer_size = @@GLOBAL.myisam_max_sort_file_size;
SET GLOBAL myisam_max_sort_file_size = 100*1024*1024*1024;
REPAIR TABLE tbl_name ;
SET GLOBAL myisam_max_sort_file_size = @old_myisam_max_sort_file_size;REPAIR
TABLE如果您希望这些值在默认情况下生效，则可以在服务器启动时全局设置
影响的系统变量。例如，将这些行添加到服务器my.cnf文件：
[mysqld]
myisam_sort_buffer_size=256M
key_buffer_size=1G
myisam_max_sort_file_size=100G
这些设置不包括
read_buffer_size. 将
read_buffer_size全局设置为一个较大的值会对所有会话执行此操作，并且可能会由于为具有许多并发会话的服务器分配过多的内存而导致性能下降。
© Mysql 中文网
