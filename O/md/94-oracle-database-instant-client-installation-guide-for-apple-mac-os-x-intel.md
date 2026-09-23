# 94. Oracle Database Instant Client Installation Guide for Apple Mac OS X (Intel)

> 源文件: `en/mxcli/oracle-database-instant-client-installation-guide-apple-mac-os-x-intel.pdf`

Oracle® Database
Database Instant Client Installation Guide




    19c for Apple Mac OS X (Intel)
    F21305-03
    October 2020
Oracle Database Database Instant Client Installation Guide, 19c for Apple Mac OS X (Intel)

F21305-03

Copyright © 2015, 2020, Oracle and/or its affiliates.

Primary Author: Sunil Surabhi

Contributors: Bharathi Jayathirtha, Prakash Jashnani

Contributors: Neha Avasthy, Dilip Nutakki, Vijay Lakkundi, Mark Bauer, David Austin, Rohitash Panda,
Subhranshu Banerjee, Janelle Simmons, Robert Chang, Jonathan Creighton, Sudip Datta, Thirumaleshwara
Hasandka, Joel Kallman, George Kotsovolos, Simon Law, Shekhar Vaggu, Richard Long, Rolly Lv,
Padmanabhan Manavazhi, Sreejith Minnanghat, Krishna Mohan, Rajendra Pingte, Hanlin Qian, Roy
Swonger, Ranjith Kundapur, Aneesh Khandelwal , Barb Lundhild, Barbara Glover, Binoy Sukumaran,
Prasad Bagal, Martin Widjaja, Ajesh Viswambharan, Eric Belden, Sivakumar Yarlagadda, Rudregowda
Mallegowda , Matthew McKerley, Trivikrama Samudrala, Akshay Shah, Sue Lee, Sangeeth Kumar, James
Spiller, Saar Maoz, Rich Long, Mark Fuller, Sunil Ravindrachar, Sergiusz Wolicki, Eugene Karichkin, Joseph
Francis, Srinivas Poovala, David Schreiner, Neha Avasthy, Dipak Saggi, Sudheendra Sampath, Mohammed
Shahnawaz Quadri, Shachi Sanklecha, Zakia Zerhouni, Jai Krishnani, Darcy Christensen., Kevin Flood, Clara
Jaeckel, Emily Murphy, Terri Winters

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
    Audience                                                                   v
    Documentation Accessibility                                                v
    Related Documentation                                                      v
    Command Syntax                                                             vi
    Typographic Conventions                                                    vi



1   Overview of Oracle Database Instant Client Installation
    Planning Your Installation                                                1-1
    Installation Considerations                                               1-1
    Oracle Database Instant Client Installation Types                         1-2
    Oracle Database Instant Client and Oracle Database Interoperability       1-3
    Simplified Patching of Timestamp with Time Zone Data Type                 1-3



2   Oracle Database Instant Client Preinstallation Tasks
    Checking the Hardware Requirements                                        2-1
        Memory Requirements                                                   2-1
        System Architecture                                                   2-1
        Disk Space Requirements                                               2-2
    Checking the Software Requirements                                        2-2
        Instant Client Light Requirements                                     2-3



3   Installing and Removing Oracle Database Instant Client
    Installing Non-Notarized Oracle Instant Client Software Using Zip Files   3-1
    Installing Notarized Oracle Instant Client Software Using DMG Files       3-1
    Removing the Oracle Database Instant Client Software                      3-2



4   Oracle Database Instant Client Postinstallation Tasks
    Using Oracle Database Instant Client                                      4-1




                                                                               iii
Required Product-Specific Postinstallation Tasks                              4-2
    Configuring Oracle Precompilers                                           4-2
        Configuring Pro*C/C++                                                 4-2
Recommended Postinstallation Tasks                                            4-2
    Connecting Instant Client or Instant Client Light to an Oracle Database   4-2
        Specifying a Connection by Using the Easy Connect Naming Method       4-3
        Specifying a Connection Using an Empty Connect String and TWO_TASK    4-4
    Setting the NLS_LANG Environment Variable                                 4-4
    Updating Instant Client                                                   4-4




                                                                               iv
Preface
           This guide provides instructions about installing and configuring Oracle Database
           Client for Apple Mac OS X (Intel) (64-bit).
           •   Audience
           •   Documentation Accessibility
           •   Related Documentation
           •   Command Syntax
           •   Typographic Conventions


Audience
           This guide is intended for anyone responsible for installing Oracle Database Client
           for Apple Mac OS X (Intel) (64-bit). Additional platform-specific installation guides
           for Oracle Database, Oracle Real Application Clusters, Oracle Clusterware, Oracle
           Database Examples, and Oracle Enterprise Manager Grid Control are available on the
           relevant installation media.


Documentation Accessibility
           For information about Oracle's commitment to accessibility, visit the
           Oracle Accessibility Program website at http://www.oracle.com/pls/topic/lookup?
           ctx=acc&id=docacc.

           Access to Oracle Support
           Oracle customers that have purchased support have access to electronic support
           through My Oracle Support. For information, visit http://www.oracle.com/pls/topic/
           lookup?ctx=acc&id=info or visit http://www.oracle.com/pls/topic/lookup?ctx=acc&id=trs
           if you are hearing impaired.


Related Documentation
           The related documentation for Oracle Database 19c products includes the following
           manuals:
           •   Oracle Database Installation Guide
           •   Oracle Grid Infrastructure Installation Guide
           •   Oracle Real Application Clusters Installation Guide for Linux and UNIX
           •   Oracle Database Error Messages
           •   Oracle Database Sample Schemas



                                                                                               v
                                                                                                    Preface




Command Syntax
         UNIX command syntax appears in monospace font. The dollar character ($), number
         sign (#), or percent character (%) are UNIX command prompts. Do not enter them
         as part of the command. The following command syntax conventions are used in this
         guide:


         Convention        Description
         backslash \       A backslash is the UNIX command continuation character. It is used in
                           command examples that are too long to fit on a single line. Enter the
                           command as displayed (with a backslash) or enter it on a single line without
                           a backslash:
                           dd if=/dev/rdsk/c0t1d0s6 of=/dev/rst0 bs=10b \
                           count=10000

         braces { }        Braces indicate required items:
                           .DEFINE {macro1}

         brackets [ ]      Brackets indicate optional items:
                           cvtcrt termname [outfile]

         ellipses ...      Ellipses indicate an arbitrary number of similar items:
                           CHKVAL fieldname value1 value2 ... valueN

         italics           Italic type indicates a variable. Substitute a value for the variable:
                           library_name

         vertical line |   A vertical line indicates a choice within braces or brackets:
                           FILE filesize [K|M]



Typographic Conventions
         The following text conventions are used in this document:


         Convention            Meaning
         boldface              Boldface type indicates graphical user interface elements associated
                               with an action, or terms defined in text or the glossary.
         italic                Italic type indicates book titles, emphasis, or placeholder variables for
                               which you supply particular values.
         monospace             Monospace type indicates commands within a paragraph, URLs, code
                               in examples, text that appears on the screen, or text that you enter.




                                                                                                           vi
1
Overview of Oracle Database Instant Client
Installation
          This chapter describes the different installation types of Oracle Database Instant Client
          and issues to consider before you install Oracle Database Instant Client.
          •    Planning Your Installation
          •    Installation Considerations
          •    Oracle Database Instant Client Installation Types
          •    Oracle Database Instant Client and Oracle Database Interoperability
          •    Simplified Patching of Timestamp with Time Zone Data Type


Planning Your Installation
          The Oracle Database installation process consists of the following phases:
          1.   Review the licensing information: Although the installation media in your media
               pack contain many Oracle components, you are permitted to use only those
               components for which you have purchased licenses.
               Oracle Support Services does not provide support for components for which
               licenses have not been purchased.



                      See Also:
                      Oracle Database Licensing Information


          2.   Plan the installation: This chapter describes the Oracle products that you can
               install and issues that you must consider before starting the installation.
          3.   Complete preinstallation tasks: Oracle Database Instant Client Preinstallation
               Tasks describes preinstallation tasks that you must complete before installing the
               product.
          4.   Install the software: Installing and Removing Oracle Database Instant Client
               describes how to install Oracle Database Instant Client.
          5.   Complete postinstallation tasks: Oracle Database Instant Client Postinstallation
               Tasks describes recommended and required postinstallation tasks.


Installation Considerations
          This section contains hardware and software certification information that you should
          consider before deciding to install this product.




                                                                                                1-1
                                                                                                   Chapter 1
                                                           Oracle Database Instant Client Installation Types


          The platform-specific hardware and software requirements included in this guide
          were current when this guide was published. However, because new platforms and
          operating system software versions might be certified after this guide is published,
          review the certification matrix on the My Oracle Support website for the most up-to-
          date list of certified hardware platforms and operating system versions. The My Oracle
          Support website is available at
          https://support.oracle.com/

          You must register online before using My Oracle Support. After logging in, from the
          menu options, select the Certifications tab. On the Certifications page, use the
          Certification Search options to search by Product, Release, and Platform. You can
          also search using the Certification Quick Links options such as Product Delivery and
          Lifetime Support.


Oracle Database Instant Client Installation Types
          In Oracle Database Instant Client 19c, Instant Client and Instant Client Light are the
          only supported installation types.
          The Instant Client installation type enables you to install only the shared libraries
          required by Oracle Call Interface (OCI), Oracle C++ Call Interface (OCCI), Pro*C, or
          Java Database Connectivity (JDBC) OCI applications.



                  See Also:
                  Oracle Call Interface Programmer's Guide


          The Instant Client Light (English) version of Instant Client further reduces the disk
          space requirements of the client installation. The size of the library has been reduced
          by removing error message files for languages other than English and leaving only a
          few supported character set definitions out of around 250.
          This Instant Client Light version is geared toward applications that use either
          US7ASCII, WE8DEC, WE8ISO8859P1, WE8MSWIN1252, or a Unicode character set.
          There is no restriction on the LANGUAGE and the TERRITORY fields of the NLS_LANG
          setting, so the Instant Client Light operates with any language and territory settings.
          Because only English error messages are provided with the Instant Client Light, error
          messages generated on the client side, such as Net connection errors, are always
          reported in English, even if NLS_LANG is set to a language other than AMERICAN. Error
          messages generated by the database side, such as syntax errors in SQL statements,
          are in the selected language provided the appropriate translated message files are
          installed in the Oracle home of the database instance.
          Instant Client Light supports the following client character sets:
          •   Single-byte
              –   US7ASCII
              –   WE8DEC
              –   WE8MSWIN1252
              –   WE8MSWIN1252
              –   WE8ISO8859P1



                                                                                                       1-2
                                                                                                  Chapter 1
                                        Oracle Database Instant Client and Oracle Database Interoperability


         •   Unicode
             –   UTF8
             –   AL16UTF16
             –   AL32UTF8
         •   Instant Client Light can connect to databases having one of these database
             character sets:
             –   US7ASCII
             –   WE8DEC
             –   WE8MSWIN1252
             –   WE8ISO8859P1
             –   WE8EBCDIC37C
             –   WE8EBCDIC1047
             –   UTF8
             –   AL32UTF8
             The advantage of using Instant Client Light is that it has a smaller footprint than
             the regular Instant Client. The shared libraries, which an application must load, are
             only 34 MB as opposed to the 110 MB that regular Instant Client uses. Therefore,
             the applications use less memory.


Oracle Database Instant Client and Oracle Database
Interoperability
         For information about interoperability between Oracle Database Instant Client and
         Oracle Database releases, see Note 207303.1 on the My Oracle Support website at
         https://support.oracle.com/CSP/main/article?cmd=show&type=NOT&id=207303.1


Simplified Patching of Timestamp with Time Zone Data Type
         Starting with Oracle Database 12c Release 1 (12.1), the patching process of
         TIMESTAMP WITH TIMEZONE data type values is simplified.




                 See Also:
                 Oracle Database Globalization Support Guide




                                                                                                      1-3
2
Oracle Database Instant Client
Preinstallation Tasks
           This chapter describes the tasks that you must complete before you install Oracle
           Instant Client.
           •   Checking the Hardware Requirements
           •   Checking the Software Requirements


Checking the Hardware Requirements
           The system must meet the following minimum hardware requirements for Oracle
           Database Instant Client 19c:
           •   Memory Requirements
           •   System Architecture
           •   Disk Space Requirements


Memory Requirements
           The following are the memory requirements for Oracle Database Instant Client 19c:
           •   At least 512 MB of RAM.
               To determine the physical RAM size, use System Profiler (/Applications/
               Utilities/System Profiler) or enter the following command:
               $ /usr/sbin/system_profiler SPHardwareDataType | grep Memory
               If the size of the physical RAM is less than the required size, then you must install
               more memory before continuing.
           The following are the RAM requirements:
           •   Up to 512 MB
           •   Between 513 MB and 726 MB
           •   More than 726 MB
           To determine the available RAM, enter the following command:
           $ free

           https://support.apple.com/en-in/guide/activity-monitor/actmntr1004/mac


System Architecture
           To determine whether the system architecture can run the software, enter the following
           command:




                                                                                                 2-1
                                                                                                 Chapter 2
                                                                       Checking the Software Requirements


          $ uname -p

          This command displays the processor type. The command output must be i386. If you
          do not see the expected output, then you cannot install the software on this system.


Disk Space Requirements
          The minimum disk space requirement for software files for Oracle Database Instant
          Client 19c is 220 MB.
          To determine the amount of free disk space available, enter the following command:
          $ df -h


Checking the Software Requirements
          Depending on the products that you intend to install, verify that the following software
          is installed on the system.


          Item                     Requirement
          Operating system         The following or later versions of the operating system are supported
                                   for Oracle Database 19c:
                                   •   Apple Mac OS X 10.13.5 (High Sierra)
                                   •   Apple Mac OS X 10.14 (Mojave)
                                   •   Apple Mac OS X 10.15 (Catalina)
          Tools                    •   Xcode 9.4
                                   •   GNU C compiler (gcc) version 4.2.1 or later
                                       This version of gcc is included in Xcode 9.4 or later.
                                   •   Apple LLVM version 9.1.0
                                   •   JDK 1.8.0_172.jdk
          Pro*C/C++, Oracle Call   The version of the GNU C and C++ compiler listed previously is
          Interface, Oracle C++    supported for use with these products.
          Call Interface
          Oracle JDBC/OCI          You must use JDBC-OCI 1.8.0 or later versions with the JNDI
          Drivers                  extension.
          Oracle ODBC Driver       Download and install unixODBC-2.3.4 or later at http://
                                   www.unixodbc.org

          To ensure that the system meets these requirements:
          1.   To determine the operating system version, enter the following command:
               $ sw_vers

               The output of this command must be similar to the following:
               ProductName:    Mac OS X
               ProductVersion: 10.13.5
               BuildVersion:   17F77




                                                                                                     2-2
                                                                                                 Chapter 2
                                                                       Checking the Software Requirements




                       Note:
                       Only the versions listed in the previous table are supported. Do not
                       install the software on other versions of Apple Mac OS X.


           2.   To determine if the required version of gcc is installed, enter the following
                command:
                $ gcc -v

                This command returns output similar to the following:

                Configured with: --prefix=/Applications/Xcode.app/Contents/
                Developer/usr --with-gxx-include-dir=/usr/include/c++/4.2.1
                Apple LLVM version 9.1.0 (clang-902.0.39.2)
                Target: x86_64-apple-darwin17.6.0
                Thread model: posix
                InstalledDir: /Applications/Xcode.app/Contents/Developer/Toolchains/
                XcodeDefault.xctoolchain/usr/bin


                If the required version (including the date and build number) or a later version is
                not installed, then download and install Xcode 9.4 or later. You can download this
                software from the Apple Developer Connection website at
                https://developer.apple.com/
           3.   To determine if the correct version of Xcode is installed, enter the following
                command:
                $ /usr/bin/xcodebuild -version

                This commands returns output similar to the following:
                Xcode 9.4
                Build version 9F1027a

                If the required version (including the date and build number) or a later version is
                not installed, then download and install Xcode 5.0.2 or later. You can download
                this software from the Apple Developer Connection website at
                https://developer.apple.com/

           •    Instant Client Light Requirements


Instant Client Light Requirements
           In addition to the requirements described in the preceding section, if you plan to
           use Instant Client Light, then the applications must use the following languages and
           character sets:
           •    Language: Any language that is supported by Oracle
           •    Territory: Any territory that is supported by Oracle
           •    Character sets:
                –   Single byte




                                                                                                     2-3
                                                                                 Chapter 2
                                                        Checking the Software Requirements


        *   US7ASCII
        *   WE8DEC
        *   WE8MSWIN1252
        *   WE8ISO8859P1
    –   Unicode
        *   UTF8
        *   AL16UTF16
        *   AL32UTF8
        Instant Client Light can connect to databases having one of the following
        database character sets:
        *   US7ASCII
        *   WE8DEC
        *   WE8MSWIN1252
        *   WE8ISO8859P1
        *   WE8EBCDIC37C
        *   WE8EBCDIC1047
        *   UTF8
        *   AL32UTF8
Instant Client Light can also operate with the OCI Environment handles created in the
OCI_UTF16 mode.
The language, territory, and character sets are determined by the NLS_LANG
environment variable.



        Note:
        Ensure that you set the NLS_LANG environment variable to the required
        character set before you run Oracle Database Instant Client.




                                                                                      2-4
3
Installing and Removing Oracle Database
Instant Client
          The Oracle Database Instant Client software is available on the Oracle Instant Client
          downloads page.
          •    Installing Non-Notarized Oracle Instant Client Software Using Zip Files
          •    Installing Notarized Oracle Instant Client Software Using DMG Files
          •    Removing the Oracle Database Instant Client Software


Installing Non-Notarized Oracle Instant Client Software
Using Zip Files
          Download and install non-notarized Oracle Database Instant Client 19c zip files by
          completing the following steps:
          1.   Download the Oracle Instant Client for Mac OS X (Intel) (64-bit) package from the
               Oracle Instant Client Downloads page:
               https://www.oracle.com/database/technologies/instant-client/
               downloads.html
          2.   Create a directory on your computer, for example, instantclient. Choose a
               directory to install the Oracle Instant Client and unzip the downloaded zip file in
               that directory. The unzipped file creates the instantclient_19_8 directory.
          3.   Set the NLS_LANG environment variable to the required character set. For example,
               an NLS_LANG of american_america.utf8 is a valid setting. It is in the following
               format: [NLS_LANGUAGE]_[NLS_TERRITORY].[NLS_CHARACTERSET].
               This completes the installation of Oracle Database Instant Client.



                      Note:
                      Non-notarized zip files will be discontinued in future releases.

          Related Topics
          •    Instant Client Light Requirements


Installing Notarized Oracle Instant Client Software Using
DMG Files
          1.   Download the Oracle Instant Client for Mac OS X (Intel) (64-bit) disk image (DMG)
               files from the Oracle Instant Client Downloads page:




                                                                                                     3-1
                                                                                              Chapter 3
                                                   Removing the Oracle Database Instant Client Software


              https://www.oracle.com/database/technologies/instant-client/
              downloads.html
         2.   Mount all the DMG packages.

              •    /usr/bin/hdiutil mount dmg_file_name
         3.   Run the following steps to copy the volume contents to /Users/user-name/
              Downloads/instantclient_19_8.

              a.   cd /Volumes/instantclient-*-macos.x64-19.8.0.0.0dbru
              b.   sh ./install_ic.sh
              c.   In Mac Finder, eject the mounted Oracle Instant Client packages.


Removing the Oracle Database Instant Client Software
         To remove the Oracle Database Instant Client software, delete the
         instantclient_19_8 directory.




                                                                                                  3-2
4
Oracle Database Instant Client
Postinstallation Tasks
         Complete these postinstallation tasks after you have installed the Oracle Database
         Instant Client software.
         •    Using Oracle Database Instant Client
         •    Required Product-Specific Postinstallation Tasks
         •    Recommended Postinstallation Tasks


Using Oracle Database Instant Client
         You can build a C/C++ application that uses Oracle Database Instant Client and
         connect to an Oracle Database server. If you want to build a 64-bit application and use
         instantclient_19_8/sdk/demo.mk file, then perform the following steps:
         1.   Edit the instantclient_19_8/sdk/demo.mk file and set the CC and cc to your gcc
              location.
         2.   Compile the C/C++ application using the flags specified in the demo.mk file,
              namely, -idirafter . -DMAC_OSX -D_GNU_SOURCE -D_REENTRANT -g -m64 -
              mmacosx-version-min=10.13 <c_file_name> -I../include.
         3.   Start make -f demo.mk buildoci EXE=cdemo81 OBJS=cdemo81.o for a working
              demonstration of the options.
         4.   Add the Java Library Path in the ott script, if you notice the following issue:
              Exception in thread "main" java.lang.UnsatisfiedLinkError: no
              ocijdbc18 in java.library.path
              -Djava.library.path=location_of_libocijdbc18
              For example, if libocijdbc18.dylib is in the /home/oracle/OTN/
              instantclient_19_8/ path, then you must add the following line in the ott script:
              JAVA_PATH=-Djava.library.path=/home/oracle/OTN/instantclient_19_8/
              and run the following command:
              exec java $JAVA_PATH $JREOPTIONS oracle.ott.c.CMain nlslang=$
              {NLS_LANG} $args
         5.   Modify ICLIBHOME in demo.mk to include the path to the libraries.
              For example, if the libraries are located in /home/oracle/OTN/
              instantclient_19_8/, then place it in the demo.mk file:
              ICLIBHOME=/home/oracle/OTN/instantclient_19_8/
         The compilation options are as follows:
         -idirafter . -DMAC_OSX -D_GNU_SOURCE -D_REENTRANT -g -m64 -mmacosx-
         version-min=10.13 <c_file_name> -I../include
         The link options are as follows:



                                                                                                4-1
                                                                                                   Chapter 4
                                                            Required Product-Specific Postinstallation Tasks


            -g -m64 -mmacosx-version-min=10.13 -rpath
            full_path_to_instantclient_19_8_libs application_name -L../../ -locci -
            lclntsh -lpthread


Required Product-Specific Postinstallation Tasks
            The following sections describe postinstallation tasks that you must perform if you
            install and intend to use Oracle Precompliers:



                   Note:
                   You must perform postinstallation tasks only for products that you intend to
                   use.



            •   Configuring Oracle Precompilers


Configuring Oracle Precompilers
            This section describes postinstallation tasks for Pro*C/C++.
            •   Configuring Pro*C/C++

Configuring Pro*C/C++
            Verify that the PATH environment variable setting includes the directory that contains
            the C compiler executable. The default directory for the gcc compiler executable
            is /usr/bin.




                   See Also:
                   Pro*C/C++ Programmer's Guide



Recommended Postinstallation Tasks
            Oracle recommends that you perform the tasks described in the following sections
            after completing an installation:
            •   Connecting Instant Client or Instant Client Light to an Oracle Database
            •   Setting the NLS_LANG Environment Variable
            •   Updating Instant Client


Connecting Instant Client or Instant Client Light to an Oracle Database
            Use one of the following methods to specify the database connection information for
            the instant client application:
            •   For OCI and OCCI programs, use the following connection string format:



                                                                                                       4-2
                                                                                               Chapter 4
                                                                      Recommended Postinstallation Tasks


                host[:port][/service_name][:server][/instance_name]
            •   Set the TNS_ADMIN environment variable to specify the location of the
                tnsnames.ora file and specify a service name from that file.
            •   Set the TNS_ADMIN and the TWO_TASK environment variables to specify a service
                name from the tnsnames.ora file.



                       Note:
                       You do not need to specify the ORACLE_HOME variable.

            After checking the environment variable, you can use any of the following methods to
            specify Oracle Database connection information for client applications:
            •   Specifying a Connection by Using the Easy Connect Naming Method
            •   Specifying a Connection Using an Empty Connect String and TWO_TASK

Specifying a Connection by Using the Easy Connect Naming Method
            You can specify a connection address to an Oracle Database directly from a client
            application, without having to configure a tnsnames setting for the Instant Client. This
            method is convenient as you do not have to create and manage a tnsnames.ora file.
            However, the application users must specify the host name and port number when
            they want to log in to the application.
            For example, if you run SQL*Plus on the client computer and want to connect to the
            sales_us database, which is located on a server whose host name is shobeen and port
            number is 1521, then you can log in as follows:
            sqlplus system/admin@shobeen:1521/sales_us

            Similarly, in the application code, you can use Oracle Call Interface net naming
            methods to create the Instant Client-to-Oracle Database connection. For example, the
            following formats in the OCIServerAttach() call specify the connection information:

            •   Specify a SQL connect URL string using one of the following format:
                [ ( username, [ "/", password ] | "/" ), [ "@", db_address ] ],
                [ admin_role ], [ initial_edition ]

                or
                username/password@inst1
            •   Alternatively, you can specify the SQL connect information as an Oracle Net
                keyword-value pair. For example:
                "(DESCRIPTION=(ADDRESS=(PROTOCOL=tcp) (HOST=shobeen) (PORT=1521))
                (CONNECT_DATA=(SERVICE_NAME=sales_us)))"



                       See Also:
                       Oracle Call Interface Programmer's Guide




                                                                                                    4-3
                                                                                                 Chapter 4
                                                                        Recommended Postinstallation Tasks




Specifying a Connection Using an Empty Connect String and TWO_TASK
            You can set the connect string to an empty connect string (""), and then set the
            TWO_TASK environment variable to one of the following values:

            •    A direct address, as described under "Specifying a Connection by Using the Easy
                 Connect Naming Method"
            •    Oracle Net keyword-value pair
            •    A tnsnames.ora entry and TNS_ADMIN is set to the location of tnsnames.ora
            This method allows the applications to specify internally a connection string if the
            application code itself uses an empty connection string. The benefit of an empty
            connect string is that the application itself does not have to specify the tnsnames.ora
            entry. Instead, when a user starts the application, the location of the database is
            determined by a script or the environment, depending on where you have set the
            TWO_TASK environment variable. The disadvantage of using empty strings is that you
            must configure this additional information in order for the application to connect to the
            database.


Setting the NLS_LANG Environment Variable
            NLS_LANG is an environment variable that specifies the locale behavior for Oracle
            software. This variable sets the language and territory used by the client application
            and the database user session. It also declares the character set of the client, which
            is the character set of data entered or displayed by an Oracle client program, such as
            SQL*Plus.



                    Note:
                    The character set of the data displayed is determined by the environment
                    of the operating system, such as keyboard driver and fonts in use. The
                    NLS_LANG character set should match the operating system.



            Refer to the "Setting Up a Globalization Support Environment" section in Oracle
            Database Globalization Support Guide for information about Globalization Support.


Updating Instant Client
            To update Instant Client:
            1.   Download Instant Client from Oracle Technology Network at https://
                 www.oracle.com/database/technologies/instant-client/downloads.html
            2.   If you want to place the files in the existing directory, then ensure that the directory
                 is empty. If you want to place the files into a different directory (and remove the
                 previous files), ensure that you update the environment variable setting to reflect
                 the new location.




                                                                                                      4-4
                                                                       Chapter 4
                                              Recommended Postinstallation Tasks




Note:
A restriction on Instant Client or Instant Client Light is that you cannot
perform patch upgrades using the opatch utility because the Instant
Client installation does not create an inventory, which the patch upgrade
process must access for patch upgrades.




                                                                             4-5

