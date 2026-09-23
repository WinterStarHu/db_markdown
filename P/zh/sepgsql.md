# F.40. sepgsql — 基于SELinux标签的强制访问控制（MAC）安全模块

F.40. sepgsql — 基于SELinux标签的强制访问控制（MAC）安全模块
版本：
纠错本页面
搜索
目录导航
❮
❯
F.40. sepgsql —
基于SELinux标签的强制访问控制（MAC）安全模块 #F.40.1. 概述F.40.2. 安装F.40.3. 回归测试F.40.4. GUC 参数F.40.5. 特性F.40.6. sepgsql 函数F.40.7. 限制F.40.8. 外部资源F.40.9. 作者
sepgsql是一个基于SELinux安全策略的
支持标签的强制访问控制（MAC）模块。
警告
当前的实现具有明显的限制，并且不支持对所有操作的强制访问控制。详见
第 F.40.7 节。
F.40.1. 概述 #
这个模块与SELinux集成在一起，在
PostgreSQL提供的安全检查之上提供了一个
额外的安全检查层。从SELinux的角度来看，这个模块允许
PostgreSQL作为一个用户空间对象管理器。
对每一次由 DML 查询发起的表或者函数访问将根据系统安全策略进行检查。这种
检查是在PostgreSQL执行的常规 SQL 权限
检查之外进行的。
SELinux访问控制决定是通过使用安全标签
来做出的，安全标签使用system_u:object_r:sepgsql_table_t:s0
这样的字符串表示。每个访问控制决定涉及两个标签：尝试执行该动作的主体的
标签以及要在其上执行该动作的对象的标签。由于这些标签可以被应用于任何种
类的对象，对于存储在数据库中的对象的（用这个模块做出的）访问控制决定服
从于用于任意其他类型对象（例如文件）的同一种一般准则。这种设计是为了允
许一种中央安全策略来保护信息资产，而不依赖于这些资产是如何存储的。
SECURITY LABEL语句允许为一个数据库对象分配安全标签。
F.40.2. 安装 #
sepgsql只能在启用了
SELinux的
Linux 2.6.28 或更高版本上使用。在任何
其他平台上都无法使用这个模块。你还需要
libselinux 2.1.10 或更高版本以及
selinux-policy 3.9.13 或更高版本（尽管某些发行版可能
将必要的规则逆向移植到较老的策略版本中）。
你可以使用sestatus命令检查
SELinux的状态。一种典型的显示是：
$ sestatus
SELinux status:                 enabled
SELinuxfs mount:                /selinux
Current mode:                   enforcing
Mode from config file:          enforcing
Policy version:                 24
Policy from config file:        targeted
如果没有安装或者启用SELinux，你就必须在安装这个模块
之前先安装或者启用它。
要构建此模块，请指定 --with-selinux（使用 make 和 autoconf 时）或 -Dselinux={ auto | enabled | disabled }（使用 meson 时）。
确保在构建时安装了 libselinux-devel RPM。
要使用这个模块，你必须在postgresql.conf文件中的
shared_preload_libraries参数里包括
sepgsql。如果以其他任何方式加载该模块，它将无法正确地工作。
一旦该模块被加载，你应该在每一个数据库中执行
sepgsql.sql。这将安装安全标签管理所需的函数
并分配初始的安全标签。
这里有一个展示如何用sepgsql函数和安全标签初始化一个新
数据库集簇的例子（根据你的安装调整其中的路径）：
$ export PGDATA=/path/to/data/directory
$ initdb
$ vi $PGDATA/postgresql.conf
change
#shared_preload_libraries = ''                # (change requires restart)
to
shared_preload_libraries = 'sepgsql'          # (change requires restart)
$ for DBNAME in template0 template1 postgres; do
postgres --single -F -c exit_on_error=true $DBNAME \
</usr/local/pgsql/share/contrib/sepgsql.sql >/dev/null
done
请注意，如果你具有特定版本的libselinux和
selinux-policy，你可能会看到下列提示中的一些或全部：
/etc/selinux/targeted/contexts/sepgsql_contexts:  line 33 has invalid object type db_blobs
/etc/selinux/targeted/contexts/sepgsql_contexts:  line 36 has invalid object type db_language
/etc/selinux/targeted/contexts/sepgsql_contexts:  line 37 has invalid object type db_language
/etc/selinux/targeted/contexts/sepgsql_contexts:  line 38 has invalid object type db_language
/etc/selinux/targeted/contexts/sepgsql_contexts:  line 39 has invalid object type db_language
/etc/selinux/targeted/contexts/sepgsql_contexts:  line 40 has invalid object type db_language
这些消息是无害的并且应该被忽略。
如果该安装过程完成时没有出现错误，就可以正常启动服务器。
F.40.3. 回归测试 #
如果 PG_TEST_EXTRA 包含 sepgsql，则会运行
sepgsql 测试套件（参见 第 31.1.3 节）。
这种方法适用于 PostgreSQL 的开发阶段。
另外，还有一种方法可以运行测试，以检查数据库实例是否已
正确设置为 sepgsql。
由于 SELinux 的特性，运行 sepgsql
的回归测试需要几个额外的配置步骤，其中一些步骤必须以 root 身份执行。
手动测试必须在配置好的 PostgreSQL 构建树的 contrib/sepgsql
目录中运行。尽管它们需要构建树，但测试旨在针对已安装的服务器执行，
也就是说，它们与 make installcheck 相当，而不是
make check。
首先，根据 第 F.40.2 节 中的指导在一个工作数据库中设置
sepgsql。注意当前操作系统用户必须能够不使用密码认证作为
超级用户连接到该数据库。
第二，为该回归测试编译和安装策略包。sepgsql-regtest 策略是一个
特殊的策略包，它提供一组在回归测试中要被允许的规则。它应该从策略源文件
sepgsql-regtest.te 编译，这需要通过使用
make 和一个 SELinux 提供的 Makefile 完成。你将需要
在你自己的系统上找到合适的 Makefile，下面展示的路径只是一个例子。
（这个 Makefile 通常由 selinux-policy-devel 或
selinux-policy RPM 提供。）一旦编译好，
使用 semodule 命令安装这个策略包，它会把所提供的策略包载入到
内核中。如果该包被正确地安装，semodule -l 应该把
sepgsql-regtest 列成一个可用的策略包：
$ cd .../contrib/sepgsql
$ make -f /usr/share/selinux/devel/Makefile
$ sudo semodule -u sepgsql-regtest.pp
$ sudo semodule -l | grep sepgsql
sepgsql-regtest 1.07
第三，打开sepgsql_regression_test_mode。由于安全原因，
sepgsql-regtest中的规则默认没有被启用。
sepgsql_regression_test_mode参数会启用启动该回归
测试所需的规则。它可以使用setsebool命令来启用：
$ sudo setsebool sepgsql_regression_test_mode on
$ getsebool sepgsql_regression_test_mode
sepgsql_regression_test_mode --> on
第四，验证你的 shell 在unconfined_t域中操作：
$ id -Z
unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023
如果有必要，可以参考第 F.40.8 节来调整你的
工作域。
最后，运行该回归测试脚本：
$ ./test_sepgsql
这个脚本将尝试验证你已经正确地完成了所有的配置步骤，接下来它将运行
sepgsql模块的回归测试。
完成测试后，推荐你禁用
sepgsql_regression_test_mode 参数：
$ sudo setsebool sepgsql_regression_test_mode off
你可能想要完全移除 sepgsql-regtest 策略：
$ sudo semodule -r sepgsql-regtest
F.40.4. GUC 参数 #
sepgsql.permissive (boolean)
#
不管系统设置如何，这个参数让 sepgsql 在宽松模式中运行。
默认值为关闭。这个参数只能在 postgresql.conf
文件中或者服务器命令行上被设置。
当这个参数为开启时，sepgsql 在宽松模式中运行，即便
SELinux 运行在强制模式中也是如此。这个参数主要用于测试目的。
sepgsql.debug_audit (boolean)
#
这个参数启用打印审计消息，而不管系统策略设置如何。
默认值为关闭，这意味着消息将根据系统设置打印。
SELinux的安全策略也有规则来控制是否记录特定访问。
默认情况下，访问违规会被记录，但允许的访问则不会。
这个参数强制打开所有可能的记录，而不管系统策略。
F.40.5. 特性 #F.40.5.1. 受控对象类 #
SELinux的安全模型将所有访问控制规则描述为主体实体
（通常是数据库的客户端）与客体实体（例如数据库对象）之间的关系，每个
实体都由安全标签标识。如果尝试访问一个未加标签的对象，该对象将被视为
被分配了标签unlabeled_t。
当前，sepgsql允许将安全标签分配给模式、表、列、
序列、视图和函数。当使用sepgsql时，安全标签会
在创建时自动分配给支持的数据库对象。该标签称为默认安全标签，并根据
系统安全策略决定，该策略以创建者的标签、分配给新对象父对象的标签以及
可选的构造对象名称作为输入。
一个新数据库对象基本上会继承父对象的安全标签，不过当安全策略具有特殊的
类型转换规则时，将会应用一个不同的标签。对于模式，其父对象是当前数据库。
对于表、序列、视图和函数，父对象是包含它的模式。对于列，其父对象是包含
它的表。
F.40.5.2. DML 权限 #
对于表，根据语句的种类会对所有被引用的目标表检查
db_table:select、db_table:insert、
db_table:update或者db_table:delete。此外，对于
所有其列被WHERE或RETURNING子句引用、作为
UPDATE的数据源（以及其他情况）的表，
都要检查db_table:select。
对每一个被引用的列也将检查列级权限。不仅在使用SELECT读取列
时会检查db_column:select，在其他 DML 语句中引用列时也要检查。
对于被UPDATE或者INSERT修改的列也将检查
db_column:update或者db_column:insert。
例如，考虑：
UPDATE t1 SET x = 2, y = func1(y) WHERE z = 100;
这里，将对t1.x检查db_column:update，因为它
被更新。对t1.y将检查db_column:{select update}，
因为它既被更新也被引用。并且会对t1.z检查
db_column:select，因为它只被引用。还将在表层面上检查
db_table:{select update}。
对于序列，当我们使用SELECT引用一个序列对象时会检查
db_sequence:get_value。不过，我们当前不会检查执行相应
函数（例如lastval()）的权限。
对于视图，将检查db_view:expand，然后对从视图展开来的任何
对象都会分别检查所需的权限。
对于函数，当用户尝试在一个查询中或者使用快路径调用执行一个函数时会检查
db_procedure:{execute}。如果该函数是一个可信过程，也会检查
db_procedure:{entrypoint}权限来看看它能否作为一个可信过程
的入口点来执行。
为了访问任何模式对象，在其所在的模式上需要db_schema:search
权限。当不用模式限定引用一个对象时，其上没有该权限的模式不会被搜索（就好
像该用户在该模式上没有USAGE特权）。如果出现一个显式的模式
限定，当该用户在提及的模式上没有所需的权限时将会发生一个错误。
客户端必须被允许访问所有引用到的表和列，即便它们是由视图扩展得来的。这样
我们可以应用一致的访问控制规则而不管表内容被引用的方式。
默认的数据库特权系统允许数据库超级用户使用 DML 命令修改系统目录并且引用
或者修改 TOAST 表。当sepgsql被启用时，这些操作会被禁止。
F.40.5.3. DDL 权限 #
SELinux为每一种对象类型定义了数个权限来控制
常用操作，例如创建、修改、删除以及重新标记安全标签。此外，数种
对象类型具有特殊的权限来控制它们的特性化操作，例如在一个特定模式
中增加或删除名字项。
创建一个新的数据库对象要求create权限。
SELinux将基于客户端的安全标签来授予或拒绝
这个权限并且为新对象提出安全标签。在某些情况下，还需要额外的特权：
CREATE DATABASE额外要求
源数据库或模板数据库的getattr权限。
创建一个模式对象额外要求父模式上的add_name权限。
创建一个表额外要求创建单个表列的权限，就好像每一个表列都是一个
单独的顶层对象。
创建一个被标记为LEAKPROOF的函数额外要求
install权限（当为一个现有函数设置
LEAKPROOF时也要检查这个权限）。
当执行DROP命令时，在要移除的对象上会检查drop。
对于通过CASCADE间接被删除的对象也会检查权限。删除包含在
一个特定模式内的对象（表、视图、序列以及过程）额外地要求该模式上的
remove_name。
在执行ALTER命令时，会在被修改的对象上为每一种对象类型检查
setattr。附属对象（例如一个表的索引或者触发器）除外，这种
情况下权限是在父对象上检查的。在某些情况下，还需要额外的权限：
将一个对象移动到一个新的模式要求旧模式上的remove_name
权限以及新模式上的add_name权限。
设置一个函数上的LEAKPROOF属性要求install权限。
在一个对象上使用SECURITY LABEL会额外对该对象要求
relabelfrom权限连同它的旧安全标签以及relabelto
权限连同它的新安全标签（在安装了多个标签提供者并且用户尝试设置一个不由
SELinux管理的安全标签的情况中，这里只应该检查
setattr。当前由于实现限制没有这样做。）。
F.40.5.4. 可信过程 #
可信过程类似于 SECURITY DEFINER 函数或者 setuid 命令。
SELinux提供了一个特性来允许可信代码使用一个不同
于客户端的安全标签运行，通常这是为了提供对敏感数据的高度控制的访问（
例如行可能会被省略或者存储值的精度可能会被降低）。一个函数是否可以
作为可信过程受到其安全标签和操作系统安全策略的控制。例如：
postgres=# CREATE TABLE customer (
cid     int primary key,
cname   text,
credit  text
);
CREATE TABLE
postgres=# SECURITY LABEL ON COLUMN customer.credit
IS 'system_u:object_r:sepgsql_secret_table_t:s0';
SECURITY LABEL
postgres=# CREATE FUNCTION show_credit(int) RETURNS text
AS 'SELECT regexp_replace(credit, ''-[0-9]+$'', ''-xxxx'', ''g'')
FROM customer WHERE cid = $1'
LANGUAGE sql;
CREATE FUNCTION
postgres=# SECURITY LABEL ON FUNCTION show_credit(int)
IS 'system_u:object_r:sepgsql_trusted_proc_exec_t:s0';
SECURITY LABEL
上述操作应该由一个管理员用户执行。
postgres=# SELECT * FROM customer;
ERROR:  SELinux: security policy violation
postgres=# SELECT cid, cname, show_credit(cid) FROM customer;
cid | cname  |     show_credit
-----+--------+---------------------
1 | taro   | 1111-2222-3333-xxxx
2 | hanako | 5555-6666-7777-xxxx
(2 rows)
在这种情况下，一个常规用户无法直接引用customer.credit，
但是一个可信过程show_credit允许用户在打印客户的信用卡号时
把一些数字掩盖掉。
F.40.5.5. 动态域转换 #
如果安全策略允许，可以使用 SELinux 的动态域转换特性来切换客户端
进程（客户端域）的安全标签到一个新的上下文。该客户端域需要
setcurrent权限以及从旧的域到新的域的
dyntransition权限。
动态域转换需要被仔细考虑，因为它们允许用户切换其标签，
并且因此切换特权，而不是（像可信过程的情况那样）受系统的强制性管理。
因此，只有当被用来切换到一个比原来的域具有更少特权的域时，
dyntransition才被认为是安全的。例如：
regression=# select sepgsql_getcon();
sepgsql_getcon
-------------------------------------------------------
unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023
(1 row)
regression=# SELECT sepgsql_setcon('unconfined_u:unconfined_r:unconfined_t:s0-s0:c1.c4');
sepgsql_setcon
----------------
t
(1 row)
regression=# SELECT sepgsql_setcon('unconfined_u:unconfined_r:unconfined_t:s0-s0:c1.c1023');
ERROR:  SELinux: security policy violation
在上面的这个例子中，我们被允许从较大范围的c1.c1023切换到
较小范围的c1.c4，但切换回去却被禁止。
动态域转换和可信过程的组合开启了一种有趣的使用案例，它适合典型的
连接池软件的处理生命周期。即便你的连接池软件不被允许运行大部分的
SQL 命令，你可以从一个可信过程中使用
sepgsql_setcon()函数允许它切换该客户端的安全标签，
这个过程应该采用一些凭证来授权该请求切换该客户端标签。之后，这个
会话将会具有目标用户而不是连接池的特权。该连接池之后可以用
NULL参数再次调用sepgsql_setcon()
逆转这次安全标签改变，当然再次的调用也要在一个可信过程中配合适当
的权限检查进行。这里的要点是只有可信过程实际具有权限来更改有效的安全
标签，并且只有在得到适当的凭证后才这样做。当然，对于安全操作，必须
保护凭证存储（表、过程定义或者其他什么）不会受到未经授权的访问。
F.40.5.6. 杂项 #
我们全面拒绝LOAD命令，因为任何模块的装载都
可能很轻易地绕过安全策略的强制执行。
F.40.6. sepgsql 函数 #
表 F.32展示了可用的函数。
表 F.32. sepgsql 函数
函数
描述
sepgsql_getcon ()
→ text
返回客户端域，客户端的当前安全标签。
sepgsql_setcon ( text )
→ boolean
如果安全策略允许，则将当前会话的客户端域切换到新域。
它还接受 NULL 输入作为请求，转换到客户端的原始域。
sepgsql_mcstrans_in ( text )
→ text
如果 mcstrans 守护进程正在运行，则将给定的限定 MLS/MCS 范围转换为原始格式。
sepgsql_mcstrans_out ( text )
→ text
如果 mcstrans 守护进程正在运行，则将给定的原始 MLS/MCS 范围转换为限定格式。
sepgsql_restorecon ( text )
→ boolean
为当前数据库中的所有对象设置初始安全标签。参数可以是 NULL，或要用作系统默认值替代项的规范文件的名称。
F.40.7. 限制 #数据定义语言 (DDL) 权限
由于实现的限制，一些 DDL 操作无法检查权限。
数据控制语言（DCL）权限
由于实现限制，DCL 操作不检查权限。
行级访问控制
PostgreSQL支持行级访问，但
sepgsql不支持。
隐蔽通道
sepgsql不会尝试隐藏一个特定对象的存在，即便是
用户不被允许引用该对象。例如，即便我们无法得到一个不可见对象
的内容，我们也可以通过主键冲突、外键违背等等结果来推知该对象
的存在。一个绝密表的存在无法被隐藏，我们只希望能够隐藏其内容。
F.40.8. 外部资源 #SE-PostgreSQL 介绍
这个 wiki 页面提供了一个简单的综述、安全设计、架构、
管理和即将到来的特性。
SELinux 用户和管理员指南
这个文档提供了广泛的知识来管理系统上的
SELinux。它主要关注 Red Hat 操作系统，但并不仅限于此。
Fedora SELinux FAQ
这个文档回答了很多SELinux
的常见问题。它主要关注 Fedora，但并不仅限于 Fedora。
F.40.9. 作者 #
KaiGai Kohei <kaigai@ak.jp.nec.com>
上一页 上一级 下一页F.39. seg — 表示线段或浮点区间的数据类型 起始页 F.41. spi — 服务器编程接口功能/示例
