# DESCRIBE

DESCRIBE
版本：
纠错本页面
搜索
目录导航
❮
❯
DESCRIBEDESCRIBE — 获取有关一个预备语句或结果集的信息大纲
DESCRIBE [ OUTPUT ] prepared_name USING [ SQL ] DESCRIPTOR descriptor_name
DESCRIBE [ OUTPUT ] prepared_name INTO [ SQL ] DESCRIPTOR descriptor_name
DESCRIBE [ OUTPUT ] prepared_name INTO sqlda_name
描述
DESCRIBE检索关于预备语句中包含的结果列的元数据
信息，而不会实际获取一行。
参数prepared_name #
一个预备语句的名称。这可以是一个 SQL 标识符或一个主变量。
descriptor_name #
一个描述符名称。它是大小写敏感的。它可以是一个 SQL 标识符或一个主变量。
sqlda_name #
一个 SQLDA 变量的名称。
示例
EXEC SQL ALLOCATE DESCRIPTOR mydesc;
EXEC SQL PREPARE stmt1 FROM :sql_stmt;
EXEC SQL DESCRIBE stmt1 INTO SQL DESCRIPTOR mydesc;
EXEC SQL GET DESCRIPTOR mydesc VALUE 1 :charvar = NAME;
EXEC SQL DEALLOCATE DESCRIPTOR mydesc;
兼容性
DESCRIBE 在 SQL 标准中被规定。
参见ALLOCATE DESCRIPTOR, GET DESCRIPTOR上一页 上一级 下一页DECLARE STATEMENT 起始页 DISCONNECT
