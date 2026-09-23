# 9.12. 网络地址函数和操作符

9.12. 网络地址函数和操作符
版本：
纠错本页面
搜索
目录导航
❮
❯
9.12. 网络地址函数和操作符 #
IP网络地址类型，cidr和inet，支持表 9.1所示的常用比较操作符，
以及表 9.39 和 表 9.40所示的专用操作符和函数。
任何cidr 值都可以隐式地转换到inet；因此，下面在inet上操作的操作符和函数也可以在cidr值上工作。
(对于inet和cidr有单独的函数，这是因为这两种情况的行为应该是不同的。)
此外，它允许将inet值转换为cidr。
当这样做时，子网掩码右边的任何位都被静默地置零，以创建一个有效的cidr值。
表 9.39. IP 地址操作符
操作符
描述
示例
inet << inet
→ boolean
子网是否严格包含在子网中？
这个操作符和后续的四个操作符测试子网包含情况。它们只考虑两个地址的网络部分（忽略网络掩码右侧的任何位），并确定一个网络与另一个网络相同或者是相同的子网。
inet '192.168.1.5' << inet '192.168.1/24'
→ t
inet '192.168.0.5' << inet '192.168.1/24'
→ f
inet '192.168.1/24' << inet '192.168.1/24'
→ f
inet <<= inet
→ boolean
子网是否包含或等于子网？
inet '192.168.1/24' <<= inet '192.168.1/24'
→ t
inet >> inet
→ boolean
子网是否严格包含子网？
inet '192.168.1/24' >> inet '192.168.1.5'
→ t
inet >>= inet
→ boolean
子网是否包含或等于子网？
inet '192.168.1/24' >>= inet '192.168.1/24'
→ t
inet && inet
→ boolean
其中一个子网是否包含或等于另一个子网？
inet '192.168.1/24' && inet '192.168.1.80/28'
→ t
inet '192.168.1/24' && inet '192.168.2.0/28'
→ f
~ inet
→ inet
计算位的 NOT.
~ inet '192.168.1.6'
→ 63.87.254.249
inet & inet
→ inet
计算位的 AND.
inet '192.168.1.6' & inet '0.0.0.255'
→ 0.0.0.6
inet | inet
→ inet
计算位的 OR.
inet '192.168.1.6' | inet '0.0.0.255'
→ 192.168.1.255
inet + bigint
→ inet
向地址添加偏移量。
inet '192.168.1.6' + 25
→ 192.168.1.31
bigint + inet
→ inet
向地址添加偏移量。
200 + inet '::ffff:fff0:1'
→ ::ffff:255.240.0.201
inet - bigint
→ inet
从地址中减去偏移量。
inet '192.168.1.43' - 36
→ 192.168.1.7
inet - inet
→ bigint
计算两个地址的差值。
inet '192.168.1.43' - inet '192.168.1.19'
→ 24
inet '::1' - inet '::ffff:1'
→ -4294901760
表 9.40. IP 地址函数
函数
描述
示例
abbrev ( inet )
→ text
创建缩略的文本显示格式。
(结果与inet输出函数产生的结果相同;它只是在与显式转换为text的结果比较时才被“abbreviated”，
由于历史原因，它永远不会抑制子网掩码部分。)
abbrev(inet '10.1.0.0/32')
→ 10.1.0.0
abbrev ( cidr )
→ text
创建缩略的文本显示格式。
(缩写包括在子网掩码的右侧删除所有零字节;更多的例子请见 表 8.22。)
abbrev(cidr '10.1.0.0/16')
→ 10.1/16
broadcast ( inet )
→ inet
计算地址的网络的广播地址。
broadcast(inet '192.168.1.5/24')
→ 192.168.1.255/24
family ( inet )
→ integer
返回地址的系列: 4 对应 IPv4,
6 对应 IPv6。
family(inet '::1')
→ 6
host ( inet )
→ text
返回IP地址文本，忽略子网掩码。
host(inet '192.168.1.0/24')
→ 192.168.1.0
hostmask ( inet )
→ inet
计算地址的网络的主机掩码。
hostmask(inet '192.168.23.20/30')
→ 0.0.0.3
inet_merge ( inet, inet )
→ cidr
计算包含两个给定网络的最小网络。
inet_merge(inet '192.168.1.5/24', inet '192.168.2.5/24')
→ 192.168.0.0/22
inet_same_family ( inet, inet )
→ boolean
测试地址是否属于同一IP家族。
inet_same_family(inet '192.168.1.5/24', inet '::1')
→ f
masklen ( inet )
→ integer
返回子网掩码长度（以比特位计）。
masklen(inet '192.168.1.5/24')
→ 24
netmask ( inet )
→ inet
计算地址的网络掩码。
netmask(inet '192.168.1.5/24')
→ 255.255.255.0
network ( inet )
→ cidr
返回地址的网络部分，将子网掩码右边的部分归零。
(这相当于将值转换为cidr。)
network(inet '192.168.1.5/24')
→ 192.168.1.0/24
set_masklen ( inet, integer )
→ inet
设置inet值的子网掩码长度。地址部分不改变。
set_masklen(inet '192.168.1.5/24', 16)
→ 192.168.1.5/16
set_masklen ( cidr, integer )
→ cidr
设置cidr值的子网掩码长度。新子网掩码右侧的地址位设置为零。
set_masklen(cidr '192.168.1.0/24', 16)
→ 192.168.0.0/16
text ( inet )
→ text
以文本形式返回未缩写的IP地址和子网掩码长度。
(这与显式转换为text的结果相同。)
text(inet '192.168.1.5')
→ 192.168.1.5/32
提示
abbrev、host和text函数主要用于为IP地址提供另一种显示格式。
MAC地址类型， macaddr 和 macaddr8，支持表 9.1中所示的常用比较操作符以及表 9.41中所示的特殊函数。
此外，它们支持位元逻辑操作符~, & 和 | (NOT, AND 和 OR)，就像上面对IP地址所示的那样。
表 9.41. MAC地址函数
函数
描述
示例
trunc ( macaddr )
→ macaddr
将地址的最后3个字节设置为零。其余的前缀可以与特定的制造商关联（使用PostgreSQL中没有包含的数据）。
trunc(macaddr '12:34:56:78:90:ab')
→ 12:34:56:00:00:00
trunc ( macaddr8 )
→ macaddr8
将地址的最后5个字节设置为零。其余的前缀可以与特定的制造商关联（使用PostgreSQL中没有包含的数据）。
trunc(macaddr8 '12:34:56:78:90:ab:cd:ef')
→ 12:34:56:00:00:00:00:00
macaddr8_set7bit ( macaddr8 )
→ macaddr8
将地址的第7位设置为1，创建所谓的修改后的EUI-64，用于包含在IPv6地址中。
macaddr8_set7bit(macaddr8 '00:34:56:ab:cd:ef')
→ 02:34:56:ff:fe:ab:cd:ef
上一页 上一级 下一页9.11. 几何函数和操作符 起始页 9.13. 文本搜索函数和操作符
