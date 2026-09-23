# pg_amcheck

pg_amcheck
版本：
纠错本页面
搜索
目录导航
❮
❯
pg_amcheckpg_amcheck — 在一个或多个PostgreSQL数据库中检查数据损坏大纲pg_amcheck [option...] [dbname]Description
pg_amcheck支持对一个或多个数据库运行amcheck的损坏检查函数，并提供选项来选择要检查的模式、表和索引、要执行的检查类型以及是否并行执行检查，如果是，建立并行连接的数量。
仅支持普通和toast表关系、物化视图、序列和btree索引。其他关系类型会被静默跳过。
如果指定了dbname，则它应该是要检查的单个数据库的名称，并且不应该存在其他数据库选择选项。否则，如果存在任何数据库选择选项，将检查所有匹配的数据库。如果不存在此类选项，将检查默认数据库。数据库选择选项包括--all，--database和--exclude-database。它们还包括--relation，--exclude-relation，
--table，--exclude-table，--index，和--exclude-index，但仅当这些选项与三段式模式一起使用时（例如，mydb*.myschema*.myrel*）。最后，它们包括--schema和--exclude-schema
当这些选项与两段式模式一起使用时（例如mydb*.myschema*）。
dbname也可以是一个连接字符串.
选项
以下命令行选项控制要检查的内容：
-a--all
检查所有数据库，除了通过--exclude-database排除的数据库。
-d pattern--database=pattern
检查与指定的
pattern
匹配的数据库，除了被--exclude-database排除的其他数据库。
可以多次指定此选项。
-D pattern--exclude-database=pattern
排除与给定的pattern
匹配的数据库。
可以多次指定此选项。
-i pattern--index=pattern
检查与指定的
pattern
匹配的索引，除非它们被排除在外。
可以多次指定此选项。
这类似于--relation选项，不同之处在于它仅适用于索引，而不适用于其他关系类型。
-I pattern--exclude-index=pattern
排除与指定的pattern匹配的索引。
可以多次指定此选项。
这类似于--exclude-relation选项，不同之处在于它仅适用于索引，而不适用于其他关系类型。
-r pattern--relation=pattern
检查与指定的
pattern
匹配的关系，除非它们被排除在外。
此选项可以多次指定。
模式可以是未经限定的，例如myrel*，也可以是经过模式限定的，例如myschema*.myrel*或者数据库限定和模式限定的，例如mydb*.myschema*.myrel*。数据库限定的模式将会将匹配的数据库添加到待检查的数据库列表中。
-R pattern--exclude-relation=pattern
排除与指定的pattern匹配的关系。
此选项可以多次指定。
与--relation一样，pattern可以是未经限定的，模式限定的，
或数据库和模式限定的。
-s pattern--schema=pattern
检查与指定的pattern匹配的模式中的表和索引，除非它们被排除在外。
此选项可以多次指定。
要选择仅匹配特定模式的模式中的表，
可考虑使用类似以下内容
--table=SCHEMAPAT.* --no-dependent-indexes。
要选择仅索引，可考虑使用类似以下内容
--index=SCHEMAPAT.*。
模式可以是数据库限定的。例如，您可以编写--schema=mydb*.myschema*来选择与myschema*匹配的模式，在匹配的数据库中选择mydb*。
-S pattern--exclude-schema=pattern
排除与指定的
pattern
匹配的模式和索引。此选项可以指定多次。
与--schema选项一样，该模式可能是数据库限定的。
-t pattern--table=pattern
检查匹配指定pattern的表，
除非它们被排除在外。
此选项可以多次指定。
这类似于--relation选项，不同之处在于它仅适用于表、物化视图和序列，而不适用于索引。
-T pattern--exclude-table=pattern
排除与指定的
pattern
匹配的表。此选项可以指定多次。
这类似于--exclude-relation选项，只适用于表、物化视图和序列，而不适用于索引。
--no-dependent-indexes
默认情况下，如果检查一个表，那么该表的任何btree索引也将被检查，即使它们没有被显式选择，
比如--index或--relation选项。此选项抑制了该行为。
--no-dependent-toast
默认情况下，如果检查一个表，它的toast表（如果有的话）也会被检查，即使它没有被选中，
例如--table或--relation选项。此选项抑制了该行为。
--no-strict-names
默认情况下，如果--database、--table、
--index或--relation的参数与任何对象都不匹配，
那么这将是一个致命错误。此选项将该错误降级为警告。
以下命令行选项用于控制表的检查：
--exclude-toast-pointers
默认情况下，每当在表中遇到toast指针时，都会执行查找以确保它引用toast表中明显有效的条目。这些检查可能非常慢，可以使用此选项跳过这些检查。
--on-error-stop
在发现损坏的表的第一页上报告所有损坏后，停止处理该表关系，并转到下一个表或索引。
请注意，索引检查总是在第一个损坏页之后停止。此选项仅与表关系相关。
--skip=option
如果给定all-frozen，表损坏检查将跳过所有表中标记为全部冻结的页面。
如果给定了all-visible，则表损坏检查将跳过所有表中标记为所有可见的页面。
默认情况下，不跳过任何页面。这可以指定为none，但由于这是默认值，因此无需提及。
--startblock=block
从指定的块号开始检查。如果正在检查的表关系的块数少于此数，则会发生错误。此选项不适用于索引，可能仅在检查单个表关系时有用。请参阅--endblock了解更多注意事项。
--endblock=block
在指定的块号结束检查。如果正在检查的表关系的块数少于此数，则会发生错误。此选项不适用于索引，可能仅在检查单个表关系时有用。如果同时选中常规表和toast表，则此选项将同时适用于这两个表，但在验证toast指针时，仍然可以访问编号更高的toast块，除非使用--exclude-toast-pointers抑制。
以下命令行选项用于控制B树索引的检查：
--checkunique
对于每个检查唯一约束的索引，使用amcheck的
checkunique选项验证索引中重复条目中最多只有一个是可见的。
--heapallindexed
对于每个被检查的索引，使用amcheck的
heapallindexed选项验证所有堆元组是否作为索引元组存在于索引中。
--parent-check
对于每个被检查的B树索引，使用amcheck的
bt_index_parent_check函数，该函数在索引检查期间执行父子关系的额外检查。
默认使用amcheck的
bt_index_check函数，但请注意，使用
--rootdescend选项会隐式选择
bt_index_parent_check。
--rootdescend
对于每个被检查的索引，使用amcheck的
rootdescend选项，通过从根页重新搜索每个元组，在叶子级别重新定位元组。
使用此选项也隐式选择了
--parent-check选项。
这种验证方式最初是为帮助开发B树索引功能而编写的。它在检测实际发生的
损坏类型方面可能作用有限甚至无效。它还可能导致损坏检查耗时显著增加，
并且在服务器上消耗更多资源。
警告
当指定--parent-check选项或--rootdescend选项时，对B树索引执行的额外检查需要相对强的关系级锁。这些检查是唯一会阻止INSERT，UPDATE，和DELETE命令并发数据修改的检查。
以下命令行选项用来控制与服务器的连接：
-h hostname--host=hostname
指定运行服务器的计算机的主机名。如果该值以斜杠开头，它将用作Unix域套接字的目录。
-p port--port=port
指定服务器正在侦听连接的TCP端口或本地Unix域套接字文件扩展名。
-U--username=username
连接的用户名。
-w--no-password
永远不要发出密码提示。如果服务器需要密码身份验证，并且密码无法通过其他方式（如.pgpass文件）提供，则连接尝试将失败。在没有用户输入密码的批处理作业和脚本中，此选项非常有用。
-W--password
在连接到数据库之前，强制pg_amcheck提示输入密码。
此选项从来都不是必需的，因为如果服务器要求密码身份验证，pg_amcheck将自动提示输入密码。但是，pg_amcheck将浪费一次连接尝试，以发现服务器需要密码。在某些情况下，键入-W以避免额外的连接尝试是值得的。
--maintenance-db=dbname
指定用于发现要检查的数据库列表的数据库或连接字符串。如果既不使用--all也不使用任何包含数据库模式的选项，则不需要这种连接，并且该选项不起任何作用。否则，连接到正在检查的数据库时，也将使用此选项值中包含的数据库名称以外的任何连接字符串参数。如果省略此选项，则默认值为postgres，或如果失败，则为template1。
其他允许的选项：
-e--echo
回显发送到服务器的所有SQL。
-j num--jobs=num
使用num个到服务器的并发连接，或每个要检查的对象使用一个连接，以较小者为准。
默认情况是使用单个连接。
-P--progress
显示进度信息。进度信息包括已完成检查的关系数以及这些关系的总大小。它还包括最终要检查的关系的总数，以及这些关系的估计大小。
-v--verbose
打印更多消息。特别是，这将为每个正在检查的关系打印一条消息，并将增加服务器错误的详细程度。
-V--version
打印pg_amcheck版本并退出。
--install-missing--install-missing=schema
安装检查数据库所需的任何缺少的扩展。如果尚未安装，每个扩展的对象将安装到给定的schema中，或者如果未指定则安装到pg_catalog模式中。
目前，唯一需要的扩展是amcheck。
-?--help
显示有关pg_amcheck命令行参数的帮助，然后退出。
环境
与大多数其他 PostgreSQL 工具一样，
pg_amcheck 也使用 libpq 支持的环境变量
（参见 第 32.15 节）。
环境变量PG_COLOR指定是否在诊断消息中使用颜色。
可能的值是always、auto和
never。
Notes
pg_amcheck被设计用于
PostgreSQL 14.0及以上版本。
See Alsoamcheck上一页 上一级 下一页ecpg 起始页 pg_basebackup
