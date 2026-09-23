# 68.2. 系统目录初始数据

68.2. 系统目录初始数据
版本：
纠错本页面
搜索
目录导航
❮
❯
68.2. 系统目录初始数据 #68.2.1. 数据文件格式68.2.2. OID分配68.2.3. OID引用查找68.2.4. 自动创建数组类型68.2.5. 编辑数据文件的方案
每个有手工创建的初始数据（有些没有）的目录都有一个相应的.dat文件，其中以可编辑的格式包含着该目录的初始数据。
68.2.1. 数据文件格式 #
每个.dat文件含有Perl数据结构文本，它可以简单地通过eval产生由一个哈希引用数组构成的内存数据结构，每个目录行一个。从pg_database.dat摘出的经过略微修改的一小部分可以展示关键特性：
[
# A comment could appear here.
{ oid => '1', oid_symbol => 'Template1DbOid',
descr => 'database\'s default template',
datname => 'template1', encoding => 'ENCODING',
datlocprovider => 'LOCALE_PROVIDER', datistemplate => 't',
datallowconn => 't', dathasloginevt => 'f', datconnlimit => '-1', datfrozenxid => '0',
datminmxid => '1', dattablespace => 'pg_default', datcollate => 'LC_COLLATE',
datctype => 'LC_CTYPE', datlocale => 'DATLOCALE', datacl => '_null_' },
]
需要注意的点：
总体的文件布局是：开方括号，一个或多个花括号集合（每一个表示一个目录行），闭方括号。在每一个闭花括号之后写一个逗号。
在每个目录行内，写成逗号分隔的key => value对。允许的key是该目录的列名，外加上元数据键oid、oid_symbol、array_type_oid以及descr。（oid和oid_symbol的使用在下文的第 68.2.2 节中描述，而array_type_oid在第 68.2.4 节中描述。descr为该对象提供一个描述字符串，它将被插入到pg_description或pg_shdescription中。）虽然元数据键是可选的，但是目录中定义的列必须全部提供，除非目录的.h文件为该列指定了默认值。在上述例子中，忽略了datdba字段是因为pg_database.h为其提供了适当的默认值。
所有的值都必须被放在单引号中。用反斜线可以转义值中用到的单引号。作为数据的反斜线可以（但是不必）被双写，这遵循的是Perl对简单引用文本的规则。注意，作为数据出现的反斜线将被bootstrap扫描器根据转义字符串常量的相同规则（见第 4.1.2.2 节）当作转义处理。例如\t转换为一个制表符。如果在最终值中确实想要一个反斜线，则需要写成四个：Perl会剥离掉两个，留下\\给bootstrap扫描器。
空值被表示为_null_。（注意没有办法创建就是该字符串的值。）
注释以#开头，并且必须位于它们自己的行上。
那些是其他目录条目的OID的字段值应该用符号名而不是实际的数字OID来表示。（在上述例子中，dattablespace包含此类的引用。）这会在下文的第 68.2.3 节中描述。
因为哈希是无序的数据结构，域顺序和行布局并不重要。不过，为了维持一种一致的外观，我们设定了一些规则，它们由格式化脚本reformat_dat_file.pl实施：
在每一对花括号内，元数据域oid、oid_symbol、array_type_oid和descr（如果存在）按照这个顺序放在最前面，然后以定义时的顺序放上该目录自己的域。
如果可能，根据需要在域之间插入新行以限制行的长度低于80字符。在元数据域和普通域之间也插入一个新行。
如果目录的.h文件为一个列指定了默认值并且一个数据项具有相同的值，reformat_dat_file.pl将从数据文件中省去它。这能使得数据表达紧凑。
reformat_dat_file.pl原样保留空行和注释行。
推荐在提交目录数据补丁前运行reformat_dat_file.pl。为了方便起见，可以简单地更改src/include/catalog/并运行make reformat-dat-files。
如果想要增加一种新方法让数据表达更小，必须在reformat_dat_file.pl中实现该方法并且还要教会Catalog::ParseData()如何将数据展开回完整的表达。
68.2.2. OID分配 #
通过写一个oid => nnnn元数据域，出现在初始数据中的目录行可以被给予一个手工分配的OID。此外，如果分配一个OID，可以通过书写一个oid_symbol => name元数据域为该OID创建一个C宏。
如果预装载的目录行被其他预装载行用OID引用，则必须给它们预先分配OID。如果行的OID必须被C代码引用，也需要预分配的OID。如果两种情况都不符合，则oid元数据域可以被省略，在这种情况下bootstrap代码会自动分配OID。实际上对于一个给定的目录，即便其中某些行实际并没有被交叉引用，我们也通常会为其中预装载的行全部预分配OID或者全部不分配OID。
在C代码中写出任何OID的实际数字值是一种非常糟糕的形式，通常应该使用宏。对pg_proc OID的直接引用太常见了，因此有一种特别的机制自动创建必需的宏，见src/backend/utils/Gen_fmgrtab.pl。类似地 — 但是由于历史原因，实现的方式不同 — 也有一种自动的为pg_type OID创建宏的方法。因此在这两个目录中，oid_symbol项不是必需的。同样，系统目录和索引的pg_class OID的宏是自动设置的。对于所有其他系统目录，开发者必须通过oid_symbol项手动指定所需的宏。
要为一个新的预装载行找到一个可用的OID，可以运行脚本src/include/catalog/unused_oids。
它能打印出未被使用的OID的闭区间范围（例如，输出行45-900表示OID 45到900都还没有被分配出去）。
当前，OID 1–9999被保留给手工分配，unused_oids脚本会简单地查看目录头部以及.dat文件来看看哪些OID没有出现。
也可以使用duplicate_oids脚本来检查错误（genbki.pl将为没有手工分配给它们的任何行分配OID，还会在编译时检测重复的OID）。
在为一个不会立即提交的补丁选择OID时，最佳实践是使用一组接近连续的OID，以8000—9999范围中随机选择的值作为开始。这样就将其与其他同时开发的补丁的冲突的风险降至最低。为了保持8000—9999范围对于开发来说可自由使用，在补丁提交到git库之后，应使用低于该范围的可用空间重新编号。通常这项工作会在接近每次开发周期的尾声时做，与此同时移动由该周期提交的补丁所消费掉的所有OID。renumber_oids.pl脚本可用来完成该项工作。如果发现一个未提交的补丁与一些近来提交的补丁有OID冲突，renumber_oids.pl也可用于从此状况下的恢复。
因为此约定可能会对补丁程序分配的OID重新编号，在补丁纳入到官方发布版本之前，补丁所分配的OID不应该认为是稳定的。一旦发布，我们并不修改手工分配的对象OID，但是那样会产生各种各样的兼容性问题。
如果genbki.pl需要为一个没有手动分配OID的目录条目分配一个OID，它将使用范围在10000—11999之间的值。服务器的OID计数器在引导运行开始时设置为10000，因此在引导处理期间动态创建的任何对象也会收到此范围内的OID。（通常的OID分配机制会确保不会发生任何冲突。）
对象的OID低于FirstUnpinnedObjectId（12000）被视为“pinned”，防止它们被删除。
（有一小部分例外情况，这些例外情况被硬编码到IsPinnedObject()中。）
initdb在准备好创建未固定对象时，会将OID计数器提升到FirstUnpinnedObjectId。
因此，在initdb的后期阶段创建的对象，比如在运行information_schema.sql脚本时创建的对象，将不会被固定，而所有被genbki.pl知道的对象将被固定。
在正常数据库操作期间分配的OID受到限制，必须为16384或更高。这确保了范围10000—16383
为genbki.pl或在initdb期间自动分配的OID保留。
这些自动分配的OID不被视为稳定，并且可能在不同的安装中发生变化。
68.2.3. OID引用查找 #
原则上，从一个初始目录行到另一个初始目录行的交叉引用只需要在引用字段中写上被引用行的预分配OID就可以实现。但是这违反了项目策略，因为它容易出错，难理解，并且如果新分配的OID重新编号的话容易损坏。因此genbki.pl提供了替代的方式来编写符号引用。规则如下：
通过对特定的目录列定义附加BKI_LOOKUP(lookuprule)来开启对符号化引用的使用，其中lookuprule是被引用目录的名称，例如pg_proc。BKI_LOOKUP可以被附加到类型为Oid、regproc、oidvector或者Oid[]的列上，在后两种情况中它意味着在数组的每个元素上执行查找。
也允许将BKI_LOOKUP(encoding)附加到整数列以引用字符集编码，字符集编码目前还没有表示为目录OID，但有对于genbki.pl已知的一组值。
在一些目录列，允许条目为零而不是有效的引用。如果这是允许的，写
BKI_LOOKUP_OPT而不是BKI_LOOKUP。然后你可以
写0作为一个条目。（如果列被声明为regproc，你可以选择
写-而不是0。）除了这种特殊情况外，所有条目在
BKI_LOOKUP列中必须是符号引用。genbki.pl将会警告无法识别的名称。
大多数种类的目录对象仅通过其名称引用。注意类型名称必须完全匹配被引用的
pg_type项的typname；不能使用
任何别名，例如用integer来替代int4。
函数可以用其proname来表示，前提是它在pg_proc.dat项中是唯一的（这和regproc输入类似）。否则，要将函数写成proname(argtypename,argtypename,...)，就像regprocedure那样。参数的类型名称必须被拼写准确，和它们在pg_proc.dat项的proargtypes域中的值一致。不要插入任何空白。
操作符的名称由oprname(lefttype,righttype)表示，类型名称要写得准确，与它们出现在pg_operator.dat项的oprleft和oprright域中的值一样。（对于一元操作符省略的操作数，可以写成0。）
操作符类和操作符族的名称仅在一个访问方法中唯一，因此它们用access_method_name/object_name表示。
在这些情况中都不能有模式限定，所有在bootstrap期间创建的对象都应该出现在pg_catalog模式中。
genbki.pl在运行时会解决所有符号引用，并将简单的数字OID放入输出的BKI文件中。因此不需要bootstrap后端处理符号引用。
将OID引用列标记为BKI_LOOKUP或BKI_LOOKUP_OPT是较为可取的，即使目录没有需要查找的初始数据。这允许genbki.pl记录系统目录中已经存在的外键关系。这些信息在回归测试中用于检查不正确的条目。也可参见宏DECLARE_FOREIGN_KEY、DECLARE_FOREIGN_KEY_OPT、DECLARE_ARRAY_FOREIGN_KEY和DECLARE_ARRAY_FOREIGN_KEY_OPT，用于声明BKI_LOOKUP过于复杂的外键关系（通常是多列外键）。
68.2.4. 自动创建数组类型 #
大多数标量数据类型应该有一个相应的数组类型（即元素类型为标量类型的标准变长数组类型，该类型由标量类型的pg_type条目的typarray字段引用）。genbki.pl在大多数情况下能够自动为数组类型生成pg_type条目。
要使用此工具，只需在标量类型的pg_type条目中写入array_type_oid => nnnn元数据字段，指定要用于数组类型的OID。然后可以省略typarray字段，因为它会使用该OID自动填充。
生成的数组类型名是标量类型名称，前面加下划线。数组条目的其他字段由BKI_ARRAY_DEFAULT(value)注释填充，如果没有则从标量类型复制。（对于typalign也有一种特殊情况）然后，将两个条目的typelem和typarray字段设置为相互交叉引用。
68.2.5. 编辑数据文件的方案 #
在更新目录数据文件时，对于执行常用任务的简便方法，这里有一些建议。
向一个目录增加一个带有默认值的新列：.
用BKI_DEFAULT(value)标注将列增加到头文件中。数据文件的调整仅需要在要求非默认值的现有行中增加该字段就可以。
为没有默认值的现有列增加默认值：.
在头文件中增加一个BKI_DEFAULT标注，然后运行make reformat-dat-files以移除现在变得冗余的字段项。
移除一列，无论它是否有默认值：.
从头文件中移除该列，然后运行make reformat-dat-files以移除现在无用的字段项。
更改或移除现有的默认值：.
不能简单地更改头文件，因为这将会导致当前的数据被不正确地解读。首先运行make expand-dat-files用显式插入所有默认值的形式重写数据文件，然后更改或移除BKI_DEFAULT标注，然后运行make reformat-dat-files移除多余的字段。
临时批量编辑：.
可以修改reformat_dat_file.pl执行很多种批量更改。寻找其中展示可以插入一次性代码的注释块。在下面的例子中，我们将把pg_proc中的两个Boolean字段联合成一个char字段：
在pg_proc.h中增加一个带有默认值的新列：
+    /* see PROKIND_ categories below */
+    char        prokind BKI_DEFAULT(f);
基于reformat_dat_file.pl创建一个新脚本以插入合适的值：
-           # At this point we have the full row in memory as a hash
-           # and can do any operations we want. As written, it only
-           # removes default values, but this script can be adapted to
-           # do one-off bulk-editing.
+           # One-off change to migrate to prokind
+           # Default has already been filled in by now, so change to other
+           # values as appropriate
+           if ($values{proisagg} eq 't')
+           {
+               $values{prokind} = 'a';
+           }
+           elsif ($values{proiswindow} eq 't')
+           {
+               $values{prokind} = 'w';
+           }
运行新的脚本：
$ cd src/include/catalog
$ perl  rewrite_dat_with_prokind.pl  pg_proc.dat
到这里pg_proc.dat拥有所有三个列prokind、proisagg以及proiswindow，不过它们将只出现在它们有非默认值的行中。
从pg_proc.h移除旧的列：
-    /* is it an aggregate? */
-    bool        proisagg BKI_DEFAULT(f);
-
-    /* is it a window function? */
-    bool        proiswindow BKI_DEFAULT(f);
最后，运行make reformat-dat-files从pg_proc.dat中移除无用的旧项。
用于批量编辑的脚本的更多例子，请参考这个消息https://www.postgresql.org/message-id/CAJVSVGVX8gXnPm+Xa=DxR7kFYprcQ1tNcCT5D0O3ShfnM6jehA@mail.gmail.com的附件convert_oid2name.pl和remove_pg_type_oid_symbols.pl。
上一页 上一级 下一页68.1. 系统目录声明规则 起始页 68.3. BKI文件格式
