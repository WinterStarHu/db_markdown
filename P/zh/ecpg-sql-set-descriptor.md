# SET DESCRIPTOR

SET DESCRIPTOR
版本：
纠错本页面
搜索
目录导航
❮
❯
SET DESCRIPTORSET DESCRIPTOR — 在 SQL 描述符区域中设置信息大纲
SET DESCRIPTOR descriptor_name descriptor_header_item = value [, ... ]
SET DESCRIPTOR descriptor_name VALUE number descriptor_item = value [, ...]
描述
SET DESCRIPTOR用值填充一个 SQL 描述符区域。然后该描述符区域通常会被用来在一个预备查询执行中绑定参数。
这个命令有两种形式：第一种形式适用于描述符“头部”，它独立于特定的数据。第二种形式为由数字标识的特定数据赋值。
参数descriptor_name #
一个描述符名称。
descriptor_header_item #
一个标识要设置哪个头部信息项的记号。当前只有设置描述符项数量的COUNT被支持。
number #
要设置的描述符项的编号。计数从 1 开始。
descriptor_item #
一个标识在描述符中要设置哪个信息项的记号。受支持的项的列表可见第 34.7.1 节。
value #
一个要存储在描述符项中的值。这可以是一个 SQL 常量或者一个主变量。
示例
EXEC SQL SET DESCRIPTOR indesc COUNT = 1;
EXEC SQL SET DESCRIPTOR indesc VALUE 1 DATA = 2;
EXEC SQL SET DESCRIPTOR indesc VALUE 1 DATA = :val1;
EXEC SQL SET DESCRIPTOR indesc VALUE 2 INDICATOR = :val1, DATA = 'some string';
EXEC SQL SET DESCRIPTOR indesc VALUE 2 INDICATOR = :val2null, DATA = :val2;
兼容性
SET DESCRIPTOR 在 SQL 标准中被指定。
另请参阅ALLOCATE DESCRIPTOR, GET DESCRIPTOR上一页 上一级 下一页SET CONNECTION 起始页 TYPE
