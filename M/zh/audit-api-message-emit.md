# 6.4.6 审计消息组件_MySQL 8.0 参考手册

6.4.6 审计消息组件_MySQL 8.0 参考手册
Skip to Main Content
Documentation
MySQL手册
MySQL企业版
工作台
InnoDB集群
MySQL NDB集群
连接器
Section Menu:
Documentation Home
MySQL 8.0 参考手册
前言和法律声明
第一章 一般信息
第 2 章安装和升级 MySQL
第 3 章教程
第 4 章 MySQL 程序
第 5 章 MySQL 服务器管理
第 6 章 安全
6.1 一般安全问题
6.2 访问控制和账户管理
6.3 使用加密连接
6.4 安全组件和插件
6.4.1 认证插件1
6.4.2 连接控制插件1
6.4.3 密码验证组件1
6.4.4 MySQL 密钥环1
6.4.5 MySQL企业审计1
6.4.6 审计消息组件1
6.4.7 MySQL 企业防火墙1
6.5 MySQL 企业数据屏蔽和去标识化
6.6 MySQL企业加密
6.7 SELinux
6.8 FIPS 支持
第 7 章备份与恢复
第8章优化
第9章语言结构
第 10 章字符集、排序规则、Unicode
第 11 章数据类型
第 12 章函数和运算符
第 13 章 SQL 语句
第14章MySQL数据字典
第 15 章 InnoDB 存储引擎
第 16 章替代存储引擎
第十七章复制
第十八章 组复制
第十九章MySQL Shell
第 20 章使用 MySQL 作为文档存储
第21章InnoDB Cluster
第 22 章 InnoDB 副本集
第 23 章 MySQL NDB Cluster 8.0
第24章分区
第25章存储对象
第 26 章 INFORMATION_SCHEMA 表
第 27 章 MySQL 性能模式
第 28 章 MySQL 系统模式
第 29 章连接器和 API
第30章MySQL企业版
第31章MySQL工作台
第 32 章 OCI 市场上的 MySQL
附录 A MySQL 8.0 常见问题解答
附录 B 错误信息和常见问题
附录 C 索引
MySQL 词汇表
MySQL 8.0 参考手册  / 第 6 章 安全  / 6.4 安全组件和插件  /
6.4.6 审计消息组件
6.4.6 审计消息组件
从 MySQL 8.0.14 开始，该audit_api_message_emit
组件使应用程序能够使用函数将自己的消息事件添加到审计日志中
audit_api_message_emit_udf()
。
该audit_api_message_emit组件与所有审计类型的插件合作。具体而言，示例使用
第 6.4.5 节“MySQL 企业审计”audit_log中描述的插件
。
安装或卸载审计消息组件审核消息功能
安装或卸载审计消息组件
要被服务器使用，组件库文件必须位于MySQL插件目录（由plugin_dir系统变量命名的目录）中。plugin_dir如有必要，通过在服务器启动时
设置值来配置插件目录位置
。
要安装该audit_api_message_emit
组件，请使用以下语句：
INSTALL COMPONENT "file://component_audit_api_message_emit";
组件安装是一次性操作，不需要在每次服务器启动时都完成。INSTALL
COMPONENT加载组件，并将其注册到mysql.component系统表中，以便在后续服务器启动期间加载它。
要卸载该audit_api_message_emit
组件，请使用以下语句：
UNINSTALL COMPONENT "file://component_audit_api_message_emit";
UNINSTALL COMPONENT卸载组件，并从
mysql.component系统表中注销它，以使其在后续服务器启动期间不被加载。
因为安装和卸载
audit_api_message_emit组件就是安装和卸载
audit_api_message_emit_udf()
组件实现的功能，所以没有必要使用CREATE
FUNCTION或
DROP FUNCTION
这样做。
审核消息功能
本节介绍
组件audit_api_message_emit_udf()
实现的功能
audit_api_message_emit。
在使用审计消息功能之前，请按照
安装或卸载审计消息组件中的说明安装审计消息组件。
audit_api_message_emit_udf(component,
producer,
message[,
key,
value] ...)
将消息事件添加到审计日志。消息事件包括调用者选择的组件、生产者和消息字符串，以及可选的一组键值对。
此函数发布的事件将发送到所有已启用的审计类型插件，每个插件都根据自己的规则处理事件。如果没有启用审核类型的插件，则发布事件无效。
参数：
component：指定组件名称的字符串。
producer：指定生产者名称的字符串。
message：指定事件消息的字符串。
key,
value: 事件可能包含 0 个或多个指定任意应用程序提供的数据映射的键值对。每个
key参数都是一个字符串，为紧随其后的
value参数指定名称。每个
value参数为其紧随其后的参数指定一个值
key。每个
value都可以是字符串或数值，或NULL.
返回值：
OK指示成功
的字符串。如果函数失败，则会发生错误。
例子：
mysql> SELECT audit_api_message_emit_udf('component_text',
'producer_text',
'message_text',
'key1', 'value1',
'key2', 123,
'key3', NULL) AS 'Message';
+---------+
| Message |
+---------+
| OK      |
+---------+
附加信息：
每个接收由发布的事件的审计插件都会以
audit_api_message_emit_udf()
特定于插件的格式记录事件。例如，
audit_log插件（参见
第 6.4.5 节，“MySQL Enterprise Audit”）记录消息值如下，具体取决于
audit_log_format系统变量配置的日志格式：
JSON 格式 ( audit_log_format=JSON):
{
...
"class": "message",
"event": "user",
...
"message_data": {
"component": "component_text",
"producer": "producer_text",
"message": "message_text",
"map": {
"key1": "value1",
"key2": 123,
"key3": null
}
}
}
新式 XML 格式 ( audit_log_format=NEW):
<AUDIT_RECORD>
...
<NAME>Message</NAME>
...
<COMMAND_CLASS>user</COMMAND_CLASS>
<COMPONENT>component_text</COMPONENT>
<PRODUCER>producer_text</PRODUCER>
<MESSAGE>message_text</MESSAGE>
<MAP>
<ELEMENT>
<KEY>key1</KEY>
<VALUE>value1</VALUE>
</ELEMENT>
<ELEMENT>
<KEY>key2</KEY>
<VALUE>123</VALUE>
</ELEMENT>
<ELEMENT>
<KEY>key3</KEY>
<VALUE/>
</ELEMENT>
</MAP>
</AUDIT_RECORD>
旧式 XML 格式 ( audit_log_format=OLD):
<AUDIT_RECORD
...
NAME="Message"
...
COMMAND_CLASS="user"
COMPONENT="component_text"
PRODUCER="producer_text"
MESSAGE="message_text"/>
笔记
由于这种格式强加的表示限制，以旧式 XML 格式记录的消息事件不包括键值映射。
发布的消息
audit_api_message_emit_udf()
有一个事件类
MYSQL_AUDIT_MESSAGE_CLASS和一个子类MYSQL_AUDIT_MESSAGE_USER。（内部生成的审核消息具有相同的类和子类MYSQL_AUDIT_MESSAGE_INTERNAL；此子类当前未使用。）要在
audit_log过滤规则中引用此类事件，请使用
值为 的class元素
。例如：
namemessage{
"filter": {
"class": {
"name": "message"
}
}
}
如果有必要区分用户生成的和内部生成的消息事件，请
根据或测试该subclass值
。
userinternal
不支持基于键值映射的内容进行过滤。
有关编写过滤规则的信息，请参阅
第 6.4.5.7 节，“审计日志过滤”。
© Mysql 中文网
