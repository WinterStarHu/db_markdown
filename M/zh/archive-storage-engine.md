# 16.5 ARCHIVE存储引擎_MySQL 8.0 参考手册

16.5 ARCHIVE存储引擎_MySQL 8.0 参考手册
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
MySQL 8.0 参考手册  / 第 16 章替代存储引擎  /
16.5 ARCHIVE存储引擎
16.5 ARCHIVE存储引擎
存储引擎生成专用表，ARCHIVE以非常小的占用空间存储大量未索引的数据。
表 16.5 ARCHIVE 存储引擎功能
特征
支持
B树索引
不
备份/时间点恢复（在服务器中实现，而不是在存储引擎中。）
是的
集群数据库支持
不
聚簇索引
不
压缩数据
是的
数据缓存
不
加密数据
是（通过加密功能在服务器中实现。）
外键支持
不
全文搜索索引
不
地理空间数据类型支持
是的
地理空间索引支持
不
哈希索引
不
索引缓存
不
锁定粒度
排
MVCC
不
复制支持（在服务器中实现，而不是在存储引擎中。）
是的
存储限制
没有任何
T树索引
不
交易
不
更新数据字典的统计信息
是的
存储引擎包含在ARCHIVEMySQL 二进制发行版中。如果您从源代码构建 MySQL，要启用此存储引擎，请使用该
选项
调用CMake 。-DWITH_ARCHIVE_STORAGE_ENGINE
要检查ARCHIVE引擎的源代码，请查看storage/archiveMySQL 源代码分发目录。
您可以使用该
语句
检查ARCHIVE存储引擎是否可用。SHOW ENGINES
创建ARCHIVE表时，存储引擎会创建名称以表名开头的文件。数据文件的扩展名为.ARZ. .ARN在优化操作期间可能会出现
一个
文件。ARCHIVE引擎支持
, INSERT,
REPLACE和
SELECT，但不
支持DELETEor
UPDATE。它确实支持
ORDER BY操作、
BLOB列和空间数据类型（请参阅第 11.4.1 节，“空间数据类型”）。不支持地理空间参考系统。该ARCHIVE
引擎使用行级锁定。
ARCHIVE引擎支持
列AUTO_INCREMENT属性。该
AUTO_INCREMENT列可以具有唯一或非唯一索引。尝试在任何其他列上创建索引会导致错误。该ARCHIVE引擎还支持语句中的AUTO_INCREMENT表选项
CREATE TABLE，分别为新表指定初始序列值或为现有表重置序列值。
ARCHIVE不支持将值插入到AUTO_INCREMENT小于当前最大列值的列中。尝试这样做会导致
ER_DUP_KEY错误。
如果没有请求，引擎会忽略列，并在阅读时扫描
过去ARCHIVE。
BLOBARCHIVE存储引擎不支持分区
。
存储：行在插入时被压缩。该ARCHIVE引擎使用
zlib无损数据压缩（请参阅
http://www.zlib.net/）。您可以使用
OPTIMIZE TABLE来分析表格并将其打包成更小的格式（关于使用 的原因
OPTIMIZE TABLE，请参阅本节后面部分）。该引擎还支持CHECK
TABLE. 使用了几种类型的插入：
一条INSERT语句只是将行推入压缩缓冲区，并且该缓冲区会根据需要刷新。插入缓冲区受锁保护。ASELECT强制发生冲洗。
批量插入只有在完成后才可见，除非同时发生其他插入，在这种情况下只能部分看到。ASELECT永远不会导致批量插入的刷新，除非在加载时发生正常插入。
检索：检索时，行按需解压缩；没有行缓存。一个
SELECT操作执行完整的表扫描：当一个操作SELECT发生时，它会找出当前有多少行可用并读取该行数。SELECT作为一致读取执行。请注意
SELECT，除非仅使用批量插入，否则插入期间的大量语句会降低压缩率。为了获得更好的压缩效果，您可以使用
OPTIMIZE TABLE或
REPAIR TABLE。ARCHIVE报告的表
中的行数
SHOW TABLE STATUS始终是准确的。参见第 13.7.3.4 节，“OPTIMIZE TABLE 语句”，
第 13.7.3.5 节，“REPAIR TABLE 语句”，以及
第 13.7.7.38 节，“显示表状态语句”。
其他资源
专用于ARCHIVE存储引擎的论坛可在https://forums.mysql.com/list.php?112找到。
© Mysql 中文网
