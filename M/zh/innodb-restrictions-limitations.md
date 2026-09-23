# 15.23 InnoDB 限制和限制_MySQL 8.0 参考手册

15.23 InnoDB 限制和限制_MySQL 8.0 参考手册
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
MySQL 8.0 参考手册  / 第 15 章 InnoDB 存储引擎  /
15.23 InnoDB 限制和限制
15.23 InnoDB 限制和限制
InnoDB本节描述存储引擎
的约束和限制
。
您不能使用与内部InnoDB列名称（包括DB_ROW_ID、
DB_TRX_ID和
）相匹配的列名称创建表DB_ROLL_PTR。此限制适用于以任何字母大小写形式使用名称。
mysql> CREATE TABLE t1 (c1 INT, db_row_id INT) ENGINE=INNODB;
ERROR 1166 (42000): Incorrect column name 'db_row_id'
SHOW TABLE STATUSInnoDB
除了表保留的物理大小外，不提供表的准确统计信息。行数只是 SQL 优化中使用的粗略估计。
InnoDB不保留表中行的内部计数，因为并发事务可能同时
“看到”不同数量的行。因此，SELECT COUNT(*)语句只对当前事务可见的行进行计数。
有关如何InnoDB处理
SELECT COUNT(*)语句的信息，请参阅
第COUNT()12.20.1
节“聚合函数说明”中的说明。
ROW_FORMAT=COMPRESSED不支持大于 16KB 的页面大小。
使用特定InnoDB
页面大小 ( innodb_page_size) 的 MySQL 实例不能使用来自使用不同页面大小的实例的数据文件或日志文件。
有关使用可
传输表空间功能导入表的相关限制，请参阅
表导入限制。
有关与在线 DDL 相关的限制，请参阅
第 15.12.8 节，“在线 DDL 限制”。
有关与一般表空间相关的限制，请参阅
一般表空间限制。
有关与静态数据加密相关的限制，请参阅
加密限制。
© Mysql 中文网
