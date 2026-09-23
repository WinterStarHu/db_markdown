# 27.11 性能模式总表特征_MySQL 8.0 参考手册

27.11 性能模式总表特征_MySQL 8.0 参考手册
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
MySQL 8.0 参考手册  / 第 27 章 MySQL 性能模式  /
27.11 性能模式总表特征
27.11 性能模式总表特征
数据库的名称performance_schema是小写的，其中的表名也是如此。查询应以小写形式指定名称。
数据库中有很多表performance_schema是只读的，不能修改：
mysql> TRUNCATE TABLE performance_schema.setup_instruments;
ERROR 1683 (HY000): Invalid performance_schema usage.
一些设置表具有可以修改以影响性能模式操作的列；有些还允许插入或删除行。允许截断以清除收集的事件，因此TRUNCATE TABLE可用于包含此类信息的表，例如以前缀命名的表events_waits_。
可以使用 截断汇总表TRUNCATE
TABLE。通常，效果是将汇总列重置为 0 或NULL，而不是删除行。这使您能够清除收集的值并重新启动聚合。这可能很有用，例如，在您更改了运行时配置之后。此截断行为的例外情况在各个汇总表部分中注明。
特权与其他数据库和表一样：
要从performance_schema表中检索，您必须具有SELECT
权限。
要更改那些可以修改的列，您必须具有UPDATE权限。
要截断可以截断的表，您必须具有
DROP权限。
因为只有一组有限的权限适用于 Performance Schema 表，所以尝试GRANT ALL用作在数据库或表级别授予权限的简写失败并出现错误：
mysql> GRANT ALL ON performance_schema.*
TO 'u1'@'localhost';
ERROR 1044 (42000): Access denied for user 'root'@'localhost'
to database 'performance_schema'
mysql> GRANT ALL ON performance_schema.setup_instruments
TO 'u2'@'localhost';
ERROR 1044 (42000): Access denied for user 'root'@'localhost'
to database 'performance_schema'
相反，授予所需的权限：
mysql> GRANT SELECT ON performance_schema.*
TO 'u1'@'localhost';
Query OK, 0 rows affected (0.03 sec)
mysql> GRANT SELECT, UPDATE ON performance_schema.setup_instruments
TO 'u2'@'localhost';
Query OK, 0 rows affected (0.02 sec)
© Mysql 中文网
