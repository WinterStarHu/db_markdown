# DROP CONVERSION

DROP CONVERSION
版本：
纠错本页面
搜索
目录导航
❮
❯
DROP CONVERSIONDROP CONVERSION — 移除转换大纲
DROP CONVERSION [ IF EXISTS ] name [ CASCADE | RESTRICT ]
描述
DROP CONVERSION 移除一个之前定义好的
转换。要删除一个转换，你必须拥有该转换。
参数IF EXISTS
如果该转换不存在则不要抛出错误，而是发出提示。
name
转换的名称。转换名称可以是模式限定的。
CASCADERESTRICT
这些关键词没有任何效果，因为在转换上没有依赖关系。
示例
要删除名为myname的转换：
DROP CONVERSION myname;
兼容性
在 SQL 标准中没有DROP CONVERSION语句，
但是有一个DROP TRANSLATION语句。还有
对应的CREATE TRANSLATION语句，它与
PostgreSQL 中的CREATE CONVERSION
语句相似。
另见ALTER CONVERSION, CREATE CONVERSION上一页 上一级 下一页DROP COLLATION 起始页 DROP DATABASE
