# 15.17.2 启用 InnoDB 监视器_MySQL 8.0 参考手册

15.17.2 启用 InnoDB 监视器_MySQL 8.0 参考手册
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
15.17.1 InnoDB 监视器类型1
15.17.2 启用 InnoDB 监视器1
15.17.3 InnoDB 标准监视器和锁定监视器输出1
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
MySQL 8.0 参考手册  / 第 15 章 InnoDB 存储引擎  / 15.17 InnoDB 监视器  /
15.17.2 启用 InnoDB 监视器
15.17.2 启用 InnoDB 监视器
当InnoDB为定期输出启用监视器时，大约每 15 秒
InnoDB将输出写入
mysqld服务器标准错误输出 ( )。stderr
InnoDB将监视器输出发送到
stderr而不是stdout
固定大小的内存缓冲区，以避免潜在的缓冲区溢出。
在 Windows上，stderr除非另有配置，否则定向到默认日志文件。如果要将输出定向到控制台窗口而不是错误日志，请使用
--console选项从控制台窗口中的命令提示符启动服务器。有关详细信息，请参阅
Windows 上的默认错误日志目标。
在 Unix 和类 Unix 系统上，stderr除非另有配置，否则通常指向终端。有关详细信息，请参阅
Unix 和类 Unix 系统上的默认错误日志目标。
InnoDB仅当您真正想要查看监视器信息时才应启用监视器，因为输出生成会导致一些性能下降。此外，如果将监视器输出定向到错误日志，那么如果您稍后忘记禁用监视器，日志可能会变得非常大。
笔记
为协助排除故障，在特定条件下InnoDB
暂时启用标准监视器输出。InnoDB有关详细信息，请参阅
第 15.21 节，“InnoDB 故障排除”。
InnoDB监视器输出以包含时间戳和监视器名称的标头开头。例如：
=====================================
2014-10-16 18:37:29 0x7fc2a95c1700 INNODB MONITOR OUTPUT
=====================================
标准InnoDBMonitor ( INNODB MONITOR OUTPUT) 的标头也用于 Lock Monitor，因为后者在添加额外的锁信息后产生相同的输出。
和系统变量用于启用标准
监视器和innodb_status_output锁定
监视器。
innodb_status_output_locksInnoDBInnoDB启用或禁用监视器
PROCESS需要权限
。InnoDB
启用标准 InnoDB 监视器
通过将系统变量设置为 来
启用标准InnoDB监视器。
innodb_status_outputONSET GLOBAL innodb_status_output=ON;
要禁用标准InnoDB监视器，请设置
innodb_status_output为
OFF。
当您关闭服务器时，该
innodb_status_output变量被设置为默认OFF值。
启用 InnoDB 锁定监视器
InnoDB锁定监视器数据与
InnoDB标准监视器输出一起打印。必须启用标准监视器和锁定监视器才能
定期
InnoDB打印
锁定监视器数据。
InnoDBInnoDB
要启用InnoDB锁定监视器，请将
innodb_status_output_locks系统变量设置为ON。必须启用标准监视器和锁定监视器才能
定期
InnoDB打印
锁定监视器数据：
InnoDBInnoDBSET GLOBAL innodb_status_output=ON;
SET GLOBAL innodb_status_output_locks=ON;
要禁用InnoDB锁定监视器，请设置
innodb_status_output_locks为
OFF。设置
innodb_status_output为
OFF也禁用
InnoDB标准监视器。
当您关闭服务器时，
innodb_status_output和
innodb_status_output_locks
变量将设置为默认OFF值。
笔记
要InnoDB为输出启用锁定监视器
SHOW ENGINE INNODB
STATUS，您只需要启用
innodb_status_output_locks.
获取标准 InnoDB Monitor 按需输出
作为
InnoDB为定期输出启用标准监视器的替代方法，您可以InnoDB使用 SQL 语句按需获取标准监视器输出，该SHOW ENGINE
INNODB STATUS语句将输出提取到您的客户端程序。如果您使用的是mysql
交互式客户端，如果您将通常的分号语句终止符替换为以下内容，则输出更具可读性\G：
mysql> SHOW ENGINE INNODB STATUS\G
SHOW ENGINE INNODB
STATUS如果启用了锁定监视器，
输出还包括InnoDB
锁定监视器数据。InnoDB
将标准 InnoDB 监视器输出定向到状态文件
通过在启动时指定选项，InnoDB可以启用
标准监视器输出并将其定向到状态文件。--innodb-status-file使用此选项时，InnoDB创建一个
在数据目录中命名的文件，并大约每 15 秒向其中写入一次输出。
innodb_status.pid
InnoDB服务器正常关闭时删除状态文件。如果发生异常关机，则可能必须手动删除状态文件。
该--innodb-status-file选项仅供临时使用，因为输出生成会影响性能，并且
文件会随着时间的推移变得非常大。
innodb_status.pid
© Mysql 中文网
