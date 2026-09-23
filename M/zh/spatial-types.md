# 11.4 空间数据类型_MySQL 8.0 参考手册

11.4 空间数据类型_MySQL 8.0 参考手册
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
MySQL 8.0 参考手册  / 第 11 章数据类型  /
11.4 空间数据类型
11.4 空间数据类型
11.4.1 空间数据类型11.4.2 OpenGIS 几何模型11.4.3 支持的空间数据格式11.4.4 几何的良构性和有效性11.4.5 空间参考系统支持11.4.6 创建空间柱11.4.7 填充空间列11.4.8 获取空间数据11.4.9 优化空间分析11.4.10 创建空间索引11.4.11 使用空间索引
开放地理空间联盟(OGC) 是一个由 250 多家公司、机构和大学组成的国际联盟，参与开发公开可用的概念解决方案，这些解决方案可用于管理空间数据的各种应用程序
。
Open Geospatial Consortium 发布了
OpenGIS® Implementation Standard for Geographic information - Simple feature access - Part 2: SQL option，该文档提出了几种扩展 SQL RDBMS 以支持空间数据的概念性方法。该规范可从 OGC 网站
http://www.opengeospatial.org/standards/sfs获得。
遵循 OGC 规范，MySQL 将空间扩展作为SQL with Geometry Types环境的一个子集来实​​现。该术语指的是已使用一组几何类型进行扩展的 SQL 环境。几何值 SQL 列被实现为具有几何类型的列。该规范描述了一组 SQL 几何类型，以及这些类型上用于创建和分析几何值的函数。
MySQL 空间扩展支持地理特征的生成、存储和分析：
表示空间值的数据类型
操作空间值的函数
用于改进对空间列的访问时间的空间索引
空间数据类型和函数可用于
MyISAM、
InnoDB、
NDB和
ARCHIVE表。用于索引空间列，MyISAM同时InnoDB
支持SPATIAL和非SPATIAL索引。其他存储引擎支持非SPATIAL索引，如
第 13.1.15 节“CREATE INDEX 语句”中所述。
地理特征是世界上任何具有位置的事物
。一个特征可以是：
一个实体。例如，一座山，一座池塘，一座城市。
空间。例如，城镇区，热带地区。
一个可定义的位置。例如，十字路口，作为两条街道相交的特定位置。
一些文档使用术语地理空间特征来指代地理特征。
几何是表示地理特征的另一个词。最初，
几何这个词的意思是测量地球。另一个含义来自制图学，指的是制图师用来绘制世界地图的几何特征。
此处的讨论将这些术语视为同义词：
地理特征、
地理空间特征、
特征或
几何。最常用的术语是几何，定义为
一个点或一组点，代表世界上任何具有位置的事物。
以下材料涵盖了这些主题：
MySQL 模型中实现的空间数据类型
OpenGIS 几何模型中空间扩展的基础
表示空间数据的数据格式
如何在 MySQL 中使用空间数据
空间数据索引的使用
MySQL 与 OpenGIS 规范的差异
有关对空间数据进行操作的函数的信息，请参阅
第 12.17 节，“空间分析函数”。
其他资源
这些标准对于空间操作的 MySQL 实现很重要：
SQL/MM 第 3 部分：空间。
Open Geospatial Consortium发布了OpenGIS® Implementation Standard for Geographic information ，
该文档提出了几种扩展 SQL RDBMS 以支持空间数据的概念性方法。具体请参见简单功能访问 - 第 1 部分：通用架构和简单功能访问 - 第 2 部分：SQL 选项。开放地理空间联盟 (OGC) 维护着一个网站，网址为
http://www.opengeospatial.org/。该规范可在
http://www.opengeospatial.org/standards/sfs获得。它包含与此处材料相关的附加信息。
空间参考系统(SRS) 定义的语法基于
OpenGIS
实施规范中定义的语法：坐标转换服务，修订版 1.00，OGC 01-009，2001 年 1 月 12 日，第 7.2 节。该规范可从
http://www.opengeospatial.org/standards/ct获得。有关在 MySQL 中实现的 SRS 定义中与该规范的差异，请参阅
第 13.1.19 节，“CREATE SPATIAL REFERENCE SYSTEM 语句”。
如果您对使用 MySQL 的空间扩展有疑问或疑虑，可以在 GIS 论坛中进行讨论：
https ://forums.mysql.com/list.php?23 。
© Mysql 中文网
