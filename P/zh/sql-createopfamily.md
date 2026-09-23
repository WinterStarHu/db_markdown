# CREATE OPERATOR FAMILY

CREATE OPERATOR FAMILY
版本：
纠错本页面
搜索
目录导航
❮
❯
CREATE OPERATOR FAMILYCREATE OPERATOR FAMILY — 定义一个新的操作符族大纲
CREATE OPERATOR FAMILY name USING index_method
描述
CREATE OPERATOR FAMILY 创建一个新的操作符族。
一个操作符族定义一个相关操作符类组成的集合，并且可能还包含一些
额外的、与这些操作符类兼容但对于任何个体索引的功能不是至关重要的
操作符和支持函数（对索引至关重要的操作符和函数应该被分组在相关的
操作符类中，而不是 “松散地” 在操作符族中。通常，单一数据
类型操作符被限制在操作符类中，而跨数据类型操作符可以松散地存在于
一个包含用于两种数据类型的操作符类的操作符族中）。
新的操作符族初始时为空。应该通过发出后续的 CREATE OPERATOR CLASS
命令来增加包含在其中的操作符类，还可以用可选的 ALTER OPERATOR FAMILY
命令来增加 “松散的” 操作符和它们对应的支持函数。
如果给出一个模式名称，该操作符族会被创建在指定的模式中。否则，它
会被创建在当前模式中。只有当同一个模式中的两个操作符族是用于不同
的索引方法时，它们才能拥有相同的名字。
定义一个操作符族的用户将成为它的拥有者。当前，创建用户必须是超级用户
（做出这样的限制是因为错误的操作符族定义可能会让服务器混淆甚至崩溃）。
进一步的信息可以参考第 36.16 节。
参数name
要创建的操作符族的名称。该名称可以被模式限定。
index_method
该操作符族要用于的索引方法的名称。
兼容性
CREATE OPERATOR FAMILY是一种
PostgreSQL扩展。在 SQL 标准中没有
CREATE OPERATOR FAMILY语句。
另见ALTER OPERATOR FAMILY, DROP OPERATOR FAMILY, CREATE OPERATOR CLASS, ALTER OPERATOR CLASS, DROP OPERATOR CLASS上一页 上一级 下一页CREATE OPERATOR CLASS 起始页 CREATE POLICY
