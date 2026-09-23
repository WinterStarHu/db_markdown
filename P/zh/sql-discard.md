# DISCARD

DISCARD
版本：
纠错本页面
搜索
目录导航
❮
❯
DISCARDDISCARD — 丢弃会话状态大纲
DISCARD { ALL | PLANS | SEQUENCES | TEMPORARY | TEMP }
描述
DISCARD 释放与一个数据库会话相关的内部资源。
这个命令有助于部分或完全重置该会话的状态。有几个子命令来
释放不同类型的资源；DISCARD ALL 变体包含
所有其他形式，并且还会重置额外的状态。
参数PLANS
释放所有已缓存的查询计划，强制在下一次使用相关预备语句时
重新规划。
SEQUENCES
丢弃所有已缓存的序列相关状态，包括
currval()/lastval() 信息
以及任何还未被 nextval() 返回的预分配的
序列值（预分配序列值的描述请见
CREATE SEQUENCE）。
TEMPORARY or TEMP
删除当前会话中创建的所有临时表。
ALL
释放与当前会话相关的所有临时资源并将会话重置为初始状态。
当前这和执行以下语句序列的效果相同：
CLOSE ALL;
SET SESSION AUTHORIZATION DEFAULT;
RESET ALL;
DEALLOCATE ALL;
UNLISTEN *;
SELECT pg_advisory_unlock_all();
DISCARD PLANS;
DISCARD TEMP;
DISCARD SEQUENCES;
Notes
DISCARD ALL 不能在事务块内执行。
Compatibility
DISCARD 是一种
PostgreSQL 扩展。
上一页 上一级 下一页DELETE 起始页 DO
