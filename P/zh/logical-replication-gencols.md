# 29.6. 生成列复制

29.6. 生成列复制
版本：
纠错本页面
搜索
目录导航
❮
❯
29.6. 生成列复制 #
通常，订阅者上的表将与发布者表定义相同，因此如果发布者表具有一个
生成列，则订阅者表将具有匹配的生成列。在这种情况下，始终使用订阅者表的生成列值。
例如，请注意下面订阅者表的生成列值来自于订阅者列的计算。
/* pub # */ CREATE TABLE tab_gen_to_gen (a int, b int GENERATED ALWAYS AS (a + 1) STORED);
/* pub # */ INSERT INTO tab_gen_to_gen VALUES (1),(2),(3);
/* pub # */ CREATE PUBLICATION pub1 FOR TABLE tab_gen_to_gen;
/* pub # */ SELECT * FROM tab_gen_to_gen;
a | b
----+---
1 | 2
2 | 3
3 | 4
(3 rows)
/* sub # */ CREATE TABLE tab_gen_to_gen (a int, b int GENERATED ALWAYS AS (a * 100) STORED);
/* sub # */ CREATE SUBSCRIPTION sub1 CONNECTION 'dbname=test_pub' PUBLICATION pub1;
/* sub # */ SELECT * from tab_gen_to_gen;
a | b
----+----
1 | 100
2 | 200
3 | 300
(3 rows)
实际上，在版本 18.0 之前，逻辑复制根本不发布 GENERATED 列。
但是，将生成列复制到常规列有时是可取的。
提示
当通过输出插件将数据复制到非 PostgreSQL 数据库时，此功能可能会很有用，尤其是当目标数据库不支持生成列时。
生成列默认情况下不被发布，但用户可以选择像常规列一样发布存储的生成列。
有两种方法可以做到这一点：
设置 PUBLICATION 参数
publish_generated_columns 为 stored。
这指示 PostgreSQL 逻辑复制发布当前和
未来的发布表的存储生成列。
指定一个表 列列表
明确指定将要发布的存储生成列。
注意
在确定将要发布的表列时，列列表
优先于 publish_generated_columns 参数的效果。
下表总结了在逻辑复制中涉及生成列时的行为。
结果显示了在未启用生成列发布时和启用时的情况。
表 29.2. 复制结果摘要发布生成列？发布者表列订阅者表列结果否生成的生成的发布者表列未被复制。使用订阅者表生成列的值。否生成的常规发布者表列未被复制。使用订阅者表常规列的默认值。否生成的--缺失--发布者表列未被复制。没有任何操作发生。是生成的生成的错误。不支持。是生成的常规发布者表列的值被复制到订阅者表列。是生成的--缺失--错误。该列在订阅者表中报告为缺失。警告
当前不支持包含多个
发布的订阅，其中同一表以不同的列
列表发布。请参见 第 29.5 节。
如果一个发布正在发布生成
列，而同一订阅中的另一个发布未
发布同一表的生成列，则可能会出现相同的情况。
注意
如果订阅者来自于 18 之前的版本，则初始表
同步不会复制生成的列，即使它们在
发布者中被定义。
上一页 上一级 下一页29.5. 列列表 起始页 29.7. 冲突
