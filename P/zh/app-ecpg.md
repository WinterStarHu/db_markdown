# ecpg

ecpg
版本：
纠错本页面
搜索
目录导航
❮
❯
ecpgecpg — 嵌入式 SQL C 预处理器大纲ecpg [option...]  file... 描述
ecpg是用于 C 程序的嵌入式 SQL 预处理器。它通过将 SQL 调用替换为特殊函数调用把带有嵌入式 SQL 语句的 C 程序转换为普通 C 代码。输出文件可以被任何 C 编译器工具链处理。
ecpg将把命令行中给出的每一个输入文件转换为相应的 C 输出文件。如果输入文件名没有任何扩展名，则假定为.pgc。文件扩展名将由.c替换以构造输出文件名。但是输出文件名可以使用-o选项覆盖。
如果输入文件名只是-，ecpg从标准输入读取程序（并写入标准输出，除非用-o重写）。
这个参考页没有描述嵌入式 SQL 语言。关于该主题请参考第 34 章。
选项
ecpg接受以下命令行参数：
-c
从SQL代码自动生成某些C代码。目前，这适用于EXEC SQL TYPE。
-C mode
设置兼容模式。mode可以是INFORMIX，
INFORMIX_SE，或ORACLE。
-D symbol[=value]
定义一个预处理器符号，相当于EXEC SQL DEFINE指令。如果没有指定value，
则该符号将被定义为值1。
-h
处理头文件。当指定此选项时，输出文件扩展名变为.h而不是.c，
默认输入文件扩展名为.pgh而不是.pgc。此外，-c选项被强制打开。
-i
解析系统包含文件。
-I directory
指定一个额外的包含路径，用于查找通过EXEC SQL INCLUDE包含的文件。默认值为
.（当前目录），
/usr/local/include，
PostgreSQL包含目录，在编译时定义（默认值为：
/usr/local/pgsql/include），
/usr/include，按照这个顺序。
-o filename
指定ecpg应将所有输出写入给定的filename。
写入-o -以将所有输出发送到标准输出。
-r option
选择运行时行为。Option可以是以下之一：
no_indicator
不使用指示器，而是使用特殊值表示空值。历史上有一些数据库使用这种方法。
prepare
在使用之前准备所有语句。Libecpg将保留一个准备好的语句的缓存，并在再次执行时重用语句。如果缓存满了，libecpg将释放最少使用的语句。
questionmarks
允许问号作为占位符，出于兼容性原因。很久以前这曾经是默认设置。
-t
打开事务的自动提交。在此模式下，每个SQL命令都会自动提交，除非它在显式
事务块内。在默认模式下，只有在发出EXEC SQL COMMIT命令时才会提交命令。
-v
打印额外信息，包括版本和“include”路径。
--version
打印ecpg版本并退出。
-?--help
显示关于ecpg命令行参数的帮助信息，并退出。
注释
在编译预处理好的 C 代码文件时，编译器需要能够找到ECPG头文件在PostgreSQL包括目录中。因此，在调用编译器时，你可能必须使用-I选项（例如，-I/usr/local/pgsql/include）。
使用带有嵌入式 SQL 的 C 代码的程序必须链接到libecpg库，例如使用链接器选项-L/usr/local/pgsql/lib -lecpg。
适合于安装的这些目录的值可以使用 pg_config 找到。
示例
如果你有一个名为 prog1.pgc 的嵌入式 SQL C 源文件，你可以使用下列命令序列创建一个可执行程序：
ecpg prog1.pgc
cc -I/usr/local/pgsql/include -c prog1.c
cc -o prog1 prog1.o -L/usr/local/pgsql/lib -lecpg
上一页 上一级 下一页dropuser 起始页 pg_amcheck
