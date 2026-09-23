# 5.1.3 服务器配置验证_MySQL 8.0 参考手册

5.1.3 服务器配置验证_MySQL 8.0 参考手册
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
5.1.3 服务器配置验证
5.1.3 服务器配置验证
从 MySQL 8.0.16 开始，MySQL Server 支持一个
--validate-config选项，可以在不以正常操作模式运行服务器的情况下检查启动配置是否存在问题：
mysqld --validate-config
如果未发现任何错误，服务器将以退出代码 0 终止。如果发现错误，服务器将显示一条诊断消息并以退出代码 1 终止。例如：
$> mysqld --validate-config --no-such-option
2018-11-05T17:50:12.738919Z 0 [ERROR] [MY-000068] [Server] unknown
option '--no-such-option'.
2018-11-05T17:50:12.738962Z 0 [ERROR] [MY-010119] [Server] Aborting
一旦发现任何错误，服务器就会终止。要进行其他检查，请更正最初的问题并--validate-config
再次运行服务器。
对于前面的示例，
--validate-config在显示错误消息时使用 results，服务器退出代码为 1。也可能会显示警告和信息消息，具体取决于
log_error_verbosity值，但不会产生立即验证终止或退出代码 1 . 例如，此命令会产生多个警告，同时显示这两个警告。但没有发生错误，所以退出代码为 0：
$> mysqld --validate-config --log_error_verbosity=2
--read-only=s --transaction_read_only=s
2018-11-05T15:43:18.445863Z 0 [Warning] [MY-000076] [Server] option
'read_only': boolean value 's' was not recognized. Set to OFF.
2018-11-05T15:43:18.445882Z 0 [Warning] [MY-000076] [Server] option
'transaction-read-only': boolean value 's' was not recognized. Set to OFF.
此命令会产生相同的警告，但也会产生错误，因此错误消息会与警告一起显示，退出代码为 1：
$> mysqld --validate-config --log_error_verbosity=2
--no-such-option --read-only=s --transaction_read_only=s
2018-11-05T15:43:53.152886Z 0 [Warning] [MY-000076] [Server] option
'read_only': boolean value 's' was not recognized. Set to OFF.
2018-11-05T15:43:53.152913Z 0 [Warning] [MY-000076] [Server] option
'transaction-read-only': boolean value 's' was not recognized. Set to OFF.
2018-11-05T15:43:53.164889Z 0 [ERROR] [MY-000068] [Server] unknown
option '--no-such-option'.
2018-11-05T15:43:53.165053Z 0 [ERROR] [MY-010119] [Server] Aborting
该--validate-config
选项的范围仅限于服务器可以在不经过其正常启动过程的情况下执行的配置检查。因此，配置检查不会初始化存储引擎和其他插件、组件等，也不会验证与那些未初始化的子系统关联的选项。
--validate-config可以随时使用，但在升级后特别有用，用于检查升级后的服务器是否认为以前用于旧服务器的任何选项已弃用或过时。例如，tx_read_only系统变量在 MySQL 5.7 中被弃用，在 8.0 中被移除。假设 MySQL 5.7 服务器在其
my.cnf文件中使用该系统变量运行，然后升级到 MySQL 8.0。运行升级后的服务器
--validate-config以检查配置会产生以下结果：
$> mysqld --validate-config
2018-11-05T10:40:02.712141Z 0 [ERROR] [MY-000067] [Server] unknown variable
'tx_read_only=ON'.
2018-11-05T10:40:02.712178Z 0 [ERROR] [MY-010119] [Server] Aborting
--validate-config可以与--defaults-file选项一起使用以仅验证特定文件中的选项：
$> mysqld --defaults-file=./my.cnf-test --validate-config
2018-11-05T10:40:02.712141Z 0 [ERROR] [MY-000067] [Server] unknown variable
'tx_read_only=ON'.
2018-11-05T10:40:02.712178Z 0 [ERROR] [MY-010119] [Server] Aborting
请记住--defaults-file，如果指定，则必须是命令行上的第一个选项。（以相反的选项顺序执行前面的示例会产生一条
--defaults-file本身未知的消息。）
© Mysql 中文网
