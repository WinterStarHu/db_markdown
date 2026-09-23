# 12.17.13 空间便利功能_MySQL 8.0 参考手册

12.17.13 空间便利功能_MySQL 8.0 参考手册
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
12.17.13 空间便利功能
12.17.13 空间便利功能
本节中的函数提供对几何值的便捷操作。
除非另有说明，本节中的函数按如下方式处理它们的几何参数：
如果任何参数是NULL，则返回值为NULL。
如果任何几何参数不是语法上格式正确的几何，
ER_GIS_INVALID_DATA则会发生错误。
如果任何几何参数是未定义空间参考系统 (SRS) 中语法上格式正确的几何，
ER_SRS_NOT_FOUND则会发生错误。
对于采用多个几何参数的函数，如果这些参数不在同一个 SRS 中，
ER_GIS_DIFFERENT_SRIDS则会发生错误。
否则，返回值为非NULL。
这些便利功能可用：
ST_Distance_Sphere(g1,
g2 [,
radius])
Point返回球体上参数
之间的最小球面距离
MultiPoint
，以米为单位。（对于通用距离计算，请参阅
ST_Distance()函数。）可选radius参数应以米为单位给出。
如果两个几何参数都是有效的笛卡尔坐标
Point或MultiPoint
SRID 0 中的值，则返回值是具有提供半径的球体上两个几何之间的最短距离。如果省略，则默认半径为 6,370,986 米，点 X 和 Y 坐标分别解释为经度和纬度，以度为单位。
如果两个几何参数都是有效的Point
或者MultiPoint是地理空间参考系统 (SRS) 中的值，则返回值是具有提供的半径的球体上两个几何之间的最短距离。如果省略，则默认半径等于平均半径，定义为 (2a+b)/3，其中 a 是半长轴，b 是 SRS 的半短轴。
ST_Distance_Sphere()按照本节介绍中的描述处理其参数，但有以下例外：
支持的几何参数组合是
Pointand Point，或
Pointand MultiPoint
（以任何参数顺序）。如果至少有一个几何图形既不是Point也不是
MultiPoint，并且其 SRID 为 0，
ER_NOT_IMPLEMENTED_FOR_CARTESIAN_SRS
则会发生错误。如果至少有一个几何图形既不是
Point也不是
MultiPoint，并且它的 SRID 指的是地理 SRS，
ER_NOT_IMPLEMENTED_FOR_GEOGRAPHIC_SRS
则会发生错误。如果任何几何图形引用投影的 SRS，
ER_NOT_IMPLEMENTED_FOR_PROJECTED_SRS
则会发生错误。
如果任何参数的经度或纬度超出范围，则会发生错误：
如果经度值不在 (−180, 180] 范围内，
ER_GEOMETRY_PARAM_LONGITUDE_OUT_OF_RANGE
则会发生错误（ER_LONGITUDE_OUT_OF_RANGE
MySQL 8.0.12 之前）。
如果纬度值不在 [−90, 90] 范围内，
ER_GEOMETRY_PARAM_LATITUDE_OUT_OF_RANGE
则会发生错误（ER_LATITUDE_OUT_OF_RANGE
MySQL 8.0.12 之前）。
显示的范围以度为单位。如果 SRS 使用另一个单位，则范围使用其单位中的相应值。由于浮点运算，确切的范围限制略有偏差。
如果radius参数存在但不是正数，
ER_NONPOSITIVE_RADIUS
则会发生错误。
如果距离超出双精度数的范围，
ER_STD_OVERFLOW_ERROR
则会发生错误。
mysql> SET @pt1 = ST_GeomFromText('POINT(0 0)');
mysql> SET @pt2 = ST_GeomFromText('POINT(180 0)');
mysql> SELECT ST_Distance_Sphere(@pt1, @pt2);
+--------------------------------+
| ST_Distance_Sphere(@pt1, @pt2) |
+--------------------------------+
|             20015042.813723423 |
+--------------------------------+
ST_IsValid(g)
如果参数在几何上有效则返回 1，如果参数在几何上无效则返回 0。几何有效性由 OGC 规范定义。
唯一有效的空几何以空几何集合值的形式表示。
ST_IsValid()在这种情况下返回 1。MySQL 不支持 GISEMPTY
值，例如POINT EMPTY.
ST_IsValid()如本节介绍中所述处理其参数，但以下情况除外：
如果几何图形的地理 SRS 的经度或纬度超出范围，则会发生错误：
如果经度值不在 (−180, 180] 范围内，
ER_GEOMETRY_PARAM_LONGITUDE_OUT_OF_RANGE
则会发生错误（ER_LONGITUDE_OUT_OF_RANGE
MySQL 8.0.12 之前）。
如果纬度值不在 [−90, 90] 范围内，
ER_GEOMETRY_PARAM_LATITUDE_OUT_OF_RANGE
则会发生错误（ER_LATITUDE_OUT_OF_RANGE
MySQL 8.0.12 之前）。
显示的范围以度为单位。如果 SRS 使用另一个单位，则范围使用其单位中的相应值。由于浮点运算，确切的范围限制略有偏差。
mysql> SET @ls1 = ST_GeomFromText('LINESTRING(0 0,-0.00 0,0.0 0)');
mysql> SET @ls2 = ST_GeomFromText('LINESTRING(0 0, 1 1)');
mysql> SELECT ST_IsValid(@ls1);
+------------------+
| ST_IsValid(@ls1) |
+------------------+
|                0 |
+------------------+
mysql> SELECT ST_IsValid(@ls2);
+------------------+
| ST_IsValid(@ls2) |
+------------------+
|                1 |
+------------------+
ST_MakeEnvelope(pt1,
pt2)
返回围绕两点形成包络的矩形，如 a Point、
LineString或Polygon。
计算是使用笛卡尔坐标系完成的，而不是在球体、椭球体或地球上进行。
给定两个点pt1和
pt2，
ST_MakeEnvelope()在抽象平面上创建结果几何体，如下所示：
如果pt1和
pt2相等，则结果为点pt1。
否则，如果是垂直或水平线段，则结果为线段
。
(pt1,
pt2)(pt1,
pt2)
否则，结果是使用
pt1和
pt2作为对角点的多边形。
结果几何的 SRID 为 0。
ST_MakeEnvelope()按照本节介绍中的描述处理其参数，但有以下例外：
如果参数不是Point值，ER_WRONG_ARGUMENTS
则会发生错误。
ER_GIS_INVALID_DATA
附加条件两点任意坐标值为无穷大或 时会
NaN报错
。
如果任何几何具有地理空间参考系统 (SRS) 的 SRID 值，
ER_NOT_IMPLEMENTED_FOR_GEOGRAPHIC_SRS
则会发生错误。
mysql> SET @pt1 = ST_GeomFromText('POINT(0 0)');
mysql> SET @pt2 = ST_GeomFromText('POINT(1 1)');
mysql> SELECT ST_AsText(ST_MakeEnvelope(@pt1, @pt2));
+----------------------------------------+
| ST_AsText(ST_MakeEnvelope(@pt1, @pt2)) |
+----------------------------------------+
| POLYGON((0 0,1 0,1 1,0 1,0 0))         |
+----------------------------------------+
ST_Simplify(g,
max_distance)
使用 Douglas-Peucker 算法简化几何并返回相同类型的简化值。
几何可以是任何几何类型，尽管 Douglas-Peucker 算法实际上可能不会处理所有类型。通过将其组件一个一个地提供给简化算法来处理几何集合，并将返回的几何作为结果放入几何集合中。
max_distance参数是顶点到要删除的其他线段的距离（以输入坐标为单位）
。简化线串此距离内的顶点将被删除。
根据 Boost.Geometry，由于简化过程，几何图形可能会变得无效，并且该过程可能会创建自相交。要检查结果的有效性，将其传递给
ST_IsValid().
ST_Simplify()如本节介绍中所述处理其参数，但以下情况除外：
如果max_distance参数不是正数，或者是NaN，
ER_WRONG_ARGUMENTS则会发生错误。
mysql> SET @g = ST_GeomFromText('LINESTRING(0 0,0 1,1 1,1 2,2 2,2 3,3 3)');
mysql> SELECT ST_AsText(ST_Simplify(@g, 0.5));
+---------------------------------+
| ST_AsText(ST_Simplify(@g, 0.5)) |
+---------------------------------+
| LINESTRING(0 0,0 1,1 1,2 3,3 3) |
+---------------------------------+
mysql> SELECT ST_AsText(ST_Simplify(@g, 1.0));
+---------------------------------+
| ST_AsText(ST_Simplify(@g, 1.0)) |
+---------------------------------+
| LINESTRING(0 0,3 3)             |
+---------------------------------+
ST_Validate(g)
根据 OGC 规范验证几何图形。几何可以在句法上格式正确（WKB 值加上 SRID）但在几何上无效。例如，这个多边形在几何上是无效的：POLYGON((0 0, 0 0, 0 0, 0 0, 0
0))
ST_Validate()如果参数在语法上格式正确并且在几何上有效，NULL如果参数在语法上格式不正确或在几何上无效或者是 ，则返回几何NULL。
ST_Validate()可用于过滤掉无效的几何数据，但需要付出一定的代价。对于需要不被无效数据污染的更精确结果的应用程序，这种损失可能是值得的。
如果几何参数有效，则按原样返回，但如果输入Polygon或
MultiPolygon具有顺时针环，则在检查有效性之前将这些环反转。如果几何有效，则返回具有反转环的值。
唯一有效的空几何以空几何集合值的形式表示。
ST_Validate()在这种情况下直接返回它而无需进一步检查。
从 MySQL 8.0.13 开始，
ST_Validate()按照本节介绍中的描述处理其参数，但有以下例外：
如果几何图形的地理 SRS 的经度或纬度超出范围，则会发生错误：
如果经度值不在 (−180, 180] 范围内，
ER_GEOMETRY_PARAM_LONGITUDE_OUT_OF_RANGE
则会发生错误（ER_LONGITUDE_OUT_OF_RANGE
MySQL 8.0.12 之前）。
如果纬度值不在 [−90, 90] 范围内，
ER_GEOMETRY_PARAM_LATITUDE_OUT_OF_RANGE
则会发生错误（ER_LATITUDE_OUT_OF_RANGE
MySQL 8.0.12 之前）。
显示的范围以度为单位。由于浮点运算，确切的范围限制略有偏差。
在 MySQL 8.0.13 之前，
ST_Validate()按照本节介绍中的描述处理其参数，但有以下例外：
如果几何在语法上不合式，则返回值为NULL。ER_GIS_INVALID_DATA不会发生错误
。
如果几何具有地理空间参考系统 (SRS) 的 SRID 值，
ER_NOT_IMPLEMENTED_FOR_GEOGRAPHIC_SRS
则会发生错误。
mysql> SET @ls1 = ST_GeomFromText('LINESTRING(0 0)');
mysql> SET @ls2 = ST_GeomFromText('LINESTRING(0 0, 1 1)');
mysql> SELECT ST_AsText(ST_Validate(@ls1));
+------------------------------+
| ST_AsText(ST_Validate(@ls1)) |
+------------------------------+
| NULL                         |
+------------------------------+
mysql> SELECT ST_AsText(ST_Validate(@ls2));
+------------------------------+
| ST_AsText(ST_Validate(@ls2)) |
+------------------------------+
| LINESTRING(0 0,1 1)          |
+------------------------------+
© Mysql 中文网
