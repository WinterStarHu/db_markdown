# 35.48. sql_features

35.48. sql_features
版本：
纠错本页面
搜索
目录导航
❮
❯
35.48. sql_features #
表sql_features包含的信息指示了哪些 SQL 标准中定义的正式特性被PostgreSQL所支持。这和附录 D中的信息一样。这里你也能找到一些额外的背景信息。
表 35.46. sql_features 列
列类型
描述
feature_id character_data
特性的标识符字符串
feature_name character_data
特性的描述性名称
sub_feature_id character_data
子特性的标识符字符串，如果不是子特性则为一个长度为零的字符串
sub_feature_name character_data
子特性的描述性名称，如果不是子特性则为一个长度为零的字符串
is_supported yes_or_no
如果该特性被当前版本的PostgreSQL完全支持，则为YES，否则为NO
is_verified_by character_data
总是为空，因为PostgreSQL开发组没有对特性的一致性执行正式的测试
comments character_data
可能是关于该特性支持状态的注释
上一页 上一级 下一页35.47. sequences 起始页 35.49. sql_implementation_info
