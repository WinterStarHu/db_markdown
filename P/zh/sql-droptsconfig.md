# DROP TEXT SEARCH CONFIGURATION

DROP TEXT SEARCH CONFIGURATION
版本：
纠错本页面
搜索
目录导航
❮
❯
DROP TEXT SEARCH CONFIGURATIONDROP TEXT SEARCH CONFIGURATION — 移除一个文本搜索配置大纲
DROP TEXT SEARCH CONFIGURATION [ IF EXISTS ] name [ CASCADE | RESTRICT ]
描述
DROP TEXT SEARCH CONFIGURATION 删除一个现有的文本
搜索配置。要执行这个命令，你必须是该配置的拥有者。
参数IF EXISTS
如果该文本搜索配置不存在则不要抛出错误，而是发出一个提示。
name
一个现有文本搜索配置的名称（可以是模式限定的）。
CASCADE
自动删除依赖于该文本搜索配置的对象，然后删除所有
依赖于那些对象的对象（见第 5.15 节）。
RESTRICT
如果有任何对象依赖于该文本搜索配置，则拒绝删除它。这是默认值。
示例
移除文本搜索配置my_english：
DROP TEXT SEARCH CONFIGURATION my_english;
如果有任何在to_tsvector调用中引用该配置的
索引存在，这个命令都不会成功。增加CASCADE
可以把这类索引与该文本搜索配置一起删除。
兼容性
SQL 标准中没有DROP TEXT SEARCH CONFIGURATION
语句。
其他ALTER TEXT SEARCH CONFIGURATION, CREATE TEXT SEARCH CONFIGURATION上一页 上一级 下一页DROP TABLESPACE 起始页 DROP TEXT SEARCH DICTIONARY
