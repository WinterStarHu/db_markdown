# 15.11.5 使用 TRUNCATE TABLE 回收磁盘空间_MySQL 8.0 参考手册

15.11.5 使用 TRUNCATE TABLE 回收磁盘空间_MySQL 8.0 参考手册
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
15.11.1 InnoDB 磁盘 I/O1
15.11.2 文件空间管理1
15.11.3 InnoDB 检查点1
15.11.4 对表进行碎片整理1
15.11.5 使用 TRUNCATE TABLE 回收磁盘空间1
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
MySQL 8.0 参考手册  / 第 15 章 InnoDB 存储引擎  / 15.11 InnoDB磁盘I/O和文件空间管理  /
15.11.5 使用 TRUNCATE TABLE 回收磁盘空间
15.11.5 使用 TRUNCATE TABLE 回收磁盘空间
要在截断表
时回收操作系统磁盘空间
，
InnoDB表必须存储在其自己的.ibd文件中。对于要存储在其自己的.ibd
文件中innodb_file_per_table的表，必须在创建表时启用。另外，被截断的表和其他表之间
不能有
外键TRUNCATE TABLE约束，否则操作失败。但是，允许在同一个表中的两列之间使用外键约束。
当表被截断时，它会被删除并在新文件中重新创建，
.ibd释放的空间会返回给操作系统。这与
InnoDB存储在
InnoDB
系统表空间中的截断表
（创建的表innodb_file_per_table=OFF）和存储在共享
通用表空间中的表形成对比，后者只能InnoDB在表被截断后使用释放的空间。
截断表并将磁盘空间返回给操作系统的能力还意味着
物理备份可以更小。截断存储在系统表空间（创建时创建的表
innodb_file_per_table=OFF）或通用表空间中的表会在表空间中留下未使用的空间块。
© Mysql 中文网
