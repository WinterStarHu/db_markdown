# F.2. auth_delay — 认证失败时的暂停

F.2. auth_delay — 认证失败时的暂停
版本：
纠错本页面
搜索
目录导航
❮
❯
F.2. auth_delay — 认证失败时的暂停 #F.2.1. 配置参数F.2.2. 作者
auth_delay使得服务器在报告认证失败之前短暂地停顿一会儿，这使得对数据库密码的暴力攻击更加困难。注意它无助于防止拒绝服务攻击，甚至可能会加剧它们，因为在报告认证失败之前等待的进程仍然要消耗连接槽。
要使之工作，该模块必须通过shared_preload_libraries在postgresql.conf中载入。
F.2.1. 配置参数 #
auth_delay.milliseconds (integer)
在报告认证失败之前等待的毫秒数。默认值为0。
这些参数必须在postgresql.conf中设置。典型的用法是：
# postgresql.conf
shared_preload_libraries = 'auth_delay'
auth_delay.milliseconds = '500'
F.2.2. 作者 #
KaiGai Kohei <kaigai@ak.jp.nec.com>
上一页 上一级 下一页F.1. amcheck — 用于验证表和索引一致性的工具 起始页 F.3. auto_explain — 记录慢查询的执行计划
