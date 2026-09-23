# 11.3.4 BLOB 和 TEXT 类型_MySQL 8.0 参考手册

11.3.4 BLOB 和 TEXT 类型_MySQL 8.0 参考手册
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
11.1 数值数据类型
11.2 日期和时间数据类型
11.3 字符串数据类型
11.3.1 字符串数据类型语法1
11.3.2 CHAR 和 VARCHAR 类型1
11.3.3 BINARY 和 VARBINARY 类型1
11.3.4 BLOB 和 TEXT 类型1
11.3.5 枚举类型1
11.3.6 SET 类型1
11.4 空间数据类型
11.5 JSON数据类型
11.6 数据类型默认值
11.7 数据类型存储要求
11.8 为列选择正确的类型
11.9 使用来自其他数据库引擎的数据类型
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
MySQL 8.0 参考手册  / 第 11 章数据类型  / 11.3 字符串数据类型  /
11.3.4 BLOB 和 TEXT 类型
11.3.4 BLOB 和 TEXT 类型
ABLOB是一个二进制大对象，可以容纳可变数量的数据。四种BLOB
类型是TINYBLOB、BLOB、
MEDIUMBLOB和LONGBLOB。它们仅在它们可以容纳的值的最大长度上有所不同。四种TEXT类型是
TINYTEXT、TEXT、
MEDIUMTEXT和LONGTEXT。它们对应于四种BLOB类型，并且具有相同的最大长度和存储要求。请参阅
第 11.7 节，“数据类型存储要求”。
BLOB值被视为二进制字符串（字节字符串）。它们有binary
字符集和排序规则，比较和排序是基于列值中字节的数值。
TEXT值被视为非二进制字符串（字符串）。它们具有 以外的字符集
binary，并且根据字符集的排序规则对值进行排序和比较。
如果未启用严格的 SQL 模式，并且您为
BLOB或TEXT列分配了一个超过该列最大长度的值，该值将被截断以适合并生成警告。对于非空格字符的截断，您可能会导致发生错误（而不是警告）并通过使用严格的 SQL 模式禁止插入值。请参阅第 5.1.11 节，“服务器 SQL 模式”。
无论 SQL 模式如何，从要插入TEXT列的值中截断多余的尾随空格总是会生成警告。
对于TEXT和BLOB列，插入时没有填充，选择时也没有删除字节。
如果TEXT列被索引，则索引条目比较在末尾用空格填充。这意味着，如果索引需要唯一值，则对于仅尾随空格数不同的值会发生重复键错误。例如，如果表包含'a'，则尝试存储'a '会导致重复键错误。BLOB对于列
来说情况并非如此。
在大多数方面，您可以将BLOB
列视为任意VARBINARY大的列。同样，你可以把一
TEXT列看成一
VARCHAR列。
BLOB并在以下方面
有所
TEXT不同
：VARBINARYVARCHAR
对于BLOB和
TEXT列的索引，您必须指定索引前缀长度。对于CHARand
VARCHAR，前缀长度是可选的。请参阅第 8.3.5 节，“列索引”。
BLOB并且TEXT列不能有DEFAULT值。
如果将BINARY属性与
TEXT数据类型一起使用，则会为该列分配_bin列字符集的二进制 ( ) 排序规则。
LONG并LONG VARCHAR映射到MEDIUMTEXT数据类型。这是一个兼容性功能。
MySQL Connector/ODBC 将BLOB值定义为
LONGVARBINARY和将TEXT
值定义为LONGVARCHAR.
因为BLOB和TEXT
值可能非常长，您可能会在使用它们时遇到一些限制：
排序时仅使用列的第一个
max_sort_length字节。的默认值为
max_sort_length1024。您可以通过增加
max_sort_length在服务器启动或运行时的值来使更多字节在排序或分组中有效。任何客户端都可以更改其会话max_sort_length
变量的值：
mysql> SET max_sort_length = 2000;
mysql> SELECT id, comment FROM t
-> ORDER BY comment;
使用临时表处理的查询结果中的实例BLOB或
TEXT列导致服务器使用磁盘上的表而不是内存中的表，因为
MEMORY存储引擎不支持这些数据类型（请参阅
第 8.4.4 节，“内部临时表” MySQL 中的表使用”）。使用磁盘会导致性能下降，因此
只有在确实需要时才在查询结果中包含BLOB或列。TEXT例如，避免使用
SELECT *, 它会选择所有列。
BLOB或
对象
的最大大小TEXT由其类型决定，但您实际可以在客户端和服务器之间传输的最大值由可用内存量和通信缓冲区的大小决定。您可以通过更改
max_allowed_packet
变量的值来更改消息缓冲区的大小，但是您必须对服务器和客户端程序都这样做。例如，mysql
和mysqldump都允许您更改客户端
max_allowed_packet值。参见第 5.1.1 节，“配置服务器”，
第 4.5.1 节，“mysql — MySQL 命令行客户端”和第 4.5.4 节，“mysqldump — 数据库备份程序”。您可能还想将数据包大小和要存储的数据对象的大小与存储要求进行比较，请参阅第 11.7 节，“数据类型存储要求”
每个BLOB或TEXT值在内部由单独分配的对象表示。这与所有其他数据类型形成对比，在打开表时，为每列分配一次存储空间。
在某些情况下，可能需要将二进制数据（例如媒体文件）存储在BLOB或
TEXT列中。您可能会发现 MySQL 的字符串处理函数对于处理此类数据很有用。请参阅
第 12.8 节，“字符串函数和运算符”。出于安全和其他原因，通常最好使用应用程序代码而不是为应用程序用户提供
FILE特权。您可以在 MySQL 论坛 ( http://forums.mysql.com/ )
中讨论各种语言和平台的细节。
笔记
在mysql客户端中，二进制字符串使用十六进制表示法显示，具体取决于--binary-as-hex. 有关该选项的更多信息，请参阅第 4.5.1 节，“mysql — MySQL 命令行客户端”。
© Mysql 中文网
