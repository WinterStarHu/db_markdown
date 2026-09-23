# 27.10 性能模式语句摘要和采样_MySQL 8.0 参考手册

27.10 性能模式语句摘要和采样_MySQL 8.0 参考手册
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
27.1 性能模式快速入门
27.2 性能模式构建配置
27.3 性能模式启动配置
27.4 性能模式运行时配置
27.5 性能模式查询
27.6 性能模式工具命名约定
27.7 性能模式状态监控
27.8 性能模式原子和分子事件
27.9 当前和历史事件的性能模式表
27.10 性能模式语句摘要和采样
27.11 性能模式总表特征
27.12 性能模式表描述
27.13 性能模式选项和变量引用
27.14 性能模式命令选项
27.15 性能模式系统变量
27.16 性能模式状态变量
27.17性能模式内存分配模型
27.18 性能模式和插件
27.19 使用性能模式诊断问题
27.20 性能模式的限制
第 28 章 MySQL 系统模式
第 29 章连接器和 API
第30章MySQL企业版
第31章MySQL工作台
第 32 章 OCI 市场上的 MySQL
附录 A MySQL 8.0 常见问题解答
附录 B 错误信息和常见问题
附录 C 索引
MySQL 词汇表
MySQL 8.0 参考手册  / 第 27 章 MySQL 性能模式  /
27.10 性能模式语句摘要和采样
27.10 性能模式语句摘要和采样
MySQL 服务器能够维护语句摘要信息。摘要过程将每个 SQL 语句转换为规范化形式（语句摘要）并根据规范化结果计算 SHA-256 哈希值（摘要哈希值）。规范化允许对相似的语句进行分组和汇总，以公开有关服务器正在执行的语句类型及其发生频率的信息。对于每个摘要，生成摘要的代表性语句作为样本存储。本节描述语句摘要和抽样是如何发生的以及它们如何有用。
无论 Performance Schema 是否可用，解析器都会进行摘要，以便 MySQL Enterprise Firewall 和查询重写插件等其他功能可以访问语句摘要。
语句摘要一般概念性能模式中的语句摘要语句摘要内存使用报表抽样
语句摘要一般概念
当解析器收到 SQL 语句时，如果需要该摘要，它会计算一个语句摘要，如果以下任何条件为真，则为真：
性能模式摘要检测已启用
MySQL 企业防火墙已启用
查询重写插件已启用
解析器也被
STATEMENT_DIGEST_TEXT()和
STATEMENT_DIGEST()函数使用，应用程序可以调用这些函数来根据 SQL 语句分别计算规范化语句摘要和摘要散列值。
max_digest_length系统变量值确定每个会话可用于计算规范化语句摘要的最大字节数
。一旦在摘要计算期间使用了该数量的空间，就会发生截断：不再收集来自已解析语句的标记或将其计入其摘要值。仅在许多字节的已解析令牌产生相同的规范化语句摘要之后才不同的语句，如果进行比较或汇总以获取摘要统计信息，则这些语句被认为是相同的。
警告
将max_digest_length
系统变量设置为零会禁用摘要生成，这也会禁用需要摘要的服务器功能。
在计算出规范化语句后，会从中计算出 SHA-256 哈希值。此外：
如果启用了 MySQL Enterprise Firewall，它会被调用并且计算出的摘要对它可用。
如果启用了任何查询重写插件，则会调用它并且语句摘要和摘要值可供它使用。
如果 Performance Schema 启用了摘要检测，它会制作规范化语句摘要的副本，为其分配最大
performance_schema_max_digest_length
字节数。因此，如果
performance_schema_max_digest_length
小于
max_digest_length，则副本相对于原件被截断。规范化语句摘要的副本与从原始规范化语句计算的 SHA-256 哈希值一起存储在适当的性能模式表中。（如果 Performance Schema 截断了其相对于原始语句摘要的规范化语句摘要副本，则它不会重新计算 SHA-256 哈希值。）
语句规范化将语句文本转换为更标准化的摘要字符串表示形式，该表示形式保留了一般语句结构，同时删除了对该结构不重要的信息：
保留对象标识符，例如数据库和表名称。
文字值被转换为参数标记。规范化语句不保留名称、密码、日期等信息。
删除注释并调整空格。
考虑这些陈述：
SELECT * FROM orders WHERE customer_id=10 AND quantity>20
SELECT * FROM orders WHERE customer_id = 20 AND quantity > 100
为了规范化这些语句，解析器用空格替换数据值?并调整空格。两个语句产生相同的规范化形式，因此被认为是
“相同的”：
SELECT * FROM orders WHERE customer_id = ? AND quantity > ?
规范化语句包含的信息较少，但仍代表原始语句。具有不同数据值的其他类似语句具有相同的规范化形式。
现在考虑这些陈述：
SELECT * FROM customers WHERE customer_id = 1000
SELECT * FROM orders WHERE customer_id = 1000
在这种情况下，规范化语句不同，因为对象标识符不同：
SELECT * FROM customers WHERE customer_id = ?
SELECT * FROM orders WHERE customer_id = ?
如果规范化生成的语句超出摘要缓冲区中的可用空间（由确定
max_digest_length），则会发生截断并且文本以“ ... ”结尾。仅在“ ... ”之后出现的部分不同的长规范化语句被认为是相同的。考虑这些陈述：
SELECT * FROM mytable WHERE cola = 10 AND colb = 20
SELECT * FROM mytable WHERE cola = 10 AND colc = 20
如果截断恰好在 之后
AND，则两个语句都具有以下规范化形式：
SELECT * FROM mytable WHERE cola = ? AND ...
在这种情况下，第二列名称中的差异将丢失，并且两个语句被认为是相同的。
性能模式中的语句摘要
在 Performance Schema 中，语句摘要涉及这些元素：
表中的statements_digest消费者
setup_consumers控制性能模式是否维护摘要信息。请参阅
声明摘要消费者。
语句事件表（events_statements_current、
events_statements_history和
events_statements_history_long）具有用于存储规范化语句摘要和相应摘要 SHA-256 哈希值的列：
DIGEST_TEXT是规范化语句摘要的文本。这是原始规范化语句的副本，已计算为最大
max_digest_length
字节数，必要时进一步截断为
performance_schema_max_digest_length
字节数。
DIGEST是从原始规范化语句计算的摘要 SHA-256 哈希值。
请参阅第 27.12.6 节，“性能模式语句事件表”。
摘要
events_statements_summary_by_digest
表提供聚合的语句摘要信息。此表汇总了每个语句SCHEMA_NAME和
DIGEST组合的信息。Performance Schema 使用 SHA-256 哈希值进行聚合，因为它们计算速度快，并且具有有利的统计分布，可以最大限度地减少冲突。请参阅
第 27.12.20.3 节，“语句汇总表”。
一些性能表有一列存储原始 SQL 语句，从中计算摘要：
、
和
语句事件表
的SQL_TEXT列
。events_statements_currentevents_statements_historyevents_statements_history_long
汇总表
的QUERY_SAMPLE_TEXT列
。events_statements_summary_by_digest
默认情况下，语句显示的最大可用空间为 1024 字节。要更改此值，请
performance_schema_max_sql_text_length
在服务器启动时设置系统变量。更改会影响刚刚命名的所有列所需的存储空间。
performance_schema_max_digest_length
系统变量确定性能模式中摘要值存储的每个语句可用的最大字节数
。
但是，由于关键字和文字值等语句元素的内部编码，语句摘要的显示长度可能比可用缓冲区大小长。因此，从
DIGEST_TEXT语句事件表的列中选择的值可能看起来超过该
performance_schema_max_digest_length
值。
摘要
events_statements_summary_by_digest
表提供了服务器执行的语句的配置文件。它显示了应用程序正在执行的语句类型以及执行频率。应用程序开发人员可以使用此信息以及表中的其他信息来评估应用程序的性能特征。例如，显示等待时间、锁定时间或索引使用情况的表列可能会突出显示效率低下的查询类型。这使开发人员可以深入了解应用程序的哪些部分需要注意。
汇总表
events_statements_summary_by_digest
具有固定大小。默认情况下，性能模式估计启动时使用的大小。要明确指定表大小，请
performance_schema_digests_size
在服务器启动时设置系统变量。如果表已满，则性能模式会将具有
SCHEMA_NAME和DIGEST
值与表中现有值不匹配的语句分组在特殊行中SCHEMA_NAME并
DIGEST设置为NULL。这允许计算所有语句。但是，如果特殊行占执行语句的很大百分比，则可能需要通过增加 来增加摘要表的大小
performance_schema_digests_size。
语句摘要内存使用
对于生成仅在末尾不同的非常长的语句的应用程序，增加
max_digest_length可以计算摘要以区分否则会聚合到同一摘要的语句。相反，减少
max_digest_length会导致服务器将更少的内存用于摘要存储，但会增加较长语句聚合到同一摘要的可能性。管理员应该记住，较大的值会导致相应增加的内存需求，特别是对于涉及大量同时会话的工作负载（服务器
max_digest_length为每个会话分配字节）。
如前所述，由解析器计算的规范化语句摘要被限制为最大
max_digest_length字节数，而存储在性能模式中的规范化语句摘要使用
performance_schema_max_digest_length
字节。以下内存使用注意事项适用于
max_digest_length和
的相对值performance_schema_max_digest_length：
如果max_digest_length小于
performance_schema_max_digest_length：
性能模式以外的服务器功能使用最多
max_digest_length
字节的规范化语句摘要。
Performance Schema 不会进一步截断它存储的规范化语句摘要，而是
max_digest_length为每个摘要分配比字节数更多的内存，这是不必要的。
如果max_digest_length等于
performance_schema_max_digest_length：
性能模式以外的服务器功能使用最多
max_digest_length
字节的规范化语句摘要。
Performance Schema 不会进一步截断它存储的规范化语句摘要，并分配与
max_digest_length每个摘要字节数相同的内存量。
如果max_digest_length大于
performance_schema_max_digest_length：
性能模式以外的服务器功能使用最多
max_digest_length
字节的规范化语句摘要。
Performance Schema 进一步截断它存储的规范化语句摘要，并分配比
max_digest_length每个摘要字节数更少的内存。
因为 Performance Schema 语句事件表可能存储许多摘要，所以设置
performance_schema_max_digest_length
小于max_digest_length
使管理员能够平衡这些因素：
需要有长的规范化语句摘要可用于性能模式之外的服务器功能
许多并发会话，每个会话分配摘要计算内存
在存储许多语句摘要时需要限制 Performance Schema 语句事件表的内存消耗
该
performance_schema_max_digest_length
设置不是每个会话，它是每个语句，一个会话可以在
events_statements_history表中存储多个语句。此表中的典型语句数是每个会话 10 个，因此每个会话
performance_schema_max_digest_length
仅针对此表消耗 10 倍的值所指示的内存。
此外，在全球范围内收集了许多声明（和摘要），最显着的是在
events_statements_history_long
表中。在这里，N存储的语句也会消耗值N指示的内存的倍数
performance_schema_max_digest_length
。
要评估用于 SQL 语句存储和摘要计算的内存量，请使用
SHOW ENGINE
PERFORMANCE_SCHEMA STATUS语句或监控这些工具：
mysql> SELECT NAME
FROM performance_schema.setup_instruments
WHERE NAME LIKE '%.sqltext';
+------------------------------------------------------------------+
| NAME                                                             |
+------------------------------------------------------------------+
| memory/performance_schema/events_statements_history.sqltext      |
| memory/performance_schema/events_statements_current.sqltext      |
| memory/performance_schema/events_statements_history_long.sqltext |
+------------------------------------------------------------------+
mysql> SELECT NAME
FROM performance_schema.setup_instruments
WHERE NAME LIKE 'memory/performance_schema/%.tokens';
+----------------------------------------------------------------------+
| NAME                                                                 |
+----------------------------------------------------------------------+
| memory/performance_schema/events_statements_history.tokens           |
| memory/performance_schema/events_statements_current.tokens           |
| memory/performance_schema/events_statements_summary_by_digest.tokens |
| memory/performance_schema/events_statements_history_long.tokens      |
+----------------------------------------------------------------------+
报表抽样
Performance Schema 使用语句抽样来收集产生
events_statements_summary_by_digest
表中每个摘要值的代表性语句。这些列存储示例语句信息：（语句
QUERY_SAMPLE_TEXT的文本）、QUERY_SAMPLE_SEEN（看到
QUERY_SAMPLE_TIMER_WAIT语句的时间）和（语句等待或执行时间）。每次选择示例语句时，性能模式都会更新所有三列。
插入新的表行时，生成行摘要值的语句将存储为与摘要关联的当前样本语句。此后，当服务器看到其他具有相同摘要值的语句时，它决定是否使用新语句来替换当前样本语句（即是否重新采样）。重采样策略基于当前示例语句和新语句的比较等待时间，以及可选的当前示例语句的年龄：
根据等待时间重采样：如果新语句等待时间的等待时间大于当前样本语句的等待时间，则成为当前样本语句。
基于年龄的重采样：如果
performance_schema_max_digest_sample_age
系统变量的值大于零，并且当前样本语句超过该秒数，则当前语句被认为“太旧”
，新语句将替换它。即使新语句等待时间小于当前示例语句的等待时间，也会发生这种情况。
默认情况下，
performance_schema_max_digest_sample_age
为 60 秒（1 分钟）。要更改示例语句因老化而“过期”的速度，请增加或减少该值。要禁用重采样策略的基于年龄的部分，请设置
performance_schema_max_digest_sample_age
为 0。
© Mysql 中文网
