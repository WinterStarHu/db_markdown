# 5.9.1 调试 MySQL 服务器_MySQL 8.0 参考手册

5.9.1 调试 MySQL 服务器_MySQL 8.0 参考手册
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
5.9.1.1 编译MySQL调试
5.9.1.2 创建跟踪文件
5.9.1.3 将 WER 与 PDB 结合使用来创建 Windows 崩溃转储
5.9.1.4 在gdb下调试mysqld
5.9.1.5 使用堆栈跟踪
5.9.1.6 使用服务器日志查找mysqld错误原因
5.9.1.7 遇到表损坏时创建测试用例
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
5.9.1 调试 MySQL 服务器
5.9.1 调试 MySQL 服务器
5.9.1.1 编译MySQL调试5.9.1.2 创建跟踪文件5.9.1.3 将 WER 与 PDB 结合使用来创建 Windows 崩溃转储5.9.1.4 在gdb下调试mysqld5.9.1.5 使用堆栈跟踪5.9.1.6 使用服务器日志查找mysqld错误原因5.9.1.7 遇到表损坏时创建测试用例
如果您正在使用 MySQL 中一些非常新的功能，您可以尝试使用该
选项运行mysqld--skip-new（它会禁用所有新的、可能不安全的功能）。请参阅
第 B.3.3.3 节，“如果 MySQL 持续崩溃怎么办”。
如果mysqld不想启动，请确认没有my.cnf干扰设置的文件！您可以使用mysqld --print-defaults检查您的my.cnf
参数，并从mysqld --no-defaults ...开始避免使用它们。
如果mysqld开始耗尽 CPU 或内存，或者如果它“挂起” ，您可以使用mysqladmin processlist status来查明是否有人正在执行需要很长时间的查询。如果您遇到性能问题或新客户端无法连接的问题，那么在某个窗口
中运行mysqladmin -i10 processlist status可能是个好主意
。
命令mysqladmin debug将一些有关正在使用的锁、已用内存和查询使用情况的信息转储到 MySQL 日志文件中。这可能有助于解决一些问题。这个命令也提供了一些有用的信息，即使你还没有编译 MySQL 进行调试！
如果问题是某些表变得越来越慢，您应该尝试使用
OPTIMIZE TABLE或
myisamchk优化表。请参阅
第 5 章，MySQL 服务器管理。您还应该使用检查慢速查询EXPLAIN。
您还应该阅读本手册中特定于操作系统的部分，了解您的环境可能独有的问题。请参见
第 2.1 节，“一般安装指南”。
© Mysql 中文网
