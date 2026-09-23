# 34.9. 预处理器指令

34.9. 预处理器指令
版本：
纠错本页面
搜索
目录导航
❮
❯
34.9. 预处理器指令 #34.9.1. 包含文件34.9.2. define 和 undef 指令34.9.3. ifdef, ifndef, elif, else, 和 endif 指令
一些预处理器指令可以用来改变ecpg预处理器解析和处理一个文件的方式。
34.9.1. 包含文件 #
要包括一个外部文件到你的嵌入式 SQL 程序中，可以用：
EXEC SQL INCLUDE filename;
EXEC SQL INCLUDE <filename>;
EXEC SQL INCLUDE "filename";
嵌入式 SQL 预处理器将查找一个名为filename.h的文件，处理它并把它包括在结果 C 输出中。这样，被包括文件中的嵌入式 SQL 语句会被正确地处理。
ecpg预处理器将以下列顺序在几个目录中搜索一个文件：
当前目录/usr/local/includePostgreSQL 的包括目录，在编译时定义（例如/usr/local/pgsql/include）/usr/include
但是当使用EXEC SQL INCLUDE "filename"时，只有当前目录会被搜索。
在每一个目录中，预处理器将首先按给定的文件名搜索，如果没有找到将会追加.h到文件名并重试（除非指定的文件名已经具有该后缀）。
注意EXEC SQL INCLUDE不同于：
#include <filename.h>
因为这个文件不服从 SQL 命令预处理。自然地，你可以继续使用 C 的#include指令来包括其他头文件。
注意
包括文件名是大小写敏感的，即使EXEC SQL INCLUDE命令的剩余部分遵守通常的 SQL 大小写敏感规则。
34.9.2. define 和 undef 指令 #
与 C 中我们熟知的指令#define相似，嵌入式 SQL 具有类似的概念：
EXEC SQL DEFINE name;
EXEC SQL DEFINE name value;
因此你可以定义一个名称：
EXEC SQL DEFINE HAVE_FEATURE;
并且你也可以定义常量：
EXEC SQL DEFINE MYNUMBER 12;
EXEC SQL DEFINE MYSTRING 'abc';
使用undef来移除一个之前的定义：
EXEC SQL UNDEF MYNUMBER;
当然在你的嵌入式 SQL 程序中你可以继续使用 C 版本的#define和#undef。区别在于你定义的值会在哪里被计算。如果你使用EXEC SQL DEFINE，那么ecpg预处理器会计算这些定义并且替换值。例如，如果你写：
EXEC SQL DEFINE MYNUMBER 12;
...
EXEC SQL UPDATE Tbl SET col = MYNUMBER;
那么ecpg将已经做过替换并且你的 C 编译器将永远不会看见名为MYNUMBER的任何名称或标识符。注意你不能把#define用于一个将要在一个嵌入式 SQL 查询中使用的常量，因为在这种情况下嵌入式 SQL 预编译器不能看到这个声明。
如果在ecpg预处理器的命令行上命名了多个输入文件，
那么EXEC SQL DEFINE和EXEC SQL UNDEF的效果不会跨文件传递：
每个文件都只使用命令行上-D开关定义的符号。
34.9.3. ifdef, ifndef, elif, else, 和 endif 指令 #
您可以使用以下指令有条件地编译代码部分：
EXEC SQL ifdef name; #
检查name，如果name已通过
EXEC SQL define name定义，则处理后续行。
EXEC SQL ifndef name; #
检查name，如果name
未通过EXEC SQL define
name定义，则处理后续行。
EXEC SQL elif name; #
在EXEC SQL ifdef name或
EXEC SQL ifndef name指令之后，
开始一个可选的替代部分。可以出现任意数量的elif部分。
如果name已被定义并且同一
ifdef/ifndef...endif
构造的前一个部分尚未被处理，则处理elif之后的行。
EXEC SQL else; #
在EXEC SQL ifdef name或
EXEC SQL ifndef name指令之后，
开始一个可选的最终替代部分。如果同一
ifdef/ifndef...endif
构造的前一个部分尚未被处理，则处理后续行。
EXEC SQL endif; #
结束ifdef/ifndef...
endif构造。后续行将正常处理。
ifdef/ifndef...endif
结构可以被嵌套，可达 127 层深。
此示例将完全编译三个SET TIMEZONE命令之一：
EXEC SQL ifdef TZVAR;
EXEC SQL SET TIMEZONE TO TZVAR;
EXEC SQL elif TZNAME;
EXEC SQL SET TIMEZONE TO TZNAME;
EXEC SQL else;
EXEC SQL SET TIMEZONE TO 'GMT';
EXEC SQL endif;
上一页 上一级 下一页34.8. 错误处理 起始页 34.10. 处理嵌入式 SQL 程序
