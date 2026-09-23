# ALL_SCHEDULER_CHAIN_RULES

`ALL_SCHEDULER_CHAIN_RULES` 显示当前用户可访问的链（即用户对其拥有 `ALTER` 或 `EXECUTE` 权限的链）的规则信息。

相关视图
- `DBA_SCHEDULER_CHAIN_RULES` 显示数据库中所有链的规则信息。
- `USER_SCHEDULER_CHAIN_RULES` 显示当前用户拥有的链的规则信息。此视图不显示 `OWNER` 列。

| Column | Datatype | NULL | 说明 |
|---|---|---|---|
| OWNER | VARCHAR2(128) | NOT NULL | 规则所在 Scheduler 链的属主 |
| CHAIN_NAME | VARCHAR2(128) | NOT NULL | 规则所在 Scheduler 链的名称 |
| RULE_OWNER | VARCHAR2(128) | NOT NULL | 规则的属主 |
| RULE_NAME | VARCHAR2(128) |  | 规则的名称 |
| CONDITION | VARCHAR2(4000) |  | 触发该规则的布尔条件 |
| ACTION | VARCHAR2(4000) |  | 规则被触发时要执行的动作 |
| COMMENTS | VARCHAR2(4000) |  | 用户对该规则指定的注释 |

参见：
- "DBA_SCHEDULER_CHAIN_RULES"
- "USER_SCHEDULER_CHAIN_RULES"
