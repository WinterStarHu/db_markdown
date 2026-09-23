# 68.4. BKI命令

68.4. BKI命令
版本：
纠错本页面
搜索
目录导航
❮
❯
68.4. BKI命令 #
create
tablename
tableoid
[bootstrap]
[shared_relation]
[rowtype_oid oid]
(name1 =
type1
[FORCE NOT NULL | FORCE NULL ] [,
name2 =
type2
[FORCE NOT NULL | FORCE NULL ],
...])
创建一个叫做tablename，OID为tableoid的表，它的列在圆括号中给出。
bootstrap.c直接支持下列列类型：bool、bytea、char（1 字节）、name、int2、int4、regproc、regclass、regtype、text、oid、tid、xid、cid、int2vector、oidvector、_int4（数组）、_text（数组）、_oid（数组）、_char（数组）、_aclitem（数组）。尽管我们可以创建包含其他类型列的表，但是我们只有在创建完pg_type并且填充了合适的记录之后才行（这实际上就意味着在自举目录中，只能使用这些列类型，而非自举目录可以使用任意内置类型）。
当指定bootstrap时，表只会在磁盘上创建；不会在pg_class、pg_attribute等中输入任何内容。因此，在通过insert命令以硬编码的方式进行这些条目之前，该表将无法通过普通的SQL操作访问。此选项用于创建pg_class等本身。
如果声明了shared_relation，那么表就作为共享表创建。
表的行类型OID（pg_type的OID）可以有选择性地通过rowtype_oid子句指定；如果没有指定，会为之自动生成一个OID。（如果bootstrap被指定，则rowtype_oid是无效的，但不管怎样它还是被写在了文档中。）
open tablename
打开名为tablename的表进行数据插入。任何当前打开的表将被关闭。
close tablename
关闭打开的表。给出的表名用于交叉检查。
insert ( [oid_value] value1 value2 ... )
用value1、value2等作为列值向打开的表插入一条新记录。
NULL值可以使用特殊的关键字_null_指定。看起来不像标识符或数字字符串的值必须用单引号括起来。
（要在一个值中包含单引号，将其写两次。转义字符串风格的反斜杠转义在字符串中也是允许的。）
declare [unique]
index indexname
indexoid
on tablename
using amname
( opclass1
name1
[, ...] )
在名为tablename的表上用amname访问方法创建一个OID为indexoid的名为indexname的索引。索引的字段被称为name1、name2等，而使用的操作符类分别是opclass1、opclass2等。该命令将会创建索引文件和适当的系统目录项，但是索引内容不会被此命令初始化。
declare toast
toasttableoid
toastindexoid
on tablename
为名为tablename的表创建一个TOAST表。该TOAST表将被赋予由toasttableoid表示的OID，且它的索引将被赋予由toastindexoid表示的OID。和declare index一样，索引的填充将被推迟。
build indices
填充之前声明的索引。
上一页 上一级 下一页68.3. BKI文件格式 起始页 68.5. 自举BKI文件的结构
