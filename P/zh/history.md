# 2. PostgreSQL简史

2. PostgreSQL简史
版本：
纠错本页面
搜索
目录导航
❮
❯
2. PostgreSQL简史 #2.1. 伯克利POSTGRES项目2.2. Postgres952.3. PostgreSQL
现在被称为PostgreSQL的对象关系数据库管理系统源自加州大学伯克利分校编写的POSTGRES软件包。
经过数十年的发展，PostgreSQL现在是全球最先进的开源数据库。
这里提供的历史的另一种看法可以在 Dr. Joe Hellerstein 的论文 “Looking Back at Postgres” [hell18] 中找到。
2.1. 伯克利POSTGRES项目 #
由Michael Stonebraker教授领导的POSTGRES项目是由防务高级研究项目局（DARPA）、陆军研究办公室（ARO）、国家科学基金（NSF）以及ESL, Inc.共同赞助的。POSTGRES的实现始于1986年。该系统最初的概念详见[ston86]，最初的数据模型定义见[rowe87]。当时的规则系统设计在[ston87a]里描述。存储管理器的理论基础和体系结构在[ston87b]里有详细描述。
从那以后，POSTGRES经历了几次主要的版本更新。第一个“演示性”系统在1987年便可使用，并且在1988年的ACM-SIGMOD大会上展出。在1989年6月发布了版本1（见[ston90a]）给一些外部用户使用。为了回应用户对第一个规则系统（[ston89]）的批评，规则系统被重新设计（[ston90b]），在1990年6月发布了使用新规则系统的版本2。版本3在1991年出现，增加了多存储管理器的支持，并且改进了查询执行器、重写了规则系统。直到Postgres95发布前（见下文）的后续版本大多把工作都集中在移植性和可靠性上。
POSTGRES 已被用于实现许多不同的研究和生产应用。
这些包括：一个金融数据分析系统、一套喷气发动机性能监控软件、一个小行星跟踪数据库、
一个医疗信息数据库，以及几个地理信息系统。
POSTGRES 还被用作几所大学的教育工具。
最后，Illustra Information Technologies（后来并入
Informix，
现由 IBM 拥有）接手了代码并将其商业化。
1992 年底，POSTGRES 成为 Sequoia 2000 科学计算项目的主要数据管理器，
该项目在 [ston92] 中有所描述。
在 1993 年间，外部用户社区的数量几乎翻番。随着用户的增加， 用于源代码维护的时间日益增加并占用了太多本应该用于数据库研究的时间，为了减少支持的负担，伯克利的POSTGRES项目在版本 4.2 时正式终止。
2.2. Postgres95 #
在 1994 年，Andrew Yu 和 Jolly Chen 向POSTGRES中增加了 SQL 语言的解释器。并随后用新名字Postgres95将源代码发布到互联网上供大家使用， 成为最初POSTGRES伯克利代码的开源继承者。
Postgres95 代码完全符合 ANSI C，并且大小减少了 25%。许多内部更改提高了性能和可维护性。Postgres95 版本 1.0.x 在威斯康星基准测试中比 POSTGRES 版本 4.2 快约 30–50%。除了错误修复外，以下是主要增强功能：
查询语言 PostQUEL 被替换为 SQL（在服务器中实现）。 （接口库 libpq 是以 PostQUEL 命名的。）在 PostgreSQL（见下文）之前，不支持子查询，但可以在 Postgres95 中通过用户定义的 SQL 函数进行模拟。聚合函数被重新实现。还添加了对 GROUP BY 查询子句的支持。
提供了一个新程序 (psql) 用于交互式 SQL 查询，使用了 GNU Readline。这在很大程度上取代了旧的 monitor 程序。
一个新的前端库 libpgtcl 支持基于 Tcl 的客户端。一个示例 shell pgtclsh 提供了新的 Tcl 命令，以便将 Tcl 程序与 Postgres95 服务器接口。
大对象接口经过彻底改造。反转大对象是存储大对象的唯一机制。（反转文件系统被移除。）
实例级规则系统被移除。规则仍然作为重写规则可用。
随源代码分发了一个简短的教程，介绍常规 SQL 特性以及 Postgres95 的特性。
使用 GNU make（而不是 BSD make）进行构建。此外，Postgres95 可以使用未修补的 GCC 编译（双精度数据对齐已修复）。
2.3. PostgreSQL #
到了 1996 年， 很明显“Postgres95”这个名字已经跟不上时代了。于是我们选择了一个新名字PostgreSQL来反映与最初的POSTGRES和最新的具有SQL能力的版本之间的关系。同时版本号也从 6.0 开始， 将版本号放回到最初由伯克利POSTGRES项目开始的序列中。
Postgres 仍然被认为是一个官方项目名称，
既因为传统，也因为人们觉得发音 Postgres 比
PostgreSQL 更容易。
Postgres95的开发重点放在标识和理解后端代码的现有问题上。PostgreSQL的开发重点则转到了一些有争议的特性和功能上面，当然各个方面的工作同时都在进行。
自那时以来，每个 PostgreSQL 版本发生的详细信息可以在 https://www.postgresql.org/docs/release/ 找到。
上一页 上一级 下一页1. 何为PostgreSQL？ 起始页 3. 约定
