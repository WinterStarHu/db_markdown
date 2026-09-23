# 12.22性能模式函数_MySQL 8.0 参考手册

12.22性能模式函数_MySQL 8.0 参考手册
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
12.22性能模式函数
12.22性能模式函数
从 MySQL 8.0.16 开始，MySQL 包含格式化或检索性能模式数据的内置 SQL 函数，并且可以用作相应sys模式存储函数的等效项。内置函数可以在任何模式中调用并且不需要限定符，这与需要模式限定符或当前模式
的sys
函数不同。sys.sys
表 12.27 性能模式函数
姓名
描述
介绍
FORMAT_BYTES()
将字节数转换为带单位的值
8.0.16
FORMAT_PICO_TIME()
将以皮秒为单位的时间转换为带单位的值
8.0.16
PS_CURRENT_THREAD_ID()
当前线程的 Performance Schema 线程 ID
8.0.16
PS_THREAD_ID()
给定线程的性能架构线程 ID
8.0.16
内置函数取代了相应的
sys函数，后者已被弃用；希望它们在未来版本的 MySQL 中被删除。使用函数的应用程序sys应该调整为使用内置函数，记住sys函数和内置函数之间的一些细微差别。有关这些差异的详细信息，请参阅本节中的功能说明。
FORMAT_BYTES(count)
给定一个数字字节数，将其转换为人类可读的格式并返回一个由值和单位指示符组成的字符串。该字符串包含四舍五入到小数点后 2 位的字节数和至少 3 位有效数字。小于 1024 字节的数字表示为整数且不四舍五入。返回NULL如果
count是NULL。
单位指示符取决于字节计数参数的大小，如下表所示。
参数值
结果单位
结果单位指标
高达 1023
字节
字节
高达 1024 2 - 1
千比字节
KiB
高达 1024 3 - 1
兆字节
军训局
高达 1024 4 - 1
千兆字节
GiB
高达 1024 5 - 1
太字节
钛硼
高达 1024 6 - 1
pebibytes
PIB
1024 6及以上
十字节
EiB
mysql> SELECT FORMAT_BYTES(512), FORMAT_BYTES(18446644073709551615);
+-------------------+------------------------------------+
| FORMAT_BYTES(512) | FORMAT_BYTES(18446644073709551615) |
+-------------------+------------------------------------+
|  512 bytes        | 16.00 EiB                          |
+-------------------+------------------------------------+
FORMAT_BYTES()在 MySQL 8.0.16 中添加。它可以用来代替
sysschema
format_bytes()函数，记住这个区别：
FORMAT_BYTES()使用
EiB单位指标。
sys.format_bytes()才不是。
FORMAT_PICO_TIME(time_val)
给定一个数字性能模式延迟或等待时间（以皮秒为单位），将其转换为人类可读的格式并返回一个由值和单位指示符组成的字符串。该字符串包含四舍五入到小数点后 2 位的小数时间和至少 3 位有效数字。小于 1 纳秒的时间表示为整数且不四舍五入。
如果time_val是
NULL，则此函数返回
NULL。
单位指示符取决于时间值参数的大小，如下表所示。
参数值
结果单位
结果单位指标
高达 10 3 − 1
皮秒
附言
高达 10 6 − 1
纳秒
ns
高达 10 9 − 1
微秒
我们
高达 10 12 − 1
毫秒
小姐
高达 60×10 12 − 1
秒
秒
高达 3.6×10 15 − 1
分钟
分钟
高达 8.64×10 16 − 1
小时
H
8.64×10 16及以上
天
d
mysql> SELECT FORMAT_PICO_TIME(3501), FORMAT_PICO_TIME(188732396662000);
+------------------------+-----------------------------------+
| FORMAT_PICO_TIME(3501) | FORMAT_PICO_TIME(188732396662000) |
+------------------------+-----------------------------------+
| 3.50 ns                | 3.15 min                          |
+------------------------+-----------------------------------+
FORMAT_PICO_TIME()在 MySQL 8.0.16 中添加。它可以代替
sysschema
format_time()函数使用，请记住以下差异：
要表示分钟，
sys.format_time()请使用
m单位指示器，而
FORMAT_PICO_TIME()使用
min.
sys.format_time()使用
w（周）单位指标。
FORMAT_PICO_TIME()才不是。
PS_CURRENT_THREAD_ID()
返回一个BIGINT UNSIGNED值，表示分配给当前连接的性能模式线程 ID。
线程 ID 返回值是
THREAD_IDPerformance Schema 表列中给出的类型的值。
Performance Schema 配置
PS_CURRENT_THREAD_ID()的影响方式与PS_THREAD_ID(). 有关详细信息，请参阅该功能的说明。
mysql> SELECT PS_CURRENT_THREAD_ID();
+------------------------+
| PS_CURRENT_THREAD_ID() |
+------------------------+
|                     52 |
+------------------------+
mysql> SELECT PS_THREAD_ID(CONNECTION_ID());
+-------------------------------+
| PS_THREAD_ID(CONNECTION_ID()) |
+-------------------------------+
|                            52 |
+-------------------------------+
PS_CURRENT_THREAD_ID()在 MySQL 8.0.16 中添加。它可以用作调用参数为或
的sys模式
ps_thread_id()函数的快捷方式。
NULLCONNECTION_ID()
PS_THREAD_ID(connection_id)
给定一个连接 ID，返回一个BIGINT
UNSIGNED值，表示分配给连接 ID 的性能模式线程 ID，或者
NULL如果连接 ID 不存在线程 ID。后者可能发生在未检测的线程上，或者如果connection_id
是NULL。
连接 ID 参数是
PROCESSLIST_IDPerformance Schemathreads表的
Id列或SHOW
PROCESSLIST输出列中给出的类型的值。
线程 ID 返回值是
THREAD_IDPerformance Schema 表列中给出的类型的值。
性能模式配置影响
PS_THREAD_ID()操作如下。（这些评论也适用于
PS_CURRENT_THREAD_ID()。）
禁用thread_instrumentation
消费者会禁用在线程级别收集和聚合统计信息，但对
PS_THREAD_ID().
如果
performance_schema_max_thread_instances
不为 0，则 Performance Schema 为线程统计信息分配内存，并为实例内存可用的每个线程分配一个内部 ID。如果存在实例内存不可用的线程，则
PS_THREAD_ID()返回
NULL；在这种情况下，
Performance_schema_thread_instances_lost
是非零的。
如果
performance_schema_max_thread_instances
为 0，则性能模式不分配线程内存并PS_THREAD_ID()返回
NULL。
如果性能模式本身被禁用，
PS_THREAD_ID()则会产生错误。
mysql> SELECT PS_THREAD_ID(6);
+-----------------+
| PS_THREAD_ID(6) |
+-----------------+
|              45 |
+-----------------+
PS_THREAD_ID()在 MySQL 8.0.16 中添加。它可以用来代替
sysschema
ps_thread_id()函数，记住这个区别：
使用参数NULL，
sys.ps_thread_id()返回当前连接的线程 ID，而
PS_THREAD_ID()返回
NULL。要获取当前连接线程 ID，请
PS_CURRENT_THREAD_ID()
改用。
© Mysql 中文网
