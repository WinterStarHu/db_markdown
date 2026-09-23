# DROP ACCESS METHOD

DROP ACCESS METHOD
版本：
纠错本页面
搜索
目录导航
❮
❯
DROP ACCESS METHODDROP ACCESS METHOD — 删除一种访问方法大纲
DROP ACCESS METHOD [ IF EXISTS ] name [ CASCADE | RESTRICT ]
描述
DROP ACCESS METHOD 移除一种现有的访问方法。只有超级用户能够删除访问方法。
参数IF EXISTS
如果该访问方法不存在，则不会抛出错误。这种情况下会发出通知。
name
现有访问方法的名称。
CASCADE
自动删除依赖于该访问方法的对象（例如操作符类、操作符族以及索引），并且接着删除所有依赖于那些对象的对象（见第 5.15 节）。
RESTRICT
如果有任何对象依赖于该访问方法，则拒绝删除它。这是默认。
示例
删除访问方法heptree：
DROP ACCESS METHOD heptree;
兼容性
DROP ACCESS METHOD 是一种PostgreSQL扩展。
另见CREATE ACCESS METHOD上一页 上一级 下一页DO 起始页 DROP AGGREGATE
