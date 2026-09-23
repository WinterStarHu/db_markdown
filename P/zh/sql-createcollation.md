# CREATE COLLATION

CREATE COLLATION
版本：
纠错本页面
搜索
目录导航
❮
❯
CREATE COLLATIONCREATE COLLATION — 定义一种新排序规则大纲
CREATE COLLATION [ IF NOT EXISTS ] name (
[ LOCALE = locale, ]
[ LC_COLLATE = lc_collate, ]
[ LC_CTYPE = lc_ctype, ]
[ PROVIDER = provider, ]
[ DETERMINISTIC = boolean, ]
[ RULES = rules, ]
[ VERSION = version ]
)
CREATE COLLATION [ IF NOT EXISTS ] name FROM existing_collation
描述
CREATE COLLATION使用指定的操作系统区域
设置，或者通过复制现有的排序规则来定义新的排序规则。
要创建一种排序规则，你必须拥有目标模式上的
CREATE特权。
参数IF NOT EXISTS
如果已经存在同名的排序规则，则不要抛出错误。在这种情况下发出一个通知。
请注意，不保证已经存在的排序规则与要创建的这个类似。
name
排序规则的名字，可以被模式限定。如果没有用模式限定，该排序规则
会被定义在当前模式中。排序规则名称在其所处的模式中必须唯一（系统
目录可以为其他编码包含具有相同名称的排序规则，但数据库编码不匹配
时它们会被忽略）。
locale
此排序规则的区域设置名称。请参阅第 23.2.2.3.1 节和第 23.2.2.3.2 节了解详细信息。
如果provider是libc，这
是同时设置LC_COLLATE和
LC_CTYPE的快捷方式。如果您指定了
locale，则不能指定这些参数中的任意一个。
如果provider是builtin，
则必须指定locale并设置为
C、C.UTF-8或
PG_UNICODE_FAST之一。
lc_collate
如果provider是libc，则使用指定的操作系统区域设置
来设置LC_COLLATE区域类别。
lc_ctype
如果provider是libc，则使用指定的操作系统区域
设置作为LC_CTYPE区域类别。
provider
指定用于与此排序规则相关的区域设置服务的提供程序。可能的值有
builtin、icu（如果服务器是使用 ICU 支持构建的）
或libc。libc是默认值。详情请参见
第 23.1.4 节。
DETERMINISTIC
指定排序规则是否应使用确定性比较。默认值为true。确定性比较认为不是逐字节相等的字符串即使在逻辑上相等也被视为不相等。PostgreSQL使用逐字节比较来解决冲突。不确定性比较可能使排序规则变得不区分大小写或重音。为此，您需要选择适当的LOCALE设置
并在此处将排序规则设置为不确定性。
非确定性排序规则仅由ICU提供者支持。
rules
指定额外的排序规则以自定义排序的行为。这仅支持ICU。有关详细信息，请参阅
第 23.2.3.4 节。
version
指定与排序规则一起存储的版本字符串。通常，这应被省略，这将导致版本从操作系统提供的排序规则的实际版本中计算出来。
此选项旨在供pg_upgrade用于复制现有安装中的版本。
另请参见ALTER COLLATION以了解如何处理排序规则版本不匹配。
existing_collation
要复制的现有排序规则的名称。新的排序规则将具有与现有排序规则相同的属性，但它将是一个独立的对象。
注释
CREATE COLLATION 采用SHARE ROW EXCLUSIVE锁，在pg_collation系统目录上，这是自我冲突的，所以一次只能运行一条CREATE COLLATION命令。
使用DROP COLLATION来移除用户定义的排序规则。
关于如何创建排序规则的更多信息可见第 23.2.2.3 节。
使用libc排序规则提供程序时，语言环境必须适用于当前的数据库编码。
有关精确的规则，请参见CREATE DATABASE。
示例
从操作系统区域fr_FR.utf8创建一种排序规则（假定
当前数据库编码是UTF8）：
CREATE COLLATION french (locale = 'fr_FR.utf8');
使用ICU提供程序创建排序规则，使用德国电话簿排序顺序：
CREATE COLLATION german_phonebook (provider = icu, locale = 'de-u-co-phonebk');
要使用ICU提供程序创建一个基于根ICU语言环境的排序规则，并使用自定义规则：
CREATE COLLATION custom (provider = icu, locale = 'und', rules = '&V << w <<< W');
请参阅第 23.2.3.4 节以获取有关规则语法的更多详细信息和示例。
从一个现有的排序规则创建一个新的排序规则：
CREATE COLLATION german FROM "de_DE";
能在应用中使用与操作系统无关的排序规则名称就很方便了。
兼容性
在 SQL 标准中有一个CREATE COLLATION
语句，但是它被限制为只能复制一个现有的排序规则。创建新排序规则的
语法是一种PostgreSQL扩展。
另见ALTER COLLATION, DROP COLLATION上一页 上一级 下一页CREATE CAST 起始页 CREATE CONVERSION
