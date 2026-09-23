# ALL_SCHEDULER_JOB_RUN_DETAILS

`ALL_SCHEDULER_JOB_RUN_DETAILS` 显示当前用户可访问的 Scheduler 作业的日志运行明细。

相关视图
- `DBA_SCHEDULER_JOB_RUN_DETAILS` 显示数据库中所有 Scheduler 作业的日志运行明细。
- `USER_SCHEDULER_JOB_RUN_DETAILS` 显示当前用户拥有的 Scheduler 作业的日志运行明细。

| Column | Datatype | NULL | 说明 |
|---|---|---|---|
| LOG_ID | NUMBER | NOT NULL | 日志条目的唯一标识符（*_SCHEDULER_JOB_LOG 视图的外键） |
| LOG_DATE | TIMESTAMP(6) WITH TIME ZONE |  | 日志条目的日期 |
| OWNER | VARCHAR2(128) |  | Scheduler 作业的属主 |
| JOB_NAME | VARCHAR2(261) |  | Scheduler 作业的名称 |
| JOB_SUBNAME | VARCHAR2(261) |  | Scheduler 作业的子名（用于运行链步骤的作业） |
| STATUS | VARCHAR2(30) |  | 作业运行的状态 |
| ERROR# | NUMBER |  | 发生错误时的错误号 |
| REQ_START_DATE | TIMESTAMP(6) WITH TIME ZONE |  | 作业运行的请求开始日期 |
| ACTUAL_START_DATE | TIMESTAMP(6) WITH TIME ZONE |  | 作业实际运行的日期 |
| RUN_DURATION | INTERVAL DAY(3) TO SECOND(0) |  | 作业运行的持续时间 |
| INSTANCE_ID | NUMBER |  | 运行该作业的实例的标识符 |
| SESSION_ID | VARCHAR2(128) |  | 作业运行的会话标识符 |
| SLAVE_PID | VARCHAR2(30) |  | 运行该作业的工作进程标识符 |
| CPU_USED | INTERVAL DAY(3) TO SECOND(2) |  | 作业运行使用的 CPU 量 |
| CREDENTIAL_OWNER | VARCHAR2(261) |  | 此次远程作业运行所用凭据的属主 |
| CREDENTIAL_NAME | VARCHAR2(261) |  | 此次远程作业运行所用凭据的名称 |
| DESTINATION_OWNER | VARCHAR2(261) |  | 此次远程作业运行所用目标对象的属主；若未使用对象则为 NULL |
| DESTINATION | VARCHAR2(261) |  | 远程作业操作的目标 |
| ADDITIONAL_INFO | VARCHAR2(4000) |  | 该作业运行的附加信息（若适用） |
| ERRORS | VARCHAR2(4000) |  | 此次作业运行生成的错误消息 |
| OUTPUT | VARCHAR2(4000) |  | 此次作业运行生成的输出消息 |
| BINARY_ERRORS | BLOB |  | 此次作业运行生成的二进制格式错误消息 |
| BINARY_OUTPUT | BLOB |  | 此次作业运行生成的二进制输出消息 |

参见：
- "DBA_SCHEDULER_JOB_RUN_DETAILS"
- "USER_SCHEDULER_JOB_RUN_DETAILS"
