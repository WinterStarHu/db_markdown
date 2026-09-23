# 6.4.2 连接控制插件_MySQL 8.0 参考手册

6.4.2 连接控制插件_MySQL 8.0 参考手册
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
6.4.1 认证插件1
6.4.2 连接控制插件1
6.4.2.1 连接控制插件安装
6.4.2.2 连接控制系统和状态变量
6.4.3 密码验证组件1
6.4.4 MySQL 密钥环1
6.4.5 MySQL企业审计1
6.4.6 审计消息组件1
6.4.7 MySQL 企业防火墙1
6.5 MySQL 企业数据屏蔽和去标识化
6.6 MySQL企业加密
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
MySQL 8.0 参考手册  / 第 6 章 安全  / 6.4 安全组件和插件  /
6.4.2 连接控制插件
6.4.2 连接控制插件
6.4.2.1 连接控制插件安装6.4.2.2 连接控制系统和状态变量
MySQL Server 包含一个插件库，使管理员能够在可配置的连续失败尝试次数后增加服务器对连接尝试的响应延迟。此功能提供了一种威慑力，可以减缓针对 MySQL 用户帐户的暴力攻击。插件库包含两个插件：
CONNECTION_CONTROL检查传入的连接尝试并根据需要为服务器响应添加延迟。该插件还公开了允许配置其操作的系统变量和提供基本监控信息的状态变量。
该CONNECTION_CONTROL插件使用审计插件接口（请参阅
编写审计插件）。为了收集信息，它订阅
MYSQL_AUDIT_CONNECTION_CLASSMASK事件类、进程
MYSQL_AUDIT_CONNECTION_CONNECT和
MYSQL_AUDIT_CONNECTION_CHANGE_USER
子事件以检查服务器是否应该在响应连接尝试之前引入延迟。
CONNECTION_CONTROL_FAILED_LOGIN_ATTEMPTS
实现一个INFORMATION_SCHEMA表，该表公开有关失败连接尝试的更详细的监视信息。
以下部分提供有关连接控制插件安装和配置的信息。有关该
CONNECTION_CONTROL_FAILED_LOGIN_ATTEMPTS
表的信息，请参阅
第 26.6.2 节，“INFORMATION_SCHEMA CONNECTION_CONTROL_FAILED_LOGIN_ATTEMPTS 表”。
© Mysql 中文网
