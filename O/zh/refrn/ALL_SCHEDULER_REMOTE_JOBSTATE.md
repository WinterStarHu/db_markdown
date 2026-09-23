# ALL_SCHEDULER_REMOTE_JOBSTATE

`ALL_SCHEDULER_REMOTE_JOBSTATE` 显示当前用户可访问的作业在远程数据库上的状态信息。

相关视图
- `DBA_SCHEDULER_REMOTE_JOBSTATE` 显示所有作业在远程数据库上的状态信息。
- `USER_SCHEDULER_REMOTE_JOBSTATE` 显示当前用户拥有的作业在远程数据库上的状态信息。此视图不显示 `OWNER` 列。

| Column | Datatype | NULL | 说明 |
|---|---|---|---|
| OWNER | VARCHAR2(128) | NOT NULL | Scheduler 作业的属主 |
| JOB_NAME | VARCHAR2(128) | NOT NULL | Scheduler 作业的名称 |
| DESTINATION | VARCHAR2(512) | NOT NULL | 作业目标的名称 |
| STATE | VARCHAR2(15) |  | 作业在该目标上的状态：DISABLED、RETRY SCHEDULED、SCHEDULED、RUNNING、COMPLETED、BROKEN、FAILED、SUCCEEDED、STOPPED |
| NEXT_START_DATE | TIMESTAMP(6) WITH TIME ZONE |  | 作业在该目标上的下次开始日期 |
| RUN_COUNT | NUMBER |  | 作业在该目标上的运行次数 |
| FAILURE_COUNT | NUMBER |  | 作业在该目标上的失败次数 |
| RETRY_COUNT | NUMBER |  | 作业在该目标上的重试次数 |
| LAST_START_DATE | TIMESTAMP(6) WITH TIME ZONE |  | 作业在该目标上的上次开始日期 |
| LAST_END_DATE | TIMESTAMP(6) WITH TIME ZONE |  | 作业在该目标上的上次结束日期 |

参见：
- "DBA_SCHEDULER_REMOTE_JOBSTATE"
- "USER_SCHEDULER_REMOTE_JOBSTATE"
