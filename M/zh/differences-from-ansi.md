# 1.7.2 MySQL 与标准 SQL 的区别_MySQL 8.0 参考手册

1.7.2 MySQL 与标准 SQL 的区别_MySQL 8.0 参考手册
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
1.7.1 MySQL 对标准 SQL 的扩展1
1.7.2 MySQL 与标准 SQL 的区别1
1.7.2.1 SELECT INTO TABLE 差异
1.7.2.2 更新差异
1.7.2.3 外键约束差异
1.7.2.4 '--' 作为注释的开始
1.7.3 MySQL 如何处理约束1
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
MySQL 8.0 参考手册  / 第一章 一般信息  / 1.7 MySQL 标准合规性  /
1.7.2 MySQL 与标准 SQL 的区别
1.7.2 MySQL 与标准 SQL 的区别
1.7.2.1 SELECT INTO TABLE 差异1.7.2.2 更新差异1.7.2.3 外键约束差异1.7.2.4 '--' 作为注释的开始
我们试图让MySQL Server遵循ANSI SQL标准和ODBC SQL标准，但是MySQL Server在某些情况下执行操作的方式不同：
MySQL 和标准 SQL 特权系统之间存在一些差异。例如，在 MySQL 中，删除表时不会自动撤销表的权限。您必须显式发出一条
REVOKE语句来撤销表的权限。有关详细信息，请参阅
第 13.7.1.8 节，“REVOKE 语句”。
该CAST()函数不支持转换为REAL或
BIGINT。请参阅
第 12.11 节，“Cast 函数和运算符”。
© Mysql 中文网
