# 23. Database Client Installation Guide for Microsoft Windows

> 源文件: `en/ntcli/database-client-installation-guide-microsoft-windows.pdf`

Oracle® Database
Database Client Installation Guide




    19c for Microsoft Windows
    E96295-09
    June 2025
Oracle Database Database Client Installation Guide, 19c for Microsoft Windows

E96295-09

Copyright © 2015, 2025, Oracle and/or its affiliates.

Primary Author: Sunil Surabhi

Contributing Authors: Prakash Jashnani, Jean-Francois Verrier, Douglas Williams

Contributors: Sivaselvam Narayanasamy, Barb Glover, Eric Belden, Sudip Datta, David Friedman, Alex Keh, Christian
Shay, Peter LaQuerre, Rich Long, Matt McKerley, Sham Rao Pavan, Hanlin Qian, Sujatha Tolstoy, Michael Verheij,
Madhu Velukur, Sergiusz Wolicki, Sue Mavris, Mohammed Shahnawaz Quadri, Vishal Saxena, Krishna Itikarlapall,
Santanu Datta, Sivaselvam Narayasamy, Michael Coulter, Robert Achacoso, Malai Stalin, David Price, Ramesh
Chakravarthula

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
    Audience                                                                                   viii
    Documentation Accessibility                                                                viii
    Diversity and Inclusion                                                                     ix
    Set Up Java Access Bridge to Implement Java Accessibility                                   ix
    Related Documentation                                                                       ix
    Conventions                                                                                  x



1   Oracle Database Client Installation Checklist
    Server Hardware Checklist for Oracle Database Client Installation                          1-1
    Operating System Checklist for Oracle Database Client Installation                         1-2
    Server Configuration Checklist for Oracle Database Client Installation                     1-2
    Oracle User Environment Configuration Checklist for Oracle Database Client Installation    1-3
    Storage Checklist for Oracle Database Client Installation                                  1-4
    Installer Planning Checklist for Oracle Database Client Installation                       1-4



2   Oracle Database Client Preinstallation Tasks
    Oracle Database Client Minimum Hardware Requirements                                       2-1
        Hardware Component Requirements for Windows x64                                        2-2
        Hard Disk Space Requirements                                                           2-2
        Verifying Hardware Requirements                                                        2-3
    Oracle Database Client Software Requirements                                               2-4
        Oracle Database Client Software Requirements                                           2-4
        Instant Client Light Language and Character Set Requirements                           2-5
    Creating Oracle Home User                                                                  2-7
    Creating Users, Groups and Environments for Oracle Database Client                         2-8
    Managing User Accounts with User Account Control                                           2-9
    Remote Desktop Services                                                                    2-9
    Microsoft Windows Servicing Options                                                       2-10
    Default Share Configuration Requirement                                                   2-10
    Installation Requirements for Web Browsers                                                2-11
    Microsoft Hyper-V Requirements                                                            2-11




                                                                                                iii
    Enabling Oracle Instant Client Code Signing                                               2-11
        Verifying Signed Oracle Instant Client Zip Files                                      2-11



3   Installing Oracle Database Client
    Installation Considerations for Oracle Database Client                                    3-1
        Creating the Oracle Base Directory                                                    3-1
        Multiple Oracle Home Components                                                       3-2
    About Image-Based Oracle Database Client Installation                                     3-2
    Accessing the Installation Software                                                       3-2
        Installing from a Remote DVD Drive                                                    3-3
            Step 1: On the Remote Computer, Share the DVD Drive                               3-3
            Step 2: On the Local Computer, Map the DVD Drive                                  3-3
        Installing on Remote Computers Through Remote Access Software                         3-4
            Installing on Remote Computers from a Hard Drive                                  3-4
            Installing on Remote Computers from a Remote DVD Drive                            3-5
        Downloading Oracle Software                                                           3-5
            Downloading the Installation Archive Files from OTN                               3-5
            Downloading the Software from Oracle Software Delivery Cloud                      3-6
        Copying the Oracle Database Client Software to a Hard Disk                            3-7
    Installing the Oracle Database Client Software                                            3-7
        Running Setup Wizard to Install Oracle Database Client                                3-7
        Installing Oracle Database Client Using Image File                                    3-8
        Using Oracle Net Configuration Assistant                                              3-9



4   Oracle Database Client Postinstallation Tasks
    Required Postinstallation Tasks                                                           4-1
        Downloading and Installing Release Update Patches                                     4-1
        Windows Authentication No Longer Uses NTLM by Default                                 4-2
        Updating Instant Client                                                               4-3
        Configuring Oracle Net Services                                                       4-3
    Recommended Postinstallation Tasks                                                        4-4
        Configuring Instant Client Light                                                      4-4
        Connecting Oracle Database Client to an Oracle Database                               4-5
        Connecting Instant Client or Instant Client Light to an Oracle Database               4-5
            Specifying a Connection by Using the Easy Connect Naming Method                   4-6
            Specifying a Connection by Configuring a tnsnames.ora File                        4-6
            Specifying a Connection by Using an Empty Connect String and the LOCAL Variable   4-7
        Changing the Oracle Home User Password                                                4-7
        Creating the OraMTS Service for Microsoft Transaction Server                          4-8




                                                                                                iv
       Creating the Scheduler Agent                                                        4-9



5   Removing Oracle Database Client Software
    About Oracle Deinstallation Options                                                    5-2
    Deinstallation Examples for Oracle Database Client                                     5-5
    Example of Running the Deinstallation Tool                                             5-5
    Deinstallation Response File Example for Oracle Database Client                        5-6



A   Installing Java Access Bridge
    Overview of Java Access Bridge 2.0.2                                                   A-1
    Setting Up Java Access Bridge 2.0.2                                                    A-1



B   Installing and Configuring Oracle Database Using Response Files
    How Response Files Work                                                                B-1
       Reasons for Using Silent Mode or Response File Mode                                 B-2
       Using Response Files                                                                B-2
    Preparing a Response File                                                              B-3
       Editing a Response File Template                                                    B-3
       Saving a Response File                                                              B-4
    Running Oracle Universal Installer Using the Response File                             B-5



C   Configuring Networks for Oracle Database
    Installing Oracle Database on Computers with Multiple IP Addresses                     C-1
    Installing Oracle Database on Computers with Multiple Aliases                          C-2
    Installing Oracle Database on Nonnetworked Computers                                   C-2
    Installing a Loopback Adapter                                                          C-2
       Checking if a Loopback Adapter is Installed on Your Computer                        C-3
       Installing a Loopback Adapter                                                       C-3
       Removing a Loopback Adapter                                                         C-5



D   Configuring Oracle Database Globalization Support
    Installing and Using Oracle Components in Different Languages                          D-1
       Configuring Oracle Components to Run in Different Languages                         D-1
           Determining the Operating System Locale                                         D-2
           Configuring Locale and Character Sets Using the NLS_LANG Environment Variable   D-2
           NLS_LANG Settings in Console Mode and Batch Mode                                D-4
       Installing Translation Resources                                                    D-5




                                                                                            v
Running Oracle Universal Installer in Different Languages   D-6


Index




                                                             vi
List of Tables
1-1   Server Hardware Checklist for Oracle Database Client Installation                         1-1
1-2   Operating System Checklist for Oracle Database Client Installation on Microsoft Windows   1-2
1-3   Server Configuration Checklist for Oracle Database Client Installation                    1-2
1-4   Oracle User Environment Configuration Checklist for Oracle Database Client Installation   1-3
1-5   Storage Checklist for Oracle Database Client Installation                                 1-4
1-6   Installer Planning Checklist for Oracle Database Client Installation                      1-4
2-1   Windows x64 Hardware Requirements                                                         2-2
2-2   Windows x64 Disk Space Requirements on NTFS                                               2-3
2-3   Windows x64 Software Requirements                                                         2-4
A-1   Copy Files to JDK Directory on Windows 64-Bit                                             A-2
B-1   Reasons for Using Silent Mode or Response File Mode                                       B-2
B-2   Response Files                                                                            B-3
D-1   Oracle Character Sets for Console Mode (OEM) Code Pages                                   D-4




                                                                                                 vii
                                                                                                        Preface




Preface
           This guide explains how to install and configure Oracle Database Client. This guide also
           provides information about postinstallation tasks and how to remove the database client
           software.
           This preface contains these topics:
           •   Audience
           •   Documentation Accessibility
           •   Diversity and Inclusion
           •   Set Up Java Access Bridge to Implement Java Accessibility
               Install Java Access Bridge so that assistive technologies on Microsoft Windows systems
               can use the Java Accessibility API.
           •   Related Documentation
           •   Conventions


Audience
           This guide is intended for anyone responsible for installing Oracle Database Client 19c.
           To use this document, you need the following:
           •   A supported Microsoft Windows operating system installed and tested on your computer
               system
           •   Administrative privileges on the computer where you are installing the Oracle Database
               software
           •   Familiarity with object-relational database management concepts
           Additional installation guides for Oracle Database, Oracle Real Application Clusters, Oracle
           Clusterware, Oracle Database Examples, and Oracle Enterprise Manager Cloud Control are
           available at the following URL:
           http://docs.oracle.com


Documentation Accessibility
           For information about Oracle's commitment to accessibility, visit the Oracle Accessibility
           Program website at http://www.oracle.com/pls/topic/lookup?ctx=acc&id=docacc.

           Access to Oracle Support
           Oracle customers that have purchased support have access to electronic support through My
           Oracle Support. For information, visit http://www.oracle.com/pls/topic/lookup?ctx=acc&id=info
           or visit http://www.oracle.com/pls/topic/lookup?ctx=acc&id=trs if you are hearing impaired.




                                                                                                           viii
                                                                                                   Preface




Diversity and Inclusion
          Oracle is fully committed to diversity and inclusion. Oracle respects and values having a
          diverse workforce that increases thought leadership and innovation. As part of our initiative to
          build a more inclusive culture that positively impacts our employees, customers, and partners,
          we are working to remove insensitive terms from our products and documentation. We are also
          mindful of the necessity to maintain compatibility with our customers' existing technologies and
          the need to ensure continuity of service as Oracle's offerings and industry standards evolve.
          Because of these technical constraints, our effort to remove insensitive terms is ongoing and
          will take time and external cooperation.


Set Up Java Access Bridge to Implement Java Accessibility
          Install Java Access Bridge so that assistive technologies on Microsoft Windows systems can
          use the Java Accessibility API.
          Java Access Bridge is a technology that enables Java applications and applets that implement
          the Java Accessibility API to be visible to assistive technologies on Microsoft Windows
          systems.
          Refer to Java Platform, Standard Edition Accessibility Guide for information about the minimum
          supported versions of assistive technologies required to use Java Access Bridge. Also refer to
          this guide to obtain installation and testing instructions, and instructions for how to use Java
          Access Bridge.
          Related Topics
          •   Java Platform, Standard Edition Java Accessibility Guide


Related Documentation
          For more information, see these Oracle resources:
          •   Oracle Database Concepts
          •   Oracle Database Examples Installation Guide
          •   Oracle Grid Infrastructure Installation Guide
          •   Oracle Enterprise Manager Cloud Control Basic Installation Guide
          •   Oracle Database Upgrade Guide
          •   Oracle Database 2 Day DBA
          •   Oracle Database Error Messages
          •   Oracle Database Sample Schemas.
          •   Oracle Database Licensing Information
          •   Oracle Database Administrator's Reference Guide for Microsoft Windows
          •   Oracle Enterprise Manager Cloud Control Basic Installation Guide
          •   Oracle Database Net Services Administrator's Guide
          •   Oracle Automatic Storage Management Administrator's Guide
          •   Oracle Database Globalization Support Guide
          •   Oracle Database Vault Administrator's Guide



                                                                                                        ix
                                                                                                          Preface




Conventions
        The following text conventions are used in this document:


         Convention            Meaning
         boldface              Boldface type indicates graphical user interface elements associated with an
                               action, or terms defined in text or the glossary.
         italic                Italic type indicates book titles, emphasis, or placeholder variables for which
                               you supply particular values.
         monospace             Monospace type indicates commands within a paragraph, URLs, code in
                               examples, text that appears on the screen, or text that you enter.




                                                                                                                 x
1
Oracle Database Client Installation Checklist
         Use checklists to review system requirements, and to plan and carry out Oracle Database
         Client installation. Oracle recommends that you use checklists as part of your installation
         planning process. Using checklists can help you to confirm that your server hardware and
         configuration meet minimum requirements for this release, and can help you to ensure you
         carry out a successful installation.
         •   Server Hardware Checklist for Oracle Database Client Installation
             Use this checklist to check hardware requirements for Oracle Database Client.
         •   Operating System Checklist for Oracle Database Client Installation
             Use this checklist to check minimum operating system requirements for Oracle Database
             Client.
         •   Server Configuration Checklist for Oracle Database Client Installation
             Use this checklist to check minimum server configuration requirements for Oracle
             Database Client installations.
         •   Oracle User Environment Configuration Checklist for Oracle Database Client Installation
             Use this checklist to plan operating system users, groups, and environments for Oracle
             Database Client management.
         •   Storage Checklist for Oracle Database Client Installation
             Use this checklist to review storage minimum requirements and assist with configuration
             planning.
         •   Installer Planning Checklist for Oracle Database Client Installation
             Use this checklist to prepare yourself before starting Oracle Universal Installer.


Server Hardware Checklist for Oracle Database Client
Installation
         Use this checklist to check hardware requirements for Oracle Database Client.

         Table 1-1   Server Hardware Checklist for Oracle Database Client Installation

          Check                          Task
          Server Make and Architecture   Confirm that server make, model, core architecture, and host bus
                                         adaptors (HBA) or network interface controllers (NIC) are supported to
                                         run with Oracle Database and Oracle Grid Infrastructure. If you are
                                         installing from a DVD, then ensure the server has a DVD drive.
          Minimum RAM                    2 GB RAM recommended
          Minimum network connectivity   Server is connected to a network
          Video Adapter                  256 colors
          Server Display Cards           At least 1024 x 768 display resolution, which Oracle Universal Installer
                                         requires




                                                                                                              1-1
                                                                                                            Chapter 1
                                                   Operating System Checklist for Oracle Database Client Installation




Operating System Checklist for Oracle Database Client
Installation
          Use this checklist to check minimum operating system requirements for Oracle Database
          Client.

          Table 1-2 Operating System Checklist for Oracle Database Client Installation on
          Microsoft Windows

          Item                          Task
          Operating system general      Oracle Database Client for Windows x64 is supported on the following
          requirements                  operating system versions:
                                        •   Windows 8.1 x64 - Pro and Enterprise editions
                                        •   Windows 10 x64 - Pro, Enterprise, and Education editions
                                        •   Windows 11 x64 - Pro, Enterprise, and Education editions
                                        •   Windows Server 2012 R2 x64 - Standard, Datacenter, Essentials,
                                            and Foundation editions
                                        •   Windows Server 2016 x64 - Standard, Datacenter, and Essentials
                                            editions
                                        •   Windows Server 2019 x64 - Standard, Datacenter, and Essentials
                                            editions
                                        •   Windows Server 2022 x64 - Standard, Datacenter, and Essentials
                                            editions
                                        •   Windows Server 2025 x64 - Standard, Datacenter, and Essentials
                                            editions



                                                                    Note:
                                                                    Windows 11 x64 - Pro, Enterprise, and
                                                                    Education editions and Windows Server
                                                                    2022 x64 - Standard, Datacenter, and
                                                                    Essentials editions are supported starting
                                                                    with Oracle Database 19c Release
                                                                    Update (19.13) or later.




Server Configuration Checklist for Oracle Database Client
Installation
          Use this checklist to check minimum server configuration requirements for Oracle Database
          Client installations.

          Table 1-3   Server Configuration Checklist for Oracle Database Client Installation

          Check                         Task
          Disk space allocated to the   At least 130 MB of space in the temporary directory
          temporary directory




                                                                                                                1-2
                                                                                                                 Chapter 1
                                   Oracle User Environment Configuration Checklist for Oracle Database Client Installation



         Table 1-3     (Cont.) Server Configuration Checklist for Oracle Database Client Installation

          Check                            Task
          Swap space allocation relative   Double the amount of RAM
          to RAM
          Groups and Users                 Oracle recommends that you create groups and user accounts
                                           required for your security plans before starting installation. Installation
                                           owners have resource limits settings and other requirements. Group
                                           and user names must use only ASCII characters.
          Mount point paths for the        Oracle recommends that you create an Optimal Flexible Architecture
          software binaries                configuration as described in the appendix "Optimal Flexible
                                           Architecture" in Oracle Database Installation Guide for Microsoft
                                           Windows for your platform.
          Ensure that the Oracle home    The ASCII character restriction includes installation owner user names,
          (the Oracle home path that you which are used as a default for some home paths, as well as other
          select for Oracle Database)    directory names you may select for paths.
          uses only ASCII characters.
          Set locale (if needed)           Specify the language and the territory, or locale, in which you want to
                                           use Oracle components. A locale is a linguistic and cultural
                                           environment in which a system or program is running. National
                                           Language Support (NLS) parameters determine the locale-specific
                                           behavior on both servers and clients. The locale setting of a
                                           component determines the language of the user interface of the
                                           component, and the globalization behavior, such as date and number
                                           formatting.



Oracle User Environment Configuration Checklist for Oracle
Database Client Installation
         Use this checklist to plan operating system users, groups, and environments for Oracle
         Database Client management.

         Table 1-4 Oracle User Environment Configuration Checklist for Oracle Database Client
         Installation

          Check                            Task
          Oracle Inventory and             The Oracle Inventory directory is the central inventory of Oracle
          ORA_INSTALL Group                software installed on your system. You do not need to create the Oracle
          Requirements                     central inventory or the ORA_INSTALL group as Oracle Universal
                                           Installer creates it for you.
          Create operating system          Create operating system groups and users depending on your security
          groups and users for standard    requirements, as described in this install guide.
          or role-allocated system
          privileges
          Unset Oracle Software            If you have an existing installation on your system, and use the same
          Environment Variables            user account to install this installation, then unset the ORACLE_HOME,
                                           ORACLE_BASE, ORACLE_SID, TNS_ADMIN environment variables and
                                           any other environment variable set for the Oracle installation user that
                                           is connected with Oracle software homes.




                                                                                                                     1-3
                                                                                                              Chapter 1
                                                               Storage Checklist for Oracle Database Client Installation




Storage Checklist for Oracle Database Client Installation
          Use this checklist to review storage minimum requirements and assist with configuration
          planning.


          Table 1-5   Storage Checklist for Oracle Database Client Installation

          Check                          Task
          Minimum local disk storage     At least 350 MB for an Instant Client installation
          space for Oracle software      At least 1536 MB for Administrator installation
                                         At least 1024 MB for Runtime installation
                                         At least 180 MB for Custom installation
          Recommended file system        Ensure that you have one of the following storage options available:
                                         •   Oracle ASM Cluster File System (Oracle ACFS)
                                         •   Oracle Automatic Storage Management (Oracle ASM)
                                         •   NTFS File System or Resilient File System (ReFS)
                                         The database files must be placed on Oracle ASM if you are using
                                         Oracle ACFS; otherwise they can be placed on NTFS or ReFS.



Installer Planning Checklist for Oracle Database Client
Installation
          Use this checklist to prepare yourself before starting Oracle Universal Installer.

          Table 1-6   Installer Planning Checklist for Oracle Database Client Installation

          Check                          Task
          Read the Release Notes         Review release notes for your platform, which are available for your
                                         release at the following URL:
                                         http://docs.oracle.com/en/database/database.html
          Reviewing the Licensing        You are permitted to use only those components in the Oracle
          Information                    Database media pack for which you have purchased licenses.
          Review Oracle Support          New platforms and operating system software versions might be
          Certification Matrix           certified after this guide is published, review the certification matrix on
                                         the My Oracle Support website for the most up-to-date list of certified
                                         hardware platforms and operating system versions:
                                         https://support.oracle.com/
                                         You must register online before using My Oracle Support. After logging
                                         in, from the menu options, select the Certifications tab. On the
                                         Certifications page, use the Certification Search options to search by
                                         Product, Release, and Platform. You can also search using the
                                         Certification Quick Link options such as Product Delivery, and
                                         Lifetime Support.




                                                                                                                   1-4
                                                                                                         Chapter 1
                                               Installer Planning Checklist for Oracle Database Client Installation



Table 1-6    (Cont.) Installer Planning Checklist for Oracle Database Client Installation

Check                             Task
Decide the client installation    You can choose one of the following installation types when installing
type                              Oracle Database Client:
                                  Instant Client: Enables you to install only the shared libraries required
                                  by Oracle Call Interface (OCI), Oracle C++ Call Interface (OCCI),
                                  Pro*C, or Java database connectivity (JDBC) OCI applications. This
                                  installation type requires much less disk space than the other Oracle
                                  Database Client installation types. For more information about Oracle
                                  Database Instant Client see the following URL:
                                  http://www.oracle.com/technetwork/database/features/instant-client/
                                  index.html
                                  Administrator: Enables applications to connect to an Oracle Database
                                  instance on the local system or on a remote system. It also provides
                                  tools that enable you to administer Oracle Database.
                                  Runtime: Enables applications to connect to an Oracle Database
                                  instance on the local system or on a remote system.
                                  Custom: Enables you to select individual components from the list of
                                  Administrator and Runtime components.
Decide if you need 32-bit client The 64-bit client software does not contain any 32-bit client binaries. If
software                         you require 32-bit client binaries on 64-bit platforms, then install the 32-
                                 bit binaries from the respective 32-bit client software. However, when
                                 you install the 32-bit client binaries on 64-bit platforms, the installer
                                 checks for the existence of 32-bit software. For more information refer
                                 to My Oracle Support notes 1243374.1 and 781432.1 if you intend to
                                 install both 32-bit and 64-bit Oracle Database Client software on the
                                 same system:
                                 •    https://support.oracle.com/CSP/main/article?
                                      cmd=show&type=NOT&id=1243374.1
                                 •    https://support.oracle.com/CSP/main/article?
                                      cmd=show&type=NOT&id=781432.1
Obtain your My Oracle Support During installation, you require a My Oracle Support user name and
account information.          password to configure security updates, download software updates,
                              and other installation tasks. You can register for My Oracle Support at
                              the following URL:
                                  https://support.oracle.com/
Oracle Database Client and        For information about interoperability between Oracle Database Client
Oracle Database                   and Oracle Database releases, see My Oracle Support Note 207303.1:
interoperability                  https://support.oracle.com/epmos/faces/DocContentDisplay?
                                  id=207303.1
Unsupported Oracle Database       The following 32-bit Oracle Database Client components are not
Client Components                 supported on Windows:
                                  •    Oracle Connection Manager
                                  •    Oracle Net Listener




                                                                                                              1-5
2
Oracle Database Client Preinstallation Tasks
         Learn about the tasks that you must complete before you start Oracle Universal Installer.
         •   Oracle Database Client Minimum Hardware Requirements
             Learn about the hardware component and hard disk space requirements.
         •   Oracle Database Client Software Requirements
             Learn about the Oracle Database Client software requirements.
         •   Creating Oracle Home User
             During Oracle Database Client installation, you can specify an optional Oracle Home User
             associated with the Oracle home.
         •   Creating Users, Groups and Environments for Oracle Database Client
             Before installation, create operating system groups, users, and configure user
             environments.
         •   Managing User Accounts with User Account Control
             To ensure that only trusted applications run on your computer, the Windows operating
             systems supported for Oracle Database Client provide User Account Control.
         •   Remote Desktop Services
             Oracle supports installing, configuring, and running Oracle Database Client through
             Remote Desktop Services.
         •   Microsoft Windows Servicing Options
             On Microsoft Windows 10 systems, Microsoft introduced new servicing options.
         •   Default Share Configuration Requirement
             The prerequisite checks during Oracle Database Client installation require that the system
             drive on your computer has default share configured on it.
         •   Installation Requirements for Web Browsers
             Web browsers are required only if you intend to use Oracle Enterprise Manager Database
             Express and Oracle Enterprise Manager Cloud Control. Web browsers must support
             JavaScript, and the HTML 4.0 and CSS 1.0 standards.
         •   Microsoft Hyper-V Requirements
             Microsoft Hyper-V enables you to create and manage a virtualized computing environment
             by running multiple operating systems simultaneously on a single computer and isolate
             operating systems from each other.
         •   Enabling Oracle Instant Client Code Signing
             Starting with Oracle Database Client 19c (19.22), you can verify the code sign for Oracle
             Instant Client zips to ensure the integrity of the packages before you deploy them in your
             environments.


Oracle Database Client Minimum Hardware Requirements
         Learn about the hardware component and hard disk space requirements.
         •   Hardware Component Requirements for Windows x64
             The following table lists the hardware components that are required for Oracle Database
             Client on Windows x64.




                                                                                                     2-1
                                                                                                        Chapter 2
                                                            Oracle Database Client Minimum Hardware Requirements

          •   Hard Disk Space Requirements
              Oracle strongly recommends that you install the Oracle database home (Oracle database
              binaries, trace files, and so on) on Oracle Automatic Storage Management Cluster File
              System (Oracle ACFS) or New Technology File System (NTFS).
          •   Verifying Hardware Requirements
              Use this procedure to verify your server configuration requirements.


Hardware Component Requirements for Windows x64
          The following table lists the hardware components that are required for Oracle Database Client
          on Windows x64.

          Table 2-1    Windows x64 Hardware Requirements

          Requirement                         Value
          System Architecture                 Processor: AMD64 and Intel EM64T
          Physical memory (RAM)               128 MB minimum
          Virtual memory (swap)               Double the amount of RAM
          Disk space                          Total ranges from 430 - 1570 MB
          Video adapter                       256 colors
          Screen Resolution                   1024 X 768 minimum



                 Note:
                 Oracle provides 32-bit and 64-bit versions of Oracle Database Client for Windows.
                 Oracle certifies 32-bit Oracle Database Client running on Windows x64 only.



Hard Disk Space Requirements
          Oracle strongly recommends that you install the Oracle database home (Oracle database
          binaries, trace files, and so on) on Oracle Automatic Storage Management Cluster File System
          (Oracle ACFS) or New Technology File System (NTFS).
          The database files must be placed on Oracle Automatic Storage Management (Oracle ASM) if
          using Oracle ACFS or on NTFS. Oracle recommends usage of Oracle ACFS and Oracle ASM
          or NTFS to ensure security of these files.
          The NTFS system requirements listed are more accurate than the hard disk values reported by
          the Oracle Universal Installer Summary window. The Summary window does not include
          accurate values for disk space, the space required to create a database, or the size of
          compressed files that are expanded on the hard drive.
          The hard disk requirements for Oracle Database Client components includes space to install
          Java Runtime Environment (JRE) and Oracle Universal Installer on the partition where the
          operating system is installed. If sufficient space is not available, the installation fails and an
          error message appears.
          The following table lists the disk space requirements on NTFS. The values in this table include
          the starter database.




                                                                                                            2-2
                                                                                                                   Chapter 2
                                                                      Oracle Database Client Minimum Hardware Requirements



Table 2-2    Windows x64 Disk Space Requirements on NTFS

Installation Type              TEMP Space          Directory:\ Program                 Oracle Home         Total
                                                   Files\Oracle\Inventory
Instant Client                 136 MB              166 KB                              361 MB              485 MB
Administrator                  140 MB              1.6 MB                              1.85 GB             1635 MB
Runtime                        130 MB              1.55 MB                             1.35 GB             1235 MB
Custom (all components         145 MB              2.0 MB *                            1.86 GB *           1635 MB *
installed)

                    * Disk space requirements vary, depending on the components selected.



                            Note:
                            If you want to configure only the Instant Client Light component of Instant Client, then
                            you need 30–32 MB of disk space to store the related files.


                    Related Topics
                    •    Configuring Instant Client Light
                         To configure Instant Client Light, you must make it the default instead of Instant Client.


Verifying Hardware Requirements
                    Use this procedure to verify your server configuration requirements.
                    To ensure that the system meets these requirements, follow these steps:
                    1.   Determine the physical RAM size.
                         For example, on a computer running Windows Server 2012 R2, click System and
                         Security, then click System.
                         If the size of the physical RAM installed in the system is less than the required size, then
                         you must install more memory before continuing.
                    2.   Determine the size of the configured virtual memory (also known as paging file size).
                         For example, on a computer running Windows Server 2012 R2, click System and
                         Security, then click System, click Advanced System Settings, click the Advanced tab
                         on System Properties page, and then click Settings in the Performance section. Then
                         select the Advanced tab on Performance Options page.
                         The virtual memory is listed in the Virtual Memory section.
                         If necessary, see your operating system documentation for information about how to
                         configure additional virtual memory.
                    3.   Determine the amount of free disk space on the system.
                         For example, on a computer running Windows Server 2012 R2, right-click My Computer
                         and click Open.
                    4.   Determine the amount of disk space available in the temp directory. This is equivalent to
                         the total amount of free disk space, minus what is required for the Oracle software to be
                         installed.




                                                                                                                       2-3
                                                                                                          Chapter 2
                                                                     Oracle Database Client Software Requirements

               On Windows x64, if there is less than 130 MB of disk space available in the temp directory,
               then delete all unnecessary files. If the temp disk space is still less than 130 MB, then set
               the TEMP or TMP environment variable to point to a different hard drive location.
               For example, to change the environment variables on a computer running Windows Server
               2012 R2, click System and Security, then click System, click Advanced System
               Settings, click the Advanced tab on System Properties page, and then click Environment
               Variables.


Oracle Database Client Software Requirements
           Learn about the Oracle Database Client software requirements.
           •   Oracle Database Client Software Requirements
               Lists the software requirements for Oracle Database client.
           •   Instant Client Light Language and Character Set Requirements
               Describes the requirements to use Instant Client Light.


Oracle Database Client Software Requirements
           Lists the software requirements for Oracle Database client.

           Table 2-3   Windows x64 Software Requirements

           Requirement                    Value
           Operating System               Oracle Database for Windows x64 is supported on the following
                                          operating systems:
                                          •   Windows 8.1 x64 - Pro and Enterprise editions
                                          •   Windows 10 x64 - Pro, Enterprise, and Education editions
                                          •   Windows 11 x64 - Pro, Enterprise, and Education editions
                                          •   Windows Server 2012 R2 x64 - Standard, Datacenter, Essentials,
                                              and Foundation editions
                                          •   Windows Server 2016 x64 - Standard, Datacenter, and Essentials
                                              editions
                                          •   Windows Server 2019 x64 - Standard, Datacenter, and Essentials
                                              editions
                                          •   Windows Server 2022 x64 - Standard, Datacenter, and Essentials
                                              editions
                                          •   Windows Server 2025 x64 - Standard, Datacenter, and Essentials
                                              editions
                                          Note:
                                          •   Windows Multilingual User Interface Pack is supported.
                                          •   The Server Core option is not supported.
                                          •   Windows 11 x64 - Pro, Enterprise, and Education editions and
                                              Windows Server 2022 x64 - Standard, Datacenter, and Essentials
                                              editions are supported starting with Oracle Database 19c Release
                                              Update (19.13) or later.




                                                                                                              2-4
                                                                                                            Chapter 2
                                                                       Oracle Database Client Software Requirements



           Table 2-3       (Cont.) Windows x64 Software Requirements

           Requirement                    Value
           Virtualization                 Oracle certifies the following virtualization technologies with Oracle
                                          Database Client on Windows:
                                          •    Oracle VM Server
                                          •    Microsoft Hyper-V
                                          For more detailed information on certified Oracle VM Server
                                          combinations, check My Oracle Support note 464754.1. For more
                                          information on certified Hyper-V combinations, you can visit:
                                          http://www.oracle.com/technetwork/database/
                                          virtualizationmatrix-172995.html
           Compiler and SDK               The following component is supported only with Microsoft Visual C++
                                          2013 Update 5:
                                          •    Pro*C/C++ : Use Microsoft Visual C++ 2013, to convert the
                                               Pro*C/C++ files into C/C++ files, and then use Microsoft Visual C+
                                               + 2017 Update 6 or later to further build them.
                                          The following components are supported with the compilers based on
                                          Microsoft Visual C++ 2017 Update 6 or later and Intel C++ 17.0 Update
                                          8, and Microsoft Visual C++ 2017 Update 6 or later SDK:
                                          •   Oracle Call Interface
                                          •   External callouts
                                          •   Oracle XML Developer's Kit (XDK)
                                          Oracle C++ Call Interface supports:
                                          •   Compilers based on Microsoft Visual C++ 2017 Update 6 or later
                                              and Intel C++ 17.0 Update 8 with Microsoft Visual Studio 2017
                                              STLs
                                          Pro*COBOL supports:
                                          •   Micro Focus Visual COBOL 2.2 - Update 2
                                          •   Micro Focus Visual COBOL (Version 6)
           Network Protocol               The Oracle Net foundation layer uses Oracle protocol support to
                                          communicate with the following industry-standard network protocols:
                                          •   TCP/IP
                                          •   TCP/IP with SSL
                                          •   Named Pipes
           Oracle Database                To connect with Oracle Database Client 19c, the following are required:
                                          •   Oracle Database Server is version 11.2.0.4 or later.
                                          •   If the earlier Oracle Database Server is running on the same
                                              computer as Oracle Database Client 19c, a bequeath connection
                                              cannot be used.
                                          Oracle recommends upgrading Oracle Database to the latest patchset
                                          (11.2.0.4 or later). You can download the patchset from the Patches
                                          and Updates section of My Oracle Support at
                                          https://support.oracle.com
           Unzip utility                  Unzip 6.0 or later.
                                          Unzip is required to extract the image files for Oracle Database and
                                          Oracle Grid Infrastructure installations.


Instant Client Light Language and Character Set Requirements
           Describes the requirements to use Instant Client Light.




                                                                                                                   2-5
                                                                                              Chapter 2
                                                           Oracle Database Client Software Requirements

In addition to the requirements, if you plan to use Instant Client Light, then the applications
must use the following languages and character sets:
•   Language: Any language that Oracle supports, but only US English error messages
    returns errors on the client side.
•   Territory: Any territory that Oracle supports.
•   Character sets:
    –   Single byte
        *   US7ASCII
        *   WE8DEC
        *   WE8ISO8859P1
        *   WE8MSWIN1252
    –   Unicode
        *   UTF8
        *   AL16UTF16
        *   AL32UTF8
        Instant Client Light can connect to databases having one of the following database
        character sets. If a character set other than those in the list is used as the client or
        database character set, then an error is returned.
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
        The language, territory, and character sets are determined by the NLS_LANG parameter,
        which is stored in the registry under the
        HKEY_LOCAL_MACHINE\SOFTWARE\ORACLE\KEY_HomeName\NLS_LANG subkey, where
        HomeName is the unique name identifying the Oracle home. The Registry setting is
        overridden by the NLS_LANG environment variable.




                                                                                                   2-6
                                                                                                  Chapter 2
                                                                                  Creating Oracle Home User



                        Note:
                        AL32UTF8 is the Oracle Database character set that is appropriate for
                        XMLType data. It is equivalent to the IANA registered standard UTF-8
                        encoding, which supports all valid XML characters.
                        Do not confuse Oracle Database database character set UTF8 (no hyphen)
                        with database character set AL32UTF8 or with character encoding UTF-8.
                        Database character set UTF8 has been superseded by AL32UTF8. Do not
                        use UTF8 for XML data. UTF8 supports only Unicode version 3.1 and earlier;
                        it does not support all valid XML characters. AL32UTF8 has no such
                        limitation.
                        Using database character set UTF8 for XML data potentially causes an
                        irrecoverable error or affects security negatively. If a character that is not
                        supported by the database character set appears in an input-document
                        element name, then a replacement character (usually "?") is substituted for it.
                        This terminates parsing and raises an exception.



Creating Oracle Home User
         During Oracle Database Client installation, you can specify an optional Oracle Home User
         associated with the Oracle home.
         For example, assume that you use an Administrator user named OraSys to install the software
         (Oracle Installation user), then you can specify the ORADOMAIN\OraDb domain user as the
         Oracle Home User for this installation. The specified Oracle home domain user must exist
         before you install the Oracle Database Client software.
         The Oracle Home User can be either the Windows Built-in Account (LocalService) or a
         Windows User Account. This account is used for running the Windows services for the Oracle
         home. Do not log in using this account to perform administrative tasks.
         Windows User Account can be a Windows Local User, Windows Domain User, Managed
         Services Account (MSA), or Group Managed Services Account (gMSA). Starting with Oracle
         Database 19c, Group Managed Services Account (gMSA) is introduced as an additional
         option.
         Using Windows built-in account, MSA, or gMSA enables you to install Oracle Database Client,
         and create and manage Database services without passwords.
         If you specify an existing user as the Oracle Home User, then the Windows User Account you
         specify can either be a Windows Domain User or a Windows Local User. If you specify a non-
         existing user as the Oracle Home User, then the Windows User Account you specify must be a
         Windows Local User. The new user is then created during installation and the created user is
         denied interactive logon privileges to the Windows computer. However, a Windows
         administrator can manage this account like any other Windows account.
         For enhanced security, Oracle recommends that you use the standard Windows User Account
         or Windows Built-in Account (LocalService), which is not an administrator account, to install
         Oracle Database Client.




                                                                                                       2-7
                                                                                                        Chapter 2
                                               Creating Users, Groups and Environments for Oracle Database Client



                Note:
                You cannot change the Oracle Home User after the installation is complete. If you
                must change the Oracle Home User, then you must reinstall the Oracle Database
                Client software.



         When you specify an Oracle Home User, the installer configures that user as the Oracle
         Service user for all software services that run from the Oracle home. The Oracle Service user
         is the operating system user that the Oracle software services run as, or the user from which
         the services inherit privileges.
         Silent installation is enhanced to support password prompt for the Oracle Home User. So,
         customers and independent software vendors (ISV) can use response files without hard coding
         the password into the source code.


Creating Users, Groups and Environments for Oracle Database
Client
         Before installation, create operating system groups, users, and configure user environments.
         Oracle Universal Installer creates other groups, such as, ORA_INSTALL, ORA_CLIENT_LISTENERS,
         ORA_HOMENAME_SVCSIDS during installation and you must not change these groups,
         memberships, and ACLs associated with various Oracle created groups.
         The groups that are created are explained as follows:
         •   ORA_INSTALL: This is a system wide group for Oracle's internal use, which is
             automatically populated with Oracle Home users. If a database server is running on this
             system, it grants dupsocket privilege to the group's members to allow listeners to operate.
             If no database server is present, this group is not used.
         •   ORA_CLIENT_LISTENERS: This group is for internal Oracle use. It contains listeners
             installed on client homes through custom installs. If a database server is running on this
             system, it grants dupsocket privilege to the group's members to allow listeners to work. If
             no database server is present, this group is not used.
         •   ORA_HOMENAME_SVCSIDS: This group is for Oracle's internal use and is automatically
             populated. It contains Service SIDs for all Windows services (e.g. Oracle Services for
             MTS, Listener, and Connection Manager) on client homes installed through custom
             installs. This group is granted full control to the specific client Oracle Home and client
             Oracle Base.
         •   ORA_DBA and ORA_HOMENAME_DBA: If the system is only used for clients,
             membership provides start/stop privileges to Oracle Windows services running from client
             homes. ORA_DBA members are granted start/stop privileges for all Oracle Windows services
             on the system, while membership in ORA_HOMENAME_DBA gives start/stop privileges to
             Oracle Windows services running from the specific home.




                                                                                                            2-8
                                                                                                       Chapter 2
                                                                Managing User Accounts with User Account Control




Managing User Accounts with User Account Control
         To ensure that only trusted applications run on your computer, the Windows operating systems
         supported for Oracle Database Client provide User Account Control.
         If you have enabled this security feature, then, depending on how you have configured it,
         Oracle Universal Installer prompts you for either your consent or your credentials when
         installing Oracle Database Client. Provide either the consent or your Windows Administrator
         credentials as appropriate.
         If User Account Control is enabled, and you are logged in as the local Administrator, then you
         can successfully run each of these commands. However, if you are logged in as "a member of
         the Administrator group," then you must explicitly start these tasks with Windows Administrator
         privileges. All the Oracle shortcuts that require Administrator privileges start as "Administrator"
         automatically when you click the shortcuts. However, if you run the above tools from a
         Windows command prompt, you must run them from an Administrator command prompt.



                 Note:
                 You must have Administrator privileges to run some Oracle tools, such as Database
                 Configuration Assistant, Oracle Net Configuration Assistant, and OPatch, or to run
                 any tool or application that writes to any directory within the Oracle home.
                 OPatch does not have a shortcut and has to be run from an Administrator command
                 prompt.



         To start a command prompt window with Windows Administrator privileges:
         1.   On your desktop, create a shortcut for the command prompt window. An icon for that
              shortcut appears on the desktop.
         2.   Right-click the icon for the newly created shortcut, and specify Run as administrator.
         When you open this window, the title bar reads Administrator: Command Prompt. Commands
         run from within this window are run with Administrator privileges.



                 See Also:
                 Oracle Database Administrator’s Reference for Microsoft Windows




Remote Desktop Services
         Oracle supports installing, configuring, and running Oracle Database Client through Remote
         Desktop Services.
         To install Oracle Database Client, Oracle recommends that you start all configuration tools
         from the Remote Desktop server console session of the server.
         Platform-specific support information is as follows:
         •    Windows client operating systems: The Remote Desktop is only available in Single User
              Mode.



                                                                                                           2-9
                                                                                                       Chapter 2
                                                                             Microsoft Windows Servicing Options

         •   Windows server operating systems: You can have multiple Remote Desktop sessions.



                See Also:

                •   The Microsoft website for more information about Remote Desktop Services
                    http://www.microsoft.com/
                •   The My Oracle Support website for the latest Terminal Services and Remote
                    Desktop Services information
                    https://support.oracle.com/



Microsoft Windows Servicing Options
         On Microsoft Windows 10 systems, Microsoft introduced new servicing options.
         Oracle Database supports the following servicing options:
         •   Semi-Annual Channel
         •   Long-Term Servicing Channel
         Other servicing options, such as Semi-Annual Channel (Targeted) are not supported. Oracle
         previously supported the former Windows servicing options, such as the Current Branch for
         Business (CBB) and Long-Term Servicing Branch (LTSB).



                Note:
                Oracle supports its database products on these channel releases that become
                generally available for as long as Microsoft supports the channel version. Once
                Microsoft support ends for a specific channel version, Oracle's support ends for that
                version as well. Oracle may recommend that customers wait until relevant Oracle
                patches have been released before upgrading to a particular channel version. Oracle
                may recommend or discourage the installation of a specific channel version if it
                significantly affects the operation of Oracle software, either positively or negatively. If
                such a statement is deemed necessary, Oracle will disseminate this statement on My
                Oracle Support.



Default Share Configuration Requirement
         The prerequisite checks during Oracle Database Client installation require that the system
         drive on your computer has default share configured on it.
         Use the net use command to verify, for example:
         C:\> net use \\hostname\c$
         The command completed successfully

         Ensure that the current user, the user in the Administrator group, has all the privileges on the
         default share.




                                                                                                          2-10
                                                                                                             Chapter 2
                                                                            Installation Requirements for Web Browsers




Installation Requirements for Web Browsers
            Web browsers are required only if you intend to use Oracle Enterprise Manager Database
            Express and Oracle Enterprise Manager Cloud Control. Web browsers must support
            JavaScript, and the HTML 4.0 and CSS 1.0 standards.
            https://support.oracle.com
            Related Topics
            •    Oracle Enterprise Manager Cloud Control Basic Installation Guide


Microsoft Hyper-V Requirements
            Microsoft Hyper-V enables you to create and manage a virtualized computing environment by
            running multiple operating systems simultaneously on a single computer and isolate operating
            systems from each other.
            Microsoft Hyper-V enables built-in integration services for supported guest operating systems
            to improve the integration between a computer and a virtual machine.
            Oracle Database supports Hyper-V Dynamic Memory.



                    Note:
                    Microsoft Hyper-V for specific Oracle Database and Microsoft Hyper-V certified
                    combinations




Enabling Oracle Instant Client Code Signing
            Starting with Oracle Database Client 19c (19.22), you can verify the code sign for Oracle
            Instant Client zips to ensure the integrity of the packages before you deploy them in your
            environments.
            •    Verifying Signed Oracle Instant Client Zip Files
                 Use the Java utility jarsigner to verify the integrity of your Oracle Instant Client zip files.


Verifying Signed Oracle Instant Client Zip Files
            Use the Java utility jarsigner to verify the integrity of your Oracle Instant Client zip files.

            To verify the integrity of the Oracle Instant Client installation zip files before you extract the
            installation files:
            1.   Go to the directory where you have downloaded the zip file.
            2.   Run the jarsigner command with the -verify option to quickly check your installation
                 zip file:

                 jarsigner -verify instant_client_zip_file




                                                                                                                 2-11
                                                                                              Chapter 2
                                                            Enabling Oracle Instant Client Code Signing

     For example, to check the Oracle Instant Client Basic package zip file for Linux for ARM
     (aarch64):

     jarsigner -verify instantclient-basic-windows.x64-19.22.0.0.0dbru.zip
     jar verified.

3.   If you want detailed certificate information, then use the -verify option along with the -
     verbose:summary and -certs options. For example:

     jarsigner -verify -verbose:summary -certs instantclient-basic-
     windows.x64-19.22.0.0.0dbru.zip

For more jarsigner options, type jarsigner -h or review the jarsigner reference
documentation.




                                                                                                 2-12
3
Installing Oracle Database Client
           Learn how to run the installer to install Oracle Database Client.
           •   Installation Considerations for Oracle Database Client
               The Oracle Database Client software is available on the Oracle Technology Network (OTN)
               website. In most cases, Oracle Universal Installer provides a graphical user interface (GUI)
               to install the software.
           •   About Image-Based Oracle Database Client Installation
               Starting with Oracle Database 19c, installation and configuration of Oracle Database Client
               software is simplified with image-based installation.
           •   Accessing the Installation Software
               The Oracle Database Client software is available on an installation media or you can
               download it from the Oracle Technology Network website or Oracle Software Delivery
               Cloud website.
           •   Installing the Oracle Database Client Software
               These topics explain how to run the Setup Wizard to perform most database client
               installations.


Installation Considerations for Oracle Database Client
           The Oracle Database Client software is available on the Oracle Technology Network (OTN)
           website. In most cases, Oracle Universal Installer provides a graphical user interface (GUI) to
           install the software.
           However, you can also use the Oracle Universal Installer to complete silent or response file
           installations, without using the GUI.
           •   Creating the Oracle Base Directory
               If you install Oracle Database Client on a computer with no other Oracle software installed,
               Oracle Universal Installer creates an Oracle base directory for you.
           •   Multiple Oracle Home Components
               You can install all Oracle components in multiple Oracle homes on the same computer.


Creating the Oracle Base Directory
           If you install Oracle Database Client on a computer with no other Oracle software installed,
           Oracle Universal Installer creates an Oracle base directory for you.
           If Oracle software is already installed, one or more Oracle base directories already exist. In the
           latter case, Oracle Universal Installer offers you a choice of Oracle Base directories into which
           you can install Oracle Database Client.
           You are not required to create an Oracle base directory before installation, but you can do so if
           you want. If a Windows User Account is used as the Oracle Home User, it can only share an
           Oracle base with other Oracle homes with the same Windows user account. If Windows Built-
           in Account is specified as the Oracle Home User, it can only share an Oracle base with other
           client Oracle homes using a Windows Built-in Account.




                                                                                                          3-1
                                                                                                         Chapter 3
                                                             About Image-Based Oracle Database Client Installation

          Oracle Database Client 19c cannot share an Oracle base with Oracle homes from earlier
          database versions, such as Oracle Database 18c and earlier.



                 Note:
                 You can choose to create a new Oracle base directory, even if other Oracle base
                 directories exist on the system.



Multiple Oracle Home Components
          You can install all Oracle components in multiple Oracle homes on the same computer.
          However, some components can only support one active instance at a time. The current
          (latest) installation renders the previous one inactive. The component Oracle Provider for OLE
          DB supports one active instance at a time.


About Image-Based Oracle Database Client Installation
          Starting with Oracle Database 19c, installation and configuration of Oracle Database Client
          software is simplified with image-based installation.
          To install Oracle Database Client, create the new Oracle home, extract the image file into the
          newly-created Oracle home, and run the setup wizard to register the Oracle Database product.
          You must extract the image software (client_home.zip) into the directory where you want
          your Oracle Database Client home to be located, and then run the Setup Wizard to start the
          Oracle Database Client installation and configuration. Oracle recommends that the Oracle
          home directory path you create is in compliance with the Oracle Optimal Flexible Architecture
          recommendations.
          Using image-based installation, you can install Oracle Database Client 32-bit and 64-bit
          configurations of the Administrator installation type.
          As with Oracle Database and Oracle Grid Infrastructure image file installations, Oracle
          Database Client image installations simplify Oracle Database Client installations and ensure
          best practice deployments. Oracle Database Client installation binaries continue to be
          available in the traditional format as non-image zip files.


Accessing the Installation Software
          The Oracle Database Client software is available on an installation media or you can download
          it from the Oracle Technology Network website or Oracle Software Delivery Cloud website.
          To install the software from the hard disk, you must either download it and unpack it, or copy it
          from the installation media, if you have it.
          •   Installing from a Remote DVD Drive
              If the computer where you want to install Oracle Database Client does not have a DVD
              drive, then you can perform the installation from a remote DVD drive.
          •   Installing on Remote Computers Through Remote Access Software
              If you want to install and run Oracle Database Client on a remote computer (that is, the
              remote computer has the hard drive and runs Oracle Database Client components), but
              you do not have physical access to the computer, you still can perform the installation on
              the remote computer.




                                                                                                             3-2
                                                                                                           Chapter 3
                                                                                 Accessing the Installation Software

            •    Downloading Oracle Software
                 Select the method you want to use to download the software.
            •    Copying the Oracle Database Client Software to a Hard Disk
                 Oracle recommends that you copy the installation software to the hard disk to enable the
                 installation to run faster.


Installing from a Remote DVD Drive
            If the computer where you want to install Oracle Database Client does not have a DVD drive,
            then you can perform the installation from a remote DVD drive.


            •    Step 1: On the Remote Computer, Share the DVD Drive
                 The remote DVD drive must allow shared access.
            •    Step 2: On the Local Computer, Map the DVD Drive
                 Use this procedure to map the DVD drive on the local computer.

Step 1: On the Remote Computer, Share the DVD Drive
            The remote DVD drive must allow shared access.
            To set this up, perform these steps on the remote computer that has the DVD drive:
            1.   Log in to the remote computer as an Administrator user.
            2.   Start Windows Explorer.
            3.   Right-click the DVD drive letter and select Sharing (or Sharing and Security).
            4.   Click the Sharing tab and do the following:
                 a.   Select Share this folder.
                 b.   In Share name, give it a share name such as dvd. You use this name when you map
                      the DVD drive on the local computer.
                 c.   Click Permissions. You need at least read permission for the user who accesses the
                      drive to install Oracle Database.
                 d.   Click OK when you are finished.
            5.   Insert the Oracle Database installation media into the DVD drive.

Step 2: On the Local Computer, Map the DVD Drive
            Use this procedure to map the DVD drive on the local computer.
            Perform these steps on the local computer to map a remote DVD drive and to run Oracle
            Universal Installer from the mapped drive:
            1.   Map the remote DVD drive.
                 a.   Start Windows Explorer on the local computer.
                 b.   From the Tools menu, select Map Network Drive to display the Map Network Drive
                      dialog box.
                 c.   Select a drive letter to use for the remote DVD drive.
                 d.   In Folder, enter the location of the remote DVD drive using the following format:
                      \\remote_hostname\share_name




                                                                                                               3-3
                                                                                                          Chapter 3
                                                                                Accessing the Installation Software

                      where:
                      •   remote_hostname is the name of the remote computer with the DVD drive.
                      •   share_name is the share name that you use when you map the DVD drive on the
                          local computer. For example:
                          \\computer2\dvd

                 e.   If you must connect to the remote computer as a different user, click different user
                      name, and enter the user name.
                 f.   Click Finish.
            2.   Run Oracle Universal Installer from the mapped DVD drive.
            Related Topics
            •    Installing the Oracle Database Client Software


Installing on Remote Computers Through Remote Access Software
            If you want to install and run Oracle Database Client on a remote computer (that is, the remote
            computer has the hard drive and runs Oracle Database Client components), but you do not
            have physical access to the computer, you still can perform the installation on the remote
            computer.
            Use remote access software such as VNC or Symantec pcAnywhere. You also need the
            remote access software running on your local computer.
            You can install Oracle Database Client on the remote computer in the following ways:
            •    If you have copied the contents of the Oracle Database Client DVD to a hard drive, you
                 can install the software from the hard drive.
            •    You can insert the DVD into a drive on your local computer, and install the software from
                 the DVD.
            •    Installing on Remote Computers from a Hard Drive
                 If you have copied the contents of the Oracle Database DVD to a hard drive, then you can
                 install the software from the hard drive.
            •    Installing on Remote Computers from a Remote DVD Drive
                 You can insert the DVD into a drive on your local computer, and install from the DVD.

Installing on Remote Computers from a Hard Drive
            If you have copied the contents of the Oracle Database DVD to a hard drive, then you can
            install the software from the hard drive.
            To install the software on a remote computer from a hard drive:
            1.   Ensure that the remote access software is installed and running on the remote and local
                 computers.
            2.   Share the hard drive that contains the Oracle Database DVD.
            3.   On the remote computer, map a drive letter to the shared hard drive. You use the remote
                 access software to do this on the remote computer.
            4.   Through the remote access software, run Oracle Universal Installer on the remote
                 computer. You access Oracle Universal Installer from the shared hard drive.




                                                                                                              3-4
                                                                                                            Chapter 3
                                                                                  Accessing the Installation Software

             Related Topics
             •    Installing the Oracle Database Client Software

Installing on Remote Computers from a Remote DVD Drive
             You can insert the DVD into a drive on your local computer, and install from the DVD.
             To install the software on a remote computer from a remote DVD drive:
             1.   Ensure that the remote access software is installed and running on the remote and local
                  computers.
             2.   On the local computer, share the DVD drive.
                  On the remote computer, map a drive letter to the shared DVD drive. Use the remote
                  access software to do this on the remote computer.
             3.   Through the remote access software, run Oracle Universal Installer on the remote
                  computer. Access Oracle Universal Installer from the shared DVD drive.
             Related Topics
             •    Installing from a Remote DVD Drive
                  If the computer where you want to install Oracle Database Client does not have a DVD
                  drive, then you can perform the installation from a remote DVD drive.
             •    Installing the Oracle Database Client Software


Downloading Oracle Software
             Select the method you want to use to download the software.
             Download the installation files from either the Oracle Technology Network (OTN) or the Oracle
             Software Delivery Cloud portal and extract them on your hard disk. Ensure that you review and
             understand the terms of the license.
             •    Downloading the Installation Archive Files from OTN
                  Download installation archive files from Oracle Technology Network (OTN).
             •    Downloading the Software from Oracle Software Delivery Cloud
                  You can download the software from Oracle Software Delivery Cloud as Media Packs.

Downloading the Installation Archive Files from OTN
             Download installation archive files from Oracle Technology Network (OTN).
             1.   Use any browser to access the software download page from Oracle Technology Network:
                  http://www.oracle.com/technetwork/indexes/downloads/index.html
             2.   Go to the download page for the product to install.
             3.   On the download page, identify the required disk space by adding the file sizes for each
                  required file.
                  The file sizes are listed next to the file names.
             4.   Select a file system with enough free space to store and expand the archive files.
                  In most cases, the available disk space must be at least twice the size of all of the archive
                  files.




                                                                                                                3-5
                                                                                                            Chapter 3
                                                                                  Accessing the Installation Software

            5.   On the file system, create a parent directory for each product (for example, OraDB19c) to
                 hold the installation directories.
            6.   Download all of the installation archive files to the directory you created for the product.



                        Note:
                        For Oracle Database Client installations, there are two installation archive files
                        available for download. The first file is the client installation binary and the
                        second file is a client gold image file. Download the appropriate zip file based on
                        the type of installation you want to perform.

            7.   Verify that the files you downloaded are the same size as the corresponding files on Oracle
                 Technology Network. Also verify the checksums are the same as noted on Oracle
                 Technology Network using a command similar to the following, where filename is the name
                 of the file you downloaded:

                 cksum filename.zip

            8.   Extract the files in each directory that you just created.

Downloading the Software from Oracle Software Delivery Cloud
            You can download the software from Oracle Software Delivery Cloud as Media Packs.
            A Media Pack is an electronic version of the software that is also available to Oracle customers
            on CD-ROM or DVD. To download the Media Pack:
            1.   Use any browser to access the Oracle Software Delivery Cloud website:
                 http://edelivery.oracle.com/
            2.   Complete the Export Validation process by entering information (name, company, e-mail
                 address, and country) in the online form.
            3.   In the Media Pack Search page, specify the Product Pack and Platform to identify the
                 Media Pack you want to download. If you do not know the name of the Product Pack, you
                 can search for it using the License List.
            4.   Optionally, select the relevant product to download from the Results list.
            5.   In the search results page, click Readme to download and review the Readme file for
                 download instructions and product information.
            6.   After you review the Readme, choose the appropriate Media Pack from the search results
                 to download the individual zip files. Follow the Download Notes instructions in this page.
                 Once you download and extract the contents of the required zip files, proceed with the
                 installation of the software.


                        Tip:
                        Print the page with the list of downloadable files. It contains a list of part numbers
                        and their corresponding descriptions to refer during the installation process.


            7.   After you download the files, click View Digest to verify that the MD5 or SHA-1 checksum
                 matches with what is listed in the media download page.




                                                                                                                3-6
                                                                                                            Chapter 3
                                                                       Installing the Oracle Database Client Software



                   See Also:

                   •   My Oracle Support Note 549617.1 for information about how to verify the integrity
                       of a software download at:
                       https://support.oracle.com/CSP/main/article?
                       cmd=show&type=NOT&id=549617.1
                   •   Frequently Asked Questions section on the Oracle Software Delivery Cloud
                       website for more information about Media Packs



Copying the Oracle Database Client Software to a Hard Disk
           Oracle recommends that you copy the installation software to the hard disk to enable the
           installation to run faster.
           To copy the contents of the installation media to a hard disk, perform the following steps:
           1.   Create a directory on your hard drive. For example:
                C:\> mkdir \install
                C:\> mkdir \install\database

           2.   Copy the contents of the installation media to the directory that you just created.
           Related Topics
           •    Installing the Oracle Database Client Software


Installing the Oracle Database Client Software
           These topics explain how to run the Setup Wizard to perform most database client
           installations.

           •    Running Setup Wizard to Install Oracle Database Client
                Use the runInstaller command to start the Oracle Database Client installation.
           •    Installing Oracle Database Client Using Image File
                Extract the image software (client_home.zip) into the directory where you want your Oracle
                Database Client home to be located.
           •    Using Oracle Net Configuration Assistant
                Run Oracle Net Configuration Assistant in standalone mode after the Oracle Database
                Client installation is complete to configure the listener, naming methods, net service
                names, and directory server usage.


Running Setup Wizard to Install Oracle Database Client
           Use the runInstaller command to start the Oracle Database Client installation.

           To install Oracle Database Client, perform the following steps:
           1.   Log in to Windows as an Administrator user. If you are installing on a Primary Domain
                Controller (PDC) or a Backup Domain Controller (BDC), log on as a member of the
                Domain Administrators group.




                                                                                                                3-7
                                                                                                          Chapter 3
                                                                     Installing the Oracle Database Client Software

           2.   Navigate to the location of the installation media for Oracle Database Client, open a
                command prompt with administrator privileges, and run the setup.exe command to start
                the Oracle setup wizard. Use the same installation media to install Oracle Database on all
                supported Windows platforms.
           3.   Select your installation type.
                Installation screens vary depending on the installation option you select. Respond to the
                configuration prompts as needed.



                       Note:
                       At any time during installation, if you have a question about what you are being
                       asked to do, click Help.


Installing Oracle Database Client Using Image File
           Extract the image software (client_home.zip) into the directory where you want your Oracle
           Database Client home to be located.
           Starting with 19c, the Oracle Database Client software is also available as an image file for
           download and installation.
           Oracle recommends that the Oracle home directory path you create is in compliance with the
           Oracle Optimal Flexible Architecture recommendations.
           To install Oracle Database Client using image file, perform the following steps:.
           1.   Log in to Windows as an Administrator user. If you are installing on a Primary Domain
                Controller (PDC) or a Backup Domain Controller (BDC), log on as a member of the
                Domain Administrators group.
           2.   Download the Oracle Database Client installation image files (client_home.zip) to a
                directory of your choice. For example, you can download the image files to the \tmp
                directory.
           3.   Create the Oracle home directory and extract the image files that you have downloaded in
                to this Oracle home directory. For example:

                C:\>md C:\app\oracle\product\19.0.0\clienthome_1
                C:\>cd C:\app\oracle\product\19.0.0\clienthome_1
                C:\app\oracle\product\19.0.0\clienthome_1> unzip \tmp\client_home.zip

           4.   From the Oracle home directory, run the setup.exe command to start the Oracle
                Database Client Setup Wizard.

                C:\app\oracle\product\19.0.0\clienthome_1>setup.exe



                       Note:
                       Run the setup.exe command from the Oracle home directory only. Do not use
                       the setup.exe command that resides at %ORACLE_HOME%\oui\bin\, or any
                       other location, to install Oracle Database, Oracle Database Client, or Oracle Grid
                       Infrastructure.




                                                                                                              3-8
                                                                                                          Chapter 3
                                                                     Installing the Oracle Database Client Software

           5.   The setup wizard starts an Administrator type installation of Oracle Database Client.
                Installation screens vary depending on the installation option you select. Respond to the
                configuration prompts as needed.



                       Note:
                       At any time during installation, if you have a question about what you are being
                       asked to do, click Help.


Using Oracle Net Configuration Assistant
           Run Oracle Net Configuration Assistant in standalone mode after the Oracle Database Client
           installation is complete to configure the listener, naming methods, net service names, and
           directory server usage.
           Oracle recommends that you have information ready about the host name of the computer
           where the Oracle database is installed.
           To start Oracle Net Configuration Assistant in standalone mode:
           1.   Run netca from the $ORACLE_HOME/bin directory.
           2.   Respond to the configuration prompts and screens as needed. The screens vary
                depending on the options you select. At any time during the configuration, if you have a
                question about what you are being asked to do, click Help.
           Related Topics
           •    Oracle Database Net Services Administrator's Guide




                                                                                                              3-9
4
Oracle Database Client Postinstallation Tasks
           Complete configuration task after you install Oracle Database Client.


           You must complete some configuration tasks after Oracle Database Client is installed. In
           addition, Oracle recommends that you complete additional tasks immediately after installation.
           You must also complete product-specific configuration tasks before you use those products.
           •    Required Postinstallation Tasks
                Download and apply required patches for your software release after completing your initial
                installation.
           •    Recommended Postinstallation Tasks
                Oracle recommends that you perform the tasks in the following sections after completing
                an installation:


Required Postinstallation Tasks
           Download and apply required patches for your software release after completing your initial
           installation.
           •    Downloading and Installing Release Update Patches
                Download and install Release Updates (RU) and Release Update Revisions (RUR)
                patches for your Oracle software after you complete installation.
           •    Windows Authentication No Longer Uses NTLM by Default
                For Microsoft Windows installations with AUTHENTICATION_SERVICES=NTS, in this Oracle
                Database release, the SQLNET.NO_NTLM parameter setting in the sqlnet.ora file defaults to
                TRUE, which can cause ORA-12638 errors.
           •    Updating Instant Client
                Review this procedure to update Instant Client.
           •    Configuring Oracle Net Services
                You can configure Oracle Database Client to communicate with Oracle Net Services by
                adding the appropriate entries to the tnsnames.ora and listener.ora files.


Downloading and Installing Release Update Patches
           Download and install Release Updates (RU) and Release Update Revisions (RUR) patches for
           your Oracle software after you complete installation.
           Starting with Oracle Database 18c, Oracle provides quarterly updates in the form of Release
           Updates (RU) and Release Update Revisions (RUR). Oracle no longer releases patch sets.
           For more information, see My Oracle Support Note 2285040.1.
           Check the My Oracle Support website for required updates for your installation.
           1.   Use a web browser to view the My Oracle Support website:
                https://support.oracle.com
           2.   Log in to My Oracle Support website.



                                                                                                         4-1
                                                                                                       Chapter 4
                                                                                 Required Postinstallation Tasks



                      Note:
                      If you are not a My Oracle Support registered user, then click Register for My
                      Oracle Support and register.

          3.   On the main My Oracle Support page, click Patches & Updates.
          4.   In the Patch Search region, select Product or Family (Advanced).
          5.   On the Product or Family (Advanced) display, provide information about the product,
               release, and platform for which you want to obtain patches, and click Search.
               The Patch Search pane opens, displaying the results of your search.
          6.   Select the patch number and click ReadMe.
               The README page is displayed. It contains information about the patch and how to apply
               the patches to your installation.
          7.   Uncompress the Oracle patch updates that you downloaded from My Oracle Support.
          Related Topics
          •    My Oracle Support note 2285040.1


Windows Authentication No Longer Uses NTLM by Default
          For Microsoft Windows installations with AUTHENTICATION_SERVICES=NTS, in this Oracle
          Database release, the SQLNET.NO_NTLM parameter setting in the sqlnet.ora file defaults to
          TRUE, which can cause ORA-12638 errors.

          Date: August 2023
          In previous releases, the default for AUTHENTICATION_SERVICES=NTS was FALSE.
          SQLNET.NO_NTLM controls whether NTLM can be used with NTS authentication. A TRUE setting
          means that NTLM cannot be used in NTS authentication. Because NTLM does not normally
          provide mutual authentication and is hence less secure, a TRUE setting for SQLNET.NO_NTLM
          makes the database and client more secure.
          The SQLNET.NO_NTLM parameter is used on both the server and the client. If you have upgraded
          a Microsoft Windows installation of Oracle Database, or upgraded a client in which
          SQLNET.NO_NTLM had not been set, then its default will be TRUE. In that case, when you have
          SQLNET.AUTHENTICATION_SERVICES=NTS in your sqlnet.ora, clients can encounter the error
          ORA-12638: Credential retrieval failed.

          If you prefer to use NTLM authentication for certain clients, then set this parameter as required
          in client-side sqlnet.ora files:

          SQLNET.NO_NTLM=FALSE


          You must include this setting on both the server and client, and this setting should be the same
          on both. Ideally, you should ensure that SQLNET.NO_NTLM is set to TRUE. However, if there is an
          authentication failure in extproc, a virtual account, or a local account on Windows, set the
          client SQLNET.NO_NTLM to FALSE, and then retry the login. If you change SQLNET.NO_NTLM on the
          server, then you must restart the database.
          Related Topics
          •    Upgrade Your Database Now - ORA-12638 on Windows only from Oracle 19.10.0 onwards




                                                                                                           4-2
                                                                                                            Chapter 4
                                                                                      Required Postinstallation Tasks

            •    Windows : While Connect to Database Getting ORA-12638 After Applying Jan 2021
                 WINDBBP 19.10.0.0.210119 On Windows 64/32 Bit Database Client (Doc ID 2757734.1)


Updating Instant Client
            Review this procedure to update Instant Client.
            To update Instant Client, perform the following steps:
            1.   Download Instant Client from https://www.oracle.com/technetwork/database/
                 database-technologies/instant-client/overview/index.htm.
            2.   Place the new files directly on top of the previous files.
                 If you place the files into a different directory (and remove the previous files), be sure to
                 update your PATH environment variable setting to reflect the new location.


Configuring Oracle Net Services
            You can configure Oracle Database Client to communicate with Oracle Net Services by adding
            the appropriate entries to the tnsnames.ora and listener.ora files.
            If you have a previous release or Oracle software, you can just copy information in the Oracle
            Net tnsnames.ora and listener.ora configuration files from the previous release to the
            corresponding files in the new release.



                    Note:
                    The default location for the tnsnames.ora and listener.ora files is the
                    ORACLE_HOME\network\admin directory.


            To create Oracle Connection Manager (CMAN) services, create a CMAN alias entry in
            cman.ora under ORACLE_HOME\network\admin. For example:
            cman_proxy=
            (CONFIGURATION=
            (ADDRESS=(PROTOCOL=tcp)(HOST=host_name)(PORT=1521))
            (RULE_LIST=
            (RULE=(SRC=*)(DST=*)(SRV=*)(ACT=accept)))
            (PARAMETER_LIST=
            (MIN_GATEWAY_PROCESSSES=1)
            (MAX_GATEWAY_PROCESSES=2)))

            This accepts connection from all clients as mentioned in the rule.
            CMAN services are created when CMAN is started for the first time using cmctl command-line
            tool. When creating services, cmctl prompts for a password if Windows User Account is
            specified as Oracle Home User during installation. If Windows Built-in Account is specified as
            Oracle Home User during installation, then cmctl does not prompt for password.




                                                                                                                 4-3
                                                                                                         Chapter 4
                                                                               Recommended Postinstallation Tasks

            Listener can be configured by adding an alias entry in listener.ora. Listener service is
            created when the listener is started for the first time. The listener control utility, lsnrctl
            prompts for a password if Windows User Account is specified as Oracle Home User during
            installation. If Windows Built-in Account is specified as Oracle Home User during installation,
            then it does not prompt for password.


Recommended Postinstallation Tasks
            Oracle recommends that you perform the tasks in the following sections after completing an
            installation:
            •    Configuring Instant Client Light
                 To configure Instant Client Light, you must make it the default instead of Instant Client.
            •    Connecting Oracle Database Client to an Oracle Database
                 After you run Oracle Universal Installer to install Oracle Database Client, you must use
                 Oracle Net Configuration Assistant (NETCA) to configure Oracle Database Client to
                 connect to an Oracle database.
            •    Connecting Instant Client or Instant Client Light to an Oracle Database
                 Before you can connect Instant Client or Instant Client Light to an Oracle Database, ensure
                 that the PATH environment variable specifies the directory that contains the Instant Client
                 libraries.
            •    Changing the Oracle Home User Password
                 Oracle Home User Control is a command-line utility that allows an administrator to update
                 the password for an Oracle Home User.
            •    Creating the OraMTS Service for Microsoft Transaction Server
                 Oracle Services for Microsoft Transaction Server (OraMTS) permit Oracle databases to be
                 used as resource managers in Microsoft application coordinated transactions.
            •    Creating the Scheduler Agent
                 The Oracle Scheduler Execution Agent permits Oracle Database clients to run Scheduler
                 jobs at the request of an Oracle instance which can be located on a remote host.


Configuring Instant Client Light
            To configure Instant Client Light, you must make it the default instead of Instant Client.
            To configure Instant Client Light:
            1.   In the ORACLE_BASE\ORACLE_CLIENT_HOME directory, either rename or delete the
                 oraociei12.dll file.
                 The oraociei12.dll file is the main binary for Instant Client.
            2.   From the ORACLE_BASE\ORACLE_CLIENT_HOME\install\instantclient\light directory,
                 copy the oraociicus12.dll file to the ORACLE_BASE\ORACLE_CLIENT_HOME directory. .
                 The oraociicus12.dll file is the binary for Instant Client Light.
            3.   Ensure that the PATH environment variable points to the
                 ORACLE_BASE\ORACLE_CLIENT_HOME directory.




                                                                                                              4-4
                                                                                                           Chapter 4
                                                                                 Recommended Postinstallation Tasks



                        Note:
                        If the Instant Client PATH is not set, then the applications attempt to load the
                        regular Instant Client libraries first. If the applications cannot find these, then they
                        attempt to load the Instant Client Light library next.


Connecting Oracle Database Client to an Oracle Database
            After you run Oracle Universal Installer to install Oracle Database Client, you must use Oracle
            Net Configuration Assistant (NETCA) to configure Oracle Database Client to connect to an
            Oracle database.
            At the end of the installation, Oracle Universal Installer prompts you to configure the database
            connection. If you bypassed that option, or if you need to change the database connection later
            on, use the following procedure if you installed the Administrator, Runtime, or Custom
            installation types.
            To connect Oracle Database Client to an Oracle Database:
            1.   From the Start menu, choose Oracle - HOME_NAME, then Configuration and Migration
                 Tools, then Oracle Net Configuration Assistant.
            2.   In the Welcome window, select Local Net Service Name configuration and click Next.
            3.   In the Net Service Name Configuration window, select Add and click Next.
            4.   In the Service Name window, enter the name of the Oracle database to which you want to
                 connect and click Next.
            5.   In the Select Protocols window, select the protocol you want and click Next.
            6.   In the Protocol window, depending on the protocol you selected, enter the appropriate
                 information and click Next.
            7.   In the Net Test window, select whether you want to test the connection, and click Next.
            8.   In the Net Service Name window, enter a name for the net service and click Next.
            9.   Answer the remaining prompts, which allow you to configure another net service name,
                 and then click Finish to complete the configuration.
                 Oracle Net Configuration Assistant creates the tnsnames.ora file in the following location:
                 ORACLE_HOME\network\admin\tnsnames.ora


Connecting Instant Client or Instant Client Light to an Oracle Database
            Before you can connect Instant Client or Instant Client Light to an Oracle Database, ensure
            that the PATH environment variable specifies the directory that contains the Instant Client
            libraries.
            •    Specifying a Connection by Using the Easy Connect Naming Method
                 You can specify a connection address to an Oracle Database directly from a client
                 application, without having to configure a tnsnames setting for the Instant Client.
            •    Specifying a Connection by Configuring a tnsnames.ora File
                 By default, when you install an Instant Client, Oracle Universal Installer does not include a
                 sample tnsnames.ora file nor the Oracle Net Configuration Assistant utility normally used
                 to create it.




                                                                                                               4-5
                                                                                                       Chapter 4
                                                                              Recommended Postinstallation Tasks

            •    Specifying a Connection by Using an Empty Connect String and the LOCAL Variable
                 Describes how to specify a connection to an empty connect string and set the LOCAL
                 environment variable.

Specifying a Connection by Using the Easy Connect Naming Method
            You can specify a connection address to an Oracle Database directly from a client application,
            without having to configure a tnsnames setting for the Instant Client.

            This method is convenient in that you do not have to create and manage a tnsnames.ora file.
            However, your application users must specify the host name and port number when they want
            to log in to your application.
            For example, suppose you are running SQL*Plus on the client computer and want to connect
            to the sales_us database, which is located on a server whose host name is shobeen and port
            number is 1521. If you launch SQL*Plus from the command line, then log in as follows:
            sqlplus system/admin@//shobeen:1521/sales_us

            Similarly, in your application code, you can use Oracle Call Interface net naming methods to
            create the Instant Client-to-Oracle Database connection. For example, the following formats in
            the OCIServerAttach() call specify the connection information:
            •    Specify a SQL connect URL string using the following format:
                 //host[:port][/service_name]
                 For example:
                 //shobeen:1521/sales_us
            •    Alternatively, specify the SQL connect information as an Oracle Net keyword-value pair.
                 For example:
                 “(DESCRIPTION=(ADDRESS=(PROTOCOL=tcp) (HOST=shobeen) (PORT=1521))
                 (CONNECT_DATA=(SERVICE_NAME=sales_us)))”

Specifying a Connection by Configuring a tnsnames.ora File
            By default, when you install an Instant Client, Oracle Universal Installer does not include a
            sample tnsnames.ora file nor the Oracle Net Configuration Assistant utility normally used to
            create it.
            However, if you want to shield users from having to specify actual host names and port
            numbers, you may want to consider using a tnsnames.ora file to set the Instant Client-to-
            Oracle Database connection.
            You can create the tnsnames.ora file manually by copying and modifying a version of this file
            from another Oracle installation, or you can use Oracle Net Configuration Assistant to create
            and manage it for you.
            To install Oracle Net Configuration Assistant:
            1.   Run Oracle Universal Installer.
            2.   Select the Custom installation type.
            3.   In the Available Product Components list, select Oracle Network Utilities and click Next.
            4.   In the Summary window, click Install, then click Exit and Yes to exit Oracle Universal
                 Installer.
                 Then, on each client computer, configure either of the following settings:




                                                                                                            4-6
                                                                                                      Chapter 4
                                                                             Recommended Postinstallation Tasks

                •   Set the TNS_ADMIN environment variable to specify the location of the tnsnames.ora file
                    and specify a service name from that file.
                •   Place the tnsnames.ora file in the ORACLE_HOME\network\admin directory, and ensure
                    that the ORACLE_HOME environment has been set to this Oracle home.

            Related Topics
            •   Connecting Oracle Database Client to an Oracle Database
                After you run Oracle Universal Installer to install Oracle Database Client, you must use
                Oracle Net Configuration Assistant (NETCA) to configure Oracle Database Client to
                connect to an Oracle database.

Specifying a Connection by Using an Empty Connect String and the LOCAL Variable
            Describes how to specify a connection to an empty connect string and set the LOCAL
            environment variable.
            You can set the connect string to an empty connect string (""), and then set the LOCAL
            environment variable to one of the following values:
            •   A direct address
            •   Oracle Net keyword-value pair
            •   A tnsnames.ora entry and TNS_ADMIN is set to the location of tnsnames.ora
            •   A tnsnames.ora entry and the following:
                –   tnsnames.ora file located in ORACLE_HOME/network/admin
                –   The ORACLE_HOME environment variable set to this Oracle home
                    This method allows your applications to specify internally a connection string if the
                    application code uses an empty connection string. The benefit of an empty connect
                    string is that the application does not need to specify the tnsnames.ora entry. Instead,
                    when a user invokes the application, the location of the database is determined by a
                    script or the environment, depending on where you have set the LOCAL environment
                    variable. The disadvantage of using empty strings is that you must configure this
                    additional information for your application to connect to the database.
            Related Topics
            •   Specifying a Connection by Using the Easy Connect Naming Method
                You can specify a connection address to an Oracle Database directly from a client
                application, without having to configure a tnsnames setting for the Instant Client.


Changing the Oracle Home User Password
            Oracle Home User Control is a command-line utility that allows an administrator to update the
            password for an Oracle Home User.
            This tool updates the password for Windows services in the Oracle home. The input password
            must match the password for the Windows User Account used as the Oracle Home User. So,
            first use Windows operating system tools to change the Windows password and then use this
            tool to update the Windows services in the Oracle home to use the same password.




                                                                                                           4-7
                                                                                                      Chapter 4
                                                                             Recommended Postinstallation Tasks



                    Note:
                    You must have Administrator privileges to run this Oracle Home User Control utility.



           Syntax Overview:
           The following is the command syntax:
           orahomeuserctl list | updpwd [-user username] [-host hostname1, hostname2, . . .] [-log
           logfilename]

           where:
           •   orahomeuserctl is used to display the Oracle Home User name associated with the
               current Oracle home or to update the Oracle Home User password.
           •   list displays the Oracle Home User name associated with the current Oracle home.
           •   updpwd prompts for the new password and updates the password for the named Oracle
               Service User. The following are the options for updpwd:
               –    -user username
                    This option determines the Oracle Home User name. If this option is not present, then
                    the user name associated with the current Oracle home is used. If the named user, be
                    it the username or user of the current Oracle home, is an MSA or Windows Built-in
                    account, then an error message is displayed and the command is terminated.
               –    -host hostname1, hostname2,. . .
                    When this option is present, the utility updates the passwords for all services belonging
                    to the named Oracle Home User on the specified hosts. Otherwise, the Oracle Home
                    User Control utility updates the passwords for all the services belonging to the named
                    Oracle Home User on a specified host with single instance installation, or updates the
                    passwords for all services belonging to the named Oracle Home User on all the
                    specified hosts.
                    When the update completes, the utility displays the number of successful updates and
                    any services that failed to update with the new password.
               –    -log logfilename
                    This option adds the password update operation results to a log file for every service
                    name receiving the new password. By default, the log files are located in the
                    ORACLE_HOME\log directory. If logfilename specifies only a file name, then the log is
                    stored in the named file in the default directory. However, if the logfilename contains a
                    path, then that path is used without modification.


Creating the OraMTS Service for Microsoft Transaction Server
           Oracle Services for Microsoft Transaction Server (OraMTS) permit Oracle databases to be
           used as resource managers in Microsoft application coordinated transactions.
           OraMTS acts as a proxy for the Oracle database to the Microsoft Distributed Transaction
           Coordinator (MSDTC). As a result, OraMTS provides client-side connection pooling and allows
           client components that leverage Oracle to participate in promotable and distributed
           transactions. In addition, OraMTS can operate with Oracle databases running on any operating
           system, given that the services themselves are run on Windows.




                                                                                                           4-8
                                                                                                        Chapter 4
                                                                             Recommended Postinstallation Tasks

           On releases before Oracle Database 12c, the OraMTS service was created as part of a
           software-only installation. Now, you must use a configuration tool to create this service.
           To create the OraMTS service after performing a software-only installation for Oracle
           Database, perform the following steps:
           1.   Open a command window.
           2.   Change directories to ORACLE_HOME\bin.
           3.   Run the OraMTSCtl utility to create the OraMTS Service:
                C:\ORACLE_HOME\bin> oramtsctl.exe -new


Creating the Scheduler Agent
           The Oracle Scheduler Execution Agent permits Oracle Database clients to run Scheduler jobs
           at the request of an Oracle instance which can be located on a remote host.
           This allows for centralized control over several hosts using Oracle Scheduler and can perform
           jobs at the operating system level and jobs that run on another Oracle Database.
           The Oracle Scheduler Execution Agent is installed with the Oracle Database Client software.
           The Oracle Scheduler Execution Agent permits Oracle Database clients to run Scheduler jobs
           at the request of an Oracle instance which can be located on a remote host. This allows for
           centralized control over several hosts using Oracle Scheduler and can perform jobs at the
           operating system level and jobs that run on another Oracle Database.
           To create the Scheduler Agent service after performing a software-only installation for Oracle
           Database Client, perform the following steps:
           1.   Open a command window.
           2.   Change directories to ORACLE_HOME\bin.
           3.   Run the executable utility, schagent to create the Scheduler Agent service:
                C:\ORACLE_HOME\bin> schagent.exe -new




                                                                                                            4-9
5
Removing Oracle Database Client Software
      Learn how to remove Oracle software and configuration files.
      You can remove Oracle software either by using Oracle Universal Installer with the deinstall
      option, or by using the deinstallation tool (deinstall) that is included in Oracle homes. Oracle
      does not support the removal of individual products or components related to the specified
      Oracle home. It includes information about removing Oracle software using the deinstallation
      tool.
      The deinstallation tool removes standalone Oracle Database installations, Oracle Clusterware
      and Oracle Automatic Storage Management (Oracle ASM) from your server, as well as Oracle
      Real Application Clusters (Oracle RAC) and Oracle Database client installations.
      Oracle recommends that you use the deinstallation tool to remove the entire Oracle home
      associated with the Oracle Database, Oracle Clusterware, Oracle ASM, Oracle RAC, or Oracle
      Database client installation. Oracle does not support the removal of individual products or
      components.



             Caution:
             If you have a standalone database on a node in a cluster and you have multiple
             databases with the same global database name (GDN), then you cannot use the
             deinstallation tool to remove one database only.




             Caution:
             You must use the deinstallation tool from the same release to remove Oracle
             software. Do not run the deinstallation tool from a later release to remove Oracle
             software from an earlier release. For example, do not run the deinstallation tool from
             the 12.2.0.1 installation media to remove Oracle software from an existing 11.2.0.4
             Oracle home.



      •   About Oracle Deinstallation Options
          You can stop and remove Oracle Database software and components in an Oracle
          Database home with Oracle Universal Installer.
      •   Deinstallation Examples for Oracle Database Client
          Use these examples to learn how to run deinstallation using a standalone tool (deinstall).
      •   Example of Running the Deinstallation Tool
          Review the examples to help you understand how to run the deinstallation tool.
      •   Deinstallation Response File Example for Oracle Database Client
          You can run the deinstallation tool with the -paramfile option to use the values you specify
          in the response file.




                                                                                                      5-1
                                                                                                         Chapter 5
                                                                               About Oracle Deinstallation Options




About Oracle Deinstallation Options
          You can stop and remove Oracle Database software and components in an Oracle Database
          home with Oracle Universal Installer.
          Using Oracle Universal Installer with the deinstall option, or running the deinstallation tool from
          the Oracle home, stops and removes Oracle software and it's components, such as database
          client and configuration files for a specific Oracle home.
          You can remove the following software using Oracle Universal Installer or the Oracle
          deinstallation tool:
          •   Oracle Database
          •   Oracle Grid Infrastructure, which includes Oracle Clusterware and Oracle Automatic
              Storage Management (Oracle ASM)
          •   Oracle Real Application Clusters (Oracle RAC)
          •   Oracle Database Client
          The deinstallation tool is integrated with the database client installation media. You can run the
          deinstallation tool with the -deinstall and -home options from the base directory of the
          Oracle Database, Oracle Database Client, or Oracle Grid Infrastructure installation media.
          The deinstallation tool is also available as a separate command (deinstall) in Oracle home
          directories after installation. It is located in ORACLE_HOME\deinstall directory.

          The deinstallation tool uses the information you provide, plus information gathered from the
          software home to create a response file. You can alternatively supply a response file generated
          previously by the deinstall command using the –checkonly option, or by editing the response
          file template.
          Using Oracle Universal Installer with the deinstall option, or running the deinstallation tool from
          the Oracle home, stops and removes Oracle software and its components, such as database
          and configuration files for a specific Oracle home.
          If the software in the Oracle home is not running (for example, after an unsuccessful
          installation), then the deinstallation tool cannot determine the configuration, and you must
          provide all the configuration details either interactively or in a response file.




                                                                                                             5-2
                                                                                              Chapter 5
                                                                    About Oracle Deinstallation Options



       Caution:
       When you install Oracle Database, if the central inventory contains no other
       registered homes besides the home that you are deconfiguring and removing, then
       the Deinstallation tool removes the following files and directory contents in the Oracle
       base directory of the Oracle Database installation owner:
       •   admin
       •   cfgtoollogs
       •   checkpoints
       •   diag
       •   oradata
       •   flash_recovery_area
       Oracle strongly recommends that you configure your installations using an Optimal
       Flexible Architecture (OFA) configuration, and that you reserve Oracle base and
       Oracle home paths for exclusive use of Oracle software. If you have any user data in
       these locations in the Oracle base that is owned by the user account that owns the
       Oracle software, then the deinstallation tool deletes this data.
       In addition, for Oracle Grid Infrastructure installations:
       •   Oracle Automatic Storage Management Cluster File System (Oracle ACFS) must
           be dismounted and Oracle Automatic Storage Management Dynamic Volume
           Manager (Oracle ADVM) must be disabled.
       •   If Grid Naming Service (GNS) is in use, then the entry for the subdomain needs
           to be deleted from DNS by your DNS administrator.


Oracle recommends that you run the deinstallation tool as the Oracle software installation
owner. The default method for running the deinstallation tool is from the deinstall directory in
the Oracle home as the installation owner:
ORACLE_HOME\deinstall
DRIVE_LETTER:\> deinstall\deinstall.bat

The command uses the following syntax, where variable content is indicated by italics:
deinstall.bat [-silent] [-checkonly]
[-paramfile complete path of input parameter property file] [-params name1=value
name2=value . . .]
[-o complete path of directory for saving files] [-help]
[-tmpdir complete path of temporary directory to use]
[-logdir complete path of log directory to use] [-help]


To run the deinstallation tool from the database installation media, use the setup.exe
command with the -deinstall option, followed by the -home option to specify the path of the
Oracle home you want to remove using the following syntax, where variable content is
indicated in italics:
setup.exe -deinstall -home complete path of Oracle home [-silent] [-checkonly] [-local]
[-paramfile complete path of input parameter property file] [-params name1=value
name2=value . . .] [-o complete path of directory for saving files] [-help]
[-tmpdir complete path of temporary directory to use]




                                                                                                  5-3
                                                                                               Chapter 5
                                                                     About Oracle Deinstallation Options

[-logdir complete path of log directory to use] [-help]


Provide information about your servers as prompted or accept the defaults.



        Note:
        If User Account Control is enabled, then you must create a desktop shortcut to a
        DOS command window. Open the command window through the Run as
        administrator, right-click context menu, and start the deinstallation tool.



In addition, you can run the deinstallation tool from other locations, or with a response file, or
select other options to run the tool.
•   -home
    Use this flag to indicate the home path of the Oracle home to check or deinstall. To
    deinstall Oracle software using the deinstall command, located in the Oracle home you
    plan to deinstall, provide a response file in a location outside the Oracle home, and do not
    use the -home flag.
    If you run the deinstallation tool from the ORACLE_HOME\deinstall path, then the -home flag
    is not required because the tool identifies the location of the home where it is run. If you
    run the tool using setup.exe -deinstall from the installation media, then -home is
    mandatory.
•   -silent
    Use this flag to run the deinstallation tool in a noninteractive mode. This option requires
    one of the following:
    –   A working system that it can access to determine the installation and configuration
        information. The -silent flag does not work with failed installations.
    –   A response file that contains the configuration values for the Oracle home that is being
        deinstalled or deconfigured.
    You can generate a response file to use or modify by running the tool with the -checkonly
    flag. The tool then discovers information from the Oracle home to deinstall and
    deconfigure. It generates the response file that you can then use with the -silent option.
    You can also modify the template file deinstall.rsp.tmpl, located in the
    ORACLE_HOME\deinstall\response directory.
•   -checkonly
    Use this flag to check the status of the Oracle software home configuration. Running the
    deinstallation tool with the -checkonly flag does not remove the Oracle configuration. The
    -checkonly flag generates a response file that you can then use with the deinstallation tool
    and -silent option.
•   -paramfile complete path of input parameter property file
    Use this flag to run the deinstallation tool with a response file in a location other than the
    default. When you use this flag, provide the complete path where the response file is
    located.
    The default location of the response file depends on the location of the deinstallation tool:
    –   From the installation media or stage location: \response




                                                                                                   5-4
                                                                                                        Chapter 5
                                                               Deinstallation Examples for Oracle Database Client

             –   After installation from the installed Oracle home: \deinstall\response.
         •   -params ["name1=value" "name2=value" "name3=value" . . .]
             Use this flag with a response file to override one or more values to change it in a response
             file you have created.
         •   -o complete path of directory for saving response file
             Use this flag to provide a path other than the default location where the response file is
             saved. The default location is \response\deinstall.rsp.tmpl.
             The default location of the response file depends on the location of deinstallation tool:
             –   From the installation media or stage location before installation: \response
             –   After installation from the installed Oracle home: ORACLE_HOME/deinstall/response.
         •   -tmpdir complete path of temporary directory
             Specifies a non-default location where Oracle Deinstallation Tool writes the temporary files
             for the deinstallation.
         •   -logdir complete path of log directory
             Specifies a non-default location where Oracle Deinstallation Tool writes the log files for the
             deinstallation.
         •   -help
             Use the help option (-help ) to obtain additional information about the command optional
             flags.
         Related Topics
         •   Managing User Accounts with User Account Control
             To ensure that only trusted applications run on your computer, the Windows operating
             systems supported for Oracle Database Client provide User Account Control.


Deinstallation Examples for Oracle Database Client
         Use these examples to learn how to run deinstallation using a standalone tool (deinstall).

         Use the optional flag -paramfile to provide a path to a response file.

         In the following example, the deinstall command is in the path
         C:\app\oracle\product\19.0.0\client_1\deinstall, and it uses a response file in the
         software owner location C:\Documents and Settings\oracle\:
         DRIVE_LETTER:\> cd \app\oracle\product\19.0.0\client_1\deinstall\
         DRIVE_LETTER:\> deinstall.bat -paramfile %HOMEPATH%\my_db_paramfile.tmpl


Example of Running the Deinstallation Tool
         Review the examples to help you understand how to run the deinstallation tool.
         If you perform a deinstallation by running the setup.exe command with the -deinstall option
         from the installation media, then help is displayed unless you enter a -home flag and provide a
         path to the home directory of the Oracle software to remove from your system.
         Use the optional flag -paramfile to provide a path to a response file.




                                                                                                            5-5
                                                                                                         Chapter 5
                                                   Deinstallation Response File Example for Oracle Database Client

         In the following example, the setup.exe command is in the path \directory_path, where
         directory_path is the path to the database directory on the installation media, and
         C:\app\oracle\product\19.0.0\dbhome_1 is the path to the Oracle home which is removed:
         DRIVE_LETTER:\> cd \directory_path
         DRIVE_LETTER:\> setup.exe -deinstall -home C:\app\oracle\product\19.0.0\dbhome_1

         The following example uses a response file in the software owner location C:\Documents and
         Settings\oracle\:
         DRIVE_LETTER:\> cd \directory_path
         DRIVE_LETTER:\> setup.exe -deinstall -paramfile C:\Documents and
         Settings\oracle\my_db_paramfile.tmpl


Deinstallation Response File Example for Oracle Database Client
         You can run the deinstallation tool with the -paramfile option to use the values you specify in
         the response file.
         The following is an example of a response file, in which the Oracle Database binary owner is
         oracle, the Oracle Database home (Oracle home) is in the path
         C:\app\oracle\product\19.0.0\client_1, the Oracle base (where other Oracle software is
         installed) is C:\app\oracle, the Oracle Inventory home is C:\Program
         Files\Oracle\Inventory, and the local node (the node where you run the deinstallation
         session from) is myserver:
         # Copyright (c) 2005, 2019, Oracle and/or its affiliates. All rights reserved.
         ORACLE_HOME=C:\app\dbinstall3\19.3admnClnt\client_1
         COMPS_TO_REMOVE=ntoledb,asp.net,odp.net
         ORACLE_HOME_VERSION=19.0.0.0.0
         ORACLE_BASE=C:\app\dbinstall3\19.3admnClnt\cbase
         INVENTORY_LOCATION=C:\Program Files\Oracle\Inventory
         CRS_HOME=false
         HOME_TYPE=CLIENT
         silent=false
         WindowsRegistryCleanupList=C:\Users\DBINST~1\AppData\Local\Temp\2\deinstall2019-05-30_03-
         29-28AM\utl\registry_cleanup.lst
         MinimumSupportedVersion=11.2.0.1.0
         LOCAL_NODE=<hostname>
         local=false
         ObaseCleanupPtrLoc=C:\Users\DBINST~1\AppData\Local\Temp\2\deinstall2019-05-30_03-29-28AM\
         utl\orabase_cleanup.lst
         ORACLE_HOME=C:\app\dbinstall3\19.3admnClnt\client_1
         LOGDIR=C:\Program Files\Oracle\Inventory\logs\
         OLD_ACTIVE_ORACLE_HOME=
         ORACLE_HOME_VERSION_VALID=true




                                                                                                             5-6
A
Installing Java Access Bridge
         Learn how to install Java Access Bridge 2.0.2.
         Java Access Bridge 2.0.2 enables use of a screen reader with Oracle components.
         •    Overview of Java Access Bridge 2.0.2
              Java Access Bridge 2.0.2 enables assistive technologies to read Java applications running
              on the Windows platform.
         •    Setting Up Java Access Bridge 2.0.2
              Learn how to install and configure Java Access Bridge 2.0.2 for Windows after installing
              Oracle components.


Overview of Java Access Bridge 2.0.2
         Java Access Bridge 2.0.2 enables assistive technologies to read Java applications running on
         the Windows platform.
         Assistive technologies can read Java-based interfaces, such as Oracle Universal Installer and
         Oracle Enterprise Manager Database Express.
         For a list of supported system configurations, including supported versions of Microsoft
         Windows and Java SE, see section "Supported System Configuration" available at the
         following link location: http://docs.oracle.com
         During installation, Oracle Universal Installer uses the Java Runtime Environment (JRE) 1.8
         contained in an Oracle Database Client installation media. The JRE enables the use of Java
         Access Bridge during installation.
         Related Topics
         •    Setting Up Java Access Bridge 2.0.2
              Learn how to install and configure Java Access Bridge 2.0.2 for Windows after installing
              Oracle components.


Setting Up Java Access Bridge 2.0.2
         Learn how to install and configure Java Access Bridge 2.0.2 for Windows after installing Oracle
         components.
         To set up Java Access Bridge 2.0.2 on a Windows 64-bit operating system, perform the
         following steps:
         1.   Go to Java Standard Edition 2 (Java SE) Downloads page to download the latest build of
              JDK 8:
              http://docs.oracle.com
         2.   Install JDK 8 after accepting the Oracle license agreement.




                                                                                                     A-1
                                                                                             Appendix A
                                                                    Setting Up Java Access Bridge 2.0.2



            Note:
            You must have administrator privileges to install JDK on Windows.


3.   Download and install screen reader, JAWS:
     http://www.freedomscientific.com/downloads/jaws/JAWS-downloads.asp
4.   Press Windows key+U to open the Ease of Access Center, and select Use the computer
     without a display.
5.   Select Enable Accessbridge check box. Click Save to save the changes.
6.   Download Java Access Bridge 2.0.2:
     http://docs.oracle.com
     Download the accessbridge-2_0_2-fcs-bin-b06.zip file, after accepting the Oracle
     license agreement.
7.   Extract accessbridge-2.0.2 to a directory on your system where you plan to install Java
     Access Bridge. For example, name the directory as follows:
     AB_HOME
8.   Copy AB_HOME\WindowsAccessBridge-64.dll to c:\windows\system32 and start the
     screen reader.
9.   Open the command prompt and navigate to setup.exe file.
10. Run the following command once you are in the Disk1 directory:
     setup.exe
     Oracle Universal Installer starts and JAWS is able to read all prompts and controls on the
     screen.
11. Once you click the Install button, you must open Windows Explorer to see the directory
     where the database is installed
     (DRIVE_LETTER:\app\username\product\19.0.0\dbhome_1), until the JDK folder is
     created. Once the JDK folder is created, you must copy the files listed in the following table
     from the Java Access Bridge source location to the JDK destination folder. Copying these
     files enable accessibility for both the Oracle Database Configuration Assistant and Oracle
     Net Configuration Assistant.

     Table A-1   Copy Files to JDK Directory on Windows 64-Bit

     Copy                                           To
     AB_HOME\JavaAccessBridge-64.dll                dbhome_1\jdk\jre\bin
     AB_HOME\JAWTAccessBridge-64.dll                dbhome_1\jdk\jre\bin
     AB_HOME\Accessibility.properties               dbhome_1\jdk\jre\lib
     AB_HOME\Access-bridge-64.jar                   dbhome_1\jdk\jre\lib\ext
     AB_HOME\jaccess.jar                            dbhome_1\jdk\jre\lib\ext




                                                                                                  A-2
B
Installing and Configuring Oracle Database
Using Response Files
        Review how to install and configure Oracle products using response files.
        Learn how to install and configure Oracle Database Using Response Files:


        •   How Response Files Work
            Response files can assist you with installing an Oracle product multiple times on multiple
            computers.
        •   Preparing a Response File
            Describest the methods that you can use to prepare a response file for use during silent-
            mode or response file-mode installations.
        •   Running Oracle Universal Installer Using the Response File
            After creating the response file, run Oracle Univeral Installer at the command line,
            specifying the response file you created, to perform the installation.


How Response Files Work
        Response files can assist you with installing an Oracle product multiple times on multiple
        computers.
        When you start Oracle Universal Installer (OUI), you can use a response file to automate the
        installation and configuration of Oracle software, either fully or partially. OUI uses the values
        contained in the response file to provide answers to some or all installation prompts.
        Typically, the installer runs in interactive mode, which means that it prompts you to provide
        information in graphical user interface (GUI) screens. When you use response files to provide
        this information, you run Oracle Universal Installer at a command prompt using either of the
        following modes:
        •   Silent mode: If you include responses for all of the prompts in the response file and
            specify the -silent option when starting the installer, then it runs in silent mode. During a
            silent mode installation, the installer does not display any screens. Instead, it displays
            progress information in the terminal that you used to start it.
        •   Response file mode: If you include responses for some or all of the prompts in the
            response file and omit the -silent option, then the installer runs in response file mode.
            During a response file mode installation, the installer displays all the screens, screens for
            which you specify information in the response file, and also screens for which you did not
            specify the required information in the response file. To use the response file mode, run
            setup.exe without the -silent parameter, but include the response file or any other
            parameters that apply.
        Define the settings for a silent or response file installation by entering values for the variables
        listed in the response file. For instance, to specify the Oracle home, provide the appropriate
        value for the ORACLE_HOME variable, as in the following example:
        ORACLE_HOME="C:\app\product"




                                                                                                         B-1
                                                                                                               Appendix B
                                                                                               How Response Files Work

           Another way of specifying the response file variable settings is to pass them as command-line
           arguments when you run Oracle Universal Installer. For example:
           DRIVE_LETTER:\setup.exe_location> setup -silent "ORACLE_HOME=C:\app\product" ...

           This method supports only the Oracle Home User passwords.
           •    Reasons for Using Silent Mode or Response File Mode
                Review this section for use cases for running the installer in silent mode or response file
                mode.
           •    Using Response Files
                Review this information to use response files.
           Related Topics
           •    My Oracle Support


Reasons for Using Silent Mode or Response File Mode
           Review this section for use cases for running the installer in silent mode or response file mode.

           Table B-1     Reasons for Using Silent Mode or Response File Mode

           Mode                 Uses
           Silent               Use silent mode to:
                                •    Complete an unattended installation, which you schedule using operating
                                     system utilities such as at.
                                •    Complete several similar installations on multiple systems without user
                                     interaction.
                                •    Install the software on a system that does not have X Window System
                                     software installed on it.
                                The installer displays progress information on the terminal that you used to start it,
                                but it does not display any of the installer screens.
           Response file        Use response file mode to complete similar Oracle software installations on more
                                than one system, providing default answers to some, but not all of the installer
                                prompts.
                                If you do not specify information required for a particular installer screen in the
                                response file, then the installer displays that screen. It suppresses screens for
                                which you have provided all of the required information.


Using Response Files
           Review this information to use response files.


           Use the following general steps to install and configure Oracle products using the installer in
           silent or response file mode:
           1.   If you plan to use Oracle Automatic Storage Management and configure new disks, then
                you must perform the following steps:
                a.   Create partitions for DAS or SAN disks.
                b.   Manually configure the disks using the asmtoolg or asmtool utility.
           2.   Customize or create a response file for the installation settings that you need.




                                                                                                                      B-2
                                                                                                           Appendix B
                                                                                           Preparing a Response File

                You can create the response file by using one of the following methods:
                •   Modify one of the sample response files that is provided with the installation.
                •   Run Oracle Universal Installer at a command prompt and save the inputs by selecting
                    the Save Response File option.
           3.   Run Oracle Universal Installer from a command prompt, specifying the response file, using
                either silent or response file mode.



                        Note:
                        Windows requires Administrator privileges at the command prompt.


           Related Topics
           •    Running Oracle Universal Installer Using the Response File


Preparing a Response File
           Describest the methods that you can use to prepare a response file for use during silent-mode
           or response file-mode installations.
           •    Editing a Response File Template
           •    Saving a Response File


Editing a Response File Template
           Oracle provides response file templates for each product and the installation type, and for each
           configuration tool. These files are located in the ORACLE_BASE\ORACLE_HOME\assistants
           directory, and the database\response directory on the Oracle Database installation media.



                    Note:
                    If you copied the software to a hard disk, the response files are located in the
                    stage_area\database\response directory.



           All response file templates contain comment entries, sample formats, examples, and other
           useful instructions. Read the response file instructions to understand how to specify values for
           the response file variables, so that you can customize your installation.
           The following table lists the available sample response files:

           Table B-2     Response Files

           Response File Name                        Description
           client_install.rsp                        Oracle Database Client installation
           netca.rsp                                 Silent installation of Oracle Net Configuration Assistant




                                                                                                                 B-3
                                                                                                       Appendix B
                                                                                       Preparing a Response File



                   Caution:
                   When you modify a response file template and save a file for use, the response file
                   may contain plain text passwords. Ownership of the response file must be given to
                   the Oracle software installation owner only. Oracle strongly recommends that
                   database administrators or other administrators delete or secure response files when
                   they are not in use.



           To copy and modify a response file:
           1.   Copy the appropriate response files from the client\response directory on the Oracle
                Database media to your hard drive.
           2.   Modify the response files with a text file editor.
           3.   Run the response file by following the instructions in the “Running Oracle Universal
                Installer Using the Response file” section.

           Related Topics
           •    Running Oracle Universal Installer Using the Response File
                After creating the response file, run Oracle Univeral Installer at the command line,
                specifying the response file you created, to perform the installation.


Saving a Response File
           You can use the Oracle Universal Installer in interactive mode to save a response file, which
           you can edit and then use to complete silent mode or response file mode installations.
           You can save all the installation steps into a response file during installation by clicking Save
           Response File on the Summary page. You can use the generated response file for a silent
           installation later.
           When you save the response file, you can either complete the installation, or you can exit from
           Oracle Universal Installer on the Summary page, before it starts to copy the software to the
           system.



                   Note:
                   Oracle Universal Installer does not save passwords in the response file.



           To save a response file:
           1.   Ensure that the computer on which you are creating the response file has met the
                requirements. .
                When you run Oracle Universal Installer to save a response file, it checks the system to
                verify that it meets the requirements to install the software. For this reason, Oracle
                recommends that you complete all of the required preinstallation tasks and save the
                response file while completing an installation.
           2.   At the command prompt, use the cd command to change to the directory that contains the
                Oracle Universal Installer setup.exe executable.




                                                                                                            B-4
                                                                                                          Appendix B
                                                           Running Oracle Universal Installer Using the Response File



                       Note:
                       Windows requires Administrator privileges at the command prompt.


              On the installation DVD, setup.exe is located in the database directory. Alternatively,
              navigate to the directory where you downloaded or copied the installation files.
         3.   Run setup.exe.
         4.   After Oracle Universal Installer starts, enter the installation settings, to save the response
              file.
         5.   When the installer displays the Summary screen, perform the following:
              a.   Click Save Response File and specify a file name and location for the response file.
                   Then, click Save to save the values to the file.
              b.   Click Finish to continue with the installation.
                   Click Cancel if you do not want to continue with the installation. The installation stops,
                   but the saved response file is retained.
         6.   Before you use the saved response file on another system, edit the file and make any
              required changes.
              Use the instructions in the file as a guide when editing it.
         Related Topics
         •    Oracle Database Client Preinstallation Tasks
              Learn about the tasks that you must complete before you start Oracle Universal Installer.


Running Oracle Universal Installer Using the Response File
         After creating the response file, run Oracle Univeral Installer at the command line, specifying
         the response file you created, to perform the installation.
         On Windows, you must open the command prompt with the Administrator privileges. The
         Oracle Universal Installer executable, setup.exe, provides several options. For help
         information about the full set of these options, run setup.exe with the -help option, for
         example:
         DRIVE_LETTER:\setup.exe_location setup -help

         A new command window appears, with the "Preparing to launch..." message. In a moment, the
         help information appears in that window.
         To run Oracle Universal Installer and specify a response file:
         1.   Place the response file on the computer where you want to install Oracle Database Client.
         2.   At a command prompt, run Oracle Universal Installer with the appropriate response file. On
              Windows, you must open command prompt with the Administrator privileges. For example:


              DRIVE_LETTER:\setup.exe_location setup [-silent] "variable=setting" [-noconfig] [-
              nowait] -responseFile
               filename

              where:




                                                                                                                B-5
                                                                                           Appendix B
                                            Running Oracle Universal Installer Using the Response File

•   filename: Identifies the full path of the response file.
•   setup.exe_location: Indicates the location of setup.exe.
•   -silent: Runs Oracle Universal Installer in silent mode and suppresses the Welcome
    window.
•   "variable=setting" refers to a variable within the response file that you may prefer to
    run at the command line rather than set in the response file. Enclose the variable and
    its setting in quotes.
•   -noconfig: Suppresses running the configuration assistants during installation,
    performing a software-only installation instead.
•   -nowait: Closes the console window when the silent installation completes.
If you save a response file during a silent installation, then Oracle Universal Installer saves
the variable values that were specified in the original source response file into the new
response file.




                                                                                                 B-6
C
Configuring Networks for Oracle Database
          Typically, the computer on which you want to install Oracle Database is connected to the
          network, has a local storage to contain the Oracle Database installation, has a display monitor,
          and has a media drive.


          Configuring networks for Oracle Database describes how to install Oracle Database on
          computers that do not meet the typical scenario.
          •    Installing Oracle Database on Computers with Multiple IP Addresses
               Use this procedure to set the ORACLE_HOSTNAME environment variable.
          •    Installing Oracle Database on Computers with Multiple Aliases
               A computer with multiple aliases is registered with the naming service under a single IP
               address but with multiple aliases.
          •    Installing Oracle Database on Nonnetworked Computers
               You can install Oracle Database on non-networked computers.
          •    Installing a Loopback Adapter
               A loopback adapter is required if you are installing on a non-networked computer to
               connect the computer to a network after the installation.


Installing Oracle Database on Computers with Multiple IP
Addresses
          Use this procedure to set the ORACLE_HOSTNAME environment variable.

          Clients must be able to access the computer using its host name, or using aliases for its host
          name. To check access, ping the host name from the client computers using the short name
          (host name only) and the fully qualified domain name (FQDN, host name and domain name).
          Both must work.


          1.   Display System in the Windows Control Panel.
          2.   In the System Properties dialog box, click Advanced.
          3.   In the Advanced tab, click Environment Variables.
          4.   In the Environment Variables dialog box, under System Variables, click New.
          5.   In the New System Variable dialog box, enter the following information:
               •   Variable name: ORACLE_HOSTNAME
               •   Variable value: The host name of the computer to use.
          6.   Click OK, then in the Environment Variables dialog box, click OK.
          7.   Click OK in the Environment Variables dialog box, then in the System Properties dialog
               box, click OK.




                                                                                                        C-1
                                                                                                         Appendix C
                                                       Installing Oracle Database on Computers with Multiple Aliases




Installing Oracle Database on Computers with Multiple Aliases
          A computer with multiple aliases is registered with the naming service under a single IP
          address but with multiple aliases.
          The naming service resolves any of those aliases to the same computer. Before installing
          Oracle Database on such a computer, set the ORACLE_HOSTNAME environment variable to the
          computer whose host name you want to use.


Installing Oracle Database on Nonnetworked Computers
          You can install Oracle Database on non-networked computers.
          If the computer, such as a laptop, is configured for DHCP and you plan to connect the
          computer to the network after the Oracle Database installation.
          Perform these steps before you install Oracle Database on the non-networked computer:
          1.   Install a loopback adapter on the computer.
               The loopback adapter and the local IP address simulate a networked computer. If you
               connect the computer to the network, Oracle Database still uses the local IP address and
               host name.
          2.   Ping the computer from itself, using only the host name and using the fully qualified name,
               which is in the DRIVE_LETTER:\system32\drivers\etc\hosts file.
               For example, if you installed a loopback adapter on a computer called mycomputer on the
               us.example.com domain, check the following:
               DRIVE_LETTER:\>ping mycomputer                     Ping itself using just the hostname.

               Reply from 10.10.10.10                    Returns local IP.
               DRIVE_LETTER:\>ping mycomputer.us.example.com   Ping using a fully qualified name.
               Reply from 10.10.10.10                    Returns local IP.



                      Note:
                      When you ping a computer from itself, the ping command must return the local
                      IP address (the IP address of the loopback adapter).


               If the ping command fails, contact your network administrator.
          If you connect the computer to a network after installation, the Oracle Database instance on
          your computer can work with other instances on the network. Remember that you must have
          installed a loopback adapter on your computer. Your computer can use a static IP or DHCP,
          depending on the network to which you are connected.


Installing a Loopback Adapter
          A loopback adapter is required if you are installing on a non-networked computer to connect
          the computer to a network after the installation.
          When you install a loopback adapter, the loopback adapter assigns a local IP address for your
          computer. After the loopback adapter is installed, there are at least two network adapters on



                                                                                                               C-2
                                                                                                       Appendix C
                                                                                     Installing a Loopback Adapter

           your computer: your own network adapter and the loopback adapter. To run Oracle Database
           on Windows, set the loopback adapter as the primary adapter.
           You can change the bind order for the adapters without reinstalling the loopback adapter. The
           bind order of the adapters to the protocol indicates the order in which the adapters are used.
           When the loopback adapter is used first for the TCP/IP protocol, all programs that access
           TCP/IP first probe the loopback adapter. The local address is used for tools, such as Oracle
           Enterprise Manager. Applications that use a different Ethernet segment are routed to the
           network card.
           •   Checking if a Loopback Adapter is Installed on Your Computer
               Review this section to verify if a loopback adapter is installed on your computer by running
               the ipconfig /all command.
           •   Installing a Loopback Adapter
               Use this procedure to install a Loopback Adapter or a Microsoft KM-TEST Loopback
               Adapter on different Windows versions.
           •   Removing a Loopback Adapter
               Use this procedure to remove a Loopback Adapter or a Microsoft KM-TEST Loopback
               Adapter on different Windows versions.
           Related Topics
           •   Installing Oracle Database on Nonnetworked Computers


Checking if a Loopback Adapter is Installed on Your Computer
           Review this section to verify if a loopback adapter is installed on your computer by running the
           ipconfig /all command.

           To check if a loopback adapter is installed on your computer, run the ipconfig /all command:
           DRIVE_LETTER:\>ipconfig /all



                  Note:
                  Loopback Adapter installed on the computer must be the Primary Network Adapter.



           If there is a loopback adapter installed, you see a section that lists the values for the loopback
           adapter. For example:
           Ethernet adapter Local Area Connection 2:
           Connection-specific DNS Suffix . :
           Description . . . . . . . . . . . : Microsoft Loopback Adapter
           Physical Address. . . . . . . . . : 02-00-4C-4F-4F-50
           DHCP Enabled. . . . . . . . . . . : No
           IP Address. . . . . . . . . . . . : 10.10.10.10
           Subnet Mask . . . . . . . . . . . : 255.255.0.0


Installing a Loopback Adapter
           Use this procedure to install a Loopback Adapter or a Microsoft KM-TEST Loopback Adapter
           on different Windows versions.
           The Microsoft Loopback Adapter in Microsoft Windows 7 is renamed to Microsoft KM-TEST
           Loopback Adapter in Microsoft Windows 8.1 and later releases.




                                                                                                             C-3
                                                                                           Appendix C
                                                                         Installing a Loopback Adapter

To install a Loopback Adapter on Microsoft Windows 7 or to install Microsoft KM-Test Loopback
Adapter on Microsoft Windows 8.1, Microsoft Windows Server 2012, Microsoft Windows
Server 2012 R2, and Microsoft Windows Server 2016 perform the following steps:
1.   Click Start and enter hdwwiz in the Search box. Click hdwwiz to start the Add Hardware
     wizard.
     For Microsoft Windows 8.1 and later releases, open the Windows Control Panel and
     double-click Add Hardware to start the Add Hardware wizard.
2.   In the Welcome window, click Next.
3.   In the The wizard can help you install other hardware window, select Install the hardware
     that I manually select from a list, and click Next.
4.   From the list of hardware types, select the type of hardware you are installing, select
     Network adapters, and click Next.
5.   In the Select Network Adapter window, make the following selections:
     •    Manufacturer: Select Microsoft.
     •    Network Adapter: Select Microsoft Loopback Adapter for Microsoft Windows 7 and
          Microsoft KM-TEST Loopback Adapter for Microsoft Windows Server 8.1 and later
          releases.
6.   Click Next.
7.   In the The wizard is ready to install your hardware window, click Next.
8.   In the Completing the Add Hardware Wizard window, click Finish.
9.   Click Manage Network Connections. This displays the Network Connections Control
     Panel item.
10. Right-click the connection that was just created. This is usually named "Local Area
     Connection 2". Choose Properties.
11. On the General tab, select Internet Protocol (TCP/IP), and click Properties.

12. In the Properties dialog box, click Use the following IP address and do the following:

     a.   IP Address: Enter a non-routable IP for the loopback adapter. Oracle recommends the
          following non-routable addresses:
          •   192.168.x.x (x is any value between 0 and 255)
          •   10.10.10.10
     b.   Subnet mask: Enter 255.255.255.0.
     c.   Record the values you entered, which you need later in this procedure.
     d.   Leave all other fields empty.
     e.   Click OK.
13. Click Close.

14. Close Network Connections.

15. Restart the computer.

16. Add a line to the DRIVE_LETTER: \WINDOWS\system32\drivers\etc\hosts file with the
     following format, after the localhost line:
     IP_address       hostname.domainname   hostname

     where:




                                                                                                 C-4
                                                                                                  Appendix C
                                                                                Installing a Loopback Adapter

               •    IP_address is the non-routable IP address.
               •    hostname is the name of the computer.
               •    domainname is the name of the domain.
               For example:
               10.10.10.10    mycomputer.us.example.com     mycomputer

          17. Check the network configuration:

               a.   Open System in the Control Panel, and verify that Full computer name displays the
                    host name and the domain name, for example, sales.us.example.com.
               b.   Click Change. In Computer name, you must see the host name, and in Full
                    computer name, you must see the host name and domain name. Using the previous
                    example, the host name must be sales and the domain must be us.example.com.
               c.   Click More. In Primary DNS suffix of this computer, you must see the domain name,
                    for example, us.example.com.


Removing a Loopback Adapter
          Use this procedure to remove a Loopback Adapter or a Microsoft KM-TEST Loopback Adapter
          on different Windows versions.
          To remove a Loopback Adapter on Microsoft Windows 7 or to remove Microsoft KM-Test
          Loopback Adapter on Microsoft Windows 8.1, Microsoft Windows Server 2012, Microsoft
          Windows Server 2012 R2, and Microsoft Windows Server 2016, perform the following steps:
          1.   Display System in the Windows Control Panel.
          2.   In the Hardware tab, click Device Manager.
          3.   For Microsoft Windows 7, in the Device Manager window, expand Network adapters. You
               must see Microsoft Loopback Adapter. For Microsoft Windows 8.1 and later releases,
               you must see Microsoft KM-TEST Loopback Adapter.
          4.   For Microsoft Windows 7, right-click Microsoft Loopback Adapter and select Uninstall.
               For Microsoft Windows 8.1 and later releases, right-click Microsoft KM-TEST Loopback
               Adapter and select Uninstall.
          5.   Click OK.
          6.   Restart the computer.
          7.   Remove the line from the DRIVE_LETTER:\WINDOWS\system32\drivers\etc\hosts file,
               added after the localhost line while installing the loopback adapter on other Windows
               operating systems.




                                                                                                        C-5
D
Configuring Oracle Database Globalization
Support
           Learn how to configure Oracle Database Globalization Support.


           •   Installing and Using Oracle Components in Different Languages
               Learn how to install and use Oracle components in other languages.
           •   Running Oracle Universal Installer in Different Languages
               Learn how to run Oracle Universal Installer in other languages.


Installing and Using Oracle Components in Different Languages
           Learn how to install and use Oracle components in other languages.
           •   Configuring Oracle Components to Run in Different Languages
               You can specify the language and the territory, or locale, in which you want to use Oracle
               components.
           •   Installing Translation Resources
               Learn how to install the appropriate language translation resources.


Configuring Oracle Components to Run in Different Languages
           You can specify the language and the territory, or locale, in which you want to use Oracle
           components.
           The locale setting of a component determines the language of the user interface of the
           component and the globalization behavior, such as date and number formatting. Depending on
           the Oracle component, the locale of the component is either inherited from the operating
           system session that started the component, or is defined by the NLS_LANG environment
           variable.
           The operating system locale usually influences Oracle components that are based on Java
           technology. The NLS_LANG environment variable usually influences Oracle components that use
           Oracle Client libraries such as OCI.



                  Note:
                  The user interface of an Oracle component is displayed in a selected language only if
                  the appropriate translation is available and has been installed. Otherwise, the user
                  interface is displayed in English.




                                                                                                        D-1
                                                                                                         Appendix D
                                                       Installing and Using Oracle Components in Different Languages

            •   Determining the Operating System Locale
                The locale setting of your operating system session determines the language of the user
                interface and the globalization behavior for components such as Oracle Universal Installer,
                Oracle Net Configuration Assistant, and Oracle Database Configuration Assistant.
            •   Configuring Locale and Character Sets Using the NLS_LANG Environment Variable
                The NLS_LANG environment variable determines the language of the user interface and the
                globalization behavior for components such as SQL*Plus, exp, and imp.
            •   NLS_LANG Settings in Console Mode and Batch Mode
                Before you can use Oracle utilities such as SQL*Plus, SQL Loader, Import, and Export
                from the Command Prompt window, set the character set field of the NLS_LANG parameter
                to a value different than the one set in Registry.

Determining the Operating System Locale
            The locale setting of your operating system session determines the language of the user
            interface and the globalization behavior for components such as Oracle Universal Installer,
            Oracle Net Configuration Assistant, and Oracle Database Configuration Assistant.
            It also determines the globalization behavior of Oracle Database sessions created by a user
            application through Oracle JDBC driver, unless overridden by the application.
            Open the Control Panel from the Start menu to modify the operating system locale settings. In
            the classic view of the Control Panel on Windows, click Regional and Language Options. In
            the default view of the Control Panel on Windows, click Change keyboards or other input
            methods.
            To set locale for the current operating system user on Windows, select the desired locale from
            the Current format pop-up list on the Formats tab.
            Some of the locales are unavailable until you install the required operating system support
            files.
            Some Oracle components, such as SQL*Plus, require that the Windows System Locale is also
            set to the language in which the components are to be run. System Locale is called Language
            for non-Unicode programs on Windows. On Windows, click the Change system locale...
            button on the Administrative tab, accept the use of administrative privileges, if User Account
            Control is active, and select the locale from the pop-up list in the opened dialog box.



                   Note:
                   The operating system must be restarted after the System Locale is changed. See the
                   operating system documentation for further information about Windows locale
                   settings.



Configuring Locale and Character Sets Using the NLS_LANG Environment Variable
            The NLS_LANG environment variable determines the language of the user interface and the
            globalization behavior for components such as SQL*Plus, exp, and imp.
            It sets the language and territory used by the client application and the database user session.
            It also declares the character set for entering and displaying data by the client application.
            The NLS_LANG environment variable uses the following format:




                                                                                                               D-2
                                                                                             Appendix D
                                           Installing and Using Oracle Components in Different Languages

NLS_LANG=language_territory.characterset

In this format:
•   language specifies the language used for displaying Oracle messages, sorting, day
    names, and month names
•   territory specifies the conventions for default date, monetary and numeric formats
•   characterset specifies the encoding used by the client application
    In most cases, this is the Oracle character set that corresponds to the Windows ANSI
    Code Page as determined by the System Locale.
The NLS_LANG parameter on Windows can be set

•   in Registry under the subkey corresponding to a given Oracle home,
•   as an environment variable.
When you install Oracle Database components and the NLS_LANG parameter is not yet set in
the Registry subkey of the target Oracle home, Oracle Universal Installer sets the NLS_LANG
parameter to a default value derived from the operating system locale for the current user. See
the following table.
For example:
•   Arabic (U.A.E.) - ARABIC_UNITED ARAB EMIRATES.AR8MSWIN1256
•   Chinese (PRC) - SIMPLIFIED CHINESE_CHINA.ZHS16GBK
•   Chinese (Taiwan) - TRADITIONAL CHINESE_TAIWAN.ZHT16MSWIN950
•   English (United Kingdom) - ENGLISH_UNITED KINGDOM.WE8MSWIN1252
•   English (United States) - AMERICAN_AMERICA.WE8MSWIN1252
•   French (Canada) - CANADIAN FRENCH_CANADA.WE8MSWIN1252
•   French (France) - FRENCH_FRANCE.WE8MSWIN1252
•   German (Germany) - GERMAN_GERMANY.WE8MSWIN1252
•   Hebrew - HEBREW_ISRAEL.IW8MSWIN1255
•   Japanese - JAPANESE_JAPAN.JA16SJISTILDE
•   Russian - RUSSIAN_RUSSIA.CL8MSWIN1251
•   Spanish (Spain) - SPANISH_SPAIN.WE8MSWIN1252
•   Spanish (Mexico) - MEXICAN SPANISH_MEXICO.WE8MSWIN1252
•   Spanish (Venezuela) - LATIN AMERICAN SPANISH_VENEZUELA.WE8MSWIN1252



       Note:
       Oracle Database Globalization Support Guide for information about the NLS_LANG
       parameter and Globalization Support initialization parameters




                                                                                                   D-3
                                                                                                             Appendix D
                                                           Installing and Using Oracle Components in Different Languages



NLS_LANG Settings in Console Mode and Batch Mode
           Before you can use Oracle utilities such as SQL*Plus, SQL Loader, Import, and Export from
           the Command Prompt window, set the character set field of the NLS_LANG parameter to a value
           different than the one set in Registry.
           This is required because programs running in console mode use, with a few exceptions, a
           different code page (character set) from programs running in GUI mode. The default Oracle
           home NLS_LANG parameter in the Registry is always set to the appropriate GUI code page. If
           you do not set the NLS_LANG parameter for the console mode session correctly, incorrect
           character conversion can corrupt error messages and data.
           For Japanese, Korean, Simplified Chinese, Traditional Chinese, Thai, and Vietnamese, the
           console (OEM) code page is identical to the GUI (ANSI) code page. In this case, you are not
           required to set the NLS_LANG parameter. For other languages, set the correct character set
           value of NLS_LANG by issuing a SET NLS_LANG command in the same Command Prompt
           window in which you want to start the affected utility.
           Similarly, in batch mode, set the correct character set value of NLS_LANG by inserting a SET
           NLS_LANG command at the start of the batch procedure, according to the character set of the
           files to be processed in the procedure.
           To find the current console code page, issue the CHCP command in the Command Prompt
           window. Use the reported code page number to look up the corresponding Oracle character
           set name in the following table.
           The following table lists the Oracle character sets that correspond to the console mode code
           pages.

           Table D-1         Oracle Character Sets for Console Mode (OEM) Code Pages

            OEM Code Page                    Oracle Character Set for Console Mode
            437 (US)                         US8PC437
            737 (Greek)                      EL8PC737
            775 (Baltic)                     BLT8PC775
            850 (Multilingual Latin I)       WE8PC850
            852 (Latin II)                   EE8PC852
            855 (Cyrillic)                   RU8PC855
            857 (Turkish)                    TR8PC857
            858 (Multilingual Latin I + Euro) WE8PC858
            866 (Russian)                    RU8PC866
            874 (Thai)                       TH8TISASCII
            932 (Japanese Shift-JIS)         JA16SJISTILDE
            936 (Simplified Chinese GBK)     ZHS16GBK
            949 (Korean)                     KO16MSWIN949
            950 (Traditional Chinese Big5)   ZHT16MSWIN950
            1258 (Vietnam)                   VN8MSWIN1258




                                                                                                                   D-4
                                                                                                          Appendix D
                                                        Installing and Using Oracle Components in Different Languages



Installing Translation Resources
           Learn how to install the appropriate language translation resources.
           To view the user interface of Oracle components in different languages, you must install the
           appropriate language translations along with the component.



                   Note:
                   Part of Oracle Database Vault user interface text is stored in database tables in the
                   DVSYS schema. By default, only the English language is loaded into these tables.
                   You can use Oracle Database Vault Configuration Assistant to add more languages
                   to Oracle Database Vault.



           To install translation resources:
           1.   Start Oracle Universal Installer.
           2.   In the Configure Security Updates screen enter the relevant information and click Next.
           3.   In the Select Installation Option screen, select the installation option and click Next.
           4.   In the System Class screen, select the type of system class for installing the database, and
                click Next.
           5.   In the Grid Installation Options screen, select the type of database installation you want to
                perform, and click Next.
           6.   In the Select Product Languages screen, select the language in which you want to run the
                product from the Available Languages field.



                       Note:
                       The Available Languages field lists all languages supported by Oracle
                       globalization libraries. The set of languages for which a translation is actually
                       available is usually smaller and depends on a particular component. The scope
                       of translation for a given component may differ between languages. For example,
                       some translations may include all user interface text, while others may include
                       only error messages and no help files.


           7.   Use the > arrow to move the selected language to the Selected Languages field, and
                then click Next.



                       Note:
                       Oracle Universal Installer ignores languages in the Selected Languages field for
                       which no translation is available.




                                                                                                                D-5
                                                                                                          Appendix D
                                                            Running Oracle Universal Installer in Different Languages




Running Oracle Universal Installer in Different Languages
          Learn how to run Oracle Universal Installer in other languages.
          Your operating system locale determines the language in which Oracle Universal Installer runs.
          You can run Oracle Universal Installer in one of these languages:
          •    Brazilian Portuguese (pt_BR)
          •    French (fr)
          •    German (de)
          •    Italian (it)
          •    Japanese (ja)
          •    Korean (ko)
          •    Simplified Chinese (zh_CN)
          •    Spanish (es)
          •    Traditional Chinese (zh_TW)
          To run Oracle Universal Installer in a supported language, change the locale in which your
          operating system session is running before you start Oracle Universal Installer. If the selected
          language is not one of the supported languages, then Oracle Universal Installer runs in
          English.
          1.   Change the locale for the operating system user and the System Locale as described in
               the section “Determining the Operating System Locale"Determining the Operating System
               Locale"
          2.   Run Oracle Universal Installer by following the instructions in the section "Installing Oracle
               Database“ in Chapter 6.




                                                                                                                D-6
Index
A                                                 G
accessibility software, Java Access Bridge, A-1   globalization support, D-1
account control, 2-9
aliases, multiple on computers, C-2
                                                  H
B                                                 host name, setting before installation, C-1

bind order of the adapters
    about, C-3
                                                  I
                                                  image
C                                                     install, 3-2
                                                  installation, 3-8
components                                            accessing installation software, 3-2
    for single Oracle homes, 3-2                      computer aliases, multiple, C-2
    installation of single Oracle home                DVD drive, 3-3
              components, 3-2                         Java Access Bridge, A-2
computers with multiple aliases, C-2                  laptops, C-2
computers, non-networked, C-2                         postinstallation tasks, 4-1
configuration assistants                              remote installation with remote access
    suppressing during silent or response file                  software, 3-4
              installation, B-6                       remote installation, DVD drive, 3-3
                                                      single Oracle home components, 3-2
                                                  installation software, accessing, 3-2
D
Deinstallation Tool                               J
    about, 5-2
disk space                                        Java Access Bridge
    checking, 2-3                                    about, A-1
documentation                                        installing, A-2
    additional Oracle documentation, ix           JRE (Java Runtime Environment)
DVD drive, installing from, 3-3                      requirements, 2-2

E                                                 L
environment variables                             languages
    NLS_LANG, D-2                                     installing Oracle components in different
    TEMP and TMP                                               languages, D-6
       hardware requirements, 2-4                     using Oracle components in different
                                                               languages, D-5
                                                  laptops, installing Oracle Database on, C-2
F                                                 loopback adapters, C-2
file systems                                          about, C-2
     system requirements, 2-2                         checking if installed, C-3
                                                      computers with multiple aliases, C-2




                                                                                                Index-1
                                                                                                        Index

loopback adapters (continued)                         Oracle Database Client, installation, 3-8
    installing, C-2                                   Oracle Database Configuration Assistant (DBCA)
    installing on Windows Server 2008, C-4                suppressing during silent or response file
    non-networked computers, C-2                                   installation, B-6
    removing, C-5                                     Oracle home directory
        See also network adapters, primary network        multiple homes, network considerations, C-1
        adapters                                          multiple homes, precedence of components,
                                                                   3-2
M                                                         single Oracle home components, 3-2
                                                      Oracle host name, setting before installation, C-1
multihomed computers, installing on, C-1              Oracle Net Configuration Assistant, installation,
multiple aliases, computers with, C-2                          3-9
multiple Oracle homes                                 Oracle Provider for OLE DB
    setting, C-1                                          behavior with multiple Oracle homes, 3-2
                                                      oracle service user, 2-8
                                                      Oracle Universal Installer
N                                                         location of executable, B-5
Net Configuration Assistant (NetCA)                       running in different languages, D-6
    suppressing during silent or response file        Oracle Universal Installer (OUI),
              installation, B-6                           response files, B-1
netca.rsp file                                            running at command line, B-5
    about, B-3                                        ORACLE_HOSTNAME environment variable
network adapters, C-2                                     computers with multiple aliases, C-2
    computers with multiple aliases, C-2                  setting before installation, C-1
    how primary adapter is determined, C-3
    non-networked computers, C-2                      P
    primary, on computers with multiple aliases,
              C-2                                     patch updates, 4-1
        See also loopback adapters, primary network   postinstallation tasks, 4-1
        adapters                                      primary network adapters, C-3
network cards, multiple, C-1                              how determined, C-3
network protocols, supported, 2-5                             See also loopback adapters, network adapters
network topics
    computers with multiple aliases, C-2
    laptops, C-2                                      R
    listed, C-1                                       release update revisions, 4-1
    loopback adapters, C-2                            release updates, 4-1
    multiple network cards, C-1                       remote access software, 3-4
    non-networked computers, C-2                      remote installations
NLS_LANG environment variable, D-2                        DVD drive, 3-3
non-networked computers, C-2                              remote access software, 3-4
NTFS system requirements, 2-2                         requirements
                                                          for JRE, 2-2
O                                                         hard disk space, 2-2
                                                          hardware, verifying, 2-3
operating systems, supported, 2-4                         Oracle Database Client, 2-5
Oracle Automatic Storage Management (Oracle               software, 2-4
        ASM)                                              Windows Terminal Services, 2-9
   silent or response file mode installations, B-2    response file mode, B-1
Oracle components                                         about, B-1
   using in different languages, D-5                      reasons for using, B-2
Oracle Database                                               See also response file mode
   Windows Terminal Services support, 2-9                     See also response files, silent mode
Oracle Database Client                                response files
   image-based installation, 3-8                          about, B-1
   requirements, 2-5




                                                                                                     Index-2
                                                                                                 Index

response files (continued)                            temporary disk space (continued)
    creating                                             freeing, 2-3
        with record mode, B-4                         tmp directory
        with template, B-3                               checking space in, 2-3
    general procedure, B-2                               freeing space in, 2-3
    netca.rsp, B-3                                    TMP environment variable
    passing values at command line, B-1                  hardware requirements, 2-4
    specifying with Oracle Universal Installer, B-5
    using, B-1
response files installation
                                                      U
    about, B-1                                        unsupported components
                                                          on Windows Terminal Services, 2-9
S                                                     user account control, 2-9
                                                      user accounts, managing, 2-9
setup.exe
    See Oracle Universal Installer (OUI)
silent mode, B-1                                      W
     about, B-1                                       Windows
     reasons for using, B-2                              compilers, supported, 2-5
        See also response file mode, response files      network protocol, supported, 2-5
single Oracle home components, 3-2                       operating systems, supported, 2-4
system requirements                                   Windows 7
    on NTFS file systems, 2-2                            user account control, 2-9
                                                      Windows 8
T                                                        user account control, 2-9
                                                      Windows Server 2008
TEMP environment variable, hardware                      user account control, 2-9
       requirements, 2-4                              Windows Server 2008 R2
temporary directory, 2-3                                 user account control, 2-9
temporary disk space                                  Windows Terminal Services
   checking, 2-3                                         support, 2-9
                                                         unsupported components, 2-9




                                                                                              Index-3

