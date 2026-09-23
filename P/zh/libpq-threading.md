# 32.21. 线程化程序中的行为

32.21. 线程化程序中的行为
版本：
纠错本页面
搜索
目录导航
❮
❯
32.21. 线程化程序中的行为 #
从版本17开始，libpq始终是可重入且线程安全的。
但是，有一个限制，即不能有两个线程同时尝试操作相同的
PGconn对象。特别是，不能通过同一个连接对象
从不同线程发出并发命令。（如果需要运行并发命令，请使用多个连接。）
PGresult对象在创建后通常是只读的，并且因此可以在线程之间自由地被传递。
但是，如果你使用任何第 32.12 节或第 32.14 节中描述的PGresult修改函数，
你需要负责避免在同一个PGresult上的并发操作。
在早期版本中，libpq可以根据编译器选项选择是否支持线程。
此函数允许查询libpq的线程安全状态：
PQisthreadsafe #
返回libpq库的线程安全状态。
int PQisthreadsafe();
如果libpq是线程安全的，则返回1；如果不是，则返回0。
在版本17及以上始终返回1。
已弃用的函数PQrequestCancel和
PQoidStatus不是线程安全的，不应在多线程程序中使用。
PQrequestCancel可以用PQcancelBlocking
替代。PQoidStatus可以用PQoidValue
替代。
如果你在应用中使用 Kerberos（除了在libpq中之外），你将需要对 Kerberos 调用加锁，因为 Kerberos 函数不是线程安全的。参考libpq源代码中的PQregisterThreadLock函数，那里有在libpq和应用之间做合作锁定的方法。
同样，如果您在应用程序中使用 Curl，并且 您尚未在启动新线程之前 全局初始化 libcurl，则需要在任何可能初始化 libcurl 的代码周围进行协作锁定（再次通过 PQregisterThreadLock）。对于构建为支持线程安全初始化的较新版本的 Curl，此限制已被解除；这些构建可以通过其版本元数据中对 threadsafe 功能的宣传来识别。
上一页 上一级 下一页32.20. OAuth 支持 起始页 32.22. 构建 libpq 程序
