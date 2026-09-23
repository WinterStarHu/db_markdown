# DROP OPERATOR FAMILY

DROP OPERATOR FAMILY
版本：
纠错本页面
搜索
目录导航
❮
❯
DROP OPERATOR FAMILYDROP OPERATOR FAMILY — 移除一个操作符族大纲
DROP OPERATOR FAMILY [ IF EXISTS ] name USING index_method [ CASCADE | RESTRICT ]
描述
DROP OPERATOR FAMILY 删除一个
现有的操作符族。要执行这个命令，你必须是该操作符族的拥有者。
DROP OPERATOR FAMILY 包括删除
该族所包含的任何操作符类，但是它不会删除该族所引用的任何操作
符或函数。如果有任何依赖于该族中操作符类的索引存在，你将需要
指定 CASCADE 来完成删除。
参数IF EXISTS
如果该操作符族不存在则不要抛出错误，而是发出一个提示。
name
一个现有操作符族的名称（可选的模式限定）。
index_method
该操作符族适用的索引访问方法的名称。
CASCADE
自动删除依赖于该操作符族的对象，然后删除所有
依赖于那些对象的对象（见第 5.15 节）。
RESTRICT
如果有任何对象依赖于该操作符族，则拒绝删除它。这是默认值。
示例
移除 B-树操作符族float_ops：
DROP OPERATOR FAMILY float_ops USING btree;
如果有任何使用该族中操作符类的索引存在，这个命令都不会成功。增加
CASCADE可以把这类索引与该操作符族一起删除。
兼容性
SQL 标准中没有DROP OPERATOR FAMILY
语句。
另请参阅ALTER OPERATOR FAMILY, CREATE OPERATOR FAMILY, ALTER OPERATOR CLASS, CREATE OPERATOR CLASS, DROP OPERATOR CLASS上一页 上一级 下一页DROP OPERATOR CLASS 起始页 DROP OWNED
