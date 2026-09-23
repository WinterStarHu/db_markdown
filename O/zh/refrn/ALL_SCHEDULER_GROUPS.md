# ALL_SCHEDULER_GROUPS

`ALL_SCHEDULER_GROUPS` 显示当前用户可访问的 Scheduler 对象组的信息。

相关视图
- `DBA_SCHEDULER_GROUPS` 显示数据库中所有 Scheduler 对象组的信息。
- `USER_SCHEDULER_GROUPS` 显示当前用户拥有的 Scheduler 对象组的信息。此视图不显示 `OWNER` 列。

| Column | Datatype | NULL | 说明 |
|---|---|---|---|
| OWNER | VARCHAR2(128) | NOT NULL | 组的属主 |
| GROUP_NAME | VARCHAR2(128) | NOT NULL | 组的名称 |
| GROUP_TYPE | VARCHAR2(13) |  | 组所含对象的类型：WINDOW、JOB、DB_DEST、EXTERNAL_DEST |
| ENABLED | VARCHAR2(5) |  | 指示组是否已启用（TRUE）或已禁用（FALSE） |
| NUMBER_OF_MEMBERS | NUMBER |  | 该组中的成员数量 |
| COMMENTS | VARCHAR2(4000) |  | 关于该组的可选注释 |

参见：
- "DBA_SCHEDULER_GROUPS"
- "USER_SCHEDULER_GROUPS"
