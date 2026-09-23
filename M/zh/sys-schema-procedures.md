# 28.4.4 sys 模式存储过程_MySQL 8.0 参考手册

28.4.4 sys 模式存储过程_MySQL 8.0 参考手册
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
28.4.1 sys 架构对象索引1
28.4.2 sys 模式表和触发器1
28.4.3 sys 架构视图1
28.4.4 sys 模式存储过程1
28.4.4.1 create_synonym_db() 过程
28.4.4.2 diagnostics() 过程
28.4.4.3 execute_prepared_stmt() 过程
28.4.4.4 ps_setup_disable_background_threads() 过程
28.4.4.5 ps_setup_disable_consumer() 过程
28.4.4.6 ps_setup_disable_instrument() 过程
28.4.4.7 ps_setup_disable_thread() 过程
28.4.4.8 ps_setup_enable_background_threads() 过程
28.4.4.9 ps_setup_enable_consumer() 过程
28.4.4.10 ps_setup_enable_instrument() 过程
28.4.4.11 ps_setup_enable_thread() 过程
28.4.4.12 ps_setup_reload_saved() 过程
28.4.4.13 ps_setup_reset_to_default() 过程
28.4.4.14 ps_setup_save() 过程
28.4.4.15 ps_setup_show_disabled() 过程
28.4.4.16 ps_setup_show_disabled_consumers() 过程
28.4.4.17 ps_setup_show_disabled_instruments() 过程
28.4.4.18 ps_setup_show_enabled() 过程
28.4.4.19 ps_setup_show_enabled_consumers() 过程
28.4.4.20 ps_setup_show_enabled_instruments() 过程
28.4.4.21 ps_statement_avg_latency_histogram() 过程
28.4.4.22 ps_trace_statement_digest() 过程
28.4.4.23 ps_trace_thread() 过程
28.4.4.24 ps_truncate_all_tables() 过程
28.4.4.25 statement_performance_analyzer() 过程
28.4.4.26 table_exists() 过程
28.4.5 sys 模式存储函数1
第 29 章连接器和 API
第30章MySQL企业版
第31章MySQL工作台
第 32 章 OCI 市场上的 MySQL
附录 A MySQL 8.0 常见问题解答
附录 B 错误信息和常见问题
附录 C 索引
MySQL 词汇表
MySQL 8.0 参考手册  / 第 28 章 MySQL 系统模式  / 28.4 sys 模式对象参考  /
28.4.4 sys 模式存储过程
28.4.4 sys 模式存储过程
28.4.4.1 create_synonym_db() 过程28.4.4.2 diagnostics() 过程28.4.4.3 execute_prepared_stmt() 过程28.4.4.4 ps_setup_disable_background_threads() 过程28.4.4.5 ps_setup_disable_consumer() 过程28.4.4.6 ps_setup_disable_instrument() 过程28.4.4.7 ps_setup_disable_thread() 过程28.4.4.8 ps_setup_enable_background_threads() 过程28.4.4.9 ps_setup_enable_consumer() 过程28.4.4.10 ps_setup_enable_instrument() 过程28.4.4.11 ps_setup_enable_thread() 过程28.4.4.12 ps_setup_reload_saved() 过程28.4.4.13 ps_setup_reset_to_default() 过程28.4.4.14 ps_setup_save() 过程28.4.4.15 ps_setup_show_disabled() 过程28.4.4.16 ps_setup_show_disabled_consumers() 过程28.4.4.17 ps_setup_show_disabled_instruments() 过程28.4.4.18 ps_setup_show_enabled() 过程28.4.4.19 ps_setup_show_enabled_consumers() 过程28.4.4.20 ps_setup_show_enabled_instruments() 过程28.4.4.21 ps_statement_avg_latency_histogram() 过程28.4.4.22 ps_trace_statement_digest() 过程28.4.4.23 ps_trace_thread() 过程28.4.4.24 ps_truncate_all_tables() 过程28.4.4.25 statement_performance_analyzer() 过程28.4.4.26 table_exists() 过程
以下部分描述了
sys架构存储过程。
© Mysql 中文网
