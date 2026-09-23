# CLOSE

CLOSE
版本：
纠错本页面
搜索
目录导航
❮
❯
CLOSECLOSE — 关闭游标大纲
CLOSE { name | ALL }
描述
CLOSE释放与一个已打开游标相关
的资源。在游标被关闭后，不允许在其上做后续的操作。当不再
需要使用游标时应该关闭它。
当一个事务被COMMIT或者
ROLLBACK终止时，每一个非可保持
的已打开游标会被隐式地关闭。当创建一个可保持游标的事务通过
ROLLBACK中止时，该可保持游标会
被隐式地关闭。如果该创建事务成功地提交，可保持游标会保持打开，
直至执行一个显式的CLOSE或者
客户端连接断开。
参数name
要关闭的打开游标的名称。
ALL
关闭所有打开的游标。
注释
PostgreSQL没有一个显式的
OPEN游标语句，一个游标在被声明时
就被认为是打开的。使用DECLARE语句来声明游标。
通过查询pg_cursors
系统视图可以看到所有可用的游标。
如果一个游标在一个保存点之后关闭，并且后来回滚到了这个保存点，
那么CLOSE不会被回滚，也就是说游标
仍然保持关闭。
示例
关闭游标liahona：
CLOSE liahona;
兼容性
CLOSE完全符合 SQL 标准。
CLOSE ALL是一个PostgreSQL
扩展。
另见DECLARE, FETCH, MOVE上一页 上一级 下一页CHECKPOINT 起始页 CLUSTER
