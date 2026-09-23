# 12.17.6 几何格式转换函数_MySQL 8.0 参考手册

12.17.6 几何格式转换函数_MySQL 8.0 参考手册
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
12.17.6 几何格式转换函数
12.17.6 几何格式转换函数
MySQL 支持本节中列出的函数，用于将几何值从内部几何格式转换为 WKT 或 WKB 格式，或者用于交换 X 和 Y 坐标的顺序。
还有一些函数可以将字符串从 WKT 或 WKB 格式转换为内部几何格式。请参阅
第 12.17.3 节，“从 WKT 值创建几何值的函数”和
第 12.17.4 节，“从 WKB 值创建几何值的函数”。
诸如ST_GeomFromText()
接受 WKT 几何集合参数的函数理解 OpenGIS'GEOMETRYCOLLECTION EMPTY'标准语法和 MySQL'GEOMETRYCOLLECTION()'
非标准语法。生成空几何集合的另一种方法是
GeometryCollection()不带参数调用。生成 WKT 值的函数
ST_AsWKT()
生成'GEOMETRYCOLLECTION
EMPTY'标准语法：
mysql> SET @s1 = ST_GeomFromText('GEOMETRYCOLLECTION()');
mysql> SET @s2 = ST_GeomFromText('GEOMETRYCOLLECTION EMPTY');
mysql> SELECT ST_AsWKT(@s1), ST_AsWKT(@s2);
+--------------------------+--------------------------+
| ST_AsWKT(@s1)            | ST_AsWKT(@s2)            |
+--------------------------+--------------------------+
| GEOMETRYCOLLECTION EMPTY | GEOMETRYCOLLECTION EMPTY |
+--------------------------+--------------------------+
mysql> SELECT ST_AsWKT(GeomCollection());
+----------------------------+
| ST_AsWKT(GeomCollection()) |
+----------------------------+
| GEOMETRYCOLLECTION EMPTY   |
+----------------------------+
除非另有说明，本节中的函数按如下方式处理它们的几何参数：
如果任何参数是NULL，则返回值为NULL。
如果任何几何参数不是语法上格式正确的几何，
ER_GIS_INVALID_DATA则会发生错误。
如果任何几何参数在未定义的空间参考系中，轴将按照它们在几何中出现的顺序输出，并出现
ER_WARN_SRS_NOT_FOUND_AXIS_ORDER
警告。
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
否则，返回值为非NULL。
这些函数可用于格式转换或坐标交换：
ST_AsBinary(g
[, options]),
ST_AsWKB(g
[, options])
将内部几何格式的值转换为其 WKB 表示形式并返回二进制结果。
函数返回值具有地理坐标（纬度、经度），其顺序由适用于几何参数的空间参考系统指定。可以提供一个可选options参数来覆盖默认的轴顺序。
ST_AsBinary()并
ST_AsWKB()
按照本节介绍中所述处理他们的论点。
mysql> SET @g = ST_LineFromText('LINESTRING(0 5,5 10,10 15)', 4326);
mysql> SELECT ST_AsText(ST_GeomFromWKB(ST_AsWKB(@g)));
+-----------------------------------------+
| ST_AsText(ST_GeomFromWKB(ST_AsWKB(@g))) |
+-----------------------------------------+
| LINESTRING(5 0,10 5,15 10)              |
+-----------------------------------------+
mysql> SELECT ST_AsText(ST_GeomFromWKB(ST_AsWKB(@g, 'axis-order=long-lat')));
+----------------------------------------------------------------+
| ST_AsText(ST_GeomFromWKB(ST_AsWKB(@g, 'axis-order=long-lat'))) |
+----------------------------------------------------------------+
| LINESTRING(0 5,5 10,10 15)                                     |
+----------------------------------------------------------------+
mysql> SELECT ST_AsText(ST_GeomFromWKB(ST_AsWKB(@g, 'axis-order=lat-long')));
+----------------------------------------------------------------+
| ST_AsText(ST_GeomFromWKB(ST_AsWKB(@g, 'axis-order=lat-long'))) |
+----------------------------------------------------------------+
| LINESTRING(5 0,10 5,15 10)                                     |
+----------------------------------------------------------------+
ST_AsText(g [,
options]),
ST_AsWKT(g
[, options])
将内部几何格式的值转换为其 WKT 表示形式并返回字符串结果。
函数返回值具有地理坐标（纬度、经度），其顺序由适用于几何参数的空间参考系统指定。可以提供一个可选options参数来覆盖默认的轴顺序。
ST_AsText()并
ST_AsWKT()
按照本节介绍中所述处理他们的论点。
mysql> SET @g = 'LineString(1 1,2 2,3 3)';
mysql> SELECT ST_AsText(ST_GeomFromText(@g));
+--------------------------------+
| ST_AsText(ST_GeomFromText(@g)) |
+--------------------------------+
| LINESTRING(1 1,2 2,3 3)        |
+--------------------------------+
值的输出MultiPoint包括每个点周围的括号。例如：
mysql> SELECT ST_AsText(ST_GeomFromText(@mp));
+---------------------------------+
| ST_AsText(ST_GeomFromText(@mp)) |
+---------------------------------+
| MULTIPOINT((1 1),(2 2),(3 3))   |
+---------------------------------+
ST_SwapXY(g)
接受内部几何格式的参数，交换几何中每个坐标对的 X 和 Y 值，并返回结果。
ST_SwapXY()如本节介绍中所述处理其参数。
mysql> SET @g = ST_LineFromText('LINESTRING(0 5,5 10,10 15)');
mysql> SELECT ST_AsText(@g);
+----------------------------+
| ST_AsText(@g)              |
+----------------------------+
| LINESTRING(0 5,5 10,10 15) |
+----------------------------+
mysql> SELECT ST_AsText(ST_SwapXY(@g));
+----------------------------+
| ST_AsText(ST_SwapXY(@g))   |
+----------------------------+
| LINESTRING(5 0,10 5,15 10) |
+----------------------------+
© Mysql 中文网
