# GaussDB 高级包 · 总览
> 来源：GaussDB V2.0-26.861.1 轻量化部署形态产品文档。按功能分类整理 29 个 DBE_/PKG_ 高级包，官方中文原文。

## 目录（按类别）

### [定时任务](定时任务.md)
定时任务/调度相关：定时任务创建、调度、运行、停止等。包含 DBE_SCHEDULER（对应 Oracle DBMS_SCHEDULER）与 DBE_TASK（旧式定时任务，对应 DBMS_JOB）。
- [DBE_SCHEDULER](定时任务.md#dbe_scheduler)
- [DBE_TASK](定时任务.md#dbe_task)


### [SQL与描述](SQL与描述.md)
SQL 执行与描述相关：动态 SQL、游标、列描述等。
- [DBE_SQL](SQL与描述.md#dbe_sql)
- [DBE_DESCRIBE](SQL与描述.md#dbe_describe)


### [输出与调试](输出与调试.md)
输出与调试相关：PUT_LINE 输出、存储过程调试、性能剖析。
- [DBE_OUTPUT](输出与调试.md#dbe_output)
- [DBE_PROFILER](输出与调试.md#dbe_profiler)
- [DBE_PLDEVELOPER](输出与调试.md#dbe_pldeveloper)


### [LOB与文件](LOB与文件.md)
大对象与文件读写相关。
- [DBE_LOB](LOB与文件.md#dbe_lob)
- [DBE_FILE](LOB与文件.md#dbe_file)


### [工具与杂项](工具与杂项.md)
通用工具与杂项：工具包、RAW 转换、随机数、模式匹配、会话、应用信息、告警。
- [DBE_UTILITY](工具与杂项.md#dbe_utility)
- [DBE_RAW](工具与杂项.md#dbe_raw)
- [DBE_RANDOM](工具与杂项.md#dbe_random)
- [DBE_MATCH](工具与杂项.md#dbe_match)
- [DBE_SESSION](工具与杂项.md#dbe_session)
- [DBE_APPLICATION_INFO](工具与杂项.md#dbe_application_info)
- [DBE_ALERT](工具与杂项.md#dbe_alert)


### [统计](统计.md)
统计信息相关：DBE_STATS。
- [DBE_STATS](统计.md#dbe_stats)


### [XML](XML.md)
XML 处理相关：DOM、解析、生成、通用。
- [DBE_XML](XML.md#dbe_xml)
- [DBE_XMLDOM](XML.md#dbe_xmldom)
- [DBE_XMLGEN](XML.md#dbe_xmlgen)
- [DBE_XMLPARSER](XML.md#dbe_xmlparser)


### [安全与ILM](安全与ILM.md)
安全、加密、信息生命周期管理（ILM）、压缩、热图、许可证。
- [DBE_OBFUSCATION_TOOLKIT](安全与ILM.md#dbe_obfuscation_toolkit)
- [DBE_ILM](安全与ILM.md#dbe_ilm)
- [DBE_ILM_ADMIN](安全与ILM.md#dbe_ilm_admin)
- [DBE_COMPRESSION](安全与ILM.md#dbe_compression)
- [DBE_HEAT_MAP](安全与ILM.md#dbe_heat_map)
- [DBE_LICENSE](安全与ILM.md#dbe_license)


### [系统包](系统包.md)
PKG_SERVICE、PKG_UTIL 等系统服务包。
- [PKG_SERVICE](系统包.md#pkg_service)
- [PKG_UTIL](系统包.md#pkg_util)


## Oracle ↔ GaussDB 高级包兼容性对照


GaussDB数据库兼容的高级包如表1所示。

| Oracle数据库 | GaussDB数据库 | 差异 |
|---|---|---|
| 表2 | DBE_LOB | GaussDB具体用法请参见DBE_LOB。 |
| 表3 | DBE_RANDOM | GaussDB具体用法请参见DBE_RANDOM。 |
| 表4 | DBE_OUTPUT | GaussDB具体用法请参见DBE_OUTPUT。 |
| 表5 | DBE_RAW | GaussDB具体用法请参见DBE_RAW。 |
| 表6 | DBE_SCHEDULER | GaussDB具体用法请参见DBE_SCHEDULER。 |
| 表7 | DBE_UTILITY | GaussDB具体用法请参见DBE_UTILITY。 |
| 表8 | DBE_SQL | GaussDB具体用法请参见DBE_SQL。 |
| 表10 | DBE_FILE | GaussDB具体用法请参见DBE_FILE。 |
| 表11 | DBE_SESSION | GaussDB具体用法请参见DBE_SESSION。 |
| 表12 | DBE_MATCH | GaussDB具体用法请参见DBE_MATCH。 |
| 表13 | DBE_APPLICATION_INFO | GaussDB具体用法请参见DBE_APPLICATION_INFO。 |
| 表14 | DBE_XMLDOM | GaussDB中具体信息请参见DBE_XMLDOM。 |
| 表15 | DBE_XMLPARSER | GaussDB中具体信息请参见DBE_XMLPARSER。 |
| 表16 | DBE_ILM | GaussDB中具体信息请参见DBE_ILM。 |
| 表17 | DBE_ILM_ADMIN | GaussDB中具体信息请参见DBE_ILM_ADMIN。 |
| 表18 | DBE_COMPRESSION | GaussDB中具体信息请参见DBE_COMPRESSION。 |
| 表19 | DBE_HEAT_MAP | GaussDB中具体信息请参见DBE_HEAT_MAP。 |
| 表20 | DBE_DESCRIBE | GaussDB中具体信息请参见DBE_DESCRIBE。 |
| 表22 | DBE_XMLGEN | GaussDB中具体信息请参见DBE_XMLGEN。 |
| 表21 | DBE_STATS | GaussDB中具体信息请参见DBE_STATS。 |
| 表23 | DBE_ALERT | GaussDB中具体信息请参见DBE_ALERT。 |
| 表24 | DBE_OBFUSCATION_TOOLKIT | GaussDB中具体信息请参见DBE_OBFUSCATION_TOOLKIT。 |
| Oracle数据库 | GaussDB数据库 |
|---|---|
| DBMS_ADDM | 不支持 |
| DBMS_ADVANCED_REWRITE | 不支持 |
| DBMS_ADVISOR | 不支持 |
| DBMS_APP_CONT | 不支持 |
| DBMS_APPLY_ADM | 不支持 |
| DBMS_AQ | 不支持 |
| DBMS_AQADM | 不支持 |
| DBMS_AQELM | 不支持 |
| DBMS_AQIN | 不支持 |
| DBMS_ASSERT | 不支持 |
| DBMS_AUDIT_UTIL | 不支持 |
| DBMS_AUDIT_MGMT | 不支持 |
| DBMS_AUTO_REPORT | 不支持 |
| DBMS_AUTO_SQLTUNE | 不支持 |
| DBMS_AUTO_TASK_ADMIN | 不支持 |
| DBMS_AW_STATS | 不支持 |
| DBMS_BLOCKCHAIN_TABLE | 不支持 |
| DBMS_CAPTURE_ADM | 不支持 |
| DBMS_CLOUD | 不支持 |
| DBMS_COMPARISON | 不支持 |
| DBMS_COMPRESSION | 不支持 |
| DBMS_CONNECTION_POOL | 不支持 |
| DBMS_CQ_NOTIFICATION | 不支持 |
| DBMS_CREDENTIAL | 不支持 |
| DBMS_CRYPTO | 不支持 |
| DBMS_CSX_ADMIN | 不支持 |
| DBMS_CUBE | 不支持 |
| DBMS_CUBE_ADVISE | 不支持 |
| DBMS_CUBE_LOG | 不支持 |
| DBMS_DATA_MINING | 不支持 |
| DBMS_DATA_MINING_TRANSFORM | 不支持 |
| DBMS_DATAPUMP | 不支持 |
| DBMS_DB_VERSION | 不支持 |
| DBMS_DBCOMP | 不支持 |
| DBMS_DBFS_CONTENT | 不支持 |
| DBMS_DBFS_CONTENT_SPI | 不支持 |
| DBMS_DBFS_HS | 不支持 |
| DBMS_DBFS_SFS | 不支持 |
| DBMS_DDL | 不支持 |
| DBMS_DEBUG | 不支持 |
| DBMS_DEBUG_JDWP | 不支持 |
| DBMS_DEBUG_JDWP_CUSTOM | 不支持 |
| DBMS_DG | 不支持 |
| DBMS_DIMENSION | 不支持 |
| DBMS_DISTRIBUTED_TRUST_ADMIN | 不支持 |
| DBMS_DNFS | 不支持 |
| DBMS_DST | 不支持 |
| DBMS_EDITIONS_UTILITIES | 不支持 |
| DBMS_EPG | 不支持 |
| DBMS_ERRLOG | 不支持 |
| DBMS_FGA | 不支持 |
| DBMS_FILE_GROUP | 不支持 |
| DBMS_FILE_TRANSFER | 不支持 |
| DBMS_FLASHBACK | 不支持 |
| DBMS_FLASHBACK_ARCHIVE | 不支持 |
| DBMS_FREQUENT_ITEMSET | 不支持 |
| DBMS_FS | 不支持 |
| DBMS_GOLDENGATE_AUTH | 不支持 |
| DBMS_HADOOP | 不支持 |
| DBMS_HANG_MANAGER | 不支持 |
| DBMS_HEAT_MAP | 不支持 |
| DBMS_HIERARCHY | 不支持 |
| DBMS_HM | 不支持 |
| DBMS_HPROF | 不支持 |
| DBMS_HS_PARALLEL | 不支持 |
| DBMS_HS_PASSTHROUGH | 不支持 |
| DBMS_ILM | 不支持 |
| DBMS_ILM_ADMIN | 不支持 |
| DBMS_IMMUTABLE_TABLE | 不支持 |
| DBMS_INMEMORY | 不支持 |
| DBMS_INMEMORY_ADMIN | 不支持 |
| DBMS_IOT | 不支持 |
| DBMS_JAVA | 不支持 |
| DBMS_JOB | 不支持 |
| DBMS_JSON | 不支持 |
| DBMS_LDAP | 不支持 |
| DBMS_LDAP_UTL | 不支持 |
| DBMS_LIBCACHE | 不支持 |
| DBMS_LOCK | 不支持 |
| DBMS_LOGMNR | 不支持 |
| DBMS_LOGMNR_D | 不支持 |
| DBMS_LOGSTDBY | 不支持 |
| DBMS_LOGSTDBY_CONTEXT | 不支持 |
| DBMS_METADATA | 不支持 |
| DBMS_METADATA_DIFF | 不支持 |
| DBMS_MGD_ID_UTL | 不支持 |
| DBMS_MGWADM | 不支持 |
| DBMS_MGWMSG | 不支持 |
| DBMS_MONITOR | 不支持 |
| DBMS_MVIEW | 不支持 |
| DBMS_MVIEW_STATS | 不支持 |
| DBMS_NETWORK_ACL_ADMIN | 不支持 |
| DBMS_NETWORK_ACL_UTILITY | 不支持 |
| DBMS_ODCI | 不支持 |
| DBMS_OPTIM_BUNDLE | 不支持 |
| DBMS_OUTLN | 不支持 |
| DBMS_PARALLEL_EXECUTE | 不支持 |
| DBMS_PART | 不支持 |
| DBMS_PCLXUTIL | 不支持 |
| DBMS_PDB | 不支持 |
| DBMS_PDB_ALTER_SHARING | 不支持 |
| DBMS_PERF | 不支持 |
| DBMS_PIPE | 不支持 |
| DBMS_PLSQL_CODE_COVERAGE | 不支持 |
| DBMS_PREDICTIVE_ANALYTICS | 不支持 |
| DBMS_PREPROCESSOR | 不支持 |
| DBMS_PRIVILEGE_CAPTURE | 不支持 |
| DBMS_PROCESS | 不支持 |
| DBMS_PROFILER | 不支持 |
| DBMS_PROPAGATION_ADM | 不支持 |
| DBMS_QOPATCH | 不支持 |
| DBMS_REDACT | 不支持 |
| DBMS_REDEFINITION | 不支持 |
| DBMS_REFRESH | 不支持 |
| DBMS_REPAIR | 不支持 |
| DBMS_RESCONFIG | 不支持 |
| DBMS_RESOURCE_MANAGER_PRIVS | 不支持 |
| DBMS_RESULT_CACHE | 不支持 |
| DBMS_RESUMABLE | 不支持 |
| DBMS_RLS | 不支持 |
| DBMS_ROLLING | 不支持 |
| DBMS_ROWID | 不支持 |
| DBMS_RULE | 不支持 |
| DBMS_RULE_ADM | 不支持 |
| DBMS_SERVER_ALERT | 不支持 |
| DBMS_SERVICE | 不支持 |
| DBMS_SHARED_POOL | 不支持 |
| DBMS_SODA | 不支持 |
| DBMS_SPACE | 不支持 |
| DBMS_SPACE_ADMIN | 不支持 |
| DBMS_SPD | 不支持 |
| DBMS_SPM | 不支持 |
| DBMS_SQL_MONITOR | 不支持 |
| DBMS_SQL_TRANSLATOR | 不支持 |
| DBMS_SQLDIAG | 不支持 |
| DBMS_SQLPA | 不支持 |
| DBMS_SQLTUNE | 不支持 |
| DBMS_STAT_FUNCS | 不支持 |
| DBMS_STORAGE_MAP | 不支持 |
| DBMS_SYNC_REFRESH | 不支持 |
| DBMS_TDB | 不支持 |
| DBMS_TF | 不支持 |
| DBMS_TNS | 不支持 |
| DBMS_TRACE | 不支持 |
| DBMS_TRANSACTION | 不支持 |
| DBMS_TRANSFORM | 不支持 |
| DBMS_TSDP_MANAGE | 不支持 |
| DBMS_TSDP_PROTECT | 不支持 |
| DBMS_TTS | 不支持 |
| DBMS_TYPES | 不支持 |
| DBMS_UMF | 不支持 |
| DBMS_USER_CERTS | 不支持 |
| DBMS_WARNING | 不支持 |
| DBMS_WM | 不支持 |
| DBMS_WORKLOAD_CAPTURE | 不支持 |
| DBMS_WORKLOAD_REPLAY | 不支持 |
| DBMS_WORKLOAD_REPOSITORY | 不支持 |
| DBMS_XA | 不支持 |
| DBMS_XDB | 不支持 |
| DBMS_XDB_ADMIN | 不支持 |
| DBMS_XDB_CONFIG | 不支持 |
| DBMS_XDB_CONSTANTS | 不支持 |
| DBMS_XDB_REPOS | 不支持 |
| DBMS_XDBRESOURCE | 不支持 |
| DBMS_XDB_VERSION | 不支持 |
| DBMS_XDBT | 不支持 |
| DBMS_XDBZ | 不支持 |
| DBMS_XEVENT | 不支持 |
| DBMS_XMLINDEX | 不支持 |
| DBMS_XMLQUERY | 不支持 |
| DBMS_XMLSAVE | 不支持 |
| DBMS_XMLSCHEMA | 不支持 |
| DBMS_XMLSTORE | 不支持 |
| DBMS_XMLTRANSLATIONS | 不支持 |
| DBMS_XPLAN | 不支持 |
| DBMS_XSLPROCESSOR | 不支持 |
| UTL_COLL | 不支持 |
| UTL_COMPRESS | 不支持 |
| UTL_DBWS | 不支持 |
| UTL_ENCODE | 不支持 |
| UTL_HTTP | 不支持 |
| UTL_I18N | 不支持 |
| UTL_INADDR | 不支持 |
| UTL_IDENT | 不支持 |
| UTL_LMS | 不支持 |
| UTL_MAIL | 不支持 |
| UTL_NLA | 不支持 |
| UTL_RECOMP | 不支持 |
| UTL_REF | 不支持 |
| UTL_SMTP | 不支持 |
| UTL_RPADV | 不支持 |
| UTL_TCP | 不支持 |
| CTX_ADM | 不支持 |
| CTX_ANL | 不支持 |
| CTX_CLS | 不支持 |
| CTX_DDL | 不支持 |
| CTX_DOC | 不支持 |
| CTX_ENTITY | 不支持 |
| CTX_OUTPUT | 不支持 |
| CTX_QUERY | 不支持 |
| CTX_REPORT | 不支持 |
| CTX_THES | 不支持 |
| CTX_ULEXER | 不支持 |
| DBMS_APP_CONT_ADMIN | 不支持 |
| DBMS_AUTO_INDEX | 不支持 |
| DBMS_GOLDENGATE_ADM | 不支持 |
| DBMS_JAVASCRIPT | 不支持 |
| DBMS_MEMOPTIMIZE | 不支持 |
| DBMS_MEMOPTIMIZE_ADMIN | 不支持 |
| DBMS_SFW_ACL_ADMIN | 不支持 |
| DBMS_TABLE_DATA | 不支持 |
| DBMS_XMLSCHEMA_ANNOTATE | 不支持 |
| DBMS_XMLSTORAGE_MANAGE | 不支持 |
| DBMS_XSTREAM_ADM | 不支持 |
| DBMS_XSTREAM_AUTH | 不支持 |
| DEBUG_EXTPROC | 不支持 |
| HTF | 不支持 |
| HTP | 不支持 |
| OWA_CACHE | 不支持 |
| OWA_COOKIE | 不支持 |
| OWA_CUSTOM | 不支持 |
| OWA_IMAGE | 不支持 |
| OWA_OPT_LOCK | 不支持 |
| OWA_PATTERN | 不支持 |
| OWA_SEC | 不支持 |
| OWA_TEXT | 不支持 |
| OWA_UTIL | 不支持 |
| SDO_CS | 不支持 |
| SDO_CSW_PROCESS | 不支持 |
| SDO_GCDR | 不支持 |
| SDO_GEOM | 不支持 |
| SDO_GEOR | 不支持 |
| SDO_GEOR_ADMIN | 不支持 |
| SDO_GEOR_AGGR | 不支持 |
| SDO_GEOR_RA | 不支持 |
| SDO_GEOR_UTL | 不支持 |
| SDO_LRS | 不支持 |
| SDO_MIGRATE | 不支持 |
| SDO_NET | 不支持 |
| SDO_NFE | 不支持 |
| SDO_OLS | 不支持 |
| SDO_PC_PKG | 不支持 |
| SDO_SAM | 不支持 |
| SDO_TIN_PKG | 不支持 |
| SDO_TOPO | 不支持 |
| SDO_TOPO_MAP | 不支持 |
| SDO_TUNE | 不支持 |
| SDO_UTIL | 不支持 |
| SDO_WFS_LOCK | 不支持 |
| SDO_WFS_PROCESS | 不支持 |
| SEM_APIS | 不支持 |
| SEM_OLS | 不支持 |
| SEM_PERF | 不支持 |
| SEM_RDFCTX | 不支持 |
| SEM_RDFSA | 不支持 |
| UTL_CALL_STACK | 不支持 |
| UTL_URL | 不支持 |
| WPG_DOCLOAD | 不支持 |
| Oracle数据库 | GaussDB数据库 | 差异 |
|---|---|---|
| APPEND Procedures | APPEND Procedures | - |
| CLOB2FILE Procedure | 不支持 | - |
| CLOSE Procedure | BFILECLOSE Procedure | GaussDB：参数类型为BFILE，不存在函数重载。 Oracle：该过程存在3个重载，3个重载的参数lob_loc、lob_loc和file_loc的类型分别为BLOB、CLOB CHARACTER SET ANY_CS和BFILE。 |
| COMPARE Functions | COMPARE Functions | GaussDB：存在3个重载函数，对于第三个参数（len）均为BIGINT。 Oracle：存在3个重载函数，对于第三个参数（amount）均为INTEGER。 |
| CONVERTTOBLOB Procedure | LOB_CONVERTTOBLOB Procedure | GaussDB：该过程共有5个参数，且第3、4、5个参数类型为BIGINT。 Oracle：该过程共有8个参数，在GaussDB所有参数的基础上增加了blob_csid、lang_context和warning3个参数，类型分别为NUMBER、INTEGER和INTEGER，且第3、4、5个参数类型为INTEGER。 |
| CONVERTTOCLOB Procedure | LOB_CONVERTTOCLOB Procedure | GaussDB：该过程共有5个参数。第3、4、5个参数类型为BIGINT。 Oracle：该过程共有8个参数。第3、4、5个参数类型为INTEGER。Oracle的该过程在GaussDB所有参数的基础上增加了3个参数:blob_csid、lang_context和warning，参数类型分别为NUMBER、INTEGER和INTEGER。 |
| COPY Procedures | LOB_COPY Functions | - |
| COPY_DBFS_LINK Procedures | 不支持 | - |
| COPY_FROM_DBFS_LINK | 不支持 | - |
| CREATETEMPORARY Procedures | CREATE_TEMPORARY Procedures | GaussDB：该过程存在2个重载。第一个重载过程的第一个参数（lob_loc）为BLOB，第二个重载过程的第一个参数（lob_loc）为CLOB；两个重载过程的第三个参数（dur）为INTEGER，默认值为10。 Oracle：该过程存在2个重载。第一个重载过程的第一个参数（lob_loc）为BLOB，第二个重载过程的第一个参数（lob_loc）为CLOB；两个重载过程的第三个参数（dur）的参数类型为PLS_INTEGER，第一个重载过程的dur默认值为DBMS_LOB.SESSION，第二个重载过程的dur默认值为10。 |
| DBFS_LINK_GENERATE_PATH Functions | 不支持 | - |
| ERASE Procedures | LOB_ERASE Procedures | - |
| FILECLOSE Procedure | 不支持 | - |
| FILECLOSEALL Procedure | 不支持 | - |
| FILEEXISTS Function | 不支持 | - |
| FILEGETNAME Procedure | 不支持 | - |
| FILEISOPEN Function | 不支持 | - |
| FILEOPEN Procedure | 不支持 | - |
| FRAGMENT_DELETE Procedure | 不支持 | - |
| FRAGMENT_INSERT Procedures | 不支持 | - |
| FRAGMENT_MOVE Procedure | 不支持 | - |
| FRAGMENT_REPLACE Procedures | 不支持 | - |
| FREETEMPORARY Procedures | 不支持 | - |
| GET_DBFS_LINK Functions | 不支持 | - |
| GET_DBFS_LINK_STATE Procedures | 不支持 | - |
| GETCHUNKSIZE Functions | GETCHUNKSIZE Functions | - |
| GETCONTENTTYPE Functions | 不支持 | - |
| GETLENGTH Functions | 不支持 | - |
| GETOPTIONS Functions | 不支持 | - |
| GET_STORAGE_LIMIT Function | 不支持 | - |
| INSTR Functions | MATCH Functions | GaussDB：存在3个重载函数。3个重载函数的第三、四个参数均为BIGINT。 Oracle：存在3个重载函数。3个重载函数的第三、四个参数均为INTEGER。 |
| ISOPEN Functions | 不支持 | - |
| ISREMOTE Function | 不支持 | - |
| ISSECUREFILE Function | 不支持 | - |
| ISTEMPORARY Functions | 不支持 | - |
| LOADBLOBFROMFILE Procedure | LOADBLOBFROMBFILE Procedure | - |
| LOADCLOBFROMFILE Procedure | LOADCLOBFROMBFILE Procedure | - |
| LOADFROMFILE Procedure | LOADFROMBFILE Procedure | - |
| MOVE_TO_DBFS_LINK Procedures | 不支持 | - |
| OPEN Procedures | BFILEOPEN Procedure | GaussDB：该过程不存在重载。第一个参数（bfile）类型为DBE_LOB.BFILE，第二个参数（open_mode）类型为TEXT，且只支持read模式。 Oracle：该过程存在3个重载。第一个重载过程的第一个参数（lob_loc）类型为NOCOPY BLOB，第二个参数（openmode）类型为BINARY_INTEGER；第二个重载过程的第一个参数（lob_loc）类型为NOCOPY CLOB CHARACTER SET ANY_CS，第二个参数（openmode）类型为BINARY_INTEGER；第三个重载过程的第一个参数（file_loc）类型为NOCOPY BFILE,第二个参数（openmode）类型为BINARY_INTEGER，且只能为file_readonly。 |
| READ Procedures | READ Procedures | GaussDB：该过程存在2个重载。 Oracle：该过程存在3个重载。其中前两个重载与GaussDB无差异，第三个过程重载包括4个参数：file_loc、amount、offset和buffer，其类型分别为BFILE、NOCOPY INTEGER、INTEGER和RAW。 |
| SET_DBFS_LINK Procedures | 不支持 | - |
| SETCONTENTTYPE Procedure | 不支持 | - |
| SETOPTIONS Procedures | 不支持 | - |
| SUBSTR Functions | LOB_SUBSTR Functions | - |
| TRIM Procedures | STRIP Functions | GaussDB：该过程存在2个重载。两个重载过程的第二个参数（newlen）均为BIGINT。 Oracle：该过程存在2个重载。两个重载过程的第二个参数（newlen）均为INTEGER。 |
| WRITE Procedures | WRITE Functions | - |
| WRITEAPPEND Procedures | WRITEAPPEND Functions | - |
| Oracle数据库 | GaussDB数据库 | 差异 |
|---|---|---|
| INITIALIZE Procedure | 不支持 | - |
| NORMAL Function | 不支持 | - |
| RANDOM Function | 不支持 | - |
| SEED Procedures | DBE_RANDOM.SET_SEED Function | GaussDB：该函数无重载，参数类型为INTEGER。 Oracle：该过程存在2个重载，2个重载过程的参数类型分别为VARCHAR2和BINARY_INTEGER。 |
| STRING Function | 不支持 | - |
| TERMINATE Procedure | 不支持 | - |
| VALUE Functions | DBE_RANDOM.GET_VALUE Function | GaussDB：该函数无重载。 Oracle：存在无参数的VALUE函数重载，返回NUMBER类型。 |
| Oracle数据库 | GaussDB数据库 | 差异 |
|---|---|---|
| DISABLE Procedure | DISABLE Function | - |
| ENABLE Procedure | ENABLE Function | - |
| GET_LINE Procedure | GET_LINE Function | - |
| GET_LINES Procedure | GET_LINES Function | GaussDB：该函数无重载，首个参数（lines）数据类型为VARCHAR[]。 Oracle：该过程存在2个重载，2个重载过程的首个参数（lines）分别为CHARARR和DBMSOUTPUT_LINESARRAY。 |
| NEW_LINE Procedure | NEW_LINE Function | - |
| PUT Procedure | PUT Function | GaussDB：当数据库服务端字符集server_encoding不是UTF8编码格式且入参的字符编码是合法的UTF8编码时，该函数不会区分入参的数据类型，都会先把该字符编码按照“UTF8 > server_encoding”的转换关系进行转换后再输出。 Oracle：当数据库服务端字符集server_encoding不是UTF8编码格式且入参的字符编码是合法的UTF8编码时，若入参类型是NVARCHAR2，则该过程会先把该字符编码按照“UTF8 > server_encoding”的转换关系进行转换后再输出；若入参为其他字符类型，则会将该字符编码视作非法字符，以占位符的形式输出。 |
| PUT_LINE Procedure | PUT_LINE Function | GaussDB：当数据库服务端字符集server_encoding不是UTF8编码格式且入参的字符编码是合法的UTF8编码时，该函数不会区分入参的数据类型，都会先把该字符编码按照“UTF8 > server_encoding”的转换关系进行转换后再输出。 Oracle：当数据库服务端字符集server_encoding不是UTF8编码格式且入参的字符编码是合法的UTF8编码时，若入参类型是NVARCHAR2，则该过程会先把该字符编码按照“UTF8 > server_encoding”的转换关系进行转换后再输出；若入参为其他字符类型，则会将该字符编码视作非法字符，以占位符的形式输出。 |
| Oracle数据库 | GaussDB数据库 | 差异 |
|---|---|---|
| BIT_AND Function | BIT_AND Function | - |
| BIT_COMPLEMENT Function | BIT_COMPLEMENT Function | - |
| BIT_OR Function | BIT_OR Function | GaussDB：两个参数类型被定义为TEXT类型并且返回TEXT类型。 Oracle：两个参数为RAW类型并且返回RAW类型。 |
| BIT_XOR Function | BIT_XOR Function | - |
| CAST_FROM_BINARY_DOUBLE Function | CAST_FROM_BINARY_DOUBLE_TO_RAW Function | - |
| CAST_FROM_BINARY_FLOAT Function | CAST_FROM_BINARY_FLOAT_TO_RAW Function | GaussDB：参数n为FLOAT4类型，且在转换前会对其进行范围和精度截断处理。 Oracle：参数n为FLOAT类型。 |
| CAST_FROM_BINARY_INTEGER Function | CAST_FROM_BINARY_INTEGER_TO_RAW Function | GaussDB：参数value为BIGINT类型。 Oracle：参数value为INTEGER类型。 |
| CAST_FROM_NUMBER Function | CAST_FROM_NUMBER_TO_RAW Function | GaussDB：参数n为NUMERIC类型。 Oracle：参数n为NUMBER类型。 |
| CAST_TO_BINARY_DOUBLE Function | CAST_FROM_RAW_TO_BINARY_DOUBLE Function | - |
| CAST_TO_BINARY_FLOAT Function | CAST_FROM_RAW_TO_BINARY_FLOAT Function | GaussDB：函数返回类型为FLOAT4。 Oracle：函数返回类型为FLOAT。 |
| CAST_TO_BINARY_INTEGER Function | CAST_FROM_RAW_TO_BINARY_INTEGER Function | GaussDB：参数endianess为INTEGER类型，函数返回类型为INTEGER。 Oracle：参数endianess为PLS_INTEGER类型，函数返回类型为BINARY_INTEGER。 |
| CAST_TO_NUMBER Function | CAST_FROM_RAW_TO_NUMBER Function | GaussDB：函数返回类型为NUMERIC。 Oracle：函数返回类型为NUMBER。 |
| CAST_TO_NVARCHAR2 Function | CAST_FROM_RAW_TO_NVARCHAR2 Function | - |
| CAST_TO_RAW Function | CAST_FROM_VARCHAR2_TO_RAW Function | - |
| CAST_TO_VARCHAR2 Function | CAST_TO_VARCHAR2 Function | - |
| COMPARE Function | COMPARE Function | GaussDB：函数返回类型为INTEGER。 Oracle：函数返回类型为NUMBER。 |
| CONCAT Function | CONCAT Function | - |
| CONVERT Function | CONVERT Function | - |
| COPIES Function | COPIES Function | GaussDB：参数n为NUMERIC类型。 Oracle：参数n为NUMBER类型。 |
| LENGTH Function | GET_LENGTH Function | GaussDB：函数返回类型为INTEGER。 Oracle：函数返回类型为NUMBER。 |
| OVERLAY Function | OVERLAY Function | - |
| REVERSE Function | REVERSE Function | - |
| SUBSTR Function | SUBSTR Function | GaussDB：参数lob_loc为BLOB类型；参数off_set为INTEGER类型，默认值为1；参数amount为INTEGER类型，默认值为32767。 Oracle：参数r为RAW类型，参数pos为BINARY_INTEGER类型且无默认值，参数len为BINARY_INTEGER类型，默认值为NULL。 |
| TRANSLATE Function | TRANSLATE Function | - |
| TRANSLITERATE Function | TRANSLITERATE Function | - |
| XRANGE Function | XRANGE Function | GaussDB：参数start_byte和end_byte无默认值。 Oracle：参数start_byte和end_byte默认为NULL。 |
| Oracle数据库 | GaussDB数据库 |
|---|---|
| ADD_EVENT_QUEUE_SUBSCRIBER Procedure | 不支持 |
| ADD_GROUP_MEMBER Procedure | 不支持 |
| ADD_JOB_EMAIL_NOTIFICATION Procedure | 不支持 |
| ADD_TO_INCOMPATIBILITY Procedure | 不支持 |
| ALTER_CHAIN Procedure | 不支持 |
| ALTER_RUNNING_CHAIN Procedure | 不支持 |
| CLOSE_WINDOW Procedure | 不支持 |
| COPY_JOB Procedure | 不支持 |
| CREATE_CHAIN Procedure | 不支持 |
| CREATE_CREDENTIAL Procedure | CREATE_CREDENTIAL Procedure |
| CREATE_DATABASE_DESTINATION Procedure | 不支持 |
| CREATE_EVENT_SCHEDULE Procedure | 不支持 |
| CREATE_FILE_WATCHER Procedure | 不支持 |
| CREATE_GROUP Procedure | 不支持 |
| CREATE_INCOMPATIBILITY Procedure | 不支持 |
| CREATE_JOB Procedure | CREATE_JOB Procedure |
| CREATE_JOB_CLASS Procedure | CREATE_JOB_CLASS Procedure |
| CREATE_JOBS Procedure | 不支持 |
| CREATE_PROGRAM Procedure | CREATE_PROGRAM Procedure |
| CREATE_RESOURCE Procedure | 不支持 |
| CREATE_SCHEDULE Procedure | CREATE_SCHEDULE Procedure |
| CREATE_WINDOW Procedure | 不支持 |
| DEFINE_ANYDATA_ARGUMENT Procedure | 不支持 |
| DEFINE_CHAIN_EVENT_STEP Procedure | 不支持 |
| DEFINE_CHAIN_RULE Procedure | 不支持 |
| DEFINE_CHAIN_STEP Procedure | 不支持 |
| DEFINE_METADATA_ARGUMENT Procedure | 不支持 |
| DEFINE_PROGRAM_ARGUMENT Procedure | DEFINE_PROGRAM_ARGUMENT Procedure |
| DISABLE Procedure | DISABLE Procedure |
| DROP_AGENT_DESTINATION Procedure | 不支持 |
| DROP_CHAIN Procedure | 不支持 |
| DROP_CHAIN_RULE Procedure | 不支持 |
| DROP_CHAIN_STEP Procedure | 不支持 |
| DROP_CREDENTIAL Procedure | DROP_CREDENTIAL Procedure |
| DROP_DATABASE_DESTINATION Procedure | 不支持 |
| DROP_FILE_WATCHER Procedure | 不支持 |
| DROP_GROUP Procedure | 不支持 |
| DROP_INCOMPATIBILITY Procedure | 不支持 |
| DROP_JOB Procedure | DROP_JOB Procedure |
| DROP_JOB_CLASS Procedure | DROP_JOB_CLASS Procedure |
| DROP_PROGRAM Procedure | DROP_PROGRAM Procedure |
| DROP_PROGRAM_ARGUMENT Procedure | 不支持 |
| DROP_SCHEDULE Procedure | DROP_SCHEDULE Procedure |
| DROP_WINDOW Procedure | 不支持 |
| ENABLE Procedure | ENABLE Procedure |
| END_DETACHED_JOB_RUN Procedure | 不支持 |
| EVALUATE_CALENDAR_STRING Procedure | EVALUATE_CALENDAR_STRING Procedure |
| EVALUATE_RUNNING_CHAIN Procedure | 不支持 |
| GENERATE_JOB_NAME Function | GENERATE_JOB_NAME Function |
| GET_AGENT_INFO Function | 不支持 |
| GET_AGENT_VERSION Function | 不支持 |
| GET_ATTRIBUTE Procedure | 不支持 |
| GET_FILE Procedure | 不支持 |
| GET_SCHEDULER_ATTRIBUTE Procedure | 不支持 |
| OPEN_WINDOW Procedure | 不支持 |
| PURGE_LOG Procedure | 不支持 |
| PUT_FILE Procedure | 不支持 |
| REMOVE_EVENT_QUEUE_SUBSCRIBER Procedure | 不支持 |
| REMOVE_FROM_INCOMPATIBILITY Procedure | 不支持 |
| REMOVE_GROUP_MEMBER Procedure | 不支持 |
| REMOVE_JOB_EMAIL_NOTIFICATION Procedure | 不支持 |
| RESET_JOB_ARGUMENT_VALUE Procedure | 不支持 |
| RUN_CHAIN Procedure | 不支持 |
| RUN_JOB Procedure | RUN_JOB Procedure |
| SET_AGENT_REGISTRATION_PASS Procedure | 不支持 |
| SET_ATTRIBUTE Procedure | SET_ATTRIBUTE Procedure |
| SET_ATTRIBUTE_NULL Procedure | 不支持 |
| SET_JOB_ANYDATA_VALUE Procedure | 不支持 |
| SET_JOB_ARGUMENT_VALUE Procedure | SET_JOB_ARGUMENT_VALUE Procedure |
| SET_JOB_ATTRIBUTES Procedure | 不支持 |
| SET_RESOURCE_CONSTRAINT Procedure | 不支持 |
| SET_SCHEDULER_ATTRIBUTE Procedure | 不支持 |
| STOP_JOB Procedure | STOP_JOB Procedure |
| Oracle数据库 | GaussDB数据库 | 差异 |
|---|---|---|
| ACTIVE_INSTANCES Procedure | 不支持 | - |
| ANALYZE_DATABASE Procedure | 不支持 | - |
| ANALYZE_PART_OBJECT Procedure | 不支持 | - |
| ANALYZE_SCHEMA Procedure | 不支持 | - |
| CANONICALIZE Procedure | CANONICALIZE Procedure | GaussDB：参数canon_len默认为1024字节。 Oracle：参数canon_len无默认值。 |
| COMMA_TO_TABLE Procedures | COMMA_TO_TABLE Procedure | GaussDB：参数tab为VARCHAR2数组。 Oracle：该过程存在2个重载。参数tab可以为两种类型之一：一种为uncl_array，另一种为lname_array。 |
| COMPILE_SCHEMA Procedure | 不支持 | - |
| CREATE_ALTER_TYPE_ERROR_TABLE Procedure | 不支持 | - |
| CURRENT_INSTANCE Function | 不支持 | - |
| DATA_BLOCK_ADDRESS_BLOCK Function | 不支持 | - |
| DATA_BLOCK_ADDRESS_FILE Function | 不支持 | - |
| DB_VERSION Procedure | DB_VERSION Procedure | GaussDB：只有参数version，类型为VARCHAR2。Oracle：有参数version和compatibility，类型均为VARCHAR2。 |
| EXEC_DDL_STATEMENT Procedure | EXEC_DDL_STATEMENT Function | GaussDB：参数parse_string为TEXT类型。 Oracle：参数parse_string为VARCHAR2类型。 |
| EXPAND_SQL_TEXT Procedure | EXPAND_SQL_TEXT Function | GaussDB： 参数output_sql_text为CLOB。 Oracle：参数 output_sql_text为NOCOPY CLOB，通过传引用方式传递OUT参数。 |
| FORMAT_CALL_STACK Function | FORMAT_CALL_STACK Function | GaussDB：函数返回类型为TEXT。 Oracle：函数返回类型为VARCHAR2。 |
| FORMAT_ERROR_BACKTRACE Function | FORMAT_ERROR_BACKTRACE Function | GaussDB：函数返回类型为TEXT。 Oracle：函数返回类型为VARCHAR2。 |
| FORMAT_ERROR_STACK Function | FORMAT_ERROR_STACK Function | GaussDB：函数返回类型为TEXT。 Oracle：函数返回类型为VARCHAR2。 |
| GET_CPU_TIME Function | GET_CPU_TIME Function | GaussDB：函数返回类型为BIGINT。 Oracle：函数返回类型为NUMBER。 |
| GET_DEPENDENCY Procedure | 不支持 | - |
| GET_ENDIANNESS Function | GET_ENDIANNESS Function | GaussDB：函数返回类型为INTEGER。 Oracle：函数返回类型为NUMBER。 |
| GET_HASH_VALUE Function | GET_HASH_VALUE Function | GaussDB：参数base、hash_size和返回类型均为INTEGER。 Oracle：参数base、hash_size和返回类型均为NUMBER。 |
| GET_PARAMETER_VALUE Function | 不支持 | - |
| GET_SQL_HASH Function | GET_SQL_HASH Function | GaussDB：参数last4bytes 为BIGINT类型，代表MD5哈希值的最后四字节，以无符号整数形式展现，函数返回类型为BIGINT。 Oracle：对应参数pre10ihash为NUMBER类型，用于存储MD5计算得到的16字节中的4字节哈希值。 |
| GET_TIME Function | GET_TIME Function | GaussDB：函数返回类型为BIGINT。 Oracle：函数返回类型为NUMBER。 |
| GET_TZ_TRANSITIONS Procedure | 不支持 | - |
| INVALIDATE Procedure | 不支持 | - |
| IS_BIT_SET Function | IS_BIT_SET Function | GaussDB：参数n和返回值类型为INTEGER。 Oracle：参数n和返回值类型为NUMBER。 |
| IS_CLUSTER_DATABASE Function | IS_CLUSTER_DATABASE Function | - |
| MAKE_DATA_BLOCK_ADDRESS Function | 不支持 | - |
| NAME_RESOLVE Procedure | NAME_RESOLVE Procedure | GaussDB：参数context和part1_type为INTEGER，参数 object_number为OID；GaussDB不支持NUMBER到OID的隐式转换。 Oracle：参数context、part1_type和object_number均为NUMBER。 |
| NAME_TOKENIZE Procedure | NAME_TOKENIZE Procedure | GaussDB：参数nextpos为INTEGER类型。 Oracle：参数nextpos为BINARY_INTEGER类型。 |
| OLD_CURRENT_SCHEMA Function | OLD_CURRENT_SCHEMA Function | GaussDB：函数返回类型为VARCHAR。 Oracle：函数返回类型为VARCHAR2。 |
| OLD_CURRENT_USER Function | OLD_CURRENT_USER Function | GaussDB：函数返回类型为TEXT。 Oracle：函数返回类型为VARCHAR2。 |
| PORT_STRING Function | 不支持 | - |
| SQLID_TO_SQLHASH Function | 不支持 | - |
| TABLE_TO_COMMA Procedures | TABLE_TO_COMMA Procedure | GaussDB：参数tab为VARCHAR2数组。 Oracle：该存储过程存在2个重载。参数tab可以为两种类型之一：一种为uncl_array，另一种为lname_array。 |
| VALIDATE Procedure | 不支持 | - |
| WAIT_ON_PENDING_DML Function | 不支持 | - |
| Oracle数据库 | GaussDB数据库 | 差异 |
|---|---|---|
| BIND_ARRAY Procedures | SQL_BIND_ARRAY Function | - |
| BIND_VARIABLE Procedures | SQL_BIND_VARIABLEFunction | - |
| BIND_VARIABLE_PKG Procedure | 不支持 | - |
| CLOSE_CURSOR Procedure | SQL_UNREGISTER_CONTEXT Function | - |
| COLUMN_VALUE Procedure | GET_RESULT Procedure | - |
| COLUMN_VALUE_LONG Procedure | 不支持 | - |
| DEFINE_ARRAY Procedure | SET_RESULTS_TYPE Procedure | - |
| DEFINE_COLUMN Procedures | SET_RESULT_TYPE Procedure | - |
| DEFINE_COLUMN_CHAR Procedure | 不支持 | - |
| DEFINE_COLUMN_LONG Procedure | 不支持 | - |
| DEFINE_COLUMN_RAW Procedure | 不支持 | - |
| DEFINE_COLUMN_ROWID Procedure | 不支持 | - |
| DESCRIBE_COLUMNS Procedure | DESCRIBE_COLUMNS Procedure | - |
| DESCRIBE_COLUMNS2 Procedure | 不支持 | - |
| DESCRIBE_COLUMNS3 Procedure | 不支持 | - |
| EXECUTE Function | SQL_RUN Function | GaussDB：返回值为常量1。当前对于语句中unknown类型之间的比较，无法正确返回结果。 Oracle：对于INSERT、UPDATE和DELETE语句，返回值是影响的行数，对于其他语句则无意义。 |
| EXECUTE_AND_FETCH Function | RUN_AND_NEXT Function | - |
| FETCH_ROWS Function | NEXT_ROW Function | - |
| GET_NEXT_RESULT Procedures | 不支持 | - |
| IS_OPEN Function | IS_ACTIVE Function | - |
| LAST_ERROR_POSITION Function | 不支持 | - |
| LAST_ROW_COUNT Function | LAST_ROW_COUNT Function | - |
| LAST_ROW_ID Function | 不支持 | - |
| LAST_SQL_FUNCTION_CODE Function | 不支持 | - |
| OPEN_CURSOR Functions | REGISTER_CONTEXT Function | - |
| PARSE Procedures | 支持，有差异 | GaussDB中为SQL_SET_SQL Function，不支持重载。 |
| RETURN_RESULT Procedures | 不支持 | - |
| TO_CURSOR_NUMBER Function | 不支持 | - |
| TO_REFCURSOR Function | 不支持 | - |
| VARIABLE_VALUE Procedures | GET_VARIABLE_RESULT Procedures | - |
| VARIABLE_VALUE_PKG Procedure | 不支持 | - |
| Oracle数据库 | GaussDB数据库 |
|---|---|
| DBMS_SQL DESC_REC | DBE_SQL.DESC_REC |
| DBMS_SQL DATE_TABLE | DBE_SQL.DATE_TABLE |
| DBMS_SQL NUMBER_TABLE | DBE_SQL.NUMBER_TABLE |
| DBMS_SQL VARCHAR2_TABLE | DBE_SQL.VARCHAR2_TABLE |
| DBMS_SQL BLOB_TABLE | DBE_SQL.BLOB_TABLE |
| Oracle数据库 | GaussDB数据库 | 差异 |
|---|---|---|
| FCLOSE Procedure | CLOSE Procedure | - |
| FCLOSE_ALL Procedure | CLOSE_ALL Procedure | - |
| FCOPY Procedure | COPY Procedure | - |
| FFLUSH Procedure | FLUSH Procedure | - |
| FGETATTR Procedure | GET_ATTR Procedure | - |
| FGETPOS Function | GET_POS Function | - |
| FOPEN Function | FOPEN Function | - |
| FOPEN_NCHAR Function | FOPEN_NCHAR Function | - |
| FREMOVE Procedure | REMOVE Procedure | - |
| FRENAME Procedure | RENAME Procedure | - |
| FSEEK Procedure | SEEK Procedure | - |
| GET_LINE Procedure | READ_LINE Procedure | - |
| GET_LINE_NCHAR Procedure | READ_LINE_NCHAR Procedure | - |
| GET_RAW Procedure | GET_RAW Procedure | - |
| IS_OPEN Function | IS_OPEN Function | - |
| NEW_LINE Procedure | 支持，有差异，NEW_LINE Function | GaussDB将接口定义为Function。 |
| PUT Procedure | 支持，有差异，WRITE Function | GaussDB将接口定义为Function。 |
| PUT_LINE Procedure | 支持，有差异，WRITE_LINE Function | GaussDB将接口定义为Function。 |
| PUT_LINE_NCHAR Procedure | 支持，有差异，WRITE_LINE_NCHAR Function | GaussDB将接口定义为Function。 |
| PUT_NCHAR Procedure | 支持，有差异，WRITE_NCHAR Function | GaussDB将接口定义为Function。 |
| PUTF Procedure | 支持，有差异，FORMAT_WRITE Function | GaussDB将接口定义为Function。 |
| PUTF_NCHAR Procedure | 支持，有差异，FORMAT_WRITE_NCHAR Function | GaussDB将接口定义为Function。 |
| PUT_RAW Procedure | 支持，有差异，PUT_RAW Function | GaussDB将接口定义为Function。 |
| Oracle数据库 | GaussDB数据库 | 差异 |
|---|---|---|
| CLEAR_ALL_CONTEXT Procedure | 不支持 | - |
| CLEAR_CONTEXT Procedure | CLEAR_CONTEXT Function | - |
| CLEAR_IDENTIFIER Procedure | 不支持 | - |
| CLOSE_DATABASE_LINK Procedure | 不支持 | - |
| CURRENT_IS_ROLE_ENABLED Function | 不支持 | - |
| FREE_UNUSED_USER_MEMORY Procedure | 不支持 | - |
| GET_PACKAGE_MEMORY_UTILIZATION Procedure | 不支持 | - |
| IS_ROLE_ENABLED Function | 不支持 | - |
| IS_SESSION_ALIVE Function | 不支持 | - |
| LIST_CONTEXT Procedures | 不支持 | - |
| MODIFY_PACKAGE_STATE Procedure | MODIFY_PACKAGE_STATE Procedure | GaussDB：仅支持入参flags = 1的场景使用。 Oracle：支持flags=1或flags= 2的场景使用。 |
| RESET_PACKAGE Procedure | 不支持 | - |
| SESSION_IS_ROLE_ENABLED Function | 不支持 | - |
| SESSION_TRACE_DISABLE Procedure | 不支持 | - |
| SESSION_TRACE_ENABLE Procedure | 不支持 | - |
| SET_CONTEXT Procedure | SET_CONTEXT Function | GaussDB：仅包括参数namespace，attribute和value，类型均为text。 Oracle：包括参数namespace，attribute，value，username和client_id，类型均为VARCHAR2。 |
| SET_EDITION_DEFERRED Procedure | 不支持 | - |
| SET_IDENTIFIER Procedure | 不支持 | - |
| SET_NLS Procedure | 不支持 | - |
| SET_ROLE Procedure | 不支持 | - |
| SET_SQL_TRACE Procedure | 不支持 | - |
| SLEEP Procedure | 不支持 | - |
| SWITCH_CURRENT_CONSUMER_GROUP Procedure | 不支持 | -- |
| UNIQUE_SESSION_ID Function | 不支持 | - |
| Oracle数据库 | GaussDB数据库 | 差异 |
|---|---|---|
| EDIT_DISTANCE Function | 不支持 | - |
| EDIT_DISTANCE_SIMILARITY Function | EDIT_DISTANCE_SIMILARITY Function | GaussDB：参数str1和str2均为TEXT类型，函数返回类型为INTEGER。 Oracle：参数s1和s2为VARCHAR2类型，函数返回类型为PLS_INTEGER。 |
| JARO_WINKLER Function | 不支持 | - |
| JARO_WINKLER_SIMILARITY Function | 不支持 | - |
| Oracle数据库 | GaussDB数据库 | 差异 |
|---|---|---|
| READ_CLIENT_INFO Procedure | READ_CLIENT_INFO Function | GaussDB：参数client_info为TEXT类型。 Oracle：参数client_info为VARCHAR2类型。 |
| READ_MODULE Procedure | READ_MODULE Procedure | GaussDB：参数module_name、action_name为TEXT类型。 Oracle：参数module_name、action_name为VARCHAR2类型。 |
| SET_ACTION Procedure | SET_ACTION Procedure | GaussDB：参数action_name为TEXT类型。 Oracle：参数action_name为VARCHAR2类型。 |
| SET_CLIENT_INFO Procedure | SET_CLIENT_INFO Function | GaussDB：参数str为TEXT类型，且返回类型为void。 Oracle：参数client_info为VARCHAR2类型，无返回值。二者均为写入客户端信息，最大输入64字节，超过64字节将被截断。 |
| SET_MODULE Procedure | SET_MODULE Procedure | GaussDB：参数module_name、action_name为TEXT类型。 Oracle：参数module_name、action_name为VARCHAR2类型。 |
| SET_SESSION_LONGOPS Procedure | 不支持 | - |
| Oracle数据库 | GaussDB数据库 | 差异 |
|---|---|---|
| DBMS_XMLDOM.APPENDCHILD | DBE_XMLDOM.APPENDCHILD | GaussDB：DOCUMENT类型节点下APPEND ATTR类型节点会报“operation not support”错误。Oracle：在此场景下不报错，但实际并没有挂载成功。 GaussDB：ATTR类型节点下APPEND ATTR类型节点会报“operation not support”错误。Oracle：在此场景下不报错，但实际并没有挂载成功。 GaussDB：父节点在添加多个ATTR类型子节点时，不允许KEY值相同的子节点同时存在于同一个父节点下。Oracle：允许KEY值相同的子节点同时存在于同一个父节点下。 |
| DBMS_XMLDOM.CREATEELEMENT | DBE_XMLDOM.CREATEELEMENT | - |
| DBMS_XMLDOM.CREATETEXTNODE | DBE_XMLDOM.CREATETEXTNODE | - |
| DBMS_XMLDOM.FREEDOCUMENT | DBE_XMLDOM.FREEDOCUMENT | GaussDB：释放时不会立刻释放对象，累积一定数量后释放。document下全部节点失效。 Oracle：立即释放对象。 |
| DBMS_XMLDOM.FREEELEMENT | DBE_XMLDOM.FREEELEMENT | - |
| DBMS_XMLDOM.FREENODE | DBE_XMLDOM.FREENODE | - |
| DBMS_XMLDOM.FREENODELIST | DBE_XMLDOM.FREENODELIST | GaussDB：nodelist会被释放。 Oracle：释放nodelist后，在原始的doc中还能被查询到。 |
| DBMS_XMLDOM.GETATTRIBUTE | DBE_XMLDOM.GETATTRIBUTE | - |
| DBMS_XMLDOM.GETATTRIBUTES | DBE_XMLDOM.GETATTRIBUTES | - |
| DBMS_XMLDOM.GETCHILDNODES | DBE_XMLDOM.GETCHILDNODES | GaussDB：对document的node使用时会包含dtd。 Oracle：不包含dtd。 |
| DBMS_XMLDOM.GETCHILDRENBYTAGNAME | DBE_XMLDOM.GETCHILDRENBYTAGNAME | GaussDB：DBE_XMLDOM.GETCHILDRENBYTAGNAME接口的参数ns不支持传入参数" * "，如需获取节点下全部属性，可使用DBE_XMLDOM.GETCHILDNODES接口。 Oracle：支持传入参数" * "。 |
| DBMS_XMLDOM.GETDOCUMENTELEMENT | DBE.XMLDOM.GETDOCUMENTELEMENT | - |
| DBMS_XMLDOM.GETFIRSTCHILD | DBE_XMLDOM.GETFIRSTCHILD | - |
| DBMS_XMLDOM.GETLASTCHILD | DBE_XMLDOM.GETLASTCHILD | - |
| DBMS_XMLDOM.GETLENGTH | DBE_XMLDOM.GETLENGTH | - |
| DBMS_XMLDOM.GETLOCALNAME | DBE_XMLDOM.GETLOCALNAME | - |
| DBMS_XMLDOM.GETNAMEDITEM | DBE_XMLDOM.GETNAMEDITEM | - |
| DBMS_XMLDOM.GETNEXTSIBLING | DBE_XMLDOM.GETNEXTSIBLING | - |
| DBMS_XMLDOM.GETNODENAME | DBE_XMLDOM.GETNODENAME | - |
| DBMS_XMLDOM.GETNODETYPE | DBE_XMLDOM.GETNODETYPE | - |
| DBMS_XMLDOM.GETTAGNAME | DBE_XMLDOM.GETTAGNAME | - |
| DBMS_XMLDOM.IMPORTNODE | DBE_XMLDOM.IMPORTNODE | - |
| DBMS_XMLDOM.ISNULL | DBE_XMLDOM.ISNULL | GaussDB：入参为DOMNODELIST类型时，若对象在哈希表中不存在会发生报错。 Oracle：不会报错。 |
| DBMS_XMLDOM.ITEM | DBE_XMLDOM.ITEM | - |
| DBMS_XMLDOM.MAKENODE | DBE_XMLDOM.MAKENODE | GaussDB：该函数不支持直接作为函数返回值返回。 Oracle：支持直接作为函数返回值返回。 |
| DBMS_XMLDOM.NEWDOMDOCUMENT | DBE_XMLDOM.NEWDOMDOCUMENT | GaussDB入参大小需限制在2GB以内。Oracle：与CLOB类型大小一致。 GaussDB目前暂不支持外部DTD解析。Oracle：支持解析外部DTD。 GaussDB newdomdocument创建的doc，默认UTF-8字符集。Oracle：根据服务端字符集生成。 GaussDB从同一个xmltype实例中解析出的每一个doc都是独立的，对doc的修改也不会影响到xmltype。Oracle：从同一个xmltype实例中解析出的每一个doc不独立，有关联关系。 GaussDB version字段只支持1.0，1.0-1.9解析警告但正常执行，1.9以上报错。Oracle：不报错。 GaussDB与Oracle数据库DTD校验差异：!ATTLIST to type (CHECK\|check\|Check) "Ch..."将报错，因默认值"Ch..."不属于括号中枚举值，而Oracle数据库不报错。<!ENTITY baidu "www.baidu.com">...... &Baidu;&writer将报错，因区分字母大小写，Baidu无法与baidu对应。Oracle：不报错。 GaussDB 与Oracle数据库命名空间校验差异：解析未声明的命名空间标签正常执行。Oracle：报错。 |
| DBMS_XMLDOM.SETATTRIBUTE | DBE_XMLDOM.SETATTRIBUTE | GaussDB：属性key不支持为null或空字符串。 Oracle：属性key允许为null或空字符串。 |
| DBMS_XMLDOM.SETCHARSET | DBE_XMLDOM.SETCHARSET | GaussDB目前支持的字符集有：UTF-8、UCS-4、UCS-2、ISO-8859-1、ISO-8859-2、ISO-8859-3、ISO-8859-4、ISO-8859-5、ISO-8859-6、ISO-8859-7、ISO-8859-8、ISO-8859-9、ISO-2022-JP、Shift_JIS、EUC-JP、ASCII。输入其他字符集会报错或者可能导致输出乱码。 |
| DBMS_XMLDOM.SETDOCTYPE | DBE_XMLDOM.SETDOCTYPE | GaussDB name、sysid、pubid的总长度限制在32500个字节以内。 Oracle：限制在32767字节内。 |
| DBMS_XMLDOM.WRITETOBUFFER | DBE_XMLDOM.WRITETOBUFFER | GaussDB writetobuffer输出buffer限制在1GB以内。Oracle：限制在32767字节内。 GaussDB输出doc将包含XML声明version和encoding。Oracle：用户不主动指定将不包含。 GaussDB入参为domnode类型时，如果节点是doc转换的，输出节点将包含XML声明version和encoding。Oracle：用户不主动指定将不包含。 GaussDB默认以UTF-8字符集输出xml。Oracle：根据数据库字符集生成。 |
| DBMS_XMLDOM.WRITETOCLOB | DBE_XMLDOM.WRITETOCLOB | GaussDB writetoclob大小支持1GB以内。Oracle：按CLOB大小支持。 GaussDB输出doc将包含XML声明version和encoding。Oracle：用户不主动指定将不包含。 GaussDB入参为domnode类型时，如果节点是doc转换的，输出节点将包含XML声明version和encoding。Oracle：用户不主动指定将不包含。 GaussDB 默认以UTF-8字符集输出xml。Oracle：根据数据库字符集生成。 |
| DBMS_XMLDOM.WRITETOFILE | DBE_XMLDOM.WRITETOFILE | GaussDB document入参，filename长度限制在255个字节以内，charset请参考dbe_xmldom.setcharset接口。Oracle：filename长度限制受操作系统影响，大于255个字节。 GaussDB domnode入参，filename长度限制在255个字节以内，charset请参考dbe_xmldom.setcharset接口。Oracle：filename长度限制受操作系统影响，大于255个字节。 GaussDB该函数会添加缩进等内容，将输出格式化。输出doc将包含XML声明version和encoding。入参为domnode类型时，如果节点是doc转换的，输出节点将包含XML声明version和encoding。Oracle：用户不主动指定将不包含。 GaussDB传入newdomdocument()无参创建的doc，在不指定charset时不会报错，默认UTF-8字符集。Oracle：会进行报错。 GaussDB filename需要在pg_directory中创建的路径下，filename中的\会被转换成/，只允许存在一个/。文件名格式应为pg_directory_name/file_name。Oracle：按用户输入不进行转义。 |
| DBMS_XMLDOM.GETNODEVALUE | DBE_XMLDOM.GETNODEVALUE | - |
| DBMS_XMLDOM.GETPARENTNODE | DBE_XMLDOM.GETPARENTNODE | - |
| DBMS_XMLDOM.HASCHILDNODES | DBE_XMLDOM.HASCHILDNODES | - |
| DBMS_XMLDOM.MAKEELEMENT | DBE_XMLDOM.MAKEELEMENT | - |
| DBMS_XMLDOM.SETNODEVALUE | DBE_XMLDOM.SETNODEVALUE | GaussDB nodeValue入参，可以输入空字符串和NULL值，但不会对节点值进行修改。Oracle：空字符串和NULL会将节点值修改为空字符串。 GaussDB nodeValue入参，暂不支持转义字符'&'，如字符串中包含该转义字符，会清空节点值。Oracle：支持转义字符。 |
| DBMS_XMLDOM.GETELEMENTSBYTAGNAME | DBE_XMLDOM.GETELEMENTSBYTAGNAME | - |
| Oracle数据库 | GaussDB数据库 | 差异 |
|---|---|---|
| DBMS_XMLPARSER.FREEPARSER | DBE_XMLPARSER.FREEPARSER | - |
| DBMS_XMLPARSER.GETDOCUMENT | DBE_XMLPARSER.GETDOCUMENT | - |
| DBMS_XMLPARSER.GETVALIDATIONMODE | DBE_XMLPARSER.GETVALIDATIONMODE | - |
| DBMS_XMLPARSER.NEWPARSER | 支持，有差异，DBE_XMLPARSER.NEWPARSER | GaussDB中parser对象的数量上限为16777215，Oracle数据库中约为1亿。 |
| DBMS_XMLPARSER.PARSEBUFFER | 支持，有差异，DBE_XMLPARSER.PARSEBUFFER | 1. 与Oracle数据库解析字段差异： 字符串encoding只支持UTF-8；version字段只支持1.0，1.0-1.9解析警告但正常执行，1.9以上报错。 2. 与Oracle数据库命名空间校验差异：解析未声明的命名空间标签正常执行，而Oracle数据库会报错。 3. 与Oracle数据库xml预定义实体解析差异：&apos;&quot;会被解析转译为字符’”，而Oracle数据库中预定义实体统一都没有转译为字符。 4. 与Oracle数据库DTD校验差异：!ATTLIST to type (CHECK\|check\|Check) "Ch..."将报错，因默认值"Ch..."不属于括号中枚举值，而Oracle数据库不报错。<!ENTITY baidu "www.baidu.com">...... &Baidu;&writer将报错，因区分字母大小写，Baidu无法与baidu对应，而Oracle数据库不报错。 |
| DBMS_XMLPARSER.PARSECLOB | 支持，有差异，DBE_XMLPARSER.PARSECLOB | 1. PARSECLOB不支持解析大于等于2GB的clob。 2. 与Oracle数据库解析字段差异： 字符串encoding只支持UTF-8；version字段只支持1.0，1.0-1.9解析警告但正常执行，1.9以上报错。 3. 与Oracle数据库命名空间校验差异：解析未声明的命名空间标签正常执行，而Oracle数据库会报错。 4. 与Oracle数据库xml预定义实体解析差异：&apos;&quot;会被解析转译为字符’”，而Oracle数据库预定义实体统一都没有转译为字符。 5. 与Oracle数据库DTD校验差异：!ATTLIST to type (CHECK\|check\|Check) "Ch..."将报错，因默认值"Ch..."不属于括号中枚举值，而Oracle数据库不报错。<!ENTITY baidu "www.baidu.com">...... &Baidu;&writer将报错，因区分字母大小写，Baidu无法与baidu对应，而Oracle数据库不报错。 |
| DBMS_XMLPARSER.SETVALIDATIONMODE | DBE_XMLPARSER.SETVALIDATIONMODE | - |
| Oracle数据库 | GaussDB数据库 | 差异 |
|---|---|---|
| DBMS_ILM.ADD_TO_ILM | 不支持 | - |
| DBMS_ILM.ARCHIVESTATENAME | 不支持 | - |
| DBMS_ILM.EXECUTE_ILM | 支持，有差异，DBE_ILM.EXECUTE_ILM | GaussDB数据库的入参Schema在Oracle数据库中对应为owner。GaussDB数据库不支持指定ilm_scope（一次指定多个对象）的操作。 |
| DBMS_ILM.EXECUTE_ILM_TASK | 不支持 | - |
| DBMS_ILM.PREVIEW_ILM | 不支持 | - |
| DBMS_ILM.REMOVE_FROM_ILM | 不支持 | - |
| DBMS_ILM.STOP_ILM | DBE_ILM.STOP_ILM | - |
| Oracle数据库 | GaussDB数据库 | 差异 |
|---|---|---|
| DBMS_ILM_ADMIN.CLEAR_HEAT_MAP_ALL | 不支持 | - |
| DBMS_ILM_ADMIN.CLEAR_HEAT_MAP_TABLE | 不支持 | - |
| DBMS_ILM_ADMIN.CUSTOMIZE_ILM | 支持，有差异，DBE_ILM_ADMIN.CUSTOMIZE_ILM | 入参parameter取值对应的特性参数存在差异。GaussDB数据库param取值支持1、2、7、11、12、13、14和15。GaussDB数据库param取值为14时，对应的特性参数为WIND_DURATION，用于控制自动调度中执行窗口的持续时长，而ORACLE数据库对应的特性参数则为AUTO_OPTIMIZE_INACTIVITY_THRESHOLD，其表示ado的不活动时间长度。 |
| DBMS_ILM_ADMIN.DISABLE_ILM | DBE_ILM_ADMIN.DISABLE_ILM | - |
| DBMS_ILM_ADMIN.ENABLE_AUTO_OPTIMIZE | 不支持 | - |
| DBMS_ILM_ADMIN.ENABLE_ILM | DBE_ILM_ADMIN.ENABLE_ILM | - |
| DBMS_ILM_ADMIN. IGNORE_AUTO_OPTIMIZE_ CRITERIA | 不支持 | - |
| DBMS_ILM_ADMIN.SET_HEAT_MAP_ALL | 不支持 | - |
| DBMS_ILM_ADMIN.SET_HEAT_MAP_START | 不支持 | - |
| DBMS_ILM_ADMIN.SET_HEAT_MAP_TABLE | 不支持 | - |
| Oracle数据库 | GaussDB数据库 | 差异 |
|---|---|---|
| DBMS_COMPRESSION.GET_COMPRESSION_RATIO | 支持，有差异，DBE_COMPRESSION.GET_COMPRESSION_RATIO | GaussDB不支持LOBs的压缩率获取。对于单个对象的压缩率获取：GaussDB入参comptype取值仅支持1（未压缩）和2（高级压缩），Oracle还支持1024、2048等取值。GaussDB入参objtype取值仅支持1（表对象），而Oracle还支持2（索引对象）。Oracle数据库使用subset_numrows参数直接来决定采样的行数（即为参数的取值），而GaussDB则使用sample_ratio（采样率）来间接确定采样的行数。 |
| DBMS_COMPRESSION.GET_COMPRESSION_TYPE | 支持，有差异，DBE_COMPRESSION.GET_COMPRESSION_TYPE | Oracle使用rowid来指定待获取压缩类型的行，而GaussDB则是使用行的ctid来指定。返回值为comptype，其取值差异同GET_COMPRESSION_RATIO。 |
| Oracle数据库 | GaussDB数据库 | 差异 |
|---|---|---|
| DBMS_HEAT_MAP.BLOCK_HEAT_MAP | 不支持 | - |
| DBMS_HEAT_MAP.EXTENT_HEAT_MAP | 不支持 | - |
| DBMS_HEAT_MAP.OBJECT_HEAT_MAP | 不支持 | - |
| DBMS_HEAT_MAP.SEGMENT_HEAT_MAP | 不支持 | - |
| DBMS_HEAT_MAP.TABLESPACE_HEAT_MAP | 不支持 | - |
| 不支持 | DBE_HEAT_MAP.ROW_HEAT_MAP | 具体的行为差异请参见DBE_HEAT_MAP。 |
| Oracle数据库 | GaussDB数据库 | 差异 |
|---|---|---|
| DBMS_DESCRIBE.DESCRIBE_PROCEDURE | 支持，有差异，DBE_DESCRIBE.DESCRIBE_PROCEDURE | datatype参数与O存在差异，GaussDB返回数据类型的oid，O数据库返回O数据库内部的数据类型的编号。datalength、dataprecision和scale因GaussDB创建存储过程或函数时无法保留类型的约束（如number(7,2)、varchar2(20)等），该三个参数置0处理；Oracle可使用%type方法获得带约束的数据类型。具体的行为差异请参见DBE_DESCRIBE。 |
| Oracle数据库 | GaussDB数据库 | 差异 |
|---|---|---|
| DBMS_STATS.ALTER_STATS_HISTORY_RETENTION | 不支持 | - |
| DBMS_STATS.CANCEL_ADVISOR_TASK | 不支持 | - |
| DBMS_STATS.CONFIGURE_ADVISOR_FILTER | 不支持 | - |
| DBMS_STATS.CONFIGURE_ADVISOR_OBJ_FILTER | 不支持 | - |
| DBMS_STATS.CONFIGURE_ADVISOR_OPR_FILTER | 不支持 | - |
| DBMS_STATS.CONFIGURE_ADVISOR_RULE_FILTER | 不支持 | - |
| DBMS_STATS.CREATE_ADVISOR_TASK | 不支持 | - |
| DBMS_STATS.CONVERT_RAW_VALUE | 不支持 | - |
| DBMS_STATS.CONVERT_RAW_VALUE_NVARCHAR | 不支持 | - |
| DBMS_STATS.CONVERT_RAW_VALUE_ROWID | 不支持 | - |
| DBMS_STATS.COPY_TABLE_STATS | 不支持 | - |
| DBMS_STATS.CREATE_EXTENDED_STATS | 不支持 | - |
| DBMS_STATS.CREATE_STAT_TABLE | DBE_STATS.CREATE_STAT_TABLE | GaussDB中ownname应传Schema名。GaussDB仅支持部分入参功能，具体请参见DBE_STATS。 |
| DBMS_STATS.DELETE_COLUMN_STATS | DBE_STATS.DELETE_COLUMN_STATS | GaussDB中ownname应传Schema名。GaussDB仅支持部分入参功能，具体请参见DBE_STATS。GaussDB中，使用该接口可以设置表达式统计信息，但tabname应传该表达式对应的索引名。 |
| DBMS_STATS.DELETE_DATABASE_PREFS | 不支持 | - |
| DBMS_STATS.DELETE_DATABASE_STATS | 不支持 | - |
| DBMS_STATS.DELETE_DICTIONARY_STATS | 不支持 | - |
| DBMS_STATS.DELETE_FIXED_OBJECTS_STATS | 不支持 | - |
| DBMS_STATS.DELETE_INDEX_STATS | DBE_STATS.DELETE_INDEX_STATS | GaussDB中ownname应传Schema名。GaussDB仅支持部分入参功能，具体请参见DBE_STATS。 |
| DBMS_STATS.DELETE_PENDING_STATS | 不支持 | - |
| DBMS_STATS.DELETE_PROCESSING_RATE | 不支持 | - |
| DBMS_STATS.DELETE_SCHEMA_PREFS | 不支持 | - |
| DBMS_STATS.DELETE_SCHEMA_STATS | DBE_STATS.DELETE_SCHEMA_STATS | GaussDB中ownname应传Schema名。GaussDB仅支持部分入参功能，具体请参见DBE_STATS。 |
| DBMS_STATS.DELETE_SYSTEM_STATS | 不支持 | - |
| DBMS_STATS.DELETE_TABLE_PREFS | 不支持 | - |
| DBMS_STATS.DELETE_TABLE_STATS | DBE_STATS.DELETE_TABLE_STATS | GaussDB中ownname应传Schema名。GaussDB仅支持部分入参功能，具体请参见DBE_STATS。 |
| DBMS_STATS.DIFF_TABLE_STATS_IN_HISTORY | 不支持 | - |
| DBMS_STATS.DIFF_TABLE_STATS_IN_PENDING | 不支持 | - |
| DBMS_STATS.DIFF_TABLE_STATS_IN_STATTAB | 不支持 | - |
| DBMS_STATS.DROP_ADVISOR_TASK | 不支持 | - |
| DBMS_STATS.DROP_EXTENDED_STATS | 不支持 | - |
| DBMS_STATS.DROP_STAT_TABLE | DBE_STATS.DROP_STAT_TABLE | - |
| DBMS_STATS.EXECUTE_ADVISOR_TASK | 不支持 | - |
| DBMS_STATS.EXPORT_COLUMN_STATS | DBE_STATS.EXPORT_COLUMN_STATS | GaussDB中ownname应传Schema名。GaussDB仅支持部分入参功能，具体请参见DBE_STATS。导出的列级统计信息与pg_statistic表保持一致，多列和pg_statistic_ext表保持一致。支持导出索引表达式统计信息。要求tabname传的是索引名称，colname传的是索引表达式名称。权限：需要具有查询表的ANALYZE权限以及stattab表的siud权限。 |
| DBMS_STATS.EXPORT_DATABASE_PREFS | 不支持 | - |
| DBMS_STATS.EXPORT_DATABASE_STATS | DBE_STATS.EXPORT_DATABASE_STATS | GaussDB中statown应传Schema名。GaussDB仅支持部分入参功能，具体请参见DBE_STATS。stattab表中，导出的表、分区级统计信息为numrows、numblocks、relallvisible，分别对应系统表pg_class、pg_partition的reltuples、relpages、relallvisible。权限：需要具有查询表的ANALYZE权限以及stattab表的siud权限。 |
| DBMS_STATS.EXPORT_DICTIONARY_STATS | 不支持 | - |
| DBMS_STATS.EXPORT_FIXED_OBJECTS_STATS | 不支持 | - |
| DBMS_STATS.EXPORT_INDEX_STATS | DBE_STATS.EXPORT_INDEX_STATS | GaussDB中ownname应传Schema名。GaussDB仅支持部分入参功能，具体请参见DBE_STATS。stattab表中，导出的表、分区级统计信息为numrows、numblocks、relallvisible，分别对应系统表pg_class、pg_partition的reltuples、relpages、relallvisible。权限：需要具有查询表的ANALYZE权限以及stattab表的siud权限。 |
| DBMS_STATS.EXPORT_PENDING_STATS | 不支持 | - |
| DBMS_STATS.EXPORT_SCHEMA_PREFS | 不支持 | - |
| DBMS_STATS.EXPORT_SCHEMA_STATS | DBE_STATS.EXPORT_SCHEMA_STATS | GaussDB中ownname应传Schema名。GaussDB仅支持部分入参功能，具体请参见DBE_STATS。stattab表中，导出的表、分区级统计信息为numrows、numblocks、relallvisible，分别对应系统表pg_class、pg_partition的reltuples，relpages，relallvisible。导出表相关列级统计信息与pg_statistic表和pg_statistic_ext表保持一致。权限：需要具有stattab表的siud权限。 |
| DBMS_STATS.EXPORT_SYSTEM_STATS | 不支持 | - |
| DBMS_STATS.EXPORT_TABLE_PREFS | 不支持 | - |
| DBMS_STATS.EXPORT_TABLE_STATS | DBE_STATS.EXPORT_TABLE_STATS | GaussDB中ownname应传Schema名。GaussDB仅支持部分入参功能，具体请参见DBE_STATS。stattab表中，导出的表、分区级统计信息为numrows、numblocks、relallvisible，分别对应系统表pg_class、pg_partition的reltuples，relpages，relallvisible。级联导出的列级统计信息与pg_statistic表和pg_statistic_ext表保持一致。权限：需要具有查询表的ANALYZE权限以及stattab表的siud权限。 |
| DBMS_STATS.FLUSH_DATABASE_MONITORING_INFO | 不支持 | - |
| DBMS_STATS.GATHER_DATABASE_STATS | 不支持 | - |
| DBMS_STATS.GATHER_DICTIONARY_STATS | 不支持 | - |
| DBMS_STATS.GATHER_FIXED_OBJECTS_STATS | 不支持 | - |
| DBMS_STATS.GATHER_INDEX_STATS | 不支持 | - |
| DBMS_STATS.GATHER_PROCESSING_RATE | 不支持 | - |
| DBMS_STATS.GATHER_SCHEMA_STATS | 不支持 | - |
| DBMS_STATS.GATHER_SYSTEM_STATS | 不支持 | - |
| DBMS_STATS.GATHER_TABLE_STATS | 不支持 | - |
| DBMS_STATS.GENERATE_STATS | 不支持 | - |
| DBMS_STATS.GET_ADVISOR_OPR_FILTER | 不支持 | - |
| DBMS_STATS.GET_ADVISOR_RECS | 不支持 | - |
| DBMS_STATS.GET_COLUMN_STATS | 不支持 | - |
| DBMS_STATS.GET_INDEX_STATS | 不支持 | - |
| DBMS_STATS.GET_PARAM | 不支持 | - |
| DBMS_STATS.GET_PREFS | 不支持 | - |
| DBMS_STATS.GET_STATS_HISTORY_AVAILABILITY | DBE_STATS.GET_STATS_HISTORY_AVAILABILITY | GaussDB查询到的是全库存在的最早历史统计信息的收集时间。 |
| DBMS_STATS.GET_STATS_HISTORY_RETENTION | DBE_STATS.GET_STATS_HISTORY_RETENTION | - |
| DBMS_STATS.GET_SYSTEM_STATS | 不支持 | - |
| DBMS_STATS.GET_TABLE_STATS | 不支持 | - |
| DBMS_STATS.IMPLEMENT_ADVISOR_TASK | 不支持 | - |
| DBMS_STATS.IMPORT_COLUMN_STATS | DBE_STATS.IMPORT_COLUMN_STATS | GaussDB中ownname应传Schema名。GaussDB仅支持部分入参功能，具体请参见DBE_STATS。导出单列col导出的统计信息与pg_statistic表保持一致。多列ext-col导出的统计信息与pg_statistic_ext表保持一致。支持导入索引表达式统计信息。要求tabname传的是索引名称，colname传的是索引表达式名称。权限：需要具有查询表的ANALYZE权限以及stattab表的siud权限。 |
| DBMS_STATS.IMPORT_DATABASE_PREFS | 不支持 | - |
| DBMS_STATS.IMPORT_DATABASE_STATS | DBE_STATS.IMPORT_DATABASE_STATS | GaussDB中statown应传Schema名。GaussDB仅支持部分入参功能，具体请参见DBE_STATS。stattab表中，导入的表、分区级统计信息为numrows、numblocks、relallvisible，分别对应系统表pg_class、pg_partition的reltuples、relpages、relallvisible。 |
| DBMS_STATS.IMPORT_DICTIONARY_STATS | 不支持 | - |
| DBMS_STATS.IMPORT_FIXED_OBJECTS_STATS | 不支持 | - |
| DBMS_STATS.IMPORT_INDEX_STATS | DBE_STATS.IMPORT_INDEX_STATS | GaussDB中ownname应传Schema名。GaussDB仅支持部分入参功能，具体请参见DBE_STATS。stattab表中，导入的表、分区级统计信息为numrows、numblocks、relallvisible，分别对应系统表pg_class、pg_partition的reltuples，relpages，relallvisible。权限：需要具有查询表的ANALYZE权限以及stattab表的siud权限。 |
| DBMS_STATS.IMPORT_SCHEMA_PREFS | 不支持 | - |
| DBMS_STATS.IMPORT_SCHEMA_STATS | DBE_STATS.IMPORT_SCHEMA_STATS | GaussDB中ownname应传Schema名。GaussDB仅支持部分入参功能，具体请参见DBE_STATS。stattab表中，导入的表、分区级统计信息为numrows、numblocks、relallvisible，分别对应系统表pg_class、pg_partition的reltuples，relpages，relallvisible。导入表相关列级统计信息与pg_statistic表和pg_statistic_ext表保持一致。权限：需要具有stattab表的siud权限。 |
| DBMS_STATS.IMPORT_SYSTEM_STATS | 不支持 | - |
| DBMS_STATS.IMPORT_TABLE_PREFS | 不支持 | - |
| DBMS_STATS.IMPORT_TABLE_STATS | DBE_STATS.IMPORT_TABLE_STATS | GaussDB中ownname应传Schema名。GaussDB仅支持部分入参功能，具体请参见DBE_STATS。stattab表中，导入的表、分区级统计信息为numrows、numblocks、relallvisible，分别对应系统表pg_class、pg_partition的reltuples，relpages，relallvisible。级联导入的列级统计信息与pg_statistic表和pg_statistic_ext表保持一致。权限：需要具有查询表的ANALYZE权限以及stattab表的siud权限。 |
| DBMS_STATS.INTERRUPT_ADVISOR_TASK | 不支持 | - |
| DBMS_STATS.LOCK_PARTITION_STATS | DBE_STATS.LOCK_PARTITION_STATS | GaussDB中ownname应传Schema名。 |
| DBMS_STATS.LOCK_SCHEMA_STATS | DBE_STATS.LOCK_SCHEMA_STATS | GaussDB中ownname应传Schema名。 |
| DBMS_STATS.LOCK_TABLE_STATS | DBE_STATS.LOCK_TABLE_STATS | GaussDB中ownname应传Schema名。 |
| DBMS_STATS.MERGE_COL_USAGE | 不支持 | - |
| DBMS_STATS.PREPARE_COLUMN_VALUES | 不支持 | - |
| DBMS_STATS.PREPARE_COLUMN_VALUES_ROWID | 不支持 | - |
| DBMS_STATS.PUBLISH_PENDING_STATS | 不支持 | - |
| DBMS_STATS.PURGE_STATS | DBE_STATS.PURGE_STATS | - |
| DBMS_STATS.REMAP_STAT_TABLE | 不支持 | - |
| DBMS_STATS.REPORT_ADVISOR_TASK | 不支持 | - |
| DBMS_STATS.REPORT_COL_USAGE | 不支持 | - |
| DBMS_STATS.REPORT_GATHER_AUTO_STATS | 不支持 | - |
| DBMS_STATS.REPORT_GATHER_DATABASE_STATS | 不支持 | - |
| DBMS_STATS.REPORT_GATHER_DICTIONARY_STATS | 不支持 | - |
| DBMS_STATS.REPORT_GATHER_FIXED_OBJ_STATS | 不支持 | - |
| DBMS_STATS.REPORT_GATHER_SCHEMA_STATS | 不支持 | - |
| DBMS_STATS.REPORT_STATS_OPERATIONS | 不支持 | - |
| DBMS_STATS.RESET_ADVISOR_TASK | 不支持 | - |
| DBMS_STATS.RESET_COL_USAGE | 不支持 | - |
| DBMS_STATS.RESET_GLOBAL_PREF_DEFAULTS | 不支持 | - |
| DBMS_STATS.RESET_PARAM_DEFAULTS | 不支持 | - |
| DBMS_STATS.RESTORE_DICTIONARY_STATS | 不支持 | - |
| DBMS_STATS.RESTORE_FIXED_OBJECTS_STATS | 不支持 | - |
| DBMS_STATS.RESTORE_SCHEMA_STATS | DBE_STATS.RESTORE_SCHEMA_STATS | GaussDB中ownname应传Schema名。GaussDB仅支持部分入参功能，具体请参见DBE_STATS。 |
| DBMS_STATS.RESTORE_SYSTEM_STATS | 不支持 | - |
| DBMS_STATS.RESTORE_TABLE_STATS | DBE_STATS.RESTORE_TABLE_STATS | GaussDB中ownname应传Schema名。GaussDB仅支持部分入参功能，具体请参见DBE_STATS。 |
| DBMS_STATS.RESUME_ADVISOR_TASK | 不支持 | - |
| DBMS_STATS.SCRIPT_ADVISOR_TASK | 不支持 | - |
| DBMS_STATS.SEED_COL_USAGE | 不支持 | - |
| DBMS_STATS.SET_ADVISOR_TASK_PARAMETER | 不支持 | - |
| DBMS_STATS.SET_COLUMN_STATS | DBE_STATS.SET_COLUMN_STATS | GaussDB中ownname应传Schema名。GaussDB仅支持部分入参功能，具体请参见DBE_STATS。 |
| DBMS_STATS.SET_DATABASE_PREFS | 不支持 | - |
| DBMS_STATS.SET_GLOBAL_PREFS | 不支持 | - |
| DBMS_STATS.SET_INDEX_STATS | DBE_STATS.SET_INDEX_STATS | GaussDB中ownname应传Schema名。GaussDB仅支持部分入参功能，具体请参见DBE_STATS。GaussDB中新增了relallvisible入参。 |
| DBMS_STATS.SET_PARAM | 不支持 | - |
| DBMS_STATS.SET_PROCESSING_RATE | 不支持 | - |
| DBMS_STATS.SET_SCHEMA_PREFS | 不支持 | - |
| DBMS_STATS.SET_SYSTEM_STATS | 不支持 | - |
| DBMS_STATS.SET_TABLE_PREFS | 不支持 | - |
| DBMS_STATS.SET_TABLE_STATS | DBE_STATS.SET_TABLE_STATS | GaussDB中ownname应传Schema名。GaussDB仅支持部分入参功能，具体请参见DBE_STATS。GaussDB中新增了relallvisible入参。 |
| DBMS_STATS.SHOW_EXTENDED_STATS_NAME | 不支持 | - |
| DBMS_STATS.TRANSFER_STATS | 不支持 | - |
| DBMS_STATS.UNLOCK_PARTITION_STATS | DBE_STATS.UNLOCK_PARTITION_STATS | GaussDB中ownname应传Schema名。 |
| DBMS_STATS.UNLOCK_SCHEMA_STATS | DBE_STATS.UNLOCK_SCHEMA_STATS | GaussDB中ownname应传Schema名。 |
| DBMS_STATS.UNLOCK_TABLE_STATS | DBE_STATS.UNLOCK_TABLE_STATS | GaussDB中ownname应传Schema名。 |
| DBMS_STATS.UPGRADE_STAT_TABLE | 不支持 | - |
| Oracle数据库 | GaussDB数据库 | 差异 |
|---|---|---|
| DBMS_XMLGEN.CONVERT | DBE_XMLGEN.CONVERT | - |
| DBMS_XMLGEN.NEWCONTEXT | DBE_XMLGEN.NEWCONTEXT | - |
| DBMS_XMLGEN.NEWCONTEXTFROMHIERARCHY | DBE_XMLGEN.NEWCONTEXTFROMHIERARCHY | GaussDB生成的递归XML最大深度不能超过5000万层。Oracle的newcontextfromhierarchy方法对于connect by语句生成的xml是带xml头的，但是对于直接构造的数据不带xml头，GaussDB均带xml头。 |
| DBMS_XMLGEN.SETCONVERTSPECIALCHARS | DBE_XMLGEN.SETCONVERTSPECIALCHARS | - |
| DBMS_XMLGEN.SETNULLHANDLING | DBE_XMLGEN.SETNULLHANDLING | - |
| DBMS_XMLGEN.SETROWSETTAG | DBE_XMLGEN.SETROWSETTAG | - |
| DBMS_XMLGEN.SETROWTAG | DBE_XMLGEN.SETROWTAG | - |
| DBMS_XMLGEN.USENULLATTRIBUTEINDICATOR | DBE_XMLGEN.USENULLATTRIBUTEINDICATOR | - |
| DBMS_XMLGEN.USEITEMTAGSFORCOLL | DBE_XMLGEN.USEITEMTAGSFORCOLL | - |
| DBMS_XMLGEN.GETNUMROWSPROCESSED | DBE_XMLGEN.GETNUMROWSPROCESSED | - |
| DBMS_XMLGEN.SETMAXROWS | DBE_XMLGEN.SETMAXROWS | - |
| DBMS_XMLGEN.SETSKIPROWS | DBE_XMLGEN.SETSKIPROWS | - |
| DBMS_XMLGEN.RESTARTQUERY | DBE_XMLGEN.RESTARTQUERY | GaussDB：调用RESTARTQUERY方法后对更新的数据不可见。Oracle：调用RESTARTQUERY方法后对更新的数据可见。 |
| DBMS_XMLGEN.GETXMLTYPE | DBE_XMLGEN.GETXMLTYPE | - |
| DBMS_XMLGEN.GETXML | DBE_XMLGEN.GETXML | - |
| DBMS_XMLGEN.CLOSECONTEXT | DBE_XMLGEN.CLOSECONTEXT | - |
| Oracle数据库 | GaussDB数据库 | 差异 |
|---|---|---|
| DBMS_ALERT.REGISTER | DBE_ALERT.REGISTER | GaussDB: 警报名称不能以GS$开头。 |
| DBMS_ALERT.REMOVE | DBE_ALERT.REMOVE | GaussDB: 警报名称不能以GS$开头。 |
| DBMS_ALERT.SIGNAL | DBE_ALERT.SIGNAL | GaussDB: 警报名称不能以GS$开头。 |
| DBMS_ALERT.WAITONE | DBE_ALERT.WAITONE | GaussDB: 警报名称不能以GS$开头。 |
| DBMS_ALERT.WAITANY | DBE_ALERT.WAITANY | - |
| DBMS_ALERT.REMOVEALL | DBE_ALERT.REMOVEALL | - |
| DBMS_ALERT.SET_DEFAULTS | DBE_ALERT.SET_DEFAULTS | - |
| Oracle数据库 | GaussDB数据库 | 差异 |
|---|---|---|
| DBMS_OBFUSCATION_TOOLKIT.DESGETKEY | DBE_OBFUSCATION_TOOLKIT.DESGETKEY | - |
| DBMS_OBFUSCATION_TOOLKIT.DESENCRYPT | DBE_OBFUSCATION_TOOLKIT.DESENCRYPT | - |
| DBMS_OBFUSCATION_TOOLKIT.DESDECRYPT | DBE_OBFUSCATION_TOOLKIT.DESDECRYPT | - |
| DBMS_OBFUSCATION_TOOLKIT.DES3GETKEY | DBE_OBFUSCATION_TOOLKIT.DES3GETKEY | - |
| DBMS_OBFUSCATION_TOOLKIT.DES3ENCRYPT | DBE_OBFUSCATION_TOOLKIT.DES3ENCRYPT | - |
| DBMS_OBFUSCATION_TOOLKIT.DES3DECRYPT | DBE_OBFUSCATION_TOOLKIT.DES3DECRYPT | - |
| DBMS_OBFUSCATION_TOOLKIT.MD5 | DBE_OBFUSCATION_TOOLKIT.MD5 | - |

父主题：
Oracle兼容性说明
版权所有 © 华为技术有限公司
< 上一节



---

