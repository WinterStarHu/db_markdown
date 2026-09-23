# 64.1. 通用WAL记录

64.1. 通用WAL记录
版本：
纠错本页面
搜索
目录导航
❮
❯
64.1. 通用WAL记录 #
虽然所有内置的WAL日志模块都有各自类型的WAL记录，但也有一种通用的WAL记录类型，
它以通用的方式描述页面的更改。
注意
通用WAL记录在逻辑解码期间被忽略。如果您的扩展需要逻辑解码，
考虑使用自定义WAL资源管理器。
构建通用WAL记录的API定义在access/generic_xlog.h中，实现在access/transam/generic_xlog.c中。
要使用通用WAL记录工具执行一次被WAL记录的数据更新，要遵循这些步骤：
state = GenericXLogStart(relation) — 为给定的关系构建一个通用WAL记录。
page = GenericXLogRegisterBuffer(state, buffer, flags)
— 注册一个要在当前的通用WAL记录中修改的缓冲区。这个函数会返回一个指针指向该缓冲区页面的一份临时拷贝，修改将会在该拷贝上进行（不要直接修改该缓冲区的内容）。第三个参数是适用于该操作的标志的位掩码。当前这类标志只有GENERIC_XLOG_FULL_IMAGE，它表示在WAL记录中应该包括一个完整页面镜像而不是增量更新。如果是新页面或者页面已经被完全重写，通常会设置这个标志。如果被WAL记录的动作需要修改多个页面，可以反复调用GenericXLogRegisterBuffer。
对包含在上一步中的页面镜像应用修改。
GenericXLogFinish(state) — 将更改应用到缓冲区并且发出通用WAL记录。
在上述步骤之间都可以调用GenericXLogAbort(state)取消WAL记录构造。这会丢弃所有对于页面镜像拷贝的更改。
在使用通用WAL记录功能时请注意以下几点：
不允许直接修改缓冲区！所有的修改必须在GenericXLogRegisterBuffer()取得的拷贝上完成。换句话说，制造通用WAL记录的代码不能为自己调用BufferGetPage()。不过，在合适的时间对缓冲区进行pin/unpin以及加锁/解锁仍然是调用者的责任。从GenericXLogRegisterBuffer()之前直到GenericXLogFinish()之后，每个目标上必须保持排他锁。
可以自由地混合注册缓冲区（步骤2）和页面镜像修改（步骤3），即两个步骤可以以任何顺序重复。记住注册缓冲区的顺序应该和重放时对它们加锁的顺序相同。
一个通用WAL记录能注册的缓冲区最大数量是MAX_GENERIC_XLOG_PAGES。如果超出这个限制将会抛出一个错误。
通用WAL假定要被修改的页面具有标准布局，特别是在pd_lower和pd_upper之间没有有用的数据。
由于正在修改缓冲区页面的拷贝，GenericXLogStart()不会开始临界区。因此可以在GenericXLogStart()和GenericXLogFinish()之间安全地进行内存分配、抛出错误等。唯一真正的临界区存在于GenericXLogFinish()内。还有，不需要担心在错误退出期间对GenericXLogAbort()的调用。
GenericXLogFinish()会负责标记缓冲区为脏并且设置它们的LSN。你不需要显式地做这些工作。
对于不做日志的关系，所有的事情都一样，不过不会发出实际的WAL记录。因此，对于不做日志的关系你通常不需要做任何显式的检查。
通用WAL重做函数将按照注册缓冲区的顺序对它们获得排他锁。在重做所有更改后，这些锁将按照同样的顺序被释放。
如果对一个已注册的缓冲区没有指定GENERIC_XLOG_FULL_IMAGE，通用WAL记录包含了新旧页面镜像之间的不同。这个不同是以逐字节比较的方式形成的。对于在页面内移动数据的情况来说这种方式不是很紧凑，未来可能会有改进。
上一页 上一级 下一页第 64 章 扩展的预写日志 起始页 64.2. 自定义WAL资源管理器
