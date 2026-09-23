# 8.5.7 优化 InnoDB DDL 操作_MySQL 8.0 参考手册

8.5.7 优化 InnoDB DDL 操作_MySQL 8.0 参考手册
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
8.1 优化概述
8.2 优化SQL语句
8.3 优化和索引
8.4 优化数据库结构
8.5 优化 InnoDB 表
8.5.1 优化 InnoDB 表的存储布局1
8.5.2 优化 InnoDB 事务管理1
8.5.3 优化 InnoDB 只读事务1
8.5.4 优化 InnoDB 重做日志记录1
8.5.5 InnoDB 表的批量数据加载1
8.5.6 优化 InnoDB 查询1
8.5.7 优化 InnoDB DDL 操作1
8.5.8 优化 InnoDB 磁盘 I/O1
8.5.9 优化 InnoDB 配置变量1
8.5.10 为多表系统优化 InnoDB1
8.6 优化 MyISAM 表
8.7 优化 MEMORY 表
8.8 了解查询执行计划
8.9 控制查询优化器
8.10 缓冲和缓存
8.11 优化锁定操作
8.12 优化MySQL服务器
8.13 测量性能（基准测试）
8.14 查看服务器线程（进程）信息
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
MySQL 8.0 参考手册  / 第8章优化  / 8.5 优化 InnoDB 表  /
8.5.7 优化 InnoDB DDL 操作
8.5.7 优化 InnoDB DDL 操作
CREATE许多对表和索引（ 、ALTER和
语句）
的 DDL 操作DROP可以在线执行。有关详细信息，请参阅第 15.12 节，“InnoDB 和在线 DDL”。
在线 DDL 支持添加二级索引意味着您通常可以通过创建不带二级索引的表，然后在加载数据后添加二级索引来加快创建和加载表及关联索引的过程。
用于TRUNCATE TABLE清空表，而不是. 外键约束可以使语句像常规语句一样工作，在这种情况下，像
和
这样的命令序列可能是最快的。
DELETE FROM
tbl_nameTRUNCATEDELETEDROP TABLECREATE TABLE
因为主键是每个InnoDB表的存储布局中不可或缺的一部分，而改变主键的定义涉及到重新组织整个表，所以始终将主键设置为
CREATE TABLE语句的一部分，并提前计划，这样您就不需要
ALTER或DROP之后的主键。
© Mysql 中文网
