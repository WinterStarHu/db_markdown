# 12.10.6 微调 MySQL 全文搜索_MySQL 8.0 参考手册

12.10.6 微调 MySQL 全文搜索_MySQL 8.0 参考手册
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
12.10.6 微调 MySQL 全文搜索
12.10.6 微调 MySQL 全文搜索
MySQL 的全文搜索功能几乎没有用户可调整的参数。如果您有 MySQL 源代码分发，您可以对全文搜索行为施加更多控制，因为某些更改需要修改源代码。参见
第 2.9 节，“从源代码安装 MySQL”。
全文搜索经过仔细调整以提高效率。在大多数情况下修改默认行为实际上会降低效率。除非您知道自己在做什么，否则不要更改 MySQL 源代码。
本节中描述的大多数全文变量必须在服务器启动时设置。需要重新启动服务器才能更改它们；服务器运行时不能修改它们。
一些变量更改需要您重建
FULLTEXT表中的索引。这样做的说明将在本节后面给出。
配置最小和最大字长配置自然语言搜索阈值修改布尔全文搜索运算符字符集修改重建 InnoDB 全文索引优化 InnoDB 全文索引重建 MyISAM 全文索引
配置最小和最大字长
要索引的单词的最小和最大长度由搜索索引的和定义，
以及
搜索
innodb_ft_min_token_size索引
innodb_ft_max_token_size的
定义
。
InnoDBft_min_word_lenft_max_word_lenMyISAM
笔记
最小和最大字长全文参数不适用于FULLTEXT使用 ngram 解析器创建的索引。ngram 标记大小由
ngram_token_size选项定义。
更改任何这些选项后，重建
FULLTEXT索引以使更改生效。例如，要使两个字符的单词可搜索，您可以将以下行放入选项文件中：
[mysqld]
innodb_ft_min_token_size=2
ft_min_word_len=2
然后重新启动服务器并重建
FULLTEXT索引。对于
MyISAM表，请注意
以下用于重建全文索引
的说明中有关myisamchk的注释。MyISAM
配置自然语言搜索阈值
对于MyISAM搜索索引，自然语言搜索的 50% 阈值由所选的特定加权方案决定。要禁用它，请在中查找以下行
storage/myisam/ftdefs.h：
#define GWS_IN_USE GWS_PROB
将该行更改为：
#define GWS_IN_USE GWS_FREQ
然后重新编译MySQL。在这种情况下不需要重建索引。
笔记
通过进行此更改，您会严重
降低 MySQL 为函数提供足够相关值的能力MATCH()
。如果你真的需要搜索这样的常用词，最好使用IN
BOOLEAN MODEinstead 搜索，它不遵守 50% 的阈值。
修改布尔全文搜索运算符
要更改用于对表进行布尔全文搜索的运算符
MyISAM，请设置
ft_boolean_syntax系统变量。（InnoDB没有等效设置。）可以在服务器运行时更​​改此变量，但您必须具有足够的权限才能设置全局系统变量（请参阅
第 5.1.9.1 节，“系统变量权限”）。在这种情况下不需要重建索引。
字符集修改
对于内置的全文解析器，您可以通过多种方式更改被视为单词字符的字符集，如下表所述。进行修改后，为包含任何索引的每个表重建FULLTEXT索引。假设您要将连字符 ('-') 视为单词字符。使用以下方法之一：
修改 MySQL 源代码：在
storage/innobase/handler/ha_innodb.cc
(for InnoDB) 或
storage/myisam/ftdefs.h(for
MyISAM) 中，查看
true_word_char()和
misc_word_char()宏。添加
'-'到其中一个宏并重新编译 MySQL。
修改字符集文件：这不需要重新编译。该true_word_char()
宏使用“字符类型”表来区分字母和数字与其他字符。. 您可以
<ctype><map>在其中一个字符集 XML 文件中编辑数组的内容，以指定它
'-'是一个“字母。”FULLTEXT然后为您的索引使用给定的字符集
。有关<ctype><map>数组格式的信息，请参阅第 10.13.1 节，“字符定义数组”。
为索引列使用的字符集添加新的排序规则，并更改列以使用该排序规则。有关添加归类的一般信息，请参阅第 10.14 节，“向字符集添加归类”。有关特定于全文索引的示例，请参阅
第 12.10.7 节，“为全文索引添加用户定义的排序规则”。
重建 InnoDB 全文索引
为使更改生效，FULLTEXT
必须在修改以下任何全文索引变量后重建索引：
innodb_ft_min_token_size;
innodb_ft_max_token_size;
innodb_ft_server_stopword_table;
innodb_ft_user_stopword_table;
innodb_ft_enable_stopword;
ngram_token_size. 修改
innodb_ft_min_token_size、
innodb_ft_max_token_size或
ngram_token_size需要重新启动服务器。
要重建表FULLTEXT的索引
InnoDB，请使用
ALTER TABLE和
选项删除DROP INDEX并ADD INDEX
重新创建每个索引。
优化 InnoDB 全文索引
在具有全文索引的表上运行OPTIMIZE TABLE会重建全文索引，删除已删除的文档 ID 并在可能的情况下合并同一个词的多个条目。
要优化全文索引，请启用
innodb_optimize_fulltext_only
并运行OPTIMIZE TABLE.
mysql> set GLOBAL innodb_optimize_fulltext_only=ON;
Query OK, 0 rows affected (0.01 sec)
mysql> OPTIMIZE TABLE opening_lines;
+--------------------+----------+----------+----------+
| Table              | Op       | Msg_type | Msg_text |
+--------------------+----------+----------+----------+
| test.opening_lines | optimize | status   | OK       |
+--------------------+----------+----------+----------+
1 row in set (0.01 sec)
为避免大型表上全文索引的重建时间过长，您可以使用该
innodb_ft_num_word_optimize
选项分阶段执行优化。该
innodb_ft_num_word_optimize选项定义每次
OPTIMIZE TABLE运行时优化的单词数。默认设置为 2000，这意味着每次OPTIMIZE
TABLE运行优化 2000 个单词。后续
OPTIMIZE TABLE操作从先前
OPTIMIZE TABLE操作结束的地方继续。
重建 MyISAM 全文索引
如果您修改影响索引的全文变量（ft_min_word_len、
ft_max_word_len或
ft_stopword_file），或者如果您更改停用词文件本身，则必须
FULLTEXT在进行更改并重新启动服务器后重建索引。
要重建表的FULLTEXT索引，
执行修复操作
MyISAM就足够了
：QUICKmysql> REPAIR TABLE tbl_name QUICK;
或者，ALTER TABLE
按照刚才的描述使用。在某些情况下，这可能比修复操作更快。
FULLTEXT必须如刚才所示修复
包含任何索引的每个表。否则，对该表的查询可能会产生不正确的结果，并且对该表的修改会导致服务器将该表视为已损坏并需要修复。
如果您使用myisamchk执行修改MyISAM 表索引的操作（例如修复或分析），
除非您另有指定，否则将使用最小字长、最大字长和停用词文件的默认FULLTEXT全文参数值重建索引
。这可能会导致查询失败。
The problem occurs because these parameters are known only by
the server. They are not stored in MyISAM
index files. To avoid the problem if you have modified the
minimum or maximum word length or stopword file values used by
the server, specify the same
ft_min_word_len,
ft_max_word_len, and
ft_stopword_file values for
myisamchk that you use for
mysqld. For example, if you have set the
minimum word length to 3, you can repair a table with
myisamchk like this:
myisamchk --recover --ft_min_word_len=3 tbl_name.MYI
为确保myisamchk和服务器对全文参数使用相同的值，请将每个参数都放在选项文件的[mysqld]和
[myisamchk]部分中：
[mysqld]
ft_min_word_len=3
[myisamchk]
ft_min_word_len=3
使用myisamchk进行
MyISAM表索引修改的替代方法是使用REPAIR TABLE、
ANALYZE TABLE、
OPTIMIZE TABLE或
ALTER TABLE语句。这些语句由服务器执行，它知道要使用的正确全文参数值。
© Mysql 中文网
