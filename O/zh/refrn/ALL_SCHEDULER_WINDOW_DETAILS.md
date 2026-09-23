# ALL_SCHEDULER_WINDOW_DETAILS

`ALL_SCHEDULER_WINDOW_DETAILS` 显示当前用户可访问的 Scheduler 窗口的日志明细。

相关视图
`DBA_SCHEDULER_WINDOW_DETAILS` 显示数据库中所有 Scheduler 窗口的日志明细。

| Column | Datatype | NULL | 说明 |
|---|---|---|---|
| LOG_ID | NUMBER |  | 日志条目的唯一标识符（*_SCHEDULER_WINDOW_LOG 视图的外键） |
| LOG_DATE | TIMESTAMP(6) WITH TIME ZONE |  | 日志条目的日期 |
| OWNER | VARCHAR2(128) |  | Scheduler 窗口的属主 |
| WINDOW_NAME | VARCHAR2(261) |  | Scheduler 窗口的名称 |
| REQ_START_DATE | TIMESTAMP(6) WITH TIME ZONE |  | Scheduler 窗口的请求开始日期 |
| ACTUAL_START_DATE | TIMESTAMP(6) WITH TIME ZONE |  | Scheduler 窗口的实际开始日期 |
| WINDOW_DURATION | INTERVAL DAY(3) TO SECOND(0) |  | Scheduler 窗口的请求持续时间 |
| ACTUAL_DURATION | INTERVAL DAY(3) TO SECOND(0) |  | Scheduler 窗口的实际持续时间 |
| INSTANCE_ID | NUMBER |  | 运行该窗口的实例的标识符 |
| ADDITIONAL_INFO | VARCHAR2(4000) |  | 该条目的附加信息（若适用） |

参见：
"DBA_SCHEDULER_WINDOW_DETAILS"
