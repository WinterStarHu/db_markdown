# 安全与ILM

安全、加密、信息生命周期管理（ILM）、压缩、热图、许可证。

---

## DBE_OBFUSCATION_TOOLKIT

#### 接口介绍
由于DES算法、DES3算法和MD5哈希算法存在算法安全风险，请谨慎使用DBE_OBFUSCATION_TOOLKIT进行加解密操作。
DBE_OBFUSCATION_TOOLKIT高级功能包是GaussDB提供的兼容性功能包，主要用于支持DES、DES3、MD5哈希算法的接口，以保持与原有业务逻辑的兼容。DBE_OBFUSCATION_TOOLKIT支持的接口请参见表1。

| 接口名称 | 描述 |
|---|---|
| DBE_OBFUSCATION_TOOLKIT.DESGETKEY | 生成DES算法的密钥。 |
| DBE_OBFUSCATION_TOOLKIT.DESENCRYPT | 使用DES算法对数据进行加密。 |
| DBE_OBFUSCATION_TOOLKIT.DESDECRYPT | 使用DES算法对数据进行解密。 |
| DBE_OBFUSCATION_TOOLKIT.DES3GETKEY | 生成DES3算法的密钥。 |
| DBE_OBFUSCATION_TOOLKIT.DES3ENCRYPT | 使用DES3算法对数据进行加密。 |
| DBE_OBFUSCATION_TOOLKIT.DES3DECRYPT | 使用DES3算法对数据进行解密。 |
| DBE_OBFUSCATION_TOOLKIT.MD5 | 计算数据的MD5哈希值。 |

```
--原型1：入参为VARCHAR2类型
DBE_OBFUSCATION_TOOLKIT.DESGETKEY(
seed_string IN VARCHAR2
) RETURN VARCHAR2;
--原型2：入参为RAW类型
DBE_OBFUSCATION_TOOLKIT.DESGETKEY(
seed IN RAW
) RETURN RAW;
```

| 参数 | 类型 | 是否可以为空 | 描述 |
|---|---|---|---|
| seed_string | VARCHAR2 | 否 | 用于生成密钥的种子值，其长度至少为80字节。 |
| seed | RAW | 否 |  |

```
-- 创建ORA兼容模式的数据库
gaussdb=# CREATE DATABASE ora_db dbcompatibility = 'ORA' encoding = 'utf8';
gaussdb=# \c ora_db
-- 生成随机密钥
ora_db=# SELECT rawtohex(dbe_raw.cast_from_varchar2_to_raw(dbe_obfuscation_toolkit.desgetkey(seed_string => '00000000000000000000000000000000000000000000000000000000000000000000000000000000')));
WARNING:  The DES algorithm is an insecure algorithm, please use it with caution.
CONTEXT:  referenced column: rawtohex
     rawtohex
------------------
 A7F0B24CF66DAECF
(1 row)
ora_db=# SELECT rawtohex(dbe_obfuscation_toolkit.desgetkey(seed => dbe_raw.cast_from_varchar2_to_raw('00000000000000000000000000000000000000000000000000000000000000000000000000000000')));
WARNING:  The DES algorithm is an insecure algorithm, please use it with caution.
CONTEXT:  referenced column: rawtohex
     rawtohex
------------------
 2A5984CA3AB67344
(1 row)
```
- DBE_OBFUSCATION_TOOLKIT.DESGETKEY功能：生成DES算法的密钥。 DBE_OBFUSCATION_TOOLKIT.DESGETKEY原型可以分为2种： 示例： DBE_OBFUSCATION_TOOLKIT.DESGETKEY生成的密钥为随机密钥。
```
--原型1：入参为VARCHAR2类型
DBE_OBFUSCATION_TOOLKIT.DESENCRYPT(
input_string IN VARCHAR2,
key_string   IN VARCHAR2
) RETURN VARCHAR2;
--原型2：入参为RAW类型
DBE_OBFUSCATION_TOOLKIT.DESENCRYPT(
input IN RAW,
key   IN RAW
) RETURN RAW;
```

| 参数 | 类型 | 是否可以为空 | 描述 |
|---|---|---|---|
| input_string | VARCHAR2 | 否 | 待加密的数据，其长度必须为8字节的倍数。 |
| input | RAW | 否 |  |
| key_string | VARCHAR2 | 否 | 加密密钥，其长度至少为8字节，超过8字节的数据不影响加密结果。 |
| key | RAW | 否 |  |

```
ora_db=# SELECT rawtohex(dbe_raw.cast_from_varchar2_to_raw(dbe_obfuscation_toolkit.desencrypt(input_string => '12345678', key_string => '12345678')));
WARNING:  The DES algorithm is an insecure algorithm, please use it with caution.
CONTEXT:  referenced column: rawtohex
     rawtohex
------------------
 96D0028878D58C89
(1 row)
ora_db=# SELECT rawtohex(dbe_obfuscation_toolkit.desencrypt(input => dbe_raw.cast_from_varchar2_to_raw('12345678'), key => dbe_raw.cast_from_varchar2_to_raw('12345678')));
WARNING:  The DES algorithm is an insecure algorithm, please use it with caution.
CONTEXT:  referenced column: rawtohex
     rawtohex
------------------
 96D0028878D58C89
(1 row)
```
- DBE_OBFUSCATION_TOOLKIT.DESENCRYPT功能：使用DES算法对数据进行加密。 DBE_OBFUSCATION_TOOLKIT.DESENCRYPT原型可以分为2种： 示例： 由于该函数执行过程需传入密钥，出于安全考虑，gsql工具不会将包含该函数名称的SQL记录至执行历史。因此，无法在gsql中通过上下翻页功能查找该函数的执行历史。
```
--原型1：入参为VARCHAR2类型
DBE_OBFUSCATION_TOOLKIT.DESDECRYPT(
input_string IN VARCHAR2,
key_string   IN VARCHAR2
) RETURN VARCHAR2;
--原型2：入参为RAW类型
DBE_OBFUSCATION_TOOLKIT.DESDECRYPT(
input IN RAW,
key   IN RAW
) RETURN RAW;
```

| 参数 | 类型 | 是否可以为空 | 描述 |
|---|---|---|---|
| input_string | VARCHAR2 | 否 | 待解密的数据，其长度必须为8字节的倍数。 |
| input | RAW | 否 |  |
| key_string | VARCHAR2 | 否 | 解密密钥，其长度至少为8字节，超过8字节的数据不影响解密结果。 |
| key | RAW | 否 |  |

```
ora_db=# SELECT rawtohex(dbe_raw.cast_from_varchar2_to_raw(dbe_obfuscation_toolkit.desdecrypt(input_string => '12345678', key_string => '12345678')));
WARNING:  The DES algorithm is an insecure algorithm, please use it with caution.
CONTEXT:  referenced column: rawtohex
     rawtohex
------------------
 F5E8E9EB81F28B73
(1 row)
ora_db=# SELECT rawtohex(dbe_obfuscation_toolkit.desdecrypt(input => dbe_raw.cast_from_varchar2_to_raw('12345678'), key => dbe_raw.cast_from_varchar2_to_raw('12345678')));
WARNING:  The DES algorithm is an insecure algorithm, please use it with caution.
CONTEXT:  referenced column: rawtohex
     rawtohex
------------------
 F5E8E9EB81F28B73
(1 row)
```
- DBE_OBFUSCATION_TOOLKIT.DESDECRYPT功能：使用DES算法对数据进行解密。 DBE_OBFUSCATION_TOOLKIT.DESDECRYPT原型可以分为2种： 示例： 由于该函数执行过程需传入密钥，出于安全考虑，gsql工具不会将包含该函数名称的SQL记录至执行历史。因此，无法在gsql中通过上下翻页功能查找该函数的执行历史。
```
--原型1：入参为VARCHAR2类型
DBE_OBFUSCATION_TOOLKIT.DES3GETKEY(
which       IN INTEGER DEFAULT 0,
seed_string IN VARCHAR2
) RETURN VARCHAR2;
--原型2：入参为RAW类型
DBE_OBFUSCATION_TOOLKIT.DES3GETKEY(
which IN INTEGER DEFAULT 0,
seed  IN RAW
) RETURN RAW;
```

| 参数 | 类型 | 是否可以为空 | 描述 |
|---|---|---|---|
| which | INTEGER | 否 | 密钥模式。 取值范围：0或1 0：返回16字节的密钥（即两个密钥）。1：返回24字节的密钥（即三个密钥）。 默认值：0 |
| seed_string | VARCHAR2 | 否 | 用于生成密钥的种子值，其长度至少为80字节。 |
| seed | RAW | 否 |  |

```
-- 生成随机密钥
ora_db=# SELECT rawtohex(dbe_raw.cast_from_varchar2_to_raw(dbe_obfuscation_toolkit.des3getkey(seed_string => '00000000000000000000000000000000000000000000000000000000000000000000000000000000')));
WARNING:  The DES3 algorithm is an insecure algorithm, please use it with caution.
CONTEXT:  referenced column: rawtohex
             rawtohex
----------------------------------
 9A64E470BC16D4969E782F3F5A8491A6
(1 row)
ora_db=# SELECT rawtohex(dbe_obfuscation_toolkit.des3getkey(which => 1, seed => dbe_raw.cast_from_varchar2_to_raw('00000000000000000000000000000000000000000000000000000000000000000000000000000000')));
WARNING:  The DES3 algorithm is an insecure algorithm, please use it with caution.
CONTEXT:  referenced column: rawtohex
                     rawtohex
--------------------------------------------------
 7497F5D61F23E751D3D337EE6B88B257350FF8B9732BC288
(1 row)
```
- DBE_OBFUSCATION_TOOLKIT.DES3GETKEY功能：生成DES3算法的密钥。 DBE_OBFUSCATION_TOOLKIT.DES3GETKEY原型可以分为2种： 示例： DBE_OBFUSCATION_TOOLKIT.DES3GETKEY生成的密钥为随机密钥。
```
--原型1：入参为VARCHAR2类型
DBE_OBFUSCATION_TOOLKIT.DES3ENCRYPT(
input_string IN VARCHAR2,
key_string   IN VARCHAR2,
which        IN INTEGER DEFAIULT 0,
iv_string    IN VARCHAR2 DEFAULT NULL
) RETURN VARCHAR2;
--原型2：入参为RAW类型
DBE_OBFUSCATION_TOOLKIT.DES3ENCRYPT(
input IN RAW,
key   IN RAW,
which IN INTEGER DEFAIULT 0,
iv    IN RAW DEFAULT NULL
) RETURN RAW;
```

| 参数 | 类型 | 是否可以为空 | 描述 |
|---|---|---|---|
| input_string | VARCHAR2 | 否 | 待加密的数据，其长度必须为8字节的倍数。 |
| input | RAW | 否 |  |
| key_string | VARCHAR2 | 否 | 加密密钥，其长度依赖which的取值。 当which取值为0时：加密密钥的长度至少为16字节，超过16字节的数据不影响加密结果。当which取值为1时：加密密钥的长度至少为24字节，超过24字节的数据不影响加密结果。 |
| key | RAW | 否 |  |
| which | INTEGER | 否 | 密钥模式。 取值范围：0或1 0：按照16字节的密钥模式（即两个密钥）进行加密。1：按照24字节的密钥模式（即三个密钥）进行加密。 默认值：0 |
| iv_string | VARCHAR2 | 是 | 初始化向量，当该参数取值不为NULL时，其长度必须为8字节的倍数，超过8字节的数据不影响加密结果。 默认值：NULL |
| iv | RAW | 是 |  |

```
ora_db=# SELECT rawtohex(dbe_raw.cast_from_varchar2_to_raw(dbe_obfuscation_toolkit.des3encrypt(input_string => '12345678', key_string => '1234567823456789', iv_string => '12345678')));
WARNING:  The DES3 algorithm is an insecure algorithm, please use it with caution.
CONTEXT:  referenced column: rawtohex
     rawtohex
------------------
 EFDD1DFBCEE3B0CA
(1 row)
ora_db=# SELECT rawtohex(dbe_obfuscation_toolkit.des3encrypt(input => dbe_raw.cast_from_varchar2_to_raw('12345678'), key => dbe_raw.cast_from_varchar2_to_raw('1234567812345678876543210'), which => 1));
WARNING:  The DES3 algorithm is an insecure algorithm, please use it with caution.
CONTEXT:  referenced column: rawtohex
     rawtohex
------------------
 1A1546D3DEAEB8BE
(1 row)
```
- DBE_OBFUSCATION_TOOLKIT.DES3ENCRYPT功能：使用DES3算法对数据进行加密。 DBE_OBFUSCATION_TOOLKIT.DES3ENCRYPT原型可以分为2种： 示例： 由于该函数执行过程需传入密钥，出于安全考虑，gsql工具不会将包含该函数名称的SQL记录至执行历史。因此，无法在gsql中通过上下翻页功能查找该函数的执行历史。
```
--原型1：入参为VARCHAR2类型
DBE_OBFUSCATION_TOOLKIT.DES3DECRYPT(
input_string IN VARCHAR2,
key_string   IN VARCHAR2,
which        IN INTEGER DEFAIULT 0,
iv_string    IN VARCHAR2 DEFAULT NULL
) RETURN VARCHAR2;
--原型2：入参为RAW类型
DBE_OBFUSCATION_TOOLKIT.DES3DECRYPT(
input IN RAW,
key   IN RAW,
which IN INTEGER DEFAIULT 0,
iv    IN RAW DEFAULT NULL
) RETURN RAW;
```

| 参数 | 类型 | 是否可以为空 | 描述 |
|---|---|---|---|
| input_string | VARCHAR2 | 否 | 待解密的数据，其长度必须为8字节的倍数。 |
| input | RAW | 否 |  |
| key_string | VARCHAR2 | 否 | 解密密钥，其长度依赖which的取值。 当which取值为0时：解密密钥的长度至少为16字节，超过16字节的数据不影响解密结果。当which取值为1时：解密密钥的长度至少为24字节，超过24字节的数据不影响解密结果。 |
| key | RAW | 否 |  |
| which | INTEGER | 否 | 密钥模式。 取值范围：0或1 0：按照16字节的密钥模式（即两个密钥）进行解密。1：按照24字节的密钥模式（即三个密钥）进行解密。 默认值：0 |
| iv_string | VARCHAR2 | 是 | 初始化向量，当该参数取值不为NULL时，其长度必须为8字节的倍数，超过8字节的数据不影响解密结果。 默认值：NULL |
| iv | RAW | 是 |  |

```
ora_db=# SELECT rawtohex(dbe_raw.cast_from_varchar2_to_raw(dbe_obfuscation_toolkit.des3decrypt(input_string => '12345678', key_string => '1234567823456789', iv_string => '12345678')));
WARNING:  The DES3 algorithm is an insecure algorithm, please use it with caution.
CONTEXT:  referenced column: rawtohex
     rawtohex
------------------
 8C2ED115CCA35582
(1 row)
ora_db=# SELECT rawtohex(dbe_obfuscation_toolkit.des3decrypt(input => dbe_raw.cast_from_varchar2_to_raw('12345678'), key => dbe_raw.cast_from_varchar2_to_raw('1234567812345678876543210'), which => 1, iv => dbe_raw.cast_from_varchar2_to_raw('12345678')));
WARNING:  The DES3 algorithm is an insecure algorithm, please use it with caution.
CONTEXT:  referenced column: rawtohex
     rawtohex
------------------
 A6FF1AA4A875B3E8
(1 row)
```
- DBE_OBFUSCATION_TOOLKIT.DES3DECRYPT功能：使用DES3算法对数据进行解密。 DBE_OBFUSCATION_TOOLKIT.DES3DECRYPT原型可以分为2种： 示例： 由于该函数执行过程需传入密钥，出于安全考虑，gsql工具不会将包含该函数名称的SQL记录至执行历史。因此，无法在gsql中通过上下翻页功能查找该函数的执行历史。
```
--原型1：入参为VARCHAR2类型
DBE_OBFUSCATION_TOOLKIT.MD5(
input_string IN VARCHAR2
) RETURN VARCHAR2;
--原型2：入参为RAW类型
DBE_OBFUSCATION_TOOLKIT.MD5(
input IN RAW
) RETURN RAW;
```

| 参数 | 类型 | 是否可以为空 | 描述 |
|---|---|---|---|
| input_string | VARCHAR2 | 否 | 待进行哈希操作的数据。 |
| input | RAW | 否 |  |

```
ora_db=# SELECT rawtohex(dbe_raw.cast_from_varchar2_to_raw(dbe_obfuscation_toolkit.md5(input_string => '1234567890')));
WARNING:  The MD5 algorithm is an insecure algorithm, please use it with caution.
CONTEXT:  referenced column: rawtohex
             rawtohex
----------------------------------
 E807F1FCF82D132F9BB018CA6738A19F
(1 row)
ora_db=# SELECT rawtohex(dbe_obfuscation_toolkit.md5(dbe_raw.cast_from_varchar2_to_raw('1234567890')));
WARNING:  The MD5 algorithm is an insecure algorithm, please use it with caution.
CONTEXT:  referenced column: rawtohex
             rawtohex
----------------------------------
 E807F1FCF82D132F9BB018CA6738A19F
(1 row)
-- 删除ora_db数据库
ora_db=# \c postgres
gaussdb=# DROP DATABASE ora_db;
```
- DBE_OBFUSCATION_TOOLKIT.MD5功能：计算数据的MD5哈希值。 DBE_OBFUSCATION_TOOLKIT.MD5原型可以分为2种： 示例：
父主题：
二次封装接口
版权所有 © 华为技术有限公司
< 上一节
下一节 >



---


---

## DBE_ILM

#### 接口介绍
服务于ILM策略实施，实现ILM策略的评估以及压缩Job的停用接口。DBE_ILM支持的接口请参见表1。

| 接口名称 | 描述 |
|---|---|
| DBE_ILM.EXECUTE_ILM | 根据参数执行对指定的数据和ILM策略进行评估，评估通过则会生成对应的压缩Job。 |
| DBE_ILM.STOP_ILM | 根据参数停止正在执行的压缩Job。 |

```
DBE_ILM.EXECUTE_ILM(
OWNER          IN VARCHAR2,
OBJECT_NAME    IN VARCHAR2,
TASK_ID        OUT NUMBER,
SUBOBJECT_NAME IN VARCHAR2 DEFAULT NULL,
POLICY_NAME    IN VARCHAR2 DEFAULT 'ALL POLICIES',
EXECUTION_MODE IN NUMBER DEFAULT 2
TURBO_FORCE    IN BOOLEAN DEFAULT FALSE,
TURBO_BLKSTART IN INTEGER DEFAULT -1,
TURBO_BLKEND   IN INTEGER DEFAULT -1)
```

| 参数 | 描述 |
|---|---|
| OWNER | 对象所属Schema。 |
| OBJECT_NAME | 对象名称。 |
| TASK_ID | 输出生成ADO task的描述符id。 |
| SUBOBJECT_NAME | 数据子对象名称。 |
| POLICY_NAME | 策略名称，通过查询GS_ADM_ILMOBJECTS视图可知，默认DBE_ILM.ILM_ALL_POLICIES代表该对象上所有策略。DBE_ILM.ILM_ALL_POLICIES默认值为'ALL POLICIES'，不支持小写。 |
| EXECUTION_MODE | 执行模式，暂不涉及在线模式（ILM_EXECUTION_ONLINE）或离线模式（ILM_EXECUTION_OFFLINE）。 |
| TURBO_FORCE | 是否开启忽略冷热管理的强制压缩，仅对跨页透明压缩生效。TRUE表示开启，FALSE表示关闭。 |
| TURBO_BLKSTART | 强制压缩开始的block number，仅对跨页透明压缩生效。 |
| TURBO_BLKEND | 强制压缩结束的block number，仅对跨页透明压缩生效。 |

  - DBE_ILM.EXECUTE_ILM依据当前数据库名及表名，生成类似“数据库名_表名_分区名_数字”格式的JOBNAME命名规则，然后通过DBE_SCHEDULER.Create_job创建对应名称的任务；当表名包含特殊字符时，调用该接口将报错：Invalid program name。
  - 当DBE_ILM.EXECUTE_ILM与DBE_ILM.STOP_ILM并发时，有较低概率会导致任务FAILED，gs_adm_ilmresults视图中comments字段内容显示“tuple concurrently updated”。
  - 业务进行压缩操作时（无论是自动调度还是手动调度），应尽可能避免对压缩中的相关表进行DDL操作。特别是在一段长事务中执行DDL，可能会引发死锁或锁等待问题。若确有必要进行DDL操作，建议使用DBE_ILM.STOP_ILM接口将相关表的压缩任务停止，确认停止后再进行DDL操作。
  - 执行DBE_ILM.EXECUTE_ILM需要拥有PUBLIC权限及CREATE JOB权限，可通过dbe_scheduler.grant_user_authorization进行赋权，非SYSADMIN用户执行需要表的owner权限。
  - 若要压缩二级分区，SUBOBJECT_NAME字段不可传入其一级分区名称，需传入具体的二级分区名称（或者传入NULL，即压缩所有子二级分区）。
  - 事务内调用此接口，需要等待事务结束、或者COMMIT后，压缩动作才能生效。多个不同事务内调用DBE_ILM.EXECUTE_ILM接口，先执行的事务若一直不提交，后执行的事务可能存在锁超时风险。
    - 当指定为FALSE时：由于gs_adm_ilmresults视图中的statistics字段统计内容本身对跨页透明压缩无意义，因此跨页透明压缩对象在该字段中显示为默认值。
    - 当指定为TRUE时：当前压缩任务独立于ILM原有的任务划分机制运行，不对该对象进行statistics统计，因此gs_adm_ilmresults视图中的statistics字段显示为空。
```
DBE_ILM.STOP_ILM(
TASK_ID             IN NUMBER DEFAULT -1,
P_DROP_RUNNING_JOBS IN BOOLEAN DEFAULT FALSE,
P_JOBNAME           IN VARCHAR2 DEFAULT NULL)
```

| 参数 | 描述 |
|---|---|
| TASK_ID | 指定待停止ADO task的描述符id。 |
| P_DROP_RUNNING_JOBS | 是否停止正在执行中的任务，true为强制停止，false为不停止正在执行的任务。 |
| P_JOBNAME | 标识待停止的特定JobName，通过GS_MY_ILMEVALUATIONDETAILS视图可以查询。 |

- DBE_ILM.STOP_ILM根据参数停止正在执行的ILM策略。 DBE_ILM.STOP_ILM原型为： 当并发量较大时，执行DBE_ILM.STOP_ILM可能会提示资源繁忙，稍后重试即可。提示内容为“Resources are busy, please try again later”。
#### 示例
```
gaussdb=# ALTER DATABASE set ilm = on;
gaussdb=# CREATE Schema ILM_DATA;
gaussdb=# SET current_schema=ILM_DATA;
BEGIN
    DBE_ILM_ADMIN.DISABLE_ILM();
    DBE_ILM_ADMIN.CUSTOMIZE_ILM(1, 15);
    DBE_ILM_ADMIN.CUSTOMIZE_ILM(2, 30);
    DBE_ILM_ADMIN.CUSTOMIZE_ILM(11, 1);
    DBE_ILM_ADMIN.CUSTOMIZE_ILM(12, 10);
    DBE_ILM_ADMIN.CUSTOMIZE_ILM(13, 1024);
    DBE_ILM_ADMIN.CUSTOMIZE_ILM(14, 240);
    DBE_ILM_ADMIN.ENABLE_ILM();
END;
/
-- 1.1.2 prepare test data
gaussdb=# CREATE SEQUENCE ILM_DATA.ORDER_TABLE_SE_ORDER_ID MINVALUE 1;
gaussdb=# CREATE OR REPLACE PROCEDURE ILM_DATA.ORDER_TABLE_CREATE_DATA(NUM INTEGER) IS
BEGIN
    FOR X IN 1..NUM
        LOOP
            INSERT INTO ORDER_TABLE VALUES(ORDER_TABLE_SE_ORDER_ID.nextval, '零食大礼包A', NOW());
        END LOOP;
    COMMIT;
END;
/
-- 1.1.3 normal procedure
-- 1.1.3.1 evaluate successed - all policy
gaussdb=# CREATE TABLE ILM_DATA.ORDER_TABLE (ORDER_ID INT, GOODS_NAME TEXT, CREATE_TIME TIMESTAMP)
    WITH (STORAGE_TYPE=ASTORE) ILM ADD POLICY ROW STORE COMPRESS ADVANCED ROW AFTER 1 DAYS OF NO MODIFICATION;
BEGIN
    ILM_DATA.ORDER_TABLE_CREATE_DATA(5);
    PERFORM PG_SLEEP(2);
END;
/
gaussdb=# SELECT ORDER_ID, DBE_COMPRESSION.GET_COMPRESSION_TYPE('ilm_data', 'order_table', ctid::text, NULL) FROM ILM_DATA.ORDER_TABLE;
 order_id | get_compression_type
----------+----------------------
        1 |                    1
        2 |                    1
        3 |                    1
        4 |                    1
        5 |                    1
(5 rows)
gaussdb=# SELECT ORDER_ID, DBE_HEAT_MAP.ROW_HEAT_MAP('ilm_data','order_table', NULL, ctid::text) FROM ILM_DATA.ORDER_TABLE;
 order_id |                 row_heat_map
----------+-----------------------------------------------
        1 | (ilm_data,order_table,,,16799,16799,"(0,1)",)
        2 | (ilm_data,order_table,,,16799,16799,"(0,2)",)
        3 | (ilm_data,order_table,,,16799,16799,"(0,3)",)
        4 | (ilm_data,order_table,,,16799,16799,"(0,4)",)
        5 | (ilm_data,order_table,,,16799,16799,"(0,5)",)
(5 rows)
DECLARE
    v_taskid number;
BEGIN
    DBE_ILM.EXECUTE_ILM(OWNER        => 'ilm_data',
                        OBJECT_NAME    => 'order_table',
                        TASK_ID        => v_taskid,
                        SUBOBJECT_NAME => NULL,
                        POLICY_NAME    => 'ALL POLICIES',
                        EXECUTION_MODE => 2);
    RAISE INFO 'Task ID is:%', v_taskid;
END;
/
INFO:  Task ID is:1
gaussdb=# SELECT ORDER_ID, DBE_COMPRESSION.GET_COMPRESSION_TYPE('ilm_data', 'order_table', ctid::text, NULL) FROM ILM_DATA.ORDER_TABLE;
 order_id | get_compression_type
----------+----------------------
        1 |                    1
        2 |                    1
        3 |                    1
        4 |                    1
        5 |                    1
(5 rows)
gaussdb=# CALL DBE_ILM.STOP_ILM(-1, true, NULL);
 stop_ilm
----------
(1 row)
```
父主题：
二次封装接口
版权所有 © 华为技术有限公司
< 上一节
下一节 >



---


---

## DBE_ILM_ADMIN

#### 接口介绍
服务于ILM策略实施，实现ADO的后台调度以及各个限流参数的控制。DBE_ILM_ADMIN支持的接口请参见表1。

| 接口名称 | 描述 |
|---|---|
| DBE_ILM_ADMIN.CUSTOMIZE_ILM | 根据输入参数定制ILM策略属性。 |
| DBE_ILM_ADMIN.DISABLE_ILM | 关闭后台调度。 |
| DBE_ILM_ADMIN.ENABLE_ILM | 开启后台调度。 |
| DBE_ILM_ADMIN.CREATE_ILM_DB_POLICY | 创建库级压缩策略。 |
| DBE_ILM_ADMIN.DELETE_ILM_DB_POLICY | 删除库级压缩策略。 |

当并发量较大时，执行DBE_ILM_ADMIN.DISABLE_ILM或DBE_ILM_ADMIN.ENABLE_ILM可能会提示资源繁忙，稍后重试即可。提示内容为“Resources are busy, please try again later.”。
```
DBE_ILM_ADMIN.CUSTOMIZE_ILM(
PARAM    IN    NUMBER,
VAL      IN    NUMBER);
```

| 参数 | 描述 |
|---|---|
| PARAM | 参数序号。 |
| VAL | 参数取值。 |
| 参数序号 | 参数值 | 描述 |
|---|---|---|
| 1 | EXECUTION_INTERVAL | ADO Task的执行频率，单位分钟，默认值15。取值范围为大于等于1小于等于2147483647的整数或浮点数，作用时向下取整。 |
| 2 | RETENTION_TIME | ADO相关历史的保留时长，单位天，默认值30。取值范围为大于等于1小于等于2147483647的整数或浮点数，作用时向下取整。 |
| 7 | ENABLE | 后台调度的状态。该参数不支持使用DBE_ILM_ADMIN.CUSTOMIZE_ILM修改，应使用DBE_ILM_ADMIN.DISABLE_ILM和DBE_ILM_ADMIN.ENABLE_ILM修改。 |
| 11 | POLICY_TIME | 控制ADO的条件单位是天或者秒，秒仅用来做测试用。取值为： 0：ILM_POLICY_IN_DAYS（默认值）。1：ILM_POLICY_IN_SECONDS。 |
| 12 | ABS_JOBLIMIT | 控制一次ADO Task最多生成ADO Job的数量。取值范围为大于等于0小于等于2147483647的整数或浮点数，作用时向下取整。 |
| 13 | JOB_SIZELIMIT | 控制单个ADO Job可以处理的最大字节数，单位兆。取值范围为大于等于0小于等于2147483647的整数或浮点数，作用时向下取整。当JOB_SIZELIMIT为0时，手动执行压缩任务会报warning且不做压缩处理，自动调度后台任务也不做压缩处理。 |
| 14 | WIND_DURATION | 维护窗口持续时长，单位分钟，默认值240（4小时）。取值范围为大于等于0小于1440（24小时）的整数。 |
| 15 | BLOCK_LIMITS | 控制实例级的行存压缩速率上限，默认值40，单位是block/ms（表示每毫秒最多压缩多少个block）。取值范围是0到10000（0表示不限制）。跨页透明压缩不支持此参数。 |
| 16 | ENABLE_META_COMPRESSION | 是否开启header压缩，默认值0。取值范围为0（关闭）和1（开启）。跨页透明压缩不支持此参数。 说明： 设置此参数为1时，对于单行数据较短的表，压缩率会有一定提升，但是访问压缩行的性能会有较大幅度的下降。若数据库多是单行数据较长的表，不建议开启此参数。 |
| 17 | SAMPLE_MIN | 常量编码和等值编码采样步长最小值，默认值10。取值范围[1, 100]，支持小数输入，小数会自动向下取整。跨页透明压缩不支持此参数。 |
| 18 | SAMPLE_MAX | 常量编码和等值编码采样步长最大值，默认值10。取值范围[1, 100]，支持小数输入，小数会自动向下取整。跨页透明压缩不支持此参数。 |
| 19 | CONST_PRIO | 常量编码优先级，默认值40。取值范围[0, 100]，100表示关闭常量编码，支持小数输入，小数会自动向下取整。跨页透明压缩不支持此参数。 |
| 20 | CONST_THRESHOLD | 常量编码阈值，默认值90。取值范围[1, 100]，表示一列常量值的占比超过该阈值时进行常量编码，支持小数输入，小数会自动向下取整。跨页透明压缩不支持此参数。 |
| 21 | EQVALUE_PRIO | 等值编码优先级，默认值60。取值范围[0, 100]，100表示关闭等值编码，支持小数输入，小数会自动向下取整。跨页透明压缩不支持此参数。 |
| 22 | EQVALUE_THRESHOLD | 等值编码阈值，默认值80。取值范围[1, 100]，表示两列数据的等值比例超过该阈值时进行等值编码，支持小数输入，小数会自动向下取整。跨页透明压缩不支持此参数。 |
| 23 | ENABLE_DELTA_ENCODE_SWITCH | 差值编码开关，默认值1。取值范围[0, 1]，0表示关闭，1表示开启，支持小数输入，小数会自动向下取整。跨页透明压缩不支持此参数。 |
| 24 | LZ4_COMPRESSION_LEVEL | lz4压缩等级，默认值0。取值范围[0, 16]，支持小数输入，小数会自动向下取整。跨页透明压缩不支持此参数。 |
| 25 | ENABLE_LZ4_PARTIAL_DECOMPRESSION | 部分解压开关，默认值1。取值范围[0, 1]，0表示关闭，1表示开启，支持小数输入，小数会自动向下取整。跨页透明压缩不支持此参数。 |
| 26 | INDEXJOB_SIZELIMIT | 控制索引压缩时单个ADO Job可以处理的最大字节数，单位兆，默认为1024。取值范围为大于等于0小于等于2147483647的整数或浮点数，作用时向下取整。当INDEXJOB_SIZELIMIT为0时，手动执行压缩任务会报warning且不做压缩处理，自动调度后台任务也不做压缩处理。 |
| 27 | ENABLE_INDEX_COMPRESS | 索引压缩使能开关，0表示关闭，1表示打开，默认为0。 |

```
gaussdb=# CALL DBE_ILM_ADMIN.CUSTOMIZE_ILM(1, 15);
 customize_ilm
---------------
(1 row)
gaussdb=# SELECT * FROM gs_adm_ilmparameters;
               name               | value
----------------------------------+-------
 EXECUTION_INTERVAL               |    15
 RETENTION_TIME                   |    30
 ENABLED                          |     1
 POLICY_TIME                      |     0
 ABS_JOBLIMIT                     |    10
 JOB_SIZELIMIT                    |  1024
 WIND_DURATION                    |   240
 BLOCK_LIMITS                     |    40
 ENABLE_META_COMPRESSION          |     0
 SAMPLE_MIN                       |    10
 SAMPLE_MAX                       |    10
 CONST_PRIO                       |    40
 CONST_THRESHOLD                  |    90
 EQVALUE_PRIO                     |    60
 EQVALUE_THRESHOLD                |    80
 ENABLE_DELTA_ENCODE_SWITCH       |     1
 LZ4_COMPRESSION_LEVEL            |     0
 ENABLE_LZ4_PARTIAL_DECOMPRESSION |     1
 INDEXJOB_SIZELIMIT               |  1024
 ENABLE_INDEX_COMPRESS            |     0
(20 rows)
```
- DBE_ILM_ADMIN.CUSTOMIZE_ILM根据输入参数定制ILM策略属性。 DBE_ILM_ADMIN.CUSTOMIZE_ILM原型为： 由于兼容性影响，在MYSQL或M-Compatibility兼容模式下，若调用DBE_ILM_ADMIN.CUSTOMIZE_ILM()时传入的VAL值为非数字的字符，例如DBE_ILM_ADMIN.CUSTOMIZE_ILM(13, '*')，会默认将传入的VAL值赋值为0。 示例：
```
CALL DBE_ILM_ADMIN.DISABLE_ILM();
```
- DBE_ILM_ADMIN.DISABLE_ILM关闭后台调度。 DBE_ILM_ADMIN.DISABLE_ILM原型为：
```
CALL DBE_ILM_ADMIN.ENABLE_ILM();
```
- DBE_ILM_ADMIN.ENABLE_ILM开启后台调度。 DBE_ILM_ADMIN.ENABLE_ILM原型为： 后台调度生效需要先在数据库运维平台将GUC参数enable_ilm设置为on。
  - 自动覆盖存量表：为当前数据库中所有未绑定压缩策略的用户表附加此策略。
  - 新表默认继承：后续新建表若未显式声明压缩策略，将自动继承该库级策略定义。
DBE_ILM_ADMIN.CREATE_ILM_DB_POLICY原型为：
```
DBE_ILM_ADMIN.CREATE_ILM_DB_POLICY(
DAYS IN INT,
COMPRESSION_LEVEL IN TEXT DEFAULT 'MEDIUM');
```

| 参数 | 描述 |
|---|---|
| DAYS | 压缩策略天数。 |
| COMPRESSION_LEVEL | 压缩策略级别。仅支持'HIGH' 和 'MEDIUM'，默认值为 'MEDIUM'。 |

- DBE_ILM_ADMIN.DELETE_ILM_DB_POLICY删除库级压缩策略及所有表上继承于库级压缩策略的压缩策略。
 - 库级压缩策略仅支持高级压缩。
- 库级策略不支持表达式功能。
- 在使用gs_dump导出库级策略定义时，需满足以下条件方可生效：必须执行全库导出操作且用户具备系统管理员权限。若上述条件未同时满足，则相关策略将以表、分区或子分区级别的独立策略形式导出，而非作为库级策略处理。
- 多个不同事务内若调用DBE_ILM_ADMIN.CREATE_ILM_DB_POLICY、DBE_ILM_ADMIN.DELETE_ILM_DB_POLICY、DBE_ILM.EXECUTE_ILM等接口并发执行，先执行的事务若一直不提交，后执行的事务可能存在锁超时风险。
库级策略示例：
```
gaussdb=# CALL DBE_ILM_ADMIN.CREATE_ILM_DB_POLICY(10);
 create_ilm_db_policy
----------------------
(1 row)
```
- 创建一个策略时间为10天压缩策略:
```
gaussdb=# CALL DBE_ILM_ADMIN.DELETE_ILM_DB_POLICY();
 delete_ilm_db_policy
----------------------
(1 row)
```
- 删除库级策略
```
gaussdb=# CALL DBE_ILM_ADMIN.CREATE_ILM_DB_POLICY(10, 'high');
 create_ilm_db_policy
----------------------
(1 row)
```
- 创建一个策略时间为10天的high级别压缩策略:
父主题：
二次封装接口
版权所有 © 华为技术有限公司
< 上一节
下一节 >



---


---

## DBE_COMPRESSION

#### 接口介绍
根据输入的参数，评估指定数据对象的采样压缩率或者获取指定行数据的压缩类型。DBE_COMPRESSION支持的接口请参见表1。

| 接口名称 | 描述 |
|---|---|
| DBE_COMPRESSION.GET_COMPRESSION_RATIO | 根据输入参数评估指定数据对象的采样压缩率。 |
| DBE_COMPRESSION.GET_COMPRESSION_TYPE | 根据输入参数获取指定行数据的压缩类型。 |
| DBE_COMPRESSION.GET_ACTUAL_COMPRESSION_RATIO | 根据输入参数评估指定数据对象的真实压缩率。 |
| DBE_COMPRESSION.GET_HOLE_RATIO | 根据输入参数评估指定跨页透明压缩数据对象的采样空洞率。 |
| DBE_COMPRESSION.TURBO_COMPRESS_BUFFER_STATS | 输出turbo_compress_shared_buffers的使用情况。 |
| DBE_COMPRESSION.GET_INDEX_COMPRESSION_TYPE | 根据输入参数获取指定索引页的压缩类型。 |

GET_COMPRESSION_TYPE接口只支持分布式数据库中数据节点（DN），其他节点暂不支持。
```
DBE_COMPRESSION.GET_COMPRESSION_RATIO(
SCRATCHTBSNAME IN VARCHAR2,
OWNNAME        IN VARCHAR2,
OBJNAME        IN VARCHAR2,
SUBOBJNAME     IN VARCHAR2,
COMPTYPE       IN NUMBER,
BLKCNT_CMP     OUT INTEGER,
BLKCNT_UNCMP   OUT INTEGER,
ROW_CMP        OUT INTEGER,
ROW_UNCMP      OUT INTEGER,
CMP_RATIO      OUT NUMBER,
COMPTYPE_STR   OUT VARCHAR2,
SAMPLE_RATIO   IN NUMBER DEFAULT 20,
OBJTYPE        IN INTEGER DEFAULT 1);
```
  - 对于跨页透明压缩表，一级分区表必须传入一级分区名称，二级分区表必须传入二级分区名称，否则会报错提示“no data found.”。对于高级压缩表，分区表必须传入分区名称（二级分区表也可传入一级分区名称），否则会报错提示“no data found.”。
  - 不支持在高级压缩表上评估跨页透明压缩的压缩率，直接使用会报错提示“The ilm turbo policy is not supported here.”。

| 参数 | 描述 |
|---|---|
| SCRATCHTBSNAME | 数据对象所属表空间。 |
| OWNNAME | 数据对象所有者（所属模式）。 |
| OBJNAME | 数据对象名称。 |
| SUBOBJNAME | 数据子对象名称。 |
| COMPTYPE | 压缩类型，支持：1：未压缩。2：高级压缩。3：跨页透明压缩low。4：跨页透明压缩medium。5：跨页透明压缩high。6：高级压缩high。 |
| BLKCNT_CMP | 样本被压缩后占用的块数。 |
| BLKCNT_UNCMP | 样本未压缩占用的块数。 |
| ROW_CMP | 样本被压缩后单个块内可容纳的行数，跨页透明压缩显示为0。 |
| ROW_UNCMP | 样本未被压缩时单个数据块可容纳的行数，跨页透明压缩显示为0。 |
| CMP_RATIO | 压缩比，blkcnt_uncmp除以blkcnt_cmp。 |
| COMPTYPE_STR | 描述压缩类型的字符串。 |
| SAMPLE_RATIO | 采样比例，输入为0-100的整数或浮点数，对应为百分之N的采样比例。默认为20，即对20%的行数进行采样。 |
| OBJTYPE | 对象类型，支持：1：表对象。 |

```
DBE_COMPRESSION.GET_COMPRESSION_TYPE(
OWNNAME    IN VARCHAR2,
TABNAME    IN VARCHAR2,
CTID       IN TEXT,
SUBOBJNAME IN VARCHAR2 DEFAULT NULL,
BUCKETID   IN pg_catalog.int2 DEFAULT NULL))
```

| 参数 | 描述 |
|---|---|
| OWNNAME | 数据对象所有者（所属模式）。 |
| TABNAME | 数据对象名称。 |
| CTID | 目标行ctid。 |
| SUBOBJNAME | 数据子对象名称。 |
| BUCKETID | 目标行tablebucketid。 |

- DBE_COMPRESSION.GET_COMPRESSION_TYPE根据输入参数获取指定行数据的压缩状态（返回1表示未压缩，2表示压缩），该接口属于运维类接口，不做可见性判断，即传入的ctid为已删除的行时，该接口依然会返回当前行在页面上最新的状态。跨页透明压缩不支持此高级包，默认返回1，无实际意义。 DBE_COMPRESSION.GET_COMPRESSION_TYPE原型为：
```
DBE_COMPRESSION.GET_ACTUAL_COMPRESSION_RATIO(
OWNER_NAME       IN VARCHAR2,
OBJNAME          IN VARCHAR2,
FILEPATH         OUT VARCHAR2,
IS_COMPRESS      OUT BOOL,
FILE_COUNT       OUT INTEGER,
LOGIC_SIZE       OUT BIGINT,
PHYSIC_SIZE      OUT BIGINT,
COMPRESS_RATIO   OUT VARCHAR2);
```

| 参数 | 描述 |
|---|---|
| OWNER_NAME | 数据对象所有者（所属模式）。 |
| OBJNAME | 数据对象名称。 |
| FILEPATH | 数据对象路径。 |
| IS_COMPRESS | 压缩类型。 |
| FILE_COUNT | 文件个数，包含数据文件和cmap文件。 |
| LOGIC_SIZE | 逻辑大小。 |
| PHYSIC_SIZE | 物理大小。 |
| COMPRESS_RATIO | 压缩比。 小表场景下，压缩比可能出现小于1的现象，属于正常现象。 |

```
gaussdb=# CREATE TABLE table_test(a int) ILM ADD POLICY ROW STORE COMPRESS TURBO HIGH UNIT AFTER 1 days OF NO MODIFICATION;
gaussdb=# INSERT INTO table_test VALUES(1);
gaussdb=# CALL DBE_COMPRESSION.GET_ACTUAL_COMPRESSION_RATIO('public', 'table_test', NULL,NULL,NULL,NULL,NULL,NULL);
```
- DBE_COMPRESSION.GET_ACTUAL_COMPRESSION_RATIO根据输入参数评估指定数据对象的真实压缩率，仅支持跨页透明压缩表。 DBE_COMPRESSION.GET_ACTUAL_COMPRESSION_RATIO原型为： 小表场景下，压缩比可能出现小于1的现象，属于正常现象。 示例：建表table_test，插入一条数据，使用高级包进行查询，压缩比显示小于1。
```
DBE_COMPRESSION.GET_HOLE_RATIO(
OWNER_NAME       IN VARCHAR2,
OBJNAME          IN VARCHAR2,
FILE_COUNT       OUT INTEGER,
PHYSIC_SIZE      OUT BIGINT,
HOLE_SIZE        OUT BIGINT,
HOLE_RATIO       OUT VARCHAR2,
SAMPLE_RATIO     IN NUMBER DEFAULT 20);
```

| 参数 | 描述 |
|---|---|
| OWNER_NAME | 数据对象所有者（所属模式）。 |
| OBJNAME | 数据对象名称。 |
| FILE_COUNT | 数据对象的文件个数，只包含数据文件 |
| PHYSIC_SIZE | 物理大小。 |
| HOLE_SIZE | 空洞大小 |
| HOLE_RATIO | 空洞率 |
| SAMPLE_RATIO | 采样率。 |

- DBE_COMPRESSION.GET_HOLE_RATIO根据输入参数评估指定跨页透明压缩数据对象的采样空洞率，仅支持跨页透明压缩表。 DBE_COMPRESSION.GET_HOLE_RATIO原型为：
```
DBE_COMPRESSION.TURBO_COMPRESS_BUFFER_STATS(
CAPACITY        OUT BIGINT,
MAIN_LEN        OUT BIGINT,
FREE_LEN        OUT BIGINT,
BUFFER_ACCESS   OUT BIGINT,
BUFFER_NOREADS  OUT BIGINT,
DISK_READS      OUT BIGINT,
RECYCLE_TIMES   OUT BIGINT,
RECYCLE_STEP    OUT BIGINT,
RECYCLE_WAITS   OUT BIGINT,
HIT_RATIO       OUT VARCHAR2);
```

| 参数 | 描述 |
|---|---|
| CAPACITY | turbo_compress_shared_buffers的容量。 |
| MAIN_LEN | lrulist中main_list的长度。 |
| FREE_LEN | lrulist中free_list的长度。 |
| BUFFER_ACCESS | 逻辑读的次数。 |
| BUFFER_NOREADS | 新扩展出来的block个数。 |
| DISK_READS | 物理读的次数。 |
| RECYCLE_TIMES | 回收次数。 |
| RECYCLE_STEP | 回收步长。 |
| RECYCLE_WAITS | alloc buf ctrl时的等待次数。 |
| HIT_RATIO | 在内存中的命中率。 |

- DBE_COMPRESSION.TURBO_COMPRESS_BUFFER_STATS输出turbo_compress_shared_buffers的使用情况。 DBE_COMPRESSION.TURBO_COMPRESS_BUFFER_STATS原型为：
```
DBE_COMPRESSION.GET_INDEX_COMPRESSION_TYPE(
IDXOID          IN OID,
IDXTYPE         IN TEXT,
BUCKET_ID       IN INT2 DEFAULT NULL,
BLOCK_ID        IN INT8);
```

| 参数 | 描述 |
|---|---|
| IDXOID | 索引oid。 |
| IDXTYPE | 索引类型，支持普通索引（'i'）、全局索引（'I'）、分区索引（'x'）。 |
| BUCKET_ID | 如果索引的bucket存储，传入对应的bucket id，默认为NULL。 |
| BLOCK_ID | 待查询的索引block id，如果输入是小数，会四舍五入取整。 |

- DBE_COMPRESSION.GET_INDEX_COMPRESSION_TYPE查询索引页面是否已经被压缩。此高级包仅能查询到高级压缩的状态，查询不到跨页透明压缩的状态。 DBE_COMPRESSION.GET_INDEX_COMPRESSION_TYPE原型为：
#### 示例
```
gaussdb=# CREATE DATABASE ilmtabledb WITH dbcompatibility = 'ORA';
gaussdb=# \c ilmtabledb
gaussdb=# ALTER DATABASE set ilm = on;
gaussdb=# CREATE USER user1 IDENTIFIED BY '********';
gaussdb=# SET ROLE user1 PASSWORD '********';
gaussdb=# CREATE TABLE TEST_DATA (ORDER_ID INT, GOODS_NAME TEXT, CREATE_TIME TIMESTAMP)
  with (storage_type=astore)
  ILM ADD POLICY ROW STORE COMPRESS ADVANCED ROW AFTER 1 DAYS OF NO MODIFICATION;
NOTICE:  The 'DISTRIBUTE BY' clause is not specified. Using 'order_id' as the distribution column by default.
HINT:  Please use 'DISTRIBUTE BY' clause to specify suitable data distribution column.
gaussdb=# INSERT INTO TEST_DATA VALUES (1, '零食大礼包A', NOW());
gaussdb=# DECLARE
o_blkcnt_cmp      integer;
o_blkcnt_uncmp    integer;
o_row_cmp         integer;
o_row_uncmp       integer;
o_cmp_ratio       number;
o_comptype_str    varchar2;
begin
dbe_compression.get_compression_ratio(
    SCRATCHTBSNAME  =>  NULL,
    OWNNAME         =>  'user1',
    OBJNAME         =>  'test_data',
    SUBOBJNAME      =>  NULL,
    COMPTYPE        =>  2,
    BLKCNT_CMP      =>  o_blkcnt_cmp,
    BLKCNT_UNCMP    =>  o_blkcnt_uncmp,
    ROW_CMP         =>  o_row_cmp,
    ROW_UNCMP       =>  o_row_uncmp,
    CMP_RATIO       =>  o_cmp_ratio,
    COMPTYPE_STR    =>  o_comptype_str,
    SAMPLE_RATIO    =>  100,
    OBJTYPE         =>  1);
RAISE INFO 'Number of blocks used by the compressed sample of the object     : %', o_blkcnt_cmp;
RAISE INFO 'Number of blocks used by the uncompressed sample of the object     : %', o_blkcnt_uncmp;
RAISE INFO 'Number of rows in a block in compressed sample of the object     : %', o_row_cmp;
RAISE INFO 'Number of rows in a block in uncompressed sample of the object     : %', o_row_uncmp;
RAISE INFO 'Estimated Compression Ratio of Sample                            : %', o_cmp_ratio;
RAISE INFO 'Compression Type                               : %', o_comptype_str;
end;
/
INFO:  Number of blocks used by the compressed sample of the object     : 1
INFO:  Number of blocks used by the uncompressed sample of the object     : 1
INFO:  Number of rows in a block in compressed sample of the object     : 1
INFO:  Number of rows in a block in uncompressed sample of the object     : 1
INFO:  Estimated Compression Ratio of Sample                            : 1.0
INFO:  Compression Type                               : Compress Advanced
gaussdb=# CREATE DATABASE ilmtabledb WITH dbcompatibility = 'ORA';
gaussdb=# \c ilmtabledb
gaussdb=# ALTER DATABASE set ilm = on;
gaussdb=# CREATE USER user1 IDENTIFIED BY '********';
gaussdb=# SET ROLE user1 PASSWORD '********';
gaussdb=# CREATE TABLE TEST_DATA (ORDER_ID INT, GOODS_NAME TEXT, CREATE_TIME TIMESTAMP) ILM ADD POLICY ROW STORE COMPRESS ADVANCED ROW AFTER 1 DAYS OF NO MODIFICATION;
gaussdb=# INSERT INTO TEST_DATA VALUES (1, '零食大礼包A', NOW());
gaussdb=# SELECT DBE_COMPRESSION.GET_COMPRESSION_TYPE('user1', 'test_data', '(0,1)', NULL);
 get_compression_type
----------------------
                    1
```
父主题：
二次封装接口
版权所有 © 华为技术有限公司
< 上一节
下一节 >



---


---

## DBE_HEAT_MAP

#### 接口介绍
DBE_HEAT_MAP根据输入的参数，返回目标数据块中行的最后修改时间等信息，用于直观浏览每一行被判定为冷、热行的依据。该接口属于运维类接口，不做可见性判断，即传入的ctid为已删除的行时，该接口依然会返回当前行在页面上最新的状态。DBE_HEAT_MAP支持的接口请参见表1。跨页透明压缩不支持此高级包，跨页透明压缩表查询结果中行的最后修改时间为空。

| 接口名称 | 描述 |
|---|---|
| DBE_HEAT_MAP.ROW_HEAT_MAP | 根据对象所属Schema、数据对象名称、数据对象分区名及ctid获取行的最后修改时间等信息。 |

```
BE_HEAT_MAP.ROW_HEAT_MAP(
OWNER           IN VARCHAR2,
SEGMENT_NAME    IN VARCHAR2,
PARTITION_NAME  IN VARCHAR2     DEFAULT NULL,
CTID            IN TEXT,
V_DEBUG         IN BOOL         DEFAULT FALSE,
BUCKETID        IN pg_catalog.int2 DEFAULT NULL))
```

| 参数 | 描述 |
|---|---|
| OWNER | 数据对象所属schema。 |
| SEGMENT_NAME | 数据对象名称。 |
| PARTITION_NAME | 数据对象分区名，可选参数，默认为NULL。 |
| CTID | 目标行的ctid，即block_id或row_id。 |
| V_DEBUG | debug调试，增加日志打印。 |
| BUCKETID | 目标行的tablebucketid。 |
| 参数 | 描述 |
|---|---|
| OWNER | 数据对象的所有者。 |
| SEGMENT_NAME | 数据对象名称。 |
| PARTITION_NAME | 数据对象分区名称，可选参数。 |
| TABLESPACE_NAME | 数据所属的表空间名称。 |
| FILE_ID | 行所属的绝对文件id。 |
| RELATIVE_FNO | 行所属的相对文件id（GaussDB中无此逻辑，因此取值同上）。 |
| CTID | 行的ctid，即block_id或row_id。 |
| WRITETIME | 行的最后修改时间。 |

```
gaussdb=# ALTER DATABASE set ilm = on;
gaussdb=# CREATE SCHEMA HEAT_MAP_DATA;
gaussdb=# SET current_schema=HEAT_MAP_DATA;
gaussdb=# CREATE TABLESPACE example1 RELATIVE LOCATION 'tablespace1';
gaussdb=# CREATE TABLE HEAT_MAP_DATA.heat_map_table(id INT, value TEXT) TABLESPACE example1;
gaussdb=# INSERT INTO HEAT_MAP_DATA.heat_map_table VALUES (1, 'test_data_row_1');
gaussdb=# SELECT * FROM DBE_HEAT_MAP.ROW_HEAT_MAP(
    owner         =>  'heat_map_data',
    segment_name  =>  'heat_map_table',
    partition_name  => NULL,
    ctid          =>  '(0,1)');
     owner     |  segment_name  | partition_name | tablespace_name | file_id | relative_fno | ctid  | writetime
---------------+----------------+----------------+-----------------+---------+--------------+-------+-----------
 heat_map_data | heat_map_table |                | example1        |   17291 |        17291 | (0,1) |
(1 row)
```
- DBE_HEAT_MAP.ROW_HEAT_MAP根据对象所属Schema、数据对象名称、数据对象分区名及ctid获取行的最后修改时间等信息。 DBE_HEAT_MAP.ROW_HEAT_MAP原型为： DBE_HEAT_MAP.ROW_HEAT_MAP 接口只支持分布式数据库中数据节点（DN），其他节点暂不支持。 示例：
父主题：
二次封装接口
版权所有 © 华为技术有限公司
< 上一节
下一节 >



---


---

## DBE_LICENSE

只有具有系统管理员或运维管理员权限的用户可以调用该高级包下的接口。
#### 接口介绍
高级功能包DBE_LICENSE主要用于激活、查看、注销License。主要支持的接口参见表 DBE_LICENSE。

| 接口名称 | 描述 |
|---|---|
| DBE_LICENSE.ACTIVATE | 激活License。 |
| DBE_LICENSE.DEACTIVATE | 注销当前License。 |
| DBE_LICENSE.GET_ESN | 查询节点ESN信息。 |
| DBE_LICENSE.GET_LICENSE_INFO | 查询当前节点License状态信息。 |
| DBE_LICENSE.GET_ALL_NODE_LICENSE_ACTIVATE | 查询数据库集群的License激活状态。 |

```
DBE_LICENSE.ACTIVATE(
    license_type IN VARCHAR2,
    token_file IN VARCHAR2)
RETURN BOOLEAN;
DBE_LICENSE.ACTIVATE(
    license_type IN VARCHAR2,
    license_file IN VARCHAR2,
    key_file IN VARCHAR2)
RETURN BOOLEAN;
```

| 参数 | 描述 |
|---|---|
| license_type | 待激活License类型，可选值为OnCloud或OffCloud。 OnCloud：表示使用令牌文件激活License。OffCloud：表示使用ESDP License文件激活License。 |
| token_file | 令牌文件名称。需遵循以下要求： 名称不能为license.json、license.xml；名称中不能包含'/'或'\\'字符。 |
| license_file | ESDP格式License文件名称。 |
| key_file | 公钥文件名称。 |

- DBE_LICENSE.ACTIVATE函数ACTIVATE根据License类型和对应文件激活License。 当前支持令牌文件或ESDP License文件两种License进行激活。 DBE_LICENSE.ACTIVATE原型为：
  - 执行注销操作后，原先的License将失效，系统将重新为当前数据库节点生成新的ESN信息，且License处于未激活状态。为了保护您的权益不受影响，在执行该操作前，请务必谨慎考虑。
  - 使用ESDP License激活License时，注销节点的License会在数据目录下的gs_esn文件夹中生成撤销码文件RevoTicket.txt。您可用该文件去ESDP平台刷新License的ESN值用于再次激活节点License。
DBE_LICENSE.DEACTIVATE原型为：
```
DBE_LICENSE.DEACTIVATE(
    idempotent    IN BOOLEAN DEFAULT FALSE)
RETURN BOOLEAN;
```
```
DBE_LICENSE.GET_ESN()
RETURN VARCHAR2;
```
- DBE_LICENSE.GET_ESN函数GET_ESN查询当前数据库节点的ESN信息，ESN是数据库节点的唯一标识符，数据库内部会尽可能保证每个节点ESN的唯一性。 DBE_LICENSE.GET_ESN原型为：
```
DBE_LICENSE.GET_LICENSE_INFO()
```
```
gaussdb=# SELECT * FROM  dbe_license.get_license_info();
      create_time       |     activate_time      |      expire_time       |  type   | license_version | customer |   state   |       lsn       |                                      feature_list

                                  | dn_capacity | cn_capacity

------------------------+------------------------+------------------------+---------+-----------------+----------+-----------+-----------------+------------------------------------------------------
----------------------------------+-------------+-------------
 2024-10-20 14:30:45+08 | 2026-01-22 12:02:17+08 | 2026-01-22 12:03:45+08 | OnCloud |               1 | Test     | Activated | lsntesttesttest | enable_ilm,enable_tde,enable_ledger,enable
_security_policy |           1 |           1
(1 row)
```

| 名称 | 类型 | 描述 |
|---|---|---|
| create_time | timestamptz(0) | License创建时间。 |
| activate_time | timestamptz(0) | License激活时间。 已激活的正式License，激活时间为调用接口激活的时间。试用的License，激活时间为进入试用模式的时间。 |
| expire_time | timestamptz(0) | License到期时间。 已激活的License，到期时间为令牌文件或ESDP License文件到期时间。试用的License，到期时间为进入试用模式时的第 90 天。 |
| type | text | License的部署类型： 带管控部署：OnCloud。无管控部署：OffCloud。其他：Illegal deploy mode |
| license_version | bigint | License的版本。 带管控部署时，用于区分签名算法及License结构等。无管控部署时为0。 |
| customer | text | License的购买方。 |
| state | text | License的状态： Activated：表示License已激活。Deactivated：表示License已注销。Expired：表示License已过期。Trial：表示License为试用状态。Error：表示License异常。 |
| lsn | text | License的识别编号。 |
| feature_list | text | License包含的高阶特性列表，由逗号分割的特性GUC参数名称组成。如“ enable_tde,enable_ledger”。 |
| dn_capacity | bigint | 预留字段，无实际含义。 |
| cn_capacity | bigint | 预留字段，无实际含义。 |

```
DBE_LICENSE.GET_ALL_NODE_LICENSE_ACTIVATE()
RETURN BOOLEAN;
```
  - DBE_LICENSE.GET_ALL_NODE_LICENSE_ACTIVATE函数GET_ALL_NODE_LICENSE_ACTIVATE查询当前数据库集群的License激活状态。当集群所有CN和主DN节点License均处于已激活或试用状态时，返回true；当任意CN或主DN节点的状态不为已激活或试用状态时，返回false。 DBE_LICENSE.GET_ALL_NODE_LICENSE_ACTIVATE原型为：
父主题：
二次封装接口
版权所有 © 华为技术有限公司
< 上一节
下一节 >



---

