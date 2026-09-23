# 11.4.7 填充空间列_MySQL 8.0 参考手册

11.4.7 填充空间列_MySQL 8.0 参考手册
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
11.4.7 填充空间列
11.4.7 填充空间列
创建空间列后，您可以使用空间数据填充它们。
值应以内部几何格式存储，但您可以将它们从 Well-Known Text (WKT) 或 Well-Known Binary (WKB) 格式转换为该格式。以下示例演示如何通过将 WKT 值转换为内部几何格式来将几何值插入表中：
直接在
INSERT语句中进行转换：
INSERT INTO geom VALUES (ST_GeomFromText('POINT(1 1)'));
SET @g = 'POINT(1 1)';
INSERT INTO geom VALUES (ST_GeomFromText(@g));
在 之前执行转换
INSERT：
SET @g = ST_GeomFromText('POINT(1 1)');
INSERT INTO geom VALUES (@g);
以下示例将更复杂的几何图形插入表中：
SET @g = 'LINESTRING(0 0,1 1,2 2)';
INSERT INTO geom VALUES (ST_GeomFromText(@g));
SET @g = 'POLYGON((0 0,10 0,10 10,0 10,0 0),(5 5,7 5,7 7,5 7, 5 5))';
INSERT INTO geom VALUES (ST_GeomFromText(@g));
SET @g =
'GEOMETRYCOLLECTION(POINT(1 1),LINESTRING(0 0,1 1,2 2,3 3,4 4))';
INSERT INTO geom VALUES (ST_GeomFromText(@g));
前面的示例用于
ST_GeomFromText()创建几何值。您还可以使用特定于类型的函数：
SET @g = 'POINT(1 1)';
INSERT INTO geom VALUES (ST_PointFromText(@g));
SET @g = 'LINESTRING(0 0,1 1,2 2)';
INSERT INTO geom VALUES (ST_LineStringFromText(@g));
SET @g = 'POLYGON((0 0,10 0,10 10,0 10,0 0),(5 5,7 5,7 7,5 7, 5 5))';
INSERT INTO geom VALUES (ST_PolygonFromText(@g));
SET @g =
'GEOMETRYCOLLECTION(POINT(1 1),LINESTRING(0 0,1 1,2 2,3 3,4 4))';
INSERT INTO geom VALUES (ST_GeomCollFromText(@g));
想要使用几何值的 WKB 表示的客户端应用程序负责将查询中正确形成的 WKB 发送到服务器。有几种方法可以满足这一要求。例如：
使用十六进制文字语法插入一个POINT(1 1)值：
INSERT INTO geom VALUES
(ST_GeomFromWKB(X'0101000000000000000000F03F000000000000F03F'));
ODBC 应用程序可以发送 WKB 表示，使用以下
BLOB类型的参数将其绑定到占位符：
INSERT INTO geom VALUES (ST_GeomFromWKB(?))
其他编程接口可能支持类似的占位符机制。
在 C 程序中，您可以使用转义二进制值
mysql_real_escape_string_quote()
并将结果包含在发送到服务器的查询字符串中。参见
mysql_real_escape_string_quote()。
© Mysql 中文网
