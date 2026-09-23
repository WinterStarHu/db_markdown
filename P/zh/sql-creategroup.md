# CREATE GROUP

CREATE GROUP
版本：
纠错本页面
搜索
目录导航
❮
❯
CREATE GROUPCREATE GROUP — 定义一个新的数据库角色大纲
CREATE GROUP name [ [ WITH ] option [ ... ] ]
其中 option 可以是：
SUPERUSER | NOSUPERUSER
| CREATEDB | NOCREATEDB
| CREATEROLE | NOCREATEROLE
| INHERIT | NOINHERIT
| LOGIN | NOLOGIN
| REPLICATION | NOREPLICATION
| BYPASSRLS | NOBYPASSRLS
| CONNECTION LIMIT connlimit
| [ ENCRYPTED ] PASSWORD 'password' | PASSWORD NULL
| VALID UNTIL 'timestamp'
| IN ROLE role_name [, ...]
| IN GROUP role_name [, ...]
| ROLE role_name [, ...]
| ADMIN role_name [, ...]
| USER role_name [, ...]
| SYSID uid
描述
CREATE GROUP 现在是
CREATE ROLE的一种别名。
兼容性
在 SQL 标准中没有 CREATE GROUP 语句。
另见CREATE ROLE上一页 上一级 下一页CREATE FUNCTION 起始页 CREATE INDEX
