# ALL_SCHEDULER_REMOTE_DATABASES

`ALL_SCHEDULER_REMOTE_DATABASES` 显示当前用户可访问的、已注册为远程数据库作业源和目标的远程数据库的信息。

相关视图
`DBA_SCHEDULER_REMOTE_DATABASES` 显示已注册为远程数据库作业源和目标的所有远程数据库的信息。

| Column | Datatype | NULL | 说明 |
|---|---|---|---|
| DATABASE_NAME | VARCHAR2(512) | NOT NULL | 远程数据库的全局名 |
| REGISTERED_AS | VARCHAR2(11) |  | 指示该数据库是注册为源（SOURCE）还是目标（DESTINATION） |
| DATABASE_LINK | VARCHAR2(512) | NOT NULL | 指向该远程数据库的有效数据库链接的名称 |

参见：
"DBA_SCHEDULER_REMOTE_DATABASES"
