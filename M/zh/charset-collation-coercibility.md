# 10.8.4 表达式中的排序规则强制性_MySQL 8.0 参考手册

10.8.4 表达式中的排序规则强制性_MySQL 8.0 参考手册
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
10.1 一般字符集和排序规则
10.2 MySQL 中的字符集和排序规则
10.3 指定字符集和归类
10.4 连接字符集和排序规则
10.5 配置应用程序字符集和排序规则
10.6 错误信息字符集
10.7 列字符集转换
10.8 整理问题
10.8.1 在 SQL 语句中使用 COLLATE1
10.8.2 COLLATE 子句优先级1
10.8.3 字符集和排序规则兼容性1
10.8.4 表达式中的排序规则强制性1
10.8.5 二进制排序规则与 _bin 排序规则的比较1
10.8.6 整理效果示例1
10.8.7 在 INFORMATION_SCHEMA 搜索中使用排序规则1
10.9 Unicode 支持
10.10 支持的字符集和归类
10.11 字符集限制
10.12 设置错误信息语言
10.13 添加字符集
10.14 向字符集添加归类
10.15 字符集配置
10.16 MySQL 服务器语言环境支持
第 11 章数据类型
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
MySQL 8.0 参考手册  / 第 10 章字符集、排序规则、Unicode  / 10.8 整理问题  /
10.8.4 表达式中的排序规则强制性
10.8.4 表达式中的排序规则强制性
在绝大多数语句中，很明显 MySQL 使用什么排序规则来解决比较操作。例如，在以下情况下，应该明确排序规则是 column 的排序规则x：
SELECT x FROM T ORDER BY x;
SELECT x FROM T WHERE x = x;
SELECT DISTINCT x FROM T;
但是，对于多个操作数，可能会出现歧义。例如，此语句执行列
x和字符串文字
之间的比较'Y'：
SELECT x FROM T WHERE x = 'Y';
如果x和'Y'具有相同的排序规则，则用于比较的排序规则没有歧义。但是如果它们有不同的归类，比较应该使用的归类x还是 of
'Y'？x和
都有'Y'归类，那么哪个归类优先？
在比较以外的上下文中也可能会出现混合排序规则。例如，一个多参数串联操作，例如CONCAT(x,'Y')
将其参数组合起来生成一个字符串。结果应该有什么排序规则？
为了解决这些问题，MySQL 检查是否可以将一项的排序规则强制转换为另一项的排序规则。MySQL 分配强制值如下：
显式COLLATE子句的可强制性为 0（根本不可强制）。
具有不同排序规则的两个字符串的串联具有 1 的强制性。
列或存储的例程参数或局部变量的排序规则具有 2 的可强制性。
“系统常量”USER() （由or
等​​函数返回的字符串）VERSION()的强制性为 3。
文字的排序规则具有 4 的强制性。
数字或时间值的排序规则具有 5 的强制性。
NULL或派生自的表达式NULL的强制性为 6。
MySQL 使用具有以下规则的强制性值来解决歧义：
使用强制性值最低的排序规则。
如果双方具有相同的强制性，则：
如果两边都是Unicode，或者两边都不是Unicode，都是错误的。
如果一方有 Unicode 字符集，另一方有非 Unicode 字符集，则有 Unicode 字符集的一方获胜，自动字符集转换应用于非 Unicode 一方。例如，以下语句不会返回错误：
SELECT CONCAT(utf8mb4_column, latin1_column) FROM t1;
它返回一个结果，其字符集为
utf8mb4且排序规则与 相同
utf8mb4_column。的值
在连接之前latin1_column自动转换为utf8mb4。
_bin对于具有来自相同字符集但混合排序规则和_cior_cs
排序规则
的操作数的操作，使用_bin排序规则。这类似于混合非二进制和二进制字符串的操作如何将操作数评估为二进制字符串，应用于排序规则而不是数据类型。
尽管自动转换不在 SQL 标准中，但该标准确实表示每个字符集（就支持的字符而言）都是 Unicode 的“子集”。因为“适用于超集的也适用于子集”是众所周知的原则，所以我们认为 Unicode 的排序规则可以适用于与非 Unicode 字符串的比较。更一般地说，MySQL 使用字符集指令表的概念，它有时可用于确定字符集之间的子集关系，并启用操作中的操作数转换，否则会产生错误。请参阅第 10.2.1 节，“字符集指令表”.
下表说明了上述规则的一些应用。
比较
使用的排序规则
column1 = 'A'
使用排序规则column1
column1 = 'A' COLLATE x
使用排序规则'A' COLLATE x
column1 COLLATE x = 'A' COLLATE y
错误
要确定字符串表达式的强制性，请使用
COERCIBILITY()函数（请参阅
第 12.16 节，“信息函数”）：
mysql> SELECT COERCIBILITY(_utf8mb4'A' COLLATE utf8mb4_bin);
-> 0
mysql> SELECT COERCIBILITY(VERSION());
-> 3
mysql> SELECT COERCIBILITY('A');
-> 4
mysql> SELECT COERCIBILITY(1000);
-> 5
mysql> SELECT COERCIBILITY(NULL);
-> 6
对于数字或时间值到字符串的隐式转换，例如1expression中的参数CONCAT(1, 'abc')，结果是一个字符（非二进制）字符串，其字符集和排序规则由
character_set_connection和
collation_connection系统变量确定。请参阅第 12.3 节，“表达式计算中的类型转换”。
© Mysql 中文网
