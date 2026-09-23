# F.36. pg_visibility — 可见性映射信息和工具

F.36. pg_visibility — 可见性映射信息和工具
版本：
纠错本页面
搜索
目录导航
❮
❯
F.36. pg_visibility — 可见性映射信息和工具 #F.36.1. 函数F.36.2. 作者
pg_visibility模块提供了一种方式来检查一个表的可见性映射（VM）以及页级别的可见性信息。它还提供了函数来检查可见性映射的完整性以及强制重建可见性映射。
有三个不同的位被用来存储有关页级别可见性的信息。
可见性映射中的“全部可见”位表示一个关系的对应页面上的所有元组对每一个当前和未来事务都可见。
可见性映射中的“全部冻结”位表示该页上的每一个元组都被冻结，
也就是说直到在那个页面上对一个元组进行插入、更新、
删除或者锁定之前都不需要用 vacuum 对该页面进行修改。
页面头部的PD_ALL_VISIBLE位具有和可见性映射中“全部可见”位相同的含义，
但是它存储在数据页面本身中而不是存储在单独的数据结构中。这两个位通常是相互一致的，
但是有时在崩溃恢复后会出现页面的“全部可见”位被设置而可见性映射位被清除的情况，
由于在pg_visibility检查了可见性映射之后，
且在它检查数据页面之前发生了修改，报告的值也会不一致。
任何导致数据损坏的事件也可能导致这些位不一致。
显示有关PD_ALL_VISIBLE的信息的函数代价比那些查看可见性映射的函数要高很多，因为它们必须读取关系的数据块而不是只读取（小很多的）可见性映射。类似地，检查关系的数据块的函数也很昂贵。
F.36.1. 函数 #pg_visibility_map(relation regclass, blkno bigint, all_visible OUT boolean, all_frozen OUT boolean) returns record
为给定关系的给定块返回其在可见性映射中的“全部可见”和“全部冻结”位。
pg_visibility(relation regclass, blkno bigint, all_visible OUT boolean, all_frozen OUT boolean, pd_all_visible OUT boolean) returns record
为给定关系的给定块返回其在可见性映射中的“全部可见”和“全部冻结”位，外加块的PD_ALL_VISIBLE位。
pg_visibility_map(relation regclass, blkno OUT bigint, all_visible OUT boolean, all_frozen OUT boolean) returns setof record
为给定关系的每一块返回其在可见性映射中的“全部可见”和“全部冻结”位。
pg_visibility(relation regclass, blkno OUT bigint, all_visible OUT boolean, all_frozen OUT boolean, pd_all_visible OUT boolean) returns setof record
为给定关系的每一块返回其在可见性映射中的“全部可见”和“全部冻结”位，外加每一块的PD_ALL_VISIBLE位。
pg_visibility_map_summary(relation regclass, all_visible OUT bigint, all_frozen OUT bigint) returns record
根据可见性映射返回关系中“全部可见”页面和“全部冻结”页面的数量。
pg_check_frozen(relation regclass, t_ctid OUT tid) returns setof tid
返回存储在可见性映射中被标为“全部冻结”的页面中的非冻结元组的 TID。
如果该函数返回一个非空的 TID 集合，则可见性映射已经损坏。
pg_check_visible(relation regclass, t_ctid OUT tid) returns setof tid
返回存储在可见性映射中标记为“全部可见”的页面中的非全部可见元组的 TID。
如果该函数返回非空的一组 TID，则可见性映射已损坏。
pg_truncate_visibility_map(relation regclass) returns void
为给定关系截断可见性映射。如果您认为该关系的可见性映射已损坏并希望强制重建它，
则该函数非常有用。在该函数被执行后，在给定关系上进行的第一次VACUUM
将会扫描关系中的每一个页面并重建可见性映射。（在完成之前，
查询会将可见性映射视为包含全是零。）
默认情况下，这些函数只能由超级用户和具有pg_stat_scan_tables角色权限的角色执行，
例外是pg_truncate_visibility_map(relation regclass)，只能由超级用户执行。
F.36.2. 作者 #
Robert Haas <rhaas@postgresql.org>
上一页 上一级 下一页F.35. pg_trgm —
使用三元组匹配支持文本相似性 起始页 F.37. pg_walinspect — 低级 WAL 检查
