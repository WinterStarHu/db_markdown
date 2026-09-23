# 15.1.2 InnoDB 表的最佳实践_MySQL 8.0 参考手册

15.1.2 InnoDB 表的最佳实践_MySQL 8.0 参考手册
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
15.1.1 使用 InnoDB 表的好处1
15.1.2 InnoDB 表的最佳实践1
15.1.3 验证 InnoDB 是默认存储引擎1
15.1.4 使用 InnoDB 进行测试和基准测试1
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
MySQL 8.0 参考手册  / 第 15 章 InnoDB 存储引擎  / 15.1 InnoDB简介  /
15.1.2 InnoDB 表的最佳实践
15.1.2 InnoDB 表的最佳实践
本节介绍使用
InnoDB表格时的最佳做法。
使用最常查询的一个或多个列为每个表指定一个主键，如果没有明显的主键，则指定一个自动增量值。
在基于这些表的相同 ID 值从多个表中提取数据的任何地方使用连接。为了快速连接性能，在连接列上定义外键，并在每个表中声明具有相同数据类型的那些列。添加外键可确保为引用的列建立索引，从而提高性能。外键还会将删除和更新传播到所有受影响的表，并在父表中不存在相应 ID 的情况下阻止在子表中插入数据。
关闭自动提交。每秒提交数百次会限制性能（受限于存储设备的写入速度）。
START TRANSACTION通过用括号和
COMMIT语句
将相关的 DML 操作集分组到事务中。虽然您不想过于频繁地提交，但您也不希望发布
运行数小时而未提交
的大量INSERT,
UPDATE, 或
语句。DELETE
不要使用LOCK TABLES
语句。InnoDB可以在不牺牲可靠性或高性能的情况下处理多个会话，同时读取和写入同一个表。要获得对一组行的独占写访问权，请使用
SELECT
... FOR UPDATE语法来锁定您打算更新的行。
启用
innodb_file_per_table
变量或使用通用表空间将表的数据和索引放入单独的文件而不是系统表空间。默认情况下启用该
innodb_file_per_table
变量。
评估您的数据和访问模式是否受益于InnoDB表或页面压缩功能。InnoDB您可以在不牺牲读/写能力的情况下
压缩表。
使用选项运行服务器
--sql_mode=NO_ENGINE_SUBSTITUTION
以防止使用您不想使用的存储引擎创建表。
© Mysql 中文网
