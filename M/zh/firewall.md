# 6.4.7 MySQL 企业防火墙_MySQL 8.0 参考手册

6.4.7 MySQL 企业防火墙_MySQL 8.0 参考手册
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
6.4.7.1 MySQL 企业防火墙的元素
6.4.7.2 安装或卸载 MySQL 企业防火墙
6.4.7.3 使用 MySQL 企业防火墙
6.4.7.4 MySQL 企业防火墙参考
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
6.4.7 MySQL 企业防火墙
6.4.7 MySQL 企业防火墙
6.4.7.1 MySQL 企业防火墙的元素6.4.7.2 安装或卸载 MySQL 企业防火墙6.4.7.3 使用 MySQL 企业防火墙6.4.7.4 MySQL 企业防火墙参考
笔记
MySQL Enterprise Firewall 是商业产品 MySQL Enterprise Edition 中包含的扩展。要了解有关商业产品的更多信息，请参阅
https://www.mysql.com/products/。
MySQL Enterprise Edition 包括 MySQL Enterprise Firewall，这是一种应用程序级防火墙，使数据库管理员能够根据与接受的语句模式列表的匹配来允许或拒绝 SQL 语句的执行。这有助于加强 MySQL 服务器抵御 SQL 注入等攻击，或试图通过在合法查询工作负载特征之外使用它们来利用应用程序。
在防火墙上注册的每个 MySQL 帐户都有自己的语句白名单，从而可以为每个帐户量身定制保护。对于给定的帐户，防火墙可以在记录、保护或检测模式下运行，以接受的语句模式进行训练，主动防御不可接受的语句，或被动检测不可接受的语句。该图说明了防火墙如何在每种模式下处理传入的语句。
图 6.1 MySQL 企业防火墙运行
以下各节介绍 MySQL Enterprise Firewall 的元素，讨论如何安装和使用它，并提供其元素的参考信息。
© Mysql 中文网
