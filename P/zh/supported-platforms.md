# 17.6. 平台支持

17.6. 平台支持
版本：
纠错本页面
搜索
目录导航
❮
❯
17.6. 平台支持 #
如果代码包含规定要工作在一个平台（即一种 CPU 架构和操作系统的结合）上并且它最近已经被验证能在该平台上编译并通过其回归测试，PostgreSQL开发社区才会认为该平台是被支持的。目前，大部分平台兼容性的测试都是由PostgreSQL 编译农场的测试机器自动完成的。如果你对在一个并没有出现在编译农场中的平台上运行PostgreSQL感兴趣，但是代码确实能够工作或者能被修改得工作，我们强烈鼓励你建立一个编译农场成员机器，这样进一步的兼容性可以被确认。
一般来说，PostgreSQL 可以在以下 CPU 架构上运行：
x86、PowerPC、S/390、SPARC、ARM、MIPS 和 RISC-V，包括
在适用的情况下的大端、小端、32 位和 64 位变体。
PostgreSQL 可以预期在以下操作系统的当前版本上运行：
Linux、Windows、FreeBSD、OpenBSD、NetBSD、DragonFlyBSD、macOS、Solaris 和 illumos。
其他类 Unix 系统也可能可用，但目前尚未进行测试。大多数情况下，
给定操作系统支持的所有 CPU 架构都能正常工作。请查看下面的
第 17.7 节，了解是否有针对您的操作系统的
具体信息，特别是如果您使用的是较旧的系统。
如果你在一个平台上有安装问题，并且该平台根据最近的编译农场结果已经可以被支持，请将问题报告给<pgsql-bugs@lists.postgresql.org>。如果你有兴趣将PostgreSQL移植到一个新的平台，<pgsql-hackers@lists.postgresql.org>是一个合适的讨论它的地方。
历史版本的 PostgreSQL 或 POSTGRES
也可以在包括 Alpha、Itanium、M32R、M68K、
M88K、NS32K、PA-RISC、SuperH 和 VAX 的 CPU 架构上运行，
以及包括 4.3BSD、AIX、BEOS、
BSD/OS、DG/UX、Dynix、HP-UX、IRIX、NeXTSTEP、QNX、SCO、SINIX、Sprite、SunOS、
Tru64 UNIX 和 ULTRIX 的操作系统上运行。
上一页 上一级 下一页17.5. 安装后设置 起始页 17.7. 平台特定说明
