# 5.12. 表分区

5.12. 表分区
版本：
纠错本页面
搜索
目录导航
❮
❯
5.12. 表分区 #5.12.1. 概述5.12.2. 声明式分区5.12.3. 使用继承的分区5.12.4. 分区剪枝5.12.5. 分区和约束排除5.12.6. 声明分区最佳实践
PostgreSQL支持基本的表分区。本小节介绍为何以及怎样把分区实现为数据库设计的一部分。
5.12.1. 概述 #
分区指的是将逻辑上的一个大表分成一些小的物理片。分区有很多益处：
在某些情况下查询性能能够显著提升，特别是当那些访问压力大的行在一个分区或者少数几个分区时。分区有效地替代了索引的上层树级别，使得索引中被大量使用的部分更有可能适合内存。
当查询或更新访问单个分区的很大一部分时，可以通过使用该分区的顺序扫描来提高性能，而不是使用索引，这将需要分散在整个表中的随机访问读取。
如果分区设计中考虑了使用模式，则可以通过添加或删除分区来完成批量加载和删除。使用DROP TABLE删除单个分区，或执行ALTER TABLE DETACH PARTITION操作，比批量操作快得多。这些命令还完全避免了批量DELETE所导致的VACUUM开销。
很少使用的数据可以被迁移到便宜且较慢的存储介质上。
当一个表非常大时，分区所带来的好处是非常值得的。一个表何种情况下会从分区获益取决于应用，一个经验法则是当表的尺寸超过了数据库服务器物理内存时，分区会为表带来好处。
PostgreSQL 提供对以下分区形式的内置支持：
范围分区 #
表被划分为由一个关键列或一组列定义的“范围”，
不同分区之间的值范围没有重叠。例如，可以按日期范围分区，
或按特定业务对象的标识符范围分区。
每个范围的边界被理解为下限是包含的，上限是排除的。
例如，如果一个分区的范围是从1
到10，而下一个分区的范围是从
10到20，那么值
10属于第二个分区，而不是第一个。
列表分区 #
表通过明确列出每个分区中出现的关键值来进行分区。
哈希分区 #
表通过为每个分区指定一个模数和余数来进行分区。
每个分区将保存分区键的哈希值除以指定模数后产生指定余数的行。
如果您的应用程序需要使用上述未列出的其他分区形式，可以改用继承和
UNION ALL视图等替代方法。这些方法提供了灵活性，
但没有内置声明式分区的一些性能优势。
5.12.2. 声明式分区 #
PostgreSQL 允许你声明一个表被划分为分区。被分割的表称为分区表。声明包括如上所述的分区方法，以及用作分区键的列或表达式列表。
分区表本身是一个“虚拟”表，没有自己的存储空间。相反，存储属于分区，这些分区是与分区表关联的普通表。每个分区存储由其分区边界定义的数据子集。插入到分区表中的所有行都将根据分区键列的值路由到适当的一个分区。如果一行不再满足其原始分区的分区边界，则更新该行的分区键将导致该行移动到另一个分区中。
分区本身可能被定义为分区表，从而导致子分区。尽管所有分区必须具有与其分区父级相同的列，但分区可能具有自己的与其他分区不同的索引、约束以及默认值。创建分区表及分区的更多细节请见CREATE TABLE。
不可能将常规表转换为分区表，反之亦然。但是，可以将现有的常规或分区表添加为分区表的分区，或从分区表中删除分区，将其转换为独立表；这可以简化和加快许多维护过程。有关ATTACH PARTITION和DETACH PARTITION子命令的详细信息，请参见ALTER TABLE。
分区也可以是外部表，但是需要非常小心，因为这时用户需要确保外部表的内容符合分区规则。还有一些其他限制。更多信息请参见CREATE FOREIGN TABLE。
5.12.2.1. 示例 #
假定我们正在为一个大型的冰激凌公司构建数据库。该公司每天测量最高温度以及每个区域的冰激凌销售情况。概念上，我们想要一个这样的表：
CREATE TABLE measurement (
city_id         int not null,
logdate         date not null,
peaktemp        int,
unitsales       int
);
我们知道大部分查询只会访问上周的、上月的或者上季度的数据，因为这个表的主要用途是为管理层准备在线报告。为了减少需要被存放的旧数据量，我们决定只保留最近3年的数据。在每个月的开始我们将去除掉最早的那个月的数据。在这种情况下我们可以使用分区技术来帮助我们满足对measurement表的所有不同需求。
要在这种情况下使用声明式分区，可采用下面的步骤：
通过指定PARTITION BY子句把measurement表创建为分区表，该子句包括分区方法（这个例子中是RANGE）以及用作分区键的列列表。
CREATE TABLE measurement (
city_id         int not null,
logdate         date not null,
peaktemp        int,
unitsales       int
) PARTITION BY RANGE (logdate);
创建分区。每个分区的定义必须指定与父分区的分区方法和分区键对应的边界。请注意，指定边界如果使得新分区的值与一个或多个现有分区中的值重叠将导致错误。
分区以普通PostgreSQL表（或者可能是外部表）的方式创建。可以为每个分区单独指定表空间和存储参数。
在我们的示例中，每个分区应该保存一个月的数据，以满足一次删除一个月数据的要求。因此，这些命令可能看起来像：
CREATE TABLE measurement_y2006m02 PARTITION OF measurement
FOR VALUES FROM ('2006-02-01') TO ('2006-03-01');
CREATE TABLE measurement_y2006m03 PARTITION OF measurement
FOR VALUES FROM ('2006-03-01') TO ('2006-04-01');
...
CREATE TABLE measurement_y2007m11 PARTITION OF measurement
FOR VALUES FROM ('2007-11-01') TO ('2007-12-01');
CREATE TABLE measurement_y2007m12 PARTITION OF measurement
FOR VALUES FROM ('2007-12-01') TO ('2008-01-01')
TABLESPACE fasttablespace;
CREATE TABLE measurement_y2008m01 PARTITION OF measurement
FOR VALUES FROM ('2008-01-01') TO ('2008-02-01')
WITH (parallel_workers = 4)
TABLESPACE fasttablespace;
（回想一下，相邻分区可以共享一个边界值，因为范围上限被视为不包含的边界。）
如果你打算实现子分区，再次在创建分区的命令中指定PARTITION BY子句，例如：
CREATE TABLE measurement_y2006m02 PARTITION OF measurement
FOR VALUES FROM ('2006-02-01') TO ('2006-03-01')
PARTITION BY RANGE (peaktemp);
在创建了measurement_y2006m02的分区之后，任何被插入到measurement中且被映射到measurement_y2006m02的数据（或者直接被插入到measurement_y2006m02的数据，它被允许来满足这个分区的分区约束）将被基于peaktemp列进一步重定向到measurement_y2006m02的一个分区。指定的分区键可以与父亲的分区键重叠，不过在指定子分区的边界时要注意它接受的数据集合是分区自身边界允许的数据集合的一个子集，系统不会尝试检查事情情况是否如此。
将没有映射到任何现有分区的数据插入父表将导致错误；必须手动添加适当的分区。
不需要手动创建描述分区边界条件的表约束。此类约束将自动创建。
在分区表的键列以及任何其他索引上创建索引。（键索引不是严格必需的，但在大多数情况下它是有用的。）会自动在每个分区上创建一个匹配的索引，你稍后创建或附加的任何分区也会有这样的索引。在分区表上声明的索引或唯一约束与分区表的方式相同：实际数据位于各个分区表的子索引中。
CREATE INDEX ON measurement (logdate);
确保enable_partition_pruning
配置参数在postgresql.conf中没有被禁用。如果被禁用，查询将不会按照想要的方式被优化。
在上面的例子中，我们会每个月创建一个新分区，因此写一个脚本来自动生成所需的DDL会更好。
5.12.2.2. 分区维护 #
通常在初始定义分区表时建立的分区并非保持静态不变。移除分区持有的旧数据并且为新数据周期性地增加新分区的需求比比皆是。分区的最大好处之一就是可以通过操纵分区结构来近乎瞬时地执行这类让人头痛的任务，而不是物理地去除大量数据。
移除旧数据最简单的选择是删除掉不再需要的分区：
DROP TABLE measurement_y2006m02;
这可以非常快地删除数百万行记录，因为它不需要逐个删除每个记录。不过要注意上面的命令需要在父表上拿到ACCESS EXCLUSIVE锁。
另一种通常更好的选项是把分区从分区表中移除，但是保留它作为一个表的访问权。有两种形式：
ALTER TABLE measurement DETACH PARTITION measurement_y2006m02;
ALTER TABLE measurement DETACH PARTITION measurement_y2006m02 CONCURRENTLY;
这些允许在数据被丢弃之前对其执行进一步的操作。例如，这通常是使用COPY，pg_dump或类似工具备份数据的好时机。这可能也是将数据聚合为较小格式，执行其他数据操作或运行报告的好时机。命令的第一种形式需要父表上的ACCESS EXCLUSIVE锁。在第二种形式中同时添加CONCURRENTLY 限定符，允许detach操作只需要父表上的SHARE UPDATE EXCLUSIVE锁，不过有关限制的详细信息，请参见ALTER TABLE ... DETACH PARTITION。
同样，我们可以添加一个新的分区来处理新数据。我们可以在分区表中创建一个空分区，
就像上面创建原始分区那样：
CREATE TABLE measurement_y2008m02 PARTITION OF measurement
FOR VALUES FROM ('2008-02-01') TO ('2008-03-01')
TABLESPACE fasttablespace;
作为创建新分区的替代方法，有时更方便的是创建一个独立于分区结构的新表，
然后再将其附加为分区。这样可以在新数据出现在分区表之前，先加载、检查和转换数据。
此外，ATTACH PARTITION操作只需要对分区表加一个
SHARE UPDATE EXCLUSIVE锁，而不是
CREATE TABLE ... PARTITION OF所需的
ACCESS EXCLUSIVE锁，因此对分区表的并发操作更友好；
详见ALTER TABLE ... ATTACH PARTITION。
CREATE TABLE ... LIKE选项
可以帮助避免重复繁琐地定义父表；例如：
CREATE TABLE measurement_y2008m02
(LIKE measurement INCLUDING DEFAULTS INCLUDING CONSTRAINTS)
TABLESPACE fasttablespace;
ALTER TABLE measurement_y2008m02 ADD CONSTRAINT y2008m02
CHECK ( logdate >= DATE '2008-02-01' AND logdate < DATE '2008-03-01' );
\copy measurement_y2008m02 from 'measurement_y2008m02'
-- possibly some other data preparation work
ALTER TABLE measurement ATTACH PARTITION measurement_y2008m02
FOR VALUES FROM ('2008-02-01') TO ('2008-03-01' );
注意，当执行ATTACH PARTITION命令时，
表将被扫描以验证分区约束，同时对该分区持有ACCESS EXCLUSIVE锁。
如上所示，建议通过在附加分区之前，在表上创建一个匹配预期分区约束的
CHECK约束来避免此扫描。一旦ATTACH PARTITION完成，
建议删除现在多余的CHECK约束。
如果被附加的表本身是一个分区表，则其每个子分区将递归地被锁定和扫描，
直到遇到合适的CHECK约束或达到叶子分区为止。
类似地，如果分区表有一个DEFAULT分区，建议创建一个
CHECK约束来排除待附加分区的约束。如果不这样做，
将扫描DEFAULT分区以验证它不包含应位于所附加分区中的记录。
此操作将在持有ACCESS EXCLUSIVE锁的DEFAULT分区上执行。
如果DEFAULT分区本身是一个分区表，
则其每个分区将以与上述相同的方式递归检查。
如前所述，可以在分区表上创建索引，使其自动应用于整个层次结构。
这非常方便，因为不仅所有现有分区都会被索引，任何未来的分区也会如此。
但是，在分区表上创建新索引时有一个限制，即不能使用
CONCURRENTLY限定符，这可能导致长时间锁定。
为避免这种情况，可以使用CREATE INDEX ON ONLY分区表，
这会创建一个标记为无效的新索引，防止自动应用于现有分区。
之后，可以使用CONCURRENTLY在每个分区上单独创建索引，
并使用attached到父表的分区索引，
通过ALTER INDEX ... ATTACH PARTITION实现。
一旦所有分区的索引都附加到父索引，父索引将自动标记为有效。示例：
CREATE INDEX measurement_usls_idx ON ONLY measurement (unitsales);
CREATE INDEX CONCURRENTLY measurement_usls_200602_idx
ON measurement_y2006m02 (unitsales);
ALTER INDEX measurement_usls_idx
ATTACH PARTITION measurement_usls_200602_idx;
...
该技术也可用于UNIQUE和
PRIMARY KEY约束；当约束创建时，索引会隐式创建。示例：
ALTER TABLE ONLY measurement ADD UNIQUE (city_id, logdate);
ALTER TABLE measurement_y2006m02 ADD UNIQUE (city_id, logdate);
ALTER INDEX measurement_city_id_logdate_key
ATTACH PARTITION measurement_y2006m02_city_id_logdate_key;
...
5.12.2.3. 限制 #
分区表适用以下限制：
要在分区表上创建唯一或主键约束，分区键中不得包含任何表达式或函数调用，
并且约束的列必须包含所有分区键列。此限制存在的原因是组成约束的各个索引
只能直接在其各自的分区内强制唯一性；因此，分区结构本身必须保证不同分区中
不存在重复值。
同样，排除约束必须包含所有分区键列。此外，约束必须对这些列进行相等比较
（而非例如&&）。此限制同样源于无法强制跨分区的限制。
约束可以包含不属于分区键的其他列，并且可以使用任意运算符比较这些列。
BEFORE ROW触发器在INSERT操作上
不能改变新行的最终分区目标。
不允许在同一分区树中混合临时和永久关系。因此，如果分区表是永久的，
其分区也必须是永久的；同理，如果分区表是临时的，其分区也必须是临时的。
使用临时关系时，分区树的所有成员必须来自同一会话。
各个分区悄悄地使用继承链接到它们的分区表。但是，不可能将继承的所有通用特性用于声明性分区的表或其分区，如下所述。值得注意的是，一个分区除了它所属的分区表之外，不能有任何父级，也不能同时从分区表和常规表继承。这意味着分区表及其分区永远不会与常规表共享继承层次结构。
由于由分区表及其
分区组成的分区层次结构仍然是一个继承层次结构，
tableoid 和所有正常的继承规则
如 第 5.11 节 中所述适用，但有一些例外：
分区不能有在父表中不存在的列。创建分区时
使用 CREATE TABLE 时无法指定列，
也无法在事后使用 ALTER TABLE 向
分区添加列。只有当其列与父表完全匹配时，
才可以使用 ALTER TABLE
... ATTACH PARTITION 将表作为分区添加。
分区表的 CHECK 和 NOT NULL
约束始终由其所有分区继承；不允许创建
这些类型的 NO INHERIT 约束。
如果相同的约束在父表中存在，则无法删除这些类型的约束。
使用 ONLY 仅在分区表上添加或删除约束是被支持的，
只要没有分区存在。一旦存在分区，使用 ONLY
将导致除 UNIQUE 和 PRIMARY KEY
之外的任何约束出现错误。相反，可以在分区
本身上添加约束，并且（如果它们在父表中不存在）可以删除。
由于分区表本身没有任何数据，因此在分区表上使用
TRUNCATE ONLY 的尝试将始终返回错误。
5.12.3. 使用继承的分区 #
虽然内建的声明式分区适合于大部分常见的用例，但还是有一些场景需要更加灵活的方法。分区可以使用表继承来实现，这能够带来一些声明式分区不支持的特性，例如：
对声明式分区来说，分区必须具有和分区表完全相同的列集合，而在表继承中，子表可以有父表中没有出现过的额外列。
表继承允许多继承。
声明式分区仅支持范围、列表以及哈希分区，而表继承允许数据按照用户的选择来划分（不过注意，如果约束排除不能有效地剪枝子表，查询性能可能会很差）。
5.12.3.1. 示例 #
这个示例构建了一个与上面的声明性分区示例等效的分区结构。使用以下步骤：
创建“根”表，所有的“子”表都将从它继承。这个表将不包含数据。不要在这个表上定义任何检查约束，除非想让它们应用到所有的子表上。同样，在这个表上定义索引或者唯一约束也没有意义。对于我们的例子来说，根表是最初定义的measurement表：
CREATE TABLE measurement (
city_id         int not null,
logdate         date not null,
peaktemp        int,
unitsales       int
);
创建数个“子”表，每一个都从根表继承。通常，这些表将不会在从根表继承的列集合之外增加任何列。正如声明性分区那样，这些表就是普通的PostgreSQL表（或者外部表）。
CREATE TABLE measurement_y2006m02 () INHERITS (measurement);
CREATE TABLE measurement_y2006m03 () INHERITS (measurement);
...
CREATE TABLE measurement_y2007m11 () INHERITS (measurement);
CREATE TABLE measurement_y2007m12 () INHERITS (measurement);
CREATE TABLE measurement_y2008m01 () INHERITS (measurement);
为子表增加不重叠的表约束来定义每个分区允许的键值。
典型的例子是：
CHECK ( x = 1 )
CHECK ( county IN ( 'Oxfordshire', 'Buckinghamshire', 'Warwickshire' ))
CHECK ( outletID >= 100 AND outletID < 200 )
确保约束能保证不同子表允许的键值之间没有重叠。设置范围约束的常见错误：
CHECK ( outletID BETWEEN 100 AND 200 )
CHECK ( outletID BETWEEN 200 AND 300 )
这是错误的，因为不清楚键值200属于哪一个子表。
相反，范围应该以如下样式定义：
CREATE TABLE measurement_y2006m02 (
CHECK ( logdate >= DATE '2006-02-01' AND logdate < DATE '2006-03-01' )
) INHERITS (measurement);
CREATE TABLE measurement_y2006m03 (
CHECK ( logdate >= DATE '2006-03-01' AND logdate < DATE '2006-04-01' )
) INHERITS (measurement);
...
CREATE TABLE measurement_y2007m11 (
CHECK ( logdate >= DATE '2007-11-01' AND logdate < DATE '2007-12-01' )
) INHERITS (measurement);
CREATE TABLE measurement_y2007m12 (
CHECK ( logdate >= DATE '2007-12-01' AND logdate < DATE '2008-01-01' )
) INHERITS (measurement);
CREATE TABLE measurement_y2008m01 (
CHECK ( logdate >= DATE '2008-01-01' AND logdate < DATE '2008-02-01' )
) INHERITS (measurement);
对于每个子表，在键列上创建一个索引，以及任何想要的其他索引。
CREATE INDEX measurement_y2006m02_logdate ON measurement_y2006m02 (logdate);
CREATE INDEX measurement_y2006m03_logdate ON measurement_y2006m03 (logdate);
CREATE INDEX measurement_y2007m11_logdate ON measurement_y2007m11 (logdate);
CREATE INDEX measurement_y2007m12_logdate ON measurement_y2007m12 (logdate);
CREATE INDEX measurement_y2008m01_logdate ON measurement_y2008m01 (logdate);
我们希望我们的应用能够使用INSERT INTO measurement ...并且数据将被重定向到合适的分区表。我们可以通过为根表附加一个合适的触发器函数来实现这一点。如果数据将只被增加到最后一个分区，我们可以使用一个非常简单的触发器函数：
CREATE OR REPLACE FUNCTION measurement_insert_trigger()
RETURNS TRIGGER AS $$
BEGIN
INSERT INTO measurement_y2008m01 VALUES (NEW.*);
RETURN NULL;
END;
$$
LANGUAGE plpgsql;
完成函数创建后，我们创建一个调用该触发器函数的触发器：
CREATE TRIGGER insert_measurement_trigger
BEFORE INSERT ON measurement
FOR EACH ROW EXECUTE FUNCTION measurement_insert_trigger();
我们必须在每个月重新定义触发器函数，这样它才会总是插入到当前的子表。而触发器的定义则不需要被更新。
我们也可能希望插入数据时服务器会自动地定位应该加入数据的子表。我们可以通过一个更复杂的触发器函数来实现之，例如：
CREATE OR REPLACE FUNCTION measurement_insert_trigger()
RETURNS TRIGGER AS $$
BEGIN
IF ( NEW.logdate >= DATE '2006-02-01' AND
NEW.logdate < DATE '2006-03-01' ) THEN
INSERT INTO measurement_y2006m02 VALUES (NEW.*);
ELSIF ( NEW.logdate >= DATE '2006-03-01' AND
NEW.logdate < DATE '2006-04-01' ) THEN
INSERT INTO measurement_y2006m03 VALUES (NEW.*);
...
ELSIF ( NEW.logdate >= DATE '2008-01-01' AND
NEW.logdate < DATE '2008-02-01' ) THEN
INSERT INTO measurement_y2008m01 VALUES (NEW.*);
ELSE
RAISE EXCEPTION 'Date out of range.  Fix the measurement_insert_trigger() function!';
END IF;
RETURN NULL;
END;
$$
LANGUAGE plpgsql;
触发器的定义和以前一样。注意每一个IF测试必须准确地匹配它的子表的CHECK约束。
当该函数比单月形式更加复杂时，并不需要频繁地更新它，因为可以在需要的时候提前加入分支。
注意
在实践中，如果大部分插入都会进入最新的子表，最好先检查它。为了简洁，我们为触发器的检查采用了和本例中其他部分一致的顺序。
把插入重定向到一个合适的子表中的另一种不同方法是在根表上设置规则而不是触发器。例如：
CREATE RULE measurement_insert_y2006m02 AS
ON INSERT TO measurement WHERE
( logdate >= DATE '2006-02-01' AND logdate < DATE '2006-03-01' )
DO INSTEAD
INSERT INTO measurement_y2006m02 VALUES (NEW.*);
...
CREATE RULE measurement_insert_y2008m01 AS
ON INSERT TO measurement WHERE
( logdate >= DATE '2008-01-01' AND logdate < DATE '2008-02-01' )
DO INSTEAD
INSERT INTO measurement_y2008m01 VALUES (NEW.*);
规则的开销比触发器大很多，但是这种开销是每个查询只有一次，而不是每行一次，因此这种方法可能对批量插入的情况有优势。不过，在大部分情况下，触发器方法将提供更好的性能。
注意COPY会忽略规则。如果想要使用COPY插入数据，则需要拷贝到正确的子表而不是直接放在根表中。COPY会引发触发器，因此在使用触发器方法时可以正常使用它。
规则方法的另一个缺点是，如果规则集合无法覆盖插入日期，则没有简单的方法能够强制产生错误，数据将会无声无息地进入到根表中。
确认constraint_exclusion配置参数在postgresql.conf中没有被禁用，否则将会不必要地访问子表。
如我们所见，一个复杂的表层次可能需要大量的DDL。在上面的例子中，我们可能为每个月创建一个新的子表，因此编写一个脚本来自动生成所需要的DDL可能会更好。
5.12.3.2. 继承分区的维护 #
要快速移除旧数据，只需要简单地去掉不再需要的子表：
DROP TABLE measurement_y2006m02;
要从继承层次表中去掉子表，但还是把它当做一个表保留：
ALTER TABLE measurement_y2006m02 NO INHERIT measurement;
要增加一个新子表来处理新数据，可以像上面创建的原始子表那样创建一个空的子表：
CREATE TABLE measurement_y2008m02 (
CHECK ( logdate >= DATE '2008-02-01' AND logdate < DATE '2008-03-01' )
) INHERITS (measurement);
或者，用户可能想要创建新子表并且在将它加入到表层次之前填充它。这可以允许数据在被父表上的查询可见之前对数据进行装载、检查以及转换。
CREATE TABLE measurement_y2008m02
(LIKE measurement INCLUDING DEFAULTS INCLUDING CONSTRAINTS);
ALTER TABLE measurement_y2008m02 ADD CONSTRAINT y2008m02
CHECK ( logdate >= DATE '2008-02-01' AND logdate < DATE '2008-03-01' );
\copy measurement_y2008m02 from 'measurement_y2008m02'
-- 可能还有其他数据准备工作
ALTER TABLE measurement_y2008m02 INHERIT measurement;
5.12.3.3. 警告 #
以下警告适用于使用
继承实现的分区：
没有自动方法可以验证所有的
CHECK 约束是否相互排斥。创建生成
子表并创建和/或修改相关对象的代码比手动编写每个对象更安全。
索引和外键约束适用于单个表，而不适用于其继承子表，因此它们有一些
警告 需要注意。
此处显示的方案假设行的键列的值
永远不会改变，或者至少不会改变到需要移动到另一个分区的程度。
尝试执行这样的 UPDATE 将因 CHECK 约束而失败。
如果您需要处理这种情况，可以在子表上放置适当的更新触发器，
但这会使结构的管理变得复杂得多。
手动 VACUUM 和 ANALYZE
命令将自动处理所有继承子表。如果这不希望发生，
可以使用 ONLY 关键字。
像这样的命令：
ANALYZE ONLY measurement;
将仅处理根表。
带有 ON CONFLICT 子句的 INSERT
语句不太可能按预期工作，因为 ON CONFLICT
操作仅在指定目标关系上发生唯一性冲突时执行，而不是在其子关系上。
需要触发器或规则将行路由到所需的
子表，除非应用程序明确知道
分区方案。触发器可能很复杂，且比声明性分区内部执行的元组路由要慢得多。
5.12.4. 分区剪枝 #
分区剪枝是一种提升声明式分区表性能的查询优化技术。例如：
SET enable_partition_pruning = on;                 --- the default
SELECT count(*) FROM measurement WHERE logdate >= DATE '2008-01-01';
如果没有分区剪枝，上面的查询将会扫描measurement表的每一个分区。如果启用了分区剪枝，规划器将会检查每个分区的定义并且检验该分区是否因为不包含符合查询WHERE子句的行而无需扫描。当规划器可以证实这一点时，它会把分区从查询计划中排除（剪枝）。
通过使用EXPLAIN命令和enable_partition_pruning配置参数，可以展示剪枝掉分区的计划与没有剪枝的计划之间的差别。对这种类型的表设置，一种典型的未优化计划是：
SET enable_partition_pruning = off;
EXPLAIN SELECT count(*) FROM measurement WHERE logdate >= DATE '2008-01-01';
QUERY PLAN
-------------------------------------------------------------------​----------------
Aggregate  (cost=188.76..188.77 rows=1 width=8)
->  Append  (cost=0.00..181.05 rows=3085 width=0)
->  Seq Scan on measurement_y2006m02  (cost=0.00..33.12 rows=617 width=0)
Filter: (logdate >= '2008-01-01'::date)
->  Seq Scan on measurement_y2006m03  (cost=0.00..33.12 rows=617 width=0)
Filter: (logdate >= '2008-01-01'::date)
...
->  Seq Scan on measurement_y2007m11  (cost=0.00..33.12 rows=617 width=0)
Filter: (logdate >= '2008-01-01'::date)
->  Seq Scan on measurement_y2007m12  (cost=0.00..33.12 rows=617 width=0)
Filter: (logdate >= '2008-01-01'::date)
->  Seq Scan on measurement_y2008m01  (cost=0.00..33.12 rows=617 width=0)
Filter: (logdate >= '2008-01-01'::date)
某些或者全部的分区可能会使用索引扫描取代全表顺序扫描，但是这里的重点是根本不需要扫描较老的分区来回答这个查询。当我们启用分区剪枝时，我们会得到一个便宜很多的计划，而它能给出相同的答案：
SET enable_partition_pruning = on;
EXPLAIN SELECT count(*) FROM measurement WHERE logdate >= DATE '2008-01-01';
QUERY PLAN
-------------------------------------------------------------------​----------------
Aggregate  (cost=37.75..37.76 rows=1 width=8)
->  Seq Scan on measurement_y2008m01  (cost=0.00..33.12 rows=617 width=0)
Filter: (logdate >= '2008-01-01'::date)
注意，分区剪枝仅由分区键隐式定义的约束所驱动，而不是由索引的存在驱动。因此，没有必要在键列上定义索引。是否需要为一个给定分区创建索引取决于预期的查询扫描该分区时会扫描大部分还是小部分。后一种情况下索引的帮助会比前者大。
分区修剪不仅可以在给定查询的规划期间执行，
还可以在其执行期间进行。这是有用的，因为它可以
允许在子句包含在查询规划时未知的值的表达式时修剪更多分区，
例如，在 PREPARE 语句中定义的参数、
使用从子查询获得的值，或在嵌套循环连接的内部使用参数化值。
执行期间的分区修剪可以在以下任何时间进行：
在查询计划初始化期间。此时可以对在执行初始化阶段已知的参数值进行分区修剪。
在此阶段修剪的分区将不会出现在查询的
EXPLAIN 或 EXPLAIN ANALYZE 中。
可以通过观察
“Subplans Removed” 属性在
EXPLAIN 输出中确定在此阶段移除的分区数量。
查询规划器会为计划中所有分区获取锁。
然而，当执行器使用缓存计划时，仅在执行初始化阶段
修剪后剩余的分区上获取锁，即在 EXPLAIN
输出中显示的分区，而不是 “Subplans Removed” 属性所提到的分区。
在查询计划的实际执行期间。此时也可以进行分区修剪，
以使用仅在实际查询执行期间已知的值来移除分区。
这包括来自子查询的值和来自执行时参数的值，例如
来自参数化嵌套循环连接的值。由于这些参数的值可能在查询执行期间多次变化，
因此每当用于分区修剪的执行参数发生变化时，都会执行分区修剪。
确定在此阶段是否修剪了分区需要仔细检查
loops 属性在
EXPLAIN ANALYZE 输出中的值。
对应于不同分区的子计划可能具有不同的值，
具体取决于在执行期间每个分区被修剪的次数。
如果它们每次都被修剪，某些可能会显示为 (never executed)。
可以使用enable_partition_pruning设置禁用分区剪枝。
5.12.5. 分区和约束排除 #
约束排除是一种与分区剪枝类似的查询优化技术。虽然它主要用于使用传统继承方法实现的分区，但它也可以用于其他目的，包括声明式分区。
约束排除以非常类似于分区剪枝的方式工作，不过它使用每个表的CHECK约束 — 这也是它得名的原因 — 而分区剪枝使用表的分区边界，分区边界仅存在于声明式分区的情况中。另一点不同之处是约束排除仅在规划时应用，在执行时不会尝试移除分区。
由于约束排除使用CHECK约束，这导致它比分区剪枝要慢，但有时候可以被当作一种优点加以利用：因为甚至可以在声明式分区的表上（在分区边界之外）定义约束，约束排除可能可以从查询计划中消去额外的分区。
constraint_exclusion的默认（也是推荐的）设置不是on也不是off，而是一种被称为partition的中间设置，这会导致该技术仅被应用于可能工作在继承分区表上的查询。on设置导致规划器检查所有查询中的CHECK约束，甚至是那些不太可能受益的简单查询。
下列提醒适用于约束排除：
约束排除仅适用于查询规划期间，和分区剪枝不同，在查询执行期间也可以应用。
只有查询的WHERE子句包含常量（或者外部提供的参数）时，约束排除才能有效果。例如，针对一个非不变函数（如CURRENT_TIMESTAMP）的比较不能被优化，因为规划器不知道该函数的值在运行时会落到哪个子表中。
保持分区约束简单化，否则规划器可能无法验证哪些子表可能不需要被访问。如前面的例子所示，对列表分区使用简单的等值条件，对范围分区使用简单的范围测试。一种好的经验规则是分区约束应该仅包含分区列与常量使用B-树可索引操作符的比较，因为只有B-树可索引列才允许出现在分区键中。
约束排除期间会检查父表的所有子表上的所有约束，因此大量的子表很可能明显地增加查询规划时间。因此，传统的基于继承的分区可以很好地处理上百个子表，不要尝试使用上千个子表。
5.12.6. 声明分区最佳实践 #
应该谨慎地选择如何划分表，因为查询规划和执行的性能可能会受到不良设计的负面影响。
最重要的设计决策之一是选择对数据进行分区的列或者列的组合。
通常最佳选择是按最常出现在分区表上执行的查询的 WHERE 子句中的列或列集合进行分区。
与分区键匹配并兼容的 WHERE 子句项可用于裁剪不需要的分区。
但是，你可能会被迫根据 PRIMARY KEY 或 UNIQUE 约束的要求做出其他决策。
在规划分区策略时，删除不需要的数据也是需要考虑的一个因素。
可以相当快地分离整个分区，因此采用这样方式设计分区策略可能是有益的，既把一次删除的所有数据都放在单个分区中。
选择表应该划分的分区的目标数量也是一个重要的决策。
没有足够的分区可能意味着索引仍然太大，数据位置仍然较差，这可能导致缓存命中率很低。
但是，将表划分为太多的分区也会导致问题。 在查询规划和执行期间，过多的分区可能意味着查询计划时间较长，内存消耗也更高，见下面进一步的描述。
在选择如何划分表时，考虑将来可能发生的更改也很重要。
例如，如果您选择为每个客户提供一个分区，而您目前只有少量的大客户，那么，如果几年后您发现自己有大量的小客户，那么就要考虑这种影响。
在这种情况下，最好选择按 HASH 分区并且选择合理数量的分区，而不是尝试按 LIST 进行分区，并希望客户数量的增长不会超出按数据分区的实际范围。
子分区有助于进一步划分那些预计会比其他分区更大的分区。
另一种选择是使用分区键中有多列的范围分区。
这两种情况都很容易导致分区数量过多，因此建议进行限制。
考虑查询计划和执行期间的分区开销也很重要。
查询规划器通常能够很好地处理多达几千个分区的分区层次结构，前提是典型的查询允许查询规划器裁剪除了少量分区之外的所有分区。
规划器执行分区修剪后保留更多分区时，规划时间会变长，内存消耗会更高。
担心拥有大量分区的另一个原因是，服务器的内存消耗可能会随着时间的推移而显著增加，特别是如果许多会话接触大量分区。
这是因为每个分区都需要将其元数据加载到接触它的每个会话的本地内存中。
对于数据仓库类型工作负载，使用比 OLTP 类型工作负载更多的分区数量很有意义。
通常，在数据仓库中，查询计划时间不太值得关注，因为大多数处理时间都花在查询执行期间。
对于这两种类型的工作负载，尽早做出正确的决策非常重要，因为重新分区大量数据可能会非常缓慢。
模拟预期工作负载通常有利于优化分区策略。永远不要只是假设更多的分区比更少的分区更好，反之亦然。
上一页 上一级 下一页5.11. 继承 起始页 5.13. 外部数据
