# SQL与描述

SQL 执行与描述相关：动态 SQL、游标、列描述等。

---

## DBE_SQL

#### 数据类型介绍
```
CREATE TYPE DBE_SQL.DESC_REC AS (
      col_type            int,
      col_max_len         int,
      col_name            VARCHAR2(32),
      col_name_len        int,
      col_schema_name     VARCHAR2(32),
      col_schema_name_len int,
      col_precision       int,
      col_scale           int,
      col_charsetid       int,
      col_charsetform     int,
      col_null_ok         BOOLEAN
);
```
- DBE_SQL.DESC_REC该类型是复合类型，用来存储DBE_SQL.SQL_DESCRIBE_COLUMNS接口中的描述信息。 DBE_SQL.DESC_REC类型的原型为：
```
CREATE TYPE DBE_SQL.DESC_TAB AS TABLE OF DBE_SQL.DESC_REC INDEX BY INTEGER;
```
- DBE_SQL.DESC_TAB该类型是DESC_REC的TABLE类型，通过TABLE OF语法实现。 DBE_SQL.DESC_TAB类型的原型为：
```
CREATE TYPE DBE_SQL.DATE_TABLE AS TABLE OF DATE INDEX BY INTEGER;
```
  - 在数据库初始化阶段，若GUC参数mapping_date_to_datea的值为on，则会将DBE_SQL.DATE_TABLE映射为DATEA的TABLE类型，若GUC参数mapping_date_to_datea的值为off，则会将DBE_SQL.DATE_TABLE映射为TIMESTAMP(0) WITHOUT TIME ZONE的TABLE类型。数据库初始化完成后，则GUC参数mapping_date_to_datea的值不再影响到DBE_SQL.DATE_TABLE的具体类型映射。
  - 在数据库初始化阶段和使用阶段GUC参数mapping_date_to_datea的值不同，会导致部分DBE_SQL函数使用DATE_TABLE时出现类型不匹配的情况，因此建议保持数据库初始化阶段和使用阶段GUC参数mapping_date_to_datea的值相同。
```
CREATE TYPE DBE_SQL.NUMBER_TABLE AS TABLE OF NUMBER INDEX BY INTEGER;
```
- DBE_SQL.NUMBER_TABLE该类型是NUMBER的TABLE类型，通过TABLE OF语法实现。 DBE_SQL.NUMBER_TABLE类型的原型为：
```
CREATE TYPE DBE_SQL.VARCHAR2_TABLE AS TABLE OF VARCHAR2(32767) INDEX BY INTEGER;
```
- DBE_SQL.VARCHAR2_TABLE该类型是VARCHAR2的TABLE类型，通过TABLE OF语法实现。 DBE_SQL.VARCHAR2_TABLE类型的原型为：
```
CREATE TYPE DBE_SQL.BLOB_TABLE AS TABLE OF BLOB INDEX BY INTEGER;
```
- DBE_SQL.BLOB_TABLE该类型是BLOB的TABLE类型，通过TABLE OF语法实现。 DBE_SQL.BLOB_TABLE类型的原型为：
#### 接口介绍
高级功能包DBE_SQL支持的接口请参见表1。

| 接口名称 | 描述 |
|---|---|
| DBE_SQL.REGISTER_CONTEXT | 打开一个游标。 |
| DBE_SQL.SQL_UNREGISTER_CONTEXT | 关闭一个已打开的游标。 |
| DBE_SQL.SQL_SET_SQL | 向游标传递一组SQL语句或匿名块。 |
| DBE_SQL.SQL_RUN | 执行给定游标中的SQL语句或匿名块。 |
| DBE_SQL.NEXT_ROW | 读取游标一行数据。 |
| DBE_SQL.SET_RESULT_TYPE | 动态定义一个列。 |
| DBE_SQL.SET_RESULT_TYPE_CHAR | 动态定义一个CHAR类型的列。 |
| DBE_SQL.SET_RESULT_TYPE_INT | 动态定义一个INT类型的列。 |
| DBE_SQL.SET_RESULT_TYPE_LONG | 动态定义一个LONG类型的列。 |
| DBE_SQL.SET_RESULT_TYPE_RAW | 动态定义一个RAW类型的列。 |
| DBE_SQL.SET_RESULT_TYPE_BYTEA | 动态定义一个BYTEA类型的列。 |
| DBE_SQL.SET_RESULT_TYPE_TEXT | 动态定义一个TEXT类型的列。 |
| DBE_SQL.SET_RESULT_TYPE_UNKNOWN | 动态定义一个未知列（类型不识别时使用此接口）。 |
| DBE_SQL.GET_RESULT | 读取一个已动态定义的列值。 |
| DBE_SQL.GET_RESULT_CHAR | 读取一个已动态定义的列值（指定CHAR类型）。 |
| DBE_SQL.GET_RESULT_INT | 读取一个已动态定义的列值（指定INT类型）。 |
| DBE_SQL.GET_RESULT_LONG | 读取一个已动态定义的列值（指定LONG类型）。 |
| DBE_SQL.GET_RESULT_RAW | 读取一个已动态定义的列值（指定RAW类型）。 |
| DBE_SQL.GET_RESULT_BYTEA | 读取一个已动态定义的列值（指定BYTEA类型）。 |
| DBE_SQL.GET_RESULT_TEXT | 读取一个已动态定义的列值（指定TEXT类型）。 |
| DBE_SQL.GET_RESULT_UNKNOWN | 读取一个已动态定义的列值（类型不识别时使用此接口）。 |
| DBE_SQL.DBE_SQL_GET_RESULT_CHAR | 读取一个已动态定义的列值（指定CHAR类型）。 |
| DBE_SQL.DBE_SQL_GET_RESULT_LONG | 读取一个已动态定义的列值（指定LONG类型）。 |
| DBE_SQL.DBE_SQL_GET_RESULT_LONG2 | 读取一个已动态定义的列值（指定LONG类型）。 |
| DBE_SQL.DBE_SQL_GET_RESULT_RAW | 读取一个已动态定义的列值（指定RAW类型）。 |
| DBE_SQL.IS_ACTIVE | 检查游标是否已打开。 |
| DBE_SQL.LAST_ROW_COUNT | 返回获取行数的累积计数。 |
| DBE_SQL.RUN_AND_NEXT | 在游标上执行一组动态定义操作后，读取游标数据。 |
| DBE_SQL.SQL_BIND_VARIABLE | 根据语句中的变量，绑定一个值到该变量。 |
| DBE_SQL.SQL_BIND_ARRAY | 根据语句中的变量，绑定一组值到该变量。 |
| DBE_SQL.SET_RESULT_TYPE_INTS | 动态定义一个INT数组类型的列。 |
| DBE_SQL.SET_RESULT_TYPE_TEXTS | 动态定义一个TEXT数组类型的列。 |
| DBE_SQL.SET_RESULT_TYPE_RAWS | 动态定义一个RAW数组类型的列。 |
| DBE_SQL.SET_RESULT_TYPE_BYTEAS | 动态定义一个BYTEA数组类型的列。 |
| DBE_SQL.SET_RESULT_TYPE_CHARS | 动态定义一个CHAR数组类型的列。 |
| DBE_SQL.SET_RESULTS_TYPE | 动态定义一个数组类型的列。 |
| DBE_SQL.GET_RESULTS_INT | 读取一个已动态定义的列值（指定INT数组类型）。 |
| DBE_SQL.GET_RESULTS_TEXT | 读取一个已动态定义的列值（指定TEXT数组类型）。 |
| DBE_SQL.GET_RESULTS_RAW | 读取一个已动态定义的列值（指定RAW数组类型）。 |
| DBE_SQL.GET_RESULTS_BYTEA | 读取一个已动态定义的列值（指定BYTEA数组类型）。 |
| DBE_SQL.GET_RESULTS_CHAR | 读取一个已动态定义的列值（指定CHAR数组类型）。 |
| DBE_SQL.GET_RESULTS | 读取一个已动态定义的列值。 |
| DBE_SQL.SQL_DESCRIBE_COLUMNS | 描述游标读取的列信息。 |
| DBE_SQL.DESCRIBE_COLUMNS | 描述游标读取的列信息。 |
| DBE_SQL.BIND_VARIABLE | 绑定参数接口。 |
| DBE_SQL.SQL_SET_RESULTS_TYPE_C | 动态定义一个数组类型的列。 |
| DBE_SQL.SQL_GET_VALUES_C | 读取一个已动态定义的列值。 |
| DBE_SQL.GET_VARIABLE_RESULT | 读取一个SQL语句执行后的返回值。 |
| DBE_SQL.GET_VARIABLE_RESULT_CHAR | 读取一个SQL语句执行后的返回值（指定CHAR类型）。 |
| DBE_SQL.GET_VARIABLE_RESULT_RAW | 读取一个SQL语句执行后的返回值（指定RAW类型）。 |
| DBE_SQL.GET_VARIABLE_RESULT_TEXT | 读取一个SQL语句执行后的返回值（指定TEXT类型）。 |
| DBE_SQL.GET_VARIABLE_RESULT_INT | 读取一个SQL语句执行后的返回值（指定INT类型）。 |
| DBE_SQL.GET_ARRAY_RESULT_TEXT | 读取一个SQL语句执行后的返回值（指定TEXT数组类型）。 |
| DBE_SQL.GET_ARRAY_RESULT_RAW | 读取一个SQL语句执行后的返回值（指定RAW数组类型）。 |
| DBE_SQL.GET_ARRAY_RESULT_CHAR | 读取一个SQL语句执行后的返回值（指定CHAR数组类型）。 |
| DBE_SQL.GET_ARRAY_RESULT_INT | 读取一个SQL语句执行后的返回值（指定INT数组类型）。 |
| DBE_SQL.SQL_SET_TABLEOF_RESULTS_TYPE_C | 动态定义一个TABLEOF类型的列。 |
| DBE_SQL.SQL_GET_TABLEOF_VALUES_C | 读取一个已动态定义的TABLEOF类型的列值。 |

 - 建议使用DBE_SQL.SET_RESULT_TYPE及DBE_SQL.GET_RESULT定义参数列。
- 当结果集大小超过GUC参数work_mem的设置值时，将触发结果集的临时磁盘存储，但临时磁盘存储最大阈值不超过512MB。
```
DBE_SQL.REGISTER_CONTEXT(
)
RETURN INTEGER;
```
- DBE_SQL.REGISTER_CONTEXT该函数用来打开一个游标，是后续DBE_SQL各项操作的前提。该函数不传入任何参数，内部自动递增生成游标ID，并作为返回值返回给integer定义的变量。 DBE_SQL打开的游标是会话级的变量，不支持跨会话调用打开的游标（如自治事务），如果调用跨会话的游标行为不可预知。 DBE_SQL.REGISTER_CONTEXT原型为：
```
DBE_SQL.SQL_UNREGISTER_CONTEXT(
    context_id    IN INTEGER
)
RETURN INTEGER;
```

| 参数名称 | 类型 | 入参/出参 | 是否可以为空 | 描述 |
|---|---|---|---|---|
| context_id | INTEGER | IN | 否 | 将要关闭的游标id号。 |

- DBE_SQL.SQL_UNREGISTER_CONTEXT该函数用来关闭一个游标，是DBE_SQL各项操作的结束步骤。如果在存储过程结束时未调用该函数，游标占用的内存将不会被释放。因此，关闭游标至关重要。由于异常情况可能导致存储过程提前退出，从而未能关闭游标，建议在存储过程的异常处理中包含此接口。 DBE_SQL.SQL_UNREGISTER_CONTEXT原型为：
```
DBE_SQL.SQL_SET_SQL(
    context_id    IN INTEGER,
    query_string  IN TEXT,
    language_flag IN INTEGER
)
RETURN BOOLEAN;
```

| 参数名称 | 类型 | 入参/出参 | 是否可以为空 | 描述 |
|---|---|---|---|---|
| context_id | INTEGER | IN | 否 | 执行查询语句解析的游标id。 |
| query_string | TEXT | IN | 否 | 执行解析的查询语句。 |
| language_flag | INTEGER | IN | 否 | 版本语言号。指定不同版本的行为，1为非兼容版本，2为兼容A版本。 |

- DBE_SQL.SQL_SET_SQL该函数用来解析给定游标的SQL语句或匿名块。目前语句参数仅可通过text类型传递，长度不大于1G。 DBE_SQL.SQL_SET_SQL原型为：
```
DBE_SQL.SQL_RUN(
    context_id    IN INTEGER,
)
RETURN INTEGER;
```

| 参数名称 | 类型 | 入参/出参 | 是否可以为空 | 描述 |
|---|---|---|---|---|
| context_id | INTEGER | IN | 否 | 执行查询语句解析的游标id。 |

- DBE_SQL.SQL_RUN该函数用于执行指定的游标。它接收一个游标id，并执行给定游标中的SQL语句或匿名块。 DBE_SQL.SQL_RUN原型为：
```
DBE_SQL.NEXT_ROW(
    context_id    IN INTEGER,
)
RETURN INTEGER;
```

| 参数名称 | 类型 | 入参/出参 | 是否可以为空 | 描述 |
|---|---|---|---|---|
| context_id | INTEGER | IN | 否 | 执行的游标id。 |

- DBE_SQL.NEXT_ROW该函数返回符合查询条件的数据行数，每次调用该函数时，都会获取一个新的行数的集合，直到数据读取完毕获取不到新行为止。 DBE_SQL.NEXT_ROW原型为：
```
DBE_SQL.SET_RESULT_TYPE(
    context_id IN INTEGER,
    pos        IN INTEGER,
    column_ref IN ANYELEMENT,
    maxsize    IN INTEGER default 1024
)
RETURN INTEGER;
```

| 参数名称 | 类型 | 入参/出参 | 是否可以为空 | 描述 |
|---|---|---|---|---|
| context_id | INTEGER | IN | 否 | 执行的游标id。 |
| pos | INTEGER | IN | 否 | 查询列在返回结果中的相对位置，起始为1。 |
| column_ref | ANYELEMENT | IN | 否 | 任意类型的变量，可根据变量类型选择适当的接口动态定义列。 |
| maxsize | INTEGER | IN | 是 | 定义的列返回类型长度。 |

- DBE_SQL.SET_RESULT_TYPE该函数用来定义从指定游标返回的列。该接口只能应用于SELECT定义的游标。定义的列通过查询列表中的相对位置进行标识，传入变量的数据类型决定了该列被定义的类型。 DBE_SQL.SET_RESULT_TYPE原型为：
```
DBE_SQL.SET_RESULT_TYPE_CHAR(
    context_id  IN INTEGER,
    pos         IN INTEGER,
    column_ref  IN TEXT,
    column_size IN INTEGER
)
RETURN INTEGER;
```

| 参数名称 | 类型 | 入参/出参 | 是否可以为空 | 描述 |
|---|---|---|---|---|
| context_id | INTEGER | IN | 否 | 执行的游标id。 |
| pos | INTEGER | IN | 否 | 动态定义列在查询中的位置。 |
| column_ref | TEXT | IN | 否 | 需要定义的某类型的参数变量。 |
| column_size | INTEGER | IN | 否 | 动态定义列长度。 |

- DBE_SQL.SET_RESULT_TYPE_CHAR该函数用来定义从指定游标返回的CHAR类型的列。该接口只能应用于SELECT定义的游标。定义的列通过查询列表中的相对位置来标识，传入变量的数据类型决定了该列被定义的类型。 DBE_SQL.SET_RESULT_TYPE_CHAR原型为：
```
DBE_SQL.SET_RESULT_TYPE_INT(
    context_id IN INTEGER,
    pos        IN INTEGER
)
RETURN INTEGER;
```

| 参数名称 | 类型 | 入参/出参 | 是否可以为空 | 描述 |
|---|---|---|---|---|
| context_id | INTEGER | IN | 否 | 执行的游标id。 |
| pos | INTEGER | IN | 否 | 动态定义列在查询中的位置。 |

- DBE_SQL.SET_RESULT_TYPE_INT该函数用来定义从指定游标返回的INT类型的列。该接口只能应用于SELECT定义的游标。定义的列通过查询列表中的相对位置来标识，传入变量的数据类型决定了该列被定义的类型。 DBE_SQL.SET_RESULT_TYPE_INT原型为：
```
DBE_SQL.SET_RESULT_TYPE_LONG(
    context_id IN INTEGER,
    pos        IN INTEGER
)
RETURN INTEGER;
```

| 参数名称 | 类型 | 入参/出参 | 是否可以为空 | 描述 |
|---|---|---|---|---|
| context_id | INTEGER | IN | 否 | 执行的游标id。 |
| pos | INTEGER | IN | 否 | 动态定义列在查询中的位置。 |

- DBE_SQL.SET_RESULT_TYPE_LONG该函数用来定义从指定游标返回的长列类型（非数据类型long）的列。该接口只能应用于SELECT定义的游标。定义的列通过查询列表中的相对位置来标识，传入变量的数据类型决定了该列被定义的类型。长列的大小限制为1G。 DBE_SQL.SET_RESULT_TYPE_LONG原型为：
```
DBE_SQL.SET_RESULT_TYPE_RAW(
    context_id  IN INTEGER,
    pos         IN INTEGER,
    column_ref  IN RAW,
    column_size IN INTEGER
)
RETURN INTEGER;
```

| 参数名称 | 类型 | 入参/出参 | 是否可以为空 | 描述 |
|---|---|---|---|---|
| context_id | INTEGER | IN | 否 | 执行的游标id。 |
| pos | INTEGER | IN | 否 | 动态定义列在查询中的位置。 |
| column_ref | RAW | IN | 否 | RAW类型的参数变量。 |
| column_size | INTEGER | IN | 否 | 列的长度。 |

- DBE_SQL.SET_RESULT_TYPE_RAW该函数用来定义从指定游标返回的RAW类型的列。该接口只能应用于SELECT定义的游标。定义的列通过查询列表中的相对位置来标识，传入变量的数据类型决定了该列被定义的类型。 DBE_SQL.SET_RESULT_TYPE_RAW原型为：
```
DBE_SQL.SET_RESULT_TYPE_BYTEA(
    context_id  IN INTEGER,
    pos         IN INTEGER,
    column_ref  IN BYTEA,
    column_size IN INTEGER
)
RETURN INTEGER;
```

| 参数名称 | 类型 | 入参/出参 | 是否可以为空 | 描述 |
|---|---|---|---|---|
| context_id | INTEGER | IN | 否 | 执行的游标id。 |
| pos | INTEGER | IN | 否 | 动态定义列在查询中的位置。 |
| column_ref | BYTEA | IN | 否 | BYTEA类型的参数变量。 |
| column_size | INTEGER | IN | 否 | 列的长度。 |

- DBE_SQL.SET_RESULT_TYPE_BYTEA该函数用来定义从指定游标返回的BYTEA类型的列。该接口只能应用于SELECT定义的游标。定义的列通过查询列表中的相对位置来标识，传入变量的数据类型决定了该列被定义的类型。 DBE_SQL.SET_RESULT_TYPE_BYTEA原型为：
```
DBE_SQL.SET_RESULT_TYPE_TEXT(
    context_id IN INTEGER,
    pos        IN INTEGER,
    maxsize    IN INTEGER
)
RETURN INTEGER;
```

| 参数名称 | 类型 | 入参/出参 | 是否可以为空 | 描述 |
|---|---|---|---|---|
| context_id | INTEGER | IN | 否 | 执行的游标id。 |
| pos | INTEGER | IN | 否 | 动态定义列在查询中的位置。 |
| maxsize | INTEGER | IN | 否 | 定义的TEXT类型的最大长度。 |

- DBE_SQL.SET_RESULT_TYPE_TEXT该函数用来定义从指定游标返回的TEXT类型的列。该接口只能应用于SELECT定义的游标。定义的列通过查询列表中的相对位置来标识，传入变量的数据类型决定了该列被定义的类型。 DBE_SQL.SET_RESULT_TYPE_TEXT原型为：
```
DBE_SQL.SET_RESULT_TYPE_UNKNOWN(
    context_id IN INTEGER,
    pos        IN INTEGER,
    col_type   IN TEXT
)
RETURN INTEGER;
```

| 参数名称 | 类型 | 入参/出参 | 是否可以为空 | 描述 |
|---|---|---|---|---|
| context_id | INTEGER | IN | 否 | 执行的游标id。 |
| pos | INTEGER | IN | 否 | 动态定义列在查询中的位置。 |
| col_type | TEXT | IN | 否 | 动态定义的参数。 |

- DBE_SQL.SET_RESULT_TYPE_UNKNOWN该函数用来处理从给定游标返回的未知数据类型的列，该接口仅在数据类型无法识别时用于报错并退出。 DBE_SQL.SET_RESULT_TYPE_UNKNOWN原型为：
```
DBE_SQL.GET_RESULT(
    context_id   IN    INTEGER,
    pos          IN    INTEGER,
    column_value INOUT ANYELEMENT
)
RETURN ANYELEMENT;
```

| 参数名称 | 类型 | 入参/出参 | 是否可以为空 | 描述 |
|---|---|---|---|---|
| context_id | INTEGER | IN | 否 | 执行的游标id。 |
| pos | INTEGER | IN | 否 | 查询列在返回结果中的相对位置，起始为1。 |
| column_value | ANYELEMENT | INOUT | 否 | 指定列的查询结果返回值。 |

- DBE_SQL.GET_RESULT该函数用来返回指定游标在给定位置的元素值。该接口访问的是由DBE_SQL.NEXT_ROW获取的数据。 DBE_SQL.GET_RESULT原型为：
```
DBE_SQL.GET_RESULT_CHAR(
    context_id    IN    INTEGER,
    pos           IN    INTEGER,
    tr            INOUT CHAR，
    err           INOUT NUMERIC,
    actual_length INOUT INTEGER
);
```

| 参数名称 | 类型 | 入参/出参 | 是否可以为空 | 描述 |
|---|---|---|---|---|
| context_id | INTEGER | IN | 否 | 执行的游标id。 |
| pos | INTEGER | IN | 否 | 查询列在返回结果中的相对位置，起始为1。 |
| tr | CHAR | INOUT | 否 | 返回值。 |
| err | NUMERIC | INOUT | 否 | 错误号。传出参数，须传入变量做参数。目前未实现，固定传出-1。 |
| actual_length | INTEGER | INOUT | 否 | 返回值的实际长度。 |

- DBE_SQL.GET_RESULT_CHAR该函数用来返回指定游标在给定位置的CHAR类型的值，该接口访问的是由DBE_SQL.NEXT_ROW获取的数据。 DBE_SQL.GET_RESULT_CHAR原型为：
```
DBE_SQL.GET_RESULT_CHAR(
    context_id IN    INTEGER,
    pos        IN    INTEGER,
    tr         INOUT CHAR
);
```

| 参数名称 | 类型 | 入参/出参 | 是否可以为空 | 描述 |
|---|---|---|---|---|
| context_id | INTEGER | IN | 否 | 执行的游标id。 |
| pos | INTEGER | IN | 否 | 动态定义列在查询中的位置。 |
| tr | CHAR | INOUT | 否 | 返回值。 |

- DBE_SQL.GET_RESULT_CHAR存储过程的重载为：
```
DBE_SQL.GET_RESULT_INT(
    context_id IN INTEGER,
    pos        IN INTEGER
)
RETURN INTEGER;
```

| 参数名称 | 类型 | 入参/出参 | 是否可以为空 | 描述 |
|---|---|---|---|---|
| context_id | INTEGER | IN | 否 | 执行的游标id。 |
| pos | INTEGER | IN | 否 | 动态定义列在查询中的位置。 |

- DBE_SQL.GET_RESULT_INT该函数用来返回指定游标在给定位置的INT类型的值。该接口访问的是由DBE_SQL.NEXT_ROW获取的数据。 DBE_SQL.GET_RESULT_INT原型为：
```
DBE_SQL.GET_RESULT_LONG(
    context_id IN INTEGER,
    pos        IN    INTEGER,
    lgth       IN    INTEGER,
    off_set    IN    INTEGER,
    vl         INOUT TEXT，
    vl_length  INOUT INTEGER
)
RETURN RECORD;
```

| 参数名称 | 类型 | 入参/出参 | 是否可以为空 | 描述 |
|---|---|---|---|---|
| context_id | INTEGER | IN | 否 | 执行的游标id。 |
| pos | INTEGER | IN | 否 | 动态定义列在查询中的位置。 |
| lgth | INTEGER | IN | 否 | 返回值的长度。 |
| off_set | INTEGER | IN | 否 | 返回值的起始位置。 |
| vl | TEXT | INOUT | 否 | 返回值。 |
| vl_length | INTEGER | INOUT | 否 | 实际返回值的长度。 |

- DBE_SQL.GET_RESULT_LONG该函数用来返回指定游标在给定位置的长列（非long/bigint整型）类型的值。该接口访问的是由DBE_SQL.NEXT_ROW获取的数据。 DBE_SQL.GET_RESULT_LONG原型为：
```
DBE_SQL.GET_RESULT_RAW(
    context_id    IN    INTEGER,
    pos           IN    INTEGER,
    tr            INOUT RAW，
    err           INOUT NUMERIC,
    actual_length INOUT INTEGER
);
```

| 参数名称 | 类型 | 入参/出参 | 是否可以为空 | 描述 |
|---|---|---|---|---|
| context_id | INTEGER | IN | 否 | 执行的游标id。 |
| pos | INTEGER | IN | 否 | 动态定义列在查询中的位置。 |
| tr | RAW | INOUT | 否 | 返回的列值。 |
| err | NUMERIC | INOUT | 否 | 错误号。传出参数，须传入变量做参数。目前未实现，固定传出-1。 |
| actual_length | INTEGER | INOUT | 否 | 返回值的实际长度，不能长于此值，否则截断。 |

- DBE_SQL.GET_RESULT_RAW该函数用来返回指定游标在给定位置的RAW类型的值。该接口访问的是由DBE_SQL.NEXT_ROW获取的数据。 DBE_SQL.GET_RESULT_RAW原型为：
```
DBE_SQL.GET_RESULT_RAW(
    context_id IN    INTEGER,
    pos        IN    INTEGER,
    tr         INOUT RAW
);
```

| 参数名称 | 类型 | 入参/出参 | 是否可以为空 | 描述 |
|---|---|---|---|---|
| context_id | INTEGER | IN | 否 | 执行的游标id。 |
| pos | INTEGER | IN | 否 | 动态定义列在查询中的位置。 |
| tr | RAW | INOUT | 否 | 返回的列值。 |

- DBE_SQL.GET_RESULT_RAW重载为：
```
DBE_SQL.GET_RESULT_BYTEA(
    context_id IN INTEGER,
    pos        IN INTEGER
)
RETURN BYTEA;
```

| 参数名称 | 类型 | 入参/出参 | 是否可以为空 | 描述 |
|---|---|---|---|---|
| context_id | INTEGER | IN | 否 | 执行的游标id。 |
| pos | INTEGER | IN | 否 | 动态定义列在查询中的位置。 |

- DBE_SQL.GET_RESULT_BYTEA该函数用来返回指定游标在给定位置的BYTEA类型的值。该接口访问的是由DBE_SQL.NEXT_ROW获取的数据。 DBE_SQL.GET_RESULT_BYTEA原型为：
```
DBE_SQL.GET_RESULT_TEXT(
    context_id IN  INTEGER,
    pos        IN  INTEGER
)
RETURN TEXT;
```

| 参数名称 | 类型 | 入参/出参 | 是否可以为空 | 描述 |
|---|---|---|---|---|
| context_id | INTEGER | IN | 否 | 执行的游标id。 |
| pos | INTEGER | IN | 否 | 动态定义列在查询中的位置。 |

- DBE_SQL.GET_RESULT_TEXT该函数用来返回指定游标在给定位置的TEXT类型的值。该接口访问的是由DBE_SQL.NEXT_ROW获取的数据。 DBE_SQL.GET_RESULT_TEXT原型为：
```
DBE_SQL.GET_RESULT_UNKNOWN(
    context_id IN INTEGER,
    pos        IN INTEGER,
    col_type   IN TEXT
)
RETURN TEXT;
```

| 参数名称 | 类型 | 入参/出参 | 是否可以为空 | 描述 |
|---|---|---|---|---|
| context_id | INTEGER | IN | 否 | 执行的游标id。 |
| pos | INTEGER | IN | 否 | 动态定义列在查询中的位置。 |
| col_type | TEXT | IN | 否 | 返回的参数类型。 |

- DBE_SQL.GET_RESULT_UNKNOWN该函数用来返回指定游标在给定位置的未知类型的值。该接口为类型不支持时的报错处理接口。 DBE_SQL.GET_RESULT_UNKNOWN原型为：
```
DBE_SQL.DBE_SQL_GET_RESULT_CHAR(
    context_id IN INTEGER,
    pos        IN INTEGER
)
RETURN CHARACTER;
```

| 参数名称 | 类型 | 入参/出参 | 是否可以为空 | 描述 |
|---|---|---|---|---|
| context_id | INTEGER | IN | 否 | 执行的游标id。 |
| pos | INTEGER | IN | 否 | 动态定义列在查询中的位置。 |

- DBE_SQL.DBE_SQL_GET_RESULT_CHAR该函数用来返回指定游标在给定位置的CHAR类型的值。该接口访问的是由DBE_SQL.NEXT_ROW获取的数据。和DBE_SQL.GET_RESULT_CHAR的区别是，该函数不设置返回值长度，返回整个字符串。 DBE_SQL.DBE_SQL_GET_RESULT_CHAR原型为：
```
DBE_SQL.DBE_SQL_GET_RESULT_LONG(
    context_id IN INTEGER,
    pos        IN INTEGER
)
RETURN BIGINT;
```

| 参数名称 | 类型 | 入参/出参 | 是否可以为空 | 描述 |
|---|---|---|---|---|
| context_id | INTEGER | IN | 否 | 执行的游标id。 |
| pos | INTEGER | IN | 否 | 动态定义列在查询中的位置。 |

- DBE_SQL.DBE_SQL_GET_RESULT_LONG该函数用来返回指定游标在给定位置的长列（非long/bigint整型）类型的值。该接口访问的是由DBE_SQL.NEXT_ROW获取的数据。和DBE_SQL.GET_RESULT_LONG的区别在于，该函数不设置返回值长度，返回整个BIGINT值。 DBE_SQL.DBE_SQL_GET_RESULT_LONG原型为： 由于该函数的返回类型和DBE_SQL.SET_RESULT_TYPE_LONG、DBE_SQL.GET_RESULT_LONG不一致，请使用DBE_SQL.DBE_SQL_GET_RESULT_LONG2代替。
```
DBE_SQL.DBE_SQL_GET_RESULT_LONG2(
    context_id IN INTEGER,
    pos        IN INTEGER
)
RETURN TEXT;
```

| 参数名称 | 类型 | 入参/出参 | 是否可以为空 | 描述 |
|---|---|---|---|---|
| context_id | INTEGER | IN | 否 | 执行的游标id。 |
| pos | INTEGER | IN | 否 | 动态定义列在查询中的位置。 |

- DBE_SQL.DBE_SQL_GET_RESULT_LONG2该函数用来返回指定游标在给定位置的长列（非long/bigint整型）类型的值。该接口访问的是由DBE_SQL.NEXT_ROW获取的数据。和DBE_SQL.GET_RESULT_LONG的区别在于，该函数不设置返回值长度，返回整列的值。 DBE_SQL.DBE_SQL_GET_RESULT_LONG2原型为：
```
DBE_SQL.GET_RESULT_RAW(
    context_id IN    INTEGER,
    pos        IN    INTEGER,
    tr         INOUT RAW
)
RETURN RAW;
```

| 参数名称 | 类型 | 入参/出参 | 是否可以为空 | 描述 |
|---|---|---|---|---|
| context_id | INTEGER | IN | 否 | 执行的游标id。 |
| pos | INTEGER | IN | 否 | 动态定义列在查询中的位置。 |
| tr | RAW | INOUT | 否 | 返回的列值。 |

- DBE_SQL.DBE_SQL_GET_RESULT_RAW该函数用来返回指定游标在给定位置的RAW类型的值。该接口访问的是由DBE_SQL.NEXT_ROW获取的数据。和函数DBE_SQL.GET_RESULT_RAW的区别在于，该函数不设置返回值长度，返回整个字符串。 DBE_SQL.DBE_SQL_GET_RESULT_RAW原型为：
```
DBE_SQL.IS_ACTIVE(
    context_id     IN   INTEGER
)
RETURN BOOLEAN;
```

| 参数名称 | 类型 | 入参/出参 | 是否可以为空 | 描述 |
|---|---|---|---|---|
| context_id | INTEGER | IN | 否 | 被查询的游标id。 |

- DBE_SQL.IS_ACTIVE该函数用来返回游标的当前状态。游标处于打开、解析、执行、定义时为true；关闭后为false；未知时报错；其余默认为关闭。 DBE_SQL.IS_ACTIVE原型为：
```
DBE_SQL.LAST_ROW_COUNT(
)
RETURN INTEGER;
```
- DBE_SQL.LAST_ROW_COUNT该函数用于返回最近一次NEXT_ROW执行后获取的数据行数的累积计数。 DBE_SQL.LAST_ROW_COUNT原型为：
```
DBE_SQL.RUN_AND_NEXT(
    context_id IN INTEGER
)
RETURNS INTEGER;
```

| 参数名称 | 类型 | 入参/出参 | 是否可以为空 | 描述 |
|---|---|---|---|---|
| context_id | INTEGER | IN | 否 | 执行查询语句解析的游标id。 |

- DBE_SQL.RUN_AND_NEXT该函数的功能等同于在调用SQL_RUN后接着调用NEXT_ROW。 DBE_SQL.RUN_AND_NEXT原型为：
```
DBE_SQL.SQL_BIND_VARIABLE(
    context_id     IN int,
    query_string   IN text,
    language_flag  IN anyelement,
    out_value_size IN int default null
)
RETURNS void;
```

| 参数名称 | 类型 | 入参/出参 | 是否可以为空 | 描述 |
|---|---|---|---|---|
| context_id | INT | IN | 否 | 被查询的游标id。 |
| query_string | TEXT | IN | 否 | 绑定的变量名。 |
| language_flag | ANYELEMENT | IN | 否 | 绑定的值。 |
| out_value_size | INT | IN | 是 | 返回值的大小，默认值为NULL。在兼容A模式下，仅当value参数值类型为VARCHAR或CHAR时，参数的行为与A数据库一致。 |

- DBE_SQL.SQL_BIND_VARIABLE该函数用于将一个参数绑定到SQL语句，当执行该SQL语句时，将根据该绑定的值来执行。 DBE_SQL.SQL_BIND_VARIABLE原型为：
```
DBE_SQL.SQL_BIND_ARRAY(
    context_id   IN int,
    query_string IN text,
    value        IN anyarray
)
RETURNS void;
DBE_SQL.SQL_BIND_ARRAY(
    context_id   IN int,
    query_string IN text,
    value        IN anyarray,
    lower_index  IN int,
    higher_index IN int
)
RETURNS void;
DBE_SQL.SQL_BIND_ARRAY(
    context_id   IN int,
    query_string IN text,
    value        IN anyindexbytable
)
RETURNS void;
DBE_SQL.SQL_BIND_ARRAY(
    context_id   IN int,
    query_string IN text,
    value        IN anyindexbytable,
    lower_index  IN int,
    higher_index IN int
)
RETURNS void;
```

| 参数名称 | 类型 | 入参/出参 | 是否可以为空 | 描述 |
|---|---|---|---|---|
| context_id | INT | IN | 否 | 被查询的游标id。 |
| query_string | TEXT | IN | 否 | 绑定的变量名。 |
| value | ANYINDEXBYTABLE | IN | 否 | 绑定的数组。 |
| lower_index | INT | IN | 否 | 绑定数组的最小下标。 |
| higher_index | INT | IN | 否 | 绑定数组的最大下标。 |

- DBE_SQL.SQL_BIND_ARRAY该函数用于将一组参数绑定到SQL语句，当执行该SQL语句时，会将根据该绑定的数组来执行。 DBE_SQL.SQL_BIND_ARRAY原型为： DBE_SQL.SQL_BIND_ARRAY不支持用户自定义的table类型，请使用数据类型介绍中提供的table类型。
```
DBE_SQL.SET_RESULT_TYPE_INTS(
    context_id IN int,
    pos        IN int,
    column_ref IN anyarray,
    cnt        IN int,
    lower_bnd  IN int
)
RETURNS integer;
```

| 参数名称 | 类型 | 入参/出参 | 是否可以为空 | 描述 |
|---|---|---|---|---|
| context_id | INT | IN | 否 | 被查询的游标id。 |
| pos | INT | IN | 否 | 动态定义列在查询中的位置。 |
| column_ref | ANYARRAY | IN | 否 | 标记返回的数组类型。 |
| cnt | INT | IN | 否 | 标记一次获取多少个值。 |
| lower_bnd | INT | IN | 否 | 标记返回数组时的开始下标。 |

- DBE_SQL.SET_RESULT_TYPE_INTS该函数用于定义从指定游标返回的INT数组类型的列。该接口只能应用于SELECT定义的游标。定义的列通过查询列表中的相对位置来标识，传入变量的数据类型决定了该列被定义的类型。 DBE_SQL.SET_RESULT_TYPE_INTS原型为：
```
DBE_SQL.SET_RESULT_TYPE_TEXTS(
    context_id IN int,
    pos        IN int,
    column_ref IN anyarray,
    cnt        IN int,
    lower_bnd  IN int,
    maxsize    IN int
)
RETURNS integer;
```

| 参数名称 | 类型 | 入参/出参 | 是否可以为空 | 描述 |
|---|---|---|---|---|
| context_id | INT | IN | 否 | 被查询的游标id。 |
| pos | INT | IN | 否 | 动态定义列在查询中的位置。 |
| column_ref | ANYARRAY | IN | 否 | 标记返回的数组类型。 |
| cnt | INT | IN | 否 | 标记一次获取多少个值。 |
| lower_bnd | INT | IN | 否 | 标记返回数组时的开始下标。 |
| maxsize | INT | IN | 否 | 定义的TEXT类型的最大长度。 |

- DBE_SQL.SET_RESULT_TYPE_TEXTS该函数用来定义从指定游标返回的TEXT数组类型的列。该接口只能应用于SELECT定义的游标。定义的列通过查询列表中的相对位置来标识，传入变量的数据类型决定了该列被定义的类型。 DBE_SQL.SET_RESULT_TYPE_TEXTS原型为：
```
DBE_SQL.set_result_type_raws(
    context_id  IN int,
    pos         IN int,
    column_ref  IN anyarray,
    cnt         IN int,
    lower_bnd   IN int,
    column_size IN int
)
RETURNS integer;
```

| 参数名称 | 类型 | 入参/出参 | 是否可以为空 | 描述 |
|---|---|---|---|---|
| context_id | INT | IN | 否 | 被查询的游标id。 |
| pos | INT | IN | 否 | 动态定义列在查询中的位置。 |
| column_ref | ANYARRAY | IN | 否 | 标记返回的数组类型。 |
| cnt | INT | IN | 否 | 标记一次获取多少个值。 |
| lower_bnd | INT | IN | 否 | 标记返回数组时的开始下标。 |
| column_size | INT | IN | 否 | 列的长度。 |

- DBE_SQL.SET_RESULT_TYPE_RAWS该函数用来定义从指定游标返回的RAW数组类型的列。该接口只能应用于SELECT定义的游标。定义的列通过查询列表中的相对位置来标识，传入变量的数据类型决定了该列被定义的类型。 DBE_SQL.SET_RESULT_TYPE_RAWS原型为：
```
DBE_SQL.set_result_type_byteas(
    context_id  IN int,
    pos         IN int,
    column_ref  IN anyarray,
    cnt         IN int,
    lower_bnd   IN int,
    column_size IN int
)
RETURNS integer;
```

| 参数名称 | 类型 | 入参/出参 | 是否可以为空 | 描述 |
|---|---|---|---|---|
| context_id | INT | IN | 否 | 被查询的游标id。 |
| pos | INT | IN | 否 | 动态定义列在查询中的位置。 |
| column_ref | ANYARRAY | IN | 否 | 标记返回的数组类型。 |
| cnt | INT | IN | 否 | 标记一次获取多少个值。 |
| lower_bnd | INT | IN | 否 | 标记返回数组时的开始下标。 |
| column_size | INT | IN | 否 | 列的长度。 |

- DBE_SQL.SET_RESULT_TYPE_BYTEAS该函数用来定义从指定游标返回的BYTEA数组类型的列。该接口只能应用于SELECT定义的游标。定义的列通过查询列表中的相对位置来标识，传入变量的数据类型决定了该列被定义的类型。 DBE_SQL.SET_RESULT_TYPE_BYTEAS原型为：
```
DBE_SQL.SET_RESULT_TYPE_CHARS(
    context_id  IN int,
    pos         IN int,
    column_ref  IN anyarray,
    cnt         IN int,
    lower_bnd   IN int,
    column_size IN int
)
RETURNS integer;
```

| 参数名称 | 类型 | 入参/出参 | 是否可以为空 | 描述 |
|---|---|---|---|---|
| context_id | INT | IN | 否 | 被查询的游标id。 |
| pos | INT | IN | 否 | 动态定义列在查询中的位置。 |
| column_ref | ANYARRAY | IN | 否 | 标记返回的数组类型。 |
| cnt | INT | IN | 否 | 标记一次获取多少个值。 |
| lower_bnd | INT | IN | 否 | 标记返回数组时的开始下标。 |
| column_size | INT | IN | 否 | 列的长度。 |

- DBE_SQL.SET_RESULT_TYPE_CHARS该函数用来定义从指定游标返回的CHAR数组类型的列。该接口只能应用于SELECT定义的游标。定义的列通过查询列表中的相对位置来标识，传入变量的数据类型决定了该列被定义的类型。 DBE_SQL.SET_RESULT_TYPE_CHARS原型为：
```
DBE_SQL.SET_RESULTS_TYPE(
    context_id IN int,
    pos        IN int,
    column_ref IN anyarray,
    cnt        IN int,
    lower_bnd  IN int,
    maxsize    IN int DEFAULT 1024
) returns void;
DBE_SQL.SET_RESULTS_TYPE(
    context_id IN int,
    pos        IN int,
    column_ref IN dbe_sql.number_table,
    cnt        IN int,
    lower_bnd  IN int,
    maxsize    IN int DEFAULT 1024
);
DBE_SQL.SET_RESULTS_TYPE(
    context_id IN int,
    pos        IN int,
    column_ref IN dbe_sql.varchar2_table,
    cnt        IN int,
    lower_bnd  IN int,
    maxsize    IN int DEFAULT 32767
);
DBE_SQL.SET_RESULTS_TYPE(
    context_id IN int,
    pos        IN int,
    column_ref IN dbe_sql.date_table,
    cnt        IN int,
    lower_bnd  IN int,
    maxsize    IN int DEFAULT 1024
);
DBE_SQL.SET_RESULTS_TYPE(
    context_id IN int,
    pos        IN int,
    column_ref IN dbe_sql.blob_table,
    cnt        IN int,
    lower_bnd  IN int,
    maxsize    IN int DEFAULT 32767
);
```

| 参数名称 | 类型 | 入参/出参 | 是否可以为空 | 描述 |
|---|---|---|---|---|
| context_id | INT | IN | 否 | 被查询的游标id。 |
| pos | INT | IN | 否 | 动态定义列在查询中的位置。 |
| column_ref | DBE_SQL.BLOB_TABLE | IN | 否 | 标记返回的数组类型。 |
| cnt | INT | IN | 否 | 标记一次获取多少个值。 |
| lower_bnd | INT | IN | 否 | 标记返回数组时的开始下标。 |
| maxsize | INT | IN | 是 | 定义的类型的最大长度。 |

- DBE_SQL.SET_RESULTS_TYPE该函数用来定义从指定游标返回的列。该接口只能应用于SELECT定义的游标。定义的列通过查询列表中的相对位置来标识，传入变量的数据类型决定了该列被定义的类型。 DBE_SQL.SET_RESULTS_TYPE原型为： DBE_SQL.SET_RESULTS_TYPE不支持用户自定义的table类型，请使用数据类型介绍中提供的table类型。
```
DBE_SQL.GET_RESULTS_INT(
    context_id   IN    int,
    pos          IN    int,
    column_value INOUT anyarray
);
```

| 参数名称 | 类型 | 入参/出参 | 是否可以为空 | 描述 |
|---|---|---|---|---|
| context_id | INT | IN | 否 | 被查询的游标id。 |
| pos | INT | IN | 否 | 动态定义列在查询中的位置。 |
| column_value | ANYARRAY | INOUT | 否 | 返回值。 |

- DBE_SQL.GET_RESULTS_INT该函数用来返回指定游标在给定位置的INT数组类型的值。该接口访问的是由DBE_SQL.NEXT_ROW获取的数据。 DBE_SQL.GET_RESULTS_INT原型为：
```
DBE_SQL.GET_RESULTS_TEXT(
    context_id   IN    int,
    pos          IN    int,
    column_value INOUT anyarray
);
```

| 参数名称 | 类型 | 入参/出参 | 是否可以为空 | 描述 |
|---|---|---|---|---|
| context_id | INT | IN | 否 | 被查询的游标id。 |
| pos | INT | IN | 否 | 动态定义列在查询中的位置。 |
| column_value | ANYARRAY | INOUT | 否 | 返回值。 |

- DBE_SQL.GET_RESULTS_TEXT该函数用来返回指定游标在给定位置的TEXT数组类型的值。该接口访问的是由DBE_SQL.NEXT_ROW获取的数据。 DBE_SQL.GET_RESULTS_TEXT原型为：
```
DBE_SQL.GET_RESULTS_RAW(
    context_id   IN    int,
    pos          IN    int,
    column_value INOUT anyarray
);
```

| 参数名称 | 类型 | 入参/出参 | 是否可以为空 | 描述 |
|---|---|---|---|---|
| context_id | INT | IN | 否 | 被查询的游标id。 |
| pos | INT | IN | 否 | 动态定义列在查询中的位置。 |
| column_value | ANYARRAY | INOUT | 否 | 返回值。 |

- DBE_SQL.GET_RESULTS_RAW该函数用来返回指定游标在给定位置的RAW数组类型的值。该接口访问的是由DBE_SQL.NEXT_ROW获取的数据。 DBE_SQL.GET_RESULTS_RAW原型为：
```
DBE_SQL.GET_RESULTS_BYTEA(
    context_id   IN    int,
    pos          IN    int,
    column_value INOUT anyarray
);
```

| 参数名称 | 类型 | 入参/出参 | 是否可以为空 | 描述 |
|---|---|---|---|---|
| context_id | INT | IN | 否 | 被查询的游标id。 |
| pos | INT | IN | 否 | 动态定义列在查询中的位置。 |
| column_value | ANYARRAY | INOUT | 否 | 返回值。 |

- DBE_SQL.GET_RESULTS_BYTEA该函数用来返回指定游标在给定位置的BYTEA数组类型的值。该接口访问的是由DBE_SQL.NEXT_ROW获取的数据。 DBE_SQL.GET_RESULTS_BYTEA原型为：
```
DBE_SQL.GET_RESULTS_CHAR(
    context_id   IN    int,
    pos          IN    int,
    column_value INOUT anyarray
);
```

| 参数名称 | 类型 | 入参/出参 | 是否可以为空 | 描述 |
|---|---|---|---|---|
| context_id | INT | IN | 否 | 被查询的游标id。 |
| pos | INT | IN | 否 | 动态定义列在查询中的位置。 |
| column_value | ANYARRAY | INOUT | 否 | 返回值。 |

- DBE_SQL.GET_RESULTS_CHAR该函数用来返回指定游标在给定位置的CHAR数组类型的值。该接口访问的是由DBE_SQL.NEXT_ROW获取的数据。 DBE_SQL.GET_RESULTS_CHAR原型为：
```
DBE_SQL.GET_RESULTS(
    context_id   IN    int,
    pos          IN    int,
    column_value INOUT anyarray
);
DBE_SQL.GET_RESULTS(
    context_id   IN    int,
    pos          IN    int,
    column_value INOUT dbe_sql.varchar2_table
);
DBE_SQL.GET_RESULTS(
    context_id   IN    int,
    pos          IN    int,
    column_value INOUT dbe_sql.number_table
);
DBE_SQL.GET_RESULTS(
    context_id   IN    int,
    pos          IN    int,
    column_value INOUT dbe_sql.date_table
);
DBE_SQL.GET_RESULTS(
    context_id   IN    int,
    pos          IN    int,
    column_value INOUT dbe_sql.blob_table
);
```

| 参数名称 | 类型 | 入参/出参 | 是否可以为空 | 描述 |
|---|---|---|---|---|
| context_id | INT | IN | 否 | 被查询的游标ID。 |
| pos | INT | IN | 否 | 动态定义列在查询中的位置。 |
| column_value | ANYARRAY | INOUT | 否 | 返回值。 |

- DBE_SQL.GET_RESULTS该函数用来返回指定游标在给定位置的数组类型的值。该接口访问的是由DBE_SQL.NEXT_ROW获取的数据。 由于DBE_SQL.GET_RESULTS的底层机制是通过数组实现的，当使用不同的数组获取同一列的返回值时，内部索引的不连续性会导致数组中填充NULL值，以确保数组索引的连续性。这将导致返回结果数组的长度和A数据库中的不一致。 DBE_SQL.GET_RESULTS原型为： DBE_SQL.GET_RESULTS不支持用户自定义的table类型，请使用数据类型介绍中提供的table类型。
```
DBE_SQL.SQL_DESCRIBE_COLUMNS(
    context_id IN    int,
    col_cnt    INOUT int,
    desc_t     INOUT dbe_sql.desc_tab
)RETURNS record ;
```

| 参数名称 | 类型 | 入参/出参 | 是否可以为空 | 描述 |
|---|---|---|---|---|
| context_id | INT | IN | 否 | 被查询的游标id。 |
| col_cnt | INT | INOUT | 否 | 返回的列的数量。 |
| desc_t | DBE_SQL.DESC_TAB | INOUT | 否 | 返回的列的描述信息。 |

- DBE_SQL.SQL_DESCRIBE_COLUMNS该函数用来描述列信息，该接口只能应用于SELECT定义的游标。 DBE_SQL.SQL_DESCRIBE_COLUMNS原型为：
```
DBE_SQL.DESCRIBE_COLUMNS(
    context_id IN  int,
    col_cnt    OUT int,
    desc_t     OUT dbe_sql.desc_tab
)
```

| 参数名称 | 类型 | 入参/出参 | 是否可以为空 | 描述 |
|---|---|---|---|---|
| context_id | INT | IN | 否 | 被查询的游标id。 |
| col_cnt | INT | OUT | 否 | 返回的列的数量。 |
| desc_t | DBE_SQL.DESC_TAB | OUT | 否 | 返回的列的描述信息。 |

- DBE_SQL.DESCRIBE_COLUMNS该函数用来描述列信息。该接口为兼容接口，只能应用于SELECT定义的游标。 DBE_SQL.DESCRIBE_COLUMNS原型为：
- DBE_SQL.BIND_VARIABLE该函数是绑定参数接口。建议使用DBE_SQL.SQL_BIND_VARIABLE。
```
DBE_SQL.sql_set_results_type_c(
    context_id IN int,
    pos        IN int,
    column_ref IN anyarray,
    cnt        IN int,
    lower_bnd  IN int,
    col_type   IN anyelement,
    maxsize    IN int
)return integer;
```

| 参数名称 | 类型 | 入参/出参 | 是否可以为空 | 描述 |
|---|---|---|---|---|
| context_id | INT | IN | 否 | 被查询的游标id。 |
| pos | INT | IN | 否 | 动态定义列在查询中的位置。 |
| column_ref | ANYARRAY | IN | 否 | 标记返回的数组类型。 |
| cnt | INT | IN | 否 | 标记一次获取多少个值。 |
| lower_bnd | INT | IN | 否 | 标记返回数组时的开始下标。 |
| col_type | ANYELEMENT | IN | 否 | 标记返回的数组类型对应的变量类型。 |
| maxsize | INT | IN | 否 | 定义的类型的最大长度。 |

- DBE_SQL.SQL_SET_RESULTS_TYPE_C该函数动态定义一个数组类型的列，不建议用户使用。 DBE_SQL.SQL_SET_RESULTS_TYPE_C原型为：
```
DBE_SQL.sql_get_values_c(
    context_id   IN    int,
    pos          IN    int,
    results_type INOUT anyarray,
    result_type  IN    anyelement
)return anyarray;
```

| 参数名称 | 类型 | 入参/出参 | 是否可以为空 | 描述 |
|---|---|---|---|---|
| context_id | INT | IN | 否 | 被查询的游标id。 |
| pos | INT | IN | 否 | 参数位置信息。 |
| results_type | ANYARRAY | INOUT | 否 | 获取的结果。 |
| result_type | ANYELEMENT | IN | 否 | 获取的结果类型。 |

- DBE_SQL.SQL_GET_VALUES_C该函数读取一个已动态定义的列值。不建议用户使用。 DBE_SQL.SQL_GET_VALUES_C原型为：
```
DBE_SQL.get_variable_result(
    context_id   IN    int,
    pos          IN    VARCHAR2,
    column_value INOUT anyelement
);
```

| 参数名称 | 类型 | 入参/出参 | 是否可以为空 | 描述 |
|---|---|---|---|---|
| context_id | INT | IN | 否 | 被查询的游标id。 |
| pos | VARCHAR2 | IN | 否 | 绑定的参数名。 |
| column_value | ANYELEMENT | INOUT | 否 | 返回值。 |

- DBE_SQL.GET_VARIABLE_RESULT该函数用来返回绑定的OUT参数的值，可以用于获取存储过程中的OUT参数。 DBE_SQL.GET_VARIABLE_RESULT原型为：
```
DBE_SQL.get_variable_result_char(
    context_id IN int,
    pos        IN VARCHAR2
)
RETURNS char
```

| 参数名称 | 类型 | 入参/出参 | 是否可以为空 | 描述 |
|---|---|---|---|---|
| context_id | INT | IN | 否 | 被查询的游标id。 |
| pos | VARCHAR2 | IN | 否 | 绑定的参数名。 |

- DBE_SQL.GET_VARIABLE_RESULT_CHAR该函数用于返回绑定的CHAR类型的OUT参数的值，可以用于获取存储过程中的OUT参数。 DBE_SQL.GET_VARIABLE_RESULT_CHAR原型为：
```
CREATE OR REPLACE FUNCTION DBE_SQL.get_variable_result_raw(
    context_id IN    int,
    pos        IN    VARCHAR2,
    value      INOUT anyelement
)
RETURNS anyelement
```

| 参数名称 | 类型 | 入参/出参 | 是否可以为空 | 描述 |
|---|---|---|---|---|
| context_id | INT | IN | 否 | 被查询的游标id。 |
| pos | VARCHAR2 | IN | 否 | 绑定的参数名。 |
| value | ANYELEMENT | INOUT | 否 | 返回值。 |

- DBE_SQL.GET_VARIABLE_RESULT_RAW该函数用于返回绑定的RAW类型的OUT参数的值，可以用于获取存储过程中的OUT参数。 DBE_SQL.GET_VARIABLE_RESULT_RAW原型为：
```
CREATE OR REPLACE FUNCTION DBE_SQL.get_variable_result_text(
    context_id IN int,
    pos        IN VARCHAR2
)
RETURNS text
```

| 参数名称 | 类型 | 入参/出参 | 是否可以为空 | 描述 |
|---|---|---|---|---|
| context_id | INT | IN | 否 | 被查询的游标id。 |
| pos | VARCHAR2 | IN | 否 | 绑定的参数名。 |

- DBE_SQL.GET_VARIABLE_RESULT_TEXT该函数用于返回绑定的TEXT类型的OUT参数的值，可以用于获取存储过程中的OUT参数。 DBE_SQL.GET_VARIABLE_RESULT_TEXT原型为：
```
DBE_SQL.get_variable_result_int(
    context_id IN    int,
    pos        IN    VARCHAR2,
    value      INOUT anyelement
)
RETURNS anyelement
```

| 参数名称 | 类型 | 入参/出参 | 是否可以为空 | 描述 |
|---|---|---|---|---|
| context_id | INT | IN | 否 | 被查询的游标id。 |
| pos | VARCHAR2 | IN | 否 | 绑定的参数名。 |
| value | ANYELEMENT | INOUT | 否 | 返回值。 |

- DBE_SQL.GET_VARIABLE_RESULT_INT该函数用于返回绑定的INT类型的OUT参数的值，可以用于获取存储过程中的OUT参数。 DBE_SQL.GET_VARIABLE_RESULT_INT原型为：
```
DBE_SQL.get_array_result_text(
    context_id   IN    int,
    pos          IN    VARCHAR2,
    column_value INOUT anyarray
)
```

| 参数名称 | 类型 | 入参/出参 | 是否可以为空 | 描述 |
|---|---|---|---|---|
| context_id | INT | IN | 否 | 被查询的游标id。 |
| pos | VARCHAR2 | IN | 否 | 绑定的参数名。 |
| column_value | ANYARRAY | INOUT | 否 | 返回值。 |

- DBE_SQL.GET_ARRAY_RESULT_TEXT该函数用于返回绑定的TEXT数组类型的OUT参数的值，可以用于获取存储过程中的OUT参数。 DBE_SQL.GET_ARRAY_RESULT_TEXT原型为：
```
DBE_SQL.get_array_result_raw(
    context_id   IN    int,
    pos          IN    VARCHAR2,
    column_value INOUT anyarray
)
```

| 参数名称 | 类型 | 入参/出参 | 是否可以为空 | 描述 |
|---|---|---|---|---|
| context_id | INT | IN | 否 | 被查询的游标id。 |
| pos | VARCHAR2 | IN | 否 | 绑定的参数名。 |
| column_value | ANYARRAY | INOUT | 否 | 返回值。 |

- DBE_SQL.GET_ARRAY_RESULT_RAW该函数用于返回绑定的RAW数组类型的OUT参数的值，可以用于获取存储过程中的OUT参数。 DBE_SQL.GET_ARRAY_RESULT_RAW原型为：
```
DBE_SQL.get_array_result_char(
    context_id   IN    int,
    pos          IN    VARCHAR2,
    column_value INOUT anyarray
)
```

| 参数名称 | 类型 | 入参/出参 | 是否可以为空 | 描述 |
|---|---|---|---|---|
| context_id | INT | IN | 否 | 被查询的游标id。 |
| pos | VARCHAR2 | IN | 否 | 绑定的参数名。 |
| column_value | ANYARRAY | INOUT | 否 | 返回值。 |

- DBE_SQL.GET_ARRAY_RESULT_CHAR该函数用于返回绑定的CHAR数组类型的OUT参数的值，可以用于获取存储过程中的OUT参数。 DBE_SQL.GET_ARRAY_RESULT_CHAR原型为：
```
DBE_SQL.get_array_result_int(
    context_id   IN    int,
    pos          IN    VARCHAR2,
    column_value INOUT anyarray
)
```

| 参数名称 | 类型 | 入参/出参 | 是否可以为空 | 描述 |
|---|---|---|---|---|
| context_id | INT | IN | 否 | 被查询的游标id。 |
| pos | VARCHAR2 | IN | 否 | 绑定的参数名。 |
| column_value | ANYARRAY | INOUT | 否 | 返回值。 |

- DBE_SQL.GET_ARRAY_RESULT_INT该函数用于返回绑定的INT数组类型的OUT参数的值，可以用于获取存储过程中的OUT参数。 DBE_SQL.GET_ARRAY_RESULT_INT原型为：
```
DBE_SQL.SQL_SET_TABLEOF_RESULTS_TYPE_C(
    context_id IN int,
    pos        IN int,
    column_ref IN anyindexbytable,
    cnt        IN int,
    lower_bnd  IN int,
    col_type   IN anyelement,
    maxsize    IN int
)return integer;
```

| 参数名称 | 类型 | 入参/出参 | 是否可以为空 | 描述 |
|---|---|---|---|---|
| context_id | INT | IN | 否 | 被查询的游标id。 |
| pos | INT | IN | 否 | 动态定义列在查询中的位置。 |
| column_ref | ANYINDEXBYTABLE | IN | 否 | 标记返回的数组类型。 |
| cnt | INT | IN | 否 | 标记一次获取多少个值。 |
| lower_bnd | INT | IN | 否 | 标记返回数组时的开始下标。 |
| col_type | ANYELEMENT | IN | 否 | 标记返回的数组类型对应的变量类型。 |
| maxsize | INT | IN | 否 | 定义的类型的最大长度。 |

- DBE_SQL.SQL_SET_TABLEOF_RESULTS_TYPE_C该函数动态定义一个tableof类型的列。不建议用户使用。 DBE_SQL.SQL_SET_TABLEOF_RESULTS_TYPE_C原型为：
```
DBE_SQL.SQL_GET_TABLEOF_VALUES_C(
    context_id   IN    int,
    pos          IN    int,
    results_type INOUT anyindexbytable,
    result_type  IN    anyelement
)return anyindexbytable;
```

| 参数名称 | 类型 | 入参/出参 | 是否可以为空 | 描述 |
|---|---|---|---|---|
| context_id | INT | IN | 否 | 被查询的游标id。 |
| pos | INT | IN | 否 | 参数位置信息。 |
| results_type | ANYINDEXBYTABLE | INOUT | 否 | 获取的结果。 |
| result_type | ANYELEMENT | IN | 否 | 获取的结果类型。 |

- DBE_SQL.SQL_GET_TABLEOF_VALUES_C该函数读取一个已动态定义的tableof类型的列值。不建议用户使用。 DBE_SQL.SQL_GET_TABLEOF_VALUES_C原型为：
#### 示例
```
-- 示例1
-- 创建表并插入数据
gaussdb=# CREATE TABLE test_desc_cols(
    id NUMBER,
    name VARCHAR2(50)
);
CREATE TABLE
gaussdb=# INSERT INTO test_desc_cols(id, name) VALUES (1, 'xiaoming');
INSERT 0 1
gaussdb=# INSERT INTO test_desc_cols(id, name) VALUES (2, 'xiaohong');
INSERT 0 1
gaussdb=# INSERT INTO test_desc_cols(id, name) VALUES (3, 'xiaolan');
INSERT 0 1
gaussdb=# DECLARE
context_id  INTEGER;
col_cnt     INTEGER;
v_id int;
v_name varchar2;
execute_ret  INTEGER;
BEGIN
-- 打开游标
context_id := DBE_SQL.REGISTER_CONTEXT();
-- 编译游标
DBE_SQL.SQL_SET_SQL(context_id, 'SELECT * FROM test_desc_cols', 2);
-- 设置列返回值的类型
DBE_SQL.SET_RESULT_TYPE(context_id, 1, v_id);
DBE_SQL.SET_RESULT_TYPE(context_id, 2, v_name);
execute_ret := DBE_SQL.SQL_RUN(context_id);
loop
exit when (DBE_SQL.NEXT_ROW(context_id) <= 0);
--获取值
DBE_SQL.GET_RESULT(context_id, 1, v_id);
DBE_SQL.GET_RESULT(context_id, 2, v_name);
--输出结果
dbe_output.print_line('id:'|| v_id || ' name:' || v_name);
end loop;
DBE_SQL.SQL_UNREGISTER_CONTEXT(context_id);
END;
/
id:1 name:xiaoming
id:2 name:xiaohong
id:3 name:xiaolan
ANONYMOUS BLOCK EXECUTE
-- 清理环境
gaussdb=# drop table if exists test_desc_cols;
DROP TABLE
-- 示例2
gaussdb=# CREATE OR REPLACE PROCEDURE test_square(n NUMBER, square OUT NUMBER) IS
BEGIN
  square := n * n;
END;
/
CREATE PROCEDURE
gaussdb=# DECLARE
cur NUMBER;
query varchar(2000);
ret integer;
n NUMBER;
square Integer;
BEGIN
  n := 2;
  cur := DBE_SQL.REGISTER_CONTEXT();
  query := 'BEGIN test_square(:n_bnd, :square_bnd); END;';
  DBE_SQL.SQL_SET_SQL(cur, query, 2);
  DBE_SQL.SQL_BIND_VARIABLE(cur, 'n_bnd', n);
  DBE_SQL.SQL_BIND_VARIABLE(cur, 'square_bnd', square);
  ret := DBE_SQL.SQL_RUN(cur);
  DBE_SQL.GET_VARIABLE_RESULT(cur, 'square_bnd', square);
  DBE_OUTPUT.PRINT_LINE('square = ' || square);
  DBE_SQL.SQL_UNREGISTER_CONTEXT(cur);
END;
/
square = 4
ANONYMOUS BLOCK EXECUTE
-- 清理环境
gaussdb=# drop PROCEDURE test_square;
DROP PROCEDURE
-- 示例3
-- DESCRIBE_COLUMNS、RUN_AND_NEXT和LAST_ROW_COUNT接口示例
-- 创建表并插入数据
gaussdb=# CREATE TABLE test_desc_cols(
    id NUMBER,
    name VARCHAR2(50)
);
CREATE TABLE
gaussdb=# INSERT INTO test_desc_cols(id, name) VALUES (1, 'xiaoming');
INSERT 0 1
gaussdb=# INSERT INTO test_desc_cols(id, name) VALUES (2, 'xiaohong');
INSERT 0 1
gaussdb=# INSERT INTO test_desc_cols(id, name) VALUES (3, 'xiaolan');
INSERT 0 1
-- 创建列描述信息打印存储过程
gaussdb=# CREATE OR REPLACE PROCEDURE print_rec(
    rec in DBE_SQL.DESC_REC
)package AS
BEGIN
    raise INFO 'col_type            =    %', rec.col_type;
    raise INFO 'col_name            =    %', rec.col_name;
    raise INFO 'col_name_len        =    %', rec.col_name_len;
END;
/
CREATE PROCEDURE
-- 进行功能验证
gaussdb=# DECLARE
context_id  INTEGER;
col_cnt     INTEGER;
rec_tab     DBE_SQL.DESC_TAB;
execute_ret  INTEGER;
nextrow_ret INTEGER;
last_row_count INTEGER;
BEGIN
-- 打开游标
context_id := DBE_SQL.REGISTER_CONTEXT();
-- 编译游标
DBE_SQL.SQL_SET_SQL(context_id, 'SELECT * FROM test_desc_cols', 2);
-- 进行列描述和信息打印
DBE_SQL.DESCRIBE_COLUMNS(context_id, col_cnt, rec_tab);
FOR var IN 1..col_cnt LOOP
    print_rec(rec_tab(var));
END LOOP;
-- 执行并获取一行数据
execute_ret := DBE_SQL.RUN_AND_NEXT(context_id);
-- 获取一行数据
nextrow_ret := DBE_SQL.NEXT_ROW(context_id);
-- 得到目前已经获取的数据行数
last_row_count := DBE_SQL.LAST_ROW_COUNT;
DBE_OUTPUT.PRINT_LINE('last_row_count =  '|| last_row_count);
DBE_SQL.SQL_UNREGISTER_CONTEXT(context_id);
END;
/
INFO:  col_type            =    1700
CONTEXT:  SQL statement "CALL print_rec(rec_tab[var])"
PL/pgSQL function inline_code_block line 16 at PERFORM
INFO:  col_name            =    id
CONTEXT:  SQL statement "CALL print_rec(rec_tab[var])"
PL/pgSQL function inline_code_block line 16 at PERFORM
INFO:  col_name_len        =    2
CONTEXT:  SQL statement "CALL print_rec(rec_tab[var])"
PL/pgSQL function inline_code_block line 16 at PERFORM
INFO:  col_type            =    1043
CONTEXT:  SQL statement "CALL print_rec(rec_tab[var])"
PL/pgSQL function inline_code_block line 16 at PERFORM
INFO:  col_name            =    name
CONTEXT:  SQL statement "CALL print_rec(rec_tab[var])"
PL/pgSQL function inline_code_block line 16 at PERFORM
INFO:  col_name_len        =    4
CONTEXT:  SQL statement "CALL print_rec(rec_tab[var])"
PL/pgSQL function inline_code_block line 16 at PERFORM
last_row_count =  2
ANONYMOUS BLOCK EXECUTE
-- 清理环境
gaussdb=# drop table test_desc_cols;
DROP TABLE
-- 示例4
gaussdb=# DROP TABLE if exists dbe_sql_tab;
NOTICE:  table "dbe_sql_tab" does not exist, skipping
DROP TABLE
gaussdb=# create table dbe_sql_tab(a char(30), b int, c text, d raw, e bytea, f text, g bool);
CREATE TABLE
gaussdb=# insert into dbe_sql_tab values('aaa', 10, 'abcdefghijklmn', HEXTORAW('DEADBEEF'), 'a', 'abcdefghijklmn', true);
INSERT 0 1
gaussdb=# DECLARE
cursorid int;
execute_ret int;
query varchar(2000);
err numeric;
v_char char(30);
v_int int;
v_long text;
v_long_len int;
v_raw raw;
v_raw_len int;
v_bytea bytea;
v_text text;
BEGIN
query := 'select * from dbe_sql_tab';
cursorid := DBE_SQL.register_context();
DBE_SQL.sql_set_sql(cursorid, query, 1);
DBE_SQL.SET_RESULT_TYPE_CHAR(cursorid, 1, v_char, 30);
DBE_SQL.SET_RESULT_TYPE_INT(cursorid, 2);
DBE_SQL.SET_RESULT_TYPE_LONG(cursorid, 3);
DBE_SQL.SET_RESULT_TYPE_RAW(cursorid, 4, v_raw, 68);
DBE_SQL.SET_RESULT_TYPE_BYTEA(cursorid, 5, v_bytea, 68);
DBE_SQL.SET_RESULT_TYPE_TEXT(cursorid, 6, 1024);
execute_ret := DBE_SQL.sql_run(cursorid);
loop
exit when (DBE_SQL.next_row(cursorid) <= 0);
DBE_SQL.GET_RESULT_CHAR(cursorid, 1, v_char);
v_int := DBE_SQL.GET_RESULT_INT(cursorid, 2);
DBE_SQL.GET_RESULT_LONG(cursorid, 3, 3, 3, v_long, v_long_len);
DBE_SQL.GET_RESULT_RAW(cursorid, 4, v_raw, err, v_raw_len);
v_bytea := DBE_SQL.GET_RESULT_BYTEA(cursorid, 5);
v_text := DBE_SQL.GET_RESULT_TEXT(cursorid, 6);
dbe_output.print_line('a:'|| v_char);
dbe_output.print_line('b:'|| v_int);
dbe_output.print_line('c:'|| v_long);
dbe_output.print_line('d:'|| v_raw);
raise info 'e:%', v_bytea;
dbe_output.print_line('f:'|| v_text);
end loop;
DBE_SQL.sql_unregister_context(cursorid);
END;
/
a:aaa
b:10
c:cde
d:DEADBEEF
INFO:  e:\x61
f:abcdefghijklmn
ANONYMOUS BLOCK EXECUTE
gaussdb=# DECLARE
cursorid int;
execute_ret int;
query varchar(2000);
BEGIN
query := 'select * from dbe_sql_tab';
cursorid := DBE_SQL.register_context();
DBE_SQL.sql_set_sql(cursorid, query, 1);
DBE_SQL.SET_RESULT_TYPE_UNKNOWN(cursorid, 7, 'boolean');
execute_ret := DBE_SQL.sql_run(cursorid);
loop
exit when (DBE_SQL.next_row(cursorid) <= 0);
DBE_SQL.GET_RESULT_UNKNOWN(cursorid, 7, 'boolean');
end loop;
DBE_SQL.sql_unregister_context(cursorid);
END;
/
ERROR:  UnSupport data type for set_result_type(context: 8, pos: 7, 'boolean')
CONTEXT:  SQL statement "CALL pg_catalog.report_application_error('UnSupport data type for set_result_type(context: '||context_id||', pos: '||pos||', '||PG_CATALOG.QUOTE_LITERAL(col_type)||')')"
PL/pgSQL function dbe_sql.set_result_type_unknown(integer,integer,text) line 8 at PERFORM
SQL statement "CALL dbe_sql.set_result_type_unknown(cursorid,7,'boolean')"
PL/pgSQL function inline_code_block line 10 at PERFORM
-- 清理环境
gaussdb=# drop table dbe_sql_tab;
DROP TABLE
-- 示例5
gaussdb=# DROP TABLE if exists dbe_sql_tab;
NOTICE:  table "dbe_sql_tab" does not exist, skipping
DROP TABLE
gaussdb=# create table dbe_sql_tab(a char(30), b raw);
CREATE TABLE
gaussdb=# insert into dbe_sql_tab values('aaa', HEXTORAW('DEADBEEF'));
INSERT 0 1
gaussdb=# DECLARE
cursorid int;
execute_ret int;
query varchar(2000);
v_char char(30);
v_raw raw;
BEGIN
query := 'select * from dbe_sql_tab';
cursorid := DBE_SQL.register_context();
DBE_SQL.sql_set_sql(cursorid, query, 2);
DBE_SQL.SET_RESULT_TYPE(cursorid, 1, v_char);
DBE_SQL.SET_RESULT_TYPE_RAW(cursorid, 2, v_raw, 68);
execute_ret := DBE_SQL.sql_run(cursorid);
loop
exit when (DBE_SQL.next_row(cursorid) <= 0);
v_char := DBE_SQL.DBE_SQL_GET_RESULT_CHAR(cursorid, 1);
v_raw := DBE_SQL.DBE_SQL_GET_RESULT_RAW(cursorid, 2);
dbe_output.print_line('a:'|| v_char);
dbe_output.print_line('b:'|| v_raw);
end loop;
DBE_SQL.sql_unregister_context(cursorid);
END;
/
a:aaa
b:DEADBEEF
ANONYMOUS BLOCK EXECUTE
-- 清理环境
gaussdb=# drop table dbe_sql_tab;
DROP TABLE
-- 示例6
gaussdb=# DECLARE
cursorid int;
execute_ret int;
is_open boolean;
BEGIN
cursorid := DBE_SQL.register_context();
is_open := DBE_SQL.IS_ACTIVE(cursorid);
dbe_output.print_line('is_open:' ||is_open);
DBE_SQL.sql_unregister_context(cursorid);
is_open := DBE_SQL.IS_ACTIVE(cursorid);
dbe_output.print_line('is_open:' ||is_open);
END;
/
is_open:true
is_open:false
ANONYMOUS BLOCK EXECUTE
-- 示例7
gaussdb=# create table tbl(a integer ,b varchar(100));
CREATE TABLE
gaussdb=# DECLARE
c integer;
v1 integer[];
v2 varchar2[];
query varchar(2000);
ret integer;
begin
c := dbe_sql.register_context();
query := 'insert into tbl(a,b) values(:v_1, :v_2);';
dbe_sql.sql_set_sql(c, query, 2);
v1(1) := 1;
v1(2) := 2;
v2(1) := '1';
v2(2) := '2';
dbe_sql.sql_bind_array(c, 'v_1', v1);
dbe_sql.sql_bind_array(c, 'v_2', v2);
ret := dbe_sql.sql_run(c);
dbe_sql.sql_unregister_context(c);
end;
/
ANONYMOUS BLOCK EXECUTE
gaussdb=# select * from tbl order by a;
 a | b
---+---
 1 | 1
 2 | 2
(2 rows)
-- 清理环境
gaussdb=# drop table tbl;
DROP TABLE
-- 示例8
-- 前置条件
gaussdb=# DROP TABLE if exists dbe_sql_tab;
NOTICE:  table "dbe_sql_tab" does not exist, skipping
DROP TABLE
gaussdb=# create table dbe_sql_tab(a int, b text, c raw, d text, e char, f int);
CREATE TABLE
gaussdb=# insert into dbe_sql_tab values(1, '9', '5', '13', 'a', 1);
INSERT 0 1
gaussdb=# insert into dbe_sql_tab values(2, '9', '6', '14', 'b', 2);
INSERT 0 1
gaussdb=# insert into dbe_sql_tab values(3, '7', '7', '15', 'c', 3);
INSERT 0 1
gaussdb=# insert into dbe_sql_tab values(4, '6', '8', '16', 'd', 4);
INSERT 0 1
gaussdb=# DECLARE
query varchar(2000);
context_id int;
execute_ret int;
v_id int;
v_ints int[];
v_texts text[];
v_raws raw[];
v_byteas bytea[];
v_chars character[];
v_type int[];
BEGIN
query := ' select * from dbe_sql_tab';
context_id := dbe_sql.register_context();
dbe_sql.sql_set_sql(context_id, query, 1);
DBE_SQL.SET_RESULT_TYPE_INTS(context_id, 1, v_ints, 3, 1);
DBE_SQL.SET_RESULT_TYPE_TEXTS(context_id, 2, v_texts, 3, 1, 1024);
DBE_SQL.SET_RESULT_TYPE_RAWS(context_id, 3, v_raws, 3, 1, 1024);
DBE_SQL.SET_RESULT_TYPE_BYTEAS(context_id, 4, v_byteas, 3, 1, 1024);
DBE_SQL.SET_RESULT_TYPE_CHARS(context_id, 5, v_chars, 3, 1, 1024);
DBE_SQL.SET_RESULTS_TYPE(context_id, 6, v_type, 3, 1);
execute_ret := dbe_sql.sql_run(context_id);
loop
v_id := dbe_sql.next_row(context_id);
v_ints := DBE_SQL.GET_RESULTS_INT(context_id, 1, v_ints);
v_texts := DBE_SQL.GET_RESULTS_TEXT(context_id, 2, v_texts);
v_raws := DBE_SQL.GET_RESULTS_RAW(context_id, 3, v_raws);
v_byteas := DBE_SQL.GET_RESULTS_BYTEA(context_id, 4, v_byteas);
v_chars := DBE_SQL.GET_RESULTS_CHAR(context_id, 5, v_chars);
v_type := DBE_SQL.GET_RESULTS(context_id, 6, v_type);
exit when(v_id != 3);
end loop;
FOR i IN v_ints.FIRST .. v_ints.LAST  LOOP
	    dbe_output.print_line('int' || i || ' = ' || v_ints[i]);
END LOOP;
FOR i IN v_texts.FIRST .. v_texts.LAST  LOOP
	    dbe_output.print_line('text' || i || ' = ' || v_texts[i]);
END LOOP;
FOR i IN v_raws.FIRST .. v_raws.LAST  LOOP
	    dbe_output.print_line('raw' || i || ' = ' || v_raws[i]);
END LOOP;
FOR i IN v_byteas.FIRST .. v_byteas.LAST  LOOP
	    dbe_output.print_line('bytea' || i || ' = ' || v_byteas[i]);
END LOOP;
FOR i IN v_chars.FIRST .. v_chars.LAST  LOOP
	    dbe_output.print_line('char' || i || ' = ' || v_chars[i]);
END LOOP;
FOR i IN v_type.FIRST .. v_type.LAST  LOOP
	    dbe_output.print_line('type' || i || ' = ' || v_type[i]);
END LOOP;
dbe_sql.sql_unregister_context(context_id);
END;
/
int1 = 1
int2 = 2
int3 = 3
int4 = 4
text1 = 9
text2 = 9
text3 = 7
text4 = 6
raw1 = 05
raw2 = 06
raw3 = 07
raw4 = 08
bytea1 = \x3133
bytea2 = \x3134
bytea3 = \x3135
bytea4 = \x3136
char1 = a
char2 = b
char3 = c
char4 = d
type1 = 1
type2 = 2
type3 = 3
type4 = 4
ANONYMOUS BLOCK EXECUTE
-- 清理环境
gaussdb=# drop table if exists dbe_sql_tab;
DROP TABLE
-- 示例9
-- 前置条件
gaussdb=# DROP TABLE if exists dbe_sql_tab;
NOTICE:  table "dbe_sql_tab" does not exist, skipping
DROP TABLE
gaussdb=# create table dbe_sql_tab(a int ,b int);
CREATE TABLE
gaussdb=# insert into dbe_sql_tab values(1,3);
INSERT 0 1
gaussdb=# DECLARE
context_id int;
type re_rssc is record (col_num int, desc_col dbe_sql.desc_tab);
employer re_rssc;
res re_rssc;
d int;
dd dbe_sql.desc_tab;
query varchar(2000);
BEGIN
query := 'select * from dbe_sql_tab';
--打开游标
context_id := dbe_sql.register_context();
--编译游标
dbe_sql.sql_set_sql(context_id, query, 1);
--执行
res := dbe_sql.sql_describe_columns(context_id, d,dd);
--输出结果
dbe_output.print_line('col_num:' || res.col_num);
dbe_output.print_line('col_type:' || res.desc_col[1].col_type);
dbe_output.print_line('col_max_len:' || res.desc_col[1].col_max_len);
dbe_output.print_line('col_name:' || res.desc_col[1].col_name);
dbe_output.print_line('col_name_len:' || res.desc_col[1].col_name_len);
dbe_output.print_line('col_schema_name:' || res.desc_col[1].col_schema_name);
dbe_output.print_line('col_schema_name_len:' || res.desc_col[1].col_schema_name_len);
dbe_output.print_line('col_precision:' || res.desc_col[1].col_precision);
dbe_output.print_line('col_scale:' || res.desc_col[1].col_scale);
dbe_output.print_line('col_charsetid:' || res.desc_col[1].col_charsetid);
dbe_output.print_line('col_charsetform:' || res.desc_col[1].col_charsetform);
dbe_output.print_line('col_null_ok:' || res.desc_col[1].col_null_ok);
--关闭游标
dbe_sql.sql_unregister_context(context_id);
END;
/
col_num:2
col_type:23
col_max_len:4
col_name:a
col_name_len:1
col_schema_name:
col_schema_name_len:0
col_precision:0
col_scale:0
col_charsetid:0
col_charsetform:0
col_null_ok:true
ANONYMOUS BLOCK EXECUTE
-- 清理环境
gaussdb=# drop table if exists dbe_sql_tab;
DROP TABLE
-- 示例10
gaussdb=# DROP TABLE if exists dbe_sql_tab;
NOTICE:  table "dbe_sql_tab" does not exist, skipping
DROP TABLE
gaussdb=# create table dbe_sql_tab(a int);
CREATE TABLE
gaussdb=# insert into dbe_sql_tab values(1);
INSERT 0 1
gaussdb=# insert into dbe_sql_tab values(2);
INSERT 0 1
gaussdb=# insert into dbe_sql_tab values(3);
INSERT 0 1
gaussdb=# DECLARE
query varchar(2000);
context_id int;
execute_ret int;
v_id int;
v_ints int[];
i1 integer;
BEGIN
query := 'select * from dbe_sql_tab';
context_id := dbe_sql.register_context();
dbe_sql.sql_set_sql(context_id, query, 1);
DBE_SQL.SQL_SET_RESULTS_TYPE_C(context_id, 1, v_ints, 3, 1, i1, 0);
execute_ret := dbe_sql.sql_run(context_id);
loop
v_id := dbe_sql.next_row(context_id);
v_ints := DBE_SQL.SQL_GET_VALUES_C(context_id, 1, v_ints, i1);
exit when(v_id != 3);
end loop;
FOR i IN v_ints.FIRST .. v_ints.LAST  LOOP
        dbe_output.print_line('int' || i || ' = ' || v_ints[i]);
END LOOP;
dbe_sql.sql_unregister_context(context_id);
END;
/
int1 = 1
int2 = 2
int3 = 3
ANONYMOUS BLOCK EXECUTE
-- 清理环境
gaussdb=# drop table if exists dbe_sql_tab;
DROP TABLE
-- 示例11
gaussdb=# CREATE OR REPLACE PROCEDURE test_proc(out_int out Integer, out_char out char, out_raw out raw, out_text out text) IS
BEGIN
  out_int := 1;
  out_char := 'a';
  out_raw := 'b';
  out_text := 'c';
END;
/
CREATE PROCEDURE
gaussdb=# DECLARE
cur NUMBER;
query varchar(2000);
ret integer;
v_int Integer;
v_char char;
v_raw raw;
v_text text;
BEGIN
  cur := DBE_SQL.REGISTER_CONTEXT();
  query := 'BEGIN test_proc(:v_int, :v_char, :v_raw, :v_text); END;';
  DBE_SQL.SQL_SET_SQL(cur, query, 2);
  DBE_SQL.SQL_BIND_VARIABLE(cur, 'v_int', v_int);
  DBE_SQL.SQL_BIND_VARIABLE(cur, 'v_char', v_char, 1024);
  DBE_SQL.SQL_BIND_VARIABLE(cur, 'v_raw', v_raw, 1024);
  DBE_SQL.SQL_BIND_VARIABLE(cur, 'v_text', v_text, 1024);
  ret := DBE_SQL.SQL_RUN(cur);
  DBE_SQL.GET_VARIABLE_RESULT_INT(cur, 'v_int', v_int);
  v_char := DBE_SQL.GET_VARIABLE_RESULT_CHAR(cur, 'v_char');
  DBE_SQL.GET_VARIABLE_RESULT_RAW(cur, 'v_raw', v_raw);
  v_text := DBE_SQL.GET_VARIABLE_RESULT_TEXT(cur, 'v_text');
  DBE_OUTPUT.PRINT_LINE('v_int = ' || v_int);
  DBE_OUTPUT.PRINT_LINE('v_char = ' || v_char);
  DBE_OUTPUT.PRINT_LINE('v_raw = ' || v_raw);
  DBE_OUTPUT.PRINT_LINE('v_text = ' || v_text);
  DBE_SQL.SQL_UNREGISTER_CONTEXT(cur);
END;
/
v_int = 1
v_char = a
v_raw = 0B
v_text = c
ANONYMOUS BLOCK EXECUTE
-- 清理环境
gaussdb=# drop procedure test_proc;
DROP PROCEDURE
-- 示例12（当设置GUC参数behavior_compat_options='proc_outparam_override'后，不支持该用例运行，请确保proc_outparam_override已关闭。）
gaussdb=# CREATE OR REPLACE PROCEDURE test_proc(out_int out Integer[], out_char out char[], out_raw out raw[], out_text out text[]) IS
BEGIN
  out_int(0) := 1;
  out_char(0) := 'a';
  out_raw(0) := 'b';
  out_text(0) := 'c';
END;
/
CREATE PROCEDURE
gaussdb=# DECLARE
cur NUMBER;
query varchar(2000);
ret integer;
v_int Integer[];
v_char char[];
v_raw raw[];
v_text text[];
BEGIN
  cur := DBE_SQL.REGISTER_CONTEXT();
  query := 'call test_proc(:v_int, :v_char, :v_raw, :v_text);';
  DBE_SQL.SQL_SET_SQL(cur, query, 1);
  DBE_SQL.SQL_BIND_ARRAY(cur, 'v_int', v_int);
  DBE_SQL.SQL_BIND_ARRAY(cur, 'v_char', v_char);
  DBE_SQL.SQL_BIND_ARRAY(cur, 'v_raw', v_raw);
  DBE_SQL.SQL_BIND_ARRAY(cur, 'v_text', v_text);
  ret := DBE_SQL.SQL_RUN(cur);
  DBE_SQL.GET_ARRAY_RESULT_INT(cur, 'v_int', v_int);
  DBE_SQL.GET_ARRAY_RESULT_CHAR(cur, 'v_char', v_char);
  DBE_SQL.GET_ARRAY_RESULT_RAW(cur, 'v_raw', v_raw);
  DBE_SQL.GET_ARRAY_RESULT_TEXT(cur, 'v_text', v_text);
  DBE_OUTPUT.PRINT_LINE('v_int = ' || v_int(0));
  DBE_OUTPUT.PRINT_LINE('v_char = ' || v_char(0));
  DBE_OUTPUT.PRINT_LINE('v_raw = ' || v_raw(0));
  DBE_OUTPUT.PRINT_LINE('v_text = ' || v_text(0));
  DBE_SQL.SQL_UNREGISTER_CONTEXT(cur);
END;
/
v_int = 1
v_char = a
v_raw = 0B
v_text = c
ANONYMOUS BLOCK EXECUTE
-- 清理环境
gaussdb=# drop PROCEDURE test_proc;
DROP PROCEDURE
```
父主题：
二次封装接口
版权所有 © 华为技术有限公司
< 上一节
下一节 >



---


---

## DBE_DESCRIBE

#### 数据类型介绍
高级包DBE_DESCRIBE内置了两个数据类型，这两个数据类型使用自定义类型创建，用于DESCRIBE_PROCEDURE接口的返回值。
```
CREATE TYPE DBE_DESCRIBE.NUMBER_TABLE AS TABLE OF NUMBER INDEX BY INTEGER;
```
- DBE_DESCRIBE.NUMBER_TABLE该类型是NUMBER的TABLE类型，通过TABLE OF语法实现。 DBE_DESCRIBE.NUMBER_TABLE原型为：
```
CREATE TYPE DBE_DESCRIBE.VARCHAR2_TABLE AS TABLE OF VARCHAR2(30) INDEX BY INTEGER;
```
- DBE_DESCRIBE.VARCHAR2_TABLE该类型是VARCHAR2的TABLE类型，通过TABLE OF语法实现。 DBE_DESCRIBE.VARCHAR2_TABLE原型为：
#### 接口介绍
高级包DBE_DESCRIBE提供了接口DBE_DESCRIBE.DESCRIBE_PROCEDURE，接口描述请参见表1。

| 接口名称 | 描述 |
|---|---|
| DBE_DESCRIBE.DESCRIBE_PROCEDURE | 用来显示存储过程或函数的参数信息。 |

```
DBE_DESCRIBE.DESCRIBE_PROCEDURE(
  object_name                IN  VARCHAR2,
  reserved1                  IN  VARCHAR2,
  reserved2                  IN  VARCHAR2,
  overload                   OUT DBE_DESCRIBE.NUMBER_TABLE,
  dataposition               OUT DBE_DESCRIBE.NUMBER_TABLE,
  datalevel                  OUT DBE_DESCRIBE.NUMBER_TABLE,
  argument_name              OUT DBE_DESCRIBE.VARCHAR2_TABLE,
  datatype                   OUT DBE_DESCRIBE.NUMBER_TABLE,
  default_value              OUT DBE_DESCRIBE.NUMBER_TABLE,
  in_out                     OUT DBE_DESCRIBE.NUMBER_TABLE,
  datalength                 OUT DBE_DESCRIBE.NUMBER_TABLE,
  dataprecision              OUT DBE_DESCRIBE.NUMBER_TABLE,
  scale                      OUT DBE_DESCRIBE.NUMBER_TABLE,
  radix                      OUT DBE_DESCRIBE.NUMBER_TABLE,
  spare                      OUT DBE_DESCRIBE.NUMBER_TABLE,
  include_string_constraints OUT BOOLEAN
);
```

| 参数 | 类型 | 是否允许为空 | 描述 |
|---|---|---|---|
| object_name | varchar2 | 否 | 存储过程的名称。此参数的语法格式为[[schema.]package.]function[@dblink]，其中： schema：可选，模式名称。package：可选，包名称。function：不能为空，函数或存储过程名称。dblink：可选，远程连接名称。 |
| reserved1 | varchar2 | 是 | 预留参数。 |
| reserved2 | varchar2 | 是 | 预留参数。 |
| overload | number_table | 是 | 分配给存储过程/函数的唯一编号。 如果存储过程/函数存在重载，则overload为该存储过程/函数的每个重载，以整个存储过程/函数为粒度，对overload从1开始递增编号。如果存储过程/函数不存在重载，则overload置0。 |
| dataposition | number_table | 是 | 表示指定参数在参数列表中的位置。 |
| datalevel | number_table | 是 | 置0。 |
| argument_name | varchar2_table | 是 | 与指定的存储过程相关联的参数名称。 |
| datatype | number_table | 是 | 被指定参数的数据类型OID。 |
| default_value | number_table | 是 | 如果被指定的参数有一个默认值，则值为 1；否则，值为 0。 |
| in_out | number_table | 是 | 指定参数的模式。 其中参数模式有： 0：IN。1：OUT。2：IN OUT。 |
| datalength | number_table | 是 | 暂不支持，默认置0。 |
| dataprecision | number_table | 是 | 暂不支持，默认置0。 |
| scale | number_table | 是 | 暂不支持，默认置0。 |
| radix | number_table | 是 | 若为数值类型（如NUMBER、INTEGER等），返回10，否则置0；数值类型请参阅数值类型。 |
| spare | number_table | 是 | 预留参数，默认置0。 |
| include_string_constraints | boolean | 是 | 预留参数，默认置FALSE。 |

  - datatype参数与A模式数据库的数据类型存在差异。GaussDB返回数据类型的OID，A模式数据库返回A模式数据库内部的数据类型编号。
  - 参数include_string_constraints作为预留参数，本身的值不会发生变化，也不会影响其它参数的返回值。
  - 使用CREATE TYPE操作创建的数据类型，由于这些数据类型的OID是不确定的，所以请勿将这些OID用于固定判断等。
  - 对于dataposition参数，如果指定的是存储过程，则返回值从1开始；如果指定的是函数，则返回值从0开始，其中0代表函数返回值的位置序号。
  - 对于argument_name参数，如果指定的是函数，那么返回值的第一个位置为空，该位置表示被描述函数的返回值的名称（即空的名称）。
  - 不可直接指定包Package，否则会报错处理。
  - 对于没有执行权限的存储过程/函数/包，会当作不存在的实体并报错处理。
  - 入参reserved1和reserved2不参与内部处理，输入任何字符串都不会对返回结果有影响。
  - 该高级包不可指定通过DBLINK获取的存储过程/函数。
  - 推荐在被指定的存储过程/函数前增加Schema前缀。若省略了Schema前缀，则该高级包会优先使用当前会话的Schema来查找其所属实体（若当前会话Schema中无该所属实体，则会遵循behavior_compat_options中配置项bind_procedure_searchpath的机制来操作）。
  - 若使用%type操作从表字段中取得数据类型，则不会保留类型的约束（带约束的数据类型如NUMBER(3)、VARCHAR2(10)等）。
示例：
```
-- 创建存储过程封装该高级包，用于打印返回值。
gaussdb=# CREATE PROCEDURE PRINT_DESCRIBE (obj_name IN VARCHAR2)
AS
  a_overload     DBE_DESCRIBE.NUMBER_TABLE;
  a_position     DBE_DESCRIBE.NUMBER_TABLE;
  a_level        DBE_DESCRIBE.NUMBER_TABLE;
  a_arg_name     DBE_DESCRIBE.VARCHAR2_TABLE;
  a_dty          DBE_DESCRIBE.NUMBER_TABLE;
  a_def_val      DBE_DESCRIBE.NUMBER_TABLE;
  a_mode         DBE_DESCRIBE.NUMBER_TABLE;
  a_length       DBE_DESCRIBE.NUMBER_TABLE;
  a_precision    DBE_DESCRIBE.NUMBER_TABLE;
  a_scale        DBE_DESCRIBE.NUMBER_TABLE;
  a_radix        DBE_DESCRIBE.NUMBER_TABLE;
  a_spare        DBE_DESCRIBE.NUMBER_TABLE;
  a_include_string_constraints BOOLEAN;
BEGIN
  DBE_DESCRIBE.DESCRIBE_PROCEDURE(
    obj_name,
    null,
    null,
    a_overload,
    a_position,
    a_level,
    a_arg_name,
    a_dty,
    a_def_val,
    a_mode,
    a_length,
    a_precision,
    a_scale,
    a_radix,
    a_spare,
    a_include_string_constraints
  );
  dbe_output.print('overload                ' || chr(9));
  for indx in 1 .. a_overload.count
  loop
    dbe_output.print(a_overload(indx) || chr(9));
  end loop;
  dbe_output.print_line(' ');
  dbe_output.print('dataposition            ' || chr(9));
  for indx in 1 .. a_position.count
  loop
    dbe_output.print(a_position(indx) || chr(9));
  end loop;
  dbe_output.print_line(' ');
  dbe_output.print('datalevel               ' || chr(9));
  for indx in 1 .. a_level.count
  loop
    dbe_output.print(a_level(indx) || chr(9));
  end loop;
  dbe_output.print_line(' ');
  dbe_output.print('argument_name           ' || chr(9));
  for indx in 1 .. a_arg_name.count
  loop
    dbe_output.print(a_arg_name(indx) || chr(9));
  end loop;
  dbe_output.print_line(' ');
  dbe_output.print('default_value           ' || chr(9));
  for indx in 1 .. a_def_val.count
  loop
    dbe_output.print(a_def_val(indx) || chr(9));
  end loop;
  dbe_output.print_line(' ');
  dbe_output.print('in_out                  ' || chr(9));
  for indx in 1 .. a_mode.count
  loop
    dbe_output.print(a_mode(indx) || chr(9));
  end loop;
  dbe_output.print_line(' ');
  dbe_output.print('length                  ' || chr(9));
  for indx in 1 .. a_length.count
  loop
    dbe_output.print(a_length(indx) || chr(9));
  end loop;
  dbe_output.print_line(' ');
  dbe_output.print('precision               ' || chr(9));
  for indx in 1 .. a_precision.count
  loop
    dbe_output.print(a_precision(indx) || chr(9));
  end loop;
  dbe_output.print_line(' ');
  dbe_output.print('scale                   ' || chr(9));
  for indx in 1 .. a_scale.count
  loop
    dbe_output.print(a_scale(indx) || chr(9));
  end loop;
  dbe_output.print_line(' ');
  dbe_output.print('radix                   ' || chr(9));
  for indx in 1 .. a_radix.count
  loop
    dbe_output.print(a_radix(indx) || chr(9));
  end loop;
  dbe_output.print_line(' ');
END;
/
CREATE PROCEDURE
-- 创建带三个重载的函数。
gaussdb=# CREATE OR REPLACE FUNCTION TEST_FUNC_OVERLOAD (
  param_a IN NUMBER,
  param_b IN VARCHAR2,
  param_c OUT TEXT
)
RETURN VARCHAR2 package
AS
BEGIN
  dbe_output.print_line('This procedure/function test num param.');
  RETURN 'This procedure/function test num param.';
END;
/
CREATE FUNCTION
gaussdb=# CREATE OR REPLACE FUNCTION TEST_FUNC_OVERLOAD (
  param_a IN NUMBER DEFAULT 20,
  param_b VARCHAR2 DEFAULT 'n',
  param_c IN TEXT, param_d OUT DATE,
  param_e INOUT RAW
)
RETURN VARCHAR2 package
AS
BEGIN
  dbe_output.print_line('This procedure/function test num param.');
  RETURN 'This procedure/function test num param.';
END;
/
CREATE FUNCTION
gaussdb=# CREATE OR REPLACE FUNCTION TEST_FUNC_OVERLOAD (
  param_a IN NUMBER DEFAULT 20,
  param_b VARCHAR2 DEFAULT 'n',
  param_c IN TEXT, param_d IN DATE,
  param_e OUT RAW, param_f INOUT INTEGER
)
RETURN VARCHAR2 package
AS
BEGIN
  dbe_output.print_line('This procedure/function test num param.');
  RETURN 'This procedure/function test num param.';
END;
/
CREATE FUNCTION
-- 调用上述封装。
gaussdb=# BEGIN PRINT_DESCRIBE('TEST_FUNC_OVERLOAD'); END;
/
overload                        1       1       1       1       2       2       2       2       2       2       3       3       3       3       3       3       3
dataposition                    0       1       2       3       0       1       2       3       4       5       0       1       2       3       4       5       6
datalevel                       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0
argument_name                           param_a param_b param_c         param_a param_b param_c param_d param_e         param_a param_b param_c param_d param_e param_f
default_value                   0       0       0       0       0       1       1       0       0       0       0       1       1       0       0       0       0
in_out                          1       0       0       1       1       0       0       0       1       2       1       0       0       0       0       1       2
length                          0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0
precision                       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0
scale                           0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0
radix                           0       10      0       0       0       10      0       0       0       0       0       10      0       0       0       0       10
ANONYMOUS BLOCK EXECUTE
-- 清理。
gaussdb=# DROP FUNCTION TEST_FUNC_OVERLOAD (
  param_a IN NUMBER,
  param_b IN VARCHAR2,
  param_c OUT TEXT
);
DROP FUNCTION
gaussdb=# DROP FUNCTION TEST_FUNC_OVERLOAD (param_a IN NUMBER,
  param_b VARCHAR2,
  param_c IN TEXT,
  param_d OUT DATE,
  param_e INOUT RAW
);
DROP FUNCTION
gaussdb=# DROP FUNCTION TEST_FUNC_OVERLOAD (param_a IN NUMBER,
  param_b VARCHAR2,
  param_c IN TEXT,
  param_d IN DATE,
  param_e OUT RAW,
  param_f INOUT INTEGER
);
DROP FUNCTION
gaussdb=# DROP PROCEDURE PRINT_DESCRIBE (obj_name IN VARCHAR2);
DROP PROCEDURE
```
父主题：
二次封装接口
版权所有 © 华为技术有限公司
< 上一节
下一节 >



---

