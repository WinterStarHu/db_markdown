# 第 27 章 监控数据库活动

第 27 章 监控数据库活动
版本：
纠错本页面
搜索
目录导航
❮
❯
第 27 章 监控数据库活动目录27.1. 标准 Unix 工具27.2. 累计统计系统27.2.1. 统计收集配置27.2.2. 查看统计信息27.2.3. pg_stat_activity27.2.4. pg_stat_replication27.2.5. pg_stat_replication_slots27.2.6. pg_stat_wal_receiver27.2.7. pg_stat_recovery_prefetch27.2.8. pg_stat_subscription27.2.9. pg_stat_subscription_stats27.2.10. pg_stat_ssl27.2.11. pg_stat_gssapi27.2.12. pg_stat_archiver27.2.13. pg_stat_io27.2.14. pg_stat_bgwriter27.2.15. pg_stat_checkpointer27.2.16. pg_stat_wal27.2.17. pg_stat_database27.2.18. pg_stat_database_conflicts27.2.19. pg_stat_all_tables27.2.20. pg_stat_all_indexes27.2.21. pg_statio_all_tables27.2.22. pg_statio_all_indexes27.2.23. pg_statio_all_sequences27.2.24. pg_stat_user_functions27.2.25. pg_stat_slru27.2.26. Statistics Functions27.3. 查看锁27.4. 进度报告27.4.1. ANALYZE 进度报告27.4.2. CLUSTER 进度报告27.4.3. COPY 进度报告27.4.4. CREATE INDEX 进度报告27.4.5. VACUUM 进度报告27.4.6. 基础备份进度报告27.5. 动态追踪27.5.1. 动态追踪的编译27.5.2. 内置探针27.5.3. 使用探针27.5.4. 定义新探针27.6. 监控磁盘使用情况27.6.1. 确定磁盘用量27.6.2. 磁盘满错误
一个数据库管理员常常会疑惑，“系统现在正在做什么？”这一章会讨论如何搞清楚这个问题。
有几种工具可用于监视数据库活动和分析性能。本章大部分内容都用于描述PostgreSQL的累积统计系统，
但不应忽视常规的Unix监控程序，如ps、top、iostat和vmstat。
此外，一旦确定了性能不佳的查询，可能需要进一步调查，使用PostgreSQL的EXPLAIN命令。
第 14.1 节讨论了EXPLAIN和其他方法，以了解单个查询的行为。
上一页 上一级 下一页26.4. 热备 起始页 27.1. 标准 Unix 工具
