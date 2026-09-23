# 12.17.12 空间聚合函数_MySQL 8.0 参考手册

12.17.12 空间聚合函数_MySQL 8.0 参考手册
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
12.1 内置函数和操作符参考
12.2 可加载函数参考
12.3 表达式求值中的类型转换
12.4 运营商
12.5 流量控制函数
12.6 数值函数和运算符
12.7 日期和时间函数
12.8 字符串函数和运算符
12.9 MySQL 使用什么日历？
12.10 全文搜索功能
12.11 转换函数和运算符
12.12 XML函数
12.13 位函数和运算符
12.14 加密和压缩函数
12.15 锁定函数
12.16 信息函数
12.17空间分析函数
12.17.1 空间函数参考1
12.17.2 空间函数的参数处理1
12.17.3 从 WKT 值创建几何值的函数1
12.17.4 从 WKB 值创建几何值的函数1
12.17.5 创建几何值的 MySQL 特定函数1
12.17.6 几何格式转换函数1
12.17.7 几何属性函数1
12.17.8 空间算子函数1
12.17.9 测试几何对象之间空间关系的函数1
12.17.10 空间 Geohash 函数1
12.17.11 空间 GeoJSON 函数1
12.17.12 空间聚合函数1
12.17.13 空间便利功能1
12.18 JSON函数
12.19 与全局事务标识符（GTID）一起使用的函数
12.20聚合函数
12.21 窗口函数
12.22性能模式函数
12.23 内部函数
12.24 辅助功能
12.25 精密数学
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
MySQL 8.0 参考手册  / 第 12 章函数和运算符  / 12.17空间分析函数  /
12.17.12 空间聚合函数
12.17.12 空间聚合函数
MySQL 支持对一组值执行计算的聚合函数。有关这些函数的一般信息，请参阅
第 12.20.1 节，“聚合函数说明”。本节介绍
ST_Collect()空间聚合函数。
ST_Collect()可以用作窗口函数，如其语法描述中所示
，表示可选子句。
在
第 12.21.2 节“窗口函数概念和语法”中进行了描述，其中还包括有关窗口函数用法的其他信息。
[over_clause]OVERover_clause
ST_Collect([DISTINCT]
g)
[over_clause]
聚合几何值并返回单个几何集合值。使用该DISTINCT选项，返回不同几何参数的聚合。
与其他聚合函数一样，GROUP BY
可用于将参数分组到子集中。
ST_Collect()返回每个子集的聚合值。
over_clause如果存在，
此函数将作为窗口函数执行
。over_clause如
第 12.21.2 节，“窗口函数概念和语法”中所述。与大多数支持窗口化的聚合函数相比，
ST_Collect()允许与
over_clause一起使用
DISTINCT。
ST_Collect()如下处理其参数：
NULL参数被忽略。
如果所有参数都是NULL或聚合结果为空，则返回值为
NULL。
如果任何几何参数不是语法上格式正确的几何，
ER_GIS_INVALID_DATA则会发生错误。
如果任何几何参数是未定义空间参考系统 (SRS) 中语法上格式正确的几何，ER_SRS_NOT_FOUND则会发生错误。
如果有多个几何参数并且这些参数在同一个 SRS 中，则返回值在该 SRS 中。如果这些参数不在同一个 SRS 中，
ER_GIS_DIFFERENT_SRIDS_AGGREGATION
则会发生错误。
结果是最窄的
或
可能的值，结果类型由非几何参数确定，如下所示：
MultiXxxGeometryCollectionNULL
如果所有参数都是Point值，则结果是一个MultiPoint值。
如果所有参数都是LineString
值，则结果是一个
MultiLineString值。
如果所有参数都是Polygon
值，则结果是一个
MultiPolygon值。
否则，参数是几何类型的混合，结果是一个
GeometryCollection值。
此示例数据集按年份和制造地点显示了假设产品：
CREATE TABLE product (
year INTEGER,
product VARCHAR(256),
location Geometry
);
INSERT INTO product
(year,  product,     location) VALUES
(2000, "Calculator", ST_GeomFromText('point(60 -24)',4326)),
(2000, "Computer"  , ST_GeomFromText('point(28 -77)',4326)),
(2000, "Abacus"    , ST_GeomFromText('point(28 -77)',4326)),
(2000, "TV"        , ST_GeomFromText('point(38  60)',4326)),
(2001, "Calculator", ST_GeomFromText('point(60 -24)',4326)),
(2001, "Computer"  , ST_GeomFromText('point(28 -77)',4326));ST_Collect()在数据集上
使用的一些示例查询
：mysql> SELECT ST_AsText(ST_Collect(location)) AS result
FROM product;
+------------------------------------------------------------------+
| result                                                           |
+------------------------------------------------------------------+
| MULTIPOINT((60 -24),(28 -77),(28 -77),(38 60),(60 -24),(28 -77)) |
+------------------------------------------------------------------+
mysql> SELECT ST_AsText(ST_Collect(DISTINCT location)) AS result
FROM product;
+---------------------------------------+
| result                                |
+---------------------------------------+
| MULTIPOINT((60 -24),(28 -77),(38 60)) |
+---------------------------------------+
mysql> SELECT year, ST_AsText(ST_Collect(location)) AS result
FROM product GROUP BY year;
+------+------------------------------------------------+
| year | result                                         |
+------+------------------------------------------------+
| 2000 | MULTIPOINT((60 -24),(28 -77),(28 -77),(38 60)) |
| 2001 | MULTIPOINT((60 -24),(28 -77))                  |
+------+------------------------------------------------+
mysql> SELECT year, ST_AsText(ST_Collect(DISTINCT location)) AS result
FROM product GROUP BY year;
+------+---------------------------------------+
| year | result                                |
+------+---------------------------------------+
| 2000 | MULTIPOINT((60 -24),(28 -77),(38 60)) |
| 2001 | MULTIPOINT((60 -24),(28 -77))         |
+------+---------------------------------------+
# selects nothing
mysql> SELECT ST_Collect(location) AS result
FROM product WHERE year = 1999;
+--------+
| result |
+--------+
| NULL   |
+--------+
mysql> SELECT ST_AsText(ST_Collect(location)
OVER (ORDER BY year, product ROWS BETWEEN 1 PRECEDING AND CURRENT ROW))
AS result
FROM product;
+-------------------------------+
| result                        |
+-------------------------------+
| MULTIPOINT((28 -77))          |
| MULTIPOINT((28 -77),(60 -24)) |
| MULTIPOINT((60 -24),(28 -77)) |
| MULTIPOINT((28 -77),(38 60))  |
| MULTIPOINT((38 60),(60 -24))  |
| MULTIPOINT((60 -24),(28 -77)) |
+-------------------------------+
这个函数是在 MySQL 8.0.24 中添加的。
© Mysql 中文网
