# ALL_SCHEDULER_RESOURCES

`ALL_SCHEDULER_RESOURCES` 显示数据库中当前用户可访问的所有调度器资源对象。

相关视图
- `DBA_SCHEDULER_RESOURCES` 显示数据库中所有调度器资源对象。
- `USER_SCHEDULER_RESOURCES` 显示数据库中当前用户 schema 下的所有调度器资源对象。此视图不显示 `OWNER` 列。

| Column | Datatype | NULL | 说明 |
|---|---|---|---|
| OWNER | VARCHAR2(128) | NOT NULL | 资源对象的属主 |
| RESOURCE_NAME | VARCHAR2(128) | NOT NULL | 资源对象的名称 |
| STATUS | VARCHAR2(19) |  | 资源对象的状态 |
| RESOURCE_UNITS | NUMBER |  | 该资源对象可用的最大单元数 |
| UNITS_USED | NUMBER |  | 该资源对象当前正在使用的资源单元数 |
| JOBS_RUNNING_COUNT | NUMBER |  | 当前使用该资源对象的正在运行的作业数量 |
| COMMENTS | VARCHAR2(256) |  | 该资源对象的注释 |

参见：
- "DBA_SCHEDULER_RESOURCES"
- "USER_SCHEDULER_RESOURCES"
