# 9.2.3 标识符区分大小写_MySQL 8.0 参考手册

9.2.3 标识符区分大小写_MySQL 8.0 参考手册
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
9.1 文字值
9.2 模式对象名称
9.2.1 标识符长度限制1
9.2.2 标识符限定符1
9.2.3 标识符区分大小写1
9.2.4 标识符到文件名的映射1
9.2.5 函数名解析解析1
9.3 关键字和保留字
9.4 用户自定义变量
9.5 表达式
9.6 查询属性
9.7 评论
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
MySQL 8.0 参考手册  / 第9章语言结构  / 9.2 模式对象名称  /
9.2.3 标识符区分大小写
9.2.3 标识符区分大小写
在 MySQL 中，数据库对应于数据目录中的目录。数据库中的每个表对应于数据库目录中的至少一个文件（可能更多，具体取决于存储引擎）。触发器也对应于文件。因此，底层操作系统的大小写敏感性在数据库、表和触发器名称的大小写敏感性中起着一定的作用。这意味着此类名称在 Windows 中不区分大小写，但在大多数 Unix 变体中区分大小写。一个值得注意的例外是 macOS，它基于 Unix，但使用不区分大小写的默认文件系统类型 (HFS+)。但是，macOS 还支持 UFS 卷，它们与在任何 Unix 上一样区分大小写。看
第 1.7.1 节，“标准 SQL 的 MySQL 扩展”。系统
lower_case_table_names变量还会影响服务器处理标识符区分大小写的方式，如本节后面所述。
笔记
尽管数据库、表和触发器名称在某些平台上不区分大小写，但您不应在同一语句中使用不同的大小写来引用其中之一。以下语句将不起作用，因为它同时引用了一个表 asmy_table和 as
MY_TABLE：
mysql> SELECT * FROM my_table WHERE MY_TABLE.col=1;
分区、子分区、列、索引、存储例程、事件和资源组名称在任何平台上都不区分大小写，列别名也不区分大小写。
但是，日志文件组的名称区分大小写。这与标准 SQL 不同。
默认情况下，表别名在 Unix 上区分大小写，但在 Windows 或 macOS 上则不然。以下语句在 Unix 上不起作用，因为它同时引用了别名 as
a和 as A：
mysql> SELECT col_name FROM tbl_name AS a
WHERE a.col_name = 1 OR A.col_name = 2;
但是，在 Windows 上允许使用相同的语句。为避免此类差异引起的问题，最好采用一致的约定，例如始终使用小写名称创建和引用数据库和表。建议使用此约定以获得最大的便携性和易用性。
表和数据库名称如何存储在磁盘上以及在 MySQL 中如何使用受
lower_case_table_names系统变量的影响。
lower_case_table_names可以取下表所示的值。此变量不
影响触发器标识符的大小写敏感性。在 Unix 上，默认值为
lower_case_table_names0。在 Windows 上，默认值为 1。在 macOS 上，默认值为 2。
lower_case_table_names只能在初始化服务器时配置。lower_case_table_names禁止在服务器初始化后
更改
设置。
价值
意义
0
表名和数据库名使用CREATE
TABLEorCREATE
DATABASE语句中指定的字母大小写存储在磁盘上。名称比较区分大小写。如果在文件名不区分大小写的系统（例如 Windows 或 macOS）上运行 MySQL，则不应将此变量设置为 0。如果
--lower-case-table-names=0
在不区分大小写的文件系统上强制此变量为 0 并
MyISAM使用不同的字母大小写访问表名，则可能导致索引损坏。
1
表名以小写形式存储在磁盘上，名称比较不区分大小写。MySQL 在存储和查找时将所有表名转换为小写。此行为也适用于数据库名称和表别名。
2
表和数据库名称使用CREATE
TABLEorCREATE
DATABASE语句中指定的字母大小写存储在磁盘上，但 MySQL 在查找时将它们转换为小写字母。名称比较不区分大小写。这仅适用于不区分大小写的文件系统！
InnoDB表名和视图名以小写形式存储，对于
lower_case_table_names=1.
如果您只在一个平台上使用 MySQL，您通常不必使用
lower_case_table_names默认设置以外的设置。但是，如果您想要在文件系统区分大小写不同的平台之间传输表，您可能会遇到困难。例如，在 Unix 上，您可以有两个不同的表，名为my_table和
MY_TABLE，但在 Windows 上，这两个名称被认为是相同的。为避免数据库或表名的字母大小写引起的数据传输问题，您有两种选择：
lower_case_table_names=1在所有系统上
使用。这样做的主要缺点是，当您使用SHOW TABLESor
时SHOW DATABASES，您看不到原始字母大小写的名称。
lower_case_table_names=0在 Unix 和
lower_case_table_names=2Windows 上使用
。这保留了数据库和表名的字母大小写。这样做的缺点是您必须确保您的语句在 Windows 上始终引用具有正确字母大小写的数据库和表名。如果您将语句转移到 Unix，其中字母大小写很重要，如果字母大小写不正确，它们将不起作用。
例外：如果您正在使用
InnoDB表并且您正在尝试避免这些数据传输问题，您应该
lower_case_table_names=1在所有平台上使用强制将名称转换为小写。
如果根据二进制排序规则它们的大写形式相等，则对象名称可能被认为是重复的。这适用于游标、条件、过程、函数、保存点、存储的例程参数、存储的程序局部变量和插件的名称。对于列名、约束、数据库、分区、用 准备的语句
PREPARE、表、触发器、用户和用户定义的变量，情况并非如此。
文件系统区分大小写会影响INFORMATION_SCHEMA表的字符串列中的搜索。有关详细信息，请参阅
第 10.8.7 节，“在 INFORMATION_SCHEMA 搜索中使用排序规则”。
© Mysql 中文网
