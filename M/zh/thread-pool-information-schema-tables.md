# 26.5 INFORMATION_SCHEMA线程池表_MySQL 8.0 参考手册

26.5 INFORMATION_SCHEMA线程池表_MySQL 8.0 参考手册
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
26.1 简介
26.2 INFORMATION_SCHEMA 表参考
26.3 INFORMATION_SCHEMA 总表
26.4 INFORMATION_SCHEMA InnoDB 表
26.5 INFORMATION_SCHEMA线程池表
26.5.1 INFORMATION_SCHEMA线程池表参考1
26.5.2 INFORMATION_SCHEMA TP_THREAD_GROUP_STATE 表1
26.5.3 INFORMATION_SCHEMA TP_THREAD_GROUP_STATS 表1
26.5.4 INFORMATION_SCHEMA TP_THREAD_STATE 表1
26.6 INFORMATION_SCHEMA 连接控制表
26.7 INFORMATION_SCHEMA MySQL 企业防火墙表
26.8 SHOW 语句的扩展
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
MySQL 8.0 参考手册  / 第 26 章 INFORMATION_SCHEMA 表  /
26.5 INFORMATION_SCHEMA线程池表
26.5 INFORMATION_SCHEMA线程池表
26.5.1 INFORMATION_SCHEMA线程池表参考26.5.2 INFORMATION_SCHEMA TP_THREAD_GROUP_STATE 表26.5.3 INFORMATION_SCHEMA TP_THREAD_GROUP_STATS 表26.5.4 INFORMATION_SCHEMA TP_THREAD_STATE 表
笔记
从 MySQL 8.0.14 开始，INFORMATION_SCHEMA
线程池表也可用作性能模式表。（请参阅
第 27.12.16 节，“性能模式线程池表”。）这些
INFORMATION_SCHEMA表已弃用；希望它们在未来版本的 MySQL 中被删除。应用程序应该从旧表过渡到新表。例如，如果应用程序使用此查询：
SELECT * FROM INFORMATION_SCHEMA.TP_THREAD_STATE;
应用程序应改用此查询：
SELECT * FROM performance_schema.tp_thread_state;
以下部分描述了
INFORMATION_SCHEMA与线程池插件关联的表（请参阅第 5.6.3 节，“MySQL 企业线程池”）。它们提供有关线程池操作的信息：
TP_THREAD_GROUP_STATE: 线程池线程组状态信息
TP_THREAD_GROUP_STATS: 线程组统计
TP_THREAD_STATE：关于线程池线程状态的信息
这些表中的行表示时间快照。在 的情况下
TP_THREAD_STATE，线程组的所有行都包含一个时间快照。因此，MySQL 服务器在生成快照时持有线程组的互斥量。但它不会同时在所有线程组上持有互斥锁，以防止语句TP_THREAD_STATE阻塞整个 MySQL 服务器。
线程池表由单独的INFORMATION_SCHEMA插件实现，是否加载一个插件的决定可以独立于其他插件（参见
第 5.6.3.2 节，“线程池安装”）。但是，所有表格的内容取决于启用的线程池插件。如果启用了表插件但未启用线程池插件，则表变得可见并且可以访问但为空。
© Mysql 中文网
