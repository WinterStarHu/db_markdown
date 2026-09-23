# 142. Upgrading Oracle Restart for Linux and Unix-Based Operating Systems

> 源文件: `en/upgor/upgrading-oracle-restart-linux-and-unix-based-operating-systems.pdf`

Oracle® Grid Infrastructure
Upgrading Oracle Restart




    19c for Linux and Unix-Based Operating Systems
    F28466-04
    August 2024
Oracle Grid Infrastructure Upgrading Oracle Restart, 19c for Linux and Unix-Based Operating Systems

F28466-04

Copyright © 2020, 2024, Oracle and/or its affiliates.

Primary Author: Subhash Chandra

Contributing Authors: Prakash Jashnani, Douglas Williams, Mark Bauer

Contributors: Jonathan Creighton, Rajesh Dasari, Pawan Tare, Balaji Pagadala, Srinivas Poovala, Patrick He

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
    Use Case Scenario for this Document                                            iv
    Documentation Accessibility                                                    iv



1   Preparing to Upgrade Oracle Restart
    Options and Restrictions for Oracle Restart Upgrades                          1-1
    Checks to Complete Before Upgrading Oracle Restart                            1-2
    Installing the Oracle Database Preinstallation RPM Using ULN                  1-3
    Creating a Copy of the Preinstallation Configuration File for the grid User   1-4
    Shutting Down the Database                                                    1-4
    Upgrading Operating System for an Oracle Restart Server                       1-5



2   Upgrading and Patching Oracle Restart
    Steps to Upgrade Oracle Restart                                               2-1
    Verifying the Oracle Restart Software Version After Upgrade                   2-2
    Downloading Release Update Patches                                            2-2
    Patching Oracle Restart                                                       2-3
    Patching and Switching Oracle Grid Infrastructure Homes                       2-4
    Unlocking and Deinstalling the Previous Release Grid Home                     2-5



3   Downgrading Oracle Restart
    Options and Restrictions for Oracle Restart Downgrades                        3-1
    Downgrading Oracle Restart                                                    3-1




                                                                                   iii
                                                                                                      Preface




Preface
         This scenario document explains how to upgrade Oracle Grid Infrastructure for a standalone
         server (Oracle Restart) to a later release.
         •    Use Case Scenario for this Document
         •    Documentation Accessibility


Use Case Scenario for this Document
         Oracle Grid Infrastructure for a standalone server upgrade consists of upgrading Oracle
         Restart and Oracle Automatic Storage Management (Oracle ASM). Oracle Restart supports
         only out-of-place upgrades.

         Prerequisites for this Scenario
         •    Before you start the Oracle Restart upgrade, ensure that you have administrative
              privileges.
         •    Download the Oracle Grid Infrastructure image file for the release to which you want to
              upgrade.

         Outline for this Scenario
         1.   Preparing Oracle Restart for Upgrade. Identify the upgrade path for your installation and
              complete the required preupgrade checks.
         2.   Upgrading and Patching Oracle Restart. Use the Oracle Grid Infrastructure installer to
              upgrade and OPatchAuto to patch Oracle Restart.
         3.   Downgrade Oracle Restart. Downgrade Oracle Restart to an earlier release after a
              successful or a failed upgrade.
         These steps correspond to the chapters in this scenario document.


Documentation Accessibility
         For information about Oracle's commitment to accessibility, visit the Oracle Accessibility
         Program website at http://www.oracle.com/pls/topic/lookup?ctx=acc&id=docacc.

         Access to Oracle Support
         Oracle customers that have purchased support have access to electronic support through My
         Oracle Support. For information, visit http://www.oracle.com/pls/topic/lookup?ctx=acc&id=info
         or visit http://www.oracle.com/pls/topic/lookup?ctx=acc&id=trs if you are hearing impaired.




                                                                                                           iv
1
Preparing to Upgrade Oracle Restart
         Before you upgrade Oracle Restart, determine the best upgrade path, and run the procedures
         that are described here to prepare for the upgrade.
         Oracle recommends that you test the upgrade process and prepare a backup strategy.
         •   Options and Restrictions for Oracle Restart Upgrades
             Review these upgrade options and restrictions when you upgrade to Oracle Grid
             Infrastructure for a standalone server (Oracle Restart) 19c.
         •   Checks to Complete Before Upgrading Oracle Restart
             Complete these preupgrade checks to avoid issues during the Oracle Restart upgrade
             process.
         •   Installing the Oracle Database Preinstallation RPM Using ULN
             Use this procedure to subscribe to Unbreakable Linux Network (ULN) Oracle Linux
             channels for your Oracle software.
         •   Creating a Copy of the Preinstallation Configuration File for the grid User
             Create a copy of the preinstallation configuration file for the grid user to set hard and soft
             limits for the operating system parameters.
         •   Shutting Down the Database
             If your Oracle Database uses Oracle Automatic Storage Management (Oracle ASM) for
             storage, then shut down the database before upgrading Oracle Restart.
         •   Upgrading Operating System for an Oracle Restart Server
             Complete this procedure on your Oracle Restart server to upgrade the operating system.


Options and Restrictions for Oracle Restart Upgrades
         Review these upgrade options and restrictions when you upgrade to Oracle Grid Infrastructure
         for a standalone server (Oracle Restart) 19c.
         Supported upgrade paths for Oracle Restart for this release are:
         •   Oracle Restart upgrade from 11g Release 2 (11.2.0.4) to Oracle Restart 19c.
         •   Oracle Restart upgrade from 12c Release 1 (12.1.0.2) to Oracle Restart 19c.
         •   Oracle Restart upgrade from 12c Release 2 (12.2) to Oracle Restart 19c.
         •   Oracle Restart upgrade from 18c to Oracle Restart 19c.

         Restrictions for Oracle Restart Upgrades
         •   Oracle Restart upgrades are always out-of-place upgrades. You cannot perform an in-
             place upgrade of Oracle Restart to an existing Grid home.
         •   The same user that owned the earlier release of the Oracle Restart software must perform
             the Oracle Restart 19c upgrade.
         •   Do not delete directories in the Grid home. For example, do not delete the directory
             Grid_home/OPatch. If you delete the directory, then the Oracle Restart installation owner




                                                                                                        1-1
                                                                                                      Chapter 1
                                                             Checks to Complete Before Upgrading Oracle Restart

              cannot use the OPatch utility to patch the Grid home, and OPatch displays the error
              message "'checkdir' error: cannot create Grid_home/OPatch".
         •    The software in the 19c Oracle Restart home is not fully functional until the upgrade is
              complete. Running srvctl, crsctl, and other commands from the new Grid home are not
              supported until the rootupgrade.sh script is run and the upgrade is complete.
         •    To manage databases in an existing earlier release database home during the Oracle
              Restart upgrade, use the srvctl utility from the existing database home.


Checks to Complete Before Upgrading Oracle Restart
         Complete these preupgrade checks to avoid issues during the Oracle Restart upgrade
         process.
         1.   Review the new features for the Oracle Restart release to which you want to upgrade.
         2.   Ensure that you have all of the information you need for the upgrade. For example:
              •   An Oracle base location for Oracle Restart.
              •   An Oracle Restart home location that is different from your existing Oracle Restart
                  home.
              •   Privileged user operating system groups.
              •   root user access, to run scripts as the root user during the upgrade.
         3.   Unset the $ORACLE_HOME, $ORACLE_BASE, and $ORACLE_SID environment variables because
              these environment variables are used during the upgrade. For example, as the grid user,
              run the following commands:
              For bash shell:

              $ unset ORACLE_HOME
              $ unset ORACLE_BASE
              $ unset ORACLE_SID


              For C shell:

              $ unsetenv ORACLE_HOME
              $ unsetenv ORACLE_BASE
              $ unsetenv ORACLE_SID

         4.   Ensure that the installation owner user profile, such as .profile or .cshrc, does not set
              any of these environment variables.
         5.   Unset any environment variables, such as ORA_NLS10 and TNS_ADMIN, set for the
              installation owner user that is connected with the Oracle software homes.
         6.   Ensure that the $ORACLE_HOME/bin path is removed from your PATH environment
              variable.
         Related Topics
         •    Oracle Database New Features Guide




                                                                                                          1-2
                                                                                                              Chapter 1
                                                           Installing the Oracle Database Preinstallation RPM Using ULN




Installing the Oracle Database Preinstallation RPM Using ULN
         Use this procedure to subscribe to Unbreakable Linux Network (ULN) Oracle Linux channels
         for your Oracle software.
         To obtain Unbreakable Linux Network (ULN) support, subscribe to Oracle Linux channels, and
         to add the Oracle Linux channel that distributes the Oracle Database Preinstallation RPM:
         1.   Download the Oracle Linux ISO from one of the following websites:
              •   Oracle yum

                  https://yum.oracle.com/oracle-linux-isos.html

              •   Oracle Software Delivery Cloud website:

                  https://edelivery.oracle.com/linux



                      Note:
                      Ensure that you use the latest available update release for Oracle Linux.

         2.   Register your server with Unbreakable Linux Network (ULN). By default, you are registered
              for the Oracle Linux Latest channel for your operating system and hardware.
              •   Oracle Linux 7
                  https://docs.oracle.com/en/operating-systems/oracle-linux/uln-user/
              •   Oracle Linux 8 and Oracle Linux 9
                  https://docs.oracle.com/en/operating-systems/oracle-linux/software-management/
         3.   Log in to Unbreakable Linux Network:

              https://linux.oracle.com

         4.   Start a terminal session and enter the following command as root, depending on your
              platform. For example:
              •   Oracle Linux 7

                  # yum install oracle-database-preinstall-19c



                           Note:
                           Use the -y option if you want yum to skip the package confirmation prompt.

              •   Oracle Linux 8 and Oracle Linux 9

                  # dnf install oracle-database-preinstall-19c

              You should see output indicating that you have subscribed to the Oracle Linux channel,
              and that packages are being installed.




                                                                                                                  1-3
                                                                                                                 Chapter 1
                                                Creating a Copy of the Preinstallation Configuration File for the grid User

               The Oracle Database Preinstallation RPM automatically creates a standard (not role-
               allocated) Oracle installation owner and groups, and sets up other kernel configuration
               settings as required for Oracle installations.
          5.   Check the RPM log file to review the system configuration changes. For example:

               /var/log/oracle-database-preinstall-19c/backup/timestamp/orakernel.log

          6.   Repeat steps 1 through 4 on all other servers in your cluster.
          If you have a premier support subscription, you can enable Ksplice to provide zero downtime
          patching. Refer to the Ksplice User's Guide for installation instructions:
          https://docs.oracle.com/en/operating-systems/oracle-linux/ksplice-user/


Creating a Copy of the Preinstallation Configuration File for the
grid User
          Create a copy of the preinstallation configuration file for the grid user to set hard and soft
          limits for the operating system parameters.
          1.   As the root user, go to the /etc/security/limits.d directory.

               # cd /etc/security/limits.d

          2.   Create a copy of the preinstallation configuration file for the grid user by replacing the
               oracle user with the grid user.

               # cat oracle-database-preinstall-19c.conf | sed 's/oracle /grid /g' >
               oracle-grid-user-preinstall-19c.conf

          3.   Delete the preinstallation configuration files for the earlier release.

               # rm -r -f oracle-database-preinstall-18c.conf oracle-grid-user-
               preinstall-18c.conf



Shutting Down the Database
          If your Oracle Database uses Oracle Automatic Storage Management (Oracle ASM) for
          storage, then shut down the database before upgrading Oracle Restart.
          1.   Log in as the oracle user.
          2.   Shut down the Oracle Database instance.

               $ Grid_home/bin/srvctl stop database –d database_unique_name

          3.   Ensure that your Oracle Database instance is shut down.

               $ Grid_home/bin/srvctl status database –d database_unique_name
               Database is not running.




                                                                                                                      1-4
                                                                                                        Chapter 1
                                                          Upgrading Operating System for an Oracle Restart Server




Upgrading Operating System for an Oracle Restart Server
         Complete this procedure on your Oracle Restart server to upgrade the operating system.
         1.   As the root user, disable the automatic startup of Oracle High Availability Services, when
              the server reboots.

              # cd Grid_home/bin
              # ./crsctl disable has

         2.   Shut down the Oracle Restart stack on the server.

              # ./crsctl stop has

         3.   Verify all services are stopped before the operating system upgrade.

              # ./crsctl check has

         4.   Upgrade the operating system to a version that is supported for your Oracle Restart
              release.
              Refer to your operating system documentation for more information about upgrading the
              operating system.
         5.   Reboot your Oracle Restart server after the operating system upgrade is complete.
         6.   As the root user, add the Oracle Database libraries and lock the Oracle Restart
              installation.

              # cd Grid_home/rdbms/install/
              # ./rootadd_rdbms.sh
              # cd Grid_home/crs/install
              # roothas.sh -lock

         7.   As the root user, enable the automatic startup of Oracle High Availability Services, when
              the server reboots.

              # cd Grid_home/bin
              # ./crsctl enable has

         8.   Start the Oracle Restart stack on the server.

              # ./crsctl start has

         9.   Connect to an SQL*Plus session and open the Pluggable Database (PDB).

              SQL> CONNECT / AS SYSDBA
              SQL> ALTER PLUGGABLE DATABASE pdb_name OPEN;

         10. As the grid user, list all registered resources on your Oracle Restart server.

              $ Grid_home/bin/crsctl stat res -t




                                                                                                            1-5
2
Upgrading and Patching Oracle Restart
         Learn how to upgrade Oracle Restart to a later release using the out-of-place upgrade mode
         and install the patches.
         •    Steps to Upgrade Oracle Restart
              Complete this procedure to upgrade Oracle Grid Infrastructure for a standalone server
              (Oracle Restart) from an earlier release.
         •    Verifying the Oracle Restart Software Version After Upgrade
              Check the software release version of Oracle Restart after the upgrade.
         •    Downloading Release Update Patches
              Download and install Release Updates (RU) and Monthly Recommended Patches (MRPs)
              patches for your Oracle software after you complete installation.
         •    Patching Oracle Restart
              After you have upgraded to Oracle Grid Infrastructure for a standalone server (Oracle
              Restart) 19c, you can install individual software patches by downloading them from My
              Oracle Support.
         •    Patching and Switching Oracle Grid Infrastructure Homes
              Perform an out-of-place Oracle Restart patching by switching from the current Oracle Grid
              Infrastructure home to a patched Oracle Grid Infrastructure home.
         •    Unlocking and Deinstalling the Previous Release Grid Home
              After upgrading from previous releases, if you want to deinstall the previous release Grid
              home, then you must first change the permission and ownership of the previous release
              Grid home.


Steps to Upgrade Oracle Restart
         Complete this procedure to upgrade Oracle Grid Infrastructure for a standalone server (Oracle
         Restart) from an earlier release.
         Be prepared to run root scripts before you start the upgrade.
         1.   As the grid user, download the Oracle Grid Infrastructure image files and extract the files
              to the Grid home.
              For example:

              mkdir -p /u01/app/grid/product/19.0.0/grid
              chown grid:oinstall /u01/app/grid/product/19.0.0/grid
              cd /u01/app/grid/product/19.0.0/grid
              unzip -q download_location/grid_home.zip


              download_location/grid_home.zip is the path of the downloaded Oracle Grid
              Infrastructure image file.




                                                                                                       2-1
                                                                                                            Chapter 2
                                                          Verifying the Oracle Restart Software Version After Upgrade



                      Note:

                      •   You must extract the image software into the directory where you want your
                          new Grid home to be located.


          2.   Start the Oracle Grid Infrastructure wizard:

               $ /u01/app/grid/product/19.0.0/grid/gridSetup.sh

          3.   Select the Upgrade Oracle Grid Infrastructure option to upgrade Oracle Grid
               Infrastructure for a standalone server.
          4.   Select the installation options as prompted.
          5.   You can run root scripts, either automatically or manually. Oracle recommends that you
               configure root script automation, so that the rootupgrade.sh script can run automatically
               during the upgrade.
               At any time during the upgrade, if you have a question about what you are being asked to
               do, or what input you are required to provide during the upgrade, then click the Help button
               on the installer window.


Verifying the Oracle Restart Software Version After Upgrade
          Check the software release version of Oracle Restart after the upgrade.
          1.   Log in as the grid user.
          2.   Verify that Oracle Restart 19c is in use after the upgrade.

               $ Grid_home/bin/crsctl query has releaseversion
               Oracle High Availability Services version on the local node is [19.0.0.0.0]



Downloading Release Update Patches
          Download and install Release Updates (RU) and Monthly Recommended Patches (MRPs)
          patches for your Oracle software after you complete installation.
          Oracle provides quarterly updates in the form of Release Updates (RU) and Monthly
          Recommended Patches (MRPs). Oracle no longer releases patch sets. For more information,
          see My Oracle Support Note 2285040.1.
          Check the My Oracle Support website for required updates for your installation.
          1.   Use a web browser to view the My Oracle Support website:
               https://support.oracle.com
          2.   Log in to My Oracle Support website.



                      Note:
                      If you are not a My Oracle Support registered user, then click Register for My
                      Oracle Support and register.




                                                                                                                2-2
                                                                                                       Chapter 2
                                                                                         Patching Oracle Restart

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
         •    My Oracle Support note 888.1
         •    Patch Delivery Methods for Oracle Database


Patching Oracle Restart
         After you have upgraded to Oracle Grid Infrastructure for a standalone server (Oracle Restart)
         19c, you can install individual software patches by downloading them from My Oracle Support.
         1.   Download the patches that you want to apply from My Oracle Support:
              https://support.oracle.com
              Select the Patches and Updates tab to locate the patch.
              Oracle recommends that you select Recommended Patch Advisor, and enter the product
              group, release, and platform for your software.
              Place the patches in a shared directory that is accessible to all users.
         2.   Review the README file for the patch that you want to apply, and complete all of the
              required steps before installing the patch.
         3.   As the root user, go to the /OPatch directory in the Grid home.

              # cd /u01/app/grid/product/19.0.0/grid/OPatch

         4.   Install the version of the OPatch utility that is recommended in the README file for the
              patch.
         5.   Follow the instructions in the README file for the patch to apply the patch.

              # opatchauto apply patch_directory_location/patch_ID

         6.   As the grid user, verify the release patch number for your Oracle Restart.

              $ Grid_home/bin/crsctl query has releasepatch


              The release patch number changes only for Release Update (RU) and Release Update
              Revision (RUR) patches.




                                                                                                           2-3
                                                                                                         Chapter 2
                                                           Patching and Switching Oracle Grid Infrastructure Homes




Patching and Switching Oracle Grid Infrastructure Homes
         Perform an out-of-place Oracle Restart patching by switching from the current Oracle Grid
         Infrastructure home to a patched Oracle Grid Infrastructure home.
         1.   Download the 19.3 Oracle Grid Infrastructure base release image files.
              https://www.oracle.com/database/technologies/oracle-database-software-
              downloads.html#19c
         2.   As the grid user, extract the downloaded image files into a new Oracle Grid Infrastructure
              home directory.

              $ mkdir -p /u01/app/oracle/product/19.17.0/grid
              $ chown grid:oinstall /u01/app/oracle/product/19.17.0/grid
              $ cd /u01/app/oracle/product/19.17.0/grid
              $ unzip -q download_location/grid.zip


              Here:
              •   /u01/app/oracle/product/19.17.0/grid is the new Grid home.
              •   /u01/app/oracle/product/19.16.0/grid is the old Grid home.
         3.   As the grid user, download and install the latest version of the OPatch utility in the new
              Grid home.
              https://updates.oracle.com/download/6880880.html

              $ mv /u01/app/oracle/product/19.17.0/grid/OPatch /u01/app/oracle/product/
              19.17.0/grid/bak_OPatch
              $ unzip latest_Opatch.zip -d /u01/app/oracle/product/19.17.0/grid/

         4.   Download the Oracle Database RU version that you want to apply from My Oracle
              Support. In this example, Oracle Database 19.17 RU.
              For more information, see, Downloading Release Update Patches
         5.   Start the Oracle Grid Infrastructure installer to perform a software-only Oracle Restart
              installation. You can apply the optional -applyRU or -applyOneOff flags to apply
              Release Updates (RUs) during the installation.

               $ /u01/app/oracle/product/19.17.0/grid/gridSetup.sh [-applyRU
              patch_directory_location]
              [-applyOneOffs comma_separated_list_of_patch_directory_locations]

         6.   Follow the steps in the configuration wizard to complete the Oracle Grid Infrastructure
              installation.
         7.   As the root user, run the following command to prepare the new home for the out-of-place
              patching:

              # /u01/app/oracle/product/19.17.0/grid/crs/install/roothas.sh -prepatch -
              dstcrshome
              /u01/app/oracle/product/19.17.0/grid


              This command does not shut down any services.




                                                                                                             2-4
                                                                                                        Chapter 2
                                                        Unlocking and Deinstalling the Previous Release Grid Home

         8.   Run the following command to switch to the new Oracle Grid Infrastructure home and
              perform the out of place patching:

              # /u01/app/oracle/product/19.17.0/grid/crs/install/roothas.sh -postpatch -
              dstcrshome
              /u01/app/oracle/product/19.17.0/grid


              This command shuts down the old Oracle Grid Infrastructure home and starts resources
              from the new Oracle Grid Infrastructure home. All Oracle Grid Infrastructure services start
              running from the new Grid home.
         9.   Update the Oracle central inventory (oraInventory).

              $ /u01/app/oracle/product/19.17.0/grid/oui/bin/runInstaller -
              updateNodeList ORACLE_HOME=/u01/app/oracle/product/19.17.0/grid CRS=TRUE
              $ /u01/app/oracle/product/19.16.0/grid/oui/bin/runInstaller -
              updateNodeList ORACLE_HOME=/u01/app/oracle/product/19.16.0/grid CRS=FALSE

         10. To switch back to the old Grid home:

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



Unlocking and Deinstalling the Previous Release Grid Home
         After upgrading from previous releases, if you want to deinstall the previous release Grid
         home, then you must first change the permission and ownership of the previous release Grid
         home.
         1.   As the root user, unlock the previous release Grid home.

              # /u01/app/oracle/product/18.0.0/grid/crs/install/roothas.sh -unlock -
              dstcrshome previous_release_Grid_home

         2.   After you change the permissions and ownership of the previous release Grid home, log in
              as the Oracle Grid Infrastructure installation owner (grid, in the preceding example), and
              use the deinstall command from the previous release Grid home $ORACLE_HOME/
              deinstall directory.




                                                                                                            2-5
                                                                               Chapter 2
                               Unlocking and Deinstalling the Previous Release Grid Home



Caution:
You must use the deinstall command from the same release to remove
Oracle software. Do not run the deinstall command from a later release to
remove Oracle software from an earlier release. For example, do not run the
deinstall command from the 19.0.0.0.0 Grid home to remove Oracle software
from an existing 18.0.0.0.0 Grid home.




                                                                                   2-6
3
Downgrading Oracle Restart
         You can restore Oracle Grid Infrastructure for a standalone server (Oracle Restart) to the
         previous release after a successful or a failed upgrade.
         •   Options and Restrictions for Oracle Restart Downgrades
             Review these downgrade options and restrictions when you downgrade Oracle Restart to
             an earlier release after a successful or a failed upgrade.
         •   Downgrading Oracle Restart
             Use this procedure to deconfigure and downgrade Oracle Restart, or to troubleshoot
             Oracle Restart installation errors.


Options and Restrictions for Oracle Restart Downgrades
         Review these downgrade options and restrictions when you downgrade Oracle Restart to an
         earlier release after a successful or a failed upgrade.
         Downgrade options include the following earlier releases:
         •   Oracle Restart downgrade to Oracle Restart 18c.
         •   Oracle Restart downgrade to Oracle Restart 12c Release 2 (12.2).
         •   Oracle Restart downgrade to Oracle Restart 12c Release 1 (12.1.0.2).
         •   Oracle Restart downgrade to Oracle Restart 11g Release 2 (11.2.0.4).

         Restrictions for Oracle Restart Downgrades
         •   You can downgrade Oracle Restart to an earlier release only if you did not make any
             configuration changes after the upgrade.
         •   You can only downgrade to the Oracle Restart release you upgraded from. For example, if
             you upgraded from Oracle Restart 18c to Oracle Restart 19c, then you can only
             downgrade to Oracle Restart 18c.


Downgrading Oracle Restart
         Use this procedure to deconfigure and downgrade Oracle Restart, or to troubleshoot Oracle
         Restart installation errors.

         Running roothas.sh with the command flags -deconfig -force enables you to
         deconfigure Oracle Restart without removing the installed binaries. This feature is useful if you
         encounter an error during an Oracle Grid Infrastructure for a standalone server installation. For
         example, when you run the root.sh command, and find a missing operating system package.
         By running roothas.sh -deconfig -force, you can deconfigure Oracle Restart, correct
         the cause of the error, and then run root.sh again.




                                                                                                      3-1
                                                                                          Chapter 3
                                                                         Downgrading Oracle Restart

1.   As the oracle user, create a backup of the SPFILE to a PFILE.

     CREATE PFILE='/u01/app/oracle/product/19.0.0/dbhome_1/dbs/test_init.ora'
     FROM SPFILE='/u01/oracle/dbs/test_spfile.ora';

2.   List all the Oracle Databases on the server with their version, unique name of the
     database, and Oracle home information.

     $ srvctl config database -home

3.   Downgrade Oracle Database. Refer to Oracle Database Upgrade Guide for more
     information about required pre-downgrade tasks, downgrade tasks, post-downgrade tasks,
     and compatibility information.



            Note:
            Downgrade Oracle Database only if the Oracle Database version is higher than
            the Oracle Restart version to which you are downgrading Oracle Restart.

4.   As the oracle user, downgrade the Oracle Restart resources corresponding to the Oracle
     Database, only if you have downgraded your Oracle Database.

     $ srvctl downgrade database -d db_unique_name -oraclehome $ORACLE_HOME -t
     to_version

5.   Inspect the Oracle Restart configuration of each database, service, and listener.

     $ srvctl config database -db db_unique_name
     $ srvctl config service -db db_unique_name
     $ srvctl config listener -listener listener_name


     Make a note of the configuration information and use this information when adding the
     components back to Oracle Restart.
6.   Stop all databases and listeners that are running before you deconfigure or downgrade
     Oracle Restart.

     $ srvctl stop database -db db_unique_name
     $ srvctl stop listener [-listener listener_name]

7.   As the root user, run roothas.sh with the -deconfig -force flags to deconfigure
     Oracle Restart.

     # /u01/app/oracle/product/19.0.0/grid/crs/install/roothas.sh -deconfig -
     force

8.   As the grid user, update the Oracle central inventory (oraInventory).

     $ /u01/app/oracle/product/19.0.0/grid/oui/bin/runInstaller -updateNodeList
     -silent ORACLE_HOME=upgraded_Grid_home -local CRS=false




                                                                                               3-2
                                                                                        Chapter 3
                                                                       Downgrading Oracle Restart

9.   As the root user, run roothas.sh with the -unlock flag to unlock the previous release
     Oracle Restart home.

     # /u01/app/oracle/product/18.0.0/grid/crs/install/roothas.sh -unlock -
     dstcrshome previous_release_Grid_home

10. As the grid user, reconfigure the previous release Oracle Restart home using the
     gridSetup.sh command.

     $ /u01/app/oracle/product/18.0.0/grid/gridSetup.sh

11. As the oracle user, add the components back to Oracle Restart with the same attributes
     that you noted down before deconfiguring Oracle Restart.
     a.   Add Oracle Database to the Oracle Restart configuration.

          $ srvctl add database -db db_unique_name -oraclehome Oracle_home

     b.   Add the listener to the Oracle Restart configuration.

          $ srvctl add listener -listener listener_name -oraclehome Oracle_home


          For the -oraclehome parameter, provide the Oracle home path from which the listener
          was running before the downgrade.
     c.   Add each service to the database, using the srvctl add service command.

          $ srvctl add service -db db_unique_name -service service_name_list

Related Topics
•    Oracle Database Upgrade Guide




                                                                                             3-3

