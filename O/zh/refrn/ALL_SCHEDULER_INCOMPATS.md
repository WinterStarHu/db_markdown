# ALL_SCHEDULER_INCOMPATS

`ALL_SCHEDULER_INCOMPATS` 显示当前用户可访问的所有 Scheduler 不兼容资源对象。

相关视图
- `DBA_SCHEDULER_INCOMPATS` 显示数据库中所有 Scheduler 不兼容资源对象。
- `USER_SCHEDULER_INCOMPATS` 显示当前用户拥有的所有 Scheduler 不兼容资源对象。此视图不显示 `OWNER` 列。

| Column | Datatype | NULL | 说明 |
|---|---|---|---|
| OWNER | VARCHAR2(128) | NOT NULL | 不兼容资源对象的属主 |
| INCOMPATIBILITY_NAME | VARCHAR2(128) | NOT NULL | 不兼容资源对象的名称 |
| CONSTRAINT_LEVEL | VARCHAR2(13) |  | JOB_LEVEL 或 PROGRAM_LEVEL。默认值 JOB_LEVEL 表示：基于 DBMS_SCHEDULER.CREATE_INCOMPATIBILITY 过程的 object_name 参数中所提及程序（或多个程序）的作业，同一时刻只能有一个运行。PROGRAM_LEVEL 表示这些程序之间互不兼容，但基于同一程序的作业之间并非不兼容 |
| ENABLED | VARCHAR2(5) |  | 指示该不兼容对象是否已启用（TRUE）或未启用（FALSE） |
| JOBS_RUNNING_COUNT | NUMBER |  | 当前使用该不兼容资源对象的正在运行的作业数量 |
| COMMENTS | VARCHAR2(256) |  | 该资源不兼容对象的注释 |

参见：
- "DBA_SCHEDULER_INCOMPATS"
- "USER_SCHEDULER_INCOMPATS"
