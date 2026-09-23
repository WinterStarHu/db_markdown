# 15.11.2 文件空间管理_MySQL 8.0 参考手册

15.11.2 文件空间管理_MySQL 8.0 参考手册
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
15.11.1 InnoDB 磁盘 I/O1
15.11.2 文件空间管理1
15.11.3 InnoDB 检查点1
15.11.4 对表进行碎片整理1
15.11.5 使用 TRUNCATE TABLE 回收磁盘空间1
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
MySQL 8.0 参考手册  / 第 15 章 InnoDB 存储引擎  / 15.11 InnoDB磁盘I/O和文件空间管理  /
15.11.2 文件空间管理
15.11.2 文件空间管理
innodb_data_file_path
您使用配置选项
在配置文件中定义的数据文件
形成了InnoDB
系统表空间。这些文件在逻辑上串联起来形成系统表空间。没有使用条纹。您无法定义表在系统表空间中的分配位置。在新创建的系统表空间中，InnoDB从第一个数据文件开始分配空间。
为避免将所有表和索引存储在系统表空间中所带来的问题，您可以启用
innodb_file_per_table
配置选项（默认设置），它将每个新创建的表存储在单独的表空间文件中（扩展名为
.ibd）。对于以这种方式存储的表，磁盘文件中的碎片较少，当表被截断时，空间将返回给操作系统，而不是仍然由 InnoDB 在系统表空间中保留。有关详细信息，请参阅
第 15.6.3.2 节，“File-Per-Table 表空间”。
您还可以将表存储在
通用表空间中。通用表空间是使用CREATE TABLESPACE
语法创建的共享表空间。它们可以在 MySQL 数据目录之外创建，能够容纳多个表，并支持所有行格式的表。有关详细信息，请参阅
第 15.6.3.3 节，“通用表空间”。
页、范围、段和表空间
每个表空间都由数据库
页面组成。MySQL 实例中的每个表空间都具有相同的页面大小。默认情况下，所有表空间的页大小都是 16KB；innodb_page_size您可以通过在创建 MySQL 实例时指定选项将页面大小减小到 8KB 或 4KB 。您还可以将页面大小增加到 32KB 或 64KB。有关详细信息，请参阅
innodb_page_size文档。
对于最大 16KB 的页面（64 个连续的 16KB 页面，或 128 个 8KB 页面，或 256 个 4KB 页面），
页面被分组为
大小为 1MB 的范围。对于 32KB 的页面大小，extent 大小为 2MB。对于 64KB 的页面大小，extent 大小为 4MB。表空间内
的
“文件”在
. （这些段不同于回滚段，后者实际上包含许多表空间段。）
InnoDB
当段在表空间内增长时，
InnoDB一次将前 32 页分配给它。之后，InnoDB开始将整个范围分配给段。InnoDB
一次最多可以将 4 个 extent 添加到一个大段中，以确保数据的良好顺序性。
为 中的每个索引分配两个段
InnoDB。一个用于
B 树的非叶节点，另一个用于叶节点。使叶节点在磁盘上保持连续可以实现更好的顺序 I/O 操作，因为这些叶节点包含实际的表数据。
表空间中的某些页包含其他页的位图，因此InnoDB
表空间中的一些盘区不能作为一个整体分配给段，而只能作为单独的页分配。
当您通过发出SHOW TABLE STATUS
语句请求表空间中的可用空闲空间时，InnoDB报告表空间中绝对空闲的盘区。InnoDB
总是保留一些范围用于清理和其他内部目的；这些保留范围不包括在可用空间中。
当您从表中删除数据时，InnoDB
收缩相应的 B 树索引。释放的空间是否可供其他用户使用取决于删除模式是否将单个页面或扩展区释放到表空间。删除表或删除表中的所有行可以保证将空间释放给其他用户，但请记住，删除的行仅通过
清除操作物理删除，在事务回滚或一致性读取不再需要它们后的某个时间自动发生. （请参阅
第 15.3 节，“InnoDB 多版本控制”。）
配置保留文件段页面的百分比
该
innodb_segment_reserve_factor
变量在 MySQL 8.0.26 中引入，是一项高级功能，它允许定义保留为空页的表空间文件段页的百分比。保留一定百分比的页面以供将来增长，以便可以连续分配 B 树中的页面。修改保留页面百分比的能力允许进行微调InnoDB以解决数据碎片或存储空间使用效率低下的问题。
该设置适用于 file-per-table 和通用表空间。默认设置为 12.5%，与
innodb_segment_reserve_factor
以前的 MySQL 版本中保留的页面百分比相同。
该
innodb_segment_reserve_factor
变量是动态的，可以使用
SET语句进行配置。例如：
mysql> SET GLOBAL innodb_segment_reserve_factor=10;
页面如何与表格行相关
对于 4KB、8KB、16KB 和 32KB
innodb_page_size设置，最大行长度略小于数据库页面大小的一半。InnoDB例如，对于默认的 16KB页面大小，最大行长度略小于 8KB 。对于 64KBinnodb_page_size
设置，最大行长度略小于 16KB。
如果一行不超过最大行长度，则所有行都存储在页面的本地。如果一行超过最大行长度，
则选择可变长度列用于外部页外存储，直到该行符合最大行长度限制。可变长度列的外部页外存储因行格式而异：
COMPACT 和 REDUNDANT 行格式
When a variable-length column is chosen for external off-page storage, InnoDBstores the first 768 bytes locally in the row, and the rest externally into overflow pages. 每个这样的列都有自己的溢出页列表。768 字节的前缀伴随着一个 20 字节的值，该值存储列的真实长度并指向存储其余值的溢出列表。请参阅第 15.10 节，“InnoDB 行格式”。
动态和压缩行格式
When a variable-length column is chosen for external off-page storage, InnoDBstores a 20-byte pointer locally in the row, and the rest externally into overflow pages. 请参阅第 15.10 节，“InnoDB 行格式”。
LONGBLOB和
LONGTEXT列必须小于 4GB，并且包括列在内的总行长度
BLOB必须
TEXT小于 4GB。
© Mysql 中文网
