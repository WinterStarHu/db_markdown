# 10.9.2 utf8mb3 字符集（3 字节 UTF-8 Unicode 编码）_MySQL 8.0 参考手册

10.9.2 utf8mb3 字符集（3 字节 UTF-8 Unicode 编码）_MySQL 8.0 参考手册
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
10.9 Unicode 支持
10.9.1 utf8mb4 字符集（4 字节 UTF-8 Unicode 编码）1
10.9.2 utf8mb3 字符集（3 字节 UTF-8 Unicode 编码）1
10.9.3 utf8 字符集（utf8mb3 的别名）1
10.9.4 ucs2字符集（UCS-2 Unicode编码）1
10.9.5 utf16字符集（UTF-16 Unicode编码）1
10.9.6 utf16le字符集（UTF-16LE Unicode编码）1
10.9.7 utf32字符集（UTF-32 Unicode编码）1
10.9.8 在 3 字节和 4 字节 Unicode 字符集之间转换1
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
MySQL 8.0 参考手册  / 第 10 章字符集、排序规则、Unicode  / 10.9 Unicode 支持  /
10.9.2 utf8mb3 字符集（3 字节 UTF-8 Unicode 编码）
10.9.2 utf8mb3 字符集（3 字节 UTF-8 Unicode 编码）
utf8mb3字符集具有以下特点
：
仅支持 BMP 字符（不支持增补字符）
每个多字节字符最多需要三个字节。
使用 UTF-8 数据但需要补充字符支持的应用程序应该使用utf8mb4而不是utf8mb3（请参阅
第 10.9.1 节，“utf8mb4 字符集（4 字节 UTF-8 Unicode 编码）”）。
utf8mb3和
中可用的字符集完全相同
ucs2。也就是说，它们具有相同的
曲目。
笔记
历史上，MySQL 曾utf8作为utf8mb3; 的别名。从 MySQL 8.0.28 开始，当表示此字符集时
，utf8mb3专门用于语句的输出和信息模式表中。SHOWutf8预计
在未来的某个时间点将成为参考utf8mb4。为避免 的含义含糊不清
utf8，请考虑
utf8mb4明确指定字符集引用而不是utf8。
您还应该知道该utf8mb3
字符集已被弃用，您应该期望它在未来的 MySQL 版本中被删除。请
utf8mb4改用。
utf8mb3可以用在CHARACTER
SET从句中，
在从句中，where
is
, ,
, ,
, 等等。例如：
utf8mb3_collation_substringCOLLATEcollation_substringbinczech_cidanish_ciesperanto_ciestonian_ciCREATE TABLE t (s1 CHAR(1) CHARACTER SET utf8mb3;
SELECT * FROM t WHERE s1 COLLATE utf8mb3_general_ci = 'x';
DECLARE x VARCHAR(5) CHARACTER SET utf8mb3 COLLATE utf8mb3_danish_ci;
SELECT CAST('a' AS CHAR CHARACTER SET utf8mb4) COLLATE utf8mb4_czech_ci;
在 MySQL 8.0.29 之前，utf8mb3
in 语句的实例被转换为utf8. 在 MySQL 8.0.30 及更高版本中，情况正好相反，因此在SHOW CREATE TABLEor
SELECT CHARACTER_SET_NAME FROM
INFORMATION_SCHEMA.COLUMNS或之类的语句中SELECT
COLLATION_NAME FROM INFORMATION_SCHEMA.COLUMNS，用户会看到以 or 为前缀的字符集或排序规则
utf8mb3名称utf8mb3_。
utf8mb3CHARACTER SET在子句以外的上下文中也有效（但已弃用） 。例如：
mysqld --character-set-server=utf8mb3SET NAMES 'utf8mb3'; /* and other SET statements that have similar effect */
SELECT _utf8mb3 'a';
有关与多字节字符集相关的数据类型存储的信息，请参阅
字符串类型存储要求。
© Mysql 中文网
