# 32.20. OAuth 支持

32.20. OAuth 支持
版本：
纠错本页面
搜索
目录导航
❮
❯
32.20. OAuth 支持 #32.20.1. Authdata 钩子32.20.2. 调试和开发者设置
libpq 实现了对 OAuth v2 设备授权客户端流程的支持，
该流程在 RFC 8628 中有文档说明，
作为一个可选模块。有关如何启用设备授权作为内置流程的支持的信息，
请参见 安装文档。
当支持被启用且可选模块已安装时，libpq
将默认使用内置流程，如果服务器在身份验证期间
请求一个承载令牌。即使在运行客户端应用程序的系统上没有可用的网页浏览器，
例如通过 SSH 运行客户端时，也可以利用此流程。
默认情况下，内置流程将打印一个 URL 以访问和一个用户代码以输入：
$ psql 'dbname=postgres oauth_issuer=https://example.com oauth_client_id=...'
访问 https://example.com/device 并输入代码： ABCD-EFGH
（此提示可以
自定义。）
用户将登录到他们的 OAuth 提供者，系统会询问是否允许 libpq 和服务器代表他们执行操作。在继续之前，
仔细检查显示的 URL 和权限，以确保它们符合预期，始终是一个好主意。权限不应授予不受信任的第三方。
客户端应用程序可以实现自己的流程，以自定义与应用程序的交互和集成。
有关如何向 libpq 添加自定义流程的更多信息，请参见 第 32.20.1 节。
要使 OAuth 客户端流程可用，连接字符串至少必须包含
oauth_issuer 和
oauth_client_id。 （这些设置由您组织的 OAuth 提供者确定。）
内置流程还要求 OAuth 授权服务器发布设备授权端点。
注意
内置设备授权流程目前在 Windows 上不受支持。
仍然可以实现自定义客户端流程。
32.20.1. Authdata 钩子 #
OAuth 流程的行为可以通过客户端使用以下钩子 API 进行修改或替换：
PQsetAuthDataHook #
设置 PGauthDataHook，覆盖
libpq 对其 OAuth 客户端流程的一个或多个方面的处理。
void PQsetAuthDataHook(PQauthDataHook_type hook);
如果 hook 为 NULL，则
默认处理程序将被重新安装。否则，应用程序将传递
一个指向回调函数的指针，其签名为：
int hook_fn(PGauthData type, PGconn *conn, void *data);
当需要应用程序执行某个操作时，libpq 将调用该函数。type 描述
正在进行的请求，conn 是正在进行身份验证的
连接句柄，而 data 指向请求特定的元数据。该指针的内容由
type 决定；请参见
第 32.20.1.1 节 以获取支持的
列表。
钩子可以串联在一起，以允许协作和/或回退
行为。一般来说，钩子实现应检查传入的
type（以及可能的请求元数据
和/或特定于所用 conn 的设置）以决定是否处理特定的 authdata。
如果不处理，则应委托给链中的前一个钩子
（可通过 PQgetAuthDataHook 检索）。
成功通过返回大于零的整数来指示。
返回负整数表示错误条件并放弃连接尝试。
（零值保留用于默认实现。）
PQgetAuthDataHook #
检索当前的 PGauthDataHook 值。
PQauthDataHook_type PQgetAuthDataHook(void);
在初始化时（在第一次调用
PQsetAuthDataHook 之前），此函数将返回
PQdefaultAuthDataHook。
32.20.1.1. 钩子类型 #
定义了以下 PGauthData 类型及其对应的
data 结构：
PQAUTHDATA_PROMPT_OAUTH_DEVICE
#
替换内置设备授权客户端流程中的默认用户提示。data 指向
一个 PGpromptOAuthDevice 的实例：
typedef struct _PGpromptOAuthDevice
{
const char *verification_uri;   /* 要访问的验证 URI */
const char *user_code;          /* 用户输入的代码 */
const char *verification_uri_complete;  /* 可选的 URI 和
* 代码的组合，或 NULL */
int         expires_in;         /* 用户代码过期的秒数 */
} PGpromptOAuthDevice;
OAuth 设备授权流程
可以包含
在 libpq 中，
需要最终用户使用浏览器访问一个 URL，然后输入一个代码
以允许 libpq 代表他们连接到服务器。默认提示只是将
verification_uri 和 user_code
打印到标准错误。替代实现可以使用任何首选方法显示此
信息，例如使用 GUI。
此回调仅在内置设备
授权流程中调用。如果应用程序安装了
自定义 OAuth
流程，或者 libpq 没有构建
支持内置流程，则此 authdata 类型将不会被使用。
如果提供了非 NULL 的 verification_uri_complete，
则可以选择用于非文本验证（例如，通过显示 QR 码）。在这种情况下，URL 和用户代码仍应显示给最终用户，
因为代码将由提供者手动确认，而 URL 使用户即使无法使用非文本方法也能继续。有关更多信息，
请参见
RFC 8628 中的第 3.3.1 节。
PQAUTHDATA_OAUTH_BEARER_TOKEN
#
添加自定义实现的流程，如果
已安装，则替换内置流程。
钩子应直接返回当前用户/发行者/范围组合的 Bearer 令牌（如果可以在不阻塞的情况下获得），
或者设置异步回调以检索一个。
data 指向一个 PGoauthBearerRequest 的实例，
应由实现填充：
typedef struct PGoauthBearerRequest
{
/* 钩子输入（在所有调用中保持不变） */
const char *openid_configuration; /* OIDC 发现 URL */
const char *scope;                /* 所需的范围，或 NULL */
/* 钩子输出 */
/*
* 实现自定义异步 OAuth 流程的回调。签名是
* 平台相关的：PQ_SOCKTYPE 在 Windows 上是 SOCKET，在其他地方是 int。
*/
PostgresPollingStatusType (*async) (PGconn *conn,
struct PGoauthBearerRequest *request,
PQ_SOCKTYPE *altsock);
/* 清理自定义分配的回调。 */
void        (*cleanup) (PGconn *conn, struct PGoauthBearerRequest *request);
char       *token;   /* 获取的 Bearer 令牌 */
void       *user;    /* 钩子定义的分配数据 */
} PGoauthBearerRequest;
libpq 向钩子提供了两条信息：
openid_configuration 包含描述授权服务器支持的流程的 OAuth 发现文档的 URL，
而 scope 包含访问服务器所需的（可能为空的）以空格分隔的 OAuth 范围列表。
其中一个或两个可能为 NULL，以指示信息不可发现。
（在这种情况下，实现可能能够使用其他预配置的知识来建立要求，或者选择失败。）
钩子的最终输出是 token，它必须指向一个有效的 Bearer 令牌，以便在连接中使用。 （该令牌应由 oauth_issuer 发放，并持有请求的作用域，否则连接将被服务器的验证模块拒绝。）分配的令牌字符串必须在 libpq 完成连接之前保持有效；钩子应设置一个 cleanup 回调，当 libpq 不再需要它时将被调用。
如果实现无法在初始调用钩子时立即生成 token，则应设置 async 回调以处理与授权服务器的非阻塞通信。
[16]
这将在从钩子返回后立即调用以开始流程。当回调无法在不阻塞的情况下进一步进展时，它应在设置 *altsock 为将在可以再次进行进展时标记为准备读取/写入的文件描述符后返回 PGRES_POLLING_READING 或 PGRES_POLLING_WRITING。 （该描述符随后通过 PQsocket() 提供给顶层轮询循环。）在流程完成后返回 PGRES_POLLING_OK，或返回 PGRES_POLLING_FAILED 以指示失败。
实现可能希望在调用 async 和 cleanup 回调之间存储额外的数据以进行记账。提供了 user 指针用于此目的；libpq 不会触及其内容，应用程序可以根据需要使用它。 （请记得在令牌清理期间释放任何分配。）
32.20.2. 调试和开发者设置 #
可以通过设置环境变量 PGOAUTHDEBUG=UNSAFE 来启用“危险的调试模式”。此功能仅为方便本地开发和测试而提供。它执行几项您不希望生产系统执行的操作：
允许在 OAuth 提供者交换期间使用未加密的 HTTP
允许使用 PGOAUTHCAFILE 环境变量完全替换系统的受信任 CA 列表
在 OAuth 流程中将 HTTP 流量（包含多个关键秘密）打印到标准错误
允许使用零秒重试间隔，这可能导致客户端忙循环并无谓地消耗 CPU
警告
不要与第三方共享 OAuth 流量的输出。它包含可以用来攻击您的客户端和服务器的秘密。
[16]
在 PQAUTHDATA_OAUTH_BEARER_TOKEN 钩子回调期间执行阻塞操作将干扰非阻塞连接 API，例如 PQconnectPoll，并阻止并发连接的进展。仅使用同步连接原语的应用程序，例如 PQconnectdb，可以在钩子期间同步检索令牌，而无需实现 async 回调，但它们必然会限制为一次一个连接。
上一页 上一级 下一页32.19. SSL 支持 起始页 32.21. 线程化程序中的行为
