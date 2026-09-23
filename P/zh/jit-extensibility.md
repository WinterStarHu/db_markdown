# 30.4. 可扩展性

30.4. 可扩展性
版本：
纠错本页面
搜索
目录导航
❮
❯
30.4. 可扩展性 #30.4.1. 对扩展的内联支持30.4.2. 可插拔的JIT提供者30.4.1. 对扩展的内联支持 #
PostgreSQL的JIT实现可以内联C和internal类型的函数体，以及基于这类函数的操作符。为了对扩展中的函数这样做，需要让那些函数的定义可用。在使用PGXS对一个已经编译有LLVM JIT支持的服务器构建一个扩展时，相关的文件将被自动构建并安装。
相关的文件必须被安装在$pkglibdir/bitcode/$extension/中，并且对它们的一份概要必须被安装在$pkglibdir/bitcode/$extension.index.bc中，其中$pkglibdir是pg_config --pkglibdir返回的目录，而$extension是扩展的共享库的基础名称。
注意
对于编译在PostgreSQL本身中的函数，其bitcode被安装在$pkglibdir/bitcode/postgres。
30.4.2. 可插拔的JIT提供者 #
PostgreSQL提供一种基于LLVM的JIT实现。JIT提供者的接口是可插拔的，可以无需重编译就能改变提供者（尽管当前构建过程仅提供了对LLVM的内联支持数据）。活跃的提供者通过设置jit_provider来选择。
30.4.2.1. JIT提供者接口 #
JIT提供者需要通过动态加载其共享库来载入。正常的搜索路径被用来定位该库。为了提供所要求的JIT提供者回调并且表示该库实际上是一个JIT提供者，它需要提供一个名为_PG_jit_provider_init的C函数。会有一个结构被传入这个函数，在函数中应该用回调函数指针来填充该结构：
struct JitProviderCallbacks
{
JitProviderResetAfterErrorCB reset_after_error;
JitProviderReleaseContextCB release_context;
JitProviderCompileExprCB compile_expr;
};
extern void _PG_jit_provider_init(JitProviderCallbacks *cb);
上一页 上一级 下一页30.3. 配置 起始页 第 31 章 回归测试
