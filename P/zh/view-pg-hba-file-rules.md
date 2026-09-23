# 53.10. pg_hba_file_rules

53.10. pg_hba_file_rules
版本：
纠错本页面
搜索
目录导航
❮
❯
53.10. pg_hba_file_rules #
视图pg_hba_file_rules提供了客户端认证配置文件
pg_hba.conf
内容的摘要。文件中每个非空、非注释行都会在该视图中显示一行，同时带有注释，指示规则是否能够成功应用。
这个视图对于检查计划中的身份验证配置文件的更改是否有效，或者诊断先前的故障非常有帮助。
请注意，这个视图报告的是文件的current内容，而不是服务器上次加载的内容。
默认情况下，pg_hba_file_rules视图只能被超级用户读取。
表 53.10. pg_hba_file_rules 列
列类型
描述
rule_number int4
此规则的编号（如果有效），否则为NULL。
这表示在身份验证期间，直到找到匹配项为止，每条规则被考虑的顺序。
file_name text
包含此规则的文件名称
line_number int4
此规则在file_name中的行号
type text
连接类型
database text[]
这条规则应用的数据库名列表
user_name text[]
这条规则应用的用户及组名列表
address text
主机名或IP地址，或者all、samehost、samenet之一，对于本地连接为空
netmask text
IP地址掩码，如果不适用则为null
auth_method text
认证方法
options text[]
为认证方法指定的选项（如果有）
error text
如果非空，则是一个错误消息，指示为什么这一行无法被处理
通常，反映错误条目的行只会有line_number和error字段的值。
查看第 20 章以获取有关客户端身份验证配置的更多信息。
上一页 上一级 下一页53.9. pg_group 起始页 53.11. pg_ident_file_mappings
