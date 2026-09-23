# 19. Database Client Installation Guide for HP-UX Itanium

> 源文件: `en/hpcli/database-client-installation-guide-hp-ux-itanium.pdf`

Oracle® Database
Database Client Installation Guide




    19c for HP-UX Itanium
    E96440-01
    May 2019
Oracle Database Database Client Installation Guide, 19c for HP-UX Itanium

E96440-01

Copyright © 2015, 2019, Oracle and/or its affiliates. All rights reserved.

Primary Author: Prakash Jashnani

Contributing Authors: Douglas Williams

Contributors: Mark Bauer, Tanaya Bhattacharjee, Neha Avasthy, Prasad Bagal, Subhranshu Banerjee, Mark
Bauer, Tammy Bednar, Eric Belden, Gavin Bowe, Robert Chang, Darcy Christensen, Kiran Chamala,
Jonathan Creighton, Benoit Dageville, Sudip Datta, Jim Erickson, Marcus Fallen, Joseph Francis, Mark
Fuller, Allan Graves, Barbara Glover, Asad Hasan, Thirumaleshwara Hasandka, Prasad Kuruvadi Nagaraj,
Clara Jaeckel, Aneesh Khandelwal, Joel Kallman, Eugene Karichkin, Jai Krishnani, Sangeeth Kumar, Ranjith
Kundapur, Kevin Jernigan, Christopher Jones, Simon Law, Bryn Llewellyn, Saar Maoz, Sreejith Minnanghat,
Gopal Mulagund, Sue Lee, Rich Long, Barb Lundhild, Rolly Lv, Rudregowda Mallegowda, Padmanabhan
Manavazhi, Mughees Minhas, Krishna Mohan, Matthew McKerley, John McHugh, Gurudas Pai, Satish
Panchumarthy , Rajesh Prasad, Rajendra Pingte, Apparsamy Perumal, Srinivas Poovala, Mohammed
Shahnawaz Quadri, Hanlin Qian, Gurumurthy Ramamurthy, Hema Ramamurthy, Sunil Ravindrachar, Mark
Richwine, Dipak Saggi, Trivikrama Samudrala, Shachi Sanklecha, David Schreiner, Ara Shakian, Mohit
Singhal, Dharma Sirnapalli, Akshay Shah, James Spiller, Roy Swonger, Binoy Sukumaran, Kamal Tbeileh,
Ravi Thammaiah, Shekhar Vaggu, Parvathi Subramanian, Ajesh Viswambharan, Peter Wahl, Terri Winters,
Sergiusz Wolicki, Sivakumar Yarlagadda, Zakia Zerhouni

This software and related documentation are provided under a license agreement containing restrictions on
use and disclosure and are protected by intellectual property laws. Except as expressly permitted in your
license agreement or allowed by law, you may not use, copy, reproduce, translate, broadcast, modify,
license, transmit, distribute, exhibit, perform, publish, or display any part, in any form, or by any means.
Reverse engineering, disassembly, or decompilation of this software, unless required by law for
interoperability, is prohibited.

The information contained herein is subject to change without notice and is not warranted to be error-free. If
you find any errors, please report them to us in writing.

If this is software or related documentation that is delivered to the U.S. Government or anyone licensing it on
behalf of the U.S. Government, then the following notice is applicable:

U.S. GOVERNMENT END USERS: Oracle programs, including any operating system, integrated software,
any programs installed on the hardware, and/or documentation, delivered to U.S. Government end users are
"commercial computer software" pursuant to the applicable Federal Acquisition Regulation and agency-
specific supplemental regulations. As such, use, duplication, disclosure, modification, and adaptation of the
programs, including any operating system, integrated software, any programs installed on the hardware,
and/or documentation, shall be subject to license terms and license restrictions applicable to the programs.
No other rights are granted to the U.S. Government.

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
the AMD logo, and the AMD Opteron logo are trademarks or registered trademarks of Advanced Micro
Devices. UNIX is a registered trademark of The Open Group.

This software or hardware and documentation may provide access to or information about content, products,
and services from third parties. Oracle Corporation and its affiliates are not responsible for and expressly
disclaim all warranties of any kind with respect to third-party content, products, and services unless otherwise
set forth in an applicable agreement between you and Oracle. Oracle Corporation and its affiliates will not be
responsible for any loss, costs, or damages incurred due to your access to or use of third-party content,
products, or services, except as set forth in an applicable agreement between you and Oracle.
Contents
    Preface
    Audience                                                                            vii
    Documentation Accessibility                                                         vii
    Set Up Java Access Bridge to Implement Java Accessibility                          viii
    Command Syntax                                                                     viii
    Related Documentation                                                               ix
    Conventions                                                                         ix



1   Oracle Database Client Installation Checklist
    Server Hardware Checklist for Oracle Database Client Installation                  1-1
    Operating System Checklist for Oracle Database on HP-UX Itanium                    1-2
    Server Configuration Checklist for Oracle Database Client                          1-2
    Oracle User Environment Configuration Checklist for Oracle Database Installation   1-4
    Storage Checklist for Oracle Database Client                                       1-5
    Installer Planning Checklist for Oracle Database Client                            1-5



2   Checking and Configuring Server Hardware for Oracle Database
    Client
    Logging In to a Remote System Using X Window System                                2-1
    Checking Server Hardware and Memory Configuration                                  2-2



3   Configuring Operating Systems for Oracle Database Client on HP-
    UX Itanium Systems
    Guidelines for HP-UX Itanium Operating System Installation                         3-1
    Reviewing Operating System Security Common Practices                               3-1
    About Operating System Requirements                                                3-2
    Operating System Requirements for HP-UX Itanium Systems                            3-2
        Supported HP-UX Release on Itanium                                             3-2
    Additional Drivers and Software Packages for HP-UX Itanium Systems                 3-3
        Installation Requirements for ODBC and LDAP                                    3-4




                                                                                        iii
            About ODBC Drivers and Oracle Database                                  3-4
            Installing ODBC Drivers for HP-UX Itanium Systems                       3-4
            About LDAP and Oracle Plug-ins                                          3-4
            Installing the LDAP Package                                             3-5
        Installation Requirements for Programming Environments for HP-UX Itanium
        Systems                                                                     3-5
        Installation Requirements for Web Browsers                                  3-6
    Checking the Software Requirements on HP-UX Itanium                             3-6



4   Configuring Users, Groups and Environments for Oracle Database
    Client
    Required Operating System Groups and Users                                      4-1
        Determining If an Oracle Inventory and Oracle Inventory Group Exist         4-2
        Creating the Oracle Inventory Group If an Oracle Inventory Does Not Exist   4-2
        About Oracle Installation Owner Accounts                                    4-3
        Identifying an Oracle Software Owner User Account                           4-3
    Creating Operating System Oracle Installation User Accounts                     4-4
        Creating an Oracle Software Owner User                                      4-4
        Environment Requirements for Oracle Software Owners                         4-4
        Procedure for Configuring Oracle Software Owner Environments                4-5
        Setting Remote Display and X11 Forwarding Configuration                     4-7
    Unsetting Oracle Installation Owner Environment Variables                       4-8



5   Installing Oracle Database Client
    About Image-Based Oracle Database Client Installation                           5-1
    Accessing the Installation Software                                             5-2
        Downloading Oracle Software                                                 5-2
        Downloading the Installation Archive Files from OTN                         5-2
        Downloading the Software from Oracle Software Delivery Cloud Portal         5-3
        Copying the Software to the Hard Disk                                       5-4
            Mounting Disks on HP-UX Itanium Systems                                 5-4
    About Character Set Selection During Installation                               5-5
    Running the Installer in a Different Language                                   5-6
    Installing the Oracle Database Client Software                                  5-6
        Running Setup Wizard to Install Oracle Database Client                      5-6
        Installing Oracle Database Client Using Image File                          5-7
        Using Oracle Net Configuration Assistant                                    5-9
    Relinking Oracle Database Client Binaries After Installation                    5-9




                                                                                     iv
6   Oracle Database Client Postinstallation Tasks
    Required Postinstallation Tasks                                      6-1
        Downloading and Installing Release Update Patches                6-1
    Recommended Postinstallation Tasks                                   6-2
        Creating a Backup of the root.sh Script                          6-2
        Setting Language and Locale Preferences for Client Connections   6-2



7   Removing Oracle Database Software
    About Oracle Deinstallation Options                                  7-1
    Oracle Deinstallation (Deinstall)                                    7-3
    Deinstallation Examples for Oracle Database Client                   7-4



A   Installing and Configuring Oracle Database Using Response Files
    How Response Files Work                                              A-1
    Reasons for Using Silent Mode or Response File Mode                  A-2
    Using Response Files                                                 A-2
    Preparing Response Files                                             A-3
        Editing a Response File Template                                 A-3
        Recording Response Files                                         A-4
    Running Oracle Universal Installer Using a Response File             A-5


    Index




                                                                          v
List of Tables
1-1   Server Hardware Checklist for Oracle Database Client Installations                      1-1
1-2   Operating System General Checklist for Oracle Database on HP-UX Itanium                 1-2
1-3   Server Configuration Checklist for Oracle Database Client                               1-2
1-4   User Environment Configuration for Oracle Database                                      1-4
1-5   Storage Checklist for Oracle Database Client                                            1-5
1-6   Oracle Universal Installer Planning Checklist for Oracle Database Client Installation   1-5
3-1   HP-UX Itanium Minimum Operating System Requirements                                     3-3
3-2   Requirements for Programming Environments for HP-UX Itanium Systems                     3-5
A-1   Response Files for Oracle Database Client                                               A-3




                                                                                               vi
Preface
           This guide explains how to install and configure single-instance Oracle Database.
           This guide also provides information about Optimal Flexible Architecture, cloning an
           Oracle home, and how to remove the database software.
           •   Audience
               This guide is intended for anyone responsible for installing Oracle Database 19c.
           •   Documentation Accessibility
           •   Set Up Java Access Bridge to Implement Java Accessibility
               Install Java Access Bridge so that assistive technologies on Microsoft Windows
               systems can use the Java Accessibility API.
           •   Command Syntax
               Refer to these command syntax conventions to understand command examples in
               this guide.
           •   Related Documentation
               The related documentation for Oracle Database products includes the following
               manuals:
           •   Conventions


Audience
           This guide is intended for anyone responsible for installing Oracle Database 19c.
           Additional installation guides for Oracle Database, Oracle Real Application Clusters,
           Oracle Clusterware, Oracle Database Examples, and Oracle Enterprise Manager
           Cloud Control are available at the following URL:
           http://docs.oracle.com


Documentation Accessibility
           For information about Oracle's commitment to accessibility, visit the Oracle
           Accessibility Program website at http://www.oracle.com/pls/topic/lookup?
           ctx=acc&id=docacc.

           Access to Oracle Support
           Oracle customers that have purchased support have access to electronic support
           through My Oracle Support. For information, visit http://www.oracle.com/pls/topic/
           lookup?ctx=acc&id=info or visit http://www.oracle.com/pls/topic/lookup?ctx=acc&id=trs
           if you are hearing impaired.




                                                                                                   vii
                                                                                                Preface




Set Up Java Access Bridge to Implement Java Accessibility
         Install Java Access Bridge so that assistive technologies on Microsoft Windows
         systems can use the Java Accessibility API.
         Java Access Bridge is a technology that enables Java applications and applets that
         implement the Java Accessibility API to be visible to assistive technologies on
         Microsoft Windows systems.
         Refer to Java Platform, Standard Edition Accessibility Guide for information about the
         minimum supported versions of assistive technologies required to use Java Access
         Bridge. Also refer to this guide to obtain installation and testing instructions, and
         instructions for how to use Java Access Bridge.
         Related Topics
         •    Java Platform, Standard Edition Java Accessibility Guide


Command Syntax
         Refer to these command syntax conventions to understand command examples in this
         guide.


          Convention        Description
          $                 Bourne or BASH shell prompt in a command example. Do not enter the
                            prompt as part of the command.
          %                 C Shell prompt in a command example. Do not enter the prompt as part of
                            the command.
          #                 Superuser (root) prompt in a command example. Do not enter the prompt
                            as part of the command.
          monospace         UNIX command syntax
          backslash \       A backslash is the UNIX and Linux command continuation character. It is
                            used in command examples that are too long to fit on a single line. Enter
                            the command as displayed (with a backslash) or enter it on a single line
                            without a backslash:

                            dd if=/dev/rdsk/c0t1d0s6 of=/dev/rst0 bs=10b \
                            count=10000


          braces { }        Braces indicate required items:

                            .DEFINE {macro1}


          brackets [ ]      Brackets indicate optional items:

                            cvtcrt termname [outfile]




                                                                                                    viii
                                                                                                     Preface




         Convention         Description
         ellipses ...       Ellipses indicate an arbitrary number of similar items:

                            CHKVAL fieldname value1 value2 ... valueN


         italic             Italic type indicates a variable. Substitute a value for the variable:

                            library_name


         vertical line |    A vertical line indicates a choice within braces or brackets:

                            FILE filesize [K|M]




Related Documentation
         The related documentation for Oracle Database products includes the following
         manuals:
         Related Topics
         •    Oracle Database Concepts
         •    Oracle Database New Features Guide
         •    Oracle Database Licensing Information User Manual
         •    Oracle Database Release Notes
         •    Oracle Grid Infrastructure Installation and Upgrade Guide
         •    Oracle Database Client Installation Guide for HP-UX Itanium
         •    Oracle Database Examples Installation Guide
         •    Oracle Real Application Clusters Installation Guide for Linux and UNIX
         •    Oracle Database Administrator's Reference for Linux and UNIX-Based Operating
              Systems
         •    Oracle Automatic Storage Management Administrator's Guide
         •    Oracle Database Upgrade Guide
         •    Oracle Database 2 Day DBA
         •    Oracle Application Express Installation Guide


Conventions
         The following text conventions are used in this document:


         Convention             Meaning
         boldface               Boldface type indicates graphical user interface elements associated
                                with an action, or terms defined in text or the glossary.




                                                                                                          ix
                                                                                Preface




Convention   Meaning
italic       Italic type indicates book titles, emphasis, or placeholder variables for
             which you supply particular values.
monospace    Monospace type indicates commands within a paragraph, URLs, code
             in examples, text that appears on the screen, or text that you enter.




                                                                                         x
1
Oracle Database Client Installation
Checklist
         Use checklists to review system requirements, and to plan and carry out Oracle
         Database Client installation.
         Oracle recommends that you use checklists as part of your installation planning
         process. Using checklists can help you to confirm that your server hardware and
         configuration meet minimum requirements for this release and can help you carry out
         a successful installation.
         •   Server Hardware Checklist for Oracle Database Client Installation
             Use this checklist to check hardware requirements for Oracle Database Client
             installations.
         •   Operating System Checklist for Oracle Database on HP-UX Itanium
             Use this checklist to check minimum operating system requirements for Oracle
             Database.
         •   Server Configuration Checklist for Oracle Database Client
             Use this checklist to check minimum server configuration requirements for Oracle
             Database Client installations.
         •   Oracle User Environment Configuration Checklist for Oracle Database Installation
             Use this checklist to plan operating system users, groups, and environments for
             Oracle Database management.
         •   Storage Checklist for Oracle Database Client
             Use this checklist to review storage minimum requirements and assist with
             configuration planning.
         •   Installer Planning Checklist for Oracle Database Client
             Use this checklist to assist you to be prepared before starting Oracle Universal
             Installer.


Server Hardware Checklist for Oracle Database Client
Installation
         Use this checklist to check hardware requirements for Oracle Database Client
         installations.

         Table 1-1   Server Hardware Checklist for Oracle Database Client Installations

          Check                      Task
          Server Make and            Confirm that server make, model, core architecture, and host
          Architecture               bus adaptors (HBA) or network interface controllers (NICs) are
                                     supported to run with Oracle Database and Oracle Grid
                                     Infrastructure. Ensure the server has a DVD drive, if you are
                                     installing from a DVD.




                                                                                                 1-1
                                                                                                   Chapter 1
                                             Operating System Checklist for Oracle Database on HP-UX Itanium




          Table 1-1 (Cont.) Server Hardware Checklist for Oracle Database Client
          Installations

          Check                          Task
          Runlevel                       3
          Server Display Cards           At least 1024 x 768 display resolution, which Oracle Universal
                                         Installer requires.
          Minimum network                Client is connected to a network.
          connectivity
          Minimum RAM                    At least 256 MB of RAM.



Operating System Checklist for Oracle Database on HP-UX
Itanium
          Use this checklist to check minimum operating system requirements for Oracle
          Database.

          Table 1-2   Operating System General Checklist for Oracle Database on HP-UX
          Itanium

          Item                   Task
          Operating system       The following HP-UX Itanium version is supported:
          general
          requirements           HP-UX 11.31 September 2014 B.11.31.1409 or later
                                 Review the system requirements section for a list of patch requirements.



Server Configuration Checklist for Oracle Database Client
          Use this checklist to check minimum server configuration requirements for Oracle
          Database Client installations.

          Table 1-3   Server Configuration Checklist for Oracle Database Client

          Check                          Task
          Disk space allocated to        At least 130 MB of space in the temporary disk space (/tmp)
          the /tmp directory             directory.




                                                                                                       1-2
                                                                                          Chapter 1
                                          Server Configuration Checklist for Oracle Database Client




Table 1-3   (Cont.) Server Configuration Checklist for Oracle Database Client

Check                         Task
Swap space allocation
relative to RAM               256 MB: 3 times the size of the RAM
                              Between 256 MB and 512 MB: 2 times the size of the
                              RAM
                              Between 512 MB and 2 GB: 1.5 times the size of the
                              RAM
                              Between 2 GB and 16 GB: Equal to the size of the RAM
                              More than 16 GB: 16 GB
                              Note: Configure swap for your expected system loads.
                              This installation guide provides minimum values for
                              installation only. Refer to your operating system
                              documentation for additional memory tuning guidance.

Oracle Inventory              •    For upgrades, Oracle Universal Installer (OUI) detects an
(oraInventory) and                 existing oraInventory directory from the /etc/
OINSTALL Group                     oraInst.loc file, and uses the existing oraInventory.
Requirements                  •    For new installs, if you have not configured an oraInventory
                                   directory, then the installer creates an Oracle inventory that
                                   is one directory level up from the Oracle base for the Oracle
                                   Grid Infrastructure install, and designates the installation
                                   owner's primary group as the Oracle Inventory group.
                              The Oracle Inventory directory is the central inventory of Oracle
                              software installed on your system. Users who have the Oracle
                              Inventory group as their primary group are granted the
                              OINSTALL privilege to write to the central inventory.
                              The OINSTALL group must be the primary group of all Oracle
                              software installation owners on the server. It should be writable
                              by any Oracle installation owner.
Groups and users              Oracle recommends that you create groups and user accounts
                              required for your security plans before starting installation.
                              Installation owners have resource limits settings and other
                              requirements. Group and user names must use only ASCII
                              characters.
Mount point paths for the     Oracle recommends that you create an Optimal Flexible
software binaries             Architecture configuration as described in the appendix "Optimal
                              Flexible Architecture" in Oracle Database Installation Guide for
                              your platform.
Ensure that the Oracle home The ASCII character restriction includes installation owner user
(the Oracle home path you   names, which are used as a default for some home paths, as
select for Oracle Database) well as other directory names you may select for paths.
uses only ASCII characters
Determine root privilege      During installation, you are asked to run configuration scripts as
delegation option for         the root user. You can either run these scripts manually as
installation                  root when prompted, or you can provide configuration
                              information and passwords using a root privilege delegation
                              option such as Sudo.
                              To enable Sudo, have a system administrator with the
                              appropriate privileges configure a user that is a member of the
                              sudoers list, and provide the username and password when
                              prompted during installation.




                                                                                              1-3
                                                                                                          Chapter 1
                                   Oracle User Environment Configuration Checklist for Oracle Database Installation




         Table 1-3     (Cont.) Server Configuration Checklist for Oracle Database Client

          Check                              Task
          Set locale (if needed)             Specify the language and the territory, or locale, in which you
                                             want to use Oracle components. A locale is a linguistic and
                                             cultural environment in which a system or program is running.
                                             NLS (National Language Support) parameters determine the
                                             locale-specific behavior on both servers and clients. The locale
                                             setting of a component determines the language of the user
                                             interface of the component, and the globalization behavior, such
                                             as date and number formatting.

         Related Topics
         •   Oracle Database Globalization Support Guide


Oracle User Environment Configuration Checklist for Oracle
Database Installation
         Use this checklist to plan operating system users, groups, and environments for
         Oracle Database management.

         Table 1-4     User Environment Configuration for Oracle Database

          Check                              Task
          Review Oracle Inventory            The physical group you designate as the Oracle Inventory
          (oraInventory) and                 directory is the central inventory of Oracle software installed on
          OINSTALL Group                     your system. It should be the primary group for all Oracle
          Requirements                       software installation owners. Users who have the Oracle
                                             Inventory group as their primary group are granted the
                                             OINSTALL privilege to read and write to the central inventory.
                                             •    If you have an existing installation, then OUI detects the
                                                  existing oraInventory directory from the/var/opt/
                                                  oracle/oraInst.loc file, and uses this location.
                                             •    If you are installing Oracle software for the first time, then
                                                  you can specify the Oracle inventory directory and the
                                                  Oracle base directory during the Oracle software
                                                  installation, and Oracle Universal Installer will set up the
                                                  software directories for you. Ensure that the directory paths
                                                  that you specify are in compliance with the Oracle Optimal
                                                  Flexible Architecture recommendations.
                                             Ensure that the group designated as the OINSTALL group is
                                             available as the primary group for all planned Oracle software
                                             installation owners.
          Create operating system            Create operating system groups and users depending on your
          groups and users for               security requirements, as described in this install guide.
          standard or role-allocated         Set resource limits settings and other requirements for Oracle
          system privileges                  software installation owners.
                                             Group and user names must use only ASCII characters.




                                                                                                              1-4
                                                                                                    Chapter 1
                                                                 Storage Checklist for Oracle Database Client




          Table 1-4   (Cont.) User Environment Configuration for Oracle Database

          Check                          Task
          Unset Oracle Software          If you have had an existing installation on your system, and you
          Environment Variables          are using the same user account to install this installation, then
                                         unset the ORACLE_HOME, ORACLE_BASE, ORACLE_SID,
                                         TNS_ADMIN environment variables and any other environment
                                         variable set for the Oracle installation user that is connected
                                         with Oracle software homes.
          Configure the Oracle       Configure the environment of the oracle or grid user by
          Software Owner Environment performing the following tasks:
                                         •   Set the default file mode creation mask (umask) to 022 in
                                             the shell startup file.
                                         •   Set the DISPLAY environment variable.


Storage Checklist for Oracle Database Client
          Use this checklist to review storage minimum requirements and assist with
          configuration planning.

          Table 1-5   Storage Checklist for Oracle Database Client

          Check                  Task
          Minimum local disk
          storage space for      At least 682 MB for an Instant Client installation
          Oracle Database        At least 3.2 GB for Administrator installation type
          Client software        At least 2.7 GB for Runtime installation type
                                 At least 7 GB for Custom installation type (all components)



Installer Planning Checklist for Oracle Database Client
          Use this checklist to assist you to be prepared before starting Oracle Universal
          Installer.

          Table 1-6 Oracle Universal Installer Planning Checklist for Oracle Database
          Client Installation

          Check                      Task
          Read the Release Notes Review release notes for your platform, which are available for your
                                 release at the following URL:
                                     http://docs.oracle.com/en/database/database.html
          Review the Licensing       You are permitted to use only those components in the Oracle
          Information                Database media pack for which you have purchased licenses. For
                                     more information about licenses, refer to the following URL:
                                     Oracle Database Licensing Information




                                                                                                        1-5
                                                                                          Chapter 1
                                             Installer Planning Checklist for Oracle Database Client




Table 1-6 (Cont.) Oracle Universal Installer Planning Checklist for Oracle
Database Client Installation

Check                   Task
Review Oracle Support   New platforms and operating system software versions might be
Certification Matrix    certified after this guide is published, review the certification matrix
                        on the My Oracle Support website for the most up-to-date list of
                        certified hardware platforms and operating system versions:
                        https://support.oracle.com/
                        You must register online before using My Oracle Support. After
                        logging in, from the menu options, select the Certifications tab. On
                        the Certifications page, use the Certification Search options to
                        search by Product, Release, and Platform. You can also search
                        using the Certification Quick Link options such as Product
                        Delivery, and Lifetime Support.
Run OUI with CVU and    Oracle Universal Installer is fully integrated with Cluster Verification
use fixup scripts       Utility (CVU), automating many CVU prerequisite checks. Oracle
                        Universal Installer runs all prerequisite checks and creates fixup
                        scripts when you run the installer. You can run OUI up to the
                        Summary screen without starting the installation.
                        You can also run CVU commands manually to check system
                        readiness. For more information, see:
                        Oracle Clusterware Administration and Deployment Guide
Ensure cron jobs do     If the installer is running when daily cron jobs start, then you may
not run during          encounter unexplained installation problems if your cron job is
installation            performing cleanup, and temporary files are deleted before the
                        installation is finished. Oracle recommends that you complete
                        installation before daily cron jobs are run, or disable daily cron jobs
                        that perform cleanup until after the installation is completed.
Decide the client       You can choose one of the following installation types when
installation type       installing Oracle Database Client:
                        •   Instant Client: Enables you to install only the shared libraries
                            required by Oracle Call Interface (OCI), Oracle C++ Call
                            Interface (OCCI), Pro*C, or Java database connectivity (JDBC)
                            OCI applications. This installation type requires much less disk
                            space than the other Oracle Database Client installation types.
                            For more information about Oracle Database Instant Client see
                            the following URL:
                            http://www.oracle.com/technetwork/database/features/instant-
                            client/index.html
                        •   Administrator:Enables applications to connect to an Oracle
                            Database instance on the local system or on a remote system.
                            It also provides tools that enable you to administer Oracle
                            Database.
                        •   Runtime:Enables applications to connect to an Oracle
                            Database instance on the local system or on a remote system.
                        •   Custom:Enables you to select individual components from the
                            list of Administrator and Runtime components.
Obtain your My Oracle   During installation, you require a My Oracle Support user name and
Support account         password to configure security updates, download software updates,
information.            and other installation tasks. You can register for My Oracle Support
                        at the following URL:
                        https://support.oracle.com/




                                                                                               1-6
                                                                                           Chapter 1
                                              Installer Planning Checklist for Oracle Database Client




Table 1-6 (Cont.) Oracle Universal Installer Planning Checklist for Oracle
Database Client Installation

Check                     Task
Decide if you need 32-bit The 64-bit Oracle Database Client software does not contain any 32-
client software           bit client binaries. If you require 32-bit client binaries on 64-bit
                          platforms, then install the 32-bit binaries from the respective 32-bit
                          client software into a separate Oracle home.
                          The 64-bit Oracle Database Client preinstallation requirements apply
                          to 32-bit Oracle Database Client also.
                          For more information, refer to My Oracle Support note 883702.1:
                          https://support.oracle.com/rs?type=doc&id=883702.1
Oracle Database Client    For information about interoperability between Oracle Database
and Oracle Database       Client and Oracle Database releases, see My Oracle Support Note
interoperability          207303.1:
                          https://support.oracle.com/rs?type=doc&id=207303.1




                                                                                                1-7
2
Checking and Configuring Server
Hardware for Oracle Database Client
         Verify that servers where you install Oracle Database Client meet the minimum
         requirements for installation.
         This section provides minimum server requirements to complete installation of Oracle
         Database Client. It does not provide system resource guidelines, or other tuning
         guidelines for particular workloads.
         •    Logging In to a Remote System Using X Window System
              Use this procedure to run Oracle Universal Installer (OUI) by logging on to a
              remote system where the runtime setting prohibits logging in directly to a graphical
              user interface (GUI).
         •    Checking Server Hardware and Memory Configuration
              Use this procedure to gather information about your server configuration.


Logging In to a Remote System Using X Window System
         Use this procedure to run Oracle Universal Installer (OUI) by logging on to a remote
         system where the runtime setting prohibits logging in directly to a graphical user
         interface (GUI).
         OUI is a graphical user interface (GUI) application. On servers where the runtime
         settings prevent GUI applications from running, you can redirect the GUI display to a
         client system connecting to the server.



                 Note:
                 If you log in as another user (for example, oracle or grid), then repeat this
                 procedure for that user as well.



         1.   Start an X Window System session. If you are using an X Window System terminal
              emulator from a PC or similar system, then you may need to configure security
              settings to permit remote hosts to display X applications on your local system.
         2.   Enter a command using the following syntax to enable remote hosts to display X
              applications on the local X server:

              # xhost + RemoteHost


              RemoteHost is the fully qualified remote host name. For example:

              # xhost + somehost.example.com
              somehost.example.com being added to the access control list




                                                                                                 2-1
                                                                                              Chapter 2
                                                      Checking Server Hardware and Memory Configuration


         3.   If you are not installing the software on the local system, then use the ssh
              command to connect to the system where you want to install the software:

              # ssh -Y     RemoteHost


              RemoteHost is the fully qualified remote host name. The -Y flag ("yes") enables
              remote X11 clients to have full access to the original X11 display. For example:

              # ssh -Y somehost.example.com

         4.   If you are not logged in as the root user, and you are performing configuration
              steps that require root user privileges, then switch the user to root.



                  Note:
                  For more information about remote login using X Window System, refer to
                  your X server documentation, or contact your X server vendor or system
                  administrator. Depending on the X server software that you are using, you
                  may have to complete the tasks in a different order.




Checking Server Hardware and Memory Configuration
         Use this procedure to gather information about your server configuration.
         1.   To determine the physical RAM size on the server:

              # /usr/contrib/bin/machinfo | grep -i Memory

         2.   To determine the size of the configured swap space:

              # /usr/sbin/swapinfo -a


              If necessary, see your operating system documentation for information about how
              to configure additional swap space.
         3.   To determine the amount of space available in the /tmp directory:

              # bdf /tmp


              If the free space available in the /tmp directory is less than what is required, then
              complete one of the following steps:
              •   Delete unnecessary files from the /tmp directory to meet the disk space
                  requirement.
              •   When you set the Oracle user's environment, also set the TMP and TMPDIR
                  environment variables to the directory you want to use instead of /tmp.
         4.   To determine the amount of free disk space on the system:

              # bdf




                                                                                                   2-2
                                                                                   Chapter 2
                                           Checking Server Hardware and Memory Configuration


5.   To determine if the system architecture can run the software:

     # uname -m


     Verify that the processor architecture matches the Oracle software release to
     install. For example, you should see the following for a x86-64 bit system:

     ia64 (itanium)


     If you do not see the expected output, then you cannot install the software on this
     system.
6.   To view the shared memory kernel parameters (shmmni, shmseg, and shmmax)
     and determine if any changes are necessary for your system:

     # kctune -v shmmni
     # kctune -v shmseg
     # kctune -v shmmax


     Use the kctune shmmni=1024 command to set the memory kernel parameter to
     the required value.




                                                                                        2-3
3
Configuring Operating Systems for Oracle
Database Client on HP-UX Itanium
Systems
         Complete operating system configuration requirements and checks for Oracle HP-UX
         Itanium systems before you start installation.
         •   Guidelines for HP-UX Itanium Operating System Installation
             Be aware of these operating system guidelines before proceeding with an Oracle
             installation.
         •   Reviewing Operating System Security Common Practices
             Secure operating systems are an important basis for general system security.
         •   About Operating System Requirements
             Depending on the products that you intend to install, verify that you have the
             required operating system kernel and packages installed.
         •   Operating System Requirements for HP-UX Itanium Systems
             The compilers and patches listed in this section are supported for this release on
             HP-UX Itanium systems for Oracle Database, Oracle Database Client, and Oracle
             Grid Infrastructure.
         •   Additional Drivers and Software Packages for HP-UX Itanium Systems
             You are not required to install additional drivers and packages, but you may
             choose to install or configure these drivers and packages.
         •   Checking the Software Requirements on HP-UX Itanium
             Check your software to see if they meet the minimum version, compiler, and patch
             requirements for installation.


Guidelines for HP-UX Itanium Operating System Installation
         Be aware of these operating system guidelines before proceeding with an Oracle
         installation.
         Refer to your HP-UX documentation to obtain information about installing HP-UX
         Itanium on your servers.


Reviewing Operating System Security Common Practices
         Secure operating systems are an important basis for general system security.
         Ensure that your operating system deployment is in compliance with common security
         practices as described in your operating system vendor security guide.




                                                                                              3-1
                                                                                             Chapter 3
                                                                  About Operating System Requirements




About Operating System Requirements
          Depending on the products that you intend to install, verify that you have the required
          operating system kernel and packages installed.
          Requirements listed in this document are current as of the date listed on the title page.
          To obtain the most current information about kernel requirements, see the online
          version at the following URL:
          http://docs.oracle.com
          Oracle Universal Installer performs checks on your system to verify that it meets the
          listed operating system package requirements. To ensure that these checks complete
          successfully, verify the requirements before you start OUI.



                 Note:
                 Oracle does not support running different operating system versions on
                 cluster members, unless an operating system is being upgraded. You cannot
                 run different operating system version binaries on members of the same
                 cluster, even if each operating system is supported.




Operating System Requirements for HP-UX Itanium
Systems
          The compilers and patches listed in this section are supported for this release on HP-
          UX Itanium systems for Oracle Database, Oracle Database Client, and Oracle Grid
          Infrastructure.
          The platform-specific hardware and software requirements included in this guide were
          current when this guide was published. However, because new platforms and
          operating system software versions might be certified after this guide is published,
          review the certification matrix on the My Oracle Support website for the most up-to-
          date list of certified hardware platforms and operating system versions:
          https://support.oracle.com/
          Identify the requirements for your HP-UX Itanium system, and ensure that you have
          supported compilers and required patches installed before starting installation.
          •   Supported HP-UX Release on Itanium
              Use the following information to check the minimum supported HP-UX Itanium
              distribution:


Supported HP-UX Release on Itanium
          Use the following information to check the minimum supported HP-UX Itanium
          distribution:




                                                                                                 3-2
                                                                                               Chapter 3
                                      Additional Drivers and Software Packages for HP-UX Itanium Systems




         Table 3-1    HP-UX Itanium Minimum Operating System Requirements

          Item                 Requirements
          HP-UX 11.31          HP-UX 11.31 September 2014 B.11.31.1409 or later.
          operating system
          Patches for HP-UX    The following patches must be installed:
          11.31
                               PHCO_43503 - 11.31 diskowner(1M) cumulative patch
                               PHKL_40941 - 11.31 scheduler cumulative patch
                               PHKL_42916 - 11.31 SCSI cumulative I/O patch
                               PHKL_42996 - 11.31 scheduler cumulative patch
                               PHKL_43775 - 11.31 vm cumulative patch
                               PHKL_44248 - 11.31 SCSI cumulative I/O patch
                               PHKL_44417 - 11.31 vm cumulative patch
                               PHKL_44565 - 11.31 vm cumulative patch
                               PHSS_37042 - 11.31 hppac
                               PHSS_39094 - 11.31 linker + fdp cumulative patch
                               PHSS_39102 - 11.31 Integrity Unwind Library
                               PHSS_42686 - 11.31 assembler patch
                               PHSS_43205 - 11.31 Math Library Cumulative Patch
                               PHSS_43291 - 11.31 X/Motif runtime patch
                               PHSS_43733 - 11.31 LIBCL patch
                               PHSS_43740 - 11.31 Integrity Unwind Library
                               PHSS_44164 - 11.31 linker + fdp cumulative patch
                               PHSS_44402 - 11.31 linker + fdp cumulative patch

          Oracle Clusterware   •   HP Serviceguard A.11.20
                               •   HP Serviceguard A.11.20 extension for RAC



                                                          Note:
                                                          HP Serviceguard is optional. It is
                                                          required only if you want to use shared
                                                          logical volumes for Oracle Clusterware or
                                                          database files.




Additional Drivers and Software Packages for HP-UX
Itanium Systems
         You are not required to install additional drivers and packages, but you may choose to
         install or configure these drivers and packages.

         •   Installation Requirements for ODBC and LDAP
             Review these topics to install Open Database Connectivity (ODBC) and
             Lightweight Directory Access Protocol (LDAP).




                                                                                                   3-3
                                                                                                  Chapter 3
                                         Additional Drivers and Software Packages for HP-UX Itanium Systems


            •   Installation Requirements for Programming Environments for HP-UX Itanium
                Systems
                Ensure that your system meets the requirements for the programming
                environment you want to configure.
            •   Installation Requirements for Web Browsers
                Web browsers are required only if you intend to use Oracle Enterprise Manager
                Database Express and Oracle Enterprise Manager Cloud Control. Web browsers
                must support JavaScript, and the HTML 4.0 and CSS 1.0 standards.


Installation Requirements for ODBC and LDAP
            Review these topics to install Open Database Connectivity (ODBC) and Lightweight
            Directory Access Protocol (LDAP).
            •   About ODBC Drivers and Oracle Database
                Open Database Connectivity (ODBC) is a set of database access APIs that
                connect to the database, prepare, and then run SQL statements on the database.
            •   Installing ODBC Drivers for HP-UX Itanium Systems
                If you intend to use ODBC, then download and install the most recent ODBC
                Driver Manager for HP-UX Itanium.
            •   About LDAP and Oracle Plug-ins
                Lightweight Directory Access Protocol (LDAP) is an application protocol for
                accessing and maintaining distributed directory information services over IP
                networks.
            •   Installing the LDAP Package
                LDAP is included in a default operating system installation.

About ODBC Drivers and Oracle Database
            Open Database Connectivity (ODBC) is a set of database access APIs that connect to
            the database, prepare, and then run SQL statements on the database.
            An application that uses an ODBC driver can access non-uniform data sources, such
            as spreadsheets and comma-delimited files.

Installing ODBC Drivers for HP-UX Itanium Systems
            If you intend to use ODBC, then download and install the most recent ODBC Driver
            Manager for HP-UX Itanium.
            http://www.unixodbc.org
            Review the minimum supported ODBC driver releases, and install ODBC drivers of the
            following or later releases for HP-UX Itanium:
            ODBC Driver Manager 2.3.4
            To use ODBC, you must also install gcc 4.2.3 or later.

About LDAP and Oracle Plug-ins
            Lightweight Directory Access Protocol (LDAP) is an application protocol for accessing
            and maintaining distributed directory information services over IP networks.




                                                                                                      3-4
                                                                                                       Chapter 3
                                              Additional Drivers and Software Packages for HP-UX Itanium Systems


            You require the LDAP package if you want to use features requiring LDAP, including
            the Oracle Database scripts odisrvreg and oidca for Oracle Internet Directory, or
            schemasync for third-party LDAP directories.

Installing the LDAP Package
            LDAP is included in a default operating system installation.
            If you did not perform a default operating system installation, and you intend to use
            Oracle scripts requiring LDAP, then use a package management system for your
            distribution to install a supported LDAP package for your distribution, and install any
            other required packages for that LDAP package.


Installation Requirements for Programming Environments for HP-UX
Itanium Systems
            Ensure that your system meets the requirements for the programming environment
            you want to configure.

            Table 3-2     Requirements for Programming Environments for HP-UX Itanium
            Systems

             Programming Environments             Support Requirements
             Java Database Connectivity           JDK 8 (1.8.0.202 or later) with the JNDI extension with
             (JDBC) / Oracle Call Interface       Oracle Java Database Connectivity and Oracle Call
             (OCI)                                Interface drivers.



                                                                              Note:
                                                                              These are not mandatory for
                                                                              the database installation.


             Oracle C++                           Compiler Version: A.06.28
             Oracle C++ Call Interface            Patch for HP-UX 11i V3 (11.31) on HP-UX Itanium:
             Pro*C/C++                            •   PHSS_40631 - 11.31 HP C/aC++ Compiler (A.06.24)
             Oracle XML Developer's Kit           •   PHSS_40633 - 11.31 u2comp/be/plugin (C.06.24)
             (XDK)                                •   PHSS_43741 - 11.31 aC++ Runtime (IA: A.06.28, PA:
                                                      A.03.90)



                                                                              Note:
                                                                              Additional patches may be
                                                                              needed depending on
                                                                              applications you deploy.


             Pro*COBOL                            Micro Focus Server Express 5.1
                                                  Micro Focus Visual COBOL for Eclipse 2.2 - Update 2
             Pro*FORTRAN                          HP FORTRAN/90 - Sep 2008 - release




                                                                                                            3-5
                                                                                                  Chapter 3
                                                      Checking the Software Requirements on HP-UX Itanium




           Table 3-2 (Cont.) Requirements for Programming Environments for HP-UX
           Itanium Systems

           Programming Environments          Support Requirements
           VERITAS File System               PHKL_44199 - 11.31 VRTS 5.0 MP1P13 VRTSvxfs Kernel
                                             Patch



                                                                        Note:
                                                                        The VERITAS file system is
                                                                        optional. This patch is
                                                                        required only if you want to
                                                                        use a VERITAS File System
                                                                        5.0.


           HP Caliper and Gmake              HP Caliper 5.7
                                             Gmake 3.81
           gcc                               gcc 4.2.3
           unzip                             Unzip 6.0 or later.
                                             Unzip is required to extract the image files for Oracle
                                             Database and Oracle Grid Infrastructure installations.


Installation Requirements for Web Browsers
           Web browsers are required only if you intend to use Oracle Enterprise Manager
           Database Express and Oracle Enterprise Manager Cloud Control. Web browsers must
           support JavaScript, and the HTML 4.0 and CSS 1.0 standards.
           https://support.oracle.com
           Related Topics
           •     Oracle Enterprise Manager Cloud Control Basic Installation Guide


Checking the Software Requirements on HP-UX Itanium
           Check your software to see if they meet the minimum version, compiler, and patch
           requirements for installation.
           1.    To determine the distribution and version of HP-UX installed:

                 # uname -a


                 HP-UX hostname B.11.31 U ia64 4156074294 unlimited-user license


                 In this example, the version of HP-UX is 11.31 and the processor is Itanium.




                                                                                                       3-6
                                                                                        Chapter 3
                                              Checking the Software Requirements on HP-UX Itanium


2.   To determine the compiler installed:

     # /usr/sbin/swlist -l product | grep -i compiler

3.   To determine if a patch is installed:

     # /usr/sbin/swlist -l patch | grep PHSS_42686


     Alternatively, to list all installed patches:

     # /usr/sbin/swlist -l patch | more


     If a required patch is not installed, then download it from the HP Support Center
     website and install it:
     https://www.support.hp.com/
     If the website has a recent version of the patch, then download and install that
     version.
4.   To verify if the system meets the minimum patch bundle requirements:

     # /usr/sbin/swlist -l bundle |grep QPK


     The QPK (Quality Pack) bundles have version numbers of the form B.
     11.31.0809.326a (for the September 2008 release), B.11.31.0903.334a (for the
     March 2009 release), and so on.
     If a required bundle, product, or fileset is not installed, then install it. See your
     operating system or software documentation for information about installing
     products.



             Note:
             There may be more recent versions of the patches listed in the
             preceding paragraph that are installed on the system. If a listed patch is
             not installed, then determine if a more recent version is installed before
             installing the version listed.

5.   If you require a CSD for WebSphere MQ, then refer to the following website for
     download and installation information:
     https://www.ibm.com/support/




                                                                                             3-7
4
Configuring Users, Groups and
Environments for Oracle Database Client
         Before installation, create operating system groups and users, and configure user
         environments.
         •   Required Operating System Groups and Users
             Oracle software installations require an installation owner, an Oracle Inventory
             group, which is the primary group of all Oracle installation owners, and at least one
             group designated as a system privileges group.
         •   Creating Operating System Oracle Installation User Accounts
             Before starting installation, create Oracle software owner user accounts, and
             configure their environments.
         •   Unsetting Oracle Installation Owner Environment Variables
             Unset Oracle installation owner environment variables before you start the
             installation.


Required Operating System Groups and Users
         Oracle software installations require an installation owner, an Oracle Inventory group,
         which is the primary group of all Oracle installation owners, and at least one group
         designated as a system privileges group.
         Review group and user options with your system administrator. If you have system
         administration privileges, then review the topics in this section and configure operating
         system groups and users as needed.
         •   Determining If an Oracle Inventory and Oracle Inventory Group Exist
             Determine if you have an existing Oracle central inventory, and ensure that you
             use the same Oracle Inventory for all Oracle software installations. Also, ensure
             that all Oracle software users you intend to use for installation have permissions to
             write to this directory.
         •   Creating the Oracle Inventory Group If an Oracle Inventory Does Not Exist
             Create an Oracle Inventory group manually as part of a planned installation,
             particularly where more than one Oracle software product is installed on servers.
         •   About Oracle Installation Owner Accounts
             Select or create an Oracle installation owner for your installation, depending on the
             group and user management plan you want to use for your installations.
         •   Identifying an Oracle Software Owner User Account
             You must create at least one software owner user account the first time you install
             Oracle software on the system. Either use an existing Oracle software user
             account, or create an Oracle software owner user account for your installation.




                                                                                               4-1
                                                                                              Chapter 4
                                                             Required Operating System Groups and Users




Determining If an Oracle Inventory and Oracle Inventory Group Exist
           Determine if you have an existing Oracle central inventory, and ensure that you use
           the same Oracle Inventory for all Oracle software installations. Also, ensure that all
           Oracle software users you intend to use for installation have permissions to write to
           this directory.
           When you install Oracle software on the system for the first time, OUI creates the
           oraInst.loc file. This file identifies the name of the Oracle Inventory group (by default,
           oinstall), and the path of the Oracle central inventory directory. If you have an
           existing Oracle central inventory, then ensure that you use the same Oracle Inventory
           for all Oracle software installations, and ensure that all Oracle software users you
           intend to use for installation have permissions to write to this directory.
           oraInst.loccentral_inventory_locationgroup

           inventory_loc=central_inventory_location
           inst_group=group


           Use the more command to determine if you have an Oracle central inventory on your
           system. For example:
           # more /var/opt/oracle/oraInst.loc

           inventory_loc=/u01/app/oraInventory
           inst_group=oinstall


           Use the command grep groupname /etc/group to confirm that the group
           specified as the Oracle Inventory group still exists on the system. For example:

           $ grep oinstall /etc/group
           oinstall:x:54321:grid,oracle



                  Note:
                  Do not put the oraInventory directory under the Oracle base directory for a
                  new installation, because that can result in user permission errors for other
                  installations.



Creating the Oracle Inventory Group If an Oracle Inventory Does Not
Exist
           Create an Oracle Inventory group manually as part of a planned installation,
           particularly where more than one Oracle software product is installed on servers.
           By default, if an oraInventory group does not exist, then the installer uses the primary
           group of the installation owner for the Oracle software being installed as the
           oraInventory group. Ensure that this group is available as a primary group for all
           planned Oracle software installation owners.




                                                                                                   4-2
                                                                                               Chapter 4
                                                              Required Operating System Groups and Users


           oraInst.loc

           # /usr/sbin/groupadd -g 54321 oinstall


About Oracle Installation Owner Accounts
           Select or create an Oracle installation owner for your installation, depending on the
           group and user management plan you want to use for your installations.
           You must create a software owner for your installation in the following circumstances:
           •   If an Oracle software owner user does not exist; for example, if this is the first
               installation of Oracle software on the system.
           •   If an Oracle software owner user exists, but you want to use a different operating
               system user, with different group membership, to separate Oracle Grid
               Infrastructure administrative privileges from Oracle Database administrative
               privileges.
           In Oracle documentation, a user created to own only Oracle Grid Infrastructure
           software installations is called the Grid user (grid). This user owns both the Oracle
           Clusterware and Oracle Automatic Storage Management binaries. A user created to
           own either all Oracle installations, or one or more Oracle database installations, is
           called the Oracle user (oracle). You can have only one Oracle Grid Infrastructure
           installation owner, but you can have different Oracle users to own different
           installations.
           Oracle software owners must have the Oracle Inventory group as their primary group,
           so that each Oracle software installation owner can write to the central inventory
           (oraInventory), and so that OCR and Oracle Clusterware resource permissions are set
           correctly. The database software owner must also have the OSDBA group and (if you
           create them) the OSOPER, OSBACKUPDBA, OSDGDBA, OSRACDBA, and
           OSKMDBA groups as secondary groups.


Identifying an Oracle Software Owner User Account
           You must create at least one software owner user account the first time you install
           Oracle software on the system. Either use an existing Oracle software user account, or
           create an Oracle software owner user account for your installation.
           To use an existing user account, obtain from you system administrator the name of an
           existing Oracle installation owner. Confirm that the existing owner is a member of the
           Oracle Inventory group.
           oinstalloinstall

           $ grep "oinstall" /etc/group
           oinstall:x:54321:oracle


           You can then use the ID command to verify that the Oracle installation owners you
           intend to use have the Oracle Inventory group as their primary group. For example:$
           id oracle

           uid=54321(oracle) gid=54321(oinstall) groups=54321(oper),54322(dba)




                                                                                                    4-3
                                                                                                  Chapter 4
                                                Creating Operating System Oracle Installation User Accounts


           After you create operating system groups, create or modify Oracle user accounts in
           accordance with your operating system authentication planning.


Creating Operating System Oracle Installation User
Accounts
           Before starting installation, create Oracle software owner user accounts, and configure
           their environments.
           Oracle software owner user accounts require resource settings and other environment
           configuration. To protect against accidents, Oracle recommends that you create one
           software installation owner account for each Oracle software program you install.
           •   Creating an Oracle Software Owner User
               If the Oracle software owner user (oracle ) does not exist, or if you require a new
               Oracle software owner user, then create it as described in this section.
           •   Environment Requirements for Oracle Software Owners
               You must make the following changes to configure Oracle software owner
               environments:
           •   Procedure for Configuring Oracle Software Owner Environments
               Configure each Oracle installation owner user account environment:
           •   Setting Remote Display and X11 Forwarding Configuration
               If you are on a remote terminal, and the local system has only one visual (which is
               typical), then use the following syntax to set your user account DISPLAY
               environment variable:


Creating an Oracle Software Owner User
           If the Oracle software owner user (oracle ) does not exist, or if you require a new
           Oracle software owner user, then create it as described in this section.
           The following example shows how to create the user oracle with the user ID 54321;
           with the primary group oinstall; and with secondary group dba.

           # /usr/sbin/useradd -u 54321 -g oinstall -G dba, oracle


           You must note the user ID number for installation users, because you need it during
           preinstallation.
           For Oracle Grid Infrastructure Installations, user IDs and group IDs must be identical
           on all candidate nodes.


Environment Requirements for Oracle Software Owners
           You must make the following changes to configure Oracle software owner
           environments:
           •   Set the installation software owner user (grid, oracle) default file mode creation
               mask (umask) to 022 in the shell startup file. Setting the mask to 022 ensures that
               the user performing the software installation creates files with 644 permissions.




                                                                                                      4-4
                                                                                                     Chapter 4
                                                   Creating Operating System Oracle Installation User Accounts


           •    Set ulimit settings for file descriptors and processes for the installation software
                owner (grid, oracle).
           •    Set the DISPLAY environment variable in preparation for running an Oracle
                Universal Installer (OUI) installation.



                    Caution:
                    If you have existing Oracle installations that you installed with the user ID
                    that is your Oracle Grid Infrastructure software owner, then unset all Oracle
                    environment variable settings for that user.



Procedure for Configuring Oracle Software Owner Environments
           Configure each Oracle installation owner user account environment:
           1.   Start an X terminal session (xterm) on the server where you are running the
                installation.
           2.   Enter the following command to ensure that X Window applications can display on
                this system, where hostname is the fully qualified name of the local host from
                which you are accessing the server:

                $ xhost + hostname

           3.   If you are not logged in as the software owner user, then switch to the software
                owner user you are configuring. For example, with the user grid:

                $ su - grid


                On systems where you cannot run su commands, use sudo instead:

                $ sudo -u grid -s

           4.   To determine the default shell for the user, enter the following command:

                $ echo $SHELL

           5.   Open the user's shell startup file in any text editor:
                •   Bash shell (bash):

                    $ vi .bash_profile

                •   Bourne shell (sh) or Korn shell (ksh):

                    $ vi .profile

                •   C shell (csh or tcsh):

                    % vi .login




                                                                                                         4-5
                                                                                          Chapter 4
                                        Creating Operating System Oracle Installation User Accounts


6.   Enter or edit the following line, specifying a value of 022 for the default file mode
     creation mask:

     umask 022

7.   If the ORACLE_SID, ORACLE_HOME, or ORACLE_BASE environment variables are set in
     the file, then remove these lines from the file.
8.   Save the file, and exit from the text editor.
9.   To run the shell startup script, enter one of the following commands:
     •   Bash shell:

         $ . ./.bash_profile

     •   Bourne, Bash, or Korn shell:

         $ . ./.profile

     •   C shell:

         % source ./.login

10. Use the following command to check the PATH environment variable:

     $ echo $PATH


     Remove any Oracle environment variables.
11. If you are not installing the software on the local system, then enter a command
     similar to the following to direct X applications to display on the local system:
     •   Bourne, Bash, or Korn shell:

         $ export DISPLAY=local_host:0.0

     •   C shell:

         % setenv DISPLAY local_host:0.0

     In this example, local_host is the host name or IP address of the system (your
     workstation, or another client) on which you want to display the installer.
12. If the /tmp directory has less than 1 GB of free space, then identify a file system
     with at least 1 GB of free space and set the TMP and TMPDIR environment variables
     to specify a temporary directory on this file system:



            Note:
            You cannot use a shared file system as the location of the temporary file
            directory (typically /tmp) for Oracle RAC installations. If you place /tmp
            on a shared file system, then the installation fails.




                                                                                              4-6
                                                                                                     Chapter 4
                                                   Creating Operating System Oracle Installation User Accounts


               a.   Use the df -h command to identify a suitable file system with sufficient free
                    space.
               b.   If necessary, enter commands similar to the following to create a temporary
                    directory on the file system that you identified, and set the appropriate
                    permissions on the directory:

                    $ sudo - s
                    # mkdir /mount_point/tmp
                    # chmod 775 /mount_point/tmp
                    # exit

               c.   Enter commands similar to the following to set the TMP and TMPDIR
                    environment variables:
                    Bourne, Bash, or Korn shell:

                    $ TMP=/mount_point/tmp
                    $ TMPDIR=/mount_point/tmp
                    $ export TMP TMPDIR


                    C shell:

                    % setenv TMP /mount_point/tmp
                    % setenv TMPDIR /mount_point/tmp

           13. To verify that the environment has been set correctly, enter the following
               commands:

               $ umask
               $ env | more


               Verify that the umask command displays a value of 22, 022, or 0022 and that the
               environment variables you set in this section have the correct values.


Setting Remote Display and X11 Forwarding Configuration
           If you are on a remote terminal, and the local system has only one visual (which is
           typical), then use the following syntax to set your user account DISPLAY environment
           variable:

           Remote Display
           Bourne, Korn, and Bash shells

           $ export DISPLAY=hostname:0


           C shell

           % setenv DISPLAY hostname:0




                                                                                                         4-7
                                                                                                 Chapter 4
                                                 Unsetting Oracle Installation Owner Environment Variables


         For example, if you are using the Bash shell and if your host name is local_host, then
         enter the following command:

         $ export DISPLAY=node1:0


         X11 Forwarding
         To ensure that X11 forwarding does not cause the installation to fail, use the following
         procedure to create a user-level SSH client configuration file for Oracle installation
         owner user accounts:
         1.   Using any text editor, edit or create the software installation owner's ~/.ssh/
              config file.
         2.   Ensure that the ForwardX11 attribute in the ~/.ssh/config file is set to no. For
              example:

              Host *
                  ForwardX11 no

         3.   Ensure that the permissions on ~/.ssh are secured to the Oracle installation
              owner user account. For example:

              $ ls -al .ssh
              total 28
              drwx------ 2 grid oinstall 4096 Jun 21 2015
              drwx------ 19 grid oinstall 4096 Jun 21 2015
              -rw-r--r-- 1 grid oinstall 1202 Jun 21 2015 authorized_keys
              -rwx------ 1 grid oinstall 668 Jun 21 2015 id_dsa
              -rwx------ 1 grid oinstall 601 Jun 21 2015 id_dsa.pub
              -rwx------ 1 grid oinstall 1610 Jun 21 2015 known_hosts


Unsetting Oracle Installation Owner Environment Variables
         Unset Oracle installation owner environment variables before you start the installation.
         The environment variables you have set for the Oracle installation owner account you
         use to run the installation can cause issues if they are set to values that conflict with
         the values needed for installation.
         If you have set ORA_CRS_HOME as an environment variable, following instructions
         from Oracle Support, then unset it before starting an installation or upgrade. You
         should never use ORA_CRS_HOME as an environment variable except under explicit
         direction from Oracle Support.
         If you have had an existing installation on your system, and you are using the same
         user account to install this installation, then unset the following environment variables:
         ORA_CRS_HOME, ORACLE_HOME, ORA_NLS10, TNS_ADMIN, and any other
         environment variable set for the Oracle installation user that is connected with Oracle
         software homes.
         Also, ensure that the $ORACLE_HOME/bin path is removed from your PATH environment
         variable.




                                                                                                     4-8
5
Installing Oracle Database Client
         Oracle Database Client installation software is available in multiple media, and can be
         installed using several options.
         The Oracle Database Client software is available on installation media, or you can
         download it from the Oracle Technology Network website, or the Oracle Software
         Delivery Cloud portal. In most cases, you use the graphical user interface (GUI)
         provided by Oracle Universal Installer (OUI) to install the software. However, you can
         also use Oracle Universal Installer to complete silent mode installations, without using
         the GUI.



                Note:
                You cannot use Oracle Universal Installer from an earlier Oracle release to
                install components from this release.



         •   About Image-Based Oracle Database Client Installation
             Starting with Oracle Database 19c, installation and configuration of Oracle
             Database Client software is simplified with image-based installation.
         •   Accessing the Installation Software
             You can download Oracle Database software from the Oracle Technology
             Network website or the Oracle Software Delivery Cloud portal. In some cases,
             Oracle Database software may be available on installation media also.
         •   About Character Set Selection During Installation
             Before you create the database, decide the character set that you want to use.
         •   Running the Installer in a Different Language
             Describes how to run the installer in other languages.
         •   Installing the Oracle Database Client Software
             These topics explain how to run the Setup Wizard to perform most database client
             installations.
         •   Relinking Oracle Database Client Binaries After Installation
             After an Oracle Database Client installation, if required, you can modify the
             binaries using the relink as_installed option.


About Image-Based Oracle Database Client Installation
         Starting with Oracle Database 19c, installation and configuration of Oracle Database
         Client software is simplified with image-based installation.
         To install Oracle Database Client, create the new Oracle home, extract the image file
         into the newly-created Oracle home, and run the setup wizard to register the Oracle
         Database product.




                                                                                              5-1
                                                                                                Chapter 5
                                                                      Accessing the Installation Software


           You must extract the image software (client_home.zip) into the directory where
           you want your Oracle Database Client home to be located, and then run the Setup
           Wizard to start the Oracle Database Client installation and configuration. Oracle
           recommends that the Oracle home directory path you create is in compliance with the
           Oracle Optimal Flexible Architecture recommendations.
           Using image-based installation, you can install Oracle Database Client 32-bit and 64-
           bit configurations of the Administrator installation type.
           As with Oracle Database and Oracle Grid Infrastructure image file installations, Oracle
           Database Client image installations simplify Oracle Database Client installations and
           ensure best practice deployments. Oracle Database Client installation binaries
           continue to be available in the traditional format as non-image zip files.


Accessing the Installation Software
           You can download Oracle Database software from the Oracle Technology Network
           website or the Oracle Software Delivery Cloud portal. In some cases, Oracle Database
           software may be available on installation media also.
           To install the software from the hard disk, you must either download it and unpack it,
           or copy it from the installation media, if you have it.
           •    Downloading Oracle Software
                Select the method you want to use to download the software.
           •    Downloading the Installation Archive Files from OTN
                Download installation archive files from Oracle Technology Network (OTN).
           •    Downloading the Software from Oracle Software Delivery Cloud Portal
                You can download the software from Oracle Software Delivery Cloud as Media
                Packs.
           •    Copying the Software to the Hard Disk
                Oracle recommends that you copy the installation software to the hard disk to
                enable the installation to run faster.


Downloading Oracle Software
           Select the method you want to use to download the software.
           You can download the trial version of the installation files from the Oracle Technology
           Network (OTN) or the Oracle Software Delivery Cloud portal and extract them on your
           hard disk. Ensure that you review and understand the terms of the license.


Downloading the Installation Archive Files from OTN
           Download installation archive files from Oracle Technology Network (OTN).
           1.   Use any browser to access the software download page from Oracle Technology
                Network:
                http://www.oracle.com/technetwork/indexes/downloads/index.html
           2.   Go to the download page for the product to install.
           3.   On the download page, identify the required disk space by adding the file sizes for
                each required file.




                                                                                                    5-2
                                                                                                    Chapter 5
                                                                          Accessing the Installation Software


                The file sizes are listed next to the file names.
           4.   Select a file system with enough free space to store and expand the archive files.
                In most cases, the available disk space must be at least twice the size of all of the
                archive files.
           5.   On the file system, create a parent directory for each product (for example,
                OraDB19c) to hold the installation directories.
           6.   Download all of the installation archive files to the directory you created for the
                product.



                       Note:
                       For Oracle Database Client installations, there are two installation
                       archive files available for download. The first file is the client installation
                       binary and the second file is a client gold image file. Download the
                       appropriate zip file based on the type of installation you want to perform.

           7.   Verify that the files you downloaded are the same size as the corresponding files
                on Oracle Technology Network. Also verify the checksums are the same as noted
                on Oracle Technology Network using a command similar to the following, where
                filename is the name of the file you downloaded:

                cksum filename.zip

           8.   Extract the files in each directory that you just created.


Downloading the Software from Oracle Software Delivery Cloud Portal
           You can download the software from Oracle Software Delivery Cloud as Media Packs.
           A Media Pack is an electronic version of the software that is also available to Oracle
           customers on CD-ROM or DVD.
           1.   Use any browser to access the Oracle Software Delivery Cloud portal:
                https://edelivery.oracle.com/
           2.   Complete the export validation process by entering information (name, company,
                email address, and country) in the online form.
           3.   In the Media Pack Search page, specify the product pack and platform to identify
                the media pack that you want to download. If you do not know the name of the
                product pack, then you can search for it using the license list.
           4.   Optionally, select the relevant product to download from the Results list.
           5.   In the search results page, click Readme to download and review the readme file
                for download instructions and product information.
           6.   After you review the readme file, select the media pack that you want to download
                from the search results to download the individual zip files for the media pack, and
                follow the Download Notes instructions in this page. After you download and
                extract the contents of the zip files, you can install the software.




                                                                                                        5-3
                                                                                                    Chapter 5
                                                                          Accessing the Installation Software




                        Note:
                        Print the page with the list of downloadable files. It contains a list of part
                        numbers and their corresponding descriptions that you may refer during
                        the installation process.

            7.   After you download the files, click View Digest to verify that the MD5 or SHA-1
                 checksum matches the value listed on the media download page.


Copying the Software to the Hard Disk
            Oracle recommends that you copy the installation software to the hard disk to enable
            the installation to run faster.
            Before copying the installation media content to the hard disk, you must mount the
            disk. Review these sections if you need instructions for how to mount the installation
            media and copy its contents to the hard disk.
            •    Mounting Disks on HP-UX Itanium Systems
                 On most HP-UX systems, the disk mounts automatically when you insert it into the
                 disk drive. If the disk does not mount automatically, then follow these steps to
                 mount it.

Mounting Disks on HP-UX Itanium Systems
            On most HP-UX systems, the disk mounts automatically when you insert it into the
            disk drive. If the disk does not mount automatically, then follow these steps to mount it.
            1.   If necessary, switch the user to root:

                 $ sudo - root

            2.   If necessary, unmount the currently mounted disc, then remove it from the drive:

                 # /usr/sbin/umount /SD_DVD


                 In this example, /SD_DVD is the mount point directory for the disc drive.
            3.   Insert the appropriate disc into the disc drive to mount it:

                 # /usr/sbin/mount -F cdfs -o rr /dev/dsk/cxtydz /SD_DVD


                 In this example, /SD_DVD is the disc mount point directory and /dev/dsk/
                 cxtydz is the device name for the disc device, for example /dev/dsk/c0t2d0.
            4.   If Oracle Universal Installer displays the Disk Location dialog box, enter the disc
                 mount point directory path, for example:

                 /SD_DVD




                                                                                                         5-4
                                                                                                 Chapter 5
                                                         About Character Set Selection During Installation




About Character Set Selection During Installation
          Before you create the database, decide the character set that you want to use.
          After a database is created, changing its character set is usually very expensive in
          terms of time and resources. Such operations may require converting all character
          data by exporting the whole database and importing it back. Therefore, it is important
          that you carefully select the database character set at installation time.
          Oracle Database uses character sets for the following:
          •   Data stored in SQL character data types (CHAR, VARCHAR2, CLOB, and LONG).
          •   Identifiers such as table names, column names, and PL/SQL variables.
          •   Stored SQL and PL/SQL source code, including text literals embedded in this
              code.
          Starting with Oracle Database 12c Release 2 (12.2), the default database character
          set of a database created from the General Purpose/Transaction Processing or the
          Data Warehousing template is Unicode AL32UTF8.

          Unicode is the universal character set that supports most of the currently spoken
          languages of the world. It also supports many historical scripts (alphabets). Unicode is
          the native encoding of many technologies, including Java, XML, XHTML, ECMAScript,
          and LDAP. Unicode is ideally suited for databases supporting the Internet and the
          global economy.
          Because AL32UTF8 is a multibyte character set, database operations on character data
          may be slightly slower when compared to single-byte database character sets, such as
          WE8ISO8859P1 or WE8MSWIN1252. Storage space requirements for text in most
          languages that use characters outside of the ASCII repertoire are higher in AL32UTF8
          compared to legacy character sets supporting the language. English data may require
          more space only if stored in CLOB (character large object) columns. Storage for non-
          character data types, such as NUMBER or DATE, does not depend on a character set.
          The universality and flexibility of Unicode usually outweighs these additional costs.
          Consider legacy character sets only when the database needs to support a single
          group of languages and the use of a legacy character set is critical for fulfilling
          compatibility, storage, or performance requirements. The database character set to be
          selected in this case is the character set of most clients connecting to this database.
          The database character set of a multitenant container database (CDB) determines
          which databases can be plugged in later. Ensure that the character set you choose for
          the CDB is compatible with the database character sets of the databases to be
          plugged into this CDB. If you use Unicode AL32UTF8 as your CDB character set, then
          you can plug in a pluggable database (PDB) in any database character set supported
          by Oracle Database (with the exception of EBCDIC-based character sets).



                 See Also:
                 Oracle Database Globalization Support Guide for more information about
                 choosing a database character set for a multitenant container database
                 (CDB)




                                                                                                     5-5
                                                                                                 Chapter 5
                                                             Running the Installer in a Different Language




Running the Installer in a Different Language
           Describes how to run the installer in other languages.
           Your operating system locale determines the language in which the database installer
           runs. You can run the installer in one of these languages:
           •   Brazilian Portuguese (pt_BR)
           •   French (fr)
           •   German (de)
           •   Italian (it)
           •   Japanese (ja)
           •   Korean (ko)
           •   Simplified Chinese (zh_CN)
           •   Spanish (es)
           •   Traditional Chinese (zh_TW)
           To run the database installer in a supported language, change the locale in which your
           operating system session is running before you start the installer.
           If the selected language is not one of the supported languages, then the installer runs
           in English.


Installing the Oracle Database Client Software
           These topics explain how to run the Setup Wizard to perform most database client
           installations.

           •   Running Setup Wizard to Install Oracle Database Client
               Use the runInstaller command to start the Oracle Database Client installation.
           •   Installing Oracle Database Client Using Image File
               Extract the Oracle Database Client image files and use the runInstaller
               command to start the Oracle Database Client installation.
           •   Using Oracle Net Configuration Assistant
               Run Oracle Net Configuration Assistant in standalone mode after the Oracle
               Database Client installation is complete to configure the listener, naming methods,
               net service names, and directory server usage.


Running Setup Wizard to Install Oracle Database Client
           Use the runInstaller command to start the Oracle Database Client installation.

           Have all the information you need to provide regarding users groups, and storage
           paths before you start the installation.
           Oracle recommends that you have your My Oracle Support credentials available
           during installation.




                                                                                                     5-6
                                                                                                  Chapter 5
                                                             Installing the Oracle Database Client Software


           During installation, you are asked to run configuration scripts as the root user. You
           can either run these scripts manually as root when prompted, or you can provide
           configuration information and passwords using a root privilege delegation option such
           as sudo.
           1.   Log in as the Oracle installation owner user account (oracle).
           2.   On the installation media, or where you have downloaded the installation binaries,
                run the runInstaller command to start the Oracle setup wizard.
                For example:
                •   On installation media:

                    /dev/dvd-rw/media/runInstaller

                •   On a hard disk:

                    $ cd /home/oracle_sw/
                    $ ./runInstaller



                       Note:
                       Run the runInstaller command from the Oracle home directory only.
                       Do not use the runInstaller command that resides
                       at $ORACLE_HOME/oui/bin/, or any other location, to install Oracle
                       Database, Oracle Database Client, or Oracle Grid Infrastructure.

           3.   Select your installation type.
                Installation screens vary depending on the installation option you select. Respond
                to the configuration prompts as needed.



                       Note:
                       At any time during installation, if you have a question about what you are
                       being asked to do, click Help.


Installing Oracle Database Client Using Image File
           Extract the Oracle Database Client image files and use the runInstaller command
           to start the Oracle Database Client installation.
           Starting with 19c, the Oracle Database Client software is also available as an image
           file for download and installation.
           Have all the information you need to provide regarding storage paths before you start
           the installation. Oracle recommends that you have your My Oracle Support credentials
           available during installation. During installation, you are asked to run configuration
           scripts as the root user. You must run these scripts manually as root when prompted.

           1.   Log in as the Oracle installation owner user account (oracle).




                                                                                                      5-7
                                                                                       Chapter 5
                                                  Installing the Oracle Database Client Software


2.   Download the Oracle Database Client installation image files
     (client_home.zip) to a directory of your choice. For example, you can
     download the image files to the /tmp directory.
3.   Create the Oracle home directory and extract the image files that you have
     downloaded in to this Oracle home directory. For example:

     $ mkdir -p /u01/app/oracle/product/19.0.0/client_1
     $ chgrp oinstall /u01/app/oracle/product/19.0.0/client_1
     $ cd /u01/app/oracle/product/19.0.0/client_1
     $ unzip -q /tmp/client_home.zip



            Note:
            Oracle recommends that the Oracle home directory path you create is in
            compliance with the Oracle Optimal Flexible Architecture
            recommendations. Also, unzip the installation image files only in this
            Oracle home directory that you created.

4.   From the Oracle home directory, run the runInstaller command to start the
     Oracle Database Client Setup Wizard.

     $ cd /u01/app/oracle/product/19.0.0/client_1
     $ ./runInstaller



            Note:
            Run the runInstaller command from the Oracle home directory only.
            Do not use the runInstaller command that resides
            at $ORACLE_HOME/oui/bin/, or any other location, to install Oracle
            Database, Oracle Database Client, or Oracle Grid Infrastructure.

5.   The setup wizard starts an Administrator type installation of Oracle Database
     Client.
     Installation screens vary depending on the installation option you select. Respond
     to the configuration prompts as needed.



            Note:
            At any time during installation, if you have a question about what you are
            being asked to do, click Help.




                                                                                           5-8
                                                                                                    Chapter 5
                                                  Relinking Oracle Database Client Binaries After Installation




Using Oracle Net Configuration Assistant
           Run Oracle Net Configuration Assistant in standalone mode after the Oracle Database
           Client installation is complete to configure the listener, naming methods, net service
           names, and directory server usage.
           Oracle recommends that you have information ready about the host name of the
           computer where the Oracle database is installed.
           To start Oracle Net Configuration Assistant in standalone mode:
           1.   Run netca from the $ORACLE_HOME/bin directory.
           2.   Respond to the configuration prompts and screens as needed. The screens vary
                depending on the options you select. At any time during the configuration, if you
                have a question about what you are being asked to do, click Help.
           Related Topics
           •    Oracle Database Net Services Administrator's Guide


Relinking Oracle Database Client Binaries After Installation
           After an Oracle Database Client installation, if required, you can modify the binaries
           using the relink as_installed option.

           For example, you might want to relink the Oracle Database Client binaries every time
           you apply an operating system patch or after an operating system upgrade.



                   Caution:
                   Before relinking executables, you must shut down all executables that run in
                   the Oracle home directory that you are relinking. In addition, shut down
                   applications linked with Oracle shared libraries.


           1.   Login as the Oracle Database Client owner user (oracle).
           2.   Set the ORACLE_HOME environment variable

                $ ORACLE_HOME=/u01/app/oracle/product/19.0.0/client_1

           3.   Go to the $ORACLE_HOME/bin directory:

                $ cd $ORACLE_HOME/bin

           4.   Run the relink script with the as_installed option to relink the binaries.

                $ ./relink as_installed


                The relinking is complete and the log files are generated under
                the $ORACLE_HOME/install directory.




                                                                                                         5-9
6
Oracle Database Client Postinstallation
Tasks
           Complete configuration tasks after you install Oracle Database.
           You are required to complete some configuration tasks after Oracle Database Client is
           installed. In addition, Oracle recommends that you complete additional tasks
           immediately after installation. You must also complete product-specific configuration
           tasks before you use those products.



                   Note:
                   This chapter describes basic configuration only. Refer to product-specific
                   administration and tuning guides for more detailed configuration and tuning
                   information.



           •    Required Postinstallation Tasks
                Download and apply required patches for your software release after completing
                your initial installation.
           •    Recommended Postinstallation Tasks
                Oracle recommends that you complete these tasks after installation.


Required Postinstallation Tasks
           Download and apply required patches for your software release after completing your
           initial installation.
           •    Downloading and Installing Release Update Patches
                Download and install Release Updates (RU) and Release Update Revisions
                (RUR) patches for your Oracle software after you complete installation.


Downloading and Installing Release Update Patches
           Download and install Release Updates (RU) and Release Update Revisions (RUR)
           patches for your Oracle software after you complete installation.
           Starting with Oracle Database 18c, Oracle provides quarterly updates in the form of
           Release Updates (RU) and Release Update Revisions (RUR). Oracle no longer
           releases patch sets. For more information, see My Oracle Support Note 2285040.1.
           Check the My Oracle Support website for required updates for your installation.
           1.   Use a web browser to view the My Oracle Support website:
                https://support.oracle.com
           2.   Log in to My Oracle Support website.




                                                                                                 6-1
                                                                                            Chapter 6
                                                                   Recommended Postinstallation Tasks




                       Note:
                       If you are not a My Oracle Support registered user, then click Register
                       for My Oracle Support and register.

           3.   On the main My Oracle Support page, click Patches & Updates.
           4.   In the Patch Search region, select Product or Family (Advanced).
           5.   On the Product or Family (Advanced) display, provide information about the
                product, release, and platform for which you want to obtain patches, and click
                Search.
                The Patch Search pane opens, displaying the results of your search.
           6.   Select the patch number and click ReadMe.
                The README page is displayed. It contains information about the patch and how
                to apply the patches to your installation.
           7.   Uncompress the Oracle patch updates that you downloaded from My Oracle
                Support.
           Related Topics
           •    My Oracle Support note 2285040.1


Recommended Postinstallation Tasks
           Oracle recommends that you complete these tasks after installation.
           •    Creating a Backup of the root.sh Script
                Oracle recommends that you back up the root.sh script after you complete an
                installation.
           •    Setting Language and Locale Preferences for Client Connections
                Configure client applications connecting to an Oracle Database according to your
                locale preferences and your I/O device character set.


Creating a Backup of the root.sh Script
           Oracle recommends that you back up the root.sh script after you complete an
           installation.
           If you install other products in the same Oracle home directory subsequent to this
           installation, then Oracle Universal Installer updates the contents of the existing
           root.sh script during the installation. If you require information contained in the
           original root.sh script, then you can recover it from the backed up root.sh file.


Setting Language and Locale Preferences for Client Connections
           Configure client applications connecting to an Oracle Database according to your
           locale preferences and your I/O device character set.
           You must configure client applications connecting to an Oracle Database according to
           your locale preferences and your I/O device character set. If your applications do not
           have their own specific methods to configure locale preferences, then the method you




                                                                                                 6-2
                                                                                   Chapter 6
                                                         Recommended Postinstallation Tasks


use to configure an Oracle database client connection depends on the access API you
use to connect to the database. Check your application documentation, before you
configure locale preferences for your applications.
For applications that connect to Oracle Databases using Oracle Call Interface (OCI)
use NLS_LANG and other client settings with names that start with NLS_ to set the
locale conventions and client character set for Oracle Database sessions. It is
important that you set the character set part of the NLS_LANG value properly. The
character set you set must correspond to the character set used by your I/O devices,
which in case of Microsoft Windows is either the ANSI Code Page (for GUI
applications), such as WE8MSWIN1252, or the OEM Code Page (for Console mode
applications), such as US8PC437. By doing this, the OCI API is notified about the
character set of data that it receives from the application. OCI can then convert this
data correctly to and from the database character set.
NLS_LANG and the other NLS settings can be specified either as environment
variables or as Windows Registry settings. Environment variable values take
precedence over Registry values.
Oracle Universal Installer sets a default value for the NLS_LANG setting in Registry
when it creates a new Oracle home on Microsoft Windows. The NLS_LANG value is
based on the language of the Windows user interface, which is the language of
Windows menu items and dialog box labels.



       Caution:
       Failure to set the client character set correctly can cause data loss.


Java applications that connect to Oracle Databases by using Oracle JDBC do not use
NLS_LANG. Instead, Oracle JDBC maps the default locale of the Java VM in which
the application runs to the Oracle Database language and territory settings. Oracle
JDBC then configures the connected database session using these settings. Because
Java works internally in Unicode, the client character set is always set to Unicode.
Unless an application explicitly changes it, the default locale of the Java VM is set
based on the locale of the user operating system on which the Java VM runs. Check
your Java VM documentation for information about configuring the Java VM default
locale.



       Note:
       In 3-tier architecture deployments, application servers that are database
       clients can have settings in their configuration files that specify the
       NLS_LANG value or the Java VM locale. Check the documentation
       accompanying these servers.




       See Also:
       Oracle Database Globalization Support Guide for more information about
       configuring user locale preferences




                                                                                       6-3
7
Removing Oracle Database Software
          These topics describe how to remove Oracle software and configuration files.
          Use the deinstall command that is included in Oracle homes to remove Oracle
          software. Oracle does not support the removal of individual products or components.



                 Caution:
                 If you have a standalone database on a node in a cluster, and if you have
                 multiple databases with the same global database name (GDN), then you
                 cannot use the deinstall command to remove one database only.



          •   About Oracle Deinstallation Options
              You can stop and remove Oracle Database software and components in an Oracle
              Database home with the deinstall command.
          •   Oracle Deinstallation (Deinstall)
              You can run the deinstall command from an Oracle home directory after
              installation.
          •   Deinstallation Examples for Oracle Database Client
              Use these examples to help you understand how to run the deinstall
              command.


About Oracle Deinstallation Options
          You can stop and remove Oracle Database software and components in an Oracle
          Database home with the deinstall command.

          You can remove the following software using deinstall :

          •   Oracle Database
          •   Oracle Grid Infrastructure, which includes Oracle Clusterware and Oracle
              Automatic Storage Management (Oracle ASM)
          •   Oracle Real Application Clusters (Oracle RAC)
          •   Oracle Database Client
          The deinstall command is available in Oracle home directories after installation. It
          is located in the $ORACLE_HOME/deinstall directory.

          deinstall creates a response file by using information in the Oracle home and using
          the information you provide. You can use a response file that you generated previously
          by running the deinstall command using the -checkonly option. You can also
          edit the response file template.




                                                                                             7-1
                                                                                    Chapter 7
                                                          About Oracle Deinstallation Options


If you run deinstall to remove an Oracle Grid Infrastructure installation, then the
deinstaller prompts you to run the deinstall command as the root user. For Oracle
Grid Infrastructure for a cluster, the script is rootcrs.sh, and for Oracle Grid
Infrastructure for a standalone server (Oracle Restart), the script is roothas.sh.



       Note:

       •    You must run the deinstall command from the same release to
            remove Oracle software. Do not run the deinstall command from a
            later release to remove Oracle software from an earlier release. For
            example, do not run the deinstall command from the 19c Oracle
            home to remove Oracle software from an existing 11.2.0.4 Oracle home.
       •    Starting with Oracle Database 12c Release 1 (12.1.0.2), the
            roothas.sh script replaces the roothas.pl script in the Oracle Grid
            Infrastructure home for Oracle Restart, and the rootcrs.sh script
            replaces the rootcrs.pl script in the Grid home for Oracle Grid
            Infrastructure for a cluster.


If the software in the Oracle home is not running (for example, after an unsuccessful
installation), then deinstall cannot determine the configuration, and you must
provide all the configuration details either interactively or in a response file.
In addition, before you run deinstall for Oracle Grid Infrastructure installations:

•   Dismount Oracle Automatic Storage Management Cluster File System (Oracle
    ACFS) and disable Oracle Automatic Storage Management Dynamic Volume
    Manager (Oracle ADVM).
•   If Grid Naming Service (GNS) is in use, then notify your DNS administrator to
    delete the subdomain entry from the DNS.

Files Deleted by deinstall
When you run deinstall, if the central inventory (oraInventory) contains no other
registered homes besides the home that you are deconfiguring and removing, then
deinstall removes the following files and directory contents in the Oracle base
directory of the Oracle Database installation owner:
•   admin
•   cfgtoollogs
•   checkpoints
•   diag
•   oradata
•   fast_recovery_area
Oracle strongly recommends that you configure your installations using an Optimal
Flexible Architecture (OFA) configuration, and that you reserve Oracle base and
Oracle home paths for exclusive use of Oracle software. If you have any user data in
these locations in the Oracle base that is owned by the user account that owns the
Oracle software, then deinstall deletes this data.




                                                                                        7-2
                                                                                               Chapter 7
                                                                        Oracle Deinstallation (Deinstall)




                Caution:
                deinstall deletes Oracle Database configuration files, user data, and fast
                recovery area (FRA) files even if they are located outside of the Oracle base
                directory path.



Oracle Deinstallation (Deinstall)
          You can run the deinstall command from an Oracle home directory after
          installation.

          Purpose
          deinstall stops Oracle software, and removes Oracle software and configuration
          files on the operating system for a specific Oracle home.

          Syntax
          The deinstall command uses the following syntax:

          (./deinstall [-silent] [-checkonly] [-paramfile complete path of input
          response file]
          [-params name1=value name2=value . . .]
          [-o complete path of directory for saving files]
          [-tmpdir complete path of temporary directory to use]
          [-logdir complete path of log directory to use] [-help]


          Parameters


           Parameter                                 Description
           -silent                                   Use this flag to run deinstall in
                                                     noninteractive mode. This option requires one
                                                     of the following:
                                                     •    A working system that it can access to
                                                          determine the installation and
                                                          configuration information. The -silent
                                                          flag does not work with failed installations.
                                                     •    A response file that contains the
                                                          configuration values for the Oracle home
                                                          that is being deinstalled or deconfigured.
                                                     You can generate a response file to use or
                                                     modify by running the deinstall command
                                                     with the -checkonly flag. deinstall then
                                                     discovers information from the Oracle home to
                                                     deinstall and deconfigure. It generates the
                                                     response file that you can then use with the -
                                                     silent option.
                                                     You can also modify the template file
                                                     deinstall.rsp.tmpl, located in
                                                     the $ORACLE_HOME/deinstall/
                                                     response directory.




                                                                                                    7-3
                                                                                              Chapter 7
                                                     Deinstallation Examples for Oracle Database Client




          Parameter                                  Description
          -checkonly                                 Use this flag to check the status of the Oracle
                                                     software home configuration. Running
                                                     deinstall with the -checkonly flag does
                                                     not remove the Oracle configuration. The -
                                                     checkonly flag generates a response file that
                                                     you can use with the deinstall command
                                                     and -silent option.
          -paramfile complete path of input          Use this flag to run deinstall with a
          response file                              response file in a location other than the
                                                     default. When you use this flag, provide the
                                                     complete path where the response file is
                                                     located.
                                                     The default location of the response file
                                                     is $ORACLE_HOME/deinstall/
                                                     response.
          -params [name1=value name2=value           Use this flag with a response file to override
          name3=value . . .]                         one or more values to change in a response
                                                     file you have created.
          -o complete path of directory for saving   Use this flag to provide a path other than the
          response files                             default location where the response file
                                                     (deinstall.rsp.tmpl) is saved.
                                                     The default location of the response file
                                                     is $ORACLE_HOME/deinstall/
                                                     response .
          -tmpdircomplete path of temporary          Use this flag to specify a non-default location
          directory to use                           where deinstall writes the temporary files
                                                     for the deinstallation.
          -logdircomplete path of log directory to   Use this flag to specify a non-default location
          use                                        where deinstall writes the log files for the
                                                     deinstallation.
          -local                                     Use this flag on a multinode environment to
                                                     deinstall Oracle software in a cluster.
                                                     When you run deinstall with this flag, it
                                                     deconfigures and deinstalls the Oracle
                                                     software on the local node (the node where
                                                     deinstall is run). On remote nodes, it
                                                     deconfigures Oracle software, but does not
                                                     deinstall the Oracle software.
          -help                                      Use this option to obtain additional information
                                                     about the command option flags.



Deinstallation Examples for Oracle Database Client
         Use these examples to help you understand how to run the deinstall command.

         You can run deinstall from the $ORACLE_HOME/deinstall directory. The
         deinstallation starts without prompting you for the Oracle home path.

         $ ./deinstall




                                                                                                    7-4
                                                                                     Chapter 7
                                            Deinstallation Examples for Oracle Database Client


If you have a response file, then use the optional flag -paramfile to provide a path
to the response file.
You can generate a deinstallation response file by running the deinstall command
with the -checkonly flag. Alternatively, you can use the response file template
located at $ORACLE_HOME/deinstall/response/deinstall.rsp.tmpl.

In the following example, the deinstall command is in the path/u01/app/oracle/
product/19.0.0/client_1/deinstall. It uses a response file called
my_db_paramfile.tmpl in the software owner location /home/usr/oracle:

$ cd /u01/app/oracle/product/19.0.0/client_1/deinstall
$ ./deinstall -paramfile /home/usr/oracle/my_db_paramfile.tmpl




                                                                                         7-5
A
Installing and Configuring Oracle Database
Using Response Files
        Review the following topics to install and configure Oracle products using response
        files.
        •   How Response Files Work
            Response files can assist you with installing an Oracle product multiple times on
            multiple computers.
        •   Reasons for Using Silent Mode or Response File Mode
            Review this section for use cases for running the installer in silent mode or
            response file mode.
        •   Using Response Files
            Review this information to use response files.
        •   Preparing Response Files
            Review this information to prepare response files for use during silent mode or
            response file mode installations.
        •   Running Oracle Universal Installer Using a Response File
            After creating the response file, run Oracle Univeral Installer at the command line,
            specifying the response file you created, to perform the installation.


How Response Files Work
        Response files can assist you with installing an Oracle product multiple times on
        multiple computers.
        When you start Oracle Universal Installer (OUI), you can use a response file to
        automate the installation and configuration of Oracle software, either fully or partially.
        OUI uses the values contained in the response file to provide answers to some or all
        installation prompts.
        Typically, the installer runs in interactive mode, which means that it prompts you to
        provide information in graphical user interface (GUI) screens. When you use response
        files to provide this information, you run the installer from a command prompt using
        either of the following modes:
        •   Silent mode
            If you include responses for all of the prompts in the response file and specify the
            -silent option when starting the installer, then it runs in silent mode. During a
            silent mode installation, the installer does not display any screens. Instead, it
            displays progress information in the terminal that you used to start it.
        •   Response file mode
            If you include responses for some or all of the prompts in the response file and
            omit the -silent option, then the installer runs in response file mode. During a
            response file mode installation, the installer displays all the screens, screens for




                                                                                                A-1
                                                                                                Appendix A
                                                       Reasons for Using Silent Mode or Response File Mode


              which you specify information in the response file, and also screens for which you
              did not specify the required information in the response file.
         You define the settings for a silent or response file installation by entering values for
         the variables listed in the response file. For example, to specify the Oracle home
         name, provide the Oracle home path for the ORACLE_HOME environment variable:

         ORACLE_HOME=/u01/app/oracle/product/19.0.0/dbhome_1



Reasons for Using Silent Mode or Response File Mode
         Review this section for use cases for running the installer in silent mode or response
         file mode.


         Mode               Uses
         Silent             Use silent mode for the following installations:
                            •    Complete an unattended installation, which you schedule using
                                 operating system utilities such as at.
                            •    Complete several similar installations on multiple systems without user
                                 interaction.
                            •    Install the software on a system that does not have X Window System
                                 software installed on it.
                            The installer displays progress information on the terminal that you used to
                            start it, but it does not display any of the installer screens.
         Response file      Use response file mode to complete similar Oracle software installations on
                            more than one system, providing default answers to some, but not all of the
                            installer prompts.



Using Response Files
         Review this information to use response files.
         Use the following general steps to install and configure Oracle products using the
         installer in silent or response file mode:



                  Note:
                  You must complete all required preinstallation tasks on a system before
                  running the installer in silent or response file mode.



         1.   Prepare a response file.
         2.   Run the installer in silent or response file mode.
         3.   Run the root scripts as prompted by Oracle Universal Installer.
         4.   If you completed a software-only installation, then run Net Configuration Assistant
              and Oracle DBCA in silent or response file mode to create the database listener
              and an Oracle Database instance respectively.




                                                                                                     A-2
                                                                                                Appendix A
                                                                                  Preparing Response Files




Preparing Response Files
           Review this information to prepare response files for use during silent mode or
           response file mode installations.

           •    Editing a Response File Template
                For Oracle Database Client, response files are located in the $ORACLE_HOME/
                response directory.
           •    Recording Response Files
                You can use Oracle Universal Installer (OUI) in interactive mode to record
                response files, which you can then edit and use to complete silent mode or
                response file mode installations.


Editing a Response File Template
           For Oracle Database Client, response files are located in the $ORACLE_HOME/
           response directory.

           All response file templates contain comment entries, sample formats, examples, and
           other useful instructions. Please read these instructions as they help you specify
           values for the variables listed in the response files and customize your installation.
           The following table lists the response files provided with this software:

           Table A-1    Response Files for Oracle Database Client

           Response File           Description
           client_install.rsp Silent installation of Oracle Database Client
           netca.rsp               Silent configuration of Oracle Net using Oracle Net Configuration
                                   Assistant.



                   Caution:
                   When you modify a response file template and save a file for use, the
                   response file may contain plain text passwords. Ownership of the response
                   file should be given to the Oracle software installation owner only, and
                   permissions on the response file should be changed to 600. Oracle strongly
                   recommends that database administrators or other administrators delete or
                   secure response files when they are not in use.



           To copy and modify a response file:
           1.   Copy the response file from the response file directory to a directory on your
                system:
                $ cp /directory_path/inventory/response/response_file.rsp local_directory

                In this example, directory_path is the path of the directory where you have
                copied the installation binaries.




                                                                                                       A-3
                                                                                             Appendix A
                                                                               Preparing Response Files


          2.   Open the response file in a text editor:
               $ vi /local_dir/response_file.rsp
          3.   Follow the instructions in the file to edit it.



                       Note:
                       The installer or configuration assistant fails if you do not correctly
                       configure the response file. Also, ensure that your response file name
                       has the .rsp suffix.


          4.   Secure the response file by changing the permissions on the file to 600:
               $ chmod 600 /local_dir/response_file.rsp

               Ensure that only the Oracle software owner user can view or modify response files
               or consider deleting them after the installation succeeds.



                       Note:
                       A fully-specified response file for an Oracle Database Client installation
                       contains the passwords for database administrative accounts and for a
                       user who is a member of the OSDBA group (required for automated
                       backups).



Recording Response Files
          You can use Oracle Universal Installer (OUI) in interactive mode to record response
          files, which you can then edit and use to complete silent mode or response file mode
          installations.
          You can save all the installation steps into a response file during installation by clicking
          Save Response File on the Summary page. You can use the generated response file
          for a silent installation later.
          When you record the response file, you can either complete the installation, or you can
          exit from the installer on the Summary page, before OUI starts to set up the software
          to the system.
          If you use record mode during a response file mode installation, then the installer
          records the variable values that were specified in the original source response file into
          the new response file.



                  Note:
                  OUI does not save passwords while recording the response file.



          To record a response file:
          1.   Complete preinstallation tasks for an Oracle Database Client installation.



                                                                                                    A-4
                                                                                                 Appendix A
                                                    Running Oracle Universal Installer Using a Response File


              When you run the installer to record a response file, it checks the system to verify
              that it meets the requirements to install the software. For this reason, Oracle
              recommends that you complete all of the required preinstallation tasks and record
              the response file while completing an installation.
         2.   Ensure that the Oracle software owner user (typically oracle) has permissions to
              create or write to the Oracle home path that you will specify when you run the
              installer.
         3.   On each installation screen, specify the required information.
         4.   When OUI displays the Summary screen, perform the following steps:
              a.   Click Save Response File. In the window, specify a file name and location for
                   the new response file. Click Save to write the responses you entered to the
                   response file.
              b.   Click Finish to continue with the installation.
                   Click Cancel if you do not want to continue with the installation. The
                   installation stops, but the recorded response file is retained.



                          Note:
                          Ensure that your response file name has the .rsp suffix.

         5.   Before you use the saved response file on another system, edit the file and make
              any required changes. Use the instructions in the file as a guide when editing it.


Running Oracle Universal Installer Using a Response File
         After creating the response file, run Oracle Univeral Installer at the command line,
         specifying the response file you created, to perform the installation.
         Run Oracle Universal Installer at the command line, specifying the response file you
         created. The Oracle Universal Installer executable, runInstaller, provides several
         options. For help information on the full set of these options, run the runInstaller
         command with the -help option. For example:
         $ directory_path/runInstaller -help

         The help information appears in a window after some time.
         To run the installer using a response file:
         1.   Complete the preinstallation tasks as for a normal installation
         2.   Log in as the software installation owner user.
         3.   If you are completing a response file mode installation, then set the operating
              system DISPLAY environment variable for the user running the installation.



                      Note:
                      You do not have to set the DISPLAY environment variable if you are
                      completing a silent mode installation.




                                                                                                       A-5
                                                                                       Appendix A
                                          Running Oracle Universal Installer Using a Response File


4.   To start the installer in silent or response file mode, enter a command similar to
     the following:
     $ /directory_path/runInstaller [-silent] [-noconfig] \
      -responseFile responsefilename



            Note:
            Do not specify a relative path to the response file. If you specify a
            relative path, then the installer fails.


     In this example:
     •   directory_pathis the path of the directory where you have copied the
         installation binaries.
     •   -silent runs the installer in silent mode.
     •   -noconfig suppresses running the configuration assistants during installation,
         and a software-only installation is performed instead.
     •   responsefilename is the full path and file name of the installation response file
         that you configured.
5.   If this is the first time you are installing Oracle software on your system, then
     Oracle Universal Installer prompts you to run the orainstRoot.sh script.
     Log in as the root user and run the orainstRoot.sh script:
     $ su root
     password:
     # /u01/app/oraInventory/orainstRoot.sh



            Note:
            You do not have to manually create the oraInst.loc file. Running the
            orainstRoot.sh script is sufficient as it specifies the location of the
            Oracle Inventory directory.

6.   When the installation completes, log in as the root user and run the root.sh
     script. For example
     $ su root
     password:
     # /oracle_home_path/root.sh




                                                                                             A-6
Index
Numerics                                    disks
                                                mounting, 5-4
32–bit client software, 1-5                 display variable, 1-4

B                                           E
Bash shell                                  enterprise.rsp file, A-3
   default user startup file, 4-5           environment variables
bash_profile file, 4-5                          ORACLE_BASE, 4-5
Bourne shell                                    ORACLE_HOME, 4-5
   default user startup file, 4-5               ORACLE_SID, 4-5
                                                removing from shell startup file, 4-5
                                                SHELL, 4-5
C                                               TEMP and TMPDIR, 4-5
C shell                                     errors
    default user startup file, 4-5              X11 forwarding, 4-7
CDBs
    character sets, 5-5                     F
central inventory
    See Oracle inventory directory          file mode creation mask
character sets, 5-5                               setting, 4-4
checklists                                  files
    and installation planning, 1-1                bash_profile, 4-5
command syntax conventions, viii                  dbca.rsp, A-3
commands                                          editing shell startup file, 4-5
    /usr/sbin/swapinfo, 2-2                       enterprise.rsp, A-3
    bdf, 2-2                                      login, 4-5
    grep -i Memory, 2-2                           profile, 4-5
    kctune, 2-2                                   response files, A-3
    root.sh, 6-2                            filesets, 3-2
    umask, 4-4
    useradd, 4-4
cron jobs, 1-5                              G
                                            globalization, 1-5
D                                               localization for client connections, 6-2
                                                NLS_LANG
dbca.rsp file, A-3                                  and client connections, 6-2
default file mode creation mask             groups
    setting, 4-4                                creating an Oracle Inventory Group, 4-2
deinstall, 7-1                                  OINSTALL group, 1-2
        See also removing Oracle software
deinstall command, 7-1
deinstallation, 7-1
    examples, 7-4
df command, 4-5



                                                                                        Index-1
                                                                                                    Index



H                                                  OINSTALL groupl, 1-4
                                                           See also Oracle Inventory directory
hardware requirements, 1-1                         operating system
    display, 1-1                                       different on cluster members, 3-2
                                                       requirements, 3-2
                                                   operating system privileges groups, 1-4
I                                                  operating system requirements, 1-2
image                                              ORAchk
    install, 5-1                                       and Upgrade Readiness Assessment, 1-5
installation, 5-7                                  Oracle Database Client
    accessing installation software, 5-2               image-based installation, 5-7
    response files, A-3                                installation, 5-1
          preparing, A-3, A-4                      Oracle Database Client, installation, 5-6, 5-7
          templates, A-3                           Oracle Database Client, relinking, 5-9
    silent mode, A-6                               Oracle Database Configuration Assistant
installation planning, 1-1                             response file, A-3
installation software, accessing, 5-2              Oracle home
installer                                              ASCII path restriction for, 1-2
    supported languages, 5-6                       Oracle Inventory, 1-4
                                                       identifying existing, 4-2
                                                   Oracle Net Configuration Assistant
J                                                      response file, A-3
                                                   Oracle Net Configuration Assistant, installation,
JDK requirements, 3-2
                                                            5-9
                                                   Oracle Software Owner user
K                                                      creating, 4-3, 4-4
                                                   Oracle Software Owner users
Korn shell                                             determining default shell, 4-5
   default user startup file, 4-5                  Oracle Universal Installer
                                                       response files
L                                                           list of, A-3
                                                   oracle user, 1-4
licensing, 1-5                                         creating, 4-3
login file, 4-5                                    Oracle user
                                                       determining default shell, 4-5
M                                                  ORACLE_BASE environment variable
                                                       removing from shell startup file, 4-5
mask                                               ORACLE_HOME environment variable
    setting default file mode creation mask, 4-4       removing from shell startup file, 4-5
mixed binaries, 3-2                                ORACLE_SID environment variable
mode                                                   removing from shell startup file, 4-5
    setting default file mode creation mask, 4-4   OSDBA, 1-4
multitenant container database                     OTN website
    character sets, 5-5                                downloading installation software from, 5-2

N                                                  P
netca.rsp file, A-3                                patch updates, 6-1
noninteractive mode                                postinstallation
    See response file mode                             recommended tasks
                                                             root.sh script, backing up, 6-2
O                                                  profile file, 4-5

oinstall group
    creating, 4-2



                                                                                                 Index-2
                                                                                                    Index



R                                                     supported languages (continued)
                                                      swap space
release update revisions, 6-1                             allocation, 1-2
release updates, 6-1                                  system requirements, 1-1
removing Oracle software, 7-1
    examples, 7-4
response file installation
                                                      T
    preparing, A-3                                    TEMP environment variable
    response files                                        commands
         templates, A-3                                        env, 4-5
    silent mode, A-6                                      env command, 4-5
response file mode, A-1                                   environment
    about, A-1                                                 checking settings, 4-5
    reasons for using, A-2                                setting, 4-5
        See also response files, silent mode              umask, 4-5
response files, A-1                                       umask command, 4-5
    about, A-1                                        TMPDIR environment variable
    creating with template, A-3                           setting, 4-5
    dbca.rsp, A-3                                     troubleshooting
    enterprise.rsp, A-3                                   cron jobs and installation, 1-5
    general procedure, A-2                                disk space errors, 1-2
    netca.rsp, A-3                                        environment path errors, 1-2
    passing values at command line, A-1                   installation owner environment variables and
    specifying with Oracle Universal Installer, A-5                 installation errors, 4-8
        See also silent mode.                             unset environment variables, 1-2
root user                                             typographic conventions, ix
    logging in as, 2-1
root.sh script
    backing up, 6-2                                   U
rootcrs.sh, 7-1
                                                      umask command, 4-4
roothas.sh, 7-1
                                                      uninstall
                                                          See removing Oracle software
S                                                     UNIX commands
                                                          xhost, 2-1
shell                                                 UNIX workstation
     determining default shell for Oracle user, 4-5       installing from, 2-1
SHELL environment variable                            unset installation owners environment variables,
     checking value of, 4-5                                   4-8
shell startup file                                    upgrading
     editing, 4-5                                         and ORAchk Upgrade Readiness
     removing environment variables, 4-5                           Assessment, 1-5
silent mode                                           useradd command, 4-4
     about, A-1                                       users
     reasons for using, A-2                               creating the oracle user, 4-3
silent mode installation, A-6
software requirements, 3-2
ssh                                                   X
     and X11 Forwarding, 4-7
                                                      X Window System
startup file
                                                         enabling remote hosts, 2-1
     for shell, 4-5
                                                      X11 forwarding errors, 4-7
supported languages
                                                      xhost command, 2-1
     installer, 5-6




                                                                                                         3

