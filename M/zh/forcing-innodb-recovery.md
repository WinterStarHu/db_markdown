# 15.21.3 强制 InnoDB 恢复_MySQL 8.0 参考手册

15.21.3 强制 InnoDB 恢复_MySQL 8.0 参考手册
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
15.13 InnoDB静态数据加密
15.14 InnoDB 启动选项和系统变量
15.15 InnoDB INFORMATION_SCHEMA 表
15.16 InnoDB 与 MySQL 性能模式的集成
15.17 InnoDB 监视器
15.18 InnoDB备份与恢复
15.19 InnoDB和MySQL复制
15.20 InnoDB 内存缓存插件
15.21 InnoDB 故障排除
15.21.1 排除 InnoDB I/O 问题1
15.21.2 故障排除恢复失败1
15.21.3 强制 InnoDB 恢复1
15.21.4 InnoDB 数据字典操作故障排除1
15.21.5 InnoDB 错误处理1
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
MySQL 8.0 参考手册  / 第 15 章 InnoDB 存储引擎  / 15.21 InnoDB 故障排除  /
15.21.3 强制 InnoDB 恢复
15.21.3 强制 InnoDB 恢复
要调查数据库页面损坏，您可以使用
SELECT ... INTO
OUTFILE. 通常，以这种方式获得的大部分数据都是完整的。严重的损坏可能会导致语句或
后台操作意外退出或断言，甚至导致
前滚恢复崩溃。在这种情况下，您可以使用该
选项强制启动存储引擎，同时阻止后台操作运行，以便您可以转储表。例如，您可以在重新启动服务器之前将以下行添加到选项文件的部分：
SELECT * FROM
tbl_nameInnoDBInnoDBinnodb_force_recoveryInnoDB[mysqld][mysqld]
innodb_force_recovery = 1
有关使用选项文件的信息，请参阅
第 4.2.2.2 节，“使用选项文件”。
警告
仅innodb_force_recovery
在紧急情况下设置为大于 0 的值，以便您可以启动InnoDB和转储表。这样做之前，请确保您有数据库的备份副本，以防需要重新创建它。4 或更大的值会永久损坏数据文件。innodb_force_recovery在您成功测试数据库的单独物理副本上的设置后，仅在生产服务器实例上使用
4 或更大的设置。强制InnoDB恢复时，您应该始终从该值开始，
innodb_force_recovery=1并且只在必要时逐步增加该值。
innodb_force_recovery默认为0（正常启动不强制恢复）。允许的非零值为
innodb_force_recovery1 到 6。较大的值包括较小值的功能。例如，值 3 包括值 1 和 2 的所有功能。
如果您能够转储
innodb_force_recovery值为 3 或更小的表，那么您相对安全，因为只有损坏的单个页面上的一些数据会丢失。值 4 或更大被认为是危险的，因为数据文件可能会永久损坏。值 6 被认为是极端的，因为数据库页面处于过时状态，这反过来可能会给B 树
和其他数据库结构带来更多损坏。
作为一项安全措施，当大于 0时，会InnoDB阻止
INSERT、
UPDATE或
DELETE操作
。在只读模式下
设置 4 个或更多位置。innodb_force_recoveryinnodb_force_recoveryInnoDB
1
( SRV_FORCE_IGNORE_CORRUPT)
让服务器运行，即使它检测到一个损坏的
页面。尝试
跳过损坏的索引记录和页面，这有助于转储表。
SELECT * FROM
tbl_name
2
( SRV_FORCE_NO_BACKGROUND)
防止主线程和任何清除线程运行。如果在清除操作期间发生意外退出，此恢复值将阻止它。
3
( SRV_FORCE_NO_TRX_UNDO)
崩溃恢复后
不运行事务
回滚。
4
( SRV_FORCE_NO_IBUF_MERGE)
防止插入缓冲区合并操作。如果它们会导致崩溃，则不执行它们。不计算表
统计信息。此值可能会永久损坏数据文件。使用此值后，准备删除并重新创建所有二级索引。设置
InnoDB为只读。
5
( SRV_FORCE_NO_UNDO_LOG_SCAN)
启动数据库时
不查看撤消日志InnoDB：甚至将未完成的事务视为已提交。此值可能会永久损坏数据文件。设置InnoDB为只读。
6
( SRV_FORCE_NO_LOG_REDO)
不执行与恢复相关的重做日志
前滚。此值可能会永久损坏数据文件。使数据库页面处于过时状态，这反过来可能会给 B 树和其他数据库结构带来更多损坏。设置
InnoDB为只读。
您可以SELECT从表中转储它们。如果
innodb_force_recovery值为 3 或更小，您可以DROP或
CREATE表格。DROP
TABLE也支持
innodb_force_recovery大于 3的值。DROP TABLE不允许
innodb_force_recovery大于 4 的值。
如果您知道给定的表在回滚时导致意外退出，您可以将其删除。如果您遇到由失败的批量导入或 引起的失控回滚ALTER
TABLE，您可以终止 mysqld
进程并设置
innodb_force_recovery为
3在不回滚的情况下启动数据库，然后DROP启动导致失控回滚的表。
如果表数据中的损坏阻止您转储整个表内容，则带有子句的查询可能能够转储损坏部分之后的表部分。
ORDER BY
primary_key DESC
如果需要高innodb_force_recovery
值来启动InnoDB，则可能存在损坏的数据结构，这些结构可能导致复杂查询（包含WHERE、ORDER
BY或其他子句的查询）失败。在这种情况下，您可能只能运行基本SELECT * FROM t
查询。
© Mysql 中文网
