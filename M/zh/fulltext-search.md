# 12.10 全文搜索功能_MySQL 8.0 参考手册

12.10 全文搜索功能_MySQL 8.0 参考手册
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
MySQL 8.0 参考手册  / 第 12 章函数和运算符  /
12.10 全文搜索功能
12.10 全文搜索功能
12.10.1 自然语言全文搜索12.10.2 布尔全文搜索12.10.3 带查询扩展的全文搜索12.10.4 全文停用词12.10.5 全文限制12.10.6 微调 MySQL 全文搜索12.10.7 为全文索引添加用户定义的排序规则12.10.8 ngram 全文解析器12.10.9 MeCab 全文解析器插件
MATCH
(col1,col2,...)
AGAINST (expr
[search_modifier])
search_modifier:
{
IN NATURAL LANGUAGE MODE
| IN NATURAL LANGUAGE MODE WITH QUERY EXPANSION
| IN BOOLEAN MODE
| WITH QUERY EXPANSION
}
MySQL 支持全文索引和搜索：
MySQL 中的全文索引是 类型的索引
FULLTEXT。
全文索引只能用于
InnoDB或
MyISAM表，并且只能为CHAR、
VARCHAR或
TEXT列创建。
MySQL 提供了一个内置的支持中文、日语和韩语 (CJK) 的全文 ngram 解析器，以及一个可安装的用于日语的 MeCab 全文解析器插件。解析差异在第 12.10.8 节“ngram 全文解析器”和
第 12.10.9 节“MeCab 全文解析器插件”中进行了概述。
FULLTEXT索引定义可以在创建表时在语句中给出
，CREATE TABLE或者稍后使用
ALTER TABLEor
添加CREATE INDEX。
FULLTEXT对于大型数据集，将数据加载到没有索引的表中然后创建索引比将数据加载到具有现有索引的表中
要快得多FULLTEXT。
全文搜索是使用
MATCH() AGAINST()语法执行的。
MATCH()采用逗号分隔的列表来命名要搜索的列。
AGAINST接受一个要搜索的字符串，以及一个可选的修饰符，指示要执行的搜索类型。搜索字符串必须是在查询评估期间保持不变的字符串值。例如，这排除了表列，因为每行可能不同。
以前，MySQL 允许使用带有 的汇总列
MATCH()，但使用此构造的查询执行不佳且结果不可靠。（这是因为它MATCH()不是作为其参数的函数实现的，而是作为基表的基础扫描中当前行的行 ID 的函数实现的。）从 MySQL 8.0.28 开始，MySQL 没有不再允许此类查询；更具体地说，任何符合此处列出的所有条件的查询都会被拒绝
ER_FULLTEXT_WITH_ROLLUP：
MATCH()出现在
查询块
的SELECT列表、GROUP BY
子句、HAVING子句或子句中。ORDER
BY
查询块包含一个GROUP BY ... WITH
ROLLUP子句。
函数调用的参数MATCH()
是分组列之一。
此处显示了此类查询的一些示例：
# MATCH() in SELECT list...
SELECT MATCH (a) AGAINST ('abc') FROM t GROUP BY a WITH ROLLUP;
SELECT 1 FROM t GROUP BY a, MATCH (a) AGAINST ('abc') WITH ROLLUP;
# ...in HAVING clause...
SELECT 1 FROM t GROUP BY a WITH ROLLUP HAVING MATCH (a) AGAINST ('abc');
# ...and in ORDER BY clause
SELECT 1 FROM t GROUP BY a WITH ROLLUP ORDER BY MATCH (a) AGAINST ('abc');允许在子句中
使用MATCH()with a rollup column
。WHERE
全文搜索分为三种类型：
自然语言搜索将搜索字符串解释为自然人类语言中的短语（自由文本中的短语）。没有特殊的运算符，双引号 (") 字符除外。停用词列表适用。有关停用词列表的更多信息，请参阅
第 12.10.4 节，“全文停用词”。
IN NATURAL LANGUAGE MODE如果给出修饰符或没有给出修饰符
，全文搜索是自然语言搜索
。有关详细信息，请参阅
第 12.10.1 节，“自然语言全文搜索”。
布尔搜索使用特殊查询语言的规则解释搜索字符串。该字符串包含要搜索的词。它还可以包含指定要求的运算符，例如匹配行中必须存在或不存在单词，或者它的权重应该比平常高或低。某些常用词（停用词）从搜索索引中省略，如果出现在搜索字符串中则不匹配。IN BOOLEAN MODE修饰符指定布尔搜索。有关详细信息，请参阅
第 12.10.2 节，“布尔全文搜索”。
查询扩展搜索是自然语言搜索的修改。搜索字符串用于执行自然语言搜索。然后将搜索返回的最相关行中的词添加到搜索字符串中，然后再次进行搜索。查询返回来自第二次搜索的行。IN NATURAL LANGUAGE MODE WITH
QUERY EXPANSIONorWITH QUERY
EXPANSION修饰符指定查询扩展搜索。有关详细信息，请参阅
第 12.10.3 节，“使用查询扩展进行全文搜索”。
有关FULLTEXT查询性能的信息，请参阅第 8.3.5 节，“列索引”。
有关InnoDB
FULLTEXT索引的更多信息，请参阅
第 15.6.2.4 节，“InnoDB 全文索引”。
全文搜索的约束在
第 12.10.5 节，“全文限制”中列出。
myisam_ftdump实用程序转储MyISAM全文索引的内容。这可能有助于调试全文查询。请参阅
第 4.6.3 节，“myisam_ftdump — 显示全文索引信息”。
© Mysql 中文网
