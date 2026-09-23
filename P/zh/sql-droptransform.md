# DROP TRANSFORM

DROP TRANSFORM
版本：
纠错本页面
搜索
目录导航
❮
❯
DROP TRANSFORMDROP TRANSFORM — 移除转换大纲
DROP TRANSFORM [ IF EXISTS ] FOR type_name LANGUAGE lang_name [ CASCADE | RESTRICT ]
描述
DROP TRANSFORM 移除一个之前定义的转换。
为了删除一种转换，你必须拥有该类型和语言。这些同样也是创建转换所需要的
特权。
参数IF EXISTS
如果该转换不存在也不要抛出一个错误。这种情况下会发出一个通知。
type_name
转换的数据类型名称。
lang_name
转换的语言名称。
CASCADE
自动删除依赖于该转换的对象，然后删除所有
依赖于那些对象的对象（见第 5.15 节）。
RESTRICT
如果有任何对象依赖于该转换，则拒绝删除它。这是默认行为。
示例
要删除类型hstore和语言plpython3u的转换：
DROP TRANSFORM FOR hstore LANGUAGE plpython3u;
兼容性
这种形式的DROP TRANSFORM是一种
PostgreSQL扩展。详见
CREATE TRANSFORM。
另请参阅CREATE TRANSFORM上一页 上一级 下一页DROP TEXT SEARCH TEMPLATE 起始页 DROP TRIGGER
