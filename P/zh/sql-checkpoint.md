# CHECKPOINT

CHECKPOINT
版本：
纠错本页面
搜索
目录导航
❮
❯
CHECKPOINTCHECKPOINT — 强制写前日志检查点大纲
CHECKPOINT
描述
一个检查点是写前日志序列中的一个点，在该点上所有数据文件
都已经被更新为反映日志中的信息。所有数据文件将被刷新到磁盘。
检查点期间发生的细节可见第 28.5 节。
CHECKPOINT命令在发出时强制一个
立即的检查点，而不用等待由系统规划的常规检查点（由
第 19.5.2 节中的设置控制）。
CHECKPOINT不是用来在正常操作中
使用的命令。
如果在恢复期间执行，CHECKPOINT命令
将强制一个重启点（见第 28.5 节）
而不是写一个新检查点。
只有超级用户或具有 pg_checkpoint 角色权限的用户
才能调用 CHECKPOINT。
兼容性
CHECKPOINT命令是一种
PostgreSQL语言扩展。
上一页 上一级 下一页CALL 起始页 CLOSE
