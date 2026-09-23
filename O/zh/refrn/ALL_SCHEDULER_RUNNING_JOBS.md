# ALL_SCHEDULER_RUNNING_JOBS

`ALL_SCHEDULER_RUNNING_JOBS` 显示当前用户可访问的正在运行的 Scheduler 作业的信息。

相关视图
- `DBA_SCHEDULER_RUNNING_JOBS` 显示数据库中所有正在运行的 Scheduler 作业的信息。
- `USER_SCHEDULER_RUNNING_JOBS` 显示当前用户拥有的正在运行的 Scheduler 作业的信息。此视图不显示 `OWNER` 列。

| Column | Datatype | NULL | 说明 |
|---|---|---|---|
| OWNER | VARCHAR2(128) |  | 正在运行的 Scheduler 作业的属主 |
| JOB_NAME | VARCHAR2(128) |  | 正在运行的 Scheduler 作业的名称 |
| JOB_SUBNAME | VARCHAR2(128) |  | 正在运行的 Scheduler 作业的子名（用于运行链步骤的作业） |
| JOB_STYLE | VARCHAR2(17) |  | 作业样式：REGULAR、LIGHTWEIGHT、IN_MEMORY_RUNTIME、IN_MEMORY_FULL |
| DETACHED | VARCHAR2(5) |  | 指示该作业是否设置了 detached 属性（TRUE）或未设置（FALSE）。若设置了 detached 属性，则即使作业动作已完成，作业仍会继续运行 |
| SESSION_ID | NUMBER |  | 运行该 Scheduler 作业的会话的标识符 |
| SLAVE_PROCESS_ID | NUMBER |  | 运行该 Scheduler 作业的工作进程的进程号 |
| SLAVE_OS_PROCESS_ID | VARCHAR2(12) |  | 运行该 Scheduler 作业的操作系统工作进程的进程号 |
| RUNNING_INSTANCE | NUMBER |  | 运行该 Scheduler 作业的工作进程所在的数据库实例号 |
| RESOURCE_CONSUMER_GROUP | VARCHAR2(32) |  | 运行该 Scheduler 作业的会话的资源使用者组 |
| ELAPSED_TIME | INTERVAL DAY(3) TO SECOND(2) |  | 自该 Scheduler 作业启动以来的耗时 |
| CPU_USED | INTERVAL DAY(3) TO SECOND(2) |  | 正在运行的 Scheduler 作业所消耗的 CPU 时间（若可用） |
| DESTINATION_OWNER | VARCHAR2(261) |  | 所用目标对象的属主（若使用），否则为 NULL |
| DESTINATION | VARCHAR2(261) |  | 该作业正在其上运行的目标 |
| CREDENTIAL_OWNER | VARCHAR2(128) |  | 用于此次正在运行的作业的登录凭据的属主（若有） |
| CREDENTIAL_NAME | VARCHAR2(128) |  | 用于此次正在运行的作业的登录凭据的名称（若有） |
| LOG_ID | NUMBER |  | 用于此次正在运行的作业的日志 ID。此列映射到 *_SCHEDULER_JOB_LOG 和 *_SCHEDULER_JOB_RUN_DETAILS 视图的 LOG_ID 列 |

参见：
- "DBA_SCHEDULER_RUNNING_JOBS"
- "USER_SCHEDULER_RUNNING_JOBS"
