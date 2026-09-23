# TPC-DS_v4.0.0（机器翻译草稿）

> ⚠️ 术语词典粗译，SQL/代码/大写标识符保留原文，可能生硬。仅供速览。

# TPC-DS_v4.0.0

> 源文件: `T/../TPC-DS_v4.0.0.pdf`，146 页。

                                TPC BENCHMARK ™ DS




                                   Standard Specification

                                         Version 4.0.0




                                        November, 2024




              Transaction Processing Performance Council (TPC)

                                          www.tpc.org

                                          info@tpc.org

                  © 2024 Transaction Processing Performance Council

                                      All Rights Reserved




TPC Benchmark™ DS - Standard Specification, Version 4.0.0        Page 1 of 146
TPC Benchmark™ DS - Standard Specification, Version 4.0.0   Page 2 of 146
                                              Legal Notice
The TPC reserves all right, title, and interest to this document and associated source code as provided under
U.S. and international laws, including without limitation all patent and trademark rights therein.

Permission to copy without fee all or 零件 of this document is granted provided that the TPC copyright
notice, the title of the publication, and its 日期 appear, and notice is given that copying is by permission of
the Transaction Processing Performance Council. To copy otherwise requires specific permission.




                                             No Warranty
TO THE MAXIMUM EXTENT PERMITTED BY APPLICABLE LAW, THE INFORMATION CONTAINED
HEREIN IS PROVIDED “AS IS” AND WITH ALL FAULTS, AND THE AUTHORS AND DEVELOPERS OF
THE WORK HEREBY DISCLAIM ALL OTHER WARRANTIES AND CONDITIONS, EITHER EXPRESS,
IMPLIED OR STATUTORY, INCLUDING, BUT NOT LIMITED TO, ANY (IF ANY) IMPLIED
WARRANTIES, DUTIES OR CONDITIONS OF MERCHANTABILITY, OF FITNESS FOR A PARTICULAR
PURPOSE, OF ACCURACY OR COMPLETENESS OF RESPONSES, OF RESULTS, OF WORKMANLIKE
EFFORT, OF LACK OF VIRUSES, AND OF LACK OF NEGLIGENCE. ALSO, THERE IS NO WARRANTY
OR CONDITION OF TITLE, QUIET ENJOYMENT, QUIET POSSESSION, CORRESPONDENCE TO
DESCRIPTION OR NON-INFRINGEMENT WITH REGARD TO THE WORK.

IN NO EVENT WILL ANY AUTHOR OR DEVELOPER OF THE WORK BE LIABLE TO ANY OTHER
PARTY FOR ANY DAMAGES, INCLUDING BUT NOT LIMITED TO THE COST OF PROCURING
SUBSTITUTE GOODS OR SERVICES, LOST PROFITS, LOSS OF USE, LOSS OF DATA, OR ANY
INCIDENTAL, CONSEQUENTIAL, DIRECT, INDIRECT, OR SPECIAL DAMAGES WHETHER UNDER
CONTRACT, TORT, WARRANTY, OR OTHERWISE, ARISING IN ANY WAY OUT OF THIS OR ANY
OTHER AGREEMENT RELATING TO THE WORK, WHETHER OR NOT SUCH AUTHOR OR
DEVELOPER HAD ADVANCE NOTICE OF THE POSSIBILITY OF SUCH DAMAGES.




                                              Trademarks
TPC Benchmark, TPC-DS and QphDS are trademarks of the Transaction Processing Performance Council.
                                      Acknowledgments
Developing a TPC 基准测试 for a new environment requires a huge effort to conceptualize research, specify,
review, prototype, and verify the 基准测试. The TPC acknowledges the work and contributions of the TPC-DS
subcommittee member companies in developing the TPC-DS 规范.
The TPC-DS subcommittee would like to acknowledge the contributions made by the many members during the
development of the 基准测试 规范. It has taken the dedicated efforts of people across many companies,
often in addition to their regular duties. The list of significant contributors to this version includes Susanne
Englert, Mary Meredith, Sreenivas Gukal, Doug Johnson 1+2, Lubor Kollar, Murali Krishna, Bob Lane, Larry
Lutz, Juergen Mueller, Bob Murphy, Doug Nelson, Ernie Ostic, Raghunath Othayoth Nambiar, Meikel Poess,
Haider Rizvi, Bryan Smith, Eric Speed, Cadambi Sriram, Jack Stephens, John Susag, Tricia Thomas, Dave
Walrath, Shirley Wang, Guogen Zhang, Torsten Grabs, Charles Levine, Mike Nikolaiev, Alain Crolotte,
Francois Raab, Yeye He, Margaret McCarthy, Indira Patel, Daniel Pol, John Galloway, Jerry Lohr, Jerry
Buggert, Michael Brey, Nicholas Wakou, Vince Carbone, Wayne Smith, Dave Steinhoff, Dave Rorke, Dileep
Kumar, Yanpei Chen, John Poelman, and Seetha Lakshmi.



                             Document Revision History

  Date         Version    Description

  08-28-2015   2.0.0      Mail ballot version

  11-12-2015   2.1.0      • The reference to "c_dep_count" in the SELECT 子句 (4th 列 selected, right under
                            "cd_marital_status") has a typo, 应 be "cd_dep_count" (FogBugz 937)
                          • added Dave Rorke, Dileep Kumar, Yanpei Chen, John Poelman, and Seetha Lakshmi to
                            Acknowledgment 节 and added following bullet to bullet list in Clause 0.1: Run on “Big Data”
                            solutions, such as RDBMS as well as Hadoop/Spark based 系统 (FogBugz 991)
                          • increased limit for db_version 列 to 100 (dbgen_version.h), modified release information to
                            2.0.0 and added warnings for 100 and 300 scale factors and changed warning from "Warning:
                            Selected volume is NOT valid for 结果 publication" to "Warning: Selected 规模因子 is NOT
                            valid for 结果 publication" (FogBugz 1002)
                          • Fixed 查询 variant templates error in templates 18a, 22a and 27a (FogBugz 1033)
                          • Added companion document Version2CompanionDocument_final.docx (FogBugz 1053)
                          • Fix broken link in 5.1.2 to refer to 7.3.8.5 (FogBugz 1060) (FogBugz 1060)
                          • Change references in 5.3.4 and 5.3.5 to refer to Table 5-5 (FogBugz 1060)
                          • Delete Clause 7.2.5 (FogBugz 1060)
                          • Fix reference in 7.6.2 to refer to clauses 7.4.7.3 and 7.4.7.6 (FogBugz 1060)
                          • Change reference in 10.3.2.4 to refer to 2.5.3 (FogBugz 1060)
                          • Delete "isolation 要求" in 0.2 bullet d. (FogBugz 1060)
                          • Delete 10.3.4.6 (FogBugz 1060)
                          • Change 10.3.6 to read "10.3.6 Clause 7- Performance Metrics and Execution Rules Related Items"
                            (FogBugz 1060) (FogBugz 1060)
                          • refer to 7.6.3 in comment of 10.6 (FogBugz 1060)
                          • 11.2.4.1. Delete broken link wording. (FogBugz 1060)
                          • Delete from Query Template 2 (FogBugz 1121)
                          • define COUNTY=random(1, rowcount("active_counties", "store"), uniform); (FogBugz 1121)
                          • define GMT=distmember(fips_county,[COUNTY], 6) (FogBugz 1121)
                          • Delete from Query Template 17 (FogBugz 1121)
                          • define QRT = random(1,4,uniform); (FogBugz 1121)
                          • Delete from Query Template 22 (FogBugz 1121)
                          • define YEAR=random(1998,2002,uniform); (FogBugz 1121)
                          • No changes necessary for Query Template 38 (FogBugz 1121)
                          • Delete from Query Template 39 (FogBugz 1121)
                          • define CATEGORY = text({"Books",1},{"Home",1},{"Electronics",1},{"Jewelry",1},{"Sports",1});
                            (FogBugz 1121)
                     • define STATENUMBER=ulist(random(1, rowcount("active_states", "仓库"), uniform),3);
                       (FogBugz 1121)
                     • define STATEA=distmember(fips_county,[STATENUMBER.1], 3); (FogBugz 1121)
                     • define STATEB=distmember(fips_county,[STATENUMBER.2], 3); (FogBugz 1121)
                     • define STATEC=distmember(fips_county,[STATENUMBER.3], 3); (FogBugz 1121)
                     • Delete from template 51 (FogBugz 1121)
                     • define YEAR = random(1998, 2002, uniform); (FogBugz 1121)
                     • Delete from template 59 (FogBugz 1121)
                     • define YEAR=random(1998,2001,uniform); (FogBugz 1121)
                     • Delete from template 62 (FogBugz 1121)
                     • define YEAR = random(1998,2002,uniform); (FogBugz 1121)
                     • Delete from template 63 (FogBugz 1121)
                     • define year = random(1998,2002,uniform); (FogBugz 1121)
                     • Delete from template 67 (FogBugz 1121)
                     • define YEAR = random(1998, 2002, uniform); (FogBugz 1121)
                     • Delete from template 71 (FogBugz 1121)
                     • define MANAGER=random(1,100,uniform); (FogBugz 1121)
                     • Delete from template 87 (FogBugz 1121)
                     • define YEAR= random(1998, 2002, uniform); (FogBugz 1121)
                     • Delete from template 97 (FogBugz 1121)
                     • define YEAR=random(1998,2002, uniform); (FogBugz 1121)
                     • Delete from template 99 (FogBugz 1121)
                     • define YEAR=random(1998,2002,uniform); (FogBugz 1121)
                     • Revised How To Document for TPC-DS tools (FogBugz 1128)
                     • Modified 查询 variant 22a.tpl (FogBugz 1135)
                     • Modified 查询 variant 70a.tpl (1136)
06-09-2016   2.2.0   • Query 14_NULLS_FIRST.ans (FogBugz 1571)
                     • Modified 查询 template 84 (FogBugz 1559)
                     • Modified answer set for Query 11 (FogBugz 1539)
                     • Add Clause 3.4.5 The 输出 of dsdgen is text. The content of each 字段 is terminated by '|'. A '|' in
                       the first position of a 行 indicates that the first 列 of the 行 is empty. Two consecutive '|'
                       indicate that the given 列 值 is empty. Empty 列 值 are only generated for
                       列 that are NULL-able as specified in the logical 数据库 design. Empty 列 值, as
                       generated by dsdgen, 必须 treated as NULL 值 in the data processing 系统, i.e. the data
                       processing 系统 必须 able to retrieve NULL-able 列 using 'is null' predicates (FogBugz
                       1538)
                     • Added bullet in 3.4.5 i) NULLs must always be printed by the same string pattern of zero or
                       more characters (FogBugz 1538)
                     • Added the following comment to Clause 7.5.2 Comment: Since the reference answer set
                       provided in the 规范 originated from different data processing 系统, the reference
                       answer set does not consistently express NULL 值 with the same string pattern. (FogBugz
                       1538)
                     • Modified answer set for Query 27 (FogBugz 1537)
                     • changed "• BPTWO.01 = unknown to • BPTWO.01 = Unknown" in the 规范 and
                       "define BPTWO= text({"0-500",1},{"unknown",1},{"5001-10000",1}); to define BPTWO= text({"0-
                       500",1},{"Unknown",1},{"5001-10000",1});" in 查询 template 34 (FogBugz 1531)
                     • Modified answer sets q34.ans_nulls_first and q34.ans_nulls_last (FogBugz 1531 and 1470)
                     • Modified changes to queries 18 and 49 as suggested(FogBugz 1502)
                     • Made changes to B.4, B.29, B.48, B.73, B.74, B.92, B93 and B.97 (FogBugz 1501)
                     • Made changes to Clause 4.2.3.4 (FogBugz 1480)
                     • Changed qualification parameter substitution in Query Template 4 as follows: YEAR.01=2001 and
                       SELECTCONE.01= t_s_secyear.客户_preferred_cust_flag (FogBugz 1479)
                     • Modified answers sets for q98_nulls_first and q98_nulls_last (FogBugz 1474)
                     • Change substitution parameter for Query 73 in 规范 as follows:
                          • COUNTY_D.01 = Orange County
                          • COUNTY_C.01 = Bronx County
                          • COUNTY_B.01 = Franklin Parish
                          • COUNTY_A.01 = Williamson County
                          • YEAR.01 = 1999
                          • BPTWO.01 = Unknown
                          • BPONE.01 = >10000
                     • And changed template parameter definitions as follows:
                           •    define BPONE= text({"1001-5000",1},{">10000",1},{"501-1000",1});
                           •    define BPTWO= text({"0-500",1},{"Unknown",1},{"5001-10000",1});
                           •    define YEAR= random(1998, 2000, uniform);
                           •    define COUNTYNUMBER=ulist(random(1, rowcount("active_counties", "store"),
                                uniform),8);
                            • define COUNTY_A=distmember(fips_county, [COUNTYNUMBER.1], 2);
                            • define COUNTY_B=distmember(fips_county, [COUNTYNUMBER.2], 2);
                            • define COUNTY_C=distmember(fips_county, [COUNTYNUMBER.3], 2);
                            • define COUNTY_D=distmember(fips_county, [COUNTYNUMBER.4], 2); (FogBugz 1473)
                     •   Modified answer set for Query 58 (FogBugz 1472)
                     •   Corrected Version number in tool files (FogBugz 1393)
                     •   Modified lines 35-36 in w_store_sales.h contain: #define W_STORE_SLAES_H to #define
                         W_STORE_SALES_H (FogBugz 1322)
                     •   Removed comments in Clause 4.1.1.8 (FogBugz1263)
08-05-2016   2.3.0   •   Changed 1 digit numbering to 2 digit numbering in B48, change YEAR.02 = 2002 to YEAR.01 =
                         2002 in B75 and "NULLCOLCS01 = cs_ship_addr_sk" to "NULLCOLCS.01 = cs_ship_addr_sk" in
                         B76 (FogBugz 1676)
                     •   Changed:
                            • B.1 change AGGFIELD.01 to AGG_FIELD.01
                            • B.4: SELECTCONE typo; 应 be SELECTONE
                            • B.11: SELECTONE 值 has a ":q" interposed; 应 be removed
                            • B.35: qualification parameters are not bulleted; 应 be bulleted
                     •   B.49: "Query49.tpl" is capitalized; 应 be lowercase (FogBugz 1627)
                     •   Changed answers sets: q34.ans_nulls_first and q34.ans_nulls_last. (FogBugz 1531)
                     •   Changes to Query Templates 4, 29, 48, 73, 74, 78, 92, 93, (FogBugz 1501)
                     •   Changes to print.c (FogBugz 616)
02-24-2017   2.4.0   •   Merge clauses 6.1.1.2 and 6.1.1.3 into one 子句 6.1.1.2 (FogBugz 1728)
                     •   Change define to Define in the following templates: 查询12.tpl, 查询39.tpl, 查询91.tpl,
                         查询92.tpl, 查询96.tpl, 查询98.tpl and change 查询 tempates 66 and 85 to use upper case in
                         substitution parameter names (FogBugz 1697)
                     •   Modify Query Template 34 (FogBugz 1696)
                     •   Corrected 列 name in 连接 子句 for Query 78 (FogBugz 1654)
06-08-2017   2.5.0   •   Added new minor 查询 modification (MQM) 规则 to allow changes to scalar functions which
                         only affect 输出 formatting or 结果 precision. See new item 10 "Existing scalar functions" in
                         子句 4.2.3.4 节 (f). (Fogbugz 1756)
                     •   Added new comment to 子句 B72 in Appendix B which clarifies that the scalar number 5 in the
                         expression "d1.d_日期 + 5" means to add 5 days. (Fogbugz 1894)
                     •   Modified 查询24.tpl to add a missing 连接 谓词, modified 谓词 to "c_birth_country <>
                         upper(ca_country)", and added ORDER BY 子句 to make 输出 deterministic. Modified answer
                         set 24.ans accordingly. Modified qualification parameters in 子句 B24 in Appendix B to be:
                         COLOR.1 = "peach", COLOR.2 = "saddle". Modified the business question in 子句 B24 in
                         Appendix B to reflect the 谓词 change. (FogBugz 1909)
                     •   Modified the business question wording in 子句 B23 in Appendix B to more accurately describe
                         查询 23 (查询23.tpl). (FogBugz 1912)
                     •   Added two new 查询 variants, 查询10a.tpl and 查询35a.tpl. The new variants replace "exists
                         {sub-查询 A} or exists {sub-查询 B)" syntax to use UNION ALL. (FogBugz 1980)
                     •   Added new minor 查询 modification (MQM) 规则 to allow ordinals to be replaced by referenced
                         列 names. See new item 3 "Ordinals" in 子句 4.2.3.4 节 (g). (FogBugz 1981)
09-26-2017   2.6.0   •   Added new comment to 子句 3.4.5 stating that dsdgen generates international characters and
                         that data 必须 encoded such that international characters are preserved (fogbugz 1556).
                     •   Removed extraneous comments related to qualification substitution 值 from 查询 templates
                         查询23.tpl and 查询54.tpl (fogbugz 1984).
                     •   Updated EULA.txt to version 2.2 of the TPC's End User Licence Agreement (fogbugz 1985).
                     •   Corrected variant 查询10a.tpl by replacing WHERE with AND in two places (fogbugz 2030).
                     •   Added a second 列 (a.ca_state) to the ORDER BY 子句 (to make the qualification answer
                         set deterministic) in 查询 template 查询6.tpl (no change to answer set 6.ans was required)
                         (fogbugz 2031).
                     •   For 一致性 with other 查询 template files, replaced DEC with DECIMAL in 查询 template
                         查询49.tpl (fogbugz 2036).
                     •   Modified ORDER BY 子句 in 查询 template 查询78.tpl to have 列 reference "ratio"
                         instead of previous expression "round(ss_qty/(coalesce(ws_qty+cs_qty,1)),2)" (fogbugz 2037).
                     • Added a second 列 (i_item_id) to the outer ORDER BY 子句 (to make the qualification
                       answer set deterministic) in 查询 template 查询56.tpl (no change to answer sets was required)
                       (fogbugz 2039).
                     • Added a third 列 (cs2.s1) to the outer ORDER BY 子句 (to make the qualification answer
                       set deterministic) in 查询 template 查询64.tpl, and modified answer set 64.ans accordingly
                       (fogbugz 2040).
                     • Added a second 列 (sales_amt_diff) to the ORDER BY 子句 (to make the qualification
                       answer set deterministic) in 查询 template 查询75.tpl (fogbugz 2041).
                     • Changed ORDER BY 子句 (to make the qualification answer set deterministic) in 查询 template
                       查询49.tpl from " 订单 by 1,4,5" to " 订单 by 1,4,5,2" (no change to answer set 49.ans was
                       required) (fogbugz 2043).
                     • In Table 2-9 (Call_center Column Definitions) in 节 2.4.2 in the 规范, modified the
                       Datatype for 列 "cc_closed_日期_sk" and "cc_open_日期_sk" from "integer" to
                       "identifier". In Table 2-10 (Catalog Page Column Definitions) in 节 2.4.3, modified the
                       Datatype of 列 "cp_start_日期_sk" and "cp_end_日期_sk") from "integer" to "identifier"
                       (fogbugz 2045).
                     • Replaced two occurrences of "c_last_review_日期" with "c_last_review_日期_sk" to be consistent
                       with Table 2-14 (Customer Table Column Definitions) in 节 2.4.7 of the 规范
                       (fogbugz 2046).
                     • Modified last ("Source Schema Column", "Target Column") pair in Table 5-5 in 子句 5.3.11.1
                       from "SS_SOLD_DATE_SK, SS_NET_PROFIT" to "SS_NET_PROFIT, SS_NET_PROFIT" (fogbugz
                       2047).
                     • Modified answer set 78.ans to be consistent with changes made to 查询 template 查询78.tpl per
                       fogbugz 1654 (resolved in TPC-DS version 2.4.0) and per fogbugz 2037 (fogbugz 2035 and 2143).
12-07-2017   2.7.0   • Expanded the wording in 子句 7.3.3 to better define how 输出 data and answer sets much
                       match.
                     • Modified answer set 75.ans to match changes to 查询 template 查询75.tpl made in version 2.6.0
                       (fogbugz 2041).
                     • Added outer SELECT 子句 to 查询 template 查询49.tpl to avoid ORDER BY precedence
                       ambiguity (fogbugz 2149)
                     • Replaced single answer set 6.ans with NULL ordering specific answer sets (6_NULLS_FIRST.ans
                       and 6_NULLS_LAST.ans) (fogbugz 2161).
                     • Replaced answer sets 56_NULLS_FIRST.ans and 56_NULLS_LAST.ans to correct 行 ordering
                       (fogbugz 2162).
                     • Added "cs1.s1" to the ORDER BY 子句 (to make the qualification answer set deterministic) to
                       查询64.tpl (no change to answer set 64.ans was required) (fogbugz 2163).
                     • Corrected typo in 查询 variant 查询70a.tpl (changed "sselect" to "select") (fogbugz 2175).
                     • Added the following sentence to the end of 子句 4.2.3.2: "The following 查询 modifications are
                       exempt from this 要求: e5, f2, f6, f10, g2 and g3." (fogbugz 2176).
2-15-2018    2.8.0   • Remove _END=""; from 查询10a and quer35a templates (Fogbugz 2034) (FogBugz 2034)
                     • Clause 0.5, 表 0-1, change last 行, third 列 to "Set of files for each 规模因子 to compare
                       the correct data generation of base data." This change removed the ", 刷新 data and dsdgen data"
                       (FogBugz 2195)
                     • Add bullet g) in 7.3.4.8.1 "g) Tests required to fulfill the 审计 要求 (see Clause 11)"
                       (FogBugz 2196)
                     • Minor editorial fix-ups in 表 5-4, add missing source 模式 表, fix typo in 表 A-21,
                       Table A-4 fix 外键 for purc_客户_id, Table A-16 fix 外键 for sret_客户_id
                       (FogBugz 2177)
                     • modify 子句 3.4.2 to specify that data from dsdgen prevails when conflicting with 表 3-2 and
                       表 5-2 (FogBugz 2321)
                     • add missing "(" in 查询 70a template in from of statement that follows "results_rollup as"
                       (FogBugz 2180)
                     • Update answer set for 查询 34 to address issue with ordering with multiple 列 with NULL
                       值. New file 34_NULLS_LOW.ans added. (FogBugz 2182)
                     • Specify that major and minor revision numbers of tools must match 规范 revision
                       numbers in 子句 11.2.4.6 and 11.3.1.4 (FogBugz 2382)
                     • Change Clause 6.1.2.1 to spicify that the "test sponsor 应 demonstrate" instead of "guarantee"
                       (FogBugz 2384)
6-21-2018    2.9.0   • remove leading whites pace in 查询 64 answer set. (FogBugz 2499)
                     • add missing cr_call_center_sk to select list and group by for 查询 77a (FogBugz 2450)
                     • remove improper line break in 查询 51a (FogBugz 2452)
                     • Table A1: add 外键 purc_purchase_id for plin_purchase_id. Table A2: remove 外键
                       for purc_purchase_id. Table A3: remove 外键 for cord_订单_id. Table A4: remove foreign
                       key for word_订单_id. Table 2-17: add Not Null for d_日期 Table 2-24: add Not Null for t_time.
                       (FogBugz 2233)
                     • remove 表 that are no longer 零件 of the data 维护 刷新 in TPC-DS v2.0 A-1
                       (s_zip_to_cmt) A-3 (s_客户) A-7 (s_item) A-10 (s_store) A-11 (s_call_center) A-12
                       (s_web_site) A-13 (s_仓库) A-14 (s_web_page) A-15 (s_promotion) A-20 (s_catalog_page)
                       (FogBugz 2178)
                     • Modify 子句 7.4.6.2, 7.4.8.1, and add 子句 7.4.8.2 to clarify activity between power, 吞吐量
                       and data 维护 tests (FogBugz 2194)
                     • 子句 5.3.6 to read "intentionally left blank" since we don't have any DM functions on dimension
                       表 (FogBugz 2199)
                     • duplicate of 2202 (FogBugz 2201)
                     • Modify footnote 1 for Table 5-1 to specify that the number of 行 are approximate numbers but
                       that bytes can vary due to NULL 值. Modify footnote 2 for Table 5-2 to specify that the
                       number of 行 are approximate. (FogBugz 2202)
                     • Modify business question of Query 2 to match the 查询 text. (FogBugz 2443)
                     • Table 5-2 Move 行 for delete_1.dat and inventory_delete_1.dat to end of the 表. (FogBugz
                       2200)
9-18-2018   2.10.0   • Modify 查询 47 and 57 templates to use ORDERBY substitution variable (FogBugz 2042)
                     • 查询14 template - add this_year alias to select 列 (FogBugz 1251)
                     • Clause 2.3.6.2 (Table 2-6) - reverse 订单 of compound 主键 for web returns (FogBugz
                       2191)
                     • Change 定价 规范 versions to be references to "The TPC Pricing Specification located
                       on the TPC website" Clause 7.6.5, introduction of Clause 9, and 9.2.1 (FogBugz 2885)
                     • Clause 7.3 and 7.3.4. Clarify 查询 validation answer set comparison to allow for NULL ordering
                       variations (FogBugz 2032)
                     • Add extra parentheses to 查询 2 template. (FogBugz 2155)
1-30-2019   2.10.1   • Modified document history to comply with Clause 5.3.4 in the TPC Policies
                     • Modified second bullet in 4.2.5.3 to read "The test sponsor must demonstrate to the satisfaction of
                       the Auditor that the file names used, and the extract facility itself, does not provide hints or
                       optimizations in the DBMS such that the 查询 has additional 性能 gains beyond any
                       benefits from accelerating the extraction of 行" (FogBugz 2938)
                     • Modified #define W_STORE_SLAES_H to #define W_STORE_SALES_H in w_store_sales.h
                       FogBugz 2937)
4-25-2019   2.11.0   • Modified Clauses 7.5.1 and 10.3.6.8 to allow for differences in the answer set due to rounding in
                       intermediate 结果 sets (FogBugz 2150)
                     • Removed "This includes disclosure of the code written to 实现 the data accessibility Query."
                       From Clause 10.3.5.1 (FogBugz 2955)
                     • Removed "Number of 行 are within 1/100th Percent of these numbers" from the header of the
                       third 列 in Table 3-2. (FogBugz 2953)
                     • Refined wording how answer sets on a 基准测试 are compared with the qualification answer
                       sets and how their 行 订单 can differ from (FogBugz 2950)
                     • Modified Clauses 7.4.9.1, 7.4.9.2, 7.4.9.3, 7.4.9.4, 7.4.9.5, 7.4.9.6, 7.4.9.7 and 7.4.9.8 (FogBugz
                       2949)
                     • Modified qualification parameters for Query 47 and 57 (FogBugz 2946)
                     • Added the following list entry d) in 5.1.3: d) All delete DM operations finish before any insert DM
                       function begin. (FogBugz 2948)
                     • Modified Clauses 7.4.3.8 and 7.4.3.8.1 to clarify load timing (FogBugz 2939)
                     • Modified clauses 7.3.3, 7.3.4.1 and 7.5.2 (FogBugz 2950)
8-29-2019   2.12.0   • Clarified the timing of 刷新 functions. Clauses modified: 5.2.5, 5.2.6, 5.2.7, 7.4.8.4, 7.4.8.5,
                       7.4.8.6,7.4.9.1, 7.4.9.2, 7.4.9.3, 7.4.9.4, 7.4.9.5, 7.4.9.6, 7.4.9.7,
                       7.4.9.8,7.4.9.9,7.4.10,10.3.6.6,5.1.1,51.2 (FogBugz 2965)
                     • Modified the 规范 to use the term “qualification 查询 结果 data” consistently in Clause
                       7.5.3 (FogBugz 2968)
                     • Clarified when MQM 规则 can be applied in clauses 4.2.3.1, 4.2.3.2,4.2.3.4,4.2.7.1 (FogBugz 2238)
                     • Clarified that TPC-DS queries are designed to test various aspects of a typical data 仓库
                       系统. This includes the 查询 优化器’s ability to transform any valid SQL queries as they 可
                       be written by humans or tools into their most optimal form. Hence, the TPC-DS provided 查询
                       templates 可 include unnecessary or non-optimal SQL (FogBugz 2154)
                      • Remove 表 5-5 through 5-11, remove content of clauses 5.3.4 and 5.3.5 (leave blank) and
                        correct 列 aliases for view lf_crv (FogBugz 2927)
                      • Clean up markup in PDF version (FogBugz 3005)
                      • Clarify what drive to fail in Clause 6.1.2.2 (FogBugz 2936)
4-29-2020    2.13.0   • Updated 审计 clauses to reflect simplified Data Maintenance Functions in DS-v2. Clauses
                        modified: 11.2.5.1, 11.2.5.2, 11.2.5.3, 11.2.5.4, 11.2.5.5 (FogBugz 3029)
                      • Fixed broken references in clauses 4.1.3.2 and 4.1.3.7 (FogBugz 3004)
                      • Corrected wrong 行 count in Table 5-2 (FogBugz 3018)
                      • Changed 说明 of DM Method 1. Clauses modified: 5.3.7, 5.1.5 (FogBugz 2197)
2-10-2021    3.0.0    • Updated 价格 性能 指标 to be $/kQphDS@SF. Clauses modified: 7.6.1, 7.6.4, 7.6.7,
                        10.4.2.1 and Appendix G
4-22-2021    3.1.0    • Added wording to simplify the 执行 of TPC-DS with cloud storage: 6.1.2(FogBugz
                        3051/2942)
                      • Corrected business questions for Query 82: Appendix B Business Questions (FogBugz 3060)
                      • Added not null to ddl for 表 日期_dim and time_dim in tpcds.sql (FogBugz 3048)
                      • Corrected list of 查询 variants in list Appendix C
6-15-2021    3.2.0    • The 3.0.0 and 3.1.0 release were created with the wrong source code (2.2.0p1 vs 2.13.0rc1).
                        Create 3.2.0 with the right source code. (code#27)
11-21-2024   4.0.0    • GitHub Issue #182: Changes necessary to use 定价 changes for dynamic resource
                        allocation. See clauses 9.1, 9.2 and 9.4.
                      • GitHub Issue #180: “assess” misspelled in Clause 1.1 of the 规范
                      • GitHub Issue #18: Primary key definitions for data 维护 模式
                      • GitHub Issue # 1: 7.1.11 typo sstreamss -> streams
                      • GitHub Issue #19: Primary key 列 for data 维护 模式
                      • GitHub Issue #4: Q75 returns no 行 if YEAR is 1999
                                                   §
                            TPC Membership
A list of the current TPC member companies can be found at
http://www.tpc.org/tpc_documents_current_versions/pdf/tpcmembers.pdf
                                                                         Table of Contents
0     PREAMBLE ........................................................................................................................................................................13
    0.1      INTRODUCTION ............................................................................................................................................................13
    0.2      GENERAL IMPLEMENTATION GUIDELINES ...................................................................................................................13
    0.3      GENERAL MEASUREMENT GUIDELINES .......................................................................................................................14
    0.4      WORKLOAD INDEPENDENCE ........................................................................................................................................15
    0.5      ASSOCIATED MATERIALS.............................................................................................................................................15
1     BUSINESS AND BENCHMARK MODEL ......................................................................................................................17
    1.1      OVERVIEW ...................................................................................................................................................................17
    1.2      BUSINESS MODEL ........................................................................................................................................................18
    1.3      DATA MODEL AND DATA ACCESS ASSUMPTIONS .......................................................................................................19
    1.4      QUERY AND USER MODEL ASSUMPTIONS....................................................................................................................19
    1.5      DATA MAINTENANCE ASSUMPTIONS ...........................................................................................................................21
2     LOGICAL DATABASE DESIGN .....................................................................................................................................23
    2.1      SCHEMA OVERVIEW .....................................................................................................................................................23
    2.2      COLUMN DEFINITIONS .................................................................................................................................................23
    2.3      FACT TABLE DEFINITIONS ...........................................................................................................................................24
    2.4      DIMENSION TABLE DEFINITIONS .................................................................................................................................31
    2.5      IMPLEMENTATION REQUIREMENTS ..............................................................................................................................38
    2.6      DATA ACCESS TRANSPARENCY REQUIREMENTS .........................................................................................................41
3     SCALING AND DATABASE POPULATION ................................................................................................................43
    3.1      SCALING MODEL ..........................................................................................................................................................43
    3.2      TEST DATABASE SCALING ...........................................................................................................................................43
    3.3      QUALIFICATION DATABASE SCALING ..........................................................................................................................44
    3.4      DSDGEN AND DATABASE POPULATION ........................................................................................................................45
    3.5      DATA VALIDATION ......................................................................................................................................................46
4     QUERY OVERVIEW ........................................................................................................................................................47
    4.1      GENERAL REQUIREMENTS AND DEFINITIONS FOR QUERIES ........................................................................................47
    4.2      QUERY MODIFICATION METHODS ...............................................................................................................................48
    4.3      SUBSTITUTION PARAMETER GENERATION ....................................................................................................................54
5     DATA MAINTENANCE ...................................................................................................................................................55
    5.1      IMPLEMENTATION REQUIREMENTS AND DEFINITIONS .................................................................................................55
    5.2      REFRESH DATA ............................................................................................................................................................56
    5.3      DATA MAINTENANCE FUNCTIONS ...............................................................................................................................58
6     DATA ACCESSIBILITY PROPERTIES ..........................................................................................................................67
    6.1      THE DATA ACCESSIBILITY PROPERTIES .......................................................................................................................67
7     PERFORMANCE METRICS AND EXECUTION RULES ........................................................................................69
    7.1      DEFINITION OF TERMS .................................................................................................................................................69
    7.2      CONFIGURATION RULES...............................................................................................................................................70
    7.3      QUERY VALIDATION ....................................................................................................................................................72
    7.4       EXECUTION RULES .......................................................................................................................................................72
    7.5       OUTPUT DATA .............................................................................................................................................................77
    7.6       METRICS ......................................................................................................................................................................78
8     SUT AND DRIVER IMPLEMENTATION .....................................................................................................................81
    8.1       MODELS OF TESTED CONFIGURATIONS........................................................................................................................81
    8.2       SYSTEM UNDER TEST (SUT) DEFINITION ....................................................................................................................81
    8.3       DRIVER DEFINITION .....................................................................................................................................................83
9     PRICING ............................................................................................................................................................................84
    9.1       PRICED SYSTEM ...........................................................................................................................................................84
    9.2       ALLOWABLE SUBSTITUTION ........................................................................................................................................86
10         FULL DISCLOSURE ......................................................................................................................................................87
    10.1      REPORTING REQUIREMENTS ........................................................................................................................................87
    10.2      FORMAT GUIDELINES ...................................................................................................................................................87
    10.3      FULL DISCLOSURE REPORT CONTENTS ........................................................................................................................87
    10.4      EXECUTIVE SUMMARY .................................................................................................................................................92
    10.5      AVAILABILITY OF THE FULL DISCLOSURE REPORT ......................................................................................................95
    10.6      REVISIONS TO THE FULL DISCLOSURE REPORT ............................................................................................................95
    10.7      DERIVED RESULTS .......................................................................................................................................................96
    10.8      SUPPORTING FILES INDEX TABLE ..................................................................................................................................97
    10.9      SUPPORTING FILES........................................................................................................................................................98
11         AUDIT ..........................................................................................................................................................................100
    11.1      GENERAL RULES ........................................................................................................................................................100
    11.2      AUDITOR'S CHECK LIST .............................................................................................................................................100
    11.3      CLAUSE 4 RELATED ITEMS.........................................................................................................................................101
    11.4      CLAUSE 5 RELATED ITEMS.........................................................................................................................................102
    11.5      CLAUSE 6 RELATED ITEMS.........................................................................................................................................102
    11.6      CLAUSE 7 RELATED ITEMS.........................................................................................................................................102
    11.7      CLAUSE 8 RELATED ITEMS.........................................................................................................................................102
    11.8      CLAUSE 9 RELATED ITEMS.........................................................................................................................................102
    11.9      CLAUSE 10 RELATED ITEMS.......................................................................................................................................103
                                      0    PREAMBLE

0.1   Introduction

         The TPC Benchmark™DS (TPC-DS) is a decision support 基准测试 that models several generally
         applicable aspects of a decision support 系统, including queries and data 维护. The 基准测试
         provides a representative evaluation of the System Under Test’s (SUT) 性能 as a general purpose
         decision support 系统.

         This 基准测试 illustrates decision support 系统 that:

          • Examine large volumes of data;
          • Give answers to real-world business questions;
          • Execute queries of various operational 要求 and complexities (e.g., ad-hoc, reporting,
            iterative OLAP, data mining);
          • Are characterized by high CPU and IO load;
          • Are periodically synchronized with source OLTP databases through 数据库 维护
            functions.
          • Run on “Big Data” solutions, such as RDBMS as well as Hadoop/Spark based 系统.

         A 基准测试 结果 measures 查询 响应时间 in single user mode, 查询 吞吐量 in multi user
         mode and data 维护 性能 for a given 硬件, operating 系统, and data processing
         系统 配置 under a controlled, complex, multi-user decision support 工作负载.

         Comment: While separated from the main text for readability, comments and appendices are a 零件 of the
         standard and their provisions 必须 enforced.

0.2   General Implementation Guidelines

         The purpose of TPC benchmarks is to provide relevant, objective 性能 data to industry users. To
         achieve that purpose, TPC 基准测试 specifications require 基准测试 tests be implemented with
         系统, products, technologies and 定价 that:

         a)   Are generally available to users;

         b) Are relevant to the market segment that the individual TPC 基准测试 models or represents (e.g.,
            TPC-DS models and represents complex, high data volume, decision support environments);

         c)   Would plausibly be implemented by a significant number of users in the market segment modeled or
              represented by the 基准测试.

         In keeping with these 要求, the TPC-DS 数据库 必须 implemented using commercially
         available data processing 软件, and its queries 必须 executed via SQL interface.

         The use of new 系统, products, technologies (硬件 or 软件) and 定价 is encouraged so long as
         they meet the 要求 above. Specifically prohibited are 基准测试 系统, products, technologies
         or 定价 (hereafter referred to as "implementations") whose primary purpose is 性能 优化
         of TPC 基准测试 results without any corresponding applicability to real-world applications and
         environments. In other words, all "基准测试 special" implementations, which improve 基准测试 results
         but not real-world 性能 or 定价, are prohibited.
         A number of characteristics 应 be evaluated in 订单 to judge whether a particular 实现 is a
         基准测试 special. It is not required that each point below be met, but that the cumulative weight of the
         evidence be considered to identify an unacceptable 实现. Absolute certainty or certainty beyond
         a reasonable doubt is not required to make a judgment on this complex issue. The question that 必须
         answered is: "Based on the available evidence, does the clear preponderance (the greater share or weight) of
         evidence indicate this 实现 is a 基准测试 special?"

         The following characteristics 应 be used to judge whether a particular 实现 is a 基准测试
         special:

          a) Is the 实现 generally available, documented, and supported?
          b) Does the 实现 have significant restrictions on its use or applicability that limits its use
             beyond TPC benchmarks?
          c) Is the 实现 or 零件 of the 实现 poorly integrated into the larger product?
          d) Does the 实现 take special advantage of the limited nature of TPC benchmarks (e.g., 查询
             templates, 查询 mix, concurrency and/or contention, etc.) in a manner that would not be generally
             applicable to the environment the 基准测试 represents?
          e) Is the use of the 实现 discouraged by the vendor? (This includes failing to promote the
             实现 in a manner similar to other products and technologies.)
          f) Does the 实现 require uncommon sophistication on the 零件 of the end-user, programmer,
             or 系统 administrator?
          g) Is the 定价 unusual or non-customary for the vendor or unusual or non-customary compared to
             normal business practices? The following 定价 practices are suspect:
                      • Availability of a 折扣 to a small subset of possible customers;
                      • Discounts documented in an unusual or non-customary manner;
                      • Discounts that exceed 25% on small quantities and 50% on large quantities;
                      • Pricing featured as a close-out or one-time special;
                      • Unusual or non-customary restrictions on transferability of product, warranty or
                          维护 on discounted items.
          h) Is the 实现 (including beta-release components) being purchased or used for applications in
             the market segment the 基准测试 represents? How many sites implemented it? How many end-users
             benefit from it? If the 实现 is not currently being purchased or used, is there any evidence
             to indicate that it will be purchased or used by a significant number of end-user sites?

0.3   General Measurement Guidelines

         TPC 基准测试 results are expected to be accurate representations of 系统 性能. Therefore,
         there are specific guidelines that are expected to be followed when measuring those results. The approach
         or methodology to be used in the measurements are either explicitly described in the 规范 or left to
         the discretion of the test sponsor.

         When not described in the 规范, the methodologies and approaches used must meet the following
         要求:

          a) The approach is an accepted engineering practice or standard;
          b) The approach does not enhance the 结果;
          c) Equipment used in measuring the results is calibrated according to established quality standards;
          d) Fidelity and candor is maintained in reporting any anomalies in the results, even if not specified in the
             基准测试 要求.
         Comment: The use of new methodologies and approaches is encouraged as long as they meet the
         要求 outlined above.
0.4    Workload Independence

           TPC-DS uses terminology and metrics which are similar to other benchmarks originated by the TPC and
           others. Such similarity in terminology does not in any way imply that TPC-DS results are comparable to
           other benchmarks. The only 基准测试 results comparable to TPC-DS are other TPC-DS results compliant
           with the same major revision of the 基准测试 规范 and with the same 规模因子.
           While this 基准测试 offers a rich environment representative of many decision support 系统, it does
           not reflect the entire range of decision support 要求. In addition, the extent to which a 客户
           can achieve the results reported by a vendor is highly dependent on how closely TPC-DS approximates the
           客户’s application. The relative 性能 of 系统 derived from this 基准测试 does not
           necessarily hold for other workloads or environments. Extrapolations to any other environment are not
           recommended.
           Benchmark results are highly dependent upon 工作负载, specific application 要求, and 系统
           design and 实现. As a 结果 of these and other factors, relative 系统 性能 will vary.
           Therefore, TPC-DS 应 not be used as a substitute for a specific 客户 application benchmarking
           when critical capacity planning and/or product evaluation decisions are contemplated.
           Benchmark sponsors are permitted to employ several possible 系统 designs and a broad degree of
           实现 freedom within the constraints detailed in this 规范. A full disclosure report (FDR)
           of the 实现 details 必须 made available along with the reported results.

0.5    Associated Materials

           In addition to this document, TPC-DS relies on material which is only available electronically. While not
           included in the printed version of the 规范, this material is integral to the submission of a
           compliant TPC-DS 基准测试 结果. Table 0-1 summarizes the electronic material related to the TPC-DS
           规范 that is available for download from the TPC web site.

           This material is maintained, versioned and revised independently of the 规范 itself. Refer to
           Appendix F to determine which version(s) of the electronic content are compliant with this revision of the
           规范.

                              Table 0-1 Electronically Available Specification Material

      Content             File Name/Location       Usage                                          Additional
                                                                                                  Information

      Data generator      dsdgen                   Used to generate the data sets for the         Clause 3.4
                                                   基准测试

      Query generator     dsqgen                   Used to generate the 查询 sets for the        Clause 4.1.2
                                                   基准测试

      Query               查询_templates/         Used by dsqgen to generate executable          Clause 4.1.3
      Templates                                    查询 text

      Query Template      查询_variants/          Used by dsqgen to generate alternative         Appendix C
      Variants                                     executable 查询 text

      Table definitions   tpcds.sql                Sample 实现 of the logical           Appendix A
      in ANSI SQL         tpcds_source.sql         模式 for the data 仓库.
        Content            File Name/Location       Usage                                           Additional
                                                                                                    Information

        Data               data_维护/        Sample 实现 of the SQL                Clause 5.3
        Maintenance                                 needed for the Data Maintenance phase
        Functions in                                of the 基准测试
        ANSI SQL

        Answer Sets        answer_sets/             Used to verify the initial population of        Clause 7.3
                                                    the data 仓库.

        Reference Data     run dsdgen with –        Set of files for each 规模因子 to
        Set                validate flag            compare the correct data generation of
                                                    base data.


0.5.1       The 规则 for 定价 are included in the current revision of the TPC Pricing Specification located on the
            TPC website (http://www.tpc.org).

            Comment: There is a non-binding How_To_Guide.doc guide electronically available. The purpose of this
            guide is to describe the most common tasks necessary to 实现 a TPC-DS 基准测试. The target
            audience is individuals who want to install, populate, run and analyze the 数据库, queries and data
            维护 workloads for TPC-DS.
                                      1    Business and Benchmark Model

1.1   Overview

         TPC Benchmark™ DS (TPC-DS) contains 基准测试 components that can be used to assess a broad range
         of 系统 topologies and 实现 methodologies in a technically rigorous and directly comparable,
         vendor-neutral manner. In 订单 to ease the learning curve for users and 基准测试 sponsors who are new
         to TPC-DS, the 基准测试 has been mapped to a typical business environment. This 子句 outlines the
         business modeling assumptions that were adopted during the development of the 基准测试, and their
         impact on the 基准测试 environment.

         TPC-DS models the decision support functions of a retail product 供应商. The supporting 模式
         contains vital business information, such as 客户, 订单, and product data. The 基准测试 models the
         two most important components of any mature decision support 系统:

         • User queries, which convert operational facts into business intelligence.
         • Data 维护, which synchronizes the process of management analysis with the operational
           external data source on which it relies.

         The 基准测试 abstracts the diversity of operations found in an information analysis application, while
         retaining essential 性能 characteristics. As it is necessary to execute a great number of queries and
         data transformations to completely manage any business analysis environment, no 基准测试 can succeed
         in exactly mimicking a particular environment and remain broadly applicable.

         While TPC-DS does not aspire to be a model of how to build an actual information analysis application, the
         工作负载 has been granted a realistic context. It imitates the activity of a multi-channel retailer; thus
         tracking store, web and catalog sales channels.

         The goal of selecting a retail business model is to assist the reader in relating intuitively to the components
         of the 基准测试, without tracking that industry segment so tightly as to minimize the relevance of the
         基准测试. The TPC-DS 工作负载 可 be used to characterize any industry that must transform
         operational and external data into business intelligence.

         Although the emphasis is on information analysis, the 基准测试 recognizes the need to periodically
         刷新 its data. The data represents a reasonable image of a business operation as they progress over time.

         Some TPC benchmarks model the operational aspect of the business environment where transactions are
         executed on a real time basis. Other benchmarks address the simpler, more static model of decision support.
         The TPC-DS 基准测试, models the challenges of business intelligence 系统 where operational data is
         used both to support the making of sound business decisions in near real time and to direct long-range
         planning and exploration.
         Figure 1-1 illustrates TPC-DS 基准测试 components.




                       Figure 1-1: TPC-DS 基准测试 components



1.2   Business Model

         TPC-DS models any industry that must manage, sell and distribute products (e.g., food, electronics,
         furniture, music and toys etc.). It utilizes the business model of a large retail company having multiple
         stores located 国家-wide. Beyond its brick and mortar stores, the company also sells goods through
         catalogs and the Internet. Along with 表 to model the associated sales and returns, it includes a simple
         inventory 系统 and a promotion 系统.

         The following are examples of business processes of this retail company:

          •   Record 客户 purchases (and track 客户 returns) from any sales channel
          •   Modify prices according to promotions
          •   Maintain 仓库 inventory
          •   Create dynamic web pages
          •   Maintain 客户 profiles (Customer Relationship Management)

         TPC-DS does not 基准测试 the operational 系统. It is assumed that the channel sub-系统 were
         designed at different times by diverse groups having dissimilar functional 要求. It is also
         recognized that they 可 be operating on significantly different 硬件 configurations, 软件
         configurations and data model semantics. All three channel sub-系统 are autonomous and retain
         possibly redundant information regarding customers, addresses, etc. For more information in the
         benchmarking of operational 系统, please see the TPC website (http://www.tpc.org).

         TPC-DS’ modeling of the business environment falls into three broad categories:

          • Data Model and Data Access Assumptions (see Clause 1.3)
            • Query and User Model Assumptions (see Clause 1.4)
            • Data Maintenance Assumptions(see Clause 1.5)

1.3     Data Model and Data Access Assumptions

1.3.1      TPC-DS models a 系统 that allows potentially long running and multi-零件 queries where the DBA can
           assume that the data processing 系统 is quiescent for queries during any particular period.

1.3.2      The TPC-DS data tracks, possibly with some delay, the state of an operational 数据库 through data
           维护 functions, which include a number of modifications impacting some 零件 of the decision
           support 系统.

1.3.3      The TPC-DS 模式 is a snowflake 模式. It consists of multiple dimension and fact 表. Each
           dimension has a single 列 surrogate key. The fact 表 连接 with dimensions using each dimension
           表's surrogate key. The dimension 表 can be classified into one of the following types:

            • Static: The contents of the dimension are loaded once during 数据库 load and do not change
              over time. The 日期 dimension is an 示例 of a static dimension.
            • Historical: The history of the changes made to the dimension data is maintained by creating
              multiple 行 for a single business key 值. Each 行 includes 列 indicating the time
              period for which the 行 is valid. The fact 表 are linked to the dimension 值 that were
              active at the time the fact was recorded, thus maintaining “historical truth”. Item is an 示例
              of a historical dimension.
            • Non-Historical: The history of the changes made to the dimension data is not maintained. As
              dimension 行 are updated, the previous 值 are overwritten and this information is lost.
              All fact data is associated with the most current 值 of the dimension. Customer is an 示例
              of a Non-Historical dimension.

1.3.4      To achieve the optimal compromise between 性能 and operational 一致性, the 系统
           administrator can set, once and for all, the locking levels and the concurrent scheduling 规则 for queries
           and data 维护 functions.

1.3.5      The size of a DSS 系统 – more precisely the size of the data captured in a DSS 系统 – 可 vary from
           company to company and within the same company based on different time frames. Therefore, the TPC-DS
           基准测试 will model several different sizes of the DSS (a.k.a. 基准测试 scaling or 规模因子).

1.4     Query and User Model Assumptions

           The users and queries modeled by the 基准测试 exhibit the following characteristics:

            a) They address complex business problems
            b) They use a variety of access patterns, 查询 phrasings, operators, and answer set constraints
            c) They employ 查询 parameters that change across 查询 executions

           In 订单 to address the enormous range of 查询 types and user behaviors encountered by a decision
           support 系统, TPC-DS utilizes a generalized 查询 model. This model allows the 基准测试 to capture
           important aspects of the interactive, iterative nature of on-line analytical processing (OLAP) queries, the
           longer-running complex queries of data mining and knowledge discovery, and the more planned behavior
           of well known report queries.

1.4.1      Query Classes
          The size of the 模式 and its three sales channels allow for amalgamating the above 查询 classes,
          especially ad-hoc and reporting, into the same 基准测试. An ad-hoc querying 工作负载 simulates an
          environment in which users connected to the 系统 send individual queries that are not known in
          advance. The 系统's administrator (DBA) cannot optimize the 系统 specifically for this set of queries.
          Consequently, 执行 time for those queries can be very long. In contrast, queries in a reporting
          工作负载 are very well known in advance. As a 结果, the DBA can optimize the 系统 specifically for
          these queries to execute them very rapidly by using clever data placement methods (e.g. partitioning and
          clustering) and auxiliary data structures (e.g. materialized views and indexes). Amalgamating both types of
          queries has been traditionally difficult in 基准测试 environments since per the 定义 of a 基准测试
          all queries, apart from bind variables, are known in advance. TPC-DS accomplishes this fusion by dividing
          the 模式 into reporting and ad-hoc parts. The catalog sales channel is dedicated for the reporting 零件,
          while the store and web channels are dedicated for the ad-hoc 零件. The catalog sales channel was chosen
          as the reporting 零件 because its data accounts for 40% of the entire data set. The reporting and ad-hoc
          parts of the 模式 differ in what kind of auxiliary data structures can be created.. The idea behind this
          approach is that the queries accessing the ad-hoc 零件 constitute the ad-hoc 查询 set while the queries
          accessing the reporting 零件 are considered the reporting queries.

          A sophisticated decision support 系统 must support a diverse user population. While there are many
          ways to categorize those diverse users and the queries that they generate, TPC-DS has defined four broad
          classes of queries that characterize most decision support queries:

          •   Reporting queries
          •   Ad hoc queries
          •   Iterative OLAP queries
          •   Data mining queries

          TPC-DS provides a wide variety of queries in the 基准测试 to emulate these diverse 查询 classes.
1.4.1.1   Reporting Queries

          These queries capture the “reporting” nature of a DSS 系统. They include queries that are executed
          periodically to answer well-known, pre-defined questions about the financial and operational health of a
          business. Although reporting queries tend to be static, minor changes are common. From one use of a given
          reporting 查询 to the next, a user might choose to shift focus by varying a 日期 range, geographic location
          or a brand name.

1.4.1.2   Ad hoc Queries

          These queries capture the dynamic nature of a DSS 系统 in which impromptu queries are constructed to
          answer immediate and specific business questions. The central difference between ad hoc queries and
          reporting queries is the limited degree of foreknowledge that is available to the System Administrator
          (SysAdmin) when planning for an ad hoc 查询.
1.4.1.3   Iterative OLAP Queries

          OLAP queries allow for the exploration and analysis of business data to discover new and meaningful
          relationships and trends. While this class of queries is similar to the “Ad hoc Queries” class, it is
          distinguished by a scenario-based user session in which a sequence of queries is submitted. Such a sequence
          可 include both complex and simple queries.

1.4.1.4   Data Mining Queries
         Data mining is the process of sifting through large amounts of data to produce data content relationships. It
         can predict future trends and behaviors, allowing businesses to make proactive, knowledge-driven
         decisions. This class of queries typically consists of joins and large aggregations that return large data 结果
         sets for possible extraction.

1.5   Data Maintenance Assumptions

         A data 仓库 is only as accurate and current as the operational data on which it is based. Accordingly,
         the migration of data from operational OLTP 系统 to analytical DSS 系统 is crucial. The migration
         tends to vary widely from business to business and application to application. Previous benchmarks
         evaluated the data analysis 组件 of decision support 系统 while excluding a realistic data 刷新
         process. TPC-DS offers a more balanced view.

         Decision support 数据库 刷新 processes usually involve three distinct and important steps:

          • Data Extraction: This phase consists of the accurate extraction of pertinent data from production
            OLTP databases and other relevant data sources. In a production environment, the extraction
            step 可 include numerous separate extract operations executed against multiple OLTP
            databases and auxiliary data sources. While selection and tuning of the associated 系统 and
            procedures is important to the success of the production 系统, it is separate from the purchase
            and 配置 of the decision support servers. Accordingly, the data extract step of the ETL
            process (E) is not modeled in the 基准测试. The TPC-DS data 维护 process starts from
            generated flat files that are assumed to be the 输出 of this external Extraction process.
          • Data Transformation: This is when the extracted data is cleansed and massaged into a common
            format suitable for assimilation by the decision support 数据库.
          • Data Load: This is the actual insertion, modification and deletion of data within the decision
            support 数据库.

          Taken together, the progression of Extraction, Transformation and Load is more commonly known
          by its 缩写, ETL. In TPC-DS, the modeling of Transformation and Load is known as Data
          Maintenance (DM) or Data Refresh. In this 规范 the two terms are used interchangeably.

         The DM process of TPC-DS includes the following tasks that 结果 from such a complex business
         environment as shown in Figure 1-2:

          i) Load the 刷新 data set, which consists of new, deleted and changed data destined for the data
             仓库 in its operational format.
         ii) Load 刷新 data set into the data 仓库 applying data transformations, e.g.:
             •   Data denormalization (3rd Normal form to snowflake). During this step the source 表 are
                 mapped into the data 仓库 by:
                  § Direct source to target mapping. This type of mapping is the most common. It applies to
                       表 in the data 仓库 that have an equivalent 表 in the operational 模式.
                  §   Multiple data 仓库 source 表 are joined and the 结果 is mapped to one target 表.
                      This mapping translates the third normal form of the operational 模式 into the de-
                      normalized form of the data 仓库.
                  §   One source 表 is mapped to multiple target 表. This mapping is the least common. It
                      occurs if, for efficiency reason, the 模式 of the operational 系统 is less normalized than
                      the data 仓库 模式.
            •    Syntactically cleanse data
             •   De-normalize
        iii) Insert new fact 记录 and delete fact 记录 by 日期.
The structure and relationships between the flat files is provided in form of a 表 说明 and the ddl of
the 表 that represent the hypothetical operational 数据库 in Appendix A.




              Figure 1-2: Execution Overview of the Data Maintenance Process
                                          2    Logical Database Design

2.1       Schema Overview

             The TPC-DS 模式 models the sales and sales returns process for an organization that employs three
             primary sales channels: stores, catalogs, and the Internet. The 模式 includes seven fact 表:

              • A pair of fact 表 focused on the product sales and returns for each of the three channels
              • A single fact 表 that models inventory for the catalog and internet sales channels.

             In addition, the 模式 includes 17 dimension 表 that are associated with all sales channels. The
             following clauses specify the logical design of each 表:

              • The name of the 表, along with its abbreviation (listed parenthetically)
              • A logical diagram of each fact 表 and its related dimension 表
              • The high-level definitions for each 表 and its relationship to other 表, using the format
                defined in Clause 2.2
              • The scaling and cardinality information for each 列

2.2       Column Definitions

2.2.1        Column Name
2.2.1.1      Each 列 is uniquely named, and each 列 name begins with the abbreviation of the 表 in which it
             appears.
2.2.1.2      Columns that are 零件 of the 表’s 主键 are indicated in the 列 called Primary Key (Sections 2.3
             and 2.4). If a 表 uses a composite 主键, then for convenience of reading the 订单 of a given 列
             in a 表’s 主键 is listed in parentheses following the 列 name.
2.2.1.3      Columns that are 零件 of a business key are indicated with (B) appearing after the 列 name (Sections 2.3
             and 2.4 ). A business key is neither a 主键 nor a 外键 in the context of the data 仓库
             模式. It is only used to differentiate new data from update data of the source 表 during the data
             维护 operations.

2.2.2        Datatype
2.2.2.1      Each 列 employs one of the following datatypes:
              a) Identifier means that the 列 应 be able to hold any key 值 generated for that 列.
              b) Integer means that the 列 应 be able to exactly represent integer 值 (i.e., 值 in
                 increments of 1) in the range of at least ( − 2n − 1) to (2n − 1 − 1), where n is 64.
              c) Decimal(d, f) means that the 列 应 be able to represent decimal 值 up to and including d
                 digits, of which f 应 occur to the right of the decimal place; the 值 can be either represented
                 exactly or interpreted to be in this range.
              d) Char(N) means that the 列 应 be able to hold any string of characters of a fixed length of N.
             Comment: If the string that a 列 of datatype char(N) holds is shorter than N characters, then trailing
             spaces 应 be stored in the 数据库 or the 数据库 应 automatically pad with spaces upon retrieval
             such that a CHAR_LENGTH() function will return N.
              e) Varchar(N) means that the 列 应 be able to hold any string of characters of a variable length
                 with a maximum length of N. Columns defined as "varchar(N)" 可 optionally be implemented as
                 "char(N)".
              f) Date means that the 列 应 be able to express any calendar day between January 1, 1900 and
                 December 31, 2199.
2.2.2.2       The datatypes do not correspond to any specific SQL-standard datatype. The definitions are provided to
              highlight the properties that are required for a particular 列. The 基准测试 implementer 可 employ any
              internal representation or SQL datatype that meets those 要求.
2.2.2.3       The 实现 chosen by the test sponsor for a particular datatype 定义 应 be applied consistently
              to all the instances of that datatype 定义 in the 模式, except for identifier 列, whose datatype 可
              be selected to satisfy 数据库 scaling 要求.

2.2.3         NULLs

              If a 列 定义 includes an ‘N’ in the NULLs 列 this 列 is populated in every 行 of the
              表 for all scale factors. If the 字段 is blank this 列 可 contain NULLs.

2.2.4         Foreign Key

              If the 值 in this 列 连接 with another 列, the foreign 列 name is listed in the Foreign
              Key 字段 of the 列 定义.

2.3       Fact Table Definitions

2.3.1         Store Sales (SS)
2.3.1.1       Store Sales ER-Diagram




2.3.1.2       Store Sales Column Definitions

              Each 行 in this 表 represents a single 行项 for a sale made through the store channel and recorded
              in the store_sales fact 表.

                                         Table 2-1 Store_sales Column Definitions
           Column                        Datatype              NULLs      Primary Key     Foreign Key
           ss_sold_日期_sk               identifier                                       d_日期_sk
           ss_sold_time_sk               identifier                                       t_time_sk
           ss_item_sk (1)                identifier            N          Y               i_item_sk
           ss_客户_sk                identifier                                       c_客户_sk
           Column                        Datatype              NULLs       Primary Key   Foreign Key
           ss_cdemo_sk                   identifier                                      cd_demo_sk
           ss_hdemo_sk                   identifier                                      hd_demo_sk
           ss_addr_sk                    identifier                                      ca_address_sk
           ss_store_sk                   identifier                                      s_store_sk
           ss_promo_sk                   identifier                                      p_promo_sk
           ss_ticket_number (2)          identifier            N           Y
           ss_数量                   integer
           ss_wholesale_成本             decimal(7,2)
           ss_list_价格                 decimal(7,2)
           ss_sales_价格                decimal(7,2)
           ss_ext_折扣_amt           decimal(7,2)
           ss_ext_sales_价格            decimal(7,2)
           ss_ext_wholesale_成本         decimal(7,2)
           ss_ext_list_价格             decimal(7,2)
           ss_ext_税                    decimal(7,2)
           ss_coupon_amt                 decimal(7,2)
           ss_net_paid                   decimal(7,2)
           ss_net_paid_inc_税           decimal(7,2)
           ss_net_profit                 decimal(7,2)

2.3.2         Store Returns (SR)
2.3.2.1       Store Returns ER-Diagram




2.3.2.2       Store Returns Column Definition

              Each 行 in this 表 represents a single 行项 for the return of an item sold through the store channel
              and recorded in the store_returns fact 表.

                                      Table 2-2 Store_returns Column Definitions
          Column                         Datatype          NULLs       Primary Key       Foreign Key
          sr_returned_日期_sk            identifier                                      d_日期_sk
          sr_return_time_sk              identifier                                      t_time_sk
          sr_item_sk (1)                 identifier        N           Y                 i_item_sk,ss_item_sk
          sr_客户_sk                 identifier                                      c_客户_sk
          sr_cdemo_sk                    identifier                                      cd_demo_sk
           Column                           Datatype         NULLs     Primary Key       Foreign Key
           sr_hdemo_sk                      identifier                                   hd_demo_sk
           sr_addr_sk                       identifier                                   ca_address_sk
           sr_store_sk                      identifier                                   s_store_sk
           sr_reason_sk                     identifier                                   r_reason_sk
           sr_ticket_number (2)             identifier       N         Y                 ss_ticket_number
           sr_return_数量               integer
           sr_return_amt                    decimal(7,2)
           sr_return_税                    decimal(7,2)
           sr_return_amt_inc_税            decimal(7,2)
           sr_fee                           decimal(7,2)
           sr_return_ship_成本              decimal(7,2)
           sr_refunded_cash                 decimal(7,2)
           sr_reversed_charge               decimal(7,2)
           sr_store_credit                  decimal(7,2)
           sr_net_loss                      decimal(7,2)




2.3.3            Catalog Sales (CS)
2.3.3.1          Catalog Sales ER-Diagram




2.3.3.2          Catalog Sales Column Definition

                 Each 行 in this 表 represents a single 行项 for a sale made through the catalog channel and recorded
                 in the catalog_sales fact 表.

                                         Table 2-3 Catalog Sales Column Definitions
        Column                               Datatype         NULLs        Primary Key      Foreign Key
        cs_sold_日期_sk                      identifier                                     d_日期_sk
        cs_sold_time_sk                      identifier                                     t_time_sk
        cs_ship_日期_sk                      identifier                                     d_日期_sk
        cs_bill_客户_sk                  identifier                                     c_客户_sk
        cs_bill_cdemo_sk                     identifier                                     cd_demo_sk
        cs_bill_hdemo_sk                     identifier                                     hd_demo_sk
        cs_bill_addr_sk                      identifier                                     ca_address_sk
        cs_ship_客户_sk                  identifier                                     c_客户_sk
        cs_ship_cdemo_sk                     identifier                                     cd_demo_sk
        cs_ship_hdemo_sk                     identifier                                     hd_demo_sk
        cs_ship_addr_sk                      identifier                                     ca_address_sk
        Column                             Datatype           NULLs        Primary Key      Foreign Key
        cs_call_center_sk                  identifier                                       cc_call_center_sk
        cs_catalog_page_sk                 identifier                                       cp_catalog_page_sk
        cs_ship_mode_sk                    identifier                                       sm_ship_mode_sk
        cs_仓库_sk                    identifier                                       w_仓库_sk
        cs_item_sk (1)                     identifier         N            Y                i_item_sk
        cs_promo_sk                        identifier                                       p_promo_sk
        cs_订单_number (2)                identifier         N            Y
        cs_数量                        integer
        cs_wholesale_成本                  decimal(7,2)
        cs_list_价格                      decimal(7,2)
        cs_sales_价格                     decimal(7,2)
        cs_ext_折扣_amt                decimal(7,2)
        cs_ext_sales_价格                 decimal(7,2)
        cs_ext_wholesale_成本              decimal(7,2)
        cs_ext_list_价格                  decimal(7,2)
        cs_ext_税                         decimal(7,2)
        cs_coupon_amt                      decimal(7,2)
        cs_ext_ship_成本                   decimal(7,2)
        cs_net_paid                        decimal(7,2)
        cs_net_paid_inc_税                decimal(7,2)
        cs_net_paid_inc_ship               decimal(7,2)
        cs_net_paid_inc_ship_税           decimal(7,2)
        cs_net_profit                      decimal(7,2)

2.3.4           Catalog Returns (CR)
2.3.4.1         Catalog Returns ER-Diagram




2.3.4.2         Catalog Returns Column Definition

                Each 行 in this 表 represents a single 行项 for the return of an item sold through the catalog
                channel and recorded in the catalog_returns 表.

                                        Table 2-4 Catalog_returns Column Definition
          Colum                               Datatype           NULLs       Primary Key        Foreign Key

          cr_returned_日期_sk                 identifier                                        d_日期_sk
          cr_returned_time_sk                 identifier                                        t_time_sk
          cr_item_sk (1)                      identifier         N           Y                  i_item_sk,cs_item_sk
          cr_refunded_客户_sk             identifier                                        c_客户_sk
          cr_refunded_cdemo_sk                identifier                                        cd_demo_sk
          cr_refunded_hdemo_sk                identifier                                        hd_demo_sk
          cr_refunded_addr_sk                 identifier                                        ca_address_sk
          cr_returning_客户_sk            identifier                                        c_客户_sk
          cr_returning_cdemo_sk               identifier                                        cd_demo_sk
          cr_returning_hdemo_sk               identifier                                        hd_demo_sk
          cr_returning_addr_sk                identifier                                        ca_address_sk
          cr_call_center_sk                   identifier                                        cc_call_center_sk
          cr_catalog_page_sk                  identifier                                        cp_catalog_page_sk
          cr_ship_mode_sk                     identifier                                        sm_ship_mode_sk
          cr_仓库_sk                     identifier                                        w_仓库_sk
          cr_reason_sk                        identifier                                        r_reason_sk
          cr_订单_number (2)                 identifier         N           Y                  cs_订单_number
          cr_return_数量                  integer
          cr_return_amount                    decimal(7,2)
          cr_return_税                       decimal(7,2)
          cr_return_amt_inc_税               decimal(7,2)
          cr_fee                              decimal(7,2)
          cr_return_ship_成本                 decimal(7,2)
          cr_refunded_cash                    decimal(7,2)
          cr_reversed_charge                  decimal(7,2)
          cr_store_credit                     decimal(7,2)
          cr_net_loss                         decimal(7,2)

2.3.5             Web Sales (WS)
2.3.5.1           Web Sales ER-Diagram




2.3.5.2           Web Sales Column Definition

                  Each 行 in this 表 represents a single 行项 for a sale made through the web channel and recorded in
                  the web_sales fact 表.

                                           Table 2-5 Web_sales Column Definitions
          Column                              Datatype          NULLs      Primary Key      Foreign Key
          ws_sold_日期_sk                     identifier                                    d_日期_sk
          Column                         Datatype       NULLs   Primary Key   Foreign Key
          ws_sold_time_sk                identifier                           t_time_sk
          ws_ship_日期_sk                identifier                           d_日期_sk
          ws_item_sk (1)                 identifier     N       Y             i_item_sk
          ws_bill_客户_sk            identifier                           c_客户_sk
          ws_bill_cdemo_sk               identifier                           cd_demo_sk
          ws_bill_hdemo_sk               identifier                           hd_demo_sk
          ws_bill_addr_sk                identifier                           ca_address_sk
          ws_ship_客户_sk            identifier                           c_客户_sk
          ws_ship_cdemo_sk               identifier                           cd_demo_sk
          ws_ship_hdemo_sk               identifier                           hd_demo_sk
          ws_ship_addr_sk                identifier                           ca_address_sk
          ws_web_page_sk                 identifier                           wp_web_page_sk
          ws_web_site_sk                 identifier                           web_site_sk
          ws_ship_mode_sk                identifier                           sm_ship_mode_sk
          ws_仓库_sk                identifier                           w_仓库_sk
          ws_promo_sk                    identifier                           p_promo_sk
          ws_订单_number (2)            identifier     N       Y
          ws_数量                    integer
          ws_wholesale_成本              decimal(7,2)
          ws_list_价格                  decimal(7,2)
          ws_sales_价格                 decimal(7,2)
          ws_ext_折扣_amt            decimal(7,2)
          ws_ext_sales_价格             decimal(7,2)
          ws_ext_wholesale_成本          decimal(7,2)
          ws_ext_list_价格              decimal(7,2)
          ws_ext_税                     decimal(7,2)
          ws_coupon_amt                  decimal(7,2)
          ws_ext_ship_成本               decimal(7,2)
          ws_net_paid                    decimal(7,2)
          ws_net_paid_inc_税            decimal(7,2)
          ws_net_paid_inc_ship           decimal(7,2)
          ws_net_paid_inc_ship_税       decimal(7,2)
          ws_net_profit                  decimal(7,2)

2.3.6           Web Returns (WR)

2.3.6.1         Web Returns ER-Diagram
2.3.6.2       Web Returns Column Definition

              Each 行 in this 表 represents a single 行项 for the return of an item sold through the web sales
              channel and recorded in the web_returns 表.

                                       Table 2-6 Web_returns Column Definitions
          Column                         Datatype         NULLs     Primary Key       Foreign Key
          wr_returned_日期_sk            identifier                                   d_日期_sk
          wr_returned_time_sk            identifier                                   t_time_sk
          wr_item_sk (1)                 identifier       N         Y                 i_item_sk,ws_item_sk
          wr_refunded_客户_sk        identifier                                   c_客户_sk
          wr_refunded_cdemo_sk           identifier                                   cd_demo_sk
          wr_refunded_hdemo_sk           identifier                                   hd_demo_sk
          wr_refunded_addr_sk            identifier                                   ca_address_sk
          wr_returning_客户_sk       identifier                                   c_客户_sk
          wr_returning_cdemo_sk          identifier                                   cd_demo_sk
          wr_returning_hdemo_sk          identifier                                   hd_demo_sk
          wr_returning_addr_sk           identifier                                   ca_address_sk
          wr_web_page_sk                 identifier                                   wp_web_page_sk
          wr_reason_sk                   identifier                                   r_reason_sk
          wr_订单_number (2)            identifier       N         Y                 ws_订单_number
          wr_return_数量             integer
          wr_return_amt                  decimal(7,2)
          wr_return_税                  decimal(7,2)
          wr_return_amt_inc_税          decimal(7,2)
          wr_fee                         decimal(7,2)
          wr_return_ship_成本            decimal(7,2)
          wr_refunded_cash               decimal(7,2)
          wr_reversed_charge             decimal(7,2)
          wr_account_credit              decimal(7,2)
          wr_net_loss                    decimal(7,2)




2.3.7         Inventory (INV)
2.3.7.1       Inventory ER-Diagram




2.3.7.2       Inventory Column Definition

              Each 行 in this 表 represents the 数量 of a particular item on-hand at a given 仓库 during a
              specific week.

                                             Table 2-7 Inventory Column Definitions
Column                    Datatype               NULLs       Primary Key         Foreign Key
inv_日期_sk (1)           identifier             N           Y                   d_日期_sk
inv_item_sk (2)           identifier             N           Y                   i_item_sk
inv_仓库_sk (3)      identifier             N           Y                   w_仓库_sk
inv_数量_on_hand      integer


2.4       Dimension Table Definitions

2.4.1         Store (S)

              Each 行 in this dimension 表 represents details of a store.

                                              Table 2-8: Store Column Definitions
 Column                       Datatype                   NULLs             Primary Key            Foreign Key
 s_store_sk                   identifier                 N                 Y
 s_store_id (B)               char(16)                   N
 s_rec_start_日期             日期
 s_rec_end_日期               日期
 s_closed_日期_sk             identifier                                                          d_日期_sk
 s_store_name                 varchar(50)
 s_number_employees           integer
 s_floor_space                integer
 s_hours                      char(20)
 S_manager                    varchar(40)
 S_market_id                  integer
 S_geography_class            varchar(100)
 S_market_desc                varchar(100)
 s_market_manager             varchar(40)
 s_division_id                integer
 s_division_name              varchar(50)
 s_company_id                 integer
 s_company_name               varchar(50)
 s_street_number              varchar(10)
 s_street_name                varchar(60)
 s_street_type                char(15)
 s_suite_number               char(10)
 s_city                       varchar(60)
 s_county                     varchar(30)
 s_state                      char(2)
 Column                        Datatype                      NULLs         Primary Key               Foreign Key
 s_zip                         char(10)
 s_country                     varchar(20)
 s_gmt_offset                  decimal(5,2)
 s_税_percentage              decimal(5,2)

2.4.2          Call Center (CC)

               Each 行 in this 表 represents details of a call center.

                                              Table 2-9 Call_center Column Definitions
 Column                       Datatype                   NULLs       Primary Key     Foreign Key
 cc_call_center_sk            identifier                 N           Y
 cc_call_center_id (B)        char(16)                   N
 cc_rec_start_日期            日期
 cc_rec_end_日期              日期
 cc_closed_日期_sk            identifier                                             d_日期_sk
 cc_open_日期_sk              identifier                                             d_日期_sk
 cc_name                      varchar(50)
 cc_class                     varchar(50)
 cc_employees                 integer
 cc_sq_ft                     integer
 cc_hours                     char(20)
 cc_manager                   varchar(40)
 cc_mkt_id                    integer
 cc_mkt_class                 char(50)
 cc_mkt_desc                  varchar(100)
 cc_market_manager            varchar(40)
 cc_division                  integer
 cc_division_name             varchar(50)
 cc_company                   integer
 cc_company_name              char(50)
 cc_street_number             char(10)
 cc_street_name               varchar(60)
 cc_street_type               char(15)
 cc_suite_number              char(10)
 cc_city                      varchar(60)
 cc_county                    varchar(30)
 cc_state                     char(2)
 cc_zip                       char(10)
 cc_country                   varchar(20)
 cc_gmt_offset                decimal(5,2)
 cc_税_percentage            decimal(5,2)

2.4.3          Catalog_page (CP)

               Each 行 in this 表 represents details of a catalog page.

                                             Table 2-10 Catalog Page Column Definitions
 Column                           Datatype                   NULLs         Primary Key       Foreign Key
 cp_catalog_page_sk               identifier                 N             Y
 cp_catalog_page_id (B)           char(16)                   N
 cp_start_日期_sk                 identifier                                                 d_日期_sk
 cp_end_日期_sk                   identifier                                                 d_日期_sk
 cp_department                    varchar(50)
 cp_catalog_number                integer,
 cp_catalog_page_number           integer,
 cp_说明                   varchar(100)
 Column                        Datatype                   NULLs            Primary Key    Foreign Key
 cp_type                       varchar(100)

2.4.4         Web_site (WEB)

              Each 行 in this 表 represents details of a web site.

                                             Table 2-11 Web_site Column Definitions
 Column                       Datatype                    NULLs        Primary Key       Foreign Key
 web_site_sk                  identifier                  N            Y
 web_site_id (B)              char(16)                    N
 web_rec_start_日期           日期
 web_rec_end_日期             日期
 web_name                     varchar(50)
 web_open_日期_sk             identifier                                                 d_日期_sk
 web_close_日期_sk            identifier                                                 d_日期_sk
 web_class                    varchar(50)
 web_manager                  varchar(40)
 web_mkt_id                   integer
 web_mkt_class                varchar(50)
 web_mkt_desc                 varchar(100)
 web_market_manager           varchar(40)
 web_company_id               integer
 web_company_name             char(50)
 web_street_number            char(10)
 web_street_name              varchar(60)
 web_street_type              char(15)
 web_suite_number             char(10)
 web_city                     varchar(60)
 web_county                   varchar(30)
 web_state                    char(2)
 web_zip                      char(10)
 web_country                  varchar(20)
 web_gmt_offset               decimal(5,2)
 web_税_percentage           decimal(5,2)

2.4.5         Web_page (WP)

              Each 行 in this 表 represents details of a web page within a web site.

                                           Table 2-12 Web_page Column Definitions
Column                      Datatype                  NULLs       Primary Key                  Foreign Key
wp_web_page_sk              identifier                N           Y
wp_web_page_id (B)          char(16)                  N
wp_rec_start_日期           日期
wp_rec_end_日期             日期
wp_creation_日期_sk         identifier                                                         d_日期_sk
wp_access_日期_sk           identifier                                                         d_日期_sk
wp_autogen_flag             char(1)
wp_客户_sk              identifier                                                         c_客户_sk
wp_url                      varchar(100)
wp_type                     char(50)
wp_char_count               integer
wp_link_count               integer
wp_image_count              integer
wp_max_ad_count             integer
2.4.6          Warehouse (W)

               Each 行 in this dimension 表 represents a 仓库 where items are stocked.

                                           Table 2-13 Warehouse Column Definitions
 Column                       Datatype                   NULLs        Primary Key             Foreign Key
 w_仓库_sk               identifier                 N            Y
 w_仓库_id (B)           char(16)                   N
 w_仓库_name             varchar(20)
 w_仓库_sq_ft            integer
 w_street_number              char(10)
 w_street_name                varchar(60)
 w_street_type                char(15)
 w_suite_number               char(10)
 w_city                       varchar(60)
 w_county                     varchar(30)
 w_state                      char(2)
 w_zip                        char(10)
 w_country                    varchar(20)
 w_gmt_offset                 decimal(5,2)

2.4.7          Customer (C)

               Each 行 in this dimension 表 represents a 客户.

                                        Table 2-14: Customer Table Column Definitions
 Column                           Datatype          NULLs        Primary Key      Foreign Key
 c_客户_sk                    identifier        N            Y
 c_客户_id (B)                char(16)          N
 c_current_cdemo_sk               identifier                                      cd_demo_sk
 c_current_hdemo_sk               identifier                                      hd_demo_sk
 c_current_addr_sk                identifier                                      ca_addres_sk
 c_first_shipto_日期_sk           identifier                                      d_日期_sk
 c_first_sales_日期_sk            identifier                                      d_日期_sk
 c_salutation                     char(10)
 c_first_name                     char(20)
 c_last_name                      char(30)
 c_preferred_cust_flag            char(1)
 c_birth_day                      integer
 c_birth_month                    integer
 c_birth_year                     integer
 c_birth_country                  varchar(20)
 c_login                          char(13)
 c_email_address                  char(50)
 c_last_review_日期_sk            identifier                                      d_日期_sk

2.4.8          Customer_address (CA)

               Each 行 in this 表 represents a unique 客户 address (each 客户 can have more than one
               address)

                                        Table 2-15 Customer_address Column Definitions
 Column                   Datatype               NULLs              Primary Key      Foreign Key
 ca_address_sk            identifier             N                  Y
 ca_address_id (B)        char(16)               N
 ca_street_number         char(10)
 ca_street_name           varchar(60)
 ca_street_type           char(15)
 ca_suite_number          char(10)
 ca_city                  varchar(60)
 ca_county                varchar(30)
 ca_state                 char(2)
 ca_zip                   char(10)
 ca_country               varchar(20)
 ca_gmt_offset            decimal(5,2)
 ca_location_type         char(20)

2.4.9         Customer_demographics (CD)

              The 客户 demographics 表 contains one 行 for each unique combination of 客户 demographic
              information.

                                 Table 2-16 Customer_demographics Column Definitions
Column                       Datatype           NULLs      Primary Key              Foreign Key
cd_demo_sk                   identifier         N          Y
cd_gender                    char(1)
cd_marital_status            char(1)
cd_education_status          char(20)
cd_purchase_estimate         integer
cd_credit_rating             char(10)
cd_dep_count                 integer
cd_dep_employed_count        integer
cd_dep_college_count         integer

2.4.10        Date_dim (D)

              Each 行 in this 表 represents one calendar day. The surrogate key (d_日期_sk) for a given 行 is
              derived from the julian 日期 being described by the 行.

                                          Table 2-17 Date_dim Column Definitions
Column                   Datatype                  NULLs        Primary Key           Foreign Key
d_日期_sk                identifier                N            Y
d_日期_id (B)            char(16)                  N
d_日期                   日期                      N
d_month_seq              integer
d_week_seq               integer
d_quarter_seq            integer
d_year                   integer
d_dow                    integer
d_moy                    integer
d_dom                    integer
d_qoy                    integer
d_fy_year                integer
d_fy_quarter_seq         integer
d_fy_week_seq            integer
d_day_name               char(9)
d_quarter_name           char(6)
d_holiday                char(1)
d_weekend                char(1)
d_following_holiday      char(1)
d_first_dom              integer
d_last_dom               integer
d_same_day_ly            integer
d_same_day_lq            integer
d_current_day            char(1)
Column                         Datatype                  NULLs       Primary Key                     Foreign Key
d_current_week                 char(1)
d_current_month                char(1)
d_current_quarter              char(1)
d_current_year                 char(1)

2.4.11        Household_demographics (HD)

              Each 行 of this 表 defines a household demographic profile.

                                     Table 2-18 Household_demographics Column Definition
                Column                      Datatype             NULLs    Primary Key            Foreign Key
                hd_demo_sk                  identifier           N        Y
                hd_income_band_sk           identifier                                           ib_income_band_sk
                hd_buy_potential            char(15)
                hd_dep_count                integer
                hd_vehicle_count            integer

2.4.12        Item (I)

              Each 行 in this 表 represents a unique product formulation (e.g., size, color, manufactuer, etc.).

                                                 Table 2-19 Item Column Definition
            Column                        Datatype                   NULLs     Primary Key            Foreign Key
            i_item_sk                     identifier                 N         Y
            i_item_id (B)                 char(16)                   N
            i_rec_start_日期              日期
            i_rec_end_日期                日期
            i_item_desc                   varchar(200)
            i_current_价格               decimal(7,2)
            i_wholesale_成本              decimal(7,2)
            i_brand_id                    integer
            i_brand                       char(50)
            i_class_id                    integer
            i_class                       char(50)
            i_category_id                 integer
            i_category                    char(50)
            i_manufact_id                 integer
            i_manufact                    char(50)
            i_size                        char(20)
            i_formulation                 char(20)
            i_color                       char(20)
            i_units                       char(10)
            i_container                   char(10)
            i_manager_id                  integer
            i_product_name                char(50)

2.4.13        Income_band (IB)

              Each 行 in this 表 represents details of an income range.

                                           Table 2-20: Income_band Column Definitions
              Column                       Datatype                  NULLs         Primary Key             Foreign Key
              ib_income_band_sk            identifier                N             Y
              ib_lower_bound               integer
              ib_upper_bound               integer

2.4.14        Promotion (P)
             Each 行 in this 表 represents details of a specific product promotion (e.g., advertising, sales, PR).

                                       Table 2-21: Promotion Column Definitions
                   Column               Datatype           NULLs           Primary Key       Foreign Key
                   p_promo_sk           identifier         N               Y
                   p_promo_id (B)       char(16)           N
                   p_start_日期_sk      identifier                                           d_日期_sk
                   p_end_日期_sk        identifier                                           d_日期_sk
                   p_item_sk            identifier                                           i_item_sk
                   p_成本               decimal(15,2)
                   p_response_target    integer
                   p_promo_name         char(50)
                   p_channel_dmail      char(1)
                   p_channel_email      char(1)
                   p_channel_catalog    char(1)
                   p_channel_tv         char(1)
                   p_channel_radio      char(1)
                   p_channel_press      char(1)
                   p_channel_event      char(1)
                   p_channel_demo       char(1)
                   p_channel_details    varchar(100)
                   p_purpose            char(15)
                   p_折扣_active    char(1)

2.4.15       Reason (R)

             Each 行 in this 表 represents a reason why an item was returned.

                                         Table 2-22: Reason Column Definitions
                Column                 Datatype                NULLs                Primary Key      Foreign Key
                r_reason_sk            identifier              N                    Y
                r_reason_id (B)        char(16)                N
                r_reason_desc          char(100)

2.4.16       Ship_mode (SM)

         Each 行 in this 表 represents a shipping mode.
                                       Table 2-23: Ship_mode Column Definitions
               Column                         Datatype                 NULLs        Primary Key          Foreign Key
               sm_ship_mode_sk                identifier               N            Y
               sm_ship_mode_id (B)            char(16)                 N
               sm_type                        char(30)
               sm_code                        char(10)
               sm_carrier                     char(20)
               sm_contract                    char(20)

2.4.17       Time_dim (T)

             Each 行 in this 表 represents one second.

                                       Table 2-24: Time_dim Column Definitions
                Column                    Datatype                         NULLs     Primary Key         Foreign Key
                t_time_sk                 Identifier                       N         Y
                t_time_id (B)             char(16)                         N
                t_time                    Integer                          N
                t_hour                    Integer
                Column                    Datatype                  NULLs     Primary Key        Foreign Key
                t_minute                  Integer
                t_second                  Integer
                t_am_pm                   char(2)
                t_shift                   char(20)
                t_sub_shift               char(20)
                t_meal_time               char(20)




2.4.18       dsdgen_version

             This 表 is not employed during the 基准测试. A 平面文件 is generated by dsdgen (see Appendix F), and it
             can be helpful in assuring that the current data set was built with the correct version of the TPC-DS toolkit.
             It is included here for completeness.

                                     Table 2-25: dsdgen_version Column Definitions
                  Column                         Datatype                       NULLs       Foreign Key
                  dv_version                     Varchar(16)                    N
                  dv_create_日期                 日期                           N
                  dv_create_time                 time                           N
                  dv_cmdline_args                Varchar(200)                   N




2.5       Implementation Requirements

2.5.1        Definition of Terms

2.5.1.1      The 表 defined in Clause 2.3 and Clause 2.4 are referred to as base 表. The 平面文件 data generated by
             dsdgen corresponding to each base 表 and loaded into each base 表 is referred to as base 表 data. A
             structure containing base 表 data is referred to as a base 表 data structure.
2.5.1.2      Other than the base 表 data structures, any 数据库 structure that contains a copy of, reference to, or data
             computed from base 表 data is defined as an auxiliary data structures (ADS). The data in the ADS is
             materialized from the base 表 data; references are a form of materialization. There is an essential distinction
             between base 表 data contained in a base 表 data structure and data contained in auxiliary data structures.
             Because auxiliary data structures contain copies of, references to, or data computed from base 表 data,
             deleting data from an auxiliary data structure does not 结果 in the loss of base 表 data in that it is still
             contained in the base 表 data structure. In contrast, deleting data from a base 表 data structure (in the
             absence of copies in any auxiliary data structures) does 结果 in the loss of base 表 data.
2.5.1.3      There are two types of auxiliary data structures: Implicit and explicit. An explicit auxiliary data structure
             (EADS) is created as a consequence of a directive (e.g. DDL, session options, global 配置 parameters).
             These directives are called EADS Directives. Any ADS which is not an EADS is by 定义 an Implict ADS
             (IADS).
                 Comment:       In contrast to an implicit ADS, an EADS would not have been created without the
                                directive.
2.5.1.4      The assignment of groups of 行 from a 表 or EADS to different files, disks, or areas is defined as
             horizontal partitioning.
2.5.1.5      The assignment of groups of 列 of one or more 行 to files, disks, or areas different from those storing
             the other 列 of these 行 is defined as vertical partitioning.
2.5.1.6      A Primary Key is one or more 列 that uniquely identifies a 行. None of the 列 that are 零件 of the
             Primary Key 可 be nullable. A 表 must have no more than one Primary Key. A 主键 可 be
             enforced, e.g. by a 主键 约束.
2.5.1.7    A Foreign Key is a 列 or combination of 列 used to establish a link between the data in two 表.
           A link is created between two 表 by adding the 列 or 列 that hold one 表's Primary Key 值
           to the other 表. This 列 becomes a Foreign Key in the second 表. A 外键 可 be enforced, e.g.
           by a 外键 约束.Referential Integrity is a data property whereby a Foreign Key in one 表 has a
           corresponding Primary key in a different 表.
2.5.1.8    The 定义 of primary and foreign keys is optional.
2.5.1.9    Whenever this 规范 refers to a set of primary and foreign keys it refers to the set of primary and foreign
           keys defined in clauses 2.3 and 2.4.

2.5.2      Data Processing System & Tables

2.5.2.1    The data processing 系统 应 be implemented using a generally available and supported 系统 (DBMS).
2.5.2.2    The SQL data 定义 statements and associated scripts used to 实现 the logical 模式 定义 are
           defined as the DDL.
2.5.2.3    The 数据库 which is built and utilized to run the Query Validation test is defined as the qualification
           数据库.
2.5.2.4    The 数据库 which is built and utilized for 性能 reporting is defined as the test 数据库.
2.5.2.5    The physical clustering of 记录 of different 表 within the 数据库 is allowed as long as this clustering
           does not alter the logical relationships of each 表.
           Comment: The intent of this 子句 is to permit flexibility in the physical layout of a 数据库 and based
           upon the defined TPC-DS 模式.
2.5.2.6    Table names 应 match those provided in Clause 2.3 and Clause 2.4. If the data processing 系统 prevents
           the use of the 表 names specified in Clause 2.3 and Clause 2.4, they 可 be altered provided that:
            • The name changes are minimal (e.g., short prefix or suffix.)
            • The name changes have no 性能 impact
            • The name changes are also made to the 查询 set, in 合规 with Clause 4.2.3
2.5.2.7    Each 表 listed in Clause 2.3 and Clause 2.4, 应 be implemented according to the 列 definitions
           provided above.
2.5.2.8    The 列 names used in the 基准测试 实现 应 match those defined for each 列 specified
           in Clause 2.3 and Clause 2.4. If the data processing 系统 prevents the use of the 列 names specified in
           Clause 2.3 and Clause 2.4, they 可 be altered provided:
            • The name changes are the minimal changes required (e.g., short prefix or suffix or character
               substitution.)
            • The changed names are required to follow the documented naming convention employed in the
               系统 used for the 基准测试 实现
            • The names used must provide no 性能 benefit compared to any other names that might
               be chosen.
            • The identical name changes must also be made to the 查询 set, in 合规 with Clause 4.2.3
2.5.2.9    The 列 within a given 表 可 be implemented in any 订单, but all 列 listed in the 表 定义
           应 be implemented and there 应 be no 列 added to the 表.
2.5.2.10   Each 表 列 defined in Clause 2.3 and Clause 2.4 应 be implemented as discrete 列 and 应 be
           independently accessible by the data processing 系统 as a single 列. Specifically:
            • Columns 应 not be merged. For 示例, C_LOGIN and C_EMAIL_ADDRESS cannot be
               implemented as two sub-parts of a single discrete 列 C_DATA.
            • Columns 应 not be split. For 示例, P_TYPE cannot be implemented as two discrete 列
               P_TYPE_SUBSTR1 and P_TYPE_SUBSTR2.
2.5.2.11   The 数据库 应 allow for insertion of arbitrary data 值 that conform to the 列’s datatype and
           optional constraints defined in accordance with Clause 2.5.4.
2.5.3       Explicit Auxiliary Data Structures (EADS)

2.5.3.1     Except as provided in this 节, 复制 of 数据库 objects (i.e., 表, 行 or 列) is prohibited.
2.5.3.2     An EADS which does not include data materialized from Catalog_Sales or Catalog_Returns is subject to the
            following limitations:
             • It 可 materialize data from no more than one base 表.
             • It 可 materialize all or some of the following three items:
                         1. The 主键 or any subset of PK 列 if the PK is a compound key
                         2. Pointers or references to corresponding base 表 行 (e.g., “行 IDs”).
                         3. At most one of the following:
                                   a) A 外键 or any subset of the FK 列 if the FK is a compound key
                                   b) A 列 having a 日期 data type
                                   c) A 列 that is a business key
2.5.3.3     An EADS which includes data materialized from Catalog_Sales or Catalog_Returns 可 not include any data
            materialized from Store_Sales, Store_Returns, Web_Sales, Web_Returns or Inventory.
2.5.3.4     An EADS which materializes data from both fact and dimension 表 必须 the 结果 of joining on FK – PK
            related 列.
2.5.3.5     An EADS which materializes data from one or more dimension 表 without simultaneously materializing
            data from Catalog_Sales and/or Catalog_Returns is disallowed, unless otherwise permitted by Clause 2.5.3.2.
            An EADS which materializes data from one or more dimension 表 must materialize at least one dimension
            行 for every fact 表 行, unless the 外键 值 for a dimension 行 is null.
            Comment: The intent is to prohibit the creation of EADS on only dimension 表, except as allowed by
            子句 2.5.3.3.
2.5.3.6     The 基准测试 实现 of EADS 可 involve 复制 of selected data from the base 表
            provided that:
             • All replicated data are managed by the 系统 used for the 基准测试 实现
             • All replications are transparent to all data manipulation operations
2.5.3.7     The creation of all EADS 必须 included in the 数据库 load test (see Clause 7.4.3). EADS 可 not be
            created or deleted during the 性能 test.
2.5.3.8     Partitioning

2.5.3.8.1   A logical 表 space is a named collection of physical storage devices referenced as a single, logically
            contiguous, non-divisible entity.

2.5.3.8.2   The DDL 可 include syntax that directs a 表 in its entirety to be stored in a particular logical 表 space.

2.5.3.8.3   Horizontal partitioning of base 表 or EADS is allowed. If the partitioning is a function of data in the 表
            or auxiliary data structure, the assignment 应 be based on the 值 in the partitioning 列(s). Only
            primary keys, foreign keys, 日期 列 and 日期 surrogate keys 可 be used as partitioning 列. If
            partitioning DDL uses directives that specify explicit partition 值 for the partitioning 列, they 应
            satisfy the following conditions:
             • They 可 not rely on any knowledge of the data stored in the partitioning 列(s) except the
                 minimum and maximum 值 for those 列, and the 定义 of data types for those
                 列 provided in Clause 2.
             • Within the limitations of integer division, they 应 define each partition to accept an equal
                 portion of the range between the minimum and maximum 值 of the partitioning 列(s).
             • For 日期-based partitions, it is permissible to partition into equally sized domains based upon an
                 integer granularity of days, weeks, months, or years; all using the Gregorian calendar (e.g., 30
                 days, 4 weeks, 1 month, 1 year, etc.). For 日期-based partition granularities other than days, a
                 partition boundary 可 extend beyond the minimum or maximum boundaries as established in
                 that 表’s data characteristics as defined in Clause 3.4
                • The directives 应 allow the insertion of 值 of the partitioning 列(s) outside the range
                  covered by the minimum and maximum 值, as required by Clause 1.5.

               If any directives or DDL are used to horizontally partition data, the directives, DDL, and other details
               necessary to replicate the partitioning behavior 应 be disclosed.

               Multi-level partitioning of base 表 or auxiliary data structures is allowed only if each level of
               partitioning satisfies the conditions stated above.

2.5.3.8.4      Vertical partitioning of base 表 or EADS is allowed when meeting all of the following 要求:
               • SQL DDL that explicitly partitions data vertically is prohibited.
               • SQL DDL must not contain partitioning directives which influence the physical placement of data
                   on durable media.
               • The 行 必须 logically presented as an atomic set of 列.
               Comment: This implies that vertical partitioning which does not rely upon explicit partitioning directives
               is allowed. Explicit partitioning directives are those that assign groups of 列 of one 行 to files, disks
               or areas different from those storing the other 列 in that 行.

2.5.4          Constraints

2.5.4.1        The use of both enforced and unenforced constraints is permitted. If constraints are used, they 应 satisfy the
               following 要求:
                • Enforced constraints 应 be enforced either at the statement level or at the 事务 level
                • Unenforced constraints 必须 validated after all data is loaded during the Load Test and before
                    the start of the Performance Test
                • They are limited to 主键, 外键, and NOT NULL constraints
                • NOT NULL constraints are allowed on EADSs and 表. Only 列 that are marked 'N' in
                    their logical 表 定义 (or 列 in EADSs derived from such 列) can be
                    constrained with NOT NULL.

2.5.4.2        If 外键 constraints are defined and enforced, there is no specific 要求 for a particular
               delete/update action when enforcing a 约束 (e.g., ANSI SQL RESTRICT, CASCADE, NO ACTION, are
               all acceptable).

2.6         Data Access Transparency Requirements

2.6.1          Data Access Transparency is the property of the 系统 that removes from the 查询 text any knowledge of
               the physical location and access mechanisms of partitioned data. No finite series of tests can prove that the
               系统 supports complete data access transparency. The 要求 below describe the minimum
               capabilities needed to establish that the 系统 provides transparent data access. A 基准测试
               实现 that uses horizontal partitioning 应 meet the 要求 for transparent data access
               described in Clauses 2.6.2 and 2.6.3.

               Comment: The intent of this 子句 is to require that access to physically and/or logically partitioned data
               be provided directly and transparently by services implemented by generally available layers such as the
               interactive SQL interface, the data processing 系统, the operating 系统 (OS), the 硬件, or any
               combination of these.

2.6.2          Each of the 表 described in Clause 2.3 and Clause 2.4 应 be identifiable by names that have no
               relationship to the partitioning of 表. All data manipulation operations in the executable 查询 text (see
               Clause 3) 应 use only these names.

2.6.3          Using the names which satisfy Clause 2.6.2, any arbitrary non-TPC-DS 查询 应 be able to reference any
               set of 行 or 列 that is:
• Identifiable by any arbitrary condition supported by the underlying 系统
• Using the names described in Clause 2.6.2 and using the same data manipulation semantics and
  syntax for all 表

For 示例, the semantics and syntax used to 查询 an arbitrary set of 行 in any one 表 应 also be
usable when querying another arbitrary set of 行 in any other 表.

Comment: The intent of this 子句 is that each TPC-DS 查询 uses general purpose mechanisms to access
data in the 数据库.
                                       3     Scaling and Database Population

           This 子句 defines the 数据库 population and how it scales.

3.1     Scaling Model

3.1.1      The TPC-DS 基准测试 defines a set of discrete scaling points (“scale factors”) based on the approximate
           size of the raw data produced by dsdgen. The actual byte count 可 vary depending on individual
           硬件 and 软件 platforms.

3.1.2      The set of scale factors defined for TPC-DS is:

            • 1TB, 3TB, 10TB, 30TB, 100TB

           where terabyte (TB) is defined to be 240 bytes.

           Comment: The maximum size of the test 数据库 for a valid 性能 test is currently set at 100TB.
           The TPC recognizes that additional 基准测试 development work is necessary to allow TPC-DS to scale
           beyond that limit.

3.1.3      Each defined 规模因子 has an associated 值 for SF, a unit-less 数量, roughly equivalent to the
           number of gigabytes of data present in the data 仓库. The relationship between scale factors and SF is
           summarized in Table 3-1 Scale Factor and SF.

                                            Table 3-1 Scale Factor and SF

                                      Scale Factor           SF
                                      1TB                    1000
                                      3TB                    3000
                                      10TB                   10000
                                      30TB                   30000
                                      100TB                  100000

3.1.4      Test sponsors 可 choose any 规模因子 from the defined series. No other scale factors 可 be used for a
           TPC-DS 结果.

3.1.5      Results at the different scale factors are not comparable, due to the substantially different computational
           challenges found at different data volumes.

3.2     Test Database Scaling

3.2.1      Test 数据库 is the 数据库 used to execute the 数据库 load test and the 性能 test (see Clause
           7.4)

3.2.2      The required 行 count for each permissible 规模因子 and each 表 in the test 数据库 is detailed in
           Table 3-2 Database Row Counts.

           Comment: The 1GB entries are used solely for the qualification 数据库 (see Clause 3.3.1) and are
           included here for ease of reference.

3.2.3      The 行 size information provided is an estimate, and 可 vary from one 基准测试 submission to
           another depending on the precise data base 实现 that is selected. It is provided solely to assist
           基准测试 sponsors in the sizing of 基准测试 configurations.
                                                       Table 3-2 Database Row Counts
             Table             Avr        Sample Row Counts.
                               Row
                               Size        1GB             1TB              3TB              10TB              30TB             100TB
                               in bytes

             call_center
                                    305            6               42               48                54                60                60

             catalog_page
                                    139      11,718           30,000           36,000            40,000            46,000            50,000

             catalog_returns
                                    166     144,067      143,996,756      432,018,033      1,440,033,112     4,319,925,093    14,400,175,879

             catalog_sales
                                    226 1,441,548       1,439,980,416    4,320,078,880    14,399,964,710    43,200,404,822 143,999,334,399

             客户
                                    132     100,000       12,000,000       30,000,000        65,000,000        80,000,000       100,000,000
             客户_addres
             s                      110      50,000        6,000,000       15,000,000        32,500,000        40,000,000        50,000,000
             客户_
             demographics            42 1,920,800          1,920,800        1,920,800          1,920,800         1,920,800         1,920,800

             日期_dim
                                    141      73,049           73,049           73,049            73,049            73,049            73,049
             household_
             demographics            21       7,200              7,200            7,200             7,200             7,200             7,200

             income_band
                                     16           20               20               20                20                20                20

             inventory
                                     16 11,745,000       783,000,000     1,033,560,000     1,311,525,000     1,627,857,000     1,965,337,830

             item
                                    281      18,000          300,000          360,000           402,000           462,000           502,000

             promotions
                                    124          300             1,500            1,800             2,000             2,300             2,500

             reason
                                     38           35               65               67                70                72                75

             ship_mode
                                     56           20               20               20                20                20                20

             store
                                    263           12             1,002            1,350             1,500             1,704             1,902

             store_returns
                                    134     287,514      287,999,764      863,989,652      2,879,970,104     8,639,952,111    28,800,018,820

             store_sales
                                    164 2,880,404       2,879,987,999    8,639,936,081    28,799,983,563    86,399,341,874 287,997,818,084

             time_dim
                                     59      86,400           86,400           86,400            86,400            86,400            86,400

             仓库
                                    117            5               20               22                25                27                30

             web_page
                                     96           60             3,000            3,600             4,002             4,602             5,004

             web_returns
                                    162      71,763       71,997,522      216,003,761       720,020,485      2,160,007,345     7,199,904,459

             web_sales
                                    226     719,384      720,000,376     2,159,968,881     7,199,963,324    21,600,036,511    71,999,670,164

             web_site
                                    292           30               54               66                78                84                96




3.3     Qualification Database Scaling

3.3.1      The Qualification 数据库 is the 数据库 used to execute the 查询 validation test (see Clause 7.3)

3.3.2      The intent is that the functionality exercised by running the validation queries against the qualification
           数据库 be the same as that exercised against the test 数据库 during the 性能 test. To this end,
           the qualification 数据库 必须 identical to the test 数据库 in virtually every regard (except size),
           including but not limited to:
            a) Column definitions
            b) Method of data generation and loading (but not degree of parallelism)
            c) Statistics gathering method
            d) Data accessibility 实现
            e) Type of partitioning (but not degree of partitioning)
            f) Replication
            g) Table type (if there is a choice)
            h) EADS (e.g., indices)

3.3.3      The qualification 数据库 可 differ from the test 数据库 only if the difference is directly related to the
           difference in sizes. For 示例, if the test 数据库 employs horizontal partitioning (see Clause 2.5.3.7),
           then the qualification 数据库 must also employ horizontal partitioning, though the number of partitions
           可 differ in each case. As another 示例, the qualification 数据库 could be configured such that it uses
           a representative sub-set of the CPUs, memory and disks used by the test 数据库 配置. If the
           qualification 数据库 配置 differs from the test 数据库 配置 in any way, the differences
           必须 disclosed

3.3.4      The qualification 数据库 必须 populated using dsdgen, and use a 规模因子 of 1GB.

3.3.5      The 行 counts of the qualification 数据库 are defined in Clause 3.2.

3.4     dsdgen and Database Population

3.4.1      The test 数据库 and the qualification 数据库 必须 populated with data produced by dsdgen, the
           TPC-supplied data generator for TPC-DS. The major and minor version number of dsdgen must match that
           of the TPC-DS 规范. The source code for dsdgen is provided as 零件 of the electronically
           downloadable portion of this 规范 (see Appendix F).

3.4.2      The data generated by dsdgen are meant to be compliant with Table 3-2 and Table 5-2. In case of
           differences between the 表 and the data generated by dsdgen, dsdgen prevails.

3.4.3      Vendors are allowed to modify the dsdgen code for both the initial 数据库 population and the data
           维护. However, the resultant data must meet the following 要求 in 订单 to be considered
           correct:

            a) The content of individual 列 必须 identical to that produced by dsdgen.
            b) The data format of individual 列 必须 identical to that produced by dsdgen.
            c) The number of 行 generated for a given 规模因子 必须 identical to that specified in Table 3-2
               and Table 5-2.

           If a modified version of dsdgen is used, the modified source code 必须 disclosed in full. In addition, the
           auditor must verify that the modified source code which is disclosed matches the data generation program
           used in the 基准测试 执行.

           Comment: The intent of this 子句 is to allow for modification of the dsdgen code required for portability
           or speed, while precluding any change that affects the resulting data. Minor changes for portability or bugs
           are permitted in dsdgen for both initial 数据库 population and data 维护.

3.4.4      If modifications are restricted to a subset of the source code, the vendor 可 publish only the individual
           dsdgen source code files which have been modified.
3.4.5      The 输出 of dsdgen is text. The content of each 字段 is terminated by '|'. A '|' in the first position of a 行
           indicates that the first 列 of the 行 is empty. Two consecutive '|' indicate that the given 列
           值 is empty. Empty 列 值 are only generated for 列 that are NULL-able as specified in
           the logical 数据库 design. Empty 列 值, as generated by dsdgen, 必须 treated as NULL 值
           in the data processing 系统, i.e. the data processing 系统 必须 able to retrieve NULL-able 列
           using 'is null' predicates.
           Comment: The data generated by dsdgen includes some international characters. Examples of international
           characters are Ô and É. The 数据库 must preserve these characters during loading and processing by using a
           character encoding such as ISO/IEC 8859-1 that includes these characters.

3.5     Data Validation

           The test 数据库 必须 verified for correct data content. This 必须 done after the initial 数据库 load
           and prior to any 性能 tests. A validation data set is produced using dsdgen with the “-validate”
           and “-vcount” options. The minimum 值 for “-vcount” is 50, which produces 50 行 of validation data
           for most 表. The exceptions being the “returns” fact 表 which will only have 5 行 each on average
           and the dimension 表 with fewer than 50 total 行.

           All 行 produced in the validation data set must exist in the test 数据库.
                                          4     Query Overview

4.1       General Requirements and Definitions for Queries

4.1.1        Query Definition and Availability

4.1.1.1      Each 查询 is described by the following components:
              a) A business question, which illustrates the business context in which the 查询 could be used. The
                 business questions are listed in Appendix B.
              b) The functional 查询 定义, as specified in the TPC-supplied 查询 template (see Clause 4.1.2 for a
                 discussion of Functional Query Definitions)
              c) The substitution parameters, which describe the substitution 值 needed to generate the executable
                 查询 text
              d) The answer set, which is used in 查询 validation (see Clause 7.3)
Comment: Some functional 查询 definitions include a limit on the number of 行 to be returned by the 查询. These
         limits are omitted from the business question.
Comment: In cases where the business question does not accurately describe the functional 查询 定义, the latter will
         prevail.
Comment: Queries are designed to test various aspects of a typical data 仓库 系统. This includes the 查询
         优化器’s ability to transform any valid SQL queries as they 可 be written by humans or tools into their
         most optimal form. Hence, the TPC-DS provided 查询 templates 可 include unnecessary or non-optimal SQL
         structures
4.1.1.2      Due to the large size of the TPC-DS 查询 set, this document does not contain all of the 查询 components.
             Refer to Table 0-1 Electronically Available Specification Material for information on obtaining the 查询 set.

4.1.2        Functional Query Definitions

4.1.2.1      The functionality of each 查询 is defined by its 查询 template and dsqgen.

4.1.3        dsqgen translates the 查询 templates into fully functional SQL, which is known as executable 查询 text
             (EQT). The major and minor version number of dsqgen must match that of the TPC-DS 规范. The
             source code for dsqgen is provided as 零件 of the electronically downloadable portion of this 规范
             (see Table 0-1 Electronically Available Specification Material).
4.1.3.1      The 查询 templates are primarily phrased in 合规 with SQL1999 core (with OLAP amendments). A
             template includes the following, non-standard additions:
              • They are annotated, where necessary, to specify the number of 行 to be returned
              • They include substitution tags that, in conjunction with dsqgen, allow a single template to
                 generate a large number of syntactically distinct queries, which are functionally equivalent
4.1.3.2      The executable 查询 text for each 查询 in a compliant 实现 必须 taken from either the
             functional 查询 定义 or an approved 查询 variant (see Clause Appendix C). Except as specifically
             allowed in Clauses 4.2.3, Error! Reference source not found.4.2.4 and 4.2.5, executable 查询 text 必须
             used in full, exactly as provided by the TPC.
4.1.3.3      Any 查询 template whose EQT does not match the functionality of the corresponding EQT produced by the
             TPC-supplied template is invalid.
4.1.3.4      All 查询 templates and their substitution parameters 应 be disclosed.
4.1.3.5      Benchmark sponsors are allowed to alter the precise phrasing of a 查询 template to allow for minor differences
             in product functionality or 查询 dialect as defined in Clause 4.2.3.
4.1.3.6      If the alterations allowed by Clause 4.2.3 are not sufficient to permit a 基准测试 sponsor to produce EQT that
             can be executed by the DBMS selected for their 基准测试 submission, they 可 submit an alternate 查询
             template for approval by the TPC (see Clause 4.2.3.4).
4.1.3.7      If the 查询 template used in a 基准测试 submission is not identical to a template supplied by the TPC, it must
             satisfy the 合规 要求 of Clauses 4.2.3, 4.2.4 and 4.2.5.

4.2       Query Modification Methods

4.2.1        The queries 必须 expressed in a commercially available 实现 of the SQL language. Since the
             ISO SQL language is continually evolving, the TPC-DS 基准测试 规范 permits certain deviations
             from the SQL phrasing used in the TPC-supplied 查询 templates.

4.2.2        There are four types of permissible deviations:

              a) Minor 查询 modifications, defined in Clause 4.2.3
              b) Modifications to limit 行 counts, defined in 子句 4.2.4
              c) Modifications for extraction queries, defined in 子句 4.2.5
              d) Approved 查询 variants, defined in Appendix C

4.2.3        Minor Query Modifications
4.2.3.1      It is recognized that implementations require specific adjustments for their operating environment and the
             syntactic variations of its dialect of the SQL language. The 查询 modifications described in Clause 4.2.3.4:
              • Are defined to be minor
              • Do not require approval
              • May be used in conjunction with any other minor 查询 modifications
              • May only be used to modify a functional 查询 定义 or its approved variants

             Modifications that do not fall within the bounds described in Clause 4.2.3.4 are not minor and are not
             compliant unless they are an integral 零件 of an approved 查询 variant (see Appendix C).

             Comment: The only exception is for the queries that require a given number of 行 to be returned. The
             要求 governing this exception are given in Clause 4.2.4.1
             Comment: Bullet 4 in above list prevents applying minor 查询 modifications to generated sql text
4.2.3.2      The application of minor 查询 modifications to functional 查询 definitions or approved variants 必须
             consistent over the functional 查询 set or their approved variants. For 示例, if a particular vendor-specific
             日期 expression or 表 name syntax is used in one 查询, it 必须 used in all other queries involving 日期
             expressions or 表 names. The following 查询 modifications are exempt from this 要求: e5, f2, f6,
             f10, g2 and g3.
4.2.3.3      The use of minor modifications 应 be disclosed and justified (see Clause 10.3.4.4).
4.2.3.4      The following 查询 modifications are minor:

            a) Tables:

                1. Table names - The 表 and view names found in the CREATE TABLE, CREATE VIEW, DROP
                   VIEW and FROM 子句 of each 查询 可 be modified to reflect the customary naming
                   conventions of the 系统 under test.
                2. Tablespace references - CREATE TABLE statements 可 be augmented with a tablespace reference
                   conforming to the 要求 of Clause 3.
                3. WITH() 子句 - Queries using the "with()" syntax, also known as common 表 sub-expressions,
                        can be replaced with semantically equivalent derived 表 or views.

            b) Joins:

                1. Outer Join - For outer 连接 queries, vendor specific syntax 可 be used instead of the specified
                        syntax. For 示例, the 连接 expression "CUSTOMER LEFT OUTER JOIN ORDERS ON
       C_CUSTKEY = O_CUSTKEY" 可 be replaced by adding CUSTOMER and ORDERS to the from
       子句 and adding a specially-marked 连接 谓词 (e.g., C_CUSTKEY *= O_CUSTKEY).
    2. Inner Join - For inner 连接 queries, vendor specific syntax 可 be used instead of the specified
       syntax. For 示例, the 连接 expression "FROM CUSTOMER, ORDERS WHERE C_CUSTKEY =
       O_CUSTKEY" 可 be modified to use a JOIN 子句 such as "FROM CUSTOMER JOIN ORDERS
       ON C_CUSTKEY = O_CUSTKEY".

c) Operators:

    1.      Explicit ASC - ASC 可 be explicitly appended to 列 in an ORDER BY 子句.
    2.      Relational operators - Relational operators used in queries such as "<", ">", "<>", "<=", and "=", 可
            be replaced by equivalent vendor-specific operators, for 示例 ".LT.", ".GT.", "!=" or "^=", ".LE.",
            and "==", respectively.
    3.      String concatenation operator - For queries which use string concatenation operators, vendor
            specific syntax can be used (e.g. || can be substituted with +).
    4.      Rollup operator - an operator of the form "rollup (x,y)" 可 be substituted with the following
            operator: "x,y with rollup". x,y are expressions.
d) Control statements:

    1. Command delimiters - Additional syntax 可 be inserted at the end of the executable 查询 text for
            the purpose of signaling the end of the 查询 and requesting its 执行. Examples of such
            command delimiters are a semicolon or the word "GO".
    2. Transaction control statements - A CREATE/DROP TABLE or CREATE/DROP VIEW statement
       可 be followed by a COMMIT WORK statement or an equivalent vendor-specific 事务
       control statement.
    3. Dependent views - If an 实现 is using variants involving views and the 实现
       only supports “DROP RESTRICT” semantics (i.e., all dependent objects 必须 dropped first), then
       additional DROP statements for the dependent views 可 be added.

e) Alias:

    1. Select-list expression aliases - For queries that include the 定义 of an alias for a SELECT-list
       item (e.g., "AS" 子句), vendor-specific syntax 可 be used instead of the specified syntax.
       Examples of acceptable implementations include "TITLE <string>", or "WITH HEADING <string>".
       Use of a select-list expression alias is optional.
    2. GROUP BY and ORDER BY - For queries that utilize a view, nested 表-expression, or select-list
       alias solely for the purposes of grouping or ordering on an expression, vendors 可 replace the
       view, nested 表-expression or select-list alias with a vendor-specific SQL extension to the
       GROUP BY or ORDER BY 子句. Examples of acceptable implementations include "GROUP BY
       <ordinal>", "GROUP BY <expression>", "ORDER BY <ordinal>", and "ORDER BY <expression>".
    3. Correlation names - Table-name aliases 可 be added to the executable 查询 text. The keyword
       "AS" before the 表-name alias 可 be omitted.
    4. Nested 表-expression aliasing - For queries involving nested 表-expressions, the nested
       keyword "AS" before the 表 alias 可 be omitted.
    5. Column alias - 列 name alias 可 be added for 列 in any SELECT list of an executable
            查询 text. These 列 aliases 可 be used to refer to the 列 in later portions of the 查询,
            such as GROUP BY or ORDER BY clauses.

f) Expressions and functions:
   1. Date expressions - For queries that include an expression involving manipulation of dates (e.g.,
      adding/subtracting days/months/years, or extracting years from dates), vendor-specific syntax 可
      be used instead of the specified syntax. Examples of acceptable implementations include
      "YEAR(<列>)" to extract the year from a 日期 列 or "DATE(<日期>) + 3 MONTHS" to add
      3 months to a 日期.
   2. Output formatting functions - Scalar functions whose sole purpose is to affect 输出 formatting
      (such as treatment of null strings) or intermediate arithmetic 结果 precision (such as COALESCE
      or CAST) 可 be applied to items in the outermost SELECT list of the 查询.
   3. Aggregate functions - At large scale factors, the aggregates 可 exceed the range of the 值
        supported by an integer. The 聚合 functions AVG and COUNT 可 be replaced with
        equivalent vendor-specific functions to handle the expanded range of 值 (e.g., AVG_BIG and
        COUNT_BIG).
   4. Substring Scalar Functions - For queries which use the SUBSTRING() scalar function, vendor-
      specific syntax 可 be used instead of the specified syntax. For 示例, "SUBSTRING(S_ZIP, 1,
      5)".
   5. Standard Deviation Function - For queries which use the standard deviation function
      (stddev_samp), vendor specific syntax 可 be used (e.g. stdev, stddev).
   6. Explicit Casting - Scalar functions (such as CAST) whose sole purpose is to affect 结果 precision for
      operations involving integer 列 or 值 可 be applied. The resulting syntax must have
      equivalent semantic behavior.
   7. Mathematical functions - Vendors specific mathematical expressions 可 be used to 实现
        mathematical functions in the executable 查询 text. The replacement syntax must 实现 the
        full semantic behavior (e.g. handling for NULLs) of the mathematical functions as defined in the
        ISO SQL standard. For 示例, avg() 可 be replaced by average() or by a mathematical
        expressions such as sum()/count().
   8. Date casting - Explicit casting of 列 that are of the 日期 datatype, as defined in Clause 2.2.2,
        and 日期 constant strings, expressed in month, day and year, into a datatype that allows for 日期
        arithmetic in expressions is permissible. Replacement syntax must have equivalent semantic
        behavior.
   9. Casting syntax: - Vendor specific casting syntax 可 be used to 实现 casting functions
       present in the executable 查询 text provided that the vendor specific casting syntax is semantically
       equivalent to the syntax provided in the executable 查询 text.
   10. Existing scalar functions - Existing scalar functions (such as CAST) in the 查询 templates whose
       sole purpose is to affect 输出 formatting or 结果 precision 可 be modified. The resulting
       syntax 必须 consistent with the 查询 template's original intended semantic behavior.
Comment: At higher scale factors some of the existing scalar functions might need adjustments to enable the
基准测试 to be run successfully at the intended 规模因子. For 示例, to avoid numeric overflow at the
intended 规模因子, changing the CAST of a 列 from decimal(15, 4) to wider decimal(31, 4) is allowed."
g) General
   1.   Delimited identifiers - In cases where identifier names conflict with reserved words in a given
        实现, delimited identifiers 可 be used.
   2.   Parentheses - Adding or removing parentheses around expressions and sub-queries is allowed. Both
        an opening parenthesis '(' and its corresponding closing parenthesis ')' 必须 added or removed
        together.
   3.   Ordinals - Ordinals can be exchanged with the referenced 列 name, or vice versa. E.g. "select
        a,b from T 订单 by 2;" can be rewritten to "select a,b from T 订单 by b;".
          Comment: The application of all minor 查询 modifications must 结果 in queries that have equivalent
          ISO SQL semantic behavior as the queries generated from the TPC-supplied functional 查询 definitions or
          their approved variants.
          Comment: All 查询 modifications are labeled minor based on the assumption that they do not
          significantly impact the 性能 of the queries


4.2.4     Row Limit Modifications
4.2.4.1   Some queries require that a given number of 行 be returned (e.g., “Return the first 10 selected 行”). If N is
          the number of 行 to be returned, the 查询 must return exactly the first N 行 unless fewer than N 行
          qualify, in which case all 行 必须 returned. There are four permissible ways of satisfying this 要求:
           • Vendor-specific control statements supported by a test sponsor’s interactive SQL interface 可
               be used (e.g., SET ROWCOUNT n) to limit the number of 行 returned.
           • Control statements recognized by the 实现 specific layer (see Clause 8.2.4) and used to
               control a loop which fetches the 行 可 be used to limit the number of 行 returned (e.g.,
               while rowcount <= n).
           • Vendor-specific SQL syntax 可 be added to the SELECT statement of a 查询 template to limit
               the number of 行 returned (e.g., SELECT FIRST n). This syntax is not classified as a minor
               查询 modification since it completes the functional 要求 of the functional 查询
               定义 and there is no standardized syntax defined. In all other respects, the 查询 must
               satisfy the 要求 of Clause 4.1.2. The syntax added must deal solely with the size of the
               answer set, and must not make any additional explicit reference, for 示例, to 表, indices,
               or access paths.
           • Enclosing the outer most SQL statement (or statements in case of iterative OLAP queries) with a
               select 子句 and a 行 limiting 谓词. For 示例, if Q is the original 查询 text. Then the
               modification would be: SELECT * FROM (Q) where rownum<=n. This syntax is not classified as
               a minor 查询 modification since it completes the functional 要求 of the functional 查询
               定义 and there is no standardized syntax defined. In all other respects, the 查询 must
               satisfy the 要求 of Clause 4.1.2. The syntax added must deal solely with the size of the
               answer set, and must not make any additional explicit reference, for 示例, to 表, indices,
               or access paths.

          A test sponsor must select one of these methods and use it consistently for all the queries that require that a
          specified number of 行 be returned.

4.2.5     Extract Query Modifications

4.2.5.1   Some queries return large 结果 sets. These queries correspond to the queries described in Clause 1.4 as those
          that produce large 结果 sets for extraction; the results are to be saved for later analysis. The 基准测试 allows
          for alternative methods for a DBMS to extract these 结果 行 to files in addition to the normal method of
          processing them through a SQL front-end tool and using the front-end tool to 输出 the 行 to a file. If a
          查询 for any stream returns 10,000 or more 结果 行, the vendor 可 extract the 行 for that 查询 in all
          streams to files using one of the following permitted vendor-specific extraction tools or methods:
          • Vendor-specific SQL syntax 可 be added to the SELECT statement of a 查询 template to redirect the
            行 returned to a file. For 示例, “Unload to file ‘outputfile’ Select c1, c2 …”

          • Vendor-specific control statements supported by a test sponsor’s interactive SQL interface 可 be used.
            For 示例,
          set 输出_file = ‘outputfile’
          select c1, c2…;
          unset 输出_file;

          • Control statements recognized by the 实现 specific layer (see Clause 8.2.4) and used to
            invoke an extraction tool or method.
4.2.5.2   If one of these alternative extract options is used, the 输出 应 be formatted as delimited or fixed-width
          ASCII text.
4.2.5.3   If one of these alternative extract options is used, they must meet the following conditions:

          A test sponsor 可 select only one of the options in 4.2.5.1. That method 必须 used consistently for all
          the queries that are eligible as extract queries.

          • If the extraction syntax modifies the 查询 SQL, in all other respects the 查询 must satisfy the
            要求 of Clause 4.1.2. The syntax added must deal solely with the extraction tool or
            method, and must not make any additional explicit reference, for 示例, to 表, indices, or
            access paths.
          • The test sponsor must demonstrate to the satisfaction of the Auditor that the file names used, and
            the extract facility itself, does not provide hints or optimizations in the DBMS such that the 查询
            has additional 性能 gains beyond any benefits from accelerating the extraction of 行.

          The tool or method used must meet all ACID 要求 for the queries used in combination with the
          tool or method.

4.2.6     Query Variants

4.2.6.1   A Query Variant is an alternate 查询 template, which has been created to allow a vendor to overcome specific
          functional barriers or product deficiencies that could not be address by minor 查询 modifications.
4.2.6.2   Approval of any new 查询 variant is required prior to using such variant to produce compliant TPC-DS results.
          The approval process is defined Clause 4.2.7.
4.2.6.3   Query variants that have already been approved are summarized in Appendix C.
          Comment: Since the soft appendix is updated each time a new variant is approved, test sponsors 应
          obtain the latest version of this appendix prior to implementing the 基准测试. See Appendix F Tool Set
          Requirements for more information)

4.2.7     Query Variant Approval
4.2.7.1   New 查询 variants will be considered for approval if they meet one of the following criteria:
          a) The vendor requesting the variant cannot successfully run the executable 查询 text against the
             qualification 数据库 using the functional 查询 定义 or an approved variant even when applying
             appropriate minor 查询 modifications to the functional 查询 定义 or an approved variant as per
             Clause 4.2.3.
          b) The proposed variant contains new or enhanced SQL syntax, relevant to the 基准测试, which is
             defined in an Approved Committee Draft of a new ISO SQL standard.
          c) The variant contains syntax that brings the proposed variant closer to adherence to an ISO SQL
             standard.
          d) The proposed variant contains minor syntax differences that have a straightforward mapping to ISO
             SQL syntax used in the functional 查询 定义 and offers functionality substantially similar to the
             ISO SQL standard.
4.2.7.2   To be approved, a proposed variant 应 have the following properties. Not all of the properties are
          specifically required. Rather, the cumulative weight of each property satisfied by the proposed variant will be
          the determining factor in approving the variant.
           a) Variant is syntactic only, seeking functional compatibility and not 性能 gain.
           b) Variant is minimal and restricted to correcting a missing functionality.
           c) Variant is based on knowledge of the business question rather than on knowledge of the 系统 under
               test (SUT) or knowledge of specific data 值 in the test 数据库.
           d) Variant has broad applicability among different vendors.
           e) Variant is non procedural.
           f) Variant is an approved ISO SQL syntax to 实现 the functional 查询 定义.
           g) Variant is sponsored by a vendor who can 实现 it and who intends on using it in an upcoming
               实现 of the 基准测试.
4.2.7.3   To be approved, the proposed variant 应 conform to the 实现 guidelines defined in Clause 4.2.8
          and the coding standards defined in Clause 4.2.9.
4.2.7.4   Approval of proposed 查询 variants will be at the sole discretion of the TPC-DS subcommittee, subject to TPC
          policy.
4.2.7.5   All proposed 查询 variants that are submitted for approval will be recorded, along with a rationale describing
          why they were or were not approved.

4.2.8     Variant Implementation Guidelines
4.2.8.1   When a proposed 查询 variant includes the creation of a 表, the datatypes 应 conform to Clause 2.2.2.
4.2.8.2   When a proposed 查询 variant includes the creation of a new entity (e.g., cursor, view, or 表) the entity
          name 应 ensure that newly created entities do not interfere with other 查询 sessions and are not shared
          between multiple 查询 sessions.
4.2.8.3   Any entity created within a proposed 查询 variant must also be deleted within that variant.
4.2.8.4   If CREATE TABLE statements are used within a proposed 查询 variant, they 可 include a tablespace
          reference (e.g., IN <tablespacename>). A single tablespace 必须 used for all 表 created within a proposed
          查询 variant.

4.2.9     Coding Style
4.2.9.1   Implementers 可 code the executable 查询 text in any desired coding style, including
           a) use of line breaks, tabs or white space
           b) choice of upper or lower case text
4.2.9.2   The coding style used 应 have no impact on the 性能 of the 系统 under test, and 必须
          consistently applied throughout the entire 查询 set.
          Comment: The auditor 可 require proof that the coding style does not affect 性能.
  4.3   Substitution Parameter Generation
4.3.1   Each 查询 has one or more substitution parameters. Dsqgen 必须 used to generate executable 查询 texts
        for the 查询 streams. In 订单 to generate the required number of 查询 streams, dsqgen 必须 used with
        the RNGSEED, INPUT and STREAMS options. The 值 for the RNGSEED option, <SEED>, is selected as the
        timestamp of the end of the 数据库 load time (Load End Time) expressed in the format mmddhhmmsss as
        defined in Clause 7.4.3.8. The 值 for the STREAMS option, <S>, is two times the number of streams, Sq, to be
        executed during each Throughput Test (S=2* Sq). The 值 of the INPUT option, <输入.txt>, is a file containing
        the location of all 99 查询 templates in numerical 订单.

        Comment:          RNGSEED guarantees that the 查询 substitution parameter 值 are not known prior to
        running the power and 吞吐量 tests. Called with a 值 of <S> for the STREAMS parameter, dsqgen
        generates S+1 files, named 查询_0.sql through 查询_[S].sql. Each file contains a different permutation of the
        99 queries.

4.3.2   Query_0.sql is the sequence of queries to be executed during the Power Test; files 查询_1.sql through
        查询_[Sq].sql are the sequences of queries to be executed during the first Throughput Test; and files
        查询_[Sq+1].sql through 查询_[2*Sq].sql are the sequences of queries to be executed during the second
        Throughput Test.

            Comment: The substitution parameter 值 for the qualification queries are provided in 18Appendix B:.
            They 必须 manually inserted into the 查询 templates.
                                        5    Data Maintenance

5.1     Implementation Requirements and Definitions

5.1.1      Data 维护 operations are performed as 零件 of the 基准测试 执行. These operations consist of
           processing data 维护 functions, grouped into 刷新 runs.The total number of 刷新 runs in the
           基准测试 equals the number of 查询 streams in one Throughput Test. Each 刷新 run has its own 刷新
           data set as generated by dsdgen and 必须 used in the 订单 generated by dsdgen. Data 维护
           operations execute separately from queries. Refresh runs do not overlap; at most one 刷新 run is running at
           any time.

5.1.2      Each 刷新 run includes all data 维护 functions defined in Clause 5.3 on the 刷新 data set
           defined in Clause 5.2. All data 维护 functions need to have finished in 刷新 run n before any
           data 维护 function can commence in 刷新 run n+1 (see Clause 7.4.8.6).

5.1.3      Data 维护 functions can be decomposed or combined into any number of 数据库 operations and
           the 执行 订单 of the data 维护 functions can be freely chosen as long as the following
           conditions are met. Particularly, the functions in each 刷新 run 可 be run sequentially or in parallel.

            a) Data Accessibility properties (See Clause 6.1 );
            b) All primary/外键 relationships 必须 preserved regardless of whether they have been enforced
               by 约束 (see Clause 2.5.4). This does not imply that referential integrity constraints 必须
               defined explicitly.
            c) A time-stamped 输出 message is sent when the data 维护 process is finished.
            d) All delete DM operations finish before any insert DM function begin.
           Comment: The intent of this 子句 is to maintain primary and 外键 referential integrity.
           Comment: Implementers can assume that if all DM operations complete successfully that the PK/FK
           relationship is preserved. Any exceptions are bugs that need to be fixed in the spec.

5.1.4      All existing and enabled EADS affected by any data 维护 operation 必须 updated within those
           data 维护 operations. All updates performed by the 刷新 process 必须 visible to queries that
           start after the updates are completed.

5.1.5      The data 维护 functions 必须 implemented in SQL or procedural SQL. The proper
           实现 of the data 维护 function 必须 validated by the auditor who 可 request
           additional tests to ascertain that the data 维护 functions were implemented and executed in
           accordance with the 基准测试 要求.

           Comment: Procedural SQL can be SQL embedded in other programs, interpreted or compiled.
           Comment: If the views in Clasue 5.3.11 are used the TPC-DS 基准测试 规范 permits certain
           deviations from the SQL phrasing used in the TPC-supplied views. Any changes must adhere to the Minor
           查询 modifications, defined in Clause 4.2.3

5.1.6      The staging area is an optional collection of 数据库 objects (e.g. 表, indexes, views, etc.) used to
           实现 the data 维护 functions. Database objects created in the staging area can only be used
           during 执行 of the data 维护 phase and cannot be used during any other phase of the
           基准测试. Any object created in the staging area needs to be disclosed in the FDR.

5.1.7      Any disk storage used for the staging area 必须 priced. Any mapping or virtualization of disk storage
           必须 disclosed.
5.2      Refresh Data

5.2.1         The 刷新 data consists of a series of 刷新 data sets, numbered 1, 2, 3…n. <n> is identical to the
              number of streams used in the Throughput Tests of the 基准测试. Each 刷新 data set consists of <N>
              flat files. The content of the flat files can be used to populate the source 模式, defined in Appendix A.
              However, populating the source 模式 is not mandated. The flat files generated for each 刷新 data set
              and their corresponding source 模式 表 are denoted in the following 表.

                 Table 5-1 Flat File to Source Schema Table Mapping and Flat File Size at Scale Factor 1

                                                       Approximate Size at SF=11
        Flat File Name                                                                            Source Schema Table Name
                                                       Bytes              Number of 行
        s_catalog_订单.dat                               116505           682                   s_catalog_订单
        s_catalog_订单_行项.dat                      592735           6138                  s_catalog_订单_行项
        s_catalog_returns.dat                             112182           578                   s_catalog_returns
        s_inventory.dat                                   26764259         540000                s_inventory
        s_purchase.dat                                    142552           1022                  s_purchase
        s_purchase_行项.dat                           1312480          12264                 s_purchase_行项
        s_store_returns.dat                               159306           1235                  s_store_returns
        s_web_订单.dat                                   43458            256                   s_web_订单
        s_web_订单_行项.dat                          324160           3072                  s_web_订单_行项
        s_web_returns.dat                                 42165            295                   s_web_returns
        The two flat files listed below are not 零件 of the source 模式. They contain 日期 boundaries for the delete operations of fact
        表 data. See clauses 5.3.8, 5.3.9 and 5.3.11.
        inventory_delete                                  66               3
        delete                                            66               3




             1 The number of 行 are approximate numbers. However, the number of bytes can vary from 刷新 set to
             刷新 set due to NULL 值.
                                   Table 5-2 Approximate Number of 行 in the update sets
                              Source          Approximate Number of Rows2 at Scale Factors:
          Schema Table Name
          Flat File Name
                                                     1          1000          3000            10000          30000          100000
           (with .dat extension)
          s_catalog_订单_1.dat                   682        681062       2043188           6810626       20431878        68106258
          s_catalog_订单_行项_1.da          6138       6129558      18388692          61295634      183886902       612956322
          t
          s_catalog_returns_1.dat                595        612485        1838772           6128994       18382810        61291609
          s_inventory_1.dat                   270000      18000000       23760000          30150000       37422000        45180000
          s_purchase_1.dat                      1022       1021594        3064780          10215938       30647816       102159386
          s_purchase_行项_1.dat            12264      12259128       36777360         122591256      367773792      1225912632
          s_store_returns_1.dat                 1200       1226054        3676450          12259852       36777217       122600683
          s_web_订单_1.dat                      256        255398         766196           2553984        7661954        25539846
          s_web_订单_行项_1.dat            3072       3064776        9194352          30647808       91943448       306478152
          s_web_returns_1.dat                    320        306222         918594           3061569        9190618        30642220
          delete_1.dat                             3             3              3                 3              3               3
          inventory_delete_1.dat                   3             3              3                 3              3               3

                                    Table 5-3 Approximate size of update data sets in bytes
        Source Schema Table Name         Approximate Number of Bytes3 at Scale Factors:
        Flat File Name
        (with .dat extension)            1               1000              3000            10000          30000          100000
        s_catalog_订单                        116505        118319211       356209093      1189890226     3582266543     11966927381
        s_catalog_订单_行项               592735        613833353      1853028767      6200096417    18729687588     62665689954
        s_catalog_returns                      112182        120659364       363309171      1212531153     3648947224     12186641092
        s_inventory                          26764259       1784226065      2355173608      2988571049     3709394541      4478391128
        s_purchase                             142552        145457806       438594877      1464772384    41069025492     14749907338
        s_purchase_行项                   1312480       1347883261      4070341609     13601008735    41069025492    137232918564
        s_store_returns                        159306        165441528       501145568      1677710639     5088325652     17029150799
        s_web_订单                             43458         44295571       133116152       445523894     1338776975      4480621920
        s_web_订单_行项                   324160        332423806       999959825      3354924415    10091449245     33855757519
        s_web_page                                482            24016           28815           31982          36801           40013
        s_web_returns                           42165         44803099       134594520       450275312     1353093091      4533145920
        inventory_delete                           66               66              66              66             66              66
        delete                                     66               66              66              66             66              66




5.2.2    The number of 行 present in each 刷新 set at 规模因子 1 for each of the flat files is summarized in
         Table 5-1.

5.2.3    The 刷新 data set of each data 维护 function 必须 generated using dsdgen. The 执行 of
         dsdgen is not timed. The 输出 of dsdgen is a text file. The storage to hold the 刷新 data sets 必须
         零件 of the priced 配置.

5.2.4    The 刷新 data set produced by dsdgen can be modified in the following way: The 输出 file for each
         表 of the 刷新 data set can be split into n files where each file contains approximately 1/n of the total
         number of 行 of the original 输出 file. The 订单 of the 行 in the original 输出 file 必须
         preserved, such that the concatenation of all n files is identical to the original file.




        2 The number of 行 are approximate numbers.

        3 The number of bytes can vary from 刷新 set to 刷新 set due to NULL 值.
5.2.5         The 刷新 data set for a specific 刷新 run 必须 loaded and timed as 零件 of the 执行 of the
              刷新 run. The loading of 刷新 data sets 必须 performed via generic processes inherent to the data
              processing 系统 or by the loader utility the 数据库 软件 provides and supports for general data
              loading. It is explicitly prohibited to use a loader tool that has been specifically developed for TPC-DS.

5.2.6         The 刷新 data set generated by dsdgen 必须 stored in flat files at a location which is different from the
              Database Location.

5.2.7         If a staging area is used, loading the 刷新 data set in the staging area is a timed portion of the data
              维护 process.

5.3      Data Maintenance Functions

5.3.1         Data 维护 functions perform insert and delete operations that are defined in pseudo code.
              Depending on which operation they perform and on which type of 表, they are categorized as Method1
              through Method3. They are:

              Method 1: fact insert data 维护

              Method 2: fact delete data 维护

              Method 3: inventory delete data 维护

5.3.2         The following 表 lists all data 维护 functions, their type of operation and target 表. The
              number of 行 in the views 必须 equal to the rowcounts in the source 模式 表 listed in 列 6
              of Table 5-4. The rowcounts of the source 模式 表 are listed in Table 5-2.

                                        Table 5-4 Data Maintenance Function Summary


Data          Data Maintenance Function    Type of          View        Target Table                             Source Schema Table(s)
Maintenance                                Operation        Name
Function ID
1             LF_CR(Clause 5.3.11.6)       Method 1         crv         catalog_returns                          s_catalog_returns
2             LF_CS(Clause 5.3.11.5)       Method 1         csv         catalog_sales                            s_catalog_订单,
                                                                                                                 s_catalog_订单_行项
3             LF_I(Clause 5.3.11.7)        Method 1         iv          inventory                                s_inventory
4             LF_SR(Clause 5.3.11.2)       Method 1         srv         store_returns                            s_store_returns
5             LF_SS(Clause 5.3.11.1)       Method 1         ssv         store_sales                              s_purchase,
                                                                                                                 s_purchase_行项
6             LF_WR(Clause 5.3.11.4)       Method 1         wrv         web_returns                              s_web_returns
7             LF_WS(Clause 5.3.11.3)       Method 1         wsv         web_sales                                s_web_订单,
                                                                                                                 s_web_订单_行项
8             DF_CS(Clause 5.3.11.10)      Method 2         -           catalog_sales [S], catalog_returns [R]   -
9             DF_SS(Clause 5.3.11.9)       Method 2         -           store_sales [S], store_returns [R]       -
10            DF_WS(Clause 5.3.11.11)      Method 2         -           web_sales [S], web_returns [R]           -
11            DF_I(Clause 5.3.11.12)       Method 3         -           Inventory [I]                            -

5.3.3         Data 维护 function method 1 reads 行 from a view V (see 列 View Name of 表 in Clause
              5.3.2) and insert 行 into a data 仓库 表 T. Both V and T are defined as 零件 of the data
              维护 function. T is created as 零件 of the initial load of the data 仓库. V is a logical 表 that
              does not need to be instantiated.

5.3.4         (intentionally left blank)

5.3.5         (intentionally left blank)
5.3.6      (intentionally left blank)

5.3.7      Method 1: Fact Table Load
           In the following pseudo code, view V refers to one of the views in Clause 5.3.11 as follows: ssv for
           store_sales, wsv for web_sales and csv for catalog_sales.
           for every 行 v in view V corresponding to sales fact 表 F
               insert v into F;

5.3.8      Method 2: Sales and Returns Fact Table Delete
           Delete 行 from R with corresponding 行 in S
                  where d_日期 between Date1 and Date2
           Delete 行 from S
                  where d_日期 between Date1 and Date2

           Comment: D_日期 is a 列 of the 日期_dim dimension. D_日期 has to be obtained by joining to the
           日期_dim dimension on sales 日期 surrogate key. The sales 日期 surrogate key for the store sales is
           ss_sold_日期_sk, for catalog it is cs_sold_日期_sk and for web sales it is ws_sold_日期_sk.

5.3.9      Method 3: Inventory Fact Table Delete
           Delete 行 from I where d_日期 between Date1 and Date2

           Comment: D_日期 is a 列 of the 日期_dim dimension. D_日期 has to be obtained by joining to the
           日期_dim dimension on inv_日期_sk.

5.3.10     Each data 维护 function inserting or updating 行 in dimension and fact 表 is defined by the
           following components:

           a) Descriptor, indicating the name of the data 维护 function in the form of DM_<abbreviation of
              data 仓库 表> for dimensions and LF_<abbreviation of the data 仓库 fact 表> for fact
              表. The extension indicates the data 仓库 表 that is populated with this data 维护
              function.
           b) The data 维护 method describes the pseudo code of the data 维护 function.
           c) A SQL view V describing which 表 of the source 模式 need to be joined to obtain the correct
              行 to be loaded.
           d) The 列 mapping defining which source 模式 列 map to which data 仓库 列;

5.3.11     Each data 维护 function deleting 行 from fact 表 is defined by the following components:

           a) Descriptor, indicating the name of the data 维护 function in the form of DF_<abbreviation of
              data 仓库 fact 表>. The extension indicates the data 仓库 fact 表 from which 行 are
              deleted.
           b) Tables: S and R, or I in case of inventory
           c) Two dates: Date1 and Date2
           d) The data 维护 method indicates how data is deleted
               Comment:        In the flat files generated by dsdgen for data 维护 there are 2 files which relate
                              to deletes. One 平面文件 (delete_<n>.dat) associated with deletes applies to sales and
                              returns for store, web and catalog where <n> denotes the set number, defined in Clause
                              5.1.2). The second 平面文件 (inventory_delete_<n>.dat) applies to inventory only where
                              <n> denotes the set number,d efined in Clause 5.1.2). In each delete 平面文件 there are 3
                              sets of start and end dates for the delete function. Each of the 3 sets of dates 必须
                              applied.
5.3.11.1   LF_SS
CREATE view ssv as
SELECT d_日期_sk ss_sold_日期_sk,
         t_time_sk ss_sold_time_sk,
         i_item_sk ss_item_sk,
         c_客户_sk ss_客户_sk,
         c_current_cdemo_sk ss_cdemo_sk,
         c_current_hdemo_sk ss_hdemo_sk,
         c_current_addr_sk ss_addr_sk,
         s_store_sk ss_store_sk,
         p_promo_sk ss_promo_sk,
         purc_purchase_id ss_ticket_number,
         plin_数量 ss_数量,
         i_wholesale_成本 ss_wholesale_成本,
         i_current_价格 ss_list_价格,
         plin_sale_价格 ss_sales_价格,
         (i_current_价格-plin_sale_价格)*plin_数量 ss_ext_折扣_amt,
         plin_sale_价格 * plin_数量 ss_ext_sales_价格,
         i_wholesale_成本 * plin_数量 ss_ext_wholesale_成本,
         i_current_价格 * plin_数量 ss_ext_list_价格,
         i_current_价格 * s_税_precentage ss_ext_税,
         plin_coupon_amt ss_coupon_amt,
         (plin_sale_价格 * plin_数量)-plin_coupon_amt ss_net_paid,
         ((plin_sale_价格 * plin_数量)-plin_coupon_amt)*(1+s_税_precentage) ss_net_paid_inc_税,
         ((plin_sale_价格 * plin_数量)-plin_coupon_amt)-(plin_数量*i_wholesale_成本)
ss_net_profit
FROM     s_purchase
LEFT OUTER JOIN 客户 ON (purc_客户_id = c_客户_id)
LEFT OUTER JOIN store ON (purc_store_id = s_store_id)
LEFT OUTER JOIN 日期_dim ON (cast(purc_purchase_日期 as 日期) = d_日期)
LEFT OUTER JOIN time_dim ON (PURC_PURCHASE_TIME = t_time)
JOIN s_purchase_行项 ON (purc_purchase_id = plin_purchase_id)
LEFT OUTER JOIN promotion ON plin_promotion_id = p_promo_id
LEFT OUTER JOIN item ON plin_item_id = i_item_id
WHERE    purc_purchase_id = plin_purchase_id
     AND i_rec_end_日期 is NULL
     AND s_rec_end_日期 is NULL;



5.3.11.2   LF_SR
CREATE view srv as
SELECT d_日期_sk sr_returned_日期_sk
      ,t_time_sk sr_return_time_sk
      ,i_item_sk sr_item_sk
      ,c_客户_sk sr_客户_sk
      ,c_current_cdemo_sk sr_cdemo_sk
      ,c_current_hdemo_sk sr_hdemo_sk
      ,c_current_addr_sk sr_addr_sk
      ,s_store_sk sr_store_sk
      ,r_reason_sk sr_reason_sk
      ,sret_ticket_number sr_ticket_number
      ,sret_return_qty sr_return_数量
      ,sret_return_amt sr_return_amt
      ,sret_return_税 sr_return_税
      ,sret_return_amt + sret_return_税 sr_return_amt_inc_税
      ,sret_return_fee sr_fee
      ,sret_return_ship_成本 sr_return_ship_成本
      ,sret_refunded_cash sr_refunded_cash
      ,sret_reversed_charge sr_reversed_charge
      ,sret_store_credit sr_store_credit
      ,sret_return_amt+sret_return_税+sret_return_fee
       -sret_refunded_cash-sret_reversed_charge-sret_store_credit sr_net_loss
FROM s_store_returns
LEFT OUTER JOIN 日期_dim
  ON (cast(sret_return_日期 as 日期) = d_日期)
LEFT OUTER JOIN time_dim
  ON (( cast(substr(sret_return_time,1,2) AS integer)*3600
       +cast(substr(sret_return_time,4,2) AS integer)*60
       +cast(substr(sret_return_time,7,2) AS integer)) = t_time)
LEFT OUTER JOIN item ON (sret_item_id = i_item_id)
LEFT OUTER JOIN 客户 ON (sret_客户_id = c_客户_id)
LEFT OUTER JOIN store ON (sret_store_id = s_store_id)
LEFT OUTER JOIN reason ON (sret_reason_id = r_reason_id)
WHERE i_rec_end_日期 IS NULL
  AND s_rec_end_日期 IS NULL;




5.3.11.3   LF_WS
CREATE VIEW wsv AS
SELECT d1.d_日期_sk ws_sold_日期_sk,
        t_time_sk ws_sold_time_sk,
        d2.d_日期_sk ws_ship_日期_sk,
        i_item_sk ws_item_sk,
        c1.c_客户_sk ws_bill_客户_sk,
        c1.c_current_cdemo_sk ws_bill_cdemo_sk,
        c1.c_current_hdemo_sk ws_bill_hdemo_sk,
        c1.c_current_addr_sk ws_bill_addr_sk,
        c2.c_客户_sk ws_ship_客户_sk,
        c2.c_current_cdemo_sk ws_ship_cdemo_sk,
        c2.c_current_hdemo_sk ws_ship_hdemo_sk,
        c2.c_current_addr_sk ws_ship_addr_sk,
        wp_web_page_sk ws_web_page_sk,
        web_site_sk ws_web_site_sk,
        sm_ship_mode_sk ws_ship_mode_sk,
        w_仓库_sk ws_仓库_sk,
        p_promo_sk ws_promo_sk,
        word_订单_id ws_订单_number,
        wlin_数量 ws_数量,
        i_wholesale_成本 ws_wholesale_成本,
        i_current_价格 ws_list_价格,
        wlin_sales_价格 ws_sales_价格,
        (i_current_价格-wlin_sales_价格)*wlin_数量 ws_ext_折扣_amt,
        wlin_sales_价格 * wlin_数量 ws_ext_sales_价格,
        i_wholesale_成本 * wlin_数量 ws_ext_wholesale_成本,
        i_current_价格 * wlin_数量 ws_ext_list_价格,
        i_current_价格 * web_税_percentage ws_ext_税,
        wlin_coupon_amt ws_coupon_amt,
        wlin_ship_成本 * wlin_数量 WS_EXT_SHIP_COST,
        (wlin_sales_价格 * wlin_数量)-wlin_coupon_amt ws_net_paid,
        ((wlin_sales_价格 * wlin_数量)-wlin_coupon_amt)*(1+web_税_percentage) ws_net_paid_inc_税,
        ((wlin_sales_价格 * wlin_数量)-wlin_coupon_amt)-(wlin_数量*i_wholesale_成本)
WS_NET_PAID_INC_SHIP,
        (wlin_sales_价格 * wlin_数量)-wlin_coupon_amt + (wlin_ship_成本 * wlin_数量)
        + i_current_价格 * web_税_percentage WS_NET_PAID_INC_SHIP_TAX,
        ((wlin_sales_价格 * wlin_数量)-wlin_coupon_amt)-(i_wholesale_成本 * wlin_数量)
WS_NET_PROFIT
FROM    s_web_订单
LEFT OUTER JOIN 日期_dim d1 ON (cast(word_订单_日期 as 日期) = d1.d_日期)
LEFT OUTER JOIN time_dim ON (word_订单_time = t_time)
LEFT OUTER JOIN 客户 c1 ON (word_bill_客户_id = c1.c_客户_id)
LEFT OUTER JOIN 客户 c2 ON (word_ship_客户_id = c2.c_客户_id)
LEFT OUTER JOIN web_site ON (word_web_site_id = web_site_id AND web_rec_end_日期 IS NULL)
LEFT OUTER JOIN ship_mode ON (word_ship_mode_id = sm_ship_mode_id)
JOIN s_web_订单_行项 ON (word_订单_id = wlin_订单_id)
LEFT OUTER JOIN 日期_dim d2 ON (cast(wlin_ship_日期 as 日期) = d2.d_日期)
LEFT OUTER JOIN item ON (wlin_item_id = i_item_id AND i_rec_end_日期 IS NULL)
LEFT OUTER JOIN web_page ON (wlin_web_page_id = wp_web_page_id AND wp_rec_end_日期 IS NULL)
LEFT OUTER JOIN 仓库 ON (wlin_仓库_id = w_仓库_id)
LEFT OUTER JOIN promotion ON (wlin_promotion_id = p_promo_id);



5.3.11.4   LF_WR
CREATE VIEW wrv AS
SELECT d_日期_sk wr_return_日期_sk
      ,t_time_sk wr_return_time_sk
      ,i_item_sk wr_item_sk
      ,c1.c_客户_sk wr_refunded_客户_sk
      ,c1.c_current_cdemo_sk wr_refunded_cdemo_sk
      ,c1.c_current_hdemo_sk wr_refunded_hdemo_sk
      ,c1.c_current_addr_sk wr_refunded_addr_sk
      ,c2.c_客户_sk wr_returning_客户_sk
      ,c2.c_current_cdemo_sk wr_returning_cdemo_sk
      ,c2.c_current_hdemo_sk wr_returning_hdemo_sk
      ,c2.c_current_addr_sk wr_returing_addr_sk
      ,wp_web_page_sk wr_web_page_sk
      ,r_reason_sk wr_reason_sk
      ,wret_订单_id wr_订单_number
      ,wret_return_qty wr_return_数量
      ,wret_return_amt wr_return_amt
      ,wret_return_税 wr_return_税
      ,wret_return_amt + wret_return_税 AS wr_return_amt_inc_税
      ,wret_return_fee wr_fee
      ,wret_return_ship_成本 wr_return_ship_成本
      ,wret_refunded_cash wr_refunded_cash
      ,wret_reversed_charge wr_reversed_charge
      ,wret_account_credit wr_account_credit
      ,wret_return_amt+wret_return_税+wret_return_fee
       -wret_refunded_cash-wret_reversed_charge-wret_account_credit wr_net_loss
FROM s_web_returns LEFT OUTER JOIN 日期_dim ON (cast(wret_return_日期 as 日期) = d_日期)
LEFT OUTER JOIN time_dim ON ((CAST(SUBSTR(wret_return_time,1,2) AS integer)*3600
+CAST(SUBSTR(wret_return_time,4,2) AS integer)*60+CAST(SUBSTR(wret_return_time,7,2) AS integer))=t_time)
LEFT OUTER JOIN item ON (wret_item_id = i_item_id)
LEFT OUTER JOIN 客户 c1 ON (wret_return_客户_id = c1.c_客户_id)
LEFT OUTER JOIN 客户 c2 ON (wret_refund_客户_id = c2.c_客户_id)
LEFT OUTER JOIN reason ON (wret_reason_id = r_reason_id)
LEFT OUTER JOIN web_page ON (wret_web_page_id = WP_WEB_PAGE_id)
WHERE i_rec_end_日期 IS NULL AND wp_rec_end_日期 IS NULL;



5.3.11.5   LF_CS
CREATE view csv as
SELECT d1.d_日期_sk cs_sold_日期_sk
      ,t_time_sk cs_sold_time_sk
      ,d2.d_日期_sk cs_ship_日期_sk
      ,c1.c_客户_sk cs_bill_客户_sk
      ,c1.c_current_cdemo_sk cs_bill_cdemo_sk
      ,c1.c_current_hdemo_sk cs_bill_hdemo_sk
      ,c1.c_current_addr_sk cs_bill_addr_sk
      ,c2.c_客户_sk cs_ship_客户_sk
      ,c2.c_current_cdemo_sk cs_ship_cdemo_sk
      ,c2.c_current_hdemo_sk cs_ship_hdemo_sk
      ,c2.c_current_addr_sk cs_ship_addr_sk
      ,cc_call_center_sk cs_call_center_sk
      ,cp_catalog_page_sk cs_catalog_page_sk
      ,sm_ship_mode_sk cs_ship_mode_sk
      ,w_仓库_sk cs_仓库_sk
      ,i_item_sk cs_item_sk
      ,p_promo_sk cs_promo_sk
      ,cord_订单_id cs_订单_number
      ,clin_数量 cs_数量
      ,i_wholesale_成本 cs_wholesale_成本
      ,i_current_价格 cs_list_价格
      ,clin_sales_价格 cs_sales_价格
      ,(i_current_价格-clin_sales_价格)*clin_数量 cs_ext_折扣_amt
      ,clin_sales_价格 * clin_数量 cs_ext_sales_价格
      ,i_wholesale_成本 * clin_数量 cs_ext_wholesale_成本
      ,i_current_价格 * clin_数量 CS_EXT_LIST_PRICE
      ,i_current_价格 * cc_税_percentage CS_EXT_TAX
      ,clin_coupon_amt cs_coupon_amt
      ,clin_ship_成本 * clin_数量 CS_EXT_SHIP_COST
      ,(clin_sales_价格 * clin_数量)-clin_coupon_amt cs_net_paid
      ,((clin_sales_价格 * clin_数量)-clin_coupon_amt)*(1+cc_税_percentage) cs_net_paid_inc_税
      ,(clin_sales_价格 * clin_数量)-clin_coupon_amt + (clin_ship_成本 * clin_数量) CS_NET_PAID_INC_SHIP
      ,(clin_sales_价格 * clin_数量)-clin_coupon_amt + (clin_ship_成本 * clin_数量)
       + i_current_价格 * cc_税_percentage CS_NET_PAID_INC_SHIP_TAX
      ,((clin_sales_价格 * clin_数量)-clin_coupon_amt)-(clin_数量*i_wholesale_成本) cs_net_profit
FROM    s_catalog_订单
LEFT OUTER JOIN 日期_dim d1 ON
  (cast(cord_订单_日期 as 日期) = d1.d_日期)
LEFT OUTER JOIN time_dim ON (cord_订单_time = t_time)
LEFT OUTER JOIN 客户 c1 ON (cord_bill_客户_id = c1.c_客户_id)
LEFT OUTER JOIN 客户 c2 ON (cord_ship_客户_id = c2.c_客户_id)
LEFT OUTER JOIN call_center ON (cord_call_center_id = cc_call_center_id AND cc_rec_end_日期 IS NULL)
LEFT OUTER JOIN ship_mode ON (cord_ship_mode_id = sm_ship_mode_id)
JOIN s_catalog_订单_行项 ON (cord_订单_id = clin_订单_id)
LEFT OUTER JOIN 日期_dim d2 ON
  (cast(clin_ship_日期 as 日期) = d2.d_日期)
LEFT OUTER JOIN catalog_page ON
  (clin_catalog_page_number = cp_catalog_page_number and clin_catalog_number = cp_catalog_number)
LEFT OUTER JOIN 仓库 ON (clin_仓库_id = w_仓库_id)
LEFT OUTER JOIN item ON (clin_item_id = i_item_id AND i_rec_end_日期 IS NULL)
LEFT OUTER JOIN promotion ON (clin_promotion_id = p_promo_id);




5.3.11.6    LF_CR
CREATE VIEW crv as
SELECT d_日期_sk cr_returned_日期_sk
      ,t_time_sk cr_returned_time_sk
      ,i_item_sk cr_item_sk
      ,c1.c_客户_sk cr_refunded_客户_sk
      ,c1.c_current_cdemo_sk cr_refunded_cdemo_sk
      ,c1.c_current_hdemo_sk cr_refunded_hdemo_sk
      ,c1.c_current_addr_sk cr_refunded_addr_sk
      ,c2.c_客户_sk cr_returning_客户_sk
      ,c2.c_current_cdemo_sk cr_returning_cdemo_sk
      ,c2.c_current_hdemo_sk cr_returning_hdemo_sk
      ,c2.c_current_addr_sk cr_returing_addr_sk
      ,cc_call_center_sk cr_call_center_sk
      ,cp_catalog_page_sk CR_CATALOG_PAGE_SK
      ,sm_ship_mode_sk CR_SHIP_MODE_SK
      ,w_仓库_sk CR_WAREHOUSE_SK
      ,r_reason_sk cr_reason_sk
      ,cret_订单_id cr_订单_number
      ,cret_return_qty cr_return_数量
      ,cret_return_amt cr_return_amt
      ,cret_return_税 cr_return_税
      ,cret_return_amt + cret_return_税 AS cr_return_amt_inc_税
      ,cret_return_fee cr_fee
      ,cret_return_ship_成本 cr_return_ship_成本
      ,cret_refunded_cash cr_refunded_cash
      ,cret_reversed_charge cr_reversed_charge
      ,cret_merchant_credit cr_merchant_credit
      ,cret_return_amt+cret_return_税+cret_return_fee
         -cret_refunded_cash-cret_reversed_charge-cret_merchant_credit cr_net_loss
FROM s_catalog_returns
LEFT OUTER JOIN 日期_dim
  ON (cast(cret_return_日期 as 日期) = d_日期)
LEFT OUTER JOIN time_dim ON
  ((CAST(substr(cret_return_time,1,2) AS integer)*3600
   +CAST(substr(cret_return_time,4,2) AS integer)*60
   +CAST(substr(cret_return_time,7,2) AS integer)) = t_time)
LEFT OUTER JOIN item ON (cret_item_id = i_item_id)
LEFT OUTER JOIN 客户 c1 ON (cret_return_客户_id = c1.c_客户_id)
LEFT OUTER JOIN 客户 c2 ON (cret_refund_客户_id = c2.c_客户_id)
LEFT OUTER JOIN reason ON (cret_reason_id = r_reason_id)
LEFT OUTER JOIN call_center ON (cret_call_center_id = cc_call_center_id)
LEFT OUTER JOIN catalog_page ON (cret_catalog_page_id = cp_catalog_page_id)
LEFT OUTER JOIN ship_mode ON (cret_shipmode_id = sm_ship_mode_id)
LEFT OUTER JOIN 仓库 ON (cret_仓库_id = w_仓库_id)
WHERE i_rec_end_日期 IS NULL AND cc_rec_end_日期 IS NULL;



5.3.11.7      LF_I:
5.3.11.8
           CREATE view iv AS
           SELECT d_日期_sk inv_日期_sk,
                  i_item_sk inv_item_sk,
                  w_仓库_sk inv_仓库_sk,
                  invn_qty_on_hand inv_数量_on_hand
           FROM s_inventory
           LEFT OUTER JOIN 仓库 ON (invn_仓库_id=w_仓库_id)
           LEFT OUTER JOIN item ON (invn_item_id=i_item_id AND i_rec_end_日期 IS NULL)
           LEFT OUTER JOIN 日期_dim ON (d_日期=invn_日期);



5.3.11.9      DF_SS:
              S=store_sales
              R=store_returns
              Date1 as generated by dsdgen
              Date2 as generated by dsdgen
5.3.11.10   DF_CS:
            S=catalog_sales
            R=catalog_returns
            Date1 as generated by dsdgen
            Date2 as generated by dsdgen
5.3.11.11   DF_WS:
            S=web_sales
            R=web_returns
            Date1 as generated by dsdgen
            Date2 as generated by dsdgen
5.3.11.12   DF_I:
            I=Inventory
            Date1 as generated by dsdgen
            Date2 as generated by dsdgen
                                         6     Data Accessibility Properties

6.1         The Data Accessibility Properties

            The System Under Test 必须 configured to satisfy the 要求 for Data Accessibility described in this
            子句. Data Accessibility is demonstrated by the SUT being able to maintain operations with full data access
            during and after the permanent irrecoverable failure of any single Durable Medium containing 表, EADS, or
            metadata. Data Accessibility tests are conducted by inducing failure of a Durable Medium within the SUT.

6.1.1       Definition of Terms
6.1.1.1     Data Accessibility: The ability to maintain operations with full data access after the permanent irrecoverable
            failure of any single Durable Medium containing 表, EADS, or metadata.
6.1.1.2     Durable Medium: A data storage medium that is either:
            a. An inherently non-volatile medium (e.g., magnetic disk, magnetic tape, optical disk, solid state disk,
                persistent memory, etc.) or;
            b. A volatile medium with its own self-contained power supply that will retain and permit the transfer of data,
                before any data is lost, to an inherently non-volatile medium after the failure of external power.
            Comment: A configured and priced Uninterruptible Power Supply (UPS) is not considered external power.
            Comment: Memory can be considered a durable medium if it can preserve data long enough to satisfy the
            要求 (b) above. For 示例, if memory is accompanied by an Uninterruptible Power Supply, and the
            contents of memory can be transferred to an inherently non-volatile medium during the failure, then the
            memory is considered durable. Note that no distinction is made between main memory and memory performing
            similar permanent or temporary data storage in other parts of the 系统 (e.g., disk controller caches).
6.1.1.3     Metadata: Descriptive information about the 数据库 including names and definitions of 表, indexes, and
            other 模式 objects. Various terms commonly used to refer collectively to the metadata include metastore,
            information 模式, data dictionary, or 系统 catalog.
6.1.2       Data Accessibility Requirements
6.1.2.1     TPC-DS’ Data Accessibility Requirements are met if the SUT continues executing queries and data
            维护 functions with full data access during and after the permanent irrecoverable failure of any single
            durable medium containing TPC-DS 数据库 objects, e.g. 表, EADS, or metadata.
6.1.2.2     The test sponsor 可 satisfy that the 系统 meets the Data Accessibility Requirements laid out in Clause
            6.1.2.1 by performing either a Data Accessibility Test or by providing Data Accessibility Documentation.
6.1.2.3     Data Accessibility Test
6.1.2.4     The Data Accessibility Test is performed by causing the failure of a Durable Media during the 执行 of the
            first Data Maintenance Test (described in Clause 7.4). The durable media is determined by the auditor at
            random. The number of durable media to be failed are:
             • One if all data resides in one set of durable media or
             • One per distinct set of durable media, if multiple distinct sets of durable media are used for
                  different purposes, e.g. metadata, primary data copies, EADs, and one in the intersecting set of
                  durable media, if overlapping sets of durable media are used for different purposes, e.g.
                  metadata, primary data copies, EADs.
             The Data Accessibility Test is successful if all in-flight data 维护 functions, subsequent
             queries and data 维护 functions complete successfully after the above durable media have
             failed.
            Comment: This 子句 could effectively require multiple simultaneous points of failure and the
            实现 必须 able to successfully complete the DA test as describe above.

6.1.2.4.1   The Data Accessibility Test 必须 performed as 零件 of the Performance Test that is used as the basis for
            reporting the 性能 指标 and results, while running against the test 数据库 at the full reported scale
            factor.
6.1.2.5     Data Accessibility Documentation

6.1.2.5.1   The Data Accessibility Documentation must fulfill all of the following 要求:
             • The Data Accessibility Documentation 必须 publically available on the vendor’s website,
             • The FDR must include sufficient documentation to prove that the Data Accessibility
                要求 are met as a stand alone documentation.
                        • The FDR must include a link to the Data Accessibility Documentation from the
                            vendor’s website,
                        • The FDR must include quotes from the relevant content of the Data Accessibility
                            Documentation.
             • The Data Accessibility Documentation must cover all products and services priced in the SUT
                which are involved in meeting the Data Accessibility Requirements laid out in Clause 6.1.2.1,
             • The Data Accessibility Documentations must describe how data redundancy is accomplished
                withhin the SUT. Following are some examples of such 说明:
                        • Data Objects are stored on redundant devices (e.g. RAID 1, RAID 5)
                        • Data Objects are redundantly stored on multiple storage devices in the same facility.
                        • Data Objects are redundantly stored across multiple facilities.
                        • Data Objects are redundantly stored across data centers in multiple regions.
             • The following features 必须 supported by the SUT and described in the Data Accessibility
                Documentation:
                        • Synchronous writes: The redundant writes of multiple copies of Data Objects to
                            multiple storage devices are executed synchronously.
                        • Automatic repair: Any loss of redundancy of a Data Object is automatically repaired
                            without any operator intervention.
                                         7    Performance Metrics and Execution Rules

7.1      Definition of Terms

7.1.1       The Benchmark is defined as the 执行 of the Load Test followed by the Performance Test.

7.1.2       The Load Test is defined as all activity required to bring the System Under Test to the 配置 that
            immediately precedes the beginning of the Performance Test. The Load Test must not include the
            执行 of any of the queries in the Power Test or Throughput Test or any similar 查询.

7.1.3       The Performance Test is defined as the Power Test, both Throughput Tests and both Data Maintenance
            Tests.

7.1.4       A 查询 stream is defined as the sequential 执行 of a permutation of queries submitted by a single
            emulated user. A 查询 stream consists of the 99 queries defined in Clause 4.

7.1.5       A session is defined as a uniquely identified process context capable of supporting the 执行 of user-
            initiated 数据库 activity.

7.1.6       A 查询 session is a session executing activity on behalf of a Power Test or a Throughput Test.

7.1.7       A 刷新 run is defined as the 执行 of one set of data 维护 functions.

7.1.8       A 刷新 session is a session executing activity on behalf of a 刷新 run.

7.1.9       A Throughput Test consists of Sq 查询 sessions each running a single 查询 stream.

7.1.10      A Power Test consists of exactly one 查询 session running a single 查询 stream.

7.1.11      A Data Maintenance Test consists of the 执行 of a series of 刷新 streams .

7.1.12      A 查询 is an ordered set of one or more valid SQL statements resulting from applying the required
            parameter substitutions to a given 查询 template. The 订单 of the SQL statements is defined in the 查询
            template.

7.1.13      The SUT consists of a collection of configured components used to complete the 基准测试.

7.1.14      The mechanism used to submit queries to the SUT and to measure their 执行 time is called a driver.

7.1.15      A timestamp 必须 taken in the time zone the SUT is located in. It is defined as any representation
            equivalent to yyyy-mm-dd hh:mm:ss.s, where:

             •   yyyy is the 4 digit representation of year
             •   mm is the 2 digit representation of month
             •   dd is the 2 digit representation of day
             •   hh is the 2 digit representation of hour in 24-hour clock notation
             •   mm is the 2 digit representation of minute
             •   ss.s is the 3 digit representation of second with a precision of at least 1/10 of a second

7.1.16      Elapsed time is measured in seconds rounded up to the nearest 0.1 second.

7.1.17      Test Database is the loaded data and created meta data required to execute the TPC-DS 基准测试, i.e.
            Load test, Power test, Throughput test, Data 维护 test and all tests required by the auditor.

7.1.18      Database Location is the location of loaded data that is directly accessible (read/write) by the test
            数据库 to 查询 or apply dml operations on the TPC-DS 表 defined in Clause 2 as required by
            Load test, Power test, Throughput test, Data 维护 test and all tests required by the auditor.
7.2       Configuration Rules

7.2.1        The driver is a logical entity that can be implemented using one or more physical programs, processes, or
             系统 (see Clause 8.3).

7.2.2        The communication between the driver and the SUT 必须 limited to one session per 查询. These
             sessions are prohibited from communicating with one another except for the purpose of scheduling Data
             Maintenance functions (see Clause 5.3).

7.2.3        All 查询 sessions 必须 initialized in exactly the same way. All 刷新 sessions 必须 initialized in
             exactly the same way. The initialization of a 刷新 session 可 be different than that of the 查询 session.

7.2.4        All session initialization parameters, settings and commands 必须 disclosed.

             Comment: The intent of this 子句 is to provide the information needed to precisely recreate the
             执行 environment of any given stream as it exists prior to the submission of the first 查询 or data
             维护 function.

7.2.5        The driver 应 submit each TPC-DS 查询 for 执行 by the SUT via the session associated with the
             corresponding 查询 stream.

7.2.6        In the case of the data 维护 functions, the driver is only required to submit the commands
             necessary to cause the 执行 of each data 维护 function.

7.2.7        The driver's submittal of the queries to the SUT during the 性能 test 应 be limited to the
             transmission of the 查询 text to the data processing 系统 and whatever additional information is
             required to conform to the measurement and data gathering 要求 defined in this document. In
             addition:

              • The interaction between the driver and the SUT 应 not have the purpose of indicating to the
                SUT or any of its components an 执行 strategy or 优先级 that is time-dependent or 查询-
                specific;
              • The interaction between the driver and the SUT 应 not have the purpose of indicating to the
                SUT, or to any of its components, the insertion of time delays;
              • The driver 应 not insert time delays before, after, or between the submission of queries to the
                SUT;
              • The interaction between the driver and the SUT 应 not have the purpose of modifying the
                behavior or 配置 of the SUT (i.e., data processing 系统 or operating 系统 settings)
                on a 查询-by-查询 basis. These parameters 应 not be altered during the 执行 of the
                性能 test.
             Comment: One intent of this 子句 is to prohibit the pacing of 查询 submission by the driver.

7.2.8        Environmental Assumptions
7.2.8.1      The 配置 and initialization of the SUT, the 数据库, or the session, including any relevant parameter,
             switch or option settings, 应 be based only on externally documented capabilities of the 系统 that can be
             reasonably interpreted as useful for a decision support 工作负载. This 工作负载 is characterized by:
              • Sequential scans of large amounts of data;
              • Aggregation of large amounts of data;
              • Multi-表 joins;
              • Possibly extensive sorting.
7.2.8.2    While the 配置 and initialization can reflect the general nature of this expected 工作负载, it 应 not
           take special advantage of the limited functions actually exercised by the 基准测试. The queries actually
           chosen in the 基准测试 are merely examples of the types of queries that might be used in such an
           environment, not necessarily actual user queries. Due to this limit in the scope of the queries and test
           environment, TPC-DS has chosen to restrict the use of some 数据库 technologies (see Clause 2.5). In general,
           the effect of the 配置 on 基准测试 性能 应 be representative of its expected effect on the
           性能 of the class of applications modeled by the 基准测试.
7.2.8.3    The features, switches or parameter settings that comprise the 配置 of the operating 系统, the data
           processing 系统 or the session 必须 such that it would be reasonable to expect a 数据库 administrator
           with the following characteristics be able to decide to use them:
            • Knowledge of the general characteristics of the 工作负载 as defined above;
            • Knowledge of the logical and physical 数据库 layout;
            • Access to operating 系统 and 数据库 documentation;
            • No knowledge of product internals beyond what is documented externally.

           Each feature, switch or parameter setting used in the 配置 and initialization of the operating
           系统, the data processing 系统 or the session must meet the following criteria:

           • It 应 remain in effect without change throughout the 性能 test;
           • It 应 not make reference to specific 表, indices or queries for the purpose of providing hints
             to the 查询 优化器.

7.2.9      The collection of statistics requested through the use of directives 必须 零件 of the 数据库 load. If these
           directives request the collection of different levels of statistics for different 列, they must adhere to
           the following 规则.:
           1) The level of statistics collected for a given 列 必须 based on the 列’s membership in a class.
           2) Class definitions must rely solely on the following 列 attributes from the logical 数据库 design (as
              defined in Clause 2):
               • Datatype;
               • Nullable;
               • Foreign Key;
               • Primary Key.
           3) Class definitions 可 combine 列 attributes using AND, OR and NOT operators. (for 示例, one
              class could contain all 列 satisfying the following combination of attributes: [Identifier Datatype]
              AND [NOT nullable OR Foreign Key]);
           4) Class membership 必须 applied consistently on all 列 across all 表;
           5) Statistics that operate in sets, such as distribution statistics, 应 employ a fixed set appropriate to the
              规模因子 used. Knowledge of the cardinality, 值 or distribution of a non-key 列 (as specified in
              Clause 3) must not be used to tailor statistics gathering.

7.2.10     Profile-Directed Optimization
7.2.10.1   Special 规则 apply to the use of so-called profile-directed 优化 (PDO), in which binary executables are
           reordered or otherwise optimized to best suit the needs of a particular 工作负载. These 规则 do not apply to the
           routine use of PDO by a 数据库 vendor in the course of building commercially available and supported
           数据库 products; such use is not restricted. Rather, the 规则 apply to the use of PDO by a test sponsor to
           optimize executables of a 数据库 product for a particular 工作负载. Such 优化 is permissible if all of
           the following conditions are satisfied:
            • The use of PDO or similar procedures by the test sponsor 必须 disclosed.
            • The procedure and any scripts used to perform the 优化 必须 disclosed.
            • The procedure used by the test sponsor could reasonably be used by a 客户 on a shipped
                数据库 executable.
            • The optimized 数据库 executables resulting from the application of the procedure 必须
                supported by the 数据库 软件 vendor.
            • The 工作负载 used to drive the 优化 is described in Clause 7.2.10.2.
               • The same set of executables 必须 used for all phases of the 基准测试.
7.2.10.2      If profile-directed 优化 is used, the 工作负载 used to drive it can be the 执行 of any subset of the
              TPC-DS queries or any data 维护 functions, in any 订单, against a TPC-DS 数据库 of any desired
              规模因子, with default substitution parameters applied. The 查询/data 维护 function set, used in
              PDO, 必须 reported.

7.3        Query and Query Output Validation

7.3.1         Query template n (1<=n<=99) used in a 基准测试 submission must match template n (or any variant of
              template n) of the TPC-DS 规范, subject to 查询 template modification 规则 in Clause 4.2.

7.3.2         The 查询 templates (potentially after applying modification 规则 in Clause 4.2) used to generate the
              qualification queries 必须 identical to the 查询 templates used to generate the queries for the Power
              and Throughput Tests.

7.3.3         The 查询 输出 validation process is defined as follows:

               1. Populate the qualification 数据库 (see Clause 3.3) ;
               2. Create a set of qualification queries by generating executable 查询 text for all 99 queries using 查询
                  templates with the qualification substitution parameters as defined in Appendix B (see Clause 4.3);
               3. Execute all qualification queries and capture their 结果 (qualification 查询 结果 data);
               4. Compare the qualification 查询 结果 data to the reference answer sets defined for the queries (see
                  Clause 7.3.4).
Comment: The reference answer set is provided as 零件 of the TPC-DS 基准测试 规范.

7.3.4         Comparing answer sets
7.3.4.1       Each qualification 查询 结果 data must match exactly one of the reference answer sets for that 查询 in the
              following way:
                  •    A random sample of n distinct 行 (n>=3) of the qualification 查询 结果 data must match n distinct
                       行 in the reference answer set, subject to the constraints defined in Clause 7.5. For answer sets with
                       less than 4 行, all 行 must match, subject to the constraints defined in Clause 7.5.
                  •    The position of all n 行 being compared 必须 identical between the qualification 查询 结果 data
                       and the reference answer set, unless position differences can be explained by 实现 specific
                       NULL ordering or the 查询 does not specify an 订单 for its qualification 查询 结果 data.
Comment:         TPC-DS allows for position differences between the 输出 data and answer sets because the SQL standard
allows for 实现 specific NULL ordering.

7.4        Execution Rules

7.4.1         General Requirements

7.4.1.1       If the load test, power test, either 吞吐量 test, or either data 维护 test fail, the 基准测试 run is
              invalid.
7.4.1.2       All 表 created with explicit directives during the 执行 of the 基准测试 tests must meet the data
              accessibility 要求 defined in Clause 6.
7.4.1.3       The SUT, including any 数据库 server(s), 应 not be restarted at any time after the power test begins until
              after all tests have completed.
7.4.1.4       The driver 应 submit queries through one or more sessions on the SUT. Each session corresponds to one, and
              only one, 查询 stream on the SUT.
7.4.1.5   Parallel activity within the SUT directed toward the 执行 of a single 查询 or data 维护 function
          (e.g. intra-查询 parallelism) is not restricted.
7.4.1.6   The real-time clock used by the driver to compute the timing intervals must measure time with a resolution of at
          least 0.01 second.

7.4.2     The 基准测试 must use the following sequence of tests:

          a) Database Load Test
          b) Power Test
          c) Throughput Test 1
          d) Data Maintenance Test 1
          e) Throughput Test 2
          f) Data Maintenance Test 2

7.4.3     Database Load Test
7.4.3.1   The process of building the test 数据库 is known as 数据库 load. Database load consists of timed and un-
          timed components.
7.4.3.2   The population of the test 数据库, as defined in Clause 2.1, consists of two logical phases:
           a) Generation: the process of using dsdgen to create data in a format suitable for presentation to the load
              facility. The generated data 可 be stored in memory, or in flat files on tape or disk.
           b) Loading: the process of storing the generated data to the Database Location.
          Generation and loading of the data can be accomplished in two ways:
          a) Load from flat files: dsdgen is used to generate flat files that are stored in or copied to a location on
             the SUT or on external storage, which is different from the Database Location, i.e. this data is a copy of
             the TPC-DS data. The 记录 in these files 可 optionally be permuted and relocated to the SUT or
             external storage. Before 基准测试 执行 data 必须 loaded from these flat files into the
             Database Location. In this case, only the loading into the Database Location contributes to the 数据库
             load time.
          b) In-line load: dsdgen is used to generate data that is directly loaded into the Database Location using an
             "in-line" load facility. In this case, generation and loading occur concurrently and both contribute to
             the 数据库 load time.
          Comment: For option a) The TPC-DS data stored in the Database Location 必须 a full copy of the flat
          files. I.e. if the flat files were deleted the 基准测试 could be executed. The reason for this is that the storing of
          dsdgen data into the Database Location must 结果 in a new copy of the data, i.e. logical copying is not allowed.
7.4.3.3   The resources used to generate, permute, relocate to the SUT or hold dsdgen data 可 optionally be distinct
          from those used to run the actual 基准测试. For 示例:
           a) For load from flat files, a separate 系统 or a distinct storage subsystem 可 be used to generate, store
              and permute dsdgen data into the flat files used for the 数据库 load.
           b) For in-line load, separate and distinct processing elements 可 be used to generate and permute data
              and to deliver it to the Database Location.
7.4.3.4   Resources used only in the generation phase of the population of the test 数据库 必须 treated as follows:

          For load from flat files,

          a) Any processing element (e.g., CPU or memory) used exclusively to generate and hold dsdgen data or
             relocate it to the SUT prior to the load phase 应 not be included in the total priced 系统 and 应
             be physically removed from or made inaccessible to the SUT prior to the start of the Load Testusing
             vendor supported methods;
            b) Any storage facility (e.g., disk drive, tape drive or peripheral controller) used exclusively to generate
               and deliver data to the SUT during the load phase 应 not be included in the total priced 系统. The
               test sponsor must demonstrate to the satisfaction of the auditor that this facility is not being used in the
               Performance Tests.

            For in-line load, any processing element (e.g., CPU or memory) or storage facility (e.g., disk drive, tape
            drive or peripheral controller) used exclusively to generate and deliver dsdgen data to the SUT during the
            load phase 应 not be included in the total priced 系统 and 应 be physically removed from or made
            inaccessible to the SUT prior to the start of the Performance Tests.

            Comment: The intent is to isolate the 成本 of resources required to generate data from those required to
            load data into the Database Location.
7.4.3.5     An 实现 可 require additional programs to transfer dsdgen data into the 数据库 表 (from
            either 平面文件 or in-line load). If non-commercial programs are used for this purpose, their source code 必须
            disclosed. If commercially available programs are used for this purpose, their vendors and configurations 应
            be disclosed. Whether or not the 软件 is commercially available, use of the 软件's functionality's 应
            be limited to:
             1. Permutation of the data generated by dsdgen ;
             2. Delivery of the data generated by dsdgen to the data processing 系统.
7.4.3.6     The 数据库 load 必须 implemented using commercially available utilities (invoked at the command level
            or through an API) or an SQL programming interface (such as embedded SQL or ODBC).
7.4.3.7     Database Load Time

7.4.3.7.1   The 耗时 to prepare the Test Database for the 执行 of the 性能 test is called the Database
            Load Time (TLOAD), and 必须 disclosed. It includes all of the 耗时 to create the 表 defined in
            Clause 2.1, load data, create and populate EADS, define and validate constraints, gather statistics for the test
            数据库, configure the 系统 under test to execute the 性能 test, and to ensure that the test 数据库
            meets the data accessibility 要求 including syncing loaded data on RAID devices and the taking of a
            backup of the data processing 系统, when necessary.
7.4.3.8     The Database Load Time, known as TLOAD is the difference between Load Start Time and Load End Time.
             • Load Start Time is defined as the timestamp taken at the start of the creation of the 表 defined
                in Clause 2.1 or when the first character is read from any of the flat files or, in case of in-line load,
                when the first character is generated by dsdgen, whichever happens first
             • Load End Time is defined as the timestamp taken when the Test Database is fully populated, all
                EADS are created, a 数据库 backup has completed (if applicable) and the SUT is configured, as
                it will be during the 性能 test
            Comment: Since the time of the end of the 数据库 load is used to seed the random number generator for
            the substitution parameters, that time cannot be delayed in any way that would make it predictable to the
            test sponsor.

7.4.3.8.1   There are five classes of operations which 可 be excluded from 数据库 load time:
            a) Any operation that does not affect the state of the data processing 系统 (e.g., data generation into flat
               files, relocation of flat files to the SUT, permutation of data in flat files, operating-系统-level disk
               partitioning or 配置);
            b) Any modification to the state of the data processing 系统 that is not specific to the TPC-DS 工作负载
               (e.g. logical tablespace creation or 数据库 block formatting);
            c) The time required to install or remove physical resources (e.g. CPU, memory or disk) on the SUT that
               are not priced;
                d) An optional backup of the test 数据库 performed at the test sponsor’s discretion. However, if a
                   backup is required to ensure that the data accessibility properties can be met, it 必须 included in the
                   load time;
                e) Operations that create RAID devices.
                f) Tests required to fulfill data validation test (see Clause 3.5)
                g) Tests required to fulfill the 审计 要求 (see Clause 11)

7.4.3.8.2      There cannot be any manual intervention during the Database Load.

7.4.3.8.3      The SUT or any 组件 of it must not be restarted after the start of the Load Test and before the start of the
               Performance Test.
               Comment: The intent of this Clause is that when the timing ends the 系统 under test be capable of
               executing the Performance Test without any further change. The 数据库 load 可 be decomposed into
               several phases. Database load time is the sum of the elapsed times of all phases during which activity other
               than that detailed in Clause 7.4.3.8.1 occurred on the SUT.


7.4.4          Power Test

7.4.4.1        The Power Test is executed immediately following the load test.
7.4.4.2        The Power Test measures the ability of the 系统 to process a sequence of queries in the least amount of time
               in a single stream fashion.
7.4.4.3        The Power Test 应 execute queries submitted by the driver through a single 查询 stream with stream
               identification number 0 and using a single session on the SUT.
7.4.4.4        The queries in the Power Test 应 be executed in the 订单 assigned to its stream identification number and
               defined in 18Appendix D:.
7.4.4.5        Only one 查询 应 be active at any point of time during the Power Test.
7.4.4.6
7.4.5       Power Test Timing

7.4.5.1        The 耗时 of the Power Test, known as TPower is the difference between
                • Power Test Start Time, which is the timestamp that 必须 taken before the first character of the
                   executable 查询 text of the first 查询 of Stream 0 is submitted to the SUT by the driver; and
                • Power Test End Time, which is the timestamp that 必须 taken after the last character of 输出
                   data from the last 查询 of Stream 0 is received by the driver from the SUT.
                • The 耗时 of the Power Test 应 be disclosed.

7.4.6          Throughput Tests
7.4.6.1        The Throughput Tests measure the ability of the 系统 to process the most queries in the least amount of time
               with multiple users.
7.4.6.2        Throughput Test 1 immediately follows the Power Test. Throughput Test 2 immediately follows Data
               Maintenance Test 1.
7.4.6.3        Any explicitly created aggregates, as defined in Clause 5.1.4, present and enabled during any portion of
               Throughput Test 1or 2 必须 present and enabled at all times that queries are being processed.
7.4.6.4        Each 查询 stream contains a distinct permutation of the 查询 templates defined for TPC-DS. The permutation
               of queries for the first 20 查询 streams is shown in 18Appendix D:.
7.4.6.5        Only one 查询 应 be active on any of the sessions at any point of time during a Throughput Test.
7.4.6.6    The Throughput Test 应 execute queries submitted by the driver through a sponsor-selected number of 查询
           streams (Sq). There 必须 one session per 查询 stream on the SUT and each stream must execute queries
           serially (i.e. one after another).
7.4.6.7    Each 查询 stream is uniquely identified by a stream identification number s ranging from 1 to S, where S is
           the number of 查询 streams in the Throughput Tests (Throughput Test 1 plus Throughput Test 2).
7.4.6.8    Once a stream identification number has been generated and assigned to a given 查询 stream, the same number
           必须 used for that 查询 stream for the duration of the test.
7.4.6.9    The 值 of Sq is any even number larger than or equal to 4.
7.4.6.10   The same 值 of Sq 应 be used for bothThroughput Tests, and 应 remain constant throughout each
           Throughput Test.
7.4.6.11   The queries in each 查询 stream 应 be executed in the 订单 assigned to the stream identification number and
           defined in 18Appendix D:.

7.4.7      Throughput Test Timing

7.4.7.1    For a given 查询 template t, used to produce the ith 查询 within 查询 stream s, the 查询 耗时,
           QD(s, i, t), is the difference between:
            • The timestamp when the first character of the executable 查询 text is submitted to the SUT by
               the driver;
            • The timestamp when the last character of the 输出 is returned from the SUT to the driver and a
               success message is sent to the driver.
           Comment: All the operations that are 零件 of the 执行 of a 查询 (e.g., creation and deletion of a
           temporary 表 or a view) 必须 included in the 耗时 of that 查询.
7.4.7.2    The 耗时 of each 查询 in each stream 应 be disclosed for each Throughput Test and Power Test.
7.4.7.3    The 耗时 of Throughput Test 1, known as TTT1 is the difference between Throughput Test 1 Start Time
           and Throughput Test 1 End Time.
7.4.7.4    Throughput Test 1 Start Time, which is the timestamp that 必须 taken before the first character of the
           executable 查询 text of the first 查询 stream of Throughput Test 1 is submitted to the SUT by the driver.
7.4.7.5    Throughput Test 1 End Time, which is the timestamp that 必须 taken after the last character of 输出 data
           from the last 查询 of the last 查询 stream of Throughput Test 1 is received by the driver from the SUT.
           Comment: In this 子句 a 查询 stream is said to be first if it starts submitting queries before any other
           查询 streams. The last 查询 stream is defined to be that 查询 stream whose 输出 data are received last
           by the driver.
7.4.7.6    The 耗时 of Throughput Test 2, known as TTT2 is the difference between Throughput Test 2 Start Time
           and Throughput Test 2 End Time,
7.4.7.7    Throughput Test 2 Start Time is defined as a timestamp identical to Data Maintenance Test 1 End Time.
7.4.7.8    Throughput Test 2 End Time, which is the timestamp that 必须 taken after the last character of 输出 data
           from the last 查询 of the last 查询 stream of Throughput Test 2 is received by the driver from the SUT.
7.4.7.9    The 耗时 of each Throughput Test 应 be disclosed.

7.4.8      Data Maintenance Tests
7.4.8.1    The Data Maintenance Tests measure the ability to perform desired data changes to the TPC-DS data set.
7.4.8.2    Data Maintenance Test 1 immediately follows Throughput Test 1 and Data Maintenance Test 2 immediately
           follows Throughput Test 2.
7.4.8.3    Each Data Maintenance Test 应 execute Sq/2 刷新 runs.
7.4.8.4      Each 刷新 run uses its own 刷新 data set as generated by dsdgen. Refresh runs 必须 executed using
             刷新 data sets in the 订单 generated by dsdgen.
7.4.8.5      Any explicitly created aggregates, as defined in 子句 5.1.4, present and enabled during any portion of
             Throughput Test 1 must conform to 子句 7.4.6.3.
7.4.8.6      Refresh runs do not overlap; at most one 刷新 run is running at any time. All data 维护 functions
             need to have finished in 刷新 run n before any data 维护 function can commence on 刷新 run n+1.
7.4.8.7      The scheduling of each data 维护 function within 刷新 runs is left to the test sponsor.
7.4.8.8      The Durable Medium failure required as 零件 of the Data Accessibility Test (Clause 6.1.2) 必须 triggered
             during Data Maintenance Test 1 (at some time after the starting timestamp of the first 刷新 run in Data
             Maintenance Test 1, and before the ending timestamp of the last 刷新 run in Data Maintenance Test 2).

7.4.9        Data Maintenance Timing
7.4.9.1      The 耗时 DI(i,s), for the data 维护 function i executing in 刷新 run s is the difference
             between:
              • The timestamp, DS(i,s), when the first character of the data 维护 function is submitted to
                 the SUT by the driver, or when the first character requesting the 执行 of data 维护
                 function is submitted to the SUT by the driver or when the first character of the 刷新 data set
                 used by the data 维护 function is read from a location other than the Database Location,
                 whichever happens first; and
              • The timestamp, DE(i,s), when the last character of 输出 data from the data 维护
                 function is received by the driver from the SUT and a success message has been received by the
                 driver from the SUT.
7.4.9.2     The 耗时, DI(s), for the 执行 of all data 维护 functions of 刷新 run s, is the difference
            between:
          • The start timestamp, DS(s), of 刷新 run s, defined as DS(i,s) for the first data 维护 function i
            executed as 零件 of 刷新 run s; and
          • The end timestamp, DE(s), of 刷新 run s, defined as DS(j,s), for the last data 维护 function j
            executed as 零件 of 刷新 run s.
7.4.9.3     The 耗时 of Data Maintenance Test 1, known as TDM1 is the difference between:
          • Data Maintenance Test 1 Start Time, defined as the starting timestamp, DS(1), of the first 刷新 run
            in Data Maintenance Test 1 or the starting timestamp of the load of 刷新 data set 1 into the staging
            area (if used), whichever happens first; and
          • Data Maintenance Test 1 End Time, defined as the ending timestamp, DE(Sq/2), of the last 刷新
            run in Data Maintenance Test 1, including all EADS updates.
7.4.9.4     The 耗时 of Data Maintenance Test 2, known as TDM2 is the difference between:
          • Data Maintenance Test 2 Start Time, defined as the starting timestamp, DS(Sq/2+1), of the first
            刷新 run in Data Maintenance Test 2 or the starting timestamp of the load of the 刷新 data set 2
            into the staging area (if used), whichever happens first; and
          • Data Maintenance Test 2 End Time, defined as the ending timestamp, DE(Sq), of the last 刷新 run
            in Data Maintenance Test 2, including all EADS updates.

7.5       Output Data

7.5.1        After 执行, a 查询 returns one or more 行. The 行 are called the 输出 data. The 行 count of
             the 输出 data must match the 行 count of the validation 输出 data, except for differences that are due
             to the precision used to calculate intermediate results during 查询 processing. The test sponsor must
             provide proof that all differences in 行 count are due to the precision used to calculate intermediate
             results during 查询 processing.

7.5.2        Output data 应 adhere to the following guidelines:

              a) Columns appear in the 订单 specified by the SELECT list of the 查询.
              b) Column headings are optional.
              c) Non-integer expressions including prices are expressed in decimal notation with at least two digits
                 behind the decimal point.
              d) Integer quantities contain no leading zeros.
              e) Dates are expressed in a format that includes the year, month and day in integer form, in that 订单
                 (e.g., YYYY-MM-DD). The delimiter between the year, month and day is not specified. Other 日期
                 representations, for 示例 the number of days since 1970-01-01, are specifically not allowed.
              f) Strings are case-sensitive and 必须 displayed as such. Leading or trailing blanks are acceptable.
              g) The amount of white space between 列 is not specified.
              h) NULLs must always be printed by the same string pattern of zero or more characters.
             Comment: The intent of this 子句 is to assure that 输出 data is expressed in a format easily readable by
             a non-sophisticated computer user, and can be compared with known 输出 data for 查询 validation.
             Comment: Since the reference answer set provided in the 规范 originated from different data
             processing 系统, the reference answer set does not consistently express NULL 值 with the same
             string pattern.

7.5.3        The precision of all 值 contained in the 输出 data 应 adhere to the following 规则:

              a) For singleton 列 值 and results from COUNT aggregates, the 值 must exactly match the
                 查询 validation 输出 data.
              b) For ratios, results 必须 within 1% of the 查询 validation 输出 data when reported to the nearest
                 1/100th, rounded up.
              c) For results from SUM money aggregates, the resulting 值 必须 within $100 of the 查询
                 validation 输出 data.
              d) For results from AVG aggregates, the resulting 值 必须 within 1% of the 查询 validation
                 输出 data when reported to the nearest 1/100th, rounded up.

7.6       Metrics

7.6.1        TPC-DS defines three primary metrics:

              a) A Performance Metric, QphDS@SF, reflecting the TPC-DS 查询 吞吐量 (see Clause 7.6.3);
              b) A Price-Performance 指标, $/kQphDS@SF (see Clause 7.6.5);
              c) System 可用性 日期 (see Clause 7.6.6).

7.6.2        TPC-DS also defines several secondary metrics. The secondary metrics are:

              a) Load time, as defined in Clause 7.4.3.7;
              b) Power Test Elapsed time as defined in Clause 7.4.4 and the 耗时 of each 查询 in the Power
                 Test;
              c) Throughput Test 1 and Throughput Test 2 elapsed times, as defined in clauses 7.4.7.3 and 7.4.7.6.
              d) When TPC_Energy option is chosen for reporting, the TPC-DS energy 指标 reports the power per
                 性能 and is expressed as Watts/kQphDS@SF. (see TPC-Energy 规范 for additional
                 要求).

             Each secondary 指标 应 be referenced in conjunction with the 规模因子 at which it was achieved.
             For 示例, Load Time references 应 take the form of Load Time @ SF, or “Load Time = 10 hours @
             1000”.

7.6.3        The Performance Metric (QphDS@SF)
7.6.3.1      The primary 性能 指标 of the 基准测试 is QphDS@SF, defined as:
          Where:

          • SF is defined in Clause 3.1.3, and is based on the 规模因子 used in the 基准测试
          • Q is the total number of weighted queries: Q=Sq*99, with Sq being the number of streams
            executed in a Throughput Test
          • TPT=TPower*Sq, where TPower is the total 耗时 to complete the Power Test, as defined in
            Clause 7.4.4, and Sq is the number of streams executed in a Throughput Test
          • TTT= TTT1+TTT2, where TTT1 is the total 耗时 of Throughput Test 1 and TTT2 is the total
            耗时 of Throughput Test 2, as defined in Clause 7.4.6.
          • TDM= TDM1+TDM2, where TDM1 is the total 耗时 of Data Maintenance Test 1 and TDM2 is the
            total 耗时 of Data Maintenance Test 2, as defined in Clause 7.4.9.
          • TLD is the load factor computed as TLD=0.01*Sq*TLoad, where Sq is the number of streams executed
            in a Throughput Test and TLoad is the time to finish the load, as defined in Clause 7.1.2.
          • TPT, TTT, TDM and TLD quantities are in units of decimal hours with a resolution of at least 1/3600th
            of an hour (i.e., 1 second)

7.6.4     TPerformanceTest is defined as the difference between the Power Test Start Time (see Clause 7.4.5.1) and the
          Data Maintenance Test 2 End Time (see Clause 7.4.9.4)


              Comment:       The floor symbol ( ! " ) in the above equation truncates any fractional 零件.

7.6.5     The Price Performance Metric ($/kQphDS@SF)

7.6.5.1   The 价格-性能 指标 for the 基准测试 is defined as:
                                                                       1000 ∗ 𝑃
                                                  $/𝑘𝑄𝑝ℎ𝐷𝑆@𝑆𝐹 =
                                                                      𝑄𝑝ℎ𝐷𝑆@𝑆𝐹



          Where:

          P is the 价格 of the Priced System as defined in Clause 9.2.1.

          kQphDS@SF is the reported 性能 指标 as defined in Clause 7.6.3 multiplied by 1000

          Comment: The 价格-性能 指标 reflects the 价格 of the Priced System for 1000 QphDS@SF
7.6.5.2   If a 基准测试 配置 is priced in a currency other than US dollars, the units of the 价格-性能
          metrics 可 be adjusted to employ the appropriate currency.

7.6.6     The System Availability Date, as defined in the current revision of the TPC Pricing Specification 必须
          disclosed in any references to either the 性能 or 价格-性能 指标 of the 基准测试.

7.6.7     Fair Metric Comparison
7.6.7.1   Results at the different scale factors are not comparable, due to the substantially different computational
          challenges found at different data volumes. Similarly, the 系统 性价比 可 not scale down
          linearly with a decrease in 数据库 size due to 配置 changes required by changes in 数据库 size.
          If results measured against different 数据库 sizes (i.e., with different scale factors) appear in a printed or
          electronic communication, then each reference to a 结果 or 指标 must clearly indicate the 数据库 size
          against which it was obtained. In particular, all textual references to TPC-DS metrics (性能 or
          性价比) appearing 必须 expressed in the form that includes the size of the test 数据库 as an
          integral 零件 of the 指标’s name; i.e. including the “@size” suffix. This applies to metrics quoted in text or
          表 as well as those used to annotate charts or graphs. If metrics are presented in graphical form, then the
          test 数据库 size on which 指标 is based 必须 immediately discernible either by appropriate axis
          labeling or data point labeling.

          In addition, the results 必须 accompanied by a disclaimer stating:

          "The TPC believes that comparisons of TPC-DS results measured against different 数据库 sizes are
          misleading and discourages such comparisons".
7.6.7.2   Any TPC-DS 结果 is comparable to other TPC-DS results regardless of the number of 查询 streams used
          during the test (as long as the scale factors chosen for their respective test databases were the same).

7.6.8     Required Reporting Components

          To be compliant with the TPC-DS standard and the TPC's fair use policies, all public references to TPC-DS
          results for a given 配置 must include the following components:

          • The size of the test 数据库, expressed separately or as 零件 of the 指标's names (e.g.,
            QphDS@10GB);
          • The TPC-DS Performance Metric, QphDS@Size;
          • The TPC-DS Price/Performance 指标, $/kQphDS@Size;
          • The Availability Date of the complete 配置 (see the current revision of the TPC Pricing
            Specification located on the TPC website (http://www.tpc.org).

          Following are two examples of compliant reporting of TPC-DS results:

          Example 1: At 10GB the RALF/3000 Server priced at $3,618.02 has a TPC-DS Query-per-Hour 指标 of
          3,010 when run against a 10GB 数据库 yielding a TPC-DS Price/Performance of $1,202 per 1000 QphDS
          and will be available 1-Apr-06.

          Example 2: The RALF/3000 Server, which will start shipping on 1-Apr-06, is rated 3,010 QphDS@10GB
          and 1,202 $/kQphDS@10GB.
                                            8   SUT AND DRIVER IMPLEMENTATION

           This 子句 defines the System Under Test (SUT) and the 基准测试 driver.

8.1     Models of Tested Configurations

8.1.1      The tested and reported 配置(s) is composed of a driver that submits queries to a 系统 under test
           (SUT). The SUT executes these queries and replies to the driver. The driver resides on the SUT 硬件
           and 软件.

8.1.2      Figure 8-1 illustrates examples of driver/SUT configurations. The driver is the shaded area. The diagram
           also depicts the driver/SUT boundary (see Clause 7.1.16 and Clause 7.4) where timing intervals are
           measured.

                                            Host Syst ems
                                                                *
                                                                    *

                                                    Query
                                   DRIVER




                                                  Execution                         *
                                                                               Network
                                                      &
                                                   Database
                                                    Access




                 Client(s)                                              Server(s)
                               *                                                    *
                                   *                                                    *
              DRIVER




                         Query                  Network                                                *
                                                                                                  Network
                       Execution                                            Database
                                                                             Access




           Items marked by an * are opt ional


            Figure 8-1: Two driver/SUT configurations, a "host-based" and a "client/server" 配置



8.2     System Under Test (SUT) Definition

8.2.1      The SUT consists of:

            a) The host 系统(s) or server(s), including 硬件 and 软件 supporting access to the 数据库
               employed in the 性能 test and whose 成本 and 性能 are described by the 基准测试
               metrics
            b) Any client processing units (e.g., front-end processors, workstations, etc.) used to execute the queries
        c) The 硬件 and 软件 components needed to communicate with user interface devices
        d) The 硬件 and 软件 components of all networks required to connect and support the SUT
           components
        e) Data storage media sufficient to satisfy scaling 规则 in Clause 3, data accessibility properties in Clause
           6.1 and data described in Clause 7.5.

8.2.2   All SUT components, as described in Clause 8.2.1, 应 be commercially available 软件 or 硬件
        products.

8.2.3   An 实现-specific layer can be implemented on the SUT. This layer 应 be logically located
        between the driver and the SUT, as depicted by Figure 8-2.

                                  Figure 8-2: Implementation Specific Layer


                                                        DRIVER


                          Exec. Query Text + Row Count
                                                                   Output Data


                                            Im plem entation Specific Layer


                                                Commercially Available
                                                        Products
                                                (e.g., OS, DBMS, ISQL)
                    SUT

8.2.4   If present on the SUT, an 实现-specific layer, 应 be minimal and general purpose (i.e., not
        limited to the TPC-DS queries). The source code 应 be disclosed. The functions performed by an
        实现 specific layer 应 be strictly limited to the following:

        a) Database 事务 control operations before and after each 查询 执行
        b) Cursor control and manipulation operations around the executable 查询 text
        c) Definition of procedures and data structures required to process dynamic SQL, including the
           communication of the executable 查询 text to the commercially available layers of the SUT and the
           reception of the 查询 输出 data
        d) Communication with the commercially available layers of the SUT
        e) Buffering of the 查询 输出 data
        f) Communication with the drivere it

        The following are examples of functions that the 实现-specific layer 应 not perform:
        a) Any modification of the executable 查询 text;
        b) Any use of stored procedures to execute the queries;
        c) Any sorting or translation of the 查询 输出 data;
        d) Any function prohibited by the 要求 of Clause 7.2.8.1.
8.3     Driver Definition

8.3.1      The driver presents the 工作负载 to the SUT. The driver is a logical entity that can be implemented using
           one or more programs, processes, or 系统. The driver 应 perform only the following functions:

            a) Generate a unique stream ID, starting with 1 for each 查询 stream
            b) Sequence queries for 执行 by the 查询
            c) Activate, schedule, and/or synchronize the 执行 of data 维护 functions
            d) Generate the executable 查询 text for each 查询
            e) Generate 值 for the substitution parameters of each 查询
            f) Complete the executable 查询 text by replacing the substitution parameters by the 值 generated
               for them and, if needed, replacing the text-tokens by the 查询 stream ID
            g) Submit each complete executable 查询 text to the SUT for 执行, including the number of 行 to
               be returned when specified by the functional 查询 定义
            h) Submit each data 维护 function to the SUT for 执行
            i) Receive the 输出 data resulting from each 查询 执行 from the SUT
            j) Measure the 执行 times of the queries and the data 维护 functions and compute
               measurement statistics
            k) Maintain an 审计 log of 查询 text and 查询 执行 输出

8.3.2      The generation of executable 查询 text used by the driver to submit queries to the SUT does not need to
           occur on the SUT and does not have to be included in any timing interval.

8.3.3      The driver 应 not perform any function other than those described in Clause 8.3.1. Specifically, the
           driver 应 not perform any of the following functions:

            a) Performing, activating, or synchronizing any operation other than those mentioned in Clause 8.3.1
            b) Delaying the 执行 of any 查询 after the 执行 of the previous 查询 other than for delays
               necessary to process the functions described in Clause 8.3.1. This delay 必须 reported and can not
               exceed half a second between any two consecutive queries of the same 查询 stream
            c) Modifying the compliant executable 查询 text prior to its submission to the SUT
            d) Embedding the executable 查询 text within a stored procedure 定义 or an application program
            e) Submitting to the SUT the 值 generated for the substitution parameters of a 查询 other than as
               零件 of the executable 查询 text submitted
            f) Submitting to the SUT any data other than the instructions to execute the data 维护 functions,
               the compliant executable 查询 text and, when specified by the functional 查询 定义, the
               number of 行 to be returned
            g) Artificially extending the 执行 time of any 查询.

8.3.4      The driver is not required to be priced.
                                          9     PRICING

             This 节 defines the components, functional 要求 of what is priced, and what substitutions are
             allowed. Rules for 定价 the Priced Configuration and associated 软件 and 维护 are included
             in the current revision of the TPC Pricing Specification located on the TPC website (http://www.tpc.org).



9.1       Pricing Methodology

9.1.1        The Default 1-Year Pricing Methodology (as defined in the TPC Pricing Specification) 必须 used to
             calculate the 价格 and the 性价比 结果 of the TPC-DS 基准测试.

9.1.2        The Pricing Model 1 – Default Pricing Model (as defined in the TPC Pricing Specification) is the only
             定价 model allowed in a TPC-DS 结果.

9.2       Priced Configuration

             The 配置 to be priced 应 include 硬件, 软件, licensed compute services and applicable
             维护 present in the System Under Test (SUT), a communication interface that can support user
             interface devices, additional operational components configured on the test 系统, and 维护 on all
             of the above

9.2.1        System Under Test

             Calculation of the priced 系统 consists of:

              • Price of the SUT as tested and defined in Clause 8;
              • Price of a communication interface capable of supporting the required number of user interface
                devices defined in Clause 8;
              • Price of on-line storage for the 数据库 as described in Clause 9.2.3 and storage for all 软件
                included in the priced 配置;
              • Price of additional products (软件 or 硬件) required for customary operation,
                administration and 维护 of the SUT for a period defined in the Pricing Methodology
                (Clause 9.1.)
              • Price of all products required to create, execute, administer, and maintain the executable 查询
                texts and to create and populate the test 数据库.

             Specifically excluded from the priced 系统 calculation are:

              • End-user communication devices and related cables, connectors, and concentrators;
              • Equipment and tools used exclusively in the production of the full disclosure report;
              • Equipment and tools used exclusively for the 执行 of the dsdgen or dsqgen (see Appendix
                F) programs.0

9.2.2         User Interface Devices and Communications

9.2.2.1      The priced 系统 must include the 硬件 and 软件 components of a communication interface capable
             of supporting a number of user interface devices (e.g., terminals, workstations, PCs, etc.) at least equal to 10
             times the minimum number of 查询 streams or the actual number of 查询 streams, whichever is greater.
             Comment: Test sponsors are encouraged to configure the SUT with a general-purpose communication
             interface capable of supporting a large number of user interface devices.
9.2.2.2     Only the interface is to be priced. Not to be included in the priced 系统 are the user interface devices
            themselves and the cables, connectors and concentrators used to connect the user interface devices to the SUT.
            For 示例, in a 配置 that includes an Ethernet interface to communicate with PCs, the Ethernet card
            and supporting 软件 必须 priced, but not the Ethernet cables and the PCs.
            Comment: Active components (e.g., workstations, PCs, concentrators, etc.) can only be excluded from the
            priced 系统 under the assumption that their role is strictly limited to submitting executable 查询 text
            and receiving 输出 data and that they do not participate in the 查询 执行. All 查询 processing
            performed by the tested 配置 is considered 零件 of the 性能 test and can only be done by
            components that are included in the priced 系统.
9.2.2.3     The communication interface used 必须 an industry standard interface, such as Ethernet, Token Ring, or
            RS232.
9.2.2.4     The following diagram illustrates the boundary between what is priced (on the right) and what is not (on the
            left). In the event the driver is a commercial product its 价格 应 not be included in the 价格 of the SUT:

                                                Q"#5M"                                !"#

                                                                          S1U9:MUMBOIO#)BD;9MA#P#AD<I-M"7
          .LM"D1BOM"PIAM              Network                                 =)UUM"A#I::-D>5I#:I?:M
            QM5#AMSL7                                                                 !")+*AOL
                                                                              SM@C@ADB;ADQ(C;AD1;a<7



                                   !"#A#BCD()*B+I"-


                                                Figure 9-1: Pricing Boundary



9.2.3       Database Storage
9.2.3.1     The storage that is required to be priced includes:
             • storage required to execute the 基准测试;
             • storage and media needed to assure that the test 数据库 meets the data accessibility
                要求;
             • storage used to hold optional staging area data.
9.2.3.2     All storage required for the priced 系统 必须 present on the tested 系统.

9.2.4       Additional Operational Components

9.2.4.1     Additional products that might be included on a 客户 installed 配置, such as operator consoles and
            magnetic tape drives, are also to be included in the priced 系统 if explicitly required for the operation,
            administration, or 维护, of the priced 系统.
9.2.4.2     Copies of the 软件, on appropriate media, and a 软件 load device, if required for initial load or
            维护 updates, 必须 included.
9.2.4.3     The 价格 of an Uninterruptible Power Supply, if specifically contributing to a 持久性 solution, 必须
            included.
9.2.4.4     The 价格 of all cables used to connect components of the 系统 (except as noted in Clause9.2.2.2) 必须
            included.
9.3     Allowable Substitution

9.3.1      Substitution is defined as a deliberate act to replace components of the Priced Configuration by the Test
           Sponsor as a 结果 of failing the 可用性 要求 of the current revision of the TPC Pricing
           Specification or when the Part Number for a 组件 changes.

9.3.2      Some 硬件 components of the Priced Configuration 可 be substituted after the Test Sponsor has
           demonstrated to the Auditor's satisfaction that the substituting components do not negatively impact the
           reported TPC-DS Performance Metric. All Substitutions 必须 reported in the Report and noted in the
           Auditor's Attestation Letter. The following 硬件 组件 可 be substituted:Durable Medium

9.4     Pricing Period

9.4.1      The 定价 period is defined as: TLOAD+TPerformance

            • TLOAD as defined in Clause 7.4.3.8
            • TPerformance as defined in Clause 7.6.4
                                             10 FULL DISCLOSURE

10.1       Reporting Requirements

10.1.1         A Full Disclosure Report (FDR) is required for a 基准测试 publication. The FDR is a zip file of a directory
               structure containing the following:

10.1.2         A Report in Adobe Acrobat PDF format,

10.1.3         An Executive Summary Statement (ES) in Adobe Acrobat PDF format,

10.1.4         An XML document (“ES.xml”) with approximately the same information as in the Executive Summary
               Statement,

10.1.5         The Supporting Files consisting of various source files, scripts, and listing files.

10.1.6         Requirements for the FDR file directory structure are described below.

10.1.7         The intent of this disclosure is to simplify comparison between results and for a 客户 to be able to
               replicate the results of this 基准测试 given appropriate documentation and products.

10.2       Format Guidelines

10.2.1         While established practice or practical limitations 可 cause a particular 基准测试 disclosure to differ
               from the examples provided in various small ways, every effort 应 be made to conform to the format
               guidelines. The intent is to make it as easy as possible for a reviewer to read, compare and evaluate material
               in different 基准测试 disclosures.

10.2.2         All sections of the report, including appendices, 必须 printed using font sizes of a minimum of 8 points.

10.2.3         The Executive Summary 必须 included near the beginning of the full disclosure report.

10.2.4         The directory structure of the FDR has three folders:

           •   ExecutiveSummaryStatement - contains the Executive Summary Statement and ES.xml
           •   Report - contains the Report,
           •   SupportingFiles - contains the Supporting Files.

10.3       Full Disclosure Report Contents

               The FDR 应 be sufficient to allow an interested reader to evaluate and, if necessary, recreate an
               实现 of TPC-DS. If any sections in the FDR refer to another 节 of the report (e.g., an
               appendix), the names of the referenced scripts/programs 必须 clearly labeled in each 节.

               Comment: Since the building of a 数据库 可 consist of a set of scripts and corresponding 输入 files, it
               is important to disclose and clearly identify, by name, scripts and 输入 files in the FDR.

               The 订单 and titles of sections in the test sponsor's full disclosure report must correspond with the 订单
               and titles of sections from the TPC-DS standard 规范 (i.e., this document).

10.3.1         General Items
10.3.1.1       A statement identifying the 基准测试 sponsor(s) and other participating companies 必须 provided.
10.3.1.2       Settings 必须 provided for all 客户-tunable parameters and options that have been changed from the
               defaults found in actual products, including but not limited to:
                a) Database tuning options;
           b) Optimizer/Query 执行 options;
           c) Query processing tool/language 配置 parameters;
           d) Recovery/commit options;
           e) Consistency/locking options;
           f) Operating 系统 and 配置 parameters;
           g) Configuration parameters and options for any other 软件 组件 incorporated into the 定价
              structure;
           h) Compiler 优化 options.
           Comment: In the event that some parameters and options are set multiple times, it 必须 easily
           discernible by an interested reader when the parameter or option was modified and what new 值 it
           received each time.
           Comment: This 要求 can be satisfied by providing a full list of all parameters and options, as long
           as all those that have been modified from their default 值 have been clearly identified and these
           parameters and options are only set once.
10.3.1.3   Explicit response to individual disclosure 要求 specified in the body of earlier sections of this document
           必须 provided.
10.3.1.4   Diagrams of both measured and priced configurations 必须 provided, accompanied by a 说明 of the
           differences. This includes, but is not limited to:
            a) Number and type of processors (including size of L2 cache);
            b) Size of allocated memory, and any specific mapping/partitioning of memory unique to the test;
            c) Number and type of disk units (and controllers, if applicable);
            d) Number of channels or bus connections to disk units, including their protocol type;
            e) Number of LAN (e.g., Ethernet) connections, including routers, workstations, terminals, etc., that were
                physically used in the test or are incorporated into the 定价 structure;
            f) Type and the run-time 执行 location of 软件 components (e.g., data processing 系统, 查询
                processing tools/languages, middleware components, 软件 drivers, etc.).

           The following sample diagram illustrates a measured 基准测试 配置 using Ethernet, an external
           driver, and four processors in the SUT. Note that this diagram does not depict or imply any optimal
           配置 for the TPC-DS 基准测试 measurement.

                          Cluster of 4 Systems


                                                                 96 x 2.1 G B Disk Unit s
                          RALF/3016

                           16 x I486DX                                     6 Units

                         1 GB of memory


                           16 x SCSI-2                                                          16
                                                                                              Channels
                            1 Ethernet
                             adapter


                                                                           6 Units
                  LAN:     Ethernet using NETplus routers
                  CPU:     16 x a243DX 50MHz with 256 KByte Second Level Cache
                                    1 gigabyte of main memory
                                     4 x SCSI-2 Fast Controllers
                  Disk:    96 x 2.1 gigabyte SCSI-2 drives

                                           Figure 10-1: Sample Configuration Diagram



             Comment: Detailed diagrams for 系统 configurations and architectures can vary widely, and it is
             impossible to provide exact guidelines suitable for all implementations. The intent here is to describe the
             系统 components and connections in sufficient detail to allow independent reconstruction of the
             measurement environment.

10.3.2       Clause 2- Logical Database Design Related Items
10.3.2.1     Listings 必须 provided for the DDL scripts and must include all 表 定义 statements and all other
             statements used to set-up the test and qualification databases.
10.3.2.2     The physical organization of 表 and indices within the test and qualification databases 必须 disclosed. If
             the 列 ordering of any 表 is different from that specified in Clause2.3 or 2.4,, it 必须 noted.
             Comment: The concept of physical organization includes, but is not limited to: 记录 clustering (i.e.,
             行 from different logical 表 are co-located on the same physical data page), 索引 clustering (i.e., 行
             and leaf nodes of an 索引 to these 行 are co-located on the same physical data page), and partial fill-
             factors (i.e., physical data pages are left partially empty even though additional 行 are available to fill
             them).
10.3.2.3      If any directives to DDLs are used to horizontally partition 表 and 行 in the test and qualification
             databases, these directives, DDLs, and other details necessary to replicate the partitioning behavior 必须
             disclosed.
10.3.2.4     Any 复制 of physical objects 必须 disclosed and must conform to the 要求 of Clause 2.5.3.

10.3.3       Clause 3 - Scaling and Database Population Related Items
10.3.3.1     The cardinality (e.g., the number of 行) of each 表 of the test 数据库, as it existed at the completion of the
             数据库 load (see Clause 7.1.2) 必须 disclosed.
10.3.3.2     The distribution of 表 and logs across all media 必须 explicitly described using a format similar to that
             shown in the following 示例 for both the tested and priced 系统.
             Comment: Detailed diagrams for layout of 数据库 表 on disks can widely vary, and it is difficult to
             provide exact guidelines suitable for all implementations. The intent is to provide sufficient detail to allow
             independent reconstruction of the test 数据库. The 图 that follows is an 示例 of 数据库 layout
             descriptions and is not intended to describe any optimal layout for the TPC-DS 数据库.


           Controller         Disk Drive         Description of Content
           40A                0                  Operating 系统, root
                              1                  System page and swap
                              2                  Physical log
                              3                  100% of store_sales and store 表
           40B                0                  33% of store_sales, catalog_sales and catalog_returns 表
                              1                  33% of store_sales, catalog_sales and catalog_returns 表
                              2                  34% of store_sales, catalog_sales and catalog_returns 表
                              3                  100% of 日期_dim, time_dim and reason 表
10.3.3.3    Figure 10-2: Sample Database Layout Description
10.3.3.4    The mapping of 数据库 partitions/replications 必须 explicitly described.
            Comment: The intent is to provide sufficient detail about partitioning and 复制 to allow
            independent reconstruction of the test 数据库.
10.3.3.5    Implementations 可 use some form of RAID. The RAID level used 必须 disclosed for each device. If
            RAID is used in an 实现, the logical intent of its use 必须 disclosed. Three levels of usage are
            defined:
             a) Base 表 only: In this case only the Base Tables (see Clause 2) are protected by any form of RAID;
             b) Base 表 and EADS: in addition to the protection of the base 表, implementations in this class
                must also employ RAID to protect all EADS;
             c) Everything: implementations in this usage category must employ RAID to protect all 数据库 storage,
                including temporary or scratch space in addition to the base 表 and EADS.
10.3.3.6    The version number (i.e., the major revision number, the minor revision number, and third tier number) of
            dsdgen 必须 disclosed. Any modifications to the dsdgen source code (see Appendix B:) 必须 disclosed.
            In the event that a program other than dsdgen was used to populate the 数据库, it 必须 disclosed in its
            entirety.
10.3.3.7    The 数据库 load time for the test 数据库 (see Clause 7.4.3.7) 必须 disclosed.
10.3.3.8    The data storage ratio 必须 disclosed. It is computed by dividing the total data storage of the priced
            配置 (expressed in GB) by SF corresponding to the 规模因子 chosen for the test 数据库 as defined
            in Clause 3.1. The ratio 必须 reported to the nearest 1/100th, rounded up. For 示例, a 系统 configured
            with 96 disks of 2.1 GB capacity for a 100GB test 数据库 has a data storage ratio of 2.02.
            Comment: For the reporting of configured disk capacity, gigabyte (GB) is defined to be 2^30 bytes. Since
            disk manufacturers typically report disk size using base ten (i.e., GB = 10^9), it 可 be necessary to convert
            the advertised size from base ten to base two.
10.3.3.9    The details of the 数据库 load 必须 disclosed, including a block diagram illustrating the overall process.
            Disclosure of the load procedure includes all steps, scripts, 输入 and 配置 files required to completely
            reproduce the test and qualification databases.
10.3.3.10   Any differences between the 配置 of the qualification 数据库 and the test 数据库 必须 disclosed.

10.3.4      Clause 4 and 5 - Query and Data Maintenance -Related Items

10.3.4.1    The 查询 language used to 实现 the queries 必须 identified (e.g., "RALF/SQL-Plus").
10.3.4.2    The method of verification for the random number generation 必须 described unless the supplied dsdgen
            and dsqgen were used.
10.3.4.3    The method used to generate 值 for substitution parameters 必须 disclosed. The version number (i.e., the
            major revision number, the minor revision number, and third tier number) of dsqgen 必须 disclosed..
10.3.4.4    The executable 查询 text used for 查询 validation 必须 disclosed along with the corresponding 输出 data
            generated during the 执行 of the 查询 text against the qualification 数据库. If minor modifications have
            been applied to any functional 查询 definitions or approved variants in 订单 to obtain executable 查询 text,
            these modifications 必须 disclosed and justified. The justification for a particular minor 查询 modification
            can apply collectively to all queries for which it has been used. The 输出 data for the power and Throughput
            Tests 必须 made available electronically upon request.
            Comment: For 查询 输出 of more than 10 行, only the first 10 need to be disclosed in the FDR. The
            remaining 行 必须 made available upon request.
10.3.4.5    All the 查询 substitution parameters used during the 性能 test 必须 disclosed in tabular format,
            along with the seeds used to generate these parameters.
10.3.4.6    All 查询 and 刷新 session initialization parameters, settings and commands 必须 disclosed (see Clauses
            7.2.2 through 7.2.7).
10.3.4.7   The details of how the data 维护 functions were implemented 必须 disclosed (including source code
           of any non-commercial program used).
10.3.4.8   Any object created in the staging area (see Clause 5.1.8 for 定义 and usage restrictions) used to 实现
           the data 维护 functions 必须 disclosed. Also, any disk storage used for the staging area 必须
           priced, and any mapping or virtualization of disk storage 必须 disclosed.

10.3.5     Clause 6– Data Persistence Properties Related Items
10.3.5.1   The results of the data accessibility tests 必须 disclosed along with a 说明 of how the data accessibility
           要求 were met.

10.3.6     Clause 7- Performance Metrics and Execution Rules Related Items
10.3.6.1   Any 系统 activity on the SUT that takes place between the conclusion of the load test and the beginning of
           the 性能 test 必须 fully disclosed including listings of scripts or command logs.
10.3.6.2   The details of the steps followed to 实现 the 性能 test 必须 disclosed.
10.3.6.3   The timing intervals defined in Clause 7 必须 disclosed.
10.3.6.4   For each Throughput Test, the minimum, the 25th percentile, the median, the 75th percentile, and the maximum
           times for each 查询 应 be reported.
10.3.6.5   The start time and finish time for each 查询 stream 必须 reported.
10.3.6.6   The start time and finish time for each 刷新 run and each data 维护 function in the 刷新 runs must
           be reported for the Throughput Tests (i.e., all DS(i,s), DE(i,s), DS(s), DE(s) and 必须 disclosed).
10.3.6.7   The computed 性能 指标, related numerical quantities and the 性价比 指标 必须
           reported.
10.3.6.8   Sufficient information that proves that any differences in the 行 count of the 查询 输出 data and the
           qualification 输出 data in the qualification test are due to the precision used to calculate intermediate results
           during 查询 processing 必须 disclosed.

10.3.7     Clause 8 - SUT and Driver Implementation Related Items
10.3.7.1   A detailed textual 说明 of how the driver performs its functions, how its various components interact and
           any product functionalities or environmental settings on which it relies 必须 provided. All related source
           code, scripts and 配置 files 必须 disclosed. The information provided 应 be sufficient for an
           independent reconstruction of the driver.
10.3.7.2   If an 实现 specific layer is used, then a detailed 说明 of how it performs its functions, how its
           various components interact and any product functionalities or environmental setting on which it relies 必须
           provided. All related source code, scripts and 配置 files 必须 disclosed. The information provided
           应 be sufficient for an independent reconstruction of the 实现 specific layer.
10.3.7.3   If profile-directed 优化 as described in Clause 7.2.10 is used, such use 必须 disclosed. In particular,
           the procedure and any scripts used to perform the 优化 必须 disclosed.

10.3.8     Clause 9 - Pricing Related Items
10.3.8.1   A detailed list of 硬件 and 软件 used in the priced 系统 必须 reported. The 规则 for 定价 are
           included in the current revision of the TPC Pricing Specification located on the TPC website
           (http://www.tpc.org).
10.3.8.2   The System Availability Date (see Clause 7.6.6) 必须 the single 可用性 日期 reported on the first page of
           the executive summary. The full disclosure report must report Availability Dates individually for at least each
           of the categories for which a 定价 subtotal 必须. All Availability Dates required to be reported 必须
           disclosed to a precision of 1 day, but the precise format is left to the test sponsor.
              Comment: A test sponsor 可 disclose additional detail on the 可用性 of the 系统’s components in
              the 注 节 of the Executive Summary and 可 add a footnote reference to the System Availability
              Date.
10.3.8.3      Additional Clause 7 related items 可 be included in the full disclosure report for each country specific priced
              配置.

10.3.9        Clause 11 - Audit Related Items
10.3.9.1      The auditor's agency name, address, phone number, and attestation letter with a brief 审计 summary report
              indicating 合规 必须 included in the full disclosure report. A statement 应 be included specifying
              whom to contact in 订单 to obtain further information regarding the 审计 process.

10.4       Executive Summary

              The executive summary is meant to be a high level overview of a TPC-DS 实现. It 应
              provide the salient characteristics of a 基准测试 执行 (metrics, 配置, 定价, etc.) without
              the exhaustive detail found in the FDR. When the TPC-Energy optional reporting is selected by the test
              sponsor, the additional 要求 and format of TPC-Energy related items in the executive summary are
              included in the TPC Energy Specification, located at www.tpc.org.

              The executive summary has three components:

              Implementation and Cost of Ownership Overview

              Pricing Spreadsheet

              Numerical Quantities

10.4.1        Page Layout

              Each 组件 of the executive summary 应 appear on a page by itself. Each page 应 use a
              standard header and format, including

               a) 1/2 inch margins, top and bottom;
               b) 3/4 inch left margin, 1/2 inch right margin;
               c) 2 pt. frame around the body of the page. All interior lines 应 be 1 pt;
               d) Sponsor identification and System identification, each set apart by a 1 pt. 规则, in 16-20 pt. Times Bold
                  font.
               e) TPC-DS, TPC-Pricing, TPC-Energy (if reported), with three tier versioning (e.g., 1.2.3), and report
                  日期, separated from other header items and each other by a 1 pt. Rule, in 9-12 pt. Times font.
              Comment: It is permissible to use or include company logos when identifying the sponsor.
              Comment: The report 日期 必须 disclosed with a precision of 1 day. The precise format is left to the
              test sponsor.
              Comment: Appendix E contains a sample executive summary. It is meant to help clarify the 要求
              in Clause 10.4 and is provided solely as an 示例.

10.4.2        Implementation Overview
                  Implementation and Cost of Ownership Overview

                  The 实现 overview page contains six sets of data, each laid out across the page as a sequence of
                  boxes using 1 pt. 规则, with a title above the required 数量. Both titles and quantities 应 use a 9-12
                  pt. Times font unless otherwise noted.

                  The middle portion of the page must contain two diagrams, which 必须 of equal size and fill out the
                  entire space. The left diagram shows the benchmarked 配置 and the right diagram shows a pie
                  chart with the percentages of the total time and the total times for the Load Test, Throughput Test 1, and
                  Throughput Test 2.

                  The next 节 must contain a synopsis of the SUT's major 系统 components, including:

                  • Total number of nodes used/total number of processors used with their types and speeds in
                    GHz/ total number of cores used/total number of threads used;
                  • Main and cache memory sizes;
                  • Network and I/O connectivity;
                  • Disk 数量 and geometry.

                  If the 实现 used a two-tier architecture, front-end and back-end 系统 必须 detailed
                  separately.
10.4.2.1          The first 节 contains the results that were obtained from the reported runs of the Performance test.
  Title                               Quantity                                   Precisio   Units             Font
                                                                                 n
  Total System Cost                   3 yr. Cost of ownership (See Clause 7)     1          $1                16-20 pt. Bold
  TPC-DS Composite Query per          QphDS (see Clause 7.6                      0.1        QphDS@nnGB        16-20 pt. Bold
  Hour Metric
  Price/Performance                   $/kQphDS (see Clause 7.6.4)                1          $/kQphDS@nnG      16-20 pt. Bold
                                                                                            B

                  The next 节 details the 系统 配置



  Title                               Quantity                                 Precision        Units    Font
  Data Set Size                       Raw data size of test 数据库           1                GB       9-12 pt. Times

  Data Processing System              Brand, Software Version of Data                                    9-12 pt. Times
                                      Processing System used
  Operating System                    Brand, Software Version of OS used                                 9-12 pt. Times
  Other Software                      Brand, Software Version of other                                   9-12 pt. Times
                                      软件 components
  System Availability Date            System Availability Date                 1 day                     9-12 pt. Times
  Clustered Or Not                    Yes/No                                                             9-12 pt. Times

                  Comment: The Software Version must uniquely identify the orderable 软件 product referenced in the
                  Priced Configuration (e.g., RALF/2000 4.2.1)
10.4.2.2          The middle portion of the page must contain two diagrams, which 必须 of equal size and fill out the width of
                  the entire space. The left diagram shows the benchmarked 配置 and the right diagram shows a pie
                  chart with the percentages of the total time and the total times for the Load Test, Throughput Test 1 and
                  Throughput Test 2.



10.4.2.3          This 节 contains the 数据库 load and RAID information
 Title                           Quantity                               Precision   Units                     Font


 Load includes backup            Yes/No                                 N/A         N/A                       9-12 pt. Times


 RAID                            None / Base 表 only /              N/A         N/A                       9-12 pt. Times
                                 Explicit Auxiliary Data Structures /
                                 Everything




10.4.2.4         The next 节 of the Implementation Overview 应 contain a synopsis of the SUT’s major components,
              including:

              Node and/or processor count and speed in GHz;

              Main and cache memory sizes;

              Network and IO connectivity;

              Disk 数量 and geometry

              Total mass storage in the priced 系统.


                   If the 实现 used a two-tier architecture, front-end and back-end 系统 应 be defined
              separately.
10.4.2.5       The final 节 of the Implementation Overview 应 contain a 注 stating:
              “Database Size includes only raw data (i.e., no temp, 索引, redundant storage space, etc.).”

10.4.3         Pricing Spreadsheet

              The 定价 spreadsheet, required by Clause 10.4, 必须 reproduced in its entirety. Refer to Appendix E
              for a sample 定价 spreadsheet.

10.4.4         Numerical Quantities Summary

              The Numerical Quantities Summary page contains three sets of data.

               1. The first set is the number of 查询 streams.
               2. The second set contains the Start Date, Start Time, End Date, End Time, and Elapsed Time for:
                  • Database Load
                   • Power Test
                   • Throughput Test 1
                   • Data Maintenance Test 1
                   • Throughput Test 2
                  • Data Maintenance Test 2.
               3. The third set is a 表 which contains the information required by Clause 10.3.6.4 .
10.4.5      ES.xml Requirements

            The 模式 of the ES.xml document is defined by the XML 模式 document tpcds-es.xsd located on the
            TPC website (http://www.tpc.org). The ES.xml file must conform to the tpcds-es.xsd (established by XML
            模式 validation).

            Comment: The Sponsor is responsible for verifying that the ES.xml file they provide in the Full
            Disclosure Report conforms to the TPC-DS XML 模式. A validation tool will be provided on the TPC
            web site to facilitate this verification.

            Appendix G describes the structure of the XML 模式, defines the individual 字段, and explains how to
            use the 模式.

10.5     Availability of the Full Disclosure Report

10.5.1      The full disclosure report 必须 readily available to the public at a reasonable charge, similar to charges
            for comparable documents by that test sponsor. The report 必须 made available when results are made
            public. In 订单 to use the phrase "TPC Benchmark DS", the full disclosure report must have been
            submitted electronically to the TPC using the procedure described in the TPC Policies document.

10.5.2      The official full disclosure report 必须 available in English but 可 be translated to additional
            languages.

10.6     Revisions to the Full Disclosure Report

            Revisions to the full disclosure documentation 应 be handled as follows:

             a) Fully documented 价格 changes can be reflected in a new published 性价比. The
                基准测试 need not be rerun to remain compliant.
             b) Hardware or 软件 product substitutions within the SUT, with the exception of equipment
                emulated as allowed under Clause 8, require the 基准测试 to be re-run with the new components in
                订单 to re-establish 合规. For any substitution of equipment emulated during the 基准测试, a
                new demonstration 必须 provided.
             c) The revised report 应 be submitted as defined in Clause10.2.1.
            Comment: During the normal product life cycle, problems will be uncovered that require changes,
            sometimes referred to as patches or updates. When the cumulative 结果 of applied changes causes the
            性能 指标 (see Clause 7.6.3) to decrease by more than 2% from the reported 值, then the test
            sponsor is required to re-validate the 基准测试 results.
             a) Fully documented 价格 changes can be reflected in a new published 性价比.
             b) When cumulative 价格 changes have resulted in a worsening of the reported 性价比 by 2%
                or more the test sponsor must submit revised 性价比 results to the TPC within 30 days of
                the effective 日期 of the 价格 change(s) to remain in 合规. The 基准测试 need not be re-run
                to remain in 合规.
            Comment: The intent of this Clause is that published 性价比 reflect actual current
            性价比.
             a) A change in the committed 可用性 日期 for the priced 系统 can be reflected in a new published
                可用性 日期.
             b) A report 可 be revised to add or delete Clause 9 related items for country-specific priced
                configurations.
             c) Full disclosure report revisions 可 be required for other reasons as specified in the TPC Policies and
                Guidelines document, and 必须 submitted using the mechanisms described therein.

10.7     Derived Results

10.7.1      TPC-DS results can be used as the basis for new TPC-DS results if and only if:

             a) The auditor ensures that the 硬件 and 软件 products are the same as those used in the prior
                结果;
             b) The auditor reviews the FDR of the new results and ensures that they match what is contained in the
                original sponsor's FDR;
             c) The auditor can attest to the validity of the 定价 used in the new FDR.
             d) The intent of this 子句 is to allow a reseller of equipment from a given 供应商 to publish under the
                re-seller's name a TPC-DS 结果 already published by the 供应商.
10.8 Supporting Files Index Table

        An 索引 for all files required by Clause 10.2.4 Supporting Files 必须 provided in the Report. The
        Supporting Files 索引 is presented in a tabular format where the 列 specify the following:
        •   The first 列 denotes the 子句 in the TPC Specification
        •   The second 列 provides a short 说明 of the file contents
        •   The third 列 contains the path name for the file starting at the SupportingFiles directory.
        If there are no Supporting Files provided then the 说明 列 must indicate that there is no supporting
        file and the path name 列 必须 left blank.
        The following 表 is an 示例 of the Supporting Files Index Table that 必须 reported in the Report.
            Clause                Description           Pathname

                                  Database Tunable
                                                   SupportingFiles/Introduction/DBtune.txt
                                  Parameters
            Introduction
                                  OS Tunable
                                                        SupportingFiles/Introduction/OStune.txt
                                  Parameters

                                  Table creation
                                                        SupportingFiles/Clause2/createTables.sh
                                  scripts
            Clause 2
                                  Index creation
                                                        SupportingFiles/Clause2/createIndex.sh
                                  scripts

                                  Load 事务
            Clause 3                                    SupportingFiles/Clause3/doLoad.sh
                                  scripts

            Clause 4

                                  Data
            Clause 5              维护           SupportingFiles/Clause5/doRefresh.sh
                                  scripts

                                  Data
            Clause 6              Accessibility         SupportingFiles/Clause6/runACID.sh
                                  Scripts

                                  Output of data
                                                        SupportingFiles/Clause6/ACID.out
                                  accessibility tests

            Clause 7

            Clause 8

            Clause 9
  10.9 Supporting Files

         The Supporting Files contain human readable and machine executable (i.e., able to be performed by the
         appropriate program without modification) scripts, executables and source code that are required to recreate
         the 基准测试 Result. If there is a choice of using a GUI or a script, then the machine executable script must
         be provided in the Supporting Files. If no corresponding script is available for a GUI, then the Supporting Files
         must contain a detailed step by step 说明 of how to manipulate the GUI.
         The combination of the following 规则 应 allow anybody to reproduce the 基准测试 结果.
            • All 软件 developed specifically for the 基准测试 必须 included in the supporting files if
              the 软件 was used to cover the 要求 of a 子句 of the 基准测试 规范 or to
              conduct a 基准测试 run with the SUT. This includes machine executable code in the form of
              scripts (e.g., .sql, .sh, .tcsh, .cmd, or .bat files) or source code (e.g., .cpp, .cc, .cxx, .c files).
              Specifically developed executables (e.g., .exe files) need to be included unless their source code
              has been provided in the supporting files with detailed instructions (e.g., make files) how to re-
              generate the executables from the source for the 硬件 and operating 系统 used for the
              基准测试.
            • References (e.g., URLs) need to be provided for all 软件 available for general purchase or
              download which has NOT been developed specifically for the 基准测试. The 软件 必须
              available under the location provided by the references for the time the 基准测试 is published
              on the TPC website.
            • All command line options used to invoke any of the above programs need to be disclosed. If a
              GUI is used, detailed instructions on how to navigate the GUI as used to reproduce the
              基准测试 结果 need to be disclosed.
         The directory structure under SupportingFiles must follow the 子句 numbering from the TPC-DS Standard
         Specification (i.e., this document). The directory name is specified by the 10.9 third level Clauses immediately
         preceding the fourth level Supporting Files reporting 要求. If there is more than one instance of one
         type of file, subfolders 可 be used for each instance. For 示例 if multiple Tier A machines were used in
         the 基准测试, there 可 be a folder for each Tier A machine.
         File names 应 be chosen to indicate to the casual reader what is contained within the file. For 示例, if
         the 要求 is to provide the scripts for all 表 定义 statements and all other statements used to set-
         up the 数据库, file names of 1, 2, 3, 4 or 5 are unacceptable. File names that include the text “表”, “索引”
         or “frames” 应 be used to convey to the reader what is being created by the script.

10.9.1     SupportingFiles/Introduction Directory

           All scripts required to configure the 硬件 必须 reported in the Supporting Files.

           All scripts required to configure the 软件 必须 reported in the Supporting Files. This includes any
           Tunable Parameters and options which have been changed from the defaults in commercially available
           products, including but not limited to:

            • Database tuning options.
            • Recovery/commit options.
            • Consistency/locking options.
            • Operating System and application 配置 parameters.
            • Compilation and linkage options and run-time optimizations used to create/install applications,
              OS, and/or databases.
            • Parameters, switches or flags that can be changed to modify the behavior of the product.
           Comment: This 要求 can be satisfied by providing a full list of all parameters and options.

10.9.2     SupportingFiles/Clause2 Directory
         Scripts 必须 provided for all 表 定义 statements and all other statements used to set-up the
         数据库. All scripts 必须 human readable and machine executable (i.e., able to be performed by the
         appropriate program without modification). All scripts are to be reported in the Supporting Files.

10.9.3   SupportingFiles/Clause3 Directory

         Scripts 必须 provided for all dsdgen invocations used to populate the 数据库 with content. All scripts
         必须 human readable and machine executable (i.e., able to be performed by the appropriate program
         without modification). All scripts are to be reported in the Supporting Files.

10.9.4   SupportingFiles/Clause4 Directory

         The 实现 of each 查询 of the 基准测试 as defined per Clause 4 必须 reported in the
         Supporting Files. This includes, but is not limited to, the code implementing the queries of this
         基准测试.

10.9.5   SupportingFiles/Clause5 Directory

         Scripts 必须 provided for all steps used to maintain the 数据库 content in 订单 to 实现 Clause 5.
         All scripts 必须 human readable and machine executable (i.e., able to be performed by the appropriate
         program without modification). All scripts are to be reported in the Supporting Files.

10.9.6   SupportingFiles/Clause6 Directory

         Scripts 必须 provided for all steps used to validate Clause 6. All scripts 必须 human readable and
         machine executable (i.e., able to be performed by the appropriate program without modification). All
         scripts and the 输出 of the scripts are to be reported in the Supporting Files.

10.9.7   SupportingFiles/Clause7 Directory

         No 要求

10.9.8   SupportingFiles/Clause8 Directory

         No 要求

10.9.9   SupportingFiles/Clause9 Directory

         No 要求
                                           11 AUDIT

              This 子句 defines the 审计 要求 for TPC-DS. The auditor needs to ensure that the 基准测试
              under 审计 complies with the TPC-DS 规范. Rules for auditing Pricing information are included in
              the current revision of the TPC Pricing Specification located at www.tpc.org. When the TPC-Energy
              optional reporting is selected by the test sponsor, the 规则 for auditing of TPC-Energy related items are
              included in the TPC Energy Specification located at www.tpc.org.

11.1       General Rules

11.1.1        An independent 审计 of the 基准测试 results by a TPC certified auditor is required. The term
              independent is defined as "the outcome of the 基准测试 carries no financial benefit to the auditing
              agency other than fees earned directly related to the 审计." In addition, the auditing agency cannot have
              supplied any 性能 consulting under contract for the 基准测试.

              In addition, the following conditions 必须 met:

              a)   The auditing agency cannot be financially related to the sponsor. For 示例, the auditing agency is
                   financially related if it is a dependent division of the sponsor, the majority of its stock is owned by the
                   sponsor, etc.

              b) The auditing agency cannot be financially related to any one of the suppliers of the measured/priced
                 配置, e.g., the data processing 系统 供应商, the disk 供应商, etc.

11.1.2        The auditor's attestation letter is to be made readily available to the public as 零件 of the full disclosure
              report. A detailed report from the auditor is not required.

11.1.3        TPC-DS results can be used as the basis for new TPC-DS results if and only if:

              The auditor ensures that the 硬件 and 软件 products are the same as those used in the prior 结果;

              The auditor reviews the FDR of the new results and ensures that they match what is contained in the
              original sponsor's FDR;

              The auditor can attest to the validity of the 定价 used in the new FDR.

              Comment: The intent of this 子句 is to allow a reseller of equipment from a given 供应商 to publish
              under the re-seller's name a TPC-DS 结果 already published by the 供应商.
              Comment: In the event that all conditions listed in Clause 11.1.2 are met, the auditor is not required to
              follow the remaining auditor's check list items from Clause 11.2.

11.1.4        In the event that a remote 审计 procedure is used in the context of a change-based 审计, a remote
              connection to the SUT 必须 available for the auditor to verify selected 审计 items from Clause 9.2

11.2       Auditor's Check List

11.2.1        This 子句 defines the minimal 审计 checks that the auditor is required to conduct for TPC-DS. In 订单
              for the auditor to ensure that the 基准测试 under 审计 complies with the TPC-DS 规范 the
              auditor is allowed to ask for additional checks.

11.2.2        Clause 2 Related Items

11.2.2.1      Verify that the data types used for each 列 are conformant. For 示例, verify that decimal 列 can
              be incremented by 0.01 from -9,999,999,999.99.
11.2.2.2   Verify that the 表 have the required list of 列.
11.2.2.3   Verify that the 实现 规则 are met by the test 数据库.
11.2.2.4   Verify that the test 数据库 meets the data access transparency 要求.
11.2.2.5   Verify that conforming arbitrary data 值 can be inserted into any of the 表. Examples of verification tests
           include:
            • Inserting a 行 that is a complete duplicate of an existing 行 except for a distinct 主键;
            • Inserting a 行 with 列 值 within the domain of the data type and check constraints but
               beyond the range of existing 值.
11.2.2.6   Ensure that all EADS satisfy the 要求 of Clause 2.5.3
11.2.2.7   Verify that the set of EADS that are present and enabled at the end of the load test are the same set that are
           present and enabled at the end of the 性能 test as required by Clause 2.5.3.6. A similar check 可 be
           performed at any point during the 性能 test at the discretion of the auditor. Note the method used to
           verify that this 要求 has been met.

           [This auditor 子句 states a 要求 that does not appear to be stated before (that no ADS can be created
           during the test). If such a 要求 exists it 应 be stated in 子句 2.]

11.2.3     Clause 3 Related Items
11.2.3.1   Verify that the qualification and test databases are properly scaled and populated.
11.2.3.2   Verify that the qualification and test databases were constructed in the same manner so that correct behavior on
           the qualification 数据库 is indicative of correct behavior on the test 数据库.
11.2.3.3   Note the method used to populate the 数据库 (i.e., dsdgen or modified version of dsdgen). Note the version
           number (i.e., the major revision number, the minor revision number, and third tier number) of dsdgen, and the
           names of the dsdgen files which have been modified. Verify that the major and minor revision numbers of the
           dsdgen version match those of the 基准测试 规范.
11.2.3.4   Verify that storage and processing elements that are not included in the priced 配置 are physically
           removed or made inaccessible during the 性能 test using a vendor supported method.
11.2.3.5   Verify that the validation data sets are proven consistent with the data loaded into the 数据库 according to
           子句 3.5.
11.2.3.6   Verify referential integrity in the 数据库 after the initial load. Referential Integrity is a data property that can
           be verified by checking that every 外键 has a corresponding 主键.
11.2.4     Clause 4 Related Items
11.2.4.1   Verify that the basis for the SQL used for each 查询 is the functional 查询 定义 or an approved variant or
           meets Clause 9.2.3.2.
11.2.4.2   Verify that any deviation in the SQL from either the functional 查询 定义 or an approved variant is
           compliant with the specified minor 查询 modifications. Verify that minor 查询 modifications have been
           applied consistently to the set of functional 查询 definitions or approved variants used.
11.2.4.3   Verify that the executable 查询 text produces the required 输出 when executed against the qualification
           数据库 using the validation 值 for substitution parameters.
11.2.4.4   Note the method used to generate the 值 for substitution parameters (i.e., dsqgen, modified version of
           dsqgen, other method). If dsqgen was used, 注 the version number (i.e., the major revision number, the minor
           revision number, and third tier number) of dsqgen. Verify that the major and minor revision numbers of the
           dsqgen version match those of the 基准测试 规范.
11.2.4.5   Verify that the generated substitution parameters are correctly generated. For each stream take 10 random
           queries and verify their substitution 值.
11.2.4.6   Verify that no aspect of the 系统 under test, except for the 数据库 size, has changed between the
           demonstration of 合规 against the qualification 数据库 and the 执行 of the reported measurements.
11.2.5     Clause 5 Related Items

11.2.5.1   Verify immediately after the 性能 test that all EADS that were created as 零件 of the 数据库 load are
           correctly maintained. This test is to be conducted with a script that performs the following two types of
           subtests:
            1. For any 索引 measure the 响应时间 for 索引 lookups of two keys, one that was loaded during the
               数据库 load test and one that was loaded during the data 维护 test. The lookup 查询
               response times 应 not be substantially different from each other (e.g. difference 应 not be
               more than 50%).
           2. Create another instance for all non–索引 EADS using the same directives as used for the original
              EADS. Verify that the creation of the second instance does not 查询 the original EADS. Verify that
              their content is logically identical.
11.2.5.2   Verify that the logic of the data 维护 functions are implemented according to their 定义 (see
           Clause 5.3).
11.2.5.3   Verify that the data 维护 functions insert and delete the correct 行. For each data 维护
           function in a random stream verify that 2 random 行 have been correctly inserted and deleted.
11.2.5.4   Verify that the 订单 of the data 维护 functions is in accordance with Clause 5.1.3.
11.2.5.5   Verify that the method used to 实现 and execute 数据库 维护 operations is in accordance with
           Clause 5.1.5.

11.2.6     Verify that the 刷新 data loaded as 零件 of each data 维护 function is in accordance with Clause
           5.2.4
11.2.7     Clause 6 Related Items

11.2.7.1   Verify that the required data accessibility properties are supported by the 系统 under test as configured for the
           执行 of the reported measurements.
11.2.8     Clause 7 Related Items

11.2.8.1   Verify that the 执行 规则 are followed for the Load Test, Power Test, Throughput Tests 1 and 2, and Data
           Maintenance Tests 1 and 2.
11.2.8.2   Verify that the 数据库 load time is measured according to the 要求.
11.2.8.3   Verify that the queries are executed against the test 数据库.
11.2.8.4   Verify that the 查询 sequencing 规则 are followed.
11.2.8.5   Verify that the measurement interval for the Throughput Tests is measured as required.
11.2.8.6   Verify that the method used to measure the timing intervals is compliant.
11.2.8.7   Verify that the metrics are computed as required.
11.2.8.8   Verify that any profile-directed 优化 performed by the test sponsor conforms to the 要求 of
           Clause 7.2.
11.2.8.9   Verify the set of EADS that exist at the end of the load test exist and are valid and up to 日期 at the end of the
           性能 test by querying the meta data of the test 数据库 before the Power Test and after Throughput Test
           2. If there is any doubt that the EADS are not maintained the auditor 应 run additional tests.
11.2.9     Clause 8 Related Items

11.2.9.1   Verify that the driver meets the 要求 of Clauses 8.3.
11.2.10    Clause 9 Related Items
11.2.10.1   Verify that the composition of the SUT is in 合规 with the Clause 9 and that its components will be
            commercially available products according to the current version of TPC 定价 规范.
11.2.10.2   Note whether an 实现 specific layer is used and verify its 合规 with Clause 9.1.
11.2.10.3   Verify that all required components of the SUT are priced according to the current version of TPC 定价
            规范.
11.2.10.4   Verify that a user communication interface is included in the SUT.
11.2.10.5   Verify that all required 维护 is priced according to the current version of TPC 定价 规范.
11.2.10.6   Verify that any 折扣 used is generally available and complies according to the current version of TPC
            定价 规范.
11.2.10.7   Verify that any third-party 定价 complies with the 要求 of TPC 定价 规范.

11.2.11     Verify that the 定价 spreadsheet includes all 硬件 and 软件 licenses, warranty coverage, and
            additional 维护 costs as required according to the current version of TPC 定价 规范.

            Comment: Since final 定价 for new products is typically set very close to the product announcement
            日期, the auditor is not required to verify the final 定价 of the tested 系统.

11.2.12     Clause 10 Related Items

11.2.12.1   Verify that major portions of the full disclosure report are accurate and comply with the reporting 要求.
            This includes:
             • The executive summary;
             • The numerical 数量 summary;
             • The diagrams of both measured and priced configurations;
             • The block diagram illustrating the 数据库 load process.
                                               Appendix A: Logical Representation of the Refresh Data Set

 A.1      Refresh Data Set DDL

         The following DDL statements define a detailed structure of the flat files, generated by dsdgen, that
         constitute the 刷新 data set. The datatypes correspond to those in Clause 2.2.



                                  Table A-1: Column 定义 s_purchase_行项
       Column                     Datatype              Primary Key                     NULLs          Foreign Key
       plin_purchase_id           identifier            Y                               N              purc_purchase_id
       plin_line_number           integer               Y                               N
       plin_item_id               char(16)                                                             i_item_id
       plin_promotion_id          char(16)                                                             p_promo_id
       plin_数量              integer
       plin_sale_价格            numeric(7,2)
       plin_coupon_amt            numeric(7,2)
       plin_comment               char(100



                                        Table A-2: Column 定义 s_purchase
       Column                     Datatype                       Primary Key        NULLs       Foreign Key
12     purc_purchase_id      13   identifier           14        Y         15       N  16
17     purc_store_id         18   char(16)                                                      s_store_id
       purc_客户_id           char(16)                                                      c_客户_id
       purc_purchase_日期         char(10)                                                      d_日期
       purc_purchase_time         integer                                                       t_time
       purc_register_id           integer
       purc_clerk_id              integer
       purc_comment               char(100)

                                     Table A-3: Column 定义 s_catalog_订单
     Column                           Datatype               Primary Key        NULLs       Foreign Key
     cord_订单_id                    identifier             Y                  N
     cord_bill_客户_id            char(16)                                              c_客户_id
     cord_ship_客户_id            char(16)                                              c_客户_id
     cord_订单_日期                  char(10)                                              d_日期
     cord_订单_time                  integer                                               t_time
     cord_ship_mode_id                char(16)                                              sm_ship_mode_id
     cord_call_center_id              char(16)                                              cc_call_center_id
     cord_订单_comments              varchar(100)

                                       Table A-4: Column 定义 s_web_订单
       Column                            Datatype           Primary Key         NULLs                Foreign Key
       word_订单_id                     identifier         Y                   N
       word_bill_客户_id             char(16)                                                    c_客户_id
       word_ship_客户_id             char(16)                                                    c_客户_id
       word_订单_日期                   char(10)                                                    d_日期
       word_订单_time                   integer                                                     t_time
       word_ship_mode_id                 char(16)                                                    sm_ship_mode_id
       word_web_site_id                  char(16)                                                    web_site_id
       word_订单_comments               char(100)
                                Table A-5: Column 定义 s_catalog_订单_行项
Column                                         Datatype                         Primary Key    NULLs          Foreign Key
clin_订单_id                                  identifier                       Y              N              cord_订单_id
clin_line_number                               integer                          Y              N
clin_item_id                                   char(16)                                                       i_item_id
clin_promotion_id                              char(16)                                                       p_promo_id
clin_数量                                  integer
clin_sales_价格                               numeric(7,2)
clin_coupon_amt                                numeric(7,2)
clin_仓库_id                              char(16)                                                       w_仓库_id
clin_ship_日期                                 char(10)
clin_catalog_number                            integer
clin_catalog_page_number                       integer
clin_ship_成本                                 numeric(7,2)

                                 Figure A-6: Column 定义 s_web_订单_行项
Column                                         Datatype                         Primary Key    NULLs          Foreign Key
wlin_订单_id                                  identifier                       Y              N              word_订单_id
wlin_line_number                               integer                          Y              N
wlin_item_id                                   char(16)                                                       i_item_id
wlin_promotion_id                              char(16)                                                       p_promo_id
wlin_数量                                  integer
wlin_sales_价格                               numeric(7,2)
wlin_coupon_amt                                numeric(7,2)
wlin_仓库_id                              char(16)                                                       w_仓库_id
wlin_ship_日期                                 char(10)                                                       d_日期
wlin_ship_成本                                 numeric(7,2)
wlin_web_page_id                               char(16)                                                       wp_web_page

                                        Table A-7: Column 定义 s_store_returns
                Column                         Datatype           Primary Key       NULLs     Foreign Key
                sret_store_id                  char(16)                                       s_store_id
                sret_purchase_id               char(16)           Y                 N
                sret_line_number               integer            Y                 N
                sret_item_id                   char(16)           Y                 N
                sret_客户_id               char(16)                                       c_客户_id
                sret_return_日期               char(10)                                       d_日期
                sret_return_time               char(10)                                       t_time
                sret_ticket_number             char(20)
                sret_return_qty                integer
                sret_return_amount             numeric(7,2)
                sret_return_税                numeric(7,2)
                sret_return_fee                numeric(7,2)
                sret_return_ship_成本          numeric(7,2)
                sret_refunded_cash             numeric(7,2)
                sret_reversed_charge           numeric(7,2)
                sret_store_credit              numeric(7,2)
                sret_reason_id                 char(16)                                       r_reason_id

                                    Table A-8: Column 定义 s_catalog_returns
             Column                         Datatype          Primary Key       NULLs   Foreign Key
             cret_call_center_id            char(16)                                    cc_call_center_id
             cret_订单_id                  integer           Y                 N
             cret_line_number               integer           Y                 N
             cret_item_id                   char(16)          Y                 N       i_item_id
             cret_return_客户_id        char(16)                                    c_客户_id
             cret_refund_客户_id        char(16)                                    c_客户_id
          Column                          Datatype            Primary Key          NULLs    Foreign Key
          cret_return_日期                char(10)                                          d_日期
          cret_return_time                char(10)                                          t_time
          cret_return_qty                 integer
          cret_return_amt                 numeric(7,2)
          cret_return_税                 numeric(7,2)
          cret_return_fee                 numeric(7,2)
          cret_return_ship_成本           numeric(7,2)
          cret_refunded_cash              numeric(7,2)
          cret_reversed_charge            numeric(7,2)
          cret_merchant_credit            numeric(7,2)
          cret_reason_id                  char(16)                                          r_reason_id
          cret_shipmode_id                char(16)
          cret_catalog_page_id            char(16)
          cret_仓库_id               char(16)

                                     Table A-9: Column 定义 s_web_returns
              Column                               Datatype           Primary Key      NULLs      Foreign Key
              wret_web_page_id                     char(16)                                       wp_web_page_id
              wret_订单_id                        integer            Y                N
              wret_line_number                     integer            Y                N
              wret_item_id                         char(16)           Y                N          i_item_id
              wret_return_客户_id              char(16)                                       c_客户_id
              wret_refund_客户_id              char(16)                                       c_客户_id
              wret_return_日期                     char(10)                                       d_日期
              wret_return_time                     char(10)                                       t_time
              wret_return_qty                      integer
              wret_return_amt                      numeric(7,2)
              wret_return_税                      numeric(7,2)
              wret_return_fee                      numeric(7,2)
              wret_return_ship_成本                numeric(7,2)
              wret_refunded_cash                   numeric(7,2)
              wret_reversed_charge                 numeric(7,2)
              wret_account_credit                  numeric(7,2)
              wret_reason_id                       char(16)                                       r_reason_id

                                      Table A-10: Column 定义 s_inventory
          Column                           Datatype               Primary Key         NULLs          Foreign Key
          invn_仓库_id                char(16),              Y                   N              w_仓库_id
          invn_item_id                     char(16),              Y                   N              i_item_id
          invn_日期                        char(10)               Y                   N              d_日期
          invn_qty_on_hand                 integer


A.1    Relationships between source 模式 表

      The following relationships are defined between source 模式 表:

                                              Table A-11: Column 定义
        Source Schema Table       Source Schema Table 2                   Join Condition
        1
        s_purchase                s_purchase_行项                     purc_purchase_id = plin_purchase_id
        s_web_订单               s_web_订单_行项                    word_订单_id = wlin_订单_id
        s_catalog_订单           s_catalog_订单_行项                cord_订单_id = clin_订单_id
                                      Appendix B: Business Questions
      Comment: The leading zeros in the numerical suffix used when parameters hold multiple 值 match the
      输出 of dsqgen. The leading zeros do not appear in the 查询 templates.

B.1   查询1.tpl

      Find customers who have returned items more than 20% more often than the average 客户 returns for
      a store in a given state for a given year.

      Qualification Substitution Parameters:

      • YEAR.01=2000
      • STATE.01=TN
      • AGG_FIELD.01 = SR_RETURN_AMT

B.2   查询2.tpl

      Report the ratios of weekly web and catalog sales increases from one year to the next year for each week.
      That is, compute the increase of Monday, Tuesday, ... Sunday sales from one year to the following.

      Qualification Substitution Parameters:

      • YEAR.01=2001

B.3   查询3.tpl

      Report the total extended sales 价格 per item brand of a specific manufacturer for all sales in a specific
      month of the year.

      Qualification Substitution Parameters:

      • MONTH.01=11
      • MANUFACT =128
      • AGGC = ss_ext_sales_价格

B.4   查询4.tpl

      Find customers who spend more money via catalog than in stores. Identify preferred customers and their
      country of origin.

      Qualification Substitution Parameters:

      • YEAR.01=2001
      • SELECTONE.01= t_s_secyear.客户_preferred_cust_flag

B.5   查询5.tpl

      Report sales, profit, return amount, and net loss in the store, catalog, and web channels for a 14-day
      window. Rollup results by sales channel and channel specific sales method (store for store sales, catalog
      page for catalog sales and web site for web sales)

      Qualification Substitution Parameters:

      • SALES_DATE.01=2000-08-23
      • YEAR.01=2000
B.6   查询6.tpl

      List all the states with at least 10 customers who during a given month bought items with the 价格 tag at
      least 20% higher than the average 价格 of items in the same category.

      Qualification Substitution Parameters:

      • MONTH.01=1
      • YEAR.01=2001

B.7   查询7.tpl

      Compute the average 数量, list 价格, 折扣, and sales 价格 for promotional items sold in stores
      where the promotion is not offered by mail or a special event. Restrict the results to a specific gender,
      marital and educational status.

      Qualification Substitution Parameters:

      •   YEAR.01=2000
      •   ES.01=College
      •   MS.01=S
      •   GEN.01=M

B.8   查询8.tpl

      Compute the net profit of stores located in 400 Metropolitan areas with more than 10 preferred customers.

      Qualification Substitution Parameters:

      •   ZIP.01=24128      ZIP.81=57834       ZIP.161=13354   ZIP.241=15734     ZIP.321=78668
      •   ZIP.02=76232      ZIP.82=62878       ZIP.162=45375   ZIP.242=63435     ZIP.322=22245
      •   ZIP.03=65084      ZIP.83=49130       ZIP.163=40558   ZIP.243=25733     ZIP.323=15798
      •   ZIP.04=87816      ZIP.84=81096       ZIP.164=56458   ZIP.244=35474     ZIP.324=27156
      •   ZIP.05=83926      ZIP.85=18840       ZIP.165=28286   ZIP.245=24676     ZIP.325=37930
      •   ZIP.06=77556      ZIP.86=27700       ZIP.166=45266   ZIP.246=94627     ZIP.326=62971
      •   ZIP.07=20548      ZIP.87=23470       ZIP.167=47305   ZIP.247=53535     ZIP.327=21337
      •   ZIP.08=26231      ZIP.88=50412       ZIP.168=69399   ZIP.248=17879     ZIP.328=51622
      •   ZIP.09=43848      ZIP.89=21195       ZIP.169=83921   ZIP.249=15559     ZIP.329=67853
      •   ZIP.10=15126      ZIP.90=16021       ZIP.170=26233   ZIP.250=53268     ZIP.330=10567
      •   ZIP.11=91137      ZIP.91=76107       ZIP.171=11101   ZIP.251=59166     ZIP.331=38415
      •   ZIP.12=61265      ZIP.92=71954       ZIP.172=15371   ZIP.252=11928     ZIP.332=15455
      •   ZIP.13=98294      ZIP.93=68309       ZIP.173=69913   ZIP.253=59402     ZIP.333=58263
      •   ZIP.14=25782      ZIP.94=18119       ZIP.174=35942   ZIP.254=33282     ZIP.334=42029
      •   ZIP.15=17920      ZIP.95=98359       ZIP.175=15882   ZIP.255=45721     ZIP.335=60279
      •   ZIP.16=18426      ZIP.96=64544       ZIP.176=25631   ZIP.256=43933     ZIP.336=37125
      •   ZIP.17=98235      ZIP.97=10336       ZIP.177=24610   ZIP.257=68101     ZIP.337=56240
      •   ZIP.18=40081      ZIP.98=86379       ZIP.178=44165   ZIP.258=33515     ZIP.338=88190
      •   ZIP.19=84093      ZIP.99=27068       ZIP.179=99076   ZIP.259=36634     ZIP.339=50308
      •   ZIP.20=28577      ZIP.100=39736      ZIP.180=33786   ZIP.260=71286     ZIP.340=26859
      •   ZIP.21=55565      ZIP.101=98569      ZIP.181=70738   ZIP.261=19736     ZIP.341=64457
      •   ZIP.22=17183      ZIP.102=28915      ZIP.182=26653   ZIP.262=58058     ZIP.342=89091
      •   ZIP.23=54601      ZIP.103=24206      ZIP.183=14328   ZIP.263=55253     ZIP.343=82136
      •   ZIP.24=67897      ZIP.104=56529      ZIP.184=72305   ZIP.264=67473     ZIP.344=62377
      •   ZIP.25=22752      ZIP.105=57647      ZIP.185=62496   ZIP.265=41918     ZIP.345=36233
•   ZIP.26=86284   ZIP.106=54917   ZIP.186=22152   ZIP.266=19515   ZIP.346=63837
•   ZIP.27=18376   ZIP.107=42961   ZIP.187=10144   ZIP.267=36495   ZIP.347=58078
•   ZIP.28=38607   ZIP.108=91110   ZIP.188=64147   ZIP.268=19430   ZIP.348=17043
•   ZIP.29=45200   ZIP.109=63981   ZIP.189=48425   ZIP.269=22351   ZIP.349=30010
•   ZIP.30=21756   ZIP.110=14922   ZIP.190=14663   ZIP.270=77191   ZIP.350=60099
•   ZIP.31=29741   ZIP.111=36420   ZIP.191=21076   ZIP.271=91393   ZIP.351=28810
•   ZIP.32=96765   ZIP.112=23006   ZIP.192=18799   ZIP.272=49156   ZIP.352=98025
•   ZIP.33=23932   ZIP.113=67467   ZIP.193=30450   ZIP.273=50298   ZIP.353=29178
•   ZIP.34=89360   ZIP.114=32754   ZIP.194=63089   ZIP.274=87501   ZIP.354=87343
•   ZIP.35=29839   ZIP.115=30903   ZIP.195=81019   ZIP.275=18652   ZIP.355=73273
•   ZIP.36=25989   ZIP.116=20260   ZIP.196=68893   ZIP.276=53179   ZIP.356=30469
•   ZIP.37=28898   ZIP.117=31671   ZIP.197=24996   ZIP.277=18767   ZIP.357=64034
•   ZIP.38=91068   ZIP.118=51798   ZIP.198=51200   ZIP.278=63193   ZIP.358=39516
•   ZIP.39=72550   ZIP.119=72325   ZIP.199=51211   ZIP.279=23968   ZIP.359=86057
•   ZIP.40=10390   ZIP.120=85816   ZIP.200=45692   ZIP.280=65164   ZIP.360=21309
•   ZIP.41=18845   ZIP.121=68621   ZIP.201=92712   ZIP.281=68880   ZIP.361=90257
•   ZIP.42=47770   ZIP.122=13955   ZIP.202=70466   ZIP.282=21286   ZIP.362=67875
•   ZIP.43=82636   ZIP.123=36446   ZIP.203=79994   ZIP.283=72823   ZIP.363=40162
•   ZIP.44=41367   ZIP.124=41766   ZIP.204=22437   ZIP.284=58470   ZIP.364=11356
•   ZIP.45=76638   ZIP.125=68806   ZIP.205=25280   ZIP.285=67301   ZIP.365=73650
•   ZIP.46=86198   ZIP.126=16725   ZIP.206=38935   ZIP.286=13394   ZIP.366=61810
•   ZIP.47=81312   ZIP.127=15146   ZIP.207=71791   ZIP.287=31016   ZIP.367=72013
•   ZIP.48=37126   ZIP.128=22744   ZIP.208=73134   ZIP.288=70372   ZIP.368=30431
•   ZIP.49=39192   ZIP.129=35850   ZIP.209=56571   ZIP.289=67030   ZIP.369=22461
•   ZIP.50=88424   ZIP.130=88086   ZIP.210=14060   ZIP.290=40604   ZIP.370=19512
•   ZIP.51=72175   ZIP.131=51649   ZIP.211=19505   ZIP.291=24317   ZIP.371=13375
•   ZIP.52=81426   ZIP.132=18270   ZIP.212=72425   ZIP.292=45748   ZIP.372=55307
•   ZIP.53=53672   ZIP.133=52867   ZIP.213=56575   ZIP.293=39127   ZIP.373=30625
•   ZIP.54=10445   ZIP.134=39972   ZIP.214=74351   ZIP.294=26065   ZIP.374=83849
•   ZIP.55=42666   ZIP.135=96976   ZIP.215=68786   ZIP.295=77721   ZIP.375=68908
•   ZIP.56=66864   ZIP.136=63792   ZIP.216=51650   ZIP.296=31029   ZIP.376=26689
•   ZIP.57=66708   ZIP.137=11376   ZIP.217=20004   ZIP.297=31880   ZIP.377=96451
•   ZIP.58=41248   ZIP.138=94898   ZIP.218=18383   ZIP.298=60576   ZIP.378=38193
•   ZIP.59=48583   ZIP.139=13595   ZIP.219=76614   ZIP.299=24671   ZIP.379=46820
•   ZIP.60=82276   ZIP.140=10516   ZIP.220=11634   ZIP.300=45549   ZIP.380=88885
•   ZIP.61=18842   ZIP.141=90225   ZIP.221=18906   ZIP.301=13376   ZIP.381=84935
•   ZIP.62=78890   ZIP.142=58943   ZIP.222=15765   ZIP.302=50016   ZIP.382=69035
•   ZIP.63=49448   ZIP.143=39371   ZIP.223=41368   ZIP.303=33123   ZIP.383=83144
•   ZIP.64=14089   ZIP.144=94945   ZIP.224=73241   ZIP.304=19769   ZIP.384=47537
•   ZIP.65=38122   ZIP.145=28587   ZIP.225=76698   ZIP.305=22927   ZIP.385=56616
•   ZIP.66=34425   ZIP.146=96576   ZIP.226=78567   ZIP.306=97789   ZIP.386=94983
•   ZIP.67=79077   ZIP.147=57855   ZIP.227=97189   ZIP.307=46081   ZIP.387=48033
•   ZIP.68=19849   ZIP.148=28488   ZIP.228=28545   ZIP.308=72151   ZIP.388=69952
•   ZIP.69=43285   ZIP.149=26105   ZIP.229=76231   ZIP.309=15723   ZIP.389=25486
•   ZIP.70=39861   ZIP.150=83933   ZIP.230=75691   ZIP.310=46136   ZIP.390=61547
•   ZIP.71=66162   ZIP.151=25858   ZIP.231=22246   ZIP.311=51949   ZIP.391=27385
•   ZIP.72=77610   ZIP.152=34322   ZIP.232=51061   ZIP.312=68100   ZIP.392=61860
•   ZIP.73=13695   ZIP.153=44438   ZIP.233=90578   ZIP.313=96888   ZIP.393=58048
•   ZIP.74=99543   ZIP.154=73171   ZIP.234=56691   ZIP.314=64528   ZIP.394=56910
•   ZIP.75=83444   ZIP.155=30122   ZIP.235=68014   ZIP.315=14171   ZIP.395=16807
•   ZIP.76=83041   ZIP.156=34102   ZIP.236=51103   ZIP.316=79777   ZIP.396=17871
      •   ZIP.77=12305 ZIP.157=22685           ZIP.237=94167    ZIP.317=28709      ZIP.397=35258
      •   ZIP.78=57665 ZIP.158=71256           ZIP.238=57047    ZIP.318=11489      ZIP.398=31387
      •   ZIP.79=68341 ZIP.159=78451           ZIP.239=14867    ZIP.319=25103      ZIP.399=35458
      •   ZIP.80=25003 ZIP.160=54364           ZIP.240=73520    ZIP.320=32213      ZIP.400=35576
      •   QOY.01=2
      •   YEAR.01=1998

B.9   查询9.tpl

      Categorize store sales transactions into 5 buckets according to the number of items sold. Each bucket
      contains the average 折扣 amount, sales 价格, list 价格, 税, net paid, paid 价格 including 税, or net
      profit..

      Qualification Substitution Parameters:

      •   AGGCTHEN.01= ss_ext_折扣_amt
      •   AGGCELSE.01= ss_net_paid
      •   RC.01=74129
      •   RC.02=122840
      •   RC.03=56580
      •   RC.04=10097
      •   RC.05=165306

B.10 查询10.tpl

      Count the customers with the same gender, marital status, education status, purchase estimate, credit
      rating, dependent count, employed dependent count and college dependent count who live in certain
      counties and who have purchased from both stores and another sales channel during a three month time
      period of a given year.

      Qualification Substitution Parameters:

      •   YEAR.01 = 2002
      •   MONTH.01 = 1
      •   COUNTY.01 = Rush County
      •   COUNTY.02 = Toole County
      •   COUNTY.03 = Jefferson County
      •   COUNTY.04 = Dona Ana County
      •   COUNTY.05 = La Porte County

B.11 查询11.tpl

      Find customers whose increase in spending was large over the web than in stores this year compared to last
      year.

      Qualification Substitution Parameters:

      • YEAR.01 = 2001
      • SELECTONE = t_s_secyear.客户_preferred_cust_flag
B.12 查询12.tpl

     Compute the 收入 ratios across item classes: For each item in a list of given categories, during a 30 day
     time period, sold through the web channel compute the ratio of sales of that item to the sum of all of the
     sales in that item's class.

     Qualification Substitution Parameters

      •   CATEGORY.01 = Sports
      •   CATEGORY.02 = Books
      •   CATEGORY.03 = Home
      •   SDATE.01 = 1999-02-22
      •   YEAR.01 = 1999

B.13 查询13.tpl

     Calculate the average sales 数量, average sales 价格, average wholesale 成本, total wholesale 成本 for
     store sales of different 客户 types (e.g., based on marital status, education status) including their
     household demographics, sales 价格 and different combinations of state and sales profit for a given year.

     Qualification Substitution Parameters:

      •   STATE.01 = TX
      •   STATE.02 = OH
      •   STATE.03 = TX
      •   STATE.04 = OR
      •   STATE.05 = NM
      •   STATE.06 = KY
      •   STATE.07 = VA
      •   STATE.08 = TX
      •   STATE.09 = MS
      •   ES.01 = Advanced Degree
      •   ES.02 = College
      •   ES.03 = 2 yr Degree
      •   MS.01 = M
      •   MS.02 = S
      •   MS.03 = W

B.14 查询14.tpl)

     This 查询 contains multiple iterations:

     Iteration 1: First identify items in the same brand, class and category that are sold in all three sales
     channels in two consecutive years. Then compute the average sales (数量*list 价格) across all sales of all
     three sales channels in the same three years (average sales). Finally, compute the total sales and the total
     number of sales rolled up for each channel, brand, class and category. Only consider sales of cross channel
     sales that had sales larger than the average sale.

     Iteration 2: Based on the previous 查询 compare December store sales.

     Qualification Substitution Parameters:

      • DAY.01 = 11
      • YEAR.01 = 1999
B.15 查询15.tpl

     Report the total catalog sales for customers in selected geographical regions or who made large purchases
     for a given year and quarter.

     Qualification Substitution Parameters:

     • QOY.01 = 2
     • YEAR.01 = 2001

B.16 查询16.tpl

     Report number of orders, total shipping costs and profits from catalog sales of particular counties and states
     for a given 60 day period for non-returned sales filled from an alternate 仓库.

     Qualification Substitution Parameters:

     •   COUNTY_E.01 = Williamson County
     •   COUNTY_D.01 = Williamson County
     •   COUNTY_C.01 = Williamson County
     •   COUNTY_B.01 = Williamson County
     •   COUNTY_A.01 = Williamson County
     •   STATE.01 = GA
     •   MONTH.01 = 2
     •   YEAR.01 = 2002

B.17 查询17.tpl

     Analyze, for each state, all items that were sold in stores in a particular quarter and returned in the next
     three quarters and then re-purchased by the 客户 through the catalog channel in the three following
     quarters.

     Qualification Substitution Parameters:

     • YEAR.01 = 2001

B.18 查询18.tpl

     Compute, for each county, the average 数量, list 价格, coupon amount, sales 价格, net profit, age, and
     number of dependents for all items purchased through catalog sales in a given year by customers who were
     born in a given list of six months and living in a given list of seven states and who also belong to a given
     gender and education demographic.

     Qualification Substitution Parameters:

     •   MONTH.01 = 1
     •   MONTH.02 = 6
     •   MONTH.03 = 8
     •   MONTH.04 = 9
     •   MONTH.05 = 12
     •   MONTH.06 = 2
     •   STATE.01 = MS
     •   STATE.02 = IN
     •   STATE.03 = ND
     •   STATE.04 = OK
     •   STATE.05 = NM
     •   STATE.06 = VA
     •   STATE.07 = MS
     •   ES.01 = Unknown
     •   GEN.01 = F
     •   YEAR.01 = 1998

B.19 查询19.tpl

     Select the top 收入 generating products bought by out of zip code customers for a given year, month
     and manager. Qualification Substitution Parameters

     • MANAGER.01 = 8
     • MONTH.01 = 11
     • YEAR.01 = 1998

B.20 查询20.tpl

     Compute the total 收入 and the ratio of total 收入 to 收入 by item class for specified item
     categories and time periods.

     Qualification Substitution Parameters:

     •   CATEGORY.01 = Sports
     •   CATEGORY.02 = Books
     •   CATEGORY.03 = Home
     •   SDATE.01 = 1999-02-22
     •   YEAR.01 = 1999

B.21 查询21.tpl

     For all items whose 价格 was changed on a given 日期, compute the percentage change in inventory
     between the 30-day period BEFORE the 价格 change and the 30-day period AFTER the change. Group this
     information by 仓库.

     Qualification Substitution Parameters:

     • SALES_DATE.01 = 2000-03-11
     • YEAR.01 = 2000

B.22 查询22.tpl

     For each product name, brand, class, category, calculate the average 数量 on hand. Rollup data by
     product name, brand, class and category.

     Qualification Substitution Parameters:

     • DMS.01 = 1200
B.23 查询23.tpl

     This 查询 contains multiple, related iterations:

     Find frequently sold items that were sold more than 4 times on any day during four consecutive years
     through the store sales channel. Compute the maximum store sales made by any given 客户 in a period
     of four consecutive years (same as above). Compute the best store customers that are in the 5th percentile
     of sales.

     Finally, compute the total web and catalog sales in a particular month made by our best store customers
     buying our most frequent store items.

     Qualification Substitution Parameters:

     • MONTH.01 = 2
     • YEAR.01 = 2000
     • TOPPERCENT=50

B.24 查询24.tpl

     This 查询 contains multiple, related iterations:

     Iteration 1: Calculate the total specified monetary 值 of items in a specific color for store sales
     transactions by 客户 name and store, in a specific market, from customers who currently don’t live in
     their birth countries and in the neighborhood of the store, and list only those customers for whom the
     total specified monetary 值 is greater than 5% of the average 值

      Iteration 2: Calculate the total specified monetary 值 of items in a specific color for store sales
     transactions by 客户 name and store, in a specific market, from customers who currently don’t live in
     their birth countries and in the neighborhood of the store, and list only those customers for whom the total
     specified monetary 值 is greater than 5% of the average 值

     Qualification Substitution Parameters:

     •   MARKET = 8
     •   COLOR.1 = peach
     •   COLOR.2 = saddle
     •   AMOUNTONE = ss_net_paid

B.25 查询25.tpl

     Get all items that were

     • sold in stores in a particular month and year and
     • returned and re-purchased by the 客户 through the catalog channel in the same month and
       in the six following months.

     For these items, compute the sum of net profit of store sales, net loss of store loss and net profit of catalog .
     Group this information by item and store.

     Qualification Substitution Parameters:

     • YEAR.01 = 2001
     • AGG.01 = sum
B.26 查询26.tpl

     Computes the average 数量, list 价格, 折扣, sales 价格 for promotional items sold through the
     catalog channel where the promotion was not offered by mail or in an event for given gender, marital
     status and educational status.

     Qualification Substitution Parameters:

     •   YEAR.01 = 2000
     •   ES.01 = College
     •   MS.01 = S
     •   GEN.01 = M

B.27 查询27.tpl

     For all items sold in stores located in six states during a given year, find the average 数量, average list
     价格, average list sales 价格, average coupon amount for a given gender, marital status, education and
     客户 demographic.

     Qualification Substitution Parameters:

     •   STATE_F.01 = TN
     •   STATE_E.01 = TN
     •   STATE_D.01 = TN
     •   STATE_C.01 = TN
     •   STATE_B.01 = TN
     •   STATE_A.01 = TN
     •   ES.01 = College
     •   MS.01 = S
     •   GEN.01 = M
     •   YEAR.01 = 2002

B.28 查询28.tpl

     Calculate the average list 价格, number of non empty (null) list prices and number of distinct list prices of
     six different sales buckets of the store sales channel. Each bucket is defined by a range of distinct items and
     information about list 价格, coupon amount and wholesale 成本.

     Qualification Substitution Parameters:

     •   WHOLESALECOST.01=57
     •   WHOLESALECOST.02=31
     •   WHOLESALECOST.03=79
     •   WHOLESALECOST.04=38
     •   WHOLESALECOST.05=17
     •   WHOLESALECOST.06=7
     •   COUPONAMT.01=459
     •   COUPONAMT.02=2323
     •   COUPONAMT.03=12214
     •   COUPONAMT.04=6071
     •   COUPONAMT.05=836
     •   COUPONAMT.06=7326
     •   LISTPRICE.01=8
     •   LISTPRICE.02=90
     •   LISTPRICE.03=142
     •   LISTPRICE.04=135
     •   LISTPRICE.05=122
     •   LISTPRICE.06=154

B.29 查询29.tpl

     Get all items that were sold in stores in a specific month and year and which were returned in the next six
     months of the same year and re-purchased by the returning 客户 afterwards through the catalog sales
     channel in the following three years.

     For those these items, compute the total 数量 sold through the store, the 数量 returned and the
     数量 purchased through the catalog. Group this information by item and store.

     Qualification Substitution Parameters:

     • MONTH.01 = 9
     • YEAR.01 = 1999
     • AGG.01 = sum

B.30 查询30.tpl

     Find customers and their detailed 客户 data who have returned items, which they bought on the web,
     for an amount that is 20% higher than the average amount a 客户 returns in a given state in a given
     time period across all items. Order the 输出 by 客户 data.

     Qualification Substitution Parameters:

     • YEAR.01 = 2002
     • STATE.01 = GA

B.31 查询31.tpl

     List counties where the percentage growth in web sales is consistently higher compared to the percentage
     growth in store sales in the first three consecutive quarters for a given year.

     Qualification Substitution Parameters:

     • YEAR.01 = 2000
     • AGG.01 = ss1.ca_county

B.32 查询32.tpl

     Compute the total discounted amount for a particular manufacturer in a particular 90 day period for catalog
     sales whose discounts exceeded the average 折扣 by at least 30%.

     Qualification Substitution Parameters:

     • CSDATE.01 = 2000-01-27
     • YEAR.01 = 2000
     • IMID.01 = 977
B.33 查询33.tpl

     What is the monthly sales 图 based on extended 价格 for a specific month in a specific year, for
     manufacturers in a specific category in a given time zone. Group sales by manufacturer identifier and sort
     输出 by sales amount, by channel, and give Total sales.

     Qualification Substitution Parameters:

     •   CATEGORY.01 = Electronics
     •   GMT.01 = -5
     •   MONTH.01 = 5
     •   YEAR.01 = 1998

B.34 查询34.tpl

     Display all customers with specific buy potentials and whose dependent count to vehicle count ratio is
     larger than 1.2, who in three consecutive years made purchases with between 15 and 20 items in the
     beginning or the end of each month in stores located in 8 counties.

     Qualification Substitution Parameters:

     •   COUNTY_H.01 = Williamson County
     •   COUNTY_G.01 = Williamson County
     •   COUNTY_F.01 = Williamson County
     •   COUNTY_E.01 = Williamson County
     •   COUNTY_D.01 = Williamson County
     •   COUNTY_C.01 = Williamson County
     •   COUNTY_B.01 = Williamson County
     •   COUNTY_A.01 = Williamson County
     •   YEAR.01 = 1999
     •   BPTWO.01 = Unknown
     •   BPONE.01 = >10000
B.35 查询35.tpl

     For the groups of customers living in the same state, having the same gender and marital status who have
     purchased from stores and from either the catalog or the web during a given year, display the following:

     •       state, gender, marital status, count of customers
     •       min, max, avg, count distinct of the 客户’s dependent count
     •       min, max, avg, count distinct of the 客户’s employed dependent count
     •       min, max, avg, count distinct of the 客户’s dependents in college count

     Display / calculate the “count of customers” multiple times to emulate a potential reporting tool scenario.

     Qualification Substitution Parameters:

         •   YEAR.01 = 2002
         •   AGGONE = min
         •   AGGTWO = max
         •   AGGTHREE = avg

B.36 查询36.tpl

     Compute store sales gross profit margin ranking for items in a given year for a given list of states.\

     Qualification Substitution Parameters:

         •   STATE_H.01 = TN
         •   STATE_G.01 = TN
         •   STATE_F.01 = TN
         •   STATE_E.01 = TN
         •   STATE_D.01 = TN
         •   STATE_C.01 = TN
         •   STATE_B.01 = TN
         •   STATE_A.01 = TN
         •   YEAR.01 = 2001

B.37 查询37.tpl

     List all items and current prices sold through the catalog channel from certain manufacturers in a given $30
     价格 range and consistently had a 数量 between 100 and 500 on hand in a 60-day period.

     Qualification Substitution Parameters:

         •   PRICE.01 = 68
         •   MANUFACT_ID.01 = 677
         •   MANUFACT_ID.02 = 940
         •   MANUFACT_ID.03 = 694
         •   MANUFACT_ID.04 = 808
         •   INVDATE.01 = 2000-02-01

B.38 查询38.tpl

     Display count of customers with purchases from all 3 channels in a given year.

     Qualification Substitution Parameters:

         • DMS.01 = 1200
B.39 查询39.tpl

     This 查询 contains multiple, related iterations:

     Iteration 1: Calculate the coefficient of variation and mean of every item and 仓库 of two consecutive
     months

     Iteration 2: Find items that had a coefficient of variation in the first months of 1.5 or large

     Qualification Substitution Parameters:

     • YEAR.01 = 2001
     • MONTH.01 = 1

B.40 查询40.tpl

     Compute the impact of an item 价格 change on the sales by computing the total sales for items in a 30 day
     period before and after the 价格 change. Group the items by location of 仓库 where they were
     delivered from.

     Qualification Substitution Parameters

     • SALES_DATE.01 = 2000-03-11
     • YEAR.01 = 2000

B.41 查询41.tpl

     How many items do we carry with specific combinations of color, units, size and category.

     Qualification Substitution Parameters

     •   MANUFACT.01 = 738
     •   SIZE.01 = medium
     •   SIZE.02 = extra large
     •   SIZE.03 = N/A
     •   SIZE.04 = small
     •   SIZE.05 = petite
     •   SIZE.06 = large
     •   UNIT.01 = Ounce
     •   UNIT.02 = Oz
     •   UNIT.03 = Bunch
     •   UNIT.04 = Ton
     •   UNIT.05 = N/A
     •   UNIT.06 = Dozen
     •   UNIT.07 = Box
     •   UNIT.08 = Pound
     •   UNIT.09 = Pallet
     •   UNIT.10 = Gross
     •   UNIT.11 = Cup
     •   UNIT.12 = Dram
     •   UNIT.13 = Each
     •   UNIT.14 = Tbl
     •   UNIT.15 = Lb
     •   UNIT.16 = Bundle
     •   COLOR.01 = powder
     •   COLOR.02 = khaki
     •   COLOR.03 = brown
     •   COLOR.04 = honeydew
     •   COLOR.05 = floral
     •   COLOR.06 = deep
     •   COLOR.07 = light
     •   COLOR.08 = cornflower
     •   COLOR.09 = midnight
     •   COLOR.10 = snow
     •   COLOR.11 = cyan
     •   COLOR.12 = papaya
     •   COLOR.13 = orange
     •   COLOR.14 = frosted
     •   COLOR.15 = forest
     •   COLOR.16 = ghost

B.42 查询42.tpl

     For each item and a specific year and month calculate the sum of the extended sales 价格 of store
     transactions.

     Qualification Substitution Parameters:

     • MONTH.01 = 11
     • YEAR.01 = 2000

B.43 查询43.tpl

     Report the sum of all sales from Sunday to Saturday for stores in a given data range by stores.

     Qualification Substitution Parameters:

     • YEAR.01 = 2000
     • GMT.01 = -5

B.44 查询44.tpl

     List the best and worst performing products measured by net profit.

     Qualification Substitution Parameters:

     • NULLCOLSS.01 = ss_addr_sk
     • STORE.01 = 4

B.45 查询45.tpl

     Report the total web sales for customers in specific zip codes, cities, counties or states, or specific items for
     a given year and quarter. .

     Qualification Substitution Parameters:

     • QOY.01 = 2
     • YEAR.01 = 2001
     • GBOBC = ca_city
B.46 查询46.tpl

     Compute the per-客户 coupon amount and net profit of all "out of town" customers buying from stores
     located in 5 cities on weekends in three consecutive years. The customers need to fit the profile of having a
     specific dependent count and vehicle count. For all these customers print the city they lived in at the time
     of purchase, the city in which the store is located, the coupon amount and net profit

     Qualification Substitution Parameters:

     •   CITY_E.01 = Fairview
     •   CITY_D.01 = Fairview
     •   CITY_C.01 = Fairview
     •   CITY_B.01 = Midway
     •   CITY_A.01 = Fairview
     •   VEHCNT.01 = 3
     •   YEAR.01 = 1999
     •   DEPCNT.01 = 4

B.47 查询47.tpl

     Find the item brands and categories for each store and company, the monthly sales figures for a specified
     year, where the monthly sales 图 deviated more than 10% of the average monthly sales for the year,
     sorted by deviation and store. Report deviation of sales from the previous and the following monthly sales.

     Qualification Substitution Parameters

     •   YEAR.01 = 1999
     •   SELECTONE = v1.i_category, v1.i_brand, v1.s_store_name, v1.s_company_name
     •   SELECTTWO = ,v1.d_year, v1.d_moy
     •   ORDERBY = s_store_name

B.48 查询48.tpl

     Calculate the total sales by different types of customers (e.g., based on marital status, education status), sales
     价格 and different combinations of state and sales profit.

     Qualification Substitution Parameters:

     •   MS.01=M
     •   MS.02=D
     •   MS.03=S
     •   ES.01=4 yr Degree
     •   ES.02=2 yr Degree
     •   ES.03=College
     •   STATE.01=CO
     •   STATE.02=OH
     •   STATE.03=TX
     •   STATE.04=OR
     •   STATE.05=MN
     •   STATE.06=KY
     •   STATE.07=VA
     •   STATE.08=CA
     •   STATE.09=MS
     •   YEAR.01=2000
B.49 查询49.tpl

     Report the worst return ratios (sales to returns) of all items for each channel by 数量 and currency
     sorted by ratio. Quantity ratio is defined as total number of sales to total number of returns. Currency ratio
     is defined as sum of return amount to sum of net paid.

     Qualification Substitution Parameters:

     • MONTH.01 = 12
     • YEAR.01 = 2001

B.50 查询50.tpl

     For each store count the number of items in a specified month that were returned after 30, 60, 90, 120 and
     more than 120 days from the day of purchase.

     Qualification Substitution Parameters:

     • MONTH.01 = 8
     • YEAR.01 = 2001

B.51 查询51.tpl

     Compute the count of store sales resulting from promotions, the count of all store sales and their ratio for
     specific categories in a particular time zone and for a given year and month.

     Qualification Substitution Parameters:

     • DMS.01 = 1200

B.52 查询52.tpl

     Report the total of extended sales 价格 for all items of a specific brand in a specific year and month.

     Qualification Substitution Parameters

     • MONTH.01=11
     • YEAR.01=2000

B.53 查询53.tpl

     Find the ID, quarterly sales and yearly sales of those manufacturers who produce items with specific
     characteristics and whose average monthly sales are larger than 10% of their monthly sales.

     Qualification Substitution Parameters:

     • DMS.01 = 1200

B.54 查询54.tpl

     Find all customers who purchased items of a given category and class on the web or through catalog in a
     given month and year that was followed by an in-store purchase at a store near their residence in the three
     consecutive months. Calculate a histogram of the 收入 by these customers in $50 segments showing the
     number of customers in each of these 收入 generated segments.

     Qualification Substitution Parameters:

     • CLASS.01 = maternity
     • CATEGORY.01 = Women
     • MONTH.01 = 12
     • YEAR.01 = 1998

B.55 查询55.tpl

     For a given year, month and store manager calculate the total store sales of any combination all brands.

     Qualification Substitution Parameters:

     • MANAGER.01 = 28
     • MONTH.01 = 11
     • YEAR.01 = 1999

B.56 查询56.tpl

     Compute the monthly sales amount for a specific month in a specific year, for items with three specific
     colors across all sales channels. Only consider sales of customers residing in a specific time zone. Group
     sales by item and sort 输出 by sales amount.

     Qualification Substitution Parameters:

     •   COLOR.01 = slate
     •   COLOR.02 = blanched
     •   COLOR.03 = burnished
     •   GMT.01 = -5
     •   MONTH.01 = 2
     •   YEAR.01 = 2001

B.57 查询57.tpl

     Find the item brands and categories for each call center and their monthly sales figures for a specified year,
     where the monthly sales 图 deviated more than 10% of the average monthly sales for the year, sorted
     by deviation and call center. Report the sales deviation from the previous and following month.

     Qualification Substitution Parameters:

     •   YEAR.01 = 1999
     •   SELECTONE = v1.i_category, v1.i_brand, v1.cc_name
     •   SELECTTWO = ,v1.d_year, v1.d_moy
     •   ORDERBY = cc_name

B.58 查询58.tpl

     Retrieve the items generating the highest 收入 and which had a 收入 that was approximately
     equivalent across all of store, catalog and web within the week ending a given 日期.

     Qualification Substitution Parameters:

     • SALES_DATE.01 = 2000-01-03
B.59 查询59.tpl

     Report the increase of weekly store sales from one year to the next year for each store and day of the week.

     Qualification Substitution Parameters:

     • DMS.01 = 1212

B.60 查询60.tpl

     What is the monthly sales amount for a specific month in a specific year, for items in a specific category,
     purchased by customers residing in a specific time zone. Group sales by item and sort 输出 by sales
     amount.

     Qualification Substitution Parameters:

     •   CATEGORY.01 = Music
     •   GMT.01 = -5
     •   MONTH.01 = 9
     •   YEAR=1998

B.61 查询61.tpl

     Find the ratio of items sold with and without promotions in a given month and year. Only items in certain
     categories sold to customers living in a specific time zone are considered.

     Qualification Substitution Parameters:

     •   GMT.01 = -5
     •   CATEGORY.01 = Jewelry
     •   MONTH.01 = 11
     •   YEAR.01 = 1998

B.62 查询62.tpl

     For web sales, create a report showing the counts of orders shipped within 30 days, from 31 to 60 days,
     from 61 to 90 days, from 91 to 120 days and over 120 days within a given year, grouped by 仓库,
     shipping mode and web site.

     Qualification Substitution Parameters:

     • DMS.01 = 1200

B.63 查询63.tpl

     For a given year calculate the monthly sales of items of specific categories, classes and brands that were sold
     in stores and group the results by store manager. Additionally, for every month and manager print the
     yearly average sales of those items.

     Qualification Substitution Parameters:

     • DMS.01 = 1200
B.64 查询64.tpl

     Find those stores that sold more cross-sales items from one year to another. Cross-sale items are items that
     are sold over the Internet, by catalog and in store.

     Qualification Substitution Parameters:

     •   YEAR.01 = 1999
     •   PRICE.01 = 64
     •   COLOR.01 = purple
     •   COLOR.02 = burlywood
     •   COLOR.03 = indian
     •   COLOR.04 = spring
     •   COLOR.05 = floral
     •   COLOR.06 = medium

B.65 查询65.tpl

     In a given period, for each store, report the list of items with 收入 less than 10% the average 收入 for
     all the items in that store.

     Qualification Substitution Parameters:


     • DMS.01 = 1176

B.66 查询66.tpl

     Compute web and catalog sales and profits by 仓库. Report results by month for a given year during
     a given 8-hour period.

     Qualification Substitution Parameters

     •   SALESTWO.01 = cs_sales_价格
     •   SALESONE.01 = ws_ext_sales_价格
     •   NETTWO.01 = cs_net_paid_inc_税
     •   NETONE.01 = ws_net_paid
     •   SMC.01 = DHL
     •   SMC.02 = BARIAN
     •   TIMEONE.01 = 30838
     •   YEAR.01 = 2001

B.67 查询67.tpl

     Find top stores for each category based on store sales in a specific year.

     Qualification Substitution Parameters:

     • DMS.01 = 1200
B.68 查询68.tpl

     Compute the per 客户 extended sales 价格, extended list 价格 and extended 税 for "out of town"
     shoppers buying from stores located in two cities in the first two days of each month of three consecutive
     years. Only consider customers with specific dependent and vehicle counts.

     Qualification Substitution Parameters:

     •   CITY_B.01 = Midway
     •   CITY_A.01 = Fairview
     •   VEHCNT.01 = 3
     •   YEAR.01 = 1999
     •   DEPCNT.01 = 4

B.69 查询69.tpl

     Count the customers with the same gender, marital status, education status, education status, purchase
     estimate and credit rating who live in certain states and who have purchased from stores but neither form
     the catalog nor from the web during a two month time period of a given year.

     Qualification Substitution Parameters:

     •   STATE.01 = KY
     •   STATE.02 = GA
     •   STATE.03 = NM
     •   YEAR.01 = 2001
     •   MONTH.01 = 4

B.70 查询70.tpl

     Compute store sales net profit ranking by state and county for a given year and determine the five most
     profitable states.

     Qualification Substitution Parameters:

     • DMS.01 = 1200

B.71 查询71.tpl

     Select the top 收入 generating products, sold during breakfast or dinner time for one month managed by
     a given manager across all three sales channels.

     Qualification Substitution Parameters:

     • MANAGER.01 = 1
     • MONTH.01 = 11
     • YEAR.01 = 1999

B.72 查询72.tpl

     For each item, 仓库 and week combination count the number of sales with and without promotion.

     Qualification Substitution Parameters:

     • BP.01 = >10000
     • MS.01 = D
     • YEAR.01 = 1999
     Comment: The adding of the scalar number 5 to d1.d_日期 in the 谓词 “d3.d_日期 > d1.d_日期 + 5”
     means that 5 days are added to d1.d_日期.

B.73 查询73.tpl

     Count the number of customers with specific buy potentials and whose dependent count to vehicle count
     ratio is larger than 1 and who in three consecutive years bought in stores located in 4 counties between 1
     and 5 items in one purchase. Only purchases in the first 2 days of the months are considered.

     Qualification Substitution Parameters:

     •   COUNTY_D.01 = Orange County
     •   COUNTY_C.01 = Bronx County
     •   COUNTY_B.01 = Franklin Parish
     •   COUNTY_A.01 = Williamson County
     •   YEAR.01 = 1999
     •   BPTWO.01 = Unknown
     •   BPONE.01 = >10000

B.74 查询74.tpl

     Display customers with both store and web sales in consecutive years for whom the increase in web sales
     exceeds the increase in store sales for a specified year.

     Qualification Substitution Parameters:

     •   YEAR.01 = 2001
     •   AGGONE.01 = sum
     •   ORDERC.01 = 1
     •   ORDERC.02 = 1
     •   ORDERC.03 = 1

B.75 查询75.tpl

     For two consecutive years track the sales of items by brand, class and category.

     Qualification Substitution Parameters:

     • CATEGORY.01 = Books
     • YEAR.01 = 2002
Comment: Some combinations of 查询 substitution parameters might cause a 查询 to return 0 行.
This is currently only known for Query 75 with YEAR=1999.

B.76 查询76.tpl

     Computes the average 数量, list 价格, 折扣, sales 价格 for promotional items sold through the web
     channel where the promotion is not offered by mail or in an event for given gender, marital status and
     educational status.

     Qualification Substitution Parameters:

     • NULLCOLCS.01 = cs_ship_addr_sk
     • NULLCOLWS.01 = ws_ship_客户_sk
     • NULLCOLSS.01 = ss_store_sk
B.77 查询77.tpl

     Report the total sales, returns and profit for all three sales channels for a given 30 day period. Roll up the
     results by channel and a unique channel location identifier.

     Qualification Substitution Parameters:

     • SALES_DATE.01 = 2000-08-23

B.78 查询78.tpl

     Report the top 客户 / item combinations having the highest ratio of store channel sales to all other
     channel sales (minimum 2 to 1 ratio), for combinations with at least one store sale and one other channel
     sale. Order the 输出 by highest ratio.

     Qualification Substitution Parameters:

     • YEAR.01 = 2000
     • SELECTONE.01 = ss_sold_year, ss_item_sk, ss_客户_sk

B.79 查询79.tpl

     Compute the per 客户 coupon amount and net profit of Monday shoppers. Only purchases of three
     consecutive years made on Mondays in large stores by customers with a certain dependent count and with
     a large vehicle count are considered.

     Qualification Substitution Parameters:

     • VEHCNT.01 = 2
     • YEAR.01 = 1999
     • DEPCNT.01 = 6

B.80 查询80.tpl

     Report extended sales, extended net profit and returns in the store, catalog, and web channels for a 30 day
     window for items with prices larger than $50 not promoted on television, rollup results by sales channel
     and channel specific sales means (store for store sales, catalog page for catalog sales and web site for web
     sales)

     Qualification Substitution Parameters:

     • SALES_DATE.01 = 2000-08-23

B.81 查询81.tpl

     Find customers and their detailed 客户 data who have returned items bought from the catalog more
     than 20 percent the average 客户 returns for customers in a given state in a given time period. Order
     输出 by 客户 data.

     Qualification Substitution Parameters:

     • YEAR.01 = 2000
     • STATE.01 = GA
B.82 查询82.tpl
         List all items and current prices sold through the store channel from certain manufacturers in a
         given $30 价格 range and consistently had a 数量 between 100 and 500 on hand in a 60-day
         period.

     Qualification Substitution Parameters

     •   MANUFACT_ID.01 = 129
     •   MANUFACT_ID.02 = 270
     •   MANUFACT_ID.03 = 821
     •   MANUFACT_ID.04 = 423
     •   INVDATE.01 = 2000-05-25
     •   PRICE.01 = 62

B.83 查询83.tpl

     Retrieve the items with the highest number of returns where the number of returns was approximately
     equivalent across all store, catalog and web channels (within a tolerance of +/- 10%), within the week
     ending a given 日期.

     Qualification Substitution Parameters

     • RETURNED_DATE_THREE.01 = 2000-11-17
     • RETURNED_DATE_TWO.01 = 2000-09-27
     • RETURNED_DATE_ONE.01 = 2000-06-30

B.84 查询84.tpl

     List all customers living in a specified city, with an income between 2 值.

     Qualification Substitution Parameters

     • INCOME.01 = 38128
     • CITY.01 = Edgewood

B.85 查询85.tpl

     For all web return reason calculate the average sales, average refunded cash and average return fee by
     different combinations of 客户 and sales types (e.g., based on marital status, education status, state and
     sales profit).

     Qualification Substitution Parameters:

     •   YEAR.01 = 2000
     •   STATE.01 = IN
     •   STATE.02 = OH
     •   STATE.03 = NJ
     •   STATE.04 = WI
     •   STATE.05 = CT
     •   STATE.06 = KY
     •   STATE.07 = LA
     •   STATE.08 = IA
     •   STATE.09 = AR
     •   ES.01 = Advanced Degree
     •   ES.02 = College
     •   ES.03 = 2 yr Degree
     •   MS.01 = M
     •   MS.02 = S
     •   MS.03 = W

B.86 查询86.tpl

     Rollup the web sales for a given year by category and class, and rank the sales among peers within the
     parent, for each group compute sum of sales, location with the hierarchy and rank within the group.

     Qualification Substitution Parameters:

     • DMS.01 = 1200

B.87 查询87.tpl

     Count how many customers have ordered on the same day items on the web and the catalog and on the
     same day have bought items in a store.

     Qualification Substitution Parameters:

     • DMS.01 = 1200

B.88 查询88.tpl

     How many items do we sell between pacific times of a day in certain stores to customers with one
     dependent count and 2 or less vehicles registered or 2 dependents with 4 or fewer vehicles registered or 3
     dependents and five or less vehicles registered. In one 行 break the counts into sells from 8:30 to 9, 9 to
     9:30, 9:30 to 10 ... 12 to 12:30

     Qualification Substitution Parameters:

     •   STORE.01=Unknown
     •   HOUR.01=4
     •   HOUR.02=2
     •   HOUR.03=0

B.89 查询89.tpl

     Within a year list all month and combination of item categories, classes and brands that have had monthly
     sales larger than 0.1 percent of the total yearly sales.

     Qualification Substitution Parameters:

     •   CLASS_F.01 = dresses
     •   CAT_F.01 = Women
     •   CLASS_E.01 = birdal
     •   CAT_E.01 = Jewelry
     •   CLASS_D.01 = shirts
     •   CAT_D.01 = Men
     •   CLASS_C.01 = football
     •   CAT_C.01 = Sports
     •   CLASS_B.01 = stereo
     •   CAT_B.01 = Electronics
     •   CLASS_A.01 = computers
     • CAT_A.01 = Books
     • YEAR.01 = 1999

B.90 查询90.tpl

     What is the ratio between the number of items sold over the internet in the morning (8 to 9am) to the
     number of items sold in the evening (7 to 8pm) of customers with a specified number of dependents.
     Consider only websites with a high amount of content.

     Qualification Substitution Parameters:

     • HOUR_PM.01 = 19
     • HOUR_AM.01 = 8
     • DEPCNT.01 = 6

B.91 查询91.tpl

     Display total returns of catalog sales by call center and manager in a particular month for male customers of
     unknown education or female customers with advanced degrees with a specified buy potential and from a
     particular time zone.

     Qualification Substitution Parameters:

     •   YEAR.01 = 1998
     •   MONTH.01 = 11
     •   BUY_POTENTIAL.01 = Unknown
     •   GMT.01 = -7

B.92 查询92.tpl

     Compute the total 折扣 on web sales of items from a given manufacturer over a particular 90 day period
     for sales whose 折扣 exceeded 30% over the average 折扣 of items from that manufacturer in that
     period of time.

     Qualification Substitution Parameters:

     • IMID.01 = 350
     • WSDATE.01 = 2000-01-27

B.93 查询93.tpl

    For a given merchandise return reason, report on customers’ total 成本 of purchases minus the 成本 of
    returned items.



     Qualification Substitution Parameters:

     • REASON.01 = reason 28
B.94 查询94.tpl

     Produce a count of web sales and total shipping 成本 and net profit in a given 60 day period to customers in
     a given state from a named web site for non returned orders shipped from more than one 仓库.

     Qualification Substitution Parameters:

     • YEAR.01 = 1999
     • MONTH.01 = 2
     • STATE.01 = IL

B.95 查询95.tpl

     Produce a count of web sales and total shipping 成本 and net profit in a given 60 day period to customers in
     a given state from a named web site for returned orders shipped from more than one 仓库.

     Qualification Substitution Parameters:

     • STATE.01=IL
     • MONTH.01=2
     • YEAR.01=1999

B.96 查询96.tpl

     Compute a count of sales from a named store to customers with a given number of dependents made in a
     specified half hour period of the day.

     Qualification Substitution Parameters:

     • HOUR.01 = 20
     • DEPCNT.01 = 7

B.97 查询97.tpl

     Generate counts of promotional sales and total sales, and their ratio from the web channel for a particular
     item category and month to customers in a given time zone.

     Qualification Substitution Parameters:

     • DMS.01 = 1200

B.98 查询98.tpl

     Report on items sold in a given 30 day period, belonging to the specified category.

     Qualification Substitution Parameters

     •   YEAR.01 = 1999
     •   SDATE.01 = 1999-02-22
     •   CATEGORY.01 = Sports
     •   CATEGORY.02 = Books
     •   CATEGORY.03 = Home
B.99 查询99.tpl

     For catalog sales, create a report showing the counts of orders shipped within 30 days, from 31 to 60 days,
     from 61 to 90 days, from 91 to 120 days and over 120 days within a given year, grouped by 仓库, call
     center and shipping mode.

     Qualification Substitution Parameters

     • DMS.01 = 1200
                               Appendix C: Approved Query Variants
The following Query variants are approved. See Table 0-1 for location of Original Query Template and
Approved Query Variant Templates.

     Original Query Template                 Approved Query Variant Template

    Query5.tpl                               Query5a.tpl

    Query10.tpl                              Query10a.tpl

    Query14.tpl                              Query14a.tpl

    Query18.tpl                              Query18a.tpl

    Query22.tpl                              Query22a.tpl

    Query27.tpl                              Query27a.tpl

    Query35.tpl                              Query35a.tpl

    Query36.tpl                              Query36a.tpl

    Query51.tpl                              Query51a.tpl

    Query67.tpl                              Query67a.tpl

    Query70.tpl                              Query70a.tpl

    Query77.tpl                              Query77a.tpl

    Query80.tpl                              Query80a.tpl

    Query86.tpl                              Query86a.tpl
                                 Appendix D: Query Ordering
 The 订单 of 查询 templates in each 查询 stream is determined by dsqgen. For convenience the
 following 表 displays the 订单 of 查询 templates for the first 21 streams. The 订单 is the same for all
 scale factors.

                                     Table 11-1 Required Query Sequences
SEQ    Stream Number
Num    0     1   2     3    4    5     6    7    8    9    10   11   12   13   14   15   16   17   18   19   20
1      96   83   56    89   79   73    34   70   57   15   43   95   68   23   46   51   11   86   40   90   18
2      7    32   98    5    39   66    88   53   29   60   50   31   37   81   54   38   97   61   42   47   35
3      75   30   59    52   93   4     44   92   24   62   41   17   94   99   76   74   48   49   9    25   16
4      44   92   24    62   41   17    94   99   76   74   48   49   9    25   16   27   63   8    19   58   6
5      39   66   88    53   29   60    50   31   37   81   54   38   97   61   42   47   35   67   82   55   22
6      80   84   2     7    32   98    5    39   66   88   53   29   60   50   31   37   81   54   38   97   61
7      32   98   5     39   66   88    53   29   60   50   31   37   81   54   38   97   61   42   47   35   67
8      19   58   6     80   84   2     7    32   98   5    39   66   88   53   29   60   50   31   37   81   54
9      25   16   27    63   8    19    58   6    80   84   2    7    32   98   5    39   66   88   53   29   60
10     78   77   87    72   71   65    20   64   12   1    96   83   56   89   79   73   34   70   57   15   43
11     86   40   90    18   45   3     75   30   59   52   93   4    44   92   24   62   41   17   94   99   76
12     1    96   83    56   89   79    73   34   70   57   15   43   95   68   23   46   51   11   86   40   90
13     91   13   91    13   91   13    91   13   91   13   91   13   91   13   91   13   91   13   91   13   91
14     21   36   28    69   14   21    36   28   69   14   21   36   28   69   14   21   36   28   69   14   21
15     43   95   68    23   46   51    11   86   40   90   18   45   3    75   30   59   52   93   4    44   92
16     27   63   8     19   58   6     80   84   2    7    32   98   5    39   66   88   53   29   60   50   31
17     94   99   76    74   48   49    9    25   16   27   63   8    19   58   6    80   84   2    7    32   98
18     45   3    75    30   59   52    93   4    44   92   24   62   41   17   94   99   76   74   48   49   9
19     58   6    80    84   2    7     32   98   5    39   66   88   53   29   60   50   31   37   81   54   38
20     64   12   1     96   83   56    89   79   73   34   70   57   15   43   95   68   23   46   51   11   86
21     36   28   69    14   21   36    28   69   14   21   36   28   69   14   21   36   28   69   14   21   36
22     33   85   26    10   78   77    87   72   71   65   20   64   12   1    96   83   56   89   79   73   34
23     46   51   11    86   40   90    18   45   3    75   30   59   52   93   4    44   92   24   62   41   17
24     62   41   17    94   99   76    74   48   49   9    25   16   27   63   8    19   58   6    80   84   2
25     16   27   63    8    19   58    6    80   84   2    7    32   98   5    39   66   88   53   29   60   50
26     10   78   77    87   72   71    65   20   64   12   1    96   83   56   89   79   73   34   70   57   15
27     63   8    19    58   6    80    84   2    7    32   98   5    39   66   88   53   29   60   50   31   37
28     69   14   21    36   28   69    14   21   36   28   69   14   21   36   28   69   14   21   36   28   69
29     60   50   31    37   81   54    38   97   61   42   47   35   67   82   55   22   33   85   26   10   78
30     59   52   93    4    44   92    24   62   41   17   94   99   76   74   48   49   9    25   16   27   63
31     37   81   54    38   97   61    42   47   35   67   82   55   22   33   85   26   10   78   77   87   72
32     98   5    39    66   88   53    29   60   50   31   37   81   54   38   97   61   42   47   35   67   82
33     85   26   10    78   77   87    72   71   65   20   64   12   1    96   83   56   89   79   73   34   70
34     70   57   15    43   95   68    23   46   51   11   86   40   90   18   45   3    75   30   59   52   93
35     67   82   55    22   33   85    26   10   78   77   87   72   71   65   20   64   12   1    96   83   56
36     28   69   14    21   36   28    69   14   21   36   28   69   14   21   36   28   69   14   21   36   28
37     81   54   38    97   61   42    47   35   67   82   55   22   33   85   26   10   78   77   87   72   71
38     97   61   42    47   35   67    82   55   22   33   85   26   10   78   77   87   72   71   65   20   64
39     66   88   53    29   60   50    31   37   81   54   38   97   61   42   47   35   67   82   55   22   33
40     90   18   45    3    75   30    59   52   93   4    44   92   24   62   41   17   94   99   76   74   48
41     17   94   99    76   74   48    49   9    25   16   27   63   8    19   58   6    80   84   2    7    32
42     47   35   67    82   55   22    33   85   26   10   78   77   87   72   71   65   20   64   12   1    96
43     95   68   23    46   51   11    86   40   90   18   45   3    75   30   59   52   93   4    44   92   24
44     92   24   62    41   17   94    99   76   74   48   49   9    25   16   27   63   8    19   58   6    80
45     3    75   30    59   52   93    4    44   92   24   62   41   17   94   99   76   74   48   49   9    25
46     51   11   86    40   90   18    45   3    75   30   59   52   93   4    44   92   24   62   41   17   94
47     35   67   82    55   22   33    85   26   10   78   77   87   72   71   65   20   64   12   1    96   83
48     49   9    25    16   27   63    8    19   58   6    80   84   2    7    32   98   5    39   66   88   53
SEQ   Stream Number
Num   0     1   2     3    4    5    6    7    8    9    10   11   12   13   14   15   16   17   18   19   20
49    9     25  16    27   63   8    19   58   6    80   84   2    7    32   98   5    39   66   88   53   29
50    31    37  81    54   38   97   61   42   47   35   67   82   55   22   33   85   26   10   78   77   87
51    11    86  40    90   18   45   3    75   30   59   52   93   4    44   92   24   62   41   17   94   99
52    93    4   44    92   24   62   41   17   94   99   76   74   48   49   9    25   16   27   63   8    19
53    29    60  50    31   37   81   54   38   97   61   42   47   35   67   82   55   22   33   85   26   10
54    38    97  61    42   47   35   67   82   55   22   33   85   26   10   78   77   87   72   71   65   20
55    22    33  85    26   10   78   77   87   72   71   65   20   64   12   1    96   83   56   89   79   73
56    89    79  73    34   70   57   15   43   95   68   23   46   51   11   86   40   90   18   45   3    75
57    15    43  95    68   23   46   51   11   86   40   90   18   45   3    75   30   59   52   93   4    44
58    6     80  84    2    7    32   98   5    39   66   88   53   29   60   50   31   37   81   54   38   97
59    52    93  4     44   92   24   62   41   17   94   99   76   74   48   49   9    25   16   27   63   8
60    50    31  37    81   54   38   97   61   42   47   35   67   82   55   22   33   85   26   10   78   77
61    42    47  35    67   82   55   22   33   85   26   10   78   77   87   72   71   65   20   64   12   1
62    41    17  94    99   76   74   48   49   9    25   16   27   63   8    19   58   6    80   84   2    7
63    8     19  58    6    80   84   2    7    32   98   5    39   66   88   53   29   60   50   31   37   81
64    12    1   96    83   56   89   79   73   34   70   57   15   43   95   68   23   46   51   11   86   40
65    20    64  12    1    96   83   56   89   79   73   34   70   57   15   43   95   68   23   46   51   11
66    88    53  29    60   50   31   37   81   54   38   97   61   42   47   35   67   82   55   22   33   85
67    82    55  22    33   85   26   10   78   77   87   72   71   65   20   64   12   1    96   83   56   89
68    23    46  51    11   86   40   90   18   45   3    75   30   59   52   93   4    44   92   24   62   41
69    14    21  36    28   69   14   21   36   28   69   14   21   36   28   69   14   21   36   28   69   14
70    57    15  43    95   68   23   46   51   11   86   40   90   18   45   3    75   30   59   52   93   4
71    65    20  64    12   1    96   83   56   89   79   73   34   70   57   15   43   95   68   23   46   51
72    71    65  20    64   12   1    96   83   56   89   79   73   34   70   57   15   43   95   68   23   46
73    34    70  57    15   43   95   68   23   46   51   11   86   40   90   18   45   3    75   30   59   52
74    48    49  9     25   16   27   63   8    19   58   6    80   84   2    7    32   98   5    39   66   88
75    30    59  52    93   4    44   92   24   62   41   17   94   99   76   74   48   49   9    25   16   27
76    74    48  49    9    25   16   27   63   8    19   58   6    80   84   2    7    32   98   5    39   66
77    87    72  71    65   20   64   12   1    96   83   56   89   79   73   34   70   57   15   43   95   68
78    77    87  72    71   65   20   64   12   1    96   83   56   89   79   73   34   70   57   15   43   95
79    73    34  70    57   15   43   95   68   23   46   51   11   86   40   90   18   45   3    75   30   59
80    84    2   7     32   98   5    39   66   88   53   29   60   50   31   37   81   54   38   97   61   42
81    54    38  97    61   42   47   35   67   82   55   22   33   85   26   10   78   77   87   72   71   65
82    55    22  33    85   26   10   78   77   87   72   71   65   20   64   12   1    96   83   56   89   79
83    56    89  79    73   34   70   57   15   43   95   68   23   46   51   11   86   40   90   18   45   3
84    2     7   32    98   5    39   66   88   53   29   60   50   31   37   81   54   38   97   61   42   47
85    26    10  78    77   87   72   71   65   20   64   12   1    96   83   56   89   79   73   34   70   57
86    40    90  18    45   3    75   30   59   52   93   4    44   92   24   62   41   17   94   99   76   74
87    72    71  65    20   64   12   1    96   83   56   89   79   73   34   70   57   15   43   95   68   23
88    53    29  60    50   31   37   81   54   38   97   61   42   47   35   67   82   55   22   33   85   26
89    79    73  34    70   57   15   43   95   68   23   46   51   11   86   40   90   18   45   3    75   30
90    18    45  3     75   30   59   52   93   4    44   92   24   62   41   17   94   99   76   74   48   49
91    13    91  13    91   13   91   13   91   13   91   13   91   13   91   13   91   13   91   13   91   13
92    24    62  41    17   94   99   76   74   48   49   9    25   16   27   63   8    19   58   6    80   84
93    4     44  92    24   62   41   17   94   99   76   74   48   49   9    25   16   27   63   8    19   58
94    99    76  74    48   49   9    25   16   27   63   8    19   58   6    80   84   2    7    32   98   5
95    68    23  46    51   11   86   40   90   18   45   3    75   30   59   52   93   4    44   92   24   62
96    83    56  89    79   73   34   70   57   15   43   95   68   23   46   51   11   86   40   90   18   45
97    61    42  47    35   67   82   55   22   33   85   26   10   78   77   87   72   71   65   20   64   12
98    5     39  66    88   53   29   60   50   31   37   81   54   38   97   61   42   47   35   67   82   55
99    76    74  48    49   9    25   16   27   63   8    19   58   6    80   84   2    7    32   98   5    39
Appendix E: Sample Executive Summary
                                      Appendix F: Tool Set Requirements

F.1     Introduction

      In addition to this document, TPC-DS relies on material that is only available electronically. While not
      included in the printed version of the 规范, this “soft appendix” is integral to the submission of a
      compliant TPC-DS 基准测试 结果.

F.2     Availability

      Need to confirm and any other legalese with TPC

      The electronically available 规范 content 可 be downloaded from the TPC-DS 节 of the TPC
      web site located on the TPC website (http://www.tpc.org) free of charge. It is solely intended for use in
      conjunction with the 执行 of a TPC-DS 基准测试. Any other use is prohibited without the express,
      prior written consent of the TPC.

F.3     Compatibility

      This material is maintained, versioned and revised independently of the 规范 itself. It is the
      基准测试 sponsor’s responsibility to assure that any 基准测试 submission relies on a revision of the soft
      appendix that is compliant with the revision of the TPC-DS 规范 against which the 结果 is being
      submitted.

      The soft appendix includes a version number similar to that used in the 规范, with a major version
      number, a minor version number and a third tier level, each separated by a decimal point. The major and
      minor revision numbers are tied to those of the TPC-DS 规范 with which the soft appendix is
      compliant. The third tier level of the soft appendix is incremented whenever the appendix itself is updated,
      and is independent of revision changes or updates to the 规范.

      A revision of the soft appendix 可 be used to submit a TPC-DS 基准测试 结果 provided that the major
      revision number of the soft appendix matches that of a 规范 revision that is eligible for 基准测试
      submission;

      Comment: The intent of this 子句 is to allow for the possibly lengthy tuning and preparation cycle that
      precedes a 基准测试 submission, during which a third tier revision could be released.

      Benchmark sponsors are encouraged to use the most recent patch level of a given soft appendix version, as
      it will contain the latest clarifications and bug fixes, but any third tier level 可 be used to produce a
      compliant 基准测试 submission as long as the prior conditions are met.
                                        Appendix G: XML Schema Guide

G.1     Overview

      The 模式 of the ES.xml document is defined by the XML 模式 document tpcds-es.xsd available at
      located on the TPC website (http://www.tpc.org). The ES.xml file must conform to the tpcds-es.xsd
      (established by XML 模式 validation).

G.2     Schema Structure

      An XML document conforming to the tpcds-es.xsd 模式 contains a single element named tpcdsResult of
      type RootType. The main complex types are explained in the sections below. The other types not included
      here can be found in tpcds-es.xsd.

G.3     The RootType contains the following attributes:

                          Attribute                  Type                   Description

           SponsorName                string                 The sponsor’s name.

           SystemIdentification       string                 The name of measured server.

           SpecVersion                SpecVersionType


           PricingSpecVersion         SpecVersionType


           ReportDate                 日期


           RevisionDate               日期

           AvailabilityDate           日期                   Availability Date (see TPC Pricing Specification)

                                                             Reported Throughput in QphDS@SF (see Clause
           TpcdsThroughput            tpcdsType
                                                             7.6)

           PricePerf                  PriceType              Price/Performance Metric ($/kQphDS@SF)

           Currency                   CurrencyType           The currency in which the 结果 is priced.

           TotalSystemCost            PriceType              Total System Cost (see TPC Pricing Specification)

           AuditorName                AuditorType            The name of the Auditor who certified the 结果.

                                                             “Y” or “N” indicating if the 结果 was
           Cluster                    YesNoType
                                                             implemented on a clustered server 配置.

                                                             “Y” or “N” indicating if the 结果 was
           AllRaidProtected           YesNoType              implemented on a server with raid protection at
                                                             all levels.

           SchemaVersion              SchemaVersionType      The 模式 version, initially “1.0”.


G.4     The RootType contains the following elements:

                           Element                    Type                      Description

                                                               The DBServer element contains information
           DBServer                    DBServerType
                                                               about the 数据库 server.
                                                                  The StorageSubsystem element contains
        StorageSubsystem             StorageSubsystemType         information about the storage subsystem used
                                                                  for the 基准测试 run.

                                                                  The DatabaseLoad element contains
        DatabaseLoad                 DatabaseLoadRunDetailType    information about 数据库 load run
                                                                  性能.

                                                                  The PowerRun element contains information
        PowerRun                     PowerRunDetailType
                                                                  about the Power Run 性能.

                                                                  The QueryRun1 element contains information
        QueryRun1                    QueryRunDetailType
                                                                  about the Throughput Test 1 性能.

                                                                  The RefreshRun1 element contains information
        RefreshGroup1                RefreshGroupDetailType
                                                                  about the Refresh Run 1 性能.

                                                                  The QueryRun2 element contains information
        QueryRun2                    QueryRunDetailType
                                                                  about the Throughput Test 2 性能.

                                                                  The RefreshRun2 element contains information
        RefreshGroup2                RefreshGroupDetailType
                                                                  about the Refresh Run 2 性能.


G.5   The DBServerType contains the following attributes:

                         Attribute                     Type                        Description


        DBName                       string

        DBVersion                    string                      The version of the DBMS.



        DBMiscInfo                   string



        OSName                       string

        OSVersion                    string



        OSMiscInfo                   string



        ProcessorName                string


        ProcessorCount               positiveInteger
                                                                 Database Server

                                                                                                   Database
        CoreCount                    positiveInteger
                                                                 Server

                                                                                                        Database
        ThreadCount                  positiveInteger
                                                                 Server

        Memory                       decimal
                                                                     Database Server

        InitialDBSize                positiveInteger             Initial Database Size in GB

        RedundancyLevel              string                      The Redundancy Level
                                                                       Priced number of Durable Media (disks) on the
             SpindleCount                 positiveInteger
                                                                       Database Server.

                                                                       Size of the priced Durable Media (disks) on the
             SpindleSize                  positiveInteger
                                                                       Database Server.

                                                                       Number of host adapters in the priced 系统
             HostBusAdapterCount          positiveInteger
                                                                       配置


•

    G.6   The DBServerType has the following elements:

                             Element                    Type                              Description


             PerNodeHardware             PerNodeHardwareType



    G.7   The StorageSubsystemType contains the following attributes:

                             Attribute                      Type                          Description

             StorageSubsystem             string                       Description or name of the storage subsystem

             RaidLevel                    string                       RAID level used for this storage subsystem

                                                                       Number of storage arrays used in the priced
             ArrayCount                   positiveInteger
                                                                       配置

                                                                       Description of the durable media technology used
             SpindleTechnology            string
                                                                       in the priced 配置

             SpindleSize                  double                       Size of the disk

             SpindleRPM                   positiveInteger              Rotations per minute of the spindles

                                                                       Total amount of storage provided by the storage
             TotalMassStorage             double
                                                                       subsystem


    G.8   The StorageSubsystemType contains the following elements:

                             Element                    Type                              Description

             StorageArray                StorageArrayType              Description of the storage array

             StorageSwitch               StorageSwitchType             Description of the storage switch


    G.9   The StorageArrayType consists of the following attributes:

                             Attribute                      Type                          Description


             RaidLevel                    string


             SpindleTechnology            string

             SpindleCount                 positiveInteger
          SpindleRPM                 positiveInteger



G.10   The StorageSwitchType consists of the following attributes:

                        Attribute                        Type              Description

          StorageSwitchDescription     string

          StorageSwitchCount           positiveInteger


          StorageSwitchTechnology      string



G.11   The DatabaseLoadRunDetailType contains the following attributes:

                        Attribute                      Type               Description


          LoadTimeIncludesBackup     YesNoType



G.12   The DatabaseLoadRunDetailType contains the following elements:

                        Element                     Type                  Description


          RunTiming                  RunTimingDataType



G.13   The PowerRunDetailType contains the following elements:

                        Element                     Type                  Description


          RunTiming                  RunTimingDataType



          PowerQuery                 PowerQueryDataType



G.14   The RefreshGroupDetailType contains the following elements:

                        Element                     Type                  Description


          RunTiming                  RunTimingDataType



          RefreshFunction            RefreshDataType



G.15   The QueryRunDetailType contains the following elements:
                        Element                     Type           Description


          RunTiming                 RunTimingDataType


          Query                     QueryDataType


G.16   PowerQueryDataType contains the following attributes:

                        Attribute                      Type        Description

          QueryNumber                positiveInteger

          RT                         RTType



G.17   QueryDataType contains the following attributes:

                        Attribute                      Type        Description

          QueryNumber                positiveInteger

          RTMin                      RTType


          RTMax                      RTTYpe


          RTMedian                   RTType


          RT25th                     RTType


          RT75th                     RTType




G.18   RefreshDataType contains the following attributes:

                        Attribute                      Type            Description


          RefreshFunctionName        RefreshFunctionNameDataType
                                                                   Table 5-4

          RT                         RTType

