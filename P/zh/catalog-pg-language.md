# 52.29. pg_language

52.29. pg_language
版本：
纠错本页面
搜索
目录导航
❮
❯
52.29. pg_language #
目录pg_language注册了可用于编写函数或存储过程的语言。
更多关于语言处理器的信息请参阅CREATE LANGUAGE和第 40 章。
表 52.29. pg_language 列
列类型
描述
oid oid
行标识符
lanname name
语言名称
lanowner oid
(references pg_authid.oid)
语言的拥有者
lanispl bool
内部语言为假（如SQL），用户定义语言为真。
当前，pg_dump仍然使用这个列来决定要转储哪些语言，但在未来这可能会被一种不同的机制所取代。
lanpltrusted bool
为真表示这是一种可信的语言，即它被相信不会向普通SQL执行环境之外的任何东西授予权限。只有超级用户可以在非可信语言中创建函数。
lanplcallfoid oid
(references pg_proc.oid)
对于非内部语言，此列引用语言处理器，它是一个特殊函数负责执行所有用这种语言编写的函数。
对于内部语言用零。
laninline oid
(references pg_proc.oid)
此列引用一个负责执行“内联”匿名代码块的函数（DO 块）。如果不支持内联块则为0。
lanvalidator oid
(references pg_proc.oid)
此列引用一个负责在函数创建时对其进行语法和有效性检查的语言验证函数。如果没有提供验证器则为0。
lanacl aclitem[]
访问权限，详情参见第 5.8 节
上一页 上一级 下一页52.28. pg_init_privs 起始页 52.30. pg_largeobject
