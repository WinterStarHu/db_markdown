# 6.4 安全组件和插件_MySQL 8.0 参考手册

6.4 安全组件和插件_MySQL 8.0 参考手册
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
MySQL 8.0 参考手册  / 第 6 章 安全  /
6.4 安全组件和插件
6.4 安全组件和插件
6.4.1 认证插件6.4.2 连接控制插件6.4.3 密码验证组件6.4.4 MySQL 密钥环6.4.5 MySQL企业审计6.4.6 审计消息组件6.4.7 MySQL 企业防火墙
MySQL 包括几个实现安全功能的组件和插件：
用于验证客户端连接到 MySQL 服务器的尝试的插件。插件可用于多种身份验证协议。有关身份验证过程的一般讨论，请参阅第 6.2.17 节，“可插入身份验证”。有关特定身份验证插件的特性，请参阅
第 6.4.1 节，“身份验证插件”。
用于实施密码强度策略和评估潜在密码强度的密码验证组件。请参阅第 6.4.3 节，“密码验证组件”。
为敏感信息提供安全存储的密钥环插件。请参阅第 6.4.4 节，“MySQL 密钥环”。
（仅限 MySQL 企业版）使用服务器插件实现的 MySQL Enterprise Audit 使用开放的 MySQL Audit API 来启用标准的、基于策略的监视和记录在特定 MySQL 服务器上执行的连接和查询活动。MySQL Enterprise Audit 旨在满足 Oracle 审计规范，为受内部和外部监管准则约束的应用程序提供开箱即用、易于使用的审计和合规性解决方案。请参阅第 6.4.5 节，“MySQL 企业审计”。
一个函数使应用程序能够将自己的消息事件添加到审计日志中。请参阅第 6.4.6 节，“审计消息组件”。
（仅限 MySQL 企业版）MySQL 企业防火墙，一种应用程序级防火墙，使数据库管理员能够根据与接受的语句模式列表的匹配来允许或拒绝 SQL 语句的执行。这有助于加强 MySQL 服务器抵御 SQL 注入等攻击，或试图通过在合法查询工作负载特征之外使用它们来利用应用程序。请参阅
第 6.4.7 节，“MySQL 企业防火墙”。
（仅限 MySQL Enterprise Edition）MySQL Enterprise Data Masking and De-Identification，作为包含插件和一组功能的插件库实现。数据屏蔽通过用替代值替换实际值来隐藏敏感信息。MySQL Enterprise Data Masking 和 De-Identification 功能可以使用多种方法来屏蔽现有数据，例如混淆（删除识别特征）、格式化随机数据的生成以及数据替换或替换。请参阅第 6.5 节，“MySQL 企业数据屏蔽和去标识化”。
© Mysql 中文网
