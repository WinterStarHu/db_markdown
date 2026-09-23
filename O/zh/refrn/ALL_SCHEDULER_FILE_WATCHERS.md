# ALL_SCHEDULER_FILE_WATCHERS

`ALL_SCHEDULER_FILE_WATCHERS` 显示当前用户可访问的 Scheduler 文件监视请求的信息。

相关视图
- `DBA_SCHEDULER_FILE_WATCHERS` 显示数据库中所有 Scheduler 文件监视请求的信息。
- `USER_SCHEDULER_FILE_WATCHERS` 显示当前用户拥有的 Scheduler 文件监视请求的信息。此视图不显示 `OWNER` 列。

| Column | Datatype | NULL | 说明 |
|---|---|---|---|
| OWNER | VARCHAR2(128) | NOT NULL | 文件监视请求的属主 |
| FILE_WATCHER_NAME | VARCHAR2(128) | NOT NULL | 文件监视请求的名称 |
| ENABLED | VARCHAR2(5) |  | 指示该文件监视请求是否已启用（TRUE）或已禁用（FALSE） |
| DESTINATION_OWNER | VARCHAR2(261) |  | 命名目标对象的属主 |
| DESTINATION | VARCHAR2(261) |  | 目标对象的名称 |
| DIRECTORY_PATH | VARCHAR2(4000) | NOT NULL | 文件将到达的目录路径名称 |
| FILE_NAME | VARCHAR2(512) | NOT NULL | 指定需要监视的文件的名称或模式 |
| CREDENTIAL_OWNER | VARCHAR2(128) |  | 用于授权该文件监视的凭据的属主 |
| CREDENTIAL_NAME | VARCHAR2(128) |  | 用于授权该文件监视的凭据的名称 |
| MIN_FILE_SIZE | NUMBER | NOT NULL | 被监视文件的最小大小 |
| STEADY_STATE_DURATION | INTERVAL DAY(3) TO SECOND(0) |  | 在断定文件已停止增长之前需等待的时间 |
| LAST_MODIFIED_TIME | TIMESTAMP(6) WITH TIME ZONE |  | 该文件监视器上次被修改的时间 |
| COMMENTS | VARCHAR2(4000) |  | 该文件监视请求的注释 |

参见：
- "DBA_SCHEDULER_FILE_WATCHERS"
- "USER_SCHEDULER_FILE_WATCHERS"
