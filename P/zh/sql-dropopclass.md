# DROP OPERATOR CLASS

DROP OPERATOR CLASS
版本：
纠错本页面
搜索
目录导航
❮
❯
DROP OPERATOR CLASSDROP OPERATOR CLASS — 删除一个操作符类大纲
DROP OPERATOR CLASS [ IF EXISTS ] name USING index_method [ CASCADE | RESTRICT ]
描述
DROP OPERATOR CLASS 删除一个现有的
操作符类。要执行这个命令，你必须是该操作符类的拥有者。
DROP OPERATOR CLASS 不会删除任何被
该类引用的操作符或者函数。如果有索引依赖于该操作符类，你将需要指
定 CASCADE 来完成删除。
参数IF EXISTS
如果该操作符类不存在则不要抛出一个错误，而是发出一个提示。
name
一个现有的操作符类的名称（可选地是模式限定的）。
index_method
该操作符类适用的索引访问方法的名称。
CASCADE
自动删除依赖于该操作符类的对象（例如索引），然后删除所有
依赖于这些对象的对象（见第 5.15 节）。
RESTRICT
如果有任何对象依赖于该操作符类，则拒绝删除它。这是默认值。
注释
DROP OPERATOR CLASS将不会删除包含该类的
操作符族，即使该族中已经没有任何成员（特别是由
CREATE OPERATOR CLASS隐式创建的族）。一个
空操作符族是无害的，但是为了整洁你可能希望用
DROP OPERATOR FAMILY移除该操作符族，或者
一开始就使用DROP OPERATOR FAMILY会更好。
示例
移除 B-树操作符类widget_ops：
DROP OPERATOR CLASS widget_ops USING btree;
如果有任何使用该操作符类的索引存在，这个命令都不会成功。增加
CASCADE可以把这类索引与该操作符类一起删除。
兼容性
SQL 标准中没有DROP OPERATOR CLASS语句。
另见ALTER OPERATOR CLASS, CREATE OPERATOR CLASS, DROP OPERATOR FAMILY上一页 上一级 下一页DROP OPERATOR 起始页 DROP OPERATOR FAMILY
