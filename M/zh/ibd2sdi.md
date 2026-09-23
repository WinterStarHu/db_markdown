# 4.6.1 ibd2sdi — InnoDB 表空间 SDI 提取实用程序_MySQL 8.0 参考手册

4.6.1 ibd2sdi — InnoDB 表空间 SDI 提取实用程序_MySQL 8.0 参考手册
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
4.1 MySQL程序概述
4.2 使用 MySQL 程序
4.3 服务器和服务器启动程序
4.4 安装相关程序
4.5 客户端程序
4.6 管理和实用程序
4.6.1 ibd2sdi — InnoDB 表空间 SDI 提取实用程序1
4.6.2 innochecksum — 离线 InnoDB 文件校验和工具1
4.6.3 myisam_ftdump——显示全文索引信息1
4.6.4 myisamchk — MyISAM 表维护实用程序1
4.6.5 myisamlog——显示MyISAM日志文件内容1
4.6.6 myisampack——生成压缩的、只读的 MyISAM 表1
4.6.7 mysql_config_editor — MySQL 配置实用程序1
4.6.8 mysql_migrate_keyring — 密钥环密钥迁移实用程序1
4.6.9 mysqlbinlog — 处理二进制日志文件的实用程序1
4.6.10 mysqldumpslow——总结慢查询日志文件1
4.7 程序开发实用程序
4.8 杂项程序
4.9 环境变量
4.10 MySQL 中的 Unix 信号处理
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
MySQL 8.0 参考手册  / 第 4 章 MySQL 程序  / 4.6 管理和实用程序  /
4.6.1 ibd2sdi — InnoDB 表空间 SDI 提取实用程序
4.6.1 ibd2sdi — InnoDB 表空间 SDI 提取实用程序
ibd2sdi是一个用于
表空间文件序列化字典信息(SDI)
InnoDBSDI 数据存在于所有持久InnoDB表空间文件中。
ibd2sdi可以在
file-per-table 表
空间文件 (*.ibdfiles )、
通用表空间文件 (*.ibdfiles )、
系统表空间
文件 (ibdata*files ) 和数据字典表空间 (mysql.ibd) 上运行。它不支持与临时表空间或撤消表空间一起使用。
ibd2sdi可以在运行时或服务器离线时使用。在DDL
操作、
操作和undo log purge操作过程中， ibd2sdiROLLBACK
可能会有一小段时间
无法读取存储在表空间中的SDI数据。
ibd2sdi从指定的表空间执行未提交的 SDI 读取。不访问重做日志和撤消日志。
像这样调用ibd2sdi实用程序：
ibd2sdi [options] file_name1 [file_name2 file_name3 ...]
ibd2sdi支持多文件表空间，如InnoDB系统表空间，但它不能一次在多个表空间上运行。对于多文件表空间，指定每个文件：
ibd2sdi ibdata1 ibdata2
多文件表空间的文件必须按照页码升序指定。如果两个连续文件具有相同的空间 ID，则后一个文件必须以前一个文件的最后页码 + 1 开头。
ibd2sdi以格式输出 SDI（包含 id、type 和 data 字段）JSON。
ibd2sdi 选项
ibd2sdi支持以下选项：
--help,-h
显示帮助信息并退出。例如：
Usage: ./ibd2sdi [-v] [-c <strict-check>] [-d <dump file name>] [-n] filename1 [filenames]
See http://dev.mysql.com/doc/refman/8.0/en/ibd2sdi.html for usage hints.
-h, --help          Display this help and exit.
-v, --version       Display version information and exit.
-#, --debug[=name]  Output debug log. See
http://dev.mysql.com/doc/refman/8.0/en/dbug-package.html
-d, --dump-file=name
Dump the tablespace SDI into the file passed by user.
Without the filename, it will default to stdout
-s, --skip-data     Skip retrieving data from SDI records. Retrieve only id
and type.
-i, --id=#          Retrieve the SDI record matching the id passed by user.
-t, --type=#        Retrieve the SDI records matching the type passed by
user.
-c, --strict-check=name
Specify the strict checksum algorithm by the user.
Allowed values are innodb, crc32, none.
-n, --no-check      Ignore the checksum verification.
-p, --pretty        Pretty format the SDI output.If false, SDI would be not
human readable but it will be of less size
(Defaults to on; use --skip-pretty to disable.)
Variables (--variable-name=value)
and boolean options {FALSE|TRUE}  Value (after reading options)
--------------------------------- ----------------------------------------
debug                             (No default value)
dump-file                         (No default value)
skip-data                         FALSE
id                                0
type                              0
strict-check                      crc32
no-check                          FALSE
pretty                            TRUE
--version,
-v
显示版本信息并退出。例如：
ibd2sdi  Ver 8.0.3-dmr for Linux on x86_64 (Source distribution)
--debug[=debug_options],
-#
[debug_options]
打印调试日志。有关调试选项，请参阅
第 5.9.4 节 “DBUG 包”。
ibd2sdi --debug=d:t /tmp/ibd2sdi.trace
仅当 MySQL 是使用
WITH_DEBUG. Oracle 提供的 MySQL 发布二进制文件不是
使用此选项构建的。
--dump-file=,
-d
将序列化字典信息 (SDI) 转储到指定的转储文件中。如果未指定转储文件，表空间 SDI 将转储到stdout.
ibd2sdi --dump-file=file_name ../data/test/t1.ibd
--skip-data,
-s
跳过data从序列化字典信息 (SDI) 中检索字段值，仅检索id和
type字段值，它们是 SDI 记录的主键。
$> ibd2sdi --skip-data ../data/test/t1.ibd
["ibd2sdi"
,
{
"type": 1,
"id": 330
}
,
{
"type": 2,
"id": 7
}
]
--id=#,
-i #
检索与指定表或表空间对象 ID 匹配的序列化字典信息 (SDI)。对象 ID 对于对象类型是唯一的。表和表空间对象 ID 也可以在数据字典表的id列中
mysql.tables找到
。mysql.tablespace有关数据字典表的信息，请参阅
第 14.1 节，“数据字典模式”。
$> ibd2sdi --id=7 ../data/test/t1.ibd
["ibd2sdi"
,
{
"type": 2,
"id": 7,
"object":
{
"mysqld_version_id": 80003,
"dd_version": 80003,
"sdi_version": 1,
"dd_object_type": "Tablespace",
"dd_object": {
"name": "test/t1",
"comment": "",
"options": "",
"se_private_data": "flags=16417;id=2;server_version=80003;space_version=1;",
"engine": "InnoDB",
"files": [
{
"ordinal_position": 1,
"filename": "./test/t1.ibd",
"se_private_data": "id=2;"
}
]
}
}
}
]
--type=#,
-t #
检索与指定对象类型匹配的序列化字典信息 (SDI)。SDI 是为表（type=1）和表空间（type=2）对象提供的。
$> ibd2sdi --type=2 ../data/test/t1.ibd
["ibd2sdi"
,
{
"type": 2,
"id": 7,
"object":
{
"mysqld_version_id": 80003,
"dd_version": 80003,
"sdi_version": 1,
"dd_object_type": "Tablespace",
"dd_object": {
"name": "test/t1",
"comment": "",
"options": "",
"se_private_data": "flags=16417;id=2;server_version=80003;space_version=1;",
"engine": "InnoDB",
"files": [
{
"ordinal_position": 1,
"filename": "./test/t1.ibd",
"se_private_data": "id=2;"
}
]
}
}
}
]
--strict-check,
-c
指定一个严格的校验和算法来验证读取的页面的校验和。选项包括
innodb、crc32和
none。
在此示例中，
innodb指定了校验和算法的严格版本：
ibd2sdi --strict-check=innodb ../data/test/t1.ibdcrc32在此示例中，指定了校验和算法
的严格版本
：ibd2sdi -c crc32 ../data/test/t1.ibd
如果您未指定该
--strict-check选项，则会针对非严格
innodb和校验和
crc32执行
验证。none
--no-check,
-n
跳过已读取页面的校验和验证。
ibd2sdi --no-check ../data/test/t1.ibd
--pretty,
-p
以 JSON 漂亮的打印格式输出 SDI 数据。默认启用。如果禁用，SDI 不是人类可读的，但大小更小。用于--skip-pretty禁用。
ibd2sdi --skip-pretty ../data/test/t1.ibd
© Mysql 中文网
