# dblink_connect

dblink_connect
版本：
纠错本页面
搜索
目录导航
❮
❯
dblink_connectdblink_connect — 打开一个持久连接到远程数据库大纲
dblink_connect(text connstr) returns text
dblink_connect(text connname, text connstr) returns text
描述
dblink_connect()建立一个到远程PostgreSQL数据库的连接。要联系的服务器和数据库通过一个标准的libpq连接字符串来标识。可以选择将一个名字赋予给该连接。多个命名的连接可以被同时打开，但是一次只允许一个未命名连接。连接将会持续直到被关闭或者数据库会话结束。
连接字符串也可以是一个现存外部服务器的名字。在使用外部服务器时，我们推荐使用外部数据包装器dblink_fdw。见下面的例子，以及CREATE SERVER和CREATE USER MAPPING。
参数connname
要用于这个连接的名字。如果被忽略，将打开一个未命名连接并替换掉任何现有的未命名连接。
connstrlibpq-风格的连接信息串，例如
hostaddr=127.0.0.1 port=5432 dbname=mydb user=postgres
password=mypasswd options=-csearch_path=。
详见第 32.1.1 节。此外，还可以是一个外部服务器的名称。
返回值
返回状态，它总是OK（因为任何错误
会导致该函数抛出一个错误而不是返回）。
注意事项
如果不可信用户能够访问一个没有采用安全模式使用方案的数据库，应该在开始每个会话时从search_path中移除公共可写的方案。例如，可以把options=-csearch_path=增加到connstr。这种考虑不是特别针对dblink，它适用于每一种执行任意SQL命令的接口。
外部数据包装器 dblink_fdw 具有一个额外的
布尔选项 use_scram_passthrough，用于控制
dblink 是否使用 SCRAM 透传
认证来连接远程数据库。使用 SCRAM 透传
认证时，dblink 使用 SCRAM 哈希的密钥
而不是明文用户密码来连接远程服务器。这
避免了在 PostgreSQL 系统目录中存储明文用户密码。
有关详细信息和限制，请参见 postgres_fdw 的等效
use_scram_passthrough
选项的文档。
只有超级用户可以使用 dblink_connect 创建
不使用密码认证、SCRAM 透传或 GSSAPI 认证的连接。
如果非超级用户需要此功能，请使用
dblink_connect_u。
选择包含等号的连接名是不明智的，因为这会产生与在其他dblink函数中的连接信息串混淆的风险。
示例
SELECT dblink_connect('dbname=postgres options=-csearch_path=');
dblink_connect
-−-−-−-−-−-−-−-−
OK
(1 row)
SELECT dblink_connect('myconn', 'dbname=postgres options=-csearch_path=');
dblink_connect
-−-−-−-−-−-−-−-−
OK
(1 row)
-− FOREIGN DATA WRAPPER functionality
-− Note: local connections that don't use SCRAM pass-through require password
-−       authentication for this to work properly. Otherwise, you will receive
-−       the following error from dblink_connect():
-−       ERROR:  password is required
-−       DETAIL:  Non-superuser cannot connect if the server does not request a password.
-−       HINT:  Target server's authentication method must be changed.
CREATE SERVER fdtest FOREIGN DATA WRAPPER dblink_fdw OPTIONS (hostaddr '127.0.0.1', dbname 'contrib_regression');
CREATE USER regress_dblink_user WITH PASSWORD 'secret';
CREATE USER MAPPING FOR regress_dblink_user SERVER fdtest OPTIONS (user 'regress_dblink_user', password 'secret');
GRANT USAGE ON FOREIGN SERVER fdtest TO regress_dblink_user;
GRANT SELECT ON TABLE foo TO regress_dblink_user;
\set ORIGINAL_USER :USER
\c - regress_dblink_user
SELECT dblink_connect('myconn', 'fdtest');
dblink_connect
-−-−-−-−-−-−-−-−
OK
(1 row)
SELECT * FROM dblink('myconn', 'SELECT * FROM foo') AS t(a int, b text, c text[]);
a  | b |       c
-−-−+-−-+-−-−-−-−-−-−-−-
0 | a | {a0,b0,c0}
1 | b | {a1,b1,c1}
2 | c | {a2,b2,c2}
3 | d | {a3,b3,c3}
4 | e | {a4,b4,c4}
5 | f | {a5,b5,c5}
6 | g | {a6,b6,c6}
7 | h | {a7,b7,c7}
8 | i | {a8,b8,c8}
9 | j | {a9,b9,c9}
10 | k | {a10,b10,c10}
(11 rows)
\c - :ORIGINAL_USER
REVOKE USAGE ON FOREIGN SERVER fdtest FROM regress_dblink_user;
REVOKE SELECT ON TABLE foo FROM regress_dblink_user;
DROP USER MAPPING FOR regress_dblink_user SERVER fdtest;
DROP USER regress_dblink_user;
DROP SERVER fdtest;
上一页 上一级 下一页F.11. dblink — 连接到其他 PostgreSQL 数据库 起始页 dblink_connect_u
