# DROP COLLATION

DROP COLLATION
版本：
纠错本页面
搜索
目录导航
❮
❯
DROP COLLATIONDROP COLLATION — 移除一个排序规则大纲
DROP COLLATION [ IF EXISTS ] name [ CASCADE | RESTRICT ]
描述
DROP COLLATION 移除一个之前
定义好的排序规则。要删除一个排序规则，你必须拥有它。
参数IF EXISTS
如果该排序规则不存在，则不要抛出错误，而是发出一个提示。
name
排序规则的名称。排序规则名称可以是模式限定的。
CASCADE
自动删除依赖于该排序规则的对象，然后删除所有
依赖于那些对象的对象（见第 5.15 节）。
RESTRICT
如果有任何对象依赖于该排序规则，则拒绝删除它。这是默认值。
示例
要删除名为german的排序规则：
DROP COLLATION german;
兼容性
DROP COLLATION命令符合
SQL标准，除了IF
EXISTS选项，该选项是一个
PostgreSQL扩展。
其他参考ALTER COLLATION, CREATE COLLATION上一页 上一级 下一页DROP CAST 起始页 DROP CONVERSION
