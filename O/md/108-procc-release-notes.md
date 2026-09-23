# 108. Pro*C/C++ Release Notes

> 源文件: `en/pccrn/c-c-release-notes.pdf`

Pro*C/C++
Release Notes
19c
E96465-02
March 2022




                Release Notes

                About these Release Notes
                This document contains important information about Pro*C/C++ release 19c, version
                19.1.
                It contains the following topics:
                •   Documentation Accessibility
                •   Compatibility and Migration Issues
                •   New Features in Previous Releases
                •   Known Bugs
                •   Bugs Fixed
                •   Support


                Documentation Accessibility
                For information about Oracle's commitment to accessibility, visit the Oracle
                Accessibility Program website at http://www.oracle.com/pls/topic/lookup?
                ctx=acc&id=docacc.


                Access to Oracle Support
                Oracle customers have access to electronic support through My Oracle Support. For
                information, visit http://www.oracle.com/pls/topic/lookup?ctx=acc&id=info or
                visit http://www.oracle.com/pls/topic/lookup?ctx=acc&id=trs if you are hearing
                impaired.


                Compatibility and Migration Issues
                This section describes compatibility issues when migrating from earlier releases of
                Pro*C/C++.


                                                                                                      1
Compatibility Between 32 Bit and 64 Bit Implementations
On platforms which support both 32 bit and 64 bit implementations, you must re-
precompile your applications which include sqlca via an EXEC SQL INCLUDE
statement before linking with the 64 bit binaries. For applications which include sqlca.h
via the #include preprocessor statement, you must recompile to include the 64 bit
sqlca.h before relinking with the 64 bit binaries.
In the future, to support generated code compatibility across implementations, only
one version, the 64 bit version, of sqlca.h may be supplied on ports which support both
32 bit and 64 bit binaries.

Pro*C/C++ Configuration File
The Pro*C/C++ configuration file precomp/admin/pcscfg.cfg needs to be updated with
the appropriate path for sys_include option. Environment variables can be used to
specify the path, e.g, $ORACLE_HOME for Unix systems and %ORACLE_HOME% for Windows.
Your include option should also be updated appropriately.
sys_include=($ORACLE_HOME/precomp/public,/usr/include)
<pre>sys_include=/usr/lib/gcc/i386-redhat-linux/4.1.1/include
<pre>include=($ORACLE_HOME/precomp/public)
<pre>include=$ORACLE_HOME/precomp/hdrs


LTYPE=SHORT
Setting the LTYPE=SHORT option causes .lis files to be generated using the
verbose form rather than the expository form in which the entire program is listed.


New Features in Previous Releases
This section lists new features introduced to Pro*C/C++ in previous releases.

Features in Pro*C/C++ 18.1 Production

The following feature is new in this release:
•   Support for Oracle Connection Manager in Traffic Director Mode
    Oracle Connection Manager in Traffic Director Mode is a proxy that is placed
    between supported database clients and database instances for improved high
    availability, connection multiplexing, and load balancing.

Features in Pro*C/C++ 12.2 Production
•   Support for long identifiers (object lengths of 128 bytes). In previous releases, the
    object length limit was 30 bytes.
•   Support for Oracle Instant Client - Basic Light version.




                                                                                            2
•   New command line option, trim_password, to prevent authentication issues
    caused by password strings that contain trailing blank space.
•   Pro*C/C++ Compatibility with vc12 (Visual Studio 2013 compiler).

Features in Pro*C/C++ 12.1 Production
•   Support for Auto Increment Columns
•   Support for 32k Columns
•   Support for Prefetch By Memory
•   Support for SQL Plan Management (SPM)


Bugs Fixed
The following section lists bugs fixed in Pro*C/C++. Numbers in parentheses following
the description refer to bug numbers in the Oracle Bug Database.

Bugs Fixed in Pro*C/C++ Release 12.2 Production
•   Pro*C/C++ no longer throws CSF-S-00000 error when common_parser=yes in the
    timezone.pc file (9531787)
•   Pro*C/C++ no longer throws ORA-01008 error when binds are used in the Select
    list while common_parser=yes (14127422)
•   Pro*C/C++ no longer throws ORA-932 error when precompiling with option
    USERID and common_parser=yes for an INSERT statement which has CASE
    clause and TIMESTAMP function (14335958, 19473788)
•   Pro*C/C++ no longer fails to set SQLSTATE during rollback, with MODE=ANSI
    and without declaring SQLCODE (5891984)
•   Pro*C/C++ no longer throws ORA-538976288 error when using a "SELECT INTO"
    statement for PIC N variable (17189633)
•   Pro*C/C++ no longer throws PCB-S-00400 error while precompiling a program
    with a Level 88 initialised variable (20194289)
•   Pro*C/C++ no longer fails to parse Solaris platform-specific keyword __thread
    (20901503)
•   Pro*C/C++ demo makefiles from Oracle Instant Client now allows the user to
    specify the GCC path (14591784)
•   Pro*C/C++ no longer truncates strings while fetching data from a long column into
    a long variable (13589112)
•   Pro*C/C++ Nvarchar2 object is now correctly mapped to nvarchar2 data type
    (11653552)
•   Pro*C/C++ now supports OCIRaw processing in the EXEC SQL OBJECT GET
    construct (11653512)
•   Pro*C/C++ is now shipped with generic demo files instead of OSD files, and old
    unused files are no longer shipped (9909411)


                                                                                     3
•   Pro*C/C++ now handles parsing of lengthy numeric values (9814506)
•   Pro*C/C++ now accepts the TYPE token in the IS OF clause (9535800)
•   Pro*C/C++ now correctly interprets a newline character between single quotes in
    SQL statements (9531904)
•   Pro*C/C++ no longer has memory corruption issues when processing SQL
    statements containing N'string' (9531638)
•   Pro*C/C++ now recognizes the CURSOR WITH HOLD option when parser
    unification is enabled (8436316)
•   Pro*C/C++ now passes the correct "mode" parameter value to OCIStmtFetch2()
    (18509872)
•   Pro*C/C++ now frees up the memory allocated to column properties (20051833)
•   Pro*C/C++ no longer fails with ORA-1008 error after encountering ORA-942 error
    when a table is dropped (20029428)
•   Pro*C/C++ no longer throws PCC-S-2201 error while parsing cursor with hold
    syntax in unified parser mode (20534275)
•   Pro*C/C++ no longer throws PLS-S-201 error when compiling with
    common_parser=No (20808657)
•   Len attribute of Varchar structure no longer gets corrupted during batch fetching of
    rows (14013076)
•   Pro*C/C++ no longer throws a segmentation fault when precompiling a long
    filename (12565588)

Bugs Fixed in Pro*C/C++ Release 12.1
•   Pro*C/C++ parser no longer fails when both outline and common_parser are set to
    'yes' (12819524)
•   Pro*C/C++ no longer generates the ANSI prototypes for public APIs when the
    Precompiler option 'code' is set to 'kr_c' (10250555)
•   XA application no longer crashes after upgrade to 11.2 (10086495)
•   Obsolete Sun SPARC compiler option 'dalign' removed from Pro*C/C++ demo
    make file (9590964)
•   EXEC SQL COLLECTION GET from VARRARY(5) of CHAR(5) now behaves
    correctly (9531014)
•   On 64-bit platform SQLSQLDAAlloc() no longer returns aninvalid descriptor handle
    (9491931)
•   Pro*C/C++ no longer crashes on HP-UX after upgrading to 11g (7365514)


Known Bugs
The following section lists known bugs in Pro*C/C++. Numbers in parentheses
following the description refer to bug numbers in the Oracle Bug Database.




                                                                                       4
Known Bugs in Pro*C/C++ Release 12.2
•       ORA-00942 error is thrown while running a query that selects values from an XML
        table in online mode (9535704)
•       PCC-S-2322 error is thrown while executing an embedded SQL statement that
        contains a macro (9970779)
•       PCC-S-02201 error is thrown due to a c99 compliance issue with the stdbool.h file
        (12866048)
•       Implementation of GCC extension #include_next needs to be modified in order to
        correctly include a file in multiple paths (21414819)
•       Certain DDL statements are incorrectly parsed (20857434)
•       PCC-S-02201 error is thrown while parsing the DDL statement "CREATE GLOBAL
        TEMPORARY TABLE" (20857400)
•       PCC-S-02201 error is thrown while parsing the DDL statement "CREATE ROLE"
        (20857370)
•       Oracle Social Network does not support special character "@" in passwords
        (20809065)


Support
For Pro*C/C++ support, please contact your local Oracle Support Services Center.




Pro*C/C++ Release Notes, 19c
E96465-02

Copyright © 1996, 2022, Oracle and/or its affiliates. All rights reserved.

This software and related documentation are provided under a license agreement containing restrictions on use and disclosure and are protected by intellectual property laws.
Except as expressly permitted in your license agreement or allowed by law, you may not use, copy, reproduce, translate, broadcast, modify, license, transmit, distribute, exhibit,
perform, publish, or display any part, in any form, or by any means. Reverse engineering, disassembly, or decompilation of this software, unless required by law for
interoperability, is prohibited.

The information contained herein is subject to change without notice and is not warranted to be error-free. If you find any errors, please report them to us in writing.

If this is software or related documentation that is delivered to the U.S. Government or anyone licensing it on behalf of the U.S. Government, then the following notice is
applicable:

U.S. GOVERNMENT END USERS: Oracle programs (including any operating system, integrated software, any programs embedded, installed or activated on delivered
hardware, and modifications of such programs) and Oracle computer documentation or other Oracle data delivered to or accessed by U.S. Government end users are
"commercial computer software" or "commercial computer software documentation" pursuant to the applicable Federal Acquisition Regulation and agency-specific supplemental
regulations. As such, the use, reproduction, duplication, release, display, disclosure, modification, preparation of derivative works, and/or adaptation of i) Oracle programs
(including any operating system, integrated software, any programs embedded, installed or activated on delivered hardware, and modifications of such programs), ii) Oracle
computer documentation and/or iii) other Oracle data, is subject to the rights and limitations specified in the license contained in the applicable contract. The terms governing the
U.S. Government’s use of Oracle cloud services are defined by the applicable contract for such services. No other rights are granted to the U.S. Government.

This software or hardware is developed for general use in a variety of information management applications. It is not developed or intended for use in any inherently dangerous
applications, including applications that may create a risk of personal injury. If you use this software or hardware in dangerous applications, then you shall be responsible to take
all appropriate fail-safe, backup, redundancy, and other measures to ensure its safe use. Oracle Corporation and its affiliates disclaim any liability for any damages caused by
use of this software or hardware in dangerous applications.

Oracle, Java, and MySQL are registered trademarks of Oracle and/or its affiliates. Other names may be trademarks of their respective owners.

Intel and Intel Inside are trademarks or registered trademarks of Intel Corporation. All SPARC trademarks are used under license and are trademarks or registered trademarks
of SPARC International, Inc. AMD, Epyc, and the AMD logo are trademarks or registered trademarks of Advanced Micro Devices. UNIX is a registered trademark of The Open
Group.

This software or hardware and documentation may provide access to or information about content, products, and services from third parties. Oracle Corporation and its affiliates
are not responsible for and expressly disclaim all warranties of any kind with respect to third-party content, products, and services unless otherwise set forth in an applicable
agreement between you and Oracle. Oracle Corporation and its affiliates will not be responsible for any loss, costs, or damages incurred due to your access to or use of third-
party content, products, or services, except as set forth in an applicable agreement between you and Oracle.




                                                                                                                                                                                  5

