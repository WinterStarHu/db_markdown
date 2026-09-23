# 10.3.5 列字符集和排序规则_MySQL 8.0 参考手册

10.3.5 列字符集和排序规则_MySQL 8.0 参考手册
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
10.3.1 归类命名约定1
10.3.2 服务器字符集和排序规则1
10.3.3 数据库字符集和排序规则1
10.3.4 表字符集和排序规则1
10.3.5 列字符集和排序规则1
10.3.6 字符串文字字符集和排序规则1
10.3.7 国家字符集1
10.3.8 字符集介绍者1
10.3.9 字符集和归类分配示例1
10.3.10 与其他 DBMS 的兼容性1
10.4 连接字符集和排序规则
10.5 配置应用程序字符集和排序规则
10.6 错误信息字符集
10.7 列字符集转换
10.8 整理问题
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
MySQL 8.0 参考手册  / 第 10 章字符集、排序规则、Unicode  / 10.3 指定字符集和归类  /
10.3.5 列字符集和排序规则
10.3.5 列字符集和排序规则
每个“字符”列（即类型为
CHAR、
VARCHAR、
TEXT类型或任何同义词的列）都有一个列字符集和一个列排序规则。和的列定义语法具有用于指定列字符集和排序规则的可选子句
CREATE TABLE：
ALTER TABLEcol_name {CHAR | VARCHAR | TEXT} (col_length)
[CHARACTER SET charset_name]
[COLLATE collation_name]
这些子句也可以用于
ENUM和
SET列：
col_name {ENUM | SET} (val_list)
[CHARACTER SET charset_name]
[COLLATE collation_name]
例子：
CREATE TABLE t1
(
col1 VARCHAR(5)
CHARACTER SET latin1
COLLATE latin1_german1_ci
);
ALTER TABLE t1 MODIFY
col1 VARCHAR(5)
CHARACTER SET latin1
COLLATE latin1_swedish_ci;
MySQL 通过以下方式选择列字符集和排序规则：
如果同时指定了和
，则使用字符集
和排序规则
。
CHARACTER SET
charset_nameCOLLATE
collation_namecharset_namecollation_nameCREATE TABLE t1
(
col1 CHAR(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci
) CHARACTER SET latin1 COLLATE latin1_bin;
为列指定了字符集和排序规则，因此使用它们。该列有 character set
utf8mb4和 collat​​ion
utf8mb4_unicode_ci。
如果没有指定，则使用字符集
及其默认排序规则。
CHARACTER SET
charset_nameCOLLATEcharset_nameCREATE TABLE t1
(
col1 CHAR(10) CHARACTER SET utf8mb4
) CHARACTER SET latin1 COLLATE latin1_bin;
为列指定了字符集，但没有指定排序规则。该列具有字符集
utf8mb4和 的默认排序规则
utf8mb4，即
utf8mb4_0900_ai_ci. 要查看每个字符集的默认排序规则，请使用
SHOW CHARACTER SET语句或查询INFORMATION_SCHEMA
CHARACTER_SETS表。
如果没有指定，则使用关联的字符集
和排序规则
。
COLLATE
collation_nameCHARACTER SETcollation_namecollation_nameCREATE TABLE t1
(
col1 CHAR(10) COLLATE utf8mb4_polish_ci
) CHARACTER SET latin1 COLLATE latin1_bin;
为列指定了排序规则，但没有指定字符集。该列具有排序规则
utf8mb4_polish_ci，字符集是与排序规则关联的字符集，即
utf8mb4.
否则（既未指定CHARACTER SET也未
COLLATE指定），使用表字符集和排序规则。
CREATE TABLE t1
(
col1 CHAR(10)
) CHARACTER SET latin1 COLLATE latin1_bin;
没有为列指定字符集和排序规则，因此使用表默认值。该列有 character setlatin1和 collat​​ion
latin1_bin。
CHARACTER SETand
COLLATE子句是标准 SQL
。
如果您使用ALTER TABLE将列从一种字符集转换为另一种字符集，MySQL 会尝试映射数据值，但如果字符集不兼容，则可能会丢失数据。
© Mysql 中文网
