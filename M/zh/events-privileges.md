# 25.4.6 事件调度器和 MySQL 权限_MySQL 8.0 参考手册

25.4.6 事件调度器和 MySQL 权限_MySQL 8.0 参考手册
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
25.4.6 事件调度器和 MySQL 权限
25.4.6 事件调度器和 MySQL 权限
要启用或禁用计划事件的执行，需要设置全局
event_scheduler系统变量的值。这需要足够的权限来设置全局系统变量。请参阅第 5.1.9.1 节，“系统变量权限”。
该EVENT权限管理事件的创建、修改和删除。可以使用 授予此特权GRANT。例如，此GRANT语句授予对用户
EVENT命名的模式的特权：
myschemajon@ghidoraGRANT EVENT ON myschema.* TO jon@ghidora;
（我们假设这个用户帐户已经存在，并且我们希望它保持不变。）
要授予同一用户EVENT
对所有模式的权限，请使用以下语句：
GRANT EVENT ON *.* TO jon@ghidora;
该EVENT权限具有全局或架构级范围。因此，尝试在单个表上授予它会导致错误，如下所示：
mysql> GRANT EVENT ON myschema.mytable TO jon@ghidora;
ERROR 1144 (42000): Illegal GRANT/REVOKE command; please
consult the manual to see which privileges can be used
重要的是要了解事件是使用其定义者的特权执行的，并且它不能执行其定义者没有必要特权的任何操作。例如，假设jon@ghidora具有 的
EVENT权限
myschema。还假设该用户拥有 的
SELECT权限
myschema，但没有该架构的其他权限。可以jon@ghidora创建一个新事件，例如：
CREATE EVENT e_store_ts
ON SCHEDULE
EVERY 10 SECOND
DO
INSERT INTO myschema.mytable VALUES (UNIX_TIMESTAMP());
用户等待一分钟左右，然后执行
SELECT * FROM mytable;查询，希望在表中看到几个新行。相反，表是空的。由于用户没有INSERT
相关表的权限，因此该事件无效。
如果您检查 MySQL 错误日志 ( hostname.err)，您可以看到该事件正在执行，但它试图执行的操作失败了：
2013-09-24T12:41:31.261992Z 25 [ERROR] Event Scheduler:
[jon@ghidora][cookbook.e_store_ts] INSERT command denied to user
'jon'@'ghidora' for table 'mytable'
2013-09-24T12:41:31.262022Z 25 [Note] Event Scheduler:
[jon@ghidora].[myschema.e_store_ts] event execution failed.
2013-09-24T12:41:41.271796Z 26 [ERROR] Event Scheduler:
[jon@ghidora][cookbook.e_store_ts] INSERT command denied to user
'jon'@'ghidora' for table 'mytable'
2013-09-24T12:41:41.272761Z 26 [Note] Event Scheduler:
[jon@ghidora].[myschema.e_store_ts] event execution failed.
由于该用户很可能无权访问错误日志，因此可以通过直接执行来验证事件的操作语句是否有效：
mysql> INSERT INTO myschema.mytable VALUES (UNIX_TIMESTAMP());
ERROR 1142 (42000): INSERT command denied to user
'jon'@'ghidora' for table 'mytable'
检查
INFORMATION_SCHEMA.EVENTS表显示e_store_ts存在并已启用，但其
LAST_EXECUTED列是
NULL：
mysql> SELECT * FROM INFORMATION_SCHEMA.EVENTS
>     WHERE EVENT_NAME='e_store_ts'
>     AND EVENT_SCHEMA='myschema'\G
*************************** 1. row ***************************
EVENT_CATALOG: NULL
EVENT_SCHEMA: myschema
EVENT_NAME: e_store_ts
DEFINER: jon@ghidora
EVENT_BODY: SQL
EVENT_DEFINITION: INSERT INTO myschema.mytable VALUES (UNIX_TIMESTAMP())
EVENT_TYPE: RECURRING
EXECUTE_AT: NULL
INTERVAL_VALUE: 5
INTERVAL_FIELD: SECOND
SQL_MODE: NULL
STARTS: 0000-00-00 00:00:00
ENDS: 0000-00-00 00:00:00
STATUS: ENABLED
ON_COMPLETION: NOT PRESERVE
CREATED: 2006-02-09 22:36:06
LAST_ALTERED: 2006-02-09 22:36:06
LAST_EXECUTED: NULL
EVENT_COMMENT:
1 row in set (0.00 sec)
要取消EVENT特权，请使用该REVOKE语句。在此示例中，EVENT架构的权限myschema已从
jon@ghidora用户帐户中删除：
REVOKE EVENT ON myschema.* FROM jon@ghidora;
重要的
撤销EVENT用户的权限不会删除或禁用该用户可能已创建的任何事件。
重命名或删除创建事件的用户不会迁移或删除事件。
假设用户jon@ghidora已被授予对模式的EVENT和
INSERT权限
myschema。然后该用户创建以下事件：
CREATE EVENT e_insert
ON SCHEDULE
EVERY 7 SECOND
DO
INSERT INTO myschema.mytable;
创建此事件后，root撤销 的EVENT特权
jon@ghidora。但是，
继续执行，每七秒e_insert插入一个新行。mytable如果root发布了以下任一声明，情况也是如此：
DROP USER jon@ghidora;
RENAME USER jon@ghidora TO
someotherguy@ghidora;
您可以通过在发出or
语句
之前和之后检查INFORMATION_SCHEMA.EVENTS表（请参阅
第 26.3.14 节，“INFORMATION_SCHEMA EVENTS 表” ）
来验证这是真的
。DROP USERRENAME USER
事件定义存储在数据字典中。要删除由其他用户帐户创建的事件，您必须是 MySQL
root用户或具有必要权限的其他用户。
用户的EVENT权限存储在和表的Event_priv列中
。在这两种情况下，此列都包含值“ ”或“ ”之一。' ' 是默认值。
仅当给定用户具有全局权限（即，如果该权限是使用 授予的）时，才会为给定用户设置为 ' ' 。对于模式级
权限，
在中创建一行
并将该行的
列设置为模式名称，将
列设置为用户名，将
列设置为 'mysql.usermysql.dbYNNmysql.user.Event_privYEVENTGRANT EVENT ON
*.*EVENTGRANTmysql.dbDbUserEvent_privY'. 永远不需要直接操作这些表，因为GRANT
EVENTandREVOKE EVENT语句对它们执行所需的操作。
五个状态变量提供事件相关操作的计数（但不包括事件执行的语句；请参阅第 25.8 节，“存储程序的限制”）。这些是：
Com_create_event：
CREATE EVENT自上次服务器重启以来执行的语句数。
Com_alter_event：
ALTER EVENT自上次服务器重启以来执行的语句数。
Com_drop_event：
DROP EVENT自上次服务器重启以来执行的语句数。
Com_show_create_event：
SHOW CREATE EVENT自上次服务器重启以来执行的语句数。
Com_show_events：
SHOW EVENTS自上次服务器重启以来执行的语句数。
您可以通过运行语句一次查看所有这些的当前值SHOW STATUS LIKE
'%event%';。
© Mysql 中文网
