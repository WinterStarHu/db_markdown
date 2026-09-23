# 27.19.1 使用性能模式进行查询分析_MySQL 8.0 参考手册

27.19.1 使用性能模式进行查询分析_MySQL 8.0 参考手册
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
27.19.1 使用性能模式进行查询分析1
27.19.2 获取父事件信息1
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
MySQL 8.0 参考手册  / 第 27 章 MySQL 性能模式  / 27.19 使用性能模式诊断问题  /
27.19.1 使用性能模式进行查询分析
27.19.1 使用性能模式进行查询分析
以下示例演示如何使用 Performance Schema 语句事件和阶段事件来检索SHOW
PROFILES与SHOW
PROFILE语句提供的分析信息相当的数据。
该setup_actors表可用于按主机、用户或帐户限制历史事件的收集，以减少运行时开销和历史表中收集的数据量。该示例的第一步显示了如何将历史事件的收集限制为特定用户。
Performance Schema 以皮秒（万亿分之一秒）为单位显示事件计时器信息，以将计时数据规范化为标准单位。在以下示例中，
TIMER_WAIT值除以 1000000000000 以秒为单位显示数据。值也被截断为小数点后 6 位，以便以SHOW PROFILES与
SHOW PROFILE语句相同的格式显示数据。
将历史事件的收集限制为运行查询的用户。默认情况下，
setup_actors配置为允许对所有前台线程进行监控和历史事件收集：
mysql> SELECT * FROM performance_schema.setup_actors;
+------+------+------+---------+---------+
| HOST | USER | ROLE | ENABLED | HISTORY |
+------+------+------+---------+---------+
| %    | %    | %    | YES     | YES     |
+------+------+------+---------+---------+
更新表中的默认行
setup_actors以禁用所有前台线程的历史事件收集和监视，并插入一个新行以启用对运行查询的用户的监视和历史事件收集：
mysql> UPDATE performance_schema.setup_actors
SET ENABLED = 'NO', HISTORY = 'NO'
WHERE HOST = '%' AND USER = '%';
mysql> INSERT INTO performance_schema.setup_actors
(HOST,USER,ROLE,ENABLED,HISTORY)
VALUES('localhost','test_user','%','YES','YES');
表中的数据setup_actors现在应类似于以下内容：
mysql> SELECT * FROM performance_schema.setup_actors;
+-----------+-----------+------+---------+---------+
| HOST      | USER      | ROLE | ENABLED | HISTORY |
+-----------+-----------+------+---------+---------+
| %         | %         | %    | NO      | NO      |
| localhost | test_user | %    | YES     | YES     |
+-----------+-----------+------+---------+---------+
确保通过更新
setup_instruments表启用语句和阶段检测。某些仪器可能已经默认启用。
mysql> UPDATE performance_schema.setup_instruments
SET ENABLED = 'YES', TIMED = 'YES'
WHERE NAME LIKE '%statement/%';
mysql> UPDATE performance_schema.setup_instruments
SET ENABLED = 'YES', TIMED = 'YES'
WHERE NAME LIKE '%stage/%';
确保events_statements_*启用
events_stages_*消费者。一些消费者可能已经默认启用。
mysql> UPDATE performance_schema.setup_consumers
SET ENABLED = 'YES'
WHERE NAME LIKE '%events_statements_%';
mysql> UPDATE performance_schema.setup_consumers
SET ENABLED = 'YES'
WHERE NAME LIKE '%events_stages_%';
在您正在监视的用户帐户下，运行您要分析的语句。例如：
mysql> SELECT * FROM employees.employees WHERE emp_no = 10001;
+--------+------------+------------+-----------+--------+------------+
| emp_no | birth_date | first_name | last_name | gender | hire_date |
+--------+------------+------------+-----------+--------+------------+
|  10001 | 1953-09-02 | Georgi     | Facello   | M      | 1986-06-26 |
+--------+------------+------------+-----------+--------+------------+EVENT_ID通过查询
表来
识别语句的所在events_statements_history_long
。这一步类似于运行
SHOW PROFILES识别
Query_ID。以下查询产生类似于的输出SHOW
PROFILES：
mysql> SELECT EVENT_ID, TRUNCATE(TIMER_WAIT/1000000000000,6) as Duration, SQL_TEXT
FROM performance_schema.events_statements_history_long WHERE SQL_TEXT like '%10001%';
+----------+----------+--------------------------------------------------------+
| event_id | duration | sql_text                                               |
+----------+----------+--------------------------------------------------------+
|       31 | 0.028310 | SELECT * FROM employees.employees WHERE emp_no = 10001 |
+----------+----------+--------------------------------------------------------+
查询
events_stages_history_long
表以检索语句的阶段事件。阶段使用事件嵌套链接到语句。每个阶段事件记录都有一个NESTING_EVENT_ID包含EVENT_ID父语句的列。
mysql> SELECT event_name AS Stage, TRUNCATE(TIMER_WAIT/1000000000000,6) AS Duration
FROM performance_schema.events_stages_history_long WHERE NESTING_EVENT_ID=31;
+--------------------------------+----------+
| Stage                          | Duration |
+--------------------------------+----------+
| stage/sql/starting             | 0.000080 |
| stage/sql/checking permissions | 0.000005 |
| stage/sql/Opening tables       | 0.027759 |
| stage/sql/init                 | 0.000052 |
| stage/sql/System lock          | 0.000009 |
| stage/sql/optimizing           | 0.000006 |
| stage/sql/statistics           | 0.000082 |
| stage/sql/preparing            | 0.000008 |
| stage/sql/executing            | 0.000000 |
| stage/sql/Sending data         | 0.000017 |
| stage/sql/end                  | 0.000001 |
| stage/sql/query end            | 0.000004 |
| stage/sql/closing tables       | 0.000006 |
| stage/sql/freeing items        | 0.000272 |
| stage/sql/cleaning up          | 0.000001 |
+--------------------------------+----------+
© Mysql 中文网
