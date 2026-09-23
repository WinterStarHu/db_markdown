# XML

XML 处理（对应 GaussDB DBE_XMLDOM、DBE_XMLPARSER、DBE_XMLGEN、DBE_XML）。

---

## DBMS_XMLDOM

**包用途**：访问 XMLType 对象，实现 DOM（文档对象模型）API，用于 HTML/XML 文档。可访问、修改、删除、添加文档节点；支持 schema 与非 schema 文档。文件读写须在服务器文件系统。

**接口清单（全部）**：

| Subprogram | 说明 |
|---|---|
| ADOPTNODE | 从另一文档收养节点 |
| APPENDCHILD | 向节点追加新子节点 |
| APPENDDATA | 向节点数据追加指定数据 |
| CLONENODE | 克隆节点 |
| CREATEATTRIBUTE | 创建属性 |
| CREATECDATASECTION | 创建 CDataSection 节点 |
| CREATECOMMENT | 创建注释节点 |
| CREATEDOCUMENT | 创建新文档 |
| CREATEDOCUMENTFRAGMENT | 创建新文档片段 |
| CREATEELEMENT | 创建新元素 |
| CREATEENTITYREFERENCE | 创建实体引用 |
| CREATEPROCESSINGINSTRUCTION | 创建处理指令 |
| CREATETEXTNODE | 创建文本节点 |
| DELETEDATA | 从指定偏移删除数据 |
| FINDENTITY | 在文档类型中查找指定实体 |
| FINDNOTATION | 在文档类型中查找指定记法 |
| FREEDOCFRAG | 释放文档片段 |
| FREEDOCUMENT | 释放文档 |
| FREEELEMENT | 释放 DOMElement 句柄内存 |
| FREENODE | 释放节点关联的所有资源 |
| FREENODELIST | 释放节点列表关联的所有资源 |
| GETATTRIBUTE | 按名取属性节点 |
| GETATTRIBUTENODE | 按名取属性节点 |
| GETATTRIBUTES | 取节点属性 |
| GETCHARSET | 取 DOM 文档字符集 |
| GETCHILDNODES | 取节点子节点 |
| GETCHILDRENBYTAGNAME | 按标签名取元素子节点 |
| GETDATA | 取节点数据/处理指令数据 |
| GETDOCTYPE | 取文档 DTD |
| GETDOCUMENTELEMENT | 取文档根元素 |
| GETELEMENTSBYTAGNAME | 按标签名取节点列表/子树元素 |
| GETENTITIES | 取文档类型中的实体节点映射 |
| GETEXPANDEDNAME | 取节点/属性/元素的展开名 |
| GETFIRSTCHILD | 取节点第一个子节点 |
| GETIMPLEMENTATION | 取 DOM 实现 |
| GETLASTCHILD | 取节点最后一个子节点 |
| GETLENGTH | 取数据长度/映射项数/列表项数 |
| GETLOCALNAME | 取限定名的本地部分/属性本地名/元素本地名 |
| GETNAME | 取属性名/文档类型名 |
| GETNAMEDITEM | 按名与命名空间 URI 取项 |
| GETNAMESPACE | 取节点/属性/元素的命名空间 URI |
| GETNEXTSIBLING | 取节点下一个兄弟 |
| GETNODENAME | 取节点名 |
| GETNODETYPE | 取节点类型 |
| GETNODEVALUE | 取节点值 |
| GETNODEVALUEASBINARYSTREAM | 以二进制流取节点值 |
| GETNODEVALUEASCHARACTERSTREAM | 以字符流取节点值 |
| GETNOTATIONNAME | 取实体记法名 |
| GETNOTATIONS | 取文档类型中的记法节点映射 |
| GETTARGET | 取处理指令目标 |
| GETOWNERDOCUMENT | 取节点所属文档 |
| GETOWNERELEMENT | 取属性的父元素节点 |
| GETPARENTNODE | 取节点父节点 |
| GETPREFIX | 取命名空间前缀 |
| GETPREVIOUSSIBLING | 取节点上一个兄弟 |
| GETPUBLICID | 取文档类型/实体/记法的 public ID |
| GETQUALIFIEDNAME | 取属性/元素的限定名 |
| GETSCHEMANODE | 取关联的 schema URI |
| GETSPECIFIED | 测试元素中是否指定了该属性 |
| GETSTANDALONE | 取文档 standalone 属性 |
| GETSYSTEMID | 取文档类型/实体/记法的 system ID |
| GETTAGNAME | 取元素标签名 |
| GETVALUE | 取属性值 |
| GETVERSION | 取文档版本 |
| GETXMLTYPE | 取与 DOM 文档关联的 XMLType |
| HASATTRIBUTES | 测试节点是否有属性 |
| HASATTRIBUTE | 测试属性是否存在 |
| HASCHILDNODES | 测试节点是否有子节点 |
| HASFEATURE | 测试 DOMImplementation 是否实现某特性 |
| IMPORTNODE | 从另一文档导入节点 |
| INSERTBEFORE | 在参照子节点前插入子节点 |
| INSERTDATA | 在节点指定偏移插入数据 |
| ISNULL | 测试节点/各类型节点是否为 NULL |
| ITEM | 按索引取映射/列表中的项 |
| MAKEATTR | 将节点转为属性 |
| MAKECDATASECTION | 将节点转为 CData Section |
| MAKECHARACTERDATA | 将节点转为 CharacterData |
| MAKECOMMENT | 将节点转为注释 |
| MAKEDOCUMENT | 将节点转为 DOM 文档 |
| MAKEDOCUMENTFRAGMENT | 将节点转为文档片段 |
| MAKEDOCUMENTTYPE | 将节点转为文档类型 |
| MAKEELEMENT | 将节点转为元素 |
| MAKEENTITY | 将节点转为实体 |
| MAKEENTITYREFERENCE | 将节点转为实体引用 |
| MAKENODE | 将各类型节点转为通用节点 |
| MAKENOTATION | 将节点转为记法 |
| MAKEPROCESSINGINSTRUCTION | 将节点转为处理指令 |
| MAKETEXT | 将节点转为文本 |
| NEWDOMDOCUMENT | 创建新文档 |
| NORMALIZE | 规范化元素的文本子节点 |
| REMOVEATTRIBUTE | 按名移除属性 |
| REMOVEATTRIBUTENODE | 移除元素中的属性节点 |
| REMOVECHILD | 从节点移除指定子节点 |
| REMOVENAMEDITEM | 按名移除项 |
| REPLACECHILD | 用新子节点替换旧子节点 |
| REPLACEDATA | 替换节点中一段字符 |
| RESOLVENAMESPACEPREFIX | 将前缀解析为命名空间 URI |
| SETATTRIBUTE | 按名设置属性 |
| SETATTRIBUTENODE | 在元素中设置属性节点 |
| SETCHARSET | 设置 DOM 文档字符集 |
| SETDATA | 设置节点数据/处理指令数据 |
| SETDOCTYPE | 设置文档 DTD |
| SETNAMEDITEM | 按名在映射中设置项 |
| SETNODEVALUE | 设置节点值 |
| SETNODEVALUEASBINARYSTREAM | 以二进制流设置节点值 |
| SETNODEVALUEASCHARACTERSTREAM | 以字符流设置节点值 |
| SETPREFIX | 设置命名空间前缀 |
| SETSTANDALONE | 设置文档 standalone 属性 |
| SETVALUE | 设置属性值 |
| SETVERSION | 设置文档版本 |
| SPLITTEXT | 将文本节点内容拆为两个文本节点 |
| SUBSTRINGDATA | 取数据子串 |
| USEBINARYSTREAM | 标记该流可用于使用 |
| WRITETOBUFFER | 将节点/文档/文档片段内容写入缓冲区 |
| WRITETOCLOB | 将节点/文档内容写入 CLOB |
| WRITETOFILE | 将节点/文档内容写入文件 |

---

## DBMS_XMLGEN

**包用途**：将 SQL 查询结果转为规范 XML 格式，以 CLOB 返回；用 C 编写编译进内核。

| Subprogram | 说明 |
|---|---|
| CLOSECONTEXT | 关闭上下文并释放所有资源 |
| CONVERT | 将 XML 转为转义/非转义等价形式 |
| GETNUMROWSPROCESSED | 获取上次 GETXML 调用处理的 SQL 行数 |
| GETXML | 获取 XML 文档 |
| GETXMLTYPE | 获取 XML 文档并以 XMLType 返回 |
| NEWCONTEXT | 创建新上下文句柄 |
| NEWCONTEXTFROMHIERARCHY | 获取用于生成带递归元素层级 XML 的句柄 |
| RESTARTQUERY | 重启查询从头取 |
| SETCONVERTSPECIALCHARS | 设置是否将 $ 等非 XML 特殊字符转义 |
| SETMAXROWS | 设置每次取的最大行数 |
| SETNULLHANDLING | 设置 NULL 处理选项 |
| SETROWSETTAG | 设置包络整个结果的元素名 |
| SETROWTAG | 设置包络每行的元素名 |
| SETSKIPROWS | 设置每次生成 XML 前跳过的行数 |
| USEITEMTAGSFORCOLL | 强制集合元素用集合列名加 _ITEM 标签 |
| USENULLATTRIBUTEINDICATOR | 指定用 XML 属性指示 NULL 还是通过省略实体 |

---

## DBMS_XMLPARSER

**包用途**：XML 解析器，将 XML 文档解析为 DOM 树以便访问与修改。（本版本未抽取到独立接口清单表，详见英文原版 `O/en/arpls/DBMS_XMLPARSER.html`。）

## DBMS_XML

**包用途**：XML 相关基础功能。（本版本未抽取到独立概述/清单，详见英文原版。）


---

## DBMS_XMLGEN 详细（机译）

## DBMS_XMLGEN
`DBMS_XMLGEN` 包将 SQL 查询的结果转换为规范的 XML 格式。
该包接受任意 SQL 查询作为输入，将其转换为 XML 格式，并以 `CLOB` 形式返回结果。该包类似于 `DBMS_XMLQUERY` 包，不同之处在于它是用 C 编写并编译到内核中的。该包只能在数据库上运行。
本章包含以下主题：
- 安全模型
- DBMS_XMLGEN 子程序摘要
另请参阅：
Oracle XML DB Developer's Guide，了解有关 XML 支持以及使用 `DBMS_XMLGEN` 示例的更多信息
### DBMS_XMLGEN 安全模型
`DBMS_XMLGEN` 包由 `XDB` 拥有，必须由 `SYS` 或 `XDB` 创建。`EXECUTE` 权限被授予 `PUBLIC`。此包中的子程序使用当前用户的权限执行。
### DBMS_XMLGEN 子程序摘要
此表列出了 DBMS_XMLGEN 子程序并对其进行了简要描述。
表 214-1 DBMS_XMLGEN 包子程序摘要
| 子程序 | 描述 |
|---|---|
| CLOSECONTEXT Procedure | 关闭上下文并释放所有资源 |
| CONVERT Functions | 将 XML 转换为等效的转义或非转义 XML |
| GETNUMROWSPROCESSED Function | 获取上次调用 GETXML Functions 时处理的 SQL 行数 |
| GETXML Functions | 获取 XML 文档 |
| GETXMLTYPE Functions | 获取 XML 文档并以 XMLType 形式返回 |
| NEWCONTEXT Functions | 创建新的上下文句柄 |
| NEWCONTEXTFROMHIERARCHY Function | 获取一个句柄，用于 GETXML Functions 和其他函数，以从结果中获取带有递归元素的分层 XML |
| RESTARTQUERY Procedure | 重新启动查询，从头开始获取数据 |
| SETCONVERTSPECIALCHARS Procedure | 设置是否将诸如 $ 等 XML 字符转换为它们的转义表示形式 |
| SETMAXROWS Procedure | 设置每次获取的最大行数 |
| SETNULLHANDLING Procedure | 设置 NULL 处理选项 |
| SETROWSETTAG Procedure | 设置包围整个结果的元素名称 |
| SETROWTAG Procedure | 设置包围结果中每一行的元素名称 |
| SETSKIPROWS Procedure | 设置每次生成 XML 前要跳过的行数 |
| USEITEMTAGSFORCOLL Procedure | 强制对集合元素使用追加有 _ITEM 标记的集合列名 |
| USENULLATTRIBUTEINDICATOR Procedure | 指定是使用 XML 属性来指示 NULL 值，还是通过在 XML 文档中省略包含特定实体来实现 |

#### CLOSECONTEXT 过程

此过程关闭给定的上下文，并释放与之关联的所有资源，包括 SQL 游标以及绑定和定义缓冲区。在此调用之后，该句柄无法用于后续的函数调用。
语法
```
DBMS_XMLGEN.CLOSECONTEXT (
   ctx  IN ctxHandle);
```
参数
表 214-2 CLOSECONTEXT 过程参数
| Parameter | Description |
|---|---|
| ctx | The context handle to close. |

#### CONVERT Functions

此函数将 XML 数据转换为转义或反转义形式的等效 XML，并以编码或解码格式返回 XML `CLOB` 数据。该函数有多个版本。
语法
使用字符串（`VARCHAR2`）形式的 `XMLDATA`：
```
DBMS_XMLGEN.CONVERT (
   xmlData IN VARCHAR2,
   flag    IN NUMBER := ENTITY_ENCODE)
RETURN VARCHAR2;
```
使用 `CLOB` 形式的 `XMLDATA`：
```
DBMS_XMLGEN.CONVERT (
   xmlData IN CLOB,
   flag    IN NUMBER := ENTITY_ENCODE)
 RETURN CLOB;
```
参数
Table 214-3 CONVERT Function Parameters
| Parameter | Description |
|---|---|
| xmlData | 要编码或解码的 XML CLOB 数据。 |
| flag | 标志设置；ENTITY_ENCODE（默认）用于编码，ENTITY_DECODE 用于解码。 |
使用注意事项
如果指定了 `ENTITY_ENCODE`，此函数将对 XML 数据进行转义。例如，字符 `<` 的转义形式为 `&lt;`。反转义则是相反的转换过程。

#### GETNUMROWSPROCESSED 函数

此函数检索使用 GETXML 函数调用生成 XML 时处理的 SQL 行数。此计数不包含在生成 XML 之前跳过的行数。
请注意，即使不存在任何行，GETXML 函数也始终会生成一个 XML 文档。
语法
```
DBMS_XMLGEN.GETNUMROWSPROCESSED (
   ctx     IN    ctxHandle)
RETURN NUMBER;
```
参数
表 214-4 GETNUMROWSPROCESSED 函数参数
| 参数 | 描述 |
|---|---|
| ctx | 从 NEWCONTEXT 函数调用获取的上下文句柄。 |
使用说明
如果在循环中调用 GETXML 函数，此函数用于确定终止条件。
**相关主题**
                           - GETXML 函数

#### GETXML 函数

此函数获取 XML 文档。该函数是重载的。
语法
通过获取指定的最大行数来获取 XML 文档。它将 XML 文档追加到传入的 `CLOB` 中。使用此版本的 GETXML 函数可以避免任何额外的 `CLOB` 拷贝，并为后续调用重用同一个 `CLOB`。由于 `CLOB` 的重用，此 GETXML 函数调用可能更高效：
```
DBMS_XMLGEN.GETXML (
   ctx          IN ctxHandle,
   tmpclob      IN OUT NCOPY CLOB,
   dtdOrSchema  IN number := NONE)
 RETURN BOOLEAN;
```
生成 XML 文档并将其作为临时 `CLOB` 返回。从此函数获取的临时 `CLOB` 必须使用 `DBMS_LOB.FREETEMPORARY` 调用来释放：
```
DBMS_XMLGEN.GETXML (
   ctx          IN ctxHandle,
   dtdOrSchema  IN number := NONE)
 RETURN CLOB;
```
将 SQL 查询字符串的结果转换为 XML 格式，并将 XML 作为临时 `CLOB` 返回，该 `CLOB` 随后必须使用 `DBMS_LOB.FREETEMPORARY` 调用来释放：
```
DBMS_XMLGEN.GETXML (
   sqlQuery     IN VARCHAR2,
   dtdOrSchema  IN number := NONE)
 RETURN CLOB;
```
参数
表 214-5 GETXML 函数参数
| Parameter | Description |
|---|---|
| ctx | 从 newContext 调用获取的上下文句柄。 |
| tmpclob | XML 文档要追加到的 CLOB。 |
| sqlQuery | SQL 查询字符串。 |
| dtdOrSchema | 生成 DTD 还是 schema？仅支持 NONE。 |
使用说明
当跳过由 SETSKIPROWS 过程调用指示的行时，将获取由 SETMAXROWS 过程调用指定的最大行数（或未指定时的整个结果集）并转换为 XML。使用 GETNUMROWSPROCESSED 函数可检查是否检索到了任何行。

#### GETXMLTYPE 函数

此函数获取 XML 文档并将其作为 `XMLTYPE` 返回。可以对结果执行 `XMLTYPE` 操作。此函数为重载函数。
语法
生成 XML 文档并将其作为 `sys.XMLType` 返回：
```
DBMS_XMLGEN.GETXMLTYPE (
   ctx           IN ctxhandle,
   dtdOrSchema   IN number := NONE)
 RETURN sys.XMLType;
```
将 SQL 查询字符串的结果转换为 XML 格式，并将 XML 作为 `sys.XMLType` 返回：
```
DBMS_XMLGEN.GETXMLTYPE (
   sqlQuery     IN VARCHAR2,
   dtdOrSchema  IN number := NONE)
 RETURN sys.XMLType
```
参数
表 214-6 GETXMLTYPE 函数参数
| 参数 | 描述 |
|---|---|
| ctx | 从 newContext 调用获取的上下文句柄。 |
| sqlQuery | SQL 查询字符串。 |
| dtdOrSchema | 生成 DTD 或 schema？仅支持 NONE。 |

#### NEWCONTEXT 函数

此函数生成并返回一个新的上下文句柄。
此上下文句柄用于 GETXML 函数和其他函数，以便从结果中获取 XML。该函数有多个版本。

语法

根据查询生成新的上下文句柄：
```
DBMS_XMLGEN.NEWCONTEXT (
      query     IN VARCHAR2)
 RETURN ctxHandle;
```

根据 PL/SQL ref cursor 形式的查询字符串生成新的上下文句柄：
```
DBMS_XMLGEN.NEWCONTEXT (
   queryString  IN SYS_REFCURSOR)
 RETURN ctxHandle;
```

参数

表 214-7 NEWCONTEXT 函数参数

| 参数 | 描述 |
|---|---|
| query | 采用 VARCHAR 形式的查询，其结果必须转换为 XML。 |
| queryString | 采用 PL/SQL ref cursor 形式的查询字符串，其结果必须转换为 XML。 |

#### NEWCONTEXTFROMHIERARCHY 函数

此函数获取一个句柄，用于在 GETXML 函数及其他函数中使用，以便从结果中获取带有递归元素的层次化 XML。

语法
```
DBMS_XMLGEN.NEWCONTEXTFROMHIERARCHY (
   queryString IN VARCHAR2)
 RETURN ctxHandle;
```

参数
表 214-8 NEWCONTEXTFROMHIERARCHY 函数参数
| Parameter | Description |
|---|---|
| queryString | 查询字符串，其结果必须转换为 XML。该查询是一个层次化查询，通常使用 CONNECT BY 子句构成，并且结果必须具有与由 CONNECT BY 查询生成的结果集相同的属性。结果集必须只有两列，即层次号和 XML 值。层次号用于确定 XML 值在结果 XML 文档中的层次位置。 |

**相关主题**
                           - GETXML 函数

#### RESTARTQUERY 过程

此过程重新启动查询并从第一行生成 XML。
它可用于再次开始执行查询，而无需创建新的上下文。
语法
```
DBMS_XMLGEN.RESTARTQUERY (
ctx  IN ctxHandle);
```
参数
表 214-9 RESTARTQUERY 过程参数
| Parameter | Description |
|---|---|
| ctx | 与当前查询对应的上下文句柄。 |

#### SETCONVERTSPECIALCHARS 过程

此过程设置是否必须将 XML 数据中的特殊字符转换为其转义后的 XML 等效形式。例如，将 `<` 符号转换为 `&lt;`。
默认执行转换。
当输入数据不包含任何必须转义的特殊字符（如 `<`、`>`, `",'`）时，此函数可提高 XML 处理的性能。扫描字符数据以替换特殊字符的开销很大，尤其是在涉及大量数据时。
语法
```
DBMS_XMLGEN.SETCONVERTSPECIALCHARS (
ctx   IN ctxHandle,
conv  IN BOOLEAN);
```
参数
表 214-10 SETCONVERTSPECIALCHARS 过程参数
| Parameter | Description |
|---|---|
| ctx | 从某个 NEWCONTEXT 函数调用获取的上下文句柄。 |
| conv | TRUE 表示需要转换。 |

#### SETMAXROWS Procedure

此过程设置每次调用 GETXML Functions 时，从 SQL 查询结果中提取的最大行数。
它在生成分页结果时使用。例如，在生成一页 XML 或 HTML 数据时，可以通过设置 `maxrows` 参数来限制转换为 XML 或 HTML 的行数。
语法
```
DBMS_XMLGEN.SETMAXROWS (
ctx      IN ctxHandle,
maxRows  IN NUMBER);
```
参数
Table 214-11 SETMAXROWS Procedure Parameters
| Parameter | Description |
|---|---|
| ctx | 与所执行的查询对应的上下文句柄。 |
| maxRows | 每次调用 GETXML Functions 时要获取的最大行数。 |
**相关主题**
                           - GETXML Functions

#### SETNULLHANDLING 过程

此过程设置 `NULL` 处理选项，通过 `flag` 参数设置来处理。
语法
```
DBMS_XMLGEN.SETNULLHANDLING(
ctx  IN ctx,
flag IN NUMBER);
```
参数
表 214-12 SETNULLHANDLING 过程参数
| Parameter | Description |
|---|---|
| ctx | 与所执行查询对应的上下文句柄。 |
| flag | 设置的 NULL 处理选项。 DROP_NULLS CONSTANT NUMBER:= 0;（默认）省略 NULL 元素的标签。 NULL_ATTR CONSTANT NUMBER:= 1; 设置 xsi:nil="true"。 EMPTY_TAG CONSTANT NUMBER:= 2; 例如，设置为 <foo/>。 |

#### SETROWSETTAG 过程

此过程设置文档根元素的名称。默认名称为 `ROWSET。`
语法
```
DBMS_XMLGEN.SETROWSETTAG (
ctx            IN ctxHandle,
rowSetTagName  IN VARCHAR2);
```
参数
表 214-13 SETROWSETTAG 过程参数
| Parameter | Description |
|---|---|
| ctx | 从 NEWCONTEXT 函数调用获取的上下文句柄。 |
| rowSetTagName | 文档元素的名称。传入 NULL 表示不希望出现 ROWSET 元素。 |
使用说明

用户可以将 `rowSetTag` 设置为 `NULL` 以禁止打印此元素。但是，如果行和行集均为 `NULL` 且输出中有多列或多行，则会产生错误。这是因为生成的 XML 将没有顶层包围标签，因此是无效的。

#### SETROWTAG 过程

此过程设置分隔所有行的元素名称。默认名称为 `ROW.`
语法
```
DBMS_XMLGEN.SETROWTAG (
ctx         IN ctxHandle,
rowTagName  IN VARCHAR2);
```
参数
Table 214-14 SETROWTAG 过程参数
| Parameter | Description |
|---|---|
| ctx | 从 NEWCONTEXT 函数调用获取的上下文句柄。 |
| rowTagName | ROW 元素的名称。传入 NULL 表示不希望存在 ROW 元素。 |
使用说明
用户可以将元素名称设置为 `NULL` 以取消 `ROW` 元素本身。但是，如果 row 和 rowset 均为 `NULL` 且输出中有多个列或行，则会产生错误。这是因为生成的 XML 将没有顶层封闭标签，因此将是无效的。

#### SETSKIPROWS Procedure

此过程在每次调用 GETXML Functions 生成 XML 输出之前，跳过指定数量的行。当使用此工具为无状态网页生成分页结果时，会用到此过程。
例如，在生成第一页 XML 或 HTML 数据时，将 `skiprows` 设置为零。若要获取下一组数据，则将 `skipRows` 设置为第一次获取到的行数。参见 GETNUMROWSPROCESSED Function。
语法
```
DBMS_XMLGEN.SETSKIPROWS (
ctx       IN ctxHandle,
skipRows  IN NUMBER);
```
参数
表 214-15 SETSKIPROWS Procedure 参数
| Parameter | Description |
|---|---|
| ctx | 与所执行的查询对应的上下文句柄。 |
| skipRows | 每次调用 getXML 时要跳过的行数。 |
**相关主题**
                           - GETXML Functions

#### USEITEMTAGSFORCOLL 过程

此过程覆盖集合元素的默认名称。集合元素的默认名称为类型名称本身。
语法
```
DBMS_XMLGEN.USEITEMTAGSFORCOLL (
   ctx  IN ctxHandle);
```
参数
Table 214-16 USEITEMTAGSFORCOLL Procedure Parameters
| Parameter | Description |
|---|---|
| ctx | 上下文句柄。 |
使用说明
使用此过程，您可以覆盖默认设置，改为使用附加了 `_ITEM` 标签的列名。如果存在 `NUMBER` 的集合，则集合元素的默认标签名为 `NUMBER`。

#### USENULLATTRIBUTEINDICATOR 过程

此过程指定是否使用 XML 属性来指示 `NULL`，或者通过在 XML 文档中省略包含特定实体来实现。
它用作 SETNULLHANDLING 过程的快捷方式`.`
语法
```
DBMS_XMLGEN.USENULLATTRIBUTEINDICATOR(
ctx       IN   ctxType,
attrind   IN   BOOLEAN := TRUE);
```
参数
表 214-17 USENULLATTRIBUTEINDICATOR 过程参数
| Parameter | Description |
|---|---|
| ctx | 上下文句柄。 |
| attrind | 是否使用属性来指示 NULL？ |


---

## DBMS_XMLDOM 详细（机译）

## DBMS_XMLDOM
`DBMS_XMLDOM` 包用于访问 `XMLType` 对象，并实现了文档对象模型（DOM），这是一种用于 HTML 和 XML 文档的应用程序编程接口。
本章包含以下主题：
- 概览
- 安全模型
- 常量
- 类型
- 异常
- 子程序组
- 子程序组
- DBMS_XMLDOM 子程序概览
另请参见：
Oracle XML Developer's Kit Programmer's Guide
### DBMS_XMLDOM 概览
文档对象模型（DOM）是一种用于 HTML 和 XML 文档的应用程序编程接口（API）。它定义了文档的逻辑结构，以及访问和操作文档的方式。
在 DOM 规范中，“文档”一词是在广义上使用的。XML 越来越多地被用来表示可能存储在各种系统中的许多不同类型的信息。这些信息在传统上被视为“数据”；然而，XML 将这些数据呈现为文档，`DBMS_XMLDOM` 包允许您访问基于模式和非基于模式的文档。
注意：
读取和写入的文件必须位于服务器文件系统上。
使用 DOM，可以通过文档对象模型访问、更改、删除或添加 HTML 或 XML 文档中的任何内容，但有少数例外。特别是，XML 内部和外部子集的 DOM 接口尚未指定。
W3C DOM 规范的一个重要目标是提供一种标准的编程接口，可用于各种环境、编程语言和应用程序。由于 DOM 标准是面向对象的，而 PL/SQL 本质上是一种过程语言，因此必须进行一些更改：
````````
- 各种 DOM 接口（如 Node、Element 等）分别有等效的 PL/SQL 类型 DOMNode、DOMElement。
``````
- 各种 DOMException 代码（如 WRONG_DOCUMENT_ERR、HIERARCHY_REQUEST_ERR 等）具有相似命名的 PL/SQL 异常。
````
- 各种 DOM Node 类型代码（如 ELEMENT_NODE、ATTRIBUTE_NODE 等）具有相似命名的 PL/SQL 常量。
````
- 在 DOM 类型上定义的子程序成为接受它作为参数的函数或过程。例如，要在 DOMNode n 上执行 APPENDCHILD Function，提供了 APPENDCHILD FunctionPL/SQL 函数。
````
- 要在 DOMElement elemSETATTRIBUTE Procedures 上执行 setAttribute，请使用 PL/SQL 过程。
DOM 定义了继承层次结构。例如，`Document`、`Element` 和 `Attr` 被定义为 `Node` 的子类型（见图 213-1）。因此，在 `Node` 接口中定义的方法也应该在这些接口中可用。由于 PL/SQL 不支持这种继承，因此它是通过直接调用 `MAKENODE` 函数来实现的。在各种 DOM 类型上调用 `MAKENODE` 会将这些类型转换为 `DOMNode`。然后可以调用接受 `DOMNode` 的适当函数或过程来操作这些类型。如果随后需要特定于类型的功能，可以通过 `makeXXX` 函数将 `DOMNode` 转换回原始类型，其中 `DOMXXX` 是所需的 DOM 类型。
图 213-1 DOM 类型的继承图
“图 213-1 DOM 类型的继承图”的描述
此接口的实现遵循 REC-DOM-Level-1-19981001。
### DBMS_XMLDOM 安全模型
`DBMS_XMLDOM` 包归 `XDB` 所有，必须由 `SYS` 或 `XDB` 创建。`EXECUTE` 权限被授予 `PUBLIC`。
此包中的子程序使用当前用户的权限执行。
### DBMS_XMLDOM 常量
`DBMS_XMLDOM` 包定义了几个常量，可用于指定参数值。
这些常量在下表中列出。
表 213-1 DBMS_XMLDOM 的已定义常量
| Constant | Type | Value | Description |
|---|---|---|---|
| ELEMENT_NODE | PLS_INTEGER | 1 | 该节点是一个元素。 |
| ATTRIBUTE_NODE | PLS_INTEGER | 2 | 该节点是一个属性。 |
| TEXT_NODE | PLS_INTEGER | 3 | 该节点是一个文本节点。 |
| CDATA_SECTION_NODE | PLS_INTEGER | 4 | 该节点是一个 CDataSection。 |
| ENTITY_REFERENCE_NODE | PLS_INTEGER | 5 | 该节点是一个实体引用。 |
| ENTITY_NODE | PLS_INTEGER | 6 | 该节点是一个实体。 |
| PROCESSING_INSTRUCTION_NODE | PLS_INTEGER | 7 | 该节点是一个处理指令。 |
| COMMENT_NODE | PLS_INTEGER | 8 | 该节点是一个注释。 |
| DOCUMENT_NODE | PLS_INTEGER | 9 | 该节点是一个文档。 |
| DOCUMENT_TYPE_NODE | PLS_INTEGER | 10 | 该节点是一个文档类型定义。 |
| DOCUMENT_FRAGMENT_NODE | PLS_INTEGER | 11 | 该节点是一个文档片段。 |
| NOTATION_NODE | PLS_INTEGER | 12 | 该节点是一个符号。 |
### DBMS_XMLDOM 类型
此表列出并简要描述了 `DBMS_XMLDOM.DOMTYPE` 包的类型。
表 213-2 XDB_XMLDOM 类型
| Type | Description |
|---|---|
| DOMATTR | 实现 DOM Attribute 接口。 |
| DOMCDATASECTION | 实现 DOM CDataSection 接口。 |
| DOMCHARACTERDATA | 实现 DOM Character Data 接口。 |
| DOMCOMMENT | 实现 DOM Comment 接口。 |
| DOMDOCUMENT | 实现 DOM Document 接口。 |
| DOMDOCUMENTFRAGMENT | 实现 DOM DocumentFragment 接口。 |
| DOMDOCUMENTTYPE | 实现 DOM Document Type 接口。 |
| DOMELEMENT | 实现 DOM Element 接口。 |
| DOMENTITY | 实现 DOM Entity 接口。 |
| DOMENTITYREFERENCE | 实现 DOM EntityReference 接口。 |
| DOMIMPLEMENTATION | 实现 DOM Implementation 接口。 |
| DOMNAMEDNODEMAP | 实现 DOM Named Node Map 接口。 |
| DOMNODE | 实现 DOM Node 接口。 |
| DOMNODELIST | 实现 DOM NodeList 接口。 |
| DOMNOTATION | 实现 DOM Notation 接口。 |
| DOMPROCESSINGINSTRUCTION | 实现 DOM Processing instruction 接口。 |
| DOMTEXT | 实现 DOM Text 接口。 |
### DBMS_XMLDOM 异常
`DBMS_XMLDOM` 在遇到问题时会生成异常。
此表列出了为 `DBMS_XMLDOM` 定义的异常：
表 213-3 DBMS_XMLDOM 的异常
| Exception | Description |
|---|---|
| DOMSTRING_SIZE_ERR | 如果指定的文本范围不适合放入 DOMString 中。 |
| HIERARCHY_REQUEST_ERR | 如果任何节点被插入到不属于它的位置。 |
| INDEX_SIZE_ERR | 如果索引或大小为负数，或大于允许的值。 |
| INUSE_ATTRIBUTE_ERR | 如果尝试添加已在其他地方使用的属性。 |
| INVALID_CHARACTER_ERR | 如果指定了无效或非法字符，例如在名称中。有关合法字符的定义请参见 XML 规范中的生产规则 2，有关合法名称字符的定义请参见生产规则 5。 |
| NO_DATA_ALLOWED_ERROR | 如果为不支持数据的节点指定了数据。 |
| NOT_FOUND_ERR | 如果尝试在不存在的上下文中引用节点。 |
| NO_MODIFICATION_ALLOWED_ERR | 如果尝试修改不允许修改的对象。 |
| NOT_SUPPORTED_ERR | 如果实现不支持请求的对象或操作类型。 |
| WRONG_DOCUMENT_ERR | 如果节点在与其创建文档不同的文档中使用（该文档不支持它）。 |
### DBMS_XMLDOM 子程序组
`DBMS_XMLDOM` 子程序根据 W3C 接口进行分组。
- DOMNode 子程序
- DOMAttr 子程序
- DOMCDataSection 子程序
- DOMCharacterData 子程序
- DOMComment 子程序
- DOMDocument 子程序
- DOMDocumentFragment 子程序
- DOMDocumentType 子程序
- DOMElement 子程序
- DOMEntity 子程序
- DOMEntityReference 子程序
- DOMImplementation 子程序
- DOMNamedNodeMap 子程序
- DOMNodeList 子程序
- DOMNotation 子程序
- DOMProcessingInstruction 子程序
- DOMText 子程序

#### DBMS_XMLDOM DOMNode 子程序

此表列出并简要描述了 `DBMS_XMLDOM` 的 `DOMNode` 子程序。
表 213-4 DOMNode 子程序摘要; DBMS_XMLDOM
| 子程序 | 描述 |
|---|---|
| ADOPTNODE Function | 从另一个文档采用节点 |
| APPENDCHILD Function | 向节点追加一个新的子节点 |
| CLONENODE Function | 克隆节点 |
| FREENODE Procedure | 释放与节点关联的所有资源 |
| GETATTRIBUTES Function | 检索节点的属性 |
| GETCHILDNODES Function | 检索节点的子节点 |
| GETEXPANDEDNAME Procedure and Functions | 检索节点的扩展名称 |
| GETFIRSTCHILD Function | 检索节点的第一个子节点 |
| GETLASTCHILD Function | 检索节点的最后一个子节点 |
| GETLOCALNAME Procedure and Functions | 检索限定名称的本地部分 |
| GETNAMESPACE Procedure and Functions | 检索节点的命名空间 URI |
| GETNEXTSIBLING Function | 检索节点的下一个同级节点 |
| GETNODENAME Function | 检索节点的名称 |
| GETNODETYPE Function | 检索节点的类型 |
| GETNODEVALUE Function | 检索节点的值 |
| GETNODEVALUEASBINARYSTREAM Function & Procedure | 以二进制流检索节点值 |
| GETNODEVALUEASCHARACTERSTREAM Function & Procedure | 以字符流检索节点值 |
| GETOWNERDOCUMENT Function | 检索节点的所有者文档 |
| GETPARENTNODE Function | 检索此节点的父节点 |
| GETPREFIX Function | 检索命名空间前缀 |
| GETPREVIOUSSIBLING Function | 检索节点的上一个同级节点 |
| GETSCHEMANODE Function | 检索关联的 schema URI |
| HASATTRIBUTES Function | 测试节点是否具有属性 |
| HASCHILDNODES Function | 测试节点是否具有子节点 |
| IMPORTNODE Function | 从另一个文档导入节点 |
| INSERTBEFORE Function | 在参考子节点之前插入一个子节点 |
| ISNULL Functions | 测试节点是否为 NULL |
| MAKEATTR Function | 将节点转换为 Attribute |
| MAKECDATASECTION Function | 将节点转换为 CData Section |
| MAKECHARACTERDATA Function | 将节点转换为 Character Data |
| MAKECOMMENT Function | 将节点转换为 Comment |
| MAKEDOCUMENT Function | 将节点转换为 DOM Document |
| MAKEDOCUMENTFRAGMENT Function | 将节点转换为 DOM Document Fragment |
| MAKEDOCUMENTTYPE Function | 将节点转换为 DOM Document Type |
| MAKEELEMENT Function | 将节点转换为 DOM Element |
| MAKEENTITY Function | 将节点转换为 DOM Entity |
| MAKEENTITYREFERENCE Function | 将节点转换为 DOM Entity Reference |
| MAKENOTATION Function | 将节点转换为 DOM Notation |
| MAKEPROCESSINGINSTRUCTION Function | 将节点转换为 DOM Processing Instruction |
| MAKETEXT Function | 将节点转换为 DOM Text |
| REMOVECHILD Function | 从节点移除指定的子节点 |
| REPLACECHILD Function | 用新的子节点替换旧的子节点 |
| SETNODEVALUE Procedure | 设置节点的值 |
| SETNODEVALUEASBINARYSTREAM Function & Procedure | 将节点值设置为二进制流 |
| SETNODEVALUEASCHARACTERSTREAM Function & Procedure | 将节点值设置为字符流 |
| SETPREFIX Procedure | 设置命名空间前缀 |
| USEBINARYSTREAM Function | 确立流是有效的 |
| WRITETOBUFFER Procedures | 将节点内容写入缓冲区 |
| WRITETOCLOB Procedures | 将节点内容写入 CLOB |
| WRITETOFILE Procedures | 将节点内容写入文件 |

#### DBMS_XMLDOM DOMAttr 子程序

本表按字母顺序列出了 DBMS_XMLDOM 的 DOMAttr 子程序，并对其进行简要描述。
Table 213-5 DOMAttr 子程序摘要；DBMS_XMLDOM
| 方法 | 描述 |
|---|---|
| GETEXPANDEDNAME 过程和函数 | 检索属性的扩展名称 |
| GETLOCALNAME 过程和函数 | 检索属性的本地名称 |
| GETNAME 函数 | 检索属性的名称 |
| GETNAMESPACE 过程和函数 | 检索属性的 NS URI |
| GETOWNERELEMENT 函数 | 检索属性父级的 Element 节点 |
| GETQUALIFIEDNAME 函数 | 检索属性的限定名称 |
| GETSPECIFIED 函数 | 测试属性是否在元素中指定 |
| GETVALUE 函数 | 检索属性的值 |
| ISNULL 函数 | 测试 Attribute 节点是否为 NULL |
| MAKENODE 函数 | 将属性转换为节点 |
| SETVALUE 过程 | 设置属性的值 |

#### DBMS_XMLDOM DOMCDataSection 子程序

本表按字母顺序列出了 DBMS_XMLDOM 的 DOMCdata 子程序，并对其进行了简要描述。
Table 213-6 Summary of DOMCdata Subprograms; DBMS_XMLDOM
| Method | Description |
|---|---|
| ISNULL Functions | 测试 CDataSection 是否为 NULL |
| MAKENODE Functions | 将 CDataSection 转换为一个 node |

#### DBMS_XMLDOM DOMCharacterData 子程序

本表按字母顺序列出了 DBMS_XMLDOM 的 DOMCharacterData 子程序，并对其进行了简要描述。
表 213-7 DOMCharacterData 子程序摘要; DBMS_XMLDOM
| Method | Description |
|---|---|
| APPENDDATA Procedure | 将指定数据追加到节点数据中 |
| DELETEDATA Procedure | 从指定 offSets 处删除数据 |
| GETDATA Functions | 检索节点的数据 |
| GETLENGTH Functions | 检索数据的长度 |
| INSERTDATA Procedure | 在节点的指定 offSets 处插入数据 |
| ISNULL Functions | 测试 CharacterData 是否为 NULL |
| MAKENODE Functions | 将 CharacterData 转换为节点 |
| REPLACEDATA Procedure | 更改节点中的一系列字符 |
| SETDATA Procedures | 为节点设置数据 |
| SUBSTRINGDATA Function | 检索数据的子串 |

#### DBMS_XMLDOM DOMComment 子程序

下表按字母顺序列出了 DBMS_XMLDOM 的 DOMComment 子程序，并对其进行了简要描述。
表 213-8 DOMComment 子程序摘要；DBMS_XMLDOM
| 方法 | 描述 |
|---|---|
| ISNULL 函数 | 测试注释是否为 NULL |
| MAKENODE 函数 | 将注释转换为节点 |

#### DBMS_XMLDOM DOMDocument 子程序

本表按字母顺序列出了 DBMS_XMLDOM 的 DOMDocument 子程序，并对其进行了简要描述。
表 213-9 DOMDocument 子程序摘要；DBMS_XMLDOM
| 方法 | 描述 |
|---|---|
| CREATEATTRIBUTE 函数 | 创建一个属性 |
| CREATECDATASECTION 函数 | 创建一个 CDataSection 节点 |
| CREATECOMMENT 函数 | 创建一个 Comment 节点 |
| CREATEDOCUMENT 函数 | 创建一个新文档 |
| CREATEDOCUMENTFRAGMENT 函数 | 创建一个新文档片段 |
| CREATEELEMENT 函数 | 创建一个新元素 |
| CREATEENTITYREFERENCE 函数 | 创建一个实体引用 |
| CREATEPROCESSINGINSTRUCTION 函数 | 创建一个处理指令 |
| CREATETEXTNODE 函数 | 创建一个文本节点 |
| FREEDOCFRAG 过程 | 释放文档片段 |
| FREEDOCUMENT 过程 | 释放文档 |
| GETCHARSET 函数 | 检索 DOM 文档的字符集 |
| GETDOCTYPE 函数 | 检索文档的 DTD |
| GETDOCUMENTELEMENT 函数 | 检索文档的根元素 |
| GETELEMENTSBYTAGNAME 函数 | 根据标签名检索 DOMNODELIST 中的元素，以及根据标签名检索 DOMNODELIST 子树中的元素 |
| GETIMPLEMENTATION 函数 | 检索 DOM 实现 |
| GETSTANDALONE 函数 | 检索文档的 standalone 属性 |
| GETVERSION 函数 | 检索文档的版本 |
| GETXMLTYPE 函数 | 检索与 DOM 文档关联的 XMLType |
| ISNULL 函数 | 测试文档是否为 NULL |
| MAKENODE 函数 | 将文档转换为节点 |
| NEWDOMDOCUMENT 函数 | 创建一个新文档 |
| SETCHARSET 过程 | 设置 DOM 文档的字符集 |
| SETDOCTYPE 过程 | 设置文档的 DTD |
| SETSTANDALONE 过程 | 设置文档的 standalone 属性 |
| SETVERSION 过程 | 设置文档的版本 |
| WRITETOBUFFER 过程 | 将文档写入缓冲区 |
| WRITETOCLOB 过程 | 将文档写入 CLOB |
| WRITETOFILE 过程 | 将文档写入文件 |

#### DBMS_XMLDOM DOMDocumentFragment 子程序

本表按字母顺序列出了 DBMS_XMLDOM 的 DOMDocumentFragment 子程序，并对其进行了简要描述。
表 213-10 DOMDocumentFragment 子程序摘要; DBMS_XMLDOM
| Method | Description |
|---|---|
| FREEDOCFRAG Procedure | 释放指定的文档片段 |
| ISNULL Functions | 测试 DocumentFragment 是否为 NULL |
| MAKENODE Functions | 将文档片段转换为节点 |
| WRITETOBUFFER Procedures | 将文档片段的内容写入缓冲区 |

#### DBMS_XMLDOM DOMDocumentType 子程序

此表按字母顺序列出了 DBMS_XMLDOM 的 DOMDocumentType 子程序，并对其进行了简要描述。
表 213-11 DOMDocumentType 子程序摘要; DBMS_XMLDOM
| 方法 | 描述 |
|---|---|
| FINDENTITY Function | 在文档类型中查找指定的实体 |
| FINDNOTATION Function | 在文档类型中查找指定的记法 |
| GETENTITIES Function | 检索文档类型中实体的 nodemap |
| GETNAME Functions | 检索文档类型的名称 |
| GETNOTATIONS Function | 检索文档类型中记法的 nodemap |
| GETPUBLICID Functions | 检索文档类型的 public ID |
| GETSYSTEMID Functions | 检索文档类型的 system ID |
| ISNULL Functions | 测试文档类型是否为 NULL |
| MAKENODE Functions | 将文档类型转换为节点 |

#### DBMS_XMLDOM DOMElement 子程序

本表按字母顺序列出了 DBMS_XMLDOM 的 DOMElement 子程序，并对其进行了简要描述。
表 213-12 DOMElement 子程序摘要；DBMS_XMLDOM
| 方法 | 描述 |
|---|---|
| FREEELEMENT 过程 | 释放分配给 DOMElement 句柄的内存 |
| GETATTRIBUTE 函数 | 按名称检索属性节点 |
| GETATTRIBUTENODE 函数 | 按名称检索属性节点 |
| GETCHILDRENBYTAGNAME 函数 | 按标签名检索元素的子节点 |
| GETELEMENTSBYTAGNAME 函数 | 按标签名检索 DOMNODELIST 中的元素，即按标签名检索 DOMNODELIST 子树中的元素 |
| GETEXPANDEDNAME 过程和函数 | 检索元素的扩展名 |
| GETLOCALNAME 过程和函数 | 检索元素的本地名 |
| GETNAMESPACE 过程和函数 | 检索元素的 NS URI |
| GETQUALIFIEDNAME 函数 | 检索元素的限定名 |
| GETTAGNAME 函数 | 检索元素的标签名 |
| HASATTRIBUTE 函数 | 测试属性是否存在 |
| ISNULL 函数 | 测试元素是否为 NULL |
| MAKENODE 函数 | 将元素转换为节点 |
| NORMALIZE 过程 | 规范化元素的文本子节点 |
| REMOVEATTRIBUTE 过程 | 移除由名称指定的属性 |
| REMOVEATTRIBUTENODE 函数 | 移除元素中的属性节点 |
| RESOLVENAMESPACEPREFIX 函数 | 将前缀解析为命名空间 URI |
| SETATTRIBUTE 过程 | 设置由名称指定的属性 |
| SETATTRIBUTENODE 函数 | 设置元素中的属性节点 |

#### DBMS_XMLDOM DOMEntity 子程序

此表列出并简要介绍了 `DBMS_XMLDOM` 的 `DOMEntity` 子程序。
表 213-13 DOMEntity 子程序摘要；DBMS_XMLDOM
| 方法 | 描述 |
|---|---|
| GETNOTATIONNAME Function | 检索实体的表示法名称 |
| GETPUBLICID Functions | 检索实体的公共 Id |
| GETSYSTEMID Functions | 检索实体的系统 Id |
| ISNULL Functions | 测试 Entity 是否为 NULL |
| MAKENODE Functions | 将 Entity 转换为节点 |

#### DBMS_XMLDOM DOMEntityReference 子程序

此表列出并简要描述了 `DBMS_XMLDOM` 的 `DOMEntityReference` 子程序。
表 213-14 DOMEntityReference 子程序摘要；DBMS_XMLDOM
| 方法 | 描述 |
|---|---|
| ISNULL 函数 | 测试 DOMEntityReference 是否为 NULL |
| MAKENODE 函数 | 将 DOMEntityReference 转换为 NULL |

#### DBMS_XMLDOM DOMImplementation 子程序

本表列出并简要描述了 `DBMS_XMLDOM` 的 `DOMImplementation` 子程序。
表 213-15 DOMImplementation 子程序摘要；DBMS_XMLDOM
| 方法 | 描述 |
|---|---|
| ISNULL 函数 | 测试 DOMImplementation 节点是否为 NULL |
| HASFEATURE 函数 | 测试 DOMImplementation 是否实现了某个特性 |

#### DBMS_XMLDOM DOMNamedNodeMap 子程序

此表列出并简要描述了 `DBMS_XMLDOM` 的 `DOMNamedNodeMap` 子程序。
表 213-16 DOMNamedNodeMap 子程序摘要；DBMS_XMLDOM
| 方法 | 描述 |
|---|---|
| GETLENGTH Functions | 检索映射中的项数 |
| GETNAMEDITEM Function | 检索由名称指定的项 |
| ISNULL Functions | 测试 NamedNodeMap 是否为 NULL |
| ITEM Functions | 检索映射中给定索引处的项 |
| REMOVENAMEDITEM Function | 移除由名称指定的项 |
| SETNAMEDITEM Function | 设置映射中由名称指定的项 |

#### DBMS_XMLDOM DOMNodeList 子程序

此表列出并简要介绍了 `DBMS_XMLDOM` 的 `DOMNodeList` 子程序。
表 213-17 DOMNodeList 子程序概览；DBMS_XMLDOM
| 方法 | 描述 |
|---|---|
| FREENODELIST 过程 | 释放与 nodelist 关联的所有资源 |
| GETLENGTH 函数 | 获取列表中的项数 |
| ISNULL 函数 | 测试 NodeList 是否为 NULL |
| ITEM 函数 | 根据列表中的索引获取项 |

#### DBMS_XMLDOM DOMNotation 子程序

此表列出并简要描述了 `DBMS_XMLDOM` 的 `DOMNotation` 子程序。
表 213-18 DOMNotation 子程序摘要；DBMS_XMLDOM
| 方法 | 描述 |
|---|---|
| GETPUBLICID 函数 | 检索表示法的公共 Id |
| GETSYSTEMID 函数 | 检索表示法的系统 Id |
| ISNULL 函数 | 测试 Notation 是否为 NULL |
| MAKENODE 函数 | 将表示法强制转换为节点 |

#### DBMS_XMLDOM DOMProcessingInstruction 子程序

此表列出并简要描述了 `DBMS_XMLDOM` 的 `DOMProcessingInstruction` 子程序。
表 213-19 DOMProcessingInstruction 子程序摘要; DBMS_XMLDOM
| 方法 | 描述 |
|---|---|
| GETDATA 函数 | 检索处理指令的数据 |
| GETTARGET 函数 | 检索处理指令的目标 |
| ISNULL 函数 | 测试处理指令是否为 NULL |
| MAKENODE 函数 | 将处理指令转换为节点 |
| SETDATA 过程 | 设置处理指令的数据 |

#### DBMS_XMLDOM DOMText 子程序

此表列出并简要描述了 `DBMS_XMLDOM` 的 `DOMText` 子程序。
表 213-20 DOMText 子程序摘要；DBMS_XMLDOM
| 方法 | 描述 |
|---|---|
| ISNULL 函数 | 测试文本是否为 NULL |
| MAKENODE 函数 | 将文本转换为节点 |
| SPLITTEXT 函数 | 将文本节点的内容拆分为 2 个文本节点 |
### DBMS_XMLDOM 子程序摘要
此表列出了 DBMS_XMLDOM 子程序并对其进行了简要描述。
表 213-21 DBMS_XMLDOM 包子程序摘要
| 子程序 | 描述 | 分组 |
|---|---|---|
| ADOPTNODE 函数 | 从另一个文档采用节点 | DOMNode 子程序 |
| APPENDCHILD 函数 | 向节点追加新的子节点 | DOMNode 子程序 |
| APPENDDATA 过程 | 将指定的数据追加到节点数据 | DOMCharacterData 子程序 |
| CLONENODE 函数 | 克隆节点 | DOMNode 子程序 |
| CREATEATTRIBUTE 函数 | 创建属性 | DOMDocument 子程序 |
| CREATECDATASECTION 函数 | 创建 CDataSection 节点 | DOMDocument 子程序 |
| CREATECOMMENT 函数 | 创建注释节点 | DOMDocument 子程序 |
| CREATEDOCUMENT 函数 | 创建新文档 | DOMDocument 子程序 |
| CREATEDOCUMENTFRAGMENT 函数 | 创建新文档片段 | DOMDocument 子程序 |
| CREATEELEMENT 函数 | 创建新元素 | DOMDocument 子程序 |
| CREATEENTITYREFERENCE 函数 | 创建实体引用 | DOMDocument 子程序 |
| CREATEPROCESSINGINSTRUCTION 函数 | 创建处理指令 | DOMDocument 子程序 |
| CREATETEXTNODE 函数 | 创建文本节点 | DOMDocument 子程序 |
| DELETEDATA 过程 | 从指定偏移量删除数据 | DOMCharacterData 子程序 |
| FINDENTITY 函数 | 在文档类型中查找指定实体 | DOMDocumentType 子程序 |
| FINDNOTATION 函数 | 在文档类型中查找指定的符号 | DOMDocumentType 子程序 |
| FREEDOCFRAG 过程 | 释放文档片段 | DOMDocument 子程序和 DOMDocumentFragment 子程序 |
| FREEDOCUMENT 过程 | 释放文档 | DOMDocument 子程序 |
| FREEELEMENT 过程 | 释放分配给 DOMElement 句柄的内存 | DOMElement 子程序 |
| FREENODE 过程 | 释放与节点关联的所有资源 | DOMNode 子程序 |
| FREENODELIST 过程 | 释放与节点列表关联的所有资源 | DOMNodeList 子程序 |
| GETATTRIBUTE 函数 | 按名称检索属性节点 | DOMElement 子程序 |
| GETATTRIBUTENODE 函数 | 按名称检索属性节点 | DOMElement 子程序 |
| GETATTRIBUTES 函数 | 检索节点的属性 | DOMNode 子程序 |
| GETCHARSET 函数 | 检索 DOM 文档的字符集 | DOMDocument 子程序 |
| GETCHILDNODES 函数 | 检索节点的子节点 | DOMNode 子程序 |
| GETCHILDRENBYTAGNAME 函数 | 按标签名检索元素的子节点 | DOMCharacterData 子程序 |
| GETDATA 函数 | 检索节点的数据 处理指令的数据 | DOMCharacterData 子程序 DOMProcessingInstruction 子程序 |
| GETDOCTYPE 函数 | 检索文档的 DTD | DOMDocument 子程序 |
| GETDOCUMENTELEMENT 函数 | 检索文档的根元素 | DOMDocument 子程序 |
| GETELEMENTSBYTAGNAME 函数 | 按标签名检索 DOMNODELIST 中的元素 按标签名检索 DOMNODELIST 子树中的元素 | DOMDocument 子程序 DOMElement 子程序 |
| GETENTITIES 函数 | 检索文档类型中的实体节点映射 | DOMDocumentType 子程序 |
| GETEXPANDEDNAME 过程和函数 | 检索节点的展开名称 属性的展开名称 元素的展开名称 | DOMNode 子程序 DOMAttr 子程序 DOMElement 子程序 |
| GETFIRSTCHILD 函数 | 检索节点的第一个子节点 | DOMNode 子程序 |
| GETIMPLEMENTATION 函数 | 检索 DOM 实现 | DOMDocument 子程序 |
| GETLASTCHILD 函数 | 检索节点的最后一个子节点 | DOMNode 子程序 |
| GETLENGTH 函数 | 检索数据的长度 映射中的项目数 列表中的项目数 | DOMCharacterData 子程序 DOMNamedNodeMap 子程序 DOMNodeList 子程序 |
| GETLOCALNAME 过程和函数 | 检索限定名称的本地部分 属性的本地名称 元素的本地名称 | DOMNode 子程序 DOMAttr 子程序 DOMElement 子程序 |
| GETNAME 函数 | 检索属性的名称 文档类型的名称 | DOMAttr 子程序 DOMDocumentType 子程序 |
| GETNAMEDITEM 函数 | 检索由名称和命名空间 URI 指定的项目 ) | DOMNamedNodeMap 子程序 DOMNamedNodeMap 子程序 |
| GETNAMESPACE 过程和函数 | 检索节点的命名空间 URI 属性的 NS URI 元素的 NS URI | DOMNode 子程序 DOMAttr 子程序 DOMElement 子程序 |
| GETNEXTSIBLING 函数 | 检索节点的下一个同级节点 | DOMNode 子程序 |
| GETNODENAME 函数 | 检索节点的名称 | DOMNode 子程序 |
| GETNODETYPE 函数 | 检索节点的类型 | DOMNode 子程序 |
| GETNODEVALUE 函数 | 检索节点的值 | DOMNode 子程序 |
| GETNODEVALUEASBINARYSTREAM 函数和过程 | 将节点值检索为二进制流 | DOMNode 子程序 |
| GETNODEVALUEASCHARACTERSTREAM 函数和过程 | 将节点值检索为字符流 | DOMNode 子程序 |
| GETNOTATIONNAME 函数 | 检索实体的符号名称 | DOMEntity 子程序 |
| GETNOTATIONS 函数 | 检索文档类型中符号的节点映射 | DOMDocumentType 子程序 |
| GETTARGET 函数 | 检索处理指令的目标 | DOMProcessingInstruction 子程序 |
| GETOWNERDOCUMENT 函数 | 检索节点的所有者文档 | DOMNode 子程序 |
| GETOWNERELEMENT 函数 | 检索属性父级的元素节点 | DOMAttr 子程序 |
| GETPARENTNODE 函数 | 检索此节点的父节点 | DOMNode 子程序 |
| GETPREFIX 函数 | 检索命名空间前缀 ) | DOMNode 子程序 |
| GETPREVIOUSSIBLING 函数 | 检索节点的上一个同级节点 | DOMNode 子程序 |
| GETPUBLICID 函数 | 检索文档类型的公共 ID 实体的公共 ID 符号的公共 ID | DOMDocumentType 子程序 DOMEntity 子程序 DOMNotation 子程序 |
| GETQUALIFIEDNAME 函数 | 检索属性的限定名称 元素的限定名称 | DOMAttr 子程序 DOMElement 子程序 |
| GETSCHEMANODE 函数 | 检索关联的模式 URI | DOMNode 子程序 |
| GETSPECIFIED 函数 | 测试属性是否在元素中指定。 | DOMAttr 子程序 |
| GETSTANDALONE 函数 | 检索文档的 standalone 属性 | DOMDocument 子程序 |
| GETSYSTEMID 函数 | 检索文档类型的系统 ID 实体的系统 ID 符号的系统 ID | DOMDocumentType 子程序 DOMEntity 子程序 DOMNotation 子程序 |
| GETTAGNAME 函数 | 检索元素的标签名 | DOMElement 子程序 |
| GETVALUE 函数 | 检索属性的值 | DOMAttr 子程序 |
| GETVERSION 函数 | 检索文档的版本 | DOMDocument 子程序) |
| GETXMLTYPE 函数 | 检索与 DOM 文档关联的 XMLType | DOMDocument 子程序 |
| HASATTRIBUTES 函数 | 测试节点是否具有属性 | DOMNode 子程序 |
| HASATTRIBUTE 函数 | 测试属性是否存在 | DOMElement 子程序 |
| HASCHILDNODES 函数 | 测试节点是否具有子节点 | DOMNode 子程序 |
| HASFEATURE 函数 | 测试 DOMImplementation 是否实现某项功能 | DOMImplementation 子程序 |
| IMPORTNODE 函数 | 从另一个文档导入节点 | DOMNode 子程序 |
| INSERTBEFORE 函数 | 在参考子节点之前插入子节点 | DOMNode 子程序 |
| INSERTDATA 过程 | 在指定偏移量处向节点插入数据 | DOMCharacterData 子程序 |
| ISNULL 函数 | 测试节点是否为 NULL 属性节点是否为 NULL CDataSection 是否为 NULL CharacterData 是否为 NULL 注释是否为 NULL 文档是否为 NULL DocumentFragment 是否为 NULL Document Type 是否为 NULL Element 是否为 NULL Entity 是否为 NULL DOMEntityReference 是否为 NULL DOMImplementation 节点是否为 NULL NamedNodeMap 是否为 NULL NodeList 是否为 NULL Notation 是否为 NULL Processing Instruction 是否为 NULL 文本是否为 NULL | DOMNode 子程序 DOMAttr 子程序 DOMCDataSection 子程序 DOMCharacterData 子程序 DOMComment 子程序 DOMDocument 子程序 DOMDocumentFragment 子程序 DOMDocumentType 子程序 DOMElement 子程序 DOMEntity 子程序 DOMEntityReference 子程序 DOMImplementation 子程序 DOMNamedNodeMap 子程序 DOMNodeList 子程序 DOMNotation 子程序 DOMProcessingInstruction 子程序 DOMText 子程序 |
| ITEM 函数 | 检索映射中给定索引的项目 NodeList 中给定索引的项目 | DOMNamedNodeMap 子程序 DOMNodeList 子程序 |
| MAKEATTR 函数 | 将节点转换为属性 | DOMNode 子程序 |
| MAKECDATASECTION 函数 | 将节点转换为 CData Section | DOMNode 子程序 |
| MAKECHARACTERDATA 函数 | 将节点转换为 Character Data | DOMNode 子程序 |
| MAKECOMMENT 函数 | 将节点转换为注释 | DOMNode 子程序 |
| MAKEDOCUMENT 函数 | 将节点转换为 DOM 文档 | DOMNode 子程序 |
| MAKEDOCUMENTFRAGMENT 函数 | 将节点转换为 DOM 文档片段 | DOMNode 子程序) |
| MAKEDOCUMENTTYPE 函数 | 将节点转换为 DOM 文档类型 | DOMNode 子程序 |
| MAKEELEMENT 函数 | 将节点转换为 DOM 元素 | DOMNode 子程序 |
| MAKEENTITY 函数 | 将节点转换为 DOM 实体 | DOMNode 子程序 |
| MAKEENTITYREFERENCE 函数 | 将节点转换为 DOM 实体引用 | DOMNode 子程序 |
| MAKENODE 函数 | 将属性转换为节点 CDataSection 转换为节点 CharacterData 转换为节点 注释转换为节点 文档转换为节点 文档片段转换为节点 文档类型转换为节点 元素转换为节点 实体转换为节点 DOMEntityReference 转换为 NULL 符号转换为节点 处理指令转换为节点 文本转换为节点 | DOMAttr 子程序 DOMCDataSection 子程序 DOMCharacterData 子程序 DOMComment 子程序 DOMDocument 子程序 DOMDocumentFragment 子程序 DOMDocumentType 子程序 DOMElement 子程序 DOMEntity 子程序 DOMEntityReference 子程序 DOMNotation 子程序 DOMProcessingInstruction 子程序 DOMText 子程序 |
| MAKENOTATION 函数 | 将节点转换为 DOM 符号 | DOMNode 子程序 |
| MAKEPROCESSINGINSTRUCTION 函数 | 将节点转换为 DOM 处理指令 | DOMNode 子程序 |
| MAKETEXT 函数 | 将节点转换为 DOM 文本 | DOMNode 子程序 |
| NEWDOMDOCUMENT 函数 | 创建新文档 | DOMDocument 子程序 |
| NORMALIZE 过程 | 规范化元素的文本子节点 | DOMElement 子程序 |
| REMOVEATTRIBUTE 过程 | 删除由名称指定的属性 | DOMElement 子程序 |
| REMOVEATTRIBUTENODE 函数 | 删除元素中的属性节点 | DOMElement 子程序 |
| REMOVECHILD 函数 | 从节点中删除指定的子节点 | DOMNode 子程序 |
| REMOVENAMEDITEM 函数 | 删除由名称指定的项目 | DOMNamedNodeMap 子程序 |
| REPLACECHILD 函数 | 用新的子节点替换旧的子节点 | DOMNode 子程序 |
| REPLACEDATA 过程 | 更改节点中的一系列字符 | DOMCharacterData 子程序 |
| RESOLVENAMESPACEPREFIX 函数 | 将前缀解析为命名空间 URI | DOMElement 子程序 |
| SETATTRIBUTE 过程 | 设置由名称指定的属性 | DOMElement 子程序 |
| SETATTRIBUTENODE 函数 | 在元素中设置属性节点 | DOMElement 子程序 |
| SETCHARSET 过程 | 设置 DOM 文档的字符集 | DOMDocument 子程序 |
| SETDATA 过程 | 将数据设置到节点 处理指令的数据 | DOMCharacterData 子程序 DOMProcessingInstruction 子程序 |
| SETDOCTYPE 过程 | 设置文档的 DTD。 | DOMDocument 子程序 |
| SETNAMEDITEM 函数 | 在映射中设置由名称指定的项目 | DOMNamedNodeMap 子程序 |
| SETNODEVALUE 过程 | 设置节点的值 | DOMNode 子程序 |
| SETNODEVALUEASBINARYSTREAM 函数和过程 | 将节点值设置为二进制流 | DOMNode 子程序 |
| SETNODEVALUEASCHARACTERSTREAM 函数和过程 | 将节点值设置为字符流 | DOMNode 子程序 |
| SETPREFIX 过程 | 设置命名空间前缀 | DOMNode 子程序 |
| SETSTANDALONE 过程 | 设置文档的 standalone 属性 | DOMDocument 子程序 |
| SETVALUE 过程 | 设置属性的值 | DOMAttr 子程序 |
| SETVERSION 过程 | 设置文档的版本 | DOMDocument 子程序 |
| SPLITTEXT 函数 | 将文本节点的内容拆分为 2 个文本节点 | DOMText 子程序 |
| SUBSTRINGDATA 函数 | 检索数据的子字符串 | DOMCharacterData 子程序 |
| USEBINARYSTREAM 函数 | 斜视该流可供有效使用 | DOMNode 子程序 |
| WRITETOBUFFER 过程 | 将节点内容写入缓冲区 文档写入缓冲区 文档片段内容写入缓冲区 | DOMNode 子程序 DOMDocument 子程序 DOMDocumentFragment 子程序 |
| WRITETOCLOB 过程 | 将节点内容写入 CLOB 文档写入 CLOB | DOMNode 子程序 DOMDocument 子程序 |
| WRITETOFILE 过程 | 将节点内容写入文件 文档写入文件 | DOMNode 子程序 DOMDocument 子程序 |

#### ADOPTNODE Function

此函数从另一个文档中接纳一个节点，并返回这个新节点。
另请参阅：
DOMNode Subprograms 可查看该组中的其他子程序
语法
```
DBMS_XMLDOM.ADOPTNODE(
   doc            IN   DOMDocument,
   importedNode   IN   DOMNode)
 RETURN DOMNODE;
```
参数
Table 213-22 ADOPTNODE Function Parameters
| Parameter | Description |
|---|---|
| doc | 接纳该节点的文档 |
| importedNode | 要接纳的节点 |
使用注意事项
请注意，ADOPTNODE Function 会从源文档中移除节点，而 IMPORTNODE Function 则会在源文档中克隆节点。

#### APPENDCHILD 函数

此函数将节点 `newchild` 添加到该节点的子节点列表末尾，并返回新添加的节点。如果 `newchild` 已经存在于树中，则会先将其移除。
另请参阅：
DOMNode 子程序
语法
```
DBMS_XMLDOM.APPENDCHILD(
   n          IN    DOMNode,
   newchild   IN    DOMNode)
 RETURN DOMNODE;
```
参数
表 213-23 APPENDCHILD 函数参数
| Parameter | Description |
|---|---|
| n | DOMNode |
| newchild | 要追加到节点 n 的子节点列表中的子节点 |

#### APPENDDATA Procedure

此过程将字符串追加到节点的字符数据末尾。成功执行后，data 将提供对 data 和指定字符串参数拼接结果的访问。
另请参阅：
DOMCharacterData Subprograms
语法
```
DBMS_XMLDOM.APPENDDATA(
   cd      IN    DOMCHARACTERDATA,
   arg     IN    VARCHAR2);
```
参数
表 213-24 APPENDDATA Procedure Parameters
| Parameter | Description |
|---|---|
| cd | DOMCHARACTERDATA |
| arg | 要追加到现有 data 的数据 |

#### CLONENODE 函数

此函数返回此节点的副本，并作为节点的通用复制构造函数。副本节点没有父节点，其父节点为 `NULL`。
另见：
DOMNode 子程序
语法
```
DBMS_XMLDOM.CLONENODE(
   n       IN    DOMNODE,
   deep    IN    BOOLEAN)
 RETURN DOMNODE;
```
参数
表 213-25 CLONENODE 函数参数
| 参数 | 描述 |
|---|---|
| n | DOMNODE |
| deep | 决定是否克隆子节点 |
使用说明
- 克隆 Element 会复制所有属性及其值，包括由 XML 处理器生成以表示默认属性的值，但此方法不会复制其包含的任何文本，除非是深度克隆，因为文本包含在子 Text 节点中。
- 直接克隆 Attribute 与作为 Element 克隆操作的一部分进行克隆不同，前者会返回指定的属性（specified 为 TRUE）。
- 克隆任何其他类型的节点只需返回此节点的副本。

#### CREATEATTRIBUTE 函数

此函数创建一个 `DOMATTR` 节点。
另请参阅：
DOMDocument 子程序
语法
创建一个具有指定名称的 `DOMATTR `：
```
DBMS_XMLDOM.CREATEATTRIBUTE(
   doc     IN    DOMDOCUMENT,
   name    IN    VARCHAR2)
 RETURN DOMATTR;
```
创建一个具有指定名称和命名空间 URI 的 `DOMATTR`：
```
DBMS_XMLDOM.CREATEATTRIBUTE(
   doc     IN    DOMDOCUMENT,
   qname    IN    VARCHAR2,
   ns      IN     VARCHAR2)
RETURN DOMATTR;
```
参数
表 213-26 CREATEATTRIBUTE 函数参数
| 参数 | 描述 |
|---|---|
| doc | DOMDOCUMENT |
| qname | 新属性的限定名 |
| ns | 命名空间 |

#### CREATECDATASECTION 函数

此函数创建一个 `DOMCDATASECTION` 节点。
另请参见：
DOMDocument 子程序
语法
```
DBMS_XMLDOM.CREATECDATASECTION(
   doc     IN      DOMDOCUMENT,
   data    IN      VARCHAR2)
 RETURN DOMCDATASECTION;
```
参数
表 213-27 CREATECDATASECTION 函数参数
| Parameter | Description |
|---|---|
| doc | DOMDOCUMENT |
| data | DOMCDATASECTION 节点的内容 |

#### CREATECOMMENT 函数

此函数创建一个 `DOMCOMMENT` 节点。
另请参阅：
DOMDocument 子程序
语法
```
DBMS_XMLDOM.CREATECOMMENT(
   doc      IN      DOMDOCUMENT,
   data     IN      VARCHAR2)
 RETURN DOMCOMMENT;
```
参数
Table 213-28 CREATECOMMENT 函数参数
| Parameter | Description |
|---|---|
| doc | DOMDOCUMENT |
| data | DOMComment 节点的内容 |

#### CREATEDOCUMENT 函数

此函数使用指定的命名空间 URI、根元素名称和 DTD 创建一个 `DOMDOCUMENT`。
另请参见：
DOMDocument 子程序
语法
```
DBMS_XMLDOM.CREATEDOCUMENT(
   namespaceURI      IN     VARCHAR2,
   qualifiedName     IN     VARCHAR2,
   doctype           IN     DOMTYPE := NULL)
 RETURN DOMDOCUMENT;
```
参数
表 213-29 CREATEDOCUMENT 函数参数
| Parameter | Description |
|---|---|
| namespaceURI | Namespace URI |
| qualifiedName | Root element name |
| doctype | Document type |

#### CREATEDOCUMENTFRAGMENT 函数

此函数创建一个 `DOMDOCUMENTFRAGMENT`。
另请参见：
DOMDocument 子程序
语法
```
DBMS_XMLDOM.CREATEDOCUMENTFRAGMENT(
   doc      IN     DOMDOCUMENT)
 RETURN DOMDOCUMENTFRAGMENT;
```
参数
表 213-30 CREATEDOCUMENTFRAGMENT 函数参数
| Parameter | Description |
|---|---|
| doc | DOMDocument |

#### CREATEELEMENT Functions

此函数创建一个 `DOMELEMENT`。
另请参阅：
DOMDocument Subprograms
语法
创建具有指定名称的 `DOMElement`：
```
DBMS_XMLDOM.CREATEELEMENT(
   doc        IN      DOMDOCUMENT,
   tagName    IN      VARCHAR2)
 RETURN DOMELEMENT;
```
创建具有指定名称和命名空间 URI 的 `DOMElement`：
```
DBMS_XMLDOM.CREATEELEMENT(
   doc        IN     DOMDOCUMENT,
   tagName    IN     VARCHAR2,
   ns         IN     VARCHAR2)
 RETURN DOMELEMENT;
```
参数
Table 213-31 CREATEELEMENT Function Parameters
| Parameter | Description |
|---|---|
| doc | DOMDOCUMENT |
| tagName | 新 DOMELEMENT 的 Tagname |
| ns | Namespace |

#### CREATEENTITYREFERENCE Function

此函数创建一个 `DOMENTITYREFERENCE` 节点。
另请参阅：
DOMDocument Subprograms
语法
```
DBMS_XMLDOM.CREATEENTITYREFERENCE(
   doc        IN     DOMDOCUMENT,
   name       IN     VARCHAR2)
 RETURN DOMENTITYREFERENCE;
```
参数
Table 213-32 CREATEENTITYREFERENCE Function Parameters
| Parameter | Description |
|---|---|
| doc | DOMDOCUMENT |
| name | New entity reference name |

#### CREATEPROCESSINGINSTRUCTION Function

此函数创建一个 `DOMPROCESSINGINSTRUCTION` 节点。
另请参阅：
DOMDocument Subprograms
语法
```
DBMS_XMLDOM.CREATEPROCESSINGINSTRUCTION(
   doc       IN      DOMDocument,
   target    IN      VARCHAR2,
   data      IN      VARCHAR2)
 RETURN DOMPROCESSINGINSTRUCTION;
```
参数
Table 213-33 CREATEPROCESSINGINSTRUCTION Function Parameters
| Parameter | Description |
|---|---|
| doc | DOMDOCUMENT |
| target | 新处理指令的 Target |
| data | 新处理指令的 Content data |

#### CREATETEXTNODE 函数

此函数创建一个 `DOMTEXT` 节点。
另请参阅：
DOMDocument 子程序
语法
```
DBMS_XMLDOM.CREATETEXTNODE(
   doc      IN     DOMDocument,
   data     IN     VARCHAR2)
 RETURN DOMTEXT;
```
参数
表 213-34 CREATETEXTNODE 函数参数
| 参数 | 描述 |
|---|---|
| doc | DOMDOCUMENT |
| data | DOMText 节点的内容 |

#### DELETEDATA 过程

此过程从节点中移除一定范围的字符。成功后，data 和 length 会反映该更改。
另请参阅：
DOMCharacterData 子程序
语法
```
DBMS_XMLDOM.DELETEDATA(
   cd        IN     DOMCHARACTERDATA,
   offset    IN     NUMBER,
   cnt       IN     NUMBER);
```
参数
表 213-35 DELETEDATA PROCEDURE 参数
| Parameter | Description |
|---|---|
| cd | DOMCHARACTERDATA |
| offset | 删除数据的起始 offset |
| cnt | 要删除的字符数量（从 offset 开始） |

#### FINDENTITY 函数

该函数在指定的 DTD 中查找实体，如果找到则返回该实体。

另请参见：
DOMDocumentType 子程序

语法
```
DBMS_XMLDOM.FINDENTITY(
   dt     IN     DOMDOCUMENTTYPE,
   name   IN     VARCHAR2,
   par    IN     BOOLEAN)
 RETURN  DOMENTITY;
```

参数
表 213-36 FINDENTITY 函数参数
| Parameter | Description |
|---|---|
| dt | DTD |
| name | 要查找的实体 |
| par | 指示实体类型的标志；TRUE 表示参数实体，FALSE 表示普通实体 |

#### FINDNOTATION 函数

此函数在指定的 DTD 中查找表示法，如果找到则返回该表示法。
另请参见：
DOMDocumentType 子程序
语法
```
DBMS_XMLDOM.FINDNOTATION(
   dt        IN     DOMDocumentType,
   name      IN     VARCHAR2)
 RETURN DOMNOTATION;
```
参数
表 213-37 FINDNOTATION 函数参数
| 参数 | 描述 |
|---|---|
| dt | 该 DTD |
| name | 要查找的表示法 |

#### FREEDOCFRAG Procedure

此 Procedure 释放指定的文档片段。
另请参见：
DOMDocument Subprograms 和 DOMDocumentFragment Subprograms
语法
```
DBMS_XMLDOM.FREEDOCFRAG(
   df    IN    DOMDOCUMENTFRAGMENT);
```
参数
Table 213-38 FREEDOCFRAG Procedure 参数
| Parameter | 描述 |
|---|---|
| df | DOM 文档片段 |

#### FREEDOCUMENT 过程

此过程释放 `DOMDOCUMENT` 对象。
另请参见：
DOMDocument 子程序
语法
```
DBMS_XMLDOM.FREEDOCUMENT(
   doc     IN     DOMDOCUMENT);
```
参数
表 213-39 FREEDOCUMENT 过程参数
| Parameter | Description |
|---|---|
| doc | DOMDOCUMENT |

#### FREEELEMENT 过程

该过程释放分配给 DOMElement 句柄的内存。
另请参阅：
DBMS_XMLDOM DOMElement 子程序
语法
```
DBMS_XMLDOM.FREEELEMENT(
    elem IN DOMELEMENT);
```
参数
表 213-40 FREEELEMENT 过程参数
| Parameter | Description |
|---|---|
| elem | Of type DOMELEMENT |

#### FREENODE Procedure

此过程释放与 `DOMNODE` 关联的所有资源。
另请参阅：
DOMNode Subprograms
语法
```
DBMS_XMLDOM.FREENODE(
   n      IN     DOMNODE);
```
参数
Table 213-41 FREENODE Procedure Parameters
| Parameter | Description |
|---|---|
| n | DOMNODE |

#### FREENODELIST 过程

此过程释放与 nodelist 关联的所有资源。
另请参阅：
DBMS_XMLDOM DOMNodeList 子程序
语法
```
DBMS_XMLDOM.FREENODELIST(
   nl IN DOMNodeList);
```
参数
表 213-42 FREENODELIST 过程参数
| Parameter | Description |
|---|---|
| nl | Of type DOMNODELIST |

#### GETATTRIBUTE 函数

本函数按名称返回 `DOMELEMENT` 的属性值。
另请参阅：
DOMElement 子程序
语法
按名称返回 `DOMELEMENT` 的属性值：
```
DBMS_XMLDOM.GETATTRIBUTE(
   elem       IN      DOMELEMENT,
   name       IN      VARCHAR2)
 RETURN VARCHAR2;
```
按名称和命名空间 URI 返回 `DOMELEMENT` 的属性值：
```
DBMS_XMLDOM.GETATTRIBUTE(
   elem      IN     DOMELEMENT,
   name      IN     VARCHAR2,
   ns        IN     VARCHAR2)
 RETURN VARCHAR2;
```
参数
表 213-43 GETATTRIBUTE 函数参数
| Parameter | Description |
|---|---|
| elem | 该 DOMELEMENT |
| name | 属性名称 |
| ns | 命名空间 |

#### GETATTRIBUTENODE 函数

此函数根据名称从 `DOMELEMENT` 返回属性节点。该函数为重载函数。其具体功能形式将结合语法声明进行描述。
另请参见：
DOMElement 子程序
语法
根据名称从 `DOMELEMENT` 返回属性节点：
```
DBMS_XMLDOM.GETATTRIBUTENODE(
   elem      IN     DOMElement,
   name      IN     VARCHAR2)
 RETURN DOMATTR;
```
根据名称和命名空间 URI 从 `DOMELEMENT` 返回属性节点：
```
DBMS_XMLDOM.GETATTRIBUTENODE(
   elem      IN     DOMElement,
   name      IN     VARCHAR2,
   ns        IN     VARCHAR2)
RETURN DOMATTR;
```
参数
表 213-44 GETATTRIBUTENODE 函数参数
| Parameter | Description |
|---|---|
| elem | DOMELEMENT |
| name | 属性名称；* 匹配任意属性 |
| ns | 命名空间 |

#### GETATTRIBUTES 函数

此函数检索包含此节点属性的 `NAMEDNODEMAP`（如果它是 Element），否则返回 `NULL`。
另请参见：
DOMNode 子程序
语法
```
DBMS_XMLDOM.GETATTRIBUTES(
   n      IN      DOMNode)
 RETURN DOMNAMEDNODEMAP;
```
参数
Table 213-45 GETATTRIBUTES 函数参数
| Parameter | Description |
|---|---|
| n | DOMNODE |

#### GETCHARSET 函数

此函数检索 `DOM` 文档的字符集。
另请参阅：
`DOMDocument` 子程序
语法
```
DBMS_XMLDOM.GETCHARSET(
   doc IN    DOMDocument)
 RETURN VARCHAR2;
```
参数
表 213-46 GETCHARSET 函数参数
| 参数 | 描述 |
|---|---|
| doc | DOM 文档 |
用法说明
对于新解析的文档，我们返回数据库字符集。一旦使用非 `NULL` 值为 `charset` 调用 `SETCHARSET` 过程，便会返回该 `charset`。

#### GETCHILDNODES Function

此函数检索包含此节点所有子节点的 `DOMNODELIST`。如果没有子节点，则返回一个不包含任何节点的 `DOMNODELIST`。
另请参阅：
DOMNode Subprograms
语法
```
DBMS_XMLDOM.GETCHILDNODES(
   n      IN    DOMNode)
 RETURN DOMNodeList;
```
参数
Table 213-47 GETCHILDNODES Function Parameters
| Parameter | Description |
|---|---|
| n | DOMNODE |

#### GETCHILDRENBYTAGNAME 函数

此函数返回 `DOMELEMENT` 的子节点。
另见：
DOMElement 子程序
语法
根据标签名返回 `DOMELEMENT` 的子节点：
```
DBMS_XMLDOM.GETCHILDRENBYTAGNAME(
   elem      IN      DOMElement,
   name      IN      VARCHAR2)
 RETURN DOMNODELIST;
```
根据标签名和命名空间返回 `DOMELEMENT` 的子节点：
```
DBMS_XMLDOM.GETCHILDRENBYTAGNAME(
   elem      IN      DOMElement,
   name      IN      VARCHAR2,
   ns        IN      VARCHAR2)
RETURN DOMNODELIST;
```
参数
表 213-48 GETCHILDRENBYTAGNAME 函数参数
| Parameter | Description |
|---|---|
| elem | DOMELEMENT |
| name | Tag name |
| ns | Namespace |

#### GETDATA 函数

此函数为重载函数。其具体功能形式随语法声明一并说明。
语法
获取实现此接口的节点的字符数据（另请参阅：DOMCharacterData Subprograms）：
```
DBMS_XMLDOM.GETDATA(
   cd      IN    DOMCHARACTERDATA)
 RETURN VARCHAR2;
```
返回 `DOMProcessingInstruction` 的内容数据（另请参阅：DOMProcessingInstruction Subprograms）：
```
DBMS_XMLDOM.GETDATA(
   pi      IN    DOMPROCESSINGINSTRUCTION)
 RETURN VARCHAR2;
```
参数
Table 213-49 GETDATA Function Parameters
| Parameter | Description |
|---|---|
| cd | DOMCHARACTERDATA |
| pi | The DOMPROCESSINGINSTRUCTION |

#### GETDOCTYPE Function

此函数返回与 `DOMDOCUMENT` 关联的 DTD。
另请参阅：
DOMDocument 子程序
语法
```
DBMS_XMLDOM.GETDOCTYPE(
   doc      IN     DOMDOCUMENT)
RETURN DOMDOCUMENTTYPE;
```
参数
表 213-50 GETDOCTYPE Function 参数
| Parameter | Description |
|---|---|
| doc | DOMDOCUMENT |

#### GETDOCUMENTELEMENT 函数

此函数返回 `DOMDOCUMENT` 的根元素。
另请参阅：
DOMDocument 子程序
语法
```
DBMS_XMLDOM.GETDOCUMENTELEMENT(
   doc      IN      DOMDOCUMENT)
 RETURN DOMELEMENT;
```
参数
Table 213-51 GETDOCUMENTELEMENT 函数参数
| Parameter | Description |
|---|---|
| doc | DOMDOCUMENT |

#### GETELEMENTSBYTAGNAME Functions

此函数被重载。具体的功能形式将连同语法声明一起描述。
语法
返回具有指定 tagname 的所有元素的 `DOMNODELIST` （参见：DOMDocument Subprograms）：
```
DBMS_XMLDOM.GETELEMENTSBYTAGNAME(
   doc         IN      DOMDOCUMENT,
   tagname     IN      VARCHAR2)
 RETURN DOMNODELIST;
```
根据给定的标签名返回 `DOMELEMENT` 的子元素 （参见：DOMElement Subprograms）：
```
DBMS_XMLDOM.GETELEMENTSBYTAGNAME(
   elem      IN     DOMELEMENT,
   name      IN     VARCHAR2)
 RETURN DOMNODELIST;
```
根据给定的标签名和命名空间返回 `DOMELEMENT` 的子元素 （参见：DOMElement Subprograms）：
```
DBMS_XMLDOM.GETELEMENTSBYTAGNAME(
   elem      IN     DOMELEMENT,
   name      IN     VARCHAR2,
   ns        IN     VARCHAR2)
 RETURN DOMNODELIST;
```
参数
表 213-52 GETELEMENTSBYTAGNAME Function Parameters
| Parameter | Description |
|---|---|
| doc | DOMDOCUMENT |
| tagname | 要匹配的标签名 |
| elem | DOMELEMENT |
| name | 标签名；使用通配符(*)将匹配任何标签 |
| ns | 命名空间 |

#### GETENTITIES 函数

此函数检索包含 DTD 中声明的一般实体（包括外部和内部实体）的 `DOMNAMEDNODEMAP`。
另请参见：
DOMDocumentType 子程序
语法
```
DBMS_XMLDOM.GETENTITIES(
   dt      IN     DOMDocumentType)
 RETURN DOMNAMEDNODEMAP;
```
参数
表 213-53 GETENTITIES 函数参数
| Parameter | Description |
|---|---|
| dt | DOMDOCUMENTTYPE |

#### GETEXPANDEDNAME 过程与函数

此子程序被重载为一个过程和两个函数。其具体功能形式与语法声明一并描述如下。
语法
如果 `Node` 属于 `Element` 或 `Attribute` 类型，则检索其扩展名称；否则，返回 `NULL`（另请参阅：DOMNode Subprograms）
```
DBMS_XMLDOM.GETEXPANDEDNAME(
   n       IN      DOMNODE
   data    OUT     VARCHAR);
```
返回 `DOMAttr` 的扩展名称（另请参阅：DOMAttr Subprograms）：
```
DBMS_XMLDOM.GETEXPANDEDNAME(
   a       IN     DOMAttr)
 RETURN VARCHAR2;
```
返回 `DOMElement` 的扩展名称（另请参阅：DOMElement Subprograms）：
```
DBMS_XMLDOM.GETEXPANDEDNAME(
   elem      IN    DOMELEMENT)
 RETURN VARCHAR2;
```
参数
表 213-54 GETEXPANDEDNAME 过程与函数参数
| Parameter | Description |
|---|---|
| n | DOMNODE |
| data | 返回的 Node 扩展名称 |
| a | DOMATTR |
| elem | DOMELEMENT |

#### GETFIRSTCHILD 函数

此函数检索此节点的第一个子节点。如果不存在这样的节点，则返回 `NULL`。
另请参阅：
DOMNode 子程序
语法
```
DBMS_XMLDOM.GETFIRSTCHILD(
   n      IN      DOMNODE)
 RETURN DOMNODE;
```
参数
表 213-55 GETFIRSTCHILD 函数参数
| 参数 | 说明 |
|---|---|
| n | DOMNODE |

#### GETIMPLEMENTATION 函数

此函数返回处理此 `DOMDOCUMENT` 的 `DOMIMPLEMENTATION` 对象。
另请参见：
DOMDocument 子程序
语法
```
DBMS_XMLDOM.GETIMPLEMENTATION(
   doc      IN     DOMDOCUMENT)
 RETURN DOMIMPLEMENTATION;
```
参数
表 213-56 GETIMPLEMENTATION 函数参数
| Parameter | Description |
|---|---|
| doc | DOMDOCUMENT |

#### GETLASTCHILD Function

该函数检索此节点的最后一个子节点。如果不存在此类节点，则返回 `NULL`。
另请参阅：
DOMNode Subprograms
语法
```
DBMS_XMLDOM.GETLASTCHILD(
   n     IN   DOMNODE)
 RETURN DOMNODE;
```
参数
Table 213-57 GETLASTCHILD Function Parameters
| Parameter | Description |
|---|---|
| n | DOMNODE |

#### GETLENGTH 函数

此函数为重载函数。其具体的功能形式随语法声明一同说明。
语法
获取数据中的字符数。该值可能为零，因为 CharacterData 节点可以为空（另请参见：DOMCharacterData 子程序）：
```
DBMS_XMLDOM.GETLENGTH(
   cd     IN     DOMCHARACTERDATA)
 RETURN NUMBER;
```
获取此映射中的节点数。有效的子节点索引范围是 `0` 到 `length-1`（包含边界）（另请参见：DOMNamedNodeMap 子程序）：
```
DBMS_XMLDOM.GETLENGTH(
   nnm      IN     DOMNAMEDNODEMAP)
 RETURN NUMBER;
```
获取列表中的节点数。有效的子节点索引范围是 `0` 到 `length-1`（包含边界）（另请参见：DOMNodeList 子程序）：
```
DBMS_XMLDOM.GETLENGTH(
   nl     IN    DOMNODELIST)
 RETURN NUMBER;
```
参数
表 213-58 GETLENGTH 函数参数
| Parameter | Description |
|---|---|
| cd | DOMCHARACTERDATA |
| nnm | DOMNAMEDNODEMAP |
| nl | DOMNODELIST |

#### GETLOCALNAME 过程与函数

此函数被重载为一个过程和两个函数。具体的功能形式与语法声明一并说明。
语法
获取节点限定名称的本地部分（另请参阅：DOMNode Subprograms）：
```
DBMS_XMLDOM.GETLOCALNAME(
   n       IN     DOMNODE,
   data    OUT    VARCHAR2);
```
返回 `DOMAttr` 的本地名称（另请参阅：DOMAttr Subprograms）：
```
DBMS_XMLDOM.GETLOCALNAME(
   a       IN     DOMATTR)
 RETURN VARCHAR2;
```
返回 `DOMElement` 的本地名称（另请参阅：DOMElement Subprograms）
```
DBMS_XMLDOM.GETLOCALNAME(
   elem       IN     DOMELEMENT)
 RETURN VARCHAR2;
```
参数
表 213-59 GETLOCALNAME 过程与函数参数
| Parameter | Description |
|---|---|
| n | DOMNode |
| data | 返回的本地名称。 |
| a | DOMAttr. |
| elem | DOMElement. |

#### GETNAME 函数

此函数为重载函数。其具体功能形式将在语法声明中予以说明。
语法
返回此属性的名称（另请参阅：DOMAttr Subprograms）：
```
DBMS_XMLDOM.GETNAME(
   a       IN     DOMATTR)
 RETURN VARCHAR2;
```
检索 DTD 的名称，即紧跟在 `DOCTYPE` 关键字之后的名称（另请参阅：DOMDocumentType Subprograms）：
```
DBMS_XMLDOM.GETNAME(
   dt       IN     DOMDOCUMENTTYPE)
 RETURN VARCHAR2;
```
参数
Table 213-60 GETNAME Function 参数
| Parameter | Description |
|---|---|
| a | DOMATTR |
| dt | DOMDOCUMENTTYPE |

#### GETNAMEDITEM Function

`GETNAMEDITEM` 检索由名称指定的节点。
另请参阅：
DOMNamedNodeMap Subprograms
语法
检索由名称指定的节点：
```
DBMS_XMLDOM.GETNAMEDITEM(
   nnm    IN  DOMNAMEDNODEMAP,
   name   IN  VARCHAR2)
 RETURN DOMNODE;
```
检索由名称和命名空间 URI 指定的节点：
```
DBMS_XMLDOM.GETNAMEDITEM(
   nnm    IN  DOMNAMEDNODEMAP,
   name   IN  VARCHAR2,
   ns     IN  VARCHAR2)
 RETURN DOMNODE;
```
参数
Table 213-61 GETNAMEDITEM Function Parameters
| Parameter | Description |
|---|---|
| nnm | DOMNAMEDNODEMAP |
| name | 要检索的项目的名称 |
| ns | 命名空间 |

#### GETNAMESPACE 过程与函数

此子程序被重载为一个过程和两个函数。具体的功能形式与语法声明一并说明。
语法
检索与该节点关联的命名空间 URI（参见：DOMNode Subprograms）：
```
DBMS_XMLDOM.GETNAMESPACE(
   n       IN     DOMNODE,
   data    OUT    VARCHAR2);
```
检索 `DOMATTR` 的命名空间（参见：DOMAttr Subprograms）：
```
DBMS_XMLDOM.GETNAMESPACE(
   a       IN     DOMATTR)
 RETURN VARCHAR2;
```
检索 `DOMELEMENT` 的命名空间（参见：DOMElement Subprograms）：
```
DBMS_XMLDOM.GETNAMESPACE(
   elem       IN     DOMELEMENT)
 RETURN VARCHAR2;
```
参数
表 213-62 GETNAMESPACE 过程与函数参数
| Parameter | Description |
|---|---|
| n | DOMNODE |
| data | 返回的命名空间 URI |
| a | DOMATTR |
| elem | DOMELEMENT |

#### GETNEXTSIBLING 函数

此函数检索紧随此节点之后的节点。如果没有这样的节点，则返回 `NULL`。
另请参见：
DOMNode 子程序
语法
```
DBMS_XMLDOM.GETNEXTSIBLING(
   n       IN     DOMNODE)
 RETURN DOMNode;
```
参数
表 213-63 GETNEXTSIBLING 函数参数
| 参数 | 描述 |
|---|---|
| n | DOMNODE |

#### GETNODETYPE 函数

此函数检索表示底层对象类型的代码。
另请参阅：
DOMNode 子程序
语法
```
DBMS_XMLDOM.GETNODETYPE(
   n       IN     DOMNODE)
 RETURN NUMBER;
```
参数
表 213-64 GETNODETYPE 函数参数
| 参数 | 描述 |
|---|---|
| n | DOMNODE |

#### GETNODENAME 函数

该函数根据节点的类型获取节点的名称。
另请参阅：
DOMNode 子程序
语法
```
DBMS_XMLDOM.GETNODENAME(
   n       IN     DOMNODE)
 RETURN VARCHAR2;
```
参数
表 213-65 GETNODENAME 函数参数
| 参数 | 说明 |
|---|---|
| n | DOMNODE |

#### GETNODEVALUE Function

此函数根据节点的类型获取该节点的值。
另请参阅：
DOMNode Subprograms
语法
```
DBMS_XMLDOM.GETNODEVALUE(
   n       IN     DOMNODE)
 RETURN VARCHAR2;*
```
参数
Table 213-66 GETNODEVALUE Function Parameters
| Parameter | Description |
|---|---|
| n | DOMNODE |

#### GETNODEVALUEASBINARYSTREAM Function & Procedure

这些子程序的操作将通过每种语法实现进行说明。
另请参阅：
DOMNode Subprograms
语法
此函数返回 PL/SQL `XMLBinaryInputStream` 的一个实例。节点数据类型必须为 `RAW` 或 `BLOB` – 否则会引发异常。
```
DBMS_XMLDOM.GETNODEVALUEASBINARYSTREAM (
   n      IN     DOMNODE)
 RETURN SYS.UTL_BINARYINPUTSTREAM;
```
使用此过程时，应用程序将传递一个 `SYS`.`UTL_BINARYOUTPUTSTREAM` 的实现，XDB 会将节点内容写入其中。节点的数据类型必须为 `RAW` 或 `CLOB` – 否则会引发异常。
```
DBMS_XMLDOM.GETNODEVALUEASBINARYSTREAM (
   n        in   DOMNODE,
   value    in   SYS.UTL_BINARYOUTPUTSTREAM);
```
参数
表 213-67 GETNODEVALUEASBINARYSTREAM Function & Procedure 参数
| Parameter | Description |
|---|---|
| n | DOMNODE |
| value | BINARYOUTPUTSTREAM |

#### GETNODEVALUEASCHARACTERSTREAM Function & Procedure

这些子程序的操作将在每种语法实现中予以说明。
另请参阅：
DOMNode Subprograms
语法
此函数返回 PL/SQL `XMLCharacterInputStream` 的一个实例。如果节点数据为字符类型，则将其转换为当前会话的字符集。如果节点数据不是字符数据，则首先将其转换为字符数据。
```
DBMS_XMLDOM.GETNODEVALUEASCHARACTERSTREAM  (
   n        IN     DOMNODE)
 RETURN SYS.UTL_CHARACTERINPUTSTREAM;
```
使用此过程时，节点数据会根据需要转换为会话字符集，然后被“推入” `SYS`.`UTL_CHARACTEROUTPUTSTREAM`。
```
DBMS_XMLDOM.GETNODEVALUEASCHARACTERSTREAM  (
   n        IN   DOMNODE,
   value    IN   SYS.UTL_CHARACTEROUTPUTSTREAM);
```
参数
表 213-68 GETNODEVALUEASCHARACTERSTREAM Function & Procedure Parameters
| Parameter | Description |
|---|---|
| n | DOMNODE |
| value | CHARACTEROUTPUTSTREAM |

#### GETNOTATIONNAME 函数

此函数返回 `DOMENTITY` 的 notation 名称。
另请参阅：
DOMEntity 子程序
语法
```
DBMS_XMLDOM.GETNOTATIONNAME(
   ent       IN     DOMENTITY)
 RETURN VARCHAR2;
```
参数
表 213-69 GETNOTATIONNAME 函数参数
| Parameter | Description |
|---|---|
| ent | DOMENTITY |

#### GETNOTATIONS Function

此函数检索包含 DTD 中所声明记法的 `DOMNAMEDNODEMAP`。
另请参见：
DOMDocumentType Subprograms
语法
```
DBMS_XMLDOM.GETNOTATIONS(
   dt       IN     DOMDOCUMENTTYPE)
 RETURN DOMNAMEDNODEMAP;
```
参数
表 213-70 GETNOTATIONS Function 参数
| Parameter | Description |
|---|---|
| dt | DOMDOCUMENTTYPE |

#### GETTARGET 函数

此函数返回 `DOMPROCESSINGINSTRUCTION` 的目标。
另请参阅：
DOMProcessingInstruction 子程序
语法
```
DBMS_XMLDOM.GETTARGET(
   pi       IN     DOMPROCESSINGINSTRUCTION)
 RETURN VARCHAR2;
```
参数
表 213-71 GETTARGET 函数参数
| Parameter | Description |
|---|---|
| pi | DOMPROCESSINGINSTRUCTION |

#### GETOWNERDOCUMENT 函数

此函数检索与此节点关联的 Document 对象。这也是用于创建新节点的 Document 对象。当此节点是一个 Document 或尚未与任何 Document 一起使用的 Document Type 时，该值为 `NULL`。
另请参阅：
DOMNode 子程序
语法
```
DBMS_XMLDOM.GETOWNERDOCUMENT(
   n       IN     DOMNODE)
 RETURN DOMDOCUMENT;
```
参数
Table 213-72 GETOWNERDOCUMENT 函数参数
| Parameter | Description |
|---|---|
| n | DOMNODE |

#### GETOWNERELEMENT 函数

此函数检索指定的 Attribute 所附加到的 Element 节点。
另请参阅：
DOMAttr 子程序
语法
```
DBMS_XMLDOM.GETOWNERELEMENT(
   a       IN     DOMATTR)
 RETURN DOMElement;
```
参数
表 213-73 GETOWNERELEMENT 函数参数
| Parameter | Description |
|---|---|
| a | Attribute |

#### GETPARENTNODE Function

此函数检索此节点的父节点。除 `Attr`、`Document`、`DocumentFragment`、`Entity` 和 `Notation` 外，所有节点都可以有父节点。但是，如果节点刚刚创建且尚未添加到树中，或者已从树中移除，则为 `NULL`。
另请参见：
DOMNode Subprograms
语法
```
DBMS_XMLDOM.GETPARENTNODE(
   n       IN     DOMNODE)
 RETURN DOMNODE;
```
参数
Table 213-74 GETPARENTNODE Function Parameters
| Parameter | Description |
|---|---|
| n | DOMNODE |

#### GETPREFIX 函数

此函数检索节点的命名空间前缀。
另请参见：
DOMNode 子程序
语法
```
DBMS_XMLDOM.GETPREFIX(
   n       IN     DOMNODE)
 RETURN VARCHAR2;
```
参数
表 213-75 GETPREFIX 函数参数
| 参数 | 描述 |
|---|---|
| n | DOMNODE |

#### GETPREVIOUSSIBLING 函数

此函数检索紧邻该节点之前的节点。如果没有这样的节点，则返回 `NULL`。
另请参阅：
DOMNode 子程序
语法
```
DBMS_XMLDOM.GETPREVIOUSSIBLING(
   n       IN     DOMNODE)
 RETURN DOMNODE;
```
参数
表 213-76 GETPREVIOUSSIBLING 函数参数
| Parameter | Description |
|---|---|
| n | DOMNODE |

#### GETPUBLICID 函数

此函数已重载。其具体功能形式随语法声明一并说明。
语法
返回指定 DTD 的公共标识符（另请参见：DOMDocumentType Subprograms）：
```
DBMS_XMLDOM.GETPUBLICID(
   dt       IN     DOMDOCUMENTTYPE)
 RETURN VARCHAR2;
```
返回 `DOMENTITY` 的公共标识符（另请参见：DOMEntity Subprograms）：
```
DBMS_XMLDOM.GETPUBLICID(
   ent      IN     DOMENTITY)
 RETURN VARCHAR2;
```
返回 `DOMNOTATION` 的公共标识符（另请参见：DOMNotation Subprograms）：
```
DBMS_XMLDOM.GETPUBLICID(
   n        IN     DOMNOTATION)
 RETURN VARCHAR2;
```
参数
表 213-77 GETPUBLICID 函数参数
| Parameter | Description |
|---|---|
| dt | DTD |
| ent | DOMENTITY |
| n | DOMNOTATION |

#### GETQUALIFIEDNAME 函数

此函数被重载。具体的功能形式将与语法声明一起描述。
语法
返回 `DOMATTR` 的限定名（另请参阅：DOMAttr Subprograms）：
```
DBMS_XMLDOM.GETQUALIFIEDNAME(
   a        IN     DOMATTR)
 RETURN VARCHAR2;
```
返回 `DOMElement` 的限定名（另请参阅：DOMElement Subprograms）：
```
DBMS_XMLDOM.GETQUALIFIEDNAME(
   elem     IN     DOMELEMENT)
 RETURN VARCHAR2;
```
参数
表 213-78 GETQUALIFIEDNAME 函数参数
| Parameter | Description |
|---|---|
| a | DOMATTR |
| elem | DOMELEMENT |

#### GETSCHEMANODE Function

此函数检索与该节点关联的 schema URI。
另请参见：
DOMNode Subprograms
语法
```
DBMS_XMLDOM.GETSCHEMANODE(
   n       IN     DOMNODE)
 RETURN DOMNODE;
```
参数
表 213-79 GETSCHEMANODE Function Parameters
| Parameter | Description |
|---|---|
| n | DOMNODE |

#### GETSPECIFIED 函数

如果该属性在原文档中被显式指定，则返回 true；否则返回 false。
另请参阅：
DOMAttr 子程序
语法
```
DBMS_XMLDOM.GETSPECIFIED(
   a       IN     DOMATTR)
 RETURN BOOLEAN;
```
参数
Table 213-80 GETSPECIFIED 函数参数
| Parameter | Description |
|---|---|
| a | DOMATTR |

#### GETSTANDALONE 函数

此函数返回与 `DOMDOCUMENT` 关联的 standalone 属性。
另请参见：
DOMDocument 子程序
语法
```
DBMS_XMLDOM.GETSTANDALONE(
   doc       IN     DOMDOCUMENT)
 RETURN VARCHAR2;
```
参数
表 213-81 GETSTANDALONE 函数参数
| 参数 | 描述 |
|---|---|
| doc | DOMDOCUMENT. |

#### GETSYSTEMID Functions

此函数为重载函数。其具体的功能形式连同语法声明一并描述。
语法
返回指定 DTD 的 system id（参见：DOMDocumentType Subprograms）：
```
DBMS_XMLDOM.GETSYSTEMID(
   dt       IN     DOMDOCUMENTTYPE)
 RETURN VARCHAR2;
```
返回 `DOMENTITY` 的 system identifier（参见：DOMEntity Subprograms）：
```
DBMS_XMLDOM.GETSYSTEMID(
   ent      IN     DOMENTITY)
 RETURN VARCHAR2;
```
返回 `DOMNOTATION` 的 system identifier（参见：DOMNotation Subprograms）：
```
DBMS_XMLDOM.GETSYSTEMID(
   n        IN     DOMNOTATION)
 RETURN VARCHAR2;
```
参数
Table 213-82 GETSYSTEMID Function Parameters
| Parameter | Description |
|---|---|
| dt | DTD。 |
| ent | DOMEntity。 |
| n | DOMNotation。 |

#### GETTAGNAME 函数

此函数返回 `DOMELEMENT` 的名称。
另请参阅：
DOMElement 子程序
语法
```
DBMS_XMLDOM.GETTAGNAME(
   elem       IN     DOMELEMENT)
 RETURN VARCHAR2;
```
参数
表 213-83 GETTAGNAME 函数参数
| Parameter | Description |
|---|---|
| elem | The DOMELEMENT |

#### GETVALUE 函数

此函数用于检索属性的值。
另请参见：
DOMAttr 子程序
语法
```
DBMS_XMLDOM.GETVALUE(
   a       IN     DOMATTR)
 RETURN VARCHAR2;
```
参数
表 213-84 GETVALUE 函数参数
| 参数 | 描述 |
|---|---|
| a | DOMATTR |

#### GETVERSION Function

此函数返回 `DOMDOCUMENT` 的版本。
另请参阅：
DOMDocument 子程序
语法
```
DBMS_XMLDOM.GETVERSION(
   doc       IN     DOMDOCUMENT)
 RETURN VARCHAR2;
```
参数
表 213-85 GETVERSION Function 参数
| Parameter | Description |
|---|---|
| doc | DOMDOCUMENT |

#### GETXMLTYPE 函数

此函数返回与 `DOMDOCUMENT` 关联的 `XMLType `。
另请参阅：
DOMDocument 子程序
语法
```
DBMS_XMLDOM.GETXMLTYPE(
   doc       IN     DOMDOCUMENT)
 RETURN SYS.XMLTYPE;
```
参数
表 213-86 GETXMLTYPE 函数参数
| Parameter | Description |
|---|---|
| doc | DOMDOCUMENT |

#### HASATTRIBUTE 函数

验证是否已为 `DOMELEMENT` 定义了属性，或是否具有默认值。
另请参阅：
DOMElement 子程序
语法
验证是否已为 `DOMElement` 定义了具有指定名称的属性：
```
DBMS_XMLDOM.HASATTRIBUTE(
   elem     IN  DOMELEMENT,
   name     IN  VARCHAR2)
 RETURN VARCHAR2;
```
验证是否已为 `DOMELEMENT` 定义了具有指定名称和命名空间 URI 的属性；已启用命名空间：
```
DBMS_XMLDOM.HASATTRIBUTE(
   elem     IN  DOMELEMENT,
   name     IN  VARCHAR2,
   ns       IN  VARCHAR2)
 RETURN VARCHAR2;
```
参数
表 213-87 HASATTRIBUTE 函数参数
| Parameter | Description |
|---|---|
| elem | 该 DOMELEMENT |
| name | 属性名称；* 匹配任何属性 |
| ns | 命名空间 |

#### HASATTRIBUTES 函数

此函数返回此节点是否具有任何属性。
另请参阅：
DOMNode 子程序
语法
```
DBMS_XMLDOM.HASATTRIBUTES(
   n       IN     DOMNODE)
 RETURN BOOLEAN;
```
参数
表 213-88 HASATTRIBUTES 函数参数
| Parameter | Description |
|---|---|
| n | DOMNODE |

#### HASCHILDNODES 函数

此函数用于判断该节点是否包含任何子节点。
另请参见：
DOMNode 子程序
语法
```
DBMS_XMLDOM.HASCHILDNODES(
   n       IN     DOMNODE)
 RETURN BOOLEAN;
```
参数
表 213-89 HASCHILDNODES 函数参数
| 参数 | 描述 |
|---|---|
| n | DOMNODE |

#### HASFEATURE Function

此函数用于测试 `DOMIMPLEMENTATION` 是否实现了特定功能。
另请参阅：
DOMImplementation Subprograms
语法
```
DBMS_XMLDOM.HASFEATURE(
   di       IN     DOMIMPLEMENTATION,
   feature  IN     VARCHAR2,
   version  IN     VARCHAR2)
 RETURN BOOLEAN;
```
参数
Table 213-90 HASFEATURE Function Parameters
| Parameter | Description |
|---|---|
| di | DOMIMPLEMENTATION |
| feature | 要检查的功能 |
| version | 要检查的 DOM 版本 |

#### IMPORTNODE 函数

此函数从外部文档导入一个节点，并返回该新节点。
另请参阅：
DOMNode 子程序
语法
```
DBMS_XMLDOM.IMPORTNODE(
   doc            IN  DOMDOCUMENT,
   importedNode   IN  DOMNODE,
   deep           IN  BOOLEAN)
  RETURN DOMNODE;
```
参数
表 213-91 IMPORTNODE 函数参数
| Parameter | Description |
|---|---|
| doc | 要从中导入节点的文档 |
| importedNode | 要导入的节点 |
| deep | 递归导入的设置。如果此值为 TRUE，则该节点的整个子树将随该节点一起导入。如果此值为 FALSE，则仅导入节点本身。 |
使用说明
请注意，ADOPTNODE 函数会从源文档中移除节点，而 IMPORTNODE 函数会克隆源文档中的节点。

#### INSERTBEFORE Function

此函数在已有的子节点 `refchild` 之前插入节点 `newchild`。如果 `refchild` 为 `NULL`，则将 `newchild` 插入到子节点列表的末尾。
如果 `newchild` 是一个 `DOCUMENTFRAGMENT` 对象，则其所有子节点将按相同的顺序插入到 `refchild` 之前。如果 `newchild` 已经存在于树中，则会先将其移除。
另请参阅：
DOMNode Subprograms
语法
```
DBMS_XMLDOM.INSERTBEFORE(
   n          IN     DOMNODE,
   newchild   IN     DOMNODE,
   refchild   IN     DOMNODE)
  RETURN DOMNode;
```
参数
Table 213-92 INSERTBEFORE Function Parameters
| Parameter | Description |
|---|---|
| n | DOMNODE |
| newChild | 要插入到 DOMNODE 中的子节点 |
| refChild | 用于在其之前插入 newchild 的引用节点 |

#### INSERTDATA 过程

此过程在指定的字符偏移量处插入字符串。
另请参见：
DOMCharacterData 子程序
语法
```
DBMS_XMLDOM.INSERTDATA(
   cd       IN     DOMCHARACTERDATA,
   offset   IN     NUMBER,
   arg      IN     VARCHAR2);
```
参数
表 213-93 INSERTDATA 过程参数
| Parameter | Description |
|---|---|
| cd | DOMCHARACTERDATA |
| offset | 插入数据的偏移量 |
| arg | 要插入的值 |

#### ISNULL 函数

此函数被重载。具体的功能形式连同语法声明一起说明。

语法

检查指定的 `DOMNODE` 是否为 `NULL`。如果是 `NULL` 则返回 `TRUE`，否则返回 `FALSE `（另请参见：DOMNode Subprograms）：
```
DBMS_XMLDOM.ISNULL(
  n        IN     DOMNODE)
 RETURN BOOLEAN;
```
检查指定的 `DOMATTR` 是否为 `NULL`；如果是 `NULL` 则返回 `TRUE`，否则返回 `FALSE`（另请参见：DOMAttr Subprograms）：
```
DBMS_XMLDOM.ISNULL(
   a       IN     DOMATTR)
 RETURN BOOLEAN;
```
检查指定的 `DOMCDATASECTION` 是否为 `NULL`；如果是 `NULL` 则返回 `TRUE`，否则返回 `FALSE`（另请参见：DOMCDataSection Subprograms）：
```
DBMS_XMLDOM.ISNULL(
   cds      IN     DOMCDATASECTION)
 RETURN BOOLEAN;
```
检查指定的 `DOMCHARACTERDATA` 是否为 `NULL`；如果是 `NULL` 则返回 `TRUE`，否则返回 `FALSE`（另请参见：DOMCharacterData Subprograms）：
```
DBMS_XMLDOM.ISNULL(
   cd       IN     DOMCHARACTERDATA)
 RETURN BOOLEAN;
```
检查指定的 `DOMCOMMENT` 是否为 `NULL`；如果是 `NULL` 则返回 `TRUE`，否则返回 `FALSE`（另请参见：DOMComment Subprograms）：
```
DBMS_XMLDOM.ISNULL(
   com       IN     DOMCOMMENT)
 RETURN BOOLEAN;
```
检查指定的 `DOMDOCUMENT` 是否为 `NULL`；如果是 `NULL` 则返回 `TRUE`，否则返回 `FALSE`（另请参见：DOMDocument Subprograms）：
```
DBMS_XMLDOM.ISNULL(
   doc       IN     DOMDOCUMENT)
 RETURN BOOLEAN;
```
检查指定的 `DOMDOCUMENTFRAGMENT` 是否为 `NULL`；如果是 `NULL` 则返回 `TRUE`，否则返回 `FALSE `（另请参见：DOMDocumentFragment Subprograms）：
```
DBMS_XMLDOM.ISNULL(
   df       IN     DOMDOCUMENTFRAGMENT)
 RETURN BOOLEAN;
```
检查指定的 `DOMDOCUMENTTYPE` 是否为 `NULL`；如果是 `NULL` 则返回 `TRUE`，否则返回 `FALSE`（另请参见：DOMDocumentType Subprograms）：
```
DBMS_XMLDOM.ISNULL(
   dt       IN     DOMDOCUMENTTYPE)
 RETURN BOOLEAN;
```
检查指定的 `DOMELEMENT` 是否为 `NULL`；如果是 `NULL` 则返回 `TRUE`，否则返回 `FALSE`（另请参见：DOMElement Subprograms）：
```
DBMS_XMLDOM.ISNULL(
   elem     IN     DOMELEMENT)
 RETURN BOOLEAN;
```
检查指定的 `DOMENTITY `是否为 `NULL`；如果是 `NULL` 则返回 `TRUE`，否则返回 `FALSE`（另请参见：DOMEntity Subprograms）：
```
DBMS_XMLDOM.ISNULL(
   ent       IN     DOMENTITY)
 RETURN BOOLEAN;
```
检查指定的 `DOMENTITYREFERENCE` 是否为 `NULL`；如果是 `NULL` 则返回 `TRUE`，否则返回 `FALSE`（另请参见：DOMEntityReference Subprograms）：
```
DBMS_XMLDOM.ISNULL(
   EREF       IN     DOMENTITYREFERENCE)
 RETURN BOOLEAN;
```
检查指定的 `DOMIMPLEMENTATION` 是否为 `NULL`；如果是 `NULL` 则返回 `TRUE`（另请参见：DOMImplementation Subprograms）：
```
DBMS_XMLDOM.ISNULL(
   di       IN     DOMIMPLEMENTATION)
 RETURN BOOLEAN;
```
检查指定的 `DOMNAMEDNODEMAP` 是否为 `NULL`；如果是 `NULL` 则返回 `TRUE`，否则返回 `FALSE`（另请参见：DOMNamedNodeMap Subprograms）：
```
DBMS_XMLDOM.ISNULL(
   nnm       IN     DOMNAMEDNODEMAP)
 RETURN BOOLEAN;
```
检查指定的 `DOMNODELIST` 是否为 `NULL`；如果是 `NULL` 则返回 `TRUE`，否则返回 `FALSE`（另请参见：DOMNodeList Subprograms）：
```
DBMS_XMLDOM.ISNULL(
   nl       IN     DOMNODELIST)
 RETURN BOOLEAN;
```
检查指定的 `DOMNOTATION` 是否为 `NULL`；如果是 `NULL` 则返回 `TRUE`，否则返回 `FALSE`（另请参见：DOMNotation Subprograms）：
```
DBMS_XMLDOM.ISNULL(
   n       IN     DOMNOTATION)
 RETURN BOOLEAN;
```
检查指定的 `DOMPROCESSINGINSTRUCTION` 是否为 `NULL`；如果是 NULL 则返回 `TRUE`，否则返回 `FALSE`（另请参见：DOMProcessingInstruction Subprograms）：
```
DBMS_XMLDOM.ISNULL(
   pi       IN     DOMPROCESSINGINSTRUCTION)
 RETURN BOOLEAN;
```
检查指定的 `DOMTEXT` 是否为 `NULL`；如果是 `NULL` 则返回 `TRUE`，否则返回 `FALSE`（另请参见：DOMText Subprograms）：
```
DBMS_XMLDOM.ISNULL(
   t       IN     DOMTEXT)
 RETURN BOOLEAN;
```

参数

Table 213-94 ISNULL Function Parameters
| Parameter | Description |
|---|---|
| n | 要检查的 DOMNODE |
| a | 要检查的 DOMATTR |
| cds | 要检查的 DOMCDATASECTION |
| cd | 要检查的 DOMCHARACTERDATA |
| com | 要检查的 DOMCOMMENT |
| doc | 要检查的 DOMDOCUMENT |
| dF | 要检查的 DOMDOCUMENTFRAGMENT |
| dt | 要检查的 DOMDOCUMENTTYPE |
| elem | 要检查的 DOMELEMENT |
| ent | 要检查的 DOMENTITY |
| eref | 要检查的 DOMENTITYREFERENCE |
| di | 要检查的 DOMIMPLEMENTATION |
| nnm | 要检查的 DOMNAMENODEMAP |
| nl | 要检查的 DOMNODELIST |
| n | 要检查的 DOMNOTATION |
| pi | 要检查的 DOMPROCESSINGINSTRUCTION |
| t | 要检查的 DOMTEXT |

#### ITEM 函数

此函数被重载。其具体功能形式与语法声明一并描述如下。
语法
返回 map 中与 `INDEX` 参数对应的项目。如果 `INDEX` 大于或等于此 map 中的节点数，则返回 `NULL` （参见：DOMNamedNodeMap Subprograms）：
```
DBMS_XMLDOM.ITEM(
   nnm       IN     DOMNAMEDNODEMAP,
   index     IN     NUMBER)
 RETURN DOMNODE;
```
返回集合中与 `INDEX` 参数对应的项目。如果 index 大于或等于列表中的节点数，则返回 `NULL` （参见：DOMNodeList Subprograms）：
```
DBMS_XMLDOM.ITEM(
   nl       IN     DOMNODELIST,
   index    IN     NUMBER)
 RETURN DOMNODE;
```
参数
Table 213-95 ITEM 函数参数
| Parameter | Description |
|---|---|
| nnm | DOMNAMEDNODEMAP |
| index | 要在其中检索项目的节点 map 中的索引 |
| nl | DOMNODELIST |
| index | 用于检索项目的 NodeList 中的索引 |

#### MAKEATTR 函数

此函数将指定的 `DOMNODE` 转换为 `DOMATTR`，并返回该 `DOMATTR`。
另请参阅：
DOMNode 子程序
语法
```
DBMS_XMLDOM.MAKEATTR(
   n       IN     DOMNODE)
 RETURN DOMATTR;
```
参数
Table 213-96 MAKEATTR Function Parameters
| Parameter | Description |
|---|---|
| n | 要转换的 DOMNODE |

#### MAKECDATASECTION Function

此函数将指定的 `DOMNODE` 转换为 `DOMCDATASECTION`。
另请参阅：
DOMNode Subprograms
语法
```
DBMS_XMLDOM.MAKECDATASECTION(
   n       IN     DOMNODE)
 RETURN DOMCDATASECTION;
```
参数
Table 213-97 MAKECDATASECTION Function Parameters
| Parameter | Description |
|---|---|
| n | DOMNODE to cast |

#### MAKECHARACTERDATA Function

此函数将指定的 `DOMNODE` 强制转换为 `DOMCHARACTERDATA`，并返回该 `DOMCHARACTERDATA`。
另请参见：
DOMNode Subprograms
语法
```
DBMS_XMLDOM.MAKECHARACTERDATA(
   n       IN     DOMNode)
 RETURN DOMCharacterData;
```
参数
Table 213-98 MAKECHARACTERDATA Function Parameters
| Parameter | Description |
|---|---|
| n | 要强制转换的 DOMNODE |

#### MAKECOMMENT 函数

此函数将指定的 `DOMNODE` 转换为 `DOMCOMMENT`，并返回该 `DOMCOMMENT`。
另请参阅：
DOMNode 子程序
语法
```
DBMS_XMLDOM.MAKECOMMENT(
   n       IN     DOMNODE)
 RETURN DOMCOMMENT;
```
参数
表 213-99 MAKECOMMENT 函数参数
| Parameter | Description |
|---|---|
| n | 要转换的 DOMNODE |

#### MAKEDOCUMENT 函数

此函数将指定的 `DOMNODE` 转换为 `DOMDOCUMENT`，并返回该 `DOMDOCUMENT`。
另请参见：
DOMNode 子程序
语法
```
DBMS_XMLDOM.MAKEDOCUMENT(
   n       IN     DOMNODE)
 RETURN DOMDocument;
```
参数
表 213-100 MAKEDOCUMENT 函数参数
| Parameter | Description |
|---|---|
| n | 要转换的 DOMNODE |

#### MAKEDOCUMENTFRAGMENT Function

此函数将指定的 `DOMNODE` 转换为 `DOMDOCUMENTFRAGMENT`，并返回 `DOMDOCUMENTFRAGMENT`。
另请参阅：
DOMNode Subprograms
语法
```
DBMS_XMLDOM.MAKEDOCUMENTFRAGMENT(
   n       IN     DOMNODE)
 RETURN DOMDOCUMENTFRAGMENT;
```
参数
Table 213-101 MAKEDOCUMENTFRAGMENT Function Parameters
| Parameter | Description |
|---|---|
| n | 要转换的 DOMNODE |

#### MAKEDOCUMENTTYPE Function

此函数将指定的 `DOMNODE` 转换为 `DOMDOCUMENTTYPE`，并返回该 `DOMDOCUMENTTYPE`。
另请参阅：
DOMNode 子程序
语法
```
DBMS_XMLDOM.MAKEDOCUMENTTYPE(
   n       IN     DOMNODE)
 RETURN DOMDOCUMENTTYPE;
```
参数
Table 213-102 MAKEDOCUMENTTYPE Function Parameters
| Parameter | Description |
|---|---|
| n | 要转换的 `DOMNODE`。 |

#### MAKEELEMENT 函数

此函数将指定的 `DOMNODE` 转换为 `DOMELEMENT`，并返回该 `DOMELEMENT`。
另请参阅：
DOMNode 子程序
语法
```
DBMS_XMLDOM.MAKEELEMENT(
   n       IN     DOMNODE)
 RETURN DOMELEMENT;
```
参数
表 213-103 MAKEELEMENT 函数参数
| Parameter | Description |
|---|---|
| n | 要转换的 DOMNODE |

#### MAKEENTITY 函数

此函数将指定的 `DOMNODE` 转换为 `DOMENTITY`，并返回该 `DOMENTITY`。
另请参阅：
DOMNode 子程序
语法
```
DBMS_XMLDOM.MAKEENTITY(
   n       IN     DOMNODE)
 RETURN DOMENTITY;
```
参数
表 213-104 MAKEENTITY 函数参数
| Parameter | Description |
|---|---|
| n | 要转换的 DOMNODE |

#### MAKEENTITYREFERENCE 函数

此函数将指定的 `DOMNODE` 转换为 `DOMENTITYREFERENCE`，并返回该 `DOMENTITYREFERENCE`。
另请参见：
DOMNode 子程序
语法
```
DBMS_XMLDOM.MAKEENTITYREFERENCE(
   n       IN     DOMNODE)
 RETURN DOMENTITYREFERENCE;
```
参数
表 213-105 MAKEENTITYREFERENCE 函数参数
| Parameter | Description |
|---|---|
| n | 要转换的 DOMNODE |

#### MAKENODE 函数

此函数已重载。具体的功能形式随语法声明一并说明。
语法
将指定的 `DOMATTR` 转换为 `DOMNODE`，并返回该 `DOMNODE`（另请参见：DOMAttr Subprograms）：
```
DBMS_XMLDOM.MAKENODE(
   a        IN     DOMATTR)
 RETURN DOMNODE;
```
将 `DOMCDATASECTION` 转换为 `DOMNODE`，并返回该 `DOMNODE`（另请参见：DOMCDataSection Subprograms）：
```
DBMS_XMLDOM.MAKENODE(
   cds      IN     DOMCDATASECTION)
 RETURN DOMNODE;
```
将指定的 `DOMCHARACTERDATA` 转换为 `DOMNODE`，并返回该 `DOMNODE`（另请参见：DOMCharacterData Subprograms）：
```
DBMS_XMLDOM.MAKENODE(
   cd       IN     DOMCHARACTERDATA)
 RETURN DOMNODE;
```
将指定的 `DOMCOMMENT` 转换为 `DOMNODE`，并返回该 `DOMNODE`（另请参见：DOMComment Subprograms）：
```
DBMS_XMLDOM.MAKENODE(
   com      IN     DOMCOMMENT)
 RETURN DOMNODE;
```
将 `DOMDOCUMENT` 转换为 `DOMNODE`，并返回该 `DOMNODE`（另请参见：DOMDocument Subprograms）：
```
DBMS_XMLDOM.MAKENODE(
   doc      IN     DOMDOCUMENT)
 RETURN DOMNODE;
```
将指定的 `DOMDOCUMENTFRAGMENT` 转换为 `DOMNODE`，并返回该 `DOMNODE`（另请参见：DOMDocumentFragment Subprograms）：
```
DBMS_XMLDOM.MAKENODE(
   df       IN     DOMDOCUMENTFRAGMENT)
 RETURN DOMNode;
```
将指定的 `DOMDOCUMENTTYPE` 转换为 `DOMNODE`，并返回该 `DOMNODE`（另请参见：DOMDocumentType Subprograms）：
```
DBMS_XMLDOM.MAKENODE(
   dt       IN     DOMDOCUMENTTYPE)
 RETURN DOMNODE;
```
将指定的 `DOMELEMENT` 转换为 `DOMNODE`，并返回该 `DOMNODE`（另请参见：DOMElement Subprograms）：
```
DBMS_XMLDOM.MAKENODE(
   elem       IN     DOMELEMENT)
 RETURN DOMNODE;
```
将指定的 `DOMENTITY` 转换为 `DOMNODE`，并返回该 `DOMNODE`（另请参见：DOMEntity Subprograms）：
```
DBMS_XMLDOM.MAKENODE(
   ent       IN     DOMENTITY)
 RETURN DOMNODE;
```
将 `DOMENTITYREFERENCE` 转换为 `DOMNODE`，并返回该 `DOMNODE`（另请参见：DOMEntityReference Subprograms）：
```
DBMS_XMLDOM.MAKENODE(
   eref       IN     DOMENTITYREFERENCE)
 RETURN DOMNODE;
```
将 `DOMNOTATION` 转换为 `DOMNODE`，并返回该 `DOMNODE`（另请参见：DOMNotation Subprograms）：
```
DBMS_XMLDOM.MAKENODE(
   n       IN     DOMNOTATION)
 RETURN DOMNODE;
```
将 `DOMPROCESSINGINSTRUCTION` 转换为 `DOMNODE`，并返回该 `DOMNODE`（另请参见：DOMProcessingInstruction Subprograms）：
```
DBMS_XMLDOM.MAKENODE(
   pi       IN     DOMPROCESSINGINSTRUCTION)
 RETURN DOMNODE;
```
将 `DOMTEXT` 转换为 `DOMNODE`，并返回该 `DOMNODE`（另请参见：DOMText Subprograms）：
```
DBMS_XMLDOM.MAKENODE(
   t       IN     DOMTEXT)
 RETURN DOMNODE;
```
参数
Table 213-106 MAKENODE Function Parameters
| Parameter | Description |
|---|---|
| a | 要转换的 DOMATTR |
| cds | 要转换的 DOMCDATASECTION |
| cd | 要转换的 DOMCHARACTERDATA |
| com | 要转换的 DOMCOMMENT |
| doc | 要转换的 DOMDOCUMENT |
| df | 要转换的 DOMDOCUMENTFRAGMENT |
| dt | 要转换的 DOMDOCUMENTTYPE |
| elem | 要转换的 DOMELEMENT |
| ent | 要转换的 DOMENTITY |
| eref | 要转换的 DOMENTITYREFERENCE |
| n | 要转换的 DOMNOTATION |
| pi | 要转换的 DOMPROCESSINGINSTRUCTION |
| t | 要转换的 DOMTEXT |

#### MAKENOTATION 函数

此函数将指定的 `DOMNODE` 转换为 `DOMNOTATION`，并返回该 `DOMNOTATION`。
另请参见：
DOMNode 子程序
语法
```
DBMS_XMLDOM.MAKENOTATION(
   n       IN     DOMNODE)
 RETURN DOMNOTATION;
```
参数
表 213-107 MAKENOTATION 函数参数
| Parameter | Description |
|---|---|
| n | 要转换的 DOMNODE |

#### MAKEPROCESSINGINSTRUCTION Function

此函数将指定的 `DOMNODE` 转换为 `DOMPROCESSINGINSTRUCTION`，并返回 `Domprocessinginstruction`。
另请参阅：
DOMNode 子程序
语法
```
DBMS_XMLDOM.MAKEPROCESSINGINSTRUCTION(
   n       IN     DOMNODE)
 RETURN DOMPROCESSINGINSTRUCTION;
```
参数
Table 213-108 MAKEPROCESSINGINSTRUCTION Function Parameters
| Parameter | Description |
|---|---|
| n | 要转换的 DOMNODE |

#### MAKETEXT 函数

此函数将指定的 `DOMNODE` 转换为 `DOMTEXT`，并返回该 `DOMTEXT`。
另请参阅：
DOMNode 子程序
语法
```
DBMS_XMLDOM.MAKETEXT(
   n       IN     DOMNODE)
 RETURN DOMTEXT;
```
参数
Table 213-109 MAKETEXT Function Parameters
| Parameter | Description |
|---|---|
| n | 要转换的 DOMNODE |

#### NEWDOMDOCUMENT 函数

此函数返回一个新的 `DOMDOCUMENT` 实例。
另请参见：
DOMDocument 子程序
语法
返回一个新的 `DOMDOCUMENT` 实例：
```
DBMS_XMLDOM.NEWDOMDOCUMENT
 RETURN DOMDOCUMENT;
```
返回一个根据指定 `XMLType` 对象创建的新 `DOMDOCUMENT` 实例：
```
DBMS_XMLDOM.NEWDOMDOCUMENT(
   xmldoc    IN SYS.XMLTYPE)
 RETURN DOMDOCUMENT;
```
返回一个根据指定 `CLOB` 创建的新 `DOMDOCUMENT` 实例：
```
DBMS_XMLDOM.NEWDOMDOCUMENT(
   cl       IN    CLOB)
 RETURN DOMDOCUMENT;
```
参数
表 213-110 NEWDOMDOCUMENT 函数参数
| Parameter | Description |
|---|---|
| xmldoc | DOMDOCUMENT 的 XMLType 源 |
| cl | DOMDOCUMENT 的 CLOB 源 |

#### NORMALIZE 过程

此过程规范化 `DOMELEMENT` 的文本子节点。
另请参见：
DOMElement 子程序
语法
```
DBMS_XMLDOM.NORMALIZE(
   elem       IN     DOMELEMENT);
```
参数
表 213-111 NORMALIZE 过程参数
| 参数 | 说明 |
|---|---|
| elem | DOMELEMENT |

#### REMOVEATTRIBUTE 过程

此过程根据名称从 `DOMELEMENT` 中移除属性。
另请参阅：
DOMElement 子程序
语法
根据名称移除 `DOMELEMENT` 的属性值：
```
DBMS_XMLDOM.REMOVEATTRIBUTE(
   elem     IN    DOMELEMENT,
   name     IN    VARCHAR2);
```
根据名称和命名空间 URI 移除 `DOMELEMENT` 的属性值。
```
DBMS_XMLDOM.REMOVEATTRIBUTE(
   elem     IN    DOMELEMENT,
   name     IN    VARCHAR2,
   ns       IN    VARCHAR2);
```
参数
Table 213-112 REMOVEATTRIBUTE Procedure Parameters
| Parameter | Description |
|---|---|
| elem | DOMELEMENT |
| name | 属性名称 |
| ns | 命名空间 |

#### REMOVEATTRIBUTENODE 函数

此函数从 `DOMELEMENT` 中移除指定的属性节点。该方法返回被移除的节点。
另请参阅：
DOMElement 子程序
语法
```
DBMS_XMLDOM.REMOVEATTRIBUTENODE(
   elem       IN     DOMELEMENT,
   oldAttr    IN     DOMATTR)
  RETURN DOMAttr;
```
参数
表 213-113 REMOVEATTRIBUTENODE 函数参数
| Parameter | Description |
|---|---|
| elem | The DOMELEMENT. |
| oldAttr | The old DOMATTR. |

#### REMOVECHILD Function

此函数从子节点列表中移除由 `oldchild` 指定的子节点，并将其返回。
另请参见：
DOMNode Subprograms
语法
```
DBMS_XMLDOM.REMOVECHILD(
   n          IN     DOMNode,
   oldchild   IN     DOMNode)
 RETURN DOMNODE;
```
参数
Table 213-114 REMOVECHILD Function Parameters
| Parameter | Description |
|---|---|
| n | DOMNODE |
| oldCHild | 需要移除的节点 n 的子节点 |

#### REMOVENAMEDITEM Function

此函数从 map 中移除由 name 指定的 node，并返回该 node。
当此 map 包含附加到 element 的 attributes 时，如果被移除的 attribute 具有已知的默认值，则会立即出现一个包含该默认值以及（在适用时）相应 namespace URI、local name 和 prefix 的 attribute。
另请参见：
DOMNamedNodeMap Subprograms
语法
移除由 name 指定的 node：
```
DBMS_XMLDOM.REMOVENAMEDITEM(
   nnm      IN     DOMNamedNodeMap,
   name     IN     VARCHAR2)
 RETURN DOMNode;
```
移除由 name 和 namespace URI 指定的 node：
```
DBMS_XMLDOM.REMOVENAMEDITEM(
   nnm      IN     DOMNamedNodeMap,
   name     IN     VARCHAR2,
   ns       IN     VARCHAR2)
 RETURN DOMNode;
```
参数
Table 213-115 REMOVENAMEDITEM Function Parameters
| Parameter | Description |
|---|---|
| nnm | DOMNamedNodeMap |
| name | 要从 map 中移除的 item 的 name |
| ns | Namespace |

#### REPLACECHILD 函数

此函数在子节点列表中用 `newchild` 替换子节点 `oldchild`，并返回 `oldchild` 节点。
如果 `newchild` 是一个 `DocumentFragment` 对象，则 `oldchild` 将被 `DocumentFragment` 的所有子节点替换，这些子节点按相同顺序插入。如果 `newchild` 已经存在于树中，则首先将其移除。
另请参阅：
DOMNode 子程序
语法
```
DBMS_XMLDOM.REPLACECHILD(
   n           IN     DOMNode,
   newchild    IN     DOMNode,
   oldchild    IN     DOMNode)
 RETURN DOMNode;
```
参数
Table 213-116 REPLACECHILD Function Parameters
| Parameter | Description |
|---|---|
| n | DOMNode |
| newchild | 要替换旧子节点的新子节点 |
| oldchild | 节点 n 中要被替换的子节点 |

#### REPLACEDATA 过程

此过程更改节点中的一系列字符。成功后，data 和 length 会反映此更改。
另请参见：
DOMCharacterData 子程序
语法
```
DBMS_XMLDOM.REPLACEDATA(
   cd        IN     DOMCHARACTERDATA,
   offset    IN     NUMBER,
   cnt       IN     NUMBER,
   arg       IN     VARCHAR2);
```
参数
表 213-117 REPLACEDATA 过程参数
| 参数 | 描述 |
|---|---|
| cd | DOMCHARACTERDATA |
| offset | 要替换的偏移量 |
| cnt | 要替换的字符数 |
| arg | 要替换为的值 |

#### RESOLVENAMESPACEPREFIX 函数

此函数解析指定的命名空间前缀，并返回解析后的命名空间。
另请参阅：
DOMElement 子程序
语法
```
DBMS_XMLDOM.RESOLVENAMESPACEPREFIX(
   elem       IN     DOMELEMENT,
   prefix     IN     VARCHAR2)
 RETURN VARCHAR2;
```
参数
表 213-118 RESOLVENAMESPACEPREFIX 函数参数
| Parameter | Description |
|---|---|
| elem | DOMELEMENT |
| prefix | 命名空间前缀 |

#### SETATTRIBUTE 过程

此过程通过名称设置 `DOMELEMENT` 属性的值。
另请参见：
DOMElement 子程序
语法
通过名称设置 `DOMELEMENT` 属性的值：
```
DBMS_XMLDOM.SETATTRIBUTE(
   elem       IN  DOMELEMENT,
   name       IN  VARCHAR2,
   newvalue   IN  VARCHAR2);
```
通过名称和命名空间 URI 设置 `DOMElement` 属性的值：
```
DBMS_XMLDOM.SETATTRIBUTE(
   elem       IN  DOMELEMENT,
   name       IN  VARCHAR2,
   newvalue   IN  VARCHAR2,
   ns         IN  VARCHAR2);
```
参数
表 213-119 SETATTRIBUTE 过程参数
| Parameter | Description |
|---|---|
| elem | `DOMELEMENT` |
| name | 属性名称 |
| newvalue | 属性值 |
| ns | 命名空间 |

#### SETATTRIBUTENODE 函数

此函数向 `DOMELEMENT` 添加一个新的属性节点。
另请参见：
DOMElement 子程序
语法
向 `DOMELEMENT` 添加一个新的属性节点：
```
DBMS_XMLDOM.SETATTRIBUTENODE(
   elem      IN  DOMELEMENT,
   newAttr   IN  DOMATTR)
 RETURN DOMATTR;
```
向 `DOMElement` 添加一个新的属性节点；启用命名空间：
```
DBMS_XMLDOM.SETATTRIBUTENODE(
   elem      IN  DOMELEMENT,
   newAttr   IN  DOMATTR,
   ns        IN  VARCHAR2)
 RETURN DOMATTR;
```
参数
表 213-120 SETATTRIBUTENODE 函数参数
| Parameter | Description |
|---|---|
| elem | DOMELEMENT |
| newAttr | 新的 DOMATTR |
| ns | 命名空间 |

#### SETCHARSET Procedure

此函数用于设置 DOM document 的字符集。
另请参见：
DOMDocument Subprograms
语法
```
DBMS_XMLDOM.SETCHARSET(
   doc      IN    DOMDocument,
   charset  IN    VARCHAR2);
```
参数
表 213-121 SETCHARSET Procedure Parameters
| 参数 | 描述 |
|---|---|
| doc | DOM document |
| charset | 字符集 |
使用说明
如果在调用 WRITETOFILE Procedures 时未显式指定字符集，则使用此字符集。

#### SETDATA 过程

此重载过程设置字符数据或 `DOMPROCESSINGINSTRUCTION` 的内容数据。具体功能在语法声明中描述。
语法
设置实现此接口的节点的字符数据（另请参阅：DOMCharacterData 子程序）：
```
DBMS_XMLDOM.SETDATA(
   cd       IN     DOMCHARACTERDATA,
   data     IN     VARCHAR2);
```
设置 `DOMPROCESSINGINSTRUCTION` 的内容数据（另请参阅：DOMProcessingInstruction 子程序）：
```
DBMS_XMLDOM.SETDATA(
   pi       IN     DOMPROCESSINGINSTRUCTION,
   data     IN     VARCHAR2);
```
参数
表 213-122 SETDATA 过程参数
| Parameter | Description |
|---|---|
| cd | DOMCHARACTERDATA |
| data | 节点要设置的数据 |
| pi | DOMPROCESSINGINSTRUCTION |
| data | 新的处理指令内容数据 |

#### SETDOCTYPE 过程

给定一个 DOM 文档，此过程使用指定的名称、系统 ID 和公共 ID 创建一个新的 DTD，并将其设置到该文档中。
此后可以使用 GETDOCTYPE 函数检索该 DTD。
语法
```
DBMS_XMLDOM.SETDOCTYPE(
  doc     IN   DOMDocument,
  name    IN   VARCHAR2,
  sysid   IN   VARCHAR2,
  pubid   IN   VARCHAR2);
```
参数
表 213-123 SETDOCTYPE 过程参数
| Parameter | Description |
|---|---|
| doc | 需要设置 DTD 的文档 |
| name | 初始化 doctype 所需的名称 |
| sysid | 初始化 doctype 所需的系统 ID |
| pubid | 初始化 doctype 所需的公共 ID |

#### SETNAMEDITEM Function

此函数使用节点的 `NodeName` 属性添加节点。
如果该 map 中已存在具有该名称的节点，则它将被新节点替换。替换时返回旧节点；如果未进行替换，则返回 `NULL`。
由于使用 `NodeName` 属性来派生节点的存储名称，因此某些具有“特殊”字符串值的特定类型的多个节点无法存储，因为名称会发生冲突。这被视为优于允许节点使用别名。
另请参见：
DOMNamedNodeMap Subprograms
语法
使用其 `NodeName` 属性添加节点：
```
DBMS_XMLDOM.SETNAMEDITEM(
   nnm     IN     DOMNAMEDNODEMAP,
   arg     IN     DOMNODE)
 RETURN DOMNode;
```
使用其 `NodeName` 属性和命名空间 URI 添加节点：
```
DBMS_XMLDOM.SETNAMEDITEM(
   nnm     IN     DOMNAMEDNODEMAP,
   arg      IN    DOMNODE,
   ns      IN     VARCHAR2)
 RETURN DOMNode;
```
参数
Table 213-124 SETNAMEDITEM Function Parameters
| Parameter | Description |
|---|---|
| nnm | DOMNAMEDNODEMAP |
| arg | 使用其 NodeName 属性要添加的节点 |
| ns | 命名空间 |

#### SETNODEVALUE 过程

此过程根据节点的类型设置该节点的值。当其定义为 `NULL` 时，对其进行设置无效。
另请参见：
DOMNode 子程序
语法
```
DBMS_XMLDOM.SETNODEVALUE(
   n         IN     DOMNODE,
   nodeValue IN     VARCHAR2);
```
参数
表 213-125 SETNODEVALUE 过程参数
| 参数 | 说明 |
|---|---|
| n | DOMNode |
| nodeValue | 节点要设置的值 |

#### SETNODEVALUEASBINARYSTREAM Function & Procedure

这些子程序的操作在语法部分进行说明。
另请参阅：
DOMNode Subprograms
语法
此函数返回一个 PL/SQL `XMLBINARYOUTPUTSTREAM` 实例，调用方可以向其中写入节点值。节点的数据类型必须是 `RAW` 或 `BLOB` – 否则将引发异常。
```
DBMS_XMLDOM.SETNODEVALUEASBINARYSTREAM (
   n      IN     DOMNODE)
 RETURN SYS.UTL_BINARYOUTPUTSTREAM;
```
使用此过程时，应用程序将传入一个 `sys`.`utl_BinaryInputStream` 的实现，XDB 将从中读取数据以填充节点。节点的数据类型必须是 `RAW` 或 BLOB – 否则将引发异常。
```
DBMS_XMLDOM.SETNODEVALUEASBINARYSTREAM (
   n        in   DOMNODE,
   value    in   SYS.UTL_BINARYINPUTSTREAM);
```
参数
表 213-126 SETNODEVALUEASBINARYSTREAM Function & Procedure 参数
| Parameter | Description |
|---|---|
| n | DOMNODE |
| value | BINARYINPUTSTREAM |

#### SETNODEVALUEASCHARACTERSTREAM Function & Procedure

这些子程序的用法在语法部分进行说明。
另请参见：
DOMNode Subprograms
语法
此函数返回一个 `XMLCHARACTEROUTPUTSTREAM` 类型的 PL/SQL 实例，调用方可向其写入节点值。节点的数据类型可以是任何有效的 XDB 数据类型。如果该类型不是字符类型或 `CLOB`，则写入流的字符数据将被转换为节点的数据类型。如果节点的数据类型是字符类型或 `CLOB`，则写入流的字符数据将从 PL/SQL 会话字符集转换为节点的字符集。
```
DBMS_XMLDOM.SETNODEVALUEASCHARACTERSTREAM  (
   n        IN     DOMNODE)
 RETURN SYS.UTL_CHARACTEROUTPUTSTREAM;
```
使用此过程时，应用程序传入一个 `SYS`.`UTL_CHARACTERINPUTSTREAM` 的实现，XDB 从中读取数据以填充该节点。节点的数据类型可以是 XDB 支持的任何有效类型。如果不是字符数据类型，则从流中读取的字符数据将被转换为该节点的数据类型。如果节点的数据类型是字符类型或 `CLOB`，则不进行转换，且该节点的字符集将变为 PL/SQL 会话的字符集。
```
DBMS_XMLDOM.SETNODEVALUEASCHARACTERSTREAM  (
   n        IN   DOMNODE,
   value    IN   SYS.UTL_CHARACTERINPUTSTREAM);
```
参数
表 213-127 SETNODEVALUEASCHARACTERSTREAM Function & Procedure 参数
| Parameter | Description |
|---|---|
| n | DOMNODE |
| value | CHARACTERINPUTSTREAM |

#### SETPREFIX 过程

此过程将此节点的 namespace prefix 设置为指定值。
另请参阅：
DOMNode 子程序
语法
```
DBMS_XMLDOM.SETPREFIX(
   n       IN     DOMNODE,
   prefix  IN     VARCHAR2);
```
参数
表 213-128 SETPREFIX 过程参数
| Parameter | Description |
|---|---|
| n | DOMNODE |
| prefix | 节点的 namespace prefix 的值 |

#### SETSTANDALONE 过程

此过程设置 `DOMDOCUMENT` 的 standalone 属性。
另请参阅：
DOMDocument 子程序
语法
```
DBMS_XMLDOM.SETSTANDALONE(
   doc         IN     DOMDOCUMENT,
   newvalue    IN     VARCHAR2);
```
参数
表 213-129 SETSTANDALONE 过程参数
| Parameter | Description |
|---|---|
| doc | DOMDOCUMENT |
| newvalue | 文档的 standalone 属性值 |

#### SETVALUE 过程

此过程用于设置属性的值。
另请参阅：
DOMAttr 子程序
语法
```
DBMS_XMLDOM.SETVALUE(
   a       IN     DOMATTR,
   value   IN     VARCHAR2);
```
参数
表 213-130 SETVALUE 过程参数
| Parameter | Description |
|---|---|
| a | DOMATTR |
| value | 要将属性设置为此值 |

#### SETVERSION 过程

此过程设置 `DOMDOCUMENT` 的 version。
另请参见：
DOMDocument 子程序
语法
```
DBMS_XMLDOM.SETVERSION(
   doc        IN     DOMDOCUMENT,
   version    IN     VARCHAR2);
```
参数
表 213-131 SETVERSION 过程参数
| Parameter | Description |
|---|---|
| doc | DOMDOCUMENT |
| version | 文档的 version |

#### SPLITTEXT Function

此函数在指定偏移量处将此 `DOMTEXT` 节点拆分为两个 `DOMTEXT` 节点。
另请参见：
DBMS_XMLDOM DOMText Subprograms
语法
```
DBMS_XMLDOM.SPLITTEXT(
   t        IN     DOMTEXT,
   offset   IN     NUMBER)
 RETURN DOMText;
```
参数
Table 213-132 SPLITTEXT Function Parameters
| Parameter | Description |
|---|---|
| t | DOMTEXT |
| offset | Offset at which to split |

#### SUBSTRINGDATA Function

此函数从节点中提取一段数据。
另请参阅：
DOMCharacterData 子程序
语法
```
DBMS_XMLDOM.SUBSTRINGDATA(
   cd        IN     DOMCHARACTERDATA,
   offset    IN     NUMBER,
   cnt       IN     NUMBER)
 RETURN VARCHAR2;
```
参数
表 213-133 SUBSTRINGDATA Function Parameters
| Parameter | Description |
|---|---|
| cd | DOMCHARACTERDATA |
| offset | 要获取的数据的起始偏移量 |
| cnt | 要获取的数据的字符数（从 offset 开始计算） |

#### USEBINARYSTREAM 函数

如果节点的数据类型为 `RAW` 或 `BLOB`，此函数返回 `TRUE`，以便可以使用 `UTL_BINARYINPUTSTREAM` 或 `UTL_BINARYOUTPUTSTREAM` 读取或写入节点值。
如果返回 `FALSE`，则只能通过 `UTL_CHARACTERINPUTSTREAM` 或 `UTL_CHARACTEROUTPUTSTREAM` 访问节点值。
另请参见：
DOMNode 子程序
语法
```
DBMS_XMLDOM.USEBINARYSTREAM   (
   n        IN     DOMNODE)
 RETURN BOOLEAN;
```
参数
表 213-134 USEBINARYSTREAM 函数参数
| Parameter | Description |
|---|---|
| n | DOMNODE |

#### WRITETOBUFFER 过程

`WRITETOBUFFER` 是一个重载过程，用于将 XML 节点、XML 文档或文档片段写入指定缓冲区。
此过程已重载。具体功能形式随语法声明一并说明。
语法
使用数据库字符集将 XML 节点写入指定缓冲区（另请参阅：DOMNode 子程序）：
```
DBMS_XMLDOM.WRITETOBUFFER(
   n        IN      DOMNODE,
   buffer   IN OUT  VARCHAR2);
```
使用数据库字符集将 XML 文档写入指定缓冲区（另请参阅：DOMDocument 子程序）：
```
DBMS_XMLDOM.WRITETOBUFFER(
   doc       IN      DOMDOCUMENT,
   buffer    IN OUT  VARCHAR2);
```
使用数据库字符集将指定文档片段的内容写入缓冲区（另请参阅：DOMDocumentFragment 子程序）：
```
DBMS_XMLDOM.WRITETOBUFFER(
   df        IN      DOMDOCUMENTFRAGMENT,
   buffer    IN OUT  VARCHAR2);
```
参数
表 213-135 WRITETOBUFFER 过程参数
| Parameter | Description |
|---|---|
| n | DOMNODE |
| buffer | 要写入的缓冲区 |
| doc | DOMDOCUMENT |
| df | DOM 文档片段 |

#### WRITETOCLOB 过程

`WRITETOCLOB` 是一个重载过程，用于将 XML 节点或文档写入指定的 `CLOB`。
下面介绍其具体功能形式及语法声明。
语法
使用数据库字符集将 XML 节点写入指定的 `CLOB`（参见：DOMNode 子程序）：
```
DBMS_XMLDOM.WRITETOCLOB(
   n       IN      DOMNODE,
   cl      IN OUT  CLOB);
```
使用数据库字符集将 XML 文档写入指定的 `CLOB`（参见：DOMDocument 子程序）：
```
DBMS_XMLDOM.WRITETOCLOB(
   doc     IN      DOMDOCUMENT,
   cl      IN OUT  CLOB);
```
参数
表 213-136 WRITETOCLOB 过程参数
| Parameter | Description |
|---|---|
| n | DOMNODE |
| cl | 要写入的 CLOB |
| doc | DOMDOCUMENT |

#### WRITETOFILE 过程

此重载过程将 XML 节点或 XML 文档写入指定节点。
具体的功能形式连同语法声明一起说明。
语法
使用数据库字符集将 XML 节点写入指定文件（另请参阅：DOMNode 子程序）：
```
DBMS_XMLDOM.WRITETOFILE(
   n          IN      DOMNODE,
   fileName   IN      VARCHAR2);
```
使用指定字符集将 XML 节点写入指定文件，该字符集作为单独的参数传入（另请参阅：DOMNode 子程序）：
```
DBMS_XMLDOM.WRITETOFILE(
   n          IN      DOMNODE,
   fileName   IN      VARCHAR2,
   charset    IN      VARCHAR2);
```
使用数据库字符集将 XML 文档写入指定文件（另请参阅：DOMDocument 子程序）：
```
DBMS_XMLDOM.WRITETOFILE(
   doc        IN   DOMDOCUMENT,
   filename   IN   VARCHAR2);
```
使用指定字符集将 XML 文档写入指定文件（另请参阅：DOMDocument 子程序）：
```
DBMS_XMLDOM.WRITETOFILE(
   doc       IN   DOMDOCUMENT,
   fileName  IN   VARCHAR2,
   charset   IN   VARCHAR2);
```
参数
表 213-137 WRITETOFILE 过程参数
| 参数 | 描述 |
|---|---|
| n | DOMNODE |
| fileName | 要写入的文件。文件名格式应为 database_directory_object_name/filename，例如 mydir/filename（在 Windows 上，使用 \ 代替 /）。 |
| charset | 指定字符集 |
| doc | DOMDOCUMENT |
| charset | 字符集 |
