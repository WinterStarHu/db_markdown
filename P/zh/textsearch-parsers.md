# 12.5. 解析器

12.5. 解析器
版本：
纠错本页面
搜索
目录导航
❮
❯
12.5. 解析器 #
文本搜索解析器负责把未处理的文档文本划分成 记号 并且标识每一个记号的类型，而可能的类型集合由解析器本身定义。注意一个解析器完全不会修改文本 — 它简单地标识看似合理的词边界。因为这种有限的视野，对于应用相关的自定义解析器的需求就没有自定义字典那么强烈。目前 PostgreSQL 只提供了一种内建解析器，它已经被证实对很多种应用都适用。
内建解析器被称为 pg_catalog.default。它识别 23 种记号类型，如 表 12.1 所示。
表 12.1. 默认解析器的记号类型别名描述示例asciiword单词，所有 ASCII 字母elephantword单词，所有字母mañananumword单词，字母和数字beta1asciihword带连字符的单词，所有 ASCIIup-to-datehword带连字符的单词，所有字母lógico-matemáticanumhword带连字符的单词，字母和数字postgresql-beta1hword_asciipart带连字符的单词部分，所有 ASCIIpostgresql in the context postgresql-beta1hword_part带连字符的单词部分，所有字母lógico or matemática
在上下文 lógico-matemáticahword_numpart带连字符的单词部分，字母和数字beta1 在上下文
postgresql-beta1emailEmail 地址foo@example.comprotocol协议头部http://urlURLexample.com/stuff/index.htmlhost主机example.comurl_pathURL 路径/stuff/index.html, 在 URL 的上下文中file文件或路径名/usr/local/foo.txt, 如果不在 URL 内sfloat科学记数法-1.234e56float十进制记数法-1.234int有符号整数-1234uint无符号整数1234version版本号8.3.0tagXML 标签<a href="dictionaries.html">entityXML 实体&amp;blank空格符号（其他不识别的任意空白或标点符号）注意
解析器的一个“字母”的概念由数据库的区域设置决定，具体是lc_ctype。只包含基本 ASCII 字母的词被报告为一个单独的记号类型，因为有时有用来区别它们。在大部分欧洲语言中，记号类型word和asciiword应该被同样对待。
email不支持所有由RFC 5322定义的有效电子邮件字符。
具体来说，电子邮件用户名仅支持句号、短横线和下划线这些非字母数字字符。
tag 不支持所有由
W3C Recommendation, XML 定义的有效标签名。
具体来说，唯一支持的标签名是以 ASCII 字母、下划线或冒号开头，并且只包含字母、
数字、连字符、下划线、句点和冒号的标签名。tag 还包括以
<!-- 开头并以 --> 结尾的 XML 注释，
以及 XML 声明（但请注意，这包括任何以 <?x 开头并以
> 结尾的内容）。
解析器有可能从同一段文本中生成重叠的标记。例如，一个连字符单词将被报告为整个单词和每个组成部分：
SELECT alias, description, token FROM ts_debug('foo-bar-beta1');
alias      |               description                |     token
-----------------+------------------------------------------+---------------
numhword        | Hyphenated word, letters and digits      | foo-bar-beta1
hword_asciipart | Hyphenated word part, all ASCII          | foo
blank           | Space symbols                            | -
hword_asciipart | Hyphenated word part, all ASCII          | bar
blank           | Space symbols                            | -
hword_numpart   | Hyphenated word part, letters and digits | beta1
这种行为是可取的，因为它允许搜索同时适用于整个复合词和组件。这里是另一个有启发性的例子：
SELECT alias, description, token FROM ts_debug('http://example.com/stuff/index.html');
alias   |  description  |            token
----------+---------------+------------------------------
protocol | Protocol head | http://
url      | URL           | example.com/stuff/index.html
host     | Host          | example.com
url_path | URL path      | /stuff/index.html
上一页 上一级 下一页12.4. 附加功能 起始页 12.6. 词典
