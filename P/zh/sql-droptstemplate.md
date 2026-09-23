# DROP TEXT SEARCH TEMPLATE

DROP TEXT SEARCH TEMPLATE
版本：
纠错本页面
搜索
目录导航
❮
❯
DROP TEXT SEARCH TEMPLATEDROP TEXT SEARCH TEMPLATE — 移除文本搜索模板大纲
DROP TEXT SEARCH TEMPLATE [ IF EXISTS ] name [ CASCADE | RESTRICT ]
描述
DROP TEXT SEARCH TEMPLATE 删除一个
现有的文本搜索模板。你必须是超级用户才能使用这个命令。
参数IF EXISTS
如果文本搜索模板不存在，则不要抛出错误，而是发出提示。
name
现有文本搜索模板的名称（可以是模式限定的）。
CASCADE
自动删除依赖于该文本搜索模板的对象，然后删除所有
依赖于那些对象的对象（见第 5.15 节）。
RESTRICT
如果有任何对象依赖于该文本搜索模板，则拒绝删除它。这是默认值。
示例
移除文本搜索模板thesaurus：
DROP TEXT SEARCH TEMPLATE thesaurus;
如果有任何使用该模板的文本搜索字典存在，这个命令都不会成功。增加
CASCADE可以将这类字典与模板一起删除。
兼容性
SQL 标准中没有DROP TEXT SEARCH TEMPLATE
语句。
另见ALTER TEXT SEARCH TEMPLATE, CREATE TEXT SEARCH TEMPLATE上一页 上一级 下一页DROP TEXT SEARCH PARSER 起始页 DROP TRANSFORM
