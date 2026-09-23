# LOB与文件

大对象与文件读写相关。

---

## DBE_LOB

#### 接口介绍
高级功能包DBE_LOB支持的接口参见表1。
 - A数据库中空格的实际字节内容为00，GaussDB中空格对应字节内容为ASCII码值（32）。
- 集中式环境中，CLOB类型对象（下文简称CLOB）、BLOB类型对象（下文简称BLOB）以及BFILE文件（下文简称BFILE）最大支持32TB。
- LOBMAXSIZE最大支持1073741771字节。
- DBE_LOB包中的LOB修改接口（如LOB_WRITE、LOB_COPY、CONVERTTOBLOB、LOB_CONVERTTOBLOB、LOADBLOBFROMBFILE等）仅更新内存中的LOB变量，不会自动更新其关联的物理表数据。即使目标行已通过SELECT ... FOR UPDATE锁定，LOB数据变更也不会自动持久化到数据库表中。如需保存修改结果，必须显式执行UPDATE语句。

| 接口名称 | 描述 |
|---|---|
| DBE_LOB.GET_LENGTH | 获取并返回指定的LOB的长度（不支持大于2GB）。 |
| DBE_LOB.LOB_GET_LENGTH | 获取并返回指定的LOB/BFILE的长度。 |
| DBE_LOB.OPEN | 打开一个LOB，并返回一个LOB的描述符。 |
| DBE_LOB.READ | 根据指定的长度及起始位置偏移读取LOB内容的一部分到BUFFER缓冲区。 |
| DBE_LOB.LOB_READ | 根据指定的长度及起始位置偏移读取LOB内容的一部分到BUFFER缓冲区（支持BFILE读取）。 |
| DBE_LOB.WRITE | 根据指定长度及起始位置偏移将BUFFER中内容写入到LOB中。 |
| DBE_LOB.WRITE_APPEND | 根据指定长度将BUFFER中内容写入到LOB的尾部。 |
| DBE_LOB.LOB_WRITE_APPEND | 根据指定长度将BUFFER中内容写入到LOB的尾部。 |
| DBE_LOB.COPY | 根据指定长度及起始位置偏移将LOB内容写入到另一个LOB中。 |
| DBE_LOB.LOB_COPY | 根据指定长度及起始位置偏移将LOB内容写入到另一个LOB中。 |
| DBE_LOB.ERASE | 根据指定长度及起始位置偏移删除LOB中的内容（不支持大于1GB）。 |
| DBE_LOB.LOB_ERASE | 根据指定长度及起始位置偏移删除LOB中的内容。 |
| DBE_LOB.CLOSE | 关闭已经打开的LOB描述符。 |
| DBE_LOB.MATCH | 返回一个字符串在LOB中第N次出现的位置。 |
| DBE_LOB.COMPARE | 比较两个LOB或者两个LOB的某一部分（支持BFILE比较）。 |
| DBE_LOB.SUBSTR | 用于读取一个LOB的子串，返回读取到的子串。 |
| DBE_LOB.LOB_SUBSTR | 用于读取一个LOB或者BFILE的子串，返回读取到的子串。 |
| DBE_LOB.STRIP | 用于截断指定长度的LOB，执行完会将LOB的长度设置为参数指定的长度。 |
| DBE_LOB.LOB_STRIP | 用于截断指定长度的LOB，执行完会将LOB的长度设置为参数指定的长度。 |
| DBE_LOB.CREATE_TEMPORARY | 创建一个临时的BLOB或者CLOB。 |
| DBE_LOB.APPEND | 将源LOB的内容拼接到目的LOB中。 |
| DBE_LOB.LOB_APPEND | 将源LOB的内容拼接到目的LOB中。 |
| DBE_LOB.FREETEMPORARY | 删除一个临时的BLOB或者CLOB。 |
| DBE_LOB.FILEOPEN | 打开一个数据库BFILE，并返回文件描述符。 |
| DBE_LOB.FILECLOSE | 关闭由FILEOPEN打开的BFILE。 |
| DBE_LOB.BFILEOPEN | 打开一个数据库BFILE。 |
| DBE_LOB.BFILECLOSE | 关闭一个由BFILEOPEN打开的BFILE。 |
| DBE_LOB.LOADFROMFILE | 读取指定位置和长度的数据库BFILE到指定位置的BLOB中。 |
| DBE_LOB.LOADFROMBFILE | 读取指定位置和长度的数据库BFILE到指定位置的LOB中。 |
| DBE_LOB.LOADBLOBFROMFILE | 读取指定位置和长度的数据库外部文件到指定位置的BLOB中（不支持大于1GB）。 |
| DBE_LOB.LOADBLOBFROMBFILE | 读取指定位置和长度的数据库BFILE到指定位置的BLOB中。 |
| DBE_LOB.LOADCLOBFROMFILE | 读取指定位置和长度的数据库外部文件到指定位置的CLOB中（不支持大于1GB）。 |
| DBE_LOB.LOADCLOBFROMBFILE | 读取指定位置和长度的数据库BFILE到指定位置的CLOB中。 |
| DBE_LOB.CONVERTTOBLOB | 将CLOB转换为BLOB（不支持大于1GB）。 |
| DBE_LOB.CONVERTTOCLOB | 将BLOB转换为CLOB（不支持大于1GB）。 |
| DBE_LOB.LOB_CONVERTTOBLOB | 将CLOB转换为BLOB。 |
| DBE_LOB.LOB_CONVERTTOCLOB | 将BLOB转换为CLOB。 |
| DBE_LOB.GETCHUNKSIZE | 获取数据库中CHUNK结构中用于存储LOB数据的最大SIZE。 |
| DBE_LOB.LOB_WRITE | 将源对象从起始位置读取指定长度内容，写入目标LOB的指定偏移位置，覆盖该位置已有的内容, 并返回目标LOB。 |
| DBE_LOB.BFILENAME | 根据目录和文件名构造返回DBE_LOB.BFILE。 |

```
DBE_LOB.GET_LENGTH (
    blob_obj IN BLOB)
RETURN INTEGER;
DBE_LOB.GET_LENGTH (
    clob_obj IN CLOB)
RETURN INTEGER;
```

| 参数 | 描述 |
|---|---|
| blob_obj/clob_obj | 待获取长度的BLOB类型对象/CLOB类型对象。 |

- DBE_LOB.GET_LENGTH函数GET_LENGTH获取并返回指定的LOB类型对象的长度，最大支持2GB。 DBE_LOB.GET_LENGTH原型为：
```
DBE_LOB.LOB_GET_LENGTH (
    blob_obj IN BLOB)
RETURN BIGINT;
DBE_LOB.LOB_GET_LENGTH (
    clob_obj IN CLOB)
RETURN BIGINT;
DBE_LOB.LOB_GET_LENGTH (
    bfile IN DBE_LOB.BFILE)
RETURN BIGINT;
```

| 参数 | 描述 |
|---|---|
| blob_obj/clob_obj/bfile | 待获取长度的BLOB类型对象/CLOB类型对象/BFILE文件。 |

- DBE_LOB.LOB_GET_LENGTH函数LOB_GET_LENGTH获取并返回指定的LOB类型对象/BFILE文件的长度，最大支持32TB。 DBE_LOB.LOB_GET_LENGTH原型为：
```
DBE_LOB.OPEN (
    lob INOUT BLOB);
DBE_LOB.OPEN (
    lob INOUT CLOB);
DBE_LOB.OPEN (
    bfile     INOUT DBE_LOB.BFILE,
    open_mode IN    TEXT DEFAULT 'null');
```

| 参数 | 描述 |
|---|---|
| lob/bfile | 被打开的BLOB类型对象/CLOB类型对象/BFILE文件。 |
| open_mode | 操作模式，现支持[R,W,A,RB,WB,AB]。 |

- DBE_LOB.OPEN存储过程打开一个LOB类型对象，并返回一个LOB描述符，该过程无实际意义，仅用于兼容。 DBE_LOB.OPEN原型为：
```
DBE_LOB.READ (
    blob_obj IN  BLOB,
    amount   IN  INTEGER,
    off_set  IN  INTEGER,
    out_put  OUT RAW);
DBE_LOB.READ (
    clob_obj IN  CLOB,
    amount   IN  INTEGER,
    off_set  IN  INTEGER,
    out_put  OUT VARCHAR2);
```

| 参数 | 说明 |
|---|---|
| blob_obj/clob_obj | 待读入的BLOB类型对象/CLOB类型对象。 |
| amount | 读入长度。 说明： 如果读入长度小于1，或大于32767，则报错。 |
| off_set | 指定从参数LOB类型对象开始读取偏移（即相对LOB类型对象内容起始位置的字节数）的位置。如果偏移量小于1或者大于LOB类型对象长度，则报错。初始位置为1。 |
| out_put | 读取参数LOB类型对象后存放的目标缓冲区。 |

- DBE_LOB.READ存储过程READ根据指定长度及起始位置偏移读取LOB类型对象内容的一部分到out_put缓冲区。 DBE_LOB.READ原型为：
```
DBE_LOB.LOB_READ(
    blob_obj IN    BLOB,
    amount   INOUT BIGINT,
    off_set  IN    BIGINT,
    out_put  OUT   RAW);
DBE_LOB.LOB_READ(
    clob_obj IN    CLOB,
    amount   INOUT BIGINT,
    off_set  IN    BIGINT,
    out_put  OUT   VARCHAR2);
DBE_LOB.LOB_READ(
    bfile   IN    DBE_LOB.BFILE,
    amount  INOUT BIGINT,
    off_set IN    BIGINT,
    out_put OUT   RAW);
```

| 参数 | 说明 |
|---|---|
| blob_obj/clob_obj/bfile | 待读入的BLOB类型对象/CLOB类型对象/BFILE文件（支持大于1GB）。 |
| amount | IN参数为读入长度，OUT参数为实际读取的长度。 说明： 如果读入长度小于1，或大于32767，则报错。 |
| off_set | 指定从参数LOB类型对象/BFILE文件开始读取偏移（即相对lob内容起始位置的字节数）的位置。如果偏移量小于1或者大于LOB类型对象/BFILE文件长度，则报错。初始位置为1。 |
| out_put | 读取参数LOB类型对象/BFILE文件后存放的目标缓冲区。 |

- DBE_LOB.LOB_READ存储过程LOB_READ根据指定长度及起始位置偏移读取LOB类型对象/BFILE文件的一部分到out_put缓冲区。 DBE_LOB.LOB_READ原型为：
```
DBE_LOB.WRITE (
    blob_obj INOUT BLOB,
    amount   IN    INTEGER,
    off_set  IN    INTEGER,
    source   IN    RAW);
DBE_LOB.WRITE (
    clob_obj INOUT CLOB,
    amount   IN    INTEGER,
    off_set  IN    INTEGER,
    source   IN    VARCHAR2);
```

| 参数 | 说明 |
|---|---|
| blob_obj/clob_obj | 待写入的BLOB类型对象/CLOB类型对象。 |
| amount | 写入长度，最大支持32767字节。 说明： 如果写入长度小于1或写入长度大于待写入的内容长度，则报错。 |
| off_set | 指定从BLOB类型对象/CLOB类型对象开始写入偏移（即相对LOB内容起始位置的字节数）的位置。 说明： 如果偏移量小于1或者大于LOBMAXSIZE时，则报错。初始位置是1，最大值为LOB类型对象最大长度。 |
| source | 待写入的内容。 |

- DBE_LOB.WRITE存储过程WRITE根据指定长度及起始位置将source中内容写入到LOB类型对象中。 DBE_LOB.WRITE原型为：
```
DBE_LOB.WRITE_APPEND (
    blob_obj   INOUT BLOB,
    amount     IN    INTEGER,
    source_obj IN    RAW);
DBE_LOB.WRITE_APPEND (
    clob_obj   INOUT CLOB,
    amount     IN    INTEGER,
    source_obj IN    VARCHAR2);
```

| 参数 | 说明 |
|---|---|
| blob_obj/clob_obj | 待写入的指定BLOB类型对象/CLOB类型对象。 |
| amount | 写入长度，最大支持32767字节。 说明： 如果写入长度小于1或写入长度大于待写入的内容长度，则报错。 |
| source_obj | 待写入的内容。 |

- DBE_LOB.WRITE_APPEND存储过程WRITE_APPEND根据指定长度将source_obj中内容写入到LOB类型对象的尾部。 DBE_LOB.WRITE_APPEND原型为：
```
DBE_LOB.LOB_WRITE_APPEND(
    blob_obj    INOUT BLOB,
    amount      IN    INTEGER,
    source_obj  IN    RAW);
DBE_LOB.LOB_WRITE_APPEND (
    clob_obj    INOUT CLOB,
    amount      IN    INTEGER,
    source_obj  IN    VARCHAR2);
```

| 参数 | 说明 |
|---|---|
| blob_obj/clob_obj | 待写入的指定BLOB类型对象/CLOB类型对象。 |
| amount | 写入长度，最大支持32767字节。 说明： 如果写入长度小于1或写入长度大于待写入的内容长度，则报错。 |
| source_obj | 待写入的内容。 |

- DBE_LOB.LOB_WRITE_APPEND存储过程LOB_WRITE_APPEND根据指定长度将source_obj中内容写入到LOB类型对象的尾部。 DBE_LOB.LOB_WRITE_APPEND原型为：
```
DBE_LOB.COPY (
    dest_lob   INOUT BLOB,
    src_lob    IN    BLOB,
    len        IN    INTEGER,
    dest_start IN    INTEGER DEFAULT 1,
    src_start  IN    INTEGER DEFAULT 1);
```

| 参数 | 说明 |
|---|---|
| dest_lob | 待拷入的LOB类型对象。 |
| src_lob | 待拷出的LOB类型对象。 |
| len | 复制长度。 |
| dest_start | 指定从dest_lob内容开始拷入偏移（即相对LOB内容起始位置的字节数）的位置。 |
| src_start | 指定从src_lob内容开始拷出偏移（即相对LOB内容起始位置的字节数）的位置。 |

- DBE_LOB.COPY存储过程COPY根据指定长度及起始位置偏移将LOB类型对象内容复制到另一个LOB类型对象中。 DBE_LOB.COPY原型为：
```
DBE_LOB.LOB_COPY(
    blob_obj    INOUT BLOB,
    source_obj  IN    BLOB,
    amount      IN    BIGINT,
    dest_offset IN    BIGINT DEFAULT 1,
    src_offset  IN    BIGINT DEFAULT 1);
DBE_LOB.LOB_COPY(
    clob_obj    INOUT CLOB,
    source_obj  IN    CLOB,
    amount      IN    BIGINT,
    dest_offset IN    BIGINT DEFAULT 1,
    src_offset  IN    BIGINT DEFAULT 1);
```

| 参数 | 说明 |
|---|---|
| blob_obj/clob_obj | 待拷入的LOB类型对象。 |
| source_obj | 待拷出的LOB类型对象。 |
| amount | 复制长度。 说明： 如果拷入长度小于1或拷入长度大于LOBMAXSIZE，则报错。 |
| dest_offset | 指定从blob_obj/clob_obj内容开始拷入偏移（即相对LOB类型对象起始位置的字节数/字符数，BLOB对象以字节为单位，CLOB对象以字符为单位）的位置。 说明： 如果偏移量小于1或者大于LOBMAXSIZE，则报错。 |
| src_offset | 指定从source_obj内容开始拷出偏移（即相对LOB类型对象起始位置的字节数/字符数，BLOB对象以字节为单位，CLOB对象以字符为单位）的位置。 说明： 如果偏移量小于1则报错。 |

- DBE_LOB.LOB_COPY存储过程COPY根据指定长度及起始位置偏移将LOB类型对象内容复制到另一个LOB类型对象中。 DBE_LOB.LOB_COPY原型为：
```
DBE_LOB.ERASE (
    blob_obj INOUT BLOB,
    amount   INOUT INTEGER,
    off_set  IN    INTEGER DEFAULT 1);
```

| 参数 | 说明 |
|---|---|
| blob_obj | IN参数为待删除内容的LOB类型对象，OUT参数为删除指定部分后的LOB类型对象，传空报错。 |
| amount | IN参数为待删除的长度（BLOB类型对象以字节为单位），OUT参数为实际删除的长度。 说明： 如果删除长度小于1或传空，则报错。 |
| off_set | 指定从BLOB类型对象开始删除偏移（即相对BLOB内容起始位置的字节数，不支持大于1GB）的位置。 说明： 如果偏移量小于1或偏移量传空，则报错。 |

- DBE_LOB.ERASE存储过程ERASE根据指定长度及起始位置偏移删除blob_obj中的内容（不支持大于1GB），blob_obj中删除部分的字节填充为0。 DBE_LOB.ERASE原型为：
```
DBE_LOB.LOB_ERASE (
    blob_obj INOUT BLOB,
    amount   INOUT BIGINT,
    off_set  IN    BIGINT DEFAULT 1);
DBE_LOB.LOB_ERASE (
    clob_obj INOUT CLOB,
    amount   INOUT BIGINT,
    off_set  IN    BIGINT DEFAULT 1);
```

| 参数 | 说明 |
|---|---|
| blob_obj/clob_obj | IN参数为待删除内容的LOB类型对象，OUT参数为删除指定部分后的LOB类型对象，传空报错。 |
| amount | IN参数为待删除的长度（BLOB类型对象以字节为单位，CLOB类型对象以字符为单位），OUT参数为实际删除的长度。 说明： 如果删除长度小于1或传空，则报错。 |
| off_set | 指定从LOB类型对象开始删除偏移（即相对BLOB内容起始位置的字节数/相对CLOB内容起始位置的字符数）的位置。 说明： 如果偏移量小于1或偏移量传空，则报错。 |

- DBE_LOB.LOB_ERASE存储过程LOB_ERASE根据指定长度及起始位置偏移删除LOB类型对象中的内容，BLOB类型对象中删除部分的字节填充为0，CLOB类型对象中删除部分的字符填充为空格，支持LOB类型对象大于1GB，最大支持32TB。 DBE_LOB.LOB_ERASE原型为：
```
DBE_LOB.CLOSE(
    lob IN BLOB);
DBE_LOB.CLOSE (
    lob IN CLOB);
DBE_LOB.CLOSE (
    file IN INTEGER);
```

| 参数 | 说明 |
|---|---|
| lob/file | 待关闭的BLOB类型对象/CLOB类型对象/文件类型对象。 |

- DBE_LOB.CLOSE存储过程CLOSE关闭已经打开的LOB类型对象描述符。 DBE_LOB.CLOSE原型为：
```
DBE_LOB.MATCH(
    blob_obj    IN BLOB,
    blob_obj2   IN RAW,
    beg_index   IN BIGINT DEFAULT 1,
    occur_index IN BIGINT DEFAULT 1)
RETURN BIGINT;
DBE_LOB.MATCH(
    clob_obj    IN CLOB,
    clob_obj2   IN VARCHAR2,
    beg_index   IN BIGINT DEFAULT 1,
    occur_index IN BIGINT DEFAULT 1)
RETURN BIGINT;
DBE_LOB.MATCH(
    bfile       IN DBE_LOB.BFILE,
    blob_obj2     IN RAW,
    beg_index   IN BIGINT DEFAULT 1,
    occur_index IN BIGINT DEFAULT 1)
RETURN BIGINT;
```

| 参数 | 说明 |
|---|---|
| blob_obj/clob_obj/bfile | 要查找的BLOB类型对象/CLOB类型对象描述符，或者BFILE文件（必须先通过DBE_LOB.BFILEOPEN打开），传空返回null。 |
| blob_obj2/clob_obj2 | 要匹配的模式，对于BLOB类型对象/BFILE文件是由一组RAW类型的数据组成，对于CLOB类型对象是由一组VARCHAR2类型的数据组成，传空返回null。 |
| beg_index | 对于BLOB类型对象/BFILE文件是以字节为单位的绝对偏移量，对于CLOB类型对象是以字符为单位的偏移量，模式匹配的起始位置是1。 说明： 有效范围为1~LOBMAXSIZE，超过返回null。 |
| occur_index | 模式匹配的次数，最小值为1。 说明： 若大于模式串在LOB类型对象中最大能匹配上的次数，则返回0，若不在范围1~LOBMAXSIZE，则返回null。 |

- DBE_LOB.MATCH该函数返回字符串在LOB类型对象或者BFILE文件中第N次出现的位置，如果输入的是一些无效值会返回NULL值。支持LOB类型对象或者BFILE文件大于1GB，最大支持32TB。 DBE_LOB.MATCH原型为：
  - 如果比较的结果相等返回0，否则返回非零的值。
  - 如果第一个LOB类型对象比第二个小，返回-1；如果第一个LOB类型对象比第二个大，返回1。
  - 如果len、start1、start2这几个参数有无效参数返回NULL，有效的偏移量范围是1~LOBMAXSIZE。
  - 如果start_pos1、start_pos2同时超过LOB类型对象/BFILE文件长度，则返回0。
DBE_LOB.COMPARE原型为：
```
DBE_LOB.COMPARE (
    lob1       IN BLOB,
    lob2       IN BLOB,
    len        IN BIGINT DEFAULT 1073741312,
    start_pos1 IN BIGINT DEFAULT 1,
    start_pos2 IN BIGINT DEFAULT 1)
RETURN INTEGER;
DBE_LOB.COMPARE (
    lob1       IN CLOB,
    lob2       IN CLOB,
    len        IN BIGINT DEFAULT 1073741312,
    start_pos1 IN BIGINT DEFAULT 1,
    start_pos2 IN BIGINT DEFAULT 1)
RETURN INTEGER;
DBE_LOB.COMPARE (
    file1       IN DBE_LOB.BFILE,
    file2       IN DBE_LOB.BFILE,
    len        IN BIGINT DEFAULT 1073741312,
    start_pos1 IN BIGINT DEFAULT 1,
    start_pos2 IN BIGINT DEFAULT 1)
RETURN INTEGER;
```

| 参数 | 说明 |
|---|---|
| lob1/file1 | 第一个要比较的BLOB类型对象/CLOB类型对象/BFILE文件（必须先通过DBE_LOB.BFILEOPEN打开）。 |
| lob2/file2 | 第二个要比较的BLOB类型对象/CLOB类型对象/BFILE文件（必须先通过DBE_LOB.BFILEOPEN打开）。 |
| len | 要比较的字符数或者字节数，默认值为1073741312。 |
| start_pos1 | 第一个LOB类型对象描述符的偏移量，初始位置是1，最大值为LOB类型对象最大长度。 |
| start_pos2 | 第二个LOB类型对象描述符的偏移量，初始位置是1，最大值为LOB类型对象最大长度。 |

```
DBE_LOB.SUBSTR(
    lob_loc IN BLOB,
    amount  IN INTEGER DEFAULT 32767,
    off_set IN INTEGER  DEFAULT 1)
RETURN RAW;
DBE_LOB.SUBSTR(
    lob_loc IN CLOB,
    amount  IN INTEGER DEFAULT 32767,
    off_set IN INTEGER  DEFAULT 1)
RETURN VARCHAR2;
```

| 参数 | 说明 |
|---|---|
| lob_loc | 将要读取子串的LOB类型对象描述符，对于BLOB类型对象的返回值是读取的RAW类型，对于CLOB类型对象的返回值是VARCHAR2类型。 |
| amount | 要读取的字节数或者字符数量。 说明： 范围为1~32767，超出返回NULL。 |
| off_set | 从开始位置偏移的字符数或者字节数量。 说明： 范围为1~LOBMAXSIZE，超出返回NULL。 |

- DBE_LOB.SUBSTR该函数用于读取一个LOB类型对象的子串，返回读取的子串。 DBE_LOB.SUBSTR原型为：
```
DBE_LOB.LOB_SUBSTR(
    lob_loc IN BLOB,
    amount  IN INTEGER DEFAULT 32767,
    off_set IN BIGINT  DEFAULT 1)
RETURN RAW;
DBE_LOB.LOB_SUBSTR(
    lob_loc IN CLOB,
    amount  IN INTEGER DEFAULT 32767,
    off_set IN BIGINT  DEFAULT 1)
RETURN VARCHAR2;
DBE_LOB.LOB_SUBSTR(
    bfile   IN DBE_LOB.BFILE,
    amount  IN INTEGER DEFAULT 32767,
    off_set IN BIGINT  DEFAULT 1)
RETURN RAW;
```

| 参数 | 说明 |
|---|---|
| lob_loc/bfile | 将要读取子串的LOB类型对象描述符或BFILE文件（必须先通过DBE_LOB.BFILEOPEN打开），对于BLOB类型对象/BFILE文件的返回值是读取的RAW类型，对于CLOB类型对象的返回值是VARCHAR2类型。 |
| amount | 要读取的字节数或者字符数量。 说明： 范围为1~32767，超出返回null。 |
| off_set | 从开始位置偏移的字符数或者字节数量。 说明： 范围为1~LOBMAXSIZE，超出返回null。 |

- DBE_LOB.LOB_SUBSTR该函数用于读取一个LOB类型对象或者BFILE文件的子串，返回读取的子串，LOB类型对象或BFILE文件最大支持32TB。 DBE_LOB.LOB_SUBSTR原型为：
```
DBE_LOB.STRIP(
    lob_loc INOUT BLOB,
    newlen  IN INTEGER);
DBE_LOB.STRIP(
    lob_loc INOUT CLOB,
    newlen  IN INTEGER);
```

| 参数 | 说明 |
|---|---|
| lob_loc | IN参数为待读入的指定LOB类型对象，OUT参数为截断后的对象，传空报错。 |
| newlen | 截断后LOB类型对象的新长度，对于BLOB类型对象是字节数，对于CLOB类型对象是字符数。 |

- DBE_LOB.STRIPSTRIP用于截断指定长度的LOB类型对象，执行完STRIP会将LOB类型对象的长度设置为newlen参数指定的长度。 DBE_LOB.STRIP原型为：
```
DBE_LOB.LOB_STRIP(
    lob_loc INOUT BLOB,
    newlen  IN    BIGINT);
DBE_LOB.LOB_STRIP(
    lob_loc INOUT CLOB,
    newlen  IN    BIGINT);
```

| 参数 | 说明 |
|---|---|
| lob_loc | IN参数为待读入的指定LOB类型对象，OUT参数为截断后的对象，传空报错。 |
| newlen | 截断后LOB类型对象的新长度，对于BLOB类型对象是字节数，对于CLOB类型对象是字符数。 说明： 小于1返回NULL，大于LOB类型对象的长度，报错。 |

- DBE_LOB.LOB_STRIPLOB_STRIP用于截断指定长度的LOB类型对象，执行完LOB_STRIP会将LOB类型对象的长度设置为newlen参数指定的长度。支持LOB类型对象大于1GB，最大支持32TB。 DBE_LOB.LOB_STRIP原型为：
```
DBE_LOB.CREATE_TEMPORARY (
    lob_loc INOUT BLOB,
    cache   IN    BOOLEAN,
    dur     IN    INTEGER DEFAULT 10);
DBE_LOB.CREATE_TEMPORARY (
    lob_loc INOUT CLOB,
    cache   IN    BOOLEAN,
    dur     IN    INTEGER DEFAULT 10);
```

| 参数 | 说明 |
|---|---|
| lob_loc | LOB类型对象描述符。 |
| cache | 仅用于语法上的兼容。 |
| dur | 仅用于语法上的兼容。 |

- DBE_LOB.CREATE_TEMPORARYCREATE_TEMPORARY创建一个临时的BLOB类型对象或者CLOB类型对象，CREATE_TEMPORARY仅用于语法上的兼容，并无实际意义。 DBE_LOB.CREATE_TEMPORARY原型为：
```
DBE_LOB.APPEND (
    blob_obj INOUT BLOB,
    source_obj  IN    BLOB);
DBE_LOB.APPEND (
    clob_obj INOUT CLOB,
    source_obj  IN    CLOB);
```

| 参数 | 说明 |
|---|---|
| blob_obj/clob_obj | 要写入的BLOB类型对象/CLOB类型对象。 |
| source_obj | 读取的BLOB类型对象/CLOB类型对象。 |

- DBE_LOB.APPEND存储过程APPEND将source_obj拼接在目标LOB类型对象之后。 DBE_LOB.APPEND原型为：
```
DBE_LOB.LOB_APPEND(
    blob_obj   INOUT BLOB,
    source_obj IN    BLOB);
DBE_LOB.LOB_APPEND(
    clob_obj   INOUT CLOB,
    source_obj IN    CLOB);
```

| 参数 | 说明 |
|---|---|
| blob_obj/clob_obj | 要写入的BLOB类型对象/CLOB类型对象。 |
| source_obj | 读取的BLOB类型对象/CLOB类型对象。 |

- DBE_LOB.LOB_APPEND存储过程LOB_APPEND将source_obj拼接在目标LOB类型对象之后。 DBE_LOB.LOB_APPEND原型为：
```
DBE_LOB.FREETEMPORARY (
    blob INOUT BLOB);
DBE_LOB.FREETEMPORARY (
    clob INOUT CLOB);
```

| 参数 | 说明 |
|---|---|
| blob/clob | 要释放的BLOB类型对象/CLOB类型对象。 |

- DBE_LOB.FREETEMPORARY存储过程FREETEMPORARY用于释放由CREATE_TEMPORARY创建的LOB类型对象。 DBE_LOB.FREETEMPORARY原型为：
```
DBE_LOB.BFILE (
    directory TEXT,
    filename  TEXT,
    fd        INTEGER);
```
```
DBE_LOB.FILEOPEN (
    bfile     IN DBE_LOB.BFILE,
    open_mode IN TEXT)
RETURN INTEGER;
```

| 参数 | 说明 |
|---|---|
| bfile | 要打开的数据库外部文件（BFILE类型包含了文件路径和文件名、文件描述符（fd））。 说明： 该变量中包含文件目录的位置directory，文件名filename。 文件目录的位置，需要添加到系统表PG_DIRECTORY中，如果传入的路径和PG_DIRECTORY中的路径不匹配，会报路径不存在的错误。在打开GUC参数safe_data_path时，用户只能通过高级包读写safe_data_path指定文件路径下的文件。文件名，包含扩展（文件类型），不包括路径名。如果文件名中包含路径，在OPEN中会被忽略，在Unix系统中，文件名不能以/.结尾。 |
| open_mode | 文件打开模式，只支持read模式（r），其他模式报错。 |

- DBE_LOB.FILEOPENFILEOPEN用于打开数据库外部BFILE文件，并返回该文件对应的文件描述符（fd），一个会话最多支持打开10个BFILE文件。 BFILE类型定义为： DBE_LOB.FILEOPEN原型为：
```
DBE_LOB.FILECLOSE (
    file IN INTEGER);
```

| 参数 | 说明 |
|---|---|
| file | 要关闭的数据库外部文件（由FILEOPEN返回的文件描述符）。 |

- DBE_LOB.FILECLOSE该函数用于关闭数据外部BFILE文件。 DBE_LOB.FILECLOSE原型为：
```
DBE_LOB.BFILEOPEN (
    bfile     INOUT DBE_LOB.BFILE,
    open_mode IN    TEXT DEFAULT 'R');
```

| 参数 | 说明 |
|---|---|
| bfile | INOUT参数为打开的数据库BFILE文件。 说明： 该变量中包含文件目录的位置directory，文件名filename。 文件目录的位置，需要添加到系统表PG_DIRECTORY中，如果传入的路径和PG_DIRECTORY中的路径不匹配，会报路径不存在的错误。在打开GUC参数safe_data_path时，用户只能通过高级包读写safe_data_path指定文件路径下的文件。文件名，包含扩展（文件类型），不包括路径名。如果文件名中包含路径，在OPEN中会被忽略，在Unix系统中，文件名不能以/.结尾。 |
| open_mode | 文件打开模式，只支持read模式（r），其他模式报错。 |

```
-- 获取bfile文件的子串（文件内容为ABCD）。
DECLARE
bfile dbe_lob.bfile;
BEGIN
bfile = DBE_LOB.BFILENAME(dir_name, file_name); -- 获取对应bfile文件对象。
DBE_LOB.bfileopen(bfile, 'r'); -- 打开bfile文件。
RAISE NOTICE 'res:%', DBE_LOB.lob_substr(bfile, 1, 1); -- 获取子串，并打印。
DBE_LOB.bfileclose(bfile);-- 关闭bfile文件。
END;
/
NOTICE:  res:41
ANONYMOUS BLOCK EXECUTE
```
- DBE_LOB.BFILEOPENBFILEOPEN用于打开数据库外部BFILE文件，一个会话最多支持打开10个BFILE文件。 DBE_LOB.BFILEOPEN原型为： 示例：
```
DBE_LOB.BFILECLOSE (
    bfile INOUT DBE_LOB.BFILE);
```

| 参数 | 说明 |
|---|---|
| bfile | INOUT参数为关闭的数据库BFILE文件。 |

- DBE_LOB.BFILECLOSE这个存储过程用于关闭数据库外部BFILE文件。 DBE_LOB.BFILECLOSE原型为：
```
DBE_LOB.LOADFROMFILE (
    dest_lob    IN BLOB,
    src_file    IN INTEGER,
    amount      IN INTEGER,
    dest_offset IN INTEGER,
    src_offset  IN INTEGER)
RETURN RAW;
```

| 参数 | 说明 |
|---|---|
| dest_lob | 目标BLOB类型对象，BFILE文件将读取到这个文件中的指定偏移位置。 |
| src_bfile | 需要读取的源BFILE文件。 |
| amount | 读取BFILE文件内容的长度。 说明： 长度小于1或者大于32767则报错。 |
| dest_offset | BLOB类型对象的偏移长度。 说明： 偏移量小于1或者大于LOBMAXSIZE则报错。 |
| src_offset | BFILE文件的偏移长度。 说明： 偏移量小于1或者大于LOBMAXSIZE则报错。amount + src_offset 大于 src_bfile的长度 + 1 则报错。 |

- DBE_LOB.LOADFROMFILE这个函数用于将BFILE外部文件读取到BLOB类型对象中，并以RAW类型返回该对象。 DBE_LOB.LOADFROMFILE原型为：
```
DBE_LOB.LOADFROMBFILE (
    dest_lob    INOUT BLOB,
    src_file    IN    DBE_LOB.BFILE,
    amount      IN    BIGINT,
    dest_offset IN    BIGINT DEFAULT 1,
    src_offset  IN    BIGINT DEFAULT 1)
RETURN BLOB;
DBE_LOB.LOADFROMBFILE (
    dest_lob    INOUT CLOB,
    src_file    IN    DBE_LOB.BFILE,
    amount      IN    BIGINT,
    dest_offset IN    BIGINT DEFAULT 1,
    src_offset  IN    BIGINT DEFAULT 1)
RETURN CLOB;
```

| 参数 | 说明 |
|---|---|
| dest_lob | IN参数为目标LOB类型对象，BFILE文件（必须先通过DBE_LOB.BFILEOPEN打开）将读取到这个对象中，OUT参数为完成读取后返回的LOB类型对象，大小支持超过1GB，最大支持32TB。 |
| src_file | 需要读取的源BFILE文件，BFILE文件的大小支持超过1GB，最大支持32TB。 |
| amount | 读取BFILE文件内容和写入LOB类型对象的长度。 说明： 长度小于1或者大于LOBMAXSIZE则报错。 |
| dest_offset | LOB类型对象的偏移长度。 说明： 偏移量小于1或者大于LOBMAXSIZE则报错。 |
| src_offset | BFILE文件的偏移长度。 说明： 偏移量小于1或者大于LOBMAXSIZE则报错。amount + src_offset 大于 src_bfile的长度 + 1 则报错。 |

- DBE_LOB.LOADFROMBFILELOADFROMBFILE用于将BFILE外部文件读取到LOB类型对象中。 DBE_LOB.LOADFROMBFILE原型为：
```
DBE_LOB.LOADBLOBFROMFILE (
    dest_lob    IN BLOB,
    src_file    IN INTEGER,
    amount      IN INTEGER,
    dest_offset IN INTEGER,
    src_offset  IN INTEGER)
RETURN RAW;
```

| 参数 | 说明 |
|---|---|
| dest_lob | 目标BLOB类型对象，BFILE文件将读取到这个对象中。 |
| src_file | 需要读取的源BFILE文件。 |
| amount | BLOB类型对象的长度，超过这个阈值的文件将不会保存到BLOB类型对象中。 说明： 长度小于1或者大于32767则报错。 |
| dest_offset | BLOB类型对象的偏移长度。 说明： 偏移量小于1或者大于LOBMAXSIZE则报错。 |
| src_offset | BFILE文件的偏移长度。 说明： 偏移量小于1或者大于LOBMAXSIZE则报错。amount + src_offset 大于 src_bfile的长度 + 1 则报错。 |

- DBE_LOB.LOADBLOBFROMFILE该函数用于将BFILE外部文件读取到BLOB类型对象文件中，并以RAW类型返回该对象。 DBE_LOB.LOADBLOBFROMFILE原型为：
```
DBE_LOB.LOADBLOBFROMFILE (
    dest_lob    INOUT BLOB,
    src_file    IN    DBE_LOB.BFILE,
    amount      IN    BIGINT,
    dest_offset INOUT BIGINT,
    src_offset  INOUT BIGINT)
```

| 参数 | 说明 |
|---|---|
| dest_lob | IN参数为目标BLOB类型对象，BFILE文件（必须先通过DBE_LOB.BFILEOPEN打开）将读取到这个对象中，OUT参数为完成读取后返回的BLOB类型对象。大小支持超过1GB，最大支持32TB。 |
| src_file | 需要读取的源BFILE文件，BFILE文件的大小支持超过1GB，最大支持32TB。 |
| amount | BLOB类型对象的长度，超过这个阈值的文件将不会保存到BLOB类型对象中。 说明： 长度小于1或者大于LOBMAXSIZE则报错。 |
| dest_offset | BLOB类型对象的偏移长度。 说明： 偏移量小于1或者大于LOBMAXSIZE则报错。 |
| src_offset | BFILE文件的偏移长度。 说明： 偏移量小于1或者大于LOBMAXSIZE则报错。amount + src_offset 大于 src_bfile的长度 + 1 则报错。 |

- DBE_LOB.LOADBLOBFROMBFILELOADBLOBFROMBFILE用于将BFILE外部文件读取到BLOB类型对象中。 DBE_LOB.LOADBLOBFROMBFILE原型为：
```
DBE_LOB.LOADCLOBFROMFILE (
    dest_lob    IN CLOB,
    src_file    IN INTEGER,
    amount      IN INTEGER,
    dest_offset IN INTEGER,
    src_offset  IN INTEGER)
RETURN RAW;
```

| 参数 | 说明 |
|---|---|
| dest_lob | 目标CLOB类型对象，BFILE文件将读取到这个文件中。 |
| src_file | 需要读取的源BFILE文件。 |
| amount | CLOB类型对象的长度。 说明： 长度小于1或者大于32767则报错。 |
| dest_offset | CLOB类型对象的偏移长度。 说明： 偏移量小于1或者大于LOBMAXSIZE则报错。 |
| src_offset | BFILE文件的偏移长度。 说明： 偏移量小于1或者大于LOBMAXSIZE则报错。amount + src_offset 大于 src_bfile的长度 + 1 则报错。 |

- DBE_LOB.LOADCLOBFROMFILE该函数用于将BFILE外部文件读取到CLOB类型对象中，并以RAW类型返回该对象。 DBE_LOB.LOADCLOBFROMFILE原型为：
```
DBE_LOB.LOADCLOBFROMBFILE (
    dest_lob    INOUT CLOB,
    src_file    IN    DBE_LOB.BFILE,
    amount      IN    BIGINT,
    dest_offset INOUT BIGINT,
    src_offset  INOUT BIGINT)
```

| 参数 | 说明 |
|---|---|
| dest_lob | IN参数为目标CLOB类型对象，BFILE文件（必须先通过DBE_LOB.BFILEOPEN打开）将读取到这个对象中，OUT参数为完成读取后返回的CLOB类型对象。大小支持超过1GB，最大支持32TB。 |
| src_file | 需要读取的源BFILE文件。BFILE文件的大小支持超过1GB，最大支持32TB。 |
| amount | CLOB类型对象的长度，超过这个阈值的文件将不会保存到CLOB类型对象中。 说明： 长度小于1或者大于LOBMAXSIZE则报错。 |
| dest_offset | CLOB类型对象的偏移长度。 说明： 偏移量小于1或者大于LOBMAXSIZE则报错。 |
| src_offset | BFILE文件的偏移长度。 说明： 偏移量小于1或者大于LOBMAXSIZE则报错。amount + src_offset 大于 src_bfile的长度 + 1 则报错。 |

- DBE_LOB.LOADCLOBFROMBFILELOADCLOBFROMBFILE用于将BFILE外部文件读取到CLOB类型对象中。 DBE_LOB.LOADCLOBFROMBFILE原型为：
```
DBE_LOB.CONVERTTOBLOB(
    dest_blob   IN BLOB,
    src_clob    IN CLOB,
    amount      IN INTEGER DEFAULT 32767,
    dest_offset IN INTEGER DEFAULT 1,
    src_offset  IN INTEGER DEFAULT 1)
RETURN RAW;
```

| 参数 | 说明 |
|---|---|
| dest_blob | 目标BLOB类型对象，CLOB类型对象转换后的文件。 |
| src_clob | 需要读取的源CLOB类型对象。 |
| amount | CLOB类型对象的长度，超过这个阈值的文件将不会保存到BLOB类型对象中。长度小于1或者大于LOBMAXSIZE则报错。 |
| dest_offset | BLOB类型对象的偏移长度，dest_offset=1将从文件起始位置开始载入，以此类推。 |
| src_offset | CLOB类型对象的偏移长度，src_offset=1将从文件起始位置开始读取，以此类推。 |

- DBE_LOB.CONVERTTOBLOB该函数将CLOB类型对象转换成BLOB类型对象，不支持大于1GB的场景。 DBE_LOB.CONVERTTOBLOB原型为：
```
DBE_LOB.LOB_CONVERTTOBLOB(
    dest_blob   INOUT BLOB,
    src_clob    IN    CLOB,
    amount      IN    BIGINT,
    dest_offset INOUT BIGINT,
    src_offset  INOUT BIGINT)
```

| 参数 | 说明 |
|---|---|
| dest_blob | 目标BLOB类型对象，CLOB类型对象转换后的文件。 |
| src_clob | 需要读取的源CLOB类型对象。 |
| amount | CLOB类型对象的长度，超过这个阈值的文件将不会保存到BLOB类型对象中。长度小于1或者大于LOBMAXSIZE则报错。 |
| dest_offset | BLOB类型对象的偏移长度，dest_offset=1将从文件起始位置开始载入，以此类推。偏移量小于1或者大于LOBMAXSIZE则报错。 |
| src_offset | CLOB类型对象的偏移长度，src_offset=1将从文件起始位置开始读取，以此类推。偏移量小于1或者大于LOBMAXSIZE则报错。 |

- DBE_LOB.LOB_CONVERTTOBLOB该函数将CLOB类型对象转换成BLOB类型对象，支持LOB类型对象大于1GB。 DBE_LOB.LOB_CONVERTTOBLOB原型为：
```
DBE_LOB.CONVERTTOCLOB(
    dest_clob   IN CLOB,
    src_blob    IN BLOB,
    amount      IN INTEGER DEFAULT 32767,
    dest_offset IN INTEGER DEFAULT 1,
    src_offset  IN INTEGER DEFAULT 1)
RETURN text;
```

| 参数 | 说明 |
|---|---|
| dest_clob | 目标CLOB类型对象，BLOB类型对象转换后的文件。 |
| src_blob | 需要读取的源BLOB类型对象。 |
| amount | BLOB类型对象的长度，超过这个阈值的文件将不会保存到CLOB类型对象中。 |
| dest_offset | CLOB类型对象的偏移长度，dest_offset=1将从文件起始位置开始载入，以此类推。 |
| src_offset | BLOB类型对象的偏移长度，src_offset=1将从文件起始位置开始读取，以此类推。 |

- DBE_LOB.CONVERTTOCLOB该函数将BLOB类型对象转换成CLOB类型对象，不支持大于1GB的场景。 DBE_LOB.CONVERTTOCLOB原型为：
```
DBE_LOB.LOB_CONVERTTOCLOB(
    dest_clob    INOUT CLOB,
    src_blob    IN    BLOB,
    amount      IN    BIGINT,
    dest_offset INOUT BIGINT,
    src_offset  INOUT BIGINT)
```

| 参数 | 说明 |
|---|---|
| dest_clob | 目标CLOB类型对象，BLOB类型对象转换后的文件。 |
| src_blob | 需要读取的源BLOB类型对象。 |
| amount | BLOB类型对象的长度，超过这个阈值的文件将不会保存到CLOB类型对象中。 |
| dest_offset | CLOB类型对象的偏移长度，dest_offset=1将从文件起始位置开始载入，以此类推。偏移量小于1或者大于LOBMAXSIZE则报错。 |
| src_offset | BLOB类型对象的偏移长度，src_offset=1将从文件起始位置开始读取，以此类推。偏移量小于1或者大于LOBMAXSIZE则报错。 |

- DBE_LOB.LOB_CONVERTTOCLOB该函数将BLOB类型对象转换成CLOB类型对象，支持LOB类型对象大于1G。 DBE_LOB.LOB_CONVERTTOCLOB原型为：
```
DBE_LOB.GETCHUNKSIZE(
    lob_loc IN CLOB
)RETURN INTEGER
DBE_LOB.GETCHUNKSIZE(
    lob_loc IN BLOB
)RETURN INTEGER
```

| 参数 | 说明 |
|---|---|
| lob_loc | 目标CLOB类型对象/BLOB类型对象。 |

- DBE_LOB.GETCHUNKSIZE在数据库存储LOB类型对象时，内部使用toast存储，本函数返回TOAST_MAX_CHUNK_SIZE。 DBE_LOB.GETCHUNKSIZE的原型为：
```
DBE_LOB.LOB_WRITE(
    clob_obj INOUT CLOB,
    amount   IN    INTEGER,
    off_set  IN    BIGINT,
    source   IN    VARCHAR2
)
RETURN CLOB;
DBE_LOB.LOB_WRITE(
    blob_obj INOUT BLOB,
    amount   IN    INTEGER,
    off_set  IN    BIGINT,
    source   IN    RAW
)
RETURN BLOB;
```

| 参数 | 类型 | 入参/出参 | 是否可以为空 | 描述 |
|---|---|---|---|---|
| blob_obj/clob_obj | BLOB/CLOB | INOUT | 否 | IN参数为待写入的目标LOB类型对象，OUT参数为写入内容后的LOB类型对象。 |
| amount | INTEGER | IN | 否 | 待写入的长度（BLOB类型对象以字节为单位，CLOB类型对象以字符为单位）。 |
| off_set | BIGINT | IN | 否 | 在blob_obj/clob_obj中写入的偏移位置。 |
| source | RAW/VARCHAR2 | IN | 否 | 源对象。 |

- DBE_LOB.LOB_WRITE将源对象从起始位置读取指定长度内容，写入目标LOB类型对象的指定偏移位置，覆盖该位置已有的内容, 并返回目标LOB类型对象。 DBE_LOB.LOB_WRITE原型为：
```
DBE_LOB.BFILENAME(
    directory IN TEXT,
    filename  IN TEXT)
RETURN DBE_LOB.BFILE;
```

| 参数 | 说明 |
|---|---|
| directory | 文件目录。 说明： 文件目录的位置，需要添加到系统表PG_DIRECTORY中，如果传入的路径和PG_DIRECTORY中的路径不匹配，会报路径不存在的错误。 在打开GUC参数safe_data_path时，用户只能通过高级包读写safe_data_path指定文件路径下的文件。文件名，包含扩展（文件类型），不包括路径名。如果文件名中包含路径，在OPEN中会被忽略，在Unix系统中，文件名不能以/.结尾。 |
| filename | 文件名。 |

- DBE_LOB.BFILENAME该函数用于根据目录和文件名构造BFILE文件。 DBE_LOB.BFILENAME原型为：
#### 示例

| 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47 48 49 50 51 52 53 54 55 56 57 58 59 60 61 62 | -- 获取字符串的长度。 SELECT DBE_LOB.GET_LENGTH('12345678'); get_length ------------ 8 (1 row) -- DBE_LOB.READ接口示例。 DECLARE myraw RAW(100); amount INTEGER :=2; buffer INTEGER :=1; begin DBE_LOB.READ('123456789012345',amount,buffer,myraw); dbe_output.print_line(myraw); end; / 0123 ANONYMOUS BLOCK EXECUTE CREATE TABLE blob_Table (t1 blob); CREATE TABLE blob_Table_bak (t2 blob); INSERT INTO blob_Table VALUES('abcdef'); INSERT INTO blob_Table_bak VALUES('22222'); -- DBE_LOB多接口示例。 DECLARE str varchar2(100) := 'abcdef'; source raw(100); dest blob; copyto blob; amount int; PSV_SQL varchar2(100); PSV_SQL1 varchar2(100); a int :=1; len int; BEGIN source := dbe_raw.cast_from_varchar2_to_raw(str); amount := dbe_raw.get_length(source); PSV_SQL :='select * from blob_Table for update'; PSV_SQL1 := 'select * from blob_Table_bak for update'; EXECUTE IMMEDIATE PSV_SQL into dest; EXECUTE IMMEDIATE PSV_SQL1 into copyto; DBE_LOB.WRITE(dest, amount, 1, source); DBE_LOB.WRITE_APPEND(dest, amount, source); DBE_LOB.ERASE(dest, a, 1); DBE_OUTPUT.PRINT_LINE(a); DBE_LOB.COPY(copyto, dest, amount, 10, 1); perform DBE_LOB.CLOSE(dest); RETURN; END; / 1 ANONYMOUS BLOCK EXECUTE -- 删除表。 DROP TABLE blob_Table; DROP TABLE blob_Table_bak; |
|---|---|

父主题：
二次封装接口
版权所有 © 华为技术有限公司
< 上一节
下一节 >



---


---

## DBE_FILE

由于当前版本暂不支持创建文件目录对象，因此本高级包下相关接口暂不可用。
DBE_FILE包为存储过程提供了读取和写入操作系统文本文件的功能。
#### 注意事项
- DBE_FILE要求通过DBE_FILE.FOPEN打开的文件必须使用数据库字符集编码，若打开的文件未按预期字符集编码，在使用DBE_FILE.READ_LINE读取时会发生编码校验错误；DBE_FILE要求通过DBE_FILE.FOPEN_NCHAR打开的文件必须使用UTF8字符集编码，若打开的文件未按预期的字符集编码，在使用DBE_FILE.READ_LINE_NCHAR读取时会发生编码校验错误。
- 使用DBE_OUTPUT.PUT_LINE打印DBE_FILE.READ_LINE_NCHAR接口结果时，需确保UTF8字符集编码能够转换为当前数据库字符集编码，满足该条件后以正常输出。DBE_OUTPUT.PRINT_LINE不支持该功能。
- DBE_FILE要求客户端字符集编码必须与数据库字符集编码保持一致。
- 当数据库字符集为ASCII编码，客户端字符集为支持中文的编码，且在客户端调用DBE_FILE.WRITE_NCHAR或DBE_FILE.WRITE_LINE_NCHAR接口写入中文内容时，若输入内容为UTF8编码格式，可能无法保证写入的内容按UTF8格式编码。这可能会导致后续使用DBE_FILE.READ_LINE_NCHAR时报错。
#### 数据类型介绍
DBE_FILE.FILE_TYPE
DBE_FILE.FILE_TYPE类型定义了DBE_FILE包中文件的表示方式，该类型包含的字段为DBE_FILE包的私有字段，禁止直接修改DBE_FILE.FILE_TYPE类型对象的字段值。
DBE_FILE.FILE_TYPE原型为：
```
CREATE TYPE DBE_FILE.FILE_TYPE AS(
    id INTEGER,
    datatype INTEGER,
    byte_mode BOOLEAN
);
```

| 参数 | 描述 |
|---|---|
| id | 文件句柄。 |
| datatype | 表明文件是CHAR文件、NCHAR文件或二进制文件。目前支持CHAR文件和NCHAR文件。CHAR文件返回1，NCHAR文件返回2。 |
| byte_mode | 表明文件是以二进制模式（TRUE）或文本模式（FALSE）打开。 |

#### 接口介绍
高级功能包DBE_FILE支持的接口请参见表2。

| 接口名称 | 描述 |
|---|---|
| DBE_FILE.OPEN/DBE_FILE.FOPEN | 根据指定的目录和文件名打开文件，返回对应的文件句柄或封装了句柄的DBE_FILE.FILE_TYPE类型对象。 |
| DBE_FILE.IS_CLOSE | 检测指定文件句柄是否关闭。 |
| DBE_FILE.IS_OPEN | 检测指定文件句柄是否打开。 |
| DBE_FILE.READ_LINE | 从一个打开的文件中读取一行指定长度的数据。 |
| DBE_FILE.WRITE | 将数据写入到一个打开文件的缓冲区中。 |
| DBE_FILE.NEW_LINE | 将一个或多个行结束符写入到一个打开文件的缓冲区中。 |
| DBE_FILE.WRITE_LINE | 将数据写入到一个打开文件的缓冲区中，并自动追加一个行结束符。 |
| DBE_FILE.FORMAT_WRITE | 将数据按指定格式写入到一个打开文件的缓冲区中。 |
| DBE_FILE.GET_RAW | 从一个打开的文件中读取指定字节数的RAW类型数据。 |
| DBE_FILE.PUT_RAW | 将RAW类型数据写入到一个打开文件的缓冲区中。 |
| DBE_FILE.FLUSH | 将缓存区中的数据写入到物理文件中。 |
| DBE_FILE.CLOSE | 关闭一个打开的文件句柄。 |
| DBE_FILE.CLOSE_ALL | 关闭一个会话中所有已打开的文件句柄。 |
| DBE_FILE.REMOVE | 根据指定目录和文件名删除一个磁盘文件，操作需具备充分权限。 |
| DBE_FILE.RENAME | 重命名一个磁盘文件，功能类似于UNIX的mv命令。 |
| DBE_FILE.COPY | 复制一个连续区域的内容到一个新创建的文件中，若未指定start_line和end_line则复制整个文件。 |
| DBE_FILE.GET_ATTR | 读取并返回一个磁盘文件的属性。 |
| DBE_FILE.SEEK | 根据用户指定的字节数向前或者向后调整文件指针的位置。 |
| DBE_FILE.GET_POS | 以字节为单位返回文件当前的偏移量。 |
| DBE_FILE.FOPEN_NCHAR | 以NCHAR模式根据指定的目录和文件名打开一个文件。 |
| DBE_FILE.WRITE_NCHAR | 将NVARCHAR2类型的数据写入到一个打开的NCHAR模式文件缓冲区中。 |
| DBE_FILE.WRITE_LINE_NCHAR | 将NVARCHAR2类型的数据写入到一个打开的NCHAR模式文件缓冲区中，并自动追加一个行结束符。 |
| DBE_FILE.FORMAT_WRITE_NCHAR | 将NVARCHAR2类型的数据按指定格式写入到一个打开的NCHAR模式文件缓冲区中，允许格式化的DBE_FILE.WRITE_NCHAR接口。 |
| DBE_FILE.READ_LINE_NCHAR | 从一个打开的NCHAR模式文件中读取一行指定长度的数据。 |

```
DBE_FILE.OPEN(
    dir           IN TEXT,
    file_name     IN TEXT,
    open_mode     IN TEXT,
    max_line_size IN INTEGER DEFAULT 1024)
RETURN INTEGER;
DBE_FILE.FOPEN(
    dir           IN TEXT,
    file_name     IN TEXT,
    open_mode     IN TEXT,
    max_line_size IN INTEGER DEFAULT 1024)
RETURN DBE_FILE.FILE_TYPE;
```

| 参数 | 类型 | 入参/出参 | 是否可以为空 | 描述 |
|---|---|---|---|---|
| dir | TEXT | IN | 否 | 文件的目录位置，该字符串表示一个目录对象名。当前版本暂不支持创建文件目录对象。 说明： 文件目录的位置，需要添加到系统表PG_DIRECTORY中，如果传入的路径和PG_DIRECTORY中的路径不匹配，会报路径不存在的错误。在打开GUC参数safe_data_path时，用户仅能通过高级包读写safe_data_path指定文件路径下的文件。 |
| file_name | TEXT | IN | 否 | 文件名，包含扩展（文件类型），不包含路径名。如果文件名中包含路径，在OPEN中会被忽略，在Unix系统中，文件名不能以/.结尾。 |
| open_mode | TEXT | IN | 否 | 指定文件的打开模式，包含：r：read text。w：write text。a：append text。rb：read byte。wb：write byte。ab：append byte。 说明： 对于写操作，会检测写入文件类型，如果为elf类型文件，会报错退出。 |
| max_line_size | INTEGER | IN | 是 | 每行的最大字节数，包含换行符在内，最小值是1，最大值是32767。如果没有指定或指定该参数为空，则使用默认值1024。 |

- DBE_FILE.OPEN/DBE_FILE.FOPEN函数DBE_FILE.OPEN用于打开一个文件，可以指定文件每行的最大字节数，同一个会话内最多可以同时打开50个文件。该函数返回一个INTEGER类型的文件句柄。函数DBE_FILE.FOPEN功能和DBE_FILE.OPEN类似，但返回一个DBE_FILE.FILE_TYPE类型的对象。 DBE_FILE.OPEN和DBE_FILE.FOPEN原型为：
```
DBE_FILE.IS_CLOSE(
    file IN INTEGER)
RETURN BOOLEAN;
DBE_FILE.IS_CLOSE(
    file IN DBE_FILE.FILE_TYPE)
RETURN BOOLEAN;
```

| 参数 | 类型 | 入参/出参 | 是否可以为空 | 描述 |
|---|---|---|---|---|
| file | INTEGER或DBE_FILE.FILE_TYPE | IN | 是 | 待检测的文件句柄或DBE_FILE.FILE_TYPE类型的对象，为空时DBE_FILE.IS_CLOSE接口返回空。 |

- DBE_FILE.IS_CLOSE函数DBE_FILE.IS_CLOSE用于检测指定的文件句柄是否已经关闭，返回布尔值。异常情况为INVALID_FILEHANDLE。 DBE_FILE.IS_CLOSE原型为：
```
DBE_FILE.IS_OPEN(
    file IN INTEGER)
RETURN BOOLEAN;
DBE_FILE.IS_OPEN(
    file IN DBE_FILE.FILE_TYPE)
RETURN BOOLEAN;
```

| 参数 | 类型 | 入参/出参 | 是否可以为空 | 描述 |
|---|---|---|---|---|
| file | INTEGER或DBE_FILE.FILE_TYPE | IN | 是 | 待检测的文件句柄或DBE_FILE.FILE_TYPE类型的对象，为空时DBE_FILE.IS_OPEN接口返回false。 |

- DBE_FILE.IS_OPEN函数DBE_FILE.IS_OPEN用于检测指定的文件句柄是否已经打开，返回布尔值。异常情况为INVALID_FILEHANDLE。 DBE_FILE.IS_OPEN原型为：
```
DBE_FILE.READ_LINE(
    file   IN  INTEGER,
    buffer OUT TEXT,
    len    IN  INTEGER DEFAULT NULL)
RETURN TEXT;
DBE_FILE.READ_LINE(
    file   IN  DBE_FILE.FILE_TYPE,
    buffer OUT TEXT,
    len    IN  INTEGER DEFAULT NULL)
RETURN TEXT;
```

| 参数 | 类型 | 入参/出参 | 是否可以为空 | 描述 |
|---|---|---|---|---|
| file | INTEGER或DBE_FILE.FILE_TYPE | IN | 否 | 通过OPEN打开的文件句柄或者FOPEN打开的DBE_FILE.FILE_TYPE类型的对象，文件必须以读模式打开，否则会抛出INVALID_OPERATION的异常。 |
| buffer | TEXT | OUT | 否 | 接收数据的buffer。 |
| len | INTEGER | IN | 是 | 从文件中读取的字节数，默认值为NULL。如果是NULL，会使用max_line_size来指定大小。 |

- DBE_FILE.READ_LINE函数DBE_FILE.READ_LINE从一个打开的文件读取数据，并把读取的结果存放到buffer中。读取的时候会读取到行尾，但不包含行终结符，或者读取到文件末尾，或者读取到len参数指定的大小。读取的长度不能超过OPEN的时候指定的max_line_size。 DBE_FILE.READ_LINE原型为：
```
DBE_FILE.WRITE(
    file   IN INTEGER,
    buffer IN TEXT)
RETURN BOOLEAN;
DBE_FILE.WRITE(
    file   IN DBE_FILE.FILE_TYPE,
    buffer IN TEXT)
RETURN VOID;
```

| 参数 | 类型 | 入参/出参 | 是否可以为空 | 描述 |
|---|---|---|---|---|
| file | INTEGER或DBE_FILE.FILE_TYPE | IN | 否 | 通过OPEN打开的文件句柄或者FOPEN打开的DBE_FILE.FILE_TYPE类型的对象，要写入的文件必须以写模式打开，这个操作不会写入行终结符。 |
| buffer | TEXT | IN | 是 | 写入文件的文本数据。每行的累计写入长度不能大于或等于OPEN或FOPEN时指定或默认的max_line_size，否则会在刷新到文件时报错，该参数为空时接口会直接返回。 说明： 对于写操作，会检测写入文件类型，如果为elf类型文件，会报错退出。 |

- DBE_FILE.WRITE函数DBE_FILE.WRITE用于向文件对应的缓冲区中写入buffer中的数据，文件必须以写模式打开，这个操作不会写入行终结符。 DBE_FILE.WRITE原型为：
```
DBE_FILE.NEW_LINE(
    file      IN INTEGER,
    line_nums IN INTEGER DEFAULT 1)
RETURN BOOLEAN;
DBE_FILE.NEW_LINE(
    file      IN DBE_FILE.FILE_TYPE,
    line_nums IN INTEGER DEFAULT 1)
RETURN VOID;
```

| 参数 | 类型 | 入参/出参 | 是否可以为空 | 描述 |
|---|---|---|---|---|
| file | INTEGER或DBE_FILE.FILE_TYPE | IN | 否 | 通过OPEN打开的文件句柄或者FOPEN打开的DBE_FILE.FILE_TYPE类型的对象。 |
| line_nums | INTEGER | IN | 是 | 写入到文件中的行终结符的数量，默认值为1，指定为空时不写入行终结符。 |

- DBE_FILE.NEW_LINE函数DBE_FILE.NEW_LINE用于向文件对应的缓冲区中写入一个或者多个行终结符，行终结符和平台相关。 DBE_FILE.NEW_LINE原型为：
```
DBE_FILE.WRITE_LINE(
    file   IN INTEGER,
    buffer IN TEXT,
    flush  IN BOOLEAN DEFAULT FALSE)
RETURN BOOLEAN;
DBE_FILE.WRITE_LINE(
    file   IN DBE_FILE.FILE_TYPE,
    buffer IN TEXT,
    flush  IN BOOLEAN DEFAULT FALSE)
RETURN VOID;
```

| 参数 | 类型 | 入参/出参 | 是否可以为空 | 描述 |
|---|---|---|---|---|
| file | INTEGER或DBE_FILE.FILE_TYPE | IN | 否 | 通过OPEN打开的文件句柄或者FOPEN打开的DBE_FILE.FILE_TYPE类型的对象。 |
| buffer | TEXT | IN | 是 | 要写入文件的文本数据，每行的长度（包含换行符）不能大于OPEN或FOPEN时指定或默认的max_line_size，否则会在刷新到文件时报错。 说明： 对于写操作，会检测写入文件类型，如果为elf类型文件，会报错退出。 |
| flush | BOOLEAN | IN | 是 | 在WRITE_LINE后是否要将文件对应缓冲区中的数据刷到磁盘，默认值或者该参数为空时为false。 |

- DBE_FILE.WRITE_LINE函数DBE_FILE.WRITE_LINE用于向文件对应的缓冲区中写入buffer中的数据，文件必须以写模式打开，这个操作会自动追加行终结符。 DBE_FILE.WRITE_LINE原型为：
```
DBE_FILE.FORMAT_WRITE(
    file   IN INTEGER,
    format IN TEXT,
    arg1   IN TEXT DEFAULT NULL,
    . . .
    arg6   IN TEXT DEFAULT NULL)
RETURN BOOLEAN;
DBE_FILE.FORMAT_WRITE(
    file   IN DBE_FILE.FILE_TYPE,
    format IN TEXT,
    arg1   IN TEXT DEFAULT NULL,
    . . .
    arg6   IN TEXT DEFAULT NULL)
RETURN VOID;
```

| 参数 | 类型 | 入参/出参 | 是否可以为空 | 描述 |
|---|---|---|---|---|
| file | INTEGER或DBE_FILE.FILE_TYPE | IN | 否 | 通过OPEN打开的文件句柄或者FOPEN打开的DBE_FILE.FILE_TYPE类型的对象。 |
| format | text | IN | 是 | 格式化的字符串，包含文本和格式符\n和%s。若指定为空时，则不写入任何数据。 |
| [arg1. . .arg6] | text | IN | 是 | 1到6个可选的参数串，参数和格式化字符的位置是一一对应的，如果存在格式化字符而没有提供参数或者参数为空，会使用空串来替代%s。 |

- DBE_FILE.FORMAT_WRITE函数DBE_FILE.FORMAT_WRITE将格式化数据写入到一个打开文件对应的缓冲区中，是允许格式化的DBE_FILE.WRITE接口。 DBE_FILE.FORMAT_WRITE原型为：
```
DBE_FILE.GET_RAW(
    file   IN  INTEGER,
    r      OUT RAW,
    length IN  INTEGER DEFAULT NULL)
RETURN RAW;
DBE_FILE.GET_RAW(
    file   IN  DBE_FILE.FILE_TYPE,
    r      OUT RAW,
    length IN  INTEGER DEFAULT NULL)
RETURN RAW;
```

| 参数 | 类型 | 入参/出参 | 是否可以为空 | 描述 |
|---|---|---|---|---|
| file | INTEGER或DBE_FILE.FILE_TYPE | IN | 否 | 通过OPEN打开的文件句柄或者FOPEN打开的DBE_FILE.FILE_TYPE类型的对象。 |
| r | RAW | OUT | 否 | 接收RAW类型数据的buffer。 |
| length | INTEGER | IN | 是 | 从文件中读取的字节数，默认值为NULL，如果是NULL，会使用RAW类型最大长度来指定大小。 |

- DBE_FILE.GET_RAW函数DBE_FILE.GET_RAW从一个打开的文件读取RAW类型数据，并把读取的结果存放到buffer中，从r中返回。 DBE_FILE.GET_RAW原型为：
```
DBE_FILE.PUT_RAW (
    file  IN INTEGER,
    r     IN RAW,
    flush IN BOOLEAN DEFAULT FALSE)
RETURN BOOLEAN;
DBE_FILE.PUT_RAW (
    file  IN DBE_FILE.FILE_TYPE,
    r     IN RAW,
    flush IN BOOLEAN DEFAULT FALSE)
RETURN VOID;
```

| 参数 | 类型 | 入参/出参 | 是否可以为空 | 描述 |
|---|---|---|---|---|
| file | INTEGER或DBE_FILE.FILE_TYPE | IN | 否 | 通过OPEN打开的文件句柄或者FOPEN打开的DBE_FILE.FILE_TYPE类型的对象。 |
| r | RAW | IN | 是 | 写入文件的RAW类型数据。指定为NULL时，不写入任何数据。 说明： 对于写操作，会检测写入文件类型，如果为elf类型文件，会报错退出。 |
| flush | BOOLEAN | IN | 是 | 在PUT_RAW后是否要刷到磁盘，不指定或指定为空时采用FALSE。 |

- DBE_FILE.PUT_RAW函数DBE_FILE.PUT_RAW用于向文件对应的缓冲区中写入RAW类型数据。 DBE_FILE.PUT_RAW原型为：
```
DBE_FILE.FLUSH(
    file IN INTEGER)
RETURN VOID;
DBE_FILE.FLUSH(
    file IN DBE_FILE.FILE_TYPE)
RETURN VOID;
```

| 参数 | 类型 | 入参/出参 | 是否可以为空 | 描述 |
|---|---|---|---|---|
| file | INTEGER或DBE_FILE.FILE_TYPE | IN | 否 | 通过OPEN打开的文件句柄或者FOPEN打开的DBE_FILE.FILE_TYPE类型的对象。 |

- DBE_FILE.FLUSH函数DBE_FILE.FLUSH将缓冲区中的数据写入到物理文件中，缓存中的数据必须要有一个行终结符。该函数可以将缓冲区的数据及时写入到对应的物理文件中。 DBE_FILE.FLUSH原型为：
```
DBE_FILE.CLOSE(
    file IN INTEGER)
RETURN BOOLEAN;
DBE_FILE.CLOSE(
    file IN DBE_FILE.FILE_TYPE)
RETURN BOOLEAN;
```

| 参数 | 类型 | 入参/出参 | 是否可以为空 | 描述 |
|---|---|---|---|---|
| file | INTEGER或DBE_FILE.FILE_TYPE | IN | 否 | 通过OPEN打开的文件句柄或者FOPEN打开的DBE_FILE.FILE_TYPE类型的对象。 |

- DBE_FILE.CLOSE函数DBE_FILE.CLOSE用于关闭一个打开的文件句柄，当调用这个函数的时候，如果还有等待写入的缓存的数据，可能会收到异常信息，正常关闭返回TRUE。 DBE_FILE.CLOSE原型为：
```
DBE_FILE.CLOSE_ALL()
RETURN VOID;
```
- DBE_FILE.CLOSE_ALL函数DBE_FILE.CLOSE_ALL关闭一个会话中打开的所有的文件句柄，可用于紧急的清理操作。 DBE_FILE.CLOSE_ALL原型为：
```
DBE_FILE.REMOVE(
    dir       IN TEXT,
    file_name IN TEXT)
RETURN VOID;
```

| 参数 | 类型 | 入参/出参 | 是否可以为空 | 描述 |
|---|---|---|---|---|
| dir | TEXT | IN | 否 | 文件的目录位置，该字符串是一个目录对象名。当前版本暂不支持创建文件目录对象。 说明： 文件目录的位置，需要添加到系统表PG_DIRECTORY中，如果传入的路径和PG_DIRECTORY中的路径不匹配，会报路径不存在的错误。在打开GUC参数safe_data_path时，用户只能通过高级包操作safe_data_path指定文件路径下的文件。 |
| file_name | TEXT | IN | 否 | 文件名。 |

- DBE_FILE.REMOVE函数DBE_FILE.REMOVE删除一个磁盘文件。拥有相应权限的用户才可执行此函数。 DBE_FILE.REMOVE原型为：
```
DBE_FILE.RENAME(
    dir        IN TEXT,
    src_file_name  IN TEXT,
    dest_dir       IN TEXT,
    dest_file_name IN TEXT,
    overwrite      IN BOOLEAN DEFAULT FALSE)
RETURN VOID;
```

| 参数 | 类型 | 入参/出参 | 是否可以为空 | 描述 |
|---|---|---|---|---|
| dir | TEXT | IN | 否 | 源文件的目录位置（大小写敏感）。当前版本暂不支持创建文件目录对象。 说明： 文件目录的位置，需要添加到系统表PG_DIRECTORY中，如果传入的路径和PG_DIRECTORY中的路径不匹配，会报路径不存在的错误。在打开GUC参数safe_data_path时，用户只能通过高级包操作safe_data_path指定文件路径下的文件。 |
| src_file_name | TEXT | IN | 否 | 要进行命名的源文件。 |
| dest_dir | TEXT | IN | 否 | 目的目录位置（大小写敏感）。当前版本暂不支持创建文件目录对象。 说明： 文件目录的位置，需要添加到系统表PG_DIRECTORY中，如果传入的路径和PG_DIRECTORY中的路径不匹配，会报路径不存在的错误。在打开GUC参数safe_data_path时，用户只能通过高级包操作safe_data_path指定文件路径下的文件。 |
| dest_file_name | TEXT | IN | 否 | 新的文件名。 |
| overwrite | BOOLEAN | IN | 是 | 是否重写，参数指定为空或者不指定时表示不重写。在不重写的情况下，如果目的目录下已存在同名文件会报错。 |

- DBE_FILE.RENAME函数DBE_FILE.RENAME重命名一个磁盘文件，类似Unix的mv指令。 DBE_FILE.RENAME原型为：
```
DBE_FILE.COPY(
    src_dir        IN TEXT,
    src_file_name  IN TEXT,
    dest_dir       IN TEXT,
    dest_file_name IN TEXT,
    start_line     IN INTEGER DEFAULT 1,
    end_line       IN INTEGER DEFAULT NULL)
RETURN VOID;
```

| 参数 | 类型 | 入参/出参 | 是否可以为空 | 描述 |
|---|---|---|---|---|
| src_dir | TEXT | IN | 否 | 源文件所在的目录。当前版本暂不支持创建文件目录对象。 说明： 文件目录的位置，需要添加到系统表PG_DIRECTORY中，如果传入的路径和PG_DIRECTORY中的路径不匹配，会报路径不存在的错误。在打开GUC参数safe_data_path时，用户只能通过高级包操作safe_data_path指定文件路径下的文件。 |
| src_file_name | TEXT | IN | 否 | 要复制的源文件名。 |
| dest_dir | TEXT | IN | 否 | 目的文件所在的目录。当前版本暂不支持创建文件目录对象。 说明： 文件目录的位置，需要添加到系统表PG_DIRECTORY中，如果传入的路径和PG_DIRECTORY中的路径不匹配，会报路径不存在的错误。在打开GUC参数safe_data_path时，用户只能通过高级包操作safe_data_path指定文件路径下的文件。 |
| dest_file_name | TEXT | IN | 否 | 目的文件名。 说明： 对于写操作，会检测写入文件类型，如果为elf类型文件，会报错退出。 |
| start_line | INTEGER | IN | 否 | 复制开始的行号，默认为1。 |
| end_line | INTEGER | IN | 是 | 复制结束的行号，默认为NULL，如果是NULL，则指定到文件尾。 |

- DBE_FILE.COPY函数DBE_FILE.COPY复制一个连续区域的内容到一个新创建的文件中，如果忽略了start_line和end_line会复制整个文件。 DBE_FILE.COPY原型为：
```
DBE_FILE.GET_ATTR(
    location    IN  TEXT,
    filename    IN  TEXT,
    fexists     OUT BOOLEAN,
    file_length OUT BIGINT,
    block_size  OUT INTEGER)
RETURN RECORD;
```

| 参数 | 类型 | 入参/出参 | 是否可以为空 | 描述 |
|---|---|---|---|---|
| location | TEXT | IN | 否 | 文件所在的目录。当前版本暂不支持创建文件目录对象。 说明： 文件目录的位置，需要添加到系统表PG_DIRECTORY中，如果传入的路径和PG_DIRECTORY中的路径不匹配，会报路径不存在的错误。在打开GUC参数safe_data_path时，用户只能通过高级包操作safe_data_path指定文件路径下的文件。 |
| filename | TEXT | IN | 否 | 文件名。 |
| fexists | BOOLEAN | OUT | 否 | 文件是否存在。 |
| file_length | BIGINT | OUT | 否 | 文件的字节长度，如果文件不存在返回NULL。 |
| block_size | INTEGER | OUT | 否 | 文件系统的块大小（单位字节），如果文件不存在返回NULL。 |

- DBE_FILE.GET_ATTR函数DBE_FILE.GET_ATTR读取并返回一个磁盘文件的属性。 DBE_FILE.GET_ATTR原型为：
```
DBE_FILE.SEEK(
    file           IN INTEGER,
    absolute_start IN BIGINT DEFAULT NULL,
    relative_start IN BIGINT DEFAULT NULL)
RETURN VOID;
DBE_FILE.SEEK(
    file           IN DBE_FILE.FILE_TYPE,
    absolute_start IN INTEGER DEFAULT NULL,
    relative_start IN INTEGER DEFAULT NULL)
RETURN VOID;
```

| 参数 | 类型 | 入参/出参 | 是否可以为空 | 描述 |
|---|---|---|---|---|
| file | INTEGER或DBE_FILE.FILE_TYPE | IN | 否 | 通过OPEN打开的文件句柄或者FOPEN打开的DBE_FILE.FILE_TYPE类型的对象。 |
| absolute_start | BIGINT或INTEGER | IN | 是 | 文件偏移的绝对位置，默认值为NULL。 |
| relative_start | BIGINT或INTEGER | IN | 是 | 文件偏移的相对位置。如果值是正数，向前偏移；如果是负数，向后偏移；默认值为NULL。如果和absolute_start参数同时指定，以absolute_start参数为准。 |

- DBE_FILE.SEEK函数DBE_FILE.SEEK根据用户指定的字节数向前或者向后调整文件指针的位置。 DBE_FILE.SEEK原型为：
```
DBE_FILE.GET_POS(
    file IN INTEGER)
RETURN BIGINT;
DBE_FILE.GET_POS(
    file IN DBE_FILE.FILE_TYPE)
RETURN BIGINT;
```

| 参数 | 类型 | 入参/出参 | 是否可以为空 | 描述 |
|---|---|---|---|---|
| file | INTEGER或DBE_FILE.FILE_TYPE | IN | 否 | 通过OPEN打开的文件句柄或者FOPEN打开的DBE_FILE.FILE_TYPE类型的对象。 |

- DBE_FILE.GET_POS函数DBE_FILE.GET_POS以字节为单位返回文件当前的偏移量。 DBE_FILE.GET_POS原型为：
```
DBE_FILE.FOPEN_NCHAR(
    dir           IN TEXT,
    file_name     IN TEXT,
    open_mode     IN TEXT,
    max_line_size IN INTEGER DEFAULT 1024)
RETURN DBE_FILE.FILE_TYPE;
```

| 参数 | 类型 | 入参/出参 | 是否可以为空 | 描述 |
|---|---|---|---|---|
| dir | TEXT | IN | 否 | 文件的目录位置，该字符串是一个目录对象名。当前版本暂不支持创建文件目录对象。 说明： 文件目录的位置，需要添加到系统表PG_DIRECTORY中，如果传入的路径和PG_DIRECTORY中的路径不匹配，会报路径不存在的错误。在打开GUC参数safe_data_path时，用户只能通过高级包读写safe_data_path指定文件路径下的文件。 |
| file_name | TEXT | IN | 否 | 文件名，包含扩展（文件类型），不包括路径名。如果文件名中包含路径，在FOPEN_NCHAR中会被忽略，在Unix系统中，文件名不能以/.结尾。 |
| open_mode | TEXT | IN | 否 | 指定文件的打开模式，包含： r：read text。w：write text。a：append text。rb：read byte。wb：write byte。ab：append byte。 说明： 对于写操作，会检测写入文件类型，如果为elf类型文件，会报错退出。 |
| max_line_size | INTEGER | IN | 是 | 每行的最大字节数，包含换行符（最小值是1，最大值是32767）。如果没有指定或指定该参数为空，会使用默认值1024。 |

- DBE_FILE.FOPEN_NCHAR函数DBE_FILE.FOPEN_NCHAR用来打开一个文件，可以指定文件每行的最大字节数，一个会话内最多可以同时打开50个文件。该函数返回一个封装了文件句柄的DBE_FILE.FILE_TYPE类型对象。该函数以国家字符集模式打开文件以进行输入或输出。 DBE_FILE.FOPEN_NCHAR原型为：
```
DBE_FILE.WRITE_NCHAR(
    file   IN DBE_FILE.FILE_TYPE,
    buffer IN NVARCHAR2)
RETURN VOID;
```

| 参数 | 类型 | 入参/出参 | 是否可以为空 | 描述 |
|---|---|---|---|---|
| file | DBE_FILE.FILE_TYPE | IN | 否 | 通过FOPEN_NCHAR打开的DBE_FILE.FILE_TYPE类型的对象，要写入的文件必须以写模式打开，这个操作不会写入行终结符。 |
| buffer | NVARCHAR2 | IN | 是 | 写入文件的文本数据。每行的累计写入长度不能大于或等于FOPEN_NCHAR时指定或默认的max_line_size，否则会在刷新到文件时报错。 说明： 对于写操作，会检测写入文件类型，如果为elf类型文件，会报错退出。 |

- DBE_FILE.WRITE_NCHAR函数DBE_FILE.WRITE_NCHAR用于向文件的缓冲区中写入buffer中的数据，文件必须以国家字符集模式和写模式打开，这个操作不会写入行终结符。文本字符串将以UTF8字符集格式写入。 DBE_FILE.WRITE_NCHAR原型为：
```
DBE_FILE.WRITE_LINE_NCHAR(
    file   IN DBE_FILE.FILE_TYPE,
    buffer IN NVARCHAR2)
RETURN VOID;
```

| 参数 | 类型 | 入参/出参 | 是否可以为空 | 描述 |
|---|---|---|---|---|
| file | DBE_FILE.FILE_TYPE | IN | 否 | 通过FOPEN_NCHAR打开的DBE_FILE.FILE_TYPE类型的对象。 |
| buffer | NVARCHAR2 | IN | 是 | 要写入文件的文本数据，每行的长度（包含换行符）不能大于FOPEN_NCHAR时指定或默认的max_line_size，否则会在刷新到文件时报错。 说明： 对于写操作，会检测写入文件类型，如果为elf类型文件，会报错退出。 |

- DBE_FILE.WRITE_LINE_NCHAR函数DBE_FILE.WRITE_LINE_NCHAR用于向文件的缓冲区中写入buffer中的数据，文件必须以国家字符集模式和写模式打开，这个操作会自动追加行终结符。文本字符串将以UTF8字符集格式写入。 DBE_FILE.WRITE_LINE_NCHAR原型为：
```
DBE_FILE.FORMAT_WRITE_NCHAR(
    file   IN DBE_FILE.FILE_TYPE,
    format IN NVARCHAR2,
    arg1   IN NVARCHAR2 DEFAULT NULL,
    . . .
    arg5   IN NVARCHAR2 DEFAULT NULL)
RETURN VOID;
```

| 参数 | 类型 | 入参/出参 | 是否可以为空 | 描述 |
|---|---|---|---|---|
| file | DBE_FILE.FILE_TYPE | IN | 否 | 通过FOPEN_NCHAR打开的DBE_FILE.FILE_TYPE类型的对象。 |
| format | NVARCHAR2 | IN | 是 | 格式化的字符串，包含文本和格式符\n和%s。 |
| [arg1. . .arg5] | NVARCHAR2 | IN | 是 | 1到5个可选的参数串，参数和格式化字符的位置是一一对应的，如果存在格式化字符而没有提供参数，会使用空串来替代%s。 |

- DBE_FILE.FORMAT_WRITE_NCHAR函数DBE_FILE.FORMAT_WRITE_NCHAR将格式化数据写入到一个打开的文件的缓冲区中，是允许格式化的DBE_FILE.WRITE_NCHAR接口。 DBE_FILE.FORMAT_WRITE_NCHAR原型为：
```
DBE_FILE.READ_LINE_NCHAR(
    file   IN  DBE_FILE.FILE_TYPE,
    buffer OUT NVARCHAR2,
    len    IN  INTEGER DEFAULT NULL)
RETURN NVARCHAR2;
```

| 参数 | 类型 | 入参/出参 | 是否可以为空 | 描述 |
|---|---|---|---|---|
| file | DBE_FILE.FILE_TYPE | IN | 否 | 通过FOPEN_NCHAR打开的DBE_FILE.FILE_TYPE类型的对象，文件必须以读模式打开，否则会抛出INVALID_OPERATION的异常。 |
| buffer | NVARCHAR2 | OUT | 否 | 接收数据的buffer。 |
| len | INTEGER | IN | 是 | 从文件中读取的字节数，默认值为NULL。如果是NULL，会使用max_line_size来指定大小。 |

- DBE_FILE.READ_LINE_NCHAR函数DBE_FILE.READ_LINE_NCHAR从一个打开的文件读取数据，并把读取的结果存放到buffer中。读取的时候会读取到行尾，但不包含行终结符，或者读取到文件末尾，或者读取到len参数指定的大小。读取的长度不能超过FOPEN_NCHAR的时候指定的max_line_size。 DBE_FILE.READ_LINE_NCHAR原型为：
#### 示例
```
-- 系统管理员向PG_DIRECTORY系统表中加入目录/tmp/（当前版本暂不支持创建文件目录对象）。
CREATE OR REPLACE DIRECTORY dir AS '/tmp/';
-- 执行结果。
CREATE DIRECTORY
-- 使用DBE_FILE高级包。
DECLARE
    f INTEGER;
    buffer VARCHAR2;
    raw_buffer RAW;
    f1 DBE_FILE.FILE_TYPE;
    f2 DBE_FILE.FILE_TYPE;
    fexists BOOLEAN;
    file_length BIGINT;
    block_size INTEGER;
    pos BIGINT;
    nvarchar_buffer nvarchar2;
    f_nchar DBE_FILE.FILE_TYPE;
BEGIN
    -- 打开文件。
    f := DBE_FILE.OPEN('dir', 'sample.txt', 'w');
    IF DBE_FILE.IS_OPEN(f) = true THEN
        DBE_OUTPUT.PRINT_LINE('file opened');
    END IF;
    -- 关闭文件。
    DBE_FILE.CLOSE(f);
    IF DBE_FILE.IS_CLOSE(f) = true THEN
        DBE_OUTPUT.PRINT_LINE('file closed');
    END IF;
    f := DBE_FILE.OPEN('dir', 'sample.txt', 'w');
    -- 写文件。
    DBE_FILE.WRITE(f, 'A');
    DBE_FILE.NEW_LINE(f);
    DBE_FILE.WRITE(f, 'B');
    DBE_FILE.WRITE(f, 'C');
    DBE_FILE.NEW_LINE(f, 2);
    DBE_FILE.WRITE_LINE(f, 'ABC');
    DBE_FILE.FORMAT_WRITE(f, '[1 -> %s, 2 -> %s]\n', 'GaussDB', 'DBE_FILE');
    DBE_FILE.PUT_RAW(f, '414243');
    DBE_FILE.NEW_LINE(f);
    DBE_FILE.CLOSE(f);
    -- 新建sample_copy.txt并复制sample.txt的内容。
    DBE_FILE.COPY('dir', 'sample.txt', 'dir', 'sample_copy.txt');
    -- 以读模式打开文件。
    f := DBE_FILE.OPEN('dir', 'sample_copy.txt', 'r');
    -- 读文件。
    DBE_FILE.READ_LINE(f, buffer); -- A
    DBE_OUTPUT.PRINT_LINE(buffer);
    DBE_FILE.READ_LINE(f, buffer); -- BC
    DBE_OUTPUT.PRINT_LINE(buffer);
    DBE_FILE.READ_LINE(f, buffer);
    DBE_FILE.READ_LINE(f, buffer); -- ABC
    DBE_OUTPUT.PRINT_LINE(buffer);
    DBE_FILE.READ_LINE(f, buffer); -- [1 -> GaussDB, 2 -> DBE_FILE]
    DBE_OUTPUT.PRINT_LINE(buffer);
    DBE_FILE.READ_LINE(f, buffer); -- RAW 414243 --> ABC
    DBE_OUTPUT.PRINT_LINE(buffer);
    -- 关闭文件。
    DBE_FILE.CLOSE(f);
    f1 := DBE_FILE.FOPEN('dir', 'sample1.txt', 'w');
    f2 := DBE_FILE.FOPEN('dir', 'sample2.txt', 'w');
    DBE_FILE.CLOSE_ALL();
    IF DBE_FILE.IS_CLOSE(f1) = true and DBE_FILE.IS_CLOSE(f2) = true THEN
        DBE_OUTPUT.PRINT_LINE('f1 and f2 all closed');
    END IF;
    -- 删除文件。
    DBE_FILE.REMOVE('dir', 'sample1.txt');
    DBE_FILE.REMOVE('dir', 'sample2.txt');
    DBE_FILE.REMOVE('dir', 'sample_copy.txt');
    -- 打开文件，清理sample.txt里的数据。
    f := DBE_FILE.OPEN('dir', 'sample.txt', 'w');
    DBE_FILE.WRITE_LINE(f, 'ABC');
    DBE_FILE.CLOSE(f);
    f := DBE_FILE.OPEN('dir', 'sample.txt', 'r');
    -- GET_RAW。
    DBE_FILE.GET_RAW(f, raw_buffer); -- 4142430A 0A是换行符
    DBE_OUTPUT.PRINT_LINE(raw_buffer);
    DBE_FILE.CLOSE(f);
    -- 获取文件属性。
    DBE_FILE.GET_ATTR('dir', 'sample.txt', fexists, file_length, block_size);
    IF fexists = true THEN
        DBE_OUTPUT.PRINT_LINE('file length: ' || file_length);
    END IF;
    -- 修改文件名。
    DBE_FILE.RENAME('dir', 'sample.txt', 'dir', 'sample_rename.txt', true);
    f1 := DBE_FILE.FOPEN('dir', 'sample_rename.txt', 'r');
    DBE_FILE.SEEK(f1, 1, null);
    pos := DBE_FILE.GET_POS(f1);
    DBE_OUTPUT.PRINT_LINE('position is: ' || pos);
    DBE_FILE.READ_LINE(f1, buffer); -- BC
    DBE_OUTPUT.PRINT_LINE(buffer);
    DBE_FILE.CLOSE(f1);
    -- FLUSH。
    f1 := DBE_FILE.FOPEN('dir', 'sample_rename.txt', 'w');
    DBE_FILE.WRITE_LINE(f1, 'ABCEFG');
    DBE_FILE.FLUSH(f1);
    f2 := DBE_FILE.FOPEN('dir', 'sample_rename.txt', 'r');
    DBE_FILE.READ_LINE(f2, buffer); -- ABCEFG
    DBE_OUTPUT.PRINT_LINE(buffer);
    DBE_FILE.CLOSE(f1);
    DBE_FILE.CLOSE(f2);
    DBE_FILE.REMOVE('dir', 'sample_rename.txt');
    -- NCHAR函数。
    f_nchar := DBE_FILE.FOPEN_NCHAR('dir', 'sample_nchar.txt', 'w');
    DBE_FILE.WRITE_NCHAR(f_nchar, 'ABCDE');
    DBE_FILE.WRITE_LINE_NCHAR(f_nchar, 'ABCDE');
    DBE_FILE.FORMAT_WRITE_NCHAR(f_nchar, '%s, %s', 'hello', 'world');
    DBE_FILE.CLOSE(f_nchar);
    f_nchar := DBE_FILE.FOPEN_NCHAR('dir', 'sample_nchar.txt', 'r');
    DBE_FILE.READ_LINE_NCHAR(f_nchar, nvarchar_buffer); -- ABCDEABCDE
    DBE_OUTPUT.PRINT_LINE(nvarchar_buffer);
    DBE_FILE.READ_LINE_NCHAR(f_nchar, nvarchar_buffer); -- hello, world
    DBE_OUTPUT.PRINT_LINE(nvarchar_buffer);
    DBE_FILE.CLOSE(f_nchar);
    DBE_FILE.REMOVE('dir', 'sample_nchar.txt');
END;
/
-- 执行结果。
file opened
file closed
A
BC
ABC
[1 -> GaussDB, 2 -> DBE_FILE]
ABC
f1 and f2 all closed
4142430A
file length: 4
position is: 1
BC
ABCEFG
ABCDEABCDE
hello, world
ANONYMOUS BLOCK EXECUTE
```
父主题：
二次封装接口
版权所有 © 华为技术有限公司
< 上一节
下一节 >



---

