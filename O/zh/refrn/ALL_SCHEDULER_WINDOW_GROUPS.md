# ALL_SCHEDULER_WINDOW_GROUPS

`ALL_SCHEDULER_WINDOW_GROUPS` 显示当前用户可访问的 Scheduler 窗口组（window group）的信息。

相关视图
`DBA_SCHEDULER_WINDOW_GROUPS` 显示数据库中所有 Scheduler 窗口组的信息。

| Column | Datatype | NULL | 说明 |
|---|---|---|---|
| WINDOW_GROUP_NAME | VARCHAR2(128) | NOT NULL | 窗口组的名称 |
| ENABLED | VARCHAR2(5) |  | 指示窗口组是否已启用（TRUE）或已禁用（FALSE） |
| NUMBER_OF_WINDOWS | NUMBER |  | 窗口组中的成员数量 |
| NEXT_START_DATE | VARCHAR2(64) |  | 若窗口组被禁用，则此列为 NULL；否则为组内已启用窗口中最早的 NEXT_START_DATE |
| COMMENTS | VARCHAR2(4000) |  | 关于窗口组的可选注释 |

参见：
"DBA_SCHEDULER_WINDOW_GROUPS"
