# 第 34 章 ECPG — C中的嵌入式 SQL

第 34 章 ECPG — C中的嵌入式 SQL
版本：
纠错本页面
搜索
目录导航
❮
❯
第 34 章 ECPG — C中的嵌入式 SQL 目录34.1. 概念34.2. 管理数据库连接34.2.1. 连接到数据库服务器34.2.2. 选择一个连接34.2.3. 关闭一个连接34.3. 运行 SQL 命令34.3.1. 执行 SQL 语句34.3.2. 使用游标34.3.3. 管理事务34.3.4. 预处理语句34.4. 使用主变量34.4.1. 概述34.4.2. 声明节34.4.3. 检索查询结果34.4.4. 类型映射34.4.5. 处理非原始 SQL 数据类型34.4.6. 指示符34.5. 动态 SQL34.5.1. 执行没有结果集的语句34.5.2. 执行一个有输入参数的语句34.5.3. 执行一个有结果集的语句34.6. pgtypes 库34.6.1. 字符串34.6.2. numeric 类型34.6.3. 日期类型34.6.4. 时间戳类型34.6.5. 区间类型34.6.6. 十进制类型34.6.7. pgtypeslib 的 errno 值34.6.8. pgtypeslib 的特殊常量34.7. 使用描述符区域34.7.1. 命名 SQL 描述符区域34.7.2. SQLDA 描述符区域34.8. 错误处理34.8.1. 设置回调34.8.2. sqlca34.8.3. SQLSTATE 与 SQLCODE34.9. 预处理器指令34.9.1. 包含文件34.9.2. define 和 undef 指令34.9.3. ifdef, ifndef, elif, else, 和 endif 指令34.10. 处理嵌入式 SQL 程序34.11. 库函数34.12. 大对象34.13. C++ 应用34.13.1. 主变量的可见范围34.13.2. 使用外部 C 模块的 C++ 应用开发34.14. 嵌入式 SQL 命令ALLOCATE DESCRIPTOR — 分配一个 SQL 描述符区域CONNECT — 建立一个数据库连接DEALLOCATE DESCRIPTOR — 释放一个 SQL 描述符区域DECLARE — 定义一个游标DECLARE STATEMENT — 声明 SQL 语句标识符DESCRIBE — 获取有关一个预备语句或结果集的信息DISCONNECT — 终止数据库连接EXECUTE IMMEDIATE — 动态准备和执行一个语句GET DESCRIPTOR — 从一个 SQL 描述符区域获取信息OPEN — 打开一个动态游标PREPARE — 准备一个语句以供执行SET AUTOCOMMIT — 设置当前会话的自动提交行为SET CONNECTION — 选择一个数据库连接SET DESCRIPTOR — 在 SQL 描述符区域中设置信息TYPE — 定义一个新的数据类型VAR — 定义一个变量WHENEVER — 指定在 SQL 语句导致特定类别条件被触发时要采取的动作34.15. Informix 兼容模式34.15.1. 附加类型34.15.2. 附加的/缺少的嵌入式 SQL 语句34.15.3. Informix 兼容的 SQLDA 描述符区域34.15.4. 附加函数34.15.5. 附加常量34.16. Oracle 兼容模式34.17. 内部
这一章描述了用于PostgreSQL的嵌入式SQL包。它由 Linus Tolke（<linus@epact.se>）和 Michael Meskes（<meskes@postgresql.org>）编写。最初它是为了与C一起工作而编写的。它也能与C++配合，但是它还不识别所有的C++结构。
这份文档还远没有完成。但是因为这个接口是标准化的，额外的信息可以在有关 SQL 的很多资源中找到。
上一页 上一级 下一页33.5. 示例程序 起始页 34.1. 概念
