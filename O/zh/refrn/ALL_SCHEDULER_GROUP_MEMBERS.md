# ALL_SCHEDULER_GROUP_MEMBERS

`ALL_SCHEDULER_GROUP_MEMBERS` 显示当前用户可访问的 Scheduler 对象组的成员信息。

相关视图
- `DBA_SCHEDULER_GROUP_MEMBERS` 显示数据库中所有 Scheduler 对象组的成员信息。
- `USER_SCHEDULER_GROUP_MEMBERS` 显示当前用户拥有的 Scheduler 对象组的成员信息。此视图不显示 `OWNER` 列。

| Column | Datatype | NULL | 说明 |
|---|---|---|---|
| OWNER | VARCHAR2(128) | NOT NULL | 组的属主 |
| GROUP_NAME | VARCHAR2(128) | NOT NULL | 组的名称 |
| MEMBER_NAME | VARCHAR2(523) |  | 该组成员的名称 |

参见：
- "DBA_SCHEDULER_GROUP_MEMBERS"
- "USER_SCHEDULER_GROUP_MEMBERS"
