# DISCONNECT

DISCONNECT
版本：
纠错本页面
搜索
目录导航
❮
❯
DISCONNECTDISCONNECT — 终止数据库连接大纲
DISCONNECT connection_name
DISCONNECT [ CURRENT ]
DISCONNECT ALL
描述
DISCONNECT 关闭一个（或所有）到数据库的连接。
参数connection_name #
一个由 CONNECT 命令建立的数据库连接名称。
CURRENT #
关闭“当前”连接，它可以是最近打开的连接或者是由SET CONNECTION命令设置的连接。如果没有参数传给DISCONNECT命令，这将是默认值。
ALL #
关闭所有打开的连接。
示例
int
main(void)
{
EXEC SQL CONNECT TO testdb AS con1 USER testuser;
EXEC SQL CONNECT TO testdb AS con2 USER testuser;
EXEC SQL CONNECT TO testdb AS con3 USER testuser;
EXEC SQL DISCONNECT CURRENT;  /* close con3          */
EXEC SQL DISCONNECT ALL;      /* close con2 and con1 */
return 0;
}
兼容性
DISCONNECT在SQL标准中被指定。
另请参阅CONNECT, SET CONNECTION上一页 上一级 下一页DESCRIBE 起始页 EXECUTE IMMEDIATE
