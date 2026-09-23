# F.20. isn — 国际标准号码（ISBN、EAN、UPC等）的数据类型

F.20. isn — 国际标准号码（ISBN、EAN、UPC等）的数据类型
版本：
纠错本页面
搜索
目录导航
❮
❯
F.20. isn — 国际标准号码（ISBN、EAN、UPC等）的数据类型 #F.20.1. 数据类型F.20.2. 类型转换F.20.3. 函数和运算符F.20.4. 配置参数F.20.5. 示例F.20.6. 参考文献F.20.7. 作者
isn模块为下列国际产品编号标准提供数据类型：EAN13、UPC、ISBN（图书）、ISMN（音乐）以及 ISSN（期刊）。在输入时会按照一个硬编码的前缀列表对输入进行验证，这个前缀的列表也被用来在输出时连接号码。因为新的前缀总是不时地出现，这个前缀列表可能会过时。这个模块的一个未来版本有希望得到一个来自于一个或多个表的前缀列表，这样用户可以根据需要来方便地更新前缀列表。不过，在当前该列表只能通过修改源代码并且重新编译来更新。另外一种方案是，在这个模块的未来版本中可能会直接移除掉前缀验证和连接支持。
该模块被认为是“trusted”，也就是说，它可以由对当前数据库具有CREATE权限的非超级用户安装。
F.20.1. 数据类型 #
表 F.10展示了isn模块提供的数据类型。
表 F.10. isn 数据类型数据类型描述EAN13
欧洲商品条码，总是以 EAN13 格式显示
ISBN13
国际标准图书号，以新的 EAN13 格式显示
ISMN13
国际标准音乐号，以新的 EAN13 格式显示
ISSN13
国际标准连续出版物号，以新的 EAN13 格式显示
ISBN
国际标准图书号，以旧的短格式显示
ISMN
国际标准音乐号，以旧的短格式显示
ISSN
国际标准连续出版物号，以旧的短格式显示
UPC
通用产品代码
一些注释：
ISBN13、ISMN13、ISSN13 号码都是 EAN13 号码。EAN13 号码不总是 ISBN13、ISMN13 或 ISSN13（有些是）。一些 ISBN13 号码可以作为 ISBN 显示。一些 ISMN13 号码可以作为 ISMN 显示。一些 ISSN13 号码可以作为 ISSN 显示。UPC 号码是 EAN13 号码的一个子集（它们基本上是去掉了第一个0位的 EAN13）。所有 UPC、ISBN、ISMN 和 ISSN 号码可以表示为 EAN13 号码。
在内部，所有这些类型使用同一种表示（一个 64 位整数），并且所有都是可以互换的。多种类型被提供来控制显示格式，并且对假定表示一种特定类型数字的输入进行更严格的合法性检查。
在可能时，ISBN、ISMN和ISSN类型将显示号码的短版本（ISxN 10），并且在无法适应短版本时显示号码的 ISxN 13 格式。EAN13、ISBN13、ISMN13和ISSN13类型总是显示长版本的 ISxN（EAN13）。
F.20.2. 类型转换 #
isn模块提供了下列类型之间的转换：
ISBN13 <=> EAN13
ISMN13 <=> EAN13
ISSN13 <=> EAN13
ISBN <=> EAN13
ISMN <=> EAN13
ISSN <=> EAN13
UPC  <=> EAN13
ISBN <=> ISBN13
ISMN <=> ISMN13
ISSN <=> ISSN13
当从EAN13转换为另一种类型时，会有对该值是否在另一种类型的域中的运行时检查，如果不在则抛出一个错误。其他的转换则是简单地重新贴个标签，因此总是会成功。
F.20.3. 函数和运算符 #
isn 模块提供了标准的比较运算符，
以及对所有这些数据类型的 B-tree 和哈希索引支持。
此外，还有几个专用函数，如 表 F.11 所示。
在此表中，
isn 表示模块的任何数据类型。
表 F.11. isn 函数
函数
描述
make_valid ( isn )
→ isn
清除值的无效检查数字标志。
is_valid ( isn )
→ boolean
检查无效检查数字标志的存在。
isn_weak ( boolean )
→ boolean
设置弱输入模式，并返回新的设置。
此函数保留用于向后兼容。
设置弱模式的推荐方法是通过
isn.weak 配置参数。
isn_weak ()
→ boolean
返回当前弱模式的状态。
此函数保留用于向后兼容。
检查弱模式的推荐方法是通过
isn.weak 配置参数。
F.20.4. 配置参数 #
isn.weak (boolean)
#
isn.weak 启用弱输入模式，这允许
即使检查数字错误也接受 ISN 输入值。
默认值为 false，这会拒绝无效的检查
数字。
为什么你会想要使用弱模式？你可能有一个巨大的 ISBN 号码集合，并且出于某种奇怪的原因其中具有错误的校验位（可能这些号码是从印刷稿中扫描并且 OCR 而来，也可能是手工输入的......谁知道呢）。不管怎样，重点是你可能希望清理这些混乱，但是你仍然想要能够把这些号码放在你的数据库中，并且可能会使用一个外部工具在数据库中定位无效号码，这样你能够更容易地验证信息。因此你可能会想要在表中选择所有无效的号码。
当你使用弱模式在一个表中插入无效号码时，被插入的号码将会被加上修正过的校验位，但是它的最后将会有一个感叹号（!），例如0-11-000322-5!。这种无效标志符可以用is_valid函数检查，并且可以用make_valid函数清除。
您还可以强制插入标记为无效的数字，即使在
弱模式下，也可以通过在数字末尾附加
! 字符来实现。
另一个特殊特性是在输入过程中，你可以写一个?代替校验位，然后正确的校验位将被自动插入。
F.20.5. 示例 #
--直接使用类型：
SELECT isbn('978-0-393-04002-9');
SELECT isbn13('0901690546');
SELECT issn('1436-4522');
--类型转换：
-- 请注意，您只能在目标类型的范围内
-- 当数字有效时才能从 ean13 转换为其他类型；
-- 因此，以下内容将不起作用： select isbn(ean13('0220356483481'));
-- 但这些将有效：
SELECT upc(ean13('0220356483481'));
SELECT ean13(upc('220356483481'));
--创建一个只有一列的表来存储 ISBN 数字：
CREATE TABLE test (id isbn);
INSERT INTO test VALUES('9780393040029');
--自动计算检查数字（注意 '?'）：
INSERT INTO test VALUES('220500896?');
INSERT INTO test VALUES('978055215372?');
SELECT issn('3251231?');
SELECT ismn('979047213542?');
--使用弱模式：
SET isn.weak TO true;
INSERT INTO test VALUES('978-0-11-000533-4');
INSERT INTO test VALUES('9780141219307');
INSERT INTO test VALUES('2-205-00876-X');
SET isn.weak TO false;
SELECT id FROM test WHERE NOT is_valid(id);
UPDATE test SET id = make_valid(id) WHERE id = '2-205-00876-X!';
SELECT * FROM test;
SELECT isbn13(id) FROM test;
F.20.6. 参考文献 #
实现此模块的信息收集自
几个网站，包括：
https://www.isbn-international.org/https://www.issn.org/https://www.ismn-international.org/https://www.wikipedia.org/
用于连字符的前缀也来自于：
https://www.gs1.org/standards/id-keyshttps://en.wikipedia.org/wiki/List_of_ISBN_registration_groupshttps://www.isbn-international.org/content/isbn-users-manual/29https://en.wikipedia.org/wiki/International_Standard_Music_Numberhttps://www.ismn-international.org/ranges/tools
在创建算法时进行了仔细的检查，并且
与官方 ISBN、ISMN、ISSN 用户手册中建议的算法
进行了细致的验证。
F.20.7. 作者 #
Germán Méndez Bravo (Kronuz), 2004–2006
这个模块受到了 Garrett A. Wollman 的isbn_issn代码的启发。
上一页 上一级 下一页F.19. intarray — 操作整数数组 起始页 F.21. lo — 管理大对象
