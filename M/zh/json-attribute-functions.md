# 12.18.5 返回 JSON 值属性的函数_MySQL 8.0 参考手册

12.18.5 返回 JSON 值属性的函数_MySQL 8.0 参考手册
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
MySQL 8.0 参考手册  / 第 12 章函数和运算符  / 12.17空间分析函数  / 12.17.11 空间 GeoJSON 函数  /
12.18.5 返回 JSON 值属性的函数
12.18.5 返回 JSON 值属性的函数
本节中的函数返回 JSON 值的属性。
JSON_DEPTH(json_doc)
返回 JSON 文档的最大深度。NULL如果参数是 则
返回
NULL。如果参数不是有效的 JSON 文档，则会发生错误。
空数组、空对象或标量值的深度为 1。仅包含深度 1 的元素的非空数组或仅包含深度 1 的成员值的非空对象的深度为 2。否则，JSON 文档的深度大于 2。
mysql> SELECT JSON_DEPTH('{}'), JSON_DEPTH('[]'), JSON_DEPTH('true');
+------------------+------------------+--------------------+
| JSON_DEPTH('{}') | JSON_DEPTH('[]') | JSON_DEPTH('true') |
+------------------+------------------+--------------------+
|                1 |                1 |                  1 |
+------------------+------------------+--------------------+
mysql> SELECT JSON_DEPTH('[10, 20]'), JSON_DEPTH('[[], {}]');
+------------------------+------------------------+
| JSON_DEPTH('[10, 20]') | JSON_DEPTH('[[], {}]') |
+------------------------+------------------------+
|                      2 |                      2 |
+------------------------+------------------------+
mysql> SELECT JSON_DEPTH('[10, {"a": 20}]');
+-------------------------------+
| JSON_DEPTH('[10, {"a": 20}]') |
+-------------------------------+
|                             3 |
+-------------------------------+
JSON_LENGTH(json_doc[,
path])
返回 JSON 文档的长度，或者，如果
path给出了参数，则返回文档中由路径标识的值的长度。NULL如果任何参数是
NULL或path
参数未标识文档中的值，则返回。json_doc如果参数不是有效的 JSON 文档或
path参数不是有效的路径表达式，则会发生错误。*在 MySQL 8.0.26 之前，如果路径表达式包含or
**通配符
，也会引发错误。
文档的长度确定如下：
标量的长度为 1。
数组的长度是数组元素的个数。
对象的长度是对象成员的数量。
长度不计算嵌套数组或对象的长度。
mysql> SELECT JSON_LENGTH('[1, 2, {"a": 3}]');
+---------------------------------+
| JSON_LENGTH('[1, 2, {"a": 3}]') |
+---------------------------------+
|                               3 |
+---------------------------------+
mysql> SELECT JSON_LENGTH('{"a": 1, "b": {"c": 30}}');
+-----------------------------------------+
| JSON_LENGTH('{"a": 1, "b": {"c": 30}}') |
+-----------------------------------------+
|                                       2 |
+-----------------------------------------+
mysql> SELECT JSON_LENGTH('{"a": 1, "b": {"c": 30}}', '$.b');
+------------------------------------------------+
| JSON_LENGTH('{"a": 1, "b": {"c": 30}}', '$.b') |
+------------------------------------------------+
|                                              1 |
+------------------------------------------------+
JSON_TYPE(json_val)
返回一个utf8mb4字符串，指示 JSON 值的类型。这可以是对象、数组或标量类型，如下所示：
mysql> SET @j = '{"a": [10, true]}';
mysql> SELECT JSON_TYPE(@j);
+---------------+
| JSON_TYPE(@j) |
+---------------+
| OBJECT        |
+---------------+
mysql> SELECT JSON_TYPE(JSON_EXTRACT(@j, '$.a'));
+------------------------------------+
| JSON_TYPE(JSON_EXTRACT(@j, '$.a')) |
+------------------------------------+
| ARRAY                              |
+------------------------------------+
mysql> SELECT JSON_TYPE(JSON_EXTRACT(@j, '$.a[0]'));
+---------------------------------------+
| JSON_TYPE(JSON_EXTRACT(@j, '$.a[0]')) |
+---------------------------------------+
| INTEGER                               |
+---------------------------------------+
mysql> SELECT JSON_TYPE(JSON_EXTRACT(@j, '$.a[1]'));
+---------------------------------------+
| JSON_TYPE(JSON_EXTRACT(@j, '$.a[1]')) |
+---------------------------------------+
| BOOLEAN                               |
+---------------------------------------+
JSON_TYPE()如果
NULL参数是
NULL：
mysql> SELECT JSON_TYPE(NULL);
+-----------------+
| JSON_TYPE(NULL) |
+-----------------+
| NULL            |
+-----------------+
如果参数不是有效的 JSON 值，则会发生错误：
mysql> SELECT JSON_TYPE(1);
ERROR 3146 (22032): Invalid data type for JSON data in argument 1
to function json_type; a JSON string or JSON type is required.
对于非NULL、非错误结果，以下列表描述了可能的
JSON_TYPE()返回值：
纯 JSON 类型：
OBJECT: JSON 对象
ARRAY: JSON 数组
BOOLEAN: JSON true 和 false 文字
NULL: JSON 空文字
数值类型：
INTEGER: MySQL
TINYINT,
SMALLINT,
MEDIUMINT和
标
INT量
BIGINT
DOUBLE: MySQL
标量
DOUBLE
FLOAT
DECIMAL: MySQL
DECIMAL和
NUMERIC标量
时间类型：
DATETIME: MySQL
DATETIME和
TIMESTAMP标量
DATE: MySQL
DATE标量
TIME: MySQL
TIME标量
字符串类型：
STRING: MySQL
utf8mb3字符类型标量:
CHAR,
VARCHAR,
TEXT,
ENUM, 和
SET
二进制类型：
BLOB: MySQL 二进制类型标量包括BINARY,
VARBINARY,
BLOB, 和
BIT
所有其他类型：
OPAQUE（原始位）
JSON_VALID(val)
返回 0 或 1 以指示值是否为有效的 JSON。NULL如果参数是 则
返回NULL。
mysql> SELECT JSON_VALID('{"a": 1}');
+------------------------+
| JSON_VALID('{"a": 1}') |
+------------------------+
|                      1 |
+------------------------+
mysql> SELECT JSON_VALID('hello'), JSON_VALID('"hello"');
+---------------------+-----------------------+
| JSON_VALID('hello') | JSON_VALID('"hello"') |
+---------------------+-----------------------+
|                   0 |                     1 |
+---------------------+-----------------------+
© Mysql 中文网
