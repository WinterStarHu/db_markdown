# 7.4.4 重新加载定界文本格式备份_MySQL 8.0 参考手册

7.4.4 重新加载定界文本格式备份_MySQL 8.0 参考手册
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
7.1 备份和恢复类型
7.2 数据库备份方式
7.3 示例备份和恢复策略
7.4 使用 mysqldump 进行备份
7.4.1 使用 mysqldump 转储 SQL 格式的数据1
7.4.2 重新加载 SQL 格式的备份1
7.4.3 使用 mysqldump 以定界文本格式转储数据1
7.4.4 重新加载定界文本格式备份1
7.4.5 mysqldump 提示1
7.5 时间点（增量）恢复
7.6 MyISAM表维护和崩溃恢复
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
MySQL 8.0 参考手册  / 第 7 章备份与恢复  / 7.4 使用 mysqldump 进行备份  /
7.4.4 重新加载定界文本格式备份
7.4.4 重新加载定界文本格式备份
对于使用mysqldump --tab生成的备份，每个表在输出目录中由一个
.sql包含
CREATE TABLE表语句的.txt文件和一个包含表数据的文件表示。要重新加载表，首先将位置更改为输出目录。然后.sql用
mysql处理文件创建一个空表，处理.txt文件加载数据到表中：
$> mysql db1 < t1.sql
$> mysqlimport db1 t1.txt
使用mysqlimport加载数据文件的替代方法是使用mysqlLOAD
DATA客户端中的语句
：
mysql> USE db1;
mysql> LOAD DATA INFILE 't1.txt' INTO TABLE t1;
如果您
在最初转储表时
对mysqldump使用了任何数据格式化选项，则必须对mysqlimport使用相同的选项或LOAD
DATA确保正确解释数据文件内容：
$> mysqlimport --fields-terminated-by=,
--fields-enclosed-by='"' --lines-terminated-by=0x0d0a db1 t1.txt
或者：
mysql> USE db1;
mysql> LOAD DATA INFILE 't1.txt' INTO TABLE t1
FIELDS TERMINATED BY ',' FIELDS ENCLOSED BY '"'
LINES TERMINATED BY '\r\n';
© Mysql 中文网
