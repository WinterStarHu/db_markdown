# CREATE SEQUENCE

CREATE SEQUENCE
版本：
纠错本页面
搜索
目录导航
❮
❯
CREATE SEQUENCECREATE SEQUENCE — 定义一个新的序列生成器大纲
CREATE [ { TEMPORARY | TEMP } | UNLOGGED ] SEQUENCE [ IF NOT EXISTS ] name
[ AS data_type ]
[ INCREMENT [ BY ] increment ]
[ MINVALUE minvalue | NO MINVALUE ] [ MAXVALUE maxvalue | NO MAXVALUE ]
[ [ NO ] CYCLE ]
[ START [ WITH ] start ]
[ CACHE cache ]
[ OWNED BY { table_name.column_name | NONE } ]
描述
CREATE SEQUENCE 创建一个新的序列号
生成器。这涉及到用名称 name 创建并初始化
一个新的特殊单行表。该生成器将由发出该命令的用户拥有。
如果给定了模式名称，则序列将在指定的模式中创建。否则，它将在当前模式中创建。
临时序列存在于一个特殊的模式中，因此在创建临时序列时不能指定模式名称。
序列名称必须与同一模式中的任何其他关系（表、序列、索引、视图、物化视图或外部表）的名称不同。
在序列被创建后，可以使用函数
nextval、
currval以及
setval 来操作该序列。这些函数在
第 9.17 节 中有介绍。
尽管无法直接更新一个序列，可以使用这样的查询：
SELECT * FROM name;
来检查一个序列的参数以及当前状态。特别地，序列的
last_value 字段显示被任意会话最后一次取得的值（当然，
在被打印时该值可能已经过时，因为可能有其他会话正在执行
nextval 调用）。
参数TEMPORARY or TEMP
如果被指定，只会为这个会话创建序列对象，并且在会话退出时自动
删除它。当临时序列存在时，已有的同名永久序列（在这个会话中）
会变得不可见，不过可以用模式限定的名称来引用同名永久序列。
UNLOGGED
如果指定，该序列将被创建为非记录序列。对非记录序列的更改不会被写入预写式日志。
它们不是崩溃安全的：在崩溃或非正常关闭后，非记录序列会自动重置为其初始状态。
非记录序列也不会被复制到备用服务器。
与未记录的表不同，未记录的序列并不提供显著的性能优势。此选项主要用于通过标识列或序列列与未记录表关联的序列。
在这些情况下，通常没有意义将序列WAL记录并复制，而不是其关联的表。
IF NOT EXISTS
如果已经存在一个同名的关系时不要抛出错误。这种情况下会发出一个
提示。注意这不保证现有的关系与即将创建的序列相似 — 它甚至可能
都不是一个序列。
name
要创建的序列的名称（可以是模式限定的）。
data_type
可选的子句AS data_type
指定序列的数据类型。有效类型是
smallint、integer、
和bigint。默认是bigint。
数据类型决定了序列的默认最小和最大值。
increment
可选的子句INCREMENT BY increment指定
了创建新值时将哪个值加到当前序列值上。一个正值将会创造一个上升
序列，负值会创造一个下降序列。默认值是 1。
minvalueNO MINVALUE
可选的子句MINVALUE minvalue决定一个序列
能产生的最小值。如果没有提供这个子句或者指定了
NO MINVALUE，那么会使用默认值。
升序序列的默认值为 1。降序序列的默认值为数据类型的最小值。
maxvalueNO MAXVALUE
可选的子句MAXVALUE maxvalue决定该序列
的最大值。如果没有提供这个子句或者指定了
NO MAXVALUE，那么将会使用默认值。
升序序列的默认值是数据类型的最大值。降序序列的默认值是 -1。
CYCLENO CYCLE
对于上升序列和下降序列，CYCLE选项允许序列
在分别达到maxvalue和minvalue时回卷。如果达到
该限制，下一个产生的数字将分别是minvalue和maxvalue。
如果指定了NO CYCLE，当序列到达其最大值
后任何nextval调用将返回一个错误。如果
CYCLE和NO CYCLE都没有
被指定，则默认为NO CYCLE。
start
可选的子句START WITH start 允许序列从任何
地方开始。对于上升序列和下降序列来说，默认的开始值分别是
minvalue和
maxvalue。
cache
可选的子句CACHE cache指定要预分配多少
个序列数并且把它们放在内存中以便快速访问。最小值为 1 （一次只生成
一个值，即没有缓存），默认值也是 1。
OWNED BY table_name.column_nameOWNED BY NONE
OWNED BY选项导致序列与一个特定的表列关联
在一起，这样如果该列（或者整个表）被删除，该序列也将被自动删除。
指定的表必须和序列具有相同的拥有者并且在同一个模式中。默认选项
OWNED BY NONE指定该序列不与某个列关联。
注释
使用DROP SEQUENCE来移除一个序列。
序列是基于bigint算法的，因此范围不能超过一个八字节
整数的范围（-9223372036854775808 到 9223372036854775807）。
由于nextval和setval调用绝不会回滚，
如果需要序列号的“无间隙”分配，则不能使用序列对象。可以
通过在一个只包含一个计数器的表上使用排他锁来构建无间隙的分配，
但是这种方案比序列对象开销更大，特别是当有很多事务并发请求序列号
时。
如果对一个将由多个会话并发使用的序列对象使用了大于 1 的cache设置，可能会得到意想不到的结果。
每个会话会在访问该序列对象时分配并且缓存后续的序列值，并且相应地增加
该序列对象的last_value。然后，在该会话中下一次
nextval会做
cache-1，并且简单地
返回预分配的值而不修改序列对象。因此，任何已分配但没有在会话中使用的
数字将在该会话结束时丢失，导致该序列中的“空洞”。
此外，虽然多个会话保证分配不同的序列值，但在考虑所有会话时，这些值可能是按顺序生成的。例如，使用cache设置为10时，会话A可能保留值1..10并返回nextval=1，然后会话B可能保留值11..20并返回nextval=11，而会话A尚未生成nextval=2。因此，当cache设置为1时，可以安全地假设nextval值是按顺序生成的；当cache设置大于1时，您只能假设nextval值都是不同的，而不是纯粹按顺序生成的。此外，last_value将反映任何会话保留的最新值，无论是否已被nextval返回。
另一个考虑是，在这样一个序列上执行的setval将不会被
其他会话注意到，直到它们用尽了任何已缓存的预分配值。
示例
创建一个称作serial的上升序列，从 101 开始：
CREATE SEQUENCE serial START 101;
从这个序列中选取下一个数字：
SELECT nextval('serial');
nextval
---------
101
再从这个序列中选取下一个数字：
SELECT nextval('serial');
nextval
---------
102
在一个INSERT命令中使用这个序列：
INSERT INTO distributors VALUES (nextval('serial'), 'nothing');
在一次COPY FROM后更新序列值：
BEGIN;
COPY distributors FROM 'input_file';
SELECT setval('serial', max(id)) FROM distributors;
END;
兼容性
CREATE SEQUENCE符合SQL
标准，不过下列除外：
使用nextval()而不是标准的NEXT VALUE FOR
表达式获取下一个值。
OWNED BY子句是一种PostgreSQL扩展。
另请参阅ALTER SEQUENCE, DROP SEQUENCE上一页 上一级 下一页CREATE SCHEMA 起始页 CREATE SERVER
