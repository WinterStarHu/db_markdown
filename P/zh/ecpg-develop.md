# 34.17. 内部

34.17. 内部
版本：
纠错本页面
搜索
目录导航
❮
❯
34.17. 内部 #
这一节解释ECPG在内部如何工作。这些信息有时有助于用户理解如何使用ECPG。
ecpg写到输出的头四行是固定行。两行是注释，两行是与库接口必须的包括行。然后预处理器会从文件读取并写输出。通常它会把所有东西回显到输出上。
当它看见一个EXEC SQL语句时，它会干预并改变它。命令以EXEC SQL开始，以;结束。之间的任何内容都被视作一个SQL语句，并被解析进行变量替换。
当一个符号以冒号（:）开头时，变量替换会发生。具有该名称的变量会在之前声明于EXEC SQL DECLARE小节中的变量中查找。
该库中最重要的函数是ECPGdo，它负责执行大部分命令。它采用可变数量的参数。可以很容易地增加到大约50个参数，并且我们希望在任何平台上这都不会成为问题。
参数包括：
行号 #
这是原始行的行号；仅用于错误消息中。
字符串 #
这是要执行的SQL命令。它会被输入变量修改，
即那些在编译时未知但需要在命令中输入的变量。字符串中包含
?的位置表示变量应放置的位置。
输入变量 #
每个输入变量会生成十个参数。（见下文。）
ECPGt_EOIT #
一个enum，表示没有更多的输入变量。
输出变量 #
每个输出变量会生成十个参数。（见下文。）这些变量由函数填充。
ECPGt_EORT #
一个enum，表示没有更多的变量。
对于每一个作为SQL命令一部分的变量，该函数得到十个参数：
作为一个特殊符号的类型。
一个值的指针或者一个指针的指针。
如果变量是一个char或者varchar，这是它的尺寸。
数组中元素的数量（用于数组获取）。
数组中下一个元素的偏移量（用于数组获取）。
作为一个特殊符号的指示符变量的类型。
一个指示符变量的指针。
0
指示符数组中的元素数量（用于数组获取）。
到指示符数组中下一个元素的偏移量（用于数组获取）。
注意并非所有 SQL 命令都以这种方式处理。例如，一个打开游标语句：
EXEC SQL OPEN cursor;
不会被复制到输出。反而，游标的DECLARE命令被用在OPEN命令的位置上，因为它确实会打开该游标。
这里有一个完整的例子，它描述了一个文件foo.pgc的预处理器输出（对预处理器的每一个特定版本细节可能不同）：
EXEC SQL BEGIN DECLARE SECTION;
int index;
int result;
EXEC SQL END DECLARE SECTION;
...
EXEC SQL SELECT res INTO :result FROM mytable WHERE index = :index;
会被翻译成：
/* 由 ecpg (2.6.0) 处理 */
/* 这两个头文件由预处理器增加 */
#include <ecpgtype.h>;
#include <ecpglib.h>;
/* exec sql begin declare section */
#line 1 "foo.pgc"
int index;
int result;
/* exec sql end declare section */
...
ECPGdo(__LINE__, NULL, "SELECT res FROM mytable WHERE index = ?     ",
ECPGt_int,&(index),1L,1L,sizeof(int),
ECPGt_NO_INDICATOR, NULL , 0L, 0L, 0L, ECPGt_EOIT,
ECPGt_int,&(result),1L,1L,sizeof(int),
ECPGt_NO_INDICATOR, NULL , 0L, 0L, 0L, ECPGt_EORT);
#line 147 "foo.pgc"
（这里的缩进是为了可读性而添加的，并非是预处理器做的处理）。
上一页 上一级 下一页34.16. Oracle 兼容模式 起始页 第 35 章 信息模式
