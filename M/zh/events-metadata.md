# 25.4.4 事件元数据_MySQL 8.0 参考手册

25.4.4 事件元数据_MySQL 8.0 参考手册
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
25.4.4 事件元数据
25.4.4 事件元数据
要获取有关事件的元数据：
查询数据库的EVENTS表
INFORMATION_SCHEMA。请参阅
第 26.3.14 节，“INFORMATION_SCHEMA EVENTS 表”。
使用SHOW CREATE EVENT
语句。请参阅第 13.7.7.7 节，“SHOW CREATE EVENT 语句”。
使用SHOW EVENTS语句。请参阅第 13.7.7.18 节，“SHOW EVENTS 语句”。
事件调度程序时间表示
MySQL 中的每个会话都有一个会话时区 (STZ)。这是在会话开始时time_zone从服务器的全局
time_zone值初始化的会话值，但在会话期间可能会更改。
CREATE EVENTor
语句执行
时的当前会话时区
ALTER EVENT用于解释事件定义中指定的时间。这成为事件时区 (ETZ)；即，用于事件调度并在事件执行时在事件中生效的时区。
为了在数据字典中表示事件信息，将execute_at、starts和
ends时间转换为 UTC 并与事件时区一起存储。这使事件执行能够按照定义继续进行，而不管服务器时区或夏令时的任何后续更改。last_executed时间也以 UTC 格式存储
。
事件时间可以通过从
INFORMATION_SCHEMA.EVENTS表中或从中选择来获得SHOW EVENTS，但它们被报告为 ETZ 或 STZ 值。下表总结了事件时间的表示。
价值
INFORMATION_SCHEMA.EVENTS
SHOW EVENTS
执行于
ETZ
ETZ
开始
ETZ
ETZ
结束
ETZ
ETZ
最后执行
ETZ
不适用
已创建
STZ
不适用
最后修改
STZ
不适用
© Mysql 中文网
