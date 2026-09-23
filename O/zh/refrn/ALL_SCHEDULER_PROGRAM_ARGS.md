# ALL_SCHEDULER_PROGRAM_ARGS

`ALL_SCHEDULER_PROGRAM_ARGS` 显示当前用户可访问的 Scheduler 程序的参数信息。

相关视图
- `DBA_SCHEDULER_PROGRAM_ARGS` 显示数据库中所有 Scheduler 程序的参数信息。
- `USER_SCHEDULER_PROGRAM_ARGS` 显示当前用户拥有的 Scheduler 程序的参数信息。此视图不显示 `OWNER` 列。

| Column | Datatype | NULL | 说明 |
|---|---|---|---|
| OWNER | VARCHAR2(128) | NOT NULL | 该参数所属程序的属主 |
| PROGRAM_NAME | VARCHAR2(128) | NOT NULL | 该参数所属程序的名称 |
| ARGUMENT_NAME | VARCHAR2(128) |  | 参数的可选名称 |
| ARGUMENT_POSITION | NUMBER | NOT NULL | 参数在参数列表中的位置 |
| ARGUMENT_TYPE | VARCHAR2(257) |  | 参数的数据类型 |
| METADATA_ATTRIBUTE | VARCHAR2(19) |  | 元数据属性：JOB_NAME、JOB_OWNER、JOB_START、WINDOW_START、WINDOW_END、JOB_SUBNAME、EVENT_MESSAGE、JOB_SCHEDULED_START |
| DEFAULT_VALUE | VARCHAR2(4000) |  | 若参数为字符串，则为该参数的默认值（字符串格式） |
| DEFAULT_ANYDATA_VALUE | ANYDATA |  | 该参数的默认值（AnyData 格式） |
| OUT_ARGUMENT | VARCHAR2(5) |  | 保留供将来使用 |

参见：
- "DBA_SCHEDULER_PROGRAM_ARGS"
- "USER_SCHEDULER_PROGRAM_ARGS"
