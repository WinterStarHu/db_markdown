# 第 53 章 系统视图

第 53 章 系统视图
版本：
纠错本页面
搜索
目录导航
❮
❯
第 53 章 系统视图目录53.1. 概述53.2. pg_aios53.3. pg_available_extensions53.4. pg_available_extension_versions53.5. pg_backend_memory_contexts53.6. pg_config53.7. pg_cursors53.8. pg_file_settings53.9. pg_group53.10. pg_hba_file_rules53.11. pg_ident_file_mappings53.12. pg_indexes53.13. pg_locks53.14. pg_matviews53.15. pg_policies53.16. pg_prepared_statements53.17. pg_prepared_xacts53.18. pg_publication_tables53.19. pg_replication_origin_status53.20. pg_replication_slots53.21. pg_roles53.22. pg_rules53.23. pg_seclabels53.24. pg_sequences53.25. pg_settings53.26. pg_shadow53.27. pg_shmem_allocations53.28. pg_shmem_allocations_numa53.29. pg_stats53.30. pg_stats_ext53.31. pg_stats_ext_exprs53.32. pg_tables53.33. pg_timezone_abbrevs53.34. pg_timezone_names53.35. pg_user53.36. pg_user_mappings53.37. pg_views53.38. pg_wait_events
除了系统目录外，PostgreSQL还提供了一些内置视图。
一些系统视图提供了对系统目录上一些常用查询的便捷访问。其他视图提供了对内部服务器状态的访问。
信息模式(第 35 章)提供了一组与系统视图功能重叠的替代视图。
由于信息模式是SQL标准，而这里描述的视图是PostgreSQL特定的，
如果信息模式提供了您需要的所有信息，通常最好使用信息模式。
表 53.1列出了这里描述的系统视图。
每个视图的更详细文档如下所示。
还有一些额外的视图，提供对累积统计数据的访问；它们在
表 27.2中描述。
上一页 上一级 下一页52.65. pg_user_mapping 起始页 53.1. 概述
