# 15.8.10 为 InnoDB 配置优化器统计信息_MySQL 8.0 参考手册

15.8.10 为 InnoDB 配置优化器统计信息_MySQL 8.0 参考手册
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
15.8.1 InnoDB启动配置1
15.8.2 为只读操作配置 InnoDB1
15.8.3 InnoDB缓冲池配置1
15.8.4 为 InnoDB 配置线程并发1
15.8.5 配置后台InnoDB I/O线程数1
15.8.6 在 Linux 上使用异步 I/O1
15.8.7 配置 InnoDB I/O 容量1
15.8.8 配置自旋锁轮询1
15.8.9 清除配置1
15.8.10 为 InnoDB 配置优化器统计信息1
15.8.10.1 配置持久优化器统计参数
15.8.10.2 配置非持久优化器统计参数
15.8.10.3 估计 InnoDB 表的 ANALYZE TABLE 复杂性
15.8.11 配置索引页的合并阈值1
15.8.12 为专用 MySQL 服务器启用自动配置1
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
MySQL 8.0 参考手册  / 第 15 章 InnoDB 存储引擎  / 15.8 InnoDB配置  /
15.8.10 为 InnoDB 配置优化器统计信息
15.8.10 为 InnoDB 配置优化器统计信息
15.8.10.1 配置持久优化器统计参数15.8.10.2 配置非持久优化器统计参数15.8.10.3 估计 InnoDB 表的 ANALYZE TABLE 复杂性
本节介绍如何为表配置持久性和非持久性优化器统计信息InnoDB
。
持久优化器统计信息在服务器重新启动时保持不变，从而实现更高的
计划稳定性和更一致的查询性能。持久优化器统计信息还提供控制和灵活性以及这些额外的好处：
您可以使用
innodb_stats_auto_recalc
配置选项来控制是否在对表进行大量更改后自动更新统计信息。
您可以将STATS_PERSISTENT、
STATS_AUTO_RECALC和
STATS_SAMPLE_PAGES子句与
CREATE TABLEand
ALTER TABLE语句一起使用来为单个表配置优化器统计信息。
mysql.innodb_table_stats您可以在和
mysql.innodb_index_stats表
中查询优化器统计数据
。
您可以查看和
表的last_update列
以了解上次更新统计信息的时间。
mysql.innodb_table_statsmysql.innodb_index_stats
您可以手动修改
mysql.innodb_table_stats和
mysql.innodb_index_stats表以强制执行特定的查询优化计划或在不修改数据库的情况下测试替代计划。
默认情况下启用持久优化器统计功能 ( innodb_stats_persistent=ON)。
非持久性优化器统计信息在每次服务器重新启动时和其他一些操作后被清除，并在下一次表访问时重新计算。因此，在重新计算统计信息时可能会产生不同的估计，从而导致执行计划的不同选择和查询性能的变化。
本节还提供有关估计
复杂性的信息，这在尝试在准确的统计信息和
执行时间
ANALYZE TABLE之间取得平衡时可能很有用。ANALYZE TABLE
© Mysql 中文网
