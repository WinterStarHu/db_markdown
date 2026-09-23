# 12.17.10 空间 Geohash 函数_MySQL 8.0 参考手册

12.17.10 空间 Geohash 函数_MySQL 8.0 参考手册
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
12.17.10 空间 Geohash 函数
12.17.10 空间 Geohash 函数
Geohash 是一种将任意精度的经纬度坐标编码为文本字符串的系统。Geohash 值是仅包含从中选择的字符的字符串
"0123456789bcdefghjkmnpqrstuvwxyz"。
本节中的函数启用对 geohash 值的操作，它为应用程序提供导入和导出 geohash 数据以及索引和搜索 geohash 值的功能。
除非另有说明，本节中的函数按如下方式处理它们的几何参数：
如果任何参数是NULL，则返回值为NULL。
如果任何参数无效，则会发生错误。
如果任何参数的经度或纬度超出范围，则会发生错误：
如果经度值不在 (−180, 180] 范围内，
ER_GEOMETRY_PARAM_LONGITUDE_OUT_OF_RANGE
则会发生错误（ER_LONGITUDE_OUT_OF_RANGE
MySQL 8.0.12 之前）。
如果纬度值不在 [−90, 90] 范围内，
ER_GEOMETRY_PARAM_LATITUDE_OUT_OF_RANGE
则会发生错误（ER_LATITUDE_OUT_OF_RANGE
MySQL 8.0.12 之前）。
显示的范围以度为单位。由于浮点运算，确切的范围限制略有偏差。
如果任何点参数不具有 SRID 0 或 4326，
ER_SRS_NOT_FOUND则会发生错误。
point不检查参数 SRID 有效性。
如果任何 SRID 参数引用未定义的空间参考系统 (SRS)，
ER_SRS_NOT_FOUND则会发生错误。
如果任何 SRID 参数不在 32 位无符号整数的范围内，
ER_DATA_OUT_OF_RANGE则会发生错误。
否则，返回值为非NULL。
这些 geohash 函数可用：
ST_GeoHash(longitude,
latitude,
max_length),
ST_GeoHash(point,
max_length)
返回连接字符集和排序规则中的 geohash 字符串。
对于第一个语法，longitude
必须是 [−180, 180] 范围内的数字，并且
latitude必须是 [−90, 90] 范围内的数字。对于第二种语法，
POINT需要一个值，其中 X 和 Y 坐标分别在经度和纬度的有效范围内。
结果字符串不超过
max_length字符数，上限为 100。字符串可能比
max_length字符数短，因为创建 geohash 值的算法会继续，直到它创建了一个字符串，该字符串是位置或max_length
字符的精确表示， 以先到者为准。
ST_GeoHash()如本节介绍中所述处理其参数。
mysql> SELECT ST_GeoHash(180,0,10), ST_GeoHash(-180,-90,15);
+----------------------+-------------------------+
| ST_GeoHash(180,0,10) | ST_GeoHash(-180,-90,15) |
+----------------------+-------------------------+
| xbpbpbpbpb           | 000000000000000         |
+----------------------+-------------------------+
ST_LatFromGeoHash(geohash_str)
从 geohash 字符串值返回纬度，作为 [−90, 90] 范围内的双精度数字。
解码函数从参数ST_LatFromGeoHash()
中读取不超过 433 个字符
geohash_str。这表示坐标值内部表示中信息的上限。第 433 个之后的字符将被忽略，即使它们在其他方面是非法的并会产生错误。
ST_LatFromGeoHash()如本节介绍中所述处理其参数。
mysql> SELECT ST_LatFromGeoHash(ST_GeoHash(45,-20,10));
+------------------------------------------+
| ST_LatFromGeoHash(ST_GeoHash(45,-20,10)) |
+------------------------------------------+
|                                      -20 |
+------------------------------------------+
ST_LongFromGeoHash(geohash_str)
从 geohash 字符串值返回经度，作为 [−180, 180] 范围内的双精度数字。
说明中
ST_LatFromGeoHash()有关从
geohash_str参数处理的最大字符数的说明也适用于
ST_LongFromGeoHash().
ST_LongFromGeoHash()如本节介绍中所述处理其参数。
mysql> SELECT ST_LongFromGeoHash(ST_GeoHash(45,-20,10));
+-------------------------------------------+
| ST_LongFromGeoHash(ST_GeoHash(45,-20,10)) |
+-------------------------------------------+
|                                        45 |
+-------------------------------------------+
ST_PointFromGeoHash(geohash_str,
srid)
POINT给定一个 geohash 字符串值，
返回一个包含解码后的 geohash 值的值。
该点的X、Y坐标分别为[−180, 180]范围内的经度和[−90, 90]范围内的纬度。
srid参数是一个 32 位无符号整数
。
说明中
ST_LatFromGeoHash()有关从
geohash_str参数处理的最大字符数的说明也适用于
ST_PointFromGeoHash().
ST_PointFromGeoHash()如本节介绍中所述处理其参数。
mysql> SET @gh = ST_GeoHash(45,-20,10);
mysql> SELECT ST_AsText(ST_PointFromGeoHash(@gh,0));
+---------------------------------------+
| ST_AsText(ST_PointFromGeoHash(@gh,0)) |
+---------------------------------------+
| POINT(45 -20)                         |
+---------------------------------------+
© Mysql 中文网
