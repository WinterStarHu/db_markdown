# TYPE

TYPE
版本：
纠错本页面
搜索
目录导航
❮
❯
TYPETYPE — 定义一个新的数据类型大纲
TYPE type_name IS ctype
描述
TYPE命令定义一个新的 C 类型。它等效于把一个typedef放在声明部分中。
只有使用选项-c运行ecpg时才能识别这个命令。
参数type_name #
新类型的名称。这必须是一个有效的 C 类型名。
ctype #
一个 C 类型规范。
示例
EXEC SQL TYPE customer IS
struct
{
varchar name[50];
int     phone;
};
EXEC SQL TYPE cust_ind IS
struct ind
{
short   name_ind;
short   phone_ind;
};
EXEC SQL TYPE c IS char reference;
EXEC SQL TYPE ind IS union { int integer; short smallint; };
EXEC SQL TYPE intarray IS int[AMOUNT];
EXEC SQL TYPE str IS varchar[BUFFERSIZ];
EXEC SQL TYPE string IS char[11];
这里是一个使用EXEC SQL TYPE的示例程序：
EXEC SQL WHENEVER SQLERROR SQLPRINT;
EXEC SQL TYPE tt IS
struct
{
varchar v[256];
int     i;
};
EXEC SQL TYPE tt_ind IS
struct ind {
short   v_ind;
short   i_ind;
};
int
main(void)
{
EXEC SQL BEGIN DECLARE SECTION;
tt t;
tt_ind t_ind;
EXEC SQL END DECLARE SECTION;
EXEC SQL CONNECT TO testdb AS con1;
EXEC SQL SELECT pg_catalog.set_config('search_path', '', false); EXEC SQL COMMIT;
EXEC SQL SELECT current_database(), 256 INTO :t:t_ind LIMIT 1;
printf("t.v = %s\n", t.v.arr);
printf("t.i = %d\n", t.i);
printf("t_ind.v_ind = %d\n", t_ind.v_ind);
printf("t_ind.i_ind = %d\n", t_ind.i_ind);
EXEC SQL DISCONNECT con1;
return 0;
}
这个程序的输出看起来像：
t.v = testdb
t.i = 256
t_ind.v_ind = 0
t_ind.i_ind = 0
兼容性
TYPE命令是一种 PostgreSQL 扩展。
上一页 上一级 下一页SET DESCRIPTOR 起始页 VAR
