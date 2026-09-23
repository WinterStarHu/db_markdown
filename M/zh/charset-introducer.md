# 10.3.8 字符集介绍者_MySQL 8.0 参考手册

10.3.8 字符集介绍者_MySQL 8.0 参考手册
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
10.3.8 字符集介绍者
10.3.8 字符集介绍者
字符串文字、十六进制文字或位值文字可能具有可选的字符集介绍符和
COLLATE子句，以将其指定为使用特定字符集和排序规则的字符串：
[_charset_name] literal [COLLATE collation_name]
该
表达式的正式名称为
介绍人。它告诉解析器，“后面的字符串使用了字符集
。”介绍人不会像往常那样
将字符串更改为介绍人字符集。它不会更改字符串值，但可能会出现填充。介绍人只是一个信号。
_charset_namecharset_nameCONVERT()
对于字符串文字，介绍人和字符串之间的空格是允许的，但可选。
对于字符集字面量，介绍符指示后续字符串的字符集，但不会更改解析器在字符串中执行转义处理的方式。转义总是由解析器根据
character_set_connection. 有关其他讨论和示例，请参阅
第 10.3.6 节，“字符串文字字符集和排序规则”。
例子：
SELECT 'abc';
SELECT _latin1'abc';
SELECT _binary'abc';
SELECT _utf8mb4'abc' COLLATE utf8mb4_danish_ci;
SELECT _latin1 X'4D7953514C';
SELECT _utf8mb4 0x4D7953514C COLLATE utf8mb4_danish_ci;
SELECT _latin1 b'1000001';
SELECT _utf8mb4 0b1000001 COLLATE utf8mb4_danish_ci;
字符集引入器和COLLATE
子句根据标准 SQL 规范实现。
字符串文字可以通过使用_binary介绍符指定为二进制字符串。默认情况下，十六进制文字和位值文字是二进制字符串，因此_binary是允许的，但通常不需要。_binary在文字被视为数字的上下文中，将十六进制或位文字保留为二进制字符串可能很有用。例如，在 MySQL 8.0 及更高版本中，位操作允许数字或二进制字符串参数，但默认情况下将十六进制和位文字视为数字。要为此类文字显式指定二进制字符串上下文，_binary请对至少一个参数使用引入器：
mysql> SET @v1 = X'000D' | X'0BC0';
mysql> SET @v2 = _binary X'000D' | X'0BC0';
mysql> SELECT HEX(@v1), HEX(@v2);
+----------+----------+
| HEX(@v1) | HEX(@v2) |
+----------+----------+
| BCD      | 0BCD     |
+----------+----------+
两个位操作的显示结果看起来相似，但是没有的结果_binary是一个
BIGINT值，而有的结果
_binary是一个二进制字符串。由于结果类型的不同，显示的值也不同： 数值结果不显示高位0位。
MySQL通过以下方式确定字符串文字、十六进制文字或位值文字的字符集和排序规则：
如果同时指定了_charset_name和
，则使用字符集
和排序规则
。
必须是 的允许排序规则
。
COLLATE
collation_namecharset_namecollation_namecollation_namecharset_name
如果_charset_name指定但未
COLLATE指定，则使用字符集
charset_name及其默认排序规则。要查看每个字符集的默认排序规则，请使用SHOW CHARACTER
SET语句或查询
INFORMATION_SCHEMA
CHARACTER_SETS表。
如果_charset_name未指定但已指定：
COLLATE
collation_name
对于字符串文字，使用
character_set_connection
系统变量和排序规则
给定的连接默认字符集collation_name。
collation_name必须是连接默认字符集允许的排序规则。
对于十六进制文字或位值文字，唯一允许的排序规则是binary因为默认情况下这些类型的文字是二进制字符串。
否则（既未指定_charset_name
也未指定）：
COLLATE
collation_name
对于字符串文字，使用
character_set_connection
和
collation_connection
系统变量给出的连接默认字符集和排序规则。
对于十六进制文字或位值文字，字符集和排序规则是
binary.
例子：
具有latin1字符集和latin1_german1_ci排序规则的非二进制字符串：
SELECT _latin1'Müller' COLLATE latin1_german1_ci;
SELECT _latin1 X'0A0D' COLLATE latin1_german1_ci;
SELECT _latin1 b'0110' COLLATE latin1_german1_ci;
具有utf8mb4字符集及其默认排序规则（即
utf8mb4_0900_ai_ci）的非二进制字符串：
SELECT _utf8mb4'Müller';
SELECT _utf8mb4 X'0A0D';
SELECT _utf8mb4 b'0110';binary具有字符集及其默认排序规则（即
）的
二进制字符串binary：
SELECT _binary'Müller';
SELECT X'0A0D';
SELECT b'0110';
十六进制字面量和位值字面量不需要引入符，因为它们默认是二进制字符串。
具有连接默认字符集和utf8mb4_0900_ai_ci排序规则的非二进制字符串（如果连接字符集不是 ，则失败
utf8mb4）：
SELECT 'Müller' COLLATE utf8mb4_0900_ai_ci;
此构造（COLLATE仅）不适用于十六进制文字或位文字，因为它们的字符集binary与连接字符集无关，并且与排序规则binary不兼容
。utf8mb4_0900_ai_ci在没有介绍人的情况下唯一允许COLLATE的条款是COLLATE binary。
具有连接默认字符集和排序规则的字符串：
SELECT 'Müller';
© Mysql 中文网
