# 27.6. 监控磁盘使用情况

27.6. 监控磁盘使用情况
版本：
纠错本页面
搜索
目录导航
❮
❯
27.6. 监控磁盘使用情况 #27.6.1. 确定磁盘用量27.6.2. 磁盘满错误
本节讨论如何监控PostgreSQL数据库系统的磁盘使用情况。
27.6.1. 确定磁盘用量 #
每个表都有一个主堆磁盘文件，用于存储大部分数据。如果表中有任何可能包含宽值的列，
也可能有一个与表相关联的TOAST文件，用于存储过宽而无法舒适地放入主
表中的值（参见第 66.2 节）。如果存在，将在TOAST表上
有一个有效的索引。基表也可能有相关的索引。每个表和索引都存储在单独的磁盘文件中——
如果文件大小超过一千兆字节，可能会有多个文件。这些文件的命名约定在第 66.1 节
中有描述。
你可以通过三种方式监控磁盘空间：
使用列在表 9.102中的SQL函数，
使用oid2name模块，或者
通过手动检查系统目录。
SQL函数是最容易使用的，通常也是推荐的。
本节的其余部分将展示如何通过检查系统目录来实现。
使用最近执行过清理（vacuum）或分析（analyze）的数据库中的
psql，您可以发出查询以查看任何表的磁盘使用情况：
SELECT pg_relation_filepath(oid), relpages FROM pg_class WHERE relname = 'customer';
pg_relation_filepath | relpages
----------------------+----------
base/16384/16806     |       60
(1 row)
每页通常为8千字节。（请记住，relpages仅由
VACUUM、ANALYZE以及一些DDL命令如
CREATE INDEX更新。）如果您想直接检查表的磁盘文件，
文件路径名称是很重要的。
显示 TOAST 表所使用的空间，可以使用如下查询：
SELECT relname, relpages
FROM pg_class,
(SELECT reltoastrelid
FROM pg_class
WHERE relname = 'customer') AS ss
WHERE oid = ss.reltoastrelid OR
oid = (SELECT indexrelid
FROM pg_index
WHERE indrelid = ss.reltoastrelid)
ORDER BY relname;
relname        | relpages
----------------------+----------
pg_toast_16806       |        0
pg_toast_16806_index |        1
您也可以轻松显示索引大小：
SELECT c2.relname, c2.relpages
FROM pg_class c, pg_class c2, pg_index i
WHERE c.relname = 'customer' AND
c.oid = i.indrelid AND
c2.oid = i.indexrelid
ORDER BY c2.relname;
relname      | relpages
-------------------+----------
customer_id_index |       26
使用这些信息可以轻松找到您最大的表和索引：
SELECT relname, relpages
FROM pg_class
ORDER BY relpages DESC;
relname        | relpages
----------------------+----------
bigtable             |     3290
customer             |     3144
27.6.2. 磁盘满错误 #
数据库管理员最重要的磁盘监控任务是确保磁盘不会被填满。填满的数据磁盘不会导致数据损坏，
但可能会阻止有用的操作发生。如果保存WAL文件的磁盘被填满，数据库服务器可能会发生恐慌并
随之关闭。
如果您无法通过删除其他内容释放磁盘上的额外空间，您可以通过使用表空间将部分数据库文件
移动到其他文件系统。有关详细信息，请参见 第 22.6 节。
提示
一些文件系统在几乎满时表现不佳，因此不要等到磁盘完全满了才采取行动。
如果您的系统支持每用户磁盘配额，那么数据库自然会受到服务器运行用户所
施加的配额限制。超过配额将产生与磁盘空间完全用尽相同的不良影响。
上一页 上一级 下一页27.5. 动态追踪 起始页 第 28 章 可靠性和预写日志
