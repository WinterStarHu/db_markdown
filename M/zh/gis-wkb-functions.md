# 12.17.4 从 WKB 值创建几何值的函数_MySQL 8.0 参考手册

12.17.4 从 WKB 值创建几何值的函数_MySQL 8.0 参考手册
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
12.17.4 从 WKB 值创建几何值的函数
12.17.4 从 WKB 值创建几何值的函数
这些函数将
BLOB包含众所周知的二进制 (WKB) 表示形式和可选的空间参考系统标识符 (SRID) 作为参数。他们返回相应的几何图形。有关 WKB 格式的说明，请参阅Well-Known Binary (WKB) Format。
本节中的函数检测笛卡尔或地理空间参考系统 (SRS) 中的参数，并返回适合 SRS 的结果。
ST_GeomFromWKB()接受任何几何类型的 WKB 值作为其第一个参数。其他函数提供特定于类型的构造函数，用于构造每种几何类型的几何值。
在 MySQL 8.0 之前，这些函数还接受由
第 12.17.5 节“创建几何值的 MySQL 特定函数”中的函数返回的几何对象。不再允许几何参数并产生错误。要将调用从使用几何参数迁移到使用 WKB 参数，请遵循以下准则：
重写
诸如ST_GeomFromWKB(Point(0,
0)).Point(0, 0)
重写诸如or之类ST_GeomFromWKB(Point(0,
0), 4326)的结构。
ST_SRID(Point(0, 0),
4326)ST_GeomFromWKB(ST_AsWKB(Point(0,
0)), 4326)
除非另有说明，本节中的函数按如下方式处理它们的几何参数：
如果 WKB 或 SRID 参数是NULL，则返回值为NULL。
默认情况下，地理坐标（纬度、经度）按照几何参数的空间参考系统指定的顺序进行解释。可以提供一个可选
options参数来覆盖默认的轴顺序。options
由逗号分隔的列表组成
。唯一允许的值为
, 允许值为
,和
（默认值）。
key=valuekeyaxis-orderlat-longlong-latsrid-defined
如果options参数是
NULL，则返回值为
NULL。如果
options参数无效，则会出现错误以说明原因。
如果 SRID 参数引用未定义的空间参考系统 (SRS)，
ER_SRS_NOT_FOUND则会发生错误。
对于地理 SRS 几何参数，如果任何参数的经度或纬度超出范围，则会发生错误：
如果经度值不在 (−180, 180] 范围内，
ER_LONGITUDE_OUT_OF_RANGE
则会发生错误。
如果纬度值不在 [−90, 90] 范围内，
ER_LATITUDE_OUT_OF_RANGE
则会发生错误。
显示的范围以度为单位。如果 SRS 使用另一个单位，则范围使用其单位中的相应值。由于浮点运算，确切的范围限制略有偏差。
这些函数可用于从 WKB 值创建几何：
ST_GeomCollFromWKB(wkb
[, srid [,
options]]),
ST_GeometryCollectionFromWKB(wkb
[, srid [,
options]])
GeometryCollection使用其 WKB 表示和 SRID
构造一个值。
这些函数按照本节介绍中的描述处理它们的参数。
ST_GeomFromWKB(wkb
[, srid [,
options]]),
ST_GeometryFromWKB(wkb
[, srid [,
options]])
使用其 WKB 表示和 SRID 构造任何类型的几何值。
这些函数按照本节介绍中的描述处理它们的参数。
ST_LineFromWKB(wkb
[, srid [,
options]]),
ST_LineStringFromWKB(wkb
[, srid [,
options]])
LineString使用其 WKB 表示和 SRID
构造一个值。
这些函数按照本节介绍中的描述处理它们的参数。
ST_MLineFromWKB(wkb
[, srid [,
options]]),
ST_MultiLineStringFromWKB(wkb
[, srid [,
options]])
MultiLineString使用其 WKB 表示和 SRID
构造一个值。
这些函数按照本节介绍中的描述处理它们的参数。
ST_MPointFromWKB(wkb
[, srid [,
options]]),
ST_MultiPointFromWKB(wkb
[, srid [,
options]])
MultiPoint使用其 WKB 表示和 SRID
构造一个值。
这些函数按照本节介绍中的描述处理它们的参数。
ST_MPolyFromWKB(wkb
[, srid [,
options]]),
ST_MultiPolygonFromWKB(wkb
[, srid [,
options]])
MultiPolygon使用其 WKB 表示和 SRID
构造一个值。
这些函数按照本节介绍中的描述处理它们的参数。
ST_PointFromWKB(wkb
[, srid [,
options]])
Point使用其 WKB 表示和 SRID
构造一个值。
ST_PointFromWKB()如本节介绍中所述处理其参数。
ST_PolyFromWKB(wkb
[, srid [,
options]]),
ST_PolygonFromWKB(wkb
[, srid [,
options]])
Polygon使用其 WKB 表示和 SRID
构造一个值。
这些函数按照本节介绍中的描述处理它们的参数。
© Mysql 中文网
