# 31.4. TAP 测试

31.4. TAP 测试
版本：
纠错本页面
搜索
目录导航
❮
❯
31.4. TAP 测试 #31.4.1. 环境变量
很多测试，特别是src/bin下的客户端程序测试，使用 Perl 的
TAP 工具并且用Perl测试程序prove运行。你可以通过
设置make变量PROVE_FLAGS
向prove传递命令行选项，例如：
make -C src/bin check PROVE_FLAGS='--timer'
详见prove的手册页。
make变量PROVE_TESTS可用于定义一个空格分隔的列表，其中是调用prove来运行的指定测试子集的路径，这些测试子集将取代默认的t/*.pl，并且这些路径是相对于Makefile的。例如：
make check PROVE_TESTS='t/001_test1.pl t/003_test3.pl'
TAP测试需要Perl模块IPC::Run。
该模块可以从
CPAN
或操作系统包中获取。
它们还需要PostgreSQL
配置选项--enable-tap-tests。
一般来说，如果你执行make installcheck，TAP测试将测试之前安装的安装树中的可执行文件；
或者如果你执行make check，将从当前源构建新的本地安装树。
在这两种情况下，他们将初始化本地实例（数据目录），并在其中暂时运行服务器。 其中一些测试运行多个服务器。 因此，这些测试可能相当耗费资源。
重要的是要认识到TAP测试将启动测试服务器，即使你说make installcheck；这与传统的非TAP测试基础架构不同，在这种情况下它期望使用已经运行的测试服务器。
某些PostgreSQL子目录包含传统样式和TAP样式测试，这意味着make installcheck将产生来自临时服务器和已运行测试服务器的混合结果。
31.4.1. 环境变量 #
数据目录根据测试文件名命名，如果测试失败，将会保留。如果环境变量
PG_TEST_NOCLEAN被设置，数据目录将无论测试状态如何
都会被保留。例如，在运行pg_dump测试时，
无论测试结果如何都保留数据目录：
PG_TEST_NOCLEAN=1 make -C src/bin/pg_dump check
此环境变量还会阻止测试的临时目录被删除。
测试套件中的许多操作使用180秒的超时时间，这在较慢的主机上可能会导致
由于负载引起的超时。通过将环境变量PG_TEST_TIMEOUT_DEFAULT
设置为更高的值，可以更改默认值以避免这种情况。
上一页 上一级 下一页31.3. 变体比较文件 起始页 31.5. 测试覆盖检查
