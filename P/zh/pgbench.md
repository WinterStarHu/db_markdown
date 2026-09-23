# pgbench

pgbench
版本：
纠错本页面
搜索
目录导航
❮
❯
pgbenchpgbench — 在PostgreSQL上运行基准测试大纲pgbench  -i  [option...] [dbname]pgbench [option...] [dbname]描述
pgbench是一种在PostgreSQL上运行基准测试的简单程序。它可能在并发的数据库会话中一遍一遍地运行相同序列的 SQL 命令，并且计算平均事务率（每秒的事务数）。默认情况下，pgbench会测试一种基于 TPC-B 但是要更宽松的场景，其中在每个事务中涉及五个SELECT、UPDATE以及INSERT命令。但是，通过编写自己的事务脚本文件很容易用来测试其他情况。
典型的pgbench输出如下：
transaction type: <builtin: TPC-B (sort of)>
scaling factor: 10
query mode: simple
number of clients: 10
number of threads: 1
maximum number of tries: 1
number of transactions per client: 1000
number of transactions actually processed: 10000/10000
number of failed transactions: 0 (0.000%)
latency average = 11.013 ms
latency stddev = 7.351 ms
initial connection time = 45.758 ms
tps = 896.967014 (without initial connection time)
前七行报告了一些最重要的参数设置。
第六行报告了具有串行化或死锁错误的事务的最大尝试次数（有关更多信息，请参见Failures and Serialization/Deadlock Retries）。
第八行报告了已完成和预期的事务数量（后者仅是客户端数量和每个客户端事务数量的乘积）；除非运行在完成之前失败或某些SQL命令失败，否则它们将相等。（在-T模式下，仅打印实际事务数量。）
接下来的行报告了由于串行化或死锁错误而失败的事务数量（有关更多信息，请参见Failures and Serialization/Deadlock Retries）。
最后一行报告了每秒事务数量。
默认的类 TPC-B 事务测试要求预先设置好特定的表。可以使用-i（初始化）选项调用pgbench来创建并且填充这些表（当你在测试一个自定义脚本时，你不需要这一步，但是需要按你自己的测试需要做一些设置工作）。初始化类似这样：
pgbench -i [ other-options ] dbname
其中dbname是要在其中进行测试的预先创建好的数据库的名称（你可能还需要-h、-p或-U选项来指定如何连接到数据库服务器）。
小心
pgbench -i会创建四个表pgbench_accounts、
pgbench_branches、pgbench_history以及pgbench_tellers，如果同名表已经存在会被先删除。如果你已经有同名表，一定注意要使用另一个数据库！
在默认的情况下“比例因子”为 1，这些表初始包含的行数为：
table                   # of rows
---------------------------------
pgbench_branches        1
pgbench_tellers         10
pgbench_accounts        100000
pgbench_history         0
你可以使用-s（比例因子）选项增加行的数量。-F（填充因子）选项也可以在这里使用。
一旦你完成了必要的设置，你就可以用不包括-i的命令运行基准，也就是：
pgbench [ options ] dbname
在近乎所有的情况中，你将需要一些选项来做一次有用的测试。最重要的选项是-c（客户端数量）、
-t（事务数量）、-T（时间限制）以及-f（指定一个自定义脚本文件）。完整的列表见下文。
选项
下面分成三个部分。数据库初始化期间使用的选项和运行基准时会使用不同的选项，但也有一些选项在两种情况下都使用。
初始化选项
pgbench接受以下命令行初始化参数：
[-d] dbname[--dbname=]dbname #
指定要测试的数据库名称。如果未指定，则使用环境变量PGDATABASE。
如果未设置该变量，则使用连接指定的用户名。
-i--initialize #
要求调用初始化模式。
-I init_steps--init-steps=init_steps #
执行一组选定的正常初始化步骤。
init_steps 指定要执行的
初始化步骤，每个步骤使用一个字符表示。
每个步骤按指定顺序调用。
默认值为 dtgvp。
可用的步骤包括：
d (删除) #
删除任何现有的 pgbench 表。
t (创建表) #
创建标准 pgbench 场景使用的表，
即 pgbench_accounts、
pgbench_branches、
pgbench_history 和
pgbench_tellers。
g 或 G (生成数据，客户端或服务器端) #
生成数据并将其加载到标准表中，
替换任何已存在的数据。
使用 g (客户端数据生成)，
数据在 pgbench 客户端中生成，然后
发送到服务器。这通过 COPY 大量使用客户端/服务器带宽。
pgbench 使用 FREEZE 选项
将数据加载到普通（非分区）表中，以加快后续的
VACUUM。
使用 g 会导致日志记录在为所有
表生成数据时每 100,000 行打印一条消息。
使用 G (服务器端数据生成)，
仅从 pgbench 客户端发送小查询，
然后在服务器中实际生成数据。
此变体不需要显著的带宽，但
服务器将执行更多工作。
使用 G 会导致日志记录在生成数据时不打印任何进度
消息。
默认的初始化行为使用客户端数据
生成（相当于 g）。
v (VACUUM) #
在标准表上调用 VACUUM。
p (创建主键) #
在标准表上创建主键索引。
f (创建外键) #
在标准表之间创建外键约束。
（请注意，此步骤默认情况下不执行。）
-F fillfactor--fillfactor=fillfactor #
创建pgbench_accounts、
pgbench_tellers和
pgbench_branches表，并使用给定的填充因子。
默认值为100。
-n--no-vacuum #
在初始化期间不执行清理操作。
（此选项会抑制v初始化步骤，即使在-I中指定了。）
-q--quiet #
将日志记录切换到安静模式，每5秒只产生一条进度消息。默认日志每100,000行打印一条消息，
这经常每秒输出多行（尤其是在良好的硬件上）。
如果在-I中指定了G，则此设置无效。
-s scale_factor--scale=scale_factor #
将生成的行数乘以比例因子。
例如，-s 100将在pgbench_accounts表中创建10,000,000行。
默认值为1。
当比例为20,000或更大时，用于保存账户标识符的列（aid列）
将切换到使用更大的整数（bigint），
以便足够大以容纳账户标识符的范围。
--foreign-keys #
在标准表之间创建外键约束。
（如果尚未存在，则此选项将在初始化步骤序列中添加f步骤。）
--index-tablespace=index_tablespace #
在指定的表空间中创建索引，而不是默认的表空间。
--partition-method=NAME #
创建一个分区的pgbench_accounts表，使用NAME方法。
预期值为range或hash。
此选项要求--partitions设置为非零值。
如果未指定，默认为range。
--partitions=NUM #
创建一个分区的pgbench_accounts表，其中包含NUM个大小几乎相等的分区，用于规模化的账户数量。
默认值为0，表示不分区。
--tablespace=tablespace #
在指定的表空间中创建表，而不是默认的表空间。
--unlogged-tables #
创建所有表时都将其作为非记录表，而不是永久表。
基准测试选项
pgbench接受以下命令行基准测试参数：
-b scriptname[@weight]--builtin=scriptname[@weight] #
将指定的内置脚本添加到要执行的脚本列表中。
可用的内置脚本包括：tpcb-like、
simple-update和select-only。
接受内置名称的无歧义前缀。
使用特殊名称list，显示内置脚本列表
并立即退出。
可选地，在@后写一个整数权重，以调整选择此脚本与其他脚本的概率。
默认权重为1。
详情请参见下文。
-c clients--client=clients #
模拟的客户端数量，即并发数据库会话的数量。默认值是1。
-C--connect #
为每个事务建立一个新连接，而不是仅在每个客户端会话中执行一次。
这对于测量连接开销很有用。
-D varname=value--define=varname=value #
定义一个变量，供自定义脚本使用（见下文）。
允许使用多个-D选项。
-f filename[@weight]--file=filename[@weight] #
将从filename读取的事务脚本添加到要执行的脚本列表中。
可选地，在@后面写一个整数权重，以调整选择此脚本与其他脚本的概率。
默认权重是1。
（要使用包含@字符的脚本文件名，附加一个权重以消除歧义，例如filen@me@1。）
详细信息请参见下文。
-j threads--jobs=threads #
pgbench中的工作线程数。
在多CPU机器上使用多个线程可能会有所帮助。
客户端尽可能均匀地分布在可用线程中。
默认值是1。
-l--log #
将每个事务的信息写入日志文件。
详细信息请参见下文。
-L limit--latency-limit=limit #
持续时间超过limit毫秒的事务将被单独计数和报告，称为late。
当使用节流时（--rate=...），落后于计划时间超过limit毫秒的事务，
因此无法满足延迟限制，根本不会发送到服务器。它们被计数并单独报告为skipped。
当使用--max-tries选项时，由于串行化异常或死锁而失败的事务，
如果所有尝试的总时间大于limit毫秒，则不会重试。
要仅限制尝试的时间而不是它们的数量，请使用--max-tries=0。
默认情况下，选项--max-tries设置为1，且具有串行化/死锁错误的事务不会重试。
有关重试此类事务的更多信息，请参见Failures and Serialization/Deadlock Retries。
-M querymode--protocol=querymode #
用于向服务器提交查询的协议：
simple: 使用简单查询协议。extended: 使用扩展查询协议。prepared: 使用带有预处理语句的扩展查询协议。
在prepared模式下，pgbench
从第二次查询迭代开始重用解析分析结果，因此pgbench运行速度
比其他模式快。
默认是简单查询协议。 (查看第 54 章获取更多信息。)
-n--no-vacuum #
在运行测试之前不要进行任何清理工作。
如果您正在运行不包括标准表pgbench_accounts、
pgbench_branches、pgbench_history和
pgbench_tellers的自定义测试方案，则此选项是必需的。
-N--skip-some-updates #
运行内置的简单更新脚本。
简写为-b simple-update。
-P sec--progress=sec #
每sec秒显示进度报告。 报告包括自运行开始以来的时间，自上次报告以来的TPS，
事务延迟的平均值、标准差和自上次报告以来失败的事务数量。 在限流（-R）下，
延迟是相对于事务计划开始时间计算的，而不是实际事务开始时间，因此它还包括平均计划滞后时间。
当使用--max-tries启用事务在序列化/死锁错误后的重试时，报告包括重试事务的数量和所有重试的总和。
-r--report-per-command #
在基准测试完成后，报告每个命令的以下统计信息：每条语句的平均延迟（从客户端视角的执行时间）、失败次数以及在该命令中发生序列化或死锁错误后的重试次数。仅当--max-tries选项不等于1时，报告显示重试统计信息。
-R rate--rate=rate #
执行针对指定速率的事务，而不是尽可能快地运行（默认）。速率以每秒事务数表示。
如果目标速率高于最大可能速率，则速率限制不会影响结果。
该速率是通过沿着泊松分布的时间线开始事务来定位的。预期的开始时间表根据客户端首次启动的时间而向前移动，而不是根据上一个事务结束的时间。这种方法意味着当事务超过其原定结束时间时，后续的事务可能会再次赶上。
当节流激活时，运行结束时报告的事务延迟是从计划开始时间计算的，因此它包括每个事务等待前一个事务完成的时间。
等待时间称为计划滞后时间，其平均值和最大值也分别报告。与实际事务开始时间相关的事务延迟，即在数据库中执行事务所花费的时间，
可以通过从报告的延迟中减去计划滞后时间来计算。
如果同时使用--latency-limit和--rate，
一个事务可能会落后太多，以至于在前一个事务结束时已经超过了
延迟限制，因为延迟是从计划开始时间计算的。这样的事务
不会发送到服务器，而是完全跳过并单独计数。
高调度滞后时间表明系统无法以指定速率处理事务，无论选择了多少客户端和线程。
当平均事务执行时间长于每个事务之间的预定间隔时，每个后续事务都会进一步落后，
而调度滞后时间将随着测试运行时间的延长而增加。当发生这种情况时，您将不得不
降低指定的事务速率。
-s scale_factor--scale=scale_factor #
报告pgbench输出中指定的比例因子。
对于内置测试，这是不必要的；正确的比例因子将通过计算pgbench_branches表中的行数来检测。
但是，当仅测试自定义基准时（-f选项），
除非使用此选项，否则比例因子将报告为1。
-S--select-only #
运行内置的select-only脚本。
“select-only”的简写形式是-b select-only。
-t transactions--transactions=transactions #
每个客户端运行的事务数量。默认值为10。
-T seconds--time=seconds #
运行测试的时间，而不是每个客户端的固定事务数量。 -t 和
-T 是互斥的。
-v--vacuum-all #
在运行测试之前，清理所有四个标准表。
如果既不使用-n也不使用-v，pgbench将会对
pgbench_tellers和pgbench_branches
表进行清理，并截断pgbench_history。
--aggregate-interval=seconds #
聚合间隔的长度（以秒为单位）。只能与-l选项一起使用。
使用此选项时，日志包含每个间隔的摘要数据，如下所述。
--exit-on-abort #
当任何客户端因某些错误而中止时立即退出。没有此选项，即使某个客户端中止，
其他客户端仍可按照-t或-T选项指定的方式继续运行，
并且pgbench在这种情况下将打印不完整的结果。
注意，序列化失败或死锁失败不会导致客户端中止，因此它们不受此选项的影响。
更多信息请参见Failures and Serialization/Deadlock Retries。
--failures-detailed #
在每个事务和聚合日志中报告失败，以及在主要和每个脚本报告中按以下类型分组：
序列化失败；死锁失败；
更多信息请参见Failures and Serialization/Deadlock Retries。
--log-prefix=prefix #
设置由--log创建的日志文件的文件名前缀。默认值为pgbench_log。
--max-tries=number_of_tries #
启用对出现序列化/死锁错误的事务进行重试，并设置最大重试次数。此选项可与
--latency-limit选项结合使用，该选项限制所有事务尝试的总时间；
此外，您不能在没有
--latency-limit或--time的情况下使用无限次数
的尝试（--max-tries=0）。
默认值为1，出现序列化/死锁错误的事务不会重试。有关重试此类事务的更多信息，请参见
Failures and Serialization/Deadlock Retries。
--progress-timestamp #
当显示进度（选项-P）时，使用时间戳（Unix纪元）而不是从运行开始以来的秒数。
单位为秒，小数点后精确到毫秒。
这有助于比较各种工具生成的日志。
--random-seed=seed #
设置随机生成器种子。为系统随机数生成器设置种子，然后生成一系列初始生成器状态，每个线程一个。
seed的值可以是:
time（默认值，种子基于当前时间），
rand（使用强随机源，如果没有可用的则失败），或者无符号十进制整数值。
随机生成器可以在pgbench脚本中显式调用（random...函数）或隐式调用（例如选项
--rate用于调度事务）。
当显式设置时，用于种子的值将显示在终端上。
任何允许的seed值也可以通过环境变量
PGBENCH_RANDOM_SEED提供。
为确保提供的种子影响所有可能的用途，将此选项放在第一位或使用环境变量。
明确设置种子允许精确复制pgbench运行，就随机数而言。
由于每个线程管理随机状态，这意味着对于相同的调用，如果每个线程有一个客户端且没有外部或数据依赖，
则pgbench运行完全相同。
从统计角度来看，精确复制运行是一个坏主意，因为它可能隐藏性能变化或不当地提高性能，
例如，通过命中与先前运行相同的页面。
但是，这也可能对调试非常有帮助，例如重新运行导致错误的棘手案例。
明智使用。
--sampling-rate=rate #
采样率，在写入数据到日志时使用，以减少生成的日志量。如果给定此选项，
则只记录指定比例的事务。1.0表示将记录所有事务，0.05表示只记录5%的事务。
处理日志文件时，请记住考虑采样率。例如，在计算TPS值时，您需要相应地乘以数字（例如，使用0.01的采样率，您只会得到实际TPS的1/100）。
--show-script=scriptname #
显示内置脚本scriptname的实际代码在stderr上，并立即退出。
--verbose-errors #
打印所有错误和失败（不重试的错误）的消息，包括超出重试限制的
情况以及序列化/死锁失败超出的程度。（请注意，在这种情况下，
输出可能会显著增加。）
请参阅Failures and Serialization/Deadlock Retries了解更多信息。
常用选项
pgbench 还接受以下常见的命令行参数，用于连接参数和其他常用设置：
--debug #
打印调试输出。
-h hostname--host=hostname #
数据库服务器的主机名
-p port--port=port #
数据库服务器的端口号
-U login--username=login #
用于连接的用户名
-V--version #
打印 pgbench 版本并退出。
-?--help #
显示关于 pgbench 命令行参数的帮助信息，并退出。
Exit Status
成功运行将以状态码0退出。状态码1表示静态问题，例如无效的命令行选项或
应该永远不会发生的内部错误。启动基准测试时发生的早期错误，如初始连接失败，
也会以状态码1退出。运行期间的错误，如数据库错误或脚本中的问题，将导致
以状态码2退出。在后一种情况下，pgbench如果未指定
--exit-on-abort选项，将打印部分结果。
环境PGDATABASEPGHOSTPGPORTPGUSER #
默认连接参数。
此实用程序与大多数其他 PostgreSQL 实用程序一样，使用 libpq 支持的环境变量（请参阅 第 32.15 节）。
环境变量 PG_COLOR 指定是否在诊断消息中使用颜色。可能的值是
always、auto 和
never。
注解在pgbench中实际执行的“事务”是什么？
pgbench执行从指定列表中随机选中的测试脚本。
这些脚本包括带有-b指定的内建脚本和带有-f指定的用户提供的脚本。
每个脚本可以在其后用@指定一个相对权重，这样可以更改该脚本的选择概率。
默认权重是1。权重为0的脚本会被忽略。
默认的内建事务脚本（也会被-b tpcb-like调用）会在每个事务上发出七个从aid、tid、bid和delta中随机选择的命令。
该场景来自于 TPC-B 基准，但并不是真正的 TPC-B，因此得名。
BEGIN;UPDATE pgbench_accounts SET abalance = abalance + :delta WHERE aid = :aid;SELECT abalance FROM pgbench_accounts WHERE aid = :aid;UPDATE pgbench_tellers SET tbalance = tbalance + :delta WHERE tid = :tid;UPDATE pgbench_branches SET bbalance = bbalance + :delta WHERE bid = :bid;INSERT INTO pgbench_history (tid, bid, aid, delta, mtime) VALUES (:tid, :bid, :aid, :delta, CURRENT_TIMESTAMP);END;
如果选择simple-update内建脚本（还有-N），第 4 和 5 步不会被包括在事务中。
这将避免更新这些表的内容，但这会让该测试用例更不像 TPC-B。
如果选择select-only内建脚本（还有-S），只会发出SELECT。
自定义脚本
pgbench支持通过从一个文件中（-f选项）读取事务脚本替换默认的事务脚本（如上文所述）来运行自定义的基准场景。
在这种情况下，一个“事务”就是一个脚本文件的一次执行。
脚本文件包含一个或多个被分号终结的 SQL 命令。空行以及以--开始的行会被忽略。
脚本文件也可以包含“元命令”，它会由pgbench自身解释，详见下文。
注意
在PostgreSQL 9.6 之前，脚本文件中的 SQL 命令被新行终结，因此命令不能跨行。现在需要分号来分隔连续的 SQL 命令（如果 SQL 命令后面跟着一个元命令则不需要分号）。如果需要创建一个能在新旧版本pgbench下工作的脚本文件，要确保把每个 SQL 命令写在一个由分号终结的行中。
假设pgbench脚本不包含不完整的 SQL 事务块。
如果在运行时客户端在未完成最后一个事务块的情况下到达脚本末尾，
该事务块将被中止。
对脚本文件有一种简单的变量替换功能。变量名必须由字母（包括非拉丁字母）、数字以及下划线构成，并且首个字符不能是数字。
如上所述，变量可以用命令行的 -D选项设置，或者按下文所说的使用元命令设置。
除了用-D命令行选项预先设置的任何变量之外，还有一些被自动预先设置的变量，它们被列在表 301中。
一个用-D为这些变量值指定的值会优先于自动的预设值。
一旦被设置，可以在 SQL 命令中写:variablename来插入一个变量的值。
当运行多于一个客户端会话时，每一个会话拥有它自己的变量集合。
pgbench在一个语句中支持使用多达255个变量。
表 301. pgbench 自动变量变量描述 client_id 标识客户端会话的唯一编号（从零开始） default_seed 默认在哈希和伪随机置换函数中使用的种子 random_seed 随机数生成器种子（除非用-D重载） scale 当前缩放因子
脚本文件元命令以反斜线（\）开始，并且通常延伸到行的末尾，不过它们也可以通过写一个反斜线回车继续到额外行。元命令的参数用空白分隔。支持的元命令是：
\gset [prefix]
\aset [prefix]
#
这些命令可以用于结束 SQL 查询，代替终止分号 (;)。
当使用\gset命令时，前面的 SQL 查询预期返回一行，存储变量名的列在列名后面，如果提供的话，则以prefix作为前缀。
使用\aset命令时，所有组合的 SQL 查询（由\;分隔）将其列存储到以列名命名的变量中，如果提供，则以prefix作为前缀。如果查询不返回任何行，则不进行赋值，并且可以测试变量是否存在以检测这一点。如果查询返回多行，则保留最后一个值。
\gset 和 \aset 不能用于管道模式，因为在命令需要它们的时候，查询结果还不可用。
下面的示例将第一个查询中的最终帐户余额放入变量abalance，并且用第三个查询中的整数填充变量p_two和p_three。第二个查询的结果将被丢弃。最后两个组合查询的结果存储在变量four和five中。
UPDATE pgbench_accounts
SET abalance = abalance + :delta
WHERE aid = :aid
RETURNING abalance \gset
-- compound of two queries
SELECT 1 \;
SELECT 2 AS two, 3 AS three \gset p_
SELECT 4 AS four \; SELECT 5 AS five \aset
\if expression\elif expression\else\endif #
这一组命令实现了可嵌套的条件块，类似于psql的\if expression。条件表达式与\set相同，非零值会被解释为真。
\set varname expression
#
设置变量varname为一个从expression计算出的值。该表达式可以包含NULL常量、布尔常量TRUE和FALSE、5432这样的整数常量、3.14159这样的双精度常量、对变量的引用:variablename、
操作符（保持它们通常的SQL优先级和结合性）、函数调用、
SQL CASE一般条件表达式以及括号。
函数和大部分操作符在NULL输入上会返回NULL。
对于条件目的，非零数字值是TRUE，零数字值以及NULL是FALSE。
太大或太小的整数和双精度常量，以及整数算术运算符（+、-、*和/）会引发溢出错误。
在没有为CASE提供最终的ELSE子句时，默认值是NULL。
示例：
\set ntellers 10 * :scale
\set aid (1021 * random(1, 100000 * :scale)) % \
(100000 * :scale) + 1
\set divx CASE WHEN :x <> 0 THEN :y/:x ELSE NULL END
\sleep number [ us | ms | s ]
#
导致脚本执行休眠指定的时间，时间的单位可以是微秒（us）、毫秒（ms）或者秒（s）。如果单位被忽略，则秒是默认值。number要么是一个整数常量，要么是一个引用了具有整数值的变量的:variablename。
例子：
\sleep 10 ms
\setshell varname command [ argument ... ]
#
用给定的argument设置变量varname为 shell 命令command的结果。该命令必须通过它的标准输出返回一个整数值。
command和每个argument要么是一个文本常量，要么是一个引用了一个变量的:variablename。如果你想要使用以冒号开始的argument，在argument的开头写一个额外的冒号。
例子：
\setshell variable_to_be_assigned command literal_argument :variable ::literal_starting_with_colon
\shell command [ argument ... ]
#
与\setshell相同，但是结果被抛弃。
例子：
\shell command literal_argument :variable ::literal_starting_with_colon
\startpipeline\syncpipeline\endpipeline #
这组命令实现了SQL语句的流水线处理。流水线必须以\startpipeline开头，
并以\endpipeline结尾。其间可以有任意数量的\syncpipeline命令，
它发送一个同步消息，但不会结束当前流水线或刷新发送缓冲区。
在流水线模式下，语句会发送到服务器，而不必等待之前语句的结果。详见
第 32.5 节。
流水线模式要求使用扩展查询协议。
内置操作符
表 302中列举的算术、按位、比较以及逻辑操作符都被编译到了pgbench中并且可以被用于\set中出现的表达式中。
运算符以升序排列。 除非另有说明，如果任一输入为双精度，则采用两个数字输入的运算符将产生双精度值，否则产生整数结果。
表 302. pgbench操作符
操作符
描述
示例
boolean OR boolean
→ boolean
逻辑或
5 or 0
→ TRUE
boolean AND boolean
→ boolean
逻辑与
3 and 0
→ FALSE
NOT boolean
→ boolean
逻辑非
not false
→ TRUE
boolean IS [NOT] (NULL|TRUE|FALSE)
→ boolean
布尔值测试
1 is null
→ FALSE
value ISNULL|NOTNULL
→ boolean
空值测试
1 notnull
→ TRUE
number = number
→ boolean
等于
5 = 4
→ FALSE
number <> number
→ boolean
不等于
5 <> 4
→ TRUE
number != number
→ boolean
不等于
5 != 5
→ FALSE
number < number
→ boolean
小于
5 < 4
→ FALSE
number <= number
→ boolean
小于等于
5 <= 4
→ FALSE
number > number
→ boolean
大于
5 > 4
→ TRUE
number >= number
→ boolean
大于等于
5 >= 4
→ TRUE
integer | integer
→ integer
按位或
1 | 2
→ 3
integer # integer
→ integer
按位异或
1 # 3
→ 2
integer & integer
→ integer
按位与
1 & 3
→ 1
~ integer
→ integer
按位非
~ 1
→ -2
integer << integer
→ integer
按位左移
1 << 2
→ 4
integer >> integer
→ integer
按位右移
8 >> 2
→ 2
number + number
→ number
加法
5 + 4
→ 9
number - number
→ number
减法
3 - 2.0
→ 1.0
number * number
→ number
乘法
5 * 4
→ 20
number / number
→ number
除法（如果两个输入都是整数，则将结果截断为零）
5 / 3
→ 1
integer % integer
→ integer
模（余数）
3 % 2
→ 1
- number
→ number
取反
- 2.0
→ -2.0
内置函数
表 303中列出的函数被内置在pgbench中，并且可能被用在出现于\set的表达式中。
表 303. pgbench 函数
函数
描述
示例
abs ( number )
→  与输入类型相同
绝对值
abs(-17)
→ 17
debug ( number )
→  与输入类型相同
将参数打印到stderr，并返回参数。
debug(5432.1)
→ 5432.1
double ( number )
→ double
转换为double。
double(5432)
→ 5432.0
exp ( number )
→ double
指数（e 的给定幂）
exp(1.0)
→ 2.718281828459045
greatest ( number [, ... ] )
→  double 如果任何参数是double， 否则 integer
选择参数中的最大值。
greatest(5, 4, 3, 2)
→ 5
hash ( value [, seed ] )
→ integer
这是 hash_murmur2 的别名。
hash(10, 5432)
→ -5817877081768721676
hash_fnv1a ( value [, seed ] )
→ integer
计算 FNV-1a hash。
hash_fnv1a(10, 5432)
→ -7793829335365542153
hash_murmur2 ( value [, seed ] )
→ integer
计算 MurmurHash2 hash。
hash_murmur2(10, 5432)
→ -5817877081768721676
int ( number )
→ integer
转换为integer。
int(5.4 + 3.8)
→ 9
least ( number [, ... ] )
→  double 如果任何参数是double， 否则 integer
选择参数中的最小值。
least(5, 4, 3, 2.1)
→ 2.1
ln ( number )
→ double
自然对数
ln(2.718281828459045)
→ 1.0
mod ( integer, integer )
→ integer
模（余数）
mod(54, 32)
→ 22
permute ( i, size [, seed ] )
→ integer
i的排列值，在范围[0, size)之间。
这是i（模size）在整数0...size-1的伪随机排列中的新位置，由seed参数化，如下所示。
permute(0, 4)
→ 介于0和3之间的整数
pi ()
→ double
π的近似值
pi()
→ 3.14159265358979323846
pow ( x, y )
→ double
power ( x, y )
→ double
x的y次幂
pow(2.0, 10)
→ 1024.0
random ( lb, ub )
→ integer
计算[lb, ub]中的均匀分布随机整数。
random(1, 10)
→ 介于1和10之间的整数
random_exponential ( lb, ub, parameter )
→ integer
计算[lb, ub]中的指数分布随机整数，如下所示。
random_exponential(1, 10, 3.0)
→ 介于1和10之间的整数
random_gaussian ( lb, ub, parameter )
→ integer
计算[lb, ub]中的高斯分布随机整数，如下所示。
random_gaussian(1, 10, 2.5)
→ 介于1和10之间的整数
random_zipfian ( lb, ub, parameter )
→ integer
计算一个在[lb, ub]范围内的Zipfian分布随机整数，如下所示。
random_zipfian(1, 10, 1.5)
→ 介于1和10之间的整数
sqrt ( number )
→ double
平方根
sqrt(2.0)
→ 1.414213562
random函数使用均匀分布生成值，即所有的值都以相等的概率从指定的范围中抽出。random_exponential、random_gaussian以及random_zipfian函数要求一个额外的 double 参数，它决定分布的精确形状。
对于指数分布，parameter通过在parameter处截断一个快速下降的指数分布来控制分布，然后投影到边界之间的整数上。确切地来说，
f(x) = exp(-parameter * (x - min) / (max - min + 1)) / (1 - exp(-parameter))
然后min和max之间（包括两者）的值i会被以概率f(i) - f(i + 1)抽出。
直观上，parameter越大，接近min的值会被越频繁地访问，并且接近max的值会被越少访问。parameter越接近 0，访问分布会越平坦（更均匀）。该分布的粗近似值是范围中当时被抽取 parameter% 次接近min的最频繁的 1% 值。parameter值必须严格为正。
对于高斯分布，区间被映射到一个在左边-parameter和右边+parameter截断的标准正态分布（经典钟型高斯曲线）。区间中间的值更可能被抽到。准确地说，如果PHI(x)是标准正态分布的累计分布函数，均值mu定义为(max + min) / 2.0，有
f(x) = PHI(2.0 * parameter * (x - mu) / (max - min + 1)) /
(2.0 * PHI(parameter) - 1)
则min和max（包括两者）之间的值i被抽出的概率是：f(i + 0.5) - f(i - 0.5)。直观上，parameter越大，靠近区间终端的值会被越频繁地抽出，并且靠近上下界两端的值会被更少抽出。大约 67% 的值会被从中间1.0 / parameter的地方抽出，即均值周围0.5 / parameter的地方。并且 95% 的值会被从中间2.0 / parameter的地方抽出，即均值周围1.0 / parameter的地方。例如，如果parameter是 4.0，67% 的值会被从该区间的中间四分之一（1.0 / 4.0）抽出（即从3.0 / 8.0到5.0 / 8.0）。并且 95% 的值会从该区间的中间一半（2.0 / 4.0）抽出（第二和第三四分位）。最小允许的parameter值为 2.0。
random_zipfian生成一个有界的Zipfian分布。
parameter定义该分布有多么倾斜。parameter越大，绘制越接近区间开头的值越频繁。
分布是这样的，假设范围从1开始，绘制k与绘制k+1的概率之比为
((k+1)/k)**parameter。
例如，random_zipfian(1, ..., 2.5)生成值1大约(2/1)**2.5 =
5.66次，比2更频繁，它本身被产生(3/2)**2.5 = 2.76次，
比3更频繁，依此类推。
pgbench的实现是基于"Non-Uniform Random Variate Generation", Luc Devroye, p. 550-551, Springer 1986。
由于该算法的限制，parameter值限制范围为[1.001, 1000]。
注意
在设计不一致选择行的基准时，要注意行的选择可能与其他数据相关，例如来自序列的ID或物理行排序，这可能会影响性能度量。
为了避免这个，您可能希望使用permute函数，或其他具有类似效果的额外步骤，来打乱选定的行并移除此类相关性。
哈希函数hash、hash_murmur2以及hash_fnv1a接受一个输入值和一个可选的种子参数。
在没有提供种子的情况下，会使用:default_seed的值，该变量会被随机地初始化，除非用命令行的-D选项重载。
permute接受一个输入值、大小和一个可选种子参数。
它生成范围在[0, size)的整数的伪随机排列，并返回排列值中的输入值的索引。
排列选择由种子参数化，默认为:default_seed，如果没有指定。
与哈希函数不同，permute确保输出值中没有冲突或空洞。
在区间之外的输入值以其大小为模进行解释。
如果大小不是正的，则该函数会抛出一个错误。
permute可用于分散不一致随机函数的分布，如 random_zipfian 或 random_exponential ，以便更经常获取的值不是琐碎相关的。
例如，下面的pgbench脚本模拟了社交媒体和博客平台可能存在的实际工作负载，其中一些账户产生了大量的负载:
\set size 1000000
\set r random_zipfian(1, :size, 1.07)
\set k 1 + permute(:r, :size)
在一些情况下需要几个不同的分布，它们彼此之间不相关，并且可选的种子参数在此时就能派上用场：
\set k1 1 + permute(:r, :size, :default_seed + 123)
\set k2 1 + permute(:r, :size, :default_seed + 321)
类似的行为也可以接近于hash:
\set size 1000000
\set r random_zipfian(1, 100 * :size, 1.07)
\set k 1 + abs(hash(:r)) % :size
然而，由于hash生成冲突，有些值将无法达成，而另一些值将比原始分布中的预期更频繁。
作为一个例子，内建的类 TPC-B 事务的全部定义是：
\set aid random(1, 100000 * :scale)
\set bid random(1, 1 * :scale)
\set tid random(1, 10 * :scale)
\set delta random(-5000, 5000)
BEGIN;
UPDATE pgbench_accounts SET abalance = abalance + :delta WHERE aid = :aid;
SELECT abalance FROM pgbench_accounts WHERE aid = :aid;
UPDATE pgbench_tellers SET tbalance = tbalance + :delta WHERE tid = :tid;
UPDATE pgbench_branches SET bbalance = bbalance + :delta WHERE bid = :bid;
INSERT INTO pgbench_history (tid, bid, aid, delta, mtime) VALUES (:tid, :bid, :aid, :delta, CURRENT_TIMESTAMP);
END;
这个脚本允许该事务的每一次迭代能够引用不同的、被随机选择的行（这个例子也展示了为什么让每一个客户端会话有其自己的变量很重要 — 否则它们不会独立地接触不同的行）。
每个事务的日志
通过-l选项（但是没有--aggregate-interval选项），pgbench把关于每个事务的信息写入到一个日志文件。该日志文件将被命名为prefix.nnn，其中prefix默认为pgbench_log，而nnn是pgbench进程的PID。前缀可以用--log-prefix选项更改。如果-j选项是2或者更高（有多个工作者线程），那么每一个工作者线程将会有它自己的日志文件。第一个工作者的日志文件的命名将和标准的单工作者情况相同。其他工作者的额外日志文件将被命名为prefix.nnn.mmm，其中mmm是每个工作者的一个序列号，这种序列号从1开始编。
每行日志文件描述一个事务。
它包含以下以空格分隔的字段：
client_id
标识运行事务的客户端会话
transaction_no
计算该会话已运行的事务数量
time
事务的经过时间，以微秒为单位
script_no
标识用于事务的脚本文件
(当使用多个脚本指定时有用
使用 -f 或 -b)
time_epoch
事务的完成时间，作为Unix纪元时间戳
time_us
事务完成时间的小数秒部分，以微秒为单位
schedule_lag
事务开始延迟，即事务计划开始时间与实际开始时间之间的差异，以微秒为单位
(仅在指定 --rate 时存在)
retries
在事务期间发生序列化或死锁错误后的重试次数
(仅当 --max-tries 不等于一时存在)
当同时使用--rate和--latency-limit时，
跳过事务的time将被报告为skipped。
如果事务以失败结束，其time将被报告为failed。
如果您使用--failures-detailed选项，失败事务的time将被报告为serialization或deadlock，具体取决于失败类型（有关更多信息，请参见Failures and Serialization/Deadlock Retries）。
这里是在单个客户端运行中生成的一个日志文件的片段：
0 199 2241 0 1175850568 995598
0 200 2465 0 1175850568 998079
0 201 2513 0 1175850569 608
0 202 2038 0 1175850569 2663
另一个例子使用的是--rate=100以及--latency-limit=5（注意额外的
schedule_lag列）：
0 81 4621 0 1412881037 912698 3005
0 82 6173 0 1412881037 914578 4304
0 83 skipped 0 1412881037 914578 5217
0 83 skipped 0 1412881037 914578 5099
0 83 4722 0 1412881037 916203 3108
0 84 4142 0 1412881037 918023 2333
0 85 2465 0 1412881037 919759 740
在这个例子中，事务 82 迟到了，因为它的延迟（6.173 ms）超过了
5 ms 限制。接下来的两个事务被跳过，因为它们在开始之前就已经迟到了。
以下示例显示了一个带有失败和重试的日志文件片段，最大尝试次数设置为10（请注意额外的retries列）：
3 0 47423 0 1499414498 34501 3
3 1 8333 0 1499414498 42848 0
3 2 8358 0 1499414498 51219 0
4 0 72345 0 1499414498 59433 6
1 3 41718 0 1499414498 67879 4
1 4 8416 0 1499414498 76311 0
3 3 33235 0 1499414498 84469 3
0 0 failed 0 1499414498 84905 9
2 0 failed 0 1499414498 86248 9
3 4 8307 0 1499414498 92788 0
如果使用--failures-detailed选项，失败的类型将在time中报告，如下所示：
3 0 47423 0 1499414498 34501 3
3 1 8333 0 1499414498 42848 0
3 2 8358 0 1499414498 51219 0
4 0 72345 0 1499414498 59433 6
1 3 41718 0 1499414498 67879 4
1 4 8416 0 1499414498 76311 0
3 3 33235 0 1499414498 84469 3
0 0 serialization 0 1499414498 84905 9
2 0 serialization 0 1499414498 86248 9
3 4 8307 0 1499414498 92788 0
在能够处理大量事务的硬件上运行一次长时间的测试时，日志文件可能变得非常大。--sampling-rate选项可以用来只记录事务的一个随机采样。
聚合日志记录
使用--aggregate-interval选项，日志文件使用不同的格式。每个日志行描述一个聚合间隔。它包含以下以空格分隔的字段：
interval_start
开始时间间隔，作为Unix纪元时间戳
num_transactions
在该时间段内的事务数量
sum_latency
事务延迟的总和
sum_latency_2
事务延迟的平方和
min_latency
最小事务延迟
max_latency
最大事务延迟
sum_lag
事务开始延迟的总和
(除非指定了--rate)
sum_lag_2
事务开始延迟的平方和
(除非指定了--rate)
min_lag
最小事务开始延迟
(除非指定了--rate)
max_lag
最大事务开始延迟
(除非指定了--rate)
skipped
由于它们将会开始得太晚而被跳过的事务数量
（除非指定了--rate和--latency-limit）
retried
重试事务的数量
(除非--max-tries不等于一)
retries
在序列化或死锁错误后的重试次数
(除非--max-tries不等于一)
serialization_failures
未重试的发生序列化错误的事务数量
（除非指定了--failures-detailed）
deadlock_failures
未重试的死锁错误事务数量
（除非指定了--failures-detailed）
这是使用此选项生成的一些示例输出：
pgbench --aggregate-interval=10 --time=20 --client=10 --log --rate=1000 --latency-limit=10 --failures-detailed --max-tries=10 test
1650260552 5178 26171317 177284491527 1136 44462 2647617 7321113867 0 9866 64 7564 28340 4148 0
1650260562 4808 25573984 220121792172 1171 62083 3037380 9666800914 0 9998 598 7392 26621 4527 0
请注意，虽然普通（未聚合）日志格式显示了每个事务使用的脚本，但聚合格式却没有。
因此，如果您需要按脚本的数据，您需要自行聚合数据。
每个语句的报告
使用-r选项，pgbench为每个语句收集以下统计信息：
latency — 每个语句的经过时间。pgbench报告该语句所有成功运行的平均值。
该语句中的失败次数。更多信息请参见Failures and Serialization/Deadlock Retries。
该语句在序列化或死锁错误后的重试次数。更多信息请参见Failures and Serialization/Deadlock Retries。
报告仅在--max-tries选项不等于1时显示重试统计信息。
所有数值都是为每个客户端执行的每个语句计算的，并在基准测试完成后报告。
对于默认脚本，输出将类似于以下内容:
starting vacuum...end.
transaction type: <builtin: TPC-B (sort of)>
scaling factor: 1
query mode: simple
number of clients: 10
number of threads: 1
maximum number of tries: 1
number of transactions per client: 1000
number of transactions actually processed: 10000/10000
number of failed transactions: 0 (0.000%)
number of transactions above the 50.0 ms latency limit: 1311/10000 (13.110 %)
latency average = 28.488 ms
latency stddev = 21.009 ms
initial connection time = 69.068 ms
tps = 346.224794 (without initial connection time)
statement latencies in milliseconds and failures:
0.012  0  \set aid random(1, 100000 * :scale)
0.002  0  \set bid random(1, 1 * :scale)
0.002  0  \set tid random(1, 10 * :scale)
0.002  0  \set delta random(-5000, 5000)
0.319  0  BEGIN;
0.834  0  UPDATE pgbench_accounts SET abalance = abalance + :delta WHERE aid = :aid;
0.641  0  SELECT abalance FROM pgbench_accounts WHERE aid = :aid;
11.126  0  UPDATE pgbench_tellers SET tbalance = tbalance + :delta WHERE tid = :tid;
12.961  0  UPDATE pgbench_branches SET bbalance = bbalance + :delta WHERE bid = :bid;
0.634  0  INSERT INTO pgbench_history (tid, bid, aid, delta, mtime) VALUES (:tid, :bid, :aid, :delta, CURRENT_TIMESTAMP);
1.957  0  END;
使用可序列化默认事务隔离级别的默认脚本的另一个输出示例
(PGOPTIONS='-c default_transaction_isolation=serializable' pgbench ...):
starting vacuum...end.
transaction type: <builtin: TPC-B (sort of)>
scaling factor: 1
query mode: simple
number of clients: 10
number of threads: 1
maximum number of tries: 10
number of transactions per client: 1000
number of transactions actually processed: 6317/10000
number of failed transactions: 3683 (36.830%)
number of transactions retried: 7667 (76.670%)
total number of retries: 45339
number of transactions above the 50.0 ms latency limit: 106/6317 (1.678 %)
latency average = 17.016 ms
latency stddev = 13.283 ms
initial connection time = 45.017 ms
tps = 186.792667 (without initial connection time)
statement latencies in milliseconds, failures and retries:
0.006     0      0  \set aid random(1, 100000 * :scale)
0.001     0      0  \set bid random(1, 1 * :scale)
0.001     0      0  \set tid random(1, 10 * :scale)
0.001     0      0  \set delta random(-5000, 5000)
0.385     0      0  BEGIN;
0.773     0      1  UPDATE pgbench_accounts SET abalance = abalance + :delta WHERE aid = :aid;
0.624     0      0  SELECT abalance FROM pgbench_accounts WHERE aid = :aid;
1.098   320   3762  UPDATE pgbench_tellers SET tbalance = tbalance + :delta WHERE tid = :tid;
0.582  3363  41576  UPDATE pgbench_branches SET bbalance = bbalance + :delta WHERE bid = :bid;
0.465     0      0  INSERT INTO pgbench_history (tid, bid, aid, delta, mtime) VALUES (:tid, :bid, :aid, :delta, CURRENT_TIMESTAMP);
1.933     0      0  END;
如果指定了多个脚本文件，则将为每个脚本文件单独报告所有统计信息。
注意为每个语句的延迟计算收集额外的时间信息会增加一些负荷。这将拖慢平均执行速度并且降低计算出的 TPS。降低的总量会很显著地依赖于平台和硬件。对比使用和不适用延迟报告时的平均 TPS 值是评估时间开销是否明显的好方法。
失败和序列化/死锁重试
执行pgbench时，主要有三种类型的错误：
主程序错误。这些错误最严重，通常会导致pgbench立即退出，
并显示相应的错误信息。包括：
pgbench启动时的错误（例如无效的选项值）；
初始化模式中的错误（例如创建内置脚本表的查询失败）；
启动线程前的错误（例如无法连接数据库服务器，元命令语法错误，线程创建失败）；
pgbench内部错误（理论上不应发生……）。
线程管理其客户端时的错误（例如客户端无法启动与数据库服务器的连接/
用于连接客户端与数据库服务器的套接字失效）。在这种情况下，该线程的所有客户端
停止，而其他线程继续工作。但如果指定了--exit-on-abort，则所有线程
会立即停止。
直接客户端错误。若发生内部pgbench错误（理论上不应发生……）
或指定了--exit-on-abort，则会导致pgbench立即退出，
并显示相应错误信息。否则，最坏情况下仅导致失败客户端中止，其他客户端继续运行
（但某些客户端错误会被处理且不会导致客户端中止，详见下文）。本节后续假设讨论的错误
仅为直接客户端错误，而非内部pgbench错误。
客户端在发生严重错误时会中止运行；例如，与数据库服务器的连接丢失或脚本结束而未完成最后一个事务。
另外，如果执行SQL或元命令失败，原因不是串行化或死锁错误，客户端会中止。
否则，如果SQL命令因为串行化或死锁错误而失败，客户端不会中止。
在这种情况下，当前事务会回滚，也包括将客户端变量设置为此事务运行之前的状态
（假设一个事务脚本只包含一个事务；详见What Is the "Transaction" Actually Performed in pgbench?了解更多信息）。
发生串行化或死锁错误的事务会在回滚后重试，直到成功完成或达到最大尝试次数
（由--max-tries选项指定）/最大重试时间（由--latency-limit选项指定）
/基准测试结束（由--time选项指定）。如果最后一次尝试运行失败，
此事务将被报告为失败，但客户端不会中止并继续工作。
注意
不指定--max-tries选项的情况下，事务在发生序列化或死锁错误后将不会重试，因为其默认值为1。
使用无限次尝试（--max-tries=0）和--latency-limit选项仅限制尝试的最大时间。
您还可以使用--time选项在无限次尝试的情况下限制基准测试持续时间。
在重复包含多个事务的脚本时要小心：脚本总是完全重试，因此成功的事务可能会执行多次。
使用shell命令重复事务时要小心。与SQL命令的结果不同，shell命令的结果不会回滚，
除非是\setshell命令的变量值。
成功事务的延迟包括事务执行的整个时间，包括回滚和重试。延迟仅针对成功的事务和命令进行测量，而不针对失败的事务或命令。
主报告包含失败交易的数量。如果--max-tries选项不等于1，
主报告还包含与重试相关的统计信息：重试交易的总数和重试次数。每个脚本报告都从主报告继承所有这些字段。
每个语句报告仅在--max-tries选项不等于1时显示重试统计信息。
如果您想在每个事务和聚合日志中按基本类型对失败进行分组，以及在主要和每个脚本报告中使用
--failures-detailed选项。如果您还想通过类型区分所有错误和失败（不重试的错误），
包括超出重试限制以及序列化/死锁失败的超出量，使用--verbose-errors选项。
表访问方法
您可以为pgbench表指定表访问方法。
环境变量PGOPTIONS指定通过命令行传递给PostgreSQL的数据库配置选项
（参见第 19.1.4 节）。
例如，可以通过以下方式为pgbench创建的表指定一个假设的默认表访问方法
wuzza：
PGOPTIONS='-c default_table_access_method=wuzza'
良好的做法
很容易使用pgbench产生完全没有意义的数字。这里有一些指导可以帮你得到有用的结果。
排在第一位的是，永远不要相信任何只运行了几秒的测试。使用-t或-T选项让运行持续至少几分钟，这样可以用平均值去掉噪声。在一些情况下，你可能需要数小时来得到能重现的数字。多运行几次测试是一个好主意，这样可以看看你的数字是不是可以重现。
对于默认的类 TPC-B 测试场景，初始化的比例因子（-s）应该至少和你想要测试的最大客户端数量一样大（-c），否则你将主要在度量更新争夺。在pgbench_branches表中只有-s行，并且每个事务都想更新其中之一，因此-c值超过-s将毫无疑问地导致大量事务被阻塞来等待其他事务。
默认的测试场景也对表被初始化了多久非常敏感：表中死亡行和死亡空间的累积会改变结果。要理解结果，你必须跟踪更新的总数以及何时发生清理。如果开启了自动清理，它可能会在度量的性能上产生不可预估的改变。
pgbench的一个限制是在尝试测试大量客户端会话时，它自身可能成为瓶颈。这可以通过在数据库服务器之外的一台机器上运行pgbench来缓解，不过必须是具有低网络延迟的机器。甚至可以在多个客户端机器上针对同一个数据库服务器并发地运行多个pgbench实例。
安全
如果不可信用户能够访问没有采用安全模式使用方案的数据库，不要在那个数据库中运行pgbench。pgbench使用非限定名称并且不会操纵搜索路径。
上一页 上一级 下一页pg_basebackup 起始页 pg_combinebackup
