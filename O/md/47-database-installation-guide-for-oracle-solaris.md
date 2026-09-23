# 47. Database Installation Guide for Oracle Solaris

> 源文件: `en/ssdbi/database-installation-guide-oracle-solaris.pdf`

Oracle® Database
Database Installation Guide




    19c for Oracle Solaris
    E96434-12
    April 2026
Oracle Database Database Installation Guide, 19c for Oracle Solaris

E96434-12

Copyright © 2015, 2026, Oracle and/or its affiliates.

Primary Authors: Prakash Jashnani, Tejas N K

Contributing Authors: Douglas Williams, Subhash Chandra

Contributors: Neha Avasthy, Jean-Francois Verrier, Prasad Bagal, Subhranshu Banerjee, Mark Bauer, Parvathi
Subramanian, Tammy Bednar, Eric Belden, Gavin Bowe, Gia-Khanh Nguyen, Bernard Clouse, Darcy Christensen, Kiran
Chamala, Sampath Ravindhran, Jonathan Creighton, Benoit Dageville, Sudip Datta, Sharad Raju, Christopher Jones,
Rajendra Sahoo, Santosh Loke, Alta Elstad, Peter Dennis, Jim Erickson, Marcus Fallen, Joseph Francis, Alan
Coopersmith, Mark Fuller, Allan Graves, Barbara Glover, Asad Hasan, Subrahmanyam Kodavaluru, Thirumaleshwara
Hasandka, Shasank Chavan, Lisa Shepherd, Clara Jaeckel, Aneesh Khandelwal, Maria Colgan, Eugene Karichkin, Jai
Krishnani, Sangeeth Kumar, Ranjith Kundapur, Kevin Jernigan, Christopher Jones, Simon Law, Bryn Llewellyn, Saar
Maoz, Sreejith Minnanghat, Gopal Mulagund, Sue Lee, Rich Long, Barb Lundhild, Prasad Kuruvadi Nagaraj,
Rudregowda Mallegowda, Padmanabhan Manavazhi, Mughees Minhas, Krishna Mohan, Matthew McKerley, John
McHugh, Gurudas Pai, Satish Panchumarthy , Rajesh Prasad, Rajendra Pingte, Prasad K Kulkarni, Srinivas Poovala,
Mohammed Shahnawaz Quadri, Hanlin Qian, Gurumurthy Ramamurthy, Hema Ramamurthy, Sunil Ravindrachar, Mark
Richwine, Dipak Saggi, Logeshwaran Rajan, Rajesh Dasari, Angad Gokakkar , Anu Natarajan, Girdhari Ghantiyala,
Chandrasekharan Iyer, David Jimenez, Robert Achacoso, Vishal Saxena, Vasu Venkatasubramanian, Suman Palavalli,
Sameer Joshi, Malai Stalin, Markus Michalewicz, Michael Coulter, Trivikrama Samudrala, Ramesh Chakravarthula,
David Schreiner, Ara Shakian, David Price, Mohit Singhal, Dharma Sirnapalli, Akshay Shah, James Spiller, Roy
Swonger, Binoy Sukumaran, Anil Nair, Ravi Thammaiah, Tak Wang, Shekhar Vaggu, Ankur Kemkar, Ian Cookson,
Ajesh Viswambharan, Peter Wahl, Balaji Pagadala, Sivaram Soma, Sergiusz Wolicki, Sivakumar Yarlagadda, Alan Tam

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
           Audience                                                                                         i
           Documentation Accessibility                                                                      i
           Diversity and Inclusion                                                                         ii
           Set Up Java Access Bridge to Implement Java Accessibility                                       ii
           Command Syntax                                                                                  ii
           Related Documentation                                                                          iii
           Conventions                                                                                    iii


           Changes in this Release for Oracle Database
           New Features                                                                                     i
           Deprecated Features                                                                             ii
           Other Changes                                                                                   ii



1          Oracle Database Installation Checklist
           Server Hardware Checklist for Oracle Database Installation                                      1
           Operating System Checklist for Oracle Database on Oracle Solaris                                2
           Server Configuration Checklist for Oracle Database Installation                                 2
           Oracle User Environment Configuration Checklist for Oracle Database Installation                4
           Storage Checklist for Oracle Database Installation                                              5
           Installer Planning Checklist for Oracle Database                                                5
           Deployment Checklist for Oracle Database                                                        8



2          Checking and Configuring the Server for Oracle Database
           Logging In to a Remote System Using X Window System                                             1
           Checking Server Hardware and Memory Configuration                                               2



3          Automatically Configuring Oracle Solaris with Oracle Database
           Prerequisites Packages
           About the Oracle Database Prerequisites Packages for Oracle Solaris                             1


Database Installation Guide
E96434-12                                                                                     April 30, 2026
Copyright © 2015, 2026, Oracle and/or its affiliates.                                           Page i of vii
           Checking the Oracle Database Prerequisites Packages Installation                               2
           Installing the Oracle Database Prerequisites Packages for Oracle Solaris                       3



4          Configuring Oracle Solaris Operating System for Oracle Database
           Guidelines for Oracle Solaris Operating System Installation                                    1
           Reviewing Operating System and Software Upgrade Best Practices                                 2
                 General Upgrade Best Practices                                                           2
                 New Server Operating System Upgrade Option                                               2
                 Oracle ASM Upgrade Notifications                                                         3
           Reviewing Operating System Security Common Practices                                           4
           About Installation Fixup Scripts                                                               4
           About Operating System Requirements                                                            5
           Operating System Requirements for Oracle Solaris on SPARC (64-bit)                             5
                 Supported Oracle Solaris 11 Releases for SPARC (64-bit)                                  5
           Operating System Requirements for Oracle Solaris on x86–64 (64-Bit)                            6
                 Supported Oracle Solaris 11 Releases for x86-64 (64-Bit)                                 7
           Additional Drivers and Software Packages for Oracle Solaris                                    8
                 Installing Oracle Messaging Gateway                                                      8
                 Installation Requirements for ODBC and LDAP                                              8
                      About ODBC Drivers and Oracle Database                                              9
                      Installing ODBC Drivers for Oracle Solaris                                          9
                      About LDAP and Oracle Plug-ins                                                      9
                      Installing the LDAP Package                                                         9
                 Installation Requirements for Programming Environments for Oracle Solaris                9
                 Installation Requirements for Web Browsers                                             10
           Checking the Software Requirements for Oracle Solaris                                        10
                 Verifying Operating System Version on Oracle Solaris                                   11
                 Verifying Operating System Packages on Oracle Solaris                                  11
           Confirming Host Name Resolution                                                              12
           Using Automatic SSH Configuration During Installation                                        12



5          Configuring Users, Groups and Environments for Oracle Grid
           Infrastructure and Oracle Database
           Required Operating System Groups and Users                                                     1
                 Determining If an Oracle Inventory and Oracle Inventory Group Exist                      2
                 Creating the Oracle Inventory Group If an Oracle Inventory Does Not Exist                2
                 About Oracle Installation Owner Accounts                                                 3
                 Identifying an Oracle Software Owner User Account                                        3
           Oracle Installations with Standard and Job Role Separation Groups and Users                    4
                 About Oracle Installations with Job Role Separation                                      5



Database Installation Guide
E96434-12                                                                                    April 30, 2026
Copyright © 2015, 2026, Oracle and/or its affiliates.                                         Page ii of vii
                 Standard Oracle Database Groups for Database Administrators                        5
                 Extended Oracle Database Groups for Job Role Separation                            6
                 Creating an ASMSNMP User                                                           7
                 Oracle Automatic Storage Management Groups for Job Role Separation                 7
           Creating Operating System Privileges Groups                                              8
                 Creating the OSDBA for ASM Group                                                   8
                 Creating the OSOPER for ASM Group                                                  9
                 Creating the OSDBA Group for Database Installations                                9
                 Creating an OSOPER Group for Database Installations                                9
                 Creating the OSBACKUPDBA Group for Database Installations                        10
                 Creating the OSDGDBA Group for Database Installations                            10
                 Creating the OSKMDBA Group for Database Installations                            10
                 Creating the OSRACDBA Group for Database Installations                           10
           Creating Operating System Oracle Installation User Accounts                            10
                 Creating an Oracle Software Owner User                                           11
                 Environment Requirements for Oracle Software Owners                              11
                 Procedure for Configuring Oracle Software Owner Environments                     12
                 Modifying Oracle Owner User Groups                                               15
                 Preventing Installation Errors Caused by Terminal Output Commands                15
           Creating Oracle Database Vault User Accounts                                           16
           Unsetting Oracle Installation Owner Environment Variables                              16



6          Configuring Networks for Oracle Database
           About Oracle Database Network Configuration Options                                      1
           About Assigning Global Database Names During Installation                                2
           Network Configuration for Computers Completed After Installation                         3
           Network Configuration for Multihome Computers                                            3
           Setting the ORACLE_HOSTNAME Environment Variable                                         4
           Network Configuration for Computers with Multiple Aliases                                4



7          Supported Storage Options for Oracle Database and Oracle Grid
           Infrastructure
           Supported Storage Options for Oracle Database                                            1
           About Oracle Grid Infrastructure for a Standalone Server                                 2
           About Upgrading Existing Oracle Automatic Storage Management Instances                   3
           About Managing Disk Groups for Older Database Versions                                   4
           Oracle ACFS and Oracle ADVM                                                              4
                 Oracle ACFS and Oracle ADVM Support on Oracle Solaris                              4
                 Restrictions and Guidelines for Oracle ACFS                                        5
           File System Options for Oracle Database                                                  6



Database Installation Guide
E96434-12                                                                             April 30, 2026
Copyright © 2015, 2026, Oracle and/or its affiliates.                                  Page iii of vii
           Guidelines for Placing Oracle Database Files On a File System or Logical Volume                           6
           About NFS Storage for Data Files                                                                          7
           About Direct NFS Client Mounts to NFS Storage Devices                                                     8



8          Configuring File System Storage for Oracle Database
           Configuring NFS Buffer Size Parameters for Oracle Database                                                1
           Checking TCP Network Protocol Buffer for Direct NFS Client                                                2
           Creating an oranfstab File for Direct NFS Client                                                          2
           Enabling and Disabling Direct NFS Client Control of NFS                                                   5
           Enabling Hybrid Columnar Compression on Direct NFS Client                                                 6



9          Configuring Storage for Oracle Grid Infrastructure for a Standalone
           Server
           Configuring Storage for Oracle Automatic Storage Management                                               2
                 Identifying Storage Requirements for Oracle Automatic Storage Management                            2
                 Oracle ASM Disk Space Requirements                                                                  5
                 ASM Disk Group Options for Installation                                                             6
                 Using an Existing Oracle ASM Disk Group                                                             6
           Configuring Storage Device Path Persistence Using Oracle ASMFD                                            7
                 About Oracle ASM with Oracle ASM Filter Driver                                                      7
                 Guidelines for Installing Oracle ASMFD on Oracle Solaris                                            8
           Configuring Disk Devices for Oracle ASM on Oracle Solaris                                                 8
           Creating DAS or SAN Disk Partitions for Oracle Automatic Storage Management                             10
           Creating Directories for Oracle Database Files                                                          10
           Creating Files on a NAS Device for Use with Oracle Automatic Storage Management                         11



10         Installing and Configuring Oracle Grid Infrastructure for a Standalone
           Server
           About Image-Based Oracle Grid Infrastructure Installation                                                 2
           Setup Wizard Installation Options for Creating Images                                                     2
           Installing Oracle Grid Infrastructure for a Standalone Server                                             3
           Installing Oracle Grid Infrastructure for a Standalone Server for an Existing Database                    5
           Installing Oracle Grid Infrastructure for a Standalone Server Using a Software-Only
           Installation                                                                                              6
                 About Oracle Grid Infrastructure Software-Only Installations                                        6
                 Installing Software Binaries for Oracle Grid Infrastructure for a Standalone Server                 7
                 Configuring Software Binaries for Oracle Grid Infrastructure for a Standalone Server                8
           Testing the Oracle Automatic Storage Management Installation                                              9
           Relinking Oracle Restart and Oracle ASM Binaries                                                          9



Database Installation Guide
E96434-12                                                                                               April 30, 2026
Copyright © 2015, 2026, Oracle and/or its affiliates.                                                    Page iv of vii
           Configuring Oracle ASM Disk Groups Manually using Oracle ASMCA                                          10
           Enabling Oracle ACFS on Oracle Restart Configurations                                                   10
           Applying Patches During an Oracle Grid Infrastructure Installation or Upgrade                            11
           Patching and Switching Oracle Grid Infrastructure Homes                                                 12



11         Installing Oracle Database
           About Image-Based Oracle Database Installation                                                            2
           About Deploying Oracle Database Using Oracle Fleet Patching and Provisioning                              2
           Downloading Oracle Software                                                                               3
                 Downloading the Software from Oracle Software Delivery Cloud Portal                                 3
                 Downloading the Installation Archive Files from Oracle Website                                      3
           About Character Set Selection During Installation                                                         4
           About Automatic Memory Management Installation Options                                                    5
           Running the Installer in a Different Language                                                             6
           Installing the Oracle Database Software                                                                   6
                 Setup Wizard Installation Options for Creating Images                                               7
                 Applying Patches During an Oracle Database Installation or Upgrade                                  7
                 Running Oracle Database Setup Wizard to Install Oracle Database                                     8
           Installing Standard Edition High Availability                                                             9
                 About Standard Edition High Availability                                                          10
                 Requirements for Installing Standard Edition High Availability                                    10
                 Deploying Standard Edition High Availability                                                       11
                      Installing Standard Edition High Availability Database Software on Local File System          11
                      Installing Standard Edition High Availability Database Software on Oracle ACFS               13



12         Oracle Database Postinstallation Tasks
           Required Postinstallation Tasks                                                                           1
                 Downloading Release Update Patches                                                                  2
                 Unlocking and Resetting Oracle Database User Passwords                                              2
                      Requirements for Database Passwords                                                            3
                      Oracle Database System Privileges Accounts and Passwords                                       3
                      Guidelines for Changing System Privileges Account Passwords                                    6
                      Locking and Unlocking User Accounts                                                            7
                      Using SQL*Plus to Unlock Accounts and Reset Passwords                                          7
           Recommended Postinstallation Tasks                                                                        8
                 Creating a Backup of the root.sh Script                                                             8
                 Setting Language and Locale Preferences for Client Connections                                      8
                 Recompile Invalid Objects in the Database                                                           9
                 About Installing Oracle Autonomous Health Framework                                                11
                 Enabling Data Analytics Accelerators on SPARC for Oracle Database                                 12



Database Installation Guide
E96434-12                                                                                                April 30, 2026
Copyright © 2015, 2026, Oracle and/or its affiliates.                                                     Page v of vii
           About Changes in Default SGA Permissions for Oracle Database                                12
           Checking Installed Oracle Database Contents and Directory Location                          13
           Enabling and Disabling Oracle Database Options After Installation                           13
                 Chopt Tool                                                                            13
           Starting Oracle Enterprise Manager Database Express                                         14
           Creating a Fast Recovery Area                                                               15
                 About the Fast Recovery Area and the Fast Recovery Area Disk Group                    15
                 Creating the Fast Recovery Area Disk Group                                            16
           Cloning an Oracle Database Home                                                             16



13         Removing Oracle Database Software
           About Oracle Deinstallation Options                                                           1
           Oracle Deinstallation (Deinstall)                                                             3
           Deinstallation Examples for Oracle Database                                                   5
           Downgrading Oracle Restart                                                                    5
           Deinstalling Previous Release Grid Home                                                       7



14         Completing Preinstallation Tasks Manually
           Configuring Kernel Parameters on Oracle Solaris                                               1
                 Minimum Parameter Settings for Installation                                             1
                 Checking Shared Memory Resource Controls                                                3
                 Configuring Additional Shared Memory Identifiers Limit                                  3
                 Displaying and Changing Kernel Parameter Values                                         4
                 Setting UDP and TCP Kernel Parameters Manually                                          5
           Configuring Shell Limits for Oracle Solaris                                                   6



A          Response Files
           How Response Files Work                                                                    A-1
           Reasons for Using Silent Mode or Response File Mode                                        A-2
           Using Response Files                                                                       A-2
           Preparing Response Files                                                                   A-3
                 Editing a Response File Template                                                     A-3
                 Recording Response Files                                                             A-4
           Running Oracle Universal Installer Using a Response File                                   A-5
           Running Configuration Assistants Using Response Files                                      A-7
                 Running Net Configuration Assistant Using Response Files                             A-7
                 Running Oracle DBCA Using Response Files                                             A-8
           Postinstallation Configuration Using Response File Created During Installation             A-9
                 Using the Installation Response File for Postinstallation Configuration              A-9



Database Installation Guide
E96434-12                                                                                   April 30, 2026
Copyright © 2015, 2026, Oracle and/or its affiliates.                                        Page vi of vii
                 Running Postinstallation Configuration Using Response File                      A-10
           Postinstallation Configuration Using the ConfigToolAllCommands Script                 A-12
                 About the Postinstallation Configuration File                                   A-12
                 Creating a Password Response File                                               A-13
                 Running Postinstallation Configuration Using a Password Response File           A-14



B          Optimal Flexible Architecture
           About the Optimal Flexible Architecture Standard                                        B-1
           About Multiple Oracle Homes Support                                                     B-2
           About the Oracle Inventory Directory and Installation                                   B-2
           Oracle Base Directory Naming Convention                                                 B-4
           Oracle Home Directory Naming Convention                                                 B-4
           Optimal Flexible Architecture File Path Examples                                        B-5



C          Configuring Read-Only Oracle Homes
           Evolution of Oracle Homes                                                               C-1
                 About Read-Only Oracle Homes                                                      C-2
                 About Oracle Base Homes                                                           C-2
                 About Oracle Base Config                                                          C-3
                 About orabasetab                                                                  C-3
           Enabling a Read-Only Oracle Home                                                        C-4
           Copying demo Directories to Oracle Base Home                                            C-6
           Determining if an Oracle Home is Read-Only                                              C-8
           File Path and Directory Changes in Read-Only Oracle Homes                               C-9



D          Managing Oracle Database Port Numbers
           About Managing Ports                                                                    D-1
           Oracle Database Component Port Numbers and Protocols                                    D-1


           Index




Database Installation Guide
E96434-12                                                                                April 30, 2026
Copyright © 2015, 2026, Oracle and/or its affiliates.                                    Page vii of vii
Preface
                      This guide explains how to install and configure single-instance Oracle Database.
                      This guide also provides information about Optimal Flexible Architecture, cloning an Oracle
                      home, and how to remove the database software.
                      •     Audience
                            This guide is intended for anyone responsible for installing Oracle Database 19c.
                      •     Documentation Accessibility
                      •     Diversity and Inclusion
                      •     Set Up Java Access Bridge to Implement Java Accessibility
                            Install Java Access Bridge so that assistive technologies on Microsoft Windows systems
                            can use the Java Accessibility API.
                      •     Command Syntax
                            Refer to these command syntax conventions to understand command examples in this
                            guide.
                      •     Related Documentation
                            The related documentation for Oracle Database products includes the following manuals:
                      •     Conventions


Audience
                      This guide is intended for anyone responsible for installing Oracle Database 19c.
                      Additional installation guides for Oracle Database, Oracle Real Application Clusters, Oracle
                      Clusterware, Oracle Database Examples, and Oracle Enterprise Manager Cloud Control are
                      available at the following URL:
                      http://docs.oracle.com


Documentation Accessibility
                      For information about Oracle's commitment to accessibility, visit the Oracle Accessibility
                      Program website at http://www.oracle.com/pls/topic/lookup?ctx=acc&id=docacc.

                      Access to Oracle Support
                      Oracle customer access to and use of Oracle support services will be pursuant to the terms
                      and conditions specified in their Oracle order for the applicable services.




Database Installation Guide
E96434-12                                                                                                   April 30, 2026
Copyright © 2015, 2026, Oracle and/or its affiliates.                                                         Page i of iv
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
                      •     Java Platform, Standard Edition Java Accessibility Guide


Command Syntax
                      Refer to these command syntax conventions to understand command examples in this guide.


                       Convention               Description
                       $                        Bourne or BASH shell prompt in a command example. Do not enter the prompt as
                                                part of the command.
                       %                        C Shell prompt in a command example. Do not enter the prompt as part of the
                                                command.
                       #                        Superuser (root) prompt in a command example. Do not enter the prompt as part
                                                of the command.
                       monospace                UNIX command syntax
                       backslash \              A backslash is the UNIX and Linux command continuation character. It is used in
                                                command examples that are too long to fit on a single line. Enter the command as
                                                displayed (with a backslash) or enter it on a single line without a backslash:

                                                dd if=/dev/rdsk/c0t1d0s6 of=/dev/rst0 bs=10b \               count=10000


                       braces { }               Braces indicate required items:

                                                .DEFINE {macro1}




Database Installation Guide
E96434-12                                                                                                            April 30, 2026
Copyright © 2015, 2026, Oracle and/or its affiliates.                                                                  Page ii of iv
                                                                                                                               Preface




                       Convention               Description
                       brackets [ ]             Brackets indicate optional items:

                                                cvtcrt termname [outfile]


                       ellipses ...             Ellipses indicate an arbitrary number of similar items:

                                                CHKVAL fieldname value1 value2 ... valueN


                       italic                   Italic type indicates a variable. Substitute a value for the variable:

                                                library_name


                       vertical line |          A vertical line indicates a choice within braces or brackets:

                                                FILE filesize [K|M]




Related Documentation
                      The related documentation for Oracle Database products includes the following manuals:
                      Related Topics
                      •     Oracle Database Concepts
                      •     Oracle Database New Features Guide
                      •     Oracle Database Licensing Information
                      •     Oracle Database Release Notes
                      •     Oracle Grid Infrastructure Installation Guide
                      •     Oracle Database Client Installation Guide for Oracle Solaris
                      •     Oracle Database Examples Installation Guide
                      •     Oracle Real Application Clusters Installation Guide for Linux and UNIX
                      •     Oracle Database Administrator's Reference for Linux and UNIX-Based Operating Systems
                      •     Oracle Automatic Storage Management Administrator's Guide
                      •     Oracle Database Upgrade Guide
                      •     Oracle Database 2 Day DBA
                      •     Oracle Application Express Installation Guide


Conventions
                      The following text conventions are used in this document:




Database Installation Guide
E96434-12                                                                                                                April 30, 2026
Copyright © 2015, 2026, Oracle and/or its affiliates.                                                                     Page iii of iv
                                                                                                                                  Preface




                       Convention                       Meaning
                       boldface                         Boldface type indicates graphical user interface elements associated with an
                                                        action, or terms defined in text or the glossary.
                       italic                           Italic type indicates book titles, emphasis, or placeholder variables for which
                                                        you supply particular values.
                       monospace                        Monospace type indicates commands within a paragraph, URLs, code in
                                                        examples, text that appears on the screen, or text that you enter.




Database Installation Guide
E96434-12                                                                                                                    April 30, 2026
Copyright © 2015, 2026, Oracle and/or its affiliates.                                                                         Page iv of iv
Changes in this Release for Oracle Database
                      Learn about the new features and changes in Oracle Database Installation Guide for Oracle
                      Database 19c.
                      •     New Features
                            Review new features available with Oracle Database installation in Oracle Database 19c.
                      •     Deprecated Features
                            Review features that are deprecated starting with Oracle Database 19c.
                      •     Other Changes
                            Review other changes for Oracle Database 19c.
                      Related Topics
                      •     Oracle Database New Features Guide


New Features
                      Review new features available with Oracle Database installation in Oracle Database 19c.
                      •     Root Scripts Automation Support for Oracle Database Installation
                      •     Simplified Image-Based Oracle Database Client Installation


Root Scripts Automation Support for Oracle Database Installation
                      Starting with Oracle Database 19c, the database installer, or setup wizard, provides options to
                      set up permissions to run the root configuration scripts automatically, as required, during a
                      database installation. You continue to have the option to run the root configuration scripts
                      manually.
                      Setting up permissions for root configuration scripts to run without user intervention can
                      simplify database installation and help avoid inadvertent permission errors.
                      Related Topics
                      •     Running Oracle Database Setup Wizard to Install Oracle Database
                            Extract the database image files and use the runInstaller command to start the
                            installation.


Simplified Image-Based Oracle Database Client Installation
                      Starting with Oracle Database 19c, the Oracle Database client software is available as an
                      image file for download and installation. You must extract the image software into a directory
                      where you want your Oracle home to be located, and then run the runInstaller script to
                      start the Oracle Database client installation. Oracle Database client installation binaries
                      continue to be available in the traditional format as non-image zip files.




Database Installation Guide
E96434-12                                                                                                   April 30, 2026
Copyright © 2015, 2026, Oracle and/or its affiliates.                                                          Page i of ii
                                                                                 Changes in this Release for Oracle Database


                      As with Oracle Database and Oracle Grid Infrastructure image file installations, Oracle
                      Database client image installations simplify Oracle Database client installations and ensure
                      best practice deployments.
                      Related Topics
                      •     Installing Oracle Database Client Using Image File


Deprecated Features
                      Review features that are deprecated starting with Oracle Database 19c.
                      The following feature is deprecated in this release, and may be desupported in another
                      release. For more information about deprecated and desupported features, parameters and
                      views, refer to Oracle Database Upgrade Guide.
                      •     Deprecation of Oracle ASMFD
                            Oracle ASM Filter Driver (ASMFD) is deprecated on both Linux and Oracle Solaris
                            beginning with Oracle Database 19c. It will be desupported in a future release.
                      •     Deprecation of clone.pl
                            The clone.pl script is deprecated in Oracle Database 19c. The functionality of performing
                            a software-only installation, using the gold image, is available in the installer wizard.
                            The clone.pl script can be removed in a future release. Instead of using the clone.pl
                            script, Oracle recommends that you install the extracted gold image as a home, using the
                            installer wizard.
                      •     Deprecation of the SERVICE_NAMES parameter
                            The use of the SERVICE_NAMES parameter is no longer actively supported. It must not be
                            used for high availability (HA) deployments. It is not supported to use service names
                            parameter for any HA operations. This restriction includes FAN, load balancing,
                            FAILOVER_TYPE, FAILOVER_RESTORE, SESSION_STATE_CONSISTENCY, and any other uses.

                      Related Topics
                      •     Oracle Database Upgrade Guide


Other Changes
                      Review other changes for Oracle Database 19c.
                      •     Rapid Home Provisioning Name Change
                            Starting with Oracle Database 19c and Oracle Grid Infrastructure 19c, Rapid Home
                            Provisioning is renamed to Fleet Patching and Provisioning (FPP).




Database Installation Guide
E96434-12                                                                                                      April 30, 2026
Copyright © 2015, 2026, Oracle and/or its affiliates.                                                            Page ii of ii
1
Oracle Database Installation Checklist
                      Use checklists to review system requirements, and to plan and carry out Oracle Database
                      installation.
                      Oracle recommends that you use checklists as part of your installation planning process. Using
                      checklists can help you to confirm that your server hardware and configuration meet minimum
                      requirements for this release, and can help you to ensure you carry out a successful
                      installation.
                      •     Server Hardware Checklist for Oracle Database Installation
                            Use this checklist to check hardware requirements for Oracle Database.
                      •     Operating System Checklist for Oracle Database on Oracle Solaris
                            Use this checklist to check minimum operating system requirements for Oracle Database.
                      •     Server Configuration Checklist for Oracle Database Installation
                            Use this checklist to check minimum server configuration requirements for Oracle
                            Database installations.
                      •     Oracle User Environment Configuration Checklist for Oracle Database Installation
                            Use this checklist to plan operating system users, groups, and environments for Oracle
                            Database management.
                      •     Storage Checklist for Oracle Database Installation
                            Use this checklist to review storage minimum requirements and assist with configuration
                            planning.
                      •     Installer Planning Checklist for Oracle Database
                            Use this checklist to assist you to be prepared before starting Oracle Universal Installer.
                      •     Deployment Checklist for Oracle Database
                            Use this checklist to decide the deployment method for a single-instance Oracle Database.


Server Hardware Checklist for Oracle Database Installation
                      Use this checklist to check hardware requirements for Oracle Database.

                      Table 1-1       Server Hardware Checklist for Oracle Database Installation

                       Check                Task
                       Runlevel             3
                       Server Display       At least 1024 x 768 display resolution, which Oracle Universal Installer requires.
                       Cards
                       Minimum              Server is connected to a network
                       network
                       connectivity
                       Minimum RAM          •    At least 1 GB RAM for Oracle Database installations. 2 GB RAM recommended.
                                            •    At least 8 GB RAM for Oracle Grid Infrastructure installations.




Database Installation Guide
E96434-12                                                                                                                April 30, 2026
Copyright © 2015, 2026, Oracle and/or its affiliates.                                                                      Page 1 of 9
                                                                                                                              Chapter 1
                                                                       Operating System Checklist for Oracle Database on Oracle Solaris




Operating System Checklist for Oracle Database on Oracle
Solaris
                      Use this checklist to check minimum operating system requirements for Oracle Database.

                      Table 1-2       Operating System General Checklist for Oracle Database on Oracle Solaris

                       Item                        Task
                       Operating system            Secure Shell is configured at installation for Oracle Solaris.
                       general requirements        The following Oracle Solaris on SPARC (64-Bit) kernels are supported:

                                                   Oracle Solaris 11.4 (Oracle Solaris 11.4.2.0.1.3.0) or later SRUs and
                                                   updates
                                                   Oracle Solaris 11.3 SRU 31 (Oracle Solaris 11.3.31.6.0) or later SRUs
                                                   and updates
                                                   The following Oracle Solaris on x86-64 (64-Bit) kernels are supported:

                                                   Solaris 11.4 (Oracle Solaris 11.4.2.0.1.3.0) or later SRUs and updates
                                                   Oracle Solaris 11.3 SRU 31 (Oracle Solaris 11.3.31.6.0) or later SRUs
                                                   and updates

                                                   Review the system requirements section for a list of minimum package
                                                   requirements.

                      Related Topics
                      •     Configuring Oracle Solaris Operating System for Oracle Database
                            Complete operating system configuration requirements and checks for Oracle Solaris
                            operating systems before you start installation.


Server Configuration Checklist for Oracle Database Installation
                      Use this checklist to check minimum server configuration requirements for Oracle Database
                      installations.

                      Table 1-3       Server Configuration Checklist for Oracle Database

                       Check                                 Task
                       Disk space allocated to               At least 1 GB of space in the temporary disk space (/tmp) directory
                       the /tmp directory
                       Swap space allocation relative
                       to RAM (Oracle Database)              Between 1 GB and 2 GB: 1.5 times the size of the RAM
                                                             Between 2 GB and 16 GB: Equal to the size of the RAM
                                                             More than 16 GB: 16 GB
                                                             Note: Configure swap for your expected system loads. This
                                                             installation guide provides minimum values for installation only.
                                                             Refer to your Oracle Solaris documentation for additional
                                                             memory tuning guidance.




Database Installation Guide
E96434-12                                                                                                                April 30, 2026
Copyright © 2015, 2026, Oracle and/or its affiliates.                                                                      Page 2 of 9
                                                                                                                             Chapter 1
                                                                       Server Configuration Checklist for Oracle Database Installation



                      Table 1-3       (Cont.) Server Configuration Checklist for Oracle Database

                       Check                             Task
                       Swap space allocation relative
                       to RAM (Oracle Restart)           Between 8 GB and 16 GB: Equal to the size of the RAM
                                                         More than 16 GB: 16 GB
                                                         Note: Configure swap for your expected system loads. This
                                                         installation guide provides minimum values for installation only.
                                                         Refer to your Oracle Solaris documentation for additional
                                                         memory tuning guidance.

                       Oracle Inventory (oraInventory)   •     For upgrades, Oracle Universal Installer (OUI) detects an existing
                       and OINSTALL Group                      oraInventory directory from the /var/opt/oracle/
                       Requirements                            oraInst.loc file, and uses the existing oraInventory.
                                                         •     For new installs, if you have not configured an oraInventory
                                                               directory, then the installer creates an Oracle inventory that is one
                                                               directory level up from the Oracle base for the Oracle Grid
                                                               Infrastructure install, and designates the installation owner's
                                                               primary group as the Oracle Inventory group.
                                                         The Oracle Inventory directory is the central inventory of Oracle
                                                         software installed on your system. Users who have the Oracle
                                                         Inventory group as their primary group are granted the OINSTALL
                                                         privilege to write to the central inventory.
                                                         The OINSTALL group must be the primary group of all Oracle software
                                                         installation owners on the server. It should be writable by any Oracle
                                                         installation owner.
                       Groups and users                  Oracle recommends that you create groups and user accounts
                                                         required for your security plans before starting installation. Installation
                                                         owners have resource limits settings and other requirements. Group
                                                         and user names must use only ASCII characters.
                       Mount point paths for the         Oracle recommends that you create an Optimal Flexible Architecture
                       software binaries                 configuration as described in the appendix "Optimal Flexible
                                                         Architecture" in Oracle Database Installation Guide for your platform.
                       Ensure that the Oracle home       The ASCII character restriction includes installation owner user
                       (the Oracle home path you         names, which are used as a default for some home paths, as well as
                       select for Oracle Database)       other directory names you may select for paths.
                       uses only ASCII characters
                       Unset Oracle software             If you have an existing Oracle software installation, and you are using
                       environment variables             the same user to install this installation, then unset the following
                                                         environment variables: $ORACLE_HOME; $ORA_NLS10; $TNS_ADMIN.
                                                         If you have set $ORA_CRS_HOME as an environment variable, then
                                                         unset it before starting an installation or upgrade. Do not
                                                         use $ORA_CRS_HOME as a user environment variable, except as
                                                         directed by Oracle Support.
                       Set locale (if needed)            Specify the language and the territory, or locale, in which you want to
                                                         use Oracle components. A locale is a linguistic and cultural
                                                         environment in which a system or program is running. NLS (National
                                                         Language Support) parameters determine the locale-specific behavior
                                                         on both servers and clients. The locale setting of a component
                                                         determines the language of the user interface of the component, and
                                                         the globalization behavior, such as date and number formatting.

                      Related Topics
                      •     Oracle Database Globalization Support Guide




Database Installation Guide
E96434-12                                                                                                               April 30, 2026
Copyright © 2015, 2026, Oracle and/or its affiliates.                                                                     Page 3 of 9
                                                                                                                               Chapter 1
                                                        Oracle User Environment Configuration Checklist for Oracle Database Installation




Oracle User Environment Configuration Checklist for Oracle
Database Installation
                      Use this checklist to plan operating system users, groups, and environments for Oracle
                      Database management.

                      Table 1-4       User Environment Configuration for Oracle Database

                       Check                               Task
                       Review Oracle Inventory             The physical group you designate as the Oracle Inventory directory is
                       (oraInventory) and OINSTALL         the central inventory of Oracle software installed on your system. It
                       Group Requirements                  should be the primary group for all Oracle software installation owners.
                                                           Users who have the Oracle Inventory group as their primary group are
                                                           granted the OINSTALL privilege to read and write to the central
                                                           inventory.
                                                           •    If you have an existing installation, then OUI detects the existing
                                                                oraInventory directory from the/var/opt/oracle/
                                                                oraInst.loc file, and uses this location.
                                                           •    If you are installing Oracle software for the first time, then you can
                                                                specify the Oracle inventory directory and the Oracle base
                                                                directory during the Oracle software installation, and Oracle
                                                                Universal Installer will set up the software directories for you.
                                                                Ensure that the directory paths that you specify are in compliance
                                                                with the Oracle Optimal Flexible Architecture recommendations.
                                                           Ensure that the group designated as the OINSTALL group is available
                                                           as the primary group for all planned Oracle software installation
                                                           owners.
                       Create operating system groups Create operating system groups and users depending on your security
                       and users for standard or role- requirements, as described in this install guide.
                       allocated system privileges     Set resource limits settings and other requirements for Oracle
                                                       software installation owners.
                                                           Group and user names must use only ASCII characters.
                       Unset Oracle Software               If you have had an existing installation on your system, and you are
                       Environment Variables               using the same user account for this installation, then unset the
                                                           ORACLE_HOME, ORACLE_BASE, ORACLE_SID, TNS_ADMIN
                                                           environment variables and any other environment variable set for the
                                                           Oracle installation user that is connected with Oracle software homes.
                       Configure the Oracle Software       Configure the environment of the oracle or grid user by performing
                       Owner Environment                   the following tasks:
                                                           •    Set the default file mode creation mask (umask) to 022 in the shell
                                                                startup file.
                                                           •    Set the DISPLAY environment variable.

                      Related Topics
                      •     Configuring Users, Groups and Environments for Oracle Grid Infrastructure and Oracle
                            Database
                            Before installation, create operating system groups and users, and configure user
                            environments.




Database Installation Guide
E96434-12                                                                                                                 April 30, 2026
Copyright © 2015, 2026, Oracle and/or its affiliates.                                                                       Page 4 of 9
                                                                                                                                 Chapter 1
                                                                                        Storage Checklist for Oracle Database Installation




Storage Checklist for Oracle Database Installation
                      Use this checklist to review storage minimum requirements and assist with configuration
                      planning.

                      Table 1-5       Storage Checklist for Oracle Database

                       Check                       Task
                       Minimum local disk
                       storage space for           For Oracle Solaris on SPARC (64-Bit):
                       Oracle software             At least 6.8 GB for an Oracle Grid Infrastructure for a standalone server
                                                   installation
                                                   At least 8.1 GB for Oracle Database Enterprise Edition
                                                   At least 7.9 GB for Oracle Database Standard Edition 2


                                                                               Note
                                                                               Oracle recommends that you allocate approximately
                                                                               100 GB to allow additional space for applying any
                                                                               future patches on top of the existing Oracle home.
                                                                               For specific patch-related disk space requirements,
                                                                               please refer to your patch documentation.



                       Select Database File        Ensure that you have one of the following storage options available:
                       Storage Option              •    File system mounted on the server. Oracle recommends that the file system
                                                        you select is separate from the file system used by the operating system or
                                                        the Oracle software. Options include the following:
                                                        –   A file system on a logical volume manager (LVM) volume or a RAID
                                                            device
                                                        – A network file system (NFS) mounted on a certified network-attached
                                                            storage (NAS) device
                                                        – Oracle Solaris ZFS file system.
                                                   •    Oracle Automatic Storage Management (Oracle ASM).
                                                        Oracle ASM is installed as part of an Oracle Grid Infrastructure installation.
                                                        If you plan to use Oracle ASM for storage, then you should install Oracle
                                                        Grid Infrastructure before you install and create the database.
                       Determine your              If you want to enable recovery during installation, then be prepared to select one
                       recovery plan               of the following options:
                                                   •    File system: Configure a fast recovery area on a file system during
                                                        installation
                                                   •    Oracle Automatic Storage Management
                                                   Review the storage configuration sections of this document for more information
                                                   about configuring recovery.



Installer Planning Checklist for Oracle Database
                      Use this checklist to assist you to be prepared before starting Oracle Universal Installer.




Database Installation Guide
E96434-12                                                                                                                   April 30, 2026
Copyright © 2015, 2026, Oracle and/or its affiliates.                                                                         Page 5 of 9
                                                                                                                               Chapter 1
                                                                                        Installer Planning Checklist for Oracle Database



                      Table 1-6       Oracle Universal Installer Planning Checklist for Oracle Database Installation

                       Check                            Task
                       Read the Release Notes           Review release notes for your platform, which are available for your release
                                                        at the following URL:
                                                        http://docs.oracle.com/en/database/database.html
                       Review Oracle Support            New platforms and operating system software versions may be certified
                       Certification Matrix             after this guide is published, review the certification matrix on the My
                                                        Oracle Support website for the most up-to-date list of certified hardware
                                                        platforms and operating system versions:
                                                        https://support.oracle.com/
                                                        You must register online before using My Oracle Support. After logging in,
                                                        from the menu options, select the Certifications tab. On the Certifications
                                                        page, use the Certification Search options to search by Product, Release,
                                                        and Platform. You can also search using the Certification Quick Link
                                                        options such as Product Delivery, and Lifetime Support.
                       Review the Licensing             You are permitted to use only those components in the Oracle Database
                       Information                      media pack for which you have purchased licenses. For more information
                                                        about licenses, refer to the following URL:
                                                        Oracle Database Licensing Information
                       Run OUI with CVU and use Oracle Universal Installer is fully integrated with Cluster Verification Utility
                       fixup scripts            (CVU), automating many CVU prerequisite checks. Oracle Universal
                                                Installer runs all prerequisite checks and creates fixup scripts when you run
                                                the installer. You can run OUI up to the Summary screen without starting
                                                the installation.
                                                        You can also run CVU commands manually to check system readiness. For
                                                        more information, see:
                                                        Oracle Clusterware Administration and Deployment Guide
                       Update and run Oracle            Oracle recommends that you update to the latest version of Oracle
                       ORAchk for runtime and           ORAchk by installing the latest version of Autonomous Health Framework
                       upgrade checks, or runtime       (AHF).
                       health checks                    The Oracle ORAchk utility provides system checks that can help to prevent
                                                        issues before and after installation. These checks include kernel
                                                        requirements, operating system resource allocations, and other system
                                                        requirements.
                                                        Use the Oracle ORAchk Upgrade Readiness Assessment to obtain an
                                                        automated upgrade-specific system health check for upgrades to 19c. For
                                                        example:
                                                        •   Before you perform a fresh database installation:

                                                            ./orachk -profile preinstall
                                                        •   To upgrade your existing database to a higher version or release:

                                                            ./orachk -pregupgrade -targetversion 19.0.0.0.0
                                                        The Oracle ORAchk Upgrade Readiness Assessment automates many of
                                                        the manual pre- and post-upgrade checks described in Oracle upgrade
                                                        documentation. Check My Oracle Support Note 2550798.1 for more
                                                        information about Oracle ORAchk support.
                                                        https://support.oracle.com/epmos/faces/DocContentDisplay?
                                                        id=2550798.1&parent=DOCUMENTATION&sourceId=USERGUIDE




Database Installation Guide
E96434-12                                                                                                                 April 30, 2026
Copyright © 2015, 2026, Oracle and/or its affiliates.                                                                       Page 6 of 9
                                                                                                                                 Chapter 1
                                                                                          Installer Planning Checklist for Oracle Database



                      Table 1-6 (Cont.) Oracle Universal Installer Planning Checklist for Oracle Database
                      Installation

                       Check                            Task
                       Verify if Oracle Grid            If you want to use Oracle ASM or Oracle Restart, then install Oracle Grid
                       Infrastructure is installed      Infrastructure for a standalone server before you install and create the
                                                        database. Otherwise, to use Oracle ASM, you must complete an Oracle
                                                        Grid Infrastructure installation, and then manually register the database
                                                        with Oracle Restart.
                                                        For Oracle Real Application Clusters (Oracle RAC) installations, ensure
                                                        that you have installed and configured Oracle Grid Infrastructure for a
                                                        cluster.
                       Check running Oracle             •   On a standalone database not using Oracle ASM: You do not need to
                       processes, and shut down             shut down the database while you install Oracle Grid Infrastructure.
                       if necessary                     •   On a standalone database using Oracle ASM: The Oracle ASM
                                                            instances are restarted during installation.
                                                        •   On an Oracle RAC Database node: This installation requires an
                                                            upgrade of Oracle Clusterware, as Oracle Clusterware is required to
                                                            run Oracle RAC. As part of the upgrade, you must shut down the
                                                            database one node at a time as the rolling upgrade proceeds from
                                                            node to node.
                       Ensure cron jobs do not          If the installer is running when daily cron jobs start, then you may
                       run during installation          encounter unexplained installation problems if your cron job is performing
                                                        cleanup, and temporary files are deleted before the installation is finished.
                                                        Oracle recommends that you complete installation before daily cron jobs
                                                        are run, or disable daily

                                                        cron

                                                        jobs that perform cleanup until after the installation is completed.
                       Obtain your My Oracle            During installation, you may require a My Oracle Support user name and
                       Support account                  password to configure updates, download software updates, and other
                       information.                     installation tasks. You can register for My Oracle Support at the following
                                                        URL:
                                                        https://support.oracle.com/
                       Decide Oracle Database           By default, Oracle Database is managed by Oracle Enterprise Manager
                       management tool                  Database Express.
                                                        If you have an existing Oracle Management Agent, and decide to use
                                                        Oracle Enterprise Manager Cloud Control to centrally manage your
                                                        database, then obtain the following information to enter during the
                                                        database installation:
                                                        •   OMS host
                                                        •   OMS port
                                                        •   EM admin username
                                                        •   EM admin password
                                                        •   Specify password of ASMSNMP user
                                                        For more information, see:
                                                        •   Oracle Database 2 Day DBA
                                                        •   Oracle Enterprise Manager Cloud Control Administrator’s Guide




Database Installation Guide
E96434-12                                                                                                                   April 30, 2026
Copyright © 2015, 2026, Oracle and/or its affiliates.                                                                         Page 7 of 9
                                                                                                                            Chapter 1
                                                                                             Deployment Checklist for Oracle Database



                      Table 1-6 (Cont.) Oracle Universal Installer Planning Checklist for Oracle Database
                      Installation

                       Check                            Task
                       Review memory allocation         You can enable automatic memory management either during, or after
                       and Automatic Memory             Oracle Database installation. If you enable automatic memory management
                       Management feature               after installation, then you must shut down and restart the database.
                                                        If the total physical memory of your database instance is greater than 4 GB,
                                                        then you cannot select the Oracle Automatic Memory Management option
                                                        during database installation and creation. Instead, use automatic shared
                                                        memory management. Automatic shared memory management
                                                        automatically distributes the available memory among the various
                                                        components as required, allowing the system to maximize the use of all
                                                        available SGA memory.
                                                        For more information, see:
                                                        Oracle Database Administrator's Guide
                       Determine superuser         During a database or grid infrastructure installation, you are asked to run
                       (root) privilege delegation configuration scripts as the root user.
                       option for installation     You can either run these scripts manually as root when prompted, or you
                                                   can provide configuration information and passwords using a root privilege
                                                   delegation option.
                                                        To run root scripts automatically, select Automatically run configuration
                                                        scripts during installation.
                                                        •   Use root user credentials
                                                            Provide the superuser password for cluster member node servers.
                                                        •   Use Sudo
                                                            Sudo is a UNIX and Linux utility that allows members of the sudoers
                                                            list privileges to run individual commands as root. Provide the
                                                            username and password of an operating system user that is a member
                                                            of sudoers, and is authorized to run Sudo on each cluster member
                                                            node.
                                                            To enable Sudo, have a system administrator with the appropriate
                                                            privileges configure a user that is a member of the sudoers list, and
                                                            provide the username and password when prompted during
                                                            installation.
                       Oracle Database Client           For information about interoperability between Oracle Database Client and
                       and Oracle Database              Oracle Database releases, see My Oracle Support Note 207303.1:
                       interoperability                 https://support.oracle.com/rs?type=doc&id=207303.1

                      Related Topics
                      •     Installing Oracle Database
                            Oracle Database and Oracle Grid Infrastructure installation software is available as image-
                            based zip files and can be installed using several options.
                      •     Installing and Configuring Oracle Grid Infrastructure for a Standalone Server
                            Oracle Grid Infrastructure for a standalone server includes Oracle Restart and Oracle
                            Automatic Storage Management.


Deployment Checklist for Oracle Database
                      Use this checklist to decide the deployment method for a single-instance Oracle Database.




Database Installation Guide
E96434-12                                                                                                               April 30, 2026
Copyright © 2015, 2026, Oracle and/or its affiliates.                                                                     Page 8 of 9
                                                                                                                            Chapter 1
                                                                                             Deployment Checklist for Oracle Database



                      Table 1-7       Deployment Checklist for Oracle Database (single-instance)

                       Item                        Task
                       To deploy single-           Use one of the following deployment methods:
                       instance Oracle             •    Install Oracle Database software using Oracle Universal Installer (OUI).
                       Database software           •    Provision Oracle Database software using Oracle Fleet Patching and
                                                        Provisioning.
                                                   •    Clone Oracle Database.
                       To deploy single-           Use one of the following deployment methods:
                       instance Oracle             •    Install Oracle Database software using Oracle Universal Installer (OUI).
                       Database software           •    Provision Oracle Database software using Oracle Fleet Patching and
                       and create databases             Provisioning.
                                                   •    Clone Oracle Database.
                       To create single-           •    Use Oracle Database Configuration Assistant (Oracle DBCA).
                       instance Oracle             •    Use Oracle Fleet Patching and Provisioning
                       Database in an
                       already-installed
                       Oracle home

                      Related Topics
                      •     Oracle Database Administrator’s Guide
                      •     Oracle Fleet Patching and Provisioning Administrator's Guide




Database Installation Guide
E96434-12                                                                                                               April 30, 2026
Copyright © 2015, 2026, Oracle and/or its affiliates.                                                                     Page 9 of 9
2
Checking and Configuring the Server for
Oracle Database
                      Verify that servers where you install Oracle Database meet the minimum requirements for
                      installation.
                      This section provides minimum server requirements to complete installation of Oracle
                      Database. It does not provide system resource guidelines, or other tuning guidelines for
                      particular workloads.
                      •     Logging In to a Remote System Using X Window System
                            Use this procedure to run Oracle Universal Installer (OUI) by logging on to a remote
                            system where the runtime setting prohibits logging in directly to a graphical user interface
                            (GUI).
                      •     Checking Server Hardware and Memory Configuration
                            Use this procedure to gather information about your server configuration.


Logging In to a Remote System Using X Window System
                      Use this procedure to run Oracle Universal Installer (OUI) by logging on to a remote system
                      where the runtime setting prohibits logging in directly to a graphical user interface (GUI).
                      OUI is a graphical user interface (GUI) application. On servers where the runtime settings
                      prevent GUI applications from running, you can redirect the GUI display to a client system
                      connecting to the server.


                                Note
                                If you log in as another user (for example, oracle or grid), then repeat this procedure
                                for that user as well.



                      1.    Start an X Window System session. If you are using an X Window System terminal
                            emulator from a PC or similar system, then you may need to configure security settings to
                            permit remote hosts to display X applications on your local system.
                      2.    Enter a command using the following syntax to enable remote hosts to display X
                            applications on the local X server:

                            # xhost + RemoteHost


                            RemoteHost is the fully qualified remote host name. For example:

                            # xhost + somehost.example.com
                            somehost.example.com being added to the access control list




Database Installation Guide
E96434-12                                                                                                     April 30, 2026
Copyright © 2015, 2026, Oracle and/or its affiliates.                                                           Page 1 of 3
                                                                                                                    Chapter 2
                                                                            Checking Server Hardware and Memory Configuration


                      3.    If you are not installing the software on the local system, then use the ssh command to
                            connect to the system where you want to install the software:

                            # ssh -Y       RemoteHost


                            RemoteHost is the fully qualified remote host name. The -Y flag ("yes") enables remote
                            clients to have full access to the original server display. For example:

                            # ssh -Y somehost.example.com

                      4.    If you are not logged in as the root user, and you are performing configuration steps that
                            require root user privileges, then switch the user to root.


                                Note
                                For more information about remote login using X Window System, refer to your X
                                server documentation, or contact your X server vendor or system administrator.
                                Depending on the X server software that you are using, you may have to complete the
                                tasks in a different order.




Checking Server Hardware and Memory Configuration
                      Use this procedure to gather information about your server configuration.
                      1.    Use the following command to report the number of memory pages and swap-file disk
                            blocks that are currently unused:

                            # sar -r n i


                            For example:

                            # sar -r 2 10


                            If the size of the physical RAM installed in the system is less than the required size, then
                            you must install more memory before continuing.
                      2.    Determine the swap space usage and size of the configured swap space:

                            # /usr/sbin/swap -s


                            If necessary, see your operating system documentation for information about how to
                            configure additional swap space.
                      3.    Determine the amount of space available in the /tmp directory:

                            # df -kh /tmp


                            If the free space available in the /tmp directory is less than what is required, then complete
                            one of the following steps:
                            •    Delete unnecessary files from the /tmp directory to meet the disk space requirement.


Database Installation Guide
E96434-12                                                                                                       April 30, 2026
Copyright © 2015, 2026, Oracle and/or its affiliates.                                                             Page 2 of 3
                                                                                                                   Chapter 2
                                                                           Checking Server Hardware and Memory Configuration


                            •    When you set the Oracle user's environment, also set the TMP and TMPDIR
                                 environment variables to the directory you want to use instead of /tmp.
                      4.    Determine the amount of free disk swap space on the system:

                            # df -kh

                      5.    Determine the RAM size:

                            # /usr/sbin/prtconf | grep "Memory size"

                      6.    Determine if the system architecture can run the software:

                            # /bin/isainfo -kv


                            This command displays the processor type. For example:

                            64-bit sparcv9 kernel modules


                            64-bit amd64 kernel modules


                            If you do not see the expected output, then you cannot install the software on this system.
                      Related Topics
                      •     Server Hardware Checklist for Oracle Database Installation
                            Use this checklist to check hardware requirements for Oracle Database.




Database Installation Guide
E96434-12                                                                                                      April 30, 2026
Copyright © 2015, 2026, Oracle and/or its affiliates.                                                            Page 3 of 3
3
Automatically Configuring Oracle Solaris with
Oracle Database Prerequisites Packages
                      Use the Oracle Database prerequisites group package to simplify Oracle Solaris operating
                      system configuration in preparation for Oracle software installations.
                      Oracle recommends that you install the Oracle Database prerequisites group package oracle-
                      database-preinstall-19c in preparation for Oracle Database and Oracle Grid Infrastructure
                      installations.
                      •     About the Oracle Database Prerequisites Packages for Oracle Solaris
                            Installing the Oracle Database prerequisites group package simplifies operating system
                            configuration and ensures that you have the required packages.
                      •     Checking the Oracle Database Prerequisites Packages Installation
                            Use this procedure to gather information about the Oracle Database prerequisites group
                            package configuration.
                      •     Installing the Oracle Database Prerequisites Packages for Oracle Solaris
                            Use this procedure to install the Oracle Database prerequisites group package for your
                            Oracle software.


About the Oracle Database Prerequisites Packages for Oracle
Solaris
                      Installing the Oracle Database prerequisites group package simplifies operating system
                      configuration and ensures that you have the required packages.
                      Use the Oracle Database prerequisites group package group/prerequisite/oracle/oracle-
                      database-preinstall-19c to ensure that all the necessary packages required for an Oracle
                      Database and Oracle Grid Infrastructure installation are present on the system.
                      The oracle-database-preinstall-19c package also creates the oracle user with a home
                      directory of /export/home/oracle, and creates the oraInventory (oinstall) and OSDBA
                      (dba) groups for that user.

                      The oracle-database-preinstall-19c package consists of two packages—one that installs
                      extra packages needed on the operating system and one that creates users and groups. The
                      users and groups are created by the package oracle-database-os-configuration. If you
                      have the oracle user and other user groups already defined, then you can chose not to
                      change them.
                      You can install oracle-database-preinstall-19c even if you installed Oracle Solaris using
                      any of the server package groups, such as solaris-minimal-server, solaris-small-server,
                      solaris-large-server, or solaris-desktop. Oracle recommends that you install the
                      solaris-minimal-server group package and then install oracle-database-preinstall-19c.

                      Configuring a server using Oracle Solaris and the Oracle Database prerequisites group
                      package consists of the following steps:
                      1.    Install the recommended Oracle Solaris version for Oracle Database.


Database Installation Guide
E96434-12                                                                                                  April 30, 2026
Copyright © 2015, 2026, Oracle and/or its affiliates.                                                        Page 1 of 4
                                                                                                                           Chapter 3
                                                                    Checking the Oracle Database Prerequisites Packages Installation


                      2.    Install the Oracle Database prerequisites group package oracle-database-
                            preinstall-19c.
                      3.    If you do not want the Oracle Database prerequisites group package to create the default
                            users and groups for you, then manually create the role-allocated groups and users.
                      4.    Complete network interface configuration for each cluster node candidate.
                      5.    Complete system configuration for shared storage access as required for each standard or
                            core node cluster candidate.
                      After these steps are complete, you can proceed to install Oracle Database, Oracle Grid
                      Infrastructure, or Oracle RAC.
                      Related Topics
                      •     Oracle Solaris 11.3 Package Group Lists


Checking the Oracle Database Prerequisites Packages
Installation
                      Use this procedure to gather information about the Oracle Database prerequisites group
                      package configuration.
                      1.    To check if oracle-database-preinstall-19c is already installed:

                            $ pkg list oracle-database-preinstall-19c

                      2.    To check for the latest version of oracle-database-preinstall-19c:

                            $ pkg list -n oracle-database-preinstall-19c

                      3.    Before you install oracle-database-preinstall-19c:
                            a.   Use the -n option to check for errors:

                                 $ pkg install -n oracle-database-preinstall-19c



                                          Note
                                          Use the -n option to check for installation errors. If -n does not display any
                                          errors, then omit the -n option when you install oracle-database-
                                          preinstall-19c.

                            b.   If there are no errors, then log in as root, and install the group package:

                                 # pkg install oracle-database-preinstall-19c

                            c.   If you have the oracle user and other user groups already defined, and do not want to
                                 change them:

                                 # pkg avoid oracle-database-os-configuration




Database Installation Guide
E96434-12                                                                                                             April 30, 2026
Copyright © 2015, 2026, Oracle and/or its affiliates.                                                                   Page 2 of 4
                                                                                                                          Chapter 3
                                                           Installing the Oracle Database Prerequisites Packages for Oracle Solaris


                      4.    To view what packages will be installed by oracle-database-preinstall-19c:

                            $ pkg contents -ro type,fmri -t depend oracle-database-preinstall-19c


                            A sample output of this command:

                            TYPE FMRI
                            conditional pkg:/service/oracle-rdbms-stats
                            group pkg:/group/prerequisite/oracle/oracle-database-os-configuration
                            group pkg:/system/font/truetype/arphic-uming
                            group pkg:/system/font/truetype/hanyang-ko-core
                            group pkg:/system/header
                            group pkg:/system/kernel/oracka
                            group pkg:/system/picl
                            group pkg:/x11/diagnostic/x11-info-clients
                            group pkg:/x11/library/libxi
                            group pkg:/x11/library/libxtst
                            group pkg:/x11/session/xauth
                            require pkg:/compress/unzip
                            require pkg:/developer/assembler
                            require pkg:/developer/build/make
                            require pkg:/system/dtrace
                            require pkg:/system/library/openmp

                      Related Topics
                      •     Adding and Updating Software in Oracle Solaris


Installing the Oracle Database Prerequisites Packages for Oracle
Solaris
                      Use this procedure to install the Oracle Database prerequisites group package for your Oracle
                      software.
                      The group/prerequisite/oracle/oracle-database-preinstall-19c group package installs
                      all the packages required for an Oracle Database and Oracle Grid Infrastructure installation. It
                      also creates the oracle user and the oinstall and dba groups for that user.


                                Caution
                                If you have the oracle user and other user groups already defined, and do not want to
                                change them, then ensure that you run the following command before you install the
                                Oracle Database prerequisites group package:

                                # pkg avoid oracle-database-os-configuration




                      To install the oracle-database-preinstall-19c group packages, log in as root, and run the
                      following command on Oracle Solaris 11.3 and later systems:

                      # pkg install oracle-database-preinstall-19c


Database Installation Guide
E96434-12                                                                                                            April 30, 2026
Copyright © 2015, 2026, Oracle and/or its affiliates.                                                                  Page 3 of 4
                                                                                                                          Chapter 3
                                                           Installing the Oracle Database Prerequisites Packages for Oracle Solaris


                      Note the following guidelines about the preceding command:
                      •     For more information about the history of the preceding command, use the pkg history
                            command. See pkg (1).
                      •     You do not have to specify the entire package name, only the trailing portion of the name
                            that is unique. See pkg(5).
                      •     Oracle recommends that you install the solaris-minimal-server group package and then
                            install oracle-database-preinstall-19c.

                      Related Topics
                      •     Oracle Solaris Documentation




Database Installation Guide
E96434-12                                                                                                            April 30, 2026
Copyright © 2015, 2026, Oracle and/or its affiliates.                                                                  Page 4 of 4
4
Configuring Oracle Solaris Operating System
for Oracle Database
                      Complete operating system configuration requirements and checks for Oracle Solaris
                      operating systems before you start installation.
                      •     Guidelines for Oracle Solaris Operating System Installation
                            Decide how you want to install Oracle Solaris.
                      •     Reviewing Operating System and Software Upgrade Best Practices
                            These topics provide general planning guidelines and platform-specific information about
                            upgrades and migration.
                      •     Reviewing Operating System Security Common Practices
                            Secure operating systems are an important basis for general system security.
                      •     About Installation Fixup Scripts
                            Oracle Universal Installer detects when the minimum requirements for an installation are
                            not met, and creates shell scripts, called fixup scripts, to finish incomplete system
                            configuration steps.
                      •     About Operating System Requirements
                            Depending on the products that you intend to install, verify that you have the required
                            operating system kernel and packages installed.
                      •     Operating System Requirements for Oracle Solaris on SPARC (64-bit)
                            The kernels and packages listed in this section are supported for this release on SPARC
                            64-bit systems for Oracle Database and Oracle Grid Infrastructure.
                      •     Operating System Requirements for Oracle Solaris on x86–64 (64-Bit)
                            The kernels and packages listed in this section are supported for this release on x86–64
                            (64-bit) systems for Oracle Database and Oracle Grid Infrastructure.
                      •     Additional Drivers and Software Packages for Oracle Solaris
                            Information about optional drivers and software packages.
                      •     Checking the Software Requirements for Oracle Solaris
                            Check the software requirements of your Oracle Solaris operating system to see if they
                            meet minimum requirements for installation.
                      •     Confirming Host Name Resolution
                            Check to ensure that the host name for your server is resolvable.
                      •     Using Automatic SSH Configuration During Installation
                            To install Oracle software, configure secure shell (SSH) connectivity between all cluster
                            member nodes.


Guidelines for Oracle Solaris Operating System Installation
                      Decide how you want to install Oracle Solaris.
                      Refer to your Oracle Solaris documentation to obtain information about installing Oracle Solaris
                      on your servers. You may want to use Oracle Solaris 11 installation services, such as Oracle




Database Installation Guide
E96434-12                                                                                                    April 30, 2026
Copyright © 2015, 2026, Oracle and/or its affiliates.                                                         Page 1 of 13
                                                                                                                      Chapter 4
                                                                 Reviewing Operating System and Software Upgrade Best Practices


                      Solaris Automated Installer (AI), to create and manage services to install the Oracle Solaris 11
                      operating system over the network.
                      Related Topics
                      •     Oracle Solaris Documentation
                      •     Installing Oracle Solaris 11 Guide
                      •     Resources for Running Oracle Database on Oracle Solaris


Reviewing Operating System and Software Upgrade Best
Practices
                      These topics provide general planning guidelines and platform-specific information about
                      upgrades and migration.
                      •     General Upgrade Best Practices
                            Be aware of these guidelines as a best practice before you perform an upgrade.
                      •     New Server Operating System Upgrade Option
                            You can upgrade your operating system by installing a new operating system on a server,
                            and then migrating your database either manually, or by using Export/Import method.
                      •     Oracle ASM Upgrade Notifications
                            Understand Oracle ASM upgrade options and restrictions.


General Upgrade Best Practices
                      Be aware of these guidelines as a best practice before you perform an upgrade.
                      If you have an existing Oracle Database installation, then do the following:
                      •     Record the version numbers, patches, and other configuration information
                      •     Review upgrade procedures for your existing installation
                      •     Review Oracle Database upgrade documentation before proceeding with installation, to
                            decide how you want to proceed


                                Caution
                                Always create a backup of existing databases before starting any configuration
                                change.



                      Refer to Oracle Database Upgrade Guide for more information about required software
                      updates, pre-upgrade tasks, post-upgrade tasks, compatibility, and interoperability between
                      different releases.
                      Related Topics
                      •     Oracle Database Upgrade Guide


New Server Operating System Upgrade Option
                      You can upgrade your operating system by installing a new operating system on a server, and
                      then migrating your database either manually, or by using Export/Import method.


Database Installation Guide
E96434-12                                                                                                         April 30, 2026
Copyright © 2015, 2026, Oracle and/or its affiliates.                                                              Page 2 of 13
                                                                                                                     Chapter 4
                                                                Reviewing Operating System and Software Upgrade Best Practices



                                Note
                                Confirm that the server operating system is supported, and that kernel and package
                                requirements for the operating system meet or exceed the minimum requirements for
                                the Oracle Database release to which you want to migrate.



                      Manual, Command-Line Copy for Migrating Data and Upgrading Oracle Database
                      You can copy files to the new server and upgrade it manually. If you use this procedure, then
                      you cannot use Oracle Database Upgrade Assistant. However, you can revert to your existing
                      database if you encounter upgrade issues.
                      1.    Copy the database files from the computer running the previous operating system to the
                            one running the new operating system.
                      2.    Re-create the control files on the computer running the new operating system.
                      3.    Manually upgrade the database using command-line scripts and utilities.


                                See Also
                                Oracle Database Upgrade Guide to review the procedure for upgrading the database
                                manually, and to evaluate the risks and benefits of this option



                      Export/Import Method for Migrating Data and Upgrading Oracle Database
                      You can install the operating system on the new server, install the new Oracle Database
                      release on the new server, and then use Oracle Data Pump Export and Import utilities to
                      migrate a copy of data from your current database to a new database in the new release. Data
                      Pump Export and Import are recommended for higher performance and to ensure support for
                      new data types.



                                See Also
                                Oracle Database Upgrade Guide to review the Export/Import method for migrating
                                data and upgrading Oracle Database




Oracle ASM Upgrade Notifications
                      Understand Oracle ASM upgrade options and restrictions.
                      •     You can upgrade Oracle Automatic Storage Management (Oracle ASM) 11g release 2
                            (11.2) and later without shutting down an Oracle RAC database by performing a rolling
                            upgrade either of individual nodes, or of a set of nodes in the cluster. However, if you have
                            a standalone database on a cluster that uses Oracle ASM, then you must shut down the
                            standalone database before upgrading.
                      •     The location of the Oracle ASM home changed in Oracle Grid Infrastructure 11g release 2
                            (11.2) so that Oracle ASM is installed with Oracle Clusterware in the Oracle Grid
                            Infrastructure home (Grid home).



Database Installation Guide
E96434-12                                                                                                        April 30, 2026
Copyright © 2015, 2026, Oracle and/or its affiliates.                                                             Page 3 of 13
                                                                                                                     Chapter 4
                                                                          Reviewing Operating System Security Common Practices


                      •     Two nodes of different releases cannot run in the cluster. When upgrading from Oracle
                            Grid Infrastructure 11g release 2 (11.2) or Oracle Grid Infrastructure 12c release 1 (12.1) to
                            a later release, if there is an outage during the rolling upgrade, then when you restart the
                            upgrade, ensure that you start the earlier release of Oracle Grid Infrastructure and bring
                            the Oracle ASM cluster back in the rolling migration mode.


Reviewing Operating System Security Common Practices
                      Secure operating systems are an important basis for general system security.
                      Ensure that your operating system deployment is in compliance with common security
                      practices as described in your operating system vendor security guide.


About Installation Fixup Scripts
                      Oracle Universal Installer detects when the minimum requirements for an installation are not
                      met, and creates shell scripts, called fixup scripts, to finish incomplete system configuration
                      steps.
                      If Oracle Universal Installer detects an incomplete task, then it generates fixup scripts
                      (runfixup.sh). You can run the fixup script and click Fix and Check Again. The fixup script
                      modifies both persistent parameter settings and parameters in memory, so you do not have to
                      restart the system.
                      The Fixup script does the following tasks:
                      •     Sets kernel parameters, if necessary, to values required for successful installation,
                            including:
                            –    Shared memory parameters.
                            –    Open file descriptor and UDP send/receive parameters.
                      •     Creates and sets permissions on the Oracle Inventory (central inventory) directory.
                      •     Creates or reconfigures primary and secondary group memberships for the installation
                            owner, if necessary, for the Oracle Inventory directory and the operating system privileges
                            groups.
                      •     Sets shell limits, if necessary, to required values.


                                Note
                                Using fixup scripts does not ensure that all the prerequisites for installing Oracle
                                Database are met. You must still verify that all the preinstallation requirements are met
                                to ensure a successful installation.



                      Oracle Universal Installer is fully integrated with Cluster Verification Utility (CVU) automating
                      many prerequisite checks for your Oracle Grid Infrastructure or Oracle Real Application
                      Clusters (Oracle RAC) installation. You can also manually perform various CVU verifications by
                      running the cluvfy command.

                      Related Topics
                      •     Completing Preinstallation Tasks Manually
                            You can complete the preinstallation configuration tasks manually.



Database Installation Guide
E96434-12                                                                                                        April 30, 2026
Copyright © 2015, 2026, Oracle and/or its affiliates.                                                             Page 4 of 13
                                                                                                                   Chapter 4
                                                                                        About Operating System Requirements


                      •     Oracle Clusterware Administration and Deployment Guide


About Operating System Requirements
                      Depending on the products that you intend to install, verify that you have the required
                      operating system kernel and packages installed.
                      Requirements listed in this document are current as of the date listed on the title page.
                      Oracle Universal Installer performs checks on your system to verify that it meets the listed
                      operating system package requirements. To ensure that these checks complete successfully,
                      verify the requirements before you start OUI.


                                Note
                                Oracle does not support running different operating system versions on cluster
                                members, unless an operating system is being upgraded. You cannot run different
                                operating system version binaries on members of the same cluster, even if each
                                operating system is supported.




Operating System Requirements for Oracle Solaris on SPARC
(64-bit)
                      The kernels and packages listed in this section are supported for this release on SPARC 64-bit
                      systems for Oracle Database and Oracle Grid Infrastructure.
                      The platform-specific hardware and software requirements included in this guide were current
                      when this guide was published. However, because new platforms and operating system
                      software versions might be certified after this guide is published, review the certification matrix
                      on the My Oracle Support website for the most up-to-date list of certified hardware platforms
                      and operating system versions:
                      https://support.oracle.com/
                      Identify the requirements for your Oracle Solaris on SPARC (64–bit) system, and ensure that
                      you have a supported kernel and required packages installed before starting installation.
                      •     Supported Oracle Solaris 11 Releases for SPARC (64-bit)
                            Check the supported Oracle Solaris 11 distributions and other operating system
                            requirements.
                      Related Topics
                      •     Installation Requirements for Programming Environments for Oracle Solaris
                            Ensure that your system meets the requirements for the programming environment you
                            want to configure:


Supported Oracle Solaris 11 Releases for SPARC (64-bit)
                      Check the supported Oracle Solaris 11 distributions and other operating system requirements.




Database Installation Guide
E96434-12                                                                                                     April 30, 2026
Copyright © 2015, 2026, Oracle and/or its affiliates.                                                          Page 5 of 13
                                                                                                                                 Chapter 4
                                                                       Operating System Requirements for Oracle Solaris on x86–64 (64-Bit)



                      Table 4-1 Oracle Solaris 11 Releases for SPARC (64-bit) Minimum Operating System
                      Requirements

                       Item                             Requirements
                       SSH Requirement                  Secure Shell is configured at installation for Oracle Solaris.
                       Oracle Solaris 11                Oracle Solaris 11.4 (Oracle Solaris 11.4.2.0.1.3.0) or later SRUs and updates
                       operating system                 Oracle Solaris 11.3 SRU 31 (Oracle Solaris 11.3.31.6.0) or later SRUs and
                                                        updates
                       Packages for Oracle              The following packages must be installed:
                       Solaris 11
                                                        pkg://solaris/system/library/openmp
                                                        pkg://solaris/compress/unzip
                                                        pkg://solaris/developer/assembler
                                                        pkg://solaris/developer/build/make
                                                        pkg://solaris/system/dtrace
                                                        pkg://solaris/system/header
                                                        pkg://solaris/system/library
                                                        pkg://solaris/system/linker
                                                        pkg://solaris/system/xopen/xcu4 (If not already installed as part of
                                                        standard Oracle Solaris 11 installation)
                                                        pkg://solaris/x11/diagnostic/x11-info-clients
                                                        pkg://solaris/system/kernel/oracka
                                                        Note: Starting with Oracle Solaris 11.2, if you have performed a standard
                                                        Oracle Solaris 11 installation, and installed the Oracle Database prerequisites
                                                        group package oracle-database-preinstall-19c, then you do not have
                                                        to install these packages, as oracle-database-preinstall-19c installs
                                                        them for you.
                       Oracle Solaris Cluster           This information applies only if you are using Oracle Solaris Cluster. Please
                       for Oracle Solaris 11            refer to the Oracle Solaris Cluster Compatibility Guide for more information:
                                                        Oracle Solaris Cluster 4 Compatibility Guide

                      Related Topics
                      •     Automatically Configuring Oracle Solaris with Oracle Database Prerequisites Packages
                            Use the Oracle Database prerequisites group package to simplify Oracle Solaris operating
                            system configuration in preparation for Oracle software installations.


Operating System Requirements for Oracle Solaris on x86–64
(64-Bit)
                      The kernels and packages listed in this section are supported for this release on x86–64 (64-
                      bit) systems for Oracle Database and Oracle Grid Infrastructure.
                      The platform-specific hardware and software requirements included in this guide were current
                      when this guide was published. However, because new platforms and operating system
                      software versions might be certified after this guide is published, review the certification matrix
                      on the My Oracle Support website for the most up-to-date list of certified hardware platforms
                      and operating system versions:
                      https://support.oracle.com/




Database Installation Guide
E96434-12                                                                                                                    April 30, 2026
Copyright © 2015, 2026, Oracle and/or its affiliates.                                                                         Page 6 of 13
                                                                                                                                 Chapter 4
                                                                       Operating System Requirements for Oracle Solaris on x86–64 (64-Bit)


                      Identify the requirements for your Oracle Solaris on x86–64 (64–bit) system, and ensure that
                      you have a supported kernel and required packages installed before starting installation.
                      •     Supported Oracle Solaris 11 Releases for x86-64 (64-Bit)
                            Check the supported Oracle Solaris 11 distributions and other operating system
                            requirements.
                      Related Topics
                      •     Installation Requirements for Programming Environments for Oracle Solaris
                            Ensure that your system meets the requirements for the programming environment you
                            want to configure:


Supported Oracle Solaris 11 Releases for x86-64 (64-Bit)
                      Check the supported Oracle Solaris 11 distributions and other operating system requirements.

                      Table 4-2 Oracle Solaris 11 Releases for x86-64 (64-Bit) Minimum Operating System
                      Requirements

                       Item                             Requirements
                       SSH Requirement                  Secure Shell is configured at installation for Oracle Solaris.
                       Oracle Solaris 11                Oracle Solaris 11.4 (Oracle Solaris 11.4.2.0.1.3.0) or later SRUs and updates
                       operating system                 Oracle Solaris 11.3 SRU 31 (Oracle Solaris 11.3.31.6.0) or later SRUs and
                                                        updates
                       Packages for Oracle              The following packages must be installed:
                       Solaris 11
                                                        pkg://solaris/system/library/openmp
                                                        pkg://solaris/compress/unzip
                                                        pkg://solaris/developer/assembler
                                                        pkg://solaris/developer/build/make
                                                        pkg://solaris/system/dtrace
                                                        pkg://solaris/system/header
                                                        pkg://solaris/system/library
                                                        pkg://solaris/system/linker
                                                        pkg://solaris/system/xopen/xcu4 (If not already installed as part of
                                                        standard Oracle Solaris 11 installation)
                                                        pkg://solaris/x11/diagnostic/x11-info-clients
                                                        pkg://solaris/system/kernel/oracka
                                                        Note:Starting with Oracle Solaris 11.2, if you have performed a standard
                                                        Oracle Solaris 11 installation, and installed the Oracle Database prerequisites
                                                        group package oracle-database-preinstall-19c, then you do not have
                                                        to install these packages, as oracle-database-preinstall-19c installs
                                                        them for you.
                       Oracle Solaris Cluster           This information applies only if you are using Oracle Solaris Cluster. Please
                       for Oracle Solaris 11            refer to the Oracle Solaris Cluster Compatibility Guide for more information:
                                                        Oracle Solaris Cluster 4 Compatibility Guide

                      Related Topics
                      •     Automatically Configuring Oracle Solaris with Oracle Database Prerequisites Packages
                            Use the Oracle Database prerequisites group package to simplify Oracle Solaris operating
                            system configuration in preparation for Oracle software installations.




Database Installation Guide
E96434-12                                                                                                                    April 30, 2026
Copyright © 2015, 2026, Oracle and/or its affiliates.                                                                         Page 7 of 13
                                                                                                                       Chapter 4
                                                                     Additional Drivers and Software Packages for Oracle Solaris




Additional Drivers and Software Packages for Oracle Solaris
                      Information about optional drivers and software packages.
                      You are not required to install additional drivers and packages, but you may choose to install or
                      configure these drivers and packages.
                      •     Installing Oracle Messaging Gateway
                            Oracle Messaging Gateway is installed with Enterprise Edition of Oracle Database.
                            However, you may require a CSD or Fix Packs.
                      •     Installation Requirements for ODBC and LDAP
                            Review these topics to install Open Database Connectivity (ODBC) and Lightweight
                            Directory Access Protocol (LDAP).
                      •     Installation Requirements for Programming Environments for Oracle Solaris
                            Ensure that your system meets the requirements for the programming environment you
                            want to configure:
                      •     Installation Requirements for Web Browsers
                            Web browsers are required only if you intend to use Oracle Enterprise Manager Database
                            Express and Oracle Enterprise Manager Cloud Control. Web browsers must support
                            JavaScript, and the HTML 4.0 and CSS 1.0 standards.


Installing Oracle Messaging Gateway
                      Oracle Messaging Gateway is installed with Enterprise Edition of Oracle Database. However,
                      you may require a CSD or Fix Packs.
                      If you require a CSD or Fix Packs for IBM WebSphere MQ, then see the following website for
                      more information:
                      https://www.ibm.com/support/


                                Note
                                •    Oracle Messaging Gateway does not support the integration of Advanced Queuing
                                     with TIBCO Rendezvous on IBM: Linux on System z.
                                •    Oracle Messaging Gateway is not supported on Linux for Arm (aarch64).



                      Related Topics
                      •     Oracle Database Advanced Queuing User's Guide


Installation Requirements for ODBC and LDAP
                      Review these topics to install Open Database Connectivity (ODBC) and Lightweight Directory
                      Access Protocol (LDAP).
                      •     About ODBC Drivers and Oracle Database
                            Open Database Connectivity (ODBC) is a set of database access APIs that connect to the
                            database, prepare, and then run SQL statements on the database.




Database Installation Guide
E96434-12                                                                                                         April 30, 2026
Copyright © 2015, 2026, Oracle and/or its affiliates.                                                              Page 8 of 13
                                                                                                                        Chapter 4
                                                                      Additional Drivers and Software Packages for Oracle Solaris


                      •     Installing ODBC Drivers for Oracle Solaris
                            If you intend to use ODBC, then install the most recent ODBC Driver Manager for Oracle
                            Solaris.
                      •     About LDAP and Oracle Plug-ins
                            Lightweight Directory Access Protocol (LDAP) is an application protocol for accessing and
                            maintaining distributed directory information services over IP networks.
                      •     Installing the LDAP Package
                            LDAP is included in a default operating system installation.

About ODBC Drivers and Oracle Database
                      Open Database Connectivity (ODBC) is a set of database access APIs that connect to the
                      database, prepare, and then run SQL statements on the database.
                      An application that uses an ODBC driver can access non-uniform data sources, such as
                      spreadsheets and comma-delimited files.

Installing ODBC Drivers for Oracle Solaris
                      If you intend to use ODBC, then install the most recent ODBC Driver Manager for Oracle
                      Solaris.
                      Download and install the ODBC Driver Manager from the following website:
                      http://www.unixodbc.org
                      Review the minimum supported ODBC driver releases, and install ODBC drivers of the
                      following or later releases for all Oracle Solaris distributions:

                      unixODBC-2.3.4 or later


About LDAP and Oracle Plug-ins
                      Lightweight Directory Access Protocol (LDAP) is an application protocol for accessing and
                      maintaining distributed directory information services over IP networks.
                      You require the LDAP package if you want to use features requiring LDAP, including the Oracle
                      Database scripts odisrvreg and oidca for Oracle Internet Directory, or schemasync for third-
                      party LDAP directories.

Installing the LDAP Package
                      LDAP is included in a default operating system installation.
                      If you did not perform a default operating system installation, and you intend to use Oracle
                      scripts requiring LDAP, then use a package management system for your distribution to install
                      a supported LDAP package for your distribution, and install any other required packages for
                      that LDAP package.


Installation Requirements for Programming Environments for Oracle Solaris
                      Ensure that your system meets the requirements for the programming environment you want to
                      configure:




Database Installation Guide
E96434-12                                                                                                          April 30, 2026
Copyright © 2015, 2026, Oracle and/or its affiliates.                                                               Page 9 of 13
                                                                                                                      Chapter 4
                                                                          Checking the Software Requirements for Oracle Solaris



                      Table 4-3       Requirements for Programming Environments for Oracle Solaris

                       Programming Environments            Support Requirements
                       Java Database Connectivity (JDBC) / JDK 8 (Java SE Development Kit) with the JNDI extension with
                       JDBC Oracle Call Interface (JDBC    Oracle Java Database Connectivity.
                       OCI)

                                                                                      Note
                                                                                      Starting with Oracle Database 12c
                                                                                      Release 2 (12.2), JDK 8 (32-bit) is
                                                                                      not supported on Oracle Solaris.
                                                                                      Features that use Java (32-bit) are
                                                                                      not available on Oracle Solaris.



                       Oracle Solaris Studio               Oracle Solaris Studio 12.6 (formerly Sun Studio) Sun C 5.15
                                                           2017/05/30

                                                           pkg://solarisstudio/developer/
                                                           developerstudio-126/

                                                           Download Oracle Solaris Studio from the following URL:
                                                           https://www.oracle.com/technetwork/server-storage/
                                                           developerstudio/overview/index.html
                       Pro*COBOL                           Micro Focus Visual COBOL Development Hub 2.3 - Update 2
                                                           Micro Focus Visual COBOL v6.0
                       Pro*FORTRAN                         Oracle Solaris Studio 12 (Fortran 95)



                                Note
                                Additional patches may be needed depending on applications you deploy.




Installation Requirements for Web Browsers
                      Web browsers are required only if you intend to use Oracle Enterprise Manager Database
                      Express and Oracle Enterprise Manager Cloud Control. Web browsers must support
                      JavaScript, and the HTML 4.0 and CSS 1.0 standards.
                      https://support.oracle.com
                      Related Topics
                      •     Oracle Enterprise Manager Cloud Control Basic Installation Guide


Checking the Software Requirements for Oracle Solaris
                      Check the software requirements of your Oracle Solaris operating system to see if they meet
                      minimum requirements for installation.




Database Installation Guide
E96434-12                                                                                                        April 30, 2026
Copyright © 2015, 2026, Oracle and/or its affiliates.                                                            Page 10 of 13
                                                                                                                        Chapter 4
                                                                            Checking the Software Requirements for Oracle Solaris


                      •     Verifying Operating System Version on Oracle Solaris
                            To check your software to see if they meet minimum version requirements for installation,
                            perform the following steps:
                      •     Verifying Operating System Packages on Oracle Solaris
                            To check if your operating system has the required Oracle Solaris 11 packages for
                            installation, run the following commands:


Verifying Operating System Version on Oracle Solaris
                      To check your software to see if they meet minimum version requirements for installation,
                      perform the following steps:
                      1.    To determine which version of Oracle Solaris is installed:

                            $ uname -r


                            5.11


                            In this example, the version shown is Oracle Solaris 11 (5.11). If necessary, refer to your
                            operating system documentation for information about upgrading the operating system.
                      2.    To determine the release level:

                            $ cat /etc/release


                            Oracle Solaris 11.4 SPARC


                            In this example, the release level shown is Oracle Solaris 11.4 SPARC.
                      3.    To determine detailed information about the operating system version such as update
                            level, SRU, and build:

                            •    On Oracle Solaris 11

                                 $ pkg list entire


                                 NAME (PUBLISHER) VERSION IFO
                                 entire (solaris) 0.5.11-0.175.3.1.0.5.0 i--


Verifying Operating System Packages on Oracle Solaris
                      To check if your operating system has the required Oracle Solaris 11 packages for installation,
                      run the following commands:

                      •     To determine if the required packages are installed on Oracle Solaris 11:
                            # /usr/bin/pkg verify [-Hqv] [pkg_pattern ...]
                            •    The -H option omits the headers from the verification output.
                            •    The -q option prints nothing but return failure if any fatal errors are found.
                            •    The -v option includes informational messages regarding packages.


Database Installation Guide
E96434-12                                                                                                           April 30, 2026
Copyright © 2015, 2026, Oracle and/or its affiliates.                                                               Page 11 of 13
                                                                                                                     Chapter 4
                                                                                               Confirming Host Name Resolution


                            If a package that is required for your system architecture is not installed, then download
                            and install it from My Oracle Support:
                            https://support.oracle.com


                                Note
                                There may be more recent versions of packages listed installed on the system. If a
                                listed patch is not installed, then determine if a more recent version is installed before
                                installing the version listed. Refer to your operating system documentation for
                                information about installing packages.



                      Related Topics
                      •     The Adding and Updating Oracle Solaris Software Packages guide
                      •     Oracle Solaris 11 Product Documentation
                      •     My Oracle Support note 1021281.1


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


                      Related Topics
                      •     Configuring Networks for Oracle Database
                            If you install Oracle Databases on servers with multiple Oracle homes, multiple aliases, or
                            without a static IP address, then review these network configuration topics.


Using Automatic SSH Configuration During Installation
                      To install Oracle software, configure secure shell (SSH) connectivity between all cluster
                      member nodes.
                      Oracle Universal Installer (OUI) uses the ssh and sftp commands during installation to run
                      remote commands on and copy files to the other cluster nodes. You must configure SSH so
                      that these commands do not prompt for a password.




Database Installation Guide
E96434-12                                                                                                        April 30, 2026
Copyright © 2015, 2026, Oracle and/or its affiliates.                                                            Page 12 of 13
                                                                                                                       Chapter 4
                                                                           Using Automatic SSH Configuration During Installation



                                Note
                                Oracle configuration assistants use SSH for configuration operations from local to
                                remote nodes. Oracle Enterprise Manager also uses SSH. RSH is no longer
                                supported.



                      You can configure SSH from the OUI interface during installation for the user account running
                      the installation. The automatic configuration creates passwordless SSH connectivity between
                      all cluster member nodes. Oracle recommends that you use the automatic procedure if
                      possible.
                      To enable the script to run, you must remove stty commands from the profiles of any existing
                      Oracle software installation owners you want to use, and remove other security measures that
                      are triggered during a login, and that generate messages to the terminal. These messages,
                      mail checks, and other displays prevent Oracle software installation owners from using the
                      SSH configuration script that is built into OUI. If they are not disabled, then SSH must be
                      configured manually before an installation can be run.
                      In rare cases, Oracle Clusterware installation can fail during the "AttachHome" operation when
                      the remote node closes the SSH connection. To avoid this problem, set the timeout wait to
                      unlimited by setting the following parameter in the SSH daemon configuration file /etc/ssh/
                      sshd_config on all cluster nodes:

                      LoginGraceTime 0


                      Related Topics
                      •     Preventing Installation Errors Caused by Terminal Output Commands
                            During an Oracle Grid Infrastructure installation, OUI uses SSH to run commands and
                            copy files to the other nodes. During the installation, hidden files on the system (for
                            example, .bashrc or .cshrc) can cause makefile and other installation errors if they
                            contain terminal output commands.




Database Installation Guide
E96434-12                                                                                                         April 30, 2026
Copyright © 2015, 2026, Oracle and/or its affiliates.                                                             Page 13 of 13
5
Configuring Users, Groups and Environments
for Oracle Grid Infrastructure and Oracle
Database
                      Before installation, create operating system groups and users, and configure user
                      environments.
                      •     Required Operating System Groups and Users
                            Oracle software installations require an installation owner, an Oracle Inventory group,
                            which is the primary group of all Oracle installation owners, and at least one group
                            designated as a system privileges group.
                      •     Oracle Installations with Standard and Job Role Separation Groups and Users
                            A job role separation configuration of Oracle Database and Oracle ASM is a configuration
                            with groups and users to provide separate groups for operating system authentication.
                      •     Creating Operating System Privileges Groups
                            The following sections describe how to create operating system groups for Oracle Grid
                            Infrastructure and Oracle Database:
                      •     Creating Operating System Oracle Installation User Accounts
                            Before starting installation, create Oracle software owner user accounts, and configure
                            their environments.
                      •     Creating Oracle Database Vault User Accounts
                            If you intend to use Oracle Database Vault by default, then you must create an Oracle
                            Database Vault user account, and configure that user.
                      •     Unsetting Oracle Installation Owner Environment Variables
                            Unset Oracle installation owner environment variables before you start the installation.


Required Operating System Groups and Users
                      Oracle software installations require an installation owner, an Oracle Inventory group, which is
                      the primary group of all Oracle installation owners, and at least one group designated as a
                      system privileges group.
                      Review group and user options with your system administrator. If you have system
                      administration privileges, then review the topics in this section and configure operating system
                      groups and users as needed.
                      •     Determining If an Oracle Inventory and Oracle Inventory Group Exist
                            Determine if you have an existing Oracle central inventory, and ensure that you use the
                            same Oracle Inventory for all Oracle software installations. Also, ensure that all Oracle
                            software users you intend to use for installation have permissions to write to this directory.
                      •     Creating the Oracle Inventory Group If an Oracle Inventory Does Not Exist
                            Create an Oracle Inventory group manually as part of a planned installation, particularly
                            where more than one Oracle software product is installed on servers.




Database Installation Guide
E96434-12                                                                                                      April 30, 2026
Copyright © 2015, 2026, Oracle and/or its affiliates.                                                           Page 1 of 16
                                                                                                                     Chapter 5
                                                                                    Required Operating System Groups and Users


                      •     About Oracle Installation Owner Accounts
                            Select or create an Oracle installation owner for your installation, depending on the group
                            and user management plan you want to use for your installations.
                      •     Identifying an Oracle Software Owner User Account
                            You must create at least one software owner user account the first time you install Oracle
                            software on the system. Either use an existing Oracle software user account, or create an
                            Oracle software owner user account for your installation.


Determining If an Oracle Inventory and Oracle Inventory Group Exist
                      Determine if you have an existing Oracle central inventory, and ensure that you use the same
                      Oracle Inventory for all Oracle software installations. Also, ensure that all Oracle software
                      users you intend to use for installation have permissions to write to this directory.
                      When you install Oracle software on the system for the first time, OUI creates the oraInst.loc
                      file. This file identifies the name of the Oracle Inventory group (by default, oinstall), and the
                      path of the Oracle central inventory directory. If you have an existing Oracle central inventory,
                      then ensure that you use the same Oracle Inventory for all Oracle software installations, and
                      ensure that all Oracle software users you intend to use for installation have permissions to
                      write to this directory.
                      oraInst.loccentral_inventory_locationgroup

                      inventory_loc=central_inventory_location
                      inst_group=group


                      Use the more command to determine if you have an Oracle central inventory on your system.
                      For example:
                      # more /var/opt/oracle/oraInst.loc

                      inventory_loc=/u01/app/oraInventory
                      inst_group=oinstall


                      Use the command grep groupname /etc/group to confirm that the group specified as the
                      Oracle Inventory group still exists on the system. For example:

                      $ grep oinstall /etc/group
                      oinstall:x:54321:grid,oracle



                                Note
                                Do not put the oraInventory directory under the Oracle base directory for a new
                                installation, because that can result in user permission errors for other installations.



Creating the Oracle Inventory Group If an Oracle Inventory Does Not Exist
                      Create an Oracle Inventory group manually as part of a planned installation, particularly where
                      more than one Oracle software product is installed on servers.
                      By default, if an oraInventory group does not exist, then the installer uses the primary group of
                      the installation owner for the Oracle software being installed as the oraInventory group. Ensure


Database Installation Guide
E96434-12                                                                                                        April 30, 2026
Copyright © 2015, 2026, Oracle and/or its affiliates.                                                             Page 2 of 16
                                                                                                                      Chapter 5
                                                                                    Required Operating System Groups and Users


                      that this group is available as a primary group for all planned Oracle software installation
                      owners.
                      oraInst.loc

                      # /usr/sbin/groupadd -g 54321 oinstall


About Oracle Installation Owner Accounts
                      Select or create an Oracle installation owner for your installation, depending on the group and
                      user management plan you want to use for your installations.
                      You must create a software owner for your installation in the following circumstances:
                      •     If an Oracle software owner user does not exist; for example, if this is the first installation of
                            Oracle software on the system.
                      •     If an Oracle software owner user exists, but you want to use a different operating system
                            user, with different group membership, to separate Oracle Grid Infrastructure
                            administrative privileges from Oracle Database administrative privileges.
                      In Oracle documentation, a user created to own only Oracle Grid Infrastructure software
                      installations is called the Grid user (grid). This user owns both the Oracle Clusterware and
                      Oracle Automatic Storage Management binaries. A user created to own either all Oracle
                      installations, or one or more Oracle database installations, is called the Oracle user (oracle).
                      You can have only one Oracle Grid Infrastructure installation owner, but you can have different
                      Oracle users to own different installations.
                      Oracle software owners must have the Oracle Inventory group as their primary group, so that
                      each Oracle software installation owner can write to the central inventory (oraInventory), and
                      so that OCR and Oracle Clusterware resource permissions are set correctly. The database
                      software owner must also have the OSDBA group and (if you create them) the OSOPER,
                      OSBACKUPDBA, OSDGDBA, OSRACDBA, and OSKMDBA groups as secondary groups.


Identifying an Oracle Software Owner User Account
                      You must create at least one software owner user account the first time you install Oracle
                      software on the system. Either use an existing Oracle software user account, or create an
                      Oracle software owner user account for your installation.
                      To use an existing user account, obtain from you system administrator the name of an existing
                      Oracle installation owner. Confirm that the existing owner is a member of the Oracle Inventory
                      group.
                      oinstalloinstall

                      $ grep "oinstall" /etc/group
                      oinstall:x:54321:grid,oracle


                      You can then use the ID command to verify that the Oracle installation owners you intend to
                      use have the Oracle Inventory group as their primary group. For example:

                      $ id -a oracle
                      uid=54321(oracle) gid=54321(oinstall) groups=54321(oinstall),54322(dba),




Database Installation Guide
E96434-12                                                                                                         April 30, 2026
Copyright © 2015, 2026, Oracle and/or its affiliates.                                                              Page 3 of 16
                                                                                                                          Chapter 5
                                                        Oracle Installations with Standard and Job Role Separation Groups and Users


                      54323(oper),54324(backupdba),54325(dgdba),54326(kmdba),54327(asmdba),54330(rac
                      dba)


                      $ id -a grid
                      uid=54331(grid) gid=54321(oinstall) groups=54321(oinstall),54322(dba),
                      54327(asmdba),54328(asmoper),54329(asmadmin),54330(racdba)


                      For Oracle Restart installations, to successfully install Oracle Database, ensure that the grid
                      user is a member of the racdba group.

                      After you create operating system groups, create or modify Oracle user accounts in
                      accordance with your operating system authentication planning.
                      Related Topics
                      •     Creating an Oracle Software Owner User
                            If the Oracle software owner user (oracle or grid) does not exist, or if you require a new
                            Oracle software owner user, then create it as described in this section.
                      •     Modifying Oracle Owner User Groups
                            If you have created an Oracle software installation owner account, but it is not a member of
                            the groups you want to designate as the OSDBA, OSOPER, OSDBA for ASM,
                            ASMADMIN, or other system privileges group, then modify the group settings for that user
                            before installation.


Oracle Installations with Standard and Job Role Separation
Groups and Users
                      A job role separation configuration of Oracle Database and Oracle ASM is a configuration with
                      groups and users to provide separate groups for operating system authentication.
                      Review the following sections to understand more about a Job Role Separation deployment:
                      •     About Oracle Installations with Job Role Separation
                            Job role separation requires that you create different operating system groups for each set
                            of system privileges that you grant through operating system authorization.
                      •     Standard Oracle Database Groups for Database Administrators
                            Oracle Database has two standard administration groups: OSDBA, which is required, and
                            OSOPER, which is optional.
                      •     Extended Oracle Database Groups for Job Role Separation
                            Oracle Database provides an extended set of database groups to grant task-specific
                            system privileges for database administration.
                      •     Creating an ASMSNMP User
                            The ASMSNMP user is an Oracle ASM user with privileges to monitor Oracle ASM instances.
                            You are prompted to provide a password for this user during installation.
                      •     Oracle Automatic Storage Management Groups for Job Role Separation
                            Oracle Grid Infrastructure operating system groups provide their members task-specific
                            system privileges to access and to administer Oracle Automatic Storage Management.




Database Installation Guide
E96434-12                                                                                                            April 30, 2026
Copyright © 2015, 2026, Oracle and/or its affiliates.                                                                 Page 4 of 16
                                                                                                                          Chapter 5
                                                        Oracle Installations with Standard and Job Role Separation Groups and Users



About Oracle Installations with Job Role Separation
                      Job role separation requires that you create different operating system groups for each set of
                      system privileges that you grant through operating system authorization.
                      With Oracle Grid Infrastructure job role separation, Oracle ASM has separate operating system
                      groups that provide operating system authorization for Oracle ASM system privileges for
                      storage tier administration. This operating system authorization is separated from Oracle
                      Database operating system authorization. In addition, the Oracle Grid Infrastructure installation
                      owner provides operating system user authorization for modifications to Oracle Grid
                      Infrastructure binaries.
                      With Oracle Database job role separation, each Oracle Database installation has separate
                      operating system groups to provide authorization for system privileges on that Oracle
                      Database. Multiple databases can, therefore, be installed on the cluster without sharing
                      operating system authorization for system privileges. In addition, each Oracle software
                      installation is owned by a separate installation owner, to provide operating system user
                      authorization for modifications to Oracle Database binaries. Note that any Oracle software
                      owner can start and stop all databases and shared Oracle Grid Infrastructure resources such
                      as Oracle ASM or Virtual IP (VIP). Job role separation configuration enables database security,
                      and does not restrict user roles in starting and stopping various Oracle Clusterware resources.
                      You can choose to create one administrative user and one group for operating system
                      authentication for all system privileges on the storage and database tiers. For example, you
                      can designate the oracle user to be the installation owner for all Oracle software, and
                      designate oinstall to be the group whose members are granted all system privileges for
                      Oracle Clusterware; all system privileges for Oracle ASM; all system privileges for all Oracle
                      Databases on the servers; and all OINSTALL system privileges for installation owners. This
                      group must also be the Oracle Inventory group.
                      If you do not want to use role allocation groups, then Oracle strongly recommends that you use
                      at least two groups:
                      •     A system privileges group whose members are granted administrative system privileges,
                            including OSDBA, OSASM, and other system privileges groups.
                      •     An installation owner group (the oraInventory group) whose members are granted Oracle
                            installation owner system privileges (the OINSTALL system privilege).


                                Note
                                To configure users for installation that are on a network directory service such as
                                Network Information Services (NIS), refer to your directory service documentation.


                      Related Topics
                      •     Oracle Database Administrator’s Guide
                      •     Oracle Automatic Storage Management Administrator's Guide


Standard Oracle Database Groups for Database Administrators
                      Oracle Database has two standard administration groups: OSDBA, which is required, and
                      OSOPER, which is optional.
                      •     The OSDBA group (typically, dba)


Database Installation Guide
E96434-12                                                                                                            April 30, 2026
Copyright © 2015, 2026, Oracle and/or its affiliates.                                                                 Page 5 of 16
                                                                                                                          Chapter 5
                                                        Oracle Installations with Standard and Job Role Separation Groups and Users


                            You must create this group the first time you install Oracle Database software on the
                            system. This group identifies operating system user accounts that have database
                            administrative privileges (the SYSDBA privilege).
                            If you do not create separate OSDBA, OSOPER, and OSASM groups for the Oracle ASM
                            instance, then operating system user accounts that have the SYSOPER and SYSASM
                            privileges must be members of this group. The name used for this group in Oracle code
                            examples is dba. If you do not designate a separate group as the OSASM group, then the
                            OSDBA group you define is also by default the OSASM group.
                      •     The OSOPER group for Oracle Database (typically, oper)
                            OSOPER grants the OPERATOR privilege to start up and shut down the database (the
                            SYSOPER privilege). By default, members of the OSDBA group have all privileges granted
                            by the SYSOPER privilege.


Extended Oracle Database Groups for Job Role Separation
                      Oracle Database provides an extended set of database groups to grant task-specific system
                      privileges for database administration.
                      The extended set of Oracle Database system privileges groups are task-specific and less
                      privileged than the OSDBA/SYSDBA system privileges. They are designed to provide
                      privileges to carry out everyday database operations. Users granted these system privileges
                      are also authorized through operating system group membership.
                      You do not have to create these specific group names, but during interactive and silent
                      installation, you must assign operating system groups whose members are granted access to
                      these system privileges. You can assign the same group to provide authorization for these
                      privileges, but Oracle recommends that you provide a unique group to designate each
                      privilege.
                      The subset of OSDBA job role separation privileges and groups consist of the following:
                      •     OSBACKUPDBA group for Oracle Database (typically, backupdba)
                            Create this group if you want a separate group of operating system users to have a limited
                            set of database backup and recovery related administrative privileges (the SYSBACKUP
                            privilege).
                      •     OSDGDBA group for Oracle Data Guard (typically, dgdba)
                            Create this group if you want a separate group of operating system users to have a limited
                            set of privileges to administer and monitor Oracle Data Guard (the SYSDG privilege). To
                            use this privilege, add the Oracle Database installation owners as members of this group.
                      •     The OSKMDBA group for encryption key management (typically, kmdba)
                            Create this group if you want a separate group of operating system users to have a limited
                            set of privileges for encryption key management such as Oracle Wallet Manager
                            management (the SYSKM privilege). To use this privilege, add the Oracle Database
                            installation owners as members of this group.
                      •     The OSRACDBA group for Oracle Real Application Clusters Administration (typically,
                            racdba)
                            Create this group if you want a separate group of operating system users to have a limited
                            set of Oracle Real Application Clusters (RAC) administrative privileges (the SYSRAC
                            privilege). To use this privilege:
                            –    Add the Oracle Database installation owners as members of this group.



Database Installation Guide
E96434-12                                                                                                            April 30, 2026
Copyright © 2015, 2026, Oracle and/or its affiliates.                                                                 Page 6 of 16
                                                                                                                          Chapter 5
                                                        Oracle Installations with Standard and Job Role Separation Groups and Users


                            –    For Oracle Restart configurations, if you have a separate Oracle Grid Infrastructure
                                 installation owner user (grid), then you must also add the grid user as a member of
                                 the OSRACDBA group of the database to enable Oracle Grid Infrastructure
                                 components to connect to the database.
                      Related Topics
                      •     Oracle Database Administrator’s Guide
                      •     Oracle Database Security Guide


Creating an ASMSNMP User
                      The ASMSNMP user is an Oracle ASM user with privileges to monitor Oracle ASM instances. You
                      are prompted to provide a password for this user during installation.
                      In addition to the OSASM group, whose members are granted the SYSASM system privilege
                      to administer Oracle ASM, Oracle recommends that you create a less privileged user, ASMSNMP,
                      and grant that user SYSDBA privileges to monitor the Oracle ASM instance. Oracle Enterprise
                      Manager uses the ASMSNMP user to monitor Oracle ASM status.

                      During installation, you are prompted to provide a password for the ASMSNMP user. You can
                      create an operating system authenticated user, or you can create an Oracle Database user
                      called asmsnmp. In either case, grant the user SYSDBA privileges.


Oracle Automatic Storage Management Groups for Job Role Separation
                      Oracle Grid Infrastructure operating system groups provide their members task-specific system
                      privileges to access and to administer Oracle Automatic Storage Management.
                      •     The OSASM group for Oracle ASM Administration (typically, asmadmin)
                            Create this group as a separate group to separate administration privileges groups for
                            Oracle ASM and Oracle Database administrators. Members of this group are granted the
                            SYSASM system privileges to administer Oracle ASM. In Oracle documentation, the
                            operating system group whose members are granted privileges is called the OSASM
                            group, and in code examples, where there is a group specifically created to grant this
                            privilege, it is referred to as asmadmin.
                            Oracle ASM can support multiple databases. If you have multiple databases on your
                            system, and use multiple OSDBA groups so that you can provide separate SYSDBA
                            privileges for each database, then you should create a group whose members are granted
                            the OSASM/SYSASM administrative privileges, and create a grid infrastructure user (grid)
                            that does not own a database installation, so that you separate Oracle Grid Infrastructure
                            SYSASM administrative privileges from a database administrative privileges group.
                            Members of the OSASM group can use SQL to connect to an Oracle ASM instance as
                            SYSASM using operating system authentication. The SYSASM privileges permit mounting
                            and dismounting disk groups, and other storage administration tasks. SYSASM privileges
                            provide no access privileges on an RDBMS instance.
                            If you do not designate a separate group as the OSASM group, but you do define an
                            OSDBA group for database administration, then by default the OSDBA group you define is
                            also defined as the OSASM group.
                      •     The OSOPER group for Oracle ASM (typically, asmoper)
                            This is an optional group. Create this group if you want a separate group of operating
                            system users to have a limited set of Oracle instance administrative privileges (the
                            SYSOPER for ASM privilege), including starting up and stopping the Oracle ASM instance.


Database Installation Guide
E96434-12                                                                                                            April 30, 2026
Copyright © 2015, 2026, Oracle and/or its affiliates.                                                                 Page 7 of 16
                                                                                                                   Chapter 5
                                                                                 Creating Operating System Privileges Groups


                            By default, members of the OSASM group also have all privileges granted by the
                            SYSOPER for ASM privilege.


Creating Operating System Privileges Groups
                      The following sections describe how to create operating system groups for Oracle Grid
                      Infrastructure and Oracle Database:
                      •     Creating the OSDBA for ASM Group
                            You must designate a group as the OSDBA for ASM (asmdba) group during installation.
                            Members of this group are also allowed to access the Oracle Automatic Storage
                            Management (Oracle ASM) disk devices.
                      •     Creating the OSOPER for ASM Group
                            You can choose to designate a group as the OSOPER for ASM group (asmoper) during
                            installation. Members of this group are granted startup and shutdown privileges to Oracle
                            Automatic Storage Management.
                      •     Creating the OSDBA Group for Database Installations
                            Each Oracle Database requires an operating system group to be designated as the
                            OSDBA group. Members of this group are granted the SYSDBA system privileges to
                            administer the database.
                      •     Creating an OSOPER Group for Database Installations
                            Create an OSOPER group only if you want to identify a group of operating system users
                            with a limited set of database administrative privileges (SYSOPER operator privileges).
                      •     Creating the OSBACKUPDBA Group for Database Installations
                            You must designate a group as the OSBACKUPDBA group during installation. Members of
                            this group are granted the SYSBACKUP privileges to perform backup and recovery
                            operations using RMAN or SQL*Plus.
                      •     Creating the OSDGDBA Group for Database Installations
                            You must designate a group as the OSDGDBA group during installation. Members of this
                            group are granted the SYSDG privileges to perform Data Guard operations.
                      •     Creating the OSKMDBA Group for Database Installations
                            You must designate a group as the OSKMDBA group during installation. Members of this
                            group are granted the SYSKM privileges to perform Transparent Data Encryption keystore
                            operations.
                      •     Creating the OSRACDBA Group for Database Installations
                            You must designate a group as the OSRACDBA group during database installation.
                            Members of this group are granted the SYSRAC privileges to perform day–to–day
                            administration of Oracle databases on an Oracle RAC cluster.


Creating the OSDBA for ASM Group
                      You must designate a group as the OSDBA for ASM (asmdba) group during installation.
                      Members of this group are also allowed to access the Oracle Automatic Storage Management
                      (Oracle ASM) disk devices.
                      The Oracle ASM disk devices should be owned by this group.
                      Create an OSDBA for ASM group using the group name asmdba unless a group with that name
                      already exists:

                      # /usr/sbin/groupadd -g 54327 asmdba



Database Installation Guide
E96434-12                                                                                                      April 30, 2026
Copyright © 2015, 2026, Oracle and/or its affiliates.                                                           Page 8 of 16
                                                                                                                      Chapter 5
                                                                                    Creating Operating System Privileges Groups



Creating the OSOPER for ASM Group
                      You can choose to designate a group as the OSOPER for ASM group (asmoper) during
                      installation. Members of this group are granted startup and shutdown privileges to Oracle
                      Automatic Storage Management.
                      If you want to create an OSOPER for ASM group, use the group name asmoper unless a group
                      with that name already exists:

                      # /usr/sbin/groupadd -g 54328 asmoper


Creating the OSDBA Group for Database Installations
                      Each Oracle Database requires an operating system group to be designated as the OSDBA
                      group. Members of this group are granted the SYSDBA system privileges to administer the
                      database.
                      You must create an OSDBA group in the following circumstances:
                      •     An OSDBA group does not exist, for example, if this is the first installation of Oracle
                            Database software on the system
                      •     An OSDBA group exists, but you want to give a different group of operating system users
                            database administrative privileges for a new Oracle Database installation
                      Create the OSDBA group using the group name dba, unless a group with that name already
                      exists:

                      # /usr/sbin/groupadd -g 54322 dba


Creating an OSOPER Group for Database Installations
                      Create an OSOPER group only if you want to identify a group of operating system users with a
                      limited set of database administrative privileges (SYSOPER operator privileges).
                      For most installations, it is sufficient to create only the OSDBA group. However, to use an
                      OSOPER group, create it in the following circumstances:
                      •     If an OSOPER group does not exist; for example, if this is the first installation of Oracle
                            Database software on the system
                      •     If an OSOPER group exists, but you want to give a different group of operating system
                            users database operator privileges in a new Oracle installation
                      If the OSOPER group does not exist, or if you require a new OSOPER group, then create it.
                      Use the group name oper unless a group with that name already exists. For example:

                      # groupadd -g 54323 oper




Database Installation Guide
E96434-12                                                                                                         April 30, 2026
Copyright © 2015, 2026, Oracle and/or its affiliates.                                                              Page 9 of 16
                                                                                                                     Chapter 5
                                                                   Creating Operating System Oracle Installation User Accounts



Creating the OSBACKUPDBA Group for Database Installations
                      You must designate a group as the OSBACKUPDBA group during installation. Members of this
                      group are granted the SYSBACKUP privileges to perform backup and recovery operations
                      using RMAN or SQL*Plus.
                      Create the OSBACKUPDBA group using the group name backupdba, unless a group with that
                      name already exists:

                      # /usr/sbin/groupadd -g 54324 backupdba


Creating the OSDGDBA Group for Database Installations
                      You must designate a group as the OSDGDBA group during installation. Members of this
                      group are granted the SYSDG privileges to perform Data Guard operations.
                      Create the OSDGDBA group using the group name dgdba, unless a group with that name
                      already exists:

                      # /usr/sbin/groupadd -g 54325 dgdba


Creating the OSKMDBA Group for Database Installations
                      You must designate a group as the OSKMDBA group during installation. Members of this
                      group are granted the SYSKM privileges to perform Transparent Data Encryption keystore
                      operations.
                      If you want a separate group for Transparent Data Encryption, then create the OSKMDBA
                      group using the group name kmdba unless a group with that name already exists:

                      # /usr/sbin/groupadd -g 54326 kmdba


Creating the OSRACDBA Group for Database Installations
                      You must designate a group as the OSRACDBA group during database installation. Members
                      of this group are granted the SYSRAC privileges to perform day–to–day administration of
                      Oracle databases on an Oracle RAC cluster.
                      Create the OSRACDBA group using the groups name racdba unless a group with that name
                      already exists:

                      # /usr/sbin/groupadd -g 54330 racdba



Creating Operating System Oracle Installation User Accounts
                      Before starting installation, create Oracle software owner user accounts, and configure their
                      environments.
                      Oracle software owner user accounts require resource settings and other environment
                      configuration. To protect against accidents, Oracle recommends that you create one software
                      installation owner account for each Oracle software program you install.


Database Installation Guide
E96434-12                                                                                                       April 30, 2026
Copyright © 2015, 2026, Oracle and/or its affiliates.                                                           Page 10 of 16
                                                                                                                        Chapter 5
                                                                      Creating Operating System Oracle Installation User Accounts


                      •     Creating an Oracle Software Owner User
                            If the Oracle software owner user (oracle or grid) does not exist, or if you require a new
                            Oracle software owner user, then create it as described in this section.
                      •     Environment Requirements for Oracle Software Owners
                            You must make the following changes to configure Oracle software owner environments:
                      •     Procedure for Configuring Oracle Software Owner Environments
                            Configure each Oracle installation owner user account environment:
                      •     Modifying Oracle Owner User Groups
                            If you have created an Oracle software installation owner account, but it is not a member of
                            the groups you want to designate as the OSDBA, OSOPER, OSDBA for ASM,
                            ASMADMIN, or other system privileges group, then modify the group settings for that user
                            before installation.
                      •     Preventing Installation Errors Caused by Terminal Output Commands
                            During an Oracle Grid Infrastructure installation, OUI uses SSH to run commands and
                            copy files to the other nodes. During the installation, hidden files on the system (for
                            example, .bashrc or .cshrc) can cause makefile and other installation errors if they
                            contain terminal output commands.


Creating an Oracle Software Owner User
                      If the Oracle software owner user (oracle or grid) does not exist, or if you require a new
                      Oracle software owner user, then create it as described in this section.
                      The following example shows how to create the user oracle with the user ID 54321; with the
                      primary group oinstall; and with secondary groups dba, asmdba, backupdba, dgdba, kmdba,
                      and racdba:

                      # /usr/sbin/useradd -u 54321 -g oinstall -G
                      dba,asmdba,backupdba,dgdba,kmdba,racdba oracle


                      The following example shows how to create the user grid with the user ID 54331; with the
                      primary group oinstall; and with secondary groups asmadmin, asmdba, and racdba:

                      # /usr/sbin/useradd -u 54331 -g oinstall -G asmadmin,asmdba,racdba grid


                      You must note the user ID number for installation users, because you need it during
                      preinstallation.


Environment Requirements for Oracle Software Owners
                      You must make the following changes to configure Oracle software owner environments:
                      •     Set the installation software owner user (grid, oracle) default file mode creation mask
                            (umask) to 022 in the shell startup file. Setting the mask to 022 ensures that the user
                            performing the software installation creates files with 644 permissions.
                      •     Set ulimit settings for file descriptors and processes for the installation software owner
                            (grid, oracle).
                      •     Set the DISPLAY environment variable in preparation for running an Oracle Universal
                            Installer (OUI) installation.




Database Installation Guide
E96434-12                                                                                                          April 30, 2026
Copyright © 2015, 2026, Oracle and/or its affiliates.                                                              Page 11 of 16
                                                                                                                            Chapter 5
                                                                          Creating Operating System Oracle Installation User Accounts



                                Caution
                                If you have existing Oracle installations that you installed with the user ID that is your
                                Oracle Grid Infrastructure software owner, then unset all Oracle environment variable
                                settings for that user.



                      Related Topics
                      •     Unsetting Oracle Installation Owner Environment Variables
                            Unset Oracle installation owner environment variables before you start the installation.


Procedure for Configuring Oracle Software Owner Environments
                      Configure each Oracle installation owner user account environment:
                      1.    Start an X terminal session (xterm) on the server where you are running the installation.
                      2.    Enter the following command to ensure that X Window applications can display on this
                            system, where hostname is the fully qualified name of the local host from which you are
                            accessing the server:

                            $ xhost + hostname

                      3.    If you are not logged in as the software owner user, then switch to the software owner user
                            you are configuring. For example, with the user grid:

                            $ su - grid


                            On systems where you cannot run su commands, use sudo instead:

                            $ sudo -u grid -s

                      4.    To determine the default shell for the user, enter the following command:

                            $ echo $SHELL

                      5.    Open the user's shell startup file in any text editor:
                            •    Bash shell (bash):

                                 $ vi .bash_profile

                            •    Bourne shell (sh) or Korn shell (ksh):

                                 $ vi .profile

                            •    C shell (csh or tcsh):

                                 % vi .login




Database Installation Guide
E96434-12                                                                                                              April 30, 2026
Copyright © 2015, 2026, Oracle and/or its affiliates.                                                                  Page 12 of 16
                                                                                                                          Chapter 5
                                                                        Creating Operating System Oracle Installation User Accounts


                      6.    Enter or edit the following line, specifying a value of 022 for the default file mode creation
                            mask:

                            umask 022

                      7.    If the ORACLE_SID, ORACLE_HOME, or ORACLE_BASE environment variables are set in the file,
                            then remove these lines from the file.
                      8.    Save the file, and exit from the text editor.
                      9.    To run the shell startup script, enter one of the following commands:
                            •    Bash shell:

                                 $ . ./.bash_profile

                            •    Bourne, Bash, or Korn shell:

                                 $ . ./.profile

                            •    C shell:

                                 % source ./.login

                      10. Use the following command to check the PATH environment variable:

                            $ echo $PATH


                            Remove any Oracle environment variables.
                      11. Unset any Oracle environment variables.

                            If you have an existing Oracle software installation, and you are using the same user to
                            install this installation, then unset the $ORACLE_HOME, $ORA_NLS10,
                            and $TNS_ADMIN environment variables.
                            If you have set $ORA_CRS_HOME as an environment variable, then unset it before
                            starting an installation or upgrade. Do not use $ORA_CRS_HOME as a user environment
                            variable, except as directed by Oracle Support.
                      12. If you are not installing the software on the local system, then enter a command similar to
                            the following to direct X applications to display on the local system:
                            •    Bourne, Bash, or Korn shell:

                                 $ export DISPLAY=local_host:0.0

                            •    C shell:

                                 % setenv DISPLAY local_host:0.0

                            In this example, local_host is the host name or IP address of the system (your
                            workstation, or another client) on which you want to display the installer.
                      13. If the /tmp directory has less than 1 GB of free space, then identify a file system with at
                            least 1 GB of free space and set the TMP and TMPDIR environment variables to specify a
                            temporary directory on this file system:




Database Installation Guide
E96434-12                                                                                                            April 30, 2026
Copyright © 2015, 2026, Oracle and/or its affiliates.                                                                Page 13 of 16
                                                                                                                         Chapter 5
                                                                       Creating Operating System Oracle Installation User Accounts



                                     Note
                                     You cannot use a shared file system as the location of the temporary file directory
                                     (typically /tmp) for Oracle RAC installations. If you place /tmp on a shared file
                                     system, then the installation fails.



                            a.   Use the df -h command to identify a suitable file system with sufficient free space.
                            b.   If necessary, enter commands similar to the following to create a temporary directory
                                 on the file system that you identified, and set the appropriate permissions on the
                                 directory:

                                 $ sudo -s
                                 # mkdir /mount_point/tmp
                                 # chmod 775 /mount_point/tmp
                                 # exit

                            c.   Enter commands similar to the following to set the TMP and TMPDIR environment
                                 variables:
                                 Bourne, Bash, or Korn shell:

                                 $ TMP=/mount_point/tmp
                                 $ TMPDIR=/mount_point/tmp
                                 $ export TMP TMPDIR


                                 C shell:

                                 % setenv TMP /mount_point/tmp
                                 % setenv TMPDIR /mount_point/tmp

                      14. To verify that the environment has been set correctly, enter the following commands:

                            $ umask
                            $ env | more


                            Verify that the umask command displays a value of 22, 022, or 0022 and that the
                            environment variables you set in this section have the correct values.




Database Installation Guide
E96434-12                                                                                                           April 30, 2026
Copyright © 2015, 2026, Oracle and/or its affiliates.                                                               Page 14 of 16
                                                                                                                      Chapter 5
                                                                    Creating Operating System Oracle Installation User Accounts



Modifying Oracle Owner User Groups
                      If you have created an Oracle software installation owner account, but it is not a member of the
                      groups you want to designate as the OSDBA, OSOPER, OSDBA for ASM, ASMADMIN, or
                      other system privileges group, then modify the group settings for that user before installation.


                                Warning
                                Each Oracle software owner must be a member of the same central inventory group.
                                Do not modify the primary group of an existing Oracle software owner account, or
                                designate different groups as the OINSTALL group. If Oracle software owner accounts
                                have different groups as their primary group, then you can corrupt the central
                                inventory.



                      During installation, the user who is installing the software should have the OINSTALL group as
                      its primary group, and it must be a member of the operating system groups appropriate for
                      your installation. For example:

                      # /usr/sbin/usermod -g oinstall -G
                      dba,asmdba,backupdba,dgdba,kmdba,racdba[,oper] oracle


Preventing Installation Errors Caused by Terminal Output Commands
                      During an Oracle Grid Infrastructure installation, OUI uses SSH to run commands and copy
                      files to the other nodes. During the installation, hidden files on the system (for
                      example, .bashrc or .cshrc) can cause makefile and other installation errors if they contain
                      terminal output commands.
                      To avoid this problem, you must modify hidden files in each Oracle installation owner user
                      home directory to suppress all output on STDOUT or STDERR (for example, stty, xtitle, and
                      other such commands) as in the following examples:
                      Bourne, Bash, or Korn shell:

                      if [ -t 0 ]; then
                         stty intr ^C
                      fi


                      C shell:

                      test -t 0
                      if ($status == 0) then
                         stty intr ^C
                      endif




Database Installation Guide
E96434-12                                                                                                        April 30, 2026
Copyright © 2015, 2026, Oracle and/or its affiliates.                                                            Page 15 of 16
                                                                                                                     Chapter 5
                                                                                  Creating Oracle Database Vault User Accounts



                                Note
                                If the remote shell can load hidden files that contain stty commands, then OUI
                                indicates an error and stops the installation.




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


Unsetting Oracle Installation Owner Environment Variables
                      Unset Oracle installation owner environment variables before you start the installation.
                      The environment variables you have set for the Oracle installation owner account you use to
                      run the installation can cause issues if they are set to values that conflict with the values
                      needed for installation.
                      If you have set ORA_CRS_HOME as an environment variable, following instructions from
                      Oracle Support, then unset it before starting an installation or upgrade. You should never use
                      ORA_CRS_HOME as an environment variable except under explicit direction from Oracle
                      Support.
                      If you have had an existing installation on your system, and you are using the same user
                      account to install this installation, then unset the following environment variables:
                      ORA_CRS_HOME, ORACLE_HOME, ORA_NLS10, TNS_ADMIN, and any other environment
                      variable set for the Oracle installation user that is connected with Oracle software homes.
                      Also, ensure that the $ORACLE_HOME/bin path is removed from your PATH environment
                      variable.




Database Installation Guide
E96434-12                                                                                                        April 30, 2026
Copyright © 2015, 2026, Oracle and/or its affiliates.                                                            Page 16 of 16
6
Configuring Networks for Oracle Database
                      If you install Oracle Databases on servers with multiple Oracle homes, multiple aliases, or
                      without a static IP address, then review these network configuration topics.

                      If you are installing Oracle Database on a server with a static host name and IP address and at
                      least one network interface, then no special network configuration is required.


                                Note
                                If you have a firewall running, ensure that all the required ports are open. See, Oracle
                                Database Component Port Numbers and Protocols for a list of port numbers and
                                protocols configured for Oracle Database components.


                      •     About Oracle Database Network Configuration Options
                            You can enable database clients to connect to servers associated with multiple IP
                            addresses, and you can install Oracle Database on servers with no network connections,
                            and set up database services after installation.
                      •     About Assigning Global Database Names During Installation
                            The database name input field is used to set the DB_NAME, DB_UNIQUE_NAME, and
                            DB_DOMAIN Oracle initialization parameter values.
                      •     Network Configuration for Computers Completed After Installation
                            You must confirm that a non-networked computer can connect to itself to ensure that you
                            can configure client network resolution after installation. A non-networked computer is a
                            computer that does not have a fixed network address, such as a computer using DHCP.
                      •     Network Configuration for Multihome Computers
                            You must set the ORACLE_HOSTNAME environment variable to install Oracle Database on a
                            multihomed computer. A multihomed computer is associated with multiple IP addresses.
                      •     Setting the ORACLE_HOSTNAME Environment Variable
                            Run the commands shown in this example as the Oracle user account to set the
                            ORACLE_HOSTNAME environment variable.
                      •     Network Configuration for Computers with Multiple Aliases
                            You must set the ORACLE_HOSTNAME environment variable to install Oracle Database on a
                            multialias computer. A multialias computer is one to which multiple aliases resolve.


About Oracle Database Network Configuration Options
                      You can enable database clients to connect to servers associated with multiple IP addresses,
                      and you can install Oracle Database on servers with no network connections, and set up
                      database services after installation.
                      Typically, the computer on which you want to install Oracle Database is a server running a
                      single database instance, with a single host name that is resolvable on a network. Oracle
                      Universal Installer uses the host name and Oracle Database instance information to set up




Database Installation Guide
E96434-12                                                                                                      April 30, 2026
Copyright © 2015, 2026, Oracle and/or its affiliates.                                                            Page 1 of 4
                                                                                                                    Chapter 6
                                                                    About Assigning Global Database Names During Installation


                      network services automatically. The database provides database services to clients using a
                      connect descriptor that resolves to the host name where the database instance is running.
                      However, you can configure Oracle Database on servers with the following nonstandard
                      configurations:
                      •     Multihomed Computers: Servers with multiple Oracle Database installations
                      •     Multiple Alias Computers: Servers with multiple aliases, so that more than one host
                            name resolves to the computer
                      •     Non-Networked computers: Servers that do not have network connectivity at the time of
                            installation


About Assigning Global Database Names During Installation
                      The database name input field is used to set the DB_NAME, DB_UNIQUE_NAME, and
                      DB_DOMAIN Oracle initialization parameter values.

                      The Oracle Database software identifies a database by its global database name. A global
                      database name consists of the database name and database domain. Usually, the database
                      domain is the same as the network domain, but it need not be. The global database name
                      uniquely distinguishes a database from any other database in the same network. You specify
                      the global database name when you create a database during the installation or using the
                      Oracle Database Configuration Assistant.

                      sales.us.example.com


                      Here:
                      •     sales.us is the name of the database. The database name, DB_UNIQUE_NAME, portion is
                            a string of no more than 30 characters that can contain alphanumeric characters,
                            underscore (_), dollar sign ($), and pound sign (#) but must begin with an alphabetic
                            character. No other special characters are permitted in a database name.
                      •     sales.us is also the DB_NAME. The DB_NAME initialization parameter specifies a database
                            identifier of up to eight characters.
                      •     example.com is the database domain in which the database is located. In this example, the
                            database domain equals the network domain. Together, the database name and the
                            database domain make the global database name unique. The domain portion is a string
                            of no more than 128 characters that can contain alphanumeric characters, underscore (_),
                            and pound sign (#). The DB_DOMAIN initialization parameter specifies the database
                            domain name.
                      However, the DB_NAME parameter need not necessarily be the first eight characters of
                      DB_UNIQUE_NAME.

                      The DB_NAME parameter and the DB_DOMAIN parameter combine to create the global
                      database name value.
                      The system identifier (SID) identifies a specific database instance. The SID uniquely
                      distinguishes the instance from any other instance on the same computer. Each database
                      instance requires a unique SID and database name. In most cases, the SID equals the
                      database name portion of the global database name.
                      Related Topics
                      •     Oracle Database Reference



Database Installation Guide
E96434-12                                                                                                       April 30, 2026
Copyright © 2015, 2026, Oracle and/or its affiliates.                                                             Page 2 of 4
                                                                                                                         Chapter 6
                                                                  Network Configuration for Computers Completed After Installation


                      •     Oracle Database Administrator's Guide


Network Configuration for Computers Completed After
Installation
                      You must confirm that a non-networked computer can connect to itself to ensure that you can
                      configure client network resolution after installation. A non-networked computer is a computer
                      that does not have a fixed network address, such as a computer using DHCP.
                      You can install Oracle Database on a non-networked computer. If the computer, such as a
                      laptop, is configured for DHCP and you plan to connect the computer to the network after the
                      Oracle Database installation, then use the ping command on the computer on which you want
                      to install the database to check if the computer can connect to itself. Perform this step by first
                      using only the host name and then using the fully qualified name, which should be in the /etc/
                      hosts file.

                      If you connect the computer to a network after installation, then the Oracle Database instance
                      on the computer can work with other instances on the network. The computer can use a static
                      IP or DHCP, depending on the network to which you are connected.
                      When you run the ping command on the computer itself, the ping command should return the
                      IP address of the computer. If the ping command fails, then contact your network
                      administrator.


Network Configuration for Multihome Computers
                      You must set the ORACLE_HOSTNAME environment variable to install Oracle Database on a
                      multihomed computer. A multihomed computer is associated with multiple IP addresses.
                      Typically, a server configured to run multiple Oracle Database Oracle homes is configured with
                      multiple network interface cards. A host name resolves to an IP address configured for one
                      network card for each Oracle Database. You can also set up aliases for host names. By
                      default, during installation, Oracle Universal Installer uses the value set for the environment
                      variable ORACLE_HOSTNAME set for the Oracle installation user account running the installation to
                      find the host name. If the user environment variable ORACLE_HOSTNAME is not set for the Oracle
                      user, and you are installing on a computer that has multiple network cards, then Oracle
                      Universal Installer determines the host name from the /etc/hosts file and the information you
                      provide during the installation session.
                      Oracle Database clients connecting to the database must be able to access the computer by
                      using either the alias for the host name, or by using the host name associated with that
                      instance. To verify that the client can resolve to the database using both alias and host name,
                      use the ping command to check connectivity to the host name both for the database on the
                      server (host name only), and for the fully qualified domain name (host name and domain
                      name).


                                Note
                                Clients must be able to obtain a response using the ping command both for the host
                                name and for the fully qualified domain name. If either test fails, then contact your
                                network administrator to resolve the issue.




Database Installation Guide
E96434-12                                                                                                           April 30, 2026
Copyright © 2015, 2026, Oracle and/or its affiliates.                                                                 Page 3 of 4
                                                                                                              Chapter 6
                                                                      Setting the ORACLE_HOSTNAME Environment Variable




Setting the ORACLE_HOSTNAME Environment Variable
                      Run the commands shown in this example as the Oracle user account to set the
                      ORACLE_HOSTNAME environment variable.

                      The following example shows the commands to run on the Oracle user account to set the
                      ORACLE_HOSTNAME environment variable. In this example, the fully qualified host name is
                      somehost.example.com.

                      Bourne, Bash or Korn Shell

                      $ export ORACLE_HOSTNAME=somehost.example.com


                      C Shell

                      % setenv ORACLE_HOSTNAME somehost.example.com



Network Configuration for Computers with Multiple Aliases
                      You must set the ORACLE_HOSTNAME environment variable to install Oracle Database on a
                      multialias computer. A multialias computer is one to which multiple aliases resolve.
                      A computer with multiple aliases is a computer that is registered with the naming service under
                      a single IP address, but which resolves multiple aliases to that address. The naming service
                      resolves any of those aliases to the same computer. Before installing Oracle Database on such
                      a computer, set the Oracle installation owner environment variable ORACLE_HOSTNAME to the
                      computer whose host name you want to use.




Database Installation Guide
E96434-12                                                                                                 April 30, 2026
Copyright © 2015, 2026, Oracle and/or its affiliates.                                                       Page 4 of 4
7
Supported Storage Options for Oracle
Database and Oracle Grid Infrastructure
                      Review supported storage options as part of your installation planning process.
                      •     Supported Storage Options for Oracle Database
                            The following table shows the storage options supported for Oracle Database binaries and
                            files:
                      •     About Oracle Grid Infrastructure for a Standalone Server
                            If you plan to use Oracle Automatic Storage Management (Oracle ASM), then you must
                            install Oracle Restart before installing your database.
                      •     About Upgrading Existing Oracle Automatic Storage Management Instances
                            Oracle Automatic Storage Management (Oracle ASM) upgrades are carried out during an
                            Oracle Grid Infrastructure upgrade.
                      •     About Managing Disk Groups for Older Database Versions
                            When you install earlier Oracle Database releases on Oracle Grid Infrastructure, use
                            Oracle ASM Configuration Assistant (Oracle ASMCA) to create and modify disk groups.
                      •     Oracle ACFS and Oracle ADVM
                            Oracle Automatic Storage Management Cluster File System (Oracle ACFS) extends
                            Oracle ASM technology to support of all of your application data in both single instance
                            and cluster configurations.
                      •     File System Options for Oracle Database
                            If you install Oracle Database files on a file system, then Oracle Database Configuration
                            Assistant creates the database files in a directory on a file system mounted on the
                            computer.
                      •     Guidelines for Placing Oracle Database Files On a File System or Logical Volume
                            If you choose to place the Oracle Database files on a file system, then use the following
                            guidelines when deciding where to place them:
                      •     About NFS Storage for Data Files
                            Review this section for NFS storage configuration guidelines.
                      •     About Direct NFS Client Mounts to NFS Storage Devices
                            Direct NFS (dNFS) Client integrates the NFS client functionality directly in the Oracle
                            software to optimize the I/O path between Oracle and the NFS server. This integration can
                            provide significant performance improvements.


Supported Storage Options for Oracle Database
                      The following table shows the storage options supported for Oracle Database binaries and
                      files:




Database Installation Guide
E96434-12                                                                                                    April 30, 2026
Copyright © 2015, 2026, Oracle and/or its affiliates.                                                          Page 1 of 9
                                                                                                                         Chapter 7
                                                                          About Oracle Grid Infrastructure for a Standalone Server



                      Table 7-1       Supported Storage Options for Oracle Database

                       Storage Option                   Oracle Database   Oracle Database Data        Oracle Database
                                                        Binaries          Files                       Recovery Files
                       Oracle Automatic                 No                Yes                         Yes
                       Storage Management
                       (Oracle ASM)
                       Note: Loopback devices
                       are not supported for
                       use with Oracle ASM
                       Oracle Automatic                 Yes               Yes (Oracle Database     Yes (Oracle Database
                       Storage Management                                 12c Release 1 (12.1) and 12c Release 1 (12.1)
                       Cluster File System                                later)                   and later
                       (Oracle ACFS)
                       Local file system                Yes               Yes, but not                Yes, but not
                                                                          recommended                 recommended
                       Network file system              Yes               Yes                         Yes
                       (NFS) on a certified
                       network-attached
                       storage (NAS) filer

                      Guidelines for Storage Options
                      Use the following guidelines when choosing storage options:
                      •     Oracle strongly recommends that you use a dedicated set of disks for Oracle ASM.
                      •     You can choose any combination of the supported storage options for each file type
                            provided that you satisfy all requirements listed for the chosen storage options.
                      •     You can use Oracle ASM to store Oracle Clusterware files.
                      •     Direct use of raw or block devices is not supported. You can only use raw or block devices
                            under Oracle ASM.
                      Related Topics
                      •     Oracle Database Upgrade Guide


About Oracle Grid Infrastructure for a Standalone Server
                      If you plan to use Oracle Automatic Storage Management (Oracle ASM), then you must install
                      Oracle Restart before installing your database.
                      Oracle Grid Infrastructure for a standalone server is a version of Oracle Grid Infrastructure that
                      supports single instance databases. This support includes volume management, file system,
                      and automatic restart capabilities. Oracle Grid Infrastructure for a standalone server includes
                      Oracle Restart and Oracle Automatic Storage Management. Oracle combined the two
                      infrastructure products into a single set of binaries that is installed into an Oracle Restart home.
                      Oracle Restart is a feature provided as part of Oracle Grid Infrastructure. Oracle Restart
                      monitors and can restart Oracle Database instances, Oracle Net Listeners, and Oracle ASM
                      instances. Oracle Restart is currently restricted to manage single instance Oracle Databases
                      and Oracle ASM instances only.
                      Oracle Automatic Storage Management is a volume manager and a file system for Oracle
                      Database files that supports single-instance Oracle Database and Oracle Real Application



Database Installation Guide
E96434-12                                                                                                           April 30, 2026
Copyright © 2015, 2026, Oracle and/or its affiliates.                                                                 Page 2 of 9
                                                                                                                     Chapter 7
                                                        About Upgrading Existing Oracle Automatic Storage Management Instances


                      Clusters (Oracle RAC) configurations. Oracle Automatic Storage Management also supports a
                      general purpose file system for your application needs, including Oracle Database binaries.
                      Oracle Automatic Storage Management is Oracle's recommended storage management
                      solution that provides an alternative to conventional volume managers, and file systems.
                      Oracle Restart improves the availability of your Oracle database by providing the following
                      services:
                      •     When there is a hardware or a software failure, Oracle Restart automatically starts all
                            Oracle components, including the Oracle database instance, Oracle Net Listener, database
                            services, and Oracle ASM.
                      •     Oracle Restart starts components in the proper order when the database host is restarted.
                      •     Oracle Restart runs periodic checks to monitor the status of Oracle components. If a check
                            operation fails for a component, then the component is shut down and restarted.
                      Note the following restrictions for using Oracle Restart:
                      •     You can neither install Oracle Restart on an Oracle Grid Infrastructure cluster member
                            node, nor add an Oracle Restart server to an Oracle Grid Infrastructure cluster member
                            node. Oracle Restart supports single-instance databases on one server, while Oracle Grid
                            Infrastructure for a Cluster supports single-instance or Oracle RAC databases on a cluster.
                      •     If you want to use Oracle ASM or Oracle Restart, then you should install Oracle Grid
                            Infrastructure for a standalone server before you install and create the database.
                            Otherwise, you must install Oracle Restart, and then manually register the database with
                            Oracle Restart.
                      •     You can use the Oracle Restart implementation of Oracle Grid Infrastructure only in single-
                            instance (nonclustered) environments. Use Oracle Grid Infrastructure with Oracle
                            Clusterware for clustered environments.


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
                      Upgrades of Oracle ASM from releases prior to 11g Release 2 (11.2) are not supported.
                      Related Topics
                      •     Oracle Automatic Storage Management Administrator's Guide
                      •     Oracle Database Upgrade Guide




Database Installation Guide
E96434-12                                                                                                        April 30, 2026
Copyright © 2015, 2026, Oracle and/or its affiliates.                                                              Page 3 of 9
                                                                                                                           Chapter 7
                                                                              About Managing Disk Groups for Older Database Versions




About Managing Disk Groups for Older Database Versions
                      When you install earlier Oracle Database releases on Oracle Grid Infrastructure, use Oracle
                      ASM Configuration Assistant (Oracle ASMCA) to create and modify disk groups.
                      Releases prior to Oracle Database 11g Release 2 used Oracle Database Configuration
                      Assistant (Oracle DBCA) to perform administrative tasks on Oracle ASM. Starting with Oracle
                      Database 11g Release 2 (11.2), Oracle ASM is installed as part of an Oracle Grid Infrastructure
                      installation. You can no longer use Oracle DBCA to perform administrative tasks on Oracle
                      ASM.



                                See Also
                                Oracle Automatic Storage Management Administrator's Guide for details about
                                configuring disk group compatibility for databases using Oracle Database 11g software
                                with this release of Oracle Grid Infrastructure.




Oracle ACFS and Oracle ADVM
                      Oracle Automatic Storage Management Cluster File System (Oracle ACFS) extends Oracle
                      ASM technology to support of all of your application data in both single instance and cluster
                      configurations.
                      Oracle Automatic Storage Management Dynamic Volume Manager (Oracle ADVM) provides
                      volume management services and a standard disk device driver interface to clients. Oracle
                      ACFS communicates with Oracle ASM through the Oracle ADVM interface.
                      •     Oracle ACFS and Oracle ADVM Support on Oracle Solaris
                            Oracle ACFS and Oracle ADVM are supported on Oracle Solaris.
                      •     Restrictions and Guidelines for Oracle ACFS
                            Review these topics as part of your storage plan for using Oracle ACFS for single instance
                            and cluster configurations.
                      Related Topics
                      •     Oracle Automatic Storage Management Administrator's Guide


Oracle ACFS and Oracle ADVM Support on Oracle Solaris
                      Oracle ACFS and Oracle ADVM are supported on Oracle Solaris.

                      Table 7-2       Platforms That Support Oracle ACFS and Oracle ADVM

                       Platform / Operating             Support Information
                       System
                       Oracle Solaris 11                Supported.
                       Oracle Solaris                   Not supported.
                       containers




Database Installation Guide
E96434-12                                                                                                              April 30, 2026
Copyright © 2015, 2026, Oracle and/or its affiliates.                                                                    Page 4 of 9
                                                                                                                        Chapter 7
                                                                                                  Oracle ACFS and Oracle ADVM



                                See Also
                                •      My Oracle Support Note 1369107.1 for more information about platforms and
                                       releases that support Oracle ACFS and Oracle ADVM:
                                       https://support.oracle.com/rs?type=doc&id=1369107.1
                                •      Patch Set Updates for Oracle Products (My Oracle Support Note 854428.1) for
                                       current release and support information:
                                       https://support.oracle.com/rs?type=doc&id=854428.1




Restrictions and Guidelines for Oracle ACFS
                      Review these topics as part of your storage plan for using Oracle ACFS for single instance and
                      cluster configurations.
                      •     Oracle Automatic Storage Management Cluster File System (Oracle ACFS) provides a
                            general purpose file system.
                      •     You can only use Oracle ACFS when Oracle ASM is configured.
                      •     Note the following general guidelines and restrictions for placing Oracle Database and
                            Oracle Grid Infrastructure files on Oracle ACFS:
                            –       You can place Oracle Database binaries, data files, and administrative files (for
                                    example, trace files) on Oracle ACFS.
                            –       Oracle ACFS does not support encryption or replication with Oracle Database data
                                    files, tablespace files, control files, redo logs, archive logs, RMAN backups, Data
                                    Pump dumpsets, and flashback files.
                            –       You can place Oracle Database homes on Oracle ACFS only if the database release is
                                    Oracle Database 11g Release 2, or more recent releases. You cannot install earlier
                                    releases of Oracle Database on Oracle ACFS.
                            –       For installations on Oracle Clusterware, you cannot place Oracle Clusterware files on
                                    Oracle ACFS.
                      •     Oracle Restart does not support root-based Oracle Clusterware resources. For this reason,
                            the following restrictions apply if you run Oracle ACFS on an Oracle Restart Configuration:
                            –       Starting with Oracle Database 18c, configuration assistants do not allow the creation of
                                    Oracle Database homes on Oracle ACFS in an Oracle Restart configuration.
                            –       Oracle Restart does not support Oracle ACFS resources on all platforms.
                            –       Starting with Oracle Database 12c, Oracle Restart configurations do not support the
                                    Oracle ACFS registry.
                            –       On Linux, Oracle ACFS provides an automated mechanism to load and unload drivers
                                    and mount and unmount Oracle ACFS file systems on system restart and shutdown.
                                    However, Oracle ACFS does not provide automated recovery of mounted file systems
                                    when the system is running. Other than Linux, Oracle ACFS does not provide this
                                    automated mechanism on other operating systems.
                            –       Creating Oracle data files on an Oracle ACFS file system is not supported in Oracle
                                    Restart configurations. Creating Oracle data files on an Oracle ACFS file system is
                                    supported on Oracle Grid Infrastructure for a cluster configurations.
                      •     Oracle ACFS and Oracle ADVM are not supported on IBM AIX Workload Partitions
                            (WPARs).


Database Installation Guide
E96434-12                                                                                                        April 30, 2026
Copyright © 2015, 2026, Oracle and/or its affiliates.                                                              Page 5 of 9
                                                                                                                     Chapter 7
                                                                                       File System Options for Oracle Database


                      Related Topics
                      •     Oracle Automatic Storage Management Administrator's Guide


File System Options for Oracle Database
                      If you install Oracle Database files on a file system, then Oracle Database Configuration
                      Assistant creates the database files in a directory on a file system mounted on the computer.
                      Oracle recommends that the file system be separate from the file systems used by the
                      operating system or the Oracle Database software.
                      The file system can be any of the following:

                      Standard Oracle Database Creation Options
                      •     A file system on a disk that is physically attached to the system.
                            If you are creating a database on basic disks that are not logical volumes or RAID devices,
                            then Oracle recommends that you follow the Optimal Flexible Architecture (OFA)
                            recommendations and distribute the database files over many disks.
                      •     A file system on a logical volume manager (LVM) volume or a RAID device.
                            If you are using multiple disks in an LVM or RAID configuration, then Oracle recommends
                            that you use the Stripe and Mirror Everything (S.A.M.E) methodology to increase
                            performance and reliability. Using this methodology, you do not have to specify multiple file
                            system mount points for the database storage.
                      •     A network file system (NFS) mounted from a certified network-attached storage (NAS)
                            device. You also have the option to use Direct NFS Client, which simplifies the
                            administration of NFS configurations and also improves performance.

                      Advanced Oracle Database Creation Options
                      •     The three file system options available to standard Oracle Database installations.
                      •     With Oracle Managed Files, you specify file system directories in which the database
                            automatically creates, names, and manages files at the database object level.
                            If you use the Oracle Managed Files feature, then you must specify only the database
                            object name instead of file names when creating or deleting database files.
                      Related Topics
                      •     Oracle RAC Technologies Matrix for Linux Platforms
                      •     Oracle Database Administrator’s Guide


Guidelines for Placing Oracle Database Files On a File System
or Logical Volume
                      If you choose to place the Oracle Database files on a file system, then use the following
                      guidelines when deciding where to place them:
                      •     The default path suggested by Oracle Universal Installer for the database file directory is a
                            subdirectory of the Oracle base directory.
                      •     You can choose either a single file system or more than one file system to store the
                            database files:



Database Installation Guide
E96434-12                                                                                                        April 30, 2026
Copyright © 2015, 2026, Oracle and/or its affiliates.                                                              Page 6 of 9
                                                                                                                       Chapter 7
                                                                                                About NFS Storage for Data Files


                            –    If you want to use a single file system, then choose a file system on a physical device
                                 that is dedicated to the database.
                                 For best performance and reliability, choose a RAID device or a logical volume on
                                 more than one physical device, and implement a stripe-and-mirror-everything (SAME)
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


About NFS Storage for Data Files
                      Review this section for NFS storage configuration guidelines.

                      Network-Attached Storage and NFS Protocol
                      Network-attached storage (NAS) systems use the network file system (NFS) protocol to to
                      access files over a network, which enables client servers to access files over networks as
                      easily as to storage devices attached directly to the servers. You can store data files on
                      supported NFS systems. NFS is a shared file system protocol, so NFS can support both single
                      instance and Oracle Real Application Clusters databases.


                                Note
                                The performance of Oracle software and databases stored on NAS devices depends
                                on the performance of the network connection between the servers and the network-
                                attached storage devices.For better performance, Oracle recommends that you
                                connect servers to NAS devices using private dedicated network connections. NFS
                                network connections should use Gigabit Ethernet or better.



                      Refer to your vendor documentation to complete NFS configuration and mounting.

                      Requirements for Using NFS Storage
                      Before you start installation, NFS file systems must be mounted and available to servers.




Database Installation Guide
E96434-12                                                                                                          April 30, 2026
Copyright © 2015, 2026, Oracle and/or its affiliates.                                                                Page 7 of 9
                                                                                                                    Chapter 7
                                                                        About Direct NFS Client Mounts to NFS Storage Devices




About Direct NFS Client Mounts to NFS Storage Devices
                      Direct NFS (dNFS) Client integrates the NFS client functionality directly in the Oracle software
                      to optimize the I/O path between Oracle and the NFS server. This integration can provide
                      significant performance improvements.
                      Direct NFS Client supports NFSv3, NFSv4, NFSv4.1, and pNFS protocols to access the NFS
                      server. Direct NFS Client also simplifies, and in many cases automates, the performance
                      optimization of the NFS client configuration for database workloads.
                      Starting with Oracle Database 12c Release 2, when you enable Direct NFS, you can also
                      enable the Direct NFS dispatcher. The Direct NFS dispatcher consolidates the number of TCP
                      connections that are created from a database instance to the NFS server. In large database
                      deployments, using Direct NFS dispatcher improves scalability and network performance.
                      Parallel NFS deployments also require a large number of connections. Hence, the Direct NFS
                      dispatcher is recommended with Parallel NFS deployments too.
                      Direct NFS Client can obtain NFS mount points either from the operating system mount
                      entries, or from the oranfstab file.

                      Direct NFS Client Requirements
                      •     NFS servers must have write size values (wtmax) of 32768 or greater to work with Direct
                            NFS Client.
                      •     NFS mount points must be mounted both by the operating system kernel NFS client and
                            Direct NFS Client, even though you configure Direct NFS Client to provide file service.
                            If Oracle Database cannot connect to an NFS server using Direct NFS Client, then Oracle
                            Database connects to the NFS server using the operating system kernel NFS client. When
                            Oracle Database fails to connect to NAS storage though Direct NFS Client, it logs an
                            informational message about the Direct NFS Client connect error in the Oracle alert and
                            trace files.
                      •     Follow standard guidelines for maintaining integrity of Oracle Database files mounted by
                            both operating system NFS and by Direct NFS Client.

                      Direct NFS Mount Point Search Order
                      Direct NFS Client searches for mount entries in the following order:
                      1.    $ORACLE_HOME/dbs/oranfstab
                      2.    /var/opt/oracle/oranfstab
                      3.    /etc/mnttab
                      Direct NFS Client uses the first matching entry as the mount point.


                                Note
                                You can have only one active NFS Client implementation for each instance. Enabling
                                Direct NFS Client on an instance prevents you from using another NFS Client
                                implementation, such as kernel NFS Client.




Database Installation Guide
E96434-12                                                                                                       April 30, 2026
Copyright © 2015, 2026, Oracle and/or its affiliates.                                                             Page 8 of 9
                                                                                                                     Chapter 7
                                                                         About Direct NFS Client Mounts to NFS Storage Devices



                      Default NFS Version Selection
                      The Direct NFS Client uses the following rules to determine the default NFS protocol version:
                      1.    If a matching mount entry is found in oranfstab and nfs_version is specified, then dNFS
                            uses the specified version.
                      2.    If a matching mount entry is found in oranfstab and nfs_version is not specified, then
                            dNFS uses NFSv3.
                      3.    If a matching mount entry is not found in oranfstab or if oranfstab is not present, then
                            dNFS queries the operating system mount table (mtab) and uses the NFS version
                            configured for the mount.
                      4.    If the specified version in oranfstab or mtab is NFSv4.2, then dNFS uses NFSv4.1
                            because NFSv4.2 is not supported.

                      Related Topics
                      •     Configuring NFS Buffer Size Parameters for Oracle Database
                            Set the values for the NFS buffer size parameters rsize and wsize to at least 32768.
                      •     Creating an oranfstab File for Direct NFS Client
                            Direct NFS uses a configuration file, oranfstab, to determine the available mount points.


                                See Also
                                •    Oracle Database Reference for information about setting the
                                     enable_dnfs_dispatcher parameter in the initialization parameter file to enable
                                     Direct NFS dispatcher
                                •    Oracle Database Performance Tuning Guide for performance benefits of enabling
                                     Parallel NFS and Direct NFS dispatcher
                                •    Oracle Automatic Storage Management Administrator's Guide for guidelines about
                                     managing Oracle Database data files created with Direct NFS Client or kernel
                                     NFS




Database Installation Guide
E96434-12                                                                                                        April 30, 2026
Copyright © 2015, 2026, Oracle and/or its affiliates.                                                              Page 9 of 9
8
Configuring File System Storage for Oracle
Database
                      Complete these procedures to use file system storage for Oracle Database.
                      For optimal database organization and performance, Oracle recommends that you install data
                      files and the Oracle Database software in different disks.
                      If you plan to place storage on Network File System (NFS) protocol devices, then Oracle
                      recommends that you use Oracle Direct NFS (dNFS) to take advantage of performance
                      optimizations built into the Oracle Direct NFS client.
                      •     Configuring NFS Buffer Size Parameters for Oracle Database
                            Set the values for the NFS buffer size parameters rsize and wsize to at least 32768.
                      •     Checking TCP Network Protocol Buffer for Direct NFS Client
                            Check your TCP network buffer size to ensure that it is adequate for the speed of your
                            servers.
                      •     Creating an oranfstab File for Direct NFS Client
                            Direct NFS uses a configuration file, oranfstab, to determine the available mount points.
                      •     Enabling and Disabling Direct NFS Client Control of NFS
                            By default, Direct NFS Client is installed in a disabled state with single-instance Oracle
                            Database installations. Before enabling Direct NFS, you must configure an oranfstab file.
                      •     Enabling Hybrid Columnar Compression on Direct NFS Client
                            Perform these steps to enable Hybrid Columnar Compression (HCC) on Direct NFS Client:
                      Related Topics
                      •     My Oracle Support note 1496040.1


Configuring NFS Buffer Size Parameters for Oracle Database
                      Set the values for the NFS buffer size parameters rsize and wsize to at least 32768.

                      For example, to use rsize and wsize buffer settings with the value 32768 for an Oracle
                      Database data files mount point, set mount point parameters to values similar to the following:

                      nfs_server:/vol/DATA/oradata /home/oracle/netapp nfs\
                      rw,bg,hard,nointr,rsize=32768,wsize=32768,tcp,actimeo=0,vers=3,timeo=600


                      Direct NFS Client issues writes at wtmax granularity to the NFS server.

                      Related Topics
                      •     My Oracle Support note 359515.1




Database Installation Guide
E96434-12                                                                                                   April 30, 2026
Copyright © 2015, 2026, Oracle and/or its affiliates.                                                         Page 1 of 6
                                                                                                                     Chapter 8
                                                                    Checking TCP Network Protocol Buffer for Direct NFS Client




Checking TCP Network Protocol Buffer for Direct NFS Client
                      Check your TCP network buffer size to ensure that it is adequate for the speed of your servers.
                      By default, the network buffer size is set to 1 MB for TCP, and 2 MB for UDP. The TCP buffer
                      size can set a limit on file transfers, which can negatively affect performance for Direct NFS
                      Client users.
                      To check the current TCP buffer size on Oracle Solaris 11:

                      # ipadm show-prop -p max_buf tcp


                      Oracle recommends that you set the value based on the link speed of your servers. For
                      example:
                      On Oracle Solaris 11:

                      # ipadm set-prop -p max_buf=1048576 tcp


                      Additionally, check your TCP send window size and TCP receive window size to ensure that
                      they are adequate for the speed of your servers.
                      To check the current TCP send window size and TCP receive window size on Oracle Solaris
                      11:

                      # ipadm show-prop -p send_buf tcp
                      # ipadm show-prop -p recv_buf tcp


                      Oracle recommends that you set the value based on the link speed of your servers. For
                      example:
                      On Oracle Solaris 11:

                      # ipadm set-prop -p send_buf=1056768 tcp
                      # ipadm set-prop -p recv_buf=1056768 tcp




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


Database Installation Guide
E96434-12                                                                                                       April 30, 2026
Copyright © 2015, 2026, Oracle and/or its affiliates.                                                             Page 2 of 6
                                                                                                                        Chapter 8
                                                                                  Creating an oranfstab File for Direct NFS Client


                      •     local
                            Up to four paths on the database host, specified by IP address or by name, as displayed
                            using the ifconfig command run on the database host.
                      •     path
                            Up to four network paths to the NFS server, specified either by IP address, or by name, as
                            displayed using the ifconfig command on the NFS server.
                      •     export
                            The exported path from the NFS server.
                      •     mount
                            The corresponding local mount point for the exported volume.
                      •     mnt_timeout
                            Specifies (in seconds) the time Direct NFS Client should wait for a successful mount
                            before timing out. This parameter is optional. The default timeout is 10 minutes (600).
                      •     nfs_version
                            Specifies the NFS protocol version used by Direct NFS Client. Possible values are NFSv3,
                            NFSv4, NFSv4.1, and pNFS. The default version is NFSv3. If you select NFSv4.x, then
                            you must configure the value in oranfstab for nfs_version.
                            Specify nfs_version as pNFS, if you want to use Direct NFS with Parallel NFS. Direct
                            NFS supports only the default sys security authentication with Parallel NFS. Direct NFS
                            does not support Parallel NFS when combined with any of the Kerberos authentication
                            parameters.
                      •     security_default
                            Specifies the default security mode applicable for all the exported NFS server paths for a
                            server entry. This parameter is optional. sys is the default value. See the description of the
                            security parameter for the supported security levels for the security_default
                            parameter.
                      •     security
                            Specifies the security level, to enable security using Kerberos authentication protocol with
                            Direct NFS Client. This optional parameter can be specified per export-mount pair. The
                            supported security levels for the security_default and security parameters are:
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
                            For NFS server Kerberos security setup, review the relevant NFS server documentation.
                            For Kerberos client setup, review the relevant operating system documentation.
                      •     dontroute



Database Installation Guide
E96434-12                                                                                                           April 30, 2026
Copyright © 2015, 2026, Oracle and/or its affiliates.                                                                 Page 3 of 6
                                                                                                                     Chapter 8
                                                                               Creating an oranfstab File for Direct NFS Client


                            Specifies that outgoing messages should not be routed by the operating system, but
                            instead sent using the IP address to which they are bound.


                                     Note
                                     The dontroute option is a POSIX option, which sometimes does not work on
                                     Linux systems with multiple paths in the same subnet.


                      •     management
                            Enables Direct NFS Client to use the management interface for SNMP queries. You can
                            use this parameter if SNMP is running on separate management interfaces on the NFS
                            server. The default value is the server parameter value.
                      •     community
                            Specifies the community string for use in SNMP queries. Default value is public.
                      The following examples show three possible NFS server entries in oranfstab. A single
                      oranfstab can have multiple NFS server entries.

                      Example 8-1          Using Local and Path NFS Server Entries
                      The following example uses both local and path. Because they are in different subnets, you do
                      not have to specify dontroute.

                      server: MyDataServer1
                      local: 192.0.2.0
                      path: 192.0.2.1
                      local: 192.0.100.0
                      path: 192.0.100.1
                      export: /vol/oradata1 mount: /mnt/oradata1


                      Example 8-2          Using Local and Path in the Same Subnet, with dontroute
                      Local and path in the same subnet, where dontroute is specified:

                      server: MyDataServer2
                      local: 192.0.2.0
                      path: 192.0.2.128
                      local: 192.0.2.1
                      path: 192.0.2.129
                      dontroute
                      export: /vol/oradata2 mount: /mnt/oradata2


                      Example 8-3 Using Names in Place of IP Addresses, with Multiple Exports,
                      management and community

                      server: MyDataServer3
                      local: LocalPath1
                      path: NfsPath1
                      local: LocalPath2
                      path: NfsPath2
                      local: LocalPath3
                      path: NfsPath3
                      local: LocalPath4


Database Installation Guide
E96434-12                                                                                                        April 30, 2026
Copyright © 2015, 2026, Oracle and/or its affiliates.                                                              Page 4 of 6
                                                                                                                      Chapter 8
                                                                        Enabling and Disabling Direct NFS Client Control of NFS


                      path: NfsPath4
                      dontroute
                      export: /vol/oradata3 mount: /mnt/oradata3
                      export: /vol/oradata4 mount: /mnt/oradata4
                      export: /vol/oradata5 mount: /mnt/oradata5
                      export: /vol/oradata6 mount: /mnt/oradata6
                      management: MgmtPath1
                      community: private


                      Example 8-4          Using Kerberos Authentication with Direct NFS Export
                      The security parameter overrides security_default:

                      server: nfsserver
                       local: 192.0.2.0
                       path: 192.0.2.2
                       local: 192.0.2.3
                       path: 192.0.2.4
                       export: /private/oracle1/logs mount: /logs security: krb5
                       export: /private/oracle1/data mount: /data security: krb5p
                       export: /private/oracle1/archive mount: /archive security: sys
                       export: /private/oracle1/data1 mount: /data1
                       security_default: krb5i


                      Related Topics
                      •     About Direct NFS Client Mounts to NFS Storage Devices
                            Direct NFS (dNFS) Client integrates the NFS client functionality directly in the Oracle
                            software to optimize the I/O path between Oracle and the NFS server. This integration can
                            provide significant performance improvements.


Enabling and Disabling Direct NFS Client Control of NFS
                      By default, Direct NFS Client is installed in a disabled state with single-instance Oracle
                      Database installations. Before enabling Direct NFS, you must configure an oranfstab file.

                      Use these procedures to enable or disable Direct NFS Client Oracle Disk Manager Control of
                      NFS

                      Enabling Direct NFS Client Control of NFS
                      1.    Change the directory to $ORACLE_HOME/rdbms/lib.
                      2.    Enter the following command:

                            make -f ins_rdbms.mk dnfs_on

                      Disabling Direct NFS Client Control of NFS
                      1.    Log in as the Oracle software installation owner, and disable Direct NFS Client using the
                            following commands:

                            cd $ORACLE_HOME/rdbms/lib
                            make -f ins_rdbms.mk dnfs_off

                      2.    Remove the oranfstab file.


Database Installation Guide
E96434-12                                                                                                        April 30, 2026
Copyright © 2015, 2026, Oracle and/or its affiliates.                                                              Page 5 of 6
                                                                                                                     Chapter 8
                                                                     Enabling Hybrid Columnar Compression on Direct NFS Client



                                Note
                                If you remove an NFS path that an Oracle Database is using, then you must restart
                                the database for the change to take effect.




Enabling Hybrid Columnar Compression on Direct NFS Client
                      Perform these steps to enable Hybrid Columnar Compression (HCC) on Direct NFS Client:
                      1.    Ensure that SNMP is enabled on the ZFS storage server. For example:

                            $ snmpget -v1 -c public server_name .1.3.6.1.4.1.42.2.225.1.4.2.0
                            SNMPv2-SMI::enterprises.42.2.225.1.4.2.0 = STRING: "Sun Storage 7410"

                      2.    If SNMP is enabled on an interface other than the NFS server, then configure oranfstab
                            using the management parameter.
                      3.    If SNMP is configured using a community string other than public, then configure
                            oranfstab file using the community parameter.
                      4.    Ensure that libnetsnmp.so is installed by checking if snmpget is available.




Database Installation Guide
E96434-12                                                                                                        April 30, 2026
Copyright © 2015, 2026, Oracle and/or its affiliates.                                                              Page 6 of 6
9
Configuring Storage for Oracle Grid
Infrastructure for a Standalone Server
                      Complete these procedures to use Oracle Grid Infrastructure for a standalone server, which
                      includes Oracle Automatic Storage Management (Oracle ASM).
                      Oracle Grid Infrastructure for a standalone server, also known as Oracle Restart, provides
                      system support for a single-instance Oracle Database. Oracle ASM is a volume manager and
                      a file system for Oracle database files that supports single-instance Oracle Database and
                      Oracle Real Application Clusters (Oracle RAC) configurations. Oracle Automatic Storage
                      Management also supports a general purpose file system for your application needs, including
                      Oracle Database binaries. Oracle Automatic Storage Management is Oracle's recommended
                      storage management solution. It provides an alternative to conventional volume managers and
                      file systems.


                                Note
                                •    If you want to use Oracle ASM or Oracle Restart, then you must install Oracle Grid
                                     Infrastructure for a standalone server before you install and create the database.
                                     Otherwise, you must manually register the database with Oracle Restart.
                                •    You can neither install Oracle Restart on an Oracle Grid Infrastructure cluster
                                     member node, nor add an Oracle Restart server to an Oracle Grid Infrastructure
                                     cluster member node. Oracle Restart supports single-instance databases on one
                                     server, while Oracle Grid Infrastructure for a Cluster supports single-instance or
                                     Oracle RAC databases on a cluster.



                      •     Configuring Storage for Oracle Automatic Storage Management
                            Identify storage requirements and Oracle ASM disk group options.
                      •     Configuring Storage Device Path Persistence Using Oracle ASMFD
                            Oracle ASM Filter Driver (Oracle ASMFD) maintains storage file path persistence and
                            helps to protect files from accidental overwrites.
                      •     Configuring Disk Devices for Oracle ASM on Oracle Solaris
                            Complete these tasks to configure disk devices for use with Oracle Automatic Storage
                            Management (Oracle ASM).
                      •     Creating DAS or SAN Disk Partitions for Oracle Automatic Storage Management
                            You can use direct-attached storage (DAS) and storage area network (SAN) disks with
                            Oracle ASM.
                      •     Creating Directories for Oracle Database Files
                            You can store Oracle Database and recovery files on a separate file system from the
                            configuration files.
                      •     Creating Files on a NAS Device for Use with Oracle Automatic Storage Management
                            If you have a certified NAS storage device, then you can create zero-padded files in an
                            NFS mounted directory and use those files as disk devices in an Oracle ASM disk group.




Database Installation Guide
E96434-12                                                                                                     April 30, 2026
Copyright © 2015, 2026, Oracle and/or its affiliates.                                                          Page 1 of 12
                                                                                                                       Chapter 9
                                                                     Configuring Storage for Oracle Automatic Storage Management




Configuring Storage for Oracle Automatic Storage Management
                      Identify storage requirements and Oracle ASM disk group options.


                                Note
                                Oracle ASM Filter Driver (ASMFD) is deprecated on both Linux and Oracle Solaris
                                beginning with Oracle Database 19c. It will be desupported in a future release.


                      •     Identifying Storage Requirements for Oracle Automatic Storage Management
                            To identify the storage requirements for using Oracle ASM, you must determine the
                            number of devices and the amount of free disk space that you require.
                      •     Oracle ASM Disk Space Requirements
                            Determine the total amount of Oracle Automatic Storage Management (Oracle ASM) disk
                            space that you require for the database files and recovery files.
                      •     ASM Disk Group Options for Installation
                            Plan how you want to configure Oracle ASM disk groups for deployment.
                      •     Using an Existing Oracle ASM Disk Group
                            Use Oracle Enterprise Manager Cloud Control or the Oracle ASM command line tool
                            (asmcmd) to identify existing disk groups, and to determine if sufficient space is available in
                            the disk group.
                      Related Topics
                      •     Oracle Automatic Storage Management Filter Driver (ASMFD) (Doc ID 2806979.1)
                      •     Oracle Automatic Storage Management Administrator's Guide


Identifying Storage Requirements for Oracle Automatic Storage
Management
                      To identify the storage requirements for using Oracle ASM, you must determine the number of
                      devices and the amount of free disk space that you require.
                      To complete this task, perform the following steps:
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




Database Installation Guide
E96434-12                                                                                                          April 30, 2026
Copyright © 2015, 2026, Oracle and/or its affiliates.                                                               Page 2 of 12
                                                                                                                        Chapter 9
                                                                      Configuring Storage for Oracle Automatic Storage Management


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
                            •    Extended redundancy
                                 Extended redundancy disk group has features similar to the flex redundancy disk
                                 group. Extended redundancy is available when you configure an Oracle Extended

Database Installation Guide
E96434-12                                                                                                           April 30, 2026
Copyright © 2015, 2026, Oracle and/or its affiliates.                                                                Page 3 of 12
                                                                                                                        Chapter 9
                                                                      Configuring Storage for Oracle Automatic Storage Management


                                 Cluster. Extended redundancy extends Oracle ASM data protection to cover failure of
                                 sites by placing enough copies of data in different failure groups of each site.
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
                            •    You can specify custom failure groups in the Create ASM Disk Group screen during
                                 an Oracle Grid Infrastructure installation.
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



Database Installation Guide
E96434-12                                                                                                           April 30, 2026
Copyright © 2015, 2026, Oracle and/or its affiliates.                                                                Page 4 of 12
                                                                                                                      Chapter 9
                                                                    Configuring Storage for Oracle Automatic Storage Management


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
                      •     Oracle ASM Disk Space Requirements
                            Determine the total amount of Oracle Automatic Storage Management (Oracle ASM) disk
                            space that you require for the database files and recovery files.
                      •     Oracle Automatic Storage Management Administrator's Guide


Oracle ASM Disk Space Requirements
                      Determine the total amount of Oracle Automatic Storage Management (Oracle ASM) disk
                      space that you require for the database files and recovery files.

                      Table 9-1 Oracle ASM Disk Number and Minimum Space Requirements for an Oracle
                      database (non-CDB)

                       Redundancy               Minimum Number Data Files           Recovery Files        Both File Types
                       Level                    of Disks
                       External                 1               2.5 GB              7.5 GB                10 GB
                       Normal or Flex with 2                    5.2 GB              15.6 GB               20.8 GB
                       two-way mirroring
                       High or Flex with   3                    7.6 GB              22.8 GB               30.4 GB
                       three-way mirroring


                      Table 9-2 Oracle ASM Disk Number and Minimum Space Requirements for a
                      multitenant container database (CDB) with one pluggable database (PDB)

                       Redundancy               Minimum Number Data Files           Recovery Files        Both File Types
                       Level                    of Disks
                       External                 1               4 GB                12 GB                 16 GB
                       Normal or Flex with 2                    8 GB                24 GB                 32 GB
                       two-way mirroring
                       High or Flex with   3                    12 GB               36 GB                 48 GB
                       three-way mirroring




Database Installation Guide
E96434-12                                                                                                         April 30, 2026
Copyright © 2015, 2026, Oracle and/or its affiliates.                                                              Page 5 of 12
                                                                                                                       Chapter 9
                                                                     Configuring Storage for Oracle Automatic Storage Management



                                 Note
                                 •   If an Oracle ASM instance is running on the system, then you can use an existing
                                     disk group to meet these storage requirements. If necessary, you can add disks to
                                     an existing disk group during the database installation.
                                 •   The disk devices must be owned by the user performing the grid installation.
                                     Check with your system administrator to determine if the disks used by Oracle
                                     ASM are mirrored at the storage level. If so, select External for the redundancy. If
                                     the disks are not mirrored at the storage level, then select Normal for the
                                     redundancy.
                                 •   Every Oracle ASM disk is divided into allocation units (AU). An allocation unit is
                                     the fundamental unit of allocation within a disk group. You can select the AU Size
                                     value from 1, 2, 4, 8, 16, 32 or 64 MB, depending on the specific disk group
                                     compatibility level. The default value is 4 MB for flex disk group and 1 MB for all
                                     other disk group types. On engineered systems, the default value is 4 MB.



ASM Disk Group Options for Installation
                      Plan how you want to configure Oracle ASM disk groups for deployment.
                      During Oracle Grid Infrastructure installation, you can create one Oracle ASM disk group. After
                      the Oracle Grid Infrastructure installation, you can create additional disk groups using Oracle
                      Automatic Storage Management Configuration Assistant (Oracle ASMCA), SQL*Plus, or
                      Automatic Storage Management Command-Line Utility (ASMCMD).
                      Related Topics
                      •     Oracle Automatic Storage Management Administrator's Guide


Using an Existing Oracle ASM Disk Group
                      Use Oracle Enterprise Manager Cloud Control or the Oracle ASM command line tool (asmcmd)
                      to identify existing disk groups, and to determine if sufficient space is available in the disk
                      group.
                      1.    Connect to the Oracle ASM instance and start the instance if necessary:

                            $ $ORACLE_HOME/bin/asmcmd
                            ASMCMD> startup

                      2.    Enter one of the following commands to view the existing disk groups, their redundancy
                            level, and the amount of free disk space in each one:

                            ASMCMD> lsdg


                            or

                            $ORACLE_HOME/bin/asmcmd -p lsdg


                            The lsdg command lists information about mounted disk groups only.




Database Installation Guide
E96434-12                                                                                                          April 30, 2026
Copyright © 2015, 2026, Oracle and/or its affiliates.                                                               Page 6 of 12
                                                                                                                      Chapter 9
                                                                 Configuring Storage Device Path Persistence Using Oracle ASMFD


                      3.    From the output, identify a disk group with the appropriate redundancy level and note the
                            free space that it contains.
                      4.    If necessary, install or identify the additional disk devices required to meet the storage
                            requirements for your installation.


                                Note
                                If you are adding devices to an existing disk group, then Oracle recommends that you
                                use devices that have the same size and performance characteristics as the existing
                                devices in that disk group.



Configuring Storage Device Path Persistence Using Oracle
ASMFD
                      Oracle ASM Filter Driver (Oracle ASMFD) maintains storage file path persistence and helps to
                      protect files from accidental overwrites.


                                Note
                                Oracle ASM Filter Driver (ASMFD) is deprecated on both Linux and Oracle Solaris
                                beginning with Oracle Database 19c. It will be desupported in a future release.


                      •     About Oracle ASM with Oracle ASM Filter Driver
                            During Oracle Grid Infrastructure installation, you can choose to install and configure
                            Oracle Automatic Storage Management Filter Driver (Oracle ASMFD). Oracle ASMFD
                            helps prevent corruption in Oracle ASM disks and files within the disk group.
                      •     Guidelines for Installing Oracle ASMFD on Oracle Solaris
                            Review these best practices for Oracle Automatic Storage Management Filter Driver
                            (Oracle ASMFD).
                      Related Topics
                      •     Oracle Automatic Storage Management Filter Driver (ASMFD) (Doc ID 2806979.1)


About Oracle ASM with Oracle ASM Filter Driver
                      During Oracle Grid Infrastructure installation, you can choose to install and configure Oracle
                      Automatic Storage Management Filter Driver (Oracle ASMFD). Oracle ASMFD helps prevent
                      corruption in Oracle ASM disks and files within the disk group.
                      Oracle ASM Filter Driver (Oracle ASMFD) rejects write I/O requests that are not issued by
                      Oracle software. This write filter helps to prevent users with administrative privileges from
                      inadvertently overwriting Oracle ASM disks, thus preventing corruption in Oracle ASM disks
                      and files within the disk group. For disk partitions, the area protected is the area on the disk
                      managed by Oracle ASMFD, assuming the partition table is left untouched by the user.
                      Oracle ASMFD simplifies the configuration and management of disk devices by eliminating the
                      need to rebind disk devices used with Oracle ASM each time the system is restarted.




Database Installation Guide
E96434-12                                                                                                         April 30, 2026
Copyright © 2015, 2026, Oracle and/or its affiliates.                                                              Page 7 of 12
                                                                                                                          Chapter 9
                                                                          Configuring Disk Devices for Oracle ASM on Oracle Solaris


                      If Oracle ASMLIB exists on your Linux system, then deinstall Oracle ASMLIB before installing
                      Oracle Grid Infrastructure, so that you can choose to install and configure Oracle ASMFD
                      during an Oracle Grid Infrastructure installation.



                                 Caution
                                 When you configure Oracle ASM, including Oracle ASMFD, do not modify or erase the
                                 contents of the Oracle ASM disks, or modify any files, including the configuration files.


                      Related Topics
                      •     Oracle Automatic Storage Management Administrator's Guide


Guidelines for Installing Oracle ASMFD on Oracle Solaris
                      Review these best practices for Oracle Automatic Storage Management Filter Driver (Oracle
                      ASMFD).
                      On Oracle Solaris systems, consider the following guidelines before you install Oracle ASMFD:
                      •     Ensure that you label the disk as either SMI or Extensible Firmware Interface (EFI).
                      •     Ensure that the disk has at least one slice that represents the entire disk. For example,
                            Slice 2.
                      •     Ensure that the slices on the disk do not overlap.


Configuring Disk Devices for Oracle ASM on Oracle Solaris
                      Complete these tasks to configure disk devices for use with Oracle Automatic Storage
                      Management (Oracle ASM).
                      1.    If necessary, install the disks that you intend to use for the disk group and restart the
                            system.
                      2.    Identify devices that are part of a logical volume manager (LVM) disk group:
                            This command displays information about VERITAS Volume Manager disks. If you use a
                            different LVM, then refer to the appropriate documentation for information about
                            determining which disk devices it is managing.

                            # vxdiskconfig
                            # /usr/sbin/vxdisk list


                            If this command displays disk group information associated with a disk device, then the
                            disk is already part of an LVM disk group. Do not use disks that are part of an LVM disk
                            group.
                      3.    Create or identify the disk slices (partitions) that you want to include in the Oracle
                            Automatic Storage Management disk group:
                            a.   List the disks attached to the system:

                                 # /usr/sbin/format




Database Installation Guide
E96434-12                                                                                                            April 30, 2026
Copyright © 2015, 2026, Oracle and/or its affiliates.                                                                 Page 8 of 12
                                                                                                                          Chapter 9
                                                                          Configuring Disk Devices for Oracle ASM on Oracle Solaris


                                 The output from this command is similar to the following:

                                 AVAILABLE DISK SELECTIONS:
                                 AVAILABLE DISK SELECTIONS:
                                        0. c0t0d0 < ST34321A cyl 8892 alt 2 hd 15 sec 63 >
                                           /pci@1f,0/pci@1,1/ide@3/dad@0,0
                                        1. c1t5d0 < SUN9.0G cyl 4924 alt 2 hd 27 sec 133 >
                                           /pci@1f,0/pci@1/scsi@1/sd@5,0


                                 This command displays information about each disk attached to the system, including
                                 the device name. For example, cxtydz.
                            b.   Enter the number corresponding to the disk that you want to use.
                            c.   Use the fdisk command to create an Oracle Solaris partition on the disk if one does
                                 not already exist.
                                 Oracle Solaris fdisk partitions must start at cylinder 1, not cylinder 0. If you create an
                                 fdisk partition, then you must label the disk before continuing.
                            d.   Enter the partition command, followed by the print command to display the
                                 partition table for the disk that you want to use.
                            e.   If necessary, create a single whole-disk slice, starting at cylinder 1.


                                          Note
                                          To prevent Automatic Storage Management from overwriting the partition
                                          table, you cannot use slices that start at cylinder 0 (for example, slice 2).

                            f.   Make a note of the number of the slice that you want to use.
                            g.   If you modified a partition table or created a new one, then enter the label command
                                 to write the partition table and label to the disk.
                            h.   Enter q to return to the format menu.
                            i.   If you have finished creating slices, then enter q to quit the format utility. Else, enter
                                 the disk command to select a new disk and repeat steps b to g to create or identify the
                                 slices on that disks.
                      4.    If you plan to use existing slices, then verify that they are not mounted as file systems:

                            # df -h /tmp


                            This command displays information about the slices on disk devices that are mounted as
                            file systems. The device name for a slice includes the disk device name followed by the
                            slice number, for example cxtydzsn, where sn is the slice number.
                      5.    On every node, change the owner, group, and permissions on the file for each disk slice
                            that you want to add to a disk group:

                            # chown grid:asmadmin /dev/rdsk/cxtydzs6
                            # chmod 660 /dev/rdsk/cxtydzs6


                            In this example, the device name specifies slice 6.




Database Installation Guide
E96434-12                                                                                                            April 30, 2026
Copyright © 2015, 2026, Oracle and/or its affiliates.                                                                 Page 9 of 12
                                                                                                                          Chapter 9
                                                        Creating DAS or SAN Disk Partitions for Oracle Automatic Storage Management



                                     Note
                                     If you are using a multi-pathing disk driver with Oracle Automatic Storage
                                     Management, then ensure that you set the permissions only on the correct logical
                                     device name for the disk.



Creating DAS or SAN Disk Partitions for Oracle Automatic
Storage Management
                      You can use direct-attached storage (DAS) and storage area network (SAN) disks with Oracle
                      ASM.
                      To use a DAS or SAN disk in Oracle ASM, Oracle recommends that the disk have a partition
                      table. Oracle recommends creating exactly one partition for each disk.


Creating Directories for Oracle Database Files
                      You can store Oracle Database and recovery files on a separate file system from the
                      configuration files.
                      Perform this procedure to place the Oracle Database or recovery files on a separate file
                      system from the Oracle base directory:
                      1.    Use the following command to determine the free disk space on each mounted file system:

                            # df -h

                      2.    Identify the file systems to use, from the display:


                            Option                                              Description
                            Database Files                                      Select one of the following:
                                                                                •   A single file system with at least 1.5 GB of
                                                                                    free disk space
                                                                                •   Two or more file systems with at least 3.5
                                                                                    GB of free disk space in total
                            Recovery Files                                      Choose a file system with at least 2 GB of free
                                                                                disk space

                            If you are using the same file system for multiple file types, then add the disk space
                            requirements for each type to determine the total disk space requirement.
                      3.    Note the names of the mount point directories for the file systems that you identified.
                      4.    If the user performing installation has permissions to create directories on the disks where
                            you plan to install Oracle Database, then Oracle DBCA creates the Oracle Database file
                            directory, and the Recovery file directory. If the user performing installation does not have
                            write access, then you must create these directories manually.
                            For example, given the user oracle and Oracle Inventory Group oinstall, and using the
                            paths /u03/oradata/wrk_area for Oracle Database files, and /u01/oradata/
                            rcv_area for the recovery area, these commands create the recommended
                            subdirectories in each of the mount point directories and set the appropriate owner, group,
                            and permissions on them:


Database Installation Guide
E96434-12                                                                                                             April 30, 2026
Copyright © 2015, 2026, Oracle and/or its affiliates.                                                                 Page 10 of 12
                                                                                                                              Chapter 9
                                                        Creating Files on a NAS Device for Use with Oracle Automatic Storage Management


                            •    Database file directory:

                                 # mkdir -p /u01/oradata/
                                 # chown oracle:oinstall /u01/oradata/
                                 # chmod 775 /u01/oradata


                                 The default location for the database file directory is $ORACLE_BASE/oradata.
                            •    Recovery file directory (fast recovery area):

                                 # mkdir -p /u01/oradata/rcv_area
                                 # chown oracle:oinstall /u01/oradata/rcv_area
                                 # chmod 775 /u01/oradata/rcv_area


                                 The default fast recovery area is $ORACLE_BASE/fast_recovery_area.
                                 Oracle recommends that you keep the fast recovery area on a separate physical disk
                                 than that of the database file directory. This method enables you to use the fast
                                 recovery area to retrieve data if the disk containing oradata is unusable for any reason.


Creating Files on a NAS Device for Use with Oracle Automatic
Storage Management
                      If you have a certified NAS storage device, then you can create zero-padded files in an NFS
                      mounted directory and use those files as disk devices in an Oracle ASM disk group.
                      Ensure that you specify the ASM discovery path for Oracle ASM disks.
                      During installation of Oracle Grid Infrastructure, Oracle Universal Installer (OUI) can create
                      files in the NFS mounted directory you specify. The following procedure explains how to
                      manually create files in an NFS mounted directory to use as disk devices in an Oracle ASM
                      disk group:
                      1.    If necessary, create an exported directory for the disk group files on the NAS device.
                      2.    Switch user to root.
                      3.    Create a mount point directory on the local system.
                            For example:

                            # mkdir -p /mnt/oracleasm

                      4.    To ensure that the NFS file system is mounted when the system restarts, add an entry for
                            the file system in the mount file /etc/fstab.
                      5.    Enter a command similar to the following to mount the NFS on the local system:

                            # mount /mnt/oracleasm

                      6.    Choose a name for the disk group to create, and create a directory for the files on the NFS
                            file system, using the disk group name as the directory name.
                            For example, if you want to set up a disk group for a sales database:

                            # mkdir /mnt/oracleasm/sales1



Database Installation Guide
E96434-12                                                                                                                 April 30, 2026
Copyright © 2015, 2026, Oracle and/or its affiliates.                                                                     Page 11 of 12
                                                                                                                              Chapter 9
                                                        Creating Files on a NAS Device for Use with Oracle Automatic Storage Management


                      7.    Use commands similar to the following to create the required number of zero-padded files
                            in this directory:

                            # dd if=/dev/zero
                            of=/mnt/oracleasm/sales1/disk1 bs=1024k
                            count=1000


                            This example creates 1 GB files on the NFS file system. You must create one, two, or three
                            files respectively to create an external, normal, or high redundancy disk group.


                                     Note
                                     Creating multiple zero-padded files on the same NAS device does not guard
                                     against NAS failure. Instead, create one file for each NAS device and mirror them
                                     using the Oracle ASM technology.

                      8.    Enter commands similar to the following to change the owner, group, and permissions on
                            the directory and files that you created:

                            # chown -R grid:asmadmin /mnt/oracleasm
                            # chmod -R 660 /mnt/oracleasm


                            In this example, the installation owner is grid and the OSASM group is asmadmin.
                      9.    During Oracle Database installations, edit the Oracle ASM disk discovery string to specify
                            a regular expression that matches the file names you created.
                            For example:

                            /mnt/oracleasm/sales1/

                      Related Topics
                      •     My Oracle Support Note 359515.1




Database Installation Guide
E96434-12                                                                                                                 April 30, 2026
Copyright © 2015, 2026, Oracle and/or its affiliates.                                                                     Page 12 of 12
10
Installing and Configuring Oracle Grid
Infrastructure for a Standalone Server
                      Oracle Grid Infrastructure for a standalone server includes Oracle Restart and Oracle
                      Automatic Storage Management.
                      If you install Oracle Grid Infrastructure for a standalone server and then create your database,
                      then the database is automatically added to the Oracle Restart configuration. Oracle Restart
                      automatically restarts the database when required.
                      If you install Oracle Grid Infrastructure for a standalone server on a host computer on which a
                      database already exists, then you must manually add the database, the listener, the Oracle
                      ASM instance, and other components to the Oracle Restart configuration before you are able
                      to configure automatic database restarts.


                                Note
                                Oracle Grid Infrastructure for a standalone server can support multiple single-instance
                                databases on a single host computer.



                      •     About Image-Based Oracle Grid Infrastructure Installation
                            Installation and configuration of Oracle Grid Infrastructure software is simplified with
                            image-based installation.
                      •     Setup Wizard Installation Options for Creating Images
                            Before you start the setup wizards for your Oracle Database or Oracle Grid Infrastructure
                            installation, decide if you want to use any of the available image-creation options.
                      •     Installing Oracle Grid Infrastructure for a Standalone Server
                            Complete these steps to install Oracle Grid Infrastructure for a standalone server and then
                            create a database that is managed by Oracle Restart.
                      •     Installing Oracle Grid Infrastructure for a Standalone Server for an Existing Database
                            Follow the high-level instructions in this section to install Oracle Grid Infrastructure for a
                            standalone server and configure it for an existing Oracle Database.
                      •     Installing Oracle Grid Infrastructure for a Standalone Server Using a Software-Only
                            Installation
                            A software-only installation only installs the Oracle Grid Infrastructure for a standalone
                            server binaries at the specified location. You must complete a few manual configuration
                            steps to enable Oracle Restart after you install the software.
                      •     Testing the Oracle Automatic Storage Management Installation
                            After installing Oracle Grid Infrastructure for a single instance, use the ASMCMD
                            command-line utility to test the Oracle ASM installation.
                      •     Relinking Oracle Restart and Oracle ASM Binaries
                            Relink the Oracle Restart and Oracle ASM binaries every time you apply an operating
                            system patch or after an operating system upgrade.




Database Installation Guide
E96434-12                                                                                                         April 30, 2026
Copyright © 2015, 2026, Oracle and/or its affiliates.                                                              Page 1 of 13
                                                                                                                        Chapter 10
                                                                         About Image-Based Oracle Grid Infrastructure Installation


                      •     Configuring Oracle ASM Disk Groups Manually using Oracle ASMCA
                            After installing Oracle Grid Infrastructure for a standalone server, you can also use Oracle
                            ASMCA to create and configure disk groups, Oracle ADVM, and Oracle ACFS.
                      •     Enabling Oracle ACFS on Oracle Restart Configurations
                            You must enable root access to use Oracle ACFS.
                      •     Applying Patches During an Oracle Grid Infrastructure Installation or Upgrade
                            Starting with Oracle Grid Infrastructure 18c, you can download and apply Release Updates
                            (RUs) and one-off patches during an Oracle Grid Infrastructure installation or upgrade.
                      •     Patching and Switching Oracle Grid Infrastructure Homes
                            Perform an out-of-place Oracle Restart patching by switching from the current Oracle Grid
                            Infrastructure home to a patched Oracle Grid Infrastructure home.


About Image-Based Oracle Grid Infrastructure Installation
                      Installation and configuration of Oracle Grid Infrastructure software is simplified with image-
                      based installation.
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
                      customized images, after you patch the base-release software with the necessary Release
                      Updates (RUs) or Release Update Revisions (RURs).


                                Note
                                You must extract the image software into the directory where you want your Grid home
                                to be located, and then run the ORACLE_HOME\gridSetup.sh script to start the Oracle
                                Grid Infrastructure Setup Wizard. Ensure that the Grid home directory path you create
                                is in compliance with the Oracle Optimal Flexible Architecture recommendations.



Setup Wizard Installation Options for Creating Images
                      Before you start the setup wizards for your Oracle Database or Oracle Grid Infrastructure
                      installation, decide if you want to use any of the available image-creation options.
                      In image-based installations, you can start your Oracle Database installation or Oracle Grid
                      Infrastructure installations by running the setup wizards runInstaller and gridSetup.sh
                      respectively. Both these wizards come with the following image-creation options.



Database Installation Guide
E96434-12                                                                                                           April 30, 2026
Copyright © 2015, 2026, Oracle and/or its affiliates.                                                                Page 2 of 13
                                                                                                                            Chapter 10
                                                                          Installing Oracle Grid Infrastructure for a Standalone Server



                      Table 10-1        Image-Creation Options for Setup Wizard

                       Option                           Description
                       -createGoldImage                 Creates a gold image from the current Oracle home.
                       -destinationLocation             Specify the complete path, or location, where the gold image will be
                                                        created.
                       -exclFiles                       Specify the complete paths to the files to be excluded from the newly
                                                        created gold image.
                       —help                            Displays help for all the available options.

                      For example:

                      cd $ORACLE_HOME
                      ./runInstaller -createGoldImage -destinationLocation /tmp/my_db_images -
                      exclFiles /u01/app/oracle/product/19.0.0/dbhome_1/relnotes


                      cd Grid_home
                      ./gridSetup.sh -createGoldImage -destinationLocation /tmp/my_grid_images -
                      exclFiles /u01/app/oracle/product/19.0.0/dbhome_1/relnotes


                      Where:
                      /tmp/my_db_images is a temporary file location where the image zip file is created.

                      /tmp/my_grid_images is a temporary file location where the image zip file is created.

                      /u01/app/oracle/product/19.0.0/dbhome_1/relnotes is the file to be excluded
                      from the newly created gold image.
                      Refer to runInstaller -createGoldImage and gridSetup.sh -createGoldImage for more examples.


Installing Oracle Grid Infrastructure for a Standalone Server
                      Complete these steps to install Oracle Grid Infrastructure for a standalone server and then
                      create a database that is managed by Oracle Restart.


                                Note
                                Oracle ASM Filter Driver (ASMFD) is deprecated on both Linux and Oracle Solaris
                                beginning with Oracle Database 19c. It will be desupported in a future release.


                      Install Oracle Grid Infrastructure for a standalone server, which installs Oracle Restart and
                      Oracle ASM, and creates one disk group.
                      You should have your network information, storage information, and operating system users
                      and groups available to you before you start the installation. You should also be prepared to
                      run root scripts or provide information to automate root scripts.
                      1.    Log in as the Oracle Restart software owner user (oracle).




Database Installation Guide
E96434-12                                                                                                                April 30, 2026
Copyright © 2015, 2026, Oracle and/or its affiliates.                                                                     Page 3 of 13
                                                                                                                          Chapter 10
                                                                        Installing Oracle Grid Infrastructure for a Standalone Server


                      2.    If this is the first time you are installing Oracle software, then create the Oracle base and
                            the Oracle inventory directories as per the Oracle Optimal Flexible Architecture (OFA)
                            recommendations. Specify the correct owner, group, and permissions for these directories.

                            # mkdir -p /u01/app/oracle
                            # mkdir -p /u01/app/oraInventory
                            # chown -R oracle:oinstall /u01/app/oracle
                            # chown -R oracle:oinstall /u01/app/oraInventory
                            # chmod -R 775 /u01/app

                      3.    Download the Oracle Grid Infrastructure for a standalone server installation image files,
                            create the grid home directory, and extract the image files in this grid home directory.
                            For example:

                            $ mkdir -p /u01/app/oracle/product/19.0.0/grid
                            $ cd /u01/app/oracle/product/19.0.0/grid
                            $ unzip -q /tmp/grid_home.zip



                                     Note
                                     •    Ensure that the Grid home directory path you create is in compliance with the
                                          Oracle Optimal Flexible Architecture recommendations. Also, unzip the
                                          installation image files only in this Grid home directory that you created.
                                     •    Oracle home or Oracle base cannot be symlinks, nor can any of their parent
                                          directories, all the way to up to the root directory.


                      4.    Log in as the Oracle Restart software owner user and run gridSetup.sh to start the
                            Oracle Grid Infrastructure setup wizard:

                            $ Grid_home/gridSetup.sh


                            Where Grid_home is the Oracle Grid Infrastructure home directory.


                                     Note
                                     You can use the gridSetup.sh command with the -applyRU and -
                                     applyOneOffs options to install Release Updates (RUs) and one-off patches
                                     during an Oracle Grid Infrastructure installation or upgrade.

                      5.    In the Select Configuration Option screen, select the Configure Oracle Grid
                            Infrastructure for a Standalone Server (Oracle Restart) option to install and configure
                            Oracle Restart and Oracle ASM. Click Next.
                      6.    During installation, disk paths mounted on Oracle ASM with the string ORCL:* are listed as
                            default database storage candidate disks.
                      7.    Configure Oracle ASM as needed with additional disk groups.
                            •    The default Disk Group Name is DATA. You can enter a new name for the disk group,
                                 or use the default name.
                            •    Any additional disk devices that you create must be owned by the user performing the
                                 grid installation.


Database Installation Guide
E96434-12                                                                                                              April 30, 2026
Copyright © 2015, 2026, Oracle and/or its affiliates.                                                                   Page 4 of 13
                                                                                                                                   Chapter 10
                                                        Installing Oracle Grid Infrastructure for a Standalone Server for an Existing Database


                      8.    Respond to the configuration prompts as needed to configure Oracle Grid Infrastructure.
                            Click Help for information.
                      9.    Provide information to automate root scripts, or run scripts as root when prompted by OUI.
                            If you configure automation for running root scripts, and a root script fails, then you can fix
                            the problem manually, and click Retry to run the root script again.
                      10. Start the Oracle Database installation, and select Oracle ASM disk groups for Oracle
                            Database files storage. For assistance during installation, click Help on the Oracle
                            Universal Installer page where you need more information.
                      Related Topics
                      •     Oracle Automatic Storage Management Administrator's Guide


Installing Oracle Grid Infrastructure for a Standalone Server for
an Existing Database
                      Follow the high-level instructions in this section to install Oracle Grid Infrastructure for a
                      standalone server and configure it for an existing Oracle Database.
                      Oracle Restart can manage resources from the same release and releases up to one version
                      lower than Oracle Restart. For instance, you can install Oracle Grid Infrastructure for a
                      standalone server 19c (Oracle Restart) to provide services for Oracle Database 19c and
                      Oracle Database 18c. Earlier Oracle Database releases can coexist on the same server
                      without being managed by Oracle Restart.
                      To install Oracle Grid Infrastructure for a standalone server for a database that is already
                      installed:
                      1.    Log in as the Oracle Database software owner user.
                      2.    Set the ORACLE_HOME and ORACLE_SID environment variables.
                            Bourne, Bash or Korn shell:

                            $ ORACLE_SID=orcl
                            $ export ORACLE_SID
                            $ ORACLE_HOME=/u01/app/oracle/product/19.0.0/dbhome_1
                            $ export ORACLE_HOME


                            C shell:

                            % setenv ORACLE_SID orcl
                            % setenv ORACLE_HOME /u01/app/oracle/product/19.0.0/dbhome_1

                      3.    Go to the Oracle home and stop any existing database listeners.

                            $ $ORACLE_HOME/lsnrctl stop listener_name



                                     Note
                                     If this command throws an error, reload the listener using lsnrctl reload
                                     LISTENER




Database Installation Guide
E96434-12                                                                                                                       April 30, 2026
Copyright © 2015, 2026, Oracle and/or its affiliates.                                                                            Page 5 of 13
                                                                                                                                  Chapter 10
                                             Installing Oracle Grid Infrastructure for a Standalone Server Using a Software-Only Installation


                      4.    On the same host computer as the database, install Oracle Grid Infrastructure for a
                            standalone server, and select Configure Oracle Grid Infrastructure for a Standalone
                            Server (Oracle Restart) as the installation option. See, “Installing Oracle Grid
                            Infrastructure for a Standalone Server with a New Database Installation” in Oracle
                            Database Installation Guide.
                            The Oracle Grid Infrastructure for a standalone server components are installed in an
                            Oracle Grid Infrastructure Oracle home (Grid home), which is in a different location from
                            existing Oracle Database homes.
                      5.    If you have an existing Oracle Database, then register it for High Availability with Oracle
                            Restart using the srvctl command:

                            $ cd $ORACLE_HOME/bin
                            $ srvctl add database -db dbname -o oracle_home_path

                      Related Topics
                      •     Installing Oracle Grid Infrastructure for a Standalone Server with a New Database
                            Installation
                      •     Oracle Database Administrator’s Guide


Installing Oracle Grid Infrastructure for a Standalone Server
Using a Software-Only Installation
                      A software-only installation only installs the Oracle Grid Infrastructure for a standalone server
                      binaries at the specified location. You must complete a few manual configuration steps to
                      enable Oracle Restart after you install the software.
                      •     About Oracle Grid Infrastructure Software-Only Installations
                            Manually installing and configuring the software binaries for Oracle Grid Infrastructure.
                      •     Installing Software Binaries for Oracle Grid Infrastructure for a Standalone Server
                            Use this procedure to do a software-only installation of Oracle Grid Infrastructure for a
                            standalone server.
                      •     Configuring Software Binaries for Oracle Grid Infrastructure for a Standalone Server
                            Use these steps to configure and activate a software-only Oracle Grid Infrastructure for a
                            standalone server installation for Oracle Restart.


About Oracle Grid Infrastructure Software-Only Installations
                      Manually installing and configuring the software binaries for Oracle Grid Infrastructure.
                      Oracle recommends that only advanced users perform software-only installations, because this
                      installation method provides no validation of the installation, and this installation option requires
                      manual postinstallation steps to enable the Oracle Grid Infrastructure for a standalone server
                      software.
                      Performing a software-only installation requires the following steps:
                      1.    Installing the software binaries.
                      2.    Configuring the software binaries.




Database Installation Guide
E96434-12                                                                                                                      April 30, 2026
Copyright © 2015, 2026, Oracle and/or its affiliates.                                                                           Page 6 of 13
                                                                                                                                  Chapter 10
                                             Installing Oracle Grid Infrastructure for a Standalone Server Using a Software-Only Installation



Installing Software Binaries for Oracle Grid Infrastructure for a Standalone
Server
                      Use this procedure to do a software-only installation of Oracle Grid Infrastructure for a
                      standalone server.
                      1.    Log in as the Oracle Restart software owner user (oracle).
                      2.    Download the Oracle Grid Infrastructure for a standalone server installation image files,
                            create the Grid home directory, and extract the image files in this Grid home directory.
                            For example:

                            $ mkdir -p /u01/app/oracle/product/19.0.0/grid
                            $ chown oracle:oinstall /u01/app/oracle/product/19.0.0/grid
                            $ cd /u01/app/oracle/product/19.0.0/grid
                            $ unzip -q /tmp/grid_home.zip



                                     Note
                                     Ensure that the Grid home directory path you create is in compliance with the
                                     Oracle Optimal Flexible Architecture recommendations. Also, unzip the installation
                                     image files only in this Grid home directory that you created.

                      3.    Ensure that you complete all the storage and server preinstallation requirements. Verify
                            that your server meets the installation requirements using the following command:

                            $ cd /u01/app/oracle/product/19.0.0/grid
                            $ runcluvfy.sh stage -pre hacfg

                      4.    Run gridSetup.sh to start the Oracle Grid Infrastructure setup wizard:

                            $ Grid_home/gridSetup.sh


                            Where, Grid_home is the Oracle Grid Infrastructure home directory.


                                     Note
                                     You must install Oracle Grid Infrastructure for a standalone server from the Oracle
                                     Grid Infrastructure media.

                      5.    In the Select Configuration Option screen, select the Set Up Software Only option to
                            perform a software-only installation of Oracle Grid Infrastructure for a standalone server.
                            Click Next.
                      6.    Respond to the prompts as needed to set up Oracle Grid Infrastructure. Click Help for
                            information.
                      7.    The Oracle Grid Infrastructure setup wizard prompts you to run the root.sh script and, if
                            required, the orainstRoot.sh script.
                      8.    The root.sh script output provides information about how to proceed, depending on the
                            configuration you plan to complete in this installation. Note this information.


Database Installation Guide
E96434-12                                                                                                                      April 30, 2026
Copyright © 2015, 2026, Oracle and/or its affiliates.                                                                           Page 7 of 13
                                                                                                                                  Chapter 10
                                             Installing Oracle Grid Infrastructure for a Standalone Server Using a Software-Only Installation



Configuring Software Binaries for Oracle Grid Infrastructure for a
Standalone Server
                      Use these steps to configure and activate a software-only Oracle Grid Infrastructure for a
                      standalone server installation for Oracle Restart.

                      Configuring With Oracle Automatic Storage Management
                      1.    Install the software binaries. See, “Installing Software Binaries for Oracle Grid
                            Infrastructure for a Standalone Server” in Oracle Database Installation Guide.
                      2.    Run gridSetup.sh to start the Oracle Grid Infrastructure setup wizard.
                            See, “Installing Oracle Grid Infrastructure for a Standalone Server with a New Database
                            Installation” in Oracle Database Installation Guide.

                      Configuring Without Oracle Automatic Storage Management
                      1.    Log in as root and run the roothas.sh script located in the Grid_home path, using the
                            following syntax:

                            # cd Grid_home/crs/install
                            # ./roothas.sh


                            Where, Grid_home is the Oracle Grid Infrastructure home directory.
                            For example:

                            # cd /u01/app/oracle/product/19.0.0/grid/crs/install
                            # ./roothas.sh

                      2.    Change directory to the path Grid_home/oui/bin.
                      3.    Log in as the Oracle Restart software owner user and use the following command syntax,
                            where Grid_home is the path of the Oracle Grid Infrastructure for a standalone server
                            home.

                            $ ./runInstaller -updateNodeList ORACLE_HOME=Grid_home -defaultHomeName
                            CLUSTER_NODES= CRS=TRUE


                            For example:

                            $ ./runInstaller -updateNodeList ORACLE_HOME=/u01/app/oracle/product/
                            19.0.0/grid
                            -defaultHomeName CLUSTER_NODES= CRS=TRUE

                      4.    Use the SRVCTL utility along with Oracle Network Configuration Assistant to add the
                            listener to the Oracle Restart configuration.


                                Note
                                This procedure does not work for Oracle Restart upgrades from previous releases.




Database Installation Guide
E96434-12                                                                                                                      April 30, 2026
Copyright © 2015, 2026, Oracle and/or its affiliates.                                                                           Page 8 of 13
                                                                                                                       Chapter 10
                                                                     Testing the Oracle Automatic Storage Management Installation


                      Related Topics
                      •     Installing Software Binaries for Oracle Grid Infrastructure for a Standalone Server
                            Use this procedure to do a software-only installation of Oracle Grid Infrastructure for a
                            standalone server.
                      •     Installing Oracle Grid Infrastructure for a Standalone Server
                            Complete these steps to install Oracle Grid Infrastructure for a standalone server and then
                            create a database that is managed by Oracle Restart.


Testing the Oracle Automatic Storage Management Installation
                      After installing Oracle Grid Infrastructure for a single instance, use the ASMCMD command-
                      line utility to test the Oracle ASM installation.
                      1.    Open a shell window, and temporarily set the ORACLE_SID and ORACLE_HOME
                            environment variables to specify the appropriate values for the Oracle ASM instance to
                            use.
                            For example, if the Oracle ASM SID is named +ASM and the Oracle home is located in the
                            grid subdirectory of the ORACLE_BASE directory, then enter the following commands to
                            create the required settings:
                            Bourne, Bash or Korn shell:

                            $ ORACLE_SID=+ASM
                            $ export ORACLE_SID
                            $ ORACLE_HOME=/u01/app/oracle/product/19.0.0/grid
                            $ export ORACLE_HOME


                            C shell:

                            % setenv ORACLE_SID +ASM
                            % setenv ORACLE_HOME /u01/app/oracle/product/19.0.0/grid

                      2.    Use ASMCMD to list the disk groups for the Oracle ASM instance:

                            $ORACLE_HOME/bin/asmcmd lsdg


                            If the Oracle ASM instance is running, then ASMCMD connects by default as the SYS user
                            with SYSASM privileges, and is available.
                      3.    If the Oracle ASM instance is not running, then start the Oracle ASM instance using the
                            following command:

                            $ORACLE_HOME/bin/srvctl start asm

                      Related Topics
                      •     Oracle Automatic Storage Management Administrator's Guide


Relinking Oracle Restart and Oracle ASM Binaries
                      Relink the Oracle Restart and Oracle ASM binaries every time you apply an operating system
                      patch or after an operating system upgrade.



Database Installation Guide
E96434-12                                                                                                          April 30, 2026
Copyright © 2015, 2026, Oracle and/or its affiliates.                                                               Page 9 of 13
                                                                                                                   Chapter 10
                                                               Configuring Oracle ASM Disk Groups Manually using Oracle ASMCA



                                Caution
                                Before relinking executables, you must shut down all executables that run in the
                                Oracle home directory that you are relinking. In addition, shut down applications linked
                                with Oracle shared libraries.


                      1.    Log in as root and unlock the grid home:

                            # cd Grid_home/crs/install
                            # roothas.sh -unlock

                      2.    Log in as the grid user and relink the binaries:

                            $ export ORACLE_HOME=Grid_home
                            $ Grid_home/bin/relink

                      3.    Log in as root again and perform the following steps:

                            # cd Grid_home/rdbms/install/
                            # ./rootadd_rdbms.sh
                            # cd Grid_home/crs/install
                            # roothas.sh -lock


Configuring Oracle ASM Disk Groups Manually using Oracle
ASMCA
                      After installing Oracle Grid Infrastructure for a standalone server, you can also use Oracle
                      ASMCA to create and configure disk groups, Oracle ADVM, and Oracle ACFS.
                      During Oracle Grid Infrastructure for a standalone server installation, Oracle Automatic Storage
                      Management Configuration Assistant (Oracle ASMCA) utility creates a new Oracle Automatic
                      Storage Management instance if there is no Oracle ASM instance currently configured on the
                      computer. After installation, you can create and configure additional disk groups, and you can
                      configure Oracle ADVM and Oracle ACFS.
                      To create disk groups or manually configure Oracle ASM disks, start Oracle ASMCA, where
                      Grid_home is the path to the Oracle Grid Infrastructure home:

                      $ cd Grid_home/bin
                      $ ./asmca


                      Related Topics
                      •     Oracle Automatic Storage Management Administrator's Guide


Enabling Oracle ACFS on Oracle Restart Configurations
                      You must enable root access to use Oracle ACFS.
                      To enable root access, log in as root, navigate to the path Grid_home/crs/install, and run
                      the script roothas.sh —lockacfs.
                      Where, Grid_home is the Oracle Grid Infrastructure home directory path.


Database Installation Guide
E96434-12                                                                                                       April 30, 2026
Copyright © 2015, 2026, Oracle and/or its affiliates.                                                           Page 10 of 13
                                                                                                                           Chapter 10
                                                         Applying Patches During an Oracle Grid Infrastructure Installation or Upgrade


                      For example:

                      # cd /u01/app/oracle/product/19.0.0/grid/crs/install
                      # roothas.sh -lockacfs



                                Note
                                Starting with Oracle Database 12c Release 1 (12.1.0.2), the roothas.sh script
                                replaces the roothas.pl script in the Oracle Grid Infrastructure home.



Applying Patches During an Oracle Grid Infrastructure
Installation or Upgrade
                      Starting with Oracle Grid Infrastructure 18c, you can download and apply Release Updates
                      (RUs) and one-off patches during an Oracle Grid Infrastructure installation or upgrade.
                      1.    Download the patches you want to apply from My Oracle Support:
                            https://support.oracle.com
                      2.    Select the Patches and Updates tab to locate the patch.
                            Oracle recommends that you select Recommended Patch Advisor, and enter the product
                            group, release, and platform for your software.
                      3.    Move the patches to an accessible directory like /tmp.
                      4.    Change to the Oracle Grid Infrastructure home directory:

                            $ cd /u01/app/oracle/product/19.0.0/grid

                      5.    Apply Release Updates (RUs) and any one-off patches during the installation or upgrade
                            process:

                            $ ./gridSetup.sh -applyRU patch_directory_location -applyOneOffs
                            comma_seperated_list_of_patch_directory_locations



                                     Note
                                     You can apply RUs and one-off patches separately or together in the same
                                     command.

                      6.    Complete the remaining steps in the Oracle Grid Infrastructure configuration wizard to
                            complete the installation or upgrade.
                      Related Topics
                      •     Oracle Grid Infrastructure Upgrading Oracle Restart for Linux and Unix-Based Operating
                            Systems




Database Installation Guide
E96434-12                                                                                                               April 30, 2026
Copyright © 2015, 2026, Oracle and/or its affiliates.                                                                   Page 11 of 13
                                                                                                                      Chapter 10
                                                                         Patching and Switching Oracle Grid Infrastructure Homes




Patching and Switching Oracle Grid Infrastructure Homes
                      Perform an out-of-place Oracle Restart patching by switching from the current Oracle Grid
                      Infrastructure home to a patched Oracle Grid Infrastructure home.
                      1.    Download the 19.3 Oracle Grid Infrastructure base release image files.
                            https://www.oracle.com/database/technologies/oracle-database-software-
                            downloads.html#19c
                      2.    As the grid user, extract the downloaded image files into a new Oracle Grid Infrastructure
                            home directory.

                            $ mkdir -p /u01/app/oracle/product/19.17.0/grid
                            $ chown grid:oinstall /u01/app/oracle/product/19.17.0/grid
                            $ cd /u01/app/oracle/product/19.17.0/grid
                            $ unzip -q download_location/grid.zip


                            Here:
                            •    /u01/app/oracle/product/19.17.0/grid is the new Grid home.
                            •    /u01/app/oracle/product/19.16.0/grid is the old Grid home.
                      3.    As the grid user, download and install the latest version of the OPatch utility in the new
                            Grid home.
                            https://updates.oracle.com/download/6880880.html

                            $ mv /u01/app/oracle/product/19.17.0/grid/OPatch /u01/app/oracle/product/
                            19.17.0/grid/bak_OPatch
                            $ unzip latest_Opatch.zip -d /u01/app/oracle/product/19.17.0/grid/

                      4.    Download the Oracle Database RU version that you want to apply from My Oracle
                            Support. In this example, Oracle Database 19.17 RU.
                            For more information, see, Downloading Release Update Patches
                      5.    Start the Oracle Grid Infrastructure installer to perform a software-only Oracle Restart
                            installation. You can apply the optional -applyRU or -applyOneOff flags to apply
                            Release Updates (RUs) during the installation.

                             $ /u01/app/oracle/product/19.17.0/grid/gridSetup.sh [-applyRU
                            patch_directory_location]
                            [-applyOneOffs comma_separated_list_of_patch_directory_locations]

                      6.    Follow the steps in the configuration wizard to complete the Oracle Grid Infrastructure
                            installation.
                      7.    As the root user, run the following command to prepare the new home for the out-of-place
                            patching:

                            # /u01/app/oracle/product/19.17.0/grid/crs/install/roothas.sh -prepatch -
                            dstcrshome
                            /u01/app/oracle/product/19.17.0/grid


                            This command does not shut down any services.


Database Installation Guide
E96434-12                                                                                                         April 30, 2026
Copyright © 2015, 2026, Oracle and/or its affiliates.                                                             Page 12 of 13
                                                                                                                     Chapter 10
                                                                        Patching and Switching Oracle Grid Infrastructure Homes


                      8.    Run the following command to switch to the new Oracle Grid Infrastructure home and
                            perform the out of place patching:

                            # /u01/app/oracle/product/19.17.0/grid/crs/install/roothas.sh -postpatch -
                            dstcrshome
                            /u01/app/oracle/product/19.17.0/grid


                            This command shuts down the old Oracle Grid Infrastructure home and starts resources
                            from the new Oracle Grid Infrastructure home. All Oracle Grid Infrastructure services start
                            running from the new Grid home.
                      9.    Update the Oracle central inventory (oraInventory).

                            $ /u01/app/oracle/product/19.17.0/grid/oui/bin/runInstaller -
                            updateNodeList ORACLE_HOME=/u01/app/oracle/product/19.17.0/grid CRS=TRUE
                            $ /u01/app/oracle/product/19.16.0/grid/oui/bin/runInstaller -
                            updateNodeList ORACLE_HOME=/u01/app/oracle/product/19.16.0/grid CRS=FALSE

                      10. If the patching fails, then perform the following steps to rollback the patch:

                            a.   As the root user, run the prepatch script.

                                 # /u01/app/oracle/product/19.17.0/grid/crs/install/roothas.sh -prepatch
                                 -dstcrshome Old_GI_Home -rollback

                            b.   As the root user, run the postpatch script.

                                 # /u01/app/oracle/product/19.17.0/grid/crs/install/roothas.sh -
                                 postpatch -dstcrshome Old_GI_Home -rollback

                      11. If you have successfully switched to the new Grid home on all nodes and want to switch
                            back to the old Grid home, then perform the following steps:
                            a.   As the root user, run the prepatch script.

                                 # Old_GI_Home/crs/install/roothas.sh -prepatch -dstcrshome Old_GI_Home

                            b.   As the grid user, run the postpatch script.

                                 # Old_GI_Home/crs/install/roothas.sh -postpatch -dstcrshome Old_GI_Home

                            c.   Update the Oracle central inventory (oraInventory).

                                 $ /u01/app/oracle/product/19.16.0/grid/oui/bin/runInstaller -
                                 updateNodeList ORACLE_HOME=/u01/app/oracle/product/19.16.0/grid CRS=TRUE
                                 $ /u01/app/oracle/product/19.17.0/grid/oui/bin/runInstaller -
                                 updateNodeList ORACLE_HOME=/u01/app/oracle/product/19.17.0/grid
                                 CRS=FALSE




Database Installation Guide
E96434-12                                                                                                        April 30, 2026
Copyright © 2015, 2026, Oracle and/or its affiliates.                                                            Page 13 of 13
11
Installing Oracle Database
                      Oracle Database and Oracle Grid Infrastructure installation software is available as image-
                      based zip files and can be installed using several options.
                      You can download Oracle Database software from the Oracle website or the Oracle Software
                      Delivery Cloud portal. In most cases, you use the graphical user interface (GUI) provided by
                      Oracle Universal Installer to install the software. However, you can also run silent mode
                      installations, without using the GUI. You can also use Oracle Fleet Patching and Provisioning
                      for Oracle Database and Oracle Grid Infrastructure (clusterware) deployments.
                      Oracle Database software may be available on installation media on-demand.


                                Note
                                To install Oracle Database files on Oracle Automatic Storage Management (Oracle
                                ASM), you must first complete an Oracle Grid Infrastructure for a standalone server
                                installation. Oracle Grid Infrastructure for a standalone server includes Oracle Restart
                                and Oracle ASM.
                                To upgrade an existing Oracle ASM installation, upgrade Oracle ASM by running an
                                Oracle Grid Infrastructure upgrade. If you do not have Oracle ASM installed and you
                                want to use Oracle ASM as your storage option, then you must complete an Oracle
                                Grid Infrastructure for a standalone server installation before you start your Oracle
                                Database installation.
                                You cannot use Oracle Universal Installer from an earlier Oracle release to install
                                components from this release.



                      •     About Image-Based Oracle Database Installation
                            Understand image-based installation to simplify installation and configuration of Oracle
                            Database software.
                      •     About Deploying Oracle Database Using Oracle Fleet Patching and Provisioning
                            You can use Oracle Fleet Patching and Provisioning (Oracle FPP) to provision Oracle
                            Database software.
                      •     Downloading Oracle Software
                            Select the method you want to use to download the software.
                      •     About Character Set Selection During Installation
                            Before you create the database, decide the character set that you want to use.
                      •     About Automatic Memory Management Installation Options
                            Decide if you want to configure Automatic Memory Management during installation.
                      •     Running the Installer in a Different Language
                            Describes how to run the installer in other languages.
                      •     Installing the Oracle Database Software
                            These topics explain how to run Oracle Universal Installer to perform most database
                            installations.



Database Installation Guide
E96434-12                                                                                                      April 30, 2026
Copyright © 2015, 2026, Oracle and/or its affiliates.                                                           Page 1 of 16
                                                                                                                   Chapter 11
                                                                               About Image-Based Oracle Database Installation


                      •     Installing Standard Edition High Availability
                            Learn how to Install high availability on Oracle Database Standard Edition 2.


About Image-Based Oracle Database Installation
                      Understand image-based installation to simplify installation and configuration of Oracle
                      Database software.
                      To install Oracle Database, create the new Oracle home, extract the image file into the newly-
                      created Oracle home, and run the setup wizard to register the Oracle Database product.
                      Using image-based installation, you can install and upgrade Oracle Database for single-
                      instance and cluster configurations. If you install or clone an Oracle Database image, then all
                      Oracle Database options such as Oracle OLAP (olap) and Oracle Real Application Testing
                      (rat) are enabled by default.

                      This installation feature streamlines the installation process and supports automation of large-
                      scale custom deployments. You can also use this installation method for deployment of
                      customized images, after you patch the base-release software with the necessary Release
                      Updates (Updates) or Monthly Recommended Patches (MRPs).


                                Note
                                You must extract the image software (db_home.zip) into the directory where you
                                want your Oracle Database home to be located, and then run the Oracle Database
                                Setup Wizard to start the Oracle Database installation and configuration. Oracle
                                recommends that the Oracle home directory path you create is in compliance with the
                                Oracle Optimal Flexible Architecture recommendations.



About Deploying Oracle Database Using Oracle Fleet Patching
and Provisioning
                      You can use Oracle Fleet Patching and Provisioning (Oracle FPP) to provision Oracle
                      Database software.
                      Starting with Oracle Database 19c, Rapid Home Provisioning is renamed to Oracle Fleet
                      Patching and Provisioning (Oracle FPP).
                      With Oracle Fleet Patching and Provisioning, you create, store, and manage templates of
                      Oracle homes as images (called gold images) of Oracle software, such as databases,
                      middleware, and applications. You can make a working copy of any gold image and then you
                      can provision that working copy to any node in the data center or cloud computing
                      environment.
                      You can use Oracle Fleet Patching and Provisioning to provision, patch, and upgrade single-
                      instance databases running on Oracle Restart, on clusters, or on single, standalone nodes.
                      These may be on nodes with or without Oracle Grid Infrastructure installed.


                                Note
                                Oracle Fleet Patching and Provisioning is not supported on Microsoft Windows and
                                HP-UX Itanium systems.



Database Installation Guide
E96434-12                                                                                                       April 30, 2026
Copyright © 2015, 2026, Oracle and/or its affiliates.                                                            Page 2 of 16
                                                                                                                Chapter 11
                                                                                              Downloading Oracle Software


                      Related Topics
                      •     Oracle Fleet Patching and Provisioning Administrator's Guide


Downloading Oracle Software
                      Select the method you want to use to download the software.
                      You can download Oracle Database software from the Oracle website or the Oracle Software
                      Delivery Cloud portal and extract them to the Oracle home. Ensure that you review and
                      understand the terms of the license.
                      •     Downloading the Software from Oracle Software Delivery Cloud Portal
                            You can download the software from Oracle Software Delivery Cloud.
                      •     Downloading the Installation Archive Files from Oracle Website
                            Download installation archive files from the Oracle website.


Downloading the Software from Oracle Software Delivery Cloud Portal
                      You can download the software from Oracle Software Delivery Cloud.
                      1.    Use a browser to access the Oracle Software Delivery Cloud portal:
                            https://edelivery.oracle.com/
                      2.    Click Sign In and enter your Oracle account username and password.
                      3.    Type Oracle Database in the search bar. Click the Add to Cart button corresponding to
                            the Oracle Database version that you want to download
                      4.    In the Checkout page, click Checkout and deselect any products that you do not want to
                            download.
                      5.    Select the operating system platform on which you want to install the software from the
                            Platform/Languages column.
                      6.    Click Continue.
                      7.    Review the license agreement.
                      8.    Select the I reviewed and accept the Oracle License Agreement checkbox. Click
                            Continue.
                      9.    Click Download to start downloading the software.
                      10. After you download the files, click View Digest to verify that the checksum matches the
                            value listed on the download page.


Downloading the Installation Archive Files from Oracle Website
                      Download installation archive files from the Oracle website.
                      1.    Use any browser to access the software download page on the Oracle website:
                            http://www.oracle.com/technetwork/indexes/downloads/index.html
                      2.    Go to the download page for the product to install.
                      3.    On the download page, identify the required disk space by adding the file sizes for each
                            required file.
                            The file sizes are listed next to the file names.


Database Installation Guide
E96434-12                                                                                                   April 30, 2026
Copyright © 2015, 2026, Oracle and/or its affiliates.                                                        Page 3 of 16
                                                                                                                          Chapter 11
                                                                                   About Character Set Selection During Installation


                      4.    Select a file system with enough free space to store and expand the archive files.
                            In most cases, the available disk space must be at least twice the size of all of the archive
                            files.
                      5.    On the file system, create a parent directory for each product (for example, OraDB19c) to
                            hold the installation directories.
                      6.    Download all of the installation archive files to the directory you created for the product.


                                     Note
                                     For Oracle Database Client installations, there are two installation archive files
                                     available for download. The first file is the client installation binary and the second
                                     file is a client gold image file. Download the appropriate zip file based on the type
                                     of installation you want to perform.

                      7.    Verify that the files you downloaded are the same size as the corresponding files on the
                            Oracle website. Also verify the checksums are the same as noted on the Oracle website
                            using a command similar to the following, where filename is the name of the file you
                            downloaded:

                            cksum filename.zip

                      8.    Extract the files in each directory that you just created.


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



Database Installation Guide
E96434-12                                                                                                             April 30, 2026
Copyright © 2015, 2026, Oracle and/or its affiliates.                                                                  Page 4 of 16
                                                                                                                    Chapter 11
                                                                        About Automatic Memory Management Installation Options


                      depend on a character set. The universality and flexibility of Unicode usually outweighs these
                      additional costs.
                      Consider legacy character sets only when the database needs to support a single group of
                      languages and the use of a legacy character set is critical for fulfilling compatibility, storage, or
                      performance requirements. The database character set to be selected in this case is the
                      character set of most clients connecting to this database.
                      The database character set of a multitenant container database (CDB) determines which
                      databases can be plugged in later. Ensure that the character set you choose for the CDB is
                      compatible with the database character sets of the databases to be plugged into this CDB. If
                      you use Unicode AL32UTF8 as your CDB character set, then you can plug in a pluggable
                      database (PDB) in any database character set supported by Oracle Database (with the
                      exception of EBCDIC-based character sets).



                                See Also
                                Oracle Database Globalization Support Guide for more information about choosing a
                                database character set for a multitenant container database (CDB)



About Automatic Memory Management Installation Options
                      Decide if you want to configure Automatic Memory Management during installation.
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
                      Starting with 12c, Oracle Database uses the Optimized Shared Memory (OSM) model of
                      Oracle Solaris on Oracle Solaris 10 1/13 or later and Oracle Solaris 11 SRU 7.5 or later
                      systems to implement Automatic Memory Management. However, Oracle Database 12c
                      continues to use Intimate Shared Memory (ISM) or Dynamic Intimate Shared Memory (DISM)
                      on systems where OSM is not available.
                      Related Topics
                      •     Oracle Database Administrator's Reference for Linux and UNIX-Based Operating Systems
                      •     Oracle Database Administrator’s Guide




Database Installation Guide
E96434-12                                                                                                        April 30, 2026
Copyright © 2015, 2026, Oracle and/or its affiliates.                                                             Page 5 of 16
                                                                                                                        Chapter 11
                                                                                     Running the Installer in a Different Language




Running the Installer in a Different Language
                      Describes how to run the installer in other languages.
                      Your operating system locale determines the language in which the database installer runs.
                      You can run the installer in one of these languages:
                      •     Brazilian Portuguese (pt_BR)
                      •     French (fr)
                      •     German (de)
                      •     Italian (it)
                      •     Japanese (ja)
                      •     Korean (ko)
                      •     Simplified Chinese (zh_CN)
                      •     Spanish (es)
                      •     Traditional Chinese (zh_TW)
                      To run the database installer in a supported language, change the locale in which your
                      operating system session is running before you start the installer.
                      If the selected language is not one of the supported languages, then the installer runs in
                      English.


Installing the Oracle Database Software
                      These topics explain how to run Oracle Universal Installer to perform most database
                      installations.


                                Note
                                •    If you plan to use Oracle Restart or Oracle ASM, then you must install Oracle Grid
                                     Infrastructure for a standalone server before you install and create the database.
                                     Otherwise, you must manually register the database with Oracle Restart.
                                •    You can install Oracle Database by using the silent or response file installation
                                     method, without the GUI. This method is useful to perform multiple installations of
                                     Oracle Database.



                      •     Setup Wizard Installation Options for Creating Images
                      •     Applying Patches During an Oracle Database Installation or Upgrade
                            Starting with Oracle Database 18c, you can download and apply Release Updates (RUs)
                            during an Oracle Database installation or upgrade.
                      •     Running Oracle Database Setup Wizard to Install Oracle Database
                            Extract the database image files and use the runInstaller command to start the
                            installation.




Database Installation Guide
E96434-12                                                                                                           April 30, 2026
Copyright © 2015, 2026, Oracle and/or its affiliates.                                                                Page 6 of 16
                                                                                                                            Chapter 11
                                                                                               Installing the Oracle Database Software



Setup Wizard Installation Options for Creating Images
                      Before you start the setup wizards for your Oracle Database or Oracle Grid Infrastructure
                      installation, decide if you want to use any of the available image-creation options.
                      In image-based installations, you can start your Oracle Database installation or Oracle Grid
                      Infrastructure installations by running the setup wizards runInstaller and gridSetup.sh
                      respectively. Both these wizards come with the following image-creation options.

                      Table 11-1       Image-Creation Options for Setup Wizard

                       Option                            Description
                       -createGoldImage                  Creates a gold image from the current Oracle home.
                       -destinationLocation              Specify the complete path, or location, where the gold image will be
                                                         created.
                       -exclFiles                        Specify the complete paths to the files to be excluded from the newly
                                                         created gold image.
                       —help                             Displays help for all the available options.

                      For example:

                      cd $ORACLE_HOME
                      ./runInstaller -createGoldImage -destinationLocation /tmp/my_db_images -
                      exclFiles /u01/app/oracle/product/19.0.0/dbhome_1/relnotes


                      cd Grid_home
                      ./gridSetup.sh -createGoldImage -destinationLocation /tmp/my_grid_images -
                      exclFiles /u01/app/oracle/product/19.0.0/dbhome_1/relnotes


                      Where:
                      /tmp/my_db_images is a temporary file location where the image zip file is created.

                      /tmp/my_grid_images is a temporary file location where the image zip file is created.

                      /u01/app/oracle/product/19.0.0/dbhome_1/relnotes is the file to be excluded
                      from the newly created gold image.
                      Refer to runInstaller -createGoldImage and gridSetup.sh -createGoldImage for more examples.


Applying Patches During an Oracle Database Installation or Upgrade
                      Starting with Oracle Database 18c, you can download and apply Release Updates (RUs)
                      during an Oracle Database installation or upgrade.
                      1.    Download the patches you want to apply from My Oracle Support:
                            https://support.oracle.com
                      2.    Select the Patches and Updates tab to locate the patch.
                            Oracle recommends that you select Recommended Patch Advisor, and enter the product
                            group, release, and platform for your software.



Database Installation Guide
E96434-12                                                                                                               April 30, 2026
Copyright © 2015, 2026, Oracle and/or its affiliates.                                                                    Page 7 of 16
                                                                                                                      Chapter 11
                                                                                         Installing the Oracle Database Software


                      3.    Move the patches to an accessible directory like /tmp.
                      4.    Change to the Oracle Database home directory:

                            $ cd $ORACLE_HOME

                      5.    Apply Release Updates (RUs) during the installation or upgrade process:

                            $ ./runInstaller -applyRU patch_directory_location

                      6.    Complete the remaining steps in the Oracle Database configuration wizard to complete the
                            installation or upgrade.


Running Oracle Database Setup Wizard to Install Oracle Database
                      Extract the database image files and use the runInstaller command to start the
                      installation.
                      Have all the information you need to provide regarding users groups, and storage paths before
                      you start installation. Oracle recommends that you have your My Oracle Support credentials
                      available during installation. You should also be prepared to run root scripts or provide
                      information to automate root scripts.
                      1.    Log in as the Oracle installation owner user account (oracle) that you want to own the
                            software binaries.
                      2.    If this is the first time you are installing Oracle software, then create the Oracle base and
                            the Oracle inventory directories as per the Oracle Optimal Flexible Architecture (OFA)
                            recommendations. Specify the correct owner, group, and permissions for these directories.

                            # mkdir -p /u01/app/oracle
                            # mkdir -p /u01/app/oraInventory
                            # chown -R oracle:oinstall /u01/app/oracle
                            # chown -R oracle:oinstall /u01/app/oraInventory
                            # chmod -R 775 /u01/app

                      3.    Download the Oracle Database installation image files (db_home.zip) to a directory of
                            your choice. For example, you can download the image files to the /tmp directory.
                      4.    Create an OFA-compliant Oracle home directory and extract the image files that you have
                            downloaded in to this Oracle home directory. For example:

                            $ mkdir -p /u01/app/oracle/product/19.0.0/dbhome_1
                            $ cd /u01/app/oracle/product/19.0.0/dbhome_1
                            $ unzip -q /tmp/db_home.zip



                                     Note
                                     •    Ensure that the Oracle home directory path you create is in compliance with
                                          the Oracle Optimal Flexible Architecture recommendations. Also, unzip the
                                          installation image files only in this Oracle home directory that you created.
                                     •    Oracle home or Oracle base cannot be symlinks, nor can any of their parent
                                          directories, all the way to up to the root directory.




Database Installation Guide
E96434-12                                                                                                         April 30, 2026
Copyright © 2015, 2026, Oracle and/or its affiliates.                                                              Page 8 of 16
                                                                                                                         Chapter 11
                                                                                       Installing Standard Edition High Availability


                      5.    From the Oracle home directory, run the runInstaller command to start the Oracle
                            Database Setup Wizard.

                            $ cd /u01/app/oracle/product/19.0.0/dbhome_1
                            $ ./runInstaller



                                     Note
                                     •    Run the runInstaller command from the Oracle home directory only. Do
                                          not use the runInstaller command that resides
                                          at $ORACLE_HOME/oui/bin/, or any other location, to install Oracle
                                          Database, Oracle Database Client, or Oracle Grid Infrastructure.
                                     •    Use the runInstaller command with the -applyRU option to install
                                          Release Updates (RUs) during an Oracle Database installation or upgrade.



                      6.    In the Select Configuration Option screen, select Create and configure a single instance
                            database.

                      7.    Select your installation type.
                            Installation screens vary depending on the installation option you select. Respond to the
                            configuration prompts as needed.
                      8.    Provide information to automate root scripts, or run scripts as root when prompted by the
                            setup wizard.
                            If you configure automation for running root scripts, and a root script fails, then you can fix
                            the problem manually, and click Retry to run the root script again.


                                     Note
                                     Click Help if you have any questions about the information you are asked to
                                     submit during installation.



Installing Standard Edition High Availability
                      Learn how to Install high availability on Oracle Database Standard Edition 2.
                      •     About Standard Edition High Availability
                            Starting with Oracle Database 19c, you can install Oracle Database Standard Edition 2 in
                            high availability mode.
                      •     Requirements for Installing Standard Edition High Availability
                            Review these requirements before you install and deploy the Standard Edition High
                            Availability feature.
                      •     Deploying Standard Edition High Availability
                            Learn the process and options to deploy high availability on Oracle Database Standard
                            Edition 2.




Database Installation Guide
E96434-12                                                                                                            April 30, 2026
Copyright © 2015, 2026, Oracle and/or its affiliates.                                                                 Page 9 of 16
                                                                                                                         Chapter 11
                                                                                       Installing Standard Edition High Availability



About Standard Edition High Availability
                      Starting with Oracle Database 19c, you can install Oracle Database Standard Edition 2 in high
                      availability mode.
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
                      Starting with Oracle Database 19c Release Update (19.7), Standard Edition High Availability is
                      supported on Linux x86-64, Oracle Solaris on SPARC (64-bit), and Microsoft Windows.
                      Starting with Oracle Database 19c Release Update (19.13), Standard Edition High Availability
                      is supported on IBM AIX on POWER Systems (64-bit) and HP-UX Itanium.


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


Database Installation Guide
E96434-12                                                                                                            April 30, 2026
Copyright © 2015, 2026, Oracle and/or its affiliates.                                                                Page 10 of 16
                                                                                                                      Chapter 11
                                                                                    Installing Standard Edition High Availability


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

Installing Standard Edition High Availability Database Software on Local File System
                      You can install Oracle Database software binaries on a local file system to enable the Oracle
                      Database Standard Edition high availability feature.
                      Ensure that all the cluster nodes, on which you plan to configure Standard Edition High
                      Availability, have the same operating system configuration, users, groups, resource limits, and
                      SSH equivalence for the Oracle Database software owner user (oracle).
                      Before you start the installation, have all the information you need about users, groups, and
                      storage paths. You should also be prepared to run root scripts or provide information to
                      automate root scripts.
                      1.    As the root user, log into the first cluster node on which you want to configure Standard
                            Edition High Availability and create the Oracle base directory on the local file system.




Database Installation Guide
E96434-12                                                                                                         April 30, 2026
Copyright © 2015, 2026, Oracle and/or its affiliates.                                                             Page 11 of 16
                                                                                                                         Chapter 11
                                                                                       Installing Standard Edition High Availability


                            Follow the Oracle Optimal Flexible Architecture (OFA) recommendations and specify the
                            correct owner, group, and permissions for this directory.

                            # mkdir -p /u01/app/oracle
                            # chown oracle:oinstall /u01/app/oracle

                      2.    Log in to the first cluster node as the Oracle Database software owner user (oracle).
                      3.    Download the Oracle Database 19c release 19.3 installation image file (db_home.zip)
                            from Oracle Software Delivery Cloud website to a directory of your choice.
                            https://edelivery.oracle.com/
                      4.    Download the Oracle Database Release Update 19.7 or later patch from My Oracle
                            Support to a directory of your choice and unzip it.
                            https://support.oracle.com/
                      5.    Create an OFA-compliant Oracle home directory on the local file system and extract the
                            image files that you have downloaded in to this Oracle home directory. For example:

                            $ mkdir -p /u01/app/oracle/product/19.0.0/dbhome_1
                            $ cd /u01/app/oracle/product/19.0.0/dbhome_1
                            $ unzip -q /tmp/db_home.zip

                      6.    From the Oracle home directory, run the runInstaller command with the -applyRU flag
                            to start the Oracle Database Setup Wizard and apply the Oracle Database Release
                            Update 19.7 or later patch during installation.

                            $ ./runInstaller -applyRU patch_directory_location/patch_ID



                                     Note
                                     Run the runInstaller command from the Oracle home directory only. Do not
                                     use the runInstaller command that resides at $ORACLE_HOME/oui/bin/, or
                                     any other location, to install Oracle Database.

                      7.    In the Select Configuration Option screen, select Set Up Software Only.
                      8.    In the Select Database Installation Option screen, select Single instance database
                            installation.
                      9.    In the Select Database Edition screen, select Standard Edition 2.
                      10. Respond to the configuration prompts as needed.

                      11. Provide information to automate root scripts, or run scripts as root when prompted by the
                            setup wizard.
                            If you configure automation for running root scripts, and a root script fails, then you can fix
                            the problem manually, and click Retry to run the root script again.


                                     Note
                                     Click Help if you have any questions about the information you are asked to
                                     submit during installation.




Database Installation Guide
E96434-12                                                                                                            April 30, 2026
Copyright © 2015, 2026, Oracle and/or its affiliates.                                                                Page 12 of 16
                                                                                                                      Chapter 11
                                                                                    Installing Standard Edition High Availability


                      12. Optional: As the oracle user, enable read-only Oracle home on the first cluster node.

                            $ $ORACLE_HOME/bin/roohctl -enable

                      13. As the root user, create the Oracle base directory on all of the other cluster nodes on
                            which you want to configure Standard Edition High Availability.

                            # mkdir -p /u01/app/oracle
                            # chown oracle:oinstall /u01/app/oracle

                      14. As the oracle user, run the addnode.sh script from the first node to perform the following
                            operations on the other nodes on which you want to configure Standard Edition High
                            Availability:
                            •    Copy the Oracle home directory from the first node to the other nodes.
                            •    Setup Oracle base and Oracle inventory directories on the other nodes.

                            $ $ORACLE_HOME/addnode/addnode.sh -silent
                            CLUSTER_NEW_NODES=comma_separated_list_of_other_nodes

                      15. As the root user, run the root.sh script on all the other cluster nodes on which you are
                            configuring Standard Edition High Availability.

                            # /u01/app/oracle/product/19.0.0/dbhome_1/root.sh

                      After the Oracle Database software installation is complete, use Oracle Database
                      Configuration Assistant (Oracle DBCA), in either interactive or silent mode, to create a
                      Standard Edition database on the first cluster node on which you installed the Oracle Database
                      software.
                      For more information about the requirements for creating a database, and the procedure for
                      enabling and configuring Standard Edition High Availability for Oracle Databases, refer to
                      Oracle Database Administrator’s Guide.
                      Related Topics
                      •     Response Files
                            Review the following topics to install and configure Oracle Database, Oracle Grid
                            Infrastructure, and other Oracle products using response files.
                      •     Oracle Grid Infrastructure Installation and Upgrade Guide for Linux
                      •     Creating a Database with Oracle DBCA

Installing Standard Edition High Availability Database Software on Oracle ACFS
                      You can install Oracle Database software binaries on an Oracle ASM Cluster File System
                      (Oracle ACFS) volume to enable the Oracle Database Standard Edition High Availability
                      feature.
                      Ensure that all the cluster nodes, on which you plan to configure Standard Edition High
                      Availability, have the same operating system configuration, users, groups, resource limits, and
                      SSH equivalence for the Oracle Database software owner user (oracle) between the nodes.
                      Before you start the installation, have all the information you need about users groups, and
                      storage paths. You should also be prepared to run root scripts or provide information to
                      automate root scripts.



Database Installation Guide
E96434-12                                                                                                         April 30, 2026
Copyright © 2015, 2026, Oracle and/or its affiliates.                                                             Page 13 of 16
                                                                                                                      Chapter 11
                                                                                    Installing Standard Edition High Availability


                      1.    As the root user, register Oracle ACFS as an Oracle Clusterware resource specifying the
                            Oracle Database software owner user (oracle) as the mount owner.

                            # Grid_home/bin/srvctl add filesystem -volume acfs_volume_name -diskgroup
                            diskgroup_name -path mount_point -fstype ACFS -autostart ALWAYS -user
                            oracle



                                     Note
                                     Mount Oracle ACFS to a mount point where you plan to create Oracle base and
                                     Oracle home directories for this installation. For example, /u01/app/oracle.

                      2.    As the oracle user, mount the Oracle ACFS file system on all of the cluster nodes on
                            which you want to configure Standard Edition High Availability.

                            $ Grid_home/bin/srvctl start filesystem -volume acfs_volume_name -
                            diskgroup diskgroup_name

                      3.    As the root user, create the Oracle base directory in an Oracle ACFS volume on the first
                            cluster node on which you want to configure Standard Edition High Availability. Follow the
                            Oracle Optimal Flexible Architecture (OFA) recommendations and specify the correct
                            owner, group, and permissions for this directory.

                            # mkdir -p /u01/app/oracle
                            # chown oracle:oinstall /u01/app/oracle



                                     Note
                                     If you have configured the Oracle ACFS file system with the oracle user as the
                                     mount owner and the /u01/app/oracle directory as the mount point, then this
                                     step is not required.

                      4.    Log in to the first cluster node as the Oracle Database software owner user (oracle).
                      5.    Download the Oracle Database 19c release 19.3 installation image file (db_home.zip)
                            from Oracle Software Delivery Cloud website to a directory of your choice.
                            https://edelivery.oracle.com/
                      6.    Download the Oracle Database Release Update 19.7 or later patch from My Oracle
                            Support to a directory of your choice and unzip it.
                            https://support.oracle.com/
                      7.    Create an OFA-compliant Oracle home directory in an Oracle ACFS volume and extract
                            the image files that you have downloaded in to this Oracle home directory. For example:

                            $ mkdir -p /u01/app/oracle/product/19.0.0/dbhome_1
                            $ cd /u01/app/oracle/product/19.0.0/dbhome_1
                            $ unzip -q /tmp/db_home.zip




Database Installation Guide
E96434-12                                                                                                         April 30, 2026
Copyright © 2015, 2026, Oracle and/or its affiliates.                                                             Page 14 of 16
                                                                                                                         Chapter 11
                                                                                       Installing Standard Edition High Availability


                      8.    From the Oracle home directory, run the runInstaller command with the -applyRU flag
                            to start the Oracle Database Setup Wizard and apply the Oracle Database Release
                            Update 19.7 or later patch during installation.

                            $ ./runInstaller -applyRU patch_directory_location/patch_ID



                                     Note
                                     Run the runInstaller command from the Oracle home directory only. Do not
                                     use the runInstaller command that resides at $ORACLE_HOME/oui/bin/, or
                                     any other location, to install Oracle Database.

                      9.    In the Select Configuration Option screen, select Set Up Software Only.
                      10. In the Select Database Installation Option screen, select Single instance database
                            installation.
                      11. In the Select Database Edition screen, select Standard Edition 2.

                      12. Respond to the configuration prompts as needed.

                      13. Provide information to automate root scripts, or run scripts as root when prompted by the
                            setup wizard.
                            If you configure automation for running root scripts, and a root script fails, then you can fix
                            the problem manually, and click Retry to run the root script again.


                                     Note
                                     Click Help if you have any questions about the information you are asked to
                                     submit during installation.

                      14. Optional: As the oracle user, enable read-only Oracle home on the first cluster node.

                            $ $ORACLE_HOME/bin/roohctl -enable

                      15. Attach the Oracle home on the first node to the other cluster nodes on which you want to
                            configure Standard Edition High Availability.

                            $ $ORACLE_HOME/addnode/addnode.sh -silent
                            CLUSTER_NEW_NODES=comma_separated_list_of_other_nodes

                      16. As the root user, run the root.sh script on all the other cluster nodes on which you are
                            configuring Standard Edition High Availability.

                            # /u01/app/oracle/product/19.0.0/dbhome_1/root.sh

                      After the Oracle Database software installation is complete, use Oracle Database
                      Configuration Assistant (Oracle DBCA), in either interactive or silent mode, to create a
                      Standard Edition database on the first cluster node on which you installed the Oracle Database
                      software.
                      For more information about the requirements for creating a database, and the procedure for
                      enabling and configuring Standard Edition High Availability for Oracle Databases, refer to
                      Oracle Database Administrator’s Guide.



Database Installation Guide
E96434-12                                                                                                            April 30, 2026
Copyright © 2015, 2026, Oracle and/or its affiliates.                                                                Page 15 of 16
                                                                                                                      Chapter 11
                                                                                    Installing Standard Edition High Availability


                      Related Topics
                      •     Oracle Grid Infrastructure Installation and Upgrade Guide for Linux
                      •     Configuring Oracle Automatic Storage Management Cluster File System
                      •     Creating a Database with Oracle DBCA




Database Installation Guide
E96434-12                                                                                                         April 30, 2026
Copyright © 2015, 2026, Oracle and/or its affiliates.                                                             Page 16 of 16
12
Oracle Database Postinstallation Tasks
                      Complete configuration tasks after you install Oracle Database.
                      You are required to complete some configuration tasks after Oracle Database is installed. In
                      addition, Oracle recommends that you complete additional tasks immediately after installation.
                      You must also complete product-specific configuration tasks before you use those products.


                                Note
                                This chapter describes basic configuration only. Refer to product-specific
                                administration and tuning guides for more detailed configuration and tuning
                                information.



                      •     Required Postinstallation Tasks
                            Download and apply required patches for your software release after completing your initial
                            installation.
                      •     Recommended Postinstallation Tasks
                            Oracle recommends that you complete these tasks after installation.
                      •     About Changes in Default SGA Permissions for Oracle Database
                            Starting with Oracle Database 12c Release 2 (12.2.0.1), by default, permissions to read
                            and write to the System Global Area (SGA) are limited to the Oracle software installation
                            owner.
                      •     Checking Installed Oracle Database Contents and Directory Location
                            Use these steps to check the contents and directory location of an Oracle Database
                            installation:
                      •     Enabling and Disabling Oracle Database Options After Installation
                            The chopt tool changes your database options after installation.
                      •     Starting Oracle Enterprise Manager Database Express
                            Use these steps to log in to Oracle Enterprise Manager Database Express (EM Express).
                      •     Creating a Fast Recovery Area
                            During an Oracle Restart installation, you can create only one disk group. During an Oracle
                            Clusterware installation, you can create multiple disk groups. If you plan to add an Oracle
                            Database for a standalone server or an Oracle RAC database, then you should create the
                            fast recovery area for database files.
                      •     Cloning an Oracle Database Home
                            Cloning an Oracle home involves creating a copy of the Oracle home and then configuring
                            it for a new environment.


Required Postinstallation Tasks
                      Download and apply required patches for your software release after completing your initial
                      installation.



Database Installation Guide
E96434-12                                                                                                     April 30, 2026
Copyright © 2015, 2026, Oracle and/or its affiliates.                                                          Page 1 of 19
                                                                                                                    Chapter 12
                                                                                               Required Postinstallation Tasks


                      •     Downloading Release Update Patches
                            Download and install Release Updates (RU) and Monthly Recommended Patches (MRPs)
                            patches for your Oracle software after you complete installation.
                      •     Unlocking and Resetting Oracle Database User Passwords
                            Passwords for all Oracle system administration accounts except SYS, SYSTEM, and
                            DBSMP are revoked after installation. Before you use a locked account, you must unlock it
                            and reset its password.


Downloading Release Update Patches
                      Download and install Release Updates (RU) and Monthly Recommended Patches (MRPs)
                      patches for your Oracle software after you complete installation.
                      Oracle provides quarterly updates in the form of Release Updates (RU) and Monthly
                      Recommended Patches (MRPs). Oracle no longer releases patch sets. For more information,
                      see My Oracle Support Note 2285040.1.
                      Check the My Oracle Support website for required updates for your installation.
                      1.    Use a web browser to view the My Oracle Support website:
                            https://support.oracle.com
                      2.    In the sign in to other Oracle Support portals section, click Support for Oracle
                            Hardware, Software, and Managed Cloud services to log in to My Oracle Support.


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


Unlocking and Resetting Oracle Database User Passwords
                      Passwords for all Oracle system administration accounts except SYS, SYSTEM, and DBSMP
                      are revoked after installation. Before you use a locked account, you must unlock it and reset its
                      password.




Database Installation Guide
E96434-12                                                                                                       April 30, 2026
Copyright © 2015, 2026, Oracle and/or its affiliates.                                                            Page 2 of 19
                                                                                                                   Chapter 12
                                                                                              Required Postinstallation Tasks


                      If you created a preconfigured database during the installation, but you did not unlock accounts
                      required to use the database, then you must unlock and reset those accounts using these
                      procedures.
                      •     Requirements for Database Passwords
                            To secure your database, use passwords that satisfy the Oracle recommended password
                            requirements, even the passwords for predefined user accounts.
                      •     Oracle Database System Privileges Accounts and Passwords
                            Review these system privileges accounts after installation in preparation for unlocking
                            accounts and changing passwords.
                      •     Guidelines for Changing System Privileges Account Passwords
                            Follow these rules for changing Oracle Database system privileges account passwords.
                      •     Locking and Unlocking User Accounts
                      •     Using SQL*Plus to Unlock Accounts and Reset Passwords
                            Use this SQL*Plus procedure to unlock and reset user account passwords.

Requirements for Database Passwords
                      To secure your database, use passwords that satisfy the Oracle recommended password
                      requirements, even the passwords for predefined user accounts.
                      Oracle Database provides a set of predefined user accounts. Create passwords in a secure
                      fashion. If you have default passwords, change these passwords to secure passwords.
                      You can manage the security for Oracle Database users in various ways:
                      •     Enforce restrictions on the way that passwords are created
                      •     Create user profiles
                      •     Use user resource limits to further secure user accounts
                      Related Topics
                      •     Oracle Database Security Guide

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
E96434-12                                                                                                      April 30, 2026
Copyright © 2015, 2026, Oracle and/or its affiliates.                                                           Page 3 of 19
                                                                                                                              Chapter 12
                                                                                                        Required Postinstallation Tasks



                                Note
                                This list contains some of the important system privileges user accounts, but it is not
                                complete. Use Oracle Enterprise Manager Database Express 12c to view the
                                complete list of database accounts.



                      Table 12-1 Partial List of Oracle Database System Privileges Accounts Locked After
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
                       FLOWS_FILES                 The account owns the Oracle Application          Oracle Application Express App
                                                   Express uploaded files.                          Builder User’s Guide




Database Installation Guide
E96434-12                                                                                                                April 30, 2026
Copyright © 2015, 2026, Oracle and/or its affiliates.                                                                     Page 4 of 19
                                                                                                                            Chapter 12
                                                                                                       Required Postinstallation Tasks



                      Table 12-1 (Cont.) Partial List of Oracle Database System Privileges Accounts Locked
                      After Installation

                       User Name                   Description                                     For More Information
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
                       SYSRAC                      The account used to administer Oracle Real      Oracle Database
                                                   Application Clusters (RAC).                     Administrator’s Guide


Database Installation Guide
E96434-12                                                                                                               April 30, 2026
Copyright © 2015, 2026, Oracle and/or its affiliates.                                                                    Page 5 of 19
                                                                                                                         Chapter 12
                                                                                                    Required Postinstallation Tasks



                      Table 12-1 (Cont.) Partial List of Oracle Database System Privileges Accounts Locked
                      After Installation

                       User Name                   Description                                  For More Information
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

Guidelines for Changing System Privileges Account Passwords
                      Follow these rules for changing Oracle Database system privileges account passwords.
                      Before you use a locked account, you must unlock it and reset its password. Passwords for all
                      Oracle system administration accounts except SYS, SYSTEM, and DBSNMP are revoked after
                      installation. If you created a starter database during the installation, Oracle Database
                      Configuration Assistant displays a screen with your database information and the Password
                      Management button. Use the Password Management button to unlock only the user names
                      you use.
                      For more information about how to create a secure password, see:
                      Oracle Database Security Guide




Database Installation Guide
E96434-12                                                                                                            April 30, 2026
Copyright © 2015, 2026, Oracle and/or its affiliates.                                                                 Page 6 of 19
                                                                                                                 Chapter 12
                                                                                            Required Postinstallation Tasks



Locking and Unlocking User Accounts
                      To temporarily deny access to the database for a particular user account, you can lock the user
                      account. If the user then attempts to connect, then the database displays an error message
                      and does not allow the connection. You can unlock the user account when you want to permit
                      database access again for that user. You can use Oracle Enterprise Manager Database
                      Express (EM Express) to lock and unlock user accounts.

                      To lock or unlock a user account:
                      1.    In EM Express, go to the Users page.
                      2.    Click the desired user account.
                      3.    From the Actions menu, select Alter Account.
                            The Alter Account page appears.
                      4.    Do one of the following:
                            •    To lock the account, enable the Account Locked option, and then click OK.
                            •    To unlock the account, disable the Account Locked option, and then click OK.

Using SQL*Plus to Unlock Accounts and Reset Passwords
                      Use this SQL*Plus procedure to unlock and reset user account passwords.
                      1.    Log in as the Oracle Database software owner user.
                      2.    Set the ORACLE_HOME and ORACLE_SID environment variables.
                            Bourne, Bash or Korn shell:

                            $ ORACLE_SID=orcl
                            $ export ORACLE_SID
                            $ ORACLE_HOME=/u01/app/oracle/product/19.0.0/dbhome_1
                            $ export ORACLE_HOME


                            C shell:

                            % setenv ORACLE_SID orcl
                            % setenv ORACLE_HOME /u01/app/oracle/product/19.0.0/dbhome_1

                      3.    Start SQL*Plus and log in as the SYS user, connecting as SYSDBA:

                            $ $ORACLE_HOME/bin/sqlplus
                            SQL> CONNECT SYS as SYSDBA
                            Enter password: sys_password

                      4.    To unlock an account:

                            ALTER USER account ACCOUNT UNLOCK;

                      5.    To reset the password:

                            ALTER USER user_name IDENTIFIED BY new_password;



Database Installation Guide
E96434-12                                                                                                    April 30, 2026
Copyright © 2015, 2026, Oracle and/or its affiliates.                                                         Page 7 of 19
                                                                                                                Chapter 12
                                                                                        Recommended Postinstallation Tasks



                                     Note
                                     If you unlock an account but do not reset the password, then the password
                                     remains expired. The first time someone connects as that user, they must change
                                     the user's password.

                      Related Topics
                      •     Oracle Database Administrator’s Guide


Recommended Postinstallation Tasks
                      Oracle recommends that you complete these tasks after installation.
                      •     Creating a Backup of the root.sh Script
                            Oracle recommends that you back up the root.sh script after you complete an
                            installation.
                      •     Setting Language and Locale Preferences for Client Connections
                            Configure client applications connecting to an Oracle Database according to your locale
                            preferences and your I/O device character set.
                      •     Recompile Invalid Objects in the Database
                            After you install, patch, or upgrade a database, recompile invalid objects on the CDB and
                            PDBs with a recompilation driver script.
                      •     About Installing Oracle Autonomous Health Framework
                            Install the latest version of Oracle Autonomous Health Framework to perform proactive
                            heath checks and collect diagnostics data for the Oracle software stack.
                      •     Enabling Data Analytics Accelerators on SPARC for Oracle Database
                            The microprocessors for the SPARC M7 and T7 series servers include Data Analytics
                            Accelerator (DAX) coprocessors. These coprocessors perform query-related operations
                            directly through the hardware, which improves Oracle Database performance.


Creating a Backup of the root.sh Script
                      Oracle recommends that you back up the root.sh script after you complete an installation.

                      If you install other products in the same Oracle home directory subsequent to this installation,
                      then Oracle Universal Installer updates the contents of the existing root.sh script during the
                      installation. If you require information contained in the original root.sh script, then you can
                      recover it from the backed up root.sh file.


Setting Language and Locale Preferences for Client Connections
                      Configure client applications connecting to an Oracle Database according to your locale
                      preferences and your I/O device character set.
                      You must configure client applications connecting to an Oracle Database according to your
                      locale preferences and your I/O device character set. If your applications do not have their own
                      specific methods to configure locale preferences, then the method you use to configure an
                      Oracle database client connection depends on the access API you use to connect to the
                      database. Check your application documentation, before you configure locale preferences for
                      your applications.




Database Installation Guide
E96434-12                                                                                                    April 30, 2026
Copyright © 2015, 2026, Oracle and/or its affiliates.                                                         Page 8 of 19
                                                                                                                   Chapter 12
                                                                                           Recommended Postinstallation Tasks


                      For applications that connect to Oracle Databases using Oracle Call Interface (OCI) use
                      NLS_LANG and other client settings with names that start with NLS_ to set the locale
                      conventions and client character set for Oracle Database sessions. It is important that you set
                      the character set part of the NLS_LANG value properly. The character set you set must
                      correspond to the character set used by your I/O devices, which in case of Microsoft Windows
                      is either the ANSI Code Page (for GUI applications), such as WE8MSWIN1252, or the OEM
                      Code Page (for Console mode applications), such as US8PC437. By doing this, the OCI API is
                      notified about the character set of data that it receives from the application. OCI can then
                      convert this data correctly to and from the database character set.
                      NLS_LANG and the other NLS settings can be specified either as environment variables or as
                      Windows Registry settings. Environment variable values take precedence over Registry
                      values.
                      Oracle Universal Installer sets a default value for the NLS_LANG setting in Registry when it
                      creates a new Oracle home on Microsoft Windows. The NLS_LANG value is based on the
                      language of the Windows user interface, which is the language of Windows menu items and
                      dialog box labels.


                                Caution
                                Failure to set the client character set correctly can cause data loss.


                      Java applications that connect to Oracle Databases by using Oracle JDBC do not use
                      NLS_LANG. Instead, Oracle JDBC maps the default locale of the Java VM in which the
                      application runs to the Oracle Database language and territory settings. Oracle JDBC then
                      configures the connected database session using these settings. Because Java works
                      internally in Unicode, the client character set is always set to Unicode. Unless an application
                      explicitly changes it, the default locale of the Java VM is set based on the locale of the user
                      operating system on which the Java VM runs. Check your Java VM documentation for
                      information about configuring the Java VM default locale.


                                Note
                                In 3-tier architecture deployments, application servers that are database clients can
                                have settings in their configuration files that specify the NLS_LANG value or the Java
                                VM locale. Check the documentation accompanying these servers.




                                See Also
                                Oracle Database Globalization Support Guide for more information about configuring
                                user locale preferences




Recompile Invalid Objects in the Database
                      After you install, patch, or upgrade a database, recompile invalid objects on the CDB and
                      PDBs with a recompilation driver script.
                      By default, AutoUpgrade performs a recompilation of invalid Oracle objects, which is controlled
                      by the configuraiton file run_utlrp local parameter (default: prefix.run_utlrp=yes). In addition,


Database Installation Guide
E96434-12                                                                                                       April 30, 2026
Copyright © 2015, 2026, Oracle and/or its affiliates.                                                            Page 9 of 19
                                                                                                                  Chapter 12
                                                                                          Recommended Postinstallation Tasks


                      Oracle provides the recompilation scripts utlrp.sql and utlprp.sql. These scripts are
                      located in the Oracle_home/rdbms/admin directory.


                                Note
                                Starting with AutoUpgrade 23.1, when you run the AutoUpgrade utility, AutoUpgrade
                                runs the utlprpom.sql script, and does not run utlrp.sql. When AutoUpgrade is
                                used for upgrades to Oracle Database 12c Release 2 (12.2.0.1) and later releases,
                                AutoUpgrade only recompiles invalid objects owned by Oracle-maintained schemas.
                                Because database upgrades do not need to touch user objects, AutoUpgrade
                                maintains this policy when it recompiles invalid objects.



                      After installing a database, recomplile all invalid objects;
                      1.    Change directory to Oracle_home/rdbms/admin. For example

                            $ cd $ORACLE_HOME/rdbms/admin

                      2.    Use the catcon.pl script in the Oracle home to run utlrp.sql. For example:

                            $ORACLE_HOME/perl/bin/perl catcon.pl --n 1 --e --b utlrp --d '''.'''
                            utlrp.sql


                            Note the following conditions of this use case:
                            •    --n parameter: is set to 1, so the script runs each PDB recompilation in sequence.
                            •    --e parameter: turns echo on.
                            •    --b parameter: Sets the log file base name. It is set to utlrp.
                            Expect a time delay for the serial recompilation of PDBs to complete. Depending on the
                            number of PDBs that you are upgrading, the recompilation can extend significantly beyond
                            the time required for the upgrade scripts to complete.
                            The utlrp.sql script automatically recompiles invalid objects in either serial or parallel
                            recompilation, based on both the number of invalid objects, and on the number of CPUs
                            available. CPUs are calculated using the number of CPUs (cpu_count) multiplied by the
                            number of threads for each CPU (parallel_threads_per_cpu). On Oracle Real Application
                            Clusters (Oracle RAC), this number is added across all Oracle RAC nodes.
                      After patching or upgrading a database, there is more than one approach you can use to
                      recompile invalid Oracle-owned and user-owned objects:
                      Recompile all invalid objects (the invalid objects in both Oracle and user schemas) by using
                      utlrp.sql or utlprp.sql.

                      If time is a factor and the type of invalid objects is predominately application owned, then you
                      can recompile Oracle-owned invalid objects first, and defer recompiling application-owned
                      invalid objects to a later time. To recompile invalid objects in Oracle schemas, use
                      utlprpom.sql. To recompile the remaining invalid objects, use utlrp.sql or utlprp.sql.




Database Installation Guide
E96434-12                                                                                                      April 30, 2026
Copyright © 2015, 2026, Oracle and/or its affiliates.                                                          Page 10 of 19
                                                                                                                 Chapter 12
                                                                                         Recommended Postinstallation Tasks



                                Note
                                When you use either utlprp.sql or utlprpom.sql, note that both scripts require you
                                to define the degree of parallelism that the script should use, or determine the number
                                of parallel recompile jobs to use.


                      The script uses syntax as follows, where base is the base name you want to have given to log
                      files, N is the number of PDBs on which you want to run recompilation jobs in parallel (degrees
                      of parallelism), script.sql is the Oracle recompilation script you chose to use, and P is the
                      number of PDBs on which you want to run in parallel:

                      $ORACLE_HOME/perl/bin/perl $ORACLE_HOME/rdbms/admin/catcon.pl -b base -
                      d $ORACLE_HOME/rdbms/admin
                                -n N -l /tmp script.sql '--pP'


                      Suppose you are running recompilation in a CDB using the log file base name recomp, with a
                      degrees of parallelism setting of 3 jobs per PDB container, the script you choose to use is
                      utlprp.sql, and you want to recompile across at most 10 PDBs at a time. In that case, the
                      syntax you use to run the recompile operation is similar to the following,

                      $ORACLE_HOME/perl/bin/perl $ORACLE_HOME/rdbms/admin/catcon.pl -b recomp -
                      d $ORACLE_HOME/rdbms/admin -n 10 -l /tmp utlprp.sql '--p3'


                      Related Topics
                      •     Syntax and Parameters for catcon.pl


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



Database Installation Guide
E96434-12                                                                                                     April 30, 2026
Copyright © 2015, 2026, Oracle and/or its affiliates.                                                         Page 11 of 19
                                                                                                                    Chapter 12
                                                                  About Changes in Default SGA Permissions for Oracle Database



Enabling Data Analytics Accelerators on SPARC for Oracle Database
                      The microprocessors for the SPARC M7 and T7 series servers include Data Analytics
                      Accelerator (DAX) coprocessors. These coprocessors perform query-related operations
                      directly through the hardware, which improves Oracle Database performance.
                      Starting with Oracle Database 12c Release 2 (12.2) and later releases, the DAX feature is
                      enabled by default for Oracle Database on Oracle Solaris on SPARC (64-bit) systems. The
                      dax_access privilege is available by default to the Oracle database installation owner (oracle)
                      and all other users and processes as part of the basic Oracle Solaris operating system
                      privilege set.
                      To use the DAX hardware with Oracle Database, you must install Oracle Database 12c
                      Enterprise Edition, and enable the In–Memory option for your application.
                      For information about configuring the Oracle Database 12c in-memory feature, see Oracle
                      Database In-Memory Guide.


                                Note
                                The DAX feature is not supported for use with Kernel Zones at this time.


                      Related Topics
                      •     Oracle Database In-Memory Guide


About Changes in Default SGA Permissions for Oracle Database
                      Starting with Oracle Database 12c Release 2 (12.2.0.1), by default, permissions to read and
                      write to the System Global Area (SGA) are limited to the Oracle software installation owner.
                      In previous releases, both the Oracle installation owner account and members of the OSDBA
                      group had access to shared memory. The change in Oracle Database 12c Release 2 (12.2)
                      and later releases to restrict access by default to the Oracle installation owner account
                      provides greater security than previous configurations. However, this change may prevent
                      DBAs who do not have access to the Oracle installation owner account from administering the
                      database.
                      The Oracle Database initialization parameter ALLOW_GROUP_ACCESS_TO_SGA determines if
                      the Oracle Database installation owner account (oracle in Oracle documentation examples) is
                      the only user who can read and write to the database System Global Area (SGA), or if
                      members of the OSDBA group can read the SGA. In Oracle Database 12c Release 2 (12.2)
                      and later releases, the default value for this parameter is FALSE, so that only the Oracle
                      Database installation owner has read and write permissions to the SGA. Group access to the
                      SGA is removed by default. This change affects all Linux and UNIX platforms.
                      If members of the OSDBA group require read access to the SGA, then you can change the
                      initialization parameter ALLOW_GROUP_ACCESS_TO_SGA setting from FALSE to TRUE. Oracle
                      strongly recommends that you accept the default permissions that limit access to the SGA to
                      the oracle user account.

                      Related Topics
                      •     Oracle Database Reference




Database Installation Guide
E96434-12                                                                                                        April 30, 2026
Copyright © 2015, 2026, Oracle and/or its affiliates.                                                            Page 12 of 19
                                                                                                                        Chapter 12
                                                                Checking Installed Oracle Database Contents and Directory Location




Checking Installed Oracle Database Contents and Directory
Location
                      Use these steps to check the contents and directory location of an Oracle Database
                      installation:
                      1.    Go to $ORACLE_HOME/oui/bin.
                      2.    Start Oracle Universal Installer.

                            $ ./runInstaller

                      3.    Click Installed Products to display the Inventory dialog box on the Welcome screen.
                      4.    Select an Oracle Database product from the list to check the installed contents.
                      5.    Click Details to find additional information about an installed product.
                      6.    Click Close to close the Inventory dialog box.
                      7.    Click Cancel to close Oracle Universal Installer, and then click Yes to confirm.


Enabling and Disabling Oracle Database Options After
Installation
                      The chopt tool changes your database options after installation.

                      When you install Oracle Database, some options are enabled and others are disabled. To
                      enable or disable a particular database feature for an Oracle home, shut down the database
                      and use the chopt tool.

                      •     Chopt Tool
                            Use the chopt tool after installation to add or remove Oracle Database options.


Chopt Tool
                      Use the chopt tool after installation to add or remove Oracle Database options.

                      Purpose
                      The chopt tool is a command-line utility that enables and disables database options.


                                Note
                                If you install or clone an Oracle Database image, then all Oracle Database options are
                                enabled by default.


                      Prerequisites
                      You must complete installation before you can use the chopt tool.




Database Installation Guide
E96434-12                                                                                                           April 30, 2026
Copyright © 2015, 2026, Oracle and/or its affiliates.                                                               Page 13 of 19
                                                                                                                    Chapter 12
                                                                           Starting Oracle Enterprise Manager Database Express



                      File Path
                      The tool is located in the ORACLE_HOME/bin directory

                      Syntax
                      chopt [enable | disable] db_option

                      Options


                       Command Option                                    Description
                       olap                                              Oracle OLAP
                       partitioning                                      Oracle Partitioning
                       rat                                               Oracle Real Application Testing



                                Note
                                •    When you enable or disable OLAP, you must run the SYS.XOQ_VALIDATE and
                                     SYS.APS_VALIDATE procedures to update the database registry. When you disable
                                     OLAP, its status in the database registry should be OPTION OFF and when you
                                     enable OLAP, its status in the database registry should be VALID.
                                •    The Oracle Advanced Analytics (OAA) feature is enabled by default for Oracle
                                     Database. You cannot disable it using the chopt tool.



                      Examples
                      To use the chopt tool to modify your Oracle Database, you must shut down the database
                      before you run the chopt tool, and then start up the database after you add or remove
                      database options.
                      Example 12-1          Enabling Oracle Real Application Testing Using chopt
                      The following example shows how to use the chopt tool to enable the Oracle Real Application
                      Testing option in an Oracle Database called Sales:

                      cd $ORACLE_HOME/bin
                      srvctl stop database -d Sales
                      chopt enable rat
                      srvctl start database -d Sales



Starting Oracle Enterprise Manager Database Express
                      Use these steps to log in to Oracle Enterprise Manager Database Express (EM Express).
                      To start Oracle Enterprise Manager Database Express, use the EM Express URL provided by
                      Oracle Database Configuration Assistant (Oracle DBCA) during the database installation and
                      creation. For information about logging in to Oracle Enterprise Manager Database Express see
                      Oracle Database 2 Day DBA.




Database Installation Guide
E96434-12                                                                                                        April 30, 2026
Copyright © 2015, 2026, Oracle and/or its affiliates.                                                            Page 14 of 19
                                                                                                                   Chapter 12
                                                                                                Creating a Fast Recovery Area


                      If Oracle DBCA did not provide the EM Express URL during the database installation and
                      creation, or if you need to change the EM Express port later on, then see Oracle Database 2
                      Day DBA.
                      Related Topics
                      •     Oracle Database 2 Day DBA
                      •     Configuring the HTTPS Port for EM Express


Creating a Fast Recovery Area
                      During an Oracle Restart installation, you can create only one disk group. During an Oracle
                      Clusterware installation, you can create multiple disk groups. If you plan to add an Oracle
                      Database for a standalone server or an Oracle RAC database, then you should create the fast
                      recovery area for database files.
                      •     About the Fast Recovery Area and the Fast Recovery Area Disk Group
                            The fast recovery area is a unified storage location for all Oracle Database files related to
                            recovery. Enabling rapid backups for recent data can reduce requests to system
                            administrators to retrieve backup tapes for recovery operations.
                      •     Creating the Fast Recovery Area Disk Group
                            Procedure to create the fast recovery area disk group.


About the Fast Recovery Area and the Fast Recovery Area Disk Group
                      The fast recovery area is a unified storage location for all Oracle Database files related to
                      recovery. Enabling rapid backups for recent data can reduce requests to system administrators
                      to retrieve backup tapes for recovery operations.
                      Database administrators can define the DB_RECOVERY_FILE_DEST parameter to the path for
                      the fast recovery area to enable on disk backups and rapid recovery of data. When you enable
                      fast recovery in the init.ora file, Oracle Database writes all RMAN backups, archive logs,
                      control file automatic backups, and database copies to the fast recovery area. RMAN
                      automatically manages files in the fast recovery area by deleting obsolete backups and
                      archiving files no longer required for recovery.
                      Oracle recommends that you create a fast recovery area disk group. Oracle Clusterware files
                      and Oracle Database files can be placed on the same disk group, and you can also place fast
                      recovery files in the same disk group. However, Oracle recommends that you create a
                      separate fast recovery disk group to reduce storage device contention.
                      The fast recovery area is enabled by setting the DB_RECOVERY_FILE_DEST parameter. The
                      size of the fast recovery area is set with DB_RECOVERY_FILE_DEST_SIZE. As a general rule,
                      the larger the fast recovery area, the more useful it becomes. For ease of use, Oracle
                      recommends that you create a fast recovery area disk group on storage devices that can
                      contain at least three days of recovery information. Ideally, the fast recovery area is large
                      enough to hold a copy of all of your data files and control files, the online redo logs, and the
                      archived redo log files needed to recover your database using the data file backups kept under
                      your retention policy.
                      Multiple databases can use the same fast recovery area. For example, assume you have
                      created a fast recovery area disk group on disks with 150 GB of storage, shared by 3 different
                      databases. You can set the size of the fast recovery for each database depending on the
                      importance of each database. For example, if database1 is your least important database,
                      database2 is of greater importance, and database3 is of greatest importance, then you can set
                      different DB_RECOVERY_FILE_DEST_SIZE settings for each database to meet your retention


Database Installation Guide
E96434-12                                                                                                       April 30, 2026
Copyright © 2015, 2026, Oracle and/or its affiliates.                                                           Page 15 of 19
                                                                                                                    Chapter 12
                                                                                            Cloning an Oracle Database Home


                      target for each database: 30 GB for database1, 50 GB for database2, and 70 GB for
                      database3.


Creating the Fast Recovery Area Disk Group
                      Procedure to create the fast recovery area disk group.
                      1.    Go to the Oracle Grid Infrastructure home bin directory, and start Oracle ASM
                            Configuration Assistant (ASMCA).
                            For example:

                            $ cd /u01/app/oracle/product/19.0.0/grid/bin
                            $ ./asmca


                            ASMCA opens the home window.
                      2.    Click Disk Groups in the left panel to open the Disk Groups tab.
                      3.    Click Create to create a new disk group.
                            The Create Disk Groups window opens.
                      4.    Provide configuration information for the fast recovery area as prompted:
                            In the Disk Group Name field, enter a descriptive name for the fast recovery area group.
                            For example: FRA.
                            In the Redundancy section, select the level of redundancy you want to use. For example:
                            Normal

                            In the Select Member Disks field, select eligible disks you want to add to the fast recovery
                            area, and click OK.
                      5.    When the Fast Recovery Area disk group creation is complete, click Exit and click Yes to
                            confirm closing the ASMCA application.


Cloning an Oracle Database Home
                      Cloning an Oracle home involves creating a copy of the Oracle home and then configuring it
                      for a new environment.
                      If you are performing multiple Oracle Database installations, then you may want to use cloning
                      to create each Oracle home, because copying files from an existing Oracle Database
                      installation takes less time than creating a new version of them. This method is also useful if
                      the Oracle home that you are cloning has had patches applied to it. When you clone the Oracle
                      home, the new Oracle home has the patch updates.
                      Perform these steps to clone an Oracle home.


                                Note
                                During cloning, Oracle Universal Installer (OUI) prompts you to run scripts that require
                                root privileges.


                      1.    Verify that the installation of Oracle Database that you want clone is successful.




Database Installation Guide
E96434-12                                                                                                        April 30, 2026
Copyright © 2015, 2026, Oracle and/or its affiliates.                                                            Page 16 of 19
                                                                                                                     Chapter 12
                                                                                             Cloning an Oracle Database Home


                            You can do this by reviewing the installActionsdate_time.log file for the installation
                            session, which is typically located in the /u01/app/oracle/oraInventory/logs
                            directory.
                            If you install patches, then check their status using the following:

                            $ cd $ORACLE_HOME/OPatch


                            Include $ORACLE_HOME/OPatch in $PATH

                            $ opatch lsinventory

                      2.    Stop all processes related to the Oracle home.
                      3.    Create a ZIP or TAR file with the Oracle home (but not the Oracle base) directory.
                            For example, if the source Oracle installation is in the path /u01/app/oracle/
                            product/19.0.0/dbhome_1, then you zip the dbhome_1 directory by using the
                            following command:

                            # zip -r dbhome_1.zip /u01/app/oracle/product/19.0.0/dbhome_1


                            You can also use the TAR command. For example:

                            # tar -cvf dbhome_1.tar /u01/app/oracle/product/19.0.0/dbhome_1


                            Do not include the admin, fast_recovery_area, and oradata directories that are under the
                            Oracle base directory. These directories are created in the target installation later, when
                            you create a new database there.
                      4.    Copy the ZIP or TAR file to the root directory of the target computer. If you use File
                            Transfer Protocol (FTP), then transfer the ZIP or TAR file in binary mode only.
                      5.    Extract the ZIP or TAR file content using the following command:

                            # unzip -d / dbhome_1.zip
                            # tar -xvf dbhome_1.tar

                      6.    If necessary, change the ownership of the Oracle Database home to the Oracle Database
                            installation owner user (oracle) belonging to the Oracle Inventory group (oinstall).

                            # chown -R oracle:oinstall /u01/app/oracle/product/19.0.0/dbhome_1

                      7.    On the target computer, change the directory to the unzipped Oracle home directory, and
                            remove all the .ora (*.ora) files present in the unzipped $ORACLE_HOME/network/
                            admin directory.
                      8.    Delete unnecessary files from the unzipped Oracle home directory.
                            The unzipped Oracle home directory contains files that are relevant only to the source
                            Oracle home. The following example shows how to remove these unnecessary files from
                            the unzipped Oracle home directory:




Database Installation Guide
E96434-12                                                                                                      April 30, 2026
Copyright © 2015, 2026, Oracle and/or its affiliates.                                                          Page 17 of 19
                                                                                                                      Chapter 12
                                                                                                Cloning an Oracle Database Home


                            Remove the .ora files from the network/admin directory, and remove the old database
                            entries from the dbs directory.

                            # cd $ORACLE_HOME
                            # rm -rf network/admin/*.ora
                            # rm dbs/old_database_entries

                      9.    From the $ORACLE_HOME/clone/bin directory, run the clone.pl file for the unzipped
                            Oracle home.
                            Use the following syntax (you can also include one or more of the extended Oracle
                            Database groups in the syntax):
                            $ORACLE_HOME/perl/bin/perl $ORACLE_HOME/clone/bin/clone.pl
                            ORACLE_BASE="target_oracle_base" ORACLE_HOME="target_oracle_home"
                            OSDBA_GROUP=OSDBA_privileged_group
                            OSOPER_GROUP=OSOPER_privileged_group
                            OSBACKUPDBA_GROUP=OSBACKUPDBA_privileged_group
                            OSDGDBA_GROUP=OSDGDBA_privileged_group
                            OSKMDBA_GROUP=OSKMDBA_privileged_group
                            OSRACDBA_GROUP=OSRACDBA_privileged_group -defaultHomeName
                            For example:

                            $ORACLE_HOME/perl/bin/perl $ORACLE_HOME/clone/bin/clone.pl
                            ORACLE_BASE="/u01/app/oracle" ORACLE_HOME="/u01/app/oracle/product/19.0.0/
                            dbhome_1"
                            OSDBA_GROUP=dba OSOPER_GROUP=oper OSBACKUPDBA_GROUP=backupdba
                            OSDGDBA_GROUP=dgdba OSKMDBA_GROUP=kmdba OSRACDBA_GROUP=racdba -
                            defaultHomeName



                                     Note
                                     •    In this command, if you do not provide the parameters for the operating
                                          system groups, then clone.pl uses the operating system group values from
                                          the source home.
                                     •    Run the $ORACLE_HOME/perl/bin/perl $ORACLE_HOME/clone/bin/
                                          clone.pl -help command for more information about the command option
                                          flags.
                                     •    The clone.pl script is deprecated in Oracle Database 19c and can be
                                          removed in a future release. Hence, Oracle recommends that you use the
                                          software-only installation option, available in the database installer, instead of
                                          clone.pl to clone your database.



                            OUI starts, and then records the cloning actions in the cloneActionstimestamp.log file.
                            This log file is typically located in /u01/app/oracle/oraInventory/logs directory.
                      10. Use the following commands to run Net Configuration Assistant to configure the
                            connection information for the new database:

                            $ cd $ORACLE_HOME/bin
                            $ ./netca




Database Installation Guide
E96434-12                                                                                                         April 30, 2026
Copyright © 2015, 2026, Oracle and/or its affiliates.                                                             Page 18 of 19
                                                                                                           Chapter 12
                                                                                     Cloning an Oracle Database Home


                      11. Use the following commands to run Database Configuration Assistant to create a new
                            Oracle Database for the newly-cloned oracle home:

                            $ cd $ORACLE_HOME/bin
                            $ ./dbca

                      Related Topics
                      •     Oracle Clusterware Administration and Deployment Guide
                      •     Oracle Database Administrator’s Guide




Database Installation Guide
E96434-12                                                                                              April 30, 2026
Copyright © 2015, 2026, Oracle and/or its affiliates.                                                  Page 19 of 19
13
Removing Oracle Database Software
                      These topics describe how to remove Oracle software and configuration files.
                      Use the deinstall command that is included in Oracle homes to remove Oracle software.
                      Oracle does not support the removal of individual products or components.


                                Caution
                                If you have a standalone database on a node in a cluster, and if you have multiple
                                databases with the same global database name (GDN), then you cannot use the
                                deinstall command to remove one database only.



                      •     About Oracle Deinstallation Options
                            You can stop and remove Oracle Database software and components in an Oracle
                            Database home with the deinstall command.
                      •     Oracle Deinstallation (Deinstall)
                            You can run the deinstall command from an Oracle home directory after installation.
                      •     Deinstallation Examples for Oracle Database
                            Use these examples to help you understand how to run the deinstall command.
                      •     Downgrading Oracle Restart
                            Use this procedure to deconfigure and downgrade Oracle Restart, or to troubleshoot
                            Oracle Restart installation errors.
                      •     Deinstalling Previous Release Grid Home
                            Use this procedure to deinstall the previous release Grid home.


About Oracle Deinstallation Options
                      You can stop and remove Oracle Database software and components in an Oracle Database
                      home with the deinstall command.

                      You can remove the following software using deinstall :

                      •     Oracle Database
                      •     Oracle Grid Infrastructure, which includes Oracle Clusterware and Oracle Automatic
                            Storage Management (Oracle ASM)
                      •     Oracle Real Application Clusters (Oracle RAC)
                      •     Oracle Database Client
                      The deinstall command is available in Oracle home directories after installation. It is
                      located in the $ORACLE_HOME/deinstall directory.

                      deinstall creates a response file by using information in the Oracle home and using the
                      information you provide. You can use a response file that you generated previously by running




Database Installation Guide
E96434-12                                                                                                    April 30, 2026
Copyright © 2015, 2026, Oracle and/or its affiliates.                                                          Page 1 of 7
                                                                                                                  Chapter 13
                                                                                         About Oracle Deinstallation Options


                      the deinstall command using the -checkonly option. You can also edit the response file
                      template.
                      If you run deinstall to remove an Oracle Grid Infrastructure installation, then the deinstaller
                      prompts you to run the deinstall command as the root user. For Oracle Grid Infrastructure
                      for a cluster, the script is rootcrs.sh, and for Oracle Grid Infrastructure for a standalone
                      server (Oracle Restart), the script is roothas.sh.


                                Note
                                •    You must run the deinstall command from the same release to remove Oracle
                                     software. Do not run the deinstall command from a later release to remove
                                     Oracle software from an earlier release. For example, do not run the deinstall
                                     command from the 19c Oracle home to remove Oracle software from an existing
                                     11.2.0.4 Oracle home.
                                •    Starting with Oracle Database 12c Release 1 (12.1.0.2), the roothas.sh script
                                     replaces the roothas.pl script in the Oracle Grid Infrastructure home for Oracle
                                     Restart, and the rootcrs.sh script replaces the rootcrs.pl script in the Grid
                                     home for Oracle Grid Infrastructure for a cluster.



                      If the software in the Oracle home is not running (for example, after an unsuccessful
                      installation), then deinstall cannot determine the configuration, and you must provide all the
                      configuration details either interactively or in a response file.
                      In addition, before you run deinstall for Oracle Grid Infrastructure installations:

                      •     Dismount Oracle Automatic Storage Management Cluster File System (Oracle ACFS) and
                            disable Oracle Automatic Storage Management Dynamic Volume Manager (Oracle
                            ADVM).
                      •     If Grid Naming Service (GNS) is in use, then notify your DNS administrator to delete the
                            subdomain entry from the DNS.

                      Files Deleted by deinstall
                      When you run deinstall, if the central inventory (oraInventory) contains no other registered
                      homes besides the home that you are deconfiguring and removing, then deinstall removes
                      the following files and directory contents in the Oracle base directory of the Oracle Database
                      installation owner:
                      •     admin
                      •     cfgtoollogs
                      •     checkpoints
                      •     diag
                      •     oradata
                      •     fast_recovery_area
                      Oracle strongly recommends that you configure your installations using an Optimal Flexible
                      Architecture (OFA) configuration, and that you reserve Oracle base and Oracle home paths for
                      exclusive use of Oracle software. If you have any user data in these locations in the Oracle
                      base that is owned by the user account that owns the Oracle software, then deinstall
                      deletes this data.



Database Installation Guide
E96434-12                                                                                                     April 30, 2026
Copyright © 2015, 2026, Oracle and/or its affiliates.                                                           Page 2 of 7
                                                                                                                     Chapter 13
                                                                                               Oracle Deinstallation (Deinstall)



                                Caution
                                deinstall deletes Oracle Database configuration files, user data, and fast recovery
                                area (FRA) files even if they are located outside of the Oracle base directory path.



Oracle Deinstallation (Deinstall)
                      You can run the deinstall command from an Oracle home directory after installation.

                      Purpose
                      deinstall stops Oracle software, and removes Oracle software and configuration files on the
                      operating system for a specific Oracle home.

                      Syntax
                      The deinstall command uses the following syntax:

                      (./deinstall [-silent] [-checkonly] [-paramfile complete path of input
                      response file]
                      [-params name1=value name2=value . . .]
                      [-o complete path of directory for saving files]
                      [-tmpdir complete path of temporary directory to use]
                      [-logdir complete path of log directory to use] [-local] [-
                      skipLocalHomeDeletion] [-skipRemoteHomeDeletion] [-help]


                      Parameters


                       Parameter                                        Description
                       -silent                                          Use this flag to run deinstall in noninteractive
                                                                        mode. This option requires one of the following:
                                                                        •    A working system that it can access to
                                                                             determine the installation and configuration
                                                                             information. The -silent flag does not work
                                                                             with failed installations.
                                                                        •    A response file that contains the configuration
                                                                             values for the Oracle home that is being
                                                                             deinstalled or deconfigured.
                                                                        You can generate a response file to use or modify
                                                                        by running deinstall with the -checkonly
                                                                        flag. deinstall then discovers information from
                                                                        the Oracle home to deinstall and deconfigure. It
                                                                        generates the response file that you can then use
                                                                        with the -silent option.
                                                                        You can also modify the template file
                                                                        deinstall.rsp.tmpl, located in
                                                                        the $ORACLE_HOME/deinstall/response
                                                                        directory.




Database Installation Guide
E96434-12                                                                                                        April 30, 2026
Copyright © 2015, 2026, Oracle and/or its affiliates.                                                              Page 3 of 7
                                                                                                                         Chapter 13
                                                                                                   Oracle Deinstallation (Deinstall)




                       Parameter                                           Description
                       -checkonly                                          Use this flag to check the status of the Oracle
                                                                           software home configuration. Running
                                                                           deinstall with the -checkonly flag does not
                                                                           remove the Oracle configuration. The -
                                                                           checkonly flag generates a response file that you
                                                                           can then use with the deinstall command and
                                                                           -silent option.
                       -paramfile complete path of input response file Use this flag to run deinstall with a response
                                                                           file in a location other than the default. When you
                                                                           use this flag, provide the complete path where the
                                                                           response file is located.
                                                                           The default location of the response file
                                                                           is $ORACLE_HOME/deinstall/response.
                       -params [name1=value name2=value                    Use this flag with a response file to override one or
                       name3=value . . .]                                  more values to change in a response file you have
                                                                           created.
                       -o complete path of directory for saving response   Use this flag to provide a path other than the
                       files                                               default location where the response file
                                                                           (deinstall.rsp.tmpl) is saved.
                                                                           The default location of the response file
                                                                           is $ORACLE_HOME/deinstall/response .
                       -tmpdir complete path of temporary directory to Use this flag to specify a non-default location
                       use                                             where deinstall writes the temporary files for
                                                                           the deinstallation.
                       -logdir complete path of log directory to use       Use this flag to specify a non-default location
                                                                           where deinstall writes the log files for the
                                                                           deinstallation.
                       -local                                              Use this flag on a multinode environment to
                                                                           deinstall Oracle software in a cluster.
                                                                           When you run deinstall with this flag, it
                                                                           deconfigures and deinstalls the Oracle software on
                                                                           the local node (the node where deinstall is
                                                                           run). On remote nodes, it deconfigures Oracle
                                                                           software, but does not deinstall the Oracle
                                                                           software.
                       -skipLocalHomeDeletion                              Use this flag in Oracle Grid Infrastructure
                                                                           installations on a multinode environment to
                                                                           deconfigure a local Grid home without deleting the
                                                                           Grid home.
                       -skipRemoteHomeDeletion                             Use this flag in Oracle Grid Infrastructure
                                                                           installations on a multinode environment to
                                                                           deconfigure a remote Grid home without deleting
                                                                           the Grid home.
                       -help                                               Use this option to obtain additional information
                                                                           about the command option flags.




Database Installation Guide
E96434-12                                                                                                            April 30, 2026
Copyright © 2015, 2026, Oracle and/or its affiliates.                                                                  Page 4 of 7
                                                                                                                   Chapter 13
                                                                                  Deinstallation Examples for Oracle Database




Deinstallation Examples for Oracle Database
                      Use these examples to help you understand how to run the deinstall command.

                      Run deinstall from the $ORACLE_HOME/deinstall directory. The deinstallation starts
                      without prompting you for the Oracle home path.

                      $ ./deinstall


                      You can generate a deinstallation response file by running deinstall with the -checkonly
                      flag. Alternatively, you can use the response file template located at $ORACLE_HOME/
                      deinstall/response/deinstall.rsp.tmpl. If you have a response file, then use the
                      optional flag -paramfile to provide a path to the response file.

                      In the following example, the deinstall command is in the path/u01/app/oracle/product/
                      19.0.0/dbhome_1/deinstall. It uses a response file called my_db_paramfile.tmpl in the
                      software owner location /home/usr/oracle:

                      $ cd /u01/app/oracle/product/19.0.0/dbhome_1/deinstall
                      $ ./deinstall -paramfile /home/usr/oracle/my_db_paramfile.tmpl


                      To remove the Oracle Grid Infrastructure home, use the deinstall command in the Oracle
                      Grid Infrastructure home.
                      In this example, the Oracle Grid Infrastructure home is /u01/app/oracle/product/
                      19.0.0/grid

                      $ cd /u01/app/oracle/product/19.0.0/grid/deinstall
                      $ ./deinstall -paramfile /home/usr/oracle/my_grid_paramfile.tmpl



Downgrading Oracle Restart
                      Use this procedure to deconfigure and downgrade Oracle Restart, or to troubleshoot Oracle
                      Restart installation errors.

                      Running roothas.sh with the command flags -deconfig -force enables you to
                      deconfigure Oracle Restart without removing the installed binaries. This feature is useful if you
                      encounter an error during an Oracle Grid Infrastructure for a standalone server installation. For
                      example, when you run the root.sh command, and find a missing operating system package.
                      By running roothas.sh -deconfig -force, you can deconfigure Oracle Restart, correct
                      the cause of the error, and then run root.sh again.

                      1.    As the oracle user, create a backup of the SPFILE to a PFILE.

                            CREATE PFILE='/u01/app/oracle/product/19.0.0/dbhome_1/dbs/test_init.ora'
                            FROM SPFILE='/u01/oracle/dbs/test_spfile.ora';

                      2.    List all the Oracle Databases on the server with their version, unique name of the
                            database, and Oracle home information.

                            $ srvctl config database -home


Database Installation Guide
E96434-12                                                                                                      April 30, 2026
Copyright © 2015, 2026, Oracle and/or its affiliates.                                                            Page 5 of 7
                                                                                                                   Chapter 13
                                                                                                Downgrading Oracle Restart


                      3.    Downgrade Oracle Database. Refer to Oracle Database Upgrade Guide for more
                            information about required pre-downgrade tasks, downgrade tasks, post-downgrade tasks,
                            and compatibility information.


                                     Note
                                     Downgrade Oracle Database only if the Oracle Database version is higher than
                                     the Oracle Restart version to which you are downgrading Oracle Restart.

                      4.    As the oracle user, downgrade the Oracle Restart resources corresponding to the Oracle
                            Database, only if you have downgraded your Oracle Database.

                            $ srvctl downgrade database -d db_unique_name -oraclehome $ORACLE_HOME -t
                            to_version

                      5.    Inspect the Oracle Restart configuration of each database, service, and listener.

                            $ srvctl config database -db db_unique_name
                            $ srvctl config service -db db_unique_name
                            $ srvctl config listener -listener listener_name


                            Make a note of the configuration information and use this information when adding the
                            components back to Oracle Restart.
                      6.    Stop all databases and listeners that are running before you deconfigure or downgrade
                            Oracle Restart.

                            $ srvctl stop database -db db_unique_name
                            $ srvctl stop listener [-listener listener_name]

                      7.    As the root user, run roothas.sh with the -deconfig -force flags to deconfigure
                            Oracle Restart.

                            # /u01/app/oracle/product/19.0.0/grid/crs/install/roothas.sh -deconfig -
                            force

                      8.    As the grid user, update the Oracle central inventory (oraInventory).

                            $ /u01/app/oracle/product/19.0.0/grid/oui/bin/runInstaller -updateNodeList
                            -silent ORACLE_HOME=upgraded_Grid_home -local CRS=false

                      9.    As the root user, run roothas.sh with the -unlock flag to unlock the previous release
                            Oracle Restart home.

                            # /u01/app/oracle/product/18.0.0/grid/crs/install/roothas.sh -unlock -
                            dstcrshome previous_release_Grid_home

                      10. As the grid user, reconfigure the previous release Oracle Restart home using the
                            gridSetup.sh command.

                            $ /u01/app/oracle/product/18.0.0/grid/gridSetup.sh

                      11. As the oracle user, add the components back to Oracle Restart with the same attributes
                            that you noted down before deconfiguring Oracle Restart.


Database Installation Guide
E96434-12                                                                                                       April 30, 2026
Copyright © 2015, 2026, Oracle and/or its affiliates.                                                             Page 6 of 7
                                                                                                                      Chapter 13
                                                                                         Deinstalling Previous Release Grid Home


                            a.   Add Oracle Database to the Oracle Restart configuration.

                                 $ srvctl add database -db db_unique_name -oraclehome Oracle_home

                            b.   Add the listener to the Oracle Restart configuration.

                                 $ srvctl add listener -listener listener_name -oraclehome Oracle_home


                                 For the -oraclehome parameter, provide the Oracle home path from which the listener
                                 was running before the downgrade.
                            c.   Add each service to the database, using the srvctl add service command.

                                 $ srvctl add service -db db_unique_name -service service_name_list

                      Related Topics
                      •     Oracle Database Upgrade Guide


Deinstalling Previous Release Grid Home
                      Use this procedure to deinstall the previous release Grid home.
                      For upgrades from previous releases, if you want to deinstall the previous release Grid home,
                      then perform the following steps:
                      1.    Log in as the root user.
                      2.    Manually change the permissions of the previous release Grid home.

                            # chmod -R 775 /u01/app/oracle/product/18.0.0/grid
                            # chown -R oracle:oinstall /u01/app/oracle/product/18.0.0/grid
                            # chown oracle /u01/app/oracle/product/18.0.0


                            In this example:
                            •    /u01/app/oracle/product/18.0.0/grid is the previous release Oracle Grid
                                 Infrastructure for a standalone server home
                            •    oracle is the Oracle Grid Infrastructure installation owner user
                            •    oinstall is the name of the Oracle Inventory group (OINSTALL group)
                            •    /u01/app/oracle/product/18.0.0 is the parent directory of the previous Grid
                                 home.
                      3.    Log in as the Oracle Grid Infrastructure software owner user (oracle) and run the
                            deinstall command.




Database Installation Guide
E96434-12                                                                                                          April 30, 2026
Copyright © 2015, 2026, Oracle and/or its affiliates.                                                                Page 7 of 7
14
Completing Preinstallation Tasks Manually
                      You can complete the preinstallation configuration tasks manually.
                      Oracle recommends that you use Oracle Universal Installer and Cluster Verification Utility fixup
                      scripts to complete minimal configuration settings. If you cannot use fixup scripts, then
                      complete minimum system settings manually.
                      •     Configuring Kernel Parameters on Oracle Solaris
                            These topics explain how to configure kernel parameters manually for Oracle Solaris if you
                            cannot complete them using the fixup scripts.
                      •     Configuring Shell Limits for Oracle Solaris
                            For each installation software owner user account, check the shell limits for installation.


Configuring Kernel Parameters on Oracle Solaris
                      These topics explain how to configure kernel parameters manually for Oracle Solaris if you
                      cannot complete them using the fixup scripts.
                      •     Minimum Parameter Settings for Installation
                            Use this table to set parameters manually if you cannot use the fixup scripts.
                      •     Checking Shared Memory Resource Controls
                            Use the prctl command to make runtime interrogations of and modifications to the
                            resource controls associated with an active process, task, or project on the system.
                      •     Configuring Additional Shared Memory Identifiers Limit
                            Starting with 18c, on Oracle Solaris systems, Oracle Database uses a new method of
                            sharing memory among a group of processes, also known as Managed Global Areas
                            (MGA). The operating system memory allocation mechanism for this new method is
                            Optimized Shared Memory (OSM).
                      •     Displaying and Changing Kernel Parameter Values
                            Use these procedures to display the current value specified for resource controls and to
                            change them if necessary:
                      •     Setting UDP and TCP Kernel Parameters Manually
                            If you do not use a Fixup script or CVU to set ephemeral ports, then set TCP/IP ephemeral
                            port range parameters to provide enough ephemeral ports for the anticipated server
                            workload.


Minimum Parameter Settings for Installation
                      Use this table to set parameters manually if you cannot use the fixup scripts.

                      Table 14-1        Minimum Oracle Solaris Resource Control Parameter Settings

                       Resource Control                                   Minimum Value
                       project.max-sem-ids                                100
                       process.max-sem-nsems                              256



Database Installation Guide
E96434-12                                                                                                      April 30, 2026
Copyright © 2015, 2026, Oracle and/or its affiliates.                                                            Page 1 of 7
                                                                                                                       Chapter 14
                                                                                  Configuring Kernel Parameters on Oracle Solaris



                      Table 14-1        (Cont.) Minimum Oracle Solaris Resource Control Parameter Settings

                       Resource Control                                   Minimum Value
                       project.max-shm-memory                             This value varies according to the RAM size.
                                                                          See section “Requirements for Shared Memory
                                                                          Resources” for minimum values.
                       project.max-shm-ids                                100
                                                                          See section “Configuring Additional Shared
                                                                          Memory Identifiers Limit”.
                       tcp_smallest_anon_port                             9000
                       tcp_largest_anon_port                              65500
                       udp_smallest_anon_port                             9000
                       udp_largest_anon_port                              65500

                      Guidelines for Setting Resource Control Parameters
                      •     Unless otherwise specified, the kernel parameter and shell limit values in the preceding
                            table are minimum values only. Verify that the kernel parameters shown in the preceding
                            table are set to values greater than or equal to the minimum value shown. For production
                            database systems, Oracle recommends that you tune these values to optimize the
                            performance of the system. See your operating system documentation for more
                            information about kernel resource management.
                      •     If the current value for any parameter is greater than the value listed in the preceding table,
                            then the Fixup scripts do not change the value of that parameter.
                      •     The project.max-shm-memory resource control value assumes that no other
                            application is using the shared memory segment from this project other than the Oracle
                            instances. If applications, other than the Oracle instances are using the shared memory
                            segment, then you must add that shared memory usage to the project.max-shm-
                            memory resource control value.
                      •     project.max-shm-memory resource control = the cumulative sum of all shared memory
                            allocated on each Oracle database instance started under the corresponding project.
                      •     Ensure that memory_target or max_sga_size does not exceed process.max-
                            address-space and project.max-shm-memory. For more information, see My Oracle
                            Support Note 1370537.1.

                      Requirements for Shared Memory Resources project.max-shm-memory

                      Table 14-2        Requirement for Resource Control project.max-shm-memory

                       RAM                                                project.max-shm-memory setting
                       1 GB to 16 GB                                      Half the size of physical memory
                       Greater than 16 GB                                 At least 8 GB

                      Related Topics
                      •     Checking TCP Network Protocol Buffer for Direct NFS Client
                            Check your TCP network buffer size to ensure that it is adequate for the speed of your
                            servers.




Database Installation Guide
E96434-12                                                                                                          April 30, 2026
Copyright © 2015, 2026, Oracle and/or its affiliates.                                                                Page 2 of 7
                                                                                                                   Chapter 14
                                                                              Configuring Kernel Parameters on Oracle Solaris


                      Related Topics
                      •     Configuring Additional Shared Memory Identifiers Limit
                            Starting with 18c, on Oracle Solaris systems, Oracle Database uses a new method of
                            sharing memory among a group of processes, also known as Managed Global Areas
                            (MGA). The operating system memory allocation mechanism for this new method is
                            Optimized Shared Memory (OSM).


Checking Shared Memory Resource Controls
                      Use the prctl command to make runtime interrogations of and modifications to the resource
                      controls associated with an active process, task, or project on the system.
                      To view the current value of project.max-shm-memory set for a project and system-wide:

                      # prctl -n project.max-shm-memory -i project default


                      default is the project ID obtained by running the id -p command.

                      project.max-shm-memory

                      prctl -n project.max-shm-memory -v 6gb -r -i project default


                      Related Topics
                      •     Administering Oracle Solaris 11


Configuring Additional Shared Memory Identifiers Limit
                      Starting with 18c, on Oracle Solaris systems, Oracle Database uses a new method of sharing
                      memory among a group of processes, also known as Managed Global Areas (MGA). The
                      operating system memory allocation mechanism for this new method is Optimized Shared
                      Memory (OSM).
                      Oracle recommends that you configure the additional shared memory identifiers and increase
                      the shared memory limits as follows:
                      Additional number of MGA segments (project.max-shm-ids) = MGA memory size /
                      granule size
                      Where:
                      MGA memory size is the cumulative MGA memory requirement size for all processes in an
                      Oracle Database instance. Typically, 2MB per Oracle process.
                      Minimum value of granule size is 4 MB. For large SGA, granule size may increase
                      automatically upto 512 MB.
                      Refer to the following table to determine the approximate granule size.

                      Table 14-3        Granule Size for SGA Values

                       SGA                                            Granule Size
                       Less than 1 GB                                 4 MB
                       Between 1 GB and 8 GB                          16 MB
                       Between 8 GB and 16 GB                         32 MB


Database Installation Guide
E96434-12                                                                                                      April 30, 2026
Copyright © 2015, 2026, Oracle and/or its affiliates.                                                            Page 3 of 7
                                                                                                                      Chapter 14
                                                                                 Configuring Kernel Parameters on Oracle Solaris



                      Table 14-3        (Cont.) Granule Size for SGA Values

                       SGA                                               Granule Size
                       Between 16 GB and 32 GB                           64 MB
                       Between 32 GB and 64 GB                           128 MB
                       Between 64 GB and 128 GB                          256 MB
                       Greater than 128 GB                               512 MB


Displaying and Changing Kernel Parameter Values
                      Use these procedures to display the current value specified for resource controls and to
                      change them if necessary:

                      Displaying Resource Control Values
                      1.    To display the current values of the resource control:

                            $ id -p // to verify the project id
                            uid=100(oracle) gid=100(dba) projid=1 (group.dba)
                            $ prctl -n project.max-shm-memory -i project group.dba
                            $ prctl -n project.max-sem-ids -i project group.dba

                      2.    To change the current values use the prctl command. For example:
                            •    To modify the value of max-shm-memory to 6 GB:

                                 # prctl -n project.max-shm-memory -v 6gb -r -i project group.dba

                            •    To modify the value of max-sem-ids to 256:

                                 # prctl -n project.max-sem-ids -v 256 -r -i project group.dba



                                     Note
                                     When you use the prctl command (Resource Control) to change system
                                     parameters, you do not have to restart the system for these parameter changes to
                                     take effect. However, the changed parameters do not persist after a system
                                     restart.


                      Modifying Resource Control Values
                      Use the following procedure to modify the resource control project settings, so that they persist
                      after a system restart:
                      1.    By default, Oracle instances are run as the oracle user of the dba group. A project with
                            the name group.dba is created to serve as the default project for the oracle user. Run the
                            id command to verify the default project for the oracle user:

                            # su - oracle
                            $ id -p




Database Installation Guide
E96434-12                                                                                                         April 30, 2026
Copyright © 2015, 2026, Oracle and/or its affiliates.                                                               Page 4 of 7
                                                                                                                    Chapter 14
                                                                               Configuring Kernel Parameters on Oracle Solaris


                            uid=100(oracle) gid=100(dba) projid=100(group.dba)
                            $ exit

                      2.    To set the maximum shared memory size to 2 GB, run the projmod command:

                            # projmod -sK "project.max-shm-memory=(privileged,2G,deny)" group.dba


                            Alternatively, add the resource control value project.max-shm-
                            memory=(privileged,2147483648,deny) to the last field of the project entries for the
                            Oracle project.
                      3.    Check the values for the /etc/project file:

                            # cat /etc/project


                            The output is similar to the following:

                            system:0::::
                            user.root:1::::
                            noproject:2::::
                            default:3::::
                            group.staff:10::::
                            group.dba:100:Oracle default project ::: project.max-shm-
                            memory=(privileged,2147483648,deny)

                      4.    To verify that the resource control is active, check process ownership, and run the
                            commands id and prctl:

                            # su - oracle
                            $ id -p
                            uid=100(oracle) gid=100(dba) projid=100(group.dba)
                            $ prctl -n project.max-shm-memory -i process $$
                            process: 5754: -bash
                            NAME                    PRIVILEGE     VALUE     FLAG                  ACTION
                            RECIPIENT
                            project.max-shm-memory privileged     2.00GB     -                    deny



                                Note
                                The value for the maximum shared memory depends on the SGA requirements and
                                should be set to a value greater than the SGA size.


                      Related Topics
                      •     Oracle Solaris Tunable Parameters Reference Manual


Setting UDP and TCP Kernel Parameters Manually
                      If you do not use a Fixup script or CVU to set ephemeral ports, then set TCP/IP ephemeral port
                      range parameters to provide enough ephemeral ports for the anticipated server workload.
                      Ensure that the lower range is set to at least 9000 or higher, to avoid Well Known ports, and to
                      avoid ports in the Registered Ports range commonly used by Oracle and other server ports.


Database Installation Guide
E96434-12                                                                                                       April 30, 2026
Copyright © 2015, 2026, Oracle and/or its affiliates.                                                             Page 5 of 7
                                                                                                                     Chapter 14
                                                                                     Configuring Shell Limits for Oracle Solaris


                      Set the port range high enough to avoid reserved ports for any applications you may intend to
                      use. If the lower value of the range you have is greater than 9000, and the range is large
                      enough for your anticipated workload, then you can ignore Oracle Universal Installer warnings
                      regarding the ephemeral port range.
                      On Oracle Solaris 11, use the ipadm command to check your current range for ephemeral
                      ports:

                      # ipadm show-prop -p smallest_anon_port,largest_anon_port tcp

                      PROTO PROPERTY           PERM CURRENT PERSISTENT DEFAULT POSSIBLE
                      tcp   smallest_anon_port rw   32768       --     32768   1024-65535
                      tcp   largest_anon_port rw    65500       --     65535   32768-65535


                      In the preceding examples, the ephemeral ports are set to the default range (32768-65535).
                      If necessary for your anticipated workload or number of servers , update the UDP and TCP
                      ephemeral port range to a broader range. For example:
                      On Oracle Solaris 11:

                      # ipadm set-prop -p smallest_anon_port=9000 tcp
                      # ipadm set-prop -p largest_anon_port=65500 tcp
                      # ipadm set-prop -p smallest_anon_port=9000 udp
                      # ipadm set-prop -p largest_anon_port=65500 udp


                      Oracle recommends that you make these settings permanent. Refer to your system
                      administration documentation for information about how to automate this ephemeral port range
                      alteration on system restarts.


Configuring Shell Limits for Oracle Solaris
                      For each installation software owner user account, check the shell limits for installation.


                                Note
                                The shell limit values in this section are minimum values only. For production database
                                systems, Oracle recommends that you tune these values to optimize the performance
                                of the system. See your operating system documentation for more information about
                                configuring shell limits.


                      The ulimit settings determine process memory related resource limits. Verify that the
                      following shell limits are set to the values shown:




Database Installation Guide
E96434-12                                                                                                         April 30, 2026
Copyright © 2015, 2026, Oracle and/or its affiliates.                                                               Page 6 of 7
                                                                                                                       Chapter 14
                                                                                       Configuring Shell Limits for Oracle Solaris



                      Table 14-4        Oracle Solaris Shell Limit Recommended Ranges

                       Resource Shell Limit Descripti Soft Limit                           Hard Limit
                                            on
                       STACK                       Size (KB) at least 10240                at most 32768
                                                   of the
                                                   stack
                                                   segment
                                                   of the
                                                   process
                       NOFILES                     Open file at least 1024                 at least 65536
                                                   descriptor
                                                   s
                       MAXUPRC or                  Maximum at least 2047                   at least 16384
                       MAXPROC                     user
                                                   processe
                                                   s

                      To display the current value specified for these shell limits:

                      ulimit -s
                      ulimit -n




Database Installation Guide
E96434-12                                                                                                           April 30, 2026
Copyright © 2015, 2026, Oracle and/or its affiliates.                                                                 Page 7 of 7
A
Response Files
                      Review the following topics to install and configure Oracle Database, Oracle Grid
                      Infrastructure, and other Oracle products using response files.
                      •     How Response Files Work
                            Response files can assist you with installing an Oracle product multiple times on multiple
                            computers.
                      •     Reasons for Using Silent Mode or Response File Mode
                            Review this section for use cases for running the installer in silent mode or response file
                            mode.
                      •     Using Response Files
                            Review this information to use response files.
                      •     Preparing Response Files
                            Review this information to prepare response files for use during silent mode or response
                            file mode installations.
                      •     Running Oracle Universal Installer Using a Response File
                            After creating the response file, run Oracle Universal Installer at the command line,
                            specifying the response file you created, to perform the installation.
                      •     Running Configuration Assistants Using Response Files
                            You can run configuration assistants in response file or silent mode to configure and start
                            Oracle software after it is installed on the system. To run configuration assistants in
                            response file or silent mode, you must copy and edit a response file template.
                      •     Postinstallation Configuration Using Response File Created During Installation
                            Use response files to configure Oracle software after installation. You can use the same
                            response file created during installation to also complete postinstallation configuration.
                      •     Postinstallation Configuration Using the ConfigToolAllCommands Script
                            You can create and run a response file configuration after installing Oracle software. The
                            configToolAllCommands script requires users to create a second response file, of a
                            different format than the one used for installing the product.


How Response Files Work
                      Response files can assist you with installing an Oracle product multiple times on multiple
                      computers.
                      When you start Oracle Universal Installer (OUI), you can use a response file to automate the
                      installation and configuration of Oracle software, either fully or partially. OUI uses the values
                      contained in the response file to provide answers to some or all installation prompts.
                      Typically, the installer runs in interactive mode, which means that it prompts you to provide
                      information in graphical user interface (GUI) screens. When you use response files to provide
                      this information, you run the installer from a command prompt using either of the following
                      modes:
                      •     Silent mode




Database Installation Guide
E96434-12                                                                                                     April 30, 2026
Copyright © 2015, 2026, Oracle and/or its affiliates.                                                   Appendix A-1 of A-14
                                                                                                                            Appendix A
                                                                                  Reasons for Using Silent Mode or Response File Mode


                            If you include responses for all of the prompts in the response file and specify the -
                            silent option when starting the installer, then it runs in silent mode. During a silent mode
                            installation, the installer does not display any screens. Instead, it displays progress
                            information in the terminal that you used to start it.
                      •     Response file mode
                            If you include responses for some or all of the prompts in the response file and omit the -
                            silent option, then the installer runs in response file mode. During a response file mode
                            installation, the installer displays all the screens, screens for which you specify information
                            in the response file, and also screens for which you did not specify the required information
                            in the response file.
                      You define the settings for a silent or response file installation by entering values for the
                      variables listed in the response file. For example, to specify the Oracle home name, provide
                      the Oracle home path for the ORACLE_HOME environment variable:

                      ORACLE_HOME=/u01/app/oracle/product/19.0.0/dbhome_1



Reasons for Using Silent Mode or Response File Mode
                      Review this section for use cases for running the installer in silent mode or response file mode.


                       Mode                    Uses
                       Silent                  Use silent mode for the following installations:
                                               •    Complete an unattended installation, which you schedule using operating
                                                    system utilities such as at.
                                               •    Complete several similar installations on multiple systems without user
                                                    interaction.
                                               •    Install the software on a system that does not have X Window System software
                                                    installed on it.
                                               The installer displays progress information on the terminal that you used to start it,
                                               but it does not display any of the installer screens.
                       Response file           Use response file mode to complete similar Oracle software installations on more
                                               than one system, providing default answers to some, but not all of the installer
                                               prompts.



Using Response Files
                      Review this information to use response files.
                      Use the following general steps to install and configure Oracle products using the installer in
                      silent or response file mode:


                                Note
                                You must complete all required preinstallation tasks on a system before running the
                                installer in silent or response file mode.



                      1.    Prepare a response file.
                      2.    Run the installer in silent or response file mode.



Database Installation Guide
E96434-12                                                                                                               April 30, 2026
Copyright © 2015, 2026, Oracle and/or its affiliates.                                                             Appendix A-2 of A-14
                                                                                                                              Appendix A
                                                                                                                Preparing Response Files


                      3.    Run the root scripts as prompted by Oracle Universal Installer.
                      4.    If you completed a software-only installation, then run Net Configuration Assistant and
                            Oracle DBCA in silent or response file mode to create the database listener and an Oracle
                            Database instance respectively.


Preparing Response Files
                      Review this information to prepare response files for use during silent mode or response file
                      mode installations.
                      •     Editing a Response File Template
                            Oracle provides response file templates for each product and each configuration tool.
                      •     Recording Response Files
                            You can use OUI in interactive mode to record response files, which you can then edit and
                            use to complete silent mode or response file mode installations. This method is useful for
                            Advanced or software-only installations.


Editing a Response File Template
                      Oracle provides response file templates for each product and each configuration tool.

                      About Response File Templates
                      For Oracle Database, the response file templates are located in the $ORACLE_HOME/
                      install/response directory. For Oracle Grid Infrastructure, the response file templates are
                      located in the Grid_home/install/response directory.

                      Where, Grid_home is the Oracle Grid Infrastructure home directory path.


                                Note
                                If you copied the software to a hard disk, then the response files are located in
                                the $ORACLE_HOME/install/response directory.



                      All response file templates contain comment entries, sample formats, examples, and other
                      useful instructions. Read the response file instructions to understand how to specify values for
                      the response file variables, so that you can customize your installation.
                      The following table lists the response files provided with this software:

                      Table A-1       Response Files for Oracle Database and Oracle Grid Infrastructure

                       Response File            Description
                       db_install.rsp           Silent installation of Oracle Database.
                       dbca.rsp                 Silent creation and configuration of Oracle Database using Oracle DBCA.
                       netca.rsp                Silent configuration of Oracle Net using Oracle NETCA.
                       gridsetup.rsp            Silent configuration of Oracle Grid Infrastructure installations.




Database Installation Guide
E96434-12                                                                                                                 April 30, 2026
Copyright © 2015, 2026, Oracle and/or its affiliates.                                                               Appendix A-3 of A-14
                                                                                                                      Appendix A
                                                                                                       Preparing Response Files



                                Caution
                                When you modify a response file template and save a file for use, the response file
                                may contain plain text passwords. Ownership of the response file should be given to
                                the Oracle software installation owner only, and permissions on the response file
                                should be changed to 600. Oracle strongly recommends that database administrators
                                or other administrators delete or secure response files when they are not in use.



                      To copy and modify a response file:
                      1.    Copy the response file from the response file directory to a directory on your system:
                            For example, for Oracle Database:

                            $ cp $ORACLE_HOME/install/response/db_install.rsp local_directory

                      2.    Open the response file in a text editor:
                            $ vi /local_directory/db_install.rsp
                      3.    Follow the instructions in the file to edit it.


                                     Note
                                     The installer or configuration assistant fails if you do not correctly configure the
                                     response file. Also, ensure that your response file name has the .rsp suffix.


                      4.    Secure the response file by changing the permissions on the file to 600:
                            $ chmod 600 /local_dir/db_install.rsp

                            Ensure that only the Oracle software owner user can view or modify response files or
                            consider deleting them after the installation succeeds.


                                     Note
                                     A fully-specified response file for an Oracle Database installation contains the
                                     passwords for database administrative accounts and for a user who is a member
                                     of the OSDBA group (required for automated backups).



Recording Response Files
                      You can use OUI in interactive mode to record response files, which you can then edit and use
                      to complete silent mode or response file mode installations. This method is useful for
                      Advanced or software-only installations.
                      You can save all the installation steps into a response file during installation by clicking Save
                      Response File on the Summary page. You can use the generated response file for a silent
                      installation later.
                      When you record the response file, you can either complete the installation, or you can exit
                      from the installer on the Summary page, before OUI starts to set up the software to the system.



Database Installation Guide
E96434-12                                                                                                         April 30, 2026
Copyright © 2015, 2026, Oracle and/or its affiliates.                                                       Appendix A-4 of A-14
                                                                                                                        Appendix A
                                                                           Running Oracle Universal Installer Using a Response File


                      If you use record mode during a response file mode installation, then the installer records the
                      variable values that were specified in the original source response file into the new response
                      file.


                                 Note
                                 OUI does not save passwords while recording the response file.



                      To record a response file:
                      1.    Complete preinstallation tasks as for a standard installation.
                            When you run the installer to record a response file, it checks the system to verify that it
                            meets the requirements to install the software. For this reason, Oracle recommends that
                            you complete all of the required preinstallation tasks and record the response file while
                            completing an installation.
                      2.    Ensure that the Oracle software owner user (typically oracle) has permissions to create or
                            write to the Oracle home path that you specify when you run the installer.
                      3.    On each installation screen, specify the required information.
                      4.    When the installer displays the Summary screen, perform the following steps:
                            a.   Click Save Response File. In the window, specify a file name and location for the new
                                 response file. Click Save to write the responses you entered to the response file.
                            b.   Click Finish to continue with the installation.
                                 Click Cancel if you do not want to continue with the installation. The installation stops,
                                 but the recorded response file is retained.


                                     Note
                                     Ensure that your response file name has the .rsp suffix.

                      5.    Before you use the saved response file on another system, edit the file and make any
                            required changes. Use the instructions in the file as a guide when editing it.


Running Oracle Universal Installer Using a Response File
                      After creating the response file, run Oracle Universal Installer at the command line, specifying
                      the response file you created, to perform the installation.
                      Run Oracle Universal Installer at the command line, specifying the response file you created.
                      The Oracle Universal Installer executables, runInstaller and gridSetup.sh, provide
                      several options. For help information on the full set of these options, run the gridSetup.sh or
                      runInstaller command with the -help option. For example:

                      •     For Oracle Database:

                            $ $ORACLE_HOME/runInstaller -help




Database Installation Guide
E96434-12                                                                                                           April 30, 2026
Copyright © 2015, 2026, Oracle and/or its affiliates.                                                         Appendix A-5 of A-14
                                                                                                                        Appendix A
                                                                           Running Oracle Universal Installer Using a Response File


                      •     For Oracle Grid Infrastructure:

                            $ /u01/app/oracle/product/19.0.0/grid/gridSetup.sh -help

                      The help information appears in a window after some time.
                      To run the installer using a response file:
                      1.    Complete the preinstallation tasks for a normal installation.
                      2.    Log in as the software installation owner user.
                      3.    If you are completing a response file mode installation, then set the operating system
                            DISPLAY environment variable for the user running the installation.


                                     Note
                                     You do not have to set the DISPLAY environment variable if you are completing a
                                     silent mode installation.


                      4.    To start the installer in silent or response file mode, enter a command similar to the
                            following:
                            •    For Oracle Database:

                                 $ $ORACLE_HOME/runInstaller [-silent] \
                                  -responseFile responsefilename

                            •    For Oracle Grid Infrastructure:

                                 $ /u01/app/oracle/product/19.0.0/grid/gridSetup.sh [-silent] \
                                  -responseFile responsefilename



                                     Note
                                     Do not specify a relative path to the response file. If you specify a relative path,
                                     then the installer fails.



                            In this example:
                            •    -silent runs the installer in silent mode.
                            •    responsefilename is the full path and file name of the installation response file that you
                                 configured.
                      5.    If this is the first time you are installing Oracle software on your system, then Oracle
                            Universal Installer prompts you to run the orainstRoot.sh script.
                            Log in as the root user and run the orainstRoot.sh script:

                            $ su root
                            password:
                            # /u01/app/oraInventory/orainstRoot.sh




Database Installation Guide
E96434-12                                                                                                           April 30, 2026
Copyright © 2015, 2026, Oracle and/or its affiliates.                                                         Appendix A-6 of A-14
                                                                                                                         Appendix A
                                                                              Running Configuration Assistants Using Response Files



                                     Note
                                     You do not have to manually create the oraInst.loc file. Running the
                                     orainstRoot.sh script is sufficient as it specifies the location of the Oracle
                                     Inventory directory.

                      6.    When the installation completes, log in as the root user and run the root.sh script. For
                            example:
                            $ su root
                            password:
                            # $ORACLE_HOME/root.sh


Running Configuration Assistants Using Response Files
                      You can run configuration assistants in response file or silent mode to configure and start
                      Oracle software after it is installed on the system. To run configuration assistants in response
                      file or silent mode, you must copy and edit a response file template.


                                Note
                                If you copied the software to a hard disk, then the response file template is located in
                                the $ORACLE_HOME/install/response directory.



                      •     Running Net Configuration Assistant Using Response Files
                            You can run NETCA in silent mode to configure and start an Oracle Net Listener on the
                            system, and configure naming methods and Oracle Net service names.
                      •     Running Oracle DBCA Using Response Files
                            You can run Oracle Database Configuration Assistant (Oracle DBCA) in response file
                            mode to configure and start an Oracle database on the system.


Running Net Configuration Assistant Using Response Files
                      You can run NETCA in silent mode to configure and start an Oracle Net Listener on the
                      system, and configure naming methods and Oracle Net service names.
                      To run Oracle Net Configuration Assistant (NETCA) in silent mode, you must copy and edit a
                      response file template. Oracle provides a response file template named netca.rsp in
                      the $ORACLE_HOME/assistants/netca directory.

                      To run Net Configuration Assistant using a response file:
                      1.    Copy the netca.rsp response file template from the response file directory to a directory
                            on your system:

                            $ cp $ORACLE_HOME/assistants/netca/netca.rsp local_directory

                      2.    Open the response file in a text editor:

                            $ vi /local_directory/netca.rsp

                      3.    Follow the instructions in the file to edit it.


Database Installation Guide
E96434-12                                                                                                            April 30, 2026
Copyright © 2015, 2026, Oracle and/or its affiliates.                                                          Appendix A-7 of A-14
                                                                                                                          Appendix A
                                                                               Running Configuration Assistants Using Response Files



                                     Note
                                     Net Configuration Assistant fails if you do not correctly configure the response file.

                      4.    Log in as the Oracle software owner user, and set the ORACLE_HOME environment variable
                            to specify the correct Oracle home directory.
                      5.    Enter a command similar to the following to run Net Configuration Assistant in silent mode:

                            $ $ORACLE_HOME/bin/netca -silent -responsefile /local_directory/netca.rsp


                            In this command:
                            •    The /silent option indicates to run Net Configuration Assistant in silent mode.
                            •    local_directory is the full path of the directory where you copied the netca.rsp
                                 response file template.


Running Oracle DBCA Using Response Files
                      You can run Oracle Database Configuration Assistant (Oracle DBCA) in response file mode to
                      configure and start an Oracle database on the system.
                      To run Oracle DBCA in response file mode, you must copy and edit a response file template.
                      Oracle provides a response file template named dbca.rsp in the ORACLE_HOME/
                      assistants/dbca directory. To run Oracle DBCA in response file mode, you must use the -
                      responseFile flag in combination with the -silent flag. You must also use a graphical
                      display and set the DISPLAY environment variable.

                      To run Oracle DBCA in response file mode:
                      1.    Copy the dbca.rsp response file template from the response file directory to a directory
                            on your system:

                            $ cp /directory_path/assistants/dbca/dbca.rsp local_directory


                            In this example, directory_path is the path of the directory where you have copied the
                            installation binaries.
                            As an alternative to editing the response file template, you can also create a database by
                            specifying all required information as command line options when you run Oracle DBCA.
                            For information about the list of options supported, enter the following command:

                            $ $ORACLE_HOME/bin/dbca -help

                      2.    Open the response file in a text editor:

                            $ vi /local_dir/dbca.rsp

                      3.    Follow the instructions in the file to edit the file.


                                     Note
                                     Oracle DBCA fails if you do not correctly configure the response file.



Database Installation Guide
E96434-12                                                                                                             April 30, 2026
Copyright © 2015, 2026, Oracle and/or its affiliates.                                                           Appendix A-8 of A-14
                                                                                                                           Appendix A
                                                        Postinstallation Configuration Using Response File Created During Installation


                      4.    Log in as the Oracle software owner user, and set the ORACLE_HOME environment variable
                            to specify the correct Oracle home directory.
                      5.    To run Oracle DBCA in response file mode, set the DISPLAY environment variable.
                      6.    Use the following command syntax to run Oracle DBCA in silent or response file mode
                            using a response file:

                            $ORACLE_HOME/bin/dbca [-silent] -createDatabase -responseFile /local_dir/
                            dbca.rsp


                            In this example:
                            •    -silent option indicates that Oracle DBCA runs in silent mode.
                            •    local_dir is the full path of the directory where you copied the dbca.rsp response
                                 file template.
                            During configuration, Oracle DBCA displays a window that contains the status messages
                            and a progress bar.


Postinstallation Configuration Using Response File Created
During Installation
                      Use response files to configure Oracle software after installation. You can use the same
                      response file created during installation to also complete postinstallation configuration.
                      •     Using the Installation Response File for Postinstallation Configuration
                            Starting with Oracle Database 12c release 2 (12.2), you can use the response file created
                            during installation to also complete postinstallation configuration.
                      •     Running Postinstallation Configuration Using Response File
                            You can use a response file to complete postinstallation tasks on one or more servers
                            simultaneously.


Using the Installation Response File for Postinstallation Configuration
                      Starting with Oracle Database 12c release 2 (12.2), you can use the response file created
                      during installation to also complete postinstallation configuration.
                      Run the installer with the -executeConfigTools option to configure configuration assistants
                      after installing Oracle Grid Infrastructure or Oracle Database. You can use the response file
                      located at $ORACLE_HOME/install/response/product_timestamp.rsp to obtain the
                      passwords required to run the configuration tools. You must update the response file with the
                      required passwords before running the -executeConfigTools command.

                      Oracle strongly recommends that you maintain security with a password response file:
                      •     Permissions on the response file should be set to 600.
                      •     The owner of the response file should be the installation owner user, with the group set to
                            the central inventory (oraInventory) group.
                      Example A-1          Response File Passwords for Oracle Grid Infrastructure (grid user)

                      grid.install.crs.config.ipmi.bmcPassword=password
                      grid.install.asm.SYSASMPassword=password



Database Installation Guide
E96434-12                                                                                                              April 30, 2026
Copyright © 2015, 2026, Oracle and/or its affiliates.                                                            Appendix A-9 of A-14
                                                                                                                           Appendix A
                                                        Postinstallation Configuration Using Response File Created During Installation


                      grid.install.asm.monitorPassword=password
                      grid.install.config.emAdminPassword=password


                      If you do not have a BMC card, or you do not want to enable IPMI, then leave the
                      ipmi.bmcPassword input field blank.

                      If you do not want to enable Oracle Enterprise Manager for management, then leave the
                      emAdminPassword password field blank.

                      Example A-2 Response File Passwords for Oracle Grid Infrastructure for a Standalone
                      Server (oracle user)

                      oracle.install.asm.SYSASMPassword=password
                      oracle.install.asm.monitorPassword=password
                      oracle.install.config.emAdminPassword=password


                      If you do not want to enable Oracle Enterprise Manager for management, then leave the
                      emAdminPassword password field blank.

                      Example A-3          Response File Passwords for Oracle Database (oracle user)

                      This example illustrates the passwords to specify for use with the database configuration
                      assistants.

                      oracle.install.db.config.starterdb.password.SYS=password
                      oracle.install.db.config.starterdb.password.SYSTEM=password
                      oracle.install.db.config.starterdb.password.DBSNMP=password
                      oracle.install.db.config.starterdb.password.PDBADMIN=password
                      oracle.install.db.config.starterdb.emAdminPassword=password
                      oracle.install.db.config.asm.ASMSNMPPassword=password


                      You can also specify oracle.install.db.config.starterdb.password.ALL=password to use
                      the same password for all database users.
                      The database configuration assistants require the SYS, SYSTEM, and DBSNMP passwords
                      for use with Oracle DBCA. You must specify the following passwords, depending on your
                      system configuration:
                      •     If the database uses Oracle Automatic Storage Management (Oracle ASM) for storage,
                            then you must specify a password for the ASMSNMPPassword variable. If you are not using
                            Oracle ASM, then leave the value for this password variable blank.
                      •     If you create a multitenant container database (CDB) with one or more pluggable
                            databases (PDBs), then you must specify a password for the PDBADMIN variable. If you are
                            not using Oracle ASM, then leave the value for this password variable blank.


Running Postinstallation Configuration Using Response File
                      You can use a response file to complete postinstallation tasks on one or more servers
                      simultaneously.
                      Complete this procedure to run configuration assistants with the executeConfigTools
                      command and a response file.
                      1.    Edit the response file and specify the required passwords for your configuration. You can
                            use the response file created during installation, located at $ORACLE_HOME/install/
                            response/product_timestamp.rsp. For example:


Database Installation Guide
E96434-12                                                                                                             April 30, 2026
Copyright © 2015, 2026, Oracle and/or its affiliates.                                                          Appendix A-10 of A-14
                                                                                                                           Appendix A
                                                        Postinstallation Configuration Using Response File Created During Installation


                            For Oracle Database (oracle user)

                            oracle.install.asm.SYSASMPassword=password
                            oracle.install.config.emAdminPassword=password


                            For Oracle Grid Infrastructure (grid user)

                            grid.install.asm.SYSASMPassword=password
                            grid.install.config.emAdminPassword=password

                      2.    Change directory to the Oracle home containing the installation software. For example:
                            For Oracle Grid Infrastructure:

                            cd Grid_home


                            Where, Grid_home is the path to the Oracle Grid Infrastructure home directory /u01/app/
                            oracle/product/19.0.0/grid
                            For Oracle Database:

                            cd $ORACLE_HOME

                      3.    Run the configuration script using the following syntax:
                            For Oracle Grid Infrastructure:

                            $ ./gridSetup.sh -executeConfigTools -responseFile Grid_home/install/
                            response/product_timestamp.rsp


                            For Oracle Database:

                            $ ./runInstaller -executeConfigTools -responseFile $ORACLE_HOME/install/
                            response/product_timestamp.rsp


                            For Oracle Database, you can also run the response file located in the
                            directory $ORACLE_HOME/inventory/response/:

                            $ ./runInstaller -executeConfigTools -responseFile $ORACLE_HOME/inventory/
                            response/db_install.rsp


                            The postinstallation configuration tool runs the installer in the graphical user interface
                            mode, displaying the progress of the postinstallation configuration. Specify the [-
                            silent] option to run the postinstallation configuration in the silent mode.
                            For example, for Oracle Grid Infrastructure:

                            $ ./gridSetup.sh -executeConfigTools -responseFile /u01/app/oracle/product/
                            19.0.0/grid/response/grid_2016-01-09_01-03-36PM.rsp [-silent]




Database Installation Guide
E96434-12                                                                                                              April 30, 2026
Copyright © 2015, 2026, Oracle and/or its affiliates.                                                           Appendix A-11 of A-14
                                                                                                                        Appendix A
                                                              Postinstallation Configuration Using the ConfigToolAllCommands Script


                            For Oracle Database:

                            $ ./runInstaller -executeConfigTools -responseFile /u01/app/oracle/product/
                            19.0.0/dbhome_1/inventory/response/db_2016-01-09_01-03-36PM.rsp [-silent]


Postinstallation Configuration Using the ConfigToolAllCommands
Script
                      You can create and run a response file configuration after installing Oracle software. The
                      configToolAllCommands script requires users to create a second response file, of a
                      different format than the one used for installing the product.
                      Starting with Oracle Database 12c Release 2 (12.2), the configToolAllCommands script is
                      deprecated and may be desupported in a future release.
                      •     About the Postinstallation Configuration File
                            When you run a silent or response file installation, you provide information about your
                            servers in a response file that you otherwise provide manually during a graphical user
                            interface installation.
                      •     Creating a Password Response File
                            You can create a password response file and use it with configuration assistants to perform
                            silent installation.
                      •     Running Postinstallation Configuration Using a Password Response File
                            Complete this procedure to run configuration assistants with the
                            configToolAllCommands script.


About the Postinstallation Configuration File
                      When you run a silent or response file installation, you provide information about your servers
                      in a response file that you otherwise provide manually during a graphical user interface
                      installation.
                      However, the response file does not contain passwords for user accounts that configuration
                      assistants require after software installation is complete. The configuration assistants are
                      started with a script called configToolAllCommands. You can run this script in response file
                      mode by using a password response file. The script uses the passwords to run the
                      configuration tools in succession to complete configuration.
                      If you keep the password file to use for clone installations, then Oracle strongly recommends
                      that you store the password file in a secure location. In addition, if you have to stop an
                      installation to fix an error, then you can run the configuration assistants using
                      configToolAllCommands and a password response file.

                      The configToolAllCommands password response file has the following syntax options:

                      •     oracle.crs for Oracle Grid Infrastructure components or oracle.server for Oracle
                            Database components that the configuration assistants configure
                      •     variable_name is the name of the configuration file variable
                      •     value is the desired value to use for configuration.
                      The command syntax is as follows:
                      internal_component_name|variable_name=value



Database Installation Guide
E96434-12                                                                                                           April 30, 2026
Copyright © 2015, 2026, Oracle and/or its affiliates.                                                        Appendix A-12 of A-14
                                                                                                                        Appendix A
                                                              Postinstallation Configuration Using the ConfigToolAllCommands Script


                      For example:

                      oracle.crs|S_ASMPASSWORD=PassWord


                      The database configuration assistants require the SYS, SYSTEM, and DBSNMP passwords
                      for use with Oracle DBCA. You may need to specify the following additional passwords,
                      depending on your system configuration:
                      •     If the database is using Oracle Automatic Storage Management (Oracle ASM) for storage,
                            then you must specify a password for the S_ASMSNMPPASSWORD variable. If you are not using
                            Oracle ASM, then leave the value for this password variable blank.
                      •     If you create a multitenant container database (CDB) with one or more pluggable
                            databases (PDBs), then you must specify a password for the S_PDBADMINPASSWORD
                            variable. If you are not using Oracle ASM, then leave the value for this password variable
                            blank.
                      Oracle strongly recommends that you maintain security with a password response file:
                      •     Permissions on the response file should be set to 600.
                      •     The owner of the response file should be the installation owner user, with the group set to
                            the central inventory (oraInventory) group.


Creating a Password Response File
                      You can create a password response file and use it with configuration assistants to perform
                      silent installation.
                      Perform the following steps to create a password response file:
                      1.    Create a response file that has a name of the format filename.properties, for example:

                            $ touch pwdrsp.properties

                      2.    Open the file with a text editor, and cut and paste the sample password file contents, as
                            shown in the examples, modifying as needed.
                      3.    Change permissions to secure the password response file. For example:

                            $ ls -al pwdrsp.properties
                            -rw------- 1 oracle oinstall 0 Apr 30 17:30 pwdrsp.properties

                      Example A-4          Password response file for Oracle Grid Infrastructure (grid user)

                      grid.crs|S_ASMPASSWORD=password
                      grid.crs|S_OMSPASSWORD=password
                      grid.crs|S_BMCPASSWORD=password
                      grid.crs|S_ASMMONITORPASSWORD=password


                      If you do not have a BMC card, or you do not want to enable IPMI, then leave the
                      S_BMCPASSWORD input field blank.




Database Installation Guide
E96434-12                                                                                                           April 30, 2026
Copyright © 2015, 2026, Oracle and/or its affiliates.                                                        Appendix A-13 of A-14
                                                                                                                       Appendix A
                                                             Postinstallation Configuration Using the ConfigToolAllCommands Script


                      Example A-5 Password response file for Oracle Grid Infrastructure for a Standalone
                      Server (oracle user)

                      oracle.crs|S_ASMPASSWORD=password
                      oracle.crs|S_OMSPASSWORD=password
                      oracle.crs|S_ASMMONITORPASSWORD=password


                      Example A-6          Password response file for Oracle Database (oracle user)

                      This example provides a template for a password response file to use with the database
                      configuration assistants.

                      oracle.server|S_SYSPASSWORD=password
                      oracle.server|S_SYSTEMPASSWORD=password
                      oracle.server|S_EMADMINPASSWORD=password
                      oracle.server|S_DBSNMPPASSWORD=password
                      oracle.server|S_ASMSNMPPASSWORD=password
                      oracle.server|S_PDBADMINPASSWORD=password


                      If you do not want to enable Oracle Enterprise Manager for management, then leave those
                      password fields blank.


Running Postinstallation Configuration Using a Password Response File
                      Complete this procedure to run configuration assistants with the configToolAllCommands
                      script.
                      1.    Create a password response file as described in Creating a Password File.
                      2.    Change directory to $ORACLE_HOME/cfgtoollogs.
                      3.    Run the configuration script using the following syntax:

                            configToolAllCommands RESPONSE_FILE=/path/name.properties


                            For example:

                            $ ./configToolAllCommands RESPONSE_FILE=/home/oracle/pwdrsp.properties




Database Installation Guide
E96434-12                                                                                                          April 30, 2026
Copyright © 2015, 2026, Oracle and/or its affiliates.                                                       Appendix A-14 of A-14
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
                      •     About the Oracle Inventory Directory and Installation
                            The directory that you designate as the Oracle Inventory directory (oraInventory) stores an
                            inventory of all software installed on the system.
                      •     Oracle Base Directory Naming Convention
                            The Oracle Base directory is the database home directory for Oracle Database installation
                            owners, and the log file location for Oracle Grid Infrastructure owners.
                      •     Oracle Home Directory Naming Convention
                            By default, Oracle Universal Installer configures Oracle home directories using these
                            Oracle Optimal Flexible Architecture conventions.
                      •     Optimal Flexible Architecture File Path Examples
                            Review examples of hierarchical file mappings of an Optimal Flexible Architecture-
                            compliant installation.


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
                      configure all Oracle components in accordance with OFA guidelines.
                      Oracle recommends that you accept the OFA default. Following OFA rules is especially of
                      value if the database is large, or if you plan to have multiple databases.




Database Installation Guide
E96434-12                                                                                                   April 30, 2026
Copyright © 2015, 2026, Oracle and/or its affiliates.                                                  Appendix B-1 of B-8
                                                                                                                  Appendix B
                                                                                         About Multiple Oracle Homes Support



                                Note
                                OFA assists in identification of an ORACLE_BASE with its Automatic Diagnostic
                                Repository (ADR) diagnostic data to properly collect incidents.




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
                      •     Multiple databases, of different versions, owned by different users can coexist concurrently.
                      •     To install Oracle Database software in multiple Oracle homes, you must extract the image
                            file in each Oracle home, and then run the setup wizard from the respective Oracle home.
                      •     You must install a new Oracle Database release in a new Oracle home that is separate
                            from earlier releases of Oracle Database.
                            You cannot install multiple releases in one Oracle home. Oracle recommends that you
                            create a separate Oracle Database Oracle home for each release, in accordance with the
                            Optimal Flexible Architecture (OFA) guidelines.
                      •     In production, the Oracle Database server software release is the release number in the
                            format of major and RU release number. For example, with the release number 19.3.0.0.0,
                            the major release is 19 and the RU release number is 3.
                      •     Later Oracle Database releases can access earlier Oracle Database releases. However,
                            this access is only for upgrades. For example, Oracle Database 19c can access an Oracle
                            Database 18c if the 18c database is started up in upgrade mode.
                      •     Structured organization of directories and files, and consistent naming for database files
                            simplify database administration.
                      •     Login home directories are not at risk when database administrators add, move, or delete
                            Oracle home directories.
                      •     For information about release support timelines, refer to My Oracle Support Doc ID
                            742060.1
                      Related Topics
                      •     My Oracle Support Note 742060.1


About the Oracle Inventory Directory and Installation
                      The directory that you designate as the Oracle Inventory directory (oraInventory) stores an
                      inventory of all software installed on the system.
                      All Oracle software installation owners on a server are granted the OINSTALL privileges to
                      read and write to this directory. If you have previous Oracle software installations on a server,


Database Installation Guide
E96434-12                                                                                                     April 30, 2026
Copyright © 2015, 2026, Oracle and/or its affiliates.                                                    Appendix B-2 of B-8
                                                                                                                      Appendix B
                                                                            About the Oracle Inventory Directory and Installation


                      then additional Oracle software installations detect this directory from the /var/opt/oracle/
                      oraInst.loc file, and continue to use that Oracle Inventory. Ensure that the group
                      designated as the OINSTALL group is available as a primary group for all planned Oracle
                      software installation owners.
                      If you are installing Oracle software for the first time, then OUI creates an Oracle base and
                      central inventory, and creates an Oracle inventory using information in the following priority:
                      •     In the path indicated in the ORACLE_BASE environment variable set for the installation
                            owner user account
                      •     In an Optimal Flexible Architecture (OFA) path (u[01–99]/app/owner where owner is the
                            name of the user account running the installation), and that user account has permissions
                            to write to that path
                      •     In the user home directory, in the path /app/owner, where owner is the name of the user
                            account running the installation
                      For example:
                      If you are performing an Oracle Database installation, and you set ORACLE_BASE for user
                      oracle to the path /u01/app/oracle before installation, and grant 755 permissions to
                      oracle for that path, then Oracle Universal Installer creates the Oracle Inventory directory one
                      level above the ORACLE_BASE in the path ORACLE_BASE/../oraInventory, so the
                      Oracle Inventory path is /u01/app/oraInventory. Oracle Universal Installer installs the
                      software in the ORACLE_BASE path. If you are performing an Oracle Grid Infrastructure for a
                      Cluster installation, then the Grid installation path is changed to root ownership after
                      installation, and the Grid home software location should be in a different path from the Grid
                      user Oracle base.
                      If you create the OFA path /u01, and grant oracle 755 permissions to write to that path, then
                      the Oracle Inventory directory is created in the path /u01/app/oraInventory, and Oracle
                      Universal Installer creates the path /u01/app/oracle, and configures the ORACLE_BASE
                      environment variable for the Oracle user to that path. If you are performing an Oracle
                      Database installation, then the Oracle home is installed under the Oracle base. However, if you
                      are installing Oracle Grid Infrastructure for a cluster, then be aware that ownership of the path
                      for the Grid home is changed to root after installation and the Grid base and Grid home should
                      be in different locations, such as /u01/app/19.0.0/grid for the Grid home path,
                      and /u01/app/grid for the Grid base. For example:

                      /u01/app/oraInventory, owned by grid:oinstall
                      /u01/app/oracle, owned by oracle:oinstall
                      /u01/app/oracle/product/19.0.0/dbhome_1/, owned by oracle:oinistall
                      /u01/app/grid, owned by grid:oinstall
                      /u01/app/19.0.0/grid, owned by root

                      If you have neither set ORACLE_BASE, nor created an OFA-compliant path, then the Oracle
                      Inventory directory is placed in the home directory of the user that is performing the installation,
                      and the Oracle software is installed in the path /app/owner, where owner is the Oracle
                      software installation owner. For example:

                      /home/oracle/oraInventory
                      /home/oracle/app/oracle/product/19.0.0/dbhome_1




Database Installation Guide
E96434-12                                                                                                         April 30, 2026
Copyright © 2015, 2026, Oracle and/or its affiliates.                                                        Appendix B-3 of B-8
                                                                                                                          Appendix B
                                                                                             Oracle Base Directory Naming Convention




Oracle Base Directory Naming Convention
                      The Oracle Base directory is the database home directory for Oracle Database installation
                      owners, and the log file location for Oracle Grid Infrastructure owners.
                      Name Oracle base directories using the syntax /pm/h/u, where pm is a string mount point
                      name, h is selected from a small set of standard directory names, and u is the name of the
                      owner of the directory.
                      You can use the same Oracle base directory for multiple installations. If different operating
                      system users install Oracle software on the same system, then you must create a separate
                      Oracle base directory for each installation owner. For ease of administration, Oracle
                      recommends that you create a unique owner for each Oracle software installation owner, to
                      separate log files.
                      Because all Oracle installation owners write to the central Oracle inventory file, and that file
                      mountpoint is in the same mount point path as the initial Oracle installation, Oracle
                      recommends that you use the same /pm/h path for all Oracle installation owners.

                      Table B-1       Examples of OFA-Compliant Oracle Base Directory Names

                       Example                  Description
                                                Oracle Database Oracle base, where the Oracle Database software installation
                       /u01/app/                owner name is oracle. The Oracle Database binary home is located underneath
                       oracle                   the Oracle base path.


                                                Oracle Grid Infrastructure Oracle base, where the Oracle Grid Infrastructure
                       /u01/app/grid            software installation owner name is grid.
                                                Caution: The Oracle Grid Infrastructure Oracle base should not contain the Oracle
                                                Grid Infrastructure binaries for an Oracle Grid Infrastructure installation.
                                                Permissions for the file path to the Oracle Grid Infrastructure binary home are
                                                changed to root during installation.



                                Note
                                Oracle home or Oracle base cannot be symlinks, nor can any of their parent
                                directories, all the way to up to the root directory.



Oracle Home Directory Naming Convention
                      By default, Oracle Universal Installer configures Oracle home directories using these Oracle
                      Optimal Flexible Architecture conventions.
                      The directory pattern syntax for Oracle homes is /pm/s/u/product/v/type_[n]. The following table
                      describes the variables used in this syntax:


                       Variable                 Description
                       pm                       A mount point name.
                       s                        A standard directory name.



Database Installation Guide
E96434-12                                                                                                              April 30, 2026
Copyright © 2015, 2026, Oracle and/or its affiliates.                                                             Appendix B-4 of B-8
                                                                                                                           Appendix B
                                                                                      Optimal Flexible Architecture File Path Examples




                       Variable                 Description
                       u                        The name of the owner of the directory.
                       v                        The version of the software.
                       type                     The type of installation. For example: Database (dbhome), Client (client), or
                                                Oracle Grid Infrastructure (grid)
                       n                        An optional counter, which enables you to install the same product more than once
                                                in the same Oracle base directory. For example: Database 1 and Database 2
                                                (dbhome_1, dbhome_2)

                      For example, the following path is typical for the first installation of Oracle Database on this
                      system:

                      /u01/app/oracle/product/19.0.0/dbhome_1



                                Note
                                Oracle home or Oracle base cannot be symlinks, nor can any of their parent
                                directories, all the way to up to the root directory.



Optimal Flexible Architecture File Path Examples
                      Review examples of hierarchical file mappings of an Optimal Flexible Architecture-compliant
                      installation.
                      /u02/u03 /u04


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




                                Caution
                                Refrain from placing any private or application files under the Optimal Flexible
                                Architecture file directories such as Oracle base, Oracle home, and OraInventory.




Database Installation Guide
E96434-12                                                                                                              April 30, 2026
Copyright © 2015, 2026, Oracle and/or its affiliates.                                                             Appendix B-5 of B-8
                                                                                                                                Appendix B
                                                                                           Optimal Flexible Architecture File Path Examples



                      Table B-2       Optimal Flexible Architecture Hierarchical File Path Examples

                       Directory                        Description
                                                        Root directory
                       /


                                                        User data mount point 1
                       /u01/


                                                        Subtree for application software
                       /u01/app/


                                                        Central OraInventory directory, which maintains information about Oracle
                       /u01/app/                        installations on a server. Members of the group designated as the OINSTALL
                       oraInventory                     group have permissions to write to the central inventory. All Oracle software
                                                        installation owners must have the OINSTALL group as their primary group,
                                                        and be able to write to this group.
                                                        Oracle base directory for user oracle. There can be many Oracle Database
                       /u01/app/oracle/                 installations on a server, and many Oracle Database software installation
                                                        owners.
                                                        Oracle software homes that an Oracle installation owner owns should be
                                                        located in the Oracle base directory for the Oracle software installation owner,
                                                        unless that Oracle software is Oracle Grid Infrastructure deployed for a
                                                        cluster.
                                                        Oracle base directory for user grid. The Oracle home (Grid home) for Oracle
                       /u01/app/grid                    Grid Infrastructure installation is located outside of the Grid user. There can
                                                        be only one Grid home on a server, and only one Grid software installation
                                                        owner.
                                                        The Grid home contains log files and other administrative files.
                                                        Subtree for database administration files
                       /u01/app/oracle/
                       admin/


                                                        Subtree for support log files
                       /u01/app/oracle/
                       admin/TAR


                                                        Admin subtree for database named “sales”
                       /u01/app/oracle/
                       admin/db_sales/


                                                        Admin subtree for database named “dwh”
                       /u01/app/oracle/
                       admin/db_dwh/




Database Installation Guide
E96434-12                                                                                                                   April 30, 2026
Copyright © 2015, 2026, Oracle and/or its affiliates.                                                                  Appendix B-6 of B-8
                                                                                                                             Appendix B
                                                                                        Optimal Flexible Architecture File Path Examples



                      Table B-2       (Cont.) Optimal Flexible Architecture Hierarchical File Path Examples

                       Directory                        Description
                                                        Subtree for recovery files
                       /u01/app/oracle/
                       fast_recovery_are
                       a/


                                                        Recovery files for database named “sales”
                       /u01/app/oracle/
                       fast_recovery_are
                       a/db_sales


                                                        Recovery files for database named “dwh”
                       /u01/app/oracle/
                       fast_recovery_are
                       a/db_dwh


                                                        Oracle data file directories
                       /u02/app/oracle/
                       oradata
                       /u03/app/oracle/
                       oradata
                       /u04/app/oracle/
                       oradata


                                                        Common path for Oracle software products other than Oracle Grid
                       /u01/app/oracle/                 Infrastructure for a cluster
                       product/


                                                        Oracle home directory for Oracle Database 1, owned by Oracle Database
                       /u01/app/oracle/                 installation owner account oracle
                       product/19.0.0/
                       dbhome_1


                                                        Oracle home directory for Oracle Database 2, owned by Oracle Database
                       /u01/app/oracle/                 installation owner account oracle
                       product/19.0.0/
                       dbhome_2


                                                        Oracle home directory for Oracle Database 2, owned by Oracle Database
                       /u01/app/oracle2/                installation owner account oracle2
                       product/19.0.0/
                       dbhome_2




Database Installation Guide
E96434-12                                                                                                                April 30, 2026
Copyright © 2015, 2026, Oracle and/or its affiliates.                                                               Appendix B-7 of B-8
                                                                                                                               Appendix B
                                                                                          Optimal Flexible Architecture File Path Examples



                      Table B-2       (Cont.) Optimal Flexible Architecture Hierarchical File Path Examples

                       Directory                        Description
                                                        Oracle home directory for Oracle Grid Infrastructure for a standalone server,
                       /u01/app/oracle/                 owned by Oracle Database and Oracle Grid Infrastructure installation owner
                       product/19.0.0/                  oracle.
                       grid


                                                        Oracle home directory for Oracle Grid Infrastructure for a cluster (Grid home),
                       /u01/app/19.0.0/                 owned by user grid before installation, and owned by root after installation.
                       grid


                                                        Oracle home directory for Oracle Database Client 1, owned by Oracle
                       /u01/app/oracle/                 Database installation owner account oracle
                       product/19.0.0/
                       client_1




Database Installation Guide
E96434-12                                                                                                                  April 30, 2026
Copyright © 2015, 2026, Oracle and/or its affiliates.                                                                 Appendix B-8 of B-8
C
Configuring Read-Only Oracle Homes
                      Understand how read-only Oracle homes work and how you can configure read-only Oracle
                      homes.
                      •     Evolution of Oracle Homes
                            Learn about read-only Oracle home concepts like Oracle base home, Oracle base config,
                            and orabasetab.
                      •     Enabling a Read-Only Oracle Home
                            Configure your Oracle home as a read-only Oracle home after you have performed a
                            software-only Oracle Database installation.
                      •     Copying demo Directories to Oracle Base Home
                            In a read-only mode ORACLE_HOME, you must copy the demo directories listed in this
                            topic from ORACLE_HOME to ORACLE_BASE_HOME.
                      •     Determining if an Oracle Home is Read-Only
                            Run the orabasehome command to determine if your Oracle home is a read/write or read-
                            only Oracle home.
                      •     File Path and Directory Changes in Read-Only Oracle Homes
                            Examples of hierarchical file mappings in a read-only Oracle home as compared to a read/
                            write Oracle home.


Evolution of Oracle Homes
                      Learn about read-only Oracle home concepts like Oracle base home, Oracle base config, and
                      orabasetab.

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
                      •     About orabasetab
                            The orabasetab file is used to define fundamental directories based
                            on $ORACLE_HOME, ORACLE_BASE, ORACLE_BASE_HOME and
                            ORACLE_BASE_CONFIG.




Database Installation Guide
E96434-12                                                                                                April 30, 2026
Copyright © 2015, 2026, Oracle and/or its affiliates.                                              Appendix C-1 of C-10
                                                                                                               Appendix C
                                                                                                Evolution of Oracle Homes



About Read-Only Oracle Homes
                      Starting with Oracle Database 18c, you can configure an Oracle home in read-only mode. A
                      read-only Oracle home does not imply that the file system and the Oracle home is in read-only
                      mode. The file system and mount point should always be in read/write mode.
                      A read-only Oracle home simplifies provisioning by implementing separation of installation and
                      configuration.
                      In a read-only Oracle home, the configuration data and log files reside outside of the read-only
                      Oracle home. See, File Path and Directory Changes in Read-Only Oracle Homes.
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
                      ORACLE_BASE/homes/HOME_NAME.
                      Where, HOME_NAME is the internal name for ORACLE_HOME.
                      For example, the networking directories network/admin, network/trace, and
                      network/log are located in the ORACLE_BASE_HOME directory. In a read/write
                      ORACLE_HOME the networking directories appear to be in ORACLE_HOME because
                      ORACLE_BASE_HOME is co-located with ORACLE_HOME, whereas in a read-only
                      ORACLE_HOME the networking directories are located in ORACLE_BASE/homes/
                      HOME_NAME.
                      To print the ORACLE_BASE_HOME path, run the orabasehome command from
                      the $ORACLE_HOME/bin directory:

                      $ setenv ORACLE_HOME /u01/app/oracle/product/19.0.0/dbhome_1
                      $ cd $ORACLE_HOME/bin
                      $ ./orabasehome




Database Installation Guide
E96434-12                                                                                                  April 30, 2026
Copyright © 2015, 2026, Oracle and/or its affiliates.                                                Appendix C-2 of C-10
                                                                                                             Appendix C
                                                                                              Evolution of Oracle Homes


                      For example:

                      $ ./orabasehome
                      /u01/app/oracle/homes/OraDB19Home1


                      Where, /u01/app/oracle is ORACLE_BASE and OraDB19Home1 is HOME_NAME


About Oracle Base Config
                      Both, in a read-only ORACLE_HOME and read/write ORACLE_HOME, the configuration files
                      reside in a location known as ORACLE_BASE_CONFIG.
                      In a read/write ORACLE_HOME, the ORACLE_BASE_CONFIG path is the same as the
                      ORACLE_HOME path because it is located at $ORACLE_HOME. However, in a read-only
                      ORACLE_HOME, the ORACLE_BASE_CONFIG path is the same as ORACLE_BASE.
                      ORACLE_BASE_CONFIG/dbs contains the configuration files for ORACLE_HOME. Each file in
                      the dbs directory contains $ORACLE_SID so that the directory can be shared by many
                      different ORACLE_SIDs.
                      To print the ORACLE_BASE_CONFIG path, run the orabaseconfig command from
                      the $ORACLE_HOME/bin directory:

                      $ setenv ORACLE_HOME /u01/app/oracle/product/19.0.0/dbhome_1
                      $ cd $ORACLE_HOME/bin
                      $ ./orabaseconfig


                      For example:

                      $ ./orabaseconfig
                      /u01/app/oracle


                      Where, /u01/app/oracle is ORACLE_BASE.


About orabasetab
                      The orabasetab file is used to define fundamental directories based on $ORACLE_HOME,
                      ORACLE_BASE, ORACLE_BASE_HOME and ORACLE_BASE_CONFIG.
                      The orabasetab file resides in ORACLE_HOME/install/orabasetab. To determine if an
                      ORACLE_HOME is read-only or read/write, you can check for the presence of the
                      orabasetab file. The orabasetab file also defines the ORACLE_BASE and the
                      HOME_NAME of the Oracle home. HOME_NAME is the internal name for ORACLE_HOME.
                      The last line in the orabasetab file, which starts with $ORACLE_HOME, defines the
                      directories for $ORACLE_HOME. The last line consists of four fields, each separate by a colon
                      delimiter(:).

                      1.    The first field matches the current $ORACLE_HOME.
                      2.    The second field defines the ORACLE_BASE for the current ORACLE_HOME.
                      3.    The third field defines the HOME_NAME which is used in constructing the
                            ORACLE_BASE_HOME path in a read-only ORACLE_HOME.




Database Installation Guide
E96434-12                                                                                                April 30, 2026
Copyright © 2015, 2026, Oracle and/or its affiliates.                                              Appendix C-3 of C-10
                                                                                                                   Appendix C
                                                                                            Enabling a Read-Only Oracle Home


                      4.    The fourth field displays N in a read/write ORACLE_HOME and Y in a read-only
                            ORACLE_HOME.
                      In a read-only ORACLE_HOME, the ORACLE_BASE_HOME path is ORACLE_BASE/homes/
                      HOME_NAME and ORACLE_BASE_CONFIG is the same as ORACLE_BASE.

                      In a read/write ORACLE_HOME, ORACLE_HOME, ORACLE_BASE_HOME and
                      ORACLE_BASE_CONFIG are all the same.

                      Viewing an orabasetab File
                      1.    Log in as the Oracle installation owner user account (oracle).
                      2.    Go to the $ORACLE_HOME/install directory.

                            $ cd /u01/app/oracle/product/19.0.0/dbhome_1/install

                      3.    View the contents of the orabasetab file.

                            $ cat orabasetab
                            /u01/app/oracle/product/19.0.0/dbhome_1:/u01/app/oracle:OraDB19Home1:Y:


                            In this example, a Y in the fourth field at the end of the line indicates you have a read-only
                            Oracle home.


Enabling a Read-Only Oracle Home
                      Configure your Oracle home as a read-only Oracle home after you have performed a software-
                      only Oracle Database installation.
                      To enable a read-only Oracle home:
                      1.    Perform a software-only Oracle Database installation.
                      2.    Run the roohctl -enable script.
                      3.    Run Oracle Database Configuration Assistant (Oracle DBCA) to create a database.


                                Note
                                Ensure that you enable read-only Oracle home before you create the database or
                                listener.


                      Software-Only Database Installation
                      1.    Log in as the Oracle installation owner user account (oracle) that you want to own the
                            software binaries.
                      2.    Download the Oracle Database installation image files (db_home.zip) to a directory of
                            your choice. For example, you can download the image files to the /tmp directory.
                      3.    Create the Oracle home directory and extract the image files that you have downloaded in
                            to this Oracle home directory. For example:

                            $ mkdir -p /u01/app/oracle/product/19.0.0/dbhome_1
                            $ chown oracle:oinstall /u01/app/oracle/product/19.0.0/dbhome_1



Database Installation Guide
E96434-12                                                                                                      April 30, 2026
Copyright © 2015, 2026, Oracle and/or its affiliates.                                                    Appendix C-4 of C-10
                                                                                                                   Appendix C
                                                                                            Enabling a Read-Only Oracle Home


                            $ cd /u01/app/oracle/product/19.0.0/dbhome_1
                            $ unzip -q /tmp/db_home.zip



                                     Note
                                     Ensure that the Oracle home directory path you create is in compliance with the
                                     Oracle Optimal Flexible Architecture recommendations. Also, unzip the installation
                                     image files only in this Oracle home directory that you created.

                      4.    From the Oracle home directory, run the runInstaller command to start the Oracle
                            Database installer.
                      5.    In the Select Configuration Option screen, select Set Up Software Only.
                      6.    Select your installation type. Installation screens vary depending on the installation option
                            you select. Respond to the configuration prompts as needed.


                                Note
                                Click Help if you have any questions about the information you are asked to submit
                                during installation.


                      Run the roohctl Script
                      1.    Go to the bin directory

                            $ cd /u01/app/oracle/product/19.0.0/dbhome_1/bin

                      2.    Run the roohctl script to enable read-only Oracle home.

                            $ ./roohctl -enable

                      3.    On Oracle Real Application Clusters (Oracle RAC) installations, run the preceding
                            roohctl script on every node of the cluster. Alternatively, run the roohctl script with the
                            nodelist option and provide the list of cluster nodes:

                            $ ./roohctl –enable –nodelist comma_separated_list_of_nodes

                      Run Oracle Database Configuration Assistant
                      1.    Ensure that you are still in the bin directory and run Oracle DBCA.

                            $ ./dbca

                      2.    In the Select Database Operation screen, select Create a Database.
                      3.    The configuration screens vary depending on the options you select. Respond to the
                            prompts as needed.




Database Installation Guide
E96434-12                                                                                                      April 30, 2026
Copyright © 2015, 2026, Oracle and/or its affiliates.                                                    Appendix C-5 of C-10
                                                                                                                  Appendix C
                                                                                Copying demo Directories to Oracle Base Home



                                Note
                                Click Help if you have any questions about the information you are asked to submit
                                during database creation.


                      Related Topics
                      •     Oracle Database 2 Day DBA


Copying demo Directories to Oracle Base Home
                      In a read-only mode ORACLE_HOME, you must copy the demo directories listed in this topic
                      from ORACLE_HOME to ORACLE_BASE_HOME.
                      Oracle Database contains various demo directories that include a variety of examples and
                      product demonstrations that you can use to learn about the products, options, and features of
                      Oracle Database. In a read-only mode ORACLE_HOME, you cannot use these demo
                      directories in ORACLE_HOME because writes are performed to these demo directories when
                      they are used.
                      Many of the demo directories are not available by default. You must install Oracle Database
                      Examples to view and use the examples and product demonstrations.
                      Copy the respective demo directory to the corresponding location in ORACLE_BASE_HOME.
                      Now, you can use this copy of the demo directory.

                      You must copy the following demo directories from ORACLE_HOME to
                      ORACLE_BASE_HOME:
                      •     jdbc/demo
                      •     odbc/demo
                      •     ord/http/demo
                      •     precomp/demo
                      •     rdbms/demo
                      •     sqlj/demo
                      •     sqlplus/demo
                      •     xdk/demo
                      You must also create symbolic links for the odbc/demo, precomp/demo, rdbms/demo, and
                      xdk/demo demo directories. See the "Creating Symbolic Links" section in this topic.

                      Copying demo Directories
                      For example, to copy the rdbms/demo directory from ORACLE_HOME to
                      ORACLE_BASE_HOME, perform the following:
                      1.    Login as the Oracle software owner user (oracle).
                      2.    Check if the rdbms/demo directory is copied to ORACLE_BASE_HOME.

                            $ ls -l -d $(orabasehome)/rdbms/demo




Database Installation Guide
E96434-12                                                                                                     April 30, 2026
Copyright © 2015, 2026, Oracle and/or its affiliates.                                                   Appendix C-6 of C-10
                                                                                                                  Appendix C
                                                                                Copying demo Directories to Oracle Base Home


                      3.    If the rdbms/demo directory has not been copied, then create it and copy it.

                            $ mkdir -p $(orabasehome)/rdbms
                            $ cp -r $ORACLE_HOME/rdbms/demo $(orabasehome)/rdbms/demo

                      Similarly, copy all the demo directories listed earlier from ORACLE_HOME to
                      ORACLE_BASE_HOME.

                      Creating Symbolic Links
                      You must create symbolic links for the odbc/demo, precomp/demo, rdbms/demo, and xdk/
                      demo demo directories.

                      For rdbms/demo, replace $ORACLE_HOME/rdbms/demo with a symbolic link to the copy.

                      1.    Ensure that the symbolic link does not already exist.

                            $ ls -l -d $ORACLE_HOME/rdbms/demo

                      2.    If $ORACLE_HOME/rdbms/demo is still the original demo directory, rename it and replace it
                            with the symbolic link.

                            $ cd $ORACLE_HOME/rdbms
                            $ mv demo demo.installed
                            $ ln -s $(orabasehome)/rdbms/demo $ORACLE_HOME/rdbms/demo

                      For odbc/demo, replace $ORACLE_HOME/odbc/demo with a symbolic link to the copy.

                      1.    Ensure that the symbolic link does not already exist.

                            $ ls -l -d $ORACLE_HOME/odbc/demo

                      2.    If $ORACLE_HOME/odbc/demo is still the original demo directory, rename it and replace it
                            with the symbolic link.

                            $ cd $ORACLE_HOME/odbc
                            $ mv demo demo.installed
                            $ ln -s $(orabasehome)/odbc/demo $ORACLE_HOME/odbc/demo

                      For precomp/demo, replace $ORACLE_HOME/precomp/demo with a symbolic link to the
                      copy.
                      1.    Ensure that the symbolic link does not already exist.

                            $ ls -l -d $ORACLE_HOME/precomp/demo

                      2.    If $ORACLE_HOME/precomp/demo is still the original demo directory, rename it and
                            replace it with the symbolic link.

                            $ cd $ORACLE_HOME/precomp
                            $ mv demo demo.installed
                            $ ln -s $(orabasehome)/precomp/demo $ORACLE_HOME/precomp/demo

                      The xdk/demo directory requires a symbolic link at $ORACLE_HOME/xdk/include pointing
                      to $(orabasehome)/xdk/include after you copy the xdk/demo directory.



Database Installation Guide
E96434-12                                                                                                     April 30, 2026
Copyright © 2015, 2026, Oracle and/or its affiliates.                                                   Appendix C-7 of C-10
                                                                                                                    Appendix C
                                                                                    Determining if an Oracle Home is Read-Only


                      1.    Ensure that the symbolic link does not already exist:

                            $ ls -l -d $ORACLE_HOME/xdk/include

                      2.    If the symbolic link does not exist, then, run the following command:

                            $ ln -s $ORACLE_HOME/xdk/include $(orabasehome)/xdk/include



                                Note
                                In the plsql/demo directory, ncmpdemo.sql is unusable in read-only mode.


                      Copying the init.ora File
                      Copy the init.ora file from ORACLE_HOME to ORACLE_BASE_HOME.

                      1.    Login as the Oracle software owner user (oracle).
                      2.    Check if the init.ora file exists in ORACLE_BASE_HOME.

                            $ ls $(orabasehome)/init.ora


                            If an init.ora file exists in ORACLE_BASE_HOME, then update this init.ora file to
                            be in-sync with the $ORACLE_HOME/init.ora file.
                      3.    If the init.ora file does not exist in ORACLE_BASE_HOME, then copy it from
                            ORACLE_HOME.

                            $ cp $ORACLE_HOME/init.ora $(orabasehome)/init.ora

                      Related Topics
                      •     Oracle Database Examples Installation Guide


Determining if an Oracle Home is Read-Only
                      Run the orabasehome command to determine if your Oracle home is a read/write or read-only
                      Oracle home.
                      If the output of the orabasehome command is the same as $ORACLE_HOME, then your
                      Oracle home is in read/write mode. If the output displays the path ORACLE_BASE/homes/
                      HOME_NAME, then your Oracle home is in read-only mode.
                      1.    Set the ORACLE_HOME environment variable:
                            Bourne, Bash or Korn shell:

                            $ ORACLE_HOME=/u01/app/oracle/product/19.0.0/dbhome_1
                            $ export ORACLE_HOME


                            C shell:

                            % setenv ORACLE_HOME /u01/app/oracle/product/19.0.0/dbhome_1



Database Installation Guide
E96434-12                                                                                                       April 30, 2026
Copyright © 2015, 2026, Oracle and/or its affiliates.                                                     Appendix C-8 of C-10
                                                                                                                  Appendix C
                                                                   File Path and Directory Changes in Read-Only Oracle Homes


                      2.    Go to the bin directory and run the orabasehome command:

                            $ cd $ORACLE_HOME/bin
                            $ ./orabasehome
                            /u01/app/oracle/homes/OraDB19Home1


                            In this example, the Oracle home is in read-only mode.


File Path and Directory Changes in Read-Only Oracle Homes
                      Examples of hierarchical file mappings in a read-only Oracle home as compared to a read/
                      write Oracle home.
                      This example shows an Optimal Flexible Architecture-compliant Oracle Database installation,
                      for the user oracle, with the ORACLE_HOME, ORACLE_BASE, ORACLE_BASE_HOME, and
                      ORACLE_BASE_CONFIG logical locations. The database files are mounted on /u01 and the
                      HOME_NAME is OraDB19Home1.

                      This example also shows the changes in the Oracle Database software defined paths of
                      configuration files, log files, and other directories in a read-only Oracle home when compared
                      to a read/write Oracle home.

                      Table C-1       read/write and Read-Only Oracle Home File Path Examples

                       Directory                        Read/Write Oracle Home File     Read-Only Oracle Home File
                                                        Path                            Path
                       ORACLE_HOME                      /u01/app/oracle/                /u01/app/oracle/
                                                        product/19.0.0/                 product/19.0.0/
                                                        dbhome_1                        dbhome_1
                       ORACLE_BASE                      /u01/app/oracle/                /u01/app/oracle/
                       ORACLE_BASE_HOME                 ORACLE_HOME                     ORACLE_BASE/homes/
                                                        (or)                            HOME_NAME

                                                        /u01/app/oracle/                (or)
                                                        product/19.0.0/                 /u01/app/oracle/homes/
                                                        dbhome_1                        OraDB19Home1
                       ORACLE_BASE_CONFIG               ORACLE_HOME                     ORACLE_BASE
                                                        (or)                            (or)
                                                        /u01/app/oracle/                /u01/app/oracle/
                                                        product/19.0.0/
                                                        dbhome_1
                       network                          ORACLE_HOME/network             ORACLE_BASE_HOME/network
                                                        (or)                            (or)
                                                        /u01/app/oracle/                /u01/app/oracle/homes/
                                                        product/19.0.0/                 OraDB19Home1/network
                                                        dbhome_1/network
                       dbs                              ORACLE_HOME/dbs                 ORACLE_BASE/dbs
                                                        (or)                            (or)
                                                        /u01/app/oracle/                /u01/app/oracle/dbs
                                                        product/19.0.0/
                                                        dbhome_1/dbs


Database Installation Guide
E96434-12                                                                                                     April 30, 2026
Copyright © 2015, 2026, Oracle and/or its affiliates.                                                   Appendix C-9 of C-10
                                                                                                       Appendix C
                                                        File Path and Directory Changes in Read-Only Oracle Homes




Database Installation Guide
E96434-12                                                                                           April 30, 2026
Copyright © 2015, 2026, Oracle and/or its affiliates.                                       Appendix C-10 of C-10
D
Managing Oracle Database Port Numbers
                      Review default port numbers. If needed, use these steps to change assigned ports after
                      installation.
                      •     About Managing Ports
                            During installation, Oracle Universal Installer assigns port numbers to components from a
                            set of default port numbers.
                      •     Oracle Database Component Port Numbers and Protocols
                            This table lists the port numbers and protocols configured for Oracle Database
                            components during a single-instance installation. By default, the first port in the range is
                            assigned to the component, if it is available.


About Managing Ports
                      During installation, Oracle Universal Installer assigns port numbers to components from a set
                      of default port numbers.
                      Many Oracle Database components and services use ports. As an administrator, it is important
                      to know the port numbers used by these services, and to ensure that the same port number is
                      not used by two services on your host. Enter the following command to identify the ports
                      currently used on your computer:

                      $/bin/netstat -a


                      Most port numbers are assigned during installation. Every component and service has an
                      allotted port range, which is the set of port numbers Oracle Database attempts to use when
                      assigning a port. Oracle Database starts with the lowest number in the range and performs the
                      following checks:
                      •     Is the port used by another Oracle Database installation on the host?
                            The installation may be up or down at the time. Oracle Database can still detect if the port
                            is used.
                      •     Is the port used by a process that is currently running?
                            This can be any process on the host, even a non-Oracle Database process.
                      •     Is the port listed in the /etc/services file?
                      If the answer to any of the preceding questions is yes, then Oracle Database moves to the next
                      highest port in the allotted port range, and continues checking until it finds a free port.


Oracle Database Component Port Numbers and Protocols
                      This table lists the port numbers and protocols configured for Oracle Database components
                      during a single-instance installation. By default, the first port in the range is assigned to the
                      component, if it is available.




Database Installation Guide
E96434-12                                                                                                      April 30, 2026
Copyright © 2015, 2026, Oracle and/or its affiliates.                                                     Appendix D-1 of D-2
                                                                                                                            Appendix D
                                                                                Oracle Database Component Port Numbers and Protocols



                      Table D-1       Protocols and Default Port Numbers for Oracle Database Components

                       Component          Description                    Default Port Port Range                 Protocol
                                                                         Number
                       Oracle Net         Enables Oracle client          1521         Port number changes to     TCP
                       Services           connections to the                          the next available port.
                       Listener           database over the Oracle                    Modifiable manually to
                                          Net Services protocol.                      any available port.
                                          You can configure it
                                          during installation. To
                                          reconfigure this port, use
                                          Net Configuration
                                          Assistant.
                       Oracle             Listening port for Oracle      1630         1630                       TCP
                       Connection         client connections to
                       Manager            Oracle Connection
                                          Manager. It is not
                                          configured during
                                          installation, but can be
                                          configured manually by
                                          editing the cman.ora
                                          parameter file. This file is
                                          located under the /
                                          network/admin
                                          directory.
                       Oracle XML         The Oracle XML DB         0                 Configured Manually        HTTP
                       DB                 HTTP port is used if web-
                                          based applications must
                                          access an Oracle
                                          database from an HTTP
                                          listener. You must
                                          configure this port
                                          manually.
                       Oracle XML         The Oracle XML DB FTP 0                     Configured Manually        FTP
                       DB                 is used when applications
                                          must access an Oracle
                                          database from an FTP
                                          listener. You must
                                          configure this port
                                          manually.

                      Related Topics
                      •     Using HTTP(S) on a Standard Port
                      •     Using FTP on the Standard Port
                      •     Oracle Real Application Clusters Installation Guide for Linux and UNIX




Database Installation Guide
E96434-12                                                                                                              April 30, 2026
Copyright © 2015, 2026, Oracle and/or its affiliates.                                                             Appendix D-2 of D-2
Index
Numerics                                                commands (continued)
                                                            df -k, 2
19c deprecated features, ii                                 grep "Memory size", 2
                                                            ipadm, 2
                                                            ndd, 2
A                                                           root.sh, 8
aliases, multiple on computers, 4                           runcluvfy.sh, 7
apply patches during install                                setup.exe, 7
    apply patches during upgrade, 11, 7                     umask, 11
asmdba groups                                               useradd, 11
    creating, 8                                         computers with multiple aliases, 4
asmoper group                                           computers, non-networked, 3
    creating, 9                                         copying demo directory, C-6
Automatic Diagnostic Repository (ADR), B-1              custom database
Automatic Memory Management, 5                              failure groups for Oracle Automatic Storage
                                                                     Management, 2
                                                            requirements when using Oracle Automatic
B                                                                    Storage Management, 2
backupdba group
    creating, 10                                        D
Bash shell
    default user startup file, 12                       DAS (direct attached storage) disks, 10
binary files                                            Data Analytics Accelerator, 12
    supported storage options for, 1                    data files
Bourne shell                                                minimum disk space for, 6
    default user startup file, 12                           recommendations for file system, 6
                                                            supported storage options for, 1
                                                        data loss
C                                                           minimizing with Oracle ASM, 2
C shell                                                 database cloning, 16
    default user startup file, 12                       Database Configuration Assistant
CDBs                                                        running in silent mode, A-7
    character sets, 4                                   database performance, 12
central inventory, 4, B-5                               databases
          See also Oracle inventory directory               Oracle Automatic Storage Management
          See also OINSTALL directory                               requirements, 2
character sets, 4                                       DAX, 12
checklists                                              DB_RECOVERY_FILE_DEST, 15
     and installation planning, 1                       DB_RECOVERY_FILE_DEST_SIZE, 15
client-server configurations, B-2                       dba group
cloning, 16                                                 creating, 9
command syntax conventions, ii                              description, 5
commands                                                    SYSDBA privilege, 5
     /usr/sbin/swap, 2                                  dba groups
     asmcmd, 6                                              creating, 10
     df -h, 2


Database Installation Guide
E96434-12                                                                                       April 30, 2026
Copyright © 2015, 2026, Oracle and/or its affiliates.                                       Index-1 of Index-7
                                                                                                          Index


DBCA                                                    external redundancy
    configuring Automatic memory Management,                Oracle Automatic Storage Management level,
              5                                                     2
dbca.rsp file, A-3
DBSNMP user
    password requirements, 3
                                                        F
default file mode creation mask                         failure group
    setting, 11                                               characteristics of Oracle ASM failure group, 2
deinstall, 1, 3                                               examples of Oracle Automatic Storage
          See also removing Oracle software                             Management failure groups, 2
deinstall command, 1                                          Oracle ASM, 2
deinstallation, 1                                       fast recovery area, 16
    examples, 5                                               filepath, B-5
    previous releases, 7                                      Grid home
    upgrades, 7                                                    filepath, B-5
demo directory, C-6                                     file mode creation mask
deprecated features, ii                                       setting, 11
df command, 12                                          file paths, C-9
dgdba group                                             file system
    creating, 10                                              using for data files, 6
diagnostic data, B-1                                    file system options, 6
Direct NFS                                              files
    disabling, 5                                              bash_profile, 12
    enabling, 5                                               dbca.rsp, A-3
    oranfstab file, 2                                         enterprise.rsp, A-3
directory                                                     login, 12
    creating separate data file directories, 10               profile, 12
    database file directory, 6                                response files, A-3
disk group                                              filesets, 5
    Oracle ASM, 2
disk group corruption
    preventing, 7                                       G
disk groups
                                                        globalization
    checking, 6
                                                            localization for client connections, 8
    recommendations for, 2
                                                            NLS_LANG
disk space
                                                                and client connections, 8
    Oracle ASM, 5
                                                        Grid user
    requirements for preconfigured database in
                                                            creating, 11
             Oracle Automatic Storage
                                                        groups
             Management, 2
                                                            creating an Oracle Inventory Group, 2
disks
                                                            creating the asmdba group, 8
    supported for Oracle Automatic Storage
                                                            creating the asmoper group, 9
             Management, 10
                                                            creating the backupdba group, 10
display variable, 4
                                                            creating the dba group, 9
                                                            creating the dgdba group, 10
E                                                           creating the kmdba group, 10
                                                            creating the racdba group, 10
editing shell startup file, 12                              OINSTALL group, 2
EM Express, 14                                              OSBACKUPDBA (backupdba), 6
enterprise.rsp file, A-3                                    OSDBA (dba), 5
environment variables                                       OSDBA group (dba), 5
     ORACLE_HOSTNAME, 3                                     OSDGDBA (dgdba), 6
examples                                                    OSKMDBA (kmdba), 6
     Oracle ASM failure groups, 2                           OSOPER (oper), 5
executeConfigTools, A-10                                    OSOPER group (oper), 5



Database Installation Guide
E96434-12                                                                                         April 30, 2026
Copyright © 2015, 2026, Oracle and/or its affiliates.                                         Index-2 of Index-7
                                                                                                          Index


H                                                       L
hardware requirements, 1                                laptops, installing Oracle Database on, 3
    display, 1                                          local device
hared Memory Resource Controls                              using for data files, 6
    checking, 3                                         locking and unlocking users, 7
host name resolution, 12                                loopback adapters, 4
host name, setting before installation, 4                   non-networked computers, 3
hugepages, 2                                            LVM
                                                            recommendations for Oracle Automatic
                                                                     Storage Management, 2
I
image                                                   M
     install, 2, 2
init.ora                                                mask
     and SGA permissions, 12                                setting default file mode creation mask, 11
installation                                            max_buf, 2
     computer aliases, multiple, 4                      mixed binaries, 5
     laptops, 3                                         mode
     Oracle Automatic Storage Management, 2                 setting default file mode creation mask, 11
     response files, A-3                                multihomed computers, installing on, 3
          preparing, A-3, A-4                           multihomed Oracle servers
          templates, A-3                                    resolving to,, 4
     silent mode, A-5                                   multiple aliases, computers with, 4
installation option                                     Multiple Oracle Homes Support
     Automatic Memory Management, 5                         advantages, B-2
installation planning, 1                                multitenant container database
installation types                                          character sets, 4
     and Oracle Automatic Storage Management,           multiversioning, B-2
               2                                        My Oracle Support credentials, 8
installer
     supported languages, 6
installer screens
                                                        N
     ASM Storage Option, 7                              Net Configuration Assistant (NetCA)
Installing                                                  response files, A-7
     Oracle Restart, 3                                      running at command prompt, A-7
invalid objects                                         netca.rsp file, A-3
     recompiling, 9                                     network adapters, 4
                                                            computers with multiple aliases, 4
J                                                           non-networked computers, 3
                                                            primary, on computers with multiple aliases, 4
JDK requirements, 5                                             See also loopback adapters
                                                        network cards, multiple, 3
                                                        network setup
K                                                           computers with multiple aliases, 4
kernel parameters                                           host name resolution, 12
    changing, 4                                         network topics
    checking, 3                                             laptops, 3
    displaying, 4                                           multiple network cards, 3
    tcp and udp, 5                                          non-networked computers, 3
kernel parameters configuration, 1                      NFS
kmdba group                                                 and data files, 7
    creating, 10                                            buffer size requirements, 1
Korn shell                                                  for data files, 7
    default user startup file, 12



Database Installation Guide
E96434-12                                                                                        April 30, 2026
Copyright © 2015, 2026, Oracle and/or its affiliates.                                        Index-3 of Index-7
                                                                                                        Index


NFS mounts                                              Oracle Automatic Storage Management (continued)
    Direct NFS Client                                      disk space, 5
        requirements, 8                                    disks, supported, 10
    mtab, 8                                                failure groups
    oranfstab, 8                                                examples, 2
non-networked computers, 3                                      identifying, 2
noninteractive installation                                part of Oracle Grid Infrastructure for a
    Oracle ASM requirements, 6                                       standalone server installation, 1
noninteractive mode                                        part of Oracle Grid Infrastructure installation,
     See response file mode                                          3
                                                           partition creation, 10
O                                                          redundancy levels, 2
                                                           SAN disks, 10
OFA, B-1                                                   space required for preconfigured database, 2
          See also Optimal Flexible Architecture        Oracle base, B-1, B-5
OINSTALL directory, B-5                                 Oracle base config, C-3
oinstall group                                          Oracle base home, C-2
    creating, 2                                         Oracle Connection Manager, D-1
OINSTALL groupl, 4                                      Oracle Database
          See also Oracle Inventory directory              minimum disk space requirements, 6
oper group                                                 requirements with Oracle Automatic Storage
    description, 5                                                   Management, 2
operating system                                        Oracle Database Configuration Assistant, A-8
    different on cluster members, 5                        response file, A-3
    requirements, 5                                     Oracle Database deployment, 8
operating system privileges groups, 4                   Oracle Database prerequisites group package, 3
operating system requirements, 2                        Oracle DBCA, A-8
Optimal Flexible Architecture, B-1                      Oracle Disk Manager
    about, B-1                                             and Direct NFS, 5
orabasehome, C-8                                        Oracle Enterprise Manager Database Express, 14
orabasetab, C-3                                         Oracle Fleet Patching and Provisioning, ii
Oracle ACFS                                                Databases, 2
    enabling, 10                                        Oracle Flex Clusters
    Installing Oracle RAC binaries not supported           Oracle Restart
              on Oracle Flex Cluster, 5                         restrictions for, 5
    restrictions for Oracle Restart, 5                     restrictions for Oracle ACFS, 5
    supported Oracle Solaris versions, 4                Oracle FPP, ii, 2
Oracle ADVM                                             Oracle Grid Infrastructure
    supported Oracle Solaris versions, 4                   restrictions for Oracle ACFS, 5
Oracle ASM, 2, 2                                        Oracle Grid Infrastructure for a standalone server,
    configuring disk devices, 8                                 2
    disk groups, 2                                      Oracle home
    disk space, 5                                          ASCII path restriction for, 2
    failure groups, 2                                      file path, B-5
    recommendations for disk groups, 2                     Grid home
          See also Oracle Automatic Storage                     filepath, B-5
          Management                                       naming conventions, B-4
Oracle ASM disk space, 5                                Oracle home directory
Oracle ASM Filter Driver                                   multiple homes, network considerations, 3
   about, 7                                             Oracle host name, setting before installation, 4
   best practices, 8                                    Oracle Inventory, 4
Oracle ASMFD on Oracle Solaris, 8                          identifying existing, 2
Oracle Automatic Storage Management, 2                  Oracle Inventory Directory
   allocation units (AU) and ASM disks, 2                  OINSTALL group, B-2
   characteristics of failure groups, 2                 Oracle Net Configuration Assistant
   DAS disks, 10                                           response file, A-3


Database Installation Guide
E96434-12                                                                                       April 30, 2026
Copyright © 2015, 2026, Oracle and/or its affiliates.                                       Index-4 of Index-7
                                                                                                         Index


Oracle Net Services Listener, D-1                       OSOPER groups
Oracle Optimal Flexible Architecture                        description for database, 5
     See Optimal Flexible Architecture                      SYSOPER privilege, 5
Oracle Restart, 2                                       OSRACDBA group
    deconfiguring, 5                                        creating, 10
    downgrading, 5                                      other changes, ii
    gridSetup.sh, 3                                     OTN website
    Installing, 3                                           downloading installation software from, 3
    troubleshooting, 5                                  out-of-place patching, 12
Oracle Software Owner user
    creating, 3, 11
Oracle Software Owner users, 12                         P
Oracle Solaris                                          parameter file
    installation options for, 1                              and permissions to read and write the SGA,
    parameters, 1                                                     12
Oracle Universal Installer                              partition
    response files                                           using with Oracle Automatic Storage
         list of, A-3                                                 Management, 2
Oracle Upgrade Companion, 2                             partitions
oracle user, 4                                               creation for Oracle Automatic Storage
    creating, 3                                                       Management disks, 10
Oracle user                                             passwords, 3, 6
    modifying, 15                                            change after install, 3
Oracle XML DB, D-1                                           resetting
ORACLE_BASE_CONFIG, C-3, C-9                                      with SQL*Plus, 7
ORACLE_BASE_HOME, C-2, C-9                                   unlocking
ORACLE_HOME, C-9                                                  with SQL*Plus, 7
ORACLE_HOSTNAME, 3                                      patch updates, 2
ORACLE_HOSTNAME environment variable                    PGA, 5
    computers with multiple aliases, 4                  ports
    multihomed computers, 3                                  Oracle Connection Manager, D-1
    setting before installation, 4                           Oracle Net Services Listener, D-1
oracle-database-preinstall-19c, 3                            Oracle XML DB, D-1
    checking, 2                                         postinstallation
oraInventory, B-5                                            recommended tasks
oranfstab configuration file, 2                                   root.sh script, backing up, 8
oranfstab file, 5                                       postinstallation -executeConfigTools option, A-9
OSBACKUPDBA group                                       postinstallation configToolAllCommands script,
    creating, 10                                                  A-12
OSBACKUPDBA group (backupdba), 6                        prctl command, 3
OSDBA, 4                                                preconfigured database
OSDBA for ASM                                                Oracle Automatic Storage Management disk
    creating for Oracle Grid Infrastructure, 8                        space requirements, 2
OSDBA groups                                                 requirements when using Oracle Automatic
    creating, 9                                                       Storage Management, 2
    creating for Oracle Grid Infrastructure, 9          project.max-shm-memory
    description for database, 5                              checking, 3
    SYSDBA privilege, 5
OSDGDBA group
    creating, 10                                        R
OSDGDBA group (dgdba), 6
                                                        racdba group
OSKMDBA group
                                                            creating, 10
    creating, 10
                                                        RAID, 6
OSKMDBA group (kmdba), 6
                                                            using for Oracle data files, 6
OSOPER group
                                                        rapid home provisioning
    creating, 9
                                                            name change, ii


Database Installation Guide
E96434-12                                                                                        April 30, 2026
Copyright © 2015, 2026, Oracle and/or its affiliates.                                        Index-5 of Index-7
                                                                                                          Index


read only Oracle home, C-4                              running multiple Oracle releases, B-2
read-only oracle home, C-2, C-9
read-only Oracle home, C-1, C-3, C-6, C-8
read/write oracle home, C-9
                                                        S
recommendations                                         SAN (storage area network) disks, 10
    on performing software-only installations, 6        seamless patching, C-2
recompiling invalid objects, 9                          security
recv_hiwat, 2                                                selecting passwords, 3
redundancy level                                        SGA, 5
    and space requirements for preconfigured            silent mode
             database, 2                                     about, A-1
    for Oracle Automatic Storage Management, 2               reasons for using, A-2
redundant array of independent disks                    silent mode installation, A-5
     See RAID                                           software requirements, 5
release update revisions, 2                             software security updates, 8
release updates, 2                                      Solaris kernel parameters, 1
releases                                                starting, 14
    multiple, B-2                                       storage area network disks, 10
removing Oracle software, 1                             stty
    examples, 5                                              suppressing to prevent installation errors, 15
requirements, 2                                         supported languages
resource control, 1                                          installer, 6
    changing, 4                                         swap space
    displaying, 4                                            allocation, 2
    project.max-shm-memory                              SYS user
         minimum value, 1                                    password requirements, 3
         requirements, 1                                SYSBACKUPDBA system privileges, 6
response file, A-8                                      SYSDBA privilege
response file installation                                   associated group, 5
    preparing, A-3                                      SYSDGDBA system privileges, 6
    response files                                      SYSKMDBA system privileges, 6
         templates, A-3                                 SYSOPER privilege
    silent mode, A-5                                         associated group, 5
response file mode, A-1                                 system global area
    about, A-1                                               permissions to read and write, 12
    reasons for using, A-2                              system privileges
          See also response files, silent mode               SYSBACKUPDBA, 6
response files, A-1, A-8                                     SYSDGDBA, 6
    about, A-1                                               SYSKMDBA, 6
    creating with template, A-3                         system privileges accounts
    dbca.rsp, A-3                                            locked after install, 3
    enterprise.rsp, A-3                                 system requirements, 1
    general procedure, A-2                              SYSTEM user
    Net Configuration Assistant, A-7                         password requirements, 3
    netca.rsp, A-3
    passing values at command line, A-1
    specifying with Oracle Universal Installer, A-5     T
          See also silent mode.
roohctl -enable, C-4                                    tcp_max_buf, 2
root user                                               tcp_recv_hiwat, 2
    logging in as, 1                                    tcp_xmit_hiwat, 2
root.sh script                                          terminal output commands
    backing up, 8                                           suppressing for Oracle installation owner
rootcrs.sh, 1                                                       accounts, 15
roothas.pl, 8, 10                                       troubleshooting
roothas.sh, 9, 10, 1                                        disk space errors, 2
                                                            environment path errors, 2


Database Installation Guide
E96434-12                                                                                         April 30, 2026
Copyright © 2015, 2026, Oracle and/or its affiliates.                                         Index-6 of Index-7
                                                                                                           Index


troubleshooting (continued)                             unset installation owners environment variables,
    garbage strings in script inputs found in log                16
              files, 15                                 upgrade, 3
    host name resolution for multihomed servers,             Oracle Automatic Storage Management, 3, 1
              3                                         upgrades
    installation owner environment variables and             best practices, 2
              installation errors, 16                   upgrading
    inventory corruption, 15                                 options, 2
    ssh errors, 15                                      useradd command, 11
    stty errors, 15                                     users
    unset environment variables, 2                           creating the oracle user, 3
typographic conventions, iii                                 locking and unlocking, 7
                                                        utlrp.sql, 9
U
                                                        X
umask command, 11
uninstall                                               X Window System
     See removing Oracle software                             enabling remote hosts, 1
UNIX commands                                           xhost command, 1
   xhost, 1                                             xmit_hiwat, 2
UNIX workstation                                        xtitle
   installing from, 1                                         suppressing to prevent installation errors, 15




Database Installation Guide
E96434-12                                                                                          April 30, 2026
Copyright © 2015, 2026, Oracle and/or its affiliates.                                          Index-7 of Index-7

