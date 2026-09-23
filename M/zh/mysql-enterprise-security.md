# 30.3 MySQL 企业安全概述_MySQL 8.0 参考手册

30.3 MySQL 企业安全概述_MySQL 8.0 参考手册
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
30.3 MySQL 企业安全概述
30.3 MySQL 企业安全概述
MySQL 企业版提供了使用外部服务实现安全功能的插件：
MySQL 企业版包含一个身份验证插件，使 MySQL 服务器能够使用 LDAP（轻量级目录访问协议）对 MySQL 用户进行身份验证。LDAP 身份验证支持 LDAP 服务的用户名和密码、SASL 和 GSSAPI/Kerberos 身份验证方法。有关详细信息，请参阅
第 6.4.1.7 节，“LDAP 可插入身份验证”。
MySQL Enterprise Edition 包含一个身份验证插件，使 MySQL Server 能够使用 Native Kerberos 来使用 Kerberos Principals 对 MySQL 用户进行身份验证。有关详细信息，请参阅
第 6.4.1.8 节，“Kerberos 可插入身份验证”。
MySQL 企业版包含一个身份验证插件，使 MySQL 服务器能够使用 PAM（可插入身份验证模块）对 MySQL 用户进行身份验证。PAM 使系统能够使用标准接口访问各种身份验证方法，例如 Unix 密码或 LDAP 目录。有关详细信息，请参阅
第 6.4.1.5 节，“PAM 可插入身份验证”。
MySQL 企业版包括一个在 Windows 上执行外部身份验证的身份验证插件，使 MySQL Server 能够使用本机 Windows 服务来验证客户端连接。登录到Windows的用户可以根据他们环境中的信息从MySQL客户端程序连接到服务器，而无需指定额外的密码。有关详细信息，请参阅
第 6.4.1.6 节，“Windows 可插入身份验证”。
MySQL Enterprise Edition 包括一套屏蔽和去标识化功能，可执行子集化、随机生成和字典替换以去标识化字符串、数字、电话号码、电子邮件等。这些功能可以使用多种方法来屏蔽现有数据，例如混淆（删除识别特征）、格式化随机数据的生成以及数据替换或替代。有关详细信息，请参阅
第 6.5.3 节，“使用 MySQL 企业数据屏蔽和去标识化”。
MySQL 企业版包括一组基于 OpenSSL 库的加密函数，这些函数在 SQL 级别公开 OpenSSL 功能。有关详细信息，请参阅
第 30.4 节，“MySQL 企业加密概述”。
MySQL 企业版 5.7 及更高版本包含一个密钥环插件，该插件使用 Oracle Key Vault 作为密钥环存储的后端。有关详细信息，请参阅第 6.4.4 节，“MySQL 密钥环”。
MySQL 透明数据加密 (TDE) 为 MySQL 服务器为可能包含敏感数据的所有文件提供静态加密。有关详细信息，请参阅
第 15.13 节，“InnoDB 静态数据加密”，
第 17.3.2 节，“加密二进制日志文件和中继日志文件”，以及
加密审计日志文件。
对于其他相关的企业安全功能，请参阅
第 30.4 节，“MySQL 企业加密概述”。
© Mysql 中文网
