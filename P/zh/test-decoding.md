# F.45. test_decoding — 基于SQL的WAL逻辑解码测试/示例模块

F.45. test_decoding — 基于SQL的WAL逻辑解码测试/示例模块
版本：
纠错本页面
搜索
目录导航
❮
❯
F.45. test_decoding — 基于SQL的WAL逻辑解码测试/示例模块 #
test_decoding是一个逻辑解码输出插件的例子。它并不做
任何特别有用的事情，但可以作为开发你自己的输出插件的起点。
test_decoding通过逻辑解码机制接收 WAL 并将其解码成
被执行的操作的文本表达形式。
这个插件的典型输出（在 SQL 逻辑解码接口上使用）可能是：
postgres=# SELECT * FROM pg_logical_slot_get_changes('test_slot', NULL, NULL, 'include-xids', '0');
lsn     | xid |                       data
-----------+-----+--------------------------------------------------
0/16D30F8 | 691 | BEGIN
0/16D32A0 | 691 | table public.data: INSERT: id[int4]:2 data[text]:'arg'
0/16D32A0 | 691 | table public.data: INSERT: id[int4]:3 data[text]:'demo'
0/16D32A0 | 691 | COMMIT
0/16D32D8 | 692 | BEGIN
0/16D3398 | 692 | table public.data: DELETE: id[int4]:2
0/16D3398 | 692 | table public.data: DELETE: id[int4]:3
0/16D3398 | 692 | COMMIT
(8 rows)
我们还可以获取正在进行中的事务的更改，典型的输出可能是：
postgres[33712]=#* SELECT * FROM pg_logical_slot_get_changes('test_slot', NULL, NULL, 'stream-changes', '1');
lsn    | xid |                       data
-----------+-----+--------------------------------------------------
0/16B21F8 | 503 | opening a streamed block for transaction TXN 503
0/16B21F8 | 503 | streaming change for TXN 503
0/16B2300 | 503 | streaming change for TXN 503
0/16B2408 | 503 | streaming change for TXN 503
0/16BEBA0 | 503 | closing a streamed block for transaction TXN 503
0/16B21F8 | 503 | opening a streamed block for transaction TXN 503
0/16BECA8 | 503 | streaming change for TXN 503
0/16BEDB0 | 503 | streaming change for TXN 503
0/16BEEB8 | 503 | streaming change for TXN 503
0/16BEBA0 | 503 | closing a streamed block for transaction TXN 503
(10 rows)
上一页 上一级 下一页F.44. tcn — 一个触发函数，用于通知监听者表内容的更改 起始页 F.46. tsm_system_rows —
SYSTEM_ROWS采样方法用于TABLESAMPLE
