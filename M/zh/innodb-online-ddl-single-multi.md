# 15.12.6 使用在线 DDL 简化 DDL 语句_MySQL 8.0 参考手册

15.12.6 使用在线 DDL 简化 DDL 语句_MySQL 8.0 参考手册
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
15.12 InnoDB和在线DDL
15.12.1 在线DDL操作1
15.12.2 在线 DDL 性能和并发1
15.12.3 在线 DDL 空间要求1
15.12.4 在线DDL内存管理1
15.12.5 为在线 DDL 操作配置并行线程1
15.12.6 使用在线 DDL 简化 DDL 语句1
15.12.7 在线 DDL 失败条件1
15.12.8 在线 DDL 限制1
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
MySQL 8.0 参考手册  / 第 15 章 InnoDB 存储引擎  / 15.12 InnoDB和在线DDL  /
15.12.6 使用在线 DDL 简化 DDL 语句
15.12.6 使用在线 DDL 简化 DDL 语句
在引入在线 DDL之前，通常的做法是将许多 DDL 操作组合到一条ALTER TABLE
语句中。因为每个ALTER TABLE
语句都涉及复制和重建表，所以一次对同一个表进行多项更改会更有效，因为这些更改都可以通过对表进行一次重建操作来完成。缺点是涉及 DDL 操作的 SQL 代码更难维护和在不同的脚本中重用。如果每次的具体变化都不同，您可能必须ALTER
TABLE为每个略有不同的场景构建一个新的复合体。
对于可以在线完成的 DDL 操作，您可以将它们分成单独ALTER TABLE
的语句，以便于编写脚本和维护，而不会牺牲效率。例如，您可能会采用如下复杂的语句：
ALTER TABLE t1 ADD INDEX i1(c1), ADD UNIQUE INDEX i2(c2),
CHANGE c4_old_name c4_new_name INTEGER UNSIGNED;
并将其分解为可以独立测试和执行的更简单的部分，例如：
ALTER TABLE t1 ADD INDEX i1(c1);
ALTER TABLE t1 ADD UNIQUE INDEX i2(c2);
ALTER TABLE t1 CHANGE c4_old_name c4_new_name INTEGER UNSIGNED NOT NULL;
您可能仍将多部分ALTER
TABLE语句用于：
必须按特定顺序执行的操作，例如创建索引后跟使用该索引的外键约束。
操作都使用相同的特定LOCK
子句，您希望作为一个组成功或失败。
不能在线进行的操作，即仍然使用table-copy方式的操作。
您指定
ALGORITHM=COPY或
的操作old_alter_table=1，以在需要时强制执行表复制行为，以便在特殊情况下实现精确的向后兼容性。
© Mysql 中文网
