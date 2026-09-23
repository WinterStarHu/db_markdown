# CREATE EXTENSION

CREATE EXTENSION
版本：
纠错本页面
搜索
目录导航
❮
❯
CREATE EXTENSIONCREATE EXTENSION — 安装扩展大纲
CREATE EXTENSION [ IF NOT EXISTS ] extension_name
[ WITH ] [ SCHEMA schema_name ]
[ VERSION version ]
[ CASCADE ]
描述
CREATE EXTENSION将一个新的扩展载入到
当前数据库中。不能有同名扩展已经被载入。
载入扩展本质上是运行该扩展的脚本文件。该脚本通常将创建新的
SQL对象，例如函数、数据类型、操作符以及索引支持
方法。CREATE EXTENSION会额外记录
所有被创建对象的标识，这样发出
DROP EXTENSION时可以删除它们。
运行CREATE EXTENSION的用户成为扩展的所有者，
以进行后续的特权检查，并且通常也成为由扩展的脚本创建的任何对象的所有者。
通常，加载扩展需要与创建其组件对象所需的特权相同的特权。对于许多扩展，这
意味着需要超级用户特权。然而，如果扩展在其控制文件中标记为trusted，
则该扩展可以由对当前数据库具有CREATE特权的任何用户安装。
在这种情况下，扩展对象本身将由主叫用户拥有，但包含的对象将由引导超级用户拥有
（除非扩展的脚本明确将其分配给主叫用户）。此配置使主叫用户有权删除该扩展，
但不能修改其中的单个对象。
参数IF NOT EXISTS
已有同名扩展存在时不要抛出错误。这种情况下会发出一个提示。
注意，不保证现有的扩展与将要从当前可用的脚本文件创建的脚本
有任何相似。
extension_name
要安装的扩展名。 PostgreSQL 将使用
从文件 extension_name.control
中的详细信息创建扩展，该文件通过服务器的扩展控制路径找到
（由 extension_control_path 设置）。
schema_name
假定该扩展允许其内容被重定位，这是要在其中安装该扩展的对象的
模式名称。被提到的模式必须已经存在。如果没有指定并且该扩展的
控制文件也没有指定一个模式，将使用当前的默认对象创建模式。
如果该扩展在其控制文件中指定了一个schema参数，
那么不能用SCHEMA子句覆盖该模式。通常，如果
给出了一个SCHEMA子句并且它与扩展的
schema参数冲突，则会发生错误。不过，如果也给
出了CASCADE子句，则schema_name
冲突时会被忽略。给定的schema_name
将被用来安装任何需要的并且没有在其控制文件中指定
schema的扩展。
记住扩展本身被认为不在任何模式中：扩展具有无限定的名称，并且
要在整个数据库范围内唯一。但是属于扩展的对象可以在模式中。
version
要安装的扩展的版本。这可以写成一个标识符或者一个字符串文字。
默认版本在该扩展的控制文件中指定。
CASCADE
自动安装这个扩展所依赖的任何还未安装的扩展。它们的依赖也会同样
被自动安装。如果给出SCHEMA子句，它会应用于这种方式
下安装的所有扩展。这个语句的其他选项不会被应用于自动安装的扩展。
特别地，这些自动安装的扩展的默认版本将被选中。
注释
在使用CREATE EXTENSION载入扩展到数据库中之前，
必须先安装好该扩展的支持文件。关于安装
PostgreSQL提供的扩展的信息可以在
其他提供的模块中找到。
当前可以用于载入的扩展可以在系统视图
pg_available_extensions
或者
pg_available_extension_versions
中看到。
小心
以超级用户身份安装扩展程序需要相信扩展程序的作者以安全的方式编写了扩展程序安装脚本。
对于恶意用户而言，创建特洛伊木马对象并不困难，而这些特洛伊木马对象会损害以后粗心编写
的扩展脚本的执行，从而使该用户获得超级用户特权。但是，仅当木马对象在脚本执行期间位于
search_path中时，它们才是危险的，这意味着它们位于扩展的安装
目标模式或它依赖的某些扩展的模式中。因此，在处理未经仔细审查其脚本的扩展时，一个好的
经验法则是仅将其安装到尚未具有CREATE特权且不会授予任何不可信用户的模式中。
对它们依赖的任何扩展也是一样。
针对此类安装时攻击，PostgreSQL提供的扩展可以认为是
安全的，除了少数依赖于其他扩展的情况。如这些扩展的文档中所述，应将
它们安装到安全模式中，或与它们所依赖的扩展安装在相同的模式中，或两者都可以。
更多有关编写新扩展的内容请见第 36.17 节。
示例
安装hstore扩展到当前数据库中，将其对象放置在
addons模式中：
CREATE EXTENSION hstore SCHEMA addons;
另一种方法：
SET search_path = addons;
CREATE EXTENSION hstore;
兼容性
CREATE EXTENSION 是一种
PostgreSQL 扩展。
另见ALTER EXTENSION, DROP EXTENSION上一页 上一级 下一页CREATE EVENT TRIGGER 起始页 CREATE FOREIGN DATA WRAPPER
