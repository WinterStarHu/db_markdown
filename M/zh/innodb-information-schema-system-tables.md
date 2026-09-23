# 15.15.3 InnoDB INFORMATION_SCHEMA 模式对象表_MySQL 8.0 参考手册

15.15.3 InnoDB INFORMATION_SCHEMA 模式对象表_MySQL 8.0 参考手册
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
15.15.1 InnoDB INFORMATION_SCHEMA 表压缩1
15.15.2 InnoDB INFORMATION_SCHEMA 事务和锁定信息1
15.15.3 InnoDB INFORMATION_SCHEMA 模式对象表1
15.15.4 InnoDB INFORMATION_SCHEMA FULLTEXT 索引表1
15.15.5 InnoDB INFORMATION_SCHEMA 缓冲池表1
15.15.6 InnoDB INFORMATION_SCHEMA 指标表1
15.15.7 InnoDB INFORMATION_SCHEMA临时表信息表1
15.15.8 从 INFORMATION_SCHEMA.FILES 检索 InnoDB 表空间元数据1
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
MySQL 8.0 参考手册  / 第 15 章 InnoDB 存储引擎  / 15.15 InnoDB INFORMATION_SCHEMA 表  /
15.15.3 InnoDB INFORMATION_SCHEMA 模式对象表
15.15.3 InnoDB INFORMATION_SCHEMA 模式对象表
您可以提取有关
InnoDB使用InnoDB
INFORMATION_SCHEMA表管理的模式对象的元数据。此信息来自数据字典。传统上，您会使用第 15.17 节“InnoDB 监视器”中的技术获得此类信息
，设置
InnoDB监视器并解析
SHOW ENGINE INNODB
STATUS语句的输出。表InnoDB
INFORMATION_SCHEMA界面允许您使用 SQL 查询此数据。
InnoDB INFORMATION_SCHEMA
模式对象表包括下面列出的表。
INNODB_DATAFILES
INNODB_TABLESTATS
INNODB_FOREIGN
INNODB_COLUMNS
INNODB_INDEXES
INNODB_FIELDS
INNODB_TABLESPACES
INNODB_TABLESPACES_BRIEF
INNODB_FOREIGN_COLS
INNODB_TABLES
表名指示所提供数据的类型：
INNODB_TABLES提供有关InnoDB表的元数据。
INNODB_COLUMNS提供有关InnoDB表列的元数据。
INNODB_INDEXES提供有关InnoDB索引的元数据。
INNODB_FIELDS提供有关InnoDB
索引的键列（字段）的元数据。
INNODB_TABLESTATSInnoDB提供有关从内存数据结构派生的表
的低级状态信息的视图
。
INNODB_DATAFILESInnoDB
为file-per-table 和通用表空间
提供数据文件路径信息。
INNODB_TABLESPACES提供有关InnoDBfile-per-table、general 和 undo 表空间的元数据。
INNODB_TABLESPACES_BRIEF提供关于InnoDB
表空间的元数据子集。
INNODB_FOREIGNInnoDB
提供有关在表
上定义的外键的元数据。
INNODB_FOREIGN_COLS提供有关在表上定义的外键列的元数据
InnoDB。
InnoDB INFORMATION_SCHEMA
模式对象表可以通过 、 和 等字段连接在一起
TABLE_ID，INDEX_ID使
SPACE您可以轻松检索要研究或监控的对象的所有可用数据。
有关每个表的列的信息，请参阅InnoDB
INFORMATION_SCHEMA
文档。
示例 15.2 InnoDB INFORMATION_SCHEMA 模式对象表
t1此示例使用带有单个索引 ( )
的简单表 ( i1) 来演示在InnoDB
INFORMATION_SCHEMA架构对象表中找到的元数据类型。
创建一个测试数据库和表t1：
mysql> CREATE DATABASE test;
mysql> USE test;
mysql> CREATE TABLE t1 (
col1 INT,
col2 CHAR(10),
col3 VARCHAR(10))
ENGINE = InnoDB;
mysql> CREATE INDEX i1 ON t1(col1);
创建表后t1，查询
INNODB_TABLES以查找元数据test/t1：
mysql> SELECT * FROM INFORMATION_SCHEMA.INNODB_TABLES WHERE NAME='test/t1' \G
*************************** 1. row ***************************
TABLE_ID: 71
NAME: test/t1
FLAG: 1
N_COLS: 6
SPACE: 57
ROW_FORMAT: Compact
ZIP_PAGE_SIZE: 0
INSTANT_COLS: 0
表t1的 a
TABLE_ID为 71。该
FLAG字段提供有关表格式和存储特性的位级信息。有六列，其中三列是由
InnoDB( DB_ROW_ID、
DB_TRX_ID和
DB_ROLL_PTR) 创建的隐藏列。表的 ID
SPACE为 57（值为 0 表示该表驻留在系统表空间中）。ROW_FORMAT是紧凑
的
。ZIP_PAGE_SIZE仅适用于具有Compressed行格式的表。
显示在使用withINSTANT_COLS添加第一个即时列之前表中的列数
。
ALTER TABLE ... ADD
COLUMNALGORITHM=INSTANT
使用TABLE_ID来自 的信息
INNODB_TABLES查询
INNODB_COLUMNS表以获取有关表列的信息。
mysql> SELECT * FROM INFORMATION_SCHEMA.INNODB_COLUMNS where TABLE_ID = 71\G
*************************** 1. row ***************************
TABLE_ID: 71
NAME: col1
POS: 0
MTYPE: 6
PRTYPE: 1027
LEN: 4
HAS_DEFAULT: 0
DEFAULT_VALUE: NULL
*************************** 2. row ***************************
TABLE_ID: 71
NAME: col2
POS: 1
MTYPE: 2
PRTYPE: 524542
LEN: 10
HAS_DEFAULT: 0
DEFAULT_VALUE: NULL
*************************** 3. row ***************************
TABLE_ID: 71
NAME: col3
POS: 2
MTYPE: 1
PRTYPE: 524303
LEN: 10
HAS_DEFAULT: 0
DEFAULT_VALUE: NULL
除了TABLE_ID和列
之外NAME，
INNODB_COLUMNS还提供了每一列的序号位置（POS从0开始依次递增），列
MTYPE或者“主要类型”（6=INT，2=CHAR，1=VARCHAR），PRTYPE
或者“精确type ”（一个二进制值，带有表示 MySQL 数据类型、字符集代码和可空性的位）和列长度 ( LEN)。HAS_DEFAULT
和DEFAULT_VALUE列仅适用于使用
ALTER TABLE ... ADD
COLUMNwith立即添加的列ALGORITHM=INSTANT。
再次
使用TABLE_ID来自的信息
，查询与表关联的索引的信息
。
INNODB_TABLESINNODB_INDEXESt1mysql> SELECT * FROM INFORMATION_SCHEMA.INNODB_INDEXES WHERE TABLE_ID = 71 \G
*************************** 1. row ***************************
INDEX_ID: 111
NAME: GEN_CLUST_INDEX
TABLE_ID: 71
TYPE: 1
N_FIELDS: 0
PAGE_NO: 3
SPACE: 57
MERGE_THRESHOLD: 50
*************************** 2. row ***************************
INDEX_ID: 112
NAME: i1
TABLE_ID: 71
TYPE: 0
N_FIELDS: 1
PAGE_NO: 4
SPACE: 57
MERGE_THRESHOLD: 50
INNODB_INDEXES返回两个索引的数据。第一个索引是
，如果表没有用户定义的聚集索引GEN_CLUST_INDEX，它是创建的聚集索引。InnoDB第二个索引 ( i1) 是用户定义的二级索引。
是索引的INDEX_ID标识符，在一个实例中的所有数据库中是唯一的。TABLE_ID标识与索引关联的表。索引
TYPE值指示索引的类型（1 = 聚集索引，0 = 二级索引）。该
N_FILEDS值是组成索引的字段数。PAGE_NO是索引B树的根页码，
SPACE是索引所在表空间的ID。非零值表示索引不驻留在系统表空间中。
MERGE_THRESHOLD定义索引页中数据量的百分比阈值。如果在删除一行或更新操作缩短了一行时索引页中的数据量低于此值（默认值为 50%），则
InnoDB尝试将索引页与相邻索引页合并。
使用INDEX_ID来自的信息
INNODB_INDEXES，查询
INNODB_FIELDS有关索引字段的信息i1。
mysql> SELECT * FROM INFORMATION_SCHEMA.INNODB_FIELDS where INDEX_ID = 112 \G
*************************** 1. row ***************************
INDEX_ID: 112
NAME: col1
POS: 0
INNODB_FIELDS提供
NAME索引字段及其在索引中的序号位置。如果索引 (i1) 已在多个字段上定义，
INNODB_FIELDS将为每个索引字段提供元数据。
使用SPACE来自 的信息
INNODB_TABLES，查询
INNODB_TABLESPACES表以获取有关表的表空间的信息。
mysql> SELECT * FROM INFORMATION_SCHEMA.INNODB_TABLESPACES WHERE SPACE = 57 \G
*************************** 1. row ***************************
SPACE: 57
NAME: test/t1
FLAG: 16417
ROW_FORMAT: Dynamic
PAGE_SIZE: 16384
ZIP_PAGE_SIZE: 0
SPACE_TYPE: Single
FS_BLOCK_SIZE: 4096
FILE_SIZE: 114688
ALLOCATED_SIZE: 98304
AUTOEXTEND_SIZE: 0
SERVER_VERSION: 8.0.23
SPACE_VERSION: 1
ENCRYPTION: N
STATE: normal
除了表空间的SPACEID 和NAME关联表的 ID 外，INNODB_TABLESPACES
还提供表空间FLAG数据，即有关表空间格式和存储特性的位级信息。还提供了表空间
ROW_FORMAT、PAGE_SIZE和其他几个表空间元数据项。
再次
使用SPACE来自的信息
，查询表空间数据文件的位置。
INNODB_TABLESINNODB_DATAFILESmysql> SELECT * FROM INFORMATION_SCHEMA.INNODB_DATAFILES WHERE SPACE = 57 \G
*************************** 1. row ***************************
SPACE: 57
PATH: ./test/t1.ibd
数据文件位于test
MySQL 目录下的data目录中。如果
使用该语句的子句
在 MySQL 数据目录之外的位置创建了file-per-table 表空间
，则该表空间将是完全限定的目录路径。
DATA DIRECTORYCREATE TABLEPATHt1最后一步，向表( )
中插入一行
TABLE_ID = 71并查看
INNODB_TABLESTATS表中的数据。MySQL 优化器使用此表中的数据来计算查询
InnoDB表时使用哪个索引。此信息源自内存中的数据结构。
mysql> INSERT INTO t1 VALUES(5, 'abc', 'def');
Query OK, 1 row affected (0.06 sec)
mysql> SELECT * FROM INFORMATION_SCHEMA.INNODB_TABLESTATS where TABLE_ID = 71 \G
*************************** 1. row ***************************
TABLE_ID: 71
NAME: test/t1
STATS_INITIALIZED: Initialized
NUM_ROWS: 1
CLUST_INDEX_SIZE: 1
OTHER_INDEX_SIZE: 0
MODIFIED_COUNTER: 1
AUTOINC: 0
REF_COUNT: 1
该STATS_INITIALIZED字段指示是否已为表收集统计信息。
NUM_ROWS是表中当前估计的行数。CLUST_INDEX_SIZE和
字段分别报告磁盘上存储表的聚簇索引和二级索引的
OTHER_INDEX_SIZE页数。该
MODIFIED_COUNTER值显示由外键的 DML 操作和级联操作修改的行数。该AUTOINC值是为任何基于自动增量的操作发出的下一个数字。table 上没有定义自动增量列t1，因此值为 0。
REF_COUNT值是一个计数器。当计数器达到 0 时，表示表元数据可以从表缓存中逐出。
示例 15.3 外键 INFORMATION_SCHEMA 模式对象表
INNODB_FOREIGN和
INNODB_FOREIGN_COLS表提供有关外键关系的数据
。本示例使用具有外键关系的父表和子表来演示在
INNODB_FOREIGN和
INNODB_FOREIGN_COLS表中找到的数据。
使用父表和子表创建测试数据库：
mysql> CREATE DATABASE test;
mysql> USE test;
mysql> CREATE TABLE parent (id INT NOT NULL,
PRIMARY KEY (id)) ENGINE=INNODB;
mysql> CREATE TABLE child (id INT, parent_id INT,
INDEX par_ind (parent_id),
CONSTRAINT fk1
FOREIGN KEY (parent_id) REFERENCES parent(id)
ON DELETE CASCADE) ENGINE=INNODB;
父子表创建完成后，查询
INNODB_FOREIGN定位test/childand
test/parent外键关系的外键数据：
mysql> SELECT * FROM INFORMATION_SCHEMA.INNODB_FOREIGN \G
*************************** 1. row ***************************
ID: test/fk1
FOR_NAME: test/child
REF_NAME: test/parent
N_COLS: 1
TYPE: 1
元数据包括外键ID
( fk1)，它以
CONSTRAINT在子表上定义的 命名。FOR_NAME是定义外键的子表的名称
。REF_NAME是父表（“引用”表）的名称。
N_COLS是外键索引中的列数。TYPE是一个数值，表示提供有关外键列的附加信息的位标志。在本例中，
TYPE值为 1，表示
ON DELETE CASCADE为外键指定了选项。有关值的更多信息，请参阅
INNODB_FOREIGN表定义TYPE。
使用外键ID查询
INNODB_FOREIGN_COLS查看外键列的数据。
mysql> SELECT * FROM INFORMATION_SCHEMA.INNODB_FOREIGN_COLS WHERE ID = 'test/fk1' \G
*************************** 1. row ***************************
ID: test/fk1
FOR_COL_NAME: parent_id
REF_COL_NAME: id
POS: 0
FOR_COL_NAME是子表中外键列
REF_COL_NAME的名称，是父表中引用列的名称。该
POS值是外键索引中键字段的序号位置，从零开始。
示例 15.4 连接 InnoDB INFORMATION_SCHEMA 模式对象表
此示例演示连接三个
InnoDB INFORMATION_SCHEMA
模式对象表（INNODB_TABLES、
INNODB_TABLESPACES和
INNODB_TABLESTATS）以收集有关员工示例数据库中的表的文件格式、行格式、页面大小和索引大小信息。
以下表名别名用于缩短查询字符串：
INFORMATION_SCHEMA.INNODB_TABLES： 一个
INFORMATION_SCHEMA.INNODB_TABLESPACES: 乙
INFORMATION_SCHEMA.INNODB_TABLESTATS： C
IF()控制流函数用于解释压缩表
。如果表被压缩，索引大小是使用
ZIP_PAGE_SIZE而不是
计算的PAGE_SIZE。
CLUST_INDEX_SIZE和
OTHER_INDEX_SIZE以字节为单位报告，除以1024*1024以提供以兆字节 (MB) 为单位的索引大小。ROUND()
使用该函数
将 MB 值四舍五入为零小数位。mysql> SELECT a.NAME, a.ROW_FORMAT,
@page_size :=
IF(a.ROW_FORMAT='Compressed',
b.ZIP_PAGE_SIZE, b.PAGE_SIZE)
AS page_size,
ROUND((@page_size * c.CLUST_INDEX_SIZE)
/(1024*1024)) AS pk_mb,
ROUND((@page_size * c.OTHER_INDEX_SIZE)
/(1024*1024)) AS secidx_mb
FROM INFORMATION_SCHEMA.INNODB_TABLES a
INNER JOIN INFORMATION_SCHEMA.INNODB_TABLESPACES b on a.NAME = b.NAME
INNER JOIN INFORMATION_SCHEMA.INNODB_TABLESTATS c on b.NAME = c.NAME
WHERE a.NAME LIKE 'employees/%'
ORDER BY a.NAME DESC;
+------------------------+------------+-----------+-------+-----------+
| NAME                   | ROW_FORMAT | page_size | pk_mb | secidx_mb |
+------------------------+------------+-----------+-------+-----------+
| employees/titles       | Dynamic    |     16384 |    20 |        11 |
| employees/salaries     | Dynamic    |     16384 |    93 |        34 |
| employees/employees    | Dynamic    |     16384 |    15 |         0 |
| employees/dept_manager | Dynamic    |     16384 |     0 |         0 |
| employees/dept_emp     | Dynamic    |     16384 |    12 |        10 |
| employees/departments  | Dynamic    |     16384 |     0 |         0 |
+------------------------+------------+-----------+-------+-----------+
© Mysql 中文网
