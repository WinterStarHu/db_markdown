# DROP LANGUAGE

DROP LANGUAGE
版本：
纠错本页面
搜索
目录导航
❮
❯
DROP LANGUAGEDROP LANGUAGE — 删除一种过程语言大纲
DROP [ PROCEDURAL ] LANGUAGE [ IF EXISTS ] name [ CASCADE | RESTRICT ]
说明
DROP LANGUAGE 移除一种之前注册的过程语言
的定义。你必须是超级用户或该语言的拥有者才能使用
DROP LANGUAGE。
注意
自PostgreSQL 9.1 起，大部分过程语言
已经被做成了“扩展”，因此应该用
DROP EXTENSION
而不是DROP LANGUAGE删除。
参数IF EXISTS
如果该语言不存在则不要抛出错误，而是发出一个提示。
name
一个已有过程语言的名称。为了向前兼容，这个名称可以用单引号包围。
CASCADE
自动删除依赖于该语言的对象（例如该语言中的函数），然后删除所有
依赖于那些对象的对象（见第 5.15 节）。
RESTRICT
如果有任何对象依赖于该语言，则拒绝删除它。这是默认值。
示例
这个命令移除过程语言plsample：
DROP LANGUAGE plsample;
兼容性
在SQL标准中没有DROP LANGUAGE语句。
另见ALTER LANGUAGE, CREATE LANGUAGE上一页 上一级 下一页DROP INDEX 起始页 DROP MATERIALIZED VIEW
