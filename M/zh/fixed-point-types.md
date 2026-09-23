# 11.1.3 定点类型（精确值）——DECIMAL、NUMERIC_MySQL 8.0 参考手册

11.1.3 定点类型（精确值）——DECIMAL、NUMERIC_MySQL 8.0 参考手册
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
MySQL 8.0 参考手册  / 第 11 章数据类型  / 11.1 数值数据类型  /
11.1.3 定点类型（精确值）——DECIMAL、NUMERIC
11.1.3 定点类型（精确值）——DECIMAL、NUMERIC
DECIMAL和NUMERIC
类型存储精确的数字数据值
。当保持精确的精度很重要时使用这些类型，例如货币数据。在 MySQL 中，NUMERIC实现为DECIMAL，因此以下关于 的说明DECIMAL同样适用于
NUMERIC。
MySQLDECIMAL以二进制格式存储值。请参阅第 12.25 节，“精度数学”。
在DECIMAL列声明中，可以（并且通常）指定精度和小数位数。例如：
salary DECIMAL(5,2)
在此示例中，5是精度，
2是比例。精度表示为值存储的有效位数，小数位数表示小数点后可以存储的位数。
标准 SQL 要求DECIMAL(5,2)能够存储任何具有五位数字和两位小数的值，因此可以存储在salary
列范围从-999.99到
999.99.
在标准 SQL 中，语法
等同于
. 类似地，语法等同于，其中允许实现决定 的值
。MySQL 支持这两种语法形式。默认值为10。
DECIMAL(M)DECIMAL(M,0)DECIMALDECIMAL(M,0)MDECIMALM
如果小数位数为 0，则DECIMAL值不包含小数点或小数部分。
的最大位数为DECIMAL65，但给定列的实际范围DECIMAL
可能受给定列的精度或小数位数限制。当为此类列分配的值的小数点后位数超过指定比例所允许的位数时，该值将转换为该比例。（精确的行为是特定于操作系统的，但通常效果是截断到允许的位数。）
© Mysql 中文网
