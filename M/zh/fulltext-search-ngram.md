# 12.10.8 ngram 全文解析器_MySQL 8.0 参考手册

12.10.8 ngram 全文解析器_MySQL 8.0 参考手册
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
12.10.1 自然语言全文搜索1
12.10.2 布尔全文搜索1
12.10.3 带查询扩展的全文搜索1
12.10.4 全文停用词1
12.10.5 全文限制1
12.10.6 微调 MySQL 全文搜索1
12.10.7 为全文索引添加用户定义的排序规则1
12.10.8 ngram 全文解析器1
12.10.9 MeCab 全文解析器插件1
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
MySQL 8.0 参考手册  / 第 12 章函数和运算符  / 12.10 全文搜索功能  /
12.10.8 ngram 全文解析器
12.10.8 ngram 全文解析器
内置的 MySQL 全文解析器使用单词之间的空格作为分隔符来确定单词的开始和结束位置，这是使用不使用单词分隔符的表意语言时的限制。为了解决这个限制，MySQL 提供了一个支持中文、日文和韩文 (CJK) 的 ngram 全文解析器。ngram 全文解析器支持与InnoDB和
一起使用MyISAM。
笔记
MySQL 还为日语提供了一个 MeCab 全文解析器插件，它将文档标记为有意义的单词。有关详细信息，请参阅第 12.10.9 节，“MeCab 全文解析器插件”。
nngram 是来自给定文本序列
的连续
字符序列。ngram 解析器将文本序列标记为连续的n字符序列。例如，您可以使用 ngram 全文解析器将
“ abcd ”标记为不同的值。nn=1: 'a', 'b', 'c', 'd'
n=2: 'ab', 'bc', 'cd'
n=3: 'abc', 'bcd'
n=4: 'abcd'
ngram 全文解析器是一个内置的服务器插件。与其他内置服务器插件一样，它会在服务器启动时自动加载。
第 12.10 节“全文搜索功能”
中描述的全文搜索语法
适用于 ngram 解析器插件。本节描述了解析行为的差异。与全文相关的配置选项，除了最小和最大字长选项 ( innodb_ft_min_token_size,
innodb_ft_max_token_size,
ft_min_word_len,
ft_max_word_len) 也适用。
配置 ngram 令牌大小
ngram 解析器的默认 ngram 标记大小为 2（二元语法）。例如，标记大小为 2 时，ngram 解析器将字符串“ abc def ”解析为四个标记：
“ ab ”、“ bc ”、“ de ”和
“ ef ”。
ngram 令牌大小可使用
ngram_token_size配置选项进行配置，其最小值为 1，最大值为 10。
通常，ngram_token_size设置为您要搜索的最大标记的大小。如果您只打算搜索单个字符，请设置
ngram_token_size为 1。较小的标记大小会产生较小的全文搜索索引和更快的搜索。如果您需要搜索由多个字符组成的单词，请
ngram_token_size相应地进行设置。例如，“ Happy Birthday ”在简体中文中
是
“生日快乐” ，其中“生日”是
“生日”，而
“快乐”译为“快乐”。要搜索诸如此类的双字符词，请将ngram_token_size
值设置为 2 或更高。
作为只读变量，
ngram_token_size只能设置为启动字符串的一部分或在配置文件中：
启动字符串：
mysqld --ngram_token_size=2
配置文件：
[mysqld]
ngram_token_size=2
笔记
FULLTEXT对于使用 ngram 解析器
的索引，将忽略以下最小和最大字长配置选项： innodb_ft_min_token_size、
innodb_ft_max_token_size、
ft_min_word_len和
ft_max_word_len。
创建使用 ngram 解析器的 FULLTEXT 索引
要创建FULLTEXT使用 ngram 解析器的索引，请指定WITH PARSER ngramwith
CREATE TABLE、
ALTER TABLE或
CREATE INDEX。
以下示例演示了创建带
ngram FULLTEXT索引的表、插入示例数据（简体中文文本）以及查看
INFORMATION_SCHEMA.INNODB_FT_INDEX_CACHE
表中标记化的数据。
mysql> USE test;
mysql> CREATE TABLE articles (
id INT UNSIGNED AUTO_INCREMENT NOT NULL PRIMARY KEY,
title VARCHAR(200),
body TEXT,
FULLTEXT (title,body) WITH PARSER ngram
) ENGINE=InnoDB CHARACTER SET utf8mb4;
mysql> SET NAMES utf8mb4;
INSERT INTO articles (title,body) VALUES
('数据库管理','在本教程中我将向你展示如何管理数据库'),
('数据库应用开发','学习开发数据库应用程序');
mysql> SET GLOBAL innodb_ft_aux_table="test/articles";
mysql> SELECT * FROM INFORMATION_SCHEMA.INNODB_FT_INDEX_CACHE ORDER BY doc_id, position;FULLTEXT要向现有表
添加索引，您可以使用ALTER TABLE或
CREATE INDEX。例如：
CREATE TABLE articles (
id INT UNSIGNED AUTO_INCREMENT NOT NULL PRIMARY KEY,
title VARCHAR(200),
body TEXT
) ENGINE=InnoDB CHARACTER SET utf8mb4;
ALTER TABLE articles ADD FULLTEXT INDEX ft_index (title,body) WITH PARSER ngram;
# Or:
CREATE FULLTEXT INDEX ft_index ON articles (title,body) WITH PARSER ngram;
ngram 解析器空间处理
ngram 解析器在解析时消除了空格。例如：
“ ab cd ”被解析为“ ab ”、
“ cd ”
“ a bc ”被解析为“ bc ”
ngram 解析器停用词处理
内置的 MySQL 全文解析器将单词与停用词列表中的条目进行比较。如果一个词等于停用词列表中的一个条目，则该词将从索引中排除。对于 ngram 解析器，停用词处理的执行方式不同。ngram 解析器不排除与停用词列表中的条目相等的标记，而是排除
包含停用词的标记。例如，假设
ngram_token_size=2包含“ a,b ”的文档被解析为“ a, ”
和“ ,b ”。如果将逗号 ( “ , ” ) 定义为停用词，则两者“ a, ”和“ ,b ”被排除在索引之外，因为它们包含逗号。
默认情况下，ngram 解析器使用默认停用词列表，其中包含英语停用词列表。对于适用于中文、日语或韩语的停用词列表，您必须创建自己的停用词列表。有关创建停用词列表的信息，请参阅
第 12.10.4 节，“全文停用词”。
长度大于
的停用词ngram_token_size将被忽略。
ngram 解析器术语搜索
对于自然语言模式搜索，搜索词被转换为 ngram 词的并集。例如，字符串“ abc ”（假设
ngram_token_size=2）被转换为“ ab bc ”。给定两个文档，一个包含“ ab ”，另一个包含
“ abc ”，搜索词“ ab bc ”匹配两个文档。
对于布尔模式搜索，搜索词被转换为 ngram 短语搜索。例如，字符串 'abc'（假设
ngram_token_size=2）被转换为 ' “ ab bc ” '。给定两个文档，一个包含“ab”，另一个包含“abc”，搜索短语“ “ ab bc ” ”仅匹配包含“abc”的文档。
ngram 解析器通配符搜索
由于FULLTEXTngram 索引仅包含 ngram，并且不包含有关术语开头的信息，因此通配符搜索可能会返回意外结果。以下行为适用于使用 ngram
FULLTEXT搜索索引的通配符搜索：
如果通配符搜索的前缀项短于 ngram 标记大小，则查询将返回包含以前缀项开头的 ngram 标记的所有索引行。例如，假设
ngram_token_size=2搜索“ a* ”返回所有以“ a ”开头的行
。
如果通配符搜索的前缀项长于 ngram 标记大小，则前缀项将转换为 ngram 短语并忽略通配符运算符。例如，假设
ngram_token_size=2“
abc * ”通配符搜索转换为
“ ab bc ”。
ngram 解析器短语搜索
短语搜索转换为 ngram 短语搜索。例如，搜索短语“ abc ”被转换为
“ ab bc ”，返回包含
“ abc ”和“ ab bc ”的文档。
搜索短语“ abc def ”转换为
“ ab bc de ef ”，返回包含
“ abc def ”和“ ab bc de ef ”的文档。不返回
包含“ abcdef ”的文档。
© Mysql 中文网
