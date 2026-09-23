# LISTEN

LISTEN
版本：
纠错本页面
搜索
目录导航
❮
❯
LISTENLISTEN — 监听通知大纲
LISTEN channel
描述
LISTEN在名为channel的通知频道上将当前会话注册为一个监听者。如果当前会话已经被注册为这个通知频道的一个监听者，则什么也不会发生。
只要命令NOTIFY channel被调用（不管是在这个会话还是在另一个连接到同一数据库的会话中），所有当前正在该通知频道上监听的会话都会被通知，并且每一个会话将会接着通知连接到它的客户端应用。
可以使用UNLISTEN命令在一个给定通知频道上反注册一个会话。当会话结束时，它的监听注册会被自动清除。
一个客户端应用检测通知事件的必用方法取决于它使用的PostgreSQL应用编程接口。如果使用libpq库，应用会将LISTEN作为一个普通 SQL 命令发出，并且接着必须周期性地调用函数PQnotifies来查看是否接收到通知事件。其他诸如libpgtcl的接口提供了更高层次上的处理通知事件的方法。事实上，通过使用libpgtcl应用程序员甚至不必直接发出LISTEN或UNLISTEN。更多细节可参阅所使用的接口的文档。
参数channel
一个通知频道的名称（任意标识符）。
注意事项
LISTEN在事务提交时生效。如果在一个后来被回滚的事务中执行了LISTEN或UNLISTEN，被监听的通知频道集合不会变化。
一个已经执行了LISTEN的事务不能为两阶段提交做准备。
第一次设置侦听会话时有一个竞争条件：如果并发提交的事务正在发送通知事件，那么新的侦听会话将接收哪些事件？
答案是，会话将接收在事务提交步骤中的一瞬间之后所有提交的事件。但这比事务在查询中可能观察到的任何
数据库状态都要晚一些。这将导致使用LISTEN的以下规则：首先执行（并提交！）该命令，
然后在一个新事务中根据应用程序逻辑的需要检查数据库状态，然后依靠通知来了解数据库状态的后续更改。最初收
到的几个通知可能涉及在初始数据库检查中已经观察到的更新，但这通常是无害的。
NOTIFY
对LISTEN和NOTIFY的使用进行了更广泛的讨论。
示例
从psql中配置并执行一个监听/通知序列：
LISTEN virtual;
NOTIFY virtual;
Asynchronous notification "virtual" received from server process with PID 8448.
兼容性
在 SQL 标准中没有LISTEN语句。
参见NOTIFY, UNLISTEN, max_notify_queue_pages上一页 上一级 下一页INSERT 起始页 LOAD
