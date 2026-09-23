# 68.6. BKI示例

68.6. BKI示例
版本：
纠错本页面
搜索
目录导航
❮
❯
68.6. BKI示例 #
下面的命令序列将创建test_table表，表的OID为420，它有三列oid、cola和colb，类型分别为oid、int4和text，然后向该表插入两行：
create test_table 420 (oid = oid, cola = int4, colb = text)
open test_table
insert ( 421 1 'value 1' )
insert ( 422 2 _null_ )
close test_table
上一页 上一级 下一页68.5. 自举BKI文件的结构 起始页 第 69 章 规划器如何使用统计信息
