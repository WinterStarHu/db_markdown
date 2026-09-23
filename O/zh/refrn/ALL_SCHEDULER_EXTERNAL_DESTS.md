# ALL_SCHEDULER_EXTERNAL_DESTS

`ALL_SCHEDULER_EXTERNAL_DESTS` 显示当前用户可访问的、指向远程代理的目标对象的信息。

相关视图
`DBA_SCHEDULER_EXTERNAL_DESTS` 显示数据库中所有指向远程代理的目标对象的信息。

| Column | Datatype | NULL | 说明 |
|---|---|---|---|
| OWNER | VARCHAR2(128) | NOT NULL | 该目标对象的属主 |
| DESTINATION_NAME | VARCHAR2(128) | NOT NULL | 该目标对象的名称 |
| HOSTNAME | VARCHAR2(256) |  | 代理所在主机的名称或 IP 地址 |
| PORT | NUMBER |  | 代理监听的端口 |
| IP_ADDRESS | VARCHAR2(64) |  | 代理所在主机的 IP 地址 |
| ENABLED | VARCHAR2(5) |  | 指示该目标对象是否已启用（TRUE）或已禁用（FALSE） |
| COMMENTS | VARCHAR2(4000) |  | 可选注释 |

参见：
"DBA_SCHEDULER_EXTERNAL_DESTS"
