# 7.3.3 备份策略总结_MySQL 8.0 参考手册

7.3.3 备份策略总结_MySQL 8.0 参考手册
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
7.1 备份和恢复类型
7.2 数据库备份方式
7.3 示例备份和恢复策略
7.3.1 建立备份策略1
7.3.2 使用备份进行恢复1
7.3.3 备份策略总结1
7.4 使用 mysqldump 进行备份
7.5 时间点（增量）恢复
7.6 MyISAM表维护和崩溃恢复
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
附录 B 错误信息和常见问题
附录 C 索引
MySQL 词汇表
MySQL 8.0 参考手册  / 第 7 章备份与恢复  / 7.3 示例备份和恢复策略  /
7.3.3 备份策略总结
7.3.3 备份策略总结
在操作系统崩溃或电源故障的情况下，
InnoDB它本身会完成所有恢复数据的工作。但要确保您睡得好，请遵守以下准则：
始终在启用二进制日志记录的情况下调整 MySQL 服务器（这是 MySQL 8.0 的默认设置）。如果您有这样安全的介质，这种技术也可以用于磁盘负载平衡（从而提高性能）。
使用前面
第 7.3.1 节“建立备份策略”中显示的mysqldump命令
进行定期完整备份，以
进行联机、非阻塞备份。
FLUSH LOGS通过使用或
mysqladmin flush-logs 刷新
日志来进行定期增量备份
。
© Mysql 中文网
