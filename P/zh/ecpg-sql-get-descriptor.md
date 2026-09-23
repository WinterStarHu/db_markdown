# GET DESCRIPTOR

GET DESCRIPTOR
版本：
纠错本页面
搜索
目录导航
❮
❯
GET DESCRIPTORGET DESCRIPTOR — 从一个 SQL 描述符区域获取信息大纲
GET DESCRIPTOR descriptor_name :cvariable = descriptor_header_item [, ... ]
GET DESCRIPTOR descriptor_name VALUE column_number :cvariable = descriptor_item [, ... ]
描述
GET DESCRIPTOR从一个 SQL 描述符区域检索关于一个查询结果集的信息并将其存储在主变量中。在使用这个命令将信息传输到主语言变量之前，一个描述符区域通常是用FETCH或SELECT填充的。
这个命令有两种形式：第一种形式检索描述符的“头部”项，它适用于结果集的整体。一种例子是行计数。第二种形式要求列号作为附加参数，它检索有关特定列的信息。其例子是列名和实际列值。
参数descriptor_name #
一个描述符名称。
descriptor_header_item #
一个标识要检索哪一个头部信息项的记号。当前只支持用于获取结果集中列数的COUNT。
column_number #
要检索其信息的列号。计数从1开始。
descriptor_item #
一个标识要检索哪一个有关列的信息项的记号。支持的项请参见第 34.7.1 节。
cvariable #
接收从描述符区域检索到的数据的主变量。
示例
检索结果集中列数的示例：
EXEC SQL GET DESCRIPTOR d :d_count = COUNT;
检索第一列中数据长度的示例：
EXEC SQL GET DESCRIPTOR d VALUE 1 :d_returned_octet_length = RETURNED_OCTET_LENGTH;
检索第二列的数据体作为字符串的示例：
EXEC SQL GET DESCRIPTOR d VALUE 2 :d_data = DATA;
这是执行SELECT current_database();并显示列数、列数据长度和列数据的完整过程的示例：
int
main(void)
{
EXEC SQL BEGIN DECLARE SECTION;
int  d_count;
char d_data[1024];
int  d_returned_octet_length;
EXEC SQL END DECLARE SECTION;
EXEC SQL CONNECT TO testdb AS con1 USER testuser;
EXEC SQL SELECT pg_catalog.set_config('search_path', '', false); EXEC SQL COMMIT;
EXEC SQL ALLOCATE DESCRIPTOR d;
/* 声明、打开一个游标，并分配一个描述符给该游标  */
EXEC SQL DECLARE cur CURSOR FOR SELECT current_database();
EXEC SQL OPEN cur;
EXEC SQL FETCH NEXT FROM cur INTO SQL DESCRIPTOR d;
/* 获取总列数 */
EXEC SQL GET DESCRIPTOR d :d_count = COUNT;
printf("d_count                 = %d\n", d_count);
/* 获取返回列的长度 */
EXEC SQL GET DESCRIPTOR d VALUE 1 :d_returned_octet_length = RETURNED_OCTET_LENGTH;
printf("d_returned_octet_length = %d\n", d_returned_octet_length);
/* 将返回的列作为字符串取出 */
EXEC SQL GET DESCRIPTOR d VALUE 1 :d_data = DATA;
printf("d_data                  = %s\n", d_data);
/* 关闭 */
EXEC SQL CLOSE cur;
EXEC SQL COMMIT;
EXEC SQL DEALLOCATE DESCRIPTOR d;
EXEC SQL DISCONNECT ALL;
return 0;
}
当该示例被执行时，结果将如下所示：
d_count                 = 1
d_returned_octet_length = 6
d_data                  = testdb
兼容性
SQL 标准中规定了GET DESCRIPTOR。
参见ALLOCATE DESCRIPTOR, SET DESCRIPTOR上一页 上一级 下一页EXECUTE IMMEDIATE 起始页 OPEN
