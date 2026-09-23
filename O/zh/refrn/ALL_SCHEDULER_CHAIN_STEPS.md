# ALL_SCHEDULER_CHAIN_STEPS

`ALL_SCHEDULER_CHAIN_STEPS` 显示当前用户可访问的链（即用户对其拥有 `ALTER` 或 `EXECUTE` 权限的链）的已定义步骤信息。

相关视图
- `DBA_SCHEDULER_CHAIN_STEPS` 显示数据库中所有链的已定义步骤信息。
- `USER_SCHEDULER_CHAIN_STEPS` 显示当前用户拥有的链的已定义步骤信息。此视图不显示 `OWNER` 列。

| Column | Datatype | NULL | 说明 |
|---|---|---|---|
| OWNER | VARCHAR2(128) | NOT NULL | 步骤所在 Scheduler 链的属主 |
| CHAIN_NAME | VARCHAR2(128) | NOT NULL | 步骤所在 Scheduler 链的名称 |
| STEP_NAME | VARCHAR2(128) | NOT NULL | 链步骤的名称 |
| PROGRAM_OWNER | VARCHAR2(392) |  | 在该步骤中运行的程序的属主 |
| PROGRAM_NAME | VARCHAR2(392) |  | 在该步骤中运行的程序的名称 |
| EVENT_SCHEDULE_OWNER | VARCHAR2(392) |  | 该步骤所等待的事件计划的属主 |
| EVENT_SCHEDULE_NAME | VARCHAR2(392) |  | 该步骤所等待的事件计划的名称 |
| EVENT_QUEUE_OWNER | VARCHAR2(128) |  | 事件将被引发到的源队列的属主 |
| EVENT_QUEUE_NAME | VARCHAR2(128) |  | 事件将被引发到的源队列的名称 |
| EVENT_QUEUE_AGENT | VARCHAR2(523) |  | 用户在事件源队列上使用的 AQ 代理名称（用于安全队列） |
| EVENT_CONDITION | VARCHAR2(4000) |  | 用作源队列上事件订阅规则的布尔表达式 |
| CREDENTIAL_OWNER | VARCHAR2(128) |  | 用于外部步骤作业的凭据的属主 |
| CREDENTIAL_NAME | VARCHAR2(128) |  | 用于外部步骤作业的凭据的名称 |
| DESTINATION | VARCHAR2(261) |  | 远程步骤作业将在其上运行的目标主机 |
| SKIP | VARCHAR2(5) |  | 指示该步骤是否应被跳过（TRUE）或不跳过（FALSE） |
| PAUSE | VARCHAR2(5) |  | 指示该步骤运行后是否应暂停（TRUE）或不暂停（FALSE） |
| PAUSE_BEFORE | VARCHAR2(5) |  | 指示该步骤运行前是否应暂停（TRUE）或不暂停（FALSE） |
| RESTART_ON_RECOVERY | VARCHAR2(5) |  | 指示数据库恢复时是否应重启该步骤（TRUE）或不重启（FALSE） |
| RESTART_ON_FAILURE | VARCHAR2(5) |  | 指示应用失败时是否应重启该步骤（TRUE）或不重启（FALSE） |
| STEP_TYPE | VARCHAR2(21) |  | 步骤的类型：EVENT_SCHEDULE、INLINE_EVENT、SUBCHAIN、PROGRAM |
| TIMEOUT | INTERVAL DAY(3) TO SECOND(0) |  | 等待事件计划的超时时间 |

参见：
- "DBA_SCHEDULER_CHAIN_STEPS"
- "USER_SCHEDULER_CHAIN_STEPS"
