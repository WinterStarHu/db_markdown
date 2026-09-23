# 附录 M. 术语表

附录 M. 术语表
版本：
纠错本页面
搜索
目录导航
❮
❯
附录 M. 术语表
这是一个术语及其在PostgreSQL和一般关系数据库系统上下文中的含义的列表。
ACID
原子性,
一致性,
隔离性, 和
持久性.
这组数据库事务属性是为了保证并发操作的有效性，并且在发生错误、电源故障等情况下也是如此。
Aggregate function (routine)
一种结合(aggregates)多个输入值的函数，例如通过计数、平均或相加，产生一个输出值。
更多信息，请参见 第 9.21 节。
参见Window function (routine).Access Method
PostgreSQL使用的接口，用于访问表和索引中的数据。该抽象
允许添加对新类型数据存储的支持。
For more information, see 第 62 章 and
第 63 章.
Analytic function见Window function (routine).Analyze (operation)
从表和其他关系
中收集数据统计信息，以帮助查询规划器
决定如何执行查询的行为。
(不要把这个术语与ANALYZE选项
与EXPLAIN命令搞混淆。)
更多信息，请参见ANALYZE。
Asynchronous I/O (AIO)
异步 I/O (AIO) 描述了
以非阻塞方式（异步）执行 I/O，与
阻塞整个 I/O 持续时间的同步 I/O
相对。
使用 AIO，启动 I/O 操作
与等待操作结果是分开的，这允许
多个 I/O 操作同时启动，
以及与 I/O 同时执行
CPU 密集型操作。增加的并发性带来的代价是复杂性增加。
参见Input/Output.Atomic
关于 datum：
它的值不能被分解成更小的组件。
关于 数据库事务：
参见 原子性。
Atomicity
事务的一种属性，它的所有操作要么作为单个单元完成，要么不执行。
此外，如果在事务执行过程中发生了系统故障，恢复后不会看到部分结果。
这是ACID的属性之一。
Attribute
tuple中具有特定名称和数据类型的元素。
Autovacuum (process)
一组后台进程，定期执行vacuum和
analyze操作。
协调工作并始终存在（除非禁用自动清理）的辅助进程
被称为autovacuum launcher，
负责执行任务的进程被称为autovacuum workers。
更多信息，请参见 第 24.1.6 节。
Auxiliary process
一个实例中的进程，
负责该实例的一些特定后台任务。
辅助进程包括
autovacuum启动器
（但不包括autovacuum工作进程），
后台写入器，
检查点进程，
日志记录器，
启动进程，
WAL归档器，
WAL接收器
（但不包括WAL发送器），
WAL汇总器，
和WAL写入器。
Backend (process)
代表client session并处理其请求的实例进程。
(不要把这个词与类似的Background Worker或Background Writer搞混淆)。
Background worker (process)
实例中的进程，该进程运行系统或用户提供的代码。
作为PostgreSQL中的一些特性的基础架构，例如logical replication和parallel queries。
此外，Extensions可以添加自定义的后台工作者进程。
更多信息，请参见 第 46 章。
Background writer (process)
一个从共享内存中将脏
数据页写入文件系统的
辅助进程。它定期唤醒，
但只工作一小段时间，以便将其昂贵的I/O活动分散在时间上，
避免产生更大的I/O峰值，可能会阻塞其他进程。
更多信息，参见 第 19.4.4 节.
Base Backup
所有数据库集群
文件的二进制拷贝。 通过pg_basebackup工具生成。
它可以结合WAL文件作为恢复、日志传送或流式复制的起点。
Bloat
数据页中不包含当前行版本的空间，例如未使用(空闲)空间或过时的行版本。
Bootstrap superuser
第一个用户在
数据库集群中初始化。
此用户拥有每个数据库中所有系统目录表。它也是所有授予权限的来源角色。
因为这些原因，此角色不能被删除。
该角色也表现为一个普通的
数据库超级用户，
并且其超级用户状态无法被移除。
Buffer Access Strategy
一些操作会访问大量的
页面。一个
缓冲区访问策略有助于防止这些操作从
共享缓冲区中驱逐过多的页面。
缓冲区访问策略设置了对有限数量的
共享缓冲区的引用，
并循环重复使用它们。当操作需要一个新页面时，会从策略环中的缓冲区中
选择一个受害缓冲区，这可能需要将页面的脏数据刷新到永久存储中，
并可能还需要将未写入的
WAL刷新到永久存储。
缓冲区访问策略用于执行各种操作，例如对大型表的顺序扫描、
VACUUM、COPY、
CREATE TABLE AS SELECT、
ALTER TABLE、CREATE DATABASE、
CREATE INDEX和CLUSTER。
Cast
从当前数据类型到另一数据类型的datum的转换。
更多信息，参见 CREATE CAST。
Catalog
SQL标准使用这个术语来表示PostgreSQL术语中所谓的database。
(不要把这个术语与 system catalog搞混淆)。
更多信息，参见 第 22.1 节。
Check constraint
一种定义在 relation上的constraint类型，以限制一个或多个attributes中允许的值。
检查约束可以引用关系中的同一行的任何属性，但不能引用同一关系的其他行或
其他关系。
更多信息，参见 第 5.5 节.
Checkpoint
WAL序列中的一个点，在这个点上可以保证堆和索引数据文件已经被更新，包括所有来自在检查点之前被修改过的shared memory的信息；
一个checkpoint record被写入并刷新到WAL以标记该点。
检查点也是执行到达上述定义的检查点所需的所有操作的行为。
当满足预定义的条件时，如已经过了指定的时间，或者已写入了一定数量的记录，则启动此过程；也可以由用户通过命令CHECKPOINT来调用。
更多信息，参见 第 28.5 节。
Checkpointer (process)
一个负责执行检查点的辅助进程。
Class (archaic)见Relation.Client (process)
任何进程，可能是远程的，通过连接到实例以与数据库交互，从而建立会话。
Cluster owner
拥有数据目录的操作系统用户，
并且是运行postgres进程的用户。
在创建新的数据库集群之前，
必须确保该用户已存在。
在具有root用户的操作系统上，
该用户不被允许成为集群所有者。
Column
在表或视图中找到的属性。
Commit
在数据库中完成事务的行为，以使其他事务可见并确保其持久性。
更多信息，参见 COMMIT。
Concurrency
这个概念指在数据库中同时发生多个独立的操作。
在PostgreSQL中，并发性是由多版本并发控制机制来控制的。
Connection
客户端进程和后端进程之间的通信线路，通常是基于网络，支持会话。
这个术语有时用作会话的同义词。
更多信息，参见 第 19.3 节。
Consistency
数据库中的数据特性总是遵循完整性约束。
事务可能被允许短暂地违反一些约束，在提交之前，但如果在提交时这些违反没有得到解决，则该事务会自动回滚。
这是ACID属性之一。
Constraint
对表中允许的数据值或在域的属性中的限制。
更多信息，参见 第 5.5 节。
Cumulative Statistics System
一个系统，如果启用，会累积关于实例活动的统计信息。
更多信息，参见 第 27.2 节。
Data area见Data directory.Database
本地SQL对象的一个已命名的集合。
更多信息，参见 第 22.1 节。
Database cluster
一组数据库和全局SQL对象，以及它们的通用静态和动态元数据。
有时被称为集群。
数据库集群是使用initdb程序创建的。
在PostgreSQL中，术语集群有时也用来指一个实例。
(不要将这个术语与SQL命令CLUSTER混淆。)
另请参见集群所有者，
即集群的操作系统所有者，
以及引导超级用户，
即集群的PostgreSQL所有者。
Database server见Instance.Database superuser
拥有超级用户状态的角色
（参见第 21.2 节）。
通常被称为超级用户。
Data directory
server文件系统上的基本目录，包含与database cluster相关联的所有数据文件和子目录
(除了tablespaces和可选的WAL)。
环境变量PGDATA通常用于引用数据目录。
cluster的存储空间包括数据目录以及任何额外的表空间。
更多信息，参见 第 66.1 节。
Data page
用于存储关系数据的基本结构。所有页面大小相同。数据页通常存储在磁盘上，每个数据页都存储在一个特定的文件中，并且可以被读取到shared buffers，在那里它们可以被修改，变为脏的。
它们写入磁盘时变得干净。新页面，最初只存在于内存中，在写入之前也是脏的。
Datum
SQL数据类型的一个值的内部表示。
Delete
从给定table或relation中删除rows的SQL命令。
更多信息，参见 DELETE。
Domain
基于另一个基础数据类型的用户定义数据类型。
它的行为与基础类型相同，除了可能限制允许的值集合。
有关更多信息，请参见 第 8.18 节。
Durability
保证一旦事务被提交，即使在系统故障或崩溃后变更仍然存在。这是ACID的特性之一。
Epoch见Transaction ID.Extension
可以安装在实例上的附加软件包，以获得额外特性。
更多信息，参见 第 36.17 节。
File segment
存储给定关系的数据的一种物理文件。
文件段的大小受配置值的限制（通常为1千兆字节），所以如果一个关系超过这个大小，它就被分割成多个段。
更多信息，参见 第 66.1 节。
(不要将这个术语与相似的WAL segment混淆)。
Foreign data wrapper
表示本地database中不包含的数据的一种方式，使其看起来就像在本地table(s)中一样。
使用外部数据封装器，可以定义外部foreign server和foreign tables。
更多信息，参见 CREATE FOREIGN DATA WRAPPER。
Foreign key
一种定义在table中的一个或多个columns上的constraint类型，
它需要这些columns中的值标识另一个表中的零或一row(或者，偶尔是相同的)。
Foreign server
foreign tables的命名集合，它们都使用相同的foreign data wrapper，并具有其他共同的配置值。
更多信息，参见 CREATE SERVER。
Foreign table (relation)
一种relation，看起来拥有与常规table相似的rows和columns，
但将通过它的foreign data wrapper转发对数据的请求，
并将返回根据foreign table定义的结构化的result sets。
更多信息，参见CREATE FOREIGN TABLE。
Fork
在被存储的关系中的每个单独分段文件集。main fork是实际数据驻留的地方。
对于元数据还存在两个次要分支:free space map和visibility map。
Unlogged relations也有一个init fork。
Free space map (fork)
一种存储结构，用于保存关于表的主分支的每个数据页的元数据。
每个页面的空闲空间映射条目存储未来元组可用的空闲空间数量，并且是结构化的，可以高效地搜索给定大小的新元组的可用空间。
更多信息，参见 第 66.3 节。
Function (routine)
一种例程类型，它接收零个或更多参数，返回零个或更多输出值，并被限制在一个事务中运行。
函数被调用作为查询的一部分，例如通过SELECT。某些函数可以返回 sets;
这些被称为set-returning functions。
函数还可以用于triggers调用。
更多信息，参见 CREATE FUNCTION。
GMT见UTC.Grant
一个SQL命令，用于允许user或role访问database中的特定对象。
更多信息，参见 GRANT。
Heap
包含对于关系的row属性（例如数据）的值。
堆是在关系的main fork中的一个或多个file segments中实现的。
Host
与其他计算机通过网络通信的计算机。这有时被用作server的同义词。
它也用于指运行client processes的计算机。
Index (relation)
包含从table或materialized view中派生的数据的relation。
它的内部结构支持对原始数据的快速检索和访问。
更多信息，参见CREATE INDEX。
Incremental backup
一种特殊的基础备份，
对某些文件可能只包含自上次备份以来被修改的页面，而不是每个文件的全部内容。
与基础备份类似，它由工具pg_basebackup生成。
要恢复增量备份，使用工具pg_combinebackup，
它将增量备份与基础备份合并。之后，恢复可以使用
WAL将
数据库集群恢复到
一致状态。
For more information, see 第 25.3.3 节.
Input/Output (I/O)
输入/输出 (I/O) 描述了程序与外部设备之间的通信。
在数据库系统的上下文中，I/O 通常，但不局限于，
指与存储设备或网络的交互。
参见Asynchronous I/O.Insert
用于向表中添加新数据的SQL命令。
更多信息，参见 INSERT。
Instance
一组后端和
辅助进程
通过共享内存区域进行通信。一个
postmaster 进程
管理实例；一个实例管理着恰好一个
数据库集群
及其所有数据库。许多实例可以在同一台
服务器
上运行，只要它们的TCP端口不冲突。
实例处理DBMS的所有关键特性：读和写到文件以及共享内存，
确保ACID特性，连接到客户端进程，
特权验证，崩溃恢复，复制等等。
Isolation
在提交之前，事务的效果对并发事务不可见的属性。这是ACID的特性之一。
更多信息，参见 第 13.2 节。
Join
在查询中用于组合来自多个关系的数据的操作和SQL关键字。
Key
一种标识表或其他关系中的行的方法，
通过关系中一个或多个属性中包含的值。
Lock
允许进程限制或阻止对资源同时进行访问的一种机制。
Log file
日志文件包含关于事件的人类可读的文本行。示例包括登录失败、长时间运行的查询等。
更多信息，参见 第 24.3 节。
Logged
如果对表的更改被发送到WAL，则认为该表被记录。
默认情况下，所有常规表都被记录。可以将表指定为未记录，在创建时或通过ALTER TABLE命令。
Logger (process)
一个辅助进程，
如果启用，会将有关数据库事件的信息写入当前的
日志文件。
当达到特定的时间或容量标准时，会创建一个新的日志文件。
也称为syslogger。
更多信息，参见 第 19.8 节。
Logical replication cluster
一组发布者和订阅者实例，其中发布者实例
将更改复制到订阅者实例。
Log record
WAL record的古老术语。
Log sequence number (LSN)
字节偏移量位于WAL中，
随着每个新的WAL记录
单调递增。
如需了解更多信息，请参阅pg_lsn和第 28.6 节。
LSN见Log sequence number.Master (server)见Primary (server).Materialized
预先计算并存储一些信息的属性，以供以后使用，而不是在运行时计算。
这个术语在物化视图中使用，意思是从视图的查询中导出的数据并与该数据的来源分开存储在磁盘上。
这个术语也用于代指一些多步骤查询，表示执行给定步骤产生的数据存储在内存中（有溢出到磁盘的可能性），这样就可以通过另一个步骤多次读取数据。
Materialized view (relation)
由SELECT语句定义的一个关系
（就像一个视图），
但以与表相同的方式存储数据。
不能通过INSERT、UPDATE、
DELETE或MERGE操作修改它。
更多信息，参见CREATE MATERIALIZED VIEW。
Merge
一个SQL命令，用于使用源关系
中的数据，有条件地添加、修改或删除指定表
中的行。
有关更多信息，请参见MERGE。
Multi-version concurrency control (MVCC)
一种机制，用于允许多个事务读取和写入相同的行，而不会因一个进程导致其他进程停顿。
在PostgreSQL中，MVCC是通过在元组被修改时创建副本(版本)来实现的；在可以看到旧版本终止的事务之后，需要删除那些旧版本。
Null
不存在性（non-existence）的概念，是关系数据库理论的中心原则。它表示没有一个确定的值。
Optimizer见Query planner.Parallel query
处理执行部分查询的能力，以利用具有多个CPU的服务器上的并行进程。
Partition
大集合中的几个不相交（不重叠）的子集之一。
对分区表的引用：每个表都包含分区表的部分数据的表之一，称为父表。
分区本身是一个表，所以也可以直接查询；同时，分区有时可以是一个分区表，允许创建层次结构。
在查询中有关的窗口函数，
分区是一种用户定义的标准，它确定该函数可以考虑查询结果集的哪些邻近行。
Partitioned table (relation)
语义上与表相同的关系，但其存储分布在多个分区上。
Postmaster (process)
第一个过程是一个实例的过程。
它启动和管理辅助进程，
并根据需要创建后端进程。
更多信息，参见 第 18.3 节。
Primary key
在表或其他关系上定义的唯一约束的一种特殊情况，
它也保证主键内的所有属性不会有空值。
顾名思义，每个表只能有一个主键，但也可能有多个唯一的约束，这些约束也不支持空属性。
Primary (server)
当两个或多个数据库通过复制链接时，
被认为是权威信息源的服务器称为主服务器，也称为主控。
Procedure (routine)
一种例程。它们的特点是不返回值，并且允许它们执行如COMMIT 和 ROLLBACK这样的事务语句。它们是通过CALL命令调用的。
更多信息，参见 CREATE PROCEDURE。
Query
客户端向后端发送的请求，通常用于返回结果或修改数据库上的数据。
Query planner
PostgreSQL中用于确定(规划)执行查询的最有效方法的部分。
也称为查询优化器、优化器或简称为规划器。
Record见Tuple.Recycling见WAL file.Referential integrity
通过外键限制一个关系中的数据的一种方法，
使它在另一个关系中必须有匹配的数据。
Relation
数据库中所有对象的通用术语，有名称和以特定顺序定义的属性列表。
表,序列,
视图,外部表,
物化视图、复合类型和索引都是关系。
更通用的来说，关系是一组元组；例如，查询的结果也是一个关系。
在PostgreSQL中，类是关系的古老同义词。
Replica (server)
与主数据库配对并维护主数据库部分或全部数据副本的数据库。
这样做的最主要的原因是允许对该数据进行更大的访问，并在主服务器不可用时保持数据的可用性。
Replication
将一台服务器上的数据复制到另一台服务器上的行为称为副本。
这可以采用物理复制的形式，其中一个服务器上的所有文件更改都是逐字复制的，或者是逻辑复制，其中已定义的数据更改子集使用更高层次的表示来传递。
Restartpoint
一种在检查点的变体，
在副本上执行。
如需更多信息，请参阅第 28.5 节。
Result set
一个关系从一个
后端进程传输到一个客户端，
通常是在一个SQL命令完成时传输，通常是一个
SELECT，但如果指定了RETURNING子句，
也可以是INSERT、UPDATE、
DELETE或MERGE命令。
结果集是一个关系这一事实意味着一个查询可以用于另一个查询的定义，成为一个subquery。
Revoke
用于防止指定角色列表对指定数据库对象集的访问的命令。
更多信息，参见 REVOKE。
Role
实例的访问权限的集合。角色本身是可以授予其他角色的特权。
当多个用户需要相同的特权时，这样做通常是为了方便或确保完整性。
更多信息，参见 CREATE ROLE。
Rollback
撤销自事务开始以来执行的所有操作的命令。
更多信息，参见 ROLLBACK。
Routine
存储在数据库系统中可被调用以执行的一组已定义的指令集合。例程可以用多种编程语言编写。
例程可以是functions(包括返回集的函数和trigger functions)、aggregate functions和procedures。
PostgreSQL自身已经定义了许多例程，但是也可以添加用户定义的例程。
Row见Tuple.Savepoint
transaction中步骤序列中的特殊标记。在此时间点之后的数据修改可能会被恢复到保存点的时间。
更多信息，参见 SAVEPOINT。
Schema
模式是SQL objects的名称空间，这些对象都驻留在同一个database中。
每个SQL对象必须确切地驻留在一个模式中。
所有系统定义的SQL对象都驻留在模式pg_catalog中。
更通用地，术语模式用来表示给定数据库或其子集的所有数据描述（表定义，约束，注释等）。
更多信息，参见 第 5.10 节。
Segment见File segment.Select
用于从数据库请求数据的SQL命令。
通常，SELECT命令不会以任何方式修改数据库，但是查询中调用的函数可能会产生修改数据的作用。
更多信息，参见 SELECT。
Sequence (relation)
一种用于生成值的关系类型。通常生成的值是连续的非重复的数字。它们通常用于生成替代的主键值。
Server
运行PostgreSQL实例的计算机。术语服务器表示实际硬件、容器或虚拟机。
这个术语有时用于指实例或主机。
Session
允许客户端和后端进行交互的状态，通过连接通信。
Shared memory
由实例的公共进程使用的RAM。
它可以镜像部分数据库文件，为WAL记录提供一个临时区域，并存储其他公共信息。注意，共享内存属于整个实例，而不是单个数据库。
共享内存中最大的部分称为共享缓冲区，用于镜像组成页面的部分数据文件。
当页面被修改时，它被称为脏页面，直到它被写回文件系统。
更多信息，参见 第 19.4.1 节。
SQL object
任何可以使用CREATE命令创建的对象。大多数对象都特定于一个数据库，通常称为本地对象。
大多数本地对象都属于它们所被包含的数据库中的特定schema，比如关系(所有类型)、例程(所有类型)、数据类型等。
同一模式中相同类型的对象的名称是强制性要求唯一的。
也存在不属于模式的本地对象;一些例子是扩展、数据类型转换和外部数据包装器。
数据库中相同类型的对象的名称必须是唯一的。
其他对象类型，如角色、表空间、复制源、逻辑复制的订阅和数据库本身都不是本地SQL对象，因为它们完全存在于任何特定的数据库之外;
它们被称为全局对象。在整个数据库集群中这些对象的名称必须是唯一的。
更多信息，参见 第 22.1 节。
SQL standard
定义SQL语言的一系列文档。
Standby (server)见Replica (server).Startup process
一个在崩溃恢复期间和在一个物理副本中重放WAL的
辅助进程。
(该名称是历史性的：在实现复制之前，启动过程就已命名；该名称指的是其在服务器崩溃后重新启动时的任务。)
Superuser
在本文档中使用时，它是
数据库超级用户
的同义词。
System catalog
tables的集合，描述了实例的所有SQL objects的结构。
系统目录位于pg_catalog模式中。这些表包含内部表示的数据，并且通常不被认为对用户检查有用；
许多用户友好的views，也在pg_catalog模式中，提供了对其中一些信息的更方便的访问，而在模式information_schema（参见 第 35 章）中存在其他表和视图，它们公开了SQL standard规定的一些相同和额外的信息。
更多信息，参见 第 5.10 节。
Table
具有公共数据结构的tuples集合（相同数量的attributes、以同样的顺序、每个位置具有相同的名称和类型）。表是PostgreSQL中最常见的relation形式。
更多信息，参见 CREATE TABLE。
Tablespace
服务器文件系统上的一个已命名位置。所有需要在它们的system catalog中定义上面存储的SQL objects必须属于单个表空间。
最初，一个数据库集群包含一个可用的表空间，它被用作所有SQL对象的默认表空间，称为pg_default。
更多信息，参见 第 22.6 节。
Temporary table
在session或transaction的生命周期内存在的表，如创建时指定的那样。
其中的数据对其他会话是不可见的，并且不会被记录。临时表经常用于存储多步骤操作的中间数据。
更多信息，参见 CREATE TABLE。
TOAST
一种将表行的大型属性分割并存储在辅助表中的机制，该表被称为TOAST table。每个具有大型属性的关系都有自己的TOAST表。
更多信息，参见 第 66.2 节。
Transaction
必须作为单个原子命令的命令组合:它们都作为单个单元成功或失败，并且它们的效果对其他会话是不可见的，直到事务完成，甚至更晚，这取决于隔离级别。
更多信息，参见 第 13.2 节。
Transaction ID
每个事务在首次引起数据库修改时都会收到一个数值的、唯一的、按顺序分配的标识符。
通常缩写为xid。
当存储在磁盘上时，xid 仅为 32 位宽，因此只能生成大约四十亿个写事务 ID；
为了使系统运行时间超过这个限制，
使用了epochs，它们也是 32 位宽。
当计数器达到最大 xid 值时，它会从3重新开始
（该值以下的值是保留的），并且 epoch 值会增加 1。
在某些上下文中，epoch 和 xid 值
被一起视为一个 64 位的值；有关更多详细信息，请参见第 67.1 节。
更多信息，参见 第 8.19 节。
Transactions per second (TPS)
每秒执行的平均事务数，在测量运行的所有活动会话中合计。这是用来衡量实例的性能特性。
Trigger
当某个操作(INSERT, UPDATE, DELETE, TRUNCATE)应用于某个relation时，可以被定义执行的function。
触发器与调用它的语句在同一个transaction中执行，如果函数失败，则调用语句也失败。
更多信息，参见 CREATE TRIGGER。
Tuple
按固定顺序排列的attributes集合。
该顺序可以由包含元组的table(或其他relation)定义，
在这种情况下，元组通常被称为一row。它也可以由结果集的结构定义，在这种情况下，它有时被称为record。
Unique constraint
一种在relation上定义的constraint，
其限制的值允许在一个列或列的组合中，以便每个值或值的组合在关系中只能出现一次，也就是说，没有其他关系中的行包含与之相等的值。
因为null values不被认为是相等的，所以允许在不违反唯一约束的情况下存在多个空值行。
Unlogged
某些relations的性质，即它们的变化没有反映在WAL中。这将禁用这些关系的复制和崩溃恢复。
非日志表的主要用途是存储必须跨进程共享的临时工作数据。
Temporary tables
总是未记录的。
Update
用于修改指定table中可能已经存在的rows的SQL命令。它不能创建或删除行。
更多信息，参见
UPDATE.
User
一个具有角色的
登录权限
（参见第 21.2 节）。
User mapping
将本地database中的登录凭据转换为由foreign data wrapper定义的远程数据系统中的凭据。
更多信息，参见
CREATE USER MAPPING.
UTC
协调世界时，主要的全球时间参考，
大约是零经线上的时间。
通常但不准确地被称为GMT（格林尼治标准时间）。
Vacuum
从表或物化视图中删除过时的tuple versions的过程，以及MVCC的PostgreSQL实现所需的其他密切相关的处理过程。
这可以通过使用VACUUM命令来启动，但是也可以通过autovacuum进程自动处理。
更多信息，参见第 24.1 节。
View
由SELECT语句定义的relation，但没有自己的存储空间。
每当查询引用视图时，视图的定义就会被替换到查询中，就好像用户输入它作为子查询而不是视图的名称。
更多信息，参见CREATE VIEW。
Visibility map (fork)
一种存储结构，用于保存表的主分支的每个数据页的元数据。
每个页面的可视性映射条目存储两个比特：第一个(all-visible)表示页面中的所有元组对所有事务都可见。
第二个(all-frozen)表示页面中的所有元组都标记为冻结。
WAL见Write-ahead log.WAL archiver (process)
一个辅助进程，
如果启用，会保存WAL文件的副本，
以便创建备份或保持副本的最新状态。
更多信息，参见第 25.3 节。
WAL file
又称WAL segment或WAL segment file。为WAL提供存储空间的每个按顺序编号的文件。
这些文件都具有相同的预定义大小，并且是按顺序写入的，当它们在多个同时发生的会话中发生时，会将更改穿插在其中。
如果系统崩溃，则按顺序读取文件，并重现每个更改，以将系统恢复到崩溃前的状态。
当checkpoint把每个WAL文件的所有修改写入相应的数据文件后，就可以释放每个WAL文件。
释放文件可以通过删除它，也可以通过更改它的名称以便将来使用，这被称为recycling。
更多信息，参见第 28.6 节。
WAL record
对单个数据更改的低级描述。它包含足够的信息，以便数据更改可以被重新执行(replayed)，在系统故障导致更改丢失的情况下。
WAL记录使用不可打印的二进制格式。
更多信息，参见第 28.6 节。
WAL receiver (process)
一个在副本
上运行的辅助进程，用于接收来自
主服务器的WAL，以便由
启动进程进行重放。
有关更多信息，请参见
第 26.2 节。
WAL segment见WAL file.WAL sender (process)
一个特殊的后端进程
可以通过网络流式传输WAL。接收端可以是一个
WAL接收器
在一个副本,
pg_receivewal，或任何其他支持复制协议的客户端程序。
WAL summarizer (process)
一个辅助进程
用于汇总WAL数据以进行
增量备份。
有关更多信息，请参见 第 19.5.7 节。
WAL writer (process)
一个辅助进程
用于将WAL 记录
从共享内存写入到
WAL 文件中。
更多信息，参见
第 19.5 节。
Window function (routine)
在查询中使用的一种函数，
用于应用于查询的结果集的一个分区;
该函数的结果基于在相同分区或框架的行中找到的值。
所有聚合函数都可以用作窗口函数，但是窗口函数也可以用来给分区中的每一行排名。也称为分析函数。
更多信息，参见第 3.5 节。
Write-ahead log
当用户和系统调用操作发生时，跟踪数据库集群中的更改的日志。
它包含许多顺序写入WAL 文件的独立WAL 记录。
上一页 上一级 下一页附录 L. 首字母缩写 起始页 附录 N. 颜色支持
