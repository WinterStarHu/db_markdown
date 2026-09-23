# 13.6.6 游标_MySQL 8.0 参考手册

13.6.6 游标_MySQL 8.0 参考手册
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
第 7 章备份与恢复
第8章优化
第9章语言结构
第 10 章字符集、排序规则、Unicode
第 11 章数据类型
第 12 章函数和运算符
第 13 章 SQL 语句
13.1 数据定义语句
13.2 数据操作语句
13.3 事务和锁定语句
13.4 复制语句
13.5 准备好的语句
13.6 复合语句语法
13.6.1 BEGIN ... END 复合语句1
13.6.2 声明标签1
13.6.3 DECLARE 语句1
13.6.4 存储程序中的变量1
13.6.5 流量控制语句1
13.6.6 游标1
13.6.6.1 游标 CLOSE 语句
13.6.6.2 游标 DECLARE 语句
13.6.6.3 游标 FETCH 语句
13.6.6.4 游标 OPEN 语句
13.6.6.5 对服务器端游标的限制
13.6.7 条件处理1
13.6.8 条件处理的限制1
13.7 数据库管理语句
13.8 效用语句
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
MySQL 8.0 参考手册  / 第 13 章 SQL 语句  / 13.6 复合语句语法  /
13.6.6 游标
13.6.6 游标
13.6.6.1 游标 CLOSE 语句13.6.6.2 游标 DECLARE 语句13.6.6.3 游标 FETCH 语句13.6.6.4 游标 OPEN 语句13.6.6.5 对服务器端游标的限制
MySQL 支持存储程序中的游标。语法与嵌入式 SQL 中的一样。游标具有以下属性：
不敏感：服务器可能会也可能不会复制其结果表
只读：不可更新
不可滚动：只能单向遍历，不能跳行
游标声明必须出现在处理程序声明之前以及变量和条件声明之后。
例子：
CREATE PROCEDURE curdemo()
BEGIN
DECLARE done INT DEFAULT FALSE;
DECLARE a CHAR(16);
DECLARE b, c INT;
DECLARE cur1 CURSOR FOR SELECT id,data FROM test.t1;
DECLARE cur2 CURSOR FOR SELECT i FROM test.t2;
DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
OPEN cur1;
OPEN cur2;
read_loop: LOOP
FETCH cur1 INTO a, b;
FETCH cur2 INTO c;
IF done THEN
LEAVE read_loop;
END IF;
IF b < c THEN
INSERT INTO test.t3 VALUES (a,b);
ELSE
INSERT INTO test.t3 VALUES (a,c);
END IF;
END LOOP;
CLOSE cur1;
CLOSE cur2;
END;
© Mysql 中文网
