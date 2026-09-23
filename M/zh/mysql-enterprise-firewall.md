# 30.6 MySQL 企业防火墙概述_MySQL 8.0 参考手册

30.6 MySQL 企业防火墙概述_MySQL 8.0 参考手册
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
30.1 MySQL Enterprise Monitor 概述
30.2 MySQL 企业备份概述
30.3 MySQL 企业安全概述
30.4 MySQL 企业加密概述
30.5 MySQL企业审计概述
30.6 MySQL 企业防火墙概述
30.7 MySQL企业线程池概述
30.8 MySQL 企业数据屏蔽和去标识化概述
第31章MySQL工作台
第 32 章 OCI 市场上的 MySQL
附录 A MySQL 8.0 常见问题解答
附录 B 错误信息和常见问题
附录 C 索引
MySQL 词汇表
MySQL 8.0 参考手册  / 第30章MySQL企业版  /
30.6 MySQL 企业防火墙概述
30.6 MySQL 企业防火墙概述
MySQL Enterprise Edition 包括 MySQL Enterprise Firewall，这是一种应用程序级防火墙，使数据库管理员能够根据与接受的语句模式的白名单进行匹配来允许或拒绝 SQL 语句的执行。这有助于加强 MySQL 服务器抵御 SQL 注入等攻击，或试图通过在合法查询工作负载特征之外使用它们来利用应用程序。
在防火墙上注册的每个 MySQL 帐户都有自己的语句白名单，从而可以为每个帐户量身定制保护。对于给定的帐户，防火墙可以在记录或保护模式下运行，以接受可接受的语句模式的培训或防止不可接受的语句。
有关详细信息，请参阅第 6.4.7 节，“MySQL 企业防火墙”。
© Mysql 中文网
