# DROP CAST

DROP CAST
版本：
纠错本页面
搜索
目录导航
❮
❯
DROP CASTDROP CAST — 移除一个转换大纲
DROP CAST [ IF EXISTS ] (source_type AS target_type) [ CASCADE | RESTRICT ]
描述
DROP CAST移除一个之前定义好的转换。
要能删除一个转换，你必须拥有源数据类型或目标数据类型。这也是
创建一个转换所要求的特权。
参数IF EXISTS
如果该转换不存在则不要抛出一个错误，而是发出一个提示。
source_type
该转换的源数据类型的名称。
target_type
该转换的目标数据类型的名称。
CASCADERESTRICT
这些关键词没有任何效果，因为在转换上没有依赖性。
示例
要移除从类型text到类型int的转换：
DROP CAST (text AS int);
兼容性
DROP CAST命令符合 SQL 标准。
另见CREATE CAST上一页 上一级 下一页DROP AGGREGATE 起始页 DROP COLLATION
