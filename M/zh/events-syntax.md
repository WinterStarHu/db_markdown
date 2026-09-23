# 25.4.3 事件语法_MySQL 8.0 参考手册

25.4.3 事件语法_MySQL 8.0 参考手册
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
25.1 定义存储程序
25.2 使用存储例程
25.3 使用触发器
25.4 使用事件调度器
25.4.1 事件调度器概述1
25.4.2 事件调度器配置1
25.4.3 事件语法1
25.4.4 事件元数据1
25.4.5 事件调度程序状态1
25.4.6 事件调度器和 MySQL 权限1
25.5 使用视图
25.6 存储对象访问控制
25.7 存储程序二进制日志记录
25.8 存储程序的限制
25.9 视图限制
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
MySQL 8.0 参考手册  / 第25章存储对象  / 25.4 使用事件调度器  /
25.4.3 事件语法
25.4.3 事件语法
MySQL 提供了几个用于处理计划事件的 SQL 语句：
CREATE
EVENT使用该语句
定义新事件。请参阅第 13.1.13 节，“CREATE EVENT 语句”。
可以通过ALTER EVENT语句更改现有事件的定义。请参阅
第 13.1.3 节，“ALTER EVENT 语句”。
当不再需要或不需要计划的事件时，它的定义者可以使用
DROP EVENT语句从服务器中删除它。请参阅
第 13.1.25 节，“DROP EVENT 语句”。一个事件是否持续到它的时间表结束还取决于它的ON
COMPLETION条款，如果它有的话。请参阅
第 13.1.13 节，“CREATE EVENT 语句”。
EVENT任何对定义事件的数据库
具有权限的用户都可以删除
事件。请参阅
第 25.4.6 节，“事件调度程序和 MySQL 权限”。
© Mysql 中文网
