# 5.8. 权限

5.8. 权限
版本：
纠错本页面
搜索
目录导航
❮
❯
5.8. 权限 #
一旦一个对象被创建，它会被分配一个所有者。所有者通常是执行创建语句的角色。对于大部分类型的对象，初始状态下只有所有者（或者超级用户）能够对该对象做任何事情。为了允许其他角色使用它，必须分配特权。
有不同种类的权限：SELECT、INSERT、UPDATE、
DELETE、TRUNCATE、REFERENCES、
TRIGGER、CREATE、CONNECT、
TEMPORARY、EXECUTE、USAGE、
SET、ALTER SYSTEM和MAINTAIN。
适用于特定对象的权限取决于该对象的类型（表、函数等）。
下面将详细说明这些权限的含义。
接下来的章节也会向您展示这些权限的使用方法。
修改或销毁一个对象的权利是作为该对象的所有者所固有的，不能授予或撤销其本身。
（但是，与所有特权一样，该权利可以由拥有角色的成员继承；请参阅第 21.3 节。）
可以使用适当类型的 ALTER 命令将对象分配给新拥有者，例如
ALTER TABLE table_name OWNER TO new_owner;
超级用户始终可以这样做；普通角色只有在他们既是对象的当前拥有者（或继承拥有角色的权限）并且能够 SET ROLE 到新的拥有角色时才能这样做。
旧拥有者的所有对象权限将与所有权一起转移给新拥有者。
要分配权限，可以使用GRANT命令。例如，如果joe是一个已有角色，而accounts是一个已有表，更新该表的权限可以按如下方式授权：
GRANT UPDATE ON accounts TO joe;
用ALL取代特定权限会把与对象类型相关的所有权限全部授权。
一个特殊的名为PUBLIC的“角色”可以用来向系统中的每一个角色授予一个权限。同时，在数据库中有很多用户时可以设置“组”角色来帮助管理权限。详见第 21 章。
要撤销以前授予的权限，请使用恰当命名的REVOKE命令:
REVOKE ALL ON accounts FROM PUBLIC;
一般情况下，只有对象拥有者（或者超级用户）可以授予或撤销一个对象上的权限。但是可以在授予权限时使用“with grant option”来允许接收人将权限转授给其他人。如果后来授予选项被撤销，则所有从接收人那里获得的权限（直接或者通过授权链获得）都将被撤销。更多详情请见GRANT和REVOKE参考页。
对象的所有者可以选择撤销自己的普通权限，例如，令表对于自己和其他人只读。
但是所有者总是被视为拥有所有的授予选项，所以他们总是可以重新授予自己的权限。
可用的权限包括：
SELECT #
允许从表、视图、物化视图或其他类似表的对象的任何列或特定列进行SELECT。
还允许使用COPY TO。
这个权限还需要用于引用UPDATE、DELETE或MERGE中的现有列值。
对于序列，这个权限还允许使用currval函数。
对于大对象，这个权限允许读取对象。
INSERT #
允许在表、视图等中插入新行，可以授予对特定列的权限，这样只有这些列可以在INSERT命令中赋值（其他列将接收默认值）。
还允许使用COPY FROM。
UPDATE #
允许对表、视图等的任何列或特定列进行UPDATE操作。
（实际上，任何非平凡的UPDATE命令都需要SELECT权限，
因为它必须引用表列来确定要更新的行，和/或为列计算新值。）
SELECT ... FOR UPDATE
和SELECT ... FOR SHARE
还需要在至少一个列上具有此权限，除了SELECT权限之外。
对于序列，此权限允许使用nextval和
setval函数。
对于大对象，此权限允许写入或截断该对象。
DELETE #
允许从表、视图等中DELETE一行，（实际上，任何非平凡的DELETE命令都需要SELECT权限，
因为它必须引用表列来确定要删除的行。）
TRUNCATE #
允许在表上使用TRUNCATE。
REFERENCES #
允许创建引用表或表的特定列的外键约束。
TRIGGER #
允许在表、视图等上创建触发器。
CREATE #
对于数据库，允许在数据库中创建新的模式和发布，并允许在数据库中安装受信任的扩展。
对于模式，允许在该模式内创建新对象。要重命名现有对象，您必须拥有该对象的所有权并对该包含的模式具有此特权。
对于表空间，允许在表空间内创建表、索引和临时文件，并允许创建将该表空间作为默认表空间的数据库。
请注意，撤销此权限不会改变现有对象的存在或位置。
CONNECT #
允许受让人连接到数据库。此权限在连接启动时进行检查（除了检查pg_hba.conf强加的任何限制）。
TEMPORARY #
允许在使用数据库时创建临时表。
EXECUTE #
允许调用函数或过程，包括使用在函数之上实现的任何运算符。这是唯一适用于函数和过程的权限类型。
USAGE #
对于过程性语言，允许在该语言中创建函数。这是唯一适用于过程性语言的权限类型。
对于模式，允许访问包含在模式中的对象（假设对象自身的权限要求也得到满足）。
本质上，这允许受让人“查找”模式中的对象。
没有这个权限，仍然可以看到对象名称，例如，通过查询系统目录。
此外，在撤销此权限后，现有会话可能有先前执行此查找的语句，因此这不是
完全安全的防止对象访问的方式。
对于序列，允许使用currval和nextval函数。
对于类型和域，允许在表格、函数和其他模式对象的创建中使用该类型或域。
（请注意，此权限并不控制类型的所有“使用”，比如类型值出现在查询中。
它只是防止依赖于该类型的对象被创建。此权限的主要目的是控制哪些用户可以创建
对类型的依赖，这可以防止所有者以后更改类型。）
对于外部数据包装器，允许使用外部数据包装器创建新的服务器。
对于外部服务器，允许使用该服务器创建外部表。受让人还可以创建、修改或删除与该服务器关联的自己的用户映射。
SET #
允许在当前会话中将服务器配置参数设置为新值。
（虽然可以授予此权限在任何参数上，但除了通常需要超级用户权限设置的参数外，这是没有意义的。）
ALTER SYSTEM #
允许使用ALTER SYSTEM命令将服务器配置参数配置为新值。
MAINTAIN #
允许VACUUM、ANALYZE、
CLUSTER、REFRESH MATERIALIZED VIEW、
REINDEX、LOCK TABLE，
以及数据库对象统计信息操作函数
（参见表 9.105）。
其他命令所需的权限列在各自命令的参考页面上。
PostgreSQL 默认在创建某些类型的对象时，授予PUBLIC权限。
默认情况下，不会向PUBLIC授予以下对象的权限：
表、
表列、
序列、
外部数据包装器、
外部服务器、
大对象、
模式、
表空间，
或配置参数。
对于其他类型的对象，默认授予PUBLIC的权限如下：
数据库的CONNECT和TEMPORARY（创建临时表）权限；
函数和过程的EXECUTE权限；以及
语言和数据类型（包括域）的USAGE权限。
对象所有者当然可以REVOKE撤销默认和明确授予的权限。
（为了最大安全性，请在创建对象的同一事务中执行REVOKE；
这样就没有其他用户可以使用该对象的时间窗口。）
此外，这些默认权限设置可以通过ALTER DEFAULT PRIVILEGES命令覆盖。
表 5.1 显示了在
ACL 值中用于这些权限类型的
单字母缩写。您将在下面列出的 psql
命令的输出中看到这些字母，或者在查看系统目录的
ACL 列时看到它们。
表 5.1. ACL 权限缩写权限缩写适用对象类型SELECTr (“读”)
LARGE OBJECT,
SEQUENCE,
TABLE (和类似表的对象),
表列
INSERTa (“追加”)TABLE, 表列UPDATEw (“写”)
LARGE OBJECT,
SEQUENCE,
TABLE,
表列
DELETEdTABLETRUNCATEDTABLEREFERENCESxTABLE, 表列TRIGGERtTABLECREATEC
DATABASE,
SCHEMA,
TABLESPACE
CONNECTcDATABASETEMPORARYTDATABASEEXECUTEXFUNCTION, PROCEDUREUSAGEU
DOMAIN,
FOREIGN DATA WRAPPER,
FOREIGN SERVER,
LANGUAGE,
SCHEMA,
SEQUENCE,
TYPE
SETsPARAMETERALTER SYSTEMAPARAMETERMAINTAINmTABLE
表 5.2 使用上面所示的缩写总结了每种类型 SQL 对象可用的权限。
它还显示可用于检查每种对象类型的权限设置的 psql 命令。
表 5.2. 访问权限摘要对象类型所有权限默认 PUBLIC 权限psql 命令DATABASECTcTc\lDOMAINUU\dD+FUNCTION 或 PROCEDUREXX\df+FOREIGN DATA WRAPPERUnone\dew+FOREIGN SERVERUnone\des+LANGUAGEUU\dL+大对象rwnone\dl+PARAMETERsAnone\dconfig+SCHEMAUCnone\dn+SEQUENCErwUnone\dpTABLE（及类似表的对象）arwdDxtmnone\dp表的列arwxnone\dpTABLESPACECnone\db+TYPEUU\dT+
已授予特定对象的权限显示为aclitem条目列表，每个条目的格式如下：
grantee=privilege-abbreviation[*].../grantor
每个aclitem列出了由特定授权者授予的一个受让人的所有权限。具体权限由表 5.1中的单字母缩写表示，如果权限是通过授予权限选项授予的，则附加*。例如，calvin=r*w/hobbes指定角色calvin具有权限SELECT（r）以及不可授予权限UPDATE（w），两者均由角色hobbes授予。如果calvin还具有由不同授权者授予的同一对象的某些权限，则这些权限将显示为单独的aclitem条目。在aclitem中的空受让人字段代表PUBLIC。
例如，假设用户miriam创建了表mytable并执行：
GRANT SELECT ON mytable TO PUBLIC;
GRANT SELECT, UPDATE, INSERT ON mytable TO admin;
GRANT SELECT (col1), UPDATE (col1) ON mytable TO miriam_rw;
那么psql的\dp命令将显示：
=> \dp mytable
Access privileges
Schema |  Name   | Type  |   Access privileges    |   Column privileges   | Policies
--------+---------+-------+------------------------+-----------------------+----------
public | mytable | table | miriam=arwdDxtm/miriam+| col1:                +|
|         |       | =r/miriam             +|   miriam_rw=rw/miriam |
|         |       | admin=arw/miriam       |                       |
(1 row)
如果“Access privileges”列对于给定对象为空，则表示该对象具有默认权限（也就是说，它在相关系统目录中的权限条目为空）。
默认权限始终包含所有者的所有权限，并且可以包括 PUBLIC 的一些权限，具体取决于对象类型，如上所述。
对象上的第一个GRANT或REVOKE将实例化默认权限（例如，生成miriam=arwdDxt/miriam），然后根据指定的请求修改它们。
类似的，只有具有非默认权限的列的条目才显示在“Column privileges”中。（注意：为此目的，“default privileges”始终表示对象类型的内置默认权限。其权限受ALTER DEFAULT PRIVILEGES 命令影响的对象将始终显示一个显式权限条目，其中包含 ALTER的影响。）
注意所有者的隐式授予选项没有在访问权限显示中标记。仅当授予选项被显式授予给某人时才会出现*。
“访问权限”列显示(none)，当对象的权限条目非空但为空时。
这意味着根本没有授予任何权限，即使是对象的所有者——这是一种罕见的情况。
（在这种情况下，所有者仍然拥有隐式的授权选项，因此可以重新授予自己的权限；
但她目前没有任何权限。）
上一页 上一级 下一页5.7. 修改表 起始页 5.9. 行级安全策略
