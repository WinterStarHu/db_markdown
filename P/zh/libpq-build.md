# 32.22. 构建 libpq 程序

32.22. 构建 libpq 程序
版本：
纠错本页面
搜索
目录导航
❮
❯
32.22. 构建 libpq 程序 #
要编译（即编译并且链接）一个使用libpq的程序，你需要做下列所有的事情：
包括libpq-fe.h头文件：
#include <libpq-fe.h>
如果你无法这样做，那么你通常会从你的编译器得到像这样的错误消息：
foo.c: In function `main':
foo.c:34: `PGconn' undeclared (first use in this function)
foo.c:35: `PGresult' undeclared (first use in this function)
foo.c:54: `CONNECTION_BAD' undeclared (first use in this function)
foo.c:68: `PGRES_COMMAND_OK' undeclared (first use in this function)
foo.c:95: `PGRES_TUPLES_OK' undeclared (first use in this function)
通过为你的编译器提供-Idirectory选项，向你的编译器指出PostgreSQL头文件安装在哪里（在某些情况下编译器默认将查看该目录，因此你可以忽略这个选项）。例如你的编译命令行可能看起来像：
cc -c -I/usr/local/pgsql/include testprog.c
如果你在使用 makefile，那么把该选项加到CPPFLAGS变量中：
CPPFLAGS += -I/usr/local/pgsql/include
如果你的程序可能由其他用户编译，那么你不应该像那样硬编码目录位置。你可以运行工具pg_config在本地系统上找出头文件在哪里：
$ pg_config --includedir
/usr/local/include
如果你安装了pkg-config，你可以运行：
$ pkg-config --cflags libpq
-I/usr/local/include
注意这将在路径前面包括-I。
无法为编译器指定正确的选项将导致一个错误消息，例如：
testlibpq.c:8:22: libpq-fe.h: No such file or directory
当链接最终的程序时，指定选项-lpq，这样libpq库会被编译进去，也可以用选项-Ldirectory向编译器指出libpq库所在的位置（再次，编译器将默认搜索某些目录）。为了最大的可移植性，将-L选项放在-lpq选项前面。例如：
cc -o testprog testprog1.o testprog2.o -L/usr/local/pgsql/lib -lpq
你也可以使用pg_config找出库目录：
$ pg_config --libdir
/usr/local/pgsql/lib
或者再次使用pkg-config：
$ pkg-config --libs libpq
-L/usr/local/pgsql/lib -lpq
再次提示这会打印出全部的选项，而不仅仅是路径。
指出这一部分问题的错误消息可能看起来像：
testlibpq.o: In function `main':
testlibpq.o(.text+0x60): undefined reference to `PQsetdbLogin'
testlibpq.o(.text+0x71): undefined reference to `PQstatus'
testlibpq.o(.text+0xa4): undefined reference to `PQerrorMessage'
This means you forgot -lpq.
/usr/bin/ld: cannot find -lpq
这意味着你忘记了-L选项或者没有指定正确的目录。
上一页 上一级 下一页32.21. 线程化程序中的行为 起始页 32.23. 示例程序
