# 13.1.5 ALTER INSTANCE 语句_MySQL 8.0 参考手册

13.1.5 ALTER INSTANCE 语句_MySQL 8.0 参考手册
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
13.1 数据定义语句
13.1.1 原子数据定义语句支持1
13.1.2 ALTER DATABASE 语句1
13.1.3 ALTER EVENT 语句1
13.1.4 ALTER FUNCTION 语句1
13.1.5 ALTER INSTANCE 语句1
13.1.6 ALTER LOGFILE GROUP 语句1
13.1.7 ALTER PROCEDURE 语句1
13.1.8 ALTER SERVER 语句1
13.1.9 ALTER TABLE 语句1
13.1.10 ALTER TABLESPACE 语句1
13.1.11 ALTER VIEW 语句1
13.1.12 CREATE DATABASE 语句1
13.1.13 CREATE EVENT 语句1
13.1.14 CREATE FUNCTION 语句1
13.1.15 CREATE INDEX 语句1
13.1.16 CREATE LOGFILE GROUP 语句1
13.1.17 CREATE PROCEDURE 和 CREATE FUNCTION 语句1
13.1.18 CREATE SERVER 语句1
13.1.19 CREATE SPATIAL REFERENCE SYSTEM 语句1
13.1.20 CREATE TABLE 语句1
13.1.21 CREATE TABLESPACE 语句1
13.1.22 CREATE TRIGGER 语句1
13.1.23 CREATE VIEW 语句1
13.1.24 DROP DATABASE 语句1
13.1.25 DROP EVENT 语句1
13.1.26 DROP FUNCTION 语句1
13.1.27 DROP INDEX 语句1
13.1.28 DROP LOGFILE GROUP 语句1
13.1.29 DROP PROCEDURE 和 DROP FUNCTION 语句1
13.1.30 DROP SERVER 语句1
13.1.31 DROP SPATIAL REFERENCE SYSTEM 语句1
13.1.32 DROP TABLE 语句1
13.1.33 DROP TABLESPACE 语句1
13.1.34 DROP TRIGGER 语句1
13.1.35 DROP VIEW 语句1
13.1.36 RENAME TABLE 语句1
13.1.37 TRUNCATE TABLE 语句1
13.2 数据操作语句
13.3 事务和锁定语句
13.4 复制语句
13.5 准备好的语句
13.6 复合语句语法
13.7 数据库管理语句
13.8 效用语句
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
MySQL 8.0 参考手册  / 第 13 章 SQL 语句  / 13.1 数据定义语句  /
13.1.5 ALTER INSTANCE 语句
13.1.5 ALTER INSTANCE 语句
ALTER INSTANCE instance_action
instance_action: {
| {ENABLE|DISABLE} INNODB REDO_LOG
| ROTATE INNODB MASTER KEY
| ROTATE BINLOG MASTER KEY
| RELOAD TLS
[FOR CHANNEL {mysql_main | mysql_admin}]
[NO ROLLBACK ON ERROR]
| RELOAD KEYRING
}
ALTER INSTANCE定义适用于 MySQL 服务器实例的操作。该声明支持以下操作：
ALTER INSTANCE {ENABLE | DISABLE} INNODB
REDO_LOG
此操作启用或禁用InnoDB重做日志记录。默认情况下启用重做日志记录。此功能仅用于将数据加载到新的 MySQL 实例中。该语句未写入二进制日志。此操作是在 MySQL 8.0.21 中引入的。
警告
不要在生产系统上禁用重做日志记录。虽然在禁用重做日志记录时允许关闭和重新启动服务器，但在禁用重做日志记录时服务器意外停止可能会导致数据丢失和实例损坏。
一个ALTER
INSTANCE [ENABLE|DISABLE] INNODB REDO_LOG操作需要一个独占备份锁，它可以防止其他
ALTER INSTANCE操作并发执行。其他ALTER
INSTANCE操作必须等待锁释放后才能执行。
有关详细信息，请参阅
禁用重做日志记录。
ALTER INSTANCE ROTATE INNODB MASTER KEY
此操作轮换用于
InnoDB表空间加密的主加密密钥。密钥轮换需要
ENCRYPTION_KEY_ADMIN或
SUPER特权。要执行此操作，必须安装和配置密钥环插件。有关说明，请参阅第 6.4.4 节，“MySQL 密钥环”。
ALTER INSTANCE ROTATE INNODB MASTER KEY
支持并发 DML。但是，它不能与
CREATE TABLE ...
ENCRYPTIONor
ALTER TABLE ...
ENCRYPTION操作并发运行，并且采用锁定来防止并发执行这些语句可能引起的冲突。如果其中一个冲突语句正在运行，则它必须先完成，然后另一个语句才能继续。
ALTER INSTANCE ROTATE INNODB MASTER KEY
语句被写入二进制日志，以便它们可以在复制的服务器上执行。
有关其他ALTER INSTANCE ROTATE INNODB MASTER
KEY使用信息，请参阅
第 15.13 节，“InnoDB 静态数据加密”。
ALTER INSTANCE ROTATE BINLOG MASTER KEY
此操作轮换用于二进制日志加密的二进制日志主密钥。二进制日志主密钥的密钥轮换需要
BINLOG_ENCRYPTION_ADMIN或
SUPER权限。binlog_encryption如果系统变量设置为 ，则不能使用该语句
OFF。要执行此操作，必须安装和配置密钥环插件。有关说明，请参阅第 6.4.4 节，“MySQL 密钥环”。
ALTER INSTANCE ROTATE BINLOG MASTER KEY
操作不会写入二进制日志，也不会在副本上执行。因此，二进制日志主密钥轮换可以在包括 MySQL 版本混合的复制环境中执行。要在所有适用的源服务器和副本服务器上安排二进制日志主密钥的定期轮换，您可以在每个服务器上启用 MySQL Event Scheduler 并ALTER INSTANCE ROTATE BINLOG MASTER KEY
使用语句发出CREATE EVENT
语句。如果因为怀疑当前或任何以前的二进制日志主密钥可能已被泄露而轮换二进制日志主密钥，请在每个适用的源服务器和副本服务器上发出该语句，这使您能够立即验证合规性。
有关其他ALTER INSTANCE ROTATE BINLOG MASTER
KEY使用信息，包括如果进程未正确完成或被意外的服务器停止中断该怎么办，请参阅
第 17.3.2 节，“加密二进制日志文件和中继日志文件”。
ALTER INSTANCE RELOAD TLS
此操作根据定义上下文的系统变量的当前值重新配置 TLS 上下文。它还更新反映活动上下文值的状态变量。此操作需要
CONNECTION_ADMIN特权。有关重新配置 TLS 上下文的其他信息，包括哪些系统和状态变量与上下文相关，请参阅
服务器端运行时配置和监视加密连接。
默认情况下，该语句会重新加载主连接接口的 TLS 上下文。如果FOR CHANNEL
给出了子句（自 MySQL 8.0.21 起可用），则该语句会重新加载命名通道的 TLS 上下文：
mysql_main对于主连接接口，mysql_admin对于管理连接接口。有关不同接口的信息，请参阅
第 5.1.12.1 节，“连接接口”。更新后的 TLS 上下文属性在性能模式
tls_channel_status表中公开。请参阅
第 27.12.21.8 节，“tls_channel_status 表”。
更新主接口的 TLS 上下文也可能影响管理接口，因为除非为该接口配置了一些非默认 TLS 值，否则它使用与主接口相同的 TLS 上下文。
笔记
当您重新加载 TLS 上下文时，OpenSSL 会重新加载包含 CRL（证书撤销列表）的文件作为该过程的一部分。如果 CRL 文件很大，服务器会分配一大块内存（文件大小的十倍），在加载新实例而旧实例尚未释放时内存会加倍。释放大量分配后，进程驻留内存不会立即减少，因此如果您ALTER INSTANCE RELOAD
TLS使用大型 CRL 文件重复发出该语句，进程驻留内存使用量可能会因此增加。
默认情况下，RELOAD TLS如果配置值不允许创建新的 TLS 上下文，则该操作会返回错误并且无效。以前的上下文值继续用于新连接。如果给出了可选NO ROLLBACK ON
ERROR子句并且无法创建新上下文，则不会发生回滚。相反，会生成一条警告，并为应用该语句的接口上的新连接禁用加密。
ALTER INSTANCE RELOAD TLS语句不会写入二进制日志（因此不会被复制）。TLS 配置是本地的，取决于不一定存在于所有相关服务器上的本地文件。
ALTER INSTANCE RELOAD KEYRING
如果安装了密钥环组件，此操作会告诉组件重新读取其配置文件并重新初始化任何密钥环内存数据。如果您在运行时修改组件配置，则新配置只有在您执行此操作后才会生效。密钥环重新加载需要
ENCRYPTION_KEY_ADMIN权限。此操作是在 MySQL 8.0.24 中添加的。
此操作仅允许重新配置当前安装的密钥环组件。它不允许更改安装的组件。例如，如果您更改已安装密钥环组件的配置，ALTER
INSTANCE RELOAD KEYRING会使新配置生效。另一方面，如果您更改服务器清单文件中命名的密钥环组件，
ALTER INSTANCE RELOAD KEYRING
则不会产生任何影响，并且当前组件仍然安装。
ALTER INSTANCE RELOAD KEYRING语句不会写入二进制日志（因此不会被复制）。
© Mysql 中文网
