# 15. Database 2 Day + Performance Tuning Guide

> 源文件: `en/tdppt/2-day-performance-tuning-guide.pdf`

Oracle® Database
Database 2 Day + Performance Tuning Guide




   19c
   E96346-03
   September 2020
Oracle Database Database 2 Day + Performance Tuning Guide, 19c

E96346-03

Copyright © 2007, 2019, Oracle and/or its affiliates.

Contributors: Glenn Maxey, Rajesh Bhatiya, Lance Ashdown, Immanuel Chan, Debaditya Chatterjee, Maria
Colgan, Dinesh Das, Kakali Das, Karl Dias, Mike Feng, Yong Feng, Andrew Holdsworth, Kevin Jernigan,
Caroline Johnston, Aneesh Kahndelwal, Sushil Kumar, Sue K. Lee, Herve Lejeune, Ana McCollum, David
McDermid, Colin McGregor, Mughees Minhas, Valarie Moore, Deborah Owens, Mark Ramacher, Uri
Shaft, Susan Shepard, Janet Stern, Stephen Wexler, Graham Wood, Khaled Yagoub, Hailing Yu, Michael
Zampiceni

This software and related documentation are provided under a license agreement containing restrictions on
use and disclosure and are protected by intellectual property laws. Except as expressly permitted in your
license agreement or allowed by law, you may not use, copy, reproduce, translate, broadcast, modify, license,
transmit, distribute, exhibit, perform, publish, or display any part, in any form, or by any means. Reverse
engineering, disassembly, or decompilation of this software, unless required by law for interoperability, is
prohibited.

The information contained herein is subject to change without notice and is not warranted to be error-free. If
you find any errors, please report them to us in writing.

If this is software or related documentation that is delivered to the U.S. Government or anyone licensing it on
behalf of the U.S. Government, then the following notice is applicable:

U.S. GOVERNMENT END USERS: Oracle programs (including any operating system, integrated software,
any programs embedded, installed or activated on delivered hardware, and modifications of such programs)
and Oracle computer documentation or other Oracle data delivered to or accessed by U.S. Government
end users are "commercial computer software" or "commercial computer software documentation" pursuant
to the applicable Federal Acquisition Regulation and agency-specific supplemental regulations. As such,
the use, reproduction, duplication, release, display, disclosure, modification, preparation of derivative works,
and/or adaptation of i) Oracle programs (including any operating system, integrated software, any programs
embedded, installed or activated on delivered hardware, and modifications of such programs), ii) Oracle
computer documentation and/or iii) other Oracle data, is subject to the rights and limitations specified in the
license contained in the applicable contract. The terms governing the U.S. Government’s use of Oracle cloud
services are defined by the applicable contract for such services. No other rights are granted to the U.S.
Government.

This software or hardware is developed for general use in a variety of information management applications.
It is not developed or intended for use in any inherently dangerous applications, including applications that
may create a risk of personal injury. If you use this software or hardware in dangerous applications, then you
shall be responsible to take all appropriate fail-safe, backup, redundancy, and other measures to ensure its
safe use. Oracle Corporation and its affiliates disclaim any liability for any damages caused by use of this
software or hardware in dangerous applications.

Oracle and Java are registered trademarks of Oracle and/or its affiliates. Other names may be trademarks of
their respective owners.

Intel and Intel Inside are trademarks or registered trademarks of Intel Corporation. All SPARC trademarks are
used under license and are trademarks or registered trademarks of SPARC International, Inc. AMD, Epyc,
and the AMD logo are trademarks or registered trademarks of Advanced Micro Devices. UNIX is a registered
trademark of The Open Group.

This software or hardware and documentation may provide access to or information about content, products,
and services from third parties. Oracle Corporation and its affiliates are not responsible for and expressly
disclaim all warranties of any kind with respect to third-party content, products, and services unless otherwise
set forth in an applicable agreement between you and Oracle. Oracle Corporation and its affiliates will not
be responsible for any loss, costs, or damages incurred due to your access to or use of third-party content,
products, or services, except as set forth in an applicable agreement between you and Oracle.
Contents
     Preface
     Audience                                                                 ix
     Documentation Accessibility                                              ix
     Related Documents                                                         x
     Conventions                                                               x


     Changes in This Release for Oracle Database 2 Day +
     Performance Tuning Guide
     Changes in Oracle Database Release 19c, Version 19.1                     xi
     Changes in Oracle Database Release 18c, Version 18.1                     xii
     Changes in Oracle Database 12c Release 2 (12.2)                          xii
     Changes in Oracle Database 12c Release 1 (12.1.0.2)                      xii
     Changes in Oracle Database 12c Release 1 (12.1.0.1)                     xiii



Part I   Getting Started


1    Introduction
     About This Guide                                                        1-1
     Common Oracle DBA Tasks                                                 1-1
     Tools for Tuning the Database                                           1-2
     Accessing the Database Home Page                                        1-3



2    Oracle Database Performance Method
     Gathering Database Statistics Using the Automatic Workload Repository   2-1
         Time Model Statistics                                               2-2
         Wait Event Statistics                                               2-4
         Session and System Statistics                                       2-4
         Active Session History Statistics                                   2-4
         High-Load SQL Statistics                                            2-5




                                                                              iii
     Using the Oracle Performance Method                                   2-5
          Preparing the Database for Tuning                                2-6
          Tuning the Database Proactively                                  2-7
          Tuning the Database Reactively                                   2-7
          Tuning SQL Statements                                            2-8
     Common Performance Problems Found in Databases                        2-8



Part II    Proactive Database Tuning


3    Automatic Database Performance Monitoring
     Overview of Automatic Database Diagnostic Monitor                     3-1
          ADDM Analysis                                                    3-2
          ADDM Recommendations                                             3-2
          ADDM for Oracle Real Application Clusters                        3-3
          ADDM for a Multitenant Environment                               3-3
     Configuring Automatic Database Diagnostic Monitor                     3-4
          Setting Initialization Parameters to Enable ADDM                 3-4
          Setting the DBIO_EXPECTED Parameter                              3-5
          Managing AWR Snapshots                                           3-5
              Creating Snapshots                                           3-6
              Modifying Snapshot Settings                                  3-7
     Reviewing the Automatic Database Diagnostic Monitor Analysis          3-8
     Interpretation of Automatic Database Diagnostic Monitor Findings     3-10
     Implementing Automatic Database Diagnostic Monitor Recommendations   3-11
     Viewing Snapshot Statistics                                          3-14



4    Monitoring Real-Time Database Performance
     Monitoring User Activity                                              4-1
          Monitoring Top Dimensions                                        4-4
          Monitoring SQL                                                   4-4
          Monitoring PL/SQL                                                4-5
          Monitoring Resource Consumption                                  4-6
          Monitoring Session Identifiers                                   4-6
          Monitoring Session Attributes                                    4-7
     Monitoring Instance Activity                                          4-8
          Monitoring Throughput                                            4-8
          Monitoring I/O                                                   4-9
              Monitoring I/O by Function                                  4-10
              Monitoring I/O by Type                                      4-11




                                                                            iv
               Monitoring I/O by Consumer Group                               4-13
           Monitoring Parallel Execution                                      4-13
           Monitoring Services                                                4-14
      Monitoring Host Activity                                                4-15
           Monitoring CPU Utilization                                         4-16
           Monitoring Memory Utilization                                      4-17
           Monitoring Disk I/O Utilization                                    4-20
      Determining the Cause of Spikes in Database Activity                    4-22



5     Monitoring Real-Time Database Operations
      About Monitoring Database Operations                                     5-1
           Types of Database Operations                                        5-1
           Purposes of Monitoring Database Operations                          5-2
           Enabling Monitoring of Database Operations                          5-3
           Attributes of Database Operations                                   5-3
      Creating a Database Operation                                            5-3
      Monitoring Database Operations in Cloud Control                          5-5
           Viewing SQL Execution Details for a Composite Database Operation    5-5
           Viewing SQL Execution Details for a SQL Statement                   5-7
           Viewing SQL Execution Details for a PL/SQL Statement                5-7



6     Monitoring Performance Alerts
      Setting Metric Thresholds for Performance Alerts                         6-1
      Responding to Alerts                                                     6-2
      Clearing Alerts                                                          6-3



Part III      Reactive Database Tuning


7     Manual Database Performance Monitoring
      Manually Running ADDM to Analyze Current Database Performance            7-1
      Manually Running ADDM to Analyze Historical Database Performance         7-3
      Accessing Previous ADDM Results                                          7-5



8     Resolving Transient Performance Problems
      Overview of Active Session History                                       8-1
      Running Active Session History Reports                                   8-2
      Active Session History Reports                                           8-4




                                                                                v
        Top Events                                                       8-4
            Top User Events                                              8-4
            Top Background Events                                        8-5
        Load Profile                                                     8-5
        Top SQL                                                          8-6
        Top Sessions                                                     8-7
        Top DB Objects/Files/Latches                                     8-7
            Top DB Objects                                               8-8
            Top DB Files                                                 8-8
            Top Latches                                                  8-9
        Activity Over Time                                               8-9



9    Resolving Performance Degradation Over Time
     Managing Baselines                                                  9-1
        Creating a Baseline                                              9-2
            Creating a Single Baseline                                   9-2
            Creating a Repeating Baseline                                9-4
        Deleting a Baseline                                              9-5
        Computing Threshold Statistics for Baselines                     9-6
        Setting Metric Thresholds for Baselines                          9-8
            Setting Metric Thresholds for the Default Moving Baseline    9-8
            Setting Metric Thresholds for Selected Baselines             9-9
     Running the AWR Compare Periods Reports                            9-10
        Comparing a Baseline to Another Baseline or Pair of Snapshots   9-11
        Comparing Current System Performance to a Baseline Period       9-14
        Comparing Two Pairs of Snapshots                                9-15
     Using the AWR Compare Periods Reports                              9-16
        Summary of the AWR Compare Periods Report                       9-17
            Snapshot Sets                                               9-18
            Host Configuration Comparison                               9-18
            Cache Sizes                                                 9-18
            Load Profile                                                9-18
            Top Timed Events                                            9-19
        Details of the AWR Compare Periods Report                       9-20
        Supplemental Information in the AWR Compare Periods Report      9-20



10   Using Automatic Workload Repository Warehouse for Generating
     Performance Reports
     Setting Up the AWR Warehouse                                       10-2




                                                                          vi
          Working with Source Databases                                10-4
          Uploading Snapshots to the AWR Warehouse                     10-5
     Using Performance Pages with the AWR Warehouse                    10-6
     AWR Warehouse Best Practices                                      10-9
          Database Best Practices                                      10-9
             Memory Management                                         10-9
             Storage Requirements                                     10-10
             Backup                                                   10-10
             Redo Log Size                                            10-10
             Stats Collection                                         10-10
             The job_queue_processes Parameter                        10-11
             Access Control                                           10-11
          Enterprise Manager Best Practices                           10-11
             AWR Warehouse Credentials                                10-11
             Source Database Credentials                              10-11
             Staging Location on AWR Warehouse                        10-11
             Network Latency                                          10-12
     Monitoring and Researching Incidents and Errors                  10-12



Part IV      SQL Tuning


11   Identifying High-Load SQL Statements
     Identification of High-Load SQL Statements Using ADDM Findings    11-1
     Identifying High-Load SQL Statements Using Top SQL                11-2



12   Tuning SQL Statements
     Tuning SQL Statements Using SQL Tuning Advisor                    12-2
          Tuning SQL Manually Using SQL Tuning Advisor                 12-2
          Viewing Automatic SQL Tuning Results                         12-5
     Managing SQL Tuning Sets                                          12-8
          Creating a SQL Tuning Set                                    12-9
             Creating a SQL Tuning Set: Options                        12-9
             Creating a SQL Tuning Set: Load Methods                  12-10
             Creating a SQL Tuning Set: Filter Options                12-13
             Creating a SQL Tuning Set: Schedule                      12-14
          Dropping a SQL Tuning Set                                   12-16
          Transporting SQL Tuning Sets                                12-16
             Exporting a SQL Tuning Set                               12-16
             Importing a SQL Tuning Set                               12-18




                                                                        vii
     Managing SQL Profiles                                                  12-19
     Managing SQL Plan Baselines                                            12-20
        Capturing SQL Plan Baselines Automatically                          12-21
        Loading SQL Plan Baselines Manually                                 12-21
        Evolving SQL Plans                                                  12-23



13   Optimizing Data Access Paths
     Running SQL Access Advisor                                              13-1
        Selecting the Initial Options                                        13-2
        Selecting the Workload Source                                        13-3
             Using SQL Statements from the Cache                             13-3
             Using an Existing SQL Tuning Set                                13-4
             Using a Hypothetical Workload                                   13-4
        Applying Filter Options                                              13-5
             Defining Filters for Resource Consumption                       13-6
             Defining Filters for Users                                      13-6
             Defining Filters for Tables                                     13-7
             Defining Filters for SQL Text                                   13-7
             Defining Filters for Modules                                    13-7
             Defining Filters for Actions                                    13-8
        Specifying Recommendation Options                                    13-8
        Specifying Task and Scheduling Options                              13-10
     Reviewing the SQL Access Advisor Recommendations                       13-14
        Reviewing the SQL Access Advisor Recommendations: Summary           13-15
        Reviewing the SQL Access Advisor Recommendations: Recommendations   13-17
        Reviewing the SQL Access Advisor Recommendations: SQL Statements    13-20
        Reviewing the SQL Access Advisor Recommendations: Details           13-21
     Implementing the SQL Access Advisor Recommendations                    13-22


     Index




                                                                              viii
Preface
           This preface contains the following topics:
           •   Audience
           •   Documentation Accessibility
           •   Related Documents
           •   Conventions


Audience
           This guide is intended for Oracle database administrators (DBAs) who want to tune
           and optimize the performance of Oracle Database. Before using this document, you
           should be familiar with Oracle Database administration.
           In particular, this guide is targeted toward the following groups of users:
           •   Oracle DBAs who want to acquire database performance tuning skills
           •   DBAs who are new to Oracle Database



                  See Also:

                  •   Oracle Database Administrator's Guide for more information about
                      database administration



Documentation Accessibility
           For information about Oracle's commitment to accessibility, visit the
           Oracle Accessibility Program website at http://www.oracle.com/pls/topic/lookup?
           ctx=acc&id=docacc.

           Access to Oracle Support
           Oracle customers that have purchased support have access to electronic support
           through My Oracle Support. For information, visit http://www.oracle.com/pls/topic/
           lookup?ctx=acc&id=info or visit http://www.oracle.com/pls/topic/lookup?ctx=acc&id=trs
           if you are hearing impaired.




                                                                                               ix
                                                                                                  Preface




Related Documents
        For more information about the topics covered in this document, see the following
        documents:
        •     Oracle Database Administrator's Guide
        •     Oracle Database Concepts
        •     Oracle Database Performance Tuning Guide
        •     Oracle Database SQL Tuning Guide


Conventions
        The following conventions are used in this document:


         Convention           Meaning
         boldface             Boldface type indicates graphical user interface elements associated
                              with an action, or terms defined in text or the glossary.
         italic               Italic type indicates book titles, emphasis, or placeholder variables for
                              which you supply particular values.
         monospace            Monospace type indicates commands within a paragraph, URLs, code
                              in examples, text that appears on the screen, or text that you enter.




                                                                                                          x
Changes in This Release for Oracle
Database 2 Day + Performance Tuning
Guide
          This preface contains:
          •    Changes in Oracle Database Release 19c, Version 19.1
          •    Changes in Oracle Database Release 18c, Version 18.1
          •    Changes in Oracle Database 12c Release 2 (12.2)
          •    Changes in Oracle Database 12c Release 1 (12.1.0.2)
          •    Changes in Oracle Database 12c Release 1 (12.1.0.1)


Changes in Oracle Database Release 19c, Version 19.1
          The following are the changes in Oracle Database 2 Day + Performance Tuning Guide
          for Oracle Database release 19c, version 19.1.


New Features
          The following features are new in this release:
          •    Automatic Database Diagnostic Monitor (ADDM) support for pluggable databases
               (PDBs)
               You can now use ADDM to analyze AWR data in PDBs for identifying and
               resolving performance related issues.
               See "ADDM for a Multitenant Environment" for more information.
          •    Real-time SQL monitoring functionality enabled for non-administrative database
               users
               The database users without the administrative privileges can also now view the
               execution plans and performance metrics of their SQL statements by navigating to
               the Monitored SQL Executions page of Oracle Enterprise Manager Cloud Control
               (Cloud Control).
               See the section "Monitoring Database Operations in Cloud Control" for more
               information.


Desupported Features
          The following feature is desupported in this release.
          •    Oracle Streams




                                                                                                xi
                              Changes in This Release for Oracle Database 2 Day + Performance Tuning Guide


               Starting in Oracle Database 19c, the Oracle Streams feature is desupported. Use
               Oracle GoldenGate to replace all replication features of Oracle Streams.


Changes in Oracle Database Release 18c, Version 18.1
          There are no changes in Oracle Database 2 Day + Performance Tuning Guide for
          Oracle Database release 18c, version 18.1. For the Oracle Database performance
          related features that are new in this release, see Oracle Database Performance Tuning
          Guide and Oracle Database SQL Tuning Guide.


Changes in Oracle Database 12c Release 2 (12.2)
          There are no changes in Oracle Database 2 Day + Performance Tuning Guide for
          Oracle Database 12c Release 2 (12.2). For the Oracle Database performance related
          features that are new in this release, see Oracle Database Performance Tuning Guide.


Changes in Oracle Database 12c Release 1 (12.1.0.2)
          The following are changes in Oracle Database 2 Day + Performance Tuning Guide for
          Oracle Database 12c Release 1 (12.1.0.2).


New Features
          The following features are new in this release:
          •    Manageability support for In-Memory Column Store
               The new Oracle Database In-Memory Column Store (IM column store) feature
               accelerates database performance of analytics, data warehousing, and online
               transaction processing (OLTP) applications.
               SQL Monitor report, ASH report, and AWR report now show statistics for various
               in-memory operations.
               –   In-memory statistics in SQL Monitor report: Activity % in Time and Wait
                   Statistics panel, Activity column in Plan Statistics table, and Activity tab in SQL
                   Monitor report show CPU consumed by SQL commands while executing in-
                   memory query operations. SQL Monitor report now supports Adaptive plans.
                   The Execution plan shows Resolving or Resolved icon depending upon the
                   current status of that plan. The Plan Statistics tab contains a drop down list to
                   show current plan, final plan, and full plan. It also contains Plan Note button,
                   which when clicked, shows the notes that are generated in the explain plan for
                   the SQL statement.
               –   In-memory statistics in ASH report: ASH report header table shows the size
                   of in-memory pool under In Memory Area column. Top Events, Top SQL, and
                   Activity Over Time sections show CPU consumption by various in-memory
                   operations.
               –   In-memory statistics in AWR report: AWR report contains a new section -
                   In-Memory Segments Statistics - that shows in-memory segment consumption
                   based on various attributes, such as, scans, DB block changes, populate CUs,
                   and repopulate CUs. Time Model Statistics section shows statistics related to
                   in-memory CPU usage and Instance Activity Statistics section shows statistics
                   related to in-memory activities.




                                                                                                       xii
                              Changes in This Release for Oracle Database 2 Day + Performance Tuning Guide




Other Changes
          The following are additional changes in the release:
          •    Changes in ASH Analytics page
               In the Average Active Sessions chart on ASH analytics page, you can now click
               on CPU wait class to see its breakdown by CPU usage based on various in-
               memory operations as well as total CPU used for operations other than in-memory
               operations.
               See "Determining the Cause of Spikes in Database Activity" for more information.


Changes in Oracle Database 12c Release 1 (12.1.0.1)
          The following are changes in Oracle Database 2 Day + Performance Tuning Guide for
          Oracle Database 12c Release 1 (12.1.0.1).


New Features
          The following features are new in this release:
          •    Real-time database operations monitoring
               Real-Time database operations monitoring tracks and reports on active and
               recently completed database operations. You can monitor details of the execution
               of a single SQL or PL/SQL statement. You can also monitor the progress of
               long-running operations such as a batch job, or extract, transform, and load (ETL)
               processing.
               See "Monitoring Real-Time Database Operations " for information on this feature.


Desupported Features
          Oracle Enterprise Manager Database Control is no longer supported by Oracle.


Other Changes
          The following are additional changes in the release:
          •    Oracle Enterprise Manager Cloud Control
               In previous releases of Oracle Database, you used Oracle Enterprise Manager
               Database Control (Database Control) to manage database performance tuning
               from a graphical user interface. In this release, you can use the Oracle Enterprise
               Manager Cloud Control (Cloud Control) graphical user interface. Cloud Control
               provides more functionality than Database Control. The procedures in this guide
               use Cloud Control.
               You must install Cloud Control separately from Oracle Database.




                                                                                                      xiii
                   Changes in This Release for Oracle Database 2 Day + Performance Tuning Guide




           See Also:
           Oracle Enterprise Manager Cloud Control Basic Installation Guide


•   ASH Analytics page
    Cloud Control has the ASH Analytics page, which graphically displays recent
    Active Session History information.
    See "Determining the Cause of Spikes in Database Activity" for more information.
•   Real-Time ADDM
    Cloud Control has the Real-Time ADDM page, from which you can run automatic
    database diagnostic monitoring in real time to diagnose problems with a slow or
    hung database.
    See "Diagnosing Serious Performance Problems in Real Time" for more
    information.




                                                                                           xiv
Part I
Getting Started
         Part I provides an introduction to this guide and explains the Oracle Database
         performance method. This part contains the following chapters:
         •   Introduction
         •   Oracle Database Performance Method
1
Introduction
         As an Oracle database administrator (DBA), you are responsible for the performance
         of your Oracle database. Tuning a database to reach a desirable performance level
         may be a daunting task, especially for DBAs who are new to Oracle Database. Oracle
         Database 2 Day + Performance Tuning Guide is a quick start guide that describes how
         to perform day-to-day database performance tuning tasks using features provided by
         Oracle Diagnostics Pack, Oracle Tuning Pack, and Oracle Enterprise Manager Cloud
         Control (Cloud Control).
         This chapter contains the following sections:
         •   About This Guide
         •   Common Oracle DBA Tasks
         •   Tools for Tuning the Database
         •   Accessing the Database Home Page


About This Guide
         Before using this guide, you must do the following:
         •   Be familiar with Oracle Database administration. See Oracle Database
             Administrator's Guide for more information.
         •   Obtain the necessary products and tools described in "Tools for Tuning the
             Database".
         Oracle Database 2 Day + Performance Tuning Guide is task-oriented. The objective is
         to describe why and when tuning tasks need to be performed.
         This guide is not an exhaustive discussion of all Oracle Database concepts. For that
         type of information, see Oracle Database Concepts.
         This guide does not describe basic Oracle Database administrative tasks. For that
         type of information, see Oracle Database Administrator's Guide.
         The primary interface used in this guide is the Enterprise Manager Cloud Control
         console. This guide is not an exhaustive discussion of all Oracle Database
         performance tuning features. It does not cover available application programming
         interfaces (APIs) that provide comparable tuning options to those presented in this
         guide. For this type of information, see Oracle Database Performance Tuning Guide
         and Oracle Database SQL Tuning Guide.


Common Oracle DBA Tasks
         As an Oracle DBA, you can expect to be involved in the following tasks:
         •   Installing Oracle software
         •   Creating Oracle databases




                                                                                             1-1
                                                                                              Chapter 1
                                                                          Tools for Tuning the Database


         •   Upgrading the database software to new releases
         •   Starting up and shutting down the database
         •   Managing the storage structures of the database
         •   Managing user accounts and security
         •   Managing schema objects, such as tables, indexes, and views
         •   Making database backups and performing database recovery, when necessary
         •   Monitoring proactively the condition of the database and taking preventive or
             corrective actions, as required
         •   Monitoring and tuning database performance
         This guide describes how to accomplish the last two tasks in the preceding list.


Tools for Tuning the Database
         The intent of this guide is to allow you to quickly and efficiently tune and optimize the
         performance of Oracle Database.
         To achieve the goals of this guide, you must acquire the following products, tools,
         features, and utilities:
         •   Oracle Database 19c, Version 19.1 (Enterprise Edition)
             Oracle Database offers enterprise-class performance, scalability and reliability on
             clustered and single-server configurations. It includes many performance features
             that are used in this guide.
         •   Oracle Enterprise Manager Cloud Control
             The primary tool to manage the database is Enterprise Manager Cloud Control
             (Cloud Control), a web-based interface. After you install the Oracle software,
             create or upgrade a database, and configure the network, you can use Cloud
             Control to manage the database. In addition, Cloud Control provides an interface
             for performance advisors and for database utilities, such as SQL*Loader and
             Recovery Manager (RMAN).
         •   Oracle Diagnostics Pack
             Oracle Diagnostics Pack offers a complete, cost-effective, and easy-to-use
             solution to manage the performance of Oracle Database environments by
             providing unique features, such as automatic identification of performance
             bottlenecks, guided problem resolution, and comprehensive system monitoring.
             Key features of Oracle Diagnostics Pack used in this guide include Automatic
             Workload Repository (AWR), Automatic Database Diagnostic Monitor (ADDM),
             and Active Session History (ASH).
         •   Oracle Tuning Pack
             Oracle Tuning Pack automates the database application tuning process, thereby
             significantly lowering database management costs while enhancing performance
             and reliability. Key features of Oracle Tuning Pack that are used in this guide
             include the following:
             –   SQL Tuning Advisor
                 This feature enables you to submit one or more SQL statements as input
                 and receive output in the form of specific advice or recommendations for




                                                                                                  1-2
                                                                                          Chapter 1
                                                                  Accessing the Database Home Page


                 how to tune statements, along with a rationale for each recommendation and
                 its expected benefit. A recommendation relates to collection of statistics on
                 objects, creation of new indexes, restructuring of the SQL statements, or
                 creation of SQL profiles.
             –   SQL Access Advisor
                 This feature enables you to optimize data access paths of SQL queries by
                 recommending the proper set of materialized views and view logs, indexes,
                 and partitions for a given SQL workload.
        •    Oracle Real Application Testing
             Oracle Real Application Testing consists of the following key features:
             –   Database Replay
                 This feature enables you to capture the database workload on a production
                 system, and replay it on a test system with the exact same timing and
                 concurrency as the production system on the same or later release of Oracle
                 Database.
             –   SQL Performance Analyzer
                 This feature enables you to assess the effect of system changes on SQL
                 performance by identifying SQL statements that have regressed, improved, or
                 remained unchanged.



                    See Also:
                    Oracle Database Testing Guide for information about how to use the
                    features Database Replay and SQL Performance Analyzer




                 Note:
                 Some of the products and tools in the preceding list, including Oracle
                 Diagnostics Pack and Oracle Tuning Pack, require separate licenses. For
                 more information, see Oracle Database Licensing Information.




Accessing the Database Home Page
        The Database Home page is the main database management page in Oracle
        Enterprise Manager Cloud Control (Cloud Control). After you log in to Cloud Control,
        you navigate to the Database Home page for the target database you want to manage
        in Cloud Control.
        To access the Database Home page in Cloud Control:
        1.   Start Cloud Control.
             The URL for accessing Cloud Control has the following syntax:
             http://hostname.domain:portnumber/em




                                                                                              1-3
                                                                                    Chapter 1
                                                            Accessing the Database Home Page


2.   In the Welcome page, enter your Cloud Control user name and password, and
     then click Login.
3.   From the Targets drop-down menu, select Databases.
     The Databases page appears with a list of the available target databases.
4.   Select the database that you want to observe or modify from the Databases page.
     If the list of databases is long, use the Search functionality.
     The home page for the target database appears. The first time that you select an
     option from some of the menus, such as the Performance menu, the Database
     Login page appears.
5.   In the login page for the target database, log in as a user with the appropriate
     privileges. For example, to log in as user SYS with the SYSDBA privilege:
     •   User Name: Enter SYS.
     •   Password: Enter the password for the SYS user.
     •   Connect As: From the Role list, select SYSDBA.




                                                                                        1-4
2
Oracle Database Performance Method
         Performance improvement is an iterative process. Removing the first bottleneck (a
         point where resource contention is highest) may not lead to performance improvement
         immediately because another bottleneck might be revealed that has an even greater
         performance impact on the system. Accurately diagnosing the performance problem is
         the first step toward ensuring that your changes improve performance.
         Typically, performance problems result from a lack of throughput (the amount of work
         that can be completed in a specified time), unacceptable user or job response time
         (the time to complete a specified workload), or both. The problem might be localized to
         specific application modules or it might span the system.
         Before looking at database or operating system statistics, it is crucial to get feedback
         from the system users and the people in charge of the application. This feedback
         makes it easier to set performance goals. Improved performance can be measured in
         terms of business goals rather than system statistics.
         The Oracle performance method can be applied until performance goals are met
         or deemed impractical. Because this process is iterative, some investigations may
         have little impact on system performance. It takes time and experience to accurately
         pinpoint critical bottlenecks quickly. Automatic Database Diagnostic Monitor (ADDM)
         implements the Oracle performance method and analyzes statistics to provide
         automatic diagnosis of major performance problems. Because ADDM can significantly
         shorten the time required to improve the performance of a system, it is the method
         used in this guide.
         This chapter discusses the Oracle Database performance method and contains the
         following sections:
         •   Gathering Database Statistics Using the Automatic Workload Repository
         •   Using the Oracle Performance Method
         •   Common Performance Problems Found in Databases


Gathering Database Statistics Using the Automatic
Workload Repository
         Database statistics provide information about the type of load on the database and
         the internal and external resources used by the database. To accurately diagnose
         performance problems with the database using ADDM, statistics must be available.
         A cumulative statistic is a count such as the number of block reads. Oracle
         Database generates many types of cumulative statistics for the system, sessions, and
         individual SQL statements. Oracle Database also tracks cumulative statistics about
         segments and services. Automatic Workload Repository (AWR) automates database
         statistics gathering by collecting, processing, and maintaining performance statistics
         for database problem detection and self-tuning purposes.




                                                                                              2-1
                                                                                                     Chapter 2
                                         Gathering Database Statistics Using the Automatic Workload Repository


           By default, the database gathers statistics every hour and creates an AWR snapshot,
           which is a set of data for a specific time that is used for performance comparisons. The
           delta values captured by the snapshot represent the changes for each statistic over
           the time period. Statistics gathered by AWR are queried from memory. The gathered
           data can be displayed in both reports and views.
           The following initialization parameters are relevant for AWR:
           •    STATISTICS_LEVEL
                Set this parameter to TYPICAL (default) or ALL to enable statistics gathering
                by AWR. Setting STATISTICS_LEVEL to BASIC disables many database features,
                including AWR, and is not recommended.
           •    CONTROL_MANAGEMENT_PACK_ACCESS
                Set to DIAGNOSTIC+TUNING (default) or DIAGNOSTIC to enable automatic database
                diagnostic monitoring. Setting CONTROL_MANAGEMENT_PACK_ACCESS to NONE disables
                many database features, including ADDM, and is strongly discouraged.



                    See Also:

                    •    Oracle Database Reference for more information about the
                         STATISTICS_LEVEL initialization parameter
                    •    Oracle Database Reference for more information about the
                         CONTROL_MANAGEMENT_PACK_ACCESS initialization parameter


           The database statistics collected and processed by AWR include:
           •    Time Model Statistics
           •    Wait Event Statistics
           •    Session and System Statistics
           •    Active Session History Statistics
           •    High-Load SQL Statistics


Time Model Statistics
           Time model statistics measure the time spent in the database by operation type. The
           most important time model statistic is database time (DB time). DB time represents
           the total time spent in database calls by foreground sessions, and is an indicator of the
           total instance workload. As shown in Figure 2-1, database time makes up a portion of
           an application's overall user response time.


           Figure 2-1     DB Time in Overall User Response Time

                                                 User Response Time




               Browser    WAN     App Server   LAN      DB Time     LAN    Apps Server     WAN      Browser




                                                                                                         2-2
                                                                                           Chapter 2
                               Gathering Database Statistics Using the Automatic Workload Repository


A session is a logical entity in the database instance memory that represents the state
of a current user login to a database. Database time is calculated by aggregating the
CPU time and wait time of all active sessions (sessions that are not idle). For any
database request, the CPU time is the sum of the time spent working on the request,
while the wait time is the sum of all the waits for various database instance resources.
DB time includes only time spent on client processes and does not include time spent
on background processes such as PMON.
For example, a user session may involve an online transaction made at an online
bookseller consisting of the actions shown in Figure 2-2.


Figure 2-2        DB Time in User Transaction

                          User Response Time
     Query for Novels     Browse Results          Add Item       Checkout
        by Author            of Query              to Cart




                                                                                        DB Time




1.     Query for novels by author
       The user performs a search for novels by a particular author. This action causes
       the application to perform a database query for novels by the author.
2.     Browse results of query
       The user browses the returned list of novels by the author and accesses additional
       details, such as user reviews and inventory status. This action causes the
       application to perform additional database queries.
3.     Add item to cart
       After browsing details about the novels, the user decides to add one novel to
       the shopping cart. This action causes the application to make a database call to
       update the shopping cart.
4.     Checkout
       The user completes the transaction by checking out, using the address and
       payment information previously saved at the bookseller's website from a previous
       purchase. This action causes the application to perform various database
       operations to retrieve the user's information, add a new order, update the
       inventory, and generate an email confirmation.
For each of the preceding actions, the user makes a request to the database,
as represented by the down arrow in Figure 2-2. The CPU time spent by the
database processing the request and the wait time spent waiting for the database
are considered DB time, as represented by the shaded areas. After the request is
completed, the results are returned to the user, as represented by the up arrow.
The space between the up and down arrows represents the total user response time
for processing the request, which contains other components besides DB time, as
illustrated in Figure 2-1.




                                                                                               2-3
                                                                                                    Chapter 2
                                        Gathering Database Statistics Using the Automatic Workload Repository




                   Note:
                   DB time is measured cumulatively from when the instance started. Because
                   DB time combines times from all non-idle user sessions, DB time can exceed
                   the time elapsed since the instance started. For example, an instance that
                   has run 5 minutes could have four active sessions whose cumulative DB
                   time is 20 minutes.



            The objective of database tuning is to reduce DB time. In this way, you can improve
            the overall response time of user transactions in the application.


Wait Event Statistics
            Wait events are incremented by a session to indicate that the session had to wait for
            an event to complete before being able to continue processing. When a session has
            to wait while processing a user request, the database records the wait by using one of
            a set of predefined wait events. The events are then grouped into wait classes, such
            as User I/O and Network. Wait event data reveals symptoms of problems that might be
            affecting performance, such as latch, buffer, or I/O contention.



                   See Also:

                   •   Oracle Database Performance Tuning Guide
                   •   Oracle Database Reference



Session and System Statistics
            A large number of cumulative database statistics are available on a system and
            session level. Some of these statistics are collected by AWR.


Active Session History Statistics
            The Active Session History (ASH) statistics are samples of session activity in the
            database. The database samples active sessions every second and stores them in
            a circular buffer in the System Global Area (SGA). Any session that is connected to
            the database and using CPU, or is waiting for an event that does not belong to the
            idle wait class, is considered an active session. By capturing only active sessions, a
            manageable set of data is represented. The size of the data is directly related to the
            work being performed, rather than the number of sessions allowed on the database.
            Using the DB time example described in "Time Model Statistics", samples of session
            activity are collected from the online transaction made at the bookseller's website,
            represented as vertical lines below the horizontal arrow in Figure 2-3.




                                                                                                        2-4
                                                                                               Chapter 2
                                                                    Using the Oracle Performance Method


           Figure 2-3     Active Session History

                                 User Response Time
           Query for Novels      Browse Results         Add Item    Checkout
              by Author             of Query             to Cart




                                                                                           DB Time
                  7:38                  7:42              7:50         7:52



           The light vertical lines represent samples of inactive session activity that are not
           captured in the ASH statistics. The bold vertical lines represent samples of active
           sessions that are captured at:
           •   7:38, while novels by the author are being queried
           •   7:42, while the user is browsing the query results
           •   7:50, when one novel is added to the shopping cart
           •   7:52, during the checkout process
           Table 2-1 lists ASH statistics collected for the active sessions, along with examples
           of the session ID (SID), module, SQL ID, session state, and wait events that are
           sampled.

           Table 2-1     Active Session History

           Time          SID       Module          SQL ID           State          Event
           7:38          213       Book by author qa324jffritcf     Waiting        db file sequential
                                                                                   read
           7:42          213       Get review ID   aferv5desfzs5    CPU            n/a
           7:50          213       Add item to     hk32pekfcbdfr    Waiting        buffer busy wait
                                   cart
           7:52          213       Checkout        abngldf95f4de    Waiting        log file sync


High-Load SQL Statistics
           SQL statements that are consuming the most resources produce the highest load on
           the system, based on criteria such as elapsed time and CPU time.


Using the Oracle Performance Method
           Performance tuning using the Oracle performance method is driven by identifying and
           eliminating bottlenecks in the database, and by developing efficient SQL statements.
           Database tuning is performed in two phases: proactively and reactively.
           In the proactive tuning phase, you must perform tuning tasks as part of your daily
           database maintenance routine, such as reviewing ADDM analysis and findings,
           monitoring the real-time performance of the database, and responding to alerts.




                                                                                                     2-5
                                                                                              Chapter 2
                                                                    Using the Oracle Performance Method


           In the reactive tuning phase, you must respond to issues reported by users, such as
           performance problems that may occur for only a short duration of time, or performance
           degradation to the database over a period of time.
           SQL tuning is an iterative process to identify, tune, and improve the efficiency of
           high-load SQL statements.
           Applying the Oracle performance method involves the following:
           •    Performing pre-tuning preparations, as described in "Preparing the Database for
                Tuning"
           •    Tuning the database proactively on a regular basis, as described in "Tuning the
                Database Proactively"
           •    Tuning the database reactively when performance problems are reported by the
                users, as described in "Tuning the Database Reactively"
           •    Identifying, tuning, and optimizing high-load SQL statements, as described in
                "Tuning SQL Statements"
           To improve database performance, you must apply these principles iteratively.


Preparing the Database for Tuning
           This section lists and describes the steps that must be performed before the database
           can be properly tuned.

           To prepare the database for tuning:
           1.   Get feedback from users.
                Determine the scope of the performance project and subsequent performance
                goals, and determine performance goals for the future. This process is key for
                future capacity planning.
           2.   Check the operating systems of all systems involved with user performance.
                Check for hardware or operating system resources that are fully utilized. List
                any overused resources for possible later analysis. In addition, ensure that all
                hardware is functioning properly.
           3.   Ensure that the STATISTICS_LEVEL initialization parameter is set to TYPICAL
                (default) or ALL to enable the automatic performance tuning features of Oracle
                Database, including AWR and ADDM.
           4.   Ensure that the CONTROL_MANAGEMENT_PACK_ACCESS initialization parameter is set to
                DIAGNOSTIC+TUNING (default) or DIAGNOSTIC to enable ADDM.



                   See Also:

                   •   "Gathering Database Statistics Using the Automatic Workload
                       Repository" for information about configuring AWR
                   •   "Configuring Automatic Database Diagnostic Monitor"




                                                                                                   2-6
                                                                                             Chapter 2
                                                                   Using the Oracle Performance Method




Tuning the Database Proactively
           This section lists and describes the proactive steps required to keep the database
           properly tuned on a regular basis. Perform these steps as part of your daily
           maintenance of Oracle Database. Repeat the tuning process until your performance
           goals are met or become impossible to achieve because of other constraints.

           To tune the database proactively:
           1.   Review the ADDM findings, as described in Automatic Database Performance
                Monitoring.
                ADDM automatically detects and reports on performance problems with the
                database, including most of the "Common Performance Problems Found in
                Databases". The results are displayed as ADDM findings on the Database Home
                page in Oracle Enterprise Manager Cloud Control (Cloud Control). Reviewing
                these findings enables you to quickly identify the performance problems that
                require your attention.
           2.   Implement the ADDM recommendations, as described in Automatic Database
                Performance Monitoring.
                With each ADDM finding, ADDM automatically provides a list of recommendations
                for reducing the impact of the performance problem. Implementing a
                recommendation applies the suggested changes to improve the database
                performance.
           3.   Monitor performance problems with the database in real time, as described in
                Monitoring Real-Time Database Performance.
                The Performance page in Cloud Control enables you to identify and respond to
                real-time performance problems. By drilling down to the appropriate pages, you
                can identify and resolve performance problems with the database in real time,
                without having to wait until the next ADDM analysis.
           4.   Respond to performance-related alerts, as described in Monitoring Performance
                Alerts.
                The Database Home page in Cloud Control displays performance-related alerts
                generated by the database. Typically, resolving the problems indicated by these
                alerts improves database performance.
           5.   Validate that any changes have produced the desired effect, and verify that the
                users experience performance improvements.


Tuning the Database Reactively
           This section lists and describes the steps required to tune the database based on
           user feedback. This tuning procedure is considered reactive. Perform this procedure
           periodically when performance problems are reported by the users.

           To tune the database reactively:
           1.   Run ADDM manually to diagnose current and historical database performance
                when performance problems are reported by the users, as described in Manual
                Database Performance Monitoring.




                                                                                                  2-7
                                                                                            Chapter 2
                                                      Common Performance Problems Found in Databases


               In this way you can analyze current database performance before the next
               ADDM analysis, or analyze historical database performance when you were not
               proactively monitoring the system.
          2.   Resolve transient performance problems, as described in Resolving Transient
               Performance Problems.
               The Active Session History (ASH) reports enable you to analyze transient
               performance problems with the database that are short-lived and do not appear
               in the ADDM analysis.
          3.   Resolve performance degradation over time, as described in Resolving
               Performance Degradation Over Time.
               The Automatic Workload Repository (AWR) Compare Periods report enables you
               to compare database performance between two periods of time, and resolve
               performance degradation that may happen from one time period to another.
          4.   Validate that the changes made have produced the desired effect, and verify that
               the users experience performance improvements.
          5.   Repeat these steps until your performance goals are met or become impossible to
               achieve due to other constraints.


Tuning SQL Statements
          This section lists and describes the steps required to identify, tune, and optimize
          high-load SQL statements.

          To tune SQL statements:
          1.   Identify high-load SQL statements, as described in Identifying High-Load SQL
               Statements.
               Use the ADDM findings and the Top SQL section to identify high-load SQL
               statements that are causing the greatest contention.
          2.   Tune high-load SQL statements, as described in Tuning SQL Statements.
               You can improve the efficiency of high-load SQL statements by tuning them using
               SQL Tuning Advisor.
          3.   Optimize data access paths, as described in Optimizing Data Access Paths.
               You can optimize the performance of data access paths by creating the proper set
               of materialized views, materialized view logs, and indexes for a given workload by
               using SQL Access Advisor.
          4.   Analyze the SQL performance impact of SQL tuning and other system changes by
               using SQL Performance Analyzer.
               To learn how to use SQL Performance Analyzer, see Oracle Database Testing
               Guide.
          5.   Repeat these steps until all high-load SQL statements are tuned for greatest
               efficiency.


Common Performance Problems Found in Databases
          This section lists and describes common performance problems found in databases.
          By following the Oracle performance method, you should be able to avoid these




                                                                                                2-8
                                                                                Chapter 2
                                          Common Performance Problems Found in Databases


problems in an Oracle Database instance. If you experience these problems, then
repeat the steps in the Oracle performance method, as described in "Using the
Oracle Performance Method", or consult the appropriate section that addresses these
problems:
•   CPU bottlenecks
    Is the application performing poorly because the system is CPU-bound?
    Performance problems caused by CPU bottlenecks are diagnosed by ADDM, as
    described in Automatic Database Performance Monitoring. You can also identify
    CPU bottlenecks by using the Performance page in Cloud Control, as described in
    "Monitoring CPU Utilization".
•   Undersized memory structures
    Are the Oracle memory structures such as the System Global Area (SGA),
    Program Global Area (PGA), and buffer cache adequately sized? Performance
    problems caused by undersized memory structures are diagnosed by ADDM, as
    described in Automatic Database Performance Monitoring. You can also identify
    memory usage issues by using the Performance page in Cloud Control, as
    described in "Monitoring Memory Utilization".
•   I/O capacity issues
    Is the I/O subsystem performing as expected? Performance problems caused
    by I/O capacity issues are diagnosed by ADDM, as described in Automatic
    Database Performance Monitoring. You can also identify disk I/O issues by using
    the Performance page in Cloud Control, as described in "Monitoring Disk I/O
    Utilization".
•   Suboptimal use of Oracle Database by the application
    Is the application making suboptimal use of Oracle Database? Problems such
    as establishing new database connections repeatedly, excessive SQL parsing,
    and high levels of contention for a small amount of data (also known as
    application-level block contention) can degrade the application performance
    significantly. Performance problems caused by suboptimal use of Oracle Database
    by the application are diagnosed by ADDM, as described in Automatic
    Database Performance Monitoring. You can also monitor top activity in various
    dimensions—including SQL, session, services, modules, and actions—by using
    the Performance page in Cloud Control, as described in "Monitoring User Activity".
•   Concurrency issues
    Is the database performing suboptimally due to a high degree of concurrent
    activities in the database? A high degree of concurrent activities might result in
    contention for shared resources that can manifest in the form of locks or waits for
    buffer cache. Performance problems caused by concurrency issues are diagnosed
    by ADDM, as described in Automatic Database Performance Monitoring. You
    can also identify concurrency issues by using Top Sessions in Cloud Control, as
    described in "Monitoring Top Sessions".
•   Database configuration issues
    Is the database configured optimally to provide desired performance levels?
    For example, is there evidence of incorrect sizing of log files, archiving issues,
    too many checkpoints, or suboptimal parameter settings? Performance problems
    caused by database configuration issues are diagnosed by ADDM, as described in
    Automatic Database Performance Monitoring.
•   Short-lived performance problems




                                                                                    2-9
                                                                                 Chapter 2
                                           Common Performance Problems Found in Databases


    Are users complaining about short-lived or intermittent performance problems?
    Depending on the interval between snapshots taken by AWR, performance
    problems that have a short duration may not be captured by ADDM. You can
    identify short-lived performance problems by using the Active Session History
    report, as described in Resolving Transient Performance Problems.
•   Degradation of database performance over time
    Is there evidence that the database performance has degraded over time? For
    example, are you or your users noticing that the database is not performing
    as well as it was 6 months ago? You can generate an AWR Compare Periods
    report to compare the period when the performance was poor to a period when
    the performance is stable to identify configuration settings, workload profile, and
    statistics that are different between these two time periods. This technique helps
    you identify the cause of the performance degradation, as described in Resolving
    Performance Degradation Over Time.
•   Inefficient or high-load SQL statements
    Are any SQL statements using excessive system resources that impact
    the system? Performance problems caused by high-load SQL statements
    are diagnosed by ADDM, as described in Automatic Database Performance
    Monitoring and "Identification of High-Load SQL Statements Using ADDM
    Findings". You can also identify high-load SQL statements by using Top SQL in
    Cloud Control, as described in "Identifying High-Load SQL Statements Using Top
    SQL". After they have been identified, you can tune the high-load SQL statements
    using SQL Tuning Advisor, as described in Tuning SQL Statements.
•   Object contention
    Are any database objects the source of bottlenecks because they are continuously
    accessed? Performance problems caused by object contention are diagnosed by
    ADDM, as described in Automatic Database Performance Monitoring. You can
    also optimize the data access path to these objects using SQL Access Advisor, as
    described in Optimizing Data Access Paths.
•   Unexpected performance regression after tuning SQL statements
    Is the performance of SQL statements degrading after they have been tuned?
    Tuning SQL statements may cause changes to their execution plans, resulting in
    a significant impact on SQL performance. In some cases, the changes may result
    in the improvement of SQL performance. In other cases, the changes may cause
    SQL statements to regress, resulting in a degradation of SQL performance.
    Before making changes on a production system, you can analyze the impact of
    SQL tuning on a test system by using SQL Performance Analyzer. This feature
    enables you to forecast the impact of system changes on a SQL workload by:
    –   Measuring the performance before and after the change
    –   Generating a report that describes the change in performance
    –   Identifying the SQL statements that regressed or improved
    –   Providing tuning recommendations for each SQL statement that regressed
    –   Enabling you to implement the tuning recommendations when appropriate




                                                                                   2-10
                                                                  Chapter 2
                            Common Performance Problems Found in Databases




See Also:
Oracle Database Testing Guide to know more about how to use SQL
Performance Analyzer




                                                                     2-11
Part II
Proactive Database Tuning
      Part II describes how to tune Oracle Database proactively on a regular basis and
      contains the following chapters:
      •   Automatic Database Performance Monitoring
      •   Monitoring Real-Time Database Performance
      •   Monitoring Real-Time Database Operations
      •   Monitoring Performance Alerts
3
Automatic Database Performance
Monitoring
         Automatic Database Diagnostic Monitor (ADDM) automatically detects and reports
         performance problems with the database. The results are displayed as ADDM
         findings on the Database Home page in Oracle Enterprise Manager Cloud Control
         (Cloud Control). Reviewing the ADDM findings enables you to quickly identify the
         performance problems that require your attention. Before using another performance
         tuning method described in this guide, first review the results of the ADDM analysis.
         Each ADDM finding provides a list of recommendations for reducing the impact of
         the performance problem. You should review ADDM findings and implement the
         recommendations every day as part of regular database maintenance. Even when
         the database is operating at an optimal performance level, you should continue to use
         ADDM to monitor database performance on an ongoing basis.
         This chapter contains the following sections:
         •   Overview of Automatic Database Diagnostic Monitor
         •   Configuring Automatic Database Diagnostic Monitor
         •   Reviewing the Automatic Database Diagnostic Monitor Analysis
         •   Interpretation of Automatic Database Diagnostic Monitor Findings
         •   Implementing Automatic Database Diagnostic Monitor Recommendations
         •   Viewing Snapshot Statistics



                See Also:

                •   Oracle Database Performance Tuning Guide for information about using
                    the DBMS_ADVISOR package to diagnose and tune the database with the
                    Automatic Database Diagnostic Monitor



Overview of Automatic Database Diagnostic Monitor
         ADDM is diagnostic software built into Oracle Database. ADDM examines and
         analyzes data captured in Automatic Workload Repository (AWR) to determine
         possible database performance problems. ADDM then does the following:
         •   Locates the root causes of the performance problems
         •   Provides recommendations for correcting them
         •   Quantifies the expected benefits
         •   Identifies areas where no action is necessary.




                                                                                            3-1
                                                                                               Chapter 3
                                                       Overview of Automatic Database Diagnostic Monitor


         This section contains the following topics:
         •   ADDM Analysis
         •   ADDM Recommendations
         •   ADDM for Oracle Real Application Clusters
         •   ADDM for a Multitenant Environment


ADDM Analysis
         An ADDM analysis is performed after each AWR snapshot (every hour by default),
         and the results are saved in the database. You can then view the results using Cloud
         Control.
         The ADDM analysis is performed from the top down, first identifying symptoms and
         then refining the analysis to reach the root causes of performance problems. ADDM
         uses the DB time statistic to identify performance problems. Database time (DB) time
         is the cumulative time spent by the database in processing user requests, including
         both the wait time and CPU time of all user sessions that are not idle.
         The goal of database performance tuning is to reduce the DB time of the system for
         a given workload. By reducing DB time, the database can support more user requests
         by using the same or fewer resources. ADDM reports system resources that are using
         a significant portion of DB time as problem areas and sorts them in descending order
         by the amount of related DB time spent.



                See Also:
                "Time Model Statistics" for more information about the DB time statistic



ADDM Recommendations
         In addition to diagnosing performance problems, ADDM recommends possible
         solutions. When appropriate, ADDM recommends multiple solutions from which you
         can choose. ADDM recommendations include the following:
         •   Hardware changes
             Adding CPUs or changing the I/O subsystem configuration
         •   Database configuration
             Changing initialization parameter settings
         •   Schema changes
             Hash partitioning a table or index, or using automatic segment space management
             (ASSM)
         •   Application changes
             Using the cache option for sequences or using bind variables
         •   Using other advisors
             Running SQL Tuning Advisor on high-load SQL statements or running the
             Segment Advisor on hot objects



                                                                                                   3-2
                                                                                               Chapter 3
                                                       Overview of Automatic Database Diagnostic Monitor


           ADDM benefits apply beyond production systems. Even on development and test
           systems, ADDM can provide an early warning of potential performance problems.
           Performance tuning is an iterative process. Fixing one problem can cause a bottleneck
           to shift to another part of the system. Even with the benefit of the ADDM analysis, it
           can take multiple tuning cycles to reach a desirable level of performance.


ADDM for Oracle Real Application Clusters
           In an Oracle Real Application Clusters (Oracle RAC) environment, you can use ADDM
           to analyze the throughput performance of a database cluster. ADDM for Oracle RAC
           considers DB time as the sum of database times for all database instances and
           reports findings that are significant at the cluster level. For example, the DB time of
           each cluster node may be insignificant when considered individually, but the aggregate
           DB time may be a significant problem for the cluster as a whole.



                  See Also:

                  •   Oracle Real Application Clusters Administration and Deployment Guide
                      for information about using ADDM for Oracle RAC



ADDM for a Multitenant Environment
           Starting with Oracle Database 12c, ADDM is enabled by default in the root container of
           a multitenant container database (CDB). Starting with Oracle Database 19c, you can
           also use ADDM in a pluggable database (PDB).



                  Note:
                  A multitenant container database is the only supported architecture in Oracle
                  Database 21c. While the documentation is being revised, legacy terminology
                  may persist. In most cases, "database" and "non-CDB" refer to a CDB or
                  PDB, depending on context. In some contexts, such as upgrades, "non-CDB"
                  refers to a non-CDB from a previous release.



           To use ADDM in a PDB, you must enable automatic snapshots in the PDB by setting
           the AWR_PDB_AUTOFLUSH_ENABLED initialization parameter to TRUE and AWR snapshot
           interval greater than 0.



                  See Also:
                  Oracle Database Performance Tuning Guide for more information about
                  using ADDM in a multitenant environment




                                                                                                   3-3
                                                                                                  Chapter 3
                                                          Configuring Automatic Database Diagnostic Monitor




Configuring Automatic Database Diagnostic Monitor
           This section contains the following topics:
           •    Setting Initialization Parameters to Enable ADDM
           •    Setting the DBIO_EXPECTED Parameter
           •    Managing AWR Snapshots


Setting Initialization Parameters to Enable ADDM
           Automatic database diagnostic monitoring is enabled by default and is controlled
           by the CONTROL_MANAGEMENT_PACK_ACCESS and the STATISTICS_LEVEL initialization
           parameters.
           Set CONTROL_MANAGEMENT_PACK_ACCESS to DIAGNOSTIC+TUNING (default) or
           DIAGNOSTIC to enable automatic database diagnostic monitoring. Setting
           CONTROL_MANAGEMENT_PACK_ACCESS to NONE disables many Oracle Database features,
           including ADDM, and is strongly discouraged.
           Set STATISTICS_LEVEL to TYPICAL (default) or ALL to enable automatic database
           diagnostic monitoring. Setting STATISTICS_LEVEL to BASIC disables many Oracle
           Database features, including ADDM, and is strongly discouraged.

           To determine whether ADDM is enabled:
           1.   Access the Database Home page.
                See "Accessing the Database Home Page" for more information.
           2.   From the Administration menu, select Initialization Parameters.
                If the Database Login page appears, then log in as a user with administrator
                privileges. The Initialization Parameters page appears.
           3.   In the Name field, enter statistics_level and then click Go.
                The Initialization Parameters table shows the setting of this initialization parameter.




           4.   Do one of the following:
                •   If the Value list shows ALL or TYPICAL, then do nothing.
                •   If the Value list shows BASIC, then select ALL or TYPICAL, and then click
                    Apply.
           5.   In the Name field, enter control_management_pack_access, and then click Go.
                The table shows the setting of this initialization parameter.
           6.   Do one of the following:
                •   If the Value column shows DIAGNOSTIC or DIAGNOSTIC+TUNING, then do
                    nothing.




                                                                                                      3-4
                                                                                                Chapter 3
                                                        Configuring Automatic Database Diagnostic Monitor


               •       If the Value column shows NONE, then select DIAGNOSTIC or
                       DIAGNOSTIC+TUNING and click Apply.



                   See Also:

                   •     Oracle Database Reference for information about the STATISTICS_LEVEL
                         initialization parameter
                   •     Oracle Database Reference for information about the
                         CONTROL_MANAGEMENT_PACK_ACCESS initialization parameter



Setting the DBIO_EXPECTED Parameter
          ADDM analysis of I/O performance partially depends on a single argument,
          DBIO_EXPECTED, that describes the expected performance of the I/O subsystem. The
          value of DBIO_EXPECTED is the average time it takes to read a single database block, in
          microseconds. Oracle Database uses the default value of 10 milliseconds, which is an
          appropriate value for most hard drives. You can choose a different value based on the
          characteristics of your hardware.

          To determine the correct setting for the DBIO_EXPECTED initialization parameter:

          1.   Measure the average read time of a single database block for your hardware.
               This measurement must be taken for random I/O, which includes seek time if you
               use standard hard drives. Typical values for hard drives are between 5000 and
               20000 microseconds.



                         See Also:
                         Oracle Database Performance Tuning Guide to learn how to assess the
                         I/O capability of the storage subsystem


          2.   Set the value one time for all subsequent ADDM executions.
               For example, if the measured value is 8000 microseconds, then execute the
               following PL/SQL code as the SYS user:
               EXECUTE DBMS_ADVISOR.SET_DEFAULT_TASK_PARAMETER(
                                    'ADDM', 'DBIO_EXPECTED', 8000);


Managing AWR Snapshots
          By default, the Automatic Workload Repository (AWR) generates snapshots of
          performance data once every hour, and retains the statistics in the workload repository
          for 8 days. You can change the default values for both the snapshot interval and the
          retention period.
          Oracle recommends that you adjust the AWR retention period to at least one month.
          You can also extend the period to one business cycle so you can compare data across
          time frames such as the close of the fiscal quarter. You can also create AWR baselines
          to retain snapshots indefinitely for important time periods.



                                                                                                    3-5
                                                                                                  Chapter 3
                                                          Configuring Automatic Database Diagnostic Monitor


            The data in the snapshot interval is analyzed by ADDM. ADDM compares the
            differences between snapshots to determine which SQL statements to capture, based
            on the effect on the system load. The ADDM analysis shows the number of SQL
            statements that need to be captured over time.
            This section contains the following topics:
            •    Creating Snapshots
            •    Modifying Snapshot Settings

Creating Snapshots
            Manually creating snapshots is usually not necessary because AWR generates
            snapshots of the performance data once every hour by default. In some cases,
            however, it may be necessary to manually create snapshots to capture different
            durations of activity, such as when you want to compare performance data over a
            shorter period than the snapshot interval.

            To create snapshots:
            1.   Access the Database Home page.
                 See "Accessing the Database Home Page" for more information.
            2.   From the Performance menu, select AWR and then select AWR Administration.
                 If the Database Login page appears, then log in as a user with administrator
                 privileges. The Automatic Workload Repository page appears.
            3.   Under Manage Snapshots and Baselines, click the number next to Snapshots.
                 The Snapshots page appears with a list of the most recent snapshots.
            4.   Click Create.
                 The Confirmation page appears.
            5.   Click Yes.
                 The Processing: Create Snapshot page is displayed while the snapshot is being
                 taken.
                 After the snapshot is taken, the Snapshots page reappears with a Confirmation
                 message.
                 The following screenshot of the list of snapshots shows that a snapshot was
                 created at 9:24:25 a.m. The ID of the snapshot is 383.




                                                                                                      3-6
                                                                                                 Chapter 3
                                                         Configuring Automatic Database Diagnostic Monitor




Modifying Snapshot Settings
            By default, AWR generates snapshots of performance data once every hour. You can
            modify the default values of both the interval between snapshots and their retention
            period.

            To modify the snapshot settings:
            1.   Access the Database Home page.
                 See "Accessing the Database Home Page" for more information.
            2.   From the Performance menu, select AWR, then select AWR Administration.
                 If the Database Login page appears, then log in as a user with administrator
                 privileges. The Automatic Workload Repository page appears.
                 In the following screenshot of the General section of the page, the snapshot
                 retention is set to 8 days and the snapshot interval is set to 60 minutes.




            3.   Click Edit.
                 The Edit Settings page appears.




            4.   For Snapshot Retention, do one of the following:
                 •   Select Use Time-Based Retention Period (Days), and in the associated field
                     enter the number of days to retain the snapshots.
                 •   Select Retain Forever to retain snapshots indefinitely.
                 It is recommended that you increase the snapshot retention period to the
                 maximum allowed by the available disk space.
                 In the following screenshot of the Snapshot Retention group, the snapshot
                 retention period is changed to 30 days.




                                                                                                     3-7
                                                                                                 Chapter 3
                                              Reviewing the Automatic Database Diagnostic Monitor Analysis


         5.   For Snapshot Collection, do one of the following:
              •   Select System Snapshot Interval, and in the Interval list, select the desired
                  interval to change the interval between snapshots.
              •   Select Turn off Snapshot Collection to disable snapshot collection.
              In the following screenshot of the Snapshot Collection group, the snapshot
              collection interval is changed to 30 minutes.




         6.   Click the link next to Collection Level.
              The Initialization Parameters page appears.
              To change the statistics level, select TYPICAL or ALL in the Value list for the
              statistics_level parameter. Click Save to File to set the value in the server
              parameter file.
              In the following screenshot of the Initialization Parameters table, the default value
              of Typical is used.




         7.   Click OK to apply the changes.
              The Automatic Workload Repository page appears and displays the new settings.




Reviewing the Automatic Database Diagnostic Monitor
Analysis
         By default, ADDM runs every hour to analyze snapshots taken by AWR during that
         period. If the database finds performance problems, then it displays the results of the
         analysis under Diagnostics in the Summary section on the Database Home page.




                                                                                                     3-8
                                                                                                    Chapter 3
                                                 Reviewing the Automatic Database Diagnostic Monitor Analysis


             The ADDM Findings link shows how many ADDM findings were found in the most
             recent ADDM analysis.

             To view ADDM findings:
             1.   Access the Database Home page.
                  See "Accessing the Database Home Page" for more information.
             2.   From the Performance menu, select Advisors Home.
                  If the Database Login page appears, then log in as a user with administrator
                  privileges. The Advisor Central page appears.
             3.   In the Results section of Advisor Tasks, select the most recent ADDM result, and
                  then click View Result.
                  The Automatic Database Diagnostic Monitor (ADDM) page appears. The results of
                  the ADDM run are displayed.

Figure 3-1   The Automatic Database Diagnostic Monitor Page




                  On the Automatic Database Diagnostic Monitor (ADDM) page, the Database
                  Activity chart shows the database activity during the ADDM analysis period.
                  Database activity types are defined in the legend based on their corresponding
                  colors in the chart. Each icon below the chart represents a different ADDM task,
                  which in turn corresponds to a pair of snapshots saved in AWR.
                  In Figure 3-1, stacked area chart in the Database Activity section shows that the
                  most database activity was between 2:00 p.m. to 4:30 p.m. on December 30.
                  During that time, the activity was dominated by CPU and wait classes, with very
                  little I/O happening.



                                                                                                        3-9
                                                                                                    Chapter 3
                                             Interpretation of Automatic Database Diagnostic Monitor Findings


               In the ADDM Performance Analysis section, ADDM findings are listed in
               descending order, from highest to least impact. The Informational Findings section
               lists areas that have no performance impact and are for information only.




          4.   Optionally, click the Zoom icons to shorten or lengthen the analysis period
               displayed on the chart.
          5.   To view the ADDM findings in a report, click View Report.
               The View Report page appears.
               You can click Save to File to save the report for later access.


Interpretation of Automatic Database Diagnostic Monitor
Findings
          The ADDM analysis results are represented as a set of findings. Each ADDM finding
          belongs to one of three types:
          •    Problem
               Findings that describe the root cause of a database performance issue
          •    Symptom
               Findings that contain information that often leads to one or more problem findings
          •    Information
               Findings that are used to report areas of the system that do not have a
               performance impact
          Each problem finding is quantified with an estimate of the portion of DB time that
          resulted from the performance problem.
          When a specific problem has multiple causes, ADDM may report multiple findings.
          In this case, the impacts of these multiple findings can contain the same portion of
          DB time. Because performance problems can overlap, summing the impacts of the
          reported findings can yield a number higher than 100% of DB time. For example, if
          a system performs many read I/O operations, ADDM may report a SQL statement
          responsible for 50% of DB time due to I/O activity as one finding, and an undersized
          buffer cache responsible for 75% of DB time as another finding.
          A problem finding can be associated with a list of recommendations for reducing
          the impact of a performance problem. Each recommendation has a benefit that is
          an estimate of the portion of DB time that can be saved if the recommendation is
          implemented. When multiple recommendations are associated with an ADDM finding,
          the recommendations may contain alternatives for solving the same problem. In this
          case, the sum of the benefits may be higher than the impact of the finding. You do not
          need to apply all the recommendations to solve the same problem.



                                                                                                       3-10
                                                                                              Chapter 3
                                     Implementing Automatic Database Diagnostic Monitor Recommendations


         Recommendations are composed of actions and rationales. You must apply all the
         actions of a recommendation to gain its estimated benefit. The rationales explain
         why the set of actions are recommended, and provide additional information for
         implementing them. An ADDM action may present multiple solutions. If this is the
         case, then choose the easiest solution to implement.


Implementing Automatic Database Diagnostic Monitor
Recommendations
         This section describes how to implement ADDM recommendations. ADDM findings are
         displayed in the Automatic Database Diagnostic Monitor (ADDM) page under ADDM
         Performance Analysis.

         To implement ADDM recommendations:
         1.   Access the Database Home page.
              See "Accessing the Database Home Page" for more information.
         2.   From the Performance menu, select Advisors Home.
              If the Database Login page appears, then log in as a user with administrator
              privileges. The Advisor Central page appears.
         3.   In the Results section of Advisor Tasks, select the most recent ADDM result, then
              click View Result.
              The Automatic Database Diagnostic Monitor (ADDM) page appears.
         4.   In the Database Activity section, click the chart icon for the ADDM run to
              investigate.
              The data in the ADDM Performance Analysis section changes based on the
              ADDM run that you selected.
         5.   In the ADDM Performance Analysis table, click the ADDM finding that has the
              greatest impact.
              In the following screenshot of the ADDM Performance Analysis table, the finding
              with the greatest impact is Top SQL Statements.




              The Performance Finding Details page appears.
              In the following screen shot of the Performance Finding Details page, five
              recommendations are shown. The first is estimated to have a maximum benefit
              of up to 26.7% of DB time in the analysis period. The second recommendation is
              estimated to have a maximum benefit of up to 10.9% of DB time, the third also
              has a maximum of 10.9%, the fourth has a maximum of 9.9%, and the fifth has a
              maximum of 5%.




                                                                                                 3-11
                                                                                    Chapter 3
                           Implementing Automatic Database Diagnostic Monitor Recommendations




6.   Under Recommendations, click Show to review the recommendations and
     required actions for each recommendation.
     The Category column displays the category of the recommendation. The Benefit
     (%) column displays the estimated benefit of implementing the recommendation.
     Figure 3-2 shows the recommendations for the first item in the Recommendations
     table.

     Figure 3-2   Recommendations on the Performance Finding Details Page




7.   If additional information is available about why the set of actions was
     recommended, then click Additional Information, or review the content displayed
     under Additional Information.
     For example, the following screenshot shows an Undersized Buffer Cache finding
     that contains additional information that indicates the recommended value of the
     DB_CACHE_SIZE initialization parameter.



                                                                                       3-12
                                                                                     Chapter 3
                            Implementing Automatic Database Diagnostic Monitor Recommendations




8.   To view the history of a finding, click Finding History.
     The Finding History page appears. The following screenshot shows the Finding
     History page for the top SQL statements.




     The Finding History page shows how often a particular finding has occurred in
     a selected 3-hour interval. You can use this information to determine whether
     the finding was a transient or a persistent problem in the system. Based on this



                                                                                        3-13
                                                                                                Chapter 3
                                                                              Viewing Snapshot Statistics


              information, you can determine whether the actions associated with the finding
              should be implemented.
              The Active Sessions stacked area chart shows the impact of the finding and of the
              other loads on the system. You can change the display as follows:
              a.   To move the 3-hour interval, click and drag the shaded box in the Active
                   Sessions chart.
              b.   To change dates, enter the desired date in the View field, and then click Go.
              c.   To view details about a finding, under Detail for Selected 3 Hour Interval, click
                   the link in the Finding Details column to display the Performance Finding
                   Details page for the corresponding ADDM finding.
         9.   Optionally, create a filter to suppress known findings that have been tuned or
              cannot be tuned further. To create filters for a selected ADDM finding:
              a.   Click Filters.
                   The Filters for Finding page appears.
              b.   Click Create.
                   The Create Filter for Finding page appears.
              c.   In the Name field, enter a name for the ADDM filter.
              d.   In the Active Sessions field, specify the filter criteria in terms of the number of
                   active sessions.
                   The database filters the ADDM finding for future ADDM runs if the number of
                   active sessions for the finding is less than the specified filter criteria.
              e.   In the % Active Sessions field, specify the filter criteria in terms of percentage
                   of active sessions.
                   The database filters the ADDM finding for future ADDM runs if the number of
                   active sessions for the finding is less than the specified filter criteria.
              f.   Click OK.
         10. Perform the required action of a chosen recommendation.

              Depending on the type of action you choose to perform, various options may be
              available, such as Implement or Run Advisor Now. These options enable you to
              implement the recommendation immediately with a single mouse click.
              In the example shown in Figure 3-2, the simplest solution is to click Run Advisor
              Now to immediately run a SQL Tuning Advisor task on the SQL statement.



                      See Also:

                      •   "Tuning SQL Statements "



Viewing Snapshot Statistics
         You can view the data contained in snapshots taken by AWR using Cloud Control.
         Typically, it is not necessary to review snapshot data because it primarily contains
         raw statistics. Instead, rely on ADDM, which analyzes statistics to identify performance




                                                                                                   3-14
                                                                                     Chapter 3
                                                                   Viewing Snapshot Statistics


problems. Snapshot statistics are intended primarily for advanced users, such as
DBAs accustomed to using Statspack for performance analysis.

To view snapshot statistics:
1.   Access the Database Home page.
     See "Accessing the Database Home Page" for more information.
2.   From the Performance menu, select AWR and then select AWR Administration.
     If the Database Login page appears, then log in as a user with administrator
     privileges. The Performance page appears.
3.   Under Manage Snapshots and Baselines, click the number next to Snapshots.
     The Snapshots page appears with a list of the most recent snapshots.
4.   To view the statistics gathered in a snapshot, click the ID link of the snapshot you
     want to view.
     The Snapshot Details appears, showing the Details subpage.
     The following screenshot of a Details subpage shows statistics gathered from the
     previous snapshot (snapshot 386) to the selected snapshot (snapshot 387).




                                                                                        3-15
                                                                                      Chapter 3
                                                                    Viewing Snapshot Statistics




5.   To view a Workload Repository report of the statistics, click Report.
     The Workload Repository report appears.
6.   Optionally, click Save to File to save the report for later access.



        See Also:

        •   " Resolving Performance Degradation Over Time "




                                                                                         3-16
4
Monitoring Real-Time Database
Performance
          The Automatic Database Diagnostic Monitor (ADDM) automatically identifies
          performance problems with the database, as described in Automatic Database
          Performance Monitoring. Information on performance appears on the Performance
          page in Oracle Enterprise Manager Cloud Control (Cloud Control).
          By drilling down to other pages from the Performance page, you can identify database
          performance problems in real time. If you find a problem, then you can run ADDM
          manually to analyze it immediately without having to wait until the next ADDM
          analysis. To learn how to run ADDM manually, see "Manually Running ADDM to
          Analyze Current Database Performance".
          This chapter describes how to monitor some aspects of database activity. It contains
          the following sections:
          •    Monitoring User Activity
          •    Monitoring Instance Activity
          •    Monitoring Host Activity
          •    Determining the Cause of Spikes in Database Activity
          •    Customizing the Database Performance page


Monitoring User Activity
          As described in Oracle Database Performance Method , database time (DB time) is
          an indicator of the total database instance workload. The average active sessions
          for a time period equals the total database time of all user sessions during the period
          divided by the elapsed time (wall-clock time) for the period.
          The Average Active Sessions graph on the Performance Hub page shows the
          average active sessions for CPU usage and wait classes in the time period. You
          can drill down by clicking on the graph to identify the causes of instance-related
          performance issues and resolve them.

          To monitor user activity:
          1.   Access the Database Home page.
               See "Accessing the Database Home Page" for more information.
          2.   From the Performance menu, select Performance Hub and ASH Analytics.
               If the Database Login page appears, then log in as a user with administrator
               privileges. The Performance Hub page appears.
          3.   Locate any spikes or other areas of interest in the Average Active Sessions
               stacked area chart.




                                                                                               4-1
                                                                                              Chapter 4
                                                                                Monitoring User Activity


                Figure 4-1 shows an example of one dimension of the Average Active Sessions
                chart on the Performance Hub page.


Figure 4-1   Average Active Sessions by Wait Class




                Each color-filled area on the stacked area chart shows the average active
                sessions for the specified event at the specified time. In the chart, the average
                active sessions amount for each event is stacked upon the one below it. The
                events appear on the chart in the order shown in the legend, with CPU starting
                at zero on the y-axis and the other events stacked in ascending order, from CPU
                Wait to Other. The wait classes show how much database activity is consumed by
                waiting for a resource such as disk I/O.
                The CPU Cores line at 2 on the y-axis indicates the number of CPUs on the host
                system. When the CPU value reaches the CPU Cores line, the database instance
                is consuming 100 percent of CPU time on the system.
                The last item in the graph title Average Active Sessions by Wait Class is a
                drop-down menu for other dimensions to view the performance. Wait Class is the
                default.
                The main dimensions are:
                •   Wait Class
                •   Wait Event
                •   Instance
                •   Service
                •   Module
                •   Action
                •   User Session
                •   SQL ID
                The Active Sessions Working page shows a 1-hour timeline. Details for each wait
                class are shown in 5-minute intervals.
                You can view the details of wait classes in different dimensions by proceeding to
                one of the following sections:
                •   Monitoring Top Dimensions
                •   Monitoring SQL
                •   Monitoring PL/SQL



                                                                                                   4-2
                                                                                               Chapter 4
                                                                                 Monitoring User Activity


                  •   Monitoring Resource Consumption
                  •   Monitoring Session Identifiers
                  •   Monitoring Session Attributes
             4.   To change the selected time interval, use the Performance Hub view and drag
                  start and end times to a different interval.


Figure 4-2   Average Active Sessions by "Wait Class"




                  The information contained in the Average Active Sessions is automatically
                  updated to display the selected time period.
             If you discover a performance problem, then you can attempt to resolve it in real time.
             On the Performance page, do one of the following:
             •    Below the Average Active Sessions chart, click the snapshot corresponding to the
                  time when the performance problem occurred to run ADDM for this time period.
                  For information about ADDM analysis, see "Reviewing the Automatic Database
                  Diagnostic Monitor Analysis".
             •    Click Run ADDM Now to create a snapshot manually.
                  For information about creating snapshots manually, see "Creating Snapshots".
                  For information about running ADDM manually, see "Manually Running ADDM to
                  Analyze Current Database Performance".
             •    Click Run ASH Report to create an Active Session History (ASH) report to
                  analyze transient, short-lived performance problems.
                  For information about ASH reports, see "Active Session History Reports".



                                                                                                    4-3
                                                                                            Chapter 4
                                                                              Monitoring User Activity




Monitoring Top Dimensions

          The Average Active Sessions by drop-down contains a Top Dimensions fly-out with
          the following common views:
          •    Wait Class
          •    Wait Event
          •    Instance
          •    Service
          •    Module
          •    Action
          •    User Session
          •    SQL ID

          To monitor a Top Dimension:
          1.   Access the Performance Hub page, as explained in "Monitoring User Activity".
          2.   Click on the drop-down in Average Active Sessions by, mouse onto Top
               Dimensions, and select the desired view.
               •   Wait Class
               •   Wait Event
               •   Instance
               •   Service
               •   Module
               •   Action
               •   User Session
               •   SQL ID
               Graphs, tables, and information on the page are updated to reflect the selected
               criteria.


Monitoring SQL

          The Average Active Sessions by drop-down contains a SQL fly-out with the following
          common views:
          •    SQL ID
          •    Top Level SQL ID
          •    SQL Force Matching Signature
          •    SQL Plan Hash Value
          •    SQL Full Plan Hash Value




                                                                                                 4-4
                                                                                            Chapter 4
                                                                              Monitoring User Activity


          •    SQL Plan Operation
          •    SQL Plan Operation Line
          •    SQL Opcode
          •    Top Level SQL Opcode

          To monitor SQL:
          1.   Access the Performance Hub page, as explained in "Monitoring User Activity".
          2.   Click on the drop-down in Average Active Sessions by, mouse onto SQL, and
               select the desired view from the fly-out.
               •       SQL ID
               •       Top Level SQL ID
               •       SQL Force Matching Signature
               •       SQL Plan Hash Value
               •       SQL Full Plan Hash Value
               •       SQL Plan Operation
               •       SQL Plan Operation Line
               •       SQL Opcode
               •       Top Level SQL Opcode
               Graphs, tables, and information on the page are updated to reflect the selected
               criteria.



                   See Also:

                   •     "Viewing Details of SQL Statements"
                   •     "Tuning SQL Statements "
                   •     "Tuning SQL Statements Using SQL Tuning Advisor"



Monitoring PL/SQL

          The Average Active Sessions by drop-down contains a PL/SQL fly-out with the
          following common views:
          •    PL/SQL
          •    Top Level PL/SQL

          To monitor PL/SQL:
          1.   Access the Performance Hub page, as explained in "Monitoring User Activity".
          2.   Click on the drop-down in Average Active Sessions by, mouse onto PL/SQL,
               and select the desired view from the fly-out.




                                                                                                 4-5
                                                                                              Chapter 4
                                                                                Monitoring User Activity


                 •   PL/SQL
                 •   Top Level PL/SQL
                 Graphs, tables, and information on the page are updated to reflect the selected
                 criteria.


Monitoring Resource Consumption

            The Average Active Sessions by drop-down contains a Resource Consumption
            fly-out with the following common views:
            •    Wait Class
            •    Wait Event
            •    Object
            •    Blocking Session
            A session is a logical entity in the database instance memory that represents the state
            of a current user login to the database. A session lasts from the time a user logs in to
            the database until the user disconnects. For example, when a user starts SQL*Plus,
            the user must provide a valid database user name and password to establish a
            session. If a single session is consuming the majority of database activity, then you
            should investigate it.

            To monitor resource consumption:
            1.   Access the Performance Hub page, as explained in "Monitoring User Activity".
            2.   Click on the drop-down in Average Active Sessions by, mouse onto Resource
                 Consumption, and select the desired view from the fly-out.
                 •   Wait Class
                 •   Wait Event
                 •   Object
                 •   Blocking Session
                 Graphs, tables, and information on the page are updated to reflect the selected
                 criteria.


Monitoring Session Identifiers

            The Average Active Sessions by drop-down contains a Sessions Identifiers fly-out
            with the following common views:
            •    Instance
            •    Service
            •    User Session
            •    Parallel Process
            •    User Name




                                                                                                   4-6
                                                                                             Chapter 4
                                                                               Monitoring User Activity


           •    Program
           •    Session Type
           A service is a group of applications with common attributes, service-level thresholds,
           and priorities. For example, the SYS$USERS service is the default service name used
           when a user session is established without explicitly identifying a service name. The
           SYS$BACKGROUND service consists of all database background processes. If a service is
           using the majority of the wait time, then you should investigate it.
           A session is a logical entity in the database instance memory that represents the state
           of a current user login to the database. A session lasts from the time a user logs in to
           the database until the user disconnects. For example, when a user starts SQL*Plus,
           the user must provide a valid database user name and password to establish a
           session. If a single session is consuming the majority of database activity, then you
           should investigate it.

           To monitor session identifiers:
           1.   Access the Performance Hub page, as explained in "Monitoring User Activity".
           2.   Click on the drop-down in Average Active Sessions by, mouse onto Session
                Identifiers, and select the desired view from the fly-out.
                •   Instance
                •   Service
                •   User Session
                •   Parallel Process
                •   User Name
                •   Program
                •   Session Type
                Graphs, tables, and information on the page are updated to reflect the selected
                criteria.


Monitoring Session Attributes
           The Average Active Sessions by drop-down contains a Sessions Attributes fly-out
           with the following common views:
           •    Consumer Group
           •    Module
           •    Action
           •    Client
           •    Client Host Name
           •    Client Host Port
           •    Transaction ID
           •    Execution Context ID
           •    Database Operation




                                                                                                  4-7
                                                                                                Chapter 4
                                                                              Monitoring Instance Activity


           A client can be a web browser or any client process that initiates a request for the
           database to perform an operation. If a single client is using the majority of the wait
           time, then you should investigate it.
           Modules represent the applications that set the service name as part of the workload
           definition. For example, the DBMS_SCHEDULER module may assign jobs that run within
           the SYS$BACKGROUND service. If a single module is using the majority of the wait time,
           then it should be investigated.

           To monitor session attributes:
           1.   Access the Performance Hub page, as explained in "Monitoring User Activity".
           2.   Click on the drop-down in Average Active Sessions by, mouse onto Sessions
                Attributes, and select the desired view from the fly-out.
                •   Consumer Group
                •   Module
                •   Action
                •   Client
                •   Client Host Name
                •   Client Host Port
                •   Transaction ID
                •   Execution Context ID
                •   Database Operation
                Graphs, tables, and information on the page are updated to reflect the selected
                criteria.


Monitoring Instance Activity
           Below the Average Active Sessions chart on the Performance page are other charts
           that you can use to monitor database instance activity. As explained in "Customizing
           the Database Performance page", you can also customize the Performance page so
           that the most useful instance activity charts are displayed by default.
           You can use the instance activity charts to perform the following tasks:
           •    Monitoring Throughput
           •    Monitoring I/O
           •    Monitoring Parallel Execution
           •    Monitoring Services


Monitoring Throughput
           Database throughput measures the amount of work the database performs in a unit
           of time. The Throughput charts show any contention that appears in the Average
           Active Sessions chart.
           Compare the peaks on the Throughput charts with the peaks on the Average Active
           Sessions chart. If the Average Active Sessions chart displays a large number of




                                                                                                     4-8
                                                                                                     Chapter 4
                                                                                   Monitoring Instance Activity


                sessions waiting, indicating internal contention, but throughput is high, then the
                situation may be acceptable. The database is probably also performing efficiently if
                internal contention is low but throughput is high. However, if internal contention is high
                but throughput is low, then consider tuning the database.

                To monitor throughput:
                1.   Access the Database Home page.
                     See "Accessing the Database Home Page" for more information.
                2.   From the Performance menu, select Performance Home.
                     If the Database Login page appears, then log in as a user with administrator
                     privileges. The Performance page appears.
                3.   Click the Throughput tab.
                4.   Select one of the following Instance Throughput Rate options.
                     •   Per Second
                         Two charts appear. One shows the number of logons and transactions per
                         second and the other shows the physical reads and redo size per second.
                         Figure 4-3 shows the Throughput charts with the Instance Throughput Rate of
                         Per Second selected. The bar in the middle of the figure indicates a portion of
                         the charts (from approximately 1:37 to 1:52) that has been removed for space
                         considerations. In Figure 4-3, the most transactions occurred from 1:15 to 1:27
                         p.m. and from 2:08 to 2:12 p.m.
                     •   Per Transaction
                         One chart appears that shows the number of physical reads and redo size per
                         transaction.


Figure 4-3   Monitoring Throughput




Monitoring I/O
                The I/O charts show I/O statistics collected from all database clients. The I/O wait time
                for a database process represents the amount of time that the process could have
                been doing useful work if a pending I/O had completed. Oracle Database captures the




                                                                                                          4-9
                                                                                                 Chapter 4
                                                                               Monitoring Instance Activity


             I/O wait times for all important I/O components in a uniform fashion so that every I/O
             wait by any Oracle process can be derived from the I/O statistics.


             Figure 4-4   Monitoring I/O




             The Latency for Synchronous Single Block Reads chart shows the total perceived I/O
             latency for a block read, which is the time difference between when an I/O request is
             submitted and when the first byte of the transfer arrives. Most systems are performing
             satisfactorily if latency is fewer than 10 milliseconds. This type of I/O request is the
             best indicator of I/O performance for the following reasons:
             •   Write operations may exhibit good performance because of write caches in
                 storage.
             •   Because multiblock I/O requests have varying sizes, they can take different
                 amounts of time.
             •   The latency of asynchronous I/O requests does not represent the full I/O wait time.
             The other charts shown depend on your selection for I/O Breakdown, as described in
             the following sections:
             •   Monitoring I/O by Function
             •   Monitoring I/O by Type
             •   Monitoring I/O by Consumer Group

Monitoring I/O by Function
             The I/O Function charts determine I/O usage level by application or job. The
             component-level statistics give a detailed view of the I/O bandwidth usage, which you
             can then use in scheduling jobs and I/O provisioning. The component-level statistics
             fall in the following categories:
             •   Background type
                 This category includes ARCH, LGWR, and DBWR.



                                                                                                    4-10
                                                                                                     Chapter 4
                                                                                   Monitoring Instance Activity


            •     Activity
                  This category includes XDB, Advanced Queuing (AQ), Data Pump, Recovery, and
                  RMAN.
            •     I/O type
                  The category includes the following:
                  –       Direct Writes
                          This write is made by a foreground process and is not from the buffer cache.
                  –       Direct Reads
                          This read is physical I/O from a data file that bypasses the buffer cache and
                          reads the data block directly into process-private memory.
                  –       Buffer Cache Reads
            •     Others
                  This category includes I/Os such as control file I/Os.

            To monitor I/O by function:
            1.    Access the Performance page, as explained in "Monitoring User Activity".
             2.   In the instance activity chart, click I/O.
                  The Latency for Synchronous Single Block Reads, I/O Megabytes per Second,
                  and I/O Requests per Second charts appear.
            3.    For I/O Breakdown, select I/O Function.
                  The I/O Megabytes per Second by I/O Function and I/O Requests per Second by
                  I/O Function charts appear.
                  The example in Figure 4-4 shows that a significant amount of I/O is being
                  performed by the log writer. The log writer activity peaked at approximately 600
                  I/O requests per second.
            4.    Click the largest colored area on the chart or the corresponding function in the
                  legend to drill down to the function with the highest I/O rate.
                  An I/O Throughput by I/O Function page appears with details about the selected
                  category.
                  You can view real-time or historical data for details on I/O megabytes or I/O
                  requests.



                      See Also:

                      •      Oracle Database Concepts to learn about database background
                             processes such as ARCH, LGWR, and DBWR



Monitoring I/O by Type
            The I/O Type charts enable you to monitor I/O by the types of read and write
            operations. Small I/Os are requests smaller than 128 KB and are typically single
            database block I/O operations. Large I/Os are requests greater than or equal to 128




                                                                                                         4-11
                                                                                     Chapter 4
                                                                  Monitoring Instance Activity


KB. Large I/Os are generated by database operations such as table/index scans,
direct data loads, backups, restores, and archiving.


Figure 4-5     Performance Monitoring I/O by Type




When optimizing for short transaction times, such as in an OLTP environment, monitor
latency for small I/Os. High latencies typically indicate that the storage system is a
bottleneck.
When optimizing for large queries, such as in a data warehouse, performance
depends on the maximum throughput the storage system can achieve rather than
the latency of the I/O requests. In this case, monitor the I/O megabytes per second
rather than the synchronous single-block I/O latencies.

To monitor I/O by type:
1.   Access the Database Home page.
     See "Accessing the Database Home Page" for more information.
2.   From the Performance menu, select Performance Home.
     If the Database Login page appears, then log in as a user with administrator
     privileges. The Performance page appears.
3.   In the instance activity area, click I/O tab.
     The I/O Megabytes per Second and I/O Requests per Second graphs appear.
4.   For I/O Breakdown, select I/O Type.
     The I/O Megabytes per Second by I/O Type and I/O Requests per Second by I/O
     Type charts appear.
5.   Click the largest colored area on the chart or the corresponding function in the
     legend to drill down to the function with the highest I/O rate.
     The I/O Details page appears.
     You can view real-time or historical data for details on I/O megabytes or I/O
     requests.



                                                                                       4-12
                                                                                                Chapter 4
                                                                              Monitoring Instance Activity




Monitoring I/O by Consumer Group
            When Oracle Database Resource Manager is enabled, the database collects I/O
            statistics for all consumer groups that are part of the currently enabled resource plan.
            The Consumer Group charts enable you to monitor I/O by consumer group.
            A resource plan specifies how the resources are to be distributed among various users
            (resource consumer groups). Resource consumer groups enable you to organize
            user sessions by resource requirements. Note that the _ORACLE_BACKGROUND_GROUP_
            consumer group contains I/O requests issued by background processes.




            To monitor I/O requests by consumer group:
            1.   Access the Database Home page.
                 See "Accessing the Database Home Page" for more information.
            2.   From the Performance menu, select Performance Home.
                 If the Database Login page appears, then log in as a user with administrator
                 privileges. The Performance page appears.
            3.   In the instance activity area, click I/O tab.
                 The I/O Megabytes per Second and I/O Requests per Second graphs appear.
            4.   For I/O Breakdown, select Consumer Group.
                 The I/O Megabytes per Second by Consumer Group and I/O Requests per
                 Second by Consumer Group graphs appear.


Monitoring Parallel Execution
            The Parallel Execution charts show system metrics related to parallel queries. Metrics
            are statistical counts per unit. The unit could be a time measure, such as seconds, or
            per transaction, or session.
            A parallel query divides the work of executing a SQL statement across multiple
            processes. The charts show parallel queries that were waiting for a particular wait
            event that accounted for the highest percentages of sampled session activity.




                                                                                                   4-13
                                                                                                  Chapter 4
                                                                                Monitoring Instance Activity


           Figure 4-6    Monitoring Parallel Execution




           To monitor parallel execution:
           1.   Access the Database Home page.
                See "Accessing the Database Home Page" for more information.
           2.   From the Performance menu, select Performance Home.
                If the Database Login page appears, then log in as a user with administrator
                privileges. The Performance page appears.
           3.   In the instance activity chart, click Parallel Execution tab.
                The Parallel Execution charts appear.
                Two pairs of charts are shown. The first pair shows the number of sessions on the
                y-axis, whereas the second pair shows the per second rate on the y-axis.


Monitoring Services
           Services represent groups of applications with common attributes, service-level
           thresholds, and priorities. For example, the SYS$USERS service is the default service
           name used when a user session is established without explicitly identifying a service
           name.

           Figure 4-7    Monitoring Services




           To monitor services:
           1.   Access the Database Home page.
                See "Accessing the Database Home Page" for more information.
           2.   From the Performance menu, select Performance Home.
                If the Database Login page appears, then log in as a user with administrator
                privileges. The Performance page appears.



                                                                                                     4-14
                                                                                              Chapter 4
                                                                                Monitoring Host Activity


          3.   In the instance activity chart, click Services.
               The Services chart appears. The Services chart shows services waiting for the
               corresponding wait event during the time period shown. Only active services are
               shown.
               In Figure 4-7, the SYS$USERS service has the greatest number of active sessions.
          4.   Click the largest colored area on the chart or the corresponding service in the
               legend to drill down to the service with the highest number of active sessions.
               The Service page appears, showing the Activity subpage.
               You can view real-time data showing the session load for all wait classes
               associated with the service.


Monitoring Host Activity
          The Host chart on the Performance page displays utilization information about the
          system hosting the database.
          To determine if the host system has enough resources available to run the database,
          establish appropriate expectations for the amount of CPU, memory, and disk
          resources that your system should be using. You can then verify that the database
          is not consuming too many of these resources.

          To view details about CPU, memory, and disk utilization:
          1.   From the Targets menu, select Hosts.
               The Hosts page appears.
          2.   In the list of hosts, click the name of the host on which your database resides.
               The hostname page appears, where hostname is the name of the host.
          3.   Determine whether sufficient resources are available and whether your system is
               using too many resources.
               For example, determine the amount of CPU, memory, and disk resources the
               database uses in the following scenarios:
               •   When your system is idle, or when little database and nondatabase activity
                   exists
               •   At average workloads
               •   At peak workloads
               Workload is an important factor when evaluating the level of resource utilization
               for your system. During peak workload hours, 90 percent utilization of a resource,
               such as a CPU with 10 percent idle and waiting time, can be acceptable. However,
               if your system shows high utilization at normal workload, then there is no room for
               additional workload.
               Perform the following tasks to monitor the host activity for your database:
               •   Monitoring CPU Utilization
               •   Monitoring Memory Utilization
               •   Monitoring Disk I/O Utilization




                                                                                                  4-15
                                                                                                Chapter 4
                                                                                 Monitoring Host Activity


           4.   Set the appropriate threshold values for the performance metrics so the system
                can automatically generate alerts when these thresholds are exceeded.
                For information about setting metric thresholds, see "Setting Metric Thresholds for
                Performance Alerts".


Monitoring CPU Utilization
           To address CPU problems, first establish appropriate expectations for the amount
           of CPU resources your system should be using. You can then determine whether
           sufficient CPU resources are available and recognize when your system is consuming
           too many resources. This section describes how to monitor CPU utilization.

           To monitor CPU utilization:
           1.   Access the hostname page as explained in "Monitoring Host Activity".
           2.   From the Host drop-down menu, select Monitoring, and then CPU Details.
                The CPU Details page appears.
                This page contains statistics about CPU utilization, I/O wait times, and load
                gathered over the last hour. The top 10 processes are listed based on CPU
                utilization.
           3.   Verify the current CPU utilization using the CPU Utilization chart.
                The CPU Utilization chart shows CPU utilization over the last hour and a half. The
                current value is displayed below the chart. During standard workload hours, the
                value should not exceed the critical threshold.
           4.   Under the graph for CPU Utilization, click the link CPU Utilization.
                This page contains CPU utilization statistics and related alerts generated over the
                last 24 hours.
                If you notice an unexpected spike in this value that is sustained through normal
                workload hours, then the CPU performance problem should be investigated.
           5.   Return to the CPU Details page. From the Host menu, select Monitoring, and
                then CPU Details.
           6.   Verify the current CPU I/O wait time using the CPU I/O Wait chart.
                The CPU I/O Wait chart shows CPU I/O wait time over the last hour and a half.
                The current value is displayed below the chart. During normal workload hours, the
                value of CPU I/O wait should not exceed the warning threshold.
                CPU I/O wait represents the average number of jobs waiting for I/O during an
                interval.
           7.   Under the graph for CPU I/O Wait, click the link CPU I/O Wait.
                The CPU in I/O Wait page appears.
                This page contains CPU I/O wait statistics and related alerts generated over the
                last 24 hours.
                If you notice an unexpected increase in this value that is sustained through
                standard workload hours, then a CPU performance problem may exist.
           8.   Return to the CPU Details page. From the Host menu, select Monitoring, and
                then CPU Details.




                                                                                                  4-16
                                                                                                Chapter 4
                                                                                  Monitoring Host Activity


           9.   Verify the current CPU load using the CPU Load chart.
                The CPU Load chart shows the CPU load over the last hour and a half. The
                current value is displayed below the chart. During standard workload hours, the
                value of CPU load should not exceed the warning threshold.
                CPU load represents the average number of processes waiting to be scheduled
                for CPU resources in the previous minute, or the level of CPU contention time over
                time.
           10. Under the graph for CPU Load, click the link CPU Load.

                The Run Queue Length (5 minute average) page appears.
                This page contains CPU load statistics and related alerts generated over the last
                24 hours.
                If you notice an unexpected spike in this value that is sustained through normal
                workload hours, then a CPU performance problem might exist.
           11. Return to the CPU Details page. From the Host menu, select Monitoring, and
                then CPU Details.
           12. Review the Top 10 Processes (ordered by CPU) table.

                If a process is consuming too much of the CPU utilization percentage, then
                investigate that process.
           13. If a CPU performance problem is identified, then you can try to resolve the issue
                by doing the following:
                •       Use Oracle Database Resource Manager to reduce the impact of peak-load-
                        use patterns by prioritizing CPU resource allocation
                •       Avoid running too many processes that use a large amount of CPU
                •       Increase hardware capacity, including changing the system architecture



                    See Also:

                    •      Oracle Database Performance Tuning Guide for information about
                           resolving CPU issues
                    •      Oracle Database Administrator's Guide for information about Oracle
                           Database Resource Manager



Monitoring Memory Utilization
           Operating system performance issues commonly involve process management,
           memory management, and scheduling. This section describes how to monitor memory
           utilization and identify problems such as paging and swapping.

           To monitor memory utilization:
           1.   Access the hostname page as explained in "Monitoring Host Activity".
           2.   From the Host drop-down menu, select Monitoring, and then Memory Details.
                The Memory Details page appears.




                                                                                                   4-17
                                                                                                  Chapter 4
                                                                                    Monitoring Host Activity


                  This page contains statistics about memory utilization, page scan rates, and swap
                  utilization gathered over the last hour. The top 10 processes are also listed
                  ordered by memory utilization. Figure 4-8 shows a portion of the Memory Details
                  page. The Top 10 Processes (ordered by Memory) section is not shown.


Figure 4-8   Memory Details Page




             3.   Verify the current memory page scan rate using the Memory Page Scan Rate
                  chart.
                  The current value of the memory page scan rate is displayed below the chart. On
                  UNIX and Linux, this value represents the number of pages scanned per second.
                  On Microsoft Windows, this value represents the rate at which pages are read
                  from or written to disk to resolve hard page faults. This value is a primary indicator
                  of the types of faults that may be causing system-wide delays.
             4.   Click Memory Scan Rate (pages per second).
                  The Memory Page Scan Rate page appears.
                  This page contains memory page scan rate statistics and related alerts over the
                  last 24 hours.
                  If you notice an unexpected increase in this value that is sustained through
                  standard workload hours, then a memory performance problem might exist.
             5.   Return to the Memory Details page. From the Host drop-down menu, select
                  Monitoring, and then Memory Details.
             6.   Using the Memory Utilization chart, verify the current memory utilization.
                  The Memory Utilization chart shows how much memory is being used. The current
                  value of memory utilization is displayed below the chart. During standard workload
                  hours, the value should not exceed the warning threshold (shown in yellow).
             7.   Click Memory Utilization (%).
                  The Memory Utilization page appears.
                  This page contains memory utilization statistics and related alerts generated over
                  the last 24 hours.




                                                                                                     4-18
                                                                                        Chapter 4
                                                                          Monitoring Host Activity




     In this example, memory utilization has exceeded 80%, so warnings appear in the
     Metric Alert History table.
     If you notice an unexpected spike in this value that is sustained through normal
     workload hours, then a memory performance problem might exist.
8.   Return to the Memory Details page. From the Host drop-down menu, select
     Monitoring, and then Memory Details.
9.   Using the Swap Utilization chart, verify current swap utilization.
     The Swap Utilization chart shows how much swap space is being used. The
     current value of swap utilization is displayed below the chart. During normal
     workload hours, the value should not exceed the warning threshold.
10. Click Swap Utilization (%).

     The Swap Utilization page appears.
     This page contains swap utilization statistics and related alerts generated over the
     last 24 hours.
     If you notice an unexpected spike in this value that is sustained through normal
     workload hours, then a memory performance problem might exist.
11. Return to the Memory Details page. From the Host drop-down menu, select
     Monitoring, and then Memory Details.
12. Review the top processes in the Top 10 Processes (ordered by Memory) table.

     If a process is taking up too much memory, then this process should be
     investigated.
13. If a memory performance problem is identified, then you can attempt to resolve the
     issue by doing the following:




                                                                                           4-19
                                                                                                 Chapter 4
                                                                                   Monitoring Host Activity


                 •       Use Automatic Memory Management to automatically manage and distribute
                         memory between the System Global Area (SGA) and the aggregate program
                         global area (PGA aggregate).
                 •       Use the Memory Advisor to set SGA and PGA memory target values.
                 •       Use Automatic PGA Management to manage SQL memory execution.
                 •       Avoid running too many processes that consume large amounts of memory.
                 •       Reduce paging or swapping.
                 •       Reduce the number of open cursors and hard parsing with cursor sharing.



                     See Also:

                     •     Oracle Database Administrator's Guide for information about using
                           Automatic Memory Management
                     •     Oracle Database Performance Tuning Guide for information about
                           resolving memory issues



Monitoring Disk I/O Utilization
            Because the database resides on a set of disks, the performance of the I/O subsystem
            is very important to database performance. Important disk statistics include the disk
            I/Os per second and the length of the service times. These statistics show if the disk
            is performing optimally or if the storage system is being overworked. This section
            describes how to monitor disk I/O utilization.

            To monitor disk I/O utilization:
            1.   Access the hostname page as explained in "Monitoring Host Activity".
            2.   From the Host drop-down menu, select Monitoring, and then Disk Details.
                 The Disk Details page appears.
                 This page contains disk I/O utilization and service time statistics, and the top disk
                 devices ordered by the percentage of time that they were in use.




                                                                                                    4-20
                                                                                     Chapter 4
                                                                       Monitoring Host Activity


     Figure 4-9   Disk Details




3.   Verify the current disk I/O utilization using the Total Disk I/O Made Across All Disks
     chart.
     The Total Disk I/O Made Across All Disks chart shows how many disk I/Os are
     being performed per second. The current value for total disk I/O per second is
     displayed below the chart. In Figure 4-9 the value is 153.07.
4.   Click Total Disk I/O made across all disks (per second).
     The Total Disk I/O Made Across All Disks (Per Second) page appears.
     This page contains disk utilization statistics and related alerts generated over the
     last 24 hours.
     If you notice an unexpected spike in this value that is sustained through standard
     workload hours, then a disk I/O performance problem might exist and should be
     investigated.
5.   Verify the current I/O service time using the Max Average Disk I/O Service Time
     (ms) Among All Disks chart.
     The Max Average Disk I/O Service Time (ms) Among All Disks chart shows the
     longest service time for disk I/Os in milliseconds. The current value for longest I/O
     service time is displayed below the chart. In Figure 4-9 the value is 1.79.
6.   Return to the Disk Details page. From the Host drop-down menu, select
     Monitoring, and then Disk Details.
7.   Click Max Average Disk I/O (ms) Service Time Among All Disks.
     This page contains I/O service time statistics and related alerts generated over the
     last 24 hours.
     If you notice an unexpected spike in this value that is sustained through normal
     workload hours, then a disk I/O performance problem might exist and should be
     investigated.
8.   Return to the Disk Details page. From the Host drop-down menu, select
     Monitoring, and then Disk Details.




                                                                                        4-21
                                                                                                     Chapter 4
                                                          Determining the Cause of Spikes in Database Activity


         9.   On the Disk Details page, verify the disk devices in the Top Disk Devices
              (ordered by % Busy) table.
              If a particular disk is busy a high percentage of the time, then this disk should be
              investigated.
         10. If a disk I/O performance problem is identified, you can attempt to resolve the
              problem by doing the following:
              •       Use Oracle Automatic Storage Management (Oracle ASM) to manage
                      database storage.
              •       Stripe everything across every disk to distribute I/O.
              •       Move files such as archived redo logs and online redo logs to separate disks.
              •       Store required data in memory to reduce the number of physical I/Os.



                  See Also:

                  •      Oracle Database Performance Tuning Guide for information about
                         resolving disk I/O issues



Determining the Cause of Spikes in Database Activity
         If you see a spike in database activity in the Performance page, then you can access
         the ASH Analytics page to find out which sessions are consuming the most database
         time. This page provides stacked area charts to help you visualize the active session
         activity from various dimensions, such as Wait Class, Module, Actions, SQL ID,
         Instance, User Session, Consumer Group, and others. You can drill down into specific
         members of a dimension (vertical zooming), and zoom in and out of any time period
         (horizontal zooming).

         To view active session activity on the ASH Analytics page:
         1.   Access the Database Home page.
              See "Accessing the Database Home Page" for more information.
         2.   From the Performance menu, select Performance Hub and then ASH Analytics.
              If the Database Login page appears, then log in as a user with administrator
              privileges. The ASH Analytics page appears.
              Figure 4-10 shows an example of the ASH Analytics page.




                                                                                                        4-22
                                                                                                       Chapter 4
                                                            Determining the Cause of Spikes in Database Activity


Figure 4-10    ASH Analytics Page




              3.   To view a high-level perspective of top activity during a selected time period, drag
                   the entire shaded slider area in the top chart to the desired time period.


                           Tip:
                           You can change the amount of time selected in the shaded slider area by
                           selecting the control at either edge of the slider and dragging it to the left
                           or right.
                           You can select a time period within the default setting of one hour or you
                           can use the selector buttons above the chart to display time periods of
                           one day, one week, or one month. You can also use the Calendar and
                           Custom buttons to display a time period other than one of the preset
                           choices.


              4.   To view a more detailed perspective of your selected time period, use the Activity
                   chart on the page. By default, the chart shows a breakdown of workload activity by
                   wait classes.
              5.   Investigate the impact by viewing detailed statistics for the top activity sessions
                   that are adversely affecting the system.
                   To view detailed statistics for a session:
                   a.   Select the largest spike in the chart or the corresponding wait class in the
                        legend beside the chart. The viewer now filters out everything in the chart
                        except for the wait class of interest.




                                                                                                          4-23
                                                                                        Chapter 4
                                             Determining the Cause of Spikes in Database Activity


          For example, if the chart shows that the Concurrency wait class has the
          biggest spike, select the chart area of the legend for Concurrency. The viewer
          refreshes the chart and now only shows the Concurrency value and displays a
          Wait Class: Concurrency icon in the Filters bar.


                 Tip:
                 You can create an unlimited number of filters.


     b.   In the Activity section, select Top Dimensions from the dimensions list.
          The chart refreshes in response to your selection, displaying values for the
          particular category you selected.
          For instance, if you create a filter for Concurrency as described above, then
          select Top Dimensions from the list, and then select User Session, the chart
          shows user sessions only for Concurrency.
          Figure 4-11 shows the list of activities with Top Dimensions selected.


          Figure 4-11   List of Activities




6.   Optionally, use the Load Map for a graphical view of system activity.
     The Load Map is useful for viewing activity in a single- or multi-dimensional layout
     when you are not interested in seeing how activity has changed over time during
     the selected period.
     Figure 4-12 shows the load map for activity by wait class and wait events.




                                                                                           4-24
                                                                                              Chapter 4
                                                   Determining the Cause of Spikes in Database Activity


Figure 4-12   Load Map on the ASH Analytics Page




                                                                                                 4-25
5
Monitoring Real-Time Database Operations
          This chapter describes how to monitor current and recent database operations in
          Oracle Enterprise Manager Cloud Control (Cloud Control). This chapter contains the
          following topics:
          •   About Monitoring Database Operations
          •   Creating a Database Operation
          •   Monitoring Database Operations in Cloud Control



                 See Also:

                 •   Oracle Database SQL Tuning Guide for information on monitoring
                     database operations using an API



About Monitoring Database Operations
          The SQL Monitoring pages in Cloud Control display information that you can use
          to monitor the performance of database operations while they are executing, view
          details about the time and resources used for recently completed operations, and
          track and report on database operations. A database operation is a set of database
          tasks defined by end users or application code such as a SQL statement or PL/SQL
          function, a batch job, or extract, transform, and load (ETL) processing. You can define,
          monitor, and report on database operations.
          This section contains the following topics:
          •   Types of Database Operations
          •   Purposes of Monitoring Database Operations
          •   Enabling Monitoring of Database Operations
          •   Attributes of Database Operations



                 See Also:

                 •   Oracle Database SQL Tuning Guide for more information about
                     monitoring database operations



Types of Database Operations
          Database operations are either simple or composite. A simple database operation
          is a single SQL statement or PL/SQL procedure or function. Monitoring of a simple



                                                                                              5-1
                                                                                              Chapter 5
                                                                   About Monitoring Database Operations


           operation starts automatically when a SQL statement runs in parallel, or when it has
           consumed at least 5 seconds of CPU or I/O time in a single execution.
           A composite database operation is activity between two defined points in time in
           a database session. You begin and end a composite operation by using PL/SQL
           procedures, as shown in "Creating a Database Operation". Only one composite
           database operation at a time can run in a database session.


Purposes of Monitoring Database Operations
           In general, database operation monitoring is useful for the following users:
           •   DBAs whose responsibilities include identifying expensive (high response time)
               SQL statements and PL/SQL functions
           •   DBAs who manage batch jobs in a data warehouse or OLTP system
           •   Application or database developers who need to monitor the activities related to
               particular operations, for example, Data Pump operations
           Monitoring database operations is useful for performing the following tasks:
           •   Tracking and reporting
               Tracking requires first defining a composite database operation. When the
               operation begins, the database infrastructure determines what to track on behalf of
               the operation. For example, your tuning task may involve determining which SQL
               statements run on behalf of a specific batch job, what their execution statistics
               were, what was occurring in the database when the operation was executing, and
               so on. In Cloud Control, you can view the reports for the composite database
               operation and for the simple database operations that comprise the composite
               database operation. You can save the reports to disk.
           •   Monitoring execution progress
               This task involves monitoring a currently executing database operation. The
               information is particularly useful when you are investigating why an operation is
               taking a long time to complete.
           •   Monitoring resource usage
               You may want to detect when a SQL execution uses excessive CPU, issues
               an excessive amount of I/O, or takes a long time to complete. With the Oracle
               Database Resource Manager (Resource Manager), you can configure thresholds
               for each consumer group that specify the maximum resource usage for all SQL
               executions in the group. When a SQL operation reaches a specified threshold,
               Resource Manager can switch the operation into a lower-priority consumer group,
               terminate the session, or cancel and quarantine the SQL operation. In Cloud
               Control, you can examine these SQL operations.



                      See Also:
                      Oracle Database Administrator's Guide for more information about
                      consumer group switching by setting resource limits using the Resource
                      Manager


           •   Tuning for response time




                                                                                                  5-2
                                                                                              Chapter 5
                                                                          Creating a Database Operation


               When tuning a database operation, you typically want to improve the response
               time. Often the database operation performance issues are mainly SQL
               performance issues.


Enabling Monitoring of Database Operations
           Real-time database operations monitoring is enabled by default when the
           STATISTICS_LEVEL initialization parameter is either set to TYPICAL (the default value) or
           ALL. Because database operations monitoring is a feature of the Oracle Tuning Pack,
           the CONTROL_MANAGEMENT_PACK_ACCESS parameter must be set to DIAGNOSTIC+TUNING
           (the default value).



                  See Also:
                  Oracle Database SQL Tuning Guide for more information about how to
                  disable real-time database operations monitoring



Attributes of Database Operations
           A database operation has attributes that uniquely identify it. These attributes are the
           following:
           •   Database operation name
               This is a user-created name such as daily_sales_report. For an example of
               naming a database operation, see "Creating a Database Operation".
           •   Database operation execution ID
               Two or more occurrences of the same database operation can run at the same
               time, each in a different database session, with the same name but with different
               execution IDs. This numeric ID uniquely identifies different executions of the same
               database operation.
               The database automatically creates an execution ID when you begin a database
               operation. You can also specify your own execution ID.


Creating a Database Operation
           You can create a composite database operation using the DBMS_SQL_MONITOR package
           subprograms.
           The following example creates a database operation named DBOP_EXAMPLE. The
           example begins the database operation. It has a PL/SQL procedure that selects
           the maximum sales amount by customer by city. It then has a SQL statement that
           selects the maximum sales amount of all customers from cities that have at least two
           customers. Finally, it ends the database operation.
           Example 5-1     Creating a Database Operation
           VAR eid NUMBER
           EXEC :eid := DBMS_SQL_MONITOR.BEGIN_OPERATION('DBOP_EXAMPLE');
           declare
           --




                                                                                                  5-3
                                                                                Chapter 5
                                                            Creating a Database Operation


v1 number;
--
CURSOR c1 IS
SELECT cust_city
   FROM (SELECT COUNT(*) cnt, cust_city
         FROM sh.customers GROUP BY cust_city
         ORDER BY 1 desc);
--
BEGIN
FOR i IN c1
LOOP
--
v1 := 0;
--
SELECT MAX(amount_sold)
INTO v1
FROM sh.sales
WHERE cust_id IN (select cust_id FROM sh.customers WHERE cust_city=i.cust_city);
--
DBMS_OUTPUT.PUT_LINE('Amount: '||v1);
--
END LOOP;
--
END;
/
SELECT MAX(asld) FROM
(SELECT MAX(amount_sold) asld, cust_id FROM sh.sales WHERE cust_id IN
   (SELECT cust_id FROM sh.customers WHERE cust_city IN
     (SELECT cust_city FROM
      (SELECT count(*) cnt, cust_city FROM sh.customers
       GROUP BY cust_city HAVING COUNT(*) > 1)
     ))
GROUP BY cust_id)
/

EXEC DBMS_SQL_MONITOR.END_OPERATION('DBOP_EXAMPLE',:eid);



      Note:
      Starting with Oracle Database 19c, database users without the administrative
      privileges can also create composite database operations using the
      DBMS_SQL_MONITOR package subprograms and view the SQL execution
      details of those operations, including the execution plans and performance
      metrics, by navigating to the Monitored SQL Executions page of Cloud
      Control.




      See Also:

      •   Oracle Database SQL Tuning Guide for information on monitoring
          database operations using an API
      •   Oracle Database PL/SQL Packages and Types Reference for
          information on the DBMS_SQL_MONITOR package




                                                                                    5-4
                                                                                                 Chapter 5
                                                           Monitoring Database Operations in Cloud Control




Monitoring Database Operations in Cloud Control
           The Monitored SQL Executions page of Cloud Control displays a table of database
           operations that are currently running or have completed.
           With a selection from the Top 100 By list, you can order the rows of the table by
           aspects of the operations such as Last Active Time, Duration, or CPU Time. With a
           selection from the Type list, you can show all of the operations or filter the rows to
           show only the SQL, PL/SQL, or database operations.
           The table contains data about the operations, such as the status and type of the
           operation, the operation ID, the database time consumed, the SQL text, if appropriate,
           and so on. The values in some columns are links to other pages or display information
           when the cursor points to them. For example, the value in the ID column is a link to
           the Monitored SQL Execution Details page. Another example is that when the cursor
           points to the bar in the Database Time column, a context message appears that
           displays information such as the wait class, the amount of time, and the percentage of
           database time. For example, pointing to the bar in the Database Time column displays
           a message such as CPU: 2.8m (92%). The Execution Detail, SQL Detail, and Session
           Detail controls above the table become active when you select a row from the table.



                  Note:
                  Starting with Oracle Database 19c, database users without the administrative
                  privileges can also view the execution plans and performance metrics of their
                  SQL statements by navigating to the Monitored SQL Executions page of
                  Cloud Control.



           This section contains the following topics:
           •    Viewing SQL Execution Details for a Composite Database Operation
           •    Viewing SQL Execution Details for a SQL Statement
           •    Viewing SQL Execution Details for a PL/SQL Statement



                  See Also:

                  •   Cloud Control Online Help for descriptions of the elements on the
                      Monitored SQL Executions Details page



Viewing SQL Execution Details for a Composite Database Operation
           This topic describes how to view the execution details for a composite database
           operation.

           To view execution details for a composite database operation:
           1.   Access the Database Home page.




                                                                                                     5-5
                                                                                                   Chapter 5
                                                             Monitoring Database Operations in Cloud Control


                  See "Accessing the Database Home Page" for more information.
             2.   From the Performance menu, select Performance Hub and then SQL
                  Monitoring.
                  If the Database Login page appears, then log in as a user with administrator
                  privileges. The Monitored SQL Execution page appears.

Figure 5-1   Monitored SQL Executions Page




             3.   Click the ID of a composite database operation in the table.
                  The Monitored SQL Execution Details page for the operation appears. In the
                  Details section, the Activity subpage is selected by default. Selecting an area
                  in the Activity chart or selecting the corresponding SQL ID value in the legend
                  displays the SQL Details page for that statement.




                                                                                                       5-6
                                                                                                 Chapter 5
                                                           Monitoring Database Operations in Cloud Control


           4.   To view metrics of the operation, click the Metrics tab.




Viewing SQL Execution Details for a SQL Statement
           This topic describes how to view the execution details for a SQL statement.

           To view execution details for a SQL statement:
           1.   Access the Database Home page.
                See "Accessing the Database Home Page" for more information.
           2.   From the Performance menu, select Performance Hub and then SQL
                Monitoring.
                If the Database Login page appears, then log in as a user with administrator
                privileges. The Monitored SQL Execution page appears.
           3.   Click the ID of a SQL statement in the table.
                The Monitored SQL Execution Details page for the operation appears. In the
                Details section, the Plan Statistics subpage is selected by default.


Viewing SQL Execution Details for a PL/SQL Statement
           This topic describes viewing the execution details for a PL/SQL statement.

           To view execution details for a PL/SQL statement:
           1.   Access the Database Home page.
                See "Accessing the Database Home Page" for more information.
           2.   From the Performance menu, select Performance Hub and then SQL
                Monitoring.
                If the Database Login page appears, then log in as a user with administrator
                privileges. The Monitored SQL Execution page appears.




                                                                                                     5-7
                                                                                     Chapter 5
                                               Monitoring Database Operations in Cloud Control


3.   Click the ID of a PL/SQL statement in the table.
     The Monitored SQL Execution Details page for the operation appears. In the
     Details section, the Activity subpage is selected by default.




                                                                                         5-8
6
Monitoring Performance Alerts
          Oracle Database includes a built-in alerts infrastructure to notify you of impending
          problems with the database. Alerts are a type of event and events comprise incidents.
          A problem is a special type of incident.
          By default, Oracle Database enables some alerts, including the following:
          •   Archive Area Used
          •   Current Open Cursors Count
          •   Recovery Area Free Space
          •   Tablespace Space Used
          In addition to these default alerts, you can set metric thresholds so that Oracle
          Database generates alerts to notify you about the database performance conditions
          that you specify.
          This chapter contains the following sections:
          •   Setting Metric Thresholds for Performance Alerts
          •   Responding to Alerts
          •   Clearing Alerts



                 See Also:

                 •   Oracle Database Administrator's Guide for information about incidents
                     and how to monitor and manage them



Setting Metric Thresholds for Performance Alerts
          A metric is the rate of change in a cumulative statistic. This rate can be measured
          against a variety of units, including time, transactions, or database calls. For example,
          the number of database calls per second is a metric. You can set thresholds on a
          metric so that an alert is generated when the threshold is passed.
          Performance alerts are based on metrics that are performance-related. These alerts
          are either environment-dependent or application-dependent.
          Environment-dependent performance alerts may not be relevant on all systems. For
          example, the AVERAGE_FILE_READ_TIME metric generates an alert when the average
          time to read a file exceeds the metric threshold. This alert may be useful on a system
          with only one disk. On a system with multiple disks, however, the alert may not be
          relevant because I/O processing is spread across the entire subsystem.
          Application-dependent performance alerts are typically relevant on all systems. For
          example, the BLOCKED_USERS metric generates a performance alert when the number



                                                                                                6-1
                                                                                           Chapter 6
                                                                                Responding to Alerts


         of users blocked by a particular session exceeds the metric threshold. This alert is
         relevant regardless of how the environment is configured.
         To obtain the most relevant information from performance alerts, set the threshold
         values of performance metrics to values that represent desirable boundaries for your
         system. You can then fine-tune these values over time until your system meets or
         exceeds your performance goals.

         To set thresholds for performance metrics:
         1.   Access the Database Home page.
              See "Accessing the Database Home Page" for more information.
         2.   From the Oracle Database menu, select Monitoring, and then Metric and
              Collection Settings.
              If the Database Login page appears, then log in as a user with administrator
              privileges. The Metric Settings page appears.
         3.   For each performance metric relevant for your system, click the Edit icon.
              The Edit Advanced Settings page appears.
         4.   Follow the steps of the wizard to set the threshold value.



                 See Also:

                 •    "Setting Metric Thresholds for Baselines"



Responding to Alerts
         When an alert is generated by Oracle Database, it appears in the Incidents and
         Problems section of the Database Home page.
         Figure 6-1 shows the Incidents and Problems section of the Database Home page.
         The section is below the SQL Monitor - Last Hour section in the default layout of the
         page.


         Figure 6-1     Incidents and Problems Section of the Database Home Page




         Oracle Enterprise Manager Cloud Control (Cloud Control) enables you to configure
         alerts to be sent by email, pager, or text messaging.




                                                                                                6-2
                                                                                                  Chapter 6
                                                                                             Clearing Alerts




               To respond to an alert:
               1.   Access the Database Home page.
                    See "Accessing the Database Home Page" for more information.
               2.   In the table in the Incidents and Problems section, find the alert that you want to
                    investigate and click the link in the Summary column.
                    If the Database Login page appears, then log in as a user with administrator
                    privileges. An Incident Manager page appears that contains further information
                    about the alert. For example, clicking the value in the first row of the Summary
                    column in Figure 6-1 causes the Incident Manager Problem Details page shown in
                    Figure 6-2 to appear. The General sub-page is selected.


  Figure 6-2   Incident Manager Problem Details Page




               3.   Do one or more of the following:
                    •   Click the other tabs to see information on the subpages.
                    •   Perform one or more of the actions in the Tracking section on the General
                        subpage.
                    •   In the Guided Resolution section, view diagnostic information by clicking
                        Support Workbench: Problem Details. To package and upload diagnostic
                        data to Oracle Support, click Support Workbench: Package Diagnostic.
                    •   Run Automatic Database Diagnostic Monitor (ADDM) or another advisor to get
                        more detailed diagnostics of the system or object behavior.


Clearing Alerts
               Most alerts, such as the CPU Utilization alert, are cleared automatically when the
               cause of the problem disappears. However, other alerts, such as the Generic Alert Log
               Error or Generic Incident alert, must be acknowledged.
               After taking the necessary corrective measures, you can clear an alert.



                                                                                                       6-3
                                                                                Chapter 6
                                                                           Clearing Alerts




To clear alerts:
1.   Access the Database Home page.
     See "Accessing the Database Home Page" for more information.
2.   In the Incidents and Problems section, click the link in the Summary column of the
     table. See Figure 6-1 for a screenshot of the section.
     The Incident Manager Problem Details page appears. If the incident or problem
     can be manually cleared, the Clear button appears in the Tracking section.
     What happens if the Clear button does not appear. How is the problem cleared?
3.   In the Tracking section, click Clear.




                                                                                     6-4
Part III
Reactive Database Tuning
       Part III describes how to tune Oracle Database in response to a reported problem,
       such as when the user reports a performance problem with the database that must be
       tuned immediately.
       This part contains the following chapters:
       •   Manual Database Performance Monitoring
       •   Resolving Transient Performance Problems
       •   Resolving Performance Degradation Over Time
7
Manual Database Performance Monitoring
         You can run the Automatic Database Diagnostic Monitor (ADDM) manually to
         monitor current and historical database performance. Typically, you use the automatic
         diagnostic feature of ADDM to identify performance problems with the database. As
         described in Automatic Database Performance Monitoring, ADDM runs once every
         hour by default. You can configure ADDM to run at a different time interval. However,
         in some cases you may want to run ADDM manually.
         You can run ADDM manually to analyze a time period that is longer than one ADDM
         analysis period. For example, you may want to analyze database performance in a
         workday by analyzing 8 consecutive hours. You could analyze each of the individual
         ADDM periods within the workday, but this approach may become complicated if
         performance problems appear in only some ADDM periods. Alternatively, you can
         run ADDM manually with a pair of Automatic Workload Repository (AWR) snapshots
         that encompass the 8-hour period. In this case, ADDM identifies the most critical
         performance problems in the entire time period.
         This chapter contains the following sections:
         •    Manually Running ADDM to Analyze Current Database Performance
         •    Manually Running ADDM to Analyze Historical Database Performance
         •    Accessing Previous ADDM Results


Manually Running ADDM to Analyze Current Database
Performance
         By default, ADDM runs every hour to analyze snapshots taken by AWR during this
         period. In some cases you may notice performance degradation that did not exist in
         the previous ADDM analysis period, or a sudden spike in database activity on the
         Performance page, as described in Monitoring Real-Time Database Performance . If
         the next ADDM analysis is not scheduled to run for 30 minutes, then you can run
         ADDM manually to identify and resolve the performance problem.
         When you run ADDM manually, a manual AWR snapshot is created automatically. This
         manual run may affect the ADDM run cycle. For example, if you scheduled ADDM to
         run hourly at the start of each hour and the last ADDM run was at 8:00 p.m., running
         ADDM manually at 8:30 p.m. causes the next scheduled run to start at 9:30 p.m., not
         9:00 p.m. Subsequent ADDM runs continue on the new run cycle, occurring hourly at
         the half-hour instead of the start of each hour.

         To analyze current database performance by manually running ADDM:
         1.   Access the Database Home page.
              See "Accessing the Database Home Page" for more information.
         2.   From the Performance menu, select Advisors Home.




                                                                                           7-1
                                                                                    Chapter 7
                               Manually Running ADDM to Analyze Current Database Performance


     If the Database Login page appears, then log in as a user with administrator
     privileges. The Advisor Central page appears.
3.   Under Advisors, select ADDM. The Run ADDM page appears.




     In this example, the average active sessions with wait events rose at 10:00 a.m.,
     peaking at 10:50 a.m. The number dipped at 11:00 a.m. and then started to rise
     again at 11:10 a.m.
4.   Select Run ADDM to analyze current performance and click OK.
     The Confirmation page appears.
5.   Click Yes.
     The Processing: Run ADDM Now page appears while the database takes a new
     AWR snapshot.
     An ADDM run occurs for the time period between the new and the previous
     snapshot. After ADDM completes the analysis, the Automatic Database Diagnostic
     Monitor (ADDM) page appears with the results.




                                                                                        7-2
                                                                                              Chapter 7
                                       Manually Running ADDM to Analyze Historical Database Performance




         6.   Click View Report.
              The View Report page appears.
         7.   Optionally, click Save to File to save the results of the ADDM task in a report for
              later access.



                 See Also:

                 •   "Reviewing the Automatic Database Diagnostic Monitor Analysis"



Manually Running ADDM to Analyze Historical Database
Performance
         You can run ADDM manually to analyze historical database performance by selecting
         a pair or range of AWR snapshots as the analysis period. This technique is useful
         when you have identified a previous time period when database performance was
         poor.
         In the Performance page, you can monitor historical performance by selecting
         Historical from the View Data list. In the Historical view, you can monitor database
         performance in the past, up to the duration defined by the AWR retention period. If
         you notice performance degradation, then you can drill down from the Performance
         page to identify historical performance problems with the database, as described in
         Monitoring Real-Time Database Performance . If you identify a problem, then you can
         run ADDM manually to analyze a particular time period.

         To analyze historical database performance by manually running ADDM:
         1.   Access the Database Home page.
              See "Accessing the Database Home Page" for more information.




                                                                                                   7-3
                                                                                      Chapter 7
                               Manually Running ADDM to Analyze Historical Database Performance


2.   From the Performance menu, select Advisors Home.
     If the Database Login page appears, then log in as a user with administrator
     privileges. The Advisor Central page appears.
3.   Under Advisors, select ADDM. The Run ADDM page appears.
4.   Select Run ADDM to analyze past performance.
5.   Specify a time period for analysis by selecting a pair of AWR snapshots. Complete
     the following steps:
     a.   Select Period Start Time.
     b.   Below the chart for the starting snapshot, click the snapshot you want to use
          for the start time.
          A play icon (displayed as an arrow) appears over the snapshot icon.
          In this example, database activity peaked from 10 a.m. to 11 a.m., so the
          snapshot taken at 10 a.m. is selected for the start time.
     c.   Select Period End Time.
     d.   Below the chart for the ending snapshot, click the snapshot you want to use
          for the end time.
          A stop icon (displayed as a square) appears over the snapshot icon.
          In this example, the ending snapshot is at 11:00 a.m.




6.   Click OK.
     After ADDM completes the analysis, the Automatic Database Diagnostic Monitor
     (ADDM) page appears with the results of the ADDM run.




                                                                                           7-4
                                                                                               Chapter 7
                                                                        Accessing Previous ADDM Results


              Figure 7-1        Analyzing Historical Database Performance




         7.   Click View Report.
              The View Report page appears.
         8.   Optionally, click Save to File.



                   See Also:

                   •      "Reviewing the Automatic Database Diagnostic Monitor Analysis"



Accessing Previous ADDM Results
         If you ran ADDM manually to analyze current or historical database performance, the
         results are displayed on the Automatic Database Diagnostic Monitor (ADDM) page
         after the ADDM run has completed.
         You can access the ADDM results at a later time, or access the ADDM results from
         previous run cycles.

         To access the ADDM results:
         1.   Access the Database Home page.
              See "Accessing the Database Home Page" for more information.
         2.   From the Performance menu, select Advisors Home.
              If the Database Login page appears, then log in as a user with administrator
              privileges. The Advisor Central page appears.
         3.   Complete the following steps:
              a.       Under Advisor Tasks, select ADDM from the Advisory Type list.
              b.       Select the appropriate search criteria.
                       For example, you can select All in the Advisor Runs list to view all ADDM
                       tasks.
              c.       Click Go.




                                                                                                   7-5
                                                                               Chapter 7
                                                        Accessing Previous ADDM Results




     The ADDM tasks are displayed under Results.
4.   To view an ADDM result, select the desired ADDM task and click View Result.
     The results from the selected ADDM task are shown in the Automatic Database
     Diagnostic Monitor (ADDM) page.



           See Also:

           •   "Reviewing the Automatic Database Diagnostic Monitor Analysis"




                                                                                   7-6
8
Resolving Transient Performance
Problems
         Transient performance problems are short-lived and typically do not appear in the
         Automatic Database Diagnostic Monitor (ADDM) analysis. ADDM tries to report the
         most significant performance problems during an analysis period in terms of their
         effect on database time (DB time). If a problem lasts for a brief time, then its
         severity might be averaged out or minimized by other performance problems in
         the entire analysis period. Therefore, the problem may not appear in the ADDM
         findings. Whether or not a performance problem is captured by ADDM depends on its
         duration compared to the interval between the Automatic Workload Repository (AWR)
         snapshots.
         If a performance problem lasts for a significant portion of the time between snapshots,
         then it is captured by ADDM. For example, if the snapshot interval is one hour, then
         a performance problem that lasts 30 minutes should not be considered a transient
         performance problem because its duration represents a significant portion of the
         snapshot interval and is likely to be captured by ADDM.
         On the other hand, a performance problem that lasts 2 minutes could be transient
         because its duration is a small portion of the snapshot interval and probably does not
         appear in the ADDM findings. For example, if the system was slow between 10:00
         p.m. and 10:10 p.m., and if the ADDM analysis for the time period between 10:00 p.m.
         and 11:00 p.m. does not show a problem, then a transient problem may have occurred
         for only a few minutes of the 10-minute interval.
         This chapter contains the following sections:
         •   Overview of Active Session History
         •   Running Active Session History Reports
         •   Active Session History Reports
         •   Diagnosing Serious Performance Problems in Real Time


Overview of Active Session History
         To capture a detailed history of database activity, Oracle Database samples active
         sessions each second with the Active Session History (ASH) sampler. AWR snapshot
         processing collects the sampled data into memory and writes it to persistent storage.
         ASH is an integral part of the Oracle Database self-management framework and is
         extremely useful for diagnosing performance problems.
         ASH gathers sampled data at the session level rather than at the instance level. By
         capturing statistics for only active sessions, ASH collects a manageable set of data.
         The size of this data is directly related to the work being performed, rather than to the
         size of the entire database instance.
         Sampled data captured by ASH can be aggregated based on the dimensions in the
         data, including the following:




                                                                                                8-1
                                                                                             Chapter 8
                                                                Running Active Session History Reports


         •    SQL identifier of a SQL statement
         •    Object number, file number, and block number
         •    Wait event identifier and parameters
         •    Session identifier and session serial number
         •    Module and action name
         •    Client identifier of the session
         •    Service hash identifier
         You can run ASH reports to analyze transient performance problems with the database
         that only occur during specific times. This technique is especially useful when you are
         trying to do either of the following:
         •    Resolve transient performance problems that may last for only a short period of
              time, such as why a particular job or session is not responding when the rest of the
              instance is performing as usual
         •    Perform scoped or targeted performance analysis by various dimensions or their
              combinations, such as time, session, module, action, or SQL identifier



                 See Also:

                 •   "Active Session History Statistics"
                 •   Oracle Database Performance Tuning Guide for more detailed
                     information about ASH reports



Running Active Session History Reports
         This section describes how to generate ASH reports using Oracle Enterprise Manager
         Cloud Control (Cloud Control).

         To run ASH reports:
         1.   Access the Database Home page.
              See "Accessing the Database Home Page" for more information.
         2.   From the Performance menu, select Performance Home.
              If the Database Login page appears, then log in as a user with administrator
              privileges. The Performance page appears.
         3.   Under Average Active Sessions, click Run ASH Report.
              The Run ASH Report page appears.
         4.   Enter the date and time for the start and end of the time period when the transient
              performance problem occurred.
              In this example, database activity increased between 9:15 p.m. and 9:20 p.m., so
              an ASH report should be created for that time period.




                                                                                                 8-2
                                                                                   Chapter 8
                                                      Running Active Session History Reports




5.   Click Generate Report.
     The Processing: View Report page appears while the report is being generated.
     After the report is generated, the ASH report appears under Report Results on the
     Run ASH Report page.




                                                                                       8-3
                                                                                                  Chapter 8
                                                                             Active Session History Reports




                         See Also:
                         "Active Session History Reports" for descriptions of some of the reports.


             6.   Optionally, click Save to File to save the report in HTML format for future analysis.


Active Session History Reports
             You can use an ASH report to identify the source of transient performance problems.
             The report is divided into titled sections. The following sections of the ASH report are
             useful places to begin the investigation:
             •    Top Events
             •    Load Profile
             •    Top SQL
             •    Top Sessions
             •    Top DB Objects/Files/Latches
             •    Activity Over Time



                     See Also:

                     •   Oracle Database Performance Tuning Guide for more detailed
                         information about ASH reports



Top Events
             The Top Events section of the report describes the top wait events of the sampled
             session activity categorized by user, background, and priority. Use this information to
             identify the wait events that may be the cause of the transient performance problem.
             The Top Events section of the report contains the following subsections:
             •    Top User Events
             •    Top Background Events

Top User Events
             The Top User Events subsection of the report lists the top wait events from client
             processes that accounted for the highest percentages of sampled session activity.
             Figure 8-1 shows that most database activity is consumed by the CPU + Wait for CPU
             event. The Wait for CPU is the time the process spent in the operating system run
             queue. The %Event column shows the percentage of DB time consumed by this event.
             In this example, over 30 percent of DB time was spent either on the CPU or waiting to
             get on it. The Load Profile section should be examined next to determine the type of
             activity that is causing this CPU consumption.




                                                                                                      8-4
                                                                                                  Chapter 8
                                                                             Active Session History Reports


           Figure 8-1    Top User Events




Top Background Events
           The Top Background Events subsection lists the top wait events from the background
           events that accounted for the highest percentages of sampled session activity.
           The example in Figure 8-2 shows that 22.81 percent of sampled session activity is
           consumed by the CPU + Wait for CPU event.


           Figure 8-2    Top Background Events




Load Profile
           The Load Profile section of the report describes the load analyzed in the sampled
           session activity. Use the information in this section to identify the service, client, or
           SQL command type that may be the cause of the transient performance problem.
           The Top Service/Module subsection lists the services and modules that accounted for
           the highest percentages of sampled session activity. A service is a group of related
           database tasks that share common functionality, quality expectations, and priority.
           Services are a convenient way to monitor multiple applications. The SYS$USERS and
           SYS$BACKGROUND services are always defined.

           Figure 8-3 shows that over half of the database activity is consumed by the SYS$USERS
           service running the SQL*Plus module. In this example, it appears that the user
           is running high-load SQL that is causing the performance problem indicated in
           Figure 8-1. The Top SQL section of the report should be analyzed next to determine
           whether a particular type of SQL statement makes up the load.




                                                                                                       8-5
                                                                                            Chapter 8
                                                                       Active Session History Reports


          Figure 8-3     Top Service/Module




                 See Also:

                 •     "Monitoring Top Services"
                 •     "Monitoring Top Modules"



Top SQL
          The Top SQL section of the report describes the top SQL statements of the sampled
          session activity. Use this information to identify high-load SQL statements that may
          be the cause of the transient performance problem. The Top SQL with Top Events
          subsection lists the SQL statements that accounted for the highest percentages of
          sampled session activity. The Sampled # of Executions column shows how many
          distinct executions of a particular SQL statement were sampled. To view the text of the
          SQL statements, click the SQL ID link.
          Figure 8-4 shows that over half of DB time is consumed by three DML statements.
          These statements were run in the SQL*Plus module shown in Figure 8-3. The
          Top Sessions section should be analyzed to identify the sessions running these
          statements.


          Figure 8-4     Top SQL with Top Events




                                                                                                8-6
                                                                                             Chapter 8
                                                                        Active Session History Reports




                  See Also:

                  •     "Monitoring Top SQL"



Top Sessions
           The Top Sessions section lists the sessions that were waiting for the wait event
           that accounted for the highest percentages of sampled session activity. Use this
           information to identify the sessions that may be the cause of the performance problem.
           The # Samples Active column shows the number of ASH samples in which the
           session was found waiting for that particular event. The percentage is calculated
           based on wall-clock time.
           In Figure 8-5, the # Samples Active column shows that of the 300 times that ASH
           sampled database activity, the HR session (SID 123) performed a sequential read 243
           times and a flashback operation 36 times. So, HR was active at least 93% of the time.
           The session consumed 27% of the total activity (much less than 93%) because other
           sessions, including the SH session, were also active.

           It appears that the HR and SH sessions were running the high-load SQL statement in
           Figure 8-4. You should investigate this session to determine whether it is performing
           a legitimate operation and tune the SQL statement if possible. If tuning the SQL is
           not possible, and if a session is causing an unacceptable performance impact on the
           system, then consider terminating the session.


           Figure 8-5    Top Sessions




                  See Also:

                  •     "Monitoring Top Sessions"
                  •     "Tuning SQL Statements "



Top DB Objects/Files/Latches
           The Top Objects/Files/Latches section provides additional information about the most
           commonly-used database resources and contains the following subsections:




                                                                                                 8-7
                                                                                                  Chapter 8
                                                                             Active Session History Reports


               •   Top DB Objects
               •   Top DB Files
               •   Top Latches

Top DB Objects
               The Top DB Objects subsection lists the database objects (such as tables and
               indexes) that accounted for the highest percentages of sampled session activity.
               The example in Figure 8-6 shows that the hr.departments and hr.employees tables
               account for a high percentage of activity. Enqueue waits are waits for locks. In this
               example, the wait is for the TM (table) lock. Sometimes these waits indicate unindexed
               foreign key constraints. The buffer busy waits event records waits for a buffer
               to become available. These waits indicate that multiple processes are attempting to
               concurrently access the same buffers in the buffer cache.


               Figure 8-6   Top DB Objects




Top DB Files
               The Top DB Files subsection lists the database files that accounted for the highest
               percentages of sampled session activity. Only cluster and I/O events are considered.
               The % Event column breaks down the activity by event, so if multiple rows exist in this
               table, then the sampled activity is divided among multiple events.
               Figure 8-7 shows that about 11 percent of DB time involves waits for the UNDOTBS
               tablespace. This information is consistent with Figure 8-4, which shows significant
               DML activity from multiple sessions.


               Figure 8-7   Top DB Files




                                                                                                      8-8
                                                                                                  Chapter 8
                                                                             Active Session History Reports




Top Latches
              The Top Latches subsection lists the latches that accounted for the highest
              percentages of sampled session activity. Latches are simple, low-level serialization
              mechanisms to protect shared data structures in the System Global Area (SGA).


Activity Over Time
              The Activity Over Time section of the ASH report is particularly useful for longer time
              periods because it provides in-depth details about activities and workload profiles
              during the analysis period. The Activity Over Time section is divided into time slots.
              The ASH report time span is divided into 10 time slots unless the time period is short
              or the data is sparse.
              Figure 8-8 shows an activity report for the period between 2:10 p.m. and 2:40 p.m. The
              report indicates that the number of sampled sessions rose sharply in the sixth inner
              slot (2:24 p.m.) and stayed up. During this period CPU activity and lock enqueue waits
              increased dramatically.




                                                                                                      8-9
                                                                                     Chapter 8
                                                                Active Session History Reports


Figure 8-8    Activity Over Time




Each time slot contains session and wait event activity, as described in Table 8-1.

Table 8-1    Activity Over Time

Column                      Description
Slot Time (Duration)        Duration of the slot
Slot Count                  Number of sampled sessions in the slot
Event                       Top three wait events in the slot




                                                                                        8-10
                                                                                     Chapter 8
                                                                Active Session History Reports




Table 8-1     (Cont.) Activity Over Time

Column                      Description
Event Count                 Number of ASH samples waiting for the wait event
% Event                     Percentage of ASH samples waiting for wait events in the entire
                            analysis period

All inner slots are the same number of minutes each for easy comparison. The first
and last slots, called outer slots, are odd-sized because they do not have a fixed slot
time.
When comparing the inner slots, perform a skew analysis by identifying spikes. A
spike in the Slot Count column indicates an increase in active sessions and a relative
increase in database workload. A spike in the Event Count column indicates an
increase in the number of sampled sessions waiting for an event. Typically, when the
number of active session samples and the number of sessions associated with a wait
event increase, the slot may be the cause of the transient performance problem.




                                                                                        8-11
9
Resolving Performance Degradation Over
Time
         Performance degradation of the database occurs when your database was performing
         optimally in the past, such as 6 months ago, but has gradually degraded to a point
         where it becomes noticeable to the users. The Automatic Workload Repository (AWR)
         Compare Periods report enables you to compare database performance between two
         periods of time.
         While an AWR report shows AWR data between two snapshots (or two points in time),
         the AWR Compare Periods report shows the difference between two periods (or two
         AWR reports with a total of four snapshots). Using the AWR Compare Periods report
         helps you to identify detailed performance attributes and configuration settings that
         differ between two time periods. The two time periods selected for the AWR Compare
         Periods report can be of different durations. The report normalizes the statistics by the
         amount of time spent on the database for each time period and presents statistical
         data ordered by the largest difference between the periods.
         For example, a batch workload that historically completed in the maintenance
         window between 10:00 p.m. and midnight is currently showing poor performance and
         completing at 2 a.m. You can generate an AWR Compare Periods report from 10:00
         p.m. to midnight on a day when performance was good and from 10:00 a.m. to 2 a.m.
         on a day when performance was poor. The comparison of these reports should identify
         configuration settings, workload profile, and statistics that were different in these two
         time periods. Based on the differences identified, you can diagnose the cause of the
         performance degradation.
         This chapter contains the following sections:
         •   Managing Baselines
         •   Running the AWR Compare Periods Reports
         •   Using the AWR Compare Periods Reports



                See Also:

                •   "Gathering Database Statistics Using the Automatic Workload
                    Repository"



Managing Baselines
         Baselines are an effective way to diagnose performance problems. AWR supports the
         capture of baseline data by enabling you to specify and preserve a pair or a range of
         snapshots as a baseline. The snapshots contained in a baseline are excluded from the
         automatic AWR purging process and are retained indefinitely.




                                                                                              9-1
                                                                                                Chapter 9
                                                                                      Managing Baselines


             A moving window baseline corresponds to all AWR data that exists within the AWR
             retention period. Oracle Database automatically maintains a system-defined moving
             window baseline. The default size of the window is the current AWR retention period,
             which by default is 8 days.
             This section contains the following topics:
             •    Creating a Baseline
             •    Deleting a Baseline
             •    Computing Threshold Statistics for Baselines
             •    Setting Metric Thresholds for Baselines


Creating a Baseline
             Before creating a baseline, carefully consider the time period you choose as a
             baseline because it should represent the database operating at an optimal level. In the
             future, you can compare these baselines with other baselines or snapshots captured
             during periods of poor performance to analyze performance degradation over time.
             You can create the following types of baseline:
             •    Creating a Single Baseline
             •    Creating a Repeating Baseline

Creating a Single Baseline
             A single baseline is captured at a single, fixed time interval. For example, a single
             baseline may be captured on February 5, 2020 from 5:00 p.m. to 8:00 p.m.
             You can choose future start and end times to create a baseline that captures future
             database activity. If both the start time and the end time are in the future, then a
             baseline template with the same name as the baseline is also created. A baseline
             template is a specification that enables Oracle Database to automatically generate a
             baseline for a future time period.

             To create a single baseline:
             1.   Access the Database Home page for the target database.
                  See "Accessing the Database Home Page" for more information.
             2.   From the Performance menu, select AWR and then AWR Administration.
                  If the Database Login page appears, then log in as a user with administrator
                  privileges. The Performance page appears.
             3.   Under Manage Snapshots and Baselines, click the number next to Baselines.
                  The AWR Baselines page appears with a list of existing baselines displayed.




                                                                                                     9-2
                                                                               Chapter 9
                                                                     Managing Baselines




4.   Click Create.
     The Create Baseline: Baseline Interval Type page appears.




5.   Select Single and then Continue.
     The Create Baseline: Single Baseline page appears.




6.   In the Baseline Name field, enter a name for the baseline.

7.   Under Baseline Interval, select whether to use a snapshot range or a time range
     for the baseline. Do one of the following:
     •   To use a range, select Snapshot Range. Complete the following steps:




                                                                                   9-3
                                                                                                Chapter 9
                                                                                      Managing Baselines


                     –   Under Select Time Period, specify a start time for the baseline by
                         selecting Period Start Time radio button and then a snapshot icon below
                         the Active Sessions chart that corresponds to the desired start time.
                     –   Specify an end time for the baseline by selecting Period End Time radio
                         button and then a snapshot icon below the Active Sessions chart that
                         corresponds to the desired end time.
                     –   Optionally, to view older snapshots that are not displayed below the
                         Active Sessions chart, expand Change Chart Time Period. Enter the
                         desired start date in the Chart Start Date field and the desired end date in
                         the Chart End Date field, and click Go.
                     In this example, a snapshot range of February 7, 2012 from 10:50 a.m. to
                     11:20 a.m. is selected.




                 •   To use a time range, select Time Range. Complete the following steps:
                     –   In the Start Time fields, select a start time for the baseline.
                     –   In the End Time fields, select an end time for the baseline.
                     In the following example, a time range from 12:20 p.m. to 12:35 p.m. on
                     February 7, 2012 is selected.




            8.   Click Finish.
                 The AWR Baselines page returns and has a new item for just created baseline.

Creating a Repeating Baseline
            A repeating baseline is a baseline that repeats during a time interval over a specific
            period. For example, a repeating baseline may repeat every Monday from 1:00 p.m. to
            3:00 p.m. from February 7, 2012 to February 7, 2013.

            To create a repeating baseline:
            1.   Access the AWR Baselines page, as explained in "Creating a Single Baseline".



                                                                                                    9-4
                                                                                              Chapter 9
                                                                                    Managing Baselines


           2.   Click Create.
                The Create Baseline: Baseline Interval Type page appears.
           3.   Select Repeating and then click Continue.
                The Create Baseline: Repeating Baseline Template page appears.
           4.   In the Baseline Name Prefix field, enter a name prefix for the baseline.
           5.   Under Baseline Time Period, specify the time of the day that you want the
                baseline to begin collecting AWR data and the duration of the baseline collection.
           6.   Under Frequency, do one of the following:
                •    Select Daily if you want the baseline to repeat on a daily basis.
                •    Select Weekly if you want the baseline to repeat on a weekly basis, and then
                     select the day of the week on which the baseline repeats.
           7.   Under Interval of Baseline Creation, complete the following steps:
                a.   In the Start Time fields, select a date and time in the future when the data
                     collection should begin.
                b.   In the End Time fields, select a date and time in the future when the data
                     collection should end.
           8.   Under Purge Policy, enter the number of days to retain captured baselines.
           9.   Click Finish.
                A baseline template with the same name as the baseline name prefix is created. A
                baseline template is a specification that enables Oracle Database to automatically
                generate a baseline for a future time period.
                This example creates a baseline that repeats weekly on Mondays from 8:00 a.m.
                to 10:00 a.m. from February 6, 2009 to February 6, 2010. Every captured baseline
                expires after 30 days.




Deleting a Baseline
           To conserve storage space, you may want to periodically delete unused baselines
           stored in the database.



                                                                                                    9-5
                                                                                              Chapter 9
                                                                                    Managing Baselines


           Removing a source from AWR dashboard presents two options:
           1.   Hard Delete: Remove source from AWR Warehouse and purge all collected
                AWR data
                •   All the extract/transfer jobs scheduled for the source are removed.
                •   The source databases are removed from AWR dashboard
                •   Already collected AWR data for the source from the warehouse is purged.
           2.   Soft Delete: Stop all upload on source but retain collected data in AWR
                Warehouse
                •   Source database remain in the dashboard, but in a disabled (greyed out)
                    state.
                •   The extract/transfer jobs scheduled for the source are removed.
                •   Diagnosis,edit,enable/disable snapshots user actions are disabled.
                •   Retention period for the collected snapshots is still applicable. For example ,
                    all snapshots older than the retention period are deleted.
                •   AWR data collected in the Warehouse are not purged, and AWR reports can
                    be generated from the data.

           To delete a baseline:
           1.   Access the AWR Baselines page, as explained in "Creating a Single Baseline".
           2.   Select a baseline and click Delete.
                The Confirmation page appears.
           3.   Select whether to purge the underlying data associated with the baseline.
                The underlying data includes the individual snapshots preserved in the baseline
                and any statistics that are computed for the baseline. Do one of the following:
                •   To delete the underlying data, select Purge the underlying data associated
                    with the baseline.
                •   To preserve the underlying data, select Do not purge the underlying data
                    associated with the baseline.
           4.   Click Yes.
                The AWR Baselines page reappears. A message informs you that the baseline
                was deleted successfully.


Computing Threshold Statistics for Baselines
           Computing threshold statistics for baselines enables you to graphically display the
           computed statistics in the charts on the Performance page.

           To compute threshold statistics for baselines:
           1.   Access the AWR Baselines page, as explained in "Creating a Single Baseline".
           2.   Select the baseline for which you want to compute statistics.
                Select a baseline that does not already have computed statistics. These baselines
                are identified by No in the Statistics Computed column.




                                                                                                  9-6
                                                                                  Chapter 9
                                                                        Managing Baselines


3.   From the Actions list, select Schedule Statistics Computation, and then click
     Go.
     The Compute Threshold Statistics page appears.
     This example computes statistics for the baseline BASELINE_TUE_1120.




4.   In the Name field, enter a name for the task.
     Alternatively, you can choose to use the system-generated name.
5.   In the Description field, enter a description for the task.
     Alternatively, you can choose to use the system-generated description.
6.   Under Start, do one of the following:
     •   Select Immediately to run the task immediately after it has been submitted.
     •   Select Later to run the task at a later time as specified using the Date and
         Time fields.
     This computation is resource-intensive, so you may want to schedule it to run
     during off-peak hours.
7.   Click Submit.
     The AWR Baselines page appears. A message informs you that statistics
     computation has been scheduled for the selected baseline.



         See Also:
         "Customizing the Database Performance page" for information about
         displaying computed statistics on the Performance page




                                                                                        9-7
                                                                                              Chapter 9
                                                                                    Managing Baselines




Setting Metric Thresholds for Baselines
             As explained in "Setting Metric Thresholds for Performance Alerts", a metric is the rate
             of change in a cumulative statistic. Alerts notify you when particular metric thresholds
             are crossed. When the metric thresholds are crossed, the system is in an undesirable
             state. You can edit the threshold settings for baseline metrics.
             You can create the following types of baseline:
             •    Setting Metric Thresholds for the Default Moving Baseline
             •    Setting Metric Thresholds for Selected Baselines

Setting Metric Thresholds for the Default Moving Baseline
             This section describes the easiest technique for setting the metric thresholds for the
             default moving baseline. You can choose a group of basic metric threshold settings
             based on common database workload profiles such as OLTP, data warehousing, and
             OLTP with nighttime batch jobs. After choosing a workload profile, you can expand or
             change the threshold values as needed.

             To set metric thresholds for the default moving baseline:
             1.   Access the Database Home page.
                  See "Accessing the Database Home Page" for more information.
             2.   From the Performance menu, select Adaptive Thresholds.
                  If the Database Login page appears, then log in as a user with administrator
                  privileges.
                  The Threshold Configuration tab of the Baseline Metric Thresholds page appears.
             3.   Click Quick Configuration.
                  The Quick Configuration: Baseline Metric Thresholds page appears.
             4.   In Workload Profile, select one of the following options, depending on how you
                  are using the database:
                  •   Primarily OLTP (pure transaction processing 24 hours a day)
                  •   Primarily Data Warehousing (query and load intensive)
                  •   Alternating (OLTP during the daytime and batch during the nighttime)
                  In this example, Primarily OLTP was selected.
             5.   Click Continue.
                  The Quick Configuration: Review OLTP Threshold Settings page appears.




                                                                                                  9-8
                                                                                               Chapter 9
                                                                                     Managing Baselines




             6.   Review the metric threshold settings and then click Finish.
                  You are returned to the Baseline Metric Thresholds page, with the Threshold
                  Configuration tab selected. The metric threshold settings are displayed.

Setting Metric Thresholds for Selected Baselines
             This section explains how to select a baseline and edit its thresholds. You can
             configure the type of threshold, for example, whether it is based on significance levels,
             percentage of maximum values, or fixed values. You can also configure the threshold
             levels that determine when the database generates critical alerts and warnings.
             You can edit thresholds for the default moving baseline or a baseline that you created
             in the AWR Baselines page. You can select a baseline in the Edit Thresholds page
             after you have scheduled statistics computation from the AWR Baselines page and the
             statistics have finished computing on the static baseline.

             To set a metric threshold for a selected moving baseline:
             1.   Access the Baseline Metric Thresholds page, as explained in "Setting Metric
                  Thresholds for the Default Moving Baseline".
             2.   In the View list, select Basic Metrics.
                  The Baseline Metric Thresholds page appears.
             3.   In the Category/Name column, click the link for the metric whose threshold you
                  want to set or change.
                  For example, click Number of Transactions (per second).
                  The Edit Thresholds: Number of Transactions (per second) appears.




                                                                                                   9-9
                                                                                              Chapter 9
                                                               Running the AWR Compare Periods Reports




             The charts on this page provide simple and detailed views of metric activity for a
             24-hour period. In the top simple chart, click a day to view the value of the metric
             plotted against a 24-hour period.
        4.   Under AWR Baseline, in the Name list, select either the default
             SYSTEM_MOVING_WINDOW or the name of a baseline created in the AWR
             Baselines page.
             A baseline appears in the AWR Baseline list after you have scheduled statistics
             computation from the AWR Baselines page and the statistics have finished
             computing on the static baseline.
             In this example, BASELINE_TUE_1120 is selected.
             The page refreshes to show the charts for the baseline that you selected.
        5.   In the Threshold Settings section, complete the following steps to change the
             settings:
             a.   In the Threshold Type list, select a type.
             b.   In the Critical list, select a level.
             c.   In the Warning list, select a value.
             d.   In the Occurrences list, select a value.
        6.   Click Apply Thresholds.
             The Baseline Metric Thresholds page reappears. The page shows the altered
             metric threshold settings.


Running the AWR Compare Periods Reports
        This section describes how to run the AWR Compare Periods reports using Enterprise
        Manager Cloud Control (Cloud Control).




                                                                                                9-10
                                                                                                 Chapter 9
                                                                  Running the AWR Compare Periods Reports


           You can use AWR Compare Periods reports to compare the database performance
           between two time periods by:
           •    Comparing a Baseline to Another Baseline or Pair of Snapshots
           •    Comparing Current System Performance to a Baseline Period
           •    Comparing Two Pairs of Snapshots


Comparing a Baseline to Another Baseline or Pair of Snapshots
           When performance degradation occurs over time, you can run the AWR Compare
           Periods report to compare the degraded performance, captured as a new baseline or
           a pair of snapshots, to an existing baseline. You must have a baseline that represents
           the system operating at an optimal level. If an existing baseline is unavailable, then
           compare database performance between two periods of time using two arbitrary pairs
           of snapshots, as described in "Comparing Two Pairs of Snapshots".

           To compare a baseline to another baseline:
           1.   Access the Database Home page for the target database.
                See "Accessing the Database Home Page" for more information.
           2.   From the Performance menu, select AWR, then AWR Administration.
                If the Database Login page appears, then log in as a user with administrator
                privileges. The Automatic Workload Repository page appears.




           3.   Under Manage Snapshots and Baselines, click the link next to Baselines.
                The AWR Baselines page appears.
           4.   Complete the following steps:
                a.   Select the baseline to use for the report.
                     At least one existing baseline must be available.
                b.   From the Actions list, select Compare Periods and then click Go.
                The Compare Periods: Second Period Start page appears. Under First Period, the
                selected baseline is displayed.
                In this example, the baseline named BASELINE_TUE_1120 is selected.




                                                                                                    9-11
                                                                                   Chapter 9
                                                    Running the AWR Compare Periods Reports




5.   Compare the baseline selected in the first period to another baseline or a pair of
     snapshots. Do one of the following:
     •   To compare to another baseline, select Select a Baseline and the baseline
         you want to use in the second period, and then click Next.
         The Compare Periods: Review page appears.
     •   To compare to a pair of snapshots, select Select Beginning Snapshot and
         the beginning snapshot to use in the second period, and then click Next.
         This example selects snapshot 18, taken on February 7, 2012 at 1:00 p.m.




         The Compare Periods: Second Period End appears. Proceed to the next
         step.
6.   Select the ending snapshot for the snapshot period to include in the report and
     then click Next.
     In this example, snapshot 1500, taken on February 7, 2009 at 12:50 p.m., is
     selected.




     The Compare Periods: Review page appears.




                                                                                     9-12
                                                                                  Chapter 9
                                                   Running the AWR Compare Periods Reports




7.   Review the periods to be included in the report and then click Finish.
     The Compare Periods: Results page appears.
     Data from the selected periods appears under the General subpage. You can view
     data per second or per transaction by selecting an option from the View Data list.



            Note:
            If the time periods have different lengths, then the data is normalized
            over database time before calculating the difference so that periods of
            different lengths can be compared.


     In this example, almost every metric shows that more resources were consumed
     in the first period. The bar graphs indicate the proportions of the values in the
     two periods. The absence of bars indicates equivalent values. The report for this
     example shows significantly more database block changes per second and parse
     time in the first period than in the second.




8.   Click Report to view the report.
     The Processing: View Report page appears while the report is being generated.
     After it completes, the report appears.
9.   Optionally, do the following:
     •   To change periods, click Change Periods.




                                                                                      9-13
                                                                                                 Chapter 9
                                                                  Running the AWR Compare Periods Reports


                •       To save the report as an HTML file, click Save to File.



                    See Also:

                    •      "Creating a Baseline"
                    •      "Using the AWR Compare Periods Reports"



Comparing Current System Performance to a Baseline Period
           You may have noticed a performance change on a production system and would like
           to know why, or you may have implemented a change to a production system and
           want to know the effect of the change, such as increased concurrency waits.
           The Compare Period ADDM compares the performance of the database server in two
           time periods, and returns a report describing the performance changes and the root
           origin of the changes. The Advisor can analyze any Oracle RDBMS version 10.2.0.4
           or later monitored by Cloud Control. The following procedure explains how to initiate a
           report from the Compare Period ADDM.
           1.   From the Performance menu, select AWR, then Compare Period ADDM.
           2.   From the Run Compare Period ADDM page, specify the desired comparison and
                base periods:
                •       Comparison Period — Generally represents an improperly functioning
                        time period. However, you could also use the advisor to understand why
                        performance has improved now when compared with an earlier time period.
                •       Base Period — Represents a known (baseline or reference) period in which
                        the database is functioning properly. You should select a base period in which
                        the performance was acceptable, and the workload was as similar or identical
                        as possible.
           3.   Click Run to display the Database Compare Period Report.
           4.   Examine the sections of the report to understand the performance change
                between the two periods and the cause of the change:
                •       Overview
                        This portion of the report shows SQL commonality, which is the comparability
                        between the base and comparison periods based on the average resource
                        consumption of the SQL statements common to both periods.
                        A commonality value of 100% means that the workload "signature" in both
                        time periods is identical. A value of 0% means that the two time periods have
                        no items in common for the specific workload dimension.
                        Commonality is based on the type of input (that is, which SQL is executing)
                        as well as the load of the executing SQL statements. Consequently, SQL
                        statements running in only one time period, but not consuming significant
                        time, do not affect commonality. Therefore, two workloads could have a
                        commonality of 100% even if some SQL statements are running only in one
                        of the two periods, provided that these SQL statements do not consume
                        significant resources.
                •       Configuration



                                                                                                   9-14
                                                                                               Chapter 9
                                                                Running the AWR Compare Periods Reports


                   The information displayed shows base period and comparison period values
                   for various parameters categorized by instance, host, and database.
               •   Findings
                   The findings can show performance improvements and identify the major
                   performance differences caused by system changes. For negative outcomes,
                   if you understand and remove the cause, the negative outcome can be
                   eliminated.
                   The values shown for the Base Period and Comparison Period represent
                   performance with regard to database time.
                   The Change Impact value represents a measurement of the scale of a change
                   in performance from one time period to another. It is applicable to issues
                   or items measured by the total database time they consumed in each time
                   period. The absolute values are sorted in descending order.
                   If the value is positive, an improvement has occurred, and if the value is
                   negative, a regression has occurred. For instance, a change impact of -200%
                   means that period 2 is three times as slow as period 1.
                   You can run performance tuning tools, such as ADDM and the SQL Tuning
                   Advisor, to fix issues in the comparison period to improve general system
                   performance.
               •   Resources
                   The information shown here provides a summary of the division of database
                   time for both time periods, and shows the resource usage for CPU, memory,
                   I/O, and interconnect (Oracle RAC only).
          5.   Based on your observations, decide how to proceed to resolve performance
               regressions, then implement your action plan.


Comparing Two Pairs of Snapshots
          If an existing baseline is unavailable, then you can compare database performance
          by using two arbitrary pairs of snapshots. Use one pair taken when the database is
          performing optimally, and another pair when the database is performing poorly. At least
          four snapshots must be available.

          To compare performance using two pairs of snapshots:
          1.   Access the Database Home page.
               See "Accessing the Database Home Page" for more information.
          2.   From the Performance drop-down menu, select AWR and then Compare
               Periods Reports.
               If the Database Login page appears, then log in as a user with administrator
               privileges. The Run Compare Periods Report page appears.
          3.   In First Period, select By Snapshot.
          4.   In Begin Snapshot, click the magnifying glass icon.
               The Search and Select: Snapshots page appears.
          5.   Select the starting point for the first snapshot period to be included in the report,
               and then click Select.




                                                                                                 9-15
                                                                                            Chapter 9
                                                               Using the AWR Compare Periods Reports


             You are returned to the Run Compare Periods Report page.
        6.   In End Snapshot, click the magnifying glass icon.
             The Search and Select: Snapshots page appears.
        7.   Select the ending point for the first snapshot period to be included in the report,
             and then click Select.
             You are returned to the Run Compare Periods Report page.
        8.   Under Second Period, repeat Step 3 through Step 7.
        9.   Click Generate Report.
             The Report Results section appears on the Run Compare Periods Report page.
             The section contains the Workload Repository Compare Period Report.
        10. Optionally, do the following:
             •   To change periods, repeat Step 3 through Step 9.
             •   To save the report as an HTML file, click Save to File.


Using the AWR Compare Periods Reports
        After an AWR Compare Periods report is generated for the time periods you want to
        compare, you can use it to analyze performance degradation. To learn how to create
        the report, see "Running the AWR Compare Periods Reports".
        Figure 9-1 shows a portion of an AWR Compare Periods report.




                                                                                              9-16
                                                                                          Chapter 9
                                                             Using the AWR Compare Periods Reports


          Figure 9-1   AWR Compare Periods Report




          The AWR Compare Periods report is divided into the following sections:
          •   Summary of the AWR Compare Periods Report
          •   Details of the AWR Compare Periods Report
          •   Supplemental Information in the AWR Compare Periods Report


Summary of the AWR Compare Periods Report
          The report summary is at the beginning of the AWR Compare Periods report, and
          summarizes information about the snapshot sets and loads used in the report. The
          report summary contains the following sections:
          •   Snapshot Sets
          •   Host Configuration Comparison
          •   Cache Sizes
          •   Load Profile
          •   Top Timed Events




                                                                                            9-17
                                                                                                Chapter 9
                                                                   Using the AWR Compare Periods Reports




Snapshot Sets
               The Snapshot Sets section displays information about the snapshot sets used for this
               report, such as instance, host, and snapshot information.
               In the example shown in Figure 9-1, the first snapshot period corresponds to the
               time when performance was stable on February 7 from 10:50 to 11:20. The second
               snapshot period corresponds to the time when performance degradation occurred on
               the same day from 12:50 to 13:00.

Host Configuration Comparison
               The Host Configuration Comparison section compares the host configurations used
               in the two snapshot sets. For example, the report compares physical memory and
               number of CPUs. Differences in the configurations are quantified as percentages in the
               %Diff column.

Cache Sizes
               The Cache Sizes section compares the database configurations used in the two
               snapshot sets. For example, the report compares the SGA and log buffer size.
               Differences in the configurations are quantified as percentages in the %Diff column.

Load Profile
               The Load Profile section compares the loads used in the two snapshot sets.
               Differences in the loads are quantified as percentages in the %Diff column.




                                                                                                  9-18
                                                                                            Chapter 9
                                                               Using the AWR Compare Periods Reports




           In this example, the DB time per second was 100% higher in the first period. CPU time
           per second was 100% higher.

Top Timed Events
           The Top Timed Events section is one of the most useful sections in the report.
           This section displays the five timed events or operations that consumed the highest
           percentage of total DB time in each of the snapshot sets.




                                                                                              9-19
                                                                                               Chapter 9
                                                                  Using the AWR Compare Periods Reports


          In this example, CPU time and the number of waits for database file sequential reads
          are significantly higher in the first period than in the second.


Details of the AWR Compare Periods Report
          The Report Details section follows the summary of the AWR Compare Periods report,
          and provides statistics about the snapshot sets and loads used in the report. For
          example, the section includes statistics for time model statistics, wait events, SQL
          execution time, and instance activity.


Supplemental Information in the AWR Compare Periods Report
          The supplemental information is at the end of the AWR Compare Periods report, and
          provides additional information about initialization parameters and SQL statements.
          The init.ora Parameters section lists all the initialization parameter values for the first
          snapshot set. The Complete List of SQL Text section lists each statement by SQL ID
          and shows the text of the SQL statement.




                                                                                                  9-20
10
Using Automatic Workload Repository
Warehouse for Generating Performance
Reports
      The Enterprise Manager AWR Warehouse enables you to consolidate and store
      detailed performance data from the Automatic Workload Repository of your important
      Oracle databases. This consolidated AWR Warehouse allows DBAs and developers
      to view and analyze historical performance data beyond the AWR retention period
      of the source database. Enterprise Manager extracts Automatic Workload Repository
      (AWR) data from one or more source database targets and transfers it into the AWR
      Warehouse, which is maintained independent of the source databases. The AWR
      Warehouse lets you keep a long-term history of AWR data, forever, if so configured,
      from the selected Enterprise Manager database targets. This enables long-term
      analysis of AWR data across databases without performance or storage impact on
      the source database targets.
      Therefore, by uploading AWR data to a centralized AWR Warehouse, you free up
      space and improve performance on your production systems.
      Starting in version 19c, AWR supports pluggable databases (PDB) as source
      databases that upload their AWR data to the warehouse. Also PDBs can be the AWR
      warehouse repository. This feature requires Oracle Database 12.2 and higher as the
      source or repository.
      To configure an AWR warehouse, an Enterprise Manager administrator needs to
      designate an existing Enterprise Manager database target as the AWR Warehouse.
      The warehouse target database must be version 12.1.0.2 or higher or version 11.2.0.4
      with the appropriate patch. It also must be an equal or higher database version of the
      source databases it accommodates.
      The warehouse is built in the SYS schema, using the SYSAUX tablespace by default.
      Starting Database 19c, it is possible to specify another tablespace to store the AWR
      data collected from all the source databases. This tablespace must exist on the
      Warehouse database.
      To use the feature, you first need to set up an Oracle database that Enterprise
      Manager can use as the AWR Warehouse. After you set up the warehouse database,
      you can identify source databases whose repositories you want to extract and upload
      to the warehouse.
      In Oracle Enterprise Manager 13c Platform Release 4 Update 2 (13.4.0.2). Active
      Data Guard (ADG) supports the switch over when the warehouse database or source
      database is configured with ADG and the primary database goes down and the
      standby database becomes the primary. After the switchover, the databases are
      automatically switched in the AWR warehouse.




                                                                                        10-1
                                                                                         Chapter 10
                                                                      Setting Up the AWR Warehouse




Setting Up the AWR Warehouse
        Ensure that these prerequisites are satisfied before designating a database as the
        AWR Warehouse:
        •    The target database must be an existing version 12.1.0.2 or higher or 11.2.0.4
             with the appropriate patch level managed target in Enterprise Manager Cloud
             Control. Oracle recommends that the selected database not be used by any other
             application and that the Enterprise Manager Cloud Control repository not be used
             as the warehouse.
        •    There is sufficient space available to accommodate the data to be uploaded, as
             a factor of per source database per day. Rule of thumb is a range of 4-10MB per
             database per day.
        •    You must have Super Administrator privileges to configure the AWR Warehouse.
        1.   From the Targets drop-down menu, select Databases.
             The Databases page appears with a list of the available target databases.
        2.   Access the Database Home page for the target database.
             See "Accessing the Database Home Page" for more information.
        3.   On the Databases page, click Performance drop-down, then select AWR
             Warehouse.
             If it has not previously been configured, a workflow diagram appears with
             aConfigure button in the right-hand pane. If it has been configured, the tool icon
             takes you to the configuration page.
             Prior to warehouse setup, the page displays a feature workflow on the left and
             configuration access on the right.




                                                                                            10-2
                                                                                   Chapter 10
                                                               Setting Up the AWR Warehouse




            Note:
            When adding a new AWR source database, you can specify dump
            locations for extract. The location should be a valid directory inside the
            source database host (or a shared location in case of a cluster) and
            accessible by the host credential specified. By default, the field is empty
            and means the dump file location is the default agent directory.


     After setup, the right side of the page summarizes the warehouse configuration
     and graphically depicts space used as a percentage of space available.




4.   Click Configure in the pane to the right of the workflow diagram. The first
     configuration page (Repository) appears.
5.   Click the search icon to select the database to serve as the AWR Warehouse.
6.   Select the preferred or named credentials established for the target database. You
     can also provide new credentials.
     You can specify a password compliant with password policy for staging schema
     during warehouse configuration. If none specified, a complex random password is
     used by default.
7.   Select the preferred or named credentials established for the target database host.
     You can also provide new credentials.
8.   Click Next. The second configuration page (AWR Snapshot Management)
     appears.
9.   Set the retention period to a number of years. Optionally, you can choose to retain
     the data indefinitely.
10. Set the snapshot upload interval. The default is 24 hours The minimum interval is
     one hour. You can also upload snapshots on-demand.
11. Select where on the warehouse database host to save exported dump files. For a
     single instance database, the location defaults to the agent state directory. For a
     cluster database, you have to specify a location that is accessible to all nodes.
12. Click Submit. This submits a job with the prefix CAW_LOAD_SETUP_.

After initial setup, the AWR Warehouse page becomes a dashboard where you can
perform the following tasks:
•    Add and remove source databases.
•    Enable and disable snapshot uploads.




                                                                                      10-3
                                                                                            Chapter 10
                                                                         Setting Up the AWR Warehouse


          •   Upload snapshots on-demand.
          •   Give administrators access to AWR data stored in the warehouse.
          •   Monitor and research incidents and errors.
          •   Run performance reports and analytics on the warehouse the same as you would
              on local AWRs.
          •   Edit Warehouse properties after the configuration is done with the Edit button.
              Properties that can be changed are:
              1.   Database Credential
              2.   Host Credential
              3.   Retention period
              4.   Upload Interval
              5.   Staging Schema Password



                      Note:
                      Modifying Warehouse properties affects all the sources and overrides
                      source level custom properties, if any.

          •   Edit the properties of a source database.
              1.   Host Credential
              2.   Database Credential
              3.   Upload Interval
              4.   Retention period



                      Note:
                      If you modify Host Credential, Database Credential, or Upload
                      Interval, a Reconfigure Job is triggred and re-schedules the extract and
                      transfer jobs with the new values.

          •   Specify dump locations for extract when adding a new AWR source database.



                      Note:
                      The location should be a valid directory inside the source database
                      host (shared location in case of a cluster) and accessible by the host
                      credential specified. By default, the field is empty and uses the default
                      agent directory.



Working with Source Databases
          Use the AWR Warehouse dashboard to manage the source databases that comprise
          the AWR warehouse, including the following activities:




                                                                                                  10-4
                                                                                           Chapter 10
                                                                        Setting Up the AWR Warehouse


          •    Add and remove source databases.
          •    Enable and disable snapshot uploads.
          •    Upload snapshots on-demand
          •    Grant view access to centrally stored AWR data.

          Adding and Removing Source Databases
          A source database whose AWR data you want to upload to the warehouse must be
          the same or earlier (to 10.2.0.4) as the version of the warehouse database. You can
          add and remove source databases provided you have access to the database target
          and to database credentials with execute privileges on the sys.dbms_swrf_internal
          package and the DBA role.
          Click the Add button on the toolbar and select the source databases to add to the
          AWR Warehouse. Select a source database on the dashboard and click the Remove
          button to remove it. When you remove a database, its data remains for a time until a
          job runs to clear the data. If you want to retain the data, disable the snapshot upload
          instead of removing the database.

          Enabling and Disabling Snapshot Uploads
          When you add a source database, its snapshot upload is enabled by default. You
          must be the owner or a proxy to disable (and re-enable) a source database's snapshot
          upload. When you disable an upload, any in-process job is allowed to complete prior
          to the cessation of an upload. When re-enabled, the upload resumes with the next
          scheduled upload.

          Uploading Snapshots On-Demand
          You can also upload a snapshot on-demand. Select a source database on the
          dashboard and then select Upload Snapshots Now from the Actions menu.

          Granting View Access to AWR Snapshots
          The source database owner can grant other Enterprise Manager Administrators view
          access to AWR snapshots stored in the AWR Warehouse.
          1.   Select a source database in the dashboard table and click the Privileges button in
               the toolbar.
          2.   In the dialog that opens, move administrator names from the Available list to the
               Selected list.
          3.   Click OK to grant view access to the selected names.


Uploading Snapshots to the AWR Warehouse
          Upload of AWR snapshot data from source databases occurs as an ETL process,
          which is a series of jobs that perform ETL—Extract, Transfer, Load—processing.

          Extract AWR Data
          As part of the collection process, a DBMS job runs at regular intervals to collect
          AWR snapshots and create dumps in a staging area on the target host. Initially,
          this job collects existing AWR data and subsequently collects the latest snapshot in




                                                                                              10-5
                                                                                            Chapter 10
                                                      Using Performance Pages with the AWR Warehouse


        incremental fashion. If there is too much data to collect initially, the job staggers the
        collection process to avoid placing a burden on the source database.

        Transfer AWR Data
        An Enterprise Manager job runs at regular intervals on the respective host to transfer
        the source database AWR data to a staging area on the warehouse host for further
        processing. This job copies the dump files using an agent-to-agent file transfer
        mechanism. Upon successful upload to the warehouse, the dump file is removed from
        the host staging area.

        Loading Transferred Data into the AWR Warehouse
        A DBMS job runs at regular intervals to process multiple source database dump files
        and import them into the warehouse schema. This occurs incrementally to ensure
        snapshots were not already imported. As part of the import process, the job maps
        DB IDs to ensure uniqueness. This information is maintained in a separate table to
        handle duplicate DB IDs and to support multitenant scenarios; for example, multiple
        customers' data stored in a single AWR database, where there might be duplicate
        database names. AWR data remains in the warehouse up to the configurable retention
        period, after which it is purged.



                Note:
                You can also upload snapshots on-demand. Select a source database on
                the dashboard and then select Upload Snapshots Now from the Actions
                menu.




Using Performance Pages with the AWR Warehouse
        You can view historical data, charts, and reports from a configured AWR Warehouse,
        by switching the View Data mode to AWR Warehouse on the respective performance
        pages for a source database.

        Performance Home Page
        Use the Performance Home page with the AWR Warehouse as follows:
        1.   If you are already in the AWR Warehouse, skip to 5.
        2.   From the Targets drop-down menu, select Databases.
        3.   Select a database on the Enterprise Manager dashboard.
        4.   From the Performance drop-down menu, select AWR and then AWR
             Warehouse.
        5.   From AWR Warehouse dashboard, highlight a database.
        6.   Click the Performance Home button on the AWR toolbar.
             The Performance Home page displays in Historical - AWR Warehouse mode.




                                                                                               10-6
                                                                                  Chapter 10
                                            Using Performance Pages with the AWR Warehouse




            Note:
            You do not have to log in to the source database to view this page.
            The AWR Warehouse selection is available only for databases that have
            been added as source databases and only to users who have been
            granted access.




        See Also:
        "Monitoring User Activity" for more information about the Performance Home
        page.



ASH Analytics Page
Use the ASH Analytics page with the AWR Warehouse as follows:
1.   If you are already in the AWR Warehouse, skip to 5.
2.   From the Targets drop-down menu, select Databases.
3.   Select a database on the Enterprise Manager dashboard.
4.   From the Performance drop-down menu, select AWR and then AWR
     Warehouse.
5.   From AWR Warehouse dashboard, highlight a database.
6.   Click the ASH Analytics button on the toolbar.
     The ASH Analytics page displays in Historical - AWR Warehouse mode.



            Note:
            You do not have to log in to the source database to view this page.




        See Also:
        "Determining the Cause of Spikes in Database Activity" for more information
        about ASH Analytics.



AWR Report Page
Use the AWR Report page with the AWR Warehouse as follows:
1.   If you are already in the AWR Warehouse, skip to 5.
2.   From the Targets drop-down menu, select Databases.
3.   Select a database on the Enterprise Manager dashboard.




                                                                                     10-7
                                                                                 Chapter 10
                                            Using Performance Pages with the AWR Warehouse


4.   From the Performance drop-down menu, select AWR and then AWR
     Warehouse.
5.   From AWR Warehouse dashboard, highlight a database.
6.   Click the AWR Report button on the toolbar.
     The AWR Report page displays in Historical - AWR Warehouse mode. Note that
     you do not have to log in to the source database to view this page.
7.   Click Generate Report.



        See Also:
        " Resolving Performance Degradation Over Time " for more information
        about AWR Report.



Compare Period ADDM Page
Use the Compare Period ADDM page with the AWR Warehouse as follows:
1.   If you are already in the AWR Warehouse, skip to 5.
2.   From the Targets drop-down menu, select Databases.
3.   Select a database on the Enterprise Manager dashboard.
4.   From the Performance drop-down menu, select AWR and then AWR
     Warehouse.
5.   From AWR Warehouse dashboard, highlight a database.
6.   Select Compare Period ADDM from the Compare Period drop-down menu.
     The Compare Period ADDM page displays in Historical - AWR Warehouse mode.
     Note that you do not have to log in to the source database to view this page.
7.   Complete Steps 1 and 2. Note that database selection in Step 2 lists all databases
     with AWR data in the warehouse to which you have access.
8.   Click Run to run the comparison.



        See Also:
        "Comparing Current System Performance to a Baseline Period" for more
        information about Compare Period ADDM.



Compare Periods Report
Use the Compare Periods Report page with the AWR Warehouse as follows:
1.   If you are already in the AWR Warehouse, skip to 5.
2.   From the Targets drop-down menu, select Databases.
3.   Select a database on the Enterprise Manager dashboard.
4.   From the Performance drop-down menu, select AWR and then AWR
     Warehouse.



                                                                                    10-8
                                                                                         Chapter 10
                                                                      AWR Warehouse Best Practices


           5.   From AWR Warehouse dashboard, highlight a database.
           6.   Select Compare Periods Report from the Compare Period drop-down menu.
                The Compare Periods Report page displays in Historical - AWR Warehouse
                mode. Note that you do not have to log in to the source database to view this
                page.
           7.   Complete First and Second Periods.



                       Note:
                       The selections for the two periods are derived from data in the
                       warehouse. For the second period, you can select any database in the
                       warehouse to which you have access.


           8.   Click Generate Report.



                   See Also:
                   "Running the AWR Compare Periods Reports" for more information about
                   Compare Periods Report.




AWR Warehouse Best Practices
           Oracle makes best practices recommendations from both a warehouse database
           perspective and an Enterprise Manager perspective.


Database Best Practices
           Best practices from the warehouse database perspective involve the following areas:
           •    Memory Management
           •    Storage Requirements
           •    Backup
           •    Redo Log Size
           •    Stats Collection
           •    The job_queue_processes Parameter
           •    Access Control

Memory Management
           Oracle recommends that you use Automatic Memory Management on the warehouse
           database to manage and tune it as required. To do this, set the target memory size
           initialization parameter (MEMORY_TARGET) and optionally a maximum memory size
           initialization parameter (MEMORY_MAX_TARGET). The amount of target memory
           depends on the number of users of the warehouse. Set it to at least 2GB and modify it
           as needed depending on the load and other requirements.



                                                                                              10-9
                                                                                            Chapter 10
                                                                         AWR Warehouse Best Practices


             When using manual memory management, set the sizes of SGA and instance PGA to
             sufficiently high enough values, minimally, 2GB. And if using manual shared memory
             management, set the sizes of individual SGA components, especially buffer cache size
             and shared pool size, to sufficiently high enough values.

Storage Requirements
             By default, Oracle Database captures snapshots once every hour; the snapshot size
             varies depending on the database load. A typical system with an average of 10
             concurrent active sessions may take anywhere from 1MB to 2MB per snapshot. Thus,
             the one hour default snapshot interval requires approximately 24MB to 48MB a day.
             AWR data is stored in SYSAUX tablespace. The tablespace space required depends
             on the number of source databases. Using default settings with a typical load on
             source databases requires approximately 24MB to 48MB a day per source database.
             To get a more accurate read on space requirements, run the awrinfo.sql script
             located in the ORACLE_HOME/rdbms/admin directory. In particular, see the "Size
             estimates for AWR snapshots" section, which contains "AWR size/day" and "AWR
             size/wk" values. On source databases, these values represent the average size of
             AWR data being generated on that database. On the AWR Warehouse database,
             these values represent the average size of AWR data imported from all the
             source databases. Use these values to estimate the warehouse space requirements.
             Naturally, as more source databases are added to the warehouse, the space required
             to store their AWR data increases.
             Use Automatic Storage Management (ASM) with redundant disk groups and
             "Average Synchronous Single-Block Read Latency" of less than 40 milliseconds. The
             DBA_HIST_SYSMETRIC_SUMMARY view contains this and other metrics related to
             storage and I/O.
             Additionally, ensure that there is enough free disk space (approximately 50GB) on the
             warehouse host to store the dump files containing incoming AWR data from source
             databases until the data can be loaded into the warehouse database.

Backup
             Oracle recommends that you back up the AWR Warehouse on a regular basis as a
             safeguard against any data loss. Using Data Guard along with RMAN ensures high
             availability and data protection.

Redo Log Size
             It is important to size the redo logs correctly. A small redo results in frequent log
             switches affecting database performance. The amount of redo generated in AWR
             Warehouse varies based on the number of source databases moving their AWR data
             into the warehouse. Oracle recommends a minimum of 1GB redo log sizing.

Stats Collection
             Gather statistics periodically, once a day at a minimum, for SYS and DBSNMP
             schemas to ensure that the stats are accurate.




                                                                                              10-10
                                                                                              Chapter 10
                                                                           AWR Warehouse Best Practices




The job_queue_processes Parameter
            Set JOB_QUEUE_PROCESSES to a value greater than 0. Oracle scheduler jobs are
            responsible for importing AWR data. Setting the parameter ensures that job slaves are
            created to run the scheduler jobs.

Access Control
            Ensure that users do not have direct access to the warehouse database as this
            will bypass the Enterprise Manager security model. The AWR Warehouse console in
            Enterprise Manager has an access control mechanism to control who can view data in
            the AWR Warehouse and for which source databases.


Enterprise Manager Best Practices
            Best practices from the Enterprise Manager perspective involve the following areas:
            •    AWR Warehouse Credentials
            •    Source Database Credentials
            •    Staging Location on AWR Warehouse
            •    Network Latency

AWR Warehouse Credentials
            When configuring an Enterprise Manager target as the AWR Warehouse Repository,
            select two credentials:
            •    Database credentials–AWR Warehouse requires SYSDBA credentials.
            •    Database host credentials–select credentials that have write permission on the
                 dump file staging location. The default staging location is the agent state directory
                 to which the agent user has the necessary permissions.

Source Database Credentials
            Before adding source database targets to the AWR Warehouse Repository, set
            Preferred Credentials (Normal Credentials should be sufficient) for each of the source
            databases and their hosts. This facilitates adding multiple source databases at once
            (select multiple databases in the Search and Select: Database dialog).
            •    Database credentials–the database user requires the following:
                 –   DBA role
                 –   Execute privileges on SYS.DBMS_SWRF_INTERNAL package
            •    Database host credentials–the user should be the same as the agent user.

Staging Location on AWR Warehouse
            AWR data from source databases moves as dump files to a staging location on the
            warehouse database host. You can configure the staging location when setting up the
            AWR Warehouse. For a single instance database, the location defaults to the agent




                                                                                                10-11
                                                                                                Chapter 10
                                                           Monitoring and Researching Incidents and Errors


           state directory. For a cluster database, you have to specify a location that is accessible
           to all nodes.

Network Latency
           AWR Warehouse uses the Agent-to-Agent file transfer method to move dump files
           from source databases to the warehouse database host. The connection between the
           source agent host and the warehouse agent host should have low network latency to
           avoid delays and problems during the transfer.


Monitoring and Researching Incidents and Errors
           With the constant movement of data, problems can occur at various stages of the
           upload process. The dashboard reports on incidents and errors so that you can trace
           and resolve issues. Consistent with Enterprise Manager best practices, you can use
           the existing frameworks to manage incidents, configure notifications, and so forth.
           The graphical region of the dashboard provides an at-a-glance view of issues
           encountered overall during warehouse upload activity. When an incident is raised, a
           View Incidents link appears; click it to link directly to Incident Manager where you can
           drill down to research the details. The Guided Resolution section provides links to view
           any warehouse errors reported and to return to the AWR Warehouse dashboard.
           You can proactively identify the points of failure after the AWR warehouse is
           configured and the ETL process started running between the source database and
           warehouse, by running a number of tests on the AWR warehouse or a select set of
           sources and determine the health of the AWR warehouse configuration.
           To view errors related to a specific database source, select the database row in the
           dashboard and click View Errors on the toolbar.
           Errors typically break down by activity—AWR Warehouse load, source database
           extract, transfer. Some of the more common errors and suggested resolutions are
           described below.

           AWR Warehouse Load Errors
           When SYSAUX tablespace on the AWR Warehouse is insufficient to accommodate the
           import of AWR snapshots, the import fails with the following errors:
           ORA-20115: Data Pump import encountered error:
           ORA-31626: job does not exist
           ORA-31633: unable to create master table "SYS.SYS_IMPORT_FULL_27"
           ORA-06512: at "SYS.DBMS_SYS_ERROR", line 95
           ORA-06512: at "SYS.KUPV$FT", line 1048
           ORA-01658: unable to create INITIAL extent for segment in tablespace SYSAUX
           ORA-31626: job does not exist

           Increase the SYSAUX tablespace to resolve the issue.
           Load jobs use Data Pump to import AWR snapshot dumps. Data Pump jobs use a
           master table to track a job's progress. If an error occurs during import, the master
           table remains. As errors accumulate so too do master tables, eventually resulting in
           the following errors:
           ORA-20115: Data Pump import encountered error:
           ORA-31634: job already exists




                                                                                                  10-12
                                                                                    Chapter 10
                                               Monitoring and Researching Incidents and Errors


ORA-31664: unable to construct unique job name when defaulted
ORA-31634: job already exists

The solution is to drop the master tables from the previous failed jobs. Query the
dba_datapump_jobs view for jobs in the NOT RUNNING state, as follows:
SELECT job_name
FROM dba_datapump_jobs
WHERE owner_name='SYS'
 AND operation='IMPORT'
 AND job_mode='FULL'
 AND job_name like 'SYS_IMPORT_%'
 AND state='NOT RUNNING';



       Caution:
       There may be cases where a job name the query returns is in use by an
       active Data Pump job. Ensure that there are no active Data Pump jobs to
       avoid mistakenly deleting their master tables.



The patch that enables the AWR Warehouse feature includes a fix for the legacy
master tables, so you should not encounter this problem after applying the patch.
When an active Data Pump job exits ungracefully (it aborts or the database shuts
down, for example), subsequent jobs fail with the following errors:
ORA-39097: Data Pump job encountered unexpected error -56935
ORA-39065: unexpected master process exception in DISPATCH
ORA-56935: existing datapump jobs are using a different version of time zone
data file

To resolve the issue, check database properties for certain values on database startup
and take appropriate action, as follows:
SELECT property_name, property_value
FROM sys.database_properties
WHERE property_name in ('DST_UPGRADE_STATE', 'DST_SECONDARY_TT_VERSION');

If the query returns 'DATAPUMP' and '<> 0', respectively, for the named properties,
run the following:
exec dbms_dst.unload_secondary();



       Note:
       This Data Pump error can also happen during source database extraction.



When the source database time zone is ahead of the AWR Warehouse time zone, the
following error occurs when importing the latest snapshot dumps:
ORA-20105: Unable to move AWR data to SYS
ORA-06512: at "SYS.DBMS_SWRF_INTERNAL", line 4773
ORA-13555: Message 13555 not found; product=RDBMS; facility=ORA;
arguments: [end_time is greater than SYSDATE]




                                                                                      10-13
                                                                                     Chapter 10
                                                Monitoring and Researching Incidents and Errors


No action is necessary. The issue self-corrects when the SYSDATE of the AWR
Warehouse advances past the date of the dump file.

Source Database Extract Errors
When SYSAUX tablespace on the source database is insufficient to accommodate the
extract of AWR snapshots, the extract fails with the following errors:
ORA-20115: Data Pump export encountered error:
ORA-31626: job does not exist
ORA-31633: unable to create master table "SYS.SYS_EXPORT_TABLE_08"
ORA-06512: at "SYS.DBMS_SYS_ERROR", line 95
ORA-06512: at "SYS.KUPV$FT", line 1048
ORA-01658: unable to create INITIAL extent for segment in tablespace SYSAUX
ORA-06512: at "SYS.DBMS_SWRF_INTERNAL", line 2159
ORA-31626: job does not exist

Increase the SYSAUX tablespace to resolve the issue.
Extract jobs use Data Pump to export AWR snapshot dumps. Data Pump jobs use
a master table to track a job's progress. If an error occurs during export, the master
table remains. As errors accumulate so too do master tables, eventually resulting in
the following errors:
ORA-20115: Data Pump import encountered error:
ORA-31634: job already exists
ORA-31664: unable to construct unique job name when defaulted
ORA-31634: job already exists

The solution is to drop the master tables from the previous failed jobs. Query the
dba_datapump_jobs view for jobs in the NOT RUNNING state, as follows:
SELECT job_name
FROM dba_datapump_jobs
WHERE owner_name='SYS'
 AND operation='EXPORT'
 AND job_mode='TABLE'
 AND job_name like 'SYS_EXPORT_%'
 AND state='NOT RUNNING';



       Caution:
       There may be cases where a job name the query returns is in use by an
       active Data Pump job. Ensure that there are no active Data Pump jobs to
       avoid mistakenly deleting their master tables.



The patch that enables the AWR Warehouse feature includes a fix for the legacy
master tables, so you should not encounter this problem after applying the patch.
See also the Data Pump error under AWR Warehouse Load errors for another
potential error during source database extraction.

Transfer Errors
If many dump files from a single source database are waiting to be loaded into the
AWR Warehouse and their total size exceeds a threshold value (1 GB), the following
error results:



                                                                                       10-14
                                                                                     Chapter 10
                                                Monitoring and Researching Incidents and Errors


The total size of dump files from the source database exceeds threshold value
(size: xxx MB, threshold: xxx MB)

There appears to be an underlying problem loading dump files into the AWR
Warehouse, resulting in a backlog of dump files. Check for and resolve any
outstanding load errors to enable importing to resume.
If the total size of dump files from all source databases waiting to be loaded into the
AWR Warehouse exceeds a threshold value (30 GB), the following error results:
The total size of dump files on AWR Warehouse exceeds threshold value (size: xxx
MB, threshold: xxx MB)

Determine why there is a backlog of pending dump files in the load queue. Resolving
the backlog issue will enable the load to resume.




                                                                                       10-15
Part IV
SQL Tuning
      Part IV describes how to effectively tune SQL statements and contains the following
      chapters:
      •   Identifying High-Load SQL Statements
      •   Tuning SQL Statements
      •   Optimizing Data Access Paths
11
Identifying High-Load SQL Statements
         High-load SQL statements may consume a disproportionate amount of system
         resources. These SQL statements often greatly affect database performance and must
         be tuned to optimize their performance and resource consumption. Even when a
         database is properly tuned, inefficient SQL can significantly degrade performance.
         Identifying high-load SQL statements is an important SQL tuning activity that must
         be performed regularly. Automatic Database Diagnostic Monitor (ADDM) automates
         this task by proactively identifying potential high-load SQL statements. Additionally,
         you can use Oracle Enterprise Manager Cloud Control (Cloud Control) to identify
         high-load SQL statements that require further investigation. After you have identified
         the high-load SQL statements, you can tune them with SQL Tuning Advisor and SQL
         Access Advisor.
         This chapter describes how to identify high-load SQL statements and contains the
         following sections:
         •   Identification of High-Load SQL Statements Using ADDM Findings
         •   Identifying High-Load SQL Statements Using Top SQL


Identification of High-Load SQL Statements Using ADDM
Findings
         By default, ADDM runs proactively once every hour. It analyzes key statistics gathered
         by the Automatic Workload Repository (AWR) over the last hour to identify any
         performance problems, including high-load SQL statements. When the system finds
         performance problems, it displays them as ADDM findings in the Automatic Database
         Diagnostic Monitor (ADDM) page.
         ADDM provides recommendations with each ADDM finding. When a high-load SQL
         statement is identified, ADDM gives recommendations, such as running SQL Tuning
         Advisor on the SQL statement. You can begin tuning SQL statements as described in
         Tuning SQL Statements .



                See Also:

                •   "Overview of Automatic Database Diagnostic Monitor"
                •   "Interpretation of Automatic Database Diagnostic Monitor Findings"
                •   "Implementing Automatic Database Diagnostic Monitor
                    Recommendations"




                                                                                            11-1
                                                                                           Chapter 11
                                                   Identifying High-Load SQL Statements Using Top SQL




Identifying High-Load SQL Statements Using Top SQL
         ADDM automatically identifies high-load SQL statements that may be causing system-
         wide performance degradation. Under normal circumstances, manual identification of
         high-load SQL statements is not necessary. In some cases, however, you may want to
         monitor SQL statements at a more granular level.
         The Top SQL section of the Top Activity page in Cloud Control enables you to identify
         high-load SQL statements for any 5-minute interval.
         Figure 11-1 shows an example of the Top Activity page. The page shows a 1-hour time
         line of the top activity running on the database. SQL statements that are using the
         highest percentage of database activity are listed under the Top SQL section, and are
         displayed in 5-minute intervals.


         Figure 11-1   Top Activity Page




         To access the SQL Monitoring:
         1.   From the Targets drop-down menu, select Databases.
              See "Accessing the Database Home Page" for more information.
         2.   From the Performance drop-down menu, select Performance Hub and ASH
              Analytics.
         3.   Using the drop-down menu on the right of Average Active Sessions by, select
              SQL and one of its fly-out options.
              •   SQL ID
              •   Top Level SQL ID




                                                                                               11-2
                                                                                  Chapter 11
                                          Identifying High-Load SQL Statements Using Top SQL


     •   SQL Force Matching Signature
     •   SQL Plan Hash Value
     •   SQL Full Plan Hash Value
     •   SQL Plan Operation
     •   SQL Plan Operation Line
     •   SQL Opcode
     •   Top Level SQL Opcode
4.   To move the 5-minute interval, drag the shaded box to the desired time.
     The information contained in the Top SQL section is automatically updated to
     reflect the selected time period.




                                                                                      11-3
12
Tuning SQL Statements
      A SQL statement specifies the data you want Oracle Database to retrieve. For
      example, a SQL statement can retrieve the names of employees in a department.
      When Oracle Database executes the SQL statement, the query optimizer (also called
      the optimizer) first determines the best and most efficient way to retrieve the results.
      The optimizer determines whether it is more efficient to read all data in the table, called
      a full table scan, or use an index. It compares the cost of all possible approaches and
      chooses the approach with the least cost. The access method for physically executing
      a SQL statement is called an execution plan, which the optimizer is responsible
      for generating. The determination of an execution plan is an important step in the
      processing of any SQL statement, and can greatly affect execution time.
      The query optimizer can also help you tune SQL statements. By using SQL Tuning
      Advisor and SQL Access Advisor, you can run the query optimizer in advisory mode
      to examine a SQL statement or set of statements and determine how to improve
      their efficiency. SQL Tuning Advisor and SQL Access Advisor can make various
      recommendations, such as the following:
      •   Creating SQL profiles
      •   Restructuring SQL statements
      •   Creating additional indexes or materialized views
      •   Refreshing optimizer statistics
      Additionally, Oracle Enterprise Manager Cloud Control (Cloud Control) enables you to
      accept and implement many of these recommendations easily.
      SQL Access Advisor is primarily responsible for making schema modification
      recommendations, such as adding or dropping indexes and materialized views. SQL
      Tuning Advisor makes other types of recommendations, such as creating SQL profiles
      and restructuring SQL statements. If significant performance improvements can be
      gained by creating a new index, then SQL Tuning Advisor may recommend it.
      However, such recommendations should be verified by running SQL Access Advisor
      using a SQL workload that contains a set of representative SQL statements.
      This chapter describes how to tune SQL statements using SQL Tuning Advisor and
      contains the following sections:
      •   Tuning SQL Statements Using SQL Tuning Advisor
      •   Managing SQL Tuning Sets
      •   Managing SQL Profiles
      •   Managing SQL Plan Baselines




                                                                                           12-1
                                                                                           Chapter 12
                                                       Tuning SQL Statements Using SQL Tuning Advisor




                  See Also:

                  •   "Identifying High-Load SQL Statements "
                  •   " Optimizing Data Access Paths " for information about SQL Access
                      Advisor



Tuning SQL Statements Using SQL Tuning Advisor
          You can use SQL Tuning Advisor to tune one or more SQL statements. When
          tuning multiple statements, SQL Tuning Advisor does not recognize interdependencies
          between the SQL statements. Instead, SQL Tuning Advisor provides a convenient way
          to obtain tuning advice for a large number of SQL statements.
          Oracle Database can generate SQL tuning reports automatically. Automatic SQL
          Tuning runs during system maintenance windows as an automated maintenance
          task, searching for ways to improve the execution plans of high-load SQL statements.
          A maintenance window is a contiguous time interval during which automated
          maintenance tasks are run.


Tuning SQL Manually Using SQL Tuning Advisor
          As described in Identifying High-Load SQL Statements , Automatic Database
          Diagnostic Monitor (ADDM) automatically identifies high-load SQL statements. If
          ADDM identifies such statements, then click Schedule/Run SQL Tuning Advisor on
          the Recommendation Detail page to run SQL Tuning Advisor.

          To tune SQL statements manually using SQL Tuning Advisor:
          1.   Access the Database Home page.
               See "Accessing the Database Home Page" for more information.
          2.   From the Performance menu, select Advisors Home
               If the Database Login page appears, then log in as a user with administrator
               privileges. The Advisor Central page appears.
          3.   In the Advisors section, click SQL Advisors. The SQL Advisors page appears.
          4.   In the SQL Tuning Advisor section, click SQL Tuning Advisor.
               The Schedule SQL Tuning Advisor page appears.




                                                                                               12-2
                                                                                 Chapter 12
                                             Tuning SQL Statements Using SQL Tuning Advisor




5.   In the Name field, enter a name for the SQL tuning task.
     If unspecified, then SQL Tuning Advisor uses a system-generated name.
6.   Do one of the following:
     •   To run a SQL tuning task for one or more high-load SQL statements, under
         Overview click Top Activity.
         The Top Activity page appears.
         Under Top SQL, select the SQL statement that you want to tune.
         In the Actions list, select Schedule SQL Tuning Advisor and click Go.



                See Also:
                "Identifying High-Load SQL Statements Using Top SQL" to learn how
                to identify high-load SQL statements using the Top Activity page


     •   To run a SQL tuning task for historical SQL statements from the Automatic
         Workload Repository (AWR), under Overview click Historical SQL (AWR).
         The Historical SQL (AWR) page appears.
         Under Historical SQL (AWR), click the band below the chart, and select the
         24-hour interval for which you want to view SQL statements that ran on
         the database. Under Detail for Selected 24 Hour Interval, select the SQL
         statement you want to tune, and click Schedule SQL Tuning Advisor.
     •   To run a SQL tuning task for a SQL tuning set, under Overview click SQL
         Tuning Sets.
         The SQL Tuning Sets page appears.
         Select the SQL tuning set that contains the SQL statements you want to tune
         and then click Schedule SQL Tuning Advisor.




                                                                                     12-3
                                                                                    Chapter 12
                                                Tuning SQL Statements Using SQL Tuning Advisor




                See Also:
                "Creating a SQL Tuning Set" to learn how to create SQL tuning sets


     The Schedule SQL Tuning Advisor page reappears.
7.   To display the SQL text of the selected statement, expand SQL Statements.




8.   Under Scope, select the scope of tuning to perform. Do one of the following:
     •   Select Limited.
         A limited scope takes approximately 1 second to tune each SQL statement but
         does not recommend a SQL profile.
     •   Select Comprehensive, and then set a time limit (in minutes) for each SQL
         statement in the Time Limit per Statement field, and a total time limit (in
         minutes) in the Total Time Limit field. Note that setting the time limit too small
         may affect the quality of the recommendations.
         Comprehensive mode may take several minutes to tune a single SQL
         statement. This mode is both time and resource intensive because each query
         must be hard-parsed. You should only use comprehensive scope for high-load
         SQL statements that have a significant impact on the entire system.



            See Also:
            "Managing SQL Profiles" to learn more about SQL profiles


9.   Under Schedule, do one of the following:
     •   Select Immediately and then click Submit to run the SQL tuning task
         immediately.
         The Processing: SQL Tuning Advisor Task page appears.
     •   Select Later to schedule a specific time in the future, and then click OK.
10. From the Performance menu, select Advisors Home.

     The Advisor Central page appears.
     Under Advisor Tasks, the Results sections lists the result of advisors.




                                                                                        12-4
                                                                                          Chapter 12
                                                      Tuning SQL Statements Using SQL Tuning Advisor


          11. Select a SQL Tuning Advisor type result from the table and then click View
               Result.
               The Recommendations for SQL ID page appears.




               If you used a SQL tuning set, then multiple recommendations may be shown. To
               help you decide whether to implement a recommendation, an estimated benefit
               of implementing the recommendation is displayed in the Benefit (%) column. The
               Rationale column displays an explanation of why the recommendation is made.
          12. To implement the recommendation, do one of the following:

               •   If an automated solution is recommended, then click Implement.
                   A confirmation page appears. Click Yes to confirm the change.
               •   If a manual solution is recommended, then consider implementing the
                   recommendation.


Viewing Automatic SQL Tuning Results
          By analyzing data in the Automatic Workload Repository (AWR), the database can
          identify routine maintenance tasks. The automated maintenance tasks infrastructure
          (known as AutoTask) schedules these tasks to run in maintenance windows.
          Maintenance windows are Oracle Scheduler time intervals that belong to the window
          group named MAINTENANCE_WINDOW_GROUP. By default, one window is scheduled for
          each day of the week. You can customize attributes of these maintenance windows,
          including start and end times, frequency, and days of the week.
          By default, AutoTask runs the following automated maintenance tasks in all
          maintenance windows:
          •    Optimizer Statistics Collection
          •    Segment Advisor
          •    SQL Tuning Advisor
          You can view the results of automated execution of SQL Tuning Advisor on observed
          high-load SQL statements.

          To view automatic SQL tuning results:
          1.   Access the Database Home page.
               See "Accessing the Database Home Page" for more information.




                                                                                              12-5
                                                                                   Chapter 12
                                               Tuning SQL Statements Using SQL Tuning Advisor


2.   From the Performance page, select Advisors Home.
     If the Database Login page appears, then log in as a user with administrator
     privileges. The Advisor Central page appears.
3.   Under Advisors, click SQL Advisors.
     The SQL Advisors page appears.
4.   Under SQL Tuning Advisor, click Automatic SQL Tuning Results.
     The Automatic SQL Tuning Result Summary page appears.
     The top half of the page includes sections for the status and activity summary of
     the SQL Tuning task.




5.   In the Time Period list, select All and then click Go.
     The Overall Task Statistics and Profile Effect Statistics sections are refreshed.




6.   Optionally, in the Task Status section, click Configure to change the attributes of
     the Automatic SQL Tuning task.



                                                                                         12-6
                                                                                 Chapter 12
                                             Tuning SQL Statements Using SQL Tuning Advisor


     The Automated Maintenance Tasks Configuration page appears.
     In this page, you can enable or disable the Automatic SQL Tuning task and specify
     which days it should run. Click Apply or Revert to return to the previous page.
7.   In the Task Activity Summary section, leave All selected for the Time Period and
     then click View Report.
     The Automatic SQL Tuning Result Details page appears.
     The page lists SQL statements that have been automatically selected by the
     database as candidates for SQL tuning.




8.   Under Recommendations, select a SQL statement and then click View
     Recommendations.
     The Recommendations for SQL ID page appears.




     This page can include recommendations for SQL profiles and indexes.



                                                                                     12-7
                                                                                        Chapter 12
                                                                         Managing SQL Tuning Sets




                   See Also:
                   "Tuning SQL Manually Using SQL Tuning Advisor" to learn how to
                   implement recommendations made by SQL Tuning Advisor



Managing SQL Tuning Sets
        A SQL tuning set is a database object that includes one or more SQL statements and
        their execution statistics and context. You can use the set as an input for advisors such
        as SQL Tuning Advisor, SQL Access Advisor, and SQL Performance Analyzer. You
        can load SQL statements into a SQL tuning set from different SQL sources, such as
        AWR, the cursor cache, or high-load SQL statements that you identify.
        A SQL tuning set includes the following:
        •   A set of SQL statements
        •   Associated execution context such as:
            –   User schema
            –   Application module name and action
            –   List of bind values
            –   Cursor compilation environment
        •   Associated basic execution statistics such as:
            –   Elapsed time and CPU time
            –   Buffer gets
            –   Disk reads
            –   Rows processed
            –   Cursor fetches
            –   Number of executions and number of complete executions
            –   Optimizer cost
            –   Command type
        •   Associated execution plans and row source statistics for each SQL statement
            (optional)
        SQL statements can be filtered using the application module name and action, or any
        of the execution statistics. In addition, SQL statements can be ranked based on any
        combination of execution statistics.
        SQL tuning sets are transportable, enabling SQL workloads to be transferred between
        databases for remote performance diagnostics and tuning. When high-load SQL
        statements are identified on a production system, it may not be desirable to perform
        investigation and tuning activities directly on this system. This feature enables you to
        transport the high-load SQL statements to a test system, where they can be safely
        analyzed and tuned.




                                                                                           12-8
                                                                                              Chapter 12
                                                                               Managing SQL Tuning Sets




                     See Also:
                     Oracle Database SQL Tuning Guide for more information about transporting
                     SQL tuning sets between databases



            Using Cloud Control, you can manage SQL tuning sets by doing the following:
            •    Creating a SQL Tuning Set
            •    Dropping a SQL Tuning Set
            •    Transporting SQL Tuning Sets


Creating a SQL Tuning Set
            This section describes how to create a SQL tuning set with Cloud Control.

            To create a SQL tuning set:
            1.   Specify the initial options for the SQL tuning set, as described in "Creating a SQL
                 Tuning Set: Options".
            2.   Select the load method to use for collecting and loading SQL statements into the
                 SQL tuning set, as described in "Creating a SQL Tuning Set: Load Methods".
            3.   Specify the filter options for the SQL tuning set, as described in "Creating a SQL
                 Tuning Set: Filter Options".
            4.   Schedule and submit a job to collect the SQL statements and load them into the
                 SQL tuning set, as described in "Creating a SQL Tuning Set: Schedule".

Creating a SQL Tuning Set: Options
            The first step in creating a SQL tuning set is to specify options for the set such as
            name, owner, and description.

            To specify options for creating a SQL tuning set:
            1.   Access the Database Home page.
                 See "Accessing the Database Home Page" for more information.
            2.   From the Performance menu, select SQL, and then SQL Tuning Sets.
                 If the Database Login page appears, then log in as a user with administrator
                 privileges. The SQL Tuning Sets page appears.
            3.   Click Create.
                 The Create SQL Tuning Set: Options page appears.
            4.   Enter the following details:
                 •   In SQL Tuning Set Name, enter a name for the SQL tuning set.
                 •   In Owner, enter the owner of the SQL tuning set.
                 •   In Description, enter a description of the SQL tuning set.




                                                                                                    12-9
                                                                                              Chapter 12
                                                                               Managing SQL Tuning Sets


              5.   Optionally, to create an empty SQL tuning set and add SQL statements to it at a
                   later time, complete the following steps:
                   a.   Select Create an empty SQL tuning set.
                   b.   Click Next.
                        The Create SQL Tuning Set: Review page appears.
                   c.   Review your SQL tuning set options and click Submit.
                        The empty SQL tuning set is created. You can add SQL statements to it later.
              6.   Click Next.
                   The Create SQL Tuning Set: Load Methods page appears.




              7.   Proceed to the next step, as described in "Creating a SQL Tuning Set: Load
                   Methods".

Creating a SQL Tuning Set: Load Methods
              After options are specified for the SQL tuning set, select the load method to use for
              collecting and loading SQL statements into the SQL tuning set, as described in the
              following sections:
              •    Loading Active SQL Statements Incrementally from the Cursor Cache
              •    Loading SQL Statements from the Cursor Cache
              •    Loading SQL Statements from AWR Snapshots
              •    Loading SQL Statements from AWR Baselines
              •    Loading SQL Statements from a User-Defined Workload

Loading Active SQL Statements Incrementally from the Cursor Cache
              You can load active SQL statements from the cursor cache into the SQL tuning set
              incrementally over a specified period of time. This technique enables you to not only
              collect current and recent SQL statements stored in the SQL cache, but also SQL
              statements that run during a specified time period in the future.




                                                                                                12-10
                                                                                              Chapter 12
                                                                              Managing SQL Tuning Sets




             To load active SQL statements incrementally from the cursor cache:
             1.   Access the Create SQL Tuning Set: Load Methods page, as explained in "Creating
                  a SQL Tuning Set: Options".
             2.   Select Incrementally capture active SQL statements over a period of time
                  from the cursor cache.
             3.   In the Duration field, specify how long to capture active SQL statements.
             4.   In the Frequency field, specify how often to capture active SQL statements during
                  the specified duration.
             5.   Click Next.
                  The Create SQL Tuning Set: Filter Options page appears.
             6.   Proceed to the next step, as described in "Creating a SQL Tuning Set: Filter
                  Options".

Loading SQL Statements from the Cursor Cache
             You can load SQL statements from the cursor cache into the SQL tuning set. However,
             because only current and recent SQL statements are in the SQL cache, collecting
             these statements only once may result in a SQL tuning set this is not representative of
             the entire database workload.

             To load SQL statements from the cursor cache:
             1.   Access the Create SQL Tuning Set: Load Methods page, as explained in "Creating
                  a SQL Tuning Set: Options".
             2.   Select Load SQL statements one time only.
             3.   From the Data Source list, select Cursor Cache.
             4.   Click Next.
                  The Create SQL Tuning Set: Filter Options page is shown.
             5.   Proceed to the next step, as described in "Creating a SQL Tuning Set: Filter
                  Options".

Loading SQL Statements from AWR Snapshots
             You can load SQL statements captured in AWR snapshots. This is useful when you
             want to collect SQL statements for specific snapshot periods of interest that can be
             used for later comparison or tuning purposes.

             To load SQL statements from AWR snapshots:
             1.   Access the Create SQL Tuning Set: Load Methods page, as explained in "Creating
                  a SQL Tuning Set: Options".
             2.   Select Load statements one time only.
             3.   In the Data Source list, select AWR Snapshots.
             4.   In the AWR Snapshots field, select the snapshots to include. Do one of the
                  following:




                                                                                                 12-11
                                                                                             Chapter 12
                                                                              Managing SQL Tuning Sets


                  •    Select either ALL or a time period such as Last 24 hours and then go to Step
                       6.
                       Only snapshots that are captured and stored in AWR in the specified time are
                       included.
                  •    Select Customize and then go to Step 5.
                       Only snapshots that are captured and stored in AWR during a customized time
                       period that you specify are included.
             5.   To select a customized time period of snapshots, complete the following steps:
                  a.   Select Customize and then click Go.
                       The Select Time Period window opens.
                  b.   For the starting snapshot, select Period Start Time and then click the
                       snapshot icon below the Active Session graph that corresponds to the desired
                       start time.
                  c.   For the ending snapshot, select Period End Time and then click the snapshot
                       icon below the Active Session graph that corresponds to the desired end time.
                  d.   Click Select.
                  In this example, the snapshot taken on December 27, 2011 at 9:00 a.m. is
                  selected as the start time, and the snapshot taken on December 27, 2011 at 11:00
                  a.m. is selected as the end time.




             6.   Click Next.
                  The Create SQL Tuning Set: Filter Options page is shown.
             7.   Proceed to the next step, as described in "Creating a SQL Tuning Set: Filter
                  Options".

Loading SQL Statements from AWR Baselines
             You can load SQL statements captured in AWR baselines. This technique is useful
             when you want to collect SQL statements that are representative of a time period
             during known performance levels that can be used for later comparison or tuning
             purposes.

             To load SQL statements from AWR baselines:
             1.   Access the Create SQL Tuning Set: Load Methods page, as explained in "Creating
                  a SQL Tuning Set: Options".
             2.   Select Load SQL statements one time only.




                                                                                                 12-12
                                                                                              Chapter 12
                                                                               Managing SQL Tuning Sets


             3.   In the Data Source field, select AWR Baseline.
             4.   In the AWR Baseline field, select the baseline to include.




             5.   Click Next.
                  The Create SQL Tuning Set: Filter Options page is shown.
             6.   Proceed to the next step, as described in "Creating a SQL Tuning Set: Filter
                  Options".

Loading SQL Statements from a User-Defined Workload
             You can load SQL statements by importing from a table or view. This technique is
             useful if the workload you want to analyze is not currently running on the database or
             captured in an existing AWR snapshot or AWR baseline.
             There are no restrictions on which schema the workload resides in, the name of the
             table, or the number of tables that you can define. The only requirement is that the
             format of the table must match format of the USER_WORKLOAD table.

             To load SQL statements from a user-defined workload:
             1.   Access the Create SQL Tuning Set: Load Methods page, as explained in "Creating
                  a SQL Tuning Set: Options".
             2.   Select Load statements one time only.
             3.   In the Data Source field, select User-Defined Workload.
             4.   In the User-Defined Workload field, select the table or view to include.




             5.   Click Next.
                  The Create SQL Tuning Set: Filter Options page appears.
             6.   Proceed to the next step, as described in "Creating a SQL Tuning Set: Filter
                  Options".

Creating a SQL Tuning Set: Filter Options
             After the load method is selected, you can apply filters to reduce the scope of the SQL
             statements found in the SQL tuning set. While using filters is optional, it can be very
             beneficial due to the following:
             •    Using filters directs the various advisors that use the SQL tuning set as a
                  workload source, such as SQL Tuning Advisor, SQL Access Advisor, and SQL



                                                                                                 12-13
                                                                                                Chapter 12
                                                                                Managing SQL Tuning Sets


                 Performance Analyzer, to make recommendations based on a specific subset of
                 SQL statements, which may lead to better recommendations.
            •    Using filters removes extraneous SQL statements from the SQL tuning set, which
                 may greatly reduce processing time when it is used as a workload source for the
                 various advisors.

            To specify filter options for a SQL tuning set:
            1.   Create a SQL tuning set and specify the initial options, as described in "Creating a
                 SQL Tuning Set: Options".
            2.   Select the load method, as described in "Creating a SQL Tuning Set: Load
                 Methods".
            3.   On the Create SQL Tuning Set: Filter Options page, specify the values of filter
                 conditions that you want use in the search in the Value column, and an operator or
                 a condition in the Operator column.
                 Only the SQL statements that meet all of the specified filter conditions are added
                 to the SQL tuning set. Unspecified filter values are not included as filter conditions
                 in the search.
                 By default, the following filter conditions are displayed:
                 •   Parsing Schema Name
                 •   SQL Text
                 •   SQL ID
                 •   Elapsed Time (sec)
            4.   To add filter conditions, under Filter Conditions, select the filter condition you want
                 to add and click Add a Filter or Column.
                 After the desired filter conditions have been added, specify their values in the
                 Value column, and an operator or a condition in the Operator column.
            5.   To remove any unused filter conditions, click the icon in the Remove column for
                 the corresponding filter condition you want to remove.
            6.   Click Next.
                 The Create SQL Tuning Set: Schedule page appears.
            7.   Proceed to the next step, as described in "Creating a SQL Tuning Set: Schedule".

Creating a SQL Tuning Set: Schedule
            After the filter options are specified for the SQL tuning set, you can schedule and
            submit a job to collect the SQL statements and load them into the SQL tuning set.

            To schedule and submit a job to create a SQL tuning set:
            1.   Create a SQL Tuning Set and specify the initial options, as described in "Creating
                 a SQL Tuning Set: Options".
            2.   Select the load method, as described in "Creating a SQL Tuning Set: Load
                 Methods".
            3.   Specify the filter options, as described in "Creating a SQL Tuning Set: Filter
                 Options".




                                                                                                  12-14
                                                                                 Chapter 12
                                                                  Managing SQL Tuning Sets


4.   On the Create SQL Tuning Set: Schedule page, under Job Parameters, enter a
     name in the Job Name field if you do not want to use the system-generated job
     name.
5.   In the Description field, enter a description of the job.
6.   Under Schedule, do one of the following:
     •   Immediately to run the job immediately after it has been submitted
     •   Later to run the job at a later time as specified using the Time Zone, Date, and
         Time fields




7.   Click Next.
     The Create SQL Tuning Set: Review page appears.




8.   Review the SQL Tuning Set options that you have selected.
     To view the SQL statements used by the job, expand Show SQL.
9.   Click Submit.
     The SQL Tuning Sets page appears.
     If the job was scheduled to run immediately, then a message is displayed to inform
     you that the job and the SQL tuning set were created successfully. If the job was




                                                                                   12-15
                                                                                              Chapter 12
                                                                               Managing SQL Tuning Sets


                 scheduled to run at a later time, a message is displayed to inform you that the job
                 was created successfully.
            10. To view details about the job, such as operation status, click View Job Details.

                 The View Job page appears to display details about the job.


Dropping a SQL Tuning Set
            This section describes how to drop a SQL tuning set. To conserve storage space, you
            may want to periodically drop unused SQL tuning sets stored in the database.

            To drop a SQL tuning set:
            1.   Access the Database Home page.
                 See "Accessing the Database Home Page" for more information.
            2.   From the Performance menu, select SQL, and then SQL Tuning Sets.
                 If the Database Login page appears, then log in as a user with administrator
                 privileges. The SQL Tuning Sets page appears.
            3.   Select the SQL tuning set you want to drop and then click Drop.
                 The Confirmation page appears to verify that you want to drop the selected SQL
                 tuning set.
            4.   Click Yes.
                 The SQL Tuning Sets page appears.
                 A confirmation message is displayed to indicate that the SQL tuning set was
                 successfully dropped.


Transporting SQL Tuning Sets
            You can transport SQL tuning sets from one system to another by first exporting a SQL
            tuning set from one database, and then importing it into another database.
            This section contains the following topics:
            •    Exporting a SQL Tuning Set
            •    Importing a SQL Tuning Set

Exporting a SQL Tuning Set
            This section describes how to export a SQL tuning set, enabling it to be transported to
            another system.

            To export a SQL tuning set:
            1.   Access the Database Home page.
                 See "Accessing the Database Home Page" for more information.
            2.   From the Performance menu, select SQL, then SQL Tuning Sets.
                 If the Database Login page appears, then log in as a user with administrator
                 privileges. The SQL Tuning Sets page appears.
            3.   Select the SQL tuning set that you want to export and then click Export To A File.



                                                                                                12-16
                                                                                      Chapter 12
                                                                     Managing SQL Tuning Sets


     The Export SQL Tuning Set page appears.




4.   In the Directory Object field, select a directory in which to create the export file.
     For example, to use the Oracle Data Pump directory, select DATA_PUMP_DIR.
     The Directory Name field refreshes automatically to indicate the selected directory.
5.   In the Export File field, enter a name for the file.
     Alternatively, you can accept the name generated by the database.
6.   In the Log File field, enter a name for the log file for the export operation.
     Alternatively, you can accept the name generated by the database.
7.   Select a tablespace to temporarily store the data for the export operation.
     By default, SYSAUX is used.
8.   Under Job Parameters, in the Job Name field, enter a name for the job.
     Alternatively, you can accept the name generated by the database.
     Optionally, in the Description field, enter a description of the tuning set.
9.   Under Schedule, do one of the following:



                                                                                        12-17
                                                                                                  Chapter 12
                                                                                 Managing SQL Tuning Sets


                 •   Select Immediately to run the job immediately after it has been submitted.
                 •   Select Later to run the job at a later time as specified by selecting or entering
                     values in the Time Zone, Date, and Time fields.
            10. Click OK.
                 The SQL Tuning Sets page appears.
                 A confirmation message indicates that the job was created successfully.
            11. Transport the export file to another system using the mechanism of choice, such
                 as Oracle Data Pump or a database link.

Importing a SQL Tuning Set
            Before a SQL tuning set can be imported, you must first export a SQL tuning set from
            another system and transport it to your current system.



                     See Also:
                     "Exporting a SQL Tuning Set" for more information



            To import a SQL tuning set:
            1.   Access the Database Home page.
                 See "Accessing the Database Home Page" for more information.
            2.   From the Performance menu, select SQL, then SQL Tuning Sets.
                 If the Database Login page appears, then log in as a user with administrator
                 privileges. The SQL Tuning Sets page appears.
            3.   Click Import From A File.
                 The Import SQL Tuning Set page appears.
            4.   In Directory Object, select the directory containing the file to be imported.
                 The directory should contain the export file that was transported to your current
                 system. For example, if the file resides in the Data Pump directory, then select
                 DATA_PUMP_DIR. The Directory Name field refreshes automatically to indicate the
                 selected directory.
            5.   In the Import File field, enter the name of the dump file to import.
            6.   In the Log File field, enter a name for the log file for the import operation.
            7.   To replace an existing SQL tuning set with the one that you are importing, select
                 Replace the existing SQL tuning set if one exists.
            8.   Select a tablespace to temporarily store the data for the import operation.
                 By default, SYSAUX is used.
            9.   Under Job Parameters, in the Job Name field, enter a name for the job.
                 Alternatively, you can accept the name generated by the system.
                 Optionally, in the Description field, enter a description of the tuning set.
            10. Under Schedule, do one of the following:




                                                                                                    12-18
                                                                                           Chapter 12
                                                                                Managing SQL Profiles


              •   Select Immediately to run the job immediately after it has been submitted.
              •   Select Later to run the job at a later time as specified by selecting or entering
                  values in the Time Zone, Date, and Time fields.
         11. Click OK.
              The SQL Tuning Sets page appears.
              A confirmation message appears that indicates that the job was successfully
              created. If the job is scheduled to run immediately, then the imported SQL tuning
              set is shown on this page. You may need to refresh to see the SQL tuning set.


Managing SQL Profiles
         A SQL profile is a set of auxiliary information that is built during automatic tuning of a
         SQL statement. A SQL profile is to a SQL statement what statistics are to a table.
         When running a SQL Tuning Advisor task with a limited scope, the optimizer makes
         estimates about cardinality, selectivity, and cost that are sometimes significantly off,
         resulting in poor execution plans. To address this problem, consider running a SQL
         Tuning Advisor task with a comprehensive scope to collect additional information using
         sampling and partial execution techniques into a SQL profile. The database can use
         the profile to verify and, if necessary, adjust optimizer estimates.
         During SQL profiling, the optimizer uses the execution history of the SQL statement
         to create appropriate settings for optimizer parameters. After SQL profiling completes,
         the optimizer uses the information in the SQL profile and regular database statistics to
         generate execution plans. The additional information enables the database to produce
         well-tuned plans for corresponding SQL statements.
         After running a SQL Tuning Advisor task with a comprehensive scope, a SQL profile
         may be recommended. If you accept the recommendation, then the database creates
         the SQL profile and enables it for the SQL statement.
         In some cases, you may want to disable a SQL profile. For example, you may want
         to test the performance of a SQL statement without using a SQL profile to determine
         if the SQL profile is actually beneficial. If the SQL statement is performing poorly after
         the SQL profile is disabled, then you should enable it again to avoid performance
         degradation. If the SQL statement is performing optimally after you have disabled the
         SQL profile, then you may want to remove the SQL profile from your database.

         To enable, disable, or delete a SQL profile:
         1.   Access the Database Home page.
              See "Accessing the Database Home Page" for more information.
         2.   From the Performance menu, select Top Activity.
              If the Database Login page appears, then log in as a user with administrator
              privileges. The Top Activity page appears.
         3.   Under Top SQL, click the SQL ID link of the SQL statement that is using a SQL
              profile.
              The SQL Details page appears.
         4.   Click the Plan Control tab.
              A list of SQL profiles is displayed under SQL Profiles and Outlines.




                                                                                             12-19
                                                                                              Chapter 12
                                                                            Managing SQL Plan Baselines


         5.   Select the SQL profile you want to manage. Do one of the following:
              •       To enable a SQL profile that is disabled, click Disable/Enable.
              •       To disable a SQL profile that is enabled, click Disable/Enable.
              •       To remove a SQL profile, click Delete.
              A confirmation page appears.
         6.   Click Yes to continue, or No to cancel the action.



                  See Also:
                  Oracle Database SQL Tuning Guide to learn how to manage SQL profiles
                  using an API




Managing SQL Plan Baselines
         SQL plan management is a preventative mechanism that enables the optimizer to
         automatically manage execution plans, ensuring that the database uses only known
         or verified plans. In this context, a plan includes all plan-related information that the
         optimizer needs to reproduce an execution plan.
         SQL plan management uses SQL plan baselines. A SQL plan baseline is a set of
         accepted plans that the optimizer is allowed to use for a SQL statement. In the typical
         use case, a plan is accepted into the SQL plan baseline only after the database
         verifies that the plan performs well.
         SQL plan management avoids SQL performance regression caused by plan changes.
         Events such as new optimizer statistics, changes to initialization parameters, database
         upgrades, and so on can cause changes to execution plans. These changes can
         cause SQL performance regressions that are difficult and time-consuming to fix
         manually. SQL plan baselines preserve performance of SQL statements, regardless of
         changes in the database. SQL plan management adapts to such changes by verifying
         and accepting only plan changes that improve performance.
         Capturing a SQL plan automatically or loading a plan manually makes SQL plan
         management aware of the plan. Evolving a plan is the process by which the optimizer
         verifies new plans and adds them to an existing SQL plan baseline. This section
         contains the following topics:
         •    Capturing SQL Plan Baselines Automatically
         •    Loading SQL Plan Baselines Manually
         •    Evolving SQL Plans



                  See Also:

                  •      Oracle Database SQL Tuning Guide for more information on SQL plan
                         management and on controlling it with APIs




                                                                                                12-20
                                                                                           Chapter 12
                                                                         Managing SQL Plan Baselines




Capturing SQL Plan Baselines Automatically
           You can specify that Oracle Database captures SQL plan baselines automatically.

           To capture SQL plan baselines automatically:
           1.   Access the Database Home page.
                See "Accessing the Database Home Page" for more information.
           2.   Select Performance, then SQL, and then SQL Plan Control.
                If the Database Login page appears, then log in as a user with administrator
                privileges. The SQL Profile subpage of the SQL Plan Control page appears.
           3.   Click SQL Plan Baseline.
                The SQL Plan Baseline subpage appears.




           4.   Under Settings, click the link next to Capture SQL Plan Baselines.
                The Initialization Parameters page appears.
           5.   In the Value column of the table, select TRUE and then click OK.
                You are returned to the SQL Plan Baseline subpage, which now shows Capture
                SQL Baselines set to TRUE.
                Because you configured baselines to be automatically captured, the database will
                create a SQL plan baseline for all SQL statements executed more than once and
                adds the current execution plan for the statement to the SQL plan baseline as the
                first accepted plan.


Loading SQL Plan Baselines Manually
           You can manually load existing plans into a SQL plan baseline. You can load plans
           from a SQL tuning set (STS) or you can load selected plans from the cursor cache.
           To load SQL execution plans manually, the Capture SQL Baselines setting must be
           FALSE.

           To manually load SQL execution plans:
           1.   Access the Database Home page.
           2.   Select Performance, then SQL, and then SQL Plan Control.
                The SQL Profile subpage of the SQL Plan Control page appears.



                                                                                               12-21
                                                                                 Chapter 12
                                                               Managing SQL Plan Baselines


3.   Click SQL Plan Baseline.
     The SQL Plan Baseline subpage appears.
4.   Click Load.
     The SQL Plan Control page appears.




5.   Select the SQL plan baselines to be loaded by completing the following steps:
     a.   Under Load SQL Plan Baselines, select Load plans from SQL Tuning Set
          (STS).
          In this example, load plans from the SQL tuning set that you created in
          "Creating a SQL Tuning Set".
     b.   In Job Name, enter a name for the job. For example, enter SPM_LOAD_TEST.
     c.   Under Schedule, select Immediately.
     d.   Click OK.
     The SQL Plan Control page reappears.
     The table displays a list of SQL plans that are stored as SQL plan baselines.




                                                                                     12-22
                                                                                                  Chapter 12
                                                                              Managing SQL Plan Baselines




          6.   Optionally, fix the execution plan of a baseline to prevent the database from using
               an alternative SQL plan baseline. Complete the following steps:
               a.       Select a SQL plan baseline that is not fixed.
               b.       Select Fixed - Yes from the list preceding the baseline table.
               c.       Click Go.
               The table is refreshed to show the SQL execution plan with the value YES in the
               Fixed column of the table.



                    See Also:

                    •      Cloud Control context-sensitive online help to learn about the other
                           options on the SQL Plan Baseline subpage



Evolving SQL Plans
          A SQL plan baseline for a SQL statement usually starts with a single accepted
          plan. However, some SQL statements perform well when executed with different
          plans under different conditions. For example, a SQL statement with bind variables
          whose values result in different selectivities may have several good plans. Creating a
          materialized view or an index or repartitioning a table may make current plans more
          expensive than other plans.
          If new plans were never added to SQL plan baselines, then the performance of some
          SQL statements might degrade. Thus, it is sometimes necessary to evolve newly
          found plans to see if they should be added to SQL plan baselines. Plan evolution
          prevents performance regressions by verifying the performance of a new plan before
          including it in a SQL plan baseline.
          Plan evolution consists of the following distinct steps:
          1.   Verifying that unaccepted plans perform at least as well as accepted plans in a
               SQL plan baseline.
          2.   Adding unaccepted plans in the plan history to the plan baseline as accepted
               plans when they have been proven to perform as well as previously accepted
               plans.
          You can evolve a plan manually or you can use the SQL Plan Management (SPM)
          Evolve Advisor.
          By default, the SPM Evolve Advisor runs daily in the scheduled maintenance window.
          It ranks all unaccepted plans, and then performs test executions of as many plans as
          possible during the window. The evolve advisor selects the lowest-cost accepted plan



                                                                                                    12-23
                                                                                       Chapter 12
                                                                     Managing SQL Plan Baselines


in the SQL plan baseline to compare against each unaccepted plan. If a plan performs
sufficiently better than the existing accepted plan, then the database automatically
accepts it.



         See Also:

         •       Oracle Database SQL Tuning Guide for more information on configuring
                 SPM Evolve Advisor and on running it manually by using APIs


To evolve plans manually:
1.   Access the Database Home page.
     See "Accessing the Database Home Page" for more information.
2.   Select Performance, then SQL, and then SQL Plan Control.
     If the Database Login page appears, then log in as a user with administrator
     privileges. The SQL Profile subpage of the SQL Plan Control page appears.
3.   Click SQL Plan Baseline.
     The SQL Plan Baseline subpage appears.
4.   In the table, select one or more SQL plans that have No in the Accepted column
     and then click Evolve.
     The Evolve SQL Plan Baselines page appears.
5.   Specify the options to perform.
     •       For Verify Performance, select one of the following:
             –   Select Yes to have the database verify that the plan performs as good as
                 or better than the current baseline plan.
             –   Select No to automatically evolve the plan regardless of how it performs.
     •       For Time Limit, select one of the following:
             –   Auto to have the database determine how long to spend verifying the
                 performance of the unaccepted plan.
             –   Unlimited to run the verification to completion regardless of how long it
                 takes.
             –   Specify to specify a time limit for the verification process. Enter a value in
                 minutes in the associated field.
     •       For Action, select one of the following:
             –   Report and Accept to have the database accept the plan and create a
                 report.
             –   Report Only to have the database create a report but not accept the plan.
     Click OK to implement the options.
     A report appears. After viewing the report, click Return to return to the SQL Plan
     Baseline subpage.




                                                                                         12-24
13
Optimizing Data Access Paths
        To achieve optimal performance for data-intensive queries, materialized views and
        indexes are essential for SQL statements. However, implementing these objects
        does not come without cost. Creation and maintenance of these objects can be time-
        consuming. Space requirements can be significant. SQL Access Advisor enables you
        to optimize query access paths by recommending materialized views and view logs,
        indexes, SQL profiles, and partitions for a specific workload.
        A materialized view provides access to table data by storing query results in a
        separate schema object. Unlike an ordinary view, which does not take up storage
        space or contain data, a materialized view contains the rows from a query of one
        or more base tables or views. A materialized view log is a schema object that
        records changes to a master table's data, so that a materialized view defined on the
        master table can be refreshed incrementally. SQL Access Advisor recommends how to
        optimize materialized views so that they can be rapidly refreshed and make use of the
        query rewrite feature.
        SQL Access Advisor also recommends bitmap, function-based, and B-tree indexes. A
        bitmap index reduces response time for many types of ad hoc queries and can also
        reduce storage space compared to other indexes. A function-based index computes
        the value of a function or expression involving one or more columns and stores it in the
        index. B-tree indexes are commonly used to index unique or near-unique keys.
        Using SQL Access Advisor involves the following tasks:
        •    Running SQL Access Advisor
        •    Reviewing the SQL Access Advisor Recommendations
        •    Implementing the SQL Access Advisor Recommendations



                See Also:

                •   "Identifying High-Load SQL Statements "
                •   "Tuning SQL Statements " for information about SQL Tuning Advisor
                •   Oracle Database Concepts to learn about materialized views
                •   Oracle Database Concepts to learn about indexes



Running SQL Access Advisor
        This section describes how to run SQL Access Advisor to make recommendations for
        a SQL workload.

        To run SQL Access Advisor:
        1.   Select the initial options, as described in "Selecting the Initial Options".



                                                                                            13-1
                                                                                               Chapter 13
                                                                              Running SQL Access Advisor


            2.   Select the workload source you want to use for the analysis, as described in
                 "Selecting the Workload Source".
            3.   Define the filters options, as described in "Applying Filter Options".
            4.   Choose the types of recommendations, as described in "Specifying
                 Recommendation Options".
            5.   Schedule the SQL Access Advisor task, as described in "Specifying Task and
                 Scheduling Options".


Selecting the Initial Options
            The first step in running SQL Access Advisor is to select the initial options on the SQL
            Access Advisor: Initial Options page.

            To select initial options:
            1.   Access the Database Home page.
                 See "Accessing the Database Home Page" for more information.
            2.   From the Performance menu, select Advisors Home.
                 If the Database Login page appears, then log in as a user with administrator
                 privileges. The Advisor Central page appears.
            3.   Click SQL Advisors.
                 The SQL Advisors page appears.
            4.   Click SQL Access Advisor.
                 The SQL Access Advisor: Initial Options page appears.
            5.   Do one of the following:
                 •   Select Verify use of access structures (indexes, materialized views,
                     partitioning, and so on) only to verify existing structures.
                 •   Select Recommend new access structures to use the recommended
                     options defined in the Oracle Enterprise Manager Cloud Control (Cloud
                     Control) default template.
                     If you select this option, then you can optionally complete the following steps:
                     –   Select Inherit Options from a previously saved Task or Template to
                         use the options defined in an existing SQL Access Advisor task or another
                         template.
                     –   In Tasks and Templates, select the task or template that you want to use.
                 In this example, Recommend new access structures is selected.




                                                                                                  13-2
                                                                                                 Chapter 13
                                                                                Running SQL Access Advisor




            6.   Click Continue.
                 The SQL Access Advisor: Workload Source page appears.
            7.   Proceed to the next step, as described in "Selecting the Workload Source".


Selecting the Workload Source
            After initial options are specified for SQL Access Advisor, select the workload source
            that you want to use for the analysis, as described in the following sections:
            •    Using SQL Statements from the Cache
            •    Using an Existing SQL Tuning Set
            •    Using a Hypothetical Workload

Using SQL Statements from the Cache
            You can use SQL statements from the cache as the workload source. However, only
            current and recent SQL statements are stored in the SQL cache, so this workload
            source may not be representative of the entire workload on your database.

            To use SQL statements from the cache as the workload source:
            1.   Select the initial options, as described in "Selecting the Initial Options".
            2.   On the SQL Access Advisor: Workload Source page, select Current and Recent
                 SQL Activity.




                                                                                                    13-3
                                                                                                 Chapter 13
                                                                                Running SQL Access Advisor




            3.   Proceed to the next step, as described in "Applying Filter Options".

Using an Existing SQL Tuning Set
            You can use an existing SQL tuning set as the workload source. This option is useful
            because SQL tuning sets can be used repeatedly as the workload source for SQL
            Access Advisor and SQL Tuning Advisor.

            To use a SQL tuning set as the workload source:
            1.   Select the initial options, as described in "Selecting the Initial Options".
            2.   On the SQL Access Advisor: Workload Source page, select Use an existing SQL
                 Tuning Set.
            3.   Click the SQL Tuning Set search icon to use an existing SQL tuning set.
                 The Search and Select: SQL Tuning Set dialog box appears.
            4.   In the Schema field, enter the name of the schema containing the SQL tuning set
                 you want to use and then click Go.
                 A list of SQL tuning sets contained in the selected schema appears.
            5.   Select the SQL tuning set to be used for the workload source and click Select.
                 The Search and Select: SQL Tuning Set dialog box closes and the selected SQL
                 Tuning Set now appears in the SQL Tuning Set field.
            6.   Proceed to the next step, as described in "Applying Filter Options".



                    See Also:

                    •   "Managing SQL Tuning Sets"



Using a Hypothetical Workload
            A dimension table stores all or part of the values for a logical dimension in a star
            or snowflake schema. You can create a hypothetical workload from dimension tables
            containing primary or foreign key constraints. This option is useful if the workload
            to be analyzed does not exist. In this case, SQL Access Advisor examines the



                                                                                                    13-4
                                                                                                 Chapter 13
                                                                                Running SQL Access Advisor


            current logical schema design, and provides recommendations based on the defined
            relationships between tables.

            To use a hypothetical workload as the workload source:
            1.   Select the initial options, as described in "Selecting the Initial Options".
            2.   On the SQL Access Advisor: Workload Source page, select Create a
                 Hypothetical Workload from the Following Schemas and Tables.
            3.   Leave Schemas and Tables empty and then click Add to search for tables.
                 The Workload Source: Search and Select Schemas and Tables page appears.
            4.   In the Tables section, enter a schema name in the Schema field and then click
                 Search.
                 A list of tables in the selected schema is displayed.
            5.   Select the tables to be used in creating the hypothetical workload and then click
                 Add Tables.
                 The selected tables now appear in the Schemas and Tables field.
            6.   Click OK.
                 The SQL Access Advisor: Workload Source page appears with the selected tables
                 now added.
            7.   Proceed to the next step, as described in "Applying Filter Options".



                    See Also:

                    •   Oracle Database Concepts for an overview of materialized views



Applying Filter Options
            After the workload source is selected, you can optionally apply filters to reduce the
            scope of the SQL statements found in the workload. Filters are beneficial for the
            following reasons:
            •    Using filters directs SQL Access Advisor to make recommendations based on a
                 specific subset of SQL statements from the workload, which may lead to better
                 recommendations.
            •    Using filters removes extraneous SQL statements from the workload, which may
                 greatly reduce processing time.

            To apply filters to the workload source:
            1.   Select initial options, as described in "Selecting the Initial Options".
            2.   Select the workload source, as described in "Selecting the Workload Source".
            3.   On the SQL Access Advisor: Workload Source page, click Filter Options.
                 The Filter Options section expands.
            4.   Select Filter Workload Based on these Options.
                 The Filter Options section is enabled.



                                                                                                    13-5
                                                                                                   Chapter 13
                                                                                 Running SQL Access Advisor


              5.   Define the filters you want to apply, as described in the following sections:
                   •   Defining Filters for Resource Consumption
                   •   Defining Filters for Users
                   •   Defining Filters for Tables
                   •   Defining Filters for SQL Text
                   •   Defining Filters for Modules
                   •   Defining Filters for Actions
              6.   Click Next.
                   The Recommendation Options page appears.
              7.   Proceed to the next step, as described in "Specifying Recommendation Options".

Defining Filters for Resource Consumption
              The resource consumption filter restricts the workload to include only the number of
              high-load SQL statements that you specify.

              To define a filter for resource consumption:
              1.   On the SQL Access Advisor: Workload Source page, under User Resource
                   Consumption, enter the number of high-load SQL statements in the Number of
                   Statements field.
              2.   From the Order by list, select one of the methods by which the SQL statements
                   are to be ordered.

Defining Filters for Users
              The users filter restricts the workload to include or exclude SQL statements executed
              by users that you specify.

              To define a filter for users:
              1.   On the SQL Access Advisor: Workload Source page, under Users, select Include
                   only SQL statements executed by these users or Exclude all SQL statements
                   executed by these users.
              2.   To search for available users, click the Users search icon.
                   The Search and Select: Users dialog box appears.
              3.   Select the users whose SQL statements you want to include or exclude and then
                   click Select.
                   The Search and Select: Users dialog box closes and the selected tables now
                   appear in the Users field.
                   In this example, a filter is defined to include only SQL statements executed by the
                   user SH.




                                                                                                      13-6
                                                                                                  Chapter 13
                                                                                Running SQL Access Advisor




Defining Filters for Tables
              The tables filter restricts the workload to include or exclude SQL statements that
              access a list of tables that you specify. Table filters are not permitted if you selected
              the Create a Hypothetical Workload from the Following Schemas and Tables
              option, as described in "Using a Hypothetical Workload".

              To define a filter for tables:
              1.   To include only SQL statements that access a specific list of tables, enter the table
                   names in the Include only SQL statements that access any of these tables
                   field.
              2.   To exclude all SQL statements that access a specific list of tables, enter the table
                   names in the Exclude all SQL statements that access any of these tables field.
              3.   To search for available tables, click the Tables search icon.
                   The Search and Select: Schema and Table dialog box appears.
              4.   Select the tables for which you want to include or exclude SQL statements and
                   click Select.
                   The Search and Select: Schema and Table dialog box closes and the selected
                   tables now appear in the corresponding Tables field.

Defining Filters for SQL Text
              The SQL text filter restricts the workload to include or exclude SQL statements that
              contains SQL text substrings that you specify.

              To define a filter for SQL text:
              1.   To include only SQL statements that contains specific SQL text, enter the SQL text
                   to be included in the Include only SQL statements containing these SQL text
                   substrings field.
              2.   To exclude all SQL statements that contain specific SQL text, enter the SQL text
                   to be excluded in the Exclude all SQL statements containing these SQL text
                   substrings field.

Defining Filters for Modules
              The module filter restricts the workload to include or exclude SQL statements that are
              associated with modules that you specify.

              To define a filter for module ID:
              1.   Do one of the following:
                   •   To include only SQL statements associated with a specific module ID in
                       the workload, select Include only SQL statements associated with these
                       modules.
                   •   To exclude all SQL statements associated to a specific module ID from
                       the workload, select Exclude all SQL statements associated with these
                       modules.




                                                                                                     13-7
                                                                                                   Chapter 13
                                                                                  Running SQL Access Advisor


              2.   In the Modules field, enter the names of the modules for which associated SQL
                   statements are included or excluded.

Defining Filters for Actions
              The actions filter restricts the workload to include or exclude SQL statements that are
              associated with actions that you specify.

              To define a filter for actions:
              1.   Do one of the following:
                   •   To include only SQL statements associated with a specific action in the
                       workload, select Include only SQL statements associated with these
                       actions.
                   •   To exclude all SQL statements associated with a specific action from the
                       workload, select Exclude all SQL statements associated with these
                       actions.
              2.   In the Actions field, enter the actions for which associated SQL statements are
                   included or excluded.


Specifying Recommendation Options
              To improve the underlying data access methods chosen by the optimizer for the
              workload, SQL Access Advisor provides recommendations for indexes, materialized
              views, and partitioning. Using these access structures can significantly improve the
              performance of the workload by reducing the time required to read data from the
              database. However, you must balance the benefits of using these access structures
              against the cost to maintain them.

              To specify recommendation options:
              1.   Select initial options, as described in "Selecting the Initial Options".
              2.   Select the workload source, as described in "Selecting the Workload Source".
              3.   Define the filter options, as described in "Applying Filter Options".
              4.   On the SQL Access Advisor: Recommendation Options page, under Access
                   Structures to Recommend, select the type of access structures to be
                   recommended by SQL Access Advisor:
                   •   Indexes
                   •   Materialized Views
                   •   Partitioning
                   In this example, all of the preceding access types are selected.




              5.   Under Scope, select the mode in which SQL Access Advisor runs. Do one of the
                   following:



                                                                                                      13-8
                                                                                 Chapter 13
                                                                Running SQL Access Advisor


     •   Select Limited.
         In limited mode, SQL Access Advisor focuses on SQL statements with the
         highest cost in the workload. The analysis is quicker, but the recommendations
         may be limited.
     •   Select Comprehensive.
         In comprehensive mode, SQL Access Advisor analyzes all SQL statements in
         the workload. The analysis can take much longer, but the recommendations
         are exhaustive.
     In this example, Limited Mode is selected.




6.   Optionally, click Advanced Options.
     The Advanced Options section expands. This section contains the following
     subsections:
     •   Workload Categorization
         In this section, you can specify the type of workload for which you want a
         recommendation. The following categories are available:
         –   Workload Volatility
             Select Consider only queries if the workload primarily contains read-
             only operations, as in data warehouses. Volatility data is useful for
             online transaction processing (OLTP) systems, where the performance of
             INSERT, UPDATE, and DELETE operations is critical.
         –   Workload Scope
             Select Recommend dropping unused access structures if the
             workload represents all access structure use cases.
     •   Space Restrictions
         Indexes and materialized views increase performance at the cost of space. Do
         one of the following:
         –   Select No, show me all recommendations (unlimited space) to specify
             no space limits. When SQL Access Advisor is invoked with no space
             limits, it makes the best possible performance recommendations.
         –   Select Yes, limit additional space to and then enter the space limit
             in megabytes, gigabytes, or terabytes. When SQL Access Advisor is
             invoked with a space limit, it produces only recommendations with space
             requirements that do not exceed the specified limit.
     •   Tuning Prioritization
         This section enables you to specify how SQL statements are tuned. Complete
         the following steps:



                                                                                      13-9
                                                                                             Chapter 13
                                                                            Running SQL Access Advisor


                    –   From the Prioritize tuning of SQL statements by list, select a method by
                        which SQL statements are to be tuned and then click Add.
                    –   Optionally, select Consider access structures creation costs
                        recommendations to weigh the cost of creating access structures against
                        the frequency and potential improvement of SQL statement execution
                        time. Otherwise, creation cost is ignored. You should select this option
                        if you want specific recommendations generated for SQL statements that
                        are executed frequently.
                •   Default Storage Locations
                    Use this section to override the defaults defined for schema and tablespace
                    locations. By default, indexes are in the schema and tablespace of the table
                    they reference. Materialized views are in the schema and tablespace of the
                    first table referenced in the query. Materialized view logs are in the default
                    tablespace of the schema of the table that they reference.
           7.   Click Next.
                The SQL Access Advisor: Schedule page appears.
           8.   Proceed to the next step, as described in "Specifying Task and Scheduling
                Options".


Specifying Task and Scheduling Options
           Use the SQL Access Advisor Schedule page to set or modify the schedule parameters
           for the SQL Access Advisor task.




                                                                                               13-10
                                                                                     Chapter 13
                                                                    Running SQL Access Advisor


Figure 13-1     Scheduling a SQL Access Advisor Task




To schedule a SQL Access Advisor task:
1.   Select initial options, as described in "Selecting the Initial Options".
2.   Select the workload source, as described in "Selecting the Workload Source".
3.   Define the filter options, as described in "Applying Filter Options".
4.   Specify the recommendation options, as described in "Specifying
     Recommendation Options".
5.   On the SQL Access Advisor: Schedule page, under Advisor Task Information,
     enter a name in the Task Name field if you do not want to use the system-
     generated task name.
     In the example in Figure 13-1, SQLACCESS8895797 is entered.
6.   In the Task Description field, enter a description of the task.




                                                                                       13-11
                                                                                    Chapter 13
                                                                   Running SQL Access Advisor


     In the example in Figure 13-1, SQL Access Advisor is entered.
7.   From the Journaling Level list, select the level of journaling for the task.
     Journaling level controls the amount of information that is logged to the SQL
     Access Advisor journal during task execution. This information appears on the
     Details subpage when viewing task results.
     In the example in Figure 13-1, Basic is selected.
8.   In the Task Expiration (days) field, enter the number of days to retain the task in
     the database before it is purged.
     In the example in Figure 13-1, 30 is entered.
9.   In the Total Time Limit (minutes) field, enter the maximum number of minutes
     that the job is permitted to run.
     You must enter a time in this field rather than use the default.
10. Under Scheduling Options, in the Schedule Type list, select a schedule type for
     the task and a maintenance window in which the task should run. Do one of the
     following:
     •   Click Standard.
         This schedule type enables you to select a repeating interval and start time for
         the task. Complete the following steps:
         –   Enter your time zone code in the Time Zone field or click the search icon
             to locate the code for your area.
         –   In the Repeat list, select Do Not Repeat to perform the task only once, or
             select a unit of time and enter the number of units in the Interval field.
         –   Under Start, select Immediately to start the task now, or Later to
             schedule the task to start at a time specified using the Date and Time
             fields.
     •   Click Use Predefined Schedule.
         This schedule type enables you to select an existing schedule. Do one of the
         following:
         –   In the Schedule field, enter the name of the schedule to be used for the
             task.
         –   To search for a schedule, click the search icon.
             The Search and Select: Schedule dialog box appears.
             Select the desired schedule and click Select. The selected schedule now
             appears in the Schedule field.
     •   Click Standard Using PL/SQL for Repeated Interval.
         This schedule type enables you to select a repeating interval and an execution
         time period (window) for the task. Complete the following steps:
         –   Enter your time zone code in the Time Zone field or click the search icon
             to locate the code for your area.
         –   Under Available to Start, select Immediately to start the task now, or
             Later to schedule the task to start at a time specified using the Date and
             Time fields.




                                                                                      13-12
                                                                               Chapter 13
                                                              Running SQL Access Advisor


        –   In the Repeated Interval field, enter a PL/SQL schedule expression, such
            as SYSDATE+1.
        –   Under Not Available After, select No End Date to indicate that there is no
            end date for the execution window, or Specified End Date to specify an
            end date using the Date and Time fields.
    •   Click Use Predefined Window.
        This schedule type enables you to select an existing window. Select Stop
        on Window Close to stop the job when the window closes. Do one of the
        following:
        –   In the Window field, enter the name of the window to be used for the task.
        –   To search for a window, click the search icon.
            The Search and Select: Window and Window Groups dialog box appears.
            Select the desired window and click Select. The selected window now
            appears in the Schedule field.
    •   Click Event.
        Complete the following steps:
        –   Enter your time zone code in the Time Zone field or click the search icon
            to locate the code for your area.
        –   Under Event Parameters, enter values in the Queue Name and
            Condition fields.
        –   Under Start, select Immediately to start the task now, or Later to
            schedule the task to start at a time specified using the Date and Time
            fields.
        –   Under Not Available After, select No End Date to indicate that there is no
            end date for the execution window, or Specified End Date to specify an
            end date using the Date and Time fields.
    •   Click Calendar.
        Complete the following steps:
        –   Enter your time zone code in the Time Zone field or click the search icon
            to locate the code for your area.
        –   Under Calendar Expression, enter a calendar expression.
        –   Under Start, select Immediately to start the task now, or Later to
            schedule the task to start at a time specified using the Date and Time
            fields.
        –   Under Not Available After, select No End Date to indicate that there is no
            end date for the execution window, or Specified End Date to specify an
            end date using the Date and Time fields.
    In the example in Figure 13-1, Standard is selected for schedule type. The task
    does not repeat and is scheduled to start immediately.
11. Click Next.

    The SQL Access Advisor: Review page appears.




                                                                                 13-13
                                                                                         Chapter 13
                                                  Reviewing the SQL Access Advisor Recommendations




             Under Options is a list of modified options for the SQL Access Advisor task. To
             display both modified and unmodified options, click Show All Options. To view
             the SQL text for the task, click Show SQL.
        12. Click Submit.

             The Advisor Central page appears. A message informs you that the task was
             created successfully.


Reviewing the SQL Access Advisor Recommendations
        SQL Access Advisor graphically displays the recommendations and provides links so
        that you can quickly see which SQL statements benefit from a recommendation. Each
        recommendation produced by the SQL Access Advisor is linked to the SQL statement
        it benefits.

        To review the SQL Access Advisor recommendations:
        1.   Run SQL Access Advisor to make the recommendations, as described in "Running
             SQL Access Advisor".
        2.   Access the Database Home page.
             See "Accessing the Database Home Page" for more information.
        3.   From the Performance menu, select Advisors Home.
             If the Database Login page appears, then log in as a user with administrator
             privileges. The Advisor Central page appears.
        4.   Select the SQL Access Advisor task for review and click View Result.




                                                                                            13-14
                                                                                            Chapter 13
                                                     Reviewing the SQL Access Advisor Recommendations


               If the task is not displayed, then you may need to refresh the screen. The Results
               for Task page appears.
          5.   Review the Summary subpage, which provides an overview of the SQL
               Access Advisor analysis, as described in "Reviewing the SQL Access Advisor
               Recommendations: Summary".
          6.   Review the Recommendations subpage, which enables you to view the
               recommendations ranked by cost improvement, as described in "Reviewing the
               SQL Access Advisor Recommendations: Recommendations".
          7.   Review the SQL statements analyzed in the workload, as described in "Reviewing
               the SQL Access Advisor Recommendations: SQL Statements".
          8.   Review the details of the workload, task options, and the SQL Access Advisor
               task, as described in "Reviewing the SQL Access Advisor Recommendations:
               Details".


Reviewing the SQL Access Advisor Recommendations: Summary
          The Summary subpage displays an overview of the SQL Access Advisor analysis.

          To review the recommendations summary:
          1.   Access the Results for Task page, as described in "Reviewing the SQL Access
               Advisor Recommendations".
          2.   Click Summary.
               The Summary subpage of the Results for Tasks page appears.
               In this example, Limited Mode is selected so that SQL Access Advisor analyzes
               the highest cost statements rather than all statements.




                                                                                              13-15
                                                                                  Chapter 13
                                           Reviewing the SQL Access Advisor Recommendations




3.   Under Overall Workload Performance, assess the potential for improvement in
     implementing the recommendations.
4.   Use the Workload I/O Cost chart to compare the original workload I/O cost with the
     new cost.
     In this example, the workload I/O cost decreases from 107.1 million to 43.1 million
     by implementing the recommendations.
5.   Use the Query Execution Time Improvement chart to compare the improvement in
     query execution time.
     This chart shows the percentage of SQL statements in the workload whose
     execution time improves by accepting the recommendations. The SQL statements
     are grouped by the projected improvement factor along the horizontal axis on
     the chart (1x to >10x). The percentage of SQL statements that improve by the
     projected improvement factor are along the vertical axis (0% to 100%).
     In this example, approximately 62 percent of SQL statements in the workload
     do not improve execution time, but about 25 percent have the potential for
     improvement of over 4x or more.
6.   Under Recommendations, click Show Recommendation Action Counts.
     In the following example, creating 2 indexes, 4 materialized views, and 4
     materialized view logs is recommended.




                                                                                    13-16
                                                                                          Chapter 13
                                                   Reviewing the SQL Access Advisor Recommendations




          7.   Under SQL Statements, click Show Statement Counts to display the type of SQL
               statement.
               In the following example, 25 SELECT statements are analyzed.




Reviewing the SQL Access Advisor Recommendations:
Recommendations
          The Recommendations subpage ranks the SQL Access Advisor recommendations by
          cost improvement. You can also view details about each recommendation.

          To review recommendation details:
          1.   Access the Results for Task page, as described in "Reviewing the SQL Access
               Advisor Recommendations".
          2.   Click Recommendations.
               The Recommendations subpage appears.




                                                                                            13-17
                                                                                Chapter 13
                                         Reviewing the SQL Access Advisor Recommendations




3.   Use the Recommendations by Cost Improvement chart to view recommendations
     ordered by the cost improvement.
     Under Select Recommendations for Implementation, each recommendation is
     listed with its implementation status, recommendation ID, cost improvement,
     space consumption, and the number of affected SQL statements for each
     recommendation. Implementing the top recommendation has the biggest benefit
     to the total performance of the workload.
4.   To view details for a particular recommendation, select the recommendation and
     click Recommendation Details.
     The Recommendation Details page appears. For space reasons, the following
     screenshot does not show the rightmost columns of the Actions table. The
     columns not shown are Tablespace and Estimated Space Used (MB).




                                                                                  13-18
                                                                                 Chapter 13
                                          Reviewing the SQL Access Advisor Recommendations




     The Recommendation Details page displays all actions for the specified
     recommendation.
     Under Actions, you can choose to specify the schema or the tablespace for all
     actions. For some actions you can modify the object name, tablespace, and
     schema. To view the SQL text of an action, click the link in the Action column
     for the specified action.
     Under SQL Affected by Recommendation, the SQL text of the SQL statement and
     cost improvement information are displayed.
5.   Click OK.
     The Recommendations subpage appears.
6.   To view the SQL text of a recommendation, select the recommendation and click
     Show SQL.
     The Show SQL page for the selected recommendation appears.




                                                                                   13-19
                                                                                         Chapter 13
                                                  Reviewing the SQL Access Advisor Recommendations




Reviewing the SQL Access Advisor Recommendations: SQL
Statements
          The SQL Statements subpage ranks SQL statements in the workload by cost
          improvement. You can use this page to view details about the SQL statements
          analyzed in the workload.

          To review SQL statements:
          1.   Access the Results for Task page, as described in "Reviewing the SQL Access
               Advisor Recommendations".
          2.   Click SQL Statements.
               The SQL Statements subpage appears.




                                                                                           13-20
                                                                                            Chapter 13
                                                     Reviewing the SQL Access Advisor Recommendations




          3.   Use the SQL Statements by Cost Improvement chart to view SQL statements in
               the workload ordered by the cost improvement.
               Under Select SQL Statements to be Improved, each SQL statement is listed with
               its statement ID, SQL text, associated recommendation, cost improvement, and
               execution count.
               Implementing the recommendation associated with the top SQL statement has
               the biggest benefit to the total performance of the workload. In this example,
               implementing the recommendation with ID 3 produces the biggest benefit, a cost
               improvement of 99.80%, for the SQL statement with ID 803.
          4.   To view the SQL text of a recommendation, select the recommendation and click
               Show SQL.
               The Show SQL page for the selected recommendation appears.


Reviewing the SQL Access Advisor Recommendations: Details
          The Details subpage displays a list of all the workload and task options used in the
          analysis. You can also use this page to view a list of journal entries for the task, based
          on the journaling level used when the task was created.

          To review workload and task details:
          1.   Access the Results for Task page, as described in "Reviewing the SQL Access
               Advisor Recommendations".




                                                                                              13-21
                                                                                         Chapter 13
                                               Implementing the SQL Access Advisor Recommendations


        2.   Click Details.
             The Details subpage appears.




             Under Workload and Task Options, a list of options that were selected when the
             advisor task was created is displayed.
             Under Journal Entries, a list of messages that were logged to the SQL Access
             Advisor journal while the task was executing is displayed.


Implementing the SQL Access Advisor Recommendations
        A SQL Access Advisor recommendation can range from a simple suggestion to
        a complex solution that requires partitioning a set of existing base tables and
        implementing a set of database objects such as indexes, materialized views, and
        materialized view logs. You can select the recommendations for implementation and
        schedule when the job should be executed.




                                                                                           13-22
                                                                                  Chapter 13
                                        Implementing the SQL Access Advisor Recommendations




To implement the SQL Access Advisor recommendations:
1.   Review the SQL Access Advisor recommendations for cost benefits to determine
     which ones, if any, should be implemented.
     See "Reviewing the SQL Access Advisor Recommendations" for more information.
2.   Access the Results for Task page, as described in "Reviewing the SQL Access
     Advisor Recommendations".
3.   Click Recommendations.
     The Recommendations subpage appears.
4.   Under Select Recommendations for Implementation, select the recommendation
     you want to implement and then click Schedule Implementation.
     In the following example, the recommendation with ID value 1 is selected.




     The Schedule Implementation page appears.
5.   In the Job Name field, enter a name for the job if you do not want to use the
     system-generated job name.
6.   Determine whether the implementation job should stop if an error is encountered.
     Do one of the following:
     •   To stop processing if an error occurs, select Stop on Error.
     •   To continue processing even if an error occurs, deselect Stop on Error.
7.   Under Scheduling Options, in the Schedule Type list, select a schedule type for
     the task and a maintenance window in which the task should run. Do one of the
     following:
     •   Click Standard.
         This schedule type enables you to select a repeating interval and start time for
         the task. Complete the following steps:
         –   Enter your time zone code in the Time Zone field or click the search icon
             to locate the code for your area.
         –   In the Repeat list, select Do Not Repeat to perform the task only once, or
             select a unit of time and enter the number of units in the Interval field.




                                                                                     13-23
                                                                              Chapter 13
                                    Implementing the SQL Access Advisor Recommendations


    –   Under Start, select Immediately to start the task now, or Later to
        schedule the task to start at a time specified using the Date and Time
        fields.
•   Click Use predefined schedule.
    This schedule type enables you to select an existing schedule. Do one of the
    following:
    –   In the Schedule field, enter the name of the schedule to be used for the
        task.
    –   To search for a schedule, click the search icon.
        The Search and Select: Schedule dialog box appears.
        Select the desired schedule and click Select. The selected schedule now
        appears in the Schedule field.
•   Click Standard using PL/SQL for repeated interval.
    This schedule type enables you to select a repeating interval and an execution
    window for the task. Complete the following steps:
    –   Enter your time zone code in the Time Zone field or click the search icon
        to locate the code for your area.
    –   Under Available to Start, select Immediately to start the task now, or
        Later to schedule the task to start at a time specified using the Date and
        Time fields.
    –   In the Repeated Interval field, enter a PL/SQL schedule expression, such
        as SYSDATE+1.
    –   Under Not Available After, select No End Date to indicate that there is no
        end date for the execution window, or Specified End Date to specify an
        end date using the Date and Time fields.
•   Click Use predefined window.
    This schedule type enables you to select an existing window. Select Stop
    on Window Close to stop the job when the window closes. Do one of the
    following:
    –   In the Window field, enter the name of the window to be used for the task.
    –   To search for a window, click the search icon.
        The Search and Select: Window and Window Groups dialog box appears.
        Select the desired window and click Select. The selected window now
        appears in the Schedule field.
•   Click Event.
    Complete the following steps:
    –   Enter your time zone code in the Time Zone field or click the search icon
        to locate the code for your area.
    –   Under Event Parameters, enter values in the Queue Name and
        Condition fields.
    –   Under Start, select Immediately to start the task now, or Later to
        schedule the task to start at a time specified using the Date and Time
        fields.




                                                                                13-24
                                                                                   Chapter 13
                                         Implementing the SQL Access Advisor Recommendations


         –   Under Not Available After, select No End Date to indicate that there is no
             end date for the execution window, or Specified End Date to specify an
             end date using the Date and Time fields.
     •   Click Calendar.
         Complete the following steps:
         –   Enter your time zone code in the Time Zone field or click the search icon
             to locate the code for your area.
         –   Under Calendar Expression, enter a calendar expression.
         –   Under Start, select Immediately to start the task now, or Later to
             schedule the task to start at a time specified using the Date and Time
             fields.
         –   Under Not Available After, select No End Date to indicate that there is no
             end date for the execution window, or Specified End Date to specify an
             end date using the Date and Time fields.
     In this example, Standard is selected for schedule type. The job does not repeat
     and is scheduled to start immediately.




8.   Optionally, click Show SQL to view the SQL text for the job.
9.   Click Submit to submit the job.
10. Do one of the following, depending on whether the job is scheduled to start
     immediately or later:




                                                                                     13-25
                                                                                      Chapter 13
                                          Implementing the SQL Access Advisor Recommendations


    •    If you submitted the job immediately, and if the Results for Task page appears,
         then click the link in the Scheduler Job field to display the View Job page. Go
         to Step 12.
    •    If the job is scheduled to start at a later time, then proceed to Step 11.
11. Complete the following steps:

    a.   From the Administration menu, select Oracle Scheduler, then Jobs.
         The Scheduler Jobs page appears.
    b.   Select the implementation job and click View Job Definition.
         The View Job page for the selected job appears.
12. On the View Job page, under Operation Detail, check the status of the operation.




13. Optionally, select the operation and click View.

    The Operation Detail page appears.
    This page contains information (such as start date and time, run duration, CPU
    time used, and session ID) that you can use when troubleshooting.
14. Optionally, from the Database Home page, select Schema, then the page of the
    object that was created.
    Depending on the type of access structure that is created, you can display
    the access structure using the Indexes page, Materialized Views page, or the
    Materialized View Logs page.




                                                                                        13-26
Index
A                                               Automatic Database Diagnostic Monitor (continued)
                                                         recommendations (continued)
about, 13-1                                              types, 3-2
Active Session History,                             report, 3-10
    about, 8-1                                      reviewing results, 3-8
    ASH Analytics page, 4-22                        running manually
    report                                               analyzing current database performance,
         about, 8-2                                               7-1
         activity over time, 8-9                         analyzing historical database
         load profile, 8-5                                        performance, 7-3
         running, 8-2                           Automatic Memory Management, 10-9
         top events, 8-4                        Automatic SQL Tuning
         top SQL, 8-6                               modifying task attributes, 12-7
         using, 8-4                                 viewing recommendations, 12-7
    sampled data, 8-1                               viewing results, 12-5
    statistics, 2-4                             Automatic Storage Management, 10-10
active sessions, 2-3                            Automatic Workload Repository, 2-1
    captured in Active Session History, 2-4         about, 2-1
ADDM                                                baselines, 9-1
    See Automatic Database Diagnostic Monitor       compare periods report
Agent-to-Agent file transfer, 10-12                      about, 9-1
alerts                                                   details, 9-20
    clearing, 6-3                                        saving, 9-14, 9-16
    default, 6-1                                         summary, 9-17
    performance, 6-1                                     supplemental information, 9-20
    responding to, 6-3                                   using, 9-16
ASH                                                      using another baseline, 9-11
    See Active Session History                      snapshots, 2-1
ASH Analytics, 4-22                                 statistics collected by, 2-1
Automatic Database Diagnostic Monitor,              using, 3-5
    about, 3-1                                  average active sessions
    accessing results, 7-5                          about, 4-1
    analysis, 3-2                               AWR
    configuring, 3-4                               See Automatic Workload Repository
    findings                                    AWR Warehouse
         about, 3-10                              about, 10-1
         viewing, 3-8                             ASH Analytics page, 10-7
    for a multitenant environment, 3-3            AWR Report page, 10-7
    for Oracle RAC, 3-3                           Compare Period ADDM page, 10-8
    identifying high-load SQL, 11-1               Compare Periods Report page, 10-8
    recommendations                               credentials, 10-11
         actions, 3-11                            ETL, 10-5
         implementing, 3-11                       extract errors, 10-14
         interpreting, 3-10                       load errors, 10-12
         rationales, 3-11                         memory management, 10-9




                                                                                        Index-1
                                                                                              Index


AWR Warehouse (continued)                       database performance
    Performance Home page, 10-6                     alerts, 6-1
    set up, 10-2                                    automatic monitoring, 3-1
    snapshot view access, 10-5                      comparing, 9-1
    source database, 10-4                           current analysis, 7-1
    staging location, 10-12                         degradation over time, 9-1
    storage requirements, 10-10                     historical analysis, 7-3
    SYSAUX tablespace, 10-10, 10-12                 manual monitoring, 7-1
    transfer errors, 10-14                          overview, 2-1
    troubleshooting, 10-12                      Database Resource Manager
awrinfo.sql script, 10-10                           using, 4-17
                                                database statistics
                                                    about, 2-1
B                                               database time,
baselines                                           about, 2-2
   about, 9-1                                       and ADDM findings, 3-10
   baseline template                                in calculating average active sessions, 4-1
        about, 9-2, 9-5                         database tuning
   comparing, 9-11, 9-14                            performance degradation over time, 9-1
   computing threshold statistics for, 9-6          preparing the database, 2-6
   creating, 9-2                                    proactive tuning, 2-7
   deleting, 9-5                                    reactive tuning, 2-7
   SQL plan, 12-20                                  real-time performance problems, 4-1
                                                    SQL tuning, 2-8
                                                    tools, 1-2
C                                                   transient performance problems, 8-1
CONTROL_MANAGEMENT_PACK_ASSESS                      using the Performance page, 4-1
         parameter, 2-6                         DB time
                                                    See database time
   and ADDM, 3-4
                                                DBIO_EXPECTED parameter
   and database operations, 5-3
                                                     setting, 3-4, 3-5
CPU
                                                DBMS_ADVISOR package
   I/O wait, 4-16
                                                     configuring ADDM, 3-5
   load, 4-17
                                                     setting DBIO_EXPECTED, 3-5
   performance problems, 4-17
                                                DBMS_SQL_MONITOR package, 5-3
   time, 2-3
                                                disk
   utilization, monitoring, 4-16
                                                     performance problems, 4-22
                                                     utilization, monitoring, 4-20
D
data access paths, optimizing, 13-1             E
Data Guard, 10-10
                                                ETL, 10-5
Database Home page
                                                events, 6-1
    accessing, 1-3
                                                execution plans
database operations
                                                    about, 12-1
    composite operations, defined, 5-2
                                                    evolving, 12-23
    creating, 5-3
                                                extract errors, AWR Warehouse, 10-14
    enabling monitoring with initialization
             parameters, 5-3
    identifying an operation, 5-3               H
    monitoring, 5-1
    simple operations, defined, 5-1             high-load SQL
    viewing on Monitored SQL Executions page,       about, 11-1
             5-5                                    identifying using ADDM, 11-1
database operations, monitoring                     identifying using top SQL, 11-2
    purpose, 5-2                                    statistics, 2-5



                                                                                          Index-2
                                                                                             Index


high-load SQL (continued)                       N
    tuning, 12-2, 12-5
host activity, monitoring, 4-15                 Network Latency, 10-12
    CPU, 4-17
    CPU utilization, 4-16
    disk utilization, 4-20
                                                O
                                                Oracle Diagnostics Pack, 1-2
I                                               Oracle performance method
                                                   about, 2-1
I/O wait times, monitoring, 4-9                    pretuning tasks, 2-6
In-Memory Column Store (IM column store), xii      proactive database tuning tasks, 2-7
incidents, 6-1                                     reactive database tuning tasks, 2-7
index                                              SQL tuning tasks, 2-8
      about, 13-1                                  using, 2-5
      B-tree, 13-1                              Oracle Tuning Pack, 1-2
      bitmap, 13-1
      creating, 13-1
      functional, 13-1
                                                P
indexes                                         parallel execution, monitoring, 4-13
      creating, 2-8                             parameters
initialization parameter, 10-9                      CONTROL_MANAGEMENT_PACK_ASSESS,
instance activity, monitoring, 4-8                            2-6, 3-4, 5-3
      I/O wait times, 4-9                           initialization, 9-20
      parallel execution, 4-13                      STATISTICS_LEVEL, 3-4, 5-3
      services, 4-14                            Performance page
      throughput, 4-8                               about, 4-1
                                                performance problems
J                                                   common, 2-8
                                                    CPU, 4-17
job_queue_processes parameter, 10-11                diagnosing, 3-1
                                                    disk, 4-22
                                                    memory, 4-19
L                                                   real-time, 4-1
load errors, AWR Warehouse, 10-12                   transient, 8-1
                                                PL/SQL
                                                    monitoring, 4-5
M                                               problems, as a type of incident, 6-1
materialized view logs, 13-1
   creating, 2-8, 13-1                          R
materialized views
   creating, 2-8, 13-1                          redo logs, 10-10
memory                                          resource consumption, 4-6
   performance problems, 4-19                   RMAN, 10-10
   swap utilization, 4-19
   utilization, monitoring, 4-17                S
memory management, AWR Warehouse, 10-9
metrics, 6-1, 9-8                               services
Monitored SQL Executions page, 5-5                  about, 4-14
monitoring                                          monitoring, 4-14
   PL/SQL, 4-5                                  session attributes, 4-7
   resource consumption, 4-6                    session identifiers, 4-6
   session attributes, 4-7                      sessions
   session identifiers, 4-6                         about, 2-3
   SQL, 4-4                                         active, 2-3, 2-4




                                                                                          Index-3
                                                                                           Index


sessions (continued)                        stacked area charts
    average active, 4-1                          described, 4-2
snapshot upload, AWR Warehouse, 10-5        statistics
snapshots                                        Active Session History, 2-4
    about, 2-1                                   baselines, 9-1
    creating, 3-6                                database, 2-1
    default interval, 3-5                        database time, 2-2, 3-10
    modifying settings, 3-7                      default retention, 3-5
    viewing statistics, 3-14                     gathering, 2-1
source database, AWR Warehouse, 10-5             high-load SQL, 2-5
spikes                                           sampled data, 8-1
    determining cause of, 4-22                   session, 2-4
SQL                                              system, 2-4
    monitoring, 4-4                              wait events, 2-4
SQL Access Advisor                          STATISTICS_LEVEL parameter
    about, 12-1, 13-1                            and ADDM, 3-4
    filters, 13-5                                and database operations, 5-3
    initial options, 13-2, 13-14            stats collection, 10-10
    recommendations                         storage requirements, AWR Warehouse, 10-10
          about, 13-1                       SYSAUX tablespace, 10-10, 10-12
          details, 13-17
          implementing, 13-22
          options, 13-8
                                            T
          reviewing, 13-14                  throughput, monitoring, 4-8
          SQL, 13-20                        Top Activity page
          summary, 13-15                        about, 11-2
    running, 13-1                           top dimensions
    scheduling, 13-10                           monitoring, 4-4
    task options, 13-21                     top SQL
    workload options, 13-21                     identifying high-load SQL, 11-2
    workload source, 13-3                       in Active Session History report, 8-6
SQL Performance Analyzer                    transfer errors, AWR Warehouse, 10-14
    about, 2-8                              troubleshooting, AWR Warehouse, 10-12
SQL plan baselines
    about, 12-20
    capturing automatically, 12-21          U
    evolving, 12-23                         user activity, monitoring
    loading manually, 12-21                     about, 4-1
SQL plan management, 12-20                      top dimensions, 4-4
SQL Plan Management Evolve Advisor, 12-23
SQL profiles
    deleting, 12-19                         W
    disabling, 12-19
                                            wait classes
    enabling, 12-19
                                                grouped wait events, 2-4
SQL Tuning Advisor
                                            wait events
    about, 12-1
                                                statistics, 2-4
    automated maintenance tasks, 12-5
                                            wait time, 2-3
    implementing recommendations, 12-5
    limited scope, 12-4
    using, 12-2, 12-5
SQL tuning sets
    about, 12-8
    creating, 12-9
    load method, 12-10




                                                                                        Index-4

