# 11.2.4 YEAR 类型_MySQL 8.0 参考手册

11.2.4 YEAR 类型_MySQL 8.0 参考手册
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
11.2.1 日期和时间数据类型语法1
11.2.2 DATE、DATETIME 和 TIMESTAMP 类型1
11.2.3 时间类型1
11.2.4 YEAR 类型1
11.2.5 TIMESTAMP 和 DATETIME 的自动初始化和更新1
11.2.6 时间值中的小数秒1
11.2.7 日期和时间类型之间的转换1
11.2.8 日期中的两位数年份1
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
MySQL 8.0 参考手册  / 第 11 章数据类型  / 11.2 日期和时间数据类型  /
11.2.4 YEAR 类型
11.2.4 YEAR 类型
该YEAR类型是用于表示年份值的 1 字节类型。它可以声明为
YEAR具有 4 个字符的隐式显示宽度，或者等效于YEAR(4)显式显示宽度。
笔记
从 MySQL 8.0.19 开始，YEAR(4)
不推荐使用具有显式显示宽度的数据类型，您应该期望在未来的 MySQL 版本中删除对它的支持。相反，使用YEAR
不带显示宽度，这具有相同的含义。
MySQL 8.0 不支持
YEAR(2)旧版本 MySQL 中允许的 2 位数据类型。有关转换为 4-digit 的说明YEAR，请参阅
MySQL 5.7 Reference Manual中
的 2-Digit YEAR(2) Limitations and Migrating to 4-Digit YEAR。
MySQLYEAR以格式显示值，
YYYY范围为
1901到2155, 和
0000.
YEAR接受多种格式的输入值：
作为 4 位字符串，范围'1901'为
'2155'.
1901作为范围内的
4 位数字2155。
作为 1 或 2 位数字字符串，范围'0'
为'99'. MySQL 将范围内的值转换为to和
to到
范围'0'to'69'和
'70'to中的值
。
'99'YEAR20002069197019990
作为范围内
的 1 位或 2 位数字99。MySQL 将范围内的值转换为to和
to到
范围1to69和
70to中的值
。
99YEAR2001206919701999
插入数字的结果0显示值为 ，0000内部值为0000。要插入零并将其解释为2000，请将其指定为字符串'0'或'00'。
作为返回上下文可接受的值的函数的结果YEAR，例如
NOW().
如果未启用严格 SQL 模式，MySQL 会将无效
YEAR值转换为0000. 在严格 SQL 模式下，尝试插入无效
YEAR值会产生错误。
另见第 11.2.8 节，“日期中的两位数年份”。
© Mysql 中文网
