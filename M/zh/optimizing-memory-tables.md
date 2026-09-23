# 8.7 优化 MEMORY 表_MySQL 8.0 参考手册

8.7 优化 MEMORY 表_MySQL 8.0 参考手册
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
8.1 优化概述
8.2 优化SQL语句
8.3 优化和索引
8.4 优化数据库结构
8.5 优化 InnoDB 表
8.6 优化 MyISAM 表
8.7 优化 MEMORY 表
8.8 了解查询执行计划
8.9 控制查询优化器
8.10 缓冲和缓存
8.11 优化锁定操作
8.12 优化MySQL服务器
8.13 测量性能（基准测试）
8.14 查看服务器线程（进程）信息
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
MySQL 8.0 参考手册  / 第8章优化  /
8.7 优化 MEMORY 表
8.7 优化 MEMORY 表
考虑MEMORY对经常访问、只读或很少更新的非关键数据使用表。在实际工作负载下将您的应用程序与等效
项InnoDB或MyISAM表进行基准测试，以确认任何额外的性能都值得冒丢失数据的风险，或在应用程序启动时从基于磁盘的表复制数据的开销。
为了获得表的最佳性能MEMORY，请检查针对每个表的查询类型，并指定用于每个关联索引的类型，B 树索引或散列索引。在CREATE INDEX
语句中，使用子句USING BTREEor
USING HASH。>B 树索引对于通过or等​​运算符进行大于或小于比较的查询来说速度很快BETWEEN。哈希索引仅对于通过运算符查找单个值=或通过运算符查找一组受限值的查询来说速度很快IN。对于为什么
USING BTREE通常是比默认更好的选择USING HASH，请参阅
第 8.2.1.23 节，“避免全表扫描”. 有关不同类型MEMORY索引的实现细节，请参阅
第 8.3.9 节，“B 树和哈希索引的比较”。
© Mysql 中文网
