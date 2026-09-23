# 59. Deploying and Managing Oracle Software Using Fleet Patching and Provisioning

> 源文件: `en/sprhp/deploying-and-managing-oracle-software-using-fleet-patching-and-provisioning.pdf`

Oracle® Database
Deploying and Managing Oracle Software
Using Fleet Patching and Provisioning




   Release 19c
   E96441-01
   January 2019
Oracle Database Deploying and Managing Oracle Software Using Fleet Patching and Provisioning, Release
19c

E96441-01

Copyright © 2016, 2019, Oracle and/or its affiliates. All rights reserved.

Primary Authors: Prakash Jashnani, Aparna Kamath, Richard Strohm

Contributors: Bernard Clouse, Sampath Ravindhran, Douglas Williams, Mark Bauer, Jean-Francois Verrier

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
    Audience                                                                      iv
    Documentation Accessibility                                                   iv
    Conventions                                                                   iv
    Related Documentation                                                          v



1   Fleet Patching and Provisioning Use Cases
    Getting Started with Fleet Patching and Provisioning                         1-2
    Adding Gold Images for Fleet Patching and Provisioning                       1-3
    Creating an Oracle Grid Infrastructure 12c Release 2 Deployment              1-4
    Provisioning an Oracle Database Home and Creating a Database                 1-5
    Upgrading to Oracle Grid Infrastructure 12c Release 2                        1-5
    Patching Oracle Grid Infrastructure Without Changing the Grid Home Path      1-6
    Patching Oracle Grid Infrastructure and Oracle Databases Simultaneously      1-7
    Patching Oracle Database 12c Release 1 Without Downtime                      1-8
    Upgrading to Oracle Database 12c Release 2                                   1-9
    Adding a Node to a Cluster and Scaling an Oracle RAC Database to the Node   1-11
    Creating a User Action to Deploy a Web Server                               1-11


    Index




                                                                                  iii
                                                                                                       Preface




Preface
           This guide provides specific use cases for Fleet Patching and Provisioning to simplify
           lifecycle management tasks in your standard operating environment.

           •    Audience
           •    Documentation Accessibility
           •    Conventions
           •    Related Documentation


Audience
           This guide is intended for anyone responsible for provisioning, patching, and
           upgrading their Oracle Database software using Fleet Patching and Provisioning.
           Additional installation guides for Oracle Database, Oracle Real Application Clusters,
           and Oracle Clusterware are available at:
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


Conventions
           The following text conventions are used in this document:


           Convention               Meaning
           boldface                 Boldface type indicates graphical user interface elements associated
                                    with an action, or terms defined in text or the glossary.
           italic                   Italic type indicates book titles, emphasis, or placeholder variables for
                                    which you supply particular values.




                                                                                                                iv
                                                                                              Preface




         Convention            Meaning
         monospace             Monospace type indicates commands within a paragraph, URLs, code
                               in examples, text that appears on the screen, or text that you enter.



Related Documentation
         The related documentation for this guide includes the following manuals:
         Related Topics
         •   Oracle Clusterware Administration and Deployment Guide
         •   Oracle Database Installation Guide
         •   Oracle Grid Infrastructure Installation and Upgrade Guide
         •   Oracle Real Application Clusters Administration and Deployment Guide
         •   Oracle Real Application Clusters Installation Guide for Linux and UNIX
         •   Oracle Database Upgrade Guide
         •   Oracle Database Release Notes




                                                                                                       v
1
Fleet Patching and Provisioning Use Cases
      Review these topics for step-by-step procedures to provision, patch, and upgrade your
      software using Fleet Patching and Provisioning.
      Fleet Patching and Provisioning is a software lifecycle management solution and helps
      standardize patching, provisioning, and upgrade of your standard operating
      environment.
      •   Getting Started with Fleet Patching and Provisioning
          Understand how you can get started and use Fleet Patching and Provisioning in
          your standard deployment.
      •   Adding Gold Images for Fleet Patching and Provisioning
          Create gold images of software home and store them on the Fleet Patching and
          Provisioning Server, to use later to provision Oracle homes.
      •   Creating an Oracle Grid Infrastructure 12c Release 2 Deployment
          Provision Oracle Grid Infrastructure software on two nodes that do not currently
          have a Grid home, and then configure Oracle Grid Infrastructure to form a multi-
          node Oracle Grid Infrastructure installation.
      •   Provisioning an Oracle Database Home and Creating a Database
          This procedure provisions Oracle Database 12c release 2 (12.2) software and
          creates Oracle Database instances.
      •   Upgrading to Oracle Grid Infrastructure 12c Release 2
          This procedure uses Fleet Patching and Provisioning to upgrade your Oracle Grid
          Infrastructure cluster from 11g release 2 (11.2.0.4) to 12c release 2 (12.2).
      •   Patching Oracle Grid Infrastructure Without Changing the Grid Home Path
          This procedure explains how to patch Oracle Grid Infrastructure without changing
          the Grid home path.
      •   Patching Oracle Grid Infrastructure and Oracle Databases Simultaneously
          This procedure patches Oracle Grid Infrastructure and Oracle Databases on the
          cluster to the latest patch level without cluster downtime.
      •   Patching Oracle Database 12c Release 1 Without Downtime
          This procedure explains how to patch Oracle Database 12c release 1 (12.1.0.2)
          with the latest patching without bringing down the database.
      •   Upgrading to Oracle Database 12c Release 2
          This procedure describes how to upgrade an Oracle database from Oracle
          Database 11g release 2 (11.2) to 12c release 2 with a single command, using
          Fleet Patching and Provisioning, both for managed and unmanaged Oracle
          homes.
      •   Adding a Node to a Cluster and Scaling an Oracle RAC Database to the Node
          You can add a node to your two-node cluster by using Fleet Patching and
          Provisioning to add the node, and then extend an Oracle RAC database to the
          new node.




                                                                                         1-1
                                                                                                   Chapter 1
                                                        Getting Started with Fleet Patching and Provisioning


          •   Creating a User Action to Deploy a Web Server
              You can install and configure any type of software using Fleet Patching and
              Provisioning user actions. Review this procedure to automate deployment of
              Apache Web Server using Fleet Patching and Provisioning.


Getting Started with Fleet Patching and Provisioning
          Understand how you can get started and use Fleet Patching and Provisioning in your
          standard deployment.

          How Do I Get Started with Fleet Patching and Provisioning?
          You must create and configure a Fleet Patching and Provisioning Server where you
          can create and store gold images of Oracle Database, Oracle Grid Infrastructure, and
          other software homes. For detailed steps on creating an Fleet Patching and
          Provisioning Server see My Oracle Support Note 2097026.1.
          https://support.oracle.com/rs?type=doc&id=2097026.1
          To set up the Fleet Patching and Provisioning Server, ensure that your hardware
          meets the requirements described in My Oracle Support Note 2126710.1 available at:
          https://support.oracle.com/rs?type=doc&id=2126710.1


          How can I Use Fleet Patching and Provisioning in my Standard Operating
          Environment?
          Review these topics for step-by-step procedures to provision, patch, and upgrade your
          software using Fleet Patching and Provisioning.


          Task                                          Description
          Create an Oracle Grid Infrastructure 12c      Provision and configure Oracle Grid
          Release 2 Deployment                          Infrastructure software on two nodes that do
                                                        not currently have a Grid home, and then
                                                        configure Oracle Grid Infrastructure to form a
                                                        multi-node Oracle Grid Infrastructure
                                                        installation.
          Provision Oracle Database Home Software       Provision Oracle Database 12c release 2
          and Create a Database                         (12.2) software and create Oracle Database
                                                        instances.
          Upgrade to Oracle Grid Infrastructure 12c     Upgrade your Oracle Grid Infrastructure cluster
          Release 2                                     from 11g release 2 (11.2.0.4) to 12c release 2
                                                        (12.2) with two Fleet Patching and Provisioning
                                                        commands.
          Patch Oracle Grid Infrastructure without      Use Fleet Patching and Provisioning to enable
          changing your Grid Home Path                  Oracle Layered File System (OLFS) for a
                                                        single Oracle home for change management.
          Patch Oracle Grid Infrastructure and Oracle   Patch Oracle Grid Infrastructure and Oracle
          Databases Simultaneously                      Databases on the cluster to the latest patch
                                                        level without cluster downtime.
          Patch Oracle Database 12c Release 1 Without Patch Oracle Database 12c release 1 (12.1)
          Downtime                                    with the latest patching without bringing down
                                                      the database.




                                                                                                       1-2
                                                                                                  Chapter 1
                                                     Adding Gold Images for Fleet Patching and Provisioning




          Task                                          Description
          Upgrade to Oracle Database 12c Release 2      Upgrade an Oracle Database from 11.2 to 12c
                                                        release 2 with a single command, using Fleet
                                                        Patching and Provisioning, both for managed
                                                        and unmanaged Oracle homes.
          Add a Node to a Cluster and Scale an Oracle   To your two-node cluster, add a new node,
          RAC Database to the Node                      and extend an Oracle RAC Database to the
                                                        new node, using Fleet Patching and
                                                        Provisioning.
          Create a Fleet Patching and Provisioning      Create gold images of software home and
          Image                                         store them on the Fleet Patching and
                                                        Provisioning Server, to use later for creating
                                                        working copies.
          Create a User Action to Deploy an Apache      You can install and configure any type of
          Web Server                                    software using Fleet Patching and Provisioning
                                                        user actions. Review this procedure to
                                                        automate deployment of Apache Web Server
                                                        using Fleet Patching and Provisioning.


Adding Gold Images for Fleet Patching and Provisioning
         Create gold images of software home and store them on the Fleet Patching and
         Provisioning Server, to use later to provision Oracle homes.

         Before You Begin
         The Oracle home to be used for creating the gold image can be on the Fleet Patching
         and Provisioning Server, or Fleet Patching and Provisioning Client, or any target
         machine that the Fleet Patching and Provisioning Server can communicate with.

         Procedure
         Create gold images of Oracle homes in any of the following ways and store them on
         the Fleet Patching and Provisioning server:
         1.   Import an image from an installed Oracle home on the Fleet Patching and
              Provisioning Server:

              rhpctl import image -image db12201 -path /share/software/122/dbhome -
              imagetype ORACLEDBSOFTWARE


              The gold image of imagetype Oracle Database 12c release 2 software is created
              and stored on the Fleet Patching and Provisioning Server.
              You can also create gold images of Oracle Grid Infrastructure or any other
              software by specifying -imagetype as ORACLEGISOFTWARE, ORACLEGGSOFTWARE, or
              SOFTWARE respectively.
         2.   Import an image from an installed Oracle home on a Fleet Patching and
              Provisioning Client by running the following command from the Fleet Patching and
              Provisioning Client:

              rhpctl import image -image db12201 -path /u01/app/dbusr/product/12.2.0/




                                                                                                      1-3
                                                                                                  Chapter 1
                                            Creating an Oracle Grid Infrastructure 12c Release 2 Deployment


              The command creates and adds the image db12201 based on the local Oracle
              home installed in the specified path.



                 Note:
                 You cannot directly use images as software homes. Use images to create
                 working copies of software homes.



Creating an Oracle Grid Infrastructure 12c Release 2
Deployment
          Provision Oracle Grid Infrastructure software on two nodes that do not currently have a
          Grid home, and then configure Oracle Grid Infrastructure to form a multi-node Oracle
          Grid Infrastructure installation.

          Before You Begin
          Provide configuration details for storage, network, users and groups, and node
          information for installing Oracle Grid Infrastructure in a response file. You can store the
          response file in any location on the Fleet Patching and Provisioning Server.
          You can provision an Oracle Standalone Cluster, Oracle Application Clusters, Oracle
          Domain Services Cluster, or Oracle Member Clusters. Ensure that the response file
          has the required cluster configuration details.
          Ensure that you have storage, network, and operating system requirements configured
          as stated in the Oracle Grid Infrastructure Installation Guide.

          Procedure
          •   From the Fleet Patching and Provisioning Server, run the command:

              $ rhpctl add workingcopy -workingcopy GI122 -image GI_HOME_12201 –
              responsefile /u01/app/rhpinfo/GI_12201_install.rsp
              {authentication_option}


              GI122 is the working copy based on the image GI_HOME_12201
              /u01/app/rhpinfo/GI_12201_install.rsp is the response file location.
              Cluster Verification Utility checks for preinstallation configuration as per
              requirements. Fleet Patching and Provisioning configures Oracle Grid
              Infrastructure.
          Oracle Grid Infrastructure 12c release 2 is provisioned as per the settings in the same
          response file.
          During provisioning, if an error occurs, the procedure stops and allows you to fix the
          error. After fixing the error, you can resume the provisioning operation from where it
          last stopped.

          Watch a video     Video




                                                                                                      1-4
                                                                                              Chapter 1
                                           Provisioning an Oracle Database Home and Creating a Database




Provisioning an Oracle Database Home and Creating a
Database
          This procedure provisions Oracle Database 12c release 2 (12.2) software and creates
          Oracle Database instances.

          Procedure
          1.   From the Fleet Patching and Provisioning Server, provision the Oracle Database
               home software:

               $ rhpctl add workingcopy -image db12201 -path /u01/app/dbusr/product/
               12.2.0/db12201
                 -client client_001 -oraclebase /u01/app/dbusr/ -workingcopy db122


               The command provisions the working copy db122 to the specified path on the
               cluster client_001, from the image db12201 .
          2.   Create the database instance:

               $ rhpctl add database -workingcopy db122 -dbname db -dbtype RAC


               The command creates an Oracle RAC database instance db . You can use the add
               database command repeatedly to create more instances on the working copy.

          Watch a video     Video


Upgrading to Oracle Grid Infrastructure 12c Release 2
          This procedure uses Fleet Patching and Provisioning to upgrade your Oracle Grid
          Infrastructure cluster from 11g release 2 (11.2.0.4) to 12c release 2 (12.2).

          Before You Begin
          To upgrade to Oracle Grid Infrastructure 12c release 2 (12.2.0.1), your source must be
          Oracle Grid Infrastructure 11g release 2 (11.2.0.3 or 11.2.0.4), or Oracle Grid
          Infrastructure 12c release 2 (12.1.0.2).
          Ensure that groups configured in the source home match those in the destination
          home.
          Ensure that you have an image GI_HOME_12201 of the Oracle Grid Infrastructure 12c
          release 2 (12.2.0.1) software to provision your working copy.
          GI_11204 is the active Grid Infrastructure home on the cluster being upgraded. It is a
          working copy because in this example, Fleet Patching and Provisioning provisioned
          the cluster. Fleet Patching and Provisioning can also upgrade clusters whose Grid
          Infrastructure homes are unmanaged that is, homes that Fleet Patching and
          Provisioning did not provision.




                                                                                                  1-5
                                                                                                   Chapter 1
                                     Patching Oracle Grid Infrastructure Without Changing the Grid Home Path




          Procedure
          1.   Provision a working copy of the Oracle Grid Infrastructure 12c release 2 (12.2.0.1)
               software:

               $ rhpctl add workingcopy -workingcopy GI122 -image GI_HOME_12201
               {authentication_option}


               GI122 is the working copy based on the image GI_HOME_12201.
          2.   Upgrade your target cluster to the GI122 working copy:

               rhpctl upgrade gihome -sourcewc GI11204 -destwc GI122


               Rapid Home Provisioning identifies the cluster to upgrade based on the name of
               the source working copy, and upgrades to the working copy GI122.


Patching Oracle Grid Infrastructure Without Changing the
Grid Home Path
          This procedure explains how to patch Oracle Grid Infrastructure without changing the
          Grid home path.

          Before You Begin
          •    Ensure that the gold image containing the Grid home is imported and exists on the
               Fleet Patching and Provisioning Server.
          •    Ensure that the directory you provide in the path option is not an existing directory.
          •    The source Grid home must be a managed home (provisioned by Fleet Patching
               and Provisioning). It does not need to be an Oracle Layered File System (OLFS)-
               compliant home.
          •    The Grid home must be Oracle Grid Infrastructure 12c (12.2.0.1) or later.

          Procedure for Patching
          •    To move a non-OLFS-compliant Grid home to an OLFS Grid home, from the Fleet
               Patching and Provisioning Server, run two commands similar to the following:

               $ rhpctl add workingcopy -workingcopy GI_HOME_12201_PSU1 -aupath
                 /u01/app/orabase/product/12.2.0.1/aupath -image image_name
                 -client client_name -softwareonly


               $ rhpctl move gihome -srcwc GI_HOME_12201 -destwc GI_HOME_12201_PSU1 -
               agpath
                 /u01/app/orabase/product/12.2.0.1/agpath -path
                 /u01/app/orabase/product/12.2.0.1/grid




                                                                                                       1-6
                                                                                                  Chapter 1
                                    Patching Oracle Grid Infrastructure and Oracle Databases Simultaneously


         •    To move an OLFS-compliant Grid home to a patched version, run two commands
              similar to the following:

              $ rhpctl add workingcopy -workingcopy gihome12201_psu1_lpm -aupath
                /u01/app/orabase/product/12.2.0.1/aupath -image image_name -client
                client_name -softwareonly


              $ rhpctl move gihome -sourcewc gihome12201_lpm -destwc
              gihome12201_psu1_lpm


Patching Oracle Grid Infrastructure and Oracle Databases
Simultaneously
         This procedure patches Oracle Grid Infrastructure and Oracle Databases on the
         cluster to the latest patch level without cluster downtime.

         Before You Begin
         In this procedure, Oracle Grid Infrastructure 12c release 2 (12.2.0.1) is running on the
         target cluster. Working copy GI_HOME_12201_WCPY is the active Grid home on this
         cluster. Working copy DB_HOME_12201_WCPY runs an Oracle RAC 12c release 2
         (12.2.0.1) Database with running database instance db1. Working copy
         DB_HOME_12102_WCPY runs an Oracle RAC 12c release 1 (12.1.0.2) Database with
         running database instance db2

         Ensure that you have images GI_HOME_12201_PSU1, DB_HOME_12201_PSU1,
         DB_HOME_12102_PSU5 with the required patches for Oracle Grid Infrastructure and
         Oracle RAC Database on the Fleet Patching and Provisioning Server.
         The groups configured in the source home must match with those in the destination
         home.

         Procedure
         1.   Prepare target Oracle homes as follows:
              a.   Provision software-only Grid home on the cluster to be patched:

                   $ rhpctl add workingcopy -workingcopy GI_HOME_12201_PATCHED_WCPY
                     -image GI_HOME_12201_PSU1 –client CLUSTER_005 -softwareonly

              b.   Provision each release Database home, without database instances, to be
                   patched:

                   $ rhpctl add workingcopy -workingcopy DB_HOME_12201_PATCHED_WCPY
                     -image DB_HOME_12201_PSU1
                   $ rhpctl add workingcopy -workingcopy DB_HOME_12102_PATCHED_WCPY
                     -image DB_HOME_12102_PSU5




                                                                                                      1-7
                                                                                            Chapter 1
                                              Patching Oracle Database 12c Release 1 Without Downtime


         2.   Patch Oracle Grid Infrastructure and all Oracle RAC Databases on node1 as
              follows:

              $ rhpctl move gihome -sourcewc GI_HOME_12201_WCPY -destwc
              GI_HOME_12201_PATCHED_WCPY -auto
                -dbhomes
              DB_HOME_12102_WCPY=DB_HOME_12102_PATCHED_WCPY,DB_HOME_12201_WCPY=DB_HOME
              _12201_PATCHED_WCPY -targetnode node1 {authentication_option}


              When you run the command, you move your active Oracle Grid Infrastructure from
              working copy GI_HOME_12201_WCPY to GI_HOME_12201_PATCHED_WCPY, Oracle RAC
              Database db1 from DB_HOME_12201_WCPY to DB_HOME_12201_PATCHED_WCPY, and
              Oracle RAC Database db2 from DB_HOME_12102_WCPY to
              DB_HOME_12102_PATCHED_WCPY.


Patching Oracle Database 12c Release 1 Without Downtime
         This procedure explains how to patch Oracle Database 12c release 1 (12.1.0.2) with
         the latest patching without bringing down the database.

         Before You Begin
         You have an Oracle Database db12102 that you want to patch to the latest patch level.

         Ensure that the working copy db12102_psu based on the image DB12102_PSU contains
         the latest patches and is available.

         Procedure
         From the Fleet Patching and Provisioning Server, run one of the following commands
         as per your source and destination database:
         1.   To patch an Oracle Database home managed by Fleet Patching and Provisioning,
              and there exist working copies of the source and destination databases, run:

              rhpctl move database -sourcewc db12102 -patchedwc db12102_psu


              db12102 is the source working copy of the database being patched
              db12102_psu is the working copy of the Oracle Database software with patches
              applied, based on the image DB12102_PSU.
         2.   To patch an unmanaged Oracle Database home (source working copy does not
              exist because the Oracle home is not managed by Fleet Patching and
              Provisioning), run:

              rhpctl move database -sourcehome /u01/app/orabase/product/12.1.0.2/
              dbhome_1
               -patchedwc db12102_psu -targetnode node1


              targetnode specifies the node on which the database to be upgraded is running,
              because the source Oracle Database is on a 12.1.0.2 cluster.
              /u01/app/orabase/product/12.1.0.2/dbhome_1 is the path of the database being
              patched



                                                                                                 1-8
                                                                                            Chapter 1
                                                           Upgrading to Oracle Database 12c Release 2


              db12102_psu is the working copy of the Oracle Database software with patches
              applied, based on the image DB12102_PSU.

              Use the saved gold image for standardized patching of all your databases of
              release 12c release 1 to the same patch level.
         3.   If for some reason, you want to rollback the patches applied to a managed Oracle
              Database home, run:

              rhpctl move database -sourcewc db12102_psu
              -patchedwc db12102 -ignorewcpatches


              db12102 is the working copy of the unpatched database to which you want to roll
              back.
              db12102_psu is the working copy of the Oracle Database software with patches
              applied, based on the image DB12102_PSU.
         For all Oracle Databases, you can also specify these additional options with the move
         database command:

         •    -keepplacement: For admin-managed Oracle RAC Databases (not Oracle RAC
              One Node Database), Fleet Patching and Provisioning retains the services on the
              same nodes after the move.
         •    -disconnect: Disconnects all sessions before stopping or relocating services.
         •    -drain_timeout: Specify the time, in seconds, allowed for resource draining to be
              completed for planned maintenance operations. During the draining period, all
              current client requests are processed, but new requests are not accepted. This
              option is available only with Oracle Database 12c release 2 (12.2) or later.
         •    -stopoption: Stops the database.
         •    -nodatapatch: Ensures datapatch is not run for databases you are moving.

         Watch a video     Video


Upgrading to Oracle Database 12c Release 2
         This procedure describes how to upgrade an Oracle database from Oracle Database
         11g release 2 (11.2) to 12c release 2 with a single command, using Fleet Patching and
         Provisioning, both for managed and unmanaged Oracle homes.

         Before you Begin
         •    To upgrade to Oracle Database 12c release 2 (12.2.0.1), your source database
              must be either Oracle Database 11g release 2 (11.2.0.3 or 11.2.0.4), or Oracle
              Database 12c release 1 (12.1.0.2).
         •    Oracle Grid Infrastructure on which the pre-upgrade database is running must be
              of the same release or later than the database release to which you are upgrading.
         •    The source Oracle home to be upgraded can be a managed working copy, that is
              an Oracle home provisioned using Fleet Patching and Provisioning, or an
              unmanaged home, that is, an Oracle home not provisioned using Fleet Patching
              and Provisioning. If you are upgrading an unmanaged Oracle home, provide the
              complete path of the database for upgrade.




                                                                                                1-9
                                                                                     Chapter 1
                                                    Upgrading to Oracle Database 12c Release 2




Procedure to Upgrade Oracle Database using Fleet Patching and Provisioning
1.   From the Fleet Patching and Provisioning Server, run one of the following
     commands as per your source and destination database:
     a.   To upgrade an Oracle home managed by Fleet Patching and Provisioning,
          and there exist working copies of the source and destination databases, run:

          $ rhpctl upgrade database -dbname test_database -sourcewc db112 -
          destwc db122
            {authentication_option}


          test_database is the name of the database being upgraded.
          db112 is the source working copy of the pre-upgrade database.
          db122 is the working copy of the upgraded Oracle Database software.
     b.   To upgrade an unmanaged Oracle home (source working copy does not exist
          because the Oracle home is not managed by Fleet Patching and
          Provisioning), run:

          $ rhpctl move database -sourcehome /u01/app/orabase/product/11.2.0/
          dbhome_1
            -destwc db122 -targetnode node1 {authentication_option}


          /u01/app/orabase/product/11.2.0/dbhome_1 is the path of the database
          being upgraded.
          db122 is the working copy of the upgraded Oracle Database software.
          targetnode specifies the node on which the database to be upgraded is
          running, because the source Oracle Database is on a 11.2.0.4 cluster.

The upgraded database is now managed by Fleet Patching and Provisioning. You can
ensure that your database is patched to the latest level, using Fleet Patching and
Provisioning.



          Note:
          During upgrade, if an error occurs, the procedure stops and allows you to fix
          the error. After fixing the error, you can resume the upgrade operation from
          where it last stopped.


Watch a video        Video




                                                                                        1-10
                                                                                                  Chapter 1
                                  Adding a Node to a Cluster and Scaling an Oracle RAC Database to the Node




Adding a Node to a Cluster and Scaling an Oracle RAC
Database to the Node
         You can add a node to your two-node cluster by using Fleet Patching and Provisioning
         to add the node, and then extend an Oracle RAC database to the new node.

         Before You Begin
         In this procedure, Oracle Grid Infrastructure 12c release 2 (12.2.0.1) is running on the
         cluster. Working copy GI_HOME_12202_WCPY is the active Grid home on this cluster.

         The Oracle RAC database home runs on the working copy DB_HOME_12202_WCPY.

         Ensure that you have storage, network, and operating system requirements configured
         for the new node as stated in Oracle Grid Infrastructure Installation Guide.

         Procedure
         1.   From the Fleet Patching and Provisioning Server, run the following command to
              add a node to the existing Oracle Grid Infrastructure working copy:

              rhpctl addnode gihome -workingcopy GI_HOME_12202_WCPY -newnodes n3:n3-
              vip {authentication_option}


              The command extends the cluster by adding node3.
         2.   Add instances to the administrator-managed Oracle RAC database on the new
              node:

              rhpctl addnode database -workingcopy DB_HOME_12202_WCPY -dbname db321 -
              node n3 {authentication_option}


              The command extends the database home on the node3 and creates database
              db321 on this node.

         Watch a video       Video


Creating a User Action to Deploy a Web Server
         You can install and configure any type of software using Fleet Patching and
         Provisioning user actions. Review this procedure to automate deployment of Apache
         Web Server using Fleet Patching and Provisioning.
         Fleet Patching and Provisioning supports creation of work flows to deploy and manage
         all types of software.
         1.   Create the script to install Apache Web server:
              a.   On the Fleet Patching and Provisioning Server, download and extract the
                   Apache Web server installation kit.
              b.   Create the script to install, configure, and start the Apache Web server.




                                                                                                     1-11
                                                                                      Chapter 1
                                                  Creating a User Action to Deploy a Web Server


2.   Register the script as a user action with Fleet Patching and Provisioning. Run the
     following command from the Fleet Patching and Provisioning Server:

     rhpctl useraction -useraction apachestart
     -actionscript /user1/useractions/apacheinstall.sh
     -post -optype ADD_WORKINGCOPY -onerror ABORT


     The command adds the apachestart user action for the action script stored in the
     specified directory. As per the specified properties, the user action runs after the
     ADD_WORKINGCOPY operation and aborts if there is any error.
3.   Create an image type and associate the user action with the image type:

     rhpctl add imagetype -imagetype apachetype -basetype SOFTWARE
     -useraction "apachestart"


     The command creates a new image type called apachetype, a derivative of the
     basic image type SOFTWARE with an associated user action apacherstart.
4.   Create a gold image of the image type:

     rhpctl import image -image apacheinstall -path /user1/apache2219_kit/
     -imagetype apachetype


     The command creates a gold image apacheinstall with the script for Apache
     Web server installation, in the specified path based on the imagetype created
     earlier.
     To view the properties of this image, run the rhpctl query image -image
     apacheinstall command.
5.   Deploy a working copy of the gold image on the target:

     rhpctl add workingcopy -workingcopy apachecopy -image apacheinstall
     -path /user1/apacheinstallloc -sudouser user1
     -sudopath /usr/local/bin/sudo -node node1 -user user1
     -useractiondata "/user1/apachehome:1080:2.2.19


     Fleet Patching and Provisioning provisions the software to the target and runs the
     script apachestart specified in the user action. You provide the Apache Web
     server configuration details such as port number with the useractiondata option.
     If the target is a Fleet Patching and Provisioning Client, then you need not specify
     sudo credentials.
You can create other user actions and automate installation and configuration of
software homes using Fleet Patching and Provisioning.




                                                                                         1-12
Index
C                                   Oracle Grid Infrastructure
                                       creating, 1-4
cluster                                patching, 1-6, 1-7
    adding a node, 1-11                upgrading, 1-5

F                                   S
Fleet Patching and Provisioning     standard operating environment, 1-2
    user actions
        creating web server, 1-11
                                    T
G                                   typographic conventions, iv

gold images
    adding, 1-3

O
Oracle Database
   patching, 1-7, 1-8
   scaling, 1-11
   upgrading, 1-9




                                                                          Index-1

