# 10.7 列字符集转换_MySQL 8.0 参考手册

10.7 列字符集转换_MySQL 8.0 参考手册
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
MySQL 8.0 参考手册  / 第 10 章字符集、排序规则、Unicode  /
10.7 列字符集转换
10.7 列字符集转换
要将二进制或非二进制字符串列转换为使用特定字符集，请使用ALTER TABLE. 要成功转换，必须满足以下条件之一：
如果该列具有二进制数据类型 ( BINARY,
VARBINARY,
BLOB)，则它包含的所有值都必须使用单个字符集（您要将该列转换为的字符集）进行编码。如果使用二进制列存储多个字符集的信息，MySQL 无法知道哪些值使用哪个字符集，也无法正确转换数据。
如果列具有非二进制数据类型 ( CHAR,
VARCHAR,
TEXT)，则其内容应使用列字符集而不是其他字符集进行编码。如果内容以不同的字符集编码，您可以先将该列转换为使用二进制数据类型，然后再转换为具有所需字符集的非二进制列。
假设一个表t有一个名为col1定义为
的二进制列VARBINARY(50)。假设列中的信息使用单个字符集进行编码，您可以将其转换为具有该字符集的非二进制列。例如，如果col1包含表示字符greek集中字符的二进制数据，则可以按如下方式转换：
ALTER TABLE t MODIFY col1 VARCHAR(50) CHARACTER SET greek;
如果您的原始列的类型为
BINARY(50)，您可以将其转换为
，但结果值在末尾CHAR(50)用字节填充，这可能是不希望的。0x00要删除这些字节，请使用以下
TRIM()函数：
UPDATE t SET col1 = TRIM(TRAILING 0x00 FROM col1);
假设该表t有一个名为col1defined as的非二进制列，CHAR(50)
CHARACTER SET latin1但您希望将其转换为 use
utf8mb4以便您可以存储来自多种语言的值。以下语句完成此操作：
ALTER TABLE t MODIFY col1 CHAR(50) CHARACTER SET utf8mb4;
如果列包含不在两个字符集中的字符，则转换可能有损。
如果您有 MySQL 4.1 之前的旧表，则会出现一种特殊情况，其中非二进制列包含的值实际上是在与服务器默认字符集不同的字符集中编码的。例如，应用程序可能将
sjis值存储在列中，即使 MySQL 的默认字符集不同。可以转换列以使用正确的字符集，但需要一个额外的步骤。假设服务器的默认字符集过去
latin1和col1现在都定义为CHAR(50)但其内容是
sjis值。第一步是将列转换为二进制数据类型，这会在不执行任何字符转换的情况下删除现有的字符集信息：
ALTER TABLE t MODIFY col1 BLOB;
下一步是将该列转换为具有适当字符集的非二进制数据类型：
ALTER TABLE t MODIFY col1 CHAR(50) CHARACTER SET sjis;此过程要求在升级到 MySQL 4.1 或更高版本之后
，该表尚未使用诸如
INSERT或
之类的语句进行修改。UPDATE在这种情况下，MySQL 将使用 将新值存储在列中latin1，并且该列将包含sjis和
latin1值的混合并且无法正确转换。
如果您在最初创建列时指定了属性，则在使用 更改表时也应该指定它们
ALTER TABLE。例如，如果您指定NOT NULL了一个显式
DEFAULT值，您还应该在ALTER TABLE语句中提供它们。否则，生成的列定义不包括那些属性。
要转换表中的所有字符列，该语句可能很有用。请参阅第 13.1.9 节，“ALTER TABLE 语句”。
ALTER
TABLE ... CONVERT TO CHARACTER SET
charset
© Mysql 中文网
