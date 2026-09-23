# 10.13.2 复杂字符集的字符串整理支持_MySQL 8.0 参考手册

10.13.2 复杂字符集的字符串整理支持_MySQL 8.0 参考手册
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
10.13.1 字符定义数组1
10.13.2 复杂字符集的字符串整理支持1
10.13.3 复杂字符集的多字节字符支持1
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
MySQL 8.0 参考手册  / 第 10 章字符集、排序规则、Unicode  / 10.13 添加字符集  /
10.13.2 复杂字符集的字符串整理支持
10.13.2 复杂字符集的字符串整理支持
对于名为 的简单字符集
MYSET，排序规则在MYSET.xml
配置文件中使用<map>元素内的数组元素指定<collation>。如果您的语言的排序规则太复杂而无法用简单的数组处理，则必须
在目录的源文件中定义字符串整理函数。
ctype-MYSET.cstrings
现有的字符集提供了最好的文档和示例来展示这些功能是如何实现的。查看目录ctype-*.c中的文件
strings，例如big5、czech、
gbk、sjis和
tis160字符集的文件。查看
MY_COLLATION_HANDLER结构以了解它们的使用方式。另请参阅目录中的
CHARSET_INFO.txt文件以
strings获取更多信息。
© Mysql 中文网
