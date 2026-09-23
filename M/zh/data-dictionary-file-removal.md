# 14.2 删除基于文件的元数据存储_MySQL 8.0 参考手册

14.2 删除基于文件的元数据存储_MySQL 8.0 参考手册
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
14.1 数据字典模式
14.2 删除基于文件的元数据存储
14.3 字典数据的事务存储
14.4 字典对象缓存
14.5 INFORMATION_SCHEMA 与数据字典集成
14.6 序列化词典信息（SDI）
14.7 数据字典使用差异
14.8 数据字典限制
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
MySQL 8.0 参考手册  / 第14章MySQL数据字典  /
14.2 删除基于文件的元数据存储
14.2 删除基于文件的元数据存储
在以前的 MySQL 版本中，字典数据部分存储在元数据文件中。基于文件的元数据存储的问题包括昂贵的文件扫描、对文件系统相关错误的敏感性、处理复制和崩溃恢复失败状态的复杂代码，以及缺乏可扩展性，这使得为新功能和关系对象添加元数据变得困难.
下面列出的元数据文件已从 MySQL 中删除。除非另有说明，否则以前存储在元数据文件中的数据现在存储在数据字典表中。
.frm文件：表元数据文件。随着.frm文件的删除：
.frm删除了文件结构
强加的 64KB 表定义大小限制
。
该列报告硬编码值，这是 MySQL 5.7 中使用的最后一个
文件版本。
INFORMATION_SCHEMA.TABLES
VERSION10.frm
.parfiles：分区定义文件。
InnoDB随着对表的本机分区支持的引入，在 MySQL 5.7 中停止使用分区定义文件InnoDB。
.TRNfiles：触发器命名空间文件。
.TRGfiles：触发参数文件。
.islfiles：InnoDB
符号链接文件，包含
在数据目录之外创建
的file-per-table 表空间文件的位置。
db.optfiles：数据库配置文件。这些文件（每个数据库目录一个）包含数据库默认字符集属性。
ddl_log.log文件：该文件包含由数据定义语句（如DROP TABLE
和）生成的元数据操作的记录ALTER TABLE。
© Mysql 中文网
