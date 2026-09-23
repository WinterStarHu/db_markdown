# 31.5. 测试覆盖检查

31.5. 测试覆盖检查
版本：
纠错本页面
搜索
目录导航
❮
❯
31.5. 测试覆盖检查 #31.5.1. 使用Autoconf和Make进行覆盖率分析31.5.2. 使用Meson进行覆盖率分析
PostgreSQL源代码可以通过覆盖率测试工具进行编译，从而可以检查哪些
代码部分被回归测试或任何其他测试套件覆盖。目前，这在使用GCC编译时
是支持的，并且需要安装gcov和lcov
软件包。
31.5.1. 使用Autoconf和Make进行覆盖率分析 #
一个典型的工作流程如下：
./configure --enable-coverage ... OTHER OPTIONS ...
make
make check # or other test suite
make coverage-html
然后在你的HTML浏览器中打开
coverage/index.html。
如果您没有lcov，或者更喜欢文本输出而不是HTML报告，
您可以运行
make coverage
来代替make coverage-html，这将为每个与测试相关的源文件
生成.gcov输出文件。（make coverage和
make coverage-html会覆盖彼此的文件，因此混用可能会
令人困惑。）
您可以在生成覆盖率报告之前运行几种不同的测试；
执行计数将会累积。如果您希望在测试运行之间重置执行计数，请运行：
make coverage-clean
您可以在子目录中运行make coverage-html或make
coverage命令，如果您只想要代码树的一部分的覆盖率报告。
使用make distclean来清理完成后的内容。
31.5.2. 使用Meson进行覆盖率分析 #
一个典型的工作流程如下：
meson setup -Db_coverage=true ... OTHER OPTIONS ... builddir/
meson compile -C builddir/
meson test -C builddir/
cd builddir/
ninja coverage-html
然后将您的HTML浏览器指向
./meson-logs/coveragereport/index.html。
在生成覆盖率报告之前，您可以运行几种不同的测试；执行计数将累积。
上一页 上一级 下一页31.4. TAP 测试 起始页 部分 IV. 客户端接口
