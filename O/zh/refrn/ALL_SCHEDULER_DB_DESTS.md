# ALL_SCHEDULER_DB_DESTS

`ALL_SCHEDULER_DB_DESTS` 显示当前用户可访问的、指向远程数据库的目标对象（destination object）的信息。

相关视图
- `DBA_SCHEDULER_DB_DESTS` 显示数据库中所有指向远程数据库的目标对象的信息。
- `USER_SCHEDULER_DB_DESTS` 显示当前用户拥有的、指向远程数据库的目标对象的信息。此视图不显示 `OWNER` 列。

| Column | Datatype | NULL | 说明 |
|---|---|---|---|
| OWNER | VARCHAR2(128) | NOT NULL | 该目标对象的属主 |
| DESTINATION_NAME | VARCHAR2(128) | NOT NULL | 该目标对象的名称 |
| CONNECT_INFO | VARCHAR2(4000) |  | 连接到远程数据库的连接字符串 |
| AGENT | VARCHAR2(128) |  | 通过其连接到远程数据库的代理名称 |
| ENABLED | VARCHAR2(5) |  | 指示该目标对象是否已启用（TRUE）或已禁用（FALSE） |
| REFS_ENABLED | VARCHAR2(5) |  | 指示所有被引用对象是否已启用（TRUE）或已禁用（FALSE） |
| COMMENTS | VARCHAR2(4000) |  | 可选注释 |

参见：
- "DBA_SCHEDULER_DB_DESTS"
- "USER_SCHEDULER_DB_DESTS"
