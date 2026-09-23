# 25.4.5 事件调度程序状态_MySQL 8.0 参考手册

25.4.5 事件调度程序状态_MySQL 8.0 参考手册
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
25.4.5 事件调度程序状态
25.4.5 事件调度程序状态
Event Scheduler 将有关以错误或警告终止的事件执行的信息写入 MySQL 服务器的错误日志。有关示例，请参见第 25.4.6 节，“事件调度程序和 MySQL 权限”。
要获取有关事件调度​​程序状态的信息以进行调试和故障排除，请运行mysqladmin debug（请参阅第 4.5.2 节，“mysqladmin — MySQL 服务器管理程序”）；运行此命令后，服务器的错误日志包含与事件调度程序相关的输出，类似于此处显示的内容：
Events status:
LLA = Last Locked At  LUA = Last Unlocked At
WOC = Waiting On Condition  DL = Data Locked
Event scheduler status:
State      : INITIALIZED
Thread id  : 0
LLA        : n/a:0
LUA        : n/a:0
WOC        : NO
Workers    : 0
Executed   : 0
Data locked: NO
Event queue status:
Element count   : 0
Data locked     : NO
Attempting lock : NO
LLA             : init_queue:95
LUA             : init_queue:103
WOC             : NO
Next activation : never
在作为事件计划程序执行的事件的一部分出现的语句中，诊断消息（不仅是错误，还有警告）被写入错误日志，并且在 Windows 上，写入应用程序事件日志。对于频繁执行的事件，这可能会导致记录许多消息。例如，对于语句，如果查询没有返回任何行，则会出现错误代码为 1329 的警告 ( )，并且变量值保持不变。如果查询返回多行，则会出现错误 1172 ( )。对于任何一种情况，您都可以通过声明条件处理程序来避免记录警告；参见
第 13.6.7.2 节，“DECLARE ... HANDLER 语句”SELECT ... INTO
var_listNo dataResult consisted of more than one row. 对于可能检索多行的语句，另一种策略是使用LIMIT
1将结果集限制为单行。
© Mysql 中文网
