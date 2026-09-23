# 27.20 性能模式的限制_MySQL 8.0 参考手册

27.20 性能模式的限制_MySQL 8.0 参考手册
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
第 27 章 MySQL 性能模式
27.1 性能模式快速入门
27.2 性能模式构建配置
27.3 性能模式启动配置
27.4 性能模式运行时配置
27.5 性能模式查询
27.6 性能模式工具命名约定
27.7 性能模式状态监控
27.8 性能模式原子和分子事件
27.9 当前和历史事件的性能模式表
27.10 性能模式语句摘要和采样
27.11 性能模式总表特征
27.12 性能模式表描述
27.13 性能模式选项和变量引用
27.14 性能模式命令选项
27.15 性能模式系统变量
27.16 性能模式状态变量
27.17性能模式内存分配模型
27.18 性能模式和插件
27.19 使用性能模式诊断问题
27.20 性能模式的限制
第 28 章 MySQL 系统模式
第 29 章连接器和 API
第30章MySQL企业版
第31章MySQL工作台
第 32 章 OCI 市场上的 MySQL
附录 A MySQL 8.0 常见问题解答
附录 B 错误信息和常见问题
附录 C 索引
MySQL 词汇表
MySQL 8.0 参考手册  / 第 27 章 MySQL 性能模式  /
27.20 性能模式的限制
27.20 性能模式的限制
Performance Schema 避免使用互斥锁来收集或生成数据，因此无法保证一致性，结果有时可能不正确。表中的事件值
performance_schema是不确定且不可重复的。
如果将事件信息保存在另一个表中，则不应假设原始事件以后仍然可用。例如，如果您从一个
performance_schema表中选择事件到一个临时表中，打算稍后将该表与原始表连接起来，则可能没有匹配项。
mysqldump并BACKUP
DATABASE忽略
performance_schema数据库中的表。
数据库中的表performance_schema不能用 锁定LOCK TABLES，表除外
。
setup_xxxperformance_schema无法为数据库中
的表编制索引。
数据库中的表performance_schema不会被复制。
计时器的类型可能因平台而异。该
performance_timers表显示了哪些事件计时器可用。如果此表中给定计时器名称的值为 ，NULL则您的平台不支持该计时器。
适用于存储引擎的工具可能不会为所有存储引擎实现。每个第三方引擎的检测是引擎维护者的责任。
© Mysql 中文网
