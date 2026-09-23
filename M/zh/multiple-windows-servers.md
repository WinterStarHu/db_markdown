# 5.8.2 在 Windows 上运行多个 MySQL 实例_MySQL 8.0 参考手册

5.8.2 在 Windows 上运行多个 MySQL 实例_MySQL 8.0 参考手册
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
5.1 MySQL 服务器
5.2 MySQL数据目录
5.3 mysql系统架构
5.4 MySQL 服务器日志
5.5 MySQL组件
5.6 MySQL 服务器插件
5.7 MySQL 服务器可加载函数
5.8 在一台机器上运行多个MySQL实例
5.8.1 设置多个数据目录1
5.8.2 在 Windows 上运行多个 MySQL 实例1
5.8.2.1 Windows命令行启动多个MySQL实例
5.8.2.2 启动多个MySQL实例为Windows服务
5.8.3 在 Unix 上运行多个 MySQL 实例1
5.8.4 在多服务器环境中使用客户端程序1
5.9 调试 MySQL
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
MySQL 8.0 参考手册  / 第 5 章 MySQL 服务器管理  / 5.8 在一台机器上运行多个MySQL实例  /
5.8.2 在 Windows 上运行多个 MySQL 实例
5.8.2 在 Windows 上运行多个 MySQL 实例
5.8.2.1 Windows命令行启动多个MySQL实例5.8.2.2 启动多个MySQL实例为Windows服务
您可以在 Windows 上运行多个服务器，方法是从命令行手动启动它们，每个服务器都具有适当的操作参数，或者通过将多个服务器安装为 Windows 服务并以这种方式运行它们。从命令行或作为服务运行 MySQL 的一般说明在
第 2.3 节“在 Microsoft Windows 上安装 MySQL”中给出。以下部分描述了如何使用不同的值来启动每个服务器，这些选项对于每个服务器必须是唯一的，例如数据目录。这些选项在第 5.8 节“在一台机器上运行多个 MySQL 实例”中列出
。
© Mysql 中文网
