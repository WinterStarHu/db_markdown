# 1.8.1 MySQL 的贡献者_MySQL 8.0 参考手册

1.8.1 MySQL 的贡献者_MySQL 8.0 参考手册
Skip to Main Content
Documentation
MySQL手册
MySQL企业版
工作台
InnoDB集群
MySQL NDB集群
连接器
Section Menu:
Documentation Home
MySQL 8.0 参考手册
前言和法律声明
第一章 一般信息
1.1 关于本手册
1.2 MySQL数据库管理系统概述
1.3 MySQL 8.0 的新特性
1.4 MySQL 8.0 中添加、弃用或删除的服务器和状态变量和选项
1.5 MySQL信息源
1.6 如何报告错误或问题
1.7 MySQL 标准合规性
1.8 学分
1.8.1 MySQL 的贡献者1
1.8.2 记录员和翻译员1
1.8.3 支持MySQL的包1
1.8.4 用于创建MySQL的工具1
1.8.5 MySQL的支持者1
第 2 章安装和升级 MySQL
第 3 章教程
第 4 章 MySQL 程序
第 5 章 MySQL 服务器管理
第 6 章 安全
第 7 章备份与恢复
第8章优化
第9章语言结构
第 10 章字符集、排序规则、Unicode
第 11 章数据类型
第 12 章函数和运算符
第 13 章 SQL 语句
第14章MySQL数据字典
第 15 章 InnoDB 存储引擎
第 16 章替代存储引擎
第十七章复制
第十八章 组复制
第十九章MySQL Shell
第 20 章使用 MySQL 作为文档存储
第21章InnoDB Cluster
第 22 章 InnoDB 副本集
第 23 章 MySQL NDB Cluster 8.0
第24章分区
第25章存储对象
第 26 章 INFORMATION_SCHEMA 表
第 27 章 MySQL 性能模式
第 28 章 MySQL 系统模式
第 29 章连接器和 API
第30章MySQL企业版
第31章MySQL工作台
第 32 章 OCI 市场上的 MySQL
附录 A MySQL 8.0 常见问题解答
附录 B 错误信息和常见问题
附录 C 索引
MySQL 词汇表
MySQL 8.0 参考手册  / 第一章 一般信息  / 1.8 学分  /
1.8.1 MySQL 的贡献者
1.8.1 MySQL 的贡献者
尽管 Oracle Corporation 和/或其附属公司拥有MySQL server和
的所有版权MySQL manual，但我们希望表彰那些为 做出过各种贡献的人
MySQL distribution。此处列出了贡献者，顺序有点随机：
詹马西莫维加佐拉或
<qwerg@mbox.vol.it><qwerg@tin.it>
Win32/NT 的初始端口。
埃里克·奥尔森
对于动态记录格式的建设性批评和实际测试。
伊雷娜·潘西罗夫<irena@mail.yacc.it>
带有 Borland 编译器的 Win32 端口。
mysqlshutdown.exe和
mysqlwatch.exe。
戴维·J·休斯
为了努力制作一个共享软件 SQL 数据库。在 MySQL AB 的前身 TcX，我们从 开始
mSQL，但发现它不能满足我们的目的，所以我们改为为我们的应用程序构建器 Unireg 编写一个 SQL 接口。mysqladmin和
mysql client 是在很大程度上受其mSQL同行影响的程序。我们付出了很多努力使 MySQL 语法成为mSQL. 许多 API 的想法都是从 MySQL 借用的，mSQL以便于将自由mSQL程序移植到 MySQL API。MySQL 软件不包含来自
mSQL. 分布中的两个文件（client/insert_test.c和
client/select_test.c) 基于
mSQL发行版中相应的（非版权）文件，但作为示例进行了修改，显示了将代码从
mSQLMySQL Server 转换为 MySQL Server 所需的更改。（mSQL版权归 David J. Hughes 所有。）
帕特里克·林奇
帮助我们获得http://www.mysql.com/。
弗雷德·林德伯格
设置 qmail 来处理 MySQL 邮件列表，以及我们在管理 MySQL 邮件列表方面得到的难以置信的帮助。
伊戈尔·罗曼年科<igor@frog.kiev.ua>
mysqldump（以前
msqldump是 ，但由 Monty 移植和增强）。
尤里·达里奥
用于保持和扩展 MySQL OS/2 端口。
蒂姆邦斯
mysqlhotcopy
的作者。
扎尔科莫尼克<zarko.mocnik@dem.si>
斯洛文尼亚语排序。
“多米多”<tommy@valley.ne.jp>
字符集_MB宏和 ujis 和 sjis 字符集。
约书亚查马斯<joshua@chamas.com>
并发插入、扩展日期语法、NT 调试和 MySQL 邮件列表答复的基础。
伊夫·卡利尔<Yves.Carlier@rug.ac.be>
mysqlaccess，一个显示用户访问权限的程序。
Rhys Jones （和 GWE Technologies Limited）
<rhys@wales.com>
对于早期的 JDBC 驱动程序之一。
朱晓琨博士<X.Zhu@brad.ac.uk>
进一步开发一种早期的 JDBC 驱动程序和其他与 MySQL 相关的 Java 工具。
詹姆斯·库珀<pixel@organic.com>
在他的网站上建立一个可搜索的邮件列表档案。
里克·梅哈利克<Rick_Mehalick@i-o.com>
对于xmysql，MySQL 服务器的图形 X 客户端。
道格西斯克<sisk@wix.com>
用于为 Red Hat Linux 提供 MySQL 的 RPM 包。
迪曼德·亚历山大 V.<axeld@vial.ethz.ch>
用于为 Red Hat Linux-Alpha 提供 MySQL 的 RPM 包。
安东尼·帕米斯橄榄<toni@readysoft.es>
为 Intel 和 SPARC 提供了很多 MySQL 客户端的 RPM 版本。
杰伊布拉德沃思<jay@pathways.sde.state.sc.us>
用于为 MySQL 3.21 提供 RPM 版本。
戴维·萨塞多特<davids@secnet.com>
安全检查 DNS 主机名的想法。
陈维玖<jou@nematic.ieo.nctu.edu.tw>
一些支持中文（BIG5）字符。
何伟<hewei@mail.ied.ac.cn>
中文（GBK）字符集的很多功能。
扬·帕齐奥拉<adelton@fi.muni.cz>
捷克排序顺序。
泽夫苏拉斯基<bourbon@netvision.net.il>
FROM_UNIXTIME()时间格式、
ENCRYPT()函数和
野牛顾问。活跃的邮件列表成员。
卢克德波尔<luuk@wxs.nl>
将基准套件移植（并扩展）到
DBI/ DBD。crash-me对运行基准测试有很大帮助。一些新的日期函数。mysql_setpermission脚本
。
亚历克西斯·米哈伊洛夫<root@medinf.chuvashia.su>
可加载函数；CREATE
FUNCTION和DROP
FUNCTION。
安德烈亚斯·F·博巴克<bobak@relog.ch>
可加载函数的AGGREGATE扩展。
罗斯维克林<R.Wakelin@march.co.uk>
帮助为 MySQL-Win32 设置 InstallShield。
杰思罗赖特三世<jetman@li.net>
图书馆libmysql.dll。
詹姆斯佩雷利亚<jpereira@iafrica.com>
Mysqlmanager，一个用于管理 MySQL 服务器的 Win32 GUI 工具。
柯特桑普森<cjs@portal.ca>
将 MIT-pthreads 移植到 NetBSD/Alpha 和 NetBSD 1.3/i386。
马丁拉姆施<m.ramsch@computer.org>
MySQL 教程中的示例。
史蒂夫·哈维
为了使mysqlaccess更安全。
Konark IA-64 持久系统中心私人有限公司
帮助MySQL服务器的Win64端口。
阿尔伯特·秦雅扬。
配置 Tru64 更新、大文件支持和更好的 TCP 包装器支持。
约翰比瑞尔
OS/2的仿真pthread_mutex()。
本杰明·普夫格曼
扩展MERGE表来处理
INSERTS。MySQL 邮件列表中的活跃成员。
乔斯林富尼耶
出色的发现和报告无数错误（尤其是在 MySQL 4.1 子查询代码中）。
马克·利亚纳格
维护 OS X 包并提供有关如何创建 OS X 包的宝贵反馈。
罗伯特·卢瑟福
提供有关 QNX 端口的宝贵信息和反馈。
NDB Cluster 的前开发人员
很多人以各种方式参与了暑期学生、硕士论文学生、员工。总共有 100 多人，这里就不多说了。著名的名字是 Ataullah Dabaghi，直到 1999 年他贡献了大约三分之一的代码库。还要特别感谢 AX 系统的开发人员，他们为 NDB Cluster 提供了很多架构基础，包括块、信号和崩溃跟踪功能。还应赞扬那些相信这些想法足以为其从 1992 年至今的发展分配预算的人。
谷歌公司
我们希望感谢 Google Inc. 对 MySQL 发行版的贡献：Mark Callaghan 的 SMP Performance 补丁和其他补丁。
其他贡献者、漏洞发现者和测试者：James H. Thompson、Maurizio Menghini、Wojciech Tryc、Luca Berra、Zarko Mocnik、Wim Bonis、Elmar Haneke、Ted
Deppner
、
Mike Simons、Jaakko Hyvatti。
<jehamby@lightside><psmith@BayNetworks.com><duane@connect.com.au><ted@psyber.com>
还有很多来自邮件列表中的人的错误报告/补丁。
非常感谢那些帮助我们回答 MySQL 邮件列表问题的人：
丹尼尔科赫<dkoch@amcity.com>
设置。
卢克德波尔<luuk@wxs.nl>
基准问题。
蒂姆塞勒<tps@users.buoy.com>
DBD::mysql问题。
博伊德·林恩·格柏<gerberb@zenez.com>
SCO相关问题。
理查德·梅哈利克<RM186061@shellus.com>
xmysql-相关问题和基本安装问题。
泽夫苏拉斯基<bourbon@netvision.net.il>
Apache 模块配置问题（log & auth）、PHP 相关问题、SQL 语法相关问题和其他一般问题。
弗朗西斯科·古施<frankie@citel.upc.es>
一般的问题。
乔纳森·J·史密斯<jsmith@wtp.net>
有关 Linux、SQL 语法和其他可能需要一些工作的特定操作系统的问题。
戴维斯克拉<sklar@student.net>
从 PHP 和 Perl 使用 MySQL。
阿利斯泰尔麦克唐纳<A.MacDonald@uel.ac.uk>
灵活，可以处理 Linux，也许还可以处理 HP-UX。
约翰里昂<jlyon@imag.net>
关于在 Linux 系统上使用.rpm文件或从源代码编译安装 MySQL 的问题。
洛维德有限公司<lorvid@WOLFENET.com>
简单的计费/许可/支持/版权问题。
帕特里克谢里尔<patrick@coconet.com>
ODBC 和VisualC++ 接口问题。
兰迪哈蒙<rjharmon@uptimecomputers.com>
DBD,Linux,一些SQL语法问题。
© Mysql 中文网
