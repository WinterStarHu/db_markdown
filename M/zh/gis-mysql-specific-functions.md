# 12.17.5 创建几何值的 MySQL 特定函数_MySQL 8.0 参考手册

12.17.5 创建几何值的 MySQL 特定函数_MySQL 8.0 参考手册
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
12.17.5 创建几何值的 MySQL 特定函数
12.17.5 创建几何值的 MySQL 特定函数
MySQL 提供了一组有用的非标准函数来创建几何值。本节中描述的函数是 MySQL 对 OpenGIS 规范的扩展。
这些函数从 WKB 值或几何对象作为参数生成几何对象。如果任何参数不是正确对象类型的正确 WKB 或几何表示，则返回值为NULL。
例如，您可以将几何返回值
Point()直接插入到
POINT列中：
INSERT INTO t1 (pt_col) VALUES(Point(1,2));
GeomCollection(g
[, g] ...)
GeomCollection从几何参数
构造一个值。
GeomCollection()即使存在不受支持的几何图形，也会返回参数中包含的所有正确几何图形。
GeomCollection()不带参数是允许创建空几何的一种方式。此外，诸如
ST_GeomFromText()接受 WKT 几何集合参数的函数理解 OpenGIS
'GEOMETRYCOLLECTION EMPTY'标准语法和 MySQL'GEOMETRYCOLLECTION()'
非标准语法。
GeomCollection()并且
GeometryCollection()是同义词，具有
GeomCollection()首选功能。
GeometryCollection(g
[, g] ...)
GeomCollection从几何参数
构造一个值。
GeometryCollection()即使存在不受支持的几何图形，也会返回参数中包含的所有正确几何图形。
GeometryCollection()不带参数是允许创建空几何的一种方式。此外，诸如
ST_GeomFromText()接受 WKT 几何集合参数的函数理解 OpenGIS
'GEOMETRYCOLLECTION EMPTY'标准语法和 MySQL'GEOMETRYCOLLECTION()'
非标准语法。
GeomCollection()并且
GeometryCollection()是同义词，具有
GeomCollection()首选功能。
LineString(pt
[, pt] ...)
LineString从多个Point或 WKBPoint
参数
构造一个值。如果参数个数少于两个，则返回值为NULL。
MultiLineString(ls
[, ls] ...)
使用或 WKB
参数
构造一个MultiLineString值
。LineStringLineString
MultiPoint(pt
[, pt2] ...)
使用或 WKB
参数
构造一个MultiPoint值
。PointPoint
MultiPolygon(poly
[, poly] ...)
MultiPolygon从一组Polygon或 WKB
Polygon参数
构造一个值。
Point(x,
y)
Point使用其坐标
构造 a 。
Polygon(ls [,
ls] ...)
Polygon从多个
LineString或 WKB
LineString参数
构造一个值。如果任何参数不代表 a LinearRing（即，不是封闭且简单LineString的），则返回值为NULL。
© Mysql 中文网
