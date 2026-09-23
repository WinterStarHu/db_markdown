# 54.3. SASL 认证

54.3. SASL 认证
版本：
纠错本页面
搜索
目录导航
❮
❯
54.3. SASL 认证 #54.3.1. SCRAM-SHA-256 认证54.3.2. OAUTHBEARER 身份验证
SASL 是一种用于面向连接协议的身份验证框架。
目前，PostgreSQL 实现了三种 SASL 身份验证机制：
SCRAM-SHA-256、SCRAM-SHA-256-PLUS 和 OAUTHBEARER。未来可能会添加更多。
以下步骤说明了 SASL 身份验证的一般执行方式，而接下来的小节将提供
有关特定机制的更多详细信息。
SASL 认证消息流
要开始一个 SASL 认证交换，服务器发送一个 AuthenticationSASL 消息。它包括服务器可以接受的 SASL 认证机制列表，按照服务器的首选顺序排列。
客户端从列表中选择一个支持的机制，并向服务器发送一个 SASLInitialResponse 消息。该消息包括所选机制的名称，以及如果所选机制使用的话，还包括一个可选的初始客户端响应。
一个或多个服务器挑战和客户端响应消息将随后而来。每个服务器挑战都是在一个
AuthenticationSASLContinue 消息中发送的，随后是客户端在一个 SASLResponse
消息中的响应。这些消息的具体内容是特定于机制的。
最后，当身份验证交换成功完成时，服务器发送一个可选的
AuthenticationSASLFinal 消息，紧接着发送 AuthenticationOk 消息。
AuthenticationSASLFinal 包含额外的服务器到客户端数据，其内容特定于所选的
身份验证机制。如果身份验证机制不使用在完成时发送的额外数据，则不发送
AuthenticationSASLFinal 消息。
在错误情况下，服务器可以在任何阶段中止认证，并发送一个ErrorMessage。
54.3.1. SCRAM-SHA-256 认证 #
SCRAM-SHA-256 及其带通道绑定的变体
SCRAM-SHA-256-PLUS 是基于密码的身份验证机制。
它们在 RFC 7677
和 RFC 5802 中有详细描述。
当在 PostgreSQL 中使用 SCRAM-SHA-256 时，服务器将忽略客户端在
client-first-message 中发送的用户名。
而是使用已经在启动消息中发送的用户名。
PostgreSQL 支持多种字符编码，而 SCRAM 规定用户名必须使用 UTF-8，
因此可能无法用 UTF-8 表示 PostgreSQL 用户名。
SCRAM 规范规定密码也必须是 UTF-8 编码，并且使用 SASLprep 算法处理。
然而，PostgreSQL 不要求密码必须使用 UTF-8 编码。
当用户设置密码时，无论实际使用的编码是什么，都会像使用 UTF-8 一样使用 SASLprep 进行处理。
但是，如果密码不是合法的 UTF-8 字节序列，或者包含 SASLprep 算法禁止的 UTF-8 字节序列，
则会使用原始密码而不进行 SASLprep 处理，而不是抛出错误。这样可以在密码为 UTF-8 时对其进行规范化，
但仍允许使用非 UTF-8 密码，并且不需要系统知道密码使用的编码方式。
Channel binding 在支持 SSL 的 PostgreSQL 构建中受支持。
带有通道绑定的 SCRAM 的 SASL 机制名称是 SCRAM-SHA-256-PLUS。
PostgreSQL 使用的通道绑定类型是 tls-server-end-point。
在没有通道绑定的SCRAM中，服务器选择一个随机数，
传输给客户端，与用户提供的密码在传输的密码哈希中混合。虽然这可以
防止密码哈希在后续会话中被成功重新传输，但无法阻止真实服务器和客
户端之间的虚假服务器通过服务器的随机值并成功进行身份验证。
SCRAM与通道绑定一起防止这种中间人攻击，通过将服务器证书的签名混合到传输的密码哈希中。
虽然伪造服务器可以重新传输真实服务器的证书，但它无法访问与该证书匹配的私钥，因此无法证明自己是所有者，导致SSL连接失败。
示例
服务器发送一个AuthenticationSASL消息。它包括服务器可以接受的SASL认证机制列表。
如果服务器构建时支持SSL，这将是SCRAM-SHA-256-PLUS和SCRAM-SHA-256，
否则只是后者。
客户端通过发送SASLInitialResponse消息做出响应，该消息指示选择的机制，SCRAM-SHA-256或SCRAM-SHA-256-PLUS。
（客户端可以自由选择任一机制，但为了更好的安全性，如果支持的话应选择通道绑定变体。）
在初始客户端响应字段中，消息包含SCRAM client-first-message。
client-first-message还包含客户端选择的通道绑定类型。
服务器发送一个AuthenticationSASLContinue消息，其中包含一个SCRAMserver-first-message作为内容。
客户端发送一个SASLResponse消息，其中包含SCRAM
client-final-message作为内容。
服务器发送一个AuthenticationSASLFinal消息，带有SCRAM
server-final-message，紧接着是一个AuthenticationOk消息。
54.3.2. OAUTHBEARER 身份验证 #
OAUTHBEARER 是一种基于令牌的联合身份验证机制。
它在 RFC 7628 中有详细描述。
典型的交换过程取决于客户端是否已经为当前用户缓存了
令牌。如果没有，交换将通过两个连接进行：第一个“发现”连接
用于从服务器获取 OAuth 元数据，第二个连接用于在客户端获取令牌后发送
令牌。（libpq 目前并未在其内置流程中实现缓存方法，因此使用
两个连接进行交换。）
该机制由客户端发起，类似于 SCRAM。客户端的初始响应
包含 SCRAM 使用的标准 "GS2" 头，后面跟着一系列
key=value 对。当前服务器支持的唯一键是
auth，它包含承载令牌。
OAUTHBEARER 还指定了客户端初始响应的三个可选
组件（GS2 头的 authzid，以及
host 和
port 键），这些组件当前被
服务器忽略。
OAUTHBEARER 不支持通道绑定，也没有
"OAUTHBEARER-PLUS" 机制。该机制在成功认证期间不使用
服务器数据，因此在交换中不使用 AuthenticationSASLFinal 消息。
示例
在第一次交换中，服务器发送带有
OAUTHBEARER 机制的 AuthenticationSASL 消息。
客户端通过发送一个指示
OAUTHBEARER 机制的 SASLInitialResponse 消息进行响应。
假设客户端当前用户没有有效的承载令牌，
auth 字段为空，表示一个发现
连接。
服务器发送一个包含错误
status 的 AuthenticationSASLContinue 消息，以及一个
客户端应使用的知名 URI 和范围来进行 OAuth 流程。
客户端发送一个包含空集合（一个单独的
0x01 字节）的 SASLResponse 消息，以完成其发现
交换的一半。
服务器发送一个 ErrorMessage 以使第一次交换失败。
此时，客户端进行多种可能的 OAuth 流程之一以
获取承载令牌，使用任何它已配置的元数据
以及服务器提供的元数据。（此描述故意模糊；
OAUTHBEARER 并未指定或强制任何特定的方法来获取令牌。）
一旦获得令牌，客户端重新连接到服务器进行最终
交换：
服务器再次发送带有
OAUTHBEARER 机制的 AuthenticationSASL 消息。
客户端通过发送一个 SASLInitialResponse 消息进行响应，
但这次消息中的 auth 字段包含
在客户端流程中获得的承载令牌。
服务器根据令牌提供者的指示验证令牌。如果客户端被授权连接，
它发送一个 AuthenticationOk 消息以结束 SASL 交换。
上一页 上一级 下一页54.2. 消息流 起始页 54.4. 流复制协议
