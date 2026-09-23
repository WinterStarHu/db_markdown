# 12.7. 配置示例

12.7. 配置示例
版本：
纠错本页面
搜索
目录导航
❮
❯
12.7. 配置示例 #
一个文本搜索配置指定了将一个文档转换成一个tsvector所需的所有选项：用于把文本分解成记号的解析器，以及用于将每一个记号转换成词位的词典。每一次to_tsvector或to_tsquery的调用都需要一个文本搜索配置来执行其处理。配置参数default_text_search_config指定了默认配置的名称，如果忽略了显式的配置参数，文本搜索函数将会使用它。它可以在postgresql.conf中设置，或者使用SET命令为一个单独的会话设置。
有一些预定义的文本搜索配置可用，并且你可以容易地创建自定义的配置。为了便于管理文本搜索对象，可以使用一组SQL命令，并且有多个psql命令可以显示有关文本搜索对象（第 12.10 节）的信息。
作为一个例子，我们将创建一个配置pg，从复制内建的english配置开始：
CREATE TEXT SEARCH CONFIGURATION public.pg ( COPY = pg_catalog.english );
我们将使用一个 PostgreSQL 特定的同义词列表，并将它存储在$SHAREDIR/tsearch_data/pg_dict.syn中。文件内容看起来像：
postgres    pg
pgsql       pg
postgresql  pg
我们定义同义词词典如下：
CREATE TEXT SEARCH DICTIONARY pg_dict (
TEMPLATE = synonym,
SYNONYMS = pg_dict
);
接下来我们注册Ispell词典english_ispell，它有其自己的配置文件：
CREATE TEXT SEARCH DICTIONARY english_ispell (
TEMPLATE = ispell,
DictFile = english,
AffFile = english,
StopWords = english
);
现在我们可以在配置pg中建立词的映射：
ALTER TEXT SEARCH CONFIGURATION pg
ALTER MAPPING FOR asciiword, asciihword, hword_asciipart,
word, hword, hword_part
WITH pg_dict, english_ispell, english_stem;
我们选择不索引或搜索某些内建配置确实处理的记号类型：
ALTER TEXT SEARCH CONFIGURATION pg
DROP MAPPING FOR email, url, url_path, sfloat, float;
现在我们可以测试我们的配置：
SELECT * FROM ts_debug('public.pg', '
PostgreSQL, the highly scalable, SQL compliant, open source object-relational
database management system, is now undergoing beta testing of the next
version of our software.
');
下一个步骤是设置会话让它使用新配置，它被创建在public模式中：
=> \dF
List of text search configurations
Schema  | Name | Description
---------+------+-------------
public  | pg   |
SET default_text_search_config = 'public.pg';
SET
SHOW default_text_search_config;
default_text_search_config
----------------------------
public.pg
上一页 上一级 下一页12.6. 词典 起始页 12.8. 测试和调试文本搜索
