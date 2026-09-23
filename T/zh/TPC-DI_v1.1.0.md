# TPC-DI_v1.1.0（机器翻译草稿）

> ⚠️ 术语词典粗译，SQL/代码/大写标识符保留原文，可能生硬。仅供速览。

# TPC-DI_v1.1.0

> 源文件: `T/../TPC-DI_v1.1.0.pdf`，117 页。

  TPC BENCHMARK ™ DI
                   (Data Integration)


                Standard Specification

                     Version 1.1.0

                    November 2014




  Transaction Processing
Performance Council (TPC)
                     www.tpc.org

                     info@tpc.org

© 2013, 2014 Transaction Processing Performance Council

                  All Rights Reserved
                                 Legal Notice
The TPC reserves all right, title, and interest to this document and associated source code as
provided under U.S. and international laws, including without limitation all patent and
trademark rights therein. Permission to copy without fee all or 零件 of this document is granted
provided that the TPC copyright notice, the title of the publication, and its 日期 appear, and
notice is given that copying is by permission of the Transaction Processing Performance
Council. To copy otherwise requires specific permission.

                                 No Warranty
TO THE MAXIMUM EXTENT PERMITTED BY APPLICABLE LAW, THE
INFORMATION CONTAINED HEREIN IS PROVIDED “AS IS” AND WITH ALL
FAULTS, AND THE AUTHORS AND DEVELOPERS OF THE WORK HEREBY
DISCLAIM ALL OTHER WARRANTIES AND CONDITIONS, EITHER EXPRESS,
IMPLIED OR STATUTORY, INCLUDING, BUT NOT LIMITED TO, ANY (IF ANY)
IMPLIED WARRANTIES, DUTIES OR CONDITIONS OF MERCHANTABILITY, OF
FITNESS FOR A PARTICULAR PURPOSE, OF ACCURACY OR COMPLETENESS OF
RESPONSES, OF RESULTS, OF WORKMANLIKE EFFORT, OF LACK OF VIRUSES,
AND OF LACK OF NEGLIGENCE. ALSO, THERE IS NO WARRANTY OR
CONDITION OF TITLE, QUIET ENJOYMENT, QUIET POSSESSION,
CORRESPONDENCE TO DESCRIPTION OR NON-INFRINGEMENT WITH REGARD
TO THE WORK.
IN NO EVENT WILL ANY AUTHOR OR DEVELOPER OF THE WORK BE LIABLE TO
ANY OTHER PARTY FOR ANY DAMAGES, INCLUDING BUT NOT LIMITED TO THE
COST OF PROCURING SUBSTITUTE GOODS OR SERVICES, LOST PROFITS, LOSS
OF USE, LOSS OF DATA, OR ANY INCIDENTAL, CONSEQUENTIAL, DIRECT,
INDIRECT, OR SPECIAL DAMAGES WHETHER UNDER CONTRACT, TORT,
WARRANTY, OR OTHERWISE, ARISING IN ANY WAY OUT OF THIS OR ANY
OTHER AGREEMENT RELATING TO THE WORK, WHETHER OR NOT SUCH
AUTHOR OR DEVELOPER HAD ADVANCE NOTICE OF THE POSSIBILITY OF SUCH
DAMAGES.

                                  Trademarks
TPC Benchmark, TPC-DI, TPC-C, TPC-E, TPC-H and TPC-DS are trademarks of the
Transaction Processing Performance Council.
Product names, logos, brands, and other trademarks featured or referred to within this
Specification are the property of their respective trademark holders.


                             Acknowledgments
The TPC acknowledges the enormous time, effort and contributions of the TPC-DI
subcommittee member companies, past and present: Dell, HP, Huawei, IBM, Intel, Microsoft,
NEC, Oracle, and Sybase.
           The TPC-DI subcommittee would like to acknowledge the contributions made by many
           individuals from across the industry during the development of the 基准测试 规范.
           Their dedicated efforts made this 基准测试 possible. The list of significant contributors
           includes Len Wyatt, Brian Caufield, Meikel Poess, Samuel Wong, Jackson Wei, Ron Liu,
           Doug Nelson, Andrew Masland, Tilmann Rabl, Manuel Danisch, Michael Frank, John Fowler,
           Mike Doucette, and Daniel Pol.




                                           TPC Membership
                                            (as of November 2014)
                                                 Full Members




 Associate Members




TPC Benchmark™ DI - Standard Specification, Revision 1.1.0                       Page 3 of 117
                                           Document Revision History
       Date                Version    Description
       October 22, 2013    1.0.0      Initial release
       February 18, 2014   1.0.1      Editorial Change 1: Change to clarify Clause 7.2.2.2 .
                                      Editorial Change 2: Added 子句 6.3 to specify the DIGen generation statistics, and
       February 25, 2014   1.0.1      added references to this 子句 in 7.5.2.2 and 7.5.3.2 to clarify where to get 行 counts
                                      from when calculating the 指标.
       April 22, 2014      1.0.1      Editorial Change 3: Fixed bad 子句 reference.
       November 11, 2014   1.1.0      Changes to Data Visibility queries (Clause 7.3)




                                           Typographic Conventions
The following typographic conventions are used in this 规范:
       Convention            Description
       Bold                  Bold type is used to highlight terms that are defined in this document

       Italics               Italics type is used to highlight a variable that indicates some 数量 whose 值 can be
                             assigned in one place and referenced in many other places.
                             Uppercase letters names such as 表 and 列 names. In addition, most acronyms are in
       UPPERCASE
                             uppercase.




TPC Benchmark™ DI - Standard Specification, Revision 1.1.0                                                      Page 4 of 117
Contents
Clause 0:                 Preamble .......................................................................................................8
  0.1       Introduction ..................................................................................................................8
  0.2       General Implementation Guidelines..............................................................................9
  0.3       General Measurement Guidelines ...............................................................................11
  0.4       Definitions ..................................................................................................................11
Clause 1:                 Benchmark Overview ...................................................................................12
  1.1       Business and Application Environment .......................................................................12
  1.2       Summary of Operations ..............................................................................................13
  1.3       Source Data Models ....................................................................................................15
  1.4       Destination Data Model ..............................................................................................17
  1.5       Transformations..........................................................................................................18
  1.6       Result Reporting Classes ............................................................................................. 19
Clause 2:                 Source Data Files..........................................................................................20
  2.1       Introduction ................................................................................................................20
  2.2       File format definitions .................................................................................................20
  2.3       Structure of the Staging Area ......................................................................................35
  2.4       Staging Area Implementation Rules ............................................................................36
Clause 3:                 Data Warehouse .......................................................................................... 37
  3.1       Introduction ................................................................................................................37
  3.2       Table Definitions .........................................................................................................37
  3.3       Data Warehouse Properties ........................................................................................46
  3.4       Data Warehouse Implementation Rules ......................................................................46
Clause 4:                 Transformations ..........................................................................................52
  4.1       Introduction ................................................................................................................52
  4.2       Data Integration System Properties ............................................................................52
  4.3       Transformation Implementation Rules ........................................................................53
  4.4       Data Manipulation Details...........................................................................................55
  4.5       Transformation Details for the Historical Load ............................................................58
  4.6       Transformation Details for Incremental Updates ........................................................71

TPC Benchmark™ DI - Standard Specification, Revision 1.1.0                                                               Page 5 of 117
Clause 5:                 Description of the System Under Test ..........................................................80
  5.1       Overview ....................................................................................................................80
  5.2       Definition of the System Under Test ...........................................................................80
Clause 6:                 DIGen...........................................................................................................82
  6.1       Overview ....................................................................................................................82
  6.2       Compliant DIGen Versions ..........................................................................................82
Clause 7:                 Execution Rules & Metrics ...........................................................................84
  7.1       Introduction ................................................................................................................84
  7.2       Execution phases and measurements .........................................................................84
  7.3       Data Visibility Query ...................................................................................................88
  7.4       Batch Validation Query ...............................................................................................88
  7.5       Calculating Throughput ...............................................................................................89
  7.6       Primary Metrics ..........................................................................................................90
Clause 8:                 System and Implementation Qualification ...................................................91
  8.1       Qualification Environment ..........................................................................................91
  8.2       Verifying accuracy and 一致性 .............................................................................91
  8.3       Transformation Accuracy ............................................................................................94
  8.4       Durability ....................................................................................................................94
Clause 9:                 Pricing .......................................................................................................... 98
  9.1       Priced Configuration ...................................................................................................98
  9.2       On-line Storage Requirement ......................................................................................98
  9.3       TPC-DI Specific Pricing Requirements ..........................................................................99
  9.4       Component Substitution ............................................................................................. 99
Clause 10:                Full Disclosure Report ................................................................................ 101
  10.1         Full Disclosure Report Requirements ..................................................................... 101
  10.2         General Requirements........................................................................................... 101
  10.3         Executive Summary Statement .............................................................................. 103
  10.4         Availability of the Full Disclosure Report................................................................ 108
  10.5         Revisions to the Full Disclosure Report .................................................................. 108
  10.6         Rebadged Results .................................................................................................. 108
  10.7         Supporting Files Index Table .................................................................................. 108

TPC Benchmark™ DI - Standard Specification, Revision 1.1.0                                                                  Page 6 of 117
Clause 11:             Independent Audit ..................................................................................... 110
  11.1       Overview ............................................................................................................... 110
Clause 12:             Definitions of Terms ................................................................................... 112
Clause 13:             Definitions of Tasks to be disclosed............................................................ 115
Clause 14:             Definitions of Observations to be disclosed ............................................... 116




TPC Benchmark™ DI - Standard Specification, Revision 1.1.0                                                             Page 7 of 117
                                         Clause 0: Preamble

0.1        Introduction
           TPC Benchmark™ DI (TPC-DI) is a 性能 test of tools that move and integrate data
           between various 系统. Data Integration (DI) tools are available from a number of vendors,
           but until now there has been no standard way to compare them. Such tools have also been
           referred to as Extract, Transform and Load (ETL) tools at times. The 基准测试 工作负载
           manipulates a defined volume of data, preparing the data for use in a Data Warehouse. The
           基准测试 model includes data representing an extract from an On-Line Transaction
           Processing (OTLP) 系统 being transformed along with data from ancillary data sources
           (including tabular and hierarchical structures), and loaded into a Data Warehouse. The
           source and destination schemas, data transformations and 实现 规则 have been
           designed to be broadly representative of modern data integration 要求.
           The 基准测试 exercises a breadth of 系统 components associated with DI environments,
           which are characterized by:
               The manipulation and loading of large volumes of data,
               A mixture of transformation types including error checking, surrogate key lookups, data
               type conversions, aggregation operations, data updates, etc.,
               Historical loading and incremental updates of a destination Data Warehouse using the
               transformed data,
               Consistency 要求 ensuring that the integration process results in reliable and
               accurate data,
               Multiple data sources having different formats,
               Multiple data 表 with varied data types, attributes and inter-表 relationships.
           The TPC-DI operations are modeled as follows:
               Source data is generated using TPC provided code. The data is provided in flat files,
               similar to the 输出 of many extraction tools.
               Transformation of the data begins with the System Under Test (SUT) reading the Source
               Data.
               The transformations validate the Source Data and properly structure the data for loading
               into a Data Warehouse.
               The process concludes when all Source Data has been transformed and is available in the
               Data Warehouse.
0.1.1      Model for the TPC-DI Benchmark
           The data model for the TPC-DI 基准测试 represents a retail brokerage. The focus of the
           TPC-DI 基准测试 is on the processes involved in transforming data from an OLTP
           environment and other relevant sources, and populating a data 仓库.
           The mixture and variety of transformations being executed on the SUT is designed to capture
           the variety and complexity involved in a realistic data integration application. It is not the
TPC Benchmark™ DI - Standard Specification, Revision 1.1.0                          Page 8 of 117
           intent of the TPC-DI 基准测试 to exercise all possible transformation types, but rather a
           representative set as needed for the brokerage scenario.
           The 基准测试 defines:
               Multiple data source schemas and file formats,
               The Source Data generation 要求 and data placement,
               The destination data 仓库 模式,
               A collection of transformation 规则 describing how the destination data 仓库 is
               populated with data from the data sources,
               Specific 规则 for the Historical Load and for Incremental Updates,
               Requirements for the 执行, timing and reporting of the metrics,
               Methodology for the verification of the resulting data in the data 仓库,
               Disclosure and auditing 要求 for the 实现 and 执行 of the
               工作负载.
           The 性能 指标 reported for TPC-DI is a 吞吐量 measure, the number of Source
           Data 行 processed per second. Conceptually, it is calculated by dividing the total 行
           processed by the 耗时 of the run. The 规则 for calculating DI 吞吐量 are given in
           Clause 7.
0.1.2      Restrictions and Limitations
           Despite the fact that this 基准测试 offers a rich environment that represents many DI
           applications, this 基准测试 does not reflect the entire range of DI 要求. In
           addition, the extent to which a 客户 can achieve the Results reported by a vendor is
           highly dependent on how closely TPC-DI approximates the 客户 application. The relative
           性能 of 系统 derived from this 基准测试 does not necessarily hold for other
           workloads or environments. Extrapolations to any other environments are not
           recommended.
           Benchmark results are highly dependent upon 工作负载, specific application 要求,
           and 系统 design and 实现. Relative 系统 性能 will vary because of
           these and other factors. Therefore, TPC-DI 应 not be used as a substitute for specific
           客户 application benchmarking when critical capacity planning and/or product
           evaluation decisions are contemplated.
           Benchmark sponsors are permitted various possible 实现 designs, insofar as they
           adhere to the model described and pictorially illustrated in this 规范. A Full
           Disclosure Report (FDR) of the 实现 details, as specified in Clause 10, 必须
           made available along with the reported Results.

0.2        General Implementation Guidelines
           The purpose of the TPC-DI 基准测试 is to provide relevant, objective 性能 data to
           industry users. To achieve that purpose, the TPC-DI 基准测试 规范 requires
           基准测试 tests be implemented with 系统, products, technologies and 定价 that:

TPC Benchmark™ DI - Standard Specification, Revision 1.1.0                          Page 9 of 117
               Are generally available to users;
               Are relevant to the market segment that the TPC-DI 基准测试 models or represents
               (e.g., TPC-DI models and represents environments that move and integrate data between
               various 系统);
               Would plausibly be implemented by a significant number of users in the market segment
               modeled or represented by the 基准测试.
           The use of new 系统, products, technologies (硬件 or 软件) and 定价
           (hereafter referred to as "TPC-DI implementations") is encouraged so long as they meet the
           要求 above. Specifically prohibited are 基准测试 系统, products, technologies
           or 定价 whose primary purpose is 性能 优化 of TPC-DI 基准测试 results
           without any corresponding applicability to real-world applications and environments. In other
           words, all "基准测试 special" TPC-DI implementations, which improve 基准测试 results
           but not real-world 性能 or 定价, are prohibited.
           A number of characteristics 应 be evaluated in 订单 to judge whether a particular TPC-DI
           实现 is a 基准测试 special. It is not required that each point below be met, but
           that the cumulative weight of the evidence be considered to identify an unacceptable TPC-DI
           实现. Absolute certainty or certainty beyond a reasonable doubt is not required to
           make a judgment on this complex issue. The question that 必须 answered is: "Based on
           the available evidence, does the clear preponderance (the greater share or weight) of
           evidence indicate this TPC-DI 实现 is a 基准测试 special?"
           The following characteristics 应 be used to judge whether a particular TPC-DI
           实现 is a 基准测试 special:
               Does the TPC-DI 实现 have significant restrictions on its use or applicability
               that limits its use beyond the TPC-DI 基准测试?
               Is the TPC-DI 实现 or 零件 of the TPC-DI 实现 poorly integrated into
               the larger product?
               Does the TPC-DI 实现 take special advantage of the limited nature of the TPC-
               DI 基准测试 (e.g., data transformations, data transformation mix, concurrency and/or
               contention, isolation 要求, etc.) in a manner that would not be generally
               applicable to the environment the 基准测试 represents?
               Is the use of the TPC-DI 实现 discouraged by the vendor? (This includes failing
               to promote the TPC-DI 实现 in a manner similar to other products and
               technologies.)
               Does the TPC-DI 实现 require uncommon sophistication on the 零件 of the
               end-user, programmer, or 系统 administrator?
               Is the 定价 unusual or non-customary for the vendor or unusual or non-customary
               compared to normal business practices? The following 定价 practices are suspect:
               • Availability of a 折扣 to a small subset of possible customers;
               • Discounts documented in an unusual or non-customary manner;
               • Discounts that exceed 25% on small quantities and 50% on large quantities;
               • Pricing featured as a close-out or one-time special;
TPC Benchmark™ DI - Standard Specification, Revision 1.1.0                         Page 10 of 117
               • Unusual or non-customary restrictions on transferability of product, warranty or
                 维护 on discounted items.
               Is the TPC-DI 实现 (including beta-release components) being purchased or
               used for applications in the market segment the 基准测试 represents? How many sites
               implemented it? How many end-users benefit from it? If the TPC-DI 实现 is
               not currently being purchased or used, is there any evidence to indicate that it will be
               purchased or used by a significant number of end-user sites?

0.3        General Measurement Guidelines
           TPC-DI 基准测试 results are expected to be accurate representations of 系统
           性能. Therefore, there are specific guidelines that are expected to be followed when
           measuring those results. The approach or methodology to be used in the measurements are
           either explicitly described in the 规范 or left to the discretion of the test sponsor.
           The use of new methodologies and approaches is encouraged when not described in the
           规范. However, these methodologies and approaches must meet the following
           要求:
               The approach is an accepted engineering practice or standard;
               The approach does not enhance the 结果;
               Equipment used in measuring the results is calibrated according to established quality
               standards;
               Fidelity and candor is maintained in reporting any anomalies in the results, even if not
               specified in the 基准测试 要求.

0.4        Definitions
           Throughout the body of this document, defined terms (see Clause 12) are formatted in bold
           to indicate that the term has a precise meaning. For 示例, “Rationale” specifically
           denotes an explanatory statement that is not 零件 of the standard, whereas “rationale”
           应 be interpreted simply using the typical 定义 of the word.




TPC Benchmark™ DI - Standard Specification, Revision 1.1.0                          Page 11 of 117
                                Clause 1: Benchmark Overview

1.1        Business and Application Environment
           The data model for the TPC-DI 基准测试 represents a retail brokerage. OLTP data is
           combined with data from additional sources to create the data 仓库. Figure 1.1-1
           illustrates the conceptual model of the brokerage DI 系统.




           Figure 1.1-1: Conceptual Overview
           There are multiple 表 in the OLTP 系统 that are extracted into a staging area; the OLTP
           系统 contains data on customers, accounts, brokers, securities, trade details, account
           balances, market information, and so on. Extracts from these 表 are represented as flat
           files in the Staging Area. For Incremental Updates the extracts are Changed Data Capture
           (CDC) extracts of changes to the 表 since the last extract while for the Historical Load the
           extract is modeled as a full dump of the 表.
           The HR 数据库 has one 表 with employee data that is represented as a full 表 extract
           into the Staging Area formatted comma separated 值 (CSV) file.
           The Prospects file contains names, addresses and demographic data for prospective
           customers, such as a company might purchase from a syndicated data provider. This data
           arrives in a comma separated 值 (CSV) file format, this being the lowest common
           denominator of information exchange. The DI process must determine what changes have
           occurred since the last update.

TPC Benchmark™ DI - Standard Specification, Revision 1.1.0                          Page 12 of 117
           In the Historical Load phase of the 基准测试, two other sources are used to provide
           information that is not directly available from the OLTP 系统. Financial information about
           companies and securities is obtained from a financial newswire (FINWIRE) service that has
           been archived over an extended period of time. This data comes in variable-format 记录
           in files saved in the Staging Area. Customer and account information is retrieved from a
           Customer Management System. Historical CMS information is saved in the Staging Area as
           an XML-formatted extract.

1.2        Summary of Operations
1.2.1      Scope of the 基准测试
           In many real world 系统, it is necessary to integrate data from different types of source
           系统, including different 数据库 vendors. While it would be desirable to include the
           extraction from these often heterogeneous source 系统 in the 基准测试, it is simply an
           intractable problem from a 基准测试 logistics point of view. Hence, TPC-DI models an
           environment where all source 系统 data has been extracted to flat files in a staging area
           before the remainder of the DI process begins. TPC-DI does not attempt to represent the
           wide range of data sources available in the marketplace, but models abstracted data sources
           and measures all 系统 involved in moving and transforming data from the Staging Area to
           the Data Warehouse.
           The use of a staging area in TPC-DI does not limit its relevance as it is common in real world
           DI applications to use staging areas for allowing extracts to be performed on a different
           schedule from the rest of the DI process, for allowing backups of extracts that can be
           returned to in case of failures, and for potentially providing an 审计 trail.
           Figure 1.2-1 shows what parts of the conceptual model are implemented in the 基准测试.




TPC Benchmark™ DI - Standard Specification, Revision 1.1.0                          Page 13 of 117
           Figure 1.2-1: The System Under Test
1.2.2      Phases of operation
           In many real world DI applications, there are two variants of the DI process. One variant
           performs an historical load, at times when the data 仓库 is initially created or when it is
           recreated from historical 记录 such as when the data 仓库 模式 is restructured.
           The second variant performs incremental updates, representing the load of new data into an
           existing data 仓库. There are many different rates at which incremental updates 可
           occur, from rarely to near real-time. Daily updates are common, and are the model for the
           TPC-DI 基准测试.
           Many DI applications have a constrained time window in which they must perform their
           regular updates. Updates are often done as an overnight operation and must fit with
           backups and other activities. At the same time, modern DI 系统 must deal with large
           volumes of historical data. The 基准测试 models both large historical data and constrained
           timing. The 基准测试 consists of several phases which are executed in sequence.
1.2.2.1    Preparation phase
1.2.2.1.1 Data Generation
           Data generation is performed using the data generator described in Clause 6. The data 可
           be generated directly in the Staging Area or it 可 be generated in a different location and
           copied to the Staging Area before the Historical Load. Generating data and copying it to the
           Staging Area are not timed for the 基准测试.



TPC Benchmark™ DI - Standard Specification, Revision 1.1.0                          Page 14 of 117
1.2.2.1.2 Data Warehouse Creation
           Creation of the Data Warehouse 数据库 and 表, including allocation of disk space, is
           not a DI operation and is not timed for the 基准测试.
1.2.2.1.3 Data Integration Preparation
           The data integration 软件 可 require additional preparation and 配置 to
           perform the 基准测试 operations. The work performed in this step will vary among
           implementations, and is not timed for the 基准测试.
1.2.2.2    Historical Load phase
           The Historical Load includes different transformations than the Incremental Updates.
           Destination 表 are initially empty and being populated with new data, and the source files
           可 have different ordering properties (an unload of the data from an OLTP 表 might be in
           主键 订单, while a CDC extract would be in 订单 of the time that changes occurred).
           In addition, there are sources of data that are different from the Incremental Updates. The
           Historical Load naturally uses a larger set of data than an Incremental Update. Following the
           Historical Load, the Validation Query collects certain information that will be used to check
           for correctness in the automated 审计 phase.
           The Historical Load phase 可 run for as much time as needed to completely process the
           data and is timed for use in the computation of the 基准测试 指标.
1.2.2.3    Incremental Update phase
           An Incremental Update includes different transformations than the Historical Load. The
           输入 files from the OLTP 数据库 are modeled as CDC extracts, which show the changes in
           the 表 data since the last extract. The Prospect file is a full data set (not CDC), so it is up to
           the DI application to determine what changes have occurred.
           Two Incremental Update phases are required in a TPC-DI 基准测试 run. By requiring more
           than one Incremental Update, the 基准测试 ensures repeatability. Following each
           Incremental Update, the Validation Query collects certain information that will be used to
           check for correctness in the automated 审计 phase.
           The Incremental Update phases are each required to complete in 30-60 minutes, and are
           timed for use in the computation of the 基准测试 指标.
1.2.2.4    Automated Audit phase
           After all of the other phases are complete, the automated 审计 queries the Data Warehouse
           to perform extensive tests on the resulting data and creates a simple report of the results.
           The automated 审计 phase is not timed, but all tests must pass for the run to be valid.

1.3        Source Data Models
1.3.1      Section 1.1 introduced the concept of the OLTP, HR, Prospects, FINWIRE and Customer
           Management data sources. In addition, there are a small number of reference files that

TPC Benchmark™ DI - Standard Specification, Revision 1.1.0                              Page 15 of 117
           contain data that is loaded only once during the Historical Load and not modified again in the
           基准测试. The 字段 in each source file are described in Clause 2.
1.3.2      The OLTP 数据库 represents a 数据库 with transactional information about securities
           market trading and the entities involved, i.e. customers, accounts, brokers, securities, trade
           details, account balances, market information, and so on. Files used in the Historical Load are
           full extracts containing all the 行 in the 表. Files used as 输入 to an Incremental Update
           are CDC extracts, and as such they contain additional “CDC_FLAG” and “CDC_DSN” 列
           at the beginning of each 行. The CDC_FLAG is a single character I, U or D that tells whether
           the 行 has been inserted, updated or deleted since the last change. For updates there is no
           indication as to what in the 行 has been changed. Rows that have not changed since the
           last extract will not appear in the CDC extract file at all. A 行 可 change multiple times in
           the course of a day. The CDC_DSN is a sequence number, a 值 whose exact 定义 is
           meaningful only to the source 数据库, but will be monotonically increasing in 值
           throughout the 行 in a file. The 行 in a file will be ordered by the CDC_DSN 值, which
           also reflects the time 订单 in which the changes were applied to the 数据库. Files from the
           OLTP 系统 are:
               Account.txt (Incremental Update)
               Customer.txt (Incremental Update)
               Trade.txt (Historical Load and Incremental Update)
               TradeHistory.txt (Historical Load)
               CashTransaction.txt (Historical Load and Incremental Update)
               HoldingHistory.txt (Historical Load and Incremental Update)
               DailyMarket.txt (Historical Load and Incremental Update)
               WatchItem.txt (Historical Load and Incremental Update)
1.3.3      The HR 数据库 is represented by a single extract file, HR.csv. This file contains information
           about the employees of the company and the employee reporting hierarchy. There is no CDC
           on this data source; it is modeled as a full 表 extract for the Historical Load.
1.3.4      The Prospect.csv represents data that is obtained from an external data provider. The file
           contains names, contact information and demographic data on potential customers, some of
           whom are already customers of the brokerage. This file is modeled as a full daily extract from
           the data provider, i.e. there is no indication in the data as to what has changed from the
           previous extract.
1.3.5      There is a FINWIRE file for each quarter of historical data. There are three types of 记录
           that 可 appear in a FINWIRE file, each with a different format. Within a 记录 type the
           字段 are fixed-width. The various 记录 types will provide data for the 表 DimCompany,
           DimSecurity and Financial in the Historical Load phase. One would normally expect updates
           to company and security data while maintaining a data 仓库. However, the number of
           these changes is too small to have a 性能 impact in this 基准测试, so they are not
           considered in the Incremental Update phases.
1.3.6      The CustomerMgmt.xml file represents data extracted from a Customer Management System
           (CMS). The CMS handles new and updated 客户 and account information. The data in
           the file is transactional in nature and uses a hierarchical structure to represent data
TPC Benchmark™ DI - Standard Specification, Revision 1.1.0                          Page 16 of 117
           relationships. This source provides the data for the DimAccount and DimCustomer 表 in
           the Historical Load phase.
1.3.7      Reference data is loaded only during the Historical Load and not modified again in the course
           of the 基准测试. The following files represent the set of reference data for the 基准测试:
               Date.txt
               Time.txt
               Industry.txt
               StatusType.txt
               TaxRate.txt
               TradeType.txt
           Although some of these 表 would be expected to change in the lifetime of a real-world
           系统, they will not change over the lifetime of a 基准测试 run.

1.4        Destination Data Model
           The destination of the TPC-DI 工作负载 is a dimensional data 仓库, such as described in
           The Data Warehouse Toolkit (Ralph Kimball and Margy Ross, Wiley, April 2002). Dimensional
           models are designed to enable efficient responses to a variety of business questions and are
           common practice in the industry. There are other ways to define a data 仓库, but this
           format provides a well understood structure in the 基准测试 Data Warehouse while also
           allowing for an appropriate variety of data transformations to be exercised in the TPC-DI
           工作负载.

                  Fact Tables                  Dimension Tables             Reference Tables
                                    DimTrade                      DimDate        TradeType
                                                    DimCustomer


                                                                                 StatusType
                                                    DimAccount    DimTime


                                                                                  TaxRate
                                                     DimBroker


                                                                                  Industry
                                                    DimSecurity


                                                                                  Financial
                                                    DimCompany




             DI Operational Tables                  DImessages                  Audit

           Figure 1.4-1: Pictorial overview of the Data Warehouse Tables
           In a dimensional model, “dimension 表” describe the business entities of interest. In the
           TPC-DI 基准测试 they are dates (in the DimDate 表), times (DimTime), customers
           (DimCustomer), accounts (DimAccount), brokers (DimBroker), securities (DimSecurity),
TPC Benchmark™ DI - Standard Specification, Revision 1.1.0                         Page 17 of 117
           companies (DimCompany), and trades (DimTrade). “Fact 表” give measurement
           information describing what occurred, such as the 价格 and volume of a 事务, or the
           status of something, such as the number of shares held on a certain 日期. In the TPC-DI
           基准测试 the fact 表 describe holdings (FactHoldings), trades (DimTrade), cash balances
           (FactCashBalances), the market history (FactMarketHistory), and 客户 watches on
           securities (FactWatches). Note that is it possible for certain 表 to serve more than one
           role: The DimTrade 表 is both a dimension 表 and a fact 表, depending on how it is
           being used.

1.5        Transformations
           The term “transformations” in this 基准测试 includes everything that 必须 done to
           prepare and load data into the Data Warehouse. This can include:
               Conversion of data from character representations to data types compatible with the
               Data Warehouse 规范
               Lookups of business keys to obtain surrogate keys for the Data Warehouse
               Merging or formatting multiple 字段 into one, or splitting one 字段 into multiple
               Checking data for errors or for adherence to business 规则
               Detecting changes in dimension data, and applying appropriate tracking mechanisms
               (retaining history or overwriting)
               Detecting changes in fact data, and journaling updates to reflect current state




TPC Benchmark™ DI - Standard Specification, Revision 1.1.0                       Page 18 of 117
1.5.1      Clause 4 gives the detailed transformation 规则 for both the Historical Load and for
           Incremental Updates.

1.6        Result Reporting Classes
1.6.1      In basic data warehousing applications, the data 仓库 is used for data analysis and
           reporting. Data is initially loaded into the data 仓库 and then periodically updated with
           more current information. The data 仓库 might also be rebuilt and reloaded from time
           to time. Typically the data 仓库 is ‘offline’ (i.e. unavailable to end users) during initial
           loads and reloads. Loading and updating the data 仓库 is controlled by a data
           integration process. The end users access the data 仓库 only for querying the data, not
           for updating. Whether or not full ACID 数据库 properties are required in a data 仓库
           is a choice unique to each organization.
1.6.2      To reflect the variety of 系统 used to 实现 data warehouses, TPC-DI defines two
           data 仓库 classes, called ACID and OPEN. The ACID data 仓库 class requires the
           Data Warehouse 系统 to be ACID compliant, while the OPEN class allows the Data
           Warehouse 系统 to adhere to a minimal set of concurrency 要求.
1.6.3      Data Warehouses eligible to run the TPC-DI 基准测试 must meet at least the OPEN class
           criteria. Test sponsors 可 choose to subject their implementations to additional criteria to
           establish eligibility for the ACID class.
1.6.4      Benchmark Results from different classes are not comparable and will be listed separately on
           the TPC website.




TPC Benchmark™ DI - Standard Specification, Revision 1.1.0                           Page 19 of 117
                                     Clause 2: Source Data Files

2.1        Introduction
           This 节 describes the formats of files created by the data generator. The number of
           行 in the files are variable, determined by the data generator based on the Scale Factor
           chosen by the test sponsor.
           Throughout this 基准测试, 输入 日期 值 are written as YYYY-MM-DD unless a specific
           alternate format is given.

2.2        File format definitions
2.2.1      General Formatting definitions
2.2.1.1    The file format definitions refer to a common set of data types, defined in Table 2.2.1, and
           meta-types defined in Table 2.2.2. The DI System needs to be able to parse the base data
           types. The meta-types are all defined in terms of base data types, with names that indicate
           their function and possibly 值 restrictions.
           Rationale: The 输入 data all comes from text files, and in that context all 值 are character sequences.
           These are not “native data types” in the sense that a 数据库 has native data types that it can store, but are
           abstractions that describe the character sequences. These types do however correlate to the data types used in
           节 3.2 to define the Data Warehouse 表.

           Table 2.2.1: Common data type definitions for source data files
            Base Type             Input formatting
            BOOLEAN               “0” for False and “1” for True.
            CHAR(n)               Character string of up to n single-byte characters.
            DATE                  Formatted as “YYYY-MM-DD”, were YYYY is the year, MM is the month
                                  number and DD is the day number. MM and DD will have leading zeroes
                                  when appropriate.
            DATETIME              Formatted as “YYYY-MM-DD HH:MM:SS”, were YYYY is the year, MM is the
                                  month number, DD is the day number, HH is the hour, MM is the minute,
                                  and SS is the second in 24-hour format. Each 零件 of the 值 will have
                                  leading zeroes when appropriate.
            NUM(m[,n])            Unsigned numeric 值 with at most m total Digits, of which up to n Digits
                                  are to the right (after) the decimal point. The length does not exceed m+1
                                  characters, including the decimal point.
            SNUM(m[,n])           Signed numeric 值 with an optional “+” or “-” followed by at most m total
                                  Digits, of which up to n Digits are to the right (after) the decimal point. The
                                  length does not exceed m+2 characters, including the sign and decimal point.
                                  If there is no sign, the 值 is positive.

           Table 2.2.2: Meta-type definitions for source data files
            Meta Type         Base Type           Usage / Restrictions
            BALANCE_T         SNUM(12,2)          Aggregate account and 事务 related 值 such as

TPC Benchmark™ DI - Standard Specification, Revision 1.1.0                                       Page 20 of 117
                                                account balances, total commissions, etc.
            CDC_FLAG_T        CHAR(1)           “I”, “U” or “D” for insert, update or delete
            CDC_DSN_T         NUM(12)           Database Sequence Number, a monotonically increasing
                                                值
            IDENT_T           NUM(11)           Numeric identifiers
            S_COUNT_T         NUM(12)           Aggregate count of shares
            S_PRICE_T         SNUM(8,2)         Share prices
            S_QTY_T           NUM(6)            Quantity of shares for an individual trade
            TRADE_T           NUM(15)           Trade identifiers
            VALUE_T           SNUM(10,2)        Non-aggregated 事务 and security related 值 such
                                                as 成本, dividend, etc.
2.2.1.2    The character set encoding for all generated source data files is single-byte UTF-8.
2.2.1.3    Unless specifically mentioned, the 行 in all generated files are not sorted in any particular
           订单.
2.2.2      Specific file format definitions
2.2.2.1    Account.txt
2.2.2.1.1 The Account.txt file is a plain-text file with variable length 字段 separated by a vertical bar
          (“|”). Records have a terminator character appropriate for the System Under Test. Null
          值, where allowed, are indicated by there being no characters between vertical bars.
2.2.2.1.2 Rows are ordered by the CDC_DSN 字段.
           Table 2.2.3: Account.txt file 字段
            Field Name     Type               Restrictions        Description / Explanation
            CDC_FLAG       CDC_FLAG_T         ‘I’ or ‘U’          Denotes insert or update
            CDC_DSN        CDC_DSN_T          Not NULL            Database Sequence Number
            CA_ID          IDENT_T            Not NULL            Customer account identifier
            CA_B_ID        IDENT_T            Not NULL            Identifier of the managing broker
            CA_C_ID        IDENT_T            Not NULL            Owning 客户 identifier
            CA_NAME        CHAR(50)                               Name of 客户 account
            CA_TAX_ST      NUM(1)             0, 1 or 2           Tax status of this account
            CA_ST_ID       CHAR(4)            ‘ACTV’ or ‘INAC’    Customer status type identifier
2.2.2.2    BatchDate.txt
2.2.2.2.1 This file has a single 行 with a single 字段 containing the 日期 of extraction of the data files
          in the Staging Area, formatted as YYYY-MM-DD. This 日期 will be referred to as the Batch
          Date elsewhere in the 规范.
           Table 2.2.4: BatchDate.txt file 字段
            Field Name      Type    Restrictions        Description / Explanation
            BatchDate       DATE    Not NULL            Date of the data batch in the Staging Area
2.2.2.3    CashTransaction.txt
           The CashTransaction.txt file is a plain-text file with variable length 字段 separated by a
           vertical bar (“|”). Records have a terminator character appropriate for the System Under


TPC Benchmark™ DI - Standard Specification, Revision 1.1.0                                    Page 21 of 117
           Test. The CDC_FLAG and CDC_DSN 字段 are not present in the data set used by the
           Historical Load.
2.2.2.3.1 For Incremental Updates this file is ordered by CDC_DSN.
           Table 2.2.5: CashTransaction.txt file 字段
            Field Name    Type            Restrictions   Description / Explanation
            CDC_FLAG      CDC_FLAG_T      ‘I’            Denotes insert
            CDC_DSN       CDC_DSN_T       Not NULL       Database Sequence Number
            CT_CA_ID      IDENT_T         Not Null       Customer account identifier
            CT_DTS        DATETIME        Not Null       Timestamp of when the trade took place
            CT_AMT        VALUE_T         Not Null       Amount of the cash 事务.
            CT_NAME       CHAR(100)       Not Null       Transaction name, or 说明: e.g. “Cash
                                                         from sale of DuPont stock”.
2.2.2.4    Customer.txt
           The Customer.txt file is a plain-text file with variable length 字段 separated by a vertical bar
           (“|”). Records have a terminator character appropriate for the System Under Test. This file
           is not used by the Historical Load. Null 值, where allowed, are indicated by there being
           no characters between vertical bars.
2.2.2.4.1 Customer.txt is ordered by CDC_DSN.
           Table 2.2.6: Customer.txt file 字段
            Field Name      Type          Restrictions    Description / Explanation
            CDC_FLAG        CDC_FLAG_T    ‘I’ or ‘U’      Denotes insert or update
            CDC_DSN         CDC_DSN_T     Not NULL        Database Sequence Number
            C_ID            IDENT_T       Not NULL        Customer identifier
            C_TAX_ID        CHAR(20)      Not NULL        Customer’s 税 identifier
            C_ST_ID         CHAR(4)       ‘ACTV’ or       Customer status type identifier
                                          ‘INAC’
            C_L_NAME        CHAR(25)      Not NULL        Primary Customer's last name.
            C_F_NAME        CHAR(20)      Not NULL        Primary Customer's first name.
            C_M_NAME        CHAR(1)                       Primary Customer's middle initial
            C_GNDR          CHAR(1)                       Gender of the primary 客户
            C_TIER          NUM(1)                        Customer tier
            C_DOB           DATE          Not NULL        Customer’s 日期 of birth, as YYYY-MM-DD.
            C_ADLINE1       CHAR(80)      Not NULL        Address Line 1
            C_ADLINE2       CHAR(80)                      Address Line 2
            C_ZIPCODE       CHAR(12)      Not NULL        Zip or postal code
            C_CITY          CHAR(25)      Not NULL        City
            C_STATE_PRO     CHAR(20)      Not NULL        State or province
            V
            C_CTRY          CHAR(24)                      Country
            C_CTRY_1        CHAR(3)                       Country code for Customer's phone 1.
            C_AREA_1        CHAR(3)                       Area code for 客户’s phone 1.
            C_LOCAL_1       CHAR(10)                      Local number for 客户’s phone 1.
            C_EXT_1         CHAR(5)                       Extension number for Customer’s phone 1.
            C_CTRY_2        CHAR(3)                       Country code for Customer's phone 2.
TPC Benchmark™ DI - Standard Specification, Revision 1.1.0                                  Page 22 of 117
            C_AREA_2         CHAR(3)                       Area code for Customer’s phone 2.
            C_LOCAL_2        CHAR(10)                      Local number for Customer’s phone 2.
            C_EXT_2          CHAR(5)                       Extension number for Customer’s phone 2.
            C_CTRY_3         CHAR(3)                       Country code for Customer's phone 3.
            C_AREA_3         CHAR(3)                       Area code for Customer’s phone 3.
            C_LOCAL_3        CHAR(10)                      Local number for Customer’s phone 3.
            C_EXT_3          CHAR(5)                       Extension number for Customer’s phone 3.
            C_EMAIL_1        CHAR(50)                      Customer's e-mail address 1.
            C_EMAIL_2        CHAR(50)                      Customer's e-mail address 2.
            C_LCL_TX_ID      CHAR(4)       Not NULL        Customer's local 税 rate
            C_NAT_TX_ID      CHAR(4)       Not NULL        Customer's national 税 rate


2.2.2.5    CustomerMgmt.xml
           CustomerMgmt.xml is an XML document, i.e. an XML formatted file, representing actions
           resulting in new or changed 客户 and account information. This file is only used in the
           Historical Load to populate the DimAccount and DimCustomer 表. The data in the
           document is ordered in time sequence.
2.2.2.5.1 The document consists of a set of Action data elements. Each Action specifies an ActionType
          and is related to an Account and/or a Customer. All Actions have at least a related Customer,
          and all Accounts are associated with a single Customer. The document uses a hierarchical
          structure to represent the relationship between these data elements.


2.2.2.5.2 The data 字段 and properties of their 值 are provided in the 表 below. In the XML
          document, these data 字段 are manifested as attributes or contained (nested) elements.
          The 表 describes the characteristics of the 值 supplied in these data 字段. Empty
          elements are expressed as an empty XML tag, e.g. <Element />.
           Table 2.2.7: CustomerMgmt element properties
            Field Name              Type              Restrictions        Description / Explanation
            Action                  XML Element                           XML element containing the
                                                                          following attributes and
                                                                          elements
            Action Attributes:
              ActionType            CHAR(9)           ’NEW’,              One of:
                                                      ‘ADDACCT’,          NEW – A new 客户. A
                                                                          new 客户 is always
                                                      ‘UPDCUST’,
                                                                          created with 1 or more
                                                      ‘UPDACCT’,          accounts.
                                                      ‘CLOSEACCT’,        ADDACCT – One or more new
                                                                          accounts for an existing
                                                      ‘INACT’
                                                                          客户.
                                                                          UPDACCT – Changes to one or

TPC Benchmark™ DI - Standard Specification, Revision 1.1.0                                 Page 23 of 117
                                                                        more existing accounts.
                                                                        UPDCUST – A change to an
                                                                        existing 客户.
                                                                        CLOSEACCT – Close one or
                                                                        more existing accounts.
                                                                        INACT – An existing 客户
                                                                        has become inactive.
              ActionTS              CHAR            Not empty           Date and time of the action as
                                                                        YYYY-MM-DDTHH:MM:SS .
                                                                        Note the ‘T’ is a literal 值.
            Action Contained Element:
            Customer                XML Element                         XML element contained by
                                                                        Action, and containing the
                                                                        following attributes and
                                                                        elements
            Customer Attributes:
                C_ID                IDENT_T         Not empty,          Customer identifier
                                                    Required
                C_TAX_ID            CHAR(20)        Not empty,          Customer’s 税 identifier
                                                    Required on ‘NEW’
                C_GNDR              CHAR(1)         Not empty           Gender of the 客户
                C_TIER              NUM(1)          Not empty           Customer tier
                C_DOB               DATE            Not empty,          Customer’s 日期 of birth as
                                                                        YYYY-MM-DD
                                                    Required on ‘NEW’
                C_ID                IDENT_T         Not empty,          Customer identifier
                                                    Required
            Customer Contained Elements:
            Name                    XML Element                         XML element contained by
                                                                        Customer, and containing the
                                                                        following attributes
            Name Attributes:
                   C_L_NAME         CHAR(25)        Not empty,          Customer's last name.
                                                    Required on ‘NEW’
                   C_F_NAME         CHAR(20)        Not empty,          Customer's first name.
                                                    Required on ‘NEW’
                   C_M_NAME         CHAR(1)                             Customer's middle initial
            Address                 XML Element                         XML element contained by
                                                                        Customer, and containing the

TPC Benchmark™ DI - Standard Specification, Revision 1.1.0                                Page 24 of 117
                                                                         following attributes
            Address Attributes:
                  C_ADLINE1           CHAR(80)       Not empty,          Address Line 1
                                                     Required on ‘NEW’
                  C_ADLINE2           CHAR(80)                           Address Line 2
                  C_ZIPCODE           CHAR(12)       Not empty,          Zip or postal code
                                                     Required on ‘NEW’
                  C_CITY              CHAR(25)       Not empty,          City
                                                     Required on ‘NEW’
                  C_STATE_PROV        CHAR(20)       Not empty,          State or province
                                                     Required on ‘NEW’
                  C_CTRY              CHAR(24)                           Country
            ContactInfo               XML Element                        XML element contained by
                                                                         Customer, and containing the
                                                                         following attributes
            ContactInfo Attributes:
                  C_PRIM_EMAIL        CHAR(50)                           Customer's primary e-mail
                                                                         address
                  C_ALT_EMAIL         CHAR(50)                           Customer's alternate e-mail
                                                                         address
                  C_PHONE_1           PhoneNumber*                       Customer’s primary phone
                                                                         number
                  C_PHONE_2           PhoneNumber*                       Customer’s secondary phone
                                                                         number
                  C_PHONE_3           PhoneNumber*                       Customer’s third phone
                                                                         number
            TaxInfo                   XML Element                        XML element contained by
                                                                         Customer, and containing the
                                                                         following attributes
            TaxInfo Attributes:
                  C_LCL_TX_ID         CHAR(4)                            Customer's local 税 rate
                  C_NAT_TX_ID         CHAR(4)                            Customer's national 税 rate
            Account                   XML Element                        XML element contained by
                                                                         Customer, and containing the
                                                                         following attributes and
                                                                         elements
            Account Attributes:
                  CA_ID               IDENT_T        Not empty,          Customer account identifier

TPC Benchmark™ DI - Standard Specification, Revision 1.1.0                                   Page 25 of 117
                                                    Required
                  CA_TAX_ST         NUM(1)          Not empty,          Tax status of this account
                                                    Required on ‘NEW’
            Account Contained Elements:
                  CA_B_ID           IDENT_T         Not empty,          Identifier of the managing
                                                                        broker
                                                    Required on ‘NEW’
                  CA_NAME           CHAR(50)                            Name of 客户 account




2.2.2.5.3 The PhoneNumber data type is defined within the scope of the CustomerMgmt XML Schema
          and used to define Action.Customer.ContactInfo.C_PHONE_1,
          Action.Customer.ContactInfo.C_PHONE_2, and Action.Customer.ContactInfo.C_PHONE_3.


            PhoneNumber             XML Type                            Defined within the scope of
                                                                        the CustomerMgmt 模式.
            PhoneNumber Contained Elements:
              C_CTRY_CODE           CHAR(3)                             Country code for Customer's
                                                                        phone
              C_AREA_CODE           CHAR(3)                             Area code for 客户’s
                                                                        phone
              C_LOCAL               CHAR(10)                            Local number for 客户’s
                                                                        phone
              C_EXT                 CHAR(5)                             Extension number for
                                                                        Customer’s phone




TPC Benchmark™ DI - Standard Specification, Revision 1.1.0                                Page 26 of 117
2.2.2.5.4 For each action, only required properties are supplied. For 示例, a ‘NEW’ action will
          contain 客户 identifying information, many properties (e.g. name, address), and one or
          more sets of account information. In contrast, an update action 可 update one or more
          客户 or account properties. For that action, only the properties used to identify the
          account and/or 客户, and the updated properties will be supplied, the other properties
          will be omitted from the XML document.
2.2.2.5.5 The structure of the XML document is described by an XML Schema (xsd). The XML 模式
          can be used to parse and validate the XML document. Note that the XML 模式 可 not
          enforce all of the data constraints defined in 表 2.2.7. While the XML 模式 定义
          allows for more variation in the data 值, the data used by the 基准测试 will conform to
          the characteristics described in 表 2.2.8.
2.2.2.5.6 The formal XML Schema 定义 is provided here:
           CustomerMgmt XML 模式 定义
           <xsd:模式 targetNamespace="http://www.tpc.org/tpc-di"
           xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:TPCDI="http://www.tpc.org/tpc-di">
             <xsd:element name="Action" type="TPCDI:ActionDef" />
             <xsd:element name="Actions">
               <xsd:complexType>
                 <xsd:sequence>
                   <xsd:element ref="TPCDI:Action" maxOccurs="unbounded" />
                 </xsd:sequence>
               </xsd:complexType>
             </xsd:element>
             <xsd:complexType name="ActionDef">
               <xsd:all>
                 <xsd:element name="Customer" minOccurs="1" maxOccurs="1">
                   <xsd:complexType>
                     <xsd:sequence>
                       <xsd:element name="Name" minOccurs="0" >
                         <xsd:complexType>
                            <xsd:all>
                              <xsd:element name="C_L_NAME" type="xsd:string" />
                              <xsd:element name="C_F_NAME" type="xsd:string" />
                              <xsd:element name="C_M_NAME" type="xsd:string" minOccurs="0" />
                            </xsd:all>
                         </xsd:complexType>
                       </xsd:element>
                       <xsd:element name="Address" minOccurs="0">
                         <xsd:complexType>
                            <xsd:all>
                              <xsd:element name="C_ADLINE1" type="xsd:string" />
                              <xsd:element name="C_ADLINE2" type="xsd:string" minOccurs="0" />
                              <xsd:element name="C_ZIPCODE" type="xsd:string" />
                              <xsd:element name="C_CITY" type="xsd:string" />
                              <xsd:element name="C_STATE_PROV" type="xsd:string" />
                              <xsd:element name="C_CTRY" type="xsd:string" />
                            </xsd:all>
                         </xsd:complexType>
                       </xsd:element>
                       <xsd:element name="ContactInfo" minOccurs="0">
                         <xsd:complexType>
                            <xsd:all>
                              <xsd:element name="C_PRIM_EMAIL" type="xsd:string" minOccurs="0" />
                              <xsd:element name="C_ALT_EMAIL" type="xsd:string" minOccurs="0" />
                              <xsd:element name="C_PHONE_1" type="TPCDI:PhoneNumber" minOccurs="0" />
                              <xsd:element name="C_PHONE_2" type="TPCDI:PhoneNumber" minOccurs="0" />
                              <xsd:element name="C_PHONE_3" type="TPCDI:PhoneNumber" minOccurs="0" />
                            </xsd:all>
                         </xsd:complexType>
                       </xsd:element>

TPC Benchmark™ DI - Standard Specification, Revision 1.1.0                          Page 27 of 117
                       <xsd:element name="TaxInfo" minOccurs="0">
                          <xsd:complexType>
                            <xsd:all>
                              <xsd:element name="C_LCL_TX_ID" type="xsd:string" />
                              <xsd:element name="C_NAT_TX_ID" type="xsd:string" />
                            </xsd:all>
                          </xsd:complexType>
                       </xsd:element>
                       <xsd:element name="Account" minOccurs="0" maxOccurs=”unbounded”>
                          <xsd:complexType>
                            <xsd:all>
                              <xsd:element name="CA_B_ID" type="xsd:string" minOccurs="0" />
                              <xsd:element name="CA_NAME" type="xsd:string" minOccurs="0" />
                            </xsd:all>
                            <xsd:属性 name="CA_ID" type="xsd:string" use="required" />
                            <xsd:属性 name="CA_TAX_ST" type="xsd:string" />
                          </xsd:complexType>
                       </xsd:element>
                     </xsd:sequence>
                     <xsd:属性 name="C_ID" type="xsd:string" use="required" />
                     <xsd:属性 name="C_TAX_ID" type="xsd:string" />
                     <xsd:属性 name="C_GNDR" type="xsd:string" />
                     <xsd:属性 name="C_TIER" type="xsd:unsignedByte" />
                     <xsd:属性 name="C_DOB" type="xsd:日期" />
                   </xsd:complexType>
                 </xsd:element>
               </xsd:all>
               <xsd:属性 name="ActionType" type="xsd:string" />
               <!-- restrict to certain 值? -->
               <xsd:属性 name="ActionTS" type="xsd:dateTime" />
               <!-- yyyy-mm-dd -->
             </xsd:complexType>
             <xsd:complexType name="PhoneNumber">
               <xsd:sequence>
                 <xsd:element name="C_CTRY_CODE" type="xsd:string" minOccurs="0" />
                 <xsd:element name="C_AREA_CODE" type="xsd:string" />
                 <xsd:element name="C_LOCAL" type="xsd:string" />
                 <xsd:element name="C_EXT" type="xsd:string" minOccurs="0" />
               </xsd:sequence>
             </xsd:complexType>
           </xsd:模式>
2.2.2.6    DailyMarket.txt
           The DailyMarket.txt file is a plain-text file with variable length 字段 separated by a vertical
           bar (“|”). Records have a terminator character appropriate for the System Under Test. The
           CDC_FLAG and CDC_DSN 字段 are not present in the data set used by the Historical Load.
2.2.2.6.1 This file is ordered by CDC_DSN for Incremental Updates.
           Table 2.2.10: DailyMarket.txt file 字段
            Field Name        Type              Restrictions   Description / Explanation
            CDC_FLAG          CDC_FLAG_T        ‘I’            Denotes insert
            CDC_DSN           CDC_DSN_T         Not NULL       Database Sequence Number
            DM_DATE           DATE              Not Null       Date of last completed trading day.
            DM_S_SYMB         CHAR(15)          Not Null       Security symbol of the security
            DM_CLOSE          S_PRICE_T         Not Null       Closing 价格 of the security on this day.
            DM_HIGH           S_PRICE_T         Not Null       Highest 价格 for the secuirity on this day.
            DM_LOW            S_PRICE_T         Not Null       Lowest 价格 for the security on this day.
            DM_VOL            S_COUNT_T         Not Null       Volume of the security on this day.




TPC Benchmark™ DI - Standard Specification, Revision 1.1.0                                 Page 28 of 117
2.2.2.7    Date.txt
           The Date.txt file is a plain-text file with variable length 字段 separated by a vertical bar (“|”).
           Records have a terminator character appropriate for the System Under Test. Null 值,
           where allowed, are indicated by there being no characters between vertical bars.
2.2.2.7.1 This file is ordered by the SK_DateID 字段.
           Table 2.2.11: Date file 字段
            Field Name            Type         Restrictions   Description / Explanation
            SK_DateID             IDENT_T      Not NULL       Surrogate key for the 日期
            DateValue             CHAR(20)     Not NULL       The 日期 as text, e.g. “2004-07-07”
            DateDesc              CHAR(20)     Not NULL       The 日期 Month Day, YYYY, e.g. July 7, 2004
            CalendarYearID        NUM(4)       Not NULL       Year number as a number
            CalendarYearDesc      CHAR(20)     Not NULL       Year number as text
            CalendarQtrID         NUM(5)       Not NULL       Quarter as a number, e.g. 20042
            CalendarQtrDesc       CHAR(20)     Not NULL       Quarter as text, e.g. “2004 Q2”
            CalendarMonthID       NUM(6)       Not NULL       Month as a number, e.g. 20047
            CalendarMonthDesc     CHAR(20)     Not NULL       Month as text, e.g. “2004 July”
            CalendarWeekID        NUM(6)       Not NULL       Week as a number, e.g. 200428
            CalendarWeekDesc      CHAR(20)     Not NULL       Week as text, e.g. “2004-W28”
            DayOfWeekNum          NUM(1)       Not NULL       Day of week as a number, e.g. 3
            DayOfWeekDesc         CHAR(10)     Not NULL       Day of week as text, e.g. “Wednesday”
            FiscalYearID          NUM(4)       Not NULL       Fiscal year as a number, e.g. 2005
            FiscalYearDesc        CHAR(20)     Not NULL       Fiscal year as text, e.g. “2005”
            FiscalQtrID           NUM(5)       Not NULL       Fiscal quarter as a number, e.g. 20051
            FiscalQtrDesc         CHAR(20)     Not NULL       Fiscal quarter as text, e.g. “2005 Q1”
            HolidayFlag           BOOLEAN                     Indicates holidays


2.2.2.8    FINWIRE
           Data from a “financial newswire” has been recorded over time, and stored in files with a new
           file being created each quarter using names like FINWIRE2003Q1, FINWIRE2003Q2, etc. The
           formatting of 记录 in the file depends on the type of 记录, as indicated by three
           characters of each 记录 starting at 列 16. Records of any type 可 appear in any
           订单 in the file. Records have a terminator character appropriate for the System Under
           Test.
           There are three 记录 types in FINWIRE files: ‘CMP’, ‘SEC’, and ‘FIN’. There are no 字段
           separators in these files; each of the 记录 types contains fixed-width 字段 with the
           exception that in some cases the last 字段 可 contain a company name (60 characters) or a
           CIK number (10 digits). Where dates appear, they are formatted as YYYYMMDD. Each 记录
           begins with a Posting Time Stamp (PTS) showing when the 记录 was originally posted on
           the FINWIRE; the format of a PTS is YYYYMMDD-HHMMSS using 24-hour time. Records in
           each FINWIRE file are in increasing 订单 of the PTS.
           All 字段 listed in the 表 below will be as wide as given in the Type 列. Text 字段 will
           be padded with spaces on the right and numeric 字段 will be padded with spaces on the left.
TPC Benchmark™ DI - Standard Specification, Revision 1.1.0                                  Page 29 of 117
           Where CIK numbers appear, they are padded with leading zeroes on the left to fill out the 10-
           character width. An “empty” 字段 is padded with all spaces.
           Table 2.2.8: FINWIRE file 字段
            Field Name        Type        Restrictions   Description / Explanation

            CMP 记录
            PTS               CHAR(15)    Not empty      Posting 日期 & time as YYYYMMDD-HHMMSS
            RecType           CHAR(3)     Not empty      “CMP”
            CompanyName       CHAR(60)    Not empty      Name of the company
            CIK               CHAR(10)    Not empty      Company identification code from SEC
            Status            CHAR(4)     Not empty      ‘ACTV’ for Active company, ‘INAC’ for inactive
            IndustryID        CHAR(2)     Not empty      Code for industry segment
            SPrating          CHAR(4)     Not empty      S&P rating
            FoundingDate      CHAR(8)                    A 日期 as YYYYMMDD
            AddrLine1         CHAR(80)    Not empty      Mailing address
            AddrLine2         CHAR(80)                   Mailing address
            PostalCode        CHAR(12)    Not empty      Mailing address
            City              CHAR(25)    Not empty      Mailing address
            StateProvince     CHAR(20)    Not empty      Mailing address
            Country           CHAR(24)                   Mailing address
            CEOname           CHAR(46)    Not empty      Name of company CEO
            Description       CHAR(150)   Not empty      Description of the company

            SEC 记录
            PTS               CHAR(15)    Not empty      Posting 日期 & time as YYYYMMDD-HHMMSS
            RecType           CHAR(3)     Not empty      “SEC”
            Symbol            CHAR(15)    Not empty      Security symbol
            IssueType         CHAR(6)     Not empty      Issue type
            Status            CHAR(4)     Not empty      ‘ACTV’ for Active security, ‘INAC’ for inactive
            Name              CHAR(70)    Not empty      Security name
            ExID              CHAR(6)     Not empty      ID of the exchange the security is traded on
            ShOut             CHAR(13)    Not empty      Number of shares outstanding
            FirstTradeDate    CHAR(8)     Not empty      Date of first trade as YYYYMMDD
            FirstTradeExchg   CHAR(8)     Not empty      Date of first trade on exchange as YYYYMMDD
            Dividend          CHAR(12)    Not empty      Dividend as VALUE_T
            CoNameOrCIK       CHAR(60     Not empty      Company CIK number (if only digits, 10 chars) or
                              or 10)                     name (if not only digits, 60 chars)
            FIN 记录
            PTS               CHAR(15)    Not empty      Posting 日期 & time as YYYYMMDD-HHMMSS
            RecType           CHAR(3)     Not empty      “FIN”
            Year              CHAR(4)     Not empty      Year of the quarter end.
            Quarter           CHAR(1)     Not empty      Quarter number: valid 值 are ‘1’, ‘2’, ‘3’, ‘4’
            QtrStartDate      CHAR(8)     Not empty      Start 日期 of quarter, as YYYYMMDD
            PostingDate       CHAR(8)     Not empty      Posting 日期 of quarterly report as YYYYMMDD
            Revenue           CHAR(17)    Not empty      Reported 收入 for the quarter
            Earnings          CHAR(17)    Not empty      Net earnings reported for the quarter

TPC Benchmark™ DI - Standard Specification, Revision 1.1.0                                       Page 30 of 117
            EPS              CHAR(12)    Not empty      Basic earnings per share for the quarter
            DilutedEPS       CHAR(12)    Not empty      Diluted earnings per share for the quarter
            Margin           CHAR(12)    Not empty      Profit divided by revenues for the quarter
            Inventory        CHAR(17)    Not empty      Value of inventory on hand at end of quarter
            Assets           CHAR(17)    Not empty      Value of total assets at the end of quarter
            Liabilities      CHAR(17)    Not empty      Value of total liabilities at the end of quarter
            ShOut            CHAR(13)    Not empty      Average number of shares outstanding
            DilutedShOut     CHAR(13)    Not empty      Average number of shares outstanding (diluted)
            CoNameOrCIK      CHAR(60     Not empty      Company CIK number (if only digits, 10 chars) or
                             or 10)                     name (if not only digits, 60 chars)


2.2.2.9    HoldingHistory.txt
           The HoldingHistory.txt file is a plain-text file with variable length 字段 separated by a vertical
           bar (“|”). Records have a terminator character appropriate for the System Under Test. The
           CDC_FLAG and CDC_DSN 字段 are not present in the data set used by the Historical Load.
2.2.2.9.1 This file is ordered by CDC_DSN for Incremental Updates.
           Table 2.2.9: HoldingHistory.txt file 字段
            Field Name        Type              Restrictions      Description / Explanation
            CDC_FLAG          CDC_FLAG_T        ‘I’               Denotes insert
            CDC_DSN           CDC_DSN_T         Not NULL          Database Sequence Number
            HH_H_T_ID         TRADE_T           Not Null          Trade Identifier of the trade that originally
                                                                  created the holding 行.
            HH_T_ID           TRADE_T           Not Null          Trade Identifier of the current trade
            HH_BEFORE_QTY     S_QTY_T           Not Null          Quantity of this security held before the
                                                                  modifying trade.
            HH_AFTER_QTY      S_QTY_T           Not Null          Quantity of this security held after the
                                                                  modifying trade.


2.2.2.10   HR.csv
           The HR.csv file is a plain-text file with variable length 字段 separated by a comma (“,”).
           Records have a terminator character appropriate for the System Under Test. Null 值,
           where allowed, are indicated by there being no characters between commas.
2.2.2.10.1 This file is ordered by EmployeeID.
           Table 2.2.10: HR.csv file 字段
             Field Name              Type          Restrictions       Description / Explanation
             EmployeeID              IDENT_T       Not NULL           ID of employee
             ManagerID               IDENT_T       Not NULL           ID of employee’s manager
             EmployeeFirstName       CHAR(30)      Not NULL           First name
             EmployeeLastName        CHAR(30)      Not NULL           Last name
             EmployeeMI              CHAR(1)                          Middle initial
             EmployeeJobCode         NUM(3)                           Numeric job code
             EmployeeBranch          CHAR(30)                         Facility in which employee has office
TPC Benchmark™ DI - Standard Specification, Revision 1.1.0                                       Page 31 of 117
             EmployeeOffice         CHAR(10)                    Office number or 说明
             EmployeePhone          CHAR(14)                    Employee phone number
2.2.2.11   Industry.txt
           The Industry.txt file is a plain-text file with variable length 字段 separated by a vertical bar
           (“|”). Records have a terminator character appropriate for the System Under Test.
               Table 2.2.11: Industry.txt file 字段
            Field Name             Type          Restrictions   Description / Explanation
            IN_ID                  CHAR(2)       Not NULL       Industry code
            IN_NAME                CHAR(50)      Not NULL       Industry 说明
            IN_SC_ID               CHAR(4)       Not NULL       Sector identifier


2.2.2.12   Prospect.csv
           The Prospect.csv file is a plain-text file with variable length 字段 separated by a comma (“,”).
           Records have a terminator character appropriate for the System Under Test. Null 值,
           where allowed, are indicated by there being no characters between commas.
           Table 2.2.12: Prospect.csv file 字段
            Field Name            Type          Restrictions    Description / Explanation
            AgencyID              CHAR(30)      Not NULL        Unique identifier from agency
            LastName              CHAR(30)      Not NULL        Last name
            FirstName             CHAR(30)      Not NULL        First name
            MiddleInitial         CHAR(1)                       Middle initial
            Gender                CHAR(1)                       ‘M’ or ‘F’ or ‘U’
            AddressLine1          CHAR(80)                      Postal address
            AddressLine2          CHAR(80)                      Postal address
            PostalCode            CHAR(12)                      Postal code
            City                  CHAR(25)      Not NULL        City
            State                 CHAR(20)      Not NULL        State or province
            Country               CHAR(24)                      Postal country
            Phone                 CHAR(30)                      Telephone number
            Income                NUM(9)                        Annual income
            NumberCars            NUM(2)                        Cars owned
            NumberChildren        NUM(2)                        Dependent children
            MaritalStatus         CHAR(1)                       ‘S’ or ‘M’ or ‘D’ or ‘W’ or ‘U’
            Age                   NUM(3)                        Current age
            CreditRating          NUM(4)                        Numeric rating
            OwnOrRentFlag         CHAR(1)                       ‘O’ or ‘R’ or ‘U’
            Employer              CHAR(30)                      Name of employer
            NumberCreditCards     NUM(2)                        Credit cards
            NetWorth              NUM(12)                       Estimated total net worth


2.2.2.13   StatusType.txt
           The StatusType.txt file is a plain-text file with variable length 字段 separated by a vertical bar
           (“|”). Records have a terminator character appropriate for the System Under Test.
TPC Benchmark™ DI - Standard Specification, Revision 1.1.0                                  Page 32 of 117
           Table 2.2.13: StatusType.txt file 字段
            Field Name         Type              Restrictions             Description / Explanation
            ST_ID              CHAR(4)           Not NULL                 Status code
            ST_NAME            CHAR(10)          Not NULL                 Status 说明
2.2.2.14   TaxRate.txt
           The TaxRate.txt file is a plain-text file with variable length 字段 separated by a vertical bar
           (“|”). Records have a terminator character appropriate for the System Under Test.
           Table 2.2.14: TaxRate.txt file 字段
             Field Name        Type             Restrictions         Description / Explanation
             TX_ID             CHAR(4)          Not NULL             Tax rate code
             TX_NAME           CHAR(50)         Not NULL             Tax rate 说明
             TX_RATE           NUM(6,5)         Not NULL             Tax rate
2.2.2.15   Time.txt
           The Time.txt file is a plain-text file with variable length 字段 separated by a vertical bar (“|”).
           Records have a terminator character appropriate for the System Under Test. Null 值,
           where allowed, are indicated by there being no characters between vertical bars.
2.2.2.15.1 This file is ordered by the SK_TimeID 字段. Hour 值 are based on 24-hour time.
           Table 2.2.12: Time.txt file 字段
             Field Name         Type             Restrictions       Description / Explanation
             SK_TimeID          IDENT_T          Not NULL           Surrogate key for the time
             TimeValue          CHAR(20)         Not NULL           The time as text, e.g. “01:23:45”
             HourID             NUM(2)           Not NULL           Hour number as a number, e.g. 01
             HourDesc           CHAR(20)         Not NULL           Hour number as text, e.g. “01”
             MinuteID           NUM(2)           Not NULL           Minute as a number, e.g. 23
             MinuteDesc         CHAR(20)         Not NULL           Minute as text, e.g. “01:23”
             SecondID           NUM(2)           Not NULL           Second as a number, e.g. 45
             SecondDesc         CHAR(20)         Not NULL           Second as text, e.g. “01:23:45”
             MarketHoursFlag    BOOLEAN                             Indicates a time during market hours
             OfficeHoursFlag    BOOLEAN                             Indicates a time during office hours


2.2.2.16   TradeHistory.txt
           The TradeHistory.txt file is a plain-text file with variable length 字段 separated by a vertical
           bar (“|”). Records have a terminator character appropriate for the System Under Test. This
           file is used only in the Historical Load.
2.2.2.16.1 This file is ordered by the TH_T_ID 字段.
           Table 2.2.15: TradeHistory file 字段
             Column Name       Data Type    Constraints         Description
             TH_T_ID           TRADE_T      Not Null            Trade identifier. Corresponds to T_ID in the
                                                                Trade.txt file
              TH_DTS           DATETIME     Not Null            When the trade history was updated.
TPC Benchmark™ DI - Standard Specification, Revision 1.1.0                                       Page 33 of 117
              TH_ST_ID        CHAR(4)        Not Null         Status type identifier.
2.2.2.17   Trade.txt
           The Trade.txt file is a plain-text file with variable length 字段 separated by a vertical bar
           (“|”). Records have a terminator character appropriate for the System Under Test. The
           CDC_FLAG and CDC_DSN 字段 are not present in the data set used by the Historical Load.
           Null 值, where allowed, are indicated by there being no characters between vertical bars.
2.2.2.17.1 Rows in Historical Load files are ordered by the T_ID 字段; 行 in the Incremental Update
           files are ordered by CDC_DSN.
           Table 2.2.16: Trade.txt file 字段
            Column Name      Data Type        Constraints               Description
            CDC_FLAG         CDC_FLAG_T       ‘I’, ‘U’                  Denotes insert, update
            CDC_DSN          CDC_DSN_T        Not NULL                  Database Sequence Number
            T_ID             TRADE_T          Not Null                  Trade identifier.
            T_DTS            DATETIME         Not Null                  Date and time of trade.
            T_ST_ID          CHAR(4)          Not Null                  Status type identifier
            T_TT_ID          CHAR(3)          Not Null                  Trade type identifier
            T_IS_CASH        BOOLEAN          ‘0’ or ’1’                Is this trade a cash (‘1’) or margin (‘0’)
                                                                        trade?
            T_S_SYMB         CHAR(15)         Not Null                  Security symbol of the security
            T_QTY            S_QTY_T          >0                        Quantity of securities traded.
            T_BID_PRICE      S_PRICE_T        >0                        The requested unit 价格.
            T_CA_ID          IDENT_T          Not Null                  Customer account identifier.
            T_EXEC_NAME      CHAR(49)         Not Null                  Name of the person executing the
                                                                        trade.
            T_TRADE_PRICE    S_PRICE_T        Null except in CMPT       Unit 价格 at which the security was
                                              记录, then > 0         traded.
            T_CHRG           VALUE_T          Null except in CMPT       Fee charged for placing this trade
                                              记录, then >= 0        request.
            T_COMM           VALUE_T          Null except in CMPT       Commission earned on this trade
                                              记录, then >= 0
            T_TAX            VALUE_T          Null except in CMPT       Amount of 税 due on this trade
                                              记录, then >= 0


2.2.2.18   TradeType.txt
           The TradeType.txt file is a plain-text file with variable length 字段 separated by a vertical bar
           (“|”). Records have a terminator character appropriate for the System Under Test.
           Table 2.2.17: TradeType.txt file 字段
             Field Name     Type          Restrictions      Description / Explanation
             TT_ID          CHAR(3)       Not NULL          Trade type code
             TT_NAME        CHAR(12)      Not NULL          Trade type 说明
             TT_IS_SELL     NUM(1)        Not NULL          Flag indicating a sale
             TT_IS_MRKT     NUM(1)        Not NULL          Flag indicating a market 订单



TPC Benchmark™ DI - Standard Specification, Revision 1.1.0                                        Page 34 of 117
2.2.2.19   WatchHistory.txt
           The WatchHistory.txt file is a plain-text file with variable length 字段 separated by a vertical
           bar (“|”). Records have a terminator character appropriate for the System Under Test. The
           CDC_FLAG and CDC_DSN 字段 are not present in the data set used by the Historical Load.
2.2.2.19.1 Rows in the Historical Load files are ordered by the W_DTS 字段; 行 in the Incremental
           Update files are ordered by CDC_DSN.
           Table 2.2.18: WatchHistory.txt file 字段
             Field Name    Type            Restrictions      Description / Explanation
             CDC_FLAG      CDC_FLAG_T      ‘I’               Rows are only added
             CDC_DSN       CDC_DSN_T       Not NULL          Database Sequence Number
             W_C_ID        IDENT_T         Not Null          Customer identifier
             W_S_SYMB      CHAR(15)        Not Null          Symbol of the security to watch
             W_DTS         DATETIME        Not Null          Date and Time Stamp for the action
             W_ACTION      CHAR(4)         ‘ACTV’ or         Whether activating or canceling the watch
                                           ‘CNCL’
2.2.2.20   Audit Data
           A number of files used for auditing are generated in all directories of the Staging Area. Each
           file contains information about a 组件 of the generated data. The files use a naming
           convention, <name>_审计.csv, where <name> corresponds to the 组件 the data is
           associated with.
2.2.2.20.1 All 审计 files are of the same format; a text file with variable length 字段 separated by a
           comma (“,”). The first 记录 in each file contains the 字段 names. Records have a terminator
           character appropriate for the System Under Test. Null 值, where allowed, are indicated
           by there being no characters between commas, or between a comma and the 记录
           delimiter.
           Table 2.2.19: Audit files 字段
             Field Name    Type            Restrictions      Description / Explanation
             DataSet       CHAR(20)        Not Null          Component the data is associated with
             BatchID       NUM(5)                            BatchID the data is associated with
             Date          DATE                              Date 值 corresponding to the Attribute
             Attribute     CHAR(50)        Not Null          Attribute this 行 of data corresponds to
             Value         SNUM(15)                          Integer 值 corresponding to the Attribute
             DValue        SNUM(15,5)                        Decimal 值 corresponding to the Attribute



2.3        Structure of the Staging Area
           The Staging Area contains one directory or folder (as appropriate for the System Under Test)
           for each batch of data to be loaded. DIGen will generate data directly into these directories:
               Batch1 contains all files used for the Historical Load.
               Batch2 contains all files used for Incremental Update 1.

TPC Benchmark™ DI - Standard Specification, Revision 1.1.0                                 Page 35 of 117
               Batch3 contains all files used for Incremental Update 2.


2.4        Staging Area Implementation Rules
2.4.1      The Staging Area must guarantee 持久性. Once the Source Data has been generated or
           copied into the Staging Area, the 一致性 of the Source Data 必须 preserved when
           presented with all of the following failures:
               Permanent irrecoverable failure of any single Durable Medium containing data of the
               Staging Area. The media to be failed is to be chosen at random by the auditor, and
               cannot be specially prepared.
               Staging Area Server Power Failure: Loss of all external power to the Staging Area Server
               for an indefinite time period.
Note:      No 系统 provides complete 持久性 (i.e., 持久性 under all possible types of failures).
           The specific set of single failures addressed above is deemed sufficiently significant to justify
           demonstration of 持久性 across such failures.
2.4.2      Access to the Source Data files in the Staging Area 必须 maintained despite any single
           media failure.
2.4.3      The Source Data 可 be generated directly into the Staging Area or generated elsewhere
           and copied into the Staging Area.
2.4.4      The directory and file structure in the Staging Area 必须 as described in Clause 2.3.
           Modifications to the structure including creating additional files are not allowed.
2.4.5      The Source Data files 必须 those generated by DIGen or exact copies. Changes to file
           contents are not allowed.
           Rationale: The intent is to disallow changes that add, remove, replace, modify, or restructure data to aid in the
           执行 of the 基准测试, while allowing copying to a file 系统 appropriate for the SUT.




TPC Benchmark™ DI - Standard Specification, Revision 1.1.0                                        Page 36 of 117
                                   Clause 3: Data Warehouse

3.1        Introduction
3.1.1      Data Structures
           The Data Warehouse is defined only in terms of the 表 it contains. This 规范 does
           not specify the storage structures to be used or the presence or absence of indices on the
           structures.

3.2        Table Definitions
           The Data Warehouse 表 definitions refer to a common set of data types, defined in Table
           3.2.1, and meta-types defined in Table 3.2.2. The Data Warehouse 实现 必须
           able to store the base data types using publicly documented native or built-in data types
           provided by the Data Warehouse. Storage must accommodate exact 值 for any number
           in the 输入 range.
Note:      Real or floating-point representations that store approximate 值 are not allowed unless it
           can be demonstrated that all possible valid 值 can be stored and retrieved exactly.
           Table 3.2.1: Common data type definitions for Data Warehouse 表
             Base Type          Storage Requirement
             BOOLEAN            Holds at least two distinct 值 that represent FALSE and TRUE or 0 and 1.
             CHAR(n)            Holds a character string of up to n single-byte characters.
             DATE               Represents a unique day in the range of January 1, 1800 to December 31,
                                9999, inclusive.
             DATETIME           Represents a time 值 with a precision of 1 millisecond in the range of
                                January 1, 1800 to December 31, 2199, inclusive.
             NUM(m[,n])         Unsigned exact numeric 值 with at most m total Digits, of which n Digits
                                are to the right (after) the decimal point.
             SNUM(m[,n])        Signed exact numeric 值 with at most m total Digits, of which n Digits are
                                to the right (after) the decimal point.
             TIME               Represents a time of day 值 to a precision of 1 millisecond. The range is
                                00:00:00.000 to 23:59:59.999.


           The meta-types are all defined in terms of base data types, with names that indicate their
           function and possibly 值 restrictions. There is no 要求 to 实现 the meta-
           types as user-defined types in the Data Warehouse. A meta-type 可 be implemented using
           a user-defined type in the Data Warehouse as long as the user-defined type encorporates a
           native data type.
           Table 3.2.2: Meta-type definitions for Data Warehouse 表
             Meta Type         Base Type                   Usage / Restrictions
             BALANCE_T         SNUM(12,2)       Aggregate account and 事务 related 值 such as
                                                account balances, total commissions, etc.

TPC Benchmark™ DI - Standard Specification, Revision 1.1.0                                     Page 37 of 117
             FIN_AGG_T         SNUM(15,2)      Aggregated financial data such as 收入 figures,
                                               valuations, and asset 值
             IDENT_T           NUM(11)         Numeric identifiers from several OLTP 系统 表
             S_COUNT_T         NUM(12)         Aggregate count of shares
             S_PRICE_T         SNUM(8,2)       Share prices
             SK_T              NUM(11)         Surrogagte key; identifies a 行 in a dimension 表
             TRADE_T           NUM(15)         Trade identifiers
             VALUE_T           SNUM(10,2)      Non-aggregated 事务 and security related 值
                                               such as 成本, dividend, etc.

           DIT- 3-1: Definitions of all 表 (e.g. DDL)
3.2.1      DimAccount
           Table 3.2.3: DimAccount 表 字段
            Field Name       Type        Restrictions   Description / Explanation
            SK_AccountID     SK_T        Not NULL       Surrogate key for AccountID
            AccountID        IDENT_T     Not NULL       Customer account identifier
            SK_BrokerID      SK_T        Not NULL       Surrogate key of managing broker
            SK_CustomerID    SK_T        Not NULL       Surrogate key of 客户
            Status           CHAR(10)    Not NULL       Account status, active or closed
            AccountDesc      CHAR(50)                   Name of 客户 account
            TaxStatus        NUM(1)      0, 1 or 2      Tax status of this account
            IsCurrent        BOOLEAN     Not NULL       True if this is the current 记录
            BatchID          NUM(5)      Not NULL       Batch ID when this 记录 was inserted
            EffectiveDate    DATE        Not NULL       Beginning of 日期 range when this 记录 was the
                                                        current 记录
            EndDate          DATE        Not NULL       Ending of 日期 range when this 记录 was the
                                                        current 记录. A 记录 that is not expired will
                                                        use the 日期 9999-12-31.


3.2.2      DimBroker
           Table 3.2.4: DimBroker 表 字段
             Field Name      Type        Restrictions   Description / Explanation
             SK_BrokerID     SK_T        Not NULL       Surrogate key for broker
             BrokerID        IDENT_T     Not NULL       Natural key for broker
             ManagerID       IDENT_T                    Natural key for manager’s HR 记录
             FirstName       CHAR(50)    Not NULL       First name
             LastName        CHAR(50)    Not NULL       Last Name
             MiddleInitial   CHAR(1)                    Middle initial
             Branch          CHAR(50)                   Facility in which employee has office
             Office          CHAR(50)                   Office number or 说明
             Phone           CHAR(14)                   Employee phone number
             IsCurrent       BOOLEAN     Not NULL       True if this is the current 记录
             BatchID         NUM(5)      Not NULL       Batch ID when this 记录 was inserted
             EffectiveDate   DATE        Not NULL       Beginning of 日期 range when this 记录 was the
                                                        current 记录
             EndDate         DATE        Not NULL       Ending of 日期 range when this 记录 was the

TPC Benchmark™ DI - Standard Specification, Revision 1.1.0                                  Page 38 of 117
                                                          current 记录. A 记录 that is not expired will
                                                          use the 日期 9999-12-31.
3.2.3      DimCompany
           Table 3.2.5: DimCompany 表 字段
             Field Name       Type         Restrictions     Description / Explanation
             SK_CompanyID     SK_T         Not NULL         Surrogate key for CompanyID
             CompanyID        IDENT_T      Not NULL         Company identifier (CIK number)
             Status           CHAR(10)     Not NULL         Company status
             Name             CHAR(60)     Not NULL         Company name
             Industry         CHAR(50)     Not NULL         Company’s industry
             SPrating         CHAR(4)                       Standard & Poor company’s rating
             isLowGrade       BOOLEAN                       True if this company is low grade
             CEO              CHAR(100)    Not NULL         CEO name
             AddressLine1     CHAR(80)                      Address Line 1
             AddressLine2     CHAR(80)                      Address Line 2
             PostalCode       CHAR(12)     Not NULL         Zip or postal code
             City             CHAR(25)     Not NULL         City
             StateProv        CHAR(20)     Not NULL         State or Province
             Country          CHAR(24)                      Country
             Description      CHAR(150)    Not NULL         Company 说明
             FoundingDate     DATE                          Date the company was founded
             IsCurrent        BOOLEAN      Not NULL         True if this is the current 记录
             BatchID          NUM(5)       Not NULL         Batch ID when this 记录 was inserted
             EffectiveDate    DATE         Not NULL         Beginning of 日期 range when this 记录 was
                                                            the current 记录
             EndDate          DATE         Not NULL         Ending of 日期 range when this 记录 was the
                                                            current 记录. A 记录 that is not expired will
                                                            use the 日期 9999-12-31.
3.2.4      DimCustomer
           Table 3.2.6: DimCustomer 表 字段
             Field Name              Type             Restrictions     Description / Explanation
             SK_CustomerID           SK_T             Not NULL         Surrogate key for CustomerID
             CustomerID              IDENT_T          Not NULL         Customer identifier
             TaxID                   CHAR(20)         Not NULL         Customer’s 税 identifier
             Status                  CHAR(10)         Not NULL         Customer status type
             LastName                CHAR(30)         Not NULL         Customer's last name.
             FirstName               CHAR(30)         Not NULL         Customer's first name.
             MiddleInitial           CHAR(1)                           Customer's middle name initial
             Gender                  CHAR(1)                           Gender of the 客户
             Tier                    NUM(1)                            Customer tier
             DOB                     DATE             Not NULL         Customer’s 日期 of birth.
             AddressLine1            CHAR(80)         Not NULL         Address Line 1
             AddressLine2            CHAR(80)                          Address Line 2
             PostalCode              CHAR(12)         Not NULL         Zip or Postal Code
             City                    CHAR(25)         Not NULL         City
             StateProv               CHAR(20)         Not NULL         State or Province

TPC Benchmark™ DI - Standard Specification, Revision 1.1.0                                      Page 39 of 117
             Country                 CHAR(24)                         Country
             Phone1                  CHAR(30)                         Phone number 1
             Phone2                  CHAR(30)                         Phone number 2
             Phone3                  CHAR(30)                         Phone number 3
             Email1                  CHAR(50)                         Email address 1
             Email2                  CHAR(50)                         Email address 2
             NationalTaxRateDesc     CHAR(50)                         National Tax rate 说明
             NationalTaxRate         NUM(6,5)                         National Tax rate
             LocalTaxRateDesc        CHAR(50)                         Local Tax rate 说明
             LocalTaxRate            NUM(6,5)                         Local Tax rate
             AgencyID                CHAR(30)                         Agency identifier
             CreditRating            NUM(5)                           Credit rating
             NetWorth                SNUM(10)                         Net worth
             MarketingNameplate      CHAR(100)                        Marketing nameplate
             IsCurrent               BOOLEAN          Not NULL        True if this is the current 记录
             BatchID                 NUM(5)           Not NULL        Batch ID when this 记录 was
                                                                      inserted
             EffectiveDate           DATE             Not NULL        Beginning of 日期 range when this
                                                                      记录 was the current 记录
             EndDate                 DATE             Not NULL        Ending of 日期 range when this
                                                                      记录 was the current 记录. A
                                                                      记录 that is not expired will use the
                                                                      日期 9999-12-31.
3.2.5      DimDate
           Table 3.2.7: DimDate 表 字段
             Field Name            Type          Restrictions    Description / Explanation
             SK_DateID             SK_T          Not NULL        Surrogate key for the 日期
             DateValue             DATE          Not NULL        The 日期 stored appropriately for doing
                                                                 comparisons in the Data Warehouse
             DateDesc              CHAR(20)      Not NULL        The 日期 in full written form, e.g. “July 7,
                                                                 2004”
             CalendarYearID        NUM(4)        Not NULL        Year number as a number
             CalendarYearDesc      CHAR(20)      Not NULL        Year number as text
             CalendarQtrID         NUM(5)        Not NULL        Quarter as a number, e.g. 20042
             CalendarQtrDesc       CHAR(20)      Not NULL        Quarter as text, e.g. “2004 Q2”
             CalendarMonthID       NUM(6)        Not NULL        Month as a number, e.g. 20047
             CalendarMonthDesc     CHAR(20)      Not NULL        Month as text, e.g. “2004 July”
             CalendarWeekID        NUM(6)        Not NULL        Week as a number, e.g. 200428
             CalendarWeekDesc      CHAR(20)      Not NULL        Week as text, e.g. “2004-W28”
             DayOfWeekNum          NUM(1)        Not NULL        Day of week as a number, e.g. 3
             DayOfWeekDesc         CHAR(10)      Not NULL        Day of week as text, e.g. “Wednesday”
             FiscalYearID          NUM(4)        Not NULL        Fiscal year as a number, e.g. 2005
             FiscalYearDesc        CHAR(20)      Not NULL        Fiscal year as text, e.g. “2005”
             FiscalQtrID           NUM(5)        Not NULL        Fiscal quarter as a number, e.g. 20051
             FiscalQtrDesc         CHAR(20)      Not NULL        Fiscal quarter as text, e.g. “2005 Q1”
             HolidayFlag           BOOLEAN                       Indicates holidays


TPC Benchmark™ DI - Standard Specification, Revision 1.1.0                                      Page 40 of 117
3.2.6      DimSecurity
           Table 3.2.8: DimSecurity 表 字段
             Field Name                   Type        Restrictions   Description / Explanation
             SK_SecurityID            SK_T            Not NULL       Surrogate key for Symbol
             Symbol                   CHAR(15)        Not NULL       Identifies security on “ticker”
             Issue                    CHAR(6)         Not NULL       Issue type
             Status                   CHAR(10)        Not NULL       Status type
             Name                     CHAR(70)        Not NULL       Security name
             ExchangeID               CHAR(6)         Not NULL       Exchange the security is traded on
             SK_CompanyID             SK_T            Not NULL       Company issuing security
             SharesOutstanding        S_COUNT_T       Not NULL       Shares outstanding
             FirstTrade               DATE            Not NULL       Date of first trade
             FirstTradeOnExchange     DATE            Not NULL       Date of first trade on this exchange
             Dividend                 VALUE_T         Not NULL       Annual dividend per share
             IsCurrent                BOOLEAN         Not NULL       True if this is the current 记录
             BatchID                  NUM(5)          Not NULL       Batch ID when this 记录 was
                                                                     inserted
             EffectiveDate            DATE            Not NULL       Beginning of 日期 range when this
                                                                     记录 was the current 记录
             EndDate                  DATE            Not NULL       Ending of 日期 range when this
                                                                     记录 was the current 记录. A
                                                                     记录 that is not expired will use the
                                                                     日期 9999-12-31.
3.2.7      DimTime
           Table 3.2.9: DimTime 表 字段
             Field Name             Type       Restrictions   Description / Explanation
             SK_TimeID              SK_T       Not NULL       Surrogate key for the time
             TimeValue              TIME       Not NULL       The time stored appropriately for doing
                                                              comparisons in the Data Warehouse
             HourID                 NUM(2)     Not NULL       Hour number as a number, e.g. 01
             HourDesc               CHAR(20)   Not NULL       Hour number as text, e.g. “01”
             MinuteID               NUM(2)     Not NULL       Minute as a number, e.g. 23
             MinuteDesc             CHAR(20)   Not NULL       Minute as text, e.g. “01:23”
             SecondID               NUM(2)     Not NULL       Second as a number, e.g. 45
             SecondDesc             CHAR(20)   Not NULL       Second as text, e.g. “01:23:45”
             MarketHoursFlag        BOOLEAN                   Indicates a time during market hours
             OfficeHoursFlag        BOOLEAN                   Indicates a time during office hours
3.2.7.1    DimTrade
           Unlike other dimension 表 in the Data Warehouse, DimTrade is not maintained as a
           history-tracking dimension. There are two state changes of concern for a trade: When it was
           initiated and when it was completed or cancelled. Therefore the 记录 has 日期 and time
           字段 for the starting and ending states.
           Rationale: This design is friendlier for users querying DimTrade as a fact 表, because there
           won’t be multiple 记录 to consider for the same trade.

TPC Benchmark™ DI - Standard Specification, Revision 1.1.0                                   Page 41 of 117
           Table 3.2.10: DimTrade 表 字段
             Field Name          Type          Restrictions       Description / Explanation
             TradeID             IDENT_T       Not NULL           Trade identifier
             SK_BrokerID         SK_T                             Surrogate key for BrokerID
             SK_CreateDateID     SK_T          Not NULL           Surrogate key for 日期 created
             SK_CreateTimeID     SK_T          Not NULL           Surrogate key for time created
             SK_CloseDateID      SK_T                             Surrogate key for 日期 closed
             SK_CloseTimeID      SK_T                             Surrogate key for time closed
             Status              CHAR(10)      Not NULL           Trade status
             Type                CHAR(12)      Not NULL           Trade type
             CashFlag            BOOLEAN       Not NULL           Is this trade a cash (1) or margin (0) trade?
             SK_SecurityID       SK_T          Not NULL           Surrogate key for SecurityID
             SK_CompanyID        SK_T          Not NULL           Surrogate key for CompanyID
             Quantity            NUM(6,0)      Not NULL           Quantity of securities traded.
             BidPrice            NUM(8,2)      Not NULL           The requested unit 价格.
             SK_CustomerID       SK_T          Not NULL           Surrogate key for CustomerID
             SK_AccountID        SK_T          Not NULL           Surrogate key for AccountID
             ExecutedBy          CHAR(64)      Not NULL           Name of person executing the trade.
             TradePrice          NUM(8,2)                         Unit 价格 at which the security was traded.
             Fee                 NUM(10,2)                        Fee charged for placing this trade request
             Commission          NUM(10,2)                        Commission earned on this trade
             Tax                 NUM(10,2)                        Amount of 税 due on this trade
             BatchID             NUM(5)        Not Null           Batch ID when this 记录 was inserted
3.2.8      DImessages
           There are five types of messages defined in the 基准测试:
               “Status” messages give information about the DI processing.
               “Alert” messages provide information that certain conditions were detected which 可
               need attention, but do not warrant excluding the data from the data 仓库. For
               示例, 客户 tiers have the 值 1, 2 or 3. If a different 值 appeared in a
               客户 记录, the 记录 would be fully processed and an alert message would be
               written.
               Phase Complete Records (“PCR”) are written at the end of each phase and are used to
               calculate the phase elapsed times.
               “Validation” messages are written by the Batch Validation 查询 (see Clause 7.4)
               “Visibility_1” and “Visibility_2” messages are written by the Data Visibility 查询 (see
               Clause 7.3)
3.2.8.1    Test Sponsors 可 include other messages in the DImessages 表, as long as they use a
           MessageType 值 that is not one of types defined above.
           Rationale: The DImessages 表 provides one place where the DI 系统 places any messages to the operator
           in response to various conditions encountered during 执行 of DI jobs.

           Table 3.2.11: DImessages 表 字段
            Field Name              Type           Restrictions     Description / Explanation


TPC Benchmark™ DI - Standard Specification, Revision 1.1.0                                        Page 42 of 117
            MessageDateAndTime      DATETIME      Not NULL       Date and time of the message
            BatchID                 NUM(5)        Not NULL       DI run number; see the 节 “Overview of
                                                                 BatchID usage”
            MessageSource           CHAR(30)                     Typically the name of the transform that
                                                                 logs the message
            MessageText             CHAR(50)      Not NULL       Description of why the message was logged
            MessageType             CHAR(12)      Not NULL       “Status” or “Alert” or “Reject”
            MessageData             CHAR(100)                    Varies with the reason for logging the
                                                                 message

3.2.9      FactCashBalances
           Table 3.2.12: FactCashBalances 表 字段
            Field Name       Type            Restrictions   Description / Explanation
            SK_CustomerID    SK_T            Not Null       Surrogate key for CustomerID
            SK_AccountID     SK_T            Not Null       Surrogate key for AccountID
            SK_DateID        SK_T            Not Null       Surrogate key for the 日期
            Cash             SNUM(15,2)      Not Null       Cash balance for the account after applying
                                                            changes for this day
            BatchID          NUM(5)          Not Null       Batch ID when this 记录 was inserted
3.2.10     FactHoldings
           Table 3.2.13: FactHoldings 表 字段
            Field Name       Type            Restrictions   Description / Explanation
            TradeID          IDENT_T         Not NULL       Key for Orignial Trade Indentifier
            CurrentTradeID   IDENT_T         Not Null       Key for the current trade
            SK_CustomerID    SK_T            Not NULL       Surrogate key for Customer Identifier
            SK_AccountID     SK_T            Not NULL       Surrogate key for Account Identifier
            SK_SecurityID    SK_T            Not NULL       Surrogate key for Security Identifier
            SK_CompanyID     SK_T            Not NULL       Surrogate key for Company Identifier
            SK_DateID        SK_T            Not NULL       Surrogate key for the 日期 associated with the
                                                            current trade
            SK_TimeID        SK_T            Not NULL       Surrogate key for the time associated with the
                                                            current trade
            CurrentPrice     S_PRICE_T       >0             Unit 价格 of this security for the current trade
            CurrentHolding   SNUM(6)         Not NULL       Quantity of a security held after the current trade.
                                                            The 值 can be a positive or negative integer
            BatchID          NUM(5)          Not Null       Batch ID when this 记录 was inserted


3.2.11     FactMarketHistory
           Table 3.2.14: FactMarketHistory 表 字段
            Field Name          Type         Restrictions     Description / Explanation
            SK_SecurityID       SK_T          Not Null        Surrogate key for SecurityID
            SK_CompanyID        SK_T          Not Null        Surrogate key for CompanyID
            SK_DateID           SK_T          Not Null        Surrogate key for the 日期
TPC Benchmark™ DI - Standard Specification, Revision 1.1.0                                     Page 43 of 117
            PERatio             NUM(10,2)                           Price to earnings per share ratio
            Yield               NUM(5,2)         Not Null           Dividend to 价格 ratio, as a percentage
            FiftyTwoWeekHigh    NUM(8,2)         Not Null           Security highest 价格 in last 52 weeks from this
                                                                    day
            SK_FiftyTwoWeek     SK_T             Not Null           Earliest 日期 on which the 52 week high 价格
            HighDate                                                was set
            FiftyTwoWeekLow     NUM(8,2)         Not Null           Security lowest 价格 in last 52 weeks from this
                                                                    day
            SK_FiftyTwoWeekL    SK_T             Not Null           Earliest 日期 on which the 52 week low 价格
            owDate                                                  was set
            ClosePrice          NUM(8,2)         Not Null           Security closing 价格 on this day
            DayHigh             NUM(8,2)         Not Null           Highest 价格 for the security on this day
            DayLow              NUM(8,2)         Not Null           Lowest 价格 for the security on this day
            Volume              NUM(12)          Not Null           Trading volume of the security on this day
            BatchID             NUM(5)           Not Null           Batch ID when this 记录 was inserted
3.2.12     FactWatches
           Table 3.2.15: FactWatches 表 字段
            Field Name                  Type          Restrictions     Description / Explanation
            SK_CustomerID               SK_T          Not NULL         Customer associated with watch list
            SK_SecurityID               SK_T          Not NULL         Security listed on watch list
            SK_DateID_DatePlaced        SK_T          Not NULL         Date the watch list item was added
            SK_DateID_DateRemoved       SK_T                           Date the watch list item was removed
            BatchID                     NUM(5)        Not Null         Batch ID when this 记录 was inserted
3.2.13     Industry
           Table 3.2.16: Industry 表 字段
            Field Name   Type         Restrictions      Description / Explanation
            IN_ID        CHAR(2)      Not NULL          Industry code
            IN_NAME      CHAR(50)     Not NULL          Industry 说明
            IN_SC_ID     CHAR(4)      Not NULL          Sector identifier
3.2.14     Financial
           Table 3.2.17: Financial 表 字段
            Field Name              Type             Restrictions    Description / Explanation
            SK_CompanyID            IDENT_T          Not NULL        Company SK.
            FI_YEAR                 NUM(4)           Not NULL        Year of the quarter end.
            FI_QTR                  NUM(1)           Not NULL        Quarter number that the financial information
                                                                     is for: valid 值 1, 2, 3, 4.
            FI_QTR_START_DATE       DATE             Not NULL        Start 日期 of quarter.
            FI_REVENUE              SNUM(15,2)       Not NULL        Reported 收入 for the quarter.
            FI_NET_EARN             SNUM(15,2)       Not NULL        Net earnings reported for the quarter.
            FI_BASIC_EPS            SNUM(10,2)       Not NULL        Basic earnings per share for the quarter.
            FI_DILUT_EPS            SNUM(10,2)       Not NULL        Diluted earnings per share for the quarter.
            FI_MARGIN               SNUM(10,2)       Not NULL        Profit divided by revenues for the quarter.
            FI_INVENTORY            SNUM(15,2)       Not NULL        Value of inventory on hand at the end of
                                                                     quarter.

TPC Benchmark™ DI - Standard Specification, Revision 1.1.0                                           Page 44 of 117
            FI_ASSETS             SNUM(15,2)    Not NULL       Value of total assets at the end of the quarter.
            FI_LIABILITY          SNUM(15,2)    Not NULL       Value of total liabilities at the end of the
                                                               quarter.
            FI_OUT_BASIC          SNUM(12)      Not NULL       Average number of shares outstanding (basic).
            FI_OUT_DILUT          SNUM(12)      Not NULL       Average number of shares outstanding
                                                               (diluted).
3.2.15     Prospect
           Table 3.2.18: Prospect 表 字段
            Field Name            Type          Restrictions    Description / Explanation
            AgencyID              CHAR(30)      Not NULL        Unique identifier from agency
            SK_RecordDateID       SK_T          Not NULL        Last 日期 this prospect appeared in 输入
            SK_UpdateDateID       SK_T          Not NULL        Latest change 日期 for this prospect
            BatchID               NUM(5)        Not Null        Batch ID when this 记录 was last modified
            IsCustomer            BOOLEAN       Not NULL        True if this person is also in DimCustomer,
                                                                else False
            LastName              CHAR(30)      Not NULL        Last name
            FirstName             CHAR(30)      Not NULL        First name
            MiddleInitial         CHAR(1)                       Middle initial
            Gender                CHAR(1)                       M/F/U
            AddressLine1          CHAR(80)                      Postal address
            AddressLine2          CHAR(80)                      Postal address
            PostalCode            CHAR(12)                      Postal code
            City                  CHAR(25)      Not NULL        City
            State                 CHAR(20)      Not NULL        State or province
            Country               CHAR(24)                      Postal country
            Phone                 CHAR(30)                      Telephone number
            Income                NUM(9)                        Annual income
            NumberCars            NUM(2)                        Cars owned
            NumberChildren        NUM(2)                        Dependent children
            MaritalStatus         CHAR(1)                       S/M/D/W/U
            Age                   NUM(3)                        Current age
            CreditRating          NUM(4)                        Numeric rating
            OwnOrRentFlag         CHAR(1)                       O/R/U
            Employer              CHAR(30)                      Name of employer
            NumberCreditCards     NUM(2)                        Credit cards
            NetWorth              NUM(12)                       Estimated total net worth
            MarketingNameplate    CHAR(100)                     For marketing purposes
3.2.16     StatusType
           Table 3.2.19: StatusType 表 字段
            Field Name     Type       Restrictions   Description / Explanation
            ST_ID          CHAR(4)    Not NULL       Status code
            ST_NAME        CHAR(10)   Not NULL       Status 说明
3.2.17     TaxRate
           Table 3.2.20: TaxRate 表 字段

TPC Benchmark™ DI - Standard Specification, Revision 1.1.0                                     Page 45 of 117
            Field Name    Type         Restrictions    Description / Explanation
            TX_ID         CHAR(4)      Not NULL        Tax rate code
            TX_NAME       CHAR(50)     Not NULL        Tax rate 说明
            TX_RATE       NUM(6,5)     Not NULL        Tax rate
3.2.18     TradeType
           Table 3.2.21: TradeType 表 字段
            Field Name      Type          Restrictions     Description / Explanation
            TT_ID           CHAR(3)       Not NULL         Trade type code
            TT_NAME         CHAR(12)      Not NULL         Trade type 说明
            TT_IS_SELL      NUM(1)        Not NULL         Flag indicating a sale
            TT_IS_MRKT      NUM(1)        Not NULL         Flag indicating a market 订单
3.2.19     Audit
           Table 3.2.23: Audit 表 字段
             Field Name      Type           Restrictions     Description / Explanation
             DataSet         CHAR(20)       Not Null         Component the data is associated with
             BatchID         NUM(5)                          BatchID the data is associated with
             Date            DATE                            Date 值 corresponding to the Attribute
             Attribute       CHAR(50)       Not Null         Attribute this 行 of data corresponds to
             Value           SNUM(15)                        Integer 值 corresponding to the Attribute
             DValue          SNUM(15,5)                      Decimal 值 corresponding to the Attribute


3.3        Data Warehouse Properties
3.3.1      The Data Warehouse 必须 implemented using a commercially available product, as
           defined by the TPC-Pricing 规范.
           DIT- 3-2: Name, optional components, and version number that uniquely identifies the
           product that implements the Data Warehouse
3.3.2      The Data Warehouse must provide access to data using logical structures (i.e. 表,
           列).
3.3.3      The Data Warehouse must allow concurrent Data Warehouse sessions.
3.3.4      The Data Warehouse must provide a means for Data Warehouse sessions to commit data. In
           the context of this 规范, to commit data means the data is made permanent in the
           Data Warehouse and visible to other Data Warehouse sessions. Committed data must meet
           the data 持久性 要求 specified in Clause 3.4.6.


3.4        Data Warehouse Implementation Rules
3.4.1      The 基准测试 does not give 要求 for the Data Warehouse internal
           实现. Various techniques, including vertical partitioning, horizontal partitioning,
           复制 and the use of various storage mechanisms, are allowed as long as they do not

TPC Benchmark™ DI - Standard Specification, Revision 1.1.0                                    Page 46 of 117
           rely on any knowledge of the Source Data other than 日期 ranges, total 记录 counts, source
           file sizes, or information provided in this 规范.
3.4.2      No ill-formed 行 可 exist in any data that is available to all Data Warehouse sessions. An
           ill-formed 行 occurs when the 值 of any 列 cannot be determined. In the context of
           this 规范, NULL is considered a 值 that can be determined. For 示例, in the
           case of a vertically partitioned 表, a 行 must exist in all the partitions.
3.4.3      The surrogate key of any 表 must not directly represent the physical disk addresses of the
           行 or any offsets thereof. Queries are not allowed to reference 行 using relative
           addressing since they are simply offsets from the beginning of the storage space.
3.4.4      The Data Warehouse must allow for insertion of arbitrary data 值 that conform to the
           datatype of 列 of the 表.
3.4.5      The 列 within a given 表 可 be implemented in any 订单, but all 列 listed in
           the 表 定义 应 be implemented and there 应 be no 列 added to or
           removed from the 表.
3.4.6      Data Durability
3.4.6.1    The Data Warehouse must guarantee 持久性. The Data Warehouse must preserve
           committed data and ensure 数据库 一致性 after 恢复 from all of the following
           failures:
               Permanent irrecoverable failure of any single Durable Medium containing data of the
               Data Warehouse. The media to be failed is to be chosen at random by the auditor, and
               cannot be specially prepared.
               Data Warehouse Server Power Failure: Loss of all external power to the Data Warehouse
               Server for an indefinite time period.
Note:      No 系统 provides complete 持久性 (i.e., 持久性 under all possible types of failures).
           The specific set of single failures addressed above is deemed sufficiently significant to justify
           demonstration of 持久性 across such failures.


3.4.7      Data Visibility
           Data visibility is the ability for all Data Warehouse sessions to operate on data that was
           committed by another Data Warehouse session. The following are the 规则 governing data
           visibility:




TPC Benchmark™ DI - Standard Specification, Revision 1.1.0                            Page 47 of 117
3.4.7.1    The Data Warehouse 可 automatically commit data or allow the DI application to control
           when data is committed.
3.4.7.2    Once data has been committed, it must remain visible at all times.
3.4.8      Auxiliary data structures
3.4.8.1    Auxiliary data structures are allowed to be created and maintained in the Data Warehouse.
3.4.8.2    Data modifications performed during a Benchmark Run phase (see Clause 7.2) 必须
           reflected in associated auxiliary data structures before the phase is completed.
3.4.9      Execution 规则
3.4.9.1    Data Warehouse 表 must not exist at the start of the Benchmark Run.
3.4.9.2    At the end of each phase, all transformations must have completed successfully and their
           输出 data 必须 committed in the Data Warehouse.
3.4.9.3    While inserts, updates and deletes are not performed on all 表, the 系统 must not be
           configured to take special advantage of this fact during the test.
3.4.9.4    Although inserts are inherently limited by the storage space available on the configured
           系统, there 必须 no restriction preventing the 执行 of seven more incremental
           updates. To determine the number of 行 added to each 表 in an incremental update,
           行 counts from Batch2 可 be used.
3.4.9.5    It is required that the space for the additional seven incremental updates (and corresponding
           growth in associated auxiliary data structures, such as indices) be configured for the
           Benchmark Run and priced accordingly, as per Clause 9.2.1.
3.4.10     Data Warehouse classification
3.4.10.1   A TPC-DI 基准测试 Result will be listed either under the TPC-DI ACID class or the TPC-DI
           OPEN class. Only TPC-DI 基准测试 Results listed in the same class are comparable.
           DIT- 3-3: Data Warehouse class (必须 either ACID or OPEN)
3.4.10.2   In 订单 for a 基准测试 Result to be listed in the ACID class of TPC-DI, the Data Warehouse
           must demonstrate ACID 合规. ACID 合规 can be demonstrated using any of the
           two following procedures. It is under the discretion of the Test Sponsor to choose the
           procedure. The FDR must clearly state which procedure was followed:
           1. The version of the 软件 that implements the Data Warehouse has demonstrated
              ACID 合规 as 零件 of one or more published TPC-C, TPC-E, TPC-H, TPC-DS, or TPC-DI
              Result, hereafter referred to as ACID Benchmark Proof (ABP). The same mechanisms that
              were enabled to demonstrate ACID 合规 in the ABP must also be enabled during
              both Incremental Update phases of TPC-DI. If this 软件 relied on any 硬件 or
              软件 features of the server or storage areas or devices to pass the ACID tests, e.g.
              RAID, the Data Warehouse Server must 实现 these features and have them
              enabled during both Incremental Update phases of TPC-DI. If, for any reason, the
              基准测试 publication listed in the ABP is withdrawn, then the TPC-DI Result 必须
              withdrawn.

TPC Benchmark™ DI - Standard Specification, Revision 1.1.0                        Page 48 of 117
           2. The version of the 软件 that implements the Data Warehouse has demonstrated
              ACID 合规 using any of the ACID tests required for TPC-C, TPC-E, TPC-H or TPC-DS,
              hereafter referred to as AT. The Test Sponsor is required to build all necessary 数据库
              objects for the AT on the SUT and demonstrate ACID 合规 to the auditor following
              the 规则 in the AT 规范. The same mechanisms that were enabled to
              demonstrate ACID 合规 during the AT must also be enabled during both
              Incremental Update phases of TPC-DI. If this 软件 relied on any 硬件 or 软件
              features of the server or storage areas or devices to pass the ACID tests, e.g. RAID, the
              Data Warehouse Server must have them enabled during both Incremental Update
              phases of TPC-DI.
           DIT- 3-4: Method use to demonstrate ACID 合规 and details of ABP or AT
3.4.10.3   If ACID 合规 is not demonstrated, then the Result 必须 listed in the TPC-DI OPEN
           class.
3.4.11     SQL Compliance
           SQL statements in this 规范 必须 executed as provided by this 规范 unless
           a Data Warehouse 实现 requires modified versions of the SQL statements to be
           able run them. If modifications are necessary, they must fall under one of the following
           categories:
               Minor 查询 modifications
               Major 查询 modifications
3.4.11.1   Minor 查询 modifications
            SQL statements provided in this 规范 可 be modified applying minor 查询
            modifications as defined in this 子句. They do not need approval by the auditor or the TPC.
            The application of minor 查询 modifications to SQL statements 必须 applied
            consistently to all SQL statements. For 示例, if a particular vendor-specific 日期
            expression or 表 name syntax is used in one 查询, it 必须 used in all other queries
            involving 日期 expressions or 表 names.
            OID 3-1: The use of minor 查询 modifications 必须 disclosed and justified.
3.4.11.1.1 The following modifications are considered minor 查询 modifications
           a) Table names - The 表 names found in the FROM 子句 of each 查询 可 be modified
              to reflect the customary naming conventions of the 系统 under test.
           b) Select-list expression aliases - For queries that include the 定义 of an alias for a
              SELECT-list item (e.g., “AS” 子句), vendor-specific syntax 可 be used instead of the
              specified syntax. Replacement syntax must have equivalent semantic behavior. Examples
              of acceptable implementations include "TITLE <string>", or "WITH HEADING <string>".




TPC Benchmark™ DI - Standard Specification, Revision 1.1.0                         Page 49 of 117
           c) Date expressions - For queries that include an expression involving manipulation of dates
              (e.g., adding/subtracting days/months/years, or extracting years from dates), vendor-
              specific syntax 可 be used instead of the specified syntax. Replacement syntax must
              have equivalent semantic behavior. Examples of acceptable implementations include
              "YEAR(<列>)" to extract the year from a 日期 列 or "DATE(<日期>) + 3
              MONTHS" to add 3 months to a 日期.
           d) GROUP BY and ORDER BY - For queries that utilize a nested 表-expression or select-list
              alias solely for the purposes of grouping or ordering on an expression, vendors 可
              replace the view, nested 表-expression or select-list alias with a vendor-specific SQL
              extension to the GROUP BY or ORDER BY 子句. Examples of acceptable implementations
              include "GROUP BY <ordinal>", "GROUP BY <expression>", "ORDER BY <ordinal>", and
              "ORDER BY <expression>".
           e) Command delimiters - Additional syntax 可 be inserted at the end of the executable
              查询 text for the purpose of signaling the end of the 查询 and requesting its 执行.
              Examples of such command delimiters are a semicolon or the word "GO".
           f) Output formatting functions - Scalar functions whose sole purpose is to affect 输出
              formatting 可 be applied to items in the outermost SELECT list of the 查询.
           g) Correlation names – Table-name aliases 可 be added to the executable 查询 text. The
              keyword "AS" before the 表-name alias 可 be omitted.
           h) Explicit ASC - ASC 可 be explicitly appended to 列 in an ORDER BY 子句.
           i) In cases where identifier names conflict with reserved words in a given 实现,
              delimited identifiers 可 be used.
           j) Relational operators - Relational operators used in queries such as "<", ">", "<>", "<=",
              and "=", 可 be replaced by equivalent vendor-specific operators, for 示例 ".LT.",
              ".GT.", "!=" or "^=", ".LE.", and "==", respectively.
           k) Nested 表-expression aliasing - For queries involving nested 表-expressions, the
              nested keyword "AS" before the 表 alias 可 be omitted.
           l) At large scale factors, the aggregates 可 exceed the range of the 值 supported by an
              integer. The 聚合 functions AVG and COUNT 可 be replaced with equivalent
              vendor-specific functions to handle the expanded range of 值 (e.g., AVG_BIG and
              COUNT_BIG).
           m) Outer Join – For outer 连接 queries, vendor specific syntax 可 be used instead of the
              specified syntax. Replacement syntax must have equivalent semantic behavior. For
              示例, the 连接 expression “CUSTOMER LEFT OUTER JOIN ORDERS ON C_CUSTKEY =
              O_CUSTKEY” 可 be replaced by adding CUSTOMER and ORDERS to the from 子句 and
              adding a specially-marked 连接 谓词 (e.g., C_CUSTKEY *= O_CUSTKEY).
           n) String concatenation operator: For queries which use string concatenation operators,
              vendor specific syntax can be used (e.g. || can be substituted with +). Replacement
              syntax must have equivalent semantic behavior.
           o) Table-less Queries - Queries that do not require any 表 可 be modified to select
              from a 系统 defined 表, e.g. sysibm.sysdummy for DB2 or dual for Oracle.



TPC Benchmark™ DI - Standard Specification, Revision 1.1.0                        Page 50 of 117
3.4.11.2   Major 查询 modifications
           All 查询 modifications that do not fall under Clause 3.4.11.1.1 are considered major 查询
           modifications, which includes queries not expressed in SQL. The Test Sponsor must prove to
           the auditor that statements containing major 查询 modifications are functionally equivalent
           to the SQL statements provided by the 规范.
           OID 3-2: The use of major 查询 modifications 必须 disclosed and justified.




TPC Benchmark™ DI - Standard Specification, Revision 1.1.0                        Page 51 of 117
                                   Clause 4: Transformations

4.1        Introduction
           Data Integration (DI) Systems provide capabilities to specify data sources and destinations,
           and actions to be taken to move and transform data from sources to destinations. Typically a
           DI System provides a design time environment for specifying data transformation logic, and a
           runtime environment for executing the specified data transformations.

4.2        Data Integration System Properties
4.2.1      The Data Integration (DI) System 必须 a commercially available product, as defined by
           the TPC-Pricing 规范.
           DIT- 4-1: The name, options and version number that uniquely identifies the product
           implementing the Data Integration System
4.2.2      The Data Integration System must provide the ability to read and write data to and from
           more than one data store and provide data transformation capabilities that can be applied
           to general data integration tasks.
4.2.3      The DI System 可 require additional 软件 to access particular data stores. For 示例,
           数据库 client 软件 provided by a 数据库 系统 vendor 可 be required for the DI
           System to access the particular 数据库 系统. If additional 软件 is required, the
           软件 必须 generally available.
4.2.4      The DI System must translate the DI 规范 into the DI application format, which can
           be executed in the DI System’s runtime environment or other general purpose program
           执行 系统.
           DIT- 4-2: The translation of the DI 规范 into the DI aplication format




TPC Benchmark™ DI - Standard Specification, Revision 1.1.0                           Page 52 of 117
4.3        Transformation Implementation Rules
4.3.1      Data Integration (DI) System
4.3.1.1    Implementation of the 基准测试 transformations 必须 created using a DI System.
4.3.1.2    The 基准测试 transformations 可 be transcribed in the optimal form for the DI System.
4.3.1.3    Creation of the DI 规范 on a different 安装 of the DI System is allowed,
           however the translation into the DI application 必须 done on the 基准测试 DI System.
4.3.1.4    The DI application 可 not be altered from the form generated by the DI System.
4.3.1.5    If the DI System uses the same format for the DI 规范 and the DI application, e.g. the
           DI System interprets the DI 规范 at run time, it is permissible to create this
           application on a DI System that is not 零件 of the SUT, provided:
                   All 软件 components that are required by the DI System to create the DI
                   规范 are installed and included in the priced 配置, as described in
                   Clause 9.
                   The DI 规范 is not altered from the form generated by the DI System.

4.3.2      Use of extension mechanisms provided by the DI System for extending base capabilities is
           allowed, with the following 规则:
                   The extension is generally available as 软件, or provided as source in the FDR.
                   If charged for, included in the priced 配置 as described in Clause 9.
4.3.3      Data Dependencies
           There are dependencies between 表 in the Data Warehouse that require data from some
           表 to be processed before data in the dependent 表, within the scope of a Benchmark
           Run phase. When a dependent 表 列 refers to a 列 in a source 表, any 行 in
           the source 表 that would change the outcome of processing of a 行 in the dependent
           表 必须 processed before the dependent 行.
           Table 4.3: Table and 列 dependencies
            Dependent                                        Source
            Table               Column                       Table           Column
            DimAccount          SK_BrokerID                  DimBroker       SK_BrokerID
            DimAccount          SK_CustomerID                DimCustomer     SK_CustomerID
            DimSecurity         SK_CompanyID                 DimCompany      SK_CompanyID
            DimTrade            SK_BrokerID                  DimBroker       SK_BrokerID
            DimTrade            SK_CreateDateID              DimDate         SK_DateID
            DimTrade            SK_CreateTimeID              DimTime         SK_TimeID
            DimTrade            SK_CloseDateID               DimDate         SK_DateID
            DimTrade            SK_CloseTimeID               DimTime         SK_TimeID
            DimTrade            SK_SecurityID                DimSecurity     SK_SecurityID
            DimTrade            SK_CompanyID                 DimCompany      SK_CompanyID
            DimTrade            SK_CustomerID                DimCustomer     SK_CustomerID

TPC Benchmark™ DI - Standard Specification, Revision 1.1.0                           Page 53 of 117
            DimTrade              SK_AccountID                 DimAccount               SK_AccountID
            FactCashBalances      SK_CustomerID                DimCustomer              SK_CustomerID
            FactCashBalances      SK_AccountID                 DimAccount               SK_AccountID
            FactCashBalances      SK_DateID                    DimDate                  SK_DateID
            FactCashBalances      SK_TimeID                    DimTime                  SK_TimeID
            FactHoldings          SK_TradeID                   DimTrade                 SK_TradeID
            FactHoldings          SK_CurrentTradeID            DimTrade                 SK_CurrentTradeID
            FactHoldings          SK_CustomerID                DimCustomer              SK_CustomerID
            FactHoldings          SK_AccountID                 DimAccount               SK_AccountID
            FactHoldings          SK_SecurityID                DimSecurity              SK_SecurityID
            FactHoldings          SK_CompanyID                 DimCompany               SK_CompanyID
            FactHoldings          SK_DateID                    DimDate                  SK_DateID
            FactHoldings          SK_TimeID                    DimTime                  SK_TimeID
            FactMarketHistory     SK_SecurityID                DimSecurity              SK_SecurityID
            FactMarketHistory     SK_CompanyID                 DimCompany               SK_CompanyID
            FactMarketHistory     SK_DateID                    DimDate                  SK_DateID
            FactWatches           SK_CustomerID                DimCustomer              SK_CustomerID
            FactWatches           SK_SecurityID                DimSecurity              SK_SecurityID
            FactWatches           SK_DateID_DatePlaced         DimDate                  SK_DateID
            FactWatches           SK_DateID_DateRemoved        DimDate                  SK_DateID
            Prospect              SK_UpdateDateID              DimDate                  SK_DateID

           Rationale: When there are dependencies between data in 表 (whether declared or not) it is common in
           developing DI applications to process 表 in 订单 of their dependencies; e.g., DimCustomer is fully processed
           before DimAccount because the account 记录 refer to 客户 记录. The 基准测试 规范 does
           not require that certain 表 必须 processed before others. However, data dependencies do exist, and
           必须 honored: An account 记录 cannot be processed until related 客户 记录 have been processed.
           How the application accomplishes this is not specified.

4.3.4      If the DI System requires additional 软件 to interact with the Data Warehouse, the
           软件 必须 installed on the SUT and included in the priced 配置.
4.3.5      Execution Phases
           The 基准测试 is executed in a series of phases, as described in Clause 7. The following are
           the 规则 associated with 执行 of the phases:




TPC Benchmark™ DI - Standard Specification, Revision 1.1.0                                       Page 54 of 117
4.3.5.1    At the end of each phase, all transformations must have completed successfully and their
           输出 data 必须 committed into the Data Warehouse.
4.3.5.2    A subset of the transformed data 可 be committed into the Data Warehouse during the
           执行 of any phase as long as all of the transformations on the subset have been
           completed, the 行 are not ill-formed as described in 子句 3.4.2.2, and the data
           dependencies described in Clause 4.3.3 are honored.
4.3.5.3    The DI application is allowed to perform the transformations defined within each phase in
           any 订单, provided the data dependencies described in 子句 4.3.3 are honored.
4.3.5.4    The DI application must determine the Staging Area directory from which to read the Source
           Data based on an 输入 parameter or calculation.
4.3.5.5    The DI application must not access data from a Staging Area directory associated with a
           subsequent 执行 phase.
4.3.5.6    While executing the Historical Load phase, the DI application 可 assume it has exclusive
           access to the Data Warehouse 表.
4.3.5.7    The same DI application 必须 used to perform all Incremental Update phases.
4.3.5.8    Starting from the first Incremental Update phase, the Data Warehouse 必须 operational
           and accessible to Data Warehouse sessions that are not managed by the DI application.
                   The DI application 可 assume the Data Warehouse sessions that it manages are the
                   only sessions that 可 be updating or inserting data into the Data Warehouse.
                   Data that has been committed in the Data Warehouse must remain visible to other
                   Data Warehouse sessions. DI applications 可 not temporarily remove data from the
                   Data Warehouse 表.
4.3.6      Various techniques, including partitioning, are allowed as long as they do not rely on any
           prior knowledge of the Source Data other than 日期 ranges, total 记录 counts, source file
           sizes, or information provided in this 规范.
4.3.7      Auxiliary data structures are allowed to be created and maintained by the DI System, with
           the following 规则:
                   No Auxiliary data structures from previous Benchmark Runs 可 be present on the
                   SUT at the start of a Benchmark Run.
                   Data modifications performed during a 基准测试 执行 phase 必须 reflected
                   in associated auxiliary data structures before the 执行 phase is completed.

4.4        Data Manipulation Details
4.4.1      History-tracking Dimension 表
           History-tracking dimension 表 retain information about changes to the data over time,
           while also allowing users to easily 查询 for current information. This is accomplished using
           both the primary (or “natural”) key for a 记录 in the source 系统, which is constant over
           time, and a surrogate key that is updated for each recorded change. Fact 表 that
TPC Benchmark™ DI - Standard Specification, Revision 1.1.0                         Page 55 of 117
           reference a history-tracking dimension include a 外键 reference to the surrogate key,
           not the natural key.
           When data that matches an existing 记录 in a history-tracking dimension 表 is processed,
           i.e. the natural keys match, updates to the dimension 表 记录 are not made in-place.
           Instead, the 记录 is marked as not current and the EndDate is set, and a new 记录 is
           inserted with the same natural key but a new surrogate key 值. This new 记录 contains
           all the current 字段 值. After this, any new 记录 introduced into fact 表
           corresponding to this natural key reference the new surrogate key 值.
           Rationale: The concept of a history tracking dimension is common in the industry, and is sometimes referred to
           as a “type 2 changing dimension” or a “type 2 slowly changing dimension.”

4.4.1.1    History tracking updates are used on the following 表:
               DimAccount
               DimBroker
               DimCompany
               DimCustomer
               DimSecurity
4.4.1.2    When a 记录 with a natural key that does not exist in the dimension 表 is processed, the
           following transformations are performed:
           1. A unique surrogate key 值 必须 assigned and included in the inserted 记录.
           2. The current indicator 字段, IsCurrent, is set to TRUE to indicate that this is the current
             记录 corresponding to the natural key.
           3. The EffectiveDate 字段 is set to a 值 specified by the transformation, or Batch Date if no
             值 is specified.
           4. The EndDate 字段 is set to December 31, 9999.
           Rationale: The EndDate of the ‘current’ 记录 is not yet determined. The actual EndDate is set when a new
           记录 is inserted and this 记录 is expired. When querying a dimension to find the valid 记录 for a given
           time, a condition like EffectiveDate <= my_time < EndDate could be used. Using a NULL 值 for EndDate
           complicates these sorts of queries as these conditions will be UNKNOWN on current 记录, so additional logic
           would need to be added to account for that. To avoid this complication, a 日期 far off into the future is used as
           the EndDate for current 记录, which allows a basic 日期 range search to work for all 记录.

4.4.1.3    When a 记录 with a natural key already present in the dimension 表 is processed, the
           following transformations are performed:
           1. Update the existing dimension 表 记录 for that natural key where IsCurrent is set to
           TRUE (these updates are known as ‘Expiring’ the 记录):
                            The current indicator 字段, IsCurrent, is set to FALSE to indicate that this is no
                            longer the current 记录 corresponding to the natural key.
                            The EndDate 字段 is set to the EffectiveDate of the new 记录.

           2. After expiring the existing 记录 in the dimension 表, a new 记录 is inserted into the
           dimension 表, as described in Clause 4.4.1.2.

TPC Benchmark™ DI - Standard Specification, Revision 1.1.0                                       Page 56 of 117
4.4.1.4    Natural keys are not deleted in the Source Data, therefore no processing of deleted 记录 is
           required.
           Rationale: In the brokerage application modeled by this 基准测试, the source 系统 that are used to
           populate the dimension 表 do not delete 记录. Rather, some indication of the state (active or inactive) of
           an object is updated. Note: A different update strategy is used on the DimTrade 表 due to its dual role as
           both a dimension 表 and a fact 表.

Note:      DimDate and DimTime are static dimension 表; they do not receive updates.
4.4.1.5    Dimension 表 granularity
           The level of precision (e.g. hours, days, months) that updates are tracked in the dimension
           表 is known as the granularity (or grain) of the dimension. The granularity of all dimensions
           in this 基准测试 is daily. This means that there 必须 at most 1 update to a natural key
           记录 on any given day, even when the Source Data contains more than 1 update to a
           natural key.
4.4.1.5.1 The DI System must accumulate the changes that occur relative to a single natural key on a
          daily basis, and apply a single update 记录 per day per natural key 值, for those keys that
          have changed on that day.
4.4.1.5.2 If a 字段 changes more than once per day, the latest 值 is used as determined by the time
          stamps on the incoming data. If the time stamps are the same, the sequence the 记录
          appear in the file determines the 订单, i.e. the latest 值 appears last.
4.4.1.6    Data dependencies and history-tracking updates
4.4.1.6.1 When a history-tracking dimension 表 contains a surrogate key reference to another
          dimension 表 and an update occurs to the referenced dimension 表, the referencing
          表 必须 updated as well. Specifically, this situation exists for:
               DimAccount, which contains a surrogate key for DimCustomer
               DimSecurity, which contains a surrogate key for DimCompany
Note:      DimAccount also contains a surrogate key for DimBroker, but DimBroker will not be updated
           according to the 基准测试 规范.
4.4.1.6.2 When a history-tracking dimension 表 depends on data from multiple source files, changes
          in either source can cause it to be updated. For 示例, DimCustomer depends on data
          from Customer.txt and Prospect.csv; data in either of these sources can cause an update to
          the DimCustomer 表.
4.4.1.6.3 Regardless of the number of causes of an update to a 记录 in a history tracking dimension,
          only one change 记录 必须 produced per natural key 值 per Incremental Update.
          Likewise, in the Historical Load, exactly one historical 记录 应 be produced per natural
          key 值 for each day that has an update to that key. See Clause 4.4.1.5.
4.4.2      BatchID
           The BatchID is a numeric 值 that is used to mark data that is added to the Data
           Warehouse so that it can be associated with a particular 基准测试 phase. The BatchID is
TPC Benchmark™ DI - Standard Specification, Revision 1.1.0                                       Page 57 of 117
           used when logging events to the DImessages 表 and is also included in 行 of data being
           added to most Data Warehouse 表.
4.4.2.1    A unique BatchID is associated with each 执行 phase of the 基准测试. When the
           BatchID is required by the 规范, the following 值 必须 used:
                   Initialization, BatchID = 0
                   Historical Load, BatchID = 1
                   Incremental Update 1, BatchID = 2
                   Incremental Update 2, BatchID = 3
           Rationale: In practice, the BatchID concept is commonly used as 零件 of an 审计 trail for data in the 仓库,
           and also can be used to help identify data that 应 be cleaned up in the event of an unrecoverable 系统
           issue during a run.

4.4.3      Error handling
4.4.3.1    The detection and handling of various data errors is a normal 零件 of data integration
           processing. Accordingly, the generated data will contain certain 值 that are defined in
           the 规范 to be errors.
4.4.3.2    The transformation 规则 specified in Clauses 4.5 and 4.6 define the error conditions that
           必须 checked and the action to take when those conditions are met.
4.4.3.3    Additional error checks are not required, but 可 be implemented at the discretion of the
           Test Sponsor.
4.4.3.4    Implementations 可 assume the Source Data is self-consistent, e.g. an account 记录 will
           not contain a 客户 key that does not reference a valid 客户 记录.
4.4.3.5    All 记录, including those meeting error conditions 必须 fully processed as described by
           the transformation 规则.

4.5        Transformation Details for the Historical Load

           DIT- 4-3: Implementation of each transformation of the Historical Load
4.5.1      DimAccount
4.5.1.1    DimAccount data is obtained from the data file CustomerMgmt.xml. Account data is stored
           as a contained element to the related Action and Customer elements. The possible
           ActionType 值 are shown in 表 4.5.1.1:
           Table 4.5.1.1
            ActionType     Description
            NEW            A new 客户. A new 客户 is always created with 1 or more new accounts.
            ADDACCT        One or more new accounts for an existing 客户.
            UPDACCT        Updates to the information in one or more existing accounts.
            UPDCUST        One or more updates to an existing 客户. When updating 客户
                           information, no account information is supplied. Note that since DimAccount
                           contains a surrogate key to DimCustomer, a change to a 客户 记录 will
                           require a history-tracking change to update the SK_CustomerID 字段 of the current

TPC Benchmark™ DI - Standard Specification, Revision 1.1.0                                       Page 58 of 117
                         associated account 记录 in DimAccount as described in 子句 4.4.1.
            CLOSEACCT    Close one or more existing accounts as described in 4.5.1.3
            INACT        Make an existing 客户 and that 客户’s currently active accounts inactive.
                         No specific account information is supplied in the Source Data.


NOTE:      The descriptions below use XPath notation (http://www.w3.org/TR/xpath) to identify specific
           data elements of the XML document. All references are relative to the context of the
           associated Action (/Action) data element.
4.5.1.2    Customer/Account/@CA_ID is the natural key for the Account data. When Account
           information is new, 字段 值 可 be missing from the XML or included as an empty
           element (e.g. <Element /> ). In both cases the 值 应 be processed as a NULL 值.
           When Account information is updated, only the natural key and the updated 字段 are given
           a 值 in the 记录, i.e. all properties that are missing 值 retain their current 值 in
           the DimAccount 表. Fields with an empty 值 (e.g. <Element /> ) 必须 processed as a
           NULL 值. All changes to DimAccount are implemented in a history-tracking manner as
           specified in Clause 4.4.1.
4.5.1.3    When populating 字段 of the DimAccount 表, for each account identified in the 记录:
               When ./@ActionType is ‘NEW’ or ‘ADDACCT’
                AccountID, AccountDesc and TaxStatus 字段 are copied from
               Customer/Account/@CA_ID, Customer/Account/CA_NAME and
               Customer/Account/@CA_TAX_ST respectively.
               SK_BrokerID and SK_CustomerID are set by obtaining the associated surrogate keys by
               matching Customer/Account/CA_B_ID with DimBroker.BrokerID and Customer/@C_ID
               (from the parent Customer element) with DimCustomer.CustomerID where the 日期
               portion of ./@ActionTS >= EffectiveDate and the 日期 portion of ./@ActionTS <= EndDate.
               The BrokerID and CustomerID matches are guaranteed to succeed.
               Status is set to ‘ACTIVE’.
               When ./@ActionType is ‘UPDACCT’
               Fields that exist in the Source Data 应 be transformed to the target 字段 as
               described above.
               Fields that do not exist in the Source Data retain their 值 from the current 记录 in
               DimAccount.
               When ./@ActionType is ‘CLOSEACCT’
               Status is set to ‘INACTIVE’
               When ./@ActionType is ‘UPDCUST’
               For each account held by the 客户 being updated, perform an update to:
               Set SK_CustomerID to the associated 客户’s DimCustomer current 记录 after it has
               been updated.
               When ./@ActionType is ‘INACT’
               For each account held by the 客户 being marked as inactive, perform an update to:
               Set SK_CustomerID to the associated 客户’s DimCustomer 记录 after it has been
               marked ‘INACTIVE’.
TPC Benchmark™ DI - Standard Specification, Revision 1.1.0                                   Page 59 of 117
               Set Status to ‘INACTIVE’.
               IsCurrent, EffectiveDate, and EndDate are set as described in 节 4.4.1, with
               EffectiveDate being assigned the 日期 值 from the 日期 portion of ./@ActionTS.
               BatchID is set as described in 节 4.4.2.
4.5.1.4    There are no messages written to the DImessages 表 by this transformation.
4.5.2      DimBroker
4.5.2.1    Data for DimBroker comes from the HR extract file HR.csv. Those employees from the HR file
           that are brokers (as indicated by the EmployeeJobCode) will have data copied to the Broker
           表.
           The Broker 表 is structured as a history tracking dimension 表. However, nothing in the
           输入 file will provide any history of changes over time; it is simply a snapshot of the current
           state of the HR data.
           Rationale: Although changes to DimBroker might be expected in a “real world” brokerage 仓库, the rate
           of change in this 表 is so low as to be inconsequential to 基准测试 results.

           When inserting 记录 from HR.csv into DimBroker:
               Records where EmployeeJobCode is not 314 are not broker 记录, and are ignored. The
               remaining steps are for 记录 where the job code is 314.
               BrokerID, ManagerID, FirstName, LastName, MiddleInitial, Branch, Office and Phone are
               obtained from these 字段 of the HR.csv file: EmployeeID, ManagerID,
               EmployeeFirstName, EmployeeLastName, EmployeeMI, EmployeeBranch, EmployeeOffice
               and EmployeePhone.
               SK_BrokerID is set appropriately for new 记录 as described in 节 4.4.1.3.
               IsCurrent is set to true
               EffectiveDate is set to the earliest 日期 in the DimDate 表 and EndDate is set to 9999-
               12-31.
               BatchID is set as described in 节 4.4.2.
4.5.3      DimCompany
4.5.3.1    DimCompany data is obtained from the FINWIRE files. All FINWIREyyyyQq files are processed
           in ascending year and quarter 订单, and 记录 of type CMP are used. CMP 记录 可
           have content that is unchanged from prior CMP 记录, except for the PTS 字段. Changes to
           DimCompany are implemented in a history-tracking manner, but unchanged 记录 are not
           recorded. CIK is the natural key for the Company data.
4.5.3.2    When populating 字段 of the DimCompany 表:
               CompanyID is copied from CIK.
               Name, SPRating, CEO, Description and FoundingDate are copied from CompanyName,
               SPrating, CEOname, Description, and FoundingDate respectively. In cases where the 输入
               data is all blanks, a NULL 值 is used in the target.
               AddressLine1, AddressLine2, PostalCode, City, State_Prov, and Country are copied from
               AddrLine1, AddrLine2, PostalCode, City, StateProvince, and Country. In cases where the 输入
               data is all blanks, a NULL 值 is used in the target.
TPC Benchmark™ DI - Standard Specification, Revision 1.1.0                                  Page 60 of 117
               Status is obtained from the FINWIRE Status by matching Status with ST_ID from the
               StatusType.txt file.
               Industry is obtained from IndustryID by matching IndustryID with IN_ID from the
               Industry.txt file.
               isLowGrade is set to False if SPrating begins with ‘A’ or ‘BBB’ otherwise set to True
               IsCurrent, EffectiveDate and EndDate are set as described in 节 4.4.1, with
               EffectiveDate being the 日期 indicated by the PTS 字段.
               BatchID is set as described in 节 4.4.2.
4.5.3.3    A 记录 will be inserted in the DImessages 表 if a company’s SPRating is not one of the
           valid 值 for Standard & Poor long-term credit-ratings. The MessageSource is
           “DimCompany”, the MessageType is “Alert” and the MessageText is “Invalid SPRating”. The
           MessageData 字段 is “CO_ID = ” followed by the key 值 of the 记录, then “, CO_SP_RATE
           = ” and the CO_SP_RATE 值. The SPRating and isLowGrade 列 will be set to NULL in
           this case. The valid 值 are: AAA, AA[+/-], A[+/-], BBB[+/-], BB[+/-], B[+/-], CCC[+/-], CC, C,
           D.
4.5.4      DimCustomer
4.5.4.1    DimCustomer data is obtained from the data file CustomerMgmt.xml. Customer data is
           stored as a sub-element to the related Action element. Every Action will have a related
           Customer, but not all actions require modifying the DimCustomer 表. The possible
           ActionTypes are shown in 表 4.5.4.1:
           Table 4.5.4.1
             ActionType    Description
             NEW           A new 客户. A new 客户 is always created with 1 or more new accounts.
             ADDACCT       One or more new accounts for an existing 客户. This does not require any
                           change to DimCustomer.
             UPDACCT       Updates to the information in one or more existing accounts. No change to
                           DimCustomer is required.
             UPDCUST       One or more updates to existing 客户’s information. Only the identifying data
                           and updated property 值 are supplied in the Source Data.
             CLOSEACCT     Close one or more existing accounts. This does not require any change to
                           DimCustomer.
             INACT         Make an existing 客户 and that 客户’s currently active accounts inactive.
                           No specific account information is supplied in the Source Data.



NOTE:      The descriptions below use XPath notation (http://www.w3.org/TR/xpath) to identify specific
           data elements of the XML document. All references are relative to the context of the
           associated Action (/Action) data element.
4.5.4.2    The TaxRate and Prospect 表 will be referenced in the transformation. Customer/@C_ID
           is the natural key for the Customer data. When a Customer is new, unknown 字段 值 可
           be missing from the XML or included as an empty element (e.g. <Element /> ). In both cases
TPC Benchmark™ DI - Standard Specification, Revision 1.1.0                                     Page 61 of 117
           the 值 应 be processed as a NULL 值. When Customer information is updated, only
           the updated 字段 are supplied a new 值, i.e. all missing 值 retain their current 值.
           Fields with empty 值 (e.g. <Element /> ) 应 be processed as NULL 值. Changes to
           DimCustomer are implemented in a history-tracking manner.
4.5.4.3    When populating 字段 of the DimCustomer 表:
               When ./@ActionType is ‘NEW’
               CustomerID, TaxID, LastName, FirstName, MiddleInitial, Tier, DOB, Email1 and Email2 are
               copied from Customer/@C_ID, Customer/@C_TAX_ID, Customer/Name/C_L_NAME,
               Customer/Name/C_F_NAME, Customer/Name/C_M_NAME, Customer/@C_TIER,
               Customer/@C_DOB, Customer/ContactInfo/C_PRIM_EMAIL,
               Customer/ContactInfo/C_ALT_EMAIL, respectively.
               Gender is obtained from Customer/@C_GNDR, and is uppercased. Values other than ‘M’
               or ‘F’ are replaced with ‘U’.
               AddressLine1, AddressLine2, PostalCode, City, State_Prov, and Country are copied from
               Customer/Address/C_ADLINE1, Customer/Address/C_ADLINE2,
               Customer/Address/C_ZIPCODE, Customer/Address/C_CITY,
               Customer/Address/C_STATE_PROV, and Customer/Address/C_CTRY.
               Status is set to ‘ACTIVE’.
               Phone1, Phone2 and Phone3 are created by concatenating 字段 from the corresponding
               输入 data. The 输入 data contains 3 contact phone number elements,
               Customer/ContactInfo/C_PHONE_1, Customer/ContactInfo/C_PHONE_2, and
               Customer/ContactInfo/C_PHONE_3, which correspond to Phone1, Phone2, and Phone3
               respectively. The transformation for each of the these 字段 is as follows:
               For each Phonen, where n = {1,2,3}
               If Customer/ContactInfo/C_PHONE_n/C_CTRY_CODE,
               Customer/ContactInfo/C_PHONE_n/C_AREA_CODE and
               Customer/ContactInfo/C_PHONE_n/C_LOCAL are not null, Phonen is:
                        '+' + Customer/ContactInfo/C_PHONE_n/C_CTRY_CODE
                        + ' (' + Customer/ContactInfo/C_PHONE_n/C_AREA_CODE + ') '
                        + Customer/ContactInfo/C_PHONE_n/C_LOCAL
               If Customer/ContactInfo/C_PHONE_n/C_CTRY_CODE is null while
               Customer/ContactInfo/C_PHONE_n/C_AREA_CODE and
               Customer/ContactInfo/C_PHONE_n/C_LOCAL are not null, Phonen is:
                        '(' + Customer/ContactInfo/C_PHONE_n/C_AREA + ') '
                        + Customer/ContactInfo/C_PHONE_n/C_LOCAL
               If Customer/ContactInfo/C_PHONE_n/C_AREA_CODE is null while
               Customer/ContactInfo/C_PHONE_n/C_LOCAL is not null, Phonen is:
                        Customer/ContactInfo/C_PHONE_n/C_LOCAL
               If any of the above 规则 has been applied and Customer/ContactInfo/C_PHONE_n/C_EXT
               is not null, Phonen is:
                        Phonen + Customer/ContactInfo/C_PHONE_n/C_EXT
               If none of the above 规则 has been applied,
TPC Benchmark™ DI - Standard Specification, Revision 1.1.0                           Page 62 of 117
               Phonen is null
               NationalTaxRateDesc and NationalTaxRate are copied from TX_NAME and TX_RATE
               respectively by matching Customer/TaxInfo/C_NAT_TX_ID with TX_ID. The match is
               guaranteed succeed.
               LocalTaxRateDesc and LocalTaxRate are copied from TX_NAME and TX_RATE respectively
               by matching Customer/TaxInfo/C_LCL_TX_ID with TX_ID. The match is guaranteed to
               succeed.
               AgencyID, CreditRating, NetWorth, MarketingNameplate: If demographic data for this
               客户 is present in the Prospect file and there are no newer ‘UPDCUST’ or ‘INACT’
               记录 for this Customer/@C_ID, the AgencyID, CreditRating and NetWorth 值 will
               be copied to DimCustomer and the MarketingNameplate will be set according to the
               latest 值 using the same process defined for the data 仓库 Prospect 表. A
               Prospect 记录 is deemed to match a DimCustomer 记录 if the LastName, FirstName,
               AddressLine1, AddressLine2 and PostalCode 字段 all match the corresponding
               DimCustomer 字段 when upper-cased. If the demographic data for this 客户 is not
               present in the Prospect file or there are newer ‘UPDCUST’ or ‘INACT’ 记录 for this
               客户, these 字段 应 be set to NULL.
           Rationale: Only current demographic information is available, and it corresponds to the Batch Date of the
           Historical Load. It does not make sense to apply that information retroactively to older 客户 记录. It
           will only be applied to the latest version of the 客户 记录.

               When ./@ActionType is ‘UPDCUST’
               Fields that exist in the Source Data 应 be transformed to the target 字段 as
               described above.
               Fields that do not exist in the Source Data retain their 值 from the current 记录 in
               DimCustomer.
               AgencyID, CreditRating, NetWorth, MarketingNameplate: If demographic data for this
               客户 is present in the Prospect file and there are no newer ‘UPDCUST’ or ‘INACT’
               记录 for this 客户, these 值 应 be obtained as described above. If the
               demographic data for this 客户 is not present in the Prospect file or there are newer
               ‘UPDCUST’ or ‘INACT’ 记录 for this 客户, these 字段 应 be not be changed.
               A history-tracking update to all current accounts for this 客户 in the DimAccount
               表 is also required, as described in 子句 4.4.1.6
               When ./@ActionType is ‘INACT’
               Status is set to ‘INACTIVE’
               AgencyID, CreditRating, NetWorth, MarketingNameplate: If demographic data for this
               客户 is present in the Prospect file, these 值 应 be obtained as described
               above. If the demographic data for this 客户 is not present in the Prospect file these
               字段 应 be not be changed.
               All current accounts for this 客户 must also be made inactive, as described in 子句
               4.5.1.3 (when ActionType is ‘INACT’).
               IsCurrent, EffectiveDate, and EndDate are set as described in 节 4.4.1 except that
               EffectiveDate is assigned the 日期 值 in the 日期 portion of ./@ActionTS.
               BatchID is set as described in 节 4.4.2.
TPC Benchmark™ DI - Standard Specification, Revision 1.1.0                                      Page 63 of 117
4.5.4.4    A 记录 will be inserted in the DImessages 表 if a 客户’s Tier is not one of the valid
           值 (1,2,3). The MessageSource is “DimCustomer”, the MessageType is “Alert” and the
           MessageText is “Invalid 客户 tier”. The MessageData 字段 is “C_ID = ” followed by the
           natural key 值 of the 记录, then “, C_TIER = ” and the C_TIER 值.
4.5.4.5    A 记录 will be reported in the DImessages 表 if a 客户’s DOB is invalid. A 客户’s
           DOB is invalid if DOB < Batch Date – 100 years or DOB > Batch Date (客户 is over 100
           years old or born in the future). The MessageSource is “DimCustomer”, the MessageType is
           “Alert” and the MessageText is “DOB out of range”. The MessageData 字段 is “C_ID = ”
           followed by the natural key 值 of the 记录, then “, C_DOB = ” and the C_DOB 值.
4.5.5      DimDate
4.5.5.1    DimDate is a static 表: It is loaded from the Date.txt in the Historical Load and not
           modified again.
4.5.5.2    During the Historical Load, all 行 and 列 of the Date.txt file 必须 loaded into the
           corresponding 列 of the DimDate 表, with no modifications.
4.5.6      DimSecurity
4.5.6.1    DimSecurity data is obtained from the FINWIRE files. All FINWIREyyyyQq files are processed
           in ascending year and quarter 订单, and 记录 of type SEC are used. The surrogate key of
           the associated company 必须 obtained for the Company dimension reference. Changes
           to DimSecurity are implemented in a history-tracking manner. Symbol is the natural key for
           the Security data.
4.5.6.2    When populating 字段 of the DimSecurity 表:
               Symbol, Issue, Name, ExchangeID, SharesOutstanding, FirstTrade, FirstTradeOnExchange
               and Dividend are copied from Symbol, IssueType, Name, ExID, ShOut, FirstTradeDate,
               FirstTradeExchg and Dividend respectively from the SEC 记录.
               SK_CompanyID is obtained from the DimCompany 表 by matching CoNameOrCIK with
               Name or CIKcode (depending on the characters found in CoNameOrCIK), where PTS >=
               EffectiveDate and PTS < EndDate, to return the SK_CompanyID. The match is guaranteed
               to succeed due to the integrity of the FINWIRE data. This dependency of DimSecurity on
               DimCompany requires that any update to a company’s DimCompany 记录 必须
               completed before updates to that company’s DimSecurity 记录.
               Status is obtained from the StatusType 表 by matching Status from the FINWIRE 记录
               with ST_ID to return the ST_NAME.
               IsCurrent, EffectiveDate, and EndDate are set as described in 节 4.4.1, where the
               EffectiveDate is the 日期 indicated by the PTS 字段.
               BatchID is set as described in 节 4.4.2.
4.5.7      DimTime
4.5.7.1    DimTime is a static 表: It is loaded from a file once in the Historical Load and not modified
           again.
           During the Historical Load, all 行 and 列 of the Time.txt file 必须 loaded into the
           corresponding 列 of the DimTime 表, with no modifications.
TPC Benchmark™ DI - Standard Specification, Revision 1.1.0                          Page 64 of 117
4.5.8      DimTrade
4.5.8.1    DimTrade data is obtained from the Trade.txt and TradeHistory.txt files. The incoming files
           可 be thought of as logically joined on the T_ID 字段. When a T_ID encountered does not
           match a TradeID from the DimTrade 表, a new DimTrade 记录 is inserted. When a T_ID
           is encountered that matches an existing TradeID in the DimTrade 表, the DimTrade 记录
           is updated.
4.5.8.2    When populating 字段 of the DimTrade 表:
               If TH_ST_ID is “SBMT” and T_TT_ID is either “TMB” or “TMS”, or TH_ST_ID is “PNDG”,
               then SK_CreateDateID and SK_CreateTimeID 必须 set based on TH_DTS, with time
               truncated to 1-second resolution. SK_CloseDateID and SK_CloseTimeID 必须 set to
               NULL if a new DimTrade 记录 is being inserted.
               If TH_ST_ID is “CMPT” or “CNCL”, SK_CloseDateID and SK_CloseTimeID 必须 set based
               on TH_DTS, with time truncated to 1-second resolution. SK_CreateDateID and
               SK_CreateTimeID 必须 set to NULL if a new DimTrade 记录 is being inserted.
               TradeID, CashFlag, Quantity, BidPrice, ExecutedBy, TradePrice, Fee, Commission and Tax
               are copied from T_ID, T_IS_CASH, T_QTY, T_BID_PRICE, T_EXEC_NAME, T_TRADE_PRICE,
               T_CHRG, T_COMM and T_TAX respectively.
               Status is copied from ST_NAME of the StatusType 表 by matching T_ST_ID with ST_ID.
               Type is copied from TT_NAME of the TradeType 表 by matching T_TT_ID with TT_ID.
               SK_SecurityID and SK_CompanyID are copied from SK_SecurityID and SK_CompanyID of
               the DimSecurity 表 by matching T_S_SYMB with Symbol where TH_DTS is in the range
               given by EffectiveDate and EndDate. The match is guaranteed to succeed due to the
               referential integrity of the OLTP 数据库. Note that these surrogate key 值 must
               reference the dimension 记录 that is current at the earliest time this TradeID is
               encountered. If an update to a 记录 is required in 订单 to set the SK_CloseDateID and
               SK_CloseTimeID, these 字段 must not be updated. This dependency of DimTrade on
               DimSecurity requires that any update to a security’s DimSecurity 记录 必须
               completed before updates to that security’s DimTrade 记录.
               SK_AccountID, SK_CustomerID, and SK_BrokerID are copied from the SK_AccountID,
               SK_CustomerID, and SK_BrokerID 字段 of the DimAccount 表 by matching T_CA_ID
               with AccountID where TH_DTS is in the range given by EffectiveDate and EndDate. The
               match is guaranteed to succeed due to the referential integrity of the OLTP 数据库.
               Note that these surrogate key 值 must reference the dimension 记录 that is current
               at the earliest time this TradeID is encountered. If an update to a 记录 is required in
               订单 to set the SK_CloseDateID and SK_CloseTimeID, these 字段 must not be updated.
               This dependency of DimTrade on DimAccount requires that any update to an account’s
               DimAccount 记录 必须 completed before updates to that account’s DimTrade
               记录.
               BatchID is set as described in 节 4.4.2 at the time the 记录 is initially created.
4.5.8.3    A 记录 will be reported in the DImessages 表 if a trade’s Commission is not null and
           exceeds TradePrice * Quantity. The MessageSource is “DimTrade”, the MessageType is

TPC Benchmark™ DI - Standard Specification, Revision 1.1.0                         Page 65 of 117
           “Alert” and the MessageText is “Invalid trade commission”. The MessageData 字段 is “T_ID =
           ” followed by the key 值 of the 记录, then “, T_COMM = ” and the T_COMM 值.
4.5.8.4    A 记录 will be reported in the DImessages 表 if a trade’s Fee is not null and exceeds
           TradePrice * Quantity. The MessageSource is “DimTrade”, the MessageType is “Alert” and
           the MessageText is “Invalid trade fee”. The MessageData 字段 is “T_ID = ” followed by the
           key 值 of the 记录, then “, T_CHRG = ” and the T_CHRG 值.
4.5.9      FactCashBalances
4.5.9.1    FactCashBalances data is obtained from the data file CashTransaction.txt. The net effect of
           all cash transactions for a given account on a given day is totaled, and only a single 记录 is
           generated per account that had changes per day.
4.5.9.2    When populating 字段 of the FactCashBalances 表:
               SK_CustomerID and SK_AccountID are obtained from DimAccount by matching CT_CA_ID
               with AccountID, where CT_DTS is in the range given by EffectiveDate and EndDate.
               SK_DateID is obtained from DimDate by matching just the 日期 portion of CT_DTS with
               DateValue to return the SK_DateID. The match is guaranteed to succeed because
               DimDate has been populated with 日期 information for all dates relevant to the
               基准测试.
               Cash is calculated as the sum of the prior Cash amount for this account plus the sum of all
               CT_AMT 值 from all transactions in this account on this day. If there is no previous
               FactCashBalances 记录 for the associated account, zero is used.
Note:      The procedure used to determine the new Cash total must account for the possibility that a
           new surrogate key is created in DimAccount since the last cash 事务.
               BatchID is set as described in 节 4.4.2.


4.5.10     FactHoldings
4.5.10.1   Data for FactHoldings comes from the HoldingHistory.txt file and the DimTrade 表. The
           数量 and 价格 值 reflect the holdings for a particular security after the most recent
           trade. The 客户 can have a positive or negative position (Quantity) as a 结果 of a trade
4.5.10.2   When populating 字段 of the FactHoldings 表:
               Retrieve the following 值 from DimTrade where HH_T_ID (current trade identifier)
               from the HoldingHistory.txt file matches the TradeID from DimTrade:
               SK_CustomerID, SK_AccountID, SK_SecurityID, SK_CompanyID and CurrentPrice
               SK_DateID is set to the 值 of SK_CloseDateID and SK_TimeID is set to the 值 of
               SK_CloseTimeID
               TradeId and CurrentTradeID 值 are supplied by HH_H_T_ID and HH_T_ID
               CurrentHolding – this 值 is supplied by HH_AFTER_QTY
               BatchID is set as described in 节 4.4.2.



TPC Benchmark™ DI - Standard Specification, Revision 1.1.0                           Page 66 of 117
4.5.11     FactMarketHistory
4.5.11.1   FactMarketHistory data is primarily obtained from the file DailyMarket.txt.
4.5.11.2   When populating 字段 of the FactMarketHistory 表:
               ClosePrice, DayHigh, DayLow, and Volume are copied from DM_CLOSE, DM_HIGH,
               DM_LOW, and DM_VOL respectively.
               SK_SecurityID is obtained from DimSecurity by matching the associated security’s current
               记录 DM_S_SYMB with Symbol, for the 日期 indicated by DM_DATE, to return the
               SK_SecurityID. The match is guaranteed to succeed due to the referential integrity of the
               OLTP 数据库. The dependency of FactMarketHistory on DimSecurity requires that any
               update to a company’s DimSecurity 记录 必须 completed before updates to the
               FactMarketHistory 记录.
               SK_CompanyID is obtained from DimSecurity by matching DM_S_SYMB with Symbol, for
               the 日期 indicated by DM_DATE, to return the SK_CompanyID. The match is guaranteed
               to succeed due to the referential integrity of the OLTP 数据库. The dependency of
               FactMarketHistory on DimSecurity requires that any update to a company’s DimSecurity
               记录 必须 completed before updates to the FactMarketHistory 记录.
               SK_DateID is obtained from DimDate by matching DM_DATE with DateValue to return the
               SK_DateID. The match is guaranteed to succeed because DimDate has been populated
               with 日期 information for all dates relevant to the 基准测试.
               FiftyTwoWeekHigh and SK_FiftyTwoWeekHighDate are determined by finding the highest
               价格 over the last year (approximately 52 weeks) for a given security. The
               FactMarketHistory 表 itself can be used for this comparison. FiftyTwoWeekHigh is set
               to the highest DM_HIGH 值 for any 日期 in the range from DM_DATE back to but not
               including the same 日期 one year earlier. SK_FiftyTwoWeekHighDate is assigned the
               earliest 日期 in the 日期 range upon which this DM_HIGH 值 occurred.
Note:      Over the course of the year, the surrogate key 值 for a security 可 have changed. It is
           not sufficient to simply compare 记录 that share the same SK_SecurityID 值.
           Rationale: The terms “52 week high” and “52 week low” are common in financial reporting, and in general
           practice seem to mean “over the last year”. This 基准测试 follows the one-year interpretation. Therefore in a
           summary generated on July 4, 2014, the 日期 range to use is 2013-07-05 to 2014-07-04.

               FiftyTwoWeekLow and SK_FiftyTwoWeekLowDate are determined by finding the lowest
               价格 over the last year (approximately 52 weeks) for a given security. The
               FactMarketHistory 表 itself can be used for this comparison. FiftyTwoWeekLow is set
               to the lowest DM_LOW 值 for any 日期 in the range from DM_DATE back to but not
               including the same 日期 one year earlier. SK_FiftyTwoWeekLowDate is assigned the
               earliest 日期 in the 日期 range upon which this DM_LOW 值 occurred.
Note:      Over the course of the year, the surrogate key 值 for a security 可 have changed. It is
           not sufficient to simply compare 记录 that share the same SK_SecurityID 值.
               PERatio is calculated by dividing DM_CLOSE (the closing 价格 for a security on a given
               day) by the sum of the company’s quarterly earnings per share (“eps”) over the previous
               4 quarters prior to DM_DATE. Company quarterly earnings per share data is provided by
TPC Benchmark™ DI - Standard Specification, Revision 1.1.0                                     Page 67 of 117
               the FINWIRE data source in the EPS 字段 of the ‘FIN’ 记录 type. If there are no earnings
               for this company, NULL is assigned to PERatio and an alert condition is raised as described
               below.
Note:      Over the course of the previous 4 quarters, attributes of securities and companies 可 have
           changed. As a 结果, there 可 be more than one surrogate key 值 used for a security
           and/or company in the target data 仓库 表 during that time period.
               Yield is calculated by dividing the security’s dividend by DM_CLOSE (the closing 价格 for a
               security on a given day), then multiplying by 100 to obtain the percentage. The dividend
               is obtained from DimSecurity by matching DM_S_SYMB with Symbol, where DM_DATE is
               in the range given by EffectiveDate and EndDate, to return the Dividend 字段.
               BatchID is set as described in 节 4.4.2.
4.5.11.3   A 记录 will be reported in the DImessages 表 if there are no earnings found for a
           company. The MessageSource is “FactMarketHistory”, the MessageType is “Alert” and the
           MessageText is “No earnings for company”. The MessageData 字段 is “DM_S_SYMB = ”
           followed by the DM_S_SYMB 值 of the 记录.
4.5.12     FactWatches
4.5.12.1   Data for FactWatches comes from the WatchHistory.txt file. Surrogate keys 必须
           obtained for the Customer, Security and Date dimension references. The 日期 keys show the
           dates the watch was set and removed.
4.5.12.2   Securities can either be added to or removed from a watch list; there is no notion of updating
           a security on a watch list.
4.5.12.3   When a security is added to a watch list, as indicated by W_ACTION = “ACTV”, surrogate keys
           from the DimCustomer, DimSecurity and DimDate are inserted based on the following:
               SK_CustomerID – each watch list is associated with a 客户. W_C_ID can be used to
               match the associated DimCustomer 记录 (W_C_ID = C_ID) that is current at the time
               indicated by W_DTS, to obtain SK_CustomerID.
               SK_SecurityID – W_S_SYMB can be used to match the current associated DimSecurity
               记录 (W_SYMB = Symbol) that is current at the time indicated by W_DTS, to obtain SK_
               SecurityID.
               SK_DateID_DatePlaced – set based on W_DTS.
               SK_DateID_DateRemoved – set to NULL.
               BatchID is set as described in 节 4.4.2.
4.5.12.4   When a security is removed from a watch list, as indicated by W_ACTION = “CNCL”, the
           FactWatches 记录 to update is located by finding the surrogate keys corresponding to
           W_C_ID and W_S_SYMB, bearing in mind that the 客户 SK 值 or the company SK
           值 many have changed since the watch was set; then the following action is required:
               SK_DateID_DateRemoved – set based on W_DTS.
               BatchID is set as described in 节 4.4.2.


TPC Benchmark™ DI - Standard Specification, Revision 1.1.0                          Page 68 of 117
4.5.13     Industry
4.5.13.1   Industry is a static 表: It is loaded from a file once in the Historical Load and not modified
           again.
4.5.13.2   During the Historical Load, all 行 and 列 of the Industry.txt file are loaded into the
           corresponding 列 of the Industry 表, with no modifications.
4.5.14     Financial
4.5.14.1   Financial data is obtained from the FINWIRE files. All FINWIREyyyyQq files are processed in
           ascending year and quarter 订单, and 记录 of type FIN are used. The surrogate key of the
           associated company 必须 obtained for the Company dimension reference.
Note:      In reality, companies sometimes “restate” earnings in special situations. The 基准测试 data
           will not contain more than one FIN 记录 for any company for a single quarter.
4.5.14.2   When populating 字段 of the Financial 表:
               FI_YEAR, FI_QTR, FI_QTR_START_DATE, FI_REVENUE, FI_NET_EARN, FI_BASIC_EPS,
               FI_DILUT_EPS, FI_MARGIN, FI_INVENTORY, FI_ASSETS, FI_LIABILITY, FI_OUT_BASIC, and
               FI_OUT_DILUT are copied from Year, Quarter, QtrStartDate, Revenue, Earnings, EPS,
               DilutedEPS, Margin, Inventory, Assets, Liabilities, ShOut, and DilutedShOut.
               SK_CompanyID is obtained from the DimCompany 表 by matching CoNameOrCIK with
               Name or CIKcode (depending on the characters found in CoNameOrCIK), where
               EffectiveDate <= PTS < EndDate, to return the SK_CompanyID. The match is guaranteed
               to succeed due to the integrity of the FINWIRE data. This dependency of Financial on
               DimCompany requires that any update to a company’s DimCompany 记录 必须
               completed before updates to that company’s Financial 记录.
4.5.15     Prospect
4.5.15.1   Prospect 表 data is obtained from the Prospect file. AgencyID is a unique identifier
           assigned by the agency providing the data feed. An AgencyID 值 will not be repeated
           within one data batch.
               The following 字段 are copied from the Prospect file: AgencyID, LastName, FirstName,
               MiddleInitial, Gender, AddressLine1, AddressLine2, PostalCode, City, State, Country,
               Phone, Income, NumberCars, NumberChildren, MaritalStatus, Age, CreditRating,
               OwnOrRentFlag, Employer, NumberCreditCards, NetWorth.
               SK_RecordDateID is set to the DimDate SK_DateID 字段 that corresponds to the Batch
               Date.
               SK_UpdateDateID is set to the DimDate SK_DateID 字段 that corresponds to the Batch
               Date.
               IsCustomer is set to True or False depending on whether the prospective 客户 记录
               matches a current 客户 记录 in DimCustomer whose status is ‘ACTIVE’ after all
               客户 记录 in the batch have been processed. A Prospect 记录 is deemed to
               match a DimCustomer 记录 if the FirstName, LastName, AddressLine1, AddressLine2
               and PostalCode 字段 all match when upper-cased.


TPC Benchmark™ DI - Standard Specification, Revision 1.1.0                           Page 69 of 117
               MarketingNameplate is set based on other 字段. Zero or more tags are concatenated
               with a “+” character between them if multiple tags apply to a given 客户. For
               示例, a prospect that qualifies for both the “Boomer” tag and the “Spender” tag
               would be assigned the MarketingNameplate 值 “Boomer+Spender”. If multiple tags
               are used they 必须 in the 订单 given below, and if no tags apply the nameplate is
               NULL. The tags are defined as:
                   • HighValue:       NetWorth > 1000000 or Income > 200000
                   • Expenses:        NumberChildren > 3 or NumberCreditCards > 5
                   • Boomer:          Age > 45
                   • MoneyAlert: Income < 50000 or CreditRating < 600 or NetWorth < 100000
                   • Spender:         NumberCars > 3 or NumberCreditCards > 7
                   • Inherited:       Age < 25 and NetWorth > 1000000
               BatchID is set as described in 节 4.4.2.




TPC Benchmark™ DI - Standard Specification, Revision 1.1.0                       Page 70 of 117
4.5.15.2   As the Prospect file is processed, a count is kept of new Prospect 表 行 created. After
           the last 行, a “Status” message is written to the DImessages 表, with the MessageSource
           “Prospect”, MessageText “Inserted 行” and the MessageData 字段 containing the number
           of 行.
4.5.16     StatusType
4.5.16.1   StatusType is a static 表: It is loaded from a file once in the Historical Load and not
           modified again.
4.5.16.2   During the Historical Load, all 行 and 列 of the StatusType.txt file are loaded into the
           corresponding 列 of the StatusType 表, with no modifications.
4.5.17     TaxRate
4.5.17.1   TaxRate is a static 表: It is loaded from a file once in the Historical Load and not modified
           again.
4.5.17.2   During the Historical Load, all 行 and 列 of the TaxRate.txt file are loaded into the
           corresponding 列 of the TaxRate 表, with no modifications.
4.5.18     TradeType
4.5.18.1   TradeType is a static 表: It is loaded from a file once in the Historical Load and not
           modified again.
4.5.18.2   During the Historical Load, all 行 and 列 of the TradeType.txt file are loaded into the
           corresponding 列 of the TradeType 表, with no modifications.

4.6        Transformation Details for Incremental Updates
4.6.1      DimAccount
4.6.1.1    DimAccount data is obtained from the data file Account.txt. CA_ID is the natural key for the
           Account data. The StatusType 表 will be referenced in the transformation.
4.6.1.2    When CDC_FLAG is “I”, a new DimAccount 记录 is inserted. When CDC_FLAG is “U”, the
           updates to DimAccount are implemented in a history-tracking manner as described in 4.4.1.
4.6.1.3    Updates to associated 客户 记录 require history-tracking updates to all of the
           客户’s accounts where IsCurrent=1. The 值 of SK_CustomerID 必须 set to the
           值 of DimCustomer.SK_CustomerID in the newest 客户 记录. If the 客户’s
           status has changed to inactive, then the Status of all associated accounts 必须 set to
           ‘INACTIVE’.
Note:      More than one update to the same Account 可 occur during this phase (i.e. on the same
           day) and 应 be handled as described in 4.4.1.5.
4.6.1.4    When populating 字段 of the DimAccount 表:
               AccountID, AccountDesc and TaxStatus 字段 are copied from CA_ID, CA_NAME and
               CA_TAX_ST respectively.
               SK_BrokerID and SK_CustomerID are set by obtaining surrogate keys by matching
               CA_B_ID with DimBroker.BrokerID where IsCurrent = 1 and CA_C_ID with
TPC Benchmark™ DI - Standard Specification, Revision 1.1.0                            Page 71 of 117
               DimCustomer.CustomerID where IsCurrent = 1. The BrokerID and CustomerID matches
               are guaranteed to succeed due to the referential integrity of the OLTP 数据库. This
               dependency of DimAccount on DimCustomer requires that any update to a 客户’s
               DimCustomer 记录 必须 completed before updates to that 客户’s DimAccount
               记录.
               Status is copied from ST_NAME of the StatusType 表 by matching CA_ST_ID with ST_ID
               of the StatusType 表.
               IsCurrent, EffectiveDate, and EndDate are set as described in 节 4.4.1.
               BatchID is set as described in 节 4.4.2.
4.6.2      DimBroker
4.6.2.1    No changes to DimBroker will occur during Incremental Updates.
           Rationale: Although changes to DimBroker might be expected in a “real world” brokerage 仓库, the rate
           of change in this 表 is so low as to be inconsequential to 基准测试 results.

4.6.3      DimCompany
4.6.3.1    No changes to DimCompany will occur during Incremental Updates.
           Rationale: Although changes to DimCompany might be expected in a “real world” brokerage 仓库, the
           rate of change in this 表 is so low as to be inconsequential to 基准测试 results.

4.6.4      DimCustomer
4.6.4.1    DimCustomer data is obtained from the data file Customer.txt. The TaxRate, StatusType, and
           Prospect 表 will be referenced in the transformation. C_ID is the natural key for the
           Customer data. Changes to DimCustomer are implemented in a history-tracking manner.
4.6.4.2    New Customer 记录 in the 输入 data are indicated by CDC_FLAG set to “I”. Existing
           客户 记录 are indicated by CDC_FLAG set to “U”.
Note:      More than one update to the same Customer 可 occur during this phase (i.e. on the same
           day) and 应 be handled as described in 4.4.1.5.
4.6.4.3    When populating 字段 of the DimCustomer 表:
               CustomerID, TaxID, LastName, FirstName, MiddleInitial, Tier, DOB, Email1 and Email2 are
               copied from C_ID, C_TAX_ID, C_L_NAME, C_F_NAME, C_M_NAME, C_TIER, C_DOB,
               C_EMAIL_1, C_EMAIL_2 respectively.
               Gender is obtained from C_GNDR, which is uppercased. Values other than ‘M’ or ‘F’ are
               replaced with ‘U’.
               AddressLine1, AddressLine2, PostalCode, City, StateProv, and Country are copied from
               C_ADLINE1, C_ADLINE2, C_ZIPCODE, C_CITY, C_STATE_PROV, and C_CTRY.
               Status is copied from ST_NAME of the StatusType 表 by matching C_ST_ID with ST_ID
               of the StatusType 表.
               Phone1, Phone2 and Phone3 are created by concatenating 字段. For each n in {1, 2, 3}:
               If C_CTRY_n, C_AREA_n and C_LOCAL_n are not null, Phonen is:
                       '+' + C_CTRY_n + ' (' + C_AREA_n + ') ' + C_LOCAL_n
               If C_CTRY_n is null while C_AREA_n and C_LOCAL_n are not null, Phonen is:
                       '(' + C_AREA_n + ') ' + C_LOCAL_n
TPC Benchmark™ DI - Standard Specification, Revision 1.1.0                                  Page 72 of 117
               If C_AREA_n is null while C_LOCAL_n is not null, Phonen is:
                       C_LOCAL_n
               If any of the above 规则 has been applied and C_EXT_n is not null, Phonen is:
                       Phonen + C_EXT_n
               If none of the above 规则 has been applied, Phonen is null
               NationalTaxRateDesc and NationalTaxRate are copied from TX_NAME and TX_RATE
               respectively by matching C_NAT_TX_ID with TX_ID.
               LocalTaxRateDesc and LocalTaxRate are copied from TX_NAME and TX_RATE respectively
               by matching C_LCL_TX_ID with TX_ID.
               AgencyID, CreditRating, NetWorth, MarketingNameplate: If demographic data for this
               客户 has been present in the Prospect file for this DI batch or for any previous batch,
               the latest AgencyID, CreditRating and NetWorth 值 will be copied to DimCustomer
               and the MarketingNameplate will be set according to the latest 值 using the same
               process defined for the data 仓库 Prospect 表. A Prospect 记录 is deemed to
               match a DimCustomer 记录 if the FirstName, LastName, AddressLine1, AddressLine2
               and PostalCode 字段 all match the corresponding 字段 in DimCustomer when upper-
               cased. The IsCustomer 字段 in the Prospect 表 needs to be updated to reflect the
               current state for the corresponding prospect 记录, as defined in Clause 4.6.14
               IsCurrent, EffectiveDate, and EndDate are set as described in 节 4.4.1.
               BatchID is set as described in 节 4.4.2.
4.6.4.4    A 记录 will be reported in the DImessages 表 if a 客户’s Tier is not one of the valid
           值 (1,2,3). The MessageSource is “DimCustomer”, the MessageType is “Alert” and the
           MessageText is “Invalid 客户 tier”. The MessageData 字段 is “C_ID = ” followed by the
           key 值 of the 记录, then “, C_TIER = ” and the C_TIER 值.
4.6.4.5    A 记录 will be reported in the DImessages 表 if a 客户’s DOB is invalid. A 客户’s
           DOB is invalid if DOB < Batch Date – 100 years or DOB > Batch Date (客户 over 100 years
           old or born in the future). The MessageSource is “DimCustomer”, the MessageType is “Alert”
           and the MessageText is “DOB out of range”. The MessageData 字段 is “C_ID = ” followed by
           the key 值 of the 记录, then “, C_DOB = ” and the C_DOB 值.
4.6.5      DimDate
4.6.5.1    The DimDate 表 is not altered by Incremental Updates.
4.6.6      DimSecurity
4.6.6.1    No changes to DimSecurity will occur during Incremental Updates.
           Rationale: Although changes to DimSecurity might be expected in a “real world” brokerage 仓库, the rate
           of change in this 表 is so low as to be inconsequential to 基准测试 results.




TPC Benchmark™ DI - Standard Specification, Revision 1.1.0                                   Page 73 of 117
4.6.6.2    The DimTime 表 is not altered by Incremental Updates.
4.6.7      DimTrade
4.6.7.1    DimTrade data is obtained from the Trade.txt file. When CDC_FLAG is “I”, a new DimTrade
           记录 is inserted. When CDC_FLAG is “U”, the existing DimTrade 记录 whose TradeID
           matches the incoming T_ID is updated.
4.6.7.2    When populating 字段 of the DimTrade 表:
               If this is a new Trade 记录 (CDC_FLAG = “I”) then SK_CreateDateID and
               SK_CreateTimeID 必须 set based on T_DTS. SK_CloseDateID and SK_CloseTimeID
               必须 set to NULL.
               If T_ST_ID is “CMPT” or “CNCL”, SK_CloseDateID and SK_CloseTimeID 必须 set based
               on T_DTS.
               TradeID, CashFlag, Quantity, BidPrice, ExecutedBy, TradePrice, Fee, Commission and Tax
               are copied from T_ID, T_IS_CASH, T_QTY, T_BID_PRICE, T_EXEC_NAME, T_TRADE_PRICE,
               T_CHRG, T_COMM and T_TAX respectively.
               Status is copied from ST_NAME of the StatusType 表 by matching T_ST_ID with ST_ID.
               Type is copied from TT_NAME of the TradeType 表 by matching T_TT_ID with TT_ID.
               SK_SecurityID and SK_CompanyID are copied from SK_SecurityID and SK_CompanyID of
               the DimSecurity 表 by matching T_S_SYMB with Symbol where IsCurrent = 1. The
               match is guaranteed to succeed due to the referential integrity of the OLTP 数据库.
               Note that these surrogate key 值 应 reference the dimension 记录 that is
               current at the earliest time this TradeID is encountered. If an update to a 记录 is
               required in 订单 to set the SK_CloseDateID and SK_CloseTimeID, these 字段 must not be
               updated. This dependency of DimTrade on DimSecurity requires that any update to a
               security’s DimSecurity 记录 必须 completed before updates to that security’s
               DimTrade 记录.
               SK_AccountID, SK_CustomerID, and SK_BrokerID are copied from the SK_AccountID,
               SK_CustomerID, and SK_BrokerID 字段 of the DimAccount 表 by matching T_CA_ID
               with AccountID where IsCurrent = 1. The match is guaranteed to succeed due to the
               referential integrity of the OLTP 数据库. Note that these surrogate key 值 must
               reference the dimension 记录 that is current at the earliest time this TradeID is
               encountered. If an update to a 记录 is required in 订单 to set the SK_CloseDateID and
               SK_CloseTimeID, these 字段 must not be updated. This dependency of DimTrade on
               DimAccount requires that any update to an account’s DimAccount 记录 必须
               completed before updates to that account’s DimTrade 记录.
               BatchID is set as described in 节 4.4.2 at the time the 记录 is initially created.
4.6.7.3    A 记录 will be reported in the DImessages 表 if a trade’s Commission is not null and
           exceeds TradePrice * Quantity. The MessageSource is “DimTrade”, the MessageType is
           “Alert” and the MessageText is “Invalid trade commission”. The MessageData 字段 is “T_ID =
           ” followed by the key 值 of the 记录, then “, T_COMM = ” and the T_COMM 值.
4.6.7.4    A 记录 will be reported in the DImessages 表 if a trade’s Fee is not null and is larger than
           TradePrice * Quantity. The MessageSource is “DimTrade”, the MessageType is “Alert” and
TPC Benchmark™ DI - Standard Specification, Revision 1.1.0                           Page 74 of 117
           the MessageText is “Invalid trade fee”. The MessageData 字段 is “T_ID = ” followed by the
           key 值 of the 记录, then “, T_CHRG = ” and the T_CHRG 值.
4.6.8      FactCashBalances
4.6.8.1    FactCashBalances data is obtained from the data file CashTransaction.txt. The net effect of
           all cash transactions for a given account on a given day is totaled, and only a single 记录 is
           generated per account that had changes per day.
4.6.8.2    When populating 字段 of the FactCashBalances 表:
               SK_CustomerID and SK_AccountID are obtained from DimAccount by matching CT_CA_ID
               with AccountID, where IsCurrent = 1.
               SK_DateID is set to the DimDate SK_DateID 字段 that corresponds to the Batch Date.
               Cash is calculated as the sum of the prior Cash amount for this account plus the sum of all
               CT_AMT 值 from all transactions in this account on this day. If there is no previous
               FactCashBalances 记录 for the associated account, zero is used.
Note:      The procedure used to determine the new Cash total must account for the possibility that a
           new surrogate key is created in DimAccount since the last cash 事务.
4.6.8.3    BatchID is set as described in 节 4.4.2.
4.6.9      FactHoldings
4.6.9.1    Data for FactHoldings comes from the HoldingHistory.txt file and the DimTrade 表. The
           数量 and 价格 值 reflect the holdings for a particular security after the most recent
           trade. The 客户 can have a positive or negative position (Quantity) as a 结果 of a trade.
4.6.9.2    When populating 字段 of the FactHoldings 表:
               Retrieve the following 值 from DimTrade where HH_T_ID (current trade identifier)
               from the HoldingHistory.txt file matches the TradeID from DimTrade: SK_CustomerID,
               SK_AccountID, SK_SecurityID, SK_CompanyID, SK_DateID, SK_TimeID, and CurrentPrice
               TradeId and CurrentTradeID 值 are supplied by HH_H_T_ID and HH_T_ID
               CurrentHolding – this 值 is supplied by HH_AFTER_QTY
               BatchID is set as described in 节 4.4.2.
4.6.10     FactMarketHistory
4.6.10.1   FactMarketHistory data is primarily obtained from the file DailyMarket.txt. When populating
           字段 of the FactMarketHistory 表:
               ClosePrice, DayHigh, DayLow, and Volume are copied from DM_CLOSE, DM_HIGH,
               DM_LOW, and DM_VOL respectively.
               SK_SecurityID is obtained from DimSecurity by matching the associated security’s current
               记录 DM_S_SYMB with Symbol, where IsCurrent = 1, to return the SK_SecurityID. The
               match is guaranteed to succeed due to the referential integrity of the OLTP 数据库.
               Note that the surrogate key 值 will reference the current security dimension 记录 at
               the time the 记录 from DailyMarket.txt is processed. This dependency of
               FactMarketHistory on DimSecurity requires that any update to a company’s DimSecurity
               记录 必须 completed before updates to the FactMarketHistory 记录.
TPC Benchmark™ DI - Standard Specification, Revision 1.1.0                           Page 75 of 117
               SK_CompanyID is obtained from DimSecurity by matching DM_S_SYMB with Symbol,
               where IsCurrent = 1, to return the SK_CompanyID. The match is guaranteed to succeed
               due to the referential integrity of the OLTP 数据库. Note that the surrogate key 值
               will reference the current company dimension 记录 at the time the 记录 from
               DailyMarket.txt is processed. This dependency of FactMarketHistory on DimSecurity
               requires that any update to a company’s DimSecurity 记录 必须 completed before
               updates to the FactMarketHistory 记录.
               SK_DateID is obtained from DimDate by matching DM_DATE with DateValue to return the
               SK_DateID. The match is guaranteed to succeed because DimDate has been populated
               with 日期 information for all dates relevant to the 基准测试.
               FiftyTwoWeekHigh and SK_FiftyTwoWeekHighDate are determined by finding the highest
               价格 over the last year (approximately 52 weeks) for a given security. The
               FactMarketHistory 表 itself can be used for this comparison. FiftyTwoWeekHigh is set
               to the highest DM_HIGH 值 for any 日期 in the range from DM_DATE back to but not
               including the same 日期 one year earlier. SK_FiftyTwoWeekHighDate is assigned the
               earliest 日期 in the 日期 range upon which this DM_HIGH 值 occurred.
Note:      Over the course of the year, the surrogate key 值 for a security 可 have changed. It is
           not sufficient to simply compare 记录 that share the same SK_SecurityID 值.
               FiftyTwoWeekLow and SK_FiftyTwoWeekLowDate are determined by finding the lowest
               价格 over the last year (approximately 52 weeks) for a given security. The
               FactMarketHistory 表 itself can be used for this comparison. FiftyTwoWeekLow is set
               to the lowest DM_LOW 值 for any 日期 in the range from DM_DATE back to but not
               including the same 日期 one year earlier. SK_FiftyTwoWeekLowDate is assigned the
               earliest 日期 in the 日期 range upon which this DM_LOW 值 occurred.
Note:      Over the course of the year, the surrogate key 值 for a security 可 have changed. It is
           not sufficient to simply compare 记录 that share the same SK_SecurityID 值.
               PERatio is calculated by dividing DM_CLOSE (the closing 价格 for a security on a given
               day) by the sum of the company’s quarterly earnings per share (“eps”) over the previous
               4 quarters prior to DM_DATE. Company quarterly earnings per share data was provided
               by the FINWIRE data source in the EPS 字段 of the ‘FIN’ 记录 type in the Historical Load
               phase data, and 应 exist in the data 仓库 FINANCIAL 表 as a 结果 of the
               Historical Load transformation desribed in 4.5.14. If there are no earnings for this
               company, NULL is assigned to PERatio and an alert condition is raised as described below.
Note:      Over the course of the previous 4 quarters, attributes of securities and companies 可 have
           changed. As a 结果, there 可 be more than one surrogate key 值 used for a security
           and/or company in the target data 仓库 表 during that time period.
               Yield is calculated by dividing the security’s dividend by DM_CLOSE (the closing 价格 for a
               security on a given day), then multiplying by 100 to obtain the percentage. The dividend
               is obtained from DimSecurity by matching DM_S_SYMB with Symbol, where IsCurrent = 1,
               to return the Dividend 字段
               BatchID is set as described in 节 4.4.2.
TPC Benchmark™ DI - Standard Specification, Revision 1.1.0                          Page 76 of 117
4.6.10.2   A 记录 will be reported in the DImessages 表 if there are no earnings found for a
           company. The MessageSource is “FactMarketHistory”, the MessageType is “Alert” and the
           MessageText is “No earnings for company”. The MessageData 字段 is “DM_S_SYMB = ”
           followed by the DM_S_SYMB 值 of the 记录.
4.6.11     FactWatches
4.6.11.1   Data for FactWatches comes from the WatchHistory.txt file. Surrogate keys 必须
           obtained for the Customer, Security and Date dimension references. The 日期 keys show the
           dates the watch was set and removed.
4.6.11.2   Securities can either be added to or removed from a watch list; there is no notion of updating
           a security on a watch list.
4.6.11.3   When a security is added to a watch list, as indicated by W_ACTION = “ACTV”, surrogate keys
           from the DimCustomer, DimSecurity and DimDate are inserted based on the following:
               SK_CustomerID – each watch list is associated with a 客户. W_C_ID can be used to
               match the associated DimCustomer 记录, W_C_ID = C_ID where IsCurrent=1, to obtain
               SK_CustomerID.
               SK_SecurityID – W_S_SYMB can be used to match the current associated DimSecurity
               记录, W_SYMB = Symbol where IsCurrent=1, to obtain SK_ SecurityID.
               SK_DateID_DatePlaced – set based on W_DTS.
               SK_DateID_DateRemoved – set to NULL.
               BatchID is set as described in 节 4.4.2.
4.6.11.4   When a security is removed from a watch list, as indicated by W_ACTION = “CNCL”, the
           FactWatches 记录 to update is located by finding the surrogate keys corresponding to
           W_C_ID and W_S_SYMB, bearing in mind that the 客户 SK 值 or the company SK
           值 many have changed since the watch was set; then the following action is required:
               SK_DateID_DateRemoved – set based on W_DTS.
               BatchID is set as described in 节 4.4.2.
4.6.12     Industry
4.6.12.1   The Industry 表 is not altered by Incremental Updates.
4.6.13     Financial
4.6.13.1   No changes to the Financial 表 will occur during Incremental Updates.
           Rationale: Although changes to Financial might be expected in a “real world” brokerage 仓库, the rate of
           change in this 表 is so low as to be inconsequential to 基准测试 results.




TPC Benchmark™ DI - Standard Specification, Revision 1.1.0                                    Page 77 of 117
4.6.14     Prospect
4.6.14.1   Prospect 表 data is obtained from the Prospect file. AgencyID is a unique identifier
           assigned by the agency providing the data feed. Because it is a unique identifier, the
           AgencyID alone is sufficient to determine whether this prospective 客户 has been seen
           in the 输入 file in a previous batch. If so, the corresponding 记录 in the Prospect 表 is
           updated with the new 值; if not, a new 记录 is created. An AgencyID 值 will not be
           repeated within one data batch.
               The following 字段 are copied from the Prospect file: AgencyID, LastName, FirstName,
               MiddleInitial, Gender, AddressLine1, AddressLine2, PostalCode, City, State, Country,
               Phone, Income, NumberCars, NumberChildren, MaritalStatus, Age, CreditRating,
               OwnOrRentFlag, Employer, NumberCreditCards, NetWorth.
               SK_RecordDateID is set to the DimDate SK_DateID 字段 that corresponds to the Batch
               Date.
               SK_UpdateDateID is set to the DimDate SK_DateID 字段 that Batch Date if this is the first
               time this AgencyID 值 has appeared in the Prospect file or if this AgencyID 值 has
               appeared before and the 值 of any of the following 字段 are different from prior
               saved 值 for the same AgencyID 值 in the Prospects 表: LastName, FirstName,
               MiddleInitial, Gender, AddressLine1, AddressLine2, PostalCode, City, State, Country,
               Phone, Income, NumberCars, NumberChildren, MaritalStatus, Age, CreditRating,
               OwnOrRentFlag, Employer, NumberCreditCards, NetWorth. Otherwise, SK_UpdateDateID
               retains its prior saved 值.
               IsCustomer is set to True or False depending on whether the prospective 客户 记录
               matches a current 客户 记录 in DimCustomer whose status is ‘ACTIVE’ after all
               客户 记录 in the batch have been processed. A Prospect 记录 is deemed to
               match a DimCustomer 记录 if the FirstName, LastName, AddressLine1, AddressLine2
               and PostalCode 字段 all match when upper-cased.
               MarketingNameplate is set based on other 字段. Zero or more tags are concatenated
               with a “+” character between them if multiple tags apply to a given 客户. For
               示例, a prospect that qualifies for both the “Boomer” tag and the “Spender” tag
               would be assigned the MarketingNameplate 值 “Boomer+Spender”. If multiple tags
               are used they 必须 in the 订单 given below, and if no tags apply the nameplate is
               NULL. The tags are defined as:
                   • HighValue:        NetWorth > 1000000 or Income > 200000
                   • Expenses:         NumberChildren > 3 or NumberCreditCards > 5
                   • Boomer:           Age > 45
                   • MoneyAlert: Income < 50000 or CreditRating < 600 or NetWorth < 100000
                   • Spender:          NumberCars > 3 or NumberCreditCards > 7
                   • Inherited:        Age < 25 and NetWorth > 1000000
               BatchID is set as described in 节 4.4.2.




TPC Benchmark™ DI - Standard Specification, Revision 1.1.0                           Page 78 of 117
4.6.14.2   Three messages are written to the DImessages 表 by this transformation.
               As the Prospect file is processed, the number of source 行 is counted. After the last
               行, a “Status” message is written to the DImessages 表, with the MessageSource
               “Prospect”, MessageText “Source 行” and the MessageData 字段 containing the
               number of 行.
               As the Prospect file is processed, a count is kept of new Prospect 表 行 created.
               After the last 行, a “Status” message is written to the DImessages 表, with the
               MessageSource “Prospect”, MessageText “Inserted 行” and the MessageData 字段
               containing the number of 行.
               As the Prospect file is processed, a count is kept of the number or 行 in the Prospect
               表 updated due to changed 值 from the Prospect file. (These are the same 行
               that cause SK_UpdateDateID to be updated.) This count does not include 行 updated
               because the IsCustomer status changed while no 输入 值 changed. Newly inserted
               行 are also excluded from this count. After the last 行, a “Status” message is written
               to the DImessages 表, with the MessageSource “Prospect”, MessageText “Updated
               行” and the MessageData 字段 containing the number of 行.
4.6.15     StatusType
4.6.15.1   The StatusType 表 is not altered by Incremental Updates.
4.6.16     TaxRate
4.6.16.1   The TaxRate 表 is not altered by Incremental Updates.
4.6.17     TradeType
4.6.17.1   The TradeType 表 is not altered by Incremental Updates.




TPC Benchmark™ DI - Standard Specification, Revision 1.1.0                         Page 79 of 117
                     Clause 5: Description of the System Under Test

5.1        Overview
           The DI 基准测试 uses data in a Staging Area as a starting point and places transformed data
           into a Data Warehouse. The guiding principle is that anything that has an effect on the
           processes involved in moving and transforming the data from the Staging Area to the Data
           Warehouse is 零件 of the System Under Test and is defined in the following sections.

5.2        Definition of the System Under Test
5.2.1      The System Under Test (SUT) consists of all 硬件 and 软件 that supports the function
           of the Staging Area, DI System and Data Warehouse. Any Network that is used for the
           communication between the Staging Area, DI System and Data Warehouse is 零件 of the
           SUT.
Note:      The intent of this 节 is to ensure that everything used in the measured phases of the
           基准测试 is included in the SUT. Data generation is not a measured phase of the
           基准测试.
5.2.2      There are many possible configurations of the SUT. The Staging Area, DI System, and Data
           Warehouse 可 run on a physical server or servers, or virtual servers. Supporting functions
           可 include storage, network, communications, bridges, routers, etc. used in the measured
           phases of the 基准测试.
           Rationale: The following diagrams are examples of possible configurations, not a comprehensive list.




           Figure 5.2-1: SUT 配置 using separate environments for each function


TPC Benchmark™ DI - Standard Specification, Revision 1.1.0                                      Page 80 of 117
           Figure 5.2-2: SUT 配置 using a single environment for all functions




           Figure 5.2-3: SUT 配置 using a single physical environment and multiple virtual
           environments.




TPC Benchmark™ DI - Standard Specification, Revision 1.1.0                         Page 81 of 117
                                           Clause 6: DIGen

6.1        Overview
           DIGen is the data generator program provided by the TPC for creating Source Data and 审计
           information. The Source Data and 审计 information used for this 基准测试 必须
           created using DIGen.
           DIGen is a specific 实现 built on top of the Parallel Data Generation Framework
           (PDGF), which is provided and maintained by Bankmark (www.bankmark.de). PDGF is a
           generic data generation framework that provides a core set of data generation capabilities
           that were extended to generate data with the specific characteristics required by TPC-DI.

6.2        Compliant DIGen Versions
6.2.1      The Source Data used for the 基准测试 必须 generated by DIGen.
6.2.2      Modifications to DIGen are not allowed.
6.2.3      The version of the 规范 and DIGen must match.
           DIT- 6-1: Version of the data generator
6.2.4      The version of PDGF that is included with DIGen 必须 used.
6.2.5      Any error in a compliant version of DIGen, as provided by the TPC, is deemed to be in
           合规 with the 规范. Therefore, any such errors 可 not serve as the basis for a
           合规 challenge.
6.2.6      A Java Virtual Machine (JVM) compliant to a minimum of Java SE 7 必须 used with DIGen
           to create the Source Data.
6.2.7      DIGen has been tested on a variety of platforms. None-the-less, it is impossible to guarantee
           that DIGen is functionally correct in all aspects or will run correctly on all platforms. It is the
           test sponsor’s responsibility to ensure DIGen runs correctly in their environment(s).

6.2.8      To submit an issue (bugs or enhancements), the test sponsor must:
               1. Document the exact nature of the issue.
               2. Document the exact nature of the proposed fix.
               3. Contact the TPC Administrator with the above specified documentation (hard or soft
                  copy is acceptable). The Sponsor must provide return contact information (e.g.
                  Name, Address, Phone number, Email)




TPC Benchmark™ DI - Standard Specification, Revision 1.1.0                            Page 82 of 117
6.3        Data Generation Statistics
6.3.1      DIGen will produce a data generation statistics file named “digen_report.txt” as 零件 of the
           data generation process. The statistics file is used to calculate the 指标 and for auditing.
           The file contains:
                   General information about the data generation process
                   Options used during the generation process
                   Row counts generated for each batch.
6.3.2      The data generation statistics file must not be modified.




TPC Benchmark™ DI - Standard Specification, Revision 1.1.0                          Page 83 of 117
                             Clause 7: Execution Rules & Metrics

7.1        Introduction
           This 子句 defines the 执行 规则 and the methods for calculating the 基准测试
           指标.
           A general principle for this 基准测试 is that all information used to perform the
           transformations or populate the Data Warehouse 表 必须 read from the Source Data
           in the Staging Area. No other sources of data are allowed, including data structures or
           caches that might be leftover from prior runs of the 基准测试, whether maintained by the
           数据库, operating 系统, or any other facility.
7.1.1      Wherever timing is called for, timing to a precision of 0.1 second is required (rounded up),
           e.g. 0.01 is reported as 0.1.
7.1.2      There is no interaction permitted between the SUT and any outside 系统 during the
           性能 of the 基准测试, except for
               Keeping login sessions open. A login session 可 only be used to start the 基准测试
               and to monitor its progress.
               Maintaining the 系统 in a network domain.
               Other interactions that clearly do not have a 性能 impact, as long as they are
               disclosed in the FDR under miscellaneous tasks and/or miscellaneous observations.

7.2        Execution phases and measurements
7.2.1      Preparation Phase
           The preparation phase consists of one time tasks needed to prepare the SUT for 执行 of
           the 基准测试. These steps are not included as 零件 of the 基准测试 指标, however they
           必须 reported as tasks in the FDR (see Clause 10.2.2).
7.2.1.1    Staging Area Preparation Step
           In this step, Source Data is prepared in the Staging Area for use in the Benchmark Run.
7.2.1.1.1 The Test Sponsor chooses a Scale Factor 值 to be used in data generation. This 值
          determines the sizes of the source files as described in Section 2.1. Scale Factor 值 must
          be chosen that 结果 in an 耗时 of each Incremental Update phase of 3600 seconds
          or less (see Clause 7.2.2).
           DIT- 7-1: Scale Factor (SF)
7.2.1.1.2 Data generation is performed using the DIGen data generator described in Clause 6. The
          Source Data 可 be generated directly in the Staging Area or it 可 be generated in a
          different location and copied to the Staging Area.
           DIT- 7-2: DIGen command line parameters used to generate the Source Data

TPC Benchmark™ DI - Standard Specification, Revision 1.1.0                         Page 84 of 117
7.2.1.1.3 The same Scale Factor 必须 used when generating Source Data for all phases of a
          Benchmark Run.
7.2.1.2    Data Warehouse Preparation Step
7.2.1.2.1 In this step, tasks are performed that are needed to prepare the environment hosting the
          Data Warehouse for 执行 of the 基准测试. Depending on the needs of the SUT, the
          following are examples of tasks included in this step:
               Changes to 系统 settings of the Data Warehouse environment, e.g. BIOS, OS, and
               driver options.
           DIT- 7-3: Non default 系统 settings
               Installation of the product running the Data Warehouse
           DIT- 7-4: Non default 安装 settings
               Allocation of space on disk
           DIT- 7-5: Instructions to allocate space on disk
               Creation of user accounts on the product hosting the Data Warehouse
           DIT- 7-6: Instructions to create user accounts in product hosting the Data Warehouse
               Allocation of space for Data Warehouse 表
           DIT- 7-7: Instructions on how to allocate space for Data Warehouse 表
7.2.1.3    DI System Preparation Step
7.2.1.3.1 In this step, tasks are performed that are needed to prepare the DI System for 执行 of
          the 基准测试. Depending on the needs of the SUT, the following are examples of tasks
          included in this step:
               Changes to 系统 settings of the DI System environment, e.g. BIOS, OS, and driver
               options
           DIT- 7-8: Non default 系统 settings
               Installation of the data integration product performing the transformations
           DIT- 7-9: Non default 安装 settings
               Allocation of space on disk
           DIT- 7-10: Commands/Scripts to allocate space on disk
               Creating user accounts
           DIT- 7-11: Commands/scripts to create user accounts
               Importing the DI 规范 into the DI System
           DIT- 7-12: Commands/scripts to import the DI 规范


TPC Benchmark™ DI - Standard Specification, Revision 1.1.0                        Page 85 of 117
7.2.2      Benchmark Run
           A valid Benchmark Run consists of the following phases, which 必须 performed in the
           following sequence:
           1. Initialization Phase (Clause 7.2.3)
           2. Historical Load Phase (Clause 7.2.4)
           3. Incremental Update 1 Phase with an 耗时 less than or equal to 3600 seconds
                (Clause 7.2.5)
           4. Incremental Update 2 Phase with an 耗时 less than or equal to 3600 seconds
                (Clause 7.2.5)
           5. Automated Audit Phase (Clause 7.2.6)
           It is not permitted to begin processing of a phase until the previous phase has completed.
7.2.2.1    A Benchmark Run 可 be initiated using an any method for the System Under Test, e.g.
           manual (command lines, graphical interfaces) or automated task 执行.
7.2.2.2    Once initiated, a Benchmark Run must complete all phases without interruption or manual
           intervention.
           Rationale: By having each phase start immediately upon completion of the prior phase, work cannot be
           performed without being timed.

7.2.3      Initialization Phase
           The initialization phase provides a “clean” SUT for each Benchmark Run, with no artifacts
           remaining from previous runs.
7.2.3.1    The Data Warehouse 必须 created as defined in Clause 3.
7.2.3.2    Auxiliary Data Structures 可 be added at the discretion of the Test Sponsor.
7.2.3.3    Tasks specific to the SUT 可 be performed at the discretion of the Test Sponsor.
7.2.3.4    Tasks that require accessing any Source Data in the Staging Area are not allowed.
7.2.3.5    After all initialization steps have been performed, the batch validation described in Clause 7.4
           is executed. Upon completion of the batch validation 查询, a phase completion 记录 (PCR)
           is written to the DImessages 表.
7.2.3.6    The initialization phase is not timed.
7.2.4      Historical Load Phase
7.2.4.1    The Historical Load phase populates Data Warehouse 表 with data by performing the
           transformations specified in Clause 4.5, using data from the Batch1 directory of the Staging
           Area.
7.2.4.2    After all transformations specified in 节 4.5 have been completed, the batch validation
           查询 given in Clause 7.4 is executed. Upon completion of the batch validation 查询, a phase
           completion 记录 (PCR) is written to the DImessages 表.
7.2.4.3    The Historical Load phase is timed as described in Clause 7.5.2.



TPC Benchmark™ DI - Standard Specification, Revision 1.1.0                                   Page 86 of 117
7.2.5      Incremental Update Phases
7.2.5.1    Two Incremental Update phases, Update1 and Update2, 必须 performed in sequence.
7.2.5.2    Update1 and Update2 each perform the transformations specified in Clause 4.6, using data
           from the Batch2 and Batch3 directories of the Staging Area, respectively.
7.2.5.3    After all transformations have been performed, the batch validation 查询 described in
           Clause 7.4 is executed to complete each phase. Upon completion of the batch validation
           查询, a phase completion 记录 (PCR) is written to the DImessages 表.
7.2.5.4    Incremental Updates are timed as described in Clause 7.5.3.1
7.2.6      Automated Audit Phase
7.2.6.1    The automated 审计 phase begins immediately upon completion of the last Incremental
           Update phase.
7.2.6.2    Audit data is generated as 零件 of the Source Data as defined in Clause 2.2.2.20. All 审计 data
           必须 loaded into the Audit 表 defined in Clause 3.2.19 using the following 规则:
                   The first 行 in every 审计 data file contains only the 字段 names, not 审计 data. This
                   记录 可 be used to aid in the load process, but must not be loaded into the Audit
                   表.
                   Each 字段 in the 审计 data 必须 loaded into the cooresponding 列 (the
                   列 of the same name) of the Audit 表.
7.2.6.3    It is permissible to create Auxiliary Data Structures to aid in the 性能 of the
           automated 审计 during this phase.
7.2.6.4    It is not permissible to modify the contents of the Data Warehouse during this phase other
           than loading the Audit 表 as described in Clause 7.2.6.2 and 7.2.6.3.
7.2.6.5    At the beginning of the automated 审计 phase, a final 执行 of the data visibility 1
           查询 (Appendix C) 必须 executed.
7.2.6.6    The 审计 查询 必须 executed, which will perform a set of tests on the Data Warehouse
           to confirm the validity of the 结果 set. The 审计 查询 is given in Appendix A.
7.2.6.7    A valid Benchmark Run must report “OK” status for every test.
           OID- 7-1: Output of the 审计 查询




TPC Benchmark™ DI - Standard Specification, Revision 1.1.0                            Page 87 of 117
7.2.6.8    The 审计 查询 is written to be compatible with most databases that can run SQL queries.
           For 系统 that cannot run the 查询 as supplied, the Test Sponsor must follow the 规则 for
           SQL 合规, outlined in Clause 3.4.11.

7.3        Data Visibility Queries
7.3.1      The data visibility queries are used to verify the visibility of the data written to the Data
           Warehouse (see Clauses 4.3.5.1 and 4.3.5.2). Data collected by the data visibility queries is
           stored in the DImessages 表 and will be examined in the Automated Audit phase. The data
           visibility queries are given in Appendix C.
7.3.2      Beginning at the start of the Incremental Update 1 phase and ending at the conclusion of the
           Incremental Update 2 phase, the data visibility queries 必须 executed at regular intervals
           against the Data Warehouse.
7.3.3      The interval between the start of the Incremental Update 1 phase and the start of the data
           visibility 1 查询 must not exceed five minutes.
7.3.4      The interval between the start of the first data visibility 2 查询 and the start of the data
           visibility 1 查询 (7.3.3) must not exceed five minutes.
7.3.5      The interval between starts of successive executions of the data visibility 2 查询 must not
           exceed five minutes
7.3.6      The interval between the start of the last data visibility 2 查询 and the conclusion of the
           Incremental Update 2 phase must not exceed five minutes.
7.3.7      The data visibility queries 必须 executed using a different Data Warehouse Session than
           the session(s) used by the DI System.
7.3.8      The data visibility queries 可 be initiated using any method for the System Under Test.

7.4        Batch Validation Query
7.4.1      The batch validation 查询 is used to capture information for the purpose of timing and
           validating the correctness of each 执行 phase. The batch validation 查询 is given in
           Appendix B.
7.4.2      The batch validation 查询 is executed multiple times as 零件 of a Benchmark Run. When
           executed as 零件 of a timed phase, the time to execute the 查询 is included as defined in
           Clause 7.2.
7.4.3      The batch validation 查询 writes results into the DImessages 表 defined in Clause 3.2.8,
           which are used in the automated 审计 phase to validate the transformed data in the Data
           Warehouse.
7.4.4      The batch validation 查询 is written to be compatible with most databases that can run SQL
           queries. For 系统 that cannot run SQL queries, the Test Sponsor must follow the 规则 for
           SQL 合规, outlined in Clause 3.4.11.



TPC Benchmark™ DI - Standard Specification, Revision 1.1.0                        Page 88 of 117
7.5        Calculating Throughput
7.5.1      The completion timestamp (CT) of each phase identified by BatchID, CTBatchID (see Clause
           4.4.2) is the 值 in the MessageDateAndTime 字段 of the 记录 in the DImessages 表
           where the MessageType 字段 is ‘PCR’ and the BatchID 字段 is equal to the BatchID for the
           phase. For 示例, the following 查询 could be used to retrieve the CT for the Historical
           Load phase:
               select MessageDateAndTime from DImessages where BatchID = 1 and MessageType = ‘PCR’

7.5.2      Historical Load Throughput
7.5.2.1    The 耗时, expressed in units of seconds, for the Historical Load is EH = CT1 - CT0
           OID- 7-2: Elapsed time of the Historical Load
7.5.2.2    The total number of 行 of Source Data in the Historical Load data set is RH and is reported
           by DIGen as the 行 count for Batch1 (see Clause Error! Reference source not found.).
           OID- 7-3: Total number of 行 of 输入 data in the Historical Load (Batch 1) data set as
           reported by DIGen
7.5.2.3    The 吞吐量 of the Historical Load is TH = RH / EH
           OID- 7-4: The 吞吐量 of the Historical Load
7.5.3      Incremental Update Throughput
7.5.3.1    The elapsed times, expressed in units of seconds, for the Incremental Updates are EI1 = CT2 -
           CT1 and EI2 = CT3 - CT2.
           OID- 7-5: The elapsed times for the Incremental Updates
7.5.3.2    The total number of 行 of Source Data in the Incremental Update data sets are RI1 and RI2,
           and are reported by DIGen as the 行 count for Batch2 and Batch3, respectively (see Clause
           Error! Reference source not found.) .
           OID- 7-6: Total number of 行 of source data in the Incremental Update data sets
7.5.3.3    The throughputs of the Incremental Updates are:
           TI1 = RI1 / Max(EI1, 1800) and TI2 = RI2 / Max(EI2, 1800)
           OID- 7-7: Throughputs of the Incremental Updates
           Rationale: To encourage that a sufficient amount of data is processed, the 基准测试 targets Incremental
           Update elapsed times of a minimum of 1800 seconds. The above formula allows the Test Sponsor to use a
           Benchmark Run with elapsed times less than 1800 seconds and avoid doing another complete run, if they are
           willing to accept the impact of calculating the 吞吐量 using a 值 larger than the actual 耗时. The
           impact is minimized as the 耗时 gets closer to 1800 seconds.




TPC Benchmark™ DI - Standard Specification, Revision 1.1.0                                       Page 89 of 117
7.6        Primary Metrics
7.6.1      Performance Metric
           The 性能 指标 for the 基准测试 is a combined 指标 using the three 吞吐量
           calculations from the timed phases, and is computed as follows:
                 TPC_DI_RPS = Trunc(GeoMean(TH, Min(TI1 , TI2) ) )
                 where:
                       TH is the 吞吐量 of the Historical Load (see Clause 7.5.2)
                       TI1 is the 吞吐量 of Incremental Update 1 (see Clause 7.5.3)
                       TI2 is the 吞吐量 of Incremental Update 2 (see Clause 7.5.3)
                       GeoMean() is the geometric mean of the arguments.
                       Min() is the argument with the least 值.
                       Trunc() is the whole number portion of the argument.
7.6.2      Price/Performance Metric
           The Price/Performance is computed using the 性能 指标 TPC_DI_RPS as follows:
                 Price-per-TPC_DI_RPS = $ / TPC_DI_RPS
                 where:
                          $ is the total 3-year 定价 as described in the effective version of the TPC
                          Pricing 规范 in the reported currency. The list of components to be
                          priced is described in Clause 9.1 of this 规范.
                          TPC_DI_RPS is the combined 吞吐量 指标 defined in Clause 7.6.1
7.6.2.1    The units of Price-per-TPC_DI_RPS are expressed as in the effective version of the TPC Pricing
           Specification. For 示例, in the United States, the 系统 价格 必须 reported in whole
           dollars and the Price-per-TPC_DI_RPS 可 be reported in dollars and cents. Any fraction of a
           unit 必须 raised to the next highest unit (e. g., $12.123 必须 shown as $12.13USD.
7.6.3      Availability Date
7.6.3.1    The Availability Date is the 日期 in which all components of the SUT are generally available, as
           defined in the effective version of the TPC Pricing Specification.




TPC Benchmark™ DI - Standard Specification, Revision 1.1.0                             Page 90 of 117
                 Clause 8: System and Implementation Qualification
           The following set of qualification tests 必须 performed to demonstrate 合规 of the
           SUT.

8.1        Qualification Environment
8.1.1      The qualification tests 必须 performed on the SUT using the same 硬件 and 软件
           components as the 性能 test. No aspect of the SUT (e.g., 系统 parameters,
           硬件 配置, 软件 releases, etc.), other than the Source Data 可 differ
           between this demonstration of 合规 and the 性能 test, unless it is directly
           related to the difference in size of the data being processed.
8.1.2      The components 必须 configured identically to the 性能 test 配置, with
           the exception of adjustments made for the size of the qualification Source Data. For 示例,
           if the Data Warehouse employs partitioning, then the qualification Data Warehouse must
           also employ partitioning in a similar manner, although the number of partitions 可 differ in
           each case.
8.1.3      The Source Data for the qualification tests 必须 generated by DIGen using Scale Factor
           (SF) = 5.
8.1.4      The DI application 必须 the same as that used in the 性能 test.

8.2        Verifying accuracy and 一致性
8.2.1      It is the responsibility of the Test Sponsor to demonstrate that the Data Warehouse was
           implemented as specified and all transformations were performed completely and
           accurately.
8.2.1.1    The TPC provides a comparison tool and expected 结果 data that is used to verify the
           accuracy and 一致性 of test 结果 data. The comparison tool can be obtained from the
           download 节 of the TPC web site. Detailed usage information is provided with the
           comparison tool.
8.2.1.2    Some 字段 are expected to be different from 实现 to 实现 or run to
           run. In these cases the exact 值 are not required to match the expected 结果 set,
           however the semantics of the 字段 必须 correct. The following variances are allowed:
               Fields with meta-type SK_T (surrogate keys) represent unique identifiers for dimension
               表 行. These 可 be generated differently from 系统 to 系统, but key-foreign
               key references 必须 correct.
               The 字段 MessageDateAndTime of the DImessages 表 is set using the current
               timestamp of the run.
               Fields with meta-type BOOLEAN must match the Boolean state, but 可 use different
               值 to indicate True and False.
Note:      The comparison tool allows for these variances.
TPC Benchmark™ DI - Standard Specification, Revision 1.1.0                       Page 91 of 117
8.2.2      Preparing Test Result Data
8.2.2.1    In 订单 to compare the results of a run with the expected 结果 data, the data 必须
           extracted from the Data Warehouse into a set of files to produce the test 结果 data. All files
           必须 pipe (“|”) delimited text files with the 字段 in the 订单 specified by the associated
           extract 查询. The following formatting 必须 used:
               Fields containing NULL 必须 expressed as an empty 字段, e.g. a 行 with 3 字段
               where the second 字段 is NULL would be written as “A||B”
               DATE 字段 必须 formatted as YYYY-MM-DD
               TIME 字段 必须 formatted as hh.mm.ss
8.2.2.2    Files 必须 created as defined below, with contents defined by the associated SQL 查询:


                   File Name                                      Extract Query
             DimAccount.txt         select SK_AccountID, AccountID, SK_BrokerID, SK_CustomerID, Status,
                                    AccountDesc, TaxStatus, IsCurrent, BatchID, EffectiveDate, EndDate
                                    from DimAccount 订单 by AccountID, EffectiveDate
             DimBroker.txt          select SK_BrokerID, BrokerID, ManagerID, FirstName, LastName,
                                    MiddleInitial, Branch, Office, Phone, IsCurrent, BatchID, EffectiveDate,
                                    EndDate from DimBroker 订单 by BrokerID, EffectiveDate
             DimCompany.txt         select SK_CompanyID, CompanyID, Status, Name, Industry, SPrating,
                                    isLowGrade, CEO, AddressLine1, AddressLine2, PostalCode, City,
                                    StateProv, Country, Description, FoundingDate, IsCurrent, BatchID,
                                    EffectiveDate, EndDate from DimCompany 订单 by CompanyID,
                                    EffectiveDate
             DimCustomer.txt        select SK_CustomerID, CustomerID, TaxID, Status, LastName, FirstName,
                                    MiddleInitial, Gender, Tier, DOB, AddressLine1, AddressLine2,
                                    PostalCode, City, StateProv, Country, Phone1, Phone2, Phone3, Email1,
                                    Email2, NationalTaxRateDesc, NationalTaxRate, LocalTaxRateDesc,
                                    LocalTaxRate, AgencyID, CreditRating, NetWorth, MarketingNameplate,
                                    IsCurrent, BatchID, EffectiveDate, EndDate from DimCustomer 订单 by
                                    CustomerID, EffectiveDate
             DimDate.txt            select SK_DateID, DateValue, DateDesc, CalendarYearID,
                                    CalendarYearDesc, CalendarQtrID, CalendarQtrDesc, CalendarMonthID,
                                    CalendarMonthDesc, CalendarWeekID, CalendarWeekDesc,
                                    DayOfWeekNum, DayOfWeekDesc, FiscalYearID, FiscalYearDesc,
                                    FiscalQtrID, FiscalQtrDesc, HolidayFlag from DimDate 订单 by
                                    DateValue
             DimSecurity.txt        select SK_SecurityID, Symbol, Issue, Status, Name, ExchangeID,
                                    SK_CompanyID, SharesOutstanding, FirstTrade, FirstTradeOnExchange,
                                    Dividend, IsCurrent, BatchID, EffectiveDate, EndDate from DimSecurity
                                    订单 by Symbol, EffectiveDate
             DimTime.txt            select SK_TimeID, TimeValue, HourID, HourDesc, MinuteID, MinuteDesc,
                                    SecondID, SecondDesc, MarketHoursFlag, OfficeHoursFlag from
                                    DimTime 订单 by TimeValue

TPC Benchmark™ DI - Standard Specification, Revision 1.1.0                                     Page 92 of 117
             DimTrade.txt            select TradeID, SK_BrokerID, SK_CreateDateID, SK_CreateTimeID,
                                     SK_CloseDateID, SK_CloseTimeID, Status, Type, CashFlag, SK_SecurityID,
                                     SK_CompanyID, Quantity, BidPrice, SK_CustomerID, SK_AccountID,
                                     ExecutedBy, TradePrice, Fee, Commission, Tax, BatchID from DimTrade
                                     订单 by TradeID, Status
             FactCashBalances.txt    select FCB.SK_CustomerID, FCB.SK_AccountID, FCB.SK_DateID,
                                     FCB.Cash, FCB.BatchID from FactCashBalances as FCB left outer 连接
                                     DimAccount as DA on FCB.SK_AccountID=DA.SK_AccountID left outer
                                     连接 DimCustomer as DC on FCB.SK_CustomerID=DC. SK_CustomerID left
                                     outer 连接 DimDate as DD on FCB.SK_DateID=DD.SK_DateID 订单 by
                                     DA.AccountID, DD.DateValue
             FactHoldings.txt        select FH.TradeID, FH.CurrentTradeID, FH.SK_CustomerID,
                                     FH.SK_AccountID, FH.SK_SecurityID, FH.SK_CompanyID, FH.SK_DateID,
                                     FH.SK_TimeID, FH.CurrentPrice, FH.CurrentHolding, FH.BatchID from
                                     FactHoldings as FH left outer 连接 DimTrade as DT on
                                     FH.TradeID=DT.TradeID left outer 连接 DimAccount as DA on
                                     FH.SK_AccountID=DA. SK_AccountID left outer 连接 DimCustomer as DC
                                     on FH. SK_CustomerID = DC. SK_CustomerID left outer 连接 DimSecurity
                                     as DS on FH.SK_SecurityID=DS.SK_SecurityID left outer 连接 DimCompany
                                     as DCo on FH.SK_CompanyID=DCo.SK_CompanyID left outer 连接
                                     DimDate as DD on FH.SK_DateID=DD.SK_DateID left outer 连接 DimTime
                                     as DT on FH.SK_TimeID=DT.SK_TimeID 订单 by FH.TradeID,
                                     DD.DateValue, DT.TimeValue
             FactMarketHistory.txt   select FM.SK_SecurityID, FM.SK_CompanyID, FM.SK_DateID,
                                     FM.PERatio, FM.Yield, FM.FiftyTwoWeekHigh,
                                     FM.SK_FiftyTwoWeekHighDate, FM.FiftyTwoWeekLow,
                                     FM.SK_FiftyTwoWeekLowDate, FM.ClosePrice, FM.DayHigh,
                                     FM.DayLow, FM.Volume, FM.BatchID from FactMarketHistory as FM left
                                     outer 连接 DimSecurity as DS on FM.SK_SecurityID=DS.SK_SecurityID left
                                     outer 连接 DimCompany as DCo on
                                     FM.SK_CompanyID=DCo.SK_CompanyID left outer 连接 DimDate as DD
                                     on FM.SK_DateID=DD.SK_DateID 订单 by DS.Symbol, DD.DateValue
             FactWatches.txt         select FW.SK_CustomerID, FW.SK_SecurityID,
                                     FW.SK_DateID_DatePlaced, FW.SK_DateID_DateRemoved, FW.BatchID
                                     from FactWatches as FW left outer 连接 DimSecurity as DS on
                                     FW.SK_SecurityID=DS.SK_SecurityID left outer 连接 DimCustomer as DC
                                     on FW.SK_CustomerID=DC.SK_CustomerID left outer 连接 DimDate as DD
                                     on FW.SK_DateID_DatePlaced=DD.SK_DateID 订单 by DC.CustomerID,
                                     DS.Symbol, DD.DateValue
             Financial.txt           select FIN.SK_CompanyID, FIN.FI_YEAR, FI_QTR,
                                     FIN.FI_QTR_START_DATE, FIN.FI_REVENUE, FI_NET_EARN,
                                     FIN.FI_BASIC_EPS, FIN.FI_DILUT_EPS, FIN.FI_MARGIN,
                                     FIN.FI_INVENTORY, FIN.FI_ASSETS, FIN.FI_LIABILITY, FIN.FI_OUT_BASIC,
                                     FIN.FI_OUT_DILUT from Financial as FIN left outer 连接 DimCompany as
                                     DC on FIN.SK_CompanyID=DC.SK_CompanyID 订单 by DC.CompanyID,
                                     FIN.FI_QTR_START_DATE
             Prospect.txt            select P.AgencyID, P.SK_RecordDateID, P.SK_UpdateDateID, P.BatchID,
                                     P.IsCustomer, P.LastName, P.FirstName, P.MiddleInitial, P.Gender,
                                     P.AddressLine1, P.AddressLine2, P.PostalCode, P.City, P.State, P.Country,

TPC Benchmark™ DI - Standard Specification, Revision 1.1.0                                     Page 93 of 117
                                    P.Phone, P.Income, P.NumberCars, P.NumberChildren, P.MaritalStatus,
                                    P.Age, P.CreditRating, P.OwnOrRentFlag, P.Employer,
                                    P.NumberCreditCards, P.NetWorth, P.MarketingNameplate from
                                    Prospect as P left outer 连接 DimDate as DD on
                                    P.SK_UpdateDateID=DD.SK_DateID 订单 by P.LastName, P.FirstName,
                                    DD.DateValue
             DImessages.txt         select MessageDateAndTime, BatchID, MessageSource, MessageText,
                                    MessageType, MessageData from DImessages where MessageType <>
                                    ‘Visibility’ 订单 by BatchId, MessageSource, MessageText, MessageData



Note:      The extract queries are written to be compatible with most databases that can run SQL
           queries. For 系统 that cannot run these SQL queries, the test sponsor must follow the
           规则 for SQL 合规, outlined in Clause 3.4.11.

8.3        Transformation Accuracy
8.3.1      To validate the 合规 of the DI application, a complete Benchmark Run 必须
           executed by the Test Sponsor using the qualification environment.
8.3.2      The qualification run test results 必须 created and verified for accuracy and 一致性 as
           described in Clause 8.2.
8.3.3      The qualification run test 结果 data must match the expected results; otherwise, the DI
           application is not compliant.

8.4        Durability
           The Test Sponsor is required to guarantee that the Staging Area and the Data Warehouse
           will preserve the data integrity and 一致性 after 恢复 from each of the failures listed
           below, see Clauses 2.4.1 and 3.4.6.
8.4.1      Durability tests
           For each of the failure conditions defined below, the Test Sponsor will perform a Benchmark
           Run using the qualification environment.
8.4.1.1    Staging Area failures
8.4.1.1.1 Access to the Source Data files 必须 maintained throughout a permanent irrecoverable
          failure of any single Durable Medium containing Source Data of the Staging Area. To
          demonstrate 合规 the following procedure 必须 followed:
               1. Start a Benchmark Run using the qualification environment.
               2. Induce the failure prior to the run completing. The run must continue to completion.
               3. Create and verify the test 结果 data as described in Clause 8.2.
               The test 结果 data must match the expected results; otherwise, the Staging Area is not
               compliant.
TPC Benchmark™ DI - Standard Specification, Revision 1.1.0                                 Page 94 of 117
8.4.1.1.2 In the event of a loss of all external power to the Staging Area for an indefinite period of
          time, the Source Data 必须 preserved. To demonstrate 合规 the following
          procedure 必须 followed:
               1. Induce the failure and recover the Staging Area Server.
               2. Start a Benchmark Run using the qualification environment.
               3. Create and verify the test 结果 data as described in Clause 8.2.
               The test 结果 data must match the expected results; otherwise, the Staging Area is not
               compliant.
8.4.1.2    Data Warehouse failures
           If ACID 合规 is demonstrated per Clause 3.4.10.2, it is not necessary to perform these
           tests.
8.4.1.2.1 The Data Warehouse must maintain 一致性 after a permanent irrecoverable failure of
          any single Durable Medium containing data of the Data Warehouse. To demonstrate
          合规 the following procedure 必须 followed:
               1. Start a Benchmark Run using the qualification environment.
               2. Wait until the second Incremental Update phase is executing and ensure the DI
                  application has committed some data to the Data Warehouse but has not completed
                  all transformations.
               3. Induce the failure. If necessary, recover the Data Warehouse.
               4. Create and verify the test 结果 data as described in Clause 8.2.
               Depending on the 实现 and the time the failure is induced, there 可 be some
               transformations that have been completed entirely, some that have been partially
               completed, and others that have not yet been performed. Therefore, the test 结果 data
               必须 a subset of the expected 结果 data. All data that exists in the test 结果 data
               must match the expected 结果 data, i.e. differences in the files can only be due to
               记录 that are missing entirely from the test 结果 data.
               The following files must match completely:
                       DimBroker
                       DimCompany
                       DimDate
                       DimSecurity
                       DimTime
                       Financial
                       Files containing only data produced by transformations indicated by the DI System
                       as complete

               Files that contain only a subset of the expected 结果 data 必须 verified to contain the
               correct number of 记录. The number of 记录 that have been created or modified in
TPC Benchmark™ DI - Standard Specification, Revision 1.1.0                             Page 95 of 117
               the second incremental update phase (i.e. where BatchID = 3) must match the number of
               记录 that the DI System indicates have been committed to the Data Warehouse
               during this phase.

Note:      Various methods can be used by the DI System to indicate the status of the transformations,
           e.g. log files or DI application created 审计 files.

           If the above conditions are not met, the Data Warehouse is not compliant.

8.4.1.2.2 The Data Warehouse must maintain 一致性 after loss of all external power to the Data
          Warehouse Server for an indefinite time period. To demonstrate 合规 the following
          procedure 必须 followed:
               1. Start a Benchmark Run using the qualification environment.
               2. Wait until the second Incremental Update phase is executing and ensure the DI
                  application has committed some data to the Data Warehouse but has not completed
                  all transformations in the phase.
               3. Induce the failure. Recover the Data Warehouse.
               4. Create and verify the test 结果 data as described in Clause 8.2.
               Depending on the 实现 and the time the failure is induced, there 可 be some
               transformations that have been completed entirely, some that have been partially
               completed, and others that have not yet been performed. Therefore, the test 结果 data
               必须 a subset of the expected 结果 data. All data that exists in the test 结果 data
               must match the expected 结果 data, i.e. differences in the files can only be due to
               记录 that are missing entirely from the test 结果 data.
               The following files must match completely:
                       DimBroker
                       DimCompany
                       DimDate
                       DimSecurity
                       DimTime
                       Financial
                       Files containing only data produced by transformations indicated by the DI System
                       as complete

               Files that contain only a subset of the expected 结果 data 必须 verified to contain the
               correct number of 记录. The number of 记录 that have been created or modified in
               the second incremental update phase (i.e. where BatchID = 3) must match the number of
               记录 that the DI System indicates have been committed to the Data Warehouse
               during this phase.

TPC Benchmark™ DI - Standard Specification, Revision 1.1.0                             Page 96 of 117
Note:      Various methods can be used by the DI System to indicate the status of the transformations,
           e.g. log files or DI application created 审计 files.

           If the above conditions are not met, the Data Warehouse is not compliant.




TPC Benchmark™ DI - Standard Specification, Revision 1.1.0                       Page 97 of 117
                                           Clause 9: Pricing
           Rules for 定价 the Priced Configuration and associated 软件 and 维护 are
           included in the effective version of the TPC Pricing Specification, located at www.tpc.org. The
           following 要求 are intended to supplement the Pricing Specification:

9.1        Priced Configuration
9.1.1      The 系统 to be priced 应 include the 硬件 and 软件 Components present in the
           System Under Test (SUT), additional operational Components configured on the test 系统,
           DI application development 软件, and 维护 on all of the above.
9.1.2      Specifically, the Priced Configuration consists of:
               1. All 软件 and 硬件 components of the SUT, as tested and defined in Clause 5.
               2. The on-line storage for the Staging Area, DI System, and Data Warehouse as
                  described in Clause 9.2 and storage for all 软件 included in the Priced
                  Configuration.
               3. Additional products (软件 or 硬件) required for customary operation,
                  administration and 维护 of the SUT.
               4. All 软件 required to execute and administer the DI application.
               5. Software required to create or modify, prepare, and translate DI specifications into a
                  DI application format for a minimum of 5 concurrent users.
9.1.2.1    Specifically excluded from the priced 系统 are:
               1.   End-user communication devices and related cables, connectors, and concentrators.
               2.   Equipment and tools used exclusively for the 执行 of DIGen.
               3.   Hardware used exclusively to develop the DI application.
               4.   Equipment and tools used exclusively in the production of the full disclosure report.



9.2        On-line Storage Requirement
9.2.1      Continuous Operation Requirement
           Within the Priced Configuration, there 必须 sufficient on-line storage to support:
                    The Staging Area with generated Source Data for the Historical Load run and two
                    Incremental Update runs.
                    The required data transformations, including temporary and intermediate storage
                    used by the DI System and DI Application.
                    The fully populated Data Warehouse after completing all 基准测试 执行 steps
                    defined in Clause 7, plus an additional 7 Incremental Update runs as required by
                    Clause 3.4.9.4.
TPC Benchmark™ DI - Standard Specification, Revision 1.1.0                          Page 98 of 117
9.2.2      Archive Operation Requirement
           TPC-DI has no 要求 for 定价 additional archive storage.
9.2.3      Back-up Storage Requirements
           TPC-DI has no 要求 for on-line back-up data capabilities in the Priced Configuration.



9.3        TPC-DI Specific Pricing Requirements
9.3.1      Additional Operational Components
9.3.1.1    Additional products that might be included on a 客户 installed 配置, such as
           operator consoles and magnetic tape drives, are also to be included in the priced 系统 if
           explicitly required for the operation, administration, or 维护, of the priced 系统.
9.3.1.2    Copies of the 软件, on appropriate media, and a 软件 load device, if required for
           initial load or 维护 updates, 必须 included.
9.3.1.3    Uninterruptible Power Supply specifically contributing to a Data Durability solution, 必须
           included (see Clause 3.4.6).
9.3.1.4    All components, including cables, used to interconnect components of the SUT 必须
           included.
9.3.2      Additional Software
9.3.2.1    All 软件 required to create or modify, prepare, and translate DI specifications into a DI
           application format for a minimum of 5 concurrent users, 必须 included. This includes the
           DI System development 软件, compilers, 数据库 client libraries, etc.



9.4        Component Substitution
9.4.1      Substitution is defined as a deliberate act to replace components of the Priced Configuration
           by the Test Sponsor as a 结果 of failing the 可用性 要求 of the TPC Pricing
           Specification or when the Part Number for a 组件 changes.
9.4.2      Hardware or Software product Substitutions within the SUT, with the exceptions noted below
           require the 基准测试 to be re-run with the new Components in 订单 to reestablish
           合规.
9.4.3      Corrections or "fixes" to components of the Priced Configuration are often required during
           the life of products. These changes are not considered Substitutions so long as the Part
           Number of the priced 组件 does not change. Suppliers of 硬件 and 软件 可
           update the components of the Priced Configuration, but these updates must not impact the
           Reported Throughput. The following are not considered Substitutions:
                    软件 patches to resolve a security vulnerability
                    silicon revision to correct errors

TPC Benchmark™ DI - Standard Specification, Revision 1.1.0                         Page 99 of 117
                   new 供应商 of functionally equivalent components (i.e. memory chips, disk drives,
                   ...)

9.4.4      Some 硬件 components of the Priced Configuration 可 be substituted after the Test
           Sponsor has demonstrated to the Auditor's satisfaction that the substituting components do
           not negatively impact the Reported Throughput. All Substitutions 必须 reported in the
           FDR and noted in the Auditor's Attestation Letter. The following 硬件 components 可
           be substituted:
                  Durable Medium
                  Durable Medium Enclosure
                  Network interface card
                  Router
                  Bridge
                  Repeater

9.4.5      Substitutions will be open to challenge for a 60-day period.




TPC Benchmark™ DI - Standard Specification, Revision 1.1.0                       Page 100 of 117
                                Clause 10: Full Disclosure Report

10.1       Full Disclosure Report Requirements
10.1.1     A Full Disclosure Report (FDR) is required. This 节 specifies the 要求 for the FDR.
           The FDR is a zip file of a directory structure containing the following:
               A Report in Adobe Acrobat PDF format,
               An Executive Summary Statement in Adobe Acrobat PDF format,
               A Supporting Files Archive consisting of various source files, scripts, and listing files.

10.2       General Requirements
10.2.1     The FDR must include all information of all steps necessary to i) configure the SUT as it was
           configured during the 基准测试 执行, ii) modify the 系统, user, and application
           environments, iii) run the TPC-DI 基准测试 according to the TPC-DI 规范, iv) verify
           that the 基准测试 执行 was conducted according to the TPC-DI 规范, and v)
           compute all 基准测试 metrics. Configuring the SUT is defined as the process of modifying
           the priced 配置 to 实现 TPC-DI and to achieve the reported 性能.
10.2.2     Each step in the process of configuring the SUT and running the TPC-DI 基准测试
           corresponds to one or more tasks. Each step in the process of verifying the 基准测试
           执行 and computing all 基准测试 metrics correspond to one or more observations.
           Definitions of tasks and observations are listed throughout the 规范.
10.2.2.1   Tasks are entitled DIT_<子句 number>_<sequence number>. If 配置 steps are
           necessary to satisfy Clause 10.2.1 that are not defined in this 规范, they 必须
           given a unique task name in format DIT_M_<sequence number> and included in the FDR
           under miscellaneous tasks. The 实现 of each task 必须 presented in programs,
           配置 files, screenshot sequences, user manual, or human readable text.
10.2.2.2   Observations are entitled OID_<子句 number>_<sequence number>. If 配置 steps
           are necessary to satisfy Clause 10.2.1 that are not defined in this 规范, they 必须
           given a unique observation name in format OID_M_<sequence number> and included in the
           FDR under miscellaneous observations. An observation 必须 presented in the form of
           human readable text or screenshot sequences.
10.2.3     The reader of the FDR 必须 able to understand the semantics of human readable text,
           programs, 配置 files and screenshots, either by accompanied explanation or by
           referring to documentation.
10.2.4     Programs
10.2.4.1   Programs are the preferred format to specify tasks.
10.2.4.2   All instructions of programs that control functions of components listed in the priced
           配置 必须 fully explained in a user manual. This manual 必须 made available


TPC Benchmark™ DI - Standard Specification, Revision 1.1.0                            Page 101 of 117
           by the 基准测试 sponsor for download upon request on the 可用性 日期 without any
           license, NDA or fee.
10.2.4.3   All instructions of programs that control functions of components that are not listed in the
           priced 配置 must adhere to a publically available standard i.e. a programming
           language whose 定义 is publically available. They 必须 presented in their source
           code. For each of these programs the version of their programming language, any 输入 and
           输出 data and the way it is translated to be machine executable 必须 disclosed. For
           each program that needs to be compiled to be machine executable, the compiler version and
           compile invocation needs to be disclosed. For each program that needs to be interpreted to
           be machine executable, the version of the interpreter and any non-default parameter need
           to be disclosed.
10.2.4.4   All programs 必须 accompanied by a short 说明 of what 零件 of the TPC-DI
           规范 they 实现. For all non-GUI driven programs a call tree 必须 provided
           that shows which program calls which. If a non-GUI driven program calls a GUI driven
           program, it needs to name the GUI-driven program. If a GUI-driven program calls a non-GUI
           driven program it needs to name the non-GUI driven program.
10.2.5     Configuration files
10.2.5.1   Each 配置 file 必须 accompanied with a short 说明 of its usage and when it
           is used.
10.2.5.2   If a 配置 file changes the default behavior of one or more components that are listed
           in the priced 配置, the syntax of the 配置 file 必须 fully explained in a
           user manual. This manual 必须 made available by the 基准测试 sponsor upon request
           on the Availability Date.
10.2.5.3   If a 配置 file changes the default behavior of one or more components that are not
           listed in the priced 配置, the syntax of the 配置 file must adhere to a
           publically available standard i.e. a programming language whose 定义 is publically
           available or the syntax 必须 explained in the FDR.
10.2.6     Screenshot Sequences
10.2.6.1   The use of screenshot sequences to specify a task is allowed if a graphical user interface was
           used to 实现 it for the SUT.
10.2.6.2   The actions that cause the transition from one screenshot to the next screenshot of a
           screenshot sequence 必须 documented in English text, e.g. click on the button <OK> or
           Enter file name foo and click on <continue>.
10.2.6.3   The 订单 in which screenshots appear 必须 disclosed.
10.2.6.4   Screenshots 必须 labeled with SS followed by a hierarchy of numbers where each level is
           separated with “_“, e.g. SS_1_4_5. If screenshots follow each other, then they 应 be
           listed in ascending 订单.
10.2.6.5   Screenshot sequences that are used more than once can be given a unique name and
           referred to by this name in other screenshot sequences.

TPC Benchmark™ DI - Standard Specification, Revision 1.1.0                        Page 102 of 117
10.2.7     User Manuals
           Tasks can be described using user manuals and English descriptions as long as all of the
           following criteria are met:
           Links to downloadable versions of the user manuals are provided with page numbers of the
           page explaining the feature. In case the manual has no page numbering (e.g. html or xml
           documents), a hyperlink that links directly to the position in the document explaining the
           feature 必须 provided.
           All manuals are downloadable without any fees or license restrictions.
           All manuals are downloadable by the Availability Date.
           A user can perform the task reading the instructions in the manual and the English
           说明.
10.2.8     The 订单 and titles of sections in the Report and Supporting Files must correspond with the
           订单 and titles of sections from the TPC-DI Standard Specification (i.e., this document). The
           intent is to make it as easy as possible for readers to compare and contrast material in
           different FDRs.
10.2.9     The content of each page of the Report and Executive Summary must fit on a 8.5 by 11
           inches sheet. The content of each page 必须 printed either in portrait or in landscape
           orientation.
10.2.10    All text sections of the report, including appendices, 必须 printed using font sizes of a
           minimum of 8 points.
10.2.11    All text on any screenshots 必须 legible and all graphical elements 必须 clearly
           identifiable. The largest screen resolution on which screenshots are allowed to be taken is
           1440 by 900. At most two screenshots are allowed to be printed on one page of the Report
           and ES.

10.3       Executive Summary Statement
           The executive summary is meant to be a high level overview of a TPC-DI 实现. It
           应 provide the salient characteristics of a 基准测试 执行 (metrics, 配置,
           定价, etc.) without the exhaustive detail found in the FDR.
            The executive summary has two components:
            Implementation Overview
            Pricing Spreadsheet
10.3.1     Page Layout
           Each 组件 of the executive summary 应 appear on a page by itself. Each page
           应 use a standard header and format, including
           1/2 inch margins, top and bottom;
           3/4 inch left margin, 1/2 inch right margin;
TPC Benchmark™ DI - Standard Specification, Revision 1.1.0                          Page 103 of 117
           2 pt. frame around the body of the page. All interior lines 应 be 1 pt;
           Test Sponsor identification and System identification, each set apart by a 1 pt. 规则, in 16-20
           pt. Times Bold font.
           TPC-DI and TPC-Pricing with three tier versioning (e.g., 1.2.3), and report 日期, separated
           from other header items and each other by a 1 pt. Rule, in 9-12 pt. Times font.
Note:      It is permissible to use or include company logos when identifying the sponsor.
Note:      The report 日期 必须 disclosed with a precision of 1 day. The precise format is left to the
           test sponsor.
Note:      An 示例 executive summary is provided to help clarify the reporting 要求.
10.3.2     Implementation Overview
           The 实现 overview page contains four sets of data, each laid out across the page
           as a sequence of boxes using 1 pt. 规则, with a title above the required 数量. Both titles
           and quantities 应 use a 9-12 pt. Times font unless otherwise noted.




TPC Benchmark™ DI - Standard Specification, Revision 1.1.0                         Page 104 of 117
10.3.2.1    The first 节 contains the results that were obtained from the reported runs of the
            Performance test.

 Title                        Quantity                             Precision       Units            Font

 TPC-DI Throughput            TPC_DI_RPS                           1               TPC_DI_RPS       16-20 pt. Bold

 Scale Factor                 Scale Factor                         1                                16-20 pt. Bold

 Price/Performance            $/TPC_DI_RPS                         $0.01           $/TPC_DI_RPS     16-20 pt. Bold

 Availability Date            System Availbility Date              1 day                            16-20 pt. Bold

 Total System Cost            3 yr. Cost of ownership (See         1           $                    16-20 pt. Bold
                              Clause 7)

10.3.2.2    The second 节 of the page must contain a 性能 summary of the phases of the
            measured run in tabular format. The 表 must have the following 列: “Rows
            Processed”, “Elapsed Time”, and “Throughput”, and have 行 for the three phases of the
            measured run (“Historical Load”, “Update 1”, and “Update 2”).


10.3.2.3    The next 节 of the Implementation Overview 应 contain a synopsis of each of the
            SUT’s major components, including:
            Functional Scope (e.g. Staging Area, Data Integration, Data Warehouse);
            Software, including both O/S and Tool(s);
            Storage, including total space and redundancy level;
            Processors/Cores/Threads
            Memory [GB].


10.3.2.4    The final 节 of the Implementation Overview 应 contain a diagram of the various SUT
            components, including 数量 and model of processors, memory, and storage.
10.3.3       Pricing Spreadsheet
            A 定价 spreadsheet 必须 included in the executive summary. Refer to the TPC-Pricing
            规范 for spreadsheet 要求.




TPC Benchmark™ DI - Standard Specification, Revision 1.1.0                                      Page 105 of 117
                                                                                   TPC-DI 1.0.0
            while [[ ! `ps -ef | grep asm_pmon_+ASM1 | grep -v grep | wc -l` -eq 1 ]];do
                                           My Super System
               echo waiting for ASM to come up `日期`
                                                                                       TPC-Pricing 1.6.0

                                                                                       Report Date: July 4, 2017
Scale Factor                     TPC-DI Throughput                                 Data Warehouse Class
100,000                          12,345 TPC_DI_RPS                                 OPEN class
Availability Date                Price/Performance                                 Total System Cost
July 7, 2017                     $123.45 USD per TPC_DI_RPS                        12,345.67 USD

                                                Performance Summary
                                       Rows Processed            Elapsed Time          Throughput

                    Historical Load      123,456 (R H )          12:34:56(E H )        12,345 (T H )
                       Update 1          12,345 (R i1 )           32:10 (E I1 )        12,345 (T I1 )
                       Update 2          12,345 (R I2 )           32:10 (E I2 )        12,345 (T I2 )
                        Overall                              --- TPC_DI_RPS --->         12,345

                                                   System Summary
Functional Scope                      Software                         Storage          Processors/        Memory
                                                                                       Cores/Threads        [GB]
                            OS             Tool            Storage     Redundancy
                                                            [GB]
 Data Integration                 D      MyDI               50           Level1          8/80/160               8
                                  I
   Staging Area                   S                        5,000         Level5            1/2/2             8
                                  T
 Data Warehouse                   D      MyDB             10,000         Level5         16/160/320          1000
                                  B
       Total Storage= 15,050          Total processor/Cores/Threads=25/242/482            Total Memory = 1016




       TPC Benchmark™ DI - Standard Specification, Revision 1.1.0                             Page 106 of 117
                                                                                                  TPC-DI 1.0.0
                                              My Super System                                     TPC-Pricing 1.6.0

                                                                                                  Report Date: July 4, 2017

                                                    Pricing Summary
Description                                      Part           Pricing     Unit      Quantity Extended          3 year
                                                 Number                     Price              Price             Maintenance
                                                                                                                 价格
My Super server                                  2109857        12,000      1         10,000      20,000         included




Results independently audited by: Mr. Audit
Prices used in TPC benchmarks reflect the actual prices a 客户 would pay for a one-time purchase of the stated components.
Individually negotiated discounts are not permitted. Special prices based on assumptions about past or future purchases are not
permitted. All discounts reflect standard 定价 policies for the listed components. For complete details, see the 定价 sections
of the TPC 基准测试 specifications. If you find that the stated prices are not available according to these terms please inform
the TPC at 定价@tpc.org. Thank you.




        TPC Benchmark™ DI - Standard Specification, Revision 1.1.0                                         Page 107 of 117
10.4       Availability of the Full Disclosure Report
10.4.1     The full disclosure report 必须 readily available to the public at a reasonable charge,
           similar to charges for comparable documents by that test sponsor. The report 必须 made
           available when results are made public. In 订单 to use the phrase "TPC Benchmark DI", the
           full disclosure report must have been submitted electronically to the TPC using the procedure
           described in the TPC Policies document.
10.4.2     The official full disclosure report 必须 available in English but 可 be translated to
           additional languages.

10.5       Revisions to the Full Disclosure Report
10.5.1     Full disclosure report revisions 可 be required as specified in the TPC Policies and
           Guidelines document, and 必须 submitted using the mechanisms described therein.
10.5.2     If the Availability Date is after the Report Date of the Result and the 性能 of the SUT
           as of the Availabilty Date has decreased by more than 2% from the reported 值, then the
           Test Sponsor is required to withdraw the 基准测试 结果.
10.5.3     A report 可 be revised to add or delete Clause 9 related items for country-specific priced
           configurations.

10.6       Rebadged Results
10.6.1     TPC-DI results 可 be rebadged. For the 规则 governing rebadging results, see the TPC
           Policies.

10.7       Supporting Files Index Table
           A supporting files 索引 for all files corresponding to tasks, observations and screenshots
           必须 provided in the Full Disclosure Report. The supporting files 索引 is presented in a
           tabular format where the 列 specify the following:
               The first 列 denotes the label of the task, observation or screenshot as required by
               the TPC-DI Specification
               The second 列 provides a short 说明 of the file contents
               The third 列 contains the path name for the file starting at the SupportingFiles
               directory.
           If there are no Supporting Files provided, e.g. in case documentation is used to fulfill the
           disclosure 要求 then path name 列 must clearly identify the location of the
           documentation.
           The following 表 is an 示例 of the Supporting Files Index Table that 必须 reported
           in the Report.

TPC Benchmark™ DI - Standard Specification, Revision 1.1.0                         Page 108 of 117
           Clause          Description                  Pathname
           Clause 2        TBD                          TBD




TPC Benchmark™ DI - Standard Specification, Revision 1.1.0         Page 109 of 117
                                  Clause 11: Independent Audit

11.1       Overview
11.1.1     Prior to its publication, a TPC-DI Result 必须 audited by a TPC-Certified, independent
           Auditor.
11.1.2     The 审计 must assure that the Result is in 合规 with all clauses of the effective
           version of the TPC-DI 规范.
11.1.3     All 审计 要求 specified in the effective version of the TPC Pricing Specification,
           located at www.tpc.org 必须 followed. For clarity and readability the TPC Pricing
           Specification 要求 可 be repeated in the TPC-DI Specification.
11.1.4     To document that a Result passed the 审计, the Attestation Letter 必须 included in the
           Report and made readily available to the public.
11.1.5     A Test Sponsor can demonstrate 合规 of a new Result produced without running any
           性能 test by referring to the Attestation Letter of another Result, if the following
           conditions are all met:
               The referenced Result has already been published by the same or by another Test
               Sponsor.
               The new Result must have the same 硬件 and 软件 architecture and
               配置 as the referenced Result. The only exceptions allowed are for elements not
               involved in the processing logic of the SUT (e.g., number of peripheral slots, power
               supply, cabinetry, fans, etc.)
               The Test Sponsor of the already published Result gives written approval for its use as
               referenced by the Test Sponsor of the new Result.
               The Auditor verifies that there are no significant functional differences between the
               priced components used for both Results (i.e., differences are limited to labeling,
               packaging and 定价.)
               The Auditor reviews the FDR of the new Result for 合规. The Auditor delivers a
               new Attestation Letter to be included in the Report of the new Result.
Note:      The intent of this 子句 is to allow publication of benchmarks for 系统 with different
           packaging and model numbers that are considered to be identical using the same Benchmark
           Run. For 示例, a rack mountable 系统 and a freestanding 系统 with identical
           electronics can use the same Benchmark Run for publication, with appropriate changes in
           定价.
Note:      Although it 应 be apparent to a careful reader that the FDR for the two Results are based
           on the same set of 性能 tests, the FDR for the new Result is not required to explicitly
           state that it is based on the 性能 tests of another published Result.
Note:      When more than one Result is published based on the same set of 性能 tests, only
           one of the Results from this group can occupy a numbered slot in each of the 基准测试
           Result “Top Ten” lists published by the TPC. The Test Sponsors of this group of Results must
TPC Benchmark™ DI - Standard Specification, Revision 1.1.0                       Page 110 of 117
           all agree on which Result from the group will occupy the single slot. In case of disagreement
           among the Test Sponsors, the decision will be made by the Test Sponsor of the earliest
           publication from the group.




TPC Benchmark™ DI - Standard Specification, Revision 1.1.0                        Page 111 of 117
                                 Clause 12: Definitions of Terms
           Auxiliary Data Structure: Any persistent or volatile data structures used by the Data
           Warehouse or the Data Integration System other than the Tables defined in the Data
           Warehouse in Clause 3. Auxiliary Data Structures 可 include temporary 表 or files,
           intermediate 表, indices on 表 or caches, among other things.
           Batch Date: Date 值 representing the 日期 of extaction of the data being processed in
           each Batch.
           Component: Defined in Clause 0.1.2 of the TPC Pricing Specification.
           Configuration File: A 配置 file is a file containing parameters and 值 that specify
           settings for a program or environment.
           Data Generation Server: The server machine (or machines) used to generate the data (using
           DIGen). This 可 be a server that is not involved in running the 基准测试.
           Data Integration (DI) DI application: The executable form of the data transformation logic.
           Typically this is generated by the DI System based on the DI 规范
           Data Integration (DI) Server: The server machine (or machines) that supports the DI System
           and any Auxiliary Data Structures used by the DI System. This server is 零件 of the SUT,
           including all 硬件 and 软件 on the machine.
           Data Integration (DI) 规范: The 输入 provided to the DI System which describes the
           data transformations that need to be performed.
           Data Integration (DI) System: The DI System performs the moving and transforming of data
           described in Clause 4.
           Data store: A durable repository of data. A data store 可 consist of one or more collections
           of data which 可 or 可 not be related. The data store provides interfaces for users and
           applications to manipulate the data. Data stores include files, and relational and non-
           relational databases.
           Data transformation: Operations on data for the purpose of creating a new context in which
           processing and analysis of the data can be performed. Examples include grouping or
           regrouping data, combining data from different data sources, reformatting, decoding, and
           data 值 substitution.
           Data Warehouse: The Data Warehouse is the set of 表 defined in Clause 3 and the
           软件 that implements the concurrency controls, and the data 定义, access and
           update mechanisms. The 表 can be read using a 查询 language or API. In this
           规范, the SQL 查询 language is used to express some queries that will be performed,
           but other languages or APIs are allowed in cases where the Test Sponsor obtains a waiver by
           submitting documentation showing that the proposed queries are functionally equivalent to
           the specified SQL.
           Data Warehouse Server: The server machine (or machines) that supports the Data
           Warehouse 数据库 and any Auxiliary Data Structures used by the Data Warehouse. Any
TPC Benchmark™ DI - Standard Specification, Revision 1.1.0                         Page 112 of 117
           软件, storage areas or devices that support the Data Warehouse or its use in the
           基准测试 are included. This server is 零件 of the SUT, including all 硬件 and 软件
           on the machine.
           Data Warehouse Session: The process context capable of supporting the 执行 of a DDL,
           DML, queries, e.g. SQL ‘create 表’ and ‘select’ statements.
           Effective Version: The effective version of the TPC Pricing Specification is the most recent
           version of the 定价 规范 published by the TPC. The TPC Pricing Specification is
           available at www.tpc.org.
           Extension mechanism: Functionality provided by the Data Integration System to extend the
           base capabilities of the DI System with reusable custom logic.
           Historical Load: Execution phase of the 基准测试 in which the Data Warehouse is initially
           loaded with transformed Source Data. The Data Warehouse is presumed to be ‘non-
           operational’ during the Historical Load, i.e. only Data Warehouse Sessions directly related to
           performing the Historical Load are active. Historical Load is a timed phase.
           Human readable text: Text using printable characters
           Incremental Update: Execution phase of the 基准测试 in which the Data Warehouse is
           updated with additional transformed Source Data. The Data Warehouse is presumed to be
           ‘operational’ during Incremental Update, i.e. Data Warehouse Sessions not related to
           updating the Data Warehouse 可 be active. Incremental Update is a timed phase.
           Network: If the Staging Area Server, DI Server or Data Warehouse Server are on separate
           machines, then the Network is whatever communication facilities are used to communicate
           between machines, including 硬件 and 软件. Any network equipment, network
           interfaces and cabling used are 零件 of the SUT.
           Note: Some statements in the 规范 are designated as notes for purposes of
           clarification. While separated from the main text for readability, notes are a 零件 of the
           standard and 必须 enforced.
           Observation: A disclosure is 输出 obtained from the 实现 of the 基准测试
           Part Number: Defined in Clause 0.1.2 of the TPC Pricing Specification.
           Priced Configuration: Defined in Clause 0.1.2 of the TPC Pricing Specification.
           Program: A program is a sequence of instructions to automate a task for a computer
           program.
           Rationale: Rationale statements 可 be provided to explain design decisions related to the
           基准测试. Rationale statements 可 be used for understanding the intent of the
           规范, but are not 零件 of the standard. Rationale statements are given a shaded
           background to clearly delineate their boundaries.
           Report: The Adobe Acrobat PDF file in the Report folder in the FDR. The contents of the
           Report are defined in Clause 10.

TPC Benchmark™ DI - Standard Specification, Revision 1.1.0                          Page 113 of 117
           Reported Throughput: The 性能 指标 reported by TPC-DI, as specified in Clause
           7.6.1.
           Result: Defined in Clause 0.2.39 of the TPC Policies as follows: A 性能 test submitted
           to the TPC, documented by an FDR and Executive Summary submitted to the TPC, and
           attested to meet the 要求 of a TPC Benchmark Standard at the time of submission.
           Scale Factor: Parameter supplied to DIGen to control the amount of Source Data generated.
           A larger Scale Factor will produce a proportionally larger set of source data. The same Scale
           Factor 必须 used to generate all source data.
           Screenshot Sequence: A screenshot sequence is an ordered list of one or more screenshots.
           Screenshot: A screen shot is an image of a computer screen.
           Staging Area: The Staging Area holds the Source Data, described in Clause 2, that will be
           read by the DI System. No manipulations are allowed on the files after they are generated or
           copied to the Staging Area.
           Staging Area Server: The server machine (or machines) that supports the Staging Area. This
           server is 零件 of the SUT, including all 硬件 and 软件 on the machine.
           System Under Test: The 系统 of 硬件 and 软件 components used to perform the
           TPC-DI 基准测试 operations. The System Under Test is specifically defined in Clause 5.
           Source Data: Data files that are generated by DIGen or exact copies, and the data contained
           within. Source data is read from the Staging Area and used as 输入 to the 基准测试
           transformations.
           Table: A data structure that is populated with data that can be read by users or applications,
           including the Data Integration process. A 表 has a structure with a name given in Clause 3
           and pre-determined 列 having names and defined types as given in Clause 3, and a
           variable number or 行 depending on the number of 记录 placed in the 表. In this
           基准测试, 表 are populated by the data integration process.
           Task: A task is a 配置 step




TPC Benchmark™ DI - Standard Specification, Revision 1.1.0                        Page 114 of 117
                            Clause 13: Definitions of Tasks to be disclosed
DIT- 3-1: Definitions of all 表 (e.g. DDL) ...............................................................................38
DIT- 3-2: Name, optional components, and version number that uniquely identifies the product that
implements the Data Warehouse .............................................................................................46
DIT- 3-3: Data Warehouse class (必须 either ACID or OPEN)................................................48
DIT- 3-4: Method use to demonstrate ACID 合规 and details of ABP or AT .....................49
DIT- 4-1: The name, options and version number that uniquely identifies the product implementing the
Data Integration System........................................................................................................... 52
DIT- 4-2: The translation of the DI 规范 into the DI aplication format ..........................52
DIT- 4-3: Implementation of each transformation of the Historical Load ..................................58
DIT- 6-1: Version of the data generator .....................................................................................82
DIT- 7-1: Scale Factor (SF) ..........................................................................................................84
DIT- 7-2: DIGen command line parameters used to generate the Source Data..........................84
DIT- 7-3: Non default 系统 settings........................................................................................85
DIT- 7-4: Non default 安装 settings ................................................................................. 85
DIT- 7-5: Instructions to allocate space on disk..........................................................................85
DIT- 7-6: Instructions to create user accounts in product hosting the Data Warehouse ............85
DIT- 7-7: Instructions on how to allocate space for Data Warehouse 表..............................85
DIT- 7-8: Non default 系统 settings........................................................................................85
DIT- 7-9: Non default 安装 settings ................................................................................. 85
DIT- 7-10: Commands/Scripts to allocate space on disk.............................................................85
DIT- 7-11: Commands/scripts to create user accounts ..............................................................85
DIT- 7-12: Commands/scripts to import the DI 规范 .....................................................85




TPC Benchmark™ DI - Standard Specification, Revision 1.1.0                                                 Page 115 of 117
                 Clause 14:                      Definitions of Observations to be disclosed
OID 3-1: The use of minor 查询 modifications 必须 disclosed and justified. .......................49
OID 3-2: The use of major 查询 modifications 必须 disclosed and justified. .......................51
OID- 7-1: Output of the 审计 查询 ..........................................................................................87
OID- 7-2: Elapsed time of the Historical Load ............................................................................89
OID- 7-3: Total number of 行 of 输入 data in the Historical Load (Batch 1) data set as reported by
DIGen .......................................................................................................................................89
OID- 7-4: The 吞吐量 of the Historical Load .......................................................................89
OID- 7-5: The elapsed times for the Incremental Updates ........................................................89
OID- 7-6: Total number of 行 of source data in the Incremental Update data sets ................ 89
OID- 7-7: Throughputs of the Incremental Updates ..................................................................89




TPC Benchmark™ DI - Standard Specification, Revision 1.1.0                                                          Page 116 of 117
The content for the appendices can be obtained from the download 节 of the TPC web site. The
Appendices are stored in a single archive file with directories containing the supporting files for each
Appendix.

                                           Appendix A: Audit Query
           The 审计 查询 is used to validate the results of a 基准测试 run and is contained in the file
           tpcdi_审计.sql

                                   Appendix B: Batch Validation Query
           The batch vaildation 查询 is used to capture the state of the Data Warehouse at the end of a
           基准测试 phase and is contained in the file tpcdi_validation.sql

                                    Appendix C: Data Visibility Queries
           The data visibility queries are used to verify the visibility of data during a 基准测试 run and
           are contained in the file tpcdi_visibility_1.sql and tpcdi_visibility_2.sql




TPC Benchmark™ DI - Standard Specification, Revision 1.1.0                          Page 117 of 117

