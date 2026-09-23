# ALL_SCHEDULER_WINDOWS

`ALL_SCHEDULER_WINDOWS` 显示当前用户可访问的 Scheduler 窗口（window）的信息。

相关视图
`DBA_SCHEDULER_WINDOWS` 显示数据库中所有 Scheduler 窗口的信息。

| Column | Datatype | NULL | 说明 |
|---|---|---|---|
| OWNER | VARCHAR2(128) | NOT NULL | Scheduler 窗口的属主 |
| WINDOW_NAME | VARCHAR2(128) | NOT NULL | Scheduler 窗口的名称 |
| RESOURCE_PLAN | VARCHAR2(128) |  | 与该窗口关联的资源计划 |
| SCHEDULE_OWNER | VARCHAR2(4000) |  | 该窗口所用计划的属主 |
| SCHEDULE_NAME | VARCHAR2(4000) |  | 该窗口所用计划的名称 |
| SCHEDULE_TYPE | VARCHAR2(8) |  | 该窗口所用计划的类型：ONCE - 重复间隔为 NULL；NAMED - 命名计划；CALENDAR - 用 Oracle 日历表达式作为计划 |
| START_DATE | TIMESTAMP(6) WITH TIME ZONE |  | 窗口的起始日期（用于内联计划） |
| REPEAT_INTERVAL | VARCHAR2(4000) |  | 窗口的日历字符串（用于内联计划） |
| END_DATE | TIMESTAMP(6) WITH TIME ZONE |  | 超过此日期后窗口不再打开（用于内联计划） |
| DURATION | INTERVAL DAY(3) TO SECOND(0) |  | 窗口的持续时间 |
| WINDOW_PRIORITY | VARCHAR2(4) |  | 窗口相对于其他窗口的优先级：HIGH、LOW |
| NEXT_START_DATE | TIMESTAMP(6) WITH TIME ZONE |  | 窗口计划下次开始的日期 |
| LAST_START_DATE | TIMESTAMP(6) WITH TIME ZONE |  | 窗口上次打开的日期 |
| ENABLED | VARCHAR2(5) |  | 指示窗口是否已启用（TRUE）或已禁用（FALSE） |
| ACTIVE | VARCHAR2(5) |  | 指示窗口是否处于打开状态（TRUE）或未打开（FALSE） |
| MANUAL_OPEN_TIME | TIMESTAMP(6) WITH TIME ZONE |  | 若窗口是手动打开的，则为打开时间；否则为 NULL |
| MANUAL_DURATION | INTERVAL DAY(3) TO SECOND(0) |  | 若窗口是手动打开的，则为持续时间；否则为 NULL |
| COMMENTS | VARCHAR2(4000) |  | 该窗口的注释 |

参见：
"DBA_SCHEDULER_WINDOWS"
