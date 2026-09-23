# 34.12. 大对象

34.12. 大对象
版本：
纠错本页面
搜索
目录导航
❮
❯
34.12. 大对象 #
ECPG 并不直接支持大对象，在调用ECPGget_PGconn()函数获得所需的PGconn对象后，ECPG 应用能通过 libpq 大对象函数操纵大对象（不过，对ECPGget_PGconn()函数的使用以及直接接触PGconn对象都必须非常小心，并且最好不要与其他 ECPG 数据库访问调用混合在一起）。
更多关于ECPGget_PGconn()的细节可见第 34.11 节。大对象函数接口的相关信息可见第 33 章。
大对象函数必须在一个事务块中被调用，因此当自动提交关闭时，必须显式地发出BEGIN命令。
例 34.2给出了一个例子程序，它展示了在一个 ECPG 应用中如何创建、写入和读取一个大对象。
例 34.2. 访问大对象的 ECPG 程序
#include <stdio.h>
#include <stdlib.h>
#include <libpq-fe.h>
#include <libpq/libpq-fs.h>
EXEC SQL WHENEVER SQLERROR STOP;
int
main(void)
{
PGconn     *conn;
Oid         loid;
int         fd;
char        buf[256];
int         buflen = 256;
char        buf2[256];
int         rc;
memset(buf, 1, buflen);
EXEC SQL CONNECT TO testdb AS con1;
EXEC SQL SELECT pg_catalog.set_config('search_path', '', false); EXEC SQL COMMIT;
conn = ECPGget_PGconn("con1");
printf("conn = %p\n", conn);
/* create */
loid = lo_create(conn, 0);
if (loid &lt; 0)
printf("lo_create() failed: %s", PQerrorMessage(conn));
printf("loid = %d\n", loid);
/* write test */
fd = lo_open(conn, loid, INV_READ|INV_WRITE);
if (fd &lt; 0)
printf("lo_open() failed: %s", PQerrorMessage(conn));
printf("fd = %d\n", fd);
rc = lo_write(conn, fd, buf, buflen);
if (rc &lt; 0)
printf("lo_write() failed\n");
rc = lo_close(conn, fd);
if (rc &lt; 0)
printf("lo_close() failed: %s", PQerrorMessage(conn));
/* read test */
fd = lo_open(conn, loid, INV_READ);
if (fd &lt; 0)
printf("lo_open() failed: %s", PQerrorMessage(conn));
printf("fd = %d\n", fd);
rc = lo_read(conn, fd, buf2, buflen);
if (rc &lt; 0)
printf("lo_read() failed\n");
rc = lo_close(conn, fd);
if (rc &lt; 0)
printf("lo_close() failed: %s", PQerrorMessage(conn));
/* check */
rc = memcmp(buf, buf2, buflen);
printf("memcmp() = %d\n", rc);
/* cleanup */
rc = lo_unlink(conn, loid);
if (rc &lt; 0)
printf("lo_unlink() failed: %s", PQerrorMessage(conn));
EXEC SQL COMMIT;
EXEC SQL DISCONNECT ALL;
return 0;
}
上一页 上一级 下一页34.11. 库函数 起始页 34.13. C++ 应用
