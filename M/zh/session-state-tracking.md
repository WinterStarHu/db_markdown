# 5.1.18 服务器跟踪客户端会话状态_MySQL 8.0 参考手册

5.1.18 服务器跟踪客户端会话状态_MySQL 8.0 参考手册
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
5.1 MySQL 服务器
5.1.1 配置服务器1
5.1.2 服务器配置默认值1
5.1.3 服务器配置验证1
5.1.4 服务器选项、系统变量、状态变量参考1
5.1.5 服务器系统变量引用1
5.1.6 服务器状态变量参考1
5.1.7 服务器命令选项1
5.1.8 服务器系统变量1
5.1.9 使用系统变量1
5.1.10 服务器状态变量1
5.1.11 服务器 SQL 模式1
5.1.12 连接管理1
5.1.13 IPv6 支持1
5.1.14 网络命名空间支持1
5.1.15 MySQL 服务器时区支持1
5.1.16 资源组1
5.1.17 服务器端帮助支持1
5.1.18 服务器跟踪客户端会话状态1
5.1.19 服务器关机流程1
5.2 MySQL数据目录
5.3 mysql系统架构
5.4 MySQL 服务器日志
5.5 MySQL组件
5.6 MySQL 服务器插件
5.7 MySQL 服务器可加载函数
5.8 在一台机器上运行多个MySQL实例
5.9 调试 MySQL
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
附录 B 错误信息和常见问题
附录 C 索引
MySQL 词汇表
MySQL 8.0 参考手册  / 第 5 章 MySQL 服务器管理  / 5.1 MySQL 服务器  /
5.1.18 服务器跟踪客户端会话状态
5.1.18 服务器跟踪客户端会话状态
MySQL 服务器实现了几个会话状态跟踪器。客户端可以启用这些跟踪器以接收其会话状态更改的通知。
用于会话状态跟踪器可用的会话状态跟踪器C API 会话状态跟踪器支持测试套件会话状态跟踪器支持
用于会话状态跟踪器
会话状态跟踪器有如下用途：
方便会话迁移。
方便交易切换。
跟踪器机制为 MySQL 连接器和客户端应用程序提供了一种方法，以确定是否有任何会话上下文可用于允许会话从一个服务器迁移到另一个服务器。（要在负载平衡的环境中更改会话，在决定是否可以进行切换时，有必要检测是否存在要考虑的会话状态。）
跟踪器机制允许应用程序知道事务何时可以从一个会话移动到另一个会话。事务状态跟踪可以实现这一点，这对于可能希望将事务从繁忙的服务器移动到负载较少的服务器的应用程序很有用。例如，管理客户端连接池的负载平衡连接器可以在池中的可用会话之间移动事务。
但是，会话切换不能在任意时间进行。如果会话正处于已完成读取或写入的事务的中间，则切换到不同的会话意味着事务回滚到原始会话。仅当事务尚未在其中执行任何读取或写入时，才必须执行会话切换。
何时可以合理切换交易的示例：
之后立马
START
TRANSACTION
后COMMIT AND
CHAIN
除了了解事务状态之外，了解事务特征也很有用，以便在事务移动到不同会话时使用相同的特征。以下特征与此目的相关：
READ ONLY
READ WRITE
ISOLATION LEVEL
WITH CONSISTENT SNAPSHOT
可用的会话状态跟踪器
为了支持会话跟踪活动，通知可用于以下类型的客户端会话状态信息：
更改客户端会话状态的这些属性：
默认架构（数据库）。
系统变量的会话特定值。
用户定义的变量。
临时表。
准备好的陈述。
系统变量控制这个
session_track_state_change
跟踪器。
对默认架构名称的更改。系统变量控制这个
session_track_schema跟踪器。
更改系统变量的会话值。系统变量控制这个
session_track_system_variables
跟踪器。需要该
SENSITIVE_VARIABLES_OBSERVER
权限才能跟踪对敏感系统变量值的更改。
可用的 GTID。系统变量控制这个
session_track_gtids跟踪器。
有关事务状态和特征的信息。系统变量控制这个
session_track_transaction_info
跟踪器。
有关跟踪器相关系统变量的说明，请参阅
第 5.1.8 节，“服务器系统变量”。这些系统变量允许控制发生哪些更改通知，但不提供访问通知信息的方法。通知发生在 MySQL 客户端/服务器协议中，它在 OK 数据包中包含跟踪器信息，以便可以检测到会话状态更改。
C API 会话状态跟踪器支持
为了使客户端应用程序能够从服务器返回的 OK 数据包中提取状态更改信息，MySQL C API 提供了一对函数：
mysql_session_track_get_first()
获取从服务器接收到的状态更改信息的第一部分。请参阅
mysql_session_track_get_first()。
mysql_session_track_get_next()
获取从服务器接收到的任何剩余状态更改信息。成功调用 后
mysql_session_track_get_first()，重复调用此函数，直到它返回成功。参见mysql_session_track_get_next()。
测试套件会话状态跟踪器支持
mysqltest程序具有
控制会话跟踪器通知是否发生的disable_session_track_info命令
。enable_session_track_info您可以使用这些命令从命令行查看 SQL 语句生成的通知。假设一个文件
testscript包含以下
mysqltest脚本：
DROP TABLE IF EXISTS test.t1;
CREATE TABLE test.t1 (i INT, f FLOAT);
--enable_session_track_info
SET @@SESSION.session_track_schema=ON;
SET @@SESSION.session_track_system_variables='*';
SET @@SESSION.session_track_state_change=ON;
USE information_schema;
SET NAMES 'utf8mb4';
SET @@SESSION.session_track_transaction_info='CHARACTERISTICS';
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;
SET TRANSACTION READ WRITE;
START TRANSACTION;
SELECT 1;
INSERT INTO test.t1 () VALUES();
INSERT INTO test.t1 () VALUES(1, RAND());
COMMIT;
按如下方式运行脚本以查看启用的跟踪器提供的信息。有关
mysqltest为各种跟踪器
Tracker:显示的信息
的描述，请参阅mysql_session_track_get_first()。
$> mysqltest < testscript
DROP TABLE IF EXISTS test.t1;
CREATE TABLE test.t1 (i INT, f FLOAT);
SET @@SESSION.session_track_schema=ON;
SET @@SESSION.session_track_system_variables='*';
-- Tracker : SESSION_TRACK_SYSTEM_VARIABLES
-- session_track_system_variables
-- *
SET @@SESSION.session_track_state_change=ON;
-- Tracker : SESSION_TRACK_SYSTEM_VARIABLES
-- session_track_state_change
-- ON
USE information_schema;
-- Tracker : SESSION_TRACK_SCHEMA
-- information_schema
-- Tracker : SESSION_TRACK_STATE_CHANGE
-- 1
SET NAMES 'utf8mb4';
-- Tracker : SESSION_TRACK_SYSTEM_VARIABLES
-- character_set_client
-- utf8mb4
-- character_set_connection
-- utf8mb4
-- character_set_results
-- utf8mb4
-- Tracker : SESSION_TRACK_STATE_CHANGE
-- 1
SET @@SESSION.session_track_transaction_info='CHARACTERISTICS';
-- Tracker : SESSION_TRACK_SYSTEM_VARIABLES
-- session_track_transaction_info
-- CHARACTERISTICS
-- Tracker : SESSION_TRACK_STATE_CHANGE
-- 1
-- Tracker : SESSION_TRACK_TRANSACTION_CHARACTERISTICS
--
-- Tracker : SESSION_TRACK_TRANSACTION_STATE
-- ________
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;
-- Tracker : SESSION_TRACK_TRANSACTION_CHARACTERISTICS
-- SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;
SET TRANSACTION READ WRITE;
-- Tracker : SESSION_TRACK_TRANSACTION_CHARACTERISTICS
-- SET TRANSACTION ISOLATION LEVEL SERIALIZABLE; SET TRANSACTION READ WRITE;
START TRANSACTION;
-- Tracker : SESSION_TRACK_TRANSACTION_CHARACTERISTICS
-- SET TRANSACTION ISOLATION LEVEL SERIALIZABLE; START TRANSACTION READ WRITE;
-- Tracker : SESSION_TRACK_TRANSACTION_STATE
-- T_______
SELECT 1;
1
1
-- Tracker : SESSION_TRACK_TRANSACTION_STATE
-- T_____S_
INSERT INTO test.t1 () VALUES();
-- Tracker : SESSION_TRACK_TRANSACTION_STATE
-- T___W_S_
INSERT INTO test.t1 () VALUES(1, RAND());
-- Tracker : SESSION_TRACK_TRANSACTION_STATE
-- T___WsS_
COMMIT;
-- Tracker : SESSION_TRACK_TRANSACTION_CHARACTERISTICS
--
-- Tracker : SESSION_TRACK_TRANSACTION_STATE
-- ________
ok
在START
TRANSACTION语句之前，执行两个SET
TRANSACTION语句来设置下一个事务的隔离级别和访问模式特征。该SESSION_TRACK_TRANSACTION_CHARACTERISTICS
值指示已设置的那些下一个事务值。
在COMMIT结束事务的语句之后，该
SESSION_TRACK_TRANSACTION_CHARACTERISTICS
值被报告为空。这表明在事务开始之前设置的下一个事务特征已被重置，并且会话默认值适用。要跟踪对这些会话默认值的更改，请跟踪
transaction_isolation和
transaction_read_only系统变量的会话值。
要查看有关 GTID 的信息，请
使用系统系统变量
启用SESSION_TRACK_GTIDS跟踪器
。session_track_gtids
© Mysql 中文网
