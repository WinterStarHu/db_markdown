# 97. Oracle Database Release Notes for Fujitsu BS2000

> 源文件: `en/dfsrn/oracle-database-release-notes-fujitsu-bs2000.pdf`

Oracle® Database
Database Release Notes
19c for Fujitsu BS2000
F28349-01
July 2020




                         This document describes the features of Oracle Database on Fujitsu BS2000.
                         This release implements the features of Oracle Database 19c Enterprise Edition.
                         These features are listed and described in the generic Oracle Documentation and
                         in Oracle Database Licensing Information User Manual and Oracle Database New
                         Features Guide.
                         The following topics are included:
                         •   Supported Fujitsu BS2000 Servers
                         •   Unsupported Options
                         •   Unsupported Features
                         •   Known Restrictions, Issues, and Workarounds
                         •   Documentation Accessibility


                         Supported Fujitsu BS2000 Servers
                         Oracle Database 19c for Fujitsu BS2000 supports the Fujitsu BS2000 SE servers.
                         On Intel x86–based servers (SU x86 of SE servers), Oracle Database 19c for Fujitsu
                         BS2000 runs in the /390 compatibility mode.


                         Unsupported Options
                         The following options are not supported on Oracle Database 19c for Fujitsu BS2000:
                         •   Oracle Machine Learning
                         •   Oracle Database In-Memory
                         •   Oracle Database Vault
                         •   Oracle Label Security
                         •   Oracle On-Line Analytical Processing (OLAP)
                         •   Oracle RAC One Node



                                                                                                              1
•   Oracle Real Application Clusters (Oracle RAC)
•   Oracle Spatial and Graph
•   Oracle TimesTen Application-Tier Database Cache (formerly known as Oracle
    In-Memory Database Cache)


Unsupported Features
The following features are not supported on Oracle Database 19c for Fujitsu BS2000:
•   Cross Platform Transportable Tablespace
•   Database Configuration Assistant
•   Database Migration Assistant for Unicode
•   Database Upgrade Assistant
•   Database AutoUpgrade Utility
•   JIT in Oracle JavaVM
•   JavaScript Object Notification (JSON)
•   Native Compilation of Java and PL/SQL
•   OCCI
•   OPatch
•   Oracle Application Express
•   Oracle Automatic Storage Management
•   Oracle Configuration Manager
•   Oracle Direct NFS
•   Oracle Enterprise Manager Database Express
•   Oracle Globalization Development Kit
•   Oracle Heterogeneous Services
•   Oracle Instant Client
•   Oracle Java Server Pages
•   Oracle JDBC OCI drivers
•   Oracle Messaging Gateway
•   Oracle Secure Backup
•   Oracle Universal Installer
•   Oracle XML DB
•   Threaded Execution Mode
•   Oracle Sharding
•   Oracle Database File System (DBFS)
•   Oracle File System (OFS) Server



                                                                                      2
Known Restrictions, Issues, and Workarounds
This section provides information about known restrictions and issues. It contains
workarounds where possible, and suggestions for certain common issues. If you
encounter an issue that is not reported here, then contact Oracle Support for further
assistance.
•   General Notes
•   ALTER DATABASE … RESIZE
•   IEEE Standard Floating Point Number Restrictions
•   SQL*Loader
•   Oracle Scheduler
•   INIT.ORA Parameters
•   SQL Tuning
•   Oracle JVM
•   Archiving to Tape
•   Import and Export
•   Oracle Data Pump Import and Oracle Data Pump Export
•   Globalization Support
•   Unsupported Oracle Call Interface Features
•   PL/SQL
•   SQL*Plus
•   Global Data Service
•   LogMiner
•   Oracle Net Services
•   Oracle Protocol Support for TCP/IP
•   POSIX Subsystem

General Notes
The German characters ä, ö, ü and ß, cannot be used in the names of tables,
columns, fields, synonyms, and so on. This is because these characters are converted
into braces (for example, {). However, these characters can be stored as data.

ALTER DATABASE … RESIZE
The operation ALTER DATABASE ... RESIZE, to make a database file smaller, is not
supported on BS2000. This operation has no effect on the corresponding BS2000 files.
However, database files can be altered to larger sizes either manually by using ALTER
or automatically, when a tablespace is defined with AUTOEXTEND.



                                                                                        3
IEEE Standard Floating Point Number Restrictions
The BINARY FLOAT and BINARY DOUBLE data types are not supported for customer-
written database applications running on BS2000.
Attempts to store or fetch these types from an application program running on BS2000
produces unpredictable results with both local and remote Oracle databases.

SQL*Loader
The binary data types FLOAT and DOUBLE of SQL*Loader are not supported on BS2000.

Using these data types with SQL*Loader and External Tables produces unpredictable
results.
Use the external, non-binary data type FLOAT EXTERNAL instead.

Multithreading functionality of direct path loads is not supported on BS2000.

Oracle Scheduler
External Jobs are not supported.

INIT.ORA Parameters
A few initialization parameters in the INIT.ORA file, described in the generic
documentation are not supported by Oracle Database 19c for BS2000. Refer to
Oracle Database Installation and Administration Guide for Fujitsu BS2000 for more
information.

SQL Tuning
Cursor-Duration Temporary Tables are not supported.

Oracle JVM
Oracle JVM, the Java Virtual Machine in Oracle Database, supports only JDK 8.

Archiving to Tape
Archiving to tape is not supported. The archive log files must always be created as
disk files. However, you may use normal BS2000 backup procedures to back up the
archive log files created by the archive process.

Import and Export
Consider the following information about Import and Export:




                                                                                      4
•   Avoid ASCII/EBCDIC conversions by the operating system, FTP, or PERCON.
    Import and Export utilities perform their own conversions. Additional conversions
    render the files unusable.
•   Import and export on tapes are not possible to or from more than one tape.

Oracle Data Pump Import and Oracle Data Pump Export
Consider the following information about Oracle Data Pump Import and Oracle Data
Pump Export:
•   Avoid ASCII/EBCDIC conversions by the operating system, FTP, or PERCON.
    Oracle Data Pump Import and Oracle Data Pump Export utilities perform their own
    conversions. Additional conversions render the files unusable.
•   Tapes are not supported with Data Pump Export and Data Pump Import.

Globalization Support
User-defined character sets implemented by Customizing Locale Data as described in
Oracle Database Globalization Support Guide are not supported in this release.

Unsupported Oracle Call Interface Features
The following features are currently not supported:
•   OCI shared mode functionality
•   OCI publish-subscribe functions
•   OCI Thread package

PL/SQL
Starting with Oracle Database 12c Release 2, a new feature was introduced that
allows the use of static PL/SQL expressions where previously literals were required.
This new feature is not supported on BS2000.

SQL*Plus
The following remarks relate to SQL*Plus:
•   SQL*Plus truncates and displays a warning message if the input lines exceed 511
    characters.
•   The internal message buffer is limited to 76 characters, therefore, certain
    messages are truncated. This typically occurs if a message includes a second
    message. In such cases, you must refer to the message number part of the
    second message.




                                                                                        5
           See Also:
           Oracle Database Error Messages Reference or Oracle Database
           Installation and Administration Guide for Fujitsu BS2000 for more
           information about the error message

•   If ECHO is set to ON, TAB is set to ON, and you specify a spool file, then the listing of
    commands may be misaligned.
•   On BS2000, you cannot use the SET LINESIZE WINDOW command to adjust the
    linesize and pagesize for the formatted output, according to the width and height of
    the screen.

Global Data Service
Only Global Data Service (GDS) clients are supported on BS2000.

LogMiner
The following data types are not supported:
•   Objects stored as VARRAYs
•   Objects (Simple and Nested ADTs without Collections)
•   XMLType data

Oracle Net Services
The following remarks relate to Oracle Net Services:
•   When you specify a name for the listener in the LISTENER.ORA file,
    Oracle recommends that the name is less than 20 characters long. If you
    use a listener name with more than 20 characters, and the parameter
    DIAG_ADR_ENABLED_listener_name is set to off, then you must specify a log
    directory (trace directory) and a log file (trace file).
•   The listener can be started only if the POSIX subsystem is running.

Oracle Protocol Support for TCP/IP
The Internet Assigned Numbers Authority (IANA) divided port numbers into three
ranges:
•   Well Known Ports from 0 through 1023
•   Registered Ports from 1024 through 49151
•   Dynamic, or Private Ports, or both, from 49152 through 65535
Fujitsu documentation for TCP/IP on BS2000 recommends to set the privileged port
to 2050. However, using a registered Oracle port number may cause conflicts. For
example, if you set the port number for the listener process to 1521, then any Oracle



                                                                                                6
process that tries to listen on such a registered port number may fail with the following
error:
TNS-12545: Connect failed because target host or object does not exist
TNS-12560: TNS:protocol adapter error
TNS-00515: Connect failed because target host or object does not exist
BS2000 Error: 126: Can't assign requested address
BS2000 BCAM-RC: 40010020

The workaround is to use a non-privileged port, or to set the privileged port number to
a value less than 1521. For example, 1520.
You can find more details about service names and port numbers at
http://www.iana.org/assignments/service-names-port-numbers/service-names-
port-numbers.xhtml

POSIX Subsystem
Oracle Database 19c requires the POSIX subsystem and access to the POSIX file
system. The following exception may occur:
The termination of the POSIX subsystem also terminates the Oracle Database
instance.


Documentation Accessibility
For information about Oracle's commitment to accessibility, visit the
Oracle Accessibility Program website at http://www.oracle.com/pls/topic/lookup?
ctx=acc&id=docacc.


Access to Oracle Support
Oracle customers that have purchased support have access to electronic support
through My Oracle Support. For information, visit http://www.oracle.com/pls/topic/
lookup?ctx=acc&id=info or visit http://www.oracle.com/pls/topic/lookup?ctx=acc&id=trs
if you are hearing impaired.




Oracle® Database Database Release Notes, 19c for Fujitsu BS2000
F28349-01

Copyright © 2016, 2020, Oracle and/or its affiliates

This software and related documentation are provided under a license agreement containing restrictions on use and disclosure and are protected by intellectual property
laws. Except as expressly permitted in your license agreement or allowed by law, you may not use, copy, reproduce, translate, broadcast, modify, license, transmit, distribute,
exhibit, perform, publish, or display any part, in any form, or by any means. Reverse engineering, disassembly, or decompilation of this software, unless required by law for
interoperability, is prohibited.

The information contained herein is subject to change without notice and is not warranted to be error-free. If you find any errors, please report them to us in writing.

If this is software or related documentation that is delivered to the U.S. Government or anyone licensing it on behalf of the U.S. Government, then the following notice is
applicable:

U.S. GOVERNMENT END USERS: Oracle programs (including any operating system, integrated software, any programs embedded, installed or activated on delivered
hardware, and modifications of such programs) and Oracle computer documentation or other Oracle data delivered to or accessed by U.S. Government end users are
"commercial computer software" or “commercial computer software documentation” pursuant to the applicable Federal Acquisition Regulation and agency-specific supplemental




                                                                                                                                                                                  7
regulations. As such, the use, reproduction, duplication, release, display, disclosure, modification, preparation of derivative works, and/or adaptation of i) Oracle programs
(including any operating system, integrated software, any programs embedded, installed or activated on delivered hardware, and modifications of such programs), ii) Oracle
computer documentation and/or iii) other Oracle data, is subject to the rights and limitations specified in the license contained in the applicable contract. The terms governing the
U.S. Government’s use of Oracle cloud services are defined by the applicable contract for such services. No other rights are granted to the U.S. Government.

This software or hardware is developed for general use in a variety of information management applications. It is not developed or intended for use in any inherently dangerous
applications, including applications that may create a risk of personal injury. If you use this software or hardware in dangerous applications, then you shall be responsible to take
all appropriate fail-safe, backup, redundancy, and other measures to ensure its safe use. Oracle Corporation and its affiliates disclaim any liability for any damages caused by
use of this software or hardware in dangerous applications.

Oracle and Java are registered trademarks of Oracle and/or its affiliates. Other names may be trademarks of their respective owners.

Intel and Intel Inside are trademarks or registered trademarks of Intel Corporation. All SPARC trademarks are used under license and are trademarks or registered trademarks
of SPARC International, Inc. AMD, Epyc, and the AMD logo are trademarks or registered trademarks of Advanced Micro Devices. UNIX is a registered trademark of The Open
Group.

This software or hardware and documentation may provide access to or information about content, products, and services from third parties. Oracle Corporation and its affiliates
are not responsible for and expressly disclaim all warranties of any kind with respect to third-party content, products, and services unless otherwise set forth in an applicable
agreement between you and Oracle. Oracle Corporation and its affiliates will not be responsible for any loss, costs, or damages incurred due to your access to or use of
third-party content, products, or services, except as set forth in an applicable agreement between you and Oracle.




                                                                                                                                                                                  8

