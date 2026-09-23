# A.16 MySQL 8.0 FAQ：InnoDB Change Buffer_MySQL 8.0 参考手册

A.16 MySQL 8.0 FAQ：InnoDB Change Buffer_MySQL 8.0 参考手册
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
第 28 章 MySQL 系统模式
第 29 章连接器和 API
第30章MySQL企业版
第31章MySQL工作台
第 32 章 OCI 市场上的 MySQL
附录 A MySQL 8.0 常见问题解答
A.1 MySQL 8.0 FAQ：一般
A.2 MySQL 8.0 FAQ：存储引擎
A.3 MySQL 8.0 常见问题解答：服务器 SQL 模式
A.4 MySQL 8.0 FAQ：存储过程和函数
A.5 MySQL 8.0 FAQ：触发器
A.6 MySQL 8.0 FAQ：视图
A.7 MySQL 8.0 FAQ：INFORMATION_SCHEMA
A.8 MySQL 8.0 FAQ：迁移
A.9 MySQL 8.0 FAQ：安全
A.10 MySQL 8.0 FAQ：NDB Cluster
A.11 MySQL 8.0 FAQ：MySQL 中日韩字符集
A.12 MySQL 8.0 常见问题解答：连接器和 API
A.13 MySQL 8.0 常见问题解答：C API、libmysql
A.14 MySQL 8.0 FAQ：复制
A.15 MySQL 8.0 FAQ：MySQL 企业级线程池
A.16 MySQL 8.0 FAQ：InnoDB Change Buffer
A.17 MySQL 8.0 FAQ：InnoDB 静态数据加密
A.18 MySQL 8.0 FAQ：虚拟化支持
附录 B 错误信息和常见问题
附录 C 索引
MySQL 词汇表
MySQL 8.0 参考手册  / 附录 A MySQL 8.0 常见问题解答  /
A.16 MySQL 8.0 FAQ：InnoDB Change Buffer
A.16 MySQL 8.0 FAQ：InnoDB Change Buffer
A.16.1.
哪些类型的操作会修改二级索引并导致更改缓冲？
A.16.2。
InnoDB 更改缓冲区有什么好处？
A.16.3.
更改缓冲区是否支持其他类型的索引？
A.16.4。
InnoDB 为更改缓冲区使用了多少空间？
A.16.5。
如何确定更改缓冲区的当前大小？
A.16.6.
何时发生更改缓冲区合并？
A.16.7。
何时刷新更改缓冲区？
A.16.8。
什么时候应该使用更改缓冲区？
A.16.9.
什么时候不应该使用更改缓冲区？
A.16.10。
我在哪里可以找到有关更改缓冲区的更多信息？
A.16.1.
哪些类型的操作会修改二级索引并导致更改缓冲？
INSERT, UPDATE, 和
DELETE操作可以修改二级索引。如果受影响的索引页不在缓冲池中，则更改可以缓冲在更改缓冲区中。
A.16.2。InnoDB更改缓冲区
有什么好处？
当二级索引页不在缓冲池中时缓冲二级索引更改可避免立即从磁盘读取受影响的索引页所需的昂贵的随机访问 I/O 操作。当其他读取操作将页面读入缓冲池时，可以稍后分批应用缓冲的更改。
A.16.3.
更改缓冲区是否支持其他类型的索引？
不可以，change buffer 只支持二级索引。不支持聚集索引、全文索引和空间索引。全文索引有自己的缓存机制。
A.16.4。InnoDB更改缓冲区使用了
多少空间？
在 MySQL 5.6中引入
innodb_change_buffer_max_size
配置选项之前，系统表空间中磁盘更改缓冲区的最大大小为
InnoDB缓冲池大小的 1/3。
在 MySQL 5.6 及更高版本中，
innodb_change_buffer_max_size
配置选项将更改缓冲区的最大大小定义为总缓冲池大小的百分比。默认情况下，
innodb_change_buffer_max_size
设置为 25。最大设置为 50。
InnoDB如果操作会导致磁盘更改缓冲区超过定义的限制，则不会缓冲该操作。
更改缓冲页面不需要在缓冲池中持久存在，并且可能会被 LRU 操作逐出。
A.16.5。
如何确定更改缓冲区的当前大小？
更改缓冲区的当前大小由
标题SHOW ENGINE INNODB STATUS \G下的
报告。INSERT BUFFER AND ADAPTIVE HASH INDEX例如：
-------------------------------------
INSERT BUFFER AND ADAPTIVE HASH INDEX
-------------------------------------
Ibuf: size 1, free list len 0, seg size 2, 0 merges
相关数据点包括：
size：更改缓冲区中使用的页数。更改缓冲区大小等于seg
size - (1 + free list len)。该1
+值表示更改缓冲区标题页。
seg size：更改缓冲区的大小，以页为单位。
有关监视更改缓冲区状态的信息，请参阅
第 15.5.2 节，“更改缓冲区”。
A.16.6.
何时发生更改缓冲区合并？
当页面被读入缓冲池时，在页面可用之前，缓冲的更改会在读取完成后合并。
更改缓冲区合并作为后台任务执行。该
innodb_io_capacity
参数设置后台任务执行的 I/O 活动的上限，InnoDB例如合并更改缓冲区中的数据。
在崩溃恢复期间执行更改缓冲区合并。当索引页被读入缓冲池时，更改缓冲区（在系统表空间中）将更改应用于二级索引的叶页。
更改缓冲区是完全持久的，可以在系统崩溃时幸存下来。重新启动后，更改缓冲区合并操作将恢复为正常操作的一部分。
可以使用 强制更改缓冲区的完全合并作为缓慢服务器关闭的一部分
--innodb-fast-shutdown=0。
A.16.7。
何时刷新更改缓冲区？
更新的页面由刷新占用缓冲池的其他页面的相同刷新机制刷新。
A.16.8。
什么时候应该使用更改缓冲区？
更改缓冲区是一项功能，旨在在索引变大且不再适合InnoDB缓冲池时减少对二级索引的随机 I/O。通常，当整个数据集不适合缓冲池时，当存在修改二级索引页面的大量 DML 活动时，或者当有大量二级索引被 DML 活动定期更改时，应使用更改缓冲区。
A.16.9.
什么时候不应该使用更改缓冲区？
如果整个数据集都适合InnoDB缓冲池，如果您的二级索引相对较少，或者如果您使用的是固态存储，那么您可能会考虑禁用更改缓冲区，其中随机读取的速度与顺序读取的速度差不多。在进行配置更改之前，建议您使用具有代表性的工作负载运行测试，以确定禁用更改缓冲区是否有任何好处。
A.16.10。
我在哪里可以找到有关更改缓冲区的更多信息？
请参阅第 15.5.2 节，“更改缓冲区”。
© Mysql 中文网
