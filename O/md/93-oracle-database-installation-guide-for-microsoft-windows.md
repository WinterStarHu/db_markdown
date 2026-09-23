# 93. Oracle Database Installation Guide for Microsoft Windows

> 源文件: `en/ntdbi/oracle-database-installation-guide-microsoft-windows.pdf`

Oracle® Database
Database Installation Guide




    19c for Microsoft Windows
    E96293-13
    November 2025
Oracle Database Database Installation Guide, 19c for Microsoft Windows

E96293-13

Copyright © 2015, 2025, Oracle and/or its affiliates.

Primary Author: Sunil Surabhi

Contributing Authors: Prakash Jashnani, Jean-Francois Verrier

Contributors: Sivaselvam Narayanasamy, Barb Glover, Eric Belden, Sudip Datta, David Friedman, Alex Keh, Peter
LaQuerre, Rich Long, Matt McKerley, Sham Rao Pavan, Hanlin Qian, Sujatha Tolstoy, Sergiusz Wolicki, Sue Mavris,
Mohammed Shahnawaz Quadri, Vishal Saxena, Krishna Itikarlapalli, Santanu Datta, Christian Shay, Aneesh
Khanderwal, Michael Coulter, Robert Achacoso, Malai Stalin, David Price, Ramesh Chakravarthula

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
           Audience                                                                                             i
           Documentation Accessibility                                                                          i
           Set Up Java Access Bridge to Implement Java Accessibility                                           ii
           Related Documentation                                                                               ii
           Conventions                                                                                         ii


           Changes in this Release for Oracle Database Installation Guide
           Changes in Oracle Database 19c                                                                       i



1          Oracle Database Installation Checklist
           Server Hardware Checklist for Oracle Database Installation                                          1
           Operating System Checklist for Oracle Database Installation on Microsoft Windows                    2
           Server Configuration Checklist for Oracle Database Installation                                     2
           Storage Checklist for Oracle Database Installation                                                  3
           Oracle User Environment Configuration Checklist for Oracle Database Installation                    4
           Installer Planning Checklist for Oracle Database Installation                                       5



2          Oracle Database Preinstallation Tasks
           Oracle Database Minimum Hardware Requirements                                                       1
                 Hardware Component Requirements for Windows x64                                               1
                 Hard Disk Space Requirements                                                                  2
                 Verifying Hardware Requirements                                                               3
           Oracle Database Software Requirements                                                               3
           Windows Certification and Web Browser Support                                                       5
                 Remote Desktop Services                                                                       5
                 Microsoft Windows Servicing Options                                                           6
                 Installation Requirements for Web Browsers                                                    6
                 Default Share Configuration Requirement                                                       6
           Reviewing Operating System Security Common Practices                                                7
           Confirming Host Name Resolution                                                                     7


Database Installation Guide
E96293-13                                                                                     November 12, 2025
Copyright © 2015, 2025, Oracle and/or its affiliates.                                              Page i of viii
           Individual Component Requirements                                                                         7
                 Configuring Disk Storage for Oracle Data Files and Recovery Files                                   8
                      Choosing a Storage Option for Oracle Database and Recovery Files                               8
                 Creating Directories for Oracle Data Files or Recovery Files                                        8
                      Guidelines for Placing Oracle Database Files on a File System or Logical Volume                8
                      Guidelines for Placing Oracle Recovery Files on a File System                                  9
                      Creating Required Directories                                                                10
                 Oracle Database Security Strong Authentication Requirements                                       10
                 Oracle Enterprise Manager Requirements                                                            10
                 Oracle-Managed Files Requirements                                                                  11
                 Oracle Volume Shadow Copy Service (VSS) Writer                                                     11



3          Overview of Oracle Database Installation
           Installation Considerations                                                                               1
                 Oracle Base Directory                                                                               1
                 Oracle Home Directory                                                                               2
                      Contents of the Oracle Home Environment                                                        2
                      Multiple Oracle Home Components                                                                3
                 Oracle Inventory Directory                                                                          3
                 Installing Oracle Database Vault in an Oracle Data Guard Environment                                3
                 Oracle Database Vault Default Audit Policy and Initialization Parameters                            3
                 Consider Memory Allocation and Automatic Memory Management                                          4
           Database Configuration Options                                                                            4
                 Creating a Database After Installation                                                              4
                      Creating an Oracle Database on Direct NFS                                                      5



4          Configuring Users, Groups and Environments for Oracle Database
           Creating Required Operating System Groups and Users                                                       1
                 About the Oracle Installation User                                                                  2
                 Creating Oracle Home User                                                                           2
                 Understanding the Oracle Inventory Directory and the Oracle Inventory Group                         3
                 Operating System Groups Created During Oracle Database Installation                                 4
                 Operating System Groups and Users for Job Role Separation                                           6
                      About Job Role Separation Operating System Privileges Groups and Users                         7
                      Oracle Software Owner for Each Oracle Software Product                                         7
                      Standard Oracle Database Groups for Job Role Separation                                        7
                      Extended Oracle Database Groups for Job Role Separation                                        8
                      Oracle Automatic Storage Management Groups for Job Role Separation                             9
                      Windows Group Managed Service Accounts and Virtual Accounts                                  10
                      Microsoft Hyper-V Requirements                                                               10



Database Installation Guide
E96293-13                                                                                          November 12, 2025
Copyright © 2015, 2025, Oracle and/or its affiliates.                                                   Page ii of viii
           Stopping Existing Oracle Services                                                                      10
           Configuring User Accounts                                                                              11
                 Configuring Environment Variables for the Software Installation Owner                            11
                 Managing User Accounts with User Account Control                                                 11
           Creating Oracle Database Vault User Accounts                                                           12



5          Configuring File System Storage for Oracle Database
           About Direct NFS Client Storage                                                                          2
           About the Oranfstab File for Direct NFS Client                                                           2
           Mounting NFS Storage Devices with Direct NFS Client                                                      3
           Specifying Network Paths for a NFS Server                                                                3
           Creating an oranfstab File for Direct NFS Client                                                         3
           Performing Basic File Operations Using the ORADNFS Utility                                               6
           Monitoring Direct NFS Client Usage                                                                       6
           Enabling Direct NFS Client                                                                               6
           Disabling Direct NFS Client                                                                              7
           Enabling HCC on Direct NFS Client                                                                        7



6          Installing and Configuring Oracle Grid Infrastructure for a Standalone
           Server
           Requirements for an Oracle Restart Installation                                                          3
                 System Requirements                                                                                3
                 Memory Requirements                                                                                3
                 Disk Space Requirements                                                                            4
           Oracle ACFS and Oracle ADVM                                                                              4
                 Oracle ACFS and Oracle ADVM Support on Microsoft Windows                                           4
                 Restrictions and Guidelines for Oracle ACFS                                                        5
           Oracle Automatic Storage Management Storage Configuration                                                6
                 About Managing Disk Groups for Older Database Versions                                             6
                 Oracle Automatic Storage Management Installation Considerations                                    6
                 Configuring Storage for Oracle Automatic Storage Management                                        7
                      Identifying Storage Requirements for Oracle Automatic Storage Management                      7
                      Oracle ASM Disk Space Requirements                                                          10
                      ASM Disk Group Options for Interactive and Noninteractive Installation                      11
                      Configuring Disks Manually for Oracle Automatic Storage Management                          13
           About Upgrading Existing Oracle Automatic Storage Management Instances                                 15
           Configuring Oracle Automatic Storage Management Disk Groups Manually Using Oracle
           ASMCA                                                                                                  16
           About Image-Based Oracle Grid Infrastructure Installation                                              16
           Setup Wizard Installation Options for Creating Images                                                  17



Database Installation Guide
E96293-13                                                                                        November 12, 2025
Copyright © 2015, 2025, Oracle and/or its affiliates.                                                 Page iii of viii
           Installing Oracle Grid Infrastructure for a Standalone Server with a New Database
           Installation                                                                                                18
           Installing Oracle Grid Infrastructure for a Standalone Server for an Existing Database                      19
           Installing Oracle Grid Infrastructure for a Standalone Server Using a Software-Only
           Installation                                                                                                19
                 Installing Software Binaries for Oracle Grid Infrastructure for a Standalone Server                   20
                 Configuring Software Binaries for Oracle Grid Infrastructure for a Standalone Server                  20
           Testing the Oracle Automatic Storage Management Installation                                                21
           Modifying Oracle Grid Infrastructure for a Standalone Server Binaries After Installation                    22



7          Installing Oracle Database
           Preinstallation Considerations for Installing Oracle Database                                                 1
                 Installation Consideration on Windows                                                                   2
                 Performing Multiple Oracle Database Installations                                                       2
                 Installing on Systems That Already Have Oracle Components                                               2
                 Installing with Minimum Memory Requirements                                                             3
           Reviewing Component-Specific Installation Guidelines                                                          3
           Using an Oracle Automatic Storage Management Disk Group                                                       4
           About Character Set Selection During Installation                                                             5
           Accessing the Installation Software                                                                           6
                 Downloading Oracle Software                                                                             6
                      Downloading the Installation Archive Files from Oracle Technology Network                          7
                      Downloading the Software from Oracle Software Delivery Cloud                                       7
                      Extracting the Installation File                                                                   8
                 Installing on Remote Computers Through Remote Access Software                                           8
                      Installing on Remote Computers from a Hard Drive                                                   8
                      Installing on Remote Computers from a Remote DVD Drive                                             9
                 Installing from a Remote DVD Drive                                                                      9
                      Step 1: On the Remote Computer, Share the DVD Drive                                                9
                      Step 2: On the Local Computer, Map the DVD Drive                                                 10
                 Copying the Oracle Database Software to a Hard Disk                                                   10
           Installing and Using Oracle Components in Different Languages                                               10
                 Configuring Oracle Components to Run in Different Languages                                            11
                 Determining the Operating System Locale                                                                11
                 Configuring Locale and Character Sets Using the NLS_LANG Environment Variable                         12
                 NLS_LANG Settings in Console Mode and Batch Mode                                                      13
                 Installing Translation Resources                                                                      14
           Running Oracle Universal Installer in Different Languages                                                   14
           About Image-Based Oracle Database Installation                                                              15
           Setup Wizard Installation Options for Creating Images                                                       15
           Installing the Oracle Database Software                                                                     16
           Installing Standard Edition High Availability                                                               18


Database Installation Guide
E96293-13                                                                                              November 12, 2025
Copyright © 2015, 2025, Oracle and/or its affiliates.                                                       Page iv of viii
                 About Standard Edition High Availability                                                           18
                 Requirements for Installing Standard Edition High Availability                                     18
                 Deploying Standard Edition High Availability                                                       19
                      Installing Standard Edition High Availability Database Software on Local File System          20
                      Installing Standard Edition High Availability Database Software on Oracle ACFS                22
           Cloning an Oracle Home                                                                                   24



8          Oracle Database Postinstallation Tasks
           Downloading Release Update Patches                                                                         1
           Requirements for Database Password                                                                         2
           About Installing Oracle Autonomous Health Framework                                                        3
           Recompiling Invalid Objects on Windows Systems                                                             3
           Configuring the Secure Sockets Layer                                                                       4
           Configuring Oracle Components                                                                              4
                 Windows Authentication No Longer Uses NTLM by Default                                                5
                 Configuring Oracle Messaging Gateway                                                                 6
                 Configuring the OraClrAgnt Service for Oracle Database Extensions for .NET                           6
                 Configuring Oracle Net Services                                                                      6
                 Installing Oracle Text Supplied Knowledge Bases                                                      7
                 Installing the Oracle Text Filtering Component                                                       7
                 Configuring or Reinstalling Oracle XML DB                                                            8
                 Configuring PL/SQL External Procedures                                                               8
                 Configuring Shared Server Support                                                                    8
                 Setting Credentials for the Job System to Work with Oracle Enterprise Manager                        8
                 Configuring Oracle Database to Communicate with Oracle Automatic Storage
                 Management                                                                                           9
                 Installing Oracle Database Examples                                                                  9
                 Creating the OraMTS Service for Microsoft Transaction Server                                       10
           Creating a Fast Recovery Area Disk Group                                                                 10
                 About the Fast Recovery Area and the Fast Recovery Area Disk Group                                 10
                 Creating the Fast Recovery Area Disk Group                                                          11
           Enabling and Disabling Database Options After Installation                                               12
           Changing the Oracle Home User Password                                                                   13



9          Getting Started with Oracle Database
           Checking the Installed Oracle Database Contents and Directory Location                                     2
           Logging In to Oracle Enterprise Manager Database Express 19c                                               2
           Managing Oracle Automatic Storage Management                                                               2
                 Starting and Stopping Oracle Automatic Storage Management                                            3
                 Oracle Automatic Storage Management Utilities                                                        3



Database Installation Guide
E96293-13                                                                                            November 12, 2025
Copyright © 2015, 2025, Oracle and/or its affiliates.                                                     Page v of viii
           Starting and Stopping an Oracle Database                                                                 4
                 Starting and Stopping the Database from the Microsoft Windows Services Utility                     4
           Accessing Oracle Database with SQL*Plus                                                                  4
           Accessing Oracle Database with Oracle SQL Developer                                                      5
           Reviewing User Accounts and Passwords                                                                    6
                 Oracle Database System Privileges Accounts and Passwords                                           6
                 Unlocking and Resetting User Passwords                                                             9
                 Using EM Express to Unlock Accounts and Reset Passwords                                          10
                 Using SQL*Plus to Unlock and Change Passwords                                                     11
           Identifying Databases                                                                                   11
           Locating the Server Parameter File                                                                     12
           Identifying Tablespaces and Data Files                                                                 13
           Locating Redo Log Files                                                                                13
           Locating Control Files                                                                                 14
           Understanding Oracle Database Services on Windows                                                      15



10         Removing Oracle Database Software
           About Oracle Deinstallation Options                                                                      1
           Files Deleted by the deinstall Command                                                                   2
           Deinstallation Examples for Oracle Database                                                              3
                 Downgrading Oracle Restart                                                                         3



A          Installing Java Access Bridge
           Overview of Java Access Bridge 2.0.2                                                                  A-1
           Setting Up Java Access Bridge 2.0.2                                                                   A-1



B          Optimal Flexible Architecture
           About the Optimal Flexible Architecture Standard                                                      B-1
           About Multiple Oracle Homes Support                                                                   B-2
           Oracle Base Directory Naming Convention                                                               B-2
           Oracle Home Directory Naming Convention                                                               B-3
           Optimal Flexible Architecture File Path Examples                                                      B-4



C          Installing and Configuring Oracle Database Using Response Files
           How Response Files Work                                                                               C-1
           Reasons for Using Silent Mode or Response File Mode                                                   C-2
           Using Response Files                                                                                  C-2
           Preparing a Response File                                                                             C-3



Database Installation Guide
E96293-13                                                                                         November 12, 2025
Copyright © 2015, 2025, Oracle and/or its affiliates.                                                  Page vi of viii
                 Editing a Response File Template                                                          C-3
                 Saving a Response File                                                                    C-4
           Running Oracle Universal Installer Using the Response File                                      C-5
           Running Net Configuration Assistant Using a Response File                                       C-5
           Running Oracle Database Configuration Assistant Using a Response File                           C-6
                 Silent Mode of Database Configuration Assistant                                           C-7
                 Running Oracle Database Configuration Assistant in Response File Mode                     C-7
           Postinstallation Configuration Using Response File Created During Installation                  C-8
                 About the Postinstallation Configuration File                                             C-8
                 Running Postinstallation Configuration Using Response File                                C-9
           Postinstallation Configuration Using the ConfigToolAllCommands Script                         C-10
           Using the Installation Response File for Postinstallation Configuration                       C-10



D          Configuring Read-Only Oracle Homes
           Evolution of Oracle Homes                                                                       D-1
                 About Read-Only Oracle Homes                                                              D-1
                 About Oracle Base Homes                                                                   D-2
                 About Oracle Base Config                                                                  D-2
           Enabling a Read-Only Oracle Home                                                                D-3
           Determining if an Oracle Home is Read-Only                                                      D-5
           File Path and Directory Changes in Read-Only Oracle Homes                                       D-5



E          Configuring Networks for Oracle Database
           Installing Oracle Database on Computers with Multiple IP Addresses                              E-1
           Installing Oracle Database on Computers with Multiple Aliases                                   E-2
           Installing Oracle Database on Nonnetworked Computers                                            E-2
           Installing a Loopback Adapter                                                                   E-2
                 About Using Loopback Adapters with Oracle Database                                        E-3
                 Checking if a Loopback Adapter is Installed on Your Computer                              E-3
                 Installing a Loopback Adapter                                                             E-4
                 Removing a Loopback Adapter                                                               E-5



F          Managing Oracle Database Port Numbers
           About Managing Ports                                                                            F-1
           Oracle Database Component Port Numbers and Protocols                                            F-1
           Changing the Oracle Services for Microsoft Transaction Server Port                              F-3




Database Installation Guide
E96293-13                                                                                   November 12, 2025
Copyright © 2015, 2025, Oracle and/or its affiliates.                                           Page vii of viii
           Index




Database Installation Guide
E96293-13                                               November 12, 2025
Copyright © 2015, 2025, Oracle and/or its affiliates.       Page viii of viii
List of Examples
5-1       Using Local and Path NFS Server Entries                                                                  5
5-2       Using Names in Place of IP Addresses, with Multiple Exports, management and community                    5
5-3       Using Kerberos Authentication with Direct NFS Export                                                     5
6-1       Using the asmtool Utility (Command Line)                                                               14
6-2       Enabling Oracle ACFS on Oracle Restart Configurations                                                  22
8-1       Running the Chopt Tool                                                                                 12
C-1       Password response file for Oracle Grid Infrastructure for a Standalone Server                         C-9
C-2       Password response file for Oracle Database                                                            C-9
C-3       Response File Passwords for Oracle Grid Infrastructure                                              C-10
C-4       Response File Passwords for Oracle Grid Infrastructure for a Standalone Server (Oracle Restart)     C-10
C-5       Response File Passwords for Oracle Database                                                          C-11




Database Installation Guide
E96293-13                                                                                        November 12, 2025
Copyright © 2015, 2025, Oracle and/or its affiliates.                                                 Page ix of viii
List of Tables
1-1       Server Hardware Checklist for Oracle Database Installation                                              1
1-2       Operating System General Checklist for Oracle Database on Microsoft Windows                             2
1-3       Server Configuration Checklist for Oracle Database                                                      3
1-4       Storage Checklist for Oracle Database                                                                   4
1-5       User Environment Configuration for Oracle Database                                                      5
1-6       Oracle Universal Installer Planning Checklist for Oracle Database Installation                          5
2-1       Windows x64 Minimum Hardware Requirements                                                               1
2-2       Windows x64 Minimum Disk Space Requirements on NTFS                                                     2
2-3       Windows x64 Software Requirements                                                                       4
4-1       User Groups Created During Oracle Database Installation                                                 4
6-1       Oracle ASM Disk Number and Minimum Space Requirements for an Oracle database (non-CDB)                10
6-2       Oracle ASM Disk Number and Minimum Space Requirements for a multitenant container
          database (CDB) with one pluggable database (PDB)                                                      10
6-3       Image-Creation Options for Setup Wizard                                                               17
7-1       Oracle Character Sets for Console Mode (OEM) Code Pages                                               13
7-2       Image-Creation Options for Setup Wizard                                                               16
8-1       Database Options for Chopt Tool Command                                                               12
9-1       Partial List of Oracle Database System Privileges Accounts Locked After Installation                    7
9-2       Tablespaces and Data Files                                                                            13
A-1       Copy Files to JDK Directory on Windows 64-Bit                                                        A-2
B-1       Examples of OFA-Compliant Oracle Base Directory Names                                                B-3
B-2       Optimal Flexible Architecture Hierarchical File Path Examples                                        B-4
C-1       Response Files                                                                                       C-3
D-1       read/write and Read-Only Oracle Home File Path Examples                                              D-5
F-1       Ports Used in Oracle Components                                                                      F-2




Database Installation Guide
E96293-13                                                                                        November 12, 2025
Copyright © 2015, 2025, Oracle and/or its affiliates.                                                 Page x of viii
Preface
                      Learn how to install and configure Oracle Database, perform postinstallation tasks, and how to
                      remove the database software.
                      The following topics are covered:
                      •     Audience
                      •     Documentation Accessibility
                      •     Set Up Java Access Bridge to Implement Java Accessibility
                            Install Java Access Bridge so that assistive technologies on Microsoft Windows systems
                            can use the Java Accessibility API.
                      •     Related Documentation
                      •     Conventions


Audience
                      This guide is intended for anyone responsible for installing Oracle Database 19c.
                      To use this document, you need the following:
                      •     A supported Microsoft Windows operating system installed and tested on your computer
                            system
                      •     Administrative privileges on the computer where you are installing the Oracle Database
                            software
                      •     Familiarity with object-relational database management concepts
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




Database Installation Guide
E96293-13                                                                                              November 12, 2025
Copyright © 2015, 2025, Oracle and/or its affiliates.                                                        Page i of iii
                                                                                                                 Preface




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
                      •     Java Platform, Standard Edition Java Accessibility Guide


Related Documentation
                      For more information, see these Oracle resources:
                      •     Oracle Database Concepts
                      •     Oracle Database Examples Installation Guide
                      •     Oracle Real Application Clusters Installation Guide
                      •     Oracle Grid Infrastructure Installation Guide
                      •     Oracle Enterprise Manager Cloud Control Basic Installation Guide
                      •     Oracle Database Upgrade Guide
                      •     Oracle Database 2 Day DBA
                      •     Oracle Database Administrator's Reference for Microsoft Windows
                      •     Oracle Database Sample Schemas
                      •     Oracle Database Error Messages
                      •     Oracle Label Security Administrator's Guide
                      Oracle error message documentation is available only in HTML. If you only have access to the
                      Oracle Database 19c Online Documentation Library, you can browse the error messages by
                      range. Once you find the specific range, use your browser's "find in page" feature to locate the
                      specific message. When connected to the Internet, you can search for a specific error
                      message using the error message search feature of the Oracle online documentation.
                      Many books in the documentation set use the sample schemas of the seed database, which is
                      installed by default when you install Oracle.
                      To download free release notes, installation documentation, white papers, or other collateral,
                      please visit the following website:
                      http://docs.oracle.com/en/database/database.html


Conventions
                      The following text conventions are used in this document:


Database Installation Guide
E96293-13                                                                                             November 12, 2025
Copyright © 2015, 2025, Oracle and/or its affiliates.                                                       Page ii of iii
                                                                                                                                    Preface




                       Convention                       Meaning
                       boldface                         Boldface type indicates graphical user interface elements associated with an
                                                        action, or terms defined in text or the glossary.
                       italic                           Italic type indicates book titles, emphasis, or placeholder variables for which
                                                        you supply particular values.
                       monospace                        Monospace type indicates commands within a paragraph, URLs, code in
                                                        examples, text that appears on the screen, or text that you enter.




Database Installation Guide
E96293-13                                                                                                               November 12, 2025
Copyright © 2015, 2025, Oracle and/or its affiliates.                                                                         Page iii of iii
Changes in this Release for Oracle Database
Installation Guide
                      Changes in Oracle Database Installation Guide for Oracle Database 19c.
                      •     Changes in Oracle Database 19c
                            New features, deprecated features, and desupported features in this release.


Changes in Oracle Database 19c
                      New features, deprecated features, and desupported features in this release.
                      The following are changes in Oracle Database Installation Guide for Oracle Database 19c:
                      •     New Features
                            Review new features available with Oracle Database installation in Oracle Database 19c.
                      •     Deprecated Features
                            Review features that are deprecated starting with Oracle Database 19c.
                      •     Desupported Features for Oracle Database 19c
                            There are no desupported features at the time of release.


New Features
                      Review new features available with Oracle Database installation in Oracle Database 19c.
                      •     Simplified Image Based Oracle Database Client Installation

Simplified Image Based Oracle Database Client Installation
                      Starting with Oracle Database 19c, the Oracle Database Client software is available as an
                      image file for download and installation. You must extract the image software into a directory
                      where you want your Oracle home to be located, and then run the runInstaller script to
                      start the Oracle Database Client installation. Oracle Database Client installation binaries
                      continue to be available in the traditional format as non-image zip files.
                      As with Oracle Database and Oracle Grid Infrastructure image file installations, Oracle
                      Database Client image installations simplify Oracle Database Client installations and ensure
                      best practice deployments.


Deprecated Features
                      Review features that are deprecated starting with Oracle Database 19c.
                      The following feature is deprecated in this release, and may be desupported in another
                      release. For more information about deprecated and desupported features, parameters and
                      views, refer to Oracle Database Upgrade Guide.



Database Installation Guide
E96293-13                                                                                             November 12, 2025
Copyright © 2015, 2025, Oracle and/or its affiliates.                                                        Page i of ii
                                                                  Changes in this Release for Oracle Database Installation Guide


                      •     Deprecation of clone.pl
                            The clone.pl script is deprecated in Oracle Database 19c. The functionality of performing
                            a software-only installation, using the gold image, is available in the installer wizard.
                            The clone.pl script can be removed in a future release. Instead of using the clone.pl
                            script, Oracle recommends that you install the extracted gold image as a home, using the
                            installer wizard.
                      Related Topics
                      •     Oracle Database Upgrade Guide


Desupported Features for Oracle Database 19c
                      There are no desupported features at the time of release.




Database Installation Guide
E96293-13                                                                                                    November 12, 2025
Copyright © 2015, 2025, Oracle and/or its affiliates.                                                              Page ii of ii
1
Oracle Database Installation Checklist
                      Use checklists to review system requirements, and to plan and carry out Oracle Database
                      installation.
                      Oracle recommends that you use checklists as part of your installation planning process. Using
                      a checklist ensures that your server hardware and configuration meets minimum requirements
                      for this release, and enables you to carry out a successful installation.
                      •     Server Hardware Checklist for Oracle Database Installation
                            Use this checklist to check hardware requirements for Oracle Database.
                      •     Operating System Checklist for Oracle Database Installation on Microsoft Windows
                            Use this checklist to check minimum operating system requirements for Oracle Database.
                      •     Server Configuration Checklist for Oracle Database Installation
                            Use this checklist to check minimum server configuration requirements for Oracle
                            Database installations.
                      •     Storage Checklist for Oracle Database Installation
                            Use this checklist to review storage minimum requirements and assist with configuration
                            planning.
                      •     Oracle User Environment Configuration Checklist for Oracle Database Installation
                            Use this checklist to plan operating system users, groups, and environments for Oracle
                            Database management.
                      •     Installer Planning Checklist for Oracle Database Installation
                            Use the checklist to assist you to be prepared before starting Oracle Universal Installer.


Server Hardware Checklist for Oracle Database Installation
                      Use this checklist to check hardware requirements for Oracle Database.

                      Table 1-1       Server Hardware Checklist for Oracle Database Installation

                       Check                            Task
                       Minimum RAM                      2 GB RAM recommended
                       Minimum network connectivity     Server is connected to a network
                       Video Adapter                    256 colors
                       Server Display Cards             At least 1024 x 768 display resolution, which Oracle Universal Installer
                                                        requires.




Database Installation Guide
E96293-13                                                                                                      November 12, 2025
Copyright © 2015, 2025, Oracle and/or its affiliates.                                                                Page 1 of 8
                                                                                                                               Chapter 1
                                                        Operating System Checklist for Oracle Database Installation on Microsoft Windows




Operating System Checklist for Oracle Database Installation on
Microsoft Windows
                      Use this checklist to check minimum operating system requirements for Oracle Database.

                      Table 1-2 Operating System General Checklist for Oracle Database on Microsoft
                      Windows

                       Item                                Task
                       Operating system general            Oracle Database for Windows x64 is supported on the following
                       requirements                        operating system versions:
                                                           •    Windows 8.1 x64 - Pro and Enterprise editions
                                                           •    Windows 10 x64 - Pro, Enterprise, and Education editions
                                                           •    Windows 11 x64 - Pro, Enterprise, and Education editions
                                                           •    Windows Server 2012 R2 x64 - Standard, Datacenter, Essentials,
                                                                and Foundation editions
                                                           •    Windows Server 2016 x64 - Standard, Datacenter, and Essentials
                                                                editions
                                                           •    Windows Server 2019 x64 - Standard, Datacenter, and Essentials
                                                                editions
                                                           •    Windows Server 2022 x64 - Standard, Datacenter, and Essentials
                                                                editions
                                                           •    Windows Server 2025 x64 - Standard, Datacenter, and Essentials
                                                                editions



                                                                                        Note
                                                                                        •    Windows 11 x64 - Pro, Enterprise, and
                                                                                             Education editions and Windows
                                                                                             Server 2022 x64 - Standard,
                                                                                             Datacenter, and Essentials editions
                                                                                             are supported starting with Oracle
                                                                                             Database 19c Release Update (19.13)
                                                                                             or later.
                                                                                        •    Windows 2025 x64 - Standard,
                                                                                             Datacenter, and Essentials editions
                                                                                             are supported starting with Oracle
                                                                                             Database 19c Release Update (19.27)
                                                                                             or later.




Server Configuration Checklist for Oracle Database Installation
                      Use this checklist to check minimum server configuration requirements for Oracle Database
                      installations.




Database Installation Guide
E96293-13                                                                                                            November 12, 2025
Copyright © 2015, 2025, Oracle and/or its affiliates.                                                                      Page 2 of 8
                                                                                                                             Chapter 1
                                                                                    Storage Checklist for Oracle Database Installation



                      Table 1-3       Server Configuration Checklist for Oracle Database

                       Check                            Task
                       Disk space allocated to the      At least 1 GB of space in the temporary directory. Oracle recommends
                       temporary file system            2 GB or more
                                                        At least 4 GB of space in the temporary directory for Oracle Restart
                       Swap space allocation relative   •   If physical memory is between 2 GB and 16 GB, then set virtual
                       to RAM                               memory to 1 times the size of the RAM
                                                        •   If physical memory is more than 16 GB, then set virtual memory to
                                                            16 GB
                       Oracle Inventory and             The Oracle Inventory directory is the central inventory of Oracle
                       ORA_INSTALL Group                software installed on your system. You do not need to create the Oracle
                       Requirements                     central inventory or the ORA_INSTALL group as Oracle Universal
                                                        Installer creates it for you.
                       Groups and Users                 Oracle recommends that you create groups and user accounts
                                                        required for your security plans before starting installation. Installation
                                                        owners have resource limits settings and other requirements. Group
                                                        and user names must use only ASCII characters.
                       Mount point paths for the        Oracle recommends that you create an Optimal Flexible Architecture
                       software binaries                configuration as described in this guide.
                       Ensure that the Oracle home    The ASCII character restriction includes installation owner user names,
                       (the Oracle home path that you which are used as a default for some home paths, as well as other
                       select for Oracle Database)    directory names you must select for paths.
                       uses only ASCII characters.
                       Set locale (if needed)           Specify the language and the territory, or locale, in which you want to
                                                        use Oracle components. A locale is a linguistic and cultural
                                                        environment in which a system or program is running. National
                                                        Language Support (NLS) parameters determine the locale-specific
                                                        behavior on both servers and clients. The locale setting of a
                                                        component determines the language of the user interface of the
                                                        component, and the globalization behavior, such as date and number
                                                        formatting.



Storage Checklist for Oracle Database Installation
                      Use this checklist to review storage minimum requirements and assist with configuration
                      planning.




Database Installation Guide
E96293-13                                                                                                         November 12, 2025
Copyright © 2015, 2025, Oracle and/or its affiliates.                                                                   Page 3 of 8
                                                                                                                               Chapter 1
                                                        Oracle User Environment Configuration Checklist for Oracle Database Installation



                      Table 1-4       Storage Checklist for Oracle Database

                       Check                              Task
                       Minimum local disk storage         At least 6.5 GB for Oracle Database Enterprise Edition
                       space for Oracle software          At least 6.0 GB for Oracle Database Standard Edition 2
                                                          At least 7.0 GB for an Oracle Restart installation



                                                                                       Note
                                                                                       Oracle recommends that you allocate
                                                                                       approximately 100 GB to allow additional
                                                                                       space for applying any future patches on
                                                                                       top of the existing Oracle home. For
                                                                                       specific patch-related disk space
                                                                                       requirements, please refer to your patch
                                                                                       documentation.



                       Recommended file system            Ensure that you have one of the following storage options available:
                                                          •   Oracle ASM Cluster File System (Oracle ACFS)
                                                          •   Oracle Automatic Storage Management (Oracle ASM)
                                                          •   NTFS File System or Resilient File System (ReFS)
                                                          The database files must be placed on Oracle ASM if you are using
                                                          Oracle ACFS; otherwise they can be placed on NTFS or ReFS.
                       Select Database File Storage       Ensure that you have one of the following storage options available:
                       Option                             •    File System
                                                               Oracle recommends that the file system be separate from the file
                                                               systems used by the operating system or the Oracle software. The
                                                               file system can be any of the following:
                                                               - A file system on a disk that is physically attached to the system
                                                               - A file system on a logical volume manager (LVM) volume or a
                                                               redundant array of independent disks (RAID) device
                                                          •    Oracle Automatic Storage Management (Oracle ASM)
                                                               Oracle ASM is installed as part of an Oracle Grid Infrastructure
                                                               installation. If you plan to use Oracle ASM, then you must install
                                                               Oracle Grid Infrastructure before you install and create the
                                                               database.
                       Determine your recovery plan       Review the storage configuration sections of this document for more
                                                          information about configuring recovery.



Oracle User Environment Configuration Checklist for Oracle
Database Installation
                      Use this checklist to plan operating system users, groups, and environments for Oracle
                      Database management.




Database Installation Guide
E96293-13                                                                                                            November 12, 2025
Copyright © 2015, 2025, Oracle and/or its affiliates.                                                                      Page 4 of 8
                                                                                                                                 Chapter 1
                                                                              Installer Planning Checklist for Oracle Database Installation



                      Table 1-5       User Environment Configuration for Oracle Database

                       Check                                 Task
                       Create operating system groups Create operating system groups and users depending on your security
                       and users for standard or role- requirements, as described in this install guide.
                       allocated system privileges     Set resource limits settings and other requirements for Oracle
                                                       software installation owners.
                                                             Group and user names must use only ASCII characters.
                       Unset Oracle Software                 If you have had an existing installation on your system, and you are
                       Environment Variables                 using the same user account to install this installation, then unset the
                                                             ORACLE_HOME, ORACLE_BASE, ORACLE_SID, TNS_ADMIN
                                                             environment variables and any other environment variable set for the
                                                             Oracle installation user that is connected with Oracle software homes.
                       Configure the Oracle Software         Set the TEMP environment variable.
                       Owner Environment
                       Manage User Account Control           If you have enabled the User Account Control security feature, then
                                                             Oracle Universal Installer prompts you for either your consent or your
                                                             credentials when installing Oracle Database. Provide either the
                                                             consent or your Windows Administrator credentials as appropriate.



Installer Planning Checklist for Oracle Database Installation
                      Use the checklist to assist you to be prepared before starting Oracle Universal Installer.


                      Table 1-6       Oracle Universal Installer Planning Checklist for Oracle Database Installation

                       Check                            Task
                       Review the Documentation •           Review the Oracle Database Release Notes, which is available at the
                                                            following location:
                                                            Oracle Database Release Notes
                                                        •   Be familiar with the installation steps for Oracle RAC software and
                                                            creating an Oracle RAC database.
                       Review the Licensing             You are permitted to use only those components in the Oracle Database
                       Information                      media pack for which you have purchased licenses. For more information
                                                        about licenses, refer to the following URL:
                                                        Oracle Database Licensing Information
                       Obtain your My Oracle            During installation, you require a My Oracle Support user name and
                       Support account                  password to configure security updates, download software updates, and
                       information.                     other installation tasks. You can register for My Oracle Support at the
                                                        following URL:
                                                        https://support.oracle.com/
                       Review Oracle Support            New platforms and operating system software versions can be certified
                       Certification Matrix             after this guide is published, review the certification matrix on the My
                                                        Oracle Support website for the most up-to-date list of certified hardware
                                                        platforms and operating system versions:
                                                        https://support.oracle.com/
                                                        You must register online before using My Oracle Support. After logging in,
                                                        from the menu options, select the Certifications tab. On the Certifications
                                                        page, use the Certification Search options to search by Product, Release,
                                                        and Platform. You can also search using the Certification Quick Link
                                                        options such as Product Delivery, and Lifetime Support.


Database Installation Guide
E96293-13                                                                                                              November 12, 2025
Copyright © 2015, 2025, Oracle and/or its affiliates.                                                                        Page 5 of 8
                                                                                                                                  Chapter 1
                                                                               Installer Planning Checklist for Oracle Database Installation



                      Table 1-6 (Cont.) Oracle Universal Installer Planning Checklist for Oracle Database
                      Installation

                       Check                            Task
                       Review online information        •   Log on to My Oracle Support to access certifications for your
                       to assist with installation          installation for your platform.
                                                        •   Refer to Oracle.com (http://www.oracle.com) for additional resources
                                                            about planning for specific implementation scenarios, best practices,
                                                            and other information that can help you with your installation plan. In
                                                            particular, refer to the Oracle Real Application Clusters pages on the
                                                            Oracle Technology Network at http://www.oracle.com/goto/rac
                       Run Oracle Universal             Oracle Universal Installer is fully integrated with Cluster Verification Utility
                       Installer (OUI) with CVU         (CVU), automating many CVU prerequisite checks. Oracle Universal
                       and use fixup scripts            Installer runs all prerequisite checks and creates fixup scripts when you run
                                                        the installer. You can run OUI up to the Summary screen without starting
                                                        the installation.
                                                        •   Obtain the latest version of CVU at the following URL:
                                                            http://www.oracle.com/technetwork/database/options/clustering/
                                                            downloads/cvu-download-homepage-099973.html
                                                        •   You can also run CVU commands manually to check that your system
                                                            is prepared for installation before you start an Oracle RAC installation.
                                                            If you have vendors performing hardware or operating system
                                                            configuration steps, then ask the vendors to complete the relevant
                                                            CVU checks of the cluster after they complete their work to ensure that
                                                            your system is configured correctly.
                                                        •   Run OUI and DBCA from a node where an Oracle RAC Oracle
                                                            database instance is located.
                                                        •   In case of an upgrade failure, follow common industry standards for
                                                            data recovery planning, including backing up your existing database.
                       Download and run Oracle          The Oracle ORAchk utility provides system checks that can help to prevent
                       ORAchk for runtime and           issues before and after installation. These checks include kernel
                       upgrade checks, or runtime       requirements, operating system resource allocations, and other system
                       health checks                    requirements.
                                                        Use the Oracle ORAchk Upgrade Readiness Assessment to obtain an
                                                        automated upgrade-specific system health check for upgrades to 11.2.0.3,
                                                        11.2.0.4, 12.1.0.1, 12.2, 18c, and 19c. For example:
                                                        •   Before you perform a fresh database installation:

                                                            %ORACLE-HOME%\suptools\orachk>orachk.bat -profile
                                                            preinstall
                                                        •   To upgrade your existing database to a higher version or release:

                                                            %ORACLE-HOME%\suptools\orachk>orachk.bat -o pre
                                                        The Oracle ORAchk Upgrade Readiness Assessment automates many of
                                                        the manual pre- and post-upgrade checks described in Oracle upgrade
                                                        documentation. Oracle ORAchk is supported on Windows 2008 and
                                                        Windows 2012 on a Cygwin environment only. For more information refer to
                                                        the following URL:
                                                        https://support.oracle.com/rs?type=doc&id=1268927.1




Database Installation Guide
E96293-13                                                                                                               November 12, 2025
Copyright © 2015, 2025, Oracle and/or its affiliates.                                                                         Page 6 of 8
                                                                                                                                 Chapter 1
                                                                              Installer Planning Checklist for Oracle Database Installation



                      Table 1-6 (Cont.) Oracle Universal Installer Planning Checklist for Oracle Database
                      Installation

                       Check                            Task
                       Verify if Oracle Grid            •   If you want to use Oracle ASM or Oracle Restart, then install Oracle
                       Infrastructure is installed          Grid Infrastructure for a standalone server before you install and create
                                                            the database. Otherwise, to use Oracle ASM, you must complete an
                                                            Oracle Grid Infrastructure installation, and then manually register the
                                                            database with Oracle Restart.
                                                        •   To install Oracle Real Applications Cluster (Oracle RAC), you must
                                                            have Oracle Grid Infrastructure (Oracle Clusterware and Oracle ASM)
                                                            installed on your cluster. The Oracle Clusterware version must be
                                                            equal to or greater than the Oracle RAC version that you plan to install.
                                                        •   Currently, there are no supported clusterware products other than
                                                            Oracle Clusterware for the Microsoft Windows platforms. If you intend
                                                            to install Oracle RAC, then you must first install Oracle Grid
                                                            Infrastructure for a cluster, which includes Oracle Clusterware.
                       Check running Oracle             •   On a standalone database not using Oracle ASM: You do not need to
                       processes, and shut down             shut down the database while you install Oracle Grid Infrastructure.
                       if necessary                     •   On a standalone database using Oracle ASM: Stop the existing Oracle
                                                            ASM instances. The Oracle ASM instances are restarted during
                                                            installation.
                                                        •   On an Oracle RAC Database node: This installation requires an
                                                            upgrade of Oracle Clusterware, as Oracle Clusterware is required to
                                                            run Oracle RAC. As part of the upgrade, you must shut down the
                                                            database one node at a time as the rolling upgrade proceeds from
                                                            node to node.
                       Ensure Task Scheduler            If the installer is running when daily scheduled jobs start, then you may
                       jobs do not run during           encounter unexplained installation problems if your scheduled job is
                       installation                     performing cleanup, and temporary files are deleted before the installation
                                                        is finished. Oracle recommends that you complete installation before daily
                                                        scheduled jobs are run, or disable daily scheduled jobs that perform
                                                        cleanup until after the installation is completed.
                       Decide on an Oracle              By default, Oracle Database is managed by Oracle Enterprise Manager
                       Database management              Database Express.
                       tool                             If you have an existing Oracle Management Agent, and decide to use
                                                        Oracle Enterprise Manager Cloud Control to centrally manage your
                                                        database, then obtain the following information to enter during the
                                                        database installation:
                                                        •   OMS host
                                                        •   OMS port
                                                        •   EM admin username
                                                        •   EM admin password
                                                        •   Specify password of ASMSNMP user
                                                        You need a web browser to access documentation, to use Oracle
                                                        Enterprise Manager Database Express, and to use Oracle Application
                                                        Express. Web browsers must support JavaScript and the HTML 4.0 and
                                                        Cascading Style Sheets (CSS) 1.0 standards.




Database Installation Guide
E96293-13                                                                                                              November 12, 2025
Copyright © 2015, 2025, Oracle and/or its affiliates.                                                                        Page 7 of 8
                                                                                                                               Chapter 1
                                                                            Installer Planning Checklist for Oracle Database Installation



                      Table 1-6 (Cont.) Oracle Universal Installer Planning Checklist for Oracle Database
                      Installation

                       Check                            Task
                       Review memory allocation         You can enable automatic memory management either during, or after
                       and Automatic Memory             Oracle Database installation. If you enable automatic memory management
                       Management feature               after installation, then you must shut down and restart the database.
                                                        With Automatic Memory Management, Oracle Database instances
                                                        automatically manage and tune memory. You choose a memory target, and
                                                        the instance automatically distributes memory between the system global
                                                        area (SGA) and the instance program global area (instance PGA). As
                                                        memory requirements change, the instance dynamically redistributes
                                                        memory between the SGA and instance PGA.

                      Related Topics
                      •     Oracle Grid Infrastructure Installation and Upgrade Guide for Microsoft Windows
                      Related Topics
                      •     Oracle Enterprise Manager Cloud Control Administrator's Guide
                      Related Topics
                      •     Oracle Database Administrator’s Guide
                      Related Topics
                      •     Oracle Clusterware Administration and Deployment Guide




Database Installation Guide
E96293-13                                                                                                            November 12, 2025
Copyright © 2015, 2025, Oracle and/or its affiliates.                                                                      Page 8 of 8
2
Oracle Database Preinstallation Tasks
                      Review the preinstallation tasks before you start Oracle Universal Installer.
                      Learn about the information required to install Oracle Database 19c. Ensure that you review
                      information related to the platform on which you intend to install Oracle Database 19c.
                      •     Oracle Database Minimum Hardware Requirements
                            Learn about the hardware component and hard disk space requirements.
                      •     Oracle Database Software Requirements
                            The following table lists the software requirements for Oracle Database on Windows x64:
                      •     Windows Certification and Web Browser Support
                            Review the Windows Certification and Web Browser Support information.
                      •     Reviewing Operating System Security Common Practices
                            Secure operating systems are an important basis for general system security.
                      •     Confirming Host Name Resolution
                            Check to ensure that the host name for your server is resolvable.
                      •     Individual Component Requirements
                            Review the individual component requirements.


Oracle Database Minimum Hardware Requirements
                      Learn about the hardware component and hard disk space requirements.
                      •     Hardware Component Requirements for Windows x64
                            The following table lists the hardware components that are required for Oracle Database
                            on Windows x64.
                      •     Hard Disk Space Requirements
                            Learn about the system requirements for Windows platforms that use the NT File System
                            (NTFS).
                      •     Verifying Hardware Requirements
                            Use this procedure to gather information about your server configuration.


Hardware Component Requirements for Windows x64
                      The following table lists the hardware components that are required for Oracle Database on
                      Windows x64.

                      Table 2-1       Windows x64 Minimum Hardware Requirements

                       Requirement                        Value
                       System Architecture                Processor: AMD64 and Intel EM64T
                       Physical memory (RAM)              2 GB minimum




Database Installation Guide
E96293-13                                                                                               November 12, 2025
Copyright © 2015, 2025, Oracle and/or its affiliates.                                                        Page 1 of 11
                                                                                                                        Chapter 2
                                                                                  Oracle Database Minimum Hardware Requirements



                      Table 2-1       (Cont.) Windows x64 Minimum Hardware Requirements

                       Requirement                             Value
                       Virtual memory (swap)                   •   If physical memory is between 2 GB and 16 GB, then set
                                                                   virtual memory to 1 times the size of the RAM
                                                               •   If physical memory is more than 16 GB, then set virtual
                                                                   memory to 16 GB
                       Disk space                              •   Typical Install Type total: 10 GB
                                                               •   Advanced Install Types total: 10 GB
                       Video adapter                           256 colors
                       Screen Resolution                       1024 X 768 minimum


Hard Disk Space Requirements
                      Learn about the system requirements for Windows platforms that use the NT File System
                      (NTFS).
                      Oracle strongly recommends that you install the Oracle database home (Oracle database
                      binaries, trace files, and so on) on Oracle ACFS or NTFS.
                      The database files themselves must be placed on Oracle ASM if using Oracle ACFS;
                      otherwise they can be placed on NTFS. Usage of Oracle ACFS and Oracle ASM or NTFS is
                      recommended to ensure security of these files.
                      The NTFS system requirements are accurate than the hard disk values reported by the Oracle
                      Universal Installer Summary window. The Summary window does not include accurate values
                      for disk space, the space required to create a database, or the size of compressed files that
                      are expanded on the hard drive.
                      The hard disk requirements for Oracle Database components include 32 MB to install Java
                      Runtime Environment (JRE) and Oracle Universal Installer on the partition where the operating
                      system is installed. If sufficient space is not detected, then the installation fails and an error
                      message appears.
                      The following table lists the disk space requirements on NTFS for Windows x64. The starter
                      database requires 720 MB of disk space.
                      The values in this table include the starter database.

Table 2-2      Windows x64 Minimum Disk Space Requirements on NTFS

Installation Type               TEMP Space          SYSTEM_DRIVE:\ Program        Oracle Home        Data Files *   Total
                                                    Files\Oracle\Inventory
Enterprise Edition              595 MB              53.00 MB                      6.50 GB            4.38 GB **     10.88 GB **
Standard Edition 2              595 MB              53.00 MB                      6.00 GB            4.24 GB **     10.24 GB **

                      * Refers to the contents of the admin, cfgtoollogs, flash_recovery_area, and oradata
                      directories in the ORACLE_BASE directory.

                      ** This size can be higher depending on the installation options selected, such as languages or
                      additional components. If you choose to install Oracle Database with customized backups
                      enabled, then include at least 2 GB extra for data file disk space.




Database Installation Guide
E96293-13                                                                                                      November 12, 2025
Copyright © 2015, 2025, Oracle and/or its affiliates.                                                               Page 2 of 11
                                                                                                                   Chapter 2
                                                                                       Oracle Database Software Requirements



Verifying Hardware Requirements
                      Use this procedure to gather information about your server configuration.
                      To ensure that the system meets these requirements, follow these steps:
                      1.    Determine the physical RAM size.
                            For example, on a computer running Windows Server 2012 R2, click System and
                            Security, then click System.
                            If the size of the physical RAM installed in the system is less than the required size, then
                            you must install more memory before continuing.
                      2.    Determine the size of the configured virtual memory (also known as paging file size).
                            For example, on a computer running Windows Server 2012 R2, click System and
                            Security, then click System, click Advanced System Settings, click the Advanced tab
                            on System Properties page, and then click Settings in the Performance section. Then
                            select the Advanced tab on Performance Options page.
                            The virtual memory is listed in the Virtual Memory section.
                            If necessary, see your operating system documentation for information about how to
                            configure additional virtual memory.
                      3.    Determine the amount of free disk space on the system.
                            For example, on a computer running Windows Server 2012 R2, right-click My Computer
                            and click Open.
                      4.    Determine the amount of disk space available in the temp directory. This is equivalent to
                            the total amount of free disk space, minus what is required for the Oracle software to be
                            installed.
                            On Windows x64, if there is less than 125 MB of disk space available in the temp directory,
                            then delete all unnecessary files. If the temp disk space is still less than 125 MB, then set
                            the TEMP or TMP environment variable to point to a different hard drive location.
                            For example, to change the environment variables on a computer running Windows Server
                            2012 R2, click System and Security, then click System, click Advanced System
                            Settings, click the Advanced tab on System Properties page, and then click Environment
                            Variables.


Oracle Database Software Requirements
                      The following table lists the software requirements for Oracle Database on Windows x64:




Database Installation Guide
E96293-13                                                                                                 November 12, 2025
Copyright © 2015, 2025, Oracle and/or its affiliates.                                                          Page 3 of 11
                                                                                                                          Chapter 2
                                                                                            Oracle Database Software Requirements



                      Table 2-3       Windows x64 Software Requirements

                       Requirement                      Value
                       Operating System                 Oracle Database for Windows x64 is supported on the following
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
                                                        •   Windows 2025 x64 - Standard, Datacenter, and Essentials editions
                                                            are supported starting with Oracle Database 19c Release Update
                                                            (19.27) or later.
                       Virtualization                   Oracle certifies the following virtualization technologies with Oracle
                                                        Database on Windows:
                                                        •    Oracle VM Server
                                                        •    Microsoft Hyper-V
                                                        For more detailed information on certified Oracle VM Server
                                                        combinations, check My Oracle Support note 464754.1. For more
                                                        information on certified Hyper-V combinations, you can visit:
                                                        http://www.oracle.com/technetwork/database/
                                                        virtualizationmatrix-172995.html
                       Compiler and SDK                 The following component is supported only with Microsoft Visual C++
                                                        2013 Update 5:
                                                        •   Pro*C/C++: Use Microsoft Visual C++ 2013 to convert the
                                                            Pro*C/C++ files into C/C++ files, and then use Microsoft Visual C+
                                                            + 2017 Update 6 Version 15.6.3 or later to further build them.
                                                        The following components are supported with the compilers based on
                                                        Microsoft Visual C++ 2017 Update 6 or later and Intel C++ 17.0 Update
                                                        8, and Microsoft Visual C++ 2017 Update 6 or later SDK:
                                                        •    Oracle Call Interface (OCI)
                                                        •    External callouts
                                                        •    Oracle XML Developer's Kit (XDK)
                                                        •    Oracle C++ Call Interface (OCCI)
                                                        Pro*COBOL supports:
                                                        •   Micro Focus Visual COBOL Version 6




Database Installation Guide
E96293-13                                                                                                       November 12, 2025
Copyright © 2015, 2025, Oracle and/or its affiliates.                                                                Page 4 of 11
                                                                                                                         Chapter 2
                                                                                   Windows Certification and Web Browser Support



                      Table 2-3        (Cont.) Windows x64 Software Requirements

                       Requirement                      Value
                       Network Protocol                 The Oracle Net foundation layer uses Oracle protocol support to
                                                        communicate with the following industry-standard network protocols:
                                                        •   TCP/IP
                                                        •   TCP/IP with SSL
                                                        •   Named Pipes
                       Oracle Database Client           To connect to Oracle Database 19c, the following are required:
                                                        •   Oracle Database Client is version 11.2.0.4 or later.
                                                        •   If the earlier Oracle Database Client is running on the same
                                                            computer as Oracle Database 19c, then you cannot use a
                                                            bequeath connection.
                                                        Oracle recommends upgrading Oracle Database Client to the latest
                                                        patchset (11.2.0.4 or later). You can download the patchset from the
                                                        Patches and Updates section of My Oracle Support at

                                                        https://support.oracle.com

                       Unzip utility                    Unzip 6.0 or later.
                                                        Unzip is required to extract the image files for Oracle Database and
                                                        Oracle Grid Infrastructure installations.



Windows Certification and Web Browser Support
                      Review the Windows Certification and Web Browser Support information.
                      •     Remote Desktop Services
                            Oracle supports installing, configuring, and running Oracle Database through Remote
                            Desktop Services on Windows.
                      •     Microsoft Windows Servicing Options
                            On Microsoft Windows 10 systems, new servicing options are available.
                      •     Installation Requirements for Web Browsers
                            Web browsers are required only if you intend to use Oracle Enterprise Manager Database
                            Express and Oracle Enterprise Manager Cloud Control. Web browsers must support
                            JavaScript, and the HTML 4.0 and CSS 1.0 standards.
                      •     Default Share Configuration Requirement
                            The prerequisite checks during Oracle Database installation require that the system drive
                            on your computer has default share configured on it.


Remote Desktop Services
                      Oracle supports installing, configuring, and running Oracle Database through Remote Desktop
                      Services on Windows.
                      To install Oracle Database, Oracle recommends that you start all configuration tools from the
                      Remote Desktop console session of the server.
                      Platform-specific support information is as follows:
                      •     Windows client operating systems: The Remote Desktop is only available in Single User
                            Mode.



Database Installation Guide
E96293-13                                                                                                     November 12, 2025
Copyright © 2015, 2025, Oracle and/or its affiliates.                                                              Page 5 of 11
                                                                                                                       Chapter 2
                                                                                   Windows Certification and Web Browser Support


                      •     Windows server operating systems: You can have multiple Remote Desktop sessions.



                                See Also
                                •    The Microsoft website for more information about Remote Desktop Services
                                     http://www.microsoft.com/
                                •    The My Oracle Support website for the latest Terminal Services and Remote
                                     Desktop Services information
                                     https://support.oracle.com/



Microsoft Windows Servicing Options
                      On Microsoft Windows 10 systems, new servicing options are available.
                      Oracle Database supports the following servicing options:
                      •     Semi-Annual Channel
                      •     Long-Term Servicing Channel
                      Other servicing options, such as Semi-Annual Channel (Targeted) are not supported. Oracle
                      previously supported the former Windows servicing options, such as the Current Branch for
                      Business (CBB) and Long-Term Servicing Branch (LTSB).


                                Note
                                Oracle supports its database products on these channel releases that become
                                generally available for as long as Microsoft supports the channel version. Once
                                Microsoft support ends for a specific channel version, Oracle's support ends for that
                                version as well. Oracle may recommend that customers wait until relevant Oracle
                                patches have been released before upgrading to a particular channel version. Oracle
                                may recommend or discourage the installation of a specific channel version if it
                                significantly affects the operation of Oracle software, either positively or negatively. If
                                such a statement is deemed necessary, Oracle will disseminate this statement on My
                                Oracle Support.



Installation Requirements for Web Browsers
                      Web browsers are required only if you intend to use Oracle Enterprise Manager Database
                      Express and Oracle Enterprise Manager Cloud Control. Web browsers must support
                      JavaScript, and the HTML 4.0 and CSS 1.0 standards.
                      https://support.oracle.com
                      Related Topics
                      •     Oracle Enterprise Manager Cloud Control Basic Installation Guide


Default Share Configuration Requirement
                      The prerequisite checks during Oracle Database installation require that the system drive on
                      your computer has default share configured on it.


Database Installation Guide
E96293-13                                                                                                     November 12, 2025
Copyright © 2015, 2025, Oracle and/or its affiliates.                                                              Page 6 of 11
                                                                                                                    Chapter 2
                                                                         Reviewing Operating System Security Common Practices


                      Use the net use command to verify, for example:

                      C:\> net use \\hostname\c$
                      The command completed successfully

                      Ensure that the current user, the user in the Administrator group, has all the privileges on the
                      default share.


Reviewing Operating System Security Common Practices
                      Secure operating systems are an important basis for general system security.
                      Ensure that your operating system deployment is in compliance with common security
                      practices as described in your operating system vendor security guide.


Confirming Host Name Resolution
                      Check to ensure that the host name for your server is resolvable.
                      Typically, the computer on which you want to install Oracle Database is connected to a
                      network. Ensure that the computer host name is resolvable, either through a Domain Name
                      System (DNS), a network information service (NIS), or a centrally-maintained TCP/IP host file,
                      such as /etc/hosts. Use the ping command to ensure that your computer host name is
                      resolvable. For example:

                      ping myhostname
                      pinging myhostname.example.com [192.0.2.2] with 32 bytes of data:
                      Reply from 192.0.2.2: bytes=32 time=138ms TTL=56



Individual Component Requirements
                      Review the individual component requirements.
                      •     Configuring Disk Storage for Oracle Data Files and Recovery Files
                            Learn about the storage options for storing Oracle data files and, optionally, Oracle
                            database recovery files.
                      •     Creating Directories for Oracle Data Files or Recovery Files
                            If you decide to place the Oracle Database files on a file system, then use the following
                            guidelines when deciding where to place them:
                      •     Oracle Database Security Strong Authentication Requirements
                            Ensure that you meet the hardware and software requirements so that you can use strong
                            authentication (Kerberos, PKI) with Oracle Database.
                      •     Oracle Enterprise Manager Requirements
                            All Oracle Enterprise Manager products must belong to the same release.
                      •     Oracle-Managed Files Requirements
                            If you choose the Advanced database creation option, then you can use the Oracle-
                            managed files feature with the new database.
                      •     Oracle Volume Shadow Copy Service (VSS) Writer
                            Oracle Volume Shadow Copy Service Writer is supported on Windows Server operating
                            systems.




Database Installation Guide
E96293-13                                                                                                  November 12, 2025
Copyright © 2015, 2025, Oracle and/or its affiliates.                                                           Page 7 of 11
                                                                                                                    Chapter 2
                                                                                            Individual Component Requirements



Configuring Disk Storage for Oracle Data Files and Recovery Files
                      Learn about the storage options for storing Oracle data files and, optionally, Oracle database
                      recovery files.
                      •     Choosing a Storage Option for Oracle Database and Recovery Files
                            Oracle Database files include data files, control files, redo log files, the server parameter
                            file, and the password file.

Choosing a Storage Option for Oracle Database and Recovery Files
                      Oracle Database files include data files, control files, redo log files, the server parameter file,
                      and the password file.
                      For all installations, you must choose the storage option to use for Oracle Database files.
                      During the database installation, you must choose the storage option to use for recovery files
                      (the fast recovery area). You do not have to use the same storage option for each file type.


                                Note
                                Database files and recovery files are supported on file systems and Oracle ASM.


                      The storage option that you choose for recovery files can be the same as or different to the
                      option you choose for the data files. The recovery files must be placed on Oracle ASM if using
                      Oracle ACFS; otherwise they can be placed on NTFS.


Creating Directories for Oracle Data Files or Recovery Files
                      If you decide to place the Oracle Database files on a file system, then use the following
                      guidelines when deciding where to place them:


                      •     Guidelines for Placing Oracle Database Files on a File System or Logical Volume
                            Review the guidelines for placing Oracle Database files on a file system or logical volume.
                      •     Guidelines for Placing Oracle Recovery Files on a File System
                            Use the guidelines listed in this section to place Oracle recovery files on a file system.
                      •     Creating Required Directories
                            Use this procedure to create the required directories.

Guidelines for Placing Oracle Database Files on a File System or Logical Volume
                      Review the guidelines for placing Oracle Database files on a file system or logical volume.
                      •     Oracle Universal Installer indicates that the default path for the database file directory is a
                            subdirectory of the Oracle base directory.
                      •     You can choose either a single file system or more than one file system to store the
                            database files:
                            –    If you want to use a single file system, then choose a file system on a physical device
                                 that is dedicated to the database.




Database Installation Guide
E96293-13                                                                                                  November 12, 2025
Copyright © 2015, 2025, Oracle and/or its affiliates.                                                           Page 8 of 11
                                                                                                                      Chapter 2
                                                                                              Individual Component Requirements


                                 For best performance and reliability, choose a RAID device or a logical volume on
                                 multiple physical devices and implement a stripe-and-mirror everything (SAME)
                                 storage policy.
                            –    If you want to use more than one file system, then choose file systems on separate
                                 physical devices that are dedicated to the database.
                                 This method enables you to distribute physical input-output operations and create
                                 separate control files on different devices for increased reliability. It also enables you to
                                 fully implement Oracle Optimal Flexible Architecture (OFA) guidelines. Choose the
                                 Advanced database creation option to implement this method.
                      •     If you intend to create a preconfigured database during the installation, then the file system
                            (or file systems) that you choose must have at least 2 GB of free disk space.
                            For production databases, you must estimate the disk space requirement depending on
                            the use of the database.
                      •     For optimum performance, the file systems that you choose must be on physical devices
                            that are used only by the database.
                      •     The Oracle user running the Oracle Database installation must have write permissions to
                            create the files in the path that you specify.

Guidelines for Placing Oracle Recovery Files on a File System
                      Use the guidelines listed in this section to place Oracle recovery files on a file system.


                                Note
                                You must choose a location for recovery files only if you intend to enable automated
                                backups during the installation.



                      If you place the Oracle recovery files on a file system, use the following guidelines when
                      deciding where to place them:
                      •     To prevent disk failure from making both the data files and the recovery files unavailable,
                            place the recovery files in a file system on a different physical disk from the data files.


                                     Note
                                     Alternatively, for both data files and recovery files, use an Oracle Automatic
                                     Storage Management disk group.


                      •     The file system that you choose must have at least 2 GB of free disk space.
                            The disk space requirement is the default disk quota configured for the fast recovery area
                            (specified by the DB_RECOVERY_FILE_DEST_SIZE initialization parameter).
                            If you choose the Advanced database configuration option, you can specify a different disk
                            quota value. After you create the database, you can also use Oracle Enterprise Manager
                            Cloud Control or Oracle Enterprise Manager Database Express to specify a different value.




Database Installation Guide
E96293-13                                                                                                    November 12, 2025
Copyright © 2015, 2025, Oracle and/or its affiliates.                                                             Page 9 of 11
                                                                                                                               Chapter 2
                                                                                                     Individual Component Requirements



                                     See Also
                                     Oracle Database Backup and Recovery User's Guide


                      •     Oracle Universal Installer suggests that the default location for the database file directory is
                            a subdirectory of the Oracle base directory. However, this default location is not
                            recommended for production databases.

Creating Required Directories
                      Use this procedure to create the required directories.


                                Note
                                You must complete this procedure only to place the Oracle database or recovery files
                                on a separate file system from the Oracle base directory.



                      To create directories for the Oracle database or recovery files on separate file systems from
                      the Oracle base directory, follow these steps:
                      1.    Use Windows Explorer to determine the free disk space on the file system.
                      2.    From the display, identify the file systems to use:


                            File Type                   File System Requirements
                            Data files                  Select one of the following:
                                                        •   A single file system with at least 950 MB of free disk space
                                                        •   Two or more file systems with at least 950 MB of free disk space in total
                            Recovery files              Choose a file system with at least 2 GB of free disk space.

                            If you are using the same file system for multiple types of files, then add the disk space
                            requirements for each type to determine the total disk space requirement.
                      3.    Note the names of the directories for the file systems that you identified.


Oracle Database Security Strong Authentication Requirements
                      Ensure that you meet the hardware and software requirements so that you can use strong
                      authentication (Kerberos, PKI) with Oracle Database.


Oracle Enterprise Manager Requirements
                      All Oracle Enterprise Manager products must belong to the same release.
                      Older versions of Enterprise Manager are not supported with the new release.
                      Oracle Enterprise Manager products are released on the Enterprise Manager Cloud Control
                      installation media. Oracle Enterprise Manager Database Express is built into Oracle Database
                      without any need for special installation or management.




Database Installation Guide
E96293-13                                                                                                             November 12, 2025
Copyright © 2015, 2025, Oracle and/or its affiliates.                                                                     Page 10 of 11
                                                                                                               Chapter 2
                                                                                       Individual Component Requirements



                                See Also
                                Oracle Enterprise Manager Cloud Control Basic Installation Guide and Oracle
                                Enterprise Manager Cloud Control Advanced Installation and Configuration Guide



Oracle-Managed Files Requirements
                      If you choose the Advanced database creation option, then you can use the Oracle-managed
                      files feature with the new database.
                      If you use this feature, then specify only the database object name instead of file names when
                      creating or deleting database files. You require configuration procedures to enable Oracle
                      Managed Files.
                      Related Topics
                      •     Oracle Database Administrator's Guide


Oracle Volume Shadow Copy Service (VSS) Writer
                      Oracle Volume Shadow Copy Service Writer is supported on Windows Server operating
                      systems.



                                See Also
                                Oracle Database Platform Guide for Microsoft Windows




Database Installation Guide
E96293-13                                                                                             November 12, 2025
Copyright © 2015, 2025, Oracle and/or its affiliates.                                                     Page 11 of 11
3
Overview of Oracle Database Installation
                      Learn about the different installation types of Oracle Database and issues to consider before
                      you install Oracle Database.


                      •     Installation Considerations
                            Learn about the information that you must consider before deciding how to install this
                            product.
                      •     Database Configuration Options
                            Review the different database configuration options.


Installation Considerations
                      Learn about the information that you must consider before deciding how to install this product.
                      •     Oracle Base Directory
                            If you install Oracle Database 19c on a computer with no other Oracle software installed,
                            Oracle Universal Installer creates an Oracle base directory for you.
                      •     Oracle Home Directory
                            Learn about the Oracle Home directory.
                      •     Oracle Inventory Directory
                            The Oracle Inventory directory is the central inventory location for all Oracle software
                            installed on a server.
                      •     Installing Oracle Database Vault in an Oracle Data Guard Environment
                            Starting with Oracle Database 12c, Oracle Database Vault is installed by default as part of
                            the Oracle Database installation.
                      •     Oracle Database Vault Default Audit Policy and Initialization Parameters
                            Oracle Database Vault installs a baseline database auditing policy.
                      •     Consider Memory Allocation and Automatic Memory Management
                            During a Typical installation, you create your database with Database Configuration
                            Assistant (DBCA), and automatic memory management is enabled. If you choose
                            advanced installation, then you can either specify memory allocation manually, or enable
                            automatic memory management.


Oracle Base Directory
                      If you install Oracle Database 19c on a computer with no other Oracle software installed,
                      Oracle Universal Installer creates an Oracle base directory for you.
                      If Oracle software is installed, then one or more Oracle base directories exist. In the latter
                      case, Oracle Universal Installer offers you a choice of Oracle base directories to install Oracle
                      Database.
                      The Oracle Home User has complete control over the Oracle base for a particular home. For
                      security reasons, different Windows User Accounts used as Oracle Home Users for different
                      Oracle homes are not allowed to share the same Oracle base. However, to support Oracle


Database Installation Guide
E96293-13                                                                                                 November 12, 2025
Copyright © 2015, 2025, Oracle and/or its affiliates.                                                           Page 1 of 5
                                                                                                                   Chapter 3
                                                                                                  Installation Considerations


                      Database upgrade, Oracle supports the sharing of an Oracle base between a Windows Built-in
                      Account and a Windows User Account. This means that if you choose to reuse an Oracle base
                      from an earlier release of Oracle Database in Oracle Database 19c, then the Oracle Home
                      User of Oracle Database 19c Oracle home has complete control over the Oracle base of the
                      earlier release.


                                See Also
                                Oracle Database Platform Guide for Microsoft Windows



                      In a default Windows installation, the Oracle base directory appears as follows:
                      DRIVE_LETTER:\app\username

                      where username is the Oracle Installation User if you choose Windows Built-in Account, else it
                      is the Oracle Home User (standard Windows User Account).


                                Caution
                                After installing Oracle Database 19c with a Windows User Account used as the Oracle
                                Home User, do not install older version of databases and share the same Oracle base
                                directory. During the installation of older releases of Oracle Database, ACLs are reset
                                corresponding to older releases. Thus Oracle Database 19c services may not be able
                                to access the Oracle base directory and the files in it.




                                Note
                                You can choose to create an Oracle base directory, even if the other Oracle base
                                directories exist on the system.




Oracle Home Directory
                      Learn about the Oracle Home directory.


                      •     Contents of the Oracle Home Environment
                            The Oracle home directory is located under the Oracle base directory.
                      •     Multiple Oracle Home Components
                            You can install all Oracle components in multiple Oracle homes on the same computer.

Contents of the Oracle Home Environment
                      The Oracle home directory is located under the Oracle base directory.
                      For example, in a default Windows installation, if you name the Oracle home directory
                      dbhome_1, it appears in the Oracle base directory as follows:
                      DRIVE_LETTER:\app\username\product\19.0.0\dbhome_1




Database Installation Guide
E96293-13                                                                                                November 12, 2025
Copyright © 2015, 2025, Oracle and/or its affiliates.                                                          Page 2 of 5
                                                                                                                      Chapter 3
                                                                                                     Installation Considerations


                      where username is the installation user if you choose a Windows Built-in Account, else it is the
                      Oracle Home User specified.
                      An Oracle home corresponds to the environment in which the Oracle components run. This
                      environment includes the following:
                      •     Location of the installed component files
                      •     PATH variable pointing to the binary files of the installed components
                      •     Registry entries
                      •     Service names
                      •     Program groups
                      Oracle homes also have a name associated with them, which is automatically assigned by the
                      installer.

Multiple Oracle Home Components
                      You can install all Oracle components in multiple Oracle homes on the same computer.
                      However, some components can only support one active instance at a time. The current
                      (latest) installation renders the previous one inactive. The component Oracle Provider for OLE
                      DB supports one active instance at a time.


Oracle Inventory Directory
                      The Oracle Inventory directory is the central inventory location for all Oracle software installed
                      on a server.
                      By default, the location of the Oracle Inventory directory is C:\Program
                      Files\Oracle\Inventory. This directory is created by default the first time you install Oracle
                      software on a Windows server.


Installing Oracle Database Vault in an Oracle Data Guard Environment
                      Starting with Oracle Database 12c, Oracle Database Vault is installed by default as part of the
                      Oracle Database installation.
                      If you plan to use Oracle Data Guard with Oracle Database Vault, then see "Integrating Oracle
                      Database Vault with Oracle Data Guard" in Oracle Database Vault Administrator's Guide.


Oracle Database Vault Default Audit Policy and Initialization Parameters
                      Oracle Database Vault installs a baseline database auditing policy.
                      This policy covers the access control configuration information stored in the following:
                      •     Database Vault database tables
                      •     Information stored in Oracle Catalog (rollback segments, tablespaces, and so on)
                      •     Use of system privileges
                      •     Oracle Label Security configuration
                      When you install Oracle Database Vault, the security specific database initialization parameters
                      are initialized with the default values.



Database Installation Guide
E96293-13                                                                                                   November 12, 2025
Copyright © 2015, 2025, Oracle and/or its affiliates.                                                             Page 3 of 5
                                                                                                                Chapter 3
                                                                                           Database Configuration Options



                                See Also
                                Oracle Database Vault Administrator's Guide




Consider Memory Allocation and Automatic Memory Management
                      During a Typical installation, you create your database with Database Configuration Assistant
                      (DBCA), and automatic memory management is enabled. If you choose advanced installation,
                      then you can either specify memory allocation manually, or enable automatic memory
                      management.
                      With automatic memory management, the Oracle Database instances automatically manage
                      and tune memory for you. With automatic memory management, you choose a memory target,
                      and the instance automatically distributes memory between the system global area (SGA) and
                      the instance program global area (instance PGA). As memory requirements change, the
                      instance dynamically redistributes memory between the SGA and instance PGA.
                      You can enable automatic memory management either during, or after the database
                      installation. Enabling automatic memory management after installation involves a shutdown
                      and restart of the database.



                                See Also
                                Oracle Database Administrator's Guide




Database Configuration Options
                      Review the different database configuration options.
                      You can create an Oracle database during the installation process. If you choose to create an
                      Oracle database, Oracle Universal Installer uses Oracle Database Configuration Assistant to
                      create it. You can create one of the preconfigured database types, which are designed for a
                      variety of different applications, modify one of the preconfigured database types, or create a
                      customized database to suit your own requirements.
                      •     Creating a Database After Installation
                            You can create a database after installation by using Oracle Database Configuration
                            Assistant (Oracle DBCA).


Creating a Database After Installation
                      You can create a database after installation by using Oracle Database Configuration Assistant
                      (Oracle DBCA).
                      If you decide not to create a database during the installation, then you can use Oracle
                      Database Configuration Assistant (Oracle DBCA) to create one after you have installed the
                      software.
                      •     Creating an Oracle Database on Direct NFS
                            Learn how to install and create an Oracle Database that uses Direct NFS (dNFS) for
                            storage.


Database Installation Guide
E96293-13                                                                                             November 12, 2025
Copyright © 2015, 2025, Oracle and/or its affiliates.                                                       Page 4 of 5
                                                                                                                   Chapter 3
                                                                                              Database Configuration Options



Creating an Oracle Database on Direct NFS
                      Learn how to install and create an Oracle Database that uses Direct NFS (dNFS) for storage.
                      There are different configuration processes you must perform to use dNFS for your database
                      file system. Following are the steps:
                      1.    Perform a Software-Only Installation of Oracle Database
                            In a software-only installation, you install the Oracle Database software but do not create a
                            database as part of the installation process. You can install only the database software by
                            selecting the Install Database Software only option provided on the Select Installation
                            Option screen.
                      2.    Use Oracle Database Configuration Assistant to Create and Configure the Database
                            After the Prerequisite checks are complete, on the Summary screen, minimize the
                            installation window. DO NOT click Finish at this point.
                      3.    Enable the Direct NFS option.
                            Return to the DBCA window and click Finish.
                      4.    Map a drive letter to a CIFS share on the NFS server that represents the location of the
                            database files.
                            NET USE * \\filer\vol0\orcl

                            After you complete this step, both Oracle and the Windows operating system can access
                            the location where the database files reside. Oracle is using DNFS, but the Windows OS
                            uses CIFS to access the same location on the NFS server.
                      5.    Verify that the Direct NFS is configured for the database.
                            a.   Start SQL*Plus.
                            b.   Connect to the newly created database as a DBA user.
                            c.   Run the following SQL command:
                                 SELECT * FROM v$dnfs_servers;




Database Installation Guide
E96293-13                                                                                                November 12, 2025
Copyright © 2015, 2025, Oracle and/or its affiliates.                                                          Page 5 of 5
4
Configuring Users, Groups and Environments
for Oracle Database
                      Learn about the users, groups, and environment settings to complete before you install Oracle
                      Database and Grid Infrastructure for a standalone server.

                      •     Creating Required Operating System Groups and Users
                            If you are installing Oracle software for the first time, then create operating system groups
                            and users to grant Oracle Database system privileges.
                      •     Stopping Existing Oracle Services
                            Learn how to stop all processes, including the listener and database, running in the Oracle
                            home.
                      •     Configuring User Accounts
                            During installation, you can specify an Oracle Home User.
                      •     Creating Oracle Database Vault User Accounts
                            If you intend to use Oracle Database Vault by default, then you must create an Oracle
                            Database Vault user account, and configure that user.


                                See Also
                                Oracle Database Administrator’s Reference for Microsoft Windows




Creating Required Operating System Groups and Users
                      If you are installing Oracle software for the first time, then create operating system groups and
                      users to grant Oracle Database system privileges.
                      You can choose to create one administrative user and use one group for operating system
                      authentication for all system privileges on the storage and database tiers. For example, you
                      can designate the oracle user to be the Oracle Installation user for all Oracle software and use
                      only the ORA_DBA group for authentication. You can also create custom configuration groups
                      and users based on job role separation that divide access privileges.
                      Log in as an Administrator user, and use the following instructions to create the Oracle
                      Installation user for Oracle Database.

                      •     About the Oracle Installation User
                            To install Oracle Restart or Oracle Database software, you must use either a local or a
                            domain user that is also a member of the Administrators group.
                      •     Creating Oracle Home User
                            During Oracle Database installation, you can specify an optional Oracle home user
                            associated with the Oracle home.




Database Installation Guide
E96293-13                                                                                                 November 12, 2025
Copyright © 2015, 2025, Oracle and/or its affiliates.                                                          Page 1 of 12
                                                                                                                      Chapter 4
                                                                            Creating Required Operating System Groups and Users


                      •     Understanding the Oracle Inventory Directory and the Oracle Inventory Group
                            The Oracle Inventory directory is the central inventory location for all Oracle software
                            installed on a server.
                      •     Operating System Groups Created During Oracle Database Installation
                            During installation, the user groups listed in the following table are created, if they do not
                            already exist.
                      •     Operating System Groups and Users for Job Role Separation
                            A job role separation configuration of Oracle Database and Oracle ASM is a configuration
                            with groups and users to provide separate groups for operating system authentication.


                                See Also
                                Oracle Database Platform Guide for Microsoft Windows




About the Oracle Installation User
                      To install Oracle Restart or Oracle Database software, you must use either a local or a domain
                      user that is also a member of the Administrators group.
                      This user is the Oracle Installation User. The Oracle Installation User can be either a local user
                      or a domain user.


Creating Oracle Home User
                      During Oracle Database installation, you can specify an optional Oracle home user associated
                      with the Oracle home.
                      For example, assume that you use an Administrator user named OraSys to install the software
                      (Oracle Installation user), then you can specify the ORADOMAIN\OraDb domain user as the
                      Oracle home user for this installation. The specified Oracle home domain user must exist
                      before you install the Oracle Database software.
                      Oracle home user can be a Windows Built-in Account (LocalSystem for Server and
                      LocalService for Client), Virtual Account, or a regular (not an administrator) Windows account.
                      If you specify an existing user as the Oracle home user, then the Windows User Account you
                      specify can either be a Windows Domain User or a Windows Local User.
                      A Windows User Account need not be created by the Administrator if a Virtual Account or a
                      Windows Built-in Account is used during installation.
                      If you specify a non-existing user as the Oracle home user, then the Windows User Account
                      you specify must be a Windows Local User. The installer creates this account automatically to
                      run the Windows services for the Oracle home. Do not log in using this account to perform
                      administrative tasks.
                      The Group Managed Services Account (gMSA) and Virtual Accounts enables you to install
                      Oracle Database, create, and manage Database services without passwords. The gMSA is a
                      domain level account that can be used by multiple servers in a domain to run the services
                      using this account. Windows User Account can be a Windows Local User, Windows Domain
                      User, Managed Services Account (MSA), or Group Managed Services Account (gMSA).
                      If you want to create a new user during installation, then it can only be a Windows Local User.
                      It cannot be a Windows Domain User, an MSA, or a gMSA. The new user that is created is
                      denied interactive logon privileges to the Windows computer. However, a Windows


Database Installation Guide
E96293-13                                                                                                    November 12, 2025
Copyright © 2015, 2025, Oracle and/or its affiliates.                                                             Page 2 of 12
                                                                                                                   Chapter 4
                                                                         Creating Required Operating System Groups and Users


                      administrator can manage this account like any other Windows account. Oracle recommends
                      that you use Virtual Account or a standard Windows User Account (instead of Windows Built-in
                      Account) as the Oracle Home User for enhanced security.


                                Note
                                You cannot change the Oracle Home User after the installation is complete. If you
                                must change the Oracle Home User, then you must reinstall the Oracle Database
                                software.



                      When you specify an Oracle Home user, the installer configures that user as the Oracle
                      Service user for all software services that run from the Oracle home. The Oracle Service user
                      is the operating system user that the Oracle software services run as, or the user from which
                      the services inherit privileges.
                      Silent installation is enhanced to support password prompt for the Oracle home user. So,
                      customers and independent software vendors (ISV) can use response files without hard coding
                      the password into the source code.
                      Oracle recommends using Virtual Account or a standard Windows User Account (not an
                      Administrator account) as the Oracle Home User for typical installation, software-only
                      installation, and cloning.
                      If an existing Windows User Account is used as the Oracle home user for software-only
                      installation, then a password is not required. Thus, you can perform a silent, software-only
                      installation using Windows User Account.
                      If you use a Windows User Account as the Oracle home user for cloning individual Oracle
                      Database installations, then a password is not required.
                      Virtual Account is the Oracle home user for Oracle Database Single Instance database
                      installation. The account enables you to install Oracle Database, create, and manage
                      Database services without passwords. The gMSA is a domain level account that can be used
                      by multiple servers in a domain to run the services using this account. The gMSA is a low
                      privilege user account.


Understanding the Oracle Inventory Directory and the Oracle Inventory
Group
                      The Oracle Inventory directory is the central inventory location for all Oracle software installed
                      on a server.
                      By default, the location of the Oracle Inventory directory is C:\Program
                      Files\Oracle\Inventory.

                      When you install Oracle software on the system for the first time, Oracle Universal Installer
                      creates the directories for the Oracle central inventory and the Oracle Inventory group,
                      ORA_INSTALL. The ORA_INSTALL group contains all the Oracle Home Users for all Oracle homes
                      on the server.
                      Whether you are performing the first installation of Oracle software on this server, or are
                      performing an installation of additional Oracle software on the server, you do not need to
                      create the Oracle central inventory or the ORA_INSTALL group; the Oracle Universal Installer
                      creates them automatically. You cannot change the name of the Oracle Inventory group - it is
                      always ORA_INSTALL.


Database Installation Guide
E96293-13                                                                                                 November 12, 2025
Copyright © 2015, 2025, Oracle and/or its affiliates.                                                          Page 3 of 12
                                                                                                                            Chapter 4
                                                                               Creating Required Operating System Groups and Users



Operating System Groups Created During Oracle Database Installation
                      During installation, the user groups listed in the following table are created, if they do not
                      already exist.
                      The HOMENAME variable refers to the generated HOMENAME for a software installation, which is of
                      the form OraproductmajorVersionHomenumber. For example, OraDB19cHome1.

                      Table 4-1       User Groups Created During Oracle Database Installation

                       Operating System Group           Related              Description
                       Name                             System
                                                        Privilege
                       ORA_DBA                          SYSDBA               A special OSDBA group for the Windows operating
                                                        system               system.
                                                        privileges for all   Members of this group are granted SYSDBA system
                                                        Oracle               privileges for all Oracle Databases installed on the
                                                        Database             server.
                                                        installations on
                                                        the server
                       ORA_OPER                         SYSOPER              A special OSOPER group for the Windows operating
                                                        system               system.
                                                        privileges for all   Members of this group are granted SYSOPER
                                                        Oracle               system privileges all Oracle Databases installed on
                                                        databases            the server. This group does not have any members
                                                        installed on the     after installation, but you can manually add users to
                                                        server               this group after the installation completes.
                       ORA_ASMADMIN                     SYSASM               The OSASM group for the Oracle ASM instance.
                                                        system               Using this group and the SYSASM system privileges
                                                        privileges for       enables the separation of SYSDBA database
                                                        Oracle ASM           administration privileges from Oracle ASM storage
                                                        administration       administration privileges. Members of the OSASM
                                                                             group are authorized to connect using the SYSASM
                                                                             privilege and have full access to Oracle ASM,
                                                                             including administrative access to all disk groups that
                                                                             the Oracle ASM instance manages.
                       ORA_ASMDBA                       SYSDBA            The OSDBA group for the Oracle ASM instance.
                                                        system            This group grants access for the database to connect
                                                        privileges on the to Oracle ASM. During installation, the Oracle
                                                        Oracle ASM        Installation Users are configured as members of this
                                                        instance          group. After you create an Oracle Database, this
                                                                             group contains the Oracle Home Users of those
                                                                             database homes.
                       ORA_ASMOPER                      SYSOPER for          The OSOPER group for the Oracle ASM instance.
                                                        ASM system           Members of this group are granted SYSOPER
                                                        privileges           system privileges on the Oracle ASM instance, which
                                                                             permits a user to perform operations such as startup,
                                                                             shutdown, mount, dismount, and check disk group.
                                                                             This group has a subset of the privileges of the
                                                                             OSASM group. Similar to the ORA_HOMENAME_OPER
                                                                             group, this group does not have any members after
                                                                             installation, but you can manually add users to this
                                                                             group after the installation completes.




Database Installation Guide
E96293-13                                                                                                         November 12, 2025
Copyright © 2015, 2025, Oracle and/or its affiliates.                                                                  Page 4 of 12
                                                                                                                           Chapter 4
                                                                               Creating Required Operating System Groups and Users



                      Table 4-1       (Cont.) User Groups Created During Oracle Database Installation

                       Operating System Group           Related              Description
                       Name                             System
                                                        Privilege
                       ORA_HOMENAME_DBA                 SYSDBA               An OSDBA group for a specific Oracle home with a
                                                        system               name of HOMENAME.
                                                        privileges for all   Members of this group can use operating system
                                                        instances that       authentication to gain SYSDBA system privileges for
                                                        run from the         any database that runs from the specific Oracle
                                                        Oracle home          home. If you specified an Oracle Home User during
                                                        with the name        installation, the user is added to this group during
                                                        HOMENAME             installation.
                       ORA_HOMENAME_OPER                SYSOPER              An OSDBA group for the Oracle home with a name
                                                        system               of HOMENAME.
                                                        privileges for all   Members of this group can use operating system
                                                        instances that       authentication to gain SYSOPER system privileges
                                                        run from the         for any database that runs from the specific Oracle
                                                        Oracle home          home. This group does not have any members after
                                                        with a name          installation, but you can manually add users to this
                                                        HOMENAME             group after the installation completes.
                       ORA_HOMENAME_SYSBACKUP           SYSBACKUP            OSBACKUPDBA group for a specific Oracle home
                                                        system               with a name of HOMENAME.
                                                        privileges for all   Members of this group have privileges necessary for
                                                        instances that       performing database backup and recovery tasks on
                                                        run from the         all database instances that run from the specified
                                                        Oracle home          Oracle home directory.
                                                        with a name of
                                                        HOMENAME
                       ORA_HOMENAME_SYSDG               SYSDG system         OSDGDBA group for a specific Oracle home with a
                                                        privileges for all   name of HOMENAME.
                                                        instances that       Members of this group have privileges necessary for
                                                        run from the         performing Data Guard administrative tasks on all
                                                        Oracle home          database instances that run from the specified
                                                        with a name of       Oracle home directory.
                                                        HOMENAME
                       ORA_HOMENAME_SYSKM               SYSKM system         OSKMDBA group for a specific Oracle home with a
                                                        privileges for all   name of HOMENAME.
                                                        instances that       Members of this group have privileges necessary for
                                                        run from the         performing encryption key management tasks on all
                                                        Oracle home          database instances that run from the specified
                                                        with a name of       Oracle home directory.
                                                        HOMENAME.
                       ORA_HOMENAME_SYSRAC              SYSRAC               OSRACDBA group for a specific Oracle home with a
                                                        system               name of HOMENAME.
                                                        privileges for all   Members of this group have privileges necessary for
                                                        instances that       performing a limited set of Oracle Real Application
                                                        run from the         Clusters administrative tasks to create a separate
                                                        Oracle home          group of operating system users.
                                                        with a name of
                                                        HOMENAME.




Database Installation Guide
E96293-13                                                                                                        November 12, 2025
Copyright © 2015, 2025, Oracle and/or its affiliates.                                                                 Page 5 of 12
                                                                                                                         Chapter 4
                                                                             Creating Required Operating System Groups and Users



                      Table 4-1       (Cont.) User Groups Created During Oracle Database Installation

                       Operating System Group           Related           Description
                       Name                             System
                                                        Privilege
                       ORA_HOMENAME_SVCACCTS            Contains Virtual SVCACCTS group specific to a Oracle home. It
                                                        Accounts for all contains virtual accounts for all the services running
                                                        Oracle           under that virtual account based HOMENAME.
                                                        Database
                                                        Windows
                                                        Services that
                                                        run from Oracle
                                                        home with a
                                                        name of
                                                        HOMENAME.
                       ORA_DBSVCACCTS                   Contains Virtual DBSVCACCTS system-wide group that contains
                                                        Accounts for all virtual accounts for all the database services for all
                                                        Oracle              Virtual Accounts based Oracle homes.
                                                        Database
                                                        Windows
                                                        Services that
                                                        run for all Virtual
                                                        Accounts based
                                                        Oracle homes.

                      During the installation of Oracle Database, all groups mentioned in the table are populated for
                      proper operation of Oracle products. You must not remove any group member populated by
                      Oracle. However, if you want to assign specific database privileges to new Windows operating
                      system users, then you can manually add users to these groups after the installation
                      completes.
                      Oracle creates other groups, such as, ORA_INSTALL, ORA_CLIENT_LISTENERS,
                      ORA_GRID_LISTENERS, ORA_HOMENAME_SVCSIDS, ORA_HOMENAME_SVCACCTS, and ORA_DBSVCACCTS
                      during installation and you must not change these groups, memberships, and ACLs associated
                      with various Oracle created groups.



                                See Also
                                •    Oracle Database Administrator's Guide
                                •    Oracle Automatic Storage Management Administrator's Guide



Operating System Groups and Users for Job Role Separation
                      A job role separation configuration of Oracle Database and Oracle ASM is a configuration with
                      groups and users to provide separate groups for operating system authentication.
                      •     About Job Role Separation Operating System Privileges Groups and Users
                            During the Oracle Database installation, the ORA_DBA, ORA_OPER, ORA_HOMENAME_DBA,
                            ORA_HOMENAME_OPER, ORA_HOMENAME_SYSBACKUP, ORA_HOMENAME_SYSDG,
                            ORA_HOMENAME_SYSKM, and ORA_HOMENAME_SYSRAC groups are created and users assigned
                            to these groups.




Database Installation Guide
E96293-13                                                                                                       November 12, 2025
Copyright © 2015, 2025, Oracle and/or its affiliates.                                                                Page 6 of 12
                                                                                                                     Chapter 4
                                                                           Creating Required Operating System Groups and Users


                      •     Oracle Software Owner for Each Oracle Software Product
                            You can create a single user (for example, oracle) to own both Oracle Database, and
                            Oracle Restart installations.
                      •     Standard Oracle Database Groups for Job Role Separation
                            Review the standard Oracle Database groups.
                      •     Extended Oracle Database Groups for Job Role Separation
                            In addition to the SYSOPER privilege to start up and shut down the database, you can
                            create new administrative privileges that are more task-specific and less privileged than
                            the ORA_DBA/SYSDBA system privileges to support specific administrative privileges tasks
                            required for everyday database operation.
                      •     Oracle Automatic Storage Management Groups for Job Role Separation
                            Review the operating system groups.
                      •     Windows Group Managed Service Accounts and Virtual Accounts
                            Group Managed Services Account (gMSA) and Virtual Accounts are now supported and
                            enable you to create and manage Database services without passwords.
                      •     Microsoft Hyper-V Requirements
                            Microsoft Hyper-V enables you to create and manage a virtualized computing environment
                            by running multiple operating systems simultaneously on a single computer and isolate
                            operating systems from each other.

About Job Role Separation Operating System Privileges Groups and Users
                      During the Oracle Database installation, the ORA_DBA, ORA_OPER, ORA_HOMENAME_DBA,
                      ORA_HOMENAME_OPER, ORA_HOMENAME_SYSBACKUP, ORA_HOMENAME_SYSDG, ORA_HOMENAME_SYSKM,
                      and ORA_HOMENAME_SYSRAC groups are created and users assigned to these groups.

                      Members of these groups are granted operating system authentication for the set of database
                      system privileges each group authorizes. Oracle recommends that you use different operating
                      system groups for each set of system privileges.

Oracle Software Owner for Each Oracle Software Product
                      You can create a single user (for example, oracle) to own both Oracle Database, and Oracle
                      Restart installations.
                      However, Oracle recommends that you create one software owner to own each Oracle
                      software installation (typically, oracle, for the database software and grid for the Oracle
                      Restart owner user).
                      You must create at least one software owner the first time you install Oracle software on the
                      system.


                                Note
                                In Oracle documentation, a user created to own only Oracle Grid Infrastructure
                                software installations is called the grid user. A user created to own either all Oracle
                                installations, or only Oracle database installations, is called the oracle user.



Standard Oracle Database Groups for Job Role Separation
                      Review the standard Oracle Database groups.


Database Installation Guide
E96293-13                                                                                                   November 12, 2025
Copyright © 2015, 2025, Oracle and/or its affiliates.                                                            Page 7 of 12
                                                                                                                    Chapter 4
                                                                          Creating Required Operating System Groups and Users


                      The following is a list of standard Oracle Database groups. These groups provide operating
                      system authentication for database administration system privileges:


                                Note
                                All these groups are automatically created as a part of Oracle Database installation on
                                Windows.



                      •     The OSDBA group (ORA_DBA)
                            Use this group the first time you install Oracle Database software on the system. This
                            group identifies operating system user accounts that have database administrative
                            privileges (the SYSDBA privilege) for all database instances running on the server.
                            Members of the ORA_DBA group do not have SYSASM privileges on Oracle ASM instances,
                            which are needed for mounting and dismounting disk groups.
                      •     The OSOPER group for Oracle Database (ORA_OPER)
                            Use this group if you want a separate group of operating system users to have a limited set
                            of database administrative privileges for starting up and shutting down the database (the
                            SYSOPER privilege).
                      •     The OSDBA group for a particular Oracle home (ORA_HOMENAME_DBA)
                            This group is created the first time you install Oracle Database software into a new Oracle
                            home. This group identifies operating system user accounts that have database
                            administrative privileges (the SYSDBA privilege) for the database instances that run from
                            that Oracle home.
                      •     The OSOPER group for a particular Oracle home (ORA_HOMENAME_OPER)
                            Use this group if you want a separate group of operating system users to have a limited set
                            of database administrative privileges for starting up and shutting down the database
                            instances that run from a particular Oracle home (the SYSOPER privilege).

Extended Oracle Database Groups for Job Role Separation
                      In addition to the SYSOPER privilege to start up and shut down the database, you can create
                      new administrative privileges that are more task-specific and less privileged than the ORA_DBA/
                      SYSDBA system privileges to support specific administrative privileges tasks required for
                      everyday database operation.
                      Users granted these system privileges are also authenticated through operating system group
                      membership.
                      During installation, you are prompted to provide operating system groups whose members are
                      granted access to these system privileges. You can assign the same group to provide
                      authentication for these privileges (for example, ORA_DBA), but Oracle recommends that you
                      provide a unique group to designate each privilege.
                      The OSDBA subset job role separation privileges and groups consist of the following:
                      •     The OSBACKUPDBA group for Oracle Database (ORA_HOMENAME_SYSBACKUP)
                            Use this group if you want a separate group of operating system users to have a limited set
                            of database backup and recovery related administrative privileges (the SYSBACKUP
                            privilege).
                      •     The OSDGDBA group for Oracle Data Guard (ORA_HOMENAME_SYSDG)

Database Installation Guide
E96293-13                                                                                                  November 12, 2025
Copyright © 2015, 2025, Oracle and/or its affiliates.                                                           Page 8 of 12
                                                                                                                    Chapter 4
                                                                          Creating Required Operating System Groups and Users


                            Use this group if you want a separate group of operating system users to have a limited set
                            of privileges to administer and monitor Oracle Data Guard (the SYSDG privilege).
                      •     The OSKMDBA group for encryption key management (ORA_HOMENAME_SYSKM)
                            Use this group if you want a separate group of operating system users to have a limited set
                            of privileges for encryption key management such as Oracle Wallet Manager management
                            (the SYSKM privilege).
                      •     The OSRACDBA group for Oracle Real Application Clusters Administration
                            (ORA_HOMENAME_SYSRAC)
                            Use this group if you want a separate group of operating system users to have a limited set
                            of Oracle Real Application Clusters (RAC) administrative privileges (the SYSRAC
                            privilege). To use this privilege:
                            –    Add the Oracle Database installation owners as members of this group.


                                Note
                                All these groups, ORA_HOMENAME_SYSBACKUP, ORA_HOMENAME_SYSDG,
                                ORA_HOMENAME_SYSKM, and ORA_HOMENAME_SYSRAC are applicable only to the database
                                instances running from that particular Oracle home.



Oracle Automatic Storage Management Groups for Job Role Separation
                      Review the operating system groups.
                      Create the following operating system groups if you are installing Oracle Grid Infrastructure:
                      •     The OSDBA group for Oracle ASM (ORA_ASMDBA)
                            This group grants access for the database to connect to Oracle ASM. During installation,
                            the Oracle Installation Users are configured as members of this group. After you create an
                            Oracle Database, this group contains the Oracle Home Users of those database homes.
                            Any client of Oracle ASM that needs to access storage managed by Oracle ASM needs to
                            be in this group.
                      •     The OSASM group for Oracle ASM Administration (ORA_ASMADMIN)
                            Use this separate group to have separate administration privilege groups for Oracle ASM
                            and Oracle Database administrators. Members of this group are granted the SYSASM
                            system privilege to administer Oracle ASM. In Oracle documentation, the operating system
                            group whose members are granted privileges is called the OSASM group. During
                            installation, the Oracle Installation User for Oracle Grid Infrastructure and Oracle Database
                            Service IDs are configured as members of this group. Membership in this group also
                            grants database access to the Oracle ASM disks.
                            Members of the OSASM group can use SQL to connect to an Oracle ASM instance as
                            SYSASM using operating system authentication. The SYSASM privilege permits mounting
                            and dismounting disk groups, and other storage administration tasks. SYSASM system
                            privileges do not grant access privileges on an Oracle Database instance.
                      •     The OSOPER group for Oracle ASM (ORA_ASMOPER)
                            This is an optional group. Create this group if you want a separate group of operating
                            system users to have a limited set of Oracle ASM instance administrative privileges (the
                            SYSOPER for ASM privilege), including starting up and stopping the Oracle ASM instance.




Database Installation Guide
E96293-13                                                                                                  November 12, 2025
Copyright © 2015, 2025, Oracle and/or its affiliates.                                                           Page 9 of 12
                                                                                                                     Chapter 4
                                                                                             Stopping Existing Oracle Services


                            By default, members of the OSASM group also have all privileges granted by the
                            SYSOPER for ASM privilege.
                            To use the Oracle ASM Operator group to create an Oracle ASM administrator with fewer
                            privileges than those granted by the SYSASM system privilege you must assign the user to
                            this group after installation.


                                     See Also
                                     –    Oracle Database Administrator’s Guide
                                     –    Oracle Database Security Guide



Windows Group Managed Service Accounts and Virtual Accounts
                      Group Managed Services Account (gMSA) and Virtual Accounts are now supported and
                      enable you to create and manage Database services without passwords.

Microsoft Hyper-V Requirements
                      Microsoft Hyper-V enables you to create and manage a virtualized computing environment by
                      running multiple operating systems simultaneously on a single computer and isolate operating
                      systems from each other.
                      Microsoft Hyper-V enables built-in integration services for supported guest operating systems
                      to improve the integration between a computer and a virtual machine.
                      Oracle Database supports Hyper-V Dynamic Memory.


                                Note
                                Microsoft Hyper-V for specific Oracle Database and Microsoft Hyper-V certified
                                combinations




Stopping Existing Oracle Services
                      Learn how to stop all processes, including the listener and database, running in the Oracle
                      home.
                      Consider the following before you install Oracle Restart or Oracle Database:
                      •     If you intend to use Oracle Restart, then you must install the Oracle Restart before you
                            install and create the database. When you perform a database installation, the database
                            must use the same listener created during the Oracle Restart installation, thereafter you do
                            not have to perform the steps listed in this section.
                            The default listener and any additional listeners must run from the Oracle Grid
                            Infrastructure home.
                      •     If you have an existing Oracle Database 19c running on Oracle ASM, then stop any
                            existing Oracle ASM instances. After you finish installing Oracle Restart, start the Oracle
                            ASM instance again.




Database Installation Guide
E96293-13                                                                                                  November 12, 2025
Copyright © 2015, 2025, Oracle and/or its affiliates.                                                          Page 10 of 12
                                                                                                                   Chapter 4
                                                                                                   Configuring User Accounts


                      If you choose to create a database during the installation, then most installation types
                      configure and start a default Oracle Net listener using TCP/IP port 1521 and the IPC key value
                      EXTPROC. However, if an existing Oracle Net listener process is using the same port or key
                      value, Oracle Universal Installer looks for the next available port (for example, 1522) and
                      configures and starts the new listener on this available port.


                                Caution
                                If you are installing additional Oracle Database 19c products in an existing Oracle
                                home, then stop all processes, including the listener and database, running in the
                                Oracle home. You cannot install into an existing Oracle home other than 19c. You
                                must complete this task to enable Oracle Universal Installer to relink certain
                                executables and libraries.



Configuring User Accounts
                      During installation, you can specify an Oracle Home User.
                      Before starting the installation, perform the following checks for the Oracle Installation users to
                      ensure the installation succeeds:
                      •     Configuring Environment Variables for the Software Installation Owner
                            Before starting the Oracle Database installation, ensure that the TEMP environment variable
                            is set correctly.
                      •     Managing User Accounts with User Account Control
                            To ensure that only trusted applications run on your computer, the Windows operating
                            systems that support Oracle Database, provide User Account Control.


Configuring Environment Variables for the Software Installation Owner
                      Before starting the Oracle Database installation, ensure that the TEMP environment variable is
                      set correctly.


Managing User Accounts with User Account Control
                      To ensure that only trusted applications run on your computer, the Windows operating systems
                      that support Oracle Database, provide User Account Control.
                      If you have enabled this security feature, then, depending on the configuration, Oracle
                      Universal Installer prompts you for either your consent or your credentials when installing
                      Oracle Database.
                      You must have Administrator privileges to run Oracle tools, such as Database Configuration
                      Assistant, Net Configuration Assistant, and OPatch, or to run any tool or application that writes
                      to any directory within the Oracle home. If User Account Control is enabled, and you are
                      logged in as the local Administrator, then you can successfully run each of these commands.
                      However, if you are logged in as a member of the Administrator group, then you must explicitly
                      start these tasks with Windows Administrator privileges. All the Oracle shortcuts that require
                      Administrator privileges start as Administrator by default when you click the shortcuts.
                      However, if you run the above tools from a Windows command prompt, you must run them
                      from an Administrator command prompt. OPatch does not have a shortcut and has to be run
                      from an Administrator command prompt.



Database Installation Guide
E96293-13                                                                                                November 12, 2025
Copyright © 2015, 2025, Oracle and/or its affiliates.                                                        Page 11 of 12
                                                                                                                     Chapter 4
                                                                                  Creating Oracle Database Vault User Accounts



                                See Also
                                Oracle Database Administrator’s Reference for Microsoft Windows



                      To start a command prompt window with Windows Administrator privileges:
                      1.    On your desktop, create a shortcut for the command prompt window. An icon for that
                            shortcut appears on the desktop.
                      2.    Right-click the icon for the newly created shortcut, and specify Run as administrator.
                      When you open this window, the title bar reads Administrator: Command Prompt. Run
                      commands from within this window using Administrator privileges.


Creating Oracle Database Vault User Accounts
                      If you intend to use Oracle Database Vault by default, then you must create an Oracle
                      Database Vault user account, and configure that user.
                      You must create the Database Vault Owner account before you can use Oracle Database
                      Vault. You can also create a Database Vault Account Manager administrative account.
                      Oracle Database Vault installs a baseline database auditing policy. This policy covers the
                      access control configuration information stored in Oracle Database Vault database tables,
                      information stored in Oracle Catalog (rollback segments, tablespaces, and so on), the use of
                      system privileges, and Oracle Label Security configuration. When you install Oracle Database
                      Vault, the security specific database initialization parameters are initialized with default values.
                      Related Topics
                      •     Oracle Database Vault Administrator’s Guide




Database Installation Guide
E96293-13                                                                                                  November 12, 2025
Copyright © 2015, 2025, Oracle and/or its affiliates.                                                          Page 12 of 12
5
Configuring File System Storage for Oracle
Database
                      Complete these procedures to use file system storage for Oracle Database.
                      For optimal database organization and performance, Oracle recommends that you install data
                      files and the Oracle Database software in different disks.
                      If you plan to place storage on Network File System (NFS) protocol devices, then Oracle
                      recommends that you use Oracle Direct NFS (dNFS) to take advantage of performance
                      optimizations built into the Oracle Direct NFS client.
                      •     About Direct NFS Client Storage
                            With Oracle Database, you can store data files on a supported NFS system. You can
                            configure Oracle Database to access NFS servers directly using an Oracle internal Direct
                            NFS Client.
                      •     About the Oranfstab File for Direct NFS Client
                            To enable the Direct NFS Client, you must add an oranfstab file to ORACLE_HOME\dbs.
                      •     Mounting NFS Storage Devices with Direct NFS Client
                            Direct NFS Client determines the mount point settings for the NFS storage devices based
                            on the configuration information in oranfstab.
                      •     Specifying Network Paths for a NFS Server
                            Direct NFS Client can use up to four network paths defined in the oranfstab file for an NFS
                            server.
                      •     Creating an oranfstab File for Direct NFS Client
                            Direct NFS uses a configuration file, oranfstab, to determine the available mount points.
                      •     Performing Basic File Operations Using the ORADNFS Utility
                            ORADNFS is a utility which enables the database administrators to perform basic file
                            operations over Direct NFS Client on Microsoft Windows platforms.
                      •     Monitoring Direct NFS Client Usage
                            Use the following views for Direct NFS Client management:
                      •     Enabling Direct NFS Client
                            To enable Direct NFS Client, you must add an oranfstab file to the Oracle_home\dbs
                            directory and modify the related DLL files used by the Oracle Database software.
                      •     Disabling Direct NFS Client
                            Complete the following steps to disable the Direct NFS Client:
                      •     Enabling HCC on Direct NFS Client
                            To enable Hybrid Columnar Compression (HCC) on Direct NFS Client, perform the
                            following steps:
                      Related Topics
                      •     My Oracle Support note 1496040.1




Database Installation Guide
E96293-13                                                                                              November 12, 2025
Copyright © 2015, 2025, Oracle and/or its affiliates.                                                        Page 1 of 7
                                                                                                                      Chapter 5
                                                                                               About Direct NFS Client Storage




About Direct NFS Client Storage
                      With Oracle Database, you can store data files on a supported NFS system. You can configure
                      Oracle Database to access NFS servers directly using an Oracle internal Direct NFS Client.
                      Direct NFS Client supports NFSv3, NFSv4, NFSv4.1, and pNFS protocols to access the NFS
                      server. If Oracle Database cannot open an NFS server using Direct NFS Client, then an
                      informational message is logged into the Oracle alert and trace files indicating that Direct NFS
                      Client could not be established.
                      Starting with Oracle Database 12c Release 2, when you enable Direct NFS, you can access
                      Direct NFS dispatcher. The Direct NFS dispatcher consolidates the number of TCP
                      connections that are created from a database instance to the NFS server. In large database
                      deployments, using Direct NFS dispatcher improves scalability and network performance.
                      Parallel NFS deployments also require a large number of connections. Hence, the Direct NFS
                      dispatcher is recommended with Parallel NFS deployments too.
                      Direct NFS Client supports Dispatcher or the Input/Output (I/O) infrastructure. Dispatcher
                      enables database processes to use I/O slave processes to perform I/O operations. This limits
                      the number of sockets and Transmission Control Protocol (TCP) connections that the Direct
                      NFS Client requires to connect to the NFS server.
                      Starting with Oracle Database 12c Release 2 (12.2), Windows Direct NFS Client supports all
                      widely accepted NFS path formats including UNIX-style NFS paths, NFS version 4, and NFS
                      version 4.1 protocols.
                      The Oracle database files resident on the NFS server that are served by the Direct NFS Client
                      can also be accessed through a third party NFS client. The volume must be mounted through
                      CIFS or kernel NFS to enable regular windows utilities and commands, such as copy, and so
                      on, access the database files in the remote location. Volumes mounted through CIFS cannot
                      be used for database file storage without configuring Direct NFS Client. The atomic write
                      requirements required for database access are not guaranteed by CIFS protocol.
                      Consequently, CIFS can only be used for the operating system level commands, such as copy,
                      move, and so on.
                      Some NFS file servers require NFS clients to connect using reserved ports. If your filer is
                      running with reserved port checking, then you must disable it for Direct NFS Client to operate.
                      To disable reserved port checking, consult your NFS file server documentation.



                                See Also
                                •    Oracle Database Reference
                                •    Oracle Database Performance Tuning Guide
                                •    Oracle Database Administrator's Guide




About the Oranfstab File for Direct NFS Client
                      To enable the Direct NFS Client, you must add an oranfstab file to ORACLE_HOME\dbs.

                      When oranfstab is placed in this directory, the entries in this file are specific to a single
                      database.



Database Installation Guide
E96293-13                                                                                                  November 12, 2025
Copyright © 2015, 2025, Oracle and/or its affiliates.                                                            Page 2 of 7
                                                                                                                   Chapter 5
                                                                         Mounting NFS Storage Devices with Direct NFS Client




Mounting NFS Storage Devices with Direct NFS Client
                      Direct NFS Client determines the mount point settings for the NFS storage devices based on
                      the configuration information in oranfstab.

                      Direct NFS Client looks for the mount point entries in ORACLE_HOME\dbs\oranfstab. It uses the
                      first matched entry as the mount point.


Specifying Network Paths for a NFS Server
                      Direct NFS Client can use up to four network paths defined in the oranfstab file for an NFS
                      server.
                      The Direct NFS Client performs load balancing across all specified paths. If a specified path
                      fails, then Direct NFS Client reissues I/O commands over any remaining paths.
                      Direct NFS Client requires an NFS server supporting NFS read/write buffers of at least 16384
                      bytes.
                      Direct NFS Client issues writes at wtmax granularity to the NFS server. Direct NFS Client does
                      not serve an NFS server with a wtmax less than 16384. Oracle recommends that you use the
                      value 32768.
                      For NFS servers that restrict port range, you can use the insecure option to enable clients
                      other than root to connect to the NFS server. Alternatively, you can disable Direct NFS Client.


                                Note
                                Use NFS servers supported for Oracle Database. See the My Oracle Support website
                                for support information:
                                https://support.oracle.com




Creating an oranfstab File for Direct NFS Client
                      Direct NFS uses a configuration file, oranfstab, to determine the available mount points.

                      Create an oranfstab file with the following attributes for each NFS server that you want to
                      access using Direct NFS Client:
                      •     server
                            The NFS server name.
                            For NFS setup with Kerberos authentication, the server attribute name must be the fully-
                            qualified name of the NFS server. This server attribute name is used to create service
                            principal for Ticket Granting Service (TGS) request from the Kerberos server. If you are
                            configuring external storage snapshot cloning, then the NFS server name should be a
                            valid host name. For all other scenarios, the NFS server name can be any unique name.
                      •     local
                            Up to four paths on the database host, specified by IP address or by name, as displayed
                            using the ipconfig command run on the database host.



Database Installation Guide
E96293-13                                                                                                November 12, 2025
Copyright © 2015, 2025, Oracle and/or its affiliates.                                                          Page 3 of 7
                                                                                                                        Chapter 5
                                                                                  Creating an oranfstab File for Direct NFS Client


                      •     path
                            Up to four network paths to the NFS server, specified either by IP address, or by name, as
                            displayed using the ipconfig command on the NFS server.
                      •     export
                            The exported path from the NFS server. Use UNIX-style path.
                      •     mount
                            The corresponding local mount point for the exported volume. Use WINDOWS-style path.
                      •     Dontroute
                            Specifies that the outgoing messages must not be routed by the operating system, but sent
                            using the IP address to which they are bound.
                      •     mnt_timeout
                            Specifies (in seconds) the time Direct NFS Client should wait for a successful mount
                            before timing out. This parameter is optional. The default timeout is 10 minutes (600).
                      •     uid (Optional)
                            The UNIX user ID to be used by Direct NFS Client to access all NFS servers listed in
                            oranfstab. The default value is uid:65534, which corresponds to user:nobody on the NFS
                            server.
                      •     gid (Optional)
                            The UNIX group ID to be used by Direct NFS Client to access all the NFS servers listed in
                            oranfstab. The default value is gid:65534, which corresponds to group:nogroup on the
                            NFS server.
                      •     nfs_version
                            Specifies the NFS protocol version used by Direct NFS Client. Acceptable values are
                            nfsv3, nfsv4, nfsv4.1, and pnfs. The default version is nfsv3. If you select nfsv4.x, then you
                            must configure the value in oranfstab for nfs_version.
                      •     security_default (Optional)
                            Specifies the default security mode applicable for all the exported NFS server paths for a
                            server entry. The default value is sys . See the description of the security parameter for
                            the supported security levels for the security_default parameter.
                      •     security (Optional)
                            Specifies the security level, to enable security using Kerberos authentication protocol with
                            Direct NFS Client. Specify security per export-mount pair. The supported security levels
                            for the security_default and security parameters are:
                                sys: UNIX level security AUTH_UNIX authentication based on user identifier (UID) and
                                group identifier (GID) values. This is the default value for security parameters.
                                krb5: Direct NFS runs with plain Kerberos authentication. Server is authenticated as
                                the real server which it claims to be.
                                krb5i: Direct NFS runs with Kerberos authentication and NFS integrity. Server is
                                authenticated and each of the message transfers is checked for integrity.
                                krb5p: Direct NFS runs with Kerberos authentication and NFS privacy. Server is
                                authenticated, and all data is completely encrypted.
                            The security parameter, if specified, takes precedence over the security_default
                            parameter. If neither of these parameters are specified, then sys is the default
                            authentication.



Database Installation Guide
E96293-13                                                                                                     November 12, 2025
Copyright © 2015, 2025, Oracle and/or its affiliates.                                                               Page 4 of 7
                                                                                                                     Chapter 5
                                                                               Creating an oranfstab File for Direct NFS Client


                            For NFS server Kerberos security setup, review the relevant NFS server documentation.
                            For Kerberos client setup, review the relevant operating system documentation.
                      •     management
                            Enables Direct NFS Client to use the management interface for SNMP queries. You can
                            use this parameter if SNMP is running on separate management interfaces on the NFS
                            server. The default value is the server parameter value.
                      •     community
                            Specifies the community string for use in SNMP queries. Default value is public.
                      The following examples show three possible NFS server entries in oranfstab. A single
                      oranfstab can have multiple NFS server entries.

                      Example 5-1          Using Local and Path NFS Server Entries
                      The following example uses both local and path. Because they are in different subnets, you do
                      not have to specify dontroute.

                      server: MyDataServer1
                      local: 192.0.2.0
                      path: 192.0.2.1
                      local: 192.0.100.0
                      path: 192.0.100.1
                      export: /vol/oradata1 mount: C:\APP\ORACLE\ORADATA\ORCL


                      Example 5-2 Using Names in Place of IP Addresses, with Multiple Exports,
                      management and community

                      server: MyDataServer2
                      local: LocalPath1
                      path: NfsPath1
                      local: LocalPath2
                      path: NfsPath2
                      local: LocalPath3
                      path: NfsPath3
                      local: LocalPath4
                      path: NfsPath4
                      nfs_version: nfsv3
                      dontroute
                      export: /vol/oradata2 mount: C:\APP\ORACLE\ORADATA\ORCL2
                      export: /vol/oradata3 mount: C:\APP\ORACLE\ORADATA\ORCL3
                      export: /vol/oradata4 mount: C:\APP\ORACLE\ORADATA\ORCL4
                      export: /vol/oradata5 mount: C:\APP\ORACLE\ORADATA\ORCL5
                      management: MgmtPath1
                      community: private


                      Example 5-3          Using Kerberos Authentication with Direct NFS Export
                      The security parameter overrides security_default:

                      server: nfsserver
                       local: 192.0.2.0
                       path: 192.0.2.2
                       local: 192.0.2.3
                       path: 192.0.2.4


Database Installation Guide
E96293-13                                                                                                  November 12, 2025
Copyright © 2015, 2025, Oracle and/or its affiliates.                                                            Page 5 of 7
                                                                                                                          Chapter 5
                                                                         Performing Basic File Operations Using the ORADNFS Utility


                       export: /vol/oradata2 mount: C:\APP\ORACLE\ORADATA\ORCL2 security: krb5
                       export: /vol/oradata3 mount: C:\APP\ORACLE\ORADATA\ORCL3 security: krb5p
                       export: /vol/oradata3 mount: C:\APP\ORACLE\ORADATA\ORCL4 security: sys
                       export: /vol/oradata3 mount: C:\APP\ORACLE\ORADATA\ORCL5
                      security_default: krb5i



Performing Basic File Operations Using the ORADNFS Utility
                      ORADNFS is a utility which enables the database administrators to perform basic file
                      operations over Direct NFS Client on Microsoft Windows platforms.
                      ORADNFS is a multi-call binary, a single binary that acts like several utilities. This allows
                      ORADNFS to be smaller since all the built-in commands can leverage DNFS code for many
                      common operations. ORADNFS is run by issuing a command as an argument on the
                      command line.
                      For example, C:\> ORADNFS help causes ORADNFS to print a list of built-in commands, and
                      C:\> ORADNFS ls C:\ORACLE\ORADATA\ORCL causes ORADNFS to behave as an ls command
                      of C:\ORACLE\ORADATA\ORCL remote directory, where C:\ORACLE\ORADATA is a DNFS virtual
                      mount point specified in the oranfstab configuration file.


                                 Note

                                 •     A valid copy of the oranfstab configuration file must be present in
                                       ORACLE_HOME\dbs directory for ORADNFS to operate.
                                 •     The user must be a member of the local ORA_DBA group to execute ORADNFS.




Monitoring Direct NFS Client Usage
                      Use the following views for Direct NFS Client management:

                      •     v$dnfs_servers: Shows a table of servers accessed using Direct NFS Client.
                      •     v$dnfs_files: Shows a table of files currently open using Direct NFS Client.
                      •     v$dnfs_channels: Shows a table of open network paths (or channels) to servers for which
                            Direct NFS Client is providing files.
                      •     v$dnfs_stats: Shows a table of performance statistics for Direct NFS Client.


Enabling Direct NFS Client
                      To enable Direct NFS Client, you must add an oranfstab file to the Oracle_home\dbs
                      directory and modify the related DLL files used by the Oracle Database software.

                      1.    Create an oranfstab file.
                      2.    Replace the standard ODM library, oraodm19.dll, with the ODM NFS library
                            Oracle Database uses the ODM library, oranfsodm19.dll, to enable Direct NFS Client. To
                            replace the ODM library, complete the following steps:
                            a.       Change directory to Oracle_home\bin.


Database Installation Guide
E96293-13                                                                                                       November 12, 2025
Copyright © 2015, 2025, Oracle and/or its affiliates.                                                                 Page 6 of 7
                                                                                                                  Chapter 5
                                                                                                Disabling Direct NFS Client


                            b.   Shut down the Oracle Database instance on a node using the Server Control Utility
                                 (SRVCTL).
                            c.   Enter the following commands:

                                 copy oraodm19.dll oraodm19.dll.orig
                                 copy /Y oranfsodm19.dll oraodm19.dll

                            d.   Restart the Oracle Database instance using SRVCTL.
                            e.   Repeat Step 2.a to Step 2.d for each node in the cluster.


Disabling Direct NFS Client
                      Complete the following steps to disable the Direct NFS Client:

                      1.    Log in as the Oracle Grid Infrastructure software owner.
                      2.    Set ORACLE_HOME to Oracle home for which the Direct NFS Client must be disabled.
                      3.    Change directory to ORACLE_HOME\bin.
                      4.    Shut down the Oracle database.
                      5.    Run the batch file, disable_dnfs.bat to delete
                            ORACLE_HOME\rdbms\lib\odm\oranfsodm18.dll.
                      6.    Remove the oranfstab file.


                                 Note
                                 If you remove an NFS path that an Oracle Database is using, then you must restart
                                 the database for the change to take effect.




Enabling HCC on Direct NFS Client
                      To enable Hybrid Columnar Compression (HCC) on Direct NFS Client, perform the following
                      steps:
                      1.    Ensure that SNMP is enabled on the ZFS storage server. For example:
                            C:\>snmpget -v1 -c public server_name .1.3.6.1.4.1.42.2.225.1.4.2.0
                            SNMPv2-SMI::enterprises.42.2.225.1.4.2.0 = STRING: "Sun Storage 7410"
                      2.    If SNMP is enabled on an interface other than the NFS server, then configure oranfstab
                            using the management parameter.
                      3.    If SNMP is configured using a community string other than public, then configure the
                            oranfstab file using the community parameter.
                      4.    Ensure that Wsnmp32.dll and snmpapi.dll are installed by checking if snmpget is
                            available.




Database Installation Guide
E96293-13                                                                                              November 12, 2025
Copyright © 2015, 2025, Oracle and/or its affiliates.                                                        Page 7 of 7
6
Installing and Configuring Oracle Grid
Infrastructure for a Standalone Server
                      If you intend to use Oracle Automatic Storage Management (Oracle ASM), then you must
                      install Oracle Restart before installing your database.
                      Oracle Grid Infrastructure for a standalone server is a version of Oracle Grid Infrastructure that
                      supports single instance databases. This support includes volume management, file system,
                      and automatic restart capabilities. Oracle Grid Infrastructure for a standalone server includes
                      Oracle Restart and Oracle Automatic Storage Management. Oracle combined the two
                      infrastructure products into a single set of binaries that is installed into an Oracle Restart home.

                      Oracle Restart is a feature provided as part of Oracle Grid Infrastructure. Oracle Restart
                      monitors and can restart Oracle Database instances, Oracle Net Listeners, and Oracle ASM
                      instances. Oracle Restart is currently restricted to manage single instance Oracle Databases
                      and Oracle ASM instances only, and is subject to desupport in future releases. Oracle
                      continues to provide Oracle ASM as part of the Oracle Grid Infrastructure installation for a
                      standalone server and Cluster deployments.

                      Oracle Automatic Storage Management is a volume manager and a file system for Oracle
                      Database files that supports single-instance Oracle Database and Oracle Real Application
                      Clusters (Oracle RAC) configurations. Oracle Automatic Storage Management also supports a
                      general purpose file system for your application needs, including Oracle Database binaries.
                      Oracle Automatic Storage Management is Oracle's recommended storage management
                      solution that provides an alternative to conventional volume managers and file systems.
                      Oracle Restart improves the availability of your Oracle database because of the following:
                      •     When there is a hardware or a software failure, Oracle Restart automatically starts all
                            Oracle components, including the Oracle database instance, Oracle Net Listener, database
                            services, and Oracle ASM.
                      •     Oracle Restart starts components in the proper order when the database host is restarted.
                      •     Oracle Restart runs periodic checks to monitor the status of Oracle components. If a check
                            operation fails for a component, then the component is shut down and restarted.




Database Installation Guide
E96293-13                                                                                                November 12, 2025
Copyright © 2015, 2025, Oracle and/or its affiliates.                                                         Page 1 of 23
                                                                                                                     Chapter 6



                                Note
                                •    You can neither install Oracle Restart on an Oracle Grid Infrastructure cluster
                                     member node, nor add an Oracle Restart server to an Oracle Grid Infrastructure
                                     cluster member node. Oracle Restart supports single-instance databases on one
                                     server, while Oracle Grid Infrastructure for a Cluster supports single-instance or
                                     Oracle RAC databases on a cluster.
                                •    If you install Oracle Grid Infrastructure for a standalone server on a host computer
                                     on which a database already exists, then you must manually add the database,
                                     the listener, the Oracle ASM instance, and other components to the Oracle Restart
                                     configuration before you are able to configure automatic database restarts.
                                •    You can use the Oracle Restart implementation of Oracle Grid Infrastructure only
                                     in single-instance (nonclustered) environments. Use Oracle Grid Infrastructure
                                     with Oracle Clusterware for clustered environments.
                                •    Oracle Grid Infrastructure for a standalone server can support multiple single-
                                     instance databases on a single host computer.



                      •     Requirements for an Oracle Restart Installation
                            Before you install Oracle Restart, ensure that your system meets the following
                            requirements:
                      •     Oracle ACFS and Oracle ADVM
                            Oracle Automatic Storage Management Cluster File System (Oracle ACFS) extends
                            Oracle ASM technology to support of all of your application data in both single instance
                            and cluster configurations.
                      •     Oracle Automatic Storage Management Storage Configuration
                            Review the following sections for information on Oracle Automatic Storage Management
                            (Oracle ASM) storage configuration:
                      •     About Upgrading Existing Oracle Automatic Storage Management Instances
                            Oracle Automatic Storage Management (Oracle ASM) upgrades are carried out during an
                            Oracle Grid Infrastructure upgrade.
                      •     Configuring Oracle Automatic Storage Management Disk Groups Manually Using Oracle
                            ASMCA
                            The Oracle Automatic Storage Management Configuration Assistant utility creates a new
                            Oracle Automatic Storage Management instance if there is no Oracle Automatic Storage
                            Management instance currently configured on this computer.
                      •     About Image-Based Oracle Grid Infrastructure Installation
                            Starting with Oracle Grid Infrastructure 12c Release 2 (12.2), installation and configuration
                            of Oracle Grid Infrastructure software is simplified with image-based installation.
                      •     Setup Wizard Installation Options for Creating Images
                            Before you start the setup wizards for your Oracle Database or Oracle Grid Infrastructure
                            installation, decide if you want to use any of the available image-creation options.
                      •     Installing Oracle Grid Infrastructure for a Standalone Server with a New Database
                            Installation
                            Complete these steps to install Oracle Restart and then create a database that is managed
                            by Oracle Restart.
                      •     Installing Oracle Grid Infrastructure for a Standalone Server for an Existing Database
                            Follow the high-level instructions in this section to install Oracle Grid Infrastructure and
                            configure it for an existing Oracle database.


Database Installation Guide
E96293-13                                                                                                  November 12, 2025
Copyright © 2015, 2025, Oracle and/or its affiliates.                                                           Page 2 of 23
                                                                                                                        Chapter 6
                                                                                  Requirements for an Oracle Restart Installation


                      •     Installing Oracle Grid Infrastructure for a Standalone Server Using a Software-Only
                            Installation
                            A software-only installation only installs the Oracle Restart binaries at the specified
                            location. You must complete a few manual configuration steps to enable Oracle Grid
                            Infrastructure after you install the software.
                      •     Testing the Oracle Automatic Storage Management Installation
                            After installing Oracle Grid Infrastructure for a single instance, use the ASMCMD
                            command-line utility to test the Oracle ASM installation.
                      •     Modifying Oracle Grid Infrastructure for a Standalone Server Binaries After Installation
                            After installation, you must first stop the Oracle Restart stack to modify the software
                            installed in your Grid home.


                                See Also
                                https://support.oracle.com/rs?type=doc&id=1584742.1



Requirements for an Oracle Restart Installation
                      Before you install Oracle Restart, ensure that your system meets the following requirements:
                      •     System Requirements
                            Oracle Restart has similar system requirements as Oracle Grid Infrastructure for a cluster,
                            such as requiring 64-bit Windows server operating system.
                      •     Memory Requirements
                            At least 1 GB of RAM for Oracle Restart installations, including installations where you plan
                            to install Oracle Database.
                      •     Disk Space Requirements
                            The disk space requirements for installing Oracle Restart are:


System Requirements
                      Oracle Restart has similar system requirements as Oracle Grid Infrastructure for a cluster,
                      such as requiring 64-bit Windows server operating system.
                      Components included with Oracle Grid Infrastructure, such as Oracle ASM, have the same
                      system requirements as Oracle Grid Infrastructure.



                                See Also
                                Oracle Grid Infrastructure Installation and Upgrade Guide for Microsoft Windows




Memory Requirements
                      At least 1 GB of RAM for Oracle Restart installations, including installations where you plan to
                      install Oracle Database.




Database Installation Guide
E96293-13                                                                                                    November 12, 2025
Copyright © 2015, 2025, Oracle and/or its affiliates.                                                             Page 3 of 23
                                                                                                                    Chapter 6
                                                                                                Oracle ACFS and Oracle ADVM



Disk Space Requirements
                      The disk space requirements for installing Oracle Restart are:
                      •     At least 7 GB of disk space
                      •     The amount of disk space available in the %TEMP% directory is equivalent to the total
                            amount of free disk space, minus what is required to install Oracle Restart
                      If the free disk space is less than 1 GB in the %TEMP% directory, then:

                      •     Delete unnecessary files from the %TEMP% directory to meet the disk space requirement.
                      •     Set TEMP environment variable. Go to System Properties, then Environment Variables,
                            "TEMP=C:\Temp\."


Oracle ACFS and Oracle ADVM
                      Oracle Automatic Storage Management Cluster File System (Oracle ACFS) extends Oracle
                      ASM technology to support of all of your application data in both single instance and cluster
                      configurations.
                      Oracle Automatic Storage Management Dynamic Volume Manager (Oracle ADVM) provides
                      volume management services and a standard disk device driver interface to clients. Oracle
                      ACFS communicates with Oracle ASM through the Oracle ADVM interface.
                      •     Oracle ACFS and Oracle ADVM Support on Microsoft Windows
                            Oracle ACFS and Oracle ADVM are supported on Windows Server 2012 x64, Windows
                            Server 2012 R2 x64, and Windows 2016 x64.
                      •     Restrictions and Guidelines for Oracle ACFS
                            Review these guidelines and restrictions as part of your storage plan for using Oracle
                            ACFS for single instance and cluster configurations.
                      Related Topics
                      •     Oracle Automatic Storage Management Administrator's Guide


Oracle ACFS and Oracle ADVM Support on Microsoft Windows
                      Oracle ACFS and Oracle ADVM are supported on Windows Server 2012 x64, Windows Server
                      2012 R2 x64, and Windows 2016 x64.



                                See Also
                                •    My Oracle Support Note 1369107.1 for more information about platforms and
                                     releases that support Oracle ACFS and Oracle ADVM: https://
                                     support.oracle.com/rs?type=doc&id=1369107.1
                                •    My Oracle Support Note 854428.1, Patch Set Updates for Oracle Products, for
                                     current release and support information: https://support.oracle.com/epmos/faces/
                                     DocumentDisplay?id=854428.1
                                •    Oracle Automatic Storage Management Administrator's Guide for more
                                     information about Oracle ACFS and Oracle ADVM




Database Installation Guide
E96293-13                                                                                                 November 12, 2025
Copyright © 2015, 2025, Oracle and/or its affiliates.                                                          Page 4 of 23
                                                                                                                   Chapter 6
                                                                                               Oracle ACFS and Oracle ADVM



Restrictions and Guidelines for Oracle ACFS
                      Review these guidelines and restrictions as part of your storage plan for using Oracle ACFS for
                      single instance and cluster configurations.
                      •     Oracle Automatic Storage Management Cluster File System (Oracle ACFS) provides a
                            general purpose file system.
                      •     You can only use Oracle ACFS when Oracle ASM is configured.
                      •     You must use a domain user when installing Oracle Grid Infrastructure if you plan to use
                            Oracle ACFS.
                      •     When creating Oracle ACFS file systems on Windows, log on as a Windows domain user.
                            Also, when creating files in an Oracle ACFS file system on Windows, you should be logged
                            in as a Windows domain user to ensure that the files are accessible by all nodes.
                            When using a file system across cluster nodes, the best practice is to mount the file
                            system using a domain user, to ensure that the security identifier is the same across
                            cluster nodes. Windows security identifiers, which are used in defining access rights to files
                            and directories, use information which identifies the user. Local users are only known in the
                            context of the local node. Oracle ACFS uses this information during the first file system
                            mount to set the default access rights to the file system.
                      Note the following general guidelines and restrictions for placing Oracle Database and Oracle
                      Grid Infrastructure files on Oracle ACFS:
                      •     Starting with Oracle Grid Infrastructure 12c Release 1 (12.1) for a cluster, you can place
                            Oracle Database binaries, data files, and administrative files (for example, trace files) on
                            Oracle ACFS.
                      •     Oracle ACFS does not support encryption or replication with Oracle Database data files,
                            tablespace files, control files, redo logs, archive logs, RMAN backups, Data Pump
                            dumpsets, and flashback files
                      •     You can place Oracle Database homes on Oracle ACFS only if the database release is
                            Oracle Database 11g release 2 or later. You cannot install earlier releases of Oracle
                            Database on Oracle ACFS.
                      •     For installations of Oracle Clusterware, you cannot place Oracle Clusterware files on
                            Oracle ACFS.
                      •     For policy-managed Oracle Flex Cluster databases, Oracle ACFS can run on any cluster
                            node.
                      The following restrictions apply if you run Oracle ACFS in an Oracle Restart configuration:
                      •     Starting with Oracle Database 18c, configuration assistants do not allow the creation of
                            Oracle Database homes on Oracle ACFS in an Oracle Restart configuration.
                      •     Oracle Restart does not support Oracle ACFS resources on all platforms.
                      •     Starting with Oracle Database 12c, Oracle Restart configurations do not support the Oracle
                            ACFS registry.
                      •     You must manually load Oracle ACFS drivers after a system restart.
                      •     You must manually mount an Oracle ACFS file system, and unmount it after the Oracle
                            ASM instance has finished running.
                      •     Creating Oracle data files on an Oracle ACFS file system is not supported in Oracle
                            Restart configurations. Creating Oracle data files on an Oracle ACFS file system is
                            supported on Oracle Grid Infrastructure for a cluster configurations.


Database Installation Guide
E96293-13                                                                                                 November 12, 2025
Copyright © 2015, 2025, Oracle and/or its affiliates.                                                          Page 5 of 23
                                                                                                                    Chapter 6
                                                                    Oracle Automatic Storage Management Storage Configuration




Oracle Automatic Storage Management Storage Configuration
                      Review the following sections for information on Oracle Automatic Storage Management
                      (Oracle ASM) storage configuration:
                      •     About Managing Disk Groups for Older Database Versions
                            Use Oracle ASM Configuration Assistant (Oracle ASMCA) to create and modify disk
                            groups when you install earlier Oracle databases on Oracle Grid Infrastructure
                            installations.
                      •     Oracle Automatic Storage Management Installation Considerations
                            In previous releases, Oracle Automatic Storage Management (Oracle ASM) was installed
                            as part of the Oracle Database installation. Starting with Oracle Database 11g Release 2
                            (11.2), Oracle Automatic Storage Management is part of an Oracle Grid Infrastructure
                            installation, either for a cluster, or for a standalone server.
                      •     Configuring Storage for Oracle Automatic Storage Management
                            Identify storage requirements and ASM disk group options.


About Managing Disk Groups for Older Database Versions
                      Use Oracle ASM Configuration Assistant (Oracle ASMCA) to create and modify disk groups
                      when you install earlier Oracle databases on Oracle Grid Infrastructure installations.
                      Releases prior to Oracle Database 11g Release 2 used Oracle Database Configuration
                      Assistant (Oracle DBCA) to perform administrative tasks on Oracle ASM. Starting with Oracle
                      Database 11g Release 2 (11.2), Oracle ASM is installed as part of an Oracle Grid Infrastructure
                      installation. You can no longer use Oracle DBCA to perform administrative tasks on Oracle
                      ASM.



                                See Also
                                Oracle Automatic Storage Management Administrator's Guide for details about
                                configuring disk group compatibility for databases using Oracle Database 11g software
                                with this release of Oracle Grid Infrastructure.




Oracle Automatic Storage Management Installation Considerations
                      In previous releases, Oracle Automatic Storage Management (Oracle ASM) was installed as
                      part of the Oracle Database installation. Starting with Oracle Database 11g Release 2 (11.2),
                      Oracle Automatic Storage Management is part of an Oracle Grid Infrastructure installation,
                      either for a cluster, or for a standalone server.
                      If you want to upgrade an existing Oracle Automatic Storage Management installation, then
                      you must upgrade Oracle Automatic Storage Management by running an Oracle Grid
                      Infrastructure upgrade (upgrades of existing Oracle Automatic Storage Management
                      installations). If you do not have Oracle Automatic Storage Management installed and you
                      want to use Oracle Automatic Storage Management as your storage option, then you must
                      complete an Oracle Restart installation before you start your Oracle Database installation.
                      You must run Oracle Automatic Storage Management Configuration Assistant for installing and
                      configuring Oracle ASM instances, disk groups, volumes, and Oracle Automatic Storage



Database Installation Guide
E96293-13                                                                                                  November 12, 2025
Copyright © 2015, 2025, Oracle and/or its affiliates.                                                           Page 6 of 23
                                                                                                                    Chapter 6
                                                                    Oracle Automatic Storage Management Storage Configuration


                      Management Cluster File System (Oracle ACFS). In addition, you can use the ASMCA
                      command-line interface.
                      Apply the following guidelines when you install Oracle Automatic Storage Management:
                      •     You must complete the steps listed under the Configuring Storage for Oracle Automatic
                            Storage Management section to prepare a disk partition to use for the Oracle Automatic
                            Storage Management disk groups.
                      •     Ensure that at least one disk is configured appropriately in an Oracle ASM disk group
                            before beginning the installation.
                      •     When you install Oracle Automatic Storage Management, Oracle Automatic Storage
                            Management Configuration Assistant creates a separate server parameter file (SPFILE)
                            and password file for the Oracle Automatic Storage Management instance. As soon as
                            Oracle Automatic Storage Management is installed, ASMSNMP schema and user are created.
                      •     The Oracle Automatic Storage Management instance that manages the existing disk group
                            runs in the Oracle Grid Infrastructure home directory.
                      Related Topics
                      •     Performance and Scalability Considerations for Disk Groups
                      •     Password File Authentication for Oracle ASM


Configuring Storage for Oracle Automatic Storage Management
                      Identify storage requirements and ASM disk group options.

                      •     Identifying Storage Requirements for Oracle Automatic Storage Management
                            To identify the storage requirements for using Oracle ASM, you must determine the
                            number of devices and the amount of free disk space that you require. To complete this
                            task, follow these steps:
                      •     Oracle ASM Disk Space Requirements
                            Determine the total amount of Oracle Automatic Storage Management (Oracle ASM) disk
                            space that you require for the database files and recovery files.
                      •     ASM Disk Group Options for Interactive and Noninteractive Installation
                            You can select new disk groups during interactive installations, but you must use existing
                            disk groups for noninteractive installations.
                      •     Configuring Disks Manually for Oracle Automatic Storage Management
                            To use Oracle Automatic Storage Management with direct attached storage (DAS) or
                            storage area network (SAN), the disks must be stamped with a header.


                                See Also
                                Oracle Automatic Storage Management Administrator's Guide



Identifying Storage Requirements for Oracle Automatic Storage Management
                      To identify the storage requirements for using Oracle ASM, you must determine the number of
                      devices and the amount of free disk space that you require. To complete this task, follow these
                      steps:




Database Installation Guide
E96293-13                                                                                                  November 12, 2025
Copyright © 2015, 2025, Oracle and/or its affiliates.                                                           Page 7 of 23
                                                                                                                       Chapter 6
                                                                       Oracle Automatic Storage Management Storage Configuration


                      1.    Determine whether you want to use Oracle ASM for Oracle Database files, recovery files,
                            or both. Oracle Database files include data files, control files, redo log files, the server
                            parameter file, and the password file.
                            During the database installation, you have the option to select either a file system or
                            Oracle ASM as the storage mechanism for Oracle Database files. Similarly, you also have
                            the option to select either a file system or Oracle ASM as the storage mechanism for your
                            recovery files.


                                     Note
                                     You do not have to use the same storage mechanism for both Oracle Database
                                     files and recovery files. You can use a file system for one file type and Oracle ASM
                                     for the other.



                            If you select Oracle ASM as your storage option for Oracle Database files, then depending
                            on your choice in the Specify Recovery Options screen, you have the following recovery
                            options:
                            •    If you select the Oracle ASM option for your recovery files, then Oracle Universal
                                 Installer provides you with only the option to use the same disk group for both Oracle
                                 Database files and recovery files.
                            •    If you decide not to enable recovery during the database installation, then, after the
                                 database installation, you can modify the DB_RECOVERY_FILE_DEST parameter to enable
                                 the fast recovery area.
                      2.    Choose the Oracle ASM redundancy level to use for each Oracle ASM disk group that you
                            create.
                            The redundancy level that you choose for the Oracle ASM disk group determines how
                            Oracle ASM mirrors files in the disk group and determines the number of disks and amount
                            of disk space that you require, as follows:
                            •    External redundancy
                                 This option does not allow Oracle ASM to mirror the contents of the disk group. Oracle
                                 recommends that you select this redundancy level either when the disk group contains
                                 devices, such as RAID devices, that provide their own data protection or when the
                                 database does not require uninterrupted access to data.
                            •    Normal redundancy
                                 To optimize performance and reliability in a normal redundancy disk group, Oracle
                                 ASM uses two-way mirroring for data files and three-way mirroring for control files, by
                                 default. In addition, you can choose the mirroring characteristics for individual files in a
                                 disk group.
                                 A normal redundancy disk group requires a minimum of two failure groups (or two disk
                                 devices) if you are using two-way mirroring. The effective disk space in a normal
                                 redundancy disk group is half the sum of the disk space of all of its devices.
                                 For most installations, Oracle recommends that you use normal redundancy disk
                                 groups. On Oracle Exadata, Oracle recommends that you use high redundancy disk
                                 groups for added protection against failure.
                            •    High redundancy




Database Installation Guide
E96293-13                                                                                                     November 12, 2025
Copyright © 2015, 2025, Oracle and/or its affiliates.                                                              Page 8 of 23
                                                                                                                       Chapter 6
                                                                       Oracle Automatic Storage Management Storage Configuration


                                 The contents of the disk group are three-way mirrored by default. To create a disk
                                 group with high redundancy, you must specify at least three failure groups (a minimum
                                 of three devices).
                                 Although high-redundancy disk groups provide a high level of data protection, you
                                 must consider the higher cost of additional storage devices before deciding to use this
                                 redundancy level.
                            •    Flex redundancy
                                 A flex redundancy disk group is a new disk group type with features such as flexible
                                 file redundancy, mirror splitting, and redundancy change. A flex disk group can
                                 consolidate files with different redundancy requirements into a single disk group. It also
                                 provides the capability for databases to change the redundancy of its files.
                                 For database data, you can choose no mirroring (unprotected), two-way mirroring
                                 (mirrored), or three-way mirroring (high). A flex redundancy disk group requires a
                                 minimum of three disk devices (or three failure groups).
                      3.    Determine the total amount of disk space that you require for the database files and
                            recovery files.
                            If an Oracle ASM instance is running on the system, then you can use an existing disk
                            group to meet these storage requirements. If necessary, you can add disks to an existing
                            disk group during the database installation.
                            See, "Oracle ASM Disk Space Requirements" in Oracle Database Installation Guide for the
                            Oracle ASM disk space requirements.


                                     Note
                                     •    The disk devices must be owned by the user performing the grid installation.
                                          Check with your system administrator to determine if the disks used by Oracle
                                          ASM are mirrored at the storage level. If so, select External for the
                                          redundancy. If the disks are not mirrored at the storage level, then select
                                          Normal for the redundancy.
                                     •    Every Oracle ASM disk is divided into allocation units (AU). An allocation unit
                                          is the fundamental unit of allocation within a disk group. You can select the AU
                                          Size value from 1, 2, 4, 8, 16, 32 or 64 MB, depending on the specific disk
                                          group compatibility level. The default value is 4 MB for flex disk group and 1
                                          MB for all other disk group types. On engineered systems, the default value is
                                          4 MB.


                      4.    Optionally, identify failure groups for the Oracle ASM disk group devices.
                            If you intend to use a normal, high or flex redundancy disk group, then you can further
                            protect your database against hardware failure by associating a set of disk devices in a
                            custom failure group. By default, each device comprises its own failure group. However, if
                            two disk devices in a normal redundancy disk group are attached to the same Host Bus
                            Adapter (HBA), then the disk group becomes unavailable if the controller fails. The
                            controller in this example is a single point of failure.
                            To protect against failures of this type, use two HBAs, each with two disks, and define a
                            failure group for the disks attached to each controller. This configuration enables the disk
                            group to tolerate the failure of one HBA.
                            Consider the following guidelines while defining custom failure groups:




Database Installation Guide
E96293-13                                                                                                     November 12, 2025
Copyright © 2015, 2025, Oracle and/or its affiliates.                                                              Page 9 of 23
                                                                                                                      Chapter 6
                                                                      Oracle Automatic Storage Management Storage Configuration


                            •    Starting with release 12.2, you can specify custom failure groups in the Create ASM
                                 Disk Group screen during an Oracle Grid Infrastructure installation.
                            •    You can also define custom failure groups after installation, using the GUI tool
                                 ASMCA, the command line tool asmcmd, or SQL commands.
                            •    If you define custom failure groups, then for failure groups containing database files
                                 only, you must specify a minimum of two failure groups for normal redundancy disk
                                 groups and three failure groups for high redundancy disk groups.
                      5.    If you are sure that a suitable disk group does not exist on the system, then install or
                            identify appropriate disk devices to add to a new disk group.
                            Use the following guidelines when identifying appropriate disk devices:
                            •    The disk devices must be owned by the user performing the Oracle Grid Infrastructure
                                 installation.
                            •    All the devices in an Oracle ASM disk group must be the same size and have the
                                 same performance characteristics.
                            •    Do not specify multiple partitions on a single physical disk as a disk group device.
                                 Oracle ASM expects each disk group device to be on a separate physical disk.
                            •    Although you can specify a logical volume as a device in an Oracle ASM disk group,
                                 Oracle does not recommend their use because it adds a layer of complexity that is
                                 unnecessary with Oracle ASM. Oracle recommends that if you choose to use a logical
                                 volume manager, then use the logical volume manager to represent a single logical
                                 unit number (LUN) without striping or mirroring, so that you can minimize the effect on
                                 storage performance of the additional storage layer.
                      Related Topics
                      •     Oracle Automatic Storage Management Administrator's Guide

Oracle ASM Disk Space Requirements
                      Determine the total amount of Oracle Automatic Storage Management (Oracle ASM) disk
                      space that you require for the database files and recovery files.

                      Table 6-1 Oracle ASM Disk Number and Minimum Space Requirements for an Oracle
                      database (non-CDB)

                       Redundancy               Minimum Number Data Files            Recovery Files       Both File Types
                       Level                    of Disks
                       External                 1               2.7 GB               8.1 GB               10.8 GB
                       Normal or Flex with 2                    5.2 GB               15.6 GB              20.8 GB
                       two-way mirroring
                       High or Flex with   3                    7.8 GB               23.4 GB              31.2 GB
                       three-way mirroring


                      Table 6-2 Oracle ASM Disk Number and Minimum Space Requirements for a
                      multitenant container database (CDB) with one pluggable database (PDB)

                       Redundancy               Minimum Number Data Files            Recovery Files       Both File Types
                       Level                    of Disks
                       External                 1               4.4 GB               13.2 GB              17.6 GB




Database Installation Guide
E96293-13                                                                                                    November 12, 2025
Copyright © 2015, 2025, Oracle and/or its affiliates.                                                            Page 10 of 23
                                                                                                                        Chapter 6
                                                                        Oracle Automatic Storage Management Storage Configuration



                      Table 6-2 (Cont.) Oracle ASM Disk Number and Minimum Space Requirements for a
                      multitenant container database (CDB) with one pluggable database (PDB)

                       Redundancy               Minimum Number Data Files              Recovery Files       Both File Types
                       Level                    of Disks
                       Normal or Flex with 2                       8.6 GB              25.8 GB              34.4 GB
                       two-way mirroring
                       High or Flex with   3                       12.9 GB             38.7 GB              51.6 GB
                       three-way mirroring



                                Note
                                •      If an Oracle ASM instance is running on the system, then you can use an existing
                                       disk group to meet these storage requirements. If necessary, you can add disks to
                                       an existing disk group during the database installation.
                                •      The disk devices must be owned by the user performing the grid installation.
                                       Check with your system administrator to determine if the disks used by Oracle
                                       ASM are mirrored at the storage level. If so, select External for the redundancy. If
                                       the disks are not mirrored at the storage level, then select Normal for the
                                       redundancy.
                                •      Every Oracle ASM disk is divided into allocation units (AU). An allocation unit is
                                       the fundamental unit of allocation within a disk group. You can select the AU Size
                                       value from 1, 2, 4, 8, 16, 32 or 64 MB, depending on the specific disk group
                                       compatibility level. The default value is 4 MB for flex disk group and 1 MB for all
                                       other disk group types. On engineered systems, the default value is 4 MB.



ASM Disk Group Options for Interactive and Noninteractive Installation
                      You can select new disk groups during interactive installations, but you must use existing disk
                      groups for noninteractive installations.


                      Select from the following choices to store either database or recovery files in an existing Oracle
                      ASM disk group, depending on installation method:
                      •     Installation method that runs Database Configuration Assistant in an interactive mode
                            (either during installation or after installation)
                            –       Select new Disk Group
                            –       Select existing Disk Group
                      •     Installation method that runs Database Configuration Assistant in a noninteractive mode
                            (either during installation or after installation)
                            Select an existing Disk Group only. You cannot create a disk group during noninteractive
                            installations. You can add disk devices to an existing disk group if it has insufficient free
                            space.




Database Installation Guide
E96293-13                                                                                                      November 12, 2025
Copyright © 2015, 2025, Oracle and/or its affiliates.                                                              Page 11 of 23
                                                                                                                    Chapter 6
                                                                    Oracle Automatic Storage Management Storage Configuration



                                Note
                                The Oracle ASM instance that manages the existing disk group can be running in a
                                different Oracle home directory.



                      Step 1: Enabling Disk Automounting
                      Before you can configure partitions or logical drives on Windows, you must enable disk
                      automounting. Enable disk automounting when using:
                      •     Disk partitions on both single-instance and Oracle RAC installations
                      •     Cluster file system for Oracle RAC
                      •     Oracle Clusterware
                      •     Raw partitions for a single-node database installation
                      •     Primary or logical partitions for Oracle Automatic Storage Management
                      To enable automounting:
                      1.    Enter the following commands at a command prompt:
                            DRIVE_LETTER:\> diskpart
                            DISKPART> automount enable
                            DISKPART> exit
                      2.    Restart your computer.

                      Step 2: Creating the Disk Partitions
                      To create disk partitions, use the disk administration tools provided by the operating system or
                      third party vendors. The following administration tools are provided by the operating system:
                      •     The graphical user interface Disk Management snap-in to manage disks.
                            To access this tool, type diskmgmt.msc at the command prompt. (Optional) From the Start
                            menu, select All Programs, then Administrative Tools, then Computer Management.
                            Then select the Disk Management node in the Storage tree.
                            Create primary partitions and logical drives in the extended partitions by selecting the New
                            Simple Volume option. To create a raw device, assign a drive letter and remove the letter
                            after the partition is created. You must select Do not format this partition to specify a raw
                            partition. Do not use spanned volumes or striped volumes. These options convert the
                            volume to a dynamic disk. Oracle Automatic Storage Management does not support
                            dynamic disks.
                            For other Windows, create primary partitions by selecting the New Partition option. Create
                            the logical drives by selecting the New Logical Drive option.
                      •     The command-line tool diskpart.exe, which lets you create primary partitions, extended
                            partitions, and logical drives.
                            To access this tool, enter diskpart.exe at the command prompt. The syntax for using
                            diskpart.exe for the procedures in this section is as follows:
                            DRIVE_LETTER:\> diskpart
                            DISKPART> select disk diskn
                            DISKPART> create partition primary | extended | logical size=sizen
                            DISKPART>

                            where:

Database Installation Guide
E96293-13                                                                                                  November 12, 2025
Copyright © 2015, 2025, Oracle and/or its affiliates.                                                          Page 12 of 23
                                                                                                                     Chapter 6
                                                                     Oracle Automatic Storage Management Storage Configuration


                            –    diskpart.exe is the command-line tool for managing disks.
                            –    diskn is the disk number where the partitions are created.
                            –    sizen is the size of the partition, for example 500 represents 500 MB.


                                See Also
                                The online help or documentation for the administration tool that you are using



                      You can enter the diskpart.exe commands directly at the command line. Alternatively, you
                      can enter the commands in a text file, and then run diskpart /s using this file as a script.

                      You cannot create more than four primary disk partitions per disk. If you need more, you can
                      get around this limitation by creating three primary partitions and then the fourth as an
                      extended partition with as many logical partitions.
                      For example, to create the disk partitions on Disk 5 and assign them each a size:
                      DISKPART> select disk 5
                      DISKPART> create partition primary size=500
                      DISKPART> ...
                      DISKPART> create partition extended
                      DISKPART> create partition logical size=800
                      DISKPART> ...
                      DISKPART> create partition logical size=500


Configuring Disks Manually for Oracle Automatic Storage Management
                      To use Oracle Automatic Storage Management with direct attached storage (DAS) or storage
                      area network (SAN), the disks must be stamped with a header.
                      If you install Oracle Restart in an interactive mode, Oracle Universal Installer configures the
                      headers of the disk during the installation process. However, if you intend to install Oracle
                      Restart in a response file mode, then you must manually configure the disks before installation
                      by using either asmtoolg (GUI version) or asmtool (command-line version). You can also use
                      these tools to reconfigure the disks after installation. The asmtoolg and asmtool utilities work
                      only on partitioned disks: you cannot use Oracle Automatic Storage Management on
                      unpartitioned disks.
                      The asmtoolg and asmtool tools associate meaningful, persistent names with disks to facilitate
                      using those disks with Oracle Automatic Storage Management. Oracle Automatic Storage
                      Management uses disk strings to more easily operate on groups of disks at once, so the
                      names that asmtoolg or asmtool creates make this easier than using Windows drive letters.

                      All disk names created by asmtoolg or asmtool begin with the prefix ORCLDISK followed by a
                      user-defined prefix (the default is DATA) and a disk number for identification purposes.

                      Using the asmtoolg Tool (Graphical User Interface)
                      The asmtoolg tool is a graphical interface for creating device names. Use asmtoolg to add,
                      change, delete, and examine the devices available for use in Oracle Automatic Storage
                      Management.
                      To add or change disk stamps:
                      1.    In the installation media labeled Oracle Grid Infrastructure 19c, from the media root, go to
                            asmtool directory and double-click asmtoolg.exe.


Database Installation Guide
E96293-13                                                                                                   November 12, 2025
Copyright © 2015, 2025, Oracle and/or its affiliates.                                                           Page 13 of 23
                                                                                                                     Chapter 6
                                                                     Oracle Automatic Storage Management Storage Configuration


                            If Oracle Database is installed, go to ORACLE_HOME\bin and double-click asmtoolg.exe.
                            If User Account Control is enabled, then create a shortcut for the command prompt window
                            on your desktop. An icon for that shortcut appears on the desktop. Right click the icon for
                            the newly created shortcut, and specify "Run as administrator." When the command
                            window opens, go to ORACLE_HOME\bin, and then type asmtoolg.
                      2.    Select the Add or change label option, then click Next.
                            The asmtoolg tool shows the devices available on the system. Unrecognized disks are
                            labeled as "Candidate device", stamped Oracle Automatic Storage Management disks as
                            "Stamped ASM disk", and unstamped Oracle Automatic Storage Management disks as
                            "Unstamped ASM disks." The tool also shows disks that are recognized by Windows as a
                            file system (such as NTFS). These are not available for use as disks and cannot be
                            selected. In addition, Microsoft Dynamic disks are not available for use as Oracle
                            Automatic Storage Management disks.
                      3.    In the Stamp Disks window, select the disks to stamp.
                            Oracle Automatic Storage Management can generate unique stamps for all of the devices
                            selected for a given prefix. The stamps are generated by concatenating a number with the
                            prefix specified. For example, if the prefix is DATA, then the first Oracle Automatic Storage
                            Management link name is ORCLDISKDATA0.
                            You can also specify the stamps of individual devices.
                      4.    (Optional) Select a disk to edit the individual stamp (Oracle Automatic Storage
                            Management link name).
                      5.    Click Next.
                      6.    Click Finish.
                      To delete disk stamps:
                      1.    Select the Delete labels option, then click Next.
                            The delete option is only available if disks exist with stamps. The delete window shows all
                            stamped Oracle Automatic Storage Management disks.
                      2.    In the Delete Stamps window, select the disks to unstamp.
                      3.    Click Next.
                      4.    Click Finish.
                      Example 6-1          Using the asmtool Utility (Command Line)
                      The asmtool utility is a command-line interface for stamping disks. If User Account Control is
                      enabled, then you can create a shortcut for the command prompt window on your desktop. An
                      icon for that shortcut appears on the desktop. Right-click the icon for the newly created
                      shortcut, and select "Run as administrator." Then start asmtool.

                      It has the following options:




Database Installation Guide
E96293-13                                                                                                   November 12, 2025
Copyright © 2015, 2025, Oracle and/or its affiliates.                                                           Page 14 of 23
                                                                                                                                Chapter 6
                                                                   About Upgrading Existing Oracle Automatic Storage Management Instances




                       Option                           Description
                       -add                             Adds or changes stamps. You must specify the hard disk, partition, and new
                                                        stamp name. If the disk is a raw device or has an existing Oracle Automatic
                                                        Storage Management stamp, then you must specify the -force option. Also
                                                        sets Oracle Automatic Storage Management instances to rescan the available
                                                        disks.
                                                        Example:

                                                        asmtool -add [-force]
                                                        \Device\Harddisk1\Partition1 ORCLDISKASM0
                                                        \Device\Harddisk2\Partition1 ORCLDISKASM2...

                       -addprefix                       Adds or changes stamps using a common prefix to generate stamps
                                                        automatically. The stamps are generated by adding a number with the prefix
                                                        specified. If the disk is a raw device or has an existing Oracle Automatic
                                                        Storage Management stamp, then you must specify the -force option. Also
                                                        sets Oracle Automatic Storage Management instances to rescan the available
                                                        disks.
                                                        Example:

                                                        asmtool -addprefix ORCLDISKASM [-force]
                                                        \Device\Harddisk1\Partition1
                                                        \Device\Harddisk2\Partition1...

                       -list                            Lists available disks. The stamp, windows device name, and disk size in
                                                        megabytes are shown. Some disks may be file systems, and cannot be
                                                        stamped. If the disk is a raw device or has an existing Oracle Automatic
                                                        Storage Management stamp, then you must specify the -force option.
                                                        Example:

                                                        asmtool -list [-force]

                       -delete                          Removes existing stamps from disks. Also sets Oracle Automatic Storage
                                                        Management instances to rescan the available disks.
                                                        Example:

                                                        asmtool -delete ORCLDISKASM0 ORCLDISKASM1...



About Upgrading Existing Oracle Automatic Storage
Management Instances
                      Oracle Automatic Storage Management (Oracle ASM) upgrades are carried out during an
                      Oracle Grid Infrastructure upgrade.
                      If you are upgrading from Oracle ASM 11g Release 2 (11.2.0.4) or later, then Oracle ASM is
                      always upgraded with Oracle Grid Infrastructure as part of the upgrade, and Oracle Automatic
                      Storage Management Configuration Assistant (Oracle ASMCA) is started by the root scripts
                      during upgrade. Subsequently, you can use Oracle ASMCA (located in Grid_home/bin) to
                      configure failure groups, Oracle ASM volumes, and Oracle Automatic Storage Management
                      Cluster File System (Oracle ACFS).
                      Oracle ASMCA cannot perform a separate upgrade of Oracle ASM from a prior release to the
                      current release.


Database Installation Guide
E96293-13                                                                                                              November 12, 2025
Copyright © 2015, 2025, Oracle and/or its affiliates.                                                                      Page 15 of 23
                                                                                                                        Chapter 6
                                          Configuring Oracle Automatic Storage Management Disk Groups Manually Using Oracle ASMCA


                      Upgrades of Oracle ASM from releases prior to 11g Release 2 (11.2) are not supported.
                      Related Topics
                      •     Oracle Automatic Storage Management Administrator's Guide
                      •     Oracle Database Upgrade Guide


Configuring Oracle Automatic Storage Management Disk Groups
Manually Using Oracle ASMCA
                      The Oracle Automatic Storage Management Configuration Assistant utility creates a new
                      Oracle Automatic Storage Management instance if there is no Oracle Automatic Storage
                      Management instance currently configured on this computer.
                      After installing Oracle Restart, you can also use Oracle Automatic Storage Management
                      Configuration Assistant to create and configure disk groups, Oracle Automatic Storage
                      Management Dynamic Volume Manager (Oracle ADVM), and Oracle Automatic Storage
                      Management Cluster File System (Oracle ACFS).
                      If you want to create additional disk groups or manually configure Oracle Automatic Storage
                      Management disks, then you can run the Oracle Automatic Storage Management
                      Configuration Assistant as follows:
                      DRIVE_LETTER:\> cd ORACLE_HOME\bin
                      DRIVE_LETTER:\> asmca.bat




                                See Also
                                Oracle Automatic Storage Management Administrator's Guide




About Image-Based Oracle Grid Infrastructure Installation
                      Starting with Oracle Grid Infrastructure 12c Release 2 (12.2), installation and configuration of
                      Oracle Grid Infrastructure software is simplified with image-based installation.
                      To install Oracle Grid Infrastructure, create the new Grid home with the necessary user group
                      permissions, and then extract the image file into the newly-created Grid home, and run the
                      setup wizard to register the Oracle Grid Infrastructure product.
                      Using image-based installation, you can do the following:
                      •     Configure Oracle Grid Infrastructure for a new cluster.
                      •     Configure Oracle Grid Infrastructure for a standalone server (Oracle Restart).
                      •     Upgrade Oracle Grid Infrastructure.
                      •     Setup software only.
                      •     Add or remove nodes from your existing cluster, if the Oracle Grid Infrastructure software is
                            already installed or configured.
                      This installation feature streamlines the installation process and supports automation of large-
                      scale custom deployments. You can also use this installation method for deployment of




Database Installation Guide
E96293-13                                                                                                      November 12, 2025
Copyright © 2015, 2025, Oracle and/or its affiliates.                                                              Page 16 of 23
                                                                                                                            Chapter 6
                                                                                Setup Wizard Installation Options for Creating Images


                      customized images, after you patch the base-release software with the necessary Release
                      Updates (RUs) or Release Update Revisions (RURs).


                                Note
                                You must extract the image software into the directory where you want your Grid home
                                to be located, and then run the %ORACLE_HOME%\setup.exe script to start the Oracle
                                Grid Infrastructure Setup Wizard. Ensure that the Grid home directory path you create
                                is in compliance with the Oracle Optimal Flexible Architecture recommendations.



Setup Wizard Installation Options for Creating Images
                      Before you start the setup wizards for your Oracle Database or Oracle Grid Infrastructure
                      installation, decide if you want to use any of the available image-creation options.
                      In image-based installations, you can start your Oracle Database installation or Oracle Grid
                      Infrastructure installation by running the setup wizard setup.exe. This wizard comes with the
                      following image-creation options:


                                Note
                                setup.exe is the recommended setup wizard for installing both Oracle Database and
                                Oracle Grid Infrastructure.


                      Table 6-3       Image-Creation Options for Setup Wizard

                       Option                           Description
                       -createGoldImage                 Creates a gold image from the current Oracle home.
                       -destinationLocation             Specify the complete path, or location, where the gold image will be
                                                        created.
                       -exclFiles                       Specify the complete paths to the files to be excluded from the newly
                                                        created gold image.
                       —help                            Displays help for all the available options.

                      For example:

                      cd ORACLE_HOME
                      setup.exe -createGoldImage -destinationLocation c:\my_db_images -exclFiles
                      C:\app\oracle\product\19.0.0\dbhome_1\relnotes


                      cd Grid_home
                      setup.exe -createGoldImage -destinationLocation c:\my_grid_images -exclFiles
                      C:\app\oracle\product\19.0.0\dbhome_1\relnotes


                      Where:
                      c:\my_db_images is the file location where the image zip file is created.

                      c:\my_grid_images is the file location where the image zip file is created.


Database Installation Guide
E96293-13                                                                                                        November 12, 2025
Copyright © 2015, 2025, Oracle and/or its affiliates.                                                                Page 17 of 23
                                                                                                                                   Chapter 6
                                               Installing Oracle Grid Infrastructure for a Standalone Server with a New Database Installation


                      C:\app\oracle\product\19.0.0\dbhome_1\relnotes is the file to be excluded from
                      the newly created gold image.


Installing Oracle Grid Infrastructure for a Standalone Server with
a New Database Installation
                      Complete these steps to install Oracle Restart and then create a database that is managed by
                      Oracle Restart.
                      Install Oracle Restart, which installs Oracle Restart and Oracle ASM, and creates one disk
                      group.
                      1.    Log in as the Oracle Restart software owner user (grid).
                      2.    Download the Oracle Grid Infrastructure installation image files, create the Grid home
                            directory, and extract the image files in this Grid home directory.
                            For example:
                            C:\> mkdir \app\oracle\product\19.0.0\grid
                            C:\> icacls grid:oinstall \app\oracle\product\19.0.0\grid
                            C:\> cd \app\oracle\product\19.0.0\grid
                            C:\> unzip -q download_location\grid_home.zip


                                     Note
                                     Ensure that the Grid home directory path you create is in compliance with the
                                     Oracle Optimal Flexible Architecture recommendations. Also, unzip the installation
                                     image files only in this Grid home directory that you created.


                      3.    Run setup.exe to start the Oracle Grid Infrastructure installation wizard.
                            C:> Grid_home\setup.exe


                                     Note
                                     You can use the gridSetup.exe command with the -applyRU and -
                                     applyOneOffs options to install Release Updates (RUs) and one-off patches
                                     during an Oracle Grid Infrastructure installation or upgrade.

                      4.    In the Select Configuration Option screen, select the Configure Oracle Restart option to
                            install and configure Oracle Restart and Oracle ASM. Click Next.
                      5.    During installation, disk paths mounted on Oracle ASM and registered with the string
                            ORCL:* are listed as default database storage candidate disks.
                      6.    Configure Oracle ASM as needed with additional disk groups.
                            •    The default Disk Group Name is DATA. You can enter a new name for the disk group,
                                 or use the default name.
                            •    Any additional disk devices that you create must be owned by the user performing the
                                 grid installation.




Database Installation Guide
E96293-13                                                                                                                November 12, 2025
Copyright © 2015, 2025, Oracle and/or its affiliates.                                                                        Page 18 of 23
                                                                                                                                    Chapter 6
                                                        Installing Oracle Grid Infrastructure for a Standalone Server for an Existing Database


                      7.    Respond to the configuration prompts as needed to configure Oracle Grid Infrastructure.
                            Click Help for information.
                      8.    Provide information to automate root scripts, or run scripts as root when prompted by
                            Oracle Universal Installer.
                            If you configure automation for running root scripts, and a root script fails, then you can fix
                            the problem manually, and click Retry to run the root script again
                      9.    Start the Oracle Database installation, and select Oracle ASM disk groups for Oracle
                            Database files storage. For assistance during installation, click Help on the Oracle
                            Universal Installer page where you need more information.


Installing Oracle Grid Infrastructure for a Standalone Server for
an Existing Database
                      Follow the high-level instructions in this section to install Oracle Grid Infrastructure and
                      configure it for an existing Oracle database.
                      Oracle Restart can manage resources from the same release and releases up to one version
                      lower than Oracle Restart. For this reason, you can install Oracle Restart to provide services
                      only for Oracle Database 19c. However, previous release Oracle Databases can coexist on the
                      same server without being managed by Oracle Restart.
                      To install Oracle Restart for a database that is already installed:
                      1.    On the same host computer as the database, install Oracle Restart, and select Configure
                            Oracle Grid Infrastructure for a Standalone Server (Oracle Restart) as the installation
                            option. See, Installing Oracle Restart with a New Database Installation in Oracle Database
                            Installation Guide.
                            The Oracle Restart components are installed in an Oracle Grid Infrastructure Oracle home
                            (Grid home), which is in a different location from existing Oracle Database homes.
                      2.    If you have an existing Oracle Database, then register it for High Availability with Oracle
                            Restart using the srvctl command:DRIVE_LETTER:\> cd ORACLE_HOME\bin
                            DRIVE_LETTER:\> srvctl add database -db dbname -o oracle_home_path


Installing Oracle Grid Infrastructure for a Standalone Server
Using a Software-Only Installation
                      A software-only installation only installs the Oracle Restart binaries at the specified location.
                      You must complete a few manual configuration steps to enable Oracle Grid Infrastructure after
                      you install the software.


                                Note
                                Oracle recommends that only advanced users perform the software-only installation,
                                because this installation method provides no validation of the installation and this
                                installation option requires manual postinstallation steps to enable the Oracle Restart
                                software.




Database Installation Guide
E96293-13                                                                                                                 November 12, 2025
Copyright © 2015, 2025, Oracle and/or its affiliates.                                                                         Page 19 of 23
                                                                                                                                   Chapter 6
                                             Installing Oracle Grid Infrastructure for a Standalone Server Using a Software-Only Installation


                      •     Installing Software Binaries for Oracle Grid Infrastructure for a Standalone Server
                            Use this procedure to do a software-only installation of Oracle Grid Infrastructure for a
                            standalone server.
                      •     Configuring Software Binaries for Oracle Grid Infrastructure for a Standalone Server
                            Use this procedure to configure and activate a software-only Oracle Restart without Oracle
                            Automatic Storage Management (Oracle ASM).


Installing Software Binaries for Oracle Grid Infrastructure for a Standalone
Server
                      Use this procedure to do a software-only installation of Oracle Grid Infrastructure for a
                      standalone server.
                      1.    Log in to Windows as an Administrator user.
                      2.    Download the Oracle Grid Infrastructure installation image files, create the Grid home
                            directory, and extract the image files in this Grid home directory.
                            For example:

                            C:\> mkdir \app\oracle\product\19.0.0\grid
                            C:\> cd \app\oracle\product\19.0.0\grid
                            C:\> unzip -q download_location\grid.zip

                      3.    Verify that the server meets the installation requirements using the command
                            runcluvfy.bat stage -pre hacfg. Ensure that you have completed all storage and
                            server preinstallation requirements.
                            For Example:

                            C:\> app\oracle\product\19.0.0\grid\runcluvfy.bat

                      4.    Log in as the Oracle Restart software owner user and run setup.exe to start the Oracle
                            Grid Infrastructure installation wizard.
                            C:\> app\oracle\product\19.0.0\grid\setup.exe
                      5.    In the Select Configuration Option screen, select the Set Up Software Only option to
                            perform a software-only installation of Oracle Restart. Click Next.
                      6.    Respond to the prompts as needed to set up Oracle Grid Infrastructure. Click Help for
                            information.


Configuring Software Binaries for Oracle Grid Infrastructure for a
Standalone Server
                      Use this procedure to configure and activate a software-only Oracle Restart without Oracle
                      Automatic Storage Management (Oracle ASM).
                      1.    Log in as a member of the Administrators group and run the roothas.bat script from the
                            Grid_home, using the following syntax:
                            C:\>DRIVE_LETTER:\Grid_home\crs\install\roothas.bat

                            For example, if your Grid home is C:\app\oracle\product\19.0.0\grid, then run
                            the following script:



Database Installation Guide
E96293-13                                                                                                                November 12, 2025
Copyright © 2015, 2025, Oracle and/or its affiliates.                                                                        Page 20 of 23
                                                                                                                       Chapter 6
                                                                    Testing the Oracle Automatic Storage Management Installation

                            C:\>C:\app\oracle\product\19.0.0\grid\crs\install\roothas.bat
                      2.    Change the home directory to the path of the Oracle Restart home as follows:
                            Grid_home\oui\bin, where Grid_home is the path of the Oracle Restart home.
                      3.    Enter the following command:
                            setup.exe -updateNodeList ORACLE_HOME=Grid_home
                            CLUSTER_NODES= CRS=TRUE

                            For example:
                            C:\app\oracle\product\19.0.0\grid> setup.exe -updateNodeList
                            ORACLE_HOME=C:\app\oracle\product\19.0.0\grid
                            CLUSTER_NODES= CRS=TRUE
                      4.    Use the SRVCTL utility along with Network Configuration Assistant and Oracle Automatic
                            Storage Management Configuration Assistant to add the listener, the Oracle Automatic
                            Storage Management instance, and all Oracle Automatic Storage Management disk
                            groups to the Oracle Restart configuration.


                                     See Also
                                     •    Oracle Database Net Services Administrator's Guide
                                     •    Oracle Automatic Storage Management Administrator's Guide
                                     •    Oracle Database Administrator's Guide



Testing the Oracle Automatic Storage Management Installation
                      After installing Oracle Grid Infrastructure for a single instance, use the ASMCMD command-
                      line utility to test the Oracle ASM installation.
                      To test the Oracle Automatic Storage Management installation:
                      1.    Use SQL*Plus to connect to the Oracle Automatic Storage Management instance as the
                            SYS user with SYSASM privilege and start the instance if necessary:
                            DRIVE_LETTER:\>sqlplus /nolog
                            SQL> CONNECT SYS as SYSASM
                            Enter password: SYS_password
                            SQL> STARTUP
                      2.    Enter the following command to view the existing disk groups, their redundancy level, and
                            the amount of free disk space in each one:
                            SQL> SELECT NAME,TYPE,TOTAL_MB,FREE_MB FROM V$ASM_DISKGROUP;



                                See Also
                                Oracle Automatic Storage Management Administrator's Guide




Database Installation Guide
E96293-13                                                                                                    November 12, 2025
Copyright © 2015, 2025, Oracle and/or its affiliates.                                                            Page 21 of 23
                                                                                                                                      Chapter 6
                                                        Modifying Oracle Grid Infrastructure for a Standalone Server Binaries After Installation




Modifying Oracle Grid Infrastructure for a Standalone Server
Binaries After Installation
                      After installation, you must first stop the Oracle Restart stack to modify the software installed in
                      your Grid home.
                      For example, to apply a one-off patch or modify any of the DLLs used by Oracle Restart or
                      Oracle ASM, you must follow these steps to stop and restart the Oracle Restart stack.


                                Caution
                                Before relinking executables, you must shut down all executables that run in the
                                Oracle home directory that you are relinking. In addition, shut down applications linked
                                with Oracle shared libraries.



                      Prepare the Oracle Restart home for modification using the following procedure:
                      1.    Log in using a member of the Administrators group and go to the directory Grid_home\bin,
                            where Grid_home is the path to the Oracle Restart home.
                      2.    Shut down the Oracle Restart stack using the following command:
                             DRIVE_LETTER:\Grid_home\bin> crsctl stop has -f

                            Alternatively, you can use the roothas.bat script to stop Oracle Restart, as shown in the
                            following example:
                             DRIVE_LETTER:\Grid_home\crs\install> roothas.bat -unlock



                                     Note
                                     Starting with Oracle Database 12c Release 1 (12.1.0.2), the roothas.bat script
                                     replaces the roothas.pl script in the Oracle Grid Infrastructure home.



                            The roothas.bat script stops Oracle Restart and then verifies that it is stopped.
                      3.    After the Oracle Restart stack is completely shut down, perform the changes to the
                            software installed in the Grid home.
                            Apply the patches using opatch apply.
                      4.    Lock the Grid home:
                                DRIVE_LETTER:\Grid_home\crs\install>roothas.bat -lock
                      5.    Use the following command to restart the Oracle Restart stack:
                                DRIVE_LETTER:\Grid_home\bin> crsctl start has
                      Example 6-2          Enabling Oracle ACFS on Oracle Restart Configurations
                      To use Oracle ACFS on Oracle Restart configurations, you must first enable Administrator
                      access for Oracle ACFS using the following command:




Database Installation Guide
E96293-13                                                                                                                   November 12, 2025
Copyright © 2015, 2025, Oracle and/or its affiliates.                                                                           Page 22 of 23
                                                                                                                                      Chapter 6
                                                        Modifying Oracle Grid Infrastructure for a Standalone Server Binaries After Installation

                      DRIVE_LETTER:\cd Grid_home\crs\install
                      DRIVE_LETTER:\Grid_home\crs\install>roothas.bat -lockacfs




                                See Also
                                Oracle OPatch User's Guide for Windows and UNIX




Database Installation Guide
E96293-13                                                                                                                   November 12, 2025
Copyright © 2015, 2025, Oracle and/or its affiliates.                                                                           Page 23 of 23
7
Installing Oracle Database
                      Oracle Database and Oracle Grid Infrastructure installation software is available as image-
                      based zip files in multiple media, and can be installed using several options.
                      •     Preinstallation Considerations for Installing Oracle Database
                            The Oracle Database software is available on the installation media or you can download it
                            from the Oracle Technology Network (OTN) website.
                      •     Reviewing Component-Specific Installation Guidelines
                            Review the following guidelines before starting Oracle Universal Installer:
                      •     Using an Oracle Automatic Storage Management Disk Group
                            Learn how to identify disk groups and determine the available free disk space.
                      •     About Character Set Selection During Installation
                            Before you create the database, decide the character set that you want to use.
                      •     Accessing the Installation Software
                            The Oracle software is available on the installation media or you can download it from the
                            Oracle Technology Network website, or Oracle Software Delivery Cloud website.
                      •     Installing and Using Oracle Components in Different Languages
                            Learn about installing and using Oracle components in different languages.
                      •     Running Oracle Universal Installer in Different Languages
                            Describes how to run Oracle Universal Installer in other languages.
                      •     About Image-Based Oracle Database Installation
                            Starting with Oracle Database 18c, installation and configuration of Oracle Database
                            software is simplified with image-based installation.
                      •     Setup Wizard Installation Options for Creating Images
                            Before you start the setup wizards for your Oracle Database or Oracle Grid Infrastructure
                            installation, decide if you want to use any of the available image-creation options.
                      •     Installing the Oracle Database Software
                            This topic explains how to run Oracle Universal Installer to perform most database
                            installations.
                      •     Installing Standard Edition High Availability
                            Learn how to Install high availability on Oracle Database Standard Edition 2.
                      •     Cloning an Oracle Home
                            Follow these steps to clone an Oracle home.


Preinstallation Considerations for Installing Oracle Database
                      The Oracle Database software is available on the installation media or you can download it
                      from the Oracle Technology Network (OTN) website.
                      In most cases, Oracle Universal Installer provides a graphical user interface (GUI) to install the
                      software. However, you can also use Oracle Universal Installer without the GUI by supplying a
                      response file with silent or response file mode.




Database Installation Guide
E96293-13                                                                                                 November 12, 2025
Copyright © 2015, 2025, Oracle and/or its affiliates.                                                          Page 1 of 26
                                                                                                                          Chapter 7
                                                                       Preinstallation Considerations for Installing Oracle Database



                                Note
                                Windows requires Administrator privileges at the command prompt.




                      •     Installation Consideration on Windows
                            On Windows, open command prompts with the Administrator privileges.
                      •     Performing Multiple Oracle Database Installations
                            To perform multiple installations of Oracle Database, use either of the following methods to
                            install Oracle Database:
                      •     Installing on Systems That Already Have Oracle Components
                            Perform the following steps when other components exist on your computer:
                      •     Installing with Minimum Memory Requirements
                            Installations of Oracle Database on computers with RAM and virtual memory lesser than
                            the minimum required have the following limitations:


Installation Consideration on Windows
                      On Windows, open command prompts with the Administrator privileges.


Performing Multiple Oracle Database Installations
                      To perform multiple installations of Oracle Database, use either of the following methods to
                      install Oracle Database:
                      •     Response files: At each node, you run Oracle Universal Installer from the command line
                            using silent or response file mode and you supply a response file to provide information
                            Oracle Universal Installer needs. The response file is a text file containing the settings you
                            normally enter in the Oracle Universal Installer GUI dialog boxes.
                      •     Cloning the Oracle home of an existing Oracle Database installation: With this
                            method, install one instance of Oracle Database, and then clone its Oracle home for each
                            additional installation.


Installing on Systems That Already Have Oracle Components
                      Perform the following steps when other components exist on your computer:
                      1.    Log on as a member of the Administrators group for the computer on which you want to
                            install Oracle components.
                            If you are installing on a Primary Domain Controller (PDC) or a Backup Domain Controller
                            (BDC), log on as a member of the Domain Administrators group.
                      2.    Delete the ORACLE_HOME environment variable if it exists. See the Microsoft online help for
                            more information about deleting environment variables.


                                     Note
                                     The ORACLE_HOME environment variable is automatically set in the registry.
                                     Manually setting this variable prevents installation.



Database Installation Guide
E96293-13                                                                                                       November 12, 2025
Copyright © 2015, 2025, Oracle and/or its affiliates.                                                                Page 2 of 26
                                                                                                                      Chapter 7
                                                                           Reviewing Component-Specific Installation Guidelines


                      3.    Back up any databases you must upgrade.



                                See Also
                                Oracle Real Application Clusters Installation Guide for Linux and UNIX




Installing with Minimum Memory Requirements
                      Installations of Oracle Database on computers with RAM and virtual memory lesser than the
                      minimum required have the following limitations:
                      •     Computers cannot run Oracle Database Upgrade Assistant, Oracle Database
                            Configuration Assistant, or Oracle Net Services Configuration Assistant during an Oracle
                            Universal Installer installation session.
                      •     Depending on how many applications run on the computer, you must further increase the
                            paging file size or reduce the size of the System Global Area (SGA) if you run out of virtual
                            memory. If temporary files and the paging file are both stored on the same physical drive,
                            the space requirements for one can limit the size of the other. If your system has limited
                            free space, first install the Oracle Database software. After the installation is finished,
                            create a database with Oracle Database Configuration Assistant.


                                Note
                                Do not install the database on computer systems that barely meet the minimum
                                memory and virtual memory requirements of 1 GB.



                      You can install only the database software by selecting the Install Database Software only
                      option provided on the Select Installation Option screen.
                      After installation, run the appropriate configuration assistant for your needs:
                      •     To create a new database, run Oracle Database Configuration Assistant. From the Start
                            menu, select All Programs, then Oracle - HOMENAME, then Configuration and
                            Migration Tools, then Database Configuration Assistant.
                      •     To upgrade an existing database, run Oracle Database Upgrade Assistant. From the Start
                            menu, select All Programs, then Oracle - HOMENAME, then Configuration and
                            Migration Tools, then Database Upgrade Assistant.


Reviewing Component-Specific Installation Guidelines
                      Review the following guidelines before starting Oracle Universal Installer:


                      •     Oracle Universal Installer
                            Do not use Oracle Universal Installer from an earlier Oracle release to install components
                            from this release.
                      •     Oracle Automatic Storage Management




Database Installation Guide
E96293-13                                                                                                   November 12, 2025
Copyright © 2015, 2025, Oracle and/or its affiliates.                                                            Page 3 of 26
                                                                                                                    Chapter 7
                                                                      Using an Oracle Automatic Storage Management Disk Group


                            In previous releases, Oracle Automatic Storage Management (Oracle ASM) was installed
                            as part of the Oracle Database installation. With Oracle Database 11g Release 2 (11.2),
                            Oracle Automatic Storage Management is part of an Oracle Grid Infrastructure installation,
                            either for a cluster, or for a standalone server.
                            If you want to upgrade an existing Oracle Automatic Storage Management installation,
                            then you must upgrade Oracle Automatic Storage Management by running an Oracle Grid
                            Infrastructure upgrade. If you do not have Oracle Automatic Storage Management installed
                            and you want to use Oracle Automatic Storage Management as your storage option, then
                            you must complete an Oracle Grid Infrastructure for a standalone server installation before
                            you start your Oracle Database installation.
                      •     Installations on a cluster
                            If Oracle Clusterware or Oracle RAC is installed on the system, then Oracle Universal
                            Installer displays the Grid Installation Options page. You must select Single instance
                            database installation, unless you want to install Oracle RAC. The other options on the
                            page are Oracle Real Application Clusters database installation and Oracle RAC One
                            Node database installation.


                                     See Also
                                     Oracle Real Application Clusters Installation Guide for Linux and UNIX



Using an Oracle Automatic Storage Management Disk Group
                      Learn how to identify disk groups and determine the available free disk space.
                      You can store either database or recovery files in an existing Oracle Automatic Storage
                      Management disk group that you created during the Oracle Grid Infrastructure for a standalone
                      server installation.


                                Note
                                The Oracle Automatic Storage Management instance that manages the existing disk
                                group runs in a different Oracle home directory.



                      1.    In the Services Control Panel, ensure that the OracleASMService+ASM service has started.
                      2.    Open command prompt and temporarily set the ORACLE_SID environment variable to
                            specify the appropriate value for the Oracle Automatic Storage Management instance.
                            For example, if the Oracle Automatic Storage Management SID, which is named +ASM, is
                            located in the asm directory, then enter the following setting:
                            DRIVE_LETTER:\>set ORACLE_SID=+ASM
                      3.    Connect to the Oracle Automatic Storage Management instance as the SYS user with the
                            SYSASM privilege and start the instance if necessary:
                            DRIVE_LETTER:\>sqlplus /nolog
                            SQL> CONNECT SYS as SYSASM
                            Enter password: SYS_password
                            SQL> STARTUP




Database Installation Guide
E96293-13                                                                                                  November 12, 2025
Copyright © 2015, 2025, Oracle and/or its affiliates.                                                           Page 4 of 26
                                                                                                                         Chapter 7
                                                                                 About Character Set Selection During Installation


                      4.    Enter the following command to view the existing disk groups, their redundancy level, and
                            the amount of free disk space in each one:
                            SQL> SELECT NAME,TYPE,TOTAL_MB,FREE_MB FROM V$ASM_DISKGROUP;
                      5.    From the output, identify a disk group with the appropriate redundancy level and note the
                            free space that it contains.
                      6.    If necessary, install, or identify the additional disk devices required to meet the storage
                            requirements.


                                     Note
                                     If you are adding devices to an existing disk group, then Oracle recommends that
                                     you use devices that have the same size and performance characteristics as the
                                     existing devices in that disk group.



About Character Set Selection During Installation
                      Before you create the database, decide the character set that you want to use.
                      After a database is created, changing its character set is usually very expensive in terms of
                      time and resources. Such operations may require converting all character data by exporting
                      the whole database and importing it back. Therefore, it is important that you carefully select the
                      database character set at installation time.
                      Oracle Database uses character sets for the following:
                      •     Data stored in SQL character data types (CHAR, VARCHAR2, CLOB, and LONG).
                      •     Identifiers such as table names, column names, and PL/SQL variables.
                      •     Stored SQL and PL/SQL source code, including text literals embedded in this code.
                      Starting with Oracle Database 12c Release 2 (12.2), the default database character set of a
                      database created from the General Purpose/Transaction Processing or the Data Warehousing
                      template is Unicode AL32UTF8.

                      Unicode is the universal character set that supports most of the currently spoken languages of
                      the world. It also supports many historical scripts (alphabets). Unicode is the native encoding
                      of many technologies, including Java, XML, XHTML, ECMAScript, and LDAP. Unicode is
                      ideally suited for databases supporting the Internet and the global economy.
                      Because AL32UTF8 is a multibyte character set, database operations on character data may be
                      slightly slower when compared to single-byte database character sets, such as WE8ISO8859P1
                      or WE8MSWIN1252. Storage space requirements for text in most languages that use characters
                      outside of the ASCII repertoire are higher in AL32UTF8 compared to legacy character sets
                      supporting the language. English data may require more space only if stored in CLOB (character
                      large object) columns. Storage for non-character data types, such as NUMBER or DATE, does not
                      depend on a character set. The universality and flexibility of Unicode usually outweighs these
                      additional costs.
                      Consider legacy character sets only when the database needs to support a single group of
                      languages and the use of a legacy character set is critical for fulfilling compatibility, storage, or
                      performance requirements. The database character set to be selected in this case is the
                      character set of most clients connecting to this database.




Database Installation Guide
E96293-13                                                                                                     November 12, 2025
Copyright © 2015, 2025, Oracle and/or its affiliates.                                                              Page 5 of 26
                                                                                                                       Chapter 7
                                                                                             Accessing the Installation Software


                      The database character set of a multitenant container database (CDB) determines which
                      databases can be plugged in later. Ensure that the character set you choose for the CDB is
                      compatible with the database character sets of the databases to be plugged into this CDB. If
                      you use Unicode AL32UTF8 as your CDB character set, then you can plug in a pluggable
                      database (PDB) in any database character set supported by Oracle Database (with the
                      exception of EBCDIC-based character sets).



                                See Also
                                Oracle Database Globalization Support Guide for more information about choosing a
                                database character set for a multitenant container database (CDB)



Accessing the Installation Software
                      The Oracle software is available on the installation media or you can download it from the
                      Oracle Technology Network website, or Oracle Software Delivery Cloud website.
                      To install the software from the hard disk, you must either download it and unpack it, or copy it
                      from the installation media, if you have it.
                      You can access and install Oracle Database by using one of the following methods:
                      •     Downloading Oracle Software
                            You can download the trial version of the installation files from the Oracle Technology
                            Network (OTN) or the Oracle Software Delivery Cloud portal and extract them on your hard
                            disk.
                      •     Installing on Remote Computers Through Remote Access Software
                            If you want to install and run Oracle Database on a remote computer (that is, the remote
                            computer has the hard drive and runs Oracle Database components), but you do not have
                            physical access to the computer, you still can perform the installation on the remote
                            computer if it is running remote access software such as VNC or Symantec pcAnywhere.
                      •     Installing from a Remote DVD Drive
                            If the computer where you want to install Oracle Database does not have a DVD drive, you
                            can perform the installation from a remote DVD drive.
                      •     Copying the Oracle Database Software to a Hard Disk
                            To copy the contents of the installation media to a hard disk:


Downloading Oracle Software
                      You can download the trial version of the installation files from the Oracle Technology Network
                      (OTN) or the Oracle Software Delivery Cloud portal and extract them on your hard disk.
                      Select the method that you want to use to download the software. Ensure that you review and
                      understand the terms of the license. Most downloads include the development license.
                      •     Downloading the Installation Archive Files from Oracle Technology Network
                            To download the installation archive files from Oracle Technology Network:
                      •     Downloading the Software from Oracle Software Delivery Cloud
                      •     Extracting the Installation File
                            Use this procedure to extract the installation archive file:




Database Installation Guide
E96293-13                                                                                                   November 12, 2025
Copyright © 2015, 2025, Oracle and/or its affiliates.                                                            Page 6 of 26
                                                                                                                         Chapter 7
                                                                                               Accessing the Installation Software



Downloading the Installation Archive Files from Oracle Technology Network
                      To download the installation archive files from Oracle Technology Network:
                      1.    Use any browser to access the software download page from OTN.
                      2.    Navigate to the download page for the product to install.
                      3.    On the download page, identify the required disk space by adding the file sizes for each
                            required file.
                            The file sizes are listed next to the file names.
                      4.    Select a file system with enough free space to store and expand the archive files.
                            In most cases, the available disk space must be at least twice the size of all of the archive
                            files.
                      5.    On the file system that you selected in step 4, create a parent directory for each product,
                            for example OraDB19c, to hold the installation directories.
                      6.    Download all of the installation archive files to the directory that you created in step 5.
                      7.    Verify that the files you downloaded are the same size as the corresponding files on Oracle
                            Technology Network. Also verify the checksums are the same as noted on OTN.
                      8.    Extract the files in each directory that you just created.

Downloading the Software from Oracle Software Delivery Cloud
                      You can download the software from Oracle Software Delivery Cloud as Media Packs. A Media
                      Pack is an electronic version of the software that is also available to Oracle customers on CD-
                      ROM or DVD. To download the Media Pack:
                      1.    Use any browser to access the Oracle Software Delivery Cloud website:
                            http://edelivery.oracle.com/
                      2.    Complete the Export Validation process by entering information (name, company, e-mail
                            address, and country) in the online form.
                      3.    In the Media Pack Search page, specify the Product Pack and Platform to identify the
                            Media Pack you want to download. If you do not know the name of the Product Pack, you
                            can search for it using the License List.
                      4.    Optionally, select the relevant product to download from the Results list.
                      5.    In the search results page, click Readme to download and review the Readme file for
                            download instructions and product information.
                      6.    After you review the Readme, choose the appropriate Media Pack from the search results
                            to download the individual zip files. Follow the Download Notes instructions in this page.
                            Once you download and extract the contents of the required zip files, proceed with the
                            installation of the software.


                                     Note
                                     Print the page with the list of downloadable files. It contains a list of part numbers
                                     and their corresponding descriptions to refer during the installation process.




Database Installation Guide
E96293-13                                                                                                     November 12, 2025
Copyright © 2015, 2025, Oracle and/or its affiliates.                                                              Page 7 of 26
                                                                                                                          Chapter 7
                                                                                                Accessing the Installation Software


                      7.    After you download the files, click View Digest to verify that the MD5 or SHA-1 checksum
                            matches with what is listed in the media download page.



                                See Also

                                •    My Oracle Support note 549617.1 for information on how to verify the integrity of a
                                     software download at:
                                     https://support.oracle.com/CSP/main/article?
                                     cmd=show&type=NOT&id=549617.1
                                •    Frequently Asked Questions section on the Oracle Software Delivery Cloud
                                     website for more information about Media Packs



Extracting the Installation File
                      Use this procedure to extract the installation archive file:

                      1.    If necessary, change to the directory that contains the downloaded installation archive file.
                      2.    Extract the zip file contents to a desired destination directory.


Installing on Remote Computers Through Remote Access Software
                      If you want to install and run Oracle Database on a remote computer (that is, the remote
                      computer has the hard drive and runs Oracle Database components), but you do not have
                      physical access to the computer, you still can perform the installation on the remote computer if
                      it is running remote access software such as VNC or Symantec pcAnywhere.
                      You also need the remote access software running on your local computer.
                      You can install Oracle Database on the remote computer in one of two ways:
                      •     If you have copied the contents of the Oracle Database installation software to a hard
                            drive, you can install the software from the hard drive.
                      •     You can insert the Oracle Database DVD into a drive on your local computer, and install
                            the software from the DVD.
                      •     Installing on Remote Computers from a Hard Drive
                            If you have copied the contents of the Oracle Database installation software to a hard
                            drive, you can install the software from the hard drive.
                      •     Installing on Remote Computers from a Remote DVD Drive
                            You can insert the DVD into a drive on your local computer, and install from the DVD.

Installing on Remote Computers from a Hard Drive
                      If you have copied the contents of the Oracle Database installation software to a hard drive,
                      you can install the software from the hard drive.
                      To install the software on a remote computer from a hard drive:
                      1.    Ensure that the remote access software is installed and running on the remote and local
                            computers.



Database Installation Guide
E96293-13                                                                                                      November 12, 2025
Copyright © 2015, 2025, Oracle and/or its affiliates.                                                               Page 8 of 26
                                                                                                                    Chapter 7
                                                                                          Accessing the Installation Software


                      2.    Share the hard drive that contains the Oracle Database installation software.
                      3.    On the remote computer, map a drive letter to the shared hard drive. You use the remote
                            access software to do this on the remote computer.
                      4.    Through the remote access software, run Oracle Universal Installer on the remote
                            computer. You access Oracle Universal Installer from the shared hard drive.

Installing on Remote Computers from a Remote DVD Drive
                      You can insert the DVD into a drive on your local computer, and install from the DVD.
                      To install the software on a remote computer from a remote DVD drive:
                      1.    Ensure that the remote access software is installed and running on the remote and local
                            computers.
                      2.    On the local computer, share the DVD drive.
                            On the remote computer, map a drive letter to the shared DVD drive. You use the remote
                            access software to do this on the remote computer.
                      3.    Through the remote access software, run Oracle Universal Installer on the remote
                            computer. You can access Oracle Universal Installer from the shared DVD drive.


Installing from a Remote DVD Drive
                      If the computer where you want to install Oracle Database does not have a DVD drive, you can
                      perform the installation from a remote DVD drive.


                      •     Step 1: On the Remote Computer, Share the DVD Drive
                            The remote DVD drive must allow shared access.
                      •     Step 2: On the Local Computer, Map the DVD Drive
                            Perform these steps on the local computer to map a remote DVD drive and to run Oracle
                            Universal Installer from the mapped drive.

Step 1: On the Remote Computer, Share the DVD Drive
                      The remote DVD drive must allow shared access.
                      To set this up, perform these steps on the remote computer that has the DVD drive:
                      1.    Log in to the remote computer as an Administrator user.
                      2.    Start Windows Explorer.
                      3.    Right-click the DVD drive letter and select Sharing (or Sharing and Security).
                      4.    Click the Sharing tab and do the following:
                            a.   Select Share this folder.
                            b.   In Share name, give it a share name such as dvd. You use this name when you map
                                 the DVD drive on the local computer in step 1.d of "Step 2: On the Local Computer,
                                 Map the DVD Drive".
                            c.   Click Permissions. You need at least read permission for the user who accesses the
                                 drive to install Oracle Database.
                            d.   Click OK when you are finished.



Database Installation Guide
E96293-13                                                                                                November 12, 2025
Copyright © 2015, 2025, Oracle and/or its affiliates.                                                         Page 9 of 26
                                                                                                                        Chapter 7
                                                                    Installing and Using Oracle Components in Different Languages


                      5.    Insert the Oracle Database installation media into the DVD drive.

Step 2: On the Local Computer, Map the DVD Drive
                      Perform these steps on the local computer to map a remote DVD drive and to run Oracle
                      Universal Installer from the mapped drive.
                      1.    Map the remote DVD drive.
                            a.   Start Windows Explorer on the local computer.
                            b.   From the Tools menu, select Map Network Drive to display the Map Network Drive
                                 dialog box.
                            c.   Select a drive letter to use for the remote DVD drive.
                            d.   In Folder, enter the location of the remote DVD drive using the following format:
                                 \\remote_hostname\share_name

                                 where:
                                 •    remote_hostname is the name of the remote computer with the DVD drive.
                                 •    share_name is the share name that you entered in step 4 of the previous
                                      procedure. For example:
                                      \\computer2\dvd
                            e.   If you must connect to the remote computer as a different user, click different user
                                 name, and enter the user name.
                            f.   Click Finish.
                      2.    Run Oracle Universal Installer from the mapped DVD drive.


Copying the Oracle Database Software to a Hard Disk
                      To copy the contents of the installation media to a hard disk:
                      1.    Create a directory on your hard drive. For example:
                            C:\> mkdir \install
                            C:\> mkdir \install\database
                      2.    Copy the contents of the installation media to the directory that you just created.


Installing and Using Oracle Components in Different Languages
                      Learn about installing and using Oracle components in different languages.
                      •     Configuring Oracle Components to Run in Different Languages
                            You can specify the language and the territory, or locale, in which you want to use the
                            Oracle components.
                      •     Determining the Operating System Locale
                            The locale setting of your operating system session determines the language of the user
                            interface and the globalization behavior for components such as Oracle Universal Installer,
                            Oracle Net Configuration Assistant, and Oracle Database Configuration Assistant.
                      •     Configuring Locale and Character Sets Using the NLS_LANG Environment Variable
                            The NLS_LANG environment variable determines the language of the user interface and the
                            globalization behavior for components such as SQL*Plus, exp, and imp.


Database Installation Guide
E96293-13                                                                                                     November 12, 2025
Copyright © 2015, 2025, Oracle and/or its affiliates.                                                             Page 10 of 26
                                                                                                                       Chapter 7
                                                                   Installing and Using Oracle Components in Different Languages


                      •     NLS_LANG Settings in Console Mode and Batch Mode
                            Before you can use Oracle utilities such as SQL*Plus, SQL Loader, Import, and Export
                            from the command prompt, you may have to set the character set in the parameter
                            NLS_LANG to a different value from the one used in the registry.
                      •     Installing Translation Resources
                            To view the user interface of Oracle components in different languages, you must install
                            the appropriate language translations along with the component.


Configuring Oracle Components to Run in Different Languages
                      You can specify the language and the territory, or locale, in which you want to use the Oracle
                      components.
                      The locale setting of a component determines the language of the user interface of the
                      component and the globalization behavior, such as date and number formatting. Depending on
                      the Oracle component, the locale of the component is either inherited from the operating
                      system session that started the component, or is defined by the NLS_LANG environment
                      variable.
                      The operating system locale usually influences Oracle components that are based on Java
                      technology. The NLS_LANG environment variable usually influences Oracle components that use
                      Oracle Client libraries such as OCI.


                                Note
                                The user interface of an Oracle component is displayed in a selected language only if
                                the appropriate translation is available and has been installed. Otherwise, the user
                                interface is displayed in English.




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
                      Some of the locales may be unavailable until you install required operating system support
                      files.
                      Some Oracle components, such as SQL*Plus, require that the Windows System Locale is also
                      set to the language in which the components are to be run. System Locale is called Language
                      for non-Unicode programs on Windows. On Windows, click the Change system locale button
                      on the Administrative tab, accept the use of administrative privileges, if User Account Control is
                      active, and select the locale from the pop-up list in the opened dialog box.



Database Installation Guide
E96293-13                                                                                                    November 12, 2025
Copyright © 2015, 2025, Oracle and/or its affiliates.                                                            Page 11 of 26
                                                                                                                       Chapter 7
                                                                   Installing and Using Oracle Components in Different Languages



                                Note
                                The operating system must be restarted after the System Locale is changed. See the
                                operating system documentation for further information about Windows locale settings.




Configuring Locale and Character Sets Using the NLS_LANG Environment
Variable
                      The NLS_LANG environment variable determines the language of the user interface and the
                      globalization behavior for components such as SQL*Plus, exp, and imp.
                      It sets the language and territory used by the client application and the database user session.
                      It also declares the character set for entering and displaying data by the client application.
                      The NLS_LANG environment variable uses the following format:
                      NLS_LANG=language_territory.characterset

                      In this format:
                      •     language specifies the language used for displaying Oracle messages, sorting, day
                            names, and month names
                      •     territory specifies the conventions for default date, monetary and numeric formats
                      •     characterset specifies the encoding used by the client application
                            In most cases, this is the Oracle character set that corresponds to the Windows ANSI
                            Code Page as determined by the System Locale.
                      The NLS_LANG parameter on Windows can be set

                      •     in Registry under the subkey corresponding to a given Oracle home,
                      •     as an environment variable.
                      When you install Oracle Database components and the NLS_LANG parameter is not yet set in
                      the Registry subkey of the target Oracle home, Oracle Universal Installer sets the NLS_LANG
                      parameter to a default value derived from the operating system locale for the current user.


                                See Also
                                •    Oracle Database Globalization Support Guide for information about the NLS_LANG
                                     parameter and Globalization Support initialization parameters



                      For example:
                      •     Arabic (U.A.E.) - ARABIC_UNITED ARAB EMIRATES.AR8MSWIN1256
                      •     Chinese (PRC) - SIMPLIFIED CHINESE_CHINA.ZHS16GBK
                      •     Chinese (Taiwan) - TRADITIONAL CHINESE_TAIWAN.ZHT16MSWIN950
                      •     English (United Kingdom) - ENGLISH_UNITED KINGDOM.WE8MSWIN1252
                      •     English (United States) - AMERICAN_AMERICA.WE8MSWIN1252
                      •     French (Canada) - CANADIAN FRENCH_CANADA.WE8MSWIN1252


Database Installation Guide
E96293-13                                                                                                    November 12, 2025
Copyright © 2015, 2025, Oracle and/or its affiliates.                                                            Page 12 of 26
                                                                                                                          Chapter 7
                                                                      Installing and Using Oracle Components in Different Languages


                      •     French (France) - FRENCH_FRANCE.WE8MSWIN1252
                      •     German (Germany) - GERMAN_GERMANY.WE8MSWIN1252
                      •     Hebrew - HEBREW_ISRAEL.IW8MSWIN1255
                      •     Japanese - JAPANESE_JAPAN.JA16SJISTILDE
                      •     Russian - RUSSIAN_RUSSIA.CL8MSWIN1251
                      •     Spanish (Spain) - SPANISH_SPAIN.WE8MSWIN1252
                      •     Spanish (Mexico) - MEXICAN SPANISH_MEXICO.WE8MSWIN1252
                      •     Spanish (Venezuela) - LATIN AMERICAN SPANISH_VENEZUELA.WE8MSWIN1252


NLS_LANG Settings in Console Mode and Batch Mode
                      Before you can use Oracle utilities such as SQL*Plus, SQL Loader, Import, and Export from
                      the command prompt, you may have to set the character set in the parameter NLS_LANG to a
                      different value from the one used in the registry.
                      You may need to set a different character set for console mode utilities, because programs
                      running in console mode use, with a few exceptions, a different code page (character set) from
                      programs running in GUI mode. The default Oracle home NLS_LANG parameter in the Registry
                      is always set to the appropriate GUI code page. If you do not set the NLS_LANG parameter for
                      the console mode session correctly, incorrect character conversion can corrupt error messages
                      and data.
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
                      set name in the following table:

                      Table 7-1         Oracle Character Sets for Console Mode (OEM) Code Pages

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


Database Installation Guide
E96293-13                                                                                                       November 12, 2025
Copyright © 2015, 2025, Oracle and/or its affiliates.                                                               Page 13 of 26
                                                                                                                          Chapter 7
                                                                          Running Oracle Universal Installer in Different Languages



                      Table 7-1       (Cont.) Oracle Character Sets for Console Mode (OEM) Code Pages

                       OEM Code Page                    Oracle Character Set for Console Mode
                       932 (Japanese Shift-JIS)         JA16SJISTILDE
                       936 (Simplified Chinese GBK)     ZHS16GBK
                       949 (Korean)                     KO16MSWIN949
                       950 (Traditional Chinese Big5)   ZHT16MSWIN950
                       1258 (Vietnam)                   VN8MSWIN1258


Installing Translation Resources
                      To view the user interface of Oracle components in different languages, you must install the
                      appropriate language translations along with the component.


                                Note
                                Part of Oracle Database Vault user interface text is stored in database tables in the
                                DVSYS schema. By default, only the English language is loaded into these tables. You
                                can use Oracle Database Vault Configuration Assistant to add more languages to
                                Oracle Database Vault.



                      To install translation resources:
                      1.    Start Oracle Universal Installer.
                      2.    In the Select Installation Option screen, select the installation option and click Next.
                      3.    In the System Class screen, select the type of system class for installing the database, and
                            click Next.
                      4.    In the Grid Installation Options screen, select the type of database installation you want to
                            perform, and click Next.



                                See Also
                                Oracle Database Vault Administrator's Guide



Running Oracle Universal Installer in Different Languages
                      Describes how to run Oracle Universal Installer in other languages.
                      Your operating system locale determines the language in which Oracle Universal Installer runs.
                      You can run Oracle Universal Installer in one of these languages:
                      •     Brazilian Portuguese (pt_BR)
                      •     French (fr)
                      •     German (de)
                      •     Italian (it)


Database Installation Guide
E96293-13                                                                                                      November 12, 2025
Copyright © 2015, 2025, Oracle and/or its affiliates.                                                              Page 14 of 26
                                                                                                                   Chapter 7
                                                                              About Image-Based Oracle Database Installation


                      •     Japanese (ja)
                      •     Korean (ko)
                      •     Simplified Chinese (zh_CN)
                      •     Spanish (es)
                      •     Traditional Chinese (zh_TW)
                      To run Oracle Universal Installer in a supported language, change the locale in which your
                      operating system session is running before you start Oracle Universal Installer. If the selected
                      language is not one of the supported languages, then Oracle Universal Installer runs in
                      English.
                      1.    Change the locale for the operating system user and the System Locale.
                      2.    Run Oracle Universal Installer.


About Image-Based Oracle Database Installation
                      Starting with Oracle Database 18c, installation and configuration of Oracle Database software
                      is simplified with image-based installation.
                      To install Oracle Database, create the new Oracle home, extract the image file into the newly-
                      created Oracle home, and run the setup wizard to register the Oracle Database product.
                      Using image-based installation, you can install and upgrade Oracle Database for single-
                      instance and cluster configurations.
                      This installation feature streamlines the installation process and supports automation of large-
                      scale custom deployments. You can also use this installation method for deployment of
                      customized images, after you patch the base-release software with the necessary Release
                      Updates (Updates) or Release Update Revisions (Revisions).


                                Note
                                You must extract the image software (db_home.zip) into the directory where you
                                want your Oracle Database home to be located, and then run the Oracle Database
                                Setup Wizard to start the Oracle Database installation and configuration. Oracle
                                recommends that the Oracle home directory path you create is in compliance with the
                                Oracle Optimal Flexible Architecture recommendations.



Setup Wizard Installation Options for Creating Images
                      Before you start the setup wizards for your Oracle Database or Oracle Grid Infrastructure
                      installation, decide if you want to use any of the available image-creation options.
                      In image-based installations, you can start your Oracle Database installation or Oracle Grid
                      Infrastructure installation by running the setup wizard setup.exe. This wizard comes with the
                      following image-creation options:


                                Note
                                setup.exe is the recommended setup wizard for installing both Oracle Database and
                                Oracle Grid Infrastructure.



Database Installation Guide
E96293-13                                                                                                November 12, 2025
Copyright © 2015, 2025, Oracle and/or its affiliates.                                                        Page 15 of 26
                                                                                                                            Chapter 7
                                                                                              Installing the Oracle Database Software



                      Table 7-2       Image-Creation Options for Setup Wizard

                       Option                           Description
                       -createGoldImage                 Creates a gold image from the current Oracle home.
                       -destinationLocation             Specify the complete path, or location, where the gold image will be
                                                        created.
                       -exclFiles                       Specify the complete paths to the files to be excluded from the newly
                                                        created gold image.
                       —help                            Displays help for all the available options.

                      For example:

                      cd ORACLE_HOME
                      setup.exe -createGoldImage -destinationLocation c:\my_db_images -exclFiles
                      C:\app\oracle\product\19.0.0\dbhome_1\relnotes


                      cd Grid_home
                      setup.exe -createGoldImage -destinationLocation c:\my_grid_images -exclFiles
                      C:\app\oracle\product\19.0.0\dbhome_1\relnotes


                      Where:
                      c:\my_db_images is the file location where the image zip file is created.

                      c:\my_grid_images is the file location where the image zip file is created.

                      C:\app\oracle\product\19.0.0\dbhome_1\relnotes is the file to be excluded from
                      the newly created gold image.


Installing the Oracle Database Software
                      This topic explains how to run Oracle Universal Installer to perform most database
                      installations.


                                Note
                                •    If you plan to use Oracle Restart or Oracle ASM, then you must install Oracle Grid
                                     Infrastructure for a standalone server before you install and create the database.
                                     Otherwise, you must manually register the database with Oracle Restart.
                                •    You may have to shut down existing Oracle processes before you start the
                                     database installation.
                                •    You can install Oracle Database by using the silent or response file installation
                                     method, without the GUI. This method is useful to perform multiple installations of
                                     Oracle Database.




Database Installation Guide
E96293-13                                                                                                         November 12, 2025
Copyright © 2015, 2025, Oracle and/or its affiliates.                                                                 Page 16 of 26
                                                                                                                     Chapter 7
                                                                                       Installing the Oracle Database Software


                      1.    Login as an Administrator user. Follow the Oracle Optimal Flexible Architecture (OFA)
                            recommendations and specify the correct owner, group, and permissions for this directory.

                            C:\>md C:\app\oracle
                            C:\>icacls oracle:oinstall C:\app\oracle


                            If you are installing on a Primary Domain Controller (PDC) or a Backup Domain Controller
                            (BDC), log on as a member of the Domain Administrators group.
                      2.    If you are installing Oracle Database on a computer with multiple Network Interface Cards
                            or multiple aliases, use System in the Control Panel to create the ORACLE_HOSTNAME
                            system environment variable. Set this variable to point to the host name of the computer
                            on which you are installing Oracle Database.
                      3.    Log in to the Oracle Database server as the Oracle Database software owner user
                            (oracle).
                      4.    Download the Oracle Database 19c release 19.3 installation image file (db_home.zip)
                            from Oracle Software Delivery Cloud website to a directory of your choice.
                            https://edelivery.oracle.com/
                      5.    Create an OFA-compliant Oracle home directory on the local file system and extract the
                            image files that you have downloaded in to this Oracle home directory. For example:

                            C:\>md C:\app\oracle\product\19.0.0\dbhome_1
                            C:\>cd C:\app\oracle\product\19.0.0\dbhome_1
                            C:\app\oracle\product\19.0.0\dbhome_1> unzip \tmp\db_home.zip

                      6.    From the Oracle home directory, run the setup.exe command to start the Oracle
                            Database Setup Wizard.

                            C:\app\oracle\product\19.0.0\dbhome_1>setup.exe



                                     Note
                                     Run the setup.exe command from the Oracle home directory only. Do not use
                                     the setup.exe command that resides at %ORACLE_HOME%\oui\bin\, or any
                                     other location, to install Oracle Database.

                      7.    In the Select Configuration Option screen, select Set Up Software Only.
                      8.    In the Select Database Installation Option screen, select Single instance database
                            installation.
                      9.    In the Select Database Edition screen, select Enterprise Edition.
                      10. Respond to the configuration prompts as needed.



                                     Note
                                     Click Help if you have any questions about the information you are asked to
                                     submit during installation.

                      11. When the Configuration Assistant tasks are complete, click Finish, click Exit, then click
                            Yes to exit from Oracle Universal Installer.


Database Installation Guide
E96293-13                                                                                                  November 12, 2025
Copyright © 2015, 2025, Oracle and/or its affiliates.                                                          Page 17 of 26
                                                                                                                          Chapter 7
                                                                                       Installing Standard Edition High Availability




Installing Standard Edition High Availability
                      Learn how to Install high availability on Oracle Database Standard Edition 2.
                      •     About Standard Edition High Availability
                            Starting with Oracle Database 19c Release Update (19.7), you can install Oracle Database
                            Standard Edition 2 in high availability mode.
                      •     Requirements for Installing Standard Edition High Availability
                            Review these requirements before you install and deploy the Standard Edition High
                            Availability feature.
                      •     Deploying Standard Edition High Availability
                            Learn the process and options to deploy high availability on Oracle Database Standard
                            Edition 2.


About Standard Edition High Availability
                      Starting with Oracle Database 19c Release Update (19.7), you can install Oracle Database
                      Standard Edition 2 in high availability mode.
                      Standard Edition High Availability provides cluster-based failover for single-instance Standard
                      Edition Oracle Databases using Oracle Clusterware.
                      Oracle Standard Edition High Availability benefits from the cluster capabilities and storage
                      solutions that are already part of Oracle Grid Infrastructure, such as Oracle Clusterware,
                      Oracle Automatic Storage Management (Oracle ASM) and Oracle ASM Cluster File System
                      (Oracle ACFS).
                      Using integrated, shared, and concurrently mounted storage, such as Oracle ASM and Oracle
                      ACFS for database files as well as for unstructured data, enables Oracle Grid Infrastructure to
                      restart an Oracle Database on a failover node much faster than any cluster solution that relies
                      on failing over and remounting volumes and file systems.
                      Standard Edition High Availability is supported on Linux x86-64, Oracle Solaris on SPARC (64-
                      bit), and Microsoft Windows.
                      Starting with Oracle Database 19c Release Update (19.13), Standard Edition High Availability
                      is supported on IBM AIX on POWER Systems (64-bit).


                                Note
                                This section is specific to Standard Edition High Availability, which provides cluster-
                                based database failover for Standard Edition Oracle Databases 19c. For more
                                information about high availability options for Oracle Database, see Oracle
                                Clusterware Administration and Deployment Guide.



Requirements for Installing Standard Edition High Availability
                      Review these requirements before you install and deploy the Standard Edition High Availability
                      feature.
                      •     You must configure Standard Edition High Availability using at least two nodes of a cluster
                            running Oracle Grid Infrastructure 19.7 or later for Standalone Cluster.



Database Installation Guide
E96293-13                                                                                                      November 12, 2025
Copyright © 2015, 2025, Oracle and/or its affiliates.                                                              Page 18 of 26
                                                                                                                       Chapter 7
                                                                                    Installing Standard Edition High Availability


                      •     You must configure Standard Edition High Availability using an Oracle Database home of
                            version 19.7 or later.


                                     Note
                                     When updating your Oracle Database home using Release Update (RU) 19.7 or
                                     later, ensure that you apply the Oracle Clusterware (OCW) RU of the same
                                     version to the Oracle Database home.

                      •     Ensure that all cluster nodes on which you plan to install Oracle Database have the same
                            operating system users, groups, and resource limits for the database software owner.
                      •     You must store the Oracle Database binaries only on local storage or Oracle Automatic
                            Storage Management Cluster File System (Oracle ACFS).
                      •     You must store the Oracle Database data files only on Oracle ASM or Oracle ACFS.
                      •     If you are using Oracle ACFS for storing data files, then you must register Oracle ACFS as
                            a clusterware resource. The Oracle Database software owner user (oracle) must be the
                            mount owner of the Oracle ACFS volume. When using an Oracle home on Oracle ACFS,
                            Oracle recommends that you have Oracle base on the local file system.
                      •     If you are using a local file system, then you must have the same single-instance Standard
                            Edition 2 installation and updates on each node. You must also use the same Oracle base
                            and Oracle home directory structure on each node.
                      •     You must perform the same Oracle home operations on all the nodes.
                      •     You must use an SPFILE for the database instance initialization parameters and a
                            database password file stored for the database instance initialization parameters in Oracle
                            ASM or Oracle ACFS. This approach ensures that the parameters are consistent across all
                            nodes and the password file is available after a failover or a relocation.
                      •     You must register the Standard Edition 2 single-instance database with SCAN listeners as
                            remote listener and node listeners as local listener.


Deploying Standard Edition High Availability
                      Learn the process and options to deploy high availability on Oracle Database Standard Edition
                      2.
                      After installing Oracle Clusterware, as described in Oracle Grid Infrastructure Installation and
                      Upgrade Guide for your platform, install single instance Standard Edition 2 Oracle Database
                      software on the cluster nodes on which you want to configure Standard Edition High
                      Availability.
                      •     Installing Standard Edition High Availability Database Software on Local File System
                            You can install Oracle Database software binaries on a local file system to enable the
                            Oracle Database Standard Edition high availability feature.
                      •     Installing Standard Edition High Availability Database Software on Oracle ACFS
                            You can install Oracle Database software binaries on an Oracle ASM Cluster File System
                            (Oracle ACFS) volume to enable the Oracle Database Standard Edition High Availability
                            feature.
                      Related Topics
                      •     Oracle Grid Infrastructure Installation and Upgrade Guide for Linux




Database Installation Guide
E96293-13                                                                                                   November 12, 2025
Copyright © 2015, 2025, Oracle and/or its affiliates.                                                           Page 19 of 26
                                                                                                                       Chapter 7
                                                                                    Installing Standard Edition High Availability



Installing Standard Edition High Availability Database Software on Local File System
                      You can install Oracle Database software binaries on a local file system to enable the Oracle
                      Database Standard Edition high availability feature.
                      Ensure that all the cluster nodes, on which you plan to configure Standard Edition High
                      Availability, have the same operating system configuration, database users, database groups,
                      resource limits, and SSH equivalence for the Oracle Database software owner user (oracle).
                      Before you start the installation, have all the information you need about users, groups, and
                      storage paths. You should also be prepared to run root scripts or provide information to
                      automate root scripts.
                      1.    As the Administrator user, log into the first cluster node on which you want to configure
                            Standard Edition High Availability and create the Oracle base directory on the local file
                            system. Follow the Oracle Optimal Flexible Architecture (OFA) recommendations and
                            specify the correct owner, group, and permissions for this directory.

                            C:\>md C:\app\oracle
                            C:\>icacls oracle:oinstall C:\app\oracle

                      2.    Log in to the first cluster node as the Oracle Database software owner user (oracle).
                      3.    Download the Oracle Database 19c release 19.3 installation image file (db_home.zip)
                            from Oracle Software Delivery Cloud website to a directory of your choice.
                            https://edelivery.oracle.com/
                      4.    Download the Oracle Database Release Update 19.7 or later patch from My Oracle
                            Support to a directory of your choice and unzip it.
                            https://support.oracle.com/
                      5.    Create an OFA-compliant Oracle home directory on the local file system and extract the
                            image files that you have downloaded in to this Oracle home directory. For example:

                            C:\>md C:\app\oracle\product\19.0.0\dbhome_1
                            C:\>cd C:\app\oracle\product\19.0.0\dbhome_1
                            C:\app\oracle\product\19.0.0\dbhome_1> unzip \tmp\db_home.zip

                      6.    From the Oracle home directory, run the setup.exe command to start the Oracle
                            Database Setup Wizard.

                            C:\app\oracle\product\19.0.0\dbhome_1>setup.exe



                                     Note
                                     Run the setup.exe command from the Oracle home directory only. Do not use
                                     the setup.exe command that resides at %ORACLE_HOME%\oui\bin\, or any
                                     other location, to install Oracle Database.

                      7.    In the Select Configuration Option screen, select Set Up Software Only.
                      8.    In the Select Database Installation Option screen, select Single instance database
                            installation.
                      9.    In the Select Database Edition screen, select Standard Edition 2.


Database Installation Guide
E96293-13                                                                                                   November 12, 2025
Copyright © 2015, 2025, Oracle and/or its affiliates.                                                           Page 20 of 26
                                                                                                                        Chapter 7
                                                                                     Installing Standard Edition High Availability


                      10. Respond to the configuration prompts as needed.



                                     Note
                                     Click Help if you have any questions about the information you are asked to
                                     submit during installation.

                      11. Apply the Oracle Database Release Update (RU) 19.7 or later patch. Review the patch
                            documentation for instructions on how to apply the patch.


                                     Note
                                     Ensure that you apply the Oracle Clusterware (OCW) RU of the same version to
                                     the Oracle Database home.


                      12. Optional: As the oracle user, enable read-only Oracle home on the first cluster node.

                            cd C:\app\vldb22\product\19.0.0\dbhome_1\bin
                            C:\app\vldb22\product\19.0.0\dbhome_1\bin>roohctl.bat -enable



                                     Note
                                     Do not use the -disable flag with the roohctl command, as it is not supported.

                      13. As the Administrator user, create the Oracle base directory on all of the other cluster
                            nodes on which you want to configure Standard Edition High Availability.

                            C:\>md C:\app\oracle
                            C:\>icacls oracle:oinstall C:\app\oracle

                      14. As the oracle user, run the addnode.bat script from the first node to perform the following
                            operations on the other nodes on which you want to configure Standard Edition High
                            Availability:
                            •    Copy the Oracle home directory from the first node to the other nodes.
                            •    Setup Oracle base, Oracle inventory directories, and Oracle DB registry keys on the
                                 other nodes.

                            C:\>%ORACLE_HOME%\addnode\addnode.bat -silent
                            CLUSTER_NEW_NODES=comma_separated_list_of_other_nodes

                      15. If you specify a non built-in and a non Administrator's user account while installing Oracle
                            Database, then add the respective user's password to the CRS wallet using the following
                            command:

                            crsctl add wallet -type OSUSER -user DB service user name -password

                      After the Oracle Database software installation is complete, use Oracle Database
                      Configuration Assistant (Oracle DBCA), in either interactive or silent mode, to create a
                      Standard Edition database on the first cluster node on which you installed the Oracle Database
                      software.


Database Installation Guide
E96293-13                                                                                                    November 12, 2025
Copyright © 2015, 2025, Oracle and/or its affiliates.                                                            Page 21 of 26
                                                                                                                       Chapter 7
                                                                                    Installing Standard Edition High Availability


                      For more information about the requirements for creating a database, and the procedure for
                      enabling and configuring Standard Edition High Availability for Oracle Databases, refer to
                      Oracle Database Administrator’s Guide
                      Related Topics
                      •     Oracle Grid Infrastructure Installation and Upgrade Guide for Linux
                      •     Creating a Database with Oracle DBCA

Installing Standard Edition High Availability Database Software on Oracle ACFS
                      You can install Oracle Database software binaries on an Oracle ASM Cluster File System
                      (Oracle ACFS) volume to enable the Oracle Database Standard Edition High Availability
                      feature.
                      Ensure that all the cluster nodes, on which you plan to configure Standard Edition High
                      Availability, have the same operating system configuration, database users, database groups,
                      resource limits, and SSH equivalence for the Oracle Database software owner user (oracle)
                      between the nodes.
                      Before you start the installation, have all the information you need about users groups, and
                      storage paths. You should also be prepared to run root scripts or provide information to
                      automate root scripts.
                      1.    As the Administrator user, register Oracle ACFS as an Oracle Clusterware resource
                            specifying the Oracle Database software owner user (oracle) as the mount owner.

                            C:\>Grid_home\bin\srvctl add filesystem -volume acfs_volume_name -
                            diskgroup diskgroup_name -path mount_point -fstype ACFS -autostart ALWAYS -
                            user oracle



                                     Note
                                     Mount Oracle ACFS to a mount point where you plan to create Oracle base and
                                     Oracle home directories for this installation. For example, C:\app\oracle.

                      2.    Mount the Oracle ACFS file system on all of the cluster nodes on which you want to
                            configure Standard Edition High Availability.

                            C:\>Grid_home\bin\srvctl start filesystem -volume acfs_volume_name -
                            diskgroup diskgroup_name

                      3.    Create the Oracle base directory in an Oracle ACFS volume on the first cluster node on
                            which you want to configure Standard Edition High Availability. Follow the Oracle Optimal
                            Flexible Architecture (OFA) recommendations and specify the correct owner, group, and
                            permissions for this directory.

                            C:\>md C:\app\oracle
                            C:\>icacls oracle:oinstall C:\app\oracle

                      4.    Log in to the first cluster node as the oracle user.
                      5.    Download the Oracle Database 19c release 19.3 installation image file (db_home.zip)
                            from Oracle Software Delivery Cloud website to a directory of your choice.
                            https://edelivery.oracle.com/


Database Installation Guide
E96293-13                                                                                                   November 12, 2025
Copyright © 2015, 2025, Oracle and/or its affiliates.                                                           Page 22 of 26
                                                                                                                        Chapter 7
                                                                                     Installing Standard Edition High Availability


                      6.    Download the Oracle Database Release Update 19.7 or later patch from My Oracle
                            Support to a directory of your choice and unzip it.
                            https://support.oracle.com/
                      7.    Create an OFA-compliant Oracle home directory in an Oracle ACFS volume and extract
                            the image files that you have downloaded in to this Oracle home directory. For example:

                            C:\>md C:\app\oracle\product\19.0.0\dbhome_1
                            C:\>cd C:\app\oracle\product\19.0.0\dbhome_1
                            C:\app\oracle\product\19.0.0\dbhome_1> unzip \tmp\db_home.zip

                      8.    From the Oracle home directory, run the setup.exe command to start the Oracle
                            Database Setup Wizard.

                            C:\app\oracle\product\19.0.0\dbhome_1>setup.exe



                                     Note
                                     Run the setup.exe command from the Oracle home directory only. Do not use
                                     the setup.exe command that resides at %ORACLE_HOME%\oui\bin\, or any
                                     other location, to install Oracle Database.

                      9.    In the Select Configuration Option screen, select Set Up Software Only.
                      10. In the Select Database Installation Option screen, select Single instance database
                            installation.
                      11. In the Select Database Edition screen, select Standard Edition 2.

                      12. Respond to the configuration prompts as needed.



                                     Note
                                     Click Help if you have any questions about the information you are asked to
                                     submit during installation.

                      13. Apply the Oracle Database Release Update (RU) 19.7 or later patch. Review the patch
                            documentation for instructions on how to apply the patch.


                                     Note
                                     Ensure that you apply the Oracle Clusterware (OCW) RU of the same version to
                                     the Oracle Database home.


                      14. Optional: As the oracle user, enable read-only Oracle home on the first cluster node.

                            cd C:\app\vldb22\product\19.0.0\dbhome_1\bin
                            C:\app\vldb22\product\19.0.0\dbhome_1\bin>roohctl.bat -enable




Database Installation Guide
E96293-13                                                                                                    November 12, 2025
Copyright © 2015, 2025, Oracle and/or its affiliates.                                                            Page 23 of 26
                                                                                                                    Chapter 7
                                                                                                      Cloning an Oracle Home



                                     Note
                                     Do not use the -disable flag with the roohctl command, as it is not supported.

                      15. Attach the Oracle home on the first node to the other cluster nodes on which you want to
                            configure Standard Edition High Availability.

                            C:\>%ORACLE_HOME%\addnode\addnode.bat -silent
                            CLUSTER_NEW_NODES=comma_separated_list_of_other_nodes

                      16. If you specify a non built-in and a non Administrator's user account while installing Oracle
                            Database, then add the respective user's password to the CRS wallet using the following
                            command:

                            crsctl add wallet -type OSUSER -user DB service user name -password

                      After the Oracle Database software installation is complete, use Oracle Database
                      Configuration Assistant (Oracle DBCA), in either interactive or silent mode, to create a
                      Standard Edition database on the first cluster node on which you installed the Oracle Database
                      software.
                      For more information about the requirements for creating a database, and the procedure for
                      enabling and configuring Standard Edition High Availability for Oracle Databases, refer to
                      Oracle Database Administrator’s Guide
                      Related Topics
                      •     Oracle Grid Infrastructure Installation and Upgrade Guide for Linux
                      •     Configuring Oracle Automatic Storage Management Cluster File System
                      •     Creating a Database with Oracle DBCA


Cloning an Oracle Home
                      Follow these steps to clone an Oracle home.


                                Note
                                During cloning, Oracle Universal Installer (OUI) prompts you to run scripts that require
                                root privileges.


                      1.    Verify that the installation of Oracle Database to clone is successful.
                            You can do this by reviewing the installActionsdate_time.log file for the installation
                            session, which is typically located in the following directory:
                            C:\Program Files\Oracle\Inventory\logs
                            If you have installed patches, you can check their status by running the following
                            commands at a command prompt:
                            C:\ORACLE_HOME\OPatch> set ORACLE_HOME=ORACLE_HOME_using_patch
                            C:\ORACLE_HOME\OPatch> opatch lsinventory

                      2.    Stop all processes related to the Oracle home. You can stop Oracle services by the
                            following method:



Database Installation Guide
E96293-13                                                                                                 November 12, 2025
Copyright © 2015, 2025, Oracle and/or its affiliates.                                                         Page 24 of 26
                                                                                                                    Chapter 7
                                                                                                      Cloning an Oracle Home


                            Microsoft Windows Services utility: From the Start menu, select Control Panel, then
                            Administrative Tools, then Services. Right-click any service that begins with Oracle, and
                            then from the menu, select Stop.
                      3.    Create a ZIP file with the Oracle home (but not Oracle base) directory.
                            For example, if the source Oracle installation is in
                            C:\app\username\product\19.0.0\dbhome_1 you zip the dbhome_1 directory, leaving
                            out the admin, flash_recovery_area, and oradata directories that are under 19.0.0.
                            These directories are created in the target installation later on when you create a new
                            database there.
                      4.    Copy the ZIP file to the root directory of the target computer. If you use File Transfer
                            Protocol (FTP), then transfer the ZIP file in binary mode only.
                      5.    Extract the ZIP file contents, selecting the Use folder names option.
                      6.    Repeat steps 4 and 5 for each computer where you want to clone the Oracle home, unless
                            the Oracle home is on a shared storage device.
                      7.    In the source Oracle home, restart the services that you stopped in step 2.
                      8.    On the target computer, cd to the unzipped Oracle home directory, and perform the
                            following steps:
                            a.   Remove the *.ora files that are present in unzipped ORACLE_HOME\network\admin
                                 directory, such as listener.ora, sqlnet.ora, and tnsnames.ora.
                            b.   Delete unnecessary files from the unzipped Oracle home directory.
                                 The unzipped Oracle home directory contains files that are relevant only to the source
                                 Oracle home. Remove the unnecessary files from the unzipped Oracle home in the
                                 log, crs/init, crf, and cdata directories. The following example shows how to
                                 remove these unnecessary files from the unzipped Oracle home directory:
                                 [grid_home]# cd copy_path
                                     [grid_home]# rm -rf host_name
                                     [grid_home]# rm -rf log/host_name
                                     [grid_home]# rm -rf gpnp/host_name
                                     [grid_home]# rm -rf find gpnp -type f -exec rm -f {} \;
                                        c:\<Gridhome> c:\mksnt\find gpnp -type f and delete these files.
                                        gpnp/init/host_name
                                        gpnp/init/host_name.pid
                                          gpnp/profiles/peer/profile.xml
                                        gpnp/profiles/peer/profile_orig.xml
                                        gpnp/host_name/profiles/peer/profile.old
                                        gpnp/host_name/profiles/peer/profile.xml
                                                 gpnp/host_name/profiles/peer/profile_orig.xml
                                        gpnp/host_name/wallets/pa/cwallet.sso
                                        gpnp/host_name/wallets/peer/cwallet.sso
                                        gpnp/host_name/wallets/prdr/cwallet.sso
                                        gpnp/host_name/wallets/root/ewallet.p12
                                        gpnp/wallets/pa/cwallet.sso
                                        gpnp/wallets/peer/cwallet.sso
                                        gpnp/wallets/prdr/cwallet.sso
                                        gpnp/wallets/roor/ewallet.p12

                                     [grid_home]# find cfgtoollogs -type f -exec rm -f {} \;
                                     [grid_home]# rm -rf crs/init/*
                                 [grid_home]# rm -rf cdata/*
                                 [grid_home]# rm -rf crf/*
                                 [grid_home]# rm -rf network/admin/*.ora




Database Installation Guide
E96293-13                                                                                                 November 12, 2025
Copyright © 2015, 2025, Oracle and/or its affiliates.                                                         Page 25 of 26
                                                                                                                    Chapter 7
                                                                                                      Cloning an Oracle Home


                      9.    From the ORACLE_HOME\clone\bin directory, run clone.pl for the unzipped Oracle
                            home.
                            Use the following syntax:
                            C:\ORACLE_HOME\clone\bin>target_home\perl\bin\perl.exe clone.pl
                            ORACLE_HOME="target location" ORACLE_BASE="target Base location"
                            ORACLE_HOME_USER="Windows User Account" OSDBA_GROUP=OSDBA_privileged_group
                            OSOPER_GROUP=OSOPER_privileged_group OSBACKUPDBA_GROUP=OSBACKUPDBA_privileged_group
                            OSDGDBA_GROUP=OSDGDBA_privileged_group OSKMDBA_GROUP=OSKMDBA_privileged_group
                            OSRACDBA_GROUP=OSRACDBA_privileged_group -defaultHomeName

                            where ORACLE_HOME_USER="Windows User Account" is the Oracle Home User for the
                            cloned home.
                            Windows Built-in Account is used as the Oracle Home User if the parameter for
                            ORACLE_HOME_USER is not specified.
                            For example:
                            C:\ORACLE_HOME\clone\bin>target_home\perl\bin\perl.exe clone.pl

                            ORACLE_HOME="C:\app\username\product\19.0.0\dbhome_1"
                            ORACLE_BASE="C:\app\username"
                            ORACLE_HOME_USER="mydomain\username" -defaultHomeName
                            OSDBA_GROUP=dba OSOPER_GROUP=oper OSBACKUPDBA_GROUP=backupdba OSDGDBA_GROUP=dgdba
                            OSKMDBA_GROUP=kmdba OSRACDBAGROUP=racdba -defaultHomeName

                            Oracle Universal Installer starts, and then records the cloning actions in the
                            cloneActionstimestamp.log file. This log file is normally located in C:\Program
                            Files\Oracle\Inventory\logs.


                                     Note
                                     •    Run \ORACLE_HOME\clone\bin>target_home\perl\bin\perl.exe clone.pl -
                                          help command for more information about the command option flags.
                                     •    Oracle recommends that you use the software-only installation option,
                                          available in the database installer, instead of clone.pl to clone your database.


                      10. To configure connection information for the new database, run Net Configuration Assistant.

                            To start Net Configuration Assistant, select Start, then All Programs, then Oracle -
                            HOMENAME, then Configuration and Migration Tools, and then Net Configuration
                            Assistant.
                      11. To create a new database for the newly cloned Oracle home, run Oracle Database
                            Configuration Assistant.
                            To start Oracle Database Configuration Assistant, select Start, then All Programs, then
                            Oracle - HOMENAME, then Configuration and Migration Tools, and then Database
                            Configuration Assistant.



                                See Also
                                Oracle Database Administrator's Guide




Database Installation Guide
E96293-13                                                                                                  November 12, 2025
Copyright © 2015, 2025, Oracle and/or its affiliates.                                                          Page 26 of 26
8
Oracle Database Postinstallation Tasks
                      Complete configuration tasks after you install Oracle Database.


                      Oracle recommends that you complete additional tasks immediately after installation. You must
                      also complete product-specific configuration tasks before you use those products.
                      •     Downloading Release Update Patches
                            Download and install Release Updates (RU) and Release Update Revisions (RUR)
                            patches for your Oracle software after you complete installation.
                      •     Requirements for Database Password
                            To secure your database, every password must satisfy the Oracle recommended password
                            requirements, even the passwords for predefined user accounts.
                      •     About Installing Oracle Autonomous Health Framework
                            Install the latest version of Oracle Autonomous Health Framework to perform proactive
                            heath checks and collect diagnostics data for the Oracle software stack.
                      •     Recompiling Invalid Objects on Windows Systems
                            Run the utlrp.sql script after you install, patch, or upgrade a database, to identify, and
                            recompile invalid objects.
                      •     Configuring the Secure Sockets Layer
                            Oracle highly recommends that you configure and use a Secure Sockets Layer (SSL) to
                            ensure that passwords and other sensitive data are not transmitted in clear text in HTTP
                            requests.
                      •     Configuring Oracle Components
                            Many Oracle products and options must be configured before you use them for the first
                            time.
                      •     Creating a Fast Recovery Area Disk Group
                            During installation, by default you can create multiple disk groups.
                      •     Enabling and Disabling Database Options After Installation
                            When you install Oracle Database, some options are enabled and the others disabled. You
                            can view the enabled Oracle Database options by querying the V$OPTION view using
                            SQL*Plus.
                      •     Changing the Oracle Home User Password
                            Oracle Home User Control is a command-line utility that allows an administrator to update
                            the password for an Oracle Home User.


Downloading Release Update Patches
                      Download and install Release Updates (RU) and Release Update Revisions (RUR) patches for
                      your Oracle software after you complete installation.
                      Starting with Oracle Database 18c, Oracle provides quarterly updates in the form of Release
                      Updates (RU) and Release Update Revisions (RUR). Oracle no longer releases patch sets.
                      For more information, see My Oracle Support Note 2285040.1.



Database Installation Guide
E96293-13                                                                                              November 12, 2025
Copyright © 2015, 2025, Oracle and/or its affiliates.                                                       Page 1 of 14
                                                                                                                   Chapter 8
                                                                                         Requirements for Database Password


                      Check the My Oracle Support website for required updates for your installation.
                      1.    Use a web browser to view the My Oracle Support website:
                            https://support.oracle.com
                      2.    Log in to My Oracle Support website.


                                     Note
                                     If you are not a My Oracle Support registered user, then click Register for My
                                     Oracle Support and register.

                      3.    On the main My Oracle Support page, click Patches & Updates.
                      4.    In the Patch Search region, select Product or Family (Advanced).
                      5.    On the Product or Family (Advanced) display, provide information about the product,
                            release, and platform for which you want to obtain patches, and click Search.
                            The Patch Search pane opens, displaying the results of your search.
                      6.    Select the patch number and click ReadMe.
                            The README page is displayed. It contains information about the patch and how to apply
                            the patches to your installation.
                      7.    Uncompress the Oracle patch updates that you downloaded from My Oracle Support.
                      Related Topics
                      •     My Oracle Support note 888.1
                      •     Patch Delivery Methods for Oracle Database


Requirements for Database Password
                      To secure your database, every password must satisfy the Oracle recommended password
                      requirements, even the passwords for predefined user accounts.
                      Oracle Database provides a set of predefined user accounts. You must create passwords in a
                      secure fashion. If you have default passwords, you must change these.
                      You can manage the security for Oracle Database users by enforcing restrictions on the
                      passwords that are created, creating user profiles, and using user resource limits to further
                      secure user accounts.



                                See Also
                                Oracle Database Security Guide




Database Installation Guide
E96293-13                                                                                                November 12, 2025
Copyright © 2015, 2025, Oracle and/or its affiliates.                                                         Page 2 of 14
                                                                                                                   Chapter 8
                                                                         About Installing Oracle Autonomous Health Framework




About Installing Oracle Autonomous Health Framework
                      Install the latest version of Oracle Autonomous Health Framework to perform proactive heath
                      checks and collect diagnostics data for the Oracle software stack.
                      Oracle Autonomous Health Framework includes the functionality from Oracle ORAchk, Oracle
                      EXAchk, and Oracle Trace File Analyzer (TFA). Oracle Autonomous Health Framework
                      extends health check coverage to the entire Oracle software stack, based on critical and
                      reoccurring problems. Oracle Autonomous Health Framework proactively scans for known
                      problems with Oracle products and deployments, including the following:
                      •     Standalone Oracle Database
                      •     Oracle Grid Infrastructure
                      •     Oracle Real Application Clusters
                      •     Maximum Availability Architecture (MAA) Validation
                      •     Upgrade Readiness Validations
                      •     Oracle GoldenGate
                      Oracle Autonomous Health Framework is pre-installed with Oracle Database. However, Oracle
                      recommends that you update to the latest version of Oracle Autonomous Health Framework by
                      downloading and installing it from My Oracle Support Note 2550798.1.
                      https://support.oracle.com/epmos/faces/DocContentDisplay?
                      id=2550798.1&parent=DOCUMENTATION&sourceId=USERGUIDE


Recompiling Invalid Objects on Windows Systems
                      Run the utlrp.sql script after you install, patch, or upgrade a database, to identify, and
                      recompile invalid objects.
                      The utlrp.sql script recompiles all invalid objects, including packages, procedures, and types.
                      Run the script immediately after installation, to ensure that users do not encounter invalid
                      objects.
                      1.    Log in as an Administrator user, or as the Oracle Home user.
                      2.    Start SQL*Plus and log in as a SYSDBA user:
                            a.   Click Start.
                            b.   Select Programs (or All Programs).
                            c.   Select Oracle - HOME_NAME.
                            d.   Select Application Development.
                            e.   Select SQL*Plus.
                      3.    Run the utlrp.sql script, where Oracle_home is the Oracle home path:

                            SQL> @Oracle_home\rdbms\admin\utlrp.sql

                      The utlrp.sql script automatically recompiles invalid objects in either serial or parallel
                      recompilation, based on the number of invalid objects, and on the number of CPUs available.
                      CPUs are calculated using the number of CPUs (cpu_count) multiplied by the number of
                      threads for each CPU (parallel_threads_per_cpu). On Oracle Real Application Clusters
                      (Oracle RAC), this number is added across all Oracle RAC nodes.

Database Installation Guide
E96293-13                                                                                                 November 12, 2025
Copyright © 2015, 2025, Oracle and/or its affiliates.                                                          Page 3 of 14
                                                                                                                    Chapter 8
                                                                                         Configuring the Secure Sockets Layer




Configuring the Secure Sockets Layer
                      Oracle highly recommends that you configure and use a Secure Sockets Layer (SSL) to
                      ensure that passwords and other sensitive data are not transmitted in clear text in HTTP
                      requests.



                                See Also
                                Oracle Database Security Guide




Configuring Oracle Components
                      Many Oracle products and options must be configured before you use them for the first time.
                      Before using individual Oracle products or options, refer to the appropriate manual in the
                      product documentation library.


                                Note
                                Perform postinstallation tasks only for the components that you intend to use.


                      •     Windows Authentication No Longer Uses NTLM by Default
                            For Microsoft Windows installations with AUTHENTICATION_SERVICES=NTS, in this Oracle
                            Database release, the SQLNET.NO_NTLM parameter setting in the sqlnet.ora file defaults to
                            TRUE, which can cause ORA-12638 errors.
                      •     Configuring Oracle Messaging Gateway
                            Oracle Messaging Gateway, an Oracle Database Advanced Queuing feature, requires
                            additional configuration after you install Oracle Database if you plan to use Oracle
                            Database Advanced Queuing.
                      •     Configuring the OraClrAgnt Service for Oracle Database Extensions for .NET
                            Oracle Database Extensions for .NET depends on a Windows service to operate properly.
                            This service is called the OraClrAgnt service, which can be accessed through the Service
                            Control Panel, as OracleORACLE_HOMEClrAgent, where ORACLE_HOME represents an Oracle
                            home name.
                      •     Configuring Oracle Net Services
                            Describes how to configure Oracle Net Services.
                      •     Installing Oracle Text Supplied Knowledge Bases
                            An Oracle Text knowledge base is a hierarchical tree of concepts used for theme indexing,
                            ABOUT queries, and deriving themes for document services.
                      •     Installing the Oracle Text Filtering Component
                            Oracle Text Filtering Technology requires the Visual C++ libraries included in the Visual C+
                            + Redistributable Package provided by Microsoft.
                      •     Configuring or Reinstalling Oracle XML DB
                            Oracle XML DB is a component of the Oracle Database installation.
                      •     Configuring PL/SQL External Procedures
                            Configuring PL/SQL depends on the network configuration files used.


Database Installation Guide
E96293-13                                                                                                 November 12, 2025
Copyright © 2015, 2025, Oracle and/or its affiliates.                                                          Page 4 of 14
                                                                                                                 Chapter 8
                                                                                             Configuring Oracle Components


                      •     Configuring Shared Server Support
                            The default setup for using the Shared Server mode depends on how the software has
                            been installed.
                      •     Setting Credentials for the Job System to Work with Oracle Enterprise Manager
                            Windows systems require that you set the correct credentials for the Jobs system to work
                            properly in Oracle Enterprise Manager.
                      •     Configuring Oracle Database to Communicate with Oracle Automatic Storage
                            Management
                            On Windows, Oracle Database installations that use Oracle Automatic Storage
                            Management must use Windows native authentication.
                      •     Installing Oracle Database Examples
                            If you plan to use the following products or features, then download and install the products
                            from the Oracle Database Examples media:
                      •     Creating the OraMTS Service for Microsoft Transaction Server
                            Oracle Services for Microsoft Transaction Server (OraMTS) permit Oracle databases to be
                            used as resource managers in Microsoft application coordinated transactions.


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
                      •     Upgrade Your Database Now - ORA-12638 on Windows only from Oracle 19.10.0 onwards
                      •     Windows : While Connect to Database Getting ORA-12638 After Applying Jan 2021
                            WINDBBP 19.10.0.0.210119 On Windows 64/32 Bit Database Client (Doc ID 2757734.1)



Database Installation Guide
E96293-13                                                                                               November 12, 2025
Copyright © 2015, 2025, Oracle and/or its affiliates.                                                        Page 5 of 14
                                                                                                                   Chapter 8
                                                                                             Configuring Oracle Components



Configuring Oracle Messaging Gateway
                      Oracle Messaging Gateway, an Oracle Database Advanced Queuing feature, requires
                      additional configuration after you install Oracle Database if you plan to use Oracle Database
                      Advanced Queuing.




                                See Also
                                Oracle Database Advanced Queuing User's Guide




Configuring the OraClrAgnt Service for Oracle Database Extensions
for .NET
                      Oracle Database Extensions for .NET depends on a Windows service to operate properly. This
                      service is called the OraClrAgnt service, which can be accessed through the Service Control
                      Panel, as OracleORACLE_HOMEClrAgent, where ORACLE_HOME represents an Oracle home name.

                      In earlier versions of Oracle Database, the OraClrAgnt service was automatically created by
                      the installer. Starting with Oracle Database 12c Release 2 (12.2), after installation you use the
                      OraClrCtl.exe utility to create, start, stop, and delete the OraClrAgnt service. The OraClrAgnt
                      service is configured by this tool using the Oracle Home User account specified during the
                      Oracle Database installation.



                                See Also
                                Oracle Database Extensions for .NET Developer's Guide for Microsoft Windows




Configuring Oracle Net Services
                      Describes how to configure Oracle Net Services.
                      If you have a previous release of Oracle software installed on this system, you can copy
                      information from the Oracle Net tnsnames.ora and listener.ora configuration files from the
                      previous release to the corresponding files for the new release.


                                Note
                                The default location for the tnsnames.ora and listener.ora files is the
                                ORACLE_BASE\ORACLE_HOME\network\admin\ directory.



                      Modifying the listener.ora File
                      If you are upgrading from a previous release of Oracle Database, Oracle recommends that you
                      use the current release of Oracle Net listener instead of the listener from the previous release.


Database Installation Guide
E96293-13                                                                                                 November 12, 2025
Copyright © 2015, 2025, Oracle and/or its affiliates.                                                          Page 6 of 14
                                                                                                                Chapter 8
                                                                                            Configuring Oracle Components


                      If you have referenced the previous Oracle home directory names in the static listener
                      information, then these directory names must be modified before the listener.ora file can be
                      used in the 19c environment.
                      To use the listener from the current release, you must copy static service information from the
                      listener.ora file from the previous release to the version of that file used by the new release.

                      For any database instances earlier than release 8.0.3, add static service information to the
                      listener.ora file. Oracle Database releases later than release 8.0.3 do not require static
                      service information.

                      Modifying the tnsnames.ora File
                      Unless you are using a central tnsnames.ora file, copy Oracle Net service names and connect
                      descriptors from the previous release tnsnames.ora file to the version of that file used by the
                      new release.
                      If necessary, you can also add the connection information for additional database instances to
                      the new file.


Installing Oracle Text Supplied Knowledge Bases
                      An Oracle Text knowledge base is a hierarchical tree of concepts used for theme indexing,
                      ABOUT queries, and deriving themes for document services.
                      If you plan to use any of these Oracle Text features, you can install two supplied knowledge
                      bases (English and French) from the Oracle Database Examples media.



                                See Also
                                Oracle Text Reference




Installing the Oracle Text Filtering Component
                      Oracle Text Filtering Technology requires the Visual C++ libraries included in the Visual C++
                      Redistributable Package provided by Microsoft.
                      You can download the 2005 SP1 Redistributable Package version at:
                      http://www.microsoft.com/downloads

                      Run the vcredist_x64.exe file.



                                See Also
                                Oracle Text Reference




Database Installation Guide
E96293-13                                                                                              November 12, 2025
Copyright © 2015, 2025, Oracle and/or its affiliates.                                                       Page 7 of 14
                                                                                                                  Chapter 8
                                                                                              Configuring Oracle Components



Configuring or Reinstalling Oracle XML DB
                      Oracle XML DB is a component of the Oracle Database installation.
                      However, you must manually configure the FTP and HTTP ports for Oracle XML DB.
                      Related Topics
                      •     Oracle XML DB Developer's Guide


Configuring PL/SQL External Procedures
                      Configuring PL/SQL depends on the network configuration files used.
                      In nearly all cases, configuration is automatic. However, if you are using pre-8.0.3
                      tnsnames.ora and listener.ora files with your 19c database, then you must manually
                      configure them.


Configuring Shared Server Support
                      The default setup for using the Shared Server mode depends on how the software has been
                      installed.
                      If you install Oracle Database using Oracle Universal Installer, then shared support is not
                      configured. If you created your database through Oracle Database Configuration Assistant,
                      then you were offered a choice of shared or dedicated server support.


Setting Credentials for the Job System to Work with Oracle Enterprise
Manager
                      Windows systems require that you set the correct credentials for the Jobs system to work
                      properly in Oracle Enterprise Manager.
                      By default, the Management Agent service is installed as a LocalSystem user. When
                      submitting jobs, such as stopping or starting the database, the operating system user
                      submitting the job must have the Log on as a batch job privilege enabled.
                      Perform the following steps to establish that privilege for any operating system user who must
                      submit an Oracle Enterprise Manager job.
                      1.    Under the Security Settings list, expand the list to Local Policies.
                      2.    Under Local Policies, double-click User Rights Assignment.
                      3.    Under Policy, search for the Log on as a batch job policy.
                            If the Management Agent service is installed as any other user (that is, not LocalSystem),
                            then, in addition to granting the Log on as a batch job privilege, you must grant the
                            Windows service user the following three privileges:
                            •    Act as part of the operating system
                            •    Adjust memory quotas for a process
                            •    Replace a process level token
                                 The service under the "Windows service" user runs at the operating system level.
                      4.    With each policy, perform the following steps:


Database Installation Guide
E96293-13                                                                                                November 12, 2025
Copyright © 2015, 2025, Oracle and/or its affiliates.                                                         Page 8 of 14
                                                                                                                  Chapter 8
                                                                                              Configuring Oracle Components


                            a.   Double-click the policy name.
                            b.   In the Properties dialog box, click Add User or Group.
                            c.   In the Select Users or Groups dialog box, enter the name of the user (for example,
                                 jsmith, administrator, and so on.)


                                          Note
                                          On Windows Server 2008, the name of the dialog box is Select Users,
                                          Computers, or Groups.


                            d.   Click Check Names to check that you have entered the name correctly.
                            e.   Click OK.
                      5.    Click OK to exit the Properties dialog box, then exit Local Security Settings and
                            Administrative Tools.
                      6.    Restart your computer.
                      If a user exists locally and at the domain level, Windows gives the local user precedence. To
                      use the domain user, qualify the user name with the domain name. For example, to use the
                      user joe in the ACCOUNTS domain specify the user name as ACCOUNTS\joe.


Configuring Oracle Database to Communicate with Oracle Automatic
Storage Management
                      On Windows, Oracle Database installations that use Oracle Automatic Storage Management
                      must use Windows native authentication.
                      By default, Windows native authentication is enabled. To ensure that Windows native
                      authentication is enabled, check the sqlnet.ora file, which by default is located in
                      ORACLE_HOME\network\admin, and ensure that it has NTS enabled. For example:
                      sqlnet.authentication_services=(NTS)


Installing Oracle Database Examples
                      If you plan to use the following products or features, then download and install the products
                      from the Oracle Database Examples media:
                      •     Oracle Database Examples
                      •     Oracle JDBC Development Drivers
                      •     Oracle Text Knowledge Base



                                 See Also
                                 Oracle Database Examples Installation Guide




Database Installation Guide
E96293-13                                                                                                November 12, 2025
Copyright © 2015, 2025, Oracle and/or its affiliates.                                                         Page 9 of 14
                                                                                                                     Chapter 8
                                                                                      Creating a Fast Recovery Area Disk Group



Creating the OraMTS Service for Microsoft Transaction Server
                      Oracle Services for Microsoft Transaction Server (OraMTS) permit Oracle databases to be
                      used as resource managers in Microsoft application coordinated transactions.
                      OraMTS acts as a proxy for the Oracle database to the Microsoft Distributed Transaction
                      Coordinator (MSDTC). As a result, OraMTS provides client-side connection pooling and allows
                      client components that leverage Oracle to participate in promotable and distributed
                      transactions. In addition, OraMTS can operate with Oracle databases running on any operating
                      system, given that the services themselves are run on Windows.
                      On releases before Oracle Database 12c, the OraMTS service was created as part of a
                      software-only installation. Starting with Oracle Database 12c, you must use a configuration tool
                      to create this service.
                      To create the OraMTS service after performing a software-only installation for Oracle
                      Database, perform the following steps:
                      1.    Open a command window.
                      2.    Change directories to ORACLE_HOME\bin.
                      3.    Run the OraMTSCtl utility to create the OraMTS Service:
                            C:\ORACLE_HOME\bin> oramtsctl.exe -new



                                     See Also
                                     Oracle Services for Microsoft Transaction Server Developer's Guide for Microsoft
                                     Windows



Creating a Fast Recovery Area Disk Group
                      During installation, by default you can create multiple disk groups.
                      If you plan to add an Oracle Database for a standalone server, then you must create the fast
                      recovery area for database files.
                      •     About the Fast Recovery Area and the Fast Recovery Area Disk Group
                            The fast recovery area is a unified storage location for all Oracle Database files related to
                            recovery. Enabling rapid backups for recent data can reduce requests to system
                            administrators to retrieve backup tapes for recovery operations.
                      •     Creating the Fast Recovery Area Disk Group
                            Use this procedure to create the fast recovery area disk group.


About the Fast Recovery Area and the Fast Recovery Area Disk Group
                      The fast recovery area is a unified storage location for all Oracle Database files related to
                      recovery. Enabling rapid backups for recent data can reduce requests to system administrators
                      to retrieve backup tapes for recovery operations.
                      Database administrators can define the DB_RECOVERY_FILE_DEST_SIZE parameter to the path
                      for the fast recovery area to enable on-disk backups, and rapid recovery of data.




Database Installation Guide
E96293-13                                                                                                  November 12, 2025
Copyright © 2015, 2025, Oracle and/or its affiliates.                                                          Page 10 of 14
                                                                                                                    Chapter 8
                                                                                     Creating a Fast Recovery Area Disk Group


                      When you enable fast recovery in the init.ora file, it writes all RMAN backups, archive logs,
                      control file automatic backups, and database copies to the fast recovery area. RMAN
                      automatically manages files in the fast recovery area by deleting obsolete backups and archive
                      files no longer required for recovery.
                      Oracle recommends that you create a fast recovery area disk group. Oracle Clusterware files
                      and Oracle Database files can be placed on the same disk group, and you can also place fast
                      recovery files in the same disk group. However, Oracle recommends that you create a
                      separate fast recovery disk group to reduce storage device contention.
                      The fast recovery area is enabled by setting DB_RECOVERY_FILE_DEST_SIZE. The size of the
                      fast recovery area is set with DB_RECOVERY_FILE_DEST_SIZE. As a general rule, the larger the
                      fast recovery area, the more useful it becomes. For ease of use, Oracle recommends that you
                      create a fast recovery area disk group on storage devices that can contain at least three days
                      of recovery information. Ideally, the fast recovery area must be large enough to hold a copy of
                      all of your data files and control files, the online redo logs, and the archived redo log files
                      needed to recover your database using the data file backups kept under your retention policy.
                      Multiple databases can use the same fast recovery area. For example, assume you have
                      created one fast recovery area disk group on disks with 150 GB of storage, shared by three
                      different databases. You can set the size of the fast recovery for each database depending on
                      the importance of each database. For example, if database1 is your least important database,
                      database2 is of greater importance and database3 is of greatest importance, then you can set
                      different DB_RECOVERY_FILE_DEST_SIZE settings for each database to meet your retention
                      target for each database: 30 GB for database1, 50 GB for database2, and 70 GB for
                      database3.


Creating the Fast Recovery Area Disk Group
                      Use this procedure to create the fast recovery area disk group.
                      1.    Navigate to the Grid home bin directory, and start ASM Configuration Assistant (ASMCA).
                            For example:
                            DRIVE_LETTER:\> cd \app\oracle\product\19.0.0\grid\bin
                            DRIVE_LETTER:\> asmca
                      2.    ASMCA opens at the Disk Groups tab. Click Create to create a disk group.
                      3.    The Create Disk Groups window opens.
                            In the Disk Group Name field, enter a descriptive name for the fast recovery area group.
                            For example: FRA.
                            In the Redundancy section, select the level of redundancy you want to use.
                            In the Select Member Disks field, select the eligible disks to be added to the fast recovery
                            area, and click OK.
                      4.    The Diskgroup Creation window opens to inform you when the disk group creation is
                            complete. Click OK.
                      5.    Click Exit.



                                See Also
                                •    Oracle Database Backup and Recovery User's Guide
                                •    Oracle Automatic Storage Management Administrator's Guide



Database Installation Guide
E96293-13                                                                                                 November 12, 2025
Copyright © 2015, 2025, Oracle and/or its affiliates.                                                         Page 11 of 14
                                                                                                                                 Chapter 8
                                                                                Enabling and Disabling Database Options After Installation




Enabling and Disabling Database Options After Installation
                      When you install Oracle Database, some options are enabled and the others disabled. You can
                      view the enabled Oracle Database options by querying the V$OPTION view using SQL*Plus.

                      If you need to enable or disable a particular database feature for an Oracle home, then use the
                      chopt tool. The chopt tool is a command-line utility that is located in the ORACLE_HOME\bin
                      directory. The syntax for chopt is as follows:
                      chopt [ enable | disable] db_option

                      The possible values for db_option are described in the following table:

                      Table 8-1       Database Options for Chopt Tool Command

                       Value                            Description
                       olap                             Oracle OLAP
                       rat                              Oracle Real Application Testing



                                Note
                                The Oracle Advanced Analytics (OAA) feature is enabled by default for Oracle
                                Database. You cannot disable it using the chopt tool.


                      Example 8-1          Running the Chopt Tool
                      To enable the Oracle Real Application Testing option in your Oracle binary files:
                      1.    Shut down the database with srvctl or SQL*Plus:

                            srvctl stop database -d myDb

                      2.    Stop the database service, OracleServiceSID, using the Services program in Control
                            Panel.
                      3.    Run the following commands:

                            cd ORACLE_HOME/bin
                            chopt enable rat

                      4.    Start the database service, OracleServiceSID, using the Services program in Control
                            Panel.
                      5.    Start up the database:

                            srvctl start database -d myDb




Database Installation Guide
E96293-13                                                                                                             November 12, 2025
Copyright © 2015, 2025, Oracle and/or its affiliates.                                                                     Page 12 of 14
                                                                                                                   Chapter 8
                                                                                     Changing the Oracle Home User Password




Changing the Oracle Home User Password
                      Oracle Home User Control is a command-line utility that allows an administrator to update the
                      password for an Oracle Home User.
                      This tool updates the password for Windows services in the Oracle home. The input password
                      must match the password for the Windows User Account used as the Oracle Home User. So,
                      first use the Windows operating system tools to change the Windows password and then use
                      this tool to update the Windows services in the Oracle home to use the same password.


                                Note
                                You must have the Administrator privileges to run this Oracle Home User Control
                                utility.



                      Syntax Overview:
                      The following is the command syntax:
                      orahomeuserctl list | updpwd [-user username] [-host hostname1, hostname2, . . .] [-log
                      logfilename]

                      where:
                      •     orahomeuserctl is used to display the Oracle Home User name associated with the
                            current Oracle home or to update the Oracle Home User password.
                      •     list displays the Oracle Home User name associated with the current Oracle home.
                      •     updpwd prompts for the new password and updates the password for the named Oracle
                            Service User. The following are the options for updpwd:
                            –    -user username
                                 This option determines the Oracle Home User name. If this option is not present, then
                                 the user name associated with the current Oracle home is used. If the named user, be
                                 it the username or user of the current Oracle home, is an MSA or Windows Built-in
                                 account, then an error message is displayed and the command is terminated.
                            –    -host hostname1, hostname2,. . .
                                 When this option is present, the utility updates the passwords for all the services
                                 belonging to the named Oracle Home User on the specified hosts. Otherwise, the
                                 Oracle Home User Control utility updates the passwords for all the services belonging
                                 to the named Oracle Home User on a specified host with single instance installation, or
                                 updates the passwords for all services belonging to the named Oracle Home User on
                                 all the specified hosts.
                                 When the update completes, the utility displays the number of successful updates and
                                 any services that failed to update with the new password.
                            –    -log logfilename
                                 This option adds the password update operation results to a log file for every service
                                 name receiving the new password. By default, the log files are located in the
                                 ORACLE_HOME\log directory. If logfilename specifies only a file name, then the log is
                                 stored in the named file in the default directory. However, if the logfilename contains a
                                 path, then that path is used without modification.


Database Installation Guide
E96293-13                                                                                                 November 12, 2025
Copyright © 2015, 2025, Oracle and/or its affiliates.                                                         Page 13 of 14
                                                                                      Chapter 8
                                                        Changing the Oracle Home User Password




Database Installation Guide
E96293-13                                                                    November 12, 2025
Copyright © 2015, 2025, Oracle and/or its affiliates.                            Page 14 of 14
9
Getting Started with Oracle Database
                      Learn how to check the installed contents, start various tools, identify, and locate various files
                      after completing Oracle Database installation.


                      •     Checking the Installed Oracle Database Contents and Directory Location
                            Use Oracle Universal Installer to check the contents and directory location of your Oracle
                            Database installation.
                      •     Logging In to Oracle Enterprise Manager Database Express 19c
                            To start Oracle Enterprise Manager Database Express, use the EM Express URL provided
                            by Oracle Database Configuration Assistant (Oracle DBCA) during the database
                            installation and creation.
                      •     Managing Oracle Automatic Storage Management
                            Describes about starting and stopping Oracle Automatic Storage Management.
                      •     Starting and Stopping an Oracle Database
                            Describes about starting and stopping an Oracle database by using any of the following
                            methods:
                      •     Accessing Oracle Database with SQL*Plus
                            You can use SQL*Plus to issue SQL and PL/SQL statements to the Oracle Database.
                      •     Accessing Oracle Database with Oracle SQL Developer
                            You can use SQL Developer to issue SQL and PL/SQL statements. All SQL and PL/SQL
                            commands are supported as they are passed directly from the SQL Worksheet to the
                            Oracle Database.
                      •     Reviewing User Accounts and Passwords
                            All databases created by the Oracle Database Configuration Assistant include the SYS,
                            SYSTEM, and DBSNMP database accounts.
                      •     Identifying Databases
                            The Oracle Database software identifies a database by its global database name.
                      •     Locating the Server Parameter File
                            The starter database contains one database initialization response file. The initialization
                            response file, init.ora.xxxxx, must exist for an instance to start.
                      •     Identifying Tablespaces and Data Files
                            An Oracle Database is divided into smaller logical areas of space known as tablespaces.
                      •     Locating Redo Log Files
                            The preconfigured database uses three redo log files. Redo log files record all changes
                            made to data in the database buffer cache.
                      •     Locating Control Files
                            The preconfigured database contains two control files located in the
                            ORACLE_BASE\oradata\DB_NAME directory.
                      •     Understanding Oracle Database Services on Windows
                            The following Oracle services are automatically started after installation when you create a
                            database:



Database Installation Guide
E96293-13                                                                                                 November 12, 2025
Copyright © 2015, 2025, Oracle and/or its affiliates.                                                          Page 1 of 15
                                                                                                                         Chapter 9
                                                            Checking the Installed Oracle Database Contents and Directory Location




Checking the Installed Oracle Database Contents and Directory
Location
                      Use Oracle Universal Installer to check the contents and directory location of your Oracle
                      Database installation.


                      Follow these steps:
                      1.    From the Start menu, select All apps, then Oracle - HOMENAME, then Oracle
                            Installation Products, then Universal Installer.
                      2.    In the Welcome window, click Installed Products to display the Inventory dialog box.
                      3.    To check the installed contents, find the Oracle Database product in the list.
                            To find additional information about an installed product, click Details.
                      4.    To check the directory location of the installed contents, click the Environment tab.
                      5.    Click Close to exit the Inventory dialog box.
                      6.    Click Cancel to exit Oracle Universal Installer, then click Yes to confirm.


Logging In to Oracle Enterprise Manager Database Express 19c
                      To start Oracle Enterprise Manager Database Express, use the EM Express URL provided by
                      Oracle Database Configuration Assistant (Oracle DBCA) during the database installation and
                      creation.
                      If Oracle DBCA did not provide the EM Express URL during the database installation and
                      creation, or if you need to change the EM Express port later on, then see the following:



                                See Also
                                •    Oracle Database 2 Day DBA for information about “Starting EM Express”
                                •    Oracle Database 2 Day DBA for information about “Accessing the Database Home
                                     Page”
                                •    Oracle Database 2 Day DBA for information about “Configuring the HTTP Port for
                                     EM Express"




Managing Oracle Automatic Storage Management
                      Describes about starting and stopping Oracle Automatic Storage Management.


                      •     Starting and Stopping Oracle Automatic Storage Management
                            To start and stop Oracle Automatic Storage Management, in addition to using SQL*Plus,
                            you can use the srvctl utility.




Database Installation Guide
E96293-13                                                                                                      November 12, 2025
Copyright © 2015, 2025, Oracle and/or its affiliates.                                                               Page 2 of 15
                                                                                                                 Chapter 9
                                                                             Managing Oracle Automatic Storage Management


                      •     Oracle Automatic Storage Management Utilities
                            To manage Oracle Automatic Storage Management, you can use the following tools:


Starting and Stopping Oracle Automatic Storage Management
                      To start and stop Oracle Automatic Storage Management, in addition to using SQL*Plus, you
                      can use the srvctl utility.



                      To start Oracle Automatic Storage Management instance using the srvctl utility, run the
                      following command:
                      srvctl start asm

                      To stop Oracle Automatic Storage Management instance using the srvctl utility, run the
                      following command:
                      srvctl stop asm




                                See Also
                                Oracle Automatic Storage Management Administrator's Guide




Oracle Automatic Storage Management Utilities
                      To manage Oracle Automatic Storage Management, you can use the following tools:


                      •     asmcmd: This command-line tool lets you manage Oracle Automatic Storage Management
                            disk group files and directories.
                      •     asmtool: This command-line tool is required to stamp the disks to create or modify disk
                            groups later on after the database installation.
                      •     Oracle Automatic Storage Management Configuration Assistant: Oracle Automatic Storage
                            Management Configuration Assistant (ASMCA) is an interactive utility that enables you to
                            create an Oracle Automatic Storage Management instance or upgrade existing Oracle
                            Automatic Storage Management instances. It also enables you to create and configure
                            disk groups, Oracle Automatic Storage Management volumes and Oracle Automatic
                            Storage Management File Systems (ASMFS).
                      •     Oracle Enterprise Manager Cloud Control: If you have Oracle Enterprise Manager
                            installed, you can use Cloud Control to manage Oracle ASM functions, such as migrating
                            an existing database to Oracle ASM, checking the status of the Oracle ASM instance,
                            checking the performance of the Oracle ASM disk groups, and creating or dropping Oracle
                            ASM disk groups.
                      •     Oracle Enterprise Manager Database Express 19c. This utility enables you to perform
                            basic administrative tasks such as user, performance, memory, and space management.
                      •     SQL*Plus: You can use Oracle Automatic Storage Management-specific commands from
                            this tool. To connect to the Oracle Automatic Storage Management instance, you use the
                            same methods that you use to connect to an Oracle Database instance.




Database Installation Guide
E96293-13                                                                                               November 12, 2025
Copyright © 2015, 2025, Oracle and/or its affiliates.                                                        Page 3 of 15
                                                                                                                      Chapter 9
                                                                                       Starting and Stopping an Oracle Database



                                See Also
                                Oracle Automatic Storage Management Administrator's Guide




Starting and Stopping an Oracle Database
                      Describes about starting and stopping an Oracle database by using any of the following
                      methods:


                      •     Starting and Stopping the Database from the Microsoft Windows Services Utility
                            You can use SQL or srvctl utility to start or stop the database instance. SRVCTL starts
                            the service automatically.


Starting and Stopping the Database from the Microsoft Windows Services
Utility
                      You can use SQL or srvctl utility to start or stop the database instance. SRVCTL starts the
                      service automatically.


                      To use SQL to start the database instance, start the Windows services:
                      1.    From the Start menu, select All Programs, then Administrative Tools, and then
                            Services.
                      2.    In the Services dialog box, locate the name of the database you want to start or stop.
                      3.    Right-click the name of the database, and from the menu, select either Start, Stop, or
                            Pause.
                            To set its startup properties, right-click Properties, and in the dialog box, select either
                            Automatic, Manual, or Disabled from the Startup type list.


Accessing Oracle Database with SQL*Plus
                      You can use SQL*Plus to issue SQL and PL/SQL statements to the Oracle Database.
                      This tool enables you to perform the same database management operations, and query,
                      insert, update, or delete data directly in the database.
                      To start SQL*Plus, from the Start menu, select All Programs, then Oracle - HOMENAME,
                      then Application Development, and then SQL Plus.
                      Alternatively, at the command line, you can enter the following command at a Windows
                      command prompt:
                      C:\> sqlplus /nolog
                      SQL> CONNECT user_name
                      Enter password: password

                      For example, to log on as SYSTEM using the password password, you enter:




Database Installation Guide
E96293-13                                                                                                   November 12, 2025
Copyright © 2015, 2025, Oracle and/or its affiliates.                                                            Page 4 of 15
                                                                                                                      Chapter 9
                                                                            Accessing Oracle Database with Oracle SQL Developer

                      C:\> sqlplus /nolog
                      SQL> CONNECT SYSTEM
                      Enter password: password

                      If you are logging on as SYS, you must connect as SYSDBA:
                      C:\> sqlplus /nolog
                      SQL> CONNECT SYS AS SYSDBA
                      Enter password: password




                                See Also
                                •      SQL*Plus User's Guide and Reference
                                •      SQL*Plus Quick Reference
                                •      Oracle Database Administrator's Guide




Accessing Oracle Database with Oracle SQL Developer
                      You can use SQL Developer to issue SQL and PL/SQL statements. All SQL and PL/SQL
                      commands are supported as they are passed directly from the SQL Worksheet to the Oracle
                      Database.
                      All SQL and PL/SQL commands are supported as they are passed directly from the SQL
                      Worksheet to the Oracle Database.
                      To start SQL Developer:
                      1.    From the Start menu, select All Programs, then Oracle - HOMENAME, then Application
                            Development, and then SQL Developer.
                      2.    If you are prompted to enter the full path name for java.exe, click Browse and find
                            java.exe. For example, C:\Program Files\Java\jdk1.6.0_25\bin\java.exe.
                      3.    Once SQL Developer starts, perform the following steps:
                            •       Right-click Connections.
                            •       Select New Connection.
                            •       In the New/Select Database Connection dialog box, enter a Connection name,
                                    username, password, and for the host string, the name of the database to which you
                                    want to connect.
                            •       Click Connect.
                      Once connected, you can view, create, modify, and delete the database objects using the
                      Connection Navigator or issue any SQL or PL/SQL command using a SQL Worksheet (From
                      the Tools menu, select SQL Worksheet).
                      SQL*Plus commands have to be interpreted by the SQL Worksheet before being passed to the
                      database. The SQL Worksheet currently supports many SQL*Plus commands. SQL*Plus
                      commands which are not supported by the SQL Worksheet are ignored and are not sent to the
                      Oracle Database.




Database Installation Guide
E96293-13                                                                                                    November 12, 2025
Copyright © 2015, 2025, Oracle and/or its affiliates.                                                             Page 5 of 15
                                                                                                                  Chapter 9
                                                                                     Reviewing User Accounts and Passwords



                                See Also
                                Oracle SQL Developer User's Guide




Reviewing User Accounts and Passwords
                      All databases created by the Oracle Database Configuration Assistant include the SYS, SYSTEM,
                      and DBSNMP database accounts.

                      In addition, Oracle provides several other administrative accounts. Before using these other
                      accounts, you must unlock them and reset their passwords.
                      Use Oracle EM Express to view the complete list of database accounts.
                      •     Oracle Database System Privileges Accounts and Passwords
                            Review these system privileges accounts after installation in preparation for unlocking
                            accounts and changing passwords.
                      •     Unlocking and Resetting User Passwords
                            Passwords for all Oracle system administration accounts except SYS, SYSTEM, and DBSNMP
                            are revoked after installation.
                      •     Using EM Express to Unlock Accounts and Reset Passwords
                            To unlock and reset user account passwords using Oracle Enterprise Manager Database
                            Express, click Help in the Oracle Enterprise Manager Database Express 18c window for
                            more information.
                      •     Using SQL*Plus to Unlock and Change Passwords
                            Use this SQL*Plus procedure to unlock and reset user account passwords.


                                See Also
                                Oracle Database Administrator's Guide




Oracle Database System Privileges Accounts and Passwords
                      Review these system privileges accounts after installation in preparation for unlocking
                      accounts and changing passwords.
                      All databases created by the Database Configuration Assistant (DBCA) include the SYS,
                      SYSTEM, and DBSNMP database accounts. In addition, Oracle Database provides several other
                      administrative accounts. Before using these accounts, you must unlock them and reset their
                      passwords.
                      Starting with Oracle Database 12c Release 2 (12.2), only the HR sample schema is
                      automatically installed after a database installation. All sample schemas, including HR, are
                      distributed on GitHub:
                      https://github.com/oracle/db-sample-schemas




Database Installation Guide
E96293-13                                                                                               November 12, 2025
Copyright © 2015, 2025, Oracle and/or its affiliates.                                                        Page 6 of 15
                                                                                                                              Chapter 9
                                                                                              Reviewing User Accounts and Passwords



                                Note
                                This list contains some of the important system privileges user accounts, but it is not
                                complete. Use Oracle Enterprise Manager Database Express 12c to view the
                                complete list of database accounts.



                      Table 9-1 Partial List of Oracle Database System Privileges Accounts Locked After
                      Installation

                       User Name                   Description                                      For More Information
                       ANONYMOUS                   Enables HTTP access to Oracle XML DB.            Oracle XML DB Developer's
                                                                                                    Guide
                       APEX_050100                 The account that owns the Oracle Application     Oracle Application Express App
                                                   Express schema and metadata.                     Builder User’s Guide
                       APEX_PUBLIC_USER The minimally privileged account used for     Oracle Application Express App
                                        Oracle Application Express configuration with Builder User’s Guide
                                        Oracle Application Express Listener or Oracle
                                        HTTP Server and mod_plsql.
                       APPQOSSYS                   Used for storing and managing all data and       None
                                                   metadata required by Oracle Quality of
                                                   Service Management.
                       AUDSYS                      The account where the unified audit data trail   Oracle Database Security Guide
                                                   resides.
                       CTXSYS                      The Oracle Text account.                         Oracle Text Application
                                                                                                    Developer's Guide
                       DBSFWUSER                   The account used to run the                      Oracle Database PL/SQL
                                                   DBMS_SFW_ACL_ADMIN package.                      Packages and Types Reference
                       DBSNMP                      The account used by the Management Agent         Oracle Enterprise Manager
                                                   component of Oracle Enterprise Manager to        Cloud Control Administrator's
                                                   monitor and manage the database.                 Guide
                       DIP                         The account used by the Directory Integration None
                                                   Platform (DIP) to synchronize the changes in
                                                   Oracle Internet Directory with the applications
                                                   in the database.
                       DVSYS                       There are two roles associated with this         Oracle Database Vault
                                                   account. The Database Vault owner role           Administrator's Guide
                                                   manages the Database Vault roles and
                                                   configurations. The Database Vault Account
                                                   Manager is used to manage database user
                                                   accounts.
                                                   Note: Part of Oracle Database Vault user
                                                   interface text is stored in database tables in
                                                   the DVSYS schema. By default, only the
                                                   English language is loaded into these tables.
                                                   You can use the
                                                   DVSYS.DBMS_MACADM.ADD_NLS_DATA
                                                   procedure to add other languages to Oracle
                                                   Database Vault.
                       DVF                         The account owned by Database Vault that         Oracle Database Vault
                                                   contains public functions to retrieve the        Administrator's Guide
                                                   Database Vault Factor values.




Database Installation Guide
E96293-13                                                                                                          November 12, 2025
Copyright © 2015, 2025, Oracle and/or its affiliates.                                                                   Page 7 of 15
                                                                                                                           Chapter 9
                                                                                              Reviewing User Accounts and Passwords



                      Table 9-1 (Cont.) Partial List of Oracle Database System Privileges Accounts Locked
                      After Installation

                       User Name                   Description                                     For More Information
                       FLOWS_FILES                 The account owns the Oracle Application         Oracle Application Express App
                                                   Express uploaded files.                         Builder User’s Guide
                       GGSYS                       The internal account used by Oracle             None
                                                   GoldenGate. It should not be unlocked or
                                                   used for a database login.
                       GSMADMIN_INTERN The internal account that owns the Global                   Oracle Database Global Data
                       AL              Data Services schema. It should not be                      Services Concepts and
                                       unlocked or used for a database login.                      Administration Guide
                       GSMCATUSER                  The account used by Global Service Manager Oracle Database Global Data
                                                   to connect to the Global Data Services     Services Concepts and
                                                   catalog.                                   Administration Guide
                       GSMUSER                     The account used by Global Service Manager Oracle Database Global Data
                                                   to connect to the database.                Services Concepts and
                                                                                              Administration Guide
                       HR                          The account that owns the Human Resources Oracle Database Sample
                                                   schema included in the Oracle Sample      Schemas
                                                   Schemas.
                       LBACSYS                     The Oracle Label Security administrator         Oracle Label Security
                                                   account. Starting with Oracle Database 18c,     Administrator’s Guide
                                                   the LBACSYS user account is created as a
                                                   schema-only account.
                       MDDATA                      The schema used by Oracle Spatial and           Oracle Spatial and Graph
                                                   Graph for storing geocoder and router data.     Developer's Guide
                       MDSYS                       The Oracle Spatial and Graph administrator      Oracle Spatial and Graph
                                                   account.                                        Developer's Guide
                       OUTLN                       The account that supports plan stability. Plan None
                                                   stability enables you to maintain the same
                                                   execution plans for the same SQL statements.
                                                   OUTLN acts as a role to centrally manage
                                                   metadata associated with stored outlines.
                       ORACLE_OCM                  This account contains the instrumentation for   None
                                                   configuration collection used by the Oracle
                                                   Configuration Manager.
                       REMOTE_SCHEDUL              The account to disable remote jobs on a         Oracle Database
                       ER_AGENT                    database. This account is created during the Administrator’s Guide
                                                   remote scheduler agent configuration. You
                                                   can disable the capability of a database to run
                                                   remote jobs by dropping this user.
                       SYS                         The account used to perform database            Oracle Database
                                                   administration tasks.                           Administrator’s Guide
                       SYSTEM                      Another account used to perform database        Oracle Database
                                                   administration tasks.                           Administrator’s Guide
                       SYSBACKUP                   The account used to perform backup and          Oracle Database
                                                   recovery tasks.                                 Administrator’s Guide
                       SYSKM                       The account used to perform encryption key      Oracle Database
                                                   management.                                     Administrator’s Guide
                       SYSDG                       The account used to administer and monitor      Oracle Database
                                                   Oracle Data Guard.                              Administrator’s Guide


Database Installation Guide
E96293-13                                                                                                        November 12, 2025
Copyright © 2015, 2025, Oracle and/or its affiliates.                                                                 Page 8 of 15
                                                                                                                        Chapter 9
                                                                                           Reviewing User Accounts and Passwords



                      Table 9-1 (Cont.) Partial List of Oracle Database System Privileges Accounts Locked
                      After Installation

                       User Name                   Description                                  For More Information
                       SYSRAC                      The account used to administer Oracle Real   Oracle Database
                                                   Application Clusters (RAC).                  Administrator’s Guide
                       SYS$UMF                     The account used to administer Remote        Oracle Database Performance
                                                   Management Framework, including the          Tuning Guide
                                                   remote Automatic Workload Repository
                                                   (AWR).
                       WMSYS                       The account used to store the metadata       Oracle Database Workspace
                                                   information for Oracle Workspace Manager.    Manager Developer's Guide
                       XDB                         The account used for storing Oracle XML DB   Oracle XML DB Developer’s
                                                   data and metadata.                           Guide
                       XS$NULL                     The internal account that represents the    Oracle Database Real
                                                   absence of a database schema user in a      Application Security
                                                   session, and indicates an application user  Administrator's and Developer's
                                                   session is in use. XS$NULL cannot be        Guide
                                                   authenticated to a database, nor can it own
                                                   any database schema objects, or possess any
                                                   database privileges.

                      Except for the accounts provided with the Oracle Sample Schemas, most of these database
                      accounts are locked by default and created without passwords as schema only. This prevents
                      malicious users from logging into these accounts using the default password set during catalog
                      creation. To find the status of an account, query the AUTHENTICATION_TYPE column of the
                      DBA_USERS data dictionary view. If AUTHENTICATION_TYPE is schema only, then the status
                      is NONE.

                      Many of these accounts are automatically created when you run standard scripts such as the
                      various cat*.sql scripts. To find user accounts that are created and maintained by Oracle,
                      query the USERNAME and ORACLE_MAINTAINED columns of the ALL_USERS data dictionary view. If
                      the output for ORACLE_MAINTAINED is Y, then you must not modify the user account except by
                      running the script that was used to create it.
                      Related Topics
                      •     Oracle Database Security Guide
                      •     Oracle Database Sample Schemas


Unlocking and Resetting User Passwords
                      Passwords for all Oracle system administration accounts except SYS, SYSTEM, and DBSNMP are
                      revoked after installation.
                      Before you use a locked account, you must unlock it and reset its password. If you created a
                      preconfigured database during the installation, but you did not unlock accounts required to use
                      the database, then you must unlock and reset those accounts using these procedures.
                      Apply the following guidelines when specifying passwords:
                      •     Passwords must be between 8 and 30 characters long.
                      •     Passwords must not start with a numeral.
                      •     Password cannot contain invalid characters: ! @ % ^ & * ( ) + = \ | ` ~ [ { ] } ; : ' " , < > ?


Database Installation Guide
E96293-13                                                                                                     November 12, 2025
Copyright © 2015, 2025, Oracle and/or its affiliates.                                                              Page 9 of 15
                                                                                                                   Chapter 9
                                                                                      Reviewing User Accounts and Passwords


                      •     Passwords must not be the same as the user name.
                      •     Passwords must not be Oracle reserved words.
                      •     The SYSTEM account password cannot be manager
                            (case-insensitive).
                      •     The SYSMAN account password cannot be sysman
                            (case-insensitive).
                      •     The DBSNMP account password cannot be dbsnmp
                            (case-insensitive).
                      •     If you choose to use the same password for all the accounts, then that password cannot be
                            manager, sysman, or dbsnmp
                            (case-insensitive).
                      •     Passwords must have at least one alphabetic, one numeric, and one special character.
                      •     Passwords must not be simple or obvious words, such as welcome, account, database,
                            and user.


                                Note
                                If you select the option to create the database as a multitenant container database,
                                then you must provide the pluggable database administrator password.



                      If you created a starter database during the installation, but you did not unlock the required
                      account, unlock the account using one of the following methods:



                                See Also
                                Oracle Database Administrator's Guide




Using EM Express to Unlock Accounts and Reset Passwords
                      To unlock and reset user account passwords using Oracle Enterprise Manager Database
                      Express, click Help in the Oracle Enterprise Manager Database Express 18c window for more
                      information.



                                See Also
                                Oracle Database 2 Day DBA




Database Installation Guide
E96293-13                                                                                                November 12, 2025
Copyright © 2015, 2025, Oracle and/or its affiliates.                                                        Page 10 of 15
                                                                                                                 Chapter 9
                                                                                                    Identifying Databases



Using SQL*Plus to Unlock and Change Passwords
                      Use this SQL*Plus procedure to unlock and reset user account passwords.


                      To change a password after installation:
                      1.    Start SQL*Plus:
                            C:\> sqlplus /nolog
                      2.    Connect as SYSDBA:
                            SQL> CONNECT SYS AS SYSDBA
                            Enter password: SYS_password
                      3.    Enter a command similar to the following, where account is the user account to unlock and
                            password is the new password:
                            SQL> ALTER USER account IDENTIFIED BY password ACCOUNT UNLOCK;



                                See Also

                                •    Oracle Database Security Guide
                                •    Oracle Database SQL Language Reference
                                •    Oracle Database Administrator's Guide




Identifying Databases
                      The Oracle Database software identifies a database by its global database name.
                      A global database name consists of the database name and database domain. Usually, the
                      database domain is the same as the network domain, but it need not be. The global database
                      name uniquely distinguishes a database from any other database in the same network. You
                      specify the global database name when you create a database during the installation, or when
                      using Oracle Database Configuration Assistant.
                      The database name input field is used to set the DB_NAME, DB_UNIQUE_NAME, and DB_DOMAIN
                      Oracle initialization parameter values.
                      For example:
                      sales_world.example.com

                      In this example:
                      •     sales_world is the name of the database. The database name (DB_UNIQUE_NAME) portion is
                            a string of no more than 30 characters that can contain ASCII alphanumeric, underscore
                            (_), dollar ($), and pound (#) characters but must begin with an alphabetic character. No
                            other special characters are permitted in a database name.
                      •     sales_wo is the DB_NAME. The DB_NAME initialization parameter specifies a database
                            identifier of up to eight characters.




Database Installation Guide
E96293-13                                                                                             November 12, 2025
Copyright © 2015, 2025, Oracle and/or its affiliates.                                                     Page 11 of 15
                                                                                                                     Chapter 9
                                                                                            Locating the Server Parameter File


                      •     example.com is the network domain in which the database is located. Together, the
                            database name and the network domain make the global database name unique. The
                            domain portion is a string of no more than 128 characters that can contain alphanumeric,
                            underscore (_), and pound (#) characters. The DB_DOMAIN initialization parameter specifies
                            the domain name.
                      However, the DB_NAME parameter need not necessarily be the first eight characters of
                      DB_UNIQUE_NAME.

                      The DB_UNIQUE_NAME parameter and the DB_DOMAIN name parameter combine to create the
                      global database name value assigned to the SERVICE_NAMES parameter in the initialization
                      parameter file.
                      The System Identifier (SID) identifies a specific database instance. The SID uniquely
                      distinguishes the instance from any other instance on the same computer. Each database
                      instance requires a unique SID and database name.
                      For example, if the SID and database name for an Oracle database are ORCL, then each
                      database file is located in the ORACLE_BASE\oradata\orcl directory, and the initialization
                      response file is located in the ORACLE_BASE\admin\orcl\pfile directory.



                                See Also
                                Oracle Database Reference




Locating the Server Parameter File
                      The starter database contains one database initialization response file. The initialization
                      response file, init.ora.xxxxx, must exist for an instance to start.

                      A response file is a text file that contains a list of instance configuration parameters. The starter
                      database init.ora file has preconfigured parameters. You must not edit this file to use the
                      starter database.
                      The server parameter file (SPFILE) is created from the initialization response file, then the
                      initialization response file is renamed. The SPFILE file name is spfileSID.ora and is located
                      in the ORACLE_HOME\database directory.

                      To use EM Express to view the location of the server parameter file and list the initialization
                      parameters, see the "Viewing and Modifying Initialization Parameters" section in Oracle
                      Database 2 Day DBA.



                                See Also
                                Oracle Database 2 Day DBA




Database Installation Guide
E96293-13                                                                                                  November 12, 2025
Copyright © 2015, 2025, Oracle and/or its affiliates.                                                          Page 12 of 15
                                                                                                                        Chapter 9
                                                                                           Identifying Tablespaces and Data Files




Identifying Tablespaces and Data Files
                      An Oracle Database is divided into smaller logical areas of space known as tablespaces.
                      Each tablespace corresponds to one or more physical data files. Data files contain the
                      contents of logical database structures such as tables and indexes. A data file can be
                      associated with only one tablespace and database.
                      The following table lists the tablespaces and data files in the Oracle Database. By default, the
                      data files are located in the ORACLE_BASE\oradata\DB_NAME directory:

                      Table 9-2       Tablespaces and Data Files

                       Tablespace           Data File        Description
                       EXAMPLE              EXAMPLE01.DBF    Stores the Sample Schemas, if you included them.
                       SYSAUX               SYSAUX01.DBF     Serves as an auxiliary tablespace to the SYSTEM tablespace.
                                                             Some products and options that previously used the SYSTEM
                                                             tablespace now use the SYSAUX tablespace to reduce the load
                                                             on the SYSTEM tablespace.
                       SYSTEM               SYSTEM01.DBF     Stores the data dictionary, including definitions of tables, views,
                                                             and stored procedures needed by the Oracle Database.
                                                             Information in this area is maintained automatically.
                       TEMP                 TEMP01.DBF       Stores temporary tables and indexes created during the
                                                             processing of your SQL statement. If you run a SQL statement
                                                             that involves a lot of sorting, such as the constructs GROUP BY,
                                                             ORDER BY, or DISTINCT, then you must expand this tablespace.
                       UNDOTBS              UNDOTBS01.DBF    Stores undo information. This contains one or more undo
                                                             segments that maintain transaction history that is used to roll
                                                             back, or undo, changes to the database.
                                                             All starter databases are configured to run in automatic undo
                                                             management mode.
                       USERS                USERS01.DBF      Stores database objects created by database users.




                                See Also
                                •    Oracle Database Concepts
                                •    Oracle Database Administrator's Guide
                                •    Oracle Database 2 Day DBA




Locating Redo Log Files
                      The preconfigured database uses three redo log files. Redo log files record all changes made
                      to data in the database buffer cache.
                      If an instance fails, then Oracle Database uses the redo log files to recover the modified data in
                      memory.




Database Installation Guide
E96293-13                                                                                                     November 12, 2025
Copyright © 2015, 2025, Oracle and/or its affiliates.                                                             Page 13 of 15
                                                                                                                     Chapter 9
                                                                                                        Locating Control Files


                      Oracle Database uses redo log files in a cyclical fashion. For example, if three files constitute
                      the online redo log, Oracle Database fills the first file, then the second file, and then the third
                      file. In the next cycle, it reuses and fills the first file, the second file, and so on.




                                See Also
                                •    Oracle Database 2 Day DBA about Viewing Online Redo Log File Information
                                •    Oracle Database 2 Day DBA about Viewing Archived Redo Log File Information
                                •    Oracle Database 2 Day DBA
                                •    Oracle Database Backup and Recovery User's Guide




Locating Control Files
                      The preconfigured database contains two control files located in the
                      ORACLE_BASE\oradata\DB_NAME directory.

                      The preconfigured database contains two control files located in the
                      ORACLE_BASE\oradata\DB_NAME directory. Oracle recommends that you keep at least two
                      control files (on separate physical drives) for each database, and set the CONTROL_FILES
                      initialization parameter to list each control file.
                      A control file is an administrative file. Oracle Database requires a control file to start and run
                      the database. The control file defines the physical structure of the database. For example, it
                      defines the database name and the names and locations of the database data files and redo
                      log files.




                                See Also
                                Oracle Database Administrator's Guide



                      For more information about using Oracle Enterprise Manager Database Express to perform
                      various tasks related to tablespaces and data files, redo log files, and control files, click Help in
                      the Oracle Enterprise Manager Database Express window.



                                See Also
                                •    Oracle Database Administrator's Guide
                                •    Oracle Database 2 Day DBA for information about “Viewing Control File”




Database Installation Guide
E96293-13                                                                                                 November 12, 2025
Copyright © 2015, 2025, Oracle and/or its affiliates.                                                         Page 14 of 15
                                                                                                                 Chapter 9
                                                                         Understanding Oracle Database Services on Windows




Understanding Oracle Database Services on Windows
                      The following Oracle services are automatically started after installation when you create a
                      database:
                      •     OracleServiceSID (Oracle Database service)
                      •     OracleHOMENAMETNSListener (Oracle Database listener service)
                      If you configured Oracle Automatic Storage Management, then the OracleOHService and
                      OracleASMService+ASM services are listed as well. However, other services for networking or
                      other individual components may not automatically start.




Database Installation Guide
E96293-13                                                                                               November 12, 2025
Copyright © 2015, 2025, Oracle and/or its affiliates.                                                       Page 15 of 15
10
Removing Oracle Database Software
                      These topics describe how to remove Oracle software and configuration files.
                      Use the deinstall command that is included in Oracle homes to remove Oracle software.
                      Oracle does not support the removal of individual products or components.


                                Caution
                                If you have a standalone database on a node in a cluster and you have multiple
                                databases with the same global database name (GDN), then you cannot use the
                                deinstallation tool to remove one database only.




                      •     About Oracle Deinstallation Options
                            The deinstall.bat command stops Oracle software, and removes Oracle software and
                            configuration files on the operating system.
                      •     Files Deleted by the deinstall Command
                            The deinstall command removes Oracle software and files from your system.
                      •     Deinstallation Examples for Oracle Database
                            Use these examples to help you understand how to run the deinstall command.


                                See Also
                                •    Oracle Grid Infrastructure Installation and Upgrade Guide for Microsoft Windows
                                •    Oracle Real Application Clusters Installation Guide for Microsoft Windows
                                •    Oracle Automatic Storage Management Administrator's Guide




About Oracle Deinstallation Options
                      The deinstall.bat command stops Oracle software, and removes Oracle software and
                      configuration files on the operating system.


                      You can remove the following software using deinstall:

                      •     Oracle Database
                      •     Oracle Grid Infrastructure, which includes Oracle Clusterware and Oracle Automatic
                            Storage Management (Oracle ASM)
                      •     Oracle Real Application Clusters (Oracle RAC)
                      •     Oracle Database Client



Database Installation Guide
E96293-13                                                                                               November 12, 2025
Copyright © 2015, 2025, Oracle and/or its affiliates.                                                         Page 1 of 5
                                                                                                                    Chapter 10
                                                                                        Files Deleted by the deinstall Command


                      The deinstall command is available in Oracle home directories after installation. It is located in
                      the ORACLE_HOME\deinstall directory.

                      The deinstallation tool uses the information you provide, plus information gathered from the
                      software home to create a response file. You can alternatively supply a response file generated
                      previously by the deinstall command using the –checkonly option, or by editing the response
                      file template.


                                Note
                                •    You must run the deinstall command from the same release to remove Oracle
                                     software. Do not run the deinstall command from a later release to remove
                                     Oracle software from an earlier release. For example, do not run the deinstall
                                     command from the 19c Oracle home to remove Oracle software from an existing
                                     12.2 Oracle home
                                •    Starting with Oracle Database 12c Release 1 (12.1.0.2), the roothas.bat script
                                     replaces the roothas.pl script in the Oracle Grid Infrastructure home for Oracle
                                     Restart, and the rootcrs.bat script replaces the rootcrs.pl script in the Grid
                                     home for Oracle Grid Infrastructure for a cluster.



                      If the software in the Oracle home is not running (for example, after an unsuccessful
                      installation), then the deinstallation tool cannot determine the configuration, and you must
                      provide all the configuration details either interactively or in a response file.
                      In addition, before you run deinstall for Oracle Grid Infrastructure installations:

                      •     Dismount Oracle Automatic Storage Management Cluster File System (Oracle ACFS) and
                            disable Oracle Automatic Storage Management Dynamic Volume Manager (Oracle
                            ADVM).
                      •     If Grid Naming Service (GNS) is in use, then notify your DNS administrator to delete the
                            subdomain entry from the DNS.



                                See Also
                                Oracle Real Application Clusters Installation Guide for Microsoft Windows x64 (64-Bit)
                                for information about the -local option




Files Deleted by the deinstall Command
                      The deinstall command removes Oracle software and files from your system.

                      When you run deinstall, if the central inventory (Inventory) contains no other registered
                      homes besides the home that you are deconfiguring and removing, then the deinstall
                      removes the following files and directory contents in the Oracle base directory of the Oracle
                      Database installation owner:
                      •     admin
                      •     cfgtoollogs
                      •     checkpoints



Database Installation Guide
E96293-13                                                                                                  November 12, 2025
Copyright © 2015, 2025, Oracle and/or its affiliates.                                                            Page 2 of 5
                                                                                                                  Chapter 10
                                                                                 Deinstallation Examples for Oracle Database


                      •     diag
                      •     oradata
                      •     fast_recovery_area
                      Oracle strongly recommends that you configure your installations using an Optimal Flexible
                      Architecture (OFA) configuration, and that you reserve Oracle base and Oracle home paths for
                      exclusive use of Oracle software. If you have any user data in these locations in the Oracle
                      base that is owned by the user account that owns the Oracle software, then deinstall deletes
                      this data.


                                Caution
                                The deinstall command deletes Oracle Database configuration files, user data, and
                                fast recovery area (FRA) files even if they are located outside of the Oracle base
                                directory path.



Deinstallation Examples for Oracle Database
                      Use these examples to help you understand how to run the deinstall command.

                      Run deinstall from the ORACLE_HOME\deinstall directory. The deinstallation starts without
                      prompting you for the Oracle home path.
                      You can generate a deinstallation response file by running deinstall with the -checkonly
                      flag. Alternatively, you can use the response file template located at DRIVE_LETTER:\>
                      ORACLE_HOME/deinstall/response/deinstall.rsp.tmpl.

                      In the following example, the deinstall command is in the path
                      C:\app\oracle\product\19.0.0\dbhome_1\deinstall, and it uses a response file in
                      the software owner location C:\Documents and Settings\oracle\:
                      DRIVE_LETTER:\> cd \app\oracle\product\19.0.0\dbhome_1\deinstall\
                      DRIVE_LETTER:\> deinstall.bat -paramfile %HOMEPATH%\my_db_paramfile.tmpl

                      For the grid infrastructure home, use (deinstall.bat) in the Oracle Grid Infrastructure home.
                      In this example, the Oracle Grid Infrastructure home is
                      C:\app\oracle\product\19.0.0\grid
                      DRIVE_LETTER:\> cd \app\oracle\product\19.0.0\grid\deinstall\
                      DRIVE_LETTER:\> deinstall.bat -paramfile %HOMEPATH%\my_grid_paramfile.tmpl

                      •     Downgrading Oracle Restart
                            Use this procedure to deconfigure and downgrade Oracle Restart, or to troubleshoot
                            Oracle Restart installation errors.


Downgrading Oracle Restart
                      Use this procedure to deconfigure and downgrade Oracle Restart, or to troubleshoot Oracle
                      Restart installation errors.
                      Running roothas.bat with the command flags -deconfig -force enables you to
                      deconfigure Oracle Restart without removing the installed binaries. This feature is useful if you
                      encounter an error during an Oracle Grid Infrastructure for a standalone server installation. For
                      example, when you run the root.sh command, and find a missing operating system package.



Database Installation Guide
E96293-13                                                                                                November 12, 2025
Copyright © 2015, 2025, Oracle and/or its affiliates.                                                          Page 3 of 5
                                                                                                                    Chapter 10
                                                                                   Deinstallation Examples for Oracle Database


                      By running roothas.bat -deconfig -force, you can deconfigure Oracle Restart, correct
                      the cause of the error, and then run root.sh again.

                      1.    As the oracle user, create a backup of the SPFILE to a PFILE.

                            CREATE PFILE='C:\app\oracle\product\19.0.0\dbhome_1\dbs\test_init.ora'
                            FROM SPFILE='C:\oracle\dbs\test_spfile.ora';

                      2.    List all the Oracle databases on the server with their version, unique name of the
                            database, and Oracle home information.

                            C:\> srvctl config database -home

                      3.    Downgrade Oracle Database. Refer to Oracle Database Upgrade Guide for more
                            information about required pre-downgrade tasks, downgrade tasks, post-downgrade tasks,
                            and compatibility information.


                                     Note
                                     Downgrade Oracle Database only if the Oracle Database version is higher than
                                     the Oracle Restart version to which you are downgrading Oracle Restart.

                      4.    As the oracle user, downgrade the Oracle Restart resources if you have downgraded your
                            Oracle Database.

                            C:\> srvctl downgrade database -d db_unique_name -oraclehome %ORACLE_HOME%
                            -t to_version

                      5.    Inspect the Oracle Restart configuration of each database, service, and listener.

                            C:\> srvctl config database -db db_unique_name
                            C:\> srvctl config service -db db_unique_name
                            C:\> srvctl config listener -listener listener_name


                            Make a note of the configuration information and use this information when adding the
                            components back to Oracle Restart.
                      6.    Stop all databases and listeners that are running before you deconfigure or downgrade
                            Oracle Restart.

                            C:\> srvctl stop database -db db_unique_name
                            C:\> srvctl stop listener [-listener listener_name]

                      7.    As the root user, run roothas.bat with the -deconfig -force flags to deconfigure
                            Oracle Restart.

                            C:\> C:\app\oracle\product\19.0.0\grid\crs\install\roothas.bat -deconfig -
                            force

                      8.    As the grid user, update the Oracle central inventory (oraInventory).

                            C:\> C:\app\oracle\product\19.0.0\grid\oui\bin\gridSetup.bat -
                            updateNodeList -silent ORACLE_HOME=upgraded_Grid_home -local CRS=false



Database Installation Guide
E96293-13                                                                                                  November 12, 2025
Copyright © 2015, 2025, Oracle and/or its affiliates.                                                            Page 4 of 5
                                                                                                                     Chapter 10
                                                                                    Deinstallation Examples for Oracle Database


                      9.    As the root user, run roothas.bat with the -unlock flag to unlock the previous release
                            Oracle Restart home.


                            C:\> C:\app\oracle\product\18.0.0\grid\crs\install\roothas.bat -unlock -
                            dstcrshome previous_release_Grid_home

                      10. As the grid user, reconfigure the previous release Oracle Restart home using the
                            gridSetup.bat command.

                            C:\> C:\app\oracle\product\18.0.0\grid\gridSetup.bat

                      11. As the oracle user, add the components back to Oracle Restart with the same attributes
                            that you noted down before deconfiguring Oracle Restart.
                            a.   Add Oracle Database to the Oracle Restart configuration.

                                 C:\> srvctl add database -db db_unique_name -oraclehome Oracle_home

                            b.   Add the listener to the Oracle Restart configuration.

                                 C:\> srvctl add listener -listener listener_name -oraclehome Oracle_home


                                 For the -oraclehome parameter, provide the Oracle home path from which the listener
                                 was running before the downgrade.
                            c.   Add each service to the database, using the srvctl add service command.

                                 C:\> srvctl add service -db db_unique_name -service service_name_list

                      Related Topics
                      •     Oracle Database Upgrade Guide




Database Installation Guide
E96293-13                                                                                                   November 12, 2025
Copyright © 2015, 2025, Oracle and/or its affiliates.                                                             Page 5 of 5
A
Installing Java Access Bridge
                      Learn how to install Java Access Bridge 2.0.2. Java Access Bridge 2.0.2 enables use of a
                      screen reader with Oracle components:


                      •     Overview of Java Access Bridge 2.0.2
                            Java Access Bridge 2.0.2 enables assistive technologies to read Java applications running
                            on the Windows platform.
                      •     Setting Up Java Access Bridge 2.0.2
                            Learn how to install and configure Java Access Bridge 2.0.2 for Windows after installing
                            Oracle components.


Overview of Java Access Bridge 2.0.2
                      Java Access Bridge 2.0.2 enables assistive technologies to read Java applications running on
                      the Windows platform.
                      Assistive technologies can read Java-based interfaces, such as Oracle Universal Installer and
                      Oracle Enterprise Manager Database Express.
                      For a list of supported system configurations, including supported versions of Microsoft
                      Windows and Java SE, see section "Supported System Configuration" available at the
                      following link location:
                      http://docs.oracle.com

                      During installation, Oracle Universal Installer uses the Java Runtime Environment (JRE) 1.8
                      contained in an Oracle Database installation media. The JRE enables the use of Java Access
                      Bridge during installation.


Setting Up Java Access Bridge 2.0.2
                      Learn how to install and configure Java Access Bridge 2.0.2 for Windows after installing Oracle
                      components.
                      To set up Java Access Bridge 2.0.2 on a Windows 64-bit operating system, follow these steps:
                      1.    Go to Java Standard Edition 2 (Java SE) Downloads page to download the latest build of
                            JDK 8:
                            http://docs.oracle.com
                      2.    Install JDK 8 after accepting the Oracle license agreement.


                                     Note
                                     You must have administrator privileges to install JDK on Windows.




Database Installation Guide
E96293-13                                                                                                November 12, 2025
Copyright © 2015, 2025, Oracle and/or its affiliates.                                                    Appendix A-1 of A-2
                                                                                                                  Appendix A
                                                                                         Setting Up Java Access Bridge 2.0.2


                      3.    Download and install screen reader, JAWS:
                            http://www.freedomscientific.com/downloads/jaws/JAWS-downloads.asp
                      4.    Press Windows key+U to open the Ease of Access Center, and select Use the computer
                            without a display.
                      5.    Select Enable Accessbridge check box. Click Save to save the changes.
                      6.    Download Java Access Bridge 2.0.2:
                            http://docs.oracle.com
                            Download the accessbridge-2_0_2-fcs-bin-b06.zip file, after accepting the Oracle
                            license agreement.
                      7.    Extract accessbridge-2.0.2 to a directory on your system where you plan to install Java
                            Access Bridge. For example, name the directory as follows:
                            AB_HOME
                      8.    Copy AB_HOME\WindowsAccessBridge-64.dll to c:\windows\system32 and start the
                            screen reader.
                      9.    Open the command prompt and navigate to setup.exe file.
                      10. Run the following command once you are in the Disk1 directory:

                            setup.exe
                            Oracle Universal Installer starts and JAWS is able to read all prompts and controls on the
                            screen.
                      11. Once you click the Install button, you must open Windows Explorer to see the directory
                            where the database is installed
                            (DRIVE_LETTER:\app\username\product\19.0.0\dbhome_1), until the JDK folder is
                            created. Once the JDK folder is created, you must copy the files from the Java Access
                            Bridge source location to the JDK destination folder. Copying these files enables
                            accessibility for both the Oracle Database Configuration Assistant and Oracle Net
                            Configuration Assistant.

                            Table A-1       Copy Files to JDK Directory on Windows 64-Bit

                            Copy                                          To
                            AB_HOME\JavaAccessBridge-64.dll               dbhome_1\jdk\jre\bin
                            AB_HOME\JAWTAccessBridge-64.dll               dbhome_1\jdk\jre\bin
                            AB_HOME\Accessibility.properties              dbhome_1\jdk\jre\lib
                            AB_HOME\Access-bridge-64.jar                  dbhome_1\jdk\jre\lib\ext
                            AB_HOME\jaccess.jar                           dbhome_1\jdk\jre\lib\ext




Database Installation Guide
E96293-13                                                                                                November 12, 2025
Copyright © 2015, 2025, Oracle and/or its affiliates.                                                    Appendix A-2 of A-2
B
Optimal Flexible Architecture
                      Oracle Optimal Flexible Architecture (OFA) rules are a set of configuration guidelines created
                      to ensure well-organized Oracle installations, which simplifies administration, support and
                      maintenance.
                      •     About the Optimal Flexible Architecture Standard
                            Oracle Optimal Flexible Architecture (OFA) rules help you to organize database software
                            and configure databases to allow multiple databases, of different versions, owned by
                            different users to coexist.
                      •     About Multiple Oracle Homes Support
                            Oracle Database supports multiple Oracle homes. You can install this release or earlier
                            releases of the software more than once on the same system, in different Oracle home
                            directories.
                      •     Oracle Base Directory Naming Convention
                            This section describes what the Oracle base is, and how it functions.
                      •     Oracle Home Directory Naming Convention
                            By default, Oracle Universal Installer configures Oracle home directories using these
                            Oracle Optimal Flexible Architecture conventions.
                      •     Optimal Flexible Architecture File Path Examples
                            This topic shows examples of hierarchical file mappings of an Optimal Flexible
                            Architecture-compliant installation.


About the Optimal Flexible Architecture Standard
                      Oracle Optimal Flexible Architecture (OFA) rules help you to organize database software and
                      configure databases to allow multiple databases, of different versions, owned by different users
                      to coexist.
                      In earlier Oracle Database releases, the OFA rules provided optimal system performance by
                      isolating fragmentation and minimizing contention. In current releases, OFA rules provide
                      consistency in database management and support, and simplifies expanding or adding
                      databases, or adding additional hardware.
                      By default, Oracle Universal Installer places Oracle Database components in directory
                      locations and with permissions in compliance with OFA rules. Oracle recommends that you
                      configure all Oracle components on the installation media in accordance with OFA guidelines.
                      Oracle recommends that you accept the OFA default. Following OFA rules is especially of
                      value if the database is large, or if you plan to have multiple databases.


                                Note
                                OFA assists in identification of an ORACLE_BASE with its Automatic Diagnostic
                                Repository (ADR) diagnostic data to properly collect incidents.




Database Installation Guide
E96293-13                                                                                              November 12, 2025
Copyright © 2015, 2025, Oracle and/or its affiliates.                                                  Appendix B-1 of B-6
                                                                                                                  Appendix B
                                                                                         About Multiple Oracle Homes Support




About Multiple Oracle Homes Support
                      Oracle Database supports multiple Oracle homes. You can install this release or earlier
                      releases of the software more than once on the same system, in different Oracle home
                      directories.
                      Careful selection of mount point names can make Oracle software easier to administer.
                      Configuring multiple Oracle homes in compliance with Optimal Flexible Architecture (OFA)
                      rules provides the following advantages:
                      •     You can install this release, or earlier releases of the software, more than once on the
                            same system, in different Oracle home directories. However, you cannot install products
                            from one release of Oracle Database into an Oracle home directory of a different release.
                            For example, you cannot install Oracle Database 19c software into an existing Oracle 18c
                            Oracle home directory.
                      •     Multiple databases, of different versions, owned by different users can coexist concurrently.
                      •     You must install a new Oracle Database release in a new Oracle home that is separate
                            from earlier releases of Oracle Database.
                            You cannot install multiple releases in one Oracle home. Oracle recommends that you
                            create a separate Oracle Database Oracle home for each release, in accordance with the
                            Optimal Flexible Architecture (OFA) guidelines.
                      •     In production, the Oracle Database server software release must be the same as the
                            Oracle Database dictionary release through the first four digits (the major, maintenance,
                            and patch release number).
                      •     Later Oracle Database releases can access earlier Oracle Database releases. However,
                            this access is only for upgrades. For example, Oracle Database 19c can access an Oracle
                            Database 18c if the 18c database is started up in upgrade mode.
                      •     Oracle Database Client can be installed in the same Oracle Database home if both
                            products are at the same release level. For example, you can install Oracle Database
                            Client 12.2.0.1 into an existing Oracle Database 12.2.0.1 home but you cannot install
                            Oracle Database Client 12.2.0.1 into an existing Oracle Database 12.1.0.2 home. If you
                            apply a patch set before installing the client, then you must apply the patch set again.
                      •     Structured organization of directories and files, and consistent naming for database files
                            simplify database administration.
                      •     Login home directories are not at risk when database administrators add, move, or delete
                            Oracle home directories.
                      •     You can test software upgrades in an Oracle home in a separate directory from the Oracle
                            home where your production database is located.


Oracle Base Directory Naming Convention
                      This section describes what the Oracle base is, and how it functions.
                      The Oracle Base directory is the database home directory for Oracle Database installation
                      owners and the log file location for Oracle Grid Infrastructure owners. You should name Oracle
                      base directories using the syntax \pm\h\u, where pm is a string mount point name, h is
                      selected from a small set of standard directory names, and u is the name of the owner of the
                      directory.
                      You can use the same Oracle base directory for multiple installations. If different operating
                      system users install Oracle software on the same system, then you must create a separate

Database Installation Guide
E96293-13                                                                                                November 12, 2025
Copyright © 2015, 2025, Oracle and/or its affiliates.                                                    Appendix B-2 of B-6
                                                                                                                              Appendix B
                                                                                            Oracle Home Directory Naming Convention


                      Oracle base directory for each installation owner. For ease of administration, Oracle
                      recommends that you create a unique owner for each Oracle software installation owner, to
                      separate log files.
                      Because all Oracle installation owners write to the central Oracle inventory file, and that file
                      mount point is in the same mount point path as the initial Oracle installation, Oracle
                      recommends that you use the same \pm\h path for all Oracle installation owners.

                      Table B-1       Examples of OFA-Compliant Oracle Base Directory Names

                       Example                  Description
                                                Oracle base directory for Oracle Database , where the Oracle Database software
                       C:\app\oracle            installation owner name is oracle. The Oracle Database binary home is located
                                                underneath the Oracle base path.

                                                Oracle base directory for Oracle Grid Infrastructure, where the Oracle Grid
                       C:\app\grid              Infrastructure software installation owner name is grid.



                                                                           Caution
                                                                           The Oracle Grid Infrastructure Oracle base should not
                                                                           contain the Oracle Grid Infrastructure binaries for an
                                                                           Oracle Grid Infrastructure for a cluster installation.
                                                                           Permissions for the file path to the Oracle Grid
                                                                           Infrastructure binary home is changed to
                                                                           LocalSystem or the Oracle Home User, if specified,
                                                                           during installation.




Oracle Home Directory Naming Convention
                      By default, Oracle Universal Installer configures Oracle home directories using these Oracle
                      Optimal Flexible Architecture conventions.
                      The directory pattern syntax for Oracle homes is \pm\s\u\product\v\type_[n]. The
                      following table describes the variables used in this syntax:


                       Variable                 Description
                       pm                       A mount point name.
                       s                        A standard directory name.
                       u                        The name of the owner of the directory.
                       v                        The version of the software.
                       type                     The type of installation. For example: Database (dbhome), Client (client), or
                                                Oracle Grid Infrastructure (grid)
                       n                        An optional counter, which enables you to install the same product more than once
                                                in the same Oracle base directory. For example: Database 1 and Database 2
                                                (dbhome_1, dbhome_2)




Database Installation Guide
E96293-13                                                                                                         November 12, 2025
Copyright © 2015, 2025, Oracle and/or its affiliates.                                                             Appendix B-3 of B-6
                                                                                                                             Appendix B
                                                                                        Optimal Flexible Architecture File Path Examples


                      For example, the following path is typical for the first installation of Oracle Database on this
                      system:

                      C:\app\oracle\product\19.0.0\dbhome_1



Optimal Flexible Architecture File Path Examples
                      This topic shows examples of hierarchical file mappings of an Optimal Flexible Architecture-
                      compliant installation.
                      D:\E:\F:\


                                Note
                                •    The Grid homes are examples of Grid homes used for an Oracle Grid
                                     Infrastructure for a standalone server deployment (Oracle Restart), or a Grid home
                                     used for an Oracle Grid Infrastructure for a cluster deployment (Oracle
                                     Clusterware). You can have either an Oracle Restart deployment, or an Oracle
                                     Clusterware deployment. You cannot have both options deployed at the same
                                     time.
                                •    Oracle Automatic Storage Management (Oracle ASM) is included as part of an
                                     Oracle Grid Infrastructure installation. Oracle recommends that you use Oracle
                                     ASM to provide greater redundancy and throughput.



Table B-2       Optimal Flexible Architecture Hierarchical File Path Examples

Directory                            Description
                                     System directory
C:\


                                     Subtree for application software
C:\app\


                                     Central OraInventory directory, which maintains information about Oracle installations on a
C:\app\oraInventory                  server. Members of the group designated as the OINSTALL group have permissions to write
                                     to the central inventory. All Oracle software installation owners must have the OINSTALL
                                     group as their primary group, and be able to write to this group.
                                     Oracle base directory for user oracle. There can be many Oracle Database installations on
C:\app\oracle\                       a server, and many Oracle Database software installation owners.
                                     Oracle software homes that an Oracle installation owner owns should be located in the
                                     Oracle base directory for the Oracle software installation owner, unless that Oracle software
                                     is Oracle Grid Infrastructure deployed for a cluster.
                                     Oracle base directory for the Oracle Grid Infrastructure software, where username is the
C:\app\grid\username                 name of the user that performed the software installation. The Oracle home (Grid home) for
                                     Oracle Grid Infrastructure for a cluster installation is located outside of the Grid user. There
                                     can be only one Grid home on a server, and only one Grid software installation owner.
                                     The Grid home contains log files and other administrative files.




Database Installation Guide
E96293-13                                                                                                           November 12, 2025
Copyright © 2015, 2025, Oracle and/or its affiliates.                                                               Appendix B-4 of B-6
                                                                                                                         Appendix B
                                                                                    Optimal Flexible Architecture File Path Examples



Table B-2       (Cont.) Optimal Flexible Architecture Hierarchical File Path Examples

Directory                            Description
                                     Subtree for database administration files
C:\app\oracle\admin\


                                     Subtree for support log files
C:\app\oracle\admin\T
AR


                                     admin subtree for database named “sales”
C:\app\oracle\admin\d
b_sales\


                                     admin subtree for database named “dwh”
C:\app\oracle\admin\d
b_dwh\


                                     Subtree for recovery files
C:\app\oracle\fast_re
covery_area\


                                     Recovery files for database named “sales”
C:\app\oracle\fast_re
covery_area\db_sales


                                     Recovery files for database named “dwh”
C:\app\oracle\fast_re
covery_area\db_dwh


                                     Oracle data file directories
D:\app\oracle\oradata
E:\app\oracle\oradata
F:\app\oracle\oradata


                                     Common path for Oracle software products other than Oracle Grid Infrastructure for a
C:\app\oracle\product                cluster.
\


                                     Oracle home directory for Oracle Database 1, owned by Oracle Database installation owner
C:\app\oracle\product                account oracle.
\19.0.0\dbhome_1




Database Installation Guide
E96293-13                                                                                                       November 12, 2025
Copyright © 2015, 2025, Oracle and/or its affiliates.                                                           Appendix B-5 of B-6
                                                                                                                          Appendix B
                                                                                     Optimal Flexible Architecture File Path Examples



Table B-2       (Cont.) Optimal Flexible Architecture Hierarchical File Path Examples

Directory                            Description
                                     Oracle home directory for Oracle Database 2, owned by Oracle Database installation owner
C:\app\oracle\product                account oracle
\19.0.0\dbhome_2


                                     Oracle home directory for Oracle Database 2, owned by Oracle Database installation owner
C:\app\oradbowner\pro                account oradbowner.
duct\19.0.0\dbhome_2


                                     Oracle home directory for Oracle Grid Infrastructure for a standalone server, owned by
C:\app\oracle\product                Oracle Database and Oracle Grid Infrastructure installation owner oracle.
\19.0.0\grid


                                     Oracle home directory for Oracle Grid Infrastructure for a cluster (Grid home), owned by user
C:\app\19.0.0\grid                   grid before installation, and owned by root after installation.


                                     Oracle Clusterware log files
C:\app\grid\username\
diag\crs\hostname\crs
\trace




Database Installation Guide
E96293-13                                                                                                        November 12, 2025
Copyright © 2015, 2025, Oracle and/or its affiliates.                                                            Appendix B-6 of B-6
C
Installing and Configuring Oracle Database
Using Response Files
                      Learn how to install and configure Oracle products using response files.


                      •     How Response Files Work
                            Response files can assist you with installing an Oracle product multiple times on multiple
                            computers.
                      •     Using Response Files
                            Review this information to use response files.
                      •     Preparing a Response File
                            Learn about the methods that you can use to prepare a response file for use during silent-
                            mode or response file-mode installations.
                      •     Running Oracle Universal Installer Using the Response File
                            At this stage, you are ready to run Oracle Universal Installer at the command line,
                            specifying the response file you created, to perform the installation.
                      •     Running Net Configuration Assistant Using a Response File
                            When you run Net Configuration Assistant with a response file, you run it in a silent mode.
                      •     Running Oracle Database Configuration Assistant Using a Response File
                            You can run Oracle Database Configuration Assistant (Oracle DBCA) in a silent or a
                            response file mode to configure and start an Oracle database on your system.
                      •     Postinstallation Configuration Using Response File Created During Installation
                            To run a response file configuration after installing Oracle software:
                      •     Postinstallation Configuration Using the ConfigToolAllCommands Script
                            You can create and run a response file configuration after installing Oracle software. The
                            configToolAllCommands script requires users to create a second response file, of a
                            different format than the one used for installing the product.
                      •     Using the Installation Response File for Postinstallation Configuration
                            Starting with Oracle Database 12c release 2 (12.2), you can use the response file created
                            during installation to also complete postinstallation configuration.


How Response Files Work
                      Response files can assist you with installing an Oracle product multiple times on multiple
                      computers.
                      When you start Oracle Universal Installer (OUI), you can use a response file to automate the
                      installation and configuration of Oracle software, either fully or partially. OUI uses the values
                      contained in the response file to provide answers to some or all installation prompts.
                      Typically, the installer runs in an interactive mode, which means that it prompts you to provide
                      information on the graphical user interface (GUI). When you use response files to provide this
                      information, you run Oracle Universal Installer at a command prompt using either of the
                      following modes:


Database Installation Guide
E96293-13                                                                                               November 12, 2025
Copyright © 2015, 2025, Oracle and/or its affiliates.                                                  Appendix C-1 of C-11
                                                                                                                     Appendix C
                                                                            Reasons for Using Silent Mode or Response File Mode


                      •     Silent mode: If you include responses for all of the prompts in the response file and
                            specify the -silent option when starting the installer, then it runs in the silent mode.
                            During a silent mode installation, the installer does not display any screens. Instead, it
                            displays progress information in the terminal that you used to start it.
                      •     Response file mode: If you include responses for some or all of the prompts in the
                            response file and omit the -silent option, then the installer runs in the response file mode.
                            During a response file mode installation, the installer displays all the screens. The screens
                            for which you specify information in the response file, and for those which you did not
                            specify the required information in the response file. To use the response file mode, run
                            setup.exe without the -silent parameter, but include the response file or any other
                            parameters that apply.
                      You define the settings for a silent or a response file installation by entering values for the
                      variables listed in the response file. For instance, to specify the Oracle home, provide the
                      appropriate value for the ORACLE_HOME variable, as in the following example:
                      ORACLE_HOME="C:\app\product"

                      Another way of specifying the response file variable settings is to pass them as command-line
                      arguments when you run Oracle Universal Installer. For example:
                      DRIVE_LETTER:\setup.exe_location> setup -silent "ORACLE_HOME=C:\app\product" ...

                      This method supports only the Oracle Home User passwords.


Reasons for Using Silent Mode or Response File Mode
Using Response Files
                      Review this information to use response files.


                      Use the following general steps to install and configure Oracle products using the installer in
                      silent or response file mode:
                      1.    If you plan to use Oracle Automatic Storage Management and configure new disks, then
                            you must perform the following steps:
                            a.   Create partitions for DAS or SAN disks.
                            b.   Manually configure the disks using the asmtoolg or asmtool utility.
                      2.    Customize or create a response file for the installation settings that you need.
                            You can create the response file by using one of the following methods:
                            •    Modify one of the sample response files that is provided with the installation.
                            •    Run Oracle Universal Installer at a command prompt and save the inputs by selecting
                                 the Save Response File option.
                      3.    Run Oracle Universal Installer from a command prompt, specifying the response file, using
                            either silent or response file mode.


                                     Note
                                     Windows requires Administrator privileges at the command prompt.



Database Installation Guide
E96293-13                                                                                                   November 12, 2025
Copyright © 2015, 2025, Oracle and/or its affiliates.                                                      Appendix C-2 of C-11
                                                                                                                          Appendix C
                                                                                                           Preparing a Response File




Preparing a Response File
                      Learn about the methods that you can use to prepare a response file for use during silent-
                      mode or response file-mode installations.
                      •     Editing a Response File Template
                      •     Saving a Response File


Editing a Response File Template
                      Oracle provides response file templates for each product and the installation type, and for each
                      configuration tool. These files are located in the ORACLE_BASE\ORACLE_HOME\assistants
                      directory, and the database\response directory on the Oracle Database installation media.


                                Note
                                If you copied the software to a hard disk, the response files are located in the
                                stage_area\database\response directory.



                      The following table lists the available sample response files:
                      All response file templates contain comment entries, sample formats, examples, and other
                      useful instructions. Read the response file instructions to understand how to specify values for
                      the response file variables, so that you can customize your installation.

                      Table C-1       Response Files

                       Response File Name                         Description
                       db_install.rsp                             Silent installation of Oracle Database
                       grid_install.rsp                           Silent installation of Oracle Grid Infrastructure
                       dbca.rsp                                   Silent installation of Database Configuration Assistant
                       netca.rsp                                  Silent installation of Oracle Net Configuration Assistant



                                Caution
                                When you modify a response file template and save a file for use, the response file
                                may contain plain text passwords. Ownership of the response file must be given to the
                                Oracle software installation owner only. Oracle strongly recommends that database
                                administrators or other administrators delete or secure response files when they are
                                not in use.



                      To copy and modify a response file:
                      1.    Copy the appropriate response files from the database\response directory on the Oracle
                            Database media to your hard drive.
                      2.    Modify the response files with a text file editor.



Database Installation Guide
E96293-13                                                                                                        November 12, 2025
Copyright © 2015, 2025, Oracle and/or its affiliates.                                                           Appendix C-3 of C-11
                                                                                                                    Appendix C
                                                                                                     Preparing a Response File


                      3.    Run the response file.


Saving a Response File
                      You can use the Oracle Universal Installer in an interactive mode to save a response file, which
                      you can edit and then use to complete a silent mode or a response file mode installation.
                      Starting with Oracle Database 11g Release 2 (11.2), you can save all the installation steps into
                      a response file during installation by clicking Save Response File on the Summary page. You
                      can use the generated response file for a silent installation later.
                      When you save the response file, you can either complete the installation, or you can exit from
                      Oracle Universal Installer on the Summary page, before it starts to copy the software to the
                      system.


                                 Note
                                 Oracle Universal Installer does not save passwords in the response file.



                      To save a response file:
                      1.    Ensure that the computer on which you are creating the response file has met the
                            requirements described in Oracle Database Preinstallation Tasks.
                            When you run Oracle Universal Installer to save a response file, it checks the system to
                            verify that it meets the requirements to install the software. For this reason, Oracle
                            recommends that you complete all of the required preinstallation tasks and save the
                            response file while completing an installation.
                      2.    At the command prompt, use the cd command to change to the directory that contains the
                            Oracle Universal Installer setup.exe executable.


                                     Note
                                     Windows requires the Administrator privileges at the command prompt.



                            On the installation DVD, setup.exe is located in the database directory. Alternatively,
                            navigate to the directory where you downloaded or copied the installation files.
                      3.    Run setup.exe.
                      4.    After Oracle Universal Installer starts, enter the installation settings, to save the response
                            file.
                      5.    When the installer displays the Summary screen, perform the following:
                            a.   Click Save Response File and specify a file name and location for the response file.
                                 Then, click Save to save the values to the file.
                            b.   Click Finish to continue with the installation.
                                 Click Cancel if you do not want to continue with the installation. The installation stops,
                                 but the saved response file is retained.
                      6.    Before you use the saved response file on another system, edit the file and make any
                            required changes.



Database Installation Guide
E96293-13                                                                                                  November 12, 2025
Copyright © 2015, 2025, Oracle and/or its affiliates.                                                     Appendix C-4 of C-11
                                                                                                                        Appendix C
                                                                         Running Oracle Universal Installer Using the Response File


                            Use the instructions in the file as a guide when editing it.


Running Oracle Universal Installer Using the Response File
                      At this stage, you are ready to run Oracle Universal Installer at the command line, specifying
                      the response file you created, to perform the installation.
                      On Windows, open the command prompt with Administrator privileges. The Oracle Universal
                      Installer executable, setup.exe, provides several options. For help information about the full
                      set of these options, run setup.exe with the -help option, for example:

                      DRIVE_LETTER:\setup.exe_location setup -help

                      A new command window with the "Preparing to launch..." message appears.
                      To run Oracle Universal Installer, and specify a response file:
                      1.    Place the response file on the computer where you want to install Oracle Database.
                      2.    At a command prompt, run Oracle Universal Installer with the appropriate response file. On
                            Windows, you must open command prompt with the Administrator privileges. For example:


                            DRIVE_LETTER:\setup.exe_location setup [-silent] "variable=setting" [-nowelcome] [-
                            noconfig] [-nowait] -responseFile
                             filename

                            where:
                            •    filename: Identifies the full path of the response file.
                            •    setup.exe_location: Indicates the location of setup.exe.
                            •    -silent: Runs Oracle Universal Installer in silent mode and suppresses the Welcome
                                 window.
                            •    "variable=setting" refers to a variable within the response file that you may prefer to
                                 run at the command line rather than set in the response file. Enclose the variable and
                                 its setting in quotes.
                            •    -noconfig: Suppresses running the configuration assistants during installation,
                                 performing a software-only installation instead.
                            •    -nowait: Closes the console window when the silent installation completes.
                            If you save a response file during a silent installation, then Oracle Universal Installer saves
                            the variable values that were specified in the original source response file into the new
                            response file.


Running Net Configuration Assistant Using a Response File
                      When you run Net Configuration Assistant with a response file, you run it in a silent mode.
                      This lets you configure and start an Oracle Net listener on the system, configure naming
                      methods, and configure Oracle Net service names. To run NetCA in a silent mode, use the
                      netca.rsp response file in the ORACLE_BASE\ORACLE_HOME\assistants\netca directory, and
                      the response directory in the database\response directory on the DVD.




Database Installation Guide
E96293-13                                                                                                      November 12, 2025
Copyright © 2015, 2025, Oracle and/or its affiliates.                                                         Appendix C-5 of C-11
                                                                                                                          Appendix C
                                                               Running Oracle Database Configuration Assistant Using a Response File



                                Note
                                If you copied the software to a hard disk, the response files are located in the
                                stage_area\database\response directory.



                      On Windows, you must open command prompt with the Administrator privileges.
                      To create a Net Configuration Assistant response file:
                      1.    Copy the netca.rsp response file template from the response file directory to a directory
                            on your system.
                            The netca.rsp is located in the database\response directory on the Oracle Database
                            installation media.
                      2.    Open the response file in a text editor.
                      3.    Edit the file, following the instructions in the file.
                            Net Configuration Assistant fails if you do not correctly configure the netca.rsp response
                            file.
                      To run Net Configuration Assistant using the response file you just created, run Net
                      Configuration Assistant in silent mode as follows, replacing local_dir with the directory where
                      you placed your version of the netca.rsp response file:
                      C:\ORACLE_HOME\bin> netca /silent /responsefile local_dir\netca.rsp

                      For example:
                      C:\ORACLE_HOME\bin> netca /silent /responsefile
                      C:\oracle_response_files\mynetca.rsp


Running Oracle Database Configuration Assistant Using a
Response File
                      You can run Oracle Database Configuration Assistant (Oracle DBCA) in a silent or a response
                      file mode to configure and start an Oracle database on your system.
                      To run Oracle Database Configuration Assistant in silent or response file mode, use the
                      dbca.rsp response file in the ORACLE_BASE\ORACLE_HOME\assistants\netca directory, and the
                      response directory in the database\response directory on the DVD.


                                Note
                                If you copied the software to a hard disk, the response files are located in the
                                stage_area\database\response directory.



                      To run Oracle DBCA in a response file mode, you must use the -responseFile flag with the -
                      silent flag. To run Oracle DBCA in response file mode, you must use a graphical display and
                      set the DISPLAY environment variable.

                      On Windows, you must open the command prompt with Administrator privileges.



Database Installation Guide
E96293-13                                                                                                        November 12, 2025
Copyright © 2015, 2025, Oracle and/or its affiliates.                                                           Appendix C-6 of C-11
                                                                                                                         Appendix C
                                                              Running Oracle Database Configuration Assistant Using a Response File


                      •     Silent Mode of Database Configuration Assistant
                            Use the -silent flag in combination with the -responseFile flag to set the mode to silent.
                      •     Running Oracle Database Configuration Assistant in Response File Mode
                            Use this procedure to run Oracle Database Configuration Assistant (Oracle DBCA) in
                            response file mode.


                                See Also

                                •    Oracle Database Administrator's Guide
                                •    Oracle Automatic Storage Management Administrator's Guide



Silent Mode of Database Configuration Assistant
                      Use the -silent flag in combination with the -responseFile flag to set the mode to silent.

                      In the silent mode, Database Configuration Assistant uses values that you specify, in the
                      response file or as command-line options, to create a database. No window or user interface is
                      displayed in the silent mode.


Running Oracle Database Configuration Assistant in Response File Mode
                      Use this procedure to run Oracle Database Configuration Assistant (Oracle DBCA) in response
                      file mode.
                      To create an Oracle DBCA response file:
                      1.    Copy the dbca.rsp response file template from the response file directory to a directory on
                            your system.
                            The dbca.rsp response file is located in the database\response directory on the Oracle
                            Database installation media.
                      2.    Open the dbca.rsp response file in a text editor.
                      3.    Edit the dbca.rsp file, following the instructions in the file.
                            Oracle DBCA fails if you do not correctly configure the dbca.rsp response file.
                      To run the Oracle DBCA using the response file you just created, run Oracle DBCA in a silent
                      or a response file mode using the following syntax:
                      C:\> %ORACLE_HOME%\bin\dbca [-silent] -createDatabase -responseFile local_dir/dbca.rsp

                      where:
                      •     -createDatabase creates Oracle Database.
                      •     -silent runs Oracle Database Configuration Assistant in the silent mode.
                      •     local_dir is the full path of the directory where you copied the dbca.rsp response file
                            template.
                      For example:
                      C:\> %ORACLE_HOME%\bin\dbca -createDatabase -responseFile
                      C:\oracle_response_files\mydbca.rsp




Database Installation Guide
E96293-13                                                                                                       November 12, 2025
Copyright © 2015, 2025, Oracle and/or its affiliates.                                                          Appendix C-7 of C-11
                                                                                                                           Appendix C
                                                        Postinstallation Configuration Using Response File Created During Installation


                      As an alternative to creating a database using a response file, you can run dbca at the
                      command line by specifying all the required information as command line options. Database
                      Configuration Assistant writes progress messages to stdout. For information about the list of
                      options supported, enter the following command:
                      C:\ORACLE_HOME\bin\dbca -help


Postinstallation Configuration Using Response File Created
During Installation
                      To run a response file configuration after installing Oracle software:
                      •     About the Postinstallation Configuration File
                            When you run a silent or a response file installation, you provide information about your
                            servers in a response file that you otherwise provide manually during a graphical user
                            interface installation.
                      •     Running Postinstallation Configuration Using Response File
                            Use this procedure to run postinstallation configuration using response file.


About the Postinstallation Configuration File
                      When you run a silent or a response file installation, you provide information about your
                      servers in a response file that you otherwise provide manually during a graphical user interface
                      installation.
                      However, the response file does not contain passwords for user accounts that configuration
                      assistants require after software installation is complete. The configuration assistants are
                      started with a script called configToolAllCommands. You can run this script in the response file
                      mode by using a password response file. The script uses the passwords to run the
                      configuration tools in succession to complete the configuration.
                      If you keep the password file to use for clone installations, then Oracle strongly recommends
                      that you store it in a secure location. In addition, if you must stop an installation to fix an error,
                      you can run the configuration assistants using configToolAllCommands and a password
                      response file.
                      The configToolAllCommands password response file consists of the following syntax options:

                      •     internal_component_name is the name of the component that the configuration assistant
                            configures
                      •     variable_name is the name of the configuration file variable
                      •     value is the desired value of the configuration.
                      The command syntax is as follows:
                      internal_component_name|variable_name=value
                      For example:
                      oracle.crs|S_ASMPASSWORD=PassWord

                      Oracle strongly recommends that you maintain security with a password response file:
                      •     Permissions on the response file must be set to 600.
                      •     The owner of the response file must be the installation owner user, with the group set to
                            the central inventory (oraInventory) group.


Database Installation Guide
E96293-13                                                                                                         November 12, 2025
Copyright © 2015, 2025, Oracle and/or its affiliates.                                                            Appendix C-8 of C-11
                                                                                                                           Appendix C
                                                        Postinstallation Configuration Using Response File Created During Installation



Running Postinstallation Configuration Using Response File
                      Use this procedure to run postinstallation configuration using response file.
                      To run configuration assistants with the executeConfigTools script:

                      1.    Create a response file using the syntax filename.properties. For example:
                            C:\> copy nul cfgrsp.properties
                      2.    Open the file with a text editor, and cut and paste the password template, modifying as
                            needed.
                      3.    Secure the cfgrsp.properties file by changing permissions in Properties page. Right-click
                            the file to open the Properties page. Select the Security tab, click the Edit button, select a
                            group or user, then select Deny check box against Read permissions to remove read
                            access for unwanted users.
                      4.    Change directory to ORACLE_HOME\cfgtoollogs
                      5.    Before running configToolAllCommands, rename it using the following command:
                            copy configToolAllCommands configToolAllCommands.bat
                      6.    Run the configuration script using the following syntax:
                            configToolAllCommands.bat RESPONSE_FILE=\path\name.properties
                            for example:
                            C:\> configToolAllCommands.bat RESPONSE_FILE=C:\oracle\cfgrsp.properties
                      Example C-1          Password response file for Oracle Grid Infrastructure for a Standalone
                      Server
                      Oracle Grid Infrastructure requires passwords for Oracle Automatic Storage Management
                      Configuration Assistant (ASMCA), and for Intelligent Platform Management Interface
                      Configuration Assistant (IPMICA) if you have a BMC card and you want to enable this feature.
                      Provide the following response file:
                      oracle.crs|S_ASMPASSWORD=password
                      oracle.crs|S_ASMMONITORPASSWORD=password
                      oracle.crs|S_OMSPASSWORD=password
                      oracle.crs|S_BMCPASSWORD=password
                      oracle.crs|S_WINSERVICEUSERPASSWORD=password

                      Example C-2          Password response file for Oracle Database
                      Oracle Database configuration requires the SYS, SYSTEM, and DBSNMP passwords for use with
                      Database Configuration Assistant (DBCA). The S_ASMSNMPPASSWORD password is necessary
                      only if the database is using Oracle ASM for storage. Similarly, the S_PDBADMINPASSWORD
                      password is necessary only if you create a multitenant container database (CDB) with one or
                      more pluggable databases (PDBs). Also, if you select configure Oracle Enterprise Manager,
                      then provide the password for the Oracle software installation owner for the
                      S_EMADMINPASSWORD password.
                      oracle.server|S_SYSPASSWORD=password
                      oracle.server|S_SYSTEMPASSWORD=password
                      oracle.server|S_DBSNMPPASSWORD=password
                      oracle.server|S_PDBADMINPASSWORD=password
                      oracle.server|S_EMADMINPASSWORD=password
                      oracle.server|S_ASMSNMPPASSWORD=password




Database Installation Guide
E96293-13                                                                                                         November 12, 2025
Copyright © 2015, 2025, Oracle and/or its affiliates.                                                            Appendix C-9 of C-11
                                                                                                                       Appendix C
                                                             Postinstallation Configuration Using the ConfigToolAllCommands Script


                      If you do not want to enable Oracle Enterprise Manager or Oracle ASM, then leave those
                      password fields blank.


Postinstallation Configuration Using the ConfigToolAllCommands
Script
                      You can create and run a response file configuration after installing Oracle software. The
                      configToolAllCommands script requires users to create a second response file, of a different
                      format than the one used for installing the product.
                      Starting with Oracle Database 12c Release 2 (12.2), the configToolAllCommands script is
                      deprecated and may be desupported in a future release.


Using the Installation Response File for Postinstallation
Configuration
                      Starting with Oracle Database 12c release 2 (12.2), you can use the response file created
                      during installation to also complete postinstallation configuration.
                      Run the installer with the -executeConfigTools option to configure configuration assistants
                      after installing Oracle Grid Infrastructure or Oracle Database. You can use the response file
                      located at %ORACLE_HOME%\install\response\grid_timestamp.rsp to obtain the
                      passwords required to run the configuration tools. You must update the response file with the
                      required passwords before running the -executeConfigTools command.

                      Oracle strongly recommends that you maintain security with a password response file. The
                      owner of the response file must be the installation owner user.
                      Example C-3          Response File Passwords for Oracle Grid Infrastructure

                      oracle.install.crs.config.ipmi.bmcPassword=password
                      oracle.install.asm.SYSASMPassword=GRID_HOME\gridSetup.bat -executeConfigTools
                      -responseFile %ORACLE_HOME%
                      \install\response\grid_time_stamp.rsporacle.install.asm.monitorPassword=passwo
                      rd
                      oracle.install.config.emAdminPassword=password
                      oracle.install.OracleHomeUserPassword=password


                      If you do not have a BMC card, or you do not want to enable IPMI, then leave the
                      ipmi.bmcPassword input field blank.

                      If you do not want to enable Oracle Enterprise Manager for management, then leave the
                      emAdminPassword password field blank.

                      If you did not specify an Oracle Home user for the Oracle Grid Infrastructure installation, then
                      leave the OracleHomeUserPassword field blank.

                      Example C-4 Response File Passwords for Oracle Grid Infrastructure for a Standalone
                      Server (Oracle Restart)

                      oracle.install.asm.SYSASMPassword=password
                      oracle.install.asm.monitorPassword=password




Database Installation Guide
E96293-13                                                                                                     November 12, 2025
Copyright © 2015, 2025, Oracle and/or its affiliates.                                                       Appendix C-10 of C-11
                                                                                                                          Appendix C
                                                              Using the Installation Response File for Postinstallation Configuration


                      oracle.install.config.emAdminPassword=password
                      oracle.install.OracleHomeUserPassword=password


                      If you do not want to enable Oracle Enterprise Manager for management, then leave the
                      emAdminPassword password field blank.

                      If you did not specify an Oracle Home user for the Oracle Grid Infrastructure for a Standalone
                      Server (Oracle Restart) installation, then leave the OracleHomeUserPassword field blank.

                      Example C-5          Response File Passwords for Oracle Database
                      This example illustrates the passwords to specify for use with the database configuration
                      assistants.

                      oracle.install.db.config.starterdb.password.SYS=password
                      oracle.install.db.config.starterdb.password.SYSTEM=password
                      oracle.install.db.config.starterdb.password.DBSNMP=password
                      oracle.install.db.config.starterdb.password.PDBADMIN=password
                      oracle.install.db.config.starterdb.emAdminPassword=password
                      oracle.install.db.config.asm.ASMSNMPPassword=password
                      oracle.install.OracleHomeUserPassword=password


                      You can also specify oracle.install.db.config.starterdb.password.ALL=password to use
                      the same password for all database users.
                      Oracle Database configuration assistants require the SYS, SYSTEM, and DBSNMP
                      passwords for use with Oracle Database Configuration Assistant (DBCA). Specify the following
                      passwords, depending on your system configuration:
                      •     If the database uses Oracle ASM for storage, then you must specify a password for the
                            ASMSNMPPassword variable. If you are not using Oracle ASM, then leave the value for this
                            password variable blank.
                      •     If you create a multitenant container database (CDB) with one or more pluggable
                            databases (PDBs), then you must specify a password for the PDBADMIN variable. If you are
                            not using Oracle ASM, then leave the value for this password variable blank.
                      •     If you did not specify an Oracle Home user for the Oracle Database installation, then leave
                            the OracleHomeUserPassword field blank.




Database Installation Guide
E96293-13                                                                                                       November 12, 2025
Copyright © 2015, 2025, Oracle and/or its affiliates.                                                         Appendix C-11 of C-11
D
Configuring Read-Only Oracle Homes
                      Understand how read-only Oracle homes work and how you can configure read-only Oracle
                      homes.
                      •     Evolution of Oracle Homes
                            Learn about read-only Oracle home concepts like ORACLE_BASE_HOME and
                            ORACLE_BASE_CONFIG.
                      •     Enabling a Read-Only Oracle Home
                            Configure your Oracle home as a read-only Oracle home after you have performed a
                            software-only Oracle Database installation.
                      •     Determining if an Oracle Home is Read-Only
                            You can use the Registry Editor to determine if your Oracle home is a read/write or read-
                            only Oracle home.
                      •     File Path and Directory Changes in Read-Only Oracle Homes
                            Examples of hierarchical file mappings in a read-only Oracle home as compared to a read/
                            write Oracle home.


Evolution of Oracle Homes
                      Learn about read-only Oracle home concepts like ORACLE_BASE_HOME and
                      ORACLE_BASE_CONFIG.

                      •     About Read-Only Oracle Homes
                            Starting with Oracle Database 18c, you can configure an Oracle home in read-only mode.
                            A read-only Oracle home does not imply that the file system and the Oracle home is in
                            read-only mode. The file system and mount point should always be in read/write mode.
                      •     About Oracle Base Homes
                            Both, in a read-only ORACLE_HOME and read/write ORACLE_HOME, the user-specific
                            files, instance-specific files, and log files reside in a location known as the
                            ORACLE_BASE_HOME.
                      •     About Oracle Base Config
                            Both, in a read-only ORACLE_HOME and read/write ORACLE_HOME, the configuration
                            files reside in a location known as ORACLE_BASE_CONFIG.


About Read-Only Oracle Homes
                      Starting with Oracle Database 18c, you can configure an Oracle home in read-only mode. A
                      read-only Oracle home does not imply that the file system and the Oracle home is in read-only
                      mode. The file system and mount point should always be in read/write mode.
                      A read-only Oracle home simplifies provisioning by implementing separation of installation and
                      configuration.
                      In a read-only Oracle home, the configuration data and log files reside outside of the read-only
                      Oracle home. See File Path and Directory Changes in Read-Only Oracle Homes.




Database Installation Guide
E96293-13                                                                                              November 12, 2025
Copyright © 2015, 2025, Oracle and/or its affiliates.                                                  Appendix D-1 of D-6
                                                                                                               Appendix D
                                                                                                Evolution of Oracle Homes


                      Apart from the traditional ORACLE_BASE and ORACLE_HOME directories, the following
                      directories contain files that used to be in ORACLE_HOME:
                      •     ORACLE_BASE_HOME
                      •     ORACLE_BASE_CONFIG
                      Ensure that you enable read-only Oracle home before you create the database or listener.
                      When you run the roohctl script to enable a read-only Oracle home, the Oracle home file
                      system will continue to be a read/write file system.


                                Note
                                This feature does not affect how database administrators monitor, diagnose, and tune
                                their system performance.



About Oracle Base Homes
                      Both, in a read-only ORACLE_HOME and read/write ORACLE_HOME, the user-specific files,
                      instance-specific files, and log files reside in a location known as the ORACLE_BASE_HOME.
                      In a read/write ORACLE_HOME, the ORACLE_BASE_HOME path is the same as the
                      ORACLE_HOME directory. However, in a read-only ORACLE_HOME, the
                      ORACLE_BASE_HOME directory is not co-located with ORACLE_HOME but is located at
                      ORACLE_BASE\homes\HOME_NAME.
                      Where, HOME_NAME is the internal name for ORACLE_HOME.
                      For example, the networking directories network\admin, network\trace, and
                      network\log are located in the ORACLE_BASE_HOME directory. In a read/write
                      ORACLE_HOME the networking directories appear to be in ORACLE_HOME because
                      ORACLE_BASE_HOME is co-located with ORACLE_HOME, whereas in a read-only
                      ORACLE_HOME the networking directories are located in
                      ORACLE_BASE\homes\HOME_NAME.
                      To print the ORACLE_BASE_HOME path, run the orabasehome command from the
                      %ORACLE_HOME%\bin directory:

                      set ORACLE_HOME C:\app\oracle\product\19.0.0\dbhome_1
                      cd %ORACLE_HOME%\bin
                      orabasehome


                      For example:

                      orabasehome
                      C:\app\oracle\homes\OraDB19Home1


                      Where, C:\app\oracle is ORACLE_BASE and OraDB19Home1 is HOME_NAME


About Oracle Base Config
                      Both, in a read-only ORACLE_HOME and read/write ORACLE_HOME, the configuration files
                      reside in a location known as ORACLE_BASE_CONFIG.



Database Installation Guide
E96293-13                                                                                             November 12, 2025
Copyright © 2015, 2025, Oracle and/or its affiliates.                                                 Appendix D-2 of D-6
                                                                                                                 Appendix D
                                                                                          Enabling a Read-Only Oracle Home


                      In a read/write ORACLE_HOME, the ORACLE_BASE_CONFIG path is the same as the
                      ORACLE_HOME path because it is located at ORACLE_HOME. However, in a read-only
                      ORACLE_HOME, the ORACLE_BASE_CONFIG path is the same as ORACLE_BASE.
                      ORACLE_BASE_CONFIG\dbs contains the configuration files for ORACLE_HOME. Each file in
                      the dbs directory contains ORACLE_SID so that the directory can be shared by many different
                      ORACLE_SIDs.
                      To print the ORACLE_BASE_CONFIG path, run the orabaseconfig command from the
                      %ORACLE_HOME%\bin directory:

                      C:\> set ORACLE_HOME C:\app\oracle\product\19.0.0\dbhome_1
                      C:\> cd %ORACLE_HOME%\bin
                      orabaseconfig


                      For example:

                      orabaseconfig
                      C:\> C:\app\oracle


                      Where, C:\app\oracle is ORACLE_BASE.


Enabling a Read-Only Oracle Home
                      Configure your Oracle home as a read-only Oracle home after you have performed a software-
                      only Oracle Database installation.
                      To enable a read-only Oracle home:
                      1.    Perform a software-only Oracle Database installation.
                      2.    Run the roohctl -enable script.


                                     Note
                                     Do not use the -disable flag with the roohctl command, as it is not supported.

                      3.    Run Oracle Database Configuration Assistant (Oracle DBCA) to create a database.


                                     Note
                                     Ensure that you enable read-only Oracle home before you create the database or
                                     listener.


                      Software-Only Database Installation
                      1.    Log in as the Oracle installation owner user account (oracle) that you want to own the
                            software binaries.
                      2.    Download the Oracle Database installation image files (db_home.zip) to a directory of
                            your choice. For example, you can download the image files to the \tmp directory.
                      3.    Create the Oracle home directory and extract the image files that you have downloaded
                            into this Oracle home directory.


Database Installation Guide
E96293-13                                                                                               November 12, 2025
Copyright © 2015, 2025, Oracle and/or its affiliates.                                                   Appendix D-3 of D-6
                                                                                                                   Appendix D
                                                                                            Enabling a Read-Only Oracle Home



                                     Note
                                     Ensure that the Oracle home directory path you create is in compliance with the
                                     Oracle Optimal Flexible Architecture recommendations. Also, unzip the installation
                                     image files only in this Oracle home directory that you created.

                      4.    From the Oracle home directory, run the setup.exe command to start the Oracle
                            Database installer.
                      5.    In the Select Configuration Option screen, select Set Up Software Only.
                      6.    Select your installation type. Installation screens vary depending on the installation option
                            you select. Respond to the configuration prompts as needed.


                                Note
                                Click Help if you have any questions about the information you are asked to submit
                                during installation.


                      Run the roohctl Script
                      1.    Go to the bin directory

                            cd C:\app\oracle\product\19.0.0\dbhome_1\bin

                      2.    Run the roohctl script to enable read-only Oracle home.

                            roohctl.bat -enable

                      Run Oracle Database Configuration Assistant
                      1.    Ensure that you are still in the bin directory and run Oracle DBCA.

                            dbca

                      2.    In the Select Database Operation screen, select Create a Database.
                      3.    The configuration screens vary depending on the options you select. Respond to the
                            prompts as needed.


                                Note
                                Click Help if you have any questions about the information you are asked to submit
                                during database creation.


                      Related Topics
                      •     Oracle Database 2 Day DBA




Database Installation Guide
E96293-13                                                                                                 November 12, 2025
Copyright © 2015, 2025, Oracle and/or its affiliates.                                                     Appendix D-4 of D-6
                                                                                                                 Appendix D
                                                                                 Determining if an Oracle Home is Read-Only




Determining if an Oracle Home is Read-Only
                      You can use the Registry Editor to determine if your Oracle home is a read/write or read-only
                      Oracle home.
                      Start Registry Editor and navigate to the ORACLE_HOME_READONLY entry in the
                      HKEY_LOCAL_MACHINE\SOFTWARE\ORACLE\KEY_OracleHomeName Windows Registry key.

                      The default value for the ORACLE_HOME_READONLY parameter appears as N. The
                      ORACLE_HOME_READONLY parameter value appears as Y if your Oracle home is in a read-only
                      mode. Do not modify this value.


File Path and Directory Changes in Read-Only Oracle Homes
                      Examples of hierarchical file mappings in a read-only Oracle home as compared to a read/
                      write Oracle home.
                      This example shows an Optimal Flexible Architecture-compliant Oracle Database installation,
                      for the user oracle, with the ORACLE_HOME, ORACLE_BASE, ORACLE_BASE_HOME, and
                      ORACLE_BASE_CONFIG logical locations. The database files are under
                      oraclebase\oradata.

                      This example also shows the changes in the Oracle Database software defined paths of
                      configuration files, log files, and other directories in a read-only Oracle home when compared
                      to a read/write Oracle home.

                      Table D-1       read/write and Read-Only Oracle Home File Path Examples

                       Directory                        Read/Write Oracle Home File    Read-Only Oracle Home File
                                                        Path                           Path
                       ORACLE_HOME                      C:\app\oracle\product\ C:\app\oracle\product\
                                                        19.0.0\dbhome_1        19.0.0\dbhome_1
                       ORACLE_BASE                      C:\app\oracle\                 C:\app\oracle\
                       ORACLE_BASE_HOME                 ORACLE_HOME                    ORACLE_BASE\homes\HOME_
                                                        (or)                           NAME.

                                                        C:\app\oracle\product\ (or)
                                                        19.0.0\dbhome_1        C:\app\oracle\homes\Or
                                                                               aDB19Home1
                       ORACLE_BASE_CONFIG               ORACLE_HOME                    ORACLE_BASE
                                                        (or)                           (or)
                                                        C:\app\oracle\product\ C:\app\oracle\
                                                        19.0.0\dbhome_1
                       network                          ORACLE_HOME\network            ORACLE_BASE_HOME\network
                                                        (or)                           (or)
                                                        C:\app\oracle\product\ C:\app\oracle\homes\Or
                                                        19.0.0\dbhome_1\networ aDB19Home1\network
                                                        k




Database Installation Guide
E96293-13                                                                                               November 12, 2025
Copyright © 2015, 2025, Oracle and/or its affiliates.                                                   Appendix D-5 of D-6
                                                                                                                  Appendix D
                                                                   File Path and Directory Changes in Read-Only Oracle Homes



                      Table D-1       (Cont.) read/write and Read-Only Oracle Home File Path Examples

                       Directory                        Read/Write Oracle Home File     Read-Only Oracle Home File
                                                        Path                            Path
                       database                         ORACLE_HOME\database            ORACLE_BASE\database
                                                        (or)                            (or)
                                                        C:\app\oracle\product\ C:\app\oracle\database
                                                        19.0.0\dbhome_1\databa
                                                        se




Database Installation Guide
E96293-13                                                                                                November 12, 2025
Copyright © 2015, 2025, Oracle and/or its affiliates.                                                    Appendix D-6 of D-6
E
Configuring Networks for Oracle Database
                      Typically, the computer on which you want to install Oracle Database is connected to the
                      network, has a local storage to contain the Oracle Database installation, has a display monitor,
                      and has a media drive.


                      Configuring networks for Oracle Database describes how to install Oracle Database on
                      computers that do not meet the typical scenario.
                      •     Installing Oracle Database on Computers with Multiple IP Addresses
                            Use this procedure to set the ORACLE_HOSTNAME environment variable.
                      •     Installing Oracle Database on Computers with Multiple Aliases
                            A computer with multiple aliases is registered with the naming service under a single IP
                            address but with multiple aliases.
                      •     Installing Oracle Database on Nonnetworked Computers
                            You can install Oracle Database on non-networked computers.
                      •     Installing a Loopback Adapter
                            A loopback adapter is required if you are installing on a non-networked computer to
                            connect the computer to a network after the installation.


Installing Oracle Database on Computers with Multiple IP
Addresses
                      Use this procedure to set the ORACLE_HOSTNAME environment variable.

                      Clients must be able to access the computer using its host name, or using aliases for its host
                      name. To check access, ping the host name from the client computers using the short name
                      (host name only) and the fully qualified domain name (FQDN, host name and domain name).
                      Both must work.


                      1.    Display System in the Windows Control Panel.
                      2.    In the System Properties dialog box, click Advanced.
                      3.    In the Advanced tab, click Environment Variables.
                      4.    In the Environment Variables dialog box, under System Variables, click New.
                      5.    In the New System Variable dialog box, enter the following information:
                            •    Variable name: ORACLE_HOSTNAME
                            •    Variable value: The host name of the computer to use.
                      6.    Click OK, then in the Environment Variables dialog box, click OK.
                      7.    Click OK in the Environment Variables dialog box, then in the System Properties dialog
                            box, click OK.



Database Installation Guide
E96293-13                                                                                              November 12, 2025
Copyright © 2015, 2025, Oracle and/or its affiliates.                                                  Appendix E-1 of E-5
                                                                                                                      Appendix E
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
                      1.    Install a loopback adapter on the computer.
                            The loopback adapter and the local IP address simulate a networked computer. If you
                            connect the computer to the network, Oracle Database still uses the local IP address and
                            host name.
                      2.    Ping the computer from itself, using only the host name and using the fully qualified name,
                            which is in the DRIVE_LETTER:\system32\drivers\etc\hosts file.
                            For example, if you installed a loopback adapter on a computer called mycomputer on the
                            us.example.com domain, check the following:
                            DRIVE_LETTER:\>ping mycomputer                     Ping itself using just the hostname.

                            Reply from 10.10.10.10                    Returns local IP.
                            DRIVE_LETTER:\>ping mycomputer.us.example.com   Ping using a fully qualified name.
                            Reply from 10.10.10.10                    Returns local IP.



                                     Note
                                     When you ping a computer from itself, the ping command must return the local IP
                                     address (the IP address of the loopback adapter).



                            If the ping command fails, contact your network administrator.
                      If you connect the computer to a network after installation, the Oracle Database instance on
                      your computer can work with other instances on the network. Remember that you must have
                      installed a loopback adapter on your computer. Your computer can use a static IP or DHCP,
                      depending on the network to which you are connected.


Installing a Loopback Adapter
                      A loopback adapter is required if you are installing on a non-networked computer to connect
                      the computer to a network after the installation.




Database Installation Guide
E96293-13                                                                                                    November 12, 2025
Copyright © 2015, 2025, Oracle and/or its affiliates.                                                        Appendix E-2 of E-5
                                                                                                                  Appendix E
                                                                                                Installing a Loopback Adapter


                      •     About Using Loopback Adapters with Oracle Database
                            Learn how to use Loopback Adapters with Oracle Database on a non-networked computer
                            to connect the computer to a network after the installation.
                      •     Checking if a Loopback Adapter is Installed on Your Computer
                            Review this section to verify if a loopback adapter is installed on your computer by running
                            the ipconfig /all command.
                      •     Installing a Loopback Adapter
                            Use this procedure to install a Loopback Adapter or a Microsoft KM-TEST Loopback
                            Adapter on different Windows versions.
                      •     Removing a Loopback Adapter
                            Use this procedure to remove a Loopback Adapter or a Microsoft KM-TEST Loopback
                            Adapter on different Windows versions.


About Using Loopback Adapters with Oracle Database
                      Learn how to use Loopback Adapters with Oracle Database on a non-networked computer to
                      connect the computer to a network after the installation.
                      When you install a loopback adapter, the loopback adapter assigns a local IP address for your
                      computer. After the loopback adapter is installed, there are at least two network adapters on
                      your computer: your own network adapter and the loopback adapter. To run Oracle Database
                      on Windows, set the loopback adapter as the primary adapter.
                      You can change the bind order for the adapters without reinstalling the loopback adapter. The
                      bind order of the adapters to the protocol indicates the order in which the adapters are used.
                      When the loopback adapter is used first for the TCP/IP protocol, all programs that access
                      TCP/IP first probe the loopback adapter. The local address is used for tools, such as Oracle
                      Enterprise Manager. Applications that use a different Ethernet segment are routed to the
                      network card.
                      Related Topics
                      •     Installing Oracle Database on Nonnetworked Computers


Checking if a Loopback Adapter is Installed on Your Computer
                      Review this section to verify if a loopback adapter is installed on your computer by running the
                      ipconfig /all command.

                      To check if a loopback adapter is installed on your computer, run the ipconfig /all command:
                      DRIVE_LETTER:\>ipconfig /all



                                Note
                                Loopback Adapter installed on the computer must be the Primary Network Adapter.



                      If there is a loopback adapter installed, you see a section that lists the values for the loopback
                      adapter. For example:
                      Ethernet adapter Local Area Connection 2:
                      Connection-specific DNS Suffix . :
                      Description . . . . . . . . . . . : Microsoft Loopback Adapter
                      Physical Address. . . . . . . . . : 02-00-4C-4F-4F-50



Database Installation Guide
E96293-13                                                                                                November 12, 2025
Copyright © 2015, 2025, Oracle and/or its affiliates.                                                    Appendix E-3 of E-5
                                                                                                                  Appendix E
                                                                                                Installing a Loopback Adapter

                      DHCP Enabled. . . . . . . . . . . : No
                      IP Address. . . . . . . . . . . . : 10.10.10.10
                      Subnet Mask . . . . . . . . . . . : 255.255.0.0


Installing a Loopback Adapter
                      Use this procedure to install a Loopback Adapter or a Microsoft KM-TEST Loopback Adapter
                      on different Windows versions.
                      The Microsoft Loopback Adapter in Microsoft Windows 7 is renamed to Microsoft KM-TEST
                      Loopback Adapter in Microsoft Windows 8.1 and later releases.
                      To install a Loopback Adapter on Microsoft Windows 7 or to install Microsoft KM-Test Loopback
                      Adapter on Microsoft Windows 8.1, Microsoft Windows Server 2012, Microsoft Windows
                      Server 2012 R2, and Microsoft Windows Server 2016 perform the following steps:
                      1.    Click Start and enter hdwwiz in the Search box. Click hdwwiz to start the Add Hardware
                            wizard.
                            For Microsoft Windows 8.1 and later releases, open the Windows Control Panel and
                            double-click Add Hardware to start the Add Hardware wizard.
                      2.    In the Welcome window, click Next.
                      3.    In the The wizard can help you install other hardware window, select Install the hardware
                            that I manually select from a list, and click Next.
                      4.    From the list of hardware types, select the type of hardware you are installing, select
                            Network adapters, and click Next.
                      5.    In the Select Network Adapter window, make the following selections:
                            •    Manufacturer: Select Microsoft.
                            •    Network Adapter: Select Microsoft Loopback Adapter for Microsoft Windows 7 and
                                 Microsoft KM-TEST Loopback Adapter for Microsoft Windows Server 8.1 and later
                                 releases.
                      6.    Click Next.
                      7.    In the The wizard is ready to install your hardware window, click Next.
                      8.    In the Completing the Add Hardware Wizard window, click Finish.
                      9.    Click Manage Network Connections. This displays the Network Connections Control
                            Panel item.
                      10. Right-click the connection that was just created. This is usually named "Local Area
                            Connection 2". Choose Properties.
                      11. On the General tab, select Internet Protocol (TCP/IP), and click Properties.

                      12. In the Properties dialog box, click Use the following IP address and do the following:

                            a.   IP Address: Enter a non-routable IP for the loopback adapter. Oracle recommends the
                                 following non-routable addresses:
                                 •    192.168.x.x (x is any value between 0 and 255)
                                 •    10.10.10.10
                            b.   Subnet mask: Enter 255.255.255.0.
                            c.   Record the values you entered, which you need later in this procedure.
                            d.   Leave all other fields empty.



Database Installation Guide
E96293-13                                                                                                 November 12, 2025
Copyright © 2015, 2025, Oracle and/or its affiliates.                                                     Appendix E-4 of E-5
                                                                                                               Appendix E
                                                                                             Installing a Loopback Adapter


                            e.   Click OK.
                      13. Click Close.

                      14. Close Network Connections.

                      15. Restart the computer.

                      16. Add a line to the DRIVE_LETTER: \WINDOWS\system32\drivers\etc\hosts file with the
                            following format, after the localhost line:
                            IP_address       hostname.domainname   hostname

                            where:
                            •    IP_address is the non-routable IP address.
                            •    hostname is the name of the computer.
                            •    domainname is the name of the domain.
                            For example:
                            10.10.10.10        mycomputer.us.example.com   mycomputer
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
                      1.    Display System in the Windows Control Panel.
                      2.    In the Hardware tab, click Device Manager.
                      3.    For Microsoft Windows 7, in the Device Manager window, expand Network adapters. You
                            must see Microsoft Loopback Adapter. For Microsoft Windows 8.1 and later releases,
                            you must see Microsoft KM-TEST Loopback Adapter.
                      4.    For Microsoft Windows 7, right-click Microsoft Loopback Adapter and select Uninstall.
                            For Microsoft Windows 8.1 and later releases, right-click Microsoft KM-TEST Loopback
                            Adapter and select Uninstall.
                      5.    Click OK.
                      6.    Restart the computer.
                      7.    Remove the line from the DRIVE_LETTER:\WINDOWS\system32\drivers\etc\hosts file,
                            added after the localhost line while installing the loopback adapter on other Windows
                            operating systems.



Database Installation Guide
E96293-13                                                                                             November 12, 2025
Copyright © 2015, 2025, Oracle and/or its affiliates.                                                 Appendix E-5 of E-5
F
Managing Oracle Database Port Numbers
                      Review default port numbers.
                      If needed, use these steps to change assigned ports after installation.
                      •     About Managing Ports
                            During installation, Oracle Universal Installer assigns port numbers to the components
                            from a set of default port numbers.
                      •     Oracle Database Component Port Numbers and Protocols
                            This table lists the port numbers and protocols configured for Oracle Database
                            components during a single-instance installation.
                      •     Changing the Oracle Services for Microsoft Transaction Server Port
                            In most cases, you need not reconfigure the port number.


About Managing Ports
                      During installation, Oracle Universal Installer assigns port numbers to the components from a
                      set of default port numbers.
                      Many Oracle Database components and services use ports. As an administrator, it is important
                      to know the port numbers used by these services, and to ensure that the same port number is
                      not used by two services on your host.
                      Most port numbers are assigned during installation. Every component and service has an
                      allotted port range, which is the set of port numbers Oracle Database attempts to use when
                      assigning a port. Oracle Database starts with the lowest number in the range and performs the
                      following checks:
                      •     Is the port used by another Oracle Database installation on the host?
                            The installation may be up or down at the time; Oracle Database can still detect if the port
                            is used.
                      •     Is the port used by a process that is currently running?
                            This could be any process on the host, even a non-Oracle Database process.
                      •     Is the port listed in the /etc/services file?
                      If the answer to any of the preceding questions is yes, then Oracle Database moves to the next
                      highest port in the allotted port range, and continues checking until it finds a free port.


Oracle Database Component Port Numbers and Protocols
                      This table lists the port numbers and protocols configured for Oracle Database components
                      during a single-instance installation.
                      By default, the first port in the range is assigned to the component, if it is available.




Database Installation Guide
E96293-13                                                                                                  November 12, 2025
Copyright © 2015, 2025, Oracle and/or its affiliates.                                                      Appendix F-1 of F-3
                                                                                                                         Appendix F
                                                                             Oracle Database Component Port Numbers and Protocols



Table F-1      Ports Used in Oracle Components

Component and Description                                             Default Port Number        Port Range        Protocol
Oracle Net Listener                                                   1521                       Port number       TCP
Enables Oracle client connections to the database by using                                       changes to the
Oracle Net services. You can configure this port number during                                   next available
installation. To reconfigure this port, use Net Configuration                                    port.
Assistant.                                                                                       Modifiable
                                                                                                 manually to any
                                                                                                 available port.
Oracle Connection Manager                                             1630                       1630              TCP
Listening port for Oracle client connections. It is not configured
during installation, but can be configured manually by editing
the cman.ora parameter file. You can find the file under /
network/admin directory.
Oracle XML DB                                                         0                          Configured        HTTP
The Oracle XML DB HTTP port is used if web-based                                                 Manually
applications need to access an Oracle database from an HTTP
listener. It is configured during installation, but you cannot view
it afterward.
See Also: Oracle XML DB Developer's Guide
Oracle XML DB Developer's Guide                                       0                          Configured        FTP
The Oracle XML DB FTP is used when applications need to                                          Manually
access an Oracle database from an FTP listener. It is
configured during installation, but you cannot view it afterward.
See Also: Oracle XML DB Developer's Guide
Oracle Services for Microsoft Transaction Server                      Dynamic                    49152-65535       TCP
The port number for Microsoft Transaction Server is configured
when you enter its value in the Oracle Universal Installer the
first time you install the software on a particular server. If you
install the software in multiple Oracle homes on the same
server, then Oracle Universal Installer uses the same port
number that you specified during the first installation.
In most cases, you do not have to reconfigure the port number.




                                See Also

                                •    Oracle Enterprise Manager Cloud Control Advanced Installation and Configuration
                                     Guide for information on Oracle Management Agent ports
                                •    Oracle Real Application Clusters Installation Guide for Microsoft Windows x64 (64-
                                     Bit) for a list of clusterware ports used in Oracle components




Database Installation Guide
E96293-13                                                                                                      November 12, 2025
Copyright © 2015, 2025, Oracle and/or its affiliates.                                                          Appendix F-2 of F-3
                                                                                                                       Appendix F
                                                                Changing the Oracle Services for Microsoft Transaction Server Port




Changing the Oracle Services for Microsoft Transaction Server
Port
                      In most cases, you need not reconfigure the port number.
                      If you must, then you can use the Registry Editor to edit its value in the
                      HKEY_LOCAL_MACHINE\SOFTWARE\ORACLE\OracleMTSRecoveryService\Protid_0 Registry Editor
                      key to any available port within the range 1024 to 65535.

                      During installation, Oracle Universal Installer takes the value for the port from the key, if it
                      exists. Otherwise, a free port ranging from 49152 to 65535 is chosen.




Database Installation Guide
E96293-13                                                                                                     November 12, 2025
Copyright © 2015, 2025, Oracle and/or its affiliates.                                                         Appendix F-3 of F-3
Index
Numerics                                                clusters
                                                            installation guidelines, 3
19c deprecated features, i                              commands
                                                            runcluvfy.bat, 20
                                                            setup.exe, 20
A                                                       components
accessibility software, Java Access Bridge, A-1             for single Oracle homes, 3
account control, 11                                         installation of single Oracle home
Administrators group, requirements for Oracle                         components, 3
         installations, 2                               computers with multiple aliases, E-2
aliases, multiple on computers, E-2                     computers, non-networked, E-2
ASMCA, 3                                                configuration assistants, 4
asmcmd utility, 21                                          suppressing during silent or response file
asmtool utility, 14                                                   installation, C-5
asmtoolg utility, 13                                            See also Oracle Database Configuration
authentication support                                          Assistant (DBCA), Net Configuration Assistant
                                                                (NetCA)
    preinstallation requirements, 10
                                                        configuring disks for Oracle Automatic Storage
Automatic Diagnostic Repository (ADR), B-1
                                                                 Management, 4
Automatic Memory Management, 4
                                                        Connection Manager
    about, 5
                                                            ports, ranges and protocol, F-2
Automatic Storage Management (Oracle ASM)
                                                        console mode, 13
    configuring Oracle Database to communicate
                                                        control files
             with, 9
                                                            about, 14
                                                            using Oracle Enterprise Manager Database
B                                                                     Control with, 14
                                                        cron jobs, 5
backups of database                                     custom database
    perform before upgrading, 3                             failure groups for Oracle Automatic Storage
bind order of the adapters                                            Management, 7
    about, E-3                                              requirements when using Oracle Automatic
                                                                      Storage Management, 7
C
CDBs, 10, C-9                                           D
    character sets, 5                                   data files
central inventory, 4, B-4                                   about, 13
          See also Oracle inventory directory
                                                            creating separate directories for, 10
          See also OINSTALL directory
                                                            minimum disk space for, 9
certification matrix, 5
                                                            options for placing on file systems, 8
character sets, 5, 13
                                                            recommendations for file system, 8
client-server configurations, B-2
                                                        data loss
Cluster Verification Utility
                                                            minimizing with Oracle ASM, 7
     download location, 5
                                                        Database Security
     incorporated into OUI, 5
                                                            preinstallation requirements, 10
     overview, 5



Database Installation Guide
E96293-13                                                                                    November 12, 2025
Copyright © 2015, 2025, Oracle and/or its affiliates.                                         Index-1 of Index-8
                                                                                                          Index


Database Upgrade Assistant, computers with              diskpart.exe tool,
          minimum memory, 3                                 about, 12
databases                                                   syntax, 12
    control files, 14                                   disks
    data files, 13                                          configuring for Oracle Automatic Storage
    initialization parameter file, 12                                Management, 4
    Oracle Automatic Storage Management                 display variable, 4
              requirements, 7                           documentation
    redo log files, 13                                      additional Oracle documentation, ii
    starting, 4                                         DVD drive, installing from, 9
    stopping, 4
    tablespaces, 13
DB_DOMAIN parameter, 11
                                                        E
DB_NAME                                                 environment variables
    parameter, 11                                           NLS_LANG, 12
DBCA                                                        ORACLE_HOME
     See Oracle Database Configuration Assistant                preventing installation, 2
dbca.rsp file                                               TEMP and TMP
    about, C-3                                                  hardware requirements, 3
    using, C-7                                              TMP and TMPDIR, 4
default control files, 14                               example01.DBF data file, 13
default data files, 13                                  examples
default initialization parameter file, init.ora, 12         Oracle ASM failure groups, 7
default tablespaces, 13                                 executeConfigTools, C-10
deinstallation                                          external redundancy
    files removed, 2                                        Oracle Automatic Storage Management level,
Deinstallation Tool                                                 7
    about, 1
deprecated features, i
description                                             F
    database restart, 1
                                                        failure group
    Oracle Restart, 1
                                                              characteristics of Oracle ASM failure group, 7
device names
                                                              examples of Oracle Automatic Storage
    creating with asmtool, 14
                                                                        Management failure groups, 7
    creating with asmtoolg, 13
                                                              Oracle ASM, 7
diagnostic data, B-1
                                                        fast recovery area
Direct NFS
                                                              filepath, B-4
    oranfstab file, 3
                                                              Grid home
Direct NFS Client
                                                                   filepath, B-4
    enabling, 6
                                                        Fast Recovery Area, 10
    Enabling HCC, 7
                                                        file paths, D-5
    SNMP support, 7
                                                        file systems
directory
                                                              data file and recovery file placement options,
    creating separate data file directories, 10
                                                                        8
    database file directory, 8
                                                              system requirements, 2
disk group
                                                              using for data files, 8
    Oracle ASM, 7
                                                        files
disk groups
                                                              removed by deinstallation, 2
    recommendations for, 7
                                                              tnsnames.ora, 7
disk space
                                                        Flash Recovery Area
    checking, 3                                             See Fast Recovery Area
    Oracle ASM, 10
    requirements for preconfigured database in
              Oracle Automatic Storage
              Management, 7



Database Installation Guide
E96293-13                                                                                    November 12, 2025
Copyright © 2015, 2025, Oracle and/or its affiliates.                                         Index-2 of Index-8
                                                                                                          Index


G                                                       Jobs system, 8
                                                        JRE (Java Runtime Environment)
generic documentation references                           requirements, 2
    Windows-specific parameter file name and
             location, 12
    Windows-specific redo log file location, 13
                                                        K
    Windows-specific redo log file size, 13             Kerberos Based Authentication for Direct NFS, 6
global database name
    about, 11
    identifying, 11                                     L
global database name, defined, 11                       languages
globalization, 5                                             installing Oracle components in different
                                                                      languages, 14
H                                                            using Oracle components in different
                                                                      languages, 14
host name resolution, 7                                 laptops, installing Oracle Database on, E-2
host name, setting before installation, E-1             licensing, 5
                                                        listeners
I                                                            stopping existing listener process, 11
                                                        local device, using for data files, 9
image                                                   loopback adapters, E-3
      install, 16, 15                                        about, E-3
initialization parameter file                                checking if installed, E-3
      about, 12                                              computers with multiple aliases, E-2
      in database, 12                                        installing, E-3
      init.ora, 12                                           installing on Windows Server 2008, E-4
installation                                                 non-networked computers, E-2
      component-specific guidelines, 3                       removing, E-5
      computer aliases, multiple, E-2                           See also network adapters, primary network
      configuration options, about, 4                           adapters
      downloading software from Oracle                  LVM
                Technology Network, 6                      recommendations for Oracle Automatic
      DVD drive, 9                                               Storage Management, 7
      Java Access Bridge, A-2
      laptops, E-2                                      M
      Oracle Automatic Storage Management, 7
      overview, 1                                       multihomed computers, installing on, E-1
      postinstallation tasks, 1                         multiple aliases, computers with, E-2
      preinstallation considerations, 2                 multiple Oracle homes
      remote installation with remote access                setting, E-1
                software, 8                                 System Identifier (SID), 12
      remote installation, DVD drive, 9                 Multiple Oracle Homes Support
      single Oracle home components, 3                      advantages, B-2
installation types                                      multitenant container database
      and Oracle Automatic Storage Management,              character sets, 5
                7                                       multiversioning, B-2
Installing                                              My Oracle Support website
      Oracle restart, 18                                    about, 5
invalid objects                                             accessing, 5
      recompiling, 3
                                                        N
J
                                                        Net Configuration Assistant (NetCA)
Java Access Bridge                                          response files, C-5
   about, A-1                                               running at command prompt, C-5
   installing, A-2

Database Installation Guide
E96293-13                                                                                    November 12, 2025
Copyright © 2015, 2025, Oracle and/or its affiliates.                                         Index-3 of Index-8
                                                                                                         Index


Net Configuration Assistant (NetCA) (continued)         Oracle ASM disk space, 10
    suppressing during silent or response file          Oracle Automatic Storage Management, 7
              installation, C-5                            allocation units (AU) and ASM disks, 7
Net Services Configuration Assistant, computers            asmcmd utility, 21
        with minimum memory, 3                             characteristics of failure groups, 7
netca.rsp file                                             configuring disks, 4
    about, C-3                                             considerations before installing, 7
    using, C-5                                             disk space, 10
network adapters, E-2                                      failure groups
    computers with multiple aliases, E-2                        examples, 7
    how primary adapter is determined, E-3                      identifying, 7
    non-networked computers, E-2                           installation, testing, 21
    primary, on computers with multiple aliases,           part of Oracle Grid Infrastructure installation,
              E-2                                                    15
          See also loopback adapters, primary network      password file, 7
          adapters                                         redundancy levels, 7
network cards, multiple, E-1                               space required for preconfigured database, 7
network protocols, supported, 5                            SPFILE server parameter file, 7
network setup                                           Oracle Automatic Storage Management (Oracle
    host name resolution, 7                                     ASM)
network topics                                             asmtool utility, 14
    computers with multiple aliases, E-2                   asmtoolg utility, 13
    laptops, E-2                                           DAS disks, 11
    listed, E-1                                            getting started using, 2
    loopback adapters, E-3                                 managing, 3
    multiple network cards, E-1                            Oracle ASM asmcmd utility, 3
    non-networked computers, E-2                           Oracle ASM disk groups
NLS_LANG environment variable, 12                               managing, 3
non-networked computers, E-2                               partition creation, 11
NTFS system requirements, 2                                SAN disks, 11
                                                           silent or response file mode installations, C-2
O                                                          starting and stopping, 3
                                                        Oracle Automatic Storage Management
OEM                                                             Configuration Assistant, 3
     See Oracle Enterprise Manager                      Oracle base, B-1, B-4
OFA, B-1                                                Oracle base config, D-2
          See also Optimal Flexible Architecture        Oracle base directory
OINSTALL directory, B-4                                    about, 1
OINSTALL groupl, 4                                         installation, 1
          See also Oracle Inventory directory           Oracle base home, D-2
operating system                                        Oracle Clusterware
    reviewing common practices, 7                          installed before Oracle Database, 3
operating system privileges groups, 4                   Oracle components
operating systems, supported, 4                            using in different languages, 14
Optimal Flexible Architecture, B-1                      Oracle Database, 9
    about, B-1                                             Automatic Storage Management, configuring
ORAchk                                                               communication with, 9
    and Upgrade Readiness Assessment, 5                    checking installed contents, 2
Oracle ACFS                                                creating data file directories, 10
    enabling, 22                                           getting started using, 1
Oracle ASM, 7                                                   accessing, 4, 5
    disk groups, 7                                              starting and stopping database, 4, 5
    disk space, 10                                         minimum disk space requirements, 9
    failure groups, 7                                      requirements with Oracle Automatic Storage
    recommendations for disk groups, 7                               Management, 7
          See also Oracle Automatic Storage
                                                           starting and stopping, 4
          Management


Database Installation Guide
E96293-13                                                                                   November 12, 2025
Copyright © 2015, 2025, Oracle and/or its affiliates.                                        Index-4 of Index-8
                                                                                                                    Index


Oracle Database (continued)                                    Oracle Optimal Flexible Architecture
   Windows Terminal Services support, 5                            See Optimal Flexible Architecture
          See also installation, postinstallation, removing,   Oracle Oracle Services for Microsoft Transaction
          requirements                                                  Server
Oracle Database Advanced Queuing, 6                                ports
Oracle Database Client                                                  changing, F-3
   requirements, 5                                             Oracle Provider for OLE DB
Oracle Database Configuration Assistant (DBCA)                     behavior with multiple Oracle homes, 3
   about, 4                                                    Oracle Real Application Clusters (RAC)
   computers with minimum memory, 3                                installed before Oracle Database, 3
   suppressing during silent or response file                  Oracle Restart
             installation, C-5                                     deconfiguring, 3
Oracle Database Configuration Assistant (Oracle                    description, 1
        DBCA)                                                      downgrading, 3
   response files, C-6                                             Installing, 18
Oracle Database Upgrade Assistant, computers                       password file, C-10
        with minimum memory, 3                                     troubleshooting, 3
Oracle Database Vault                                          Oracle Schemas, ii
   audit policy, 3                                             oracle service user, 3
Oracle Disk Manager (ODM)                                      Oracle Services for Microsoft Transaction Server
   library file, 6                                                 ports
Oracle Enterprise Manager,                                              ranges and protocol, F-2
   Database Control                                            Oracle SQL Developer
        using to modify control files, 14                          accessing, 5
        using to modify redo log files, 14                     Oracle Technology Network (OTN)
        using to view control files, 14                            downloading software from, 6
        using to view redo log files, 14                       Oracle Text knowledge base, 7
Oracle Enterprise Manager (OEM)                                Oracle Universal Installer
   jobs system, setting correct credentials, 8                     location of executable, C-5
   preinstallation requirements, 10                                running in different languages, 14
Oracle Enterprise Manager Database Express                     Oracle Universal Installer (OUI),
   logging into, 2                                                 guidelines in using, 3
   password management, 10                                         installation guidelines, 3
   port number, 2                                                  response files, C-1
Oracle home                                                        running at command line, C-5
   file path, B-4                                              oracle user, 4
   Grid home                                                   Oracle XML DB
        filepath, B-4                                              ports, ranges and protocol, F-2
   naming conventions, B-3                                     ORACLE_BASE_CONFIG, D-2, D-5
Oracle home directory                                          ORACLE_BASE_HOME, D-2, D-5
   about, 2                                                    ORACLE_HOME, D-5
   multiple homes, network considerations, E-1                 ORACLE_HOME environment variable
   multiple homes, precedence of components, 3                     preventing installation, 2
   single Oracle home components, 3                            ORACLE_HOSTNAME environment variable
Oracle host name, setting before installation, E-1                 computers with multiple aliases, E-2
Oracle Inventory, 4                                                setting before installation, E-1
Oracle Messaging Gateway feature, 6                            Oracle-managed files feature, 11
Oracle Net Listener                                            oraInventory, B-4
   ports                                                       oranfstab configuration file, 3
        ranges and protocol, F-2                               OSDBA, 4
Oracle Net Services
   configuring, 6
   postinstallation task, 6                                    P
   stopping existing listener, 11                              partition
Oracle Net Services Configuration Assistant,                       using with Oracle Automatic Storage
        computers with minimum memory, 3                                   Management, 7


Database Installation Guide
E96293-13                                                                                              November 12, 2025
Copyright © 2015, 2025, Oracle and/or its affiliates.                                                   Index-5 of Index-8
                                                                                                           Index


partitions, 12                                          primary network adapters, E-3
          See also diskpart.exe tool                        how determined, E-3
password file for Oracle Automatic Storage                      See also loopback adapters, network adapters
         Management, 7                                  process, stopping existing listener process, 11
passwords                                               proxy realm, 5
    change after install, 6
    for administrative accounts, 6
    guidelines, 9
                                                        R
    managing in SQL*Plus, 11                            RAID (Redundant Array of Independent Disks)
patch updates, 1                                            using for Oracle data files, 8
PDBs, C-9                                               read only Oracle home, D-3
PGA                                                     read-only oracle home, D-1, D-2, D-5
    and memory management, 5                            read-only Oracle home, D-2
PL/SQL                                                  read/write oracle home, D-5
    external procedures postinstallation task, 8        recommendations
ports                                                       on performing software-only installations, 19
    Connection Manager, ranges and protocol,            recovery files, options for placing on file system, 8
              F-2                                       redo log files
    default ranges, F-1                                     in starter database, 13
    Oracle Net Listener                                     using Oracle Enterprise Manager Database
         ranges and protocol, F-2                                    Control with, 14
    Oracle Services for Microsoft Transaction           redundancy level
              Server                                        and space requirements for preconfigured
         changing, F-3                                               database, 7
    Oracle Services for Microsoft Transaction               for Oracle Automatic Storage Management, 7
              Server, ranges and protocol, F-2          Redundant Array of Independent Disks
    Oracle XML DB, ranges and protocol, F-2                 See RAID
postinstallation                                        release update revisions, 1
    configuration of Oracle software, C-10              release updates, 1
postinstallation tasks, 1                               releases
    changing passwords, 9                                   multiple, B-2
    configuring secure sockets layer, 4                 remote access software, 8
    database-to-Automatic Storage Management            remote installations
              communication, 9                              DVD drive, 9
    getting started using Oracle Database, 1                remote access software, 8
    Jobs system, 8                                      requirements, 7
    Oracle Messaging Gateway feature, 6                     for JRE, 2
    Oracle Net Services, 6                                  for Oracle Enterprise Manager, 10
    Oracle Text knowledge base, 7                           hard disk space, 2
    PL/SQL external procedures, 8                           hardware, verifying, 3
    setting job system credentials for Enterprise           Oracle Database Client, 5
              Manager, 8                                    software, 3
    shared server support, 8                                Windows Terminal Services, 5
preconfigured database                                  response file mode, C-1
    Oracle Automatic Storage Management disk                about, C-2
              space requirements, 7                             See also response file mode
    requirements when using Oracle Automatic                    See also response files, silent mode
              Storage Management, 7                     response files
preinstallation                                             about, C-1
    perform database backup, 3                              creating
    requirements for Oracle Database Security,                  with record mode, C-4
              10                                                with template, C-3
    requirements for Oracle Enterprise Manager,             dbca.rsp, C-3
              10                                            general procedure, C-2
preinstallation considerations, 2                           Net Configuration Assistant, C-5
                                                            netca.rsp, C-3


Database Installation Guide
E96293-13                                                                                     November 12, 2025
Copyright © 2015, 2025, Oracle and/or its affiliates.                                          Index-6 of Index-8
                                                                                                      Index


response files (continued)                              T
    Oracle Database Configuration Assistant
             (DBCA), C-6                                tablespaces, 13
    passing values at command line, C-2                     expanding for large sorts, 13
    specifying with Oracle Universal Installer, C-5         in database, 13
    using, C-1                                              SYSTEM, 13
response files installation                                 TEMP, 13
    about, C-1                                              UNDOTBS, 13
roohctl -enable, D-3                                        USERS, 13
running multiple Oracle releases, B-2                   TEMP
                                                            tablespace (temp01.dbf), 13
                                                        TEMP environment variable, hardware
S                                                               requirements, 3
Sample Schemas                                          temp01.dbf data file, 13
    tablespaces and data files, 13                      temporary directory, 3
schemas                                                 temporary disk space
    Oracle Schemas, about, ii                               checking, 3
    Sample Schemas tablespaces and data files,              freeing, 3
             13                                         tmp directory
seamless patching, D-1                                      checking space in, 3
security                                                    freeing space in, 3
    Oracle Database Security Strong                     TMP environment variable, 4
             Authentication requirements, 10                hardware requirements, 3
server parameter file (SPFILE), 7                       TMPDIR environment variable, 4
SERVICE_NAMES parameter, 11                             tnsnames.ora file, 7
services, stopping, 10                                  troubleshooting
setup.exe                                                   cron jobs and installation, 5
     See Oracle Universal Installer (OUI)
SGA                                                     U
     and memory management, 5
shared server support, 8                                UNDOTBS
silent mode, C-2                                             tablespace (undotbs01.dbf), 13
     about, C-2                                         unsupported components
          See also response file mode, response files        on Windows Terminal Services, 5
single Oracle home components, 3                        upgrade
SPFILE server parameter file, 7                              Oracle Automatic Storage Management, 15
SQL Developer                                           upgrading
    accessing, 5                                             and ORAchk Upgrade Readiness
SQL*Plus                                                             Assessment, 5
    accessing, 4                                             backing up before upgrading, 3
    password management, 11                             user account control, 11
sqlnet.ora file, enabling Windows native                user accounts, managing, 11
        authentication, 9                               user names
SSL, 4                                                       changing passwords, 9
stopping existing services, 10                          USERS
SYSTEM                                                       tablespace (users01.dbf), 13
    tablespace, description, 13                         utlrp.sql, 3
system privileges accounts
    locked after install, 6
system requirements                                     W
    on NTFS file systems, 2                             Windows
system01.dbf data file, 13                                 compilers, supported, 4
                                                           credentials for job system, 8
                                                           network protocol, supported, 5
                                                           operating systems, supported, 4



Database Installation Guide
E96293-13                                                                                November 12, 2025
Copyright © 2015, 2025, Oracle and/or its affiliates.                                     Index-7 of Index-8
                                                                                                          Index


Windows 7                                               Windows Services utility, starting and stopping
   user account control, 11                                   databases, 4
Windows 8                                               Windows Terminal Services
   user account control, 11                                support, 5
Windows Server 2008                                        unsupported components, 5
   user account control, 11
Windows Server 2008 R2
   user account control, 11




Database Installation Guide
E96293-13                                                                                   November 12, 2025
Copyright © 2015, 2025, Oracle and/or its affiliates.                                        Index-8 of Index-8

