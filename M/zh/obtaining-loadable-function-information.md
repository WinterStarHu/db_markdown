# 5.7.2 获取有关可加载函数的信息_MySQL 8.0 参考手册

5.7.2 获取有关可加载函数的信息_MySQL 8.0 参考手册
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
5.7.1 安装和卸载可加载函数1
5.7.2 获取有关可加载函数的信息1
5.8 在一台机器上运行多个MySQL实例
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
MySQL 8.0 参考手册  / 第 5 章 MySQL 服务器管理  / 5.7 MySQL 服务器可加载函数  /
5.7.2 获取有关可加载函数的信息
5.7.2 获取有关可加载函数的信息
Performance Schema
user_defined_functions表包含有关当前安装的可加载功能的信息：
SELECT * FROM performance_schema.user_defined_functions;mysql.func系统表还列出了已安装的可加载函数，但仅列出
使用CREATE
FUNCTION. 该
user_defined_functions表列出了使用安装
CREATE
FUNCTION的可加载函数以及组件或插件自动安装的可加载函数。这种差异
user_defined_functions比
mysql.func检查安装了哪些可加载功能更可取。请参阅
第 27.12.21.9 节，“user_defined_functions 表”。
© Mysql 中文网
