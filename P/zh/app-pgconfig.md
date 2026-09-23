# pg_config

pg_config
版本：
纠错本页面
搜索
目录导航
❮
❯
pg_configpg_config — 获取已安装的PostgreSQL版本的信息大纲pg_config [option...]描述
pg_config工具打印当前安装版本的PostgreSQL的配置参数。它的设计目的之一是便于想与PostgreSQL交互的软件包能够找到所需的头文件和库。
选项
要使用pg_config，提供一个或多个下列选项：
--bindir
打印用户可执行文件的位置。例如使用这个选项来寻找psql程序。这通常也是pg_config程序所在的位置。
--docdir
打印文档文件的位置。
--htmldir
打印 HTML 文档文件的位置。
--includedir
打印客户端接口的 C 头文件的位置。
--pkgincludedir
打印其他 C 头文件的位置。
--includedir-server
打印用于服务器编程的 C 头文件的位置。
--libdir
打印对象代码库的位置。
--pkglibdir
打印动态可载入模块的位置，或者服务器可能搜索它们的位置（其他架构独立数据文件可能也被安装在这个目录）。
--localedir
打印区域支持文件的位置（如果在PostgreSQL被编译时没有配置区域支持，这将是一个空字符串）。
--mandir
打印手册页的位置。
--sharedir
打印架构独立支持文件的位置。
--sysconfdir
打印系统范围配置文件的位置。
--pgxs
打印扩展 makefile 的位置。
--configure
打印当PostgreSQL被配置编译时给予configure脚本的选项。这可以被用来重新得到相同的配置，或者找出是哪个选项编译了一个二进制包（不过注意二进制包通常包含厂商相关的自定义补丁）。参见下面的例子。
--cc
打印用来编译PostgreSQL的CC变量值。这显示被使用的 C 编译器。
--cppflags
打印用来编译PostgreSQL的CPPFLAGS变量值。这显示在预处理时需要的 C 编译器开关（典型的是-I开关）。
--cflags
打印用来编译PostgreSQL的CFLAGS变量值。这显示被使用的 C 编译器开关。
--cflags_sl
打印用来编译PostgreSQL的CFLAGS_SL变量值。这显示被用来编译共享库的额外 C 编译器开关。
--ldflags
打印用来编译PostgreSQL的LDFLAGS变量值。这显示链接器开关。
--ldflags_ex
打印用来编译PostgreSQL的LDFLAGS_EX变量值。这只显示被用来编译可执行程序的链接器开关。
--ldflags_sl
打印用来编译PostgreSQL的LDFLAGS_SL变量值。这只显示被用来编译共享库的链接器开关。
--libs
打印用来编译PostgreSQL的LIBS变量值。这通常包含用于链接到PostgreSQL中的外部库的-l开关。
--version
打印PostgreSQL的版本。
-?--help
显示有关pg_config命令行参数的帮助并退出。
如果给定多于一个选项，将按照相同的顺序打印信息，每行一项。如果没有给定选项，将打印所有可用信息，并带有标签。
备注
选项--docdir、--pkgincludedir、
--localedir、--mandir、
--sharedir、--sysconfdir、
--cc、--cppflags、
--cflags、--cflags_sl、
--ldflags、--ldflags_sl和--libs在PostgreSQL 8.1被加入。选项--htmldir在PostgreSQL 8.4被加入。选项--ldflags_ex在PostgreSQL 9.0被加入。
示例
要重建当前 PostgreSQL 安装的编译配置，可以运行下列命令：
eval ./configure `pg_config --configure`
pg_config --configure的输出包含 shell 引号，这样带空格的参数可以被正确地表示。因此，为了得到正确的结果需要使用 eval。
上一页 上一级 下一页pg_combinebackup 起始页 pg_dump
