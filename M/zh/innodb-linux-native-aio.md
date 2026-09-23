# 15.8.6 在 Linux 上使用异步 I/O_MySQL 8.0 参考手册

15.8.6 在 Linux 上使用异步 I/O_MySQL 8.0 参考手册
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
15.8.1 InnoDB启动配置1
15.8.2 为只读操作配置 InnoDB1
15.8.3 InnoDB缓冲池配置1
15.8.4 为 InnoDB 配置线程并发1
15.8.5 配置后台InnoDB I/O线程数1
15.8.6 在 Linux 上使用异步 I/O1
15.8.7 配置 InnoDB I/O 容量1
15.8.8 配置自旋锁轮询1
15.8.9 清除配置1
15.8.10 为 InnoDB 配置优化器统计信息1
15.8.11 配置索引页的合并阈值1
15.8.12 为专用 MySQL 服务器启用自动配置1
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
MySQL 8.0 参考手册  / 第 15 章 InnoDB 存储引擎  / 15.8 InnoDB配置  /
15.8.6 在 Linux 上使用异步 I/O
15.8.6 在 Linux 上使用异步 I/O
InnoDB使用 Linux 上的异​​步 I/O 子系统（本机 AIO）来执行数据文件页面的预读和写入请求。此行为由
innodb_use_native_aio
配置选项控制，该选项仅适用于 Linux 系统并且默认启用。在其他类 Unix 系统上，
InnoDB仅使用同步 I/O。历史上，
InnoDB仅在 Windows 系统上使用异步 I/O。在 Linux 上使用异步 I/O 子系统需要libaio库。
对于同步 I/O，查询线程将 I/O 请求排队，
InnoDB后台线程一次检索一个排队的请求，为每个请求发出一个同步 I/O 调用。当 I/O 请求完成并且 I/O 调用返回时，
InnoDB处理该请求的后台线程调用 I/O 完成例程并返回以处理下一个请求。可并行处理的请求数为n，其中
n为
InnoDB后台线程数。后台线程的数量
InnoDB由
innodb_read_io_threads和
控制innodb_write_io_threads。请参阅
第 15.8.5 节，“配置后台 InnoDB I/O 线程的数量”。
使用本机 AIO，查询线程将 I/O 请求直接分派给操作系统，从而消除了后台线程数量的限制。InnoDB后台线程等待 I/O 事件发出已完成请求的信号。当请求完成时，后台线程调用 I/O 完成例程并继续等待 I/O 事件。
本机 AIO 的优势是可扩展性，适用于严重 I/O 绑定的系统，这些系统通常在
SHOW ENGINE INNODB STATUS\G输出中显示许多挂起的读/写。使用本机 AIO 时并行处理的增加意味着 I/O 调度程序的类型或磁盘阵列控制器的属性对 I/O 性能有更大的影响。
对于严重 I/O 绑定的系统，本机 AIO 的一个潜在缺点是无法控制一次分派到操作系统的 I/O 写入请求的数量。在某些情况下，分配给操作系统进行并行处理的过多 I/O 写入请求可能会导致 I/O 读取饥饿，具体取决于 I/O 活动量和系统功能。
如果操作系统中的异步 I/O 子系统出现问题而无法InnoDB启动，您可以使用 启动服务器
innodb_use_native_aio=0。InnoDB如果检测到潜在问题（例如tmpdir位置、
tmpfs文件系统和不支持异步 I/O 的 Linux 内核的组合），此选项也可能在启动期间自动禁用
tmpfs。
© Mysql 中文网
