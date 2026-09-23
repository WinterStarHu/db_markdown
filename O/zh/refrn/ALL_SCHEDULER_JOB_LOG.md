# ALL_SCHEDULER_JOB_LOG

`ALL_SCHEDULER_JOB_LOG` 显示当前用户可访问的 Scheduler 作业的日志信息。

相关视图
- `DBA_SCHEDULER_JOB_LOG` 显示数据库中所有 Scheduler 作业的日志信息。
- `USER_SCHEDULER_JOB_LOG` 显示当前用户拥有的 Scheduler 作业的日志信息。

| Column | Datatype | NULL | 说明 |
|---|---|---|---|
| LOG_ID | NUMBER | NOT NULL | 标识一行的唯一标识符 |
| LOG_DATE | TIMESTAMP(6) WITH TIME ZONE |  | 日志条目的日期 |
| OWNER | VARCHAR2(128) |  | Scheduler 作业的属主 |
| JOB_NAME | VARCHAR2(261) |  | Scheduler 作业的名称 |
| JOB_SUBNAME | VARCHAR2(261) |  | Scheduler 作业的子名（用于运行链步骤的作业） |
| JOB_CLASS | VARCHAR2(128) |  | 记录该条目时作业所属的作业类 |
| OPERATION | VARCHAR2(30) |  | 对应于该日志条目的操作 |
| STATUS | VARCHAR2(30) |  | 操作的状态（若适用）。此列的可能取值取决于 OPERATION 列的值。多数情况下 STATUS 为 NULL。仅对作业运行操作才会有值。当 OPERATION 为下列之一时 STATUS 为 NULL：CREATE - 作业已创建；UPDATE - 一个或多个作业属性已被修改；ENABLE - 作业已被启用；DISABLE - 作业已被禁用；COMPLETED - 仅对重复作业，作业已到达其结束日期或最大运行次数；BROKEN - 作业已达最大失败次数。当 OPERATION 为下列之一时，STATUS 可为 SUCCEEDED（作业运行成功完成）、FAILED（作业运行失败）或 STOPPED（作业运行被停止）：RUN - 常规作业运行；RETRY_RUN - 因上次运行出错且 RESTARTABLE 为 TRUE 而正在重试的作业；RECOVERY_RUN - 因数据库宕机或作业工作进程崩溃且 RESTARTABLE 为 TRUE 而正在重新运行的作业 |
| USER_NAME | VARCHAR2(128) |  | 执行该操作的用户名称（若适用） |
| CLIENT_ID | VARCHAR2(64) |  | 执行该操作的用户的客户端标识符（若适用） |
| GLOBAL_UID | VARCHAR2(32) |  | 执行该操作的用户的全局用户标识符（若适用） |
| CREDENTIAL_OWNER | VARCHAR2(261) |  | 此次远程作业运行所用凭据的属主 |
| CREDENTIAL_NAME | VARCHAR2(261) |  | 此次远程作业运行所用凭据的名称 |
| DESTINATION_OWNER | VARCHAR2(261) |  | 此次远程作业运行所用目标对象的属主；若未使用对象则为 NULL |
| DESTINATION | VARCHAR2(261) |  | 远程作业操作的目标 |
| ADDITIONAL_INFO | CLOB |  | 该条目的附加信息（若适用） |

参见：
- "DBA_SCHEDULER_JOB_LOG"
- "USER_SCHEDULER_JOB_LOG"
