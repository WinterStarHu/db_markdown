# 5.1.1 配置服务器_MySQL 8.0 参考手册

5.1.1 配置服务器_MySQL 8.0 参考手册
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
5.1.1 配置服务器
5.1.1 配置服务器
MySQL 服务器mysqld有许多命令选项和系统变量，可以在启动时设置它们以配置其操作。要确定服务器使用的默认命令选项和系统变量值，请执行以下命令：
$> mysqld --verbose --help
该命令生成所有mysqld
选项和可配置系统变量的列表。它的输出包括默认选项和变量值，看起来像这样：
abort-slave-event-count           0
allow-suspicious-udfs             FALSE
archive                           ON
auto-increment-increment          1
auto-increment-offset             1
autocommit                        TRUE
automatic-sp-privileges           TRUE
avoid-temporal-upgrade            FALSE
back-log                          80
basedir                           /home/jon/bin/mysql-8.0/
...
tmpdir                            /tmp
transaction-alloc-block-size      8192
transaction-isolation             REPEATABLE-READ
transaction-prealloc-size         4096
transaction-read-only             FALSE
transaction-write-set-extraction  XXHASH64
updatable-views-with-limit        YES
validate-user-plugins             TRUE
verbose                           TRUE
wait-timeout                      28800
要查看服务器在运行时实际使用的当前系统变量值，请连接到它并执行以下语句：
mysql> SHOW VARIABLES;
要查看正在运行的服务器的一些统计和状态指示器，请执行以下语句：
mysql> SHOW STATUS;
系统变量和状态信息也可以使用
mysqladmin命令获得：
$> mysqladmin variables
$> mysqladmin extended-status
有关所有命令选项、系统变量和状态变量的完整描述，请参阅以下部分：
第 5.1.7 节，“服务器命令选项”
第 5.1.8 节，“服务器系统变量”
第 5.1.10 节，“服务器状态变量”
Performance Schema 提供了更详细的监控信息；参见第 27 章，MySQL 性能模式。此外，MySQL sysschema 是一组对象，可以方便地访问 Performance Schema 收集的数据；参见第 28 章，MySQL 系统模式。
如果您在命令行上为
mysqld或mysqld_safe指定一个选项，它仅对服务器的调用有效。要在每次服务器运行时使用该选项，请将其放入选项文件中。请参见第 4.2.2.2 节，“使用选项文件”。
© Mysql 中文网
