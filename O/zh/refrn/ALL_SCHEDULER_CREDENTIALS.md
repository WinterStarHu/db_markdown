# ALL_SCHEDULER_CREDENTIALS

`ALL_SCHEDULER_CREDENTIALS` 显示当前用户可访问的凭据（credential）的信息（即用户对其拥有 `ALTER` 或 `EXECUTE` 权限的凭据）。

注意：
此视图已弃用，由 `ALL_CREDENTIALS` 视图取代。Oracle 建议改用 `ALL_CREDENTIALS`。`ALL_SCHEDULER_CREDENTIALS` 仅出于向后兼容而保留。

相关视图
- `DBA_SCHEDULER_CREDENTIALS` 显示数据库中所有凭据的信息。
- `USER_SCHEDULER_CREDENTIALS` 显示当前用户拥有的凭据的信息。此视图不显示 `OWNER` 列。

| Column | Datatype | NULL | 说明 |
|---|---|---|---|
| OWNER | VARCHAR2(128) | NOT NULL | Scheduler 凭据的属主 |
| CREDENTIAL_NAME | VARCHAR2(128) | NOT NULL | Scheduler 凭据的名称 |
| USERNAME | VARCHAR2(128) |  | 用于登录远程数据库或操作系统的用户名称 |
| DATABASE_ROLE | VARCHAR2(9) |  | 对于数据库目标，登录时使用的数据库角色：SYSDBA、SYSOPER |
| WINDOWS_DOMAIN | VARCHAR2(30) |  | 对于 Windows 目标，登录时使用的 Windows 域 |
| COMMENTS | VARCHAR2(4000) |  | 该凭据的注释 |

参见：
- "ALL_CREDENTIALS"
- "DBA_SCHEDULER_CREDENTIALS"
- "USER_SCHEDULER_CREDENTIALS"
