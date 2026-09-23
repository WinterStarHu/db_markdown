# 15.15.7 InnoDB INFORMATION_SCHEMA临时表信息表_MySQL 8.0 参考手册

15.15.7 InnoDB INFORMATION_SCHEMA临时表信息表_MySQL 8.0 参考手册
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
15.15.7 InnoDB INFORMATION_SCHEMA临时表信息表
15.15.7 InnoDB INFORMATION_SCHEMA临时表信息表
INNODB_TEMP_TABLE_INFO提供有关实例InnoDB中活动的用户创建的临时表的信息。InnoDB它不提供有关
InnoDB优化器使用的内部临时表的信息。
mysql> SHOW TABLES FROM INFORMATION_SCHEMA LIKE 'INNODB_TEMP%';
+---------------------------------------------+
| Tables_in_INFORMATION_SCHEMA (INNODB_TEMP%) |
+---------------------------------------------+
| INNODB_TEMP_TABLE_INFO                      |
+---------------------------------------------+
有关表定义，请参阅
第 26.4.27 节，“INFORMATION_SCHEMA INNODB_TEMP_TABLE_INFO 表”。
示例 15.12 INNODB_TEMP_TABLE_INFO
此示例演示
INNODB_TEMP_TABLE_INFO表的特征。
创建一个简单的InnoDB临时表：
mysql> CREATE TEMPORARY TABLE t1 (c1 INT PRIMARY KEY) ENGINE=INNODB;
查询INNODB_TEMP_TABLE_INFO以查看临时表元数据。
mysql> SELECT * FROM INFORMATION_SCHEMA.INNODB_TEMP_TABLE_INFO\G
*************************** 1. row ***************************
TABLE_ID: 194
NAME: #sql7a79_1_0
N_COLS: 4
SPACE: 182TABLE_ID 是临时表的唯一标识符
。该NAME列显示系统为临时表生成的名称，该名称以“ #sql ”为前缀。列数 ( N_COLS) 是 4 而不是 1，因为InnoDB总是创建三个隐藏表列（DB_ROW_ID、
DB_TRX_ID和
DB_ROLL_PTR）。
重启 MySQL 并查询
INNODB_TEMP_TABLE_INFO。
mysql> SELECT * FROM INFORMATION_SCHEMA.INNODB_TEMP_TABLE_INFO\G
返回一个空集，因为
INNODB_TEMP_TABLE_INFO它的数据在服务器关闭时不会持久保存到磁盘。
创建一个新的临时表。
mysql> CREATE TEMPORARY TABLE t1 (c1 INT PRIMARY KEY) ENGINE=INNODB;
查询INNODB_TEMP_TABLE_INFO以查看临时表元数据。
mysql> SELECT * FROM INFORMATION_SCHEMA.INNODB_TEMP_TABLE_INFO\G
*************************** 1. row ***************************
TABLE_ID: 196
NAME: #sql7b0e_1_0
N_COLS: 4
SPACE: 184SPACEID 可能不同，因为它是在服务器启动时动态生成的
。
© Mysql 中文网
