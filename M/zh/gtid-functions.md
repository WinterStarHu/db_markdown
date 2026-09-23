# 12.19 与全局事务标识符（GTID）一起使用的函数_MySQL 8.0 参考手册

12.19 与全局事务标识符（GTID）一起使用的函数_MySQL 8.0 参考手册
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
12.1 内置函数和操作符参考
12.2 可加载函数参考
12.3 表达式求值中的类型转换
12.4 运营商
12.5 流量控制函数
12.6 数值函数和运算符
12.7 日期和时间函数
12.8 字符串函数和运算符
12.9 MySQL 使用什么日历？
12.10 全文搜索功能
12.11 转换函数和运算符
12.12 XML函数
12.13 位函数和运算符
12.14 加密和压缩函数
12.15 锁定函数
12.16 信息函数
12.17空间分析函数
12.18 JSON函数
12.19 与全局事务标识符（GTID）一起使用的函数
12.20聚合函数
12.21 窗口函数
12.22性能模式函数
12.23 内部函数
12.24 辅助功能
12.25 精密数学
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
MySQL 8.0 参考手册  / 第 12 章函数和运算符  /
12.19 与全局事务标识符（GTID）一起使用的函数
12.19 与全局事务标识符（GTID）一起使用的函数
本节中描述的函数与基于 GTID 的复制一起使用。请务必记住，所有这些函数都将 GTID 集的字符串表示形式作为参数。因此，GTID 集在与它们一起使用时必须始终被引用。有关详细信息，请参阅GTID 集。
两个 GTID 集的并集只是将它们表示为字符串，用插入的逗号连接在一起。换句话说，您可以定义一个非常简单的函数来获取两个 GTID 集的并集，类似于此处创建的函数：
CREATE FUNCTION GTID_UNION(g1 TEXT, g2 TEXT)
RETURNS TEXT DETERMINISTIC
RETURN CONCAT(g1,',',g2);
有关 GTID 以及如何在实践中使用这些 GTID 函数的更多信息，请参阅第 17.1.3 节，“使用全局事务标识符进行复制”。
表 12.24 GTID 函数
姓名
描述
弃用
GTID_SUBSET()
如果子集中的所有 GTID 也在集合中，则返回 true；否则为假。
GTID_SUBTRACT()
返回集合中不在子集中的所有 GTID。
WAIT_FOR_EXECUTED_GTID_SET()
等到给定的 GTID 已在副本上执行。
WAIT_UNTIL_SQL_THREAD_AFTER_GTIDS()
使用WAIT_FOR_EXECUTED_GTID_SET()。
8.0.18
GTID_SUBSET(set1,set2)
给定两组全局事务标识符
set1和
set2，如果所有 GTID
set1也在 中
，则返回 true set2。返回
NULLifset1或
set2is NULL。否则返回假。
与此函数一起使用的 GTID 集表示为字符串，如以下示例所示：
mysql> SELECT GTID_SUBSET('3E11FA47-71CA-11E1-9E33-C80AA9429562:23',
->     '3E11FA47-71CA-11E1-9E33-C80AA9429562:21-57')\G
*************************** 1. row ***************************
GTID_SUBSET('3E11FA47-71CA-11E1-9E33-C80AA9429562:23',
'3E11FA47-71CA-11E1-9E33-C80AA9429562:21-57'): 1
1 row in set (0.00 sec)
mysql> SELECT GTID_SUBSET('3E11FA47-71CA-11E1-9E33-C80AA9429562:23-25',
->     '3E11FA47-71CA-11E1-9E33-C80AA9429562:21-57')\G
*************************** 1. row ***************************
GTID_SUBSET('3E11FA47-71CA-11E1-9E33-C80AA9429562:23-25',
'3E11FA47-71CA-11E1-9E33-C80AA9429562:21-57'): 1
1 row in set (0.00 sec)
mysql> SELECT GTID_SUBSET('3E11FA47-71CA-11E1-9E33-C80AA9429562:20-25',
->     '3E11FA47-71CA-11E1-9E33-C80AA9429562:21-57')\G
*************************** 1. row ***************************
GTID_SUBSET('3E11FA47-71CA-11E1-9E33-C80AA9429562:20-25',
'3E11FA47-71CA-11E1-9E33-C80AA9429562:21-57'): 0
1 row in set (0.00 sec)
GTID_SUBTRACT(set1,set2)
给定两组全局事务标识符
set1和
set2，仅返回那些不在
set1中
的 GTID set2。返回
NULLifset1或
set2is NULL。
与此函数一起使用的所有 GTID 集都表示为字符串并且必须被引用，如以下示例所示：
mysql> SELECT GTID_SUBTRACT('3E11FA47-71CA-11E1-9E33-C80AA9429562:21-57',
->     '3E11FA47-71CA-11E1-9E33-C80AA9429562:21')\G
*************************** 1. row ***************************
GTID_SUBTRACT('3E11FA47-71CA-11E1-9E33-C80AA9429562:21-57',
'3E11FA47-71CA-11E1-9E33-C80AA9429562:21'): 3e11fa47-71ca-11e1-9e33-c80aa9429562:22-57
1 row in set (0.00 sec)
mysql> SELECT GTID_SUBTRACT('3E11FA47-71CA-11E1-9E33-C80AA9429562:21-57',
->     '3E11FA47-71CA-11E1-9E33-C80AA9429562:20-25')\G
*************************** 1. row ***************************
GTID_SUBTRACT('3E11FA47-71CA-11E1-9E33-C80AA9429562:21-57',
'3E11FA47-71CA-11E1-9E33-C80AA9429562:20-25'): 3e11fa47-71ca-11e1-9e33-c80aa9429562:26-57
1 row in set (0.00 sec)
mysql> SELECT GTID_SUBTRACT('3E11FA47-71CA-11E1-9E33-C80AA9429562:21-57',
->     '3E11FA47-71CA-11E1-9E33-C80AA9429562:23-24')\G
*************************** 1. row ***************************
GTID_SUBTRACT('3E11FA47-71CA-11E1-9E33-C80AA9429562:21-57',
'3E11FA47-71CA-11E1-9E33-C80AA9429562:23-24'): 3e11fa47-71ca-11e1-9e33-c80aa9429562:21-22:25-57
1 row in set (0.01 sec)
WAIT_FOR_EXECUTED_GTID_SET(gtid_set[,
timeout])
等到服务器应用了全局事务标识符包含在中的所有事务
gtid_set；也就是说，直到条件 GTID_SUBSET( gtid_subset,
@@GLOBAL.gtid_executed) 成立。有关 GTID 集的定义，请参阅
第 17.1.3.1 节，“GTID 格式和存储”。
如果指定了超时，并且
timeout在应用 GTID 集中的所有事务之前经过了秒数，则该函数将停止等待。timeout是可选的，默认超时为 0 秒，在这种情况下，该函数始终等待，直到应用了 GTID 集中的所有事务。
WAIT_FOR_EXECUTED_GTID_SET()监控服务器上应用的所有 GTID，包括来自所有复制通道和用户客户端的事务。它不考虑复制通道是否已启动或停止。
有关详细信息，请参阅第 17.1.3 节，“使用全局事务标识符进行复制”。
与此函数一起使用的 GTID 集表示为字符串，因此必须按以下示例所示引用：
mysql> SELECT WAIT_FOR_EXECUTED_GTID_SET('3E11FA47-71CA-11E1-9E33-C80AA9429562:1-5');
-> 0
有关 GTID 集的语法描述，请参阅
第 17.1.3.1 节，“GTID 格式和存储”。
对于WAIT_FOR_EXECUTED_GTID_SET()，返回值是查询的状态，其中0代表成功，1代表超时。任何其他故障都会产生错误。
gtid_mode当任何客户端正在使用此功能等待应用 GTID 时，不能将其更改为 OFF。
WAIT_UNTIL_SQL_THREAD_AFTER_GTIDS(gtid_set[,
timeout][,channel])
WAIT_UNTIL_SQL_THREAD_AFTER_GTIDS()已弃用。Use
WAIT_FOR_EXECUTED_GTID_SET()instead，无论指定事务通过哪个复制通道或用户客户端到达服务器，它都有效。
© Mysql 中文网
