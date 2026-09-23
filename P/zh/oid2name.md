# oid2name

oid2name
版本：
纠错本页面
搜索
目录导航
❮
❯
oid2nameoid2name — 解析 OID 和文件节点在 PostgreSQL 数据目录中的位置。大纲oid2name [option...]描述
oid2name 是一个帮助管理员检查 PostgreSQL 使用的文件结构的工具程序。要使用它，你需要熟悉数据库文件结构，详见 第 66 章。
注意
名称 “oid2name” 是有历史原因的，它确实有些误导性，因为在你使用它的大部分时间里，你实际关心的是表的文件节点编号（在数据目录中是可见的文件名）。请确保你理解表 OID 和表文件节点之间的区别！
oid2name 连接到一个目标数据库并提取 OID、文件节点和/或表名信息。你也可以让它显示数据库 OID 或表空间 OID。
选项
oid2name 接受下列命令行参数：
-f filenode--filenode=filenode显示具有文件节点 filenode 的表的信息。-i--indexes在列表中包括索引和序列。-o oid--oid=oid显示具有 OID oid 的表的信息。-q--quiet忽略头部（用于脚本）。-s--tablespaces显示表空间 OIDs。-S--system-objects包括系统对象（位于 information_schema、pg_toast 和 pg_catalog 模式）。-t tablename_pattern--table=tablename_pattern显示匹配 tablename_pattern 的表的信息。-V--version
打印 oid2name 版本并退出。
-x--extended显示关于每个对象的更多信息：表空间名、模式名和 OID。-?--help
显示有关 oid2name 命令行参数的帮助并退出。
oid2name也接受下列用于连接参数的命令行参数：
-d database--dbname=database要连接的数据库。-h host--host=host数据库服务器的主机。-H host数据库服务器的主机。这个参数在
PostgreSQL 12中已经不推荐。-p port--port=port数据库服务器的端口。-U username--username=username用于连接的用户名。
要显示特定表，通过使用-o、-f和-t选择要显示哪个表。
-o采用一个 OID，
-f采用一个文件节点，
而-t采用一个表名（实际上，它是一个LIKE模式，因此你可以用诸如foo%之类的东西）。
这些选项你想用多少就用多少，最后的列举将包括所有匹配任意一个这些选项的对象。但是注意这些选项只能显示由-d给定的数据库中的对象。
如果你没有给出任何-o、-f或者-t，但是给出了-d，它将列出由-d指定的数据库中的所有表。在这种模式下，-S和-i选项控制什么会被列出。
如果你也没有给出-d，它将显示一个数据库 OID 的列表。你也可以给出-s来得到一个表空间列表。
环境PGHOSTPGPORTPGUSER
默认连接参数。
与大多数其他 PostgreSQL的实用程序一样，这个实用程序也使用libpq 支持的环境变量 (参见 第 32.15 节)。
环境变量PG_COLOR指定是否在诊断消息中使用颜色。
可能的值是always、auto和
never。
注释
oid2name要求一个运行着的数据库服务器并且其系统目录没有损坏。因此它对于数据库损坏的情况用处有限。
示例
$ # what's in this database server, anyway?
$ oid2name
All databases:
Oid  Database Name  Tablespace
----------------------------------
17228       alvherre  pg_default
17255     regression  pg_default
17227      template0  pg_default
1      template1  pg_default
$ oid2name -s
All tablespaces:
Oid  Tablespace Name
-------------------------
1663       pg_default
1664        pg_global
155151         fastdisk
155152          bigdisk
$ # OK, let's look into database alvherre
$ cd $PGDATA/base/17228
$ # get top 10 db objects in the default tablespace, ordered by size
$ ls -lS * | head -10
-rw-------  1 alvherre alvherre 136536064 sep 14 09:51 155173
-rw-------  1 alvherre alvherre  17965056 sep 14 09:51 1155291
-rw-------  1 alvherre alvherre   1204224 sep 14 09:51 16717
-rw-------  1 alvherre alvherre    581632 sep  6 17:51 1255
-rw-------  1 alvherre alvherre    237568 sep 14 09:50 16674
-rw-------  1 alvherre alvherre    212992 sep 14 09:51 1249
-rw-------  1 alvherre alvherre    204800 sep 14 09:51 16684
-rw-------  1 alvherre alvherre    196608 sep 14 09:50 16700
-rw-------  1 alvherre alvherre    163840 sep 14 09:50 16699
-rw-------  1 alvherre alvherre    122880 sep  6 17:51 16751
$ # What file is 155173?
$ oid2name -d alvherre -f 155173
From database "alvherre":
Filenode  Table Name
----------------------
155173    accounts
$ # you can ask for more than one object
$ oid2name -d alvherre -f 155173 -f 1155291
From database "alvherre":
Filenode     Table Name
-------------------------
155173       accounts
1155291  accounts_pkey
$ # you can mix the options, and get more details with -x
$ oid2name -d alvherre -t accounts -f 1155291 -x
From database "alvherre":
Filenode     Table Name      Oid  Schema  Tablespace
------------------------------------------------------
155173       accounts   155173  public  pg_default
1155291  accounts_pkey  1155291  public  pg_default
$ # show disk space for every db object
$ du [0-9]* |
> while read SIZE FILENODE
> do
>   echo "$SIZE       `oid2name -q -d alvherre -i -f $FILENODE`"
> done
16            1155287  branches_pkey
16            1155289  tellers_pkey
17561            1155291  accounts_pkey
...
$ # same, but sort by size
$ du [0-9]* | sort -rn | while read SIZE FN
> do
>   echo "$SIZE   `oid2name -q -d alvherre -f $FN`"
> done
133466             155173    accounts
17561            1155291  accounts_pkey
1177              16717  pg_proc_proname_args_nsp_index
...
$ # If you want to see what's in tablespaces, use the pg_tblspc directory
$ cd $PGDATA/pg_tblspc
$ oid2name -s
All tablespaces:
Oid  Tablespace Name
-------------------------
1663       pg_default
1664        pg_global
155151         fastdisk
155152          bigdisk
$ # what databases have objects in tablespace "fastdisk"?
$ ls -d 155151/*
155151/17228/  155151/PG_VERSION
$ # Oh, what was database 17228 again?
$ oid2name
All databases:
Oid  Database Name  Tablespace
----------------------------------
17228       alvherre  pg_default
17255     regression  pg_default
17227      template0  pg_default
1      template1  pg_default
$ # Let's see what objects does this database have in the tablespace.
$ cd 155151/17228
$ ls -l
total 0
-rw-------  1 postgres postgres 0 sep 13 23:20 155156
$ # OK, this is a pretty small table ... but which one is it?
$ oid2name -d alvherre -f 155156
From database "alvherre":
Filenode  Table Name
----------------------
155156         foo
作者
B. Palmer <bpalmer@crimelabs.net>
上一页 上一级 下一页G.1. 客户端应用程序 起始页 vacuumlo
