# 10.3.2 服务器字符集和排序规则_MySQL 8.0 参考手册

10.3.2 服务器字符集和排序规则_MySQL 8.0 参考手册
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
10.1 一般字符集和排序规则
10.2 MySQL 中的字符集和排序规则
10.3 指定字符集和归类
10.3.1 归类命名约定1
10.3.2 服务器字符集和排序规则1
10.3.3 数据库字符集和排序规则1
10.3.4 表字符集和排序规则1
10.3.5 列字符集和排序规则1
10.3.6 字符串文字字符集和排序规则1
10.3.7 国家字符集1
10.3.8 字符集介绍者1
10.3.9 字符集和归类分配示例1
10.3.10 与其他 DBMS 的兼容性1
10.4 连接字符集和排序规则
10.5 配置应用程序字符集和排序规则
10.6 错误信息字符集
10.7 列字符集转换
10.8 整理问题
10.9 Unicode 支持
10.10 支持的字符集和归类
10.11 字符集限制
10.12 设置错误信息语言
10.13 添加字符集
10.14 向字符集添加归类
10.15 字符集配置
10.16 MySQL 服务器语言环境支持
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
MySQL 8.0 参考手册  / 第 10 章字符集、排序规则、Unicode  / 10.3 指定字符集和归类  /
10.3.2 服务器字符集和排序规则
10.3.2 服务器字符集和排序规则
MySQL 服务器有一个服务器字符集和一个服务器排序规则。默认情况下，它们是utf8mb4和
utf8mb4_0900_ai_ci，但它们可以在服务器启动时在命令行或选项文件中显式设置，并在运行时更改。
最初，服务器字符集和排序规则取决于您在启动mysqld时使用的选项。您可以使用
--character-set-server字符集。连同它，您可以添加
--collation-server排序规则。如果不指定字符集，则与
--character-set-server=utf8mb4. 如果您仅指定字符集（例如，
utf8mb4）而不指定排序规则，则与说
因为是默认排序规则相同。因此，以下三个命令都具有相同的效果：
--character-set-server=utf8mb4
--collation-server=utf8mb4_0900_ai_ciutf8mb4_0900_ai_ciutf8mb4mysqld
mysqld --character-set-server=utf8mb4
mysqld --character-set-server=utf8mb4 \
--collation-server=utf8mb4_0900_ai_ci
更改设置的一种方法是重新编译。要在从源构建时更改默认服务器字符集和排序规则，请使用CMakeDEFAULT_CHARSET的
和DEFAULT_COLLATION选项
。例如：
cmake . -DDEFAULT_CHARSET=latin1
或者：
cmake . -DDEFAULT_CHARSET=latin1 \
-DDEFAULT_COLLATION=latin1_german1_ci
mysqld和CMake都会
验证字符集/归类组合是否有效。否则，每个程序都会显示一条错误消息并终止。
CREATE DATABASE
如果语句
中没有指定数据库字符集和排序规则，则使用服务器字符集和排序规则作为默认值。他们没有其他目的。
当前服务器字符集和排序规则可以从
character_set_server和
collation_server系统变量的值中确定。这些变量可以在运行时更改。
© Mysql 中文网
