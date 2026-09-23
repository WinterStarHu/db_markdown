# 15.5.4 日志缓冲区_MySQL 8.0 参考手册

15.5.4 日志缓冲区_MySQL 8.0 参考手册
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
15.5.1 缓冲池1
15.5.2 更改缓冲区1
15.5.3 自适应哈希索引1
15.5.4 日志缓冲区1
15.6 InnoDB 磁盘结构
15.7 InnoDB 锁定和事务模型
15.8 InnoDB配置
15.9 InnoDB 表和页压缩
15.10 InnoDB 行格式
15.11 InnoDB磁盘I/O和文件空间管理
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
MySQL 8.0 参考手册  / 第 15 章 InnoDB 存储引擎  / 15.5 InnoDB 内存结构  /
15.5.4 日志缓冲区
15.5.4 日志缓冲区
日志缓冲区是存储要写入磁盘上日志文件的数据的内存区域。日志缓冲区大小由
innodb_log_buffer_size变量定义。默认大小为 16MB。日志缓冲区的内容会定期刷新到磁盘。大型日志缓冲区使大型事务无需在事务提交之前将重做日志数据写入磁盘即可运行。因此，如果您有更新、插入或删除许多行的事务，增加日志缓冲区的大小可以节省磁盘 I/O。
该
innodb_flush_log_at_trx_commit
变量控制日志缓冲区的内容如何写入和刷新到磁盘。该
innodb_flush_log_at_timeout
变量控制日志刷新频率。
有关相关信息，请参阅
内存配置和
第 8.5.4 节，“优化 InnoDB 重做日志记录”。
© Mysql 中文网
