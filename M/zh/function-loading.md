# 5.7.1 安装和卸载可加载函数_MySQL 8.0 参考手册

5.7.1 安装和卸载可加载函数_MySQL 8.0 参考手册
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
5.7.1 安装和卸载可加载函数1
5.7.2 获取有关可加载函数的信息1
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
MySQL 8.0 参考手册  / 第 5 章 MySQL 服务器管理  / 5.7 MySQL 服务器可加载函数  /
5.7.1 安装和卸载可加载函数
5.7.1 安装和卸载可加载函数
可加载函数，顾名思义，必须加载到服务器中才能使用。MySQL 支持在服务器启动时自动加载函数，然后手动加载。
加载可加载函数时，有关它的信息可用，如
第 5.7.2 节“获取有关可加载函数的信息”中所述。
安装可加载函数卸载可加载函数重新安装或升级可加载函数
安装可加载函数
要手动加载可加载函数，请使用该
CREATE
FUNCTION语句。例如：
CREATE FUNCTION metaphon
RETURNS STRING
SONAME 'udf_example.so';
文件基本名称取决于您的平台。通用后缀
.so用于 Unix 和类 Unix 系统，
.dll用于 Windows。
CREATE
FUNCTION具有以下效果：
它将函数加载到服务器中以使其立即可用。
它在系统表中注册该函数，
mysql.func以使其在服务器重启后保持不变。为此，
CREATE
FUNCTION需要
系统数据库
的INSERT权限
。mysql
它将函数添加到 Performance Schema
user_defined_functions表中，该表提供有关已安装可加载函数的运行时信息。请参阅
第 5.7.2 节，“获取有关可加载函数的信息”。
可加载函数的自动加载发生在正常的服务器启动序列中：
mysql.func
安装表中
注册的功能。
启动时安装的组件或插件可能会自动安装相关功能。
自动功能安装将功能添加到性能模式
user_defined_functions表中，该表提供有关已安装功能的运行时信息。
如果服务器以该
--skip-grant-tables选项启动，则mysql.func表中注册的功能不会加载且不可用。这不适用于组件或插件自动安装的功能。
卸载可加载函数
要删除可加载函数，请使用该
DROP
FUNCTION语句。例如：
DROP FUNCTION metaphon;
DROP
FUNCTION具有以下效果：
它卸载函数以使其不可用。
它从
mysql.func系统表中删除函数。为此，
DROP
FUNCTION需要
系统数据库的DELETE权限
。mysql由于该函数不再在mysql.func
表中注册，服务器在随后的重新启动期间不会加载该函数。
它从 Performance Schema 表中删除该函数，该
user_defined_functions表提供有关已安装可加载函数的运行时信息。
DROP
FUNCTION不能用于删除由组件或插件自动安装的可加载函数，而不是使用
CREATE
FUNCTION. 当安装它的组件或插件被卸载时，这样的功能也会自动删除。
重新安装或升级可加载函数
要重新安装或升级与可加载函数关联的共享库，请发出
DROP
FUNCTION语句，升级共享库，然后发出
CREATE
FUNCTION语句。如果先升级共享库再使用
DROP
FUNCTION，服务器可能会意外关闭。
© Mysql 中文网
