# UNLISTEN

UNLISTEN
版本：
纠错本页面
搜索
目录导航
❮
❯
UNLISTENUNLISTEN — 停止监听通知大纲
UNLISTEN { channel | * }
描述
UNLISTEN被用来移除一个已经存在的对
NOTIFY事件的注册。
UNLISTEN取消任何已经存在的把当前
PostgreSQL会话作为名为
channel的通知
频道的监听者的注册。特殊的通配符*取消当前会话
的所有监听者注册。
NOTIFY
包含有关LISTEN和
NOTIFY使用的更深入讨论。
参数channel
通知频道的名称（任何标识符）。
*
所有当前会话的监听注册都会被清除。
注释
你可以 unlisten 你没有监听的内容，不会出现警告或错误。
在每个会话结束时，UNLISTEN *会被自动执行。
一个已经执行了UNLISTEN的事务不能为
两阶段提交做准备。
示例
进行一次注册：
LISTEN virtual;
NOTIFY virtual;
Asynchronous notification "virtual" received from server process with PID 8448.
一旦执行了UNLISTEN，进一步的NOTIFY
消息将被忽略：
UNLISTEN virtual;
NOTIFY virtual;
-- no NOTIFY event is received
兼容性
SQL 标准中没有UNLISTEN命令。
另见LISTEN, NOTIFY上一页 上一级 下一页TRUNCATE 起始页 UPDATE
