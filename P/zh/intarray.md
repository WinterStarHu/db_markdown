# F.19. intarray — 操作整数数组

F.19. intarray — 操作整数数组
版本：
纠错本页面
搜索
目录导航
❮
❯
F.19. intarray — 操作整数数组 #F.19.1. intarray 函数和操作符F.19.2. 索引支持F.19.3. 示例F.19.4. 基准测试F.19.5. 作者
intarray模块提供了一些有用的函数和操作符来操纵不含空值的整数数组。也提供了对使用某些操作符的索引搜索的支持。
如果一个提供的数组中包含任何 NULL 元素，所有这些操作都将抛出一个错误。
很多这些操作只对一维数组有意义。尽管它们将接受更多维数的数组输入，数据将被当作一个按照存储顺序排列的线性数组对待。
该模块被认为是“trusted”，也就是说，它可以由对当前数据库具有CREATE权限的非超级用户安装。
F.19.1. intarray 函数和操作符 #
intarray模块提供的函数被列在表 F.8中，操作符被列在表 F.9中。
表 F.8. intarray 函数
函数
描述
示例
icount ( integer[] )
→ integer
返回数组中元素的数量。
icount('{1,2,3}'::integer[])
→ 3
sort ( integer[], dir text )
→ integer[]
按升序或降序对数组进行排序。
dir必须是asc或desc。
sort('{1,3,2}'::integer[], 'desc')
→ {3,2,1}
sort ( integer[] )
→ integer[]
sort_asc ( integer[] )
→ integer[]
以升序排序。
sort(array[11,77,44])
→ {11,44,77}
sort_desc ( integer[] )
→ integer[]
以降序排序。
sort_desc(array[11,77,44])
→ {77,44,11}
uniq ( integer[] )
→ integer[]
移除相邻的重复项。
常与sort一起使用以移除所有重复项。
uniq('{1,2,2,3,1,1}'::integer[])
→ {1,2,3,1}
uniq(sort('{1,2,3,2,1}'::integer[]))
→ {1,2,3}
idx ( integer[], item integer )
→ integer
返回匹配item的第一个元素的索引，或如果没有匹配则返回0。
idx(array[11,22,33,22,11], 22)
→ 2
subarray ( integer[], start integer, len integer )
→ integer[]
提取从位置start开始的包含len
个元素的数组部分。
subarray('{1,2,3,2,1}'::integer[], 2, 3)
→ {2,3,2}
subarray ( integer[], start integer )
→ integer[]
提取从位置start开始的数组部分。
subarray('{1,2,3,2,1}'::integer[], 2)
→ {2,3,2,1}
intset ( integer )
→ integer[]
创建单元素数组。
intset(42)
→ {42}
表 F.9. intarray 操作符
操作符
描述
integer[] && integer[]
→ boolean
数组是否重叠（至少有一个共同元素）？
integer[] @> integer[]
→ boolean
左数组是否包含右数组？
integer[] <@ integer[]
→ boolean
左数组是否被包含在右数组中？
# integer[]
→ integer
返回数组中元素的数量。
integer[] # integer
→ integer
返回与正确参数匹配的第一个数组元素的索引，如果不匹配则返回 0。
（与idx函数相同。）
integer[] + integer
→ integer[]
将元素添加到数组末尾。
integer[] + integer[]
→ integer[]
连接数组。
integer[] - integer
→ integer[]
从数组中移除匹配右参数的项。
integer[] - integer[]
→ integer[]
从左数组中移除右数组的元素。
integer[] | integer
→ integer[]
计算参数的并集。
integer[] | integer[]
→ integer[]
计算参数的并集。
integer[] & integer[]
→ integer[]
计算参数的交集。
integer[] @@ query_int
→ boolean
数组是否满足查询？（见下文）
query_int ~~ integer[]
→ boolean
数组是否满足查询？（@@的交换子）
操作符&&、@>和<@等效于PostgreSQL的内建同名操作符，不过它们只能在不含空值的整数数组上工作，而内建的操作符可以对任何数组类型工作。这种限制使它们在很多情况下比内建操作符更快。
@@和~~操作符测试一个数组是否满足一个query，它被表示成一种特殊数据类型query_int的一个值。一个query由整数值组成，这些值会被针对数组的元素检查，可能会组合使用操作符&（AND）、|（OR）以及!（NOT）。根据需要可以使用圆括号。例如，查询1&(2|3)匹配包含 1 并且还包括 2 或 3 的数组。
F.19.2. 索引支持 #
intarray提供对于&&、@>和@@操作符以及常规数组相等的索引支持。
提供了两种参数化的 GiST 索引操作符类：gist__int_ops（被默认使用）适合于中小尺寸的数据集，而gist__intbig_ops使用一种更大的签名并且更适合于索引大型数据集（即，包含大量可区分数组值的列）。该实现使用了一种带有内建有损压缩的 RD 树结构。
gist__int_ops将整数集近似为整数范围数组。
它的可选整数参数numranges决定了一个索引键中的最大范围数。
numranges的默认值是 100。有效值在 1 到 253 之间。
使用更大的数组作为 GiST 索引键会导致更精确的搜索（扫描更小的索引部分和
更少的堆页面），以更大的索引为代价。
gist__intbig_ops将整数集近似为位图签名。
它的可选整数参数siglen确定签名长度（以字节为单位）。
默认签名长度为 16 字节。签名长度的有效值介于 1 到 2024 字节之间。
更长的签名导致更精确的搜索（扫描索引的一小部分和更少的堆页面），但代价是
更大的索引。
也有一种非默认的 GIN 操作符类gin__int_ops，支持这些操作符
以及<@。
在 GiST 和 GIN 索引之间的选择取决于 GiST 和 GIN 的相对性能特点，
这将在其他地方讨论。
F.19.3. 示例 #
-- 一个消息可以在一个或多个“小节”中
CREATE TABLE message (mid INT PRIMARY KEY, sections INT[], ...);
-- 创建签名长度为 32 字节的专用索引
CREATE INDEX message_rdtree_idx ON message USING GIST (sections gist__intbig_ops (siglen = 32));
-- 选择小节 1 或 2 中的消息 - OVERLAP 操作符
SELECT message.mid FROM message WHERE message.sections && '{1,2}';
-- 选择小节 1 和 2 中的消息 - CONTAINS 操作符
SELECT message.mid FROM message WHERE message.sections @> '{1,2}';
-- 相同，使用 QUERY 操作符
SELECT message.mid FROM message WHERE message.sections @@ '1&2'::query_int;
F.19.4. 基准测试 #
源代码目录contrib/intarray/bench包含一个基准测试套件，
可以针对一个安装好的PostgreSQL服务器运行这个套件（
还要求安装DBD::Pg）。要运行测试基准：
cd .../contrib/intarray/bench
createdb TEST
psql -c "CREATE EXTENSION intarray" TEST
./create_test.pl | psql TEST
./bench.pl
bench.pl脚本有多个选项，当它不带任何参数运行时会显示这些选项。
F.19.5. 作者 #
所有工作由 Teodor Sigaev（<teodor@sigaev.ru>）和 Oleg Bartunov（<oleg@sai.msu.su>）完成。更多信息请见http://www.sai.msu.su/~megera/postgres/gist/。Andrey Oktyabrski 在增加新函数和操作方面做了出色的工作。
上一页 上一级 下一页F.18. intagg — 整数聚合器和枚举器 起始页 F.20. isn — 国际标准号码（ISBN、EAN、UPC等）的数据类型
