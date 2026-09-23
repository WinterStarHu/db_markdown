# B.3.7 MySQL 中的已知问题_MySQL 8.0 参考手册

B.3.7 MySQL 中的已知问题_MySQL 8.0 参考手册
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
2.1 一般安装指南
2.2 使用通用二进制文件在 Unix/Linux 上安装 MySQL
2.3 在 Microsoft Windows 上安装 MySQL
2.4 在 macOS 上安装 MySQL
2.5 在 Linux 上安装 MySQL
2.6 使用坚不可摧的Linux网络（ULN）安装MySQL
2.7 在 Solaris 上安装 MySQL
2.8 在 FreeBSD 上安装 MySQL
2.9 从源码安装MySQL
2.9.1 源码安装方式1
2.9.2 源安装先决条件1
2.9.3 MySQL源码安装布局1
2.9.4 使用标准源代码分发安装 MySQL1
2.9.5 使用开发源树安装MySQL1
2.9.6 配置 SSL 库支持1
2.9.7 MySQL 源配置选项1
2.9.8 处理编译MySQL的问题1
B.3.1 如何确定导致问题的原因
B.3.2 使用 MySQL 程序时的常见错误
B.3.3 管理相关问题
B.3.4 查询相关问题
B.3.5 优化器相关问题
B.3.6 表定义相关问题
B.3.7 MySQL 中的已知问题
2.9.9 MySQL配置和第三方工具1
2.9.10 生成MySQL Doxygen文档内容1
2.10 安装后设置和测试
2.11 升级MySQL
2.12 降级MySQL
2.13 Perl 安装注意事项
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
MySQL 8.0 参考手册  / 第 2 章安装和升级 MySQL  / 2.9 从源码安装MySQL  / 2.9.8 处理编译MySQL的问题  /
B.3.7 MySQL 中的已知问题
B.3.7 MySQL 中的已知问题
本节列出了最新版本的 MySQL 中的已知问题。
有关平台特定问题的信息，请参阅
第 2.1 节“一般安装指南”和
第 5.9 节“调试 MySQL”中的安装和调试说明。
已知以下问题：
的子查询优化IN不如 有效=。
即使您使用lower_case_table_names=2
（这使 MySQL 能够记住用于数据库和表名的大小写），MySQL 也不会记住用于函数
DATABASE()或各种日志（在不区分大小写的系统上）的数据库名称的大小写。
删除FOREIGN KEY约束在复制中不起作用，因为约束在副本上可能有另一个名称。
REPLACE（和
LOAD DATA选项
REPLACE）不触发ON DELETE CASCADE。
DISTINCT如果您不使用列表中的所有列且仅使用列表中的那些列，则
withORDER BY
在内部不起作用
。
GROUP_CONCAT()DISTINCT
将大整数值（介于 2 63和 2 64 −1 之间）插入小数或字符串列时，它会作为负值插入，因为该数字是在有符号整数上下文中计算的。
使用基于语句的二进制日志记录，源服务器将执行的查询写入二进制日志。这是一种非常快速、紧凑且高效的日志记录方法，在大多数情况下都能完美运行。但是，如果以数据修改不确定的方式设计查询（通常不推荐的做法，即使在复制之外），源和副本上的数据也可能变得不同。
例如：
CREATE
TABLE ... SELECT或
将零或值插入
列的INSERT
... SELECT语句
。
NULLAUTO_INCREMENT
DELETE如果要从具有带
ON DELETE CASCADE属性的外键的表中删除行。
REPLACE ...
SELECT，INSERT IGNORE ...
SELECT如果您在插入的数据中有重复的键值。
当且仅当前面的查询没有ORDER BY保证确定性顺序的子句时。
例如，对于
INSERT ...
SELECTno ORDER BY，
SELECT可能会以不同的顺序返回行（这会导致行具有不同的等级，因此在
AUTO_INCREMENT列中获得不同的数字），具体取决于优化器对源和副本所做的选择。
只有在以下情况下，查询才会在源和副本上进行不同的优化：
该表在源上使用与副本上不同的存储引擎进行存储。（可以在源和副本上使用不同的存储引擎。例如，您可以InnoDB在源上使用，但MyISAM如果副本的可用磁盘空间较少，则在副本上使用。）
源和副本上的MySQL 缓冲区大小（key_buffer_size等）不同。
源和副本运行不同的 MySQL 版本，优化器代码在这些版本之间不同。
这个问题也可能影响使用
mysqlbinlog|mysql的数据库恢复。
避免此问题的最简单方法是
ORDER BY在上述非确定性查询中添加一个子句，以确保行始终以相同的顺序存储或修改。使用基于行或混合的日志格式也可以避免这个问题。
如果您未使用启动选项指定文件名，则日志文件名基于服务器主机名。如果将主机名更改为其他名称，要保留相同的日志文件名，必须明确使用诸如
. 请参阅第 5.1.7 节，“服务器命令选项”。或者，重命名旧文件以反映您的主机名更改。如果这些是二进制日志，您必须编辑二进制日志索引文件并修复二进制日志文件名。（副本上的中继日志也是如此。）
--log-bin=old_host_name-bin
mysqlbinlog不会删除LOAD DATA
语句后留下的临时文件。请参阅第 4.6.9 节，“mysqlbinlog — 处理二进制日志文件的实用程序”。
RENAME不适
TEMPORARY用于表格或表格中使用的
MERGE表格。
使用 时SET CHARACTER SET，您不能在数据库、表和列名称中使用翻译后的字符。
在 MySQL 8.0.17 之前，您不能使用_
or %with ESCAPEin
LIKE ...
ESCAPE。
服务器
max_sort_length在比较数据值时仅使用第一个字节。这意味着值不能可靠地用于GROUP BY,
ORDER BY, 或者DISTINCT
它们仅在第一个
max_sort_length字节后不同。要解决此问题，请增加变量值。默认值为max_sort_length1024，可以在服务器启动时或运行时更改。
数值计算是用
BIGINTor
完成的DOUBLE（两者通常都是 64 位长）。您获得的精度取决于功能。一般规则是位函数以
BIGINT精度执行，
IF()并
ELT()以
BIGINTor
DOUBLE精度执行，其余以DOUBLE精度执行。如果 unsigned long long 值解析为大于 63 位 (9223372036854775807)，除了位域之外，您应该尽量避免使用它们。
一张表中最多可以有 255ENUM
列SET。
在MIN()、
MAX()和其他聚合函数中，MySQL 目前
根据字符串值而不是字符串在集合中的相对位置来
比较ENUM和
列。SET
在一个UPDATE语句中，列从左到右更新。如果您引用更新的列，您将获得更新的值而不是原始值。例如，以下语句递增KEY，2而
不是 1：
mysql> UPDATE tbl_name SET KEY=KEY+1,KEY=KEY+1;
您可以在同一查询中引用多个临时表，但不能多次引用任何给定的临时表。例如，以下内容不起作用：
mysql> SELECT * FROM temp_table, temp_table AS t2;
ERROR 1137: Can't reopen table: 'temp_table'DISTINCT
当您在联接中使用“隐藏”列时
，优化器的处理方式可能与未使用时不同。在连接中，隐藏列被计为结果的一部分（即使它们没有显示），而在普通查询中，隐藏列不参与DISTINCT比较。
这方面的一个例子是：
SELECT DISTINCT mp3id FROM band_downloads
WHERE userid = 9 ORDER BY id DESC;
和
SELECT DISTINCT band_downloads.mp3id
FROM band_downloads,band_mp3
WHERE band_downloads.userid = 9
AND band_mp3.id = band_downloads.mp3id
ORDER BY band_downloads.id DESC;
在第二种情况下，您可能会在结果集中得到两个相同的行（因为隐藏
id列中的值可能不同）。
请注意，这仅发生在结果中没有
ORDER BY列的查询中。
如果PROCEDURE对返回空集的查询执行 a，在某些情况下
PROCEDURE不会转换列。
类型表的创建MERGE不会检查基础表是否为兼容类型。
如果您使用ALTER TABLE向UNIQUE表中使用的
MERGE表添加索引，然后在表上添加普通索引，MERGE如果表中有旧的非UNIQUE键，则表的键顺序不同。这是因为ALTER TABLE将
UNIQUE索引放在普通索引之前，以便能够尽早检测到重复键。
© Mysql 中文网
