# 14.6 序列化词典信息（SDI）_MySQL 8.0 参考手册

14.6 序列化词典信息（SDI）_MySQL 8.0 参考手册
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
14.6 序列化词典信息（SDI）
14.6 序列化词典信息（SDI）
除了在数据字典中存储关于数据库对象的元数据外，MySQL 还以序列化的形式存储它。此数据称为序列化字典信息 (SDI)。
InnoDB将 SDI 数据存储在其表空间文件中。NDBCLUSTER将 SDI 数据存储在 NDB 字典中。其他存储引擎将 SDI 数据存储
.sdi在为表的数据库目录中的给定表创建的文件中。SDI 数据以紧凑JSON格式生成。
序列化字典信息 (SDI) 存在于
InnoDB除临时表空间和撤消表空间文件之外的所有表空间文件中。表空间文件中的 SDI 记录
InnoDB仅描述表空间中包含的表和表空间对象。
SDI 数据由表或
CHECK TABLE FOR
UPGRADE. 当 MySQL 服务器升级到新版本或版本时，SDI 数据不会更新。
SDI 数据的存在提供了元数据冗余。例如，如果数据字典变得不可用，则可以使用ibd2sdi工具
直接从InnoDB
表空间文件中提取对象元数据。
对于InnoDB，SDI 记录需要单个索引页，默认情况下大小为 16KB。但是，SDI 数据经过压缩以减少存储占用空间。
对于InnoDB由多个表空间组成的分区表，SDI 数据存储在第一个分区的表空间文件中。
MySQL 服务器使用在DDL操作
期间访问的内部 API
来创建和维护 SDI 记录。
该IMPORT TABLE语句
MyISAM根据文件中包含的信息导入表
.sdi。有关详细信息，请参阅
第 13.2.5 节，“IMPORT TABLE 语句”。
© Mysql 中文网
