# CONNECT

CONNECT
版本：
纠错本页面
搜索
目录导航
❮
❯
CONNECTCONNECT — 建立一个数据库连接大纲
CONNECT TO connection_target [ AS connection_name ] [ USER connection_user ]
CONNECT TO DEFAULT
CONNECT connection_user
DATABASE connection_target
描述
CONNECT命令在客户端和 PostgreSQL 服务器之间建立连接。
参数connection_target #
connection_target
指定连接目标服务器的形式之一。
[ database_name ] [ @host ] [ :port ] #
通过 TCP/IP 连接
unix:postgresql://host [ :port ] / [ database_name ] [ ?connection_option ] #
通过 Unix 域套接字连接
tcp:postgresql://host [ :port ] / [ database_name ] [ ?connection_option ] #
通过 TCP/IP 连接
SQL 字符串常量 #
包含上述形式之一的值
主机变量 #
类型为 char[] 或 VARCHAR[] 的主机变量，包含上述形式之一的值
connection_name #
用于该连接的一个可选标识符，这样可以在其他命令中引用它。这可以是一个 SQL 标识符或者一个主机变量。
connection_user #
用于数据库连接的用户名。
这个参数也能指定用户名和口令，使用以下形式之一：
user_name/password、
user_name IDENTIFIED BY password或者
user_name USING password。
用户名和口令可以是 SQL 标识符、字符串常量或者主机变量。
DEFAULT #
按 libpq 的定义使用所有默认连接参数。
示例
这里是一些指定连接参数的变体：
EXEC SQL CONNECT TO "connectdb" AS main;
EXEC SQL CONNECT TO "connectdb" AS second;
EXEC SQL CONNECT TO "unix:postgresql://200.46.204.71/connectdb" AS main USER connectuser;
EXEC SQL CONNECT TO "unix:postgresql://localhost/connectdb" AS main USER connectuser;
EXEC SQL CONNECT TO 'connectdb' AS main;
EXEC SQL CONNECT TO 'unix:postgresql://localhost/connectdb' AS main USER :user;
EXEC SQL CONNECT TO :db AS :id;
EXEC SQL CONNECT TO :db USER connectuser USING :pw;
EXEC SQL CONNECT TO @localhost AS main USER connectdb;
EXEC SQL CONNECT TO REGRESSDB1 as main;
EXEC SQL CONNECT TO AS main USER connectdb;
EXEC SQL CONNECT TO connectdb AS :id;
EXEC SQL CONNECT TO connectdb AS main USER connectuser/connectdb;
EXEC SQL CONNECT TO connectdb AS main;
EXEC SQL CONNECT TO connectdb@localhost AS main;
EXEC SQL CONNECT TO tcp:postgresql://localhost/ USER connectdb;
EXEC SQL CONNECT TO tcp:postgresql://localhost/connectdb USER connectuser IDENTIFIED BY connectpw;
EXEC SQL CONNECT TO tcp:postgresql://localhost:20/connectdb USER connectuser IDENTIFIED BY connectpw;
EXEC SQL CONNECT TO unix:postgresql://localhost/ AS main USER connectdb;
EXEC SQL CONNECT TO unix:postgresql://localhost/connectdb AS main USER connectuser;
EXEC SQL CONNECT TO unix:postgresql://localhost/connectdb USER connectuser IDENTIFIED BY "connectpw";
EXEC SQL CONNECT TO unix:postgresql://localhost/connectdb USER connectuser USING "connectpw";
EXEC SQL CONNECT TO unix:postgresql://localhost/connectdb?connect_timeout=14 USER connectuser;
这里是一个展示使用主变量指定连接参数的例子程序：
int
main(void)
{
EXEC SQL BEGIN DECLARE SECTION;
char *dbname     = "testdb";    /* 数据库名 */
char *user       = "testuser";  /* 连接用户名 */
char *connection = "tcp:postgresql://localhost:5432/testdb";
/* 连接字符串 */
char ver[256];                  /* 存储版本字符串的缓冲区 */
EXEC SQL END DECLARE SECTION;
ECPGdebug(1, stderr);
EXEC SQL CONNECT TO :dbname USER :user;
EXEC SQL SELECT pg_catalog.set_config('search_path', '', false); EXEC SQL COMMIT;
EXEC SQL SELECT version() INTO :ver;
EXEC SQL DISCONNECT;
printf("version: %s\n", ver);
EXEC SQL CONNECT TO :connection USER :user;
EXEC SQL SELECT pg_catalog.set_config('search_path', '', false); EXEC SQL COMMIT;
EXEC SQL SELECT version() INTO :ver;
EXEC SQL DISCONNECT;
printf("version: %s\n", ver);
return 0;
}
兼容性
SQL 标准中说明了CONNECT，但是连接参数的格式是
与实现相关的。
参见DISCONNECT, SET CONNECTION上一页 上一级 下一页ALLOCATE DESCRIPTOR 起始页 DEALLOCATE DESCRIPTOR
