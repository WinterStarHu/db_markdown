# 8.14.7 复制连接线程状态_MySQL 8.0 参考手册

8.14.7 复制连接线程状态_MySQL 8.0 参考手册
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
8.6 优化 MyISAM 表
8.7 优化 MEMORY 表
8.8 了解查询执行计划
8.9 控制查询优化器
8.10 缓冲和缓存
8.11 优化锁定操作
8.12 优化MySQL服务器
8.13 测量性能（基准测试）
8.14 查看服务器线程（进程）信息
8.14.1 访问进程列表1
8.14.2 线程命令值1
8.14.3 一般线程状态1
8.14.4 复制源线程状态1
8.14.5 复制 I/O（接收器）线程状态1
8.14.6 复制 SQL 线程状态1
8.14.7 复制连接线程状态1
8.14.8 NDB Cluster 线程状态1
8.14.9 事件调度器线程状态1
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
MySQL 8.0 参考手册  / 第8章优化  / 8.14 查看服务器线程（进程）信息  /
8.14.7 复制连接线程状态
8.14.7 复制连接线程状态
这些线程状态发生在副本服务器上，但与连接线程相关联，而不是与 I/O 或 SQL 线程相关联。
在 MySQL 8.0.26 中，对仪器名称进行了不兼容的更改，包括线程阶段的名称，其中包含术语“ master ”更改为
“ source ”，“ slave ”更改为
“ replica ”，以及“ mts ”（代表
“多线程从机”），改为
“ mta ”（代表“多线程应用程序”). 使用这些工具名称的监视工具可能会受到影响。如果不兼容的更改对您有影响，请将
terminology_use_previous系统变量设置为BEFORE_8_0_26以使 MySQL 服务器使用先前列表中指定的对象的旧版本名称。这使得依赖旧名称的监视工具能够继续工作，直到它们可以更新为使用新名称。
将
terminology_use_previous具有会话范围的系统变量设置为支持单个函数，或将全局范围设置为所有新会话的默认值。使用全局范围时，慢速查询日志包含名称的旧版本。
Changing master
从 MySQL 8.0.26 开始：Changing replication
source
线程正在处理一个CHANGE
REPLICATION SOURCE TO语句（来自 MySQL 8.0.23）或CHANGE MASTER TO
语句（MySQL 8.0.23 之前）。
Killing slave
线程正在处理一条
STOP REPLICA
语句。
Opening master dump table
此状态发生在 之后Creating table from master
dump。
Reading master dump table data
此状态发生在 之后Opening master dump
table。
Rebuilding the index on master dump table
此状态发生在 之后Reading master dump table
data。
© Mysql 中文网
