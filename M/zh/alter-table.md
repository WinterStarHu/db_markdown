# 13.1.9 ALTER TABLE 语句_MySQL 8.0 参考手册

13.1.9 ALTER TABLE 语句_MySQL 8.0 参考手册
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
13.1 数据定义语句
13.1.1 原子数据定义语句支持1
13.1.2 ALTER DATABASE 语句1
13.1.3 ALTER EVENT 语句1
13.1.4 ALTER FUNCTION 语句1
13.1.5 ALTER INSTANCE 语句1
13.1.6 ALTER LOGFILE GROUP 语句1
13.1.7 ALTER PROCEDURE 语句1
13.1.8 ALTER SERVER 语句1
13.1.9 ALTER TABLE 语句1
13.1.9.1 ALTER TABLE 分区操作
13.1.9.2 ALTER TABLE 和生成的列
13.1.9.3 更改表示例
13.1.10 ALTER TABLESPACE 语句1
13.1.11 ALTER VIEW 语句1
13.1.12 CREATE DATABASE 语句1
13.1.13 CREATE EVENT 语句1
13.1.14 CREATE FUNCTION 语句1
13.1.15 CREATE INDEX 语句1
13.1.16 CREATE LOGFILE GROUP 语句1
13.1.17 CREATE PROCEDURE 和 CREATE FUNCTION 语句1
13.1.18 CREATE SERVER 语句1
13.1.19 CREATE SPATIAL REFERENCE SYSTEM 语句1
13.1.20 CREATE TABLE 语句1
13.1.21 CREATE TABLESPACE 语句1
13.1.22 CREATE TRIGGER 语句1
13.1.23 CREATE VIEW 语句1
13.1.24 DROP DATABASE 语句1
13.1.25 DROP EVENT 语句1
13.1.26 DROP FUNCTION 语句1
13.1.27 DROP INDEX 语句1
13.1.28 DROP LOGFILE GROUP 语句1
13.1.29 DROP PROCEDURE 和 DROP FUNCTION 语句1
13.1.30 DROP SERVER 语句1
13.1.31 DROP SPATIAL REFERENCE SYSTEM 语句1
13.1.32 DROP TABLE 语句1
13.1.33 DROP TABLESPACE 语句1
13.1.34 DROP TRIGGER 语句1
13.1.35 DROP VIEW 语句1
13.1.36 RENAME TABLE 语句1
13.1.37 TRUNCATE TABLE 语句1
13.2 数据操作语句
13.3 事务和锁定语句
13.4 复制语句
13.5 准备好的语句
13.6 复合语句语法
13.7 数据库管理语句
13.8 效用语句
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
MySQL 8.0 参考手册  / 第 13 章 SQL 语句  / 13.1 数据定义语句  /
13.1.9 ALTER TABLE 语句
13.1.9 ALTER TABLE 语句
13.1.9.1 ALTER TABLE 分区操作13.1.9.2 ALTER TABLE 和生成的列13.1.9.3 更改表示例
ALTER TABLE tbl_name
[alter_option [, alter_option] ...]
[partition_options]
alter_option: {
table_options
| ADD [COLUMN] col_name column_definition
[FIRST | AFTER col_name]
| ADD [COLUMN] (col_name column_definition,...)
| ADD {INDEX | KEY} [index_name]
[index_type] (key_part,...) [index_option] ...
| ADD {FULLTEXT | SPATIAL} [INDEX | KEY] [index_name]
(key_part,...) [index_option] ...
| ADD [CONSTRAINT [symbol]] PRIMARY KEY
[index_type] (key_part,...)
[index_option] ...
| ADD [CONSTRAINT [symbol]] UNIQUE [INDEX | KEY]
[index_name] [index_type] (key_part,...)
[index_option] ...
| ADD [CONSTRAINT [symbol]] FOREIGN KEY
[index_name] (col_name,...)
reference_definition
| ADD [CONSTRAINT [symbol]] CHECK (expr) [[NOT] ENFORCED]
| DROP {CHECK | CONSTRAINT} symbol
| ALTER {CHECK | CONSTRAINT} symbol [NOT] ENFORCED
| ALGORITHM [=] {DEFAULT | INSTANT | INPLACE | COPY}
| ALTER [COLUMN] col_name {
SET DEFAULT {literal | (expr)}
| SET {VISIBLE | INVISIBLE}
| DROP DEFAULT
}
| ALTER INDEX index_name {VISIBLE | INVISIBLE}
| CHANGE [COLUMN] old_col_name new_col_name column_definition
[FIRST | AFTER col_name]
| [DEFAULT] CHARACTER SET [=] charset_name [COLLATE [=] collation_name]
| CONVERT TO CHARACTER SET charset_name [COLLATE collation_name]
| {DISABLE | ENABLE} KEYS
| {DISCARD | IMPORT} TABLESPACE
| DROP [COLUMN] col_name
| DROP {INDEX | KEY} index_name
| DROP PRIMARY KEY
| DROP FOREIGN KEY fk_symbol
| FORCE
| LOCK [=] {DEFAULT | NONE | SHARED | EXCLUSIVE}
| MODIFY [COLUMN] col_name column_definition
[FIRST | AFTER col_name]
| ORDER BY col_name [, col_name] ...
| RENAME COLUMN old_col_name TO new_col_name
| RENAME {INDEX | KEY} old_index_name TO new_index_name
| RENAME [TO | AS] new_tbl_name
| {WITHOUT | WITH} VALIDATION
}
partition_options:
partition_option [partition_option] ...
partition_option: {
ADD PARTITION (partition_definition)
| DROP PARTITION partition_names
| DISCARD PARTITION {partition_names | ALL} TABLESPACE
| IMPORT PARTITION {partition_names | ALL} TABLESPACE
| TRUNCATE PARTITION {partition_names | ALL}
| COALESCE PARTITION number
| REORGANIZE PARTITION partition_names INTO (partition_definitions)
| EXCHANGE PARTITION partition_name WITH TABLE tbl_name [{WITH | WITHOUT} VALIDATION]
| ANALYZE PARTITION {partition_names | ALL}
| CHECK PARTITION {partition_names | ALL}
| OPTIMIZE PARTITION {partition_names | ALL}
| REBUILD PARTITION {partition_names | ALL}
| REPAIR PARTITION {partition_names | ALL}
| REMOVE PARTITIONING
}
key_part: {col_name [(length)] | (expr)} [ASC | DESC]
index_type:
USING {BTREE | HASH}
index_option: {
KEY_BLOCK_SIZE [=] value
| index_type
| WITH PARSER parser_name
| COMMENT 'string'
| {VISIBLE | INVISIBLE}
}
table_options:
table_option [[,] table_option] ...
table_option: {
AUTOEXTEND_SIZE [=] value
| AUTO_INCREMENT [=] value
| AVG_ROW_LENGTH [=] value
| [DEFAULT] CHARACTER SET [=] charset_name
| CHECKSUM [=] {0 | 1}
| [DEFAULT] COLLATE [=] collation_name
| COMMENT [=] 'string'
| COMPRESSION [=] {'ZLIB' | 'LZ4' | 'NONE'}
| CONNECTION [=] 'connect_string'
| {DATA | INDEX} DIRECTORY [=] 'absolute path to directory'
| DELAY_KEY_WRITE [=] {0 | 1}
| ENCRYPTION [=] {'Y' | 'N'}
| ENGINE [=] engine_name
| ENGINE_ATTRIBUTE [=] 'string'
| INSERT_METHOD [=] { NO | FIRST | LAST }
| KEY_BLOCK_SIZE [=] value
| MAX_ROWS [=] value
| MIN_ROWS [=] value
| PACK_KEYS [=] {0 | 1 | DEFAULT}
| PASSWORD [=] 'string'
| ROW_FORMAT [=] {DEFAULT | DYNAMIC | FIXED | COMPRESSED | REDUNDANT | COMPACT}
| SECONDARY_ENGINE_ATTRIBUTE [=] 'string'
| STATS_AUTO_RECALC [=] {DEFAULT | 0 | 1}
| STATS_PERSISTENT [=] {DEFAULT | 0 | 1}
| STATS_SAMPLE_PAGES [=] value
| TABLESPACE tablespace_name [STORAGE {DISK | MEMORY}]
| UNION [=] (tbl_name[,tbl_name]...)
}
partition_options:
(see CREATE TABLE options)
ALTER TABLE改变表的结构。例如，您可以添加或删除列、创建或销毁索引、更改现有列的类型或重命名列或表本身。您还可以更改特性，例如用于表或表注释的存储引擎。
要使用ALTER TABLE，您需要
ALTER、
CREATE和
INSERT表权限。重命名表需要
在旧表上、
、
和
ALTER新
表上。
DROPALTERCREATEINSERT
在表名之后，指定要进行的更改。如果没有给出，ALTER TABLE
什么都不做。
许多允许的更改的语法类似于语句的子句CREATE TABLE
。column_definition
子句使用与 forADD和
CHANGEfor相同的语法CREATE
TABLE。有关详细信息，请参阅
第 13.1.20 节，“CREATE TABLE 语句”。
该词COLUMN是可选的，可以省略，除了RENAME COLUMN（以区分列重命名操作和
RENAME表重命名操作）。
单个语句中允许有
多个ADD, ALTER,
DROP, 和子句，以逗号分隔。这是标准 SQL 的 MySQL 扩展，它只允许每个
语句中的每个子句之一。例如，要在单个语句中删除多个列，请执行以下操作：
CHANGEALTER
TABLEALTER TABLEALTER TABLE t2 DROP COLUMN c, DROP COLUMN d;
如果存储引擎不支持尝试的
ALTER TABLE操作，则可能会产生警告。此类警告可以用 显示
SHOW WARNINGS。请参阅
第 13.7.7.42 节，“显示警告声明”。有关故障排除的信息ALTER TABLE，请参阅第 B.3.6.1 节，“ALTER TABLE 的问题”。
有关生成的列的信息，请参阅
第 13.1.9.2 节，“ALTER TABLE 和生成的列”。
有关用法示例，请参阅
第 13.1.9.3 节，“ALTER TABLE 示例”。
InnoDB在 MySQL 8.0.17 及更高版本中支持使用规范在 JSON 列上添加多值索引
key_part可以采用. 有关
多值索引的创建和使用以及多值索引的约束和限制的详细信息，请参阅多值索引。
(CAST json_path AS
type ARRAY)
使用mysql_info()C API 函数，您可以找出 .copy 了多少行
ALTER TABLE。请参阅
mysql_info()。
该声明还有几个其他方面，ALTER
TABLE在本节的以下主题下进行了描述：
表格选项性能和空间要求并发控制添加和删​​除列重命名、重新定义和重新排序列主键和索引外键和其他约束更改字符集导入 InnoDB 表MyISAM 表的行顺序分区选项
表格选项
table_options表示可在CREATE
TABLE语句中使用的那种表选项，例如ENGINE、
AUTO_INCREMENT、
AVG_ROW_LENGTH、MAX_ROWS、
ROW_FORMAT或TABLESPACE。
有关所有表选项的说明，请参阅
第 13.1.20 节，“CREATE TABLE 语句”。但是，
ALTER TABLE忽略DATA
DIRECTORY和INDEX DIRECTORY作为表选项给出时。ALTER TABLE
只允许它们作为分区选项，并要求您有FILE权限。
使用表选项ALTER
TABLE提供了一种更改单个表特征的便捷方法。例如：
如果t1当前不是
InnoDB表，则此语句将其存储引擎更改为InnoDB：
ALTER TABLE t1 ENGINE = InnoDB;
有关将表切换到
存储引擎
时的注意事项，
请参阅第 15.6.1.5 节，“将表从 MyISAM 转换为 InnoDB” 。InnoDB
当您指定一个ENGINE子句时，
ALTER TABLE重建表。即使表已经具有指定的存储引擎也是如此。
在现有
表上
运行会执行
“空”操作，可用于对表进行碎片整理，如
第 15.11.4 节“对表进行碎片整理”中所述。在
表上运行
执行相同的功能。
ALTER
TABLE tbl_name
ENGINE=INNODBInnoDB ALTER
TABLEInnoDBALTER TABLE
tbl_name FORCEInnoDB
ALTER TABLE
tbl_name
ENGINE=INNODB并
使用
在线 DDL。有关详细信息，请参阅第 15.12 节，“InnoDB 和在线 DDL”。
ALTER TABLE
tbl_name FORCE
尝试更改表的存储引擎的结果受所需存储引擎是否可用和
NO_ENGINE_SUBSTITUTION
SQL 模式设置的影响，如第 5.1.11 节，“服务器 SQL 模式”中所述。
为防止无意中丢失数据，
ALTER TABLE不能用于将表的存储引擎更改为
MERGE或BLACKHOLE。
要更改InnoDB表以使用压缩行存储格式：
ALTER TABLE t1 ROW_FORMAT = COMPRESSED;
该ENCRYPTION子句为表启用或禁用页级数据加密InnoDB
。必须安装并配置密钥环插件以启用加密。
如果
table_encryption_privilege_check
启用该变量，
TABLE_ENCRYPTION_ADMIN
则需要特权才能使用具有ENCRYPTION
不同于默认模式加密设置的设置的子句。
在 MySQL 8.0.16 之前，ENCRYPTION
只有在更改驻留在 file-per-table 表空间中的表时才支持该子句。从 MySQL 8.0.16 开始，
ENCRYPTION驻留在通用表空间中的表也支持该子句。
对于驻留在通用表空间中的表，表和表空间加密必须匹配。
ENCRYPTION
在没有明确指定子句
的情况下，不允许通过将表移动到不同的表空间或更改存储引擎来更改表加密。从 MySQL 8.0.16 开始，如果表使用不支持加密的存储引擎，则不允许使用orENCRYPTION以外的值
指定
子句。此前，该条款被接受。也不允许
尝试使用不支持加密的存储引擎在启用加密的模式中创建没有子句的表
。'N'''ENCRYPTION
有关更多信息，请参阅
第 15.13 节，“InnoDB 静态数据加密”。
要重置当前的自动增量值：
ALTER TABLE t1 AUTO_INCREMENT = 13;
您不能将计数器重置为小于或等于当前使用的值的值。对于
InnoDB和MyISAM，如果值小于或等于AUTO_INCREMENT列中当前的最大值，则将值重置为当前最大AUTO_INCREMENT
列值加一。
要更改默认表字符集：
ALTER TABLE t1 CHARACTER SET = utf8mb4;
另请参阅更改字符集。
添加（或更改）表注释：
ALTER TABLE t1 COMMENT = 'New table comment';ALTER TABLE与
TABLESPACE选项一起
使用可InnoDB在现有
通用表空间、
file-per-table 表
空间和
系统表空间之间移动表。请参阅
使用 ALTER TABLE 在表空间之间移动表。
ALTER TABLE ... TABLESPACE操作总是会导致完整的表重建，即使该
TABLESPACE属性未从其先前的值更改。
ALTER TABLE ... TABLESPACE语法不支持将表从临时表空间移动到持久表空间。
支持的DATA DIRECTORY子句不受支持
CREATE TABLE
... TABLESPACE，
ALTER TABLE ... TABLESPACE如果指定则忽略。
有关该TABLESPACE选项的功能和限制的更多信息，请参阅CREATE TABLE。
MySQL NDB Cluster 8.0 支持设置
NDB_TABLE选项来控制表的分区平衡（片段计数类型）、从任何副本读取能力、完全复制或这些的任意组合，作为
ALTER TABLE语句的表注释的一部分以相同的方式至于CREATE TABLE，如本例所示：
ALTER TABLE t1 COMMENT = "NDB_TABLE=READ_BACKUP=0,PARTITION_BALANCE=FOR_RA_BY_NODE";
也可以将表NDB_COMMENT
列的选项设置为语句
NDB的一部分，如下所示：ALTER TABLEALTER TABLE t1
CHANGE COLUMN c1 c1 BLOB
COMMENT = 'NDB_COLUMN=BLOB_INLINE_SIZE=4096,MAX_BLOB_PART_SIZE';
NDB 8.0.30 及更高版本支持以这种方式设置 blob 内联大小。请记住，ALTER TABLE
... COMMENT ...丢弃表的任何现有注释。有关其他信息和示例，
请参阅
设置 NDB_TABLE 选项。
ENGINE_ATTRIBUTE和
SECONDARY_ENGINE_ATTRIBUTE选项（自 MySQL 8.0.21 起可用）用于指定主存储引擎和辅助存储引擎的表、列和索引属性。这些选项保留供将来使用。不能更改索引属性。必须删除一个索引并用所需的更改添加回来，这可以在单个ALTER TABLE语句中执行。
要验证表选项是否按预期更改，请使用
SHOW CREATE TABLE或查询
INFORMATION_SCHEMA.TABLES表。
性能和空间要求
ALTER TABLE使用以下算法之一处理操作：
COPY：对原表的副本进行操作，将原表的表数据逐行复制到新表中。不允许并发 DML。
INPLACE：操作避免复制表数据，但可能会重建表。在操作的准备和执行阶段可能会短暂地获取表上的独占元数据锁。通常，支持并发 DML。
INSTANT：操作只修改数据字典中的元数据。在操作的执行阶段可能会短暂地获取表上的独占元数据锁。表数据不受影响，使操作即时进行。允许并发 DML。(MySQL 8.0.12引入)
对于使用NDB存储引擎的表，这些算法的工作原理如下：
COPY：NDB创建表的副本并更改它；NDB Cluster 处理程序然后在表的旧版本和新版本之间复制数据。随后，NDB删除旧表并重命名新表。
这有时也称为“复制”
或“离线” ALTER TABLE。
INPLACE：数据节点进行所需的更改；NDB Cluster 处理程序不复制数据或以其他方式参与。
这有时也称为
“非复制”或“在线”
ALTER TABLE。
INSTANT: 不支持
NDB。
有关更多信息，请参阅第 23.6.11 节，“在 NDB Cluster 中使用 ALTER TABLE 进行在线操作”。
该ALGORITHM子句是可选的。如果
ALGORITHM省略该子句，MySQL 将使用
支持它ALGORITHM=INSTANT的存储引擎和
ALTER TABLE子句。否则，ALGORITHM=INPLACE使用。如果
ALGORITHM=INPLACE不支持，
ALGORITHM=COPY则使用。
笔记
使用 向分区表添加列后
ALGORITHM=INSTANT，无法再
ALTER
TABLE ... EXCHANGE PARTITION对该表执行操作。
指定一个ALGORITHM子句要求操作对支持它的子句和存储引擎使用指定的算法，否则会失败并出现错误。指定ALGORITHM=DEFAULT与省略ALGORITHM子句相同。
ALTER TABLE使用该
COPY算法的操作等待正在修改表的其他操作完成。对表副本应用更改后，数据被复制过来，原始表被删除，表副本被重命名为原始表的名称。当ALTER TABLE
操作执行时，原始表可被其他会话读取（例外情况稍后会注明）。操作开始后对表的更新和写入将ALTER
TABLE停止，直到新表准备就绪，然后自动重定向到新表。表的临时副本在原始表的数据库目录中创建，除非它是RENAME TO
将表移动到驻留在不同目录中的数据库的操作。
前面提到的例外是
ALTER TABLE在准备好从表和表定义缓存中清除过时的表结构时阻止读取（而不仅仅是写入）。此时，它必须获得一个独占锁。为此，它等待当前读者完成，并阻止新的读写。
ALTER TABLE使用该算法
的操作COPY可防止并发 DML 操作。仍然允许并发查询。也就是说，一个表复制操作总是至少包括LOCK=SHARED（允许查询但不包括 DML）的并发限制。您可以通过指定 来进一步限制支持该LOCK子句的
操作的并发性LOCK=EXCLUSIVE，这会阻止 DML 和查询。有关详细信息，请参阅
并发控制。
要强制将COPY算法用于
ALTER TABLE原本不会使用它的操作，请指定ALGORITHM=COPY或启用old_alter_table系统变量。old_alter_table如果设置与
ALGORITHM值不是 的子句
之间存在冲突
DEFAULT，则该ALGORITHM
子句优先。
对于InnoDB表，
对驻留在
共享表空间ALTER TABLE中的表使用该算法的操作
会增加表空间使用的空间量。此类操作需要与表中的数据加上索引一样多的额外空间。对于驻留在共享表空间中的表，操作期间使用的额外空间不会释放回操作系统，就像驻留在file-per-table 表空间中的表一样
。
COPY
有关在线 DDL 操作的空间要求的信息，请参阅
第 15.12.3 节，“在线 DDL 空间要求”。
ALTER TABLE支持该INPLACE算法的操作包括：
ALTER TABLEInnoDB
在线 DDL功能支持的操作
。请参阅
第 15.12.1 节，“在线 DDL 操作”。
重命名表。MySQL 重命名与表对应的文件tbl_name而不制作副本。（您也可以使用RENAME
TABLE语句重命名表。请参阅
第 13.1.36 节，“RENAME TABLE 语句”。）专门为重命名表授予的权限不会迁移到新名称。它们必须手动更改。
仅修改表元数据的操作。这些操作是即时的，因为服务器不接触表内容。仅元数据操作包括：
重命名列。在 NDB Cluster 8.0.18 及更高版本中，此操作也可以在线执行。
更改列的默认值（
NDB表除外）。
通过将新的枚举或集合成员添加到有效成员值列表的末尾ENUM来修改or
列
的定义
，只要数据类型的存储大小不变即可。例如，向具有 8 个成员的列添加一个成员会将每个值所需的存储空间从 1 个字节更改为 2 个字节；这需要一个表副本。在列表中间添加成员会导致现有成员重新编号，这需要表副本。
SETSET
更改空间列的定义以删除
SRID属性。（添加或更改
SRID属性需要重建，并且不能就地完成，因为服务器必须验证所有值是否都具有指定SRID
值。）
从 MySQL 8.0.14 开始，当这些条件适用时，更改列字符集：
列数据类型是
CHAR、
VARCHAR、
TEXT类型或
ENUM。
字符集更改是从
utf8mb3到
utf8mb4，或任何字符集到
binary。
列上没有索引。
从 MySQL 8.0.14 开始，当这些条件适用时，更改生成的列：
对于InnoDB表，修改生成的存储列但不更改其类型、表达式或可空性的语句。
对于非InnoDB表，修改生成的存储列或虚拟列但不更改其类型、表达式或可空性的语句。
此类更改的一个示例是对列注释的更改。
重命名索引。
InnoDB为和
NDB表
添加或删除二级索引
。请参阅
第 15.12.1 节，“在线 DDL 操作”。
对于NDB表，在可变宽度列上添加和删除索引的操作。这些操作在线发生，没有表复制，也没有在大部分持续时间内阻止并发 DML 操作。请参阅第 23.6.11 节，“在 NDB Cluster 中使用 ALTER TABLE 进行在线操作”。
使用操作修改索引可见性ALTER
INDEX。
DEFAULT如果修改的列不包含在生成的列表达式中，则
包含生成的列的表的列修改依赖于具有值的列。例如，更改
NULL单独列的属性可以在不重建表的情况下就地完成。
ALTER TABLE支持该
INSTANT算法的操作包括：
添加一列。此功能称为“即时
ADD COLUMN”。限制适用。请参阅
第 15.12.1 节，“在线 DDL 操作”。
删除列。此功能称为
“即时DROP COLUMN”。限制适用。请参阅
第 15.12.1 节，“在线 DDL 操作”。
添加或删除虚拟列。
添加或删除列默认值。
修改
ENUMor
SET列的定义。与上述相同的限制适用于
ALGORITHM=INSTANT.
更改索引类型。
重命名表。与上述相同的限制适用于ALGORITHM=INSTANT.
有关支持的操作的更多信息
ALGORITHM=INSTANT，请参阅
第 15.12.1 节，“在线 DDL 操作”。
ALTER TABLE将 MySQL 5.5 临时列升级到 5.6 格式，用于ADD COLUMN、
CHANGE COLUMN、MODIFY
COLUMN、ADD INDEX和
FORCE操作。INPLACE由于必须重建表，因此
无法使用该算法完成此转换，因此ALGORITHM=INPLACE在这些情况下指定会导致错误。ALGORITHM=COPY必要时
指定。
如果ALTER TABLE对用于对表进行分区的多列索引的操作KEY更改了列的顺序，则只能使用
ALGORITHM=COPY.
WITHOUT VALIDATIONandWITH
VALIDATION子句影响是否
对虚拟生成的列修改ALTER TABLE执行就地操作
。请参阅
第 13.1.9.2 节，“ALTER TABLE 和生成的列”。
ALGORITHM=INPLACENDB Cluster 8.0使用与标准 MySQL 服务器
相同的语法支持在线操作
。NDB不支持在线更改表空间；从 NDB 8.0.21 开始，这是不允许的。有关更多信息，请参阅第 23.6.11 节，“在 NDB Cluster 中使用 ALTER TABLE 进行在线操作”。
NDB 8.0.27 及更高版本，在执行复制时ALTER
TABLE，检查以确保没有对受影响的表进行并发写入。如果它发现已经做了任何事情，则NDB拒绝该ALTER
TABLE声明并提出
ER_TABLE_DEF_CHANGED.
ALTER TABLE使用DISCARD ... PARTITION
... TABLESPACE或IMPORT ... PARTITION ...
TABLESPACE不创建任何临时表或临时分区文件。
ALTER TABLEwith ADD
PARTITION, DROP PARTITION,
COALESCE PARTITION, REBUILD
PARTITION, orREORGANIZE PARTITION
不创建临时表（与
NDB表一起使用时除外）；但是，这些操作可以而且确实会创建临时分区文件。
ADDor或partitions 的DROP操作
是立即操作或几乎是立即操作。or
操作
或分区在所有分区之间复制数据，除非使用or
；这实际上与创建新表相同，尽管
or操作是逐个分区执行的。操作仅复制已更改的分区，而不会触及未更改的分区。
RANGELISTADDCOALESCEHASHKEYLINEAR HASHLINEAR KEYADDCOALESCEREORGANIZE
对于表，您可以通过将系统变量设置为较高的值
MyISAM来加快重新创建索引（更改过程中最慢的部分）
。myisam_sort_buffer_size
并发控制
对于ALTER TABLE支持它的操作，您可以使用该LOCK子句来控制表被更改时的并发读写级别。为该子句指定一个非默认值使您能够在更改操作期间要求一定数量的并发访问或排他性，并在请求的锁定程度不可用时停止操作。
仅LOCK = DEFAULT允许使用ALGORITHM=INSTANT. 其他
LOCK子句参数不适用。
该LOCK子句的参数是：
LOCK = DEFAULT
给定
ALGORITHM子句（如果有）和
ALTER TABLE操作的最大并发级别：如果支持，则允许并发读取和写入。如果不支持，则允许并发读取（如果支持）。如果不是，则强制执行独占访问。
LOCK = NONE
如果支持，则允许并发读取和写入。否则，会发生错误。
LOCK = SHARED
如果支持，则允许并发读取但阻止写入。即使给定ALGORITHM
子句（如果有）和ALTER TABLE操作的存储引擎支持并发写入，写入也会被阻止。如果不支持并发读取，则会发生错误。
LOCK = EXCLUSIVE
强制执行独占访问。即使存储引擎支持给定
ALGORITHM子句（如果有）和
ALTER TABLE操作的并发读/写，也会这样做。
添加和删​​除列
用于ADD向表中添加新列，以及
DROP删除现有列。是标准 SQL 的 MySQL 扩展。
DROP
col_name
要在表格行内的特定位置添加列，请使用
FIRST或。默认是最后添加列。
AFTER
col_name
如果一个表只包含一列，则不能删除该列。如果您打算删除表，请改用该
DROP TABLE语句。
如果从表中删除列，则这些列也会从它们所属的任何索引中删除。如果组成索引的所有列都被删除，那么索引也会被删除。如果使用
CHANGEorMODIFY来缩短列上存在索引的列，并且生成的列长度小于索引长度，MySQL 会自动缩短索引。
对于ALTER TABLE ... ADD，如果该列具有使用非确定性函数的表达式默认值，则该语句可能会产生警告或错误。有关详细信息，请参阅第 11.6 节，“数据类型默认值”和
第 17.1.3.7 节，“使用 GTID 进行复制的限制”。
重命名、重新定义和重新排序列
、CHANGE、MODIFY和
子句允许更改现有列的名称和定义RENAME COLUMN。ALTER它们具有以下比较特征：
CHANGE:
可以重命名列并更改其定义，或两者兼而有之。
MODIFY比or
具有更多的能力RENAME COLUMN，但以牺牲某些操作的便利性为代价。CHANGE
如果不重命名，则需要对列命名两次，如果仅重命名，则需要重新指定列定义。
使用FIRST或AFTER，可以对列重新排序。
MODIFY:
可以更改列定义但不能更改其名称。
CHANGE比在不重命名的情况下更改列定义
更方便。
使用FIRST或AFTER，可以对列重新排序。
RENAME COLUMN:
可以更改列名但不能更改其定义。
CHANGE比在不更改其定义的情况下重命名列
更方便。
ALTER：仅用于更改列默认值。
CHANGE是标准 SQL 的 MySQL 扩展。
MODIFY并且RENAME COLUMN是 Oracle 兼容性的 MySQL 扩展。
要更改列以更改其名称和定义，请使用
CHANGE，指定旧名称和新名称以及新定义。例如，要将INT NOT
NULL列从重命名为ato
b并将其定义更改为
BIGINT在保留
NOT NULL属性的同时使用数据类型，请执行以下操作：
ALTER TABLE t1 CHANGE a b BIGINT NOT NULL;
要更改列定义但不更改其名称，请使用
CHANGE或MODIFY。对于
CHANGE，语法需要两个列名，因此您必须指定相同的名称两次才能保持名称不变。例如，要更改 column 的定义
b，请执行以下操作：
ALTER TABLE t1 CHANGE b b INT NOT NULL;
MODIFY在不更改名称的情况下更改定义更方便，因为它只需要列名一次：
ALTER TABLE t1 MODIFY b INT NOT NULL;
要更改列名但不更改其定义，请使用
CHANGE或RENAME COLUMN。对于CHANGE，语法需要列定义，因此要保持定义不变，您必须重新指定列当前具有的定义。例如，要将INT NOT NULL列
从重命名b为a，请执行以下操作：
ALTER TABLE t1 CHANGE b a INT NOT NULL;
RENAME COLUMN在不更改定义的情况下更改名称更方便，因为它只需要旧名称和新名称：
ALTER TABLE t1 RENAME COLUMN b TO a;
通常，您不能将列重命名为表中已存在的名称。但是，有时情况并非如此，例如当您交换名称或在循环中移动它们时。如果表中有名为a、b和
的列c，则这些是有效操作：
-- swap a and b
ALTER TABLE t1 RENAME COLUMN a TO b,
RENAME COLUMN b TO a;
-- "rotate" a, b, c through a cycle
ALTER TABLE t1 RENAME COLUMN a TO b,
RENAME COLUMN b TO c,
RENAME COLUMN c TO a;CHANGE对于使用or
的
列定义更改MODIFY，定义必须包括数据类型和应应用于新列的所有属性，而不是诸如PRIMARY KEYor
之类的索引属性UNIQUE。原始定义中存在但未为新定义指定的属性不会被继承。假设一列col1定义为INT UNSIGNED DEFAULT 1 COMMENT 'my
column'，您按如下方式修改该列，仅打算更改INT为
BIGINT：
ALTER TABLE t1 MODIFY col1 BIGINT;
该语句将数据类型从 更改INT
为BIGINT，但它也删除了
UNSIGNED、DEFAULT和
COMMENT属性。要保留它们，语句必须明确包括它们：
ALTER TABLE t1 MODIFY col1 BIGINT UNSIGNED DEFAULT 1 COMMENT 'my column';CHANGE对于使用or
的数据类型更改MODIFY，MySQL 会尽可能地将现有列值转换为新类型。
警告
这种转换可能会导致数据更改。例如，如果您缩短字符串列，值可能会被截断。如果转换为新数据类型会导致数据丢失，为防止操作成功，请在使用前启用严格 SQL 模式ALTER TABLE（请参阅
第 5.1.11 节，“服务器 SQL 模式”）。
如果使用CHANGEorMODIFY
来缩短列上存在索引的列，并且生成的列长度小于索引长度，MySQL 会自动缩短索引。
对于由CHANGEor
重命名的列RENAME COLUMN，MySQL 自动将这些引用重命名为重命名的列：
引用旧列的索引，包括不可见索引和禁用MyISAM索引。
引用旧列的外键。
对于由CHANGEor
重命名的列RENAME COLUMN，MySQL 不会自动将这些引用重命名为重命名的列：
生成的列和分区表达式引用重命名的列。您必须在与重命名列
CHANGE的语句相同的语句中使用重新定义此类表达式
。ALTER TABLE
引用重命名列的视图和存储程序。您必须手动更改这些对象的定义以引用新的列名。
要对表中的列重新排序，请使用FIRST
and AFTERin CHANGEor
MODIFY操作。
ALTER ... SET DEFAULT或ALTER ...
DROP DEFAULT分别为列指定新的默认值或删除旧的默认值。如果删除旧的默认值并且列可以是NULL，则新的默认值是NULL。如果该列不能是
，MySQL 将按照第 11.6 节，“数据类型默认值”NULL中的描述分配一个默认值。
从 MySQL 8.0.23 开始，ALTER ... SET VISIBLE启用
ALTER ... SET INVISIBLE要更改的列可见性。请参阅第 13.1.20.10 节，“不可见的列”。
主键和索引
DROP PRIMARY KEY删除
主键。如果没有主键，就会出错。有关主键性能特征的信息，尤其是
InnoDB表，请参阅
第 8.3.2 节，“主键优化”。
如果sql_require_primary_key
启用了系统变量，则尝试删除主键会产生错误。
如果你添加一个UNIQUE INDEX或PRIMARY
KEY到一个表，MySQL 将它存储在任何非唯一索引之前，以允许尽早检测重复键。
DROP INDEX删除索引。这是标准 SQL 的 MySQL 扩展。请参阅
第 13.1.27 节，“DROP INDEX 语句”。要确定索引名称，请使用
.
SHOW INDEX FROM
tbl_name
一些存储引擎允许您在创建索引时指定索引类型。说明符的语法
index_type是. 有关详细信息
，请参阅第 13.1.15 节，“CREATE INDEX 语句”。首选位置在列列表之后。期望支持在将来的 MySQL 版本中删除列列表之前的选项。
USING
type_nameUSING
index_option值指定索引的附加选项。USING就是这样一种选择。有关允许
index_option值的详细信息，请参阅
第 13.1.15 节，“CREATE INDEX 语句”。
RENAME INDEX old_index_name TO
new_index_name重命名索引。这是标准 SQL 的 MySQL 扩展。表的内容保持不变。
old_index_name必须是表中未被同一
ALTER TABLE语句删除的现有索引的名称。
new_index_name是新的索引名称，它不能在应用更改后复制结果表中的索引名称。两个索引名称都不能是
PRIMARY.
如果您ALTER TABLE在
MyISAM表上使用，则所有非唯一索引都在单独的批次中创建（对于REPAIR
TABLE）。当你有很多索引时，这应该会ALTER
TABLE更快。
对于MyISAM表，可以显式控制键更新。用于ALTER TABLE ... DISABLE
KEYS告诉 MySQL 停止更新非唯一索引。然后用于ALTER TABLE ... ENABLE KEYS重新创建丢失的索引。MyISAM使用一种比逐个插入键快得多的特殊算法来执行此操作，因此在执行批量插入操作之前禁用键应该会大大加快速度。除了前面提到
的特权之外，使用
还ALTER TABLE ... DISABLE KEYS需要
特权。INDEX
虽然非唯一索引被禁用，但对于诸如SELECT和
之类的语句，它们将被忽略EXPLAIN，否则将使用它们。
在ALTER TABLE语句之后，可能需要运行ANALYZE
TABLE以更新索引基数信息。请参阅
第 13.7.7.22 节，“SHOW INDEX 语句”。
该ALTER INDEX操作允许索引可见或不可见。优化器不使用不可见索引。索引可见性的修改适用于主键以外的索引（显式或隐式）。此功能是存储引擎中立的（支持任何引擎）。有关详细信息，请参阅第 8.3.12 节，“不可见索引”。
外键和其他约束
FOREIGN KEY和
子句REFERENCES由
实现.
_ 请参阅第 13.1.20.5 节，“外键约束”。对于其他存储引擎，这些子句被解析但被忽略。
InnoDBNDBADD [CONSTRAINT
[symbol]] FOREIGN KEY
[index_name] (...) REFERENCES ...
(...)
对于ALTER TABLE，与 不同
CREATE TABLE，如果给定则ADD FOREIGN
KEY忽略index_name并使用自动生成的外键名称。作为解决方法，包括CONSTRAINT用于指定外键名称的子句：
ADD CONSTRAINT name FOREIGN KEY (....) ...
重要的
MySQL 默默地忽略内联REFERENCES
规范，其中引用被定义为列规范的一部分。MySQL 只接受
REFERENCES定义为单独FOREIGN KEY规范的一部分的子句。
笔记
分区InnoDB表不支持外键。此限制不适用于
NDB表，包括由 显式分区的表[LINEAR] KEY。有关详细信息，请参阅
第 24.6.2 节，“与存储引擎相关的分区限制”。
MySQL Server 和 NDB Cluster 都支持使用
ALTER TABLE删除外键：
ALTER TABLE tbl_name DROP FOREIGN KEY fk_symbol;
支持在同一
ALTER TABLE语句中添加和删除外键，ALTER TABLE ...
ALGORITHM=INPLACE但不支持
ALTER TABLE ...
ALGORITHM=COPY.
服务器禁止更改可能导致引用完整性丢失的外键列。解决方法是ALTER TABLE
... DROP FOREIGN KEY在更改列定义之前和ALTER
TABLE ... ADD FOREIGN KEY之后使用。禁止更改的示例包括：
更改可能不安全的外键列的数据类型。例如，允许更改
VARCHAR(20)为
VARCHAR(30)，但VARCHAR(1024)不能更改为，因为这会改变存储单个值所需的长度字节数。
禁止在非严格模式下将NULL列
更改为，以防止将值转换为默认的非值，因为这些值在引用表中没有对应的值。该操作在严格模式下是允许的，但如果需要任何此类转换，则会返回错误。
NOT
NULLNULLNULL
ALTER TABLE tbl_name RENAME
new_tbl_name更改内部生成的外键约束名称和以字符串“ tbl_name_ibfk_ ”开头的用户定义的外键约束名称
以反映新的表名称。将以字符串“ _ibfk_ ”InnoDB开头的外键约束名称解释
为内部生成的名称。
tbl_name
在 MySQL 8.0.16 之前，ALTER TABLE
只允许以下有限版本的
CHECK约束添加语法，它被解析并被忽略：
ADD CHECK (expr)
从 MySQL 8.0.16 开始，ALTER TABLE
允许CHECK添加、删除或更改现有表的约束：
添加新CHECK约束：
ALTER TABLE tbl_name
ADD [CONSTRAINT [symbol]] CHECK (expr) [[NOT] ENFORCED];
约束语法元素的含义与 for 相同
CREATE TABLE。请参阅
第 13.1.20.6 节，“检查约束”。
删除名为 的现有CHECK约束
symbol：
ALTER TABLE tbl_name
DROP CHECK symbol;
更改是否强制执行名为的现有CHECK约束symbol：
ALTER TABLE tbl_name
ALTER CHECK symbol [NOT] ENFORCED;
DROP CHECKand子句是 MySQL 对标准 SQL
的ALTER
CHECK扩展。
从 MySQL 8.0.19 开始，ALTER TABLE
允许使用更通用（和 SQL 标准）的语法来删除和更改任何类型的现有约束，其中约束类型由约束名称确定：
删除名为 的现有约束
symbol：
ALTER TABLE tbl_name
DROP CONSTRAINT symbol;
如果
sql_require_primary_key
启用了系统变量，则尝试删除主键会产生错误。
更改是否强制执行名为的现有约束
symbol：
ALTER TABLE tbl_name
ALTER CONSTRAINT symbol [NOT] ENFORCED;
只有CHECK约束可以更改为未强制执行。始终强制执行所有其他约束类型。
SQL 标准规定所有类型的约束（主键、唯一索引、外键、校验）都属于同一个命名空间。在 MySQL 中，每个约束类型在每个模式中都有自己的命名空间。因此，每个模式的每种约束类型的名称必须是唯一的，但不同类型的约束可以具有相同的名称。当多个约束具有相同的名称
DROP CONSTRAINT并且ADD
CONSTRAINT不明确时会发生错误。在这种情况下，必须使用特定于约束的语法来修改约束。例如，使用DROP PRIMARY KEY
或 DROP FOREIGN KEY 删除主键或外键。
如果表更改导致违反强制
CHECK约束，则会发生错误并且不会修改表。发生错误的操作示例：
尝试将AUTO_INCREMENT
属性添加到
CHECK约束中使用的列。
尝试添加强制CHECK
约束或强制非强制CHECK
约束，但现有行违反了约束条件。
尝试修改、重命名或删除约束中使用的列
CHECK，除非该约束也在同一语句中删除。例外：如果
CHECK约束仅引用单个列，则删除该列会自动删除该约束。
ALTER TABLE tbl_name RENAME
new_tbl_name更改以字符串“ _chk_ ”CHECK
开头的
内部生成的和用户定义的约束名称以反映新的表名称。MySQL将以字符串“ _chk_ ”
开头的约束名称
解释为内部生成的名称。
tbl_nameCHECKtbl_name
更改字符集
要将表默认字符集和所有字符列 ( CHAR,
VARCHAR,
TEXT) 更改为新字符集，请使用如下语句：
ALTER TABLE tbl_name CONVERT TO CHARACTER SET charset_name;
该语句还更改所有字符列的排序规则。如果您没有指定任何COLLATE子句来指示要使用的排序规则，该语句将使用字符集的默认排序规则。如果此归类不适合预期的表用途（例如，如果它将从区分大小写的归类更改为不区分大小写的归类），请明确指定归类。
对于具有一种数据类型
VARCHAR或其中一种
TEXT类型的列，CONVERT TO
CHARACTER SET根据需要更改数据类型以确保新列的长度足以存储与原始列一样多的字符。例如，一个
TEXT列有两个长度字节，存储列中值的字节长度，最大为 65,535。对于一latin1
TEXT列，每个字符需要一个字节，因此该列最多可以存储 65,535 个字符。如果将列转换为
utf8mb4，则每个字符最多可能需要 4 个字节，最大可能长度为 4 × 65,535 = 262,140 字节。该长度不适合
TEXT列的长度字节，因此 MySQL 将数据类型转换为
MEDIUMTEXT，这是最小的字符串类型，其长度字节可以记录值 262,140。同样，VARCHAR
列可能会转换为
MEDIUMTEXT.
为避免刚才描述的类型的数据类型更改，请勿使用
CONVERT TO CHARACTER SET. 相反，用于
MODIFY更改单个列。例如：
ALTER TABLE t MODIFY latin1_text_col TEXT CHARACTER SET utf8mb4;
ALTER TABLE t MODIFY latin1_varchar_col VARCHAR(M) CHARACTER SET utf8mb4;
如果指定CONVERT TO CHARACTER SET binary，则CHAR、
VARCHAR和
TEXT列将转换为其相应的二进制字符串类型 ( BINARY、
VARBINARY、
BLOB)。这意味着列不再具有字符集，后续CONVERT
TO操作也不适用于它们。
如果charset_name在
操作DEFAULT中，则使用系统变量
CONVERT TO CHARACTER
SET命名的字符集
。character_set_database
警告
该CONVERT TO操作在原始字符集和命名字符集之间转换列值。如果您在一个字符集中有一列（如），但存储的值实际上使用其他一些不兼容的字符集（如），则这
不是您想要的。在这种情况下，您必须为每个这样的列执行以下操作：
latin1utf8mb4ALTER TABLE t1 CHANGE c1 c1 BLOB;
ALTER TABLE t1 CHANGE c1 c1 TEXT CHARACTER SET utf8mb4;BLOB这样做的原因是当您转换到列或从列
转换时没有转换。
要仅更改表的默认字符集，请使用以下语句：
ALTER TABLE tbl_name DEFAULT CHARACTER SET charset_name;
这个词DEFAULT是可选的。默认字符集是在您没有为稍后添加到表中的列指定字符集时使用的字符集（例如，使用ALTER TABLE ... ADD
column）。
启用系统变量（默认设置）时foreign_key_checks
，不允许在包含外键约束中使用的字符串列的表上进行字符集转换。foreign_key_checks解决方法是在执行字符集转换之前禁用
。在重新启用之前，必须对外键约束涉及的两个表进行转换
foreign_key_checks。foreign_key_checks
如果您仅在转换其中一个表后重新启用，则ON DELETE
CASCADEorON UPDATE CASCADE
操作可能会由于在这些操作期间发生隐式转换而损坏引用表中的数据（错误 #45290、错误 #74816）。
导入 InnoDB 表
InnoDB在其自己的 file-per-table 表空间中创建的
表可以
使用DISCARD TABLEPACE和
IMPORT TABLESPACE子句从备份或从另一个 MySQL 服务器实例导入。请参阅
第 15.6.1.3 节，“导入 InnoDB 表”。
MyISAM 表的行顺序
ORDER BY使您能够创建具有特定顺序的行的新表。此选项主要在您知道大多数时间以特定顺序查询行时有用。通过在对表进行重大更改后使用此选项，您可能可以获得更高的性能。在某些情况下，如果表是按您以后要按其排序的列排序的，则 MySQL 的排序可能会更容易。
笔记
表在插入和删除后没有保持指定的顺序。
ORDER BY语法允许为排序指定一个或多个列名，每个列名后面可选地跟有ASCorDESC以分别指示升序或降序排序顺序。默认是升序。只允许列名作为排序标准；不允许任意表达。该子句应在任何其他子句之后给出。
ORDER BY对表没有意义，
InnoDB因为InnoDB
总是根据
聚集索引对表行进行排序。
在分区表上使用时，ALTER TABLE ... ORDER
BY仅对每个分区内的行进行排序。
分区选项
partition_options表示可与分区表一起用于重新分区、添加、删除、丢弃、导入、合并和拆分分区以及执行分区维护的选项。
一个ALTER TABLE
语句可以包含一个PARTITION BYor
REMOVE PARTITIONING子句作为对其他更改规范的补充，但PARTITION
BYorREMOVE PARTITIONING子句必须在任何其他规范之后最后指定。、ADD
PARTITION、DROP PARTITION、
DISCARD PARTITION、IMPORT
PARTITION、COALESCE PARTITION、
REORGANIZE PARTITION、EXCHANGE
PARTITION、和选项不能与单个 中的其他更改规范组合ANALYZE PARTITION，
因为刚刚列出的选项作用于单个分区。
CHECK PARTITIONREPAIR
PARTITIONALTER TABLE
有关分区选项的更多信息，请参阅
第 13.1.20 节，“CREATE TABLE 语句”和
第 13.1.9.1 节，“ALTER TABLE 分区操作”。有关ALTER TABLE ...
EXCHANGE PARTITION语句的信息和示例，请参阅
第 24.3.3 节，“使用表交换分区和子分区”。
© Mysql 中文网
