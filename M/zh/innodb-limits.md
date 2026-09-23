# 15.22 InnoDB 限制_MySQL 8.0 参考手册

15.22 InnoDB 限制_MySQL 8.0 参考手册
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
MySQL 8.0 参考手册  / 第 15 章 InnoDB 存储引擎  /
15.22 InnoDB 限制
15.22 InnoDB 限制
本节描述存储引擎
的InnoDB
表、索引、表空间和其他方面的
限制。InnoDB
一个表最多可以包含 1017 列。虚拟生成的列包含在此限制中。
一个表最多可以包含 64 个
二级索引。
InnoDB对于使用
DYNAMIC
或
COMPRESSED
行格式
的表，索引键前缀长度限制为 3072 字节
。
对于使用or
行格式的InnoDB表，
索引键前缀长度限制为 767 字节
。例如，您可能会
在或
列上使用超过 191 个字符的列前缀索引达到此限制，假设有一个
字符集并且每个字符最多 4 个字节。
REDUNDANTCOMPACTTEXTVARCHARutf8mb4
尝试使用超过限制的索引键前缀长度会返回错误。
如果您在创建 MySQL 实例时通过指定
选项将InnoDB
页面大小减小innodb_page_size到 8KB 或 4KB ，则索引键的最大长度将按比例降低，基于 16KB 页面大小的 3072 字节限制。即页大小为8KB时索引键最大长度为1536字节，页大小为4KB时为768字节。
适用于索引键前缀的限制也适用于全列索引键。
多列索引最多允许 16 列。超出限制会返回错误。
ERROR 1070 (42000): Too many key parts specified; max 16 parts allowed
对于 4KB、8KB、16KB 和 32KB 页面大小，最大行大小（不包括存储在页外的任何可变长度列）略小于页面的一半。例如，默认
innodb_page_size16KB 的最大行大小约为 8000 字节。但是，对于InnoDB
64KB 的页面大小，最大行大小约为 16000 字节。LONGBLOB和
LONGTEXT
列必须小于 4GB，并且包括列在内的总行大小BLOB必须
TEXT小于 4GB。
如果一行的长度小于半页，则所有行都存储在页面的本地。如果它超过半页，则选择可变长度列用于外部页外存储，直到该行适合半页，如
第 15.11.2 节，“文件空间管理”中所述。
尽管InnoDB内部支持大于 65,535 字节的行大小，但 MySQL 本身对所有列的组合大小施加了 65,535 的行大小限制。请参阅
第 8.4.7 节，“表列数和行大小的限制”。
在一些较旧的操作系统上，文件必须小于 2GB。这不是InnoDB限制。如果您需要一个大的系统表空间，请使用几个较小的数据文件而不是一个大的数据文件来配置它，或者将表数据分布在 file-per-table 和通用表空间数据文件中。
InnoDB日志文件
的最大组合大小为512GB。
最小表空间大小略大于 10MB。最大表空间大小取决于
InnoDB页面大小。
表 15.31 InnoDB 最大表空间大小
InnoDB 页面大小
最大表空间大小
4KB
16TB
8KB
32TB
16KB
64TB
32KB
128TB
64KB
256TB
最大表空间大小也是表的最大大小。
一个InnoDB实例最多支持 2^32 (4294967296) 个表空间，其中少量表空间保留用于撤消表和临时表。
共享表空间最多支持 2^32 (4294967296) 个表。
表空间文件的路径，包括文件名，不能超过MAX_PATHWindows 的限制。在 Windows 10 之前，MAX_PATH限制为 260 个字符。从 Windows 10 版本 1607 开始，
MAX_PATH常见 Win32 文件和目录功能的限制已被删除，但您必须启用新行为。
有关与并发读写事务相关的限制，请参阅第 15.6.6 节，“撤消日志”。
© Mysql 中文网
