# 11.1 数值数据类型_MySQL 8.0 参考手册

11.1 数值数据类型_MySQL 8.0 参考手册
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
11.1.1 数字数据类型语法1
11.1.2 整数类型（精确值）——INTEGER、INT、SMALLINT、TINYINT、MEDIUMINT、BIGINT1
11.1.3 定点类型（精确值）——DECIMAL、NUMERIC1
11.1.4 浮点类型（近似值）——FLOAT、DOUBLE1
11.1.5 比特值类型——BIT1
11.1.6 数值类型属性1
11.1.7 超出范围和溢出处理1
11.2 日期和时间数据类型
11.3 字符串数据类型
11.4 空间数据类型
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
11.1 数值数据类型
11.1 数值数据类型
11.1.1 数字数据类型语法11.1.2 整数类型（精确值）——INTEGER、INT、SMALLINT、TINYINT、MEDIUMINT、BIGINT11.1.3 定点类型（精确值）——DECIMAL、NUMERIC11.1.4 浮点类型（近似值）——FLOAT、DOUBLE11.1.5 比特值类型——BIT11.1.6 数值类型属性11.1.7 超出范围和溢出处理
MySQL 支持所有标准的 SQL 数字数据类型。这些类型包括精确数值数据类型（INTEGER、
SMALLINT、
DECIMAL和
NUMERIC），以及近似数值数据类型（FLOAT、
REAL和
DOUBLE PRECISION）。关键字
INT是 的同义词
INTEGER，关键字
DEC和
FIXED是 的同义词
DECIMAL。MySQL 将
其视为（非标准扩展）DOUBLE的同义词
。除非启用 SQL 模式
，否则DOUBLE PRECISIONMySQL 也将其视为
（非标准变体）
REAL
的同义词。DOUBLE PRECISIONREAL_AS_FLOAT数据类型存储位值并
BIT支持
、MyISAM、
MEMORY和
表。
InnoDBNDB
有关 MySQL 如何处理将超出范围的值分配给列以及表达式评估期间溢出的信息，请参阅
第 11.1.7 节，“超出范围和溢出处理”。
有关数字数据类型的存储要求的信息，请参阅第 11.7 节，“数据类型存储要求”。
有关对数值进行运算的函数的说明，请参阅
第 12.6 节，“数值函数和运算符”。用于数字操作数计算结果的数据类型取决于操作数的类型和对它们执行的操作。有关详细信息，请参阅第 12.6.1 节，“算术运算符”。
© Mysql 中文网
