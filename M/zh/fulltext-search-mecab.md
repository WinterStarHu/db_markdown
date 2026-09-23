# 12.10.9 MeCab 全文解析器插件_MySQL 8.0 参考手册

12.10.9 MeCab 全文解析器插件_MySQL 8.0 参考手册
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
12.10.9 MeCab 全文解析器插件
12.10.9 MeCab 全文解析器插件
内置的 MySQL 全文解析器使用单词之间的空格作为分隔符来确定单词的开始和结束位置，这是使用不使用单词分隔符的表意语言时的限制。为了解决日语的这个限制，MySQL 提供了一个 MeCab 全文解析器插件。MeCab 全文解析器插件支持与
InnoDB和
一起使用MyISAM。
笔记
MySQL 还提供了一个支持日语的 ngram 全文解析器插件。有关详细信息，请参阅
第 12.10.8 节，“ngram 全文解析器”。
MeCab 全文解析器插件是用于日语的全文解析器插件，可将文本序列标记为有意义的单词。例如，MeCab
将“テータベース管理”
（“数据库管理”）分
词为“テータベース”
（“数据库”）和
“管理”
（“管理”）。相比之下，
ngram全文解析器将文本标记为连续的
n字符序列，其中
n代表 1 到 10 之间的数字。
除了将文本标记为有意义的词外，MeCab 索引通常比 ngram 索引更小，而且 MeCab 全文搜索通常更快。一个缺点是，与 ngram 全文解析器相比，MeCab 全文解析器可能需要更长的时间来标记文档。
在第 12.10 节“全文搜索函数”
中描述的全文搜索语法
适用于 MeCab 解析器插件。本节描述了解析行为的差异。全文相关的配置选项也适用。
有关 MeCab 解析器的更多信息，请参阅 Github 上的
MeCab：Yet Another Part-of-Speech and Morphological Analyzer项目。
安装 MeCab 解析器插件
MeCab 解析器插件需要mecab和
mecab-ipadic.
在支持的Fedora、Debian和Ubuntu平台上（Ubuntu 12.04系统版本过旧除外），如果MySQL安装到默认位置，则mecab动态链接到系统
安装。mecab在其他支持的类 Unix 平台上，
libmecab.so静态链接在
libpluginmecab.soMySQL 插件目录中。mecab-ipadic包含在 MySQL 二进制文件中，位于
MYSQL_HOME\lib\mecab.
您可以安装mecab和
使用本机包管理实用程序（在 Fedora、Debian 和 Ubuntu 上），也
mecab-ipadic可以从源代码构建。有关安装和
使用本机包管理实用程序的信息，请参阅
从二进制分发版安装 MeCab（可选）。如果您想
从源代码构建 MeCab ，
请参阅从源代码
构建 MeCab（可选）。
mecabmecab-ipadicmecabmecab-ipadicmecabmecab-ipadic
在 Windows 上，libmecab.dll位于 MySQLbin目录中。
mecab-ipadic位于
MYSQL_HOME/lib/mecab。
要安装和配置 MeCab 解析器插件，请执行以下步骤：
在MySQL配置文件中，将
mecab_rc_file配置选项设置为配置文件所在位置mecabrc
，即MeCab的配置文件。如果您使用的是随 MySQL 一起分发的 MeCab 包，则该mecabrc文件位于
MYSQL_HOME/lib/mecab/etc/.
[mysqld]
loose-mecab-rc-file=MYSQL_HOME/lib/mecab/etc/mecabrcloose前缀是一个
选项修饰符
。在安装 MeCaB 解析器插件之前，MySQL 无法识别该
mecab_rc_file选项，但必须在尝试安装 MeCaB 解析器插件之前设置它。该loose前缀允许您重新启动 MySQL 而不会因无法识别的变量而遇到错误。
如果您使用自己的 MeCab 安装，或从源代码构建 MeCab，mecabrc
配置文件的位置可能会有所不同。
有关 MySQL 配置文件及其位置的信息，请参阅第 4.2.2.2 节，“使用选项文件”。
同样在 MySQL 配置文件中，将最小标记大小设置为 1 或 2，这是建议用于 MeCab 解析器的值。对于InnoDB表，最小标记大小由
innodb_ft_min_token_size
配置选项定义，默认值为 3。对于
MyISAM表，最小标记大小由 定义ft_min_word_len，默认值为 4。
[mysqld]
innodb_ft_min_token_size=1
修改mecabrc配置文件以指定您要使用的字典。mecab-ipadic与 MySQL 二进制文件一起分发的
包包括三个字典（ ipadic_euc-jp、
ipadic_sjis和
ipadic_utf-8）。MySQL打包的
mecabrc配置文件包含类似下面的条目：
dicdir =  /path/to/mysql/lib/mecab/lib/mecab/dic/ipadic_euc-jp
例如，要使用ipadic_utf-8字典，修改条目如下：
dicdir=MYSQL_HOME/lib/mecab/dic/ipadic_utf-8
如果您使用自己的 MeCab 安装或从源代码构建 MeCab，dicdir
则文件中的默认条目mecabrc可能不同，字典及其位置也可能不同。
笔记
安装 MeCab 解析器插件后，您可以使用mecab_charset状态变量查看 MeCab 使用的字符集。MySQL 二进制文件提供的三个 MeCab 词典支持以下字符集。
ipadic_euc-jp字典支持ujis和
eucjpms字符集
。ipadic_sjis字典支持sjis和
cp932字符集
。ipadic_utf-8字典支持utf8mb3和
utf8mb4字符集
。
mecab_charset只报告第一个支持的字符集。例如，ipadic_utf-8字典同时支持utf8mb3和
utf8mb4。
mecab_charset总是utf8在这本词典被使用时报告。
重新启动 MySQL。
安装 MeCab 解析器插件：
MeCab 解析器插件是使用
INSTALL PLUGIN语法安装的。插件名称是mecab，共享库名称是libpluginmecab.so。有关安装插件的其他信息，请参阅
第 5.6.1 节，“安装和卸载插件”。
INSTALL PLUGIN mecab SONAME 'libpluginmecab.so';
安装后，MeCab 解析器插件会在每次正常的 MySQL 重新启动时加载。
SHOW PLUGINS使用语句
验证是否加载了 MeCab 解析器插件
。mysql> SHOW PLUGINS;mecab插件应该出现在插件列表中
。
创建使用 MeCab 解析器的全文索引
要创建使用 mecab 解析器的索引，
FULLTEXT请指定WITH PARSER ngram、
或
。
CREATE TABLEALTER TABLECREATE INDEX
此示例演示如何创建带
mecab FULLTEXT索引的表、插入示例数据以及查看
INFORMATION_SCHEMA.INNODB_FT_INDEX_CACHE
表中的标记化数据：
mysql> USE test;
mysql> CREATE TABLE articles (
id INT UNSIGNED AUTO_INCREMENT NOT NULL PRIMARY KEY,
title VARCHAR(200),
body TEXT,
FULLTEXT (title,body) WITH PARSER mecab
) ENGINE=InnoDB CHARACTER SET utf8mb4;
mysql> SET NAMES utf8mb4;
mysql> INSERT INTO articles (title,body) VALUES
('データベース管理','このチュートリアルでは、私はどのようにデータベースを管理する方法を紹介します'),
('データベースアプリケーション開発','データベースアプリケーションを開発することを学ぶ');
mysql> SET GLOBAL innodb_ft_aux_table="test/articles";
mysql> SELECT * FROM INFORMATION_SCHEMA.INNODB_FT_INDEX_CACHE ORDER BY doc_id, position;FULLTEXT要向现有表
添加索引，您可以使用ALTER TABLE或
CREATE INDEX。例如：
CREATE TABLE articles (
id INT UNSIGNED AUTO_INCREMENT NOT NULL PRIMARY KEY,
title VARCHAR(200),
body TEXT
) ENGINE=InnoDB CHARACTER SET utf8mb4;
ALTER TABLE articles ADD FULLTEXT INDEX ft_index (title,body) WITH PARSER mecab;
# Or:
CREATE FULLTEXT INDEX ft_index ON articles (title,body) WITH PARSER mecab;
MeCab 解析器空间处理
MeCab 解析器使用空格作为查询字符串中的分隔符。例如，MeCab 解析器将 de
ータベース 管理标记为
deータベース和
管理。
MeCab 解析器停用词处理
默认情况下，MeCab 解析器使用默认停用词列表，其中包含一个简短的英语停用词列表。对于适用于日语的停用词列表，您必须创建自己的。有关创建停用词列表的信息，请参阅
第 12.10.4 节，“全文停用词”。
MeCab 解析器术语搜索
对于自然语言模式搜索，搜索词被转换为标记的并集。例如，
テータベース管理转换为テータベース管理。
SELECT COUNT(*) FROM articles WHERE MATCH(title,body) AGAINST('データベース管理' IN NATURAL LANGUAGE MODE);
对于布尔模式搜索，搜索词被转换为搜索短语。例如，
テータベース管理转换为テータベース管理。
SELECT COUNT(*) FROM articles WHERE MATCH(title,body) AGAINST('データベース管理' IN BOOLEAN MODE);
MeCab 解析器通配符搜索
通配符搜索词未标记化。搜索“
テータベース管理* ”是在前缀“
テータベース管理”上执行的。
SELECT COUNT(*) FROM articles WHERE MATCH(title,body) AGAINST('データベース*' IN BOOLEAN MODE);
MeCab 解析器短语搜索
短语被标记化。例如，
テータベース管理被代币化为テータベース管理。
SELECT COUNT(*) FROM articles WHERE MATCH(title,body) AGAINST('"データベース管理"' IN BOOLEAN MODE);
从二进制发行版安装 MeCab（可选）
本节介绍如何使用本机包管理实用程序安装mecab
和mecab-ipadic从二进制分发版安装。例如，在 Fedora 上，您可以使用 Yum 执行安装：
yum mecab-devel
在 Debian 或 Ubuntu 上，您可以执行 APT 安装：
apt-get install mecab
apt-get install mecab-ipadic
从源安装 MeCab（可选）
如果您想从源代码构建mecab，
mecab-ipadic下面提供了基本安装步骤。有关其他信息，请参阅 MeCab 文档。
从
http://taku910.github.io/mecab/#downloadmecab下载
tar.gz
包。截至 2016 年 2 月，最新的可用软件包是
和
.
mecab-ipadicmecab-0.996.tar.gzmecab-ipadic-2.7.0-20070801.tar.gz
安装mecab：
tar zxfv mecab-0.996.tar
cd mecab-0.996
./configure
make
make check
su
make install
安装mecab-ipadic：
tar zxfv mecab-ipadic-2.7.0-20070801.tar
cd mecab-ipadic-2.7.0-20070801
./configure
make
su
make installWITH_MECAB使用CMake 选项
编译 MySQL
。将WITH_MECAB选项设置为
system是否已安装
mecab并
mecab-ipadic设置为默认位置。
-DWITH_MECAB=system
如果您定义了自定义安装目录，请设置
WITH_MECAB为自定义目录。例如：
-DWITH_MECAB=/path/to/mecab
© Mysql 中文网
