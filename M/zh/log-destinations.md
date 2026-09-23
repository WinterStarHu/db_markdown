# 5.4.1 选择通用查询日志和慢查询日志输出目的地_MySQL 8.0 参考手册

5.4.1 选择通用查询日志和慢查询日志输出目的地_MySQL 8.0 参考手册
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
5.2 MySQL数据目录
5.3 mysql系统架构
5.4 MySQL 服务器日志
5.4.1 选择通用查询日志和慢查询日志输出目的地1
5.4.2 错误日志1
5.4.3 一般查询日志1
5.4.4 二进制日志1
5.4.5 慢查询日志1
5.4.6 服务器日志维护1
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
MySQL 8.0 参考手册  / 第 5 章 MySQL 服务器管理  / 5.4 MySQL 服务器日志  /
5.4.1 选择通用查询日志和慢查询日志输出目的地
5.4.1 选择通用查询日志和慢查询日志输出目的地
如果启用了这些日志，则 MySQL 服务器可以灵活地控制写入一般查询日志和慢速查询日志的输出目的地。日志条目的可能目的地是日志文件或
系统数据库中general_log的
slow_log表。mysql可以选择文件输出、表格输出或两者。
服务器启动时的日志控制运行时的日志控制日志表的好处和特点
服务器启动时的日志控制
log_output系统变量指定日志输出的目的地
。设置这个变量本身并不会启用日志；它们必须单独启用。
如果log_output在启动时未指定，则默认日志记录目标为
FILE.
如果log_output在启动时指定，它的值是一个列表，一个或多个逗号分隔的单词，选自TABLE（记录到表）、
FILE（记录到文件）或
NONE（不记录到表或文件）。
NONE，如果存在，优先于任何其他说明符。
general_log系统变量控制记录到所选日志目标的一般查询日志
。如果在服务器启动时指定，
general_log则采用可选参数 1 或 0 来启用或禁用日志。要为文件记录指定默认文件名以外的文件名，请设置该
general_log_file变量。类似地，该slow_query_log
变量控制记录到所选目标的慢速查询日志，并且设置
slow_query_log_file指定用于文件记录的文件名。如果启用了任一日志，服务器将打开相应的日志文件并将启动消息写入其中。但是，不会进一步记录对文件的查询，除非FILE日志目的地被选中。
例子：
要将一般查询日志条目写入日志表和日志文件，请使用
--log_output=TABLE,FILE选择两个日志目标并
--general_log启用一般查询日志。
要仅将一般和慢速查询日志条目写入日志表，请使用
--log_output=TABLE选择表作为日志目标并
--general_log启用
--slow_query_log两个日志。
要仅将慢速查询日志条目写入日志文件，请使用
--log_output=FILE选择文件作为日志目标并
--slow_query_log启用慢速查询日志。在这种情况下，因为默认日志目的地是FILE，您可以省略该
log_output设置。
运行时的日志控制
与日志表和文件关联的系统变量启用对日志记录的运行时控制：
该log_output变量指示当前的日志记录目的地。它可以在运行时修改以更改目标。
和变量表示通用查询日志和慢查询日志是启用（general_log）
还是禁用（）。您可以在运行时设置这些变量来控制是否启用日志。
slow_query_logONOFFgeneral_log_file和
变量表示通用查询日志和慢查询日志文件
的slow_query_log_file
名称。您可以在服务器启动时或运行时设置这些变量以更改日志文件的名称。
要为当前会话禁用或启用常规查询日志记录，请将会话
sql_log_off变量设置为
ON或OFF。（这假定通用查询日志本身已启用。）
日志表的好处和特点
使用表进行日志输出具有以下好处：
日志条目具有标准格式。要显示日志表的当前结构，请使用以下语句：
SHOW CREATE TABLE mysql.general_log;
SHOW CREATE TABLE mysql.slow_log;
可以通过 SQL 语句访问日志内容。这使得可以使用仅选择那些满足特定条件的日志条目的查询。例如，要选择与特定客户端关联的日志内容（这对于识别来自该客户端的有问题的查询很有用），使用日志表比使用日志文件更容易做到这一点。
可以通过任何可以连接到服务器并发出查询（如果客户端具有适当的日志表权限）的客户端远程访问日志。无需登录服务器主机，直接访问文件系统。
日志表实现具有以下特点：
一般来说，日志表的主要目的是为用户提供一个接口来观察服务器的运行时执行情况，而不是干扰其运行时的执行。
CREATE TABLE、
ALTER TABLE和
DROP TABLE是对日志表的有效操作。对于ALTER
TABLE和DROP
TABLE，日志表不能在使用中，必须禁用，如后所述。
默认情况下，日志表使用CSV
以逗号分隔值格式写入数据的存储引擎。对于有权访问
.CSV包含日志表数据的文件的用户，这些文件很容易导入其他程序，例如可以处理 CSV 输入的电子表格。
可以更改日志表以使用
MyISAM存储引擎。您不能使用
ALTER TABLE来更改正在使用的日志表。必须先禁用日志。CSV对于日志表，除了或
之外没有任何引擎MyISAM是合法的。
日志表和“打开的文件太多”错误。
如果您选择TABLE作为日志目标并且日志表使用
CSV存储引擎，您可能会发现在运行时重复禁用和启用一般查询日志或慢速查询日志会导致文件的许多打开文件描述符.CSV，可能导致“打开的文件太多”
错误。要解决此问题，请执行
FLUSH
TABLES或确保 的值
open_files_limit大于 的值
table_open_cache_instances。
要禁用日志记录以便您可以更改（或删除）日志表，您可以使用以下策略。该示例使用通用查询日志；慢查询日志的过程类似，但使用slow_log表和slow_query_log系统变量。
SET @old_log_state = @@GLOBAL.general_log;
SET GLOBAL general_log = 'OFF';
ALTER TABLE mysql.general_log ENGINE = MyISAM;
SET GLOBAL general_log = @old_log_state;
TRUNCATE TABLE是对日志表的有效操作。它可用于使日志条目过期。
RENAME TABLE是对日志表的有效操作。您可以使用以下策略自动重命名日志表（例如，执行日志轮换）：
USE mysql;
DROP TABLE IF EXISTS general_log2;
CREATE TABLE general_log2 LIKE general_log;
RENAME TABLE general_log TO general_log_backup, general_log2 TO general_log;
CHECK TABLE是对日志表的有效操作。
LOCK TABLES不能在日志表上使用。
INSERT、
DELETE和
UPDATE不能用于日志表。这些操作只允许在服务器内部进行。
FLUSH TABLES WITH READ LOCK
并且
read_only系统变量的状态对日志表没有影响。服务器始终可以写入日志表。
写入日志表的条目不会写入二进制日志，因此不会复制到副本。
要刷新日志表或日志文件，请分别使用
FLUSH TABLES或
FLUSH LOGS。
不允许对日志表进行分区。
mysqldump转储包括重新创建这些表
的语句，以便在重新加载转储文件后它们不会丢失。不转储日志表内容。
© Mysql 中文网
