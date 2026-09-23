# 11.1.5 比特值类型——BIT_MySQL 8.0 参考手册

11.1.5 比特值类型——BIT_MySQL 8.0 参考手册
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
11.1.5 比特值类型——BIT
11.1.5 比特值类型——BIT
BIT数据类型用于存储位值
。一种
允许存储-bit 值的类型。
范围从 1 到 64。
BIT(M)MM
要指定位值，
可以使用符号。是使用零和一写入的二进制值。例如，
和
分别代表 7 和 128。请参阅
第 9.1.5 节，“位值文字”。
b'value'valueb'111'b'10000000'
如果您将值分配给
长度小于位的列，则该值将在左侧填充零。例如，为
列分配一个值实际上与分配
.
BIT(M)Mb'101'BIT(6)b'000101'NDB集群。 BIT
给定表中使用的所有列
的最大组合大小NDB不得超过 4096 位。
© Mysql 中文网
