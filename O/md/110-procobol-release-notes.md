# 110. Pro*COBOL Release Notes

> 源文件: `en/pcbrn/cobol-release-notes.pdf`

Pro*COBOL®
Release Notes
19c
E96464-02
June 2021




                Release Notes

                About these Release Notes
                This document contains important information about Pro*COBOL release 19c.
                It contains the following topics:
                •   Documentation Accessibility
                •   New Features in Pro*COBOL Release 19c
                •   New Features in Previous Releases
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


                New Features in Pro*COBOL Release 19c
                Micro Focus Visual COBOL v6.0 compiler supports the following platforms:
                •   Linux x86 (32-bit and 64-bit) on OL8 & SLES15




                                                                                                    1
•   Windows x86 (32-bit and 64-bit)
•   HPUX on Itanium (32-bit and 64-bit)
•   Solaris SPARC (32-bit and 64-bit)
•   IBM AIX (32-bit and 64-bit)
•   Linux for IBM System z (31-bit and 64-bit)


New Features in Previous Releases
This section lists new features introduced to Pro*COBOL in previous releases.

Features in Pro*COBOL Release 18c, Version 18.1

The following feature is new in this release:
•   Support for Oracle Connection Manager in Traffic Director Mode
    Oracle Connection Manager in Traffic Director Mode is a proxy that is placed
    between supported database clients and database instances for improved high
    availability, connection multiplexing, and load balancing.

Features in Pro*COBOL 12.2 Production
•   Support for long identifiers (object lengths of 128 bytes). In previous releases, the
    object length limit was 30 bytes.
•   Support for Oracle Instant Client - Basic Light version.
•   New command line option, trim_password, to prevent authentication issues
    caused by password strings that contain trailing blank space.
•   Support for Micro Focus Visual COBOL 2.2 Update 2 compiler for the following
    platforms:
    –   Linux x64
    –   Windows 64-bit and 32-bit
    –   Solaris x86 (32-bit and 64-bit)
    –   Solaris SPARC (32-bit and 64-bit)

Features in Pro*COBOL 12.1 Production
•   Support for Auto Increment Columns
•   Support for 32k Columns
•   Support for Prefetch By Memory
•   Support for SQL Plan Management (SPM)


Bugs Fixed

                                                                                            2
The following section lists bugs fixed in Pro*COBOL. Numbers in parentheses
following the description refer to bug numbers in the Oracle Bug Database.

Bugs Fixed in Pro*COBOL Release 12.2 Production
•   Pro*COBOL no longer throws CSF-S-00000 error when common_parser=yes in
    the timezone.pc file (9531787)
•   Pro*COBOL no longer throws ORA-01008 error when binds are used in the Select
    list while common_parser=yes (14127422)
•   Pro*COBOL no longer throws ORA-932 error when precompiling with option
    USERID and common_parser=yes for an INSERT statement which has CASE
    clause and TIMESTAMP function (14335958, 19473788)
•   Pro*COBOL no longer throws PCB-S-00576, PLS-103 error while precompiling
    with embedded PL/SQL using the select /*+ index hint */ statement (953338)
•   Pro*COBOL no longer fails to set SQLSTATE during rollback, with MODE=ANSI
    and without declaring SQLCODE (5891984)
•   Pro*COBOL no longer fails to generate a proper log file (17280039)
•   Pro*COBOL no longer throws PCB-S-00400 error while precompiling a program
    with a Level 88 initialised variable (20194289)
•   Pro*COBOL no longer gets SIGSEGV for duplicate host variables when
    precompiling with common_parser=yes (19473788)
•   Pro*COBOL no longer throws PCB-S-00576 error while precompiling a program
    with common_parser=yes (18800170)
•   Pro*COBOL now checks for a fatal error during precompilation before deleting log
    and sql files (17871321)
•   Pro*COBOL no longer throws ORA-538976288 error when using a "SELECT
    INTO" statement for PIC N variable (17189633)
•   Pro*COBOL no longer creates a .sql file containing "plan_run=yes" when
    precompilation fails (16240153)
•   Pro*COBOL no longer creates over 72 columns when a variable is modified by
    varying with comp5=yes (14708769)
•   SQLGLS calls in Pro*COBOL now work as expected (14640230)
•   Pro*COBOL no longer returns PCB-S-00400 error during precompilation when a
    variable identifier follows a COPY statement (14113014)
•   Pro*COBOL no longer returns PCB-S-00400 error when a COPY modifier is used
    (13478294)
•   Pro*COBOL no longer generates a UNIX Return Code of 0 when precompilation
    fails (10083052)
•   Pro*COBOL no longer generates .cob files after errors are encountered (9303962)

Bugs Fixed in Pro*COBOL Release 12.1


                                                                                   3
•     Pro*COBOL no longer crashes while parsing long token/ SQL statement
      (13006848)
•     Pro*COBOL no longer returns PCB-S-400 when precompiling SQL that includes
      an inline view written as embedded SQL (EXEC SQL), in-spite of using
      common_parser=yes (12641413)
•     Pro*COBOL no longer throws PCB-0400 error when using numeric as first
      character of a group element (10265545)
•     Pro*COBOL on Windows no longer crashes when option comp1=integer is set
      (10040552)
•     Pro*COBOL no longer returns ORA-6502 with PL/SQL bind (9905110)
•     Pro*COBOL no longer crashes when a large source file contains a large number
      of host variables (9689604)
•     Pro*COBOL now parses statements with a double dot after a COBOL COPY
      clause after installing patch 9218271 (9470397)
•     Pro*COBOL no longer generates illegal values when a statement is declared at a
      remote DB and then prepared by passing a string instead of bind-var) (9402996)
•     Pro*COBOL non longer fails with ORA-12899 when max_rows_insert is set
      (9381997)
•     Pro*COBOL non longer returns PCB-S-00214 when JUSTFIED clause is used
      with host variables (9266470)
•     Pro*COBOL no longer returns PCB-S-400 error if SCREEN SECTION is used
      (9151190)
•     Pro*COBOL no longer returns PCB-W-233 when host variable was used for AT
      clause (9147830)
•     Pro*COBOL no longer returns PCB-S-400 when COPY is used in OCCURS
      clause of an array declaration (9128157)
•     Pro*COBOL no longer returns PCB-S-400 when a COPY statement ends with
      double dots (9055457)
•     Pro*COBOL now correctly translates SQL statements which contain a list of lists
      (8932394)
•     Pro*COBOL no longer returns ORA-933 when cursors are declared with outline
      enabled (8770900)
•     Pro*COBOL no longer returns PCB-S-00400 when an EXE SQL INCLUDE
      statement is used without an ending period in DATA SECTION (8713408)


Support
For Pro*COBOL support, contact your local Oracle Support Services Center.




Pro*COBOL Release Notes, 19c
E96464-02




                                                                                        4
Copyright © 1996, 2021, Oracle and/or its affiliates. All rights reserved.

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

