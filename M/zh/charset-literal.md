# 10.3.6 字符串文字字符集和排序规则_MySQL 8.0 参考手册

10.3.6 字符串文字字符集和排序规则_MySQL 8.0 参考手册
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
10.3.6 字符串文字字符集和排序规则
10.3.6 字符串文字字符集和排序规则
每个字符串文字都有一个字符集和一个排序规则。
对于简单语句，字符串具有由
和系统变量
定义的连接默认字符集和排序规则。SELECT
'string'character_set_connectioncollation_connection
字符串文字可能有一个可选的字符集介绍符和COLLATE子句，以将其指定为使用特定字符集和排序规则的字符串：
[_charset_name]'string' [COLLATE collation_name]
该
表达式的正式名称为
介绍人。它告诉解析器，“后面的字符串使用了字符集
。”介绍人不会像往常那样
将字符串更改为介绍人字符集。它不会更改字符串值，但可能会出现填充。介绍人只是一个信号。请参阅
第 10.3.8 节，“字符集介绍人”。
_charset_namecharset_nameCONVERT()
例子：
SELECT 'abc';
SELECT _latin1'abc';
SELECT _binary'abc';
SELECT _utf8mb4'abc' COLLATE utf8mb4_danish_ci;
字符集引入器和COLLATE
子句根据标准 SQL 规范实现。
MySQL通过以下方式确定字符串文字的字符集和排序规则：
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
如果_charset_name未指定但指定，则使用
系统变量和排序规则
给定的连接默认字符集
。
必须是连接默认字符集允许的排序规则。
COLLATE
collation_namecharacter_set_connectioncollation_namecollation_name
否则（既未指定_charset_name
也未指定），使用
和
系统变量
给出的连接默认字符集和排序规则
。COLLATE
collation_namecharacter_set_connectioncollation_connection
例子：
具有latin1字符集和latin1_german1_ci排序规则的非二进制字符串：
SELECT _latin1'Müller' COLLATE latin1_german1_ci;
具有utf8mb4字符集及其默认排序规则（即
utf8mb4_0900_ai_ci）的非二进制字符串：
SELECT _utf8mb4'Müller';
具有binary字符集及其默认排序规则（即
binary）的二进制字符串：
SELECT _binary'Müller';
具有连接默认字符集和utf8mb4_0900_ai_ci排序规则的非二进制字符串（如果连接字符集不是 ，则失败
utf8mb4）：
SELECT 'Müller' COLLATE utf8mb4_0900_ai_ci;
具有连接默认字符集和排序规则的字符串：
SELECT 'Müller';
Introducer 指示后续字符串的字符集，但不会更改解析器在字符串中执行转义处理的方式。转义总是由解析器根据
character_set_connection.
以下示例显示
character_set_connection即使在介绍人在场的情况下也会发生转义处理。这些示例使用
SET NAMES（它更改
character_set_connection了，如第 10.4 节“连接字符集和排序规则”中所述），并使用该
HEX()函数显示结果字符串，以便可以看到确切的字符串内容。
示例 1：
mysql> SET NAMES latin1;
mysql> SELECT HEX('à\n'), HEX(_sjis'à\n');
+------------+-----------------+
| HEX('à\n')  | HEX(_sjis'à\n')  |
+------------+-----------------+
| E00A       | E00A            |
+------------+-----------------+
这里，à（十六进制值
E0）后跟\n换行符的转义序列。转义序列使用的
character_set_connection值进行解释latin1以生成文字换行符（十六进制值0A）。即使是第二个字符串也会发生这种情况。即_sjis
引入器不影响解析器的转义处理。
示例 2：
mysql> SET NAMES sjis;
mysql> SELECT HEX('à\n'), HEX(_latin1'à\n');
+------------+-------------------+
| HEX('à\n')  | HEX(_latin1'à\n')  |
+------------+-------------------+
| E05C6E     | E05C6E            |
+------------+-------------------+
这里，character_set_connection
是sjis一个字符集，其中à后跟
\（十六进制值05
和5C）的序列是一个有效的多字节字符。因此，字符串的前两个字节被解释为单个sjis字符，
\而不被解释为转义字符。以下n（十六进制值
6E）不被解释为转义序列的一部分。即使对于第二个字符串也是如此；介绍人不
_latin1影响转义处理。
© Mysql 中文网
