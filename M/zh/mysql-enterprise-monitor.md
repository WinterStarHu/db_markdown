# 30.1 MySQL Enterprise Monitor 概述_MySQL 8.0 参考手册

30.1 MySQL Enterprise Monitor 概述_MySQL 8.0 参考手册
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
30.1 MySQL Enterprise Monitor 概述
30.1 MySQL Enterprise Monitor 概述
MySQL Enterprise Monitor 是 MySQL 的企业监控系统，它会密切关注您的 MySQL 服务器，通知您潜在的问题和问题，并建议您如何解决这些问题。MySQL Enterprise Monitor 可以监控各种配置，从对您的业务很重要的单个 MySQL 服务器，一直到为繁忙网站提供支持的大型 MySQL 服务器群。
以下讨论简要总结了构成 MySQL Enterprise Monitor 产品的基本组件。有关详细信息，请参阅 MySQL Enterprise Monitor 手册，网址为
https://mysql.net.cn/doc/mysql-monitor/en/。
MySQL Enterprise Monitor 组件可以安装在各种配置中，具体取决于您的数据库和网络拓扑，为您提供可靠且响应迅速的监控数据的最佳组合，同时将数据库服务器机器的开销降至最低。典型的 MySQL Enterprise Monitor 安装包括：
要监控的一台或多台 MySQL 服务器。MySQL Enterprise Monitor 可以监控社区和企业 MySQL 服务器版本。
每个受监控主机的 MySQL Enterprise Monitor Agent。
单个 MySQL 企业服务管理器，它整理来自代理的信息并为收集的数据提供用户界面。
MySQL Enterprise Monitor 旨在监控一台或多台 MySQL 服务器。监控信息是使用代理
MySQL Enterprise Monitor Agent收集的。代理与其监控的主机和 MySQL 服务器通信，收集变量、状态和健康信息，并将这些信息发送到 MySQL 企业服务管理器。
代理收集的有关您正在监视的每个 MySQL 服务器和主机的信息被发送到
MySQL Enterprise Service Manager。该服务器整理来自代理的所有信息。在整理代理发送的信息时，MySQL 企业服务管理器不断测试收集的数据，将服务器的状态与合理的值进行比较。当达到阈值时，服务器可以触发事件（包括警报和通知）以突出显示潜在问题，例如内存不足、CPU 使用率高或缓冲区大小和状态信息不足等更复杂的情况。我们将每个测试及其关联的阈值称为规则。
这些规则以及警报和通知均称为
MySQL Enterprise Advisors。顾问构成了 MySQL Enterprise Service Manager 的关键部分，因为它们提供有关潜在问题的警告信息和故障排除建议。
MySQL Enterprise Service Manager 包括一个 Web 服务器，您可以通过任何 Web 浏览器与它交互。这个界面，即 MySQL Enterprise Monitor 用户界面，显示了代理收集的所有信息，并允许您作为一个组或单独查看所有服务器及其当前状态。您可以使用 MySQL Enterprise Monitor 用户界面控制和配置服务的所有方面。
MySQL Enterprise Monitor Agent 进程提供的信息还包括统计信息和查询信息，您可以以图形的形式查看这些信息。例如，您可以将服务器负载、查询数量或索引使用信息等方面视为随时间变化的图表。该图可让您查明服务器上的问题或潜在问题，并可通过检查特定时间间隔内的数据来帮助诊断数据库或外部问题（例如外部系统或网络故障）的影响。
MySQL Enterprise Monitor Agent 还可以配置为收集有关在您的服务器上执行的查询的详细信息，包括执行每个查询的行数和执行时间。您可以将详细的查询数据与图形信息相关联，以确定在您遇到特别高的负载、索引或其他问题时正在执行哪些查询。查询数据由一个称为查询分析器的系统提供支持，并且可以根据您的需要以不同的方式呈现数据。
© Mysql 中文网
