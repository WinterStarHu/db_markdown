# ALL_SCHEDULER_JOB_CLASSES

`ALL_SCHEDULER_JOB_CLASSES` 显示当前用户可访问的 Scheduler 作业类（job class）的信息。

相关视图
`DBA_SCHEDULER_JOB_CLASSES` 显示数据库中所有 Scheduler 作业类的信息。

| Column | Datatype | NULL | 说明 |
|---|---|---|---|
| OWNER | VARCHAR2(128) | NOT NULL | Scheduler 作业类的属主 |
| JOB_CLASS_NAME | VARCHAR2(128) | NOT NULL | Scheduler 作业类的名称 |
| RESOURCE_CONSUMER_GROUP | VARCHAR2(128) |  | 与该作业类关联的资源使用者组 |
| SERVICE | VARCHAR2(64) |  | 该作业类所关联服务的名称 |
| LOGGING_LEVEL | VARCHAR2(11) |  | 针对该作业类记录日志的数量：OFF、RUNS、FAILED RUNS、FULL |
| LOG_HISTORY | NUMBER |  | 该作业类在作业日志中保留的历史天数 |
| COMMENTS | VARCHAR2(4000) |  | 该作业类的注释 |

参见：
"DBA_SCHEDULER_JOB_CLASSES"
