# 14.8 数据字典限制_MySQL 8.0 参考手册

14.8 数据字典限制_MySQL 8.0 参考手册
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
14.1 数据字典模式
14.2 删除基于文件的元数据存储
14.3 字典数据的事务存储
14.4 字典对象缓存
14.5 INFORMATION_SCHEMA 与数据字典集成
14.6 序列化词典信息（SDI）
14.7 数据字典使用差异
14.8 数据字典限制
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
MySQL 8.0 参考手册  / 第14章MySQL数据字典  /
14.8 数据字典限制
14.8 数据字典限制
本节介绍 MySQL 数据字典引入的临时限制。
不支持在数据目录下手动创建数据库目录（例如，使用mkdir）。MySQL 服务器无法识别手动创建的数据库目录。
由于写入存储、撤消日志和重做日志而不是.frm
文件，DDL 操作需要更长的时间。
© Mysql 中文网
