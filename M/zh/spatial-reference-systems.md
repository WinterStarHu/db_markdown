# 11.4.5 空间参考系统支持_MySQL 8.0 参考手册

11.4.5 空间参考系统支持_MySQL 8.0 参考手册
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
11.4.5 空间参考系统支持
11.4.5 空间参考系统支持
空间数据的空间参考系统 (SRS) 是一种基于坐标的地理位置系统。
有不同类型的空间参考系统：
投影 SRS 是地球仪在平面上的投影；即平面地图。例如，地球仪内的灯泡照亮地球仪周围的纸筒，将地图投射到纸上。结果是地理参考的：每个点映射到地球上的一个地方。该平面上的坐标系是使用长度单位（米、英尺等）而不是经度和纬度的笛卡尔坐标系。
在这种情况下，球体是椭圆体；也就是说，扁平的球体。地球的南北轴比东西轴短一点，所以略微扁平的球体更正确，但完美的球体允许更快的计算。
地理 SRS 是一种非投影 SRS，以任何角度单位表示椭圆体上的经度-纬度（或纬度-经度）坐标。
在 MySQL 中由 SRID 0 表示的 SRS 表示一个无限平坦的笛卡尔平面，其轴没有分配单位。与投影的 SRS 不同，它没有地理参考，也不一定代表地球。它是一个可以用于任何事物的抽象平面。SRID 0 是 MySQL 中空间数据的默认 SRID。
MySQL 在数据字典表中维护有关空间数据的可用空间参考系统的信息，该
mysql.st_spatial_reference_systems表可以存储投影和地理 SRS 的条目。此数据字典表是不可见的，但 SRS 条目内容可通过INFORMATION_SCHEMA
ST_SPATIAL_REFERENCE_SYSTEMS表获得，实现为视图
mysql.st_spatial_reference_systems（请参阅
第 26.3.36 节，“INFORMATION_SCHEMA ST_SPATIAL_REFERENCE_SYSTEMS 表”）。
以下示例显示了 SRS 条目的外观：
mysql> SELECT *
FROM INFORMATION_SCHEMA.ST_SPATIAL_REFERENCE_SYSTEMS
WHERE SRS_ID = 4326\G
*************************** 1. row ***************************
SRS_NAME: WGS 84
SRS_ID: 4326
ORGANIZATION: EPSG
ORGANIZATION_COORDSYS_ID: 4326
DEFINITION: GEOGCS["WGS 84",DATUM["World Geodetic System 1984",
SPHEROID["WGS 84",6378137,298.257223563,
AUTHORITY["EPSG","7030"]],AUTHORITY["EPSG","6326"]],
PRIMEM["Greenwich",0,AUTHORITY["EPSG","8901"]],
UNIT["degree",0.017453292519943278,
AUTHORITY["EPSG","9122"]],
AXIS["Lat",NORTH],AXIS["Long",EAST],
AUTHORITY["EPSG","4326"]]
DESCRIPTION:
此条目描述了用于 GPS 系统的 SRS。它的名称 ( SRS_NAME) 为 WGS 84，ID ( SRS_ID) 为 4326，这是
欧洲石油调查组(EPSG) 使用的 ID。
列中的 SRS 定义DEFINITION是 WKT 值，如
开放地理空间联盟文档
OGC 12-063r5中指定的那样表示。
SRS_ID值表示与几何值的 SRID 相同类型的值，或作为 SRID 参数传递给空间函数。SRID 0（无单位笛卡尔平面）是特殊的。它始终是合法的空间参考系统 ID，可用于任何依赖于 SRID 值的空间数据计算。
对于多个几何值的计算，所有值必须具有相同的 SRID，否则会发生错误。
当 GIS 功能需要定义时，SRS 定义解析按需进行。已解析的定义存储在数据字典缓存中，以实现重用并避免为每个需要 SRS 信息的语句产生解析开销。
为了能够对存储在数据字典中的 SRS 条目进行操作，MySQL 提供了以下 SQL 语句：
CREATE SPATIAL REFERENCE
SYSTEM：请参阅
第 13.1.19 节，“CREATE SPATIAL REFERENCE SYSTEM 语句”。此声明的描述包括有关 SRS 组件的附加信息。
DROP SPATIAL REFERENCE
SYSTEM：请参阅
第 13.1.31 节，“DROP SPATIAL REFERENCE SYSTEM 语句”。
© Mysql 中文网
