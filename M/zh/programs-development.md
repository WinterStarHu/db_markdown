# 4.7 程序开发实用程序_MySQL 8.0 参考手册

4.7 程序开发实用程序_MySQL 8.0 参考手册
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
4.1 MySQL程序概述
4.2 使用 MySQL 程序
4.3 服务器和服务器启动程序
4.4 安装相关程序
4.5 客户端程序
4.6 管理和实用程序
4.7 程序开发实用程序
4.7.1 mysql_config——编译客户端的显示选项1
4.7.2 my_print_defaults — 显示选项文件中的选项1
4.8 杂项程序
4.9 环境变量
4.10 MySQL 中的 Unix 信号处理
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
第 29 章连接器和 API
第30章MySQL企业版
第31章MySQL工作台
第 32 章 OCI 市场上的 MySQL
附录 A MySQL 8.0 常见问题解答
附录 B 错误信息和常见问题
附录 C 索引
MySQL 词汇表
MySQL 8.0 参考手册  / 第 4 章 MySQL 程序  /
4.7 程序开发实用程序
4.7 程序开发实用程序
4.7.1 mysql_config——编译客户端的显示选项4.7.2 my_print_defaults — 显示选项文件中的选项
本节描述了一些实用程序，您可能会发现它们在开发 MySQL 程序时很有用。
在 shell 脚本中，您可以使用
my_print_defaults程序来解析选项文件并查看给定程序将使用哪些选项。以下示例显示了
当要求显示在
和组
中找到的选项时my_print_defaults可能产生的输出：[client][mysql]$> my_print_defaults client mysql
--port=3306
--socket=/tmp/mysql.sock
--no-auto-rehash
开发人员注意事项：选项文件处理在 C 客户端库中实现，只需在任何命令行参数之前处理适当组中的所有选项即可。这适用于使用多次指定的选项的最后一个实例的程序。如果您有一个 C 或 C++ 程序以这种方式处理多个指定的选项但不读取选项文件，则您只需添加两行即可为其提供该功能。检查任何标准 MySQL 客户端的源代码以了解如何执行此操作。
其他几种 MySQL 语言接口基于 C 客户端库，其中一些提供了一种访问选项文件内容的方法。这些包括 Perl 和 Python。有关详细信息，请参阅您的首选界面的文档。
© Mysql 中文网
