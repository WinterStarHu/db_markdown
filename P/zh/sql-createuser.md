# CREATE USER

CREATE USER
版本：
纠错本页面
搜索
目录导航
❮
❯
CREATE USERCREATE USER — 定义一个新的数据库角色大纲
CREATE USER name [ [ WITH ] option [ ... ] ]
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
CREATE USER现在是
CREATE ROLE的一个别名。唯一的区别是
CREATE USER中LOGIN
被作为默认值，而NOLOGIN是
CREATE ROLE的默认值。
兼容性
CREATE USER语句是一种
PostgreSQL扩展。SQL 标准
把用户的定义留给实现来解释。
另见CREATE ROLE上一页 上一级 下一页CREATE TYPE 起始页 CREATE USER MAPPING
