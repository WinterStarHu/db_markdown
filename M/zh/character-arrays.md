# 10.13.1 字符定义数组_MySQL 8.0 参考手册

10.13.1 字符定义数组_MySQL 8.0 参考手册
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
10.13.1 字符定义数组1
10.13.2 复杂字符集的字符串整理支持1
10.13.3 复杂字符集的多字节字符支持1
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
MySQL 8.0 参考手册  / 第 10 章字符集、排序规则、Unicode  / 10.13 添加字符集  /
10.13.1 字符定义数组
10.13.1 字符定义数组
每个简单字符集在sql/share/charsets目录中都有一个配置文件。对于名为 的字符集MYSYS，文件名为
MYSET.xml. 它使用<map>数组元素列出字符集属性。<map>
元素出现在这些元素中：
<ctype>定义每个字符的属性。
<lower>并
<upper>列出小写和大写字符。
<unicode>将 8 位字符值映射到 Unicode 值。
<collation>元素指示用于比较和排序的字符顺序，每个排序规则一个元素。二进制归类不需要
<map>元素，因为字符代码本身提供了排序。
对于在目录下的文件中
实现的复杂字符集
，有对应的数组：
,
, 等等。并非每个复杂字符集都具有所有数组。另请参阅现有
文件以获取示例。有关其他信息，
请参阅
目录中的文件
。ctype-MYSET.cstringsctype_MYSET[]to_lower_MYSET[]ctype-*.cCHARSET_INFO.txtstrings
大多数数组按字符值索引并有 256 个元素。该<ctype>数组由字符值 + 1 索引，有 257 个元素。这是处理EOF.
<ctype>数组元素是位值。每个元素描述字符集中单个字符的属性。每个属性都与一个位掩码相关联，定义include/m_ctype.h如下：
#define _MY_U   01      /* Upper case */
#define _MY_L   02      /* Lower case */
#define _MY_NMR 04      /* Numeral (digit) */
#define _MY_SPC 010     /* Spacing character */
#define _MY_PNT 020     /* Punctuation */
#define _MY_CTR 040     /* Control character */
#define _MY_B   0100    /* Blank */
#define _MY_X   0200    /* heXadecimal digit */
给定字符的<ctype>值应该是描述该字符的适用位掩码值的并集。例如，'A'是一个大写字符（_MY_U）和一个十六进制数字（_MY_X），那么它的
ctype值应该这样定义：
ctype['A'+1] = _MY_U | _MY_X = 01 | 0200 = 0201
中的位掩码值m_ctype.h是八进制值，但<ctype>
数组中
的元素MYSET.xml应该写成十六进制值。
<lower>和
<upper>数组保存与字符集的每个成员对应的小写和大写字符
。例如：
lower['A'] should contain 'a'
upper['a'] should contain 'A'
每个<collation>数组指示字符应该如何排序以进行比较和排序。MySQL 根据这些信息的值对字符进行排序。在某些情况下，这与
<upper>数组相同，这意味着排序不区分大小写。对于更复杂的排序规则（对于复杂字符集），请参阅第 10.13.2 节“复杂字符集的字符串整理支持”中关于字符串整理的讨论。
© Mysql 中文网
