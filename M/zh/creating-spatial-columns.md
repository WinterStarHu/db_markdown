# 11.4.6 创建空间柱_MySQL 8.0 参考手册

11.4.6 创建空间柱_MySQL 8.0 参考手册
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
11.4.6 创建空间柱
11.4.6 创建空间柱
MySQL 提供了一种为几何类型创建空间列的标准方法，例如，使用CREATE
TABLE或ALTER TABLE。MyISAM、
InnoDB、
NDB和
表支持空间列
ARCHIVE。另请参阅第 11.4.10 节，“创建空间索引”下有关空间索引的注释
。
具有空间数据类型的列可以具有 SRID 属性，以明确指示列中存储的值的空间参考系统 (SRS)。有关 SRID 限制列的含义，请参阅
第 11.4.1 节，“空间数据类型”。
使用CREATE TABLE
语句创建一个带有空间列的表：
CREATE TABLE geom (g GEOMETRY);
使用该ALTER TABLE语句向现有表添加空间列或从现有表删除空间列：
ALTER TABLE geom ADD pt POINT;
ALTER TABLE geom DROP pt;
© Mysql 中文网
