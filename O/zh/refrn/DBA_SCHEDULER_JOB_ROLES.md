# DBA_SCHEDULER_JOB_ROLES

`DBA_SCHEDULER_JOB_ROLES` 按数据库角色显示数据库中所有 Scheduler 作业的信息。

| Column | Datatype | NULL | 说明 |
|---|---|---|---|
| OWNER | VARCHAR2(128) | NOT NULL | Scheduler 作业的属主 |
| JOB_NAME | VARCHAR2(128) | NOT NULL | Scheduler 作业的名称 |
| JOB_SUBNAME | VARCHAR2(128) |  | Scheduler 作业的子名（用于运行链步骤的作业） |
| JOB_CREATOR | VARCHAR2(128) |  | Scheduler 作业的创建者 |
| DATABASE_ROLE | VARCHAR2(16) |  | 数据库角色的名称 |
| PROGRAM_OWNER | VARCHAR2(4000) |  | 与该作业关联的程序的属主 |
| PROGRAM_NAME | VARCHAR2(4000) |  | 与该作业关联的程序的名称 |
| JOB_TYPE | VARCHAR2(16) |  | 内联作业动作类型：PLSQL_BLOCK、STORED_PROCEDURE、EXECUTABLE、CHAIN |
| JOB_ACTION | VARCHAR2(4000) |  | 内联作业动作 |
| JOB_CLASS | VARCHAR2(128) |  | 与该作业关联的作业类的名称 |
| SCHEDULE_OWNER | VARCHAR2(4000) |  | 该作业所用计划的属主（可以是窗口或窗口组） |
| SCHEDULE_NAME | VARCHAR2(4000) |  | 该作业所用计划的名称（可以是窗口或窗口组） |
| SCHEDULE_TYPE | VARCHAR2(12) |  | 该作业所用计划的类型：IMMEDIATE - 开始日期和重复间隔为 NULL；ONCE - 重复间隔为 NULL；PLSQL - 用 PL/SQL 表达式作为计划；CALENDAR - 用 Oracle 日历表达式作为计划；EVENT - 事件计划；NAMED - 命名计划；WINDOW - 用窗口作为计划；WINDOW_GROUP - 用窗口组作为计划 |
| START_DATE | TIMESTAMP(6) WITH TIME ZONE |  | 作业的原始计划开始日期（用于内联计划） |
| REPEAT_INTERVAL | VARCHAR2(4000) |  | 内联计划的 PL/SQL 表达式或日历字符串 |
| END_DATE | TIMESTAMP(6) WITH TIME ZONE |  | 超过此日期后作业将不再运行（用于内联计划） |
| LAST_START_DATE | TIMESTAMP(6) WITH TIME ZONE |  | 作业上次运行的日期 |
| ENABLED | VARCHAR2(5) |  | 指示作业是否已启用（TRUE）或已禁用（FALSE） |
| STATE | VARCHAR2(15) |  | 作业的当前状态：DISABLED、RETRY SCHEDULED、SCHEDULED、RUNNING、COMPLETED、BROKEN、FAILED、REMOTE、SUCCEEDED、CHAIN_STALLED |
| COMMENTS | VARCHAR2(4000) |  | 该作业的注释 |
