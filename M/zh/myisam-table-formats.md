# 16.2.3 MyISAM 表存储格式_MySQL 8.0 参考手册

16.2.3 MyISAM 表存储格式_MySQL 8.0 参考手册
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
16.1 设置存储引擎
16.2 MyISAM 存储引擎
16.2.1 MyISAM 启动选项1
16.2.2 按键所需空间1
16.2.3 MyISAM 表存储格式1
16.2.3.1 静态（定长）表特征
16.2.3.2 动态表特性
16.2.3.3 压缩表特征
16.2.4 MyISAM 表问题1
16.3 MEMORY存储引擎
16.4 CSV存储引擎
16.5 ARCHIVE存储引擎
16.6 BLACKHOLE存储引擎
16.7 MERGE存储引擎
16.8 联合存储引擎
16.9 示例存储引擎
16.10 其他存储引擎
16.11 MySQL存储引擎架构概述
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
MySQL 8.0 参考手册  / 第 16 章替代存储引擎  / 16.2 MyISAM 存储引擎  /
16.2.3 MyISAM 表存储格式
16.2.3 MyISAM 表存储格式
16.2.3.1 静态（定长）表特征16.2.3.2 动态表特性16.2.3.3 压缩表特征
MyISAM支持三种不同的存储格式。其中两种，固定格式和动态格式，是根据您使用的列类型自动选择的。第三种压缩格式只能使用
myisampack实用程序创建（请参阅
第 4.6.6 节“myisampack — 生成压缩的只读 MyISAM 表”）。
当您将CREATE TABLEor
ALTER TABLE用于没有
BLOBor
列的表时，您可以使用
table 选项
TEXT强制将表格式设置为FIXEDor
。DYNAMICROW_FORMAT有关的信息
，
请参阅第 13.1.20 节，“CREATE TABLE 语句”ROW_FORMAT。
您可以使用myisamchk
解压缩（解压缩）压缩MyISAM
表；有关详细信息，请参阅
第 4.6.4 节，“myisamchk — MyISAM 表维护实用程序”。
--unpack
© Mysql 中文网
