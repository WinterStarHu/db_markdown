# 18.1.3 多主模式和单主模式_MySQL 8.0 参考手册

18.1.3 多主模式和单主模式_MySQL 8.0 参考手册
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
18.1 组复制背景
18.1.1 复制技术1
18.1.2 组复制用例1
18.1.3 多主模式和单主模式1
18.1.3.1 单主模式
18.1.3.2 多主模式
18.1.4 组复制服务1
18.1.5 组复制插件架构1
18.2 开始
18.3 要求和限制
18.4 监控组复制
18.5 组复制操作
18.6 组复制安全
18.7 组复制性能和故障排除
18.8 升级组复制
18.9 组复制系统变量
18.10 常见问题
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
MySQL 8.0 参考手册  / 第十八章 组复制  / 18.1 组复制背景  /
18.1.3 多主模式和单主模式
18.1.3 多主模式和单主模式
18.1.3.1 单主模式18.1.3.2 多主模式
组复制在单主模式或多主模式下运行。组的模式是组范围内的配置设置，由
group_replication_single_primary_mode
系统变量指定，所有成员必须相同。
ON表示单主模式，这是默认模式，OFF表示多主模式。不可能以不同模式部署组的成员，例如，一个成员配置为多主模式，而另一个成员配置为单主模式。
group_replication_single_primary_mode
当组复制运行时
，您不能手动更改值
。从 MySQL 8.0.13 开始，您可以使用
group_replication_switch_to_single_primary_mode()
和
group_replication_switch_to_multi_primary_mode()
函数将组从一种模式移动到另一种模式，同时组复制仍在运行。这些功能管理更改组模式的过程，并确保您的数据的安全性和一致性。在早期版本中，要更改组的模式，您必须停止组复制并更改
group_replication_single_primary_mode
所有成员的值。然后执行组的完全重启（由服务器引导
group_replication_bootstrap_group=ON）以实现对新操作配置的更改。您不需要重新启动服务器。
无论部署模式如何，Group Replication 都不会处理客户端故障转移。这必须由中间件框架（例如MySQL Router 8.0）、代理、连接器或应用程序本身来处理。
© Mysql 中文网
