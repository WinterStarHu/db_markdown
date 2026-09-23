# 27.19.2 获取父事件信息_MySQL 8.0 参考手册

27.19.2 获取父事件信息_MySQL 8.0 参考手册
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
27.19.2 获取父事件信息
27.19.2 获取父事件信息
该data_locks表显示持有和请求的数据锁。该表的行有一个
THREAD_ID列指示拥有锁的会话的线程 ID，以及一个
EVENT_ID指示导致锁的性能模式事件的列。( THREAD_ID, EVENT_ID) 值的元组隐式标识其他性能模式表中的父事件：
表
中的父等待事件
events_waits_xxx
表格
中的父阶段事件
events_stages_xxx
表
中的父语句事件
events_statements_xxxevents_transactions_current
表
中父事务事件
要获取有关父事件的详细信息，请将
THREAD_ID和EVENT_ID
列与相应父事件表中名称相似的列连接起来。该关系基于嵌套集数据模型，因此连接有多个子句。parent给定分别由和
表示的父表和子表child，连接如下所示：
WHERE
parent.THREAD_ID = child.THREAD_ID        /* 1 */
AND parent.EVENT_ID < child.EVENT_ID      /* 2 */
AND (
child.EVENT_ID <= parent.END_EVENT_ID   /* 3a */
OR parent.END_EVENT_ID IS NULL          /* 3b */
)
加盟条件为：
父事件和子事件在同一个线程中。
子事件在父事件之后开始，因此其
EVENT_ID值大于父事件。
父事件已完成或仍在运行。
要查找锁定信息，
data_locks是包含子事件的表。
该data_locks表仅显示现有锁，因此这些注意事项适用于哪个表包含父事件：
对于交易，唯一的选择是
events_transactions_current. 如果事务已完成，它可能在事务历史表中，但锁已经消失了。
对于语句，这完全取决于获取锁的语句是已经完成（use
events_statements_history）的事务中的语句还是仍在运行（use
events_statements_current）的语句。
对于阶段，逻辑类似于语句；使用
events_stages_history或
events_stages_current。
对于等待，逻辑类似于语句；使用
events_waits_history或
events_waits_current。但是，记录了如此多的等待，导致锁定的等待很可能已经从历史表中消失了。
等待、暂存和声明事件会迅速从历史记录中消失。如果一个很久以前执行的语句获取了锁但在一个仍然打开的事务中，则可能无法找到该语句，但有可能找到该事务。
这就是嵌套集数据模型更适合定位父事件的原因。当中间节点已经从历史表中消失时，父/子关系中的后续链接（数据锁定 -> 父等待 -> 父阶段 -> 父事务）无法正常工作。
下面的场景说明了如何找到获取锁的语句的父事务：
会话 A：
[1] START TRANSACTION;
[2] SELECT * FROM t1 WHERE pk = 1;
[3] SELECT 'Hello, world';
会话 B：
SELECT ...
FROM performance_schema.events_transactions_current AS parent
INNER JOIN performance_schema.data_locks AS child
WHERE
parent.THREAD_ID = child.THREAD_ID
AND parent.EVENT_ID < child.EVENT_ID
AND (
child.EVENT_ID <= parent.END_EVENT_ID
OR parent.END_EVENT_ID IS NULL
);
会话 B 的查询应将语句 [2] 显示为拥有记录上的数据锁pk=1。
如果会话 A 执行更多语句，[2] 会淡出历史表。
查询应该显示在 [1] 中开始的事务，无论执行了多少语句、阶段或等待。
要查看更多数据，您还可以使用
表，但事务除外，假设服务器中没有其他查询运行（以便保留历史记录）。
events_xxx_history_long
© Mysql 中文网
