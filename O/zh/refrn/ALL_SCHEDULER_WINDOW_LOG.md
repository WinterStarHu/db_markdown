# ALL_SCHEDULER_WINDOW_LOG

`ALL_SCHEDULER_WINDOW_LOG` 显示当前用户可访问的 Scheduler 窗口的日志信息。

相关视图
`DBA_SCHEDULER_WINDOW_LOG` 显示数据库中所有 Scheduler 窗口的日志信息。

| Column | Datatype | NULL | 说明 |
|---|---|---|---|
| LOG_ID | NUMBER | NOT NULL | 日志条目的唯一标识符 |
| LOG_DATE | TIMESTAMP(6) WITH TIME ZONE |  | 日志条目的日期 |
| OWNER | VARCHAR2(128) |  | Scheduler 窗口的属主 |
| WINDOW_NAME | VARCHAR2(261) |  | Scheduler 窗口的名称 |
| OPERATION | VARCHAR2(30) |  | 对应于该日志条目的操作 |
| STATUS | VARCHAR2(30) |  | 操作的状态（若适用） |
| USER_NAME | VARCHAR2(128) |  | 执行该操作的用户名称（若适用） |
| CLIENT_ID | VARCHAR2(64) |  | 执行该操作的用户的客户端标识符（若适用） |
| GLOBAL_UID | VARCHAR2(32) |  | 执行该操作的用户的全局用户标识符（若适用） |
| ADDITIONAL_INFO | CLOB |  | 该条目的附加信息（若适用） |

参见：
"DBA_SCHEDULER_WINDOW_LOG"
