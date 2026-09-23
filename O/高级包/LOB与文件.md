# LOB与文件

大对象与文件读写（对应 GaussDB DBE_LOB、DBE_FILE）。

---

## DBMS_LOB

**包用途**：操作 BLOB/CLOB/NCLOB/BFILE 及临时 LOB 的子程序。可读写、修改 LOB 的特定部分或整体；对 BFILE 提供只读操作。

**接口清单（全部）**：

| Subprogram | 说明 |
|---|---|
| APPEND | 将源 LOB 内容追加到目标 LOB |
| CLOB2FILE | 将 CLOB 内容写入文件 |
| CLOSE | 关闭先前打开的内部或外部 LOB |
| COMPARE | 比较两个整体 LOB 或其部分 |
| CONVERTTOBLOB | 将源 CLOB 字符数据转为二进制写入目标 BLOB，返回新偏移 |
| CONVERTTOCLOB | 将源 BLOB 二进制转为字符数据写入目标 CLOB，返回新偏移 |
| COPY | 将源 LOB 的全部或部分复制到目标 LOB |
| COPY_DBFS_LINK | 将源 LOB 的 DBFS 链接复制到目标 LOB |
| COPY_FROM_DBFS_LINK | 从 DBFS 存储取该 LOB 数据 |
| CREATETEMPORARY | 在用户默认临时表空间创建临时 BLOB/CLOB 及其索引 |
| DBFS_LINK_GENERATE_PATH | 返回用于创建 DBFS 链接的唯一文件路径名 |
| ERASE | 擦除 LOB 的全部或部分 |
| FILECLOSE | 关闭文件 |
| FILECLOSEALL | 关闭所有先前打开的文件 |
| FILEEXISTS | 检查文件在服务器上是否存在 |
| FILEGETNAME | 获取目录对象名与文件名 |
| FILEISOPEN | 检查文件是否用输入 BFILE 定位符打开 |
| FILEOPEN | 打开文件 |
| FRAGMENT_DELETE | 从 LOB 指定偏移起删除指定长度数据 |
| FRAGMENT_INSERT | 在 LOB 指定偏移插入指定数据（≤32K） |
| FRAGMENT_MOVE | 从指定偏移将指定字节数（BLOB）或字符数（CLOB/NCLOB）移到新偏移 |
| FRAGMENT_REPLACE | 用指定数据替换指定偏移处数据（≤32K） |
| FREETEMPORARY | 释放默认临时表空间中的临时 BLOB/CLOB |
| GET_DBFS_LINK | 返回指定 SecureFile 关联的 DBFS 链接路径 |
| GET_DBFS_LINK_STATE | 取指定 SecureFile 的当前 DBFS 链接状态 |
| GETCHUNKSIZE | 返回 LOB 块中存储 LOB 值所用空间量 |
| GETCONTENTTYPE | 返回先前由 SETCONTENTTYPE 设置的内容 ID 字符串 |
| GETLENGTH | 获取 LOB 值长度 |
| GETOPTIONS | 取特定 LOB 对应 option_type 字段的设置 |
| GET_STORAGE_LIMIT | 返回数据库配置中 LOB 的存储上限 |
| INSTR | 返回模式在 LOB 中第 n 次匹配的位置 |
| ISOPEN | 检查 LOB 是否已用输入定位符打开 |
| ISREMOTE | 检查 LOB 是本地还是属于远程数据库 |
| ISSECUREFILE | 是否 SecureFile LOB |
| ISTEMPORARY | 检查定位符是否指向临时 LOB |
| LOADBLOBFROMFILE | 将 BFILE 数据载入内部 BLOB |
| LOADCLOBFROMFILE | 将 BFILE 数据载入内部 CLOB |
| LOADFROMFILE | 将 BFILE 数据载入内部 LOB（自 12.2 已弃用） |
| MOVE_TO_DBFS_LINK | 将指定 SecureFile 数据写入 DBFS 存储 |
| OPEN | 以指定模式打开 LOB（内部/外部/临时） |
| READ | 从指定偏移读取 LOB 数据 |
| SET_DBFS_LINK | 将指定 SecureFile 链接到指定路径名（不复制数据） |
| SETCONTENTTYPE | 设置 LOB 中数据的内容类型字符串 |
| SETOPTIONS | 按 LOB 启用 CSCE 特性，覆盖默认 LOB 列设置 |
| SUBSTR | 从指定偏移返回 LOB 值的一部分 |
| TRIM | 将 LOB 值修剪到指定较短长度 |
| WRITE | 从指定偏移向 LOB 写数据 |
| WRITEAPPEND | 向 LOB 末尾写缓冲区 |

---

## UTL_FILE

**包用途**：服务端 PL/SQL 文件 I/O，类似客户端 TEXT_IO；用 PL/SQL 异常返回错误。

**接口清单（全部）**：

| Subprogram | 说明 |
|---|---|
| FCLOSE | 关闭文件 |
| FCLOSE_ALL | 关闭所有打开的文件句柄 |
| FCOPY | 将文件的连续部分复制到新文件 |
| FFLUSH | 将所有待输出物理写入文件 |
| FGETATTR | 读取并返回磁盘文件属性 |
| FGETPOS | 返回文件内当前相对偏移（字节） |
| FOPEN | 打开文件用于输入或输出 |
| FOPEN_NCHAR | 以 Unicode 打开文件用于输入或输出 |
| FREMOVE | 删除磁盘文件（须有足够权限） |
| FRENAME | 重命名文件（类似 UNIX mv） |
| FSEEK | 按指定字节数前/后调整文件指针 |
| GET_LINE | 从打开文件读文本 |
| GET_LINE_NCHAR | 以 Unicode 从打开文件读文本 |
| GET_RAW | 从文件读 RAW 值并前移文件指针 |
| IS_OPEN | 文件句柄是否指向打开的文件 |
| NEW_LINE | 向文件写一个或多个 OS 行结束符 |
| PUT | 向文件写字符串 |
| PUT_LINE | 向文件写一行并追加 OS 行结束符 |
| PUT_LINE_NCHAR | 向文件写 Unicode 行 |
| PUT_NCHAR | 向文件写 Unicode 字符串 |
| PUTF | 带格式的 PUT |
| PUTF_NCHAR | 带格式的 PUT_NCHAR（写 Unicode） |
| PUT_RAW | 接受 RAW 值写入输出缓冲区 |


---

## UTL_FILE 详细（机译）

## UTL_FILE
通过 `UTL_FILE` 包，PL/SQL 程序可以读取和写入操作系统文本文件。`UTL_FILE` 提供了操作系统流文件 I/O 的受限版本。
本章包含以下主题：
- 安全模型
- 操作说明
- 规则与限制
- 异常
- 示例
- 数据结构
- UTL_FILE 子程序摘要
### UTL_FILE 安全模型
用户通过 `UTL_FILE` 可访问的文件和目录集合受多种因素和数据库参数的控制。其中最重要的是已授予用户的目录对象集合。
目录对象的性质在 Oracle Database SQL Language Reference 中进行了论述。
假设用户对目录对象 `USER_DIR` 同时拥有 `READ` 和 `WRITE` 访问权限，那么用户可以打开位于 `USER_DIR` 所描述的操作系统目录中的文件，但不能打开该目录的子目录或父目录中的文件。
最后，客户端（文本 I/O）和服务器实现均需经过操作系统文件权限检查。
`UTL_FILE` 同时提供客户端和服务器端的文件访问。在服务器端运行时，`UTL_FILE` 提供对从服务器可访问的所有操作系统文件的访问。在客户端，例如 Forms 应用，`UTL_FILE` 提供对从客户端可访问的操作系统文件的访问。
目录对象为 `UTL_FILE` 应用管理员提供了更多的灵活性和更细粒度的控制，可以动态维护（即无需关闭数据库），并且与其他 Oracle 工具保持一致。默认情况下，`CREATE` `ANY` `DIRECTORY` 权限仅授予 `SYS` 和 `SYSTEM`。
注意：
请使用 `CREATE` `DIRECTORY` 特性进行目录访问验证。
请注意，不支持硬链接和符号链接。
在 UNIX 系统上，由 `FOPEN` 函数创建的文件的所有者是运行该实例的影子进程的所有者。通常，此所有者是 `ORACLE`。使用 `FOPEN` 创建的文件始终可使用 `UTL_FILE` 子程序进行写入和读取。但是，需要在 PL/SQL 之外读取这些文件的非特权操作系统用户可能需要系统管理员的访问权限。
警告：
访问目录对象中的文件所需的权限因操作系统而异。`UTL_FILE` 目录对象权限赋予您对指定目录内所有文件的读写访问权限。
### UTL_FILE 操作说明
使用 `UTL_FILE` 时请牢记这些注意事项。
文件位置和文件名参数作为单独的字符串提供给 `FOPEN` 函数，以便可以根据可访问目录对象的 `ALL_DIRECTORIES` 视图指定的可访问目录列表来检查文件位置。文件位置和名称合在一起必须代表系统上的合法文件名，并且该目录必须是可访问的。可访问目录的子目录不一定也可访问；它也必须使用与 `ALL_DIRECTORIES` 对象匹配的完整路径名来指定。
                     `UTL_FILE` 在读取请求时会隐式解释行终止符，从而影响 `GET_LINE` 调用返回的字节数。例如，`UTL_FILE.GET_LINE` 的 `len` 参数指定了请求的字符数据字节数。实际返回给用户的字节数将是以下值中的较小者：
````
- The GET_LINE len parameter, or
- The number of bytes until the next line terminator character, or
````
- The max_linesize parameter specified by UTL_FILE.FOPEN
`FOPEN` 的 `max_linesize` 参数必须是 1 到 32767 之间的数字。如果未指定，Oracle 将提供默认值 1024。`GET_LINE` 的 `len` 参数必须是 1 到 32767 之间的数字。如果未指定，Oracle 将提供默认值 `max_linesize`。如果 `max_linesize` 和 `len` 定义为不同的值，则以较小值为准。
`UTL_FILE.GET_RAW` 忽略行终止符。
`UTL_FILE` 要求以文本模式通过 `UTL_FILE.FOPEN` 打开的文件采用数据库字符集编码。它要求以文本模式通过 `UTL_FILE.FOPEN_NCHAR` 打开的文件采用 UTF8 字符集编码。如果打开的文件未采用预期的字符集编码，则尝试读取该文件的结果将是不确定的。当读取以一种字符集编码的数据，而全球化支持被告知（例如通过 `NLS_LANG`）它是用另一种字符集编码时，结果也是不确定的。因此，如果设置了 `NLS_LANG`，它应与数据库字符集相同。
### UTL_FILE 规则与限制
特定于操作系统的参数（例如 UNIX 下的 C-shell 环境变量）不能用在文件位置或文件名参数中。
`UTL_FILE` I/O 功能类似于标准操作系统流文件 I/O（`OPEN`、`GET`、`PUT`、`CLOSE`）功能，但存在一些限制。例如，您调用 `FOPEN` 函数返回一个文件句柄，然后在后续调用 `GET_LINE` 或 `PUT` 时使用该句柄对文件执行流式 I/O。文件 I/O 完成后，您调用 `FCLOSE` 完成所有输出并释放与文件关联的资源。
注意：
`UTL_FILE` 包类似于 Oracle Procedure Builder 当前提供的客户端 `TEXT_IO` 包。服务器实现的限制要求 `UTL_FILE` 和 `TEXT_IO` 之间存在一些 API 差异。在 PL/SQL 文件 I/O 中，错误通过 PL/SQL 异常返回。
### UTL_FILE 异常
此表描述了 `UTL_FILE` 子程序引发的异常。
表 272-1 UTL_FILE 包异常
| 异常名称 | 描述 |
|---|---|
| INVALID_PATH | 文件位置无效。 |
| INVALID_MODE | FOPEN 中的 open_mode 参数无效。 |
| INVALID_FILEHANDLE | 文件句柄无效。 |
| INVALID_OPERATION | 无法按要求打开或操作文件。 |
| READ_ERROR | 目标缓冲区太小，或在读取操作期间发生操作系统错误 |
| WRITE_ERROR | 在写入操作期间发生操作系统错误。 |
| INTERNAL_ERROR | 未指定的 PL/SQL 错误 |
| CHARSETMISMATCH | 使用 FOPEN_NCHAR 打开了文件，但后续 I/O 操作使用了非字符函数，例如 PUTF 或 GET_LINE。 |
| FILE_OPEN | 由于文件已打开，请求的操作失败。 |
| INVALID_MAXLINESIZE | FOPEN() 的 MAX_LINESIZE 值无效；它应在 1 到 32767 范围内。 |
| INVALID_FILENAME | filename 参数无效。 |
| ACCESS_DENIED | 拒绝访问文件位置的权限。 |
| INVALID_OFFSET | INVALID_OFFSET 异常的原因：ABSOLUTE_OFFSET = NULL 且 RELATIVE_OFFSET = NULL，或者 ABSOLUTE_OFFSET < 0，或者任一偏移量导致搜索越过文件末尾 |
| DELETE_FAILED | 请求的文件删除操作失败。 |
| RENAME_FAILED | 请求的文件重命名操作失败。 |
`UTL_FILE` 中的过程也可能引发预定义的 PL/SQL 异常，例如 `NO_DATA_FOUND` 或 `VALUE_ERROR`。
### UTL_FILE 示例
这两个示例展示了该过程的使用。
示例 1
注意：
这些示例是特定于 UNIX 的。
假设如下：
```
SQL> CREATE DIRECTORY log_dir AS '/appl/gl/log';
SQL> GRANT READ ON DIRECTORY log_dir TO DBA;
SQL> GRANT WRITE ON DIRECTORY log_dir TO DBA;
SQL> CREATE DIRECTORY USER_DIR AS '/appl/gl/user'';
SQL> GRANT READ ON DIRECTORY USER_DIR TO PUBLIC;
SQL> GRANT WRITE ON DIRECTORY USER_DIR TO PUBLIC;
```
以下文件位置和文件名有效且可按如下方式访问：
| 文件位置 | 文件名 | READ 和 WRITE |
|---|---|---|
| /appl/gl/log | L12345.log | 拥有 DBA 权限的用户 |
| /appl/gl/user | u12345.tmp | 所有用户 |
以下文件位置和文件名无效：
| 文件位置 | 文件名 | 无效原因 |
|---|---|---|
| /appl/gl/log/backup | L12345.log | # 无法访问子目录 |
| /APPL/gl/log | L12345.log | # 目录字符串必须遵循操作系统要求的区分大小写规则 |
| /appl/gl/log | backup/L1234.log | # 文件名不能包含目录路径部分 |
| /user/tmp | L12345.log | # 没有发出相应的 CREATE DIRECTORY 命令 |
示例 2
```
DECLARE
  V1 VARCHAR2(32767);
  F1 UTL_FILE.FILE_TYPE;
BEGIN
  -- In this example MAX_LINESIZE is less than GET_LINE's length request
  -- so the number of bytes returned will be 256 or less if a line terminator is seen.
  F1 := UTL_FILE.FOPEN('USER_DIR','u12345.tmp','R',256);
  UTL_FILE.GET_LINE(F1,V1,32767);
  UTL_FILE.FCLOSE(F1);
  -- In this example, FOPEN's MAX_LINESIZE is NULL and defaults to 1024,
  -- so the number of bytes returned will be 1024 or less if a line terminator is seen.
  F1 := UTL_FILE.FOPEN('USER_DIR','u12345.tmp','R');
  UTL_FILE.GET_LINE(F1,V1,32767);
  UTL_FILE.FCLOSE(F1);
  -- In this example, GET_LINE doesn't specify a number of bytes, so it defaults to
  -- the same value as FOPEN's MAX_LINESIZE which is NULL in this case and defaults to 1024.
  -- So the number of bytes returned will be 1024 or less if a line terminator is seen.
  F1 := UTL_FILE.FOPEN('USER_DIR','u12345.tmp','R');
  UTL_FILE.GET_LINE(F1,V1);
  UTL_FILE.FCLOSE(F1);
END;
```
### UTL_FILE 数据结构
`UTL_FILE` 包定义了一种 RECORD 类型。
记录类型
- FILETYPE 记录类型

#### FILETYPE Record Type

`FILE_TYPE` 的内容是 `UTL_FILE` 包私有的。你不应引用或更改此记录的组件。
```
TYPE file_type IS RECORD (
   id          BINARY_INTEGER,
   datatype    BINARY_INTEGER,
   byte_mode   BOOLEAN);
```
字段
Table 272-2 FILE_TYPE Fields
| Field | Description |
|---|---|
| id | 指示内部文件句柄编号的数值 |
| datatype | 指示文件是 CHAR 文件、Nchar 文件还是其他（二进制）文件 |
| byte_mode | 指示文件是作为二进制文件还是文本文件打开 |
注意：
Oracle 不保证 `FILE_TYPE` 值在数据库会话之间或单个会话内持久存在。尝试克隆文件句柄或使用虚拟文件句柄可能会产生不确定的结果。
### Summary of UTL_FILE Subprograms
此表列出了 `UTL_FILE` 子程序并对其进行了简要描述。
Table 272-3 UTL_FILE Subprograms
| Subprogram | Description |
|---|---|
| FCLOSE Procedure | 关闭文件 |
| FCLOSE_ALL Procedure | 关闭所有打开的文件句柄 |
| FCOPY Procedure | 将文件中连续的部分复制到新创建的文件 |
| FFLUSH Procedure | 物理地将所有待处理输出写入文件 |
| FGETATTR Procedure | 读取并返回磁盘文件的属性 |
| FGETPOS Function | 返回文件内当前的相对偏移位置（以字节为单位） |
| FOPEN Function | 打开文件以进行输入或输出 |
| FOPEN_NCHAR Function | 以 Unicode 方式打开文件以进行输入或输出 |
| FREMOVE Procedure | 删除磁盘文件，前提是你具有足够的权限 |
| FRENAME Procedure | 将现有文件重命名为新名称，类似于 UNIX 的 mv 功能 |
| FSEEK Procedure | 按指定的字节数在文件中向前或向后调整文件指针 |
| GET_LINE Procedure | 从打开的文件中读取文本 |
| GET_LINE_NCHAR Procedure | 从打开的文件中读取 Unicode 文本 |
| GET_RAW Procedure | 从文件中读取 RAW 字符串值，并按读取的字节数向前调整文件指针 |
| IS_OPEN Function | 确定文件句柄是否指向打开的文件 |
| NEW_LINE Procedure | 向文件写入一个或多个特定于操作系统的行终止符 |
| PUT Procedure | 向文件写入字符串 |
| PUT_LINE Procedure | 向文件写入一行，并附加特定于操作系统的行终止符 |
| PUT_LINE_NCHAR Procedure | 向文件写入一行 Unicode 文本 |
| PUT_NCHAR Procedure | 向文件写入 Unicode 字符串 |
| PUTF Procedure | 带格式的 PUT 过程 |
| PUTF_NCHAR Procedure | 带格式的 PUT_NCHAR 过程，向文件写入带格式的 Unicode 字符串 |
| PUT_RAW Procedure | 接受 RAW 数据值作为输入，并将该值写入输出缓冲区 |

#### FCLOSE 过程

此过程关闭由文件句柄标识的已打开文件。
语法
```
UTL_FILE.FCLOSE (
   file IN OUT FILE_TYPE);
```
参数
Table 272-4 FCLOSE 过程参数
| Parameter | Description |
|---|---|
| file | 由 FOPEN 或 FOPEN_NCHAR 调用返回的活动文件句柄 |
使用说明
如果在运行 `FCLOSE` 时仍有尚未写入的缓冲数据，则在关闭文件时可能会收到 `WRITE_ERROR` 异常。
异常
```
WRITE_ERROR
INVALID_FILEHANDLE
```

#### FCLOSE_ALL 过程

此过程关闭会话的所有打开文件句柄。它应作为紧急清理过程使用，例如，当 PL/SQL 程序因异常退出时。
语法
```
UTL_FILE.FCLOSE_ALL;
```
用法说明
注意：
`FCLOSE_ALL` 不会更改用户所持有打开文件句柄的状态。这意味着在调用 `FCLOSE_ALL` 之后对文件句柄进行 `IS_OPEN` 测试仍会返回 `TRUE`，即使该文件已被关闭。对在 `FCLOSE_ALL` 之前打开的文件，无法再执行任何进一步的读或写操作。
异常
```
WRITE_ERROR
```

#### FCOPY 过程

此过程将文件中连续的一部分复制到一个新创建的文件中。默认情况下，如果省略 `start_line` 和 `end_line` 参数，则会复制整个文件。源文件以读模式打开。目标文件以写模式打开。可以选择指定起始和结束行号，以便从源文件中部选取一部分进行复制。

语法
```
UTL_FILE.FCOPY (
   src_location    IN VARCHAR2,
   src_filename    IN VARCHAR2,
   dest_location   IN VARCHAR2,
   dest_filename   IN VARCHAR2,
   start_line      IN BINARY_INTEGER DEFAULT 1,
   end_line        IN BINARY_INTEGER DEFAULT NULL);
```

参数
表 272-5 FCOPY 过程参数
| Parameters | Description |
|---|---|
| src_location | 源文件的目录位置，即 ALL_DIRECTORIES 视图中的一个 DIRECTORY_NAME（区分大小写） |
| src_filename | 要复制的源文件 |
| dest_location | 创建目标文件的目标目录 |
| dest_filename | 由源文件创建的目标文件 |
| start_line | 开始复制的行号。默认为 1，即第一行 |
| end_line | 停止复制的行号。默认为 NULL，表示文件结尾 |

异常
`INVALID_FILENAME`
`INVALID_PATH`
`INVALID_OPERATION`
`INVALID_OFFSET`
`READ_ERROR`
`WRITE_ERROR`

#### FFLUSH 过程

`FFLUSH` 将待处理数据物理写入由文件句柄标识的文件。通常，写入文件的数据会被缓冲。`FFLUSH` 过程强制将缓冲数据写入文件。数据必须以换行符结尾。
当文件在仍然打开的情况下必须被读取时，刷新操作非常有用。例如，调试信息可以被刷新到文件中，以便能够立即读取。
语法
```
UTL_FILE.FFLUSH (
   file  IN FILE_TYPE);
```
参数
Table 272-6 FFLUSH 过程参数
| Parameters | Description |
|---|---|
| file | 由 FOPEN 或 FOPEN_NCHAR 调用返回的活动文件句柄 |
异常
`INVALID_FILENAME`
`INVALID_MAXLINESIZE`
`INVALID_OPERATION`
`WRITE_ERROR`

#### FGETATTR 过程

此过程读取并返回磁盘文件的属性。
语法
```
UTL_FILE.FGETATTR(
   location     IN VARCHAR2,
   filename     IN VARCHAR2,
   fexists      OUT BOOLEAN,
   file_length  OUT NUMBER,
   block_size   OUT BINARY_INTEGER);
```
参数
Table 272-7 FGETATTR 过程参数
| 参数 | 描述 |
|---|---|
| location | 源文件的目录位置，即 ALL_DIRECTORIES 视图中的一个 DIRECTORY_NAME（区分大小写） |
| filename | 要检查的文件名 |
| fexists | 表示文件是否存在的 BOOLEAN 值 |
| file_length | 文件的字节长度。如果文件不存在，则为 NULL。 |
| block_size | 文件系统的块大小（以字节为单位）。如果文件不存在，则为 NULL。 |

#### FGETPOS 函数

此函数返回文件内当前的相对偏移位置，以字节为单位。
语法
```
UTL_FILE.FGETPOS (
   file IN FILE_TYPE)
 RETURN PLS_INTEGER;
```
参数
Table 272-8 FGETPOS Parameters
| Parameters | Description |
|---|---|
| file | 源文件的目录位置 |
返回值
`FGETPOS` 返回已打开文件的相对偏移位置，以字节为单位。如果文件未打开，则会引发异常。对于文件开头，它返回 `0`。
异常
`INVALID_FILEHANDLE`
`INVALID_OPERATION`
`READ_ERROR`
使用说明
如果文件是为字节模式操作而打开的，则会引发 `INVALID` `OPERATION` 异常。

#### FOPEN Function

此函数用于打开文件。您可以指定最大行大小，并且最多可以同时打开 50 个文件。
另请参见 FOPEN_NCHAR Function。
语法
```
UTL_FILE.FOPEN (
   location     IN VARCHAR2,
   filename     IN VARCHAR2,
   open_mode    IN VARCHAR2,
   max_linesize IN BINARY_INTEGER DEFAULT 1024)
  RETURN FILE_TYPE;
```
参数
Table 272-9 FOPEN Function Parameters
| Parameter | Description |
|---|---|
| location | 文件的目录位置。此字符串是目录对象名称，必须以大写形式指定。必须授予 UTL_FILE 用户对此目录对象的读取权限，才能运行 FOPEN。 |
| filename | 文件名，包含扩展名（文件类型），不含目录路径。如果在 filename 中指定了目录路径，FOPEN 会将其忽略。在 Unix 系统上，filename 不能以 / 结尾。 |
| open_mode | 指定文件的打开方式。模式包括：r -- 读取文本 w -- 写入文本 a -- 追加文本 rb -- 读取字节模式 wb -- 写入字节模式 ab -- 追加字节模式 如果在 open_mode 中指定 'a' 或 'ab' 来打开文件但文件不存在，则会以写入模式创建该文件。 |
| max_linesize | 该文件每一行的最大字节数，包括换行符（最小值为 1，最大值为 32767）。如果未指定，Oracle 将提供默认值 1024。 |
返回值
`FOPEN` 返回一个文件句柄，该句柄必须传递给对该文件进行操作的所有后续过程。文件句柄的具体内容是 `UTL_FILE` 包私有的，`UTL_FILE` 用户不应引用或修改其各个组件。
Table 272-10 FOPEN Function Return Values
| Return | Description |
|---|---|
| FILE_TYPE | 指向已打开文件的句柄 |
异常
`INVALID_MAXILINESIZE`
`INVALID_MODE`
`INVALID_OPERATION`
`INVALID_PATH`
`INVALID_FILENAME`
使用注意事项
必须以带引号的字符串形式向 `FOPEN` 函数提供文件位置和文件名参数，以便可以根据可访问目录对象视图 `ALL_DIRECTORIES` 指定的可访问目录列表来检查文件位置。

#### FOPEN_NCHAR Function

此函数以国家字符集模式打开文件用于输入或输出，并指定最大行大小。通过此函数，您可以以 Unicode 而非数据库字符集读写文本文件。
您最多可以同时打开 50 个文件。
尽管 `NVARCHAR2` 缓冲区的内容可能是 AL16UTF16 或 UTF8（取决于数据库的国家字符集），但文件内容始终以 UTF8 进行读写。`UTL_FILE` 会在必要时在 UTF8 和 AL16UTF16 之间进行转换。
另请参见 FOPEN Function。
语法
```
UTL_FILE.FOPEN_NCHAR (
   location     IN VARCHAR2,
   filename     IN VARCHAR2,
   open_mode    IN VARCHAR2,
   max_linesize IN BINARY_INTEGER DEFAULT 1024)
RETURN FILE_TYPE;
```
参数
表 272-11 FOPEN_NCHAR Function Parameters
| Parameter | Description |
|---|---|
| location | 文件的目录位置 |
| filename | 文件名（包括扩展名） |
| open_mode | 打开模式 (r,w,a,rb,wb,ab) |
| max_linesize | 此文件每行的最大字符数，包括换行符（最小值为 1，最大值为 32767） |
返回值
`FOPEN_NCHAR` 返回一个文件句柄，该句柄必须传递给对该文件进行操作的所有后续过程。文件句柄的具体内容是 `UTL_FILE` 包私有的，`UTL_FILE` 用户不应引用或更改其各个组件。
表 272-12 FOPEN_NCHAR Function Return Values
| Return | Description |
|---|---|
| FILE_TYPE | 打开文件的句柄 |
异常
`INVALID_MAXILINESIZE`
`INVALID_MODE`
`INVALID_OPERATION`
`INVALID_PATH`

#### FREMOVE 过程

此过程用于删除磁盘文件，前提是您拥有足够的权限。
语法
```
UTL_FILE.FREMOVE (
   location IN VARCHAR2,
   filename IN VARCHAR2);
```
参数
表 272-13 FREMOVE 过程参数
| Parameters | Description |
|---|---|
| location | 文件的目录位置，是来自 ALL_DIRECTORIES 的一个 DIRECTORY_NAME（区分大小写） |
| filename | 要删除的文件名 |
异常
`ACCESS_DENIED`
`DELETE_FAILED`
`INVALID_FILENAME`
`INVALID_OPERATION`
`INVALID_PATH`
用法说明
`FREMOVE` 过程在删除文件前不验证权限。由 O/S 验证文件和目录权限。失败时将返回异常。

#### FRENAME 过程

此过程将现有文件重命名为新名称，类似于 UNIX `mv` 功能。
语法
```
UTL_FILE.FRENAME (
   src_location     IN   VARCHAR2,
   src_filename     IN   VARCHAR2,
   dest_location    IN   VARCHAR2,
   dest_filename    IN   VARCHAR2,
   overwrite        IN   BOOLEAN DEFAULT FALSE);
```
参数
Table 272-14 FRENAME 过程参数
| Parameters | Description |
|---|---|
| src_location | 源文件的目录位置，是 ALL_DIRECTORIES 视图中的 DIRECTORY_NAME（区分大小写） |
| src_filename | 要重命名的源文件 |
| dest_location | 目标文件的目标目录，是 ALL_DIRECTORIES 视图中的 DIRECTORY_NAME（区分大小写） |
| dest_filename | 文件的新名称 |
| overwrite | 默认为 FALSE。必须授予源目录和目标目录的权限。可以使用 overwrite 参数指定如果目标目录中已存在文件是否覆盖该文件。默认值为 FALSE，表示不覆盖。 |
异常
`ACCESS_DENIED`
`INVALID_FILENAME`
`INVALID_PATH`
`RENAME_FAILED`

#### FSEEK 过程

此过程按指定的字节数在文件中向前或向后调整文件指针。
语法
```
UTL_FILE.FSEEK (
   file             IN OUT  UTL_FILE.FILE_TYPE,
   absolute_offset  IN      PL_INTEGER DEFAULT NULL,
   relative_offset  IN      PLS_INTEGER DEFAULT NULL);
```
参数
Table 272-15 FSEEK 过程参数
| Parameters | Description |
|---|---|
| file | 文件句柄 |
| absolute_offset | 要定位到的绝对位置；默认值 = NULL |
| relative_offset | 向前或向后定位的字节数；正数 = 向前，负整数 = 向后，0 = 当前位置，默认值 = NULL |
异常
`INVALID_FILEHANDLE`
`INVALID_OFFSET`
`INVALID_OPERATION`
`READ_ERROR`
使用说明
- 使用 FSEEK，无需先关闭并重新打开文件即可读取文件中前面的行。您必须知道要移动的字节数。
````````
- 如果使用 relative_offset，过程将向前定位。如果 relative_offset > 0，则向前定位；如果 relative_offset < 0，则向后定位，过程将按指定的 relative_offset 字节数在文件中定位。
- 如果在达到指定字节数之前到达文件开头，则文件指针将被置于文件开头。如果在达到指定字节数之前到达文件结尾，则会引发 INVALID_OFFSET 错误。
- 如果使用 absolute_offset，过程将定位到以字节为单位的绝对位置。
````
- 如果 file 是为字节模式操作而打开的，则会引发 INVALID OPERATION 异常。

#### GET_LINE 过程

此过程从由文件句柄标识的打开文件中读取文本，并将文本放入输出 buffer 参数中。读取文本直至行终止符（但不包含行终止符），或直至文件末尾，或直至 `len` 参数的末尾。它不能超过在 `FOPEN` 中指定的 `max_linesize`。

语法
```
UTL_FILE.GET_LINE (
   file        IN  FILE_TYPE,
   buffer      OUT VARCHAR2,
   len         IN  PLS_INTEGER DEFAULT NULL);
```

参数
表 272-16 GET_LINE 过程参数
| Parameters | Description |
|---|---|
| file | 由 FOPEN 调用返回的活动文件句柄。文件必须以读模式（mode r）打开；否则会引发 INVALID_OPERATION 异常。 |
| buffer | 用于接收从文件中读取的行的数据缓冲区 |
| len | 从文件中读取的字节数。默认值为 NULL。如果为 NULL，Oracle 提供 max_linesize 的值。 |

异常
`INVALID_FILEHANDLE`
`INVALID_OPERATION`
`NO_DATA_FOUND`
`READ_ERROR`

用法说明
如果该行无法放入缓冲区，会引发 `READ_ERROR` 异常。如果因到达文件末尾而未读取到文本，会引发 `NO_DATA_FOUND` 异常。如果文件以字节模式操作打开，会引发 `INVALID_OPERATION` 异常。

由于行终止符不会读入缓冲区，读取空行会返回空字符串。

`buffer` 参数的最大大小为 32767 字节，除非在 `FOPEN` 中指定了更小的值。如果未指定，Oracle 提供默认值 1024。另请参见“GET_LINE_NCHAR 过程”。

#### GET_LINE_NCHAR Procedure

此过程从由文件句柄标识的打开文件中读取文本，并将其放入输出缓冲区参数中。使用此函数，您可以读取 Unicode 格式的文本文件，而不是数据库字符集格式的文本文件。
文件必须以国家字符集模式打开，并且必须以 UTF8 字符集编码。预期的缓冲区数据类型为 `NVARCHAR2`。如果指定了其他数据类型的变量，例如 `NCHAR`、`NCLOB` 或 `VARCHAR2`，PL/SQL 将在读取文本后执行从 `NVARCHAR2` 的标准隐式转换。
另请参见 GET_LINE Procedure
语法
```
UTL_FILE.GET_LINE_NCHAR (
   file        IN  FILE_TYPE,
   buffer      OUT NVARCHAR2,
   len         IN  PLS_INTEGER DEFAULT NULL);
```
参数
Table 272-17 GET_LINE_NCHAR Procedure Parameters
| Parameters | Description |
|---|---|
| file | 由 FOPEN_NCHAR 调用返回的活动文件句柄。文件必须以读取模式（mode r）打开。如果文件是由 FOPEN 而不是 FOPEN_NCHAR 打开的，将引发 CHARSETMISMATCH 异常。 |
| buffer | 用于接收从文件中读取的行的数据缓冲区 |
| len | 从文件中读取的字节数。默认值为 NULL。如果为 NULL，Oracle 将提供 max_linesize 的值。 |
异常
`INVALID_FILEHANDLE`
`INVALID_OPERATION`
`NO_DATA_FOUND`
`READ_ERROR`

#### GET_RAW Procedure

此过程从文件中读取一个 `RAW` 字符串值，并将文件指针按读取的字节数向前移动。`UTL_FILE.GET_RAW` 会忽略行终止符。
语法
```
UTL_FILE.GET_RAW (
   file       IN            UTL_FILE.FILE_TYPE,
   buffer     OUT NOCOPY    RAW,
   len        IN            PLS_INTEGER DEFAULT NULL);
```
参数
Table 272-18 GET_RAW Procedure Parameters
| 参数 | 描述 |
|---|---|
| file | 文件句柄 |
| buffer | RAW 数据 |
| len | 从文件中读取的字节数。默认值为 NULL。如果为 NULL，则假定 len 为 RAW 的最大长度。 |
异常
`INVALID_FILEHANDLE`
`INVALID_OPERATION`
`LENGTH_MISMATCH`
`NO_DATA_FOUND`
`READ_ERROR`
用法说明
当子程序尝试读取超过文件末尾时，将引发 `No_Data_Found`。您的应用程序应通过在处理循环中捕获该异常来对此做好准备。
```
PROCEDURE Sys.p (n IN VARCHAR2) IS
      h     UTL_FILE.FILE_TYPE := UTL_FILE.FOPEN('D', n, 'r', 32767);
      Buf   RAW(32767);
      Amnt  CONSTANT PLS_INTEGER := 32767;
    BEGIN
      LOOP
        BEGIN
          Utl_File.Get_Raw(h, Buf, Amnt);
          -- 对此数据块执行某些操作
        EXCEPTION WHEN No_Data_Found THEN EXIT; END;
      END LOOP;
      UTL_FILE.FCLOSE (h);
    END;
```

#### IS_OPEN 函数

此函数测试文件句柄，以查看它是否标识一个打开的文件。
`IS_OPEN` 仅报告文件句柄是否表示一个已打开但尚未关闭的文件。它不保证在您尝试使用该文件句柄时不会出现操作系统错误。
语法
```
UTL_FILE.IS_OPEN (
   file  IN FILE_TYPE)
  RETURN BOOLEAN;
```
参数
Table 272-19 IS_OPEN Function Parameters
| Parameter | Description |
|---|---|
| file | 由 FOPEN 或 FOPEN_NCHAR 调用返回的活动文件句柄 |
返回值
`TRUE` 或 `FALSE`
异常
`INVALID_FILEHANDLE`

#### NEW_LINE 过程

此过程向由输入文件句柄标识的文件写入一个或多个行终止符。
此过程与 `PUT` 分开，因为行终止符是特定于平台的字符或字符序列。
语法
```
UTL_FILE.NEW_LINE (
   file     IN FILE_TYPE,
   lines    IN BINARY_INTEGER := 1);
```
参数
表 272-20 NEW_LINE 过程参数
| 参数 | 描述 |
|---|---|
| file | 由 FOPEN 或 FOPEN_NCHAR 调用返回的活动文件句柄 |
| lines | 要写入文件的行终止符数量 |
异常
`INVALID_FILEHANDLE`
`INVALID_OPERATION`
`WRITE_ERROR`

#### PUT 过程

`PUT` 将存储在 buffer 参数中的文本字符串写入由文件句柄标识的已打开文件。
文件必须已打开以进行写操作。`PUT` 不会追加行终止符；请使用 `NEW_LINE` 来终止行，或者使用 `PUT_LINE` 来写入带有行终止符的完整行。另请参见“PUT_NCHAR 过程”。
语法
```
UTL_FILE.PUT (
   file      IN FILE_TYPE,
   buffer    IN VARCHAR2);
```
参数
表 272-21 PUT 过程参数
| Parameters | Description |
|---|---|
| file | 由 FOPEN_NCHAR 调用返回的活动文件句柄。文件必须已打开以进行写入。 |
| buffer | 包含要写入文件的文本的缓冲区。用户必须已使用模式 w 或模式 a 打开文件；否则，将引发 INVALID_OPERATION 异常。 |
使用说明
`buffer` 参数的最大大小为 32767 字节，除非您在 `FOPEN` 中指定了更小的大小。如果未指定，Oracle 将提供默认值 1024。在没有中间缓冲区刷新的情况下，所有连续 `PUT` 调用的总和不能超过 32767。
异常
`INVALID_FILEHANDLE`
`INVALID_OPERATION`
`WRITE_ERROR`

#### PUT_LINE Procedure

此过程将存储在 `buffer` 参数中的文本字符串写入由文件句柄标识的打开文件中。
该文件必须处于为写操作打开的状态。`PUT_LINE` 使用平台特定的一个或多个行终止符来结束该行。
另请参见“PUT_LINE_NCHAR Procedure”。
语法
```
UTL_FILE.PUT_LINE (
   file      IN FILE_TYPE,
   buffer    IN VARCHAR2,
   autoflush IN BOOLEAN DEFAULT FALSE);
```
参数
Table 272-22 PUT_LINE Procedure Parameters
| Parameters | Description |
|---|---|
| file | 由 FOPEN 调用返回的活动文件句柄 |
| buffer | 包含要写入文件的行的文本缓冲区 |
| autoflush | 在 WRITE 之后将缓冲区刷新到磁盘 |
异常
`INVALID_FILEHANDLE`
`INVALID_OPERATION`
`WRITE_ERROR`
用法说明
``````
- `buffer` 参数的最大大小为 32767 字节，除非在 FOPEN 中指定了更小的大小。如果未指定，Oracle 提供默认值 1024。在没有中间缓冲区刷新的情况下，所有连续 PUT 调用的总和不能超过 32767。
````
- 如果文件是为字节模式操作而打开的，则会引发 INVALID OPERATION 异常。

#### PUT_LINE_NCHAR 过程

此过程将存储在 buffer 参数中的文本字符串写入由文件句柄标识的打开文件中。使用此函数，您可以以 Unicode 格式而不是数据库字符集写入文本文件。
此过程等同于 PUT_NCHAR 过程，区别在于会在写入的文本后附加行分隔符。另请参见 PUT_LINE 过程。
语法
```
UTL_FILE.PUT_LINE_NCHAR (
   file    IN FILE_TYPE,
   buffer  IN NVARCHAR2);
```
参数
表 272-23 PUT_LINE_NCHAR 过程参数
| 参数 | 描述 |
|---|---|
| file | 由 FOPEN_NCHAR 调用返回的活动文件句柄。该文件必须以写入方式打开。 |
| buffer | 包含要写入文件各行的文本缓冲区 |
异常
`INVALID_FILEHANDLE`
`INVALID_OPERATION`
`WRITE_ERROR`
使用说明
``````
- buffer 参数的最大大小为 32767 字节，除非您在 FOPEN 中指定了更小的值。如果未指定，Oracle 会提供默认值 1024。在没有中间缓冲区刷新的情况下，所有连续 PUT 调用的总和不能超过 32767。
````
- 如果文件以字节模式操作打开，则会引发 INVALID OPERATION 异常。

#### PUT_NCHAR Procedure

此过程将存储在 buffer 参数中的文本字符串写入由文件句柄标识的已打开文件。
使用此函数，您可以以 Unicode 而非数据库字符集写入文本文件。文件必须以国家字符集模式打开。文本字符串将以 UTF8 字符集写入。预期的 buffer 数据类型为 `NVARCHAR2`。如果指定了其他数据类型的变量，PL/SQL 将在写入文本之前执行到 `NVARCHAR2` 的隐式转换。
语法
```
UTL_FILE.PUT_NCHAR (
   file      IN FILE_TYPE,
   buffer    IN NVARCHAR2);
```
参数
Table 272-24 PUT_NCHAR Procedure Parameters
| Parameters | Description |
|---|---|
| file | 由 FOPEN_NCHAR 调用返回的活动文件句柄。如果文件由 FOPEN 而非 FOPEN_NCHAR 打开，将引发 CHARSETMISMATCH 异常。 |
| buffer | 包含要写入文件的文本的缓冲区。用户必须已使用模式 w 或模式 a 打开文件；否则，将引发 INVALID_OPERATION 异常。 |
异常
`INVALID_FILEHANDLE`
`INVALID_OPERATION`
`WRITE_ERROR`
使用说明
`buffer` 参数的最大大小为 32767 字节，除非您在 `FOPEN` 中指定了更小的大小。如果未指定，Oracle 将提供默认值 1024。在没有中间缓冲区刷新的情况下，所有连续 `PUT` 调用的总和不能超过 32767。
**相关主题**
                           - PUT Procedure

#### PUTF 过程

此过程是一个带格式的 `PUT` 过程。
它的作用类似于一个功能受限的 `printf`()。
语法
```
UTL_FILE.PUTF (
   file    IN FILE_TYPE,
   format  IN VARCHAR2,
   [arg1   IN VARCHAR2  DEFAULT NULL,
   . . .
   arg5    IN VARCHAR2  DEFAULT NULL]);
```
参数
Table 272-25 PUTF 过程参数
| 参数 | 描述 |
|---|---|
| file | 由 FOPEN 调用返回的活动文件句柄 |
| format | 格式化字符串，可以包含文本以及格式化字符 \n 和 %s |
| arg1..arg5 | 一到五个可操作的参数字符串。参数字符串会按顺序替换格式字符串中的 %s 格式符。如果格式参数字符串中的格式符数量多于参数数量，则对于没有参数对应的每个 %s，将使用空字符串进行替换。 |
用法说明
````
- 如果文件是以字节模式操作打开的，则会引发 INVALID OPERATION 异常。
````
| 字符序列 | 含义 |
|---|---|
| %s | 将此序列替换为参数列表中下一个参数的字符串值。 |
| \n | 替换为相应于特定平台的换行符。 |
- 格式化字符串可以包含任何文本，但字符序列 %s 和 \n 具有特殊含义。
异常
`INVALID_FILEHANDLE`
`INVALID_OPERATION`
`WRITE_ERROR`
示例
以下示例写入以下行：
```
Hello, world!
I come from Zork with greetings for all earthlings.
my_world  varchar2(4) := 'Zork';
...
PUTF(my_handle, 'Hello, world!\nI come from %s with %s.\n',
                my_world,
                'greetings for all earthlings');
```
如果 format 参数中的 `%s` 格式符数量多于参数数量，则对于每个没有匹配参数的 `%s`，将使用空字符串进行替换。
**相关主题**
                           - PUTF_NCHAR 过程

#### PUTF_NCHAR Procedure

此过程是 PUT_NCHAR Procedure 的格式化版本。使用 `PUTF_NCHAR`，您可以以 Unicode 而非数据库字符集写入文本文件。它接受一个包含格式化元素 `\n` 和 `%s` 的格式字符串，以及最多五个参数，用于替换格式字符串中连续出现的 `%s`。格式字符串和参数的预期数据类型为 `NVARCHAR2`。
如果指定了其他数据类型的变量，PL/SQL 将在格式化文本之前执行向 `NVARCHAR2` 的隐式转换。格式化后的文本将以 UTF8 字符集写入由文件句柄标识的文件中。该文件必须以国家字符集模式打开。
语法
```
UTL_FILE.PUTF_NCHAR (
   file    IN FILE_TYPE,
   format  IN NVARCHAR2,
   [arg1   IN NVARCHAR2  DEFAULT NULL,
   . . .
   arg5    IN NVARCHAR2  DEFAULT NULL]);
```
参数
Table 272-26 PUTF_NCHAR Procedure Parameters
| Parameters | Description |
|---|---|
| file | 由 FOPEN_NCHAR 调用返回的活动文件句柄。文件必须以读取模式（mode r）打开。如果文件由 FOPEN 而非 FOPEN_NCHAR 打开，将引发 CHARSETMISMATCH 异常。 |
| format | 格式字符串，可包含文本以及格式化字符 \n 和 %s |
| arg1..arg5 | 一到五个可操作的参数字符串。参数字符串按顺序替换格式字符串中的 %s 格式符。如果格式参数字符串中的格式符数量多于参数数量，则对于没有参数的每个 %s，将替换为空字符串。 |
异常
`INVALID_FILEHANDLE`
`INVALID_OPERATION`
`WRITE_ERROR`
使用说明
``````
- buffer 参数的最大大小为 32767 字节，除非您在 FOPEN 中指定了更小的值。如果未指定，Oracle 将提供默认值 1024。在没有中间缓冲区刷新的情况下，所有连续 PUT 调用的总和不能超过 32767。
````
- 如果文件以字节模式操作打开，将引发 INVALID OPERATION 异常。
**相关主题**
                           - PUT_NCHAR Procedure

#### PUT_RAW 过程

此过程接受一个 `RAW` 数据值作为输入，并将该值写入输出缓冲区。
语法
```
UTL_FILE.PUT_RAW (
   file          IN    UTL_FILE.FILE_TYPE,
   buffer        IN    RAW,
   autoflush     IN    BOOLEAN DEFAULT FALSE);
```
参数
Table 272-27 PUT_RAW 过程参数
| 参数 | 描述 |
|---|---|
| file | 文件句柄 |
| buffer | 写入缓冲区的 RAW 数据 |
| autoflush | 如果为 TRUE，则在将值写入输出缓冲区后执行刷新；默认为 FALSE。 |
异常
`INVALID_FILEHANDLE`
`INVALID_OPERATION`
`WRITE_ERROR`
用法说明
你可以通过将第三个参数设置为 `TRUE` 来请求自动刷新缓冲区。
`buffer` 参数的最大大小为 32767 字节，除非你在 `FOPEN` 中指定了更小的值。如果未指定，Oracle 提供默认值 1024。在没有中间缓冲区刷新的情况下，所有连续 `PUT` 调用的总和不能超过 32767。


---

## DBMS_LOB 详细（机译）

## DBMS_LOB
`DBMS_LOB` 包提供了用于操作 `BLOBs`、`CLOBs`、`NCLOBs`、`BFILEs` 和临时 `LOBs` 的子程序。你可以使用 `DBMS_LOB` 访问和操作 LOB 的特定部分或完整的 LOB。
本章包含以下主题：
- 概述
- 安全模型
- 常量
- 数据类型
- 操作说明
- 规则与限制
- 异常
- DBMS_LOB 子程序摘要
另请参阅：
Oracle Database SecureFiles and Large Objects Developer's Guide
### DBMS_LOB 概述
`DBMS_LOB` 可以读取和修改 `BLOBs`、`CLOBs` 和 `NCLOBs`；它为 `BFILEs` 提供只读操作。大部分 LOB 操作由该包提供。
### DBMS_LOB 弃用的子程序
在 Oracle Database 12c release 12.2 中，`DBMS_LOB` 包弃用了 DBMS_LOB.LOADFROMFILE 程序。
注意：
Oracle 建议不要在新的应用程序中使用已弃用的过程。对已弃用功能的支持仅用于向后兼容。
请改用 DBMS_LOB.LoadClobFromFile 或 DBMS_LOB.LoadBlobFromFile。
### DBMS_LOB 安全模型
此包必须在 `SYS` 下创建。此包提供的操作在当前调用用户下执行，而不是在包所有者 `SYS` 下执行。
从匿名 PL/SQL 块调用的任何 `DBMS_LOB` 子程序都使用当前用户的权限执行。从存储过程调用的任何 `DBMS_LOB` 子程序都使用该存储过程所有者的权限执行。
创建过程时，用户可以设置 `AUTHID` 以指示他们想要定义者权限还是调用者权限。例如：
```
CREATE PROCEDURE proc1 AUTHID DEFINER ...
```
或
```
CREATE PROCEDURE proc1 AUTHID CURRENT_USER ...
```
另请参阅：
有关 `AUTHID` 和权限的更多信息，请参阅 Oracle Database PL/SQL Language Reference
你可以使用 Oracle Database SecureFiles and Large Objects Developer's Guide 和 Oracle Database SQL Language Reference 中 `BFILENAME` 函数讨论的 `DIRECTORY` 功能，来提供对 `BFILEs` 的安全访问。
有关临时 LOB 的安全模型信息，请参阅操作说明。
### DBMS_LOB 常量
本主题描述了 DBMS_LOB 包使用的常量
如下表所示：
- Table 107-1
- Table 107-2
- Table 107-3
- Table 107-4
- Table 107-5
- Table 107-6
Table 107-1 DBMS_LOB 常量 - 基本
| Constant | Type | Value | Description |
|---|---|---|---|
| CALL | PLS_INTEGER | 12 | 以调用持续时间创建 TEMP LOB |
| FILE_READONLY | BINARY_INTEGER | 0 | 以只读方式打开指定的 BFILE |
| LOB_READONLY | BINARY_INTEGER | 0 | 以只读方式打开指定的 LOB |
| LOB_READWRITE | BINARY_INTEGER | 1 | 以读写方式打开指定的 LOB |
| LOBMAXSIZE | INTEGER | 18446744073709551615 | LOB 的最大大小（以字节为单位） |
| SESSION | PLS_INTEGER | 10 | 以会话持续时间创建 TEMP LOB |
Table 107-2 DBMS_LOB 常量 - 选项类型
| Constant | Definition | Value | Description |
|---|---|---|---|
| OPT_COMPRESS | BINARY_INTEGER | 1 | 设置/获取 SECUREFILE 压缩选项值 |
| OPT_DEDUPLICATE | BINARY_INTEGER | 4 | 设置/获取 SECUREFILE 去重选项值 |
| OPT_ENCRYPT | BINARY_INTEGER | 2 | 获取 SECUREFILE 加密选项值 |
Table 107-3 DBMS_LOB 常量 - 选项值
| Constant | Definition | Value | Description |
|---|---|---|---|
| COMPRESS_OFF | BINARY_INTEGER | 0 | 对于 SETOPTIONS 过程，关闭压缩；对于 GETOPTIONS 函数，压缩已关闭 |
| COMPRESS_ON | BINARY_INTEGER | 1 | 对于 SETOPTIONS 过程，打开压缩；对于 GETOPTIONS 函数，压缩已打开 |
| DEDUPLICATE_OFF | BINARY_INTEGER | 0 | 对于 SETOPTIONS 过程，关闭去重；对于 GETOPTIONS 函数，去重已关闭 |
| DEDUPLICATE_ON | BINARY_INTEGER | 4 | 对于 SETOPTIONS 过程，打开去重；对于 GETOPTIONS 函数，去重已打开 |
| ENCRYPT_OFF | BINARY_INTEGER | 0 | 对于 GETOPTIONS 函数，加密已关闭 |
| ENCRYPT_ON | BINARY_INTEGER | 2 | 对于 GETOPTIONS 函数，加密已打开 |
Table 107-4 DBMS_LOB 常量 - DBFS 状态值类型
| Constant | Definition | Value | Description |
|---|---|---|---|
| DBFS_LINK_NEVER | PLS_INTEGER | 0 | LOB 从未被归档 |
| DBFS_LINK_NO | PLS_INTEGER | 2 | LOB 曾被归档，但已被读回 RDBMS |
| DBFS_LINK_YES | PLS_INTEGER | 1 | LOB 当前已被归档 |
Table 107-5 DBMS_LOB 常量 - DBFS 缓存标志
| Constant | Definition | Value | Description |
|---|---|---|---|
| DBFS_LINK_CACHE | PLS_INTEGER | 1 | 将 LOB 数据放入归档，但在 RDBMS 中保留数据作为缓存版本 |
| DBFS_LINK_NOCACHE | PLS_INTEGER | 0 | 将 LOB 数据放入归档，并从 RDBMS 中删除数据。 |
Table 107-6 DBMS_LOB 常量 - 其他
| Constant | Definition | Value | Description |
|---|---|---|---|
| CONTENTTYPE_MAX_SIZE | PLS_INTEGER | 128 | 内容类型字符串允许的最大字节数 |
| DBFS_LINK_PATH_MAX_SIZE | PLS_INTEGER | 1024 | DBFS 路径名的最大长度 |
### DBMS_LOB 数据类型
本主题中的表格描述了 DBMS_LOB 使用的数据类型。
                  .
Table 107-7 DBMS_LOB 使用的数据类型
| Type | Description |
|---|---|
| BLOB | 源或目标二进制 LOB。 |
| RAW | 源或目标 RAW 缓冲区（与 BLOB 一起使用）。 |
| CLOB | 源或目标字符 LOB（包括 NCLOB）。 |
| VARCHAR2 | 源或目标字符缓冲区（与 CLOB 和 NCLOB 一起使用）。 |
| INTEGER | 指定缓冲区或 LOB 的大小、LOB 中的偏移量或要访问的数据量。 |
| BFILE | 存储在数据库外部的大型二进制对象。 |
`DBMS_LOB` 包未定义任何特殊类型。
`NCLOB` 是一种 `CLOB`，用于保存固定宽度和可变宽度的多字节国家字符集。
`DBMS_LOB` 子程序规范中针对 `CLOB` 的 `ANY_CS` 子句使 `CLOB` 类型能够接受 `CLOB` 或 `NCLOB` 定位符变量作为输入。
### DBMS_LOB 操作说明
所有 `DBMS_LOB` 子程序均基于 LOB 定位符工作。为了成功完成 `DBMS_LOB` 子程序，你必须提供一个输入定位符，该定位符代表数据库表空间或外部文件系统中已存在的 LOB。
 另请参阅 Oracle Database SecureFiles and Large Objects Developer's Guide 的第 1 章
从 12.2 版本开始，你可以从远程表中选择持久 LOB 定位符到本地变量中。远程列的类型可以是 BLOB、CLOB 或 NCLOB。你无法从远程表中选择 `BFILE`。引用远程表中 LOB 值的 LOB 变量称为远程定位符。
除了专为 BFILEs 设计的 API 外，所有 `DBMS_LOB` API 现在都将接受并支持对远程 LOB 定位符的操作。所有接受两个定位符的 API 必须确保两个 LOB 位于同一个数据库中。
另请参阅：
Oracle Database SecureFiles and Large Objects Developer's Guide 中的 Distributed LOB 章节。
要在数据库中使用 LOB，你必须首先使用 SQL 数据定义语言 (DDL) 定义包含 LOB 列的表。
- 内部 LOB
- 外部 LOB
- 临时 LOB
内部 LOB
在表中定义 LOB 列后，若要使用内部 LOB 填充表，你需要使用 SQL 数据操作语言 (DML) 来初始化或填充 LOB 列中的定位符。
外部 LOB
要使外部 LOB (BFILE) 由 LOB 定位符表示，你必须：
- 确保已定义代表有效、现有物理目录的 DIRECTORY 对象，并且物理文件（你计划添加的 LOB）存在且数据库具有读权限。如果你的操作系统使用区分大小写的路径名，请确保以正确的格式指定目录。
````
- 将 DIRECTORY 对象和你正在添加的外部 LOB 的文件名传递给 BFILENAME 函数，以为你的外部 LOB 创建一个 LOB 定位符。
完成这些任务后，你可以使用指定的 LOB 定位符插入或更新包含 LOB 列的行。
定义并创建 LOB 之后，你可以从 LOB 定位符 `SELECT` 到本地 PL/SQL LOB 变量中，并将此变量用作 `DBMS_LOB` 的输入参数以访问 LOB 值。
有关执行此操作的不同方法的详细信息，请参阅 Oracle Database SecureFiles and Large Objects Developer's Guide
临时 LOB
数据库支持临时 LOB 的定义、创建、删除、访问和更新。你的临时表空间存储临时 LOB 数据。临时 LOB 不会永久存储在数据库中。它们的目的主要是对 LOB 数据执行转换。
对于临时 LOB，你必须使用 OCI、PL/SQL 或其他编程接口来创建或操作它们。临时 LOB 可以是 `BLOBs`、`CLOBs` 或 `NCLOBs`。
临时 LOB 在创建时为空。默认情况下，所有临时 LOB 都在创建它们的会话结束时被删除。如果进程意外终止或数据库崩溃，临时 LOB 将被删除，并且临时 LOB 的空间将被释放。
还有一个接口可让你将临时 LOB 分组到一个逻辑桶中。持续时间代表此临时 LOB 的逻辑存储。每个临时 LOB 可以具有单独的存储特性，例如 `CACHE`/ `NOCACHE`。每个会话都有一个默认存储区，如果你未指定特定持续时间，临时 LOB 将被放入其中。此外，你可以对持续时间执行释放操作，这将导致持续时间内的所有内容被释放。
临时 LOB 不支持一致读 (CR)、撤销、备份、并行处理或事务管理。因为临时 LOB 不支持 CR 和回滚，如果遇到错误，你必须释放临时 LOB 并重新开始。
由于不为临时 LOB 生成 CR、撤销和版本，如果将多个定位符分配给同一个临时 LOB，可能会对性能产生影响。在语义上，每个定位符都应该有其自己的临时 LOB 副本。
如果用户在另一个定位符也指向临时 LOB 时修改该临时 LOB，则会创建该临时 LOB 的副本。执行修改的定位符现在指向临时 LOB 的新副本。其他定位符不再能看到与进行修改的定位符相同的数据。在这些情况下，永久 LOB 不会产生深拷贝，因为 CR 快照和版本页使用户能够以低成本看到他们自己的 LOB 版本。
通过在 OCI 中使用指向定位符的指针，并在必要时让多个指向定位符的指针指向同一个临时 LOB 定位符，你可以获得伪 `REF` 语义。在 PL/SQL 中，你必须避免为每个临时 LOB 使用多个定位符。临时 LOB 定位符可以通过引用传递给其他过程。
由于临时 LOB 不与任何表模式关联，因此行内和行外临时 LOB 这些术语没有意义。用户创建临时 LOB 实例会促使引擎创建并向该 LOB 数据返回一个定位符。PL/SQL `DBMS_LOB` 包、PRO*C/C++、OCI 和其他编程接口通过这些定位符操作临时 LOB，就像它们操作永久 LOB 一样。
不支持客户端临时 LOB。所有临时 LOB 都驻留在服务器上。
临时 LOB 不支持永久 LOB 支持的 `EMPTY_BLOB` 或 `EMPTY_CLOB` 函数。`EMPTY_BLOB` 函数表明 LOB 已初始化，但未填充任何数据。
临时 LOB 实例只能通过使用 OCI 或 `DBMS_LOB` 包中的适当 `FREETEMPORARY` 或 `OCIDurationEnd` 语句来销毁。
可以使用适当的 OCI 和 `DBMS_LOB` 语句访问和修改临时 LOB 实例，就像常规的永久内部 LOB 一样。要使临时 LOB 成为永久 LOB，你必须显式使用 OCI 或 `DBMS_LOB` 的 `COPY` 命令，并将临时 LOB 复制到永久 LOB 中。
安全性通过 LOB 定位符提供。只有创建临时 LOB 的用户才能看到它。定位符不应从一个用户的会话传递到另一个用户的会话。即使有人确实将定位符从一个会话传递到另一个会话，他们也无法从原始会话访问临时 LOB。临时 LOB 查找局限于每个用户自己的会话。使用来自其他地方的定位符的人只能访问他自己会话中具有相同 LOB ID 的 LOB。用户不应尝试这样做，但如果他们这样做了，他们也无法影响其他任何人的数据。
数据库在一个名为 `V$TEMPORARY_LOBS` 的 `v$` 视图中跟踪每个会话的临时 LOB，该视图包含有关每个会话存在多少临时 LOB 的信息。`V$` 视图供 DBA 使用。通过会话，数据库可以确定哪个用户拥有临时 LOB。通过将 `V$TEMPORARY_LOBS` 与 `DBA_SEGMENTS` 结合使用，DBA 可以查看会话为临时 LOB 使用的空间量。DBA 可以使用这些表来监视和指导对临时 LOB 使用的临时空间的任何紧急清理。
以下注意事项特定于临时 LOB：
``````````
- 如果任何输入参数为 NULL，则 DBMS_LOB 中的所有函数均返回 NULL。如果 LOB 定位符输入为 NULL，则 DBMS_LOB 中的所有过程都会引发异常。
``````
- 基于 CLOBs 的操作不验证参数（CLOB 参数、VARCHAR2 缓冲区和模式等）的字符集 ID 是否匹配。确保这一点是用户的责任。
- DBA 通过创建不同的临时表空间来控制数据存储资源。如有必要，DBA 可以为不同的用户定义单独的临时表空间。
另请参阅：
Oracle Database PL/SQL Language Reference，了解有关 `NOCOPY` 语法的更多信息
### DBMS_LOB 规则与限制
本主题描述了 DBMS_LOB 的一般规则与限制、特定于外部文件 (BFILEs) 的规则与限制，以及最大的 LOB 和缓冲区大小。
一般规则与限制
- Oracle 数据库不支持对类型为 LOB 的列或属性进行约束，但以下情况例外：LOB 列或属性支持 NOT NULL 约束。
``````````
  - 操作 BLOBs 和 BFILEs 的子程序的 newlen、offset 和 amount 参数必须以字节为单位指定。
````````
  - 操作 CLOBs 的子程序的 newlen、offset 和 amount 参数必须以字符为单位指定。
在多字节字符集中，无法正确解释这些偏移量。因此，`SUBSTR` 会引发以下错误：`ORA-22998: CLOB or NCLOB in multibyte character set not supported`。
  - 仅允许从 LOB 数据开头算起的正、绝对偏移量：不允许从 LOB 尾部算起的负偏移量。
````````
  - 对于表示大小和位置数量的参数，例如 amount、offset、newlen、nth 等，仅允许正值和非零值。不允许使用 SQL 字符串函数和运算符中出现的负偏移量和范围。
````````````
  - 在任何 DBMS_LOB 子程序中，offset、amount、newlen、nth 的值不得超过 lobmaxsize 的值 18446744073709551615 (264)。
````````
```
JA16SJISFIXED
```
```
18446744073709551615/2 = 9223372036854775807
```
  - 对于由固定宽度多字节字符组成的 CLOB，这些参数的最大值不得超过 (lobmaxsize/character_width_in_bytes) 个字符。例如，如果 CLOB 由 2 字节字符组成，例如：那么，最大 amount 值不应超过：
``````
```
charbuf VARCHAR2(3000)
```
````````
- PL/SQL 语言规范规定 DBMS_LOB 子程序中使用的 RAW 和 VARCHAR2 参数的上限为 32767 字节（而不是字符）。例如，如果你将变量声明为：那么，charbuf 可以容纳 3000 个单字节字符或 1500 个 2 字节固定宽度字符。这对于 CLOBs 和 NCLOBs 的 DBMS_LOB 子程序具有重要影响。
``````
````````````````
``````````
- %CHARSET 子句指示带有 %CHARSET 的参数形式必须与它所引用的 ANY_CS 参数的形式匹配。例如，在采用 VARCHAR2 缓冲区参数的 DBMS_LOB 子程序中，VARCHAR2 缓冲区的形式必须与 CLOB 参数的形式匹配。如果输入 LOB 参数的类型为 NCLOB，则缓冲区必须包含 NCHAR 数据。反之，如果输入 LOB 参数的类型为 CLOB，则缓冲区必须包含 CHAR 数据。对于采用两个 CLOB 参数的 DBMS_LOB 子程序，两个 CLOB 参数必须具有相同的形式；即，它们必须都是 NCLOBs，或者必须都是 CLOBs。
````
``````````````````````
- 如果 amount 加上 offset 的值超过了数据库允许的最大 LOB 大小，则会引发访问异常。在这些输入条件下，读取子程序（如 READ、COMPARE、INSTR 和 SUBSTR）会读取直到到达 LOB/文件末尾。例如，对于大小为 4GB 的 LOB 上的 BLOB 或 BFILE 的 READ 操作，如果用户指定 offset 值为 3 GB 且 amount 值为 2 GB，则 READ 仅返回 1GB (4GB-3GB) 字节。
``````


#### APPEND 过程

此过程将源内部 LOB 的内容追加到目标 LOB 中。它会追加完整的源 LOB。
语法
```
DBMS_LOB.APPEND (
   dest_lob IN OUT  NOCOPY BLOB,
   src_lob  IN             BLOB);
DBMS_LOB.APPEND (
   dest_lob IN OUT  NOCOPY CLOB  CHARACTER SET ANY_CS,
   src_lob  IN             CLOB  CHARACTER SET dest_lob%CHARSET);
```
参数
表 107-10 APPEND 过程参数
| 参数 | 说明 |
|---|---|
| dest_lob | 要将数据追加到的内部 LOB 的定位器。 |
| src_lob | 要从中读取数据的内部 LOB 的定位器。 |
异常
表 107-11 APPEND 过程异常
| 异常 | 说明 |
|---|---|
| VALUE_ERROR | 源或目标 LOB 为 NULL。 |
| QUERY_WRITE | 无法在查询或 PDML 并行执行服务器内部执行 LOB 写入 |
| BUFFERING_ENABLED | 如果任一 LOB 启用了缓冲，则无法在启用 LOB 缓冲的情况下执行操作 |
用法说明
````
- 不强制要求将 LOB 操作封装在 Open/Close 接口中。如果在执行操作之前未打开 LOB，则在调用期间会更新 LOB 列上的函数索引和域索引。但是，如果在执行操作之前打开了 LOB，则必须在提交事务之前将其关闭。当内部 LOB 关闭时，它会更新 LOB 列上的函数索引和域索引。如果不将 LOB 操作封装在 Open/Close API 中，则每次写入 LOB 时都会更新函数索引和域索引。这可能会对性能产生不利影响。因此，建议将对 LOB 的写操作包含在 OPEN 或 CLOSE 语句中。
- 如果对已归档的 LOB 调用 APPEND，它会在写入第一个字节之前隐式获取该 LOB
- 如果对作为 DBFS 链接的 SecureFiles LOB 调用 APPEND，则会引发异常。
另请参阅：
Oracle Database SecureFiles and Large Objects Developer's Guide 获取有关此过程用法的更多详细信息

#### CLOB2FILE Procedure

此过程将 `CLOB` 的内容写入 `bfile`。此过程在内部由已弃用的 `dbms_xslprocessor.clob2file` 调用。
语法
```
DBMS_LOB.CLOB2FILE(
   src_cl      IN  CLOB,
   file_loc    IN  VARCHAR2,
   file_name   IN  VARCHAR2,
   csid        IN  NUMBER   := 0,
   open_mode   IN  VARCHAR2 :='wb');
```
参数
Table 107-12 CLOB2FILE Procedure Parameters
| Parameter | Description |
|---|---|
| src_cl | 要写入文件的源 CLOB 定位符 |
| file_loc | 文件所在目录的对象名称 |
| file_name | 文件名 |
| csid | CLOB 定位符的字符集 ID，必须是有效的 Oracle ID；否则返回错误。如果值为 0，则输出文件的内容将采用数据库字符集 |
| open_mode | 打开输出文件的模式。wb — 字节写入模式，覆盖文件。默认值为 wb。 |

#### CLOSE 过程

此过程关闭先前打开的内部或外部 LOB。
语法
```
DBMS_LOB.CLOSE (
   lob_loc    IN OUT NOCOPY BLOB);
DBMS_LOB.CLOSE (
   lob_loc    IN OUT NOCOPY CLOB CHARACTER SET ANY_CS);
DBMS_LOB.CLOSE (
   file_loc   IN OUT NOCOPY BFILE);
```
参数
Table 107-13 CLOSE 过程参数
| Parameter | Description |
|---|---|
| lob_loc | LOB 定位器。有关更多信息，请参阅操作说明。 |
异常
如果 `BFILE` 存在但未打开，不会返回错误。如果 LOB 未打开，则会返回错误。
用法说明
对于内部和外部 LOB，`CLOSE` 都需要与服务器进行一次往返。对于内部 LOB，`CLOSE` 会触发依赖该关闭调用的其他代码；对于外部 LOB（`BFILEs`），`CLOSE` 会实际关闭服务器端的操作系统文件。
并非必须将所有 LOB 操作都包装在 Open/Close 接口中。但是，如果打开了 LOB，必须在提交事务之前关闭它；否则将产生错误。当内部 LOB 被关闭时，它会更新 LOB 列上的函数索引和域索引。
在关闭由该事务打开的所有已打开的 LOB 之前提交事务是一个错误。返回该错误时，已打开 LOB 的打开状态将被丢弃，但事务会成功提交。因此，事务中对 LOB 和非 LOB 数据所做的所有更改都会被提交，但域索引和基于函数的索引不会被更新。如果发生这种情况，应重新构建 LOB 列上的函数索引和域索引。
另请参阅：
Oracle Database SecureFiles and Large Objects Developer's Guide，了解有关此过程用法的更多详细信息

#### COMPARE 函数

此函数比较两个完整的 LOB 或两个 LOB 的部分内容。
语法
```
DBMS_LOB.COMPARE (
   lob_1            IN BLOB,
   lob_2            IN BLOB,
   amount           IN INTEGER := DBMS_LOB.LOBMAXSIZE,
   offset_1         IN INTEGER := 1,
   offset_2         IN INTEGER := 1)
  RETURN INTEGER;
DBMS_LOB.COMPARE (
   lob_1            IN CLOB  CHARACTER SET ANY_CS,
   lob_2            IN CLOB  CHARACTER SET lob_1%CHARSET,
   amount           IN INTEGER := DBMS_LOB.LOBMAXSIZE,
   offset_1         IN INTEGER := 1,
   offset_2         IN INTEGER := 1)
  RETURN INTEGER;
DBMS_LOB.COMPARE (
   lob_1            IN BFILE,
   lob_2            IN BFILE,
   amount           IN INTEGER,
   offset_1         IN INTEGER := 1,
   offset_2         IN INTEGER := 1)
  RETURN INTEGER;
```
Pragmas
```
pragma restrict_references(COMPARE, WNDS, WNPS, RNDS, RNPS);
```
参数
表 107-14 COMPARE 函数参数
| 参数 | 描述 |
|---|---|
| lob_1 | 用于比较的第一个目标的 LOB 定位器。 |
| lob_2 | 用于比较的第二个目标的 LOB 定位器。 |
| amount | 要比较的字节数（对于 BLOB）或字符数（对于 CLOB/NCLOB）。 |
| offset_1 | 第一个 LOB 上用于比较的字节或字符偏移量（起始值：1）。 |
| offset_2 | 第二个 LOB 上用于比较的字节或字符偏移量（起始值：1）。 |
返回值
- INTEGER：如果比较成功则为 0，否则为非零值。
``````````
- NULL，如果 amount、offset_1 或 offset_2 中任何一个不是有效的 LOB 偏移值。有效的偏移量在 1 到 LOBMAXSIZE（含）范围内。
使用注意事项
``````````````````
- 只能比较相同数据类型的 LOB（BLOB 类型的 LOB 与其他 BLOB 比较，CLOB 与 CLOB 比较，BFILE 与 BFILE 比较）。对于 BFILE，文件必须已经通过成功的 FILEOPEN 操作打开，此操作才能成功。
``````````
- 如果数据在由 offset 和 amount 参数指定的范围内完全匹配，则 COMPARE 返回 0。如果第一个 CLOB 小于第二个，则 COMPARE 返回 -1，如果大于则返回 1。
``````````````
- 对于固定宽度 n-byte CLOB，如果为 COMPARE 指定的输入 amount 大于 (DBMS_LOB.LOBMAXSIZE/n)，则 COMPARE 将在 (DBMS_LOB.LOBMAXSIZE/n) 或 Max(length(clob1), length(clob2)) 的大小范围内匹配字符，取两者中较小的一个。
- 如果对任何已归档的 LOB 调用 COMPARE，它会在比较开始前隐式获取该 LOB。
- 如果对作为 DBFS Link 的 SecureFiles LOB 调用 COMPARE()，如果可能，链接的 LOB 将从 DBFS 流式传输，否则抛出异常。
异常
表 107-15 BFILE 操作的 COMPARE 函数异常
| 异常 | 描述 |
|---|---|
| UNOPENED_FILE | 文件未使用输入定位器打开。 |
| NOEXIST_DIRECTORY | 目录不存在。 |
| NOPRIV_DIRECTORY | 您没有该目录的权限。 |
| INVALID_DIRECTORY | 目录在文件打开后已失效。 |
| INVALID_OPERATION | 文件不存在，或者您没有该文件的访问权限。 |
| BUFFERING_ENABLED | 如果任一 LOB 启用了缓冲，则无法在启用 LOB 缓冲的情况下执行此操作 |
另请参见：
Oracle Database SecureFiles and Large Objects Developer's Guide，了解有关此过程使用的更多详细信息

#### CONVERTTOBLOB Procedure

此过程从源 `CLOB` 或 `NCLOB` 实例读取字符数据，将字符数据转换为您指定的字符集，以二进制格式将转换后的数据写入目标 `BLOB` 实例，并返回新的偏移量。
您可以将此接口用于作为源或目标的持久或临时 LOB 实例的任何组合。
语法
```
DBMS_LOB.CONVERTTOBLOB(
  dest_lob       IN OUT     NOCOPY  BLOB,
  src_clob       IN         CLOB CHARACTER SET ANY_CS,
  amount         IN         INTEGER,
  dest_offset    IN OUT     INTEGER,
  src_offset     IN OUT     INTEGER,
  blob_csid      IN         NUMBER,
  lang_context   IN OUT     INTEGER,
  warning        OUT        INTEGER);
```
参数
表 107-16 CONVERTTOBLOB Procedure Parameters
| Parameter | Description |
|---|---|
| dest_lob | 目标 LOB 实例的 LOB 定位器。 |
| src_clob | 源 LOB 实例的 LOB 定位器。 |
| amount | 要从源 LOB 转换的字符数。如果要复制整个 LOB，请传入常量 DBMS_LOB.LOBMAXSIZE。如果传入任何其他值，则该值必须小于或等于 LOB 的大小。 |
| dest_offset | (IN) 目标 LOB 中开始写入处的字节偏移量。指定值为 1 表示从 LOB 的开头开始。(OUT) 写入结束后的新字节偏移量。 |
| src_offset | (IN) 源 LOB 中开始读取处的字符偏移量。(OUT) 读取结束后源 LOB 中的字符偏移量。 |
| blob_csid | 转换后数据所需的目标字符集 ID。 |
| lang_context | (IN) 当前转换的语言上下文，例如移位状态。(OUT) 当前转换完成时的语言上下文。返回此信息是为了让您可以在后续转换中使用它，而不会丢失或误解任何源数据。对于第一次转换，或者如果您不在乎，请使用默认值零。 |
| warning | (OUT) 警告消息。此参数指示在转换过程中是否发生了异常情况。您有责任检查警告消息。目前，唯一可能的警告是不可转换字符。当源中的字符无法正确转换为目标中的字符时，就会发生这种情况。将使用默认替换字符（例如 '?'）来代替不可转换的字符。此错误消息的返回值在 DBMS_LOB 包中被定义为常量 warn_inconvertible_char。 |
用法说明
前提条件
在调用 `CONVERTTOBLOB` 过程之前，必须满足以下前提条件：
- 源和目标 LOB 实例都必须存在。
``````
- 如果目标 LOB 是持久 LOB，则必须锁定该行。要锁定该行，请使用 SELECT 语句的 FOR UPDATE 子句选择该 LOB。
常量与默认值
所有参数均为必填。您必须为每个 `OUT` 或 `IN OUT` 参数传入一个变量。您必须为每个 `IN` 参数传入一个变量或一个值。
表 107-17 总结了每个参数的典型值。第一列列出了参数，第二列列出了典型值，最后一列描述了传入该值的结果。请注意，某些值使用了常量。这些常量定义在 `dbmslob.sql` 包规范文件中。
表 107-17 DBMS_LOB.CONVERTTOBLOB Typical Values
| Parameter | Value | Description |
|---|---|---|
| amount | LOBMAXSIZE (IN) | 转换整个文件 |
| dest_offset | 1 (IN) | 从头开始 |
| src_offset | 1 (IN) | 从头开始 |
| blob_csid | DEFAULT_CSID (IN) | 默认 CSID，使用与源 LOB 相同的 CSID |
| lang_context | DEFAULT_LANG_CTX (IN) | 默认语言上下文 |
| warning | NO_WARNING (OUT) WARN_INCONVERTIBLE_CHAR (OUT) | 无警告消息，成功 源中的字符无法正确转换 |
一般说明
````
- 您必须在 blob_csid 参数中指定目标 LOB 所需的字符集。您可以为 blob_csid 传入零值。当您这样做时，数据库会假定所需的字符集与源 LOB 字符集相同。
``````````
- 您必须指定源和目标 LOB 的偏移量，以及要从源 LOB 复制的字符数。amount 和 src_offset 值以字符为单位，而 dest_offset 以字节为单位。要转换整个 LOB，您可以为 amount 参数指定 LOBMAXSIZE。
- CONVERTTOBLOB 在转换和写入数据之前，会根据需要获取源和/或目标 LOB。
异常
表 107-18 列出了此过程可能抛出的异常。第一列列出了异常字符串，第二列描述了可能导致该异常的错误条件。
表 107-18 CONVERTTOBLOB Procedure Exceptions
| Exception | Description |
|---|---|
| VALUE_ERROR | 任何输入参数为 NULL 或 INVALID。 |
| INVALID_ARGVAL | 以下一项或多项： - src_offset 或 dest_offset < 1。 - src_offset 或 dest_offset > LOBMAXSIZE。 - amount < 1。 - amount > LOBMAXSIZE。 |
另请参阅：
Oracle Database SecureFiles and Large Objects Developer's Guide，了解有关在应用程序开发中使用 LOB 的更多信息

#### CONVERTTOCLOB 过程

此过程接收一个源 `BLOB` 实例，使用您指定的字符集将源实例中的二进制数据转换为字符数据，将字符数据写入目标 `CLOB` 或 `NCLOB` 实例，并返回新的偏移量。
您可以将此接口用于作为源或目标的持久或临时 LOB 实例的任意组合。
语法
```
DBMS_LOB.CONVERTTOCLOB(
   dest_lob       IN OUT NOCOPY  CLOB CHARACTER SET ANY_CS,
   src_blob       IN             BLOB,
   amount         IN             INTEGER,
   dest_offset    IN OUT         INTEGER,
   src_offset     IN OUT         INTEGER,
   blob_csid      IN             NUMBER,
   lang_context   IN OUT         INTEGER,
   warning        OUT            INTEGER);
```
参数
表 107-19 CONVERTTOCLOB 过程参数
| 参数 | 描述 |
|---|---|
| dest_lob | 目标 LOB 实例的 LOB 定位符。 |
| src_blob | 源 LOB 实例的 LOB 定位符。 |
| amount | 要从源 LOB 转换的字节数。如果要复制整个 BLOB，请传入常量 DBMS_LOB.LOBMAXSIZE。如果传入任何其他值，则该值必须小于或等于 BLOB 的大小。 |
| dest_offset | (IN) 目标 LOB 中开始写入的字符偏移量。指定值为 1 表示从 LOB 的起始位置开始。(OUT) 写入结束后新的字符偏移量。此偏移量始终指向写入结束后第一个完整字符的起始位置。 |
| src_offset | (IN) 源 LOB 中开始读取的字节偏移量。(OUT) 读取结束后源 LOB 中的字节偏移量。 |
| blob_csid | 源数据的字符集 ID。 |
| lang_context | (IN) 当前转换的语言上下文，例如移位状态。(OUT) 当前转换完成时的语言上下文。返回此信息是为了让您可以在后续转换中使用它，而不会丢失或误解任何源数据。对于第一次转换，或者如果不在意，请使用默认值零。 |
| warning | 警告消息。此参数指示在转换期间是否发生了异常情况。您有责任检查警告消息。目前，唯一可能的警告是不可转换字符。当源中的字符无法正确转换为目标中的字符时，就会发生这种情况。将使用默认替换字符（例如 '?'）来代替不可转换的字符。此错误消息的返回值在 DBMS_LOB 包中被定义为常量 warn_inconvertible_char。 |
使用注意事项
前置条件
在调用 `CONVERTTOCLOB` 过程之前，必须满足以下前置条件：
- 源和目标 LOB 实例都必须存在。
``````
- 如果目标 LOB 是持久 LOB，则在调用 CONVERTTOCLOB 过程之前必须锁定该行。要锁定该行，请使用 SELECT 语句的 FOR UPDATE 子句查询该 LOB。
常量与默认值
所有参数均为必填项。您必须为每个 `OUT` 或 `IN OUT` 参数传入一个变量。您必须为每个 `IN` 参数传入一个变量或一个值。
表 107-20 总结了各参数的典型值。第一列列出参数，第二列列出典型值，最后一列描述传入该值的结果。请注意，某些值使用了常量。这些常量定义在 `dbmslob.sql` 包规范文件中。
表 107-20 DBMS_LOB.CONVERTTOCLOB 典型值
| 参数 | 值 | 描述 |
|---|---|---|
| amount | LOBMAXSIZE (IN) | 转换整个文件 |
| dest_offset | 1 (IN) | 从起始位置开始 |
| src_offset | 1 (IN) | 从起始位置开始 |
| csid | DEFAULT_CSID (IN) | 默认 CSID，使用目标 CSID |
| lang_context | DEFAULT_LANG_CTX (IN) | 默认语言上下文 |
| warning | NO_WARNING (OUT) WARN_INCONVERTIBLE_CHAR (OUT) | 无警告消息，成功 源中的字符无法正确转换 |
一般注意事项
````
- 您必须在 blob_csid 参数中指定源 LOB 所需的字符集。您可以为 blob_csid 传入零值。当您这样做时，数据库会假定所需字符集与目标 LOB 字符集相同。
``````````
- 您必须指定源和目标 LOB 的偏移量，以及要从源 LOB 复制的字符数。amount 和 src_offset 值以字节为单位，而 dest_offset 以字符为单位。要转换整个 LOB，您可以为 amount 参数指定 LOBMAXSIZE。
- CONVERTTOCLOB 会在转换和写入数据之前根据需要获取源和/或目标 LOB。
异常
表 107-21 CONVERTTOCLOB 过程异常
| 异常 | 描述 |
|---|---|
| VALUE_ERROR | 任何输入参数为 NULL 或 INVALID。 |
| INVALID_ARGVAL | 以下一项或多项： - src_offset 或 dest_offset < 1。 - src_offset 或 dest_offset > LOBMAXSIZE。 - amount < 1。 - amount > LOBMAXSIZE。 |
另请参阅：
《Oracle Database SecureFiles and Large Objects Developer's Guide》，获取有关在应用程序开发中使用 LOB 的更多信息

#### COPY Procedures

此过程将源内部 LOB 的全部或部分复制到目标内部 LOB。您可以指定源 LOB 和目标 LOB 的偏移量，以及要复制的字节数或字符数。
语法
```
DBMS_LOB.COPY (
  dest_lob    IN OUT NOCOPY BLOB,
  src_lob     IN            BLOB,
  amount      IN            INTEGER,
  dest_offset IN            INTEGER := 1,
  src_offset  IN            INTEGER := 1);
DBMS_LOB.COPY (
  dest_lob    IN OUT NOCOPY CLOB  CHARACTER SET ANY_CS,
  src_lob     IN            CLOB  CHARACTER SET dest_lob%CHARSET,
  amount      IN            INTEGER,
  dest_offset IN            INTEGER := 1,
  src_offset  IN            INTEGER := 1);
```
参数
Table 107-22 COPY Procedure Parameters
| Parameter | Description |
|---|---|
| dest_lob | 复制目标的 LOB 定位符。 |
| src_lob | 复制源的 LOB 定位符。 |
| amount | 要复制的字节数（对于 BLOB）或字符数（对于 CLOB）。 |
| dest_offset | 目标 LOB 中开始复制的偏移量（以字节或字符为单位，起始值为 1）。 |
| src_offset | 源 LOB 中开始复制的偏移量（以字节或字符为单位，起始值为 1）。 |
异常
Table 107-23  COPY Procedure Exceptions
| Exception | Description |
|---|---|
| VALUE_ERROR | 任何输入参数为 NULL 或无效。 |
| INVALID_ARGVAL | 满足以下任一条件： - src_offset 或 dest_offset < 1 - src_offset 或 dest_offset > LOBMAXSIZE - amount < 1 - amount > LOBMAXSIZE |
| QUERY_WRITE | 无法在查询或 PDML 并行执行服务器内执行 LOB 写入 |
| BUFFERING_ENABLED | 如果任一 LOB 启用了缓冲，则在启用缓冲的情况下无法执行操作 |
使用注意事项
````
- 如果您在目标 LOB 中指定的偏移量超出了该 LOB 中当前数据的末尾，则会在目标 BLOB 或 CLOB 中分别插入零字节填充符或空格。如果偏移量小于目标 LOB 的当前长度，则会覆盖现有数据。
- 指定的数量超过源 LOB 中数据的长度不会被视为错误。因此，您可以指定一个较大的数量从源 LOB 进行复制，这会将数据从 src_offset 复制到源 LOB 的末尾。
- 您并非必须将 LOB 操作封装在 Open/Close 接口内。如果您在执行操作前未打开 LOB，则在调用期间会更新 LOB 列上的函数索引和域索引。但是，如果您在执行操作前打开了 LOB，则必须在提交事务前关闭它。当内部 LOB 关闭时，它会更新 LOB 列上的函数索引和域索引。
````
- 如果您未将 LOB 操作封装在 Open/Close API 内，则每次写入 LOB 时都会更新函数索引和域索引。这可能会对性能产生不利影响。因此，建议您将对 LOB 的写操作包含在 OPEN 或 CLOSE 语句中。
- 复制前，如果源 LOB 和目标 LOB 当前已归档，则会检索它们。对于完全覆盖，不检索目标 LOB。
- 如果源 LOB 是 DBFS Link，则尽可能从 DBFS 流式传输数据，否则抛出异常。如果目标 LOB 是 DBFS Link，则抛出异常。
另请参阅：
Oracle Database SecureFiles and Large Objects Developer's Guide 获取有关此过程使用的更多详细信息

#### COPY_DBFS_LINK 过程

此过程将源 LOB 中的 DBFS Link 复制到目标 LOB。
语法
```
DBMS_LOB.COPY_DBFS_LINK (
  lob_loc_dst    IN OUT BLOB,
  lob_loc_src    IN     BLOB,
  flags          IN     PLS_INTEGER DEFAULT DBFS_LINK_NOCACHE);
DBMS_LOB.COPY_DBFS_LINK (
  lob_loc_dst    IN OUT CLOB CHARACTER SET ANY_CS,
  lob_loc_src    IN     CLOB CHARACTER SET ANY_CS,
  flags          IN     PLS_INTEGER DEFAULT DBFS_LINK_NOCACHE);
```
参数
表 107-24 COPY_DBFS_LINK 过程参数
| 参数 | 描述 |
|---|---|
| lob_loc_dst | 要使其引用与 lob_loc_src 相同存储数据的 LOB |
| lob_loc_src | 要从中复制引用的 LOB |
| flags | COPY_DBFS_LINK 的选项：DBFS_LINK_NOCACHE 指定仅复制 DBFS Link DBFS_LINK_CACHE 指定复制 DBFS Link 并将数据读入由 lob_loc_dst 指定的数据库 LOB 中，以便缓存数据 |
异常
表 107-25 COPY_DBFS_LINK 过程异常
| 异常 | 描述 |
|---|---|
| SECUREFILE_BADLOB | lob_loc_src 或 lob_loc_dst 不是 SECUREFILE |
| INVALID_ARGVAL | lob_loc_src LOB 尚未归档 |
| ORA-01555 | 如果源 LOB 已被取回但从未归档，或者如果自获取定位器以来 LOB 已被迁入和迁出（无论是否修改过）。 |

#### COPY_FROM_DBFS_LINK

此过程从 DBFS HSM 存储中检索已归档的 SecureFiles LOB 数据并存入数据库。
语法
```
DBMS_LOB.COPY_FROM_DBFS_LINK (
  lob_loc       IN OUT BLOB);
DBMS_LOB.COPY_FROM_DBFS_LINK (
  lob_loc       IN OUT CLOB CHARACTER SET ANY_CS);
```
参数
表 107-26 COPY_FROM_DBFS_LINK 过程参数
| Parameter | Description |
|---|---|
| lob_loc | 要从归档中检索的 LOB |
使用说明
`COPY_FROM_DBFS_LINK` 不会删除底层的 DBFS 文件。
如果 LOB 成功检索，`COPY_FROM_DBFS_LINK` 将静默返回成功。
异常
表 107-27 COPY_FROM_DBFS_LINK 过程异常
| Exception | Description |
|---|---|
| SECUREFILE_BADLOB | lob_loc 不是 SECUREFILE |
| ORA-01555 | 如果 LOB 已经被检索并且自检索后已被修改；如果自定位器被检索以来，LOB 已经被移入和移出（无论是否修改过） |

#### CREATETEMPORARY 过程

此过程在默认临时表空间中创建临时 `BLOB` 或 `CLOB` 及其对应的索引。
语法
```
DBMS_LOB.CREATETEMPORARY (
   lob_loc IN OUT NOCOPY BLOB,
   cache   IN            BOOLEAN,
   dur     IN            PLS_INTEGER := DBMS_LOB.SESSION);
DBMS_LOB.CREATETEMPORARY (
   lob_loc IN OUT NOCOPY CLOB CHARACTER SET ANY_CS,
   cache   IN            BOOLEAN,
   dur     IN            PLS_INTEGER := 10);
```
参数
表 107-28 CREATETEMPORARY 过程参数
| 参数 | 描述 |
|---|---|
| lob_loc | LOB 定位符。了解更多信息，请参见“操作说明”。 |
| cache | 指定是否将 LOB 读入缓冲区缓存。 |
| dur | 2 个预定义持续时间值（SESSION 或 CALL）中的 1 个，用于提供提示，指示临时 LOB 是在会话或调用结束时清理。如果省略 dur，则使用会话持续时间。 |
另请参见：
- Oracle Database SecureFiles and Large Objects Developer's Guide，了解有关此过程用法的更多细节
- Oracle Database PL/SQL Language Reference，了解有关 NOCOPY 以及将临时 lobs 作为参数传递的更多信息

#### DBFS_LINK_GENERATE_PATH 函数

此子程序返回一个唯一的文件路径名，用于创建 DBFS Link。
语法
```
DBMS_LOB.DBFS_LINK_GENERATE_PATH (
  lob_loc       IN BLOB,
  storage_dir   IN VARCHAR2)
 RETURN VARCHAR2;
DBMS_LOB.DBFS_LINK_GENERATE_PATH (
  lob_loc       IN CLOB CHARACTER SET ANY_CS,
  storage_dir   IN VARCHAR2)
 RETURN VARCHAR2;
```
编译指示
```
PRAGMA RESTRICT_REFERENCES(dbfs_link_generate_path,
       WNDS, RNDS, WNPS, RNPS);
```
参数
Table 107-29 DBFS_LINK_GENERATE_PATH 函数参数
| 参数 | 描述 |
|---|---|
| lob_loc | 要从 DBFS 检索的 LOB |
| storage_dir | 将作为文件父目录的 DBFS 目录 |
异常
Table 107-30 DBFS_LINK_GENERATE_PATH 函数异常
| 异常 | 描述 |
|---|---|
| SECUREFILE_WRONGTYPE | lob_loc 不是 SECUREFILE |
使用说明
返回可用于归档的全局唯一文件路径名。对于不同的 LOB 及该 LOB 的不同版本，确保在对此函数的所有调用中该路径名全局唯一。对于相同的 LOB 及相同版本，该路径名始终相同。

#### ERASE 过程

此过程擦除整个内部 LOB 或部分内部 LOB。

语法
```
DBMS_LOB.ERASE (
   lob_loc           IN OUT   NOCOPY   BLOB,
   amount            IN OUT   NOCOPY   INTEGER,
   offset            IN                INTEGER := 1);
DBMS_LOB.ERASE (
   lob_loc           IN OUT   NOCOPY   CLOB CHARACTER SET ANY_CS,
   amount            IN OUT   NOCOPY   INTEGER,
   offset            IN                INTEGER := 1);
```

参数
表 107-31 ERASE 过程参数
| 参数 | 描述 |
|---|---|
| lob_loc | 要擦除的 LOB 的定位符。更多信息，请参见操作说明。 |
| amount | 要擦除的字节数（对于 BLOB 或 BFILES）或字符数（对于 CLOB 或 NCLOB）。 |
| offset | 从 LOB 开头开始的绝对偏移量（起始值为 1），以字节（对于 BLOB）或字符（对于 CLOB）为单位。 |

使用注意事项
````
- 当从 LOB 中间擦除数据时，会分别为 BLOB 或 CLOB 写入零字节填充符或空格。
````
- 如果在擦除指定数量之前达到了 LOB 值的末尾，实际擦除的字节或字符数可能与您在 amount 参数中指定的数量不同。实际擦除的字符或字节数会通过 amount 参数返回。
- 如果 LOB 已归档，ERASE 会获取该 LOB，除非擦除操作覆盖了整个 LOB。
- 如果要擦除的 LOB 是 DBFS Link，则会抛出异常。

注意：
擦除 LOB 的某一部分时，LOB 的长度不会减少。要减少 LOB 值的长度，请参见“TRIM 过程”。

异常
表 107-32 ERASE 过程异常
| 异常 | 描述 |
|---|---|
| VALUE_ERROR | 任何输入参数为 NULL。 |
| INVALID_ARGVAL | 满足以下任一条件： - amount < 1 或 amount > LOBMAXSIZE - offset < 1 或 offset > LOBMAXSIZE |
| QUERY_WRITE | 无法在查询或 PDML 并行执行服务器内部执行 LOB 写入 |
| BUFFERING_ENABLED | 如果在 LOB 上启用了缓冲，则无法在启用 LOB 缓冲的情况下执行操作 |

使用注意事项
您并非必须将 LOB 操作封装在 Open/Close 接口内。如果在执行操作之前未打开 LOB，则在调用期间会更新 LOB 列上的函数索引和域索引。但是，如果在执行操作之前打开了 LOB，则必须在提交事务之前关闭它。当内部 LOB 被关闭时，它会更新 LOB 列上的函数索引和域索引。

如果不将 LOB 操作封装在 Open/Close API 内，则每次写入 LOB 时都会更新函数索引和域索引。这可能会对性能产生不利影响。因此，建议您将针对 LOB 的写操作包含在 `OPEN` 或 `CLOSE` 语句中。

另请参见：
- “TRIM 过程”
- 有关此过程使用的更多详细信息，请参见 Oracle Database SecureFiles and Large Objects Developer's Guide

#### FILECLOSE 过程

此过程关闭已经通过输入定位器打开的 `BFILE`。
注意：
数据库对 `BFILEs` 只有只读访问权限。这意味着不能通过数据库写入 `BFILEs`。
语法
```
DBMS_LOB.FILECLOSE (
    file_loc IN OUT NOCOPY BFILE);
```
参数
表 107-33 FILECLOSE 过程参数
| Parameter | Description |
|---|---|
| file_loc | 要关闭的 BFILE 的定位器。 |
异常
表 107-34 FILECLOSE 过程异常
| Exception | Description |
|---|---|
| VALUE_ERROR | file_loc 的输入值为 NULL。 |
| UNOPENED_FILE | 文件未通过输入定位器打开。 |
| NOEXIST_DIRECTORY | 目录不存在。 |
| NOPRIV_DIRECTORY | 您没有该目录的权限。 |
| INVALID_DIRECTORY | 文件打开后目录已失效。 |
| INVALID_OPERATION | 文件不存在，或者您没有该文件的访问权限。 |
另请参见：
- "FILEOPEN Procedure"
- "FILECLOSEALL Procedure"
- Oracle Database SecureFiles and Large Objects Developer's Guide for additional details on usage of this procedure

#### FILECLOSEALL 过程

此过程关闭会话中打开的所有 `BFILEs`。
语法
```
DBMS_LOB.FILECLOSEALL;
```
异常
Table 107-35 FILECLOSEALL 过程异常
| 异常 | 描述 |
|---|---|
| UNOPENED_FILE | 会话中未打开任何文件。 |
另请参阅：
- "FILEOPEN 过程"
- "FILECLOSE 过程"
- Oracle Database SecureFiles and Large Objects Developer's Guide 了解有关此过程用法的更多细节

#### FILEEXISTS 函数

该函数用于查明指定的 `BFILE` 定位器是否指向服务器文件系统中实际存在的文件。
语法
```
DBMS_LOB.FILEEXISTS (
   file_loc     IN    BFILE)
  RETURN INTEGER;
```
Pragma
```
pragma restrict_references(FILEEXISTS, WNDS, RNDS, WNPS, RNPS);
```
参数
表 107-36 FILEEXISTS 函数参数
| 参数 | 说明 |
|---|---|
| file_loc | BFILE 的定位器。 |
返回值
表 107-37 FILEEXISTS 函数返回值
| 返回值 | 说明 |
|---|---|
| 0 | 物理文件不存在。 |
| 1 | 物理文件存在。 |
异常
表 107-38 FILEEXISTS 函数异常
| 异常 | 说明 |
|---|---|
| NOEXIST_DIRECTORY | 目录不存在。 |
| NOPRIV_DIRECTORY | 您没有该目录的权限。 |
| INVALID_DIRECTORY | 目录在文件打开后已失效。 |
另请参见：
- "FILEISOPEN 函数"。
- 有关此过程用法的更多详细信息，请参阅 Oracle Database SecureFiles and Large Objects Developer's Guide

#### FILEGETNAME 过程

给定一个 `BFILE` 定位符，此过程确定目录对象和文件名。
此函数仅指示分配给定位符的目录对象名和文件名，而不指示物理文件或目录是否实际存在。
`dir_alias` 缓冲区的最大约束值为 30，整个路径名的最大约束值为 2000。
语法
```
DBMS_LOB.FILEGETNAME (
   file_loc   IN    BFILE,
   dir_alias  OUT   VARCHAR2,
   filename   OUT   VARCHAR2);
```
参数
表 107-39 FILEGETNAME 过程参数
| 参数 | 描述 |
|---|---|
| file_loc | BFILE 的定位符 |
| dir_alias | 目录对象名 |
| filename | BFILE 的名称 |
异常
表 107-40 FILEGETNAME 过程异常
| 异常 | 描述 |
|---|---|
| VALUE_ERROR | 任何输入参数为 NULL 或 INVALID。 |
| INVALID_ARGVAL | dir_alias 或 filename 为 NULL。 |
另请参阅：
Oracle Database SecureFiles and Large Objects Developer's Guide 了解有关此过程用法的更多详细信息

#### FILEISOPEN 函数

该函数用于查明 `BFILE` 是否已使用指定的 `FILE` 定位器打开。
语法
```
DBMS_LOB.FILEISOPEN (
   file_loc   IN    BFILE)
  RETURN INTEGER;
```
Pragmas
```
PRAGMA RESTRICT_REFERENCES(fileisopen, WNDS, RNDS, WNPS, RNPS);
```
参数
表 107-41 FILEISOPEN 函数参数
| Parameter | Description |
|---|---|
| file_loc | BFILE 的定位器。 |
返回值
`INTEGER`：0 = 文件未打开，1 = 文件已打开
使用说明
如果输入的 `FILE` 定位器从未传递给 `FILEOPEN` 过程，则该定位器被视为未打开此文件。但是，其他定位器可能已打开此文件。换言之，打开状态与特定定位器相关联。
异常
表 107-42 FILEISOPEN 函数异常
| Exception | Description |
|---|---|
| NOEXIST_DIRECTORY | 目录不存在。 |
| NOPRIV_DIRECTORY | 您没有该目录的权限。 |
| INVALID_DIRECTORY | 目录在文件打开后已失效。 |
另请参见：
- "FILEEXISTS 函数"
- Oracle Database SecureFiles and Large Objects Developer's Guide 获取有关此过程用法的更多详细信息

#### FILEOPEN Procedure

此过程打开 `BFILE` 以进行只读访问。不能通过数据库写入 `BFILE` 数据。
语法
```
DBMS_LOB.FILEOPEN (
   file_loc   IN OUT NOCOPY  BFILE,
   open_mode  IN             BINARY_INTEGER := file_readonly);
```
参数
Table 107-43 FILEOPEN Procedure Parameters
| Parameter | Description |
|---|---|
| file_loc | BFILE 的定位器。 |
| open_mode | 文件访问为只读。 |
异常
Table 107-44 FILEOPEN Procedure Exceptions
| Exception | Description |
|---|---|
| VALUE_ERROR | file_loc 或 open_mode 为 NULL。 |
| INVALID_ARGVAL | open_mode 不等于 FILE_READONLY。 |
| OPEN_TOOMANY | 会话中打开的文件数超过 session_max_open_files。 |
| NOEXIST_DIRECTORY | 与 file_loc 关联的目录不存在。 |
| INVALID_DIRECTORY | 文件打开后目录已失效。 |
| INVALID_OPERATION | 文件不存在，或者您对该文件没有访问权限。 |
另请参阅：
- "FILECLOSE Procedure"
- "FILECLOSEALL Procedure"
- Oracle Database SecureFiles and Large Objects Developer's Guide 获取有关此过程用法的更多详细信息

#### FRAGMENT_DELETE 过程

此过程从 LOB 中删除指定偏移量处指定长度的数据，而无需重写指定偏移量之后 LOB 中的所有数据。
语法
```
DBMS_LOB.FRAGMENT_DELETE (
   lob_loc     IN OUT NOCOPY BLOB,
   amount      IN            INTEGER,
   offset      IN            INTEGER);
DBMS_LOB.FRAGMENT_DELETE (
   lob_loc     IN OUT NOCOPY CLOB CHARACTER SET ANY_CS,
   amount      IN            INTEGER,
   offset      IN            INTEGER);
```
参数
表 107-45 FRAGMENT_DELETE 过程参数
| Parameter | Description |
|---|---|
| lob_loc | LOB 定位器。有关更多信息，请参见操作说明。 |
| amount | 要从 LOB 中删除的字节数（BLOB）或字符数（CLOB/NCLOB） |
| offset | LOB 中开始删除的字节（BLOB）或字符（CLOB/NCLOB）偏移量 |
异常
表 107-46 FRAGMENT_DELETE 过程异常
| Exception | Description |
|---|---|
| INVALID_ARGVAL | 参数值无效 |
| QUERY_WRITE | 查询期间无法执行操作 |
| BUFFERING_ENABLED | 启用 LOB 缓冲时无法执行操作 |
| SECUREFILE_BADLOB | 在仅限 SECUREFILE LOB 的调用中使用了非 SECUREFILE LOB |
| SECUREFILE_OUTOFBOUNDS | 尝试在 LOB 末尾之后执行 FRAGMENT_* 操作 |

#### FRAGMENT_INSERT 过程

此过程将指定数据（上限为 32K）插入到 LOB 中指定的偏移量处。
语法
```
DBMS_LOB.FRAGMENT_INSERT (
   lob_loc     IN OUT NOCOPY BLOB,
   amount      IN            INTEGER,
   offset      IN            INTEGER,
   buffer      IN            RAW);
DBMS_LOB.FRAGMENT_INSERT (
   lob_loc     IN OUT NOCOPY CLOB CHARACTER SET ANY_CS,
   amount      IN            INTEGER,
   offset      IN            INTEGER,
   buffer      IN            VARCHAR2 CHARACTER SET lob_loc%CHARSET);
```
参数
表 107-47 FRAGMENT_INSERT 过程参数
| Parameter | Description |
|---|---|
| lob_loc | LOB 定位器。有关更多信息，请参见操作说明。 |
| amount | 要插入到 LOB 中的字节数 (BLOB) 或字符数 (CLOB/NCLOB) |
| offset | LOB 中开始插入处的偏移量，以字节 (BLOB) 或字符 (CLOB/NCLOB) 为单位 |
| buffer | 要插入到 LOB 中的数据 |
异常
表 107-48 FRAGMENT_INSERT 过程异常
| Exception | Description |
|---|---|
| INVALID_ARGVAL | 参数值无效 |
| QUERY_WRITE | 查询期间无法执行操作 |
| BUFFERING_ENABLED | 启用 LOB 缓冲时无法执行操作 |
| SECUREFILE_BADLOB | 在仅限 SECUREFILE LOB 的调用中使用了非 SECUREFILE LOB |
| SECUREFILE_OUTOFBOUNDS | 尝试在 LOB 末尾之后执行 FRAGMENT_* 操作 |
使用注意事项
`FRAGMENT_INSERT` 在对 LOB 执行操作之前，如有必要会先获取该 LOB。

#### FRAGMENT_MOVE Procedure

此过程将指定数量的字节 (BLOB) 或字符 (CLOB/NCLOB) 从指定的偏移量移动到指定的新偏移量。
语法
```
DBMS_LOB.FRAGMENT_MOVE (
   lob_loc       IN OUT NOCOPY BLOB,
   amount        IN            INTEGER,
   src_offset    IN            INTEGER,
   dest_offset   IN            INTEGER);
DBMS_LOB.FRAGMENT_MOVE (
   lob_loc       IN OUT NOCOPY CLOB CHARACTER SET ANY_CS,
   amount        IN            INTEGER,
   src_offset    IN            INTEGER,
   dest_offset   IN            INTEGER);
```
参数
Table 107-49 FRAGMENT_MOVE Procedure Parameters
| Parameter | Description |
|---|---|
| lob_loc | LOB locator. 有关更多信息，请参见操作说明。 |
| amount | 要在 LOB 中移动的字节 (BLOB) 或字符 (CLOB/NCLOB) 数 |
| src_offset | 放入数据的 LOB 中的起始偏移量，以字节 (BLOB) 或字符 (CLOB/NCLOB) 为单位 |
| dest_offset | 移除数据的 LOB 中的起始偏移量，以字节 (BLOB) 或字符 (CLOB/NCLOB) 为单位 |
异常
Table 107-50 FRAGMENT_MOVE Procedure Exceptions
| Exception | Description |
|---|---|
| INVALID_ARGVAL | 参数值无效 |
| QUERY_WRITE | 查询期间无法执行操作 |
| BUFFERING_ENABLED | 启用 LOB 缓冲时无法执行操作 |
| SECUREFILE_BADLOB | 在仅限 SECUREFILE LOB 的调用中使用了非 SECUREFILE LOB |
| SECUREFILE_OUTOFBOUNDS | 尝试在超过 LOB 末尾执行 FRAGMENT_* 操作 |
使用说明
- 所有偏移量均为移动前的偏移量。
- 不允许超过 LOB 末尾 1 以上的偏移量。
- FRAGMENT_MOVE 在对 LOB 执行操作之前，如有必要会先获取该 LOB。

#### FRAGMENT_REPLACE 过程

此过程使用指定数据替换指定偏移量处的数据（不超过 32k）。
语法
```
DBMS_LOB.FRAGMENT_REPLACE (
   lob_loc     IN OUT NOCOPY BLOB,
   old_amount  IN            INTEGER,
   new_amount  IN            INTEGER,
   offset      IN            INTEGER,
   buffer      IN            RAW);
DBMS_LOB.FRAGMENT_REPLACE (
   lob_loc     IN OUT NOCOPY CLOB CHARACTER SET ANY_CS,   old_amount  IN           INTEGER,
   new_amount  IN           INTEGER,
   offset      IN           INTEGER,
   buffer      IN           VARCHAR2 CHARACTER SET lob_loc%CHARSET);
```
参数
表 107-51 FRAGMENT_REPLACE 函数参数
| 参数 | 描述 |
|---|---|
| lob_loc | LOB 定位器。有关更多信息，请参见操作说明。 |
| old_amount | LOB 中要替换的字节数（BLOB）或字符数（CLOB/NCLOB） |
| new_amount | 要写入 LOB 的字节数（BLOB）或字符数（CLOB/NCLOB） |
| offset | LOB 中放入数据的起始偏移量，以字节（BLOB）或字符（CLOB/NCLOB）为单位 |
| buffer | 要插入 LOB 的数据 |
异常
表 107-52 FRAGMENT_REPLACE 过程异常
| 异常 | 描述 |
|---|---|
| INVALID_ARGVAL | 参数值无效 |
| QUERY_WRITE | 无法在查询期间执行操作 |
| BUFFERING_ENABLED | 启用 LOB 缓冲时无法执行操作 |
| SECUREFILE_BADLOB | 在仅限 SECUREFILE LOB 的调用中使用了非 SECUREFILE LOB |
| SECUREFILE_OUTOFBOUNDS | 试图在 LOB 末尾之后执行 FRAGMENT_* 操作 |
使用说明
- 调用此过程相当于先删除偏移量处指定数量的字节/字符，然后在偏移量处插入指定数量的新字节/字符。
- FRAGMENT_REPLACE 在对 LOB 执行操作之前，如有必要会先获取 LOB。

#### FREETEMPORARY 过程

此过程释放在默认临时表空间中的临时 `BLOB` 或 `CLOB`。
语法
```
DBMS_LOB.FREETEMPORARY (
   lob_loc  IN OUT  NOCOPY BLOB);
DBMS_LOB.FREETEMPORARY (
   lob_loc  IN OUT  NOCOPY CLOB CHARACTER SET ANY_CS);
```
参数
表 107-53 FREETEMPORARY 过程参数
| Parameter | Description |
|---|---|
| lob_loc | LOB 定位器。有关更多信息，请参见操作说明。 |
用法说明
- 当创建新的临时 LOB，且当前没有相同持续时间（会话、调用）的临时 LOB 正在使用时，将创建一个新的临时 LOB 段。当释放临时 LOB 时，其占用的空间将释放给临时段。如果没有相同持续时间的其他临时 LOB，则临时段也会被释放。
- 调用 FREETEMPORARY 后，被释放的 LOB 定位器将被标记为无效。
- 如果在 OCI 中使用 OCILobLocatorAssign 或通过 PL/SQL 中的赋值操作，将无效的 LOB 定位器分配给另一个 LOB 定位器，则赋值的目标也将被释放并标记为无效。
另请参阅：
Oracle Database SecureFiles and Large Objects Developer's Guide，了解有关此过程用法的更多详细信息

#### GET_DBFS_LINK 函数

此函数返回指定 SecureFile LOB 的 DBFS 路径名。
语法
```
DBMS_LOB.GET_DBFS_LINK (
  lob_loc             IN     BLOB,
  storage_path        OUT VARCHAR2(DBFS_LINK_PATH_MAX_SIZE),
  lob_length          OUT NUMBER);
DBMS_LOB.GET_DBFS_LINK (
  lob_loc             IN     CLOB CHARACTER SET ANY_CS,
  storage_path        OUT VARCHAR2(DBFS_LINK_PATH_MAX_SIZE),
  lob_length          OUT NUMBER);
```
参数
表 107-54 GET_DBFS_LINK 函数参数
| 参数 | 描述 |
|---|---|
| lob_loc | 要从 DBFS 中检索的 LOB |
| storage_path | LOB 在 DBFS 中存储的路径 |
| lob_length | 写入 DBFS 时的 LOB 长度 |
返回值
Archive ID
异常
表 107-55 GET_DBFS_LINK 函数异常
| 异常 | 描述 |
|---|---|
| SECUREFILE_BADLOB | lob_loc 不是 SECUREFILE |
| ORA-01555 | 该 LOB 已经被检索过，并且自检索以来已被修改；或者自定位器被检索以来，该 LOB 已被迁入和迁出（无论是否修改） |

#### GET_DBFS_LINK_STATE 过程

`GET_DBFS_LINK_STATE` 用于获取指定 SecureFile 的当前链接状态。
语法
```
DBMS_LOB.GET_DBFS_LINK_STATE (
  lob_loc       IN BLOB,
  storage_path  OUT VARCHAR2(DBFS_LINK_PATH_MAX_SIZE),
  state         OUT NUMBER,
  cached        OUT BOOLEAN);
DBMS_LOB.GET_DBFS_LINK_STATE (
  lob_loc       IN CLOB CHARACTER SET ANY_CS,
  storage_path  OUT VARCHAR2(DBFS_LINK_PATH_MAX_SIZE),
  state         OUT NUMBER,
  cached        OUT BOOLEAN);
```
参数
表 107-56 GET_DBFS_LINK_STATE 过程参数
| Parameter | Description |
|---|---|
| lob_loc | 要从归档中检索的 LOB |
| storage_path | LOB 在 DBFS HSM 存储中存储的路径 |
| state | DBFS_LINK_NEVER、DBFS_LINK_NO 或 DBFS_LINK_YES 之一 |
| cached | 如果 LOB 已归档，且在执行 put 操作时指定要缓存数据 |
异常
表 107-57 GET_DBFS_LINK_STATE 过程异常
| Exception | Description |
|---|---|
| SECUREFILE_BADLOB | lob_loc 不是 SECUREFILE |
用法说明
``````````
- 如果 LOB 从未归档，state 设置为 DBMS_LOB.DBFS_LINK_NEVER。如果 LOB 已归档，state 设置为 DBMS_LOB.DBFS_LINK_YES。如果 LOB 之前已从归档中检索，state 设置为 DBFS_LINK_NO。
``````````````
- 如果 LOB 已归档，但数据保留在 RDBMS 中，cached 设置为 TRUE。如果在创建链接后移除了数据，cached 设置为 FALSE；如果 state 为 DBMS_LOB.DBFS_LINK_NEVER，则为 NULL。

#### GETCONTENTTYPE 函数

此过程返回先前通过 SETCONTENTTYPE 过程设置的内容类型字符串。
语法
```
DBMS_LOB.GETCONTENTTYPE (
   lob_loc  IN BLOB)
 RETURN VARCHAR2;
DBMS_LOB.GETCONTENTTYPE (
   lob_loc  IN CLOB CHARACTER SET ANY_CS)
 RETURN VARCHAR2;
```
Pragma
```
PRAGMA RESTRICT_REFERENCES(getcontenttype, WNDS, RNDS, WNPS, RNPS);
```
参数
Table 107-58 GETCONTENTTYPE Function Parameters
| Parameter | Description |
|---|---|
| lob_loc | 要检索其内容类型的 LOB |
返回值
返回的内容类型。
如果 SecureFiles LOB 没有关联的 `contenttype`，`GETCONTENTTYPE()` 返回 `NULL`。
异常
Table 107-59 GETCONTENTTYPE Function Exceptions
| Exception | Description |
|---|---|
| SECUREFILE_BADLOB | lob_loc 不是 SECUREFILE |
**相关主题**
                           - SETCONTENTTYPE Procedure

#### GET_STORAGE_LIMIT 函数

此函数返回指定 LOB 的 LOB 存储限制。
语法
```
DBMS_LOB.GET_STORAGE_LIMIT (
   lob_loc  IN CLOB CHARACTER SET ANY_CS)
 RETURN INTEGER;
DBMS_LOB.GET_STORAGE_LIMIT (
   lob_loc  IN BLOB)
 RETURN INTEGER;
```
Pragmas
```
PRAGMA RESTRICT_REFERENCES(get_storage_limit, WNDS, RNDS, WNPS, RNPS);
```
参数
表 107-60 GET_STORAGE_LIMIT 函数参数
| 参数 | 描述 |
|---|---|
| lob_loc | LOB 定位器。有关更多信息，请参见操作说明。 |
返回值
此函数返回的值是指定 LOB 定位器的最大允许大小。对于 `BLOB`，返回值取决于 LOB 所在表空间的块大小，其计算方式为 (232)-1 (4294967295) 乘以表空间的块大小。对于 `CLOB`/`NCLOB`，返回值为 (232)-1 (4294967295) 乘以表空间块大小后再除以 `CLOB`/`NCLOB` 的字符宽度。
用法
另请参见：
有关 LOB 存储限制的详细信息，请参阅 Oracle Database SecureFiles and Large Objects Developer's Guide

#### GETCHUNKSIZE 函数

创建表时，可以指定分块因子，即以字节为单位的表空间块的倍数。这对应于 LOB 数据层在访问或修改 LOB 值时所使用的块大小。块的一部分用于存储系统相关信息，其余部分用于存储 LOB 值。此函数返回 LOB 块中用于存储 LOB 值的空间量。
语法
```
DBMS_LOB.GETCHUNKSIZE (
   lob_loc IN BLOB)
  RETURN INTEGER;
DBMS_LOB.GETCHUNKSIZE (
   lob_loc IN CLOB CHARACTER SET ANY_CS)
  RETURN INTEGER;
```
Pragma
```
PRAGMA RESTRICT_REFERENCES(getchunksize, WNDS, RNDS, WNPS, RNPS);
```
参数
表 107-61 GETCHUNKSIZE 函数参数
| 参数 | 描述 |
|---|---|
| lob_loc | LOB 定位器。有关更多信息，请参阅操作说明。 |
返回值
返回值为以字节为单位的可用块大小。
使用说明
````
- 对于基本 LOB 文件，如果输入的读/写请求使用此块大小的倍数，则性能会得到提升。对于写入操作还有一个额外的好处，因为 LOB 块是版本化的，如果所有写入操作都基于块进行，则不会产生额外或多余的版本化或重复版本化。您可以将 WRITE 批处理直到累积够一个块的数据，而不是对同一个块发出多次 WRITE 调用。这些提升性能的策略不适用于 SecureFiles。
``````
- 请注意，块大小与 LOB 类型（BLOB、CLOB、NCLOB、Unicode 或其他字符集）无关。
另请参阅：
Oracle Database SecureFiles and Large Objects Developer's Guide 中有关此过程用法的更多详细信息
异常
表 107-62 GETCHUNKSIZE 过程异常
| 异常 | 描述 |
|---|---|
| BUFFERING_ENABLED | 如果在 LOB 上启用了缓冲，则无法在启用 LOB 缓冲的情况下执行操作 |

#### GETLENGTH 函数

此函数用于获取指定 LOB 的长度。返回值的单位为字节或字符。
对于 `BFILE` 返回的长度包含 `EOF`（如果存在）。由于先前的 `ERASE` 或 `WRITE` 操作而在 LOB 中产生的任何 0 字节或空间填充符也会计入长度。空内部 LOB 的长度为 0。
语法
```
DBMS_LOB.GETLENGTH (
   lob_loc    IN  BLOB)
  RETURN INTEGER;
DBMS_LOB.GETLENGTH (
   lob_loc    IN  CLOB   CHARACTER SET ANY_CS)
  RETURN INTEGER;
DBMS_LOB.GETLENGTH (
   file_loc    IN  BFILE)
  RETURN INTEGER;
```
Pragma
```
pragma restrict_references(GETLENGTH, WNDS, WNPS, RNDS, RNPS);
```
参数
表 107-63 GETLENGTH 函数参数
| Parameter | Description |
|---|---|
| file_loc | 要返回其长度的 LOB 的文件定位符。 |
返回值
以字节或字符为单位的 LOB 长度，类型为 `INTEGER`。如果输入 LOB 为 `NULL` 或输入的 `lob_loc` 为 `NULL`，则返回 `NULL`。对于 `BFILEs`，在以下情况下会返回错误：
- lob_loc 不具备必要的目录和操作系统权限
- 由于操作系统读取错误，lob_loc 无法读取 另请参阅：Oracle Database SecureFiles and Large Objects Developer's Guide 了解有关使用此过程的更多详细信息
异常
表 107-64 GETLENGHTH 过程异常
| Exception | Description |
|---|---|
| BUFFERING_ENABLED | 如果在 LOB 上启用了缓冲，则无法在启用 LOB 缓冲的情况下执行操作 |

#### GETOPTIONS Functions

此函数获取特定 LOB 对应于 `option_type` 字段的压缩、去重和加密设置。
语法
```
DBMS_LOB.GETOPTIONS (
   lob_loc             IN     BLOB,
   option_types        IN     PLS_INTEGER)
 RETURN PLS_INTEGER;
DBMS_LOB.GETOPTIONS (
  lob_loc             IN     CLOB CHARACTER SET ANY_CS,
  option_types        IN     PLS_INTEGER)
RETURN PLS_INTEGER;
```
参数
Table 107-65 GETOPTIONS Function Parameter
| Parameter | Description |
|---|---|
| lob_loc | 要检查的 LOB 的定位器。有关更多信息，请参见 Operational Notes。 |
| option_type | 参见 Table 107-2 |
返回值
返回值是 `COMPRESS_ON`、`ENCRYPT_ON` 和 `DEDUPLICATE_ON`（参见 Table 107-3）的组合，具体取决于传入的选项类型（参见 Table 107-2）。
异常
Table 107-66 GETOPTIONS Procedure Exceptions
| Exception | Description |
|---|---|
| INVALID_ARGVAL | 参数值无效 |
| QUERY_WRITE | 查询期间无法执行操作 |
| BUFFERING_ENABLED | 启用 LOB 缓冲时无法执行操作 |
| SECUREFILE_BADLOB | 在仅适用于 SECUREFILE LOB 的调用中使用了非 SECUREFILE LOB |
使用说明
对于未启用这些功能的 SecureFile 列，无法打开或关闭压缩或去重。GetOptions Functions 和 SETOPTIONS Procedures 作用于单个 SecureFiles。可以关闭特定 SecureFile 上的某个功能，也可以打开先前被 SetOptions 关闭的功能，但不能打开在创建表时未提供给 SecureFile 的选项。

#### INSTR 函数

此函数返回从指定 offset 开始，第 nth 次出现的 pattern 在 LOB 中的匹配位置。

语法
```
DBMS_LOB.INSTR (
   lob_loc    IN   BLOB,
   pattern    IN   RAW,
   offset     IN   INTEGER := 1,
   nth        IN   INTEGER := 1)
  RETURN INTEGER;
DBMS_LOB.INSTR (
   lob_loc    IN   CLOB      CHARACTER SET ANY_CS,
   pattern    IN   VARCHAR2  CHARACTER SET lob_loc%CHARSET,
   offset     IN   INTEGER := 1,
   nth        IN   INTEGER := 1)
  RETURN INTEGER;
DBMS_LOB.INSTR (
   file_loc   IN   BFILE,
   pattern    IN   RAW,
   offset     IN   INTEGER := 1,
   nth        IN   INTEGER := 1)
  RETURN INTEGER;
```
Pragmas
```
pragma restrict_references(INSTR, WNDS, WNPS, RNDS, RNPS);
```
参数
Table 107-67 INSTR 函数参数
| Parameter | Description |
|---|---|
| lob_loc | 要检查的 LOB 的定位器。更多信息请参见操作说明。 |
| file_loc | 要检查的 LOB 的文件定位器。 |
| pattern | 要测试的 pattern。对于 BLOB，pattern 是一组 RAW 字节；对于 CLOB，pattern 是字符串（VARCHAR2）。pattern 的最大大小为 16383 字节。 |
| offset | 开始进行 pattern 匹配的绝对 offset，以字节（BLOB）或字符（CLOB）为单位。（起点：1） |
| nth | 出现次数，从 1 开始。 |

返回值
Table 107-68 INSTR 函数返回值
| Return | Description |
|---|---|
| INTEGER | 匹配 pattern 起始处的 offset，以字节或字符为单位。如果未找到 pattern，则返回 0。 |
| NULL | 满足以下任一条件：- 一个或多个 IN 参数为 NULL 或 INVALID。- offset < 1 或 offset > LOBMAXSIZE。- nth < 1。-nth > LOBMAXSIZE。 |

使用说明
`VARCHAR2` 缓冲区（`pattern` 参数）的形式必须与 `CLOB` 参数的形式匹配。换言之，如果输入 LOB 参数类型为 `NCLOB`，则缓冲区必须包含 `NCHAR` 数据。反之，如果输入 LOB 参数类型为 `CLOB`，则缓冲区必须包含 `CHAR` 数据。
对于 `BFILEs`，文件必须已通过成功的 `FILEOPEN` 操作打开，此操作才能成功。
接受 `RAW` 或 `VARCHAR2` 参数进行 pattern 匹配的操作（例如 `INSTR`）不支持在 pattern 参数或子字符串中使用正则表达式或特殊匹配字符（如 SQL `LIKE` 的情况）。

异常
Table 107-69 BFILES 的 INSTR 函数异常
| Exception | Description |
|---|---|
| UNOPENED_FILE | 未使用输入定位器打开文件。 |
| NOEXIST_DIRECTORY | 目录不存在。 |
| NOPRIV_DIRECTORY | 您没有该目录的权限。 |
| INVALID_DIRECTORY | 文件打开后目录已失效。 |
| INVALID_OPERATION | 文件不存在，或者您没有该文件的访问权限。 |
| BUFFERING_ENABLED | 如果在 LOB 上启用了缓冲，则无法在启用 LOB 缓冲的情况下执行操作。 |

另请参见：
- "SUBSTR Functions"
- Oracle Database SecureFiles and Large Objects Developer's Guide for additional details on usage of this procedure

#### ISOPEN Functions

此函数检查是否已使用输入定位器打开 LOB。此子程序适用于内部和外部 LOB。
语法
```
DBMS_LOB.ISOPEN (
   lob_loc IN BLOB)
  RETURN INTEGER;
DBMS_LOB.ISOPEN (
   lob_loc IN CLOB CHARACTER SET ANY_CS)
  RETURN INTEGER;
DBMS_LOB.ISOPEN (
   file_loc IN BFILE)
  RETURN INTEGER;
```
Pragmas
```
PRAGMA RESTRICT_REFERENCES(isopen, WNDS, RNDS, WNPS, RNPS);
```
参数
Table 107-70 ISOPEN Function Parameters
| Parameter | Description |
|---|---|
| lob_loc | LOB 定位器。有关更多信息，请参见操作说明。 |
| file_loc | 文件定位器。 |
返回值
如果 LOB 已打开，则返回值为 1，否则为 0。
使用说明
对于 `BFILES`，打开状态与定位器相关联。如果输入定位器从未传递给 `OPEN`，则此定位器不会被认为打开了该 `BFILE`。但是，不同的定位器可能已经打开了该 `BFILE`。可以使用不同的定位器对同一个 `BFILE` 执行多次 `OPEN`。
对于内部 LOB，打开状态与 LOB 相关联，而不是与定位器相关联。如果 locator1 打开了 LOB，则 locator2 也会看到该 LOB 处于打开状态。对于内部 LOB，`ISOPEN` 需要一次往返，因为它需要检查服务器上的状态以确认 LOB 是否确实已打开。
对于外部 LOB（`BFILEs`），`ISOPEN` 也需要一次往返，因为状态保存在服务器上。
另请参见：
Oracle Database SecureFiles and Large Objects Developer's Guide，了解有关此过程使用的更多详细信息

#### ISREMOTE 函数

此函数用于检查 LOB 是位于本地数据库，还是属于远程数据库。

语法
```
DBMS_LOB.ISREMOTE (
   lob_loc IN BLOB)
  RETURN BOOLEAN;
```
```
DBMS_LOB.ISREMOTE (
   lob_loc IN CLOB CHARACTER SET ANY_CS)
  RETURN BOOLEAN;
```
Pragmas
```
PRAGMA RESTRICT_REFERENCES(isremote, WNDS, RNDS, WNPS, RNPS);
```
参数
Table 107-71 ISREMOTE Function Parameter
| Parameter | Description |
|---|---|
| lob_loc | LOB 的定位器。 |
返回值
`BOOLEAN`：对于通过数据库链接获取的远程 LOB，返回 `TRUE`；对于从本地数据库获取的 LOB，返回 `FALSE`

另请参见：
- 有关此过程用法的更多详情，请参阅 Database SecureFiles and Large Objects Developer's Guide 中的 Distributed LOBs 章节。

#### ISSECUREFILE 函数

此函数在传入的 LOB 定位器指向 SecureFile LOB 时返回 `TRUE`。否则返回 `FALSE`。
语法
```
DBMS_LOB ISSECUREFILE(
    lob_loc    IN      BLOB)
  RETURN BOOLEAN;
```
PRAGMA
```
PRAGMA RESTRICT_REFERENCES(issecurefile, WNDS, RNDS, WNPS, RNPS);
```
参数
Table 107-72 ISSECUREFILE Function Parameter
| Parameter | Description |
|---|---|
| lob_loc | LOB 定位器。更多信息请参见操作说明。 |
返回值
此函数在传入的 LOB 定位器指向 SecureFile LOB 时返回 `TRUE`。否则返回 `FALSE`。

#### ISTEMPORARY 函数

此函数用于确定一个 LOB 实例是否为临时的。
语法
```
DBMS_LOB.ISTEMPORARY (
   lob_loc IN BLOB)
  RETURN INTEGER;
DBMS_LOB.ISTEMPORARY (
   lob_loc IN CLOB CHARACTER SET ANY_CS)
  RETURN INTEGER;
```
Pragma
```
PRAGMA RESTRICT_REFERENCES(istemporary, WNDS, RNDS, WNPS, RNPS);
```
参数
Table 107-73 ISTEMPORARY Procedure Parameters
| Parameter | Description |
|---|---|
| lob_loc | LOB 定位器。有关更多信息，请参见操作说明。 |
返回值
如果 LOB 是临时的并且存在，则返回值为 1；如果 LOB 不是临时的或者不存在，则为 0；如果给定的定位器为 `NULL`，则为 `NULL`。
使用说明
当你使用 `FREETEMPORARY` 释放一个临时 LOB 时，该 LOB 定位器不会被设置为 `NULL`。因此，对于一个已被释放但未显式重置为 `NULL` 的定位器，`ISTEMPORARY` 将返回 0。
另请参见：
Oracle Database SecureFiles and Large Objects Developer's Guide 获取有关此过程用法的更多细节

#### LOADBLOBFROMFILE Procedure

此过程将数据从 `BFILE` 加载到内部 `BLOB`。其效果与 `LOADFROMFILE` 相同，并返回新的偏移量。
Syntax
```
DBMS_LOB.LOADBLOBFROMFILE (
   dest_lob    IN OUT NOCOPY BLOB,
   src_bfile   IN            BFILE,
   amount      IN            INTEGER,
   dest_offset IN OUT        INTEGER,
   src_offset  IN OUT        INTEGER);
```
Parameters
Table 107-74 LOADBLOBFROMFILE Procedure Parameters
| Parameter | Description |
|---|---|
| dest_lob | 加载目标的 BLOB 定位器。 |
| src_bfile | 加载源的 BFILE 定位器。 |
| amount | 要从 BFILE 加载的字节数。也可以使用 DBMS_LOB.LOBMAXSIZE 一直加载到 BFILE 末尾。 |
| dest_offset | (IN) 目标 BLOB 中开始写入的偏移量（以字节为单位，起始值为 1）。(OUT) 本次写入结束后目标 BLOB 中的新偏移量（以字节为单位），也是下一次写入应开始的位置。 |
| src_offset | (IN) 源 BFILE 中开始读取的偏移量（以字节为单位，起始值为 1）。(OUT) 本次读取结束后源 BFILE 中的新偏移量（以字节为单位），也是下一次读取应开始的位置。 |
Usage Notes
````````````
- 可以指定源 LOB 和目标 LOB 的偏移量，以及要从源 BFILE 复制的字节数。因为 amount 和 src_offset 指向 BFILE，所以它们以字节为单位，而对于 BLOB，dest_offset 也以字节为单位。
- 如果在目标 LOB 中指定的偏移量超出了该 LOB 当前数据的末尾，则会在目标 BLOB 中插入零字节填充符或空格。如果偏移量小于目标 LOB 的当前长度，则会覆盖现有数据。
``````
- 如果输入的 amount 加上偏移量超过了 BFILE 中数据的长度，则会引发错误（除非指定的 amount 为 LOBMAXSIZE，此时可以指定它持续加载直到到达 BFILE 末尾）。
- 不必强制将 LOB 操作包装在 OPEN/CLOSE 操作内。如果在执行操作前未打开 LOB，则在调用期间会更新 LOB 列上的函数索引和域索引。但是，如果在执行操作前打开了 LOB，则必须在提交事务之前将其关闭。当内部 LOB 关闭时，它会更新 LOB 列上的函数索引和域索引。
``````
- 如果不将 LOB 操作包装在 OPEN/CLOSE 内部，则每次写入 LOB 时都会更新函数索引和域索引。这会对性能产生不利影响。因此，建议将对 LOB 的写操作包含在 OPEN 或 CLOSE 语句中。
- 除非加载覆盖了整个 LOB，否则 LOADFROMFILE 会在加载前获取目标 LOB。
Constants and Defaults
没有简便的方法可以省略参数。必须为 `IN/OUT` 参数声明变量，或者为 `IN` 参数提供默认值。以下是可用常量和默认值的汇总。
Table 107-75 Suggested Values of the Parameter
| Parameter | Default Value | Description |
|---|---|---|
| amount | DBMS_LOB.LOBMAXSIZE (IN) | 加载整个文件 |
| dest_offset | 1 (IN) | 从头开始 |
| src_offset | 1 (IN) | 从头开始 |
Constants defined in `DBMSLOB.SQL`
```
lobmaxsize                    CONSTANT INTEGER        := DBMS_LOB.LOBMAXSIZE;
```
Exceptions
Table 107-76 LOADBLOBFROMFILE Procedure Exceptions
| Exception | Description |
|---|---|
| VALUE_ERROR | 任何输入参数为 NULL 或 INVALID。 |
| INVALID_ARGVAL | 满足以下任意条件： - src_offset 或 dest_offset < 1。 - src_offset 或 dest_offset > LOBMAXSIZE。 - amount < 1。 - amount > LOBMAXSIZE。 |
| BUFFERING_ENABLED | 如果在 BLOB 上启用了缓冲，则无法在启用 LOB 缓冲的情况下执行操作 |
See Also:
Oracle Database SecureFiles and Large Objects Developer's Guide for additional details on usage of this procedure

#### LOADCLOBFROMFILE 过程

该过程将数据从 `BFILE` 加载到内部 `CLOB/NCLOB`，进行必要的字符集转换，并返回新的偏移量。
语法
```
DBMS_LOB.LOADCLOBFROMFILE (
   dest_lob       IN OUT NOCOPY   NOCOPY CLOB CHARACTER SET ANY_CS,
   src_bfile      IN              BFILE,
   amount         IN              INTEGER,
   dest_offset    IN OUT          INTEGER,
   src_offset     IN OUT          INTEGER,
   bfile_csid     IN              NUMBER,
   lang_context   IN OUT          INTEGER,
   warning        OUT             INTEGER);
```
参数
表 107-77 LOADCLOBFROMFILE 过程参数
| Parameter | Description |
|---|---|
| dest_lob | 加载目标的 CLOB/NCLOB 定位器。 |
| src_bfile | 加载源的 BFILE 定位器。 |
| amount | 从 BFILE 加载的字节数。使用 DBMS_LOB.LOADCLOBSIZE 可加载至 BFILE 结尾。 |
| dest_offset | (IN) 目标 CLOB 中写入起始位置的字符偏移量（原点：1）。(OUT) 本次加载结束后紧接着的字符偏移量，也是下一次加载应开始的位置。它始终指向加载结束后第一个完整字符的开头。如果最后一个字符不完整，偏移量将回退到该不完整字符的开头。 |
| src_offset | (IN) 源 BFILE 中读取起始位置的字节偏移量（原点：1）。(OUT) 源 BFILE 中本次读取结束后紧接着的字节偏移量，也是下一次读取应开始的位置。 |
| bfile_csid | 源 (BFILE) 文件的字符集 ID。 |
| lang_context | (IN) 当前加载的语言上下文，如移位状态。(OUT) 当前加载停止时的语言上下文，以及如果继续从同一源加载时下一次加载应使用的语言上下文。此信息返回给用户，以便用户在连续加载时使用，避免丢失或误解任何源数据。对于第一次加载，或者如果不在意，直接使用默认值 0 即可。该语言上下文的细节对用户是隐藏的。用户无需了解它是什么或包含什么内容即可进行调用。 |
| warning | (OUT) 警告信息。指示在加载过程中发生了异常情况。它可能由用户的错误导致，也可能不是。加载会按要求完成，用户需自行检查警告信息。目前，唯一可能的警告是不可转换字符。当源中的字符无法正确转换为目标字符时，会使用默认替换字符（例如 '?'）代替，就会发生这种情况。该信息由常量值 DBMS_LOB.WARN_INCONVERTIBLE_CHAR 定义。 |
用法说明
您可以为源和目标 LOB 指定偏移量，以及从源 `BFILE` 复制的字节数。由于 `amount` 和 `src_offset` 指向 `BFILE`，它们的单位是字节；而对于 `CLOB`，`dest_offset` 的单位是字符。
如果您在目标 LOB 中指定的偏移量超出了该 LOB 当前数据的末尾，则会在目标 `CLOB` 中插入零字节填充符或空格。如果偏移量小于目标 LOB 的当前长度，则会覆盖现有数据。
如果输入 amount 加偏移量超过了 `BFILE` 中数据的长度，将会报错（除非指定的 amount 为 `LOBMAXSIZE`，您可以指定它来持续加载直至达到 `BFILE` 的末尾）。
请注意以下要求：
````
- 对于 CLOB，目标字符集始终与数据库字符集相同；对于 NCLOB，则与国家字符集相同。
````````````
- csid=0 表示默认行为，即对于 CLOB 使用数据库 csid，对于 NCLOB 使用国家 csid 来代替源 csid。如果是变宽字符集，仍然需要进行转换。
``````
- 您并非必须将 LOB 操作封装在 OPEN/CLOSE 操作中。如果在执行操作前未打开 LOB，则 LOB 列上的函数索引和域索引会在调用期间更新。但是，如果在执行操作前打开了 LOB，则必须在提交事务前关闭它。当内部 LOB 被关闭时，它会更新 LOB 列上的函数索引和域索引。如果不将 LOB 操作封装在 OPEN/CLOSE 中，每次写入 LOB 时都会更新函数索引和域索引。这可能会对性能产生不利影响。因此，建议将 LOB 的写操作包含在 OPEN 或 CLOSE 语句中。
源 `BFILE` 可以包含 Unicode 字符集的数据。Unicode 标准定义了许多编码方案，提供从 Unicode 字符到字节序列的映射。表 107-78 列出了该子程序支持的 Unicode 编码方案。
表 107-78 支持的 Unicode 编码方案
| Encoding Scheme | Oracle Name | bfile_csid Value |
|---|---|---|
| UTF-8 | AL32UTF8 | 873 |
| UTF-16BE | AL16UTF16 | 2000 |
| UTF-16LE | AL16UTF16LE | 2002 |
| CESU-8 | UTF8 | 871 |
| UTF-EBCDIC | UTFE | 872 |
| UTF-16 | UTF16 | 1000 |
所有三种 `UTF-16` 编码方案都将 Unicode 字符编码为 2 字节的无符号整数。整数可以以大端字节序或小端字节序存储。`UTF-16BE ` 编码方案定义大端数据。`UTF-16LE` 方案定义小端数据。`UTF-16` 方案要求源 `BFILE` 的前两个字节包含字节顺序标记 (BOM) 字符以定义字节顺序。BOM 代码为 `0xFEFF`。如果代码存储为 `{0xFE,0xFF}`，则数据被解释为大端序。如果存储为 `{0xFF,0xFE}`，则数据被解释为小端序。
在 `UTF-8` 和 `CESU-8` 编码中，字节顺序标记存储为 `{0xEF,0xBB, 0xBF}`。对于任何 Unicode 编码，都会识别文件开头的相应 BOM 序列，并且不会将其加载到目标 LOB 中。
常量
以下是可用的常量及其建议值的摘要。
表 107-79 LOADCLOBFROMFILE 参数的建议值
| Parameter | Suggested Value | Description |
|---|---|---|
| amount | DBMS_LOB.LOBMAXSIZE (IN) | 加载整个文件 |
| dest_offset | 1 (IN) | 从头开始 |
| src_offset | 1 (IN) | 从头开始 |
| csid | 0 (IN) | 默认 csid，使用目标 csid |
| lang_context | 0 (IN) | 默认语言上下文 |
| warning | 0 (OUT) | 无警告信息，一切正常 |
`DBMSLOB.SQL` 中定义的常量
```
lobmaxsize                    CONSTANT INTEGER        := 18446744073709551615;
warn_inconvertible_char       CONSTANT INTEGER        := 1;
default_csid                  CONSTANT INTEGER        := 0;
default_lang_ctx              CONSTANT INTEGER        := 0;
no_warning                    CONSTANT INTEGER        := 0;
```
异常
表 107-80 LOADCLOBFROMFILE 过程异常
| Exception | Description |
|---|---|
| VALUE_ERROR | 任何输入参数为 NULL 或 INVALID。 |
| INVALID_ARGVAL | 满足以下任一条件： - src_offset 或 dest_offset < 1。 - src_offset 或 dest_offset > LOBMAXSIZE。 - amount < 1。 - amount > LOBMAXSIZE。 |
| BUFFERING_ENABLED | 如果 CLOB 启用了缓冲，则无法在启用 LOB 缓冲的情况下执行操作 |
另请参阅：
Oracle Database SecureFiles and Large Objects Developer's Guide 获取有关此过程用法的更多详细信息

#### LOADFROMFILE Procedure

此已弃用的过程将源外部 LOB（`BFILE`）的全部或部分复制到目标内部 LOB。
注意：
从 Oracle Database 12c release 12.2 开始，此过程已被弃用。
语法
```
DBMS_LOB.LOADFROMFILE (
   dest_lob    IN OUT NOCOPY BLOB,
   src_file    IN            BFILE,
   amount      IN            INTEGER,
   dest_offset IN            INTEGER  := 1,
   src_offset  IN            INTEGER  := 1);
```
参数
Table 107-81 LOADFROMFILE Procedure Parameters
| Parameter | Description |
|---|---|
| dest_lob | 加载目标的 LOB 定位器。 |
| src_file | 加载源的 BFILE 定位器。 |
| amount | 要从 BFILE 加载的字节数。 |
| dest_offset | 目标 LOB 中加载起始位置的字节或字符偏移量（起始值为 1）。 |
| src_offset | 源 BFILE 中加载起始位置的字节偏移量（起始值为 1）。 |
使用注意事项
您可以指定源和目标 LOB 的偏移量，以及要从源 `BFILE` 复制的字节数。`amount` 和 `src_offset` 因为引用的是 `BFILE`，所以以字节为单位；而对于 `BLOB` 和 `CLOB`，`dest_offset` 分别以字节或字符为单位。
注意：
在使用此过程之前，必须先打开输入 `BFILE`。将二进制 `BFILE` 数据加载到 `CLOB` 时不会隐式执行字符集转换。`BFILE` 数据必须已经与数据库中 `CLOB` 的字符集相同。不会执行任何错误检查来验证这一点。
如果您在目标 LOB 中指定的偏移量超出了该 LOB 中当前数据的末尾，则会在目标 `BLOB` 或 `CLOB` 中分别插入零字节填充符或空格。如果偏移量小于目标 LOB 的当前长度，则现有数据将被覆盖。
如果输入的 amount 加上 offset 超过了 `BFILE` 中数据的长度，将会报错。
注意：
如果字符集是变宽字符集（例如 UTF-8），LOB 值会以固定宽度的 UCS2 格式存储。因此，如果您正在使用 `DBMS_LOB.LOADFROMFILE`，BFILE 中的数据应采用 UCS2 字符集而不是 UTF-8 字符集。但是，您应该使用 `sql*loader` 而不是 `LOADFROMFILE` 将数据加载到 CLOB 或 NCLOB 中，因为 `sql*loader` 提供了必要的字符集转换。
您并非必须将 LOB 操作封装在 Open/Close 接口中。如果您在执行操作之前未打开 LOB，则在调用期间会更新 LOB 列上的函数索引和域索引。但是，如果您在执行操作之前打开了 LOB，则必须在提交事务之前关闭它。当内部 LOB 关闭时，它会更新 LOB 列上的函数索引和域索引。
如果您没有将 LOB 操作封装在 Open/Close API 中，则每次写入 LOB 时都会更新函数索引和域索引。这可能会对性能产生不利影响。因此，建议您将对 LOB 的写操作包含在 `OPEN` 或 `CLOSE` 语句中。
异常
Table 107-82 LOADFROMFILE Procedure Exceptions
| Exception | Description |
|---|---|
| VALUE_ERROR | 任何输入参数为 NULL 或 INVALID。 |
| INVALID_ARGVAL | 满足以下任一条件： - src_offset 或 dest_offset < 1。 - src_offset 或 dest_offset > LOBMAXSIZE。 - amount < 1。 - amount > LOBMAXSIZE。 |
另请参阅：
Oracle Database SecureFiles and Large Objects Developer's Guide，了解有关此过程使用的更多详细信息

#### MOVE_TO_DBFS_LINK 过程

此过程将指定的 LOB 数据（来自数据库）归档到 DBFS HSM Store 中。
语法
```
DBMS_LOB.MOVE_TO_DBFS_LINK (
  lob_loc       IN OUT BLOB,
  storage_path  IN     VARCHAR2(dbfs_link_path_max_size),
  flags         IN     BINARY INTEGER DEFAULT DBFS_LINK_NOCACHE);
DBMS_LOB.MOVE_TO_DBFS_LINK (
  lob_loc       IN OUT CLOB CHARACTER SET ANY_CS,
  storage_path  IN     VARCHAR2(dbfs_link_path_max_size),
  flags         IN     BINARY INTEGER DEFAULT DBFS_LINK_NOCACHE);
```
参数
表 107-83 MOVE_TO_DBFS_LINK 过程参数
| 参数 | 描述 |
|---|---|
| lob_loc | 要归档的 LOB |
| storage_path | 存储 LOB 的路径 |
| flags | DBFS_LINK_CACHE 或 DBFS_LINK_NOCACHE。如果指定 DBFS_LINK_CACHE，LOB 数据将继续存储在 RDBMS 中，同时也会写入 DBFS store。DBFS_LINK_NOCACHE 指定一旦写入 DBFS，LOB 数据应从 RDBMS 中删除。 |
异常
表 107-84 MOVE_TO_DBFS_LINK 过程异常
| 异常 | 描述 |
|---|---|
| SECUREFILE_BADLOB | lob_loc 不是 SECUREFILE |
使用说明
````
- 如果 LOB 已经被归档，该过程会静默返回，就像 put 操作成功一样。在这种情况下，如果指定了 DBFS_LINK_NOCACHE，或者 flags 为默认值，LOB 数据将从 RDBMS 中移除。
- 使用相同的 flags 对同一个 LOB 多次调用此过程没有任何影响。
````
- 对已经归档的 LOB 调用此过程，将根据标志设置导致该 LOB 被缓存 (DBFS_LINK_CACHE) 或被移除 (DBFS_LINK_NOCACHE)。

#### OPEN Procedures

此过程以指定模式打开 LOB（内部或外部）。有效模式包括只读和读/写。
语法
```
DBMS_LOB.OPEN (
   lob_loc   IN OUT NOCOPY BLOB,
   open_mode IN            BINARY_INTEGER);
DBMS_LOB.OPEN (
   lob_loc   IN OUT NOCOPY CLOB CHARACTER SET ANY_CS,
   open_mode IN            BINARY_INTEGER);
DBMS_LOB.OPEN (
   file_loc  IN OUT NOCOPY BFILE,
   open_mode IN            BINARY_INTEGER := file_readonly);
```
参数
Table 107-85 OPEN Procedure Parameters
| Parameter | Description |
|---|---|
| lob_loc | LOB 定位器。有关更多信息，请参见操作说明。 |
| open_mode | 打开模式。对于 BLOB 和 CLOB 类型，模式可以为：LOB_READONLY 或 LOB_READWRITE。对于 BFILE 类型，模式必须为 FILE_READONLY。 |
使用说明
注意：
如果 LOB 是以只读模式打开的，并且您尝试写入该 LOB，则会返回错误。`BFILE` 只能以只读模式打开。
对于内部和外部 LOB，`OPEN` 都需要与服务器进行一次往返通信。对于内部 LOB，`OPEN` 会触发依赖于 `OPEN` 调用的其他代码。对于外部 LOB（`BFILEs`），`OPEN` 需要进行一次往返通信，因为服务器端的实际操作系统文件正在被打开。
您并非必须将所有 LOB 操作都封装在 Open/Close 接口内。但是，如果您打开了 LOB，则必须在提交事务之前关闭它；否则会产生错误。当内部 LOB 被关闭时，它会更新 LOB 列上的函数索引和域索引。
在关闭由该事务打开的所有已打开 LOB 之前提交事务是错误的。当返回此错误时，已打开 LOB 的打开状态将被放弃，但事务会成功提交。因此，事务中对 LOB 和非 LOB 数据所做的所有更改都会被提交，但域索引和基于函数的索引不会被更新。如果发生这种情况，您应该重建 LOB 列上的函数索引和域索引。
另请参见：
Oracle Database SecureFiles and Large Objects Developer's Guide 获取有关此过程使用的更多详细信息

#### READ 过程

此过程读取 LOB 的一部分，并从 LOB 开头的绝对偏移量开始，将指定数量返回到 `buffer` 参数中。实际读取的字节数或字符数将返回到 `amount` 参数中。如果输入的 `offset` 超过了 LOB 的末尾，则 `amount` 将被设置为 0，并引发 `NO_DATA_FOUND` 异常。

语法
```
DBMS_LOB.READ (
   lob_loc   IN             BLOB,
   amount    IN OUT  NOCOPY INTEGER,
   offset    IN             INTEGER,
   buffer    OUT            RAW);
DBMS_LOB.READ (
   lob_loc   IN             CLOB CHARACTER SET ANY_CS,
   amount    IN OUT  NOCOPY INTEGER,
   offset    IN             INTEGER,
   buffer    OUT            VARCHAR2 CHARACTER SET lob_loc%CHARSET);
DBMS_LOB.READ (
   file_loc   IN             BFILE,
   amount    IN OUT   NOCOPY INTEGER,
   offset    IN              INTEGER,
   buffer    OUT             RAW);
```
参数
表 107-86 READ 过程参数
| Parameter | Description |
|---|---|
| lob_loc | 要读取的 LOB 的定位器。更多信息请参见操作说明。 |
| file_loc | 要检查的 LOB 的文件定位器。 |
| amount | 要读取的字节数（对于 BLOB）或字符数（对于 CLOB），或者已经读取的数量。 |
| offset | 从 LOB 起始位置开始的偏移量（以字节为单位，对于 BLOB；或以字符为单位，对于 CLOB）（起始值为 1）。 |
| buffer | 用于读取操作的输出缓冲区。 |

异常
表 107-87 列出了适用于任何 LOB 实例的异常。表 107-88 列出了仅适用于 `BFILE` 的异常。

表 107-87 READ 过程异常
| Exception | Description |
|---|---|
| VALUE_ERROR | lob_loc、amount 或 offset 参数中任何一个为 NULL。 |
| INVALID_ARGVAL | 满足以下任意条件： - amount < 1 - amount > 32767 字节（或等效字符数） - offset < 1 - offset > LOBMAXSIZE - amount（按字节或字符计）大于 buffer 的容量。 |
| NO_DATA_FOUND | 已到达 LOB 的末尾，并且没有更多可从 LOB 读取的字节或字符：amount 的值为 0。 |

表 107-88 针对 BFILE 的 READ 过程异常
| Exception | Description |
|---|---|
| UNOPENED_FILE | 未使用输入定位器打开文件。 |
| NOEXIST_DIRECTORY | 目录不存在。 |
| NOPRIV_DIRECTORY | 您没有该目录的权限。 |
| INVALID_DIRECTORY | 文件打开后目录已失效。 |
| INVALID_OPERATION | 文件不存在，或者您没有该文件的访问权限。 |
| BUFFERING_ENABLED | 如果对 LOB 启用了缓冲，则无法在启用 LOB 缓冲的情况下执行操作。 |

使用说明
````````````
- VARCHAR2 缓冲区的形式必须与 CLOB 参数的形式匹配。换言之，如果输入的 LOB 参数类型为 NCLOB，则缓冲区必须包含 NCHAR 数据。反之，如果输入的 LOB 参数类型为 CLOB，则缓冲区必须包含 CHAR 数据。
````````
- 从客户端调用 DBMS_LOB.READ 时（例如，在 SQL*Plus 内的 BEGIN/END 块中），返回的缓冲区包含客户端字符集的数据。数据库在将缓冲区返回给用户之前，会将 LOB 值从服务器字符集转换为客户端字符集。
- 必要时，READ 会在读取之前获取 LOB。
- 如果 LOB 是 DBFS LINK，则会尽可能从 DBFS 流式传输数据，否则将引发异常。

另请参见：
Oracle Database SecureFiles and Large Objects Developer's Guide，获取有关此过程用法的更多详细信息。

#### SET_DBFS_LINK 过程

此过程将指定的 SecureFile 链接到指定的路径名。它不会将数据复制到该路径。
语法
```
DBMS_LOB.SET_DBFS_LINK (
  lob_loc        IN OUT BLOB,
  archive_id     IN     RAW(1024));
DBMS_LOB.SET_DBFS_LINK(
  lob_loc_dst    IN OUT CLOB CHARACTER SET ANY_CS,
  archive_id     IN     RAW(1024));
```
参数
表 107-89 SET_DBFS_LINK 过程参数
| 参数 | 描述 |
|---|---|
| lob_loc | 用于存储引用值的 LOB |
| archive_id | 通过调用任意一个 GET_DBFS_LINK 函数所返回的归档 ID |
异常
表 107-90 SET_DBFS_LINK 过程异常
| 异常 | 描述 |
|---|---|
| SECUREFILE_BADLOB | lob_loc 不是 SECUREFILE |

#### SETCONTENTTYPE Procedure

此过程为 LOB 中的数据设置内容类型字符串。
语法
```
DBMS_LOB.SETCONTENTTYPE (
   lob_loc      IN OUT NOCOPY BLOB,
   contenttype  IN            VARCHAR2);
DBMS_LOB.SETCONTENTTYPE (
   lob_loc     IN OUT NOCOPY CLOB CHARACTER SET ANY_CS,
   contenttype IN            VARCHAR2);
```
参数
Table 107-91 SETCONTENTTYPE Procedure Parameters
| Parameter | Description |
|---|---|
| lob_loc | 要为其指定内容类型的 LOB |
| contenttype | 要指定的字符串 |
异常
Table 107-92 SETCONTENTTYPE Procedure Exceptions
| Exception | Description |
|---|---|
| SECUREFILE_BADLOB | lob_loc 不是 SECUREFILE |
使用说明
要清除与 `SECUREFILE` 关联的现有内容类型，请调用 `SETCONTENTTYPE` 并将 `contenttype` 设置为空字符串。

#### SETOPTIONS 过程

此过程按每个 LOB 为基础启用/禁用压缩和去重，覆盖默认的 LOB 列设置。
语法
```
DBMS_LOB.SETOPTIONS (
   lob_loc             IN     BLOB,
   option_types        IN     PLS_INTEGER,
   options             IN     PLS_INTEGER);
DBMS_LOB.SETOPTIONS (
  lob_loc             IN     CLOB CHARACTER SET ANY_CS,
  option_types        IN     PLS_INTEGER,
  options             IN     PLS_INTEGER);
```
参数
表 107-93 SETOPTIONS 过程参数
| Parameter | Description |
|---|---|
| lob_loc | 要检查的 LOB 的定位器。更多信息请参见操作说明。 |
| option_type | 参见表 107-2 |
| options | 参见表 107-3 |
异常
表 107-94 SETOPTIONS 过程异常
| Exception | Description |
|---|---|
| SECUREFILE_BADLOB | 不支持该操作的对象类型 |
| INVALID_ARGVAL | 参数值无效 |
| QUERY_WRITE | 查询期间无法执行操作 |
| BUFFERING_ENABLED | 启用 LOB 缓冲时无法执行操作 |
使用说明
- DBMS_LOB.SETOPTIONS 不能用于启用或禁用单个 LOB 的加密。
````
- 如果在创建表时未启用 SecureFile 列的压缩或去重功能，则无法为其开启或关闭这些功能。GETOPTIONS 函数和 SETOPTIONS 过程作用于单个 SecureFiles。如果已通过 SETOPTIONS 关闭了特定 SecureFiles LOB 的压缩或去重，则可以将其关闭并重新开启。
- 此调用会产生一次到服务器的往返，以使更改持久化。

#### SUBSTR Functions

此函数从 LOB 起始处开始，按照绝对 `offset` 返回 LOB 的 `amount` 个字节或字符。
对于固定宽度为 `n` 字节的 `CLOBs`，如果 `SUBSTR` 的输入 `amount` 大于 (32767/`n`)，则 `SUBSTR` 返回长度为 (32767/`n`) 或 `CLOB` 自身长度的字符缓冲区，以两者中较小者为准。对于变宽字符集中的 CLOBs，`n` 是 CLOB 中字符使用的最大字节宽度。
语法
```
DBMS_LOB.SUBSTR (
   lob_loc     IN    BLOB,
   amount      IN    INTEGER := 32767,
   offset      IN    INTEGER := 1)
  RETURN RAW;
DBMS_LOB.SUBSTR (
   lob_loc     IN    CLOB   CHARACTER SET ANY_CS,
   amount      IN    INTEGER := 32767,
   offset      IN    INTEGER := 1)
  RETURN VARCHAR2 CHARACTER SET lob_loc%CHARSET;
DBMS_LOB.SUBSTR (
   file_loc     IN    BFILE,
   amount      IN    INTEGER := 32767,
   offset      IN    INTEGER := 1)
  RETURN RAW;
```
Pragma
```
pragma restrict_references(SUBSTR, WNDS, WNPS, RNDS, RNPS);
```
参数
Table 107-95 SUBSTR Function Parameters
| Parameter | Description |
|---|---|
| lob_loc | 要读取的 LOB 的定位器。更多信息，请参见操作说明。 |
| file_loc | 要检查的 LOB 的文件定位器。 |
| amount | 要读取的字节数（对于 BLOBs）或字符数（对于 CLOBs）。 |
| offset | 从 LOB 起始处算起的字节偏移量（对于 BLOBs）或字符偏移量（对于 CLOBs）（起始值为 1）。 |
返回值
Table 107-96 SUBSTR Function Return Values
| Return | Description |
|---|---|
| RAW | 参数中包含 BLOB 或 BFILE 的函数重载。 |
| VARCHAR2 | CLOB 版本。 |
| NULL | 满足以下任一条件：- 任何输入参数为 NULL - amount < 1 - amount > 32767 - offset < 1 - offset > LOBMAXSIZE |
异常
Table 107-97 SUBSTR Function Exceptions for BFILE operations
| Exception | Description |
|---|---|
| UNOPENED_FILE | 文件未使用输入定位器打开。 |
| NOEXIST_DIRECTORY | 目录不存在。 |
| NOPRIV_DIRECTORY | 您没有该目录的权限。 |
| INVALID_DIRECTORY | 目录在文件打开后已失效。 |
| INVALID_OPERATION | 文件不存在，或者您没有该文件的访问权限。 |
| BUFFERING_ENABLED | 如果在 LOB 上启用了缓冲，则无法在启用 LOB 缓冲的情况下执行操作。 |
使用说明
````````````
- VARCHAR2 缓冲区的形式必须与 CLOB 参数的形式匹配。换句话说，如果输入 LOB 参数的类型为 NCLOB，则缓冲区必须包含 NCHAR 数据。反之，如果输入 LOB 参数的类型为 CLOB，则缓冲区必须包含 CHAR 数据。
````````
- 从客户端调用 DBMS_LOB.SUBSTR 时（例如，在 SQL*Plus 中的 BEGIN/END 块内），返回的缓冲区包含客户端字符集的数据。数据库在将缓冲区返回给用户之前，会将 LOB 值从服务器字符集转换为客户端字符集。
````
- 根据存储在 LOBs 中的字符，DBMS_LOB.SUBSTR 将返回 8191 个或更多字符。如果由于字符字节大小超出了可用缓冲区而导致未能返回所有字符，用户应使用新的 offset 调用 DBMS_LOB.SUBSTR 来读取剩余字符，或者循环调用该子程序直到提取出所有数据。
- 必要时，SUBSTR 会在读取前获取 LOB。
- 如果 LOB 是 DBFS Link，则会尽可能从 DBFS 流式传输数据，否则将引发异常。
另请参见：
- "INSTR Functions"
- "READ Procedures"
- Oracle Database SecureFiles and Large Objects Developer's Guide for additional details on usage of this procedure

#### TRIM 过程

此过程将内部 LOB 的值截断为你在 `newlen` 参数中指定的长度。对于 `BLOBs` 以字节为单位指定长度，对于 `CLOBs` 以字符为单位指定长度。
注意：
`TRIM` 过程会将 LOB 的长度缩减为 `newlen` 参数中指定的值。如果你尝试对空的 LOB 执行 `TRIM`，则不会发生任何操作，并且 `TRIM` 不会返回错误。如果你在 `newlen` 中指定的新长度大于 LOB 的大小，则会引发异常。
语法
```
DBMS_LOB.TRIM (
   lob_loc        IN OUT  NOCOPY BLOB,
   newlen         IN             INTEGER);
DBMS_LOB.TRIM (
   lob_loc        IN OUT  NOCOPY CLOB CHARACTER SET ANY_CS,
   newlen         IN             INTEGER);
```
 参数
表 107-98 TRIM 过程参数
| Parameter | Description |
|---|---|
| lob_loc | 要截断长度的内部 LOB 的定位器。有关更多信息，请参见操作说明。 |
| newlen | LOB 值的新截断长度，对于 BLOBs 以字节为单位，对于 CLOBs 以字符为单位。 |
异常
表 107-99 TRIM 过程异常
| Exception | Description |
|---|---|
| VALUE_ERROR | lob_loc 为 NULL。 |
| INVALID_ARGVAL | 满足以下任一条件： - new_len < 0 - new_len > LOBMAXSIZE |
| QUERY_WRITE | 无法在查询或 PDML 并行执行服务器内执行 LOB 写入 |
| BUFFERING_ENABLED | 如果在 LOB 上启用了缓冲，则无法在启用 LOB 缓冲的情况下执行操作 |
使用说明
- 你并非必须将 LOB 操作封装在 Open/Close 接口内。如果你在执行操作前未打开 LOB，则 LOB 列上的函数索引和域索引会在调用期间更新。但是，如果你在执行操作前打开了 LOB，则必须在提交事务之前将其关闭。当内部 LOB 关闭时，它会更新 LOB 列上的函数索引和域索引。
````
- 如果你不将 LOB 操作封装在 Open/Close API 内，则每次写入 LOB 时都会更新函数索引和域索引。这可能会对性能产生不利影响。因此，建议你将 LOB 的写操作包含在 OPEN 或 CLOSE 语句中。
- 在更改 LOB 长度之前，如有必要，TRIM 会先获取 LOB，除非指定的新长度为 '0'
另请参见：
- "ERASE Procedures"
- "WRITEAPPEND Procedures"
- 有关此过程用法的更多详细信息，请参见 Oracle Database SecureFiles and Large Objects Developer's Guide

#### WRITE Procedures

此过程从 LOB 起始处的绝对偏移量开始，将指定数量的数据写入内部 LOB。数据从 `buffer` 参数写入。
`WRITE` 会替换（覆盖）LOB 中指定偏移量处已存在的、且长度为您所指定长度的任何数据。

语法
```
DBMS_LOB.WRITE (
   lob_loc  IN OUT NOCOPY  BLOB,
   amount   IN             INTEGER,
   offset   IN             INTEGER,
   buffer   IN             RAW);
DBMS_LOB.WRITE (
   lob_loc  IN OUT  NOCOPY CLOB   CHARACTER SET ANY_CS,
   amount   IN             INTEGER,
   offset   IN             INTEGER,
   buffer   IN             VARCHAR2 CHARACTER SET lob_loc%CHARSET);
```

参数
表 107-100 WRITE Procedure Parameters
| Parameter | Description |
|---|---|
| lob_loc | 要写入的内部 LOB 的定位器。更多信息，请参见“操作说明” |
| amount | 要写入的字节数（对于 BLOB）或字符数（对于 CLOB） |
| offset | 从 LOB 起始处（原点：1）算起的写入操作偏移量，以字节（对于 BLOB）或字符（对于 CLOB）为单位。 |
| buffer | 用于写入的输入缓冲区 |

异常
表 107-101 WRITE Procedure Exceptions
| Exception | Description |
|---|---|
| VALUE_ERROR | lob_loc、amount 或 offset 参数中任何一个为 NULL、超出范围或 INVALID。 |
| INVALID_ARGVAL | 满足以下任一条件：- amount < 1 - amount > 32767 字节（或等效字符数）- offset < 1 - offset > LOBMAXSIZE |
| QUERY_WRITE | 无法在查询或 PDML 并行执行服务器内执行 LOB 写入 |
| BUFFERING_ENABLED | 如果在 LOB 上启用了缓冲，则无法在启用 LOB 缓冲的情况下执行操作 |
| SECUREFILE_OUTOFBOUNDS | 尝试对带有 FRAGMENT_* 的 LOB 执行超过其末尾的写入操作 |

使用说明
````
- 如果输入的 amount 大于 buffer 中的数据量，则会引发错误。如果输入的 amount 小于 buffer 中的数据量，则仅将 buffer 中 amount 数量的字节或字符写入 LOB。如果您指定的 offset 超出了 LOB 中当前数据的末尾，则会分别在 BLOB 或 CLOB 中插入零字节填充符或空格。
````````````
- VARCHAR2 buffer 的形式必须与 CLOB 参数的形式匹配。换言之，如果输入的 LOB 参数类型为 NCLOB，则 buffer 必须包含 NCHAR 数据。反之，如果输入的 LOB 参数类型为 CLOB，则 buffer 必须包含 CHAR 数据。
````````
- 从客户端调用 DBMS_LOB.WRITE 时（例如，在 SQL*Plus 中的 BEGIN/END 块内），buffer 必须包含客户端字符集的数据。数据库会在将缓冲区数据写入 LOB 之前，将客户端缓冲区转换为服务器字符集。
- 您不一定要将 LOB 操作封装在 Open/Close 接口内。如果在执行操作前未打开 LOB，则 LOB 列上的函数索引和域索引会在调用期间更新。但是，如果您在执行操作前打开了 LOB，则必须在提交事务之前将其关闭。当内部 LOB 关闭时，它会更新 LOB 列上的函数索引和域索引。
````
- 如果您没有将 LOB 操作封装在 Open/Close API 内，则每次写入 LOB 时都会更新函数索引和域索引。这可能会对性能产生不利影响。因此，建议您将对 LOB 的写入操作包含在 OPEN 或 CLOSE 语句中。
- WRITE 在写入 LOB 之前（如有必要）会先获取 LOB，除非指定该写入操作将覆盖整个 LOB。

另请参见：
- "APPEND Procedures"
- "COPY Procedures"
- Oracle Database SecureFiles and Large Objects Developer's Guide 了解有关此过程用法的更多细节

#### WRITEAPPEND 过程

此过程将指定数量的数据写入内部 LOB 的末尾。数据从 `buffer` 参数写入。
语法
```
DBMS_LOB.WRITEAPPEND (
   lob_loc IN OUT NOCOPY BLOB,
   amount  IN            INTEGER,
   buffer  IN            RAW);
DBMS_LOB.WRITEAPPEND (
   lob_loc IN OUT NOCOPY CLOB CHARACTER SET ANY_CS,
   amount  IN            INTEGER,
   buffer  IN            VARCHAR2 CHARACTER SET lob_loc%CHARSET);
```
参数
表 107-102 WRITEAPPEND 过程参数
| 参数 | 描述 |
|---|---|
| lob_loc | 要写入的内部 LOB 的定位器。有关更多信息，请参见操作说明 |
| amount | 要写入的字节数（对于 BLOB）或字符数（对于 CLOB） |
| buffer | 用于写入的输入缓冲区 |
用法说明
如果输入的 amount 大于缓冲区中的数据，则会发生错误。如果输入的 amount 小于缓冲区中的数据，则只会将缓冲区中的 amount 字节或字符写入 LOB 的末尾。
异常
表 107-103 WRITEAPPEND 过程异常
| 异常 | 描述 |
|---|---|
| VALUE_ERROR | lob_loc、amount 或 offset 参数为 NULL、超出范围或 INVALID。 |
| INVALID_ARGVAL | 满足以下任一条件：- amount < 1 - amount > 32767 字节（或等量的字符数） |
| QUERY_WRITE | 无法在查询或 PDML 并行执行服务器内部执行 LOB 写入 |
| BUFFERING_ENABLED | 如果在 LOB 上启用了缓冲，则无法在启用缓冲的情况下执行 LOB 操作 |
用法说明
````````````
- VARCHAR2 缓冲区的形式必须与 CLOB 参数的形式匹配。换言之，如果输入 LOB 参数的类型为 NCLOB，则缓冲区必须包含 NCHAR 数据。反之，如果输入 LOB 参数的类型为 CLOB，则缓冲区必须包含 CHAR 数据。
````````
- 从客户端调用 DBMS_LOB.WRITEAPPEND 时（例如，在 SQL*Plus 内的 BEGIN/END 块中），缓冲区必须包含客户端字符集的数据。数据库在将缓冲区数据写入 LOB 之前，会将客户端缓冲区转换为服务器字符集。
- 不必将 LOB 操作封装在 Open/Close 接口内。如果在执行操作之前未打开 LOB，则在调用期间会更新 LOB 列上的功能索引和域索引。但是，如果在执行操作之前打开了 LOB，则必须在提交事务之前将其关闭。当内部 LOB 关闭时，它会更新 LOB 列上的功能索引和域索引。
````
- 如果不将 LOB 操作封装在 Open/Close API 内，则每次写入 LOB 时都会更新功能索引和域索引。这可能会对性能产生不利影响。因此，建议将 LOB 的写入操作包含在 OPEN 或 CLOSE 语句中。
- WRITEAPPEND 在追加到 LOB 之前，如有必要会先获取 LOB。
另请参见：
- "APPEND Procedures"
- "COPY Procedures"
- "WRITE Procedures"
- Oracle Database SecureFiles and Large Objects Developer's Guide for additional details on usage of this procedure
