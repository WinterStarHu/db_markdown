# ALL_SCHEDULER_INCOMPAT_MEMBER

`ALL_SCHEDULER_INCOMPAT_MEMBER` 显示当前用户可访问的所有 Scheduler 不兼容资源对象的成员。

相关视图
- `DBA_SCHEDULER_INCOMPAT_MEMBER` 显示数据库中所有 Scheduler 不兼容资源对象的成员。
- `USER_SCHEDULER_INCOMPAT_MEMBER` 显示当前用户拥有的所有 Scheduler 不兼容资源对象的成员。

| Column | Datatype | NULL | 说明 |
|---|---|---|---|
| INCOMPATIBILITY_OWNER | VARCHAR2(128) | NOT NULL | 包含该成员的不兼容资源对象的属主 |
| INCOMPATIBILITY_NAME | VARCHAR2(128) | NOT NULL | 包含该成员的不兼容资源对象的名称 |
| OBJECT_OWNER | VARCHAR2(128) | NOT NULL | 不兼容资源成员的属主 |
| OBJECT_NAME | VARCHAR2(128) | NOT NULL | 不兼容资源成员的名称 |

参见：
- "DBA_SCHEDULER_INCOMPAT_MEMBER"
- "USER_SCHEDULER_INCOMPAT_MEMBER"
