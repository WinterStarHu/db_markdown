# SPI_gettypeid

SPI_gettypeid
版本：
纠错本页面
搜索
目录导航
❮
❯
SPI_gettypeidSPI_gettypeid — 返回指定列的数据类型的OID大纲
Oid SPI_gettypeid(TupleDesc rowdesc, int colnumber)
描述
SPI_gettypeid 返回指定列的数据类型的
OID。
参数TupleDesc rowdesc
输入行描述
int colnumber
列号（从 1 开始计数）
返回值
指定列的数据类型的OID，或者出错时返回
InvalidOid。出错时，
SPI_result会被设置成
SPI_ERROR_NOATTRIBUTE。
上一页 上一级 下一页SPI_gettype 起始页 SPI_getrelname
