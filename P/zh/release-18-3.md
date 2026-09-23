# E.1. 版本 18.3

E.1. 版本 18.3
版本：
纠错本页面
搜索
目录导航
❮
❯
E.1. 版本 18.3 #E.1.1. 迁移到版本 18.3E.1.2. 变更发布日期：. 2026-02-26
此版本包含来自 18.2 的少量修复。
有关主要版本 18 中新功能的信息，请参见
第 E.4 节。
E.1.1. 迁移到版本 18.3 #
对于运行 18.X 的用户，不需要进行转储/恢复。
然而，如果您是从早于 18.2 的版本升级，
请参阅 第 E.2 节。
E.1.2. 变更 #
修复从 WAL 重放由旧的次要版本生成的 multixid 截断记录后失败的问题
(Heikki Linnakangas)
§
处理以前版本处理 multixid 回绕的方式的错误逻辑导致重放失败，
并出现类似 “无法访问事务状态” 的消息。
这种情况的典型场景是最新次要版本的备用服务器从
旧版本的主服务器消费 WAL。
避免在对 substring() 应用
“toasted” 数据时错误地抱怨无效编码
(Noah Misch)
§
§
§
CVE-2026-2006 的修复过于激进，可能会在实际上有效的情况下
报告关于不完整字符的错误。
修复 CVE-2026-2007 的修复中的疏忽 (Zsolt Parragi)
§
如果需要扩展 “bounds” 数组，因为输入包含的三元组
超过了初始猜测，generate_trgm_only 没有将修改后的
数组指针返回给调用者。这将导致 strict_word_similarity()
和相关函数的输出不正确，或者在少数情况下导致崩溃。
如果输入字符串在转换为小写时变得更长，则会到达错误的代码。
目前已知的情况是使用某些单字节编码的 ICU 区域设置时发生的。
修复 json_strip_nulls()
和 jsonb_strip_nulls() 的波动性标记
(Andrew Dunstan)
§
这些函数一直被认为是不可变的，但在版本 18 中的重构意外地将它们标记为稳定。
这阻止了它们在索引表达式中的使用，并可能导致查询中不必要的重复评估。
此修复在新初始化的数据库集群中更正了标记（包括通过
pg_upgrade 升级到 18.3 或更高版本的集群）。
但是，它不会帮助使用 18.0 到 18.2 版本创建的现有集群。
如果这个错误影响了您对这些函数的使用，建议对现有集群的修复是手动更新目录。
作为超级用户，在每个受影响的数据库中执行
UPDATE pg_catalog.pg_proc SET provolatile = 'i' WHERE oid IN ('3261','3262');
还要更新 template0
和 template1，以便将来创建的数据库将具有修复。
修复 LATERAL UNION ALL 子查询输出的潜在空连接的集合计算
(Richard Guo)
§
这个错误可能导致跳过 NOT NULL 测试，
错误地认为它们是不必要的，从而导致查询输出错误。
避免用户编写的约束与自动命名的 NOT NULL 约束之间的名称冲突
(Laurenz Albe)
§
从版本 18 开始，NOT NULL 约束具有完整的 pg_constraint 条目，
因此需要名称。为未命名的 NOT NULL 约束选择名称的逻辑未能避免
与同一 CREATE TABLE 语句中其他地方的用户编写的约束冲突。
修复 pg_stat_get_backend_wait_event()
和 pg_stat_get_backend_wait_event_type()
以报告辅助进程的值 (Heikki Linnakangas)
§
之前这些函数对辅助进程返回 NULL，
但这与 pg_stat_activity 视图不一致。
修复从 PL/pgSQL 函数返回复合类型变量的值时
将其转换为域类型的问题（Tom Lane）
§
如果变量的值为 NULL，将导致 “cache lookup failed for
type 0” 错误。
修复 contrib/hstore 的二进制输入函数中
可能出现的空指针解引用问题（Michael Paquier）
§
hstore 的接收函数在输入包含
重复键时崩溃。hstore 由 Postgres 生成的值
永远不会包含重复键，因此这个错误一直未被注意。
崩溃可能是由恶意或损坏的数据引起的。
上一页 上一级 下一页附录 E. 版本说明 起始页 E.2. 版本 18.2
