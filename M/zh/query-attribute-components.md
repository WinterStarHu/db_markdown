# 5.5.4 查询属性组件_MySQL 8.0 参考手册

5.5.4 查询属性组件_MySQL 8.0 参考手册
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
5.5.1 安装和卸载组件1
5.5.2 获取组件信息1
5.5.3 错误日志组件1
5.5.4 查询属性组件1
5.6 MySQL 服务器插件
5.7 MySQL 服务器可加载函数
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
MySQL 8.0 参考手册  / 第 5 章 MySQL 服务器管理  / 5.5 MySQL组件  /
5.5.4 查询属性组件
5.5.4 查询属性组件
从 MySQL 8.0.23 开始，组件服务提供对查询属性的访问（请参阅第 9.6 节，“查询属性”）。该
query_attributes组件使用此服务提供对 SQL 语句中查询属性的访问。
目的：实现
mysql_query_attribute_string()
接受属性名称参数并以字符串形式返回属性值或NULL属性不存在时返回的函数。
瓮：file://component_query_attributes
希望合并所使用的相同查询属性组件服务的开发人员query_attributes
应该查阅mysql_query_attributes.h
MySQL 源代码分发中的文件。
© Mysql 中文网
