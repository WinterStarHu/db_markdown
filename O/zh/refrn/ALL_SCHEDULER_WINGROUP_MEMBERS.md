# ALL_SCHEDULER_WINGROUP_MEMBERS

`ALL_SCHEDULER_WINGROUP_MEMBERS` 显示当前用户可访问的 Scheduler 窗口组的成员。

相关视图
`DBA_SCHEDULER_WINGROUP_MEMBERS` 显示数据库中所有 Scheduler 窗口组的成员。

| Column | Datatype | NULL | 说明 |
|---|---|---|---|
| WINDOW_GROUP_NAME | VARCHAR2(128) | NOT NULL | 窗口组的名称 |
| WINDOW_NAME | VARCHAR2(128) | NOT NULL | 该窗口组中作为成员的窗口的名称 |

参见：
"DBA_SCHEDULER_WINGROUP_MEMBERS"
