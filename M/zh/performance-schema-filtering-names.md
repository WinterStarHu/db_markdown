# 27.4.9 过滤操作的命名工具或消费者_MySQL 8.0 参考手册

27.4.9 过滤操作的命名工具或消费者_MySQL 8.0 参考手册
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
27.1 性能模式快速入门
27.2 性能模式构建配置
27.3 性能模式启动配置
27.4 性能模式运行时配置
27.4.1 性能模式事件时序1
27.4.2 性能模式事件过滤1
27.4.3 事件预过滤1
27.4.4 按仪器预过滤1
27.4.5 按对象预过滤1
27.4.6 按线程预过滤1
27.4.7 消费者预过滤1
27.4.8 消费者配置示例1
27.4.9 过滤操作的命名工具或消费者1
27.4.10 确定检测的是什么1
27.5 性能模式查询
27.6 性能模式工具命名约定
27.7 性能模式状态监控
27.8 性能模式原子和分子事件
27.9 当前和历史事件的性能模式表
27.10 性能模式语句摘要和采样
27.11 性能模式总表特征
27.12 性能模式表描述
27.13 性能模式选项和变量引用
27.14 性能模式命令选项
27.15 性能模式系统变量
27.16 性能模式状态变量
27.17性能模式内存分配模型
27.18 性能模式和插件
27.19 使用性能模式诊断问题
27.20 性能模式的限制
第 28 章 MySQL 系统模式
第 29 章连接器和 API
第30章MySQL企业版
第31章MySQL工作台
第 32 章 OCI 市场上的 MySQL
附录 A MySQL 8.0 常见问题解答
附录 B 错误信息和常见问题
附录 C 索引
MySQL 词汇表
MySQL 8.0 参考手册  / 第 27 章 MySQL 性能模式  / 27.4 性能模式运行时配置  /
27.4.9 过滤操作的命名工具或消费者
27.4.9 过滤操作的命名工具或消费者
为过滤操作指定的名称可以根据需要具体或通用。要指示单个仪器或消费者，请完整指定其名称：
UPDATE performance_schema.setup_instruments
SET ENABLED = 'NO'
WHERE NAME = 'wait/synch/mutex/myisammrg/MYRG_INFO::mutex';
UPDATE performance_schema.setup_consumers
SET ENABLED = 'NO'
WHERE NAME = 'events_waits_current';
要指定一组工具或消费者，请使用与组成员匹配的模式：
UPDATE performance_schema.setup_instruments
SET ENABLED = 'NO'
WHERE NAME LIKE 'wait/synch/mutex/%';
UPDATE performance_schema.setup_consumers
SET ENABLED = 'NO'
WHERE NAME LIKE '%history%';
如果您使用一种模式，则应选择它以匹配所有感兴趣的项目，而不匹配其他项目。例如，要选择所有文件 I/O 工具，最好使用包含整个工具名称前缀的模式：
... WHERE NAME LIKE 'wait/io/file/%';
匹配名称中任意位置'%/file/%'元素的其他乐器
的模式。'/file/'该模式更不合适，
'%file%'因为它匹配
'file'名称中任何位置的乐器，例如
wait/synch/mutex/innodb/file_open_mutex.
要检查模式匹配的仪器或消费者名称，请执行一个简单的测试：
SELECT NAME FROM performance_schema.setup_instruments
WHERE NAME LIKE 'pattern';
SELECT NAME FROM performance_schema.setup_consumers
WHERE NAME LIKE 'pattern';
有关支持的名称类型的信息，请参阅
第 27.6 节，“Performance Schema Instrument Naming Conventions”。
© Mysql 中文网
