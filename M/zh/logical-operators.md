# 12.4.3 逻辑运算符_MySQL 8.0 参考手册

12.4.3 逻辑运算符_MySQL 8.0 参考手册
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
12.4.1 运算符优先级1
12.4.2 比较函数和运算符1
12.4.3 逻辑运算符1
12.4.4 赋值运算符1
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
MySQL 8.0 参考手册  / 第 12 章函数和运算符  / 12.4 运营商  /
12.4.3 逻辑运算符
12.4.3 逻辑运算符
表 12.5 逻辑运算符
姓名
描述
AND,&&
逻辑与
NOT,!
否定价值
OR,||
逻辑或
XOR
逻辑异或
在 SQL 中，所有逻辑运算符的计算结果都是
TRUE、FALSE或
NULL( UNKNOWN)。在 MySQL 中，这些实现为 1 ( TRUE)、0 ( FALSE) 和NULL。其中大部分对于不同的 SQL 数据库服务器是通用的，尽管某些服务器可能会为 返回任何非零值
TRUE。
MySQL 将任何非零、非NULL值计算为TRUE。例如，以下语句均评估为TRUE：
mysql> SELECT 10 IS TRUE;
-> 1
mysql> SELECT -10 IS TRUE;
-> 1
mysql> SELECT 'string' IS NOT NULL;
-> 1
NOT,
!
逻辑非。计算1操作数是否为0，0操作数是否为非零，并NOT NULL
返回NULL。
mysql> SELECT NOT 10;
-> 0
mysql> SELECT NOT 0;
-> 1
mysql> SELECT NOT NULL;
-> NULL
mysql> SELECT ! (1+1);
-> 0
mysql> SELECT ! 1+1;
-> 1
生成最后一个示例1是因为表达式的计算方式与 相同
(!1)+1。
,!运算符是一个非标准的 MySQL 扩展。从 MySQL 8.0.17 开始，此运算符已弃用；希望在未来的 MySQL 版本中将其删除。应调整应用程序以使用标准 SQLNOT运算符。
AND,
&&
逻辑与。评估1是否所有操作数都是非零且不是NULL，
0如果一个或多个操作数是
0，否则NULL返回。
mysql> SELECT 1 AND 1;
-> 1
mysql> SELECT 1 AND 0;
-> 0
mysql> SELECT 1 AND NULL;
-> NULL
mysql> SELECT 0 AND NULL;
-> 0
mysql> SELECT NULL AND 0;
-> 0
,&&运算符是一个非标准的 MySQL 扩展。从 MySQL 8.0.17 开始，此运算符已弃用；希望在未来版本的 MySQL 中删除对它的支持。应调整应用程序以使用标准 SQL
AND运算符。
OR,
||
逻辑或。当两个操作数都为非NULL- 时，结果为
1如果任何操作数为非零，
0否则为。对于一个
NULL操作数，结果是
1另一个操作数是否为非零，
NULL否则。如果两个操作数都是
NULL，则结果是
NULL。
mysql> SELECT 1 OR 1;
-> 1
mysql> SELECT 1 OR 0;
-> 1
mysql> SELECT 0 OR 0;
-> 0
mysql> SELECT 0 OR NULL;
-> NULL
mysql> SELECT 1 OR NULL;
-> 1
笔记
如果PIPES_AS_CONCAT
启用了 SQL 模式，则
||表示 SQL 标准字符串连接运算符（如
CONCAT()）。
,||运算符是一个非标准的 MySQL 扩展。从 MySQL 8.0.17 开始，此运算符已弃用；希望在未来版本的 MySQL 中删除对它的支持。应调整应用程序以使用标准 SQL
OR运算符。PIPES_AS_CONCAT例外：如果启用，
则弃用不适用，
因为在这种情况下，||表示字符串连接。
XOR
逻辑异或。NULL如果任一操作数是 ，则返回NULL。对于非NULL操作数，
1如果奇数个操作数不为零，则求值，否则0返回。
mysql> SELECT 1 XOR 1;
-> 0
mysql> SELECT 1 XOR 0;
-> 1
mysql> SELECT 1 XOR NULL;
-> NULL
mysql> SELECT 1 XOR 1 XOR 1;
-> 1
a XOR b在数学上等于
(a AND (NOT b)) OR ((NOT a) and b)。
© Mysql 中文网
