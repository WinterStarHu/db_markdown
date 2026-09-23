# 15.8.11 配置索引页的合并阈值_MySQL 8.0 参考手册

15.8.11 配置索引页的合并阈值_MySQL 8.0 参考手册
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
15.8.11 配置索引页的合并阈值
15.8.11 配置索引页的合并阈值
您可以配置MERGE_THRESHOLD索引页的值。如果索引页的“ page-full ”百分比在删除行或通过操作
MERGE_THRESHOLD
缩短行时
低于该值，则尝试将索引页与相邻索引页合并。默认
值为 50，这是以前硬编码的值。最小值
为 1，最大值为 50。
UPDATEInnoDBMERGE_THRESHOLDMERGE_THRESHOLD
当索引页面的“ page-full ”百分比低于 50%（默认
MERGE_THRESHOLD设置）时，
InnoDB会尝试将索引页面与相邻页面合并。如果两个页面都接近 50% 满，则页面拆分可能会在页面合并后很快发生。如果这种合并-拆分行为频繁发生，可能会对性能产生不利影响。为避免频繁的合并拆分，您可以降低该MERGE_THRESHOLD值，以便
InnoDB尝试以较低的
“页面已满”百分比合并页面。以较低的页面填充百分比合并页面会在索引页面中留出更多空间，并有助于减少合并拆分行为。
MERGE_THRESHOLD可以为表或单个索引定义索引页
。为单个索引定义的
值MERGE_THRESHOLD优先于MERGE_THRESHOLD
为表定义的值。如果未定义，则该
MERGE_THRESHOLD值默认为 50。
为表设置 MERGE_THRESHOLD
您可以使用语句的子句
设置MERGE_THRESHOLD表的值。例如：
table_option
COMMENTCREATE TABLECREATE TABLE t1 (
id INT,
KEY id_index (id)
) COMMENT='MERGE_THRESHOLD=45';
您还可以使用
子句 withMERGE_THRESHOLD为现有表设置值
：
table_option COMMENTALTER TABLECREATE TABLE t1 (
id INT,
KEY id_index (id)
);
ALTER TABLE t1 COMMENT='MERGE_THRESHOLD=40';
为单个索引设置 MERGE_THRESHOLD
要设置MERGE_THRESHOLD单个索引的值，您可以使用
带有、
或
的
子句，如以下示例所示：
index_option COMMENTCREATE TABLEALTER TABLECREATE INDEX
使用以下方法设置MERGE_THRESHOLD单个索引CREATE TABLE：
CREATE TABLE t1 (
id INT,
KEY id_index (id) COMMENT 'MERGE_THRESHOLD=40'
);
使用以下方法设置MERGE_THRESHOLD单个索引ALTER TABLE：
CREATE TABLE t1 (
id INT,
KEY id_index (id)
);
ALTER TABLE t1 DROP KEY id_index;
ALTER TABLE t1 ADD KEY id_index (id) COMMENT 'MERGE_THRESHOLD=40';
使用以下方法设置MERGE_THRESHOLD单个索引CREATE INDEX：
CREATE TABLE t1 (id INT);
CREATE INDEX id_index ON t1 (id) COMMENT 'MERGE_THRESHOLD=40';
笔记
您不能修改MERGE_THRESHOLD索引级别的值，它是在没有主键或唯一键索引的情况下创建表时GEN_CLUST_INDEX创建的聚集索引。您只能
通过表的设置
来修改值
。
InnoDBInnoDBMERGE_THRESHOLDGEN_CLUST_INDEXMERGE_THRESHOLD
查询索引的 MERGE_THRESHOLD 值
索引的当前MERGE_THRESHOLD值可以通过查询
INNODB_INDEXES表来获得。例如：
mysql> SELECT * FROM INFORMATION_SCHEMA.INNODB_INDEXES WHERE NAME='id_index' \G
*************************** 1. row ***************************
INDEX_ID: 91
NAME: id_index
TABLE_ID: 68
TYPE: 0
N_FIELDS: 1
PAGE_NO: 4
SPACE: 57
MERGE_THRESHOLD: 40
如果使用子句
明确定义，
您可以使用SHOW CREATE TABLE查看表的值：MERGE_THRESHOLDtable_option COMMENTmysql> SHOW CREATE TABLE t2 \G
*************************** 1. row ***************************
Table: t2
Create Table: CREATE TABLE `t2` (
`id` int(11) DEFAULT NULL,
KEY `id_index` (`id`) COMMENT 'MERGE_THRESHOLD=40'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4
笔记
在索引级别定义的值MERGE_THRESHOLD优先于MERGE_THRESHOLD
为表定义的值。如果未定义，
则MERGE_THRESHOLD默认为 50% ( MERGE_THRESHOLD=50，这是之前硬编码的值。
同样，如果使用子句
明确定义
，您可以使用SHOW INDEX查看索引的值：MERGE_THRESHOLDindex_option COMMENTmysql> SHOW INDEX FROM t2 \G
*************************** 1. row ***************************
Table: t2
Non_unique: 1
Key_name: id_index
Seq_in_index: 1
Column_name: id
Collation: A
Cardinality: 0
Sub_part: NULL
Packed: NULL
Null: YES
Index_type: BTREE
Comment:
Index_comment: MERGE_THRESHOLD=40
测量 MERGE_THRESHOLD 设置的效果
该INNODB_METRICS表提供了两个计数器，可用于衡量
MERGE_THRESHOLD设置对索引页面合并的影响。
mysql> SELECT NAME, COMMENT FROM INFORMATION_SCHEMA.INNODB_METRICS
WHERE NAME like '%index_page_merge%';
+-----------------------------+----------------------------------------+
| NAME                        | COMMENT                                |
+-----------------------------+----------------------------------------+
| index_page_merge_attempts   | Number of index page merge attempts    |
| index_page_merge_successful | Number of successful index page merges |
+-----------------------------+----------------------------------------+
降低MERGE_THRESHOLD价值时，目标是：
更少的页面合并尝试和成功的页面合并
相似数量的页面合并尝试和成功的页面合并
由于过多的MERGE_THRESHOLD空白页面空间，设置太小可能会导致数据文件很大。
有关使用
INNODB_METRICS计数器的信息，请参阅
第 15.15.6 节，“InnoDB INFORMATION_SCHEMA 指标表”。
© Mysql 中文网
