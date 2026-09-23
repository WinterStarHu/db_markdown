# 52.27. pg_inherits

52.27. pg_inherits
版本：
纠错本页面
搜索
目录导航
❮
❯
52.27. pg_inherits #
目录pg_inherits记录有关表和索引的继承层次的信息。数据库中每一个直接父子表和索引关系在这里都有一项（间接继承可以通过顺着项构成的链来确定）。
表 52.27. pg_inherits 列
列类型
描述
inhrelid oid
(references pg_class.oid)
子表或索引的OID
inhparent oid
(references pg_class.oid)
父表或索引的OID
inhseqno int4
如果一个子表有多个直接父表（多继承），这个数字说明了继承列被排列的顺序。计数从1开始。
索引不能具有多个继承，因为它们只能在使用声明性分区时继承。
inhdetachpending bool
true 用于正在脱离进程中的分区；否则为false。
上一页 上一级 下一页52.26. pg_index 起始页 52.28. pg_init_privs
