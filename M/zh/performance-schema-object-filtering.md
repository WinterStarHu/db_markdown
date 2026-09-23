# 27.4.5 按对象预过滤_MySQL 8.0 参考手册

27.4.5 按对象预过滤_MySQL 8.0 参考手册
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
27.1 性能模式快速入门
27.2 性能模式构建配置
27.3 性能模式启动配置
27.4 性能模式运行时配置
27.4.1 性能模式事件时序1
27.4.2 性能模式事件过滤1
27.4.3 事件预过滤1
27.4.4 按仪器预过滤1
27.4.5 按对象预过滤1
27.4.6 按线程预过滤1
27.4.7 消费者预过滤1
27.4.8 消费者配置示例1
27.4.9 过滤操作的命名工具或消费者1
27.4.10 确定检测的是什么1
27.5 性能模式查询
27.6 性能模式工具命名约定
27.7 性能模式状态监控
27.8 性能模式原子和分子事件
27.9 当前和历史事件的性能模式表
27.10 性能模式语句摘要和采样
27.11 性能模式总表特征
27.12 性能模式表描述
27.13 性能模式选项和变量引用
27.14 性能模式命令选项
27.15 性能模式系统变量
27.16 性能模式状态变量
27.17性能模式内存分配模型
27.18 性能模式和插件
27.19 使用性能模式诊断问题
27.20 性能模式的限制
第 28 章 MySQL 系统模式
第 29 章连接器和 API
第30章MySQL企业版
第31章MySQL工作台
第 32 章 OCI 市场上的 MySQL
附录 A MySQL 8.0 常见问题解答
附录 B 错误信息和常见问题
附录 C 索引
MySQL 词汇表
MySQL 8.0 参考手册  / 第 27 章 MySQL 性能模式  / 27.4 性能模式运行时配置  /
27.4.5 按对象预过滤
27.4.5 按对象预过滤
该setup_objects表控制性能模式是否监视特定的表和存储的程序对象。初始
setup_objects内容如下所示：
mysql> SELECT * FROM performance_schema.setup_objects;
+-------------+--------------------+-------------+---------+-------+
| OBJECT_TYPE | OBJECT_SCHEMA      | OBJECT_NAME | ENABLED | TIMED |
+-------------+--------------------+-------------+---------+-------+
| EVENT       | mysql              | %           | NO      | NO    |
| EVENT       | performance_schema | %           | NO      | NO    |
| EVENT       | information_schema | %           | NO      | NO    |
| EVENT       | %                  | %           | YES     | YES   |
| FUNCTION    | mysql              | %           | NO      | NO    |
| FUNCTION    | performance_schema | %           | NO      | NO    |
| FUNCTION    | information_schema | %           | NO      | NO    |
| FUNCTION    | %                  | %           | YES     | YES   |
| PROCEDURE   | mysql              | %           | NO      | NO    |
| PROCEDURE   | performance_schema | %           | NO      | NO    |
| PROCEDURE   | information_schema | %           | NO      | NO    |
| PROCEDURE   | %                  | %           | YES     | YES   |
| TABLE       | mysql              | %           | NO      | NO    |
| TABLE       | performance_schema | %           | NO      | NO    |
| TABLE       | information_schema | %           | NO      | NO    |
| TABLE       | %                  | %           | YES     | YES   |
| TRIGGER     | mysql              | %           | NO      | NO    |
| TRIGGER     | performance_schema | %           | NO      | NO    |
| TRIGGER     | information_schema | %           | NO      | NO    |
| TRIGGER     | %                  | %           | YES     | YES   |
+-------------+--------------------+-------------+---------+-------+
对表的修改setup_objects
会立即影响对象监控。
该OBJECT_TYPE列指示行适用的对象类型。TABLE
过滤会影响表 I/O 事件 ( wait/io/table/sql/handlerinstrument) 和表锁定事件 ( wait/lock/table/sql/handlerinstrument)。
和列应包含文字模式或对象名称，或OBJECT_SCHEMA匹配
任何名称。
OBJECT_NAME'%'
该ENABLED列表示是否监控匹配对象，TIMED表示是否收集定时信息。设置
TIMED列会影响 Performance Schema 表内容，如
第 27.4.1 节，“Performance Schema Event Timing”中所述。
默认对象配置的效果是检测除 、 和 数据库中的对象之外的mysql所有
INFORMATION_SCHEMA对象
performance_schema。（
INFORMATION_SCHEMA无论 的内容如何，​​都不会检测数据库中的
表setup_objects；该行
information_schema.%只是明确显示了此默认值。）
当 Performance Schema 检查中的匹配项时
setup_objects，它会首先尝试找到更具体的匹配项。对于匹配给定的行
OBJECT_TYPE，性能模式按以下顺序检查行：
行
与
。
OBJECT_SCHEMA='literal'OBJECT_NAME='literal'
行
与。
OBJECT_SCHEMA='literal'OBJECT_NAME='%'
行OBJECT_SCHEMA='%'与
OBJECT_NAME='%'。
例如，对于一个表db1.t1，Performance Schema 在行中查找和TABLE的匹配项，然后是和，然后是和。匹配发生的顺序很重要，因为不同的匹配行可以有不同的
值。
'db1''t1''db1''%''%''%'setup_objectsENABLEDTIMED
对于表相关的事件，Performance Schema结合setup_objectswith
的内容setup_instruments来判断是否启用instruments以及是否对启用的instruments进行计时：
对于与 中的行匹配的表，
setup_objects只有
在和
ENABLED中YES都
存在时，表工具才会产生事件。
setup_instrumentssetup_objects
两个表中的TIMED值合并在一起，因此仅当两个值都为 时才收集时序信息YES。
对于存储的程序对象，性能模式
直接从行中获取ENABLED和列
。没有值与 的组合
。
TIMEDsetup_objectssetup_instruments
假设包含适用于
、和
setup_objects的以下行：
TABLEdb1db2db3+-------------+---------------+-------------+---------+-------+
| OBJECT_TYPE | OBJECT_SCHEMA | OBJECT_NAME | ENABLED | TIMED |
+-------------+---------------+-------------+---------+-------+
| TABLE       | db1           | t1          | YES     | YES   |
| TABLE       | db1           | t2          | NO      | NO    |
| TABLE       | db2           | %           | YES     | YES   |
| TABLE       | db3           | %           | NO      | NO    |
| TABLE       | %             | %           | YES     | YES   |
+-------------+---------------+-------------+---------+-------+
如果与对象相关的工具 in
setup_instruments的
ENABLED值为NO，则不会监视该对象的事件。如果
ENABLED值为，则根据相关
行
中YES的值进行事件监听
：ENABLEDsetup_objects
db1.t1事件被监控
db1.t2事件不受监控
db2.t3事件被监控
db3.t4事件不受监控
db4.t5事件被监控
类似的逻辑适用于组合
和表中的TIMED
列以确定是否收集事件计时信息。
setup_instrumentssetup_objects
如果持久表和临时表具有相同的名称，则两者对行的匹配setup_objects方式相同。不可能只对一个表启用监视而对另一个表不启用监视。但是，每个表都是单独检测的。
© Mysql 中文网
