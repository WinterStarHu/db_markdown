# 20.4.2 下载导入world_x数据库_MySQL 8.0 参考手册

20.4.2 下载导入world_x数据库_MySQL 8.0 参考手册
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
20.1 MySQL文档存储的接口
20.2 文档存储概念
20.3 JavaScript 快速入门指南：用于文档存储的 MySQL Shell
20.4 Python 快速入门指南：用于文档存储的 MySQL Shell
20.4.1 MySQL 外壳1
20.4.2 下载导入world_x数据库1
20.4.3 文件和收藏1
20.4.4 关系表1
20.4.5 表格中的文件1
20.5 X 插件
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
MySQL 8.0 参考手册  / 第 20 章使用 MySQL 作为文档存储  / 20.4 Python 快速入门指南：用于文档存储的 MySQL Shell  /
20.4.2 下载导入world_x数据库
20.4.2 下载导入world_x数据库
作为本快速入门指南的一部分，提供了一个示例模式，称为world_x模式。许多示例演示了使用此架构的文档存储功能。启动 MySQL 服务器以便加载world_x模式，然后执行以下步骤：
下载
world_x-db.zip。
将安装存档提取到一个临时位置，例如/tmp/. 解压归档文件会生成一个名为world_x.sql.
将文件导入world_x.sql您的服务器。您可以：
以 SQL 模式启动 MySQL Shell 并通过发出以下命令导入文件：
mysqlsh -u root --sql --file /tmp/world_x-db/world_x.sql
Enter password: ****
在运行时将 MySQL Shell 设置为 SQL 模式，并通过发出以下命令获取模式文件：
\sql
Switching to SQL mode... Commands end with ;
\source /tmp/world_x-db/world_x.sql
替换为系统上文件/tmp/的路径
。world_x.sql如果有提示，请输入密码。只要帐户具有创建新模式的权限，就可以使用非根帐户。
world_x 模式
world_x示例架构包含以下 JSON 集合和关系表
：
收藏
countryinfo：有关世界各国的信息。
表
country：关于世界各国的最少信息。
city: 有关这些国家的一些城市的信息。
countrylanguage: 每个国家使用的语言。
相关信息
MySQL Shell Sessions解释了会话类型。
© Mysql 中文网
