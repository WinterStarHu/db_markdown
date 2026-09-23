# 4.7.2 my_print_defaults — 显示选项文件中的选项_MySQL 8.0 参考手册

4.7.2 my_print_defaults — 显示选项文件中的选项_MySQL 8.0 参考手册
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
4.1 MySQL程序概述
4.2 使用 MySQL 程序
4.3 服务器和服务器启动程序
4.4 安装相关程序
4.5 客户端程序
4.6 管理和实用程序
4.7 程序开发实用程序
4.7.1 mysql_config——编译客户端的显示选项1
4.7.2 my_print_defaults — 显示选项文件中的选项1
4.8 杂项程序
4.9 环境变量
4.10 MySQL 中的 Unix 信号处理
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
第 28 章 MySQL 系统模式
第 29 章连接器和 API
第30章MySQL企业版
第31章MySQL工作台
第 32 章 OCI 市场上的 MySQL
附录 A MySQL 8.0 常见问题解答
附录 B 错误信息和常见问题
附录 C 索引
MySQL 词汇表
MySQL 8.0 参考手册  / 第 4 章 MySQL 程序  / 4.7 程序开发实用程序  /
4.7.2 my_print_defaults — 显示选项文件中的选项
4.7.2 my_print_defaults — 显示选项文件中的选项
my_print_defaults显示存在于选项文件的选项组中的选项。输出表明读取指定选项组的程序使用了哪些选项。例如，
mysqlcheck程序读取
[mysqlcheck]和[client]
选项组。要查看标准选项文件中这些组中存在哪些选项，请像这样调用
my_print_defaults：
$> my_print_defaults mysqlcheck client
--user=myusername
--password=password
--host=localhost
输出由选项组成，每行一个，以它们将在命令行上指定的形式出现。
my_print_defaults支持以下选项。
--help,
-?
显示帮助信息并退出。
--config-file=file_name,
,
--defaults-file=file_name-c file_name
只读给定的选项文件。
--debug=debug_options,
-# debug_options
写调试日志。典型的
debug_options字符串是
. 默认值为
。
d:t:o,file_named:t:o,/tmp/my_print_defaults.trace
--defaults-extra-file=file_name,
,
--extra-file=file_name-e file_name
在全局选项文件之后但（在 Unix 上）在用户选项文件之前读取此选项文件。
有关此选项和其他选项文件选项的其他信息，请参阅第 4.2.2.3 节，“影响选项文件处理的命令行选项”。
--defaults-group-suffix=suffix,
-g suffix
除了在命令行上命名的组之外，读取具有给定后缀的组。
有关此选项和其他选项文件选项的其他信息，请参阅第 4.2.2.3 节，“影响选项文件处理的命令行选项”。
--login-path=name,
-l name
从登录路径文件中指定的登录路径读取选项
.mylogin.cnf。“
登录路径”是一个选项组，其中包含指定要连接到哪个 MySQL 服务器以及要以哪个帐户进行身份验证的选项。要创建或修改登录路径文件，请使用
mysql_config_editor实用程序。请参阅
第 4.6.7 节，“mysql_config_editor — MySQL 配置实用程序”。
有关此选项和其他选项文件选项的其他信息，请参阅第 4.2.2.3 节，“影响选项文件处理的命令行选项”。
--no-defaults,
-n
返回一个空字符串。
有关此选项和其他选项文件选项的其他信息，请参阅第 4.2.2.3 节，“影响选项文件处理的命令行选项”。
--show,
-s
my_print_defaults默认屏蔽密码。使用此选项将密码显示为明文。
--verbose,
-v
详细模式。打印有关程序功能的更多信息。
--version,
-V
显示版本信息并退出。
© Mysql 中文网
