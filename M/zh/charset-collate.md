# 10.8.1 在 SQL 语句中使用 COLLATE_MySQL 8.0 参考手册

10.8.1 在 SQL 语句中使用 COLLATE_MySQL 8.0 参考手册
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
10.8.1 在 SQL 语句中使用 COLLATE
10.8.1 在 SQL 语句中使用 COLLATE
使用该COLLATE子句，您可以覆盖用于比较的任何默认排序规则。
COLLATE可用于 SQL 语句的各个部分。这里有些例子：
与ORDER BY：
SELECT k
FROM t1
ORDER BY k COLLATE latin1_german2_ci;
与AS：
SELECT k COLLATE latin1_german2_ci AS k1
FROM t1
ORDER BY k1;
与GROUP BY：
SELECT k
FROM t1
GROUP BY k COLLATE latin1_german2_ci;
使用聚合函数：
SELECT MAX(k COLLATE latin1_german2_ci)
FROM t1;
与DISTINCT：
SELECT DISTINCT k COLLATE latin1_german2_ci
FROM t1;
与WHERE：
SELECT *
FROM t1
WHERE _latin1 'Müller' COLLATE latin1_german2_ci = k;SELECT *
FROM t1
WHERE k LIKE _latin1 'Müller' COLLATE latin1_german2_ci;
与HAVING：
SELECT k
FROM t1
GROUP BY k
HAVING k = _latin1 'Müller' COLLATE latin1_german2_ci;
© Mysql 中文网
