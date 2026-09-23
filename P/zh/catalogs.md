# 第 52 章 系统目录

第 52 章 系统目录
版本：
纠错本页面
搜索
目录导航
❮
❯
第 52 章 系统目录目录52.1. 概述52.2. pg_aggregate52.3. pg_am52.4. pg_amop52.5. pg_amproc52.6. pg_attrdef52.7. pg_attribute52.8. pg_authid52.9. pg_auth_members52.10. pg_cast52.11. pg_class52.12. pg_collation52.13. pg_constraint52.14. pg_conversion52.15. pg_database52.16. pg_db_role_setting52.17. pg_default_acl52.18. pg_depend52.19. pg_description52.20. pg_enum52.21. pg_event_trigger52.22. pg_extension52.23. pg_foreign_data_wrapper52.24. pg_foreign_server52.25. pg_foreign_table52.26. pg_index52.27. pg_inherits52.28. pg_init_privs52.29. pg_language52.30. pg_largeobject52.31. pg_largeobject_metadata52.32. pg_namespace52.33. pg_opclass52.34. pg_operator52.35. pg_opfamily52.36. pg_parameter_acl52.37. pg_partitioned_table52.38. pg_policy52.39. pg_proc52.40. pg_publication52.41. pg_publication_namespace52.42. pg_publication_rel52.43. pg_range52.44. pg_replication_origin52.45. pg_rewrite52.46. pg_seclabel52.47. pg_sequence52.48. pg_shdepend52.49. pg_shdescription52.50. pg_shseclabel52.51. pg_statistic52.52. pg_statistic_ext52.53. pg_statistic_ext_data52.54. pg_subscription52.55. pg_subscription_rel52.56. pg_tablespace52.57. pg_transform52.58. pg_trigger52.59. pg_ts_config52.60. pg_ts_config_map52.61. pg_ts_dict52.62. pg_ts_parser52.63. pg_ts_template52.64. pg_type52.65. pg_user_mapping
系统目录是关系型数据库管理系统存放模式元数据的地方，比如表和列的信息，以及内部统计信息等。PostgreSQL的系统目录就是普通表。你可以删除并重建这些表、增加列、插入和更新数值，然后彻底把你的系统搞垮。通常情况下，我们不应该手工修改系统目录，通常有SQL命令可以做这些事情。（例如，CREATE DATABASE向 pg_database表插入一行 — 并且实际上在磁盘上创建该数据库。）有几种特别深奥的操作例外，但是随着时间的流逝其中的很多也可以用 SQL 命令来完成，因此对系统目录直接修改的需求也越来越小。
上一页 上一级 下一页51.6. 执行器 起始页 52.1. 概述
