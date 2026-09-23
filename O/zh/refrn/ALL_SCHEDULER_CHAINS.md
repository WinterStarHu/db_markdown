# ALL_SCHEDULER_CHAINS

`ALL_SCHEDULER_CHAINS` 显示当前用户可访问的链（chain）的信息（即用户对其拥有 `ALTER` 或 `EXECUTE` 权限的链）。

相关视图
- `DBA_SCHEDULER_CHAINS` 显示数据库中所有链的信息。
- `USER_SCHEDULER_CHAINS` 显示当前用户拥有的链的信息。此视图不显示 `OWNER` 列。

| Column | Datatype | NULL | 说明 |
|---|---|---|---|
| OWNER | VARCHAR2(128) | NOT NULL | Scheduler 链的属主 |
| CHAIN_NAME | VARCHAR2(128) | NOT NULL | Scheduler 链的名称 |
| RULE_SET_OWNER | VARCHAR2(128) |  | 描述依赖关系的规则集的属主 |
| RULE_SET_NAME | VARCHAR2(128) |  | 描述依赖关系的规则集的名称 |
| NUMBER_OF_RULES | NUMBER |  | 链中规则的数量 |
| NUMBER_OF_STEPS | NUMBER |  | 链中已定义步骤的数量 |
| ENABLED | VARCHAR2(5) |  | 指示链是否已启用（TRUE）或已禁用（FALSE） |
| EVALUATION_INTERVAL | INTERVAL DAY(3) TO SECOND(0) |  | 重新评估链规则的周期性间隔 |
| USER_RULE_SET | VARCHAR2(5) |  | 指示链是否使用用户指定的规则集（TRUE）或不使用（FALSE） |
| COMMENTS | VARCHAR2(4000) |  | 该链的注释 |

参见：
- "DBA_SCHEDULER_CHAINS"
- "USER_SCHEDULER_CHAINS"
