# ALL_SCHEDULER_JOB_DESTS

`ALL_SCHEDULER_JOB_DESTS` 显示当前用户可访问的作业在各自每个目标上的状态信息。

相关视图
- `DBA_SCHEDULER_JOB_DESTS` 显示数据库中所有作业在各自每个目标上的状态信息。
- `USER_SCHEDULER_JOB_DESTS` 显示当前用户拥有的作业在各自每个目标上的状态信息。此视图不显示 `OWNER` 列。

| Column | Datatype | NULL | 说明 |
|---|---|---|---|
| OWNER | VARCHAR2(128) |  | Scheduler 作业的属主 |
| JOB_NAME | VARCHAR2(128) |  | Scheduler 作业的名称 |
| JOB_SUBNAME | VARCHAR2(128) |  | Scheduler 作业的子名 |
| CREDENTIAL_OWNER | VARCHAR2(128) |  | 用于该远程目标的凭据的属主 |
| CREDENTIAL_NAME | VARCHAR2(128) |  | 用于该远程目标的凭据的名称 |
| DESTINATION_OWNER | VARCHAR2(261) |  | 指向该目标的目标对象的属主 |
| DESTINATION | VARCHAR2(261) |  | 目标对象的名称，或目标本身的名称 |
| JOB_DEST_ID | NUMBER |  | 该作业在此目标上分配的数字 ID |
| ENABLED | VARCHAR2(5) |  | 指示父作业是否已启用（TRUE）或已禁用（FALSE） |
| REFS_ENABLED | VARCHAR2(5) |  | 指示该目标及其代理是否已启用（TRUE）或已禁用（FALSE） |
| STATE | VARCHAR2(15) |  | 该作业在此目标上的状态：DISABLED、RUNNING、CHAIN_STALLED、SCHEDULED、RETRY SCHEDULED、READY TO RUN、COMPLETED、BROKEN、FAILED、SUCCEEDED、REMOTE、STOPPED |
| NEXT_START_DATE | TIMESTAMP(6) WITH TIME ZONE |  | 该作业在此目标上的下次启动时间 |
| RUN_COUNT | NUMBER |  | 该作业在此目标上已运行的次数 |
| RETRY_COUNT | NUMBER |  | 该作业在此目标上已重试的次数 |
| FAILURE_COUNT | NUMBER |  | 该作业在此目标上已失败的次数 |
| LAST_START_DATE | TIMESTAMP(6) WITH TIME ZONE |  | 该作业在此目标上上次启动的时间 |
| LAST_END_DATE | TIMESTAMP(6) WITH TIME ZONE |  | 该作业在此目标上上次结束的时间 |

参见：
- "DBA_SCHEDULER_JOB_DESTS"
- "USER_SCHEDULER_JOB_DESTS"
