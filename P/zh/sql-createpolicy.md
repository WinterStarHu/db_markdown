# CREATE POLICY

CREATE POLICY
版本：
纠错本页面
搜索
目录导航
❮
❯
CREATE POLICYCREATE POLICY — 为表定义一条新的行级安全策略大纲
CREATE POLICY name ON table_name
[ AS { PERMISSIVE | RESTRICTIVE } ]
[ FOR { ALL | SELECT | INSERT | UPDATE | DELETE } ]
[ TO { role_name | PUBLIC | CURRENT_ROLE | CURRENT_USER | SESSION_USER } [, ...] ]
[ USING ( using_expression ) ]
[ WITH CHECK ( check_expression ) ]
描述
CREATE POLICY 命令为表定义一条行级
安全策略。注意，为了应用已创建的策略，必须在表上启用行级安全
（使用 ALTER TABLE ... ENABLE ROW LEVEL
SECURITY）。
策略授予选择、插入、更新或删除与相关策略表达式匹配的行的权限。
现有的表行会根据 USING 中指定的表达式进行检查，
而通过 INSERT 或 UPDATE 创建的新行
会根据 WITH CHECK 中指定的表达式进行检查。
当 USING 表达式对给定行返回 true 时，该行对用户可见，
如果返回 false 或 null，则该行不可见。
通常，当行不可见时不会发生错误，但请参见
表 300 以了解例外情况。
当 WITH CHECK 表达式对某行返回 true 时，
该行将被插入或更新，而如果返回 false 或 null，则会发生错误。
对于 INSERT、UPDATE 和
MERGE 语句，
WITH CHECK 表达式在
BEFORE 触发器触发后执行，
并在进行任何实际数据修改之前执行。因此，BEFORE ROW 触发器可能
修改要插入的数据，从而影响安全策略检查的结果。
WITH CHECK 表达式在其他约束之前执行。
策略名称是针对每个表的。因此，一个策略名称可以用于多个不同的表，
并且对于每个表都有适合该表的定义。
策略可以被应用于特定的命令或者特定的角色。除非特别指定，新创建的策略
的默认行为是适用于所有命令和角色。多个策略可以应用于单个命令，更多细节请见下文。表 300总结了不同类型的策略如何应用于特定的命令。
对同时具有USING和WITH CHECK
表达式（ALL和UPDATE）的策略，
如果没有定义WITH CHECK表达式，那么
USING表达式将被用于决定哪些行可见（普通
USING情况）以及允许哪些新行被增加（
WITH CHECK情况）。
如果为一个表启用了行级安全性但是没有适用的策略存在，将假定为一种
“默认拒绝”策略，这样任何行都不可见也不可更新。
参数name
要创建的策略的名称。这必须和该表上已有的任何其他策略名称相区分。
table_name
该策略适用的表的名称（可以被模式限定）。
PERMISSIVE
指定策略被创建为宽松性策略。适用于一个给定查询的所有宽松性策略将被使用布尔“OR”操作符组合在一起。通过创建宽松性策略，管理员可以在能被访问的记录集合中进行增加。策略默认是宽松性的。
RESTRICTIVE
指定策略被创建为限制性策略。适用于一个给定查询的所有限制性策略将被使用布尔“AND”操作符组合在一起。通过创建限制性策略，管理员可以减少能被访问的记录集合，因为每一条记录都必须通过所有的限制性策略。
注意在限制性策略真正能发挥作用减少访问之前，需要至少一条宽松性策略来授予对记录的访问。如果只有限制性策略存在，则没有记录能被访问。当宽松性和限制性策略混合存在时，只有当一个记录能通过至少一条宽松性策略以及所有的限制性策略时，该记录才是可访问的。
command
该策略适用的命令。合法的选项是
ALL、SELECT、
INSERT、UPDATE
以及DELETE。
ALL为默认。有关这些策略如何被应用的
细节见下文。
role_name
该策略适用的角色。默认是PUBLIC，它将把策略应用
到所有的角色。
using_expression
任何 SQL 条件表达式（返回
boolean）。条件表达式不能包含
任何聚合或窗口函数。如果启用了行级安全性，
此表达式将被添加到引用该表的查询中。
表达式返回 true 的行将是可见的。
任何表达式返回 false 或 null 的行将对用户不可见
（在 SELECT 中），并且在
UPDATE 或 DELETE 中
将无法进行修改。通常，这些行会被静默抑制；
不会报告错误（但请参见
表 300 以了解例外情况）。
check_expression
任何 SQL 条件表达式（返回
boolean）。该条件表达式不能包含任何聚合或窗口
函数。如果行级安全性被启用，这个表达式将被用在该表上的
INSERT以及
UPDATE查询中。只有让该表达式计算为真
的行才被允许。如果任何被插入的记录或者更新后的记录导致该表达式计算为假或者空，则会抛出一个错误。注意
check_expression
是根据行的新内容而不是原始内容计算的。
每种命令的策略ALL #
为一条策略使用ALL表示它将适用于所有命令，
不管命令的类型如何。如果存在一条ALL策略
以及更多特定的策略，则ALL策略和那些策略
会被应用。此外，
ALL策略将同时适用于一个查询的选择端和修
改端，如果只定义了一个USING表达式则将
该USING表达式用于两种情况。
例如，如果发出 UPDATE，则
ALL 策略将适用于 UPDATE
能够选择的要更新的行（应用 USING 表达式），
以及结果更新的行，以检查它们是否被允许
添加到表中（应用 WITH CHECK 表达式，如果定义了，
否则应用 USING 表达式）。
如果 INSERT 或
UPDATE 命令尝试向表中添加不通过
ALL 策略的 WITH CHECK 表达式
（或其 USING 表达式，如果没有
WITH CHECK 表达式），则整个命令将被中止。
SELECT #
对于策略使用 SELECT 意味着它将适用于
SELECT 查询以及在定义策略的关系上
需要 SELECT 权限的情况。结果是，
只有那些通过 SELECT 策略的记录
在 SELECT 查询中会被返回，并且需要
SELECT 权限的查询，如
UPDATE、DELETE 和
MERGE，也只会看到那些
被 SELECT 策略允许的记录。
SELECT 策略不能有 WITH
CHECK 表达式，因为它仅适用于从关系中
检索记录的情况，除非如下所述。
如果数据修改查询有 RETURNING 子句，
则在关系上需要 SELECT 权限，
并且来自关系的任何新插入或更新的行必须满足
关系的 SELECT 策略，以便在
RETURNING 子句中可用。
如果新插入或更新的行不满足关系的
SELECT 策略，将抛出错误（要返回的
插入或更新的行 永远 不会被静默忽略）。
如果 INSERT 有 ON CONFLICT DO
UPDATE 子句，或有带仲裁索引或约束
规范的 ON CONFLICT DO
NOTHING 子句，则在关系上需要
SELECT 权限，并且提议插入的行
会使用关系的 SELECT 策略进行检查。
如果提议插入的行不满足关系的 SELECT
策略，将抛出错误（INSERT 永远
不会被静默忽略）。此外，如果采取 UPDATE
路径，则要更新的行和新的更新行会根据
关系的 SELECT 策略进行检查，
如果不满足，则会抛出错误（辅助的
UPDATE 永远 不会被静默忽略）。
MERGE 命令需要在源和目标关系上
具有 SELECT 权限，因此在连接之前
应用每个关系的 SELECT 策略，
MERGE 操作将只看到那些被这些策略允许的记录。
此外，如果执行 UPDATE 操作，则目标关系的
SELECT 策略会应用于更新的行，
与独立的 UPDATE 相同，除了如果不满足
则会抛出错误。
INSERT #
使用 INSERT 来定义一个策略意味着它将适用于
包含 INSERT 动作和 MERGE 命令的
INSERT 命令。插入的行如果不符合该策略，
将导致策略违规错误，并且整个 INSERT 命令将被中止。
INSERT 策略不能有 USING 表达式，
因为它仅适用于向关系添加记录的情况。
请注意，带有 ON CONFLICT DO NOTHING/UPDATE 子句的
INSERT 将检查所有提议插入的行的
INSERT 策略的 WITH CHECK 表达式，
无论它们是否最终被插入。
UPDATE #
对于策略使用 UPDATE 意味着它将适用于
UPDATE、SELECT FOR UPDATE，
和 SELECT FOR SHARE 命令，以及
INSERT 命令的辅助 ON CONFLICT DO UPDATE
子句和包含 UPDATE 操作的 MERGE
命令。由于 UPDATE 命令涉及提取现有记录并用新
修改的记录替换它，UPDATE
策略接受 USING 表达式和
WITH CHECK 表达式。
USING 表达式确定 UPDATE
命令将看到哪些记录进行操作，
而 WITH CHECK 表达式定义哪些
修改后的行被允许存储回关系中。
任何更新后的值无法通过 WITH CHECK 表达式的行
将会导致错误，并且整个命令将被中止。如果只指定了一个
USING 子句，那么该子句将被用于
USING 和 WITH CHECK 两种情况。
典型地，UPDATE命令也需要从待更新关系中的列读数据（例如在WHERE子句、RETURNING子句或在SET子句右侧的表达式中）。这种情况下，正被更新的关系上也需要SELECT权限，并且除了UPDATE策略外，也要应用适当的SELECT或ALL策略。这样，除由UPDATE或ALL策略授权更新行之外，通过SELECT或ALL策略也必须能访问正被更新的行。
当 INSERT 命令有辅助
ON CONFLICT DO UPDATE 子句时，如果
采取 UPDATE 路径，则要更新的行
首先会根据任何 UPDATE 策略的
USING 表达式进行检查，然后新的更新行
会根据 WITH CHECK 表达式进行检查。
但是请注意，与独立的 UPDATE 命令不同，
如果现有行不通过 USING 表达式，
将抛出错误（UPDATE 路径 永远
不会被静默避免）。同样适用于 UPDATE 操作
的 MERGE 命令。
DELETE #
对于策略使用 DELETE 意味着它将适用于
DELETE 命令和包含 DELETE
操作的 MERGE 命令。
对于 DELETE 命令，只有通过此策略的行
才会被 DELETE 命令看到。
可能存在通过 SELECT 策略可见的行
但不允许删除，如果它们不通过
DELETE 策略的 USING 表达式。
但是请注意，MERGE 命令中的
DELETE 操作将看到通过
SELECT 策略可见的行，如果
DELETE 策略对这样的行不通过，将抛出错误。
大多数情况下，DELETE命令也需要从其所删除的关系中的列读取数据（例如在WHERE子句或RETURNING子句中）。这种情况下，在该关系上也需要SELECT权限，并且除了DELETE策略外，也要应用适当的SELECT或ALL策略。这样，除由DELETE或ALL策略授权删除行之外，通过SELECT或ALL策略，用户也必须能访问正被删除的行。
DELETE策略不能具有WITH
CHECK表达式，因为它只适用于正在从关系中删除记录的情况，
所以没有新行需要检查。
表 300 总结了不同类型的策略
如何适用于特定命令。在表中，
“check” 意味着检查策略表达式，如果返回 false 或 null
则抛出错误，而 “filter” 意味着如果策略表达式返回
false 或 null，则该行会被静默忽略。
表 300. 按命令类型应用的策略命令SELECT/ALL策略INSERT/ALL策略UPDATE/ALL策略DELETE/ALL策略USING expressionWITH CHECK expressionUSING expressionWITH CHECK expressionUSING expressionSELECT / COPY ... TO过滤现有行————SELECT FOR UPDATE/SHARE过滤现有行—过滤现有行——INSERT
检查新行 [a]
检查新行———UPDATE
过滤现有行 [a] &
检查新行 [a]
—过滤现有行检查新行—DELETE
过滤现有行 [a]
———过滤现有行INSERT ... ON CONFLICT
检查新行 [b][c]
检查新行 [c]
———ON CONFLICT DO UPDATE
检查现有行 & 新行 [d]
—检查现有行
检查新行 [d]
—MERGE过滤源行 & 目标行————MERGE ... THEN INSERT
检查新行 [a]
检查新行———MERGE ... THEN UPDATE检查新行—检查现有行检查新行—MERGE ... THEN DELETE————检查现有行[a]
如果需要对现有行或新行进行读取访问（例如，引用关系列的
WHERE 或 RETURNING 子句）。
[b]
如果指定了仲裁索引或约束。
[c]
提议插入的行无论是否发生冲突都要进行检查。
[d]
辅助 UPDATE 命令的新行，可能与原始
INSERT 命令的新行不同。
多重策略的应用
当多种不同命令类型的策略应用于相同命令（例如SELECT和UPDATE策略应用于UPDATE命令）时，用户就必须同时具有这两种类型的权限（例如从关系中选取行以及更新的权限）。这样一种策略类型的表达式就与另一种策略类型的表达式通过使用AND操作符组合在一起。
当相同命令类型的多种策略应用于同一命令时，则必须至少有一个PERMISSIVE策略授权对该关系的访问，所有的RESTRICTIVE策略必须通过。这样，所有的PERMISSIVE策略表达式都用OR来组合，所有的RESTRICTIVE策略表达式都用AND来组合，而结果用AND来组合。如果没有PERMISSIVE策略，则拒绝访问。
要注意的是，出于组合多种策略的目的，将ALL策略视为与所应用的任何其他类型的策略具有相同的类型。
例如，在UPDATE命令中，SELECT和UPDATE两种权限都需要，如果每种类型都有多个适用的策略，则将之以下面的方式组合：
expression from RESTRICTIVE SELECT/ALL policy 1
AND
expression from RESTRICTIVE SELECT/ALL policy 2
AND
...
AND
(
expression from PERMISSIVE SELECT/ALL policy 1
OR
expression from PERMISSIVE SELECT/ALL policy 2
OR
...
)
AND
expression from RESTRICTIVE UPDATE/ALL policy 1
AND
expression from RESTRICTIVE UPDATE/ALL policy 2
AND
...
AND
(
expression from PERMISSIVE UPDATE/ALL policy 1
OR
expression from PERMISSIVE UPDATE/ALL policy 2
OR
...
)
注释
要为一个表创建或修改策略，你必须是该表的拥有者。
虽然策略将被应用于针对数据库中表的显式查询上，但当系统正在执行
内部引用完整性检查或验证约束时不会应用它们。这意味着有间接的
方法来决定一个给定的值是否存在。一个例子是向一个作为主键或拥有
唯一约束的列中尝试插入重复值。如果插入失败则用户可以推导出该
值已经存在（这个例子假设用户被策略允许插入他们看不到的记录）。
另一个例子是一个用户被允许向一个引用了其他表的表中插入，然而另
一个表是隐藏表。通过用户向引用表中插入值可以判断存在性，
成功表示该值存在于被引用表中。为了解决这些问题，应该仔细地制作
策略以完全阻止用户插入、删除或更新那些可能指示他们不能看到的
值的记录，或者使用生成的值（例如代理键）来代替具有外部含义的键。
通常，系统将在应用用户查询中出现的条件之前先强制由安全性策略施
加的过滤条件，这是为了防止无意中把受保护的数据暴露给可能不可信
的用户定义函数。不过，被系统（或者系统管理员）标记为
LEAKPROOF的函数和操作符可以在策略表达式之前
被计算，因为它们已经被假定为可信。
由于策略表达式直接添加到用户的查询中，它们将以运行整体查询的用户的权限运行。
因此，使用给定策略的用户必须能够访问表达式中引用的任何表或函数，否则当尝试查询启用了行级安全性的表时，他们将仅收到权限被拒绝的错误。
然而，这并不改变视图的工作方式。与普通查询和视图一样，引用视图的表的权限检查和策略将使用视图所有者的权限以及适用于视图所有者的任何策略，除非视图是使用security_invoker选项定义的（请参见CREATE VIEW）。
MERGE没有单独的策略。相反，在执行MERGE时，应用为SELECT、
INSERT、UPDATE和DELETE定义的策略，具体取决于执行的操作。
在第 5.9 节中可以找到额外的讨论和实际的例子。
兼容性
CREATE POLICY是一种PostgreSQL扩展。
另见ALTER POLICY, DROP POLICY, ALTER TABLE上一页 上一级 下一页CREATE OPERATOR FAMILY 起始页 CREATE PROCEDURE
