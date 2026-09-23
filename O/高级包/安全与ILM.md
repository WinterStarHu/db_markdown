# 安全与ILM

安全/加密/ILM/压缩/热图（对应 GaussDB DBE_OBFUSCATION_TOOLKIT、DBE_ILM、DBE_COMPRESSION、DBE_HEAT_MAP）。

---

## DBMS_OBFUSCATION_TOOLKIT

**包用途**：数据加密/解密与哈希工具（DES、Triple-DES、MD5）。已基本被 DBMS_CRYPTO 取代。主要接口：DES3ENCRYPT/DES3DECRYPT（Triple-DES 加解密）、DESGETKEY/DES3GETKEY（生成密钥）、MD5/GETHASH（哈希）。（本版本未抽取到独立清单表，详见英文原版。）

## DBMS_ILM

**包用途**：用 ADO（自动数据优化）策略实现信息生命周期管理（ILM）。支持立即评估/执行 ADO 任务、向任务添加/移除对象、预览策略评估。

| Subprogram | 说明 |
|---|---|
| ADD_TO_ILM | 将指定对象加入某 ADO 任务并评估其上的 ADO 策略 |
| ARCHIVESTATENAME | 返回行归档启用表的 ORA_ARCHIVE_STATE 列值 |
| EXECUTE_ILM | 执行一个 ADO 任务 |
| EXECUTE_ILM_TASK | 执行先前已评估的 ADO 任务 |
| PREVIEW_ILM | 评估参数指定范围内的所有 ADO 策略 |
| REMOVE_FROM_ILM | 从某 ADO 任务移除指定对象 |
| STOP_ILM | 停止为某 ADO 任务创建的 ADO 相关作业 |

## DBMS_COMPRESSION

**包用途**：汇集压缩相关信息，含估计分区/非分区表可压缩性、获取已压缩表的行级压缩信息，辅助做压缩决策。

| Subprogram | 说明 |
|---|---|
| GET_COMPRESSION_RATIO | 分析表的压缩比，给出可压缩性信息 |
| GET_COMPRESSION_TYPE | 返回指定行的压缩类型 |

## DBMS_HEAT_MAP

**包用途**：在块/区/段/对象/表空间各级导出热图（数据访问与修改跟踪），用于 ILM 与 ADO。SYSTEM/SYSAUX 表空间不跟踪。

| Subprogram | 说明 |
|---|---|
| BLOCK_HEAT_MAP | 返回表段每块的最后修改时间 |
| EXTENT_HEAT_MAP | 返回表段的区级热图统计 |
| OBJECT_HEAT_MAP | 返回对象所有段的最小/最大/平均访问时间 |
| SEGMENT_HEAT_MAP | 返回给定段的热图属性 |
| TABLESPACE_HEAT_MAP | 返回表空间所有段的最小/最大/平均访问时间 |


---

## DBMS_COMPRESSION 详细（机译）

## DBMS_COMPRESSION
`DBMS_COMPRESSION` 包提供了一组接口，用于为应用程序选择正确的压缩级别。
本章包含以下主题：
- 概述
- 安全模型
- 常量
- 数据结构
- DBMS_COMPRESSION 子程序摘要
另请参见：
- Oracle Database Administrator’s Guide
- Oracle Database Concepts
- Oracle Database SQL Language Reference
- Oracle Database Data Warehousing Guide
- Oracle Database VLDB and Partitioning Guide
- Oracle Database Reference
### DBMS_COMPRESSION 概述
`DBMS_COMPRESSION` 包用于收集数据库环境中的压缩相关信息。这包括用于估算分区表和非分区表可压缩性的工具，以及收集先前已压缩表的行级压缩信息。这为用户提供了足够的信息来做出与压缩相关的决策。
### DBMS_COMPRESSION 安全模型
`DBMS_COMPRESSSION` 包使用 `AUTHID CURRENT USER` 定义，因此它以当前用户的权限执行。
### DBMS_COMPRESSION 常量
`DBMS_COMPRESSION` 包使用的常量可用于指定参数值。
这些常量如下表所示：
Table 44-1 DBMS_COMPRESSION 常量 - 压缩类型
| Constant | Type | Value | Description |
|---|---|---|---|
| COMP_NOCOMPRESS | NUMBER | 1 | 无压缩 |
| COMP_ADVANCED | NUMBER | 2 | 高级行压缩 |
| COMP_QUERY_HIGH | NUMBER | 4 | 查询仓库压缩的高级别（混合列压缩） |
| COMP_QUERY_LOW | NUMBER | 8 | 查询仓库压缩的低级别（混合列压缩） |
| COMP_ARCHIVE_HIGH | NUMBER | 16 | 高归档压缩（混合列压缩） |
| COMP_ARCHIVE_LOW | NUMBER | 32 | 低归档压缩（混合列压缩） |
| COMP_BLOCK | NUMBER | 64 | 压缩块 |
| COMP_LOB_HIGH | NUMBER | 128 | LOB 操作的高压缩级别 |
| COMP_LOB_MEDIUM | NUMBER | 256 | LOB 操作的中等压缩级别 |
| COMP_LOB_LOW | NUMBER | 512 | LOB 操作的低压缩级别 |
| COMP_INDEX_ADVANCED_HIGH | NUMBER | 1024 | 索引的高压缩级别 |
| COMP_INDEX_ADVANCED_LOW | NUMBER | 2048 | 索引的低压缩级别 |
| COMP_RATIO_LOB_MINROWS | NUMBER | 1000 | 要估算 LOB 压缩比的对象所需的最少 LOB 数量 |
| COMP_BASIC | NUMBER | 4096 | 基本表压缩 |
| COMP_RATIO_LOB_MAXROWS | NUMBER | 5000 | 用于计算 LOB 压缩比的最多 LOB 数量 |
| COMP_INMEMORY_NOCOMPRESS | NUMBER | 8192 | 内存中无压缩 |
| COMP_INMEMORY_DML | NUMBER | 16384 | 用于 DML 的内存中压缩级别 |
| COMP_INMEMORY_QUERY_LOW | NUMBER | 32768 | 针对查询性能优化的内存中压缩级别 |
| COMP_INMEMORY_QUERY_HIGH | NUMBER | 65536 | 在查询性能和空间节省上优化的内存中压缩级别 |
| COMP_INMEMORY_CAPACITY_LOW | NUMBER | 131072 | 针对容量优化的内存中低压缩级别 |
| COMP_INMEMORY_CAPACITY_HIGH | NUMBER | 262144 | 针对容量优化的内存中高压缩级别 |
| COMP_RATIO_MINROWS | NUMBER | 1000000 | 要估算 HCC 比率的对象所需的最少行数 |
| COMP_RATIO_ALLROWS | NUMBER | -1 | 表示使用对象中的所有行来估算 HCC 比率 |
| OBJTYPE_TABLE | PLS_INTEGER | 1 | 标识估算其压缩比的对象类型为表 |
| OBJTYPE_INDEX | PLS_INTEGER | 2 | 标识估算其压缩比的对象类型为索引 |
注：
混合列压缩是特定 Oracle 存储系统的特性。有关更多信息，请参见 Oracle Database Concepts。
### DBMS_COMPRESSION 数据结构
`DBMS_COMPRESSION` 包定义了一个 `RECORD` 类型和一个 `TABLE` 类型。
RECORD 类型
COMPREC 记录类型
TABLE 类型
COMPRECLIST 表类型

#### COMPREC Record Type

`COMPREC` 记录类型是用于计算表上单个索引压缩比的记录。
语法
```
TYPE COMPREC IS RECORD(
  ownname           varchar2(255),
  objname           varchar2(255),
  blkcnt_cmp        PLS_INTEGER,
  blkcnt_uncmp      PLS_INTEGER,
  row_cmp           PLS_INTEGER,
  row_uncmp         PLS_INTEGER,
  cmp_ratio         NUMBER,
  objtype           PLS_INTEGER);
```
字段
Table 44-2 COMREC 属性
| Field | Description |
|---|---|
| ownname | 对象所有者的 Schema |
| objname | 对象的名称 |
| blkcnt_cmp | 对象压缩样本使用的块数 |
| blkcnt_uncmp | 对象未压缩样本使用的块数 |
| row_cmp | 对象压缩样本中一个块的行数 |
| row_uncmp | 对象未压缩样本中一个块的行数 |
| cmp_ratio | 压缩比，blkcnt_uncmp 除以 blkcnt_cmp |
| objtype | 对象的类型 |

#### COMPRECLIST 表类型

COMPRECLIST 是 COMPREC 记录类型的一种表类型。
语法
```
TYPE compreclist IS TABLE OF comprec;
```
**相关主题**
                           - COMPREC 记录类型
### DBMS_COMPRESSION 子程序摘要
`DBMS_COMPRESSION` 包使用 `GET_COMPRESSION_RATIO` 过程和 `GET_COMPRESSION_TYPE` 函数子程序。
表 44-3 DBMS_COMPRESSION 包子程序
| 子程序 | 描述 |
|---|---|
| GET_COMPRESSION_RATIO 过程 | 分析表的压缩比，并给出有关表可压缩性的信息 |
| GET_COMPRESSION_TYPE 函数 | 返回指定行的压缩类型 |

#### GET_COMPRESSION_RATIO 过程

此过程分析表或索引的压缩比率，并给出有关对象可压缩性的信息。用户可以提供各种参数来有选择地分析不同的压缩类型。
语法
获取对象（表或索引，默认为表）的压缩比率：
```
DBMS_COMPRESSION.GET_COMPRESSION_RATIO (
   scratchtbsname        IN     VARCHAR2,
   ownname               IN     VARCHAR2,
   objname               IN     VARCHAR2,
   subobjname            IN     VARCHAR2,
   comptype              IN     NUMBER,
   blkcnt_cmp            OUT    PLS_INTEGER,
   blkcnt_uncmp          OUT    PLS_INTEGER,
   row_cmp               OUT    PLS_INTEGER,
   row_uncmp             OUT    PLS_INTEGER,
   cmp_ratio             OUT    NUMBER,
   comptype_str          OUT    VARCHAR2,
   subset_numrows        IN     NUMBER  DEFAULT COMP_RATIO_MINROWS,
   objtype               IN     PLS_INTEGER DEFAULT OBJTYPE_TABLE);
```
获取 LOB 的压缩比率：
```
DBMS_COMPRESSION.GET_COMPRESSION_RATIO (
   scratchtbsname        IN     VARCHAR2,
   tabowner              IN     VARCHAR2,
   tabname               IN     VARCHAR2,
   lobname               IN     VARCHAR2,
   partname              IN     VARCHAR2,
   comptype              IN     NUMBER,
   blkcnt_cmp            OUT    PLS_INTEGER,
   blkcnt_uncmp          OUT    PLS_INTEGER,
   lobcnt                OUT    PLS_INTEGER,
   cmp_ratio             OUT    NUMBER,
   comptype_str          OUT    VARCHAR2,
   subset_numrows        IN     number DEFAULT COMP_RATIO_LOB_MAXROWS);
```
获取表上所有索引的压缩比率。压缩比率以集合形式返回。
```
DBMS_COMPRESSION.GET_COMPRESSION_RATIO (
  scratchtbsname        IN     VARCHAR2,
  ownname               IN     VARCHAR2,
  tabname               IN     VARCHAR2,
  comptype              IN     NUMBER,
  index_cr              OUT    DBMS_COMPRESSION.COMPRECLIST,
  comptype_str          OUT    VARCHAR2,
  subset_numrows        IN     NUMBER DEFAULT COMP_RATIO_INDEX_MINROWS);
```
参数
表 44-4 GET_COMPRESSION_RATIO 过程参数
| 参数 | 描述 |
|---|---|
| scratchtbsname | 可用于分析的临时临时表空间 |
| ownname / tabowner | 要分析的表所在的 Schema |
| tabname | 要分析的表的名称 |
| objname | 对象的名称 |
| subobjname | 对象的分区或子分区名称 |
| comptype | 应执行分析的压缩类型。当对象是索引时，只有以下压缩类型有效：COMP_INDEX_ADVANCED_HIGH (值 1024) 和 COMP_INDEX_ADVANCED_LOW (值 2048)。注意：对于任何类型的对象，都不能在此参数中指定以下压缩类型：COMP_BLOCK (值 64) 和 COMP_BASIC (值 4096)。 |
| blkcnt_cmp | 表的压缩样本所使用的块数 |
| blkcnt_uncmp | 表的未压缩样本所使用的块数 |
| row_cmp | 表的压缩样本中一个块内的行数 |
| row_uncmp | 表的未压缩样本中一个块内的行数 |
| cmp_ratio | 压缩比率，blkcnt_uncmp 除以 blkcnt_cmp |
| comptype_str | 描述压缩类型的字符串 |
| subset_numrows | 为估计压缩比率而采样的行数。 |
| objtype | 对象的类型，为 OBJTYPE_TABLE 或 OBJTYPE_INDEX |
| lobname | LOB 列的名称 |
| partname | 对于分区表，相关的分区名称 |
| lobcnt | 为估计压缩比率而实际采样的 LOB 数量 |
| index_cr | 索引列表及其估计的压缩比率 |
示例
以下示例显示如何估计高级行压缩的压缩比率：
```
SET SERVEROUTPUT ON
DECLARE
  1_blkcnt_cmp   PLS_INTEGER;
  1_blkcnt_uncmp PLS_INTEGER;
  1_row_cmp      PLS_INTEGER;
  1_row_uncmp    PLS_INTEGER;
  1_cmp_ratio    NUMBER;
  1_comptype_str VARCHAR2(32767);
BEGIN
   DBMS_COMPRESSION.GET_COMPRESSION_RATIO (
   scratchtbsname => 'USERS' ,
   ownname	  => 'TEST' ,
   objname	  => 'SALES' ,
   subobjname     =>  NULL ,
   comptype       =>  DBMS_COMPRESSION.COMP_ADVANCED,
   blkcnt_cmp     => 1_blkcnt_cmp,
   blkcnt_uncmp   => 1_blkcnt_uncmp,
   row_cmp	  => 1_row_cmp,
   row_uncmp      => 1_row_uncmp,
   cmp_ratio      => 1_cmp_ratio,
   comptype_str   => 1_comptype_str,
   subset_numrows => DBMS_COMPRESSION.comp_ratio_minrows,
   objtype	  => DBMS_COMPRESSION.objtype_table
  );
DBMS_OUTPUT.put_line( 'Number of blocks used by the compressed sample of the object	:  ' || 1_blkcnt_cmp);
DBMS_OUTPUT.put_line( 'Number of blocks used by the uncompressed sample of the object	:  ' || 1_blkcnt_uncmp);
DBMS_OUTPUT.put_line( 'Number of rows in a block in compressed sample of the object	:  ' || 1_row_cmp);
DBMS_OUTPUT.put_line( 'Number of rows in a block in uncompressed sample of the object	:  ' || 1_row_uncmp);
DBMS_OUTPUT.put_line( 'Estimated Compression Ratio of Sample                       	:  ' || 1_cmp_ratio);
DBMS_OUTPUT.put_line( 'Compression Type							:  ' || 1_comptype_str);
END;
/
```
压缩顾问程序对高级行压缩的估计输出（整表）：
```
Number of blocks used by the compressed sample of the object     : 165
Number of blocks used by the uncompressed sample of the object   : 629
Number of rows in a block in compressed sample of the object     : 599
Number of rows in a block in uncompressed sample of the object   : 157
Estimated Compression Ratio of Sample			         : 3.8
Compression Type						 : “Compress Advanced”
```
以下示例显示如何估计高级索引压缩的压缩比率：
```
SET SERVEROUTPUT ON
DECLARE
  1_blkcnt_cmp	   PLS_INTEGER;
  1_blkcnt_uncmp   PLS_INTEGER
  1_row_cmp	   PLS_INTEGER;
  1_row_uncmp	   PLS_INTEGER;
  1_cmp_ratio	   NUMBER;
  1_comptype_str   VARCHAR2(32767);
BEGIN
   DBMS_COMPRESSION.GET_COMPRESSION_RATIO (
    scratchtbsname =>       'USERS' ,
    ownname	   =>       'TEST' ,
    objname	   =>       'SALES_IDX' ,
    subobjname     =>        NULL ,
    comptype       =>        DBMS_COMPRESSION.COMP_INDEX_ADVANCED_LOW,
    blkcnt_cmp     =>        1_blkcnt_cmp,
    blkcnt_uncmp   =>        1_blkcnt_uncmp,
    row_cmp	   =>        1_row_cmp,
    row_uncmp      =>        1_row_uncmp,
    cmp_ratio      =>        1_cmp_ratio,
    comptype_str   =>        1_comptype_str,
    subset_numrows =>        DBMS_COMPRESSION.comp_ratio_minrows,
    objtype	   =>        DBMS_COMPRESSION.objtype_index
   );
DBMS_OUTPUT.put_line( 'Number of blocks used by the compressed sample of the object   :  ' || 1_blkcnt_cmp);
DBMS_OUTPUT.put_line( 'Number of blocks used by the uncompressed sample of the object :  ' || 1_blkcnt_uncmp);
DBMS_OUTPUT.put_line( 'Number of rows in a block in compressed sample of the object   :  ' || 1_row_cmp);
DBMS_OUTPUT.put_line( 'Number of rows in a block in uncompressed sample of the object :  ' || 1_row_uncmp);
DBMS_OUTPUT.put_line( 'Estimated Compression Ratio of Sample                          :  ' || 1_cmp_ratio);
DBMS_OUTPUT.put_line( 'Compression Type						      :  ' || 1_comptype_str);
END;
/
```
压缩顾问程序对高级索引压缩的估计输出：
```
Number of blocks used by the compressed sample of the object     : 243
Number of blocks used by the uncompressed sample of the object   : 539
Number of rows in a block in compressed sample of the object     : 499
Number of rows in a block in uncompressed sample of the object   : 145
Estimated Compression Ratio of Sample				 : 2.2
Compression Type						 : “Compress Advanced Low”
```
以下示例显示如何估计高级 LOB 压缩的压缩比率：
```
SET SERVEROUTPUT ON
DECLARE
  1_blkcnt_cmp     PLS_INTEGER;
  1_blkcnt_uncmp   PLS_INTEGER;
  1_row_cmp	   PLS_INTEGER;
  1_lobcnt	   PLS_INTEGER;
  1_cmp_ratio      NUMBER;
  1_comptype_str   VARCHAR2(32767);
BEGIN
   DBMS_COMPRESSION.GET_COMPRESSION_RATIO (
    scratchtbsname => 'USERS' ,
    tabowner       => 'TEST' ,
    tabname	   => 'PARTS' ,
    lobname	   =>  'PART_DESCRIPTION' ,
    partname       =>  NULL ,
    comptype       =>  DBMS_COMPRESSION.COMP_LOB_MEDIUM,
    blkcnt_cmp     => 1_blkcnt_cmp,
    blkcnt_uncmp   => 1_blkcnt_uncmp,
    row_cmp	   => 1_row_cmp,
    lobcnt	   => 1_lobcnt,
    cmp_ratio      => 1_cmp_ratio,
    comptype_str   => 1_comptype_str,
    subset_numrows => DBMS_COMPRESSION.comp_ratio_lob_maxrows
   );
DBMS_OUTPUT.put_line( 'Number of blocks used by the compressed sample of the object    :  ' || 1_blkcnt_cmp);
DBMS_OUTPUT.put_line( 'Number of blocks used by the uncompressed sample of the object  :  ' || 1_blkcnt_uncmp);
DBMS_OUTPUT.put_line( 'Number of rows in a block in compressed sample of the object    :  ' || 1_row_cmp);
DBMS_OUTPUT.put_line( 'Number of LOBS actually sampled				       :  ' || 1_lobcnt);
DBMS_OUTPUT.put_line( 'Estimated Compression Ratio of Sample                           :  ' || 1_cmp_ratio);
DBMS_OUTPUT.put_line( 'Compression Type                                                :  ' || 1_comptype_str);
END;
/
```
压缩顾问程序对高级 LOB 压缩的估计输出：
```
Number of blocks used by the compressed sample of the object   : 199
Number of blocks used by the uncompressed sample of the object : 389
Number of rows in a block in compressed sample of the object   : 293
Number of LOBS actually sampled 			       : 55
Estimated Compression Ratio of Sample			       : 1.9
Compression Type					       : “Compress Medium”
```
用法说明
此过程会在临时表空间中创建不同的表，并对这些对象进行分析。它不会修改用户指定表中的任何内容。

#### GET_COMPRESSION_TYPE Function

此函数返回指定行的压缩类型。如果行发生链接，该函数仅返回头部数据块的压缩类型，并且不会检查中间块或尾部块，因为头部数据块的压缩方式可能不同。
语法
```
DBMS_COMPRESSION.GET_COMPRESSION_TYPE (
   ownname      IN    VARCHAR2,
   tabname      IN    VARCHAR2,
   row_id       IN    ROWID,
   subobjname   IN    VARCHAR2 DEFAULT NULL))
  RETURN NUMBER;
```
参数
Table 44-5 GET_COMPRESSION_TYPE Function Parameters
| Parameter | Description |
|---|---|
| ownname | 表的 Schema 名称 |
| tabname | 表名 |
| rowid | 行的 Rowid |
| subobjname | 表分区或子分区的名称 |
返回值
指示压缩类型的标志（见表 Table 44-1）。


---

## DBMS_HEAT_MAP 详细（机译）

## DBMS_HEAT_MAP
`DBMS_HEAT_MAP` 包提供了一个接口，用于将不同存储层级（包括 block、extent、segment、object 和 tablespace）的 heatmap 外化。第二组子程序用于外化由后台为 top N 个 tablespace 物化好的 heatmap。
本章包含以下主题：
- 概述
- 安全模型
- DBMS_HEAT_MAP 子程序摘要
另请参阅：
- Oracle Database VLDB and Partitioning Guide 中的 Heat Map
- DBMS_ILM
- DBMS_ILM_ADMIN
### DBMS_HEAT_MAP 概述
要实施您的 ILM 策略，可以使用 Oracle Database 中的 Heat Map 来跟踪数据访问和修改。您还可以使用自动数据优化 (ADO) 来自动压缩数据并在数据库内的不同存储层之间移动数据。
Heat Map 在 block 级别跟踪修改时间，并在 segment 级别跟踪多种访问统计信息。`SYSTEM` 和 `SYSAUX` 表空间中的对象不被跟踪。`DBMS_HEAT_MAP` 允许您访问不同级别（block、extent、segment、object 和 tablespace）的 Heat Map 统计信息。
### DBMS_HEAT_MAP 安全模型
执行权限授予了 `PUBLIC`。此包中的过程在调用者安全下运行。用户必须对该对象具有 `ANALYZE` 权限。
### DBMS_HEAT_MAP 子程序摘要
此表列出并简要描述了 `DBMS_HEAT_MAP` 包的子程序。
表 88-1 DBMS_HEAT_MAP 包子程序
| 子程序 | 描述 |
|---|---|
| BLOCK_HEAT_MAP Function | 返回表 segment 中每个 block 的最后修改时间 |
| EXTENT_HEAT_MAP Function | 返回表 segment 的 extent 级别 Heat Map 统计信息 |
| OBJECT_HEAT_MAP Function | 返回属于该 object 的所有 segment 的最小、最大和平均访问时间 |
| SEGMENT_HEAT_MAP Procedure | 返回给定 segment 的 heatmap 属性 |
| TABLESPACE_HEAT_MAP Function | 返回 tablespace 中所有 segment 的最小、最大和平均访问时间 |

#### BLOCK_HEAT_MAP 函数

此表函数返回表段中每个块的最后修改时间。对于非数据段类型，它不返回任何信息。
语法
```
DBMS_HEAT_MAP.BLOCK_HEAT_MAP (
   owner             IN VARCHAR2,
   segment_name      IN VARCHAR2,
   partition_name    IN VARCHAR2 DEFAULT NULL,
   sort_columnid     IN NUMBER DEFAULT NULL,
   sort_order        IN VARCHAR2 DEFAULT NULL)
RETURN hm_bls_row PIPELINED;
```
参数
表 88-2 BLOCK_HEAT_MAP 函数参数
| Parameter | Description |
|---|---|
| owner | 段的所有者 |
| segment_name | 非分区表的表名或分区表的（子）分区。当为分区表指定表名时，不返回任何行。 |
| partition_name | 默认为 NULL。对于分区表，请指定分区或子分区段名。 |
| sort_columnid | 用于对输出进行排序的列的 ID。有效值为 1..9。无效值将被忽略。 |
| sort_order | 默认为 NULL。可能的值：ASC, DESC |
返回值
表 88-3 BLOCK_HEAT_MAP 函数返回值（输出参数）
| Parameter | Description |
|---|---|
| owner | 段的所有者 |
| segment_name | 非分区表的段名 |
| partition_name | 分区或子分区名 |
| tablespace_name | 包含该段的表空间 |
| file_id | 段中块的绝对文件号 |
| relative_fno | 段中块的相对文件号 |
| block_id | 块的块号 |
| write time | 块的最后修改时间 |

#### EXTENT_HEAT_MAP 函数

此表函数返回表段的区级 Heat Map 统计信息。对于非数据段类型，不返回任何信息。其中包括区级的聚合数据，包含最小修改时间和最大修改时间。
语法
```
DBMS_HEAT_MAP.EXTENT_HEAT_MAP (
   owner             IN VARCHAR2,
   segment_name      IN VARCHAR2,
   partition_name    IN VARCHAR2 DEFAULT NULL,
RETURN hm_els_row PIPELINED;
```
参数
Table 88-4 EXTENT_HEAT_MAP 函数参数
| Parameter | Description |
|---|---|
| owner | 段的所有者 |
| segment_name | 非分区表的表名或分区表的（子）分区名。为分区表指定表名时不返回任何行。 |
| partition_name | 默认为 NULL。对于分区表，请指定分区或子分区段名。 |
返回值
Table 88-5 EXTENT_HEAT_MAP 函数返回值（输出参数）
| Parameter | Description |
|---|---|
| owner | 段的所有者 |
| segment_name | 非分区表的段名 |
| partition_name | 分区或子分区名 |
| tablespace_name | 包含该段的表空间 |
| file_id | 段中块的绝对文件号 |
| relative_fno | 段中块的相对文件号 |
| block_id | 块的块号 |
| blocks | 区中的块数 |
| bytes | 区中的字节数 |
| min_writetime | 块的最后修改时间的最小值 |
| max_writetime | 块的最后修改时间的最大值 |
| avg_writetime | 块的最后修改时间的平均值 |

#### OBJECT_HEAT_MAP 函数

此表函数返回属于该对象的所有段的最低、最高和平均访问时间。该对象必须是一个表。如果在表以外的对象表上调用此表函数，将引发错误。

语法
```
DBMS_HEAT_MAP.OBJECT_HEAT_MAP (
   object_owner      IN VARCHAR2,
   object_name       IN VARCHAR2)
 RETURN hm_object_table PIPELINED;
```

参数

Table 88-6 OBJECT_HEAT_MAP 函数参数

| Parameter | Description |
|---|---|
| object_owner | 包含该段的表空间 |
| object_name | 段头相对文件号 |

返回值

Table 88-7 OBJECT_HEAT_MAP 函数返回值（输出参数）

| Parameter | Description |
|---|---|
| segment_name | 顶层段的名称 |
| partition_name | 分区的名称 |
| tablespace_name | 表空间的名称 |
| segment_type | 段的类型，如 DBA_SEGMENTS.SEGMENT_TYPE 所示 |
| segment_size | 段的大小（以字节为单位） |
| min_writetime | 该段最早的写入时间 |
| max_writetime | 该段最近的写入时间 |
| avg_writetime | 该段的平均写入时间 |
| min_readtime | 该段最早的读取时间 |
| max_readtime | 该段最近的读取时间 |
| avg_writetime | 该段的平均写入时间 |
| min_lookuptime | 该段最早的索引查找时间 |
| max_lookuptime | 该段最近的索引查找时间 |
| avg_lookuptime | 该段的平均索引查找时间 |
| min_ftstime | 该段最早的全文扫描时间 |
| max_ftstime | 该段最近的全文扫描时间 |
| avg_ftstime | 该段的平均全文扫描时间 |

#### SEGMENT_HEAT_MAP 过程

此过程返回给定段的heatmap属性。
语法
```
DBMS_HEAT_MAP.SEGMENT_HEAT_MAP (
   tablespace_id          IN  NUMBER,
   header_file            IN  NUMBER,
   header_block           IN  NUMBER,
   segment_objd           IN  NUMBER,
   min_writetime          OUT DATE,
   max_writetime          OUT DATE,
   avg_writetime          OUT DATE,
   min_readtime           OUT DATE,
   max_readtime           OUT DATE,
   avg_readtime           OUT DATE,
   min_lookuptime         OUT DATE,
   max_lookuptime         OUT DATE,
   avg_lookuptime         OUT DATE,
   min_ftstime            OUT DATE,
   max_ftstime            OUT DATE,
   avg_ftstime            OUT DATE);
```
参数
表 88-8 SEGMENT_HEAT_MAP 过程参数
| Parameter | Description |
|---|---|
| tablespace_id | 包含该段的表空间 |
| header_file | 段头的相对文件号 |
| header_block | 段头的数据块号 |
| segment_objd | 该段的 DATAOBJ |
返回值
表 88-9 SEGMENT_HEAT_MAP 过程返回值（输出参数）
| Parameter | Description |
|---|---|
| min_writetime | 该段最早的写入时间 |
| max_writetime | 该段最近的写入时间 |
| avg_writetime | 该段的平均写入时间 |
| min_readtime | 该段最早的读取时间 |
| max_readtime | 该段最近的读取时间 |
| avg_writetime | 该段的平均写入时间 |
| min_lookuptime | 该段最早的索引查找时间 |
| max_lookuptime | 该段最近的索引查找时间 |
| avg_lookuptime | 该段的平均索引查找时间 |
| min_ftstime | 该段最早的全表扫描时间 |
| max_ftstime | 该段最近的全表扫描时间 |
| avg_ftstime | 该段的平均全表扫描时间 |

#### TABLESPACE_HEAT_MAP 函数

该表函数返回表空间中所有段的最低、最高和平均访问时间。
语法
```
DBMS_HEAT_MAP.TABLESPACE_HEAT_MAP (
    tablespace_name      IN VARCHAR2)
  RETURN hm_tablespace_table PIPELINED;
```
参数
表 88-10 TABLESPACE_HEAT_MAP 过程参数
| 参数 | 描述 |
|---|---|
| tablespace_name | 表空间的名称 |
返回值
表 88-11 TABLESPACE_HEAT_MAP 过程返回值（输出参数）
| 参数 | 描述 |
|---|---|
| segment_count | 表空间中段的总数 |
| allocated_bytes | 表空间中段所使用的空间 |
| min_writetime | 段的最早写入时间 |
| max_writetime | 段的最新写入时间 |
| avg_writetime | 段的平均写入时间 |
| min_readtime | 段的最早读取时间 |
| max_readtime | 段的最新读取时间 |
| avg_writetime | 段的平均写入时间 |
| min_lookuptime | 段的最早索引查找时间 |
| max_lookuptime | 段的最新索引查找时间 |
| avg_lookuptime | 段的平均索引查找时间 |
| min_ftstime | 段的最早全表扫描时间 |
| max_ftstime | 段的最新全表扫描时间 |
| avg_ftstime | 段的平均全表扫描时间 |


---

## DBMS_ILM 详细（机译）

## DBMS_ILM
`DBMS_ILM` 包提供了一个接口，用于使用 Automatic Data Optimization (ADO) 策略实现信息生命周期管理 (ILM) 策略。
本章包含以下主题：
- 概述
- 安全模型
- 常量
- 异常
- DBMS_ILM 子程序摘要
另请参阅：
- Oracle Database VLDB and Partitioning Guide，了解有关使用此包管理 Automatic Data Optimization (ADO) 的信息
- DBMS_ILM_ADMIN
- DBMS_HEAT_MAP
### DBMS_ILM 概述
要实现您的 ILM 策略，您可以使用 Oracle Database 中的 Heat Map 来跟踪数据访问和修改。您还可以使用 Automatic Data Optimization (ADO) 来自动执行数据库内不同存储层之间的数据压缩和移动。`DBMS_ILM` 包支持对 ADO 相关任务进行即时评估或执行。该包支持以下两种调度 ADO 操作的方式。
- 数据库用户计划在一组对象上立即执行 ADO 策略。
- 数据库用户查看在一组对象上评估 ADO 策略的结果。然后，用户向该集合中添加或删除对象，并再次查看 ADO 策略评估的结果。用户重复此步骤以确定用于 ADO 执行的对象集合。然后，用户可以计划在这组对象上立即执行 ADO 操作。
以下过程支持这两种使用模式。在描述这些过程之前，我们引入 ADO 任务的概念，它作为一个实体，帮助跟踪 ADO 策略的特定评估或（评估和执行）。特定的 ADO 任务可能处于以下状态之一。
- Inactive
- Active
- Completed
### DBMS_ILM 安全模型
`DBMS_ILM` 包在调用者权限下运行。
### DBMS_ILM 常量
本主题中的表列出了 `DBMS_ILM` 包使用的常量。
Table 94-1 DBMS_ILM Constants
| Constant | Value | Type | Description |
|---|---|---|---|
| ILM_ALL_POLICIES | 'ALL POLICIES' | VARCHAR2(20) | 选择对象上的所有 ADO 策略 |
| ILM_EXECUTION_OFFLINE | 1 | NUMBER | 指定在执行 ADO 操作时对象可以处于离线状态 |
| ILM_EXECUTION_ONLINE | 2 | NUMBER | 指定在执行 ADO 操作时对象应处于在线状态 |
| SCOPE_DATABASE | 1 | NUMBER | 选择数据库中的所有 ADO 策略 |
| SCOPE_SCHEMA | 2 | NUMBER | 选择当前模式中的所有 ADO 策略 |
| SCHEDULE_IMMEDIATE | 1 | NUMBER | 计划 ADO 任务以立即执行 |
| ARCHIVE_STATE_ACTIVE | '0' | VARCHAR2(1) | 表示启用行归档的表的 ORA_ARCHIVE_STATE 列的值，该值会使行处于活动状态 |
| ARCHIVE_STATE_ARCHIVED | '1' | VARCHAR2(1) | 表示启用行归档的表的 ORA_ARCHIVE_STATE 列的值，该值会使行处于非活动状态 |
### DBMS_ILM 异常
本主题中的表列出了 `DBMS_ILM` 包引发的异常。
Table 94-2 DBMS_ILM Exceptions
| Exception | Error Code | Description |
|---|---|---|
| INVALID_ARGUMENT_VALUE | 38327 | 无效的参数值 |
| INVALID_ILM_DICTIONARY | 38328 | 不一致的数据字典状态 |
| INTERNAL_ILM_ERROR | 38329 | 内部错误 |
| INSUFFICIENT_PRIVILEGES | 38330 | 权限不足 |
### DBMS_ILM 子程序摘要
此表列出并描述了 `DBMS_ILM` 包的子程序。
Table 94-3 DBMS_ILM Package Subprograms
| Subprogram | Description |
|---|---|
| ADD_TO_ILM Procedure | 将通过参数指定的对象添加到特定 ADO 任务中，并评估此对象上的 ADO 策略 |
| ARCHIVESTATENAME Function | 返回启用行归档的表的 ORA_ARCHIVE_STATE 列的值 |
| EXECUTE_ILM Procedure | 执行一个 ADO 任务。 |
| EXECUTE_ILM_TASK Procedure | 执行先前已评估的 ADO 任务 |
| PREVIEW_ILM Procedure | 评估通过参数指定范围内的所有 ADO 策略 |
| REMOVE_FROM_ILM Procedure | 从特定 ADO 任务中移除通过参数指定的对象 |
| STOP_ILM Procedure | 停止为特定 ADO 任务创建的与 ADO 相关的作业 |

#### ADD_TO_ILM 过程

此过程将通过参数指定的对象添加到特定的 ADO 任务中，并评估该对象上的 ADO 策略。
该过程只能在处于非活动状态的 ADO 任务上执行。可以根据角色和访问权限使用相应的视图来查看该对象上 ADO 策略的评估结果（`USER_ILMTASKS` 或 `DBA_ILMTASKS`、`USER_ILMEVALUATIONDETAILS` 或 `DBA_ILMEVALUATIONDETAILS`、`USER_ILMRESULTS` 或 `DBA_ILMRESULTS`）。
语法
```
DBMS_ILM.ADD_TO_ILM (
   task_id           IN    NUMBER,
   owner             IN    VARCHAR2,
   object_name       IN    VARCHAR2,
   subobject_name    IN    VARCHAR2 DEFAULT NULL);
```
参数
Table 94-4 ADD_TO_ILM Procedure Parameters
| Parameter | Description |
|---|---|
| task_id | 标识特定的 ADO 任务 |
| owner | 对象的所有者 |
| object_name | 对象的名称 |
| subobject_name | 子对象的名称（对于分区表，为分区名称） |

#### ARCHIVESTATENAME 函数

此函数返回启用了行归档的表的 `ORA_ARCHIVE_STATE` 列的值。
语法
```
DBMS_ILM.ARCHIVESTATENAME (
   value      IN  VARCHAR2)
 RETURN VARCHAR2;
```
参数
表 94-5 ARCHIVESTATENAME 函数参数
| 参数 | 描述 |
|---|---|
| value | 要返回其归档状态名称的值 |
用法说明
对于 `0` 返回 `ARCHIVE_STATE_ACTIVE`，对于其他值返回 `ARCHIVE_STATE_ARCHIVED`
另请参见：
Oracle Database VLDB and Partitioning Guide 中的“Using In-Database Archiving”

#### EXECUTE_ILM 过程

此过程执行一个 ADO 任务。
此过程有两个重载。第一个重载针对一组对象执行 ADO 任务，而无需预先对它们进行评估。第二个重载针对特定对象执行 ADO 策略。
语法
```
DBMS_ILM.EXECUTE_ILM (
   task_id             OUT    NUMBER,
   ilm_scope           IN     NUMBER DEFAULT SCOPE_SCHEMA,
   execution_mode      IN     NUMBER DEFAULT ILM_EXECUTION_ONLINE);
DBMS_ILM.EXECUTE_ILM (
   owner               IN     VARCHAR2,
   object_name         IN     VARCHAR2,
   task_id             OUT    NUMBER,
   subobject_name      IN     VARCHAR2 DEFAULT NULL,
   policy_name         IN     VARCHAR2 DEFAULT ILM_ALL_POLICIES,
   execution_mode      IN     NUMBER DEFAULT ILM_EXECUTION_ONLINE);
```
参数
表 94-6 EXECUTE_ILM 过程参数
| Parameter | Description |
|---|---|
| task_id | 标识特定的 ADO 任务 |
| ilm_scope | 确定考虑用于 ADO 执行的对象集合。默认只考虑模式中的对象。 |
| execution_mode | 指示 ADO 任务是在线（ILM_EXECUTION_ONLINE）还是离线（ILM_EXECUTION_OFFLINE）执行 |
| owner | 对象的拥有者 |
| object_name | 对象的名称 |
| subobject_name | 子对象的名称（对于分区表，即分区名称） |
| policy_name | 要在对象上评估的 ADO 策略的名称。如果要评估对象上的所有 ADO 策略，应使用包常量 ILM_ALL_POLICIES。 |
使用注意事项
- EXECUTE_ILM 过程可供希望更多地控制 ADO 执行时间，且不想等待到下一个维护窗口的用户使用。
- 该过程类似于 DDL 执行，因为它会在创建 ADO 任务及相关作业之前和之后自动提交。

#### EXECUTE_ILM_TASK 过程

此过程执行先前已评估的 ADO 任务，并将其移至活动状态。
语法
```
DBMS_ILM.EXECUTE_ILM_TASK (
   task_id             IN     NUMBER,
   execution_mode      IN     NUMBER DEFAULT ILM_EXECUTION_ONLINE);
   execution_schedule  IN     NUMBER DEFAULT SCHEDULE_IMMEDIATE);
```
参数
Table 94-7 EXECUTE_ILM_TASK 过程参数
| Parameter | Description |
|---|---|
| task_id | 标识特定的 ADO 任务 |
| execution_mode | 指示 ADO 任务是在线执行 (ILM_EXECUTION_ONLINE) 还是离线执行 (ILM_EXECUTION_OFFLINE) |
| execution_schedule | 标识 ADO 任务应在何时执行。目前唯一可用的选项是立即调度 ADO 作业 |

#### PREVIEW_ILM 过程

此过程对使用 `ILM_SCOPE` 参数指定的对象评估 ADO 策略。
它返回一个数字作为 `task_id`，用于标识特定的 ADO 任务。根据角色和访问权限，可使用该标识在相应的视图中查看策略评估的结果（`USER_ILMTASKS` 或 `DBA_ILMTASKS`、`USER_ILMEVALUATIONDETAILS` 或 `DBA_ILMEVALUATIONDETAILS`、`USER_ILMRESULTS` 或 `DBA_ILMRESULTS`）。
`PREVIEW_ILM` 过程会使 ADO 任务保持非活动状态。预览结果后，您可以向该任务添加或从中删除对象。
语法
```
DBMS_ILM.PREVIEW_ILM (
   task_id           OUT    NUMBER,
  ilm_scope          IN     NUMBER DEFAULT SCOPE_SCHEMA);
```
参数
Table 94-8 PREVIEW_ILM Procedure Parameters
| Parameter | Description |
|---|---|
| task_id | 标识特定的 ADO 任务 |
| ilm_scope | 标识执行范围。应为 Constants 中所述的 SCOPE_DATABASE 或 SCOPE_SCHEMA |

#### REMOVE_FROM_ILM 过程

此过程从特定 ADO 任务中移除通过参数指定的对象。
该过程只能对处于非活动状态的 ADO 任务执行。
语法
```
DBMS_ILM.REMOVE_FROM_ILM (
   task_id           IN    NUMBER,
   owner             IN    VARCHAR2,
   object_name       IN    VARCHAR2,
   subobject_name    IN    VARCHAR2 DEFAULT NULL);
```
参数
Table 94-9 REMOVE_FROM_ILM 过程参数
| Parameter | Description |
|---|---|
| task_id | 标识特定的 ADO 任务 |
| owner | 对象的所有者 |
| object_name | 对象的名称 |
| subobject_name | 子对象的名称（对于分区表，即分区名称） |

#### STOP_ILM 过程

此过程终止与特定任务 Id 或作业名称关联的 ILM ADO 作业。
语法
```
DBMS_ILM.STOP_ILM (
   task_id               IN         NUMBER,
   p_drop_running_jobs   IN         BOOLEAN  DEFAULT FALSE),
   p_jobname             IN         VARCHAR2 DEFAULT NULL);
```
参数
表 94-10 STOP_ILM 过程参数
| Parameter | Description |
|---|---|
| task_id | 唯一标识特定 ADO 任务的数字 |
| p_drop_running_jobs | 确定是否删除正在运行的作业 |
| p_jobname | 要终止的作业的名称 |
