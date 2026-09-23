# 15.11.1 InnoDB 磁盘 I/O_MySQL 8.0 参考手册

15.11.1 InnoDB 磁盘 I/O_MySQL 8.0 参考手册
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
15.1 InnoDB简介
15.2 InnoDB 和 ACID 模型
15.3 InnoDB 多版本
15.4 InnoDB架构
15.5 InnoDB 内存结构
15.6 InnoDB 磁盘结构
15.7 InnoDB 锁定和事务模型
15.8 InnoDB配置
15.9 InnoDB 表和页压缩
15.10 InnoDB 行格式
15.11 InnoDB磁盘I/O和文件空间管理
15.11.1 InnoDB 磁盘 I/O1
15.11.2 文件空间管理1
15.11.3 InnoDB 检查点1
15.11.4 对表进行碎片整理1
15.11.5 使用 TRUNCATE TABLE 回收磁盘空间1
15.12 InnoDB和在线DDL
15.13 InnoDB静态数据加密
15.14 InnoDB 启动选项和系统变量
15.15 InnoDB INFORMATION_SCHEMA 表
15.16 InnoDB 与 MySQL 性能模式的集成
15.17 InnoDB 监视器
15.18 InnoDB备份与恢复
15.19 InnoDB和MySQL复制
15.20 InnoDB 内存缓存插件
15.21 InnoDB 故障排除
15.22 InnoDB 限制
15.23 InnoDB 限制和限制
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
MySQL 8.0 参考手册  / 第 15 章 InnoDB 存储引擎  / 15.11 InnoDB磁盘I/O和文件空间管理  /
15.11.1 InnoDB 磁盘 I/O
15.11.1 InnoDB 磁盘 I/O
InnoDB尽可能使用异步磁盘 I/O，通过创建多个线程来处理 I/O 操作，同时允许其他数据库操作在 I/O 仍在进行时继续进行。在 Linux 和 Windows 平台上，InnoDB使用可用的操作系统和库函数来执行“本机”异步 I/O。在其他平台上，InnoDB仍然使用 I/O 线程，但线程可能实际上等待 I/O 请求完成；这种技术被称为“模拟”
异步 I/O。
预读
如果InnoDB可以确定很快可能需要数据的可能性很高，它会执行预读操作以将该数据带入缓冲池，以便它在内存中可用。对连续数据发出几个大的读取请求比发出几个小的、分散的请求更有效。有两个预读启发式InnoDB：
在顺序预读中，如果InnoDB
注意到表空间中某个段的访问模式是顺序的，它会提前将一批数据库页面读取发送到 I/O 系统。
在随机预读中，如果InnoDB注意到表空间中的某些区域似乎正在被完全读入缓冲池，它会将剩余的读取发布到 I/O 系统。
有关配置预读启发式的信息，请参阅
第 15.8.3.4 节，“配置 InnoDB 缓冲池预取（预读）”。
双写缓冲区
InnoDB使用一种新颖的文件刷新技术，该技术涉及称为
双写缓冲区的结构，在大多数情况下默认启用 ( innodb_doublewrite=ON)。它增加了意外退出或断电后恢复的安全性，并通过减少fsync()操作需求提高了大多数 Unix 的性能。
在将页面写入数据文件之前，InnoDB
首先将它们写入一个称为双写缓冲区的存储区域。只有在对双写缓冲区的写入和刷新完成后，才会InnoDB将页面写入数据文件中的正确位置。如果在页面写入过程中出现操作系统、存储子系统或意外
的mysqld进程退出（导致页面撕裂
情况），InnoDB稍后可以在恢复期间从双写缓冲区中找到该页面的良好副本。
有关双写缓冲区的更多信息，请参阅
第 15.6.4 节，“双写缓冲区”。
© Mysql 中文网
