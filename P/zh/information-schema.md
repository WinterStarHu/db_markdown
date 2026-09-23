# 第 35 章 信息模式

第 35 章 信息模式
版本：
纠错本页面
搜索
目录导航
❮
❯
第 35 章 信息模式目录35.1. 模式35.2. 数据类型35.3. information_schema_catalog_name35.4. administrable_role_​authorizations35.5. applicable_roles35.6. attributes35.7. character_sets35.8. check_constraint_routine_usage35.9. check_constraints35.10. collations35.11. collation_character_set_​applicability35.12. column_column_usage35.13. column_domain_usage35.14. column_options35.15. column_privileges35.16. column_udt_usage35.17. columns35.18. constraint_column_usage35.19. constraint_table_usage35.20. data_type_privileges35.21. domain_constraints35.22. domain_udt_usage35.23. domains35.24. element_types35.25. enabled_roles35.26. foreign_data_wrapper_options35.27. foreign_data_wrappers35.28. foreign_server_options35.29. foreign_servers35.30. foreign_table_options35.31. foreign_tables35.32. key_column_usage35.33. parameters35.34. referential_constraints35.35. role_column_grants35.36. role_routine_grants35.37. role_table_grants35.38. role_udt_grants35.39. role_usage_grants35.40. routine_column_usage35.41. routine_privileges35.42. routine_routine_usage35.43. routine_sequence_usage35.44. routine_table_usage35.45. routines35.46. schemata35.47. sequences35.48. sql_features35.49. sql_implementation_info35.50. sql_parts35.51. sql_sizing35.52. table_constraints35.53. table_privileges35.54. tables35.55. transforms35.56. triggered_update_columns35.57. triggers35.58. udt_privileges35.59. usage_privileges35.60. user_defined_types35.61. user_mapping_options35.62. user_mappings35.63. view_column_usage35.64. view_routine_usage35.65. view_table_usage35.66. views
信息模式由一组视图构成，它们包含定义在当前数据库中对象的信息。信息模式以 SQL 标准定义，因此能够被移植并且保持稳定 — 系统目录则不同，它们是与PostgreSQL相关的并且是为了实现的考虑而建模的。不过，信息模式视图不包含与PostgreSQL-特定特性有关的信息。要查询那些信息你需要查询系统目录或其他PostgreSQL-特定视图。
注意
当在数据库中查询约束信息时，一个期望返回一行的标准兼容的查询可能返回多行。这是因为 SQL 标准要求约束名在一个模式中唯一，但是PostgreSQL并不强制这种限制。PostgreSQL自动产生的约束名避免在相同的模式中重复，但是用户可以指定这种重复的名称。
这个问题可能在查询信息模式视图时出现，例如check_constraint_routine_usage、
check_constraints、domain_constraints和
referential_constraints。一些其他视图也有相似的问题，但是它们包含了表名来帮助区分重复行，例如constraint_column_usage、
constraint_table_usage、table_constraints。
上一页 上一级 下一页34.17. 内部 起始页 35.1. 模式
