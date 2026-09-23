# 26.8 SHOW 语句的扩展_MySQL 8.0 参考手册

26.8 SHOW 语句的扩展_MySQL 8.0 参考手册
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
26.1 简介
26.2 INFORMATION_SCHEMA 表参考
26.3 INFORMATION_SCHEMA 总表
26.4 INFORMATION_SCHEMA InnoDB 表
26.5 INFORMATION_SCHEMA线程池表
26.6 INFORMATION_SCHEMA 连接控制表
26.7 INFORMATION_SCHEMA MySQL 企业防火墙表
26.8 SHOW 语句的扩展
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
MySQL 8.0 参考手册  / 第 26 章 INFORMATION_SCHEMA 表  /
26.8 SHOW 语句的扩展
26.8 SHOW 语句的扩展
语句的一些扩展SHOW伴随着以下的实现
INFORMATION_SCHEMA：
SHOW可用于获取有关
INFORMATION_SCHEMA自身结构的信息。
多个SHOW语句接受一个WHERE子句，该子句在指定要显示的行方面提供了更大的灵活性。
INFORMATION_SCHEMA是一个信息数据库，因此它的名称包含在
SHOW DATABASES. 同样，
SHOW TABLES可以与一起使用
INFORMATION_SCHEMA以获取其表的列表：
mysql> SHOW TABLES FROM INFORMATION_SCHEMA;
+---------------------------------------+
| Tables_in_INFORMATION_SCHEMA          |
+---------------------------------------+
| CHARACTER_SETS                        |
| COLLATIONS                            |
| COLLATION_CHARACTER_SET_APPLICABILITY |
| COLUMNS                               |
| COLUMN_PRIVILEGES                     |
| ENGINES                               |
| EVENTS                                |
| FILES                                 |
| KEY_COLUMN_USAGE                      |
| PARTITIONS                            |
| PLUGINS                               |
| PROCESSLIST                           |
| REFERENTIAL_CONSTRAINTS               |
| ROUTINES                              |
| SCHEMATA                              |
| SCHEMA_PRIVILEGES                     |
| STATISTICS                            |
| TABLES                                |
| TABLE_CONSTRAINTS                     |
| TABLE_PRIVILEGES                      |
| TRIGGERS                              |
| USER_PRIVILEGES                       |
| VIEWS                                 |
+---------------------------------------+
SHOW COLUMNS并且
DESCRIBE可以显示有关各个
INFORMATION_SCHEMA表中列的信息。
SHOW接受
LIKE子句以限制显示的行的语句也允许一个WHERE子句指定所选行必须满足的更一般的条件：
SHOW CHARACTER SET
SHOW COLLATION
SHOW COLUMNS
SHOW DATABASES
SHOW FUNCTION STATUS
SHOW INDEX
SHOW OPEN TABLES
SHOW PROCEDURE STATUS
SHOW STATUS
SHOW TABLE STATUS
SHOW TABLES
SHOW TRIGGERS
SHOW VARIABLES
该WHERE子句（如果存在）根据语句显示的列名进行评估
SHOW。例如，
SHOW CHARACTER SET语句产生这些输出列：
mysql> SHOW CHARACTER SET;
+----------+-----------------------------+---------------------+--------+
| Charset  | Description                 | Default collation   | Maxlen |
+----------+-----------------------------+---------------------+--------+
| big5     | Big5 Traditional Chinese    | big5_chinese_ci     |      2 |
| dec8     | DEC West European           | dec8_swedish_ci     |      1 |
| cp850    | DOS West European           | cp850_general_ci    |      1 |
| hp8      | HP West European            | hp8_english_ci      |      1 |
| koi8r    | KOI8-R Relcom Russian       | koi8r_general_ci    |      1 |
| latin1   | cp1252 West European        | latin1_swedish_ci   |      1 |
| latin2   | ISO 8859-2 Central European | latin2_general_ci   |      1 |
...
要使用WHERE子句 with
SHOW CHARACTER SET，您将引用那些列名。例如，以下语句显示有关默认排序规则包含字符串的字符集的信息'japanese'：
mysql> SHOW CHARACTER SET WHERE `Default collation` LIKE '%japanese%';
+---------+---------------------------+---------------------+--------+
| Charset | Description               | Default collation   | Maxlen |
+---------+---------------------------+---------------------+--------+
| ujis    | EUC-JP Japanese           | ujis_japanese_ci    |      3 |
| sjis    | Shift-JIS Japanese        | sjis_japanese_ci    |      2 |
| cp932   | SJIS for Windows Japanese | cp932_japanese_ci   |      2 |
| eucjpms | UJIS for Windows Japanese | eucjpms_japanese_ci |      3 |
+---------+---------------------------+---------------------+--------+
此语句显示多字节字符集：
mysql> SHOW CHARACTER SET WHERE Maxlen > 1;
+---------+---------------------------------+---------------------+--------+
| Charset | Description                     | Default collation   | Maxlen |
+---------+---------------------------------+---------------------+--------+
| big5    | Big5 Traditional Chinese        | big5_chinese_ci     |      2 |
| cp932   | SJIS for Windows Japanese       | cp932_japanese_ci   |      2 |
| eucjpms | UJIS for Windows Japanese       | eucjpms_japanese_ci |      3 |
| euckr   | EUC-KR Korean                   | euckr_korean_ci     |      2 |
| gb18030 | China National Standard GB18030 | gb18030_chinese_ci  |      4 |
| gb2312  | GB2312 Simplified Chinese       | gb2312_chinese_ci   |      2 |
| gbk     | GBK Simplified Chinese          | gbk_chinese_ci      |      2 |
| sjis    | Shift-JIS Japanese              | sjis_japanese_ci    |      2 |
| ucs2    | UCS-2 Unicode                   | ucs2_general_ci     |      2 |
| ujis    | EUC-JP Japanese                 | ujis_japanese_ci    |      3 |
| utf16   | UTF-16 Unicode                  | utf16_general_ci    |      4 |
| utf16le | UTF-16LE Unicode                | utf16le_general_ci  |      4 |
| utf32   | UTF-32 Unicode                  | utf32_general_ci    |      4 |
| utf8mb3 | UTF-8 Unicode                   | utf8mb3_general_ci  |      3 |
| utf8mb4 | UTF-8 Unicode                   | utf8mb4_0900_ai_ci  |      4 |
+---------+---------------------------------+---------------------+--------+
© Mysql 中文网
