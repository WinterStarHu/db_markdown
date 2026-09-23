# 27.12.21 性能模式杂表_MySQL 8.0 参考手册

27.12.21 性能模式杂表_MySQL 8.0 参考手册
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
27.1 性能模式快速入门
27.2 性能模式构建配置
27.3 性能模式启动配置
27.4 性能模式运行时配置
27.5 性能模式查询
27.6 性能模式工具命名约定
27.7 性能模式状态监控
27.8 性能模式原子和分子事件
27.9 当前和历史事件的性能模式表
27.10 性能模式语句摘要和采样
27.11 性能模式总表特征
27.12 性能模式表描述
27.12.1 性能模式表参考1
27.12.2 性能模式设置表1
27.12.3 性能模式实例表1
27.12.4 性能模式等待事件表1
27.12.5 性能模式阶段事件表1
27.12.6 性能模式语句事件表1
27.12.7 性能模式事务表1
27.12.8 性能模式连接表1
27.12.9 性能模式连接属性表1
27.12.10 性能模式用户定义的变量表1
27.12.11 性能模式复制表1
27.12.12 Performance Schema NDB 集群表1
27.12.13 性能模式锁表1
27.12.14 性能模式系统变量表1
27.12.15 性能模式状态变量表1
27.12.16 性能模式线程池表1
27.12.17 性能模式防火墙表1
27.12.18 性能模式密钥环表1
27.12.19 性能模式克隆表1
27.12.20 性能模式汇总表1
27.12.21 性能模式杂表1
27.12.21.1 error_log 表
27.12.21.2 host_cache 表
27.12.21.3 innodb_redo_log_files 表
27.12.21.4 log_status 表
27.12.21.5 performance_timers 表
27.12.21.6 进程表
27.12.21.7 线程表
27.12.21.8 tls_channel_status 表
27.12.21.9 user_defined_functions 表
27.13 性能模式选项和变量引用
27.14 性能模式命令选项
27.15 性能模式系统变量
27.16 性能模式状态变量
27.17性能模式内存分配模型
27.18 性能模式和插件
27.19 使用性能模式诊断问题
27.20 性能模式的限制
第 28 章 MySQL 系统模式
第 29 章连接器和 API
第30章MySQL企业版
第31章MySQL工作台
第 32 章 OCI 市场上的 MySQL
附录 A MySQL 8.0 常见问题解答
附录 B 错误信息和常见问题
附录 C 索引
MySQL 词汇表
MySQL 8.0 参考手册  / 第 27 章 MySQL 性能模式  / 27.12 性能模式表描述  /
27.12.21 性能模式杂表
27.12.21 性能模式杂表
27.12.21.1 error_log 表27.12.21.2 host_cache 表27.12.21.3 innodb_redo_log_files 表27.12.21.4 log_status 表27.12.21.5 performance_timers 表27.12.21.6 进程表27.12.21.7 线程表27.12.21.8 tls_channel_status 表27.12.21.9 user_defined_functions 表
以下部分描述了不属于前面部分中讨论的表类别的表：
error_log：写入错误日志的最新事件。
host_cache：来自内部主机缓存的信息。
innodb_redo_log_files：有关 InnoDB 重做日志文件的信息。
log_status：有关用于备份目的的服务器日志的信息。
performance_timers：哪些事件计时器可用。
processlist：有关服务器进程的信息。
threads：有关服务器线程的信息。
tls_channel_status：连接接口的 TLS 上下文属性。
user_defined_functions: 由组件、插件或
CREATE
FUNCTION语句注册的可加载函数。
© Mysql 中文网
