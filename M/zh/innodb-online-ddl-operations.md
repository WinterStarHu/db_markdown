# 15.12.1 在线DDL操作_MySQL 8.0 参考手册

15.12.1 在线DDL操作_MySQL 8.0 参考手册
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
15.12.1 在线DDL操作1
15.12.2 在线 DDL 性能和并发1
15.12.3 在线 DDL 空间要求1
15.12.4 在线DDL内存管理1
15.12.5 为在线 DDL 操作配置并行线程1
15.12.6 使用在线 DDL 简化 DDL 语句1
15.12.7 在线 DDL 失败条件1
15.12.8 在线 DDL 限制1
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
MySQL 8.0 参考手册  / 第 15 章 InnoDB 存储引擎  / 15.12 InnoDB和在线DDL  /
15.12.1 在线DDL操作
15.12.1 在线DDL操作
本节的以下主题下提供了 DDL 操作的在线支持详细信息、语法示例和使用说明。
索引操作主键操作列操作生成的列操作外键操作表操作表空间操作分区操作
索引操作
下表概述了对索引操作的在线 DDL 支持。星号表示附加信息、异常或依赖关系。有关详细信息，请参阅
语法和使用说明。
表 15.16 索引操作的在线 DDL 支持
手术
立即的
到位
重建表
允许并发 DML
仅修改元数据
创建或添加二级索引
不
是的
不
是的
不
删除索引
不
是的
不
是的
是的
重命名索引
不
是的
不
是的
是的
添加FULLTEXT索引
不
是的*
不*
不
不
添加SPATIAL索引
不
是的
不
不
不
更改索引类型
是的
是的
不
是的
是的
语法和使用说明
创建或添加二级索引
CREATE INDEX name ON table (col_list);ALTER TABLE tbl_name ADD INDEX name (col_list);
在创建索引时，该表仍可用于读写操作。该
CREATE INDEX语句仅在访问表的所有事务都完成后才结束，因此索引的初始状态反映了表的最新内容。
在线 DDL 支持添加二级索引意味着您通常可以通过创建不带二级索引的表，然后在加载数据后添加二级索引来加快创建和加载表及关联索引的整个过程。
CREATE INDEX新创建的二级索引仅包含or
ALTER TABLE语句执行完毕
时表中已提交的数据
。它不包含任何未提交的值、旧版本的值或标记为删除但尚未从旧索引中删除的值。
一些因素会影响此操作的性能、空间使用和语义。有关详细信息，请参阅
第 15.12.8 节，“在线 DDL 限制”。
删除索引
DROP INDEX name ON table;ALTER TABLE tbl_name DROP INDEX name;
在删除索引时，该表仍可用于读取和写入操作。该
DROP INDEX语句仅在访问表的所有事务都完成后才结束，因此索引的初始状态反映了表的最新内容。
重命名索引
ALTER TABLE tbl_name RENAME INDEX old_index_name TO new_index_name, ALGORITHM=INPLACE, LOCK=NONE;
添加FULLTEXT索引
CREATE FULLTEXT INDEX name ON table(column);FULLTEXT如果没有用户定义的
FTS_DOC_ID列，
添加第一个索引会重建表。FULLTEXT可以在不重建表的情况下添加
额外
的索引。
添加SPATIAL索引
CREATE TABLE geom (g GEOMETRY NOT NULL);
ALTER TABLE geom ADD SPATIAL INDEX(g), ALGORITHM=INPLACE, LOCK=SHARED;
更改索引类型 ( USING {BTREE |
HASH})
ALTER TABLE tbl_name DROP INDEX i1, ADD INDEX i1(key_part,...) USING BTREE, ALGORITHM=INSTANT;
主键操作
下表概述了对主键操作的在线 DDL 支持。星号表示附加信息、异常或依赖关系。请参阅
语法和使用说明。
表 15.17 对主键操作的在线 DDL 支持
手术
立即的
到位
重建表
允许并发 DML
仅修改元数据
添加主键
不
是的*
是的*
是的
不
删除主键
不
不
是的
不
不
删除主键并添加另一个
不
是的
是的
是的
不
语法和使用说明
添加主键
ALTER TABLE tbl_name ADD PRIMARY KEY (column), ALGORITHM=INPLACE, LOCK=NONE;
就地重建表。数据被大量重组，使其成为一项昂贵的操作。
ALGORITHM=INPLACE如果必须将列转换为 ，则在某些情况下不允许使用
NOT NULL.
重组
聚集索引
总是需要复制表数据。因此，最好在创建表时
定义主键ALTER TABLE ... ADD PRIMARY KEY，而不是稍后发布。
当你创建一个UNIQUE或
PRIMARY KEY索引时，MySQL 必须做一些额外的工作。对于UNIQUE索引，MySQL 检查表中是否包含键的重复值。对于PRIMARY KEY索引，MySQL 还会检查没有任何PRIMARY KEY
列包含NULL.
当您使用该
ALGORITHM=COPY子句添加主键时，MySQL 会将
NULL关联列中的值转换为默认值：数字为 0，基于字符的列和 BLOB 为空字符串，0000-00-00 00:00:00 为DATETIME. 这是 Oracle 建议您不要依赖的非标准行为。仅当设置包含或
标志ALGORITHM=INPLACE时才允许
使用添加主键；当
设置为严格时，
允许，但如果请求的主键列包含，语句仍然会失败SQL_MODEstrict_trans_tablesstrict_all_tablesSQL_MODEALGORITHM=INPLACENULL值。该
ALGORITHM=INPLACE行为更符合标准。
如果您创建的表没有主键，
InnoDB请为您选择一个，它可以是列UNIQUE上定义的第一个键
，也可以是NOT NULL系统生成的键。为避免不确定性和额外隐藏列的潜在空间需求，请将
PRIMARY KEY子句指定为语句的一部分
CREATE TABLE。
MySQL 通过将现有数据从原始表复制到具有所需索引结构的临时表来创建新的聚集索引。一旦数据被完全复制到临时表中，原始表将被重命名为不同的临时表名称。包含新聚簇索引的临时表被重命名为原始表的名称，并且原始表从数据库中删除。
适用于二级索引操作的在线性能增强不适用于主键索引。InnoDB 表的行存储在
基于
主键组织的聚簇索引中，形成一些数据库系统所谓的“索引组织表”。由于表结构与主键紧密相关，重新定义主键仍然需要复制数据。
当对主键的操作使用
ALGORITHM=INPLACE时，即使数据仍然被复制，它也比使用更高效，
ALGORITHM=COPY因为：
不需要撤消日志记录或关联的重做日志记录ALGORITHM=INPLACE。这些操作增加了使用
ALGORITHM=COPY.
二级索引条目是预先排序的，因此可以按顺序加载。
未使用更改缓冲区，因为二级索引中没有随机访问插入。
删除主键
ALTER TABLE tbl_name DROP PRIMARY KEY, ALGORITHM=COPY;
只ALGORITHM=COPY支持在同一
ALTER TABLE语句中删除主键而不添加新主键。
删除主键并添加另一个
ALTER TABLE tbl_name DROP PRIMARY KEY, ADD PRIMARY KEY (column), ALGORITHM=INPLACE, LOCK=NONE;
数据被大量重组，使其成为一项昂贵的操作。
列操作
下表概述了对列操作的在线 DDL 支持。星号表示附加信息、异常或依赖关系。有关详细信息，请参阅
语法和使用说明。
表 15.18 列操作的在线 DDL 支持
手术
立即的
到位
重建表
允许并发 DML
仅修改元数据
添加列
是的*
是的
不*
是的*
是的
删除列
是的*
是的
是的
是的
是的
重命名列
是的*
是的
不
是的*
是的
重新排序列
不
是的
是的
是的
不
设置列默认值
是的
是的
不
是的
是的
更改列数据类型
不
不
是的
不
不
扩展VARCHAR列大小
不
是的
不
是的
是的
删除列默认值
是的
是的
不
是的
是的
更改自动增量值
不
是的
不
是的
不*
制作专栏NULL
不
是的
是的*
是的
不
制作专栏NOT NULL
不
是的*
是的*
是的
不
修改ENUMor
SET列的定义
是的
是的
不
是的
是的
语法和使用说明
添加列
ALTER TABLE tbl_name ADD COLUMN column_name column_definition, ALGORITHM=INSTANT;
INSTANT是 MySQL 8.0.12 及INPLACE之前版本的默认算法。
当
INSTANT算法用于添加列时，以下限制适用：
添加列不能与ALTER TABLE不支持的其他操作组合在同一语句中ALGORITHM=INSTANT。
在 MySQL 8.0.29 之前，只能添加一列作为表的最后一列。不支持将列添加到其他列中的任何其他位置。从 MySQL 8.0.29 开始，即时添加的列可以添加到表中的任意位置。
不能将列添加到使用
ROW_FORMAT=COMPRESSED的表、具有
FULLTEXT索引的表、驻留在数据字典表空间中的表或临时表。临时表仅支持
ALGORITHM=COPY.
在 MySQL 8.0.29 之前，添加列时不会评估行大小限制。但是，在向表中插入和更新行的 DML 操作期间会检查行大小限制。从 8.0.29 开始，添加列时会检查行大小限制。如果超出限制，会报如下错误信息：
错误 4092 (HY000)：无法使用 ALGORITHM=INSTANT 添加列，因为在此最大可能行大小超过最大允许行大小之后。尝试算法=就地/复制。
可以在同一
ALTER TABLE语句中添加多个列。例如：
ALTER TABLE t1 ADD COLUMN c2 INT, ADD COLUMN c3 INT, ALGORITHM=INSTANT;ALTER TABLE ...
ALGORITHM=INSTANT在每次添加一列或多列、删除一列或多列或者在同一操作中添加和删除一列或多列的操作
之后，都会创建一个新的行版本
。该
INFORMATION_SCHEMA.INNODB_TABLES.TOTAL_ROW_VERSIONS
列跟踪表的行版本数。每次立即添加或删除列时，该值都会递增。初始值为 0。
mysql>  SELECT NAME, TOTAL_ROW_VERSIONS FROM INFORMATION_SCHEMA.INNODB_TABLES
WHERE NAME LIKE 'test/t1';
+---------+--------------------+
| NAME    | TOTAL_ROW_VERSIONS |
+---------+--------------------+
| test/t1 |                  0 |
+---------+--------------------+
当通过重建表ALTER TABLE
或OPTIMIZE TABLE
操作重建具有即时添加或删除列的表时，该TOTAL_ROW_VERSIONS值将重置为 0。允许的最大行版本数为 64，因为每个行版本都需要额外的空间用于表元数据。当达到行版本限制时，
使用的操作将
被拒绝，ADD COLUMN并显示一条错误消息，建议使用
或
算法重建表。
DROP
COLUMNALGORITHM=INSTANTCOPYINPLACE
错误 4080 (HY000)：达到表 test/t1 的最大行版本。无法立即添加或删除更多列。请使用 COPY/INPLACE。
以下
INFORMATION_SCHEMA列为即时添加的列提供额外的元数据。有关详细信息，请参阅这些列的说明。请参阅
第 26.4.9 节，“INFORMATION_SCHEMA INNODB_COLUMNS 表”和
第 26.4.23 节，“INFORMATION_SCHEMA INNODB_TABLES 表”。
INNODB_COLUMNS.DEFAULT_VALUE
INNODB_COLUMNS.HAS_DEFAULT
INNODB_TABLES.INSTANT_COLS
添加自
增列时不允许并发 DML
。数据被大量重组，使其成为一项昂贵的操作。至少，
ALGORITHM=INPLACE, LOCK=SHARED是必需的。
如果ALGORITHM=INPLACE
用于添加列，则重建表。
删除列
ALTER TABLE tbl_name DROP COLUMN column_name, ALGORITHM=INSTANT;
INSTANT是 MySQL 8.0.29 及INPLACE之前版本的默认算法。
当
INSTANT算法用于删除列时，以下限制适用：
删除列不能与ALTER
TABLE不支持的其他操作
组合在同一语句中ALGORITHM=INSTANT。
不能从使用
ROW_FORMAT=COMPRESSED的表、具有
FULLTEXT索引的表、驻留在数据字典表空间中的表或临时表中删除列。临时表仅支持
ALGORITHM=COPY.
可以在同
ALTER TABLE一条语句中删除多个列；例如：
ALTER TABLE t1 DROP COLUMN c4, DROP COLUMN c5, ALGORITHM=INSTANT;
每次使用添加或删除列时
ALGORITHM=INSTANT，都会创建一个新的行版本。该
INFORMATION_SCHEMA.INNODB_TABLES.TOTAL_ROW_VERSIONS
列跟踪表的行版本数。每次立即添加或删除列时，该值都会递增。初始值为 0。
mysql>  SELECT NAME, TOTAL_ROW_VERSIONS FROM INFORMATION_SCHEMA.INNODB_TABLES
WHERE NAME LIKE 'test/t1';
+---------+--------------------+
| NAME    | TOTAL_ROW_VERSIONS |
+---------+--------------------+
| test/t1 |                  0 |
+---------+--------------------+
当通过重建表ALTER TABLE
或OPTIMIZE TABLE
操作重建具有即时添加或删除列的表时，该TOTAL_ROW_VERSIONS值将重置为 0。允许的最大行版本数为 64，因为每个行版本都需要额外的空间用于表元数据。当达到行版本限制时，
使用的操作将
被拒绝，ADD COLUMN并显示一条错误消息，建议使用
或
算法重建表。
DROP
COLUMNALGORITHM=INSTANTCOPYINPLACE
错误 4080 (HY000)：达到表 test/t1 的最大行版本。无法立即添加或删除更多列。请使用 COPY/INPLACE。
如果使用除此之外的算法
ALGORITHM=INSTANT，数据将被大量重组，从而使其成为一项昂贵的操作。
重命名列
ALTER TABLE tbl CHANGE old_col_name new_col_name data_type, ALGORITHM=INSTANT, LOCK=NONE;
ALGORITHM=INSTANTMySQL 8.0.28 中添加了对重命名列的支持。较早的 MySQL Server 版本仅在ALGORITHM=INPLACE
重ALGORITHM=COPY命名列时支持。
要允许并发 DML，请保持相同的数据类型并仅更改列名。
当你保持相同的数据类型和[NOT]
NULL属性时，只改变列名，操作总是可以在线进行。
重命名从另一个表引用的列只允许使用ALGORITHM=INPLACE. 如果您使用ALGORITHM=INSTANT、
ALGORITHM=COPY或导致操作使用这些算法的某些其他条件，则该
ALTER TABLE语句将失败。
ALGORITHM=INSTANT支持重命名虚拟列；ALGORITHM=INPLACE才不是。
ALGORITHM=INSTANT并且
ALGORITHM=INPLACE不支持在同一语句中添加或删除虚拟列时重命名列。在这种情况下，仅
ALGORITHM=COPY支持。
重新排序列
要对列重新排序，请使用FIRSTor
AFTERin CHANGEor
MODIFY操作。
ALTER TABLE tbl_name MODIFY COLUMN col_name column_definition FIRST, ALGORITHM=INPLACE, LOCK=NONE;
数据被大量重组，使其成为一项昂贵的操作。
更改列数据类型
ALTER TABLE tbl_name CHANGE c1 c1 BIGINT, ALGORITHM=COPY;
仅支持更改列数据类型
ALGORITHM=COPY。
扩展VARCHAR列大小
ALTER TABLE tbl_name CHANGE COLUMN c1 c1 VARCHAR(255), ALGORITHM=INPLACE, LOCK=NONE;
列所需的长度字节数
VARCHAR必须保持不变。对于VARCHAR大小为 0 到 255 字节的列，需要一个长度字节来对值进行编码。对于VARCHAR
大小为 256 字节或更多的列，需要两个长度字节。因此，就地ALTER
TABLE仅支持将
VARCHAR列大小从 0 字节增加到 255 字节，或从 256 字节增加到更大的大小。就地
ALTER TABLE不支持增加a的大小
VARCHAR从小于 256 字节到等于或大于 256 字节的列。在这种情况下，所需的长度字节数从 1 变为 2，这仅由表副本（ALGORITHM=COPY）支持。例如，尝试VARCHAR就地使用将单字节字符集的列大小从 VARCHAR(255) 更改为 VARCHAR(256) 会ALTER
TABLE返回此错误：
ALTER TABLE tbl_name ALGORITHM=INPLACE, CHANGE COLUMN c1 c1 VARCHAR(256);
ERROR 0A000: ALGORITHM=INPLACE is not supported. Reason: Cannot change
column type INPLACE. Try ALGORITHM=COPY.
笔记
列的字节长度VARCHAR取决于字符集的字节长度。
不支持VARCHAR使用就地
减小尺寸。ALTER TABLE减小VARCHAR
大小需要一个表副本 ( ALGORITHM=COPY)。
设置列默认值
ALTER TABLE tbl_name ALTER COLUMN col SET DEFAULT literal, ALGORITHM=INSTANT;
仅修改表元数据。默认列值存储在数据字典中。
删除列默认值
ALTER TABLE tbl ALTER COLUMN col DROP DEFAULT, ALGORITHM=INSTANT;
更改自动增量值
ALTER TABLE table AUTO_INCREMENT=next_value, ALGORITHM=INPLACE, LOCK=NONE;
修改存储在内存中的值，而不是数据文件。
在使用复制或分片的分布式系统中，您有时会将表的自动增量计数器重置为特定值。插入表中的下一行使用指定的值作为其自动增量列。您也可以在数据仓库环境中使用此技术，在该环境中您定期清空所有表并重新加载它们，然后从 1 重新启动自动递增序列。
制作专栏NULL
ALTER TABLE tbl_name MODIFY COLUMN column_name data_type NULL, ALGORITHM=INPLACE, LOCK=NONE;
就地重建表。数据被大量重组，使其成为一项昂贵的操作。
制作专栏NOT NULL
ALTER TABLE tbl_name MODIFY COLUMN column_name data_type NOT NULL, ALGORITHM=INPLACE, LOCK=NONE;
就地重建表。
STRICT_ALL_TABLES或者
STRICT_TRANS_TABLES
SQL_MODE是操作成功所必需的。如果该列包含 NULL 值，则操作失败。服务器禁止更改可能导致引用完整性丢失的外键列。请参阅第 13.1.9 节，“ALTER TABLE 语句”。数据被大量重组，使其成为一项昂贵的操作。
修改ENUMor
SET列
的定义CREATE TABLE t1 (c1 ENUM('a', 'b', 'c'));
ALTER TABLE t1 MODIFY COLUMN c1 ENUM('a', 'b', 'c', 'd'), ALGORITHM=INSTANT;通过将新的枚举或集合成员添加到有效成员值列表的末尾ENUM来修改or
列
的定义
可以立即执行或就地执行，只要数据类型的存储大小不变即可。例如，向
具有 8 个成员的列添加一个成员会将每个值所需的存储空间从 1 个字节更改为 2 个字节；这需要一个表副本。在列表中间添加成员会导致现有成员重新编号，这需要表副本。
SETSET
生成的列操作
下表概述了对生成的列操作的在线 DDL 支持。有关详细信息，请参阅
语法和使用说明。
表 15.19 生成列操作的在线 DDL 支持
手术
立即的
到位
重建表
允许并发 DML
仅修改元数据
添加STORED列
不
不
是的
不
不
修改STORED列顺序
不
不
是的
不
不
删除STORED列
不
是的
是的
是的
不
添加VIRTUAL列
是的
是的
不
是的
是的
修改VIRTUAL列顺序
不
不
是的
不
不
删除VIRTUAL列
是的
是的
不
是的
是的
语法和使用说明
添加STORED列
ALTER TABLE t1 ADD COLUMN (c2 INT GENERATED ALWAYS AS (c1 + 1) STORED), ALGORITHM=COPY;
ADD COLUMN不是存储列的就地操作（在不使用临时表的情况下完成），因为表达式必须由服务器计算。
修改STORED列顺序
ALTER TABLE t1 MODIFY COLUMN c2 INT GENERATED ALWAYS AS (c1 + 1) STORED FIRST, ALGORITHM=COPY;
就地重建表。
删除STORED列
ALTER TABLE t1 DROP COLUMN c2, ALGORITHM=INPLACE, LOCK=NONE;
就地重建表。
添加VIRTUAL列
ALTER TABLE t1 ADD COLUMN (c2 INT GENERATED ALWAYS AS (c1 + 1) VIRTUAL), ALGORITHM=INSTANT;
添加虚拟列可以立即执行，也可以为非分区表就地执行。
添加 aVIRTUAL不是分区表的就地操作。
修改VIRTUAL列顺序
ALTER TABLE t1 MODIFY COLUMN c2 INT GENERATED ALWAYS AS (c1 + 1) VIRTUAL FIRST, ALGORITHM=COPY;
删除VIRTUAL列
ALTER TABLE t1 DROP COLUMN c2, ALGORITHM=INSTANT;
对于非分区表，删除VIRTUAL列可以立即执行或就地执行。
外键操作
下表概述了对外键操作的在线 DDL 支持。星号表示附加信息、异常或依赖关系。有关详细信息，请参阅
语法和使用说明。
表 15.20 外键操作的在线 DDL 支持
手术
立即的
到位
重建表
允许并发 DML
仅修改元数据
添加外键约束
不
是的*
不
是的
是的
删除外键约束
不
是的
不
是的
是的
语法和使用说明
添加外键约束
禁用时支持
该INPLACE算法
。foreign_key_checks否则，仅COPY
支持算法。
ALTER TABLE tbl1 ADD CONSTRAINT fk_name FOREIGN KEY index (col1)
REFERENCES tbl2(col2) referential_actions;
删除外键约束
ALTER TABLE tbl DROP FOREIGN KEY fk_name;
可以在
foreign_key_checks启用或禁用选项的情况下在线执行删除外键。
如果您不知道特定表的外键约束名称，请执行以下语句并在
CONSTRAINT子句中为每个外键查找约束名称：
SHOW CREATE TABLE table\G
或者，查询
INFORMATION_SCHEMA.TABLE_CONSTRAINTS
表并使用CONSTRAINT_NAME和
CONSTRAINT_TYPE列来标识外键名称。
您还可以在单​​个语句中删除外键及其关联索引：
ALTER TABLE table DROP FOREIGN KEY constraint, DROP INDEX index;
笔记
如果正在更改的表中已经存在外键（即它是
包含子句的子表FOREIGN KEY ... REFERENCE），则附加限制适用于在线 DDL 操作，即使是那些不直接涉及外键列的操作：
如果对父表的更改通过使用or
参数
的or
子句
ALTER TABLE导致子表中的相关更改，则子表上的 an 可以等待另一个事务提交。ON UPDATEON DELETECASCADESET NULL
同样，如果一个表是外键关系中的
父表，即使它不包含任何子句，如果,
, or
语句导致
子表中
的or操作FOREIGN KEY，它也可以等待ALTER TABLE完成。INSERTUPDATEDELETEON UPDATEON
DELETE
表操作
下表概述了表操作的在线 DDL 支持。星号表示附加信息、异常或依赖关系。有关详细信息，请参阅
语法和使用说明。
表 15.21 表操作的在线 DDL 支持
手术
立即的
到位
重建表
允许并发 DML
仅修改元数据
改变ROW_FORMAT
不
是的
是的
是的
不
改变KEY_BLOCK_SIZE
不
是的
是的
是的
不
设置持久表统计信息
不
是的
不
是的
是的
指定字符集
不
是的
是的*
不
不
转换字符集
不
不
是的*
不
不
优化表
不
是的*
是的
是的
不
FORCE使用选项重建
不
是的*
是的
是的
不
执行空重建
不
是的*
是的
是的
不
重命名表
是的
是的
不
是的
是的
语法和使用说明
改变ROW_FORMAT
ALTER TABLE tbl_name ROW_FORMAT = row_format, ALGORITHM=INPLACE, LOCK=NONE;
数据被大量重组，使其成为一项昂贵的操作。
有关该
ROW_FORMAT选项的其他信息，请参阅
表格选项。
改变KEY_BLOCK_SIZE
ALTER TABLE tbl_name KEY_BLOCK_SIZE = value, ALGORITHM=INPLACE, LOCK=NONE;
数据被大量重组，使其成为一项昂贵的操作。
有关该
KEY_BLOCK_SIZE选项的其他信息，请参阅
表格选项。
设置持久表统计选项
ALTER TABLE tbl_name STATS_PERSISTENT=0, STATS_SAMPLE_PAGES=20, STATS_AUTO_RECALC=1, ALGORITHM=INPLACE, LOCK=NONE;
仅修改表元数据。
持久性统计信息包括
STATS_PERSISTENT、
STATS_AUTO_RECALC和
STATS_SAMPLE_PAGES。有关详细信息，请参阅第 15.8.10.1 节，“配置持久优化器统计参数”。
指定字符集
ALTER TABLE tbl_name CHARACTER SET = charset_name, ALGORITHM=INPLACE, LOCK=NONE;
如果新字符编码不同，则重建表。
转换字符集
ALTER TABLE tbl_name CONVERT TO CHARACTER SET charset_name, ALGORITHM=COPY;
如果新字符编码不同，则重建表。
优化表
OPTIMIZE TABLE tbl_name;FULLTEXT具有索引
的表不支持就地操作
。该操作使用该
INPLACE算法，但
ALGORITHM不允许LOCK
语法。
FORCE使用选项
重建表ALTER TABLE tbl_name FORCE, ALGORITHM=INPLACE, LOCK=NONE;ALGORITHM=INPLACE从 MySQL 5.6.17 开始
使用。ALGORITHM=INPLACE不支持带FULLTEXT
索引的表。
执行“空”重建
ALTER TABLE tbl_name ENGINE=InnoDB, ALGORITHM=INPLACE, LOCK=NONE;
从 MySQL 5.6.17 开始使用ALGORITHM=INPLACE。ALGORITHM=INPLACE不支持带FULLTEXT
索引的表。
重命名表
ALTER TABLE old_tbl_name RENAME TO new_tbl_name, ALGORITHM=INSTANT;
重命名表可以立即执行或就地执行。MySQL 重命名与表对应的文件
tbl_name而不制作副本。（您也可以使用RENAME
TABLE语句重命名表。请参阅
第 13.1.36 节，“RENAME TABLE 语句”。）专门为重命名表授予的权限不会迁移到新名称。它们必须手动更改。
表空间操作
下表概述了对表空间操作的在线 DDL 支持。有关详细信息，请参阅
语法和使用说明。
表 15.22 表空间操作的在线 DDL 支持
手术
立即的
到位
重建表
允许并发 DML
仅修改元数据
重命名通用表空间
不
是的
不
是的
是的
启用或禁用通用表空间加密
不
是的
不
是的
不
启用或禁用 file-per-table 表空间加密
不
不
是的
不
不
语法和使用说明
重命名通用表空间
ALTER TABLESPACE tablespace_name RENAME TO new_tablespace_name;
ALTER
TABLESPACE ... RENAME TO使用该
INPLACE算法但不支持该ALGORITHM子句。
启用或禁用通用表空间加密
ALTER TABLESPACE tablespace_name ENCRYPTION='Y';
ALTER
TABLESPACE ... ENCRYPTION使用该
INPLACE算法但不支持该ALGORITHM子句。
有关相关信息，请参阅
第 15.13 节，“InnoDB 静态数据加密”。
启用或禁用 file-per-table 表空间加密
ALTER TABLE tbl_name ENCRYPTION='Y', ALGORITHM=COPY;
有关相关信息，请参阅
第 15.13 节，“InnoDB 静态数据加密”。
分区操作
除了某些ALTER
TABLE分区子句外，分区InnoDB表的在线 DDL 操作遵循适用于常规InnoDB表的相同规则。
一些ALTER TABLE分区子句不通过与常规非分区InnoDB表相同的内部在线 DDL API。因此，对ALTER
TABLE分区子句的在线支持各不相同。
下表显示了每个
ALTER TABLE分区语句的在线状态。无论使用何种在线 DDL API，MySQL 都会尝试尽可能减少数据复制和锁定。
ALTER TABLEALGORITHM=COPY使用或仅允许
“ ALGORITHM=DEFAULT,
LOCK=DEFAULT”的分区选项，使用该COPY算法对表进行重新分区
。换句话说，一个新的分区表是用新的分区方案创建的。新创建的表包括
ALTER TABLE语句应用的任何更改，表数据被复制到新的表结构中。
表 15.23 分区操作的在线 DDL 支持
分割条款
立即的
到位
允许 DML
笔记
PARTITION BY
不
不
不
许可证ALGORITHM=COPY，
LOCK={DEFAULT|SHARED|EXCLUSIVE}
ADD PARTITION
不
是的*
是的*
ALGORITHM=INPLACE,
LOCK={DEFAULT|NONE|SHARED|EXCLUSISVE}RANGE和
LIST分区、
ALGORITHM=INPLACE,
LOCK={DEFAULT|SHARED|EXCLUSISVE}和
HASH分区KEY
以及ALGORITHM=COPY,
LOCK={SHARED|EXCLUSIVE}所有分区类型都支持。不复制按
RANGE或分区的表的现有数据LIST。对于由orALGORITHM=COPY分区的表，允许并发查询
，因为 MySQL 在持有共享锁的同时复制数据。HASHLIST
DROP PARTITION
不
是的*
是的*
ALGORITHM=INPLACE,
LOCK={DEFAULT|NONE|SHARED|EXCLUSIVE}被支持。不复制由
RANGE或分区的表的数据LIST。
DROP PARTITIONwith
ALGORITHM=INPLACE删除存储在分区中的数据并删除分区。但是，
DROP PARTITION使用
ALGORITHM=COPY或
old_alter_table=ON
重建分区表并尝试将数据从删除的分区移动到具有兼容PARTITION ... VALUES
定义的另一个分区。无法移动到另一个分区的数据将被删除。
DISCARD PARTITION
不
不
不
只允许ALGORITHM=DEFAULT,
LOCK=DEFAULT
IMPORT PARTITION
不
不
不
只允许ALGORITHM=DEFAULT,
LOCK=DEFAULT
TRUNCATE
PARTITION
不
是的
是的
不复制现有数据。它只是删除行；它不会改变表本身或其任何分区的定义。
COALESCE
PARTITION
不
是的*
不
ALGORITHM=INPLACE, LOCK={DEFAULT|SHARED|EXCLUSIVE}被支持。
REORGANIZE
PARTITION
不
是的*
不
ALGORITHM=INPLACE, LOCK={DEFAULT|SHARED|EXCLUSIVE}被支持。
EXCHANGE
PARTITION
不
是的
是的
ANALYZE PARTITION
不
是的
是的
CHECK PARTITION
不
是的
是的
OPTIMIZE
PARTITION
不
不
不
ALGORITHM和LOCK子句被忽略。重建整个表。请参阅
第 24.3.4 节，“分区的维护”。
REBUILD PARTITION
不
是的*
不
ALGORITHM=INPLACE, LOCK={DEFAULT|SHARED|EXCLUSIVE}被支持。
REPAIR PARTITION
不
是的
是的
REMOVE
PARTITIONING
不
不
不
许可证ALGORITHM=COPY，
LOCK={DEFAULT|SHARED|EXCLUSIVE}
分区表上的非分区联机ALTER
TABLE操作遵循适用于常规表的相同规则。但是，
ALTER TABLE对每个表分区进行在线操作，由于对多个分区进行操作，导致对系统资源的需求增加。
有关ALTER
TABLE分区子句的其他信息，请参阅
分区选项和
第 13.1.9.1 节，“ALTER TABLE 分区操作”。有关分区的一般信息，请参阅
第 24 章，分区。
© Mysql 中文网
