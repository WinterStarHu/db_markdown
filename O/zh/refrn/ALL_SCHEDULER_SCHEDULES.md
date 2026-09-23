# ALL_SCHEDULER_SCHEDULES

`ALL_SCHEDULER_SCHEDULES` 显示当前用户可访问的 Scheduler 计划（schedule）的信息。

相关视图
- `DBA_SCHEDULER_SCHEDULES` 显示数据库中所有 Scheduler 计划的信息。
- `USER_SCHEDULER_SCHEDULES` 显示当前用户拥有的 Scheduler 计划的信息。此视图不显示 `OWNER` 列。

| Column | Datatype | NULL | 说明 |
|---|---|---|---|
| OWNER | VARCHAR2(128) | NOT NULL | 计划的属主 |
| SCHEDULE_NAME | VARCHAR2(128) | NOT NULL | 计划的名称 |
| SCHEDULE_TYPE | VARCHAR2(12) |  | 计划的类型：ONCE - 重复间隔为 NULL；CALENDAR - 用 Oracle 日历表达式作为计划；EVENT - 事件计划 |
| START_DATE | TIMESTAMP(6) WITH TIME ZONE |  | 重复间隔的起始日期 |
| REPEAT_INTERVAL | VARCHAR2(4000) |  | 该计划的日历语法表达式 |
| EVENT_QUEUE_OWNER | VARCHAR2(128) |  | 事件将被引发到的源队列的属主 |
| EVENT_QUEUE_NAME | VARCHAR2(128) |  | 事件将被引发到的源队列的名称 |
| EVENT_QUEUE_AGENT | VARCHAR2(523) |  | 用户在事件源队列上使用的 AQ 代理名称（若为安全队列） |
| EVENT_CONDITION | VARCHAR2(4000) |  | 用作源队列上事件订阅规则的布尔表达式 |
| FILE_WATCHER_OWNER | VARCHAR2(261) |  | 该计划所基于的文件监视器（file watcher）的属主 |
| FILE_WATCHER_NAME | VARCHAR2(261) |  | 该计划所基于的文件监视器的名称 |
| END_DATE | TIMESTAMP(6) WITH TIME ZONE |  | 截止日期，超过后该计划不再指定任何日期 |
| COMMENTS | VARCHAR2(4000) |  | 该计划的注释 |

参见：
- "DBA_SCHEDULER_SCHEDULES"
- "USER_SCHEDULER_SCHEDULES"
