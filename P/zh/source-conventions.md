# 55.4. 其他编码规范

55.4. 其他编码规范
版本：
纠错本页面
搜索
目录导航
❮
❯
55.4. 其他编码规范 #C 标准 #
PostgreSQL中的代码应该只依赖于 C99 标准中的语言特性。这意味着遵循 C99 的编译器一定能编译 postgres，至少除开少数平台依赖的部分。
目前，C99 标准中包含的一些特性，不允许用于核心 PostgreSQL 代码。
这当前包括可变长度数组、混合声明和代码、// 注释、通用字符名称。原因包括可移植性和历史实践。
如果提供了回退，则可以使用 C 标准或编译器后续版本中的特性。
例如当前使用的 _Static_assert() 和 __builtin_constant_p，即使它们分别来自 C 标准的更新修订和 GCC 扩展。
如果没有，我们分别回退到 C99 兼容替换来执行相同的检查，但会发出相当神秘的消息，并且不使用 __builtin_constant_p。
类函数宏和内联函数 #
带参数的宏和static inline函数都可以使用。如果在宏中存在多次评估的风险，
则后者更可取，例如，像下面这样写一个宏的情况：
#define Max(x, y)       ((x) > (y) ? (x) : (y))
或者当宏会非常长时。在其他情况下，只能使用宏，或者至少更容易。例如，因为需要将各种类型的表达式传递给宏。
当一个内联函数的定义引用只在后端中可用的符号（即变量、函数）时，从前端代码引用该函数时该函数可能不可见。
#ifndef FRONTEND
static inline MemoryContext
MemoryContextSwitchTo(MemoryContext context)
{
MemoryContext old = CurrentMemoryContext;
CurrentMemoryContext = context;
return old;
}
#endif   /* FRONTEND */
在这个例子中，CurrentMemoryContext 只在后端中可用，但该函数引用了它并且该函数因此被 #ifndef FRONTEND 隐藏。之所以存在这条规则，是因为即使内联函数中包含的符号没有被使用，有些编译器也会发出对它们的引用。
编写信号处理程序 #
为了适合在信号处理程序中运行，代码必须被非常仔细地编写。根本问题是，除非被阻塞，信号处理程序能在任何时候打断代码。如果信号处理程序内部的代码使用和外部代码相同的状态，很可能会出现混乱。例如，可以想想如果一个信号处理程序试图获取已经在被打断代码中持有的锁时会发生什么。
除特殊安排的代码之外，在信号处理程序中只应该调用对异步信号安全的函数（如 POSIX 中定义的那样）并且只访问volatile sig_atomic_t类型的变量。一些postgres中的函数也被视作是信号安全的，其中很重要的一个是SetLatch()。
在大多数情况下，信号处理程序应该仅仅记录信号已到达，并使用闩锁唤醒处理程序外部运行的代码。这样的处理程序示例如下：
static void
handle_sighup(SIGNAL_ARGS)
{
got_SIGHUP = true;
SetLatch(MyLatch);
}
调用函数指针 #
为了清晰，如果函数指针是一个简单的变量，在调用指向的函数时显式地对其解除引用会更好。例如：
(*emit_log_hook) (edata);
（虽然emit_log_hook(edata)也会有效）。当函数指针是一个结构的组成部分时，则额外的标点符号可以被省略并且通常也应该被省略，例如：
paramInfo->paramFetch(paramInfo, paramId);
上一页 上一级 下一页55.3. 错误消息风格指南 起始页 第 56 章 本地语言支持
