# 38.5. 数据库登录事件触发器示例

38.5. 数据库登录事件触发器示例
版本：
纠错本页面
搜索
目录导航
❮
❯
38.5. 数据库登录事件触发器示例 #
触发login事件的事件触发器对于记录用户登录、验证连接、
根据当前情况分配角色或初始化会话数据非常有用。非常重要的是，任何使用
login事件的事件触发器在执行写操作之前都必须检查数据库
是否处于恢复状态。写入备用服务器将导致其无法访问。
以下示例演示了这些选项。
-- create test tables and roles
CREATE TABLE user_login_log (
"user" text,
"session_start" timestamp with time zone
);
CREATE ROLE day_worker;
CREATE ROLE night_worker;
-- the example trigger function
CREATE OR REPLACE FUNCTION init_session()
RETURNS event_trigger SECURITY DEFINER
LANGUAGE plpgsql AS
$$
DECLARE
hour integer = EXTRACT('hour' FROM current_time at time zone 'utc');
rec boolean;
BEGIN
-- 1. Forbid logging in between 2AM and 4AM.
IF hour BETWEEN 2 AND 4 THEN
RAISE EXCEPTION 'Login forbidden';
END IF;
-- The checks below cannot be performed on standby servers so
-- ensure the database is not in recovery before we perform any
-- operations.
SELECT pg_is_in_recovery() INTO rec;
IF rec THEN
RETURN;
END IF;
-- 2. Assign some roles. At daytime, grant the day_worker role, else the
-- night_worker role.
IF hour BETWEEN 8 AND 20 THEN
EXECUTE 'REVOKE night_worker FROM ' || quote_ident(session_user);
EXECUTE 'GRANT day_worker TO ' || quote_ident(session_user);
ELSE
EXECUTE 'REVOKE day_worker FROM ' || quote_ident(session_user);
EXECUTE 'GRANT night_worker TO ' || quote_ident(session_user);
END IF;
-- 3. Initialize user session data
CREATE TEMP TABLE session_storage (x float, y integer);
ALTER TABLE session_storage OWNER TO session_user;
-- 4. Log the connection time
INSERT INTO public.user_login_log VALUES (session_user, current_timestamp);
END;
$$;
-- trigger definition
CREATE EVENT TRIGGER init_session
ON login
EXECUTE FUNCTION init_session();
ALTER EVENT TRIGGER init_session ENABLE ALWAYS;
上一页 上一级 下一页38.4. 一个表重写事件触发器示例 起始页 第 39 章 规则系统
