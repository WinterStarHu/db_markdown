# 8.11.5 外部锁定_MySQL 8.0 参考手册

8.11.5 外部锁定_MySQL 8.0 参考手册
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
8.1 优化概述
8.2 优化SQL语句
8.3 优化和索引
8.4 优化数据库结构
8.5 优化 InnoDB 表
8.6 优化 MyISAM 表
8.7 优化 MEMORY 表
8.8 了解查询执行计划
8.9 控制查询优化器
8.10 缓冲和缓存
8.11 优化锁定操作
8.11.1 内部锁定方法1
8.11.2 表锁定问题1
8.11.3 并发插入1
8.11.4 元数据锁定1
8.11.5 外部锁定1
8.12 优化MySQL服务器
8.13 测量性能（基准测试）
8.14 查看服务器线程（进程）信息
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
MySQL 8.0 参考手册  / 第8章优化  / 8.11 优化锁定操作  /
8.11.5 外部锁定
8.11.5 外部锁定
外部锁定是使用文件系统锁定来管理MyISAM多个进程对数据库表的争用。外部锁定用于不能假定单个进程（例如 MySQL 服务器）是需要访问表的唯一进程的情况。这里有些例子：
如果您运行多个使用相同数据库目录的服务器（不推荐），则每个服务器都必须启用外部锁定。
如果使用myisamchk对表执行表维护操作
MyISAM，则必须确保服务器未运行，或者服务器启用了外部锁定，以便它根据需要锁定表文件以与myisamchk协调以
访问表。使用
myisampack打包
MyISAM表也是一样。
如果服务器在启用外部锁定的情况下运行，您可以随时使用myisamchk进行读取操作，例如检查表。在这种情况下，如果服务器尝试更新
myisamchk正在使用的表，则服务器会等待
myisamchk完成后再继续。
如果你使用myisamchk进行写操作，如修复或优化表，或者如果你使用
myisampack来打包表，你
必须始终确保
mysqld服务器没有使用该表。如果不停止mysqld，至少
在运行myisamchk之前执行
mysqladmin flush-tables。如果服务器和
myisamchk同时访问表，
您的表可能会损坏。
在外部锁定生效的情况下，每个需要访问表的进程都会在继续访问表之前为表文件获取文件系统锁。如果无法获取所有必要的锁，则进程将被阻止访问表，直到可以获取锁（在当前持有锁的进程释放它们之后）。
外部锁定会影响服务器性能，因为服务器有时必须等待其他进程才能访问表。
如果您运行单个服务器来访问给定的数据目录（这是通常的情况）并且在服务器运行时没有其他程序（如myisamchk ）需要修改表，则不需要外部锁定。如果您仅
使用其他程序读取表，则不需要外部锁定，但如果服务器在myisamchk读取
表时更改表， myisamchk
可能会报告警告
。
在禁用外部锁定的情况下，要使用
myisamchk ，您必须在myisamchk执行时停止服务器，或者在运行myisamchk之前锁定并刷新表。为避免此要求，请使用CHECK
TABLEandREPAIR TABLE
语句来检查和修复
MyISAM表。
对于mysqld，外部锁定由
skip_external_locking系统变量的值控制。启用此变量时，将禁用外部锁定，反之亦然。默认情况下禁用外部锁定。
可以在服务器启动时使用--external-locking或
--skip-external-locking
选项控制外部锁定的使用。
如果您确实使用外部锁定选项来启用
MyISAM来自许多 MySQL 进程的表更新，请不要在
delay_key_write系统变量设置为的情况下启动服务器，也不要对任何共享表ALL使用
DELAY_KEY_WRITE=1table 选项。否则，可能会发生索引损坏。
满足此条件的最简单方法是始终
--external-locking与一起使用
--delay-key-write=OFF。（默认情况下不会这样做，因为在许多设置中，混合使用上述选项很有用。）
© Mysql 中文网
