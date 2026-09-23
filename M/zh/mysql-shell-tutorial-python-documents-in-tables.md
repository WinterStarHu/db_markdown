# 20.4.5 表格中的文件_MySQL 8.0 参考手册

20.4.5 表格中的文件_MySQL 8.0 参考手册
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
20.1 MySQL文档存储的接口
20.2 文档存储概念
20.3 JavaScript 快速入门指南：用于文档存储的 MySQL Shell
20.4 Python 快速入门指南：用于文档存储的 MySQL Shell
20.4.1 MySQL 外壳1
20.4.2 下载导入world_x数据库1
20.4.3 文件和收藏1
20.4.4 关系表1
20.4.5 表格中的文件1
20.5 X 插件
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
MySQL 8.0 参考手册  / 第 20 章使用 MySQL 作为文档存储  / 20.4 Python 快速入门指南：用于文档存储的 MySQL Shell  /
20.4.5 表格中的文件
20.4.5 表格中的文件
在 MySQL 中，表可能包含传统的关系数据、JSON 值或两者。通过将文档存储在具有本机
JSON数据类型的列中，您可以将传统数据与 JSON 文档结合起来。
本节中的示例使用模式中的城市表
world_x。
city 表说明
city 表有五个列（或字段）。
+----------------+------------+--------+--------+---- -----+--------------------+
| 领域 | 类型 | 空 | 键 | 默认 | 额外 |
+----------------+------------+--------+--------+---- -----+--------------------+
| 编号 | 整数（11） | 否 | 优先级 | 空 | 自动递增 |
| 名称 | 字符（35） | 否 | | | |
| 国家代码 | 字符（3） | 否 | | | |
| 地区 | 字符（20） | 否 | | | |
| 资讯 | JSON | 是 | | 空 | |
+----------------+------------+--------+--------+---- -----+--------------------+
插入记录
要将文档插入表的列，请以
values()正确的顺序将格式良好的 JSON 文档传递给该方法。在以下示例中，文档作为最终值被传递到信息列中。
mysql-py> db.city.insert().values(
None, "San Francisco", "USA", "California", '{"Population":830000}')
选择一条记录
您可以发出带有搜索条件的查询，该搜索条件计算表达式中的文档值。
mysql-py> db.city.select(["ID", "Name", "CountryCode", "District", "Info"]).where(
"CountryCode = :country and Info->'$.Population' > 1000000").bind(
'country', 'USA')
+------+----------------+-------------+----------------+-----------------------------+
| ID   | Name           | CountryCode | District       | Info                        |
+------+----------------+-------------+----------------+-----------------------------+
| 3793 | New York       | USA         | New York       | {"Population": 8008278}     |
| 3794 | Los Angeles    | USA         | California     | {"Population": 3694820}     |
| 3795 | Chicago        | USA         | Illinois       | {"Population": 2896016}     |
| 3796 | Houston        | USA         | Texas          | {"Population": 1953631}     |
| 3797 | Philadelphia   | USA         | Pennsylvania   | {"Population": 1517550}     |
| 3798 | Phoenix        | USA         | Arizona        | {"Population": 1321045}     |
| 3799 | San Diego      | USA         | California     | {"Population": 1223400}     |
| 3800 | Dallas         | USA         | Texas          | {"Population": 1188580}     |
| 3801 | San Antonio    | USA         | Texas          | {"Population": 1144646}     |
+------+----------------+-------------+----------------+-----------------------------+
9 rows in set (0.01 sec)
相关信息
有关详细信息，请参阅
使用关系表和文档
。
有关数据类型的详细说明，请参阅第 11.5 节，“JSON 数据类型”。
© Mysql 中文网
