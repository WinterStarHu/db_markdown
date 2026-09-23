# 13.7.1 账户管理报表_MySQL 8.0 参考手册

13.7.1 账户管理报表_MySQL 8.0 参考手册
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
13.1 数据定义语句
13.2 数据操作语句
13.3 事务和锁定语句
13.4 复制语句
13.5 准备好的语句
13.6 复合语句语法
13.7 数据库管理语句
13.7.1 账户管理报表1
13.7.1.1 ALTER USER 语句
13.7.1.2 CREATE ROLE 语句
13.7.1.3 创建用户语句
13.7.1.4 DROP ROLE 语句
13.7.1.5 DROP USER 语句
13.7.1.6 GRANT 语句
13.7.1.7 RENAME USER 语句
13.7.1.8 REVOKE 语句
13.7.1.9 SET DEFAULT ROLE 语句
13.7.1.10 设置密码语句
13.7.1.11 SET ROLE 语句
13.7.2 资源组管理语句1
13.7.3 表维护语句1
13.7.4 组件、插件和可加载函数语句1
13.7.5 CLONE 语句1
13.7.6 SET 语句1
13.7.7 显示语句1
13.7.8 其他行政报表1
13.8 效用语句
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
MySQL 8.0 参考手册  / 第 13 章 SQL 语句  / 13.7 数据库管理语句  /
13.7.1 账户管理报表
13.7.1 账户管理报表
13.7.1.1 ALTER USER 语句13.7.1.2 CREATE ROLE 语句13.7.1.3 创建用户语句13.7.1.4 DROP ROLE 语句13.7.1.5 DROP USER 语句13.7.1.6 GRANT 语句13.7.1.7 RENAME USER 语句13.7.1.8 REVOKE 语句13.7.1.9 SET DEFAULT ROLE 语句13.7.1.10 设置密码语句13.7.1.11 SET ROLE 语句
MySQL 帐户信息存储在
mysql系统模式的表中。该数据库和访问控制系统在第 5 章MySQL 服务器管理中进行了广泛讨论
，您应该查阅该章以获取更多详细信息。
重要的
一些 MySQL 版本引入了对授权表的更改以添加新的权限或功能。为确保您可以利用任何新功能，请在升级 MySQL 时将授权表更新为当前结构。请参阅
第 2.11 节，“升级 MySQL”。
read_only启用系统变量后，除了任何其他所需的权限外，帐户管理语句还需要
权限（CONNECTION_ADMIN或已弃用的权限）。SUPER这是因为它们修改了mysql系统模式中的表。
账户管理报表是原子的并且是崩溃安全的。有关详细信息，请参阅第 13.1.1 节，“原子数据定义语句支持”。
© Mysql 中文网
