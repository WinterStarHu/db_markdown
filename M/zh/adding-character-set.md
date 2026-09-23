# 10.13 添加字符集_MySQL 8.0 参考手册

10.13 添加字符集_MySQL 8.0 参考手册
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
MySQL 8.0 参考手册  / 第 10 章字符集、排序规则、Unicode  /
10.13 添加字符集
10.13 添加字符集
10.13.1 字符定义数组10.13.2 复杂字符集的字符串整理支持10.13.3 复杂字符集的多字节字符支持
本节讨论向 MySQL 添加字符集的过程。正确的过程取决于字符集是简单的还是复杂的：
如果字符集不需要特殊的字符串整理例程来排序，也不需要多字节字符支持，那就很简单了。
如果字符集需要这些功能中的任何一个，那么它就是复杂的。
例如，greek和swe7
是简单字符集，而big5和
czech是复杂字符集。
要使用以下说明，您必须具有 MySQL 源代码分发。在说明中，
MYSET表示要添加的字符集的名称。
为
文件
添加一个<charset>元素
。使用文件中的现有内容作为添加新内容的指南。该元素的部分清单如下：
MYSETsql/share/charsets/Index.xmllatin1
<charset><charset name="latin1">
<family>Western</family>
<description>cp1252 West European</description>
...
<collation name="latin1_swedish_ci" id="8" order="Finnish, Swedish">
<flag>primary</flag>
<flag>compiled</flag>
</collation>
<collation name="latin1_danish_ci" id="15" order="Danish"/>
...
<collation name="latin1_bin" id="47" order="Binary">
<flag>binary</flag>
<flag>compiled</flag>
</collation>
...
</charset>
该<charset>元素必须列出字符集的所有排序规则。这些必须至少包括二进制排序规则和默认（主要）排序规则。默认排序规则通常使用后缀
general_ci（一般，不区分大小写）命名。二进制排序规则可能是默认排序规则，但通常它们是不同的。默认排序规则应该有一个primary标志。二进制排序规则应该有一个binary标志。
您必须为每个归类分配一个唯一的 ID 号。从 1024 到 2047 的 ID 范围是为用户定义的排序规则保留的。要查找当前使用的归类 ID 的最大值，请使用以下查询：
SELECT MAX(ID) FROM INFORMATION_SCHEMA.COLLATIONS;
此步骤取决于您添加的是简单字符集还是复杂字符集。简单字符集只需要配置文件，而复杂字符集需要定义归类函数、多字节函数或两者的 C 源文件。
对于简单的字符集，创建一个
MYSET.xml描述字符集属性的配置文件。在目录中创建此文件sql/share/charsets。您可以使用 的副本latin1.xml作为此文件的基础。该文件的语法非常简单：
注释被写成普通的 XML 注释 ( )。
<!-- text
-->
数组元素中的单词<map>由任意数量的空格分隔。
数组元素中的每个单词都<map>必须是十六进制格式的数字。
该元素的<map>数组元素
<ctype>有 257 个字。之后的其他<map>数组元素有 256 个字。请参阅
第 10.13.1 节，“字符定义数组”。
<charset>对于中字符集
的元素中列出的每个归类
Index.xml，
MYSET.xml
必须包含一个<collation>
定义字符排序的元素。
对于复杂的字符集，创建一个 C 源文件来描述字符集属性并定义正确执行字符集操作所需的支持例程：
在目录中
创建文件
。查看现有文件之一（例如）以查看需要定义的内容。文件中的数组必须具有 、 等
名称
。这些对应于简单字符集的数组。请参阅第 10.13.1 节，“字符定义数组”。
ctype-MYSET.cstringsctype-*.cctype-big5.cctype_MYSETto_lower_MYSET
对于中字符集<collation>的元素中列出的每个元素，
文件必须提供排序规则的实现。
<charset>Index.xmlctype-MYSET.c
如果字符集需要字符串整理功能，请参阅第 10.13.2 节，“复杂字符集的字符串整理支持”。
如果字符集需要多字节字符支持，请参阅第 10.13.3 节，“复杂字符集的多字节字符支持”。
修改配置信息。使用现有配置信息作为为 . 添加信息的指南
MYSYS。此处的示例假定字符集具有默认排序规则和二进制排序规则，但如果MYSET有其他排序规则，则需要更多行。
编辑mysys/charset-def.c并
“注册”新字符集的排序规则。
将这些行添加到“声明”部分：
#ifdef HAVE_CHARSET_MYSET
extern CHARSET_INFO my_charset_MYSET_general_ci;
extern CHARSET_INFO my_charset_MYSET_bin;
#endif
将这些行添加到“注册”
部分：
#ifdef HAVE_CHARSET_MYSET
add_compiled_collation(&my_charset_MYSET_general_ci);
add_compiled_collation(&my_charset_MYSET_bin);
#endif
如果字符集使用
，编辑并添加
到
变量的定义中。
ctype-MYSET.cstrings/CMakeLists.txtctype-MYSET.cSTRINGS_SOURCES
编辑cmake/character_sets.cmake：
按字母顺序
添加MYSET到 with 的值。CHARSETS_AVAILABLE按字母顺序
添加MYSET到的值
。CHARSETS_COMPLEX即使是简单的字符集也需要这样做，以便CMake可以识别
.
-DDEFAULT_CHARSET=MYSET
重新配置、重新编译和测试。
© Mysql 中文网
