# 43.3. 内置函数

43.3. 内置函数
版本：
纠错本页面
搜索
目录导航
❮
❯
43.3. 内置函数 #43.3.1. 从 PL/Perl 访问数据库43.3.2. PL/Perl 中的工具函数43.3.1. 从 PL/Perl 访问数据库 #
可以通过下列函数从 Perl 函数中访问数据库本身：
spi_exec_query(query [, limit])
spi_exec_query 执行一个 SQL 命令，并将整个行集作为哈希引用数组的引用返回。
如果指定了 limit 并且大于零，则 spi_exec_query 最多检索 limit 行，就像查询包括一个 LIMIT 子句一样。省略 limit 或将其指定为零将导致没有行限制。
只有在您知道结果集相对较小时才应使用此命令。这是一个带有可选最大行数的查询（SELECT 命令）示例：
$rv = spi_exec_query('SELECT * FROM my_table', 5);
这将从表 my_table 返回最多 5 行。如果 my_table 有一列 my_column，您可以像这样从结果的第 $i 行获取该值：
$foo = $rv->{rows}[$i]->{my_column};
可以通过以下方式访问从 SELECT 查询返回的总行数：
$nrows = $rv->{processed}
这里是使用不同命令类型的一个例子：
$query = "INSERT INTO my_table VALUES (1, 'test')";
$rv = spi_exec_query($query);
您可以这样访问命令状态（例如 SPI_OK_INSERT）：
$res = $rv->{status};
要得到受影响的行数：
$nrows = $rv->{processed};
这里是一个完整的例子：
CREATE TABLE test (
i int,
v varchar
);
INSERT INTO test (i, v) VALUES (1, 'first line');
INSERT INTO test (i, v) VALUES (2, 'second line');
INSERT INTO test (i, v) VALUES (3, 'third line');
INSERT INTO test (i, v) VALUES (4, 'immortal');
CREATE OR REPLACE FUNCTION test_munge() RETURNS SETOF test AS $$
my $rv = spi_exec_query('select i, v from test;');
my $status = $rv->{status};
my $nrows = $rv->{processed};
foreach my $rn (0 .. $nrows - 1) {
my $row = $rv->{rows}[$rn];
$row->{i} += 200 if defined($row->{i});
$row->{v} =~ tr/A-Za-z/a-zA-Z/ if (defined($row->{v}));
return_next($row);
}
return undef;
$$ LANGUAGE plperl;
SELECT * FROM test_munge();
spi_query(command)
spi_fetchrow(cursor)
spi_cursor_close(cursor)
spi_query和spi_fetchrow
结对用于可能比较大的行集合，或者用于希望在行到达时返回的情况。
spi_fetchrow只和
spi_query一起工作。下面的例子展示了如何使用
它们：
CREATE TYPE foo_type AS (the_num INTEGER, the_text TEXT);
CREATE OR REPLACE FUNCTION lotsa_md5 (INTEGER) RETURNS SETOF foo_type AS $$
use Digest::MD5 qw(md5_hex);
my $file = '/usr/share/dict/words';
my $t = localtime;
elog(NOTICE, "opening file $file at $t" );
open my $fh, '<', $file # ooh, it's a file access!
or elog(ERROR, "cannot open $file for reading: $!");
my @words = <$fh>;
close $fh;
$t = localtime;
elog(NOTICE, "closed file $file at $t");
chomp(@words);
my $row;
my $sth = spi_query("SELECT * FROM generate_series(1,$_[0]) AS b(a)");
while (defined ($row = spi_fetchrow($sth))) {
return_next({
the_num => $row->{a},
the_text => md5_hex($words[rand @words])
});
}
return;
$$ LANGUAGE plperlu;
SELECT * from lotsa_md5(500);
通常，spi_fetchrow应该重复执行直到它返回
undef（表示没有更多行要读取）。当
spi_fetchrow返回undef时，
spi_query返回的游标会自动被释放。如果不
想读取所有的行，可以调用spi_cursor_close来
释放游标。如果没有这样做会导致内存泄漏。
spi_prepare(command, argument types)
spi_query_prepared(plan, arguments)
spi_exec_prepared(plan [, attributes], arguments)
spi_freeplan(plan)
spi_prepare, spi_query_prepared, spi_exec_prepared,
和spi_freeplan实现了相同的功能，但用于预处理查询。
spi_prepare接受一个带有编号参数占位符（$1，$2等）和参数类型的字符串列表：
$plan = spi_prepare('SELECT * FROM test WHERE id > $1 AND name = $2',
'INTEGER', 'TEXT');
一旦通过调用spi_prepare准备了查询计划，该计划可以代替字符串查询使用，
可以在spi_exec_prepared中使用，其结果与spi_exec_query返回的结果相同，
或者在spi_query_prepared中使用，该函数返回一个游标，正如spi_query所做的那样，
该游标稍后可以传递给spi_fetchrow。
spi_exec_prepared的可选第二个参数是属性的哈希引用；
目前仅支持的属性是limit，它设置从查询返回的最大行数。
省略limit或将其指定为零将导致没有行限制。
准备查询的优点是可以为多个查询执行使用一个准备计划。在计划不再需要时，可以使用
spi_freeplan来释放它：
CREATE OR REPLACE FUNCTION init() RETURNS VOID AS $$
$_SHARED{my_plan} = spi_prepare('SELECT (now() + $1)::date AS now',
'INTERVAL');
$$ LANGUAGE plperl;
CREATE OR REPLACE FUNCTION add_time( INTERVAL ) RETURNS TEXT AS $$
return spi_exec_prepared(
$_SHARED{my_plan},
$_[0]
)->{rows}->[0]->{now};
$$ LANGUAGE plperl;
CREATE OR REPLACE FUNCTION done() RETURNS VOID AS $$
spi_freeplan( $_SHARED{my_plan});
undef $_SHARED{my_plan};
$$ LANGUAGE plperl;
SELECT init();
SELECT add_time('1 day'), add_time('2 days'), add_time('3 days');
SELECT done();
add_time  |  add_time  |  add_time
------------+------------+------------
2005-12-10 | 2005-12-11 | 2005-12-12
请注意，在spi_prepare中的参数下标是通过$1、$2、$3等定义的，因此要避免
在双引号中声明可能很容易导致难以捕捉错误的查询字符串。
另一个示例说明了在spi_exec_prepared中使用可选参数的用法：
CREATE TABLE hosts AS SELECT id, ('192.168.1.'||id)::inet AS address
FROM generate_series(1,3) AS id;
CREATE OR REPLACE FUNCTION init_hosts_query() RETURNS VOID AS $$
$_SHARED{plan} = spi_prepare('SELECT * FROM hosts
WHERE address << $1', 'inet');
$$ LANGUAGE plperl;
CREATE OR REPLACE FUNCTION query_hosts(inet) RETURNS SETOF hosts AS $$
return spi_exec_prepared(
$_SHARED{plan},
{limit => 2},
$_[0]
)->{rows};
$$ LANGUAGE plperl;
CREATE OR REPLACE FUNCTION release_hosts_query() RETURNS VOID AS $$
spi_freeplan($_SHARED{plan});
undef $_SHARED{plan};
$$ LANGUAGE plperl;
SELECT init_hosts_query();
SELECT query_hosts('192.168.1.0/30');
SELECT release_hosts_query();
query_hosts
-----------------
(1,192.168.1.1)
(2,192.168.1.2)
(2 rows)
spi_commit()
spi_rollback()
提交或回滚当前事务。只能在从顶层调用的过程或匿名代码块（DO命令）中调用这个函数（注意不能通过spi_exec_query或类似的函数运行SQL命令COMMIT或ROLLBACK。这样的工作只能使用这些函数完成）。在一个事务结束后，一个新的事务会自动开始，因此没有单独的函数来开始新事务。
这里是一个例子：
CREATE PROCEDURE transaction_test1()
LANGUAGE plperl
AS $$
foreach my $i (0..9) {
spi_exec_query("INSERT INTO test1 (a) VALUES ($i)");
if ($i % 2 == 0) {
spi_commit();
} else {
spi_rollback();
}
}
$$;
CALL transaction_test1();
43.3.2. PL/Perl 中的工具函数 #
elog(level, msg)
发出一个日志或错误消息。可用的级别有
DEBUG、LOG、INFO、
NOTICE、WARNING和ERROR。
ERROR产生一种错误情况，如果它没有被周围的 Perl 代码
捕获，错误会传播到调用查询中，导致当前事务或子事务被中止。这实际
上和 Perl 的die命令相同。其他级别只产生不同优先级的消息。
特定优先级的消息是被报告给客户端、写到服务器日志或两者都做由
配置变量log_min_messages和
client_min_messages控制。详见
第 19 章。
quote_literal(string)
返回给定字符串的被适当引用后的形式，这种形式能被用作 SQL 语句字符串中的字符串。
嵌入的引号和反斜线会被正确地双写。注意对 undef 输入quote_literal
会返回 undef。如果参数可能是 undef，quote_nullable通常更合适。
quote_nullable(string)
返回给定字符串的被适当引用后的形式，这种形式能被用作 SQL 语句字符串中的字符串；
或者在参数为 undef 时，返回未引用的串 "NULL"。
嵌入的引号和反斜线会被正确地双写。
quote_ident(string)
返回给定字符串的适当引用形式，以便用作 SQL 语句字符串中的标识符。
只有在必要时才增加引号（即，如果字符串包含非标识符字符或会被大小写折叠）。
嵌入的引号会被正确地双写。
decode_bytea(string)
返回由给定字符串的内容表示的未转义二进制数据，该内容应为bytea编码。
encode_bytea(string)
返回给定字符串的二进制数据内容的bytea编码形式。
encode_array_literal(array)
encode_array_literal(array, delimiter)
返回被引用数组的内容作为数组文字格式的字符串（见第 8.15.2 节）。
如果它不是数组的引用，则不加修改地返回参数值。如果没有指定定界符或定界符为
undef，则默认使用", "作为数组文字元素之间的定界符。
encode_typed_literal(value, typename)
将一个 Perl 变量转换为由第二个参数传入的数据类型的值，并返回该值
的字符串表示。它能正确地处理嵌套数组和复合类型的值。
encode_array_constructor(array)
返回被引用数组的内容，格式为数组构造器格式（
第 4.2.12 节）。
个体值使用 quote_nullable 引用。
如果参数不是一个数组引用，则返回用 quote_nullable 引用的该参数值。
looks_like_number(string)
如果给定字符串的内容在 Perl 中看起来像是数字，则返回真值，否则返回假值。
如果参数是 undef，则返回 undef。前导和结尾的空格会被忽略。
Inf 和 Infinity 被视作数字。
is_array_ref(argument)
如果给定参数可以被视作一个数组引用，则返回真值，即该参数的引用类型为
ARRAY 或者 PostgreSQL::InServer::ARRAY 时返回
真值。否则返回假值。
上一页 上一级 下一页43.2. PL/Perl 中的数据值 起始页 43.4. PL/Perl 中的全局值
