# 50.2. 初始化函数

50.2. 初始化函数
版本：
纠错本页面
搜索
目录导航
❮
❯
50.2. 初始化函数 #
OAuth 验证器模块是从 oauth_validator_libraries 列出的共享
库动态加载的。模块在登录过程中请求时按需加载。
使用正常的库搜索路径来定位库。为了提供验证器回调并指示该库是一个 OAuth
验证器模块，必须提供一个名为
_PG_oauth_validator_module_init 的函数。
该函数的返回值必须是指向类型为
OAuthValidatorCallbacks 的结构的指针，该结构包含一个魔数
和指向模块的令牌验证函数的指针。返回的指针必须具有服务器生命周期，
通常通过在全局作用域中将其定义为 static const 变量来实现。
typedef struct OAuthValidatorCallbacks
{
uint32        magic;            /* 必须设置为 PG_OAUTH_VALIDATOR_MAGIC */
ValidatorStartupCB startup_cb;
ValidatorShutdownCB shutdown_cb;
ValidatorValidateCB validate_cb;
} OAuthValidatorCallbacks;
typedef const OAuthValidatorCallbacks *(*OAuthValidatorModuleInit) (void);
仅 validate_cb 回调是必需的，其他的都是可选的。
上一页 上一级 下一页50.1. 安全设计验证器模块 起始页 50.3. OAuth 验证器回调
