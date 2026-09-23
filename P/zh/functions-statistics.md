# 9.31. 统计信息函数

9.31. 统计信息函数
版本：
纠错本页面
搜索
目录导航
❮
❯
9.31. 统计信息函数 #9.31.1. 检查MCV列表
PostgreSQL提供了一个函数来检查使用CREATE STATISTICS命令定义的复杂统计。
9.31.1. 检查MCV列表 #
pg_mcv_list_items ( pg_mcv_list ) → setof record
pg_mcv_list_items返回一组记录，描述存储在多列MCV列表中的所有项目。它返回以下列:
名称类型描述indexinteger在MCV列表中的项目索引valuestext[]存储在MCV项目中的值nullsboolean[]标识NULL值的标志frequencydouble precision该MCV项目的频率base_frequencydouble precision该MCV项目的基本频率
pg_mcv_list_items函数可以这样使用:
SELECT m.* FROM pg_statistic_ext join pg_statistic_ext_data on (oid = stxoid),
pg_mcv_list_items(stxdmcv) m WHERE stxname = 'stts';
pg_mcv_list类型的值只能从pg_statistic_ext_data.stxdmcv列中获取。
上一页 上一级 下一页9.30. 事件触发器函数 起始页 第 10 章 类型转换
