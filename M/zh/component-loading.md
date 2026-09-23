# 5.5.1 安装和卸载组件_MySQL 8.0 参考手册

5.5.1 安装和卸载组件_MySQL 8.0 参考手册
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
5.5.1 安装和卸载组件1
5.5.2 获取组件信息1
5.5.3 错误日志组件1
5.5.4 查询属性组件1
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
MySQL 8.0 参考手册  / 第 5 章 MySQL 服务器管理  / 5.5 MySQL组件  /
5.5.1 安装和卸载组件
5.5.1 安装和卸载组件
组件必须先加载到服务器才能使用。MySQL 支持在运行时手动加载组件和在服务器启动时自动加载。
加载组件时，有关它的信息可用，如第 5.5.2 节“获取组件信息”中所述。
和SQL 语句启用组件加载和卸载INSTALL COMPONENT。
UNINSTALL COMPONENT例如：
INSTALL COMPONENT 'file://component_validate_password';
UNINSTALL COMPONENT 'file://component_validate_password';
加载器服务处理组件的加载和卸载，并在
mysql.component系统表中注册加载的组件。
组件操作的SQL语句影响服务器运行和mysql.component系统表如下：
INSTALL COMPONENT将组件加载到服务器中。组件立即激活。加载程序服务还在mysql.component系统表中注册加载的组件。对于后续的服务器重新启动，加载程序服务会加载
mysql.component在启动序列中列出的任何组件。即使服务器以该
--skip-grant-tables选项启动，也会发生这种情况。
UNINSTALL COMPONENT停用组件并从服务器卸载它们。加载程序服务还从
mysql.component系统表中取消注册组件，以便服务器在其启动序列期间不再加载它们以进行后续重新启动。
与INSTALL
PLUGIN服务器插件的相应声明
相比INSTALL COMPONENT，组件声明提供了显着的优势，即无需知道任何特定于平台的文件名后缀即可命名组件。这意味着给定的
INSTALL COMPONENT语句可以跨平台统一执行。
组件在安装时也可能会自动安装相关的可加载功能。如果是这样，组件在卸载时也会自动卸载这些功能。
© Mysql 中文网
