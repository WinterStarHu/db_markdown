# 12.10.2 布尔全文搜索_MySQL 8.0 参考手册

12.10.2 布尔全文搜索_MySQL 8.0 参考手册
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
12.10.2 布尔全文搜索
12.10.2 布尔全文搜索
IN BOOLEAN MODEMySQL 可以使用修饰符
执行布尔全文搜索
。使用此修饰符，某些字符在搜索字符串中单词的开头或结尾具有特殊含义。在以下查询中，
+和-运算符分别表示一个词必须存在或不存在，才能进行匹配。因此，查询检索所有包含单词“ MySQL ”但
不包含单词
“ YourSQL ”的行：
mysql> SELECT * FROM articles WHERE MATCH (title,body)
-> AGAINST ('+MySQL -YourSQL' IN BOOLEAN MODE);
+----+-----------------------+-------------------------------------+
| id | title                 | body                                |
+----+-----------------------+-------------------------------------+
|  1 | MySQL Tutorial        | DBMS stands for DataBase ...        |
|  2 | How To Use MySQL Well | After you went through a ...        |
|  3 | Optimizing MySQL      | In this tutorial, we show ...       |
|  4 | 1001 MySQL Tricks     | 1. Never run mysqld as root. 2. ... |
|  6 | MySQL Security        | When configured properly, MySQL ... |
+----+-----------------------+-------------------------------------+
笔记
在实现这个特性时，MySQL 使用了有时被称为隐式布尔逻辑的东西，其中
+代表AND
-代表NOT
[无运算符]表示
OR
布尔全文搜索具有以下特征：
它们不会按照相关性递减的顺序自动对行进行排序。
InnoDB表需要
表达式FULLTEXT所有列的索引
MATCH()才能执行布尔查询。针对
MyISAM搜索索引的布尔查询即使没有索引也可以工作FULLTEXT，尽管以这种方式执行的搜索会非常慢。
最小和最大字长全文参数适用于FULLTEXT使用内置FULLTEXT解析器和 MeCab 解析器插件创建的索引。
innodb_ft_min_token_size
并
innodb_ft_max_token_size
用于InnoDB搜索索引。
ft_min_word_len并
ft_max_word_len用于MyISAM搜索索引。
最小和最大字长全文参数不适用于FULLTEXT使用 ngram 解析器创建的索引。ngram 标记大小由
ngram_token_size选项定义。
停用词列表适用，由
innodb_ft_enable_stopword,
控制innodb_ft_server_stopword_table，并且
innodb_ft_user_stopword_table
用于InnoDB搜索索引，以及
ft_stopword_fileones
MyISAM。
InnoDB全文搜索不支持对单个搜索词使用多个运算符，如本例所示：'++apple'。在单个搜索词上使用多个运算符会向标准输出返回语法错误。MyISAM 全文搜索成功地处理了相同的搜索，忽略了除与搜索词紧邻的运算符之外的所有运算符。
InnoDB全文搜索仅支持前导加号或减号。例如，
InnoDB支持
'+apple'但不支持
'apple+'。指定尾随加号或减号会导致InnoDB报告语法错误。
InnoDB全文搜索不支持使用带通配符的前导加号 ( '+*')、加号和减号组合 ( '+-') 或前加号和减号组合 ( '+-apple')。这些无效查询返回语法错误。
InnoDB全文搜索不支持@在布尔全文搜索中使用符号。该@符号保留供@distance
邻近搜索运算符使用。
他们不使用适用于
MyISAM搜索索引的 50% 阈值。
布尔全文搜索功能支持以下运算符：
+
前导或尾随加号表示该词
必须出现在返回的每一行中。InnoDB仅支持前导加号。
-
前导或尾随减号表示该词不得出现在返回的任何行中。InnoDB仅支持前导减号。
注意：-运算符仅用于排除与其他搜索词匹配的行。因此，仅包含以 开头的术语的布尔模式搜索
-返回空结果。它不会返回“除包含任何排除项的行之外的所有行。”
（无操作员）
默认情况下（未指定+nor
时-），该词是可选的，但包含它的行评级更高。这模仿了MATCH()
AGAINST()没有IN BOOLEAN
MODE修饰符的行为。
@distance
此运算符InnoDB仅适用于表。它测试两个或多个单词是否都在彼此之间指定的距离内开始，以单词为单位。在运算符之前的双引号字符串中指定搜索词
，例如，@distanceMATCH(col1) AGAINST('"word1
word2 word3" @8' IN BOOLEAN MODE)
> <
这两个运算符用于更改单词对分配给行的相关值的贡献。>运营商增加贡献，运营
<商减少贡献。请参阅此列表后面的示例。
( )
括号将单词分组为子表达式。括号内的组可以嵌套。
~
前导波浪号充当否定运算符，导致单词对行相关性的贡献为负。这对于标记“噪音”词很有用。包含这样一个词的行的评级低于其他行，但不会像
-运算符那样被完全排除。
*
星号用作截断（或通配符）运算符。与其他运算符不同，它
附加到要受影响的词。如果单词以运算符之前的单词开头，则单词匹配
*。
如果用截断运算符指定了一个词，则它不会从布尔查询中删除，即使它太短或者是停用词。一个词是否太短是由
表格或
表格的innodb_ft_min_token_size
设置决定的
。这些选项不适用于使用 ngram 解析器的索引。
InnoDBft_min_word_lenMyISAMFULLTEXT
通配符被视为前缀，必须出现在一个或多个单词的开头。如果最小字长为 4，则搜索
返回的行可能少于
搜索返回的行数，因为第二个查询忽略了太短的搜索词
。
'+word +the*''+word +the'the
"
包含在双引号 ( ") 字符中的短语仅匹配包含字面意思的短语的行，因为它是键入的。全文引擎将短语拆分为单词并在
FULLTEXT索引中搜索单词。非单词字符不需要完全匹配：短语搜索只需要匹配包含与短语完全相同的单词并且顺序相同。例如，
"test phrase"匹配"test,
phrase".
如果短语不包含索引中的单词，则结果为空。由于多种因素的组合，这些词可能不在索引中：如果它们在文本中不存在，是停用词，或者比索引词的最小长度短。
以下示例演示了一些使用布尔全文运算符的搜索字符串：
'apple banana'
查找至少包含这两个词之一的行。
'+apple +juice'
查找包含这两个词的行。
'+apple macintosh'
查找包含单词“ apple ”的行，但如果它们还包含
“ macintosh ” ，则对行进行排名。
'+apple -macintosh'
查找包含单词“ apple ”但不
包含“ macintosh ”的行。
'+apple ~macintosh'
查找包含单词“ apple ”的行，但如果该行还包含单词“ macintosh ”，则将其评分低于不包含单词的行。这
比搜索“更软” ，因为“ macintosh ”'+apple
-macintosh'的存在
导致行根本不返回。
'+apple +(>turnover <strudel)'
查找包含单词“ apple ”和
“ turnover ”或“ apple ”和
“ strudel ”（任意顺序）但“ apple turnover ”的排名高于“ apple strudel ”的行。
'apple*'
查找包含“ apple ”、
“ apples ”、“ applesauce ”或
“ applet ”等词的行。
'"some words"'
查找包含确切短语“ some words ”的行（例如，包含“ some words of wisdom ”但不包含“ some noise words ”的行）。请注意，"
包围短语的字符是分隔短语的运算符。它们不是包含搜索字符串本身的引号。
InnoDB 布尔模式搜索的相关性排名
InnoDB全文搜索以
Sphinx全文搜索引擎为蓝本，使用的算法基于
BM25
和
TF-IDF
排序算法。由于这些原因，
InnoDB布尔全文搜索的相关性排名可能与MyISAM相关性排名不同。
InnoDB使用“词频-逆文档频率”
( TF-IDF) 加权系统的变体来对给定全文搜索查询的文档相关性进行排名。权重基于一个词在文档中出现的
TF-IDF频率，由该词在集合中所有文档中出现的频率抵消。也就是说，一个词在文档中出现的频率越高，在文档集合中出现的频率越低，文档的排名就越高。
如何计算相关性排名
词频 ( TF) 值是一个词在文档中出现的次数。单词的逆文档频率 ( IDF) 值使用以下公式计算，其中
total_records是集合中matching_records的记录数， 是搜索词出现的记录数。
${IDF} = log10( ${total_records} / ${matching_records} )
当一个文档多次包含一个词时，IDF值乘以TF值：
${TF} * ${IDF}
使用TF和IDF
值，文档的相关性排名是使用以下公式计算的：
${rank} = ${TF} * ${IDF} * ${IDF}
该公式在以下示例中进行了说明。
单个词搜索的相关性排名
此示例演示了单词搜索的相关性排名计算。
mysql> CREATE TABLE articles (
->   id INT UNSIGNED AUTO_INCREMENT NOT NULL PRIMARY KEY,
->   title VARCHAR(200),
->   body TEXT,
->   FULLTEXT (title,body)
->)  ENGINE=InnoDB;
Query OK, 0 rows affected (1.04 sec)
mysql> INSERT INTO articles (title,body) VALUES
->   ('MySQL Tutorial','This database tutorial ...'),
->   ("How To Use MySQL",'After you went through a ...'),
->   ('Optimizing Your Database','In this database tutorial ...'),
->   ('MySQL vs. YourSQL','When comparing databases ...'),
->   ('MySQL Security','When configured properly, MySQL ...'),
->   ('Database, Database, Database','database database database'),
->   ('1001 MySQL Tricks','1. Never run mysqld as root. 2. ...'),
->   ('MySQL Full-Text Indexes', 'MySQL fulltext indexes use a ..');
Query OK, 8 rows affected (0.06 sec)
Records: 8  Duplicates: 0  Warnings: 0
mysql> SELECT id, title, body,
->   MATCH (title,body) AGAINST ('database' IN BOOLEAN MODE) AS score
->   FROM articles ORDER BY score DESC;
+----+------------------------------+-------------------------------------+---------------------+
| id | title                        | body                                | score               |
+----+------------------------------+-------------------------------------+---------------------+
|  6 | Database, Database, Database | database database database          |  1.0886961221694946 |
|  3 | Optimizing Your Database     | In this database tutorial ...       | 0.36289870738983154 |
|  1 | MySQL Tutorial               | This database tutorial ...          | 0.18144935369491577 |
|  2 | How To Use MySQL             | After you went through a ...        |                   0 |
|  4 | MySQL vs. YourSQL            | When comparing databases ...        |                   0 |
|  5 | MySQL Security               | When configured properly, MySQL ... |                   0 |
|  7 | 1001 MySQL Tricks            | 1. Never run mysqld as root. 2. ... |                   0 |
|  8 | MySQL Full-Text Indexes      | MySQL fulltext indexes use a ..     |                   0 |
+----+------------------------------+-------------------------------------+---------------------+
8 rows in set (0.00 sec)
总共有 8 条记录，其中 3 条与
“数据库”搜索词相匹配。第一条记录 ( id 6) 包含搜索词 6 次，相关性排名为
1.0886961221694946。这个排名值是用TF数值6（
“数据库”搜索词在记录中出现6次
id 6）和IDF数值0.42596873216370745来计算的，计算如下（其中8是记录总数，3是记录数搜索词出现在）：
${IDF} = LOG10( 8 / 3 ) = 0.42596873216370745
然后将TF和IDF值输入排名公式：
${rank} = ${TF} * ${IDF} * ${IDF}
在 MySQL 命令行客户端中执行计算返回排名值 1.088696164686938。
mysql> SELECT 6*LOG10(8/3)*LOG10(8/3);
+-------------------------+
| 6*LOG10(8/3)*LOG10(8/3) |
+-------------------------+
|       1.088696164686938 |
+-------------------------+
1 row in set (0.00 sec)
笔记
您可能会注意到SELECT ... MATCH ...
AGAINST语句和 MySQL 命令行客户端返回的排名值略有不同（1.0886961221694946对比
1.088696164686938）。不同之处在于整数和浮点数/双精度数之间的转换是如何在内部执行的InnoDB（以及相关的精度和舍入决策），以及它们是如何在其他地方执行的，例如在 MySQL 命令行客户端或其他类型的计算器中。
多词搜索的相关性排名
articles此示例演示了基于上一个示例中使用的表和数据
的多词全文搜索的相关性排名计算
。
如果您搜索多个词，则相关度排名值是每个词的相关度排名值的总和，如以下公式所示：
${rank} = ${TF} * ${IDF} * ${IDF} + ${TF} * ${IDF} * ${IDF}
对两个术语（'mysql tutorial'）执行搜索返回以下结果：
mysql> SELECT id, title, body, MATCH (title,body)
->   AGAINST ('mysql tutorial' IN BOOLEAN MODE) AS score
->   FROM articles ORDER BY score DESC;
+----+------------------------------+-------------------------------------+----------------------+
| id | title                        | body                                | score                |
+----+------------------------------+-------------------------------------+----------------------+
|  1 | MySQL Tutorial               | This database tutorial ...          |   0.7405621409416199 |
|  3 | Optimizing Your Database     | In this database tutorial ...       |   0.3624762296676636 |
|  5 | MySQL Security               | When configured properly, MySQL ... | 0.031219376251101494 |
|  8 | MySQL Full-Text Indexes      | MySQL fulltext indexes use a ..     | 0.031219376251101494 |
|  2 | How To Use MySQL             | After you went through a ...        | 0.015609688125550747 |
|  4 | MySQL vs. YourSQL            | When comparing databases ...        | 0.015609688125550747 |
|  7 | 1001 MySQL Tricks            | 1. Never run mysqld as root. 2. ... | 0.015609688125550747 |
|  6 | Database, Database, Database | database database database          |                    0 |
+----+------------------------------+-------------------------------------+----------------------+
8 rows in set (0.00 sec)
在第一条记录（id 8）中，'mysql'出现了一次，'tutorial'出现了两次。“mysql”有六个匹配记录，“tutorial”有两个匹配记录。将这些值插入多词搜索的排名公式时，MySQL 命令行客户端返回预期的排名值：
mysql> SELECT (1*log10(8/6)*log10(8/6)) + (2*log10(8/2)*log10(8/2));
+-------------------------------------------------------+
| (1*log10(8/6)*log10(8/6)) + (2*log10(8/2)*log10(8/2)) |
+-------------------------------------------------------+
|                                    0.7405621541938003 |
+-------------------------------------------------------+
1 row in set (0.00 sec)
笔记
SELECT ... MATCH ... AGAINST前面的示例解释
了语句和 MySQL 命令行客户端返回的排名值的细微差别
。
© Mysql 中文网
