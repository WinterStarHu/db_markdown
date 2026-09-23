# 部分 IV. 客户端接口

部分 IV. 客户端接口
版本：
纠错本页面
搜索
目录导航
❮
❯
部分 IV. 客户端接口
本部分介绍随PostgreSQL分发的客户端编程接口。每章内容均可独立阅读。
有许多单独分发的外部客户端编程接口。它们包含自己的文档（附录 H
列出了一些较受欢迎的接口）。本部分的读者应熟悉使用SQL操作和查询数据库（参见
第 II 部分），当然还应熟悉所选的编程语言。
目录32. libpq — C 库32.1. 数据库连接控制函数32.2. 连接状态函数32.3. 命令执行函数32.4. 异步命令处理32.5. 管道模式32.6. 分块检索查询结果32.7. 取消进行中的查询32.8. 快速路径接口32.9. 异步通知32.10. COPY命令相关的函数32.11. 控制函数32.12. 杂项函数32.13. 通知处理32.14. 事件系统32.15. 环境变量32.16. 密码文件32.17. 连接服务文件32.18. 连接参数的 LDAP 查找32.19. SSL 支持32.20. OAuth 支持32.21. 线程化程序中的行为32.22. 构建 libpq 程序32.23. 示例程序33. 大对象33.1. 简介33.2. 实现特性33.3. 客户端接口33.4. 服务器端函数33.5. 示例程序34. ECPG — C中的嵌入式 SQL 34.1. 概念34.2. 管理数据库连接34.3. 运行 SQL 命令34.4. 使用主变量34.5. 动态 SQL34.6. pgtypes 库34.7. 使用描述符区域34.8. 错误处理34.9. 预处理器指令34.10. 处理嵌入式 SQL 程序34.11. 库函数34.12. 大对象34.13. C++ 应用34.14. 嵌入式 SQL 命令34.15. Informix 兼容模式34.16. Oracle 兼容模式34.17. 内部35. 信息模式35.1. 模式35.2. 数据类型35.3. information_schema_catalog_name35.4. administrable_role_​authorizations35.5. applicable_roles35.6. attributes35.7. character_sets35.8. check_constraint_routine_usage35.9. check_constraints35.10. collations35.11. collation_character_set_​applicability35.12. column_column_usage35.13. column_domain_usage35.14. column_options35.15. column_privileges35.16. column_udt_usage35.17. columns35.18. constraint_column_usage35.19. constraint_table_usage35.20. data_type_privileges35.21. domain_constraints35.22. domain_udt_usage35.23. domains35.24. element_types35.25. enabled_roles35.26. foreign_data_wrapper_options35.27. foreign_data_wrappers35.28. foreign_server_options35.29. foreign_servers35.30. foreign_table_options35.31. foreign_tables35.32. key_column_usage35.33. parameters35.34. referential_constraints35.35. role_column_grants35.36. role_routine_grants35.37. role_table_grants35.38. role_udt_grants35.39. role_usage_grants35.40. routine_column_usage35.41. routine_privileges35.42. routine_routine_usage35.43. routine_sequence_usage35.44. routine_table_usage35.45. routines35.46. schemata35.47. sequences35.48. sql_features35.49. sql_implementation_info35.50. sql_parts35.51. sql_sizing35.52. table_constraints35.53. table_privileges35.54. tables35.55. transforms35.56. triggered_update_columns35.57. triggers35.58. udt_privileges35.59. usage_privileges35.60. user_defined_types35.61. user_mapping_options35.62. user_mappings35.63. view_column_usage35.64. view_routine_usage35.65. view_table_usage35.66. views上一页 上一级 下一页31.5. 测试覆盖检查 起始页 第 32 章 libpq — C 库
