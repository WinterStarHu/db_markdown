# 30.2 MySQL 企业备份概述_MySQL 8.0 参考手册

30.2 MySQL 企业备份概述_MySQL 8.0 参考手册
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
30.2 MySQL 企业备份概述
30.2 MySQL 企业备份概述
MySQL Enterprise Backup 对 MySQL 数据库执行热备份操作。该产品的架构旨在高效可靠地备份由 InnoDB 存储引擎创建的表。为了完整起见，它还可以备份来自 MyISAM 和其他存储引擎的表。
以下讨论简要总结了 MySQL Enterprise Backup。有关详细信息，请参阅 MySQL Enterprise Backup 手册，网址为
https://mysql.net.cn/doc/mysql-enterprise-backup/en/。
热备份是在数据库运行且应用程序正在读取和写入数据库时​​执行的。这种类型的备份不会阻止正常的数据库操作，它甚至可以捕获备份过程中发生的更改。由于这些原因，当您的数据库“长大”时，热备份是可取的——当数据大到备份需要花费大量时间时，当您的数据对您的业务非常重要时，您必须捕获每一个最后的更改，而无需采取您的应用程序、网站或 Web 服务离线。
MySQL Enterprise Backup 对使用 InnoDB 存储引擎的所有表进行热备份。对于使用 MyISAM 或其他非 InnoDB 存储引擎的表，它会进行“热”备份，数据库继续运行，但这些表在备份时无法修改。为了高效的备份操作，您可以将 InnoDB 指定为新表的默认存储引擎，或者将现有表转换为使用 InnoDB 存储引擎。
© Mysql 中文网
