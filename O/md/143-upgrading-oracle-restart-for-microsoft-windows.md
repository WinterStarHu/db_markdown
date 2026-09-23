# 143. Upgrading Oracle Restart for Microsoft Windows

> 源文件: `en/uporw/upgrading-oracle-restart-microsoft-windows.pdf`

Oracle® Grid Infrastructure
Upgrading Oracle Restart




    19c for Microsoft Windows
    F31804-02
    June 2020
Oracle Grid Infrastructure Upgrading Oracle Restart, 19c for Microsoft Windows

F31804-02

Copyright © 2019, 2020, Oracle and/or its affiliates.

Primary Author: Bharathi Jayathirtha

Contributing Authors: Subhash Chandra

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
end users are "commercial computer software" or “commercial computer software documentation” pursuant
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
    Use Case Scenario for this Document                                  iv
    Documentation Accessibility                                          iv



1   Preparing to Upgrade Oracle Restart
    1.1   Options and Restrictions for Oracle Restart Upgrades          1-1
    1.2   Checks to Complete Before Upgrading Oracle Restart            1-2
    1.3   Shutting Down the Database                                    1-2



2   Upgrading and Patching Oracle Restart
    2.1   Steps to Upgrade Oracle Restart                               2-1
    2.2   Verifying the Oracle Restart Software Version After Upgrade   2-2
    2.3   Patching Oracle Restart                                       2-2
    2.4   Unlocking and Deinstalling the Previous Release Grid Home     2-3



3   Downgrading Oracle Restart
    3.1   Options and Restrictions for Oracle Restart Downgrades        3-1
    3.2   Downgrading Oracle Restart                                    3-1




                                                                         iii
                                                                                           Preface




Preface
         This scenario document explains how to upgrade Oracle Grid Infrastructure for a
         standalone server (Oracle Restart) to a later release.
         •    Use Case Scenario for this Document
         •    Documentation Accessibility


Use Case Scenario for this Document
         Oracle Grid Infrastructure for a standalone server upgrade consists of upgrading
         Oracle Restart and Oracle Automatic Storage Management (Oracle ASM). Oracle
         Restart supports only out-of-place upgrades.

         Prerequisites for this Scenario
         •    Before you start the Oracle Restart upgrade, ensure that you have administrative
              privileges.
         •    Download the Oracle Grid Infrastructure image file for the release to which you
              want to upgrade.

         Outline for this Scenario
         1.   Preparing Oracle Restart for Upgrade. Identify the upgrade path for your
              installation and complete the required preupgrade checks.
         2.   Upgrading and Patching Oracle Restart. Use the Oracle Grid Infrastructure
              installer to upgrade and OPatchAuto to patch Oracle Restart.
         3.   Downgrade Oracle Restart. Downgrade Oracle Restart to an earlier release after
              a successful or a failed upgrade.
         These steps correspond to the chapters in this scenario document.


Documentation Accessibility
         For information about Oracle's commitment to accessibility, visit the
         Oracle Accessibility Program website at http://www.oracle.com/pls/topic/lookup?
         ctx=acc&id=docacc.

         Access to Oracle Support
         Oracle customers that have purchased support have access to electronic support
         through My Oracle Support. For information, visit http://www.oracle.com/pls/topic/
         lookup?ctx=acc&id=info or visit http://www.oracle.com/pls/topic/lookup?ctx=acc&id=trs
         if you are hearing impaired.




                                                                                                 iv
1
Preparing to Upgrade Oracle Restart
          Before you upgrade Oracle Restart, determine the best upgrade path, and run the
          procedures that are described here to prepare for the upgrade.
          Oracle recommends that you test the upgrade process and prepare a backup strategy.
          •   Options and Restrictions for Oracle Restart Upgrades
              Review these upgrade options and restrictions when you upgrade to Oracle Grid
              Infrastructure for a standalone server (Oracle Restart) 19c.
          •   Checks to Complete Before Upgrading Oracle Restart
              Complete these preupgrade checks to avoid issues during the Oracle Restart
              upgrade process.
          •   Shutting Down the Database
              If your Oracle Database uses Oracle Automatic Storage Management (Oracle
              ASM) for storage, then shut down the database before upgrading Oracle Restart.


1.1 Options and Restrictions for Oracle Restart Upgrades
          Review these upgrade options and restrictions when you upgrade to Oracle Grid
          Infrastructure for a standalone server (Oracle Restart) 19c.
          Supported upgrade paths for Oracle Restart for this release are:
          •   Oracle Restart upgrade from 11g Release 2 (11.2.0.4) to Oracle Restart 19c.
          •   Oracle Restart upgrade from 12c Release 1 (12.1.0.2) to Oracle Restart 19c.
          •   Oracle Restart upgrade from 12c Release 2 (12.2) to Oracle Restart 19c.
          •   Oracle Restart upgrade from 18c to Oracle Restart 19c.

          Restrictions for Oracle Restart Upgrades
          •   Oracle Restart upgrades are always out-of-place upgrades. You cannot perform an
              in-place upgrade of Oracle Restart to an existing Grid home.
          •   The same user that owned the earlier release of the Oracle Restart software must
              perform the Oracle Restart 19c upgrade.
          •   Do not delete directories in the Grid home. For example, do not delete the
              directory Grid_home\OPatch. If you delete the directory, then the Oracle Restart
              installation owner cannot use the OPatch utility to patch the Grid home,
              and OPatch displays the error message "'checkdir' error: cannot create
              Grid_home\OPatch".
          •   The software in the 19c Oracle Restart home is not fully functional until the
              upgrade is complete. Running srvctl, crsctl, and other commands from the new
              Grid home are not supported until the the upgrade is complete.
          •   To manage databases in an existing earlier release database home during the
              Oracle Restart upgrade, use the srvctl utility from the existing database home.




                                                                                                 1-1
                                                                                               Chapter 1
                                                      Checks to Complete Before Upgrading Oracle Restart




1.2 Checks to Complete Before Upgrading Oracle Restart
         Complete these preupgrade checks to avoid issues during the Oracle Restart upgrade
         process.
         1.   Review the new features for the Oracle Restart release to which you want to
              upgrade.
         2.   Ensure that you have all of the information you need for the upgrade. For example:
              •    An Oracle base location for Oracle Restart.
              •    An Oracle Restart home location that is different from your existing Oracle
                   Restart home.
              •    Privileged user operating system groups.
         3.   Unset the %ORACLE_HOME%, %ORACLE_BASE%, and %ORACLE_SID% environment
              variables because these environment variables are used during the upgrade. For
              example, as the grid user, run the following commands:


              SET ORACLE_HOME=""
              SET ORACLE_BASE=""
              SET ORACLE_SID=""

         4.   Set the value of the TNS_ADMIN variable under environment variables to NULL.
         5.   Unset the PATH environment variable:
              a.   Right-click My Computer, and select Properties.
              b.   Select the Advanced system settings option in the right pane.
              c.   Select the Environment Variables option in the Advanced tab.
              d.   Select the Path variable and click Edit.
              e.   Click Delete in the Edit environment variable window, and click OK to confirm.
         Related Topics
         •    Oracle Database New Features Guide


1.3 Shutting Down the Database
         If your Oracle Database uses Oracle Automatic Storage Management (Oracle ASM)
         for storage, then shut down the database before upgrading Oracle Restart.
         1.   Log in as the Oracle Home user.
         2.   Shut down the Oracle Database instance.

              C:\> Grid_home\bin\srvctl stop database –d database_unique_name

         3.   Ensure that your Oracle Database instance is shut down.

              C:\> Grid_home\bin\srvctl status database –d database_unique_name
              Database is not running.




                                                                                                   1-2
2
Upgrading and Patching Oracle Restart
         Learn how to upgrade Oracle Restart to a later release using the out-of-place upgrade
         mode and install the patches.
         •    Steps to Upgrade Oracle Restart
              Complete this procedure to upgrade Oracle Grid Infrastructure for a standalone
              server (Oracle Restart) from an earlier release.
         •    Verifying the Oracle Restart Software Version After Upgrade
              Check the software release version of Oracle Restart after the upgrade.
         •    Patching Oracle Restart
              After you have upgraded to Oracle Grid Infrastructure for a standalone server
              (Oracle Restart) 19c, you can install individual software patches by downloading
              them from My Oracle Support.
         •    Unlocking and Deinstalling the Previous Release Grid Home
              After upgrading from previous releases, you can deinstall the previous release
              Grid home.


2.1 Steps to Upgrade Oracle Restart
         Complete this procedure to upgrade Oracle Grid Infrastructure for a standalone server
         (Oracle Restart) from an earlier release.
         Be prepared to run root scripts before you start the upgrade.
         1.   As the Oracle Home user, download the Oracle Grid Infrastructure image files and
              extract the files to the Grid home.
              For example:

              C:\> md C:\app\grid\product\19.0.0\grid
              C:\> cd C:\app\grid\product\19.0.0\grid
              C:\> unzip -q download_location\grid_home.zip


              download_location\grid_home.zip is the path of the downloaded Oracle Grid
              Infrastructure image file.



                     Note:

                     •   You must extract the image software into the directory where you
                         want your new Grid home to be located.


         2.   Start the Oracle Grid Infrastructure wizard:

              C:\> C:\app\grid\product\19.0.0\grid\setup.exe




                                                                                               2-1
                                                                                                   Chapter 2
                                                 Verifying the Oracle Restart Software Version After Upgrade


          3.   Select the Upgrade Oracle Grid Infrastructure option to upgrade Oracle Grid
               Infrastructure for a standalone server.
          4.   Select the installation options as prompted.
               At any time during the upgrade, if you have a question about what you are being
               asked to do, or what input you are required to provide during the upgrade, then
               click the Help button on the installer window.


2.2 Verifying the Oracle Restart Software Version After
Upgrade
          Check the software release version of Oracle Restart after the upgrade.
          1.   Log in as the grid user.
          2.   Verify that Oracle Restart 19c is in use after the upgrade.

               C:\> Grid_home\bin\crsctl query has releaseversion
               Oracle High Availability Services version on the local node is
               [19.0.0.0.0]


2.3 Patching Oracle Restart
          After you have upgraded to Oracle Grid Infrastructure for a standalone server (Oracle
          Restart) 19c, you can install individual software patches by downloading them from My
          Oracle Support.
          1.   Download the patches that you want to apply from My Oracle Support:
               https://support.oracle.com
               Select the Patches and Updates tab to locate the patch.
               Oracle recommends that you select Recommended Patch Advisor, and enter
               the product group, release, and platform for your software.
               Place the patches in a shared directory that is accessible to all users.
          2.   Review the README file for the patch that you want to apply, and complete all of
               the required steps before installing the patch.
          3.   As the Administrator user, go to the /OPatch directory in the Grid home.

               C:\> cd C:\app\grid\product\19.0.0\grid\OPatch

          4.   Install the version of the OPatch utility that is recommended in the README file
               for the patch.
          5.   Follow the instructions in the README file for the patch to apply the patch.

               C:\> opatchauto apply patch_directory_location\patch_ID

          6.   As the grid user, verify the release patch number for your Oracle Restart.

               C:\> Grid_home\bin\crsctl query has releasepatch




                                                                                                       2-2
                                                                                               Chapter 2
                                               Unlocking and Deinstalling the Previous Release Grid Home


              The release patch number changes only for Release Update (RU) and Release
              Update Revision (RUR) patches.


2.4 Unlocking and Deinstalling the Previous Release Grid
Home
         After upgrading from previous releases, you can deinstall the previous release Grid
         home.
         Perform the following steps:
         1.   Navigate to the bin directory of the previous release Grid home.

              C:\> cd C:\app\grid\product\18.0.0\grid\bin

         2.   Use the deinstall command to remove the previous release of Oracle Grid
              Infrastructure installation.

              C:\app\grid\product\18.0.0\grid\bin:\> deinstall



                     Note:
                     Ensure that the services and directories of the older grid home are
                     deleted.



                     Caution:
                     You must use the deinstall command from the same release to
                     remove Oracle software. Do not run the deinstall command from
                     a later release to remove Oracle software from an earlier release. For
                     example, do not run the deinstall command from the 19.0.0.0.0 Grid
                     home to remove Oracle software from an existing 18.0.0.0.0 Grid home.




                                                                                                   2-3
3
Downgrading Oracle Restart
         You can restore Oracle Grid Infrastructure for a standalone server (Oracle Restart) to
         the previous release after a successful or a failed upgrade.
         •   Options and Restrictions for Oracle Restart Downgrades
             Review these downgrade options and restrictions when you downgrade Oracle
             Restart to an earlier release after a successful or a failed upgrade.
         •   Downgrading Oracle Restart
             Use this procedure to deconfigure and downgrade Oracle Restart, or to
             troubleshoot Oracle Restart installation errors.


3.1 Options and Restrictions for Oracle Restart Downgrades
         Review these downgrade options and restrictions when you downgrade Oracle Restart
         to an earlier release after a successful or a failed upgrade.
         Downgrade options include the following earlier releases:
         •   Oracle Restart downgrade to Oracle Restart 18c.
         •   Oracle Restart downgrade to Oracle Restart 12c Release 2 (12.2).
         •   Oracle Restart downgrade to Oracle Restart 12c Release 1 (12.1.0.2).
         •   Oracle Restart downgrade to Oracle Restart 11g Release 2 (11.2.0.4).

         Restrictions for Oracle Restart Downgrades
         •   You can downgrade Oracle Restart to an earlier release only if you did not make
             any configuration changes after the upgrade.
         •   You can only downgrade to the Oracle Restart release you upgraded from. For
             example, if you upgraded from Oracle Restart 18c to Oracle Restart 19c, then you
             can only downgrade to Oracle Restart 18c.


3.2 Downgrading Oracle Restart
         Use this procedure to deconfigure and downgrade Oracle Restart, or to troubleshoot
         Oracle Restart installation errors.
         Running roothas.bat with the command flags -deconfig -force enables you
         to deconfigure Oracle Restart without removing the installed binaries. This feature is
         useful if you encounter an error during an Oracle Grid Infrastructure for a standalone
         server installation. For example, when you run the root.sh command, and find a
         missing operating system package. By running roothas.bat -deconfig -force,
         you can deconfigure Oracle Restart, correct the cause of the error, and then run
         root.sh again.




                                                                                             3-1
                                                                                   Chapter 3
                                                                 Downgrading Oracle Restart


1.   As the oracle user, create a backup of the SPFILE to a PFILE.

     CREATE
     PFILE='C:\app\oracle\product\19.0.0\dbhome_1\dbs\test_init.ora'
     FROM SPFILE='C:\oracle\dbs\test_spfile.ora';

2.   List all the Oracle databases on the server with their version, unique name of the
     database, and Oracle home information.

     C:\> srvctl config database -home

3.   Downgrade Oracle Database. Refer to Oracle Database Upgrade Guide for
     more information about required pre-downgrade tasks, downgrade tasks, post-
     downgrade tasks, and compatibility information.



            Note:
            Downgrade Oracle Database only if the Oracle Database version is
            higher than the Oracle Restart version to which you are downgrading
            Oracle Restart.

4.   As the oracle user, downgrade the Oracle Restart resources if you have
     downgraded your Oracle Database.

     C:\> srvctl downgrade database -d db_unique_name -oraclehome
     %ORACLE_HOME% -t to_version

5.   Inspect the Oracle Restart configuration of each database, service, and listener.

     C:\> srvctl config database -db db_unique_name
     C:\> srvctl config service -db db_unique_name
     C:\> srvctl config listener -listener listener_name


     Make a note of the configuration information and use this information when adding
     the components back to Oracle Restart.
6.   Stop all databases and listeners that are running before you deconfigure or
     downgrade Oracle Restart.

     C:\> srvctl stop database -db db_unique_name
     C:\> srvctl stop listener [-listener listener_name]

7.   As the root user, run roothas.bat with the -deconfig -force flags to
     deconfigure Oracle Restart.

     C:\> C:\app\oracle\product\19.0.0\grid\crs\install\roothas.bat -
     deconfig -force




                                                                                       3-2
                                                                                   Chapter 3
                                                                  Downgrading Oracle Restart


8.   As the grid user, update the Oracle central inventory (oraInventory).

     C:\> C:\app\oracle\product\19.0.0\grid\oui\bin\setup.exe -
     updateNodeList -silent ORACLE_HOME=upgraded_Grid_home -local
     CRS=false

9.   As the root user, run roothas.bat with the -unlock flag to unlock the previous
     release Oracle Restart home.


     C:\> C:\app\oracle\product\18.0.0\grid\crs\install\roothas.bat -
     unlock -dstcrshome previous_release_Grid_home

10. As the grid user, reconfigure the previous release Oracle Restart home using the
     setup.exe command.

     C:\> C:\app\oracle\product\18.0.0\grid\setup.exe

11. As the oracle user, add the components back to Oracle Restart with the same
     attributes that you noted down before deconfiguring Oracle Restart.
     a.   Add Oracle Database to the Oracle Restart configuration.

          C:\> srvctl add database -db db_unique_name -oraclehome
          Oracle_home

     b.   Add the listener to the Oracle Restart configuration.

          C:\> srvctl add listener -listener listener_name -oraclehome
          Oracle_home


          For the -oraclehome parameter, provide the Oracle home path from which the
          listener was running before the downgrade.
     c.   Add each service to the database, using the srvctl add service command.

          C:\> srvctl add service -db db_unique_name -service
          service_name_list

Related Topics
•    Oracle Database Upgrade Guide




                                                                                        3-3
Index
C                         R
commands                  running setup.exe, 2-1
   unset, 1-2
                          U
E
                          upgrade
environment variables        running setup.exe, 2-1
    ORACLE_HOME, 1-2      upgrades
    ORACLE_SID, 1-2          unsetting environment variables for, 1-2

I
installer screens, 2-1

O
Oracle Restart
   deconfiguring, 3-1
   downgrading, 3-1
   troubleshooting, 3-1




                                                                   Index-1

