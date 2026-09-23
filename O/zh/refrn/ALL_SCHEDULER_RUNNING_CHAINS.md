# ALL_SCHEDULER_RUNNING_CHAINS

`ALL_SCHEDULER_RUNNING_CHAINS` 显示当前用户可访问的正在运行的链（即用户对其拥有 `ALTER` 权限的链）的链步骤信息。对于嵌套链，此视图还允许你通过包含 `CONNECT BY` 子句、将 `JOB_SUBNAME` 与 `STEP_JOB_SUBNAME` 列关联起来的 SQL 语句来遍历链的层次结构。

相关视图
- `DBA_SCHEDULER_RUNNING_CHAINS` 显示数据库中所有正在运行的链的链步骤信息。
- `USER_SCHEDULER_RUNNING_CHAINS` 显示当前用户拥有的正在运行的链的链步骤信息。此视图不显示 `OWNER` 列。

| Column | Datatype | NULL | 说明 |
|---|---|---|---|
| OWNER | VARCHAR2(128) | NOT NULL | 运行该链的作业的属主 |
| JOB_NAME | VARCHAR2(128) | NOT NULL | 运行该链的作业的名称 |
| JOB_SUBNAME | VARCHAR2(128) |  | 运行该链的作业的子名（用于嵌套链），否则为 NULL |
| CHAIN_OWNER | VARCHAR2(128) | NOT NULL | 正在运行的链的属主 |
| CHAIN_NAME | VARCHAR2(128) | NOT NULL | 正在运行的链的名称 |
| STEP_NAME | VARCHAR2(128) | NOT NULL | 正在运行的链步骤的名称 |
| STATE | VARCHAR2(15) |  | 正在运行的链步骤的状态：NOT_STARTED、RUNNING、SUCCEEDED、STOPPED、FAILED、SCHEDULED、RETRY SCHEDULED、PAUSED、STALLED |
| ERROR_CODE | NUMBER |  | 步骤完成时（若已完成）所带的错误码 |
| COMPLETED | VARCHAR2(5) |  | 指示正在运行的链步骤是否已完成（TRUE）或未完成（FALSE） |
| START_DATE | TIMESTAMP(6) WITH TIME ZONE |  | 正在运行的链步骤开始的时间（若已开始） |
| END_DATE | TIMESTAMP(6) WITH TIME ZONE |  | 正在运行的链步骤停止的时间（若已停止） |
| DURATION | INTERVAL DAY(9) TO SECOND(6) |  | 该链步骤完成所花费的时间（若已完成） |
| SKIP | VARCHAR2(5) |  | 指示该链步骤是否应被跳过（TRUE）或不跳过（FALSE） |
| PAUSE | VARCHAR2(5) |  | 指示该链步骤运行后是否应暂停（TRUE）或不暂停（FALSE） |
| PAUSE_BEFORE | VARCHAR2(5) |  | 指示该链步骤运行前是否应暂停（TRUE）或不暂停（FALSE） |
| RESTART_ON_RECOVERY | VARCHAR2(5) |  | 指示数据库恢复时是否将重启该链步骤（TRUE）或不重启（FALSE） |
| RESTART_ON_FAILURE | VARCHAR2(5) |  | 指示应用失败时是否将重启该链步骤（TRUE）或不重启（FALSE） |
| STEP_JOB_SUBNAME | VARCHAR2(128) |  | 运行该步骤的作业的子名 |
| STEP_JOB_LOG_ID | NUMBER |  | 运行该步骤的作业的日志 ID |

参见：
- "DBA_SCHEDULER_RUNNING_CHAINS"
- "USER_SCHEDULER_RUNNING_CHAINS"
