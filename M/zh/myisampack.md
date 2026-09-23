# 4.6.6 myisampack——生成压缩的、只读的 MyISAM 表_MySQL 8.0 参考手册

4.6.6 myisampack——生成压缩的、只读的 MyISAM 表_MySQL 8.0 参考手册
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
4.1 MySQL程序概述
4.2 使用 MySQL 程序
4.3 服务器和服务器启动程序
4.4 安装相关程序
4.5 客户端程序
4.6 管理和实用程序
4.6.1 ibd2sdi — InnoDB 表空间 SDI 提取实用程序1
4.6.2 innochecksum — 离线 InnoDB 文件校验和工具1
4.6.3 myisam_ftdump——显示全文索引信息1
4.6.4 myisamchk — MyISAM 表维护实用程序1
4.6.5 myisamlog——显示MyISAM日志文件内容1
4.6.6 myisampack——生成压缩的、只读的 MyISAM 表1
4.6.7 mysql_config_editor — MySQL 配置实用程序1
4.6.8 mysql_migrate_keyring — 密钥环密钥迁移实用程序1
4.6.9 mysqlbinlog — 处理二进制日志文件的实用程序1
4.6.10 mysqldumpslow——总结慢查询日志文件1
4.7 程序开发实用程序
4.8 杂项程序
4.9 环境变量
4.10 MySQL 中的 Unix 信号处理
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
第 28 章 MySQL 系统模式
第 29 章连接器和 API
第30章MySQL企业版
第31章MySQL工作台
第 32 章 OCI 市场上的 MySQL
附录 A MySQL 8.0 常见问题解答
附录 B 错误信息和常见问题
附录 C 索引
MySQL 词汇表
MySQL 8.0 参考手册  / 第 4 章 MySQL 程序  / 4.6 管理和实用程序  /
4.6.6 myisampack——生成压缩的、只读的 MyISAM 表
4.6.6 myisampack——生成压缩的、只读的 MyISAM 表
myisampack实用程序压缩
表MyISAM。myisampack
通过分别压缩表中的每一列来工作。通常，myisampack将数据文件打包 40% 到 70%。
稍后使用该表时，服务器会将解压缩列所需的信息读入内存。这会在访问单个行时产生更好的性能，因为您只需要解压缩一行。
MySQLmmap()在可能的情况下使用对压缩表执行内存映射。如果
mmap()不起作用，MySQL 将回退到正常的读/写文件操作。
请注意以下事项：
如果在禁用外部锁定的情况下调用
mysqld服务器，如果表可能在打包过程中由服务器更新，则调用myisampack不是一个好主意。在服务器停止的情况下压缩表是最安全的。
打包表后，它变为只读。这通常是有意的（例如访问 CD 上的打包表时）。
myisampack不支持分区表。
像这样调用myisampack：
myisampack [options] file_name ...
每个文件名参数应该是索引 ( .MYI) 文件的名称。如果不在数据库目录中，则应指定文件的路径名。允许省略.MYI扩展名。
使用myisampack
压缩表后，使用myisamchk -rq重建其索引。
第 4.6.4 节，“myisamchk — MyISAM 表维护实用程序”。
myisampack支持以下选项。它还读取选项文件并支持第 4.2.2.3 节“影响选项文件处理的命令行选项”。
--help,
-?
显示帮助信息并退出。
--backup,
-b
使用名称对每个表的数据文件进行备份
tbl_name.OLD。
--character-sets-dir=dir_name
安装字符集的目录。请参阅
第 10.15 节，“字符集配置”。
--debug[=debug_options],
-#
[debug_options]
写调试日志。典型的
debug_options字符串是
. 默认值为。
d:t:o,file_named:t:o
仅当 MySQL 是使用
WITH_DEBUG. Oracle 提供的 MySQL 发布二进制文件不是
使用此选项构建的。
--force,
-f
生成打包表，即使它变得比原始表大，或者如果myisampack的早期调用的中间文件存在。（myisampack在压缩表时创建一个在数据库目录中命名的中间文件
tbl_name.TMD
。如果你杀死myisampack，该
.TMD文件可能不会被删除。）通常，如果myisampack发现
tbl_name.TMD
存在，则退出并出错。无论如何，myisampack 都会--force打包
表格。
--join=big_tbl_name,
-j big_tbl_name
将命令行中命名的所有表连接到一个压缩表中big_tbl_name。要合并的所有表必须
具有相同的结构（相同的列名和类型、相同的索引等）。
big_tbl_name在加入操作之前不得存在。所有在命令行中命名的要合并到的源表都
big_tbl_name必须存在。为连接操作读取源表，但不修改。
--silent,
-s
静音模式。仅在发生错误时写入输出。
--test,
-t
不要实际打包桌子，只是测试打包它。
--tmpdir=dir_name,
-T dir_name
使用命名目录作为
myisampack创建临时文件的位置。
--verbose,
-v
详细模式。写入有关打包操作的进度及其结果的信息。
--version,
-V
显示版本信息并退出。
--wait,
-w
如果表正在使用中，请等待并重试。如果在
禁用外部锁定的情况下调用
mysqld服务器，如果表可能在打包过程中由服务器更新，则
调用myisampack不是一个好主意。
以下命令序列说明了典型的表压缩会话：
$> ls -l station.*
-rw-rw-r--   1 jones    my         994128 Apr 17 19:00 station.MYD
-rw-rw-r--   1 jones    my          53248 Apr 17 19:00 station.MYI
$> myisamchk -dvv station
MyISAM file:     station
Isam-version:  2
Creation time: 1996-03-13 10:08:58
Recover time:  1997-02-02  3:06:43
Data records:              1192  Deleted blocks:              0
Datafile parts:            1192  Deleted data:                0
Datafile pointer (bytes):     2  Keyfile pointer (bytes):     2
Max datafile length:   54657023  Max keyfile length:   33554431
Recordlength:               834
Record format: Fixed length
table description:
Key Start Len Index   Type                 Root  Blocksize    Rec/key
1   2     4   unique  unsigned long        1024       1024          1
2   32    30  multip. text                10240       1024          1
Field Start Length Type
1     1     1
2     2     4
3     6     4
4     10    1
5     11    20
6     31    1
7     32    30
8     62    35
9     97    35
10    132   35
11    167   4
12    171   16
13    187   35
14    222   4
15    226   16
16    242   20
17    262   20
18    282   20
19    302   30
20    332   4
21    336   4
22    340   1
23    341   8
24    349   8
25    357   8
26    365   2
27    367   2
28    369   4
29    373   4
30    377   1
31    378   2
32    380   8
33    388   4
34    392   4
35    396   4
36    400   4
37    404   1
38    405   4
39    409   4
40    413   4
41    417   4
42    421   4
43    425   4
44    429   20
45    449   30
46    479   1
47    480   1
48    481   79
49    560   79
50    639   79
51    718   79
52    797   8
53    805   1
54    806   1
55    807   20
56    827   4
57    831   4
$> myisampack station.MYI
Compressing station.MYI: (1192 records)
- Calculating statistics
normal:     20  empty-space:   16  empty-zero:     12  empty-fill:  11
pre-space:   0  end-space:     12  table-lookups:   5  zero:         7
Original trees:  57  After join: 17
- Compressing file
87.14%
Remember to run myisamchk -rq on compressed tables
$> myisamchk -rq station
- check record delete-chain
- recovering (with sort) MyISAM-table 'station'
Data records: 1192
- Fixing index 1
- Fixing index 2
$> mysqladmin -uroot flush-tables
$> ls -l station.*
-rw-rw-r--   1 jones    my         127874 Apr 17 19:00 station.MYD
-rw-rw-r--   1 jones    my          55296 Apr 17 19:04 station.MYI
$> myisamchk -dvv station
MyISAM file:     station
Isam-version:  2
Creation time: 1996-03-13 10:08:58
Recover time:  1997-04-17 19:04:26
Data records:               1192  Deleted blocks:              0
Datafile parts:             1192  Deleted data:                0
Datafile pointer (bytes):      3  Keyfile pointer (bytes):     1
Max datafile length:    16777215  Max keyfile length:     131071
Recordlength:                834
Record format: Compressed
table description:
Key Start Len Index   Type                 Root  Blocksize    Rec/key
1   2     4   unique  unsigned long       10240       1024          1
2   32    30  multip. text                54272       1024          1
Field Start Length Type                         Huff tree  Bits
1     1     1      constant                             1     0
2     2     4      zerofill(1)                          2     9
3     6     4      no zeros, zerofill(1)                2     9
4     10    1                                           3     9
5     11    20     table-lookup                         4     0
6     31    1                                           3     9
7     32    30     no endspace, not_always              5     9
8     62    35     no endspace, not_always, no empty    6     9
9     97    35     no empty                             7     9
10    132   35     no endspace, not_always, no empty    6     9
11    167   4      zerofill(1)                          2     9
12    171   16     no endspace, not_always, no empty    5     9
13    187   35     no endspace, not_always, no empty    6     9
14    222   4      zerofill(1)                          2     9
15    226   16     no endspace, not_always, no empty    5     9
16    242   20     no endspace, not_always              8     9
17    262   20     no endspace, no empty                8     9
18    282   20     no endspace, no empty                5     9
19    302   30     no endspace, no empty                6     9
20    332   4      always zero                          2     9
21    336   4      always zero                          2     9
22    340   1                                           3     9
23    341   8      table-lookup                         9     0
24    349   8      table-lookup                        10     0
25    357   8      always zero                          2     9
26    365   2                                           2     9
27    367   2      no zeros, zerofill(1)                2     9
28    369   4      no zeros, zerofill(1)                2     9
29    373   4      table-lookup                        11     0
30    377   1                                           3     9
31    378   2      no zeros, zerofill(1)                2     9
32    380   8      no zeros                             2     9
33    388   4      always zero                          2     9
34    392   4      table-lookup                        12     0
35    396   4      no zeros, zerofill(1)               13     9
36    400   4      no zeros, zerofill(1)                2     9
37    404   1                                           2     9
38    405   4      no zeros                             2     9
39    409   4      always zero                          2     9
40    413   4      no zeros                             2     9
41    417   4      always zero                          2     9
42    421   4      no zeros                             2     9
43    425   4      always zero                          2     9
44    429   20     no empty                             3     9
45    449   30     no empty                             3     9
46    479   1                                          14     4
47    480   1                                          14     4
48    481   79     no endspace, no empty               15     9
49    560   79     no empty                             2     9
50    639   79     no empty                             2     9
51    718   79     no endspace                         16     9
52    797   8      no empty                             2     9
53    805   1                                          17     1
54    806   1                                           3     9
55    807   20     no empty                             3     9
56    827   4      no zeros, zerofill(2)                2     9
57    831   4      no zeros, zerofill(1)                2     9
myisampack显示以下类型的信息：
normal
未使用额外填料的色谱柱数。
empty-space
包含仅为空格的值的列数。这些占一位。
empty-zero
包含仅为二进制零的值的列数。这些占一位。
empty-fill
不占据其类型的完整字节范围的整数列数。这些被更改为较小的类型。例如，如果一列（八个字节）的所有值都在从
到的范围内，则它BIGINT
可以存储为一
列（一个字节） 。
TINYINT-128127
pre-space
以前导空格存储的十进制列数。在这种情况下，每个值都包含前导空格数的计数。
end-space
具有大量尾随空格的列数。在这种情况下，每个值都包含尾随空格数的计数。
table-lookup
该列只有少量不同的值，这些值被转换为
ENUM之前的霍夫曼压缩。
zero
所有值为零的列数。
Original trees
霍夫曼树的初始数量。
After join
加入树以节省一些头部空间后留下的不同霍夫曼树的数量。
压缩表后，myisamchk -dvvField
显示的行包括有关每一列的附加信息：
Type
数据类型。该值可能包含以下任何描述符：
constant
所有行都具有相同的值。
no endspace
不要储存末端空间。
no endspace, not_always
不要存储端空间，也不要对所有值进行端空间压缩。
no endspace, no empty
不要储存末端空间。不要存储空值。
table-lookup
该列已转换为
ENUM.
zerofill(N)
值中最重要N的字节始终为 0，并且不会被存储。
no zeros
不要存储零。
always zero
零值使用一位存储。
Huff tree
与列关联的哈夫曼树的编号。
Bits
霍夫曼树中使用的位数。
运行myisampack后，使用
myisamchk重新创建任何索引。这时，您还可以对索引块进行排序并创建 MySQL 优化器更有效地工作所需的统计信息：
myisamchk -rq --sort-index --analyze tbl_name.MYI
将打包表安装到 MySQL 数据库目录后，应执行mysqladmin flush-tables以强制mysqld开始使用新表。
要解压缩打包表，请使用
myisamchk--unpack的选项
。
© Mysql 中文网
