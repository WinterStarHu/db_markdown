# 21.3. 角色成员资格

21.3. 角色成员资格
版本：
纠错本页面
搜索
目录导航
❮
❯
21.3. 角色成员资格 #
把用户分组在一起来便于管理权限常常很方便：那样，权限可以被授予一整个组或从一整个组回收。在PostgreSQL中通过创建一个表示组的角色来实现，并且然后将在该组角色中的成员资格授予给单独的用户角色。
要建立一个组角色，首先创建该角色：
CREATE ROLE name;
通常被用作一个组的角色不需要有LOGIN属性，不过如果你愿意也可以设置它。
一旦组角色存在，你可以使用GRANT 和 REVOKE命令增加和移除成员：
GRANT group_role TO role1, ... ;
REVOKE group_role FROM role1, ... ;
你也可以为其他组角色授予成员资格（因为组角色和非组角色之间其实没有任何区别）。数据库将不会让你设置环状的成员关系。另外，不允许把一个角色中的成员资格授予给PUBLIC。
组角色的成员可以通过两种方式使用该角色的权限。首先，已被授予
SET 选项的成员角色可以执行
SET ROLE 来
临时 “成为” 组角色。在这种状态下，数据库会话可以访问
组角色的权限，而不是原始登录角色的权限，并且创建的任何数据库对象
被视为由组角色拥有，而不是登录角色拥有。其次，已被授予
INHERIT 选项的成员角色自动可以使用那些直接或间接
成员的权限，尽管链条在缺少继承选项的成员资格处停止。举个例子，
假设我们已经执行了：
CREATE ROLE joe LOGIN;
CREATE ROLE admin;
CREATE ROLE wheel;
CREATE ROLE island;
GRANT admin TO joe WITH INHERIT TRUE;
GRANT wheel TO admin WITH INHERIT FALSE;
GRANT island TO joe WITH INHERIT TRUE, SET FALSE;
立即在以角色 joe 连接后，数据库会话将可以使用
直接授予 joe 的权限，以及授予 admin
和 island 的任何权限，因为 joe
“继承” 了这些权限。然而，授予 wheel 的
权限不可用，因为尽管 joe 是 wheel
的间接成员，但该成员资格是通过使用
WITH INHERIT FALSE 授予的 admin。
之后：
SET ROLE admin;
会话将只能使用授予 admin 的权限，而不是授予
joe 或 island 的权限。之后：
SET ROLE wheel;
会话将只能使用授予 wheel 的权限，而不是授予
joe 或 admin 的权限。可以通过以下任一方式
恢复原始权限状态：
SET ROLE joe;
SET ROLE NONE;
RESET ROLE;
注意
SET ROLE命令始终允许选择任何原始登录角色直接或间接
属于的角色，前提是每个成员资格授予链都具有SET TRUE
（这是默认值）。
因此，在上述示例中，不需要先成为admin，然后再成为
wheel。
另一方面，完全无法成为island；
joe只能通过继承访问这些权限。
注意
在 SQL 标准中，用户和角色之间的区别很清楚，并且用户不会自动继承权限而角色会继承。这种行为在PostgreSQL中也可以实现：为要用作 SQL 角色的角色给予INHERIT属性，而为要用作 SQL 用户的角色给予NOINHERIT属性。不过，为了向后兼容 8.1 以前的发布（在其中用户总是拥有它们所在组的权限），PostgreSQL默认给所有的角色INHERIT属性。
角色属性LOGIN、SUPERUSER、CREATEDB和CREATEROLE可以被认为是一种特殊权限，但是它们从来不会像数据库对象上的普通权限那样被继承。要使用这些属性，你必须实际SET ROLE到一个有这些属性之一的特定角色。继续上述例子，我们可以选择授予CREATEDB和CREATEROLE给admin角色。然后一个以joe角色连接的会话将不会立即有这些权限，只有在执行了SET ROLE admin之后才会拥有。
要销毁一个组角色，使用DROP ROLE：
DROP ROLE name;
任何在该组角色中的成员关系会被自动撤销（但是成员角色不会受到影响）。
上一页 上一级 下一页21.2. 角色属性 起始页 21.4. 删除角色
