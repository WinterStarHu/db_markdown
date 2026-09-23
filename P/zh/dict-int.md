# F.12. dict_int — 示例全文搜索字典用于整数

F.12. dict_int — 示例全文搜索字典用于整数
版本：
纠错本页面
搜索
目录导航
❮
❯
F.12. dict_int —
示例全文搜索字典用于整数 #F.12.1. 配置F.12.2. 用法
dict_int是一个附加全文搜索字典模板的例子。这个例子字典的动机是控制整数（有符号和无符号）的索引，允许在阻止唯一词数量的过度增长（会严重影响搜索性能）时也能索引这些数字。
这个模块被视为“trusted”，也就是说，它可以由在当前数据库上具有CREATE特权的非超级用户安装。
F.12.1. 配置 #
该字典接受三个选项：
maxlen参数指定在一个整数词中允许的最大位数。默认值为6。
rejectlong参数指定一个超长整数是否应该被截断或忽略。如果rejectlong为false（默认），该字典返回该整数的前maxlen位数字。如果rejectlong为true，该字典将一个超长整数视为停用词，因此它将不会被索引。注意这也意味着这样一个整数不能被搜索。
absval 参数规定“+” 或 “-”符号是否将被从整数前删除。
默认值为 false。当为 true时，在maxlen被应用之前，符号被删除。
F.12.2. 用法 #
安装dict_int扩展会使用默认参数创建一个文本搜索模板intdict_template和一个基于它的词典intdict。你可以修改参数，例如
mydb# ALTER TEXT SEARCH DICTIONARY intdict (MAXLEN = 4, REJECTLONG = true);
ALTER TEXT SEARCH DICTIONARY
或创建基于该模板的新词典。
要测试该词典，可以尝试
mydb# select ts_lexize('intdict', '12345678');
ts_lexize
-----------
{123456}
但是现实世界的用法将涉及将它包括在一个第 12 章中描述的文本搜索配置中。那可能看起来像这样：
ALTER TEXT SEARCH CONFIGURATION english
ALTER MAPPING FOR int, uint WITH intdict;
上一页 上一级 下一页dblink_build_sql_update 起始页 F.13. dict_xsyn — 示例同义词全文搜索字典
