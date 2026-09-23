# 15.6.4 双写缓冲区_MySQL 8.0 参考手册

15.6.4 双写缓冲区_MySQL 8.0 参考手册
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
15.6.4 双写缓冲区
15.6.4 双写缓冲区
双写缓冲区是一个存储区域，在
InnoDB将页面写入
InnoDB数据文件中的适当位置之前，写入从缓冲池中刷新的页面。如果在页面写入过程中出现操作系统、存储子系统或意外的mysqld
进程退出，
InnoDB则可以在崩溃恢复期间从双写缓冲区中找到一份完好的页面副本。
虽然数据被写入两次，但双写缓冲区不需要两倍的 I/O 开销或两倍的 I/O 操作。数据以大的顺序块写入双写缓冲区，只需fsync()调用一次操作系统（
innodb_flush_method设置为
的情况除外O_DIRECT_NO_FSYNC）。
在MySQL 8.0.20之前，doublewrite buffer存储区位于InnoDB系统表空间中。从 MySQL 8.0.20 开始，doublewrite 缓冲区存储区域位于 doublewrite 文件中。
为双写缓冲区配置提供了以下变量：
innodb_doublewrite
该innodb_doublewrite
变量控制是否启用双写缓冲区。在大多数情况下，默认情况下它是启用的。要禁用双写缓冲区，请设置
innodb_doublewrite为
OFF。如果您更关心性能而不是数据完整性，请考虑禁用双写缓冲区，例如，在执行基准测试时可能就是这种情况。
从 MySQL 8.0.30 开始，
innodb_doublewrite支持
DETECT_AND_RECOVER和
DETECT_ONLY设置。
设置与设置DETECT_AND_RECOVER相同ON。使用此设置，双写缓冲区完全启用，数据库页面内容写入双写缓冲区，在恢复期间访问它以修复不完整的页面写入。
通过DETECT_ONLY设置，只有元数据被写入双写缓冲区。数据库页面内容不写入双写缓冲区，恢复不使用双写缓冲区来修复不完整的页面写入。此轻量级设置仅用于检测不完整的页面写入。
MySQL 8.0.30 及更高版本支持动态更改
innodb_doublewrite启用双写缓冲区的设置，介于
ON、DETECT_AND_RECOVER和之间DETECT_ONLY。MySQL 不支持启用双写缓冲区的设置之间的动态更改，OFF反之亦然。
如果双写缓冲区位于支持原子写入的 Fusion-io 设备上，则双写缓冲区会自动禁用，并使用 Fusion-io 原子写入执行数据文件写入。但是，请注意该innodb_doublewrite
设置是全局的。当禁用双写缓冲区时，所有数据文件（包括那些不驻留在 Fusion-io 硬件上的数据文件）都会被禁用。此功能仅在 Fusion-io 硬件上受支持，并且仅在 Linux 上为 Fusion-io NVMFS 启用。要充分利用此功能，
建议innodb_flush_method设置O_DIRECT为 。
innodb_doublewrite_dir
该innodb_doublewrite_dir
变量（在 MySQL 8.0.20 中引入）定义了InnoDB创建双写文件的目录。如果未指定目录，则在该innodb_data_home_dir
目录中创建双写文件，如果未指定，则默认为数据目录。
散列符号“#”会自动添加到指定目录名称的前缀，以避免与模式名称发生冲突。但是，如果是 '.'，'#'。或在目录名称中明确指定了“/”前缀，但哈希符号“#”未作为目录名称的前缀。
理想情况下，doublewrite 目录应该放在最快的可用存储介质上。
innodb_doublewrite_files
该innodb_doublewrite_files
变量定义双写文件的数量。默认情况下，为每个缓冲池实例创建两个双写文件：刷新列表双写文件和 LRU 列表双写文件。
刷新列表双写文件用于从缓冲池刷新列表中刷新的页面。刷新列表双写文件的默认大小是InnoDB页面大小 * 双写页面字节数。
LRU 列表双写文件用于从缓冲池 LRU 列表中刷新的页面。它还包含用于单页刷新的插槽。LRU 列表双写文件的默认大小是InnoDB页面大小 *（双写页面 +（512 / 缓冲池实例数）），其中 512 是为单页刷新保留的插槽总数。
至少有两个双写文件。双写文件的最大数量是缓冲池实例数量的两倍。（缓冲池实例的数量由
innodb_buffer_pool_instances
变量控制。）
双写文件名具有以下格式：（
或带有
设置）。例如，以下双写文件是为页面大小为 16KB 和单个缓冲池的 MySQL 实例创建的：
#ib_page_size_file_number.dblwr.bdblwrDETECT_ONLYInnoDB#ib_16384_0.dblwr
#ib_16384_1.dblwr
该innodb_doublewrite_files
变量用于高级性能调整。默认设置应该适合大多数用户。
innodb_doublewrite_pages
该innodb_doublewrite_pages
变量（在 MySQL 8.0.20 中引入）控制每个线程的最大双写页数。如果未指定值，
innodb_doublewrite_pages则设置为该
innodb_write_io_threads
值。此变量用于高级性能调整。默认值应该适合大多数用户。
innodb_doublewrite_batch_size
该
innodb_doublewrite_batch_size
变量（在 MySQL 8.0.20 中引入）控制批量写入的双写页数。此变量用于高级性能调整。默认值应该适合大多数用户。
从 MySQL 8.0.23 开始，InnoDB自动加密属于加密表空间的双写文件页面（请参阅第 15.13 节，“InnoDB 静态数据加密”）。同样，属于页压缩表空间的双写文件页也会被压缩。因此，双写文件可以包含不同的页面类型，包括未加密和未压缩的页面、加密的页面、压缩的页面以及既加密又压缩的页面。
© Mysql 中文网
