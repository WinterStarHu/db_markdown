# 55. Database Release Notes

> 源文件: `en/rnrdm/database-release-notes.pdf`

Oracle® Database
Database Release Notes




   19c
   E96072-37
   March 2026
Oracle Database Database Release Notes, 19c

E96072-37

Copyright © 2017, 2026, Oracle and/or its affiliates.

Primary Authors: Sarah Hirschfeld, Sunil Surabhi, Rhonda Day

This software and related documentation are provided under a license agreement containing restrictions on use and
disclosure and are protected by intellectual property laws. Except as expressly permitted in your license agreement or
allowed by law, you may not use, copy, reproduce, translate, broadcast, modify, license, transmit, distribute, exhibit,
perform, publish, or display any part, in any form, or by any means. Reverse engineering, disassembly, or decompilation
of this software, unless required by law for interoperability, is prohibited.

The information contained herein is subject to change without notice and is not warranted to be error-free. If you find
any errors, please report them to us in writing.

If this is software, software documentation, data (as defined in the Federal Acquisition Regulation), or related
documentation that is delivered to the U.S. Government or anyone licensing it on behalf of the U.S. Government, then
the following notice is applicable:

U.S. GOVERNMENT END USERS: Oracle programs (including any operating system, integrated software, any
programs embedded, installed, or activated on delivered hardware, and modifications of such programs) and Oracle
computer documentation or other Oracle data delivered to or accessed by U.S. Government end users are "commercial
computer software," "commercial computer software documentation," or "limited rights data" pursuant to the applicable
Federal Acquisition Regulation and agency-specific supplemental regulations. As such, the use, reproduction,
duplication, release, display, disclosure, modification, preparation of derivative works, and/or adaptation of i) Oracle
programs (including any operating system, integrated software, any programs embedded, installed, or activated on
delivered hardware, and modifications of such programs), ii) Oracle computer documentation and/or iii) other Oracle
data, is subject to the rights and limitations specified in the license contained in the applicable contract. The terms
governing the U.S. Government's use of Oracle cloud services are defined by the applicable contract for such services.
No other rights are granted to the U.S. Government.

This software or hardware is developed for general use in a variety of information management applications. It is not
developed or intended for use in any inherently dangerous applications, including applications that may create a risk of
personal injury. If you use this software or hardware in dangerous applications, then you shall be responsible to take all
appropriate fail-safe, backup, redundancy, and other measures to ensure its safe use. Oracle Corporation and its
affiliates disclaim any liability for any damages caused by use of this software or hardware in dangerous applications.

Oracle®, Java, MySQL, and NetSuite are registered trademarks of Oracle and/or its affiliates. Other names may be
trademarks of their respective owners.

Intel and Intel Inside are trademarks or registered trademarks of Intel Corporation. All SPARC trademarks are used
under license and are trademarks or registered trademarks of SPARC International, Inc. AMD, Epyc, and the AMD logo
are trademarks or registered trademarks of Advanced Micro Devices. UNIX is a registered trademark of The Open
Group.

This software or hardware and documentation may provide access to or information about content, products, and
services from third parties. Oracle Corporation and its affiliates are not responsible for and expressly disclaim all
warranties of any kind with respect to third-party content, products, and services unless otherwise set forth in an
applicable agreement between you and Oracle. Oracle Corporation and its affiliates will not be responsible for any loss,
costs, or damages incurred due to your access to or use of third-party content, products, or services, except as set forth
in an applicable agreement between you and Oracle.
Contents
           Preface
           Audience                                                                                                i
           Documentation Accessibility                                                                             i
           Related Resources                                                                                       i
           Conventions                                                                                            ii



1          Purpose of These Release Notes


2          Issues Affecting All Platforms for Oracle Database 19c
           Compatibility, Upgrading, Downgrading, and Installation                                                1
                 Core Dump ORA-00600 [8153] Error Encountered After Database Upgrade                              1
                 Upgrading from Oracle Database 11g Release 2 (11.2.0.4) to 19c to Oracle Database
                 Results in Errors During Upgrade                                                                 2
                 Plugging in an Oracle Database 12.1 Non-CDB to an Oracle Database 12.2 Local Undo
                 CDB                                                                                              2
           Deprecated and Desupported Features for Oracle Database                                                2
           Oracle Database Security                                                                               3
           Other Readmes, Release Notes, or Installation Guides                                                   3
           Open Bugs Affecting All Platforms                                                                      3
                 Analytic Workspace Manager Known Bugs                                                            4
                      Bug 28937717                                                                                4
                      Bug 28532773                                                                                4
                 Oracle ASM Cluster File System (Oracle ACFS) Known Bugs                                          4
                      Bug 29391849                                                                                4
                 Oracle ASM Dynamic Volume Manager (Oracle ADVM) Known Bugs                                       5
                      Bug 29520544                                                                                5
                 Oracle Data Pump Known Bugs                                                                      5
                      Bug 27092988                                                                                6
                 Oracle Database Enterprise Edition Known Bugs                                                    6
                      Bug 23569490                                                                                6
                      Bug 24291322                                                                                6
                      Bug 27254644                                                                                6



Database Release Notes
E96072-37                                                                                            March 26, 2026
Copyright © 2017, 2026, Oracle and/or its affiliates.                                                    Page i of v
                 Oracle Grid Infrastructure Known Bugs                                                             7
                      Bug 29414664                                                                                 7
                      Bug 29053083                                                                                 7
                      Bug 21559133                                                                                 7
                 Oracle Universal Installer Known Bugs                                                             7
                      Bug 18336219                                                                                 8
                      Bug 23006768                                                                                 8
                      Bug 27080535                                                                                 8
                      Bug 27120934                                                                                 9



3          Issues Affecting Linux for Oracle Database 19c
           Certification Information                                                                               2
           Unsupported Products for Linux                                                                          2
           Product Support                                                                                         2
           Linking Applications with Oracle Client Libraries for Linux                                             3
           Preinstallation Requirements for the Linux Platform                                                     3
           Open Bugs Affecting Linux                                                                               3
                 Bug 26708302                                                                                      3
           Known Issues and Bugs for SUSE Linux Enterprise Server 15                                               4
                 Bug 29953021                                                                                      4
                 Bug 29916735                                                                                      5
                 Bug 29836096                                                                                      5
                 Bug 29742223                                                                                      5
                 Bug 30131474                                                                                      6
           Unsupported Products for Oracle Database 19c on Oracle Linux 8                                          6
           Known Issues and Bugs for Oracle Linux 8 and Red Hat Enterprise Linux 8                                 6
                 Bug 30878668                                                                                      6
                 Bug 30445619                                                                                      6
                 Bug 36567521                                                                                      7
                 Bug 36565959                                                                                      7
                 Bug 29772579                                                                                      7
           Installing Oracle Database 19c on Oracle Linux 8 and Red Hat Enterprise Linux 8                         7
           Installing Oracle Database 19c (19.22) on Oracle Linux 9 and Red Hat Enterprise Linux 9                 8
           Installing Oracle Database Client 64-bit 19c (19.22) on Oracle Linux 9 and Red Hat
           Enterprise Linux 9                                                                                      9
           Installing Oracle Database Gateway 19c (19.21) on Oracle Linux 9 and Red Hat Enterprise
           Linux 9                                                                                                11
           Installing Oracle Database Client 32-bit 19c (19.19) on Oracle Linux 9 and Red Hat
           Enterprise Linux 9                                                                                     11
           Unsupported Products for Oracle Database 19c on Oracle Linux 9 and Red Hat Enterprise
           Linux 9                                                                                               12




Database Release Notes
E96072-37                                                                                            March 26, 2026
Copyright © 2017, 2026, Oracle and/or its affiliates.                                                    Page ii of v
           Known Issues and Bugs for Oracle Linux 9 and Red Hat Enterprise Linux 9 on Oracle
           Database                                                                                        12
                 Bug 35521990                                                                              13
                 Bug 35547711                                                                              13
                 Bug 35448216                                                                              14
                 Bug 35584316                                                                              14
                 Bug 35614058                                                                              14
                 Bug 36347606                                                                              14
                 Bug 36513962                                                                              15
           Known Issues and Bugs for Standard Edition High Availability                                    15
                 Bug 30821297                                                                              15
                 Bug 30979062                                                                              16
                 Bug 30992915                                                                              16
                 Bug 31114977                                                                              16
                 Bug 31128434                                                                              16
                 Bug 31128452                                                                              17
                 Bug 31146826                                                                              17
                 Bug 31156506                                                                              17
                 Bug 31188168                                                                              17
                 Bug 31264160                                                                              18



4          Issues Affecting Oracle on Linux for Arm (aarch64) for Oracle Database
           19c
           Unsupported Products for Linux for Arm (aarch64) for Oracle Database 19c                          1
           Open Bugs for Linux for Arm (aarch64) for Oracle Database 19c                                     2
                 Bug 34398211                                                                                2
                 Bug 34501504                                                                                2
                 Bug 34485708                                                                                3
                 Bug 35386579                                                                                3
           Limitation on Data Migration Using Transportable Tablespaces                                      4
           Prerequisite for Cross-Platform PDB Move                                                          4



5          Issues Affecting Oracle Instant Client on Linux for Arm (aarch64) for
           Oracle Database 19c
           Unsupported Products for Linux for Arm (aarch64)                                                  1



6          Issues Affecting Oracle Solaris for Oracle Database 19c
           Unsupported Products for Oracle Solaris                                                           1
                 Bug 21816875                                                                                1



Database Release Notes
E96072-37                                                                                      March 26, 2026
Copyright © 2017, 2026, Oracle and/or its affiliates.                                             Page iii of v
           Product Support                                                                                   1
           Linking Applications with Oracle Client Libraries for Oracle Solaris                              2
           Preinstallation Requirements for Oracle Solaris                                                   2
           Installation, Configuration, and Upgrade Issues for Oracle Solaris                                2
                 Bug 21800407                                                                                2
                 Bug 28650933                                                                                2
                 Bug 24355490                                                                                3
           Open Bugs Affecting Oracle Solaris                                                                3



7          Issues Affecting HP-UX Itanium for Oracle Database 19c
           Unsupported Products for HP-UX Itanium                                                            1
           Product Support                                                                                   1
           Linking Applications with Oracle Client Libraries for HP-UX Itanium                               1
           Preinstallation Requirements for HP-UX Itanium                                                    2
           Installation, Configuration, and Upgrade Issues for HP-UX Itanium                                 2
                 Bug 27367949                                                                                2
                 Bug 28340043                                                                                3
                 Bug 29198896                                                                                3



8          Issues Affecting the IBM AIX on POWER Systems Platform for Oracle
           Database 19c
           Unsupported Products for the IBM AIX on POWER Systems Platform                                    1
           Linking Applications with Oracle Client Libraries for the IBM AIX on POWER Systems
           Platform                                                                                          1
           Preinstallation Requirements for the IBM AIX on POWER Systems Platform                            1
           Installation, Configuration, and Upgrade Issues for the IBM AIX on POWER Systems
           Platform                                                                                          1
                 Bug 29053538                                                                                2
                 Bug 29434250                                                                                2
                 Bug 29052788                                                                                2
                 Bug 29178036                                                                                2
           Open Bugs Affecting the IBM AIX on POWER Systems Platform                                         3



9          Issues Affecting Microsoft Windows for Oracle Database 19c
           Unsupported Products for Microsoft Windows                                                        1
           Product Support                                                                                   1
           Linking Applications with Oracle Client Libraries for Microsoft Windows                           2
           Preinstallation Requirements for Microsoft Windows                                                2
           Installation, Configuration, and Upgrade Issues for Microsoft Windows                             2
                 Bug 20918120                                                                                3


Database Release Notes
E96072-37                                                                                       March 26, 2026
Copyright © 2017, 2026, Oracle and/or its affiliates.                                              Page iv of v
                 Bug 21325903                                       3
                 Bug 29426320                                       3
                 Bug 38057837                                       3




Database Release Notes
E96072-37                                               March 26, 2026
Copyright © 2017, 2026, Oracle and/or its affiliates.      Page v of v
Preface
                      This document describes last-minute features and changes that are not included in the Oracle
                      Database Documentation Library for Oracle Database 19c.
                      Starting with Oracle Database 18c, the readme and platform-specific release notes have been
                      combined into one document. The first chapter of this document contains generic information.
                      Subsequent chapters of this document contain platform-specific information. The last chapter
                      of this document contains last-minute changes not included in the Oracle Database
                      documentation library.
                      •     Audience
                      •     Documentation Accessibility
                      •     Related Resources
                      •     Conventions


Audience
                      This document is relevant only to Oracle Database 19c and documents new features, changes,
                      unsupported products, preinstallation requirements, generic and platform-specific bug fixes,
                      and known issues that are not included in the Oracle Database documentation library.


Documentation Accessibility
                      For information about Oracle's commitment to accessibility, visit the Oracle Accessibility
                      Program website at http://www.oracle.com/pls/topic/lookup?ctx=acc&id=docacc.

                      Access to Oracle Support
                      Oracle customers that have purchased support have access to electronic support through My
                      Oracle Support. For information, visit http://www.oracle.com/pls/topic/lookup?ctx=acc&id=info
                      or visit http://www.oracle.com/pls/topic/lookup?ctx=acc&id=trs if you are hearing impaired.


Related Resources
                      Refer to the following documentation for more information related to this release:
                      •     http://docs.oracle.com/en/database/database.html
                      •     For licensing information, refer to Oracle Database Licensing Information User Manual.
                      •     Additional readme or release notes files also exist. Refer to Other Readmes, Release
                            Notes, or Installation Guides.




Database Release Notes
E96072-37                                                                                                  March 26, 2026
Copyright © 2017, 2026, Oracle and/or its affiliates.                                                          Page i of ii
                                                                                                                                    Preface




Conventions
                      The following text conventions are used in this document:


                       Convention                       Meaning
                       boldface                         Boldface type indicates graphical user interface elements associated with an
                                                        action, or terms defined in text or the glossary.
                       italic                           Italic type indicates book titles, emphasis, or placeholder variables for which
                                                        you supply particular values.
                       monospace                        Monospace type indicates commands within a paragraph, URLs, code in
                                                        examples, text that appears on the screen, or text that you enter.




Database Release Notes
E96072-37                                                                                                                   March 26, 2026
Copyright © 2017, 2026, Oracle and/or its affiliates.                                                                           Page ii of ii
1
Purpose of These Release Notes
                      This topic briefly describes the purpose of these release notes.
                      Updates to this document can occur after it is released. Check for updates to this document
                      and view other Oracle documentation at:
                      http://docs.oracle.com/en/database/database.html
                      For licensing information, refer to Oracle Database Licensing Information User Manual.
                      Additional readme or release notes files also exist. Refer to the Other Readmes, Release
                      Notes, or Installation Guides.




Database Release Notes
E96072-37                                                                                               March 26, 2026
Copyright © 2017, 2026, Oracle and/or its affiliates.                                                      Page 1 of 1
2
Issues Affecting All Platforms for Oracle
Database 19c
                      These topics contain last-minute features and changes that affect all platforms for Oracle
                      Database 19c.
                      •     Compatibility, Upgrading, Downgrading, and Installation
                            This section describes compatibility, upgrading, downgrading, and installation topics for
                            Oracle Database 19c.
                      •     Deprecated and Desupported Features for Oracle Database
                            This topic describes deprecated and desupported features for Oracle Database 19c.
                      •     Oracle Database Security
                      •     Other Readmes, Release Notes, or Installation Guides
                            There are additional documents for Oracle products that are associated with this Oracle
                            Database release.
                      •     Open Bugs Affecting All Platforms
                            This section describes known bugs in Oracle Database 19c that affect all platforms.


Compatibility, Upgrading, Downgrading, and Installation
                      This section describes compatibility, upgrading, downgrading, and installation topics for Oracle
                      Database 19c.
                      •     Core Dump ORA-00600 [8153] Error Encountered After Database Upgrade
                            This topic describes the ORA-00600 error that can occur after a database upgrade.
                      •     Upgrading from Oracle Database 11g Release 2 (11.2.0.4) to 19c to Oracle Database
                            Results in Errors During Upgrade
                            This topic describes the ORA-08102 error that can occur when upgrading from Oracle
                            Database 11g release 2 (11.2.0.4) to Oracle Database 19c.
                      •     Plugging in an Oracle Database 12.1 Non-CDB to an Oracle Database 12.2 Local Undo
                            CDB
                            This topic describes undo tablespaces are not plugged in when going from Oracle
                            Database release 12.1 to release 12.2.


Core Dump ORA-00600 [8153] Error Encountered After Database Upgrade
                      This topic describes the ORA-00600 error that can occur after a database upgrade.

                      A core dump ORA-00600 [8153] error is encountered after the database is upgraded to Oracle
                      Database 12c release 2 (12.2) or to Oracle Database 19c and then downgraded back to its
                      original release (reference Bug 20898997).
                      Always apply the patch for this bug before upgrading the database to Oracle Database 12c
                      release 2 (12.2) or to Oracle Database 19c.




Database Release Notes
E96072-37                                                                                                   March 26, 2026
Copyright © 2017, 2026, Oracle and/or its affiliates.                                                          Page 1 of 9
                                                                                                                 Chapter 2
                                                                   Deprecated and Desupported Features for Oracle Database



Upgrading from Oracle Database 11g Release 2 (11.2.0.4) to 19c to Oracle
Database Results in Errors During Upgrade
                      This topic describes the ORA-08102 error that can occur when upgrading from Oracle Database
                      11g release 2 (11.2.0.4) to Oracle Database 19c.
                      In some cases, when altering table WRH$_SEG_STAT to add some columns, you may encounter
                      the ORA-08102 error (reference Bug 28668676). For example:

                      ALTER TABLE WRH$_SEG_STAT ADD (im_membytes NUMBER DEFAULT 0);
                      ALTER TABLE WRH$_SEG_STAT ADD (im_membytes NUMBER DEFAULT 0)
                      *
                      ERROR at line 1:
                      ORA-08102: index key not found, obj# 16200, file 2, block 4765 (2)


                      Download c18.sql and c1202000.sql from the bug and restart the upgrade process.


Plugging in an Oracle Database 12.1 Non-CDB to an Oracle Database 12.2
Local Undo CDB
                      This topic describes undo tablespaces are not plugged in when going from Oracle Database
                      release 12.1 to release 12.2.
                      When trying to plug in an Oracle Database 12c Release 1 (12.1) non-CDB to an Oracle
                      Database 12c Release 2 (12.2) or higher CDB and local undo is enabled, undo tablespaces
                      are not plugged in.

                      Workaround:
                      None.


Deprecated and Desupported Features for Oracle Database
                      This topic describes deprecated and desupported features for Oracle Database 19c.
                      Oracle Database 19c introduces behavior changes for your database in addition to new
                      features. Changes in behavior include deprecated and desupported initialization parameters,
                      options, syntax, and the deprecation and desupport of features and components. For more
                      information, see the Oracle Database Upgrade Guide.

                      Removal of 3DES Encryption Algorithm in FIPS-Compliant Mode
                      The 3DES encryption algorithm functionality for databases operating in FIPS 140-3 compliant
                      mode is scheduled for removal later this year. Update your systems accordingly.
                      The National Institute of Standards and Technology (NIST) will move FIPS 140-2 to the
                      historical list on 21 September 2026. Oracle is transitioning from FIPS 140-2 to FIPS 140-3
                      validated cryptographic modules for Oracle AI Database 26ai and Oracle Database 19c. FIPS
                      140-3 desupports the 3DES (Triple Data Encryption Standard) encryption algorithms. In
                      compliance with this change to the updated standard, Oracle Database is desupporting the use
                      of 3DES for Oracle Database 19c when databases are configured to run in FIPS 140-3
                      compliant mode. Support for 3DES in FIPS -complaint databases is scheduled for removal in



Database Release Notes
E96072-37                                                                                                  March 26, 2026
Copyright © 2017, 2026, Oracle and/or its affiliates.                                                         Page 2 of 9
                                                                                                                Chapter 2
                                                                                                 Oracle Database Security


                      2026 with Oracle Database 19c Release Update 19.32. Oracle AI Database 26ai already
                      desupports 3DES for use when the database is configured for FIPS 140-3.
                      In line with current security best practices, Oracle recommends transitioning to the Advanced
                      Encryption Standard (AES). AES offers improved security, performance, and resistance to
                      known attacks. Review your encryption configurations (including transparent data encryption
                      and network encryption) to ensure that you do not use 3DES. If you have not already done so,
                      convert Oracle Wallets created prior to Oracle Database 19.22 to use AES. If you find any use
                      of 3DES, then transition to a more secure cipher such as AES. For additional details, refer to
                      appendix E of the Oracle Database Security Guide.


Oracle Database Security
                      Oracle provides a patch that will strengthen native network encryption security for both Oracle
                      Database servers and clients.



                                See Also
                                Oracle Database Security Guide



Other Readmes, Release Notes, or Installation Guides
                      There are additional documents for Oracle products that are associated with this Oracle
                      Database release.
                      Refer to the following Oracle products and the location of their associated readme, release
                      notes, or installation guide for additional information:

                      Table 2-1       Other Oracle Products Documentation

                       Product                          Document
                       Oracle Multimedia                ORACLE_HOME/ord/im/admin/README.txt
                       Oracle ODBC Driver               Oracle ODBC Driver Release Notes
                       Oracle SQL Developer             ORACLE_HOME/sqldeveloper/readme.html
                       Pro*C                            Pro*C/C++ Release Notes
                       Pro*COBOL                        Pro*COBOL Release Notes
                       SQL*Plus                         SQL*Plus Release Notes


Open Bugs Affecting All Platforms
                      This section describes known bugs in Oracle Database 19c that affect all platforms.
                      •     Analytic Workspace Manager Known Bugs
                            These are the Analytic Workspace Manager bugs in Oracle Database 19c.
                      •     Oracle ASM Cluster File System (Oracle ACFS) Known Bugs
                            These are the Oracle Automatic Storage Management (Oracle ASM) Cluster File System
                            (Oracle ACFS) bugs in Oracle Database 19c.




Database Release Notes
E96072-37                                                                                                 March 26, 2026
Copyright © 2017, 2026, Oracle and/or its affiliates.                                                        Page 3 of 9
                                                                                                                 Chapter 2
                                                                                         Open Bugs Affecting All Platforms


                      •     Oracle ASM Dynamic Volume Manager (Oracle ADVM) Known Bugs
                            These are the Oracle Automatic Storage Management (Oracle ASM) Dynamic Volume
                            Manager (Oracle ADVM) bugs in Oracle Database 19c.
                      •     Oracle Data Pump Known Bugs
                            These are the Oracle Data Pump bugs in Oracle Database 19c.
                      •     Oracle Database Enterprise Edition Known Bugs
                            These are the Oracle Database Enterprise Edition bugs in Oracle Database 19c.
                      •     Oracle Grid Infrastructure Known Bugs
                            These are the Oracle Grid Infrastructure bugs in Oracle Database 19c.
                      •     Oracle Universal Installer Known Bugs
                            These are the Oracle Universal Installer (OUI) bugs in Oracle Database 19c.


Analytic Workspace Manager Known Bugs
                      These are the Analytic Workspace Manager bugs in Oracle Database 19c.
                      •     Bug 28937717
                      •     Bug 28532773

Bug 28937717
                      Measures cannot be calculated in the Create Calculation Measure wizard.

                      Workaround:
                      None.

Bug 28532773
                      Cube Storage Advisor fails with the following error:

                      ORA-00942 table or view not found


                      Workaround:
                      None.


Oracle ASM Cluster File System (Oracle ACFS) Known Bugs
                      These are the Oracle Automatic Storage Management (Oracle ASM) Cluster File System
                      (Oracle ACFS) bugs in Oracle Database 19c.
                      •     Bug 29391849

Bug 29391849
                      After an upgrade to either Oracle Grid 18.x or 19.x is complete, a subsequent upgrade to
                      Oracle Grid 18.y or 19.y results in the Oracle Automatic Storage Management Cluster File
                      System (Oracle ACFS) being offline on the first node being upgraded. This issue does not
                      occur on a fresh installation of Oracle Grid 19c or 18c.




Database Release Notes
E96072-37                                                                                                  March 26, 2026
Copyright © 2017, 2026, Oracle and/or its affiliates.                                                         Page 4 of 9
                                                                                                                   Chapter 2
                                                                                           Open Bugs Affecting All Platforms



                      Workaround:
                      •     To avoid this issue:
                            1.   Complete the upgrade from Oracle Grid 12c Release 1 (12.1.0.2) or Oracle Grid 12c
                                 Release 2 (12.2) to Oracle Grid 18.x or 19.x.
                            2.   Restart Cluster Ready Services (CRS) on each node, restarting the master node last.
                                 For example:
                                 a.   Run acfsutil clusterinfo | grep -i master .
                                 b.   Restart CRS on each non-master node, in any order.
                                 c.   Restart CRS on the master node last.
                            3.   Then, upgrade from Oracle Grid 18.x or 19.x to Oracle Grid 18.y or 19.y.
                      •     If you have completed the upgrade from Oracle Grid 12.1.0.2 or 12.2 to Oracle Grid 18.x or
                            19.x, and have started the upgrade to Oracle Grid 18.y or 19.y, and if you see the Oracle
                            Automatic Storage Management Dynamic Volume Manager (Oracle ADVM) volumes
                            offline on the node that you have upgraded, then:
                            1.   Roll back that node to Oracle Grid 18.x or 19.x.
                            2.   Restart CRS on each node, restarting the master node last.
                                 a.   Run acfsutil clusterinfo | grep -i master .
                                 b.   Restart CRS on each non master node, in any order.
                                 c.   Restart CRS on the master node last.
                            3.   Then, upgrade from Oracle Grid 18.x or 19.x to Oracle Grid 18.y or 19.y.


Oracle ASM Dynamic Volume Manager (Oracle ADVM) Known Bugs
                      These are the Oracle Automatic Storage Management (Oracle ASM) Dynamic Volume
                      Manager (Oracle ADVM) bugs in Oracle Database 19c.
                      •     Bug 29520544

Bug 29520544
                      Upgrading to Oracle Grid 19c or 18c can cause unnecessary disk resilvering (if using more
                      than 1 MB of allocation units (AU)). This issue does not occur on a fresh installation of Oracle
                      Grid 19c or 18c.

                      Workaround:
                      Apply the patch for 29520544 before upgrading to Oracle Grid 19c or 18c. Note that the patch
                      can be applied on the initiating system (Oracle Grid 12c Release 1 (12.1.0.2) or Oracle Grid
                      12c Release 2 (12.2)) before the upgrade or the patch can be applied on the receiving system
                      (Oracle Grid 19c or 18c) before the upgrade.
                      Allow resilvering to complete. This is a one-time operation. Once the resilvering completes,
                      performance returns to normal.


Oracle Data Pump Known Bugs
                      These are the Oracle Data Pump bugs in Oracle Database 19c.



Database Release Notes
E96072-37                                                                                                    March 26, 2026
Copyright © 2017, 2026, Oracle and/or its affiliates.                                                           Page 5 of 9
                                                                                                                   Chapter 2
                                                                                           Open Bugs Affecting All Platforms


                      •     Bug 27092988

Bug 27092988
                      In releases prior to Oracle Database 19c, the Oracle Data Pump always enabled secure roles
                      that were granted to the user running the data pump. Starting in Oracle Database 19c, the data
                      pump no longer enables these roles by default. There is a new parameter,
                      ENABLE_SECURE_ROLES, to control whether those roles should be enabled for the data pump job.

                      Workaround:
                      None.


Oracle Database Enterprise Edition Known Bugs
                      These are the Oracle Database Enterprise Edition bugs in Oracle Database 19c.
                      •     Bug 23569490
                      •     Bug 24291322
                      •     Bug 27254644

Bug 23569490
                      If you have a large number of collections and are working with clients earlier than Oracle
                      Database 12c release 2 (12.2), then you need a larger object cache, due to a change in
                      snapshot size and thus a need for collection image conversion.

                      Workaround:
                      The object cache size can be set using the OBJECT_CACHE_OPTIMAL_SIZE initialization
                      parameter. This is set to a low value by default.

Bug 24291322
                      Symbolic links are not allowed in the directory object paths or filenames when opening BFILEs.
                      The entire directory path and filename is checked and the following error is returned if any
                      symbolic link is found:

                      ORA-22288: file or LOB operation FILEOPEN failed soft link in path


                      Workaround:
                      If the database directory object or filename that you are trying to open contains symbolic links,
                      then change it to provide the real path and filename.

Bug 27254644
                      During the Oracle Scheduler agent register database process (schagent -registerdatabase),
                      the following warning message might be issued:

                      "Warning: The JKS keystore uses a proprietary format. It is recommended to
                      migrate
                      to PKCS12 which is an industry standard format using..."



Database Release Notes
E96072-37                                                                                                    March 26, 2026
Copyright © 2017, 2026, Oracle and/or its affiliates.                                                           Page 6 of 9
                                                                                                                 Chapter 2
                                                                                         Open Bugs Affecting All Platforms



                      Workaround:
                      This warning message is due to a new Java runtime update. There is no change in the Oracle
                      Scheduler agent usage of keystores (jks files). You can ignore this warning message.


Oracle Grid Infrastructure Known Bugs
                      These are the Oracle Grid Infrastructure bugs in Oracle Database 19c.
                      •     Bug 29414664
                      •     Bug 29053083
                      •     Bug 21559133

Bug 29414664
                      The Help text for command rhpctl instantiate image does not show the -server option.

                      Workaround:
                      When instantiating an image between two Fleet Patching and Provisioning (FPP) servers
                      whose peer-to-peer relationship has already been established, use the command rhpctl
                      instantiate image with the -server option specifying the remote FPP server from which to
                      instantiate the given image.

Bug 29053083
                      The Grid Naming Service (GNS) manifest file validation fails.

                      Workaround:
                      Do not add GNS while creating a member cluster manifest file.

Bug 21559133
                      This issue affects rolling upgrades from Oracle Grid Infrastructure 12c release 1 (12.1) to
                      Oracle Grid Infrastructure 19c of Oracle Clusterware standard Cluster with Oracle ASM. A
                      node running Oracle Grid Infrastructure 12c release 1 (12.1) cannot join the cluster after the
                      first node has been upgraded to Oracle Grid Infrastructure 19c. The nodes running Oracle Grid
                      Infrastructure 12c release 1 (12.1) that are in ONLINE status continue to be members of the
                      cluster.

                      Workaround:
                      Upgrade Oracle Grid Infrastructure from 12c release 1 (12.1) to 19c on the failed node.


Oracle Universal Installer Known Bugs
                      These are the Oracle Universal Installer (OUI) bugs in Oracle Database 19c.
                      You should also review Compatibility, Upgrading, Downgrading, and Installation for other
                      issues related to installation and upgrades.
                      •     Bug 18336219
                      •     Bug 23006768


Database Release Notes
E96072-37                                                                                                  March 26, 2026
Copyright © 2017, 2026, Oracle and/or its affiliates.                                                         Page 7 of 9
                                                                                                                   Chapter 2
                                                                                           Open Bugs Affecting All Platforms


                      •     Bug 27080535
                      •     Bug 27120934

Bug 18336219
                      Oracle Database installer does not check if the password specified for ASMSNMP on the Specify
                      Management Options screen is correct. If you proceed with the configuration and specify an
                      incorrect password, then Oracle Enterprise Manager Cloud Control cannot discover details and
                      monitor the Oracle ASM instance.

                      Workaround #1:
                      Ensure that the correct password (the same password specified earlier during the Oracle Grid
                      Infrastructure for a cluster installation) is specified in the Specify Management Options screen
                      of Oracle Database installer.

                      Workaround #2:
                      On the Oracle Enterprise Manager Cloud Control portal, navigate to the Oracle ASM
                      credentials screen and update the password for ASMSNMP. Once the password is saved on
                      Oracle Enterprise Manager Cloud Control, the Oracle ASM monitoring starts working.

Bug 23006768
                      When installing an Oracle RAC database on an Oracle Member Cluster for Database that is
                      configured to use an Oracle ASM service of an Oracle Domain Services Cluster (DSC) and, if
                      the network selected for ASM or ASM & Private usage is not of the same type as the Oracle
                      ASM network of the DSC, then the database instance terminates with the following error:

                      IOS hit ORA-00600: internal error code, arguments: [kfias_creg!net]


                      Workaround:
                      During the installation of the Oracle Member Cluster for Database, choose the network
                      interface for ASM or ASM & Private so that it is on the same network as the Oracle ASM
                      network of the DSC.

Bug 27080535
                      When deinstalling the Oracle Grid Infrastructure for a standalone server home with an Oracle
                      Management Server configuration, the emConfig.txt file in ORACLE_BASE/admin/emca is not
                      deleted.

                      Workaround:
                      To remove the emConfig.txt file, run the following command:

                      rm -rf $ORACLE_BASE/admin/emca/emConfig.txt


                      During the last ORACLE_HOME deinstallation, to remove ORACLE_BASE, run the following command
                      after the deinstallation tool exits:

                      rm -rf $ORACLE_BASE




Database Release Notes
E96072-37                                                                                                    March 26, 2026
Copyright © 2017, 2026, Oracle and/or its affiliates.                                                           Page 8 of 9
                                                                                                               Chapter 2
                                                                                       Open Bugs Affecting All Platforms



Bug 27120934
                      After downgrading Oracle Clusterware using the Grid Setup Wizard, from Oracle Database 19c
                      to Oracle Clusterware release 12.1 or release 11.2, the unused data files of the Oracle Grid
                      Infrastructure Management Repository (GIMR) of the 19c Oracle Grid Infrastructure home
                      could still be present in the disk group.

                      Workaround:
                      Before starting the downgrade procedure using the Grid Setup Wizard, delete the GIMR
                      database using the following command:

                      <Active_GI_HOME>/bin/dbca -silent -deleteDatabase -sourceDB -MGMTDB




Database Release Notes
E96072-37                                                                                                March 26, 2026
Copyright © 2017, 2026, Oracle and/or its affiliates.                                                       Page 9 of 9
3
Issues Affecting Linux for Oracle Database
19c
                      These topics contain last-minute features and changes for Linux for Oracle Database 19c.
                      •     Certification Information
                            The latest certification information for Oracle Database 19c is available in My Oracle
                            Support note 1304727.2:
                      •     Unsupported Products for Linux
                            This topic describes products or features that are unavailable for Oracle Database 19c.
                      •     Product Support
                            This topic describes the supported products or features for Oracle Database 19c.
                      •     Linking Applications with Oracle Client Libraries for Linux
                            You must use the dynamic Oracle client libraries to link the client code on Linux.
                      •     Preinstallation Requirements for the Linux Platform
                            Refer to the installation guides for the preinstallation requirements for Oracle Database
                            19c.
                      •     Open Bugs Affecting Linux
                            This topic contains last-minute features and changes for Oracle Database 19c.
                      •     Known Issues and Bugs for SUSE Linux Enterprise Server 15
                            This section contains information about issues related to SUSE Linux Enterprise Server
                            15:
                      •     Unsupported Products for Oracle Database 19c on Oracle Linux 8
                            The following products or features are unavailable for Oracle Database 19c on Oracle
                            Linux 8.
                      •     Known Issues and Bugs for Oracle Linux 8 and Red Hat Enterprise Linux 8
                            This section contains information about issues related to Oracle Linux 8 and Red Hat
                            Enterprise Linux 8:
                      •     Installing Oracle Database 19c on Oracle Linux 8 and Red Hat Enterprise Linux 8
                            To install Oracle Database 19c on Oracle Linux 8 or Red Hat Enterprise Linux 8, download
                            the 19.3 Oracle Database software binaries from Oracle Technology Network (OTN), and
                            then apply the 19.18 release updates (RUs) during the Oracle Database and Oracle Grid
                            Infrastructure installation or upgrade process.
                      •     Installing Oracle Database 19c (19.22) on Oracle Linux 9 and Red Hat Enterprise Linux 9
                            Oracle recommends that you install Oracle Database 19c Release 19.22 or later on Oracle
                            Linux 9 and Red Hat Enterprise Linux 9.
                      •     Installing Oracle Database Client 64-bit 19c (19.22) on Oracle Linux 9 and Red Hat
                            Enterprise Linux 9
                            Oracle recommends that you install Oracle Database Client 19c Release 19.22 or later on
                            Oracle Linux 9 and Red Hat Enterprise Linux 9.
                      •     Installing Oracle Database Gateway 19c (19.21) on Oracle Linux 9 and Red Hat Enterprise
                            Linux 9
                            Oracle recommends that you use Oracle Database Client 19c Release 19.21 or later to
                            install Oracle Database Gateway on Oracle Linux 9 and Red Hat Enterprise Linux 9.


Database Release Notes
E96072-37                                                                                                   March 26, 2026
Copyright © 2017, 2026, Oracle and/or its affiliates.                                                         Page 1 of 18
                                                                                                                    Chapter 3
                                                                                                     Certification Information


                      •     Installing Oracle Database Client 32-bit 19c (19.19) on Oracle Linux 9 and Red Hat
                            Enterprise Linux 9
                            Oracle recommends that you install Oracle Database Client 32-bit 19c Release 19.19 or
                            later on Oracle Linux 9 and Red Hat Enterprise Linux 9.
                      •     Unsupported Products for Oracle Database 19c on Oracle Linux 9 and Red Hat Enterprise
                            Linux 9
                            This topic describes products or features that are unavailable for Oracle Database 19c on
                            Oracle Linux 9 and Red Hat Enterprise Linux 9.
                      •     Known Issues and Bugs for Oracle Linux 9 and Red Hat Enterprise Linux 9 on Oracle
                            Database
                            This section contains information about issues related to Oracle Linux 9 and Red Hat
                            Enterprise Linux 9 on Oracle Database Client:
                      •     Known Issues and Bugs for Standard Edition High Availability
                            This section contains information about issues related to Standard Edition High Availability:


Certification Information
                      The latest certification information for Oracle Database 19c is available in My Oracle Support
                      note 1304727.2:
                      https://support.oracle.com/epmos/faces/DocumentDisplay?id=1304727.2
                      Oracle Linux 7
                      Starting with Oracle Database 19c, release update (RU) 19.9, Oracle Linux 7.7 with the
                      Unbreakable Enterprise Kernel 6: 5.4.17-2011.4.4.el7uek.x86_64 or later is supported on Linux
                      x86-64.
                      Refer to Oracle Database Installation Guide for Linux for the preinstallation requirements.


Unsupported Products for Linux
                      This topic describes products or features that are unavailable for Oracle Database 19c.
                      In addition to the list of unavailable products or features in this release of Oracle Database 19c,
                      the following product is not supported for Linux:
                      •     IPv6 Networks Support
                            The IPv6 based IP addresses to configure the private networks for a cluster is not
                            supported on IBM: Linux on System z. It is currently under testing and the support will be
                            announced after testing is successfully complete.
                      •     Oracle ACFS
                            Oracle Automatic Storage Management Cluster File System (Oracle ACFS) is not
                            supported on Oracle Linux 8 and Red Hat Enterprise Linux 8 on Oracle Database 19c
                            release update RU (19.6) and RU (19.7).


Product Support
                      This topic describes the supported products or features for Oracle Database 19c.
                      The supported products or features are:
                      •     Database Smart Flash Cache Support
                            Database Smart Flash Cache is supported on Oracle Linux.

Database Release Notes
E96072-37                                                                                                    March 26, 2026
Copyright © 2017, 2026, Oracle and/or its affiliates.                                                          Page 2 of 18
                                                                                                                         Chapter 3
                                                                        Linking Applications with Oracle Client Libraries for Linux


                      •     Oracle ACFS
                            Oracle Automatic Storage Management Cluster File System (Oracle ACFS) is supported
                            on Oracle Linux 9.2 or later and Red Hat Enterprise Linux 9.2 or later on Oracle Database
                            19c starting with release update RU 19.21 (along with the patch) and later..
                            For the latest information about supported platforms and releases, see the Note 1369107.1
                            on My Oracle Support at https://support.oracle.com
                      •     Oracle ADVM
                            Although Oracle ADVM supports raw disks in Oracle Automatic Storage Management disk
                            groups, Oracle ADVM device special files created through raw are not supported; Oracle
                            ADVM only supports block device special files.
                            For the latest information about supported platforms and releases, see the Note 1369107.1
                            on My Oracle Support at https://support.oracle.com
                      •     Oracle ASM Filter Driver Support
                            Oracle Automatic Storage Management Filter Driver (Oracle ASMFD) is supported only on
                            Linux x86-64.
                      •     Oracle ASM library (Oracle ASMLIB)
                            Oracle ASM library (Oracle ASMLIB) is supported on Oracle Linux 6 or later and Red Hat
                            Enterprise Linux 6 or later on Oracle Database 19c starting with release update RU 19.21
                            (along with the patch) and later.
                      •     Share-based Instance Caging
                            Share-based Instance Caging is supported on Oracle Linux.


Linking Applications with Oracle Client Libraries for Linux
                      You must use the dynamic Oracle client libraries to link the client code on Linux.
                      Do not link the static Oracle client libraries.


Preinstallation Requirements for the Linux Platform
                      Refer to the installation guides for the preinstallation requirements for Oracle Database 19c.


Open Bugs Affecting Linux
                      This topic contains last-minute features and changes for Oracle Database 19c.
                      •     Bug 26708302


Bug 26708302
                      Deinstallation of Oracle Real Application Clusters (Oracle RAC) home on shared Network
                      Attached Storage (NAS) fails to delete the directory $ORACLE_HOME/deinstall and returns the
                      following error:
                      Failed to delete the directory $ORACLE_HOME/deinstall. Either user has no
                      permission to delete or it is in use.

                      Workaround:



Database Release Notes
E96072-37                                                                                                          March 26, 2026
Copyright © 2017, 2026, Oracle and/or its affiliates.                                                                Page 3 of 18
                                                                                                                 Chapter 3
                                                                 Known Issues and Bugs for SUSE Linux Enterprise Server 15


                      Manually delete the $ORACLE_HOME/deinstall folder as either the Oracle RAC owner or as
                      root.


Known Issues and Bugs for SUSE Linux Enterprise Server 15
                      This section contains information about issues related to SUSE Linux Enterprise Server 15:
                      •     Bug 29953021
                      •     Bug 29916735
                      •     Bug 29836096
                      •     Bug 29742223
                      •     Bug 30131474


Bug 29953021
                      To install Oracle Database software 19.4 on SUSE Linux Enterprise Server 15, download the
                      Oracle Database software binaries from Oracle Technology Network (OTN), and then apply the
                      19.4 release updates (RUs) during the the Oracle Database and Oracle Grid Infrastructure
                      installation or upgrade process.
                      Workaround:
                      During the Oracle Database and Oracle Grid Infrastructure installation process, run the
                      runInstaller and gridSetup.sh commands with the -applyRU and -applyOneOffs
                      options to install the latest 19.4 RU for SUSE Linux Enterprise Server 15:
                      Oracle Grid Infrastructure without Oracle ACFS and Oracle ADVM:

                       $ 19.3_grid_home/gridSetup.sh -applyRU 19.4GIRU patch 29708769 -applyOneOffs
                      patch 30171454


                      Oracle Grid Infrastructure with Oracle ACFS and Oracle ADVM:

                      $ 19.3_grid_home/gridSetup.sh -applyRU 19.4GIRU patch 29708769 -applyOneOffs
                      patch 30171454, patch 28321248


                      Oracle Real Applications Cluster or Oracle Database (with Oracle Restart):

                      $ 19.3_dbhome/runInstaller -applyRU 19.4GIRU patch 29708769 -applyOneOffs
                      patch 30171454


                      Single-instance Oracle Database:

                      $ 19.3_dbhome/runInstaller -applyRU 19.4DBRU patch 29834717 -applyOneOffs
                      patch 30083976




Database Release Notes
E96072-37                                                                                                  March 26, 2026
Copyright © 2017, 2026, Oracle and/or its affiliates.                                                        Page 4 of 18
                                                                                                                    Chapter 3
                                                                    Known Issues and Bugs for SUSE Linux Enterprise Server 15



Bug 29916735
                      On SUSE Linux Enterprise Server 15, after upgrading Oracle Grid Infrastructure to 19.4 GIRU,
                      CPU usage increases when you run OSWatcher.
                      Workaround:
                      Perform the following steps:
                      1.    Enter the following command to stop OSWatcher from Oracle Trace File Analyzer (Oracle
                            TFA):

                            $ grid_home/bin/tfactl stop       oswbb to stop

                      2.    Add disown -a to the main loop inside OSWatcher.sh.
                      3.    Set ulimit to a sufficiently low value for the user running OSWatcher.
                      This issue is fixed in OSWatcher 8.3.1.
                      See My Oracle Support Note 301137.1 for more information:
                      https://support.oracle.com/rs?type=doc&id=301137.1


Bug 29836096
                      libstdc++33 package missing error during Oracle Instant Client installation.

                      Workaround:
                      In the Perform Prerequisite Checks screen, select Ignore All and proceed with the
                      installation.
                      For non-interactive or silent installations, run the following command:

                      $./runInstaller -ignorePrereq


Bug 29742223
                      If you install single instance Oracle Database 19c on SUSE Linux Enterprise Server 15 or
                      SUSE Linux Enterprise Server 12 SP3 with 19.8 or later DBRU, then you may encounter a
                      prerequisite error for the libstdc++33-3.3.3-62.1 package.

                      Workaround 1:
                      The libstdc++33-3.3.3-62.1 package is not required on SUSE Linux Enterprise Server 15 or
                      SUSE Linux Enterprise Server 12 SP3.
                      In the Perform Prerequisite Checks screen, select Ignore All and proceed with the
                      installation.
                      Workaround 2:
                      Apply 19c Oracle Clusterware Release Update (OCWRU) that is bundled in the 19c Oracle
                      Grid Infrastructure Release Update (GIRU) along with Oracle Database 19c Release Update
                      (DBRU) 19.8 or later.




Database Release Notes
E96072-37                                                                                                     March 26, 2026
Copyright © 2017, 2026, Oracle and/or its affiliates.                                                           Page 5 of 18
                                                                                                                     Chapter 3
                                                                Unsupported Products for Oracle Database 19c on Oracle Linux 8



Bug 30131474
                      libgfortran package missing error during Oracle Database 19.4 installation on SUSE Linux
                      Enterprise Server 15
                      Workaround:
                      Ignore the warning and ensure that you install the libgfortran4-7.3.1+r258812-2.15.x86_64
                      package on the system.


Unsupported Products for Oracle Database 19c on Oracle Linux
8
                      The following products or features are unavailable for Oracle Database 19c on Oracle Linux 8.
                      •     DBnest


Known Issues and Bugs for Oracle Linux 8 and Red Hat
Enterprise Linux 8
                      This section contains information about issues related to Oracle Linux 8 and Red Hat
                      Enterprise Linux 8:
                      •     Bug 30878668
                      •     Bug 30445619
                      •     Bug 36567521
                      •     Bug 36565959
                      •     Bug 29772579


Bug 30878668
                      The sudo option for running root configuration scripts does not work during Oracle Database
                      19c or Oracle Grid Infrastructure 19c installations on Oracle Linux 8 or Red Hat Enterprise
                      Linux 8 systems.
                      Workaround:
                      Run the root configuration scripts manually as the root user.


Bug 30445619
                      On Oracle Linux 8 or Red Hat Enterprise Linux 8, C++ applications built with g++8 cannot be
                      used with Oracle C++ Call Interface (OCCI).
                      Workaround:
                      For building applications with g++8, use the following compilation options:

                      -D_GLIBCXX_USE_CXX11_ABI=0 -Wno-narrowing




Database Release Notes
E96072-37                                                                                                      March 26, 2026
Copyright © 2017, 2026, Oracle and/or its affiliates.                                                            Page 6 of 18
                                                                                                                              Chapter 3
                                                        Installing Oracle Database 19c on Oracle Linux 8 and Red Hat Enterprise Linux 8



Bug 36567521
                      All Pro*C demos fail during compilation on Oracle Database 19c on Oracle Linux 8 and Red
                      Hat Enterprise Linux 8.
                      Workaround:
                      Manually add the gcc include path in the pcscfg.cfg file with the sys_include option.

                      sys_include=/usr/lib/gcc/x86_64-redhat-linux/8/include


Bug 36565959
                      On Oracle Linux 8 or Red Hat Enterprise Linux 8, C++ applications built with g++11 cannot be
                      used with Oracle C++ Call Interface (OCCI).
                      Workaround:
                      For building applications with g++11, use the following compilation options:

                      -D_GLIBCXX_USE_CXX11_ABI=0 -Wno-narrowing


Bug 29772579
                      compat-libcap1-1.10 package missing error during single-instance Oracle Database and
                      Oracle Database Client installations on Oracle Linux 8 and Red Hat Enterprise Linux 8.
                      Workaround:
                      In the Perform Prerequisite Checks screen, for the compat-libcap1-1.10 missing check,
                      select Ignore All, and click Install to continue with the installation.


                                Note
                                Ensure that you fix all other checks and issues that are listed in the screen.




Installing Oracle Database 19c on Oracle Linux 8 and Red Hat
Enterprise Linux 8
                      To install Oracle Database 19c on Oracle Linux 8 or Red Hat Enterprise Linux 8, download the
                      19.3 Oracle Database software binaries from Oracle Technology Network (OTN), and then
                      apply the 19.18 release updates (RUs) during the Oracle Database and Oracle Grid
                      Infrastructure installation or upgrade process.




Database Release Notes
E96072-37                                                                                                               March 26, 2026
Copyright © 2017, 2026, Oracle and/or its affiliates.                                                                     Page 7 of 18
                                                                                                                                 Chapter 3
                                                   Installing Oracle Database 19c (19.22) on Oracle Linux 9 and Red Hat Enterprise Linux 9



                                Note
                                •    Starting with Oracle Database 19c Release 19.21, Oracle Linux 8.8 with the
                                     Unbreakable Enterprise Kernel 7 is supported.
                                •    Starting with Oracle Grid Infrastructure 19c Release 19.23, Oracle Linux 8.8 with
                                     the Unbreakable Enterprise Kernel 7 is supported.



                      Installation Process:
                      During the Oracle Database and Oracle Grid Infrastructure installation process, run the
                      runInstaller and gridSetup.sh commands with the -applyRU and -applyOneOffs
                      options to install the latest 19.18 RU for Oracle Linux 8 and Red Hat Enterprise Linux 8:
                      Single-instance Oracle Database (19.18):

                      $ export CV_ASSUME_DISTID=OL7
                      $ 19.3_dbhome/runInstaller -applyRU 19.18DBRU patch 34765931 location


                      Oracle Grid Infrastructure (19.18):

                      $ 19.3_grid_home/gridSetup.sh -applyRU 19.18GIRU patch 34762026 location


                      Oracle Real Applications Cluster (19.18):

                      $ 19.3_dbhome/runInstaller -applyRU 19.18GIRU patch 34762026 location



Installing Oracle Database 19c (19.22) on Oracle Linux 9 and
Red Hat Enterprise Linux 9
                      Oracle recommends that you install Oracle Database 19c Release 19.22 or later on Oracle
                      Linux 9 and Red Hat Enterprise Linux 9.
                      To install Oracle Database 19c on Oracle Linux 9 and Red Hat Linux 9, download the 19.3
                      Oracle Database software binaries from the Oracle website, and then apply the 19.22 release
                      updates (RUs) during the installation process.
                      Installation Process:
                      During the Oracle Database and Oracle Grid Infrastructure installation process, run the
                      runInstaller and gridSetup.sh commands with the -applyRU and -applyOneOffs
                      options to install the latest 19.22 RU for Oracle Linux 9 and Red Hat Enterprise Linux 9.
                      Oracle Grid Infrastructure (19.22):
                      1.    Unzip the 19.3.0.0.0 Oracle Grid Infrastructure gold image.
                      2.    Copy the OPatch utility version 12.2.0.1.40 or later from My Oracle Support patch 6880880
                            by selecting the 19.0.0.0.0 release.
                      3.    Install Oracle Grid Infrastructure by running gridSetup.sh with applyRU to create and install
                            Oracle Grid Infrastructure 19.22 by running the following command:
                            From the 19.3 GI home, run



Database Release Notes
E96072-37                                                                                                                  March 26, 2026
Copyright © 2017, 2026, Oracle and/or its affiliates.                                                                        Page 8 of 18
                                                                                                                                 Chapter 3
                                     Installing Oracle Database Client 64-bit 19c (19.22) on Oracle Linux 9 and Red Hat Enterprise Linux 9


                            $ gridSetup.sh -applyRU <19.22 GIRU Patch 35940989 location>
                      Oracle Real Application Clusters (19.22):
                      1.    Unzip the 19.3.0.0.0 Oracle Database gold image.
                      2.    Copy the OPatch utility version 12.2.0.1.40 or later from My Oracle Support patch 6880880
                            by selecting the 19.0.0.0.0 release.
                      3.    Install Oracle Real Applications Cluster (Oracle RAC) software with $ 19.3 on-prem_db_
                            image/runInstaller -applyRU <19.22 GIRU Patch 35940989 location>
                      4.    Run Oracle Database Configuration Assistant (DBCA) to create the Oracle Real
                            Applications Cluster (Oracle RAC).
                      Single-instance Oracle Database (19.22):
                      1.    Set the environment variable CV_ASSUME_DISTID to OL7 ($export
                            CV_ASSUME_DISTID=OL7).
                      2.    Unzip the 19.3.0.0.0 Oracle Database gold image.
                      3.    Copy the OPatch utility version 12.2.0.1.40 or later from My Oracle Support patch 6880880
                            by selecting the 19.0.0.0.0 release.
                      4.    Install Single-instance Oracle Database with $ 19.3 on-prem_db_ image/runInstaller -
                            applyRU <19.22 DBRU Patch 35943157 location>
                      Oracle Restart with Single-instance Oracle Database (19.22):
                      Oracle Restart (19.22)
                      1.    Unzip the 19.3.0.0.0 Oracle Grid Infrastructure gold image.
                      2.    Copy the OPatch utility version 12.2.0.1.40 or later from My Oracle Support patch 6880880
                            by selecting the 19.0.0.0.0 release.
                      3.    Install Oracle Grid Infrastructure with $ 19.3 on-prem_grid_ image/gridSetup.sh applyRU
                            <19.22 GIRU Patch 35940989 location>
                      Single-instance Oracle Database on Oracle Automatic Storage Management (Oracle
                      ASM) with Oracle Restart (19.22)
                      1.    Unzip the 19.3.0.0.0 Oracle Database gold image.
                      2.    Copy the OPatch utility version 12.2.0.1.40 or later from My Oracle Support patch 6880880
                            by selecting the 19.0.0.0.0 release.
                      3.    Install Single-instance Oracle Database with $ 19.3 on-prem_db_ image/runInstaller
                            applyRU <19.22 GIRU Patch 35940989 location>


Installing Oracle Database Client 64-bit 19c (19.22) on Oracle
Linux 9 and Red Hat Enterprise Linux 9
                      Oracle recommends that you install Oracle Database Client 19c Release 19.22 or later on
                      Oracle Linux 9 and Red Hat Enterprise Linux 9.
                      To install Oracle Database Client 19c on Oracle Linux 9 and Red Hat Linux 9, download the
                      19.3 Oracle Database Client software binaries from the Oracle website, and then apply the
                      19.22 release updates (RUs) during the installation process.




Database Release Notes
E96072-37                                                                                                                 March 26, 2026
Copyright © 2017, 2026, Oracle and/or its affiliates.                                                                       Page 9 of 18
                                                                                                                                 Chapter 3
                                     Installing Oracle Database Client 64-bit 19c (19.22) on Oracle Linux 9 and Red Hat Enterprise Linux 9


                      During the Oracle Database Client gold image installation process, run the runInstaller
                      command with the -applyRU and -applyOneOffs options to install the latest 19.22 RU for
                      Oracle Linux 9 and Red Hat Enterprise Linux 9.
                      Oracle Database Client (19.22) Gold Image Installation

                      $ export CV_ASSUME_DISTID=OL7
                      $ 19.3_clienthome/runInstaller -applyRU <19.22DBRU patch 35943157 location>


                      During the Oracle Database Client gold image installation process, run the runInstaller
                      command with the -applyRU and -applyOneOffs options to install the latest 19.22 RU for
                      Oracle Linux 9 and Red Hat Enterprise Linux 9.
                      Oracle Database Client (19.22) Shiphome-based Installation

                      $ export CV_ASSUME_DISTID=OL7
                      $ 19.3_clienthome/runInstaller



                                Note
                                •    Ignore the linking errors during 19.3 client installations and 19.22DBRU.
                                •    After the 19.3 Oracle Database Client installation is complete, apply the 19.22DBRU
                                     patch 35943157.



                      During the Oracle Database Client shiphome based installation process, run the runInstaller
                      command to install the latest 19.22 RU for Oracle Linux 9 and Red Hat Enterprise Linux 9.
                      Oracle Database Global Service Manager (19.22) Shiphome-based Installation

                      $ export CV_ASSUME_DISTID=OL7
                      $ 19.3_gsmhome/runInstaller



                                Note
                                •    Ignore the linking errors during 19.3 client installations and 19.22DBRU.
                                •    After the 19.3 Oracle Database Global Service Manager installation is complete,
                                     apply the 19.22DBRU patch 35943157.




                                Note
                                For all Client and GSM installations, after you apply a patch, ensure that you run the
                                following command to relink executables and libraries in $ORACLE_HOME:

                                $ORACLE_HOME/bin/relink as_installed




Database Release Notes
E96072-37                                                                                                                 March 26, 2026
Copyright © 2017, 2026, Oracle and/or its affiliates.                                                                      Page 10 of 18
                                                                                                                               Chapter 3
                                         Installing Oracle Database Gateway 19c (19.21) on Oracle Linux 9 and Red Hat Enterprise Linux 9




Installing Oracle Database Gateway 19c (19.21) on Oracle Linux
9 and Red Hat Enterprise Linux 9
                      Oracle recommends that you use Oracle Database Client 19c Release 19.21 or later to install
                      Oracle Database Gateway on Oracle Linux 9 and Red Hat Enterprise Linux 9.
                      To install Oracle Database Gateway 19c on Oracle Linux 9 and Red Hat Linux 9, download the
                      19.3 Oracle Database Client software binaries from the Oracle website, and then apply the
                      19.21 release updates (RUs) during the installation process.

                      Oracle Database Gateway (19.21) Shiphome-based Installation

                      $ export CV_ASSUME_DISTID=OL7
                      $ 19.3_gatewayshome/runInstaller



                                Note
                                •    Ignore the linking errors during 19.3 Oracle Database Gateway installation and
                                     19.21DBRU.
                                •    After the 19.3 Oracle Database Gateway installation is complete, apply the
                                     19.21DBRU patch 35643107, 19.21OneOff patch 35954820, and
                                     19.21OneOff patch 35578393.
                                •    Apply the 19.0.0.0.0 OneOff patch 35578393 if APPC component is
                                     installed during the Oracle Database Gateway installation.




                                Note
                                For Gateway installations, after you apply a patch, ensure that you run the following
                                command to relink executables and libraries in $ORACLE_HOME:

                                $ORACLE_HOME/bin/relink as_installed




Installing Oracle Database Client 32-bit 19c (19.19) on Oracle
Linux 9 and Red Hat Enterprise Linux 9
                      Oracle recommends that you install Oracle Database Client 32-bit 19c Release 19.19 or later
                      on Oracle Linux 9 and Red Hat Enterprise Linux 9.
                      To install Oracle Database Client 19c on Oracle Linux 9 and Red Hat Linux 9, download the
                      19.3 Oracle Database Client software binaries from the Oracle website, and then apply the
                      19.19 release updates (RUs) during the installation process.
                      During the Oracle Database Client gold image installation process, run the runInstaller
                      command with the -applyRU and -applyOneOffs options to install the latest 19.19 RU for
                      Oracle Linux 9 and Red Hat Enterprise Linux 9.


Database Release Notes
E96072-37                                                                                                                March 26, 2026
Copyright © 2017, 2026, Oracle and/or its affiliates.                                                                     Page 11 of 18
                                                                                                                             Chapter 3
                                         Unsupported Products for Oracle Database 19c on Oracle Linux 9 and Red Hat Enterprise Linux 9



                      Oracle Database Client 32-bit (19.19) Gold Image Installation

                      $ export CV_ASSUME_DISTID=OL7
                      $ 19.3_clienthome/runInstaller -applyRU <19.19DBRU patch 35042068 location> -
                      applyOneOffs <19.19OneOff patch 35700050 location>


                      During the Oracle Database Client shiphome based installation process, run the
                      runInstaller command to install the latest 19.19 RU for Oracle Linux 9 and Red Hat
                      Enterprise Linux 9.

                      Oracle Database Client 32-bit (19.19) Shiphome-based Installation

                      $ export CV_ASSUME_DISTID=OL7
                      $ 19.3_clienthome/runInstaller



                                Note
                                •    Ignore the linking errors during 19.3 client installations and 19.19DBRU.
                                •    After the 19.3 Oracle Database Client installation is complete, apply the
                                     19.19DBRU patch 35042068 and 19.19OneOff patch 35700050.




                                Note
                                For 32-bit Client installations, after you apply a patch, ensure that you run the following
                                command to relink executables and libraries in $ORACLE_HOME:

                                $ORACLE_HOME/bin/relink as_installed




Unsupported Products for Oracle Database 19c on Oracle Linux
9 and Red Hat Enterprise Linux 9
                      This topic describes products or features that are unavailable for Oracle Database 19c on
                      Oracle Linux 9 and Red Hat Enterprise Linux 9.
                      •     DBnest
                      •     Oracle Machine Learning for R (OML4R)


Known Issues and Bugs for Oracle Linux 9 and Red Hat
Enterprise Linux 9 on Oracle Database
                      This section contains information about issues related to Oracle Linux 9 and Red Hat
                      Enterprise Linux 9 on Oracle Database Client:
                      •     Bug 35521990


Database Release Notes
E96072-37                                                                                                              March 26, 2026
Copyright © 2017, 2026, Oracle and/or its affiliates.                                                                   Page 12 of 18
                                                                                                                             Chapter 3
                                            Known Issues and Bugs for Oracle Linux 9 and Red Hat Enterprise Linux 9 on Oracle Database


                      •     Bug 35547711
                      •     Bug 35448216
                      •     Bug 35584316
                      •     Bug 35614058
                      •     Bug 36347606
                      •     Bug 36513962


Bug 35521990
                      During Oracle Database Client 32-bit installation on Oracle Linux 9 and Red Hat Enterprise
                      Linux 9, the following warning messages is displayed:

                      /bin/ld: libirc.a(fast_memcpy_pp.o):
                      warning: relocation in read-only section `.text'

                      INFO:
                      /bin/ld: warning: creating DT_TEXTREL in a shared object

                      INFO:
                      /bin/ld: libirc.a(sse2_strspn.o): warning:
                      relocation in read-only section `.text'

                      INFO:
                      /bin/ld: warning: creating DT_TEXTREL in a shared object


                      The following warning messages is displayed during 19.19OneOff patch 35700050:

                      OPatch found the word "warning" in the stderr of the make command.
                      Please look at this stderr. You can re-run this make command.
                      Stderr output:
                      /bin/ld: $ORACLE_HOME/lib/libirc.a(fast_memcpy_pp.o):warning: relocation in
                      read-only section `.text'
                      /bin/ld: warning: creating DT_TEXTREL in a shared object
                      /bin/ld: $ORACLE_HOME/lib/libirc.a(sse2_strspn.o): warning: relocation in
                      read-only section `.text'
                      /bin/ld: warning: creating DT_TEXTREL in a shared object


                      Workaround:
                      Ignore the warning messages.


Bug 35547711
                      compat-libcap1-1.10 and compat-libstdc++-33 packages missing error during Oracle
                      Database Client 32-bit installation on Oracle Linux 9 and Red Hat Enterprise Linux 9.
                      Workaround:
                      In the Perform Prerequisite Checks screen, for the compat-libcap1-1.10 and compat-
                      libstdc++-33 missing checks, select Ignore All, and click Install to continue with the
                      installation.



Database Release Notes
E96072-37                                                                                                              March 26, 2026
Copyright © 2017, 2026, Oracle and/or its affiliates.                                                                   Page 13 of 18
                                                                                                                             Chapter 3
                                            Known Issues and Bugs for Oracle Linux 9 and Red Hat Enterprise Linux 9 on Oracle Database



                                Note
                                Ensure that you fix all other checks and issues that are listed in the screen.




Bug 35448216
                      compat-libcap1-1.10 package missing error during Oracle Database Client 64-bit installation
                      on Oracle Linux 9 and Red Hat Enterprise Linux 9.
                      Workaround:
                      In the Perform Prerequisite Checks screen, for the compat-libcap1-1.10 missing check,
                      select Ignore All, and click Install to continue with the installation.


                                Note
                                Ensure that you fix all other checks and issues that are listed in the screen.



Bug 35584316
                      On Oracle Linux 9 or Red Hat Enterprise Linux 9, C++ applications built with g++11 cannot be
                      used with Oracle C++ Call Interface (OCCI).
                      Workaround:
                      For building applications with g++11, use the following compilation options:

                      -D_GLIBCXX_USE_CXX11_ABI=0 -Wno-narrowing


Bug 35614058
                      Static Client linking demos fail during compilation on Oracle Database Client 19c on both 32-bit
                      and 64-bit versions on Oracle Linux 9 and Red Hat Enterprise Linux 9.
                      Workaround:
                      Oracle Database Client 19c supports only Dynamic Client linking demos on both 32-bit and 64-
                      bit versions on Oracle Linux 9 and Red Hat Enterprise Linux 9.


Bug 36347606
                      During Oracle Database Client 64-bit installation on Oracle Linux 9 and Red Hat Enterprise
                      Linux 9, the silent installation fails.
                      Workaround:
                      Perform the following steps when installing Oracle Database Client 64-bit using the silent
                      installation method:
                      1.    Extract the p36347606_1922000_Linux-x86-64.zip and extract client.zip to a temporary
                            (or bootstrap) location.




Database Release Notes
E96072-37                                                                                                              March 26, 2026
Copyright © 2017, 2026, Oracle and/or its affiliates.                                                                   Page 14 of 18
                                                                                                                      Chapter 3
                                                                   Known Issues and Bugs for Standard Edition High Availability


                      2.    Run the command:

                            ./runInstaller -silent -ignorePrereq -showProgress -waitforcompletion -
                            responseFile <response file location>


Bug 36513962
                      During Oracle Database Client 32-bit installation on Oracle Linux 9 and Red Hat Enterprise
                      Linux 9, the silent installation method fails.
                      Workaround:
                      Perform the following steps when installing Oracle Database Client 32-bit using the silent
                      installation method:
                      1.    Extract the p36513962_1922000DBRU_LINUX.zip and extract client.zip to a temporary (or
                            bootstrap) location.
                      2.    Run the command:

                            ./runInstaller -silent -ignorePrereq -showProgress -waitforcompletion -
                            responseFile <response file location>


Known Issues and Bugs for Standard Edition High Availability
                      This section contains information about issues related to Standard Edition High Availability:
                      •     Bug 30821297
                      •     Bug 30979062
                      •     Bug 30992915
                      •     Bug 31114977
                      •     Bug 31128434
                      •     Bug 31128452
                      •     Bug 31146826
                      •     Bug 31156506
                      •     Bug 31188168
                      •     Bug 31264160


Bug 30821297
                      Oracle Database Standard Edition 2 allows you to create more than one pluggable database
                      (PDB) in a multitenant container database (CDB). However, when you use the Oracle
                      Database Configuration Assistant (Oracle DBCA) to create a second PDB, you receive the
                      following error:

                      [FATAL] [DBT-11506] Creation of more than one PDB requires Enterprise Edition
                      license.


                      Workaround:



Database Release Notes
E96072-37                                                                                                       March 26, 2026
Copyright © 2017, 2026, Oracle and/or its affiliates.                                                            Page 15 of 18
                                                                                                                          Chapter 3
                                                                       Known Issues and Bugs for Standard Edition High Availability


                      Create the additional PDB using the SQL statement CREATE PLUGGABLE DATABASE.

                      Related Topics
                      •     Oracle Multitenant Administrator’s Guide


Bug 30979062
                      When you use the srvctl relocate database command to initiate the relocation of a
                      database configured with Standard Edition High Availability, and if the destination-configured
                      node does not have an available Oracle Database home, then the relocation fails as expected
                      but with error messages that do not include the reason for the failure.
                      This issue will be fixed in a future Oracle Database 19c release update.
                      Workaround:
                      None.


Bug 30992915
                      When you use Oracle Database Configuration Assistant (Oracle DBCA) to create a single-
                      instance database on an Oracle Clusterware node, the database is registered with Oracle
                      Clusterware. However, the command output incorrectly says the following:

                      Registering database with Oracle Restart


                      Workaround:
                      None.


Bug 31114977
                      When you relocate Oracle Database configured with Standard Edition High Availability that has
                      active database services, the srvctl status service command on that database displays a
                      blank list of instance that has the services running. However, the services are running on the
                      database instance.
                      Workaround:
                      None.


Bug 31128434
                      When you use the srvctl relocate database command to initiate the relocation of a
                      database configured with Standard Edition High Availability, and if Oracle Database has a
                      service registered, then the shutdown of the database instance is suspended for a period of
                      time due to the mount lock being held.
                      The registered database services are not accessible when the database instance is
                      suspended and the Oracle Database instance stops eventually on the current node and starts
                      on the destination node.
                      Workaround:
                       Use a sequence of srvctl stop database commands followed by the srvctl start
                      database -node destination node commands to avoid shutdown suspension.


Database Release Notes
E96072-37                                                                                                           March 26, 2026
Copyright © 2017, 2026, Oracle and/or its affiliates.                                                                Page 16 of 18
                                                                                                                        Chapter 3
                                                                     Known Issues and Bugs for Standard Edition High Availability



Bug 31128452
                      When you run the srvctl config service command for an Oracle Database with Standard
                      Edition High Availability configured and its services registered, a Java NULL pointer
                      exception occurs at the end of the output for the first service.

                      This issue will be fixed in a future Oracle Database 19c release update.
                      Workaround:
                      None.


Bug 31146826
                      When you configure Standard Edition High Availability for a single-instance Oracle Database
                      19c Release Update (RU) 19.7 that does not have any database services registered, you will
                      observe a local restart when the instance is abnormally terminated. However, after a service is
                      added to the database, you do not observe the local restart. Instead, the database fails over
                      immediately when it is abnormally terminated.
                      This issue will be fixed in a future Oracle Database 19c release update.
                      Workaround:
                      None.


Bug 31156506
                      If Oracle base of the Oracle Database home is the same as Oracle base of the Oracle Grid
                      Infrastructure home, then if the user adds a new node to the cluster, the Oracle Database
                      home user loses access permissions to some of the subdirectories under Oraclebase of the
                      Oracle Database home.
                      Workaround:
                      Use distinct directories as Oracle base for the Oracle Grid Infrastructure and Oracle Database
                      installations.


Bug 31188168
                      When you use the srvctl relocate database -help command from a Standard Edition
                      single-instance Oracle Database 19c home, the prompt incorrectly displays usage and help
                      messages with the mention of Oracle Real Application Clusters One Node (Oracle RAC One
                      Node). Starting with Oracle Database 19c Release Update (RU) 19.7, this command applies to
                      Standard Edition High Availability and must contain the corresponding usage and help
                      messages.
                      This issue will be fixed in a future Oracle Databse 19c release update.
                      Workaround:
                      Related Topics
                      •     Oracle Database Admninistrator's Guide
                      •     Oracle Clusterware Administration and Deployment Guide




Database Release Notes
E96072-37                                                                                                         March 26, 2026
Copyright © 2017, 2026, Oracle and/or its affiliates.                                                              Page 17 of 18
                                                                                                                        Chapter 3
                                                                     Known Issues and Bugs for Standard Edition High Availability



Bug 31264160
                      Starting with Oracle Database 19c Release Update (RU) 19.7, you use the srvctl add or
                      modify database commands to configure Standard Edition High Availability by specifying the -
                      node option with a node list of more than one node. However, the usage messages from these
                      commands, such as when running from an Oracle Database Standard Edition 2 database
                      home with the -help option, do not show this usage.

                      This issue will be fixed in a future Oracle Database 19c release update.
                      Workaround:
                      Related Topics
                      •     Oracle Database Admninistrator's Guide
                      •     Oracle Clusterware Administration and Deployment Guide




Database Release Notes
E96072-37                                                                                                         March 26, 2026
Copyright © 2017, 2026, Oracle and/or its affiliates.                                                              Page 18 of 18
4
Issues Affecting Oracle on Linux for Arm
(aarch64) for Oracle Database 19c
                      This topic contains last-minute features and changes for Oracle Database on Linux for Arm
                      (aarch64) for Oracle Database 19c.
                      •     Unsupported Products for Linux for Arm (aarch64) for Oracle Database 19c
                            This topic describes products or features that are unavailable for Oracle Database 19c.
                      •     Open Bugs for Linux for Arm (aarch64) for Oracle Database 19c
                            This section contains information about issues related to Linux for Arm (aarch64) for
                            Oracle Database 19c:
                      •     Limitation on Data Migration Using Transportable Tablespaces
                            Data Migration using Transportable Tablespaces (TTS) from Oracle Database 19c (release
                            19.19 or higher), Linux x86-64 and Microsoft Windows x64 to Oracle Database 19c
                            (release 19.19 or higher) Linux for Arm (aarch64) is only supported for simple schema.
                      •     Prerequisite for Cross-Platform PDB Move
                            Perform these steps to move a PDB cross-platform from source release 19.19 RU (Linux
                            x86-64 and Microsoft Windows x64) to target release 19.19 Linux for Arm (aarch64).


Unsupported Products for Linux for Arm (aarch64) for Oracle
Database 19c
                      This topic describes products or features that are unavailable for Oracle Database 19c.
                      The following products are not supported for Linux for Arm (aarch64) for Oracle Database 19c:
                      •     PLSQL Just-in-Time Compiler (JIT)
                      •     JAVAVM JIT
                      •     Oracle Cluster File System (OCFS2)
                      •     Oracle ASM Filter Driver (Oracle ASMFD)
                      •     Oracle Database Gateways (PG4APPC and PG4MQ)
                      •     Oracle Machine Learning for Python (OML4PY)
                      •     Oracle Database backups to Zero Data Loss Recovery Appliance (ZDLRA)
                      •     Pro*COBOL
                      •     Pro*FORTRAN
                      •     Oracle Messaging Gateway (MGW)
                      •     Oracle ASM library (Oracle ASMLIB)
                      •     DBnest
                      •     Oracle Big Data SQL
                      •     Oracle R



Database Release Notes
E96072-37                                                                                                  March 26, 2026
Copyright © 2017, 2026, Oracle and/or its affiliates.                                                         Page 1 of 4
                                                                                                                     Chapter 4
                                                                 Open Bugs for Linux for Arm (aarch64) for Oracle Database 19c


                      •     Oracle Machine Learning for R (OML4R)
                      The following scenarios were not tested on Linux for Arm (aarch64) for Oracle Database 19c
                      and may not work as expected:
                      •     Oracle Grid Infrastructure and Oracle RAC via standard IPv6 address notations.
                      •     The use of Dynamic Host Configuration Protocol (DHCP) for the VIP addresses and the
                            Single Client Access Name (SCAN) address for Oracle Grid Infrastructure using Grid
                            Naming Service (GNS).
                      Related Topics
                      •     Limitation on Data Migration Using Transportable Tablespaces
                            Data Migration using Transportable Tablespaces (TTS) from Oracle Database 19c (release
                            19.19 or higher), Linux x86-64 and Microsoft Windows x64 to Oracle Database 19c
                            (release 19.19 or higher) Linux for Arm (aarch64) is only supported for simple schema.


Open Bugs for Linux for Arm (aarch64) for Oracle Database 19c
                      This section contains information about issues related to Linux for Arm (aarch64) for Oracle
                      Database 19c:
                      •     Bug 34398211
                      •     Bug 34501504
                      •     Bug 34485708
                      •     Bug 35386579


Bug 34398211
                      Adding a node from grid fails due to SSH configuration issue and returns the following error:

                      [INS-06003] Failed to setup passwordless SSH connectivity with the following
                      node(s): node1, node2


                      Workaround:
                      Passwordless SSH configuration is a mandatory installation requirement. SSH is used during
                      installation to configure cluster member nodes, and SSH is used after installation by
                      configuration assistants, Oracle Enterprise Manager, Opatch, and other features.
                      If the system has OpenSSH 7.8 or later configured, then the Automatic Passwordless SSH
                      configuration using OUI fails.
                      Manually setup SSH to the node that you want to add before performing the addnode
                      operation.
                      Related Topics
                      •     Configuring SSH Manually on All Cluster Nodes


Bug 34501504
                      If the shell TZ environment variable is not in sync with the clusterware timezone, then the data
                      might not be displayed as part of oclumon dumpnodeview.

                      Workaround:


Database Release Notes
E96072-37                                                                                                      March 26, 2026
Copyright © 2017, 2026, Oracle and/or its affiliates.                                                             Page 2 of 4
                                                                                                                     Chapter 4
                                                                 Open Bugs for Linux for Arm (aarch64) for Oracle Database 19c


                      Set the TZ environment variable based on the clusterware timezone.


Bug 34485708
                      Deleting a node from grid fails due to SSH configuration issue and returns the following error:

                      [PILOT-00452] Unable to establish SSH connection to node1 to execute command
                      "Grid_home/deinstall/deinstall"
                      CAUSE: An attempt to connect to specified node to execute specified command
                      using SSH failed.
                      ACTION: Make sure that the specified node is reachable and the SSH daemon on
                      the specified
                      node is alive.


                      Workaround:
                      Update OpenSSH format to RSA format by running the following command on all nodes:

                      ssh-keygen -p -f private_key_location -m pem
                      Example: ssh-keygen -p -f ~/.ssh/id_rsa -m pem


Bug 35386579
                      While you migrate a PDB from source release 19.19 RU (Linux x86-64 and Microsoft Windows
                      x64) to target release Linux for Arm (aarch64), you may encounter the following issue at
                      aarch64 while trying to restore the foreign PDB from the backup set:

                      - database (19.0.0.0.0 1.8) does not match that of the oracle executable
                      (19.0.0.0.230117 1.8)


                      Workaround:
                      Run the following SQLs to resolve the issue:

                      SQL> alter session set "_ORACLE_SCRIPT"=true;
                      Session altered.

                      SQL> DECLARE n varchar2(100);

                      BEGIN
                      n := dbms_java_test.funcall('-rujs', ' ');
                      initjvmaux.validate_javavm;




Database Release Notes
E96072-37                                                                                                      March 26, 2026
Copyright © 2017, 2026, Oracle and/or its affiliates.                                                             Page 3 of 4
                                                                                                                       Chapter 4
                                                                    Limitation on Data Migration Using Transportable Tablespaces


                      END;
                      /


                         2       3       4      5       6   7   8   9

                      PL/SQL procedure successfully completed.


                      SQL> select dbms_java.get_jdk_version from dual;


                      GET_JDK_VERSION

                      ------------
                      1.8.0_371



Limitation on Data Migration Using Transportable Tablespaces
                      Data Migration using Transportable Tablespaces (TTS) from Oracle Database 19c (release
                      19.19 or higher), Linux x86-64 and Microsoft Windows x64 to Oracle Database 19c (release
                      19.19 or higher) Linux for Arm (aarch64) is only supported for simple schema.
                      More complex schemas may encounter issues related to guard-column and other issues.
                      Cross platform transportable tablespace is only supported from source Linux x86-64 and
                      Microsoft Windows x64 to target Linux for Arm (aarch64), when both the source and
                      destination are at the same major version and the same RU level. For example, from source
                      release 19.19 RU (Linux x86-64 and Microsoft Windows x64) to target release 19.19 Linux for
                      Arm (aarch64).


Prerequisite for Cross-Platform PDB Move
                      Perform these steps to move a PDB cross-platform from source release 19.19 RU (Linux
                      x86-64 and Microsoft Windows x64) to target release 19.19 Linux for Arm (aarch64).
                      Before you unplug your PDB from the source container, run these queries to clear the
                      datapatch inventory:

                      /* Delete all rows from datapatch tables to clear the inventory */

                      alter session set container=pdb_name;

                      delete from dba_registry_sqlpatch;

                      delete from dba_registry_sqlpatch_ru_info;

                      commit;




Database Release Notes
E96072-37                                                                                                        March 26, 2026
Copyright © 2017, 2026, Oracle and/or its affiliates.                                                               Page 4 of 4
5
Issues Affecting Oracle Instant Client on Linux
for Arm (aarch64) for Oracle Database 19c
                      This topic contains last-minute features and changes for Oracle Instant Client on Linux for Arm
                      (aarch64) for Oracle Database 19c.
                      •     Unsupported Products for Linux for Arm (aarch64)
                            This topic describes products or features that are unavailable for Oracle Database 19c.


Unsupported Products for Linux for Arm (aarch64)
                      This topic describes products or features that are unavailable for Oracle Database 19c.
                      The following products are not supported for Linux for Arm (aarch64):
                      •     Pro*COBOL
                      •     Pro*FORTRAN




Database Release Notes
E96072-37                                                                                                 March 26, 2026
Copyright © 2017, 2026, Oracle and/or its affiliates.                                                        Page 1 of 1
6
Issues Affecting Oracle Solaris for Oracle
Database 19c
                      These topics contain last-minute features and changes for Oracle Solaris for Oracle Database
                      19c.
                      •     Unsupported Products for Oracle Solaris
                            In addition to the list of unavailable products or features in this release of Oracle Database
                            19c, the following product is not supported for Oracle Solaris:
                      •     Product Support
                            These are the supported products or features for Oracle Database 19c:
                      •     Linking Applications with Oracle Client Libraries for Oracle Solaris
                            You must use the dynamic Oracle client libraries to link the client code on Oracle Solaris.
                      •     Preinstallation Requirements for Oracle Solaris
                            Refer to the installation guides for the preinstallation requirements for Oracle Database
                            19c.
                      •     Installation, Configuration, and Upgrade Issues for Oracle Solaris
                            These topics describe information about issues that affect Oracle Database installation,
                            configuration, and upgrade.
                      •     Open Bugs Affecting Oracle Solaris
                            There are no open bugs affecting Oracle Solaris at the time of the release.


Unsupported Products for Oracle Solaris
                      In addition to the list of unavailable products or features in this release of Oracle Database 19c,
                      the following product is not supported for Oracle Solaris:
                      •     Net Configuration Assistant Support
                      •     Bug 21816875
                            Net Configuration Assistant (NETCA) is not supported on Oracle Solaris on SPARC (32-
                            Bit) and Oracle Solaris on x86 (32-Bit) client platforms.


Bug 21816875
                      Net Configuration Assistant (NETCA) is not supported on Oracle Solaris on SPARC (32-Bit)
                      and Oracle Solaris on x86 (32-Bit) client platforms.


Product Support
                      These are the supported products or features for Oracle Database 19c:
                      •     Oracle Solaris Support on SPARC
                            Oracle Database 19c is supported on Oracle Solaris on SPARC (64-bit).
                      •     Database Smart Flash Cache Support


Database Release Notes
E96072-37                                                                                                    March 26, 2026
Copyright © 2017, 2026, Oracle and/or its affiliates.                                                           Page 1 of 3
                                                                                                                             Chapter 6
                                                                   Linking Applications with Oracle Client Libraries for Oracle Solaris


                            Database Smart Flash Cache is supported on Oracle Solaris.
                      •     Oracle ACFS and Oracle ADVM Support
                            Although Oracle ADVM supports raw disks in Oracle Automatic Storage Management disk
                            groups, Oracle ADVM device special files created through raw are not supported; Oracle
                            ADVM only supports block device special files.
                            For the latest information about supported platforms and releases, see the Note 1369107.1
                            on My Oracle Support at https://support.oracle.com


Linking Applications with Oracle Client Libraries for Oracle
Solaris
                      You must use the dynamic Oracle client libraries to link the client code on Oracle Solaris.
                       Do not link the static Oracle client libraries.


Preinstallation Requirements for Oracle Solaris
                      Refer to the installation guides for the preinstallation requirements for Oracle Database 19c.


Installation, Configuration, and Upgrade Issues for Oracle Solaris
                      These topics describe information about issues that affect Oracle Database installation,
                      configuration, and upgrade.
                      •     Bug 21800407
                      •     Bug 28650933
                      •     Bug 24355490


Bug 21800407
                      When installing Oracle Database for English and Japanese environments, the background font
                      incorrectly displays yellow color for the Oracle Universal Installer (OUI), Database
                      Configuration Assistant (DBCA), and Database Upgrade Assistant (DBUA) pages.
                      Workaround:
                      Prior to installing Oracle Database, run the following command:
                      export _JAVA_OPTIONS='-Dsun.java2d.xrender=false'


Bug 28650933
                      Installing and using Oracle Secure Backup 12.2 on Oracle Solaris 11.4 may fail if the library
                      libnls.so is not available in standard system library paths, since the Oracle Secure Backup
                      libraries depend on libnls.so.

                      Workaround:
                      Upgrade the Oracle Solaris OS version to Oracle Solaris 11.4.6.4.0. and then install Oracle
                      Secure Backup 12.2. Alternate workaround is to copy the file /usr/ib/64/libnls.so.1 from
                      an Oracle Solaris 11.3 machine to the /usr/lib/64 path in the Oracle Solaris 11.4 machine
                      where Oracle Secure Backup 12.2 needs to be installed.

Database Release Notes
E96072-37                                                                                                              March 26, 2026
Copyright © 2017, 2026, Oracle and/or its affiliates.                                                                     Page 2 of 3
                                                                                                                    Chapter 6
                                                                                           Open Bugs Affecting Oracle Solaris



Bug 24355490
                      When installing or upgrading an Oracle Grid Infrastructure home on Oracle Solaris 10, if the
                      desired software location resides under a soft link, then the Oracle Grid Infrastructure installer
                      incorrectly sets the physical path as the software location.
                      Workaround:
                      Perform the following steps:
                      1.    Set the Oracle Grid Infrastructure installer specifying the complete path to the desired
                            Oracle home path:
                            Complete Oracle home path/gridSetup.sh
                      2.    Proceed with the Oracle Grid Infrastructure installation.


Open Bugs Affecting Oracle Solaris
                      There are no open bugs affecting Oracle Solaris at the time of the release.




Database Release Notes
E96072-37                                                                                                     March 26, 2026
Copyright © 2017, 2026, Oracle and/or its affiliates.                                                            Page 3 of 3
7
Issues Affecting HP-UX Itanium for Oracle
Database 19c
                      These topics contain last-minute features and changes for HP-UX Itanium for Oracle Database
                      19c.

                      •     Unsupported Products for HP-UX Itanium
                            In addition to the list of unavailable products or features in this release of Oracle Database
                            19c, the following products and features are not supported:
                      •     Product Support
                            There are no supported products or features for Oracle Database 19c on HP-UX Itanium at
                            this time.
                      •     Linking Applications with Oracle Client Libraries for HP-UX Itanium
                            You must use the dynamic Oracle client libraries to link the client code on HP-UX Itanium.
                      •     Preinstallation Requirements for HP-UX Itanium
                            Refer to the installation guides for the preinstallation requirements for Oracle Database
                            19c.
                      •     Installation, Configuration, and Upgrade Issues for HP-UX Itanium
                            This topic describes information about issues that affect Oracle Database installation,
                            configuration, and upgrade.


Unsupported Products for HP-UX Itanium
                      In addition to the list of unavailable products or features in this release of Oracle Database 19c,
                      the following products and features are not supported:
                      •     Database Smart Flash Cache Support
                      •     Oracle ASM Filter Driver Support


Product Support
                      There are no supported products or features for Oracle Database 19c on HP-UX Itanium at this
                      time.


Linking Applications with Oracle Client Libraries for HP-UX
Itanium
                      You must use the dynamic Oracle client libraries to link the client code on HP-UX Itanium.
                      Do not link the static Oracle client libraries.




Database Release Notes
E96072-37                                                                                                    March 26, 2026
Copyright © 2017, 2026, Oracle and/or its affiliates.                                                           Page 1 of 3
                                                                                                                    Chapter 7
                                                                               Preinstallation Requirements for HP-UX Itanium




Preinstallation Requirements for HP-UX Itanium
                      Refer to the installation guides for the preinstallation requirements for Oracle Database 19c.


Installation, Configuration, and Upgrade Issues for HP-UX
Itanium
                      This topic describes information about issues that affect Oracle Database installation,
                      configuration, and upgrade.
                      •     Bug 27367949
                      •     Bug 28340043
                      •     Bug 29198896


Bug 27367949
                      In some Oracle Database installation scenarios, Database Upgrade Assistant (DBUA) reports
                      a prerequirement checks failure, and returns the following error:

                      Oracle OLAP API UPGRADED 18.1.0.0.0 00:00:18
                      Upgrade Datapatch Error: prereq checks failed!
                      Upgrade Datapatch 00:00:37


                      Further catupgrd_datapatch_normal.log returns the following error:

                      Connecting to database...OK
                      Gathering database info...done
                      Bootstrapping registry and package to current versions...done
                      Error: prereq checks failed!
                      verify_queryable_inventory returned ORA-20001: Latest xml inventory is not
                      loaded into table
                      Prereq check failed, exiting without installing any patches.


                      Workaround:
                      Start DBUA as a user with the same group ID as that of the Oracle user that owns the Oracle
                      Database 18c Oracle home.
                      For example, if the user asmadmin is the group owner of the Oracle home on your system,
                      change the user primary group to the asmadmin group using newgrp:

                      bash-4.3$ ls -l $ORACLE_HOME/bin/oracle
                      -rwsr-s--x 1 oracle asmadmin 1133380232 Feb 14 00:36 bin/oracle
                      bash-4.3$ newgrp asmadmin
                      bash-4.3$ $ORACLE_HOME/bin/dbua




Database Release Notes
E96072-37                                                                                                     March 26, 2026
Copyright © 2017, 2026, Oracle and/or its affiliates.                                                            Page 2 of 3
                                                                                                                      Chapter 7
                                                              Installation, Configuration, and Upgrade Issues for HP-UX Itanium



Bug 28340043
                      In some Oracle Database installation scenarios, creating database using Database
                      Configuration Assistant (DBCA) results in INVALID JAVAVM component or database upgrade
                      using Database Upgrade Assistant (DBUA) reports a prerequirement checks failure and
                      returns the following error:

                      Oracle OLAP API UPGRADED 18.1.0.0.0 00:00:18
                      Upgrade Datapatch Error: prereq checks failed!
                      Upgrade Datapatch 00:00:37


                      Further catupgrd_datapatch_normal.log returns the following error:

                      Connecting to database...OK
                      Gathering database info...done
                      Bootstrapping registry and package to current versions...done
                      Error: prereq checks failed!
                      verify_queryable_inventory returned ORA-20001: Latest xml inventory is not
                      loaded into table
                      Prereq check failed, exiting without installing any patches.


                      Workaround:
                      Start DBCA or DBUA as a user with the same group ID as that of the Oracle user that owns
                      the Oracle Database 18c Oracle home.
                      For example, if the user asmadmin is the group owner of the Oracle home on your system,
                      change the user primary group to the asmadmin group using newgrp:

                      bash-4.3$ ls -l $ORACLE_HOME/bin/oracle
                      -rwsr-s--x 1 oracle asmadmin 1133380232 Feb 14 00:36 bin/oracle
                      bash-4.3$ newgrp asmadmin
                      bash-4.3$ $ORACLE_HOME/bin/dbua


Bug 29198896
                      While duplicating Oracle Database as standby using Database Configuration Assistant
                      (DBCA), internally, RMAN DUPLICATE tries to copy the password file from Oracle Automatic
                      Storage Management (Oracle ASM) to Non-ASM or vice-versa. The password file is copied,
                      but the clone password file is not readable and returns the following error:

                        “ORA-01017: invalid username/password; logon denied” on clone instance
                      reconnection"


                      Workaround:
                      If the source instance password file is on Oracle ASM, then define the clone instance
                      password on Oracle ASM only, and when the source password file is on Non-ASM files
                      system, then keep the clone instance password file on Non-ASM file system.




Database Release Notes
E96072-37                                                                                                      March 26, 2026
Copyright © 2017, 2026, Oracle and/or its affiliates.                                                             Page 3 of 3
8
Issues Affecting the IBM AIX on POWER
Systems Platform for Oracle Database 19c
                      These topics contain last-minute features and changes for Oracle Database 19c.
                      •     Unsupported Products for the IBM AIX on POWER Systems Platform
                      •     Linking Applications with Oracle Client Libraries for the IBM AIX on POWER Systems
                            Platform
                      •     Preinstallation Requirements for the IBM AIX on POWER Systems Platform
                      •     Installation, Configuration, and Upgrade Issues for the IBM AIX on POWER Systems
                            Platform
                      •     Open Bugs Affecting the IBM AIX on POWER Systems Platform


Unsupported Products for the IBM AIX on POWER Systems
Platform
                      There are no unsupported products for the IBM AIX on POWER Systems Platform at this time.
                      Refer to the list of unavailable products or features for all platforms in Oracle Database 19c.


Linking Applications with Oracle Client Libraries for the IBM AIX
on POWER Systems Platform
                      You must use the dynamic Oracle client libraries to link the client code on Linux. Do not link the
                      static Oracle client libraries.


Preinstallation Requirements for the IBM AIX on POWER
Systems Platform
                      Refer to the installation guides for the preinstallation requirements for Oracle Database 19c.


Installation, Configuration, and Upgrade Issues for the IBM AIX
on POWER Systems Platform
                      These topics describe information about issues that affect Oracle Database installation,
                      configuration, and upgrade.
                      •     Bug 29053538
                      •     Bug 29434250
                      •     Bug 29052788



Database Release Notes
E96072-37                                                                                                  March 26, 2026
Copyright © 2017, 2026, Oracle and/or its affiliates.                                                         Page 1 of 3
                                                                                                                              Chapter 8
                                              Installation, Configuration, and Upgrade Issues for the IBM AIX on POWER Systems Platform


                      •     Bug 29178036


Bug 29053538
                      Oracle database instance at startup loads libora_netlib.so. This library has dependencies
                      on IBM XL Fortran runtime libraries. If they are not installed on the system, startup fails with
                      the following error:

                      ORA-40238: invalid linear algebra shared library


                      Workaround:
                      Install XL Fortran Runtime for AIX Fix Pack 10 (February 2018 PTF) for 15.1.
                      Download and install XL Fortran Runtime for AIX Fix Pack 10 (February 2018 PTF) for 15.1
                      from:
                      https://www-01.ibm.com/support/docview.wss?uid=swg24044611


Bug 29434250
                      If you install Oracle Database 19c or Oracle Grid Infrastructure 19c or upgrade Oracle
                      Database 19c or Oracle Grid Infrastructure 19c from previous versions to 19c by registering
                      with Enterprise Manager Cloud Control (EMCC), installer may crash.
                      Workaround:
                      Do not register with EMCC during install or upgrade. Instead, discover the host and add targets
                      either using EMCC web console or Enterprise Manager Command Line Interface (EMCLI)
                      commands after the install and upgrade is complete.


Bug 29052788
                      In some environments, every time the Dynamic Host Configuration Protocol (DHCP) lease is
                      renewed, a different IP address is assigned. The Cross-Doman Protocol (CDP) daemon does
                      not see these changes, and assumes the IP address has not changed unless the CDP
                      resource is restarted. Example, when the SCAN is stopped. When the IP address changes,
                      there is a window when CDP is unreachable by that IP, and the agent eventually executes a
                      clean action and restarts.
                      Workaround:
                      If CDP is found to be offline when the SCAN VIP's IP changes, then use srvctl start cdp
                      to restart it.


Bug 29178036
                      The shutdown abort of Oracle RAC One Node Database software on IBM AIX on Power
                      Systems 7.1 does not finish quickly and results in failing to failover.
                      Workaround:
                      IBM AIX on Power Systems 8 or later, and AIX 7.2 use hardware compression for Active
                      Memory Expansion (AME) and therefore can support the use of 64k pages with AME. On AIX
                      7.1 or earlier, 64k pages are not supported when AME is enabled, and 4k pages are used
                      instead. In certain scenarios when using 4k pages with the Oracle Database, certain
                      operations may be slower, including startup and shutdown of the database. Use of AME with

Database Release Notes
E96072-37                                                                                                               March 26, 2026
Copyright © 2017, 2026, Oracle and/or its affiliates.                                                                      Page 2 of 3
                                                                                                                Chapter 8
                                                               Open Bugs Affecting the IBM AIX on POWER Systems Platform


                      the Oracle RAC One Node Database software is not recommended unless using AIX 8 or later
                      and AIX 7.2 or later with 64k pages enabled.


Open Bugs Affecting the IBM AIX on POWER Systems Platform
                      These topics contain last-minute features and changes for Oracle Database 19c.




Database Release Notes
E96072-37                                                                                                 March 26, 2026
Copyright © 2017, 2026, Oracle and/or its affiliates.                                                        Page 3 of 3
9
Issues Affecting Microsoft Windows for Oracle
Database 19c
                      These topics contain last-minute features and changes for Microsoft Windows for Oracle
                      Database 19c.

                      •     Unsupported Products for Microsoft Windows
                            There are no unsupported Microsoft Windows-specific products at this time.
                      •     Product Support
                            These are the supported products or features for Oracle Database 19c.
                      •     Linking Applications with Oracle Client Libraries for Microsoft Windows
                            You must use the dynamic Oracle client libraries to link the client code on Microsoft
                            Windows.
                      •     Preinstallation Requirements for Microsoft Windows
                            Refer to the installation guides for the preinstallation requirements for Oracle Database
                            19c.
                      •     Installation, Configuration, and Upgrade Issues for Microsoft Windows
                            These topics describe information about issues that affect Oracle Database installation,
                            configuration, and upgrade.


Unsupported Products for Microsoft Windows
                      There are no unsupported Microsoft Windows-specific products at this time.


Product Support
                      These are the supported products or features for Oracle Database 19c.
                      Oracle ACFS and Oracle ADVM Support
                      Although Oracle ADVM supports raw disks in Oracle Automatic Storage Management disk
                      groups, Oracle ADVM device special files created through raw are not supported; Oracle
                      ADVM only supports block device special files.
                      For the latest information about supported platforms and releases, see the Note 1369107.1 on
                      My Oracle Support at https://support.oracle.com
                      Oracle Fail Safe Server Release 4.2.1 Support
                      Oracle Fail Safe Server, Release 4.2.1 is supported on the software listed in the following
                      table:




Database Release Notes
E96072-37                                                                                                   March 26, 2026
Copyright © 2017, 2026, Oracle and/or its affiliates.                                                          Page 1 of 4
                                                                                                                             Chapter 9
                                                               Linking Applications with Oracle Client Libraries for Microsoft Windows




                       Software                                             Release or Version
                       Oracle Database (Standard and Enterprise             Oracle Database 11g Release 2 (11.2)
                       editions)                                            Oracle Database 12c Release 1 (12.1)
                                                                            Oracle Database 12c Release 2 (12.2)
                                                                            Oracle Database 18c
                                                                            Oracle Database 19c
                       Microsoft Windows Platforms                          Microsoft Windows Server 2012
                                                                            Microsoft Windows Server 2012 R2
                                                                            Microsoft Windows Server 2016
                                                                            Microsoft Windows Server 2019

                      Oracle Fail Safe Client Release 4.2.1 Support
                      Oracle Fail Safe Manager, the client, works with Oracle Fail Safe Server version 3.4.2.4 and
                      later patch sets. Oracle Fail Safe Manager is supported on the following operating systems:
                      •     Microsoft Windows Server 2012
                      •     Microsoft Windows Server 2012 R2
                      •     Microsoft Windows Server 2016
                      •     Microsoft Windows Server 2019
                      •     Windows 7
                      •     Windows 8
                      •     Windows 8.1
                      •     Windows 10
                      For the latest certification information for Oracle Fail Safe, see the Certifications tab in My
                      Oracle Support at https://support.oracle.com


Linking Applications with Oracle Client Libraries for Microsoft
Windows
                      You must use the dynamic Oracle client libraries to link the client code on Microsoft Windows.
                      Do not link the static Oracle client libraries.


Preinstallation Requirements for Microsoft Windows
                      Refer to the installation guides for the preinstallation requirements for Oracle Database 19c.


Installation, Configuration, and Upgrade Issues for Microsoft
Windows
                      These topics describe information about issues that affect Oracle Database installation,
                      configuration, and upgrade.
                      •     Bug 20918120



Database Release Notes
E96072-37                                                                                                             March 26, 2026
Copyright © 2017, 2026, Oracle and/or its affiliates.                                                                    Page 2 of 4
                                                                                                                        Chapter 9
                                                            Installation, Configuration, and Upgrade Issues for Microsoft Windows


                      •     Bug 21325903
                      •     Bug 29426320
                      •     Bug 38057837


Bug 20918120
                      Installing Oracle Real Application Clusters Database home with a Group Managed Services
                      Account (gMSA) as the Oracle home user, fails with the following error if the gMSA name
                      consists of more than 15 characters (including the domain name):
                      [INS-32101] Specified Oracle Home user does not exist

                      Workaround:
                      Use a gMSA name (including the domain name) that consists of less than 15 characters.


Bug 21325903
                      The deinstallation operation fails to remove Oracle home and displays file in use
                      errors because the services and processes running from Oracle home are not removed
                      completely before Oracle home removal.
                      Workaround:
                      Manually remove the Oracle home.


Bug 29426320
                      The following error occurs when running external procedures or Oracle Database Extensions
                      for .NET procedures with a virtual user account:

                      ORA-28575 Unable to open RPC connection to external procedure agent


                      Workaround#1
                      Restart the Oracle listener service and the OracleClrAgent service using a non-virtual user
                      account.
                      Workaround#2
                      Reinstall Oracle Database 19c and select a non-virtual user account.
                      Workaround#3
                      If you require a virtual user account, then set sqlnet.authentication_services to NONE in
                      SQLNET.ORA.


Bug 38057837
                      When installing a 32-bit Oracle Database Client in the same Oracle base directory as an
                      existing 64-bit Oracle Database Client, the installer revokes permissions for non-Administrator
                      users on the 64-bit client home. Consequently, non-Administrator users may receive Access is
                      denied errors when attempting to run executables, applications, or graphical user interface
                      (GUI) tools associated with the 64-bit client installation.
                      Workaround:


Database Release Notes
E96072-37                                                                                                        March 26, 2026
Copyright © 2017, 2026, Oracle and/or its affiliates.                                                               Page 3 of 4
                                                                                                                        Chapter 9
                                                            Installation, Configuration, and Upgrade Issues for Microsoft Windows


                      To avoid permission conflicts, install 32-bit and 64-bit Oracle Database Clients in separate
                      Oracle base directories.




Database Release Notes
E96072-37                                                                                                        March 26, 2026
Copyright © 2017, 2026, Oracle and/or its affiliates.                                                               Page 4 of 4

