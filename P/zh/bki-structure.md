# 68.5. 自举BKI文件的结构

68.5. 自举BKI文件的结构
版本：
纠错本页面
搜索
目录导航
❮
❯
68.5. 自举BKI文件的结构 #
在open命令打开某个表时，它需要系统中已经存在一些表并且其中要具有与被打开表相关的项，在这些先决条件满足之前，open命令不能被使用（这些至少应该存在的表是pg_class、pg_attribute、pg_proc和pg_type）。 为了允许这些表本身被填充，带着bootstrap选项的create将会隐式打开所创建的表用于插入数据。
同样，declare index和declare toast命令也必须在相关系统目录被创建和填充之后才能被使用。
因此，postgres.bki文件的结构必须是：
create bootstrap其中一个关键表
insert数据，这些数据至少要能描述这些关键表
close
重复创建其他关键表。
create（不带bootstrap）一个非关键表
open
insert需要的数据
close
重复创建其他非关键表。
定义索引和TOAST表。
build indices
无疑还有其他未被文档记录的顺序依赖关系。
上一页 上一级 下一页68.4. BKI命令 起始页 68.6. BKI示例
