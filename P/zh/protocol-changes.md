# 54.10. 自协议 2.0 以来的变化总结

54.10. 自协议 2.0 以来的变化总结
版本：
纠错本页面
搜索
目录导航
❮
❯
54.10. 自协议 2.0 以来的变化总结 #
本节为那些试图将现有客户端库更新到协议 3.0 的开发人员提供了一个快速变更清单。
初始启动数据包使用灵活的字符串列表格式，而不是固定格式。请注意，现在可以直接在启动数据包中指定运行时参数的会话默认值。
（实际上，以前可以使用options字段来做到这一点，但考虑到options的有限宽度以及缺乏引用值中空格的任何方法，这并不是一种非常安全的技术。）
所有消息现在都在消息类型字节后面立即跟着长度计数（除了启动数据包，它们没有类型字节）。另外请注意，PasswordMessage 现在有一个类型字节。
ErrorResponse 和 NoticeResponse（'E' 和 'N'）
消息现在包含多个字段，客户端代码可以从中组装出所需级别的错误消息。请注意，
单个字段通常不会以换行符结尾，而在旧协议中发送的单个字符串总是以换行符结尾。
ReadyForQuery（'Z'）消息包括事务状态指示器。
二进制行和数据行消息类型之间的区别已经消失；单个数据行消息类型用于以所有格式返回数据。
请注意，DataRow 的布局已更改，以使其更容易解析。
此外，二进制值的表示已更改：它不再直接与服务器的内部表示形式绑定。
有一个新的“扩展查询”子协议，它增加了前端消息类型Parse、Bind、Execute、Describe、Close、Flush和Sync，
以及后端消息类型ParseComplete、BindComplete、PortalSuspended、ParameterDescription、NoData和CloseComplete。
现有客户端不必关心这个子协议，但利用它可能会提高性能或功能。
COPY 数据现在被封装到 CopyData 和 CopyDone 消息中。
在 COPY 过程中，有一种明确定义的方式来从错误中恢复。
特殊的 “\.” 最后一行不再需要，并且在 COPY OUT 过程中不会发送。
（在文本模式 COPY IN 过程中仍然被识别为终止符，但在 CSV 模式下不再如此。
文本模式的行为已被弃用，可能最终会被移除。）支持二进制 COPY。
CopyInResponse 和 CopyOutResponse 消息包含指示列数和每列格式的字段。
FunctionCall和FunctionCallResponse消息的布局已更改。
FunctionCall现在可以支持将NULL参数传递给函数。它还可以处理以文本或二进制格式传递参数和检索结果。
不再需要考虑FunctionCall可能存在安全漏洞，因为它不提供对内部服务器数据表示的直接访问。
后端在连接启动期间向客户端库发送ParameterStatus（'S'）消息，以传达其认为对客户端库有趣的所有参数。
随后，每当这些参数中任何一个的活动值发生变化时，都会发送ParameterStatus消息。
RowDescription（'T'）消息携带了描述行的每列的新表OID和列号字段。它还显示了每列的格式代码。
CursorResponse（'P'）消息不再由后端生成。
NotificationResponse（'A'）消息有一个额外的字符串字段，可以携带一个“有效负载”字符串，
从NOTIFY事件发送者传递过来。
EmptyQueryResponse（'I'）消息曾包含一个空字符串参数；现已移除。
上一页 上一级 下一页54.9. 逻辑复制消息格式 起始页 第 55 章 PostgreSQL编码习惯
