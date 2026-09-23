# 8.4.7 表列数和行大小的限制_MySQL 8.0 参考手册

8.4.7 表列数和行大小的限制_MySQL 8.0 参考手册
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
8.4.1 优化数据大小1
8.4.2 优化MySQL数据类型1
8.4.3 优化多表1
8.4.4 MySQL内部临时表的使用1
8.4.5 数据库和表的数量限制1
8.4.6 表大小限制1
8.4.7 表列数和行大小的限制1
8.5 优化 InnoDB 表
8.6 优化 MyISAM 表
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
MySQL 8.0 参考手册  / 第8章优化  / 8.4 优化数据库结构  /
8.4.7 表列数和行大小的限制
8.4.7 表列数和行大小的限制
本节介绍对表中列数和各行大小的限制。
列数限制行大小限制
列数限制
MySQL 对每个表有 4096 列的硬限制，但对于给定的表，有效最大值可能会更少。确切的列限制取决于几个因素：
表的最大行大小限制了列的数量（可能还有大小），因为所有列的总长度不能超过此大小。请参阅
行大小限制。
各个列的存储要求限制了适合给定最大行大小的列数。某些数据类型的存储要求取决于存储引擎、存储格式和字符集等因素。请参阅第 11.7 节，“数据类型存储要求”。
存储引擎可能会施加额外的限制来限制表的列数。例如，
InnoDB每个表有 1017 列的限制。请参阅第 15.22 节，“InnoDB 限制”。有关其他存储引擎的信息，请参阅
第 16 章，替代存储引擎。
功能键部分（请参阅第 13.1.15 节，“CREATE INDEX 语句”）被实现为隐藏的虚拟生成的存储列，因此表索引中的每个功能键部分都计入表总列限制。
行大小限制
给定表的最大行大小由几个因素决定：
MySQL 表的内部表示具有 65,535 字节的最大行大小限制，即使存储引擎能够支持更大的行也是如此。
BLOB和
TEXT列仅对行大小限制贡献 9 到 12 个字节，因为它们的内容与行的其余部分分开存储。
适用于本地存储在数据库页面中的数据的表的最大行大小InnoDB
略小于 4KB、8KB、16KB 和 32KB
innodb_page_size
设置的半页。InnoDB例如，对于默认的 16KB页面大小，最大行大小略小于 8KB
。对于 64KB 页面，最大行大小略小于 16KB。请参阅
第 15.22 节，“InnoDB 限制”。
如果包含
可变长度列的行超过InnoDB
最大行大小，则InnoDB选择可变长度列用于外部页外存储，直到该行符合InnoDB
行大小限制。对于页外存储的可变长度列，本地存储的数据量因行格式而异。有关更多信息，请参阅
第 15.10 节，“InnoDB 行格式”。
不同的存储格式使用不同数量的页眉和页尾数据，这会影响可用于行的存储量。
有关InnoDB行格式的信息，请参阅第 15.10 节，“InnoDB 行格式”。
有关MyISAM
存储格式的信息，请参阅
第 16.2.3 节，“MyISAM 表存储格式”。
行大小限制示例
MySQL 的最大行大小限制为 65,535 字节，在以下示例中InnoDB
进行了MyISAM说明。无论存储引擎如何，都会强制执行该限制，即使存储引擎可能能够支持更大的行。
mysql> CREATE TABLE t (a VARCHAR(10000), b VARCHAR(10000),
c VARCHAR(10000), d VARCHAR(10000), e VARCHAR(10000),
f VARCHAR(10000), g VARCHAR(6000)) ENGINE=InnoDB CHARACTER SET latin1;
ERROR 1118 (42000): Row size too large. The maximum row size for the used
table type, not counting BLOBs, is 65535. This includes storage overhead,
check the manual. You have to change some columns to TEXT or BLOBsmysql> CREATE TABLE t (a VARCHAR(10000), b VARCHAR(10000),
c VARCHAR(10000), d VARCHAR(10000), e VARCHAR(10000),
f VARCHAR(10000), g VARCHAR(6000)) ENGINE=MyISAM CHARACTER SET latin1;
ERROR 1118 (42000): Row size too large. The maximum row size for the used
table type, not counting BLOBs, is 65535. This includes storage overhead,
check the manual. You have to change some columns to TEXT or BLOBs
在以下MyISAM示例中，更改列以TEXT
避免 65,535 字节的行大小限制并允许操作成功，因为
BLOB列
TEXT仅对行大小贡献 9 到 12 字节。
mysql> CREATE TABLE t (a VARCHAR(10000), b VARCHAR(10000),
c VARCHAR(10000), d VARCHAR(10000), e VARCHAR(10000),
f VARCHAR(10000), g TEXT(6000)) ENGINE=MyISAM CHARACTER SET latin1;
Query OK, 0 rows affected (0.02 sec)
该操作对InnoDB
表成功，因为更改列以
TEXT避免 MySQL 65,535 字节的行大小限制，并且InnoDB
可变长度列的页外存储避免了
InnoDB行大小限制。
mysql> CREATE TABLE t (a VARCHAR(10000), b VARCHAR(10000),
c VARCHAR(10000), d VARCHAR(10000), e VARCHAR(10000),
f VARCHAR(10000), g TEXT(6000)) ENGINE=InnoDB CHARACTER SET latin1;
Query OK, 0 rows affected (0.02 sec)
可变长度列的存储包括计入行大小的长度字节。例如，一
VARCHAR(255)
CHARACTER SET utf8mb3列需要两个字节来存储值的长度，因此每个值最多可以占用 767 个字节。
创建表的语句t1
成功，因为列需要 32,765 + 2 字节和 32,766 + 2 字节，这在 65,535 字节的最大行大小范围内：
mysql> CREATE TABLE t1
(c1 VARCHAR(32765) NOT NULL, c2 VARCHAR(32766) NOT NULL)
ENGINE = InnoDB CHARACTER SET latin1;
Query OK, 0 rows affected (0.02 sec)
create table语句t2失败是因为虽然列长度在65535字节的最大长度以内，但是需要额外增加两个字节来记录长度，导致行大小超过65535字节：
mysql> CREATE TABLE t2
(c1 VARCHAR(65535) NOT NULL)
ENGINE = InnoDB CHARACTER SET latin1;
ERROR 1118 (42000): Row size too large. The maximum row size for the used
table type, not counting BLOBs, is 65535. This includes storage overhead,
check the manual. You have to change some columns to TEXT or BLOBs
将列长度减少到 65,533 或更少允许语句成功。
mysql> CREATE TABLE t2
(c1 VARCHAR(65533) NOT NULL)
ENGINE = InnoDB CHARACTER SET latin1;
Query OK, 0 rows affected (0.01 sec)
对于MyISAM表格，
NULL列需要在行中有额外的空间来记录它们的值是否为
NULL. 每NULL
列额外占用一位，四舍五入到最接近的字节。
create table 语句t3失败，因为除了可变长度列长度字节所需的空间外，还
MyISAM需要列空间，导致行大小超过 65,535 字节：NULLmysql> CREATE TABLE t3
(c1 VARCHAR(32765) NULL, c2 VARCHAR(32766) NULL)
ENGINE = MyISAM CHARACTER SET latin1;
ERROR 1118 (42000): Row size too large. The maximum row size for the used
table type, not counting BLOBs, is 65535. This includes storage overhead,
check the manual. You have to change some columns to TEXT or BLOBs
有关列存储的信息，请参阅
第 15.10 节，“InnoDB 行格式”。
InnoDB
NULL
InnoDB对于 4KB、8KB、16KB 和 32KB 设置，将行大小（对于本地存储在数据库页面中的数据）限制为略小于数据库页面的一半，
innodb_page_size
对于 64KB 页面限制为略小于 16KB。
创建表的语句t4失败，因为定义的列超过了 16KBInnoDB页的行大小限制。
mysql> CREATE TABLE t4 (
c1 CHAR(255),c2 CHAR(255),c3 CHAR(255),
c4 CHAR(255),c5 CHAR(255),c6 CHAR(255),
c7 CHAR(255),c8 CHAR(255),c9 CHAR(255),
c10 CHAR(255),c11 CHAR(255),c12 CHAR(255),
c13 CHAR(255),c14 CHAR(255),c15 CHAR(255),
c16 CHAR(255),c17 CHAR(255),c18 CHAR(255),
c19 CHAR(255),c20 CHAR(255),c21 CHAR(255),
c22 CHAR(255),c23 CHAR(255),c24 CHAR(255),
c25 CHAR(255),c26 CHAR(255),c27 CHAR(255),
c28 CHAR(255),c29 CHAR(255),c30 CHAR(255),
c31 CHAR(255),c32 CHAR(255),c33 CHAR(255)
) ENGINE=InnoDB ROW_FORMAT=DYNAMIC DEFAULT CHARSET latin1;
ERROR 1118 (42000): Row size too large (> 8126). Changing some columns to TEXT or BLOB may help.
In current row format, BLOB prefix of 0 bytes is stored inline.
© Mysql 中文网
