# 第 8 章 数据类型

第 8 章 数据类型
版本：
纠错本页面
搜索
目录导航
❮
❯
第 8 章 数据类型目录8.1. 数值类型8.1.1. 整数类型8.1.2. 任意精度数字8.1.3. 浮点数类型8.1.4. 序列类型8.2. 货币类型8.3. 字符类型8.4. 二进制数据类型8.4.1. bytea十六进制格式8.4.2. bytea转义格式8.5. 日期/时间类型8.5.1. 日期/时间输入8.5.2. 日期/时间输出8.5.3. 时区8.5.4. 间隔输入8.5.5. 间隔输出8.6. 布尔类型8.7. 枚举类型8.7.1. 枚举类型的声明8.7.2. 排序8.7.3. 类型安全8.7.4. 实现细节8.8. 几何类型8.8.1. 点8.8.2. 线8.8.3. 线段8.8.4. 方框8.8.5. 路径8.8.6. 多边形8.8.7. 圆8.9. 网络地址类型8.9.1. inet8.9.2. cidr8.9.3. inet vs. cidr8.9.4. macaddr8.9.5. macaddr88.10. 位串类型8.11. 文本搜索类型8.11.1. tsvector8.11.2. tsquery8.12. UUID 类型8.13. XML 类型8.13.1. 创建 XML 值8.13.2. 编码处理8.13.3. 访问XML值8.14. JSON 类型8.14.1. JSON 输入和输出语法8.14.2. 设计 JSON 文档8.14.3. jsonb 包含和存在8.14.4. jsonb 索引8.14.5. jsonb 下标8.14.6. 转换8.14.7. jsonpath 类型8.15. 数组8.15.1. 数组类型的定义8.15.2. 数组值输入8.15.3. 访问数组8.15.4. 修改数组8.15.5. 在数组中搜索8.15.6. 数组输入和输出语法8.16. 组合类型8.16.1. 组合类型的声明8.16.2. 构造组合值8.16.3. 访问组合类型8.16.4. 修改组合类型8.16.5. 在查询中使用组合类型8.16.6. 组合类型输入和输出语法8.17. 范围类型8.17.1. 内建范围类型和多范围类型8.17.2. 示例8.17.3. 包含和排除边界8.17.4. 无限（无界）范围8.17.5. 范围输入/输出8.17.6. 构造范围和多范围8.17.7. 离散范围类型8.17.8. 定义新的范围类型8.17.9. 索引8.17.10. 范围上的约束8.18. 域类型8.19. 对象标识符类型8.20. pg_lsn 类型8.21. 伪类型
PostgreSQL有着丰富的本地数据类型可用。用户可以使用CREATE TYPE命令为 PostgreSQL增加新的类型。
表 8.1显示了所有内建的普通数据类型。大部分在“别名”列里列出的可选名字都是因历史原因被PostgreSQL在内部使用的名字。另外，还有一些内部使用的或废弃的类型也可以用，但没有在这里列出。
表 8.1. 数据类型名字别名描述bigintint8有符号的8字节整数bigserialserial8自动增长的八字节整数bit [ (n) ] 定长位串bit varying [ (n) ]varbit [ (n) ]变长位串booleanbool逻辑布尔值（真/假）box 平面上的矩形框bytea 二进制数据（“byte array”）character [ (n) ]char [ (n) ]定长字符字符串character varying [ (n) ]varchar [ (n) ]变长字符字符串cidr IPv4或IPv6网络地址circle 平面上的圆date 日历日期（年、月、日）双精度float, float8双精度浮点数（8字节）inet IPv4或IPv6主机地址integerint, int4有符号4字节整数interval [ fields ] [ (p) ] 时间段json 文本 JSON 数据jsonb 二进制 JSON 数据，已分解line 平面上的无限线lseg 平面上的线段macaddr MAC（媒体访问控制）地址macaddr8 MAC（媒体访问控制）地址（EUI-64格式）money 货币金额numeric [ (p,
s) ]decimal [ (p,
s) ]可选择精度的精确数字path 平面上的几何路径pg_lsn PostgreSQL日志序列号pg_snapshot 用户级事务ID快照point 平面上的几何点polygon 平面上的封闭几何路径realfloat4单精度浮点数（4字节）smallintint2有符号2字节整数smallserialserial2自动增长的2字节整数serialserial4自动增长的4字节整数text 变长字符字符串time [ (p) ] [ without time zone ] 一天中的时间（无时区）time [ (p) ] with time zonetimetz一天中的时间，包括时区timestamp [ (p) ] [ without time zone ] 日期和时间（无时区）timestamp [ (p) ] with time zonetimestamptz日期和时间，包括时区tsquery 文本搜索查询tsvector 文本搜索文档txid_snapshot 用户级事务ID快照（废弃；参见 pg_snapshot）uuid 全局唯一标识符xml XML 数据兼容性
下列类型（或其拼写）是SQL指定的：bigint、bit、bit varying、boolean、char、character varying、character、varchar、date、double precision、integer、interval、numeric、decimal、real、smallint、time（有时区或无时区）、timestamp（有时区或无时区）、xml。
每种数据类型都有一个由其输入和输出函数决定的外部表现形式。许多内建的类型有明显的外部格式。不过，某些类型要么是PostgreSQL所特有的，例如几何路径，要么有几种可能的格式，例如日期和时间类型。有些输入和输出函数是不可逆的，即输出函数的结果与原始输入相比可能会丢失精度。
上一页 上一级 下一页7.8. WITH 查询（公共表表达式） 起始页 8.1. 数值类型
