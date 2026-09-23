# 5.9.2 调试 MySQL 客户端_MySQL 8.0 参考手册

5.9.2 调试 MySQL 客户端_MySQL 8.0 参考手册
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
5.5 MySQL组件
5.6 MySQL 服务器插件
5.7 MySQL 服务器可加载函数
5.8 在一台机器上运行多个MySQL实例
5.9 调试 MySQL
5.9.1 调试 MySQL 服务器1
5.9.2 调试 MySQL 客户端1
5.9.3 LOCK_ORDER 工具1
5.9.4 DBUG 包1
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
MySQL 8.0 参考手册  / 第 5 章 MySQL 服务器管理  / 5.9 调试 MySQL  /
5.9.2 调试 MySQL 客户端
5.9.2 调试 MySQL 客户端
为了能够使用集成调试包调试 MySQL 客户端，您应该使用
-DWITH_DEBUG=1. 请参阅
第 2.9.7 节，“MySQL 源配置选项”。
在运行客户端之前，您应该设置
MYSQL_DEBUG环境变量：
$> MYSQL_DEBUG=d:t:O,/tmp/client.trace
$> export MYSQL_DEBUG
这会导致客户端以
/tmp/client.trace.
如果您自己的客户端代码有问题，您应该尝试连接到服务器并使用已知可以工作的客户端运行您的查询。通过在调试模式下运行mysql来执行此操作（假设您已在调试模式下编译 MySQL）：
$> mysql --debug=d:t:O,/tmp/client.trace
如果您邮寄错误报告，这会提供有用的信息。请参阅第 1.6 节，“如何报告错误或问题”。
如果您的客户端在某些看起来“合法”的代码处崩溃，您应该检查您的mysql.h包含文件是否与您的 MySQL 库文件相匹配。一个非常常见的错误是将
mysql.h来自旧 MySQL 安装的旧文件与新 MySQL 库一起使用。
© Mysql 中文网
