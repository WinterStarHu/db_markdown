# ALTER USER

ALTER USER
版本：
纠错本页面
搜索
目录导航
❮
❯
ALTER USERALTER USER — 更改数据库角色大纲
ALTER USER role_specification [ WITH ] option [ ... ]
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
ALTER USER name RENAME TO new_name
ALTER USER { role_specification | ALL } [ IN DATABASE database_name ] SET configuration_parameter { TO | = } { value | DEFAULT }
ALTER USER { role_specification | ALL } [ IN DATABASE database_name ] SET configuration_parameter FROM CURRENT
ALTER USER { role_specification | ALL } [ IN DATABASE database_name ] RESET configuration_parameter
ALTER USER { role_specification | ALL } [ IN DATABASE database_name ] RESET ALL
其中 role_specification 可以是：
role_name
| CURRENT_ROLE
| CURRENT_USER
| SESSION_USER
描述
ALTER USER现在是
ALTER ROLE的一种别名。
兼容性
ALTER USER语句是一种
PostgreSQL扩展。SQL 标准把用户的定义留给
实现来处理。
另见ALTER ROLE上一页 上一级 下一页ALTER TYPE 起始页 ALTER USER MAPPING
