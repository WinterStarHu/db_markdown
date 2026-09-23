# XML

XML 处理相关：DOM、解析、生成、通用。

---

## DBE_XML

DBE_XML支持的所有接口请参见表1：

| 接口名称 | 描述 |
|---|---|
| DBE_XML.XML_FREE_PARSER | 释放PARSER。 |
| DBE_XML.XML_PARSER_GET_DOC | 获取解析的document节点。 |
| DBE_XML.XML_GET_VALIDATION_MODE | 获取validate属性。 |
| DBE_XML.XML_NEW_PARSER | 新建PARSER实例。 |
| DBE_XML.XML_PARSE_BUFFER | 解析VARCHAR字符串。 |
| DBE_XML.XML_PARSE_CLOB | 解析CLOB字符串。 |
| DBE_XML.XML_SET_VALIDATION_MODE | 设置validate属性。 |
| DBE_XML.XML_DOM_APPEND_CHILD | 将newchild node添加到parent(n)节点最后面,并返回新添加的Node节点。 |
| DBE_XML.XML_DOM_CREATE_ELEMENT | 返回创建指定名称的DOMELEMENT对象。 |
| DBE_XML.XML_DOM_CREATE_ELEMENT_NS | 返回创建指定名称和命名空间的DOMELEMENT对象。 |
| DBE_XML.XML_DOM_CREATE_TEXT_NODE | 创建并返回DOMTEXT对象。 |
| DBE_XML.XML_DOM_FREE_DOCUMENT | 将指定的xmldom类型对象释放。 |
| DBE_XML.XML_DOM_FREE_ELEMENT | 将指定的xmldom类型对象释放。 |
| DBE_XML.XML_DOM_FREE_NODE | 释放DOMNODE节点。 |
| DBE_XML.XML_DOM_FREE_NODELIST | 释放DOMNODELIST节点。 |
| DBE_XML.XML_DOM_GET_ATTRIBUTE | 获取指定的xmldom类型对象的属性。 |
| DBE_XML.XML_DOM_GET_ATTRIBUTES | 将DOMNode节点属性值作为map返回。 |
| DBE_XML.XML_DOM_GET_CHILD_NODES | 将节点下的若干子节点转换成节点列表。 |
| DBE_XML.XML_DOM_GET_CHILDREN_BY_TAGNAME | 获取指定的xmldom类型对象指定子节点组成的列表。 |
| DBE_XML.XML_DOM_GET_CHILDREN_BY_TAGNAME_NS | 获取指定的xmldom类型对象指定命名空间指定子节点组成的列表。 |
| DBE_XML.XML_DOM_GET_DOCUMENT_ELEMENT | 返回指定DOCUMENT的首个子节点。 |
| DBE_XML.XML_DOM_GET_FIRST_CHILD | 返回node节点的第一个子节点。 |
| DBE_XML.XML_DOM_GET_LAST_CHILD | 返回node节点的最后一个子节点。 |
| DBE_XML.XML_DOM_GET_LENGTH | 根据类型节点中内容返回节点数。 |
| DBE_XML.XML_DOM_GET_LOCALNAME | 返回给定对象的本地名称。 |
| DBE_XML.XML_DOM_GET_NAMED_ITEM | 检索由名称指定的节点。 |
| DBE_XML.XML_DOM_GET_NAMED_ITEM_NS | 检索由名称和命名空间指定的节点。 |
| DBE_XML.XML_DOM_GET_NEXT_SIBLING | 返回该节点的下一个节点。 |
| DBE_XML.XML_DOM_GET_NODE_NAME | 返回节点的名称。 |
| DBE_XML.XML_DOM_GET_NODE_TYPE | 返回节点的类型。 |
| DBE_XML.XML_DOM_GET_NODE_VALUE | 返回NODE节点的值。 |
| DBE_XML.XML_DOM_GET_PARENT_NODE | 返回给定NODE节点的父节点。 |
| DBE_XML.XML_DOM_GET_TAGNAME | 获取指定的xmldom类型对象的标签名。 |
| DBE_XML.XML_DOM_HAS_CHILD_NODES | 检查DOMNODE对象是否拥有任一子节点。 |
| DBE_XML.XML_DOM_IMPORT_NODE | 该函数将节点复制到另一节点中，并将复制后的节点挂载到指定document中。 |
| DBE_XML.XML_DOM_IS_NULL | 判断给定对象是否为NULL。 |
| DBE_XML.XML_DOM_ITEM | 根据索引返回list或map中与索引对应的元素。 |
| DBE_XML.XML_DOM_MAKE_ELEMENT | 返回转换后的DOMELEMENT对象。 |
| DBE_XML.XML_DOM_MAKENODE | 将给定对象强制转换为DOMNODE类型。 |
| DBE_XML.XML_DOM_NEW_DOM_DOCUMENT_EMPTY | 返回新的DOMDOCUMENT对象。 |
| DBE_XML.XML_DOM_NEW_DOM_DOCUMENT_CLOB | 返回从指定的CLOB类型创建的新DOMDOCUMENT实例对象。 |
| DBE_XML.XML_DOM_NEW_DOCUMENT_XMLTYPE | 返回从指定的XMLType类型创建的新DOMDOCUMENT实例对象。 |
| DBE_XML.XML_DOM_SET_ATTRIBUTE | 设置指定的xmldom类型对象的属性。 |
| DBE_XML.XML_DOM_SET_CHARSET | 设置DOM设置DOMDOCUMENT的CHARSET字符集。 |
| DBE_XML.XML_DOM_SET_DOCTYPE | 设置DOMDOCUMENT的外部DTD。 |
| DBE_XML.XML_DOM_SET_NODE_VALUE | 此函数用于向DOMNODE对象中设置节点的值。 |
| DBE_XML.XML_DOM_WRITE_TO_BUFFER_DOC | 将给定的DOMDOCUMENT类型对象写入缓冲区。 |
| DBE_XML.XML_DOM_WRITE_TO_BUFFER_NODE | 将给定的DOMNODE类型对象写入缓冲区。 |
| DBE_XML.XML_DOM_WRITE_TO_CLOB_DOC | 将给定的DOMDOCUMENT类型对象写入Clob。 |
| DBE_XML.XML_DOM_WRITE_TO_CLOB_NODE | 将给定的DOMNODE类型对象写入Clob。 |
| DBE_XML.XML_DOM_WRITE_TO_FILE_DOC | 使用数据库字符集将XML节点写入指定文件。 |
| DBE_XML.XML_DOM_WRITE_TO_FILE_NODE | 使用数据库字符集将XML节点写入指定文件。 |
| DBE_XML.XML_DOM_GET_SESSION_TREE_NUM | 显示当前session中所有类型的dom树的数量。 |
| DBE_XML.XML_DOM_GET_DOC_TREES_INFO | 显示document类型的dom树的内存占用、节点数量等统计信息。 |
| DBE_XML.XML_DOM_GET_DETAIL_DOC_TREE_INFO | 显示特定的document变量的各类型节点数量。 |

```
DBE_XML.XML_FREE_PARSER(
id IN RAW(13))
returns VOID;
```

| 参数 | 类型 | 入参/出参 | 是否可以为空 | 描述 |
|---|---|---|---|---|
| id | RAW(13) | IN | 是 | 指定的parser类型对象。 |

- DBE_XML.XML_FREE_PARSER释放给定的PARSER对象。 DBE_XML.XML_FREE_PARSER的存储过程原型为：
```
DBE_XML.XML_PARSER_GET_DOC(
id IN RAW(13))
returns RAW(13);
```

| 参数 | 类型 | 入参/出参 | 是否可以为空 | 描述 |
|---|---|---|---|---|
| id | RAW(13) | IN | 是 | 指定的parser类型对象。 |

  - DBE_XML.XML_PARSER_GET_DOC函数传空，返回NULL。
  - DBE_XML.XML_PARSER_GET_DOC函数传入的parser还没有解析文档，返回NULL。
```
DBE_XML.XML_GET_VALIDATION_MODE(
id RAW(13))
returns BOOL;
```

| 参数 | 类型 | 入参/出参 | 是否可以为空 | 描述 |
|---|---|---|---|---|
| id | RAW(13) | IN | 是 | 指定的parser类型对象。 |

- DBE_XML.XML_GET_VALIDATION_MODE 获取给定Parser的解析验证模式。如果DTD验证开启返回TRUE，否则返回FALSE。 DBE_XML.XML_GET_VALIDATION_MODE的函数原型为：
```
DBE_XML.XML_NEW_PARSER()
RETURNS RAW(13);
```
- DBE_XML.XML_NEW_PARSER 新建Parser对象，返回一个新的解析器实例。 DBE_XML.XML_NEW_PARSER的函数原型为：
```
DBE_XML.XML_PARSE_BUFFER(
id RAW(13),
xmlstr VARCHAR2)
RETURNS VOID;
```

| 参数 | 类型 | 入参/出参 | 是否可以为空 | 描述 |
|---|---|---|---|---|
| id | RAW(13) | IN | 是 | 指定的parser类型对象。 |
| xmlstr | VARCHAR2 | IN | 否 | 存储XML文档的字符串。 |

  - xml_parse_buffer函数能够解析的字符串最大长度为32767，超过最大长度解析报错。
  - 与ORA数据库差异：字符串encoding只支持UTF-8；version字段只支持1.0，1.0-1.9解析警告但正常执行，1.9以上报错。
    - !ATTLIST to type (CHECK|check|Check) "Ch..."将报错，因默认值"Ch..."不属于括号中枚举值，而ORA数据库不报错。
    - <!ENTITY baidu "www.baidu.com">...... &Baidu;&writer将报错，因区分字母大小写，Baidu无法与baidu对应，而ORA数据库不报错。
  - 与ORA数据库命名空间校验差异：解析未声明的命名空间标签正常执行，而ORA数据库会报错。
  - 与ORA数据库xml预定义实体解析差异：&apos;&quot;会被解析转义为字符’”，而ORA数据库中预定义实体统一都没有转义为字符。
```
DBE_XML.XML_PARSE_CLOB(
id IN RAW(13),
doc IN CLOB)
returns VOID；
```

| 参数 | 类型 | 入参/出参 | 是否可以为空 | 描述 |
|---|---|---|---|---|
| id | RAW(13) | IN | 是 | 指定的parser类型对象。 |
| doc | CLOB | IN | 否 | 存储XML文档的字符串。 |

  - xml_parse_clob不支持解析大于1GB的CLOB。
  - 与ORA数据库差异：字符串encoding只支持UTF-8；version字段只支持1.0，1.0-1.9解析警告但正常执行，1.9以上报错。
    - !ATTLIST to type (CHECK|check|Check) "Ch..."将报错，因默认值"Ch..."不属于括号中枚举值，而ORA数据库不报错。
    - <!ENTITY baidu "www.baidu.com">...... &Baidu;&writer将报错，因区分字母大小写，Baidu无法与baidu对应，而ORA数据库不报错。
  - 与ORA数据库命名空间校验差异：解析未声明的命名空间标签正常执行，而ORA数据库会报错。
  - 与ORA数据库XML预定义实体解析差异：&apos;&quot;会被解析转义为字符’”，而ORA数据库中预定义实体统一都没有为字符。
```
DBE_XML.XML_SET_VALIDATION_MODE(
id RAW(13),
validate BOOLEAN)
returns VOID;
```

| 参数 | 类型 | 入参/出参 | 是否可以为空 | 描述 |
|---|---|---|---|---|
| id | RAW(13) | IN | 是 | 指定的parser类型对象。 |
| validate | BOOLEAN | IN | 是 | 要设置的模式：TRUE：开启DTD验证。FALSE：不开启验证。 |

  - DBE_XML.XML_SET_VALIDATION_MODE函数validate传入为空，不改变parser的解析验证模式。
  - parser初始化默认为开启DTD验证模式。
```
DBE_XML.XML_DOM_APPEND_CHILD(
    parentId IN RAW(13),
    childId IN RAW(13)
)
RETURNS RAW(13);
```

| 参数 | 类型 | 入参/出参 | 是否可以为空 | 描述 |
|---|---|---|---|---|
| parentId | RAW(13) | IN | 否 | 指定的xmldom类型对象。 |
| childId | RAW(13) | IN | 否 | 指定的xmldom类型对象。 |

- DBE_XML.XML_DOM_APPEND_CHILD将newchild node添加到parent(n)节点最后面,并返回新添加的Node节点。 DBE_XML.XML_DOM_APPEND_CHILD的存储过程原型为：
```
DBE_XML.XML_DOM_CREATE_ELEMENT(
    id IN RAW(13),
    tagname IN VARCHAR2
)
RETURNS RAW(13);
```

| 参数 | 类型 | 入参/出参 | 是否可以为空 | 描述 |
|---|---|---|---|---|
| id | RAW(13) | IN | 否 | 指定的xmldom类型对象。 |
| tagname | VARCHAR2 | IN | 否 | 新建的DOMELEMENT名称。 |

- DBE_XML.XML_DOM_CREATE_ELEMENT返回创建指定名称的DOMELEMENT对象。 DBE_XML.XML_DOM_CREATE_ELEMENT的函数原型为：
```
DBE_XML.XML_DOM_CREATE_ELEMENT_NS(
    id IN RAW(13),
    tagname IN VARCHAR2,
    ns IN VARCHAR2
)
RETURNS RAW(13);
```

| 参数 | 类型 | 入参/出参 | 是否可以为空 | 描述 |
|---|---|---|---|---|
| id | RAW(13) | IN | 否 | 指定的xmldom类型对象。 |
| tagname | VARCHAR2 | IN | 否 | 新建的DOMELEMENT名称。 |
| ns | VARCHAR2 | IN | 否 | 命名空间。 |

- DBE_XML.XML_DOM_CREATE_ELEMENT_NS返回创建指定名称和命名空间的DOMELEMENT对象。 DBE_XML.XML_DOM_CREATE_ELEMENT_NS的函数原型为：
```
DBE_XML.XML_DOM_CREATE_TEXT_NODE(
    id IN RAW(13),
    data IN VARCHAR2
)
RETURNS RAW(13);
```

| 参数 | 类型 | 入参/出参 | 是否可以为空 | 描述 |
|---|---|---|---|---|
| id | RAW(13) | IN | 否 | 指定的xmldom类型对象。 |
| data | VARCHAR2 | IN | 否 | 新建的DOMTEXT节点内容。 |

- DBE_XML.XML_DOM_CREATE_TEXT_NODE创建并返回DOMTEXT对象。 DBE_XML.XML_DOM_CREATE_TEXT_NODE的函数原型为：
```
DBE_XML.XML_DOM_FREE_DOCUMENT(
    id RAW(13)
)
RETURNS VOID;
```

| 参数 | 类型 | 入参/出参 | 是否可以为空 | 描述 |
|---|---|---|---|---|
| id | RAW(13) | IN | 否 | 指定的xmldom类型对象。 |

- DBE_XML.XML_DOM_FREE_DOCUMENT将指定的xmldom类型对象释放。 DBE_XML.XML_DOM_FREE_DOCUMENT的存储过程原型为：
```
DBE_XML.XML_DOM_FREE_ELEMENT (
    id RAW(13)
)
RETURNS VOID;
```

| 参数 | 类型 | 入参/出参 | 是否可以为空 | 描述 |
|---|---|---|---|---|
| id | RAW(13) | IN | 否 | 指定的xmldom类型对象。 |

- DBE_XML.XML_DOM_FREE_ELEMENT将指定的xmldom类型对象释放 DBE_XML.XML_DOM_FREE_ELEMENT的存储过程原型为：
```
DBE_XML.XML_DOM_FREE_NODE (
    id RAW(13)
)
RETURNS VOID;
```

| 参数 | 类型 | 入参/出参 | 是否可以为空 | 描述 |
|---|---|---|---|---|
| id | RAW(13) | IN | 否 | 指定的xmldom类型对象。 |

- DBE_XML.XML_DOM_FREE_NODE释放DOMNODE节点。 DBE_XML.XML_DOM_FREE_NODE的函数原型为：
```
DBE_XML.XML_DOM_FREE_NODELIST(
    id IN RAW(13)
)
RETURNS VOID
```

| 参数 | 类型 | 入参/出参 | 是否可以为空 | 描述 |
|---|---|---|---|---|
| id | RAW(13) | IN | 否 | 指定的xmldom类型对象。 |

- DBE_XML.XML_DOM_FREE_NODELIST释放DOMNODELIST节点 DBE_XML.XML_DOM_FREE_NODELIST的存储过程原型为：
```
DBE_XML.XML_DOM_GET_ATTRIBUTE (
    docid   IN  RAW(13),
    name    IN  VARCHAR2
)
RETURNS VARCHAR2;
```

| 参数 | 类型 | 入参/出参 | 是否可以为空 | 描述 |
|---|---|---|---|---|
| docid | RAW(13) | IN | 否 | 指定的xmldom类型对象。 |
| name | VARCHAR2 | IN | 否 | 字符串。 |

- DBE_XML.XML_DOM_GET_ATTRIBUTE获取指定的xmldom类型对象的属性 DBE_XML.XML_DOM_GET_ATTRIBUTE的存储过程原型为：
```
DBE_XML.XML_DOM_GET_ATTRIBUTES (
    id RAW(13)
)
RETURNS RAW(13);
```

| 参数 | 类型 | 入参/出参 | 是否可以为空 | 描述 |
|---|---|---|---|---|
| id | RAW(13) | IN | 否 | 指定的xmldom类型对象。 |

- DBE_XML.XML_DOM_GET_ATTRIBUTES将DOMNode节点属性值作为map返回。 DBE_XML.XML_DOM_GET_ATTRIBUTES的函数原型为：
```
DBE_XML.XML_DOM_GET_CHILD_NODES(
    id IN RAW(13)
)
RETURNS RAW(13);
```

| 参数 | 类型 | 入参/出参 | 是否可以为空 | 描述 |
|---|---|---|---|---|
| id | RAW(13) | IN | 否 | 指定的xmldom类型对象。 |

- DBE_XML.XML_DOM_GET_CHILD_NODES将节点下的若干子节点转换成节点列表 DBE_XML.XML_DOM_GET_CHILD_NODES的函数原型为：
```
DBE_XML.XML_DOM_GET_CHILDREN_BY_TAGNAME (
    docid   IN  RAW(13),
    name    IN  VARCHAR2
)
RETURNS RAW(13);
```

| 参数 | 类型 | 入参/出参 | 是否可以为空 | 描述 |
|---|---|---|---|---|
| docid | RAW(13) | IN | 否 | 指定的xmldom类型对象。 |
| name | VARCHAR2 | IN | 否 | 字符串。 |

- DBE_XML.XML_DOM_GET_CHILDREN_BY_TAGNAME获取指定的xmldom类型对象指定子节点组成的列表 DBE_XML.XML_DOM_GET_CHILDREN_BY_TAGNAME的存储过程原型为：
```
DBE_XML.XML_DOM_GET_CHILDREN_BY_TAGNAME_NS (
    docid   IN  RAW(13),
    name    IN  VARCHAR2,
    ns      IN  VARCHAR2
)
RETURNS RAW(13);
```

| 参数 | 类型 | 入参/出参 | 是否可以为空 | 描述 |
|---|---|---|---|---|
| docid | RAW(13) | IN | 否 | 指定的xmldom类型对象。 |
| name | VARCHAR2 | IN | 否 | 字符串。 |
| ns | VARCHAR2 | IN | 是 | 字符串。 |

- DBE_XML.XML_DOM_GET_CHILDREN_BY_TAGNAME_NS获取指定的xmldom类型对象指定命名空间指定子节点组成的列表 DBE_XML.XML_DOM_GET_CHILDREN_BY_TAGNAME_NS的存储过程原型为：
```
DBE_XML.XML_DOM_GET_DOCUMENT_ELEMENT(
    id  RAW(13)
)
RETURNS RAW(13);
```

| 参数 | 类型 | 入参/出参 | 是否可以为空 | 描述 |
|---|---|---|---|---|
| id | RAW(13) | IN | 否 | 指定的xmldom类型对象。 |

- DBE_XML.XML_DOM_GET_DOCUMENT_ELEMENT返回指定DOCUMENT的首个子节点。 DBE_XML.XML_DOM_GET_DOCUMENT_ELEMENT的存储过程原型为：
```
DBE_XML.XML_DOM_GET_FIRST_CHILD(
    id IN RAW(13)
)
RETURNS RAW(13);
```

| 参数 | 类型 | 入参/出参 | 是否可以为空 | 描述 |
|---|---|---|---|---|
| id | RAW(13) | IN | 否 | 指定的xmldom类型对象。 |

- DBE_XML.XML_DOM_GET_FIRST_CHILD返回node节点的第一个子节点。 DBE_XML.XML_DOM_GET_FIRST_CHILD的函数原型为：
```
DBE_XML.XML_DOM_GET_LAST_CHILD(
    id IN RAW(13)
)
RETURNS RAW(13);
```

| 参数 | 类型 | 入参/出参 | 是否可以为空 | 描述 |
|---|---|---|---|---|
| id | RAW(13) | IN | 否 | 指定的xmldom类型对象。 |

- DBE_XML.XML_DOM_GET_LAST_CHILD返回node节点的最后一个子节点。 DBE_XML.XML_DOM_GET_LAST_CHILD的函数原型为：
```
DBE_XML.XML_DOM_GET_LENGTH(
    id RAW(13)
)
RETURNS VOID;
```

| 参数 | 类型 | 入参/出参 | 是否可以为空 | 描述 |
|---|---|---|---|---|
| id | RAW(13) | IN | 是 | 指定的xmldom类型对象。 |

- DBE_XML.XML_DOM_GET_LENGTH根据类型节点中内容返回节点数。 DBE_XML.XML_DOM_GET_LENGTH的存储过程原型为：
```
DBE_XML.XML_DOM_GET_LOCALNAME (
    id  RAW(13)
)
RETURNS VARCHAR2;
```

| 参数 | 类型 | 入参/出参 | 是否可以为空 | 描述 |
|---|---|---|---|---|
| id | RAW(13) | IN | 是 | 指定的xmldom类型对象。 |

- DBE_XML.XML_DOM_GET_LOCALNAME返回给定对象的本地名称 DBE_XML.XML_DOM_GET_LOCALNAME的存储过程原型为：
```
DBE_XML.XML_DOM_GET_NAMED_ITEM(
    id IN RAW(13),
    nodeName IN VARCHAR2
)
RETURNS RAW(13);
```

| 参数 | 类型 | 入参/出参 | 是否可以为空 | 描述 |
|---|---|---|---|---|
| id | RAW(13) | IN | 否 | 指定的xmldom类型对象。 |
| nodeName | VARCHAR2 | IN | 否 | 要检索的元素的名称。 |

- DBE_XML.XML_DOM_GET_NAMED_ITEM检索由名称指定的节点 DBE_XML.XML_DOM_GET_NAMED_ITEM的函数原型为：
```
DBE_XML.XML_DOM_GET_NAMED_ITEM_NS(
    id  RAW(13),
    nodeName IN VARCHAR2,
    ns IN VARCHAR2
)
RETURNS RAW(13);
```

| 参数 | 类型 | 入参/出参 | 是否可以为空 | 描述 |
|---|---|---|---|---|
| id | RAW(13) | IN | 否 | 指定的xmldom类型对象。 |
| nodeName | VARCHAR2 | IN | 否 | 要检索的元素的名称。 |
| ns | VARCHAR2 | IN | 是 | 命名空间。 |

- DBE_XML.XML_DOM_GET_NAMED_ITEM_NS检索由名称和命名空间指定的节点 DBE_XML.XML_DOM_GET_NAMED_ITEM_NS的函数原型为：
```
DBE_XML.XML_DOM_GET_NEXT_SIBLING(
    id IN RAW(13)
)
RETURNS RAW(13);
```

| 参数 | 类型 | 入参/出参 | 是否可以为空 | 描述 |
|---|---|---|---|---|
| id | RAW(13) | IN | 否 | 指定的xmldom类型对象。 |

- DBE_XML.XML_DOM_GET_NEXT_SIBLING返回该节点的下一个节点。 DBE_XML.XML_DOM_GET_NEXT_SIBLING的函数原型为：
```
DBE_XML.XML_DOM_GET_NODE_NAME(
    id IN RAW(13)
)
RETURNS VARCHAR2;
```

| 参数 | 类型 | 入参/出参 | 是否可以为空 | 描述 |
|---|---|---|---|---|
| id | RAW(13) | IN | 否 | 指定的xmldom类型对象。 |

- DBE_XML.XML_DOM_GET_NODE_NAME返回节点的名称。 DBE_XML.XML_DOM_GET_NODE_NAME的函数原型为：
```
DBE_XML.XML_DOM_GET_NODE_TYPE(
    id IN RAW(13)
)
RETURNS INTEGER;
```

| 参数 | 类型 | 入参/出参 | 是否可以为空 | 描述 |
|---|---|---|---|---|
| id | RAW(13) | IN | 否 | 指定的xmldom类型对象。 |

- DBE_XML.XML_DOM_GET_NODE_TYPE返回节点的类型。 DBE_XML.XML_DOM_GET_NODE_TYPE的函数原型为：
```
DBE_XML.XML_DOM_GET_NODE_VALUE(
id IN RAW(13))
RETURNS VARCHAR2;
```

| 参数 | 类型 | 入参/出参 | 是否可以为空 | 描述 |
|---|---|---|---|---|
| id | RAW(13) | IN | 是 | 指定的xmldom类型对象。 |

- DBE_XML.XML_DOM_GET_NODE_VALUE 返回NODE节点的值。 DBE_XML.XML_DOM_GET_NODE_VALUE的存储过程原型为：
```
DBE_XML.XML_DOM_GET_PARENT_NODE(
id IN RAW(13))
RETURNS RAW(13);
```

| 参数 | 类型 | 入参/出参 | 是否可以为空 | 描述 |
|---|---|---|---|---|
| id | RAW(13) | IN | 是 | 指定的xmldom类型对象。 |

- DBE_XML.XML_DOM_GET_PARENT_NODE返回给定NODE节点的父节点。 DBE_XML.XML_DOM_GET_PARENT_NODE的存储过程原型为：
```
DBE_XML.XML_DOM_GET_TAGNAME (
    docid RAW(13)
)
RETURNS VARCHAR2;
```

| 参数 | 类型 | 入参/出参 | 是否可以为空 | 描述 |
|---|---|---|---|---|
| docid | RAW(13) | IN | 是 | 指定的xmldom类型对象。 |

- DBE_XML.XML_DOM_GET_TAGNAME获取指定的xmldom类型对象的标签名 DBE_XML.XML_DOM_GET_TAGNAME的存储过程原型为：
```
DBE_XML.XML_DOM_HAS_CHILD_NODES(
id IN RAW(13))
RETURNS BOOLEAN
```

| 参数 | 类型 | 入参/出参 | 是否可以为空 | 描述 |
|---|---|---|---|---|
| id | RAW(13) | IN | 是 | 指定的xmldom类型对象。 |

- DBE_XML.XML_DOM_HAS_CHILD_NODES检查DOMNODE对象是否拥有任一子节点。 DBE_XML.XML_DOM_HAS_CHILD_NODES的存储过程原型为：
```
DBE_XML.XML_DOM_IMPORT_NODE(
    doc_id IN RAW(13),
    node_id IN RAW(13),
    deep IN BOOLEAN
)
RETURNS RAW(13);
```

| 参数 | 类型 | 入参/出参 | 是否可以为空 | 描述 |
|---|---|---|---|---|
| doc_id | RAW(13) | IN | 否 | 节点挂载的文档。 |
| node_id | RAW(13) | IN | 否 | 将要导入的节点。 |
| deep | BOOLEAN | IN | 否 | 设置递归导入：如果为TRUE，则导入该节点及其所有子节点。如果为FALSE，则只导入节点本身。 |

- DBE_XML.XML_DOM_IMPORT_NODE该函数将节点复制到另一节点中，并将复制后的节点挂载到指定document中。若被复制节点的类型不属于xmldom的constants所规定的12种类型，则直接抛出类型不支持异常。 DBE_XML.XML_DOM_IMPORT_NODE的函数原型为：
```
DBE_XML.XML_DOM_IS_NULL (
    id  RAW(13)
)
RETURNS BOOLEAN;
```

| 参数 | 类型 | 入参/出参 | 是否可以为空 | 描述 |
|---|---|---|---|---|
| id | RAW(13) | IN | 是 | 指定的xmldom类型对象。 |

- DBE_XML.XML_DOM_IS_NULL判断给定对象是否为NULL，如果是则返回True，否则返回false。 DBE_XML.XML_DOM_IS_NULL的函数原型为：
```
DBE_XML.XML_DOM_ITEM (
    id IN RAW(13),
    index IN INTEGER
)
RETURNS RAW(13);
```

| 参数 | 类型 | 入参/出参 | 是否可以为空 | 描述 |
|---|---|---|---|---|
| id | RAW(13) | IN | 否 | 指定的xmldom类型对象。 |
| index | INTEGER | IN | 否 | 要检索的元素的索引。 |

- DBE_XML.XML_DOM_ITEM根据索引返回list或map中与索引对应的元素。 DBE_XML.XML_DOM_ITEM的函数原型为：
```
DBE_XML.XML_DOM_MAKE_ELEMENT(
id IN RAW(13))
RETURNS RAW(13)
```

| 参数 | 类型 | 入参/出参 | 是否可以为空 | 描述 |
|---|---|---|---|---|
| id | RAW(13) | IN | 否 | 指定的xmldom类型对象。 |

- DBE_XML.XML_DOM_MAKE_ELEMENT返回转换后的DOMELEMENT对象。 DBE_XML.XML_DOM_MAKE_ELEMENT的存储过程原型为：
```
DBE_XML.XML_DOM_MAKENODE(
   id    RAW(13)
)
RETURNS DOMNODE;
```

| 参数 | 类型 | 入参/出参 | 是否可以为空 | 描述 |
|---|---|---|---|---|
| id | RAW(13) | IN | 是 | 指定的xmldom类型对象。 |

- DBE_XML.XML_DOM_MAKENODE将给定对象强制转换为DOMNODE类型。 DBE_XML.XML_DOM_MAKENODE的存储过程原型为：
```
DBE_XML.XML_DOM_NEW_DOM_DOCUMENT_EMPTY()
RETURNS RAW(13);
```
- DBE_XML.XML_DOM_NEW_DOM_DOCUMENT_EMPTY返回新的DOMDOCUMENT对象。 DBE_XML.XML_DOM_NEW_DOM_DOCUMENT_EMPTY的函数原型为：
```
DBE_XML.XML_DOM_NEW_DOM_DOCUMENT_CLOB(
    content IN  CLOB
)
RETURNS RAW(13);
```

| 参数 | 类型 | 入参/出参 | 是否可以为空 | 描述 |
|---|---|---|---|---|
| content | CLOB | IN | 否 | 指定的CLOB类型。 |

- DBE_XML.XML_DOM_NEW_DOM_DOCUMENT_CLOB返回从指定的CLOB类型创建的新DOMDOCUMENT实例对象。 DBE_XML.XML_DOM_NEW_DOM_DOCUMENT_CLOB的函数原型为：
```
DBE_XML.XML_DOM_NEW_DOCUMENT_XMLTYPE(
    content IN  CLOB
)
RETURNS RAW(13);
```

| 参数 | 类型 | 入参/出参 | 是否可以为空 | 描述 |
|---|---|---|---|---|
| content | CLOB | IN | 否 | 指定的CLOB类型。 |

- DBE_XML.XML_DOM_NEW_DOCUMENT_XMLTYPE返回从指定的XMLType类型创建的新DOMDOCUMENT实例对象。 DBE_XML.XML_DOM_NEW_DOCUMENT_XMLTYPE的函数原型为：
```
DBE_XML.XML_DOM_SET_ATTRIBUTE(
    docid   IN  RAW(13),
    name    IN  VARCHAR2,
    value   IN  VARCHAR2
)
RETURNS void;
```

| 参数 | 类型 | 入参/出参 | 是否可以为空 | 描述 |
|---|---|---|---|---|
| id | RAW(13) | IN | 否 | 指定的xmldom类型对象。 |
| name | VARCHAR2 | IN | 否 | 字符串。 |
| value | VARCHAR2 | IN | 否 | 字符串。 |

- DBE_XML.XML_DOM_SET_ATTRIBUTE设置指定的xmldom类型对象的属性。 DBE_XML.XML_DOM_SET_ATTRIBUTE的存储过程原型为：
```
DBE_XML.XML_DOM_SET_CHARSET(
    id      IN RAW(13),
    charset IN VARCHAR2
)
RETURNS void;
```

| 参数 | 类型 | 入参/出参 | 是否可以为空 | 描述 |
|---|---|---|---|---|
| id | RAW(13) | IN | 否 | 指定的xmldom类型对象。 |
| charset | VARCHAR2 | IN | 否 | 字符集。 |

- DBE_XML.XML_DOM_SET_CHARSET设置DOMDOCUMENT的CHARSET字符集。 DBE_XML.XML_DOM_SET_CHARSET的函数原型为：
```
DBE_XML.XML_DOM_SET_DOCTYPE(
    id          IN  RAW(13),
    dtd_name    IN  VARCHAR2,
    system_id   IN  VARCHAR2,
    public_id   IN  VARCHAR2
)
RETURNS void;
```

| 参数 | 类型 | 入参/出参 | 是否可以为空 | 描述 |
|---|---|---|---|---|
| id | RAW(13) | IN | 否 | 指定的xmldom类型对象。 |
| dtd_name | VARCHAR2 | IN | 否 | 需要初始化doctype的名称。 |
| system_id | VARCHAR2 | IN | 否 | 需要初始化doctype的system ID。 |
| public_id | VARCHAR2 | IN | 否 | 需要初始化doctype的public ID。 |

- DBE_XML.XML_DOM_SET_DOCTYPE设置DOMDOCUMENT的外部DTD。 DBE_XML.XML_DOM_SET_DOCTYPE的函数原型为：
```
DBE_XML.XML_DOM_SET_NODE_VALUE(
id IN RAW(13),
node_value IN VARCHAR2)
RETURNS VOID
```

| 参数 | 类型 | 入参/出参 | 是否可以为空 | 描述 |
|---|---|---|---|---|
| id | RAW(13) | IN | 否 | 指定的xmldom类型对象。 |
| node_value | VARCHAR2 | IN | 否 | 向DOMNODE对象中设置的字符串。 |

- DBE_XML.XML_DOM_SET_NODE_VALUE此函数用于向DOMNODE对象中设置节点的值。 DBE_XML.XML_DOM_SET_NODE_VALUE的存储过程原型为：
```
DBE_XML.XML_DOM_WRITE_TO_BUFFER_DOC(
id IN RAW(13))
RETURNS VARCHAR2;
```

| 参数 | 类型 | 入参/出参 | 是否可以为空 | 描述 |
|---|---|---|---|---|
| id | RAW(13) | IN | 是 | 指定的xmldom类型对象。 |

- DBE_XML.XML_DOM_WRITE_TO_BUFFER_DOC将给定的DOMDOCUMENT类型对象写入缓冲区。 DBE_XML.XML_DOM_WRITE_TO_BUFFER_DOC的存储过程原型为：
```
DBE_XML.XML_DOM_WRITE_TO_BUFFER_NODE(
id IN RAW(13))
RETURNS VARCHAR2;
```

| 参数 | 类型 | 入参/出参 | 是否可以为空 | 描述 |
|---|---|---|---|---|
| id | RAW(13) | IN | 是 | 指定的xmldom类型对象。 |

- DBE_XML.XML_DOM_WRITE_TO_BUFFER_NODE将给定的DOMNODE类型对象写入缓冲区。 DBE_XML.XML_DOM_WRITE_TO_BUFFER_NODE的存储过程原型为：
```
DBE_XML.XML_DOM_WRITE_TO_CLOB_DOC(
    id IN RAW(13)
)
RETURNS VARCHAR2;
```

| 参数 | 类型 | 入参/出参 | 是否可以为空 | 描述 |
|---|---|---|---|---|
| id | RAW(13) | IN | 是 | 指定的xmldom类型对象。 |

- DBE_XML.XML_DOM_WRITE_TO_CLOB_DOC将给定的DOMDOCUMENT类型对象写入Clob。 DBE_XML.XML_DOM_WRITE_TO_CLOB_DOC的存储过程原型为：
```
DBE_XML.XML_DOM_WRITE_TO_CLOB_NODE(
    id          IN  RAW(13)
)
RETURNS CLOB;
```

| 参数 | 类型 | 入参/出参 | 是否可以为空 | 描述 |
|---|---|---|---|---|
| id | RAW(13) | IN | 是 | 指定的xmldom类型对象。 |

- DBE_XML.XML_DOM_WRITE_TO_CLOB_NODE将给定的DOMNODE类型对象写入Clob。 DBE_XML.XML_DOM_WRITE_TO_CLOB_NODE的存储过程原型为：
```
DBE_XML.XML_DOM_WRITE_TO_FILE_DOC(
id IN  RAW(13),
file_dir IN  VARCHAR2)
RETURNS VOID
DBE_XML.XML_DOM_WRITE_TO_FILE_DOC(
id IN  RAW(13),
file_dir IN  VARCHAR2,
charset  IN  VARCHAR2)
RETURNS VOID PACKAGE
```

| 参数 | 类型 | 入参/出参 | 是否可以为空 | 描述 |
|---|---|---|---|---|
| id | RAW(13) | IN | 是 | 指定的xmldom类型对象。 |
| file_dir | VARCHAR2 | IN | 否 | 要写入的文件。 |
| charset | VARCHAR2 | IN | 否 | 指定字符集。 |

- DBE_XML.XML_DOM_WRITE_TO_FILE_DOC使用数据库字符集将XML节点写入指定文件。 DBE_XML.XML_DOM_WRITE_TO_FILE_DOC的存储过程原型为：
```
DBE_XML.XML_DOM_WRITE_TO_FILE_NODE(
id IN  RAW(13),
filename IN  VARCHAR2)
RETURNS VOID
```

| 参数 | 类型 | 入参/出参 | 是否可以为空 | 描述 |
|---|---|---|---|---|
| id | RAW(13) | IN | 否 | 指定的xmldom类型对象。 |
| filename | VARCHAR2 | IN | 否 | 指定文件地址。 |

- DBE_XML.XML_DOM_WRITE_TO_FILE_NODE使用数据库字符集将XML节点写入指定文件。 DBE_XML.XML_DOM_WRITE_TO_FILE_NODE的存储过程原型为：
```
DBE_XML.XML_DOM_GET_SESSION_TREE_NUM()
RETURNS INTEGER
```
- DBE_XML.XML_DOM_GET_SESSION_TREE_NUM查询当前session中所有类型的dom树数量。 DBE_XML.XML_DOM_GET_SESSION_TREE_NUM的函数原型为：
```
DBE_XML.XML_DOM_GET_DOC_TREES_INFO()
RETURNS VARCHAR2
```
- DBE_XML.XML_DOM_GET_DOC_TREES_INFO查询当前session中Document类型的dom树信息，如内存占用等。 DBE_XML.XML_DOM_GET_DOC_TREES_INFO的函数原型为：
```
dbe_xml.xml_dom_get_detail_doc_tree_info(
id IN  RAW(13))
RETURNS VARCHAR2
```

| 参数 | 类型 | 入参/出参 | 是否可以为空 | 描述 |
|---|---|---|---|---|
| id | RAW(13) | IN | 否 | 指定的xmldom类型对象。 |

- DBE_XML.XML_DOM_GET_DETAIL_DOC_TREE_INFO查询传入的document内的各类型子节点的数量。 DBE_XML.XML_DOM_GET_DETAIL_DOC_TREE_INFO的函数原型为：
父主题：
基础接口
版权所有 © 华为技术有限公司
< 上一节



---


---

## DBE_XMLDOM

#### 接口介绍
高级功能包DBE_XMLDOM用于访问XMLType对象，实现DOM(Document Object Model)，用于访问HTML和XML DOCUMENTS API。高级功能包DBE_XMLDOM支持的所有类型请参见表1，DBE_XMLDOM支持的所有接口请参见表2。
DBE_XMLDOM高级包在字符集设置为SQL_ASCII的数据库内使用的情况下，输入超出ASCII范围的字符，会导致报错。

| 类型名称 | 描述 |
|---|---|
| DOMATTR | 实现DOM Attribute接口。 |
| DOMDOCUMENT | 实现DOM Document接口。 |
| DOMELEMENT | 实现DOM Element接口。 |
| DOMNAMEDNODEMAP | 实现DOM Named Node Map接口。 |
| DOMNODELIST | 实现DOM Node List接口。 |
| DOMNODE | 实现DOM Node接口。 |
| DOMTEXT | 实现DOM Text接口。 |
| 接口名称 | 描述 |
|---|---|
| DBE_XMLDOM.APPENDCHILD | 将newchild node添加到parent(n)节点最后面，并返回新添加的Node节点。 |
| DBE_XMLDOM.CREATEELEMENT | 创建指定名称的DOMELEMENT对象。 |
| DBE_XMLDOM.CREATETEXTNODE | 创建DOMTEXT节点。 |
| DBE_XMLDOM.FREEDOCUMENT | 释放DOMDOCUMENT节点相关资源。 |
| DBE_XMLDOM.FREEELEMENT | 释放DOMELEMENT节点相关资源。 |
| DBE_XMLDOM.FREENODE | 释放DOMNODE节点相关资源。 |
| DBE_XMLDOM.FREENODELIST | 释放DOMNODELIST节点相关资源。 |
| DBE_XMLDOM.GETATTRIBUTE | 按名称返回DOMELEMENT属性的值。 |
| DBE_XMLDOM.GETATTRIBUTES | 将DOMNODE节点属性值作为map返回。 |
| DBE_XMLDOM.GETCHILDNODES | 将节点下的若干子节点转换成节点列表。 |
| DBE_XMLDOM.GETCHILDRENBYTAGNAME | 按名称返回DOMELEMENT的子节点。 |
| DBE_XMLDOM.GETDOCUMENTELEMENT | 返回指定DOCUMENT的首个子节点。 |
| DBE_XMLDOM.GETFIRSTCHILD | 返回第一个子节点。 |
| DBE_XMLDOM.GETLASTCHILD | 返回最后一个子节点。 |
| DBE_XMLDOM.GETLENGTH | 获取给定节点中的节点个数。 |
| DBE_XMLDOM.GETLOCALNAME | 检索节点的本地名称。 |
| DBE_XMLDOM.GETNAMEDITEM | 检索由名称指定的节点。 |
| DBE_XMLDOM.GETNEXTSIBLING | 返回该节点的下一个节点。 |
| DBE_XMLDOM.GETNODENAME | 返回节点名称。 |
| DBE_XMLDOM.GETNODETYPE | 返回节点类型。 |
| DBE_XMLDOM.GETNODEVALUE | 此函数用于获取节点的值，具体取决于其类型。 |
| DBE_XMLDOM.GETPARENTNODE | 检索此节点的父节点。 |
| DBE_XMLDOM.GETTAGNAME | 返回指定DOMELEMENT的标签名称。 |
| DBE_XMLDOM.HASCHILDNODES | 检查DOMNODE对象是否拥有任一子节点。 |
| DBE_XMLDOM.IMPORTNODE | 复制节点并为该节点指定所属文档。 |
| DBE_XMLDOM.ISNULL | 检测节点是否为空。 |
| DBE_XMLDOM.ITEM | 返回映射中与索引参数对应的项。 |
| DBE_XMLDOM.MAKEELEMENT | 将DOMNODE对象转换为DOMELEMENT类型。 |
| DBE_XMLDOM.MAKENODE | 将节点强制转换为DOMNODE类型。 |
| DBE_XMLDOM.NEWDOMDOCUMENT | 返回新的DOMDOCUMENT对象。 |
| DBE_XMLDOM.SETATTRIBUTE | 按名称设置DOMELEMENT属性的值。 |
| DBE_XMLDOM.SETCHARSET | 设置DOMDOCUMENT的CHARSET字符集。 |
| DBE_XMLDOM.SETDOCTYPE | 设置DOMDOCUMENT的外部DTD。 |
| DBE_XMLDOM.SETNODEVALUE | 此函数用于向DOMNODE对象中设置节点的值。 |
| DBE_XMLDOM.WRITETOBUFFER | 将XML节点写入指定缓冲区。 |
| DBE_XMLDOM.WRITETOCLOB | 将XML节点写入指定CLOB。 |
| DBE_XMLDOM.WRITETOFILE | 将XML节点写入指定文件。 |
| DBE_XMLDOM.GETSESSIONTREENUM | 显示当前session中所有类型的dom树的数量。 |
| DBE_XMLDOM.GETDOCTREESINFO | 显示document类型的dom树的内存占用、节点数量等统计信息。 |
| DBE_XMLDOM.GETDETAILDOCTREEINFO | 显示特定的document变量的各类型节点数量。 |
| DBE_XMLDOM.GETELEMENTSBYTAGNAM | 返回匹配TAGNAME的DOMNODELIST节点列表。 |

```
DBE_XMLDOM.APPENDCHILD(
   n IN DOMNode,
   newchild IN DOMNode)
RETURN DOMNODE;
```

| 参数 | 描述 |
|---|---|
| n | 被添加的node。 |
| newchild | 添加的新node。 |

  - DOCUMENT类型节点下APPEND ATTR类型节点会报“operation not support”错误，ORA数据库在此场景下不报错，但实际并没有挂载成功。
  - ATTR类型节点下APPEND ATTR类型节点会报“operation not support”错误，ORA数据库在此场景下不报错，但实际并没有挂载成功。
  - 父节点在添加多个ATTR类型子节点时，不允许KEY值相同的子节点同时存在于同一个父节点下。
示例：
```
--为指定的DOC树添加DOMNODE节点，并通过DBE_XMLDOM.HASCHILDNODES()验证子节点是否添加成功。
DECLARE
    doc DBE_XMLDOM.DOMDocument;
    doc1 DBE_XMLDOM.DOMDocument;
    root DBE_XMLDOM.DOMElement;
    rootnode DBE_XMLDOM.DOMNode;
    child1 DBE_XMLDOM.DOMElement;
    child2 DBE_XMLDOM.DOMElement;
    attr DBE_XMLDOM.DOMAttr;
    text DBE_XMLDOM.DOMTEXT;
    node DBE_XMLDOM.DOMNode;
    child1_node DBE_XMLDOM.DOMNode;
    attr_node DBE_XMLDOM.DOMNode;
    parent DBE_XMLDOM.DOMNode;
    buf varchar2(1000);
BEGIN
    doc := DBE_XMLDOM.newDOMDocument();
    root := DBE_XMLDOM.createElement(doc, 'root');
    rootnode := DBE_xmldom.makeNode(root);
    node := DBE_XMLDOM.appendChild(DBE_xmldom.makeNode(doc), rootnode);
    child1 := DBE_XMLDOM.createElement(doc, 'child1');
    child1_node := DBE_XMLDOM.makeNode(child1);
    node := DBE_XMLDOM.appendChild(rootnode, child1_node);
    attr := DBE_XMLDOM.createAttribute(doc, 'abc');
    attr_node := DBE_XMLDOM.makeNode(attr);
    node := DBE_XMLDOM.appendChild(child1_node, attr_node);
    IF DBE_XMLDOM.HASCHILDNODES(child1_node) THEN
        DBE_OUTPUT.print_line('HAS CHILD NODES');
    ELSE
        DBE_OUTPUT.print_line('NOT HAS CHILD NODES ');
    END IF;
    parent := DBE_XMLDOM.GETPARENTNODE(attr_node);
    buf := DBE_XMLDOM.GETNODENAME(parent);
    DBE_OUTPUT.print_line(buf);
END;
/
-- 预期结果为：
NOT HAS CHILD NODES
ANONYMOUS BLOCK EXECUTE
```
```
DBE_XMLDOM.CREATEELEMENT(
   doc        IN      DOMDOCUMENT,
   tagName    IN      VARCHAR2)
 RETURN DOMELEMENT;
```
```
DBE_XMLDOM.CREATEELEMENT(
   doc        IN     DOMDOCUMENT,
   tagName    IN     VARCHAR2,
   ns         IN     VARCHAR2)
 RETURN DOMELEMENT;
```

| 参数 | 描述 |
|---|---|
| doc | 指定的DOMDOCUMENT对象。 |
| tagName | 新建的DOMELEMENT名称。 |
| ns | 命名空间。 |

  - tagName参数传入NULL和空字符串时，都会抛出异常 "NULL or invalid TagName argument specified"
  - tagName和ns默认的最大长度为32767，超过该长度会抛出异常。
示例：
```
--1. 创建指定名称的DOMELEMENT对象。
DECLARE
   doc dbe_xmldom.domdocument;
   attr DBE_XMLDOM.DOMATTR;
   elem DBE_XMLDOM.DOMELEMENT;
   ans DBE_XMLDOM.DOMATTR;
   buf varchar2(1010);
BEGIN
    doc := dbe_xmldom.newdomdocument('<?xml version="1.0" encoding="UTF-8"?>
        <computer size="ITX"><cpu>Ryzen 9 3950X</cpu>
        <ram>32GBx2 DDR4 3200MHz</ram>
        <motherboard>ROG X570i</motherboard>
        <gpu>RTX2070 Super</gpu>
        <ssd>1TB NVMe Toshiba + 2TB NVMe WD Black</ssd>
        <hdd>12TB WD Digital</hdd>
        <psu>CORSAIR SF750</psu>
        <case>LIANLI TU150</case>
        </computer>');
    elem := dbe_xmldom.createelement(doc,'elem');
    DBE_XMLDOM.WRITETOBUFFER(dbe_xmldom.makenode(elem), buf);
    DBE_OUTPUT.print_line(buf);
END;
/
-- 预期结果为：
ANONYMOUS BLOCK EXECUTE
--2. 创建指定名称和命名空间的DOMELEMENT对象。
DECLARE
   doc dbe_xmldom.domdocument;
   attr DBE_XMLDOM.DOMATTR;
   elem DBE_XMLDOM.DOMELEMENT;
   ans DBE_XMLDOM.DOMNODE;
   buf varchar2(1010);
   list DBE_XMLDOM.DOMNODELIST;
   node DBE_XMLDOM.DOMNODE;
BEGIN
    doc := dbe_xmldom.newdomdocument('<h:data xmlns:h="http://www.w3.org/TR/html4/">
        <h:da1 len="10">test namespace</h:da1><h:da1>bbbbbbbbbb</h:da1></h:data>');
    elem := dbe_xmldom.createelement(doc,'elem','http://www.w3.org/TR/html5/');
    ans := DBE_XMLDOM.APPENDCHILD(dbe_xmldom.makenode(doc), dbe_xmldom.makenode(elem));
    DBE_XMLDOM.WRITETOBUFFER(doc, buf);
    DBE_OUTPUT.print_line(buf);
END;
/
-- 预期结果为：
<?xml version="1.0" encoding="UTF-8"?>
<h:data xmlns:h="http://www.w3.org/TR/html4/">
  <h:da1 len="10">test namespace</h:da1>
  <h:da1>bbbbbbbbbb</h:da1>
</h:data>
<elem xmlns="http://www.w3.org/TR/html5/"/>
ANONYMOUS BLOCK EXECUTE
```
```
DBE_XMLDOM.CREATETEXTNODE(
   doc IN DOMDocument,
   data IN VARCHAR2)
RETURN DOMTEXT;
```

| 参数 | 描述 |
|---|---|
| doc | 指定的DOMDOCUMENT。 |
| data | DOMText节点的内容。 |

  - data可以输入空字符串和NULL值。
  - data默认的最大长度为32767，超过该长度会抛出异常。
示例：
```
--为DOC树添加DOMTEXT节点，并将DOC树打印输出到缓冲区。
DECLARE
   doc DBE_XMLDOM.DOMDOCUMENT;
   doctext DBE_XMLDOM.DOMTEXT;
   node DBE_XMLDOM.DOMNODE;
   buffer varchar2(1010);
BEGIN
   doc := dbe_xmldom.newdomdocument('<?xml version="1.0"?>
       <!DOCTYPE note [<!ELEMENT note (to,from,heading,body)>
       <!ELEMENT to (#PCDATA)>
       <!ELEMENT from (#PCDATA)>
       <!ELEMENT heading (#PCDATA)>
       <!ELEMENT body (#PCDATA)>]>
       <note>
          <to>中文</to>
          <from>Jani</from>
          <heading>Reminder</heading>
          <body>Don''t forget me this weekend!</body>
       </note>');
   doctext := DBE_XMLDOM.CREATETEXTNODE(doc, 'there is nothing');
   node := DBE_XMLDOM.MAKENODE(doctext);
   dbe_xmldom.writetobuffer(node, buffer);
   dbe_output.print_line('buffer: ');
   dbe_output.print_line(buffer);
END;
/
-- 预期结果为：
buffer:
there is nothing
ANONYMOUS BLOCK EXECUTE
```
```
DBE_XMLDOM.FREEDOCUMENT(
   doc     IN     DOMDOCUMENT);
```

| 参数 | 描述 |
|---|---|
| doc | 指定的DOMDOCUMENT节点。 |

```
--在DOC树中添加DOMNODE节点后，将整个DOC树的资源释放。
DECLARE
   doc dbe_xmldom.domdocument;
   elem dbe_xmldom.domelement;
   doc_node dbe_xmldom.DOMNODE;
   root_elmt dbe_xmldom.DOMELEMENT;
   root_node dbe_xmldom.DOMNODE;
   value  varchar(1000);
BEGIN
   doc := dbe_xmldom.newdomdocument();
   doc_node := dbe_xmldom.MAKENODE(doc);
   root_elmt := dbe_xmldom.CREATEELEMENT(doc,'staff');
   root_node:=dbe_xmldom.APPENDCHILD(doc_node, dbe_xmldom.MAKENODE(root_elmt));
   dbe_xmldom.freedocument(doc);
END;
/
-- 预期结果为：
ANONYMOUS BLOCK EXECUTE
```
- DBE_XMLDOM.FREEDOCUMENT释放DOMDOCUMENT节点。DBE_XMLDOM.FREEDOCUMENT的函数原型为： 示例：
```
DBE_XMLDOM.FREEELEMENT(
   elem     IN     DOMELEMENT);
```

| 参数 | 描述 |
|---|---|
| elem | 指定的DOMELEMENT节点。 |

```
--从DOC中获取DOMELEMENT节点后对其进行释放，对比其free前后是否为空的情况。
DECLARE
   doc dbe_xmldom.domdocument;
   elem dbe_xmldom.domelement;
   node dbe_xmldom.domnode;
   node1 dbe_xmldom.domnode;
   nodelist DBE_XMLDOM.DOMNODELIST;
   len INTEGER;
   buffer varchar2(1010);
BEGIN
   doc := dbe_xmldom.newdomdocument('<?xml version="1.0"?>
       <!DOCTYPE note [<!ELEMENT note (to,from,heading,body)>
       <!ELEMENT to (#PCDATA)>
       <!ELEMENT from (#PCDATA)>
       <!ELEMENT heading (#PCDATA)>
       <!ELEMENT body (#PCDATA)>]>
       <note>
          <to>中文</to>
          <from>Jani</from>
          <heading>Reminder</heading>
          <body>Don''t forget me this weekend!</body>
       </note>');
   elem := dbe_xmldom.GETDOCUMENTELEMENT(doc);
   IF DBE_XMLDOM.ISNULL(elem) THEN
        dbe_output.print_line('IS NULL');
   ELSE
        dbe_output.print_line('NOT NULL');
   END IF;
   dbe_xmldom.FREEELEMENT(elem);
   IF DBE_XMLDOM.ISNULL(elem) THEN
         dbe_output.print_line('IS NULL');
   ELSE
         dbe_output.print_line('NOT NULL');
   END IF;
END;
/
-- 预期结果为：
NOT NULL
IS NULL
ANONYMOUS BLOCK EXECUTE
```
- DBE_XMLDOM.FREEELEMENT释放DOMELEMENT节点。DBE_XMLDOM.FREEELEMENT的函数原型为： 示例：
```
DBE_XMLDOM.FREENODE(
   n IN DOMNODE);
```

| 参数 | 描述 |
|---|---|
| n | 指定的DOMNODE节点。 |

  - GaussDB数据库进行FREENODE操作后，被释放的节点不会出现重新可用的情况；ORA数据库在FREENODE后存在被释放的节点重新可用并变成其他节点的情况。
  - 其他接口在调用被释放的DOMNODE节点时与ORA数据库存在差异。
示例：
```
--从DOC树中获取一个DOMNODE节点后对其进行释放，对比其free前后是否为空的情况。
DECLARE
   doc dbe_xmldom.domdocument;
   node dbe_xmldom.domnode;
   node1 dbe_xmldom.domnode;
   nodelist DBE_XMLDOM.DOMNODELIST;
   len INTEGER;
   buffer1 varchar2(1010);
BEGIN
   doc := dbe_xmldom.newdomdocument('<?xml version="1.0"?>
       <!DOCTYPE note [<!ELEMENT note (to,from,heading,body)>
       <!ELEMENT to (#PCDATA)>
       <!ELEMENT from (#PCDATA)>
       <!ELEMENT heading (#PCDATA)>
       <!ELEMENT body (#PCDATA)>]>
       <note>
          <to>中文</to>
          <from>Jani</from>
          <heading>Reminder</heading>
          <body>Don''t forget me this weekend!</body>
       </note>');
   node := dbe_xmldom.makenode(doc);
   node := dbe_xmldom.GETFIRSTCHILD(node);
   IF DBE_XMLDOM.ISNULL(node) THEN
          dbe_output.print_line('IS NULL');
   ELSE
          dbe_output.print_line('NOT NULL');
   END IF;
   DBE_XMLDOM.FREENODE(node);
   IF DBE_XMLDOM.ISNULL(node) THEN
          dbe_output.print_line('IS NULL');
   ELSE
          dbe_output.print_line('NOT NULL');
   END IF;
END;
/
-- 预期结果为：
NOT NULL
IS NULL
ANONYMOUS BLOCK EXECUTE
```
```
DBE_XMLDOM.GETLENGTH(
   nl     IN    DOMNODELIST);
```

| 参数 | 描述 |
|---|---|
| nl | 指定的DOMNODELIST节点。 |

  - FREENODELIST会彻底释放NODELIST。
  - 其他接口在调用被释放的DOMNODELIST节点时与ORA数据库存在差异。
  - freenodelist不允许空值入参。
示例：
```
--从DOC树中获取一个DOMNODELIST节点后对其进行释放，对比其free前后的长度。
DECLARE
   doc dbe_xmldom.domdocument;
   node dbe_xmldom.domnode;
   node1 dbe_xmldom.domnode;
   nodelist DBE_XMLDOM.DOMNODELIST;
   len INTEGER;
   buffer1 varchar2(1010);
BEGIN
   doc := dbe_xmldom.newdomdocument('<?xml version="1.0"?>
       <!DOCTYPE note [<!ELEMENT note (to,from,heading,body)>
       <!ELEMENT to (#PCDATA)>
       <!ELEMENT from (#PCDATA)>
       <!ELEMENT heading (#PCDATA)>
       <!ELEMENT body (#PCDATA)>]>
       <note>
          <to>中文</to>
          <from>Jani</from>
          <heading>Reminder</heading>
          <body>Don''t forget me this weekend!</body>
       </note>');
   node := dbe_xmldom.makenode(doc);
   node := dbe_xmldom.GETFIRSTCHILD(node);
   nodelist := DBE_XMLDOM.GETCHILDNODES(node);
   len := DBE_XMLDOM.GETLENGTH(nodelist);
   RAISE NOTICE 'len :  %', len;
   DBE_XMLDOM.FREENODELIST(nodelist);
   len := DBE_XMLDOM.GETLENGTH(nodelist);
   RAISE NOTICE 'len :  %', len;
END;
/
-- 预期结果为：
NOTICE:  len :  4
NOTICE:  len :  0
ANONYMOUS BLOCK EXECUTE
```
```
DBE_XMLDOM.GETATTRIBUTE(
   elem       IN      DOMELEMENT,
   name       IN      VARCHAR2)
RETURN VARCHAR2;
```
```
DBE_XMLDOM.GETATTRIBUTE(
   elem      IN     DOMELEMENT,
   name      IN     VARCHAR2,
   ns        IN     VARCHAR2)
RETURN VARCHAR2;
```

| 参数 | 描述 |
|---|---|
| elem | 指定的DOMELEMENT节点。 |
| name | 属性名称。 |
| ns | 命名空间。 |

  - DBE_XMLDOM.GETATTRIBUTE接口的参数ns不支持传入参数" * "。
  - GaussDB数据库不支持将命名空间前缀作为属性，不允许通过DBE_XMLDOM.GETATTRIBUTE接口查询该前缀的值。
示例：****
```
--1. 按名称返回DOMELEMENT属性的值。
DECLARE
   doc dbe_xmldom.domdocument;
   elem dbe_xmldom.domelement;
   docnode DBE_XMLDOM.DOMNode;
   buffer varchar2(1010);
   value  varchar2(1000);
BEGIN
   doc := dbe_xmldom.newDOMDocument();
   elem := DBE_XMLDOM.CREATEELEMENT(doc, 'root');
   DBE_XMLDOM.setattribute(elem, 'len', '50cm');
   docnode := DBE_XMLDOM.appendChild(DBE_XMLDOM.makeNode(doc), DBE_XMLDOM.makeNode(elem));
   value := DBE_XMLDOM.getattribute(elem, 'len');
   dbe_output.print_line('value: ');
   dbe_output.print_line(value);
   dbe_xmldom.writetobuffer(doc, buffer);
   dbe_output.print_line('buffer: ');
   dbe_output.print_line(buffer);
END;
/
-- 预期结果为：
value:
50cm
buffer:
<?xml version="1.0" encoding="UTF-8"?>
<root len="50cm"/>
ANONYMOUS BLOCK EXECUTE
--2. 按名称和命名空间URI返回DOMELEMENT属性的值。
DECLARE
   doc dbe_xmldom.domdocument;
   elem dbe_xmldom.domelement;
   docnode DBE_XMLDOM.DOMNode;
   buffer varchar2(1010);
   value  varchar(1000);
BEGIN
   doc := dbe_xmldom.newDOMDocument();
   elem := DBE_XMLDOM.CREATEELEMENT(doc, 'root');
   DBE_XMLDOM.setattribute(elem, 'len', '50cm', 'www.xxxxx.com');
   docnode := DBE_XMLDOM.appendChild(DBE_XMLDOM.makeNode(doc), DBE_XMLDOM.makeNode(elem));
   value := DBE_XMLDOM.getattribute(elem, 'len', 'www.xxxxx.com');
   dbe_output.print_line('value: ');
   dbe_output.print_line(value);
   dbe_xmldom.writetobuffer(doc, buffer);
   dbe_output.print_line('buffer: ');
   dbe_output.print_line(buffer);
END;
/
-- 预期结果为：
value:
50cm
buffer:
<?xml version="1.0" encoding="UTF-8"?>
<root len="50cm"/>
ANONYMOUS BLOCK EXECUTE
```
```
DBE_XMLDOM.GETATTRIBUTES(
   n IN DOMNode)
RETURN DOMNAMEDNODEMAP;
```

| 参数 | 描述 |
|---|---|
| n | 指定的DOMNODE节点。 |

```
--获取DOMNODE节点下的属性值并返回DOMNAMEDNODEMAP类型，输出DOMNAMEDNODEMAP的长度和第一个节点值。
DECLARE
   doc dbe_xmldom.domdocument;
   node dbe_xmldom.domnode;
   node1 dbe_xmldom.domnode;
   len INTEGER;
   map DBE_XMLDOM.DOMNAMEDNODEMAP;
   buffer1 varchar2(1010);
BEGIN
   doc := dbe_xmldom.newdomdocument('<?xml version="1.0"?>
       <note a="16" b="176" c="asd">
          <to>中文</to>
          <from>Jani</from>
          <heading>Reminder</heading>
          <body>Don''t forget me this weekend!</body>
       </note>');
   node := dbe_xmldom.makenode(doc);
   node := dbe_xmldom.GETFIRSTCHILD(node);
   map := DBE_XMLDOM.GETATTRIBUTES(node);
   IF DBE_XMLDOM.ISNULL(map) THEN
          dbe_output.print_line('IS NULL');
   ELSE
          dbe_output.print_line('NOT NULL');
   END IF;
     len := DBE_XMLDOM.GETLENGTH(map);
   RAISE NOTICE 'len :  %', len;
    node1 := DBE_XMLDOM.ITEM(map, 0);
   dbe_xmldom.writetobuffer(node1, buffer1);
   dbe_output.print_line('buffer1: ');
   dbe_output.print_line(buffer1);
END;
/
-- 预期结果为：
NOT NULL
NOTICE:  len :  3
buffer1:
16
ANONYMOUS BLOCK EXECUTE
```
- DBE_XMLDOM.GETATTRIBUTES将DOMNode节点属性值作为map返回。DBE_XMLDOM.GETATTRIBUTES的函数原型为： 示例：
```
DBE_XMLDOM.GETCHILDNODES(
   n IN DOMNode)
RETURN DOMNodeList;
```

| 参数 | 描述 |
|---|---|
| n | 指定的DOMNODE节点。 |

```
--获取DOC树的第一个子节点后，将节点下的若干子节点转换成节点列表，输出其长度信息。
DECLARE
    doc dbe_xmldom.domdocument;
    doc_node dbe_xmldom.domnode;
    root_node dbe_xmldom.domnode;
    node_list dbe_xmldom.domnodelist;
    list_len integer;
    node_name varchar2(1000);
    node_type integer;
    buffer varchar2(1010);
BEGIN
   doc := dbe_xmldom.newdomdocument('<?xml version="1.0"?>
       <note>
          <to>中文</to>
          <from>Jani</from>
          <heading>Reminder</heading>
          <body>Don''t forget me this weekend!</body>
       </note>');
    doc_node := DBE_XMLDOM.MAKENODE(doc);
    root_node := DBE_XMLDOM.GETFIRSTCHILD(doc_node);
    node_name := DBE_XMLDOM.GETNODENAME(root_node);
    node_type := DBE_XMLDOM.GETNODETYPE(root_node);
    dbe_output.print_line(node_name);
    dbe_output.print_line(node_type);
    node_list := DBE_XMLDOM.GETCHILDNODES(root_node);
    list_len := DBE_XMLDOM.GETLENGTH(node_list);
    dbe_output.print_line(list_len);
END;
/
-- 预期结果为：
note
1
4
ANONYMOUS BLOCK EXECUTE
```
- DBE_XMLDOM.GETCHILDNODES函数将节点下的若干子节点转换成节点列表。DBE_XMLDOM.GETCHILDNODES的函数原型为： 示例：
```
DBE_XMLDOM.GETCHILDRENBYTAGNAME (
   elem       IN      DOMELEMENT,
   name       IN      VARCHAR2)
RETURN DOMNODELIST;
```
```
DBE_XMLDOM.GETCHILDRENBYTAGNAME (
   elem      IN     DOMELEMENT,
   name      IN     VARCHAR2,
   ns        IN     VARCHAR2)
 RETURN DOMNODELIST;
```

| 参数 | 描述 |
|---|---|
| elem | 指定的DOMELEMENT节点。 |
| name | 属性名称。 |
| ns | 命名空间。 |

****
```
--1. 按名称返回DOMELEMENT的子节点。
DECLARE
   doc dbe_xmldom.domdocument;
   elem dbe_xmldom.domelement;
   docnodelist dbe_xmldom.domnodelist;
   node_elem dbe_xmldom.domelement;
   node dbe_xmldom.domnode;
   buffer varchar2(1010);
   value  varchar2(1000);
BEGIN
   doc := dbe_xmldom.newdomdocument('<?xml version="1.0" encoding="UTF-8"?>
       <students age="16" hight="176">
       <student>
          <name>Jerry</name><age>519</age><gender>man</gender><abc>12345</abc>
       </student>
       <student>
          <name>Bob</name><age>245</age><gender>woman</gender><abc>54321</abc>
       </student>
       </students>');
   elem := dbe_xmldom.GETDOCUMENTELEMENT(doc);
   docnodelist := dbe_xmldom.GETCHILDRENBYTAGNAME(elem, 'student');
   node := dbe_xmldom.ITEM(docnodelist, 0);
   node_elem := dbe_xmldom.makeelement(node);
   value := DBE_XMLDOM.gettagname(node_elem);
   dbe_output.print_line('value: ');
   dbe_output.print_line(value);
   dbe_xmldom.writetobuffer(doc, buffer);
   dbe_output.print_line('buffer: ');
   dbe_output.print_line(buffer);
END;
/
-- 预期结果为：
value:
student
buffer:
<?xml version="1.0" encoding="UTF-8"?>
<students age="16" hight="176">
  <student>
    <name>Jerry</name>
    <age>519</age>
    <gender>man</gender>
    <abc>12345</abc>
  </student>
  <student>
    <name>Bob</name>
    <age>245</age>
    <gender>woman</gender>
    <abc>54321</abc>
  </student>
</students>
ANONYMOUS BLOCK EXECUTE
--2. 按名称和命名空间返回DOMELEMENT的子节点。
DECLARE
   doc dbe_xmldom.domdocument;
   elem dbe_xmldom.domelement;
   node dbe_xmldom.domnode;
   node_elem dbe_xmldom.domelement;
   docnodelist dbe_xmldom.domnodelist;
   buffer varchar2(1010);
   value varchar2(1000);
BEGIN
   doc := dbe_xmldom.newdomdocument('
      <note xmlns:h="www.xxxxx.com">
      <h:to h:len="50cm">中文</h:to>
      <from>Jani</from>
      <heading>Reminder</heading>
      <body>Don''t forget me this weekend!</body>
      </note>');
   elem := dbe_xmldom.GETDOCUMENTELEMENT(doc);
   docnodelist := dbe_xmldom.GETCHILDRENBYTAGNAME(elem, 'to', 'www.xxxxx.com');
   node := dbe_xmldom.ITEM(docnodelist, 0);
   node_elem := dbe_xmldom.makeelement(node);
   value := DBE_XMLDOM.getattribute(node_elem, 'len');
   dbe_output.print_line('value: ');
   dbe_output.print_line(value);
END;
/
-- 预期结果为：
value:
50cm
ANONYMOUS BLOCK EXECUTE
```
- DBE_XMLDOM.GETCHILDRENBYTAGNAME按名称返回DOMELEMENT的子节点。DBE_XMLDOM.GETCHILDRENBYTAGNAME的函数原型为： 按名称和命名空间返回DOMELEMENT的子节点。DBE_XMLDOM.GETCHILDRENBYTAGNAME的函数原型为： DBE_XMLDOM.GETCHILDRENBYTAGNAME接口的参数ns不支持传入参数" * "，如需获取节点下全部属性，可使用DBE_XMLDOM.GETCHILDNODES接口。 示例：
```
DBE_XMLDOM.GETDOCUMENTELEMENT(
   doc      IN      DOMDOCUMENT)
 RETURN DOMELEMENT;
```

| 参数 | 描述 |
|---|---|
| doc | 指定的DOMDOCUMENT节点。 |

```
--获取DOC树中的首个子节点，并输出该节点的名称。
DECLARE
   doc dbe_xmldom.domdocument;
   elem dbe_xmldom.domelement;
   doc_node dbe_xmldom.DOMNODE;
   root_elmt dbe_xmldom.DOMELEMENT;
   root_node dbe_xmldom.DOMNODE;
   value  varchar(1000);
BEGIN
   doc := dbe_xmldom.newdomdocument();
   doc_node := dbe_xmldom.MAKENODE(doc);
   root_elmt := dbe_xmldom.CREATEELEMENT(doc,'staff');
   root_node:=dbe_xmldom.APPENDCHILD(doc_node, dbe_xmldom.MAKENODE(root_elmt));
   elem := dbe_xmldom.GETDOCUMENTELEMENT(doc);
   value := DBE_XMLDOM.gettagname(elem);
   dbe_output.print_line(value);
END;
/
-- 预期结果为：
staff
ANONYMOUS BLOCK EXECUTE
```
- DBE_XMLDOM.GETDOCUMENTELEMENT返回指定DOCUMENT的首个子节点。DBE_XMLDOM.GETDOCUMENTELEMENT的函数原型为： 示例：
```
DBE_XMLDOM.GETFIRSTCHILD(
   n IN DOMNODE)
RETURN DOMNODE;
```

| 参数 | 描述 |
|---|---|
| n | 指定的DOMNODE节点。 |

```
--获取DOC转换成DOMNODE类型后的第一个子节点后输出其名称和类型；在获取到的第一个子节点基础上，获取该DOMNODE的第一个子节点并输出其名称。
DECLARE
    doc dbe_xmldom.domdocument;
    doc_node dbe_xmldom.domnode;
     root_node dbe_xmldom.domnode;
    inside_node dbe_xmldom.domnode;
    node_name varchar2(1000);
    node_type integer;
BEGIN
    doc := dbe_xmldom.newdomdocument('<?xml version="1.0" encoding="UTF-8"?>
       <students age="16" hight="176">
       <student1>
          <name>Jerry</name><age>519</age><gender>man</gender><abc>12345</abc>
       </student1>
       <student2>
          <name>Bob</name><age>245</age><gender>woman</gender><abc>54321</abc>
       </student2>
       </students>');
    doc_node := DBE_XMLDOM.MAKENODE(doc);
    root_node := DBE_XMLDOM.GETFIRSTCHILD(doc_node);
    node_name := DBE_XMLDOM.GETNODENAME(root_node);
    node_type := DBE_XMLDOM.GETNODETYPE(root_node);
    dbe_output.print_line(node_name);
    dbe_output.print_line(node_type);
    inside_node := DBE_XMLDOM.GETFIRSTCHILD(root_node);
    node_name := DBE_XMLDOM.GETNODENAME(inside_node);
    dbe_output.print_line(node_name);
END;
/
-- 预期结果为：
students
1
student1
ANONYMOUS BLOCK EXECUTE
```
- DBE_XMLDOM.GETFIRSTCHILD返回节点的第一个子节点。DBE_XMLDOM.GETFIRSTCHILD的函数原型为： 示例：
```
DBE_XMLDOM.GETLASTCHILD(
   n IN DOMNODE)
RETURN DOMNODE;
```

| 参数 | 描述 |
|---|---|
| n | 指定的DOMNODE节点。 |

```
--获取DOC转换成DOMNODE类型后的最后一个子节点后输出其名称和类型；在获取到的最后一个子节点基础上，获取该DOMNODE的最后一个子节点并输出其名称。
DECLARE
    doc dbe_xmldom.domdocument;
    doc_node dbe_xmldom.domnode;
    root_node dbe_xmldom.domnode;
    inside_node dbe_xmldom.domnode;
    node_name varchar2(1000);
    node_type integer;
BEGIN
    doc := dbe_xmldom.newdomdocument('<?xml version="1.0" encoding="UTF-8"?>
       <students age="16" hight="176">
       <student1>
          <name>Jerry</name><age>519</age><gender>man</gender><abc>12345</abc>
       </student1>
       <student2>
          <name>Bob</name><age>245</age><gender>woman</gender><abc>54321</abc>
       </student2>
       </students>');
    doc_node := DBE_XMLDOM.MAKENODE(doc);
    root_node := DBE_XMLDOM.GETFIRSTCHILD(doc_node);
    node_name := DBE_XMLDOM.GETNODENAME(root_node);
    node_type := DBE_XMLDOM.GETNODETYPE(root_node);
    dbe_output.print_line(node_name);
    dbe_output.print_line(node_type);
    inside_node := DBE_XMLDOM.GETLASTCHILD(root_node);
    node_name := DBE_XMLDOM.GETNODENAME(inside_node);
    dbe_output.print_line(node_name);
END;
/
-- 预期结果为：
students
1
student2
ANONYMOUS BLOCK EXECUTE
```
- DBE_XMLDOM.GETLASTCHILD返回节点的最后一个子节点。DBE_XMLDOM.GETLASTCHILD的函数原型为： 示例：
```
DBE_XMLDOM.GETLENGTH(
   nnm      IN     DOMNAMEDNODEMAP)
 RETURN NUMBER;
```
```
DBE_XMLDOM.GETLENGTH(
   nl     IN    DOMNODELIST)
 RETURN NUMBER;
```

| 参数 | 描述 |
|---|---|
| nnm | 指定的DOMNAMEDNODEMAP类型节点。 |
| nl | 指定的DOMNODELIST类型节点。 |

```
--1. DOMNAMEDNODEMAP类型作为函数参数。
DECLARE
   doc DBE_XMLDOM.DOMDocument;
   elem DBE_XMLDOM.DOMElement;
   map DBE_XMLDOM.DOMNAMEDNODEMAP;
   node DBE_XMLDOM.DOMNODE;
   buf varchar2(10000);
   len INTEGER;
BEGIN
   doc := dbe_xmldom.newdomdocument('<?xml version="1.0"?>
       <bookstore category="web" cover="paperback">
       <book category="cooking">
          <title lang="en">Everyday Italian</title>
          <author>Giada De Laurentiis</author>
          <year>2005</year>
          <price>30.00</price>
       </book>
       </bookstore>');
   elem := DBE_XMLDOM.GETDOCUMENTELEMENT(doc);
   node := DBE_XMLDOM.MAKENODE(elem);
   map := DBE_XMLDOM.GETATTRIBUTES(node);
   len := DBE_XMLDOM.GETLENGTH(map);
   DBE_OUTPUT.print_line(len);
END;
/
-- 预期结果为：
2
ANONYMOUS BLOCK EXECUTE
--2. Nodelist类型作为函数参数
DECLARE
   doc dbe_xmldom.domdocument;
   node dbe_xmldom.domnode;
   node1 dbe_xmldom.domnode;
   nodelist DBE_XMLDOM.DOMNODELIST;
   len INTEGER;
   buffer1 varchar2(1010);
BEGIN
   doc := dbe_xmldom.newdomdocument('<?xml version="1.0" encoding="UTF-8"?>
       <students age="16" hight="176">
       <student>
          <name>Jerry</name><age>519</age><gender>man</gender><abc>12345</abc>
       </student>
       <student>
          <name>Jerry</name><age>519</age><gender>man</gender><abc>12345</abc>
       </student>
       </students>');
   node := dbe_xmldom.makenode(doc);
   node := dbe_xmldom.GETFIRSTCHILD(node);
   nodelist := DBE_XMLDOM.GETCHILDNODES(node);
   len := DBE_XMLDOM.GETLENGTH(nodelist);
   RAISE NOTICE 'len :  %', len;
END;
/
-- 预期结果为：
NOTICE:  len :  2
ANONYMOUS BLOCK EXECUTE
```
- DBE_XMLDOM.GETLENGTH返回DOMNAMEDNODEMAP类型节点中的节点数。DBE_XMLDOM.GETLENGTH的函数原型为： 返回DOMNODELIST类型节点中的节点数。DBE_XMLDOM.GETLENGTH的函数原型为： 示例：
```
DBE_XMLDOM.GETLOCALNAME(
   a       IN     DOMATTR)
RETURN VARCHAR2;
```
```
DBE_XMLDOM.GETLOCALNAME(
   elem       IN     DOMELEMENT)
RETURN VARCHAR2;
```
```
DBE_XMLDOM.GETLOCALNAME(
   n      IN     DOMNODE,
   data   OUT    VARCHAR2);
```

| 参数 | 描述 |
|---|---|
| a | 指定的DOMATTR类型节点。 |
| elem | 指定的DOMELEMENT类型节点。 |
| n | 指定的DOMNODE类型节点。 |
| data | 返回的本地名称。 |

```
--1. createAttribute函数生成attr节点，获取它的本地名称。
DECLARE
   doc DBE_XMLDOM.DOMDocument;
   root DBE_XMLDOM.DOMElement;
   attr1 DBE_XMLDOM.DOMATTR;
   value VARCHAR2(1000);
BEGIN
   doc := DBE_xmldom.newdomdocument('<?xml version="1.0"?>
      <!DOCTYPE note [<!ELEMENT note (to,from,heading,body)>
      <!ELEMENT to (#PCDATA)>
      <!ELEMENT from (#PCDATA)>
      <!ELEMENT heading (#PCDATA)>
      <!ELEMENT body (#PCDATA)>]>
      <note><to>中文</to>
      <from>Jani</from>
      <heading>Reminder</heading>
      <body>Don''t forget me this weekend!</body>
      </note>');
   attr1 := DBE_XMLDOM.createAttribute(doc,'len');
   value := DBE_XMLDOM.getlocalname(attr1);
   DBE_output.print_line('value: ');
   DBE_output.print_line(value);
END;
/
-- 预期结果为：
value:
len
ANONYMOUS BLOCK EXECUTE
--2. createElement函数生成elem节点，获取它的本地名称。
DECLARE
   doc DBE_xmldom.domdocument;
   elem DBE_xmldom.domelement;
   value  varchar2(10000);
BEGIN
   doc := DBE_xmldom.newdomdocument();
   elem := DBE_XMLDOM.createELEMENT(doc, 'root');
   value := DBE_XMLDOM.getlocalname(elem);
   DBE_output.print_line('value: ');
   DBE_output.print_line(value);
END;
/
-- 预期结果为：
value:
root
ANONYMOUS BLOCK EXECUTE
--3. Element节点转换成node节点后，取其本地名称。
DECLARE
   doc DBE_xmldom.domdocument;
   elem DBE_xmldom.domelement;
   node DBE_xmldom.domnode;
   value  varchar2(100);
   buf varchar2(100);
BEGIN
   doc := DBE_xmldom.newdomdocument();
   elem := DBE_XMLDOM.createELEMENT(doc, 'root');
   node := DBE_xmldom.makenode(elem);
   DBE_XMLDOM.getlocalname(node, buf);
   DBE_output.print_line('buf: ');
   DBE_output.print_line(buf);
END;
/
-- 预期结果为：
buf:
root
ANONYMOUS BLOCK EXECUTE
```
- DBE_XMLDOM.GETLOCALNAME函数返回给定的DOMATTR类型节点的本地名称。DBE_XMLDOM.MAKENODE的函数原型为： 函数返回给定的DOMELEMENT类型节点的本地名称。DBE_XMLDOM.MAKENODE的函数原型为 存储过程返回给定的DOMNODE类型节点的本地名称。DBE_XMLDOM.MAKENODE的函数原型为 示例：
```
DBE_XMLDOM.GETNAMEDITEM(
   nnm IN DOMNAMEDNODEMAP,
   name IN VARCHAR2)
RETURN DOMNODE;
```
```
DBE_XMLDOM.GETNAMEDITEM(
   nnm IN DOMNAMEDNODEMAP,
   name IN VARCHAR2,
   ns IN VARCHAR2)
RETURN DOMNODE;
```

| 参数 | 描述 |
|---|---|
| nnm | DOMNAMEDNODEMAP。 |
| name | 要检索的元素名称。 |
| ns | 命名空间。 |

  - name和nnm可以输入NULL值，但不可不入参。
  - name和ns默认的最大长度为32767，超出该长度会报错。
  - name和ns可输入int类型，长度可超出127位。
示例：
```
--1. 检索由名称指定的节点。
DECLARE
   doc DBE_XMLDOM.DOMDocument;
   elem DBE_XMLDOM.DOMElement;
   map DBE_XMLDOM.DOMNAMEDNODEMAP;
   node DBE_XMLDOM.DOMNODE;
   node2 DBE_XMLDOM.DOMNODE;
   buf varchar2(1000);
   buf2 varchar2(1000);
BEGIN
   doc := dbe_xmldom.newdomdocument('<bookstore category="web" cover="paperback">
       <book category="cooking"><title lang="en">Everyday Italian</title>
       <author>Giada De Laurentiis</author><year>2005</year>
       <price>30.00</price></book></bookstore>');
   elem := DBE_XMLDOM.GETDOCUMENTELEMENT(doc);
   node := DBE_XMLDOM.MAKENODE(elem);
   map := DBE_XMLDOM.GETATTRIBUTES(node);
   node2:= DBE_XMLDOM.GETNAMEDITEM(map,'category');
   DBE_XMLDOM.writeToBuffer(node2, buf2);
   dbe_output.print_line(buf2);
END;
/
-- 预期结果为：
web
ANONYMOUS BLOCK EXECUTE
--2. 检索由名称和命名空间指定的节点。
DECLARE
   doc DBE_XMLDOM.DOMDocument;
   root DBE_XMLDOM.DOMElement;
   elem DBE_XMLDOM.DOMElement;
   map DBE_XMLDOM.DOMNAMEDNODEMAP;
   node DBE_XMLDOM.DOMNODE;
   buf varchar2(1000);
   buf2 varchar2(1000);
BEGIN
   doc := dbe_xmldom.newdomdocument('<h:table xmlns:h="http://www.w3.org/TR/html4/">
        <h:tr h:id="10"><h:td >Apples</h:td>
        <h:td>Bananas</h:td></h:tr></h:table>');
   root := DBE_XMLDOM.getDocumentElement(doc);
   node := DBE_XMLDOM.MAKENODE(root);
   node := dbe_xmldom.GETFIRSTCHILD(node);
   map := DBE_XMLDOM.GETATTRIBUTES(node);
   node := DBE_XMLDOM.GETNAMEDITEM(map,'id','http://www.w3.org/TR/html4/');
   DBE_XMLDOM.writeToBuffer(node, buf2);
   dbe_output.print_line(buf2);
END;
/
-- 预期结果为：
10
ANONYMOUS BLOCK EXECUTE
```
```
DBE_XMLDOM.GETNEXTSIBLING(
   n  IN  DOMNODE)
RETURN DOMNODE;
```

| 参数 | 描述 |
|---|---|
| n | 指定的DOMNODE节点。 |

```
--首先获取DOC转换成DOMNODE类型后的第一个子节点；在获取到的第一个子节点基础上，获取该DOMNODE的第一个子节点；通过DBE_XMLDOM.GETNEXTSIBLING获取该节点的下一个节点，并输出下一个节点的名称。
DECLARE
    doc dbe_xmldom.domdocument;
    doc_node dbe_xmldom.domnode;
    root_node dbe_xmldom.domnode;
    inside_node dbe_xmldom.domnode;
    node_name varchar2(1000);
    node_type integer;
BEGIN
   doc := dbe_xmldom.newdomdocument('<computer size="ITX">
        <cpu>Ryzen 9 3950X</cpu>
        <ram>32GBx2 DDR4 3200MHz</ram>
        <motherboard>X570i</motherboard>
    </computer>');
    doc_node := DBE_XMLDOM.MAKENODE(doc);
    root_node := DBE_XMLDOM.GETFIRSTCHILD(doc_node);
    node_name := DBE_XMLDOM.GETNODENAME(root_node);
    node_type := DBE_XMLDOM.GETNODETYPE(root_node);
    dbe_output.print_line(node_name);
    dbe_output.print_line(node_type);
    inside_node := DBE_XMLDOM.GETFIRSTCHILD(root_node);
    node_name := DBE_XMLDOM.GETNODENAME(inside_node);
    dbe_output.print_line(node_name);
    inside_node := DBE_XMLDOM.GETNEXTSIBLING(inside_node);
    node_name := DBE_XMLDOM.GETNODENAME(inside_node);
    dbe_output.print_line(node_name);
END;
/
-- 预期结果为：
computer
1
cpu
ram
ANONYMOUS BLOCK EXECUTE
```
- DBE_XMLDOM.GETNEXTSIBLING返回下一个节点。DBE_XMLDOM.GETNEXTSIBLING的函数原型为： 示例：
```
DBE_XMLDOM.GETNODENAME(
   n  IN  DOMNODE)
RETURN  VARCHAR2;
```

| 参数 | 描述 |
|---|---|
| n | 指定的DOMNODE节点。 |

```
--在DOC树中获取DOMNODE节点，输出该节点的名称。
DECLARE
  doc DBE_XMLDOM.DOMDocument;
  root DBE_XMLDOM.DOMElement;
  root_node DBE_XMLDOM.DOMNode;
  inside_node DBE_XMLDOM.DOMNode;
  buf VARCHAR2(1000);
BEGIN
   doc := dbe_xmldom.newdomdocument('<bookstore category="web" cover="paperback">
       <book category="cooking"><title lang="en">Everyday Italian</title>
       <author>Giada De Laurentiis</author><year>2005</year>
       <price>30.00</price></book></bookstore>');
   root := DBE_XMLDOM.getDocumentElement(doc);
   root_node := DBE_XMLDOM.MAKENODE(root);
   inside_node := DBE_XMLDOM.GETFIRSTCHILD(root_node);
   buf := DBE_XMLDOM.GETNODENAME(inside_node);
   dbe_output.print_line(buf);
END;
/
-- 预期结果为：
book
ANONYMOUS BLOCK EXECUTE
```
- DBE_XMLDOM.GETNODENAME返回NODE节点的名称。DBE_XMLDOM.GETNODENAME的函数原型为： 示例：
```
DBE_XMLDOM.GETNODETYPE(
   n  IN  DOMNODE)
RETURN  NUMBER;
```

| 参数 | 描述 |
|---|---|
| n | 指定的DOMNODE节点。 |

```
--在DOC树中获取DOMNODE节点，输出该节点的类型值。
DECLARE
   doc DBE_XMLDOM.DOMDocument;
   doc_node DBE_XMLDOM.DOMNode;
   num number;
   buf varchar2(1000);
BEGIN
   doc := dbe_xmldom.newdomdocument('<bookstore category="web" cover="paperback">
       <book category="cooking"><title lang="en">Everyday Italian</title>
       <author>Giada De Laurentiis</author><year>2005</year>
       <price>30.00</price></book></bookstore>');
   doc_node := DBE_XMLDOM.makeNode(doc);
   num := DBE_XMLDOM.GETNODETYPE(doc_node);
   dbe_output.print_line(num);
   buf := DBE_XMLDOM.GETNODENAME(doc_node);
   dbe_output.print_line(buf);
END;
/
-- 预期结果为：
9
#document
ANONYMOUS BLOCK EXECUTE
```
- DBE_XMLDOM.GETNODETYPE返回NODE节点的类型。DBE_XMLDOM.GETNODETYPE的函数原型为： 示例：
```
DBE_XMLDOM.GETNODEVALUE(
   n  IN  DOMNODE)
RETURN  VARCHAR2;
```

| 参数 | 描述 |
|---|---|
| n | 指定的DOMNODE对象。 |

```
--将DOMTEXT类型节点转换为DOMNODE类型后获取该节点的值并输出。
DECLARE
  buf VARCHAR2(1000);
  doc DBE_XMLDOM.DOMDocument;
  text DBE_XMLDOM.DOMText;
  elem2 DBE_XMLDOM.DOMElement;
  node DBE_XMLDOM.DOMNode;
begin
  doc := DBE_XMLDOM.NEWDOMDOCUMENT();
  text := DBE_XMLDOM.createTextNode(doc, 'aaa');
  DBE_XMLDOM.SETNODEVALUE(DBE_XMLDOM.makeNode(text), 'ccc');
  buf := DBE_XMLDOM.GETNODEVALUE(DBE_XMLDOM.makeNode(text));
  DBE_OUTPUT.print_line(buf);
end;
/
-- 预期结果为：
ccc
ANONYMOUS BLOCK EXECUTE
```
- DBE_XMLDOM.GETNODEVALUE返回NODE节点的值。DBE_XMLDOM.GETNODEVALUE的函数原型为： 示例：
```
DBE_XMLDOM.GETPARENTNODE(
   n  IN  DOMNODE)
RETURN  DOMNODE;
```

| 参数 | 描述 |
|---|---|
| n | 指定的DOMNODE对象。 |

```
--向DOC树中添加子节点后，获取该子节点的父节点，输出父节点的名称。
DECLARE
   doc DBE_XMLDOM.DOMDocument;
   doc1 DBE_XMLDOM.DOMDocument;
   root DBE_XMLDOM.DOMElement;
   child1 DBE_XMLDOM.DOMElement;
   child2 DBE_XMLDOM.DOMElement;
   attr DBE_XMLDOM.DOMAttr;
   text DBE_XMLDOM.DOMTEXT;
   node DBE_XMLDOM.DOMNode;
   parent DBE_XMLDOM.DOMNode;
   buf varchar2(1000);
BEGIN
   doc := DBE_XMLDOM.newDOMDocument();
   root := DBE_XMLDOM.createElement(doc, 'root');
   node := DBE_XMLDOM.appendChild(DBE_xmldom.makeNode(doc),DBE_xmldom.makeNode(root));
   child1 := DBE_XMLDOM.createElement(doc, 'child1');
   node := DBE_XMLDOM.appendChild(DBE_XMLDOM.makeNode(root), DBE_XMLDOM.makeNode(child1));
   child2 := DBE_XMLDOM.createElement(doc, 'child2');
   node := DBE_XMLDOM.appendChild(DBE_XMLDOM.makeNode(child1), DBE_XMLDOM.makeNode(child2));
   parent := DBE_XMLDOM.GETPARENTNODE(DBE_XMLDOM.makeNode(child2));
   buf := DBE_XMLDOM.GETNODENAME(parent);
   DBE_OUTPUT.print_line(buf);
END;
/
-- 预期结果为：
child1
ANONYMOUS BLOCK EXECUTE
```
- DBE_XMLDOM.GETPARENTNODE返回给定NODE节点的父节点。DBE_XMLDOM.GETPARENTNODE的函数原型为： 示例：
```
DBE_XMLDOM.GETTAGNAME(
   elem  IN  DOMELEMENT)
RETURN  VARCHAR2;
```

| 参数 | 描述 |
|---|---|
| elem | 指定的DOMELEMENT节点。 |

```
--创建DOMELEMENT节点后，输出其标签名称。
DECLARE
   doc dbe_xmldom.domdocument;
   elem dbe_xmldom.domelement;
   buffer varchar2(1010);
   value  varchar(1000);
BEGIN
   doc := dbe_xmldom.newDOMDocument();
   elem := DBE_XMLDOM.CREATEELEMENT(DBE_XMLDOM.NEWDOMDOCUMENT(), 'root');
   value := DBE_XMLDOM.gettagname(elem);
   dbe_output.print_line('value: ');
   dbe_output.print_line(value);
   dbe_xmldom.writetobuffer(doc, buffer);
   dbe_output.print_line('buffer: ');
   dbe_output.print_line(buffer);
END;
/
-- 预期结果为：
value:
root
buffer:
<?xml version="1.0" encoding="UTF-8"?>
ANONYMOUS BLOCK EXECUTE
```
- DBE_XMLDOM.GETTAGNAME返回指定DOMELEMENT的标签名称。DBE_XMLDOM.GETTAGNAME的函数原型为： 示例：
```
DBE_XMLDOM.HASCHILDNODES(
   n  IN  DOMNODE)
RETURN  BOOLEAN;
```

| 参数 | 描述 |
|---|---|
| n | 指定的DOMNODE对象。 |

```
--创建节点child1并将其挂载到DOC树中，为child1节点添加子节点后，判断其是否拥有任一子节点。
DECLARE
   doc DBE_XMLDOM.DOMDocument;
   doc1 DBE_XMLDOM.DOMDocument;
   root DBE_XMLDOM.DOMElement;
   child1 DBE_XMLDOM.DOMElement;
   child2 DBE_XMLDOM.DOMElement;
   attr DBE_XMLDOM.DOMAttr;
   text DBE_XMLDOM.DOMTEXT;
   node DBE_XMLDOM.DOMNode;
   buf varchar2(1000);
BEGIN
   doc := DBE_XMLDOM.newDOMDocument();
   root := DBE_XMLDOM.createElement(doc, 'root');
   node := DBE_XMLDOM.appendChild(DBE_xmldom.makeNode(doc),DBE_xmldom.makeNode(root));
   child1 := DBE_XMLDOM.createElement(doc, 'child1');
   node := DBE_XMLDOM.appendChild(DBE_XMLDOM.makeNode(root), DBE_XMLDOM.makeNode(child1));
   child2 := DBE_XMLDOM.createElement(doc, 'child2');
   node := DBE_XMLDOM.appendChild(DBE_XMLDOM.makeNode(child1), DBE_XMLDOM.makeNode(child2));
   IF DBE_XMLDOM.HASCHILDNODES(DBE_XMLDOM.makeNode(child1)) THEN
      DBE_OUTPUT.print_line('HAS CHILD NODES');
   ELSE
      DBE_OUTPUT.print_line('NOT HAS CHILD NODES ');
   END IF;
END;
/
-- 预期结果为：
HAS CHILD NODES
ANONYMOUS BLOCK EXECUTE
```
- DBE_XMLDOM.HASCHILDNODES检查DOMNODE对象是否拥有任一子节点。DBE_XMLDOM.HASCHILDNODES的函数原型为： 示例：
```
DBE_XMLDOM.IMPORTNODE(
   doc IN DOMDOCUMENT,
   importedNode IN DOMNODE,
   deep IN BOOLEAN)
RETURN DOMNODE;
```

| 参数 | 描述 |
|---|---|
| doc | 节点挂载的文档。 |
| importedNode | 将要导入的节点。 |
| deep | 设置递归导入：如果为TRUE，则导入该节点及其所有子节点。如果为FALSE，则只导入节点本身。 |

```
--获取将DOC2树中的节点root2_node，并将其复制并挂载到DOC树中。
DECLARE
    doc dbe_xmldom.domdocument;
    doc2 dbe_xmldom.domdocument;
    doc_node dbe_xmldom.domnode;
    doc2_node dbe_xmldom.domnode;
     root_node dbe_xmldom.domnode;
    root2_node dbe_xmldom.domnode;
    import_node dbe_xmldom.domnode;
    result_node dbe_xmldom.domnode;
    buffer varchar2(1010);
BEGIN
    doc := dbe_xmldom.newdomdocument('<bookstore category="web" cover="paperback">
       <book category="cooking"><title lang="en">Everyday Italian</title>
       <author>Giada De Laurentiis</author><year>2005</year>
       <price>30.00</price></book></bookstore>');
    doc2 := dbe_xmldom.newdomdocument('<case>LIANLI TU150</case>');
    doc_node := DBE_XMLDOM.MAKENODE(doc);
    doc2_node := DBE_XMLDOM.MAKENODE(doc2);
    root_node := DBE_XMLDOM.GETFIRSTCHILD(doc_node);
    root2_node := DBE_XMLDOM.GETFIRSTCHILD(doc2_node);
    DBE_XMLDOM.WRITETOBUFFER(doc, buffer);
    dbe_output.print_line(buffer);
    import_node := DBE_XMLDOM.IMPORTNODE(doc, root2_node, TRUE);
    result_node := DBE_XMLDOM.APPENDCHILD(root_node, import_node);
    DBE_XMLDOM.WRITETOBUFFER(doc, buffer);
    dbe_output.print_line(buffer);
END;
/
-- 预期结果为：
<?xml version="1.0" encoding="UTF-8"?>
<bookstore category="web" cover="paperback">
  <book category="cooking">
    <title lang="en">Everyday Italian</title>
    <author>Giada De Laurentiis</author>
    <year>2005</year>
    <price>30.00</price>
  </book>
</bookstore>
<?xml version="1.0" encoding="UTF-8"?>
<bookstore category="web" cover="paperback">
  <book category="cooking">
    <title lang="en">Everyday Italian</title>
    <author>Giada De Laurentiis</author>
    <year>2005</year>
    <price>30.00</price>
  </book>
  <case>LIANLI TU150</case>
</bookstore>
ANONYMOUS BLOCK EXECUTE
```
- DBE_XMLDOM.IMPORTNODE该函数将节点复制到另一节点中，并将复制后的节点挂载到指定document中。若被复制节点的类型不属于xmldom的constants所规定的12种类型，则直接抛出类型不支持异常。DBE_XMLDOM.IMPORTNODE的函数原型为： 示例：
```
DBE_XMLDOM.ISNULL(
   a       IN     DOMATTR)
RETURN BOOLEAN;
```
```
DBE_XMLDOM.ISNULL(
   doc       IN     DOMDOCUMENT)
RETURN BOOLEAN;
```
```
DBE_XMLDOM.ISNULL(
   elem     IN     DOMELEMENT)
RETURN BOOLEAN;
```
```
DBE_XMLDOM.ISNULL(
   nnm       IN     DOMNAMEDNODEMAP)
RETURN BOOLEAN;
```
```
DBE_XMLDOM.ISNULL(
   n      IN     DOMNODE)
RETURN BOOLEAN;
```
```
DBE_XMLDOM.ISNULL(
   nl       IN     DOMNODELIST)
RETURN BOOLEAN;
```
```
DBE_XMLDOM.ISNULL(
   t       IN     DOMTEXT)
RETURN BOOLEAN;
```

| 参数 | 描述 |
|---|---|
| a | 指定的DOMATTR类型节点。 |
| doc | 指定的DOMDOCUMENT类型节点。 |
| elem | 指定的DOMELEMENT类型节点。 |
| nnm | 指定的DOMNAMEDNODEMAP类型节点。 |
| n | 指定的DOMNODE类型节点。 |
| nl | 指定的DOMNODELIST类型节点。 |
| t | 指定的DOMTEXT类型节点。 |

```
--1. 通过createAttribute创建DOMATTR节点，并判断其是否为空。
DECLARE
   doc DBE_XMLDOM.DOMDocument;
   attr DBE_XMLDOM.DOMATTR;
   buf VARCHAR2(1000);
BEGIN
   doc := DBE_xmldom.newdomdocument('<?xml version="1.0"?>
      <!DOCTYPE note [<!ELEMENT note (to,from,heading,body)>
      <!ATTLIST note color CDATA #REQUIRED>
      <!ELEMENT to (#PCDATA)>
      <!ELEMENT from (#PCDATA)>
      <!ELEMENT heading (#PCDATA)>
      <!ELEMENT body (#PCDATA)>]>
      <note color="red"><to>中文</to>
      <from>Jani</from>
      <heading>Reminder</heading>
      <body>Don''t forget me this weekend!</body>
      </note>');
   attr := DBE_XMLDOM.CREATEATTRIBUTE (doc, 'length');
   if DBE_XMLDOM.ISNULL(attr) then
      DBE_OUTPUT.print_line('null');
   else
      DBE_OUTPUT.print_line('not null');
   end if;
END;
/
-- 预期结果为：
not null
ANONYMOUS BLOCK EXECUTE
--2. DOMELEMENT仅声明不初始化，并判断其是否为空。
DECLARE
   docelem   DBE_XMLDOM.DOMElement;
BEGIN
   if DBE_XMLDOM.ISNULL(docelem) then
      DBE_OUTPUT.print_line('null');
   else
      DBE_OUTPUT.print_line('not null');
   end if;
END;
/
-- 预期结果为：
null
ANONYMOUS BLOCK EXECUTE
--3. 通过newDomdocument构建良构的DOMDOCUMENT节点，判断其是否为空。
Declare
  doc dbe_xmldom.domdocument;
BEGIN
  doc := DBE_xmldom.newdomdocument('<?xml version="1.0"?>
      <!DOCTYPE note [<!ELEMENT note (to,from,heading,body)>
      <!ATTLIST note color CDATA #REQUIRED>
      <!ELEMENT to (#PCDATA)>
      <!ELEMENT from (#PCDATA)>
      <!ELEMENT heading (#PCDATA)>
      <!ELEMENT body (#PCDATA)>]>
      <note color="red"><to>中文</to>
      <from>Jani</from>
      <heading>Reminder</heading>
      <body>Don''t forget me this weekend!</body>
      </note>');
  if DBE_XMLDOM.ISNULL(doc) then
      DBE_OUTPUT.print_line('null');
   else
      DBE_OUTPUT.print_line('not null');
   end if;
END;
/
-- 预期结果为：
not null
ANONYMOUS BLOCK EXECUTE
```
- DBE_XMLDOM.ISNULL检测给定的DOMATTR类型节点是否为NULL。如果是返回TRUE，否则返回FALSE。DBE_XMLDOM.ISNULL的函数原型为： 检测给定的DOMDOCUMENT类型节点是否为NULL。如果是返回TRUE，否则返回FALSE。DBE_XMLDOM.ISNULL的函数原型为： 检测给定的DOMELEMENT类型节点是否为NULL。如果是返回TRUE，否则返回FALSE。DBE_XMLDOM.ISNULL的函数原型为： 检测给定的DOMNAMEDNODEMAP类型节点是否为NULL。如果是返回TRUE，否则返回FALSE。DBE_XMLDOM.ISNULL的函数原型为： 检测给定的DOMNODE类型节点是否为NULL。如果是返回TRUE，否则返回FALSE。DBE_XMLDOM.ISNULL的函数原型为： 检测给定的DOMNODELIST类型节点是否为NULL。如果是返回TRUE，否则返回FALSE。DBE_XMLDOM.ISNULL的函数原型为： 检测给定的DOMTEXT类型节点是否为NULL。如果是返回TRUE，否则返回FALSE。DBE_XMLDOM.ISNULL的函数原型为： 由于DBE_XMLDOM.FREEDOCUMENT的实现差异，DBE_XMLDOM.ISNULL接口在调用释放后的DOMDOCUMENT节点时会发生报错。 示例：
```
DBE_XMLDOM.ITEM(
   nl IN DOMNODELIST,
   index IN NUMBER)
RETURN DOMNODE;
```
```
DBE_XMLDOM.ITEM(
   nnm IN DOMNAMEDNODEMAP,
   index IN NUMBER)
RETURN DOMNODE;
```

| 参数 | 描述 |
|---|---|
| nl | DOMNODELIST。 |
| nnm | DOMNAMEDNODEMAP。 |
| index | 要检索的元素的索引。 |

```
--1. 根据索引返回map中与索引对应的元素。
DECLARE
   doc DBE_XMLDOM.DOMDocument;
   elem DBE_XMLDOM.DOMElement;
   map DBE_XMLDOM.DOMNAMEDNODEMAP;
   node DBE_XMLDOM.DOMNODE;
   node2 DBE_XMLDOM.DOMNODE;
   buf varchar2(1000);
BEGIN
   doc := dbe_xmldom.newdomdocument('<bookstore category="web" cover="paperback"><book category="cooking">
       <title lang="en">Everyday Italian</title><author>Giada De Laurentiis</author>
       <year>2005</year><price>30.00</price></book></bookstore>');
   elem := DBE_XMLDOM.GETDOCUMENTELEMENT(doc);
   node := DBE_XMLDOM.MAKENODE(elem);
   map := DBE_XMLDOM.GETATTRIBUTES(DBE_XMLDOM.getFirstChild(node));
   node2:= DBE_XMLDOM.item(map,0);
   DBE_XMLDOM.writeToBuffer(node2, buf);
   dbe_output.print_line(buf);
   dbe_xmldom.freedocument(doc);
   RAISE NOTICE '%', buf;
END;
/
-- 预期结果为：
cooking
NOTICE:  cooking
ANONYMOUS BLOCK EXECUTE
--2. 根据索引返回list中与索引对应的元素。
DECLARE
   doc dbe_xmldom.domdocument;
   node dbe_xmldom.domnode;
   node1 dbe_xmldom.domnode;
   nodelist DBE_XMLDOM.DOMNODELIST;
   len INTEGER;
   buffer1 varchar2(1010);
BEGIN
   doc := dbe_xmldom.newdomdocument('<bookstore category="web" cover="paperback"><book category="cooking">
       <title lang="en">Everyday Italian</title><author>Giada De Laurentiis</author>
       <year>2005</year><price>30.00</price></book></bookstore>');
   node := dbe_xmldom.makenode(doc);
   node := dbe_xmldom.GETFIRSTCHILD(node);
   node := dbe_xmldom.GETFIRSTCHILD(node);
   nodelist := DBE_XMLDOM.GETCHILDNODES(node);
   len := DBE_XMLDOM.GETLENGTH(nodelist);
   RAISE NOTICE 'len :  %', len;
   node1 := DBE_XMLDOM.ITEM(nodelist, 0);
   IF DBE_XMLDOM.ISNULL(node1) THEN
          dbe_output.print_line('IS NULL');
   ELSE
          dbe_output.print_line('NOT NULL');
   END IF;
   dbe_xmldom.writetobuffer(node1, buffer1);
   dbe_output.print_line('buffer1: ');
   dbe_output.print_line(buffer1);
END;
/
-- 预期结果为：
NOTICE:  len :  4
NOT NULL
buffer1:
<title lang="en">Everyday Italian</title>
ANONYMOUS BLOCK EXECUTE
```
- DBE_XMLDOM.ITEM根据索引返回list中与索引对应的元素。DBE_XMLDOM.ITEM的函数原型为： 根据索引返回map中与索引对应的元素。DBE_XMLDOM.ITEM的函数原型为： map类型函数item对不合理的参数输入：如bool、clob，会默认指向第一个index的值。 示例：
```
DBE_XMLDOM.MAKEELEMENT(
   n IN DOMNODE)
RETURN DOMELEMENT;
```

| 参数 | 描述 |
|---|---|
| n | 指定的DOMNODE对象。 |

```
--将DOMELEMENT类型转换后的DOMNODE类型节点node强制转换回DOMELEMENT类型。
DECLARE
  buf VARCHAR2(1000);
  doc DBE_XMLDOM.DOMDocument;
  elem DBE_XMLDOM.DOMElement;
  elem2 DBE_XMLDOM.DOMElement;
  node DBE_XMLDOM.DOMNode;
BEGIN
  doc := DBE_XMLDOM.NEWDOMDOCUMENT();
  elem := DBE_XMLDOM.createElement(doc, 'aaa');
  node := DBE_XMLDOM.makeNode(elem);
  elem2 := DBE_XMLDOM.makeElement(node);
  buf := DBE_XMLDOM.GETNODENAME(DBE_XMLDOM.makeNode(elem2));
  DBE_OUTPUT.print_line(buf);
END;
/
-- 预期结果为：
aaa
ANONYMOUS BLOCK EXECUTE
```
- DBE_XMLDOM.MAKEELEMENT返回转换后的DOMELEMENT对象。DBE_XMLDOM.MAKEELEMENT的函数原型为： 示例：
```
DBE_XMLDOM.MAKENODE(
   a        IN     DOMATTR)
 RETURN DOMNODE;
```
```
DBE_XMLDOM.MAKENODE(
   doc      IN     DOMDOCUMENT)
 RETURN DOMNODE;
```
```
DBE_XMLDOM.MAKENODE(
   elem       IN     DOMELEMENT)
 RETURN DOMNODE;
```
```
DBE_XMLDOM.MAKENODE(
   t       IN     DOMTEXT)
 RETURN DOMNODE;
```

| 参数 | 描述 |
|---|---|
| a | 指定的DOMATTR类型节点。 |
| doc | 指定的DOMDOCUMENT类型节点。 |
| elem | 指定的DOMELEMENT类型节点。 |
| t | 指定的DOMTEXT类型节点。 |

```
return DBE_XMLDOM.MAKENODE(doc);
```
```
tmp_node := DBE_XMLDOM.MAKENODE(doc );
return tmp_node;
```
```
--1. createattr生成ATTR,将其转换为node。
DECLARE
  doc DBE_XMLDOM.DOMDocument;
  attr DBE_XMLDOM.DOMATTR;
  dom_node DBE_XMLDOM.DOMNode;
  buf VARCHAR2(1000);
BEGIN
  doc := DBE_xmldom.newdomdocument('<?xml version="1.0"?>
      <!DOCTYPE note [<!ELEMENT note (to,from,heading,body)>
      <!ELEMENT to (#PCDATA)>
      <!ELEMENT from (#PCDATA)>
      <!ELEMENT heading (#PCDATA)>
      <!ELEMENT body (#PCDATA)>]>
      <note><to>中文</to>
      <from>Jani</from>
      <heading>Reminder</heading>
      <body>Don''t forget me this weekend!</body>
      </note>');
   attr := DBE_XMLDOM.CREATEATTRIBUTE (doc, 'length');
   dom_node := DBE_XMLDOM.makeNode(attr);
   buf := DBE_XMLDOM.getNodeName(dom_node);
   DBE_OUTPUT.print_line(buf);
END;
/
-- 预期结果为：
length
ANONYMOUS BLOCK EXECUTE
--2. getdocumentelement函数生成elem节点后进行makenode。
DECLARE
  doc DBE_XMLDOM.DOMDocument;
  root DBE_XMLDOM.DOMElement;
  attr DBE_XMLDOM.DOMATTR;
  node DBE_XMLDOM.DOMNODE;
  buf VARCHAR2(1000);
BEGIN
  doc := DBE_xmldom.newdomdocument('<?xml version="1.0"?>
      <!DOCTYPE note [<!ELEMENT note (to,from,heading,body)>
      <!ATTLIST note color CDATA #REQUIRED>
      <!ELEMENT to (#PCDATA)>
      <!ELEMENT from (#PCDATA)>
      <!ELEMENT heading (#PCDATA)>
      <!ELEMENT body (#PCDATA)>]>
      <note color="red"><to>中文</to>
      <from>Jani</from>
      <heading>Reminder</heading>
      <body>Don''t forget me this weekend!</body>
      </note>');
  root := DBE_XMLDOM.getDocumentElement(doc);
  node := DBE_XMLDOM.makenode(root);
  DBE_OUTPUT.print_line(DBE_XMLDOM.GETNODENAME(node));
END;
/
-- 预期结果为：
note
ANONYMOUS BLOCK EXECUTE
--3. 通过newdomdocument创建DOMDOCUMENT类型参数，非空内容，并作为MAKENODE的输入参数。
DECLARE
  doc DBE_XMLDOM.DOMDocument;
  buf VARCHAR2(1000);
  dom_node DBE_XMLDOM.DOMNODE;
BEGIN
  doc := DBE_xmldom.newdomdocument('<?xml version="1.0"?>
              <!DOCTYPE note [<!ELEMENT note (to,from,heading,body)>
              <!ELEMENT to (#PCDATA)>
              <!ELEMENT from (#PCDATA)>
              <!ELEMENT heading (#PCDATA)>
              <!ELEMENT body (#PCDATA)>]>
              <note><to>中文</to>
              <from>Jani</from>
              <heading>Reminder</heading>
              <body>Don''t forget me this weekend!</body>
              </note>');
  DBE_OUTPUT.print_line('doc.id: ');
  DBE_OUTPUT.print_line(doc.id);
  dom_node := DBE_XMLDOM.makeNode(doc);
  DBE_OUTPUT.print_line('dom_node.id: ');
  DBE_OUTPUT.print_line(dom_node.id);
  buf := DBE_XMLDOM.GETNODENAME(dom_node);
  DBE_OUTPUT.print_line(buf);
END;
/
-- 预期结果为（若当前session之前执行过xmldom接口，则结果是不确定的）：
doc.id:
19000000000000001B00000001
dom_node.id:
19000000010000001B00000001
#document
ANONYMOUS BLOCK EXECUTE
--4. DOMTEXT声明变量，不初始化, 并作为MAKENODE的输入参数。
DECLARE
  text DBE_XMLDOM.DOMTEXT;
  buf VARCHAR2(1000);
  dom_node DBE_XMLDOM.DOMNODE;
BEGIN
  dom_node := DBE_XMLDOM.makeNode(text);
  buf := DBE_XMLDOM.GETNODENAME(dom_node);
  DBE_OUTPUT.print_line(buf);
END;
/
-- 预期结果为：
ANONYMOUS BLOCK EXECUTE
```
- DBE_XMLDOM.MAKENODE将给定的DOMATTR类型节点强制转换为DOMNODE类型，返回DOMNODE节点。DBE_XMLDOM.MAKENODE的函数原型为： 将给定的DOMDOCUMENT类型节点强制转换为DOMNODE类型，返回DOMNODE节点。DBE_XMLDOM.MAKENODE的函数原型为： 将给定的DOMELEMENT类型节点强制转换为DOMNODE类型，返回DOMNODE节点。DBE_XMLDOM.MAKENODE的函数原型为： 将给定的DOMTEXT类型节点强制转换为DOMNODE类型，返回DOMNODE节点。DBE_XMLDOM.MAKENODE的函数原型为： 由于语法限制，DBE_XMLDOM.MAKENODE作为函数返回值时，不能直接通过如下命令实现： 建议写为： 示例：
```
DBE_XMLDOM.NEWDOMDOCUMENT
RETURN DOMDOCUMENT;
```
```
DBE_XMLDOM.NEWDOMDOCUMENT(
   xmldoc    IN SYS.XMLTYPE)
RETURN DOMDOCUMENT;
```
```
DBE_XMLDOM.NEWDOMDOCUMENT(
   cl       IN    CLOB)
RETURN DOMDOCUMENT;
```

| 参数 | 描述 |
|---|---|
| xmldoc | 指定的XMLType类型。 |
| cl | 指定的CLOB类型。 |

  - 入参大小需限制在1GB以内。
  - 目前暂不支持外部DTD解析。
  - newdomdocument创建的doc，默认UTF-8字符集。
  - 从同一个xmltype实例中解析出的每一个doc都是独立的，对doc的修改也不会影响到xmltype。
  - 与ORA数据库差异参见DBE_XMLPARSER.PARSECLOB。
示例：
```
--1. 返回新的DOMDOCUMENT对象。
DECLARE
   doc dbe_xmldom.domdocument;
   buffer varchar2(1010);
BEGIN
   doc := dbe_xmldom.newdomdocument();
   dbe_xmldom.setdoctype(doc, 'note', 'sysid', 'pubid');
   dbe_xmldom.writetobuffer(doc, buffer);
   dbe_output.print_line('buffer: ');
   dbe_output.print_line(buffer);
   dbe_xmldom.freedocument(doc);
END;
/
-- 预期结果为：
buffer:
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE note PUBLIC "pubid" "sysid">
ANONYMOUS BLOCK EXECUTE
--2. 返回从指定的CLOB类型创建的新DOMDOCUMENT实例对象。
DECLARE
   doc dbe_xmldom.domdocument;
   buffer varchar2(1010);
BEGIN
   doc := dbe_xmldom.newdomdocument('<?xml version="1.0"?>
       <note><to>test</to><from>Jani</from><heading>Reminder</heading>
       <body>Don''t forget me this weekend!</body></note>');
   dbe_xmldom.writetobuffer(doc, buffer);
   dbe_output.print_line('buffer: ');
   dbe_output.print_line(buffer);
   dbe_xmldom.freedocument(doc);
END;
/
-- 预期结果为：
buffer:
<?xml version="1.0" encoding="UTF-8"?>
<note>
  <to>test</to>
  <from>Jani</from>
  <heading>Reminder</heading>
  <body>Don't forget me this weekend!</body>
</note>
ANONYMOUS BLOCK EXECUTE
--3. 返回从指定的XMLType类型创建的新DOMDOCUMENT实例对象。
DECLARE
doc dbe_xmldom.domdocument;
   xt xmltype;
   buffer varchar2(1010);
BEGIN
   xt := xmltype('<h:data xmlns:h="http://www.w3.org/TR/html4/">
      <h:da1 len="10">test namespace</h:da1>
      <h:da1>bbbbbbbbbb</h:da1>
      </h:data>');
   doc := dbe_xmldom.newdomdocument(xt);
   dbe_xmldom.writetobuffer(doc, buffer);
   dbe_output.print_line('buffer: ');
   dbe_output.print_line(buffer);
   dbe_xmldom.freedocument(doc);
END;
/
-- 预期结果为：
buffer:
<?xml version="1.0" encoding="UTF-8"?>
<h:data xmlns:h="http://www.w3.org/TR/html4/">
  <h:da1 len="10">test namespace</h:da1>
  <h:da1>bbbbbbbbbb</h:da1>
</h:data>
ANONYMOUS BLOCK EXECUTE
```
```
DBE_XMLDOM.SETATTRIBUTE(
   elem    IN  DOMELEMENT,
   name    IN  VARCHAR2,
   value   IN  VARCHAR2);
```
```
DBE_XMLDOM.SETATTRIBUTE(
   elem    IN  DOMELEMENT,
   name    IN  VARCHAR2,
   value   IN  VARCHAR2,
   ns      IN  VARCHAR2);
```

| 参数 | 描述 |
|---|---|
| elem | 指定的DOMELEMENT节点。 |
| name | 属性名称。 |
| value | 属性值。 |
| ns | 命名空间。 |

******
```
--1. 按名称设置DOMELEMENT属性的值。
DECLARE
   doc dbe_xmldom.domdocument;
   elem dbe_xmldom.domelement;
   docnode DBE_XMLDOM.DOMNode;
   buffer varchar2(1010);
   value  varchar(1000);
BEGIN
   doc := dbe_xmldom.newDOMDocument();
   elem := DBE_XMLDOM.CREATEELEMENT(doc, 'root');
   DBE_XMLDOM.setattribute(elem, 'len', '50cm');
   docnode := DBE_XMLDOM.appendChild(DBE_XMLDOM.makeNode(doc), DBE_XMLDOM.makeNode(elem));
   dbe_xmldom.writetobuffer(doc, buffer);
   dbe_output.print_line('buffer: ');
   dbe_output.print_line(buffer);
END;
/
-- 预期结果为：
buffer:
<?xml version="1.0" encoding="UTF-8"?>
<root len="50cm"/>
ANONYMOUS BLOCK EXECUTE
--2. 按名称和命名空间URI设置DOMELEMENT属性的值。
DECLARE
   doc dbe_xmldom.domdocument;
   elem dbe_xmldom.domelement;
   docnode DBE_XMLDOM.DOMNode;
   buffer varchar2(1010);
   value  varchar(1000);
begin
   doc := dbe_xmldom.newDOMDocument();
   elem := DBE_XMLDOM.CREATEELEMENT(doc, 'root');
   DBE_XMLDOM.setattribute(elem, 'len', '50cm', 'www.xxxxx.com');
   docnode := DBE_XMLDOM.appendChild(DBE_XMLDOM.makeNode(doc), DBE_XMLDOM.makeNode(elem));
   dbe_xmldom.writetobuffer(doc, buffer);
   dbe_output.print_line('buffer: ');
   dbe_output.print_line(buffer);
END;
/
-- 预期结果为：
buffer:
<?xml version="1.0" encoding="UTF-8"?>
<root len="50cm"/>
ANONYMOUS BLOCK EXECUTE
--3. 按名称修改DOMELEMENT属性的值。
DECLARE
   doc dbe_xmldom.domdocument;
   elem dbe_xmldom.domelement;
   docnode DBE_XMLDOM.DOMNode;
   buffer varchar2(1010);
   value  varchar(1000);
BEGIN
   doc := dbe_xmldom.newDOMDocument();
   elem := DBE_XMLDOM.CREATEELEMENT(doc, 'root');
   DBE_XMLDOM.setattribute(elem, 'len', '50cm');
   DBE_XMLDOM.setattribute(elem, 'len', '55cm');
   docnode := DBE_XMLDOM.appendChild(DBE_XMLDOM.makeNode(doc), DBE_XMLDOM.makeNode(elem));
   dbe_xmldom.writetobuffer(doc, buffer);
   dbe_output.print_line('buffer: ');
   dbe_output.print_line(buffer);
END;
/
-- 预期结果为：
buffer:
<?xml version="1.0" encoding="UTF-8"?>
<root len="55cm"/>
ANONYMOUS BLOCK EXECUTE
--4. 按名称和命名空间URI修改DOMELEMENT属性的值。
DECLARE
   doc dbe_xmldom.domdocument;
   elem dbe_xmldom.domelement;
   docnode DBE_XMLDOM.DOMNode;
   buffer varchar2(1010);
   value  varchar(1000);
begin
   doc := dbe_xmldom.newDOMDocument();
   elem := DBE_XMLDOM.CREATEELEMENT(doc, 'root');
   DBE_XMLDOM.setattribute(elem, 'len', '50cm', 'www.xxxxx.com');
   DBE_XMLDOM.setattribute(elem, 'len', '55cm', 'www.xxxxx.com');
   docnode := DBE_XMLDOM.appendChild(DBE_XMLDOM.makeNode(doc), DBE_XMLDOM.makeNode(elem));
   dbe_xmldom.writetobuffer(doc, buffer);
   dbe_output.print_line('buffer: ');
   dbe_output.print_line(buffer);
END;
/
-- 预期结果为：
buffer:
<?xml version="1.0" encoding="UTF-8"?>
<root len="55cm"/>
ANONYMOUS BLOCK EXECUTE
```
- DBE_XMLDOM.SETATTRIBUTE按名称设置DOMELEMENT属性的值。DBE_XMLDOM.SETATTRIBUTE的函数原型为： 按名称和命名空间URI设置DOMELEMENT属性的值。DBE_XMLDOM.SETATTRIBUTE的函数原型为： DBE_XMLDOM.SETATTRIBUTE接口可以添加多个属性，属性名称不可以为null，且同一个DOMELEMENT节点不能出现同名属性。如需添加同名属性，应显式的为每个同名属性设置命名空间，但是应尽量避免此类操作。如果属性存在于某命名空间下，当修改属性时，应显式指定命名空间，否则视为添加同名属性。 示例：
```
DBE_XMLDOM.SETCHARSET(
   doc       IN     DOMDocument,
   charset   IN     VARCHAR2);
```

| 参数 | 描述 |
|---|---|
| doc | 指定的DOMDOCUMENT节点 |
| charset | 字符集 |

  - charset限制为60个字节以内。
  - 目前支持的字符集有：UTF-8、UCS-4、UCS-2、ISO-8859-1、ISO-8859-2、ISO-8859-3、ISO-8859-4、ISO-8859-5、ISO-8859-6、ISO-8859-7、ISO-8859-8、ISO-8859-9、ISO-2022-JP、Shift_JIS、EUC-JP、ASCII。输入其他字符集会报错或者可能导致输出乱码。
示例：
```
--为DOC树设置UTF-8字符集后，将DOC树输出到缓冲区。
DECLARE
   doc dbe_xmldom.domdocument;
   buffer varchar2(1010);
BEGIN
   doc := dbe_xmldom.newdomdocument('<?xml version="1.0"?>
       <!DOCTYPE note [<!ELEMENT note (to,from,heading,body)><!ELEMENT to (#PCDATA)>
       <!ELEMENT from (#PCDATA)><!ELEMENT heading (#PCDATA)><!ELEMENT body (#PCDATA)>]>
       <note><to>test</to><from>Jani</from><heading>Reminder</heading>
       <body>Don''t forget me this weekend!</body></note>');
   dbe_xmldom.setcharset(doc, 'utf-8');
   dbe_xmldom.writetobuffer(doc, buffer);
   dbe_output.print_line('buffer: ');
   dbe_output.print_line(buffer);
   dbe_xmldom.freedocument(doc);
END;
/
-- 预期结果为：
buffer:
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE note [
<!ELEMENT note (to , from , heading , body)>
<!ELEMENT to (#PCDATA)>
<!ELEMENT from (#PCDATA)>
<!ELEMENT heading (#PCDATA)>
<!ELEMENT body (#PCDATA)>
]>
<note>
  <to>test</to>
  <from>Jani</from>
  <heading>Reminder</heading>
  <body>Don't forget me this weekend!</body>
</note>
ANONYMOUS BLOCK EXECUTE
```
```
DBE_XMLDOM.SETDOCTYPE(
  doc     IN   DOMDocument,
  name    IN   VARCHAR2,
  sysid   IN   VARCHAR2,
  pubid   IN   VARCHAR2);
```

| 参数 | 描述 |
|---|---|
| doc | 指定的DOMDOCUMENT节点。 |
| name | 需要初始化doctype的名称。 |
| sysid | 需要初始化doctype的system ID。 |
| pubid | 需要初始化doctype的public ID。 |

```
--为DOMDOCUMENT的外部DTD分别设置初始化的system ID、public ID和名称后，分别将每次修改后的DOC树输出到缓冲区。
DECLARE
   doc dbe_xmldom.domdocument;
   buffer varchar2(1010);
begin
   doc := dbe_xmldom.newdomdocument('<?xml version="1.0"?>
       <!DOCTYPE note [<!ELEMENT note (to,from,heading,body)><!ELEMENT to (#PCDATA)>
       <!ELEMENT from (#PCDATA)><!ELEMENT heading (#PCDATA)><!ELEMENT body (#PCDATA)>]>
       <note><to>test</to><from>Jani</from><heading>Reminder</heading>
       <body>Don''t forget me this weekend!</body></note>');
   dbe_xmldom.setdoctype(doc, 'note', 'sysid', 'pubid');
   dbe_xmldom.writetobuffer(doc, buffer);
   dbe_output.print_line('buffer: ');
   dbe_output.print_line(buffer);
   dbe_output.print_line('------------------------------------------------');
   dbe_xmldom.setdoctype(doc, 'n0te', NULL, '');
   dbe_xmldom.setdoctype(doc, 'n0t1e', NULL, '');
   dbe_xmldom.writetobuffer(doc, buffer);
   dbe_output.print_line('buffer: ');
   dbe_output.print_line(buffer);
   dbe_xmldom.freedocument(doc);
END;
/
-- 预期结果为：
buffer:
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE note PUBLIC "pubid" "sysid" [
<!ELEMENT note (to , from , heading , body)>
<!ELEMENT to (#PCDATA)>
<!ELEMENT from (#PCDATA)>
<!ELEMENT heading (#PCDATA)>
<!ELEMENT body (#PCDATA)>
]>
<note>
  <to>test</to>
  <from>Jani</from>
  <heading>Reminder</heading>
  <body>Don't forget me this weekend!</body>
</note>
------------------------------------------------
buffer:
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE n0t1e [
<!ELEMENT note (to , from , heading , body)>
<!ELEMENT to (#PCDATA)>
<!ELEMENT from (#PCDATA)>
<!ELEMENT heading (#PCDATA)>
<!ELEMENT body (#PCDATA)>
]>
<note>
  <to>test</to>
  <from>Jani</from>
  <heading>Reminder</heading>
  <body>Don't forget me this weekend!</body>
</note>
ANONYMOUS BLOCK EXECUTE
```
- DBE_XMLDOM.SETDOCTYPE设置DOMDOCUMENT的外部DTD。DBE_XMLDOM.SETDOCTYPE的函数原型为： name、sysid、pubid的总长度限制在32500个字节以内。 示例：
```
DBE_XMLDOM.SETNODEVALUE(
 n IN DOMNODE,
 nodeValue IN VARCHAR2);
```

| 参数 | 描述 |
|---|---|
| n | 指定的DOMNODE对象。 |
| nodeValue | 向DOMNODE对象中设置的字符串。 |

  - nodeValue可以输入空字符串和NULL值，但不会对节点值进行修改。
  - nodeValue支持转义字符'&'，序列化时自动转义。
  - nodeValue默认的最大长度受限于VARCHAR2类型，为32767字节，超过该长度会抛出异常。
示例：
```
--对DOMTEXT转换后的DOMNODE节点设置与初始值不同的节点值后，获取并输出该节点的值。
DECLARE
  buf VARCHAR2(1000);
  doc DBE_XMLDOM.DOMDocument;
  text DBE_XMLDOM.DOMText;
  elem2 DBE_XMLDOM.DOMElement;
  node DBE_XMLDOM.DOMNode;
BEGIN
  doc := DBE_XMLDOM.NEWDOMDOCUMENT();
  text := DBE_XMLDOM.createTextNode(doc, 'aaa');
  DBE_XMLDOM.SETNODEVALUE(DBE_XMLDOM.makeNode(text), 'ccc');
  buf := DBE_XMLDOM.GETNODEVALUE(DBE_XMLDOM.makeNode(text));
  DBE_OUTPUT.print_line(buf);
END;
/
-- 预期结果为：
ccc
ANONYMOUS BLOCK EXECUTE
```
```
DBE_XMLDOM.WRITETOBUFFER(
   doc       IN      DOMDOCUMENT,
   buffer   INOUT  VARCHAR2);
```
```
DBE_XMLDOM.WRITETOBUFFER(
   n        IN      DOMNODE,
   buffer   INOUT  VARCHAR2);
```

| 参数 | 描述 |
|---|---|
| doc | 指定的DOMDOCUMENT节点。 |
| buffer | 写入操作的缓冲区。 |
| n | 指定的DOMNODE节点。 |

  - writetobuffer输出buffer限制在1GB以内。
  - 该函数会添加缩进等内容，将输出格式化。输出doc将包含XML声明version和encoding。
  - 默认以UTF-8字符集输出xml。
示例：
```
--1. 输入DOMNODE类型参数。
DECLARE
   doc dbe_xmldom.domdocument;
   elem DBE_XMLDOM.DOMELEMENT;
   buf varchar2(1000);
BEGIN
    doc := dbe_xmldom.newdomdocument();
    elem := dbe_xmldom.createelement(doc,'elem');
    DBE_XMLDOM.WRITETOBUFFER(dbe_xmldom.makenode(elem), buf);
    DBE_OUTPUT.print_line(buf);
END;
/
-- 预期结果为：
<elem/>
ANONYMOUS BLOCK EXECUTE
--2. 输入DOMDOCUMENT类型参数。
DECLARE
  doc DBE_XMLDOM.DOMDocument;
  buf VARCHAR2(1000);
BEGIN
  doc := dbe_xmldom.newdomdocument('<?xml version="1.0"?>
       <!DOCTYPE note [<!ELEMENT note (to,from,heading,body)><!ELEMENT to (#PCDATA)>
       <!ELEMENT from (#PCDATA)><!ELEMENT heading (#PCDATA)><!ELEMENT body (#PCDATA)>]>
       <note><to>test</to><from>Jani</from><heading>Reminder</heading>
       <body>Don''t forget me this weekend!</body></note>');
  DBE_XMLDOM.WRITETOBUFFER(doc, buf);
  DBE_OUTPUT.print_line('doc: ');
  DBE_OUTPUT.print_line(buf);
  DBE_XMLDOM.FREEDOCUMENT(doc);
END;
/
-- 预期结果为：
doc:
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE note [
<!ELEMENT note (to , from , heading , body)>
<!ELEMENT to (#PCDATA)>
<!ELEMENT from (#PCDATA)>
<!ELEMENT heading (#PCDATA)>
<!ELEMENT body (#PCDATA)>
]>
<note>
  <to>test</to>
  <from>Jani</from>
  <heading>Reminder</heading>
  <body>Don't forget me this weekend!</body>
</note>
ANONYMOUS BLOCK EXECUTE
```
```
DBE_XMLDOM.WRITETOCLOB(
   doc     IN      DOMDOCUMENT,
   cl      INOUT  CLOB);
```
```
DBE_XMLDOM.WRITETOCLOB(
   n       IN      DOMNODE,
   cl      INOUT  CLOB);
```

| 参数 | 描述 |
|---|---|
| doc | 指定的DOMDOCUMENT节点。 |
| cl | 要写入的CLOB。 |
| n | 指定的DOMNODE节点。 |

  - document入参，writetoclob大小支持1GB以内。
  - 该函数会添加缩进等内容，将输出格式化。输出doc将包含XML声明version和encoding。
  - 默认以UTF-8字符集输出xml。
示例：
```
--1. 输入DOMNODE类型参数。
DECLARE
  CL  CLOB;
  N   DBE_XMLDOM.DOMNODE;
BEGIN
  DBE_XMLDOM.WRITETOCLOB(N, CL);
  DBE_OUTPUT.PRINT_LINE(CL);
END;
/
-- 预期结果为：
ANONYMOUS BLOCK EXECUTE
--2. 输入DOMDOCUMENT类型参数。
DECLARE
    doc dbe_xmldom.domdocument;
    mclob clob;
BEGIN
    doc := dbe_xmldom.newdomdocument('<?xml version="1.0"?>
       <!DOCTYPE note [<!ELEMENT note (to,from,heading,body)><!ELEMENT to (#PCDATA)>
       <!ELEMENT from (#PCDATA)><!ELEMENT heading (#PCDATA)><!ELEMENT body (#PCDATA)>]>
       <note><to>test</to><from>Jani</from><heading>Reminder</heading>
       <body>Don''t forget me this weekend!</body></note>');
    dbe_xmldom.writetoclob(doc, mclob);
    dbe_output.print_line('mclob: ');
    dbe_output.print_line(mclob);
    dbe_xmldom.freedocument(doc);
END;
/
-- 预期结果为：
mclob:
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE note [
<!ELEMENT note (to , from , heading , body)>
<!ELEMENT to (#PCDATA)>
<!ELEMENT from (#PCDATA)>
<!ELEMENT heading (#PCDATA)>
<!ELEMENT body (#PCDATA)>
]>
<note>
  <to>test</to>
  <from>Jani</from>
  <heading>Reminder</heading>
  <body>Don't forget me this weekend!</body>
</note>
ANONYMOUS BLOCK EXECUTE
```
```
DBE_XMLDOM.WRITETOCLOB(
   doc     IN      DOMDOCUMENT,
   fileName   IN      VARCHAR2);
```
```
DBE_XMLDOM.WRITETOCLOB(
   n       IN      DOMNODE,
   fileName   IN      VARCHAR2);
```
```
DBE_XMLDOM.WRITETOCLOB(
   doc     IN      DOMDOCUMENT,
   fileName   IN      VARCHAR2,
   charset   IN   VARCHAR2);
```
```
DBE_XMLDOM.WRITETOCLOB(
   n       IN      DOMNODE,
   fileName   IN      VARCHAR2,
   charset   IN   VARCHAR2);
```

| 参数 | 描述 |
|---|---|
| doc | 指定的DOMDOCUMENT节点。 |
| fileName | 要写入的文件。 |
| n | 指定的DOMNODE节点。 |
| charset | 指定字符集。 |

  - document入参，filename长度限制在255个字节以内，charset限制在60个字节以内，charset支持字符集请参考DBE_XMLDOM.SETCHARSET接口。
  - 该函数会添加缩进等内容，将输出格式化。输出doc将包含XML声明version和encoding。
  - 传入newdomdocument()无参创建的doc，在不指定charset时不会报错，默认UTF-8字符集。
  - filename需要在pg_directory中创建的路径下，filename中的\会被转换成/，只允许存在一个/。文件名格式应为pg_directory_name/file_name.xml，输出文件仅支持xml类型。
  - 在打开guc参数safe_data_path时，用户只能通过高级包读写safe_data_path指定文件路径下的文件。
  - 创建目录前需要保证路径为操作系统实际存在的路径，且用户需要拥有该目录的读和写权限。关于目录创建，请参考CREATE DIRECTORY。
示例：
```
--创建目录前需要保证路径为操作系统实际存在的路径，且用户需要拥有该目录的读和写权限
create directory dir as '/tmp';
--1. 使用数据库字符集将 XML 节点写入指定文件。
DECLARE
  FPATH VARCHAR2(1000);
  DOC   DBE_XMLDOM.DOMDOCUMENT;
BEGIN
  DOC := DBE_XMLDOM.NEWDOMDOCUMENT('<ROOT>
    <A ATTR1="A_VALUE">
        <ACHILD>ACHILD TXT</ACHILD>
    </A>
    <B>B TXT</B>
    <C/>
  </ROOT>');
  FPATH := 'dir/simplexml.xml';
  DBE_XMLDOM.WRITETOFILE(DOC, FPATH);
END;
/
-- 预期结果为：
ANONYMOUS BLOCK EXECUTE
--2. 使用指定字符集将 XML 文档写入指定文件。
DECLARE
  SRC   VARCHAR(1000);
  FPATH VARCHAR2(1000);
  DOC   DBE_XMLDOM.DOMDOCUMENT;
  ELE   DBE_XMLDOM.DOMELEMENT;
BEGIN
  FPATH := 'dir/simplexml.xml';
  SRC := '<ROOT>
    <A ATTR1="A_VALUE">
        <ACHILD>ACHILD TXT</ACHILD>
    </A>
    <B>B TXT</B>
    <C/>
  </ROOT>';
  DOC := DBE_XMLDOM.NEWDOMDOCUMENT(SRC);
  ELE := DBE_XMLDOM.GETDOCUMENTELEMENT(DOC);
  DBE_XMLDOM.WRITETOFILE(DBE_XMLDOM.MAKENODE(ELE), FPATH, 'ASCII');
  DBE_XMLDOM.FREEDOCUMENT(DOC);
END;
/
-- 预期结果为：
ANONYMOUS BLOCK EXECUTE
-- 清理环境
drop directory dir;
```
```
DBE_XMLDOM.GETSESSIONTREENUM()
RETURN INTEGER;
```
```
-- 创建三个document，并获取当前session中所有dom树的数量
DECLARE
  doc DBE_XMLDOM.DOMDocument;
  doc2 DBE_XMLDOM.DOMDocument;
  doc3 DBE_XMLDOM.DOMDocument;
  buffer varchar2(1010);
BEGIN
  -- 创建三个document
  doc := DBE_XMLDOM.NEWDOMDOCUMENT('<?xml version="1.0"?>
<root>
    <elem1 attr="attrtest">
        <elem2>Im text</elem2>
        <elem3>Im text too</elem3>
    </elem1>
    <elem4>Text</elem4>
</root>
');
  doc2 := DBE_XMLDOM.NEWDOMDOCUMENT('<?xml version="1.0"?>
<computer size="ITX" price="19999">
    <cpu>Ryzen 9 3950X</cpu>
    <ram>32GBx2 DDR4 3200MHz</ram>
    <motherboard>ROG X570i</motherboard>
    <gpu>RTX2070 Super</gpu>
    <ssd>1TB NVMe Toshiba + 2TB NVMe WD Black</ssd>
    <hdd>12TB WD Digital</hdd>
    <psu>CORSAIR SF750</psu>
    <case>LIANLI TU150</case>
</computer>
');
  doc3 := DBE_XMLDOM.NEWDOMDOCUMENT('<?xml version="1.0"?>
<bookstore>
    <book genre="autobiography" publicationdate="1981" ISBN="1-861003-11-0">
        <title>The Autobiography of Benjamin Franklin</title>
        <author>
            <first-name>Benjamin</first-name>
            <last-name>Franklin</last-name>
        </author>
        <price>8.99</price>
    </book>
    <book genre="novel" publicationdate="1967" ISBN="0-201-63361-2">
        <title>The Confidence Man</title>
        <author>
            <first-name>Herman</first-name>
            <last-name>Melville</last-name>
        </author>
        <price>11.99</price>
    </book>
    <book genre="philosophy" publicationdate="1991" ISBN="1-861001-57-6">
        <title>The Gorgias</title>
        <author>
            <name>Plato</name>
        </author>
        <price>9.99</price>
    </book>
</bookstore>
');
  -- 打印id
  DBE_OUTPUT.PRINT_LINE(doc.id);
  DBE_OUTPUT.PRINT_LINE(doc2.id);
  DBE_OUTPUT.PRINT_LINE(doc3.id);
  -- 调用该函数并打印
  DBE_OUTPUT.PRINT_LINE(DBE_XMLDOM.GETSESSIONTREENUM());
  -- 释放document
  DBE_XMLDOM.FREEDOCUMENT(doc);
  DBE_XMLDOM.FREEDOCUMENT(doc2);
  DBE_XMLDOM.FREEDOCUMENT(doc3);
END;
/
-- 预期结果为（若当前session之前执行过xmldom接口，则结果是不确定的）：
00000000000000000200000001
01000000000000000300000001
02000000000000000400000001
3
ANONYMOUS BLOCK EXECUTE
```
- DBE_XMLDOM.GETSESSIONTREENUM查询当前session中所有类型的dom树数量。DBE_XMLDOM.GETSESSIONTREENUM的函数原型为： 对于使用过FREEELEMENT和FREENODE的dom树，该函数依然会将其统计在内。 示例：
```
DBE_XMLDOM.GETDOCTREESINFO()
RETURN VARCHAR2;
```
```
-- 创建三个document，并获取当前session中document类型的树的信息
DECLARE
  doc DBE_XMLDOM.DOMDocument;
  doc2 DBE_XMLDOM.DOMDocument;
  doc3 DBE_XMLDOM.DOMDocument;
  buffer varchar2(1010);
BEGIN
  -- 创建三个document
  doc := DBE_XMLDOM.NEWDOMDOCUMENT('<?xml version="1.0"?>
<root>
    <elem1 attr="attrtest">
        <elem2>Im text</elem2>
        <elem3>Im text too</elem3>
    </elem1>
    <elem4>Text</elem4>
</root>
');
  doc2 := DBE_XMLDOM.NEWDOMDOCUMENT('<?xml version="1.0"?>
<computer size="ITX" price="19999">
    <cpu>Ryzen 9 3950X</cpu>
    <ram>32GBx2 DDR4 3200MHz</ram>
    <motherboard>ROG X570i</motherboard>
    <gpu>RTX2070 Super</gpu>
    <ssd>1TB NVMe Toshiba + 2TB NVMe WD Black</ssd>
    <hdd>12TB WD Digital</hdd>
    <psu>CORSAIR SF750</psu>
    <case>LIANLI TU150</case>
</computer>
');
  doc3 := DBE_XMLDOM.NEWDOMDOCUMENT('<?xml version="1.0"?>
<bookstore>
    <book genre="autobiography" publicationdate="1981" ISBN="1-861003-11-0">
        <title>The Autobiography of Benjamin Franklin</title>
        <author>
            <first-name>Benjamin</first-name>
            <last-name>Franklin</last-name>
        </author>
        <price>8.99</price>
    </book>
    <book genre="novel" publicationdate="1967" ISBN="0-201-63361-2">
        <title>The Confidence Man</title>
        <author>
            <first-name>Herman</first-name>
            <last-name>Melville</last-name>
        </author>
        <price>11.99</price>
    </book>
    <book genre="philosophy" publicationdate="1991" ISBN="1-861001-57-6">
        <title>The Gorgias</title>
        <author>
            <name>Plato</name>
        </author>
        <price>9.99</price>
    </book>
</bookstore>
');
  -- 打印id
  DBE_OUTPUT.PRINT_LINE(doc.id);
  DBE_OUTPUT.PRINT_LINE(doc2.id);
  DBE_OUTPUT.PRINT_LINE(doc3.id);
  -- 调用该函数并打印
  DBE_OUTPUT.PRINT_LINE(DBE_XMLDOM.GETDOCTREESINFO());
  -- 释放document
  DBE_XMLDOM.FREEDOCUMENT(doc);
  DBE_XMLDOM.FREEDOCUMENT(doc2);
  DBE_XMLDOM.FREEDOCUMENT(doc3);
END;
/
-- 预期结果为（若当前session之前执行过xmldom接口，则结果是不确定的）：
00000000000000000200000001
01000000000000000300000001
02000000000000000400000001

|ID:00000000000000000200000001	|Node count:11	|Memory used:151 byte	|
|ID:01000000000000000300000001	|Node count:22	|Memory used:322 byte	|
|ID:02000000000000000400000001	|Node count:48	|Memory used:654 byte	|

ANONYMOUS BLOCK EXECUTE
```
- DBE_XMLDOM.GETDOCTREESINFO查询当前session中Document类型的dom树信息，如内存占用等。DBE_XMLDOM.GETDOCTREESINFO的函数原型为： 该函数只统计Document类型的dom树节点。 示例：
```
DBE_XMLDOM.GETDETAILDOCTREEINFO(
    doc     IN      DOMDOCUMENT
)
RETURN VARCHAR2;
```

| 参数 | 描述 |
|---|---|
| doc | 指定的DOMDOCUMENT节点 |

```
-- 创建三个document，并使用该函数分别获取每一个document内的各类型节点数量
DECLARE
  doc DBE_XMLDOM.DOMDocument;
  doc2 DBE_XMLDOM.DOMDocument;
  doc3 DBE_XMLDOM.DOMDocument;
  buffer varchar2(1010);
BEGIN
  -- 创建三个document
  doc := DBE_XMLDOM.NEWDOMDOCUMENT('<?xml version="1.0"?>
<root>
    <elem1 attr="attrtest">
        <elem2>Im text</elem2>
        <elem3>Im text too</elem3>
    </elem1>
    <elem4>Text</elem4>
</root>
');
  doc2 := DBE_XMLDOM.NEWDOMDOCUMENT('<?xml version="1.0"?>
<computer size="ITX" price="19999">
    <cpu>Ryzen 9 3950X</cpu>
    <ram>32GBx2 DDR4 3200MHz</ram>
    <motherboard>ROG X570i</motherboard>
    <gpu>RTX2070 Super</gpu>
    <ssd>1TB NVMe Toshiba + 2TB NVMe WD Black</ssd>
    <hdd>12TB WD Digital</hdd>
    <psu>CORSAIR SF750</psu>
    <case>LIANLI TU150</case>
</computer>
');
  doc3 := DBE_XMLDOM.NEWDOMDOCUMENT('<?xml version="1.0"?>
<bookstore>
    <book genre="autobiography" publicationdate="1981" ISBN="1-861003-11-0">
        <title>The Autobiography of Benjamin Franklin</title>
        <author>
            <first-name>Benjamin</first-name>
            <last-name>Franklin</last-name>
        </author>
        <price>8.99</price>
    </book>
    <book genre="novel" publicationdate="1967" ISBN="0-201-63361-2">
        <title>The Confidence Man</title>
        <author>
            <first-name>Herman</first-name>
            <last-name>Melville</last-name>
        </author>
        <price>11.99</price>
    </book>
    <book genre="philosophy" publicationdate="1991" ISBN="1-861001-57-6">
        <title>The Gorgias</title>
        <author>
            <name>Plato</name>
        </author>
        <price>9.99</price>
    </book>
</bookstore>
');
  -- 打印id
  DBE_OUTPUT.PRINT_LINE(doc.id);
  DBE_OUTPUT.PRINT_LINE(doc2.id);
  DBE_OUTPUT.PRINT_LINE(doc3.id);
  -- 调用该函数并打印
  buffer := DBE_XMLDOM.GETDETAILDOCTREEINFO(doc);
  DBE_OUTPUT.PRINT_LINE(buffer);
  buffer := DBE_XMLDOM.GETDETAILDOCTREEINFO(doc2);
  DBE_OUTPUT.PRINT_LINE(buffer);
  buffer := DBE_XMLDOM.GETDETAILDOCTREEINFO(doc3);
  DBE_OUTPUT.PRINT_LINE(buffer);
  -- 释放document
  DBE_XMLDOM.FREEDOCUMENT(doc);
  DBE_XMLDOM.FREEDOCUMENT(doc2);
  DBE_XMLDOM.FREEDOCUMENT(doc3);
END;
/
-- 预期结果为（若当前session之前执行过xmldom接口，则结果是不确定的）：
00000000000000000200000001
01000000000000000300000001
02000000000000000400000001

|ID:00000000000000000200000001	|Element count:5	|Attribute count:1	|Text count:4	|
|ID:01000000000000000300000001	|Element count:9	|Attribute count:2	|Text count:10	|
|ID:02000000000000000400000001	|Element count:18	|Attribute count:9	|Text count:20	|

ANONYMOUS BLOCK EXECUTE
```
- DBE_XMLDOM.GETDETAILDOCTREEINFO查询传入的document内的各类型子节点的数量。DBE_XMLDOM.GETDETAILDOCTREEINFO的函数原型为： 该函数只统计Document类型的dom树节点。 示例：
```
DBE_XMLDOM.GETELEMENTSBYTAGNAME(
   doc        IN      DOMDOCUMENT,
   tagname    IN      VARCHAR2)
RETURN DOMNODELIST;
```
```
DBE_XMLDOM.GETELEMENTSBYTAGNAME(
   elem       IN      DOMELEMENT,
   tagname       IN      VARCHAR2)
RETURN DOMNODELIST;
```
```
DBE_XMLDOM.GETELEMENTSBYTAGNAME(
   elem      IN     DOMELEMENT,
   tagname      IN     VARCHAR2,
   ns        IN     VARCHAR2)
 RETURN DOMNODELIST;
```

| 参数 | 描述 |
|---|---|
| doc | 指定的DOMDOCUMENT节点。 |
| elem | 指定的DOMELEMENT节点。 |
| tagname | 标签名称。使用通配符（*）将匹配任何标签。 |
| ns | 命名空间。使用通配符（*）将匹配任何命名空间。 |

****
```
--1. 在DOMDOCUMENT节点通过TAGNAME匹配查找，返回匹配的DOMNODELIST节点列表。
DECLARE
  doc DBE_XMLDOM.DOMDocument;
  root_elem DBE_XMLDOM.DOMElement;
  child_node DBE_XMLDOM.DOMNODE;
  node_list DBE_XMLDOM.DOMNODELIST;
  buffer VARCHAR2(1000);
BEGIN
  doc := DBE_XMLDOM.NEWDOMDOCUMENT('<?xml version="1.0" encoding="UTF-8"?>
<computer size="ITX" price="19999">
    <cpu>Ryzen 9 3950X</cpu>
    <cpu>Ryzen 9 5950X_1</cpu>
    <ram>32GBx2 DDR4 3200MHz<cpu>Ryzen <cpu>Ryzen 9 5950X_2</cpu></cpu></ram>
    <motherboard>ROG X570i</motherboard>
    <gpu>RTX2070 Super</gpu>
    <ssd>1TB NVMe Toshiba + 2TB NVMe WD Black</ssd>
    <hdd>12TB WD Digital</hdd>
    <psu>CORSAIR SF750</psu>
    <case>LIANLI TU150</case>
</computer>');
  root_elem := DBE_XMLDOM.GETDOCUMENTELEMENT(doc);
  node_list := DBE_XMLDOM.GETELEMENTSBYTAGNAME(doc, 'cpu');
  child_node := DBE_XMLDOM.ITEM(node_list, 2);
  DBE_XMLDOM.WRITETOBUFFER(child_node, buffer);
  DBE_OUTPUT.PRINT_LINE(buffer);
END;
/
-- 预期结果为：
<cpu>Ryzen <cpu>Ryzen 9 5950X_2</cpu></cpu>
ANONYMOUS BLOCK EXECUTE
--2. 在DOMELEMENT节点通过TAGNAME匹配查找，返回匹配的DOMNODELIST节点列表。
DECLARE
  doc DBE_XMLDOM.DOMDocument;
  root_elem DBE_XMLDOM.DOMElement;
  child_node DBE_XMLDOM.DOMNODE;
  node_list DBE_XMLDOM.DOMNODELIST;
  buffer VARCHAR2(1000);
BEGIN
  doc := DBE_XMLDOM.NEWDOMDOCUMENT(
    '<?xml version="1.0" encoding="UTF-8"?>' ||
    '<computer size="ITX" price="19999">' ||
    '<cpu>Ryzen 9 3950X</cpu>' ||
    '<cpu>Ryzen 9 5950X_1</cpu>' ||
    '<ram>32GBx2 DDR4 3200MHz' ||
        '<cpu>Ryzen 9 5950X_2' ||
            '<cpu>Ryzen 9 5950X_3' ||
                '<cpu>Ryzen 9 5950X_4</cpu>' ||
            '</cpu>' ||
        '</cpu>' ||
    '</ram>' ||
    '</computer>');
  root_elem := DBE_XMLDOM.GETDOCUMENTELEMENT(doc);
  node_list := DBE_XMLDOM.GETELEMENTSBYTAGNAME(root_elem, 'cpu');
  child_node := DBE_XMLDOM.ITEM(node_list, 3);
  DBE_XMLDOM.WRITETOBUFFER(child_node, buffer);
  DBE_OUTPUT.PRINT_LINE(buffer);
END;
/
-- 预期结果为：
<cpu>Ryzen 9 5950X_3<cpu>Ryzen 9 5950X_4</cpu></cpu>
ANONYMOUS BLOCK EXECUTE
--3. 在DOMELEMENT节点通过TAGNAME以及NAMESPACE匹配查找，返回匹配的DOMNODELIST节点列表。
DECLARE
  doc DBE_XMLDOM.DOMDocument;
  root_elem DBE_XMLDOM.DOMElement;
  child_node DBE_XMLDOM.DOMNODE;
  node_list DBE_XMLDOM.DOMNODELIST;
  buffer VARCHAR2(1000);
BEGIN
  doc := DBE_XMLDOM.NEWDOMDOCUMENT('<?xml version="1.0" encoding="UTF-8"?>
<computer size="ITX" price="19999" xmlns:h="www.xxxxx.com">
    <cpu>Ryzen 9 3950X</cpu>
    <cpu>Ryzen 9 5950X_1</cpu>
    <h:cpu>ns Ryzen 9 5950X_2</h:cpu>
    <ram>32GBx2 DDR4 3200MHz<cpu>Ryzen 9 5950X_3<cpu>Ryzen 9 5950X_4<cpu>Ryzen 9 5950X_5</cpu></cpu></cpu></ram>
    <motherboard>ROG X570i</motherboard>
    <gpu>RTX2070 Super</gpu>
    <ssd>1TB NVMe Toshiba + 2TB NVMe WD Black</ssd>
    <hdd>12TB WD Digital</hdd>
    <psu>CORSAIR SF750</psu>
    <case>LIANLI TU150</case>
</computer>');
  root_elem := DBE_XMLDOM.GETDOCUMENTELEMENT(doc);
  node_list := DBE_XMLDOM.GETELEMENTSBYTAGNAME(root_elem, 'cpu', 'www.xxxxx.com');
  child_node := DBE_XMLDOM.ITEM(node_list, 0);
  DBE_XMLDOM.WRITETOBUFFER(child_node, buffer);
  DBE_OUTPUT.PRINT_LINE(buffer);
END;
/
-- 预期结果为：
<h:cpu>ns Ryzen 9 5950X_2</h:cpu>
ANONYMOUS BLOCK EXECUTE
```
- DBE_XMLDOM.GETELEMENTSBYTAGNAMXML中按名称查找返回DOMNODELIST的节点。DBE_XMLDOM.GETELEMENTSBYTAGNAME的函数原型为： XML中按名称查找返回DOMNODELIST的节点。DBE_XMLDOM.GETELEMENTSBYTAGNAME的函数原型为： XML中按名称和命名空间查找返回DOMNODELIST的节点。DBE_XMLDOM.GETELEMENTSBYTAGNAME的函数原型为： 示例：
父主题：
二次封装接口
版权所有 © 华为技术有限公司
< 上一节
下一节 >



---


---

## DBE_XMLGEN

#### 接口介绍
DBE_XMLGEN系统包将SQL查询的结果转换为规范的XML格式，并将结果返回。支持的所有接口参考表2。

| 类型名称 | 描述 |
|---|---|
| DBE_XMLGEN.CTXHANDLE | 用于存储XML输出状态的数据类型。 |

 - 在同一个session中context handle最多只允许存在65535个。关闭context handle并不会回收这个数量。
- 输出的xml中表字段、类型与用户创建的表字段与类型大小写一致，如果需要大写字段与类型名需要在创建时用双引号包裹，显式指定。
- NEWCONTEXTFROMHIERARCHY初始化时，能够调用SETNULLHANDLING、USENULLATTRIBUTEINDICATOR、SETCONVERTSPECIALCHARS方法设置，但不生效。

| 接口名称 | 描述 |
|---|---|
| DBE_XMLGEN.CONVERT | 将输入的字符串进行xml编码或解码操作。 |
| DBE_XMLGEN.NEWCONTEXT | 初始化普通context handle。 |
| DBE_XMLGEN.NEWCONTEXTFROMHIERARCHY | 初始化带有递归元素的context handle。 |
| DBE_XMLGEN.SETCONVERTSPECIALCHARS | 设置输出的xml是否需要xml编码。 |
| DBE_XMLGEN.SETNULLHANDLING | 设置xml中null值如何展示。 |
| DBE_XMLGEN.SETROWSETTAG | 设置xml根节点名称。 |
| DBE_XMLGEN.SETROWTAG | 设置xml中每一行数据的tag名。 |
| DBE_XMLGEN.USENULLATTRIBUTEINDICATOR | 对xml中的null值所在的元素添加xsi:nil="true"属性。 |
| DBE_XMLGEN.USEITEMTAGSFORCOLL | 对数组类型变量所在的元素中添加'_ITEM'后缀。 |
| DBE_XMLGEN.GETNUMROWSPROCESSED | 查看上一次getxml或者getxmltype返回的数据行数。 |
| DBE_XMLGEN.SETMAXROWS | 设置getxml最大的返回行数。 |
| DBE_XMLGEN.SETSKIPROWS | 设置跳过sql行数。 |
| DBE_XMLGEN.RESTARTQUERY | 重启SQL。 |
| DBE_XMLGEN.GETXMLTYPE | 返回XMLTYPE类型的xml文本。 |
| DBE_XMLGEN.GETXML | 返回CLOB类型的xml文本。 |
| DBE_XMLGEN.CLOSECONTEXT | 关闭context handle。 |
| 原始值 | 编码值 |
|---|---|
| & | &amp; |
| < | &lt; |
| > | &gt; |
| " | &quot; |
| ' | &apos; |

```
DBE_XMLGEN.CONVERT(XMLSTR IN VARCHAR2, FLAG IN NUMBER := 0) RETURNS VARCHAR2;
DBE_XMLGEN.CONVERT(XMLCLOB IN CLOB, FLAG IN NUMBER := 0) RETURNS CLOB;
```

| 参数 | 描述 |
|---|---|
| XMLSTR | 需要转换的XML字符串，VARCHAR2类型。 |
| XMLCLOB | 需要转换的XML字符串， CLOB类型。 |
| FLAG | 转码或解码字符串。 0：编码操作。 1：解码操作。 |

```
-- xml解码
SELECT DBE_XMLGEN.CONVERT('<foo/>', 1);
 convert
---------
 <foo/>
(1 row)
-- xml编码
SELECT DBE_XMLGEN.CONVERT('<foo><qwe</foo>', 0);
            convert
--------------------------------
 &lt;foo&gt;&lt;qwe&lt;/foo&gt;
(1 row)
```
- DBE_XMLGEN.CONVERT将输入的字符串进行xml编码或解码操作。 会按以下规则进行转换。 函数原型： 参数说明： 示例：
```
DBE_XMLGEN.NEWCONTEXT(QUERYSTRING IN VARCHAR2) RETURNS DBE_XMLGEN.CTXHANDLE;
DBE_XMLGEN.NEWCONTEXT(QUERYSTRING IN SYS_REFCURSOR) RETURNS DBE_XMLGEN.CTXHANDLE;
```

| 参数 | 描述 |
|---|---|
| QUERYSTRING | 用于生成XML的查询SQL语句或SYS_REFCURSOR。 |

```
-- 预置数据。
CREATE TABLE IF NOT EXISTS department(department_id NUMBER, department_name VARCHAR2(30), manager NUMBER, location NUMBER);
INSERT INTO department VALUES(10, 'administrator', 200, 1700);
INSERT INTO department VALUES(11, 'aaa', 200, 1700);
INSERT INTO department VALUES(12, 'bbb', 300, 1600);
INSERT INTO department VALUES(13, 'ccc', 400, 1600);
INSERT INTO department VALUES(14, 'aaa</row><a>asd</a><row>', 400, 1600);
INSERT INTO department VALUES(15, NULL, 500,1600);
INSERT INTO department VALUES(16, '!@#$%^&*()+-=<>/\"a3_啊', 400, 1600);
-- 初始化普通context handle。
DECLARE
    qryctx DBE_XMLGEN.CTXHANDLE;
    result CLOB;
BEGIN
 qryctx := DBE_XMLGEN.NEWCONTEXT('SELECT * FROM DEPARTMENT ORDER BY DEPARTMENT_ID');
 result:=DBE_XMLGEN.GETXML(qryctx);
 DBE_XMLGEN.CLOSECONTEXT(qryctx);
 DBE_OUTPUT.PUT_LINE(result);
END;
/
<?xml version="1.0"?>
<ROWSET>
<ROW>
  <department_id>10</department_id>
  <department_name>administrator</department_name>
  <manager>200</manager>
  <location>1700</location>
</ROW>
<ROW>
  <department_id>11</department_id>
  <department_name>aaa</department_name>
  <manager>200</manager>
  <location>1700</location>
</ROW>
<ROW>
  <department_id>12</department_id>
  <department_name>bbb</department_name>
  <manager>300</manager>
  <location>1600</location>
</ROW>
<ROW>
  <department_id>13</department_id>
  <department_name>ccc</department_name>
  <manager>400</manager>
  <location>1600</location>
</ROW>
<ROW>
  <department_id>14</department_id>
  <department_name>aaa&lt;/row&gt;&lt;a&gt;asd&lt;/a&gt;&lt;row&gt;</department_name>
  <manager>400</manager>
  <location>1600</location>
</ROW>
<ROW>
  <department_id>15</department_id>
  <manager>500</manager>
  <location>1600</location>
</ROW>
<ROW>
  <department_id>16</department_id>
  <department_name>!@#$%^&amp;*()+-=&lt;&gt;/\&quot;a3_啊</department_name>
  <manager>400</manager>
  <location>1600</location>
</ROW>
</ROWSET>
-- 初始化普通context handle。
DECLARE
    lr SYS_REFCURSOR;
    qryctx DBE_XMLGEN.CTXHANDLE;
    result XMLTYPE;
BEGIN
    OPEN lr FOR SELECT department_id, department_name FROM DEPARTMENT ORDER BY DEPARTMENT_ID;
    qryctx:=DBE_XMLGEN.NEWCONTEXT(lr);
 result:=DBE_XMLGEN.GETXMLTYPE(qryctx);
 DBE_XMLGEN.CLOSECONTEXT(qryctx);
 DBE_OUTPUT.PUT_LINE(result.getclobval);
END;
/
<?xml version="1.0"?>
<ROWSET>
<ROW>
  <department_id>10</department_id>
  <department_name>administrator</department_name>
</ROW>
<ROW>
  <department_id>11</department_id>
  <department_name>aaa</department_name>
</ROW>
<ROW>
  <department_id>12</department_id>
  <department_name>bbb</department_name>
</ROW>
<ROW>
  <department_id>13</department_id>
  <department_name>ccc</department_name>
</ROW>
<ROW>
  <department_id>14</department_id>
  <department_name>aaa&lt;/row&gt;&lt;a&gt;asd&lt;/a&gt;&lt;row&gt;</department_name>
</ROW>
<ROW>
  <department_id>15</department_id>
</ROW>
<ROW>
  <department_id>16</department_id>
  <department_name>!@#$%^&amp;*()+-=&lt;&gt;/\&quot;a3_啊</department_name>
</ROW>
</ROWSET>
ANONYMOUS BLOCK EXECUTE
DROP TABLE department;
```
- DBE_XMLGEN.NEWCONTEXT初始化普通context handle，该context handle只能在一个事务中使用，否则使用DBE_XMLGEN.RESTARTQUERY和DBE_XMLGEN.CLOSECONTEXT关闭对应context handle时会报错。 函数原型： 参数说明： 示例：
```
DBE_XMLGEN.NEWCONTEXTFROMHIERARCHY(QUERYSTRING IN VARCHAR2);
```

| 参数 | 描述 |
|---|---|
| QUERYSTRING | 需要转换的XML字符串，VARCHAR2类型。 |

```
-- 预置数据。
CREATE TABLE tree_list(id NUMBER, name VARCHAR2(30), fid NUMBER);
INSERT INTO tree_list VALUES(1, 'a', NULL);
INSERT INTO tree_list VALUES(6, 'a-1-2', 2);
INSERT INTO tree_list VALUES(2, 'a-1', 1);
INSERT INTO tree_list VALUES(3, 'a-2', 1);
INSERT INTO tree_list VALUES(4, 'a-3', 1);
INSERT INTO tree_list VALUES(5, 'a-1-1', 2);
INSERT INTO tree_list VALUES(7, 'a-2-1', 3);
INSERT INTO tree_list VALUES(8, 'a-2-2', 3);
INSERT INTO tree_list VALUES(9, 'a-3-1', 4);
INSERT INTO tree_list VALUES(10, 'a-3-2', 4);
INSERT INTO tree_list VALUES(11, 'a-3-2-1', 10);
INSERT INTO tree_list VALUES(12, 'a-3-2-1-1', 11);
INSERT INTO tree_list VALUES(13, 'a-3-2-1-1-1', 12);
INSERT INTO tree_list VALUES(14, 'a-3-2-1-1-1-1', 13);
INSERT INTO tree_list VALUES(15, 'a-3-2-1-1-1-1-1', 14);
INSERT INTO tree_list VALUES(16, NULL, 14);
INSERT INTO tree_list VALUES(17, '<?q>', 14);
-- 递归xml生成。
DECLARE
qryctx DBE_XMLGEN.CTXHANDLE;
result CLOB;
BEGIN
 qryctx := DBE_XMLGEN.NEWCONTEXTFROMHIERARCHY('SELECT level, xmlelement("children", xmlelement("node_name", name)) ss from tree_list start with id=1 connect by prior id=fid');
 DBE_XMLGEN.USENULLATTRIBUTEINDICATOR(qryctx, true);
 result:=DBE_XMLGEN.GETXML(qryctx);
 DBE_XMLGEN.CLOSECONTEXT(qryctx);
 DBE_OUTPUT.PUT_LINE(result);
END;
/
<?xml version="1.0" encoding="utf-8"?>
<children>
  <node_name>a</node_name>
  <children>
    <node_name>a-3</node_name>
    <children>
      <node_name>a-3-2</node_name>
      <children>
        <node_name>a-3-2-1</node_name>
        <children>
          <node_name>a-3-2-1-1</node_name>
          <children>
            <node_name>a-3-2-1-1-1</node_name>
            <children>
              <node_name>a-3-2-1-1-1-1</node_name>
              <children>
                <node_name>&lt;?q&gt;</node_name>
              </children>
              <children>
                <node_name/>
              </children>
              <children>
                <node_name>a-3-2-1-1-1-1-1</node_name>
              </children>
            </children>
          </children>
        </children>
      </children>
    </children>
    <children>
      <node_name>a-3-1</node_name>
    </children>
  </children>
  <children>
    <node_name>a-2</node_name>
    <children>
      <node_name>a-2-2</node_name>
    </children>
    <children>
      <node_name>a-2-1</node_name>
    </children>
  </children>
  <children>
    <node_name>a-1</node_name>
    <children>
      <node_name>a-1-1</node_name>
    </children>
    <children>
      <node_name>a-1-2</node_name>
    </children>
  </children>
</children>
ANONYMOUS BLOCK EXECUTE
DROP TABLE tree_list;
```
- DBE_XMLGEN.NEWCONTEXTFROMHIERARCHY初始化带有递归元素的context handle。 数据格式要求为两列，第一列为numeric类型，第二列为xml或XMLTYPE类型。通常情况下由connect by语句生成，第一列指定生成level。 生成的xml层级嵌套不允许超过5000万层。 函数原型： 参数说明： 示例：
```
DBE_XMLGEN.SETCONVERTSPECIALCHARS(CTX IN DBE_XMLGEN.CTXHANDLE, CONV IN BOOLEAN);
```

| 参数 | 描述 |
|---|---|
| CTX | context handle。 |
| CONV | 是否需要对输出的xml进行编码。 true：编码。false：不编码。 |

```
-- 预置数据。
CREATE TABLE IF NOT EXISTS department(department_id NUMBER, department_name VARCHAR2(30), manager NUMBER, location NUMBER);
INSERT INTO department VALUES(10, 'administrator', 200, 1700);
INSERT INTO department VALUES(11, 'aaa', 200, 1700);
INSERT INTO department VALUES(12, 'bbb', 300, 1600);
INSERT INTO department VALUES(13, 'ccc', 400, 1600);
INSERT INTO department VALUES(14, 'aaa</row><a>asd</a><row>', 400, 1600);
INSERT INTO department VALUES(15, NULL, 500,1600);
INSERT INTO department VALUES(16, '!@#$%^&*()+-=<>/\"a3_啊', 400, 1600);
-- xml编码。
DECLARE
    qryctx DBE_XMLGEN.CTXHANDLE;
    result CLOB;
BEGIN
 qryctx := DBE_XMLGEN.NEWCONTEXT('SELECT * from department where department_id=14');
 DBE_XMLGEN.SETCONVERTSPECIALCHARS(qryctx, true);
 result:=DBE_XMLGEN.GETXML(qryctx);
 DBE_XMLGEN.CLOSECONTEXT(qryctx);
 DBE_OUTPUT.PUT_LINE(result);
END;
/
<?xml version="1.0"?>
<ROWSET>
<ROW>
  <department_id>14</department_id>
  <department_name>aaa&lt;/row&gt;&lt;a&gt;asd&lt;/a&gt;&lt;row&gt;</department_name>
  <manager>400</manager>
  <location>1600</location>
</ROW>
</ROWSET>
-- 不进行编码。
DECLARE
    qryctx DBE_XMLGEN.CTXHANDLE;
    result CLOB;
BEGIN
	qryctx := DBE_XMLGEN.NEWCONTEXT('SELECT * from department where department_id=14');
	DBE_XMLGEN.SETCONVERTSPECIALCHARS(qryctx, false);
	result:=DBE_XMLGEN.GETXML(qryctx);
	DBE_XMLGEN.CLOSECONTEXT(qryctx);
	DBE_OUTPUT.PUT_LINE(result);
END;
/
<?xml version="1.0"?>
<ROWSET>
<ROW>
  <department_id>14</department_id>
  <department_name>aaa</row><a>asd</a><row></department_name>
  <manager>400</manager>
  <location>1600</location>
</ROW>
</ROWSET>
-- 对其余非xml的特殊字符不进行编码。
DECLARE
    qryctx DBE_XMLGEN.CTXHANDLE;
    result CLOB;
BEGIN
	qryctx := DBE_XMLGEN.NEWCONTEXT('SELECT * from department where department_id=16');
	DBE_XMLGEN.SETCONVERTSPECIALCHARS(qryctx, true);
	result:=DBE_XMLGEN.GETXML(qryctx);
	DBE_XMLGEN.CLOSECONTEXT(qryctx);
	DBE_OUTPUT.PUT_LINE(result);
END;
/
<?xml version="1.0"?>
<ROWSET>
<ROW>
  <department_id>16</department_id>
  <department_name>!@#$%^&amp;*()+-=&lt;&gt;/\&quot;a3_啊</department_name>
  <manager>400</manager>
  <location>1600</location>
</ROW>
</ROWSET>
ANONYMOUS BLOCK EXECUTE
DROP TABLE department;
```
- DBE_XMLGEN.SETCONVERTSPECIALCHARS设置输出的xml是否需要xml编码。取消xml编码可能会存在xml注入问题，如果出于性能考虑且可以保证xml是安全的情况下可以不进行xml编码。 函数原型： 参数说明： 示例：
```
DBE_XMLGEN.SETNULLHANDLING(CTX IN DBE_XMLGEN.CTXHANDLE, FLAG IN NUMBER := 0);
```

| 参数 | 描述 |
|---|---|
| CTX | context handle。 |
| FLAG | NULL值展示格式。 0：不展示元素。 1：元素上添加 xsi:nil="true" 属性。 2：展示自闭合元素 |

```
-- 预置数据。
CREATE TABLE IF NOT EXISTS department(department_id NUMBER, department_name VARCHAR2(30), manager NUMBER, location NUMBER);
INSERT INTO department VALUES(10, 'administrator', 200, 1700);
INSERT INTO department VALUES(11, 'aaa', 200, 1700);
INSERT INTO department VALUES(12, 'bbb', 300, 1600);
INSERT INTO department VALUES(13, 'ccc', 400, 1600);
INSERT INTO department VALUES(14, 'aaa</row><a>asd</a><row>', 400, 1600);
INSERT INTO department VALUES(15, NULL, 500,1600);
INSERT INTO department VALUES(16, '!@#$%^&*()+-=<>/\"a3_啊', 400, 1600);
-- 不用nullhandling的默认值。
DECLARE
    result CLOB;
    qryctx DBE_XMLGEN.CTXHANDLE;
BEGIN
	qryctx:=DBE_XMLGEN.NEWCONTEXT('SELECT * from department where department_id=15');
	result:=DBE_XMLGEN.GETXML(qryctx);
	DBE_OUTPUT.PUT_LINE(result);
	DBE_XMLGEN.CLOSECONTEXT(qryctx);
END;
/
<?xml version="1.0"?>
<ROWSET>
<ROW>
  <department_id>15</department_id>
  <manager>500</manager>
  <location>1600</location>
</ROW>
</ROWSET>
-- nullhandling为0
DECLARE
    result CLOB;
    qryctx DBE_XMLGEN.CTXHANDLE;
BEGIN
	qryctx:=DBE_XMLGEN.NEWCONTEXT('SELECT * from department where department_id=15');
	DBE_XMLGEN.SETNULLHANDLING(qryctx, 0);
	result:=DBE_XMLGEN.GETXML(qryctx);
	DBE_OUTPUT.PUT_LINE(result);
	DBE_XMLGEN.CLOSECONTEXT(qryctx);
END;
/
<?xml version="1.0"?>
<ROWSET>
<ROW>
  <department_id>15</department_id>
  <manager>500</manager>
  <location>1600</location>
</ROW>
</ROWSET>
-- nullhandling 1
DECLARE
    result CLOB;
    qryctx DBE_XMLGEN.CTXHANDLE;
BEGIN
	qryctx:=DBE_XMLGEN.NEWCONTEXT('SELECT * from department where department_id=15');
	DBE_XMLGEN.SETNULLHANDLING(qryctx, 1);
	result:=DBE_XMLGEN.GETXML(qryctx);
	DBE_OUTPUT.PUT_LINE(result);
	DBE_XMLGEN.CLOSECONTEXT(qryctx);
END;
/
<?xml version="1.0"?>
<ROWSET xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
<ROW>
  <department_id>15</department_id>
  <department_name xsi:nil="true"/>
  <manager>500</manager>
  <location>1600</location>
</ROW>
</ROWSET>
-- nullhandling 2
DECLARE
    result CLOB;
    qryctx DBE_XMLGEN.CTXHANDLE;
BEGIN
	qryctx:=DBE_XMLGEN.NEWCONTEXT('SELECT * from department where department_id=15');
	DBE_XMLGEN.SETNULLHANDLING(qryctx, 2);
	result:=DBE_XMLGEN.GETXML(qryctx);
	DBE_OUTPUT.PUT_LINE(result);
	DBE_XMLGEN.CLOSECONTEXT(qryctx);
END;
/
<?xml version="1.0"?>
<ROWSET>
<ROW>
  <department_id>15</department_id>
  <department_name/>
  <manager>500</manager>
  <location>1600</location>
</ROW>
</ROWSET>
ANONYMOUS BLOCK EXECUTE
DROP TABLE department;
```
- DBE_XMLGEN.SETNULLHANDLING设置xml中null值如何展示。 函数原型： 参数说明： 示例：
```
DBE_XMLGEN.SETROWSETTAG(CTX IN DBE_XMLGEN.CTXHANDLE, ROWSETTAGNAME IN VARCHAR2);
```

| 参数 | 描述 |
|---|---|
| CTX | context handle。 |
| ROWSETTAGNAME | xml根节点名称。 |

```
-- 预置数据。
CREATE TABLE IF NOT EXISTS department(department_id NUMBER, department_name VARCHAR2(30), manager NUMBER, location NUMBER);
INSERT INTO department VALUES(10, 'administrator', 200, 1700);
INSERT INTO department VALUES(11, 'aaa', 200, 1700);
INSERT INTO department VALUES(12, 'bbb', 300, 1600);
INSERT INTO department VALUES(13, 'ccc', 400, 1600);
INSERT INTO department VALUES(14, 'aaa</row><a>asd</a><row>', 400, 1600);
INSERT INTO department VALUES(15, NULL, 500,1600);
INSERT INTO department VALUES(16, '!@#$%^&*()+-=<>/\"a3_啊', 400, 1600);
-- 设置根节点名称为asd。
DECLARE
    qryctx DBE_XMLGEN.CTXHANDLE;
    result CLOB;
BEGIN
	qryctx := DBE_XMLGEN.NEWCONTEXT('SELECT * FROM DEPARTMENT ORDER BY DEPARTMENT_ID');
	DBE_XMLGEN.SETROWSETTAG(qryctx, 'asd');
	DBE_XMLGEN.SETROWTAG(qryctx, 'qwe');
	result:=DBE_XMLGEN.GETXML(qryctx);
	DBE_XMLGEN.CLOSECONTEXT(qryctx);
	DBE_OUTPUT.PUT_LINE(result);
END;
/
<?xml version="1.0"?>
<asd>
<qwe>
  <department_id>10</department_id>
  <department_name>administrator</department_name>
  <manager>200</manager>
  <location>1700</location>
</qwe>
<qwe>
  <department_id>11</department_id>
  <department_name>aaa</department_name>
  <manager>200</manager>
  <location>1700</location>
</qwe>
<qwe>
  <department_id>12</department_id>
  <department_name>bbb</department_name>
  <manager>300</manager>
  <location>1600</location>
</qwe>
<qwe>
  <department_id>13</department_id>
  <department_name>ccc</department_name>
  <manager>400</manager>
  <location>1600</location>
</qwe>
<qwe>
  <department_id>14</department_id>
  <department_name>aaa&lt;/row&gt;&lt;a&gt;asd&lt;/a&gt;&lt;row&gt;</department_name>
  <manager>400</manager>
  <location>1600</location>
</qwe>
<qwe>
  <department_id>15</department_id>
  <manager>500</manager>
  <location>1600</location>
</qwe>
<qwe>
  <department_id>16</department_id>
  <department_name>!@#$%^&amp;*()+-=&lt;&gt;/\&quot;a3_啊</department_name>
  <manager>400</manager>
  <location>1600</location>
</qwe>
</asd>
ANONYMOUS BLOCK EXECUTE
DROP TABLE department;
```
- DBE_XMLGEN.SETROWSETTAG设置xml根节点名称。 函数原型： 参数说明： 示例：
```
DBE_XMLGEN.SETROWTAG(CTX IN DBE_XMLGEN.CTXHANDLE, ROWTAGNAME IN VARCHAR2);
```

| 参数 | 描述 |
|---|---|
| CTX | context handle。 |
| ROWTAGNAME | 每一行数据的tag名。 |

```
-- 预置数据。
CREATE TABLE IF NOT EXISTS department(department_id NUMBER, department_name VARCHAR2(30), manager NUMBER, location NUMBER);
INSERT INTO department VALUES(10, 'administrator', 200, 1700);
INSERT INTO department VALUES(11, 'aaa', 200, 1700);
INSERT INTO department VALUES(12, 'bbb', 300, 1600);
INSERT INTO department VALUES(13, 'ccc', 400, 1600);
INSERT INTO department VALUES(14, 'aaa</row><a>asd</a><row>', 400, 1600);
INSERT INTO department VALUES(15, NULL, 500,1600);
INSERT INTO department VALUES(16, '!@#$%^&*()+-=<>/\"a3_啊', 400, 1600);
-- 设置每一行数据的tag名为qwe。
DECLARE
    qryctx DBE_XMLGEN.CTXHANDLE;
    result CLOB;
BEGIN
	qryctx := DBE_XMLGEN.NEWCONTEXT('SELECT * FROM DEPARTMENT ORDER BY DEPARTMENT_ID');
	DBE_XMLGEN.SETROWSETTAG(qryctx, 'asd');
	DBE_XMLGEN.SETROWTAG(qryctx, 'qwe');
	result:=DBE_XMLGEN.GETXML(qryctx);
	DBE_XMLGEN.CLOSECONTEXT(qryctx);
	DBE_OUTPUT.PUT_LINE(result);
END;
/
<?xml version="1.0"?>
<asd>
<qwe>
  <department_id>10</department_id>
  <department_name>administrator</department_name>
  <manager>200</manager>
  <location>1700</location>
</qwe>
<qwe>
  <department_id>11</department_id>
  <department_name>aaa</department_name>
  <manager>200</manager>
  <location>1700</location>
</qwe>
<qwe>
  <department_id>12</department_id>
  <department_name>bbb</department_name>
  <manager>300</manager>
  <location>1600</location>
</qwe>
<qwe>
  <department_id>13</department_id>
  <department_name>ccc</department_name>
  <manager>400</manager>
  <location>1600</location>
</qwe>
<qwe>
  <department_id>14</department_id>
  <department_name>aaa&lt;/row&gt;&lt;a&gt;asd&lt;/a&gt;&lt;row&gt;</department_name>
  <manager>400</manager>
  <location>1600</location>
</qwe>
<qwe>
  <department_id>15</department_id>
  <manager>500</manager>
  <location>1600</location>
</qwe>
<qwe>
  <department_id>16</department_id>
  <department_name>!@#$%^&amp;*()+-=&lt;&gt;/\&quot;a3_啊</department_name>
  <manager>400</manager>
  <location>1600</location>
</qwe>
</asd>
ANONYMOUS BLOCK EXECUTE
DROP TABLE department;
```
- DBE_XMLGEN.SETROWTAG设置xml中每一行数据的tag名。 函数原型： 参数说明： 示例：
```
DBE_XMLGEN.USENULLATTRIBUTEINDICATOR(CTX IN DBE_XMLGEN.CTXHANDLE, ATTRIND IN BOOLEAN);
```

| 参数 | 描述 |
|---|---|
| CTX | context handle。 |
| ATTRIND | 无意义。 |

```
-- 预置数据。
CREATE TABLE IF NOT EXISTS department(department_id NUMBER, department_name VARCHAR2(30), manager NUMBER, location NUMBER);
INSERT INTO department VALUES(10, 'administrator', 200, 1700);
INSERT INTO department VALUES(11, 'aaa', 200, 1700);
INSERT INTO department VALUES(12, 'bbb', 300, 1600);
INSERT INTO department VALUES(13, 'ccc', 400, 1600);
INSERT INTO department VALUES(14, 'aaa</row><a>asd</a><row>', 400, 1600);
INSERT INTO department VALUES(15, NULL, 500,1600);
INSERT INTO department VALUES(16, '!@#$%^&*()+-=<>/\"a3_啊', 400, 1600);
-- 对null值添加 xsi:nil="true"属性。
DECLARE
    result CLOB;
    qryctx DBE_XMLGEN.CTXHANDLE;
BEGIN
	qryctx:=DBE_XMLGEN.NEWCONTEXT('SELECT * from department where department_id=15');
	DBE_XMLGEN.USENULLATTRIBUTEINDICATOR(qryctx, true);
	result:=DBE_XMLGEN.GETXML(qryctx);
	DBE_OUTPUT.PUT_LINE(result);
	DBE_XMLGEN.CLOSECONTEXT(qryctx);
END;
/
<?xml version="1.0"?>
<ROWSET xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
<ROW>
  <department_id>15</department_id>
  <department_name xsi:nil="true"/>
  <manager>500</manager>
  <location>1600</location>
</ROW>
</ROWSET>
ANONYMOUS BLOCK EXECUTE
DROP TABLE department;
```
- DBE_XMLGEN.USENULLATTRIBUTEINDICATOR对xml中的null值所在的元素添加xsi:nil="true"属性。 函数原型： 参数说明： 示例：
```
DBE_XMLGEN.USEITEMTAGSFORCOLL(CTX IN DBE_XMLGEN.CTXHANDLE);
```

| 参数 | 描述 |
|---|---|
| CTX | context handle。 |

```
-- 预置数据。
CREATE TABLE test_for_array(id INT[]);
INSERT INTO test_for_array VALUES(ARRAY[1,2,3]);
SELECT DBE_XMLGEN.GETXML('SELECT * from test_for_array');
-- 数组类型添加'_ITEM'后缀。
DECLARE
qryctx DBE_XMLGEN.CTXHANDLE;
result CLOB;
BEGIN
	qryctx := DBE_XMLGEN.NEWCONTEXT('SELECT * from test_for_array');
	DBE_XMLGEN.useItemTagsForColl(qryctx);
	result:=DBE_XMLGEN.GETXML(qryctx);
	DBE_XMLGEN.CLOSECONTEXT(qryctx);
	DBE_OUTPUT.PUT_LINE(result);
END;
/
<?xml version="1.0"?>
<ROWSET>
<ROW>
  <id>
    <int4_ITEM>1</int4_ITEM>
    <int4_ITEM>2</int4_ITEM>
    <int4_ITEM>3</int4_ITEM>
  </id>
</ROW>
</ROWSET>
ANONYMOUS BLOCK EXECUTE
DROP TABLE test_for_array;
```
- DBE_XMLGEN.USEITEMTAGSFORCOLL对数组类型变量所在的元素中添加'_ITEM'后缀。 函数原型： 参数说明： 示例：
```
DBE_XMLGEN.GETNUMROWSPROCESSED(CTX IN DBE_XMLGEN.CTXHANDLE);
```

| 参数 | 描述 |
|---|---|
| CTX | context handle。 |

```
-- 预置数据。
CREATE TABLE IF NOT EXISTS department(department_id NUMBER, department_name VARCHAR2(30), manager NUMBER, location NUMBER);
INSERT INTO department VALUES(10, 'administrator', 200, 1700);
INSERT INTO department VALUES(11, 'aaa', 200, 1700);
INSERT INTO department VALUES(12, 'bbb', 300, 1600);
INSERT INTO department VALUES(13, 'ccc', 400, 1600);
INSERT INTO department VALUES(14, 'aaa</row><a>asd</a><row>', 400, 1600);
INSERT INTO department VALUES(15, NULL, 500,1600);
INSERT INTO department VALUES(16, '!@#$%^&*()+-=<>/\"a3_啊', 400, 1600);
-- getNumRowsProcessed
DECLARE
    qryctx DBE_XMLGEN.CTXHANDLE;
	result CLOB;
BEGIN
	qryctx:=DBE_XMLGEN.NEWCONTEXT('SELECT * from department');
	-- 每一次查询返回的最大值。
	DBE_XMLGEN.SETMAXROWS(qryctx, 4);
	LOOP
        result := DBE_XMLGEN.GETXML(qryctx);
		-- 这一轮查询返回的数量。
		exit when DBE_XMLGEN.GETNUMROWSPROCESSED(qryctx) = 0;
		DBE_OUTPUT.PUT_LINE('-------'||DBE_XMLGEN.GETNUMROWSPROCESSED(qryctx)||'----------');
		DBE_OUTPUT.PUT_LINE(result);
		DBE_OUTPUT.PUT_LINE('********************');
    END LOOP;
	DBE_XMLGEN.CLOSECONTEXT(qryctx);
END;
/
-------4----------
<?xml version="1.0"?>
<ROWSET>
<ROW>
  <department_id>10</department_id>
  <department_name>administrator</department_name>
  <manager>200</manager>
  <location>1700</location>
</ROW>
<ROW>
  <department_id>11</department_id>
  <department_name>aaa</department_name>
  <manager>200</manager>
  <location>1700</location>
</ROW>
<ROW>
  <department_id>12</department_id>
  <department_name>bbb</department_name>
  <manager>300</manager>
  <location>1600</location>
</ROW>
<ROW>
  <department_id>13</department_id>
  <department_name>ccc</department_name>
  <manager>400</manager>
  <location>1600</location>
</ROW>
</ROWSET>
********************
-------3----------
<?xml version="1.0"?>
<ROWSET>
<ROW>
  <department_id>14</department_id>
  <department_name>aaa&lt;/row&gt;&lt;a&gt;asd&lt;/a&gt;&lt;row&gt;</department_name>
  <manager>400</manager>
  <location>1600</location>
</ROW>
<ROW>
  <department_id>15</department_id>
  <manager>500</manager>
  <location>1600</location>
</ROW>
<ROW>
  <department_id>16</department_id>
  <department_name>!@#$%^&amp;*()+-=&lt;&gt;/\&quot;a3_啊</department_name>
  <manager>400</manager>
  <location>1600</location>
</ROW>
</ROWSET>
********************
ANONYMOUS BLOCK EXECUTE
DROP TABLE department;
```
- DBE_XMLGEN.GETNUMROWSPROCESSED查看上一次getxml或者getxmltype返回的数据行数。 函数原型： 参数说明： 示例：
```
DBE_XMLGEN.SETMAXROWS(CTX IN DBE_XMLGEN.CTXHANDLE, MAXROWS IN NUMBER);
```

| 参数 | 描述 |
|---|---|
| CTX | context handle。 |
| MAXROWS | 每一次getxml最大的返回行数。 |

```
-- 预置数据。
CREATE TABLE IF NOT EXISTS department(department_id NUMBER, department_name VARCHAR2(30), manager NUMBER, location NUMBER);
INSERT INTO department VALUES(10, 'administrator', 200, 1700);
INSERT INTO department VALUES(11, 'aaa', 200, 1700);
INSERT INTO department VALUES(12, 'bbb', 300, 1600);
INSERT INTO department VALUES(13, 'ccc', 400, 1600);
INSERT INTO department VALUES(14, 'aaa</row><a>asd</a><row>', 400, 1600);
INSERT INTO department VALUES(15, NULL, 500,1600);
INSERT INTO department VALUES(16, '!@#$%^&*()+-=<>/\"a3_啊', 400, 1600);
-- getNumRowsProcessed
DECLARE
    qryctx DBE_XMLGEN.CTXHANDLE;
 result CLOB;
BEGIN
 qryctx:=DBE_XMLGEN.NEWCONTEXT('SELECT * from department');
 -- 每一次查询返回的最大值。
 DBE_XMLGEN.SETMAXROWS(qryctx, 4);
 LOOP
        result := DBE_XMLGEN.GETXML(qryctx);
 -- 这一轮查询返回的数量。
  exit when DBE_XMLGEN.GETNUMROWSPROCESSED(qryctx) = 0;
  DBE_OUTPUT.PUT_LINE('-------'||DBE_XMLGEN.GETNUMROWSPROCESSED(qryctx)||'----------');
  DBE_OUTPUT.PUT_LINE(result);
  DBE_OUTPUT.PUT_LINE('********************');
    END LOOP;
 DBE_XMLGEN.CLOSECONTEXT(qryctx);
END;
/
-------4----------
<?xml version="1.0"?>
<ROWSET>
<ROW>
  <department_id>10</department_id>
  <department_name>administrator</department_name>
  <manager>200</manager>
  <location>1700</location>
</ROW>
<ROW>
  <department_id>11</department_id>
  <department_name>aaa</department_name>
  <manager>200</manager>
  <location>1700</location>
</ROW>
<ROW>
  <department_id>12</department_id>
  <department_name>bbb</department_name>
  <manager>300</manager>
  <location>1600</location>
</ROW>
<ROW>
  <department_id>13</department_id>
  <department_name>ccc</department_name>
  <manager>400</manager>
  <location>1600</location>
</ROW>
</ROWSET>
********************
-------3----------
<?xml version="1.0"?>
<ROWSET>
<ROW>
  <department_id>14</department_id>
  <department_name>aaa&lt;/row&gt;&lt;a&gt;asd&lt;/a&gt;&lt;row&gt;</department_name>
  <manager>400</manager>
  <location>1600</location>
</ROW>
<ROW>
  <department_id>15</department_id>
  <manager>500</manager>
  <location>1600</location>
</ROW>
<ROW>
  <department_id>16</department_id>
  <department_name>!@#$%^&amp;*()+-=&lt;&gt;/\&quot;a3_啊</department_name>
  <manager>400</manager>
  <location>1600</location>
</ROW>
</ROWSET>
********************
ANONYMOUS BLOCK EXECUTE
DROP TABLE department;
```
- DBE_XMLGEN.SETMAXROWS设置getxml最大的返回行数。 函数原型： 参数说明： 示例：
```
DBE_XMLGEN.SETSKIPROWS(CTX IN DBE_XMLGEN.CTXHANDLE, SKIPROWS IN NUMBER);
```

| 参数 | 描述 |
|---|---|
| CTX | context handle。 |
| SKIPROWS | 跳过SQL的头部行数。 |

```
CREATE TABLE IF NOT EXISTS department(department_id NUMBER, department_name VARCHAR2(30), manager NUMBER, location NUMBER);
INSERT INTO department VALUES(10, 'administrator', 200, 1700);
INSERT INTO department VALUES(11, 'aaa', 200, 1700);
INSERT INTO department VALUES(12, 'bbb', 300, 1600);
INSERT INTO department VALUES(13, 'ccc', 400, 1600);
INSERT INTO department VALUES(14, 'aaa</row><a>asd</a><row>', 400, 1600);
INSERT INTO department VALUES(15, NULL, 500,1600);
INSERT INTO department VALUES(16, '!@#$%^&*()+-=<>/\"a3_啊', 400, 1600);
-- setskiprows跳过5行。
declare
    result CLOB;
    qryctx DBE_XMLGEN.CTXHANDLE;
BEGIN
 qryctx:=DBE_XMLGEN.NEWCONTEXT('SELECT * from department');
 DBE_XMLGEN.SETSKIPROWS(qryctx, 5);
 result:=DBE_XMLGEN.GETXML(qryctx);
 DBE_OUTPUT.PUT_LINE(result);
 DBE_XMLGEN.CLOSECONTEXT(qryctx);
END;
/
<?xml version="1.0"?>
<ROWSET>
<ROW>
  <department_id>15</department_id>
  <manager>500</manager>
  <location>1600</location>
</ROW>
<ROW>
  <department_id>16</department_id>
  <department_name>!@#$%^&amp;*()+-=&lt;&gt;/\&quot;a3_啊</department_name>
  <manager>400</manager>
  <location>1600</location>
</ROW>
ANONYMOUS BLOCK EXECUTE
DROP TABLE department;
```
- DBE_XMLGEN.SETSKIPROWS设置跳过sql行数。 函数原型： 参数说明： 示例：
```
DBE_XMLGEN.RESTARTQUERY(CTX IN DBE_XMLGEN.CTXHANDLE);
```

| 参数 | 描述 |
|---|---|
| CTX | context handle。 |

```
CREATE TABLE IF NOT EXISTS department(department_id NUMBER, department_name VARCHAR2(30), manager NUMBER, location NUMBER);
INSERT INTO department VALUES(10, 'administrator', 200, 1700);
INSERT INTO department VALUES(11, 'aaa', 200, 1700);
INSERT INTO department VALUES(12, 'bbb', 300, 1600);
INSERT INTO department VALUES(13, 'ccc', 400, 1600);
INSERT INTO department VALUES(14, 'aaa</row><a>asd</a><row>', 400, 1600);
INSERT INTO department VALUES(15, NULL, 500,1600);
INSERT INTO department VALUES(16, '!@#$%^&*()+-=<>/\"a3_啊', 400, 1600);
DECLARE
    qryctx DBE_XMLGEN.CTXHANDLE;
 result CLOB;
BEGIN
 qryctx:=DBE_XMLGEN.NEWCONTEXT('SELECT * from department');
 -- 每一次查询返回的最大值。
 DBE_XMLGEN.SETMAXROWS(qryctx, 4);
 LOOP
        result := DBE_XMLGEN.GETXML(qryctx);
        -- 这一轮查询返回的数量。
        exit when DBE_XMLGEN.GETNUMROWSPROCESSED(qryctx) = 0;
        DBE_OUTPUT.PUT_LINE('-------'||DBE_XMLGEN.GETNUMROWSPROCESSED(qryctx)||'----------');
        DBE_OUTPUT.PUT_LINE(result);
        DBE_OUTPUT.PUT_LINE('********************');
    END LOOP;
    -- 重启查询。
    DBE_XMLGEN.RESTARTQUERY(qryctx);
    result := DBE_XMLGEN.GETXML(qryctx);
    DBE_OUTPUT.PUT_LINE('-------'||DBE_XMLGEN.GETNUMROWSPROCESSED(qryctx)||'----------');
    DBE_OUTPUT.PUT_LINE(result);
    DBE_OUTPUT.PUT_LINE('********************');
    DBE_XMLGEN.CLOSECONTEXT(qryctx);
END;
/
-------4----------
<?xml version="1.0"?>
<ROWSET>
<ROW>
  <department_id>10</department_id>
  <department_name>administrator</department_name>
  <manager>200</manager>
  <location>1700</location>
</ROW>
<ROW>
  <department_id>11</department_id>
  <department_name>aaa</department_name>
  <manager>200</manager>
  <location>1700</location>
</ROW>
<ROW>
  <department_id>12</department_id>
  <department_name>bbb</department_name>
  <manager>300</manager>
  <location>1600</location>
</ROW>
<ROW>
  <department_id>13</department_id>
  <department_name>ccc</department_name>
  <manager>400</manager>
  <location>1600</location>
</ROW>
</ROWSET>
********************
-------3----------
<?xml version="1.0"?>
<ROWSET>
<ROW>
  <department_id>14</department_id>
  <department_name>aaa&lt;/row&gt;&lt;a&gt;asd&lt;/a&gt;&lt;row&gt;</department_name>
  <manager>400</manager>
  <location>1600</location>
</ROW>
<ROW>
  <department_id>15</department_id>
  <manager>500</manager>
  <location>1600</location>
</ROW>
<ROW>
  <department_id>16</department_id>
  <department_name>!@#$%^&amp;*()+-=&lt;&gt;/\&quot;a3_啊</department_name>
  <manager>400</manager>
  <location>1600</location>
</ROW>
</ROWSET>
********************
-------4----------
<?xml version="1.0"?>
<ROWSET>
<ROW>
  <department_id>10</department_id>
  <department_name>administrator</department_name>
  <manager>200</manager>
  <location>1700</location>
</ROW>
<ROW>
  <department_id>11</department_id>
  <department_name>aaa</department_name>
  <manager>200</manager>
  <location>1700</location>
</ROW>
<ROW>
  <department_id>12</department_id>
  <department_name>bbb</department_name>
  <manager>300</manager>
  <location>1600</location>
</ROW>
<ROW>
  <department_id>13</department_id>
  <department_name>ccc</department_name>
  <manager>400</manager>
  <location>1600</location>
</ROW>
</ROWSET>
********************
ANONYMOUS BLOCK EXECUTE
DROP TABLE department;
```
- DBE_XMLGEN.RESTARTQUERY重启sql。 函数原型： 参数说明： 示例：
```
DBE_XMLGEN.GETXMLTYPE(SQLQUERY IN VARCHAR2, DTDORSCHEMA IN NUMBER := 0) RETURNS XMLTYPE;
DBE_XMLGEN.GETXMLTYPE(CTX IN DBE_XMLGEN.CTXHANDLE, DTDORSCHEMA IN NUMBER := 0) RETURNS XMLTYPE;
```

| 参数 | 描述 |
|---|---|
| SQLQUERY | 需要转换成XML的查询SQL。 |
| DTDORSCHEMA | 无意义。 |
| CTX | context handle。 |

```
CREATE TABLE IF NOT EXISTS department(department_id NUMBER, department_name VARCHAR2(30), manager NUMBER, location NUMBER);
INSERT INTO department VALUES(10, 'administrator', 200, 1700);
INSERT INTO department VALUES(11, 'aaa', 200, 1700);
INSERT INTO department VALUES(12, 'bbb', 300, 1600);
INSERT INTO department VALUES(13, 'ccc', 400, 1600);
INSERT INTO department VALUES(14, 'aaa</row><a>asd</a><row>', 400, 1600);
INSERT INTO department VALUES(15, NULL, 500,1600);
INSERT INTO department VALUES(16, '!@#$%^&*()+-=<>/\"a3_啊', 400, 1600);
DECLARE
    lr SYS_REFCURSOR;
    qryctx DBE_XMLGEN.CTXHANDLE;
    result XMLTYPE;
BEGIN
    OPEN lr FOR SELECT department_id, department_name FROM DEPARTMENT ORDER BY DEPARTMENT_ID;
    qryctx:=DBE_XMLGEN.NEWCONTEXT(lr);
 result:=DBE_XMLGEN.GETXMLTYPE(qryctx);
 DBE_XMLGEN.CLOSECONTEXT(qryctx);
        -- 返回的是xmltype类型所以需要用getclobval转换才能被put_line输出。
 DBE_OUTPUT.PUT_LINE(result.getclobval);
END;
/
<?xml version="1.0"?>
<ROWSET>
<ROW>
  <department_id>10</department_id>
  <department_name>administrator</department_name>
</ROW>
<ROW>
  <department_id>11</department_id>
  <department_name>aaa</department_name>
</ROW>
<ROW>
  <department_id>12</department_id>
  <department_name>bbb</department_name>
</ROW>
<ROW>
  <department_id>13</department_id>
  <department_name>ccc</department_name>
</ROW>
<ROW>
  <department_id>14</department_id>
  <department_name>aaa&lt;/row&gt;&lt;a&gt;asd&lt;/a&gt;&lt;row&gt;</department_name>
</ROW>
<ROW>
  <department_id>15</department_id>
</ROW>
<ROW>
  <department_id>16</department_id>
  <department_name>!@#$%^&amp;*()+-=&lt;&gt;/\&quot;a3_啊</department_name>
</ROW>
</ROWSET>
ANONYMOUS BLOCK EXECUTE
DROP TABLE department;
```
- DBE_XMLGEN.GETXMLTYPE返回XMLTYPE类型的xml文本。 函数原型： 参数说明： 示例：
```
DBE_XMLGEN.GETXML(SQLQUERY IN VARCHAR2, DTDORSCHEMA IN NUMBER := 0) RETURNS CLOB;
DBE_XMLGEN.GETXML(CTX IN DBE_XMLGEN.CTXHANDLE, DTDORSCHEMA IN NUMBER := 0) RETURNS CLOB;
DBE_XMLGEN.GETXML(CTX IN DBE_XMLGEN.CTXHANDLE, TMPCLOB INOUT CLOB, DTDORSCHEMA IN NUMBER := 0);
```

| 参数 | 描述 |
|---|---|
| SQLQUERY | 需要转换成XML的查询SQL。 |
| DTDORSCHEMA | 无意义。 |
| CTX | context handle。 |
| TMPCLOB | 用于保存输出的XML的CLOB变量。 |

```
CREATE TABLE IF NOT EXISTS department(department_id NUMBER, department_name VARCHAR2(30), manager NUMBER, location NUMBER);
INSERT INTO department VALUES(10, 'administrator', 200, 1700);
INSERT INTO department VALUES(11, 'aaa', 200, 1700);
INSERT INTO department VALUES(12, 'bbb', 300, 1600);
INSERT INTO department VALUES(13, 'ccc', 400, 1600);
INSERT INTO department VALUES(14, 'aaa</row><a>asd</a><row>', 400, 1600);
INSERT INTO department VALUES(15, NULL, 500,1600);
INSERT INTO department VALUES(16, '!@#$%^&*()+-=<>/\"a3_啊', 400, 1600);
DECLARE
    qryctx DBE_XMLGEN.CTXHANDLE;
 result CLOB;
BEGIN
 qryctx:=DBE_XMLGEN.NEWCONTEXT('SELECT * from department');
 -- 每一次查询返回的最大值。
 DBE_XMLGEN.SETMAXROWS(qryctx, 4);
 LOOP
        result := DBE_XMLGEN.GETXML(qryctx);
        -- 这一轮查询返回的数量。
        exit when DBE_XMLGEN.GETNUMROWSPROCESSED(qryctx) = 0;
        DBE_OUTPUT.PUT_LINE('-------'||DBE_XMLGEN.GETNUMROWSPROCESSED(qryctx)||'----------');
        DBE_OUTPUT.PUT_LINE(result);
        DBE_OUTPUT.PUT_LINE('********************');
    END LOOP;
    DBE_XMLGEN.RESTARTQUERY(qryctx);
    result := DBE_XMLGEN.GETXML(qryctx);
    DBE_OUTPUT.PUT_LINE('-------'||DBE_XMLGEN.GETNUMROWSPROCESSED(qryctx)||'----------');
    DBE_OUTPUT.PUT_LINE(result);
    DBE_OUTPUT.PUT_LINE('********************');
    DBE_XMLGEN.CLOSECONTEXT(qryctx);
END;
/
-------4----------
<?xml version="1.0"?>
<ROWSET>
<ROW>
  <department_id>10</department_id>
  <department_name>administrator</department_name>
  <manager>200</manager>
  <location>1700</location>
</ROW>
<ROW>
  <department_id>11</department_id>
  <department_name>aaa</department_name>
  <manager>200</manager>
  <location>1700</location>
</ROW>
<ROW>
  <department_id>12</department_id>
  <department_name>bbb</department_name>
  <manager>300</manager>
  <location>1600</location>
</ROW>
<ROW>
  <department_id>13</department_id>
  <department_name>ccc</department_name>
  <manager>400</manager>
  <location>1600</location>
</ROW>
</ROWSET>
********************
-------3----------
<?xml version="1.0"?>
<ROWSET>
<ROW>
  <department_id>14</department_id>
  <department_name>aaa&lt;/row&gt;&lt;a&gt;asd&lt;/a&gt;&lt;row&gt;</department_name>
  <manager>400</manager>
  <location>1600</location>
</ROW>
<ROW>
  <department_id>15</department_id>
  <manager>500</manager>
  <location>1600</location>
</ROW>
<ROW>
  <department_id>16</department_id>
  <department_name>!@#$%^&amp;*()+-=&lt;&gt;/\&quot;a3_啊</department_name>
  <manager>400</manager>
  <location>1600</location>
</ROW>
</ROWSET>
********************
-------4----------
<?xml version="1.0"?>
<ROWSET>
<ROW>
  <department_id>10</department_id>
  <department_name>administrator</department_name>
  <manager>200</manager>
  <location>1700</location>
</ROW>
<ROW>
  <department_id>11</department_id>
  <department_name>aaa</department_name>
  <manager>200</manager>
  <location>1700</location>
</ROW>
<ROW>
  <department_id>12</department_id>
  <department_name>bbb</department_name>
  <manager>300</manager>
  <location>1600</location>
</ROW>
<ROW>
  <department_id>13</department_id>
  <department_name>ccc</department_name>
  <manager>400</manager>
  <location>1600</location>
</ROW>
</ROWSET>
********************
ANONYMOUS BLOCK EXECUTE
DROP TABLE department;
```
- DBE_XMLGEN.GETXML返回CLOB类型的xml文本。 函数原型： 参数说明： 示例：
```
DBE_XMLGEN.CLOSECONTEXT(CTX IN DBE_XMLGEN.CTXHANDLE);
```

| 参数 | 描述 |
|---|---|
| CTX | context handle。 |

```
CREATE TABLE IF NOT EXISTS department(department_id NUMBER, department_name VARCHAR2(30), manager NUMBER, location NUMBER);
INSERT INTO department VALUES(10, 'administrator', 200, 1700);
INSERT INTO department VALUES(11, 'aaa', 200, 1700);
INSERT INTO department VALUES(12, 'bbb', 300, 1600);
INSERT INTO department VALUES(13, 'ccc', 400, 1600);
INSERT INTO department VALUES(14, 'aaa</row><a>asd</a><row>', 400, 1600);
INSERT INTO department VALUES(15, NULL, 500,1600);
INSERT INTO department VALUES(16, '!@#$%^&*()+-=<>/\"a3_啊', 400, 1600);
-- 关闭context。
DECLARE
    qryctx DBE_XMLGEN.CTXHANDLE;
    result CLOB;
BEGIN
 qryctx := DBE_XMLGEN.NEWCONTEXT('SELECT * from department where department_id=14');
 DBE_XMLGEN.SETCONVERTSPECIALCHARS(qryctx, false);
 result:=DBE_XMLGEN.GETXML(qryctx);
 DBE_XMLGEN.CLOSECONTEXT(qryctx);
 DBE_OUTPUT.PUT_LINE(result);
END;
/
<?xml version="1.0"?>
<ROWSET>
<ROW>
  <department_id>14</department_id>
  <department_name>aaa</row><a>asd</a><row></department_name>
  <manager>400</manager>
  <location>1600</location>
</ROW>
</ROWSET>
ANONYMOUS BLOCK EXECUTE
DROP TABLE department;
```
- DBE_XMLGEN.CLOSECONTEXT关闭context handle。 函数原型： 参数说明： 示例：
父主题：
二次封装接口
版权所有 © 华为技术有限公司
< 上一节
下一节 >



---


---

## DBE_XMLPARSER

#### 接口介绍
DBE_XMLPARSER用于将xml字符串反序列化，将存储xml文档的字符串转换为document节点。高级包DBE_XMLPARSER支持的所有接口请参见表1。
XMLPARSER数据类型可以被用来存储XMLPARSER数据，存储Xmlparser的数量上限为16777215。XMLPARSER数据类型能够根据输入的字符串解析建立domdocument节点，高级包还提供相应的set、get型接口，对解析过程的约束属性进行操作。
DBE_XMLPARSER高级包在字符集设置为SQL_ASCII的数据库内使用的情况下，传入超出ASCII范围的字符，会导致报错。

| 接口名称 | 描述 |
|---|---|
| DBE_XMLPARSER.FREEPARSER | 释放PARSER。 |
| DBE_XMLPARSER.GETDOCUMENT | 获取解析的document节点。 |
| DBE_XMLPARSER.GETVALIDATIONMODE | 获取validate属性。 |
| DBE_XMLPARSER.NEWPARSER | 新建PARSER实例。 |
| DBE_XMLPARSER.PARSEBUFFER | 解析VARCHAR字符串。 |
| DBE_XMLPARSER.PARSECLOB | 解析CLOB字符串。 |
| DBE_XMLPARSER.SETVALIDATIONMODE | 设置validate属性。 |

```
   DBE_XMLPARSER.FREEPARSER (
     p     IN     parser);
```

| 参数 | 描述 |
|---|---|
| p | 指定的parser类型对象。 |

```
-- 新建parser ，随后释放。
DECLARE
  l_parser dbe_xmlparser.parser;
  BEGIN
  l_parser := dbe_xmlparser.newparser;
  -- 直接释放l_parser实例
  dbe_xmlparser.freeparser(l_parser);
END;
/
```
- DBE_XMLPARSER.FREEPARSER释放给定的PARSER对象。 DBE_XMLPARSER.FREEPARSER的存储过程原型为： 示例： 执行结果：执行成功
```
DBE_XMLPARSER.GETDOCUMENT (
  p     IN     parser)
 RETURN DOMDocument;
```

| 参数 | 描述 |
|---|---|
| p | 指定的parser类型对象。 |

  - GETDOCUMENT函数无传入参数，报错。
  - GETDOCUMENT函数参数parser传入为空，返回NULL。
  - GETDOCUMENT函数传入的parser还没有解析文档，返回NULL。
示例：
```
-- 新建parser，解析字符串，GETDOCUMENT获取文档打印出来。
DECLARE
  l_parser dbe_xmlparser.parser;
  l_doc dbe_xmldom.domdocument;
  buffer varchar2 :=
'<?xml version="1.0" encoding="UTF-8"?>
<note>
<to>Tove</to>
<from>Jani</from>
<heading>Reminder</heading>
<body>Do not forget me this weekend!</body>
</note>';
  buffer2 varchar2;
  BEGIN
  l_parser := dbe_xmlparser.newparser;
-- l_parser解析字符串，通过GETDOCUMENT获取domdocument节点
  dbe_xmlparser.PARSEBUFFER(l_parser, buffer);
  l_doc := dbe_xmlparser.getdocument(l_parser);
 --将l_doc中的内容打印出来
  dbe_xmldom.writetobuffer(l_doc, buffer2);
  RAISE NOTICE '%', buffer2;
  dbe_xmlparser.freeparser(l_parser);
  dbe_xmldom.freedocument(l_doc);
END;
/
```
执行结果：
```
NOTICE:  <?xml version="1.0" encoding="UTF-8"?>
<note>
<to>Tove</to>
<from>Jani</from>
<heading>Reminder</heading>
<body>Do not forget me this weekend!</body>
</note>
ANONYMOUS BLOCK EXECUTE
```
```
DBE_XMLPARSER.GETVALIDATIONMODE (
  p     IN     parser)
 RETURN BOOLEAN;
```

| 参数 | 描述 |
|---|---|
| p | 指定的parser类型对象。 |

```
-- 新建parser,通过GETVALIDATIONMODE获取parser解析验证模式是否打开。
DECLARE
  l_parser dbe_xmlparser.parser;
BEGIN
  l_parser := dbe_xmlparser.newparser();
    if (dbe_xmlparser.GETVALIDATIONMODE(l_parser) = true) then
 RAISE NOTICE 'validation';
    else
    RAISE NOTICE 'no validation';
  end if;
  dbe_xmlparser.freeparser(l_parser);
END;
/
```
```
NOTICE:  validation
ANONYMOUS BLOCK EXECUTE
```
- DBE_XMLPARSER.GETVALIDATIONMODE 获取给定Parser的解析验证模式。如果DTD验证开启返回TRUE，否则返回FALSE。 DBE_XMLPARSER.GETVALIDATIONMODE的函数原型为： 示例： 执行结果：
```
DBE_XMLPARSER.NEWPARSER
 RETURN Parser;
```
```
-- 新建parser，解析字符串，随后释放。
DECLARE
  -- Create a parser.
  l_parser dbe_xmlparser.parser;
  l_doc dbe_xmldom.domdocument;
  buffer varchar2(1000) :=
    '<?xml version="1.0" encoding="UTF-8"?>
    <note>
    <to>Tove</to>
    <from>Jani</from>
    <heading>Reminder</heading>
    <body>Donot forget me this weekend!</body>
    </note>';
  buffer2 varchar2(1000);
  BEGIN
  l_parser := dbe_xmlparser.newparser;
  -- Parse the document and create a new DOM document.
  dbe_xmlparser.PARSEBUFFER(l_parser, buffer);
  dbe_xmlparser.freeparser(l_parser);
END;
/
```
- DBE_XMLPARSER.NEWPARSER 新建Parser对象，返回一个新的解析器实例。 DBE_XMLPARSER.NEWPARSER的函数原型为： 示例： 执行结果：执行成功
```
DBE_XMLPARSER.PARSEBUFFER (
   p     IN     parser,
   doc   IN VARCHAR2);
```

| 参数 | 描述 |
|---|---|
| p | 指定的parser类型对象。 |
| doc | 存储XML文档的字符串。 |

  - PARSEBUFFER函数能够解析的字符串最大长度为32767，超过最大长度解析报错。
  - 与A数据库差异：字符串encoding只支持UTF-8；version字段只支持1.0，1.0-1.9解析警告但正常执行，1.9以上报错。
    - !ATTLIST to type (CHECK|check|Check) "Ch..."将报错，因默认值"Ch..."不属于括号中枚举值，而A数据库不报错。
    - <!ENTITY baidu "www.baidu.com">...... &Baidu;&writer将报错，因区分字母大小写，Baidu无法与baidu对应，而A数据库不报错。
  - 与A数据库命名空间校验差异：解析未声明的命名空间标签正常执行，而A数据库会报错。
  - 与A数据库xml预定义实体解析差异：&apos;&quot;会被解析转义为字符’”，而A数据库中预定义实体统一都没有转义为字符。
示例：
```
-- 新建parser，PARSEBUFFER解析字符串，获取文档打印出来。
DECLARE
  l_parser dbe_xmlparser.parser;
  l_doc dbe_xmldom.domdocument;
  buffer varchar2 :=
'<?xml version="1.0" encoding="UTF-8"?>
<note>
<to>Tove</to>
<from>Jani</from>
<heading>Reminder</heading>
<body>Donot forget me this weekend!</body>
</note>';
  buffer2 varchar2;
  BEGIN
  l_parser := dbe_xmlparser.newparser;
  dbe_xmlparser.PARSEBUFFER(l_parser, buffer);
  l_doc := dbe_xmlparser.getdocument(l_parser);
  dbe_xmldom.writetobuffer(l_doc, buffer2);
  RAISE NOTICE '%', buffer2;
  dbe_xmlparser.freeparser(l_parser);
  dbe_xmldom.freedocument(l_doc);
END;
/
```
执行结果：
```
NOTICE:  <?xml version="1.0" encoding="UTF-8"?>
<note>
<to>Tove</to>
<from>Jani</from>
<heading>Reminder</heading>
<body>Donot forget me this weekend!</body>
</note>
ANONYMOUS BLOCK EXECUTE
```
```
DBE_XMLPARSER.PARSECLOB (
   p     IN     parser,
   doc   IN CLOB);
```

| 参数 | 描述 |
|---|---|
| p | 指定的parser类型对象 |
| doc | 存储XML文档的clob字符串 |

  - PARSECLOB不支持解析大于等于2GB的CLOB。
  - 与A数据库差异：字符串encoding只支持UTF-8；version字段只支持1.0，1.0-1.9解析警告但正常执行，1.9以上报错。
    - !ATTLIST to type (CHECK|check|Check) "Ch..."将报错，因默认值"Ch..."不属于括号中枚举值，而A数据库不报错。
    - <!ENTITY baidu "www.baidu.com">...... &Baidu;&writer将报错，因区分字母大小写，Baidu无法与baidu对应，而A数据库不报错。
  - 与A数据库命名空间校验差异：解析未声明的命名空间标签正常执行，而A数据库会报错。
  - 与A数据库xml预定义实体解析差异：&apos;&quot;会被解析转义为字符’”，而A数据库中预定义实体统一都没有转义为字符。
示例：
```
-- 新建parser，parseclob解析字符串，获取文档打印出来。
DECLARE
  l_clob clob :=
 '<?xml version="1.0" encoding="UTF-8"?>
  <note>
  <to>Tove</to>
  <from>Jani</from>
  <heading>Reminder</heading>
  <body>this weekend!</body>
  </note>';
  -- Create a parser.
  l_parser dbe_xmlparser.parser;
  l_doc dbe_xmldom.domdocument;
  buffer varchar2(1000);
  BEGIN
  l_parser := dbe_xmlparser.newparser;
  -- Parse the document and create a new DOM document.
  dbe_xmlparser.parseclob(l_parser, l_clob);
  l_doc := dbe_xmlparser.getdocument(l_parser);
  dbe_xmldom.writetobuffer(l_doc, buffer);
  RAISE NOTICE '%',buffer;
  dbe_xmlparser.freeparser(l_parser);
  dbe_xmldom.freedocument(l_doc);
  END;
  /
```
执行结果：
```
NOTICE:  <?xml version="1.0" encoding="UTF-8"?>
<note>
  <to>Tove</to>
  <from>Jani</from>
  <heading>Reminder</heading>
  <body>this weekend!</body>
</note>
ANONYMOUS BLOCK EXECUTE
```
```
DBE_XMLPARSER.SETVALIDATIONMODE(
  p     IN     parser)
  yes   IN BOOLEAN);
```

| 参数 | 描述 |
|---|---|
| p | 指定的parser类型对象。 |
| yes | 要设置的模式：TRUE：开启DTD验证。FALSE：不开启验证 |

  - SETVALIDATIONMODE函数yes传入为空，不改变parser的解析验证模式。
  - parser初始化默认为开启DTD验证模式。
示例1：
```
-- 新建parser，设置的待解析xml字符串同DTD格式不匹配。
-- setValidationMode设置为false可以正常解析，设置为true后解析报错。
DECLARE
  l_clob clob :=
 '<!DOCTYPE note [
 <!ELEMENT note (to,from,heading,body)>
 <!ELEMENT to (#PCDATA)>
 <!ELEMENT from (#PCDATA)>
 <!ELEMENT heading (#PCDATA)>
 <!ELEMENT body (#PCDATA)>
 ]>
 <table>
 <name attr1="WEB" attr2="web2">African Coffee Table</name>
 <width>80</width>
 <length>120</length>
 </table>';
  l_parser dbe_xmlparser.parser;
  l_doc dbe_xmldom.domdocument;
 buffer varchar2(1000);
  BEGIN
  l_parser := dbe_xmlparser.newparser;
  -- 设为 false，去解析
    dbe_xmlparser.setValidationMode(l_parser, false);
    dbe_xmlparser.parseclob(l_parser, l_clob);
    l_doc := dbe_xmlparser.getdocument(l_parser);
    dbe_xmldom.writetobuffer(l_doc, buffer);
    RAISE NOTICE '%', buffer;
    dbe_xmlparser.freeparser(l_parser);
    dbe_xmldom.freedocument(l_doc);
  END;
  /
```
执行结果：
```
NOTICE:  <?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE note [
<!ELEMENT note (to , from , heading , body)>
<!ELEMENT to (#PCDATA)>
<!ELEMENT from (#PCDATA)>
<!ELEMENT heading (#PCDATA)>
<!ELEMENT body (#PCDATA)>
]>
<table>
 <name attr1="WEB" attr2="web2">African Coffee Table</name>
 <width>80</width>
 <length>120</length>
 </table>
ANONYMOUS BLOCK EXECUTE
```
示例2：
```
-- 新建parser，设置的待解析xml字符串同DTD格式不匹配。
-- setValidationMode设置为true后解析报错。
DECLARE
  l_clob clob :=
 '<!DOCTYPE note [
 <!ELEMENT note (to,from,heading,body)>
 <!ELEMENT to (#PCDATA)>
 <!ELEMENT from (#PCDATA)>
 <!ELEMENT heading (#PCDATA)>
 <!ELEMENT body (#PCDATA)>
 ]>
 <table>
 <name attr1="WEB" attr2="web2">African Coffee Table</name>
 <width>80</width>
 <length>120</length>
 </table>';
  l_parser dbe_xmlparser.parser;
  l_doc dbe_xmldom.domdocument;
 buffer varchar2(1000);
  BEGIN
  l_parser := dbe_xmlparser.newparser;
  -- 设为 true，去解析。
  --xml字符串不符合DTD格式，预期将报错
    dbe_xmlparser.setValidationMode(l_parser, true);
    dbe_xmlparser.parseclob(l_parser, l_clob);
    l_doc := dbe_xmlparser.getdocument(l_parser);
    dbe_xmldom.writetobuffer(l_doc, buffer);
    dbe_xmlparser.freeparser(l_parser);
    dbe_xmldom.freedocument(l_doc);
  END;
  /
```
执行结果：
```
xmlparser解析报错
ERROR:  invalid XML document
```
父主题：
二次封装接口
版权所有 © 华为技术有限公司
< 上一节
下一节 >



---

