# 12.10. psql支持

12.10. psql支持
版本：
纠错本页面
搜索
目录导航
❮
❯
12.10. psql支持 #
关于文本搜索配置对象的信息可以在psql中使用一组命令获得：
\dF{d,p,t}[+] [PATTERN]
可选的+能产生更多细节。
可选参数PATTERN可以是一个文本搜索对象的名称，可以是模式限定的。如果PATTERN被忽略，则所有可见对象的信息都将被显示。PATTERN可以是一个正则表达式并且可以为模式和对象名称提供独立的模式。下面的例子展示了这些特性：
=> \dF *fulltext*
List of text search configurations
Schema |  Name        | Description
--------+--------------+-------------
public | fulltext_cfg |
=> \dF *.fulltext*
List of text search configurations
Schema   |  Name        | Description
----------+----------------------------
fulltext | fulltext_cfg |
public   | fulltext_cfg |
可用的命令是：
\dF[+] [PATTERN]
列出文本搜索配置（添加+以获取更多详细信息）。
=> \dF russian
List of text search configurations
Schema   |  Name   |            Description
------------+---------+------------------------------------
pg_catalog | russian | configuration for russian language
=> \dF+ russian
Text search configuration "pg_catalog.russian"
Parser: "pg_catalog.default"
Token      | Dictionaries
-----------------+--------------
asciihword      | english_stem
asciiword       | english_stem
email           | simple
file            | simple
float           | simple
host            | simple
hword           | russian_stem
hword_asciipart | english_stem
hword_numpart   | simple
hword_part      | russian_stem
int             | simple
numhword        | simple
numword         | simple
sfloat          | simple
uint            | simple
url             | simple
url_path        | simple
version         | simple
word            | russian_stem
\dFd[+] [PATTERN]
列出文本搜索字典（添加 + 以获取更多详细信息）。
=> \dFd
文本搜索字典列表
模式   |      名称       |                        描述
------------+-----------------+-----------------------------------------------------------
pg_catalog | arabic_stem     | 阿拉伯语的 snowball 词干提取器
pg_catalog | armenian_stem   | 亚美尼亚语的 snowball 词干提取器
pg_catalog | basque_stem     | 巴斯克语的 snowball 词干提取器
pg_catalog | catalan_stem    | 加泰罗尼亚语的 snowball 词干提取器
pg_catalog | danish_stem     | 丹麦语的 snowball 词干提取器
pg_catalog | dutch_stem      | 荷兰语的 snowball 词干提取器
pg_catalog | english_stem    | 英语的 snowball 词干提取器
pg_catalog | estonian_stem   | 爱沙尼亚语的 snowball 词干提取器
pg_catalog | finnish_stem    | 芬兰语的 snowball 词干提取器
pg_catalog | french_stem     | 法语的 snowball 词干提取器
pg_catalog | german_stem     | 德语的 snowball 词干提取器
pg_catalog | greek_stem      | 希腊语的 snowball 词干提取器
pg_catalog | hindi_stem      | 印地语的 snowball 词干提取器
pg_catalog | hungarian_stem  | 匈牙利语的 snowball 词干提取器
pg_catalog | indonesian_stem | 印度尼西亚语的 snowball 词干提取器
pg_catalog | irish_stem      | 爱尔兰语的 snowball 词干提取器
pg_catalog | italian_stem    | 意大利语的 snowball 词干提取器
pg_catalog | lithuanian_stem | 立陶宛语的 snowball 词干提取器
pg_catalog | nepali_stem     | 尼泊尔语的 snowball 词干提取器
pg_catalog | norwegian_stem  | 挪威语的 snowball 词干提取器
pg_catalog | portuguese_stem | 葡萄牙语的 snowball 词干提取器
pg_catalog | romanian_stem   | 罗马尼亚语的 snowball 词干提取器
pg_catalog | russian_stem    | 俄语的 snowball 词干提取器
pg_catalog | serbian_stem    | 塞尔维亚语的 snowball 词干提取器
pg_catalog | simple          | 简单字典：仅小写并检查停用词
pg_catalog | spanish_stem    | 西班牙语的 snowball 词干提取器
pg_catalog | swedish_stem    | 瑞典语的 snowball 词干提取器
pg_catalog | tamil_stem      | 泰米尔语的 snowball 词干提取器
pg_catalog | turkish_stem    | 土耳其语的 snowball 词干提取器
pg_catalog | yiddish_stem    | 意第绪语的 snowball 词干提取器
\dFp[+] [PATTERN]
列出文本搜索解析器（添加+以获取更多详细信息）。
=> \dFp
List of text search parsers
Schema   |  Name   |     Description
------------+---------+---------------------
pg_catalog | default | default word parser
=> \dFp+
Text search parser "pg_catalog.default"
Method      |    Function    | Description
-----------------+----------------+-------------
Start parse     | prsd_start     |
Get next token  | prsd_nexttoken |
End parse       | prsd_end       |
Get headline    | prsd_headline  |
Get token types | prsd_lextype   |
Token types for parser "pg_catalog.default"
Token name    |               Description
-----------------+------------------------------------------
asciihword      | Hyphenated word, all ASCII
asciiword       | Word, all ASCII
blank           | Space symbols
email           | Email address
entity          | XML entity
file            | File or path name
float           | Decimal notation
host            | Host
hword           | Hyphenated word, all letters
hword_asciipart | Hyphenated word part, all ASCII
hword_numpart   | Hyphenated word part, letters and digits
hword_part      | Hyphenated word part, all letters
int             | Signed integer
numhword        | Hyphenated word, letters and digits
numword         | Word, letters and digits
protocol        | Protocol head
sfloat          | Scientific notation
tag             | XML tag
uint            | Unsigned integer
url             | URL
url_path        | URL path
version         | Version number
word            | Word, all letters
(23 rows)
\dFt[+] [PATTERN]
列出文本搜索模板（添加+以获取更多详细信息）。
=> \dFt
List of text search templates
Schema   |   Name    |                        Description
------------+-----------+-----------------------------------------------------------
pg_catalog | ispell    | ispell dictionary
pg_catalog | simple    | simple dictionary: just lower case and check for stopword
pg_catalog | snowball  | snowball stemmer
pg_catalog | synonym   | synonym dictionary: replace word by its synonym
pg_catalog | thesaurus | thesaurus dictionary: phrase by phrase substitution
上一页 上一级 下一页12.9. 文本搜索的首选索引类型 起始页 12.11. 限制
