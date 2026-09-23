# 33.4. 服务器端函数

33.4. 服务器端函数
版本：
纠错本页面
搜索
目录导航
❮
❯
33.4. 服务器端函数 #
表 33.1中列出了为从 SQL 操作大对象定制的服务器端函数。
表 33.1. SQL-Oriented Large Object Functions
函数
描述
示例
lo_from_bytea ( loid oid, data bytea )
→ oid
创建一个大对象并在其中存储data。
如果loid为零，则系统将选择一个
空闲OID，否则将使用该OID（如果某个大对象已经拥有该OID，则会出现错误）。在成功时，将返回大对象的OID。
lo_from_bytea(0, '\xffffff00')
→ 24528
lo_put ( loid oid, offset bigint, data bytea )
→ void
从给定偏移量开始在大对象中写入data；如有必要，可以扩大大对象。
lo_put(24528, 1, '\xaa')
→
lo_get ( loid oid [, offset bigint, length integer ] )
→ bytea
提取大对象的内容，或其子字符串。
lo_get(24528, 0, 3)
→ \xffaaff
之前描述过的每个客户端函数都有一个相应的服务器端函数。实际上，
多半客户端函数都是等效的服务器端函数的简单接口。这些可以从 SQL
命令方便调用的函数是：
lo_creat、
lo_create、
lo_unlink、
lo_import以及
lo_export。
下面是使用它们的例子：
CREATE TABLE image (
name            text,
raster          oid
);
SELECT lo_creat(-1);       -- 返回新的空大对象的OID
SELECT lo_create(43213);   -- 尝试创建OID为43213的大对象
SELECT lo_unlink(173454);  -- 删除OID为173454的大对象
INSERT INTO image (name, raster)
VALUES ('beautiful image', lo_import('/etc/motd'));
INSERT INTO image (name, raster)  -- 和上面相同，但是指定了使用的OID
VALUES ('beautiful image', lo_import('/etc/motd', 68583));
SELECT lo_export(image.raster, '/tmp/motd') FROM image
WHERE name = 'beautiful image';
服务器端的lo_import和lo_export函数具有和它们的客户端同类大不相同的行为。这两个函数从服务器的文件系统中读和写文件，使用的是数据库所有者的权限。因此，默认情况下它们的使用被限制于超级用户。相反，客户端的导入和导出函数读写的是客户端的文件系统，使用的是客户端程序的权限。除了读取或写入所请求的大对象的特权之外，客户端函数不要求任何数据库特权。
小心
可以把服务器端的lo_import和lo_export函数GRANT给非超级用户，但需要仔细地考虑安全因素。有这类特权的恶意用户可以很容易地利用它们成为超级用户（例如通过重写服务器配置文件），或者攻击该服务器文件系统的其他部分而无需获得数据库超级用户特权。因此对具有这类特权的角色访问必须受到和超级用户角色一样的仔细保护。尽管如此，如果某些例行任务需要使用服务器端的lo_import或者lo_export，使用具有这类特权的角色比使用具有完整超级用户特权的角色更加安全，因为那样会减小意外错误造成的损伤风险。
函数lo_read和
lo_write的功能也可以在服务器端调用，但是在服务器端的名称与客户端接口不同：它们的名称中不包含下划线。我们必须以loread和lowrite调用这些函数。
上一页 上一级 下一页33.3. 客户端接口 起始页 33.5. 示例程序
