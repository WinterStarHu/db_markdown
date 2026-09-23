# ALL_SCHEDULER_PROGRAMS

`ALL_SCHEDULER_PROGRAMS` 显示当前用户可访问的 Scheduler 程序（program）的信息。

相关视图
- `DBA_SCHEDULER_PROGRAMS` 显示数据库中所有 Scheduler 程序的信息。
- `USER_SCHEDULER_PROGRAMS` 显示当前用户拥有的 Scheduler 程序的信息。此视图不显示 `OWNER` 列。

| Column | Datatype | NULL | 说明 |
|---|---|---|---|
| OWNER | VARCHAR2(128) | NOT NULL | Scheduler 程序的属主 |
| PROGRAM_NAME | VARCHAR2(128) | NOT NULL | Scheduler 程序的名称 |
| PROGRAM_TYPE | VARCHAR2(16) |  | 程序动作的类型：PLSQL_BLOCK、STORED_PROCEDURE、EXECUTABLE |
| PROGRAM_ACTION | VARCHAR2(4000) |  | 指定程序动作的字符串 |
| NUMBER_OF_ARGUMENTS | NUMBER |  | 该程序接受的参数个数 |
| ENABLED | VARCHAR2(5) |  | 指示程序是否已启用（TRUE）或已禁用（FALSE） |
| DETACHED | VARCHAR2(5) |  | 此列供内部使用 |
| SCHEDULE_LIMIT | INTERVAL DAY(3) TO SECOND(0) |  | 在计划开始时间之后运行该程序的最大延迟 |
| PRIORITY | NUMBER |  | 程序的优先级 |
| WEIGHT | NUMBER |  | 程序的权重 |
| MAX_RUNS | NUMBER |  | 基于该程序的任何作业的最大运行次数 |
| MAX_FAILURES | NUMBER |  | 基于该程序的任何作业的最大失败次数 |
| MAX_RUN_DURATION | INTERVAL DAY(3) TO SECOND(0) |  | 该程序可运行的最长时间 |
| HAS_CONSTRAINTS | VARCHAR2(5) |  | 指示作业（不含作业的程序部分）是否属于某个资源约束或不兼容组（TRUE）或不属于（FALSE） |
| NLS_ENV | VARCHAR2(4000) |  | 创建该程序时的 NLS 环境 |
| COMMENTS | VARCHAR2(4000) |  | 该程序的注释 |

参见：
- "DBA_SCHEDULER_PROGRAMS"
- "USER_SCHEDULER_PROGRAMS"
