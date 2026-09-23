# ALL_SCHEDULER_DESTS

`ALL_SCHEDULER_DESTS` 显示当前用户可访问的作业的目标对象的信息。

相关视图
- `DBA_SCHEDULER_DESTS` 显示数据库中所有作业目标对象的信息。
- `USER_SCHEDULER_DESTS` 显示当前用户拥有的作业目标对象的信息。此视图不显示 `OWNER` 列。

| Column | Datatype | NULL | 说明 |
|---|---|---|---|
| OWNER | VARCHAR2(128) | NOT NULL | 该目标对象的属主 |
| DESTINATION_NAME | VARCHAR2(128) | NOT NULL | 该目标对象的名称 |
| DESTINATION_TYPE | VARCHAR2(8) |  | 该目标对象的类型：EXTERNAL、DATABASE |
| ENABLED | VARCHAR2(5) |  | 指示该目标对象是否已启用（TRUE）或已禁用（FALSE） |
| COMMENTS | VARCHAR2(4000) |  | 可选注释 |

参见：
- "DBA_SCHEDULER_DESTS"
- "USER_SCHEDULER_DESTS"
