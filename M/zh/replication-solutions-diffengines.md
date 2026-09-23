# 17.4.4 使用不同源和副本存储引擎的复制_MySQL 8.0 参考手册

17.4.4 使用不同源和副本存储引擎的复制_MySQL 8.0 参考手册
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
第十七章复制
17.1 配置复制
17.2 复制实现
17.3 复制安全
17.4 复制解决方案
17.4.1 使用复制进行备份1
17.4.2 处理副本的意外停止1
17.4.3 监控基于行的复制1
17.4.4 使用不同源和副本存储引擎的复制1
17.4.5 使用复制进行横向扩展1
17.4.6 将不同的数据库复制到不同的副本1
17.4.7 提高复制性能1
17.4.8 在故障转移期间切换源1
17.4.9 使用异步连接故障转移切换源和副本1
17.4.10 半同步复制1
17.4.11 延迟复制1
17.5 复制注意事项和技巧
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
MySQL 8.0 参考手册  / 第十七章复制  / 17.4 复制解决方案  /
17.4.4 使用不同源和副本存储引擎的复制
17.4.4 使用不同源和副本存储引擎的复制
对于复制过程来说，源上的原始表和副本上的复制表是否使用不同的存储引擎类型无关紧要。事实上，
default_storage_engine系统变量并没有被复制。
这在复制过程中提供了许多好处，因为您可以针对不同的复制场景利用不同的引擎类型。例如，在典型的横向扩展场景中（请参阅
第 17.4.5 节，“使用复制进行横向扩展”），您希望使用
InnoDB源上的表来利用事务功能，但
MyISAM在事务所在的副本上使用不需要支持，因为仅读取数据。在数据记录环境中使用复制时，您可能希望
Archive在副本上使用存储引擎。
在源和副本上配置不同的引擎取决于您如何设置初始复制过程：
如果您使用mysqldump在源上创建数据库快照，则可以编辑转储文件文本以更改每个表上使用的引擎类型。
mysqldump的
另一种替代方法是在使用转储在副本上构建数据之前禁用不想在副本上使用的引擎类型。例如，您可以
--skip-federated
在副本上添加选项以禁用
FEDERATED引擎。如果要创建的表不存在特定引擎，则 MySQL 使用默认引擎类型，通常是InnoDB. （这要求
NO_ENGINE_SUBSTITUTION未启用 SQL 模式。）如果您想以这种方式禁用其他引擎，您可能需要考虑构建一个特殊的二进制文件以用于仅支持所需引擎的副本。
如果您使用原始数据文件（二进制备份）来设置副本，则无法更改初始表格式。相反，用于ALTER
TABLE在副本启动后更改表类型。
对于当前在源上没有表的新源/副本复制设置，避免在创建新表时指定引擎类型。
如果您已经在运行复制解决方案并希望将现有表转换为另一种引擎类型，请执行以下步骤：
停止副本运行复制更新：
mysql> STOP SLAVE;
Or from MySQL 8.0.22:
mysql> STOP REPLICA;
这使得可以不间断地更改引擎类型。
为每个要更改的表
执行一个。ALTER TABLE ...
ENGINE='engine_type'
再次开始复制过程：
mysql> START SLAVE;
或者，从 MySQL 8.0.22 开始：
mysql> START REPLICA;
尽管
default_storage_engine未复制该变量，但请注意包含引擎规范的CREATE
TABLE和ALTER TABLE
语句已正确复制到副本。如果在
CSV表的情况下，您执行此语句：
mysql> ALTER TABLE csvtable ENGINE='MyISAM';
此声明被复制；副本上表的引擎类型将转换为InnoDB，即使您之前已将副本上的表类型更改为 以外的引擎CSV。如果要保留源和副本上的引擎差异，则default_storage_engine
在创建新表时应小心使用源上的变量。例如，而不是：
mysql> CREATE TABLE tablea (columna int) Engine=MyISAM;
使用这种格式：
mysql> SET default_storage_engine=MyISAM;
mysql> CREATE TABLE tablea (columna int);
复制时，该
default_storage_engine变量将被忽略，CREATE TABLE
语句将使用副本的默认引擎在副本上执行。
© Mysql 中文网
