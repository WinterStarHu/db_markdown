# Oracle 高级包 · 总览
> Oracle Database 19c 的高级包。**中文概述与接口清单见 [`中文速览.md`](中文速览.md)**；各分类文件为英文详细语法。（DBMS_* / UTL_*），与 GaussDB `G/高级包/` 对应。本目录英文原文待精译，`定时任务.md`（DBMS_SCHEDULER）已精译。

## 目录（按类别，对应 GaussDB）

### [定时任务](定时任务.md)
定时任务/调度。DBMS_SCHEDULER（**已精译**）。
- DBMS_SCHEDULER

### [SQL与描述](SQL与描述.md)
SQL 执行与描述相关（对应 GaussDB DBE_SQL、DBE_DESCRIBE）。
- DBMS_SQL
- DBMS_DESCRIBE

### [输出与调试](输出与调试.md)
输出与调试（对应 GaussDB DBE_OUTPUT、DBE_PROFILER）。
- DBMS_OUTPUT
- DBMS_PROFILER

### [LOB与文件](LOB与文件.md)
大对象与文件（对应 GaussDB DBE_LOB、DBE_FILE）。
- DBMS_LOB
- UTL_FILE

### [工具与杂项](工具与杂项.md)
工具与杂项（对应 GaussDB DBE_UTILITY、DBE_RAW、DBE_RANDOM、DBE_MATCH、DBE_SESSION、DBE_APPLICATION_INFO、DBE_ALERT）。
- DBMS_UTILITY
- UTL_RAW
- DBMS_RANDOM
- DBMS_MATCH
- DBMS_SESSION
- DBMS_APPLICATION_INFO
- DBMS_ALERT

### [统计](统计.md)
统计信息（对应 GaussDB DBE_STATS）。
- DBMS_STATS

### [XML](XML.md)
XML 处理（对应 GaussDB DBE_XMLDOM、DBE_XMLPARSER、DBE_XMLGEN、DBE_XML）。
- DBMS_XMLDOM
- DBMS_XMLPARSER
- DBMS_XMLGEN
- DBMS_XML

### [安全与ILM](安全与ILM.md)
安全/加密/ILM/压缩/热图（对应 GaussDB DBE_OBFUSCATION_TOOLKIT、DBE_ILM、DBE_COMPRESSION、DBE_HEAT_MAP）。
- DBMS_OBFUSCATION_TOOLKIT
- DBMS_ILM
- DBMS_COMPRESSION
- DBMS_HEAT_MAP

> GaussDB 对应高级包见 [`G/高级包/`](../../G/高级包/)。Oracle↔GaussDB 兼容性对照见 GaussDB 侧 `G/高级包/README.md`。
