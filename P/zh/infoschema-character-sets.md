# 35.7. character_sets

35.7. character_sets
版本：
纠错本页面
搜索
目录导航
❮
❯
35.7. character_sets #
视图character_sets标识当前数据库中可用的字符集。因为 PostgreSQL 不支持在同一个数据库中有多个字符集，这个视图只显示一个字符集，它就是数据库编码。
请注意SQL标准中以下术语的用法：
character repertoire
一个抽象的字符集合，例如UNICODE，UCS或
LATIN1。不作为SQL对象公开，但在此视图中可见。
character encoding form
一种字符集的编码形式。大多数旧的字符集只使用一种编码形式，因此它们没有单独的名称
（例如，LATIN2是适用于LATIN2字符集的编码形式）。
但是例如Unicode有编码形式UTF8，UTF16等
（并非所有都受PostgreSQL支持）。编码形式不作为SQL对象公开，但在此视图中可见。
character set
一个命名的SQL对象，用于标识字符集、字符编码和默认排序规则。预定义的字符集通常与编码形式
同名，但用户可以定义其他名称。例如，字符集UTF8通常会标识字符集
UCS，编码形式UTF8和一些默认排序规则。
在PostgreSQL中，您可以将“编码”视为字符集或字符编码形式。它们将具有相同的名称，
并且一个数据库中只能有一个。
表 35.5. character_sets 列
列类型
描述
character_set_catalog sql_identifier
字符集当前并未被实现为模式对象，因此这一列为空。
character_set_schema sql_identifier
字符集当前并未被实现为模式对象，因此这一列为空。
character_set_name sql_identifier
字符集的名称，当前实现为显示该数据库编码的名称
character_repertoire sql_identifier
字符集，如果编码为UTF8则显示UCS，否则只显示编码名称
form_of_use sql_identifier
字符编码形式，与数据库编码相同
default_collate_catalog sql_identifier
包含默认排序规则的数据库名称（如果有排序规则被标识，总是当前数据库）
default_collate_schema sql_identifier
包含默认排序规则的模式名
default_collate_name sql_identifier
默认排序规则的名字。该默认排序规则被标识为匹配当前数据库的COLLATE和CTYPE设置的排序规则。如果没有那种排序规则，那么这一列和相关模式以及目录列为空。
上一页 上一级 下一页35.6. attributes 起始页 35.8. check_constraint_routine_usage
