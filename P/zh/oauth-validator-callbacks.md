# 50.3. OAuth 验证器回调

50.3. OAuth 验证器回调
版本：
纠错本页面
搜索
目录导航
❮
❯
50.3. OAuth 验证器回调 #50.3.1. 启动回调50.3.2. 验证回调50.3.3. 关闭回调
OAuth 验证器模块通过定义一组回调来实现其功能。服务器将在需要时调用它们以处理
来自用户的身份验证请求。
50.3.1. 启动回调 #
startup_cb 回调在加载模块后直接执行。此回调可用于设置本地状态
并在需要时执行额外的初始化。如果验证模块有状态，它可以使用
state->private_data 来存储它。
typedef void (*ValidatorStartupCB) (ValidatorModuleState *state);
50.3.2. 验证回调 #
validate_cb 回调在用户尝试使用 OAuth 进行身份验证时在 OAuth
交换期间执行。之前调用中设置的任何状态将在 state->private_data 中可用。
typedef bool (*ValidatorValidateCB) (const ValidatorModuleState *state,
const char *token, const char *role,
ValidatorModuleResult *result);
token 将包含要验证的持有者令牌。
PostgreSQL 已确保令牌在语法上是格式良好的，但未执行其他验证。
role 将包含用户请求登录的角色。回调必须在 result 结构中设置输出参数，该结构定义如下：
typedef struct ValidatorModuleResult
{
bool        authorized;
char       *authn_id;
} ValidatorModuleResult;
只有当模块将 result->authorized 设置为 true 时，连接才会继续。
要验证用户，经过身份验证的用户名（根据令牌确定）应被 palloc 并返回在 result->authn_id 字段中。
另外，如果令牌有效但无法确定相关的用户身份，result->authn_id 可以设置为 NULL。
验证器可以返回 false 来表示内部错误，
在这种情况下，任何结果参数都将被忽略，连接将失败。
否则，验证器应返回 true 以指示
它已处理令牌并做出了授权决策。
validate_cb 返回后的行为取决于
特定的 HBA 设置。 通常，result->authn_id 用户名
必须与用户登录时的角色完全匹配。 （此
行为可以通过用户映射进行修改。） 但是在使用
delegate_ident_mapping 开启的 HBA 规则进行身份验证时，
PostgreSQL 将根本不对
result->authn_id 的值进行任何检查；在这种情况下，
由验证器确保令牌具有足够的权限，以便用户能够
在指定的 role 下登录。
50.3.3. 关闭回调 #
shutdown_cb 回调在与连接相关联的后端
进程退出时执行。如果验证器模块有任何分配的状态，则此回调应释放它以避免资源泄漏。
typedef void (*ValidatorShutdownCB) (ValidatorModuleState *state);
上一页 上一级 下一页50.2. 初始化函数 起始页 部分 VI. 参考
