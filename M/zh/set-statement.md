# 13.7.6 SET 语句_MySQL 8.0 参考手册

13.7.6 SET 语句_MySQL 8.0 参考手册
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
13.7.2 资源组管理语句1
13.7.3 表维护语句1
13.7.4 组件、插件和可加载函数语句1
13.7.5 CLONE 语句1
13.7.6 SET 语句1
13.7.6.1 变量赋值的 SET 语法
13.7.6.2 SET CHARACTER SET 语句
13.7.6.3 SET NAMES 语句
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
13.7.6 SET 语句
13.7.6 SET 语句
13.7.6.1 变量赋值的 SET 语法13.7.6.2 SET CHARACTER SET 语句13.7.6.3 SET NAMES 语句
该SET
声明有多种形式。与特定服务器功能无关的那些表单的说明出现在本节的小节中：
SET
var_name =
value使您能够为影响服务器或客户端操作的变量赋值。请参阅第 13.7.6.1 节，“变量赋值的 SET 语法”。
SET CHARACTER SET并
SET NAMES为与服务器的当前连接关联的字符集和排序规则变量赋值。请参阅
第 13.7.6.2 节，“SET CHARACTER SET 语句”和
第 13.7.6.3 节，“SET NAMES 语句”。
其他形式的描述出现在其他地方，与其他与其帮助实现的功能相关的陈述分组：
SET DEFAULT ROLE并
SET ROLE为用户帐户设置默认角色和当前角色。请参阅
第 13.7.1.9 节，“SET DEFAULT ROLE 语句”和
第 13.7.1.11 节，“SET ROLE 语句”。
SET PASSWORD分配帐户密码。请参阅第 13.7.1.10 节，“SET PASSWORD 语句”。
SET RESOURCE GROUP将线程分配给资源组。请参阅第 13.7.2.4 节，“SET RESOURCE GROUP 语句”。
SET
TRANSACTION ISOLATION LEVEL设置事务处理的隔离级别。请参阅
第 13.3.7 节，“SET TRANSACTION 语句”。
© Mysql 中文网
