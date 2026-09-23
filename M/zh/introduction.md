# 第一章 一般信息_MySQL 8.0 参考手册

第一章 一般信息_MySQL 8.0 参考手册
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
1.1 关于本手册
1.2 MySQL数据库管理系统概述
1.3 MySQL 8.0 的新特性
1.4 MySQL 8.0 中添加、弃用或删除的服务器和状态变量和选项
1.5 MySQL信息源
1.6 如何报告错误或问题
1.7 MySQL 标准合规性
1.8 学分
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
第31章MySQL工作台
第 32 章 OCI 市场上的 MySQL
附录 A MySQL 8.0 常见问题解答
附录 B 错误信息和常见问题
附录 C 索引
MySQL 词汇表
MySQL 8.0 参考手册  /
第一章 一般信息
第一章 一般信息
目录1.1 关于本手册1.2 MySQL数据库管理系统概述1.2.1 什么是MySQL？1.2.2 MySQL的主要特点1.2.3 MySQL的历史1.3 MySQL 8.0 的新特性1.4 MySQL 8.0 中添加、弃用或删除的服务器和状态变量和选项1.5 MySQL信息源1.6 如何报告错误或问题1.7 MySQL 标准合规性1.7.1 MySQL 对标准 SQL 的扩展1.7.2 MySQL 与标准 SQL 的区别1.7.3 MySQL 如何处理约束1.8 学分1.8.1 MySQL 的贡献者1.8.2 记录员和翻译员1.8.3 支持MySQL的包1.8.4 用于创建MySQL的工具1.8.5 MySQL的支持者
MySQL 软件提供了一个非常快速、多线程、多用户和强大的 SQL（结构化查询语言）数据库服务器。MySQL Server 旨在用于关键任务、重负载生产系统以及嵌入到大规模部署的软件中。Oracle 是 Oracle Corporation 和/或其附属公司的注册商标。MySQL 是 Oracle Corporation 和/或其附属公司的商标，未经 Oracle 明确书面授权，客户不得使用。其他名称可能是其各自所有者的商标。
MySQL 软件是双重许可的。用户可以根据 GNU 通用公共许可证 ( http://www.fsf.org/licenses/ )的条款选择将 MySQL 软件作为开源产品使用，或者可以从 Oracle 购买标准的商业许可证。有关我们的许可政策的更多信息，请参阅
http://www.mysql.com/company/legal/licensing/。
以下列表描述了本手册中一些特别重要的部分：
有关 MySQL 数据库服务器功能的讨论，请参阅
第 1.2.2 节，“MySQL 的主要功能”。
有关新 MySQL 功能的概述，请参阅
第 1.3 节，“MySQL 8.0 中的新功能”。有关每个版本中更改的信息，请参阅
发行说明。
有关安装说明，请参阅第 2 章，安装和升级 MySQL。有关升级 MySQL 的信息，请参阅
第 2.11 节，“升级 MySQL”。
有关 MySQL 数据库服务器的教程介绍，请参阅
第 3 章教程。
有关配置和管理 MySQL 服务器的信息，请参阅第 5 章，MySQL 服务器管理。
有关 MySQL 中安全性的信息，请参阅
第 6 章，安全性。
有关设置复制服务器的信息，请参阅
第 17 章，复制。
有关 MySQL Enterprise（具有高级功能和管理工具的商业 MySQL 版本）的信息，请参阅
第 30 章，MySQL Enterprise Edition。
有关 MySQL 数据库服务器及其功能的一些常见问题的答案，请参阅
附录 A，MySQL 8.0 常见问题解答。
有关新功能和错误修复的历史记录，请参阅
发行说明。
重要的
要报告问题或错误，请使用
第 1.6 节“如何报告错误或问题”中的说明。如果您在 MySQL 服务器中发现安全漏洞，请立即发送电子邮件至 告知我们。例外：支持客户应向 Oracle 支持报告所有问题，包括安全漏洞。
<secalert_us@oracle.com>
© Mysql 中文网
