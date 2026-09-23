# 第 28 章 MySQL 系统模式_MySQL 8.0 参考手册

第 28 章 MySQL 系统模式_MySQL 8.0 参考手册
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
第 28 章 MySQL 系统模式
28.1 使用 sys 模式的先决条件
28.2 使用系统模式
28.3 sys Schema 进度报告
28.4 sys 模式对象参考
第 29 章连接器和 API
第30章MySQL企业版
第31章MySQL工作台
第 32 章 OCI 市场上的 MySQL
附录 A MySQL 8.0 常见问题解答
附录 B 错误信息和常见问题
附录 C 索引
MySQL 词汇表
MySQL 8.0 参考手册  /
第 28 章 MySQL 系统模式
第 28 章 MySQL 系统模式
目录28.1 使用 sys 模式的先决条件28.2 使用系统模式28.3 sys Schema 进度报告28.4 sys 模式对象参考28.4.1 sys 架构对象索引28.4.2 sys 模式表和触发器28.4.3 sys 架构视图28.4.4 sys 模式存储过程28.4.5 sys 模式存储函数
MySQL 8.0 包含
sys架构，一组对象可帮助 DBA 和开发人员解释性能架构收集的数据。sys模式对象可用于典型的调优和诊断用例。此架构中的对象包括：
将 Performance Schema 数据汇总为更易于理解的形式的视图。
执行性能模式配置和生成诊断报告等操作的存储过程。
查询 Performance Schema 配置并提供格式化服务的存储函数。
对于新安装，sys如果将mysqld与
--initialize或
--initialize-insecure选项一起使用，则在数据目录初始化期间默认安装架构。如果不需要，您可以sys
在初始化后手动删除不需要的模式。
sys如果模式存在但没有
视图，
则 MySQL 升级过程会产生错误
version，假设该视图的缺失表示用户创建的sys
模式。要在这种情况下升级，请先删除或重命名现有
sys架构。
sys模式对象有
一个DEFINER。
'mysql.sys'@'localhost'使用专用
mysql.sys帐户可以避免在 DBA 重命名或删除root帐户时发生的问题。
© Mysql 中文网
