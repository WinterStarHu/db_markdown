# DROP STATISTICS

DROP STATISTICS
版本：
纠错本页面
搜索
目录导航
❮
❯
DROP STATISTICSDROP STATISTICS — 删除扩展统计大纲
DROP STATISTICS [ IF EXISTS ] name [, ...] [ CASCADE | RESTRICT ]
说明
DROP STATISTICS 删除统计对象(s) 从数据库中。只有统计对象的所有者、模式的所有者或超级用户可以删除统计对象。
参数IF EXISTS
如果统计对象不存在则不要抛出错误，这种情况下会发出一个提示。
name
要删除的统计对象的名称（可以是模式限定的）。
CASCADERESTRICT
由于没有对统计数据的依赖，这些关键字没有任何效果。
示例
删除不同模式中的两个统计对象，如果它们不存在时不会失败：
DROP STATISTICS IF EXISTS
accounting.users_uid_creation,
public.grants_user_role;
兼容性
SQL标准中没有DROP STATISTICS命令。
另见ALTER STATISTICS, CREATE STATISTICS上一页 上一级 下一页DROP SERVER 起始页 DROP SUBSCRIPTION
