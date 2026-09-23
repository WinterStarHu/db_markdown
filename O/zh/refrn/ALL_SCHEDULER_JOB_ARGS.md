# ALL_SCHEDULER_JOB_ARGS

`ALL_SCHEDULER_JOB_ARGS` 显示当前用户可访问的 Scheduler 作业的参数信息。

相关视图
- `DBA_SCHEDULER_JOB_ARGS` 显示数据库中所有 Scheduler 作业的参数信息。
- `USER_SCHEDULER_JOB_ARGS` 显示当前用户拥有的 Scheduler 作业的参数信息。此视图不显示 `OWNER` 列。

| Column | Datatype | NULL | 说明 |
|---|---|---|---|
| OWNER | VARCHAR2(128) |  | 该参数所属作业的属主 |
| JOB_NAME | VARCHAR2(128) |  | 该参数所属作业的名称 |
| ARGUMENT_NAME | VARCHAR2(128) |  | 参数的可选名称 |
| ARGUMENT_POSITION | NUMBER |  | 参数在参数列表中的位置 |
| ARGUMENT_TYPE | VARCHAR2(257) |  | 参数的数据类型 |
| VALUE | VARCHAR2(4000) |  | 若参数为字符串，则为该参数的值（字符串格式） |
| ANYDATA_VALUE | ANYDATA |  | 该参数的值（AnyData 格式） |
| OUT_ARGUMENT | VARCHAR2(5) |  | 保留供将来使用 |

参见：
- "DBA_SCHEDULER_JOB_ARGS"
- "USER_SCHEDULER_JOB_ARGS"
