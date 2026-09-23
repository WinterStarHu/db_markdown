# 21. Database Client Installation Guide for IBM Linux on POWER Little Endian Systems

> 源文件: `en/lplig/database-client-installation-guide-ibm-linux-power-little-endian-systems.pdf`

Oracle® Database
Database Client Installation Guide




    19c for IBM: Linux on POWER Little Endian Systems
    F21092-01
    July 2019
Oracle Database Database Client Installation Guide, 19c for IBM: Linux on POWER Little Endian Systems

F21092-01

Copyright © 2015, 2019, Oracle and/or its affiliates. All rights reserved.

Primary Author: Sunil Surabhi

Contributing Authors: Bharathi Jayathirtha

Contributors: Mark Bauer, Janelle Simmons, David Austin, Rohitash Panda, Subhranshu Banerjee, Robert
Chang, Jonathan Creighton, Sudip Datta, Thirumaleshwara Hasandka, Joel Kallman, George Kotsovolos, Si‐
mon Law, Shekhar Vaggu, Richard Long, Rolly Lv, Padmanabhan Manavazhi, Sreejith Minnanghat, Krishna
Mohan, Rajendra Pingte, Hanlin Qian, Roy Swonger, Namrata Bhakthavatsalam, Ranjith Kundapur, Aneesh
Khandelwal , Barb Lundhild, Barbara Glover, Binoy Sukumaran, Prasad Bagal, Martin Widjaja, Ajesh Vis‐
wambharan, Eric Belden, Sivakumar Yarlagadda, Rudregowda Mallegowda , Matthew McKerley, Trivikrama
Samudrala, Akshay Shah, Sue Lee, Sangeeth Kumar, James Spiller, Saar Maoz, Rich Long, Mark Fuller, Su‐
nil Ravindrachar, Sergiusz Wolicki, Eugene Karichkin, Joseph Francis, Srinivas Poovala, David Schreiner,
Neha Avasthy, Dipak Saggi, Sudheendra Sampath, Mohammed Shahnawaz Quadri, Shachi Sanklecha, Za‐
kia Zerhouni, Jai Krishnani, Darcy Christensen, Kevin Flood, Clara Jaeckel, Emily Murphy, Terri Winters

This software and related documentation are provided under a license agreement containing restrictions on
use and disclosure and are protected by intellectual property laws. Except as expressly permitted in your li‐
cense agreement or allowed by law, you may not use, copy, reproduce, translate, broadcast, modify, license,
transmit, distribute, exhibit, perform, publish, or display any part, in any form, or by any means. Reverse engi‐
neering, disassembly, or decompilation of this software, unless required by law for interoperability, is prohibit‐
ed.

The information contained herein is subject to change without notice and is not warranted to be error-free. If
you find any errors, please report them to us in writing.

If this is software or related documentation that is delivered to the U.S. Government or anyone licensing it on
behalf of the U.S. Government, then the following notice is applicable:

U.S. GOVERNMENT END USERS: Oracle programs, including any operating system, integrated software,
any programs installed on the hardware, and/or documentation, delivered to U.S. Government end users are
"commercial computer software" pursuant to the applicable Federal Acquisition Regulation and agency-spe‐
cific supplemental regulations. As such, use, duplication, disclosure, modification, and adaptation of the pro‐
grams, including any operating system, integrated software, any programs installed on the hardware, and/or
documentation, shall be subject to license terms and license restrictions applicable to the programs. No other
rights are granted to the U.S. Government.

This software or hardware is developed for general use in a variety of information management applications.
It is not developed or intended for use in any inherently dangerous applications, including applications that
may create a risk of personal injury. If you use this software or hardware in dangerous applications, then you
shall be responsible to take all appropriate fail-safe, backup, redundancy, and other measures to ensure its
safe use. Oracle Corporation and its affiliates disclaim any liability for any damages caused by use of this
software or hardware in dangerous applications.

Oracle and Java are registered trademarks of Oracle and/or its affiliates. Other names may be trademarks of
their respective owners.

Intel and Intel Xeon are trademarks or registered trademarks of Intel Corporation. All SPARC trademarks are
used under license and are trademarks or registered trademarks of SPARC International, Inc. AMD, Opteron,
the AMD logo, and the AMD Opteron logo are trademarks or registered trademarks of Advanced Micro Devi‐
ces. UNIX is a registered trademark of The Open Group.

This software or hardware and documentation may provide access to or information about content, products,
and services from third parties. Oracle Corporation and its affiliates are not responsible for and expressly dis‐
claim all warranties of any kind with respect to third-party content, products, and services unless otherwise
set forth in an applicable agreement between you and Oracle. Oracle Corporation and its affiliates will not be
responsible for any loss, costs, or damages incurred due to your access to or use of third-party content, prod‐
ucts, or services, except as set forth in an applicable agreement between you and Oracle.
Contents
    Preface
    Audience                                                           v
    Documentation Accessibility                                        v
    Set Up Java Access Bridge to Implement Java Accessibility          v
    Command Syntax                                                    vi
    Related Documentation                                             vi
    Typographic Conventions                                           vii



1   Overview of Oracle Database Client Installation
    Planning Your Installation                                       1-1
    Installation Considerations                                      1-1
    Oracle Database Client Installation Types                        1-2
    Oracle Database Client and Oracle Database Interoperability      1-3
    Simplified Patching of Timestamp with Time Zone Data Type        1-3



2   Oracle Database Client Preinstallation Tasks
    Logging In to the System as root                                 2-1
    Checking the Hardware Requirements                               2-2
        Memory Requirements                                          2-2
        System Architecture                                          2-3
        Disk Space Requirements                                      2-4
        Display Requirements                                         2-4
        Recommended Hardware Requirement for SQL Developer           2-4
    Checking the Software Requirements                               2-4
        Instant Client Light Requirements                            2-8



3   Installing and Removing Oracle Database Client
    Downloading and Installing the Oracle Database Client Software   3-1
    Removing the Oracle Database Client Software                     3-2




                                                                      iii
4   Oracle Database Client Postinstallation Tasks
    Required Postinstallation Tasks                                               4-1
        Updating Instant Client                                                   4-1
        Connecting with Instant Client                                            4-2
    Recommended Postinstallation Tasks                                            4-2
        Connecting Instant Client or Instant Client Light to an Oracle Database   4-2
            Specifying a Connection by Using the Easy Connect Naming Method       4-3
            Specifying a Connection Using an Empty Connect String and TWO_TASK    4-3
        Setting the NLS_LANG Environment Variable                                 4-4
    Required Product-Specific Postinstallation Tasks                              4-4
        Configuring Oracle Precompilers                                           4-4
            Configuring Pro*C/C++                                                 4-5
        Configuring GCC as the Primary Compiler                                   4-5


    Index




                                                                                   iv
Preface
           This guide provides instructions about installing and configuring Oracle Database Cli‐
           ent for Linux on POWER Systems. This guide also describes about installing and con‐
           figuring database using response files, globalization support, ports, and troubleshoot‐
           ing.
           The preface contains the following topics:
           •   Audience
           •   Documentation Accessibility
           •   Command Syntax
           •   Related Documentation
           •   Typographic Conventions


Audience
           This guide is intended for anyone responsible for installing Oracle Database Client.
           Additional platform-specific installation guides for Oracle Database, Oracle Real Appli‐
           cation Clusters, Oracle Clusterware, Oracle Database Examples, and Oracle Enter‐
           prise Manager Grid Control are available at
           http://docs.oracle.com/en/database/database.html


Documentation Accessibility
           For information about Oracle's commitment to accessibility, visit the Oracle Accessibili‐
           ty Program website at http://www.oracle.com/pls/topic/lookup?ctx=acc&id=docacc.

           Access to Oracle Support
           Oracle customers that have purchased support have access to electronic support
           through My Oracle Support. For information, visit http://www.oracle.com/pls/topic/look‐
           up?ctx=acc&id=info or visit http://www.oracle.com/pls/topic/lookup?ctx=acc&id=trs if
           you are hearing impaired.


Set Up Java Access Bridge to Implement Java Accessibility
           Install Java Access Bridge so that assistive technologies on Microsoft Windows sys‐
           tems can use the Java Accessibility API.
           Java Access Bridge is a technology that enables Java applications and applets that
           implement the Java Accessibility API to be visible to assistive technologies on Micro‐
           soft Windows systems.




                                                                                                    v
                                                                                                     Preface


         Refer to Java Platform, Standard Edition Accessibility Guide for information about the
         minimum supported versions of assistive technologies required to use Java Access
         Bridge. Also refer to this guide to obtain installation and testing instructions, and in‐
         structions for how to use Java Access Bridge.
         Related Topics
         •   Java Platform, Standard Edition Java Accessibility Guide


Command Syntax
         UNIX command syntax appears in monospace font. The dollar character ($), number
         sign (#), or percent character (%) are UNIX command prompts. Do not enter them as
         part of the command. The following command syntax conventions are used in this
         guide:


         Convention         Description
         backslash \        A backslash is the UNIX command continuation character. It is used in
                            command examples that are too long to fit on a single line. Enter the com‐
                            mand as displayed (with a backslash) or enter it on a single line without a
                            backslash:
                            dd if=/dev/rdsk/c0t1d0s6 of=/dev/rst0 bs=10b \
                            count=10000

         braces { }         Braces indicate required items:
                            .DEFINE {macro1}

         brackets [ ]       Brackets indicate optional items:
                            cvtcrt termname [outfile]

         ellipses ...       Ellipses indicate an arbitrary number of similar items:
                            CHKVAL fieldname value1 value2 ... valueN

         italics            Italic type indicates a variable. Substitute a value for the variable:
                            library_name

         vertical line |    A vertical line indicates a choice within braces or brackets:
                            FILE filesize [K|M]



Related Documentation
         The product-specific and platform-specific documentation for Oracle Database prod‐
         ucts are available in both, PDF and HTML formats. You can view and download the
         documentation at
         http://docs.oracle.com/en/

         See Oracle Database Client Release Notes for IBM: Linux on POWER Little Endian
         Systems for important information that was not available when this book was released.




                                                                                                          vi
                                                                                                  Preface




Typographic Conventions
         The following text conventions are used in this document:


         Convention           Meaning
         boldface             Boldface type indicates graphical user interface elements associated
                              with an action, or terms defined in text or the glossary.
         italic               Italic type indicates book titles, emphasis, or placeholder variables for
                              which you supply particular values.
         monospace            Monospace type indicates commands within a paragraph, URLs, code
                              in examples, text that appears on the screen, or text that you enter.




                                                                                                          vii
1
Overview of Oracle Database Client Instal‐
lation
          This chapter describes the different installation types of Oracle Database Client and is‐
          sues to consider before you install Oracle Database Client:
          •    Planning Your Installation
          •    Installation Considerations
          •    Oracle Database Client Installation Types
          •    Oracle Database Client and Oracle Database Interoperability
          •    Simplified Patching of Timestamp with Time Zone Data Type


Planning Your Installation
          The Oracle Database Client installation process consists of the following phases:
          1.   Read the release notes: Read the Oracle Database Client Release Notes for
               IBM: Linux on POWER Little Endian Systems before you begin the installation.
          2.   Review the licensing information: Although the installation media in your media
               pack contain many Oracle components, you are permitted to use only those com‐
               ponents for which you have purchased licenses.
               Oracle Support Services does not provide support for components for which li‐
               censes have not been purchased.



                      See Also:
                      Oracle Database Licensing Information

          3.   Plan the installation: This chapter describes the Oracle products that you can in‐
               stall and issues that you must consider before starting the installation.
          4.   Complete preinstallation tasks: Oracle Database Client Preinstallation Tasks
               describes preinstallation tasks that you must complete before installing the prod‐
               uct.
          5.   Install the software: Installing and Removing Oracle Database Client describes
               how to install Oracle Database Client.
          6.   Complete postinstallation tasks: Oracle Database Client Postinstallation Tasks
               describes recommended and required postinstallation tasks.


Installation Considerations
          This section contains hardware and software certification information that you should
          consider before deciding to install this product.



                                                                                               1-1
                                                                                                Chapter 1
                                                                Oracle Database Client Installation Types


          The platform-specific hardware and software requirements included in this guide were
          current when this guide was published. However, because new platforms and operat‐
          ing system software versions might be certified after this guide is published, review the
          certification matrix on the My Oracle Support website for the most up-to-date list of
          certified hardware platforms and operating system versions. The My Oracle Support
          website is available at
          https://support.oracle.com/

          You must register online before using My Oracle Support. After logging in, from the
          menu options, select the Certifications tab. On the Certifications page, use the Cer‐
          tification Search options to search by Product, Release, and Platform. You can also
          search using the Certification Quick Link options such as Product Delivery and Life‐
          time Support.


Oracle Database Client Installation Types
          The Instant Client Enables you to install only the shared libraries required by Oracle
          Call Interface (OCI), Oracle C++ Call Interface (OCCI), Pro*C, or Java Database Con‐
          nectivity (JDBC) OCI applications. This installation type requires much less disk space
          than the other Oracle Database Client installation types.
          For more information about Instant Client, see Oracle Call Interface Programmer's
          Guide or Oracle Database JDBC Developer's Guide.
          Included in the Instant Client installation is Instant Client Light. You may want to use
          this version of Instant Client if the applications generate error messages in American
          English only. Instant Client Light is beneficial to application that use one of the sup‐
          ported character sets and can accept error messages in American English. The follow‐
          ing are the supported character sets:
          •   US7ASCII
          •   WE8DEC
          •   WE8MSWIN1252
          •   WE8ISO8859P1
          •   WE8EBCDIC37C for EBCDIC platforms only
          •   WE8EBCDIC1047 for EBCDIC platforms only
          •   UTF8
          •   AL32UTF8
          •   AL16UTF16
              The advantage of using Instant Client Light is that it has a smaller footprint than
              the regular Instant Client. The shared libraries, which an application must load, are
              only 34 MB as opposed to the 110 MB that regular Instant Client uses. Therefore,
              the applications use less memory.




                                                                                                    1-2
                                                                                               Chapter 1
                                             Oracle Database Client and Oracle Database Interoperability




Oracle Database Client and Oracle Database Interoperabili‐
ty
         For information about interoperability between Oracle Database Client and Oracle Da‐
         tabase releases, see Note 207303.1 on the My Oracle Support website at
         https://support.oracle.com/


Simplified Patching of Timestamp with Time Zone Data
Type
         Starting with Oracle Database 11g Release 2 (11.2), the patching process of TIME-
         STAMP WITH TIMEZONE data type values is simplified.

         Related Topics
         •   Changes in This Release for Oracle Database Globalization Support Guide
         •   Clients and Servers Operating with Different Versions of Time Zone Files




                                                                                                   1-3
2
Oracle Database Client Preinstallation
Tasks
          This chapter describes the tasks that you must complete before you install Oracle In‐
          stant Client. It includes the following information:
          •    Logging In to the System as root
          •    Checking the Hardware Requirements
          •    Checking the Software Requirements


Logging In to the System as root
          Before you install the Oracle software, you must complete several tasks as the root
          user. To log in as the root user, complete the following procedure:

          •    If you are installing the software from an X Window System workstation or X termi‐
               nal, then:
          1.   Start a local terminal session (xterm).
          2.   If you are not installing the software on the local system, then enter the following
               command to enable the remote host to display X applications on the local X serv‐
               er:
               $ xhost fully_qualified_remote_host_name

               For example,
               $ xhost somehost.us.example.com
          3.   If you are not installing the software on the local system, then use the ssh, rlogin,
               or telnet command to connect to the system where you want to install the soft‐
               ware:
               $ telnet fully_qualified_remote_host_name
          4.   If you are not logged in as the root user, then enter the following command to
               switch user to root:
               $ su - root
               password:
               #



                  Note:
                  Unless you intend to complete a silent-mode installation, you must install the
                  software from an X Window System workstation, an X terminal, or a PC or
                  other system with X server software installed.




                                                                                                 2-1
                                                                                             Chapter 2
                                                                   Checking the Hardware Requirements


         •    If you are installing the software from a PC or other system with X server software
              installed, then:
         1.   Start the X server software.
         2.   Configure the security settings of the X server software to permit remote hosts to
              display X applications on the local system.
         3.   Connect to the remote system where you want to install the software and start a
              terminal session on that system, for example, an X terminal (xterm).
         4.   If you are not logged in as the root user on the remote system, then enter the fol‐
              lowing command to switch user to root:
              $ su - root
              password:
              #



                 Note:
                 If necessary, refer to your X server documentation for more information
                 about completing this procedure. Depending on the X server software that
                 you are using, you may need to complete the tasks in a different order.




Checking the Hardware Requirements
         The system must meet the following minimum hardware requirements for Oracle Data‐
         base Client:
         •    Memory Requirements
         •    System Architecture
         •    Disk Space Requirements
         •    Display Requirements
         •    Recommended Hardware Requirement for SQL Developer


Memory Requirements
         The following are the memory requirements for Oracle Database Client:
         •    256 MB of RAM.
              To determine the physical RAM size, enter the following command:
              # grep MemTotal /proc/meminfo

              If the size of the physical RAM is less than the required size, then you must install
              more memory before continuing.
         •    The following table describes the relationship between installed RAM and the con‐
              figured swap space recommendation:




                                                                                                 2-2
                                                                                               Chapter 2
                                                                     Checking the Hardware Requirements




                        Note:
                        On Linux on POWER Systems, the HugePages feature allocates non-
                        swappable memory for large page tables using memory-mapped files. If
                        you enable HugePages, then you should deduct the memory allocated to
                        HugePages from the available RAM before calculating swap space.



               Available RAM                              Swap Space Required
               Up to 256 MB                               3 times the size of RAM
               Between 257 MB and 512 MB                  2 times the size of RAM
               Between 513 MB and 726 MB                  1.5 times the size of RAM
               More than 726 MB                           0.75 times the size of RAM

           To determine the size of the configured swap space, enter the following command:
           # grep SwapTotal /proc/meminfo

           If necessary, see the operating system documentation for information about how to
           configure additional swap space.
           To determine the available RAM and swap space, enter the following command:
           # free



                    Note:

                    •   Oracle recommends that you take multiple values for the available RAM
                        and swap space before finalizing on a value. This is because the availa‐
                        ble RAM and swap space keep changing depending on the user interac‐
                        tions with the computer.
                    •   Contact the operating system vendor for swap space allocation guidance
                        for your server. The vendor guidelines supersede the swap space re‐
                        quirements listed in this guide.



System Architecture
           To determine whether the system architecture can run the software, enter the following
           command:
           # uname -m



                    Note:
                    This command displays the processor type. Verify that the processor archi‐
                    tecture matches the Oracle software release to install. If you do not see the
                    expected output, then you cannot install the software on this system.




                                                                                                    2-3
                                                                                                 Chapter 2
                                                                        Checking the Software Requirements




Disk Space Requirements
          The following are the disk space requirements for Oracle Database Client:
          •   The minimum disk space requirement for a client install in the /tmp directory is
              120 MB. The minimum disk space requirement in the /tmp directory depends on
              the installation type you have selected. The following table lists the minimum disk
              space requirements for the /tmp directory in each type of installation.
              To determine the amount of disk space available, enter the following command:
              # df -k /tmp

              If there is less than 120 MB of free space available in the /tmp directory, then
              complete one of the following steps:
              –      Delete unnecessary files from the /tmp directory to meet the space require‐
                     ment.
              –      Set the TMP and TMPDIR environment variables when setting the oracle user's
                     environment.
              –      Extend the file system that contains the /tmp directory. If necessary, contact
                     the system administrator for information about extending file systems.
          •   To determine the amount of free disk space on the system, enter the following
              command:
              # df -k

              The client install requires 130 MB disk space for software files on Linux on POW‐
              ER Systems.


Display Requirements
          The minimum display requirement for Oracle Database Client is a resolution of 1024 x
          768 or higher.


Recommended Hardware Requirement for SQL Developer
          The following are the recommended CPU, Memory and Display requirements for SQL
          Developer:


           Resource                        Recommended
           Memory                          1 GB RAM (recommended), 256 MB RAM (minimum)
           Display                         65536 colors, set to at least 1024 X 768 resolution



Checking the Software Requirements
          Depending on the products that you intend to install, verify that the following software
          is installed on the system:




                                                                                                      2-4
                                                                                     Chapter 2
                                                           Checking the Software Requirements




Item               Requirement
Operating system   The following operating systems (or a later version) are supported:
                   •   Red Hat Enterprise Linux Server 7.1
                   •   SUSE Linux Enterprise Server 12
Kernel version     The system must be running the following kernel versions (or a later ver‐
                   sion):
                   •   Red Hat Enterprise Linux Server 7.1
                       (3.10.0-229.ael7b.ppc64le)
                   •   SUSE Linux Enterprise Server 12 (3.12.28-4.6.ppc64le)
Red Hat Enterprise The following packages must be installed:
Linux Server 7.1   binutils-2.23.52.0.1-30.ael7b.ppc64le
Packages
                   compat-openldap-2.3.43-5.ael7b.ppc64le
                   compat-libtiff3-3.9.4-11.ael7b.ppc64le
                   compat-libcap1-1.10-7.ael7b.ppc64le
                   compat-db47-4.7.25-28.ael7b.ppc64le
                   compat-db-headers-4.7.25-28.ael7b.noarch
                   libstdc++-4.8.3-9.ael7b.ppc64le
                   libstdc++-devel-4.8.3-9.ael7b.ppc64le
                   gcc-4.8.3-9.ael7b.ppc64le
                   gcc-c++-4.8.3-9.ael7b.ppc64le
                   libgcc-4.8.3-9.ael7b.ppc64le
                   gcc-gfortran-4.8.3-9.ael7b.ppc64le
                   libaio-devel-0.3.109-12.ael7b.ppc64le
                   libaio-0.3.109-12.ael7b.ppc64le
                   glibc-common-2.17-78.ael7b.ppc64le
                   glibc-devel-2.17-78.ael7b.ppc64le
                   glibc-2.17-78.ael7b.ppc64le
                   glibc-headers-2.17-78.ael7b.ppc64le
                   GNU Make 3.82 for powerpc64le-redhat-linux-gnu
                   sysstat-10.1.5-7.ael7b.ppc64le
                   java-1.8.0-openjdk for ppc64le
                   java-1.8.0-openjdk-headless-1.8.0 for ppc64le
                   IBM XL C/C++ for Linux, V13.1.2 (5725-C73, 5765-J08)
                   Version: 13.01.0002.0000




                                                                                          2-5
                                                                                         Chapter 2
                                                             Checking the Software Requirements




Item                Requirement
SUSE Linux Enter‐   The following packages must be installed:
prise Server 12     binutils-2.24-2.165.ppc64le
Packages
                    libstdc++-devel-4.8-6.189.ppc64le
                    libstdc++6-4.8.3+r212056-6.3.ppc64le
                    libstdc++48-devel-4.8.3+r212056-6.3.ppc64le
                    libgcc_s1-4.8.3+r212056-6.3.ppc64le
                    gcc48-info-4.8.3+r212056-6.3.noarch
                    gcc-info-4.8-6.189.ppc64le
                    gcc48-locale-4.8.3+r212056-6.3.ppc64le
                    gcc-locale-4.8-6.189.ppc64le
                    gcc-4.8-6.189.ppc64le
                    gcc-c++-4.8-6.189.ppc64le
                    gcc48-4.8.3+r212056-6.3.ppc64le
                    gcc48-c++-4.8.3+r212056-6.3.ppc64le
                    glibc-i18ndata-2.19-17.72.noarch
                    glibc-devel-2.19-17.72.ppc64le
                    glibc-info-2.19-17.72.noarch
                    glibc-html-2.19-17.72.noarch
                    glibc-locale-2.19-17.72.ppc64le
                    linux-glibc-devel-3.12-3.98.noarch
                    glibc-profile-2.19-17.72.ppc64le
                    glibc-2.19-17.72.ppc64le
                    libaio-devel-0.3.109-17.15.ppc64le
                    libaio1-0.3.109-17.15.ppc64le
                    sysstat-10.2.1-1.11.ppc64le
                    sysstat-isag-10.2.1-1.11.ppc64le
                    GNU Make 4.0
                    IBM XL C/C++ for Linux, V13.1.1 (5725-C73, 5765-J08)
                    Version: 13.01.0001.0000
C/C++ Runtime En‐ Download the following IBM XL C/C++ Runtime Environment:
vironment         •  V13.1.1 for SUSE Linux Enterprise Server 12 at
                        http://www-01.ibm.com/support/docview.wss?
                        uid=swg24039070
                    •   V13.1.2 for Red Hat Enterprise Linux Server 7.1 at
                        http://www-01.ibm.com/support/docview.wss?
                        uid=swg24040214
                    If you need VAC optimization packages, then you must download and in‐
                    stall the XL Optimization Libraries component from this link.
Compilers           The version of GNU C and C++ compilers listed under Packages are sup‐
                    ported.
Pro*FORTRAN         The following fortran versions (or a later version) are supported:
                    •   IBM XL Fortran V15.1.2
                    •   GNU Fortran (GCC) 4.8.3 20140911




                                                                                             2-6
                                                                                      Chapter 2
                                                            Checking the Software Requirements




Item                 Requirement
Oracle JDBC- OCI     You can use the following JDBC - OCI drivers; however, these are not re‐
Drivers              quired for the installation:
                     •    JDBC-OCI 1.8.0 or later on RHEL 7.1
                     •    JDBC-OCI 1.8.0 or later versions on SUSE 12
Oracle ODBC Driv‐ To use ODBC, you must also install the following additional ODBC RPMs,
er                depending on your operating system.
                     Red Hat Enterprise Linux Server 7.1
                     unixODBC-2.3.1-4.95.ppc64le
                     SUSE Linux Enterprise Server 12:
                     unixODBC-2.3.1-4.95.ppc64le

If you want to use GNU Compiler Collection (GCC) as the primary compiler, see the
"Configuring GCC as the Primary Compiler" section for instructions on configuring the
primary compiler.
The following procedure describes how to verify and ensure that the system meets
these requirements:
1.   To determine which distribution and version of Linux is installed, enter the follow‐
     ing command:
     # cat /etc/issue



            Note:
            Only the distributions and versions listed in the previous table are sup‐
            ported. Do not install the software on other versions of Linux on POWER
            Systems.


2.   To determine whether the required kernel is installed, enter the following com‐
     mand:
     # uname -r

     The following is a sample output displayed by running this command on a Red Hat
     Enterprise Linux Server 7.1 system:
     3.10.0-229.ael7b.ppc64le

     In this example, the output shows the kernel version (3.10.0) and errata level
     (ael17b) on the system.
     If the kernel version does not meet the requirement specified earlier in this section,
     then contact your operating system vendor for information about obtaining and in‐
     stalling kernel updates.
3.   To determine whether the required packages are installed, enter commands simi‐
     lar to the following:
     # rpm -q package_name

     If a package is not installed, then install it from your Linux distribution media or
     download the required package version from your Linux vendor's website.




                                                                                            2-7
                                                                                                Chapter 2
                                                                       Checking the Software Requirements




Instant Client Light Requirements
           In addition to the requirements described in the preceding section, if you plan to use
           Instant Client Light, then the applications must use the following languages and char‐
           acter sets:
           •   Language: Any language that is supported by Oracle.
           •   Territory: Any territory that is supported by Oracle.
           •   Character sets:
               –   Single byte
                   *   US7ASCII
                   *   WE8DEC
                   *   WE8MSWIN1252
                   *   WE8ISO8859P1
                   *   WE8EBCDIC37C for EBCDIC platforms only
                   *   WE8EBCDIC1047 for EBCDIC platforms only
               –   Unicode
                   *   UTF8
                   *   AL32UTF8
                   *   AL16UTF16
                       The advantage of using Instant Client Light is that it has a smaller footprint
                       than the regular Instant Client. The shared libraries, which an application
                       must load, are only 34 MB as opposed to the 110 MB that regular Instant
                       Client uses. Therefore, the applications use less memory.
           The language, territory, and character sets are determined by the NLS_LANG environ‐
           ment variable.



                   Note:
                   Ensure that you set the NLS_LANG environment variable to the required char‐
                   acter set before you run Oracle Database Instant Client.




                                                                                                     2-8
3
Installing and Removing Oracle Database
Client
          The Oracle Database Client software is available on Oracle Technology Network web‐
          site. This chapter describes the following sections:
          •    Downloading and Installing the Oracle Database Client Software
          •    Removing the Oracle Database Client Software


Downloading and Installing the Oracle Database Client Soft‐
ware
          The following steps describe how to install the Oracle software:
          1.   Download the Instant Client for Linux on POWER Systems (64-bit) package from
               the Instant Client Downloads page on Oracle Technology Network at
               http://www.oracle.com/technetwork/index.html
          2.   Create a directory on your computer, for example, instantclient. Choose a di‐
               rectory to install the Oracle Instant Client and unzip the downloaded zip file in that
               directory. The unzipped file creates the instantclient_19_3 directory.
          3.   Set the LD_LIBRARY_PATH and the NLS_LANG environment variables to the full path
               of the instantclient_19_3 directory. For example, if you unzipped the Instant Cli‐
               ent zip file in the /bin/oracle directory, then set the LD_LIBRARY_PATH environ‐
               ment variable to /bin/oracle/instantclient_19_3.
               See the "Instant Client Light Requirements" section for information about setting
               the NLS_LANG environment variable to the required character set.
               This completes the installation of Oracle Database Client. To connect to the Ora‐
               cle Database server, run the client from the Oracle Database Instant Client envi‐
               ronment.
          4.   The Object Type Translator Utility (OTT) utility may have to be modified to reflect
               the correct environment variable LD_LIBRARY_PATH as ORACLE_HOME may not be
               available.




                                                                                                  3-1
                                                                                          Chapter 3
                                                       Removing the Oracle Database Client Software




               Note:
               If you want to use VAC compiler, then you must set the COMPILER=VAC value
               in the environment. Also, set the VAC_VERSION as follows:

               •   For Red Hat Enterprise Linux Server 7.1, set:
                   VAC_VERSION=13.1.2
               •   For SUSE Linux Enterprise Server 12, set:
                   VAC_VERSION=13.1.1
               In addition to the preceding task:
               •   Ensure that xlC is in the PATH of your environment.
               •   Also, set COMPILER_MODE = 64 if you want to build a 64-bit demo execut‐
                   able.



Removing the Oracle Database Client Software
         To remove the Oracle Database Client software, delete the instantclient_19_3 di‐
         rectory.




                                                                                              3-2
4
Oracle Database Client Postinstallation
Tasks
            This chapter describes how to complete postinstallation tasks after you have installed
            the Oracle Database Client software. It includes information about the following topics:
            •    Required Postinstallation Tasks
            •    Recommended Postinstallation Tasks
            •    Required Product-Specific Postinstallation Tasks
            You must perform the tasks listed in "Required Postinstallation Tasks". Oracle recom‐
            mends that you perform the tasks listed in "Recommended Postinstallation Tasks" af‐
            ter all installations.
            If you install and intend to use any of the products listed in "Required Product-Specific
            Postinstallation Tasks", then you must perform the tasks listed in the product-specific
            subsections.


Required Postinstallation Tasks
            You must perform the tasks described in the following sections after completing an in‐
            stallation:
            •    Updating Instant Client
            •    Connecting with Instant Client


Updating Instant Client
            To update Instant Client:
            1.   Download Instant Client from Oracle Technology Network at
                 http://www.oracle.com/technetwork/database/features/instant-client/
                 index-097480.html
            2.   If you want to place the files in the existing directory, then ensure that the directory
                 is empty.
                 If you want to place the files into a different directory (and remove the previous
                 files), ensure that you update the PATH environment variable setting to reflect the
                 new location.




                                                                                                     4-1
                                                                                                  Chapter 4
                                                                        Recommended Postinstallation Tasks




                     Caution:
                     The Instant Client and Instant Client Light installations do not create an in‐
                     ventory. Therefore, you cannot perform patch upgrades for these installa‐
                     tions using the opatch utility.



Connecting with Instant Client
            If you installed the Instant Client installation type, you can configure users' environ‐
            ments to enable dynamically linked client applications to connect to a database as fol‐
            lows:
            1.   Set the appropriate shared library path environment variable for your platform to
                 specify the directory that contains the Instant Client libraries. For the Instant Client
                 installation type, this directory is the Oracle home directory that you specified dur‐
                 ing the installation, for example:
                 Your_current_dir/instantclient_19_3
            2.   Use one of the following methods to specify database connection information for
                 the client application:
                 •    Specify a SQL connect URL string using the following format:
                      //host:port/service_name

                      For example:
                      //shobeen:1521/sales_us
                 •    Set the TNS_ADMIN environment variable to specify the location of the
                      tnsnames.ora file and specify a service name from that file.
                 •    Set the TNS_ADMIN and the TWO_TASK environment variables to specify a serv‐
                      ice name from the tnsnames.ora file.



                     Note:
                     It is not required that you specify the ORACLE_HOME environment variable.




Recommended Postinstallation Tasks
            Oracle recommends that you perform the tasks described in the following sections af‐
            ter completing an installation:
            •    Connecting Instant Client or Instant Client Light to an Oracle Database
            •    Setting the NLS_LANG Environment Variable


Connecting Instant Client or Instant Client Light to an Oracle Database
            Before you can connect Instant Client (including Instant Client Light) to an Oracle data‐
            base, ensure that the LD_LIBRARY_PATH environment variable specifies the directo‐



                                                                                                      4-2
                                                                                               Chapter 4
                                                                      Recommended Postinstallation Tasks


            ry that contains the Instant Client libraries. This directory is the ORACLE_HOME direc‐
            tory that you specified during installation.
            For example, the shared libraries for Instant Client or Instant Client Light (if you have
            configured Instant Client Light), are in:
            Your_current_dir/instantclient_19_3

            After checking the LD_LIBRARY_PATH environment variable, you can use any of the fol‐
            lowing methods to specify Oracle Database connection information for client applica‐
            tions:
            •   Specifying a Connection by Using the Easy Connect Naming Method
            •   Specifying a Connection Using an Empty Connect String and TWO_TASK

Specifying a Connection by Using the Easy Connect Naming Method
            You can specify a connection address to an Oracle Database directly from a client ap‐
            plication, without having to configure a tnsnames setting for the Instant Client. This
            method is convenient as you do not have to create and manage a tnsnames.ora file.
            However, the application users must specify the host name and port number when
            they want to log in to the application.
            For example, if you run SQL*Plus on the client computer and want to connect to the
            sales_us database, which is located on a server whose host name is shobeen and port
            number is 1521, then you can log in as follows:
            Enter user-name: system@admin@//shobeen:1521/sales_us

            Similarly, in the application code, you can use Oracle Call Interface net naming meth‐
            ods to create the Instant Client-to-Oracle Database connection. For example, the fol‐
            lowing formats in the OCIServerAttach() call specify the connection information:

            •   Specify a SQL connect URL string using the following format:
                //host[:port][/service_name]

                For example:
                //shobeen:1521/sales_us
            •   Alternatively, you can specify the SQL connect information as an Oracle Net key‐
                word-value pair. For example:
                "(DESCRIPTION=(ADDRESS=(PROTOCOL=tcp) (HOST=shobeen) (PORT=1521))
                (CONNECT_DATA=(SERVICE_NAME=sales_us)))"



                       See Also:
                       Oracle Call Interface Programmer's Guide for more information on using
                       Oracle Call Interface Instant Client



Specifying a Connection Using an Empty Connect String and TWO_TASK
            You can set the connect string to an empty connect string (""), and then set the
            TWO_TASK environment variable to one of the following values:




                                                                                                    4-3
                                                                                                  Chapter 4
                                                           Required Product-Specific Postinstallation Tasks


           •   A direct address, as described under "Specifying a Connection by Using the Easy
               Connect Naming Method".
           •   Oracle Net keyword-value pair.
           •   A tnsnames.ora entry and TNS_ADMIN is set to the location of tnsnames.ora.
           •   A tnsnames.ora entry and the following:
               –   tnsnames.ora file located in $ORACLE_HOME/network/admin.
               –   The ORACLE_HOME environment variable set to this Oracle home.
           This method allows the applications to specify internally a connection string if the ap‐
           plication code itself uses an empty connection string. The benefit of an empty connect
           string is that the application itself does not have to specify the tnsnames.ora entry. In‐
           stead, when a user starts the application, the location of the database is determined by
           a script or the environment, depending on where you have set the TWO_TASK environ‐
           ment variable. The disadvantage of using empty strings is that you must configure this
           additional information in order for the application to connect to the database.


Setting the NLS_LANG Environment Variable
           NLS_LANG is an environment variable that specifies the locale behavior for Oracle soft‐
           ware. This variable sets the language and territory used by the client application and
           the database user session. It also declares the character set of the client, which is the
           character set of data entered or displayed by an Oracle client program, such as
           SQL*Plus.



                   Note:
                   The character set of the data displayed is determined by the environment of
                   the operating system, such as keyboard driver and fonts in use. The
                   NLS_LANG character set should match the operating system.



           See the "Setting Up a Globalization Support Environment" section in Oracle Database
           Globalization Support Guide for information about Globalization Support.


Required Product-Specific Postinstallation Tasks
           The following sections describe postinstallation tasks that you must perform if you in‐
           stall and intend to use Oracle Precompliers:



                   Note:
                   You must perform postinstallation tasks only for products that you intend to
                   use.



Configuring Oracle Precompilers
           This section describes postinstallation tasks for Pro*C/C++.



                                                                                                      4-4
                                                                                                     Chapter 4
                                                              Required Product-Specific Postinstallation Tasks




                    Note:
                    All precompiler configuration files are located in the $ORACLE_HOME/precomp/
                    admin directory.



Configuring Pro*C/C++
            Verify that the PATH environment variable setting includes the directory that contains
            the C compiler executable. The default directory for the gcc compiler executable
            is /usr/bin.

            For more information about setting environment variables, see Pro*C/C++ Programm‐
            er's Guide.


Configuring GCC as the Primary Compiler
            You can configure GNU Compiler Collection (GCC) as the primary compiler if the pri‐
            mary supported compiler is not available. Configuring the primary compiler enables
            you to speed up the performance of PL/SQL modules such as packages by compiling
            them into native code that resides in shared libraries. This method translates the mod‐
            ule into C code, compiles it with a C compiler, and then links it into the Oracle process.
            Remember that you must use one compiler to compile all your Oracle modules. You
            cannot compile some modules with the primary compiler and others with a different
            compiler.
            If both, the primary supported compiler for the operating system and GCC are availa‐
            ble, then use the primary supported compiler. However, if the primary supported com‐
            piler is not available, then use GCC.
            To configure GCC as the primary compiler:
            1.   Open the spnc_commands configuration file in a text editor. In a default installation,
                 the spnc_commands file is located in the $ORACLE_HOME/plsql directory.
            2.   Look for the following line of text and comment it out:
                 /usr/local/packages/vac/vac/$(VAC_VERSION)/bin/xlc -F$
                 (ORACLE_HOME)/lib/xlc.cfg %(src) -O0 -qpic -q64 -I$(ORACLE_HOME)/
                 plsql/include -I$(ORACLE_HOME)/plsql/public -s -qmkshrobj -o %(so)
            3.   Look for the following lines, which pertain to GCC, and uncomment them:
                 # /usr/bin/gcc -m64 -B/usr/bin/ %(src) -O1 -fPIC -I$(ORACLE_HOME)/
                 plsql/include -I$(ORACLE_HOME)/plsql/public -s -shared -o %(so)
            4.   Save and close the spnc_commands configuration file.



                    See Also:
                    Oracle Database PL/SQL User's Guide and Reference for more information
                    on PL/SQL native compilation and the spnc_commands configuration file




                                                                                                         4-5
                                                                                       Chapter 4
                                                Required Product-Specific Postinstallation Tasks




Using the IBM XL C/C++ compiler for PL/SQL Native Compilation
By default, PL/SQL native compilation is configured to use the GCC compiler. If you
want to use the IBM XL compiler (XLC) instead of the GCC compiler, then make the
following changes in the $ORACLE_HOME/plsql/spnc_commands file:

1.   Comment out the lines for the GCC compiler.
2.   Uncomment the lines for IBM XL compiler.




                                                                                           4-6
Index
C                                             O
character sets, 2-8                           operating system, 2-5
checking system requirements, 2-7             Oracle Database Instant Client
    checking the gcc version, 2-7                connecting to an Oracle Database, 4-2
checking the gcc version, 2-7                 Oracle Database Instant Client Light
                                                 connecting to an Oracle Database, 4-2
                                              Oracle JDBC/OCI drivers, 2-7
D                                             Oracle precompilers, 4-4
disk space requirements, 2-4                     Pro C/C++, 4-4
display requirements, 2-4
                                              P
E                                             postinstallation tasks, 4-1
environment variables                             connecting with Instant Client, 4-2
    NLS_LANG, 4-4                                 NLS_LANG, 4-4
                                                  Oracle precompilers, 4-4
                                                  updating Instant Client, 4-1
H                                             preinstallation requirements
hardware requirement, 2-2                         hardware requirement, 2-2
    display requirements, 2-4                     logging in to the system as root, 2-1
    hardware requirement for SQL developer,       preinstallation tasks, 2-1
             2-4                                  software requirements, 2-4
    memory requirements, 2-2                  preinstallation tasks
    system architecture, 2-3                      preinstallation requirements, 2-1
hardware requirement for SQL developer, 2-4
hardware requirements                         S
    disk space requirements, 2-4
                                              software requirements, 2-4
                                                  checking system requirements, 2-7
I                                                 Instant Client Light requirements, 2-8
installation                                      operating system, 2-5
    available products, 1-2                       Oracle JDBC/OCI drivers, 2-7
installation considerations, 1-1                  tools requirement, 2-5
Instant Client Light requirements, 2-8        system architecture, 2-3
    character sets, 2-8
                                              T
M                                             TIMESTAMP WITH TIMEZONE patching, 1-3
memory requirements, 2-2                      tools requirement, 2-5




                                                                                           Index-1

