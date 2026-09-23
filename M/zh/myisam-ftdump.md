# 4.6.3 myisam_ftdump——显示全文索引信息_MySQL 8.0 参考手册

4.6.3 myisam_ftdump——显示全文索引信息_MySQL 8.0 参考手册
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
4.6.3 myisam_ftdump——显示全文索引信息
4.6.3 myisam_ftdump——显示全文索引信息
myisam_ftdump显示有关
FULLTEXT索引的MyISAM
。它直接读取MyISAM索引文件，因此必须在表所在的服务器主机上运行。在使用myisam_ftdump之前，如果服务器正在运行，请务必先发出一条FLUSH TABLES语句。
myisam_ftdump扫描并转储整个索引，速度不是特别快。另一方面，单词的分布变化不频繁，因此不需要经常运行。
像这样调用myisam_ftdump：
myisam_ftdump [options] tbl_name index_numtbl_name参数应该是表的
名称MyISAM。您也可以通过命名其索引文件（具有
.MYI后缀的文件）来指定表。如果您不在表文件所在的目录中调用
myisam_ftdump，则表或索引文件名必须以表的数据库目录的路径名开头。索引编号以 0 开头。
示例：假设test数据库包含一个名为的表mytexttable，其定义如下：
CREATE TABLE mytexttable
(
id   INT NOT NULL,
txt  TEXT NOT NULL,
PRIMARY KEY (id),
FULLTEXT (txt)
) ENGINE=MyISAM;
The index onid是 index 0，
FULLTEXTindex ontxt是 index 1。如果你的工作目录是
test数据库目录，调用
myisam_ftdump如下：
myisam_ftdump mytexttable 1
如果test数据库目录的路径名为/usr/local/mysql/data/test，您还可以使用该路径名指定表名参数。如果您不在数据库目录中
调用myisam_ftdump ，这将很有用
：myisam_ftdump /usr/local/mysql/data/test/mytexttable 1
您可以使用myisam_ftdump生成索引条目列表，按照在类 Unix 系统上的出现频率排序：
myisam_ftdump -c mytexttable 1 | sort -r
在 Windows 上，使用：
myisam_ftdump -c mytexttable 1 | sort /R
myisam_ftdump支持以下选项：
--help,
-h -?
显示帮助信息并退出。
--count,
-c
计算每个单词的统计信息（计数和全局权重）。
--dump,
-d
转储索引，包括数据偏移量和单词权重。
--length,
-l
报告长度分布。
--stats,
-s
报告全局索引统计信息。如果未指定其他操作，则这是默认操作。
--verbose,
-v
详细模式。打印更多关于程序做什么的输出。
© Mysql 中文网
