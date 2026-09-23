# 11.11. 索引和排序规则

11.11. 索引和排序规则
版本：
纠错本页面
搜索
目录导航
❮
❯
11.11. 索引和排序规则 #
一个索引在每一个索引列上只能支持一种排序规则。如果需要多种排序规则，可能需要多个索引。
考虑这些语句：
CREATE TABLE test1c (
id integer,
content varchar COLLATE "x"
);
CREATE INDEX test1c_content_index ON test1c (content);
该索引自动使用下层列的排序规则。因此一个如下形式的查询：
SELECT * FROM test1c WHERE content > constant;
可以使用该索引，因为比较会默认使用列的排序规则。但是，这个索引无法加速涉及到某些其他排序规则的查询。因此对于下面形式的查询：
SELECT * FROM test1c WHERE content > constant COLLATE "y";
可以创建一个额外的支持"y"排序规则的索引，例如：
CREATE INDEX test1c_content_y_index ON test1c (content COLLATE "y");
上一页 上一级 下一页11.10. 操作符类和操作符族 起始页 11.12. 检查索引使用
