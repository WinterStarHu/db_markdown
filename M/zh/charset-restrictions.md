# 10.11 字符集限制_MySQL 8.0 参考手册

10.11 字符集限制_MySQL 8.0 参考手册
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
MySQL 8.0 参考手册  / 第 10 章字符集、排序规则、Unicode  /
10.11 字符集限制
10.11 字符集限制
标识符使用 存储在mysql数据库表（user、db等）中utf8mb3，但标识符只能包含基本多语言平面 (BMP) 中的字符。标识符中不允许使用增补字符。
、ucs2、utf16和
字符utf16le集utf32
具有以下限制：
它们都不能用作客户端字符集。请参阅
不允许的客户端字符集。
目前无法使用
LOAD DATA加载使用这些字符集的数据文件。
FULLTEXT不能在使用这些字符集的列上创建索引。但是，您可以IN BOOLEAN MODE在没有索引的列上执行搜索。
REGEXPand
运算符
以RLIKE
字节方式工作，因此它们不是多字节安全的，并且可能会在多字节字符集上产生意外结果。此外，这些运算符通过字符的字节值和重音字符比较字符可能不相等，即使给定的排序规则将它们视为相等。
© Mysql 中文网
