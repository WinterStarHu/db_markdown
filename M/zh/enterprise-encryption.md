# 6.6 MySQL企业加密_MySQL 8.0 参考手册

6.6 MySQL企业加密_MySQL 8.0 参考手册
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
MySQL 8.0 参考手册  / 第 6 章 安全  /
6.6 MySQL企业加密
6.6 MySQL企业加密
6.6.1 MySQL企业加密安装升级6.6.2 配置MySQL企业加密6.6.3 MySQL 企业加密使用和示例6.6.4 MySQL企业加密函数参考6.6.5 MySQL企业加密组件功能说明6.6.6 MySQL企业加密遗留功能说明
笔记
MySQL Enterprise Encryption 是商业产品 MySQL Enterprise Edition 中包含的扩展。要了解有关商业产品的更多信息，
请访问 https://www.mysql.com/products/。
MySQL Enterprise Edition 包含一组加密功能，可在 SQL 级别公开 OpenSSL 功能。这些函数使企业应用程序能够执行以下操作：
使用公钥非对称加密实现额外的数据保护
创建公钥和私钥以及数字签名
执行非对称加密和解密
使用加密哈希进行数字签名以及数据验证和确认
在 MySQL 8.0.30 之前的版本中，这些函数基于
openssl_udf共享库。从 MySQL 8.0.30 开始，它们由 MySQL 组件提供
component_enterprise_encryption。
© Mysql 中文网
