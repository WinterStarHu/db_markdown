# CREATE TEXT SEARCH CONFIGURATION

CREATE TEXT SEARCH CONFIGURATION
版本：
纠错本页面
搜索
目录导航
❮
❯
CREATE TEXT SEARCH CONFIGURATIONCREATE TEXT SEARCH CONFIGURATION — 定义一个新的文本搜索配置大纲
CREATE TEXT SEARCH CONFIGURATION name (
PARSER = parser_name |
COPY = source_config
)
描述
CREATE TEXT SEARCH CONFIGURATION
创建一个新的文本搜索配置。一个文本搜索配置指定一个文本搜索解析器（
它能把字符串解析成记号），外加一些词典（可用于决定哪些记号是搜索
感兴趣的）。
如果只指定了解析器，那么新文本搜索配置最初没有从记号类型到词典的映射，
并因此将忽略所有词。后续的ALTER TEXT SEARCH
CONFIGURATION命令必须用于创建映射以使该配置变得可用。
另一种方式是复制一个现有的文本搜索配置。
如果给定一个模式名称，则文本搜索配置会被创建在指定的模式中。否则它将
被创建在当前模式中。
定义一个文本搜索配置的用户会成为其拥有者。
进一步的信息请参考第 12 章。
参数name
要创建的文本搜索配置的名称。该名称可以被模式限定。
parser_name
该配置要使用的文本搜索解析器的名称。
source_config
要复制的已有文本搜索配置的名称。
备注
PARSER和COPY选项是互斥的，因为当
复制一个已有的配置时，它的解析器选择也会被复制。
兼容性
在 SQL 标准中没有
CREATE TEXT SEARCH CONFIGURATION 语句。
另请参阅ALTER TEXT SEARCH CONFIGURATION, DROP TEXT SEARCH CONFIGURATION上一页 上一级 下一页CREATE TABLESPACE 起始页 CREATE TEXT SEARCH DICTIONARY
