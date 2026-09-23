# 36.18. 扩展构建基础设施

36.18. 扩展构建基础设施
版本：
纠错本页面
搜索
目录导航
❮
❯
36.18. 扩展构建基础设施 #
如果你正在考虑发布你的PostgreSQL扩展模块，为它们建立一个可移植的构建系统实在是相当困难。因此PostgreSQL安装为扩展提供了一种被称为PGXS构建基础设施，因此简单的扩展模块能够在一个已经安装的服务器上简单地编译。PGXS主要是为了包括 C 代码的扩展而设计，不过它也能用于纯 SQL 的扩展。注意PGXS并不想成为一种用于构建任何与PostgreSQL交互的软件的通用构建系统框架。它只是简单地把简单服务器扩展模块的公共构建规则自动化。对于更复杂的包，你可能需要编写你自己的构建系统。
要把PGXS基础设施用于你的扩展，你必须编写一个简单的 makefile。在这个 makefile 中，你需要设置一些变量并且把它们包括在全局的PGXS makefile 中。这里有一个例子，它构建一个名为isbn_issn的扩展模块，其中包括一个含有 C 代码的共享库、一个扩展控制文件、一个 SQL 脚本、一个包括文件（仅当其他模块可能需要通过调用而不是SQL访问这个扩展的函数时才需要）以及一个文档文件：
MODULES = isbn_issn
EXTENSION = isbn_issn
DATA = isbn_issn--1.0.sql
DOCS = README.isbn_issn
HEADERS_isbn_issn = isbn_issn.h
PG_CONFIG = pg_config
PGXS := $(shell $(PG_CONFIG) --pgxs)
include $(PGXS)
最后三行应该总是相同的。在这个文件的前面部分，你要对变量赋值或者增加自定义的make规则。
设置以下三个变量之一以指定构建内容：
MODULES #
从源文件中构建的共享库对象列表，具有相同的主干（不要在此列表中
包含库后缀）。
MODULE_big #
一个共享库可以从多个源文件构建
（在OBJS中列出目标文件）
PROGRAM #
一个可执行程序，用于构建
（在OBJS中列出目标文件）
以下变量也可以设置：
EXTENSION #
扩展名；对于每个名称，您必须提供一个
extension.control 文件，
该文件将被安装到
prefix/share/extension
MODULEDIR #
prefix/share的子目录，
用于安装DATA和DOCS文件
（如果未设置，默认值为extension，如果
EXTENSION已设置，
或contrib如果未设置）
DATA #
随机文件安装到prefix/share/$MODULEDIR
DATA_built #
随机文件安装到
prefix/share/$MODULEDIR，
这些文件需要先构建。
DATA_TSEARCH #
随机文件安装在
prefix/share/tsearch_data
DOCS #
随机文件安装在
prefix/doc/$MODULEDIR
HEADERSHEADERS_built #
要（可选地构建并）安装的文件位于
prefix/include/server/$MODULEDIR/$MODULE_big。
与DATA_built不同，HEADERS_built中的文件不会被
clean目标移除；如果你希望它们被移除，可以将它们添加到
EXTRA_CLEAN中，或者添加你自己的规则来完成此操作。
HEADERS_$MODULEHEADERS_built_$MODULE #
要安装的文件（如果指定，则在构建后）位于
prefix/include/server/$MODULEDIR/$MODULE
下，其中$MODULE必须是
MODULES或MODULE_big中使用的模块名称。
与DATA_built不同，HEADERS_built_$MODULE中的文件
不会被clean目标移除；如果你希望它们被移除，
也请将它们添加到EXTRA_CLEAN中，或者添加你自己的规则来完成此操作。
可以合法地对同一个模块同时使用这两个变量，或者任意组合，除非
在MODULES列表中有两个模块名称仅因存在
前缀built_而不同，这会导致歧义。在这种
（希望不太可能发生的）情况下，你应该只使用
HEADERS_built_$MODULE变量。
SCRIPTS #
脚本文件（不是二进制文件）安装到
prefix/bin
SCRIPTS_built #
将脚本文件（不是二进制文件）安装到
prefix/bin，
这些文件需要先进行构建。
REGRESS #
回归测试用例列表（不带后缀），详见下文
REGRESS_OPTS #
传递给pg_regress的附加开关
ISOLATION #
隔离测试用例列表，详见下文了解更多细节
ISOLATION_OPTS #
传递给pg_isolation_regress的附加开关
TAP_TESTS #
切换定义是否需要运行TAP测试，详见下文
NO_INSTALL #
不要定义install目标，这对于不需要安装其构建产物的测试模块
很有用。
NO_INSTALLCHECK #
不要定义installcheck目标，例如在测试需要特殊配置时很有用，或者
不使用pg_regress。
EXTRA_CLEAN #
在make clean中需要删除的额外文件
PG_CPPFLAGS #
将被添加到CPPFLAGS
PG_CFLAGS #
将被追加到CFLAGS
PG_CXXFLAGS #
将被追加到CXXFLAGS
PG_LDFLAGS #
将被添加到LDFLAGS之前
PG_LIBS #
将被添加到PROGRAM链接行
SHLIB_LINK #
将被添加到MODULE_big链接行
PG_CONFIG #
用于构建的pg_config程序的路径，适用于
PostgreSQL安装（通常只需使用
pg_config，以使用PATH中的第一个）。
把这个 makefile 作为Makefile放在保存你扩展的目录中。然后你可以执行make进行编译，并且接着make install来安装你的模块。默认情况下，该模块会为在你的PATH中找到的第一个pg_config程序所对应的PostgreSQL安装编译和安装。你可以通过在 makefile 中或者make命令行中设置PG_CONFIG指向另一个pg_config程序来使用一个不同的安装。
您可以通过在执行 make install 时设置 make 变量 prefix 来选择一个单独的目录前缀以安装扩展的文件，如下所示：
make install prefix=/usr/local/postgresql
这将把扩展控制和 SQL 文件安装到 /usr/local/postgresql/share，并将共享模块安装到 /usr/local/postgresql/lib。如果前缀不包含字符串 postgres 或 pgsql，例如：
make install prefix=/usr/local/extras
那么 postgresql 将被附加到目录名称中，将控制和 SQL 文件安装到 /usr/local/extras/share/postgresql/extension，并将共享模块安装到 /usr/local/extras/lib/postgresql。无论哪种方式，您都需要设置 extension_control_path 和 dynamic_library_path 以使 PostgreSQL 服务器能够找到这些文件：
extension_control_path = '/usr/local/extras/share/postgresql:$system'
dynamic_library_path = '/usr/local/extras/lib/postgresql:$libdir'
如果你想保持编译目录独立，你也可以在你的扩展所属的源代码树之外的目录中运行
make。 这个过程也被称为一个
VPATH
编译。下面是做法：
mkdir build_dir
cd build_dir
make -f /path/to/extension/source/tree/Makefile
make -f /path/to/extension/source/tree/Makefile install
此外，你可以以对核心代码所作的方式一样为 VPATH 设置一个目录。一种方式是使用核心脚本
config/prep_buildtree。一旦这样做，你可以这样设置
make变量VPATH：
make VPATH=/path/to/extension/source/tree
make VPATH=/path/to/extension/source/tree install
这个过程可以在很多种目录布局下工作。
列举在REGRESS变量中的脚本会被用来对你的扩展进行回归测试，回归测试可以在做完make install之后用make installcheck调用。要让这能够工作，你必须已经有一个运行着的PostgreSQL服务器。列举在REGRESS中的脚本文件必须在你扩展目录的名为sql/的子目录中出现。这些文件必须带有扩展.sql，但扩展不能被包括在 makefile 的REGRESS列表中。对每一个测试还应该在名为expected/的子目录中有一个包含预期输出的文件，它具有和脚本文件相同的词干并带有扩展.out。make installcheck会用psql执行每一个测试脚本，并且将得到结果输出与相应的预期输出比较。任何区别都将以diff -c格式写入到文件regression.diffs中。注意尝试运行一个不带预期文件的测试将被报告为“故障”，因此确保你拥有所有的预期文件。
ISOLATION变量中列出的脚本用于测试强调与模块并发会话的行为，可以在make install之后通过make installcheck 调用。
要实现这个工作，你必须有一个正在运行的PostgreSQL服务器。
ISOLATION中列出的脚本文件必须显示在扩展目录中名为 specs/的子目录中。
这些文件必须具备扩展名.spec，并且不得包含在 makefile 中的ISOLATION列表中。
对于每个测试，在名为expected/的子目录中还应该有一个包含预期输出的文件，并且具有相同的词干和扩展名 .out。
make installcheck执行每个测试脚本，并将结果输出与匹配的预期文件进行比较。
任何差异都将以diff -c的格式写入到output_iso/regression.diffs文件中。
请注意，尝试运行缺少其预期文件的测试将会报告“故障”，因此请确保你具有全部的预期文件。
TAP_TESTS 启用TAP测试。
每个运行中的数据都存在于名为 tmp_check/的子目录中。
更多详细信息，请参阅第 31.4 节
提示
创建预期文件最简单的方法是创建空文件，然后做一次测试运行（这当然将报告区别）。
检查在results/目录中找到的实际结果文件 (对于 REGRESS中的测试), 或output_iso/results/ 目录(对于ISOLATION)中的测试，如果它们符合你的预期则把它们复制到expected/中。
上一页 上一级 下一页36.17. 打包相关对象到扩展中 起始页 第 37 章 触发器
