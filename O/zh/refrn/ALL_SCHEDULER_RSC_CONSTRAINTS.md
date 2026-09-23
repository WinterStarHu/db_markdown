# ALL_SCHEDULER_RSC_CONSTRAINTS

`ALL_SCHEDULER_RSC_CONSTRAINTS` 列出当前用户可访问的所有 Oracle Scheduler 资源约束成员。

相关视图
- `DBA_SCHEDULER_RSC_CONSTRAINTS` 列出数据库中所有 Oracle Scheduler 资源约束成员。
- `USER_SCHEDULER_RSC_CONSTRAINTS` 列出当前用户拥有的所有 Oracle Scheduler 资源约束成员。

| Column | Datatype | NULL | 说明 |
|---|---|---|---|
| OBJECT_OWNER | VARCHAR2(128) | NOT NULL | 该成员所属资源对象的属主 |
| OBJECT_NAME | VARCHAR2(128) | NOT NULL | 该成员所属资源对象的名称 |
| RESOURCE_OWNER | VARCHAR2(128) | NOT NULL | 资源约束资源成员的属主 |
| RESOURCE_NAME | VARCHAR2(128) | NOT NULL | 资源约束资源成员的名称 |
| UNITS_USED | NUMBER |  | 该约束资源成员所使用的该资源的单元数 |

参见：
- "DBA_SCHEDULER_RSC_CONSTRAINTS"
- "USER_SCHEDULER_RSC_CONSTRAINTS"
