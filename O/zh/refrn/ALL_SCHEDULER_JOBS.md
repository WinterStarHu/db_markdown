# ALL_SCHEDULER_JOBS

`ALL_SCHEDULER_JOBS` 显示当前用户可访问的 Scheduler 作业的信息。

相关视图
- `DBA_SCHEDULER_JOBS` 显示数据库中所有 Scheduler 作业的信息。
- `USER_SCHEDULER_JOBS` 显示当前用户拥有的 Scheduler 作业的信息。此视图不显示 `OWNER` 列。

| Column | Datatype | NULL | 说明 |
|---|---|---|---|
| OWNER | VARCHAR2(128) |  | Scheduler 作业的属主 |
| JOB_NAME | VARCHAR2(128) |  | Scheduler 作业的名称 |
| JOB_SUBNAME | VARCHAR2(128) |  | Scheduler 作业的子名（用于运行链步骤的作业） |
| JOB_STYLE | VARCHAR2(17) |  | 作业样式：REGULAR、LIGHTWEIGHT、IN_MEMORY_RUNTIME、IN_MEMORY_FULL |
| JOB_CREATOR | VARCHAR2(128) |  | 作业的原始创建者 |
| CLIENT_ID | VARCHAR2(65) |  | 创建该作业的用户的客户端标识符 |
| GLOBAL_UID | VARCHAR2(33) |  | 创建该作业的用户的全局用户标识符 |
| PROGRAM_OWNER | VARCHAR2(4000) |  | 与该作业关联的程序的属主 |
| PROGRAM_NAME | VARCHAR2(4000) |  | 与该作业关联的程序的名称 |
| JOB_TYPE | VARCHAR2(16) |  | 内联作业动作类型：PLSQL_BLOCK、STORED_PROCEDURE、EXECUTABLE、CHAIN、SQL_SCRIPT、BACKUP_SCRIPT、EXTERNAL_SCRIPT |
| JOB_ACTION | VARCHAR2(4000) |  | 内联作业动作 |
| NUMBER_OF_ARGUMENTS | NUMBER |  | 内联作业参数个数 |
| SCHEDULE_OWNER | VARCHAR2(4000) |  | 该作业所用计划的属主（可以是窗口或窗口组） |
| SCHEDULE_NAME | VARCHAR2(4000) |  | 该作业所用计划的名称（可以是窗口或窗口组） |
| SCHEDULE_TYPE | VARCHAR2(12) |  | 该作业所用计划的类型：IMMEDIATE - 开始日期和重复间隔为 NULL；ONCE - 重复间隔为 NULL；PLSQL - 用 PL/SQL 表达式作为计划；CALENDAR - 用 Oracle 日历表达式作为计划；EVENT - 事件计划；NAMED - 命名计划；WINDOW - 用窗口作为计划；WINDOW_GROUP - 用窗口组作为计划 |
| START_DATE | TIMESTAMP(6) WITH TIME ZONE |  | 作业的原始计划开始日期（用于内联计划） |
| REPEAT_INTERVAL | VARCHAR2(4000) |  | 内联计划的 PL/SQL 表达式或日历字符串 |
| EVENT_QUEUE_OWNER | VARCHAR2(128) |  | 事件将被引发到的源队列的属主 |
| EVENT_QUEUE_NAME | VARCHAR2(128) |  | 事件将被引发到的源队列的名称 |
| EVENT_QUEUE_AGENT | VARCHAR2(523) |  | 用户在事件源队列上使用的 AQ 代理名称（若为安全队列） |
| EVENT_CONDITION | VARCHAR2(4000) |  | 用作源队列上事件订阅规则的布尔表达式 |
| EVENT_RULE | VARCHAR2(261) |  | 协调器用来触发基于事件的作业所使用的规则名称 |
| FILE_WATCHER_OWNER | VARCHAR2(261) |  | 该作业所基于的文件监视器的属主 |
| FILE_WATCHER_NAME | VARCHAR2(261) |  | 该作业所基于的文件监视器的名称 |
| END_DATE | TIMESTAMP(6) WITH TIME ZONE |  | 超过此日期后作业将不再运行（用于内联计划） |
| JOB_CLASS | VARCHAR2(128) |  | 与该作业关联的作业类的名称 |
| ENABLED | VARCHAR2(5) |  | 指示作业是否已启用（TRUE）或已禁用（FALSE） |
| AUTO_DROP | VARCHAR2(5) |  | 指示作业完成时是否会被删除（TRUE）或不删除（FALSE） |
| RESTART_ON_RECOVERY | VARCHAR2(5) |  | 指示数据库恢复时是否应重启该步骤（TRUE）或不重启（FALSE） |
| RESTART_ON_FAILURE | VARCHAR2(5) |  | 指示应用失败时是否应重启该步骤（TRUE）或不重启（FALSE） |
| STATE | VARCHAR2(20) |  | 作业的当前状态：BLOCKED、BROKEN、CHAIN_STALLED、COMPLETED、DISABLED、FAILED、READY TO RUN、REMOTE、RESOURCE_UNAVAILABLE、RETRY SCHEDULED、RUNNING、SCHEDULED、SOME FAILED、STOPPED、SUCCEEDED |
| JOB_PRIORITY | NUMBER |  | 作业相对于同一作业类中其他作业的优先级 |
| RUN_COUNT | NUMBER |  | 该作业已运行的次数 |
| UPTIME_RUN_COUNT | NUMBER |  | 自数据库上次重启以来的运行次数。对于内存中作业，此列已填充，但 RUN_COUNT 列未填充。对于所有其他作业，此列为 NULL |
| MAX_RUNS | NUMBER |  | 该作业计划运行的最大次数 |
| FAILURE_COUNT | NUMBER |  | 该作业运行失败的次数 |
| UPTIME_FAILURE_COUNT | NUMBER |  | 自数据库上次重启以来的失败次数。对于内存中作业，此列已填充，但 FAILURE_COUNT 列未填充。对于所有其他作业，此列为 NULL |
| MAX_FAILURES | NUMBER |  | 作业在被标记为 broken 之前允许失败的次数 |
| RETRY_COUNT | NUMBER |  | 该作业已重试的次数（若正在重试） |
| LAST_START_DATE | TIMESTAMP(6) WITH TIME ZONE |  | 该作业上次开始运行的日期 |
| LAST_RUN_DURATION | INTERVAL DAY(9) TO SECOND(6) |  | 该作业上次运行期间完成所花费的时间 |
| NEXT_RUN_DATE | TIMESTAMP(6) WITH TIME ZONE |  | 该作业计划下次运行的日期 |
| SCHEDULE_LIMIT | INTERVAL DAY(3) TO SECOND(0) |  | 尚未运行的作业在此时间之后将被重新调度 |
| MAX_RUN_DURATION | INTERVAL DAY(3) TO SECOND(0) |  | 允许该作业运行的最长时间 |
| LOGGING_LEVEL | VARCHAR2(11) |  | 针对该作业记录日志的数量：OFF、RUNS、FAILED RUNS、FULL |
| STORE_OUTPUT | VARCHAR2(5) |  | 指示该作业的所有作业输出消息是否存储在已记录日志的作业运行所对应的 *_JOB_RUN_DETAILS 视图的 OUTPUT 列中。可能取值：TRUE - 该作业的所有作业输出消息都存储在已记录日志的作业运行所对应的 *_JOB_RUN_DETAILS 视图的 OUTPUT 列中。这是新作业的默认值（新作业指使用 Oracle Database 12c 软件创建的作业）。FALSE - 该作业的作业输出消息不存储在 *_JOB_RUN_DETAILS 视图的 OUTPUT 列中。这是现有作业的默认值（现有作业指使用 Oracle Database 12c 之前软件创建的作业） |
| STOP_ON_WINDOW_CLOSE | VARCHAR2(5) |  | 指示与该作业关联的窗口关闭时作业是否会停止（TRUE）或不停止（FALSE） |
| INSTANCE_STICKINESS | VARCHAR2(5) |  | 指示该作业是否为粘性（sticky）（TRUE）或否（FALSE） |
| RAISE_EVENTS | VARCHAR2(4000) |  | 要为该作业引发的作业事件列表：JOB_STARTED、JOB_SUCCEEDED、JOB_FAILED、JOB_BROKEN、JOB_COMPLETED、JOB_STOPPED、JOB_SCH_LIM_REACHED、JOB_DISABLED、JOB_CHAIN_STALLED、JOB_OVER_MAX_DUR |
| SYSTEM | VARCHAR2(5) |  | 指示该作业是否为系统作业（TRUE）或否（FALSE） |
| JOB_WEIGHT | NUMBER |  | 作业的权重 |
| NLS_ENV | VARCHAR2(4000) |  | 该作业的 NLS 环境 |
| SOURCE | VARCHAR2(128) |  | 源全局数据库标识符 |
| NUMBER_OF_DESTINATIONS | NUMBER |  | 与该作业关联的目标数量 |
| DESTINATION_OWNER | VARCHAR2(261) |  | 所用目标对象的属主（若使用），否则为 NULL |
| DESTINATION | VARCHAR2(261) |  | 该作业将在其上运行的目标 |
| CREDENTIAL_OWNER | VARCHAR2(128) |  | 用于外部作业的凭据的属主 |
| CREDENTIAL_NAME | VARCHAR2(128) |  | 用于外部作业的凭据的名称 |
| INSTANCE_ID | NUMBER |  | 用户请求该作业在其上运行的实例 |
| DEFERRED_DROP | VARCHAR2(5) |  | 指示作业是否因用户请求而在完成时被删除（TRUE）或否（FALSE） |
| ALLOW_RUNS_IN_RESTRICTED_MODE | VARCHAR2(5) |  | 指示是否允许该作业在受限会话模式下运行（TRUE）或否（FALSE） |
| COMMENTS | VARCHAR2(4000) |  | 该作业的注释 |
| FLAGS | NUMBER |  | 此列供内部使用 |
| RESTARTABLE | VARCHAR2(5) |  | 指示该作业是否可被重启（TRUE）或否（FALSE） |
| HAS_CONSTRAINTS | VARCHAR2(5) |  | 指示该作业（不含作业的程序部分）是否属于某个资源约束或不兼容组（TRUE）或否（FALSE） |
| CONNECT_CREDENTIAL_OWNER | VARCHAR2(128) |  | 连接凭据的属主 |
| CONNECT_CREDENTIAL_NAME | VARCHAR2(128) |  | 连接凭据的名称 |
| FAIL_ON_SCRIPT_ERROR | VARCHAR2(5) |  | 指示该作业在脚本出错时是否失败（TRUE）或否（FALSE） |

参见：
- "DBA_SCHEDULER_JOBS"
- "USER_SCHEDULER_JOBS"
