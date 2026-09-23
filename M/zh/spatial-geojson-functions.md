# 12.17.11 空间 GeoJSON 函数_MySQL 8.0 参考手册

12.17.11 空间 GeoJSON 函数_MySQL 8.0 参考手册
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
12.18.1 JSON函数参考
12.18.2 创建 JSON 值的函数
12.18.3 搜索 JSON 值的函数
12.18.4 修改 JSON 值的函数
12.18.5 返回 JSON 值属性的函数
12.18.6 JSON 表函数
12.18.7 JSON 模式验证函数
12.18.8 JSON 实用函数
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
12.17.11 空间 GeoJSON 函数
12.17.11 空间 GeoJSON 函数
本节介绍用于在 GeoJSON 文档和空间值之间进行转换的函数。GeoJSON 是一种用于编码几何/地理特征的开放标准。有关详细信息，请参阅http://geojson.org。此处讨论的函数遵循 GeoJSON 规范修订版 1.0。
GeoJSON 支持与 MySQL 相同的几何/地理数据类型。不支持 Feature 和 FeatureCollection 对象，除了从中提取几何对象。CRS 支持仅限于标识 SRID 的值。
MySQL 还支持原生JSON
数据类型和一组 SQL 函数，以启用对 JSON 值的操作。有关详细信息，请参阅第 11.5 节，“JSON 数据类型”和
第 12.18 节，“JSON 函数”。
ST_AsGeoJSON(g
[, max_dec_digits [,
options]])
从 geometry 生成一个 GeoJSON 对象
g。对象字符串具有连接字符集和排序规则。
如果任何参数是NULL，则返回值为NULL。如果任何非NULL
参数无效，则会发生错误。
max_dec_digits，如果指定，则限制坐标的小数位数并导致输出四舍五入。如果未指定，则此参数默认为其最大值 2 32 − 1。最小值为 0。
options，如果指定，是一个位掩码。下表显示了允许的标志值。如果几何参数的 SRID 为 0，则即使对于那些请求一个的标志值，也不会生成 CRS 对象。
标志值
意义
0
没有选择。options如果未指定，则这是默认值。
1个
向输出添加边界框。
2个
在输出中添加短格式 CRS URN。默认格式是短格式 ( )。EPSG:srid
4个
添加长格式 CRS URN ( )。此标志覆盖标志 2。例如，选项值 5 和 7 表示相同（添加边界框和长格式 CRS URN）。urn:ogc:def:crs:EPSG::srid
mysql> SELECT ST_AsGeoJSON(ST_GeomFromText('POINT(11.11111 12.22222)'),2);
+-------------------------------------------------------------+
| ST_AsGeoJSON(ST_GeomFromText('POINT(11.11111 12.22222)'),2) |
+-------------------------------------------------------------+
| {"type": "Point", "coordinates": [11.11, 12.22]}            |
+-------------------------------------------------------------+
ST_GeomFromGeoJSON(str
[, options [,
srid]])
str解析表示 GeoJSON 对象
的字符串并返回几何图形。
如果任何参数是NULL，则返回值为NULL。如果任何非NULL
参数无效，则会发生错误。
options，如果给定，描述如何处理包含坐标维度大于 2 的几何图形的 GeoJSON 文档。下表显示了允许的options值。
期权价值
意义
1个
拒绝文档并产生错误。options如果未指定，则这是默认值
。
2, 3, 4
接受文档并剥离坐标以获得更高的坐标维度。
options2、3 和 4 的值目前产生相同的效果。如果将来支持坐标维度大于 2 的几何图形，您可以预期这些值会产生不同的效果。
参数（srid如果给定）必须是 32 位无符号整数。如果未给出，则几何返回值的 SRID 为 4326。
如果srid引用未定义的空间参考系统 (SRS)，
ER_SRS_NOT_FOUND则会发生错误。
对于地理 SRS 几何参数，如果任何参数的经度或纬度超出范围，则会发生错误：
如果经度值不在 (−180, 180] 范围内，
ER_LONGITUDE_OUT_OF_RANGE
则会发生错误。
如果纬度值不在 [−90, 90] 范围内，
ER_LATITUDE_OUT_OF_RANGE
则会发生错误。
显示的范围以度为单位。如果 SRS 使用另一个单位，则范围使用其单位中的相应值。由于浮点运算，确切的范围限制略有偏差。
GeoJSON 几何、特征和特征集合对象可能有一个crs属性。解析函数解析 和 命名空间中命名的 CRS URN
，
但不解析作为链接对象给出的 CRS。此外，
被识别为 SRID 4326。如果对象具有无法理解的 CRS，则会发生错误，但如果提供了可选
参数，则任何 CRS 都会被忽略，即使它是无效的。
urn:ogc:def:crs:EPSG::sridEPSG:sridurn:ogc:def:crs:OGC:1.3:CRS84srid
如果crs在 GeoJSON 文档的较低级别发现指定 SRID 与顶级对象 SRID 不同的成员，
ER_INVALID_GEOJSON_CRS_NOT_TOP_LEVEL
则会发生错误。
type正如 GeoJSON 规范中指定的那样，解析对于GeoJSON 输入的成员（Point、
LineString等）
区分大小写。该规范没有提及其他解析的大小写敏感性，这在 MySQL 中是不区分大小写的。
此示例显示了一个简单的 GeoJSON 对象的解析结果。请注意，坐标顺序取决于所使用的 SRID。
mysql> SET @json = '{ "type": "Point", "coordinates": [102.0, 0.0]}';
mysql> SELECT ST_AsText(ST_GeomFromGeoJSON(@json));
+--------------------------------------+
| ST_AsText(ST_GeomFromGeoJSON(@json)) |
+--------------------------------------+
| POINT(0 102)                         |
+--------------------------------------+
mysql> SELECT ST_SRID(ST_GeomFromGeoJSON(@json));
+------------------------------------+
| ST_SRID(ST_GeomFromGeoJSON(@json)) |
+------------------------------------+
|                               4326 |
+------------------------------------+
mysql> SELECT ST_AsText(ST_SRID(ST_GeomFromGeoJSON(@json),0));
+-------------------------------------------------+
| ST_AsText(ST_SRID(ST_GeomFromGeoJSON(@json),0)) |
+-------------------------------------------------+
| POINT(102 0)                                    |
+-------------------------------------------------+
© Mysql 中文网
