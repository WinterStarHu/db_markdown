# 附录 F. 附加提供的模块和扩展

附录 F. 附加提供的模块和扩展
版本：
纠错本页面
搜索
目录导航
❮
❯
附录 F. 附加提供的模块和扩展目录F.1. amcheck — 用于验证表和索引一致性的工具F.1.1. 函数F.1.2. 可选的heapallindexed验证F.1.3. 有效地使用amcheckF.1.4. 修复损坏F.2. auth_delay — 认证失败时的暂停F.2.1. 配置参数F.2.2. 作者F.3. auto_explain — 记录慢查询的执行计划F.3.1. 配置参数F.3.2. 示例F.3.3. 作者F.4. basebackup_to_shell — 示例 "shell" pg_basebackup 模块F.4.1. 配置参数F.4.2. 作者F.5. basic_archive — 一个示例WAL归档模块F.5.1. 配置参数F.5.2. 注意事项F.5.3. 作者F.6. bloom — bloom过滤器索引访问方法F.6.1. 参数F.6.2. 示例F.6.3. 操作符类接口F.6.4. 限制F.6.5. 作者F.7. btree_gin — 具有B-tree行为的GIN操作符类F.7.1. 用法示例F.7.2. 作者F.8. btree_gist — 具有B树行为的GiST操作符类F.8.1. 用法示例F.8.2. 作者F.9. citext — 一种不区分大小写的字符字符串类型F.9.1. 基本原理F.9.2. 如何使用它F.9.3. 字符串比较行为F.9.4. 限制F.9.5. 作者F.10. cube — 一种多维立方体数据类型F.10.1. 语法F.10.2. 精度F.10.3. 用法F.10.4. 默认值F.10.5. 注释F.10.6. 致谢F.11. dblink — 连接到其他 PostgreSQL 数据库dblink_connect — 打开一个持久连接到远程数据库dblink_connect_u — 不安全地打开一个持久连接到远程数据库dblink_disconnect — 关闭到远程数据库的持久连接dblink — 在远程数据库中执行查询dblink_exec — 在远程数据库中执行命令dblink_open — 在远程数据库中打开游标dblink_fetch — 从一个远程数据库中的打开的游标返回行dblink_close — 关闭远程数据库中的游标dblink_get_connections — 返回所有打开的命名dblink连接的名称dblink_error_message — 获取命名连接上的最后一个错误消息dblink_send_query — 发送一个异步查询到远程数据库dblink_is_busy — 检查连接是否正在忙于异步查询dblink_get_notify — 在连接上检索异步通知dblink_get_result — 获取一个异步查询结果dblink_cancel_query — 在命名连接上取消任何活动查询dblink_get_pkey — 返回一个关系的主键字段的位置和字段名称
dblink_build_sql_insert —
使用一个本地元组构建一个 INSERT 语句，将主键字段值替换为提供的值
dblink_build_sql_delete — 使用所提供的主键字段值构建一个 DELETE 语句
dblink_build_sql_update — 使用一个本地元组构建一个 UPDATE 语句，将主键字段值替换为提供的值
F.12. dict_int —
示例全文搜索字典用于整数F.12.1. 配置F.12.2. 用法F.13. dict_xsyn — 示例同义词全文搜索字典F.13.1. 配置F.13.2. 用法F.14. earthdistance — 计算大圆距离F.14.1. 基于立方体的地球距离F.14.2. 基于点的地球距离F.15. file_fdw — 访问服务器文件系统中的数据文件F.16. fuzzystrmatch — 确定字符串相似性和距离F.16.1. SoundexF.16.2. Daitch-Mokotoff SoundexF.16.3. LevenshteinF.16.4. MetaphoneF.16.5. 双变音位F.17. hstore — hstore 键/值数据类型F.17.1. hstore 外部表示F.17.2. hstore 操作符和函数F.17.3. 索引F.17.4. 示例F.17.5. 统计F.17.6. 兼容性F.17.7. 转换F.17.8. 作者F.18. intagg — 整数聚合器和枚举器F.18.1. 函数F.18.2. 示例用法F.19. intarray — 操作整数数组F.19.1. intarray 函数和操作符F.19.2. 索引支持F.19.3. 示例F.19.4. 基准测试F.19.5. 作者F.20. isn — 国际标准号码（ISBN、EAN、UPC等）的数据类型F.20.1. 数据类型F.20.2. 类型转换F.20.3. 函数和运算符F.20.4. 配置参数F.20.5. 示例F.20.6. 参考文献F.20.7. 作者F.21. lo — 管理大对象F.21.1. 原理F.21.2. 如何使用F.21.3. 限制F.21.4. 作者F.22. ltree — 层次树状数据类型F.22.1. 定义F.22.2. 操作符和函数F.22.3. 索引F.22.4. 示例F.22.5. 转换F.22.6. 作者F.23. pageinspect — 数据库页面的低级检查F.23.1. 通用函数F.23.2. Heap FunctionsF.23.3. B树函数F.23.4. BRIN函数F.23.5. GIN函数F.23.6. GiST 函数F.23.7. Hash 函数F.24. passwordcheck — 验证密码强度F.24.1. 配置参数F.25. pg_buffercache — 检查PostgreSQL
缓冲区缓存状态F.25.1. pg_buffercache 视图F.25.2. The pg_buffercache_numa 视图F.25.3. pg_buffercache_summary() 函数F.25.4. pg_buffercache_usage_counts() 函数F.25.5. pg_buffercache_evict() 函数F.25.6. pg_buffercache_evict_relation() 函数F.25.7. pg_buffercache_evict_all() 函数F.25.8. 样例输出F.25.9. 作者F.26. pgcrypto — 加密函数F.26.1. 通用哈希函数F.26.2. 口令哈希函数F.26.3. PGP 加密函数F.26.4. 原始加密函数F.26.5. 随机数据函数F.26.6. OpenSSL 支持函数F.26.7. 配置参数F.26.8. 注释F.26.9. 作者F.27. pg_freespacemap — 检查空闲空间映射F.27.1. 函数F.27.2. 样本输出F.27.3. 作者F.28. pg_logicalinspect — 逻辑解码组件检查F.28.1. 函数F.28.2. 作者F.29. pg_overexplain — 允许 EXPLAIN 输出更多细节F.29.1. EXPLAIN (DEBUG)F.29.2. EXPLAIN (RANGE_TABLE)F.29.3. 作者F.30. pg_prewarm — 将关系数据预加载到缓冲区缓存中F.30.1. 函数F.30.2. 配置参数F.30.3. 作者F.31. pgrowlocks — 显示表的行锁定信息F.31.1. 概述F.31.2. 样例输出F.31.3. 作者F.32. pg_stat_statements — 跟踪 SQL 规划和执行的统计信息F.32.1. The pg_stat_statements视图F.32.2. pg_stat_statements_info 视图F.32.3. 函数F.32.4. 配置参数F.32.5. 示例输出F.32.6. 作者F.33. pgstattuple — 获取元组级别的统计信息F.33.1. 函数F.33.2. 作者F.34. pg_surgery — 对关系数据执行低级操作F.34.1. 函数F.34.2. 作者F.35. pg_trgm —
使用三元组匹配支持文本相似性F.35.1. 三元组（或者三元组）概念F.35.2. 函数和操作符F.35.3. GUC 参数F.35.4. 索引支持F.35.5. 文本搜索集成F.35.6. 参考F.35.7. 作者F.36. pg_visibility — 可见性映射信息和工具F.36.1. 函数F.36.2. 作者F.37. pg_walinspect — 低级 WAL 检查F.37.1. 通用函数F.37.2. AuthorF.38. postgres_fdw —
访问存储在外部PostgreSQL
服务器中的数据F.38.1. postgres_fdw 的 FDW 选项F.38.2. FunctionsF.38.3. 连接管理F.38.4. 事务管理F.38.5. 远程查询优化F.38.6. 远程查询执行环境F.38.7. 跨版本兼容性F.38.8. 等待事件F.38.9. 配置参数F.38.10. 示例F.38.11. 作者F.39. seg — 表示线段或浮点区间的数据类型F.39.1. 原理F.39.2. 语法F.39.3. 精度F.39.4. 用法F.39.5. 注释F.39.6. 致谢F.40. sepgsql —
基于SELinux标签的强制访问控制（MAC）安全模块F.40.1. 概述F.40.2. 安装F.40.3. 回归测试F.40.4. GUC 参数F.40.5. 特性F.40.6. sepgsql 函数F.40.7. 限制F.40.8. 外部资源F.40.9. 作者F.41. spi — 服务器编程接口功能/示例F.41.1. refint — 用于实现参照完整性的函数F.41.2. autoinc — 自增字段的函数F.41.3. insert_username — 用于跟踪谁修改了一个表的函数F.41.4. moddatetime — 用于跟踪最后修改时间的函数F.42. sslinfo — 获取客户端SSL信息F.42.1. 提供的函数F.42.2. AuthorF.43. tablefunc — 返回表的函数（crosstab及其他）F.43.1. 所提供的函数F.43.2. 作者F.44. tcn — 一个触发函数，用于通知监听者表内容的更改F.45. test_decoding — 基于SQL的WAL逻辑解码测试/示例模块F.46. tsm_system_rows —
SYSTEM_ROWS采样方法用于TABLESAMPLEF.46.1. 示例F.47. tsm_system_time —
SYSTEM_TIME采样方法用于TABLESAMPLEF.47.1. 示例F.48. unaccent — 一个去除变音符号的文本搜索字典F.48.1. 配置F.48.2. 用法F.48.3. 函数F.49. uuid-ossp — 一个UUID生成器F.49.1. uuid-ossp 函数F.49.2. 构建 uuid-osspF.49.3. 作者F.50. xml2 — XPath查询和XSLT功能F.50.1. 废弃公告F.50.2. 函数描述F.50.3. xpath_tableF.50.4. XSLT 函数F.50.5. 作者
本附录和下一个附录包含有关contrib目录中可选组件的信息，
该目录是PostgreSQL发行版的一部分。
这些组件包括移植工具、分析实用程序以及不属于核心PostgreSQL系统的插件功能。
它们之所以被分离，主要是因为它们针对的受众有限，或者过于实验性，
无法成为主源代码树的一部分。这并不影响它们的实用性。
本附录介绍了在contrib中找到的扩展和其他服务器插件模块库。
附录 G介绍了实用程序。
当从源代码分发包构建时，这些可选组件不会自动构建，
除非您构建“world”目标（请参阅步骤 2）。
您可以通过运行以下命令来构建并安装所有组件：
make
make install
在已配置的源代码树的contrib目录中；
或者要仅构建和安装一个选定的模块，请在该模块的子目录中执行相同操作。
许多模块都有回归测试，可以通过运行以下命令来执行：
make check
在安装之前，或者在您有一个PostgreSQL
服务器运行后，通过运行以下命令：
make installcheck
来执行。
如果您使用的是预先打包的PostgreSQL版本，
这些组件通常作为一个单独的子包提供，例如postgresql-contrib。
许多组件提供了新的用户定义函数、操作符或类型，
这些都被打包为扩展。
要使用这些扩展中的一个，在安装代码之后，
需要在数据库系统中注册新的SQL对象。
这是通过执行
CREATE EXTENSION命令完成的。在一个新的数据库中，
你可以简单地执行
CREATE EXTENSION extension_name;
这个命令仅在当前数据库中注册新的SQL对象，
因此你需要在每个希望扩展功能可用的数据库中运行它。
或者，可以在数据库template1中运行它，
这样扩展将默认被复制到随后创建的数据库中。
对于所有扩展，CREATE EXTENSION命令必须由数据库超级用户运行，
除非该扩展被认为是“可信的”。可信的扩展可以由任何在当前数据库上拥有
CREATE权限的用户运行。被认为可信的扩展将在后续章节中标明。
通常，可信的扩展是那些无法提供数据库外部功能访问的扩展。
以下扩展在默认安装中是受信任的：
btree_ginfuzzystrmatchltreetcnbtree_gisthstorepgcryptotsm_system_rowscitextintarraypg_trgmtsm_system_timecubeisnsegunaccentdict_intlotablefuncuuid-ossp
许多扩展允许您将它们的对象安装到您选择的模式中。为此，请在
CREATE EXTENSION命令中添加SCHEMA
schema_name。默认情况下，这些对象将被放置在
您当前的创建目标模式中，而当前的默认模式是public。
请注意，其中一些组件在这个意义上并不是“扩展”，而是通过其他方式加载到
服务器中，例如通过
shared_preload_libraries。有关详细信息，请参阅每个组件的文档。
上一页 上一级 下一页E.5. 先前版本 起始页 F.1. amcheck — 用于验证表和索引一致性的工具
