# 11.3.3 BINARY 和 VARBINARY 类型_MySQL 8.0 参考手册

11.3.3 BINARY 和 VARBINARY 类型_MySQL 8.0 参考手册
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
11.3.3 BINARY 和 VARBINARY 类型
11.3.3 BINARY 和 VARBINARY 类型
BINARYandVARBINARY
类型类似于CHARand
，VARCHAR只是它们存储二进制字符串而不是非二进制字符串。也就是说，它们存储字节串而不是字符串。这意味着它们具有binary字符集和排序规则，并且比较和排序基于值中字节的数值。
and的允许最大长度与
BINARYand相同，VARBINARY只是CHARand
VARCHAR的长度以字节BINARY而VARBINARY
不是字符为单位。
和
数据类型不同于BINARY和
数据类型。对于后一种类型，该属性不会导致该列被视为二进制字符串列。相反，它会导致使用列字符集的二进制 ( ) 排序规则（如果未指定列字符集，则使用表默认字符集），并且列本身存储非二进制字符串而不是二进制字节字符串。例如，如果默认字符集是
,则被视为. 这不同于
，后者存储 5 个字节的二进制字符串，这些字符串具有VARBINARYCHAR BINARYVARCHAR BINARYBINARY_binutf8mb4CHAR(5) BINARYCHAR(5) CHARACTER SET utf8mb4 COLLATE
utf8mb4_binBINARY(5)binary字符集和排序规则。有关字符集排序规则与非二进制字符集排序规则之间差异的信息
，
binary请
参阅第 10.8.5 节，“二进制排序规则与 _bin 排序规则的比较”。
binary_bin
如果未启用严格的 SQL 模式，并且您为
BINARY或VARBINARY列分配了一个超过该列最大长度的值，该值将被截断以适合并生成警告。对于截断情况，要导致发生错误（而不是警告）并禁止插入值，请使用严格的 SQL 模式。请参阅
第 5.1.11 节，“服务器 SQL 模式”。
存储值时BINARY，它们会用填充值右填充到指定长度。填充值是0x00（零字节）。0x00对于插入，值用右填充，并且没有尾随字节被删除以进行检索。所有字节在比较中都是有意义的，包括ORDER
BY和DISTINCT运算。
0x00和 space 在比较中有所不同，
0x00在 space 之前进行排序。
示例：对于BINARY(3)列，
插入时
'a '变为
。插入时变为。两个插入的值在检索时保持不变。
'a \0''a\0''a\0\0'
对于VARBINARY，没有用于插入的填充，也没有用于检索的字节被剥离。所有字节在比较中都是有意义的，包括ORDER
BY和DISTINCT运算。
0x00和 space 在比较中有所不同，
0x00在 space 之前进行排序。
对于尾随填充字节被剥离或比较忽略它们的情况，如果列具有需要唯一值的索引，则将值插入到仅尾随填充字节数不同的列中会导致重复键错误。例如，如果表包含'a'，则尝试存储'a\0'会导致重复键错误。
如果您打算使用该
BINARY数据类型来存储二进制数据，并且您要求检索的值与存储的值完全相同，那么您应该仔细考虑前面的填充和剥离特性。以下示例说明了
0x00-paddingBINARY
值如何影响列值比较：
mysql> CREATE TABLE t (c BINARY(3));
Query OK, 0 rows affected (0.01 sec)
mysql> INSERT INTO t SET c = 'a';
Query OK, 1 row affected (0.01 sec)
mysql> SELECT HEX(c), c = 'a', c = 'a\0\0' from t;
+--------+---------+-------------+
| HEX(c) | c = 'a' | c = 'a\0\0' |
+--------+---------+-------------+
| 610000 |       0 |           1 |
+--------+---------+-------------+
1 row in set (0.09 sec)
如果检索到的值必须与为存储指定的值相同且没有填充，则最好使用
VARBINARY或其中一种
BLOB数据类型。
笔记
在mysql客户端中，二进制字符串使用十六进制表示法显示，具体取决于--binary-as-hex. 有关该选项的更多信息，请参阅第 4.5.1 节，“mysql — MySQL 命令行客户端”。
© Mysql 中文网
