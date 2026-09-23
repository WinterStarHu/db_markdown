# 80. ODBC Driver Release Notes

> 源文件: `en/odbcr/odbc-driver-release-notes.pdf`

Oracle® Database
ODBC Driver Release Notes
Release 19c, version 19.1.0.0.0
E96305-01
January 2019




                          ODBC Driver Release Notes
                          The Oracle ODBC Driver Release Notes describe the following topics:
                          •   Description
                          •   New Features
                          •   Functionality
                          •   Software Required
                          •   Server Software Requirements
                          •   Hardware Required
                          •   Testing Matrix
                          •   More Information
                          •   Documentation Accessibility


                          Description
                          The Oracle ODBC Driver enables applications to connect to Oracle database from a
                          Windows client as well as from a UNIX client that use Microsoft Open Database
                          Connectivity (ODBC) API to read from and write to Oracle databases.
                          The Oracle ODBC Driver distribution kit consists of Dynamic Link Libraries and shared
                          libraries (for UNIX platforms), help file (on UNIX and Windows platforms), a copy of the
                          license and this product description. To use an ODBC enabled application the
                          following software is required in addition to the Oracle ODBC Driver:
                          •   Oracle Client & Net version 12.2
                          •   Oracle Database Server
                          Oracle ODBC Driver complies with ODBC 3.52 specifications.


                          New Features
                          Describes new features by release from release 10.1.0.2.0 to the current release.
                          Oracle ODBC Driver new features are described for the following releases:


                                                                                                                1
•   ODBC Release 19c, Version 19.1.0.0.0
•   ODBC Release 18c, Version 18.1.0.0.0
•   ODBC 12.2.0.1.0
•   ODBC 12.1.0.2.0
•   ODBC 12.1.0.1.0
•   ODBC 11.2.0.1.0
•   ODBC 11.1.0.1.0
•   ODBC 10.2.0.1.0
•   ODBC 10.1.0.2.0

ODBC Release 19c, Version 19.1.0.0.0
Describes new features for release 19c, version 19.1.0.0.0
There are no new features of the Oracle ODBC Driver release 19c, version 19.1.0.0.0
software for the Microsoft Windows Server 2008, Windows Server 2008 R2, Windows
Server 2012, Windows Server 2012 R2, Windows 7, Windows 8, Windows 8.1,
Windows 10, Linux X86-64 (32-bit, 64-bit), Sun Solaris SPARC64 (32-bit, 64-bit), IBM
AIX 5L (32-bit, 64-bit), Sun Solaris X64 (32-bit, 64-bit), HPUX IA64 (32-bit, 64-bit),
ZLinux (32-bit, 64-bit) operating systems.

ODBC Release 18c, Version 18.1.0.0.0
Describes new features for release 18c, version 18.1.0.0.0
Features of the Oracle ODBC Driver release 18c, version 18.1.0.0.0 software for the
Microsoft Windows Server 2008, Windows Server 2008 R2, Windows Server 2012,
Windows Server 2012 R2, Windows 7, Windows 8, Windows 8.1, Windows 10, Linux
X86-64 (32-bit, 64-bit), Sun Solaris SPARC64 (32-bit, 64-bit), IBM AIX 5L (32-bit, 64-
bit), Sun Solaris X64 (32-bit, 64-bit), HPUX IA64 (32-bit, 64-bit), ZLinux (32-bit, 64-bit)
operating systems are described as follows:
•   unixODBC ODBC Driver Manager is upgraded from unixODBC–2.3.2 to
    unixODBC–2.3.4.

ODBC 12.2.0.1.0
Describes new features for release 12.2.0.1.0.
Features of the Oracle ODBC Driver release 12.2.0.1.0 software for the Microsoft
Windows Server 2008, Windows Server 2008 R2, Windows Server 2012, Windows
Server 2012 R2, Windows 7, Windows 8, Windows 8.1, Windows 10, Linux X86-64
(32-bit, 64-bit), Sun Solaris SPARC64 (32-bit, 64-bit), IBM AIX 5L (32-bit, 64-bit), Sun
Solaris X64 (32-bit, 64-bit), HPUX IA64 (32-bit, 64-bit), ZLinux (32-bit, 64-bit) operating
systems are described as follows:
•   Support is added for long identifiers up to 128 bytes.




                                                                                          2
•   Support is added for time stamp with time zone and time stamp with local time
    zone.
    This features does not require changes to the existing ODBC application where
    ODBC TIMESTAMP data type is used. If an existing application uses ODBC
    TIMESTAMP data type and the database column is TIMESTAMP, the current behavior
    is preserved.
    For database column TIMESTAMP WITH TIMEZONE or TIMESTAMP WITH LOCAL
    TIMEZONE, the time component in the ODBC TIMESTAMP_STRUCT is in the user’s
    session time zone. This behavior is transparent to the user’s application, requiring
    no change to the ODBC application.

ODBC 12.1.0.2.0
Describes new features for release 12.1.0.2.0.
Features of the Oracle ODBC Driver release 12.1.0.2.0 software for the Microsoft
Windows Server 2008, Windows Server 2008 R2, Windows Server 2012, Windows 7,
Windows 8, Windows 10, Linux X86-64 (32-bit, 64-bit), Sun Solaris SPARC64 (32-bit,
64-bit), IBM AIX 5L (32-bit, 64-bit), Sun Solaris X64 (32-bit, 64-bit), HPUX IA64 (32-bit,
64-bit), ZLinux (32-bit, 64-bit) operating systems are described as follows:
•   Microsoft Windows 10 platform is added.

ODBC 12.1.0.1.0
Describes new features for release 12.1.0.1.0.
Features of the Oracle ODBC Driver release 12.1.0.1.0 software for the Microsoft
Windows Server 2008, Windows Server 2008 R2, Windows 7,Windows 8, Windows
Server 2012,Linux X86-64 (32-bit, 64-bit), Sun Solaris SPARC64 (32-bit, 64-bit), IBM
AIX 5L (32-bit, 64-bit), Sun Solaris X64 (32-bit, 64-bit), HPUX IA64 (32-bit, 64-bit),
ZLinux (32-bit, 64-bit) operating systems are described as follows:
•   Oracle ODBC Driver now supports 32 KB data columns with VARCHAR2, NVARCHAR2,
    and RAW data. See Oracle Database PL/SQL Packages and Types Reference and
    Oracle Database SQL Language Reference for information about creating 32 KB
    columns.
•   ODBC driver supports the migration of third-party applications to Oracle
    Databases by using the SQL Translation Framework. This enables non-Oracle
    database SQL statements to run against Oracle Database. For using this feature
    with an ODBC application, you must specify the service name, which was created
    as part of SQL Translation Framework setup, as the ServerName= entry in the
    odbc.ini file. If you require support for translation of Oracle errors (ORA errors) to
    your the native database, once your application starts running against Oracle
    Database, then you must enable the SQLTranslateErrors=T entry in the odbc.ini
    file.
    See Oracle Database SQL Translation and Migration Guide on "How to Use SQL
    Translation Framework" before migrating a third-party ODBC application to Oracle
    Database.




                                                                                         3
•   Oracle ODBC driver now supports executing a stored procedure, which can return
    implicit results without using RefCursor. This support eases any third party ODBC
    application, which migrated to Oracle and wants to use this same functionality that
    was provided by their previous vendors.
    See Oracle Database SQL Translation and Migration Guide for more information
    about implicit results support by Oracle Database.
•   Extended support of SQLColAttribute() field identifiers to support Oracle
    Database auto increment feature. You can use this feature by including Oracle
    ODBC driver specific header file sqora.h in the application. See Oracle Call
    Interface Programmer's Guide for more information about auto increment:
    –   SQL_COLUMN_AUTO_INCREMENT
        Starting from Oracle Database Release 12c Release 1 (12.1), Oracle supports
        auto increment columns so the Oracle ODBC Driver has extended the same
        support through the existing SQLColAttribute() identifier
        SQL_COLUMN_AUTO_INCREMENT. This property is read only and returns SQL_TRUE
        if the column is auto increment; otherwise, it returns SQL_FALSE.
    –   SQL_ORCLATTR_COLUMN_PROP
        Starting from Oracle Database Release 12c Release 1 (12.1), Oracle ODBC
        Driver supports a new driver specific field identifier
        SQL_ORCLATTR_COLUMN_PROP, which returns the attributes of the column. This
        identifier returns SQLULEN value, which has all the column properties, shown as
        follows:
        +-----------------------------------------+
        | 32 |...| 10 | 9 | 8 |......| 3 | 2 | 1 |
        +-----------------------------------------+
                                           | | |
                                           | | |-> Column is auto-increment?
                                           | |-> Auto value is always generated?
                                           |-> If generated by default when null?


ODBC 11.2.0.1.0
Describes new features for release 11.2.0.1.0.
•   Oracle ODBC driver has been enhanced to prefetch LONG and LONG RAW data to
    improve performance of ODBC applications. To do this, the maximum size of LONG
    data (MaxLargeData) has to be set in registry on Windows (also need to add the
    registry key MaxLargeData= in the DSN), and in odbc.ini file on UNIX platforms
    manually. This enhancement has improved the performance of Oracle ODBC
    driver up to 10 times, depending on the MaxLargeData size set by the user. The
    default value of MaxLargeData is 0. The maximum value for MaxLargeData that can
    be set by the user is 64 KB (65536 bytes). Even if the value of MaxLargeData is set
    to some value greater than 65536, the data fetched will be 65536 bytes only. If a
    user has LONG and LONG RAW data in database, which is greater that 65536 bytes,
    MaxLargeData should be set to 0 (the default value), which will result in single row
    fetch and the complete LONG data can be fetched. In case the user has passed the
    buffer less than MaxLargeData size in non-polling mode, the data truncation error




                                                                                      4
    will occur if LONG data size in the database is greater than the buffer size.
    (Enhancement Request 7006879).
•   Oracle ODBC Driver is now made to support OCIDescribeAny() call (to get
    metadata) to improve performance when the application is making heavy calls to
    small packaged procedures that return REF CURSORS through the option called
    UseOCIDescribeAny in odbc.ini. To use OCIDescribeAny() on UNIX platforms,
    set UseOCIDescribeAny to T (True) in odbc.ini file, and on Windows through the
    registry in DSN. (Enhancement Request 7704827).

ODBC 11.1.0.1.0
Describes new features for release 11.1.0.1.0.
•   Added support for Disable RULE Hint. Oracle ODBC Driver now allows user to
    specify the option to select whether to use RULE Hint in catalog APIs. The change
    has been done to increase the performance of ODBC driver for catalog APIs. The
    default value for the option is TRUE which means that RULE Hint will not be used in
    catalog APIs by default. (Bug4150034).
•   Added support for Bind Number As FLOAT. By introducing Column Binding for
    NUMBER Column as FLOAT when the column contains FLOAT data speeds up the
    query execution that uses bind variables as FLOAT. (Bug4608183).
•   Added support for OCI statement caching feature that provides and manages a
    cache of statements for each session. By implementing the support for OCI
    Statement Caching option, Oracle ODBC Driver will see the increase in
    performance where users have to parse the same statement multiple times in the
    same connection. The default value for the statement cache flag is FALSE.
•   Changed the behavior of Result-set cache by saving the unnecessary memory
    calls to increase the ODBC Driver Performance.

ODBC 10.2.0.1.0
Describes new features for release 10.2.0.1.0.
•   Added support for named parameter, binding parameters by name. Oracle ODBC
    Driver now allows application to specify the parameters to a stored procedure by
    name, in the procedure call. Named parameters are only to be used in calls to
    stored procedures, and not to be used in other SQL statements. (Bug3617324)
•   Changed the behavior of describing metadata for stored procedures that exist in
    some package. The change has been done to increase the performance of ODBC
    Driver for stored procedure calls. Now if the stored procedure is in some package,
    then the metadata will be described using a PL/SQL procedure. (Bug4030664)
•   The support for Oracle ODBC Driver for Linux and Solaris platforms is introduced
    in release 10.2.0.1. From release 10.2.0.4 ODBC Driver was made available for
    the AIX platform as well.

ODBC 10.1.0.2.0
Describes new features for release 10.1.0.2.0.


                                                                                       5
•   Added support for NCHAR columns in INSERT/UPDATE statements with parameter
    markers, (Bug 2827132). Previously, the driver did not notice that the column was
    of NCHAR type and failed to set the proper attribute when binding at the OCI level.
    As a side effect, the SQLDescribeParam call now returns useful information for
    parameters in INSERT/UPDATE statements, though not in other statement types.
•   Added support for LOBs larger then 4 GB. Requires the Oracle Client and
    Database to both be Oracle Database 10g (10.1) or later.
•   Added support for the new BINARY_FLOAT and BINARY_DOUBLE data types in Oracle
    Database 10g and later servers.
•   Added support for MONTHNAME and DAYNAME functions in SQL statements.


Functionality
The Oracle ODBC Driver complies with Version 3.52 of the Microsoft ODBC
specification.


Software Required
Oracle ODBC driver was certified against the currently supported Windows and UNIX
operating system versions, the most current release of Oracle Net Client and Oracle
Universal Installer shipping with Oracle Database.
Oracle ODBC driver was certified against:
•   Windows operating system versions: Windows Server 2008, Windows Server
    2008 R2, Windows 7,Windows 8, and Windows Server 2012
•   UNIX operating system versions: 32-bit and 64-bit ports of Linux X86-64, AIX5L,
    Solaris.Sparc64, Solaris X64, HPUX.IA64, and ZLinux
Oracle Net Client 12.2
Oracle Universal Installer shipping with Oracle Database 12.2


Server Software Requirements
Oracle Database Server 10.2 or later is the server software required to support ODBC
enabled applications through the Oracle ODBC Driver.


Hardware Required
What are the requirements for Oracle ODBC Driver system configuration for Windows
and UNIX platforms?
The Oracle ODBC Driver requires a system configuration supported by certified
Windows platforms as mentioned in Software Required and on few UNIX platforms as
documented in Oracle ODBC Driver for UNIX Platforms Readme.


Testing Matrix

                                                                                      6
The following table summarizes the Windows operating system versions on which
ODBC driver was certified.

Table 1-1   Oracle ODBC Driver Is Certified on Windows Operating Systems

Driver Version                Database Version              Operating Systems
12.2.0.1                      As Supported by OCI           See Software Required.


More Information
To learn more about post-installation tasks, known software problems for Oracle
ODBC Driver, information about ODBC Driver for UNIX platforms, software problems
fixed, and the certification matrix on UNIX platforms, see the sections that follow.
•   Post-Installation
•   Known Software Problems for Oracle ODBC Driver
•   ODBC Driver For UNIX Platforms
•   Software Problems Fixed

Post-Installation
You must configure the data sources on Windows and on UNIX platforms.
Use the Microsoft ODBC Administrator to configure your Oracle ODBC Driver data
sources on Windows. See the information about configuring the data source in Oracle
Database Development Guide for more information.
For the UNIX Client, see ODBC Driver For UNIX Platforms.

Known Software Problems for Oracle ODBC Driver
Learn about known software problems and unsupported usage.
•   The SQLSetStmtOption SQL_QUERY_TIMEOUT does not work if the database server
    is running on Windows NT. As a workaround, setting BREAK_POLL_SKIP=1 in the
    server's sqlnet.ora file solves the problem. By default, this is set to 100, and the
    database would not check for a time out set by the ODBC application.
•   SQLBindParameter when used to bind a buffer as SQL_PARAM_INPUT_OUTPUT and
    having a PL/SQL procedure with IN OUT parameter and if the parameter is not
    changed in the procedure, then the driver will not return SQL_NULL_DATA in
    StrLen_or_IndPtr.
•   Oracle ODBC driver does not support the usage of Keyset cursors with the CASE
    clause in a SQL SELECT query.

ODBC Driver For UNIX Platforms



                                                                                           7
Oracle ODBC Driver for UNIX platforms complies with ODBC 3.52 specifications. It is
based on features of Oracle 12.2 client.
See the Certification Matrix, to learn more about the platforms on which Oracle ODBC
Driver 12.2 is supported.
This section describes the following topics:
•   Pre-installation Task – Install ODBC DM from unixODBC.org
•   Post-installation Task
•   Uninstalling ODBC Driver
•   Bugs Fixed
•   Certification Matrix

Pre-installation Task – Install ODBC DM from unixODBC.org
Complete this pre-installation task before installing the ODBC Driver for UNIX
platforms.
Please install ODBC Driver Manager after downloading .tar file from http://
www.unixodbc.org/.

Post-installation Task
Complete these post-installation tasks.
•   Configure Oracle ODBC driver on UNIX platforms.
    You can configure Oracle ODBC Driver by running install-home/odbc/utl/
    odbc_update_ini.sh.
    The utility odbc_update_ini.sh takes four command-line arguments:
    –   arg-1 : Complete path where unixODBC DM has been installed.
    –   arg-2 : Complete path of driver install location (optional); if this argument is
        not passed, the driver path is set to the directory from where the utility is run.
    –   arg-3 : Driver name (optional); if this argument is not passed, driver name is
        set to Oracle 12c ODBC driver.
    –   arg-4 : Data Source Name (optional); if no value is passed, DSN is set to
        OracleODBC-12c.
•   Update and verify values of environment variables such as: PATH,
    LD_LIBRARY_PATH, LIBPATH, and TNS_ADMIN.

Uninstalling ODBC Driver
Complete these tasks to uninstall the Oracle ODBC Driver from UNIX platforms.
•   Update ~/.odbc.ini file:
    –   Remove the DSN entry (for example, OracleODBC-12c) from [ODBC Data
        Sources].


                                                                                             8
    –    Remove the complete DSN information for the corresponding DSN.
•   Update ODBCDM_HOME/etc/odbcinst.ini file:
    –    Remove the driver information for Oracle 12c ODBC driver.
•   Remove Oracle ODBC driver for UNIX platforms
    –    Delete libsqora.so.12.1
•   Reset environment variables such as: PATH, LD_LIBRARY_PATH, LIBPATH, and
    TNS_ADMIN.

Bugs Fixed
Follow the link to software problems fixed.
See Software Problems Fixed.

Certification Matrix
Oracle has certified Oracle ODBC Driver for release 12.2 against DM 2.3.1 on the
listed UNIX platforms.
These UNIX platforms are shown in Table 1-2. On 64bit UNIX platforms, DM 2.3.1 is
built with the -DBUILD_REAL_64_BIT_MODE -DSIZEOF_LONG=8 -fshort-wchar flags and
then certified.

Table 1-2     Certification Matrix for Oracle ODBC Driver on UNIX Platforms

Platform                      32-bit/64-bit                UnixODBC DM version
Linux x86-64                  32-bit, 64-bit               2.3.1
Solaris SPARC64               32-bit, 64-bit               2.3.1
AIX5L                         32-bit, 64-bit               2.3.1
Solaris x64                   32-bit, 64-bit               2.3.1
HPUX.IA64                     32-bit, 64-bit               2.3.1
ZLinux                        32-bit, 64-bit               2.3.1

See the Installation guide of each platform to learn more about each operating system
and Oracle Client software requirements.

Software Problems Fixed
Software problems fixed are shown by version for versions 11.1.0.1.0 to the current
version.
Most of the software bug fixes are generic in nature though some may have been
discovered on a particular platform. There could be a small number of platform specific
software bug fixes as well. Software bug fixes are described for the following versions:
•   Version 19.1.0.0.0




                                                                                      9
•   Version 18.1.0.0.0
•   Version 12.2.0.1.0
•   Version 12.1.0.2.0
•   Version 12.1.0.1.0
•   Version 11.2.0.2.0
•   Version 11.2.0.1.0
•   Version 11.1.0.1.0

Version 19.1.0.0.0
Lists the problems fixed for version 19.1.0.0.0
•   12.2 UNIX ODBC Driver failed with HY003:1:-1:[ORACLE][ODBC][ORA]ORA-0001
    error. (Bug 27684767)
•   Row SELECT operation in Oracle ODBC Driver is slower than DataDirect ODBC
    Driver. (Bug 27641555)
•   Oracle ODBC raised ORA-3137 [KPOAL8CHECK-3] error, when setting
    BAM=AllSuccessful and connecting to DB 12.2. (Bug 28250843)
•   Oracle ODBC Driver in 12c failed at TIMESTAMP conversion. (Bug 27132192)
•   Application crashed when executing PL/SQL with LONG literal by ODBC call. (Bug
    27743516)

Version 18.1.0.0.0
Lists the problems fixed for version 18.1.0.0.0
•   Upgrade unixODBC from 2.3.2 to 2.3.4. (Bug 19179407)
•   ODBC SQLColumns no longer returns an error when passing in an empty string as
    a column name. (Bug 23637102)
•   ODBC Recordset.Update no longer fails with error ORA-00942 using 12c Oracle
    ODBC Driver. (Bug 24926081)
•   Setting DBA=R in DSN now works when connecting to Exadata Express Cloud.
    (Bug 25376850)
•   OdbcConnection.GetSchema no longer throws a
    SYSTEM.ACCESSVIOLATIONEXCEPTION error. (Bug 25597467)
•   ODBC Driver no longer crashes when SQL_DESC_BIND_OFFSET_PTR is set. (Bug
    25832115)
•   ODBC SQL_ATTR_QUERY_TIMEOUT now works as expected. (Bug 26352452)
•   Row insert operation in Oracle ODBC is no longer slower than the DataDirect
    ODBC Driver (Bug 23288642)
•   After migrating an 11gR2 ADO/ODBC application, it no longer causes the wrong
    result on a recordset operation. (Bug 19000463)



                                                                                  10
•   ODBC Driver API SQLStatistics now passes the SCHEMANAME value for filtering.
    (Bug 23259086)
•   ODBC SQLFetch no longer fails with abort (core dumped) error. (Bug 23186348)
•   ODBC SQLFetch no longer returns no data when binding a TIMESTAMP column with
    SQL_C_CHAR. (Bug 23120325)

Version 12.2.0.1.0
Lists the problems fixed for version 12.2.0.1.0.
•   Oracle ODBC driver 12.1.0.2 had a performance degradation that was observed
    when using the DBMS.DESCRIBE procedure. (Bug 22566981)
•   ODBC Driver now includes the version number in the driver name when
    OCI_ATTR_DRIVER_NAME is set, such as ODBCCLNT : 12.2.0.1.0. (Bug 21795969)
•   Oracle ODBC driver truncated an output parameter of SP when run from 12.1.0.2.
    (Bug 21616079)
•   Multi-threaded UNIX ODBC application hung on SSLSSREGHDLR. (Bug 21459317)
•   Oracle ODBC driver now allows a Server name length to 1024 bytes long. (Bug
    21379636)
•   Oracle ODBC driver raised an error [ORACLE][ODBC][ORA]ORA-00911 :INVALID
    CHARACTER(#911). (Bug 21372951)
•   Oracle ODBC driver in 12.2 encountered an ORA:01000 error when statement
    caching was enabled. (Bug 21255142)
•   Oracle ODBC driver calling a procedure with two out parameters, RAW and DATE
    failed with an ORA-01483 error. (Bug 20716320
•   Oracle ODBC driver returned an empty message string in the generated
    exception. (Bug 20517697)
•   Oracle ODBC driver crashed during a call of Oracle functions with return type
    REFCURSOR. (Bug 20387007)
•   Oracle ODBC driver corrupted data when inserting an image of BLOB type. (Bug
    19720146)
•   Oracle ODBC driver SQLColumns() API returned the wrong metadata for the TSLTZ
    column. (Bug 19573657)
•   Oracle ODBC driver had different TSLTZ outputs when binding with CHAR types.
    (Bug 19545406)
•   Oracle ODBC driver quit at SQLFETCH() with cursor type
    SQL_CURSOR_KEYSET_DRIVEN. (Bug 19531841)
•   Oracle ODBC driver quit while fetching from a procedure that returns a REF cursor.
    (Bug 19530596)
•   Oracle ODBC driver during a SQLFETCH() gave an undefined symbol: M_FMEMALLOC
    with SQL_C_WCHAR. (Bug 19529966)




                                                                                    11
•   Oracle ODBC driver during a SQLFETCH() quit when bound with SQL_C_CHAR or
    SQL_C_BINARY. (Bug 19529718)
•   Oracle ODBC driver crashed when passing more than 4093 characters. (Bug
    19524047)
•   Oracle ODBC driver using a stored procedure with NCHAR data type did not execute
    correctly with ODBC 12.1.0.1. (Bug 19158940)
•   Oracle ODBC driver 12.1.0.1 using a procedure returned NULL. (Bug 19026257)
•   Migrating an Oracle Database 11g Release 2 (11.2) ADO/ODBC application
    caused the wrong result on a recordset operation. (Bug 19000463)
•   Oracle ODBC driver could not retrieve a CLOB containing CHR(0). (Bug 18749178)
•   Oracle ODBC driver raised a database exception with an INSERT statement with
    11.2.0.3 + P30. (Bug 18681683)
•   Oracle ODBC driver got an access violation in Japanese environment when
    inserting over 64K data into a LONG RAW column. (Bug 18606539)
•   Oracle ODBC driver reported an ORA-01461 error while inserting into NVARCHAR2
    columns with the Chinese language. (Bug 18232462)
•   ODBC 12.1 application using a query with comments embedded in them failed
    with an ORA-24374 error. (Bug 18024745)
•   Oracle ODBC driver did not free a temporary LOB after fetching data from it. (Bug
    17928169)
•   A Microsoft Access client hung trying to link a table over a database link. (Bug
    17925209)
•   ODBC connection hung in Japanese environment when the CLOB type contained
    the data of CHR(0). (Bug 17901129)
•   Oracle ODBC driver crashed on ORANLS12. (Bug 17896495)
•   Oracle ODBC driver reported an ORA-1410 error when fetching data from an index
    organized table using KEYSET_DRIVEN cursor. (Bug 17583959)
•   Oracle ODBC driver using a query returned a truncated value. (Bug 16959397)
•   ODBC application with a SQLFETCH after SQLCOLUMNS resulted in a
    SUCCESS_WITH_INFO message for an invalid view. (Bug 16324625)
•   ODBC application with an array insert of LOBs resulted in the last LOB only being
    inserted multiple times. (Bug 16235055)
•   Oracle ODBC driver with an ODBC idle connection to Microsoft Access resulted in
    an ODBC call failed error. (Bug 16181438)
•   Oracle ODBC driver gave an access violation at SQLEXECUTE when setting
    incorrect binding at TIMESTAMP. (Bug 16009315)
•   Oracle ODBC driver after upgrade to 11.2, SQLSETPARAM and SQL_WCHAR (NCHAR)
    resulted in corruption. (Bug 14623077)
•   Oracle ODBC driver reported an ORA-1843 or ORA–1830 error when inserting a DATE
    type data the second time. (Bug 14308740)




                                                                                       12
•   Oracle ODBC driver reported an ORA-22275 error after an error ORA-1, ORA-14400
    error during insertion. (Bug 13518550)
•   ODBC application rarely returned an S1004 for a SQLFETCH call in a multithreaded
    application. (Bug 13044472)
•   Oracle ODBC driver reported an error ORA-00918 for a query with inner join and
    KEYSET_DRIVEN cursor. (Bug 9642938)
•   Oracle ODBC driver now supports TIMESTAMP WITH LOCAL TIME ZONE data type.
    (Bug 7533808)
•   Oracle ODBC driver quit when using SQLPREPARE with an invalid SQL statement.
    (Bug 7325015)

Version 12.1.0.2.0
Lists the problems fixed for version 12.1.0.2.0.
•   Array insert of type LOB resulted in inserting the last element into all the rows.
    (Bug 16491814)
•   ODBC application use to throw ORA-00918: column ambiguously defined error
    when join and multiple tables were used in a query with a KEYSET_DRIVEN cursor.
    (Bug 9642938)
•   Oracle ODBC driver use to result in ODBC call failed error when the ODBC driver
    tried to reconnect to Oracle Database after Microsoft Access connection timed out.
    (Bug 16181438)
•   Oracle ODBC driver use to give access violation at SQLExecute when setting an
    incorrect bind parameter value for TIMESTAMP database column. (Bug 16009315)
•   Oracle ODBC driver use to return string truncation error S1004 when a
    multithreaded application having common ENV handle across all threads uses
    SQL_C_TCHAR C data type as the buffer type in SQLBindCol when NLS_LANG is
    JA16SJISTILDE. (Bug 13044472)
•   Data truncation with MSADSQL and ATL library where applications rely on
    precision and scale field in SQL_NUMERIC_STRUCT. (Bug 16959397)
•   Crash is due to array bind when the array bind is done a number of times. (Bug
    17896495)
•   Temporary lob not free after data is fetched. (Bug 17928169)
•   When fetching data from index organized table using KEYSET-DRIVEN cursor, it
    results in ORA-01410 error. (Bug 17583959)

Version 12.1.0.1.0
Lists the problems fixed for version 12.1.0.1.0.
•   Oracle ODBC driver use to give ORA-1410 followed by access violation with SELECT
    statement where the table is created and values are inserted with database
    character set as AL32UTF8. (Bug 10132342)




                                                                                         13
•   Oracle ODBC driver use to return ORA-1002 when the ODBC application executes
    and fetches a huge number of rows the second time, but does not reprepare and
    bind the column the second time. (Bug 10131881)
•   Oracle ODBC driver use to throw ORA-932 on inserting a record view MFC
    Recordset. (Bug 9952132)
•   Oracle ODBC driver use to return ORA-1461 or access violation when used with
    SQL_RESET_PARAMS in SQLFreeStmt() API. (Bug 9903704)
•   Oracle ODBC function SQLSetPos() use to overwrite 2 bytes after the row status
    buffer is called with the SQL_UPDATE parameter. (Bug 9764806)
•   Oracle ODBC driver never use to time out when SQL_ATTR_QUERY_TIMEOUT
    statement option is set to a non-zero value on UNIX platforms. (Bug 9714490)
•   Oracle ODBC driver use to return ORA-1406 when an application with client side
    character set as AL32UTF8 was trying to read data from single byte character set
    database. (Bug 8927110)
•   Oracle ODBC driver use to return ORA-1410 after applying the 11.2.0.1 Patch 7
    against a UTF8 Oracle database. (Bug 10422748)
•   ODBC data Source Administrator never use to show the fully qualified service
    name in the drop down box. (Bug 10236704)
•   Oracle ODBC driver use to fail when the CREATE PROCEDURE statement has the
    wide character \r. (Bug 14458246)
•   Oracle ODBC driver use to throw pop up window of change-password repeatedly
    when database password expired. (Bug 10353128)
•   ODBC driver use to hang and/or crash under a multithreaded environment and
    when there was a memory leak during multiple connects and disconnects. (Bug
    9850419)
•   SQLGetData() API of Oracle ODBC driver use to consume more time during
    scalability of threads versus processes. The threaded version of the application
    use to take more time than the process version. (Bug 9835629)
•   Oracle ODBC driver use to fail with access violation in SQLFetchScroll() API with
    the SQL_FETCH_NEXT option. (Bug 9578533)
•   Oracle ODBC driver use to return wrong columns_size and buffer_length values
    through SQLColumns() APIs for CHAR columns. (Bug 9414079)
•   Oracle ODBC driver use to return SQL_NO_DATA_FOUND when SQL_ROWSET_SIZE was
    set to more than the remaining rows. (Bug 9264668)
•   Oracle ODBC driver use to hang when transferring Microsoft Access table data to
    Oracle table. (Bug 8984021)
•   Oracle ODBC driver use to truncate returned data when there were more
    characters with multibyte in a selected row, with NLS_LENGTH_SEMANTICS=CHAR and
    AL32UTF8 database character set. (Bug 8771556)

Version 11.2.0.2.0
Lists the problems fixed for version 11.2.0.2.0.



                                                                                       14
•   ODBC driver use to abort when a SQL Server EXEC statement containing
    procedure without parameters is passed and EXECSyntax=T. (Bug 8393140)
•   ODBC driver use to return wrong suffix and prefix lengths on 64-bit environment.
    (Bug 8429289)
•   ODBC driver use to fail during SQLConnect on AIX environment when DM version
    is set to SQL_OV_ODBC2. (Bug 8639577)
•   ODBC application use to fail on UNIX 64-bit environment when SQLFetchScroll()
    with bind type SQL_C_SLONG. (Bug 8735155)
•   ODBC driver use to truncate the data when there is multi-byte data in a selected
    row with combination of NLS_LENGTH_SEMANTICS=CHAR and AL32UTF8 character set.
    (Bug 8771556)
•   ODBC driver use to crash on Solaris sparc64 while executing the statement. (Bug
    8775499)
•   ODBC driver use to crash on HPUXIA64 while fetching FLOAT/DOUBLE data. (Bug
    8974909)
•   ODBC Driver use to hang during transfer of Microsoft Access table data to Oracle
    table. (Bug 8984021)
•   ODBC driver use to fail on Windows 64-bit while adding data source using
    SQLConfigDataSource() API. (Bug 9023338)
•   ODBC driver use to crash on Solaris while dealing with FLOAT/DOUBLE. Bug
    9058381)
•   ODBC driver used return incorrect data on big endian environment when
    application binds date field to SQL_C_WCHAR. (Bug 9070694)
•   ODBC driver use to crash on UNIX 64-bit environment when
    SQLGetConnectAttr() is used with pointer to UNSIGNED INT. (Bug 9105601)
•   ODBC driver use to map incorrect size for SQL_C_ULONG, SQL_C_SLONG, and
    SQL_C_LONG types on UNIX 64-bit environment. (Bug 9463231)
•   Unicode ODBC application use to fail while SQL execution. (Bug 9743383)
•   ODBC Driver Configuration of "ODBC Data Source Administrator" use to show
    garbage values in the drop down list for TNS Service Name when TNS_ADMIN value
    is set in registry and not as environment variable. (Bug 8796983)
•   ODBC Driver use to return no-data-found in case of SQLROWSET_SIZE is more than
    remaining rows application returns no-data-found when SQLROWSET_SIZE is set
    more than the remaining rows after first fetch. (Bug 9264668)

Version 11.2.0.1.0
Lists the problems fixed for version 11.2.0.1.0.
•   ODBC Driver use to return the wrong length for SQLBindCol on Solaris (port
    specific). (Bug 7660125)
•   Memory leak was reported in the ODBC driver while returning a result set from a
    stored procedure. (Bug 7586197)



                                                                                   15
•   ODBC was failing to update the LONG RAW when the size was more than 65536
    bytes. (Bug 7585970)
•   ODBC application use to fail with a NULL password error when MTS was enabled.
    (Bug 7509964)
•   ODBC Driver use to return an access violation on executing a stored procedure.
    (Bug 7458976)
•   ODBC application use to hang when more connections were created. (Bug
    7388606)
•   ODBC application use to crash when SQLSetParm() was called with a string that is
    non NULL terminated. (Bug 7011807)
•   ODBC Driver use to report an ORA-24817 error on querying a bulk operation. (Bug
    6908070)
•   ODBC Driver use to return the wrong length and data fora SQLGetData() call when
    using NLS character in literal and with NLS settings as NLS_LENGTH_SEMANTICS=
    CHAR, NLS_CHARACTERSET = AL32UTF8. (Bug 6801797)
•   ODBC driver use to crash on 64-bit environments while fetching data. (Bug
    6801211)
•   ODBC Driver use to show the wrong types when using calls SQLDescribeParam(),
    SQLDescribeCol(), SQLColumns(), SQLGetTypeInfo(). (Bug 6598695)
•   ODBC driver use to crash with SQLGetStmtAttr()call. (Bug 6416638)
•   ODBC driver use to report SIGBUS on Solaris SPARC as memory for cache
    blocks was not aligned. (Bug 6411945)
•   ODBC Driver use to return an [ORACLE][ODBC]Memory Allocation Error, while
    describing metadata for a procedure. (Bug 6085754)
•   ODBC Driver use to report an error on executing a procedure after execution of
    the INSERT statement. (Bug 5961436)
•   ODBC Driver use to report an ORA-24374 error whenever a SQL Statement was
    preceded by any valid tokens that did not give the SQL Statement type. (Bug
    5383456)
•   ODBC Driver use to return the same error message twice with a SQLExecute()call.
    (Bug 5222165)
•   ODBC Driver use to return an ORA-24374 error when executing a query that
    included a line comment. (Bug 4743995)

Version 11.1.0.1.0
Lists the problems fixed for version 11.1.0.1.0.
•   ODBC driver use to fail in updating the output parameter of a stored procedure
    when it contained a large CLOB parameter as the input parameter. (Bug 5365475)
•   ODBC Driver use to do an improper round off for DOUBLE data if connecting to a 10
    GB database. (Bug 5389003)




                                                                                     16
•   ODBC driver use to fail in updating the output parameter of a stored procedure
    when it contained a large CLOB parameter as an input parameter. (Bug 5365475)
•   ODBC driver use to truncate CLOB data for a client UNICODE character set. (Bug
    5220440)
•   ODBC driver use to return old data on requering the data for a read-only
    connection. (Bug 5202103)
•   ODBC driver use to report an ORA-1008 error, when an MFC application requeries
    the database. (Bug 5147229)
•   ODBC driver use to return the wrong value on fetching a NUMBER value that is
    converted to SQL_C_CHAR. (Bug 5128512)
•   ODBC driver use to return the wrong information for few column types. (Bug
    5015342)
•   ODBC driver use to report an ORA-12704 error on the second invocation of a
    SQLExecute() call for NCLOB columns. (Bug 4965677)
•   ODBC Driver use to report a crash on exit from an ADO and Excel applications.
    (Bug 4893583)
•   ODBC Driver use to return 0 as the data type on calling SQLBindCol() after
    SQLColumns(). This problem appears only on the Solaris platform, but the software
    fix is generic. (Bug 4880062)
•   ODBC Administrator use to show ODBC entries even after uninstalling the ODBC.
    (Bug 4761792)
•   ODBC driver use to truncate the data retrieved with the SQLFetchScroll() call.
    (Bug 4735799)
•   ODBC driver use to result in an application crash while executing a stored
    procedure having a large number of parameters. (Bug 4727495)
•   DM from UNIXODBC.ORG reports error: Driver does not support
    SQLSETSTMTATTR(). This is a port specific (Linux and Solaris) bug. (Bug 4710548)
•   ODBC driver use to report an undefined symbol SLEEP when fail over happened.
    (Bug 4698310)
•   ODBC Driver use to report a crash on inserting NULL data using bind offsets. (Bug
    4694220)
•   ODBC Driver use to set the value corresponding to attribute
    SQL_ATTR_PARAMS_PROCESSED_PTR improperly when the stored procedure
    execution was with array binds. (Bug 4690201)
•   ODBC Driver use to report a crash when returning an array of VARCHARs from a
    stored procedure. (Bug 4690147)
•   ODBC Driver use to give an incomplete result set when the stored procedure
    contained REF CURSOR arguments. (Bug 4624776)
•   ODBC driver use to report an error on executing a stored procedure containing
    REF CURSOR parameters. (Bug 4622561)
•   ODBC Driver use to take more time fetching data from a NUMBER column containing
    FLOAT data. (Bug 4608183)



                                                                                     17
•       ODBC driver use to return duplicate results for a SQLProcedures() call. (Bug
        4565416)
•       ODBC Driver use to report a memory leak for a stored procedure containing REF
        CURSORS. (Bug 4551675)
•       ODBC Driver use to return an ORA-1406 error when selecting a calculated number
        with a large precision from a view. (Bug 4546618)
•       ODBC driver use to report a crash for executing queries in a multithreaded
        application. (Bug 4519067)
•       ODBC administrator use to invoke English ODBC help in the Japanese
        environment. (Bug 4506552)
•       ODBC driver use to report the error Input string too long, limit 4096, when
        the long string contained CRLF code (\n \r) and contained more that 4096
        characters after the CRLF characters. (Bug 4371966)
•       ODBC administrator use to fail while opening the help file under an Instant Client
        environment. (Bug 4309867)
•       ODBC Driver use to return the wrong data for stored procedures having NCLOB as
        the OUT Param. (Bug 4235212)
•       ODBC catalogue functions use to take more time to complete. (Bug 4150034)


Documentation Accessibility
For information about Oracle's commitment to accessibility, visit the Oracle
Accessibility Program website at http://www.oracle.com/pls/topic/lookup?
ctx=acc&id=docacc.


Access to Oracle Support
Oracle customers that have purchased support have access to electronic support
through My Oracle Support. For information, visit http://www.oracle.com/pls/topic/
lookup?ctx=acc&id=info or visit http://www.oracle.com/pls/topic/lookup?ctx=acc&id=trs
if you are hearing impaired.




Oracle® Database ODBC Driver Release Notes, Release 19c, version 19.1.0.0.0
E96305-01

Copyright © 2009, 2019, Oracle and/or its affiliates. All rights reserved.

This software and related documentation are provided under a license agreement containing restrictions on use and disclosure and are protected by intellectual property laws.
Except as expressly permitted in your license agreement or allowed by law, you may not use, copy, reproduce, translate, broadcast, modify, license, transmit, distribute, exhibit,
perform, publish, or display any part, in any form, or by any means. Reverse engineering, disassembly, or decompilation of this software, unless required by law for
interoperability, is prohibited.

The information contained herein is subject to change without notice and is not warranted to be error-free. If you find any errors, please report them to us in writing.

If this is software or related documentation that is delivered to the U.S. Government or anyone licensing it on behalf of the U.S. Government, then the following notice is
applicable:

U.S. GOVERNMENT END USERS: Oracle programs, including any operating system, integrated software, any programs installed on the hardware, and/or documentation,
delivered to U.S. Government end users are "commercial computer software" pursuant to the applicable Federal Acquisition Regulation and agency-specific supplemental
regulations. As such, use, duplication, disclosure, modification, and adaptation of the programs, including any operating system, integrated software, any programs installed on
the hardware, and/or documentation, shall be subject to license terms and license restrictions applicable to the programs. No other rights are granted to the U.S. Government.




                                                                                                                                                                              18
This software or hardware is developed for general use in a variety of information management applications. It is not developed or intended for use in any inherently dangerous
applications, including applications that may create a risk of personal injury. If you use this software or hardware in dangerous applications, then you shall be responsible to take
all appropriate fail-safe, backup, redundancy, and other measures to ensure its safe use. Oracle Corporation and its affiliates disclaim any liability for any damages caused by
use of this software or hardware in dangerous applications.

Oracle and Java are registered trademarks of Oracle and/or its affiliates. Other names may be trademarks of their respective owners.

Intel and Intel Xeon are trademarks or registered trademarks of Intel Corporation. All SPARC trademarks are used under license and are trademarks or registered trademarks of
SPARC International, Inc. AMD, Opteron, the AMD logo, and the AMD Opteron logo are trademarks or registered trademarks of Advanced Micro Devices. UNIX is a registered
trademark of The Open Group.

This software or hardware and documentation may provide access to or information about content, products, and services from third parties. Oracle Corporation and its affiliates
are not responsible for and expressly disclaim all warranties of any kind with respect to third-party content, products, and services unless otherwise set forth in an applicable
agreement between you and Oracle. Oracle Corporation and its affiliates will not be responsible for any loss, costs, or damages incurred due to your access to or use of third-
party content, products, or services, except as set forth in an applicable agreement between you and Oracle.




                                                                                                                                                                               19

