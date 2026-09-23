# VALUES

VALUES
版本：
纠错本页面
搜索
目录导航
❮
❯
VALUESVALUES — 计算一组行大纲
VALUES ( expression [, ...] ) [, ...]
[ ORDER BY sort_expression [ ASC | DESC | USING operator ] [, ...] ]
[ LIMIT { count | ALL } ]
[ OFFSET start [ ROW | ROWS ] ]
[ FETCH { FIRST | NEXT } [ count ] { ROW | ROWS } ONLY ]
描述
VALUES 计算由值表达式指定的一个行值或者
一组行值。更常见的是把它用来生成一个大型命令内的“常量表”，
但是它也可以被独自使用。
当多于一行被指定时，所有行都必须具有相同数量的元素。结果表的列数据类型
由出现在该列的表达式的显式或者推导类型组合决定，决定的规则与
UNION相同（见第 10.5 节）。
在大型的命令中，在语法上允许VALUES出现在
SELECT出现的任何地方。因为语法把它当做一个
SELECT，可以为一个VALUES
命令使用ORDER BY、
LIMIT（或者等效的FETCH FIRST）
以及OFFSET子句。
参数expression
要在结果表（行集合）中指定位置计算并插入的一个常量或表达式。
在一个出现于INSERT顶层的
VALUES列表中，
expression可以
被DEFAULT替代以表示应该插入目标列的默认值。
当VALUES出现在其他环境中时，不能使用
DEFAULT。
sort_expression
一个指示如何排序结果行的表达式或整型常量。这个表达式
可以用column1、column2等来
引用该VALUES结果的列。有关详细信息，请参阅
SELECT文档中的ORDER BY Clause。
operator
一个排序操作符。详见
SELECT文档中的ORDER BY Clause。
count
要返回的最大行数。详见
SELECT文档中的LIMIT Clause。
start
开始返回行之前要跳过的行数。详见
SELECT文档中的LIMIT Clause。
注释
应该避免具有大量行的VALUES列表，否则可能会
碰到内存不足失败或性能不佳。出现在INSERT
中的VALUES是一种特殊情况（因为想要的列类型
可以从INSERT的目标表得知，并且不需要通过扫描
该VALUES列表来推导），因此它可以处理比其他
环境中更大的列表。
示例
一个纯粹的VALUES命令：
VALUES (1, 'one'), (2, 'two'), (3, 'three');
这将返回一个具有两列、三行的表。它实际等效于：
SELECT 1 AS column1, 'one' AS column2
UNION ALL
SELECT 2, 'two'
UNION ALL
SELECT 3, 'three';
更常用地，VALUES可以被用在一个大型 SQL 命令中。
在INSERT中最常用：
INSERT INTO films (code, title, did, date_prod, kind)
VALUES ('T_601', 'Yojimbo', 106, '1961-06-16', 'Drama');
在INSERT的环境中，一个VALUES列表
的项可以是DEFAULT来指示应该使用该列的默认值而不是
指定一个值：
INSERT INTO films VALUES
('UA502', 'Bananas', 105, DEFAULT, 'Comedy', '82 minutes'),
('T_601', 'Yojimbo', 106, DEFAULT, 'Drama', DEFAULT);
VALUES可以用在子SELECT的地方，例如在FROM子句中：
SELECT f.*
FROM films f, (VALUES('MGM', 'Horror'), ('UA', 'Sci-Fi')) AS t (studio, kind)
WHERE f.studio = t.studio AND f.kind = t.kind;
UPDATE employees SET salary = salary * v.increase
FROM (VALUES(1, 200000, 1.2), (2, 400000, 1.4)) AS v (depno, target, increase)
WHERE employees.depno = v.depno AND employees.sales >= v.target;
注意，在FROM子句中使用VALUES时，需要一个AS子句，就像在SELECT中一样。并不需要AS子句为所有列指定名称，但最好这样做。
（在PostgreSQL中，VALUES的默认列名是column1，column2等，但在其他数据库系统中这些名称可能不同。）
当在INSERT中使用VALUES时，值都会
被自动地强制为相应目标列的数据类型。当在其他环境中使用时，有必要指定
正确的数据类型。如果项都是带引号的字符串常量，强制第一个就足以为所有
项假设数据类型：
SELECT * FROM machines
WHERE ip_address IN (VALUES('192.168.0.1'::inet), ('192.168.0.10'), ('192.168.1.43'));
提示
对于简单的IN测试，最好使用IN的
list-of-scalars形式
而不是写一个上面那样的VALUES查询。标量列表方法的
书写更少并且常常更加高效。
兼容性VALUES符合 SQL 标准。
LIMIT和OFFSET是
PostgreSQL扩展，另见
SELECT。
另请参阅INSERT, SELECT上一页 上一级 下一页VACUUM 起始页 PostgreSQL 客户端应用程序
