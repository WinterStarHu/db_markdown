# 34.11. 库函数

34.11. 库函数
版本：
纠错本页面
搜索
目录导航
❮
❯
34.11. 库函数 #
libecpg库主要包含用于实现嵌入式 SQL 命令所表达功能的“隐藏”函数。但是也有一些可以被直接调用的函数。注意这会让你的代码不可移植。
ECPGdebug(int on, FILE
*stream)会打开调试日志，如果调用时第一个参数非零。调试日志在stream上完成。该日志包含所有插入了输入变量的SQL语句，以及来自于PostgreSQL服务器的结果。在你的SQL语句中查找错误时这会非常有用。
注意
在 Windows 上，如果ecpg库和应用使用不同标志编译，这个函数调用将会导致应用崩溃，因为FILE指针的内部表示不同。特别地，库和使用库的应用应该使用相同的多线程/单线程、发行/调试以及静态/动态标志。
ECPGget_PGconn(const char *connection_name)
返回由给定名称标识的库数据库连接句柄。如果connection_name被设置为NULL，当前连接句柄将被返回。如果无法定位到连接句柄，该函数返回NULL。如果需要，返回的连接句柄可以用来调用任何其他来自于libpq的函数。
注意
直接使用libpq例程来操纵ecpg中建立的数据库连接句柄是一种糟糕的做法。
ECPGtransactionStatus(const char *connection_name)返回由connection_name标识的给定连接的当前事务状态。
关于返回的状态代码请参考第 32.2 节和libpq的PQtransactionStatus。
如果你连接到了一个数据库，ECPGstatus(int lineno,
const char* connection_name)会返回真；否则返回假。
如果使用的是一个单一连接，connection_name可以为NULL。
上一页 上一级 下一页34.10. 处理嵌入式 SQL 程序 起始页 34.12. 大对象
