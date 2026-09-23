# 11.4.3 支持的空间数据格式_MySQL 8.0 参考手册

11.4.3 支持的空间数据格式_MySQL 8.0 参考手册
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
11.4.3 支持的空间数据格式
11.4.3 支持的空间数据格式
两种标准空间数据格式用于表示查询中的几何对象：
知名文本 (WKT) 格式
众所周知的二进制 (WKB) 格式
在内部，MySQL 以与 WKT 或 WKB 格式不同的格式存储几何值。（内部格式类似于 WKB，但有一个初始的 4 个字节来指示 SRID。）
有一些函数可以在不同的数据格式之间进行转换；参见第 12.17.6 节，“几何格式转换函数”。
以下部分描述了 MySQL 使用的空间数据格式：
知名文本 (WKT) 格式众所周知的二进制 (WKB) 格式内部几何存储格式
知名文本 (WKT) 格式
几何值的 Well-Known Text (WKT) 表示旨在以 ASCII 形式交换几何数据。OpenGIS 规范提供了一个 Backus-Naur 语法，它指定了写入 WKT 值的正式生产规则（请参阅第 11.4 节，“空间数据类型”）。
几何对象的 WKT 表示示例：
答Point：
POINT(15 20)
指定的点坐标没有分隔逗号。这与 SQL
Point()函数的语法不同，后者需要在坐标之间使用逗号。注意使用适合给定空间操作上下文的语法。例如，以下语句都用于
从对象ST_X()中提取 X 坐标。Point第一个直接使用
Point()函数生成对象。第二个使用 WKT 表示形式转换为
Pointwith
ST_GeomFromText()。
mysql> SELECT ST_X(Point(15, 20));
+---------------------+
| ST_X(POINT(15, 20)) |
+---------------------+
|                  15 |
+---------------------+
mysql> SELECT ST_X(ST_GeomFromText('POINT(15 20)'));
+---------------------------------------+
| ST_X(ST_GeomFromText('POINT(15 20)')) |
+---------------------------------------+
|                                    15 |
+---------------------------------------+
ALineString有四点：
LINESTRING(0 0, 10 10, 20 25, 50 60)
点坐标对以逗号分隔。
Polygon带一个外环和一个内环
的 A ：POLYGON((0 0,10 0,10 10,0 10,0 0),(5 5,7 5,7 7,5 7, 5 5))MultiPoint具有三个
Point值
的 A ：MULTIPOINT(0 0, 20 20, 60 60)
诸如
ST_MPointFromText()和
之类的空间函数ST_GeomFromText()接受 WKT 格式的
MultiPoint值表示，允许值中的各个点用括号括起来。例如，以下两个函数调用都是有效的：
ST_MPointFromText('MULTIPOINT (1 1, 2 2, 3 3)')
ST_MPointFromText('MULTIPOINT ((1 1), (2 2), (3 3))')
AMultiLineString有两个
LineString值：
MULTILINESTRING((10 10, 20 20), (15 15, 30 15))
AMultiPolygon有两个
Polygon值：
MULTIPOLYGON(((0 0,10 0,10 10,0 10,0 0)),((5 5,7 5,7 7,5 7, 5 5)))
AGeometryCollection由两个
Point值和一个
组成LineString：
GEOMETRYCOLLECTION(POINT(10 10), POINT(30 30), LINESTRING(15 15, 20 20))
众所周知的二进制 (WKB) 格式
几何值的 Well-Known Binary (WKB) 表示用于将几何数​​据交换为由BLOB包含几何 WKB 信息的值表示的二进制流。此格式由 OpenGIS 规范定义（请参阅
第 11.4 节“空间数据类型”）。它也在 ISO SQL/MM 第 3 部分：空间标准中定义。
WKB 使用 1 字节无符号整数、4 字节无符号整数和 8 字节双精度数（IEEE 754 格式）。一个字节是八位。
例如，对应的 WKB 值POINT(1
-1)由以下 21 个字节序列组成，每个字节由两个十六进制数字表示：
0101000000000000000000F03F000000000000F0BF
该序列由下表中显示的组件组成。
表 11.2 WKB 组件示例
零件
尺寸
价值
字节顺序
1字节
01
WKB型
4字节
01000000
X坐标
8字节
000000000000F03F
Y坐标
8字节
000000000000F0BF
组件表示如下：
字节顺序指示符是 1 或 0，表示小端存储或大端存储。little-endian 和 big-endian 字节顺序也分别称为网络数据表示 (NDR) 和外部数据表示 (XDR)。
WKB 类型是表示几何类型的代码。MySQL 使用从 1 到 7 的值来表示
Point, LineString,
Polygon, MultiPoint,
MultiLineString,
MultiPolygon, 和
GeometryCollection。
值Point具有 X 和 Y 坐标，每个坐标都表示为双精度值。
更复杂的几何值的 WKB 值具有更复杂的数据结构，如 OpenGIS 规范中所述。
内部几何存储格式
MySQL 使用 4 个字节存储几何值以指示 SRID，后跟该值的 WKB 表示形式。有关 WKB 格式的说明，请参阅
Well-Known Binary (WKB) Format。
对于 WKB 部分，这些特定于 MySQL 的注意事项适用：
字节顺序指示符字节为 1，因为 MySQL 将几何存储为小端值。
MySQL 支持Point,
LineString, Polygon,
MultiPoint,
MultiLineString,
MultiPolygon, 和
的几何类型GeometryCollection。不支持其他几何类型。
只能GeometryCollection为空。这样的值存储有 0 个元素。
可以顺时针和逆时针指定多边形环。MySQL 在读取数据时会自动翻转环。
笛卡尔坐标以空间参考系的长度单位存储，X 坐标为 X 值，Y 坐标为 Y 值。轴方向是由空间参照系指定的方向。
地理坐标以空间参照系的角度单位存储，经度在 X 坐标中，纬度在 Y 坐标中。轴方向和子午线是由空间参考系指定的。
该LENGTH()函数返回值存储所需的字节空间。例子：
mysql> SET @g = ST_GeomFromText('POINT(1 -1)');
mysql> SELECT LENGTH(@g);
+------------+
| LENGTH(@g) |
+------------+
|         25 |
+------------+
mysql> SELECT HEX(@g);
+----------------------------------------------------+
| HEX(@g)                                            |
+----------------------------------------------------+
| 000000000101000000000000000000F03F000000000000F0BF |
+----------------------------------------------------+
值长度为 25 个字节，由这些部分组成（从十六进制值可以看出）：
整数 SRID (0) 的 4 个字节
整数字节顺序为 1 个字节（1 = little-endian）
4 个字节用于整数类型信息 (1 =
Point)
双精度 X 坐标 8 个字节 (1)
8 个字节用于双精度 Y 坐标 (−1)
© Mysql 中文网
