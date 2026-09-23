# SQL与描述

SQL 执行与描述（对应 GaussDB DBE_SQL、DBE_DESCRIBE）。

---

## DBMS_SQL

**包用途**：提供用 PL/SQL 解析任意 DML/DDL 语句的动态 SQL 接口（如从存储过程执行 `DROP TABLE`）。多数情况原生动态 SQL（EXECUTE IMMEDIATE）更易用且性能更好，但 DBMS_SQL 支持 Method 4（输入/输出数未知）等场景。

**接口清单（全部）**：

| Subprogram | 说明 |
|---|---|
| BIND_ARRAY | 将给定值绑定到给定集合 |
| BIND_VARIABLE | 将给定值绑定到给定变量 |
| BIND_VARIABLE_PKG | 将给定值绑定到给定包变量 |
| CLOSE_CURSOR | 关闭给定游标并释放内存 |
| COLUMN_VALUE | 返回游标中指定位置元素的值 |
| COLUMN_VALUE_LONG | 返回用 DEFINE_COLUMN_LONG 定义的 LONG 列的选定部分 |
| DEFINE_ARRAY | 定义从给定游标选择的集合（仅 SELECT） |
| DEFINE_COLUMN | 定义从给定游标选择的列（仅 SELECT） |
| DEFINE_COLUMN_CHAR | 定义选择的 CHAR 类型列 |
| DEFINE_COLUMN_LONG | 定义选择的 LONG 列 |
| DEFINE_COLUMN_RAW | 定义选择的 RAW 类型列 |
| DEFINE_COLUMN_ROWID | 定义选择的 ROWID 类型列 |
| DESCRIBE_COLUMNS | 描述通过 DBMS_SQL 打开并解析的游标的列 |
| DESCRIBE_COLUMNS2 | 描述指定列（DESCRIBE_COLUMNS 的替代） |
| DESCRIBE_COLUMNS3 | 描述指定列（DESCRIBE_COLUMNS 的替代） |
| EXECUTE | 执行给定游标 |
| EXECUTE_AND_FETCH | 执行给定游标并取行 |
| FETCH_ROWS | 从给定游标取一行 |
| GET_NEXT_RESULT | 获取递归语句返回给调用者的下一条结果 |
| IS_OPEN | 游标是否打开 |
| LAST_ERROR_POSITION | 返回出错处 SQL 文本的字节偏移 |
| LAST_ROW_COUNT | 返回已取行的累计数 |
| LAST_ROW_ID | 返回最后处理行的 ROWID |
| LAST_SQL_FUNCTION_CODE | 返回语句的 SQL 函数码 |
| OPEN_CURSOR | 返回新游标的 ID 号 |
| PARSE | 解析给定语句 |
| RETURN_RESULT | 将已执行语句的结果返回给客户端应用 |
| TO_CURSOR_NUMBER | 将已打开的强/弱类型 ref 游标转为 DBMS_SQL 游标号 |
| TO_REFCURSOR | 将已打开、解析、执行的游标转为 PL/SQL 可用的 REF CURSOR |
| VARIABLE_VALUE | 返回给定游标中命名变量的值 |
| VARIABLE_VALUE_PKG | 返回包内命名变量的值（用于 returning 子句） |

---

## DBMS_DESCRIBE

**包用途**：声明两个 PL/SQL 表类型，用于保存 DESCRIBE_PROCEDURE 的 OUT 参数返回数据。功能同 OCI 的 OCIDescribeAny 调用。

| Subprogram | 说明 |
|---|---|
| DESCRIBE_PROCEDURE | 给出 PL/SQL 存储过程的简要描述 |


---

## DBMS_DESCRIBE 详细（机译）

## DBMS_DESCRIBE
您可以使用 `DBMS_DESCRIBE` 包获取有关 PL/SQL 对象的信息。当您指定对象名时，`DBMS_DESCRIBE` 会返回一组带有结果的索引表。它会执行完整名称转换，并对最终对象进行安全检查。
本章包含以下主题：
- 概述
- 安全模型
- 类型
- 异常
- 示例
- DBMS_DESCRIBE 子程序摘要
### DBMS_DESCRIBE 概述
此包提供与 Oracle 调用接口 `OCIDescribeAny` 调用相同的功能。
另请参见：
Oracle Call Interface Programmer's Guide
### DBMS_DESCRIBE 安全模型
此包可供 `PUBLIC` 使用，并根据所描述的方案对象执行其自身的安全检查。
### DBMS_DESCRIBE 类型
`DBMS_DESCRIBE` 包声明了两种 PL/SQL 表类型，用于在 `DESCRIBE_PROCEDURE` 的 `OUT` 参数中保存返回的数据。
这些类型是：
```
TYPE VARCHAR2_TABLE IS TABLE OF VARCHAR2(30)
    INDEX BY BINARY_INTEGER;
TYPE NUMBER_TABLE IS TABLE OF NUMBER
    INDEX BY BINARY_INTEGER;
```
### DBMS_DESCRIBE 异常
`DBMS_DESCRIBE` 可能会引发 -20000 到 -20000 范围内的应用程序错误。
Table 66-1 DBMS_DESCRIBE 错误
| Error | Description |
|---|---|
| ORA-20000 | ORU 10035: 无法描述包 ('X')，只能描述包内的过程。 |
| ORA-20001 | ORU-10032: 包 'Y' 内的过程 'X' 不存在。 |
| ORA-20002 | ORU-10033: 对象 'X' 是远程的，无法描述；展开名称 'Y'。 |
| ORA-20003 | ORU-10036: 对象 'X' 无效，无法描述。 |
| ORA-20004 | 尝试解析 'X' 时出现语法错误。 |
### DBMS_DESCRIBE 示例
`DESCRIBE_PROCEDURE` 过程的一个用途是作为外部服务接口。
例如，考虑一个客户端，它提供了 `SCOTT`.`ACCOUNT_UPDATE,` 的 `OBJECT_NAME`，其中 `ACCOUNT_UPDATE` 是一个重载函数，其规范如下：
```
TABLE account (accnt_no NUMBER, person_id NUMBER,
               balance NUMBER(7,2))
TABLE person  (person_id number(4), person_nm varchar2(10))
CREATE OR REPLACE PACKAGE ACCOUNT_PKG is   FUNCTION ACCOUNT_UPDATE (accnt_no    NUMBER,
                            person      person%rowtype,
                            amounts     DBMS_DESCRIBE.NUMBER_TABLE,
                            trans_date  DATE)
                            return       account.balance%type;
   FUNCTION ACCOUNT_UPDATE (accnt_no     NUMBER,
                            person       person%rowtype,
                            amounts      DBMS_DESCRIBE.NUMBER_TABLE,
                            trans_no     NUMBER)
                            return       account.balance%type;
END;
```
此过程的输出可能类似于以下内容：
```
overload position  argument level  datatype length prec scale rad
-------- --------- -------- ------ -------- ------ ---- ----- ---
       1        0               0         2     22    7     2  10
       1        1   ACCNT_NO    0         2      0    0     0   0
       1        2   PERSON      0       250      0    0     0   0
       1        1   PERSON_ID   1         2     22    4     0  10
       1        2   PERSON_NM   1         1     10    0     0   0
       1        3   AMOUNTS     0       251      0    0     0   0
       1        1               1         2     22    0     0   0
       1        4   TRANS_DATE  0        12      0    0     0   0
       2        0               0         2     22    7     2  10
       2        1   ACCNT_NO    0         2     22    0     0   0
       2        2   PERSON      0         2     22    4     0  10
       2        3   AMOUNTS     0       251     22    4     0  10
       2        1               1         2      0    0     0   0
       2        4   TRANS_NO    0         2      0    0     0   0
```
以下 PL/SQL 过程的参数包含了所有 PL/SQL 数据类型：
```
CREATE OR REPLACE PROCEDURE p1 (
        pvc2    IN     VARCHAR2,
        pvc     OUT    VARCHAR,
        pstr    IN OUT STRING,
        plong   IN     LONG,
        prowid  IN     ROWID,
        pchara  IN     CHARACTER,
        pchar   IN     CHAR,
        praw    IN     RAW,
        plraw   IN     LONG RAW,
        pbinint IN     BINARY_INTEGER,
        pplsint IN     PLS_INTEGER,
        pbool   IN     BOOLEAN,
        pnat    IN     NATURAL,
        ppos    IN     POSITIVE,
        pposn   IN     POSITIVEN,
        pnatn   IN     NATURALN,
        pnum    IN     NUMBER,
        pintgr  IN     INTEGER,
        pint    IN     INT,
        psmall  IN     SMALLINT,
        pdec    IN     DECIMAL,
        preal   IN     REAL,
        pfloat  IN     FLOAT,
        pnumer  IN     NUMERIC,
        pdp     IN     DOUBLE PRECISION,
        pdate   IN     DATE,
        pmls    IN     MLSLABEL) AS
BEGIN
    NULL;
END;
```
如果您使用以下代码描述此过程：
```
CREATE OR REPLACE PACKAGE describe_it AS
    PROCEDURE desc_proc (name VARCHAR2);
END describe_it;
CREATE OR REPLACE PACKAGE BODY describe_it AS
  PROCEDURE prt_value(val VARCHAR2, isize INTEGER) IS
    n INTEGER;
  BEGIN
    n := isize - LENGTHB(val);
    IF n < 0 THEN
      n := 0;
    END IF;
    DBMS_OUTPUT.PUT(val);
    FOR i in 1..n LOOP
      DBMS_OUTPUT.PUT(' ');
    END LOOP;
  END prt_value;
  PROCEDURE desc_proc (name VARCHAR2) IS
      overload     DBMS_DESCRIBE.NUMBER_TABLE;
      position     DBMS_DESCRIBE.NUMBER_TABLE;
      c_level      DBMS_DESCRIBE.NUMBER_TABLE;
      arg_name     DBMS_DESCRIBE.VARCHAR2_TABLE;
      dty          DBMS_DESCRIBE.NUMBER_TABLE;
      def_val      DBMS_DESCRIBE.NUMBER_TABLE;
      p_mode       DBMS_DESCRIBE.NUMBER_TABLE;
      length       DBMS_DESCRIBE.NUMBER_TABLE;
      precision    DBMS_DESCRIBE.NUMBER_TABLE;
      scale        DBMS_DESCRIBE.NUMBER_TABLE;
      radix        DBMS_DESCRIBE.NUMBER_TABLE;
      spare        DBMS_DESCRIBE.NUMBER_TABLE;
      idx          INTEGER := 0;
  BEGIN
      DBMS_DESCRIBE.DESCRIBE_PROCEDURE(
              name,
              null,
              null,
              overload,
              position,
              c_level,
              arg_name,
              dty,
              def_val,
              p_mode,
              length,
              precision,
              scale,
              radix,
              spare);
      DBMS_OUTPUT.PUT_LINE('Position    Name        DTY  Mode');
      LOOP
          idx := idx + 1;
          prt_value(TO_CHAR(position(idx)), 12);
          prt_value(arg_name(idx), 12);
          prt_value(TO_CHAR(dty(idx)), 5);
          prt_value(TO_CHAR(p_mode(idx)), 5);
          DBMS_OUTPUT.NEW_LINE;
      END LOOP;
  EXCEPTION
     WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.NEW_LINE;
        DBMS_OUTPUT.NEW_LINE;
  END desc_proc;
END describe_it;
```
然后结果会列出 PL/SQL 数据类型的所有数字代码：
```
Position  Name    Datatype_Code  Mode
1         PVC2      1              0
2         PVC       1              1
3         PSTR      1              2
4         PLONG     8              0
5         PROWID    11             0
6         PCHARA    96             0
7         PCHAR     96             0
8         PRAW      23             0
9         PLRAW     24             0
10        PBININT   3              0
11        PPLSINT   3              0
12        PBOOL     252            0
13        PNAT      3              0
14        PPOS      3              0
15        PPOSN     3              0
16        PNATN     3              0
17        PNUM      2              0
18        PINTGR    2              0
19        PINT      2              0
20        PSMALL    2              0
21        PDEC      2              0
22        PREAL     2              0
23        PFLOAT    2              0
24        PNUMER    2              0
25        PDP       2              0
26        PDATE     12             0
27        PMLS      106            0
```
### DBMS_DESCRIBE 子程序摘要
`DBMS_DESCRIBE` 包包含 `DESCRIBE_PROCEDURE` 过程。
Table 66-2 DBMS_DESCRIBE 包子程序
| Subprogram | Description |
|---|---|
| DESCRIBE_PROCEDURE Procedure | 提供 PL/SQL 存储过程的简要描述 |

#### DESCRIBE_PROCEDURE Procedure

过程 `DESCRIBE_PROCEDURE` 提供 PL/SQL 存储过程的简要描述。
它接受存储过程的名称，并返回有关该过程每个参数的信息。
语法
```
DBMS_DESCRIBE.DESCRIBE_PROCEDURE(
   object_name                   IN  VARCHAR2,
   reserved1                     IN  VARCHAR2,
   reserved2                     IN  VARCHAR2,
   overload                      OUT NUMBER_TABLE,
   position                      OUT NUMBER_TABLE,
   level                         OUT NUMBER_TABLE,
   argument_name                 OUT VARCHAR2_TABLE,
   datatype                      OUT NUMBER_TABLE,
   default_value                 OUT NUMBER_TABLE,
   in_out                        OUT NUMBER_TABLE,
   length                        OUT NUMBER_TABLE,
   precision                     OUT NUMBER_TABLE,
   scale                         OUT NUMBER_TABLE,
   radix                         OUT NUMBER_TABLE,
   spare                         OUT NUMBER_TABLE
   include_string_constraints    OUT BOOLEAN DEFAULT FALSE);
```
参数
表 66-3 DBMS_DESCRIBE.DESCRIBE_PROCEDURE 参数
| 参数 | 描述 |
|---|---|
| object_name | 要描述的过程的名称。此参数的语法遵循 SQL 中标识符使用的规则。该名称可以是同义词。此参数为必填项，不能为 null。名称的总长度不能超过 197 字节。错误指定的 OBJECT_NAME 可能导致以下异常之一：ORA-20000 - 指定了包。只能指定存储过程、存储函数、包内过程或包内函数。ORA-20001 - 指定的过程或函数在给定包中不存在。ORA-20002 - 指定的对象是远程对象。此过程当前无法描述远程对象。ORA-20003 - 指定的对象无效，无法描述。ORA-20004 - 对象的指定存在语法错误。 |
| reserved1 reserved2 | 保留供将来使用 -- 必须设置为 NULL 或空字符串。 |
| overload | 分配给过程签名的唯一编号。如果过程是重载的，则此字段为过程的每个版本保存不同的值。 |
| position | 参数在参数列表中的位置。位置 0 返回函数返回类型的值。 |
| level | 如果参数是复合类型（例如 record），则此参数返回数据类型的级别。有关示例，请参阅 Oracle Call Interface Programmer's Guide 中对 ODESSP 调用的描述。 |
| argument_name | 与正在描述的过程关联的参数名称。 |
| datatype | 正在描述的参数的 Oracle 数据类型。数据类型及其数字类型代码为：0 无参数过程的占位符 1 VARCHAR, VARCHAR, STRING 2 NUMBER, INTEGER, SMALLINT, REAL, FLOAT, DECIMAL 3 BINARY_INTEGER, PLS_INTEGER, POSITIVE, NATURAL 8 LONG 11 ROWID 12 DATE 23 RAW 24 LONG RAW 58 OPAQUE TYPE 96 CHAR (ANSI FIXED CHAR), CHARACTER 106 MLSLABEL 121 OBJECT 122 NESTED TABLE 123 VARRAY 178 TIME 179 TIME WITH TIME ZONE 180 TIMESTAMP 181 TIMESTAMP WITH TIME ZONE 231 TIMESTAMP WITH LOCAL TIME ZONE 250 PL/SQL RECORD 251 PL/SQL TABLE 252 PL/SQL BOOLEAN |
| default_value | 如果正在描述的参数具有默认值，则为 1；否则，值为 0。 |
| in_out | 描述参数的模式：0 IN 1 OUT 2 IN OUT |
| length | 对于 %rowtype 形式参数，返回长度约束，否则返回 0。如果 include_string_constraints 参数设置为 TRUE，当参数为适当类型时，将传回该参数的形式长度约束。这些是字符串类型：1;8;23;24;96 |
| precision | 如果正在描述的参数的数据类型为 2 (NUMBER)，则此参数为该数字的 precision。 |
| scale | 如果正在描述的参数的数据类型为 2 (NUMBER)，则此参数为该数字的 scale。 |
| radix | 如果正在描述的参数的数据类型为 2 (NUMBER)，则此参数为该数字的 radix。 |
| spare | 保留供将来功能使用。 |
| include_string_constraints | 默认值为 FALSE。如果该参数设置为 TRUE，当参数为适当类型时，将传回参数的形式类型约束。这些是字符串类型：1;8;23;24;96 |
返回值
来自 `DESCRIBE_PROCEDURE` 的所有值均在其 `OUT` 参数中返回。这些参数的数据类型为 PL/SQL 表，以适应可变数量的参数。


---

## DBMS_SQL 详细（机译）

## DBMS_SQL
`DBMS_SQL` 包提供了一个接口，用于使用动态 SQL 来解析任何数据操作语言 (DML) 或数据定义语言 (DDL) 语句（使用 PL/SQL）。
例如，您可以使用 `DBMS_SQL` 包提供的 PARSE 过程，从存储过程中执行 `DROP` `TABLE` 语句。
本章包含以下主题：
- 概览
- 安全模型
- 常量
- 异常
- 操作说明
- 示例
- 数据结构
- DBMS_SQL 子程序摘要
另请参阅：
有关原生动态 SQL 的更多信息，请参阅 Oracle Database PL/SQL Language Reference。
### DBMS_SQL 概览
Oracle 允许您编写使用动态 SQL 的存储过程和匿名 PL/SQL 块。动态 SQL 语句并不嵌入在您的源程序中；相反，它们存储在程序运行时输入或由程序构建的字符串中。这使您能够创建更通用的过程。例如，动态 SQL 允许您创建一个对表进行操作的过程，而该表的名称直到运行时才知道。
原生动态 SQL 是 `DBMS_SQL` 的替代方案，它允许您将动态 SQL 语句直接放入 PL/SQL 块中。在大多数情况下，原生动态 SQL 比 `DBMS_SQL` 更易于使用且性能更好。但是，原生动态 SQL 本身具有某些限制：
- 不支持所谓的 Method 4（用于输入或输出数量未知的动态 SQL 语句）
````
- 有些任务只能使用 DBMS_SQL 来完成。有关需要 DBMS_SQL 的任务，请参阅 Oracle Database PL/SQL Language Reference。
从存储过程中使用动态 SQL 的能力通常遵循 Oracle 调用接口 (OCI) 的模型。
另请参阅：
Oracle Call Interface Programmer's Guide
PL/SQL 与其他常见编程语言（如 C）略有不同。例如，地址（也称为指针）在 PL/SQL 中对用户是不可见的。因此，Oracle 调用接口和 `DBMS_SQL` 包之间存在一些差异。这些差异包括：
- OCI 按地址绑定，而 DBMS_SQL 包按值绑定。
````````
- 使用 DBMS_SQL 时，您必须调用 VARIABLE_VALUE 来检索匿名块的 OUT 参数的值，并且在提取行之后，您必须调用 COLUMN_VALUE 将行中的列值检索到您的程序中。
````
- 当前版本的 DBMS_SQL 包不提供 CANCEL 游标过程。
- 不需要指示符变量，因为 NULL 作为 PL/SQL 变量的值得到完全支持。
### DBMS_SQL 安全模型
`DBMS_SQL` 是一个由 `SYS` 拥有并使用 `AUTHID` `CURRENT_USER` 编译的包。从匿名 PL/SQL 块调用的任何 `DBMS_SQL` 子程序都以当前用户的权限运行。
另请参阅：
有关使用调用者权限或定义者权限的更多信息，请参阅 Oracle Database PL/SQL Language Reference
防止恶意或意外访问已打开的游标编号
当使用不表示已打开游标的游标编号调用任何 `DBMS_SQL` 子程序时，会引发 `ORA-29471` 错误。引发该错误时，会向警报日志发出警报，并且 DBMS_SQL 在会话的生命周期内将无法操作。
如果在对 IS_OPEN 函数的调用中，游标编号的实际值表示会话中当前打开的游标，则返回值为 `TRUE`。如果实际值为 `NULL`，则返回值为 `FALSE`。否则，将引发 `ORA-29471` 错误。
防止不当使用游标
游标受到保护，防止破坏已知现有游标的安全违规。
在绑定和执行时进行检查。可以选择对每一个 DBMS_SQL 子程序调用执行检查。检查内容为：
- 调用子程序时的 current_user 与调用最近一次解析时的 current_user 相同。
- 调用子程序时启用的角色必须与调用最近一次解析时启用的角色相同。
- 调用子程序时的容器与调用最近一次解析时的容器相同。
与使用定义者权限子程序一致，角色不适用。
如果任一检查失败，则引发 `ORA-29470` 错误。
定义何时执行检查的机制是 `OPEN_CURSOR` 子程序的一个新重载，它接受一个形式参数 `security_level`，其允许值为 `NULL`、`1` 和 `2`。
``````
- 当 security_level = 1（或为 NULL）时，仅在绑定和执行时进行检查。
````
- 当 security_level = 2 时，始终进行检查。
升级注意事项
此安全机制比以前版本中的机制更严格。因此，`DBMS_SQL` 的用户在升级时可能会遇到运行时错误。
### DBMS_SQL 常量
`DBMS_SQL Constants` 包提供了与 `PARSE Procedures` 的 `language_flag` 参数一起使用的常量。
下表描述了这些常量。
表 170-1 DBMS_SQL 常量
| 名称 | 类型 | 值 | 描述 |
|---|---|---|---|
| V6 | INTEGER | 0 | 指定 Oracle 数据库版本 6 行为 |
| NATIVE | INTEGER | 1 | 指定程序连接到的数据库的常规行为 |
| V7 | INTEGER | 2 | 指定 Oracle 数据库版本 7 行为 |
| FOREIGN_SYNTAX | INTEGER | 4294967295 | 指定非 Oracle 数据库语法和行为。要解析的 SQL 语句需要先使用数据库会话中设置的 SQL 转换配置文件进行转换。SQL 转换配置文件是一个数据库模式对象，用于指示如何将 SQL 语句转换为 Oracle 语句。如果未设置配置文件，则会引发错误。 |
**相关主题**
                        - PARSE Procedures
### DBMS_SQL 操作说明
这些操作说明描述了处理查询、处理更新、插入和删除以及定位错误。
处理查询
如果您正在使用动态 SQL 处理查询，则必须执行以下步骤：
- 通过调用 DEFINE_COLUMN 过程、DEFINE_COLUMN_LONG 过程或 DEFINE_ARRAY 过程，指定用于接收 SELECT 语句返回值的变量。
- 通过调用 EXECUTE 函数运行您的 SELECT 语句。
- 调用 FETCH_ROWS 函数（或 EXECUTE_AND_FETCH）检索满足您的查询的行。
- 调用 COLUMN_VALUE 过程或 COLUMN_VALUE_LONG 过程，确定由 FETCH_ROWS 函数为您的查询检索到的列的值。如果您使用了包含对 PL/SQL 过程调用的匿名块，则您必须调用 VARIABLE_VALUE 过程来检索分配给这些过程的输出变量的值。
处理更新、插入和删除
如果您正在使用动态 SQL 处理 `INSERT`、`UPDATE` 或 `DELETE`，则必须执行以下步骤：
``````
- 通过调用 EXECUTE 函数运行您的 INSERT、UPDATE 或 DELETE 语句。
- 如果语句包含 returning 子句，则您必须调用 VARIABLE_VALUE 过程来检索分配给输出变量的值。
定位错误
`DBMS_SQL` 包具有附加功能，用于获取有关会话中最后引用的游标的信息。这些函数返回的值仅在 SQL 语句运行后立即才有意义。此外，某些错误定位函数仅在特定的 `DBMS_SQL` 调用之后才有意义。例如，您在调用某个 PARSE 过程之后立即调用 LAST_ERROR_POSITION 函数。
### DBMS_SQL 执行流程
这些函数构成了 DBMS_SQL 执行流程。
- OPEN_CURSOR
- PARSE
- BIND_VARIABLE, BIND_VARIABLE_PKG 或 BIND_ARRAY
- DEFINE_COLUMN_ DEFINE_COLUMN_LONG_ 或 DEFINE_ARRAY
- EXECUTE
- FETCH_ROWS 或 EXECUTE_AND_FETCH
- VARIABLE_VALUE, VARIABLE_PKG, COLUMN_VALUE 或 COLUMN_VALUE_LONG
- CLOSE_CURSOR

#### OPEN_CURSOR

要处理 SQL 语句，必须拥有一个打开的游标。当您调用 OPEN_CURSOR Functions 时，会获得一个游标 `ID` 号，该编号代表由 Oracle 维护的表示有效游标的数据结构。
这些游标不同于在预编译器、OCI 或 PL/SQL 层级定义的游标，它们仅供 `DBMS_SQL` 包使用。
**相关主题**
                           - OPEN_CURSOR Functions

#### PARSE

每条 SQL 语句都必须通过调用 PARSE 过程进行解析。解析语句会检查语句的语法，并将其与程序中的游标关联。
您可以解析任何 DML 或 DDL 语句。DDL 语句在解析时执行，这会执行隐式提交。
`DBMS_SQL` 的执行流程如 Figure 170-1 所示。
Figure 170-1  DBMS_SQL Execution Flow
"Figure 170-1  DBMS_SQL Execution Flow" 的说明
**相关主题**
                           - PARSE Procedures

#### BIND_VARIABLE, BIND_VARIABLE_PKG or BIND_ARRAY

许多 DML 语句要求将程序中的数据输入到 Oracle。当定义一条在运行时提供输入数据的 SQL 语句时，必须在 SQL 语句中使用占位符来标记必须提供数据的位置。

对于 SQL 语句中的每个占位符，必须调用 BIND_ARRAY Procedures、BIND_VARIABLE Procedures 或 BIND_VARIABLE Procedure 之一，将程序中变量的值（或数组的值）提供给该占位符。当随后运行该 SQL 语句时，Oracle 会使用程序放置在输出和输入变量或绑定变量中的数据。

`DBMS_SQL` 可以多次运行一条 DML 语句——每次使用不同的绑定变量。`BIND_ARRAY` 过程允许绑定标量集合，其中每个值在每次 `EXECUTE` 时被用作一次输入变量。这类似于 OCI 支持的数组接口。

请注意，绑定到占位符的值的数据类型不能是 PL/SQL 专有的数据类型。

#### DEFINE_COLUMN, DEFINE_COLUMN_LONG, or DEFINE_ARRAY

`DEFINE_COLUMN`、`DEFINE_COLUMN_LONG` 和 `DEFINE_ARRAY` 过程用于指定接收查询中 `SELECT` 值的变量。
`SELECT` 语句中所选行的列按其在选择列表中从左到右出现的相对位置进行标识。对于查询，必须调用某个 define 过程（DEFINE_COLUMN Procedures、DEFINE_COLUMN_LONG Procedure 或 DEFINE_ARRAY Procedure）来指定接收 `SELECT` 值的变量，这与 `INTO` 子句在静态查询中的作用非常相似。
使用 `DEFINE_COLUMN_LONG` 过程可定义 `LONG` 列，其使用方式与使用 `DEFINE_COLUMN` 定义非 `LONG` 列相同。在使用 COLUMN_VALUE_LONG Procedure 从 `LONG` 列提取数据之前，必须先调用 `DEFINE_COLUMN_LONG`。
使用 `DEFINE_ARRAY` 过程可定义 PL/SQL 集合，以便在单个 `SELECT` 语句中提取多行数据存入该集合。`DEFINE_ARRAY` 提供了一次提取多行的接口。在使用 `COLUMN_VALUE` 过程提取行之前，必须先调用 `DEFINE_ARRAY`。

#### EXECUTE

调用 `EXECUTE` 函数来运行你的 SQL 语句。
**相关主题**
                           - EXECUTE 函数

#### FETCH_ROWS 或 EXECUTE_AND_FETCH

FETCH_ROWS Function 检索满足查询的行。每次连续的提取都会检索另一批行，直到提取无法再检索到更多行为止。如果您为了单次执行而调用 `EXECUTE`，与其先调用 EXECUTE Function 再调用 `FETCH_ROWS`，您可能会发现直接调用 EXECUTE_AND_FETCH Function 效率更高。
**相关主题**
                           - FETCH_ROWS Function
                           - EXECUTE Function
                           - EXECUTE_AND_FETCH Function

#### VARIABLE_VALUE, VARIABLE_VALUE_PKG, COLUMN_VALUE, or COLUMN_VALUE_LONG

调用的类型决定了要使用哪个过程或函数。
对于查询，调用 COLUMN_VALUE Procedure 以确定由 FETCH_ROWS Function 检索到的列的值。
对于包含对 `PL`/`SQL` 过程调用或带有 `returning` 子句的 DML 语句的匿名块，调用 VARIABLE_VALUE Procedures 或 VARIABLE_VALUE_PKG Procedure 来检索语句运行时分配给输出变量的值。
若要仅提取 `LONG` 数据库列的一部分（其大小可达两 GB），请使用 DEFINE_COLUMN_LONG Procedure。您可以指定在列值中的偏移量（以字节为单位），以及要提取的字节数。

#### CLOSE_CURSOR

当会话不再需要游标时，通过调用 CLOSE_CURSOR Procedure 关闭游标。如果您正在使用 Oracle Open Gateway，则可能还需要在其他时间关闭游标。有关更多信息，请查阅您的 Oracle Open Gateway 文档。
**相关主题**
                           - CLOSE_CURSOR Procedure
### DBMS_SQL 异常
当给定 `OUT` 参数（用于放置所请求值的位置）的类型与值的类型不同时，`COLUMN_VALUE Procedure` 或 `VARIABLE_VALUE Procedures` 会引发此异常。
```
inconsistent_type EXCEPTION;
  pragma exception_init(inconsistent_type, -6562);
```
**相关主题**
                        - COLUMN_VALUE Procedure
                        - VARIABLE_VALUE Procedures
### DBMS_SQL 示例
这些示例过程使用 `DBMS_SQL` 包。
示例：使用 DBMS_SQL 演示
此示例不需要动态 SQL，因为语句的文本在编译时已知，但它说明了该包的基本概念。
`DEMO` 过程从 `EMP` 表中删除所有薪水大于您运行 `DEMO` 时指定薪水的员工。
```
CREATE OR REPLACE PROCEDURE demo(salary IN NUMBER) AS
    cursor_name INTEGER;
    rows_processed INTEGER;
BEGIN
    cursor_name := dbms_sql.open_cursor;
    DBMS_SQL.PARSE(cursor_name, 'DELETE FROM emp WHERE sal > :x',
                   DBMS_SQL.NATIVE);
    DBMS_SQL.BIND_VARIABLE(cursor_name, ':x', salary);
    rows_processed := DBMS_SQL.EXECUTE(cursor_name);
    DBMS_SQL.CLOSE_CURSOR(cursor_name);
EXCEPTION
WHEN OTHERS THEN
    DBMS_SQL.CLOSE_CURSOR(cursor_name);
END;
```
示例 2
以下示例过程接收一个 SQL 语句，然后对其进行解析并运行：
```
CREATE OR REPLACE PROCEDURE exec(STRING IN varchar2) AS
    cursor_name INTEGER;
    ret INTEGER;
BEGIN
   cursor_name := DBMS_SQL.OPEN_CURSOR;
```
DDL 语句通过解析调用来运行，该调用会执行隐式提交。
```
   DBMS_SQL.PARSE(cursor_name, string, DBMS_SQL.NATIVE);
   ret := DBMS_SQL.EXECUTE(cursor_name);
   DBMS_SQL.CLOSE_CURSOR(cursor_name);
END;
```
创建这样的过程使您可以执行以下操作：
- SQL 语句可以在运行时由调用程序动态生成。
- SQL 语句可以是不带绑定的 DDL 语句或 DML 语句。
例如，创建此过程后，您可以进行以下调用：
```
exec('create table acct(c1 integer)');
```
您甚至可以远程调用此过程，如以下示例所示。这使您可以执行远程 DDL。
```
exec@domain.com('CREATE TABLE acct(c1 INTEGER)');
```
示例 3
以下示例过程接收源表和目标表的名称，并将行从源表复制到目标表。此示例过程假定源表和目标表都包含以下列：
```
id        of type NUMBER
name      of type VARCHAR2(30)
birthdate of type DATE
```
此过程不需要使用动态 SQL；但是，它说明了此包的概念。
```
CREATE OR REPLACE PROCEDURE copy (
     source      IN VARCHAR2,
     destination IN VARCHAR2) IS
     id_var             NUMBER;
     name_var           VARCHAR2(30);
     birthdate_var      DATE;
     source_cursor      INTEGER;
     destination_cursor INTEGER;
     ignore             INTEGER;
  BEGIN
  -- Prepare a cursor to select from the source table:
     source_cursor := dbms_sql.open_cursor;
     DBMS_SQL.PARSE(source_cursor,
         'SELECT id, name, birthdate FROM ' || source,
          DBMS_SQL.NATIVE);
     DBMS_SQL.DEFINE_COLUMN(source_cursor, 1, id_var);
     DBMS_SQL.DEFINE_COLUMN(source_cursor, 2, name_var, 30);
     DBMS_SQL.DEFINE_COLUMN(source_cursor, 3, birthdate_var);
     ignore := DBMS_SQL.EXECUTE(source_cursor);
  -- Prepare a cursor to insert into the destination table:
     destination_cursor := DBMS_SQL.OPEN_CURSOR;
     DBMS_SQL.PARSE(destination_cursor,
                  'INSERT INTO ' || destination ||
                  ' VALUES (:id_bind, :name_bind, :birthdate_bind)',
                   DBMS_SQL.NATIVE);
  -- Fetch a row from the source table and insert it into the destination table:
     LOOP
       IF DBMS_SQL.FETCH_ROWS(source_cursor)>0 THEN
         -- get column values of the row
         DBMS_SQL.COLUMN_VALUE(source_cursor, 1, id_var);
         DBMS_SQL.COLUMN_VALUE(source_cursor, 2, name_var);
         DBMS_SQL.COLUMN_VALUE(source_cursor, 3, birthdate_var);
  -- Bind the row into the cursor that inserts into the destination table. You
  -- could alter this example to require the use of dynamic SQL by inserting an
  -- if condition before the bind.
        DBMS_SQL.BIND_VARIABLE(destination_cursor, ':id_bind', id_var);
        DBMS_SQL.BIND_VARIABLE(destination_cursor, ':name_bind', name_var);
        DBMS_SQL.BIND_VARIABLE(destination_cursor, ':birthdate_bind',
                                                                   birthdate_var);
        ignore := DBMS_SQL.EXECUTE(destination_cursor);
      ELSE
  -- No more rows to copy:
        EXIT;
      END IF;
    END LOOP;
  -- Commit and close all cursors:
     COMMIT;
     DBMS_SQL.CLOSE_CURSOR(source_cursor);
     DBMS_SQL.CLOSE_CURSOR(destination_cursor);
   EXCEPTION
     WHEN OTHERS THEN
       IF DBMS_SQL.IS_OPEN(source_cursor) THEN
         DBMS_SQL.CLOSE_CURSOR(source_cursor);
       END IF;
       IF DBMS_SQL.IS_OPEN(destination_cursor) THEN
         DBMS_SQL.CLOSE_CURSOR(destination_cursor);
       END IF;
       RAISE;
  END;
/
```
示例 4：RETURNING 子句
使用此子句，`INSERT`、`UPDATE` 和 `DELETE` 语句可以在绑定变量中返回表达式的值。
如果插入、更新或删除了单行，则使用 `DBMS_SQL`.`BIND_VARIABLE` 绑定这些输出绑定。要获取这些绑定变量中的值，请调用 `DBMS_SQL`.`VARIABLE_VALUE`
注意：
此过程类似于 `DBMS_SQL`.`VARIABLE_VALUE`，它必须在运行带有输出绑定的 PL/SQL 块之后在 `DBMS_SQL` 内部调用。
i) 单行插入
```
      CREATE OR REPLACE PROCEDURE single_Row_insert
           (c1 NUMBER, c2 NUMBER, r OUT NUMBER) is
      c NUMBER;
      n NUMBER;
      begin
        c := DBMS_SQL.OPEN_CURSOR;
        DBMS_SQL.PARSE(c, 'INSERT INTO tab VALUES (:bnd1, :bnd2) ' ||
                          'RETURNING c1*c2 INTO :bnd3', DBMS_SQL.NATIVE);
     DBMS_SQL.BIND_VARIABLE(c, 'bnd1', c1);
        DBMS_SQL.BIND_VARIABLE(c, 'bnd2', c2);
        DBMS_SQL.BIND_VARIABLE(c, 'bnd3', r);
        n := DBMS_SQL.EXECUTE(c);
        DBMS_SQL.VARIABLE_VALUE(c, 'bnd3', r); -- get value of outbind variable
        DBMS_SQL.CLOSE_CURSOR(c);
      END;
      /
```
ii) 单行更新
```
      CREATE OR REPLACE PROCEDURE single_Row_update
           (c1 NUMBER, c2 NUMBER, r out NUMBER) IS
      c NUMBER;
      n NUMBER;
      BEGIN
        c := DBMS_SQL.OPEN_CURSOR;
        DBMS_SQL.PARSE(c, 'UPDATE tab SET c1 = :bnd1, c2 = :bnd2 ' ||
                          'WHERE rownum < 2 ' ||
                          'RETURNING c1*c2 INTO :bnd3', DBMS_SQL.NATIVE);
        DBMS_SQL.BIND_VARIABLE(c, 'bnd1', c1);
        DBMS_SQL.BIND_VARIABLE(c, 'bnd2', c2);
        DBMS_SQL.BIND_VARIABLE(c, 'bnd3', r);
        n := DBMS_SQL.EXECUTE(c);
        DBMS_SQL.VARIABLE_VALUE(c, 'bnd3', r);-- get value of outbind variable
        DBMS_SQL.CLOSE_CURSOR(c);
      END;
      /
```
iii) 单行删除
```
      CREATE OR REPLACE PROCEDURE single_Row_Delete
           (c1 NUMBER, r OUT NUMBER) is
      c NUMBER;
      n number;
      BEGIN
        c := DBMS_SQL.OPEN_CURSOR;
        DBMS_SQL.PARSE(c, 'DELETE FROM tab WHERE ROWNUM = :bnd1 ' ||
                      'RETURNING c1*c2 INTO :bnd2', DBMS_SQL.NATIVE);
        DBMS_SQL.BIND_VARIABLE(c, 'bnd1', c1);
        DBMS_SQL.BIND_VARIABLE(c, 'bnd2', r);
        n := DBMS_SQL.EXECUTE(c);
        DBMS_SQL.VARIABLE_VALUE(c, 'bnd2', r);-- get value of outbind variable
        DBMS_SQL.CLOSE_CURSOR(c);
      END;
      /
```
iv) 多行插入
```
      CREATE OR REPLACE PROCEDURE multi_Row_insert
           (c1 DBMS_SQL.NUMBER_TABLE, c2 DBMS_SQL.NUMBER_TABLE,
            r OUT DBMS_SQL.NUMBER_TABLE) is
      c NUMBER;
      n NUMBER;
      BEGIN
        c := DBMS_SQL.OPEN_CURSOR;
        DBMS_SQL.PARSE(c, 'insert into tab VALUES (:bnd1, :bnd2) ' ||
                          'RETURNING c1*c2 INTO :bnd3', DBMS_SQL.NATIVE);
        DBMS_SQL.BIND_ARRAY(c, 'bnd1', c1);
        DBMS_SQL.BIND_ARRAY(c, 'bnd2', c2);
        DBMS_SQL.BIND_ARRAY(c, 'bnd3', r);
        n := DBMS_SQL.EXECUTE(c);
        DBMS_SQL.VARIABLE_VALUE(c, 'bnd3', r);-- get value of outbind variable
        DBMS_SQL.CLOSE_CURSOR(c);
      END;
      /
```
v) 多行更新。
```
      CREATE OR REPLACE PROCEDURE multi_Row_update
           (c1 NUMBER, c2 NUMBER, r OUT DBMS_SQL.NUMBER_TABLE) IS
      c NUMBER;
      n NUMBER;
     BEGIN
        c := DBMS_SQL.OPEN_CURSOR;
        DBMS_SQL.PARSE(c, 'UPDATE tab SET c1 = :bnd1 WHERE c2 = :bnd2 ' ||
                          'RETURNING c1*c2 INTO :bnd3', DBMS_SQL.NATIVE);
        DBMS_SQL.BIND_VARIABLE(c, 'bnd1', c1);
        DBMS_SQL.BIND_VARIABLE(c, 'bnd2', c2);
        DBMS_SQL.BIND_ARRAY(c, 'bnd3', r);
        n := DBMS_SQL.EXECUTE(c);
        DBMS_SQL.VARIABLE_VALUE(c, 'bnd3', r);-- get value of outbind variable
        DBMS_SQL.CLOSE_CURSOR(c);
      END;
      /
```
注意：
bnd1 和 bnd2 也可以是数组。所有更新行的表达式值都将在 bnd3 中。无法确定 bnd1 和 bnd2 的每个值更新了哪些行。
vi) 多行删除
```
      CREATE OR REPLACE PROCEDURE multi_row_delete
           (c1 DBMS_SQL.NUMBER_TABLE,
            r OUT DBMS_SQL.NUMBER_TABLE) is
      c NUMBER;
      n NUMBER;
      BEGIN
        c := DBMS_SQL.OPEN_CURSOR;
        DBMS_SQL.PARSE(c, 'DELETE FROM tab WHERE c1 = :bnd1' ||
                          'RETURNING c1*c2 INTO :bnd2', DBMS_SQL.NATIVE);
        DBMS_SQL.BIND_ARRAY(c, 'bnd1', c1);
        DBMS_SQL.BIND_ARRAY(c, 'bnd2', r);
        n := DBMS_SQL.EXECUTE(c);
        DBMS_SQL.VARIABLE_VALUE(c, 'bnd2', r);-- get value of outbind variable
        DBMS_SQL.CLOSE_CURSOR(c);
      END;
      /
```
vii) 批量 PL/SQL 中的输出绑定
```
      CREATE OR REPLACE PROCEDURE foo (n NUMBER, square OUT NUMBER) IS
      BEGIN square := n * n; END;/
      CREATE OR REPLACE PROCEDURE bulk_plsql
         (n DBMS_SQL.NUMBER_TABLE, square OUT DBMS_SQL.NUMBER_TABLE) IS
      c NUMBER;
      r NUMBER;
      BEGIN
        c := DBMS_SQL.OPEN_CURSOR;
        DBMS_SQL.PARSE(c, 'BEGIN foo(:bnd1, :bnd2); END;', DBMS_SQL.NATIVE);
        DBMS_SQL.BIND_ARRAY(c, 'bnd1', n);
        DBMS_SQL.BIND_ARRAY(c, 'bnd2', square);
        r := DBMS_SQL.EXECUTE(c);
        DBMS_SQL.VARIABLE_VALUE(c, 'bnd2', square);
     END;
     /
```
注意：
`number_Table` 的 `DBMS_SQL`.`BIND_ARRAY` 在内部绑定一个数字。语句运行的次数取决于输入绑定数组中的元素数量。
示例 5：DBMS_SQL 中用户定义类型的绑定和定义
```
CREATE TYPE dnames_var IS VARRAY(7) OF VARCHAR2(30)
/
CREATE TABLE depts (region VARCHAR2(25), dept_names dnames_var)
/
INSERT INTO depts VALUES('Europe', dnames_var('Shipping','Sales','Finance'))
/
INSERT INTO depts VALUES('Americas', dnames_var('Sales','Finance','Shipping'))
/
INSERT INTO depts VALUES('Asia', dnames_var('Finance','Payroll','Shipping','Sales'))
/
CREATE OR REPLACE PROCEDURE update_depts(new_dnames dnames_var, region VARCHAR2) IS
   some_dnames dnames_var;
   c      NUMBER;
   r      NUMBER;
   sql_stmt VARCHAR2(32767) :=
    'UPDATE depts SET dept_names = :b1 WHERE region = :b2 RETURNING dept_names INTO :b3';
BEGIN
   c := DBMS_SQL.OPEN_CURSOR;
   DBMS_SQL.PARSE(c, sql_stmt, dbms_sql.native);
   DBMS_SQL.BIND_VARIABLE(c, 'b1', new_dnames);
   DBMS_SQL.BIND_VARIABLE(c, 'b2', region);
   DBMS_SQL.BIND_VARIABLE(c, 'b3', some_dnames);
   r := DBMS_SQL.EXECUTE(c);
   -- Get value of outbind variable
   DBMS_SQL.VARIABLE_VALUE(c, 'b3', some_dnames);
   DBMS_SQL.CLOSE_CURSOR(c);
   -- select dept_names
   sql_stmt := 'SELECT dept_names FROM depts WHERE region = :b1';
   c := DBMS_SQL.OPEN_CURSOR;
   DBMS_SQL.PARSE(c, sql_stmt, dbms_sql.native);
   DBMS_SQL.DEFINE_COLUMN(c, 1, some_dnames);
   DBMS_SQL.BIND_VARIABLE(c, 'b1', region);
   r := DBMS_SQL.EXECUTE_AND_FETCH(c);
   DBMS_SQL.COLUMN_VALUE(c, 1, some_dnames);
   DBMS_SQL.CLOSE_CURSOR(c);
    -- loop through some_dnames collections
    FOR i IN some_dnames.FIRST .. some_dnames.LAST  LOOP
        DBMS_OUTPUT.PUT_LINE('Dept. Name = ' || some_dnames(i) || ' Updated!');
    END LOOP;
END;
/
DECLARE
  new_dnames dnames_var;
BEGIN
  new_dnames := dnames_var('Benefits', 'Advertising', 'Contracting',
                           'Executive', 'Marketing');
  update_depts(new_dnames, 'Asia');
END;
/
```
### DBMS_SQL 数据结构
`DBMS_SQL` 包定义了 `RECORD` 类型和 `TABLE` 类型的数据结构。
RECORD 类型
- DBMS_SQL DESC_REC 记录类型（已弃用）
- DBMS_SQL DESC_REC2 记录类型
- DBMS_SQL DESC_REC3 记录类型
- DBMS_SQL DESC_REC4 记录类型
用于 DESCRIBE_COLUMNS Procedures 的 TABLE 类型
- DBMS_SQL DESC_TAB 表类型
- DBMS_SQL DESC_TAB2 表类型
- DBMS_SQL DESC_TAB3 表类型
- DBMS_SQL DESC_TAB4 表类型
用于标量和 LOB 集合的 TABLE 类型
 DBMS_SQL 批量操作仅支持这些预定义的 DBMS_SQL TABLE 类型。
- BFILE_TABLE 表类型
- BINARY_DOUBLE_TABLE 表类型
- BINARY_FLOAT_TABLE 表类型
- BLOB_TABLE 表类型
- CLOB_TABLE 表类型
- DATE_TABLE 表类型
- INTERVAL_DAY_TO_SECOND_TABLE 表类型
- INTERVAL_YEAR_TO_MONTH_TABLE 表类型
- NUMBER_TABLE 表类型
- TIME_TABLE 表类型
- TIME_WITH_TIME_ZONE_TABLE 表类型
- TIMESTAMP_TABLE 表类型
- TIMESTAMP_WITH_LTZ_TABLE 表类型
- TIMESTAMP_WITH_TIME_ZONE_TABLE 表类型
- UROWID_TABLE 表类型
- VARCHAR2_TABLE 表类型
- VARCHAR2A 表类型
- VARCHAR2S 表类型

#### DBMS_SQL DESC_REC 记录类型

此记录类型保存动态查询中单个列的描述信息。
注意：
此类型已被弃用，推荐使用 DESC_REC2 记录类型。
它是 `DESC_TAB` 表类型和 DESCRIBE_COLUMNS 过程的元素类型。
语法
```
TYPE desc_rec IS RECORD (
      col_type            BINARY_INTEGER := 0,
      col_max_len         BINARY_INTEGER := 0,
      col_name            VARCHAR2(32)   := '',
      col_name_len        BINARY_INTEGER := 0,
      col_schema_name     VARCHAR2(32)   := '',
      col_schema_name_len BINARY_INTEGER := 0,
      col_precision       BINARY_INTEGER := 0,
      col_scale           BINARY_INTEGER := 0,
      col_charsetid       BINARY_INTEGER := 0,
      col_charsetform     BINARY_INTEGER := 0,
      col_null_ok         BOOLEAN        := TRUE);
TYPE desc_tab IS TABLE OF desc_rec INDEX BY BINARY_INTEGER;
```
字段
表 170-2 DESC_REC 字段
| 字段 | 描述 |
|---|---|
| col_type | 列的类型 |
| col_max_len | 列的最大长度 |
| col_name | 列名 |
| col_name_len | 列名长度 |
| col_schema_name | 列的方案名 |
| col_schema_name_len | 列的方案名长度 |
| col_precision | 列的精度 |
| col_scale | 列的标度 |
| col_charsetid | 列的字符集 ID |
| col_charsetform | 列的字符集形式 |
| col_null_ok | 列的 NULL 标志；如果可以为 NULL，则为 TRUE |

#### DBMS_SQL DESC_REC2 记录类型

`DESC_REC2` 是 `DESC_TAB2` 表类型和 `DESCRIBE_COLUMNS2` 过程的元素类型。
此记录类型与 `DESC_REC` 相同，只是 `col_name` 字段扩展到了 `VARCHAR2` 的最大可能大小。因此，它比 `DESC_REC` 更受推荐，因为列名值可能超过 32 个字符。结果，`DESC_REC` 已被弃用。
语法
```
TYPE desc_rec2 IS RECORD (
   col_type            binary_integer := 0,
   col_max_len         binary_integer := 0,
   col_name            varchar2(32767) := '',
   col_name_len        binary_integer := 0,
   col_schema_name     varchar2(32)   := '',
   col_schema_name_len binary_integer := 0,
   col_precision       binary_integer := 0,
   col_scale           binary_integer := 0,
   col_charsetid       binary_integer := 0,
   col_charsetform     binary_integer := 0,
   col_null_ok         boolean        := TRUE);
```
字段
Table 170-3 DESC_REC2 字段
| Field | Description |
|---|---|
| col_type | 列的类型 |
| col_max_len | 列的最大长度 |
| col_name | 列的名称 |
| col_name_len | 列名的长度 |
| col_schema_name | 列的 schema 名称 |
| col_schema_name_len | 列 schema 名称的长度 |
| col_precision | 列的精度 |
| col_scale | 列的标度 |
| col_charsetid | 列的字符集 ID |
| col_charsetform | 列的字符集形式 |
| col_null_ok | NULL 列标志；如果可以为 NULL，则为 TRUE |
**相关主题**
                           - DESCRIBE_COLUMNS2 过程

#### DBMS_SQL DESC_REC3 记录类型

`DESC_REC3` 是 `DESC_TAB3` 表类型和 `DESCRIBE_COLUMNS3 Procedure` 的元素类型。
`DESC_REC3` 与 `DESC_REC2` 相同，区别在于增加了两个字段，用于保存动态查询中列的类型名 (`type_name`) 和类型名长度 (`type_name_len`)。当列为用户定义类型（集合类型或对象类型）时，这两个字段保存类型名和类型名长度。只有当 `col_type` 字段的值为 109（即用户定义类型的 Oracle 类型编号）时，才会填充 `col_type_name` 和 `col_type_name_len` 字段。
语法
```
TYPE desc_rec3 IS RECORD (
   col_type               binary_integer := 0,
   col_max_len            binary_integer := 0,
   col_name               varchar2(32767) := '',
   col_name_len           binary_integer := 0,
   col_schema_name        varchar2(32) := '',
   col_schema_name_len    binary_integer := 0,
   col_precision          binary_integer := 0,
   col_scale              binary_integer := 0,
   col_charsetid          binary_integer := 0,
   col_charsetform        binary_integer := 0,
   col_null_ok            boolean := TRUE,
   col_type_name          varchar2(32767)   := '',
   col_type_name_len      binary_integer := 0);
```
字段
表 170-4 DESC_REC3 字段
| 字段 | 描述 |
|---|---|
| col_type | 列的类型 |
| col_max_len | 列的最大长度 |
| col_name | 列名 |
| col_name_len | 列名的长度 |
| col_schema_name | 列的模式名 |
| col_schema_name_len | 列模式名的长度 |
| col_precision | 列的精度 |
| col_scale | 列的标度 |
| col_charsetid | 列的字符集 ID |
| col_charsetform | 列的字符集形式 |
| col_null_ok | 列的 NULL 标志；如果可以为 NULL，则为 TRUE |
| col_type_name | 用户定义类型列的类型名，此字段在 col_type 为 109 时有效 |
| col_type_name_len | 用户定义类型列类型名的长度，此字段在 col_type 为 109 时有效 |
**相关主题**
                           - DESCRIBE_COLUMNS3 Procedure

#### DBMS_SQL DESC_REC4 记录类型

`DESC_REC4` 是 `DESC_TAB4` 表类型和 DESCRIBE_COLUMNS3 过程的元素类型。
`DESC_REC4` 与 `DESC_REC3` 相同，区别在于它在保存动态查询中列的方案名 (`col_schema_name`) 和类型名 (`col_type_name`) 的字段中支持更长的标识符。
语法
```
TYPE desc_rec4 IS RECORD (
   col_type               binary_integer := 0,
   col_max_len            binary_integer := 0,
   col_name               varchar2(32767) := '',
   col_name_len           binary_integer := 0,
   col_schema_name        DBMS_ID := '',
   col_schema_name_len    binary_integer := 0,
   col_precision          binary_integer := 0,
   col_scale              binary_integer := 0,
   col_charsetid          binary_integer := 0,
   col_charsetform        binary_integer := 0,
   col_null_ok            boolean := TRUE,
   col_type_name          DBMS_ID   := '',
   col_type_name_len      binary_integer := 0);
```
另请参见：
 Oracle Database PL/SQL Language Reference for more information about the predefined subtype DBMS_ID.
字段
Table 170-5 DESC_REC4 字段
| Field | Description |
|---|---|
| col_type | 列类型 |
| col_max_len | 列的最大长度 |
| col_name | 列名 |
| col_name_len | 列名长度 |
| col_schema_name | 列的方案名 |
| col_schema_name_len | 列方案名长度 |
| col_precision | 列的精度 |
| col_scale | 列的标度 |
| col_charsetid | 列字符集 ID |
| col_charsetform | 列字符集形式 |
| col_null_ok | NULL 列标志；如果可以为 NULL，则为 TRUE |
| col_type_name | 用户定义类型的列类型名，此字段在 col_type 为 109 时有效 |
| col_type_name_len | 用户定义类型的列类型名长度，此字段在 col_type 为 109 时有效 |
**相关主题**
                           - DESCRIBE_COLUMNS3 Procedure

#### DBMS_SQL BFILE_TABLE 表类型

这是一个 `BFILE` 表。
语法
```
TYPE bfile_table IS TABLE OF BFILE INDEX BY BINARY_INTEGER;
```

#### DBMS_SQL BINARY_DOUBLE_TABLE 表类型

这是一个 `BINARY_DOUBLE` 类型的表。
语法
```
TYPE binary_double_table IS TABLE OF BINARY_DOUBLE INDEX BY BINARY_INTEGER;
```

#### DBMS_SQL BINARY_FLOAT_TABLE 表类型

这是一个 `BINARY_FLOAT` 类型的表。
语法
```
TYPE binary_float_table IS TABLE OF BINARY_FLOAT INDEX BY BINARY_INTEGER;
```

#### DBMS_SQL BLOB_TABLE 表类型

这是一个 `BLOB` 表。
语法
```
TYPE blob_table IS TABLE OF BLOB INDEX BY BINARY_INTEGER;
```

#### DBMS_SQL CLOB_TABLE 表类型

这是一个 `CLOB` 类型的表。
语法
```
TYPE clob_table IS TABLE OF CLOB INDEX BY BINARY_INTEGER;
```

#### DBMS_SQL DATE_TABLE 表类型

这是一个由 `DATE` 组成的表。
语法
```
type date_table IS TABLE OF DATE INDEX BY BINARY_INTEGER;
```

#### DBMS_SQL DESC_TAB 表类型

这是 `DESC_REC 记录类型` 的表。
语法
```
TYPE desc_tab IS TABLE OF desc_rec INDEX BY BINARY_INTEGER;
```
**相关主题**
                           - DBMS_SQL DESC_REC 记录类型

#### DBMS_SQL DESC_TAB2 表类型

这是 `DESC_REC2 记录类型` 的表。
语法
```
TYPE desc_tab2 IS TABLE OF desc_rec2 INDEX BY BINARY_INTEGER;
```
**相关主题**
                           - DBMS_SQL DESC_REC2 记录类型

#### DBMS_SQL DESC_TAB3 表类型

这是 `DESC_REC3` 记录类型的表。
语法
```
TYPE desc_tab3 IS TABLE OF desc_rec3 INDEX BY BINARY_INTEGER;
```
**相关主题**
                           - DBMS_SQL DESC_REC3 记录类型

#### DBMS_SQL DESC_TAB4 表类型

这是 DBMS_SQL DESC_REC4 记录类型的表。
语法
```
TYPE DESC_TAB4 IS TABLE OF DESC_REC4 INDEX BY BINARY_INTEGER;
```
**相关主题**
                           - DBMS_SQL DESC_REC4 记录类型

#### DBMS_SQL INTERVAL_DAY_TO_SECOND_TABLE 表类型

这是一个 `DSINTERVAL_UNCONSTRAINED` 类型的表。
语法
```
 TYPE interval_day_to_second_Table IS TABLE OF
    DSINTERVAL_UNCONSTRAINED INDEX BY binary_integer;
```

#### DBMS_SQL INTERVAL_YEAR_TO_MONTH_TABLE 表类型

这是由 `YMINTERVAL_UNCONSTRAINED` 组成的表。
语法
```
TYPE interval_year_to_month_table IS TABLE OF YMINTERVAL_UNCONSTRAINED
   INDEX BY BINARY_INTEGER;
```

#### DBMS_SQL NUMBER_TABLE 表类型

这是一个由 `NUMBER` 组成的表。
语法
```
TYPE number_table IS TABLE OF NUMBER INDEX BY BINARY_INTEGER;
```

#### DBMS_SQL TIME_TABLE 表类型

这是一个 `TIME_UNCONSTRAINED` 的表。
语法
```
TYPE time_table IS TABLE OF TIME_UNCONSTRAINED INDEX BY BINARY_INTEGER;
```

#### DBMS_SQL TIME_WITH_TIME_ZONE_TABLE 表类型

这是一个由 `TIME_TZ_UNCONSTRAINED` 组成的表。
语法
```
TYPE time_with_time_zone_table IS TABLE OF TIME_TZ_UNCONSTRAINED
   INDEX BY BINARY_INTEGER;;
```

#### DBMS_SQL TIMESTAMP_TABLE 表类型

这是一个由 `TIMESTAMP_UNCONSTRAINED` 组成的表。
语法
```
TYPE timestamp_table IS TABLE OF TIMESTAMP_UNCONSTRAINED INDEX BY BINARY_INTEGER;
```

#### DBMS_SQL TIMESTAMP_WITH_LTZ_TABLE 表类型

这是一个 TIMESTAMP_LTZ_UNCONSTRAINED 的表
语法
```
TYPE timestamp_with_ltz_table IS TABLE OF
    TIMESTAMP_LTZ_UNCONSTRAINED INDEX BY binary_integer;
```

#### DBMS_SQL TIMESTAMP_WITH_TIME_ZONE_TABLE 表类型

这是一个 `TIMESTAMP_TZ_UNCONSTRAINED` 类型的表。
语法
```
TYPE timestamp_with_time_zone_Table IS TABLE OF
    TIMESTAMP_TZ_UNCONSTRAINED INDEX BY binary_integer;
```

#### DBMS_SQL UROWID_TABLE 表类型

这是一个 `UROWID` 的表。
语法
```
TYPE urowid_table IS TABLE OF UROWID INDEX BY BINARY_INTEGER;
```

#### DBMS_SQL VARCHAR2_TABLE 表类型

这是 `VARCHAR2(2000)` 的表。
语法
```
TYPE varchar2_table IS TABLE OF VARCHAR2(2000) INDEX BY BINARY_INTEGER;
```

#### DBMS_SQL VARCHAR2A 表类型

这是 `VARCHAR2(32767)` 的表。
语法
```
TYPE varchar2a IS TABLE OF VARCHAR2(32767) INDEX BY BINARY_INTEGER;
```

#### DBMS_SQL VARCHAR2S 表类型

这是 `VARCHAR2(256)` 的表。
注意：
此类型已被 VARCHAR2A 表类型取代。尽管目前为了旧代码的向后兼容而予以保留，但它正处于弃用过程中，并将在未来的版本中停止支持。
语法
```
TYPE varchar2s IS TABLE OF VARCHAR2(256) INDEX BY BINARY_INTEGER;
```
### DBMS_SQL 子程序汇总
此表列出了 `DBMS_SQL` 子程序并对其进行了简要描述。
Table 170-6 DBMS_SQL 程序包子程序
| 子程序 | 描述 |
|---|---|
| BIND_ARRAY Procedures | 将给定值绑定到给定集合。 |
| BIND_VARIABLE Procedures | 将给定值绑定到给定变量。 |
| BIND_VARIABLE_PKG Procedure | 将给定值绑定到给定包变量。 |
| CLOSE_CURSOR Procedure | 关闭给定游标并释放内存。 |
| COLUMN_VALUE Procedure | 返回游标中给定位置对应的游标元素值。 |
| COLUMN_VALUE_LONG Procedure | 返回已使用 DEFINE_COLUMN_LONG 定义的 LONG 列的选定部分。 |
| DEFINE_ARRAY Procedure | 定义要从给定游标中选择的集合，仅用于 SELECT 语句。 |
| DEFINE_COLUMN Procedures | 定义要从给定游标中选择的列，仅用于 SELECT 语句。 |
| DEFINE_COLUMN_CHAR Procedure | 定义要从给定游标中选择的 CHAR 类型列，仅用于 SELECT 语句。 |
| DEFINE_COLUMN_LONG Procedure | 定义要从给定游标中选择的 LONG 列，仅用于 SELECT 语句。 |
| DEFINE_COLUMN_RAW Procedure | 定义要从给定游标中选择的 RAW 类型列，仅用于 SELECT 语句。 |
| DEFINE_COLUMN_ROWID Procedure | 定义要从给定游标中选择的 ROWID 类型列，仅用于 SELECT 语句。 |
| DESCRIBE_COLUMNS Procedure | 描述通过 DBMS_SQL 打开并解析的游标的列。 |
| DESCRIBE_COLUMNS2 Procedure | 描述指定列，是 DESCRIBE_COLUMNS Procedure 的替代方案。 |
| DESCRIBE_COLUMNS3 Procedure | 描述指定列，是 DESCRIBE_COLUMNS Procedure 的替代方案。 |
| EXECUTE Function | 执行给定游标。 |
| EXECUTE_AND_FETCH Function | 执行给定游标并提取行。 |
| FETCH_ROWS Function | 从给定游标中提取一行。 |
| GET_NEXT_RESULT Procedures | 获取返回给递归语句调用者的下一个结果语句；或者，如果此调用者将自身设为递归语句的客户端，则获取作为客户端返回给此调用者的下一个结果。 |
| IS_OPEN Function | 如果给定游标已打开，则返回 TRUE。 |
| LAST_ERROR_POSITION Function | 返回 SQL 语句文本中发生错误的字节偏移量。 |
| LAST_ROW_COUNT Function | 返回已提取行数的累积计数。 |
| LAST_ROW_ID Function | 返回最后处理的行的 ROWID。 |
| LAST_SQL_FUNCTION_CODE Function | 返回语句的 SQL 函数代码。 |
| OPEN_CURSOR Functions | 返回新游标的游标 ID 号。 |
| PARSE Procedures | 解析给定语句。 |
| RETURN_RESULT Procedures | 将已执行语句的结果返回给客户端应用程序。 |
| TO_CURSOR_NUMBER Function | 接收一个已 OPEN 的强类型或弱类型 ref cursor，并将其转换为 DBMS_SQL 游标号。 |
| TO_REFCURSOR Function | 接收一个已 OPEN、PARSE 且 EXECUTE 的游标，将其转换/迁移为可由 PL/SQL 原生动态 SQL 消化的 PL/SQL 可管理 REF CURSOR（弱类型游标），以便切换使用原生动态 SQL。 |
| VARIABLE_VALUE Procedures | 返回给定游标的命名变量值。 |
| VARIABLE_VALUE_PKG Procedure | 返回给定游标的命名变量值。它用于返回已声明包的 PL/SQL 块或带回 returning 子句的 DML 语句内部绑定变量的值。该变量的类型必须在包规范中声明。 |

#### BIND_ARRAY 过程

此过程根据语句中变量的名称，将给定值或一组值绑定到游标中的给定变量。
语法
```
DBMS_SQL.BIND_ARRAY (
   c                   IN INTEGER,
   name                IN VARCHAR2,
   <table_variable>    IN <datatype>
 [,index1              IN INTEGER,
   index2              IN INTEGER)] );
```
其中 <`table_variable`> 及其对应的 <`datatype`> 可以是以下任意匹配对之一：
```
<clob_tab>     Clob_Table
<bflt_tab>     Binary_Float_Table
<bdbl_tab>     Binary_Double_Table
<blob_tab>     Blob_Table
<bfile_tab>    Bfile_Table
<date_tab>     Date_Table
<num_tab>      Number_Table
<urowid_tab>   Urowid_Table
<vchr2_tab>    Varchar2_Table
<tm_tab>       Time_Table
<ttz_tab>      Time_With_Time_Zone_Table
<tms_tab>      Timestamp_Table
<tstz_tab>     Timestamp_With_ltz_Table
<tstz_tab>     Timestamp_With_Time_Zone_Table
<ids_tab>      Interval_Day_To_Second_Table
<iym_tab>      Interval_Year_To_Month_Table
```
请注意，`BIND_ARRAY` 过程经过重载，可接受不同的 datatype。
参数
Table 170-7 BIND_ARRAY 过程参数
| Parameter | Description |
|---|---|
| c | 要绑定值的游标的 ID 编号。 |
| name | 语句中集合的名称。 |
| table_variable | 已声明为 <datatype> 的局部变量。 |
| index1 | 标记范围下界的表元素的索引。 |
| index2 | 标记范围上界的表元素的索引。 |
使用说明
要绑定一个范围，表必须包含指定范围的元素 — tab(index1) 和 tab(index2) — 但该范围不一定是密集的。Index1 必须小于或等于 index2。tab(index1) 和 tab(index2) 之间的所有元素都将用于绑定。
如果未在绑定调用中指定索引，并且语句中两个不同的绑定指定了包含不同元素数量的表，则实际使用的元素数量是所有表中的最小数量。如果您指定了索引，情况也是如此 — 在所有表的两个索引之间选择最小范围。
查询中的绑定变量不必都是数组绑定。有些可以是常规绑定，并且在表达式求值（等等）中，相同的值用于集合的每个元素。
批量数组绑定
批量查询、插入、更新和删除通过将许多调用捆绑在一起来提高应用程序的性能。`DBMS_SQL` 包允许您使用 PL/SQL 表类型处理数据集合。
表项是无界同构集合。在持久存储中，它们类似于其他关系表，并且没有内在排序。但是，当表项被带入工作区时（通过查询或对持久数据的导航访问），或者当它作为 PL/SQL 变量或参数的值创建时，它的元素会被赋予下标，这些下标可与数组式语法一起使用以获取和设置元素的值。
这些元素的下标不必是密集的，可以是包括负数在内的任何数字。例如，表项可以仅包含位置 -10、2 和 7 处的元素。
当表项从临时工作区移至持久存储时，下标不会被存储；表项在持久存储中是无序的。
绑定时，表会从 PL/SQL 缓冲区复制到本地 `DBMS_SQL` 缓冲区（与所有标量类型相同），然后从本地 `DBMS_SQL` 缓冲区操作该表。因此，如果您在绑定调用后更改了表，则该更改不会影响执行的行为方式。
标量和 LOB 集合的类型
您可以将局部变量声明为以下任意表项类型之一，这些类型在 `DBMS_SQL` 中定义为公共类型。
```
TYPE binary_double_table
                    IS TABLE OF BINARY_DOUBLE  INDEX BY BINARY_INTEGER;
TYPE binary_float_table
                    IS TABLE OF BINARY_FLOAT   INDEX BY BINARY_INTEGER;
TYPE bfile_table    IS TABLE OF BFILE          INDEX BY BINARY_INTEGER;
TYPE blob_table     IS TABLE OF BLOB           INDEX BY BINARY_INTEGER;
TYPE clob_table     IS TABLE OF CLOB           INDEX BY BINARY_INTEGER;
TYPE date_table     IS TABLE OF DATE           INDEX BY BINARY_INTEGER;
TYPE interval_day_to_second_Table
                    IS TABLE OF dsinterval_unconstrained
                                               INDEX BY BINARY_INTEGER;
TYPE interval_year_to_MONTH_Table
                    IS TABLE OF yminterval_unconstrained
                                               INDEX BY BINARY_INTEGER;
TYPE number_table   IS TABLE OF NUMBER         INDEX BY BINARY_INTEGER;
TYPE time_table     IS TABLE OF time_unconstrained
                                               INDEX BY BINARY_INTEGER;
TYPE time_with_time_zone_table
                    IS TABLE OF time_tz_unconstrained
                                               INDEX BY BINARY_INTEGER;
TYPE timestamp_table
                    IS TABLE OF timestamp_unconstrained
                                               INDEX BY BINARY_INTEGER;
TYPE timestamp_with_ltz_Table
                    IS TABLE OF timestamp_ltz_unconstrained
                                               INDEX BY BINARY_INTEGER;
TYPE timestamp_with_time_zone_Table
                    IS TABLE OF timestamp_tz_unconstrained
                                               INDEX BY BINARY_INTEGER;
TYPE urowid_table   IS TABLE OF UROWID         INDEX BY BINARY_INTEGER;
TYPE varchar2_table IS TABLE OF VARCHAR2(2000) INDEX BY BINARY_INTEGER;
```
示例 170-1 使用批量 DML 的示例
本系列示例展示了如何在 SQL DML 语句 `INSERT`、`UPDATE` 和 `DELETE` 中使用批量数组绑定（表项）。
以下是批量 `INSERT` 语句的示例，演示了向 `emp` 表中添加 7 名新员工：
```
DECLARE
  stmt VARCHAR2(200);
  empno_array      DBMS_SQL.NUMBER_TABLE;
  empname_array    DBMS_SQL.VARCHAR2_TABLE;
  jobs_array       DBMS_SQL.VARCHAR2_TABLE;
  mgr_array        DBMS_SQL.NUMBER_TABLE;
  hiredate_array   DBMS_SQL.VARCHAR2_TABLE;
  sal_array        DBMS_SQL.NUMBER_TABLE;
  comm_array       DBMS_SQL.NUMBER_TABLE;
  deptno_array     DBMS_SQL.NUMBER_TABLE;
  c                NUMBER;
  dummy            NUMBER;
BEGIN
  empno_array(1):= 9001;
  empno_array(2):= 9002;
  empno_array(3):= 9003;
  empno_array(4):= 9004;
  empno_array(5):= 9005;
  empno_array(6):= 9006;
  empno_array(7):= 9007;
  empname_array(1) := 'Dopey';
  empname_array(2) := 'Grumpy';
  empname_array(3) := 'Doc';
  empname_array(4) := 'Happy';
  empname_array(5) := 'Bashful';
  empname_array(6) := 'Sneezy';
  empname_array(7) := 'Sleepy';
  jobs_array(1) := 'Miner';
  jobs_array(2) := 'Miner';
  jobs_array(3) := 'Miner';
  jobs_array(4) := 'Miner';
  jobs_array(5) := 'Miner';
  jobs_array(6) := 'Miner';
  jobs_array(7) := 'Miner';
  mgr_array(1) := 9003;
  mgr_array(2) := 9003;
  mgr_array(3) := 9003;
  mgr_array(4) := 9003;
  mgr_array(5) := 9003;
  mgr_array(6) := 9003;
  mgr_array(7) := 9003;
  hiredate_array(1) := '06-DEC-2006';
  hiredate_array(2) := '06-DEC-2006';
  hiredate_array(3) := '06-DEC-2006';
  hiredate_array(4) := '06-DEC-2006';
  hiredate_array(5) := '06-DEC-2006';
  hiredate_array(6) := '06-DEC-2006';
  hiredate_array(7) := '06-DEC-2006';
  sal_array(1):= 1000;
  sal_array(2):= 1000;
  sal_array(3):= 1000;
  sal_array(4):= 1000;
  sal_array(5):= 1000;
  sal_array(6):= 1000;
  sal_array(7):= 1000;
  comm_array(1):= 0;
  comm_array(2):= 0;
  comm_array(3):= 0;
  comm_array(4):= 0;
  comm_array(5):= 0;
  comm_array(6):= 0;
  comm_array(7):= 0;
  deptno_array(1):= 11;
  deptno_array(2):= 11;
  deptno_array(3):= 11;
  deptno_array(4):= 11;
  deptno_array(5):= 11;
  deptno_array(6):= 11;
  deptno_array(7):= 11;
  stmt := 'INSERT INTO emp VALUES(
     :num_array, :name_array, :jobs_array, :mgr_array, :hiredate_array,
     :sal_array, :comm_array, :deptno_array)';
  c := DBMS_SQL.OPEN_CURSOR;
  DBMS_SQL.PARSE(c, stmt, DBMS_SQL.NATIVE);
  DBMS_SQL.BIND_ARRAY(c, ':num_array', empno_array);
  DBMS_SQL.BIND_ARRAY(c, ':name_array', empname_array);
  DBMS_SQL.BIND_ARRAY(c, ':jobs_array', jobs_array);
  DBMS_SQL.BIND_ARRAY(c, ':mgr_array', mgr_array);
  DBMS_SQL.BIND_ARRAY(c, ':hiredate_array', hiredate_array);
  DBMS_SQL.BIND_ARRAY(c, ':sal_array', sal_array);
  DBMS_SQL.BIND_ARRAY(c, ':comm_array', comm_array);
  DBMS_SQL.BIND_ARRAY(c, ':deptno_array', deptno_array);
  dummy := DBMS_SQL.EXECUTE(c);
  DBMS_SQL.CLOSE_CURSOR(c);
  EXCEPTION WHEN OTHERS THEN
    IF DBMS_SQL.IS_OPEN(c) THEN
      DBMS_SQL.CLOSE_CURSOR(c);
    END IF;
    RAISE;
END;
/
SHOW ERRORS;
```
以下是批量 `UPDATE` 语句的示例，演示了为 `emp` 表中的 4 名现有员工更新工资：
```
DECLARE
  stmt VARCHAR2(200);
  empno_array     DBMS_SQL.NUMBER_TABLE;
  salary_array    DBMS_SQL.NUMBER_TABLE;
  c               NUMBER;
  dummy           NUMBER;
BEGIN
  empno_array(1):= 7369;
  empno_array(2):= 7876;
  empno_array(3):= 7900;
  empno_array(4):= 7934;
  salary_array(1) := 10000;
  salary_array(2) := 10000;
  salary_array(3) := 10000;
  salary_array(4) := 10000;
  stmt := 'update emp set sal = :salary_array
    WHERE empno = :num_array';
  c := DBMS_SQL.OPEN_CURSOR;
  DBMS_SQL.PARSE(c, stmt, DBMS_SQL.NATIVE);
  DBMS_SQL.BIND_ARRAY(c, ':num_array', empno_array);
  DBMS_SQL.BIND_ARRAY(c, ':salary_array', salary_array);
  dummy := DBMS_SQL.EXECUTE(c);
  DBMS_SQL.CLOSE_CURSOR(c);
  EXCEPTION WHEN OTHERS THEN
    IF DBMS_SQL.IS_OPEN(c) THEN
      DBMS_SQL.CLOSE_CURSOR(c);
    END IF;
    RAISE;
END;
/
```
例如，在 `DELETE` 语句中，您可以绑定 `WHERE` 子句中的数组，并使该语句对数组中的每个元素执行：
```
DECLARE
  stmt VARCHAR2(200);
  dept_no_array DBMS_SQL.NUMBER_TABLE;
  c NUMBER;
  dummy NUMBER;
begin
  dept_no_array(1) := 10; dept_no_array(2) := 20;
  dept_no_array(3) := 30; dept_no_array(4) := 40;
  dept_no_array(5) := 30; dept_no_array(6) := 40;
  stmt := 'delete from emp where deptno = :dept_array';
  c := DBMS_SQL.OPEN_CURSOR;
  DBMS_SQL.PARSE(c, stmt, DBMS_SQL.NATIVE);
  DBMS_SQL.BIND_ARRAY(c, ':dept_array', dept_no_array, 1, 4);
  dummy := DBMS_SQL.EXECUTE(c);
  DBMS_SQL.CLOSE_CURSOR(c);
  EXCEPTION WHEN OTHERS THEN
    IF DBMS_SQL.IS_OPEN(c) THEN
      DBMS_SQL.CLOSE_CURSOR(c);
    END IF;
    RAISE;
END;
/
```
在前面的示例中，按照 `BIND_ARRAY` 调用的指定，仅使用了元素 1 到 4。数组中的每个元素都可能会从数据库中删除大量员工。

#### BIND_VARIABLE 过程

这些过程根据语句中的变量名，将给定值或一组值绑定到游标中的指定变量。
语法
```
DBMS_SQL.BIND_VARIABLE (
   c              IN INTEGER,
   name           IN VARCHAR2,
   value          IN <datatype>);
```
其中 <datatype> 可以是以下任意一种类型：
```
ADT (user-defined object types)
BINARY_DOUBLE
BINARY_FLOAT
BFILE
BLOB
BOOLEAN
CLOB CHARACTER SET ANY_CS
DATE
DSINTERVAL_UNCONSTRAINED
NESTED table
NUMBER
OPAQUE types
REF
TIME_UNCONSTRAINED
TIME_TZ_UNCONSTRAINED
TIMESTAMP_LTZ_UNCONSTRAINED
TIMESTAMP_TZ_UNCONSTRAINED
TIMESTAMP_UNCONSTRAINED
UROWID
VARCHAR2 CHARACTER SET ANY_CS
VARRAY
YMINTERVAL_UNCONSTRAINED
```
请注意，`BIND_VARIABLE` 已重载以接受不同的 datatype。
`BIND_VARIABLE` 还支持以下语法。方括号 [] 表示 `BIND_VARIABLE` 过程的可选参数。
```
DBMS_SQL.BIND_VARIABLE (
   c              IN INTEGER,
   name           IN VARCHAR2,
   value          IN VARCHAR2 CHARACTER SET ANY_CS [,out_value_size IN INTEGER]);
```
要绑定 `CHAR`、`RAW` 和 `ROWID` 数据，可以使用以下语法变体：
```
DBMS_SQL.BIND_VARIABLE_CHAR (
   c              IN INTEGER,
   name           IN VARCHAR2,
   value          IN CHAR CHARACTER SET ANY_CS [,out_value_size IN INTEGER]);
DBMS_SQL.BIND_VARIABLE_RAW (
   c              IN INTEGER,
   name           IN VARCHAR2,
   value          IN RAW [,out_value_size IN INTEGER]);
DBMS_SQL.BIND_VARIABLE_ROWID (
   c              IN INTEGER,
   name           IN VARCHAR2,
   value          IN ROWID);
```
Pragma
```
pragma restrict_references(bind_variable,WNDS);
```
参数
表 170-8 BIND_VARIABLE 过程参数
| 参数 | 描述 |
|---|---|
| c | 要将值绑定到的游标的 ID 号。 |
| name | 语句中的变量名。绑定变量名的长度必须 <=30 字节。 |
| value | 要绑定到游标中变量的值。对于 IN 和 IN/OUT 变量，该值与为此参数传入的值的类型相同。 |
| out_value_size | VARCHAR2、RAW、CHAR OUT 或 IN/OUT 变量的最大预期 OUT 值大小（以字节为单位）。如果未指定大小，则使用当前值的长度。如果未初始化 value 参数，则必须指定此参数。 |
使用注意事项
如果变量是 `IN` 或 `IN`/`OUT` 变量，或者是 `IN` 集合，则给定的绑定值必须对该变量或数组类型有效。`OUT` 变量的绑定值将被忽略。
SQL 语句的绑定变量或集合由其名称标识。将值绑定到绑定变量或绑定数组时，在语句中标识它的字符串必须包含前导冒号，如下例所示：
```
SELECT emp_name FROM emp WHERE SAL > :X;
```
对于此示例，相应的绑定调用类似于
```
BIND_VARIABLE(cursor_name, ':X', 3500);
or
BIND_VARIABLE (cursor_name, 'X', 3500);
```

#### BIND_VARIABLE_PKG 过程

此过程根据语句中变量的名称，将给定的单个值或一组值绑定到游标中的指定变量。变量的类型必须在包规范中声明。这些类型不支持批量操作。
语法
```
DBMS_SQL.BIND_VARIABLE_PKG (
   c              IN INTEGER,
   name           IN VARCHAR2,
   value          IN <datatype>);
```
其中 <datatype> 可以是以下任意一种数据类型：
- RECORD
- VARRAY
- NESTED TABLE
- INDEX BY PLS_INTEGER TABLE
- INDEX BY BINARY_INTEGER TABLE
表 170-9 BIND_VARIABLE_PKG 参数
| 参数 | 描述 |
|---|---|
| c | 要从中获取值的游标的 ID 编号。 |
| name | 语句中要检索其值的变量的名称。 |
| value | 单行选项：返回指定位置的变量值。如果此输出参数的类型与调用 BIND_VARIABLE_PKG 所定义的值的实际类型不同，Oracle 将引发异常 ORA-06562, inconsistent_type。数组选项：已声明为 <table_type> 的局部变量 |
示例 170-2 使用 DBMS_SQL.BIND_VARIABLE_PKG 绑定包变量的动态 SQL
变量类型在包规范中声明。`BIND_VARIABLE_PKG` 用于将变量 v1 绑定到游标 SQL 语句中。
```
CREATE OR REPLACE PACKAGE ty_pkg AS
   TYPE rec IS RECORD ( n1 NUMBER, n2 NUMBER);
   TYPE trec IS TABLE OF REC INDEX BY BINARY_INTEGER;
   TYPE trect IS TABLE OF NUMBER;
   TYPE trecv IS VARRAY(100) OF NUMBER;
END ty_pkg;
/
CREATE OR REPLACE PROCEDURE dyn_sql_ibbi AS
  dummy NUMBER;
  cur   NUMBER;
  v1 ty_pkg.trec;
  str VARCHAR2(3000);
  n1 NUMBER;
  n2 NUMBER;
BEGIN
  FOR i in 1..3 LOOP
     v1(i).n1 := i*10;
     v1(i).n2 := i*20;
  END LOOP;
  str := 'SELECT * FROM TABLE(:v1)' ;
  cur := DBMS_SQL.OPEN_CURSOR();
  DBMS_SQL.PARSE(cur, str, DBMS_SQL.NATIVE);
  DBMS_SQL.BIND_VARIABLE_PKG(cur, ':v1', v1);
  dummy := DBMS_SQL.EXECUTE(cur);
  DBMS_SQL.DEFINE_COLUMN(cur, 1, n1);
  DBMS_SQL.DEFINE_COLUMN(cur, 2, n2);
  LOOP
    IF DBMS_SQL.FETCH_ROWS(cur) > 0 THEN
      -- get column values of the row
       DBMS_SQL.COLUMN_VALUE(cur, 1, n1);
       DBMS_SQL.COLUMN_VALUE(cur, 2, n2);
       DBMS_OUTPUT.PUT_LINE('n1 = '||n1||' n2 = '||n2);
    ELSE
      -- No more rows
       EXIT;
    END IF;
  END LOOP;
  DBMS_SQL.CLOSE_CURSOR(cur);
END dyn_sql_ibbi;
/
EXEC dyn_sql_ibbi;
n1 = 10 n2 = 20
n1 = 20 n2 = 40
n1 = 30 n2 = 60
```

#### `CLOSE_CURSOR` 过程

此过程关闭给定的游标。
语法
```
DBMS_SQL.CLOSE_CURSOR (
   c    IN OUT INTEGER);
```
Pragmas
```
pragma restrict_references(close_cursor,RNDS,WNDS);
```
参数
Table 170-10 `CLOSE_CURSOR` 过程参数
| 参数 | 模式 | 描述 |
|---|---|---|
| `c` | `IN` | 要关闭的游标的 `ID` 号。 |
| `c` | `OUT` | 游标被设置为 `null`。调用 `CLOSE_CURSOR` 后，分配给该游标的内存将被释放，并且您无法再从该游标中提取数据。 |

#### COLUMN_VALUE Procedure

此过程返回给定游标中指定位置处的游标元素值。此过程用于访问通过调用 `FETCH_ROWS` 获取的数据。
语法
```
DBMS_SQL.COLUMN_VALUE (
   c                 IN  INTEGER,
   position          IN  INTEGER,
   value             OUT <datatype>
 [,column_error      OUT NUMBER]
 [,actual_length     OUT INTEGER]);
```
其中方括号 [ ] 表示可选参数，<`datatype`> 可以是以下任意一种类型：
```
BINARY_DOUBLE
BINARY_FLOAT
BFILE
BLOB
CLOB CHARACTER SET ANY_CS
DATE
DSINTERVAL_UNCONSTRAINED
NUMBER
TIME_TZ_UNCONSTRAINED
TIME_UNCONSTRAINED
TIMESTAMP_LTZ_UNCONSTRAINED
TIMESTAMP_TZ_UNCONSTRAINED
TIMESTAMP_UNCONSTRAINED
UROWID
VARCHAR2 CHARACTER SET ANY_CS
YMINTERVAL_UNCONSTRAINED
user-defined object types
collections (VARRAYs and nested tables)
REFs
Opaque types
```
对于包含 `CHAR`、`RAW` 和 `ROWID` 数据的变量，可以使用以下语法变体：
```
DBMS_SQL.COLUMN_VALUE_CHAR (
   c               IN  INTEGER,
   position        IN  INTEGER,
   value           OUT CHAR CHARACTER SET ANY_CS
 [,column_error    OUT NUMBER]
 [,actual_length   OUT INTEGER]);
DBMS_SQL.COLUMN_VALUE_RAW (
   c               IN  INTEGER,
   position        IN  INTEGER,
   value           OUT RAW
 [,column_error    OUT NUMBER]
 [,actual_length   OUT INTEGER]);
DBMS_SQL.COLUMN_VALUE_ROWID (
   c               IN  INTEGER,
   position        IN  INTEGER,
   value           OUT ROWID
 [,column_error    OUT NUMBER]
 [,actual_length   OUT INTEGER]);
```
以下语法使 `COLUMN_VALUE` 过程能够支持批量操作：
```
DBMS_SQL.COLUMN_VALUE(
   c                 IN             INTEGER,
   position          IN             INTEGER,
   <param_name>      IN OUT NOCOPY  <table_type>);
```
其中 <`param_name`> 及其对应的 <`table_type`> 可以是以下匹配对中的任意一个：
```
bdbl_tab     Binary_Double_Table
bflt_tab     Binary_Float_Table
bf_tab       Bfile_Table
bl_tab       Blob_Table
cl_tab       Clob_Table
d_tab        Date_Table
ids_tab      Interval_Day_To_Second_Table
iym_tab      Interval_Year_To_Month_Table
n_tab        Number_Table
tm_tab       Time_Table
ttz_tab      Time_With_Time_Zone_Table
tms_tab      Timestamp_Table
tstz_tab     Timestamp_With_ltz_Table
tstz_tab     Timestamp_With_Time_Zone_Table
ur_tab       Urowid_Table
c_tab        Varchar2_Table
```
Pragma
```
pragma restrict_references(column_value,RNDS,WNDS);
```
参数
Table 170-11 COLUMN_VALUE Procedure Parameters (Single Row)
| Parameter | Description |
|---|---|
| c | 要从中提取值的游标 ID 号。 |
| position | 游标中列的相对位置。语句中的第一列位置为 1。 |
| value | 返回指定列的值。如果此输出参数的类型与值的实际类型（由调用 DEFINE_COLUMN 定义）不同，Oracle 将引发异常 ORA-06562, inconsistent_type。 |
| column_error | 返回指定列值的任何错误代码。 |
| actual_length | 指定列中值在截断前的实际长度。 |
Table 170-12 COLUMN_VALUE Procedure Parameters (Bulk)
| Parameter | Description |
|---|---|
| c | 要从中提取值的游标 ID 号。 |
| position | 游标中列的相对位置。语句中的第一列位置为 1。 |
| <param_name> | 已声明为 <table_type> 的局部变量。<param_name> 是用于批量操作的 IN OUT NOCOPY 参数。对于批量操作，子程序会在适当的（隐式维护的）索引处追加新元素。例如，如果在使用 DEFINE_ARRAY 过程时指定了 10 行的批量大小（cnt 参数）并指定了 1 的起始索引（lower_bound），那么在调用 FETCH_ROWS 函数之后首次调用此子程序将填充索引 1..10 处的元素，而下一次调用将填充 11..20 处的元素，依此类推。 |
异常
如果给定 `OUT` 参数 `value` 的类型与值的实际类型不同，将引发 `INCONSISTENT_TYPE` (`ORA`-`06562`)。此类型是在通过调用过程 `DEFINE_COLUMN` 定义列时所给定的类型。

#### COLUMN_VALUE_LONG 过程

此过程用于获取 long 列值的一部分。
语法
```
DBMS_SQL.COLUMN_VALUE_LONG (
   c            IN  INTEGER,
   position     IN  INTEGER,
   length       IN  INTEGER,
   offset       IN  INTEGER,
   value        OUT VARCHAR2,
   value_length OUT INTEGER);
```
Pragmas
```
pragma restrict_references(column_value_long,RNDS,WNDS);
```
参数
Table 170-13 COLUMN_VALUE_LONG Procedure Parameters
| Parameter | Description |
|---|---|
| c | 要从中获取值的游标的游标 ID 编号。 |
| position | 要获取其值的列的位置。 |
| length | 要提取的 long 值的字节数。 |
| offset | long 字段中开始提取处的偏移量。 |
| value | 作为 VARCHAR2 返回的列值。 |
| value_length | 实际在 value 中返回的字节数。 |

#### DEFINE_ARRAY 过程

此过程为您要从中提取行的列定义集合（通过调用 `FETCH_ROWS`）。此过程允许您从单个 `SELECT` 语句中批量提取行。一次提取调用会将多行数据提取到 PL/SQL 聚合对象中。
当您提取行时，它们会被复制到 `DBMS_SQL` 缓冲区中，直到您运行 `COLUMN_VALUE` 调用，此时这些行会被复制到作为参数传递给 `COLUMN_VALUE` 调用的表中。

集合的标量和 LOB 类型
您可以将局部变量声明为以下任一表项类型，然后使用 `DBMS_SQL` 向其中提取任意数量的行。（这些类型与您可以为 `BIND_ARRAY` 过程指定的类型相同。）
```
TYPE binary_double_table
                    IS TABLE OF BINARY_DOUBLE  INDEX BY BINARY_INTEGER;
TYPE binary_float_table
                    IS TABLE OF BINARY_FLOAT   INDEX BY BINARY_INTEGER;
TYPE bfile_table    IS TABLE OF BFILE          INDEX BY BINARY_INTEGER;
TYPE blob_table     IS TABLE OF BLOB           INDEX BY BINARY_INTEGER;
TYPE clob_table     IS TABLE OF CLOB           INDEX BY BINARY_INTEGER;
TYPE date_table     IS TABLE OF DATE           INDEX BY BINARY_INTEGER;
TYPE interval_day_to_second_Table
                    IS TABLE OF dsinterval_unconstrained
                                               INDEX BY BINARY_INTEGER;
TYPE interval_year_to_MONTH_Table
                    IS TABLE OF yminterval_unconstrained
                                               INDEX BY BINARY_INTEGER;
TYPE number_table   IS TABLE OF NUMBER         INDEX BY BINARY_INTEGER;
TYPE time_table     IS TABLE OF time_unconstrained
                                               INDEX BY BINARY_INTEGER;
TYPE time_with_time_zone_table
                    IS TABLE OF time_tz_unconstrained
                                               INDEX BY BINARY_INTEGER;
TYPE timestamp_table
                    IS TABLE OF timestamp_unconstrained
                                               INDEX BY BINARY_INTEGER;
TYPE timestamp_with_ltz_Table
                    IS TABLE OF timestamp_ltz_unconstrained
                                               INDEX BY BINARY_INTEGER;
TYPE timestamp_with_time_zone_Table
                    IS TABLE OF timestamp_tz_unconstrained
                                               INDEX BY BINARY_INTEGER;
TYPE urowid_table   IS TABLE OF UROWID         INDEX BY BINARY_INTEGER;
TYPE varchar2_table IS TABLE OF VARCHAR2(2000) INDEX BY BINARY_INTEGER;
```
语法
```
DBMS_SQL.DEFINE_ARRAY (
   c           IN INTEGER,
   position    IN INTEGER,
   <table_variable>    IN <datatype>
   cnt         IN INTEGER,
   lower_bnd   IN INTEGER);
```
其中 <`table_variable`> 及其对应的 <datatype> 可以是以下任意匹配对之一，`DEFINE_ARRAY` 经过重载以接受不同的数据类型：
```
<clob_tab>     Clob_Table
<bflt_tab>     Binary_Float_Table
<bdbl_tab>     Binary_Double_Table
<blob_tab>     Blob_Table
<bfile_tab>    Bfile_Table
<date_tab>     Date_Table
<num_tab>      Number_Table
<urowid_tab>   Urowid_Table
<vchr2_tab>    Varchar2_Table
<tm_tab>       Time_Table
<ttz_tab>      Time_With_Time_Zone_Table
<tms_tab>      Timestamp_Table
<tstz_tab>     Timestamp_With_ltz_Table
<tstz_tab>     Timestamp_With_Time_Zone_Table
<ids_tab>      Interval_Day_To_Second_Table
<iym_tab>      Interval_Year_To_Month_Table
```
编译指示
```
pragma restrict_references(define_array,RNDS,WNDS);
```
随后的 `FETCH_ROWS` 调用将提取 "count" 行。当进行 `COLUMN_VALUE` 调用时，这些行会被放置在 `lower_bnd`、`lower_bnd`+1、`lower_bnd`+2 等位置。只要还有行返回，用户就会不断发出 `FETCH_ROWS`/`COLUMN_VALUE` 调用。这些行会不断累积在作为参数指定给 `COLUMN_VALUE` 调用的表中。

参数
表 170-14 DEFINE_ARRAY 过程参数
| 参数 | 描述 |
|---|---|
| c | 要将数组绑定到的游标的 ID 号。 |
| position | 所定义数组中列的相对位置。语句中的第一列位置为 1。 |
| table_variable | 已声明为 <datatype> 的局部变量。 |
| cnt | 必须提取的行数。 |
| lower_bnd | 结果将被复制到集合中，从此下界索引开始。 |

使用注意事项
计数 `(cnt)` 必须是大于零的整数；否则会引发异常。`lower_bnd` 可以是正数、负数或零。已对其发出 `DEFINE_ARRAY` 调用的查询不能包含数组绑定。

示例
```
PROCEDURE BULK_PLSQL(deptid NUMBER)
    TYPE namelist IS TABLE OF employees.last_name%TYPE;
    TYPE sallist IS TABLE OF employees.salary%TYPE;
    names    namelist;
    sals     sallist;
    c        NUMBER;
    r        NUMBER;
    sql_stmt VARCHAR2(32767) :=
        'SELECT last_name, salary FROM employees WHERE department_id = :b1';
BEGIN
    c := DBMS_SQL.OPEN_CURSOR;
    DBMS_SQL.PARSE(c, sql_stmt, dbms_sql.native);
    DBMS_SQL.BIND_VARIABLE(c, 'b1', deptid);
    DBMS_SQL.DEFINE_ARRAY(c, 1, names, 5);
    DBMS_SQL.DEFINE_ARRAY(c, 2, sals, 5);
    r := DBMS_SQL.EXECUTE(c);
    LOOP
      r := DBMS_SQL.FETCH_ROWS(c);
      DBMS_SQL.COLUMN_VALUE(c, 1, names);
      DBMS_SQL.COLUMN_VALUE(c, 2, sals);
      EXIT WHEN r != 5;
    END LOOP;
    DBMS_SQL.CLOSE_CURSOR(c);
    -- loop through the names and sals collections
    FOR i IN names.FIRST .. names.LAST  LOOP
      DBMS_OUTPUT.PUT_LINE('Name = ' || names(i) || ', salary = ' || sals(i));
    END LOOP;
END;
/
```
示例 170-3 示例：定义数组
以下示例展示了如何使用 `DEFINE_ARRAY` 过程：
```
declare
  c       NUMBER;
  d       NUMBER;
  n_tab   DBMS_SQL.NUMBER_TABLE;
  indx    NUMBER := -10;
BEGIN
  c := DBMS_SQL.OPEN_CURSOR;
  dBMS_SQL.PARSE(c, 'select n from t order by 1', DBMS_SQL.NATIVE);
  DBMS_SQL.DEFINE_ARRAY(c, 1, n_tab, 10, indx);
  d := DBMS_SQL.EXECUTE(c);
  loop
    d := DBMS_SQL.FETCH_ROWS(c);
    DBMS_SQL.COLUMN_VALUE(c, 1, n_tab);
    EXIT WHEN d != 10;
  END LOOP;
  DBMS_SQL.CLOSE_CURSOR(c);
  EXCEPTION WHEN OTHERS THEN
    IF DBMS_SQL.IS_OPEN(c) THEN
      DBMS_SQL.CLOSE_CURSOR(c);
    END IF;
    RAISE;
END;
/
```
上面的示例每次调用 FETCH_ROWS 函数时，都会提取 10 行保存在 `DBMS_SQL` 缓冲区中。当调用 COLUMN_VALUE 过程时，这些行将移动到指定的 PL/SQL 表（在本例中为 `n_tab`）中，位置为 -10 到 -1，正如 `DEFINE` 语句中指定的那样。当在循环中提取第二批时，行将移动到位置 0 到 9；依此类推。
每个数组的当前索引会自动维护。此索引在 `EXECUTE` 时被初始化为 "indx"，并在每次调用 `COLUMN_VALUE` 时更新。如果您在任何时候重新执行，每个 `DEFINE` 的当前索引都会被重新初始化为 "indx"。
通过这种方式，查询的全部结果都被提取到表中。当 `FETCH_ROWS` 无法提取 10 行时，它会返回实际提取的行数（如果无法提取任何行，则返回零）并退出循环。

以下是使用 `DEFINE_ARRAY` 过程的另一个示例：
考虑一个定义为如下形式的表 `MULTI_TAB`：
```
CREATE TABLE multi_tab (num NUMBER,
                        dat1 DATE,
                        var VARCHAR2(24),
                        dat2 DATE)
```
要选择该表中的所有内容并将其移动到四个 PL/SQL 表中，您可以使用以下简单程序：
```
DECLARE
  c       NUMBER;
  d       NUMBER;
  n_tab  DBMS_SQL.NUMBER_TABLE;
  d_tab1 DBMS_SQL.DATE_TABLE;
  v_tab  DBMS_SQL.VARCHAR2_TABLE;
  d_tab2 DBMS_SQL.DATE_TABLE;
  indx NUMBER := 10;
BEGIN
  c := DBMS_SQL.OPEN_CURSOR;
  DBMS_SQL.PARSE(c, 'select * from multi_tab order by 1', DBMS_SQL.NATIVE);
  DBMS_SQL.DEFINE_ARRAY(c, 1, n_tab,  5, indx);
  DBMS_SQL.DEFINE_ARRAY(c, 2, d_tab1, 5, indx);
  DBMS_SQL.DEFINE_ARRAY(c, 3, v_tab,  5, indx);
  DBMS_SQL.DEFINE_ARRAY(c, 4, d_tab2, 5, indx);
  d := DBMS_SQL.EXECUTE(c);
  LOOP
    d := DBMS_SQL.FETCH_ROWS(c);
    DBMS_SQL.COLUMN_VALUE(c, 1, n_tab);
    DBMS_SQL.COLUMN_VALUE(c, 2, d_tab1);
    DBMS_SQL.COLUMN_VALUE(c, 3, v_tab);
    DBMS_SQL.COLUMN_VALUE(c, 4, d_tab2);
    EXIT WHEN d != 5;
  END LOOP;
  DBMS_SQL.CLOSE_CURSOR(c);
/*
```
这四个表可以用于任何用途。一种用法可能是使用 `BIND_ARRAY` 通过诸如 '`INSERT` into `SOME_T` values (:a, :b, :c, :d);' 的语句将这些行移动到另一个表。
```
*/
EXCEPTION WHEN OTHERS THEN
    IF DBMS_SQL.IS_OPEN(c) THEN
      DBMS_SQL.CLOSE_CURSOR(c);
    END IF;
    RAISE;
END;
/
```

#### DEFINE_COLUMN Procedures

此过程用于定义从给定游标中选择的列。此过程仅用于 `SELECT` 游标。
被定义的列由其在给定游标中语句的 `SELECT` 列表中的相对位置标识。`COLUMN` 值的类型决定了被定义列的类型。
另请参见 DEFINE_COLUMN_CHAR Procedure、DEFINE_COLUMN_LONG Procedure、DEFINE_COLUMN_RAW Procedure 和 DEFINE_COLUMN_ROWID Procedure。
语法
```
DBMS_SQL.DEFINE_COLUMN (
   c              IN INTEGER,
   position       IN INTEGER,
   column         IN <datatype>);
```
其中 <`datatype`> 可以是以下任意一种类型：
```
BINARY_DOUBLE
BINARY_FLOAT
BFILE
BLOB
CLOB CHARACTER SET ANY_CS
DATE
DSINTERVAL_UNCONSTRAINED
NUMBER
TIME_UNCONSTRAINED
TIME_TZ_UNCONSTRAINED
TIMESTAMP_LTZ_UNCONSTRAINED
TIMESTAMP_TZ_UNCONSTRAINED
TIMESTAMP_UNCONSTRAINED
UROWID
YMINTERVAL_UNCONSTRAINED
user-defined object types
collections (VARRAYs and nested tables)
REFs
Opaque types
```
注意，`DEFINE_COLUMN` 经过重载以接受不同的数据类型。
`DEFINE_COLUMN` 过程还支持以下语法：
```
DBMS_SQL.DEFINE_COLUMN (
   c              IN INTEGER,
   position       IN INTEGER,
   column         IN VARCHAR2 CHARACTER SET ANY_CS,
   column_size    IN INTEGER);
```
Pragma
```
pragma restrict_references(define_column,RNDS,WNDS);
```
参数
Table 170-15 DEFINE_COLUMN Procedure Parameters
| 参数 | 描述 |
|---|---|
| c | 要定义其待选择行的游标的 ID 号 |
| position | 被定义的行中列的相对位置。语句中的第一列位置为 1。 |
| column | 被定义列的值。该值的类型决定了被定义列的类型。 |
| column_size | 对于 VARCHAR2 类型的列，列值以字节为单位的最大预期大小。 |
使用说明
使用字符长度语义时，对于 `VARCHAR2` 类型的列值，可返回的最大字节数计算方式为：`column_size` `*` 当前字符集的最大字符字节大小。例如，将 `column_size` 指定为 10，意味着在 UTF8 字符集下使用字符长度语义时，无论其表示的字符数是多少，最多可以返回 30 (10*3) 个字节。

#### DEFINE_COLUMN_CHAR 过程

此过程定义一个具有 `CHAR` 数据的列，以便从给定游标中提取该列。此过程仅用于 `SELECT` 游标。
被定义的列由其在给定游标中语句的 `SELECT` 列表中的相对位置来标识。`COLUMN` 值的类型决定了被定义列的类型。
另请参见 DEFINE_COLUMN Procedures、DEFINE_COLUMN_LONG Procedure、DEFINE_COLUMN_RAW Procedure 和 DEFINE_COLUMN_ROWID Procedure。
语法
```
DBMS_SQL.DEFINE_COLUMN_CHAR (
   c              IN INTEGER,
   position       IN INTEGER,
   column         IN CHAR CHARACTER SET ANY_CS,
   column_size    IN INTEGER);
```
Pragma
```
pragma restrict_references(define_column,RNDS,WNDS);
```
参数
Table 170-16 DEFINE_COLUMN_CHAR 过程参数
| Parameter | Description |
|---|---|
| c | 要为其定义提取行的游标的 ID 号 |
| position | 被定义列在行中的相对位置。语句中的第一列位置为 1。 |
| column | 被定义列的值。该值的类型决定了被定义列的类型。 |
| column_size | 对于 CHAR 类型的列，列值以字符为单位的最大预期大小。 |

#### DEFINE_COLUMN_LONG 过程

此过程为 `SELECT` 游标定义一个 `LONG` 列。所定义的列由其在给定游标对应语句的 `SELECT` 列表中的相对位置标识。`COLUMN` 值的类型决定了所定义列的类型。
另请参见 DEFINE_COLUMN 过程、DEFINE_COLUMN_CHAR 过程、DEFINE_COLUMN_RAW 过程和 DEFINE_COLUMN_ROWID 过程。
语法
```
DBMS_SQL.DEFINE_COLUMN_LONG (
   c              IN INTEGER,
   position       IN INTEGER);
```
参数
Table 170-17 DEFINE_COLUMN_LONG 过程参数
| Parameter | Description |
|---|---|
| c | 要选择和定义其行的游标的 ID number。 |
| position | 所定义行中列的相对位置。语句中的第一列位置为 1。 |

#### DEFINE_COLUMN_RAW 过程

此过程定义一个 `RAW` 类型的列，以便从给定游标中选取。
此过程仅用于 `SELECT` 游标。
被定义的列通过其在给定游标中语句的 `SELECT` 列表里的相对位置来标识。`COLUMN` 值的类型决定了被定义列的类型。
另请参见 DEFINE_COLUMN 过程、DEFINE_COLUMN_CHAR 过程、DEFINE_COLUMN_LONG 过程和 DEFINE_COLUMN_ROWID 过程。
语法
```
DBMS_SQL.DEFINE_COLUMN_RAW (
   c              IN INTEGER,
   position       IN INTEGER,
   column         IN RAW,
   column_size    IN INTEGER);
```
编译指示
```
pragma restrict_references(define_column,RNDS,WNDS);
```
参数
Table 170-18 DEFINE_COLUMN_RAW 过程参数
| Parameter | Description |
|---|---|
| c | 要定义被选取行的游标的 ID 号。 |
| position | 被定义列在行中的相对位置。语句中的第一列位置为 1。 |
| column | 被定义列的值。该值的类型决定了被定义列的类型。 |
| column_size | 对于 RAW 类型的列，列值的最大预期大小（以字节为单位）。 |

#### DEFINE_COLUMN_ROWID Procedure

此过程定义一个 `ROWID` 类型的列，以便从给定游标中进行选择。此过程仅与 `SELECT` 游标一起使用。
所定义的列由其在给定游标中语句的 `SELECT` 列表中的相对位置来标识。`COLUMN` 值的类型决定了所定义列的类型。
另请参见 DEFINE_COLUMN Procedures、DEFINE_COLUMN_CHAR Procedure、DEFINE_COLUMN_LONG Procedure 和 DEFINE_COLUMN_RAW Procedure。
语法
```
DBMS_SQL.DEFINE_COLUMN_ROWID (
   c              IN INTEGER,
   position       IN INTEGER,
   column         IN ROWID);
```
Pragma
```
pragma restrict_references(define_column,RNDS,WNDS);
```
参数
表 170-19 DEFINE_COLUMN_ROWID Procedure 参数
| Parameter | Description |
|---|---|
| c | 要选择并定义其行的游标的 ID 编号 |
| position | 所定义行中列的相对位置。语句中的第一列 position 为 1。 |
| column | 所定义列的值。此值的类型决定了所定义列的类型。 |

#### DESCRIBE_COLUMNS 过程

此过程用于描述通过 `DBMS_SQL` 打开并解析的游标的列。
语法
```
DBMS_SQL.DESCRIBE_COLUMNS (
   c              IN  INTEGER,
   col_cnt        OUT INTEGER,
   desc_t         OUT DESC_TAB);
```
参数
表 170-20  DESCRIBE_COLUMNS 过程参数
| Parameter | Description |
|---|---|
| c | 要描述的列所在游标的 ID 编号 |
| col_cnt | 查询的 select 列表中的列数 |
| desc_t | 用于填充查询中各列描述的描述表 |

示例 170-4 描述列
通过对要描述的表使用 `SELECT` * 查询，此代码可用作 SQL*Plus `DESCRIBE` 调用的替代方法。
```
DECLARE
  c           NUMBER;
  d           NUMBER;
  col_cnt     INTEGER;
  f           BOOLEAN;
  rec_tab     DBMS_SQL.DESC_TAB;
  col_num    NUMBER;
  PROCEDURE print_rec(rec in DBMS_SQL.DESC_REC) IS
  BEGIN
    DBMS_OUTPUT.NEW_LINE;
    DBMS_OUTPUT.PUT_LINE('col_type            =    ' || rec.col_type);
    DBMS_OUTPUT.PUT_LINE('col_maxlen          =    ' || rec.col_max_len);
    DBMS_OUTPUT.PUT_LINE('col_name            =    ' || rec.col_name);
    DBMS_OUTPUT.PUT_LINE('col_name_len        =    ' || rec.col_name_len);
    DBMS_OUTPUT.PUT_LINE('col_schema_name     =    ' || rec.col_schema_name);
    DBMS_OUTPUT.PUT_LINE('col_schema_name_len =    ' || rec.col_schema_name_len);
    DBMS_OUTPUT.PUT_LINE('col_precision       =    ' || rec.col_precision);
    DBMS_OUTPUT.PUT_LINE('col_scale           =    ' || rec.col_scale);
    DBMS_OUTPUT.PUT('col_null_ok         =    ');
    IF (rec.col_null_ok) THEN
      DBMS_OUTPUT.PUT_LINE('true');
    ELSE
      DBMS_OUTPUT.PUT_LINE('false');
    END IF;
  END;
BEGIN
  c := DBMS_SQL.OPEN_CURSOR;
  DBMS_SQL.PARSE(c, 'SELECT * FROM scott.bonus', DBMS_SQL.NATIVE);
  d := DBMS_SQL.EXECUTE(c);
  DBMS_SQL.DESCRIBE_COLUMNS(c, col_cnt, rec_tab);
/*
 * 以下循环可以直接写为 for j in 1..col_cnt loop。
 * 这里我们只是演示 PL/SQL 表的某些特性。
 */
  col_num := rec_tab.first;
  IF (col_num IS NOT NULL) THEN
    LOOP
      print_rec(rec_tab(col_num));
      col_num := rec_tab.next(col_num);
      EXIT WHEN (col_num IS NULL);
    END LOOP;
  END IF;
  DBMS_SQL.CLOSE_CURSOR(c);
END;
/
```

#### DESCRIBE_COLUMNS2 过程

此过程描述指定的列。它是 DESCRIBE_COLUMNS 过程的替代方案。
语法
```
DBMS_SQL.DESCRIBE_COLUMNS2 (
   c              IN  INTEGER,
   col_cnt        OUT INTEGER,
   desc_t         OUT DESC_TAB2);
```
编译指示
```
PRAGMA RESTRICT_REFERENCES(describe_columns2,WNDS);
```
参数
表 170-21 DESCRIBE_COLUMNS2 过程参数
| 参数 | 描述 |
|---|---|
| c | 正在描述的列所在游标的 ID 号。 |
| col_cnt | 查询选择列表中的列数。 |
| desc_t | 用于填入查询中各列描述的描述表。此表的索引范围从 1 到查询选择列表中的元素数量。 |
**相关主题**
                           - DESCRIBE_COLUMNS 过程

#### DESCRIBE_COLUMNS3 过程

此过程用于描述指定的列。它是 DESCRIBE_COLUMNS 过程的替代方案。
语法
```
DBMS_SQL.DESCRIBE_COLUMNS3 (
   c              IN  INTEGER,
   col_cnt        OUT INTEGER,
   desc_t         OUT DESC_TAB3);
BMS_SQL.DESCRIBE_COLUMNS3 (
   c              IN  INTEGER,
   col_cnt        OUT INTEGER,
   desc_t         OUT DESC_TAB4);
```
Pragmas
```
PRAGMA RESTRICT_REFERENCES(describe_columns3,WNDS);
```
参数
Table 170-22 DESCRIBE_COLUMNS3 过程参数
| Parameter | Description |
|---|---|
| c | 正在被描述的列所在游标的 ID 编号。 |
| col_cnt | 查询选择列表中的列数。 |
| desc_t | 用于填充查询中各列描述的描述表。此表的索引从 1 开始，到查询选择列表中的元素数量为止。 |
使用说明
通过游标 ID 传入的游标必须已经 `OPEN` 并且经过 `PARSE`，否则会引发 "invalid cursor id" 错误。
示例
```
CREATE TYPE PROJECT_T AS OBJECT
      ( projname          VARCHAR2(20),
        mgr               VARCHAR2(20))
/
CREATE TABLE projecttab(deptno NUMBER, project HR.PROJECT_T)
/
DECLARE
  curid      NUMBER;
  desctab    DBMS_SQL.DESC_TAB3;
  colcnt     NUMBER;
  sql_stmt   VARCHAR2(200) := 'select * from projecttab';
BEGIN
    curid := DBMS_SQL.OPEN_CURSOR;
    DBMS_SQL.PARSE(curid, sql_stmt, DBMS_SQL.NATIVE);
    DBMS_SQL.DESCRIBE_COLUMNS3(curid, colcnt, desctab);
    FOR i IN 1 .. colcnt LOOP
      IF desctab(i).col_type = 109 THEN
        DBMS_OUTPUT.PUT(desctab(i).col_name || ' is user-defined type: ');
        DBMS_OUTPUT.PUT_LINE(desctab(i).col_schema_name || '.' ||
                             desctab(i).col_type_name);
      END IF;
    END LOOP;
    DBMS_SQL.CLOSE_CURSOR(curid);
END;
/
输出：
PROJECT is user-defined type: HR.PROJECT_T
```
**相关主题**
                           - DESCRIBE_COLUMNS 过程

#### EXECUTE Function

此函数执行给定的游标。此函数接受游标的 `ID` 号并返回已处理的行数。
返回值仅对 `INSERT`、`UPDATE` 和 `DELETE` 语句有效；对于其他类型的语句（包括 DDL），返回值未定义，必须忽略。
语法
```
DBMS_SQL.EXECUTE (
   c   IN INTEGER)
  RETURN INTEGER;
```
参数
Table 170-23 EXECUTE Function Parameters
| Parameter | Description |
|---|---|
| c | 要执行的游标的 Cursor ID number。 |
返回值
返回已处理的行数
用法说明
由 TO_CURSOR_NUMBER Function 返回的 `DBMS_SQL` 游标，其行为方式与已执行的 `DBMS_SQL` 游标相同。因此，对该游标调用 `EXECUTE` 将导致错误。

#### EXECUTE_AND_FETCH 函数

此函数执行给定的游标并提取行。
此函数提供的功能与先调用 `EXECUTE` 再调用 `FETCH_ROWS` 相同。但是，针对远程数据库使用时，调用 `EXECUTE_AND_FETCH` 可以减少网络往返次数。
`EXECUTE_AND_FETCH` 函数返回实际提取的行数。
语法
```
DBMS_SQL.EXECUTE_AND_FETCH (
   c              IN INTEGER,
   exact          IN BOOLEAN DEFAULT FALSE)
  RETURN INTEGER;
```
Pragma
```
pragma restrict_references(execute_and_fetch,WNDS);
```
参数
Table 170-24 EXECUTE_AND_FETCH 函数参数
| Parameter | Description |
|---|---|
| c | 要执行和提取的游标的 ID number。 |
| exact | 如果实际匹配查询的行数不为 1，则设置为 TRUE 以引发异常。注意：Oracle 不支持对 LONG 列使用精确提取 TRUE 选项。即使引发异常，行仍会被提取并保持可用。 |
返回值
返回指定的行

#### FETCH_ROWS Function

此函数从给定的游标中提取一行。
只要还有剩余的行可供提取，您就可以重复调用 `FETCH_ROWS`。这些行会被检索到缓冲区中，并且必须在每次调用 `FETCH_ROWS` 之后，针对每一列调用 `COLUMN_VALUE` 来读取。
`FETCH_ROWS` 函数接受要提取的游标的 ID 号，并返回实际提取的行数。
语法
```
DBMS_SQL.FETCH_ROWS (
   c              IN INTEGER)
  RETURN INTEGER;
```
Pragmas
```
pragma restrict_references(fetch_rows,WNDS);
```
参数
表 170-25 FETCH_ROWS 函数参数
| Parameter | Description |
|---|---|
| c | ID 号。 |
返回值
从给定的游标中返回一行

#### GET_NEXT_RESULT 过程

此过程获取返回给递归语句调用者的下一个结果的语句，或者，如果此调用者将自身设置为递归语句的客户端，则获取作为客户端返回给此调用者的下一个结果。
语句的返回顺序与 RETURN_RESULT 过程返回它们的顺序相同。
语法
```
DBMS_SQL.GET_NEXT_RESULT(
   c            IN          INTEGER,
   rc           OUT         SYS_REFCURSOR);
DBMS_SQL.GET_NEXT_RESULT(
   c            IN          INTEGER,
   rc           OUT         INTEGER);
```
参数
表 170-26 GET_NEXT_RESULT 过程参数
| Parameter | Description |
|---|---|
| c | 递归语句游标 |
| rc | 下一个返回结果语句的游标或 ref 游标 |
异常
`ORA-01403 no_data_found:` 当没有进一步的返回语句结果时，会引发此异常。
使用说明
- 在检索到语句结果的游标后，当不再需要该游标时，调用者必须正确关闭它。
- 关闭递归语句的游标后，所有未检索的返回语句的游标都将被关闭。
示例
```
DECLARE
  c  INTEGER;
  rc SYS_REFCURSOR;
BEGIN
  c := DBMS_SQL.OPEN_CURSOR(treat_as_client_for_results => TRUE);
  DBMS_SQL.PARSE(c                  => c,
                 statement          => 'begin proc; end;');
  DBMS_SQL.EXECUTE(c);
  LOOP
    BEGIN
      DBMS_SQL.GET_NEXT_RESULT(c, rc);
    EXCEPTIONS
      WHEN no_data_found THEN
        EXIT;
    END;
    LOOP
      FETCH rc INTO ...
      ...
    END LOOP;
  END LOOP;
END;
```

#### IS_OPEN Function

此函数用于检查给定的游标当前是否已打开。
语法
```
DBMS_SQL.IS_OPEN (
   c              IN INTEGER)
  RETURN BOOLEAN;
```
Pragmas
```
pragma restrict_references(is_open,RNDS,WNDS);
```
参数
Table 170-27 IS_OPEN Function Parameters
| Parameter | Description |
|---|---|
| c | 要检查的游标的 Cursor ID number。 |
返回值
对于任何已打开但尚未关闭的游标编号返回 `TRUE`，对于 `NULL` 游标编号返回 `FALSE`。请注意，CLOSE_CURSOR Procedure 会将传递给它的游标变量置为 `NULL`。
异常
`ORA-29471 DBMS_SQL access denied:` 如果检测到无效的游标 ID 编号，则会引发此异常。一旦会话遇到并报告了此错误，同一会话中随后的每次 DBMS_SQL 调用都将引发此错误，这意味着 DBMS_SQL 在此会话中无法使用。

#### LAST_ERROR_POSITION 函数

此函数返回 SQL 语句文本中发生错误的字节偏移量。SQL 语句中的第一个字符位于位置 0。
语法
```
DBMS_SQL.LAST_ERROR_POSITION
   RETURN INTEGER;
```
Pragmas
```
pragma restrict_references(last_error_position,RNDS,WNDS);
```
返回值
返回 SQL 语句文本中发生错误的字节偏移量
使用说明
在调用 `PARSE` 之后，且在调用任何其他 `DBMS_SQL` 过程或函数之前，调用此函数。

#### LAST_ROW_COUNT 函数

此函数返回已提取行数的累计计数。
语法
```
DBMS_SQL.LAST_ROW_COUNT
   RETURN INTEGER;
```
编译指示
```
pragma restrict_references(last_row_count,RNDS,WNDS);
```
返回值
返回已提取行数的累计计数
使用说明
在调用 `FETCH_ROWS` 或 `EXECUTE_AND_FETCH` 之后调用此函数。如果在调用 `EXECUTE` 之后调用，则返回值为零。

#### LAST_ROW_ID 函数

此函数返回最后处理行的 `ROWID`。
语法
```
DBMS_SQL.LAST_ROW_ID
   RETURN ROWID;
```
Pragmas
```
pragma restrict_references(last_row_id,RNDS,WNDS);
```
返回值
返回最后处理行的 `ROWID`
使用说明
在调用 `FETCH_ROWS` 或 `EXECUTE_AND_FETCH` 之后调用此函数。

#### LAST_SQL_FUNCTION_CODE 函数

此函数返回语句的 SQL 函数代码。
这些代码列在《Oracle Call Interface Programmer's Guide》中。
语法
```
DBMS_SQL.LAST_SQL_FUNCTION_CODE
   RETURN INTEGER;
```
Pragmas
```
pragma restrict_references(last_sql_function_code,RNDS,WNDS);
```
返回值
返回语句的 SQL 函数代码
使用说明
您必须在运行 SQL 语句后立即调用此函数；否则，返回值是未定义的。

#### OPEN_CURSOR 函数

此函数打开一个新游标。
`security_level` 参数允许对所打开游标的安全性实施细粒度控制。

语法
```
DBMS_SQL.OPEN_CURSOR (
   treat_as_client_for_results    IN     BOOLEAN    DEFAULT FALSE)
  RETURN INTEGER;
DBMS_SQL.OPEN_CURSOR (
   security_level                 IN     INTEGER,
   treat_as_client_for_results    IN     BOOLEAN    DEFAULT FALSE)
  RETURN INTEGER;
```

参数
表 170-28 OPEN_CURSOR 函数参数
| Parameter | Description |
|---|---|
| security_level | 指定对打开的游标强制执行的安全保护级别。有效的安全级别值为 0、1 和 2。当为此重载提供 NULL 参数值时，以及对于使用不带 security_level 参数的 open_cursor 重载打开的游标，将对打开的游标强制执行默认安全级别值 1。级别 0 - 允许对游标进行所有 DBMS_SQL 操作，无需任何安全检查。运行时的有效用户 ID 或角色与解析游标时有效的用户 ID 或角色不同，代码也可以从该游标中提取数据，甚至重新绑定和重新执行。默认情况下关闭此安全级别。级别 1 - 要求调用 DBMS_SQL 对此游标执行绑定和执行操作时所引用的容器、有效用户 ID 和角色，必须与此游标上最近一次解析操作的调用者相同。级别 2 - 要求调用 DBMS_SQL 对此游标执行所有绑定、执行、定义、描述和提取操作时所引用的容器、有效用户 ID 和角色，必须与此游标上最近一次解析操作的调用者相同。 |
| treat_as_client_for_results | 允许递归语句的调用者将自身设置为客户端，以接收从递归语句返回给客户端的语句结果。返回的语句结果可通过 GET_NEXT_RESULT 过程检索。 |

Pragmas
```
pragma restrict_references(open_cursor,RNDS,WNDS);
```

返回值
返回新游标的游标 ID 号。

使用注意事项
- 当不再需要此游标时，必须通过调用 CLOSE_CURSOR 过程显式关闭它。
- 您可以使用游标重复运行同一 SQL 语句或运行新的 SQL 语句。当重用游标时，在解析新的 SQL 语句时会重置相应游标数据区的内容。重用游标前无需关闭并重新打开它。

#### PARSE 过程

此过程在给定的游标中解析给定的语句。所有语句都会被立即解析。此外，DDL 语句在解析时会立即运行。
`PARSE` 过程有多个版本：
- 接受 VARCHAR2 语句作为参数
``````````
- 接受分段字符串，其中一个接受 VARCHAR2A（即 TABLE OF VARCHAR2(32767)）作为参数，另一个接受 VARCHAR2S（即 TABLE OF VARCHAR2(256)）作为参数。这些重载过程会拼接 PL/SQL 表语句的元素并解析生成的字符串。通过拆分语句，您可以使用这些过程来解析长度超过单个 VARCHAR2 变量限制的语句。
````
- 接受 CLOB 语句作为参数。您可以使用 parse 过程的 CLOB 重载版本来解析大于 32K 字节的 SQL 语句。
语法
每个版本都有多个重载。
```
DBMS_SQL.PARSE (
   c                           IN   INTEGER,
   statement                   IN   VARCHAR2,
   language_flag               IN   INTEGER[
 [,edition                     IN   VARCHAR2 DEFAULT NULL],
   apply_crossedition_trigger  IN   VARCHAR2 DEFAULT NULL,
   fire_apply_trigger          IN   BOOLEAN DEFAULT TRUE]
 [,schema                      IN   VARCHAR2 DEFAULT NULL]
 [,container                   IN   VARCHAR2)];
```
```
DBMS_SQL.PARSE (
   c                           IN   INTEGER,
   statement                   IN   CLOB,
   language_flag               IN   INTEGER[
 [,edition                     IN   VARCHAR2 DEFAULT NULL],
   apply_crossedition_trigger  IN   VARCHAR2 DEFAULT NULL,
   fire_apply_trigger          IN   BOOLEAN DEFAULT TRUE]
 [,schema                      IN   VARCHAR2 DEFAULT NULL]
 [,container                   IN   VARCHAR2)];
```
```
DBMS_SQL.PARSE (
   c                           IN   INTEGER,
   statement                   IN   VARCHAR2A,
   lb                          IN   INTEGER,
   ub                          IN   INTEGER,
   lfflg                       IN   BOOLEAN,
   language_flag               IN   INTEGER[
 [,edition                     IN   VARCHAR2 DEFAULT NULL],
   apply_crossedition_trigger  IN   VARCHAR2 DEFAULT NULL,
   fire_apply_trigger          IN   BOOLEAN DEFAULT TRUE]
 [,schema                      IN   VARCHAR2 DEFAULT NULL]
 [,container                   IN   VARCHAR2)];
DBMS_SQL.PARSE (
   c                           IN   INTEGER,
   statement                   IN   VARCHAR2s,
   lb                          IN   INTEGER,
   ub                          IN   INTEGER,
   lfflg                       IN   BOOLEAN,
   language_flag               IN   INTEGER[
 [,edition                     IN   VARCHAR2 DEFAULT NULL],
   apply_crossedition_trigger  IN   VARCHAR2 DEFAULT NULL,
   fire_apply_trigger          IN   BOOLEAN DEFAULT TRUE]
 [,schema                      IN   VARCHAR2 DEFAULT NULL]
 [,container                   IN   VARCHAR2)];
```
参数
表 170-29 PARSE 过程参数
| 参数 | 描述 |
|---|---|
| c | 要在其中解析语句的游标的 ID 编号。 |
| statement | 要解析的 SQL 语句。大于 32K 的 SQL 语句可以存储在 CLOB 中。与 PL/SQL 语句不同，SQL 语句不得包含结尾的分号。例如：DBMS_SQL.PARSE(cursor1, 'BEGIN proc; END;', 2); DBMS_SQL.PARSE(cursor1, 'INSERT INTO tab VALUES(1)', 2); |
| lb | 语句中元素的下界 |
| ub | 语句中元素的上界 |
| lfflg | 如果为 TRUE，则在拼接时在每个元素后插入一个换行符。 |
| language_flag | 指定 SQL 语句的行为。有关可能的值及其对应行为的更多信息，请参见 DBMS_SQL 常量 |
| edition | 指定在以下条件下运行语句的版本：如果为 NULL 且 container 为 NULL，语句将在当前版本中运行。如果指定了有效的 container，传入 NULL 表示语句将在目标容器的默认版本中运行。给定执行语句的用户和版本，该用户必须对该版本具有 USE 权限。以下一般条件适用。字符串的内容作为 SQL 标识符处理；如果版本的实际名称中存在特殊字符或小写字符，则字符串的其余部分必须用双引号括起来，如果不使用双引号，内容将被转换为大写。 |
| apply_crossedition_trigger | 指定要应用于指定 SQL 的正向跨版本触发器的非限定名称。该名称使用执行语句的 edition 和 current_schema 设置进行解析。该触发器必须由执行该语句的用户拥有。如果指定了非 NULL 值，则假设 fire_apply_trigger 为 TRUE、触发器已启用、触发器定义在作为语句目标的表上、语句的类型与触发器的 dml_event_clause 匹配、满足所有有效的 WHEN 和 UPDATE OF 限制等条件，则将执行指定的跨版本触发器。其他正向跨版本触发器也可能被执行，这些触发器是使用“跨版本触发器 DML 规则”选择的，应用方式如同指定的触发器正在对作为语句目标的表进行进一步的 DML 操作。非跨版本触发器和反向跨版本触发器将不会被执行。字符串的内容作为 SQL 标识符处理；如果触发器的实际名称中存在特殊字符或小写字符，则字符串的其余部分必须用双引号括起来，如果不使用双引号，内容将被转换为大写。 |
| fire_apply_trigger | 指示指定的 apply_crossedition_trigger 本身是否要被执行，或者仅作为选择其他触发器时使用的指南。当语句是对 apply_crossedition_trigger 本身要执行的操作的替换时，通常将其设置为 FALSE。如果为 FALSE，则指定的触发器不执行，但仍会选择其他触发器来触发，如同指定的触发器正在对作为语句目标的表进行 DML 操作一样。如果语句不是 DML，则忽略 apply_crossedition_trigger 和 fire_apply_trigger 参数。 |
| schema | 指定用于解析非限定对象名称的模式。如果为 NULL，则当前模式为有效用户的模式。 |
| container | 要在其中运行游标的目标容器的名称。如果为 NULL 或未指定，目标容器的名称与调用容器的名称相同，且不执行容器切换。如果指定了有效的容器名称，当前用户必须是具有 SET CONTAINER 权限的公共用户才能切换到目标容器。如果容器切换完成，有效用户将拥有其默认角色。 |
使用注意事项
- 使用 DBMS_SQL 动态运行 DDL 语句可能会导致程序停止响应。例如，调用包中的过程会导致该包被锁定，直到执行返回到用户端。任何导致冲突锁定的操作（例如在释放第一个锁定之前尝试动态删除该包）都会使程序停止运行。
````````````
``````````
- 由于客户端代码无法引用远程包变量或常量，因此必须显式使用常量的值。例如，以下代码在客户端无法编译：DBMS_SQL.PARSE(cur_hdl, stmt_str, DBMS_SQL.NATIVE); -- 使用常量 DBMS_SQL.NATIVE 以下代码在客户端有效，因为显式提供了参数：DBMS_SQL.PARSE(cur_hdl, stmt_str, 1); -- 在客户端可编译
``````
- 目前支持 VARCHAR2S 类型是为了向后兼容遗留代码。但是，建议您使用 VARCHAR2A，因为它的功能更强大，且 VARCHAR2S 将在未来的版本中被弃用。
````
- 要解析大于 32 KB 的 SQL 语句，可以使用 PARSE 过程的新的 CLOB 重载版本，而不是 VARCHAR2A 重载版本。
- 如果 container 参数值与调用容器相同，则不会发生容器切换。但是，当前用户的默认角色将生效。
异常
如果您使用 `DBMS_SQL` 创建的类型、过程、函数或包存在编译警告，则会引发 `ORA-24344` 异常，并且仍会创建该 PL/SQL 单元。

#### RETURN_RESULT 过程

此过程将已执行语句的结果返回给客户端应用程序。
结果可由客户端稍后检索。或者，它也可以将语句结果返回给执行递归语句的即时调用者，并由其稍后检索，其中该语句结果将被返回。
调用者可以是：
- 使用 DBMS_SQL 执行递归语句的 PL/SQL 存储过程
- 使用 JDBC 的 Java 存储过程
````
- 使用 ADO.NET 的 .NET 存储过程
- 使用 Oracle Call Interface (OCI) 的外部过程
语法
```
DBMS_SQL.RETURN_RESULT(
   rc           IN OUT      SYS_REFCURSOR,
   to_client    IN          BOOLEAN           DEFAULT TRUE);
DBMS_SQL.RETURN_RESULT(
   rc           IN OUT      INTEGER,
   to_client    IN          BOOLEAN           DEFAULT TRUE);
```
参数
表 170-30 RETURN_RESULT 过程参数
| Parameter | Description |
|---|---|
| rc | 语句游标或 ref cursor |
| to_client | 将语句结果返回（或不返回）给客户端。如果不返回，则将其返回给即时调用者。 |
使用说明
- 目前仅可返回 SQL 查询，且不支持通过远程过程调用返回语句结果。
- 语句一旦返回，除了返回给它的客户端或即时调用者之外，其他任何地方都无法再访问。
- 当客户端或任何中间递归语句正在执行的语句是 SQL 查询并引发错误时，无法返回语句结果。
- 被返回的 ref cursor 可以是强类型或弱类型的。
- 被返回的查询可以已被部分提取。
``````````
- 由于 EXECUTE IMMEDIATE 语句未提供接口来检索从其递归语句返回的语句结果，因此当该语句完成时，返回给 EXECUTE IMMEDIATE 语句调用者的语句结果游标将被关闭。要在 PL/SQL 中从递归语句检索返回的语句结果，请使用 DBMS_SQL 执行递归语句。
示例
```
CREATE PROCEDURE proc AS
  rc1 sys_refcursor;
  rc2 sys_refcursor;
BEGIN
  OPEN rc1 FOR SELECT * FROM t1;
  DBMS_SQL.RETURN_RESULT(rc1);
  OPEN rc2 FOR SELECT * FROM t2;
  DBMS_SQL.RETURN_RESULT(rc2);
END;
/
```

#### TO_CURSOR_NUMBER 函数

此函数接受一个已 `OPEN` 的强类型或弱类型 ref cursor，并将其转换为 `DBMS_SQL` 游标号。
语法
```
DBMS_SQL.TO_CURSOR_NUMBER(
   rc IN OUT SYS_REFCURSOR)
  RETURN INTEGER;
```
参数
Table 170-31 TO_CURSOR_NUMBER 函数参数
| Parameter | Description |
|---|---|
| rc | 要转换为游标号的 REF CURSOR |
返回值
返回从 `REF` `CURSOR` 转换而来的可由 DBMS_SQL 管理的游标号。
使用说明
``````
- 传入的 REF CURSOR 必须已 OPEN，否则会引发错误。
``````````
- 一旦 REF CURSOR 被转换为 DBMS_SQL 游标号，该 REF CURSOR 将无法再通过任何原生动态 SQL 操作进行访问。
````
- 此子程序返回的 DBMS_SQL 游标，其行为方式与已执行的 DBMS_SQL 游标相同。
示例
```
CREATE OR REPLACE PROCEDURE DO_QUERY(sql_stmt VARCHAR2) IS
  TYPE CurType IS REF CURSOR;
  src_cur         CurType;
  curid           NUMBER;
  desctab         DBMS_SQL.DESC_TAB;
  colcnt          NUMBER;
  namevar         VARCHAR2(50);
  numvar          NUMBER;
  datevar         DATE;
  empno           NUMBER := 100;
BEGIN
    -- sql_stmt := 'select ...... from employees where employee_id = :b1';
    OPEN src_cur FOR sql_stmt USING empno;
    -- Switch from native dynamic SQL to DBMS_SQL
    curid := DBMS_SQL.TO_CURSOR_NUMBER (src_cur);
    DBMS_SQL.DESCRIBE_COLUMNS(curid, colcnt, desctab);
    -- Define columns
    FOR i IN 1 .. colcnt LOOP
        IF desctab(i).col_type = 2 THEN
           DBMS_SQL.DEFINE_COLUMN(curid, i, numvar);
        ELSIF desctab(i).col_type = 12 THEN
            DBMS_SQL.DEFINE_COLUMN(curid, i, datevar);
.......
         ELSE
            DBMS_SQL.DEFINE_COLUMN(curid, i, namevar, 25);
         END IF;
    END LOOP;
  -- Fetch Rows
    WHILE DBMS_SQL.FETCH_ROWS(curid) > 0 LOOP
        FOR i IN 1 .. colcnt LOOP
          IF (desctab(i).col_type = 1) THEN
            DBMS_SQL.COLUMN_VALUE(curid, i, namevar);
         ELSIF (desctab(i).col_type = 2) THEN
            DBMS_SQL.COLUMN_VALUE(curid, i, numvar);
          ELSIF (desctab(i).col_type = 12) THEN
            DBMS_SQL.COLUMN_VALUE(curid, i, datevar);
....
          END IF;
        END LOOP;
    END LOOP;
    DBMS_SQL.CLOSE_CURSOR(curid);
END;
/
```

#### TO_REFCURSOR 函数

此函数接受一个已 `OPEN`、已 `PARSE` 且已 `EXECUTE` 的游标，并将其转换/迁移为 PL/SQL 可管理的 `REF CURSOR`（弱类型游标），供切换为使用原生动态 SQL 的 PL/SQL 使用。
此子程序仅用于 `SELECT` 游标。
语法
```
DBMS_SQL.TO_REFCURSOR(
   cursor_number IN OUT INTEGER)
  RETURN SYS_REFCURSOR;
```
参数
表 170-32 TO_REFCURSOR 函数参数
| Parameter | Description |
|---|---|
| cursor_number | 要转换为 REF CURSOR 的游标的游标编号 |
返回值
返回从 `DBMS_SQL` 游标编号转换而来的 PL/SQL `REF` `CURSOR`
使用说明
````````
- 通过 cursor_number 传入的游标必须已 OPEN、已 PARSE 且已 EXECUTEd；否则会报错。
````````
- 一旦 cursor_number 被转换为 REF CURSOR，该 cursor_number 将无法再通过任何 DBMS_SQL 操作进行访问。
````````
- 在 cursor_number 被转换为 REF CURSOR 之后，使用 DBMS_SQL.IS_OPEN 检查该 cursor_number 是否仍然处于打开状态会导致错误。
- 如果游标编号最后是使用有效的容器参数进行 PARSE 的，则无法将其转换为 REF CURSOR。
示例
```
CREATE OR REPLACE PROCEDURE DO_QUERY(mgr_id NUMBER) IS
  TYPE CurType IS REF CURSOR;
  src_cur         CurType;
  curid           NUMBER;
  sql_stmt        VARCHAR2(200);
  ret             INTEGER;
  empnos          DBMS_SQL.Number_Table;
  depts           DBMS_SQL.Number_Table;
BEGIN
  -- DBMS_SQL.OPEN_CURSOR
  curid := DBMS_SQL.OPEN_CURSOR;
  sql_stmt :=    'SELECT EMPLOYEE_ID, DEPARTMENT_ID from employees where MANAGER_ID = :b1';
  DBMS_SQL.PARSE(curid, sql_stmt, DBMS_SQL.NATIVE);
  DBMS_SQL.BIND_VARIABLE(curid, 'b1', mgr_id);
  ret := DBMS_SQL.EXECUTE(curid);
  -- Switch from DBMS_SQL to native dynamic SQL
  src_cur := DBMS_SQL.TO_REFCURSOR(curid);
  -- Fetch with native dynamic SQL
  FETCH src_cur BULK COLLECT INTO empnos, depts;
  IF empnos.COUNT > 0 THEN
    DBMS_OUTPUT.PUT_LINE('EMPNO DEPTNO');
    DBMS_OUTPUT.PUT_LINE('----- ------');
    -- Loop through the empnos and depts collections
    FOR i IN 1 .. empnos.COUNT LOOP
      DBMS_OUTPUT.PUT_LINE(empnos(i) || '   ' || depts(i));
    END LOOP;
  END IF;
   -- Close cursor
  CLOSE src_cur;
END;
/
```

#### VARIABLE_VALUE 过程

此过程返回给定游标的指定变量值。它用于返回 PL/SQL 块或带有 `returning` 子句的 DML 语句内部绑定变量的值。
语法
```
DBMS_SQL.VARIABLE_VALUE (
   c               IN  INTEGER,
   name            IN  VARCHAR2,
   value           OUT NOCOPY <datatype>);
```
其中 <datatype> 可以是以下任意一种类型：
```
ADT (user-defined object types)
BINARY_DOUBLE
BINARY_FLOAT
BFILE
BLOB
BOOLEAN
CLOB CHARACTER SET ANY_CS
DATE
DSINTERVAL_UNCONSTRAINED
NESTED table
NUMBER
OPAQUE types
REF
TIME_UNCONSTRAINED
TIME_TZ_UNCONSTRAINED
TIMESTAMP_LTZ_UNCONSTRAINED
TIMESTAMP_TZ_UNCONSTRAINED
TIMESTAMP_UNCONSTRAINED
UROWID
VARCHAR2 CHARACTER SET ANY_CS
VARRAY
YMINTERVAL_UNCONSTRAINED
```
对于包含 `CHAR`、`RAW` 和 `ROWID` 数据的变量，您可以使用以下语法变体：
```
DBMS_SQL.VARIABLE_VALUE_CHAR (
   c               IN  INTEGER,
   name            IN  VARCHAR2,
   value           OUT CHAR CHARACTER SET ANY_CS);
DBMS_SQL.VARIABLE_VALUE_RAW (
   c               IN  INTEGER,
   name            IN  VARCHAR2,
   value           OUT RAW);
DBMS_SQL.VARIABLE_VALUE_ROWID (
   c               IN  INTEGER,
   name            IN  VARCHAR2,
   value           OUT ROWID);
```
以下语法使 `VARIABLE_VALUE` 过程能够支持批量操作：
```
DBMS_SQL.VARIABLE_VALUE (
   c                 IN   INTEGER,
   name              IN   VARCHAR2,
   value             OUT NOCOPY <table_type>);
```
对于批量操作，<`table_type`> 必须是受支持的 DBMS_SQL 预定义 TABLE 类型。
参见 DBMS_SQL 数据结构
Pragmas
```
pragma restrict_references(variable_value,RNDS,WNDS);
```
参数
表 170-33 VARIABLE_VALUE 过程参数
| Parameter | Description |
|---|---|
| c | 要从中获取值的游标 ID 号。 |
| name | 要检索其值的变量名。 |
| value | 单行选项：返回指定位置处的变量值。如果此输出参数的类型与实际值的类型（由调用 BIND_VARIABLE 定义）不一致，Oracle 将引发异常 ORA-06562, inconsistent_type。数组选项：已声明为 <table_type> 的局部变量。对于批量操作，value 是一个 OUT NOCOPY 参数。 |

#### VARIABLE_VALUE_PKG 过程

此过程返回给定游标的命名变量的值。
它用于返回已声明包的 PL/SQL 块或带有 `returning` 子句的 DML 语句中集合或记录类型的绑定变量的值。变量的类型必须在包规范中声明。这些类型不支持批量操作。
语法
```
DBMS_SQL.VARIABLE_VALUE_PKG (
   c                 IN   INTEGER,
   name              IN   VARCHAR2,
   value             OUT NOCOPY <table_type>);
```
其中 <datatype> 可以是以下任意一种数据类型：
- RECORD
- VARRAY
- NESTED TABLE
- INDEX BY PLS_INTEGER TABLE
- INDEX BY BINARY_INTEGER TABLE
参数
表 170-34 VARIABLE_VALUE_PKG 参数
| 参数 | 描述 |
|---|---|
| c | 要从中获取值的游标的 ID 号。 |
| name | 要检索其值的变量的名称。 |
| value | 单行选项：返回指定位置的变量值。如果此输出参数的类型与实际值的类型（由调用 BIND_VARIABLE_PKG 定义）不同，Oracle 会引发异常 ORA-06562, inconsistent_type。数组选项：已声明为 <table_type> 的局部变量。 |
示例 170-5 使用 DBMS_SQL.VARIABLE_VALUE_PKG 获取绑定变量值的动态 SQL
数据类型在包规范中声明。`VARIABLE_VALUE_PKG` 用于获取游标 SQL 语句中绑定变量 v2 的值。
```
CREATE OR REPLACE PACKAGE ty_pkg AS
TYPE rec IS RECORD
   ( n1 NUMBER,
    n2 NUMBER);
TYPE trect IS TABLE OF NUMBER;
END ty_pkg;
/
CREATE OR REPLACE PROCEDURE dyn_sql_nt  AS
  dummy NUMBER;
  cur   NUMBER;
  v1 ty_pkg.trect;
  v2 ty_pkg.trect;
  str VARCHAR2(3000);
BEGIN
  v1 := ty_pkg.trect(1000);
  str := 'declare v1 ty_pkg.trect;  begin v1:=:v1;  v1(1) := 2000; :v2 := v1; end;' ;
  cur := DBMS_SQL.OPEN_CURSOR();
  DBMS_SQL.PARSE(cur, str, DBMS_SQL.NATIVE);
  DBMS_SQL.BIND_VARIABLE_PKG(cur, ':v1', v1);
  DBMS_SQL.BIND_VARIABLE_PKG(cur, ':v2', v2);
  dummy := DBMS_SQL.EXECUTE(cur);
  DBMS_SQL.VARIABLE_VALUE_PKG(cur, ':v2', v2);
  DBMS_OUTPUT.PUT_LINE('n =  '
  || V2(1));
  DBMS_SQL.CLOSE_CURSOR(cur);
END dyn_sql_nt;
/
EXEC dyn_sql_nt;
n =  2000
```
