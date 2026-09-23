# 10.9.8 在 3 字节和 4 字节 Unicode 字符集之间转换_MySQL 8.0 参考手册

10.9.8 在 3 字节和 4 字节 Unicode 字符集之间转换_MySQL 8.0 参考手册
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
10.9.1 utf8mb4 字符集（4 字节 UTF-8 Unicode 编码）1
10.9.2 utf8mb3 字符集（3 字节 UTF-8 Unicode 编码）1
10.9.3 utf8 字符集（utf8mb3 的别名）1
10.9.4 ucs2字符集（UCS-2 Unicode编码）1
10.9.5 utf16字符集（UTF-16 Unicode编码）1
10.9.6 utf16le字符集（UTF-16LE Unicode编码）1
10.9.7 utf32字符集（UTF-32 Unicode编码）1
10.9.8 在 3 字节和 4 字节 Unicode 字符集之间转换1
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
MySQL 8.0 参考手册  / 第 10 章字符集、排序规则、Unicode  / 10.9 Unicode 支持  /
10.9.8 在 3 字节和 4 字节 Unicode 字符集之间转换
10.9.8 在 3 字节和 4 字节 Unicode 字符集之间转换
utf8mb3本节介绍在和
utf8mb4字符集
之间转换字符数据时可能遇到的问题。
笔记
此讨论主要集中在 和 之间的转换
utf8mb3，utf8mb4但类似的原则适用于
ucs2字符集与字符集（例如utf16或）之间的转换utf32。
utf8mb3和字符集
的utf8mb4
区别如下：
utf8mb3仅支持基本多语言平面 (BMP) 中的字符。utf8mb4
另外还支持位于 BMP 之外的增补字符。
utf8mb3每个字符最多使用三个字节。utf8mb4每个字符最多使用四个字节。
笔记
此讨论引用utf8mb3和
utf8mb4字符集名称以明确引用 3 字节和 4 字节 UTF-8 字符集数据。
utf8mb3将 from 转换为to
的
一个优点utf8mb4是这使应用程序能够使用增补字符。一个权衡是这可能会增加数据存储空间需求。
就表格内容而言，从
utf8mb3到的转换utf8mb4
没有问题：
对于一个BMP字符，utf8mb4具有
utf8mb3相同的存储特性：相同的码值、相同的编码、相同的长度。
对于增补字符，utf8mb4
需要四个字节来存储，而
utf8mb3根本不能存储字符。将utf8mb3列转换为 时
utf8mb4，您不必担心转换增补字符，因为没有增补字符。
就表结构而言，这些是主要的潜在不兼容性：
对于可变长度字符数据类型（VARCHAR和
TEXT类型），列的最大允许字符长度小于
utf8mb4列
utf8mb3。
对于所有字符数据类型（CHAR、
VARCHAR和
类型），列
TEXT可以索引的最大字符数少于
列。
utf8mb4utf8mb3
因此，要将表从 转换utf8mb3
为utf8mb4，可能需要更改某些列或索引定义。
可以使用 将表从转换utf8mb3为
。假设一个表有这样的定义：
utf8mb4ALTER
TABLECREATE TABLE t1 (
col1 CHAR(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
col2 CHAR(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL
) CHARACTER SET utf8mb3;
以下语句转换t1为 use
utf8mb4：
ALTER TABLE t1
DEFAULT CHARACTER SET utf8mb4,
MODIFY col1 CHAR(10)
CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
MODIFY col2 CHAR(10)
CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL;utf8mb3从到
转换时utf8mb4的问题是列或索引键的最大长度以
字节为单位不变。因此，它在
字符方面更小，因为字符的最大长度是四个字节而不是三个。对于
CHAR、
VARCHAR和
TEXT数据类型，在转换 MySQL 表时注意这些问题：
检查utf8mb3列的所有定义并确保它们不超过存储引擎的最大长度。
检查utf8mb3列上的所有索引并确保它们不超过存储引擎的最大长度。有时由于存储引擎的增强，最大值可能会发生变化。
如果上述条件适用，您必须减少列或索引的定义长度，或者继续使用
utf8mb3rather than
utf8mb4.
以下是一些可能需要进行结构更改的示例：
一TINYTEXT列最多可容纳 255 个字节，因此它最多可容纳 85 个 3 字节或 63 个 4 字节字符。假设您有一个
TINYTEXT使用
utf8mb3但必须能够包含超过 63 个字符的列。您无法将其转换为，
utf8mb4除非您还将数据类型更改为更长的类型，例如
TEXT.
同样，如果要将
很长的
VARCHAR列
从
.
TEXTutf8mb3utf8mb4
InnoDB对于使用
COMPACT
or
REDUNDANT
行格式的表，最大索引长度为 767 字节，因此对于utf8mb3or
utf8mb4列，您最多可以分别索引 255 或 191 个字符。如果您当前的utf8mb3列的索引长度超过 191 个字符，则必须索引更少的字符。
在InnoDB使用
COMPACT
或
REDUNDANT
行格式的表中，这些列和索引定义是合法的：
col1 VARCHAR(500) CHARACTER SET utf8mb3, INDEX (col1(255))
要utf8mb4改为使用，索引必须更小：
col1 VARCHAR(500) CHARACTER SET utf8mb4, INDEX (col1(191))
笔记
对于使用
或
行格式的InnoDB表，允许使用
超过 767 字节（最多 3072 字节）的索引键前缀。使用这些行格式创建的表使您能够分别为或
列索引最多 1024 或 768 个字符。有关相关信息，请参阅第 15.22 节，“InnoDB 限制”和动态行格式。
COMPRESSEDDYNAMICutf8mb3utf8mb4
仅当您的列或索引非常长时，才最有可能需要进行上述类型的更改。否则，您应该能够毫无问题地将表从 转换
utf8mb3为utf8mb4，ALTER TABLE如前所述使用。
以下项目总结了其他潜在的不兼容性：
SET NAMES 'utf8mb4'导致使用 4 字节字符集作为连接字符集。只要服务器没有发送 4 字节的字符，应该就没有问题。否则，期望每个字符最多接收三个字节的应用程序可能会出现问题。相反，希望发送 4 字节字符的应用程序必须确保服务器能够理解它们。
对于复制，如果要在源上使用支持增补字符的字符集，则所有副本也必须理解它们。
此外，请记住一般原则，如果表在源和副本上有不同的定义，这可能会导致意外结果。例如，最大索引键长度的差异使得
utf8mb3在源和
utf8mb4副本上使用存在风险。
如果您已转换为utf8mb4、
utf16、utf16le或
utf32，然后决定转换回
utf8mb3或ucs2（例如，降级到旧版本的 MySQL），则适用以下注意事项：
utf8mb3ucs2数据应该没有问题
。
服务器必须足够新以识别引用您正在转换的字符集的定义。
对于引用
utf8mb4字符集的对象定义，您可以在降级之前
使用mysqldumputf8mb4转储它们，编辑转储文件以将实例更改为utf8，并在旧服务器中重新加载文件，只要其中没有 4 字节字符数据。旧服务器
utf8在转储文件中查看对象定义并创建使用（3 字节）
utf8字符集的新对象。
© Mysql 中文网
