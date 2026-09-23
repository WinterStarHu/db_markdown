# A.6 MySQL 8.0 FAQ：视图_MySQL 8.0 参考手册

A.6 MySQL 8.0 FAQ：视图_MySQL 8.0 参考手册
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
第31章MySQL工作台
第 32 章 OCI 市场上的 MySQL
附录 A MySQL 8.0 常见问题解答
A.1 MySQL 8.0 FAQ：一般
A.2 MySQL 8.0 FAQ：存储引擎
A.3 MySQL 8.0 常见问题解答：服务器 SQL 模式
A.4 MySQL 8.0 FAQ：存储过程和函数
A.5 MySQL 8.0 FAQ：触发器
A.6 MySQL 8.0 FAQ：视图
A.7 MySQL 8.0 FAQ：INFORMATION_SCHEMA
A.8 MySQL 8.0 FAQ：迁移
A.9 MySQL 8.0 FAQ：安全
A.10 MySQL 8.0 FAQ：NDB Cluster
A.11 MySQL 8.0 FAQ：MySQL 中日韩字符集
A.12 MySQL 8.0 常见问题解答：连接器和 API
A.13 MySQL 8.0 常见问题解答：C API、libmysql
A.14 MySQL 8.0 FAQ：复制
A.15 MySQL 8.0 FAQ：MySQL 企业级线程池
A.16 MySQL 8.0 FAQ：InnoDB Change Buffer
A.17 MySQL 8.0 FAQ：InnoDB 静态数据加密
A.18 MySQL 8.0 FAQ：虚拟化支持
附录 B 错误信息和常见问题
附录 C 索引
MySQL 词汇表
MySQL 8.0 参考手册  / 附录 A MySQL 8.0 常见问题解答  /
A.6 MySQL 8.0 FAQ：视图
A.6 MySQL 8.0 FAQ：视图
A.6.1.
在哪里可以找到有关 MySQL 视图的文档？
A.6.2.
是否有 MySQL Views 的讨论论坛？
A.6.3.
如果基础表被删除或重命名，视图会发生什么情况？
A.6.4。
MySQL 8.0 有表快照吗？
A.6.5。
MySQL 8.0 有物化视图吗？
A.6.6.
您可以插入到基于连接的视图中吗？
A.6.1.
在哪里可以找到有关 MySQL 视图的文档？
请参阅第 25.5 节，“使用视图”。
您可能还会发现
MySQL 用户论坛
很有帮助。
A.6.2.
是否有 MySQL Views 的讨论论坛？
请参阅MySQL 用户论坛。
A.6.3.
如果基础表被删除或重命名，视图会发生什么情况？
创建视图后，可以删除或更改定义所引用的表或视图。要检查此类问题的视图定义，请使用该
CHECK TABLE语句。（请参阅
第 13.7.3.2 节，“CHECK TABLE 语句”。）
A.6.4。
MySQL 8.0 有表快照吗？
不。
A.6.5。
MySQL 8.0 有物化视图吗？
不。
A.6.6.
您可以插入到基于连接的视图中吗？
这是可能的，前提是您的
INSERT语句有一个列列表，清楚地表明只涉及一个表。
您不能在一个视图上使用单个插入插入到多个表中。
© Mysql 中文网
