# DECLARE

DECLARE
版本：
纠错本页面
搜索
目录导航
❮
❯
DECLAREDECLARE — 定义一个游标大纲
DECLARE name [ BINARY ] [ ASENSITIVE | INSENSITIVE ] [ [ NO ] SCROLL ]
CURSOR [ { WITH | WITHOUT } HOLD ] FOR query
描述
DECLARE 允许用户创建游标，游标可以用来检索
在大型查询中一次少量的行。
游标创建后，可以用FETCH从中取得行。
注意
该页面描述了在 SQL 命令层面上游标的用法。如果您想要在
PL/pgSQL函数中使用游标，其规则是不同的
— 详见第 41.7 节。
参数name
要创建的游标的名称。
这必须与会话中任何其他活动游标名称不同。
BINARY
让游标返回二进制数据而不是返回文本格式数据。
ASENSITIVEINSENSITIVE
游标敏感性决定了在同一事务中，游标声明后对游标底层数据的更改是否可见。
INSENSITIVE 表示它们不可见，ASENSITIVE表示行为是实现相关的。
第三个行为，SENSITIVE，意味着此类更改在游标中可见，但在PostgreSQL中不可用。
在PostgreSQL中，所有游标都不敏感；因此这些关键字没有任何影响，并且只在兼容SQL标准时才被接受。
把 INSENSITIVE 与 FOR UPDATE 或 FOR SHARE 一起指定，是一个错误。
SCROLLNO SCROLLSCROLL指定游标可以用非顺序（例如，反向）
的方式从中检索行。根据查询的执行计划的复杂度，指定
SCROLL可能导致查询执行时间上的性能损失。
NO SCROLL指定游标不能以非顺序的方式从中检索
行。默认是允许在某些情况下滚动，但这和指定
SCROLL不完全相同。详情请见
Notes。
WITH HOLDWITHOUT HOLDWITH HOLD指定该游标在创建它的事务提交
之后还能被继续使用。WITHOUT HOLD指定该游标
不能在创建它的事务之外使用。如果两者都没有指定，则默认为
WITHOUT HOLD。
query
用于提供该游标返回的行的SELECT或者VALUES命令。
关键词ASENSITIVE、BINARY、INSENSITIVE和SCROLL可以以任意顺序出现。
注释
普通游标以文本格式返回数据，这和SELECT产生的数据一样。
BINARY选项指定游标应该以二进制格式返回数据。这减少了服务器
和客户端的转换负担，但程序员需要付出更多工作来处理与平台相关的二进制
数据格式。例如，如果一个查询从一个整数列中返回一个值一，用一个默认游标
将得到一个字符串1，而使用一个二进制游标将得到该值的四字节
内部表示（big-endian 大端字节顺序）。
使用二进制游标时应该小心。很多应用（包括
psql）还没有准备好处理二进制游标，
它们仍然期待数据以文本格式到来。
注意
当客户端应用使用“扩展查询”协议发出一个
FETCH命令，绑定协议消息会指定使用文本还是
二进制格式检索数据。这种选择会覆盖定义游标时指定的方式。因此
在使用扩展查询协议时，这样一个二进制游标的概念实际是被废弃的
— 任何游标都可以被视作文本或者二进制。
除非指定了WITH HOLD，这个命令创建的游标只能在当前事务中使用。
因此，没有WITH HOLD的DECLARE在事务块外是没有用的：游标只会生存到该语句结束。
因此如果这种命令在事务块之外被使用，PostgreSQL会报告一个错误。
定义事务块需要使用BEGIN和COMMIT（或者ROLLBACK）。
如果指定了WITH HOLD并且创建游标的事务
成功提交，在同一个会话中的后续事务中还能够继续访问该游标（
但是如果创建事务被中止，游标会被移除）。一个用
WITH HOLD创建的游标可以用一个显式的
CLOSE命令关闭，或者会话结束时它
也会被关闭。在当前的实现中，由一个被保持游标表示的行会被复
制到一个临时文件或者内存区域中，这样它们才会在后续事务中保
持可用。
当查询包括FOR UPDATE或FOR SHARE时，
不能指定WITH HOLD。
在定义一个将被反向取元组的游标时，应该指定SCROLL
选项。这是 SQL 标准所要求的。不过，为了和早期版本兼容，
如果游标的查询计划足够简单到支持它不需要额外的开销，
PostgreSQL会允许在没有
SCROLL的情况下反向取元组。不过，建议应用开发者
不要依赖于从没有用SCROLL创建的游标中反向取
元组。如果指定了NO SCROLL，那么任何情况下都不
允许反向取元组。
当查询包括FOR UPDATE或FOR SHARE时，
也不允许反向取元组。因此在这种情况下不能指定
SCROLL。
小心
如果可滚动游标调用了任何不稳定的函数（见第 36.7 节），它们可能给出预期之外的结果。
当重新取得一个之前取得过的行时，那些函数会被重新执行，这可能导致得到与第一次不同的结果。
它最好指定NO SCROLL对频繁调用的易变函数。
如果那样不可行，一个变通方法是，声明游标为SCROLL WITH HOLD并且在从其中读任何行之前提交事务。
这将强制该游标的整个输出被物化在临时存储中，这样针对每一行只会执行一次不稳定函数。
如果游标的查询包括FOR UPDATE或者FOR SHARE，那么被返回的行会在它们第一次被取得时被锁定，这和带有这些选项的常规SELECT命令一样。
此外，被返回的行将是最新的版本。
小心
如果游标要和UPDATE ... WHERE CURRENT OF或者
DELETE ... WHERE CURRENT OF一起使用，通常推荐
使用FOR UPDATE。使用FOR UPDATE可以
阻止其他会话在行被取得和被更新之间修改行。如果没有
FOR UPDATE，当行在游标创建后被更改后，一个后续的
WHERE CURRENT OF命令将不会产生效果。
另一个使用FOR UPDATE的原因是，如果没有它，当游标查询不符合
SQL 标准的“简单可更新”规则时，后续的
WHERE CURRENT OF可能会失败（特别地，该游标必须只引用一个
表并且没有使用分组或者ORDER BY）。不是简单可更新的游标可能
成功也可能不成功，这取决于计划选择的细节。因此在最坏的情况下，应用可能会
在测试时成功但是在生产中失败。如果指定了FOR UPDATE，
则保证游标是可更新的。
不把FOR UPDATE和WHERE CURRENT OF一起用的主要原因是，需要游标可滚动，或者与当前的更新隔离（也就是说，继续显示旧的数据）。
如果这是你的需求，应密切关注上述警示。
SQL 标准只对嵌入式SQL中的游标做出了规定。
PostgreSQL服务器没有为游标实现
OPEN语句。当游标被声明时就被认为已经
被打开。不过，ECPG（
PostgreSQL的嵌入式 SQL 预处理器）
支持标准 SQL 游标习惯，包括那些DECLARE
和OPEN语句。
支持打开游标的服务器数据结构被称为
门户。门户名称在客户端协议中是可见的：
如果客户端知道门户名称，它可以直接从一个打开的门户中获取行。
当使用DECLARE创建游标时，门户名称与游标名称相同。
你可以通过查询pg_cursors
系统视图看到所有可用的游标。
示例
声明一个游标：
DECLARE liahona CURSOR FOR SELECT * FROM films;
更多游标的例子请见FETCH。
兼容性
SQL 标准只允许在嵌入式SQL和模块中使用游标。
PostgreSQL允许以交互的方式使用游标。
根据SQL标准，由UPDATE ... WHERE CURRENT OF 和 DELETE ... WHERE CURRENT OF 语句对不敏感游标做出的改变，在同一游标中是可见的。
PostgreSQL 对待这些语句就像所有其他数据更改语句，因为它们在不敏感游标中是不可见的。
二进制游标是PostgreSQL
的一种扩展。
另请参阅CLOSE, FETCH, MOVE上一页 上一级 下一页DEALLOCATE 起始页 DELETE
