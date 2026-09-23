# CREATE CONVERSION

CREATE CONVERSION
版本：
纠错本页面
搜索
目录导航
❮
❯
CREATE CONVERSIONCREATE CONVERSION — 定义一种新的编码转换大纲
CREATE [ DEFAULT ] CONVERSION name
FOR source_encoding TO dest_encoding FROM function_name
描述
CREATE CONVERSION 定义一种两个字符集编码之间的新转换。
标记为DEFAULT的转换将被自动地用于客户端和服务器之间的编码转换。为了支持这种用法，必须定义两个转换（从编码 A 到 B 以及从编码 B 到 A）。
要创建一个转换，你必须拥有该函数上的EXECUTE特权以及目标模式上的CREATE特权。
参数DEFAULT
DEFAULT子句表示这个转换是从源编码到目标编码的默认
转换。在一个模式中对于每一个编码对，只应该有一个默认编码。
name
转换的名称，可以被模式限定。如果没有被模式限定，该转换被定义在
当前模式中。在一个模式中，转换名称必须唯一。
source_encoding
源编码名称。
dest_encoding
目标编码名称。
function_name
被用来执行转换的函数。函数名可以被模式限定。如果没有，将在路径
中查找该函数。
该函数必须具有以下的特征：
conv_proc(
integer,  -- 源编码 ID
integer,  -- 目标编码 ID
cstring,  -- 源字符串（空值终止的 C 字符串）
internal, -- 目标（用一个空值终止的 C 字符串填充）
integer,  -- 源字符串长度
boolean   -- 如果为 true，则在转换失败时不要抛出错误
) RETURNS integer;
返回值是成功转换的源字节数。如果最后一个参数为 false，
则函数必须在无效输入时抛出错误，并且返回值始终等于源字符串长度。
注释
源编码和目标编码都不可以是SQL_ASCII，
因为在涉及SQL_ASCII “encoding”的情况下，
服务器的行为是硬编码的。
使用DROP CONVERSION来移除用户定义的转换。
创建转换所需的特权可能在未来的发行中被更改。
示例
使用myfunc创建一个从编码UTF8到
LATIN1的转换：
CREATE CONVERSION myconv FOR 'UTF8' TO 'LATIN1' FROM myfunc;
兼容性
CREATE CONVERSION
是一种PostgreSQL扩展。
在 SQL 标准中没有CREATE CONVERSION
语句，但是有一个目的和语法都类似的
CREATE TRANSLATION语句。
其他参考ALTER CONVERSION, CREATE FUNCTION, DROP CONVERSION上一页 上一级 下一页CREATE COLLATION 起始页 CREATE DATABASE
