# 11.4.1 空间数据类型_MySQL 8.0 参考手册

11.4.1 空间数据类型_MySQL 8.0 参考手册
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
11.1 数值数据类型
11.2 日期和时间数据类型
11.3 字符串数据类型
11.4 空间数据类型
11.4.1 空间数据类型1
11.4.2 OpenGIS 几何模型1
11.4.3 支持的空间数据格式1
11.4.4 几何的良构性和有效性1
11.4.5 空间参考系统支持1
11.4.6 创建空间柱1
11.4.7 填充空间列1
11.4.8 获取空间数据1
11.4.9 优化空间分析1
11.4.10 创建空间索引1
11.4.11 使用空间索引1
11.5 JSON数据类型
11.6 数据类型默认值
11.7 数据类型存储要求
11.8 为列选择正确的类型
11.9 使用来自其他数据库引擎的数据类型
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
MySQL 8.0 参考手册  / 第 11 章数据类型  / 11.4 空间数据类型  /
11.4.1 空间数据类型
11.4.1 空间数据类型
MySQL 具有对应于 OpenGIS 类的空间数据类型。这些类型的基础在
第 11.4.2 节“OpenGIS 几何模型”中进行了描述。
一些空间数据类型包含单个几何值：
GEOMETRY
POINT
LINESTRING
POLYGON
GEOMETRY可以存储任何类型的几何值。其他单值类型（POINT、
LINESTRING和POLYGON）将它们的值限制为特定的几何类型。
其他空间数据类型包含值的集合：
MULTIPOINT
MULTILINESTRING
MULTIPOLYGON
GEOMETRYCOLLECTION
GEOMETRYCOLLECTION可以存储任何类型的对象的集合。其他集合类型（MULTIPOINT、
MULTILINESTRING和
MULTIPOLYGON）将集合成员限制为具有特定几何类型的成员。
示例：要创建一个名为 的表，该表geom具有一个名为g可以存储任何几何类型的值的列，请使用以下语句：
CREATE TABLE geom (g GEOMETRY);
具有空间数据类型的列可以具有
SRID属性，以明确指示列中存储的值的空间参考系统 (SRS)。例如：
CREATE TABLE geom (
p POINT SRID 0,
g GEOMETRY NOT NULL SRID 4326
);
SPATIAL索引可以在空间列上创建，如果它们是NOT NULL并且具有特定的 SRID，因此如果您计划索引该列，请使用NOT NULL和SRID
属性声明它：
CREATE TABLE geom (g GEOMETRY NOT NULL SRID 4326);
InnoDB表允许SRID
笛卡尔和地理 SRS 的值。
MyISAM表允许SRID
笛卡尔 SRS 的值。
该SRID属性使空间列受 SRID 限制，这具有以下含义：
该列只能包含具有给定 SRID 的值。尝试插入具有不同 SRID 的值会产生错误。
优化器可以SPATIAL在列上使用索引。请参阅
第 8.3.3 节，“空间索引优化”。
SRID没有属性的
空间列不受 SRID 限制，并且接受具有任何 SRID 的值。但是，优化器不能SPATIAL在它们上使用索引，直到列定义被修改为包含一个
SRID属性，这可能需要首先修改列内容，以便所有值都具有相同的 SRID。
有关显示如何在 MySQL 中使用空间数据类型的其他示例，请参阅第 11.4.6 节，“创建空间列”。有关空间参考系统的信息，请参阅
第 11.4.5 节，“空间参考系统支持”。
© Mysql 中文网
