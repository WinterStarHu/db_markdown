# 部分 VIII. 附录

部分 VIII. 附录
版本：
纠错本页面
搜索
目录导航
❮
❯
部分 VIII. 附录目录A. PostgreSQL错误代码B. 日期/时间支持B.1. 日期/时间输入解释B.2. 处理无效或不明确的时间戳B.3. 日期/时间关键字B.4. 日期/时间配置文件B.5. POSIX 时区规范B.6. 单位历史B.7. 儒略日期C. SQL关键字D. SQL 符合性D.1. 支持的特性D.2. 未支持的特性D.3. XML限制和符合性E. 版本说明E.1. 版本 18.3E.2. 版本 18.2E.3. 版本 18.1E.4. 发布 18E.5. 先前版本F. 附加提供的模块和扩展F.1. amcheck — 用于验证表和索引一致性的工具F.2. auth_delay — 认证失败时的暂停F.3. auto_explain — 记录慢查询的执行计划F.4. basebackup_to_shell — 示例 "shell" pg_basebackup 模块F.5. basic_archive — 一个示例WAL归档模块F.6. bloom — bloom过滤器索引访问方法F.7. btree_gin — 具有B-tree行为的GIN操作符类F.8. btree_gist — 具有B树行为的GiST操作符类F.9. citext — 一种不区分大小写的字符字符串类型F.10. cube — 一种多维立方体数据类型F.11. dblink — 连接到其他 PostgreSQL 数据库F.12. dict_int —
示例全文搜索字典用于整数F.13. dict_xsyn — 示例同义词全文搜索字典F.14. earthdistance — 计算大圆距离F.15. file_fdw — 访问服务器文件系统中的数据文件F.16. fuzzystrmatch — 确定字符串相似性和距离F.17. hstore — hstore 键/值数据类型F.18. intagg — 整数聚合器和枚举器F.19. intarray — 操作整数数组F.20. isn — 国际标准号码（ISBN、EAN、UPC等）的数据类型F.21. lo — 管理大对象F.22. ltree — 层次树状数据类型F.23. pageinspect — 数据库页面的低级检查F.24. passwordcheck — 验证密码强度F.25. pg_buffercache — 检查PostgreSQL
缓冲区缓存状态F.26. pgcrypto — 加密函数F.27. pg_freespacemap — 检查空闲空间映射F.28. pg_logicalinspect — 逻辑解码组件检查F.29. pg_overexplain — 允许 EXPLAIN 输出更多细节F.30. pg_prewarm — 将关系数据预加载到缓冲区缓存中F.31. pgrowlocks — 显示表的行锁定信息F.32. pg_stat_statements — 跟踪 SQL 规划和执行的统计信息F.33. pgstattuple — 获取元组级别的统计信息F.34. pg_surgery — 对关系数据执行低级操作F.35. pg_trgm —
使用三元组匹配支持文本相似性F.36. pg_visibility — 可见性映射信息和工具F.37. pg_walinspect — 低级 WAL 检查F.38. postgres_fdw —
访问存储在外部PostgreSQL
服务器中的数据F.39. seg — 表示线段或浮点区间的数据类型F.40. sepgsql —
基于SELinux标签的强制访问控制（MAC）安全模块F.41. spi — 服务器编程接口功能/示例F.42. sslinfo — 获取客户端SSL信息F.43. tablefunc — 返回表的函数（crosstab及其他）F.44. tcn — 一个触发函数，用于通知监听者表内容的更改F.45. test_decoding — 基于SQL的WAL逻辑解码测试/示例模块F.46. tsm_system_rows —
SYSTEM_ROWS采样方法用于TABLESAMPLEF.47. tsm_system_time —
SYSTEM_TIME采样方法用于TABLESAMPLEF.48. unaccent — 一个去除变音符号的文本搜索字典F.49. uuid-ossp — 一个UUID生成器F.50. xml2 — XPath查询和XSLT功能G. 附加提供的程序G.1. 客户端应用程序G.2. 服务器应用程序H. 外部项目H.1. 客户端接口H.2. 管理工具H.3. 过程语言H.4. 扩展I. 源代码仓库I.1. 通过Git获取源码J. 文档J.1. DocBookJ.2. 工具集J.3. 使用 Make 构建文档J.4. 使用Meson构建文档J.5. 文档创作J.6. 样式指南K. PostgreSQL限制L. 首字母缩写M. 术语表N. 颜色支持N.1. 当使用颜色时N.2. 配置颜色O. 废弃或重命名的功能O.1. recovery.conf 文件合并到 postgresql.confO.2. 默认角色重命名为预定义角色O.3. pg_xlogdump 重命名为 pg_waldumpO.4. pg_resetxlog 重命名为 pg_resetwalO.5. pg_receivexlog 重命名为 pg_receivewal上一页 上一级 下一页70.3. 备份清单 WAL 范围对象 起始页 附录 A. PostgreSQL错误代码
