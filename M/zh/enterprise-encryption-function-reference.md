# 6.6.4 MySQL企业加密函数参考_MySQL 8.0 参考手册

6.6.4 MySQL企业加密函数参考_MySQL 8.0 参考手册
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
6.1 一般安全问题
6.2 访问控制和账户管理
6.3 使用加密连接
6.4 安全组件和插件
6.5 MySQL 企业数据屏蔽和去标识化
6.6 MySQL企业加密
6.6.1 MySQL企业加密安装升级1
6.6.2 配置MySQL企业加密1
6.6.3 MySQL 企业加密使用和示例1
6.6.4 MySQL企业加密函数参考1
6.6.5 MySQL企业加密组件功能说明1
6.6.6 MySQL企业加密遗留功能说明1
6.7 SELinux
6.8 FIPS 支持
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
MySQL 8.0 参考手册  / 第 6 章 安全  / 6.6 MySQL企业加密  /
6.6.4 MySQL企业加密函数参考
6.6.4 MySQL企业加密函数参考
在 MySQL 8.0.30 版本中，MySQL Enterprise Encryption 的功能由 MySQL 组件提供
component_enterprise_encryption。有关它们的描述，请参阅
第 6.6.5 节，“MySQL 企业加密组件功能描述”。
在 MySQL 8.0.30 之前的版本中，MySQL Enterprise Encryption 的功能基于openssl_udf共享库。如果已安装这些功能，它们将在以后的版本中继续可用，但已弃用。有关它们的描述，请参阅第 6.6.6 节，“MySQL Enterprise Encryption Legacy Function Descriptions”。
有关升级到 MySQL 组件提供的新组件功能的信息
component_enterprise_encryption，以及遗留功能和组件功能之间的行为差​​异列表，请参阅
升级 MySQL Enterprise Encryption。
© Mysql 中文网
