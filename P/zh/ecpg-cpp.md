# 34.13. C++ 应用

34.13. C++ 应用
版本：
纠错本页面
搜索
目录导航
❮
❯
34.13. C++ 应用 #34.13.1. 主变量的可见范围34.13.2. 使用外部 C 模块的 C++ 应用开发
ECPG 对于 C++ 应用提供了有限的支持。这一节描述了一些注意事项。
ecpg预处理器采用一个用 C（或者类似 C 的东西）和嵌入式 SQL 命令编写的输入文件，把嵌入式 SQL 命令转换成 C 语言块，并且最终产生一个.c文件。在 C++ 下使用时，它们应该能在 C++ 中无缝地使用。
不过，通常ecpg预处理器只理解 C，它无法处理 C++ 语言的特殊语法和保留词。因此，一些写在 C++ 应用代码中的使用了 C++ 特定复杂特性的嵌入式 SQL 代码可能无法被正确地预处理或者无法按预期工作。
使用 C++ 应用中嵌入式 SQL 代码的安全方法是把 ECPG 调用隐藏在一个 C 模块中，C++ 应用代码会调用它来访问数据库，还要把它和剩余的 C++ 代码链接起来。详见第 34.13.2 节。
34.13.1. 主变量的可见范围 #
ecpg预处理器能理解 C 中变量的可见范围。在 C 语言中，这是相当简单的，因为变量的可见范围是基于它们的代码块的。不过在 C++ 中，引用类成员变量的代码块是不同于定义它的代码块的，因此ecpg预处理器将无法理解类成员变量的可见范围。
例如，在下面的情况中，ecpg预处理器无法为test方法中的变量dbname找到任何声明，因此将发生一个错误。
class TestCpp
{
EXEC SQL BEGIN DECLARE SECTION;
char dbname[1024];
EXEC SQL END DECLARE SECTION;
public:
TestCpp();
void test();
~TestCpp();
};
TestCpp::TestCpp()
{
EXEC SQL CONNECT TO testdb1;
EXEC SQL SELECT pg_catalog.set_config('search_path', '', false); EXEC SQL COMMIT;
}
void Test::test()
{
EXEC SQL SELECT current_database() INTO :dbname;
printf("current_database = %s\n", dbname);
}
TestCpp::~TestCpp()
{
EXEC SQL DISCONNECT ALL;
}
这段代码将导致一个这样的错误：
ecpg test_cpp.pgc
test_cpp.pgc:28: ERROR: variable "dbname" is not declared
为了避免这种可见性问题，可以修改test方法来把一个本地变量用作中间存储。但是这种方法只是一种比较差的变通方案，因为它让代码变得丑陋并且降低了性能。
void TestCpp::test()
{
EXEC SQL BEGIN DECLARE SECTION;
char tmp[1024];
EXEC SQL END DECLARE SECTION;
EXEC SQL SELECT current_database() INTO :tmp;
strlcpy(dbname, tmp, sizeof(tmp));
printf("current_database = %s\n", dbname);
}
34.13.2. 使用外部 C 模块的 C++ 应用开发 #
如果你理解了 C++ 中ecpg预处理器的这些技术限制，你可能已经知道在链接阶段把 C 对象和 C++ 对象链接起来让 C++ 应用能使用 ECPG 特性比直接在 C++ 代码中写一些嵌入式 SQL 命令要更好。这一节用一个简单的例子描述了一种将嵌入式 SQL 命令从 C++ 应用代码中独立出去的方法。在这个例子中，应用由 C++ 实现，而 C 和 ECPG 被用来连接到 PostgreSQL 服务器。
需要创建三种文件：一个 C 文件
(*.pgc)、一个头文件和一个 C++ 文件：
test_mod.pgc #
一个子程序模块，用于执行嵌入在 C 中的 SQL 命令。
它将被预处理器转换为
test_mod.c。
#include "test_mod.h"
#include <stdio.h>
void
db_connect()
{
EXEC SQL CONNECT TO testdb1;
EXEC SQL SELECT pg_catalog.set_config('search_path', '', false); EXEC SQL COMMIT;
}
void
db_test()
{
EXEC SQL BEGIN DECLARE SECTION;
char dbname[1024];
EXEC SQL END DECLARE SECTION;
EXEC SQL SELECT current_database() INTO :dbname;
printf("current_database = %s\n", dbname);
}
void
db_disconnect()
{
EXEC SQL DISCONNECT ALL;
}
test_mod.h #
一个头文件，包含 C 模块
(test_mod.pgc) 中函数的声明。
它被test_cpp.cpp包含。
这个文件必须在声明周围有一个
extern "C"块，因为它将从 C++ 模块中链接。
#ifdef __cplusplus
extern "C" {
#endif
void db_connect();
void db_test();
void db_disconnect();
#ifdef __cplusplus
}
#endif
test_cpp.cpp #
应用程序的主代码，包括
main例程，以及在本例中
一个 C++ 类。
#include "test_mod.h"
class TestCpp
{
public:
TestCpp();
void test();
~TestCpp();
};
TestCpp::TestCpp()
{
db_connect();
}
void
TestCpp::test()
{
db_test();
}
TestCpp::~TestCpp()
{
db_disconnect();
}
int
main(void)
{
TestCpp *t = new TestCpp();
t->test();
return 0;
}
要构建该应用，按以下步骤处理。通过运行ecpg将test_mod.pgc转换为test_mod.c，并且用 C 编译器将test_mod.c编译成test_mod.o：
ecpg -o test_mod.c test_mod.pgc
cc -c test_mod.c -o test_mod.o
接着，用 C++ 编译器把test_cpp.cpp编译成test_cpp.o：
c++ -c test_cpp.cpp -o test_cpp.o
最后，使用 C++ 编译器链接这些对象文件（test_cpp.o和test_mod.o）成为一个可执行文件：
c++ test_cpp.o test_mod.o -lecpg -o test_cpp
上一页 上一级 下一页34.12. 大对象 起始页 34.14. 嵌入式 SQL 命令
