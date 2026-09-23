# 60. Enterprise User Security Administrators Guide

> 源文件: `en/dbimi/enterprise-user-security-administrators-guide.pdf`

Oracle® Database
Enterprise User Security Administrator's
Guide




    19c
    E96086-04
    May 2020
Oracle Database Enterprise User Security Administrator's Guide, 19c

E96086-04

Copyright © 2000, 2020, Oracle and/or its affiliates.

Primary Author: Rod Ward

Contributors: Apoorva Srinivas, Tanvir Ahmed, Chi Ching Chui, Santanu Datta, Janis Greenberg, Rishabh
Gupta, Pat Huey, Min-Hank Ho, Yong Hu, Sudha Iyer, Sumit Jeloka, Supriya Kalyanasundaram, Srinidhi
Kayoor, Lakshmi Kethana, Manoj Kamani, Van Le, Nina Lewis, Stella Li, Chao Liang, Gopal Mulagund,
Sarma Namuduri, Janaki Narasinghanallur, Hozefa Palitanawala, Eric Paapanen, Vikram Pesati, Andy
Philips, Richard Smith, Deborah Steiner, Srividya Tata, Philip Thornton, Ramana Turlapati, Sudheesh Varma,
Anand Verma, Peter Wahl , Alan Williams

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

U.S. GOVERNMENT END USERS: Oracle programs (including any operating system, integrated software,
any programs embedded, installed or activated on delivered hardware, and modifications of such programs)
and Oracle computer documentation or other Oracle data delivered to or accessed by U.S. Government end
users are "commercial computer software" or “commercial computer software documentation” pursuant to the
applicable Federal Acquisition Regulation and agency-specific supplemental regulations. As such, the use,
reproduction, duplication, release, display, disclosure, modification, preparation of derivative works, and/or
adaptation of i) Oracle programs (including any operating system, integrated software, any programs
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
set forth in an applicable agreement between you and Oracle. Oracle Corporation and its affiliates will not be
responsible for any loss, costs, or damages incurred due to your access to or use of third-party content,
products, or services, except as set forth in an applicable agreement between you and Oracle.
Contents
    Preface
    Intended Audience                                                                   xxii
    Documentation Accessibility                                                         xxii
    Related Documents                                                                  xxiii
    Conventions                                                                        xxiv


    Changes in This Release for Oracle Database Enterprise User
    Security Administrator's Guide
    Changes in this Release for Release 19c Version 19.1                                xxv
    Changes in Oracle Database Release 18c Version 18.1                                xxvi
    Changes in Oracle Database 12c Release 2 (12.2.0.1)                                xxvii



1   Introducing Enterprise User Security
    1.1     Introduction to Enterprise User Security                                    1-1
          1.1.1   The Challenges of User Management                                     1-1
          1.1.2   Enterprise User Security: The Big Picture                             1-2
              1.1.2.1   How Oracle Internet Directory Implements Identity Management    1-4
              1.1.2.2   Enterprise Users Compared to Database Users                     1-5
              1.1.2.3   About Enterprise User Schemas                                   1-6
              1.1.2.4   How Enterprise Users Access Database Resources with
                        Database Links                                                  1-7
              1.1.2.5   How Enterprise Users Are Authenticated                          1-8
          1.1.3   About Enterprise User Security Directory Entries                     1-10
              1.1.3.1   Enterprise Users                                               1-10
              1.1.3.2   Enterprise Roles                                               1-11
              1.1.3.3   Enterprise Domains                                             1-13
              1.1.3.4   Database Server Entries                                        1-13
              1.1.3.5   User-Schema Mappings                                           1-15
              1.1.3.6   Administrative Groups                                          1-15
              1.1.3.7   Password Policies                                              1-17
    1.2     About Using Shared Schemas for Enterprise User Security                    1-18




                                                                                          iii
          1.2.1   Overview of Shared Schemas Used in Enterprise User Security               1-19
          1.2.2   How Shared Schemas Are Configured for Enterprise Users                    1-19
          1.2.3   How Enterprise Users Are Mapped to Schemas                                1-20
    1.3     Enterprise User Proxy                                                           1-22
    1.4     About Using Current User Database Links for Enterprise User Security            1-24
    1.5     Enterprise User Security Deployment Considerations                              1-25
          1.5.1   Security Aspects of Centralizing Security Credentials                     1-26
              1.5.1.1   Security Benefits Associated with Centralized Security Credential
                        Management                                                          1-26
              1.5.1.2   Security Risks Associated with Centralized Security Credential
                        Management                                                          1-26
          1.5.2   Security of Password-Authenticated Enterprise User Database Login
                  Information                                                               1-26
              1.5.2.1   What Is Meant by Trusted Databases                                  1-27
              1.5.2.2   Protecting Database Password Verifiers                              1-27
          1.5.3   Considerations for Defining Database Membership in Enterprise
                  Domains                                                                   1-28
          1.5.4   Choosing Authentication Types between Clients, Databases, and
                  Directories for Enterprise User Security                                  1-28
              1.5.4.1   Typical Configurations                                              1-29



2   Getting Started with Enterprise User Security
    2.1     Configuring Your Database to Use the Directory                                   2-1
    2.2     Registering Your Database with the Directory                                     2-4
    2.3     Registering an Oracle RAC Database with the Directory                            2-7
    2.4     Creating a Shared Schema in the Database                                         2-8
    2.5     Mapping Enterprise Users to the Shared Schema                                    2-8
    2.6     Connecting to the Database as an Enterprise User                                 2-9
    2.7     Using Enterprise Roles                                                           2-9
    2.8     Using Proxy Permissions                                                         2-14
    2.9     Using Pluggable Databases                                                       2-18
          2.9.1   Wallet Location for Pluggable Databases                                   2-19
          2.9.2   Wallet Root for Pluggable Databases                                       2-19
          2.9.3   Connecting to a Directory Service                                         2-20
              2.9.3.1   Comparison of the dsi.ora and ldap.ora Files                        2-20
              2.9.3.2   About Using a dsi.ora File                                          2-20
              2.9.3.3   Creating the dsi.ora File                                           2-22
              2.9.3.4   About Using an ldap.ora File                                        2-22
              2.9.3.5   Creating the ldap.ora File                                          2-23
          2.9.4   Default Database DN Format                                                2-24
          2.9.5   Plugging and Unplugging PDBs                                              2-24




                                                                                              iv
          2.9.6   Switching Containers                                                  2-24



3   Configuration and Administration Tools Overview
    3.1     Enterprise User Security Tools Overview                                      3-1
    3.2     Oracle Internet Directory Self-Service Console                               3-2
    3.3     Oracle Net Configuration Assistant                                           3-2
          3.3.1   Starting Oracle Net Configuration Assistant                            3-3
    3.4     Database Configuration Assistant                                             3-4
          3.4.1   Starting Database Configuration Assistant                              3-4
    3.5     Oracle Wallet Manager                                                        3-4
          3.5.1   Starting Oracle Wallet Manager                                         3-5
          3.5.2   The orapki Command-Line Utility                                        3-5
    3.6     Oracle Enterprise Manager                                                    3-5
    3.7     User Migration Utility                                                       3-6
    3.8     Duties of an Enterprise User Security Administrator/DBA                      3-7



4   Enterprise User Security Configuration Tasks and Troubleshooting
    4.1     Enterprise User Security Configuration Overview                              4-1
    4.2     Enterprise User Security Configuration Roadmap                               4-4
    4.3     Preparing the Directory for Enterprise User Security (Phase One)             4-4
          4.3.1   Configuring Directory Access for Enterprise Users                     4-10
          4.3.2   About the Database Wallet and Password                                4-11
              4.3.2.1   Sharing Wallets and sqlnet.ora Files Among Multiple Databases   4-12
    4.4     Configuring Enterprise User Security Objects in the Database and the
            Directory (Phase Two)                                                       4-13
    4.5     Configure Enterprise User Security for the Authentication Method You
            Require (Phase Three)                                                       4-17
          4.5.1   Configuring Enterprise User Security for Password Authentication      4-17
          4.5.2   Configuring Enterprise User Security for Kerberos Authentication      4-19
          4.5.3   Configuring Enterprise User Security for SSL Authentication           4-22
              4.5.3.1   Viewing the Database DN in the Wallet and in the Directory      4-27
    4.6     Enabling Current User Database Links                                        4-27
    4.7     Troubleshooting Enterprise User Security                                    4-28
          4.7.1   ORA-n Errors for Password-Authenticated Enterprise Users              4-28
          4.7.2   ORA-n Errors for Kerberos-Authenticated Enterprise Users              4-31
          4.7.3   ORA-n Errors for SSL-Authenticated Enterprise Users                   4-33
          4.7.4   NO-GLOBAL-ROLES Checklist                                             4-34
          4.7.5   USER-SCHEMA ERROR Checklist                                           4-35
          4.7.6   DOMAIN-READ-ERROR Checklist                                           4-36




                                                                                          v
5   Administering Enterprise User Security
    5.1     Administering Identity Management Realms                                      5-1
          5.1.1   Identity Management Realm Versions                                      5-2
          5.1.2   Setting Properties of an Identity Management Realm                      5-2
              5.1.2.1   Setting Login Name, Kerberos Principal Name, User Search
                        Base, and Group Search Base Identity Management Realm
                        Attributes                                                        5-3
          5.1.3   Setting the Default Database-to-Directory Authentication Type for an
                  Identity Management Realm                                               5-3
          5.1.4   Managing Identity Management Realm Administrators                       5-4
    5.2     Administering Enterprise Users                                                5-5
          5.2.1   Creating New Enterprise Users                                           5-6
          5.2.2   Setting Enterprise User Passwords                                       5-6
          5.2.3   Granting Enterprise Roles to Enterprise Users                           5-7
          5.2.4   Granting Proxy Permissions to Enterprise Users                          5-8
          5.2.5   Creating User-Schema Mappings for Enterprise Users                      5-9
          5.2.6   Creating Label Authorizations for Enterprise Users                     5-10
    5.3     Configuring User-Defined Enterprise Groups                                   5-10
          5.3.1   Granting Enterprise Roles to User-Defined Enterprise Groups            5-11
    5.4     Configuring Databases for Enterprise User Security                           5-11
          5.4.1   Creating User-Schema Mappings for a Database                           5-12
          5.4.2   Adding Administrators to Manage Database Schema Mappings               5-12
    5.5     Administering Enterprise Domains                                             5-13
          5.5.1   Creating an Enterprise Domain                                          5-14
          5.5.2   Adding Databases to an Enterprise Domain                               5-14
          5.5.3   Creating User-Schema Mappings for an Enterprise Domain                 5-15
          5.5.4   Configuring Enterprise Roles                                           5-16
          5.5.5   Configuring Proxy Permissions                                          5-18
          5.5.6   Configuring User Authentication Types and Enabling Current User
                  Database Links                                                         5-19
          5.5.7   Configuring Domain Administrators                                      5-20



6   Using Oracle Wallet Manager
    6.1     About Oracle Wallet Manager                                                   6-1
          6.1.1   What Is Oracle Wallet Manager?                                          6-2
          6.1.2   Wallet Password Management                                              6-2
          6.1.3   Strong Wallet Encryption                                                6-2
          6.1.4   Microsoft Windows Registry Wallet Storage                               6-2
          6.1.5   ACL Settings Needed for Wallet Files Created Using Wallet Manager       6-3
          6.1.6   Backward Compatibility                                                  6-3
          6.1.7   Public-Key Cryptography Standards (PKCS) Support                        6-4



                                                                                           vi
      6.1.8    Multiple Certificate Support                                             6-4
      6.1.9    LDAP Directory Support                                                   6-6
6.2     Starting Oracle Wallet Manager                                                  6-7
6.3     General Process for Creating an Oracle Wallet                                   6-7
6.4     Managing Oracle Wallets                                                         6-8
      6.4.1    Required Guidelines for Creating Oracle Wallet Passwords                 6-8
      6.4.2    Creating a New Oracle Wallet                                             6-9
          6.4.2.1    Creating a Standard Oracle Wallet                                  6-9
          6.4.2.2    Creating an Oracle Wallet to Store Hardware Security Module
                     Credentials                                                       6-10
      6.4.3    Opening an Existing Oracle Wallet                                       6-11
      6.4.4    Closing an Oracle Wallet                                                6-12
      6.4.5    Exporting an Oracle Wallet to a Third-Party Environment                 6-12
      6.4.6    Exporting an Oracle Wallet to a Tools That Does Not Support PKCS
               #12                                                                     6-13
      6.4.7    Uploading an Oracle Wallet to an LDAP Directory                         6-14
      6.4.8    Downloading an Oracle Wallet from an LDAP Directory                     6-15
      6.4.9    Saving Changes to an Oracle Wallet                                      6-16
      6.4.10    Saving the Open Wallet to a New Location                               6-16
      6.4.11    Saving an Oracle Wallet to the System Default Directory Location       6-17
      6.4.12    Deleting an Oracle Wallet                                              6-17
      6.4.13    Changing the Oracle Wallet Password                                    6-18
      6.4.14    Using Auto Login for Oracle Wallets to Enable Access Without Human
                Intervention                                                           6-19
          6.4.14.1    About Using Auto Login for Oracle Wallets                        6-19
          6.4.14.2    Enabling Auto Login for Oracle Wallets                           6-19
          6.4.14.3    Disabling Auto Login for Oracle Wallets                          6-20
6.5     Managing Certificates for Oracle Wallets                                       6-20
      6.5.1    About Managing Certificates for Oracle Wallets                          6-20
      6.5.2    Managing User Certificates for Oracle Wallets                           6-21
          6.5.2.1    About Managing User Certificates                                  6-21
          6.5.2.2    Adding a Certificate Request                                      6-21
          6.5.2.3    Importing the User Certificate into an Oracle Wallet              6-23
          6.5.2.4    Importing Certificates and Wallets Created by Third Parties       6-25
          6.5.2.5    Removing a User Certificate from an Oracle Wallet                 6-26
          6.5.2.6    Removing a Certificate Request                                    6-27
          6.5.2.7    Exporting a User Certificate                                      6-27
          6.5.2.8    Exporting a User Certificate Request                              6-28
      6.5.3    Managing Trusted Certificates for Oracle Wallets                        6-29
          6.5.3.1    Importing a Trusted Certificate                                   6-29
          6.5.3.2    Removing a Trusted Certificate                                    6-30
          6.5.3.3    Exporting a Trusted Certificate to Another File System Location   6-31




                                                                                        vii
              6.5.3.4   Exporting All Trusted Certificates to Another File System Location   6-31



7   Enterprise User Security Manager (EUSM) Command Reference
    7.1     About Using a Secure External Password Store                                      7-2
    7.2     About SSL Port Connectivity through EUSM to OID                                   7-3
    7.3     Enterprise User Security Manager (EUSM) Command Summary                           7-4
          7.3.1    createDomain                                                               7-7
          7.3.2    deleteDomain                                                               7-9
          7.3.3    listDomains                                                               7-10
          7.3.4    listDomainInfo                                                            7-11
          7.3.5    addDomainAdmin                                                            7-13
          7.3.6    removeDomainAdmin                                                         7-14
          7.3.7    listDomainAdmins                                                          7-16
          7.3.8    addDatabase                                                               7-17
          7.3.9    removeDatabase                                                            7-19
          7.3.10    addDBAdmin                                                               7-20
          7.3.11    listDBAdmins                                                             7-22
          7.3.12    listDBInfo                                                               7-23
          7.3.13    removeDBAdmin                                                            7-24
          7.3.14    createMapping                                                            7-26
          7.3.15    deleteMapping                                                            7-28
          7.3.16    listMappings                                                             7-29
          7.3.17    setCulinkStatus                                                          7-31
          7.3.18    setAuthTypes                                                             7-32
          7.3.19    createRole                                                               7-34
          7.3.20    deleteRole                                                               7-35
          7.3.21    addGlobalRole                                                            7-37
          7.3.22    removeGlobalRole                                                         7-39
          7.3.23    grantRole                                                                7-42
          7.3.24    revokeRole                                                               7-44
          7.3.25    listEnterpriseRoles                                                      7-46
          7.3.26    listEnterpriseRolesOfUser                                                7-47
          7.3.27    listEnterpriseRoleInfo                                                   7-49
          7.3.28    listGlobalRolesInDB                                                      7-51
          7.3.29    listSharedSchemasInDB                                                    7-52
          7.3.30    createProxyPerm                                                          7-53
          7.3.31    deleteProxyPerm                                                          7-54
          7.3.32    addTargetUser                                                            7-56
          7.3.33    removeTargetUser                                                         7-58
          7.3.34    grantProxyPerm                                                           7-60




                                                                                              viii
          7.3.35    revokeProxyPerm                                                    7-62
          7.3.36    listProxyPermissions                                               7-63
          7.3.37    listProxyPermissionsOfUser                                         7-65
          7.3.38    listProxyPermissionInfo                                            7-66
          7.3.39    listTargetUsersInDB                                                7-68
          7.3.40    setDBOIDAuth                                                       7-69
          7.3.41    listDBOIDAuth                                                      7-70
          7.3.42    addToPwdAccessibleDomains                                          7-72
          7.3.43    removeFromPwdAccessibleDomains                                     7-73
          7.3.44    listPwdAccessibleDomains                                           7-75
          7.3.45    listRealmCommonAttr                                                7-76
          7.3.46    createAppCtxNamespace                                              7-77
          7.3.47    deleteAppCtxNamespace                                              7-79
          7.3.48    listAppCtxNamespaces                                               7-80
          7.3.49    createAppCtxAttribute                                              7-81
          7.3.50    deleteAppCtxAttribute                                              7-83
          7.3.51    listAppCtxAttributes                                               7-84
          7.3.52    createAppCtxAttributeValue                                         7-86
          7.3.53    deleteAppCtxAttributeValue                                         7-87
          7.3.54    listAppCtxAttributeValues                                          7-89
          7.3.55    createAppCtxUsers                                                  7-91
          7.3.56    deleteAppCtxUsers                                                  7-92
          7.3.57    listAppCtxUsers                                                    7-94



A   Using the User Migration Utility
    A.1     Benefits of Migrating Local or External Users to Enterprise Users          A-1
    A.2     Introduction to the User Migration Utility                                 A-2
          A.2.1    Bulk User Migration Process Overview                                A-2
             A.2.1.1     Step 0: About Using a Secure External Password Store          A-3
             A.2.1.2     Step 1: (Phase One) Preparing for the Migration               A-4
             A.2.1.3     Step 2: Verify User Information                               A-5
             A.2.1.4     Step 3: (Phase Two) Completing the Migration                  A-5
          A.2.2    About the ORCL_GLOBAL_USR_MIGRATION_DATA Table                      A-5
             A.2.2.1     Which Interface Table Column Values Can Be Modified Between
                         Phase One and Phase Two?                                      A-6
          A.2.3    Migration Effects on Users' Old Database Schemas                    A-7
          A.2.4    Migration Process                                                   A-8
    A.3     Prerequisites for Performing Migration                                     A-9
          A.3.1    Required Database Privileges                                        A-9
          A.3.2    Required Directory Privileges                                       A-9
          A.3.3    Required Setup to Run the User Migration Utility                    A-9



                                                                                         ix
A.4     User Migration Utility Command-Line Syntax                             A-10
A.5     Accessing Help for the User Migration Utility                          A-12
A.6     User Migration Utility Parameters                                      A-12
      A.6.1    Keyword: HELP                                                   A-12
      A.6.2    Keyword: PHASE                                                  A-13
      A.6.3    Keyword: DBLOCATION                                             A-13
      A.6.4    Keyword: DIRLOCATION                                            A-13
      A.6.5    Keyword: DBADMIN                                                A-14
      A.6.6    Keyword: ENTADMIN                                               A-14
      A.6.7    Keyword: USERS                                                  A-14
      A.6.8    Keyword: USERSLIST                                              A-15
      A.6.9    Keyword: USERSFILE                                              A-15
      A.6.10    Keyword: KREALM                                                A-15
      A.6.11    Keyword: MAPSCHEMA                                             A-16
      A.6.12    Keyword: MAPTYPE                                               A-16
      A.6.13    Keyword: CASCADE                                               A-17
      A.6.14    Keyword: CONTEXT                                               A-17
      A.6.15    Keyword: LOGFILE                                               A-18
      A.6.16    Keyword: PARFILE                                               A-18
      A.6.17    Keyword: DBALIAS                                               A-18
      A.6.18    Keyword: ENTALIAS                                              A-19
      A.6.19    Keyword: WALLETLOCATION                                        A-19
      A.6.20    Keyword: KEYALIAS                                              A-19
      A.6.21    Keyword: KEYSTORE                                              A-20
A.7     User Migration Utility Usage Examples                                  A-20
      A.7.1    Migrating Users While Retaining Their Own Schemas               A-20
      A.7.2    Migrating Users and Mapping to a Shared Schema                  A-21
         A.7.2.1    Mapping Users to a Shared Schema Using Different CASCADE
                    Options                                                    A-22
         A.7.2.2    Mapping Users to a Shared Schema Using Different MAPTYPE
                    Options                                                    A-24
      A.7.3    Migrating Users Using the PARFILE, USERSFILE, and LOGFILE
               Parameters                                                      A-26
A.8     Troubleshooting Using the User Migration Utility                       A-27
      A.8.1    Common User Migration Utility Error Messages                    A-27
         A.8.1.1    Resolving Error Messages Displayed for Both Phases         A-28
         A.8.1.2    Resolving Error Messages Displayed for Phase One           A-29
         A.8.1.3    Resolving Error Messages Displayed for Phase Two           A-32
      A.8.2    Common User Migration Utility Log Messages                      A-32
         A.8.2.1    Common Log Messages for Phase One                          A-32
         A.8.2.2    Common Log Messages for Phase Two                          A-33
      A.8.3    Summary of User Migration Utility Error and Log Messages        A-34




                                                                                 x
          A.8.4   Tracing for UMU                                                           A-35



B   SSL External Users Conversion Script
    B.1     Using the SSL External Users Conversion Script                                   B-2
    B.2     Converting Global Users into External Users                                      B-4



C   Integrating Enterprise User Security with Microsoft Active Directory
    C.1     About Direct Integration with Microsoft Active Directory                        C-1
    C.2     Set Up Synchronization Between Active Directory and Oracle Internet
            Directory                                                                       C-2
    C.3     Set Up Active Directory to Interoperate with Oracle Client                      C-2
    C.4     Set Up Oracle Database to Interoperate with Microsoft Active Directory          C-3
    C.5     Set Up Oracle Database Client to Interoperate with Microsoft Active Directory   C-3
    C.6     Obtain an Initial Ticket for the Client                                         C-3
    C.7     Configure Enterprise User Security for Kerberos Authentication                  C-4



D   Upgrading from Oracle9i to Oracle Database Release 18c Version
    18.1
    D.1     Upgrading Oracle Internet Directory from Release 9.2 to Release 9.0.4           D-1
    D.2     Upgrading Oracle Database from Release 9.2.0.8 to Oracle Database
            Release 18c Version 18.1                                                        D-2
    D.3     Upgrading Oracle Database from Release 10g (10.1) and Higher to Oracle
            Database Release 18c Version 18.1                                               D-2


    Glossary


    Index




                                                                                              xi
List of Examples
2-1    Creating a Shared Schema                                                        2-8
2-2    Mapping Enterprise Users to the Shared Schema                                   2-8
2-3    Connecting to the Database as an Enterprise User                                2-9
2-4    Using Enterprise Roles                                                         2-10
2-5    Using Proxy Permissions                                                        2-14
7-1    Creating a Domain in the Realm with SSL Port Conectivity to OID and Using
       Passwords Stored in the Oracle Wallet                                           7-8
7-2    Creating a Domain in the Realm with SSL Port Conectivity to OID                 7-8
7-3    Creating a Domain in the Realm with non-SSL Port Conectivity to OID             7-8
7-4    Deleting a Domain from the Realm with SSL Port Conectivity to OID and Using
       Passwords Stored in the Oracle Wallet                                          7-10
7-5    Deleting a Domain from the Realm with SSL Port Conectivity to OID              7-10
7-6    Deleting a Domain from the Realm with non-SSL Port Conectivity to OID          7-10
7-7    Lists the domains in the realm with SSL Port Conectivity to OID and Using
       Passwords Stored in the Oracle Wallet                                          7-11
7-8    Lists the domains in the realm with SSL Port Conectivity to OID                7-11
7-9    Lists the domains in the realm with non-SSL Port Conectivity to OID            7-11
7-10   Listing the Domain Information with SSL Port Conectivity to OID and Using
       Passwords Stored in the Oracle Wallet                                          7-12
7-11   Listing the Domain Information with SSL Port Conectivity to OID                7-12
7-12   Listing the Domain Information with non-SSL Port Conectivity to OID            7-13
7-13   Adding a Domain Administrator with SSL Port Conectivity to OID and Using
       Passwords Stored in the Oracle Wallet                                          7-14
7-14   Adding a Domain Administrator with SSL Port Conectivity to OID                 7-14
7-15   Adding a Domain Administrator with non-SSL Port Conectivity to OID             7-14
7-16   Removing a Domain Administrator with SSL Port Conectivity to OID and Using
       Passwords Stored in the Oracle Wallet                                          7-15
7-17   Removing a Domain Administrator with SSL Port Conectivity to OID               7-15
7-18   Removing a Domain Administrator with non-SSL Port Conectivity to OID           7-16
7-19   Listing the Domain Administrators with SSL Port Conectivity to OID and Using
       Passwords Stored in the Oracle Wallet                                          7-17
7-20   Listing the Domain Administrators with SSL Port Conectivity to OID             7-17
7-21   Listing the Domain Administrators with non-SSL Port Conectivity to OID         7-17
7-22   Adding a Database to the Domain with SSL Port Conectivity to OID and Using
       Passwords Stored in the Oracle Wallet                                          7-18




                                                                                       xii
7-23   Adding a Database to the Domain with SSL Port Conectivity to OID                  7-18
7-24   Adding a Database to the Domain with non-SSL Port Conectivity to OID              7-18
7-25   Removing a Database from the Domain with SSL Port Conectivity to OID and Using
       Passwords Stored in the Oracle Wallet                                             7-20
7-26   Removing a Database from the Domain with SSL Port Conectivity to OID              7-20
7-27   Removing a Database from the Domain with non-SSL Port Conectivity to OID          7-20
7-28   Adding a Database Administrator with SSL Port Conectivity to OID and Using
       Passwords Stored in the Oracle Wallet                                             7-21
7-29   Adding a Database Administrator with SSL Port Conectivity to OID                  7-21
7-30   Adding a Database Administrator with non-SSL Port Conectivity to OID              7-21
7-31   Listing the Database Administrators with SSL Port Conectivity to OID and Using
       Passwords Stored in the Oracle Wallet                                             7-23
7-32   Listing the Database Administrators with SSL Port Conectivity to OID              7-23
7-33   Listing the Database Administrators with non-SSL Port Conectivity to OID          7-23
7-34   Lists the Database Information with SSL Port Conectivity to OID and Using
       Passwords Stored in the Oracle Wallet                                             7-24
7-35   Lists the Database Information with SSL Port Conectivity to OID                   7-24
7-36   Lists the Database Information with non-SSL Port Conectivity to OID               7-24
7-37   Removing a Database Administrator with SSL Port Conectivity to OID and Using
       Passwords Stored in the Oracle Wallet                                             7-25
7-38   Removing a Database Administrator with SSL Port Conectivity to OID                7-26
7-39   Removing a Database Administrator with non-SSL Port Conectivity to OID            7-26
7-40   Creating the User or Shared Schema Mapping with SSL Port Conectivity to OID and
       Using Passwords Stored in the Oracle Wallet                                       7-27
7-41   Creating the User or Shared Schema Mapping with SSL Port Conectivity to OID       7-27
7-42   Creating the User or Shared Schema Mapping with non-SSL Port Conectivity to OID   7-27
7-43   Deleting the User or Shared Schema Mapping with SSL Port Conectivity to OID and
       Using Passwords Stored in the Oracle Wallet                                       7-29
7-44   Deleting the User or Shared Schema Mapping with SSL Port Conectivity to OID       7-29
7-45   Deleting the User or Shared Schema Mapping with non-SSL Port Conectivity to OID   7-29
7-46   Listing the User or Shared Schema Mappings with SSL Port Conectivity to OID and
       Using Passwords Stored in the Oracle Wallet                                       7-30
7-47   Listing the User or Shared Schema Mappings with SSL Port Conectivity to OID       7-30
7-48   Listing the User or Shared Schema Mappings with non-SSL Port Conectivity to OID   7-30
7-49   Enabling the Current User Database-link Usage in the Domain with SSL Port
       Conectivity to OID and Using Passwords Stored in the Oracle Wallet                7-32




                                                                                          xiii
7-50   Enabling the Current User Database-link Usage in the Domain with SSL Port
       Conectivity to OID                                                                    7-32
7-51   Enabling the Current User Database-link Usage in the Domain with non-SSL Port
       Conectivity to OID                                                                    7-32
7-52   Setting the Authentication Types Accepted for the Users in the Domain with SSL Port
       Conectivity to OID and Using Passwords Stored in the Oracle Wallet                    7-33
7-53   Setting the Authentication Types Accepted for the Users in the Domain with SSL Port
       Conectivity to OID                                                                    7-33
7-54   Setting the Authentication Types Accepted for the Users in the Domain with non-SSL
       Port Conectivity to OID                                                               7-33
7-55   Creating a Role with SSL Port Conectivity to OID and Using Passwords Stored in the
       Oracle Wallet                                                                         7-35
7-56   Creating a Role with SSL Port Conectivity to OID                                      7-35
7-57   Creating a Role with non-SSL Port Conectivity to OID                                  7-35
7-58   Deleting a Role with SSL Port Conectivity to OID and Using Passwords Stored in the
       Oracle Wallet                                                                         7-36
7-59   Deleting a Role with SSL Port Conectivity to OID                                      7-37
7-60   Deleting a Role with non-SSL Port Conectivity to OID                                  7-37
7-61   Adding a Global Role with SSL Port Conectivity to OID and Using Passwords Stored
       in the Oracle Wallet                                                                  7-38
7-62   Adding an Administrative Role with SSL Port Conectivity to OID and Using
       Passwords Stored in the Oracle Wallet                                                 7-39
7-63   Adding a Global Role with SSL Port Conectivity to OID                                 7-39
7-64   Adding an Administrative Role with SSL Port Conectivity to OID                        7-39
7-65   Adding a Global Role with non-SSL Port Conectivity to OID                             7-39
7-66   Adding an Administrative Role with non-SSL Port Conectivity to OID                    7-39
7-67   Removing a Global Role with SSL Port Conectivity to OID and Using Passwords
       Stored in the Oracle Wallet                                                           7-41
7-68   Removing an Administrative Role with SSL Port Conectivity to OID and Using
       Passwords Stored in the Oracle Wallet                                                 7-41
7-69   Removing a Global Role with SSL Port Conectivity to OID                               7-41
7-70   Removing an Administrative Role with SSL Port Conectivity to OID                      7-42
7-71   Removing a Global Role with non-SSL Port Conectivity to OID                           7-42
7-72   Removing an Administrative Role with non-SSL Port Conectivity to OID                  7-42
7-73   Granting a Role to a User with SSL Port Conectivity to OID and Using Passwords
       Stored in the Oracle Wallet                                                           7-43
7-74   Granting a Role to a User with SSL Port Conectivity to OID                            7-44



                                                                                              xiv
7-75    Granting a Role to a User with non-SSL Port Conectivity to OID                      7-44
7-76    Revoking a Role from a User with SSL Port Conectivity to OID and Using Passwords
        Stored in the Oracle Wallet                                                         7-45
7-77    Revoking a Role from a User with SSL Port Conectivity to OID                        7-45
7-78    Revoking a Role from a User with non-SSL Port Conectivity to OID                    7-46
7-79    List the Enterprisre Roles with SSL Port Conectivity to OID and Use Passwords
        Stored in the Oracle Wallet                                                         7-47
7-80    List the Enterprisre Roles with SSL Port Conectivity to OID                         7-47
7-81    List the Enterprisre Roles with non-SSL Port Conectivity to OID                     7-47
7-82    List the Enterprise Roles of a User with SSL Port Conectivity to OID and Use
        Passwords Stored in the Oracle Wallet                                               7-48
7-83    List the Enterprise Roles of a User with SSL Port Conectivity to OID                7-49
7-84    List the Enterprise Roles of a User with non-SSL Port Conectivity to OID            7-49
7-85    List the Enterprise Role Information with SSL Port Conectivity to OID and Use
        Passwords Stored in the Oracle Wallet                                               7-50
7-86    List the Enterprise Role Information with SSL Port Conectivity to OID               7-50
7-87    List the Enterprise Role Information with non-SSL Port Conectivity to OID           7-51
7-88    Listing the Global Roles in the Database and Using Passwords Stored in the Oracle
        Wallet                                                                              7-52
7-89    Listing the Global Roles in the Database                                            7-52
7-90    List the Shared Schemas in the Database and Use Passwords Stored in the Oracle
        Wallet                                                                              7-52
7-91    List the Shared Schemas in the Database                                             7-53
7-92    Create the Proxy Permission Object PROXY01 with SSL Port Conectivity to OID and
        Use Passwords Stored in the Oracle Wallet                                           7-54
7-93    Create the Proxy Permission Object PROXY01 with SSL Port Conectivity to OID         7-54
7-94    Create the Proxy Permission Object PROXY01 with non-SSL Port Conectivity to OID     7-54
7-95    Deleting the Proxy Permission PROXY01 with SSL Port Conectivity to OID and Using
        Passwords Stored in the Oracle Wallet                                               7-55
7-96    Deleting the Proxy Permission PROXY01 with SSL Port Conectivity to OID              7-56
7-97    Deleting the Proxy Permission PROXY01 with non-SSL Port Conectivity to OID          7-56
7-98    Add the Target Database User to the Proxy Permission Object with SSL Port
        Conectivity to OID and Using Passwords Stored in the Oracle Wallet                  7-57
7-99    Add the Target Database User to the Proxy Permission Object with SSL Port
        Conectivity to OID                                                                  7-57
7-100   Add the Target Database User to the Proxy Permission Object with non-SSL Port
        Conectivity to OID                                                                  7-58



                                                                                             xv
7-101   Removing the Target User from the Proxy Permission Object with SSL Port
        Conectivity to OID and Using Passwords Stored in the Oracle Wallet                  7-59
7-102   Removing the Target User from the Proxy Permission Object with SSL Port
        Conectivity to OID                                                                  7-59
7-103   Removing the Target User from the Proxy Permission Object with non-SSL Port
        Conectivity to OID                                                                  7-60
7-104   Mapping the Enterprise User to the Database User Through the PROXY01
        Permission Object with SSL Port Conectivity to OID and Using Passwords Stored in
        the Oracle Wallet                                                                   7-61
7-105   Mapping the Enterprise User to the Database User Through the PROXY01
        Permission Object with SSL Port Conectivity to OID                                  7-61
7-106   Mapping the Enterprise User to the Database User Through the PROXY01
        Permission Object with non-SSL Port Conectivity to OID                              7-61
7-107   Revoking Proxy Permission Object PROXY01 From the User with SSL Port
        Conectivity to OID and Using Passwords Stored in the Oracle Wallet                  7-63
7-108   Revoking Proxy Permission Object PROXY01 From the User with SSL Port
        Conectivity to OID                                                                  7-63
7-109   Revoking Proxy Permission Object PROXY01 From the User with non-SSL Port
        Conectivity to OID                                                                  7-63
7-110   Listing the Proxy Permissions for the Domain with SSL Port Conectivity to OID and
        Using Passwords Stored in the Oracle Wallet                                         7-64
7-111   Listing the Proxy Permissions for the Domain with SSL Port Conectivity to OID       7-65
7-112   Listing the Proxy Permissions for the Domain with non-SSL Port Conectivity to OID   7-65
7-113   List the Proxy Permission for the User with SSL Port Conectivity to OID and Use
        Passwords Stored in the Oracle Wallet                                               7-66
7-114   List the Proxy Permission for the User with SSL Port Conectivity to OID             7-66
7-115   List the Proxy Permission for the User with non-SSL Port Conectivity to OID         7-66
7-116   List Proxy Permission Information with SSL Port Conectivity to OID and Using
        Passwords Stored in the Oracle Wallet                                               7-67
7-117   List Proxy Permission Information with SSL Port Conectivity to OID                  7-68
7-118   List Proxy Permission Information with non-SSL Port Conectivity to OID              7-68
7-119   Listing the Target Users in the Database and Using Passwords Stored in the Oracle
        Wallet                                                                              7-69
7-120   Listing the Target Users in the Database                                            7-69
7-121   Setting the Database-OID Authentication Method with SSL Port Conectivity to OID
        and Using Passwords Stored in the Oracle Wallet                                     7-70
7-122   Setting the Database-OID Authentication Method with SSL Port Conectivity to OID     7-70



                                                                                             xvi
7-123   Setting the Database-OID Authentication Method with non-SSL Port Conectivity to OID   7-70
7-124   Listing the Database-OID Authentication Method with SSL Port Conectivity to OID
        and Using Passwords Stored in the Oracle Wallet                                       7-71
7-125   Listing the Database-OID Authentication Method with SSL Port Conectivity to OID       7-71
7-126   Listing the Database-OID Authentication Method with non-SSL Port Conectivity to OID   7-72
7-127   Adding to Password Accessible Domains with SSL Port Conectivity to OID and Using
        Passwords Stored in the Oracle Wallet                                                 7-73
7-128   Adding to Password Accessible Domains with SSL Port Conectivity to OID                7-73
7-129   Adding to Password Accessible Domains with non-SSL Port Conectivity to OID            7-73
7-130   Removing from Password Accessible Domains with SSL Port Conectivity to OID and
        Using Passwords Stored in the Oracle Wallet                                           7-74
7-131   Removing from Password Accessible Domains with SSL Port Conectivity to OID            7-74
7-132   Removing from Password Accessible Domains with non-SSL Port Conectivity to OID        7-74
7-133   Listing the Password Accessible Domains with SSL Port Conectivity to OID and
        Using Passwords Stored in the Oracle Wallet                                           7-75
7-134   Listing the Password Accessible Domains with SSL Port Conectivity to OID              7-76
7-135   Listing the Password Accessible Domains with non-SSL Port Conectivity to OID          7-76
7-136   Listing the Realm Common Attributes with SSL Port Conectivity to OID and Using
        Passwords Stored in the Oracle Wallet                                                 7-77
7-137   Listing the Realm Common Attributes with SSL Port Conectivity to OID                  7-77
7-138   Listing the Realm Common Attributes with non-SSL Port Conectivity to OID              7-77
7-139   Adding a New Domain Namespace with SSL Port Conectivity to OID and Using
        Passwords Stored in the Oracle Wallet                                                 7-78
7-140   Adding a New Domain Namespace with SSL Port Conectivity to OID                        7-78
7-141   Adding a New Domain Namespace with non-SSL Port Conectivity to OID                    7-79
7-142   Deleting a Domain Namespace with SSL Port Conectivity to OID and Using
        Passwords Stored in the Oracle Wallet                                                 7-80
7-143   Deleting a Domain Namespace with SSL Port Conectivity to OID                          7-80
7-144   Deleting a Domain Namespace with non-SSL Port Conectivity to OID                      7-80
7-145   Listing the Namespaces with SSL Port Conectivity to OID and Using Passwords
        Stored in the Oracle Wallet                                                           7-81
7-146   Listing the Namespaces with SSL Port Conectivity to OID                               7-81
7-147   Listing the Namespaces with non-SSL Port Conectivity to OID                           7-81
7-148   Adding a New Attribute with SSL Port Conectivity to OID and Using Passwords
        Stored in the Oracle Wallet                                                           7-83
7-149   Adding a New Attribute with SSL Port Conectivity to OID                               7-83
7-150   Adding a New Attribute with non-SSL Port Conectivity to OID                           7-83



                                                                                              xvii
7-151   Deleting Attributes with SSL Port Conectivity to OID and Using Passwords Stored in
        the Oracle Wallet                                                                     7-84
7-152   Deleting Attributes with SSL Port Conectivity to OID                                  7-84
7-153   Deleting Attributes with non-SSL Port Conectivity to OID                              7-84
7-154   Listing Attributes with SSL Port Conectivity to OID and Using Passwords Stored in
        the Oracle Wallet                                                                     7-85
7-155   Listing Attributes with SSL Port Conectivity to OID                                   7-86
7-156   Example Title with non-SSL Port Conectivity to OID                                    7-86
7-157   Adding a New Attribute Value with SSL Port Conectivity to OID and Using Passwords
        Stored in the Oracle Wallet                                                           7-87
7-158   Adding a New Attribute Value with SSL Port Conectivity to OID                         7-87
7-159   Adding a New Attribute Value with non-SSL Port Conectivity to OID                     7-87
7-160   Deleting an Attribute Value with SSL Port Conectivity to OID and Using Passwords
        Stored in the Oracle Wallet                                                           7-89
7-161   Deleting an Attribute Value with SSL Port Conectivity to OID                          7-89
7-162   Deleting an Attribute Value with non-SSL Port Conectivity to OID                      7-89
7-163   Listing the Attribute Values with SSL Port Conectivity to OID and Using Passwords
        Stored in the Oracle Wallet                                                           7-90
7-164   Listing the Attribute Values with SSL Port Conectivity to OID                         7-90
7-165   Listing the Attribute Values with non-SSL Port Conectivity to OID                     7-90
7-166   Adding a New User for an Attribute Value with SSL Port Conectivity to OID and Using
        Passwords Stored in the Oracle Wallet                                                 7-92
7-167   Adding a New User for an Attribute Value with SSL Port Conectivity to OID             7-92
7-168   Adding a New User for an Attribute Value with non-SSL Port Conectivity to OID         7-92
7-169   Deleting a User from an Attribute Value with SSL Port Conectivity to OID and Using
        Passwords Stored in the Oracle Wallet                                                 7-93
7-170   Deleting a User from an Attribute Value with SSL Port Conectivity to OID              7-94
7-171   Deleting a User from an Attribute Value with non-SSL Port Conectivity to OID          7-94
7-172   Listing All Users for an Attribute Value with SSL Port Conectivity to OID and Using
        Passwords Stored in the Oracle Wallet                                                 7-95
7-173   Listing All Users for an Attribute Value with SSL Port Conectivity to OID             7-95
7-174   Listing All Users for an Attribute Value with non-SSL Port Conectivity to OID         7-95
A-1     User Migration Utility Command-Line Syntax                                            A-11
A-2     Migrating Users with MAPSCHEMA=PRIVATE (Default)                                      A-21
A-3     Migrating Users with MAPSCHEMA=SHARED                                                 A-21
A-4     Migrating Users with Shared Schema Mapping and CASCADE=YES                            A-23
A-5     Migrating Users with Shared Schema Mapping Using the MAPTYPE Parameter                A-24



                                                                                              xviii
A-6   Parameter Text File (par.txt) to Use with the PARFILE Parameter        A-26
A-7   Users List Text File (usrs.txt) to Use with the USERSFILE Parameter    A-27
A-8   Migrating Users Using the PARFILE, USERSFILE, and LOGFILE Parameters   A-27




                                                                              xix
List of Figures
1-1   Enterprise User Security and the Oracle Security Architecture    1-3
1-2   Example of Enterprise Roles                                     1-12
1-3   Related Entries in a Realm Oracle Context                       1-15
3-1   Opening Page of Oracle Net Configuration Assistant               3-3
4-1   Enterprise User Security Configuration Flow Chart                4-3




                                                                       xx
List of Tables
1-1   Enterprise User Security Authentication: Selection Criteria                             1-8
1-2   Administrative Groups in a Realm Oracle Context                                        1-16
1-3   Enterprise User Security: Supported Authentication Types for Connections between
      Clients, Databases, and Directories                                                    1-28
3-1   Enterprise User Security Tasks and Tools Summary                                        3-1
3-2   Summary of orapki Commands                                                              3-5
3-3   Common Enterprise User Security Administrator Configuration and Administrative Tasks    3-7
4-1   Identity Realm Defaults                                                                 4-5
4-2   Oracle Internet Directory Matching Rules                                               4-23
5-1   Identity Management Realm Properties                                                    5-2
5-2   Enterprise User Security Identity Management Realm Administrators                       5-4
6-1   KeyUsage Values                                                                         6-5
6-2   Oracle Wallet Manager Import of User Certificates to an Oracle Wallet                   6-5
6-3   Oracle Wallet Manager Import of Trusted Certificates to an Oracle Wallet                6-6
6-4   PKI Wallet Encoding Standards                                                          6-13
6-5   Types of Certificates                                                                  6-20
6-6   Certificate Request: Fields and Descriptions                                           6-22
6-7   Available Key Sizes                                                                    6-23
A-1   ORCL_GLOBAL_USR_MIGRATION_DATA Table Schema                                             A-6
A-2   Interface Table Column Values That Can Be Modified Between Phase One and
      Phase Two                                                                               A-7
A-3   Effects of Choosing Shared Schema Mapping with CASCADE Options                          A-8
A-4   Alphabetical Listing of User Migration Utility Error Messages                          A-34
A-5   Alphabetical Listing of User Migration Utility Log Messages                            A-35




                                                                                              xxi
                                                                                          Preface




Preface
         Welcome to the Oracle Database Enterprise User Security Administrator's Guide for
         Oracle Database release 18c, version 18.1.
         Oracle Database contains a comprehensive suite of security features that protect your
         data. These features include database privileges, roles, and integration with the Oracle
         Identity Management infrastructure for identity management services. Identity
         management refers to the process by which the complete security lifecycle—account
         creation, suspension, modification, and deletion—for network entities is managed by
         an organization.
         The Oracle Database Enterprise User Security Administrator's Guide describes how to
         implement, configure, and administer Oracle Database users in Oracle Internet
         Directory, a directory service provided by the Oracle Identity Management platform.
         This preface contains these topics:
         •   Intended Audience
         •   Documentation Accessibility
         •   Related Documents
         •   Conventions


Intended Audience
         The Oracle Database Enterprise User Security Administrator's Guide is intended for
         security administrators, DBAs, and application developers who perform one or more of
         the following tasks:
         •   Manage database users and privileges
         •   Provision database users
         •   Develop PL/SQL applications for enterprise users
         To use this document, you need a working knowledge of SQL and Oracle
         fundamentals. You should also be familiar with Oracle security features described in
         "Related Documents".


Documentation Accessibility
         For information about Oracle's commitment to accessibility, visit the Oracle
         Accessibility Program website at http://www.oracle.com/pls/topic/lookup?
         ctx=acc&id=docacc.




                                                                                             xxii
                                                                                        Preface




        Access to Oracle Support
        Oracle customers that have purchased support have access to electronic support
        through My Oracle Support. For information, visit http://www.oracle.com/pls/topic/
        lookup?ctx=acc&id=info or visit http://www.oracle.com/pls/topic/lookup?ctx=acc&id=trs
        if you are hearing impaired.


Related Documents
        For more information, see these Oracle resources:
        •   Oracle Fusion Middleware Administrator's Guide for Oracle Internet Directory
        •   Oracle Fusion Middleware Reference for Oracle Identity Management
        •   Oracle Database Advanced Security Guide
        •   Oracle Database 2 Day DBA
        •   Oracle Database Administrator’s Guide
        •   Oracle Database Security Guide
        •   Oracle Database Development Guide
        •   Oracle Database SQL Language Reference
        •   SQL*Plus Quick Reference
        •   Oracle Database Error Messages Reference
        •   Oracle Database Reference
        •   Oracle Database Heterogeneous Connectivity User's Guide
        •   Oracle Database Net Services Administrator's Guide
        Many of the examples in this book use the sample schemas, which are installed by
        default when you select the Basic Installation option with an Oracle Database
        installation. Refer to Oracle Database Sample Schemas for information on how these
        schemas were created and how you can use them yourself.
        To download free release notes, installation documentation, white papers, or other
        collateral, please visit the Oracle Technology Network (OTN). You must register online
        before using OTN; registration is free and can be done at
        Community - Get Started

        If you already have a user name and password for OTN, then you can go directly to
        the documentation section of the OTN Web site at
        Oracle Documentation

        For conceptual information about the security technologies supported by Enterprise
        User Security, you can refer to the following third-party publications:
        •   Oracle Database 12c Security by Scott Gaetjen, David Knox, and William
            Maroulis. McGraw-Hill Education (Publisher), 2015.
        •   Oracle Database 12c Security Cookbook by Zorin Pavlovic and Maja Veselica.
            Birmingham, UK. Packet Publishing Ltd., 2016.




                                                                                           xxiii
                                                                                                  Preface


        •     Applied Oracle Security: Developing Secure Database and Middleware
              Environments by David Knox, Scott Gaetjen, Hamza Jahangir, Tyler Muth, Patrick
              Sack, Richard Wark, and Byran Wise. McGraw-Hill Companies Inc., 2010.


Conventions
        The following text conventions are used in this document:


         Convention           Meaning
         boldface             Boldface type indicates graphical user interface elements associated
                              with an action, or terms defined in text or the glossary.
         italic               Italic type indicates book titles, emphasis, or placeholder variables for
                              which you supply particular values.
         monospace            Monospace type indicates commands within a paragraph, URLs, code
                              in examples, text that appears on the screen, or text that you enter.




                                                                                                     xxiv
Changes in This Release for Oracle
Database Enterprise User Security
Administrator's Guide
          This preface contains:
          •    Changes in this Release for Release 19c Version 19.1
          •    Changes in Oracle Database Release 18c Version 18.1
          •    Changes in Oracle Database 12c Release 2 (12.2.0.1)


Changes in this Release for Release 19c Version 19.1
          The following are changes in Oracle Database Enterprise User Security
          Administrator's Guide for Oracle Database release 19c, version 19.1.


New Features
          The following features are new in this release:
          •    Enterprise Security Administrators can configure a client-side wallet also known as
               an external secure password store to store user name credentials when using
               standalone utilities.
               Doing this simplifies deployments that rely on password credentials for connecting
               to databases as scripts will then no longer need to embed user names and
               passwords. This also reduces risk because the passwords are no longer exposed,
               and password policies are more easily managed without changing application
               code or scripts whenever user names or passwords change.
               The client-side wallet can be used with the following standalone utilities:
               –   Enterprise User Security Manager (EUSM)
                   See About Using a Secure External Password Store for more information
                   about configuring the dbuser, keystore, and ldap_user credentials in the
                   wallet and using the db_alias, keystore_alias, ldap_alias, and
                   wallet_location parameters on the command-line.
               –   User Migration Utility
                   See Step 0: About Using a Secure External Password Store for more
                   information about configuring the DBADMIN and ENTADMIN credentials in the
                   wallet and using the DBALIAS, ENTALIAS, and WALLETLOCATION parameters on
                   the command-line.
               –   External Users Conversion Script




                                                                                              xxv
                     Changes in This Release for Oracle Database Enterprise User Security Administrator's Guide


                   See SSL External Users Conversion Script for more information about
                   configuring the dbuser credential in the wallet and using the -dbalias and -
                   wallet_location parameters on the command-line.


Changes in Oracle Database Release 18c Version 18.1
          The following are changes in Oracle Database Enterprise User Security
          Administrator's Guide for Oracle Database release 18c, version 18.1.


New Features
          The following features are new in this release:
          •    Oracle Database Enterprise User Security release 18c, version 18.1 includes the
               following new features:
               –   Enterprise User Security Manager (EUSM)
                   The eusm command-line tool can be used to manage the Enterprise User
                   Security (EUS) Configuration in Oracle Internet Directory (OID) directory
                   server.
                   See Enterprise User Security Manager (EUSM) Command Reference for more
                   information about this feature.
               –   Centrally Managed Users for Microsoft Active Directory.
                   This integration is the preferred option from a complexity, cost, maintenance,
                   and development perspective for new projects that do not require some of the
                   more complex Enterprise User Security features like trusted database links.
                   See Configuring Authentication and Configuring Authorization in Oracle
                   Database Security Guide for more information about using centrally managed
                   users to directly authenticate and authorize users with Microsoft Active
                   Directory.
                   See Integrating Enterprise User Security with Microsoft Active Directory for
                   other options to authenticate and authorize users with Microsoft Active
                   Directory.
               –   Support is added for Enterprise User Security authentication with 12C verifier
                   generated from Oracle Internet Directory
                   The 12C verifier generated from Oracle Internet Directory uses a new ZT tag,
                   MR-SHA512, for multi-round Password-Based Key Derivation Function
                   (PBKDF2) based keyed-hash message authentication code (HMAC) with
                   SHA512 cryptographic hash functions to provide a strong password verifier.
                   This support is added in OID bundle patch 11.1.1.9.0.
                   See Oracle® Fusion Middleware Administrator's Guide for Oracle Internet
                   Directory for more information.
               –   For pluggable databases, you are no longer restricted to the default wallet
                   location. The WALLET_LOCATION can point to a directory location of your choice.
                   See Wallet Location for Pluggable Databases for more information.
               –   A new initialization parameter, WALLET_ROOT, is introduced to specify the path
                   to a directory containing the wallet location.




                                                                                                         xxvi
                     Changes in This Release for Oracle Database Enterprise User Security Administrator's Guide


                   See Wallet Root for Pluggable Databases for more information.


Changes in Oracle Database 12c Release 2 (12.2.0.1)
          The following are changes in Oracle Database Enterprise User Security
          Administrator's Guide for Oracle Database 12c Release 2 (12.2.0.1).


New Features
          The following features are new in this release:
          •    Enterprise User Security 12c release 2 (12.2.0.1) includes the following new
               features:
               –   The okcreate command-line utility to automate creation of the service
                   principal keytab when deploying Enterprise User Security using Kerberos
                   authentication.
                   See Set Up Active Directory to Interoperate with Oracle Client for more
                   information about this feature.




                                                                                                         xxvii
1
Introducing Enterprise User Security
          Enterprise User Security is an important component of Oracle Database 12c Release
          1 (12.1) Enterprise Edition. It enables you to address administrative and security
          challenges for a large number of enterprise database users. Enterprise users are
          those users that are defined in a directory. Their identity remains constant throughout
          the enterprise. Enterprise User Security relies on Oracle Identity Management
          infrastructure, which in turn uses an LDAP-compliant directory service to centrally
          store and manage users.
          This chapter explains what Enterprise User Security is and how it works, in the
          following topics:
          •   Introduction to Enterprise User Security
          •   About Using Shared Schemas for Enterprise User Security
          •   Enterprise User Proxy
          •   About Using Current User Database Links for Enterprise User Security
          •   Enterprise User Security Deployment Considerations


1.1 Introduction to Enterprise User Security
          This overview of Enterprise User Security explains how it benefits an organization and
          how enterprise users authenticate and access resources across a distributed database
          system. It contains the following topics:
          •   The Challenges of User Management
          •   Enterprise User Security: The Big Picture
          •   About Enterprise User Security Directory Entries


1.1.1 The Challenges of User Management
          Administrators must keep user information up-to-date and secure for the entire
          enterprise. This task becomes more difficult as the number of applications and users
          increases. Typically, each user has multiple accounts on different databases, which
          means that each user must remember multiple passwords. The result is too many
          passwords for users to remember and too many accounts for administrators to
          effectively manage.
          With thousands of users accessing database accounts, user administration requires
          substantial resources. Common information used by multiple applications, such as
          usernames, telephone numbers, and system roles and privileges, is typically
          fragmented across the enterprise. Such data increasingly becomes redundant,
          inconsistent, and difficult to manage.
          In addition to user and account management problems, these conditions produce
          security problems as well. For example, any time a user leaves a company or changes
          jobs, that user's privileges should be changed the same day in order to guard against




                                                                                               1-1
                                                                                                Chapter 1
                                                                  Introduction to Enterprise User Security


           their misuse. However, large enterprises often have many user accounts distributed
           over multiple databases, and an administrator may be unable to make such timely
           changes.
           Similarly, if your users have too many passwords, they may write them down, making
           them easy for others to copy. They may choose passwords that are easy to
           remember, making them easy for others to guess, and use the same password for
           multiple applications, risking wider consequences from a compromised password. All
           such user efforts to track multiple passwords can compromise enterprise security.


1.1.2 Enterprise User Security: The Big Picture
           Enterprise User Security addresses user, administrative, and security challenges by
           relying on the identity management services supplied by Oracle Internet Directory, an
           LDAP-compliant directory service. Identity management is the process by which the
           complete security life cycle for network entities is managed in an organization. It
           typically refers to the management of an organization's application users, where steps
           in the security life cycle include account creation, suspension, privilege modification,
           and account deletion.
           Figure 1-1 shows how Enterprise User Security fits into the Oracle security
           architecture, which uses the Oracle Identity Management infrastructure as its
           foundation.




                                                                                                     1-2
                                                                                                                     Chapter 1
                                                                                       Introduction to Enterprise User Security


Figure 1-1        Enterprise User Security and the Oracle Security Architecture


   ·Authorization         ·Responsibilities     ·S-MIME                 ·Roles
   ·Auditing              ·Roles                ·Interpersonal          ·Privilege
                                                 Rights                  Groups
                                                ·File Privileges

   Third-Party            Oracle                Oracle                  OracleAS Portal
   Applications           E-Business            Collaboration           OracleAS Wireless
                          Suite                 Suite


                                                                       Application Security

                                                                              Oracle Platform
                                                                                     Security


                                                ·JAAS Roles             ·Enterprise User
                                                ·Web Services            Security
                                                 Security               ·VPD
                                                ·Java 2                 ·Encryption
                                                 Permissions            ·Label Security

                                                Oracle                  Oracle
                                                Application             Database
                                                Server




 External Security              Oracle Identity Management
 Services                       Infrastructure

   Access                        OracleAS      Oracle              OracleAS      Oracle
   Management                    Certificate   Delegated           Single        Directory
                                 Authority     Administration      Sign-On       Integration
                                               Services                          Service
   Directory
   Services


   Provisioning
   Services                                     Oracle Internet Directory




                     Users benefit from Enterprise User Security through single sign-on (SSO) or single
                     password authentication, depending on the configuration chosen by the administrator.
                     Using single sign-on, users need to authenticate only once and subsequent
                     authentications take place transparently. This functionality requires SSL, which should
                     not be confused with OracleAS Single Sign-On, a component of Oracle Identity
                     Management infrastructure.
                     Single password authentication lets users authenticate to multiple databases with a
                     single global password although each connection requires a unique authentication.
                     The password is securely stored in the centrally located, LDAP-compliant directory,
                     and protected with security mechanisms including encryption and \. This approach
                     improves usability by reducing the number of passwords to remember and manage,
                     and by eliminating the overhead of setting up SSL.
                     Enterprise User Security requires Oracle Internet Directory 10g (9.0.4) or higher. Other
                     LDAP-compliant directory services are supported by using Oracle Internet Directory
                     Integration Platform to synchronize them with Oracle Internet Directory. Another
                     directory services product, Oracle Virtual Directory, provides a single, dynamic access
                     point to multiple data sources through LDAP or XML protocols. Oracle Virtual Directory



                                                                                                                          1-3
                                                                                                    Chapter 1
                                                                      Introduction to Enterprise User Security


              can provide multiple application-specific views of identity data stored in, for example,
              Oracle Internet Directory, Microsoft Active Directory and Sun Java Systems Directory
              instances, and can also be used to secure data access to the application-specific
              sources and enhance high-availability to existing data-sources.



                     See Also:
                     Oracle Fusion Middleware Administrator's Guide for Oracle Internet
                     Directory, for information about using Oracle Directory Integration Platform
                     and Oracle Virtual Directory with other directories.




                     Note:
                     Microsoft Active Directory is supported only for Oracle databases on
                     Windows platforms.



              This section contains the following topics:
              •   How Oracle Internet Directory Implements Identity Management
              •   Enterprise Users Compared to Database Users
              •   About Enterprise User Schemas
              •   How Enterprise Users Access Database Resources with Database Links
              •   How Enterprise Users Are Authenticated

1.1.2.1 How Oracle Internet Directory Implements Identity Management
              Oracle Internet Directory uses the concept of identity management realms to organize
              information in the directory information tree (DIT), which is a hierarchical tree-like
              structure consisting of directory object entries. In a directory, each collection of
              information about an object is called an entry. This object may be a person, but it can
              also be information about a networked device, such as configuration information. To
              name and identify the location of directory objects in the DIT, each entry is assigned a
              unique distinguished name (DN). The DN of an entry consists of the entry itself and its
              parent entries, connected in ascending order, from the entry itself up to the root (top)
              entry in the DIT.
              This section contains the following topics:
              •   About Identity Management Realms
              •   About Identity Management Realm-Specific Oracle Contexts

1.1.2.1.1 About Identity Management Realms
              An identity management realm is a subtree of directory entries, all of which are
              governed by the same administrative policies. For example, all employees in an
              enterprise who have access to the intranet may belong to one realm, while all external
              users who access the public applications of the enterprise may belong to another
              realm. Use of different realms enables an enterprise to isolate user populations and




                                                                                                         1-4
                                                                                                     Chapter 1
                                                                       Introduction to Enterprise User Security


              enforce different administrative policies, such as password policies or naming policies,
              in each realm. The default nickname attribute, used to identify the login identity, is uid,
              and it is set in each identity management realm

1.1.2.1.2 About Identity Management Realm-Specific Oracle Contexts
              Each identity management realm has a realm-specific Oracle Context (realm Oracle
              Context) that stores Oracle product information for that realm. A realm Oracle Context
              stores application data, how users are named and located, how users must be
              authenticated, group locations, and privilege assignments, all specific to the particular
              identity management realm in which the realm Oracle Context is located.



                     See Also:

                     •   Oracle Fusion Middleware Administrator's Guide for Oracle Internet
                         Directory for information about Oracle Internet Directory and its
                         architecture
                     •   About Enterprise User Security Directory Entries for information about
                         Oracle Internet Directory entries that are used for Enterprise User
                         Security



1.1.2.2 Enterprise Users Compared to Database Users
              Database users are typically defined in the database by using the CREATE USER
              statement as follows:
              CREATE USER username IDENTIFIED BY password;

              This creates a database user, associated with a user schema, who can access the
              database and be authenticated by using a password with the CONNECT command as
              follows:
              CONNECT username@database_service_name
              Enter Password:

              Database users must be created in each database they need to access, and they can
              choose a different password for each database. Database user privileges are
              controlled by local roles in each database.
              In contrast, enterprise users are provisioned and managed centrally in an LDAP-
              compliant directory, such as Oracle Internet Directory, for database access. Enterprise
              users have a unique identity in the directory called the distinguished name (DN). When
              enterprise users log on to a database, the database authenticates those users by
              using their DN.
              Enterprise users are defined in the database as global users. Global users can have
              their own schemas, or they can share a global schema in the databases they access.
              You can create enterprise users by using the GLOBALLY clause in the CREATE USER
              statement in two different ways.
              You can specify a user's directory DN with an AS clause, which is shown in the
              following statement:
              CREATE USER username IDENTIFIED GLOBALLY AS '<DN of directory user entry>';




                                                                                                          1-5
                                                                                                  Chapter 1
                                                                    Introduction to Enterprise User Security


            In this case, they have a schema allocated exclusively to them.
            Alternatively, you can specify a null string with the AS clause as the following statement
            shows:
            CREATE USER username IDENTIFIED GLOBALLY AS '';

            When you specify a null string with the AS clause, the directory maps authenticated
            users to the appropriate database schema. In this case, multiple users can be mapped
            to a shared schema based on the mapping information set up and stored in Oracle
            Internet Directory.



                   Note:
                   You can also use the following syntax to create a shared schema:
                   CREATE USER username IDENTIFIED GLOBALLY;

                   This is the same as specifying a null string.



            When enterprise users connect over SSL to the database, they do not use a
            password. Instead they use the following CONNECT command, which looks up the wallet
            location based on information in the client's sqlnet.ora file:
            CONNECT /@database_service_name

            Password-authenticated enterprise users use the same CONNECT statement to connect
            to the database as regular database users. For example, password-authenticated
            enterprise users connect to the database by using the following syntax:
            CONNECT username@database_service_name
            Enter password:

            When the database receives a connection request from an enterprise user, the
            database refers to the directory for user authentication and authorization (role)
            information.



                   See Also:

                   •   Getting Started with Enterprise User Security for a tutorial on creating
                       and using enterprise users
                   •   "Creating New Enterprise Users"
                   •   Oracle Database Security Guide for more information about global users
                   •   Oracle Fusion Middleware Administrator's Guide for Oracle Internet
                       Directory for information about defining users in the directory



1.1.2.3 About Enterprise User Schemas
            Enterprise users can retain their individual database schemas (exclusive schemas) or
            share schemas if the enterprise security administrator maps them to a shared schema.




                                                                                                       1-6
                                                                                                   Chapter 1
                                                                     Introduction to Enterprise User Security


              This section contains the following topics:
              •   Private or Exclusive Schemas
              •   Shared Schemas

1.1.2.3.1 Private or Exclusive Schemas
              If users want to retain their individual schemas in the databases that they access, then
              they must complete the following tasks:
              •   Create enterprise users in the directory
              •   Create a global user schema for each user in each database that they access
              Creating separate accounts for each enterprise user on each database that they
              access results in significant overhead. Instead, creating enterprise users who access a
              single, generic shared schema in each database increases the efficiency of the
              enterprise user solution.

1.1.2.3.2 Shared Schemas
              To receive the real benefit of the enterprise user solution, you can use shared
              schemas for your enterprise users. For this strategy, complete the following tasks:
              •   Create enterprise users in the directory
              •   Create a single shared schema in each database
              •   Create a single shared schema mapping in Oracle Internet Directory
              Mapping enterprise users to a generic, shared schema on each of the databases that
              they access greatly reduces the overhead of creating separate schemas for each
              enterprise user.
              Shared schema enterprise users can be mapped to generic, shared schemas on all of
              the databases that they access, or they can have exclusive schemas on some
              databases and shared schemas on others. The shared schema mappings are stored
              in the directory.



                     See Also:

                     •   "About Using Shared Schemas for Enterprise User Security" for more
                         information about creating and using shared schemas for enterprise
                         users
                     •   "Creating a Shared Schema in the Database" for a tutorial on creating a
                         shared schema in the database



1.1.2.4 How Enterprise Users Access Database Resources with Database
Links
              Database links are network objects stored in the local database or in the network
              definition that identify a remote database, a communication path to that database, and
              optionally, a user name and password. Once defined, the database link is used to




                                                                                                        1-7
                                                                                                           Chapter 1
                                                                             Introduction to Enterprise User Security


                  access the remote database. Oracle Database supports connected user links, fixed
                  user links, and current user links.
                  Enterprise users can use all three types of the following database links:
                  •   Connected user links are accessed by a local user who has an account on the
                      remote server.
                  •   Fixed user links contain a user name and password as part of the link definition.
                  •   Current user database links allow enterprise users to access objects on remote
                      databases without passing authentication information during link execution, or
                      storing authentication information in the link definition.
                      They require SSL for the database network connections, which means public key
                      infrastructure (PKI) credentials must be obtained and maintained for the
                      databases. Current user database links can be used to connect to the remote
                      database only as an enterprise user.



                          See Also:

                          •     "About Using Current User Database Links for Enterprise User Security"
                                for detailed information about creating and using current user database
                                links
                          •     Oracle Database Administrator’s Guide for information about all of the
                                different types of database links supported by Oracle Database



1.1.2.5 How Enterprise Users Are Authenticated
                  Enterprise User Security supports the following authentication methods:
                  •   Password-based authentication
                  •   SSL-based authentication
                  •   Kerberos-based authentication
                  Each authentication method has advantages and disadvantages. Table 1-1
                  summarizes the criteria for selecting which authentication method is best for your
                  Enterprise User Security implementation.

Table 1-1   Enterprise User Security Authentication: Selection Criteria

Password Authentication               SSL Authentication                    Kerberos Authentication
Password-based authentication         Provides strong authentication over   Provides strong authentication by
                                      SSL                                   using Kerberos, version 5 tickets
Provides centralized user and         Provides centralized user and PKI     Provides centralized user and
password management                   credential/wallet management          Kerberos credential management
Separate authentications required for Supports single sign-on (SSO) using   Supports SSO using Kerberos,
each database connection              SSL                                   version 5 encrypted tickets and
                                                                            authenticators, and authentication
                                                                            forwarding




                                                                                                                1-8
                                                                                                                          Chapter 1
                                                                                           Introduction to Enterprise User Security




Table 1-1       (Cont.) Enterprise User Security Authentication: Selection Criteria

Password Authentication                      SSL Authentication                          Kerberos Authentication
Retains users' current authentication Initial configuration maybe more       Initial configuration maybe more
methods                               difficult because PKI credentials must difficult because Kerberos must be
                                      be generated for all users.            installed and configured to
                                      (Dependent on administrators' PKI      authenticate database users
                                      knowledge)
User identity can be used in two-tier Compatible with either a two-tier or               Compatible with either a two-tier or
or multitier applications. OracleAS   multitier environment                              multitier environment
Single Sign-On users and enterprise
users use the same stored password
Supports Oracle Release 7.3 and              Supports Oracle8i and later clients         Supports Oracle Database 10g and
later clients with Oracle Database           with Oracle Database 10g and later          later clients with Oracle Database
10g and later                                                                            10g and later
Supports current user database links Supports current user database links Supports current user database links
only if the connection between                                            only if the connection between
databases is over SSL                                                     databases is over SSL
Can use third-party directories to           Can use third-party directories to          Can use third-party directories to
store users if synchronized with             store users if synchronized with            store users if synchronized with
Oracle Internet Directory1                   Oracle Internet Directory2                  Oracle Internet Directory3

1   If third-party directory is Microsoft Active Directory, then when user passwords change, they must be changed in both Active
    Directory and in Oracle Internet Directory.
2   Must modify the Directory Integration Services agent to synchronize user PKCS #12 attributes.
3   If third-party directory is Microsoft Active Directory, then login to Windows gives you single sign-on login to databases.
    However, you must modify the Directory Integration Services agent for other third-party directories to synchronize the
    KrbPrincipalName attribute. This synchronization is automatic for Microsoft Active Directory.



                                Note:
                                Enterprise User Security supports three-tier environments. Oracle Database
                                proxy authentication features enable
                                (i) proxy of user names and passwords through multiple tiers, and
                                (ii) proxy of X.509 certificates and distinguished names through multiple tiers.




                                See Also:

                                •    Enterprise User Security Configuration Tasks and Troubleshooting for
                                     information about configuring the various authentication types for
                                     enterprise user security
                                •    Oracle Database Security Guide, for information about using proxy
                                     authentication




                                                                                                                               1-9
                                                                                                  Chapter 1
                                                                    Introduction to Enterprise User Security




1.1.3 About Enterprise User Security Directory Entries
             In a directory, a collection of information about an object is called an entry. For
             Enterprise User Security, elements such as users, roles, and databases are directory
             objects, and information about these objects is stored as entries in the directory.
             Each entry in the directory is uniquely identified by a DN. The DN tells you exactly
             where the entry resides in the directory entry hierarchy, which is commonly called the
             directory information tree (DIT).



                    Note:
                    For Oracle Database 10g and later, databases must be registered in a
                    complete identity management realm of Oracle Internet Directory.




                    See Also:
                    Oracle Fusion Middleware Administrator's Guide for Oracle Internet Directory
                    for a complete discussion of directory entries



             The following sections describe directory entries related to Enterprise User Security:
             •   Enterprise Users
             •   Enterprise Roles
             •   Enterprise Domains
             •   Database Server Entries
             •   User-Schema Mappings
             •   Administrative Groups
             •   Password Policies

1.1.3.1 Enterprise Users
             An enterprise user is one who is defined and managed in a directory. Each enterprise
             user has a unique identity across an enterprise. Enterprise user entries can reside at
             any location within the identity management realm, except within the realm Oracle
             Context.




                                                                                                     1-10
                                                                                                   Chapter 1
                                                                     Introduction to Enterprise User Security




                    Note:
                    When creating enterprise users in a 9.0.4 or later Oracle Internet Directory,
                    use the tools that come with that 9.0.4 or later Oracle Internet Directory, such
                    as Delegated Administration System (DAS). Even if your databases are 9i or
                    9iR2, do not use the 9i or 9iR2 Enterprise Security Manager GUI tool to
                    create users in a 9.0.4 or later Oracle Internet Directory.
                    Use only DAS-based tools, like the Oracle Internet Directory Self-Service
                    Console, that ship with Oracle Application Server 10g, to create enterprise
                    users in identity management realms.



             The entries described in the following sections can reside only within a realm Oracle
             Context.

1.1.3.2 Enterprise Roles
             An enterprise role is a directory object that acts like a container to hold one or more
             database global roles. Each global role is defined in a specific database where it is
             assigned privileges, but then it is managed in the directory by using enterprise roles.
             Enterprise users can be assigned an enterprise role, which determines their access
             privileges on databases. Figure 1-3 shows an example of an enterprise role called
             Manager under OracleDefaultDomain.
             As an example, consider the enterprise role sales_manager, which contains the global
             role manage_leads with its privileges on the Customer Relationship Management
             (CRM) database, and the bonus_approval global role with its privileges on the Finance
             database. Figure 1-2 illustrates this example.




                                                                                                      1-11
                                                                                                            Chapter 1
                                                                              Introduction to Enterprise User Security


Figure 1-2   Example of Enterprise Roles

Eastern Region
   (Identity
 Management
    Realm)




                     Oracle
                     Context




                                                   Registered as members of . . .
                                   Acme Widgets
                                     (Enterprise
                                      Domain)      Registered as members of . . .




                 sales_manager
                 Enterprise Role

     manage_leads              bonus_approval
       global role                global role




                                                                                    Finance
                                                                                    Database
                                                                                bonus_approval
                                                                                   global role




                                                           CRM
                                                         Database
                                                      manage_leads
                                                        global role




                 An enterprise role can be assigned to one or more enterprise users. For example, you
                 could assign the enterprise role sales_manager to a number of enterprise users who
                 hold the same job. This information is protected in the directory, and only a directory
                 administrator can manage users and assign their roles. A user can be granted local
                 roles and privileges in a database in addition to enterprise roles, by virtue of the
                 privileges on the schema to which the user connects.
                 Enterprise role entries are stored in enterprise domain subtrees. Each enterprise role
                 contains information about associated global roles on each database server and the
                 associated enterprise users. The enterprise domain administrator creates and
                 manages enterprise roles by using Oracle Enterprise Manager.




                                                                                                               1-12
                                                                                                  Chapter 1
                                                                    Introduction to Enterprise User Security




                   See Also:
                   "Configuring Enterprise Roles" for information about using Oracle Enterprise
                   Manager to create and manage enterprise roles




                   Note:
                   The database obtains a user's global roles from the directory as part of the
                   login process. If you change a user's global roles in the directory, then those
                   changes do not take effect until the next time the user logs in to the
                   database.



1.1.3.3 Enterprise Domains
            An enterprise domain is a group of databases and enterprise roles. An example of a
            domain could be the engineering division in an enterprise or a small enterprise itself.
            Figure 1-3 shows an example of an enterprise domain called Services that resides
            under the OracleDBSecurity entry in an identity management realm. It is here, at the
            enterprise domain level, that the enterprise domain administrator, using Oracle
            Enterprise Manager, assigns enterprise roles to users and manages enterprise
            security.
            An enterprise domain subtree in a directory is composed of three types of entries:
            enterprise role entries, user-schema mappings, and the enterprise domain
            administrator's group for that domain. Enterprise domains are used to manage
            information that applies to multiple databases. All user-schema mappings entries
            contained in an enterprise domain apply to all databases in the domain. If you need to
            apply different user-schema mappings to individual databases, then use database
            server entries, which are discussed in the following section.
            Enterprise roles apply to specific databases in the domain, as explained in the
            previous section. Enterprise roles, domain-level mappings, and the domain
            administrators group are all administered by using Oracle Enterprise Manager.



                   See Also:
                   "Administering Enterprise Domains"



1.1.3.4 Database Server Entries
            A database server entry (represented as "Sales" in Figure 1-3) is a directory entry
            containing information about one database server. It is created by the Database
            Configuration Assistant during database registration. A database server entry is the
            parent of database-level mapping entries called user-schema mappings, which
            describe mappings between full or partial user DNs and database shared schema
            names. User-schema mapping entries are created by the database administrator by
            using Oracle Enterprise Manager.




                                                                                                     1-13
                                                                                   Chapter 1
                                                     Introduction to Enterprise User Security




      See Also:
      "Oracle Enterprise Manager"



Database administrators belong to the directory administrative group,
OracleDBAdmins, which is also managed with Oracle Enterprise Manager. Only
OracleDBAdmins or OracleContextAdmins group members can add or remove users
from the OracleDBAdmins group. When a user registers a database in the directory,
Database Configuration Assistant automatically puts the person who performs
registration into the OracleDBAdmins group. The directory entry for this group is
located under the database server entry in the DIT.



      See Also:

      •   Table 1-2 for a description of the OracleContextAdmins group
      •   "Task 6: Register the database in the directory"
      •   "Administering Enterprise Domains" and "Adding Administrators to
          Manage Database Schema Mappings"




                                                                                      1-14
                                                                                                             Chapter 1
                                                                               Introduction to Enterprise User Security


Figure 1-3     Related Entries in a Realm Oracle Context


                                                                  realm
                                                                   DN




                                                 Oracle           Users         Groups
                                                 Context




                                                   Groups
                                              OracleDBCreators
                                            OracleContextAdmins
                                           OracleDBSecurityAdmins               Sales
                  Products                OracleUserSecurityAdmins            (Example
                                      OraclePasswordAccessibleDomains         Database)



User Search Base                                                             User-Schema
                       OracleDBSecurity                     OracleDBAdmins     Mapping
Group Search Base                                                Group        (Example)           Networking




     Services
     (Example                                     OracleDefaultDomain
     Enterprise
      Domain)


       Domain                Domain Admins    User-Schema      Manager         Proxy 1
       Admins                                                  (Example       (Example
    (for Services              (for Default     Mapping
                                 Domain)       (Example)       Enterprise       Proxy
       Domain)                                                   Role)       Permission)




1.1.3.5 User-Schema Mappings
                     A user-schema mapping is a directory entry that contains mapping information
                     between a user's DN and an Oracle database schema. The users referenced in the
                     mapping are connected to the specified schema when they connect to the database.
                     User-schema mapping entries can apply to only one database or they can apply to all
                     databases in a domain, depending on where they reside in the realm Oracle Context.



                               See Also:

                               •   "How Enterprise Users Are Mapped to Schemas"
                               •   "Creating User-Schema Mappings for an Enterprise Domain"



1.1.3.6 Administrative Groups
                     An identity management realm contains administrative groups related to Enterprise
                     User Security. Figure 1-3 shows these administrative groups in a realm in the triangle




                                                                                                                1-15
                                                                                                           Chapter 1
                                                                             Introduction to Enterprise User Security


                   labeled "Groups." Each administrative group includes Access Control Lists (ACLs) that
                   control access to the group itself. ACLs elsewhere in the directory may refer to these
                   groups, which allows directory administrators access to perform necessary
                   administrative tasks. The administrative user who creates the realm automatically
                   becomes the first member of each of these groups, thus gaining the associated
                   privileges provided by each group. However, this user can be removed.
                   The relevant administrative groups in a realm are described in Table 1-2.



                          Note:
                          Observe the following practices. Using other methods may break the security
                          configuration for Enterprise User Security objects and may break enterprise
                          user functionality as well.
                          •   Do not modify the ACLs for the objects contained in a realm Oracle
                              Context. Modified realm Oracle Context object ACLs are not supported.
                          •   Use only Oracle tools, such as Oracle Enterprise Manager, Oracle
                              Internet Directory Self-Service Console, and Database Configuration
                              Assistant, to modify Enterprise User Security directory entries.



Table 1-2   Administrative Groups in a Realm Oracle Context

Administrative Group                Description
OracleContextAdmins                 DN: (cn=OracleContextAdmins,cn=Groups,cn=OracleContext...)
                                    Default owner: The user who created the identity management realm. (If it
                                    is the realm created during installation, then it is orcladmin.)
                                    OracleContextAdmins has full access to all groups and entries within the
                                    associated realm Oracle Context.
OracleDBAdmins                      DN:
                                    (cn=OracleDBAdmins,cn=<database_entry_name>,cn=OracleContex
                                    t...)
                                    Default owner: None. Database Configuration Assistant automatically
                                    makes the user who registers a database in the directory a member of this
                                    group.
                                    Members of this group manage user-schema mappings specific to this
                                    database. Only users who are already members of this group or
                                    OracleContextAdmins can add or remove users from the OracleDBAdmins
                                    group.
OracleDBCreators                    DN: (cn=OracleDBCreators,cn=OracleContext...)
                                    Default owner: OracleContextAdmins
                                    During default realm Oracle Context creation, Oracle Internet Directory
                                    Configuration Assistant sets up the following access rights/permissions for
                                    these group members:
                                    •   Add permission for database service objects in the realm Oracle
                                        Context
                                    •   Modify permission for the Default Domain
                                    OracleDBCreators create new databases and register them in the directory
                                    by using Database Configuration Assistant




                                                                                                              1-16
                                                                                                           Chapter 1
                                                                             Introduction to Enterprise User Security




Table 1-2   (Cont.) Administrative Groups in a Realm Oracle Context

Administrative Group              Description
OracleDBSecurityAdmins            DN: (cn=OracleDBSecurityAdmins,cn=OracleContext...)
                                  Default owner: All group members.
                                  During default realm Oracle Context creation, Oracle Internet Directory
                                  Configuration Assistant sets up the following access rights/permissions for
                                  these group members:
                                  •   All privileges in the OracleDBSecurity subtree
                                  •   Modify privileges for membership in this group
                                  OracleDBSecurityAdmins have permissions on all of the domains in the
                                  enterprise and perform the following tasks:
                                  •   Sets Enterprise User Security configurations for the realm, such as the
                                      default database-to-directory authentication method
                                  •   Group owner administers the OracleDBSecurityAdmins group
                                  •   Creates and deletes enterprise domains
                                  •   Moves databases from one domain to another within the enterprise
OracleDomainAdmins                DN: (cn=OracleDomainAdmins,cn=<enterprise_domain_name>,
                                  cn=OracleDBSecurity,cn=Products,cn=OracleContext....)
                                  Default owner: The user creating or updating the domain.
                                  If a new context and OracleDefaultDomain are created, then the initial
                                  member will be the context creator.
                                  Members of the OracleDomainAdmins group have full privileges for the
                                  enterprise domain. They manage mappings, enterprise roles, and proxy
                                  permissions specific to the entire domain. You should be a member of
                                  OracleDomainAdmins (for the domain), OracleDBSecurityAdmins, or
                                  OracleContextAdmins to modify membership of this group.
OracleUserSecurityAdmins          DN:
                                  (cn=OracleUserSecurityAdmins,cn=Groups,cn=OracleContext...)
                                  Default owner: The user who created the identity management realm.
                                  By default, an ACL is set at the directory root in Oracle Internet Directory
                                  that sets up the relevant permissions so OracleSecurityAdmins can
                                  administer Oracle user security.
OraclePasswordAccessibleDomains DN:
                                (cn=OraclePasswordAccessibleDomains,cn=Groups,cn=OracleCont
                                ext...)
                                  Default owner: Same as OracleDBSecurityAdmins
                                  Group members are enterprise domains, which contain databases enabled
                                  for password-authorized enterprise users.


1.1.3.7 Password Policies
                Password policies are a set of rules that apply to all user passwords in an identity
                management realm. Password policies include settings for password complexity,
                minimum password length, and the like. They also include account lockout and
                password expiration settings.
                A password policy entry is defined in Oracle Internet Directory for every identity
                management realm. Password policies in Oracle Internet Directory are standard
                Oracle Internet Directory entries that can be used by Oracle Database for Enterprise
                User Security.




                                                                                                              1-17
                                                                                                Chapter 1
                                                  About Using Shared Schemas for Enterprise User Security


         Oracle Internet Directory ensures that all enterprise user passwords meet the rules
         specified in the password policy entry for the realm. The database communicates with
         Oracle Internet Directory when authenticating an enterprise user. It requests Oracle
         Internet Directory to report any password policy violations. If the database gets a
         policy violation response from Oracle Internet Directory, then it flashes the appropriate
         warning or error message to the user.
         The database reports the following events:
         •   It flashes a warning when the user password is about to expire and displays the
             number of days left for the user to change his or her password.
         •   It flashes a warning when the password has expired and informs the user about
             the number of grace logins that remain.
         •   It displays an error when the user password has expired and the user does not
             have any grace logins left.
         •   It displays an error when the user account has been locked due to repeated failed
             attempts at login.



                    Note:
                    For Enterprise SYSDBA users, the failed login count is enabled and is
                    updated whether the database is up or down.


         •   It displays an error if the user account has been disabled by the administrator.
         •   It displays an error if the user account is inactive.
         Enterprise user login attempts to the database, update the user account status in
         Oracle Internet Directory. For example, consecutive failed login attempts to the
         database results in the account getting locked in the directory, as per the directory's
         password policy.



                See Also:
                Oracle Fusion Middleware Administrator's Guide for Oracle Internet Directory
                for detailed information on password policies and their management




1.2 About Using Shared Schemas for Enterprise User
Security
         The following sections describe shared schemas, and how to set them up:
         •   Overview of Shared Schemas Used in Enterprise User Security
         •   How Shared Schemas Are Configured for Enterprise Users
         •   How Enterprise Users Are Mapped to Schemas




                                                                                                   1-18
                                                                                               Chapter 1
                                                 About Using Shared Schemas for Enterprise User Security




1.2.1 Overview of Shared Schemas Used in Enterprise User Security
           Users do not necessarily require individual accounts or schemas set up in each
           database. Alternatively, they can connect to a shared schema and be granted access
           to the objects associated with target applications. For example, suppose that users
           Tom, Dick, and Harriet require access to the Payroll application on the Finance
           database. They do not need to create unique objects in the database, and therefore do
           not need their own schemas, but they do need access to the objects in the Payroll
           schema.
           Oracle Database supports mapping multiple users stored in an enterprise directory to
           a shared schema on an individual database. This separation of users from schemas
           reduces administration costs by reducing the number of user accounts on databases.
           It means that you do not need to create an account for each user (user schema) in
           addition to creating the user in the directory. Instead, you can create a user in the
           enterprise directory, and map that user to a shared schema. Other enterprise users
           can also be mapped to that schema.
           For example, if Tom, Dick and Harriet all access both the Sales and the Finance
           databases, you do not need to create an account for each user on each database.
           Instead, you can create a single shared schema on each database, such as GUEST,
           that all three users can access. Then individual access to objects in the Sales or
           Finance database can be granted to these three users by using enterprise roles. A
           typical environment can have up to 5,000 enterprise users mapped to one shared
           schema and each user can be assigned a set of enterprise roles.
           Oracle recommends that you create a separate shared schema that contains no
           objects to use as an entry point. Then, grant access to application objects in other
           schemas through enterprise roles. Otherwise, application objects can be inadvertently
           or maliciously deleted or altered.
           In summary, shared schemas provide the following benefits:
           •    Shared schemas eliminate the need to have a dedicated database schema on
                each database for each enterprise user.
           •    Each enterprise user can be mapped to a shared schema on each database the
                user needs to access. The user connects to the shared schema when the user
                connects to a database.
           •    Shared schemas lower the cost of managing users in an enterprise.


1.2.2 How Shared Schemas Are Configured for Enterprise Users
           To configure shared schemas, the local database administrator (DBA) must create at
           least one database schema in a database. Enterprise users can be mapped to this
           schema.
           In the following example, the administrator creates a shared schema and maps users
           to it:
           1.   The administrator creates a global shared schema called EMPLOYEE and the global
                role HRMANAGER on the HR database.
           2.   The administrator uses the Oracle Internet Directory Self-Service Console and
                Oracle Enterprise Manager to create and manage enterprise users and roles in the
                directory. For example, the administrator creates enterprise user Harriet and an



                                                                                                  1-19
                                                                                                 Chapter 1
                                                   About Using Shared Schemas for Enterprise User Security


               enterprise role named MANAGER. The administrator then assigns the HR database
               global role of HRMANAGER to the enterprise role MANAGER.
          3.   The administrator assigns enterprise roles to enterprise users in the directory. For
               example, the administrator assigns the enterprise role MANAGER to Harriet.
          4.   The administrator uses Oracle Enterprise Manager to map the user Harriet in the
               directory to the shared schema EMPLOYEE on the HR database.
          When Harriet connects to the HR database, she is automatically connected to the
          EMPLOYEE schema and is given the global role of HRMANAGER. Multiple enterprise users
          can be mapped to the same shared schema. For example, the enterprise security
          administrator can create another enterprise user Scott and map Scott to the EMPLOYEE
          schema. From that point on, both Harriet and Scott automatically use the EMPLOYEE
          schema when connecting to the HR database, but each can have different roles and
          can be individually audited.



                    See Also:
                    Oracle Database Security Guide for more information about auditing



1.2.3 How Enterprise Users Are Mapped to Schemas
          Global schemas (those created with CREATE USER IDENTIFIED GLOBALLY AS '') can
          be owned by one enterprise user (exclusive schema) or shared among multiple
          enterprise users (shared schema). The mapping between a single enterprise user and
          his or her exclusive schema is stored in the database as an association between the
          user DN and the schema name. The mapping between enterprise users and a shared
          schema is done in the directory by means of one or more mapping objects. A mapping
          object is used to map the distinguished name (DN) of a user to a database schema
          that the user will access. You create a mapping object by using Oracle Enterprise
          Manager. This mapping can be one of the following:
          •    Entry-level (full DN) mapping
               This method associates the DN of a single directory user with a particular schema
               on a database. It results in one mapping entry for each user.
          •    Subtree-level (partial DN) mapping
               This method lets multiple enterprise users share part of their DN to access the
               same shared schema. This method is useful if multiple enterprise users are
               already grouped under some common root in the directory tree. The subtree that
               these users share can be mapped to a shared schema on a database. For
               example, you can map all enterprise users in the subtree for the engineering
               division to one shared schema, BUG_APP_USER, on the bug database. Note that
               the root of the subtree is not mapped to the specified schema.
               When an enterprise user connects to a database, the database retrieves a DN for
               the user, either from the network (in the case of SSL) or from the directory (in the
               case of password and Kerberos-authenticated enterprise users).
               When determining which schema to connect the user to, the database uses the
               user DN and the following precedence rules:
               1.   It looks for an exclusive schema locally (in the database).




                                                                                                    1-20
                                                                                        Chapter 1
                                          About Using Shared Schemas for Enterprise User Security


     2.   If it does not find an exclusive schema locally, then it searches the directory.
          Within the directory, it looks under the database server entry, first for an entry-
          level mapping, and then for a subtree-level mapping.
     3.   If it does not find a mapping entry under the server entry, then it looks under
          the enterprise domain entry, first for an entry-level mapping, and then for a
          subtree-level mapping.
     4.   If it does not find an exclusive schema locally or an applicable mapping entry
          in the database, then the database refuses the connection. Otherwise, the
          database connects the user to the appropriate schema.
For example, suppose that Harriet is trying to connect to the HR database but the
database does not find Harriet's exclusive schema (in the database). In this case, the
following events occur:
1.   The HR database looks up a user schema mapping with Harriet's DN in the
     directory. The directory has a mapping of Harriet to the shared schema EMPLOYEE
     and returns this schema.
2.   The database logs Harriet in and connects her to the EMPLOYEE schema.
3.   The database retrieves this user's global roles for this database from the directory.
4.   The database also retrieves from its own tables any local roles and privileges
     associated with the database schema to which the user is mapped.
5.   The database uses both the global and the local roles to determine the information
     that the user can access.
Continuing this example, assume that the enterprise role MANAGER contains the global
roles ANALYST on the HR database, and USER on the Payroll database. When Harriet,
who has the enterprise role MANAGER, connects to the HR database, she uses the
schema EMPLOYEE on that database.
•    Her privileges on the HR database are determined by:
     –    The global role ANALYST
     –    Any local roles and privileges associated with the EMPLOYEE schema on the
          HR database
•    When Harriet connects to the Payroll database, her privileges are determined by:
     –    The global role USER
     –    Any local roles and privileges associated with the EMPLOYEE schema on the
          Payroll database
You can grant privileges to a specified group of users by granting roles and privileges
to a database schema. Every user sharing such a schema gets these local roles and
privileges in addition to personal enterprise roles. However, you should exercise
caution when doing this because every user who is mapped to this shared schema
can exercise the privileges assigned to it. Accordingly, Oracle does not recommend
granting roles and privileges to a shared schema.




                                                                                           1-21
                                                                                            Chapter 1
                                                                                Enterprise User Proxy




                 See Also:

                 •   "Task 1: Create Global Schemas and Global Roles in the Database" for
                     detailed information about how to create shared schemas for enterprise
                     users
                 •   "Enterprise User Proxy"



1.3 Enterprise User Proxy
         Sometimes, an enterprise user needs to connect to a database as another user,
         temporarily having the target user's authorizations and privileges. This capability is
         particularly useful for midtier tools or applications, which often operate across various
         databases as enterprise users, their identities established as entries in Oracle Internet
         Directory. Such an application can maintain a single database connection while
         switching end user identities, thereby providing functionality in the name of each
         authorized user in turn.
         Enterprise User Security 11g Release 1 (11.1) enhanced the efficiency of the proxy
         mechanism by introducing a single-session model. The two-session proxy model
         required maintaining separate sessions for the proxy user and the target user. In the
         new model, only one session is maintained in the security context of the target user.
         This leads to an improvement in performance.
         Enterprise User Security 11g Release 1 (11.1), and later, allows greater granularity in
         assigning proxy permissions to enterprise users. Enterprise users can be individually
         granted permissions to proxy as local database users. The permissions no longer
         need to be associated with the user's shared schema in the database.
         Being able to assign proxy permissions individually to enterprise users means that the
         permissions can be more specific. Assigning permissions to a shared schema, on the
         other hand, forces you to assign the same permissions to all users who map to the
         schema. This can lead to unwarranted rights and privileges.
         Enterprise user proxy permissions are created and stored in Oracle Internet Directory.
         A permission allows one or more enterprise users or groups to proxy as a target
         database user. Permissions can apply to specific databases or to all databases in the
         enterprise domain.
         By default, domain administrators can manage proxy permissions in the directory for
         an enterprise domain. These permissions are configured and managed using Oracle
         Enterprise Manager.



                 See Also:
                 For more information on configuring enterprise user proxy permissions, see
                 "Configuring Proxy Permissions"



         Setting up such proxying has several stages:
         1.   Identify all enterprise users who need permissions to proxy to various databases.




                                                                                               1-22
                                                                                   Chapter 1
                                                                       Enterprise User Proxy


2.   Identify all the target users in each such database.
3.   Issue ALTER USER commands for each such target user, in the following form:
     •    ALTER USER target_user GRANT CONNECT THROUGH ENTERPRISE USERS
     The target_user can now be proxied to by the enterprise users that have proxy
     permissions in Oracle Internet Directory. Revoking proxy permission uses similar
     syntax, replacing GRANT with REVOKE.



              See Also:
              For the full ALTER USER syntax, see Oracle Database SQL Language
              Reference
              For Oracle Call Interface usage, see Oracle Call Interface Programmer's
              Guide


4.   Grant proxy permissions to each enterprise user either individually or as a member
     of a group. See the section entitled "Granting Proxy Permissions to Enterprise
     Users".



              Note:
              To establish a group representing those enterprise users who will proxy
              to the same database user, use Oracle Delegated Administration
              Services as described in the Oracle Identity Management Guide to
              Delegated Administration.


5.   With all four of the preceding steps accomplished, your identified enterprise users
     can proxy to any of the local database users you identified and associated with
     them. Two versions of the CONNECT command can be used. In (a), you supply the
     enterprise user's password in the command. In (b), you do not, relying instead on
     the password being in a wallet whose location was put in the sqlnet.ora file.
     a.   To establish an enterprise user proxy connection as a database user, use the
          following SQL*Plus command syntax, supplying the enterprise user's
          password:
          •   CONNECT joeproxy[targetuser]@database_service_name
              Enter Password:

              where you would replace joeproxy with the name of the enterprise user
              wishing to proxy as targetuser, and replace targetuser with the name of
              the registered user of the target database. The square brackets are
              required. Enter the enterprise user's password when prompted for the
              password.
          Once these identities are validated, this connection request results in a single
          session, in which the proxy user operates in the target database as the target
          user. The identity of the original user is maintained through to the database,
          and the audit records can capture both the proxy and the target user's identity.




                                                                                      1-23
                                                                                                  Chapter 1
                                       About Using Current User Database Links for Enterprise User Security


             b.   To connect as an enterprise user proxy for a database user without specifying
                  a password, ensure that the sqlnet.ora file contains the location of the wallet
                  holding that user's password. Then, use the following command syntax:
                  •    CONNECT [targetuser]/@database_service_name

                       where you would replace targetuser with the name of the registered user
                       of the target database. The square brackets are required. The current
                       enterprise user proxies as the targetuser.



                  Note:
                  The regular proxy login mechanism using OCI calls can still be used. The
                  CONNECT syntax is a new alternative. For more information on the OCI call
                  mechanism, refer to Oracle Database Security Guide.



         Although the enterprise user proxy permissions are assigned in Oracle Internet
         Directory, the database administrator can decide which local accounts are to be
         available as enterprise user proxy targets. The enterprise domain administrator can
         assign proxy permissions to only those targets that are available in the dba_proxies
         view of the database.


1.4 About Using Current User Database Links for Enterprise
User Security
         Oracle Database supports current user database links over an SSL-authenticated
         network connection. Current user database links let you connect to a second database
         as yourself, or as another user when used from within a stored procedure owned by
         that user. Such access is limited to the scope of the procedure. The security
         advantage of current user database links is that the other user's credentials are not
         stored in the database link definition and are not sent across the network connection
         between databases. Instead, security of these links is based on mutual trust, mutual
         authentication, and a secure network connection between the databases themselves.
         For example, a current user database link lets Harriet, a user of the Finance database,
         procedurally access the Accounts Payable database by connecting as the enterprise
         user Scott.
         For Harriet to access a current user database link to connect to the schema Scott,
         Scott must be a global schema (created as IDENTIFIED GLOBALLY) in both databases.
         Harriet, however, can be a user identified in one of three ways:
         •   By a password
         •   GLOBALLY
         •   EXTERNALLY
         To create Scott as a global user in the first database, Finance, you must enter
         CREATE USER Scott IDENTIFIED GLOBALLY as 'CN=Scott,O=nmt'

         so that Scott has an exclusive schema. Then Scott can map to a shared schema in the
         second database, Accounts Payable. In order for the current user database link to



                                                                                                     1-24
                                                                                              Chapter 1
                                                     Enterprise User Security Deployment Considerations


         work, the schema created for Scott in the first database cannot be shared with other
         users.
         Current user database links operate only between trusted databases within a single
         enterprise domain. Databases within the domain trust each other to authenticate
         users. You specify an enterprise domain as trusted by using Oracle Enterprise
         Manager. When you use Oracle Enterprise Manager to enable current user database
         links for a domain, they will work for all databases within that domain. However, each
         database in the domain must have its own PKI credentials and use SSL to
         authenticate to the other databases. To specify a database as untrusted that is part of
         a trusted enterprise domain, use the PL/SQL package
         DBMS_DISTRIBUTED_TRUST_ADMIN. To obtain a list of trusted servers, use the
         TRUSTED_SERVERS view.



                Note:
                Oracle Advanced Security, an option to the Oracle Database Enterprise
                Edition, does not support RADIUS authentication over database links.




                See Also:

                •   What Is Meant by Trusted Databases
                •   Oracle Database Heterogeneous Connectivity User's Guide, for
                    additional information about current user database links
                •   Oracle Database SQL Language Reference for more information about
                    SQL syntax
                •   Oracle Database PL/SQL Packages and Types Reference, for
                    information about the PL/SQL package DBMS_DISTRIBUTED_TRUST_ADMIN
                •   Oracle Database Reference, for information about the TRUSTED_SERVERS
                    view
                •   Oracle Database Security Guide, for information about configuring SSL
                    for Oracle Net.
                •   Managing Oracle Wallets for information about creating wallets



1.5 Enterprise User Security Deployment Considerations
         Consider the following issues before deploying Enterprise User Security:
         •   Security Aspects of Centralizing Security Credentials
         •   Security of Password-Authenticated Enterprise User Database Login Information
         •   Considerations for Defining Database Membership in Enterprise Domains
         •   Choosing Authentication Types between Clients, Databases, and Directories for
             Enterprise User Security




                                                                                                 1-25
                                                                                                    Chapter 1
                                                           Enterprise User Security Deployment Considerations




1.5.1 Security Aspects of Centralizing Security Credentials
             Beyond the general benefits that flow from the centralization of enterprise users and
             their associated credentials, there are a number of security-related benefits and risks
             that should be reviewed. The following sections describe these benefits and risks:
             •   Security Benefits Associated with Centralized Security Credential Management
             •   Security Risks Associated with Centralized Security Credential Management

1.5.1.1 Security Benefits Associated with Centralized Security Credential
Management
             Centralizing management makes it easier and faster to administer users, credentials,
             and roles, and to quickly revoke a user's privileges on all applications and databases
             across the enterprise. With centralized management, the administrator can delete a
             user in one place to revoke all global privileges, minimizing the risk of retaining
             unintended privileges.
             Centralizing management makes it possible to centralize an organization's security
             expertise. Specialized, security-aware administrators can manage all aspects of
             enterprise user security, including directory security, user roles and privileges, and
             database access. This is a substantial improvement over the traditional model, where
             DBAs are typically responsible for everything on the databases they manage, including
             security.

1.5.1.2 Security Risks Associated with Centralized Security Credential
Management
             While Oracle Internet Directory is a secure repository, there is a security challenge and
             inherent risk in centralizing credentials in any publicly accessible repository. Although
             centralized credentials can be protected at least as securely as distributed credentials,
             the very nature of centralization increases the consequences of inadvertent credential
             exposure to unauthorized parties. It is therefore imperative to limit the privileges of
             administrators to set restrictive Access Control Lists (ACLs) in the directory, and to
             implement good security practices in the protection of security credentials when they
             are temporarily outside of the directory.


1.5.2 Security of Password-Authenticated Enterprise User Database
Login Information
             In all secure password-based authentication methods, a server authenticates a client
             with a password verifier, typically a hashed version of the password that must be
             rigorously protected. Password-based authentication to an Oracle database is no
             different. There is a password verifier, and it must be protected as well. This is true if
             the verifier is stored locally in the database or centrally in the directory. Note that a
             password verifier cannot be used to derive the original password.
             An enterprise user's database password can be stored in a central directory service for
             access by multiple databases. It can be viewed and shared by all trusted databases to
             which the user has access. Although the password verifier stored in the directory is not
             the cleartext password, it is still necessary to protect it from casual or unauthorized




                                                                                                       1-26
                                                                                                  Chapter 1
                                                         Enterprise User Security Deployment Considerations


             access. It is therefore extremely important to define password-related ACLs in the
             directory that are as restrictive as possible while still enabling necessary access and
             usability. (Note that Oracle Database supports all verifier types that are supported by
             Oracle Internet Directory.)
             Oracle tools help set up ACLs in the directory to protect these password verifiers
             during identity management realm creation. The approach that Oracle recommends is
             intended to balance security and usability considerations. If you require maximum
             security and can set up wallets for all users, you should require only SSL connections
             from users to databases. This SSL-only approach circumvents the entire directory
             password protection issue.
             The following sections provide more information about trusted databases and
             protecting database password verifiers in the directory:
             •   What Is Meant by Trusted Databases
             •   Protecting Database Password Verifiers

1.5.2.1 What Is Meant by Trusted Databases
             SSL provides strong authentication so databases are ensured of being trusted with
             their own identity. With password-authenticated Enterprise User Security where
             database password verifiers are stored centrally in a directory and shared among
             multiple databases, each database that allows password-authenticated enterprise
             users to log in must be a trusted database. Each database has access to the shared
             password verifiers, so it is important that each database can be trusted to observe the
             following security precautions:
             •   Each database must be trusted to protect itself from tampering with the server
                 code so a malicious user cannot misuse the database identity to gain access to
                 password verifiers in the directory.
             •   Each database must be trusted to protect its PKI and other credentials from theft
                 so a malicious user cannot use them to gain access to the password verifiers
                 stored in the directory.

1.5.2.2 Protecting Database Password Verifiers
             The OraclePasswordAccessibleDomains group in each identity management realm is
             created automatically when the realm is created, and it can be managed by using
             Oracle Internet Directory tools like the Oracle Internet Directory Self-Service Console.
             Enterprise domains with member databases that must view users' database password
             verifiers in the directory are placed in this group.
             For a selected realm, determine which databases can accept password-authenticated
             connections. Use Oracle Internet Directory Self-Service Console to place the domains
             containing those databases into the OraclePasswordAccessibleDomains group. An
             ACL on the user subtree permits access to the directory attribute that holds the
             password verifier used by the database.
             All other users are denied access to this attribute. An ACL that prevents anonymous
             read access to the password verifier attributes is at the root of the directory tree.
             Note that for usability, by default, OracleDefaultDomain is a member of the
             OraclePasswordAccessibleDomains group. It can be removed, if desired.




                                                                                                     1-27
                                                                                                 Chapter 1
                                                        Enterprise User Security Deployment Considerations




1.5.3 Considerations for Defining Database Membership in Enterprise
Domains
           Consider the following criteria when defining the database membership of a domain:
           •   Current user database link s operate only between databases within a single
               enterprise domain. Use of these links requires mutual trust between these
               databases and between the DBAs who administer them.
           •   Accepted authentication types for enterprise users are defined at the domain level.
               Database membership in a domain should therefore be defined accordingly.



                      Note:
                      If one or more databases are intended to only support SSL-based
                      certificate authentication, they cannot be combined in the same domain
                      with password-authenticated databases.


           •   Enterprise roles are defined at the domain level. To share an enterprise role
               across multiple databases, the databases must be members of the same domain.


1.5.4 Choosing Authentication Types between Clients, Databases,
and Directories for Enterprise User Security
           Enterprise User Security supports the authentication types listed in Table 1-3 for
           connections between clients, databases, and directories.

           Table 1-3 Enterprise User Security: Supported Authentication Types for
           Connections between Clients, Databases, and Directories

           Connection                      Supported Authentication Types
           Clients-to-Databases            Passwords, SSL, and Kerberos
           Databases-to-Databases          SSL only
           (Current User Database Links)
           Databases-to-Directories        SSL and Passwords

           However, some combinations of authentication types for connections make more
           sense than others. For example, it is unusual to have a high level of security for client-
           database connections by using SSL for all user connections, but then configuring the
           database to authenticate to the directory by using passwords. Although this
           configuration is supported, it does not provide consistent security for connections.
           Ideally, the database-directory connection should be at least as secure as that
           between users and databases.
           The following section describes some typical configurations: Typical Configurations.




                                                                                                    1-28
                                                                                                   Chapter 1
                                                          Enterprise User Security Deployment Considerations




1.5.4.1 Typical Configurations
             The following combinations of authentication types between clients, databases, and
             directories are typical:
             •   Password authentication for all connections with no need for current user
                 database links
             •   SSL authentication for all connections
             •   Kerberos authentication for client-to-database connections, and password
                 authentication for database-to-directory connections




                                                                                                      1-29
2
Getting Started with Enterprise User
Security
         Enterprise User Security enables you to centrally manage database users across the
         enterprise. Enterprise users are created in Oracle Internet Directory, and can be
         assigned roles and privileges across various enterprise databases registered with the
         directory.
         This chapter uses a tutorial approach to help you get started with Enterprise User
         Security. The following steps discuss configuring Enterprise User Security:
         1.   Configuring Your Database to Use the Directory
         2.   Registering Your Database with the Directory
         3.   Creating a Shared Schema in the Database
         4.   Mapping Enterprise Users to the Shared Schema
         5.   Connecting to the Database as an Enterprise User
         6.   Using Enterprise Roles
         7.   Using Proxy Permissions
         8.   Using Pluggable Databases


2.1 Configuring Your Database to Use the Directory
         The first step in configuring Enterprise User Security is to configure the database to
         use the directory. Running the Net Configuration Assistant (NetCA) tool enables you to
         configure the directory host name and port that your database should use.

         To configure your database for directory usage:
         1.   Start NetCA using the netca command.
              •   On Windows, you can also start NetCA from the Start menu:
                  Click Start, All Programs, Oracle - OracleHomeName, Configuration and
                  Migration Tools, Net Configuration Assistant.
              •   On Unix systems, you can start NetCA using the following command:
                  $ORACLE_HOME/bin/netca
              The Welcome screen appears.




                                                                                              2-1
                                                                                   Chapter 2
                                              Configuring Your Database to Use the Directory




2.   Select Directory Usage Configuration. Click Next.
     The Directory Type screen appears.




3.   Click Next.
     The Directory Location screen appears.




                                                                                       2-2
                                                                                      Chapter 2
                                                 Configuring Your Database to Use the Directory




4.   Enter the name of the host on which the Oracle Internet Directory server is
     running. Also enter the LDAP non-SSL and SSL port numbers. These port
     numbers are 3060 and 3131 by default. Click Next.
     The Select Oracle Context screen appears.




5.   Select the default Oracle Context to use. You need to select this if there are
     multiple identity management realms on the directory server. Click Next.
     The Directory Usage Configuration, Done screen is displayed.



                                                                                          2-3
                                                                                                Chapter 2
                                                             Registering Your Database with the Directory


          6.   Confirm that the directory usage configuration is successfully completed. Click
               Next.
          7.   Click Finish.
               NetCA creates an ldap.ora file in the $ORACLE_HOME/network/admin directory.
               This is the $ORACLE_HOME\network\admin directory in Windows. The ldap.ora file
               stores the connection information details about the directory.


2.2 Registering Your Database with the Directory
          The next step is to register the database with the directory service. The Database
          Configuration Assistant (DBCA) tool enables you to register the database with Oracle
          Internet Directory.

          To register the database with the directory:
          1.   Start DBCA using the dbca command.
               •   On Windows, you can also start DBCA from the Start menu:
                   Click Start, All Programs, Oracle - OracleHomeName, Configuration and
                   Migration Tools, Database Configuration Assistant.
               •   On Unix systems, you can start DBCA using the following command:
                   $ORACLE_HOME/bin/dbca
               The Welcome screen appears.
          2.   Click Next.
               The Operations screen displays.




                                                                                                    2-4
                                                                                     Chapter 2
                                                  Registering Your Database with the Directory




3.   Select Configure Database Options. Click Next.
     The Database screen appears.
4.   Select the database name that you wish to configure. You might also be asked to
     enter SYS user credentials if you are not using operating system authentication.
     Click Next.
     The Management Options screen appears.
5.   Select the management options, and click Next.
     The Security Settings screen appears.
6.   Select Keep the enhanced 12c default security settings to keep the Oracle
     Database 12c security settings. Click Next.
     The Network Configuration screen appears.




                                                                                         2-5
                                                                                      Chapter 2
                                                   Registering Your Database with the Directory




7.   Select Yes, register the database to register the database with the directory.
     Enter the distinguished name (DN) of a user who is authorized to register
     databases in Oracle Internet Directory. Also, enter the password for the directory
     user. Enter a wallet password. Reenter the password in the Confirm Password
     field. Click Next.



            Note:
            The database uses a randomly generated password to log in to the
            directory. This database password is stored in an Oracle wallet. The
            wallet can also be used to store certificates needed for SSL connections.
            The wallet password that you specify is different from the database
            password. The wallet password is used to protect the wallet.


     The Database Components screen appears.
8.   Click Next.
     The Connection Mode page appears.
9.   Select Dedicated Server Mode or Shared Server Mode. Click Finish.
     The Confirmation dialog box appears.
10. Click OK.




                                                                                          2-6
                                                                                               Chapter 2
                                                   Registering an Oracle RAC Database with the Directory




                 Note:
                 After you register the database with the directory, make sure that auto login
                 is enabled for the database wallet. The default wallet is created in
                 the $ORACLE_BASE/admin/database_sid/wallet directory.

                 You can verify that auto login for the wallet is enabled by checking for the
                 presence of the cwallet.sso file in the wallet directory. If the file is not
                 present, you can enable auto login by opening the wallet using Oracle Wallet
                 Manager, and using the option to enable auto login for the wallet.




2.3 Registering an Oracle RAC Database with the Directory
         Configuring the Oracle Internet Directory (OID) in an Oracle RAC environment
         requires certain additional steps.
         1.   Create the ldap.ora file using NetCA following the steps under Configuring Your
              Database to Use the Directory. Choose Cluster configuration for the entire
              cluster configuration or Single node configuration to create the ldap.ora file in
              one node and copy it to the other remaining nodes. The ldap.ora file is located
              at $ORACLE_HOME/network/admin/ldap.ora.




         2.   Configure the database by running DBCA in silent mode for Oracle RAC
              databases:

              dbca -silent -configureDatabase -sourceDB <DB_name> -
              registerWithDirService <true/false>
              -dirServiceUserName <OracleContext_value> -dirServicePassword <OID_pwd>
              -walletPassword <wallet_pwd>


              DB_name is the name of the source database to configure




                                                                                                   2-7
                                                                                            Chapter 2
                                                             Creating a Shared Schema in the Database


              registerWithDirService is the boolean value that must be set to true for
              configuring the database
              OracleContext_value is the default Oracle Context that is unique for the OID
              OID_pwd is the unique password value for the OID
              wallet_pwd is the user specified wallet password
              For example, for an Oracle RAC database named t2, the DBCA command is as
              follows:

              dbca -silent -configureDatabase -sourceDB t2 -registerWithDirService
              true
              -dirServiceUserName cn=dbcauser,cn=users,dc=us,dc=oracle,dc=com
              -dirServicePassword <OID_pwd> -walletPassword <wallet_pwd>


2.4 Creating a Shared Schema in the Database
         Creating a shared schema in the database enables you to map multiple enterprise
         users to the same schema. Example 2-1creates a shared schema,
         global_ident_schema_user, and grants the CONNECT role to it.

         Example 2-1     Creating a Shared Schema
         SQL> CREATE USER global_ident_schema_user IDENTIFIED GLOBALLY;
         User created.
         SQL> GRANT CONNECT TO global_ident_schema_user;
         Grant succeeded.


2.5 Mapping Enterprise Users to the Shared Schema
         Enterprise User Security can be managed using Enterprise Manager. Example 2-2
         maps the DN, cn=users, dc=us, dc=oracle, dc=com to the shared database
         schema, global_ident_schema_user.

         Example 2-2     Mapping Enterprise Users to the Shared Schema
         To create the user-schema mapping:
         1.   Log in to Enterprise Manager Cloud Control, as an administrative user.
         2.   To navigate to your database, select Databases from the Targets menu.
         3.   Click the database name in the list that appears. The database page appears.
         4.   Under the Administration menu, select Security, Enterprise User Security. The
              Oracle Internet Directory Login page appears.
         5.   Enter the distinguished name (DN) of a directory user who can administer
              enterprise users in the User field. Enter the user password in the Password field.
              Click Login.




                                                                                                2-8
                                                                                              Chapter 2
                                                       Connecting to the Database as an Enterprise User




                     See Also:
                     Registering Your Database with the Directory, specifically Step 6, where
                     you previously entered the user DN and password to register the
                     database with the directory service


              The Enterprise User Security page appears.
         6.   Click Manage Enterprise Domains.
              The Manage Enterprise Domains page appears.
         7.   Select the enterprise domain which contains the database. Click Configure.
              The Configure Domain page appears.
         8.   Click the User-Schema Mappings tab. All user-schema maps that apply to the
              enterprise domain are displayed.
         9.   Click Create.
              The Create Mapping page is displayed.
         10. Under the From section, select Subtree. Click the Search icon. Select the DN,
              cn=Users, dc=us,dc=oracle,dc=com.
         11. Under the To section, enter global_ident_schema_user in the Schema field. Click
              Continue.
              The user-schema mapping is added in the Configure Domain page.
         12. Click OK.


2.6 Connecting to the Database as an Enterprise User
         All users in the mapped Oracle Internet Directory subtree can now connect to the
         database as enterprise users. Example 2-3 shows the cn=orcladmin, cn=users,
         dc=us,dc=oracle,dc=com user connecting to the database.

         Example 2-3      Connecting to the Database as an Enterprise User
         SQL> CONNECT orcladmin
         Enter password:
         Connected.


2.7 Using Enterprise Roles
         Enterprise roles are created in the directory. Enterprise roles contain global roles from
         different databases that are part of the enterprise domain. Enterprise roles are used to
         assign database privileges to enterprise users.
         Example 2-4 creates two enterprise users, Joe and Nina. Both these users are created
         in the subtree, cn=Users, dc=us,dc=oracle,dc=com, which is already mapped to the
         global_ident_schema_user in the EUSDB database. See RFC4519 — Lightweight
         Directory Access Protocol (LDAP) : Schema for User Applications for information
         about the LDAP attribute types shown in the previous subtree example.




                                                                                                  2-9
                                                                                                  Chapter 2
                                                                                     Using Enterprise Roles


               Nina is an HR manager. She needs the SELECT privilege on the hr.employees table in
               the EUSDB database. Example 2-4 achieves this using enterprise roles.
Example 2-4   Using Enterprise Roles
               We start by creating two enterprise users, Joe and Nina. You can create enterprise
               users using the Oracle Internet Directory Self Service Console.
               To create enterprise users, Joe and Nina:
               1.   Connect to the Oracle Internet Directory Self Service Console. Use the following
                    URL:
                    http://hostname:port/oiddas/
                    Here, hostname is the name of the host that is running the Oracle Internet
                    Directory server. The port number is the TCP port number on which the Oracle
                    Internet Directory Self Service Console is running. This is 7777 by default.




               2.   Click the Directory tab.
                    The Sign In page appears.




               3.   Log in as the user that can create users in Oracle Internet Directory.
                    The User page appears.



                                                                                                     2-10
                                                                                  Chapter 2
                                                                     Using Enterprise Roles


4.   Click Create.
     The Create User page appears.




5.   Enter joe under User Name. Enter values for the other required fields. Select
     Enabled under Is Enabled.
6.   Click Submit.
7.   Click Create Another User.
     The Create User page appears.
8.   Enter Nina under User Name. Enter values for the other required fields. Select
     Enabled under Is Enabled.
9.   Click Submit. Click OK.
Next, we create a global role in the database that allows access to the hr.employees
table. The following SQL*Plus statements create a global role, hr_access and grant
the necessary privilege to it.
SQL> CREATE ROLE hr_access IDENTIFIED GLOBALLY;
Role created.
SQL> GRANT SELECT ON hr.employees TO hr_access;
Grant succeeded.

Next, we create an enterprise role called hr_access and assign the global role to it.
We then assign this enterprise role to the enterprise user, Nina. The enterprise role
can be created using Enterprise Manager.
To create the enterprise role, hr_access:

1.   Log in to Enterprise Manager Cloud Control, as an administrative user.
2.   To navigate to your database, select Databases from the Targets menu.




                                                                                     2-11
                                                                                     Chapter 2
                                                                        Using Enterprise Roles


3.   Click the database name in the list that appears. The database page appears.
4.   Under the Administration menu, select Security, Enterprise User Security. The
     Oracle Internet Directory Login page appears.
5.   Enter the distinguished name (DN) of a directory user who can administer
     enterprise users in the User field. Enter the user password in the Password field.
     Click Login.
     The Enterprise User Security page appears.
6.   Click Manage Enterprise Domains.
     The Manage Enterprise Domains page appears. This page lists the enterprise
     domains in the identity management realm.
7.   Select the enterprise domain that contains the database. Click Configure.
     The Configure Domain page appears.
8.   Click the Enterprise Roles tab.
9.   Click Create.
     The Create Enterprise Role page appears.
10. Enter hr_access in the Name field.




11. Click Add to add the database global role to the enterprise role.

     The Search and Select Database Global Roles window is displayed.




                                                                                        2-12
                                                                                    Chapter 2
                                                                       Using Enterprise Roles




12. Select the hr_access global role in your database. Click Select.



           Note:
           You will be required to log in to the database before you can select the
           global role.


13. Click the Grantees tab. Click Add.

    The Select Users or Groups window appears.
14. Select user Nina. Click Select.




15. Click Continue in the Create Enterprise Role page.

16. Click OK in the Configure Domain page.

The enterprise user, Nina can now access the hr.employees table in the database.
The following SQL*Plus statements illustrate this:



                                                                                       2-13
                                                                                                 Chapter 2
                                                                                   Using Proxy Permissions


               SQL> CONNECT Nina
               Enter password:
               Connected.
               SQL> SELECT employee_id FROM hr.employees;
               EMPLOYEE_ID
               -----------
                       100
                       101
                       102
               ...
               ...
               107 rows selected.

               The enterprise user, Joe cannot access the hr.employees table, as he does not have
               the enterprise role assigned to him.
               SQL> CONNECT joe
               Enter password:
               Connected.
               SQL> SELECT employee_id FROM hr.employees;
               SELECT employee_id FROM hr.employees

               ERROR at line 1:
               ORA-00942: table or view does not exist



2.8 Using Proxy Permissions
               Proxy permissions are created at the enterprise domain level. Proxy permissions allow
               an enterprise user to proxy a local database user, which means that the enterprise
               user can log in to the database as the local database user. You can grant proxy
               permissions to individual enterprise users or groups. Proxy permissions are especially
               useful for middle-tier applications that operate across multiple databases as enterprise
               users.
               Example 2-5 illustrates the use of proxy permissions. The enterprise user, joe is a
               sales manager and needs to log in to enterprise databases as the target database
               user, SH. The SH user owns the sample SH schema that contains Sales History related
               tables.
Example 2-5   Using Proxy Permissions
               The first step in allowing enterprise user proxy is to ALTER the target database user to
               allow CONNECT through enterprise users. The following SQL statements unlock the SH
               database account, set a password for it, and ALTER the account to allow enterprise
               user proxy:
               SQL> CONNECT SYSTEM
               Enter password:
               Connected.
               SQL> ALTER USER SH IDENTIFIED BY hrd2guess ACCOUNT UNLOCK;
               User altered.
               SQL> ALTER USER SH GRANT CONNECT THROUGH ENTERPRISE USERS;
               User altered.

               Next, use Enterprise Manager to configure the proxy permission. This allows the
               enterprise user joe to connect as the local database user, SH.

               To configure the proxy permission for enterprise user, joe:




                                                                                                    2-14
                                                                                 Chapter 2
                                                                   Using Proxy Permissions


1.   Log in to Enterprise Manager Cloud Control, as an administrative user.
2.   To navigate to your database, select Databases from the Targets menu.
3.   Click the database name in the list that appears. The database page appears.
4.   Under the Administration menu, select Security, Enterprise User Security. The
     Oracle Internet Directory Login page appears.
5.   Enter the distinguished name (DN) of a directory user who can administer
     enterprise users in the User field. Enter the user password in the Password field.
     Click Login.
     The Enterprise User Security page appears.
6.   Click Manage Enterprise Domains.
     The Manage Enterprise Domains page appears. This page lists the enterprise
     domains in the identity management realm.
7.   Select the enterprise domain that you wish to configure. Click Configure.
     The Configure Domain page appears.
8.   Click the Proxy Permissions tab.




9.   Click Create to create a new proxy permission.
     The Create Proxy Permission page appears.
10. Enter SH_Proxy, as the name of the proxy permission, in the Name field.




                                                                                    2-15
                                                                                   Chapter 2
                                                                     Using Proxy Permissions




11. Ensure that the Target DB Users tab is selected. Click Add.

    The Search and Select window appears.
12. Log in to the database that contains the SH user. A list of all database users that
    have been altered to allow enterprise user proxy is displayed.
13. Select the SH user. Click Select.

    The SH user is added under Target DB Users in the Create Proxy Permission
    page.




                                                                                      2-16
                                                                             Chapter 2
                                                               Using Proxy Permissions


14. Click the Grantees tab.

15. Click Add.

   The Select Users or Groups window appears.
16. Select cn=users,dc=us,dc=oracle,dc=com under Search Base. Select User
   under View. Click Go.
   A list of users under the subtree, cn=users,dc=us,dc=oracle,dc=com is displayed.




17. Select cn=joe,cn=users,dc=us,dc=oracle,dc=com. Click Select.

   The user joe is added under Grantees in the Create Proxy Permission page.




18. Click Continue in the Create Proxy Permission page.

   The proxy permission, SH_Proxy is added in the Configure Domain page.




                                                                                2-17
                                                                                         Chapter 2
                                                                         Using Pluggable Databases




         19. Click OK.

         The enterprise user, joe can now log in as the local database user SH. The following
         SQL statements illustrate this:
         SQL> REMARK Joe uses his own password to connect as the local database user, SH.
         SQL> CONNECT joe[SH]
         Enter password:
         Connected.
         SQL> SELECT * FROM SH.sales WHERE cust_id=4;

             PROD_ID   CUST_ID TIME_ID CHANNEL_ID PROMO_ID QUANTITY_SOLD AMOUNT_SOLD
         ---------- ---------- --------- ---------- ---------- ------------- -----------
                  37         4 31-MAY-00          3        999             1       60.43
                  39         4 31-MAY-00          3        999             1       38.45
                  40         4 31-MAY-00          3        999             1        48.1
         ...
         ...
         72 rows selected.


2.9 Using Pluggable Databases
         You can use Enterprise User Security with Pluggable Databases (PDBs), introduced in
         Oracle Database 12c Release 1 (12.1). Each PDB has its own Enterprise User
         Security metadata, such as global users, global roles, and so on. Each PDB should
         have its own identity in the directory. A PDB is like any regular database registered
         with the directory, except for the following restrictions:
         •   Client-side SSL authentication uses the Container Database (CDB)-wide wallet
             configured for the listener. The PDB-specific wallet is used for database-to-
             directory authentication.
         •   If the client-to-database authentication uses SSL, and the database-to-directory
             authentication also uses SSL, then two wallets need to be configured for the
             database with certificates. The first wallet is the CDB-wide wallet and the second
             wallet is the PDB-specific wallet.
         •   Current user database link is not supported in the CDB environment.




                                                                                            2-18
                                                                                            Chapter 2
                                                                            Using Pluggable Databases




                  Note:
                  Each PDB has it's own value for LDAP_DIRECTORY_ACCESS parameter. The
                  value of the LDAP_DIRECTORY_ACCESS parameter has to be set from a PDB.


           The following sections describe more information about using pluggable databases:
           •   Wallet Location for Pluggable Databases
           •   Wallet Root for Pluggable Databases
           •   Default Database DN Format
           •   Plugging and Unplugging PDBs
           •   Switching Containers


2.9.1 Wallet Location for Pluggable Databases
           For pluggable databases, when a PDB is registered with the directory, the Database
           Configuration Assistant (DBCA) creates the wallet at the following location:
           •   If the ORACLE_BASE environment variable is set:
               ORACLE_BASE/admin/db_unique_name/pdb_GUID/wallet
           •   If ORACLE_BASE is not set:
               ORACLE_HOME/admin/db_unique_name/pdb_GUID/wallet

               The GUID of the PDB is used because the PDB name can change, but the GUID
               does not change. So, the PDB wallet location is still valid even if the PDB name
               changes.



                  Note:
                  On the Microsoft Windows x64 platform, without specifying the
                  WALLET_LOCATION parameter in the listener.ora file and server side
                  sqlnet.ora file, the server does not pick up the wallets from the default
                  system location, which is %USERPROFILE%\ORACLE\WALLETS. Hence, when you
                  try to login using an SSL connection, the login fails with the following error:
                  ORA-28864: SSL connection closed gracefully. There is no workaround
                  to this known issue.



2.9.2 Wallet Root for Pluggable Databases
           WALLET_ROOT specifies the path to the root of a directory tree containing a subdirectory
           for each pluggable database (PDB). The directory structure is similar to the Oracle
           ASM wallet storage directory structure which is used to store the various wallets
           associated with the PDB.
           This example uses the value of ORACLE_BASE environment variable to set the root of
           the wallet directory hierarchy:
           WALLET_ROOT=$ORACLE_BASE/admin/orcl/wallet



                                                                                               2-19
                                                                                               Chapter 2
                                                                               Using Pluggable Databases


             You can also use WALLET_LOCATION to specify the wallet location of your choice. When
             you specify both WALLET_ROOT and WALLET_LOCATION parameters, WALLET_ROOT takes
             the highest precedence. If both parameters are not specified, default wallet location is
             used.



                    Note:
                    This parameter is available starting with Oracle Database release 18c,
                    version 18.1.



                    See Also:
                    WALLET_ROOT



2.9.3 Connecting to a Directory Service
             Previously in a multitenant database, all the containers used to connect to a single
             directory service. You can now connect a different directory service for each pluggable
             database (PDB).

2.9.3.1 Comparison of the dsi.ora and ldap.ora Files
             You can use either dsi.ora or ldap.ora for Enterprise User Security and integration
             with Oracle Internet Directory(OID).
             If you use ldap.ora for Enterprise User Security, you can only specify a single OID
             server for all the containers (PDBs) in a database. However, ldap.ora can also be
             used for net naming services which may or may not be using the same directory
             service. The dsi.ora allows each PDB to integrate with a different OID server if
             needed. While DBCA can be used to configure the ldap.ora, the dsi.ora needs to be
             created manually.

2.9.3.2 About Using a dsi.ora File
             You use a dsi.ora file to specify the Oracle Internet Directory(OID) server.

             You must manually create the dsi.ora file to identify the OID server. The dsi.ora file
             provides directory connection information for all pluggable databases if it is located in
             the same places where the ldap.ora file can be placed. A dsi.ora file in a PDB-
             specific wallet location takes precedence over the main dsi.ora file for that PDB only.



                    Note:
                    If you are using ldap.ora for naming services, then do not make any
                    changes to ldap.ora for the directory configuration. Only use dsi.ora to
                    configure OID.




                                                                                                  2-20
                                                                                      Chapter 2
                                                                      Using Pluggable Databases




Placement of dsi.ora
Oracle recommends that you use directories for writable files under $ORACLE_BASE, not
under $ORACLE_HOME. Starting with Oracle Database 18c, you can optionally set
the $ORACLE_HOME directory to be read-only. Hence, you should place the dsi.ora file
in a directory that is outside of $ORACLE_HOME to accommodate the dsi.ora
configuration for future releases.

Search Order for dsi.ora
When you create the dsi.ora file, Oracle Database searches for it in the following
order:
1.   For a PDB, Oracle searches for it in the PDB-specific wallet location.
     a.   If WALLET_ROOT is specified in init.ora, the PDB-specific wallet location is at
          WALLET_ROOT/pdb_guid/eus/
     b.   If WALLET_ROOT is not specified in init.ora, and if WALLET_LOCATION is
          specified in sqlnet.ora, the PDB-specific wallet location is at
          WALLET_LOCATION/pdb_guid/
     c.   If neither WALLET_ROOT or WALLET_LOCATION is specified, the PDB-specific
          wallet location is the default location, that is:
          i.    If the ORACLE_BASE environment variable is set, the default location is:

                ORACLE_BASE/admin/db_unique_name/pdb_guid/wallet/

          ii.   If ORACLE_BASE is not set, the default location is:

                ORACLE_HOME/admin/db_unique_name/pdb_guid/wallet/

2.   If Oracle Database cannot find dsi.ora in the wallet location, then Oracle
     Database searches for it in the following order. These are the same locations that
     Oracle Database searches for the ldap.ora file.
     a.   $LDAP_ADMIN environment variable setting
     b.   $ORACLE_HOME/ldap/admin directory
     c.   $TNS_ADMIN environment variable setting
     d.   $ORACLE_HOME/network/admin directory

When to Use dsi.ora
Oracle recommends that you use only dsi.ora to connect to a different OID service
for each PDB . If both dsi.ora and ldap.ora are configured in the same database and
are both located in the same directory, then dsi.ora takes precedence over the
ldap.ora file. If they are in different directories, then Oracle uses the first one that it
finds in the location precedence list above to find the directory server.
The default wallet location for a PDB is the $ORACLE_BASE/admin/db_unique_name/
pdb_guid/wallet/ directory.

To find the db_unique_name, connect to the CDB root and execute the following query:
SELECT DB_UNIQUE_NAME FROM V$DATABASE;




                                                                                           2-21
                                                                                                   Chapter 2
                                                                                  Using Pluggable Databases


              To find the pdb_guid, from the CDB root, execute the following query:
              SELECT PDB_NAME,GUID FROM DBA_PDBS;


2.9.3.3 Creating the dsi.ora File
              The dsi.ora configuration file sets the information to find the directory server.

              To use the dsi.ora configuration file:
              1.   Log in to the host where the Oracle database is located.
              2.   Locate the wallet location directory to place the dsi.ora file. See Search Order for
                   dsi.ora for more information on wallet location. Create the directory for the wallet
                   location if it does not exist. Go to the wallet location directory to create the dsi.ora
                   file.
              3.   Add the following parameters to the dsi.ora file:
                   •   DSI_DIRECTORY_SERVERS, which sets the Directory server host and port
                       number, and alternate directory servers. The directory server name must be a
                       fully qualified name. For example:

                       DSI_DIRECTORY_SERVERS = (ldap-server.examplecorp.com:389:636,
                       raffles.examplecorp.com:389:636)

                   •   DSI_DEFAULT_ADMIN_CONTEXT, specifies the default directory for the creation,
                       modification, or search of the connect identifiers. For example:

                       DSI_DEFAULT_ADMIN_CONTEXT = "o=OracleSoftware,c=US"

                   •   DSI_DIRECTORY_SERVER_TYPE, which determines the directory server access.
                       You must set it to OID for Oracle Internet Directory. Enter this value in upper
                       case.

                       DSI_DIRECTORY_SERVER_TYPE = OID


2.9.3.4 About Using an ldap.ora File
              You can use an ldap.ora file to specify the directory server.

              If you are already using an ldap.ora file for another purpose such as net naming
              services, then you must use the dsi.ora file to configure the directory for user
              authentication and authorization. Even if the database currently is not using ldap.ora
              for another service, Oracle recommends using dsi.ora in case ldap.ora will be used
              at a future time for net naming services.
              If ldap.ora is being used for naming services, then do not make any changes to
              ldap.ora. Only use dsi.ora to configure the directory.

              Benefit of Using ldap.ora
              The benefit of using ldap.ora is that you can use the DBCA graphical interface or the
              DBCA silent mode to complete configuring the connection to the directory servers.
              When using dsi.ora, the steps to complete configuring the connection to the directory
              must be done separately.




                                                                                                     2-22
                                                                                                  Chapter 2
                                                                                  Using Pluggable Databases


             Once you configure a PDB using DBCA with a ldap.ora, you can create an individual
             dsi.ora in the PDB-specific wallet location for that PDB. Move the contents of
             ldap.ora into the corresponding dsi.ora with DSI_ prefix added to each parameter in
             dsi.ora.

             Later, you can update ldap.ora with different OID servers. After you update ldap.ora,
             use DBCA to configure another PDB, and move the contents of ldap.ora into the
             dsi.ora in the PDB-specific wallet location for that PDB. Repeat the process to
             configure every PDB so that each PDB can connect to different OID servers.

             Placement of ldap.ora
             Typically, the ldap.ora file is stored in the $ORACLE_HOME/network/admin directory.

             Search Order for ldap.ora
             After you create the ldap.ora file, Oracle Database searches for it in the following
             order:
             1.   $LDAP_ADMIN environment variable setting
             2.   $ORACLE_HOME/ldap/admin directory
             3.   $TNS_ADMIN environment variable setting
             4.   $ORACLE_HOME/network/admin directory

             Changing the Contents of ldap.ora
             If you change the contents of ldap.ora after database has been started, then you
             must either restart the database instance or re-execute the following DDL to make the
             updated content in ldap.ora effective:
             ALTER SYSTEM SET LDAP_DIRECTORY_ACCESS = 'PASSWORD';


2.9.3.5 Creating the ldap.ora File
             These steps assume that ldap.ora is not being used for net naming services and can
             be used to set up the connection with the directory.
             1.   Log in to the host where the Oracle database is located.
             2.   Choose a directory where to use the ldap.ora file, based on the search order for
                  the ldap.ora file. (See Related Topics.) If this directory does not exist, then create
                  the directory. Then go to this directory to create the ldap.ora file.
             3.   If the ldap.ora file does not exist, then create it by using a text editor.
                  If the ldap.ora file does exist, create a backup of this file, and then
                  open ldap.ora.
             4.   Add the following parameters to the ldap.ora file:
                  •   DSI_DIRECTORY_SERVERS, which sets the Directory server host and port
                      number, and alternate directory servers. The directory server name must be a
                      fully qualified name. For example:

                      DIRECTORY_SERVERS = (ldap-server.examplecorp.com:389:636,
                      raffles.examplecorp.com:389:636)




                                                                                                     2-23
                                                                                             Chapter 2
                                                                            Using Pluggable Databases


               •   DEFAULT_ADMIN_CONTEXT, specifies the default directory for the creation,
                   modification, or search of the connect identifiers. For example:

                   DEFAULT_ADMIN_CONTEXT = "o=OracleSoftware,c=US"

               •   DIRECTORY_SERVER_TYPE, which determines the LDAP server access. You
                   must set it to OID for Enterprise User Security. Enter this value in upper case.

                   DIRECTORY_SERVER_TYPE = OID


2.9.4 Default Database DN Format
           When a PDB is registered with the directory using DBCA, the default PDB
           Distinguished Name (DN) is generated in the following format:
           cn=PDB_NAME.DB_UNIQUE_NAME,cn=oraclecontext,realm

           You can change the default cn (PDB_NAME.DB_UNIQUE_NAME) to a custom value
           in the DBCA registration screen. It cannot be altered after registration.


2.9.5 Plugging and Unplugging PDBs
           You can plug existing registered databases into a CDB. You do not need to register
           the PDB again, as long as you perform the following steps:
           •   Pick the wallet files from the source location and put them in the new default wallet
               location for the PDB.
           •   Set the LDAP_DIRECTORY_ACCESS parameter to the desired value in the PDB.
           Similarly, when unplugging an existing PDB that is registered with the directory, you do
           not need to re-register the database. You need to copy the wallet to the new default
           location after unplug. The default location should be:
           •   If the ORACLE_BASE environment variable is set:
               ORACLE_BASE/admin/db_unique_name/pdb_guid/wallet
           •   If ORACLE_BASE is not set:
               ORACLE_HOME/admin/db_unique_name/pdb_guid/wallet


2.9.6 Switching Containers
           An Enterprise User cannot execute the ALTER SESSION SET CONTAINER target-CDB
           command, as an enterprise user is not a common user.




                                                                                               2-24
3
Configuration and Administration Tools
Overview
         Configuring Enterprise User Security for an Oracle database primarily involves
         creating directory objects to store enterprise user and database information. For some
         implementations, it can also require creating special network configuration files
         (ldap.ora) that enable your databases to locate the correct directory server on the
         network.
         While Oracle Enterprise Manager is your primary tool for both configuring Enterprise
         User Security and for administration tasks, this chapter introduces all the available
         tools, in the following topics:
         •   Enterprise User Security Tools Overview
         •   Database Configuration Assistant
         •   Oracle Wallet Manager
         •   Oracle Enterprise Manager
         •   Oracle Net Configuration Assistant
         •   User Migration Utility
         •   Duties of an Enterprise User Security Administrator/DBA


3.1 Enterprise User Security Tools Overview
         Enterprise users are database users whose identities are stored and centrally
         managed in an LDAP directory, such as Oracle Internet Directory. Table 3-1 provides
         a summary of Enterprise User Security configuration and management tasks and the
         tools to complete them. The tool names are links to sections that describe them.

         Table 3-1    Enterprise User Security Tasks and Tools Summary

          Task                                    Tools
          Create users and manage their           Oracle Internet Directory Self-Service Console
          passwords
          Configure databases Oracle home for     Oracle Net Configuration Assistant
          directory usage over the network
          Register and un-register databases in   Database Configuration Assistant
          Oracle Internet Directory
          Manage Oracle wallets for Enterprise    Oracle Wallet Manager
          User Security




                                                                                                   3-1
                                                                                                  Chapter 3
                                                             Oracle Internet Directory Self-Service Console




          Table 3-1    (Cont.) Enterprise User Security Tasks and Tools Summary

          Task                                   Tools
          •   Configure enterprise domains and Oracle Enterprise Manager
              databases in Oracle Internet
              Directory including mappings, roles
              and proxy permissions
          •   Manage identity management
              realm attributes and administrative
              groups that pertain to Enterprise
              User Security in Oracle Internet
              Directory
          Manage identity management realms in Oracle Internet Directory Self-Service Console
          Oracle Internet Directory
          For information about this tool and
          realms, refer to Oracle Identity
          Management Guide to Delegated
          Administration.
          Perform bulk migrations of database    User Migration Utility
          users to Oracle Internet Directory



3.2 Oracle Internet Directory Self-Service Console
          Oracle Internet Directory Self-Service Console is a tool based on Delegated
          Administration Services. This is a self service application that allows administrated
          access to the applications data managed in the directory. This tool comes ready to use
          with Oracle Internet Directory.
          The Oracle Identity Management Guide to Delegated Administration discusses
          Delegated Administration Services and the Oracle Internet Directory Self-Service
          Console tool.


3.3 Oracle Net Configuration Assistant
          Oracle Net Configuration Assistant is a wizard-based tool with a graphical user
          interface. Its primary uses are to configure basic Oracle Net network components,
          such as listener names and protocol addresses, and to configure your Oracle home for
          directory server usage. The latter use is what makes this tool important for configuring
          Enterprise User Security.
          If you use Domain Name System (DNS) discovery (automatic domain name lookup) to
          locate Oracle Internet Directory on your network, then this assistant is not necessary.
          Note that using DNS discovery is the recommended configuration.
          Before you can register a database with the directory, you must do either one of the
          following two tasks:
          •   Configure DNS discovery of Oracle Internet Directory on your network.




                                                                                                      3-2
                                                                                                Chapter 3
                                                                       Oracle Net Configuration Assistant




                         See Also:
                         Oracle Fusion Middleware Administrator's Guide for Oracle Internet
                         Directory for information about DNS server discovery


            •   If DNS discovery is not configured on your network, then use Oracle Net
                Configuration Assistant to create an ldap.ora file for your Oracle home.
            Your database initially uses the ldap.ora file to locate the correct Oracle Internet
            Directory server on your network. This configuration file contains the hostname, port
            number, and identity management realm information for your directory server.
            Once database registration is complete, the realm is ascertained through the database
            DN stored in the database wallet.
            The following section describes more information about Oracle Net Configuration
            Assistant: Starting Oracle Net Configuration Assistant.


3.3.1 Starting Oracle Net Configuration Assistant
            To start Oracle Net Configuration Assistant:
            •   (UNIX) From $ORACLE_HOME/bin, enter the following at the command line:
                netca
            •   (Windows) Choose Start, Programs, Oracle-HOME_NAME, Configuration and
                Migration Tools, Net Configuration Assistant
            After you start this tool, you will be presented with the opening page shown in
            Figure 3-1.
            Choose the Directory Usage Configuration option on this page, click Next, and
            choose the directory server where you wish to store your enterprise users. Then, click
            Finish to create a properly configured ldap.ora file for your Oracle home.


            Figure 3-1     Opening Page of Oracle Net Configuration Assistant




                                                                                                    3-3
                                                                                               Chapter 3
                                                                       Database Configuration Assistant




                  See Also:

                  •   "Task 5: (Optional) Configure your Oracle home for directory usage" for
                      more information about using this tool to configure your Oracle home for
                      Enterprise User Security
                  •   Oracle Net Configuration Assistant online help and Oracle Database Net
                      Services Administrator's Guide for a complete documentation of this tool



3.4 Database Configuration Assistant
           Database Configuration Assistant is a wizard-based tool used to create and configure
           Oracle databases.
           Use Database Configuration Assistant to register a database with the directory. In that
           process, Database Configuration Assistant creates a distinguished name (DN) for the
           database and the corresponding entry and subtree in Oracle Internet Directory.
           The following section describes more information about Database Configuration
           Assistant: Starting Database Configuration Assistant.


3.4.1 Starting Database Configuration Assistant
           To start Database Configuration Assistant:
           •   (UNIX) From $ORACLE_HOME/bin, enter dbca at the command line:
           •   (Windows) Choose Start > Programs > Oracle - HOME_NAME > Configuration
               and Migration Tools > Database Configuration Assistant



                      See Also:

                      –   "To register a database with the directory:" for information about
                          using this tool to register your database
                      –   Oracle Database Administrator’s Guide for more information about
                          this tool



3.5 Oracle Wallet Manager
           Security administrators use Oracle Wallet Manager, which is an application that wallet
           owners use to manage and edit the security credentials in their Oracle wallets. A wallet
           is a password-protected container used to store authentication and signing credentials,
           including private keys, certificates, and trusted certificates needed by SSL The wallets
           it creates can be read by Oracle Database, Oracle Application Server 10g, and the
           Oracle Identity Management infrastructure.




                                                                                                   3-4
                                                                                                     Chapter 3
                                                                                     Oracle Enterprise Manager




                     See Also:
                     Using Oracle Wallet Manager



           This section includes the following topics:
           •    Starting Oracle Wallet Manager
           •    The orapki Command-Line Utility


3.5.1 Starting Oracle Wallet Manager
           To start Oracle Wallet Manager:
           •    (Windows) Select Start, Programs, Oracle-HOME_NAME, Integrated
                Management Tools, Wallet Manager
           •    (UNIX) At the command line, enter owm.


3.5.2 The orapki Command-Line Utility
           The orapki command-line utility enables administrators to manage wallets, certificate
           revocation lists, and other public key infrastructure (PKI) elements from the command
           line. It can be used inside scripts, enabling administrators to automate many routine
           PKI tasks. The orapki commands enable you to do the following tasks:

           Table 3-2      Summary of orapki Commands

            Object Affected                        Operations Possible with orapki Commands
            Certificate                            Create or display
            CRL (certificate revocation list)      Delete, display, hash, list, or upload
            Wallet                                 Create, display, add, or export



                     See Also:
                     orapki Utility in the Oracle Database Security Guide




3.6 Oracle Enterprise Manager
           Enterprise User Security employs Oracle Enterprise Manager to administer enterprise
           users, administrative groups, enterprise domains, and enterprise roles stored in Oracle
           Internet Directory. You can use the Web-based user interface provided by Oracle
           Enterprise Manager to administer Enterprise User Security.
           Enterprise users are users provisioned and managed centrally in an LDAP-compliant
           directory, such as Oracle Internet Directory, for database access. Enterprise domains
           are directory constructs containing databases, enterprise roles (the access privileges




                                                                                                         3-5
                                                                                               Chapter 3
                                                                                   User Migration Utility


          assigned to enterprise users), and proxy permissions (which enable enterprise users
          to connect to databases as other users).



                  See Also:
                  Introducing Enterprise User Security for a discussion of Enterprise User
                  Security administrative groups, enterprise domains, enterprise roles,
                  enterprise users, shared schemas, and user-schema mappings



          Use the following steps to access the Enterprise User Security link in Oracle
          Enterprise Manager Cloud Control:
          1.   Enter the URL for Cloud Control in a browser window. For example:
               https://mydbhost:1158/em
          2.   Log in as an administrative database user.
          3.   To navigate to your database, select Databases from the Targets menu.
          4.   Click the database name in the list that appears. The database page appears.
          5.   Under the Administration menu, select Security, Enterprise User Security. The
               Oracle Internet Directory Login page appears.
          6.   Enter the distinguished name (DN) of a directory user, who has administrative
               privileges for the identity management realm, in the User field. Enter the user
               password in the Password field. Click Login.
               The Enterprise User Security page appears.


3.7 User Migration Utility
          User Migration Utility is a command-line tool that enables you to perform bulk
          migrations of database users to Oracle Internet Directory where they are stored and
          managed as enterprise users. This tool performs a bulk migration in two phases: In
          phase one, it populates a table with database user information. During phase two, the
          database user information is migrated to the directory.
          This tool is automatically installed in the following location when you install an Oracle
          Database client:
          $ORACLE_HOME/rdbms/bin/umu

          The basic syntax for this utility is as follows:
          umu parameter_keyword_1=value1:value2

          parameter_keyword_2=value
          parameter_keyword_3=value1:value2:value3
          ...
          parameter_keyword_n=value

          Note that when a parameter takes multiple values, they are separated with colons (:).




                                                                                                    3-6
                                                                                                               Chapter 3
                                                                 Duties of an Enterprise User Security Administrator/DBA




                             See Also:
                             Using the User Migration Utility for complete instructions (including usage
                             examples) for using this tool to migrate database users to a directory




3.8 Duties of an Enterprise User Security Administrator/DBA
                   Enterprise User Security administrators plan, implement, and administer enterprise
                   users. Table 3-3 lists the primary tasks of Enterprise User Security administrators, the
                   tools used to perform the tasks, and the links to where the tasks are documented.

Table 3-3    Common Enterprise User Security Administrator Configuration and Administrative
Tasks

Task                               Tools Used                  See Also
Create an identity management      Oracle Internet Directory Oracle Fusion Middleware Administrator's Guide for
realm in Oracle Internet           Self-Service Console      Oracle Internet Directory for information about how
Directory                          (Delegated Administration to perform this task
                                   Service)
Upgrade an identity                Oracle Internet Directory   Oracle Fusion Middleware Administrator's Guide for
management realm in Oracle         Configuration Assistant     Oracle Internet Directory and the online Help for this
Internet Directory                                             tool
Set up DNS to enable automatic Oracle Internet Directory       Oracle Fusion Middleware Administrator's Guide for
discovery of Oracle Internet     Configuration Assistant       Oracle Internet Directory (Domain Name System
Directory over the network. Note                               server discovery) and the online Help for this tool
that this is the recommended
configuration.
Create an ldap.ora file to         Oracle Net Configuration    "Task 5: (Optional) Configure your Oracle home for
enable directory access            Assistant                   directory usage"
Register a database in the         Database Configuration      "Task 6: Register the database in the directory"
directory                          Assistant
Configure password                 Oracle Enterprise           "Configuring Enterprise User Security for Password
authentication for Enterprise      Manager                     Authentication"
User Security
Configure Kerberos                 •   Oracle Internet        "Configuring Enterprise User Security for Kerberos
authentication for Enterprise          Directory Self-Service Authentication"
User Security                          Console (Delegated
                                       Administration
                                       Service)
                                   •   Oracle Enterprise
                                       Manager
Configure SSL authentication       •   Oracle Net Manager      "Configuring Enterprise User Security for SSL
for Enterprise User Security       •   Oracle Enterprise       Authentication"
                                       Manager
                                   •   Oracle Wallet
                                       Manager
Create or modify user entries      Oracle Internet Directory •     "Administering Identity Management Realms"
and Oracle administrative          Self-Service Console      •     "Administering Enterprise Users"
groups in the directory            (Delegated Administration
                                   Service)




                                                                                                                   3-7
                                                                                                               Chapter 3
                                                                 Duties of an Enterprise User Security Administrator/DBA




Table 3-3 (Cont.) Common Enterprise User Security Administrator Configuration and
Administrative Tasks

Task                              Tools Used                 See Also
Create or modify enterprise       Oracle Enterprise          •     "Administering Enterprise Domains"
roles and domains in the          Manager                    •     "Configuring Enterprise Roles"
directory
Create or modify wallets for      •    Oracle Wallet         •     "Managing Oracle Wallets"
directory, databases, and clients      Manager               •     Oracle Database Security Guide for information
                                  •    orapki command line         about orapki Utility
                                       utility
Change a user's database or       Oracle Internet Directory "Setting Enterprise User Passwords"
directory password                Self-Service Console
                                  (Delegated Administration
                                  Service)
Change a database's directory     Database Configuration     "To change the database's directory password:"
password                          Assistant
Manage user wallets on the      Oracle Wallet Manager        "Managing Oracle Wallets"
local system or update database
and directory wallet passwords
Request initial Kerberos ticket   okinit utility             Oracle Database Security Guide for information
when KDC is not part of the                                  about using the okinit utility to get an initial
operating system, such as                                    Kerberos ticket
Kerberos V5 from MIT
Migrate large numbers of local    User Migration Utility     Using the User Migration Utility
or external database users to
the directory for Enterprise User
Security




                                                                                                                   3-8
4
Enterprise User Security Configuration
Tasks and Troubleshooting
         This chapter describes configuring Enterprise User Security using a sequence of
         steps. They include the initial database and directory preparation through connecting
         to the database as an enterprise user, where authentication can use passwords,
         Kerberos tickets, or SSL. A troubleshooting section helps you when you test your
         Enterprise User Security implementation.
         This chapter contains the following topics:
         •   Enterprise User Security Configuration Overview
         •   Enterprise User Security Configuration Roadmap
         •   Preparing the Directory for Enterprise User Security (Phase One)
         •   Configuring Enterprise User Security Objects in the Database and the Directory
             (Phase Two)
         •   Configure Enterprise User Security for the Authentication Method You Require
             (Phase Three)
         •   Enabling Current User Database Links
         •   Troubleshooting Enterprise User Security


4.1 Enterprise User Security Configuration Overview
         Configuring Enterprise User Security means creating shared schemas and global roles
         in databases that you want accessible to enterprise users. You configure the identity
         management realm in the directory to reflect those database roles and schemas, and
         then associate directory users with them. These steps apply regardless of the
         authentication method you choose: password, Kerberos, or SSL.
         The primary configuration differences among the authentication types are in network
         connection configuration. You must consider the following three connection types:
         •   Client-to-database
         •   Database-to-directory
         •   Database-to-database (current user database links can be secured by SSL only)
         Enterprise User Security supports many combinations of authentication types between
         databases, directories, and clients. The three most common implementations of
         Enterprise User Security, described in this chapter, use the following authentication
         methods for client-database and database-directory connections:
         •   Passwords for both connections
         •   SSL for both connections
         •   Kerberos for client-database connections and passwords for database-directory
             connections



                                                                                            4-1
                                                                                      Chapter 4
                                                Enterprise User Security Configuration Overview


You decide which of these to choose based primarily on your network environment,
because the security and integrity of your enterprise data depend on creating secure
network connections. Typical network environments can have all clients, databases,
and directories residing within the same network behind a firewall, or distributed
across several networks and perhaps exposed to the Internet. Different environments
can dictate what authentication types you choose, in order to secure your Enterprise
User Security network connections.
A second consideration in making such choices is the fact that more rigorous
authentication types, such as SSL and Kerberos, require greater configuration
complexity, additional software, and ongoing maintenance.
Figure 4-1 shows the configuration process for Enterprise User Security. It is a step-
by-step process with decision points based on your implementation and how your
users are authenticated. The configuration steps represented with broken lines are
optional.




                                                                                          4-2
                                                                                                                                       Chapter 4
                                                                                     Enterprise User Security Configuration Overview


Figure 4-1    Enterprise User Security Configuration Flow Chart

 Configuration Started
                                         OID DAS: Set
     What OID version                    Login Name
     and realm Oracle                    attribute, user         EM: Set DB-OID             DBCA: Register             Are you using
     Context version Are you             and group               authentication             the database               the default
     do you           using DNS          search bases for        type for the               in the                     enterprise
     have?                                                       IM Realm                   directory                  domain?
            9.0.4 or discovery?          the IM Realm.
            later           Yes

        9.2 or              No
        earlier                                                                               No                          Yes
                                                                                                   EM: Create a new
                                                                                                   enterprise domain
                                                                                                   in the realm and
                                                                                                   put the database          EM: Set the
                                                                                                   into it                   user
     Upgrade OID         NetCA:                                                                                              authentication
     or Create           Create                                                                                              type for the
                                                  OID DAS: Set the Attribute for Kerberos                                    enterprise
     or upgrade          ldap.ora file            Principal Name in the IM realm, and the
     a realm Oracle                                                                                                          domain in the
                                                  principal names for the users in the                                       directory.
     Context in OID                               user entries in OID                                Kerberos


                                                                                                                             How are users
                                                                                                     Password                authenticated?


                                                                OWM, Netmgr: Set up                  SSL
                                         OWM, ODM: Set          user and DB wallets, and
                                         up OID wallet, and     configure SSL for client
                                         configure SSL          and DB.
                                         for OID.

                  SQL:Create                                     EM: Create user-           EM: Add global             EM: Grant
                  global schema                                  schema mappings            database roles to          enterprise roles
                  and global roles                               and enterprise roles       enterprise roles in        to enterprise users
                  in the database                                in the directory.          the directory.             in the directory.




                                                                       How are users
                                            SSL or Kerberos            authenticated?


             At a SQL prompt, use:                                  Password                                           Connect to the
             CONNECT                                                                                                   database as an
             /@<net_service_name>                                     At a SQL prompt, use:                            enterprise user.
                                                                      CONNECT
                                                                      username/password@<net_service_name>
                                                                 Configuration Finished




                      For brevity, some product names and features have been abbreviated in this flow
                      chart. The following table lists the abbreviations used and the meaning of each:


                      Abbreviation                       Meaning
                      DBCA                               Database Configuration Assistant
                      EM                                 Oracle Enterprise Manager
                      IM Realm                           Identity Management Realm
                      Netmgr                             Oracle Net Manager
                      ODM                                Oracle Directory Manager
                      OID                                Oracle Internet Directory




                                                                                                                                             4-3
                                                                                                 Chapter 4
                                                            Enterprise User Security Configuration Roadmap




          Abbreviation                Meaning
          OID DAS                     Oracle Internet Directory Delegated Administration Services
          OWM                         Oracle Wallet Manager
          SQL                         SQL*Plus



                   See Also:
                   Introducing Enterprise User Security for information about the realm Oracle
                   Context, its administrative groups, and entries that pertain to Enterprise User
                   Security




4.2 Enterprise User Security Configuration Roadmap
          This section provides detailed descriptions of the configuration steps that Figure 4-1
          illustrates. They should be performed in the following order:
          1.   "Preparing the Directory for Enterprise User Security (Phase One)"
          2.   "Configuring Enterprise User Security Objects in the Database and the Directory
               (Phase Two)"
          3.   "Configure Enterprise User Security for the Authentication Method You Require
               (Phase Three)", which completes your Enterprise User Security configuration by
               establishing your chosen authentication method as one of the following three:
               •   "Configuring Enterprise User Security for Password Authentication"
               •   "Configuring Enterprise User Security for Kerberos Authentication"
               •   "Configuring Enterprise User Security for SSL Authentication"


4.3 Preparing the Directory for Enterprise User Security
(Phase One)
          This configuration phase must be performed before you can configure any other part
          of Enterprise User Security.
          Enterprise User Security for 12c Release 1 (12.1) requires Release 9.0.4 (or later)
          version of Oracle Internet Directory, which installs with the required version of the
          Oracle schema. This schema is backward compatible. After you have installed Oracle
          Internet Directory, perform the following directory usage configuration tasks:
          •    Task 1: (Optional) Create an identity management realm in the directory
          •    Task 2: (Optional) Set identity management realm properties
          •    Task 3: Identify administrative users in the directory
          •    Task 4: (Optional) Set the default database-to-directory authentication type for the
               identity management realm
          •    Task 5: (Optional) Configure your Oracle home for directory usage




                                                                                                     4-4
                                                                                         Chapter 4
                                  Preparing the Directory for Enterprise User Security (Phase One)


•   Task 6: Register the database in the directory

Task 1: (Optional) Create an identity management realm in the directory
If necessary, use Oracle Internet Directory Self-Service Console (Delegated
Administration Service) to create an identity management realm in the directory. You
can use Oracle Internet Directory Configuration Assistant to upgrade an Oracle9i
Oracle Context to a 9.0.4 or higher version Identity Management Realm.
You must have version 9.0.4 (or later) identity management realm to use Oracle
Database 10g or Oracle Database 11g. Version 9.0.4 realms are backward compatible
to Oracle9i, so you can register Oracle9i and Oracle Database 12c Release 1 (12.1) in
the same realm and place them in the same domain, if desired.



       See Also:
       Oracle Identity Management Guide to Delegated Administration for more
       information on creating identity management realms in Oracle Internet
       Directory



Task 2: (Optional) Set identity management realm properties
Table 4-1 shows the defaults for a version 9.0.4 identity management realm.

Table 4-1   Identity Realm Defaults

User Search Base          Group Search Base             Login Name Attribute (nickname)
cn=Users,realm_DN         cn=Groups,realm_DN            uid, the user id

If you want different settings, then use Oracle Internet Directory Self-Service Console
to set the user search base, group search base, and login name attribute (nickname).
You can also set up the necessary context administrators in the identity management
realm you plan to use in the directory.
To perform this task, see "Setting Properties of an Identity Management Realm".



       Note:
       Each identity management realm includes an orcladmin user who is the root
       user of that realm only. These realm-specific orcladmin users are
       represented by the directory entries cn=orcladmin,cn=Users,<realm_DN>.
       Note that when you are logged in to Enterprise User Security administration
       tools as a realm-specific orcladmin user, then you can only manage directory
       objects for that realm. To manage objects in another realm, you must log in
       to administration tools as the orcladmin user for that realm.



Task 3: Identify administrative users in the directory
Identify administrative users in the directory who are authorized to perform the
following tasks:




                                                                                             4-5
                                                                                          Chapter 4
                                   Preparing the Directory for Enterprise User Security (Phase One)


•   Register databases
•   Administer database security
•   Create and manage enterprise domains
If administrative users do not already exist who can perform these tasks, then see
Administering Enterprise User Security to create them.



       Note:
       Although one administrator can perform all Enterprise User Security
       administrative tasks, you can create many different kinds of administrators so
       security tasks can be assigned to different people. Separating security tasks
       in this way results in a more secure enterprise environment, but this requires
       coordination among the different administrators.



Task 4: (Optional) Set the default database-to-directory authentication type for
the identity management realm
By default, the database-to-directory authentication type for the identity management
realm is set to passwords. If you want a different default setting, then use the Oracle
Enterprise Manager interface to change it. For example, if you are using a public key
infrastructure (PKI), then you would need to set the authentication type to SSL. See
"Setting the Default Database-to-Directory Authentication Type for an Identity
Management Realm".



       Note:

       •   This default realmwide setting can be overridden on a database by
           setting the LDAP_DIRECTORY_ACCESS initialization parameter. See Oracle
           Database Reference for more information about this parameter.
       •   If you are using SSL, then see Oracle Fusion Middleware Administrator's
           Guide for Oracle Internet Directory for information about setting up SSL
           with two-way authentication for Oracle Internet Directory.


Task 5: (Optional) Configure your Oracle home for directory usage
This step is optional because users of Domain Name System (DNS) discovery
(automatic domain name lookup to locate the directory on a network) do not need to
perform this step. (See Oracle Fusion Middleware Administrator's Guide for Oracle
Internet Directory for information about DNS server discovery.)
If you are not using DNS discovery, then you must use Oracle Net Configuration
Assistant (NetCA) to create an ldap.ora file for your Oracle home. This configuration
file specifies the directory host and port information, and the location of the identity
management realm so the database can connect to the directory. (See "Starting
Oracle Net Configuration Assistant")
To create an ldap.ora file for your Oracle home:




                                                                                              4-6
                                                                                         Chapter 4
                                  Preparing the Directory for Enterprise User Security (Phase One)


1.   In the Oracle Net Configuration Assistant welcome page, choose Directory
     Service Usage Configuration, and click Next.
2.   On the Directory Usage Configuration page, select an option appropriate for your
     environment. Then follow the prompts in the wizard and refer to the online Help to
     create an ldap.ora file for your Oracle home.



            Note:

            •   SSL authentication between your database and directory requires
                that the SSL port entered in the ldap.ora file support two-way
                authentication, in which both client and server send certificates to
                each other. Thus, you must acquire a PKI digital certificate and
                wallet for Oracle Internet Directory, and bring up Oracle Internet
                Directory in the SSL mutual authentication mode. The second port in
                the ldap.ora file should have the SSL mutual authentication port.
                (See Oracle Fusion Middleware Administrator's Guide for Oracle
                Internet Directory.)
            •   If you are using password authentication for your database-to-
                directory connection, then the SSL port entered in the ldap.ora file
                must support SSL with no authentication. No wallet or certificate is
                required for Oracle Internet Directory. The second port in the
                ldap.ora file should have the SSL no authentication port.




        See Also:
        "Configuring Your Database to Use the Directory" for an example of using
        NetCA to configure directory usage



Task 6: Register the database in the directory
After you have configured your Oracle home for directory usage, use Database
Configuration Assistant to register the database in the directory. Registration creates
an entry in the directory so the database can bind (log in) to it.



        Note:
        To perform this task, you must be the directory superuser or a member of
        either the OracleDBCreators group or the OracleContextAdmins group.



When registering a database in the directory, Database Configuration Assistant
performs the following configuration tasks:
•    Creates a new database service entry and subtree, and assigns a DN to it in the
     Oracle Context for the identity management realm you are using.
•    Adds the database to the default enterprise domain.




                                                                                             4-7
                                                                                         Chapter 4
                                  Preparing the Directory for Enterprise User Security (Phase One)


•    Establishes the authentication type of the database to the directory by setting the
     LDAP_DIRECTORY_ACCESS parameter to one of the three allowable settings: NONE,
     PASSWORD, or SSL. Database Configuration Assistant reads the default database to
     directory authentication attribute setting for the identity management realm to
     determine the authentication type setting for the database.
     The LDAP_DIRECTORY_ACCESS parameter, residing in the database initialization
     parameter file, determines whether and how the database attempts authentication
     to the directory. An administrator can change this authentication type setting by
     using the ALTER SYSTEM command.
•    Creates a database wallet, containing the database DN in the following form:
     cn=short_database_name,cn=OracleContext,realm_DN
     where short_database_name is the first part of the fully qualified domain name for
     a database.
     For example, if you have a database named db1.us.example.com, then the short
     database name is db1.
•    Randomly generates a database password for directory access, storing it in the
     database wallet and in the directory.
•    After creating the wallet, Database Configuration Assistant stores it
     at $ORACLE_BASE/admin/Oracle_SID/wallet (in UNIX environments), if the
     ORACLE_BASE environment variable is present. If the ORACLE_BASE environment
     variable is not present, then the $ORACLE_HOME/admin/Oracle_SID/wallet
     directory is used.
     In Windows environments, replace the slashes (/) with backslashes (\).
     If a database wallet already exists, then Database Configuration Assistant uses it
     and updates the password in the wallet.
•    Enables autologin for the database wallet.



        Note:
        The database's password-based credentials for authentication to Oracle
        Internet Directory are placed in the wallet when an Oracle database is
        registered in Oracle Internet Directory.



To register a database with the directory:
See "Starting Database Configuration Assistant" to start this tool.
1.   After starting Database Configuration Assistant, select Configure Database
     Options in a Database and click Next.
2.   Select a database and click Next.
3.   To register the database, click Yes, Register the Database.
4.   Enter a Custom Database Name for the database.
     The ability to specify a custom database name is new in Oracle Database 12c
     Release 1 (12.1). By default, the database CN (first part of the DN or the
     distinguished name) in the directory is the DB_UNIQUE_NAME. You can change this
     to a custom value.



                                                                                             4-8
                                                                                          Chapter 4
                                   Preparing the Directory for Enterprise User Security (Phase One)


5.   Enter the directory credentials for a user in the OracleDBCreators group.
6.   Enter a password for the database wallet.



            Note:
            Remember the database wallet password you entered in Step 5. It
            cannot be retrieved after you finish database registration. If you do not
            know the password, a multistep process is required to generate a new
            wallet and reregister the database. See "About the Database Wallet and
            Password" for further information.


7.   Click Finish if you are only registering the database. Click Next if you want to
     configure additional database features.



            See Also:
            "Registering Your Database with the Directory" for an example of using
            DBCA to register the database


To change the database's directory password:
After starting Database Configuration Assistant, select Configure Database Options
in a Database, and click Next.
1.   Select a database and click Next.
2.   Select Regenerate database password.
3.   Enter the directory credentials for a user in the OracleDBCreators group and a
     password for the database wallet. Click OK.
4.   Click Finish if you are only regenerating the password. Click Next if you want to
     configure additional database features.

To unregister a database from the directory:
See "Starting Database Configuration Assistant" to start this tool.
1.   After starting Database Configuration Assistant, select Configure Database
     Options in a Database and click Next.
2.   Select a database and click Next.
3.   To unregister the database, select the Unregister option.
4.   Enter the directory credentials for a user with the appropriate permissions.
5.   Enter a password for the database wallet.
When you unregister a database from the directory, Database Configuration Assistant
performs the following configuration tasks:
•    Removes the database entry and subtree from the directory.
•    Sets the LDAP_DIRECTORY_ACCESS parameter to NONE.




                                                                                              4-9
                                                                                                    Chapter 4
                                             Preparing the Directory for Enterprise User Security (Phase One)


           •    Removes the database from its enterprise domain (if the user has sufficient
                permissions).



                       Note:
                       Depending on user permissions, Database Configuration Assistant may
                       be unable to remove a database from its domain in the directory. If it
                       cannot, then use Oracle Enterprise Manager to remove it from the
                       enterprise domain.


           •    Does not remove the database wallet.



                       See Also:
                       "About Oracle Wallet Manager" and "Deleting an Oracle Wallet" for more
                       information about deleting the wallet




                   Note:
                   To succeed at unregistering an Oracle Database from Oracle Internet
                   Directory by using Database Configuration Assistant, you must be one of the
                   following:
                   •   A member of the Oracle Context Admin group
                   •   A member of both the Database Admin group (for the database you are
                       unregistering) and the Database Security Admin group
                   •   A member of both the Database Admin group (for the database you are
                       unregistering) and the Domain Admin group (for the enterprise domain
                       that contains the database).


           This section includes the following topics:
           •    About the Database Wallet and Password
           •    Configuring Directory Access for Enterprise Users


4.3.1 Configuring Directory Access for Enterprise Users
           You can configure the Oracle Internet Directory services connection manually by using
           LDAP-specific Oracle Database system parameters.
           1.   Ensure that you have created the dsi.ora file or the ldap.ora file, and that you
                have created the wallet.
           2.   Log in to the appropriate PDB as a user who has the ALTER SYSTEM system
                privilege.
                For example:




                                                                                                       4-10
                                                                                                     Chapter 4
                                              Preparing the Directory for Enterprise User Security (Phase One)


                sqlplus sec_admin@pdb_name
                Enter password: password

                To find the available PDBs in a CDB, log in to the CDB root container and then
                query the PDB_NAME column of the DBA_PDBS data dictionary view. To check the
                current container, run the show con_name command.
           3.   Modify the LDAP_DIRECTORY_ACCESS parameter, which determines the type of
                LDAP directory access.
                Set LDAP_DIRECTORY_ACCESS in each PDB, not in the CDB root. Setting this
                parameter in the CDB root will apply it only to the root, not to the PDBs.
                Valid values are PASSWORD, SSL and NONE (to disable the connection). If you set this
                parameter to NONE, enterprise users from Oracle Internet Directory cannot log in to
                Oracle database.
                For example:
                ALTER SYSTEM SET LDAP_DIRECTORY_ACCESS = 'PASSWORD';

                You can also set this parameter in the spfile or in the init.ora file (if the init.ora
                file is used). Afterward, restart the database.
           4.   Set the LDAP_DIRECTORY_SYSAUTH parameter to YES, so that administrative users
                can log in to Oracle Database with the SYSDBA, SYSOPER, SYSBACKUP, SYSDG, SYSKM,
                or SYSRAC administrative privilege.
                Set LDAP_DIRECTORY_SYSAUTH in each PDB, not in the CDB root. Setting this
                parameter in the CDB root will apply it only to the root, not to the PDBs.
                If you set this parameter to NO, then enterprise users from Oracle Internet Directory
                cannot log in to Oracle database with these privileges.
                ALTER SYSTEM SET LDAP_DIRECTORY_SYSAUTH = YES SCOPE=SPFILE ;

                You can also set this parameter in the spfile or in the init.ora file (if the init.ora
                file is used). Afterward, restart the database.
           5.   Connect to the root as a user with the SYSDBA administrative privilege.
           6.   Close and then re-open the PDB.
                ALTER PLUGGABLE DATABASE pdb_name CLOSE IMMEDIATE;
                ALTER PLUGGABLE DATABASE pdb_name OPEN;
           After you re-open the PDB, you can log in to the PDB with the SYSDBA administrative
           privilege and check the LDAP parameters settings as follows:
           show parameter ldap

           Related Topics
           •    LDAP_DIRECTORY_SYSAUTH
           •    LDAP_DIRECTORY_ACCESS


4.3.2 About the Database Wallet and Password
           The database requires the wallet even if no SSL (Secure Sockets Layer) is used to
           secure the connection between the database and the directory. If SSL is used, then
           this wallet should be used to store the database's digital PKI certificate.




                                                                                                        4-11
                                                                                                     Chapter 4
                                              Preparing the Directory for Enterprise User Security (Phase One)


            The wallet password you enter when using Database Configuration Assistant to
            register a database in the directory is the password to the wallet itself. This password
            is not the database's directory login credentials.
            You can change this wallet password later, using Oracle Wallet Manager. However, if
            you forget this wallet password, then you must generate an entirely new wallet and
            password. To do so, you must first delete the existing database wallet, create a new
            wallet (which can be empty) and put it at the default wallet location, $ORACLE_HOME/
            admin/Oracle_SID/wallet (in UNIX environment). Next, unregister the database from
            the directory, and reregister the database in the directory. During that registration,
            another database wallet and password can be generated.



                   See Also:
                   "Changing the Oracle Wallet Password" for information about using Oracle
                   Wallet Manager to change wallet passwords and, in general, to manage
                   public key infrastructure (PKI) credentials



            After you have prepared the directory for Enterprise User Security, then you can
            create the Enterprise User Security database and directory objects as described in
            "Configuring Enterprise User Security Objects in the Database and the Directory
            (Phase Two)".



                   See Also:

                   •   Oracle Fusion Middleware Administrator's Guide for Oracle Internet
                       Directory for information about configuring an identity management
                       realm in the directory
                   •   Oracle Database Reference for information about changing the value of
                       the LDAP_DIRECTORY_ACCESS initialization parameter


            This section includes the following topic: Sharing Wallets and sqlnet.ora Files Among
            Multiple Databases.

4.3.2.1 Sharing Wallets and sqlnet.ora Files Among Multiple Databases
            Multiple databases (that are not replicas) cannot share wallets, because wallets
            contain a database's identity. Therefore, if a sqlnet.ora file contains a wallet location,
            then multiple databases cannot share that sqlnet.ora file.

            In order to share a single sqlnet.ora file among multiple databases, the following
            preconditions are required:
            •   User authentication should use passwords or Kerberos.
            •   The wallet containing the password should reside at the default wallet location,
                which is where Database Configuration Assistant creates it.
            If the preceding conditions are met, then multiple databases can share the sqlnet.ora
            file because no wallet location information is stored in that file.




                                                                                                        4-12
                                                                                                      Chapter 4
                     Configuring Enterprise User Security Objects in the Database and the Directory (Phase Two)


          However, when SSL authentication is used between the user (client) and the
          database, the wallet location must be specified in the database server's sqlnet.ora
          file. Such a sqlnet.ora file cannot be shared by multiple databases for SSL-
          authenticated enterprise users.


4.4 Configuring Enterprise User Security Objects in the
Database and the Directory (Phase Two)
          This is the second phase of configuration steps required to implement Enterprise User
          Security. The configuration steps in this section assume the following recommended
          setup:
          •   You have prepared your database and your directory by completing the tasks
              described in "Preparing the Directory for Enterprise User Security (Phase One)".
          •   Your users are stored in an identity management realm Users subtree.
          •   You use the OracleDefaultDomain, which is the default enterprise domain that
              Database Configuration Assistant uses when you register databases in the
              directory.
          Note that databases must be in an enterprise domain that is in an identity
          management realm in order for enterprise user logins to work.



                 See Also:
                 If you do not use the OracleDefaultDomain or store your users in an identity
                 management realm Users subtree, then see the following documentation:
                 •   Oracle Fusion Middleware Administrator's Guide for Oracle Internet
                     Directory for information about creating a new identity management
                     realm or modifying an existing one, and for information about setting
                     access control lists on directory objects
                 •   "Creating an Enterprise Domain" to create another domain in which to
                     put your database. Then substitute your new domain name for
                     OracleDefaultDomain in the following configuration steps


          To configure Enterprise User Security objects in the database and directory perform
          the following tasks:
          •   Task 1: Create Global Schemas and Global Roles in the Database
          •   Task 2: Configure User-Schema Mappings for the Enterprise Domain
          •   Task 3: Create Enterprise Roles in the Enterprise Domain
          •   Task 4: Add Global Database Roles to Enterprise Roles
          •   Task 5: Grant Enterprise Roles to Enterprise Users for Database Access

          Task 1: Create Global Schemas and Global Roles in the Database
          Although this step can also be completed by using Oracle Enterprise Manager, the
          following examples use SQL*Plus directly:




                                                                                                         4-13
                                                                                            Chapter 4
           Configuring Enterprise User Security Objects in the Database and the Directory (Phase Two)


1.   Create a shared schema for enterprise users. The following syntax example
     creates a shared schema named guest:
     SQL> CREATE USER guest IDENTIFIED GLOBALLY AS '';

     If you do not want to use a shared schema, then specify a user DN between the
     single quotation marks to create an exclusive schema.
2.   Grant the CREATE SESSION privilege to the shared schema created in Step 1 so
     users can connect to it. The following syntax example grants the CREATE SESSION
     privilege to the guest shared schema:
     SQL> GRANT CREATE SESSION TO guest;

     Alternatively, you can grant the CREATE SESSION privilege to a global role, which
     you grant to specific users through an enterprise role. See Step 3.
3.   Create global roles for the database to hold relevant privileges. The following
     syntax examples create the emprole and custrole global roles:
     SQL> CREATE ROLE emprole IDENTIFIED GLOBALLY;
     SQL> CREATE ROLE custrole IDENTIFIED GLOBALLY;

     Global roles are associated with enterprise roles, which are created later, and then
     are allocated to enterprise users.
4.   Grant privileges to the new global roles that were created in Step 3. The following
     syntax example grants the SELECT privilege to emprole and custrole global roles
     on the products table:
     SQL> GRANT select ON products TO custrole, emprole;



            See Also:
            Oracle Database SQL Language Reference for information about the
            syntax for creating a user.
            Oracle Database SQL Language Reference for information about the
            syntax for granting a privilege to a user or role.
            Oracle Database SQL Language Reference for information about the
            syntax for creating a role.


Task 2: Configure User-Schema Mappings for the Enterprise Domain
Use Enterprise Manager to configure user-schema mappings for the
OracleDefaultDomain by using the following steps:
1.   Log in to Enterprise Manager Cloud Control, as an administrative user.
2.   To navigate to your database, select Databases from the Targets menu.
3.   Click the database name in the list that appears. The database page appears.
4.   Under the Administration menu, select Security, Enterprise User Security. The
     Oracle Internet Directory Login page appears.
5.   Enter the distinguished name (DN) of a directory user who can administer
     enterprise users in the User field. Enter the user password in the Password field.
     Click Login.




                                                                                               4-14
                                                                                            Chapter 4
           Configuring Enterprise User Security Objects in the Database and the Directory (Phase Two)


     The Enterprise User Security page appears.
6.   Click Manage Enterprise Domains.
     The Manage Enterprise Domains page appears. This page lists the enterprise
     domains in the identity management realm.
7.   Select OracleDefaultDomain. Click Configure.
     The Configure Domain page appears.
8.   Click the User-Schema Mappings tab. All user-schema maps created at the
     domain level are displayed. User-schema maps created at database levels are not
     displayed here.
9.   Click Create to create a new user-schema mapping for the domain.
     The Create Mapping page is displayed.
10. Under the From section, select Users to map an individual enterprise user to a
     database schema. Alternatively, select Subtree to map a directory subtree
     containing multiple users. You can use the Search icon to search for the
     appropriate user or subtree.
11. Under the To section, enter the name of the Schema to which the user or subtree
     should be mapped. This is the schema that you created in Task 1.
12. Click Continue in the Create Mapping page.

13. Click OK in the Configure Domain page.



        Note:
        You can also create user-schema mappings for an individual database in an
        enterprise domain. Such mappings apply only to that particular database and
        not to other databases in the domain.




        See Also:
        "Mapping Enterprise Users to the Shared Schema" for an example on
        creating user-schema mappings



Task 3: Create Enterprise Roles in the Enterprise Domain
Use Enterprise Manager to create enterprise roles in the OracleDefaultDomain by
using the following steps:
1.   Select OracleDefaultDomain in the Manage Enterprise Domains page. Click
     Configure.
     The Configure Domain page appears.
2.   Click the Enterprise Roles tab.
3.   Click Create to create a new enterprise role.
     The Create Enterprise Role page appears.
4.   Enter a name for the enterprise role in the Name field. Click Continue.



                                                                                               4-15
                                                                                            Chapter 4
           Configuring Enterprise User Security Objects in the Database and the Directory (Phase Two)


     The new role is displayed in the Configure Domain page.



        See Also:
        "Using Enterprise Roles" for an example on creating and using enterprise
        roles



Task 4: Add Global Database Roles to Enterprise Roles
Use Enterprise Manager to add the global database roles that you created in Task 1 to
the enterprise roles that you created in Task 3 by using the following steps:
1.   Select the enterprise role that you just created in the Configure Domain page.
     Click Edit.
     The Edit Enterprise Role page is displayed.
2.   Make sure that the DB Global Roles tab is selected. Click Add to add global roles
     from databases that are part of the enterprise domain.
     The Search and Select Database Global Roles page appears.
3.   Select the Database that contains the global roles you wish to add. Log in to the
     selected database by supplying a User Name and Password. Click Go.
4.   Select the global roles to add. Click Select.
     The selected roles appear in the Edit Enterprise Role page.



        See Also:
        "Using Enterprise Roles" for an example on creating and using enterprise
        roles



Task 5: Grant Enterprise Roles to Enterprise Users for Database Access
Use Enterprise Manager to grant enterprise roles that you created in Task 3 to the
enterprise users by using the following steps:
1.   Click the Grantees tab in the Edit Enterprise Role page.
2.   Click Add.
     The Select Users or Groups page is displayed.
3.   Select the Search Base or the subtree that contains the user or group. Select
     User under View if you are granting the enterprise role to a user. Select Group
     under View, if you are granting the role to a group. Optionally, enter the common
     name of the user or group in the Name field. Click Go.
4.   Select the users or groups to be granted the enterprise role. Click Select.
5.   Click Continue in the Edit Enterprise Role page.
6.   Click OK in the Configure Domain page.




                                                                                               4-16
                                                                                                      Chapter 4
                     Configure Enterprise User Security for the Authentication Method You Require (Phase Three)




                  See Also:
                  "Using Enterprise Roles" for an example on creating and using enterprise
                  roles




4.5 Configure Enterprise User Security for the
Authentication Method You Require (Phase Three)
           In the third phase, you complete the Enterprise User Security configuration based on
           the authentication method you have chosen. Go to one of the following sections:
           •   "Configuring Enterprise User Security for Password Authentication"
           •   "Configuring Enterprise User Security for Kerberos Authentication"
           •   "Configuring Enterprise User Security for SSL Authentication"



                  See Also:
                  Table 1-1 for a comparison of the benefits provided by password, Kerberos,
                  and SSL authentication for Enterprise User Security



4.5.1 Configuring Enterprise User Security for Password
Authentication
           By default, new enterprise domains are configured to accept all supported user
           authentication types (password, Kerberos, and SSL). If you want enterprise users to
           be authenticated by passwords, then you must configure that as described in the
           following tasks.
           The configuration steps in this section assume the following:
           •   You have prepared your directory by completing the tasks described in "Preparing
               the Directory for Enterprise User Security (Phase One)".
           •   You have configured your Enterprise User Security objects in the database and
               the directory by completing the tasks described in "Configuring Enterprise User
               Security Objects in the Database and the Directory (Phase Two)".
           •   You have configured an SSL instance with no authentication for Oracle Internet
               Directory as described in Oracle Fusion Middleware Administrator's Guide for
               Oracle Internet Directory. If you are using an ldap.ora file, then also ensure that
               the port number for this SSL with no authentication instance is listed there as your
               directory SSL port.
           To configure Enterprise User Security for password authentication, perform the
           following tasks:
           •   Task 1: (Optional) Enable the Enterprise Domain to Accept Password
               Authentication




                                                                                                         4-17
                                                                                            Chapter 4
           Configure Enterprise User Security for the Authentication Method You Require (Phase Three)


•    Task 2: Connect as a Password-Authenticated Enterprise User

Task 1: (Optional) Enable the Enterprise Domain to Accept Password
Authentication
By default, OracleDefaultDomain is configured to accept password authentication. If
this has been changed, then use Oracle Enterprise Manager to enable password
authentication for OracleDefaultDomain using the following steps:
1.   Log in to Enterprise Manager Cloud Control, as an administrative user.
2.   To navigate to your database, select Databases from the Targets menu.
3.   Click the database name in the list that appears. The database page appears.
4.   Under the Administration menu, select Security, Enterprise User Security. The
     Oracle Internet Directory Login page appears.
5.   Enter the distinguished name (DN) of a directory user who can administer
     enterprise users in the User field. Enter the user password in the Password field.
     Click Login.
     The Enterprise User Security page appears.
6.   Click Manage Enterprise Domains.
     The Manage Enterprise Domains page appears. This page lists the enterprise
     domains in the identity management realm.
7.   Select OracleDefaultDomain. Click Configure.
     The Configure Domain page appears.
8.   Click the Configuration tab.
9.   Under User Authentication Types Accepted, select Password.
10. Click OK.

Task 2: Connect as a Password-Authenticated Enterprise User
For an enterprise user whose directory login name is hscortea and whose password is
Easy2rem, enter the following to connect to the database by using SQL*Plus:
SQL> connect hscortea@<Oracle Net Service Name>
Enter password:
/* Enter Easy2rem when prompted for the password*/

The database authenticates the enterprise user (hscortea) by verifying the username-
password combination against the directory entry associated with this user. Then, it
identifies the proper schema and retrieves the user's global roles. If successful, then
the connection to the database is established.
If your connection succeeds, then the system responds Connected to:.... This is the
confirmation message of a successful connect and setup. If an error message is
displayed, then see "ORA-n Errors for Password-Authenticated Enterprise Users".
If you do connect successfully, then check that the appropriate global roles were
retrieved from the directory, by entering the following at the SQL*Plus prompt:
select * from session_roles

If the global roles were not retrieved from the directory, then see "NO-GLOBAL-
ROLES Checklist".



                                                                                               4-18
                                                                                                       Chapter 4
                      Configure Enterprise User Security for the Authentication Method You Require (Phase Three)


           You have completed password-authenticated Enterprise User Security configuration.



                  See Also:

                  •    "Troubleshooting Enterprise User Security" for information about
                       diagnosing and resolving errors
                  •    Administering Enterprise User Security for information about configuring
                       the identity management realm, and about creating and managing
                       enterprise domains, enterprise roles, and enterprise users



4.5.2 Configuring Enterprise User Security for Kerberos Authentication
           The configuration steps in this section assume the following:
           •   You have registered your databases with the Kerberos authentication server and
               configured your Oracle Net Services as described in information about configuring
               Kerberos authentication in Oracle Database Security Guide.
           •   You have prepared your directory by completing the tasks described in "Preparing
               the Directory for Enterprise User Security (Phase One)".
           •   You have configured your Enterprise User Security objects in the database and
               the directory by completing the tasks described in "Configuring Enterprise User
               Security Objects in the Database and the Directory (Phase Two)".
           •   You have configured an SSL instance with no authentication for Oracle Internet
               Directory as described in Oracle Fusion Middleware Administrator's Guide for
               Oracle Internet Directory. If you are using an ldap.ora, then also ensure that the
               port number for this SSL with no authentication instance is listed there as your
               directory SSL port.
           To configure Enterprise User Security for Kerberos authentication, perform the
           following tasks:
           •   Task 1: Configure Oracle Internet Directory Self-Service Console to display the
               Kerberos principal name attribute
           •   Task 2: (Optional) Configure the Kerberos Principal Name Directory Attribute for
               the Identity Management Realm
           •   Task 3: Specify the Enterprise User's Kerberos Principal Name in the
               krbPrincipalName Attribute
           •   Task 4: (Optional) Enable the Enterprise Domain to Accept Kerberos
               Authentication
           •   Task 5: Connect as a Kerberos-Authenticated Enterprise User

           Task 1: Configure Oracle Internet Directory Self-Service Console to display the
           Kerberos principal name attribute
           By default, the Oracle Internet Directory Self-Service Console user interface does not
           display the field where you can configure Kerberos principal names. The first time you
           create Kerberos-authenticated users in the directory, you must configure this tool to
           display the krbPrincipalName attribute in its Create User page by using the following
           steps:




                                                                                                          4-19
                                                                                             Chapter 4
            Configure Enterprise User Security for the Authentication Method You Require (Phase Three)


1.   Log in to the Oracle Internet Directory Self-Service Console.
     Enter the URL to access the Oracle Internet Directory Self-Service Console in a
     browser window. For example:
     http://myhost1:7777/oiddas

     Log in as the orcladmin user.
2.   Click the Configuration tab. Click the User Entry subtab.
3.   Click Next until the Configure User Attributes page appears.
4.   In the Configure User Attributes page, click Add New Attribute.
     The Add New Attribute page appears.
5.   In the Add New Attribute page, select krbPrincipalName from the Directory
     Attribute Name box (or the attribute that you have configured for
     orclCommonKrbPrincipalAttribute in your identity management realm) and
     perform the following steps on this page:
     a.   Enter a value, say Kerberos Principal Name, for the UI Label.
     b.   Select Searchable and Viewable.
     c.   Select Single Line Text from the UI Type.
     d.   ClickDone.
6.   Click Next to navigate to the Configure Attribute Categories page. Select Basic
     Information and click Edit.
     The Edit Category page appears.
7.   Perform the following steps on the Edit Category page:
     a.   Select krbPrincipalName in the left category list.
     b.   Click Move, to move krbPrincipalName to the right-hand list.
     c.   Click Done.
8.   Click Next until you reach the last step. Click Finish to save your work.

Task 2: (Optional) Configure the Kerberos Principal Name Directory Attribute for
the Identity Management Realm
Use Oracle Internet Directory Self-Service Console to enter the directory attribute used
to store the Kerberos principal name for the identity management realm you are using
in the directory. By default, Kerberos principal names are stored in the
krbPrincipalName attribute but can be changed to correspond to your directory
configuration by changing orclCommonKrbPrincipalAttribute in the identity
management realm. For more information about this task, see "Setting Login Name,
Kerberos Principal Name, User Search Base, and Group Search Base Identity
Management Realm Attributes".




                                                                                                4-20
                                                                                            Chapter 4
           Configure Enterprise User Security for the Authentication Method You Require (Phase Three)




        Note:
        By default, the Oracle Internet Directory Self-Service Console user interface
        does not display the field where you can configure Kerberos principal names.
        The first time you create Kerberos-authenticated users in the directory, you
        must configure the console to display the krbPrincipalName attribute in its
        Create User window.



Task 3: Specify the Enterprise User's Kerberos Principal Name in the
krbPrincipalName Attribute
Use Oracle Internet Directory Self-Service Console to specify the enterprise user's
Kerberos principal name (Kerberos_username@Kerberos_realm) in the
krbPrincipalName attribute of the enterprise user's directory entry. For more
information about this task, see "Creating New Enterprise Users".

Task 4: (Optional) Enable the Enterprise Domain to Accept Kerberos
Authentication
By default, OracleDefaultDomain is configured to accept all types of authentication. If
this has been changed or if you are using another domain, then use Oracle Enterprise
Manager to enable Kerberos authentication for your enterprise domain by performing
the following steps:
1.   Log in to Enterprise Manager Cloud Control, as an administrative user.
2.   To navigate to your database, select Databases from the Targets menu.
3.   Click the database name in the list that appears. The database page appears.
4.   Under the Administration menu, select Security, Enterprise User Security. The
     Oracle Internet Directory Login page appears.
5.   Enter the distinguished name (DN) of a directory user who can administer
     enterprise users in the User field. Enter the user password in the Password field.
     Click Login.
     The Enterprise User Security page appears.
6.   Click Manage Enterprise Domains.
     The Manage Enterprise Domains page appears. This page lists the enterprise
     domains in the identity management realm.
7.   Select OracleDefaultDomain. Click Configure.
     The Configure Domain page appears.
8.   Click the Configuration tab.
9.   Under User Authentication Types Accepted, select Kerberos.
10. Click OK.

Task 5: Connect as a Kerberos-Authenticated Enterprise User
If the KDC is not part of the operating system, such as Kerberos V5 from MIT, then the
user must get an initial ticket with the FORWARDABLE flag set by using the okinit utility.
See Oracle Database Security Guide for information about obtaining the initial ticket
with the okinit Utility.



                                                                                               4-21
                                                                                                       Chapter 4
                      Configure Enterprise User Security for the Authentication Method You Require (Phase Three)


           If the KDC is part of the operating system, such as Windows 2000 or some versions of
           Linux or UNIX, then the operating system automatically picks up the user's ticket (with
           the FORWARDABLE flag set) from the cache when the user logs in.

           The user connects to the database by launching SQL*Plus and entering the following
           at the command line:
           SQL> connect /@<net_service_name>

           The database uses Kerberos to authenticate the user. The database authenticates
           itself to the directory by password.
           If your connection succeeds, then the system responds with Connected to:.... This
           is the confirmation message of a successful connect and setup. If an error message is
           displayed, then see "ORA-n Errors for Kerberos-Authenticated Enterprise Users".
           If you do connect successfully, then check that the appropriate global roles were
           retrieved from the directory, by entering the following at the SQL*Plus prompt:
           select * from session_roles

           If the global roles were not retrieved from the directory, then see "NO-GLOBAL-
           ROLES Checklist".
           You have completed Kerberos-authenticated Enterprise User Security configuration.



                  See Also:

                  •    "Troubleshooting Enterprise User Security" for information about
                       diagnosing and resolving errors
                  •    Administering Enterprise User Security for information about configuring
                       the identity management realm, and information about creating and
                       managing enterprise domains, enterprise roles, and enterprise users



4.5.3 Configuring Enterprise User Security for SSL Authentication
           The configuration steps in this section assume the following:
           •   You have obtained the appropriate PKI credentials and used Oracle Wallet
               Manager to create wallets for the directories, databases, and clients that you want
               to include in your Enterprise User Security implementation.
           •   You have confirmed that each enterprise user entry in Oracle Internet Directory is
               provisioned with a unique PKI credential. However, in this release an enterprise
               user can have different DNs in his or her PKI certificate and Oracle Internet
               Directory entry. Also in this release, the database entry can have different DNs in
               its PKI certificate and Oracle Internet Directory entry.
               You must provision user certificates in their respective Oracle Internet Directory
               user entries in order to support using different DNs in the certificate and the
               directory. A user certificate is provisioned in to the usercertificate attribute of
               the user entry. If you prefer not to provision the certificates, then you must make
               sure that the subject DNs in the certificates match the user DNs in the directory.




                                                                                                          4-22
                                                                                         Chapter 4
        Configure Enterprise User Security for the Authentication Method You Require (Phase Three)


Oracle Internet Directory 10g Release2 (10.1.2) includes certificate matching rules
to support the new functionality of being able to use different DNs in the certificate
and the directory. The orclpkimatchingrule attribute in Oracle Internet Directory
determines the type of match that is used.
The default value of orclpkimatchingrule is 2. This enables you to support both
provisioned and non-provisioned user entries. The database finds out a user's
Oracle Internet Directory DN based on a search for the user's certificate
provisioned in the directory. If the certificate search fails, then the database reverts
to using an exact match between the user's certificate DN and his or her Oracle
Internet Directory DN.
If all users have certificates provisioned in Oracle Internet Directory, then you can
set the orclpkimatchingrule to 1. This instructs Oracle Internet Directory to
always conduct a certificate search. For instance, if your certificate authority does
not support two common names in certificate DNs but the directory DNs are using
two common names, then you would need to provision all user certificates into the
directory. You can then set the orclpkimatchingrule to 1.
If you do not want to support the functionality of using different DNs in the PKI
certificate and Oracle Internet Directory, then you can set the
orclpkimatchingrule value to 0. You use this setting if all certificate DNs match
directory DNs and you do not wish to provision the certificates.
You can also create your own mapping rules to map certificate DNs to directory
DNs in Oracle Internet Directory 10g Release 2 (10.1.2.0.2). To use mapping
rules, orclpkimatchingrule is set to 3 or 4.
When you want to use the mapping rule for all users, set orclpkimatchingrule to
3. If you also need to support certificate-based search and exact match, then set
orclpkimatchingrule to 4.
Table 4-2 describes the values of the orclpkimatchingrule attribute.

Table 4-2      Oracle Internet Directory Matching Rules

Value                               Rule
orclpkimatchingrule=0               Exact match. The bind is based on the subject DN of the
                                    client certificate. This DN is compared with the DN of the
                                    user in the directory.
orclpkimatchingrule=1               Certificate hash. The bind is based on the hashed value
                                    of the certificate.
orclpkimatchingrule=2               Certificate hash/exact match. The bind is based on the
(default)                           hashed value of the certificate. If this operation fails, then
                                    a bind based on the subject DN of the client certificate is
                                    performed.
orclpkimatchingrule=3               Mapping rule only.
orclpkimatchingrule=4               Mapping rule/certificate hash/exact match. The bind is
                                    based on the mapping rule. If this operation fails, a bind
                                    based on the hashed value of the certificate is
                                    performed. If this operation fails, then a bind based on an
                                    exact match of the certificate is performed.




                                                                                            4-23
                                                                                            Chapter 4
           Configure Enterprise User Security for the Authentication Method You Require (Phase Three)




            Note:
            Oracle Fusion Middleware Administrator's Guide for Oracle Internet
            Directory and Oracle Fusion Middleware Reference for Oracle Identity
            Management for information on how to modify the orclpkimatchingrule
            attribute




            Note:
            A certificate search will fail if there is no user entry under the realm's
            user search base with that certificate, or if you are using an older version
            of Oracle Internet Directory that does not support the certificate search
            functionality. If the certificate search fails, then the database will revert to
            the old behavior of matching the user DN with the certificate DN for a
            successful connection.


•    You have enabled SSL for your client-database Oracle Net connections as
     described in Oracle Database Security Guide for information about enabling SSL.
     Ensure that you included the following steps when you enabled SSL:
     –   Enabled SSL for your database listener on TCPS and provided a corresponding
         TNS name
     –   Stored your database PKI credentials in the database wallet that Database
         Configuration Assistant automatically created during database registration
•    You have configured an SSL instance with two-way authentication for Oracle
     Internet Directory as described in Oracle Fusion Middleware Administrator's Guide
     for Oracle Internet Directory.
•    You have prepared your directory by completing the tasks described in "Preparing
     the Directory for Enterprise User Security (Phase One)".
•    You have configured your Enterprise User Security objects in the database and
     the directory by completing the tasks described in "Configuring Enterprise User
     Security Objects in the Database and the Directory (Phase Two)".
To configure Enterprise User Security for SSL authentication, perform the following
tasks:
•    Task 1: Enable the Enterprise Domain to Accept SSL Authentication
•    Task 2: Set the LDAP_DIRECTORY_ACCESS Initialization Parameter to SSL
•    Task 3: Connect as an SSL-Authenticated Enterprise User

Task 1: Enable the Enterprise Domain to Accept SSL Authentication
By default, OracleDefaultDomain is configured to accept all types of authentication. If
this has been changed or if you are using another domain, then use Oracle Enterprise
Manager to enable SSL authentication for your enterprise domain by performing the
following steps:
1.   Log in to Enterprise Manager Cloud Control, as an administrative user.
2.   To navigate to your database, select Databases from the Targets menu.




                                                                                               4-24
                                                                                             Chapter 4
            Configure Enterprise User Security for the Authentication Method You Require (Phase Three)


3.   Click the database name in the list that appears. The database page appears.
4.   Under the Administration menu, select Security, Enterprise User Security. The
     Oracle Internet Directory Login page appears.
5.   Enter the distinguished name (DN) of a directory user who can administer
     enterprise users in the User field. Enter the user password in the Password field.
     Click Login.
     The Enterprise User Security page appears.
6.   Click Manage Enterprise Domains.
     The Manage Enterprise Domains page appears. This page lists the enterprise
     domains in the identity management realm.
7.   Select OracleDefaultDomain. Click Configure.
     The Configure Domain page appears.
8.   Click the Configuration tab.
9.   Under User Authentication Types Accepted, select SSL.
10. Click OK.

Task 2: Set the LDAP_DIRECTORY_ACCESS Initialization Parameter to SSL
You can change this initialization parameter either by editing your database
initialization parameter file or by issuing an ALTER SYSTEM SQL command with the SET
clause.
For example, the following ALTER SYSTEM command changes the
LDAP_DIRECTORY_ACCESS parameter value to SSL in the server parameter file:
ALTER SYSTEM SET LDAP_DIRECTORY_ACCESS=SSL SCOPE=SPFILE



        See Also:

        •    Oracle Database Reference for information about editing initialization
             parameters
        •    Oracle Database Reference for information about the
             LDAP_DIRECTORY_ACCESS initialization parameter
        •    Oracle Database SQL Language Reference for information about using
             the ALTER SYSTEM command with the SET clause


Task 3: Connect as an SSL-Authenticated Enterprise User
Connecting as an SSL-authenticated enterprise user involves ensuring that you have
the appropriate Oracle wallet features configured and that you do not have a wallet
location specified in the client sqlnet.ora file. If the client sqlnet.ora file contains a
wallet location, then multiple users and databases cannot share that file. Only the
server sqlnet.ora file must have a value for the wallet location parameter.




                                                                                                4-25
                                                                                            Chapter 4
           Configure Enterprise User Security for the Authentication Method You Require (Phase Three)




        See Also:
        "Saving an Oracle Wallet to the System Default Directory Location" for the
        default location of a user's wallet when the authentication used between the
        user and the database is SSL



To connect as an SSL-authentication enterprise user, perform the following steps:
1.   Use Oracle Wallet Manager to download a user wallet from the directory. See
     "Downloading an Oracle Wallet from an LDAP Directory".
2.   Use Oracle Wallet Manager to enable autologin for the user wallet. Enabling
     autologin generates a single sign-on (.sso) file and enables authentication to the
     SSL adapter. See "Using Auto Login for Oracle Wallets to Enable Access Without
     Human Intervention" for information about using the autologin feature of Oracle
     Wallet Manager.
3.   Set the TNS_ADMIN environment variable (to point to the client's sqlnet.ora file) for
     the client if the client Oracle home points to a server Oracle home. (Because a
     server must have a wallet location set in its sqlnet.ora file and a client cannot
     have a wallet location specified there, the server and client cannot share
     sqlnet.ora files.)
     If you have a separate client Oracle home, then you do not need to set the
     TNS_ADMIN environment variable.
4.   Launch SQL*Plus and enter the following at the command line:
     SQL> /@connect_identifier

     where connect_identifer is the Oracle Net service name you set up when you
     configured SSL for the database client.
     If your connection succeeds, then the system responds with Connected to:....
     This is the confirmation message of a successful connect and setup. If an error
     message is displayed, then see "ORA-n Errors for SSL-Authenticated Enterprise
     Users".
     If you do connect successfully, then check that the appropriate global roles were
     retrieved from the directory, by entering the following at the SQL*Plus prompt:
     select * from session_roles

     If the global roles were not retrieved from the directory, then see "NO-GLOBAL-
     ROLES Checklist".
You have completed SSL-authenticated Enterprise User Security configuration.



        Note:
        For security purposes, ensure that you disable auto login for the user wallet
        after logging out from the enterprise user session with the database. This is
        especially important if the client computer is shared by more than one user.
        See "Disabling Auto Login for Oracle Wallets" for information about using
        Oracle Wallet Manager to disable auto login for an Oracle wallet.




                                                                                               4-26
                                                                                                 Chapter 4
                                                                      Enabling Current User Database Links


             This section includes the following topic: Viewing the Database DN in the Wallet and in
             the Directory.

4.5.3.1 Viewing the Database DN in the Wallet and in the Directory
             When you use Database Configuration Assistant to register your database in the
             directory, this tool automatically creates identical DNs for the database wallet and the
             database directory entry. To view the database DN, use one of the following options:
             Use Oracle Directory Manager to look in the directory under the realm Oracle Context
             for
             cn=<short_database_name>,cn=OracleContext,<realm_DN>

             where short_database_name is the first part of the fully qualified domain name for a
             database. For example, if you have a database named db1.us.example.com, then the
             short database name is db1.

             •    Use the following mkstore utility syntax on the command line:
                  mkstore -wrl <wallet_location> -viewEntry ORACLE.SECURITY.DN

                  where wallet_location is the path to the database wallet.



                         See Also:

                         –   "Troubleshooting Enterprise User Security" for information about
                             diagnosing and resolving errors
                         –   Administering Enterprise User Security for information about
                             configuring the identity management realm, and information about
                             creating and managing enterprise domains, enterprise roles, and
                             enterprise users



4.6 Enabling Current User Database Links
             Current user database links require SSL-enabled network connections between the
             databases. Before you can enable current user database links, you must enable SSL,
             create Oracle wallets, and obtain PKI credentials for all databases involved.
             Then, use Oracle Enterprise Manager to enable current user database links between
             databases within the enterprise domain in the directory by using the following steps:
             1.   Log in to Enterprise Manager Cloud Control, as an administrative user.
             2.   To navigate to your database, select Databases from the Targets menu.
             3.   Click the database name in the list that appears. The database page appears.
             4.   Under the Administration menu, select Security, Enterprise User Security. The
                  Oracle Internet Directory Login page appears.
             5.   Enter the distinguished name (DN) of a directory user who can administer
                  enterprise users in the User field. Enter the user password in the Password field.
                  Click Login.
                  The Enterprise User Security page appears.



                                                                                                    4-27
                                                                                                   Chapter 4
                                                                    Troubleshooting Enterprise User Security


           6.   Click Manage Enterprise Domains.
                The Manage Enterprise Domains page appears. This page lists the enterprise
                domains in the identity management realm.
           7.   Select the enterprise domain that you wish to configure. Click Configure.
                The Configure Domain page appears.
           8.   Click the Configuration tab.
           9.   Select Enable Current User Database Links in this domain.
           10. Click OK.


4.7 Troubleshooting Enterprise User Security
           This section describes potential problems and associated corrective actions in the
           following topics:
           •    ORA-n Errors for Password-Authenticated Enterprise Users
           •    ORA-n Errors for Kerberos-Authenticated Enterprise Users
           •    ORA-n Errors for SSL-Authenticated Enterprise Users
           •    NO-GLOBAL-ROLES Checklist
           •    USER-SCHEMA ERROR Checklist
           •    DOMAIN-READ-ERROR Checklist


4.7.1 ORA-n Errors for Password-Authenticated Enterprise Users
           If you receive an ORA-n error while using password-authenticated Enterprise User
           Security, then locate the error in the following section and take the recommended
           action.

           ORA-1017: Invalid username/password; login denied
           Cause: As in error message

           Action: See "USER-SCHEMA ERROR Checklist"

           ORA-28030: Server encountered problems accessing LDAP directory service
           Cause: Indicates a problem with the connection between the database and the
           directory.

           Action: Check the following:
           1.   Check that the correct wallet_location value is specified in the database's
                sqlnet.ora file in case you are not using the default wallet location. You can use
                Oracle Net Manager to enter the wallet location. You do not need to specify a
                wallet location in the sqlnet.ora file if the default wallet location is being used. If
                a wallet location is specified in the sqlnet.ora file, then you must ensure that it is
                correct.
           2.   If Domain Name System (DNS) server discovery of Oracle Internet Directory is
                not used, check that there is a correct ldap.ora file
                in $LDAP_ADMIN, $ORACLE_HOME/ldap/admin, $TNS_ADMIN, or $ORACLE_HOME/




                                                                                                      4-28
                                                                                      Chapter 4
                                                       Troubleshooting Enterprise User Security


     network/admin. (See Oracle Fusion Middleware Administrator's Guide for Oracle
     Internet Directory for information about DNS server discovery.)
3.   Check that the SSL port used (by way of either DNS discovery or an ldap.ora
     file) supports SSL with no authentication.
4.   Check that the LDAP_DIRECTORY_ACCESS parameter is set to PASSWORD in the
     database initialization parameters file.
5.   Use Database Configuration Assistant to reset the database password used to
     authenticate the database to Oracle Internet Directory. This resets it both locally
     in the database wallet, and remotely in the database entry in Oracle Internet
     Directory.
6.   Check that the database wallet has autologin enabled. Either use Oracle Wallet
     Manager or check that there is a cwallet.sso file in $ORACLE_HOME/admin/
     <ORACLE_SID>/wallet/.
7.   Use the password stored in the database wallet to check that the database can
     bind to Oracle Internet Directory:
     •   Use the mkstore command-line utility to retrieve the database password from
         the wallet by using the following syntax:
         mkstore -wrl <database wallet location> -viewEntry ORACLE.SECURITY.PASSWORD
     •   Use the password returned from mkstore in the following ldapbind:
         ldapbind -h <directory host> -p <non-SSL directory port> -D "<database DN>"
         -q
         Please enter bind password: Password returned by mkstore
8.   Check to ensure that the database belongs to only one enterprise domain.



            Note:

            The mkstore utility is for troubleshooting purposes only. The name and
            functionality of this tool may change in the future.


ORA-28043: Invalid bind credentials for DB/OID connection
Cause: The database directory password no longer synchronizes with the directory.

Action: Use the Regenerate Password button in Database Configuration Assistant to
generate a new directory password for the database, synchronize it with the directory,
and store it in the database wallet.

ORA-28271: No permission to read user entry in LDAP directory service
Cause: As in error message

Action: Check the following:
1.   Use Oracle Internet Directory Self-Service Console to check that a user search
     base containing this user is listed in the user search base attribute of the realm
     that you are using.
2.   Check the ACL on the User Search Base in Oracle Internet Directory to ensure
     that the verifierServices group has read permission on the user entry, and that




                                                                                         4-29
                                                                                       Chapter 4
                                                        Troubleshooting Enterprise User Security


     this permission is not prevented by an ACL between the User Search Base entry
     and the user entry in the directory tree.
3.   Check that the enterprise domain is in the password-accessible domains group
     for that realm Oracle Context.

ORA-28272: Domain policy restricts password-based GLOBAL user
authentication.
Cause: As in error message

Action: Use the Oracle Enterprise Manager interface to set the user authentication
policy for this enterprise domain to Password or ALL.

ORA-28273: No mapping for user nickname to LDAP distinguished name exists
Cause: As in error message

Action: Check the following:
1.   Check that a user entry exists in Oracle Internet Directory for your user.
2.   Use Oracle Internet Directory Self-Service Console to check that a user search
     base containing this user is listed in the identity management realm that you are
     using.
3.   Check that the user entry contains the correct login name:
     •   Use Oracle Internet Directory Self-Service Console to find the login name
         attribute that is configured for the directory in your realm, and
     •   Check that the name provided during the attempted user database login is the
         value for that attribute in the user directory entry.
4.   If you have an exclusive schema for the global user in the database, then check
     that the DN in the database matches the DN of the user entry in Oracle Internet
     Directory.

ORA-28274: No ORACLE password attribute corresponding to user nickname
exists
Cause: As in error message

Action: Check the following:
1.   Check that the user entry in the directory has the orcluser object class. If it does
     not, then perform the following steps:
     •   Use Oracle Internet Directory Self-Service Console to check that the default
         object classes for new user creation include orcluser, and then
     •   Use Oracle Internet Directory Self-Service Console to re-create the user, or
     •   Add the orcluser and the orcluserV2 object classes.
2.   Check that there is a value for the attribute orclpassword in the user entry. If
     there is no value, then reset the user's directory password (userpassword
     attribute). This should prompt Oracle Internet Directory to regenerate the
     database password verifier for the user.
3.   Use Oracle Internet Directory Self-Service Console to check that the user search
     base containing this user is listed in the user search base attribute of the realm
     that you are using.




                                                                                          4-30
                                                                                               Chapter 4
                                                                Troubleshooting Enterprise User Security


           4.   Check that the ACL on the user search base attribute allows read and search
                access to the orclpassword attributes by the verifierServices group. This is set
                properly by default, but may have been altered.

           ORA-28275: Multiple mappings for user nickname to LDAP distinguished name
           exist
           Cause: There are multiple user DNs in the directory within the user search base
           whose login name for the user matches what was provided during the database
           connection.

           Action: Use Oracle Internet Directory Self-Service Console to make the login name
           value unique (no two users share the same login name) within all user search bases
           associated with the realm Oracle Context.

           ORA-28277: LDAP search, while authenticating global user with passwords,
           failed
           Cause: As in error message

           Action: Check that the relevant directory instance is up and running.

           ORA-28278: No domain policy registered for password-based GLOBAL users
           Cause: The database cannot read the enterprise domain information that it needs.

           Action: See "DOMAIN-READ-ERROR Checklist"

           ORA-28862: SSL connection failed
           Cause: As in error message

           Action: Check that you are using a non-SSL connect string.


4.7.2 ORA-n Errors for Kerberos-Authenticated Enterprise Users
           If you receive an ORA-n error while using Kerberos-authenticated Enterprise User
           Security, then locate the error in the following section and take the recommended
           action.

           ORA-1017: Invalid username/password; login denied
           Cause: As in error message

           Action: See "USER-SCHEMA ERROR Checklist"

           ORA-28030: Problem accessing LDAP directory service
           Cause: Indicates a problem with the connection between the database and the
           directory.

           Action: See the actions listed for resolving ORA-28030: Server encountered problems
           accessing LDAP directory service in the troubleshooting section for password-
           authenticated enterprise users.

           ORA-28271: No permission to read user entry in LDAP directory service
           Cause: As in error message

           Action: See the actions listed for resolving ORA-28271: No permission to read user
           entry in LDAP directory service in the troubleshooting section for password-
           authenticated enterprise users.




                                                                                                  4-31
                                                                                      Chapter 4
                                                       Troubleshooting Enterprise User Security


ORA-28292: No domain policy registered for Kerberos-based authentication
Cause: As in error message

Action: Perform the following actions:
1.   Use Oracle Enterprise Manager to set the user authentication policy for this
     enterprise domain to KERBEROS or ALL.
2.   See "DOMAIN-READ-ERROR Checklist"

ORA-28290: Multiple entries found for the same Kerberos principal name
Cause: The Kerberos principal name for this user is not unique within the user search
base containing this user.

Action: Use Oracle Internet Directory Self-Service Console to change the Kerberos
principal name, or to change the other copies so that it is unique.

ORA-28291: No Kerberos principal value found
Cause: As in error message

Action: Check the following:
1.   Check that the user entry in the directory has the krbprincipalname attribute.
     If it does not have the krbprincipalname attribute, then check the following:
     •   Check that the default attributes for new user creation by using Oracle
         Internet Directory Self-Service Console include krbprincipalname, and then
     •   Use Oracle Internet Directory Self-Service Console to create the user again,
         or
     •   Add the orclcommonattributes object class.
2.   Check that there is a value for the attribute krbprincipalname in the user entry. If
     there is no value, then use Oracle Internet Directory Self-Service Console to enter
     one.
3.   Use Oracle Internet Directory Self-Service Console to check that the user search
     base containing this user is listed in the realm Oracle Context that you are using.
4.   Check that the ACL on the user search base attribute allows read and search
     access to the krbprincipalname attributes by the verifierServices group. This
     is set properly by default, but may have been altered.

ORA-28293: No matched Kerberos principal found in any user entry.
Cause: As in error message

Action: Check the following:
1.   Check that a user entry exists in Oracle Internet Directory for your user.
2.   Use Oracle Internet Directory Self-Service Console or ldapsearch to check that a
     user search base containing this user is listed in the identity management realm
     that you are using.
3.   Check that the user entry in the directory contains the correct Kerberos principal
     name, by using the following steps:




                                                                                         4-32
                                                                                                 Chapter 4
                                                                  Troubleshooting Enterprise User Security


                •   Use Oracle Internet Directory Self-Service Console to find the Kerberos
                    principal name attribute that is configured for the directory in your realm, and
                •   Check that the correct Kerberos principal name appears in that attribute in the
                    user's directory entry.
           4.   If you have an exclusive schema for the global user in the database, check that
                the DN in the database matches the DN of the user entry in Oracle Internet
                Directory.

           ORA-28300: No permission to read user entry in LDAP directory service
           Cause: As in error message

           Action: Check that the database wallet contains the correct credentials for the
           database-to-directory connection. The wallet DN should be the DN of the database in
           Oracle Internet Directory. To retrieve the credentials, perform the following steps:
           1.   Use the mkstore command-line utility to retrieve the database password for the
                wallet by using the following syntax:
                mkstore -wrl <database wallet location> -viewEntry ORACLE.SECURITY.PASSWORD -
                viewEntry ORACLE.SECURITY.DN
           2.   If these values are incorrect, reset the database wallet by using Database
                Configuration Assistant.
           3.   Use the DN and the password returned by mkstore in the following ldapbind:
                ldapbind -h <directory host> -p <non-SSL directory port> -D "<database DN>" -q
                Please enter bind password: Password returned by mkstore



                       Note:

                       The mkstore utility is for troubleshooting purposes only. The name and
                       functionality of this tool may change in the future.


           ORA-28302: User does not exist in the LDAP directory service
           Cause: As in error message

           Action: Check that the user entry is present in the directory.


4.7.3 ORA-n Errors for SSL-Authenticated Enterprise Users
           If you receive an ORA-n error while using SSL-authenticated Enterprise User Security,
           then locate the error in the following section and perform the recommended action.

           ORA-1017: Invalid username/password; login denied
           Cause: As in error message

           Action: See "USER-SCHEMA ERROR Checklist"

           ORA-28030: Problem accessing LDAP directory service
           Cause: Indicates a problem with the connection between the database and the
           directory.

           Action: Check the following:




                                                                                                    4-33
                                                                                              Chapter 4
                                                               Troubleshooting Enterprise User Security


         1.   Check that there is a correct wallet_location value in the database's
              sqlnet.ora file. If not, then use Oracle Net Manager to enter one.
         2.   If Domain Name System (DNS) server discovery of Oracle Internet Directory is
              not used, then check that there is a correct ldap.ora file
              in $LDAP_ADMIN, $ORACLE_HOME/ldap/admin, $TNS_ADMIN or $ORACLE_HOME/
              network/admin. (See Oracle Fusion Middleware Administrator's Guide for Oracle
              Internet Directory for information about DNS server discovery.)
         3.   Check that the Oracle Internet Directory SSL port used (by way of DNS discovery
              or an ldap.ora file) supports SSL with two-way authentication.
         4.   Check that the LDAP_DIRECTORY_ACCESS parameter is set to SSL in the database
              initialization parameters file.
         5.   Check that the database wallet has autologin enabled. Either use Oracle Wallet
              Manager or check that there is a cwallet.sso file in $ORACLE_HOME/admin/
              <ORACLE_SID>/wallet/.
         6.   Use the mkstore command-line utility to check that the database wallet has the
              database DN in it by using the following syntax:
              mkstore -wrl <database_wallet_location> -viewEntry ORACLE.SECURITY.DN

              If the wallet does not contain the database DN, then use Database Configuration
              Assistant to reregister the database with Oracle Internet Directory.
         7.   Check that the database can bind to Oracle Internet Directory, by using its wallet
              with the following ldapbind:
              ldapbind -h <directory_host> -p <directory_SSLport> -U 3 -W "file:<database
              wallet_location>" -Q
              Please enter SSL wallet password: wallet_password
         8.   Check to ensure that the database belongs to only one enterprise domain.



                     Note:

                     The mkstore utility is for troubleshooting purposes only. The name and
                     functionality of this tool may change in the future.


         ORA-28301: Domain policy has not been registered for SSL authentication
         Cause: As in error message

         Action: Use Oracle Enterprise Manager to set the user authentication policy for this
         enterprise domain to include SSL.

         ORA-28862: SSL handshake failed
         Cause: As in error message

         Action: See the SSL (Secure Sockets Layer) chapter in Oracle Database Security
         Guide for information about configuring your SSL connection.


4.7.4 NO-GLOBAL-ROLES Checklist
         If the enterprise user can connect to the database but a select * from
         session_roles returns no global roles, then check the following:



                                                                                                 4-34
                                                                                                Chapter 4
                                                                 Troubleshooting Enterprise User Security


         1.   Check that the global role has been created in the database. To create global
              roles, use the following syntax:
              CREATE ROLE <role_name> IDENTIFIED GLOBALLY;
         2.   Use Oracle Enterprise Manager to check that the global role is included in an
              enterprise role in the directory.
         3.   Use Oracle Enterprise Manager to check that the enterprise role is assigned to the
              user in the directory.
         4.   If these checks are fine, then see the "DOMAIN-READ-ERROR Checklist".


4.7.5 USER-SCHEMA ERROR Checklist
         If your database cannot read the user schema, then check the following:
         1.   If this is a globally authenticated administrative user who logged in as SYSDBA to
              shut down the database, the database shuts down successfully followed by the
              ORA-01017: invalid username/password; logon denied error, then ensure that
              the sqlnet.ora is configured with the wallet location of the Database-OID wallet.
              An Administrative user login and database shutdown and startup operation using
              this login does happen gracefully when the sqlnet.ora has the wallet location
              explicitly set to the directory where the Database-OID wallet file is present.
         2.   If this is an SSL-authenticated enterprise user, then ensure that the correct user
              wallet is being used by checking the following:
              •   There is no WALLET_LOCATION parameter value in the client sqlnet.ora file,
                  and
              •   The TNS_ADMIN parameter is set properly so that the correct sqlnet.ora file is
                  being used.
         3.   Check that the schema was created in the database as a global user, by using the
              following syntax:
              CREATE USER username IDENTIFIED GLOBALLY AS ' ';

              or by using the following syntax:
              CREATE USER username IDENTIFIED GLOBALLY AS '<DN>';
         4.   Suppose the following is true:
              •   The user schema is an exclusive schema (created with the CREATE USER
                  username IDENTIFIED GLOBALLY AS 'user_DN'; syntax), and
              •   This is an SSL-authenticated user.
              Then, ensure that the DN in the user wallet matches the DN that was used in the
              CREATE USER statement.
              Use Oracle Wallet Manager to view the DN in the user wallet.
              Use the following syntax to view the DN that was used with the CREATE USER
              statement:
              SELECT EXTERNAL_NAME FROM DBA_USERS WHERE USERNAME='schema';
         5.   If you are using a shared schema, then check the following:
              •   Use Oracle Enterprise Manager to ensure that you have created a user-
                  schema mapping either for the entire enterprise domain or for the database.




                                                                                                   4-35
                                                                                             Chapter 4
                                                              Troubleshooting Enterprise User Security


              •   If the user-schema mapping is intended to apply to this database (not to the
                  entire enterprise domain), then check that the database can read its own entry
                  and subtree in the directory.
                  To check this, enter the following ldapsearch command for your database-to-
                  directory connection type:
                  –   If the database connects to the directory over SSL, then use
                      ldapsearch -h directory_host -p directory_SSLport -U 3 -W
                      "file:database_wallet_path" -Q -b "database_DN" "objectclass=*"
                      Please enter SSL wallet password: wallet_password

                      where wallet_password is the password to the wallet, which enables you
                      to open or change the wallet.
                  –   If the database connects to the directory by using password
                      authentication, then use
                      ldapsearch -h directory_host -p directory_port -D database_DN -q -b
                      "database_DN" "objectclass=*"
                      Please enter bind password: database_directory_password

                      where database_directory_password is the database bind password
                      returned by a utility like mkstore.
                  You should see the database entry and the relevant mapping.
              •   If the user-schema mapping applies to the entire enterprise domain rather than
                  to only this individual database, then see "DOMAIN-READ-ERROR Checklist".


4.7.6 DOMAIN-READ-ERROR Checklist
         If your database cannot read its enterprise domain information in Oracle Internet
         Directory, then check the following:
         1.   Use Oracle Enterprise Manager to check that the database is a member of exactly
              one enterprise domain, and add it to one if it is not.
         2.   Check that the database can see its domain, by entering one of the following at
              the command line:
              •   If the database connects to the directory over SSL, then use
                  ldapsearch -h directory_host -p directory_SSLport -U 3 -W
                  "file:database_wallet_path" -Q -b "cn=OracleContext, realm_DN"
                  "objectclass=orclDBEnterpriseDomain"
                  Please enter SSL wallet password: wallet_password

                  where wallet_password is the password to the wallet, which enables you to
                  open or change the wallet.
              •   If the database connects to the directory by using password authentication,
                  then use
                  ldapsearch -h directory_host -p directory_port -D database_DN -q -b
                  "cn=OracleContext, realm_DN" "objectclass=orclDBEnterpriseDomain"
                  Please enter bind password: database_directory_password

                  where database_directory_password is the password in the database wallet,
                  which is the database's password to Oracle Internet Directory.




                                                                                                4-36
                                                                                     Chapter 4
                                                      Troubleshooting Enterprise User Security


     The ldapsearch command should return exactly one enterprise domain.
     If no domain is returned and Oracle Enterprise Manager shows the database as a
     member of a domain, then restart the database. Restarting the database updates
     the cached value for the enterprise domain.
     If more than one domain is returned, then use Oracle Enterprise Manager to
     remove the database from the additional domain.
3.   Check that the database can read the enterprise domain subtree and thus can
     read its enterprise roles and mappings, by entering one of the following at the
     command line:
     •   If the database connects to the directory over SSL, then use
         ldapsearch -h directory_host -p directory_SSLport -U 3 -W
         "file:database_wallet_path" -Q -b "cn=OracleContext, realm_DN"
         "objectclass=orclDBEnterpriseRole"
         Please enter SSL wallet password: wallet_password

         where wallet_password is the password to the wallet, which enables you to
         open or change the wallet.
     •   If the database connects to the directory by using password authentication,
         then use
         ldapsearch -h directory_host -p directory_port -D database_DN -q -b
         "cn=OracleContext, realm_DN" "objectclass=orclDBEnterpriseRole"
         Please enter bind password: database_directory_password

         where database_directory_password is the password in the database wallet,
         which is the database password to Oracle Internet Directory.
     This ldapsearch should return all of the enterprise roles that you have created for
     this domain. If it does not, then use Oracle Enterprise Manager to create
     enterprise roles and mappings.
4.   Use Oracle Enterprise Manager to set or reset the user authentication policy for
     the relevant enterprise domain. See "Configuring User Authentication Types and
     Enabling Current User Database Links" for information about setting the user
     authentication policy for an enterprise domain.




                                                                                        4-37
5
Administering Enterprise User Security
         This chapter describes how to use Oracle Enterprise Manager to administer Enterprise
         User Security in Oracle Databases. This chapter contains the following topics:
         •   Administering Identity Management Realms
         •   Administering Enterprise Users
         •   Configuring User-Defined Enterprise Groups
         •   Configuring Databases for Enterprise User Security
         •   Administering Enterprise Domains


5.1 Administering Identity Management Realms
         An identity management realm is a subtree of directory entries, all of which are
         governed by the same administrative policies. A realm Oracle Context is a subtree in a
         directory identity management realm that contains the data used by any installed
         Oracle product that uses the directory.
         You can set properties of an identity management realm using Oracle Internet
         Directory tools like the Oracle Internet Directory Self-Service Console.
         The Oracle Enterprise Manager Web interface enables you to manage Enterprise User
         Security related entries in an identity management realm.
         This section describes administering identity management realms for Enterprise User
         Security. It contains the following topics:
         •   Identity Management Realm Versions
         •   Setting Properties of an Identity Management Realm
         •   Setting the Default Database-to-Directory Authentication Type for an Identity
             Management Realm
         •   Managing Identity Management Realm Administrators



                Note:
                Do not create users within a realm Oracle Context.




                                                                                             5-1
                                                                                                  Chapter 5
                                                                  Administering Identity Management Realms




                  See Also:

                  •    "How Oracle Internet Directory Implements Identity Management" for a
                       discussion about identity management realms and realm Oracle
                       Contexts and how they are related to one another
                  •    "About Enterprise User Security Directory Entries" for a discussion on
                       the Oracle Internet Directory entries that are used for Enterprise User
                       Security



5.1.1 Identity Management Realm Versions
           Enterprise User Security can only use an identity management realm supplied by
           Oracle Internet Directory 10g (9.0.4), or later, which ships with Oracle Application
           Server 10g (9.0.4), or later. You can manage Enterprise User Security directory entries
           in a version 9.0.4 (or later) identity management realm by using Oracle Enterprise
           Manager for Oracle Database 12c Release 1 (12.1).


5.1.2 Setting Properties of an Identity Management Realm
           An identity management realm has a number of properties that can be viewed and
           managed by using Oracle Internet Directory tools like the Oracle Internet Directory
           Self-Service Console. These properties are described in Table 5-1.

           Table 5-1    Identity Management Realm Properties

           Property                    Description
           Attribute for Login Name    Name of the directory attribute used to store login names. By
                                       default, login names are stored in the uid attribute, but they can
                                       be changed to correspond to your directory configuration. In
                                       previous releases, this was the cn attribute.
           Attribute for Kerberos      Name of the directory attribute used to store Kerberos principal
           Principal Name              names. By default, Kerberos principal names are stored in the
                                       krbPrincipalName directory attribute, but they can be changed
                                       to correspond to your directory configuration by changing
                                       orclCommonKrbPrincipalAttribute in the identity
                                       management realm.
           User Search Base            Full distinguished name (DN) for the node at which enterprise
                                       users are stored in the directory.
           Group Search Base           Full DN for the node at which user groups are stored for this
                                       identity management realm in the directory.
           Version Compatibility       This property is no longer used. However, you should ensure that
                                       it is not set to 81000, because release 8.1.7 and earlier
                                       databases cannot be in the same realm with Oracle Database
                                       10g or later databases.




                                                                                                       5-2
                                                                                                 Chapter 5
                                                                  Administering Identity Management Realms




                    Note:
                    Each identity management realm includes an orcladmin user who is the root
                    user of that realm only. These realm-specific orcladmin users are
                    represented by the directory entries cn=orcladmin,cn=Users,realm_DN.
                    Note that when you are logged in to Enterprise User Security administration
                    tools as a realm-specific orcladmin user, then you can manage only
                    directory objects for that realm. To manage objects in another realm, you
                    must log in to administration tools as the orcladmin user for that realm.

                    This sections includes the following topic: Setting Login Name, Kerberos
                    Principal Name, User Search Base, and Group Search Base Identity
                    Management Realm Attributes.



5.1.2.1 Setting Login Name, Kerberos Principal Name, User Search Base, and
Group Search Base Identity Management Realm Attributes
            Setting these identity management realm attributes enables the database to locate
            Enterprise User Security entries.

            To set Login Name, Kerberos Principal Name, User Search Base, and Group
            Search Base identity management realm attributes:
            1.   Log in to the Oracle Internet Directory Self-Service Console.
                 Enter the URL to access the Oracle Internet Directory Self-Service Console in a
                 browser window. For example:
                 http://myhost1:7777/oiddas

                 Log in as the orcladmin user.
            2.   Click the Configuration tab. Click the Identity Management Realm subtab.
                 The Directory Configuration page appears.
            3.   Enter the appropriate information into the available fields.
            4.   Click Submit to save your changes to the directory.



                    See Also:
                    Oracle Identity Management Guide to Delegated Administration for detailed
                    information on using the Oracle Internet Directory Self-Service Console



5.1.3 Setting the Default Database-to-Directory Authentication Type
for an Identity Management Realm
            The initial value for the LDAP_DIRECTORY_ACCESS parameter is picked from the default
            database-to-directory authentication attribute setting at the realm level. This parameter
            is set on individual databases when they are registered in Oracle Internet Directory.




                                                                                                     5-3
                                                                                                    Chapter 5
                                                                  Administering Identity Management Realms


           The Oracle Enterprise Manager interface enables you to set the authentication
           mechanism that the database uses to authenticate to Oracle Internet Directory. The
           authentication mechanism can be set to password or SSL.

           To set the default database-to-directory authentication type for an identity
           management realm:
           1.   Log in to Enterprise Manager Cloud Control, as an administrative user.
           2.   To navigate to your database, select Databases from the Targets menu.
           3.   Click the database name in the list that appears. The database page appears.
           4.   Under the Administration menu, select Security, Enterprise User Security. The
                Oracle Internet Directory Login page appears.
           5.   Enter the distinguished name (DN) of a directory user who can administer
                enterprise users in the User field. Enter the user password in the Password field.
                Click Login.
                The Enterprise User Security page appears.
           6.   Click OID Realm Administration.
                The OID Realm Administration page appears. The current DB-OID authentication
                method is displayed.
           7.   To change the current DB-OID authentication method, click Change.
                The Realm Configuration page appears.
           8.   Select Password or SSL under DB-OID Authentication.
           9.   If all the databases and clients in the realm are release 10g or higher, you can turn
                off the password verifiers feature. This feature is used by the directory to populate
                an additional password field for pre-10g databases. To turn off password verifiers,
                deselect Password Verifiers.
           10. Click OK.


5.1.4 Managing Identity Management Realm Administrators
           An identity management realm contains administrative groups that have varying levels
           of privileges. The administrative groups for an identity management realm, which
           pertain to Enterprise User Security, are defined in Table 5-2. For more information
           about these groups, see "Administrative Groups".

           Table 5-2    Enterprise User Security Identity Management Realm Administrators

           Administrative Group              Definition
           Oracle Database Registration      Registers new databases in the realm.
           Administrators
           (OracleDBCreators)
           Oracle Database Security          Has all privileges on the OracleDBSecurity directory
           Administrators                    subtree. Creates, modifies, and can read all Enterprise
           (OracleDBSecurityAdmins)          User Security directory objects.

           Oracle Context Administrators     Has full access to all groups and entries within its
           (OracleContextAdmins)             associated realm.




                                                                                                        5-4
                                                                                                Chapter 5
                                                                           Administering Enterprise Users




         Table 5-2 (Cont.) Enterprise User Security Identity Management Realm
         Administrators

          Administrative Group              Definition
          User Security Administrators      Has relevant permissions necessary to administer security
          (OracleUserSecurityAdmins)        aspects for enterprise users in the directory. For example,
                                            OracleUserSecurityAdmins can modify user passwords.

         To manage identity management realm administrators:
         1.   Log in to Enterprise Manager Cloud Control, as an administrative user.
         2.   To navigate to your database, select Databases from the Targets menu.
         3.   Click the database name in the list that appears. The database page appears.
         4.   Under the Administration menu, select Security, Enterprise User Security. The
              Oracle Internet Directory Login page appears.
         5.   Enter the distinguished name (DN) of a directory user who can administer
              enterprise users in the User field. Enter the user password in the Password field.
              Click Login.
              The Enterprise User Security page appears.
         6.   Click OID Realm Administration.
              The OID Realm Administration page appears. This page lists the Enterprise User
              Security related administrative groups in the identity management realm.
         7.   Select the administrative group that you wish to edit. Click Edit.
              The Edit page appears. It lists the directory users that are currently members of
              the group selected in the OID Realm Administration page.
         8.   To add a directory user to the group, click Add.
              The Select Users window appears.
         9.   Select the Search Base. The Search Base is the directory subtree that you wish
              to search for locating the user. Click Go.
         10. Select the user that you wish to add as an administrator. Click Select.

              The user is added in the Edit page.
         11. Click OK.


5.2 Administering Enterprise Users
         This section describes how to use Oracle Internet Directory Self-Service Console and
         Oracle Enterprise Manager to administer enterprise users. It contains the following
         topics:
         •    Creating New Enterprise Users
         •    Setting Enterprise User Passwords
         •    Granting Enterprise Roles to Enterprise Users
         •    Granting Proxy Permissions to Enterprise Users
         •    Creating User-Schema Mappings for Enterprise Users



                                                                                                    5-5
                                                                                               Chapter 5
                                                                          Administering Enterprise Users


           •    Creating Label Authorizations for Enterprise Users


5.2.1 Creating New Enterprise Users
           You can use Oracle Internet Directory tools like the Oracle Internet Directory Self-
           Service Console to create users in the directory.



                   Note:
                   Before creating new enterprise users, you must first define the user search
                   base in the directory and also verify the user create base. See "Setting Login
                   Name, Kerberos Principal Name, User Search Base, and Group Search
                   Base Identity Management Realm Attributes"



           To create new enterprise users:
           1.   Log in to the Oracle Internet Directory Self-Service Console.
                Enter the URL to access the Oracle Internet Directory Self-Service Console in a
                browser window. For example:
                http://myhost1:7777/oiddas

                Log in as the orcladmin user.
           2.   Click the Directory tab. Click the Users subtab.
                The Users page appears.
           3.   Click Create to create a new user.
                The Create User page appears.
           4.   Enter the appropriate user information in the Create User page. Click Submit to
                create a new enterprise user.



                   Note:
                   Note that if your users are authenticated to the database by using Kerberos
                   credentials, and the krbPrincipalName attribute is not there, then see "Task
                   1: Configure Oracle Internet Directory Self-Service Console to display the
                   Kerberos principal name attribute" for information about how to configure
                   this.



5.2.2 Setting Enterprise User Passwords
           You can use Oracle Internet Directory Self-Service Console to set and maintain
           enterprise user passwords in Oracle Internet Directory.
           The enterprise user password is used for:
           •    Directory logon




                                                                                                   5-6
                                                                                                Chapter 5
                                                                           Administering Enterprise Users


           •    Database logon, to databases that support password authentication for global
                users

           To set the password for an enterprise user:
           1.   Log in to the Oracle Internet Directory Self-Service Console.
                Enter the URL to access the Oracle Internet Directory Self-Service Console in a
                browser window. For example:
                http://myhost1:7777/oiddas

                Log in as the orcladmin user.
           2.   Click the Directory tab. Click the Users subtab.
                The Users page appears.
           3.   Enter part of the enterprise user's user name (login name) or e-mail address in the
                Search field. Click Go.
                A list of all users who match your search criteria displays.
           4.   Select the user for whom you wish to create a new password. Click Edit.
                The Edit User page appears.
           5.   Enter the new password in the Password field. Confirm the password in the
                Confirm Password field. Click Submit.


5.2.3 Granting Enterprise Roles to Enterprise Users
           Enterprise roles are directory objects that allow you to group global roles from various
           databases. You can assign enterprise roles to enterprise users, which gives them
           privileges across enterprise databases.
           To grant enterprise roles to enterprise users:
           1.   Log in to Enterprise Manager Cloud Control, as an administrative user.
           2.   To navigate to your database, select Databases from the Targets menu.
           3.   Click the database name in the list that appears. The database page appears.
           4.   Under the Administration menu, select Security, Enterprise User Security. The
                Oracle Internet Directory Login page appears.
           5.   Enter the distinguished name (DN) of a directory user who can administer
                enterprise users in the User field. Enter the user password in the Password field.
                Click Login.
                The Enterprise User Security page appears.
           6.   Click Configure Enterprise Users.
                The Configure Enterprise Users page appears.
           7.   Select the Search Base in which the enterprise user is located. The search base
                is the subtree which contains the enterprise user entry. You can optionally enter
                the common name of the enterprise user in the Name field. Select User in the
                View box. Click Go.
                A list of users with matching criteria appears.
           8.   Select the enterprise user that you wish to configure. Click Configure.




                                                                                                    5-7
                                                                                               Chapter 5
                                                                          Administering Enterprise Users


                The Configure User page appears.
           9.   Click the Enterprise Roles tab.
           10. Click Grant.
                The Select Enterprise Roles window appears.
           11. Select the enterprise role that you wish to grant. Click Select.

           12. Click OK in the Configure User page.


5.2.4 Granting Proxy Permissions to Enterprise Users
           Proxy permissions allow an enterprise user to proxy a local database user, which
           means that the enterprise user can log in to the database as the local database user.
           You can grant proxy permissions to individual users or groups. Proxy permissions are
           especially useful for middle tier applications that operate across multiple databases as
           enterprise users.
           Proxy permissions are created at the enterprise domain level. After creating a proxy
           permission for an enterprise domain, you can grant it to an enterprise user.
           To grant proxy permissions to enterprise users:
           1.   Log in to Enterprise Manager Cloud Control, as an administrative user.
           2.   To navigate to your database, select Databases from the Targets menu.
           3.   Click the database name in the list that appears. The database page appears.
           4.   Under the Administration menu, select Security, Enterprise User Security. The
                Oracle Internet Directory Login page appears.
           5.   Enter the distinguished name (DN) of a directory user who can administer
                enterprise users in the User field. Enter the user password in the Password field.
                Click Login.
                The Enterprise User Security page appears.
           6.   Click Configure Enterprise Users.
                The Configure Enterprise Users page appears.
           7.   Select the Search Base in which the enterprise user is located. The search base
                is the subtree which contains the enterprise user entry. You can optionally enter
                the common name of the enterprise user in the Name field. Select User in the
                View box. Click Go.
                A list of users with matching criteria appears.
           8.   Select the enterprise user that you wish to configure. Click Configure.
                The Configure User page appears.
           9.   Click the Proxy Permissions tab.
           10. Click Grant.

                The Select Proxy Permissions window appears.
           11. Select the Proxy Permission to be granted. The proxy permission must have
                already been created for the enterprise domain. Click Select.
           12. Click OK in the Configure User page.




                                                                                                   5-8
                                                                                               Chapter 5
                                                                          Administering Enterprise Users




5.2.5 Creating User-Schema Mappings for Enterprise Users
           A user-schema mapping maps an enterprise user to a global database schema. When
           the enterprise user logs in to the database, he is connected to the mapped schema, by
           default.
           To create a user-schema mapping:
           1.   Log in to Enterprise Manager Cloud Control, as an administrative user.
           2.   To navigate to your database, select Databases from the Targets menu.
           3.   Click the database name in the list that appears. The database page appears.
           4.   Under the Administration menu, select Security, Enterprise User Security. The
                Oracle Internet Directory Login page appears.
           5.   Enter the distinguished name (DN) of a directory user who can administer
                enterprise users in the User field. Enter the user password in the Password field.
                Click Login.
                The Enterprise User Security page appears.
           6.   Click Configure Enterprise Users.
                The Configure Enterprise Users page appears.
           7.   Select the Search Base in which the enterprise user is located. The search base
                is the subtree which contains the enterprise user entry. You can optionally enter
                the common name of the enterprise user in the Name field. Select User in the
                View box. Click Go.
                A list of users with matching criteria appears.
           8.   Select the enterprise user that you wish to configure. Click Configure.
                The Configure User page appears.
           9.   Click the User-Schema Mappings tab. All user-schema maps that apply to the
                user directly or indirectly are displayed.
                A user can be individually mapped to a schema. Alternatively, you can map a
                directory subtree containing multiple users to the database schema.
           10. Click Create.

                The Create Mapping page is displayed.
           11. Under the From section, select Users to map an individual enterprise user to a
                database schema. Alternatively, select Subtree to map a directory subtree
                containing multiple users.
           12. Under To, select Database to map to a database schema. Select Domain to map
                to a schema common to all databases in the enterprise domain.
                You can have multiple databases in an enterprise domain that have a common
                schema name. When you map an enterprise user to such a schema, the
                enterprise user is automatically mapped to the individual schemas in each
                database contained in the domain.
           13. If you selected Database in the preceding step, then select the name of the
                database that contains the schema. Next, enter the database schema name. You
                can also use the search icon to select the schema. You will be required to log in to
                the database to select the schema.



                                                                                                   5-9
                                                                                                   Chapter 5
                                                                  Configuring User-Defined Enterprise Groups


                If you selected Domain in the preceding step, then select the name of the domain
                and enter the common schema name in the Schema field.
           14. Click Continue in the Create Mapping page.

           15. Click OK in the Configure User page.


5.2.6 Creating Label Authorizations for Enterprise Users
           An Oracle Label Security (OLS) policy stored in the directory can have multiple profiles
           associated with it. Each profile is a set of policy authorizations and privileges. These
           policy authorizations and privileges apply to all enterprise users who belong to the
           profile. You can assign a profile to an enterprise user.
           To assign label authorizations to an enterprise user:
           1.   Log in to Enterprise Manager Cloud Control, as an administrative user.
           2.   To navigate to your database, select Databases from the Targets menu.
           3.   Click the database name in the list that appears. The database page appears.
           4.   Under the Administration menu, select Security, Enterprise User Security. The
                Oracle Internet Directory Login page appears.
           5.   Enter the distinguished name (DN) of a directory user who can administer
                enterprise users in the User field. Enter the user password in the Password field.
                Click Login.
                The Enterprise User Security page appears.
           6.   Click Configure Enterprise Users.
                The Configure Enterprise Users page appears.
           7.   Select the Search Base in which the enterprise user is located. The search base
                is the subtree which contains the enterprise user entry. You can optionally enter
                the common name of the enterprise user in the Name field. Select User in the
                View box. Click Go.
                A list of users with matching criteria appears.
           8.   Select the enterprise user that you wish to configure. Click Configure.
                The Configure User page appears.
           9.   Click the Label Authorizations tab.
                A list of all user profiles associated with the user is displayed.
           10. Click Add.

                The Select User Profile window appears.
           11. Select the user profiles that you want the user to be added to, and click Select.
                You can only select one profile per policy.
           12. Click OK in the Configure User page.


5.3 Configuring User-Defined Enterprise Groups
           User-defined enterprise groups help group together enterprise users that require the
           same roles or privileges across enterprise databases. Enterprise groups are stored in
           the directory.



                                                                                                      5-10
                                                                                                   Chapter 5
                                                          Configuring Databases for Enterprise User Security


           This section includes the following topic: Granting Enterprise Roles to User-Defined
           Enterprise Groups.


5.3.1 Granting Enterprise Roles to User-Defined Enterprise Groups
           Enterprise roles are directory objects that allow you to group global roles from various
           databases. You can assign an enterprise role to an enterprise group, which gives the
           group members privileges across enterprise databases.
           To grant an enterprise role to an enterprise group:
           1.   Log in to Enterprise Manager Cloud Control, as an administrative user.
           2.   To navigate to your database, select Databases from the Targets menu.
           3.   Click the database name in the list that appears. The database page appears.
           4.   Under the Administration menu, select Security, Enterprise User Security. The
                Oracle Internet Directory Login page appears.
           5.   Enter the distinguished name (DN) of a directory user who can administer
                enterprise users in the User field. Enter the user password in the Password field.
                Click Login.
                The Enterprise User Security page appears.
           6.   Click Configure User Defined Enterprise Groups.
                The Configure Enterprise Groups page appears.
           7.   Select the Search Base in which the enterprise group is located. The search base
                is the subtree which contains the enterprise group entry. Optionally, enter the
                common name of the enterprise group in the Name field. Select Group in the View
                box. Click Go.
                A list of groups with matching criteria appears.
           8.   Select the enterprise group that you wish to configure. Click Configure.
                The Configure Group page appears.
           9.   Click the Enterprise Roles tab.
                A list of enterprise roles granted to the enterprise group is displayed.
           10. Click Grant to grant a new enterprise role to the group.

                The Select Enterprise Roles window appears.
           11. Select the enterprise roles that you wish to grant. Click Select.

           12. Click OK in the Configure Group page.


5.4 Configuring Databases for Enterprise User Security
           Enterprise User Security for databases registered with Oracle Internet Directory can
           be configured using Enterprise Manager. You can map users or subtrees to database
           schemas. You can also configure administrators in the directory that can modify
           schema mappings and enterprise domain membership of the database.
           See the following sections for more information:
           •    Creating User-Schema Mappings for a Database




                                                                                                      5-11
                                                                                                Chapter 5
                                                       Configuring Databases for Enterprise User Security


          •    Adding Administrators to Manage Database Schema Mappings


5.4.1 Creating User-Schema Mappings for a Database
          A user-schema mapping maps an enterprise user to a global schema in the database.
          When the enterprise user logs in to the database, he is connected to the mapped
          schema, by default.
          To create a user-schema mapping:
          1.   Log in to Enterprise Manager Cloud Control, as an administrative user.
          2.   To navigate to your database, select Databases from the Targets menu.
          3.   Click the database name in the list that appears. The database page appears.
          4.   Under the Administration menu, select Security, Enterprise User Security. The
               Oracle Internet Directory Login page appears.
          5.   Enter the distinguished name (DN) of a directory user who can administer
               enterprise users in the User field. Enter the user password in the Password field.
               Click Login.
               The Enterprise User Security page appears.
          6.   Click Configure Databases.
               The Configure Databases page appears. A list of databases registered in the
               identity management realm is displayed.
          7.   Select the database name. Click Configure.
               The Configure Database page appears.
          8.   Click the User-Schema Mappings tab. All user-schema maps created at the
               database level are displayed. User-schema maps created at the enterprise domain
               levels are not displayed here.
          9.   Click Create to create a new user-schema mapping for the database.
               The Create Mapping page is displayed.
          10. Under the From section, select Users to map an individual enterprise user to a
               database schema. Alternatively, select Subtree to map a directory subtree
               containing multiple users. You can use the Search icon to search for the
               appropriate user or subtree.
          11. Under the To section, enter the name of the Schema to which the user or subtree
               should be mapped. You can use the search icon to search for the appropriate
               schema in the database. You will be required to log in to the database to access
               the schema names.
          12. Click Continue in the Create Mapping page.

          13. Click OK in the Configure Database page.


5.4.2 Adding Administrators to Manage Database Schema Mappings
          Directory users who are authorized to manage database schema mappings for a
          database can create or delete database schema mappings for the database.
          To add administrators for managing database schema mappings:




                                                                                                   5-12
                                                                                            Chapter 5
                                                                     Administering Enterprise Domains


         1.   Log in to Enterprise Manager Cloud Control, as an administrative user.
         2.   To navigate to your database, select Databases from the Targets menu.
         3.   Click the database name in the list that appears. The database page appears.
         4.   Under the Administration menu, select Security, Enterprise User Security. The
              Oracle Internet Directory Login page appears.
         5.   Enter the distinguished name (DN) of a directory user who can administer
              enterprise users in the User field. Enter the user password in the Password field.
              Click Login.
              The Enterprise User Security page appears.
         6.   Click Configure Databases.
              The Configure Databases page appears. A list of databases registered in the
              identity management realm is displayed.
         7.   Select the database name. Click Configure.
              The Configure Database page appears.
         8.   Click the Administrators tab. A list of administrators who can manage database
              schema mappings is displayed.
         9.   Click Add to add an administrator.
              The Select Users window appears.
         10. Select the Search Base. The Search Base is the directory subtree that you wish
              to search for locating the user. Click Go.
         11. Select the user that you wish to add as an administrator. Click Select.

              The user is added in the Configure Database page.
         12. If you want the user to be able to add or remove other administrators, then select
              the Admin Group Owner check box corresponding to the added user.
         13. Click OK.


5.5 Administering Enterprise Domains
         Enterprise Domains are groups of databases that can share enterprise roles, proxy
         permissions, user-schema mappings, current user database links, and permitted
         authentication mechanisms. A database can belong to only one enterprise domain.
         An enterprise domain can be thought of as an administrative domain, administered by
         the Domain Admins group for that domain. These administrators can add databases to
         the enterprise domain.
         An identity management realm contains an enterprise domain called
         OracleDefaultDomain. OracleDefaultDomain is part of the realm when it is first
         created in the directory. When a new database is registered into a realm, it
         automatically becomes a member of OracleDefaultDomain in that realm. You can
         create and remove your own enterprise domains, but you must not remove
         OracleDefaultDomain from a realm.

         This section describes how to use Oracle Enterprise Manager to administer enterprise
         domains in the directory. It contains the following topics:
         •    Creating an Enterprise Domain




                                                                                               5-13
                                                                                              Chapter 5
                                                                       Administering Enterprise Domains


           •    Adding Databases to an Enterprise Domain
           •    Creating User-Schema Mappings for an Enterprise Domain
           •    Configuring Enterprise Roles
           •    Configuring Proxy Permissions
           •    Configuring User Authentication Types and Enabling Current User Database Links
           •    Configuring Domain Administrators


5.5.1 Creating an Enterprise Domain
           An enterprise domain is an administrative domain of databases that can share
           enterprise roles, proxy permissions, user-schema mappings, current user database
           links, and permitted authentication mechanisms.
           If you do not want to use OracleDefaultDomain, then you can create a new enterprise
           domain in your identity management realm.
           To create an enterprise domain:
           1.   Log in to Enterprise Manager Cloud Control, as an administrative user.
           2.   To navigate to your database, select Databases from the Targets menu.
           3.   Click the database name in the list that appears. The database page appears.
           4.   Under the Administration menu, select Security, Enterprise User Security. The
                Oracle Internet Directory Login page appears.
           5.   Enter the distinguished name (DN) of a directory user who can administer
                enterprise users in the User field. Enter the user password in the Password field.
                Click Login.
                The Enterprise User Security page appears.
           6.   Click Manage Enterprise Domains.
                The Manage Enterprise Domains page appears. This page lists the enterprise
                domains in the identity management realm.
           7.   Click Create to create a new enterprise domain.
                The Create Domain page appears.
           8.   Enter the name for the new enterprise domain in the Name field. Click OK.
                The new enterprise domain is added to the list of enterprise domains in the
                Enterprise Domains page.


5.5.2 Adding Databases to an Enterprise Domain
           A member of the Domain Admins group can add databases to the enterprise domain.
           You can add databases to an enterprise domain from the Configure Domain page.
           You can also add databases from the Create Domain page, if you are creating a new
           enterprise domain.




                                                                                                 5-14
                                                                                              Chapter 5
                                                                       Administering Enterprise Domains




                   Note:
                   The following restrictions apply to adding databases to an enterprise domain:
                   •   You can add a database to an enterprise domain only if both the
                       database and the enterprise domain exist in the same realm.
                   •   A database cannot be added as a member of two different enterprise
                       domains.


           To add databases to an enterprise domain:
           1.   Log in to Enterprise Manager Cloud Control, as an administrative user.
           2.   To navigate to your database, select Databases from the Targets menu.
           3.   Click the database name in the list that appears. The database page appears.
           4.   Under the Administration menu, select Security, Enterprise User Security. The
                Oracle Internet Directory Login page appears.
           5.   Enter the distinguished name (DN) of a directory user who can administer
                enterprise users in the User field. Enter the user password in the Password field.
                Click Login.
                The Enterprise User Security page appears.
           6.   Click Manage Enterprise Domains.
                The Manage Enterprise Domains page appears. This page lists the enterprise
                domains in the identity management realm.
           7.   Select the enterprise domain that you wish to configure. Click Configure.
                The Configure Domain page appears.
           8.   Make sure that the Databases tab is selected. Click Add to add new databases to
                the enterprise domain.
                The Select Databases page appears. A list of databases, that are registered with
                the identity management realm, is displayed. You can add a database only if it is
                not part of any other enterprise domain.
           9.   Select the databases to add. Click Select.
           10. Click OK in the Configure Domain page.


5.5.3 Creating User-Schema Mappings for an Enterprise Domain
           A user-schema mapping maps an enterprise user to a global schema in the database.
           When the enterprise user logs in to the database, he is connected to the mapped
           schema, by default.
           When you create a user-schema mapping for an enterprise domain, it applies to all
           databases in the domain. However, for the mapping to be effective in a database, that
           database must have a schema with the name used in the mapping.
           To create a user-schema mapping for an enterprise domain:
           1.   Log in to Enterprise Manager Cloud Control, as an administrative user.




                                                                                                 5-15
                                                                                              Chapter 5
                                                                       Administering Enterprise Domains


           2.   To navigate to your database, select Databases from the Targets menu.
           3.   Click the database name in the list that appears. The database page appears.
           4.   Under the Administration menu, select Security, Enterprise User Security. The
                Oracle Internet Directory Login page appears.
           5.   Enter the distinguished name (DN) of a directory user who can administer
                enterprise users in the User field. Enter the user password in the Password field.
                Click Login.
                The Enterprise User Security page appears.
           6.   Click Manage Enterprise Domains.
                The Manage Enterprise Domains page appears. This page lists the enterprise
                domains in the identity management realm.
           7.   Select the enterprise domain that you wish to configure. Click Configure.
                The Configure Domain page appears.
           8.   Click the User-Schema Mappings tab. All user-schema maps created at the
                domain level are displayed. User-schema maps created at database levels are not
                displayed here.
           9.   Click Create to create a new user-schema mapping for the domain.
                The Create Mapping page is displayed.
           10. Under the From section, select Users to map an individual enterprise user to a
                database schema. Alternatively, select Subtree to map a directory subtree
                containing multiple users. You can use the Search icon to search for the
                appropriate user or subtree.
           11. Under the To section, enter the name of the Schema to which the user or subtree
                should be mapped.
           12. Click Continue in the Create Mapping page.

           13. Click OK in the Configure Domain page.


5.5.4 Configuring Enterprise Roles
           An enterprise domain within an identity management realm can contain multiple
           enterprise roles. An enterprise role is a set of Oracle role-based authorizations across
           one or more databases in an enterprise domain.
           Enterprise roles allow you to group global roles from different databases that are part
           of the enterprise domain. Enterprise roles can be assigned to enterprise users.
           To create enterprise roles:
           1.   Log in to Enterprise Manager Cloud Control, as an administrative user.
           2.   To navigate to your database, select Databases from the Targets menu.
           3.   Click the database name in the list that appears. The database page appears.
           4.   Under the Administration menu, select Security, Enterprise User Security. The
                Oracle Internet Directory Login page appears.
           5.   Enter the distinguished name (DN) of a directory user who can administer
                enterprise users in the User field. Enter the user password in the Password field.
                Click Login.




                                                                                                 5-16
                                                                                    Chapter 5
                                                             Administering Enterprise Domains


     The Enterprise User Security page appears.
6.   Click Manage Enterprise Domains.
     The Manage Enterprise Domains page appears. This page lists the enterprise
     domains in the identity management realm.
7.   Select the enterprise domain that you wish to configure. Click Configure.
     The Configure Domain page appears.
8.   Click the Enterprise Roles tab.
9.   Click Create to create a new enterprise role.
     The Create Enterprise Role page appears.
10. Enter a name for the enterprise role in the Name field. Click Continue.

     The new role is displayed in the Configure Domain page.
Next, you can configure the enterprise role that you just created. Configuring an
enterprise role includes adding database global roles to the enterprise role and
assigning the enterprise role to enterprise users or groups.
To add database global roles to the enterprise role:
1.   Select the enterprise role that you just created in the Configure Domain page.
     Click Edit.
     The Edit Enterprise Role page is displayed.
2.   Make sure that the DB Global Roles tab is selected. Click Add to add global roles
     from databases that are part of the enterprise domain.
     The Search and Select Database Global Roles page appears.
3.   Select the Database that contains the global roles you wish to add. Log in to the
     selected database by supplying a User Name and Password. Click Go.
4.   Select the global roles to add. Click Select.
     The selected roles appear in the Edit Enterprise Role page.
5.   Repeat Steps 2 to 4 for the other databases.
You can now assign the enterprise role to enterprise users or groups.
To assign the enterprise role to enterprise users or groups:
1.   Click the Grantees tab in the Edit Enterprise Role page.
2.   Click Add.
     The Select Users or Groups page is displayed.
3.   Select the Search Base or the subtree that contains the user or group. Select
     User under View if you are granting the enterprise role to a user. Select Group
     under View, if you are granting the role to a group. Optionally, enter the common
     name of the user or group in the Name field. Click Go.
4.   Select the users or groups to be granted the enterprise role. Click Select.
5.   Click Continue in the Edit Enterprise Role page.
6.   Click OK in the Configure Domain page.




                                                                                       5-17
                                                                                              Chapter 5
                                                                       Administering Enterprise Domains




5.5.5 Configuring Proxy Permissions
           Proxy permissions are created at the enterprise domain level. Proxy permissions allow
           an enterprise user to proxy a local database user, which means that the enterprise
           user can log in to the database as the local database user. You can grant proxy
           permissions to individual enterprise users or groups. Proxy permissions are especially
           useful for middle tier applications that operate across multiple databases as enterprise
           users.
           To create a proxy permission for an enterprise domain:
           1.   Log in to Enterprise Manager Cloud Control, as an administrative user.
           2.   To navigate to your database, select Databases from the Targets menu.
           3.   Click the database name in the list that appears. The database page appears.
           4.   Under the Administration menu, select Security, Enterprise User Security. The
                Oracle Internet Directory Login page appears.
           5.   Enter the distinguished name (DN) of a directory user who can administer
                enterprise users in the User field. Enter the user password in the Password field.
                Click Login.
                The Enterprise User Security page appears.
           6.   Click Manage Enterprise Domains.
                The Manage Enterprise Domains page appears. This page lists the enterprise
                domains in the identity management realm.
           7.   Select the enterprise domain that you wish to configure. Click Configure.
                The Configure Domain page appears.
           8.   Click the Proxy Permissions tab.
           9.   Click Create to create a new proxy permission.
                The Create Proxy Permission page appears.
           10. Enter the name for the proxy permission in the Name field. Click Continue.

                The proxy permission appears in the Configure Domain page.
           Next, you need to add target database users for the permission. You also need to
           grant the permission to enterprise users or groups, who can then proxy the target
           database users.
           To add target database users for the proxy permission:
           1.   Select the proxy permission that you just created in the Configure Domain page.
                Click Edit.
                The Edit Proxy Permissions page appears.
           2.   Ensure that the Target DB Users tab is selected. Click Add.
                The Search and Select window appears. A list of all database users that have
                been altered to allow enterprise user proxy is displayed.
           3.   Select the target database users that you wish to proxy. Click Select.
           You can now grant the proxy permission to enterprise users or groups.




                                                                                                 5-18
                                                                                              Chapter 5
                                                                       Administering Enterprise Domains


           To grant the proxy permission to an enterprise user or group:
           1.   Click the Grantees tab in the Edit Proxy Permission page.
           2.   Click Add.
                The Select Users or Groups window appears.
           3.   Select the Search Base or the subtree that contains the user or group. Select
                User under View if you are granting the proxy permission to a user. Select Group
                under View, if you are granting the proxy permission to a group. Optionally, enter
                the common name of the user or group in the Name field. Click Go.
           4.   Select the Users or Groups to grant them the proxy permission. Click Select.
           5.   Click Continue in the Edit Proxy Permission page.
           6.   Click OK in the Configure Domain page.


5.5.6 Configuring User Authentication Types and Enabling Current
User Database Links
           Enterprise users can be authenticated using password authentication, SSL
           authentication, or Kerberos authentication. You can set the authentication modes that
           are allowed for an enterprise domain using Enterprise Manager. You can also enable
           current user database links for databases in the enterprise domain. These links enable
           databases to trust each other to authenticate users.
           To configure user authentication types and enable current user database links:
           1.   Log in to Enterprise Manager Cloud Control, as an administrative user.
           2.   To navigate to your database, select Databases from the Targets menu.
           3.   Click the database name in the list that appears. The database page appears.
           4.   Under the Administration menu, select Security, Enterprise User Security. The
                Oracle Internet Directory Login page appears.
           5.   Enter the distinguished name (DN) of a directory user who can administer
                enterprise users in the User field. Enter the user password in the Password field.
                Click Login.
                The Enterprise User Security page appears.
           6.   Click Manage Enterprise Domains.
                The Manage Enterprise Domains page appears. This page lists the enterprise
                domains in the identity management realm.
           7.   Select the enterprise domain that you wish to configure. Click Configure.
                The Configure Domain page appears.
           8.   Click the Configuration tab.
           9.   Under User Authentication Types Accepted, select the authentication types that
                you want to allow.
           10. If you wish to enable current user database links for the domain, then select
                Enable Current User Database Links in this domain.
           11. Click OK.




                                                                                                 5-19
                                                                                               Chapter 5
                                                                        Administering Enterprise Domains




5.5.7 Configuring Domain Administrators
           Domain administrators have full privileges in the domain. They can add or remove
           databases to the domain, create user-schema mappings, manage proxy permissions
           and modify domain configuration settings. You can add or remove domain
           administrators from Enterprise Manager.
           To add an enterprise domain administrator:
           1.   Log in to Enterprise Manager Cloud Control, as an administrative user.
           2.   To navigate to your database, select Databases from the Targets menu.
           3.   Click the database name in the list that appears. The database page appears.
           4.   Under the Administration menu, select Security, Enterprise User Security. The
                Oracle Internet Directory Login page appears.
           5.   Enter the distinguished name (DN) of a directory user who can administer
                enterprise users in the User field. Enter the user password in the Password field.
                Click Login.
                The Enterprise User Security page appears.
           6.   Click Manage Enterprise Domains.
                The Manage Enterprise Domains page appears. This page lists the enterprise
                domains in the identity management realm.
           7.   Select the enterprise domain that you wish to configure. Click Configure.
                The Configure Domain page appears.
           8.   Click the Administrators tab. A list of administrators for the enterprise domain is
                displayed.
           9.   Click Add to add an administrator.
                The Select Users window appears.
           10. Select the Search Base. The Search Base is the directory subtree that you wish
                to search for locating the user. Click Go.
           11. Select the user that you wish to add as an administrator. Click Select.

                The user is added in the Configure Domain page.
           12. If you want the user to be able to add or remove other administrators, then select
                the Admin Group Owner check box corresponding to the added user.
           13. Click OK.




                                                                                                  5-20
6
Using Oracle Wallet Manager
         This chapter covers:
         •   About Oracle Wallet Manager
         •   Starting Oracle Wallet Manager
         •   General Process for Creating an Oracle Wallet
         •   Managing Oracle Wallets
         •   Managing Certificates for Oracle Wallets



                See Also:

                •   Oracle Database Security Guide in the section that discusses all of the
                    Oracle PKI components
                •   Oracle Database Security Guide in the appendix for information about
                    the orapki command-line utility you can use to create wallets and issue
                    certificates for testing purposes
                •   Oracle Database Licensing Information for licensing information about
                    the use of Oracle Wallet Manager



6.1 About Oracle Wallet Manager
         This section contains:
         •   What Is Oracle Wallet Manager?
         •   Wallet Password Management
         •   Strong Wallet Encryption
         •   Microsoft Windows Registry Wallet Storage
         •   ACL Settings Needed for Wallet Files Created Using Wallet Manager
         •   Backward Compatibility
         •   Public-Key Cryptography Standards (PKCS) Support
         •   Multiple Certificate Support
         •   LDAP Directory Support




                                                                                              6-1
                                                                                           Chapter 6
                                                                         About Oracle Wallet Manager




                  See Also:
                  Oracle Database Security Guide for information about public key
                  infrastructure in an Oracle environment



6.1.1 What Is Oracle Wallet Manager?
           You can use Oracle Wallet Manager to manage public key security credentials on
           Oracle clients and servers. The wallets it creates can be read by Oracle Database,
           Oracle Application Server, and the Oracle Identity Management infrastructure.
           Oracle Wallet Manager enables wallet owners to manage and edit the security
           credentials in their Oracle wallets. A wallet is a password-protected container used to
           store authentication and signing credentials, including private keys, certificates, and
           trusted certificates needed by SSL. You can use Oracle Wallet Manager to perform the
           following tasks:
           •   Creating wallets
           •   Generating certificate requests
           •   Opening wallets to access PKI-based services
           •   Saving credentials to hardware security modules, by using APIs that comply with
               the Public-Key Cryptography Standards #11 (PKCS #11) specification
           •   Uploading wallets to (and downloading them from) an LDAP directory
           •   Importing third-party PKCS #12 -format wallets
           •   Exporting Oracle wallets to a third-party environment


6.1.2 Wallet Password Management
           Oracle wallets are password protected. Oracle Wallet Manager includes an enhanced
           wallet password management module that enforces Password Management Policy
           guidelines, including the following:
           •   Minimum password length (8 characters)
           •   Maximum password length unlimited
           •   Alphanumeric character mix required


6.1.3 Strong Wallet Encryption
           Oracle Wallet Manager stores private keys associated with X.509 certificates and uses
           AES encryption.


6.1.4 Microsoft Windows Registry Wallet Storage
           Oracle Wallet Manager lets you store multiple Oracle wallets in a Windows file
           management system or in the user profile area of the Microsoft Windows system
           registry. Storing your wallets in the registry provides the following benefits:




                                                                                                6-2
                                                                                             Chapter 6
                                                                           About Oracle Wallet Manager


           •   Better Access Control: Wallets stored in the user profile area of the registry are
               only accessible by the associated user. User access controls for the system thus
               become, by extension, access controls for the wallets. In addition, when a user
               logs out of a system, access to that user's wallets is effectively precluded.
           •   Easier Administration: Wallets are associated with specific user profiles, so no
               file permissions need to be managed, and the wallets stored in the profile are
               automatically deleted when the user profile is deleted. You can use Oracle Wallet
               Manager to create and manage the wallets in the registry.
           The supported options are as follows:
           •   Open a wallet from the registry
           •   Save a wallet to the registry
           •   Save As to a different registry location
           •   Delete a wallet from the registry
           •   Open a wallet from the file system and save it to the registry
           •   Open a wallet from the registry and save it to the file system



                  See Also:
                  Oracle Database Platform Guide for Microsoft Windows



6.1.5 ACL Settings Needed for Wallet Files Created Using Wallet
Manager
           On Microsoft Windows systems, beginning with Oracle Database 12c (Release 12.1),
           you may need to set file system ACLs manually, for example to grant access to wallets
           in the file system created using Wallet Manager. As Oracle Database services now run
           under a low-privileged user, a file may not be accessible by Oracle Database services
           unless the file system Access Control Lists (ACLs) grant access to the file. Though
           Oracle installation configures the ACLs in a way to ensure that you do not have to
           change ACLs manually for typical usage, it may be necessary to change ACLs
           manually.



                  See:
                  Oracle Database Platform Guide for Microsoft Windows for more information
                  about setting File System ACLs manually



6.1.6 Backward Compatibility
           Oracle Wallet Manager is backward-compatible to Release 8.1.7.




                                                                                                  6-3
                                                                                             Chapter 6
                                                                           About Oracle Wallet Manager




6.1.7 Public-Key Cryptography Standards (PKCS) Support
            RSALaboratories, a division of RSA Security, Inc., has developed, in cooperation with
            representatives from industry, academia, and government, a family of basic
            cryptography standards called Public-Key Cryptography Standards, or PKCS for short.
            These standards establish interoperability between computer systems that use public-
            key technology to secure data across intranets and the Internet.
            Oracle Wallet Manager stores X.509 certificates and private keys in PKCS #12 format,
            and generates certificate requests according to the PKCS #10 specification. These
            capabilities make the Oracle wallet structure interoperable with supported third-party
            PKI applications and provide wallet portability across operating systems.
            Oracle Wallet Manager wallets can store credentials on hardware security modules
            that use APIs conforming to the PKCS #11 specification. When a wallet is created with
            PKCS11 chosen as the wallet type, then all keys stored in that wallet are saved to a
            hardware security module or token. Examples of such hardware devices include smart
            cards, PCMCIA cards, smart diskettes, or other portable hardware devices that store
            private keys or perform cryptographic operations (or both).



                   Note:
                   To use Oracle Wallet Manager with PKCS #11 integration on the 64-bit
                   Solaris Operating System, enter the following at the command line:
                   owm -pkcs11




                   See Also:

                   •   "Importing User Certificates Created with a Third-Party Tool"
                   •   "Exporting an Oracle Wallet to a Third-Party Environment"
                   •   "Creating an Oracle Wallet to Store Hardware Security Module
                       Credentials"
                   •   To view PKCS standards documents, navigate to the following URL:
                       PKCS Standards Documents




6.1.8 Multiple Certificate Support
            Oracle Wallet Manager enables you to store multiple certificate s in each wallet,
            supporting any of the following Oracle PKI certificate usages:
            •   SSL authentication
            •   S/MIME signature
            •   S/MIME encryption
            •   Code-Signing




                                                                                                  6-4
                                                                                            Chapter 6
                                                                        About Oracle Wallet Manager


•       CA Certificate Signing
Each certificate request you create generates a unique private/public key pair. The
private key stays in the wallet and the public key is sent with the request to a certificate
authority. When that certificate authority generates your certificate and signs it, you
can import it only into the wallet that has the corresponding private key.
If the wallet also contains a separate certificate request, the private/public key pair
corresponding to that request is of course different from the pair for the first certificate
request. Sending this separate certificate request to a certificate authority can get you
a separate signed certificate, which you can import into this same wallet
A single certificate request can be sent to a certificate authority multiple times to obtain
multiple certificates. However, only one certificate corresponding to that certificate
request can be installed in the wallet.
Oracle Wallet Manager uses the X.509 Version 3 KeyUsage extension to define Oracle
PKI certificate usages (Table 6-1). A single certificate cannot be applied to all possible
certificate usages. Table 6-2 and Table 6-3 show legal usage combinations.

Table 6-1       KeyUsage Values

    Value                Usage
    0                    digitalSignature
    1                    nonRepudiation
    2                    keyEncipherment
    3                    dataEncipherment
    4                    keyAgreement
    5                    keyCertSign
    6                    cRLSign
    7                    encipherOnly
    8                    decipherOnly

When installing a certificate, Oracle Wallet Manager maps the KeyUsage extension
values to Oracle PKI certificate usages as specified in Table 6-2 and Table 6-3.

Table 6-2       Oracle Wallet Manager Import of User Certificates to an Oracle Wallet

 KeyUsage Value                  Critical?1 Usage
none                             NA         Certificate is importable for SSL or S/MIME
                                            encryption use.
0 alone or along with any        NA         Accept certificate for S/MIME signature or code-
values excluding 5 and 2                    signing use.
1 alone                          Yes        Not importable
1 alone                          No         Accept certificate for S/MIME signature or code-
                                            signing use.
2 alone or along with any        NA         Accept certificate for SSL or S/MIME encryption use.
combination excluding 5
5 alone or along with any        NA         Accept certificate for CA certificate signing use.
other values




                                                                                                 6-5
                                                                                                                   Chapter 6
                                                                                            About Oracle Wallet Manager




           Table 6-2 (Cont.) Oracle Wallet Manager Import of User Certificates to an
           Oracle Wallet

               KeyUsage Value                   Critical?1 Usage
               Any settings not listed          Yes           Not importable.
               previously
               Any settings not listed          No            Certificate is importable for SSL or S/MIME
               previously                                     encryption use.

           1
                If the KeyUsage extension is critical, the certificate cannot be used for other purposes.


           Table 6-3        Oracle Wallet Manager Import of Trusted Certificates to an Oracle
           Wallet

               KeyUsage Value                 Critical?1 Usage
               none                           NA            Importable.
               Any combination excluding Yes                Not importable.
               5
               Any combination excluding No                 Importable
               5
               5 alone or along with any      NA            Importable.
               other values

           1
                If the KeyUsage extension is marked critical, the certificate cannot be used for other purposes.


           You should obtain, from the certificate authority, certificates with the correct KeyUsage
           value matching your required Oracle PKI certificate usage. A single wallet can contain
           multiple key pairs for the same usage. Each certificate can support multiple Oracle PKI
           certificate usages, as indicated by Table 6-2 and Table 6-3. Oracle PKI applications
           use the first certificate containing the required PKI certificate usage.
           For example, for SSL usage, the first certificate containing the SSL Oracle PKI
           certificate usage is used.
           If you do not have a certificate with SSL usage, then an ORA-28885 error (No
           certificate with required key usage found) is returned.


6.1.9 LDAP Directory Support
           Oracle Wallet Manager can upload wallets to and retrieve them from an LDAP-
           compliant directory. Storing wallets in a centralized LDAP-compliant directory lets
           users access them from multiple locations or devices, ensuring consistent and reliable
           user authentication while providing centralized wallet management throughout the
           wallet life cycle. To prevent a user from accidentally overwriting functional wallets, only
           wallets containing an installed certificate can be uploaded.
           Directory user entries must be defined and configured in the LDAP directory before
           Oracle Wallet Manager can be used to upload or download wallets for a user. If a
           directory contains Oracle8i (or prior) users, then they are automatically upgraded to
           use the wallet upload and download feature on first use.




                                                                                                                       6-6
                                                                                                Chapter 6
                                                                          Starting Oracle Wallet Manager


         Oracle Wallet Manager downloads a user wallet by using a simple password-based
         connection to the LDAP directory. However, for uploads it uses an SSL connection if
         the open wallet contains a certificate with SSL Oracle PKI certificate usage. If an SSL
         certificate is not present in the wallet, password-based authentication is used.



                    Note:
                    The directory password and the wallet password are independent and can be
                    different. Oracle recommends that these passwords be maintained to be
                    consistently different, where neither one can logically be derived from the
                    other.




                    See Also:

                    •   "Uploading an Oracle Wallet to an LDAP Directory".
                    •   "Downloading an Oracle Wallet from an LDAP Directory"
                    •   "Multiple Certificate Support", for more information about Oracle PKI
                        certificate usage.



6.2 Starting Oracle Wallet Manager
         To start Oracle Wallet Manager:
         •    (UNIX) At the command line, enter the following command:
              owm

              To use Oracle Wallet Manager with PKCS #11 integration on the 64-bit Solaris
              Operating System, enter this command:
              owm -pkcs11

              (This guide assumes that you are not using the PKCS#11 integration.)
         •    (Windows) Select Start, Programs, Oracle-HOME_NAME, Integrated
              Management Tools, Wallet Manager


6.3 General Process for Creating an Oracle Wallet
         Oracle wallets provide a necessary repository in which you can securely store your
         user certificates and the trust point you need to validate the certificates of your peers.
         The following steps provide an overview of the complete wallet creation process:
         1.   Use Oracle Wallet Manager to create a new wallet.
         2.   Generate a certificate request. When you create a new wallet with Oracle Wallet
              Manager, the tool automatically prompts you to create a certificate request.
         3.   Send the certificate request to the CA you want to use. You can copy and paste
              the certificate request text into an e-mail message, or you can export the certificate



                                                                                                    6-7
                                                                                                  Chapter 6
                                                                                 Managing Oracle Wallets


                request to a file. The certificate request becomes part of your wallet. It must
                remain there until you remove its associated certificate.
           4.   When the CA sends your signed user certificate and its associated trusted
                certificate, then you can import these certificates in the following order. The user
                certificates and trusted certificates in the PKCS #7 format can be imported at the
                same time.
                •   First import the CA's trusted certificate into your wallet. This step may be
                    optional if the new user certificate has been issued by one of the CAs whose
                    trusted certificate is already present in Oracle Wallet Manager by default.
                •   After you have successfully imported the trusted certificate, then import the
                    user certificate that the CA sent to you into your wallet.
           5.   (Optional) Set the auto login feature for your wallet.
                Typically, this feature, which enables PKI-based access to services without a
                password, is required for most wallets. It is required for database server and client
                wallets. It is only optional for products that take the wallet password at the time of
                startup.
           After completing the preceding process, you have a wallet that contains a user
           certificate and its associated trust points.



                    See Also:
                    For more information about these steps, refer to "Managing Certificates for
                    Oracle Wallets"




6.4 Managing Oracle Wallets
           This section describes how to create a new Oracle wallet and perform associated
           wallet management tasks, such as generating certificate requests, exporting certificate
           requests, and importing certificates into wallets, in the following subsections:
           •    What Is Oracle Wallet Manager?
           •    Wallet Password Management
           •    Strong Wallet Encryption
           •    Microsoft Windows Registry Wallet Storage
           •    ACL Settings Needed for Wallet Files Created Using Wallet Manager
           •    Backward Compatibility
           •    Public-Key Cryptography Standards (PKCS) Support
           •    Multiple Certificate Support
           •    LDAP Directory Support


6.4.1 Required Guidelines for Creating Oracle Wallet Passwords
           Because an Oracle wallet contains user credentials that can be used to authenticate
           the user to multiple databases, it is especially important to choose a strong wallet




                                                                                                      6-8
                                                                                                 Chapter 6
                                                                                   Managing Oracle Wallets


             password. A malicious user who guesses the wallet password can access all the
             databases to which the wallet owner has access.
             Passwords must contain at least eight characters that consist of alphabetic characters
             combined with numbers or special characters.



                      Note:
                      It is strongly recommended that you avoid choosing easily guessed
                      passwords based on user names, phone numbers, or government
                      identification numbers. This prevents a potential attacker from using personal
                      information to deduce the users' passwords. It is also a prudent security
                      practice for users to change their passwords periodically, such as once in
                      each month or once in each quarter.
                      When you change passwords, you must regenerate auto-login wallets.




                      See Also:

                      •         "Wallet Password Management".
                      •         "Using Auto Login for Oracle Wallets to Enable Access Without Human
                                Intervention"



6.4.2 Creating a New Oracle Wallet
             You can use Oracle Wallet Manager to create PKCS #12 wallets (the standard default
             wallet type) that store credentials in a directory on your file system. It can also be used
             to create PKCS #11 wallets that store credentials on a hardware security module for
             servers, or private keys on tokens for clients. The following sections explain how to
             create both types of wallets by using Oracle Wallet Manager.
             This section describes the following topics:
             •    Creating a Standard Oracle Wallet
             •    Creating an Oracle Wallet to Store Hardware Security Module Credentials

6.4.2.1 Creating a Standard Oracle Wallet
             Unless you have a hardware security module (a PKCS #11 device), then you should
             use a standard wallet that stores credentials in a directory on your file system.
             To create a standard Oracle wallet, perform the following tasks:
             1.   Start Oracle Wallet Manager.
                  •       (UNIX) At the command line, enter the following command:
                          owm
                  •       (Windows) Select Start, Programs, Oracle-HOME_NAME, Integrated
                          Management Tools, Wallet Manager




                                                                                                      6-9
                                                                                                Chapter 6
                                                                                  Managing Oracle Wallets


             2.   From the Wallet menu, select New.
                  If you have not yet created a directory for the wallet, then you are prompted to
                  create this directory. By default, the wallet directory is created in the /oracle/owm/
                  wallets/user_name directory.
                  The New Wallet dialog box appears.
             3.   Enter the following information:
                  •   Password and Confirm Password: Enter a password in these two fields.
                      Ensure that you follow the guidelines in "Required Guidelines for Creating
                      Oracle Wallet Passwords". This password protects unauthorized use of your
                      credentials.
                  •   Wallet Type: Select Standard.
             4.   Click OK.
                  An alert is displayed, and informs you that a new empty wallet has been created. It
                  prompts you to decide whether you want to add a certificate request.
             5.   When prompted to create a certificate request, select one of the following options:
                  •   Yes: See "Adding a Certificate Request".
                  •   No: If you select No, then you are returned to the Oracle Wallet Manager main
                      window. The new wallet you just created is displayed in the left window pane.
                      The certificate has a status of [Empty], and the wallet displays its default
                      trusted certificates.
             6.   From the Wallet menu, select Save In System Default to save the new wallet.
                  If you do not have permission to save the wallet in the system default, then you
                  can save it to another location. This location must be used in the SSL
                  configuration for clients and servers.
                  A message at the bottom of the window confirms that the wallet was successfully
                  saved.

6.4.2.2 Creating an Oracle Wallet to Store Hardware Security Module
Credentials
             To create an Oracle wallet to store credentials on a hardware security module that
             complies with PKCS #11:
             1.   Start Oracle Wallet Manager.
                  •   (UNIX) At the command line, enter the following command:
                      owm
                  •   (Windows) Select Start, Programs, Oracle-HOME_NAME, Integrated
                      Management Tools, Wallet Manager
             2.   From the Wallet menu, select New.
                  The New Wallet dialog box appears.
             3.   Enter the following information:
                  •   Password and Confirm Password: Enter a password in these two fields.
                      Ensure that you follow the guidelines in "Required Guidelines for Creating




                                                                                                   6-10
                                                                                              Chapter 6
                                                                                Managing Oracle Wallets


                    Oracle Wallet Passwords". This password protects unauthorized use of your
                    credentials.
                •   Wallet Type: Select PKCS11.
           4.   Click OK to continue.
                The PKCS11 Information window appears.
           5.   In the PKCS11 Information window, enter the following information: From the
                Select Hardware Vendor list, select a vendor name.
                •   Hardware Vendor: Select the vendor name. SafeNET and nCipher hardware
                    have been certified to interoperate with Oracle wallets.
                •   PKCS11 library filename field, enter the path to the directory where the
                    PKCS11 library is stored, or click Browse to find it by searching the file
                    system.
                •   Smart Card password: Enter this password. The smart card password, which
                    is different from the wallet password, is stored in the wallet.
           6.   Click OK.
                An alert is displayed, and informs you that a new empty wallet has been created. It
                prompts you to decide whether you want to add a certificate request.
           7.   When prompted to create a certificate request, select one of the following options:
                •   Yes: See "Adding a Certificate Request".
                •   No: If you select No, then you are returned to the Oracle Wallet Manager main
                    window. The new wallet you just created is displayed in the left window pane.
                    The certificate has a status of [Empty], and the wallet displays its default
                    trusted certificates.
           8.   From the Wallet menu, select Save In System Default to save the new wallet.
                If you do not have permission to save the wallet in the system default, you can
                save it to another location.
                A message at the bottom of the window confirms that the wallet was successfully
                saved.
                If you change the smart card password or move the PKCS #11 library, an error
                message displays when you try to open the wallet. Then you are prompted to
                enter the new smart card password or the new path to the library.


6.4.3 Opening an Existing Oracle Wallet
           1.   Start Oracle Wallet Manager.
                •   (UNIX) At the command line, enter the following command:
                    owm
                •   (Windows) Select Start, Programs, Oracle-HOME_NAME, Integrated
                    Management Tools, Wallet Manager
           2.   From the Wallet menu, select Open.
                The Select Directory dialog box appears.
           3.   Navigate to the directory location in which the wallet is located, and select the
                directory.




                                                                                                    6-11
                                                                                              Chapter 6
                                                                               Managing Oracle Wallets


           4.   Click OK.
                The Open Wallet dialog box appears.
           5.   In the Wallet Password field, enter the wallet password.
           6.   Click OK.
                The main window appears and a message displays at the bottom of the window
                indicating that the wallet opened successfully. The wallet's certificate and its
                trusted certificates appear in the left window pane.


6.4.4 Closing an Oracle Wallet
           1.   Start Oracle Wallet Manager.
                •    (UNIX) At the command line, enter the following command:
                     owm
                •    (Windows) Select Start, Programs, Oracle-HOME_NAME, Integrated
                     Management Tools, Wallet Manager
           2.   From the Wallet menu, select Close.
           A message is displayed at the bottom of the window to confirm that the wallet is
           closed.


6.4.5 Exporting an Oracle Wallet to a Third-Party Environment
           1.   Use Oracle Wallet Manager to save the wallet file.
                a.   Start Oracle Wallet Manager.
                     (UNIX) At the command line, enter the following command:
                     owm

                     (Windows) Select Start, Programs, Oracle-HOME_NAME, Integrated
                     Management Tools, Wallet Manager
                b.   Ensure that the wallet is open by selecting Wallet from the panel, and from the
                     Wallet menu, select Open. When prompted, select the wallet directory
                     location, and then enter your wallet password.
                c.   From the Wallet menu,. select Save.
           2.   Follow the procedure specific to your third-party product to import an operating
                system PKCS #12 wallet file created by Oracle Wallet Manager (called
                ewallet.p12 on UNIX and Windows platforms).




                                                                                                6-12
                                                                                                 Chapter 6
                                                                                   Managing Oracle Wallets




                          Note:

                          •     Oracle Wallet Manager supports multiple certificates for each wallet,
                                yet current browsers typically support import of single-certificate
                                wallets only. For these browsers, you must export an Oracle wallet
                                containing a single key-pair.
                          •     Oracle Wallet Manager supports wallet export to only Netscape
                                Communicator 4.7.2 and later, OpenSSL, and Microsoft Internet
                                Explorer 5.0 and later.



6.4.6 Exporting an Oracle Wallet to a Tools That Does Not Support
PKCS #12
           You can export a wallet to a text-based PKI format if you want to put a wallet into a
           tool that does not support PKCS #12. Individual components are formatted according
           to the standards listed in Table 6-4. Within the wallet, only those certificates with SSL
           key usage are exported with the wallet.
           To export a wallet to text-based PKI format:
           1.   Start Oracle Wallet Manager.
                •   (UNIX) At the command line, enter the following command:
                    owm
                •   (Windows) Select Start, Programs, Oracle-HOME_NAME, Integrated
                    Management Tools, Wallet Manager
           2.   If the wallet is closed, then open it by selecting Open from the Wallet menu. When
                prompted, select the wallet directory location, and then enter your wallet
                password.
           3.   From the Operations menu, select Export Wallet.
                The Export Wallet dialog box is displayed.
           4.   Enter the destination file system directory for the wallet, or navigate to the
                directory structure under Folders.
           5.   Enter the destination file name for the wallet.
           6.   Click OK to return to the main window.

           Table 6-4          PKI Wallet Encoding Standards

            Component                                        Encoding Standard
            Certificate chains                               X509v3
            Trusted certificates                             X509v3
            Private keys                                     PKCS #8




                                                                                                    6-13
                                                                                             Chapter 6
                                                                               Managing Oracle Wallets




6.4.7 Uploading an Oracle Wallet to an LDAP Directory
           To upload an Oracle wallet to an LDAP directory, Oracle Wallet Manager uses SSL if
           the specified wallet contains an SSL certificate. Otherwise, it lets you enter the
           directory password.
           To prevent accidental destruction of your wallet, Oracle Wallet Manager will not permit
           you to execute the upload option unless the target wallet is currently open and
           contains at least one user certificate.
           To upload a wallet:
           1.   Start Oracle Wallet Manager.
                •   (UNIX) At the command line, enter the following command:
                    owm
                •   (Windows) Select Start, Programs, Oracle-HOME_NAME, Integrated
                    Management Tools, Wallet Manager
           2.   If the wallet is closed, then open it by selecting Open from the Wallet menu. When
                prompted, select the wallet directory location, and then enter your wallet
                password.
           3.   From the Wallet menu, select Upload Into The Directory Service.
                Oracle Database checks wallet certificates for SSL key usage.
           4.   Depending on whether the wallet has a certificate with SSL key usage, do one of
                the following:
                •   If at least one certificate has SSL key usage: When prompted, enter the
                    LDAP directory server host name and port information, then click OK. Oracle
                    Wallet Manager attempts connection to the LDAP directory server using SSL.
                    A message is displayed indicating whether the wallet was uploaded
                    successfully or it failed.
                •   If no certificates have SSL key usage: When prompted, enter the user's
                    distinguished name (DN), the LDAP server host name, and port information,
                    and then click OK. Oracle Wallet Manager attempts connection to the LDAP
                    directory server using simple password authentication mode, assuming that
                    the wallet password is the same as the directory password.
                    If the connection fails, then a dialog box prompts for the directory password of
                    the specified DN. Oracle Wallet Manager attempts connection to the LDAP
                    directory server using this password and displays a warning message if the
                    attempt fails. Otherwise, Oracle Wallet Manager displays a status message at
                    the bottom of the window indicating that the upload was successful.




                                                                                                6-14
                                                                                                   Chapter 6
                                                                                    Managing Oracle Wallets




                    Note:

                    •         You should ensure that the distinguished name used matches a
                              corresponding user entry of object class inetOrgPerson in the LDAP
                              directory.
                    •         When uploading a wallet with an SSL certificate, use the SSL port. When
                              uploading a wallet that does not contain an SSL certificate, use the non-
                              SSL port.



6.4.8 Downloading an Oracle Wallet from an LDAP Directory
           When you download an Oracle wallet from an LDAP directory, the wallet becomes
           resident in working memory. It is not saved to the file system unless you explicitly save
           it using any of the save options described in the following sections.



                    See Also:

                    •         "Saving Changes to an Oracle Wallet"
                    •         "Saving the Open Wallet to a New Location"
                    •         "Saving an Oracle Wallet to the System Default Directory Location"


           To download a wallet from an LDAP directory:
           1.   Start Oracle Wallet Manager.
                •       (UNIX) At the command line, enter the following command:
                        owm
                •       (Windows) Select Start, Programs, Oracle-HOME_NAME, Integrated
                        Management Tools, Wallet Manager
           2.   From the Wallet menu, select Download From The Directory Service.
                The Download From Directory Service dialog box prompts for the distinguished
                name (DN), and the LDAP directory password, host name, and port information.
                Oracle Wallet Manager uses simple password authentication to connect to the
                LDAP directory.
           3.   Depending on whether or not the downloading operation succeeds, do one of the
                following:
                •       If the download operation fails: Check to make sure that you have correctly
                        entered the user's DN, and the LDAP server host name and port information.
                        The port used must be the non-SSL port.
                •       If the download is successful: Click OK to open the downloaded wallet.
                        Oracle Wallet Manager attempts to open that wallet using the directory
                        password. If the operation fails after using the directory password, then a
                        dialog box prompts for the wallet password.




                                                                                                      6-15
                                                                                                Chapter 6
                                                                               Managing Oracle Wallets


                    If Oracle Wallet Manager cannot open the target wallet using the wallet
                    password, then check to make sure you entered the correct password.
                    Otherwise a message displays at the bottom of the window, indicating that the
                    wallet was downloaded successfully.


6.4.9 Saving Changes to an Oracle Wallet
           1.   Start Oracle Wallet Manager.
                •   (UNIX) At the command line, enter the following command:
                    owm
                •   (Windows) Select Start, Programs, Oracle-HOME_NAME, Integrated
                    Management Tools, Wallet Manager
           2.   If the wallet is closed, then open it by selecting Open from the Wallet menu. When
                prompted, select the wallet directory location, and then enter your wallet
                password.
           3.   From the Wallet menu, select Save.
           A message at the bottom of the window confirms that the wallet changes were
           successfully saved to the wallet in the selected directory location.


6.4.10 Saving the Open Wallet to a New Location
           1.   Start Oracle Wallet Manager.
                •   (UNIX) At the command line, enter the following command:
                    owm
                •   (Windows) Select Start, Programs, Oracle-HOME_NAME, Integrated
                    Management Tools, Wallet Manager
           2.   If the wallet is closed, then open it by selecting Open from the Wallet menu. When
                prompted, select the wallet directory location, and then enter your wallet
                password.
           3.   From the Wallet menu, select Save As.
                The Select Directory dialog box appears.
           4.   Select a directory location in which to save the wallet.
           5.   Click OK.
                The following message is displayed if a wallet already exists in the selected
                location:
                A wallet already exists in the selected path. Do you want to overwrite it?

                Select Yes to overwrite the existing wallet or No to save the wallet to another
                location.
                A message at the bottom of the window confirms that the wallet was successfully
                saved to the selected directory location.




                                                                                                  6-16
                                                                                                      Chapter 6
                                                                                       Managing Oracle Wallets




6.4.11 Saving an Oracle Wallet to the System Default Directory
Location
           1.   Start Oracle Wallet Manager.
                •       (UNIX) At the command line, enter the following command:
                        owm
                •       (Windows) Select Start, Programs, Oracle-HOME_NAME, Integrated
                        Management Tools, Wallet Manager
           2.   If the wallet is closed, then open it by selecting Open from the Wallet menu. When
                prompted, select the wallet directory location, and then enter your wallet
                password.
           3.   From the Wallet menu, select Save In System Default.
           A message at the bottom of the window confirms that the wallet was successfully
           saved in the system default wallet location as follows for UNIX and Windows
           platforms:
           •    (UNIX) $ORACLE_HOME/owm/wallets/username if the ORACLE_HOME environment
                variable has been set.
                ./owm/wallets/username if the ORACLE_HOME environment variable is not set.
           •    (WINDOWS) ORACLE_HOME\owm\wallets\username if the ORACLE_HOME
                environment variable has been set.
                .\owm\wallets\username if the ORACLE_HOME environment variable is not set.



                    Note:

                    •         SSL uses the wallet that is saved in the system default directory location.
                    •         Some Oracle applications are not able to use the wallet if it is not in the
                              system default location. Check the Oracle documentation for your
                              specific application to determine whether wallets must be placed in the
                              default wallet directory location.



6.4.12 Deleting an Oracle Wallet
           1.   Start Oracle Wallet Manager.
                •       (UNIX) At the command line, enter the following command:
                        owm
                •       (Windows) Select Start, Programs, Oracle-HOME_NAME, Integrated
                        Management Tools, Wallet Manager
           2.   If the wallet is closed, then open it by selecting Open from the Wallet menu. When
                prompted, select the wallet directory location, and then enter your wallet
                password.
           3.   From the Wallet menu, select Delete.



                                                                                                        6-17
                                                                                                      Chapter 6
                                                                                        Managing Oracle Wallets


                The Delete Wallet dialog box appears.
           4.   Do the following:
                •       Wallet Location: Review the displayed wallet location to verify that you are
                        deleting the correct wallet.
                •       Wallet Password: Enter the wallet password.
           5.   Click OK.
           6.   In the Confirmation dialog box, click OK.



                    Note:

                    •         Any open wallet in application memory will remain in memory until the
                              application exits. Therefore, deleting a wallet that is currently in use does
                              not immediately affect system operation.
                    •         Do not use Oracle Wallet Manager to delete Transparent Data
                              Encryption keystores. See Oracle Database Advanced Security Guide
                              for information about deleting keystores.



6.4.13 Changing the Oracle Wallet Password
           An Oracle wallet password change is effective immediately. The wallet is saved to the
           currently selected directory, encrypted with the password.



                    Note:
                    If you are using a wallet with auto login enabled, you must regenerate the
                    auto login wallet after changing the password. See "Using Auto Login for
                    Oracle Wallets to Enable Access Without Human Intervention" for more
                    information.



           To change the password for a wallet:
           1.   Start Oracle Wallet Manager.
                •       (UNIX) At the command line, enter the following command:
                        owm
                •       (Windows) Select Start, Programs, Oracle-HOME_NAME, Integrated
                        Management Tools, Wallet Manager
           2.   If the wallet is closed, then open it by selecting Open from the Wallet menu. When
                prompted, select the wallet directory location, and then enter your wallet
                password.
           3.   From the Wallet menu, select Change Password.
                The Change Wallet Password dialog box appears.
           4.   Enter the following information:




                                                                                                         6-18
                                                                                                  Chapter 6
                                                                                    Managing Oracle Wallets


                  •       Old Wallet Password: Enter the current wallet password.
                  •       New Wallet Password and Confirm Wallet Password: Enter the new
                          password.
             5.   Click OK.
             A message at the bottom of the window confirms that the password was successfully
             changed.



                      See Also:

                      •         "Required Guidelines for Creating Oracle Wallet Passwords"
                      •         "Wallet Password Management", for password policy restrictions



6.4.14 Using Auto Login for Oracle Wallets to Enable Access Without
Human Intervention
             This section contains:
             •    About Using Auto Login for Oracle Wallets
             •    Enabling Auto Login for Oracle Wallets
             •    Disabling Auto Login for Oracle Wallets

6.4.14.1 About Using Auto Login for Oracle Wallets
             The auto login feature for wallets is the ability to enable PKI-based access to services
             without requiring human intervention to supply the necessary passwords. Enabling
             auto login creates an obfuscated copy of the wallet, which is then used automatically
             until the auto login feature is disabled for that wallet.
             Auto login wallets are protected by file system permissions. When auto login is
             enabled for a wallet, only the operating system user who created it can manage it,
             through the Oracle Wallet Manager.
             You must enable auto login if you want single sign-on access to multiple Oracle
             databases: such access is normally disabled, by default. Sometimes the obfuscated
             auto login wallets are called "SSO wallets" because they support single sign-on
             capability.

6.4.14.2 Enabling Auto Login for Oracle Wallets
             1.   Start Oracle Wallet Manager.
                  •       (UNIX) At the command line, enter the following command:
                          owm
                  •       (Windows) Select Start, Programs, Oracle-HOME_NAME, Integrated
                          Management Tools, Wallet Manager




                                                                                                     6-19
                                                                                                          Chapter 6
                                                                           Managing Certificates for Oracle Wallets


             2.     If the wallet is closed, then open it by selecting Open from the Wallet menu. When
                    prompted, select the wallet directory location, and then enter your wallet
                    password.
             3.     From the Wallet menu, select the Auto Login check box.
                    A message at the bottom of the window indicates that auto login is enabled.

6.4.14.3 Disabling Auto Login for Oracle Wallets
             1.     Start Oracle Wallet Manager.
                    •    (UNIX) At the command line, enter the following command:
                         owm
                    •    (Windows) Select Start, Programs, Oracle-HOME_NAME, Integrated
                         Management Tools, Wallet Manager
             2.     If the wallet is closed, then open it by selecting Open from the Wallet menu. When
                    prompted, select the wallet directory location, and then enter your wallet
                    password.
             3.     From the Wallet menu, deselect the Auto Login check box.
                    A message at the bottom of the window indicates that auto login is disabled.


6.5 Managing Certificates for Oracle Wallets
             This section contains:
             •      About Managing Certificates for Oracle Wallets
             •      Managing User Certificates for Oracle Wallets
             •      Managing Trusted Certificates for Oracle Wallets


6.5.1 About Managing Certificates for Oracle Wallets
             All certificates are signed data structures that bind a network identity with a
             corresponding public key.
             Table 6-5 describes the two types of certificates distinguished in this chapter.

             Table 6-5         Types of Certificates

                 Certificate Type            Examples
                 User certificates           Certificates issued to servers or users to prove an end entity's
                                             identity in a public key/private key exchange
                 Trusted certificates        Certificates representing entities whom you trust, such as
                                             certificate authorities who sign the user certificates they issue




                                                                                                             6-20
                                                                                                     Chapter 6
                                                                      Managing Certificates for Oracle Wallets




                      Note:
                      Before you can install a user certificate, ensure that the wallet contains the
                      trusted certificate representing the certificate authority who issued that user
                      certificate. However, whenever you create a new wallet, several publicly
                      trusted certificates are automatically installed, since they are so widely used.
                      If the necessary certificate authority is not represented, then you must install
                      its certificate first.
                      Also, you can import using the PKCS#7 certificate chain format, which gives
                      you the user certificate and the CA certificate at the same time.



6.5.2 Managing User Certificates for Oracle Wallets
             This section contains:
             •    About Managing User Certificates
             •    Adding a Certificate Request
             •    Importing the User Certificate into an Oracle Wallet
             •    Importing Certificates and Wallets Created by Third Parties
             •    Removing a User Certificate from an Oracle Wallet
             •    Removing a Certificate Request
             •    Exporting a User Certificate
             •    Exporting a User Certificate Request

6.5.2.1 About Managing User Certificates
             User certificates, including server certificates, are used by end users, smart cards, or
             applications, such as Web servers. For example, if a CA issues a certificate for a Web
             server, placing its distinguished name (DN) in the Subject field, then the Web server is
             the certificate owner, thus the "user" for this user certificate.

6.5.2.2 Adding a Certificate Request
             You can add multiple certificate requests with Oracle Wallet Manager. When adding
             multiple requests, Oracle Wallet Manager automatically populates each subsequent
             request dialog box with the content of the initial request that you can then edit.
             The actual certificate request becomes part of the wallet. You can reuse any certificate
             request to obtain a new certificate. However, you cannot edit an existing certificate
             request. Store only a correctly filled out certificate request in a wallet.
             To create a PKCS #10 certificate request:
             1.   Start Oracle Wallet Manager.
                  •   (UNIX) At the command line, enter the following command:
                      owm




                                                                                                        6-21
                                                                                             Chapter 6
                                                            Managing Certificates for Oracle Wallets


     •   (Windows) Select Start, Programs, Oracle-HOME_NAME, Integrated
         Management Tools, Wallet Manager
2.   If the wallet is closed, then open it by selecting Open from the Wallet menu. When
     prompted, select the wallet directory location, and then enter your wallet
     password.
3.   From the Operations menu, select Add Certificate Request.
     The Create Certificate Request dialog box is displayed.
     The online Help for Oracle Wallet Manager becomes unresponsive when modal
     dialog boxes appear, such as the one for entering certificate request information.
     The online Help becomes responsive once the modal dialog box is closed.
4.   Enter the information specified in Table 6-6.
5.   Click OK.
     A message informs you that a certificate request was successfully created. You
     can either copy the certificate request text from the body of this dialog panel and
     paste it into an e-mail message to send to a certificate authority, or you can export
     the certificate request to a file. At this point, Oracle Wallet Manager has created
     your private/public key pair and stored it in the wallet. When the certificate
     authority issues your certificate, it will also be stored in the wallet and associate it
     with its corresponding private key.
6.   Click OK.
     The status of the certificate changes to [Requested].



            See Also:
            "Exporting a User Certificate Request"



Table 6-6    Certificate Request: Fields and Descriptions

Field Name                 Description
Common Name                Mandatory. Enter the name of the user's or service's identity. Enter
                           a user's name in first name /last name format.
                           Example: Eileen.Sanger
Organizational Unit        Optional. Enter the name of the identity's organizational unit.
                           Example: Finance.
Organization               Optional. Enter the name of the identity's organization. Example:
                           XYZ Corp.
Locality/City              Optional. Enter the name of the locality or city in which the identity
                           resides.
State/Province             Optional. Enter the full name of the state or province in which the
                           identity resides.
                           Enter the full state name, because some certificate authorities do
                           not accept two–letter abbreviations.
Country                    Mandatory. Select Country to view a list of country abbreviations.
                           Select the country in which the organization is located.




                                                                                               6-22
                                                                                                           Chapter 6
                                                                            Managing Certificates for Oracle Wallets




             Table 6-6        (Cont.) Certificate Request: Fields and Descriptions

                 Field Name                 Description
                 DN                         Mandatory. Select the Algorithm (Key Size/Elliptic Curve) list to
                                            view a list of key sizes to use when creating the public/private key
                                            pair. Refer to Table 6-7 to evaluate the key size.
                 Advanced                   Optional. Select Advanced to view the Advanced Certificate
                                            Request dialog panel. Use this field to edit or customize the
                                            identity's distinguished name (DN). For example, you can edit the
                                            full state name and locality.

             Table 6-7 lists the available key sizes and the relative security each size provides.
             Typically, CAs use key sizes of 1024 or 2048. When certificate owners wish to keep
             their keys for a longer duration, they choose 3072 or 4096 bit keys.

             Table 6-7        Available Key Sizes

              Key Size                                    Relative Security Level
              512 or 768                                  Not regarded as secure.
              1024 or 2048                                Secure.
              3072 or 4096                                Very secure.


6.5.2.3 Importing the User Certificate into an Oracle Wallet
             When the Certificate Authority grants you a certificate, it may send you an e-mail that
             has your certificate in text (BASE64) form or attached as a binary file. You can import
             the user certificate using the following methods:
             •        Importing the User Certificate from the Text of the Certificate Authority Email
             •        Importing the User Certificate from a File



                         Note:
                         Certificate authorities may send your certificate in a PKCS #7 certificate
                         chain or as an individual X.509 certificate. Oracle Wallet Manager can import
                         both types.
                         PKCS #7 certificate chains are a collection of certificates, including the user's
                         certificate and all of the supporting trusted CA and subCA certificates.
                         In contrast, an X.509 certificate file contains an individual certificate without
                         the supporting certificate chain.
                         However, before you can import any such individual certificate, the signer's
                         certificate must be a Trusted Certificate in the wallet.




                                                                                                              6-23
                                                                                              Chapter 6
                                                               Managing Certificates for Oracle Wallets




Importing the User Certificate from the Text of the Certificate Authority Email
Copy the certificate, represented as text (BASE64), from the e-mail message. Include
the lines Begin Certificate and End Certificate.

1.   Start Oracle Wallet Manager.
     •        (UNIX) At the command line, enter the following command:
              owm
     •        (Windows) Select Start, Programs, Oracle-HOME_NAME, Integrated
              Management Tools, Wallet Manager
2.   If the wallet is closed, then open it by selecting Open from the Wallet menu. When
     prompted, select the wallet directory location, and then enter your wallet
     password.
3.   Select Operations, Import User Certificate.
     The Import Certificate dialog box is displayed.
4.   Select Paste the certificate, and then click OK.
     Another Import Certificate dialog box is displayed with the following message:
     Please provide a base64 format certificate and paste it below.
5.   Paste the certificate into the dialog box, and click OK.
     a.       If the certificate received is in PKCS#7 format, it is installed, and all the other
              certificates included with the PKCS#7 data are placed in the Trusted
              Certificate list.
     b.       If the certificate received is not in PKCS#7 format, and the certificate of its CA
              is not already in the Trusted Certificates list, then more must be done. Oracle
              Wallet Manager will ask you to import the certificate of the CA that issued your
              certificate. This CA certificate will be placed in the Trusted Certificates list. (If
              the CA certificate was already in the Trusted Certificates list, your certificate is
              imported without additional steps.)
     After either (a) or (b) succeeds, a message at the bottom of the window confirms
     that the certificate was successfully installed. You are returned to the Oracle
     Wallet Manager main panel, and the status of the corresponding entry in the left
     panel subtree changes to [Ready].



          Note:
          The standard X.509 certificate includes the following start and end text:
          •         -----BEGIN CERTIFICATE-----
                    -----END CERTIFICATE-----
          A typical PKCS#7 certificate includes more, as described earlier, and
          includes the following start and end text:
          •         -----BEGIN PKCS7-----
                    -----END PKCS7-----
          You can use the standard Ctrl+c to copy, including all dashes, and Ctrl+v to
          paste.




                                                                                                 6-24
                                                                                                       Chapter 6
                                                                        Managing Certificates for Oracle Wallets




             Importing the User Certificate from a File
             The user certificate in the file can be in either text (BASE64) or binary (der) format.

             1.   Start Oracle Wallet Manager.
                  •    (UNIX) At the command line, enter the following command:
                       owm
                  •    (Windows) Select Start, Programs, Oracle-HOME_NAME, Integrated
                       Management Tools, Wallet Manager
             2.   If the wallet is closed, then open it by selecting Open from the Wallet menu. When
                  prompted, select the wallet directory location, and then enter your wallet
                  password.
             3.   Select Operations, Import User Certificate. The Import Certificate dialog box is
                  displayed.
             4.   Select Select a file that contains the certificate, and click OK. Another Import
                  Certificate dialog box is displayed.
             5.   Enter the path or folder name of the certificate file location.
             6.   Select the name of the certificate file (for example, cert.txt, cert.der).
             7.   Click OK.
                  a.   If the certificate received is in PKCS#7 format, it is installed, and all the other
                       certificates included with the PKCS#7 data are placed in the Trusted
                       Certificate list.
                  b.   If the certificate received is not in PKCS#7 format, and the certificate of its CA
                       is not already in the Trusted Certificates list, then more must be done. Oracle
                       Wallet Manager will ask you to import the certificate of the CA that issued your
                       certificate. This CA certificate will be placed in the Trusted Certificates list. (If
                       the CA certificate was already in the Trusted Certificates list, your certificate is
                       imported without additional steps.)
                  After either (a) or (b) succeeds, a message at the bottom of the window confirms
                  that the certificate was successfully installed. You are returned to the Oracle
                  Wallet Manager main panel, and the status of the corresponding entry in the left
                  panel subtree changes to [Ready].

6.5.2.4 Importing Certificates and Wallets Created by Third Parties
             Third-party certificates are those created from certificate requests that were not
             generated using Oracle Wallet Manager. These third-party certificates are actually
             wallets, in the Oracle sense, because they contain more than just the user certificate;
             they also contain the private key for that certificate. Furthermore, they include the
             chain of trusted certificates validating that the certificate was created by a trustworthy
             entity.
             Oracle Wallet Manager makes these wallets available in a single step by importing
             them in PKCS#12 format, which includes all three elements described earlier: the user
             certificate, the private key, and the trusted certificates. It supports the following PKCS
             #12-format certificates:
             •    Netscape Communicator 4.x and later
             •    Microsoft Internet Explorer 5.x and later



                                                                                                          6-25
                                                                                                       Chapter 6
                                                                        Managing Certificates for Oracle Wallets


             Oracle Wallet Manager adheres to the PKCS#12 standard, so certificates exported by
             any PKCS#12-compliant tool should be usable with Oracle Wallet Manager.
             Such third-party certificates cannot be stored into existing Oracle wallets because they
             would lack the private key and chain of trusted authorities. Therefore, each such
             certificate is exported and retrieved instead as an independent PKCS#12 file, that is,
             as its own wallet.

             Importing User Certificates Created with a Third-Party Tool
             Once a third party generates the wallet, you need to import it to make use of it, as
             described in this section.
             To import a certificate created with a third-party tool:
             1.   Follow the procedures for your particular product to export the certificate.
                  Perform the actions indicated in the exporting product to include the private key in
                  the export, and specify the new password to protect the exported certificate. Also
                  include all associated trust points. (Under PKCS #12, browsers do not necessarily
                  export trusted certificates, other than the signer's own certificate. You may need to
                  add additional certificates to authenticate to your peers. You can use Oracle
                  Wallet Manager to import trusted certificates.)
                  The resulting file, containing the certificate, the private key, and the trust points, is
                  the new wallet that enables the third-party certificate to be used.
             2.   Place the wallet where it will be easily found, by copying it to the correct system
                  and directory.
                  To be used by particular applications or servers, such as a web server or an LDAP
                  server, wallets must be located precisely. Each application has its own
                  expectations as to which directory it will search to find the needed wallet.
             3.   For use with UNIX or Windows applications or servers, ensure that the wallet is
                  named ewallet.p12.
                  For other operating systems, refer to the Oracle documentation for that specific
                  operating system.
                  Once a third-party certificate is stored as ewallet.p12, you can open and manage
                  it using Oracle Wallet Manager. You will have to supply the password you created
                  when exporting this wallet.



                     Note:
                     The password will be required whenever the associated application starts up
                     or otherwise needs the certificate. To make such access automatic, refer to
                     "Using Auto Login for Oracle Wallets to Enable Access Without Human
                     Intervention".
                     However, if the private key for the desired certificate is held in a separate
                     hardware security module, you will not be able to import that certificate.



6.5.2.5 Removing a User Certificate from an Oracle Wallet
             1.   Start Oracle Wallet Manager.




                                                                                                          6-26
                                                                                                      Chapter 6
                                                                       Managing Certificates for Oracle Wallets


                  •   (UNIX) At the command line, enter the following command:
                      owm
                  •   (Windows) Select Start, Programs, Oracle-HOME_NAME, Integrated
                      Management Tools, Wallet Manager
             2.   If the wallet is closed, then open it by selecting Open from the Wallet menu. When
                  prompted, select the wallet directory location, and then enter your wallet
                  password.
             3.   In the left panel subtree, select the certificate that you want to remove.
             4.   From the Operations menu, select Remove User Certificate.
             5.   In the Confirmation dialog box, select Yes to return to the Oracle Wallet Manager
                  main panel.
                  The certificate displays a status of [Requested].

6.5.2.6 Removing a Certificate Request
             You must remove a certificate before removing its associated request.
             To remove a certificate request:
             1.   Start Oracle Wallet Manager.
                  •   (UNIX) At the command line, enter the following command:
                      owm
                  •   (Windows) Select Start, Programs, Oracle-HOME_NAME, Integrated
                      Management Tools, Wallet Manager
             2.   If the wallet is closed, then open it by selecting Open from the Wallet menu. When
                  prompted, select the wallet directory location, and then enter your wallet
                  password.
             3.   In the left panel subtree, select the certificate request that you want to remove.
             4.   From the Operations menu, select Remove Certificate Request.
             5.   In the Confirmation dialog box, click Yes.

6.5.2.7 Exporting a User Certificate
             To save the certificate in a file system directory, export the certificate as follows:
             1.   Start Oracle Wallet Manager.
                  •   (UNIX) At the command line, enter the following command:
                      owm
                  •   (Windows) Select Start, Programs, Oracle-HOME_NAME, Integrated
                      Management Tools, Wallet Manager
             2.   If the wallet is closed, then open it by selecting Open from the Wallet menu. When
                  prompted, select the wallet directory location, and then enter your wallet
                  password.
             3.   In the left panel subtree, select the certificate that you want to export.
             4.   From the Operations menu, select Export User Certificate.




                                                                                                         6-27
                                                                                                     Chapter 6
                                                                      Managing Certificates for Oracle Wallets


                  The Export Certificate dialog box appears.
             5.   Enter the following information:
                  •   Enter path or folder name: Enter the file system directory location where you
                      want to save your certificate, or navigate to the directory structure under
                      Folders.
                  •   Enter file name: Enter a file name for your certificate.
             6.   Click Save.
                  A message confirms that the certificate was successfully exported to the file. You
                  are returned to the Oracle Wallet Manager main window.



                      See Also:
                      "Exporting an Oracle Wallet to a Third-Party Environment" for information
                      about exporting wallets. Oracle Wallet Manager supports storing multiple
                      certificates in a single wallet, yet current browsers typically support only
                      single-certificate wallets. For these browsers, you must export an Oracle
                      wallet that contains a single key-pair.



6.5.2.8 Exporting a User Certificate Request
             To save the certificate request in a file system directory, export the certificate request
             as follows:
             1.   Start Oracle Wallet Manager.
                  •   (UNIX) At the command line, enter the following command:
                      owm
                  •   (Windows) Select Start, Programs, Oracle-HOME_NAME, Integrated
                      Management Tools, Wallet Manager
             2.   If the wallet is closed, then open it by selecting Open from the Wallet menu. When
                  prompted, select the wallet directory location, and then enter your wallet
                  password.
             3.   In the left panel subtree, select the certificate request that you want to export.
             4.   From the Operations menu, select Export Certificate Request.
                  The Export Certificate Request dialog box appears.
             5.   Enter the following information:
                  •   Enter path or folder name: Enter the file system directory location where you
                      want to save your certificate, or navigate to the directory structure under
                      Folders.
                  •   Enter file name: Enter a file name for your certificate.
             6.   Click OK.
                  A message confirms that the certificate request was successfully exported to the
                  file. You are returned to the Oracle Wallet Manager main window.




                                                                                                        6-28
                                                                                                    Chapter 6
                                                                     Managing Certificates for Oracle Wallets




6.5.3 Managing Trusted Certificates for Oracle Wallets
             Managing trusted certificates includes the following tasks:
             •    Importing a Trusted Certificate
             •    Removing a Trusted Certificate
             •    Exporting a Trusted Certificate to Another File System Location
             •    Exporting All Trusted Certificates to Another File System Location

6.5.3.1 Importing a Trusted Certificate
             You can import a trusted certificate into a wallet in either of two ways: paste the trusted
             certificate from an e-mail that you receive from the certificate authority, or import the
             trusted certificate from a file.
             Oracle Wallet Manager automatically installs trusted certificates from VeriSign, RSA,
             Entrust, and GTE CyberTrust when you create a new wallet.
             This section contains:
             •    Copying and Pasting Text-Only (BASE64) Trusted Certificates
             •    Importing a File That Contains the Trusted Certificate

             Copying and Pasting Text-Only (BASE64) Trusted Certificates
             1.   Copy the trusted certificate from the body of the email message you received that
                  contained the user certificate. Include the lines BEGIN CERTIFICATE and END
                  CERTIFICATE.
                  You can use the Ctrl+c keyboard shortcut to copy the user certificate.
             2.   Start Oracle Wallet Manager.
                  •   (UNIX) At the command line, enter the following command:
                      owm
                  •   (Windows) Select Start, Programs, Oracle-HOME_NAME, Integrated
                      Management Tools, Wallet Manager
             3.   If the wallet is closed, then open it by selecting Open from the Wallet menu. When
                  prompted, select the wallet directory location, and then enter your wallet
                  password.
             4.   From the Operations menu, select Import Trusted Certificate.
                  The Import Trusted Certificate dialog box appears.
             5.   Select the Paste the certificate option and then click OK.
                  Another Import Trusted Certificate dialog box appears with the following message:
                  Please paste a BASE64 format certificate below.
             6.   Paste the certificate into the window, and click OK.
                  You can use the Ctrl+v keyboard shortcut to paste the certificate.
                  A message informs you that the trusted certificate was successfully installed.
             7.   Click OK.



                                                                                                       6-29
                                                                                                      Chapter 6
                                                                       Managing Certificates for Oracle Wallets


                  You are returned to the Oracle Wallet Manager main panel, and the trusted
                  certificate is displayed at the bottom of the Trusted Certificates tree.

             Importing a File That Contains the Trusted Certificate
             1.   Ensure that you had saved the file that contains the trusted certificate in either text
                  (BASE64) or binary (der) format.
             2.   Start Oracle Wallet Manager.
                  •   (UNIX) At the command line, enter the following command:
                      owm
                  •   (Windows) Select Start, Programs, Oracle-HOME_NAME, Integrated
                      Management Tools, Wallet Manager
             3.   If the wallet is closed, then open it by selecting Open from the Wallet menu. When
                  prompted, select the wallet directory location, and then enter your wallet
                  password.
             4.   From the Operations menu, select Import Trusted Certificate.
                  The Import Trusted Certificate dialog box appears.
             5.   Select the Select a file that contains the certificate option and then click OK.
                  The Import Trusted Certificate dialog box appears.
             6.   Enter the following information:
                  •   Enter path or folder name: Enter the file system directory location where the
                      certificate is stored, or navigate to the directory structure under Folders.
                  •   Enter file name: Select the name of the trusted certificate file (for example,
                      cert.txt).
             7.   Click OK.
                  A message informs you that the trusted certificate was successfully imported into
                  the wallet.
             8.   Click OK to exit the dialog box.
                  You are returned to the Oracle Wallet Manager main panel, and the trusted
                  certificate is displayed at the bottom of the Trusted Certificates tree.

6.5.3.2 Removing a Trusted Certificate
             You cannot remove a trusted certificate if it has been used to sign a user certificate still
             present in the wallet. To remove such trusted certificates, you must first remove the
             certificates it has signed. Also, you cannot verify a certificate after its trusted certificate
             has been removed from your wallet.
             To remove a trusted certificate from a wallet:
             1.   Start Oracle Wallet Manager.
                  •   (UNIX) At the command line, enter the following command:
                      owm
                  •   (Windows) Select Start, Programs, Oracle-HOME_NAME, Integrated
                      Management Tools, Wallet Manager




                                                                                                         6-30
                                                                                                      Chapter 6
                                                                       Managing Certificates for Oracle Wallets


             2.   If the wallet is closed, then open it by selecting Open from the Wallet menu. When
                  prompted, select the wallet directory location, and then enter your wallet
                  password.
             3.   Select the trusted certificate listed in the Trusted Certificates tree.
             4.   From the Operations menu, select Remove Trusted Certificate.
                  A dialog box warns you that your user certificate will no longer be verifiable by its
                  recipients if you remove the trusted certificate that was used to sign it.
             5.   Select Yes.
                  The selected trusted certificate is removed from the Trusted Certificates tree.

6.5.3.3 Exporting a Trusted Certificate to Another File System Location
             1.   Start Oracle Wallet Manager.
                  •   (UNIX) At the command line, enter the following command:
                      owm
                  •   (Windows) Select Start, Programs, Oracle-HOME_NAME, Integrated
                      Management Tools, Wallet Manager
             2.   If the wallet is closed, then open it by selecting Open from the Wallet menu. When
                  prompted, select the wallet directory location, and then enter your wallet
                  password.
             3.   In the left panel subtree, select the trusted certificate that you want to export.
             4.   From the Operations menu, select Export Trusted Certificate.
                  The Export Trusted Certificate dialog box appears.
             5.   Enter the following information:
                  •   Enter path or folder name: Enter a file system directory in which you want to
                      save your trusted certificate, or navigate to the directory structure under
                      Folders.
                  •   Enter file name: Enter a file name to save your trusted certificate.
             6.   Click OK.
                  You are returned to the Oracle Wallet Manager main window.

6.5.3.4 Exporting All Trusted Certificates to Another File System Location
             1.   Start Oracle Wallet Manager.
                  •   (UNIX) At the command line, enter the following command:
                      owm
                  •   (Windows) Select Start, Programs, Oracle-HOME_NAME, Integrated
                      Management Tools, Wallet Manager
             2.   If the wallet is closed, then open it by selecting Open from the Wallet menu. When
                  prompted, select the wallet directory location, and then enter your wallet
                  password.
             3.   From the Operations menu, select Export All Trusted Certificates.
                  The Export Trusted Certificate dialog box appears.




                                                                                                         6-31
                                                                                      Chapter 6
                                                       Managing Certificates for Oracle Wallets


4.   Enter the following information:
     •   Enter path or folder name: Enter a file system directory location where you
         want to save your trusted certificates, or navigate to the directory structure
         under Folders.
     •   Enter file name: Enter a file name to save your trusted certificates.
5.   Click OK.
     You are returned to the Oracle Wallet Manager main window.




                                                                                         6-32
7
Enterprise User Security Manager (EUSM)
Command Reference
      Enterprise User Security Manager (EUSM) is a command-line tool you can use to
      manage the Enterprise User Security (EUS) Configuration in the Oracle Internet
      Directory (OID) directory server.
      The EUSM command-line tool sends data to and retrieves data from the Oracle
      Internet Directory (OID) directory server. You can use Oracle Enterprise Manager to
      administer enterprise users, enterprise domains, and enterprise roles stored in OID as
      described in Oracle Enterprise Manager. However, this becomes a cumbersome
      process if the entries are very large and the process cannot be automated. Hence, the
      use of this command-line tool becomes a requirement.
      The file path of the EUSM command is:

      $ORACLE_HOME/bin


      EUSM is a user friendly command-line tool. Entering eusm on the shell and pressing
      Enter or Return, prints all the commands that are supported. Also entering eusm help
      <command> or just eusm <command> and pressing Enter or Return prints the signature
      of a particular command supported by EUSM. Note that you must enter eusm in all
      lowercase characters.
      Both EUSM commands and command-line options are not case sensitive.
      Password credentials for the users: dbuser and ldap_user, and for the keystore can be
      stored in a client-side Oracle wallet in the external secure password store by providing
      information regarding the <alias, username, password> for each one. See About
      Using a Secure External Password Store, where this is described in more detail.
      Examples for each of the EUSM commands show this usage.
      This chapter contains descriptions of the EUSM commands listed by their group. Each
      description contains the following parts:


      Section                                     Description
      Term                                        Describes the function of each term.
      Syntax                                      Shows how to enter the command and
                                                  provides a brief description of the basic uses
                                                  of the command.
      Options                                     Describes the function of each clause and
                                                  option appearing in the syntax.
      Usage Notes                                 Provides additional information on uses of the
                                                  command and on how the command works.




                                                                                              7-1
                                                                                              Chapter 7
                                                           About Using a Secure External Password Store




         Section                                       Description
         Examples                                      Gives examples of the command using SSL
                                                       port connectivity and not using SSL port
                                                       connectivity to OID and using an Oracle wallet
                                                       to store user credentials.

         This chapter includes the following topics:
         •   About Using a Secure External Password Store
         •   About SSL Port Connectivity through EUSM to OID
         •   Enterprise User Security Manager (EUSM) Command Summary


7.1 About Using a Secure External Password Store
         If you want to use a secure external password store, then configure the Oracle wallet
         as described in the information that follows; otherwise, passwords can be provided
         interactively and you can skip this section.
         Before you run the Enterprise User Security Manager (EUSM), configure a client-side
         Oracle wallet as a secure external password store so that your applications can use
         password credentials stored in the wallet to connect to databases. Storing database
         password credentials in a client-side Oracle wallet eliminates the need to embed
         passwords in application code, batch jobs, or scripts. This reduces the risk of exposing
         passwords in the clear in scripts and application code, and allows you to more easily
         manage password policies for user accounts without changing application code or
         scripts whenever passwords change.
         See Configuring a Client to Use the External Password Store for steps to configure a
         client to use the external password store by using the mkstore command-line utility.



                Note:
                The external password store of the wallet is separate from the area where
                public key infrastructure (PKI) credentials are stored. Consequently, you
                cannot use Oracle Wallet Manager to manage credentials in the external
                password store of the wallet. Instead, use the command-line utility mkstore
                to manage these credentials.



         Using the mkstore CreateCredential command, configure the following user
         credentials by providing information for <alias, username, password>, in which you
         will be prompted to enter the password for each user.
         •   dbalias, dbuser, password
         •   ldap_alias, ldap_user, password
         •   keystore_alias, keystore, passowrd

         Configuring these user credentials allows you to use the following parameters on the
         EUSM command line:
         •   dbalias=<db-password-alias>




                                                                                                  7-2
                                                                                              Chapter 7
                                                        About SSL Port Connectivity through EUSM to OID


         •   ldap_alias=<OID-user-password-alias>
         •   keystore_alias=<keystore-password-alias>

         EUSM command examples use the following wallet credential information for users:
         dbuser, ldap_user, and keystore that was provided for the alias name, user name,
         and password. The wallet location is specified as shown.
         •   dbadmin1, sysman, password
         •   ldabadmin1, ldapman, password
         •   keystore1, keystore, password
         •   wallet_location=/oracle/product/db_1/wallets

         EUSM command-line examples use the following entries on the command-line:
         •   dbalias=dbadmin1
         •   ldap_alias=ldabadmin1
         •   keystore_alias=keystore1
         •   wallet_location=/oracle/product/db_1/wallets

         After configuring the client-side wallet, enable auto-login for Oracle Wallets to allow the
         administrator running EUSM commands to access and perform these services without
         having to supply the necessary credentials.



                See Also:

                •   Managing the Secure External Password Store for Password Credentials
                    for more information about creating a client-side password store wallet to
                    store alias, user name, and password credentials for users
                •   About Using Auto Login for Oracle Wallets for information about enabling
                    auto login for Oracle wallets that enables PKI-based access to services
                    without requiring human intervention to supply the necessary user name
                    passwords required to run EUSM



7.2 About SSL Port Connectivity through EUSM to OID
         To enhance security, use the SSL Port connectivity option (ldap_ssl_port=<OID ssl
         port>) when connecting from Enterprise User Security Manager (EUSM) to Oracle
         Internet Directory (OID) directory server.
         Using the SSL Port connectivity option (ldap_ssl_port=<OID ssl port>) assumes the
         environment where the OID directory server is set up supports the SSL port.
         The following are additional parameters that must be given to EUSM to connect to the
         SSL port of the OID server:
         •   The ldap_ssl_port option takes the ssl port of the directory server (OID) as input
             from the EUSM command line.
         •   The keystore=<path to PKCS12 format of keystore> file path parameter takes
             the path to the PKCS12 format of the keystore (for example, ewallet.p12 file) as




                                                                                                  7-3
                                                                                              Chapter 7
                                            Enterprise User Security Manager (EUSM) Command Summary


             input from the command line and the password is taken from the Oracle client-side
             wallet when the wallet is configured as a secure external password store or is
             taken interactively with the option –K prompt for keystore password.

         Prerequisites
         Prerequisites include the following:
         •   The client must have a keystore in PKCS12 format for example, ewallet.p12 file.
             This keystore file consists of a client private key certificate.
         •   The inputs for the passwords of keystore should also be given by the client.
         •   The client must have Java 2 SDK, v1.4 or any updated version that supports the
             current EUSM API.


7.3 Enterprise User Security Manager (EUSM) Command
Summary
         Enterprise User Security Manager (EUSM) commands are listed by group with links to
         its command page.


         Group of Commands             Command                    Description
         Manage Enterprise Domains     listDomains                Lists the domains in the realm.
         Manage Enterprise Domains     createDomain               Creates a domain in the realm.
         Manage Enterprise Domains     deleteDomain               Deletes a domain from the realm.
         Manage Enterprise Domains     listDomainInfo             Lists the domain information.
         Manage Domain                 addDomainAdmin             Adds a domain administrator.
         Administrators
         Manage Domain                 listDomainAdmins           Lists the domain administrators.
         Administrators                                           The domain is taken as one of
                                                                  the inputs.
         Manage Domain                 removeDomainAdmin          Removes a domain administrator
         Administrators
         Manage Databases in an        addDatabase                Adds a database to the domain.
         Existing Domain
         Manage Databases in an        removeDatabase             Removes a database from the
         Existing Domain                                          domain.
         Manage Database               addDBAdmin                 Adds a database administrator.
         Administrators
         Manage Database               removeDBAdmin              Removes a database
         Administrators                                           administrator.
         Manage Database               listDBAdmins               Lists the database
         Administrators                                           administrators.
         Manage Database               listDBInfo                 Lists the database information.
         Administrators
         Manage user-schema            createMapping              Creates the user and shared
         mappings                                                 schema mapping.
         Manage user-schema            deleteMapping              Deletes a mapping.
         mappings
         Manage user-schema            listMappings               Lists the user and shared
         mappings                                                 schema mappings.




                                                                                                  7-4
                                                                                         Chapter 7
                                    Enterprise User Security Manager (EUSM) Command Summary




Group of Commands              Command                     Description
Enable or Disable Current    setCulinkStatus               Enables or disables the current
User Database Links Usage in                               user database-link usage in the
the Domain                                                 domain.
Setting Authentication Types   setAuthTypes                Sets authentication types to be
                                                           accepted for the users in the
                                                           domain.
Manage Enterprise Roles/       createRole                  Creates an enterprise role.
Global Roles
Manage Enterprise Roles/       deleteRole                  Deletes an enterprise role.
Global Roles
Manage Enterprise Roles/       addGlobalRole               Adds a global role or
Global Roles                                               administrative role to an
                                                           enterprise role.
Manage Enterprise Roles/       removeGlobalRole            Removes a global role or
Global Roles                                               administrative role from an
                                                           enterprise role.
Manage Enterprise Roles/       grantRole                   Grants an enterprise role.
Global Roles
Manage Enterprise Roles/       revokeRole                  Revokes an enterprise role.
Global Roles
Manage Enterprise Roles/       listEnterpriseRoles         Lists the enterprise roles.
Global Roles
Manage Enterprise Roles/       listEnterpriseRolesOfUser   Lists the enterprise roles of a
Global Roles                                               user.
Manage Enterprise Roles/       listEnterpriseRoleInfo      Lists enterprise role information.
Global Roles
Manage Enterprise Roles/       listGlobalRolesInDB         Lists the global roles in the
Global Roles                                               database.
Manage Enterprise Roles/       listSharedSchemasInDB       Lists the shared schemas in the
Global Roles                                               database.
Manage Proxy Authentication    createProxyPerm             Creates a proxy permission
                                                           object.
Manage Proxy Authentication    deleteProxyPerm             Deletes a proxy permission
                                                           object.
Manage Proxy Authentication    addTargetUser               Adds a target database user to
                                                           the proxy permission object.
Manage Proxy Authentication    removeTargetUser            Removes a target database user
                                                           from the proxy permission object.
Manage Proxy Authentication    grantProxyPerm              Maps an enterprise user to the
                                                           database user through the proxy
                                                           permission object.
Manage Proxy Authentication    revokeProxyPerm             Revokes a proxy permission
                                                           object.
Manage Proxy Authentication    listProxyPermissions        Lists the proxy permissions. Input
                                                           is the domain name.
Manage Proxy Authentication    listProxyPermissionsOfUse Lists the proxy permissions for
                               r                         the user. Input is user
                                                         distinguished name.
Manage Proxy Authentication    listProxyPermissionInfo     Lists the proxy permission
                                                           information.
Manage Proxy Authentication    listTargetUsersInDB         Lists the target users in the
                                                           database.




                                                                                             7-5
                                                                                        Chapter 7
                                   Enterprise User Security Manager (EUSM) Command Summary




Group of Commands             Command                     Description
Manage Database-OID           setDBOIDAuth                Sets the database-OID
Authentication Method                                     authentication method.
Manage Database-OID           listDBOIDAuth               Lists the database-OID
Authentication Method                                     authentication method.
Manage the list of the        addToPwdAccessibleDoma Adds a domain to the password
Password Accessible           ins                    accessible domains group in the
Domains                                              realm.
Manage the list of the        removeFromPwdAccessibl      Removes a domain from the
Password Accessible           eDomains                    password accessible domains
Domains                                                   group in the realm.
Manage the list of the        listPwdAccessibleDomains    Lists the password accessible
Password Accessible                                       domains in the realm.
Domains
Display Realm Properties      listRealmCommonAttr         Lists the realm common
                                                          attributes.
App Context Namespace         createAppCtxNamespace       Adds a new namespace.
App Context Namespace         listAppCtxNamespaces        Lists the namespaces.
App Context Namespace         deleteAppCtxNamespace       Deletes a namespace.
App Context Attribute         createAppCtxAttribute       Adds a new attribute.
App Context Attribute         listAppCtxAttributes        Lists the attributes.
App Context Attribute         deleteAppCtxAttribute       Deletes an attribute.
App Context Attribute Value   createAppCtxAttributeValue Adds a new attribute value.
App Context Attribute Value   listAppCtxAttributeValues   Lists the attribute values.
App Context Attribute Value   deleteAppCtxAttributeValue Deletes an attribute value.
Manage App Context Users      createAppCtxUsers           Adds a new user for an attribute
                                                          value.
Manage App Context Users      listAppCtxUsers             Lists all users for an attribute
                                                          value.
Manage App Context Users      deleteAppCtxUsers           Deletes a user from an attribute
                                                          value.
Help                          help <command name>         Displays help for a command.

Examples of EUSM Commands Use Options
Examples for EUSM commands use some of the following options and values, where
values are used for example purposes only:
•   proxy_permission=PROXY01
•   domain_name=test_domain
•   domain_name=OracleDefaultDomain — an enterprise domain
•   realm_dn=dc=yy, dc=company,dc=com
•   user_dn=cn=test_user,cn=Users,dc=yy,dc=company,dc=com
•   database_name=dbtest1
•   map_type=ENTRY — can be either ENTRY or SUBTREE
•   map_dn=cn=test_user,cn=Users,dc=yy,dc=company,dc=com
•   mapping_name=MAPPING01
•   schema=test_user



                                                                                             7-6
                                                                                           Chapter 7
                                            Enterprise User Security Manager (EUSM) Command Summary


          •   status=ENABLED — can be either ENABLED or DISABLED
          •   auth_type=SSL
          •   enterprise_role=ent_connect — enterprise role
          •   enterprise_role=ent_resource — global role
          •   global_role=global_resource
          •   global_role=global_connect
          •   dbuser=system — a privileged user
          •   db_alias=dbadmin1 — alias for dbuser credentials stored in an Oracle wallet
          •   dbconnect_string=zzzz10-yy.yy.company.com:1531:dbtest1
          •   target_user=PROXY_TEST
          •   namespace=ns1
          •   attribute_name=attr1
          •   attribute_value=val1
          •   ldap_host=xxxxx.zz.company.com — name of the OID server
          •   ldap_SSL_port=3131 — OID SSL (SASL) port used for OID connections; ports
              3132 to 3141 or 13131 to 13141 can also be used
          •   keystore=/etc/myapp/keyStore — path to PKCS12 format of keystore; keystore
              location is administrator defined
          •   keystore_alias=keystore1 — alias for keystore credentials stored in an Oracle
              wallet
          •   ldap port =3060 — nonSSL (SASL) port used for OID connections; ports 3061 to
              3070 or 13060 to 13070 can also be used
          •   ldap_user_dn=cn=orcladmin — OID administrator name
          •   ldap_alias=ldapadmin1 — alias for ldap_user credentials stored in an Oracle
              wallet
          •   wallet_location=/oracle/product/db_1/wallets — the wallet or secure external
              password store location


7.3.1 createDomain
          Creates a domain in the realm.

          Syntax

          createDomain
               domain_name=<domain name>
               realm_dn=<DN of the realm>
               ldap_host=<OID host>
               ldap_port=<OID non ssl port> | ldap_ssl_port=<OID ssl port>
               keystore=<path to keystore>
               keystore_alias=<keystore password alias>
               ldap_user_dn=<DN of OID user>
               ldap_alias=<OID user password alias>
               wallet_location=<wallet location>




                                                                                               7-7
                                                                                  Chapter 7
                                 Enterprise User Security Manager (EUSM) Command Summary




Options
Each option must be prefixed with a space. Multiple options can be concatenated and
prefixed with single space.


Option                                     Description
domain_name=<domain name>                  Name of the domain.
realm_dn=<DN of the realm>                 DN of the realm.
ldap_host=<OID host>                       OID host.
ldap_port=<OID non ssl port> |             OID non ssl port or OID ssl port.
ldap_ssl_port=<OID ssl port>
keystore=<path to keystore>                Path to the keystore.
keystore_alias=<keystore password          Keystore password taken from the Oracle
alias>                                     wallet.
ldap_user_dn=<DN of OID user>              DN of OID user which is used for
                                           authenticating and executing a command in
                                           the OID.
ldap_alias=<OID user password alias> OID user password taken from the Oracle
                                           wallet.
wallet_location=<wallet location>          Path to Oracle wallet when using the wallet.

Usage Notes
None.

Examples
Examples include creating a domain in the realm with and without SSL port
connectivity to OID.
Example 7-1 Creating a Domain in the Realm with SSL Port Conectivity to OID
and Using Passwords Stored in the Oracle Wallet

eusm createDomain domain_name=test_domain realm_dn=dc=yy,dc=company,dc=com
ldap_host=xxxxx.zz.company.com ldap_ssl_port=3131 keystore=/etc/myapp/
keyStore keystore_alias=keystore1 ldap_user_dn=cn=orcladmin
ldap_alias=ldabadmin1 wallet_location=/oracle/product/db_1/wallets


Example 7-2    Creating a Domain in the Realm with SSL Port Conectivity to OID

eusm createDomain domain_name=test_domain realm_dn=dc=yy,dc=company,dc=com
ldap_host=xxxxx.zz.company.com ldap_ssl_port=3131 keystore=/etc/myapp/
keyStore ldap_user_dn=cn=orcladmin


Example 7-3    Creating a Domain in the Realm with non-SSL Port Conectivity to
OID

eusm createDomain domain_name=test_domain realm_dn=dc=yy,dc=company,dc=com
ldap_host=xxxxx.zz.company.com ldap_port=3060 ldap_user_dn=cn=orcladmin




                                                                                      7-8
                                                                                              Chapter 7
                                             Enterprise User Security Manager (EUSM) Command Summary




7.3.2 deleteDomain
          Deletes a domain from the realm.

          Syntax

          deleteDomain
               domain_name=<domain name>
               realm_dn=<DN of the realm>
               ldap_host=<OID host>
               ldap_port=<OID non ssl port> | ldap_ssl_port=<OID ssl port>
               keystore=<path to keystore>
               keystore_alias=<keystore password alias>
               ldap_user_dn=<DN of OID user>
               ldap_alias=<OID user password alias>
               wallet_location=<wallet location>


          Options
          Each option must be prefixed with a space. Multiple options can be concatenated and
          prefixed with single space.


           Option                                      Description
           domain_name=<domain name>                   Name of the domain.
           realm_dn=<DN of the realm>                  DN of the realm.
           ldap_host=<OID host>                        OID host.
           ldap_port=<OID non ssl port> |              OID non ssl port or OID ssl port.
           ldap_ssl_port=<OID ssl port>
           keystore=<path to keystore>                 Path to the keystore.
           keystore_alias=<keystore password           Keystore password taken from the Oracle
           alias>                                      wallet.
           ldap_port=<OID non ssl port>                OID non ssl port.
           ldap_user_dn=<DN of OID user>               DN of OID user which is used for
                                                       authenticating and executing a command in
                                                       the OID.
           ldap_alias=<OID user password alias> OID user password taken from the Oracle
                                                       wallet.
           wallet_location=<wallet location>           Path to Oracle wallet when using the wallet.



          Usage Notes
          None.

          Examples
          Examples include deleting a domain in the realm with and without SSL port
          connectivity to OID.




                                                                                                  7-9
                                                                                            Chapter 7
                                             Enterprise User Security Manager (EUSM) Command Summary


           Example 7-4 Deleting a Domain from the Realm with SSL Port Conectivity to
           OID and Using Passwords Stored in the Oracle Wallet

           eusm deleteDomain domain_name=test_domain realm_dn=dc=yy,dc=company,dc=com
           ldap_host=xxxxx.zz.company.com ldap_ssl_port=3131 keystore=/etc/myapp/
           keyStore keystore_alias=keystore1 ldap_user_dn=cn=orcladmin
           ldap_alias=ldabadmin1 wallet_location=/oracle/product/db_1/wallets


           Example 7-5    Deleting a Domain from the Realm with SSL Port Conectivity to
           OID

           eusm deleteDomain domain_name=test_domain realm_dn=dc=yy,dc=company,dc=com
           ldap_host=xxxxx.zz.company.com ldap_ssl_port=3131 keystore=/etc/myapp/
           keyStore ldap_user_dn=cn=orcladmin


           Example 7-6    Deleting a Domain from the Realm with non-SSL Port Conectivity
           to OID

           eusm deleteDomain domain_name=test_domain realm_dn=dc=yy,dc=company,dc=com
           ldap_host=xxxxx.zz.company.com ldap_port=3060 ldap_user_dn=cn=orcladmin


7.3.3 listDomains
           Lists the domains in the realm.

           Syntax

           listDomains
                realm_dn=<DN of the realm>
                ldap_host=<OID host>
                ldap_port=<OID non ssl port> | ldap_ssl_port=<OID ssl port>
                keystore=<path to keystore>
                keystore_alias=<keystore password alias>
                ldap_user_dn=<DN of OID user>
                ldap_alias=<OID user password alias>
                wallet_location=<wallet location>


           Options
           Each option must be prefixed with a space. Multiple options can be concatenated and
           prefixed with single space.


            Option                                     Description
            realm_dn=<DN of the realm>                 DN of the realm.
            ldap_host=<OID host>                       OID host.
            ldap_port=<OID non ssl port> |             OID non ssl port or OID ssl port.
            ldap_ssl_port=<OID ssl port>
            keystore=<path to keystore>                Path to the keystore.
            keystore_alias=<keystore password          Keystore password taken from the Oracle
            alias>                                     wallet.




                                                                                                 7-10
                                                                                             Chapter 7
                                            Enterprise User Security Manager (EUSM) Command Summary




            Option                                    Description
            ldap_user_dn=<DN of OID user>             DN of OID user which is used for
                                                      authenticating and executing a command in
                                                      the OID.
            ldap_alias=<OID user password alias> OID user password taken from the Oracle
                                                      wallet.
            wallet_location=<wallet location>         Path to Oracle wallet when using the wallet.

           Usage Notes
           None.

           Examples
           Examples include listing the domains in the realm with and without SSL port
           connectivity to OID.
           Example 7-7 Lists the domains in the realm with SSL Port Conectivity to OID
           and Using Passwords Stored in the Oracle Wallet

           eusm listDomains realm_dn=dc=yy,dc=company,dc=com
           ldap_host=xxxxx.zz.company.com ldap_ssl_port=3131 keystore=/etc/myapp/
           keyStore keystore_alias=keystore1 ldap_user_dn=cn=orcladmin
           ldap_alias=ldabadmin1 wallet_location=/oracle/product/db_1/wallets


           Example 7-8    Lists the domains in the realm with SSL Port Conectivity to OID

           eusm listDomains realm_dn=dc=yy,dc=company,dc=com
           ldap_host=xxxxx.zz.company.com ldap_ssl_port=3131 keystore=/etc/myapp/
           keyStore ldap_user_dn=cn=orcladmin


           Example 7-9    Lists the domains in the realm with non-SSL Port Conectivity to
           OID

           eusm listDomains realm_dn=dc=yy,dc=company,dc=com
           ldap_host=xxxxx.zz.company.com ldap_port=3060 ldap_user_dn=cn=orcladmin


7.3.4 listDomainInfo
           List domain information.

           Syntax

           listDomainInfo
                domain_name=<domain name>
                realm_dn=<DN of the realm>
                ldap_host=<OID host>
                ldap_port=<OID non ssl port> | ldap_ssl_port=<OID ssl port>
                keystore=<path to keystore>
                keystore_alias=<keystore password alias>
                ldap_user_dn=<DN of OID user>



                                                                                                7-11
                                                                                   Chapter 7
                                  Enterprise User Security Manager (EUSM) Command Summary


     ldap_alias=<OID user password alias>
     wallet_location=<wallet location>


Options
Each option must be prefixed with a space. Multiple options can be concatenated and
prefixed with single space.


Option                                      Description
domain_name=<domain name>                   Name of the domain.
realm_dn=<DN of the realm>                  DN of the realm.
ldap_host=<OID host>                        OID host.
ldap_port=<OID non ssl port> |              OID non ssl port or OID ssl port.
ldap_ssl_port=<OID ssl port>
keystore=<path to keystore>                 Path to the keystore.
keystore_alias=<keystore password           Keystore password taken from the Oracle
alias>                                      wallet.
ldap_user_dn=<DN of OID user>               DN of OID user which is used for
                                            authenticating and executing a command in
                                            the OID.
ldap_alias=<OID user password alias> OID user password taken from the Oracle
                                            wallet.
wallet_location=<wallet location>           Path to Oracle wallet when using the wallet.

Usage Notes
None.

Examples
Examples include listing the domain information with and without SSL port connectivity
to OID.
Example 7-10 Listing the Domain Information with SSL Port Conectivity to OID
and Using Passwords Stored in the Oracle Wallet

eusm listDomainInfo domain_name=test_domain
realm_dn=dc=yy,dc=company,dc=com ldap_host=xxxxx.zz.company.com
ldap_ssl_port=3131 keystore=/etc/myapp/keyStore keystore_alias=keystore1
ldap_user_dn=cn=orcladmin ldap_alias=ldabadmin1 wallet_location=/oracle/
product/db_1/wallets


Example 7-11    Listing the Domain Information with SSL Port Conectivity to OID

eusm listDomainInfo domain_name=test_domain
realm_dn=dc=yy,dc=company,dc=com ldap_host=xxxxx.zz.company.com
ldap_ssl_port=3131 keystore=/etc/myapp/keyStore ldap_user_dn=cn=orcladmin




                                                                                      7-12
                                                                                            Chapter 7
                                           Enterprise User Security Manager (EUSM) Command Summary


          Example 7-12    Listing the Domain Information with non-SSL Port Conectivity to
          OID

          eusm listDomainInfo domain_name=test_domain
          realm_dn=dc=yy,dc=company,dc=com ldap_host=xxxxx.zz.company.com
          ldap_port=3060 ldap_user_dn=cn=orcladmin


7.3.5 addDomainAdmin
          Adds a domain administrator.

          Syntax

          addDomainAdmin
               domain_name=<domain name>
               realm_dn=<DN of the realm>
               user_dn=<user DN>
               ldap_host=<OID host>
               ldap_port=<OID non ssl port> | ldap_ssl_port=<OID ssl port>
               keystore=<path to keystore>
               keystore_alias=<keystore password alias>
               ldap_user_dn=<DN of OID user>
               ldap_alias=<OID user password alias>
               wallet_location=<wallet location>


          Options
          Each option must be prefixed with a space. Multiple options can be concatenated and
          prefixed with single space.


          Option                                     Description
          domain_name=<domain name>                  Name of the domain.
          realm_dn=<DN of the realm>                 DN of the realm.
          user_dn=<user DN>                          DN of the user. For example, the user to be
                                                     added as database administrator in the
                                                     command addDBAdmin.
          ldap_host=<OID host>                       OID host.
          ldap_port=<OID non ssl port> |             OID non ssl port or OID ssl port.
          ldap_ssl_port=<OID ssl port>
          keystore=<path to keystore>                Path to the keystore.
          keystore_alias=<keystore password          Keystore password taken from the Oracle
          alias>                                     wallet.
          ldap_user_dn=<DN of OID user>              DN of OID user which is used for
                                                     authenticating and executing a command in
                                                     the OID.
          ldap_alias=<OID user password alias> OID user password taken from the Oracle
                                                     wallet.
          wallet_location=<wallet location>          Path to Oracle wallet when using the wallet.




                                                                                               7-13
                                                                                           Chapter 7
                                            Enterprise User Security Manager (EUSM) Command Summary




          Usage Notes
          None.

          Examples
          Examples include adding a domain administrator with and without SSL port
          connectivity to OID.
          Example 7-13 Adding a Domain Administrator with SSL Port Conectivity to OID
          and Using Passwords Stored in the Oracle Wallet

          eusm addDomainAdmin domain_name=test_domain
          user_dn=cn=test_user,cn=Users,dc=yy,dc=company,dc=com realm_dn=dc=yy,
          dc=company,dc=com ldap_host=xxxxx.zz.company.com ldap_ssl_port=3131
          keystore=/etc/myapp/keyStore keystore_alias=keystore1
          ldap_user_dn=cn=orcladmin ldap_alias=ldabadmin1 wallet_location=/oracle/
          product/db_1/wallets


          Example 7-14    Adding a Domain Administrator with SSL Port Conectivity to OID

          eusm addDomainAdmin domain_name=test_domain
          user_dn=cn=test_user,cn=Users,dc=yy,dc=company,dc=com realm_dn=dc=yy,
          dc=company,dc=com ldap_host=xxxxx.zz.company.com ldap_ssl_port=3131
          keystore=/etc/myapp/keyStore ldap_user_dn=cn=orcladmin


          Example 7-15    Adding a Domain Administrator with non-SSL Port Conectivity to
          OID

          eusm addDomainAdmin domain_name=test_domain
          user_dn=cn=test_user,cn=Users,dc=yy,dc=company,dc=com realm_dn=dc=yy,
          dc=company,dc=com ldap_host=xxxxx.zz.company.com ldap_port=3060
          ldap_user_dn=cn=orcladmin


7.3.6 removeDomainAdmin
          Removes a domain administrator.

          Syntax

          removeDomainAdmin
               domain_name=<domain name>
               realm_dn=<DN of the realm>
               user_dn=<user DN>
               ldap_host=<OID host>
               ldap_port=<OID non ssl port> | ldap_ssl_port=<OID ssl port>
               keystore=<path to keystore>
               keystore_alias=<keystore password alias>
               ldap_user_dn=<DN of OID user>
               ldap_alias=<OID user password alias>
               wallet_location=<wallet location>




                                                                                             7-14
                                                                                  Chapter 7
                                 Enterprise User Security Manager (EUSM) Command Summary




Options
Each option must be prefixed with a space. Multiple options can be concatenated and
prefixed with single space.


Option                                     Description
domain_name=<domain name>                  Name of the domain.
realm_dn=<DN of the realm>                 DN of the realm.
user_dn=<user DN>                          DN of the user. For example, the user to be
                                           removed as database administrator in the
                                           command removeDBAdmin.
ldap_host=<OID host>                       OID host.
ldap_port=<OID non ssl port> |             OID non ssl port or OID ssl port.
ldap_ssl_port=<OID ssl port>
keystore=<path to keystore>                Path to the keystore.
keystore_alias=<keystore password          Keystore password taken from the Oracle
alias>                                     wallet.
ldap_user_dn=<DN of OID user>              DN of OID user which is used for
                                           authenticating and executing a command in
                                           the OID.
ldap_alias=<OID user password alias> OID user password taken from the Oracle
                                           wallet.
wallet_location=<wallet location>          Path to Oracle wallet when using the wallet.

Usage Notes
None.

Examples
Examples include removing a domain administrator with and without SSL port
connectivity to OID.
Example 7-16 Removing a Domain Administrator with SSL Port Conectivity to
OID and Using Passwords Stored in the Oracle Wallet

eusm removeDomainAdmin domain_name=test_domain
user_dn=cn=test_user,cn=Users,dc=yy,dc=company,dc=com realm_dn=dc=yy,
dc=company,dc=com ldap_host=xxxxx.zz.company.com ldap_ssl_port=3131
keystore=/etc/myapp/keyStore keystore_alias=keystore1
ldap_user_dn=cn=orcladmin ldap_alias=ldabadmin1 wallet_location=/oracle/
product/db_1/wallets


Example 7-17    Removing a Domain Administrator with SSL Port Conectivity to
OID

eusm removeDomainAdmin domain_name=test_domain
user_dn=cn=test_user,cn=Users,dc=yy,dc=company,dc=com realm_dn=dc=yy,
dc=company,dc=com ldap_host=xxxxx.zz.company.com ldap_ssl_port=3131
keystore=/etc/myapp/keyStore ldap_user_dn=cn=orcladmin




                                                                                     7-15
                                                                                              Chapter 7
                                             Enterprise User Security Manager (EUSM) Command Summary


           Example 7-18 Removing a Domain Administrator with non-SSL Port
           Conectivity to OID

           eusm removeDomainAdmin domain_name=test_domain
           user_dn=cn=test_user,cn=Users,dc=yy,dc=company,dc=com realm_dn=dc=yy,
           dc=company,dc=com ldap_host=xxxxx.zz.company.com ldap_port=3060
           ldap_user_dn=cn=orcladmin


7.3.7 listDomainAdmins
           Lists the domain administrators. The domain is taken as one of the inputs.

           Syntax

           listDomainAdmins
                domain_name=<domain name>
                realm_dn=<DN of the realm>
                ldap_host=<OID host>
                ldap_port=<OID non ssl port> | ldap_ssl_port=<OID ssl port>
                keystore=<path to keystore>
                keystore_alias=<keystore password alias>
                ldap_user_dn=<DN of OID user>
                ldap_alias=<OID user password alias>
                wallet_location=<wallet location>


           Options
           Each option must be prefixed with a space. Multiple options can be concatenated and
           prefixed with single space.


           Option                                      Description
           domain_name=<domain name>                   Name of the domain.
           realm_dn=<DN of the realm>                  DN of the realm.
           ldap_host=<OID host>                        OID host.
           ldap_port=<OID non ssl port> |              OID non ssl port or OID ssl port.
           ldap_ssl_port=<OID ssl port>
           keystore=<path to keystore>                 Path to the keystore.
           keystore_alias=<keystore password           Keystore password taken from the Oracle
           alias>                                      wallet.
           ldap_user_dn=<DN of OID user>               DN of OID user which is used for
                                                       authenticating and executing a command in
                                                       the OID.
           ldap_alias=<OID user password alias> OID user password taken from the Oracle
                                                       wallet.
           wallet_location=<wallet location>           Path to Oracle wallet when using the wallet.

           Usage Notes
           None.




                                                                                                 7-16
                                                                                          Chapter 7
                                           Enterprise User Security Manager (EUSM) Command Summary




          Examples
          Examples include listing domain administrators with and without SSL port connectivity
          to OID.
          Example 7-19 Listing the Domain Administrators with SSL Port Conectivity to
          OID and Using Passwords Stored in the Oracle Wallet

          eusm listDomainAdmins domain_name=test_domain
          realm_dn=dc=yy,dc=company,dc=com ldap_host=xxxxx.zz.company.com
          ldap_ssl_port=3131 keystore=/etc/myapp/keyStore keystore_alias=keystore1
          ldap_user_dn=cn=orcladmin ldap_alias=ldabadmin1 wallet_location=/oracle/
          product/db_1/wallets


          Example 7-20    Listing the Domain Administrators with SSL Port Conectivity to
          OID

          eusm listDomainAdmins domain_name=test_domain
          realm_dn=dc=yy,dc=company,dc=com ldap_host=xxxxx.zz.company.com
          ldap_ssl_port=3131 keystore=/etc/myapp/keyStore ldap_user_dn=cn=orcladmin


          Example 7-21 Listing the Domain Administrators with non-SSL Port
          Conectivity to OID

          eusm listDomainAdmins domain_name=test_domain
          realm_dn=dc=yy,dc=company,dc=com ldap_host=xxxxx.zz.company.com
          ldap_port=3060 ldap_user_dn=cn=orcladmin


7.3.8 addDatabase
          Adds a database to the domain.

          Syntax

          addDatabase
               domain_name=<domain name>
               realm_dn=<DN of the realm>
               database_name=<Database name>
               ldap_host=<OID host>
               ldap_port=<OID non ssl port> | ldap_ssl_port=<OID ssl port>
               keystore=<path to keystore>
               keystore_alias=<keystore password alias>
               ldap_user_dn=<DN of OID user>
               ldap_alias=<OID user password alias>
               wallet_location=<wallet location>


          Options
          Each option must be prefixed with a space. Multiple options can be concatenated and
          prefixed with single space.




                                                                                            7-17
                                                                                 Chapter 7
                                Enterprise User Security Manager (EUSM) Command Summary




Option                                    Description
domain_name=<domain name>                 Name of the domain.
realm_dn=<DN of the realm>                DN of the realm.
database_name=<Database name>             Database name.
ldap_host=<OID host>                      OID host.
ldap_port=<OID non ssl port> |            OID non ssl port or OID ssl port.
ldap_ssl_port=<OID ssl port>
keystore=<path to keystore>               Path to the keystore.
keystore_alias=<keystore password         Keystore password taken from the Oracle
alias>                                    wallet.
ldap_user_dn=<DN of OID user>             DN of OID user which is used for
                                          authenticating and executing a command in
                                          the OID.
ldap_alias=<OID user password alias> OID user password taken from the Oracle
                                          wallet.
wallet_location=<wallet location>         Path to Oracle wallet when using the wallet.

Usage Notes
None.

Examples
Examples include adding a database to the domain with and without SSL port
connectivity to OID.
Example 7-22 Adding a Database to the Domain with SSL Port Conectivity to
OID and Using Passwords Stored in the Oracle Wallet

eusm addDatabase domain_name=test_domain realm_dn=dc=yy,dc=company,dc=com
database_name=dbtest1 ldap_host=xxxxx.zz.company.com ldap_ssl_port=3131
keystore=/etc/myapp/keyStore keystore_alias=keystore1
ldap_user_dn=cn=orcladmin ldap_alias=ldabadmin1 wallet_location=/oracle/
product/db_1/wallets


Example 7-23    Adding a Database to the Domain with SSL Port Conectivity to
OID

eusm addDatabase domain_name=test_domain realm_dn=dc=yy,dc=company,dc=com
database_name=dbtest1 ldap_host=xxxxx.zz.company.com ldap_ssl_port=3131
keystore=/etc/myapp/keyStore ldap_user_dn=cn=orcladmin


Example 7-24    Adding a Database to the Domain with non-SSL Port Conectivity
to OID

eusm addDatabase domain_name=test_domain realm_dn=dc=yy,dc=company,dc=com
database_name=dbtest1 ldap_host=xxxxx.zz.company.com ldap_port=3060
ldap_user_dn=cn=orcladmin




                                                                                    7-18
                                                                                            Chapter 7
                                           Enterprise User Security Manager (EUSM) Command Summary




7.3.9 removeDatabase
          Removes a database from the domain.

          Syntax

          removeDatabase
               domain_name=<domain name>
               realm_dn=<DN of the realm>
               database_name=<Database name>
               ldap_host=<OID host>
               ldap_port=<OID non ssl port> | ldap_ssl_port=<OID ssl port>
               keystore=<path to keystore>
               keystore_alias=<keystore password alias>
               ldap_user_dn=<DN of OID user>
               ldap_alias=<OID user password alias>
               wallet_location=<wallet location>


          Options
          Each option must be prefixed with a space. Multiple options can be concatenated and
          prefixed with single space.


          Option                                     Description
          domain_name=<domain name>                  Name of the domain.
          realm_dn=<DN of the realm>                 DN of the realm.
          database_name=<Database name>              Database name.
          ldap_host=<OID host>                       OID host.
          ldap_port=<OID non ssl port> |             OID non ssl port or OID ssl port.
          ldap_ssl_port=<OID ssl port>
          keystore=<path to keystore>                Path to the keystore.
          keystore_alias=<keystore password          Keystore password from the Oracle wallet.
          alias>
          ldap_user_dn=<DN of OID user>              DN of OID user which is used for
                                                     authenticating and executing a command in
                                                     the OID.
          ldap_alias=<OID user password alias> OID user password taken from the Oracle
                                                     wallet.
          wallet_location=<wallet location>          Path to Oracle wallet when using the wallet.

          Usage Notes
          None.

          Examples
          Examples include removing a database from the domain with and without SSL port
          connectivity to OID.




                                                                                               7-19
                                                                                          Chapter 7
                                           Enterprise User Security Manager (EUSM) Command Summary


          Example 7-25 Removing a Database from the Domain with SSL Port
          Conectivity to OID and Using Passwords Stored in the Oracle Wallet

          eusm removeDatabase domain_name=test_domain
          realm_dn=dc=yy,dc=company,dc=com database_name=dbtest1
          ldap_host=xxxxx.zz.company.com ldap_ssl_port=3131 keystore=/etc/myapp/
          keyStore keystore_alias=keystore1 ldap_user_dn=cn=orcladmin
          ldap_alias=ldabadmin1 wallet_location=/oracle/product/db_1/wallets


          Example 7-26 Removing a Database from the Domain with SSL Port
          Conectivity to OID

          eusm removeDatabase domain_name=test_domain
          realm_dn=dc=yy,dc=company,dc=com database_name=dbtest1
          ldap_host=xxxxx.zz.company.com ldap_ssl_port=3131 keystore=/etc/myapp/
          keyStore ldap_user_dn=cn=orcladmin


          Example 7-27 Removing a Database from the Domain with non-SSL Port
          Conectivity to OID

          eusm removeDatabase domain_name=test_domain
          realm_dn=dc=yy,dc=company,dc=com database_name=dbtest1
          ldap_host=xxxxx.zz.company.com ldap_port=3060 ldap_user_dn=cn=orcladmin


7.3.10 addDBAdmin
          Adds a database administrator.

          Syntax

          addDBAdmin
               realm_dn=<DN of the realm>
               database_name=<Database name>
               user_dn=<Distinguished name of the user>
               ldap_host=<OID host>
               ldap_port=<OID non ssl port> | ldap_ssl_port=<OID ssl port>
               keystore=<path to keystore>
               keystore_alias=<keystore password alias>
               ldap_user_dn=<DN of OID user>
               ldap_alias=<OID user password alias>
               wallet_location=<wallet location>


          Options
          Each option must be prefixed with a space. Multiple options can be concatenated and
          prefixed with single space.


          Option                                     Description
          realm_dn=<DN of the realm>                 DN of the realm.
          database_name=<Database name>              Database name.




                                                                                            7-20
                                                                                 Chapter 7
                                Enterprise User Security Manager (EUSM) Command Summary




Option                                    Description
user_dn=<user DN>                         DN of the user. For example, the user to be
                                          added as database administrator in the
                                          command addDBAdmin.
ldap_host=<OID host>                      OID host.
ldap_port=<OID non ssl port> |            OID non ssl port or OID ssl port.
ldap_ssl_port=<OID ssl port>
keystore=<path to keystore>               Path to the keystore.
keystore_alias=<keystore password         Keystore password taken from the Oracle
alias>                                    wallet.
ldap_user_dn=<DN of OID user>             DN of OID user which is used for
                                          authenticating and executing a command in
                                          the OID.
ldap_alias=<OID user password alias> OID user password taken from the Oracle
                                          wallet.
wallet_location=<wallet location>         Path to Oracle wallet when using the wallet.

Usage Notes
None.

Examples
Examples include adding a database administrator with and without SSL port
connectivity to OID.
Example 7-28 Adding a Database Administrator with SSL Port Conectivity to
OID and Using Passwords Stored in the Oracle Wallet

eusm addDBAdmin realm_dn=dc=yy,dc=company,dc=com database_name=dbtest1
user_dn=cn=test_user,cn=Users,dc=yy,dc=company,dc=com
ldap_host=xxxxx.zz.company.com ldap_ssl_port=3131 keystore=/etc/myapp/
keyStore keystore_alias=keystore1 ldap_user_dn=cn=orcladmin
ldap_alias=ldabadmin1 wallet_location=/oracle/product/db_1/wallets


Example 7-29    Adding a Database Administrator with SSL Port Conectivity to
OID

eusm addDBAdmin realm_dn=dc=yy,dc=company,dc=com database_name=dbtest1
user_dn=cn=test_user,cn=Users,dc=yy,dc=company,dc=com
ldap_host=xxxxx.zz.company.com ldap_ssl_port=3131 keystore=/etc/myapp/
keyStore ldap_user_dn=cn=orcladmin


Example 7-30    Adding a Database Administrator with non-SSL Port Conectivity
to OID

eusm addDBAdmin realm_dn=dc=yy,dc=company,dc=com database_name=dbtest1
user_dn=cn=test_user,cn=Users,dc=yy,dc=company,dc=com
ldap_host=xxxxx.zz.company.com ldap_port=3060 ldap_user_dn=cn=orcladmin




                                                                                    7-21
                                                                                                 Chapter 7
                                                Enterprise User Security Manager (EUSM) Command Summary




7.3.11 listDBAdmins
           Lists the database administrators.

           Syntax

           listDBAdmins
                realm_dn=<DN of the realm>
                database_name=<Database name>
                ldap_host=<OID host>
                ldap_port=<OID non ssl port> | ldap_ssl_port=<OID ssl port>
                keystore=<path to keystore>
                keystore_alias=<keystore password alias>
                ldap_user_dn=<DN of OID user>
                ldap_alias=<OID user password alias>
                wallet_location=<wallet location>


           Options
           Each option must be prefixed with a space. Multiple options can be concatenated and
           prefixed with single space.


           Option                                         Description
           realm_dn=<DN of the realm>                     DN of the realm.
           database_name=<Database name>                  Database name.
           ldap_host=<OID host>                           OID host.
           ldap_port=<OID non ssl port> |                 OID non ssl port or OID ssl port.
           ldap_ssl_port=<OID ssl port>
           keystore=<path to keystore>                    Path to the keystore.
           keystore_alias=<keystore password              Keystore password taken from the Oracle
           alias>                                         wallet.
           ldap_user_dn=<DN of OID user>                  DN of OID user which is used for
                                                          authenticating and executing a command in
                                                          the OID.
           ldap_alias=<OID user password alias> OID user password taken from the Oracle
                                                          wallet.
           wallet_location=<wallet location>              Path to Oracle wallet when using the wallet.

           Usage Notes
           None.

           Examples
           Examples include listing the database administrators with and without SSL port
           connectivity to OID.




                                                                                                    7-22
                                                                                             Chapter 7
                                              Enterprise User Security Manager (EUSM) Command Summary


            Example 7-31 Listing the Database Administrators with SSL Port Conectivity to
            OID and Using Passwords Stored in the Oracle Wallet

            eusm listDBAdmins realm_dn=dc=yy,dc=company,dc=com database_name=dbtest1
            ldap_host=xxxxx.zz.company.com ldap_ssl_port=3131 keystore=/etc/myapp/
            keyStore keystore_alias=keystore1 ldap_user_dn=cn=orcladmin
            ldap_alias=ldabadmin1 wallet_location=/oracle/product/db_1/wallets


            Example 7-32     Listing the Database Administrators with SSL Port Conectivity to
            OID

            eusm listDBAdmins realm_dn=dc=yy,dc=company,dc=com database_name=dbtest1
            ldap_host=xxxxx.zz.company.com ldap_ssl_port=3131 keystore=/etc/myapp/
            keyStore ldap_user_dn=cn=orcladmin


            Example 7-33 Listing the Database Administrators with non-SSL Port
            Conectivity to OID

            eusm listDBAdmins realm_dn=dc=yy,dc=company,dc=com database_name=dbtest1
            ldap_host=xxxxx.zz.company.com ldap_port=3060 ldap_user_dn=cn=orcladmin


7.3.12 listDBInfo
            Lists the database information.

            Syntax

            listDBInfo
                 realm_dn=<DN of the realm>
                 database_name=<Database name>
                 ldap_host=<OID host>
                 ldap_port=<OID non ssl port> | ldap_ssl_port=<OID ssl port>
                 keystore=<path to keystore>
                 keystore_alias=<keystore password alias>
                 ldap_user_dn=<DN of OID user>
                 ldap_alias=<OID user password alias>
                 wallet_location=<wallet location>


            Options
            Each option must be prefixed with a space. Multiple options can be concatenated and
            prefixed with single space.


            Option                                      Description
            realm_dn=<DN of the realm>                  DN of the realm.
            database_name=<Database name>               Database name.
            ldap_host=<OID host>                        OID host.
            ldap_port=<OID non ssl port> |              OID non ssl port or OID ssl port.
            ldap_ssl_port=<OID ssl port>
            keystore=<path to keystore>                 Path to the keystore.




                                                                                               7-23
                                                                                           Chapter 7
                                          Enterprise User Security Manager (EUSM) Command Summary




          Option                                    Description
          keystore_alias=<keystore password         Keystore password taken from the Oracle
          alias>                                    wallet.
          ldap_user_dn=<DN of OID user>             DN of OID user which is used for
                                                    authenticating and executing a command in
                                                    the OID.
          ldap_alias=<OID user password alias> OID user password taken from the Oracle
                                                    wallet.
          wallet_location=<wallet location>         Path to Oracle wallet when using the wallet.

         Usage Notes
         None.

         Examples
         Examples include listing the database information with and without SSL port
         connectivity to OID.
         Example 7-34 Lists the Database Information with SSL Port Conectivity to OID
         and Using Passwords Stored in the Oracle Wallet

         eusm listDBInfo realm_dn=dc=yy,dc=company,dc=com database_name=dbtest1
         ldap_host=xxxxx.zz.company.com ldap_ssl_port=3131 keystore=/etc/myapp/
         keyStore keystore_alias=keystore1 ldap_user_dn=cn=orcladmin
         ldap_alias=ldabadmin1 wallet_location=/oracle/product/db_1/wallets


         Example 7-35    Lists the Database Information with SSL Port Conectivity to OID

         eusm listDBInfo realm_dn=dc=yy,dc=company,dc=com database_name=dbtest1
         ldap_host=xxxxx.zz.company.com ldap_ssl_port=3131 keystore=/etc/myapp/
         keyStore ldap_user_dn=cn=orcladmin


         Example 7-36    Lists the Database Information with non-SSL Port Conectivity to
         OID

         eusm listDBInfo realm_dn=dc=yy,dc=company,dc=com database_name=dbtest1
         ldap_host=xxxxx.zz.company.com ldap_port=3060 ldap_user_dn=cn=orcladmin


7.3.13 removeDBAdmin
         Removes a database administrator.

         Syntax

         removeDBAdmin
              realm_dn=<DN of the realm>
              database_name=<Database name>
              user_dn=<Distinguished name of the user>
              ldap_host=<OID host>
              ldap_port=<OID non ssl port> | ldap_ssl_port=<OID ssl port>



                                                                                              7-24
                                                                                  Chapter 7
                                 Enterprise User Security Manager (EUSM) Command Summary


     keystore=<path to keystore>
     keystore_alias=<keystore password alias>
     ldap_user_dn=<DN of OID user>
     ldap_alias=<OID user password alias>
     wallet_location=<wallet location>


Options
Each option must be prefixed with a space. Multiple options can be concatenated and
prefixed with single space.


Option                                     Description
realm_dn=<DN of the realm>                 DN of the realm.
database_name=<Database name>              Database name.
user_dn=<user DN>                          DN of the user. For example, the user to be
                                           added as database administrator in the
                                           command addDBAdmin.
ldap_host=<OID host>                       OID host.
ldap_port=<OID non ssl port> |             OID non ssl port or OID ssl port.
ldap_ssl_port=<OID ssl port>
keystore=<path to keystore>                Path to the keystore.
keystore_alias=<keystore password          Keystore password taken from the Oracle
alias>                                     wallet.
ldap_user_dn=<DN of OID user>              DN of OID user which is used for
                                           authenticating and executing a command in
                                           the OID.
ldap_alias=<OID user password alias> OID user password taken from the Oracle
                                           wallet.
wallet_location=<wallet location>          Path to Oracle wallet when using the wallet.

Usage Notes
None.

Examples
Examples include removing a database administrator with and without SSL port
connectivity to OID.
Example 7-37 Removing a Database Administrator with SSL Port Conectivity to
OID and Using Passwords Stored in the Oracle Wallet

eusm removeDBAdmin realm_dn=dc=yy,dc=company,dc=com database_name=dbtest1
user_dn=cn=test_user,cn=Users,dc=yy,dc=company,dc=com
ldap_host=xxxxx.zz.company.com ldap_ssl_port=3131 keystore=/etc/myapp/
keyStore keystore_alias=keystore1 ldap_user_dn=cn=orcladmin
ldap_alias=ldabadmin1 wallet_location=/oracle/product/db_1/wallets




                                                                                     7-25
                                                                                          Chapter 7
                                           Enterprise User Security Manager (EUSM) Command Summary


          Example 7-38    Removing a Database Administrator with SSL Port Conectivity to
          OID

          eusm removeDBAdmin realm_dn=dc=yy,dc=company,dc=com database_name=dbtest1
          user_dn=cn=test_user,cn=Users,dc=yy,dc=company,dc=com
          ldap_host=xxxxx.zz.company.com ldap_ssl_port=3131 keystore=/etc/myapp/
          keyStore ldap_user_dn=cn=orcladmin


          Example 7-39 Removing a Database Administrator with non-SSL Port
          Conectivity to OID

          eusm removeDBAdmin realm_dn=dc=yy,dc=company,dc=com database_name=dbtest1
          user_dn=cn=test_user,cn=Users,dc=yy,dc=company,dc=com
          ldap_host=xxxxx.zz.company.com ldap_port=3060 ldap_user_dn=cn=orcladmin


7.3.14 createMapping
          Creates the user and shared schema mapping.

          Syntax

          createMapping
              [domain_name=<domain name>]
              [database_name=<database name>]
               realm_dn=<DN of the realm>
               map_type=<mapping type ENTRY/SUBTREE>
               map_dn=<DN which is being mapped to schema>
               schema=<database schema>
               ldap_host=<OID host>
               ldap_port=<OID non ssl port> | ldap_ssl_port=<OID ssl port>
               keystore=<path to keystore>
               keystore_alias=<keystore password alias>
               ldap_user_dn=<DN of OID user>
               ldap_alias=<OID user password alias>
               wallet_location=<wallet location>


          Options
          Each option must be prefixed with a space. Multiple options can be concatenated and
          prefixed with single space.


           Option                                    Description
           [domain_name=<domain name>]               Name of the domain.
           [database_name=<database name>]           Database name.
           realm_dn=<DN of the realm>                DN of the realm.
           map_type=<mapping type ENTRY/             Type of mapping ENTRY/SUBTREE.
           SUBTREE>
           map_dn=<DN which is being mapped to       DN that is being mapped to the schema.
           schema>
           schema=<database schema>                  Database schema.




                                                                                              7-26
                                                                                 Chapter 7
                                Enterprise User Security Manager (EUSM) Command Summary




Option                                    Description
ldap_host=<OID host>                      OID host.
ldap_port=<OID non ssl port> |            OID non ssl port or OID ssl port.
ldap_ssl_port=<OID ssl port>
keystore=<path to keystore>               Path to the keystore.
keystore_alias=<keystore password         Keystore password taken from the Oracle
alias>                                    wallet.
ldap_user_dn=<DN of OID user>             DN of OID user which is used for
                                          authenticating and executing a command in
                                          the OID.
ldap_alias=<OID user password alias> OID user password taken from the Oracle
                                          wallet.
wallet_location=<wallet location>         Path to Oracle wallet when using the wallet.

Usage Notes
None.

Examples
Examples include creating the user or shared schema mapping with and without SSL
port connectivity to OID.
Example 7-40 Creating the User or Shared Schema Mapping with SSL Port
Conectivity to OID and Using Passwords Stored in the Oracle Wallet

eusm createMapping database_name=dbtest1 realm_dn=dc=yy,dc=company,dc=com
map_type=ENTRY map_dn=cn=test_user,cn=Users,dc=yy,dc=company,dc=com
schema=test_user ldap_host=xxxxx.zz.company.com ldap_ssl_port=3131
keystore=/etc/myapp/keyStore keystore_alias=keystore1
ldap_user_dn=cn=orcladmin ldap_alias=ldabadmin1 wallet_location=/oracle/
product/db_1/wallets


Example 7-41 Creating the User or Shared Schema Mapping with SSL Port
Conectivity to OID

eusm createMapping database_name=dbtest1 realm_dn=dc=yy,dc=company,dc=com
map_type=ENTRY map_dn=cn=test_user,cn=Users,dc=yy,dc=company,dc=com
schema=test_user ldap_host=xxxxx.zz.company.com ldap_ssl_port=3131
keystore=/etc/myapp/keyStore ldap_user_dn=cn=orcladmin


Example 7-42 Creating the User or Shared Schema Mapping with non-SSL Port
Conectivity to OID

eusm createMapping database_name=dbtest1 realm_dn=dc=yy,dc=company,dc=com
map_type=ENTRY map_dn=cn=test_user,cn=Users,dc=yy,dc=company,dc=com
schema=test_user ldap_host=xxxxx.zz.company.com ldap_port=3060
ldap_user_dn=cn=orcladmin




                                                                                    7-27
                                                                                            Chapter 7
                                           Enterprise User Security Manager (EUSM) Command Summary




7.3.15 deleteMapping
          Deletes a mapping.

          Syntax

          deleteMapping
              [domain_name=<domain name>]
              [database_name=<database name>]
               realm_dn=<DN of the realm>
               mapping_name=<Name of mapping>
               ldap_host=<OID host>
               ldap_port=<OID non ssl port> | ldap_ssl_port=<OID ssl port>
               keystore=<path to keystore>
               keystore_alias=<keystore password alias>
               ldap_user_dn=<DN of OID user>
               ldap_alias=<OID user password alias>
               wallet_location=<wallet location>


          Options
          Each option must be prefixed with a space. Multiple options can be concatenated and
          prefixed with single space.


           Option                                    Description
           [domain_name=<domain name>]               Name of the domain.
           [database_name=<database name>]           Database name.
           realm_dn=<DN of the realm>                DN of the realm.
           mapping_name=<Name of mapping>            Name of the mapping.
           ldap_host=<OID host>                      OID host.
           ldap_port=<OID non ssl port> |            OID non ssl port or OID ssl port.
           ldap_ssl_port=<OID ssl port>
           keystore=<path to keystore>               Path to the keystore.
           keystore_alias=<keystore password         Keystore password taken from the Oracle
           alias>                                    wallet.
           ldap_user_dn=<DN of OID user>             DN of OID user which is used for
                                                     authenticating and executing a command in
                                                     the OID.
           ldap_alias=<OID user password alias> OID user password taken from the Oracle
                                                     wallet.
           wallet_location=<wallet location>         Path to Oracle wallet when using the wallet.

          Usage Notes
          None.

          Examples
          Examples include deleting the user or shared schema mapping with and without SSL
          port connectivity to OID.




                                                                                               7-28
                                                                                                Chapter 7
                                              Enterprise User Security Manager (EUSM) Command Summary


           Example 7-43 Deleting the User or Shared Schema Mapping with SSL Port
           Conectivity to OID and Using Passwords Stored in the Oracle Wallet

           eusm deleteMapping database_name=dbtest1 realm_dn=dc=yy,dc=company,dc=com
           mapping_name=MAPPING01 ldap_host=xxxxx.zz.company.com ldap_ssl_port=3131
           keystore=/etc/myapp/keyStore keystore_alias=keystore1
           ldap_user_dn=cn=orcladmin ldap_alias=ldabadmin1 wallet_location=/oracle/
           product/db_1/wallets


           Example 7-44 Deleting the User or Shared Schema Mapping with SSL Port
           Conectivity to OID

           eusm deleteMapping database_name=dbtest1 realm_dn=dc=yy,dc=company,dc=com
           mapping_name=MAPPING01 ldap_host=xxxxx.zz.company.com ldap_ssl_port=3131
           keystore=/etc/myapp/keyStore ldap_user_dn=cn=orcladmin


           Example 7-45 Deleting the User or Shared Schema Mapping with non-SSL Port
           Conectivity to OID

           eusm deleteMapping database_name=dbtest1 realm_dn=dc=yy,dc=company,dc=com
           mapping_name=MAPPING01 ldap_host=xxxxx.zz.company.com ldap_port=3060
           ldap_user_dn=cn=orcladmin


7.3.16 listMappings
           Lists the user and shared schema mappings.

           Prerequisites
           (Optional) List the prerequisites for executing the command in the following list:
           •   Prerequisite #1
           •   Prerequisite #2

           Syntax

           listMappings
               [domain_name=<domain name>]
               [database_name=<database name>]
                realm_dn=<DN of the realm>
                ldap_host=<OID host>
                ldap_port=<OID non ssl port> | ldap_ssl_port=<OID ssl port>
                keystore=<path to keystore>
                keystore_alias=<keystore password alias>
                ldap_user_dn=<DN of OID user>
                ldap_alias=<OID user password alias>
                wallet_location=<wallet location>


           Options
           Each option must be prefixed with a space. Multiple options can be concatenated and
           prefixed with single space.




                                                                                                  7-29
                                                                                 Chapter 7
                                Enterprise User Security Manager (EUSM) Command Summary




Option                                    Description
[domain_name=<domain name>]               Name of the domain.
[database_name=<database name>]           Database name.
realm_dn=<DN of the realm>                DN of the realm.
ldap_host=<OID host>                      OID host.
ldap_port=<OID non ssl port> |            OID non ssl port or OID ssl port.
ldap_ssl_port=<OID ssl port>
keystore=<path to keystore>               Path to the keystore.
keystore_alias=<keystore password         Keystore password taken from the Oracle
alias>                                    wallet.
ldap_user_dn=<DN of OID user>             DN of OID user which is used for
                                          authenticating and executing a command in
                                          the OID.
ldap_alias=<OID user password alias> OID user password taken from the Oracle
                                          wallet.
wallet_location=<wallet location>         Path to Oracle wallet when using the wallet.

Usage Notes
None.

Examples
Examples include listing the user or shared schema mappings with and without SSL
port connectivity to OID.
Example 7-46 Listing the User or Shared Schema Mappings with SSL Port
Conectivity to OID and Using Passwords Stored in the Oracle Wallet

eusm listMappings database_name=dbtest1 realm_dn=dc=yy,dc=company,dc=com
ldap_host=xxxxx.zz.company.com ldap_ssl_port=3131 keystore=/etc/myapp/
keyStore keystore_alias=keystore1 ldap_user_dn=cn=orcladmin
ldap_alias=ldabadmin1 wallet_location=/oracle/product/db_1/wallets


Example 7-47 Listing the User or Shared Schema Mappings with SSL Port
Conectivity to OID

eusm listMappings database_name=dbtest1 realm_dn=dc=yy,dc=company,dc=com
ldap_host=xxxxx.zz.company.com ldap_ssl_port=3131 keystore=/etc/myapp/
keyStore ldap_user_dn=cn=orcladmin


Example 7-48 Listing the User or Shared Schema Mappings with non-SSL Port
Conectivity to OID

eusm listMappings database_name=dbtest1 realm_dn=dc=yy,dc=company,dc=com
ldap_host=xxxxx.zz.company.com ldap_port=3060 ldap_user_dn=cn=orcladmin




                                                                                    7-30
                                                                                             Chapter 7
                                            Enterprise User Security Manager (EUSM) Command Summary




7.3.17 setCulinkStatus
           Enables or disables the current user database-link usage in the domain.

           Syntax

           setCulinkStatus
                domain_name=<domain name>
                realm_dn=<DN of the realm>
                status=<ENABLED/DISABLED>
                ldap_host=<OID host>
                ldap_port=<OID non ssl port> | ldap_ssl_port=<OID ssl port>
                keystore=<path to keystore>
                keystore_alias=<keystore password alias>
                ldap_user_dn=<DN of OID user>
                ldap_alias=<OID user password alias>
                wallet_location=<wallet location>


           Options
           Each option must be prefixed with a space. Multiple options can be concatenated and
           prefixed with single space.


            Option                                    Description
            domain_name=<domain name>                 Name of the domain.
            realm_dn=<DN of the realm>                DN of the realm.
            status=<ENABLED/DISABLED>                 Whether the status is enabled or disabled.
            ldap_host=<OID host>                      OID host.
            ldap_port=<OID non ssl port> |            OID non ssl port or OID ssl port.
            ldap_ssl_port=<OID ssl port>
            keystore=<path to keystore>               Path to the keystore.
            keystore_alias=<keystore password         Keystore password taken from the Oracle
            alias>                                    wallet.
            ldap_user_dn=<DN of OID user>             DN of OID user which is used for
                                                      authenticating and executing a command in
                                                      the OID.
            ldap_alias=<OID user password alias> OID user password taken from the Oracle
                                                      wallet.
            wallet_location=<wallet location>         Path to Oracle wallet when using the wallet.

           Usage Notes
           None.

           Examples
           Examples include enabling the current user database-link usage in the domain with
           and without SSL port connectivity to OID.




                                                                                                7-31
                                                                                           Chapter 7
                                            Enterprise User Security Manager (EUSM) Command Summary


          Example 7-49 Enabling the Current User Database-link Usage in the Domain
          with SSL Port Conectivity to OID and Using Passwords Stored in the Oracle
          Wallet

          eusm setCulinkStatus domain_name=test_domain
          realm_dn=dc=yy,dc=company,dc=com status=ENABLED
          ldap_host=xxxxx.zz.company.com ldap_ssl_port=3131 keystore=/etc/myapp/
          keyStore keystore_alias=keystore1 ldap_user_dn=cn=orcladmin
          ldap_alias=ldabadmin1 wallet_location=/oracle/product/db_1/wallets


          Example 7-50 Enabling the Current User Database-link Usage in the Domain
          with SSL Port Conectivity to OID

          eusm setCulinkStatus domain_name=test_domain
          realm_dn=dc=yy,dc=company,dc=com status=ENABLED
          ldap_host=xxxxx.zz.company.com ldap_ssl_port=3131 keystore=/etc/myapp/
          keyStore ldap_user_dn=cn=orcladmin


          Example 7-51 Enabling the Current User Database-link Usage in the Domain
          with non-SSL Port Conectivity to OID

          eusm setCulinkStatus domain_name=test_domain
          realm_dn=dc=yy,dc=company,dc=com status=ENABLED
          ldap_host=xxxxx.zz.company.com ldap_port=3060 ldap_user_dn=cn=orcladmin


7.3.18 setAuthTypes
          Sets the authentication types to be accepted for the users in the domain

          Syntax

          setAuthTypes
               domain_name=<domain name>
               realm_dn=<DN of the realm>
               auth_types=<Allowed User-DB authentication>
               ldap_host=<OID host>
               ldap_port=<OID non ssl port> | ldap_ssl_port=<OID ssl port>
               keystore=<path to keystore>
               keystore_alias=<keystore password alias>
               ldap_user_dn=<DN of OID user>
               ldap_alias=<OID user password alias>
               wallet_location=<wallet location>


          Options
          Each option must be prefixed with a space. Multiple options can be concatenated and
          prefixed with single space.


           Option                                     Description
           domain_name=<domain name>                  Name of the domain.
           realm_dn=<DN of the realm>                 DN of the realm.




                                                                                             7-32
                                                                                   Chapter 7
                                  Enterprise User Security Manager (EUSM) Command Summary




Option                                      Description
auth_types=<Allowed User-DB                 Allowed user-database authentication types
authentication>
ldap_host=<OID host>                        OID host.
ldap_port=<OID non ssl port> |              OID non ssl port or OID ssl port.
ldap_ssl_port=<OID ssl port>
keystore=<path to keystore>                 Path to the keystore.
keystore_alias=<keystore password           Keystore password taken from the Oracle
alias>                                      wallet.
ldap_user_dn=<DN of OID user>               DN of OID user which is used for
                                            authenticating and executing a command in
                                            the OID.
ldap_alias=<OID user password alias> OID user password taken from the Oracle
                                            wallet.
wallet_location=<wallet location>           Path to Oracle wallet when using the wallet.

Usage Notes
None.

Examples
Examples include setting the authentication type accepted for user in the domain with
and without SSL port connectivity to OID.
Example 7-52 Setting the Authentication Types Accepted for the Users in the
Domain with SSL Port Conectivity to OID and Using Passwords Stored in the
Oracle Wallet

eusm setAuthTypes domain_name=test_domain realm_dn=dc=yy,dc=company,dc=com
auth_type=SSL ldap_host=xxxxx.zz.company.com ldap_ssl_port=3131
keystore=/etc/myapp/keyStore keystore_alias=keystore1
ldap_user_dn=cn=orcladmin ldap_alias=ldabadmin1 wallet_location=/oracle/
product/db_1/wallets


Example 7-53 Setting the Authentication Types Accepted for the Users in the
Domain with SSL Port Conectivity to OID

eusm setAuthTypes domain_name=test_domain realm_dn=dc=yy,dc=company,dc=com
auth_type=SSL ldap_host=xxxxx.zz.company.com ldap_ssl_port=3131
keystore=/etc/myapp/keyStore ldap_user_dn=cn=orcladmin


Example 7-54 Setting the Authentication Types Accepted for the Users in the
Domain with non-SSL Port Conectivity to OID

eusm setAuthTypes domain_name=test_domain realm_dn=dc=yy,dc=company,dc=com
auth_type=SSL ldap_host=xxxxx.zz.company.com ldap_port=3060
ldap_user_dn=cn=orcladmin




                                                                                      7-33
                                                                                              Chapter 7
                                             Enterprise User Security Manager (EUSM) Command Summary




7.3.19 createRole
           Creates an enterprise role.

           Syntax

           createRole
                enterprise_role=<Enterprise role name>
                domain_name=<domain name>
                realm_dn=<DN of the realm>
                ldap_host=<OID host>
                ldap_port=<OID non ssl port> | ldap_ssl_port=<OID ssl port>
                keystore=<path to keystore>
                keystore_alias=<keystore password alias>
                ldap_user_dn=<DN of OID user>
                ldap_alias=<OID user password alias>
                wallet_location=<wallet location>


           Options
           Each option must be prefixed with a space. Multiple options can be concatenated and
           prefixed with single space.


           Option                                      Description
           enterprise_role=<Enterprise role            Name of the enterprise role.
           name>
           domain_name=<domain name>                   Name of the domain.
           realm_dn=<DN of the realm>                  DN of the realm.
           ldap_host=<OID host>                        OID host.
           ldap_port=<OID non ssl port> |              OID non ssl port or OID ssl port.
           ldap_ssl_port=<OID ssl port>
           keystore=<path to keystore>                 Path to the keystore.
           keystore_alias=<keystore password           Keystore password taken from the Oracle
           alias>                                      wallet.
           ldap_user_dn=<DN of OID user>               DN of OID user which is used for
                                                       authenticating and executing a command in
                                                       the OID.
           ldap_alias=<OID user password alias> OID user password taken from the Oracle
                                                       wallet.
           wallet_location=<wallet location>           Path to Oracle wallet when using the wallet.

           Usage Notes
           Enterprise roles are access privileges assigned to enterprise users. Enterprise roles
           are a set of Oracle role-based authorizations across one or more databases in an
           enterprise domain. Enterprise roles are stored in the directory and contain one or more
           global roles.




                                                                                                 7-34
                                                                                              Chapter 7
                                              Enterprise User Security Manager (EUSM) Command Summary


           A global role is a role managed in a directory, but its privileges are contained within a
           single database. A global role is created in a database using SQL*Plus. For example:

           SQL> create role global_connect identified globally;
           SQL> create role global_resource identified globally;
           SQL> grant connect to global_connect;
           SQL> grant resource to global_resource;


           Examples
           Examples include creating an enterprise role in an enterprise domain in the realm with
           and without SSL port connectivity to OID.
           Example 7-55 Creating a Role with SSL Port Conectivity to OID and Using
           Passwords Stored in the Oracle Wallet

           eusm createRole enterprise_role=ent_connect
           domain_name=OracleDefaultDomain realm_dn=dc=yy,dc=company,dc=com
           ldap_host=xxxxx.zz.company.com ldap_ssl_port=3131 keystore=/etc/myapp/
           keyStore keystore_alias=keystore1 ldap_user_dn=cn=orcladmin
           ldap_alias=ldabadmin1 wallet_location=/oracle/product/db_1/wallets


           Example 7-56     Creating a Role with SSL Port Conectivity to OID

           eusm createRole enterprise_role=ent_connect
           domain_name=OracleDefaultDomain realm_dn=dc=yy,dc=company,dc=com
           ldap_host=xxxxx.zz.company.com ldap_ssl_port=3131 keystore=/etc/myapp/
           keyStore ldap_user_dn=cn=orcladmin


           Example 7-57     Creating a Role with non-SSL Port Conectivity to OID

           eusm createRole enterprise_role=ent_connect
           domain_name=OracleDefaultDomain realm_dn=dc=yy,dc=company,dc=com
           ldap_host=xxxxx.zz.company.com ldap_port=3060 ldap_user_dn=cn=orcladmin


7.3.20 deleteRole
           Deletes an enterprise role.

           Syntax

           deleteRole
                enterprise_role=<Enterprise role name>
                domain_name=<domain name>
                realm_dn=<DN of the realm>
                ldap_host=<OID host>
                ldap_port=<OID non ssl port> | ldap_ssl_port=<OID ssl port>
                keystore=<path to keystore>
                keystore_alias=<keystore password alias>
                ldap_user_dn=<DN of OID user>
                ldap_alias=<OID user password alias>
                wallet_location=<wallet location>




                                                                                                7-35
                                                                                     Chapter 7
                                   Enterprise User Security Manager (EUSM) Command Summary




Options
Each option must be prefixed with a space. Multiple options can be concatenated and
prefixed with single space.


Option                                        Description
enterprise_role=<Enterprise role              Name of the enterprise role.
name>
domain_name=<domain name>                     Name of the domain.
realm_dn=<DN of the realm>                    DN of the realm.
ldap_host=<OID host>                          OID host.
ldap_port=<OID non ssl port> |                OID non ssl port or OID ssl port.
ldap_ssl_port=<OID ssl port>
keystore=<path to keystore>                   Path to the keystore.
keystore_alias=<keystore password             Keystore password taken from the Oracle
alias>                                        wallet.
ldap_user_dn=<DN of OID user>                 DN of OID user which is used for
                                              authenticating and executing a command in
                                              the OID.
ldap_alias=<OID user password alias> OID user password taken from the Oracle
                                              wallet.
wallet_location=<wallet location>             Path to Oracle wallet when using the wallet.

Usage Notes
Enterprise roles are access privileges assigned to enterprise users. Enterprise roles
are a set of Oracle role-based authorizations across one or more databases in an
enterprise domain. Enterprise roles are stored in the directory and contain one or more
global roles.
A global role is a role managed in a directory, but its privileges are contained within a
single database. A global role is created in a database using SQL*Plus. For example:

SQL> create role global_connect identified globally;
SQL> create role global_resource identified globally;
SQL> grant connect to global_connect;
SQL> grant resource to global_resource;


Examples
Examples include deleting an enterprise role in an enterprise domain in the realm with
and without SSL port connectivity to OID.
Example 7-58 Deleting a Role with SSL Port Conectivity to OID and Using
Passwords Stored in the Oracle Wallet

eusm deleteRole enterprise_role=ent_connect
domain_name=OracleDefaultDomain realm_dn=dc=yy,dc=company,dc=com
ldap_host=xxxxx.zz.company.com ldap_ssl_port=3131 keystore=/etc/myapp/
keyStore keystore_alias=keystore1 ldap_user_dn=cn=orcladmin
ldap_alias=ldabadmin1 wallet_location=/oracle/product/db_1/wallets




                                                                                        7-36
                                                                                               Chapter 7
                                             Enterprise User Security Manager (EUSM) Command Summary


          Example 7-59     Deleting a Role with SSL Port Conectivity to OID

          eusm deleteRole enterprise_role=ent_connect
          domain_name=OracleDefaultDomain realm_dn=dc=yy,dc=company,dc=com
          ldap_host=xxxxx.zz.company.com ldap_ssl_port=3131 keystore=/etc/myapp/
          keyStore ldap_user_dn=cn=orcladmin


          Example 7-60     Deleting a Role with non-SSL Port Conectivity to OID

          eusm deleteRole enterprise_role=ent_connect
          domain_name=OracleDefaultDomain realm_dn=dc=yy,dc=company,dc=com
          ldap_host=xxxxx.zz.company.com ldap_port=3060 ldap_user_dn=cn=orcladmin


7.3.21 addGlobalRole
          Adds a global role or an administrative role to an enterprise role.

          Syntax

          addGlobalRole
               enterprise_role=<Enterprise role name>
               domain_name=<domain name>
               realm_dn=<DN of the realm>
               database_name=<Database name>
               global_role=<Global role name>
               dbuser=<Database user name to connect>
               db_alias=<Database username password alias>
               dbconnect_string=<Database connect string>
               ldap_host=<OID host>
               ldap_port=<OID non ssl port> | ldap_ssl_port=<OID ssl port>
               keystore=<path to keystore>
               keystore_alias=<keystore password alias>
               ldap_user_dn=<DN of OID user>
               ldap_alias=<OID user password alias>
               wallet_location=<wallet location>


          Options
          Each option must be prefixed with a space. Multiple options can be concatenated and
          prefixed with single space.


           Option                                       Description
           enterprise_role=<Enterprise role             Name of the enterprise role.
           name>
           domain_name=<domain name>                    Name of the domain.
           realm_dn=<DN of the realm>                   DN of the realm.
           database_name=<Database name>                Database name.
           global_role=<Global role name>               Global role or administrative role name.
           dbuser=<Database user name to                The database user name to connect.
           connect>




                                                                                                   7-37
                                                                                   Chapter 7
                                  Enterprise User Security Manager (EUSM) Command Summary




Option                                      Description
db_alias=<Database username password Database user password taken from the
alias>                               Oracle wallet.
dbconnect_string=<Database connect          Database connect string
string>
ldap_host=<OID host>                        OID host.
ldap_port=<OID non ssl port> |              OID non ssl port or OID ssl port.
ldap_ssl_port=<OID ssl port>
keystore=<path to keystore>                 Path to the keystore.
keystore_alias=<keystore password           Keystore password taken from the Oracle
alias>                                      wallet.
ldap_user_dn=<DN of OID user>               DN of OID user which is used for
                                            authenticating and executing a command in
                                            the OID.
ldap_alias=<OID user password alias> OID user password taken from the Oracle
                                            wallet.
wallet_location=<wallet location>           Path to Oracle wallet when using the wallet.

Usage Notes
Enterprise roles are access privileges assigned to enterprise users. Enterprise roles
are a set of Oracle role-based authorizations across one or more databases in an
enterprise domain. Enterprise roles are stored in the directory and contain one or more
global roles.
A global role and an administrative role are roles managed in a directory, but their
privileges are contained within a single database. A global role and an administrative
role are created in a database using SQL*Plus. A global_role for administrative role
can be either SYSDBA, SYSOPER, SYSBACKUP, SYSKM, or SYSDG. For example:

SQL> create role global_connect identified globally;
SQL> create role global_resource identified globally;
SQL> grant connect to global_connect;
SQL> grant resource to global_resource;


Examples
Examples include adding a global role and an administrative role in an enterprise
domain in the realm for a database user with and without SSL port connectivity to OID.
Example 7-61 Adding a Global Role with SSL Port Conectivity to OID and
Using Passwords Stored in the Oracle Wallet

eusm addGlobalRole enterprise_role=ent_resource
domain_name=OracleDefaultDomain realm_dn=dc=yy,dc=company,dc=com
database_name=dbtest1 global_role=global_resource dbuser=system
db_alias=dbadmin1 dbconnect_string=zzzz10-yy.yy.company.com:1531:dbtest1
ldap_host=xxxxx.zz.company.com ldap_ssl_port=3131 keystore=/etc/myapp/
keyStore keystore_alias=keystore1 ldap_user_dn=cn=orcladmin
ldap_alias=ldabadmin1 wallet_location=/oracle/product/db_1/wallets




                                                                                      7-38
                                                                                           Chapter 7
                                            Enterprise User Security Manager (EUSM) Command Summary


          Example 7-62 Adding an Administrative Role with SSL Port Conectivity to OID
          and Using Passwords Stored in the Oracle Wallet

          eusm addGlobalRole enterprise_role=ent_resource
          domain_name=OracleDefaultDomain realm_dn=dc=yy,dc=company,dc=com
          database_name=dbtest1 global_role=SYSDBA dbuser=system db_alias=dbadmin1
          dbconnect_string=zzzz10-yy.yy.company.com:1531:dbtest1
          ldap_host=xxxxx.zz.company.com ldap_ssl_port=3131 keystore=/etc/myapp/
          keyStore keystore_alias=keystore1 ldap_user_dn=cn=orcladmin
          ldap_alias=ldabadmin1 wallet_location=/oracle/product/db_1/wallets


          Example 7-63     Adding a Global Role with SSL Port Conectivity to OID

          eusm addGlobalRole enterprise_role=ent_resource
          domain_name=OracleDefaultDomain realm_dn=dc=yy,dc=company,dc=com
          database_name=dbtest1 global_role=global_resource dbuser=system
          dbconnect_string=zzzz10-yy.yy.company.com:1531:dbtest1
          ldap_host=xxxxx.zz.company.com ldap_ssl_port=3131 keystore=/etc/myapp/
          keyStore ldap_user_dn=cn=orcladmin


          Example 7-64     Adding an Administrative Role with SSL Port Conectivity to OID

          eusm addGlobalRole enterprise_role=ent_resource
          domain_name=OracleDefaultDomain realm_dn=dc=yy,dc=company,dc=com
          database_name=dbtest1 global_role=SYSDBA dbuser=system
          dbconnect_string=zzzz10-yy.yy.company.com:1531:dbtest1
          ldap_host=xxxxx.zz.company.com ldap_ssl_port=3131 keystore=/etc/myapp/
          keyStore ldap_user_dn=cn=orcladmin


          Example 7-65     Adding a Global Role with non-SSL Port Conectivity to OID

          eusm addGlobalRole enterprise_role=ent_resource
          domain_name=OracleDefaultDomain realm_dn=dc=yy,dc=company,dc=com
          database_name=dbtest1 global_role=global_resource dbuser=system
          dbconnect_string=zzzz10-yy.yy.company.com:1531:dbtest1
          ldap_host=xxxxx.zz.company.com ldap_port=3060 ldap_user_dn=cn=orcladmin


          Example 7-66     Adding an Administrative Role with non-SSL Port Conectivity to
          OID

          eusm addGlobalRole enterprise_role=ent_resource
          domain_name=OracleDefaultDomain realm_dn=dc=yy,dc=company,dc=com
          database_name=dbtest1 global_role=SYSDBA dbuser=system
          dbconnect_string=zzzz10-yy.yy.company.com:1531:dbtest1
          ldap_host=xxxxx.zz.company.com ldap_port=3060 ldap_user_dn=cn=orcladmin


7.3.22 removeGlobalRole
          Removes a global role or an administrative role from an enterprise role.




                                                                                             7-39
                                                                                  Chapter 7
                                 Enterprise User Security Manager (EUSM) Command Summary




Syntax

removeGlobalRole
     enterprise_role=<Enterprise role name>
     domain_name=<domain name>
     realm_dn=<DN of the realm>
     database_name=<Database name>
     global_role=<Global role name >
     dbuser=<Database user name to connect>
     db_alias=<Database username password alias>
     dbconnect_string=<Database connect string>
     ldap_host=<OID host>
     ldap_port=<OID non ssl port> | ldap_ssl_port=<OID ssl port>
     keystore=<path to keystore>
     keystore_alias=<keystore password alias>
     ldap_user_dn=<DN of OID user>
     ldap_alias=<OID user password alias>
     wallet_location=<wallet location>


Options
Each option must be prefixed with a space. Multiple options can be concatenated and
prefixed with single space.


Option                                     Description
enterprise_role=<Enterprise role           Name of the enterprise role.
name>
domain_name=<domain name>                  Name of the domain.
realm_dn=<DN of the realm>                 DN of the realm.
database_name=<Database name>              Database name.
global_role=<Global role name>             Global role or administrative role name.
dbuser=<Database user name to        The database user name to connect.
connect>
db_alias=<Database username password Database user password taken from the
alias>                               Oracle wallet.
dbconnect_string=<Database connect         Database connect string
string>
ldap_host=<OID host>                       OID host.
ldap_port=<OID non ssl port> |             OID non ssl port or OID ssl port.
ldap_ssl_port=<OID ssl port>
keystore=<path to keystore>                Path to the keystore.
keystore_alias=<keystore password          Keystore password taken from the Oracle
alias>                                     wallet.
ldap_user_dn=<DN of OID user>              DN of OID user which is used for
                                           authenticating and executing a command in
                                           the OID.
ldap_alias=<OID user password alias> OID user password taken from the Oracle
                                           wallet.
wallet_location=<wallet location>          Path to Oracle wallet when using the wallet.




                                                                                      7-40
                                                                                 Chapter 7
                                  Enterprise User Security Manager (EUSM) Command Summary




Usage Notes
Enterprise roles are access privileges assigned to enterprise users. Enterprise roles
are a set of Oracle role-based authorizations across one or more databases in an
enterprise domain. Enterprise roles are stored in the directory and contain one or more
global roles.
A global role and an administrative role are roles managed in a directory, but their
privileges are contained within a single database. A global role and an administrative
role are created in a database using SQL*Plus. A global_role for administrative role
can be either SYSDBA, SYSOPER, SYSBACKUP, SYSKM, or SYSDG. For example:

SQL> create role global_connect identified globally;
SQL> create role global_resource identified globally;
SQL> grant connect to global_connect;
SQL> grant resource to global_resource;


Examples
Examples include removing a global role and an administrative role in an enterprise
domain in the realm from a database user with and without SSL port connectivity to
OID.
Example 7-67 Removing a Global Role with SSL Port Conectivity to OID and
Using Passwords Stored in the Oracle Wallet

eusm removeGlobalRole enterprise_role=ent_resource
domain_name=OracleDefaultDomain realm_dn=dc=yy,dc=company,dc=com
database_name=dbtest1 global_role=global_connect dbuser=system
db_alias=dbadmin1 dbconnect_string=zzzz10-yy.yy.company.com:1531:dbtest1
ldap_host=xxxxx.zz.company.com ldap_ssl_port=3131 keystore=/etc/myapp/
keyStore keystore_alias=keystore1 ldap_user_dn=cn=orcladmin
ldap_alias=ldabadmin1 wallet_location=/oracle/product/db_1/wallets


Example 7-68 Removing an Administrative Role with SSL Port Conectivity to
OID and Using Passwords Stored in the Oracle Wallet

eusm removeGlobalRole enterprise_role=ent_resource
domain_name=OracleDefaultDomain realm_dn=dc=yy,dc=company,dc=com
database_name=dbtest1 global_role=SYSDBA dbuser=system db_alias=dbadmin1
dbconnect_string=zzzz10-yy.yy.company.com:1531:dbtest1
ldap_host=xxxxx.zz.company.com ldap_ssl_port=3131 keystore=/etc/myapp/
keyStore keystore_alias=keystore1 ldap_user_dn=cn=orcladmin
ldap_alias=ldabadmin1 wallet_location=/oracle/product/db_1/wallets


Example 7-69     Removing a Global Role with SSL Port Conectivity to OID

eusm removeGlobalRole enterprise_role=ent_resource
domain_name=OracleDefaultDomain realm_dn=dc=yy,dc=company,dc=com
database_name=dbtest1 global_role=global_connect dbuser=system
dbconnect_string=zzzz10-yy.yy.company.com:1531:dbtest1
ldap_host=xxxxx.zz.company.com ldap_ssl_port=3131 keystore=/etc/myapp/
keyStore ldap_user_dn=cn=orcladmin




                                                                                   7-41
                                                                                           Chapter 7
                                            Enterprise User Security Manager (EUSM) Command Summary


           Example 7-70     Removing an Administrative Role with SSL Port Conectivity to
           OID

           eusm removeGlobalRole enterprise_role=ent_resource
           domain_name=OracleDefaultDomain realm_dn=dc=yy,dc=company,dc=com
           database_name=dbtest1 global_role=SYSDBA dbuser=system
           dbconnect_string=zzzz10-yy.yy.company.com:1531:dbtest1
           ldap_host=xxxxx.zz.company.com ldap_ssl_port=3131 keystore=/etc/myapp/
           keyStore ldap_user_dn=cn=orcladmin


           Example 7-71     Removing a Global Role with non-SSL Port Conectivity to OID

           eusm removeGlobalRole enterprise_role=ent_resource
           domain_name=OracleDefaultDomain realm_dn=dc=yy,dc=company,dc=com
           database_name=dbtest1 global_role=global_connect dbuser=system
           dbconnect_string=zzzz10-yy.yy.company.com:1531:dbtest1
           ldap_host=xxxxx.zz.company.com ldap_port=3060 ldap_user_dn=cn=orcladmin


           Example 7-72     Removing an Administrative Role with non-SSL Port Conectivity
           to OID

           eusm removeGlobalRole enterprise_role=ent_resource
           domain_name=OracleDefaultDomain realm_dn=dc=yy,dc=company,dc=com
           database_name=dbtest1 global_role=SYSDBA dbuser=system
           dbconnect_string=zzzz10-yy.yy.company.com:1531:dbtest1
           ldap_host=xxxxx.zz.company.com ldap_port=3060 ldap_user_dn=cn=orcladmin


7.3.23 grantRole
           Grants an enterprise role.

           Syntax

           grantRole
                enterprise_role=<Enterprise role name>
                domain_name=<domain name>
                realm_dn=<DN of the realm>
                [user_dn=<Distinguished name of user>]
                [group_dn=<Distinguished name of group>]
                ldap_host=<OID host>
                ldap_port=<OID non ssl port> | ldap_ssl_port=<OID ssl port>
                keystore=<path to keystore>
                keystore_alias=<keystore password alias>
                ldap_user_dn=<DN of OID user>
                ldap_alias=<OID user password alias>
                wallet_location=<wallet location>


           Options
           Each option must be prefixed with a space. Multiple options can be concatenated and
           prefixed with single space.




                                                                                             7-42
                                                                                     Chapter 7
                                   Enterprise User Security Manager (EUSM) Command Summary




Option                                        Description
enterprise_role=<Enterprise role              Name of the enterprise role.
name>
domain_name=<domain name>                     Name of the domain.
realm_dn=<DN of the realm>                    DN of the realm.
[user_dn=<Distinguished name of               DN of the user.
user>]
[group_dn=<Distinguished name of              DN of the group.
group>]
ldap_host=<OID host>                          OID host.
ldap_port=<OID non ssl port> |                OID non ssl port or OID ssl port.
ldap_ssl_port=<OID ssl port>
keystore=<path to keystore>                   Path to the keystore.
keystore_alias=<keystore password             Keystore password taken from the Oracle
alias>                                        wallet.
ldap_user_dn=<DN of OID user>                 DN of OID user which is used for
                                              authenticating and executing a command in
                                              the OID.
ldap_alias=<OID user password alias> OID user password taken from the Oracle
                                              wallet.
wallet_location=<wallet location>             Path to Oracle wallet when using the wallet.

Usage Notes
Enterprise roles are access privileges assigned to enterprise users. Enterprise roles
are a set of Oracle role-based authorizations across one or more databases in an
enterprise domain. Enterprise roles are stored in the directory and contain one or more
global roles.
A global role is a role managed in a directory, but its privileges are contained within a
single database. A global role is created in a database using SQL*Plus. For example:

SQL> create role global_connect identified globally;
SQL> create role global_resource identified globally;
SQL> grant connect to global_connect;
SQL> grant resource to global_resource;


Examples
Examples include granting an enterprise role in an enterprise domain in the realm to a
user with and without SSL port connectivity to OID.
Example 7-73 Granting a Role to a User with SSL Port Conectivity to OID and
Using Passwords Stored in the Oracle Wallet

eusm grantRole enterprise_role=ent_connect domain_name=OracleDefaultDomain
realm_dn=dc=yy,dc=company,dc=com
user_dn=cn=test_user,cn=Users,dc=yy,dc=company,dc=com
ldap_host=xxxxx.zz.company.com ldap_ssl_port=3131 keystore=/etc/myapp/




                                                                                        7-43
                                                                                           Chapter 7
                                            Enterprise User Security Manager (EUSM) Command Summary


           keyStore keystore_alias=keystore1 ldap_user_dn=cn=orcladmin
           ldap_alias=ldabadmin1 wallet_location=/oracle/product/db_1/wallets


           Example 7-74    Granting a Role to a User with SSL Port Conectivity to OID

           eusm grantRole enterprise_role=ent_connect domain_name=OracleDefaultDomain
           realm_dn=dc=yy,dc=company,dc=com
           user_dn=cn=test_user,cn=Users,dc=yy,dc=company,dc=com
           ldap_host=xxxxx.zz.company.com ldap_ssl_port=3131 keystore=/etc/myapp/
           keyStore ldap_user_dn=cn=orcladmin


           Example 7-75    Granting a Role to a User with non-SSL Port Conectivity to OID

           eusm grantRole enterprise_role=ent_connect domain_name=OracleDefaultDomain
           realm_dn=dc=yy,dc=company,dc=com
           user_dn=cn=test_user,cn=Users,dc=yy,dc=company,dc=com
           ldap_host=xxxxx.zz.company.com ldap_port=3060 ldap_user_dn=cn=orcladmin


7.3.24 revokeRole
           Revokes an enterprise role.

           Syntax

           revokeRole
                enterprise_role=<Enterprise role name>
                domain_name=<domain name>
                realm_dn=<DN of the realm>
                [user_dn=<Distinguished name of user>]
                [group_dn=<Distinguished name of group>]
                ldap_host=<OID host>
                ldap_port=<OID non ssl port> | ldap_ssl_port=<OID ssl port>
                keystore=<path to keystore>
                keystore_alias=<keystore password alias>
                ldap_user_dn=<DN of OID user>
                ldap_alias=<OID user password alias>
                wallet_location=<wallet location>


           Options
           Each option must be prefixed with a space. Multiple options can be concatenated and
           prefixed with single space.


           Option                                     Description
           enterprise_role=<Enterprise role           Name of the enterprise role.
           name>
           domain_name=<domain name>                  Name of the domain.
           realm_dn=<DN of the realm>                 DN of the realm.
           [user_dn=<Distinguished name of            DN of the user.
           user>]




                                                                                             7-44
                                                                                     Chapter 7
                                   Enterprise User Security Manager (EUSM) Command Summary




Option                                        Description
[group_dn=<Distinguished name of              DN of the group.
group>]
ldap_host=<OID host>                          OID host.
ldap_port=<OID non ssl port> |                OID non ssl port or OID ssl port.
ldap_ssl_port=<OID ssl port>
keystore=<path to keystore>                   Path to the keystore.
keystore_alias=<keystore password             Keystore password taken from the Oracle
alias>                                        wallet.
ldap_user_dn=<DN of OID user>                 DN of OID user which is used for
                                              authenticating and executing a command in
                                              the OID.
ldap_alias=<OID user password alias> OID user password taken from the Oracle
                                              wallet.
wallet_location=<wallet location>             Path to Oracle wallet when using the wallet.

Usage Notes
Enterprise roles are access privileges assigned to enterprise users. Enterprise roles
are a set of Oracle role-based authorizations across one or more databases in an
enterprise domain. Enterprise roles are stored in the directory and contain one or more
global roles.
A global role is a role managed in a directory, but its privileges are contained within a
single database. A global role is created in a database using SQL*Plus. For example:

SQL> create role global_connect identified globally;
SQL> create role global_resource identified globally;
SQL> grant connect to global_connect;
SQL> grant resource to global_resource;


Examples
Examples include revoking an enterprise role in an enterprise domain in the realm
from a user with and without SSL port connectivity to OID.
Example 7-76 Revoking a Role from a User with SSL Port Conectivity to OID
and Using Passwords Stored in the Oracle Wallet

eusm revokeRole enterprise_role=ent_connect
domain_name=OracleDefaultDomain realm_dn=dc=yy,dc=company,dc=com
user_dn=cn=test_user,cn=Users,dc=yy,dc=company,dc=com
ldap_host=xxxxx.zz.company.com ldap_ssl_port=3131 keystore=/etc/myapp/
keyStore keystore_alias=keystore1 ldap_user_dn=cn=orcladmin
ldap_alias=ldabadmin1 wallet_location=/oracle/product/db_1/wallets


Example 7-77     Revoking a Role from a User with SSL Port Conectivity to OID

eusm revokeRole enterprise_role=ent_connect
domain_name=OracleDefaultDomain realm_dn=dc=yy,dc=company,dc=com
user_dn=cn=test_user,cn=Users,dc=yy,dc=company,dc=com




                                                                                        7-45
                                                                                              Chapter 7
                                             Enterprise User Security Manager (EUSM) Command Summary


            ldap_host=xxxxx.zz.company.com ldap_ssl_port=3131 keystore=/etc/myapp/
            keyStore ldap_user_dn=cn=orcladmin


            Example 7-78      Revoking a Role from a User with non-SSL Port Conectivity to
            OID

            eusm revokeRole enterprise_role=ent_connect
            domain_name=OracleDefaultDomain realm_dn=dc=yy,dc=company,dc=com
            user_dn=cn=test_user,cn=Users,dc=yy,dc=company,dc=com
            ldap_host=xxxxx.zz.company.com ldap_port=3060 ldap_user_dn=cn=orcladmin


7.3.25 listEnterpriseRoles
            Lists the enterprise roles.

            Syntax

             listEnterpriseRoles
                 domain_name=<domain name>
                 realm_dn=<DN of the realm>
                 ldap_host=<OID host>
                 ldap_port=<OID non ssl port> | ldap_ssl_port=<OID ssl port>
                 keystore=<path to keystore>
                 keystore_alias=<keystore password alias>
                 ldap_user_dn=<DN of OID user>
                 ldap_alias=<OID user password alias>
                 wallet_location=<wallet location>


            Options
            Each option must be prefixed with a space. Multiple options can be concatenated and
            prefixed with single space.


            Option                                     Description
            domain_name=<domain name>                  Name of the domain.
            realm_dn=<DN of the realm>                 DN of the realm.
            ldap_host=<OID host>                       OID host.
            ldap_port=<OID non ssl port> |             OID non ssl port or OID ssl port.
            ldap_ssl_port=<OID ssl port>
            keystore=<path to keystore>                Path to the keystore.
            keystore_alias=<keystore password          Keystore password taken from the Oracle
            alias>                                     wallet.
            ldap_user_dn=<DN of OID user>              DN of OID user which is used for
                                                       authenticating and executing a command in
                                                       the OID.
            ldap_alias=<OID user password alias> OID user password taken from the Oracle
                                                       wallet.
            wallet_location=<wallet location>          Path to Oracle wallet when using the wallet.




                                                                                                 7-46
                                                                                              Chapter 7
                                               Enterprise User Security Manager (EUSM) Command Summary




           Usage Notes
           Enterprise roles are access privileges assigned to enterprise users. Enterprise roles
           are a set of Oracle role-based authorizations across one or more databases in an
           enterprise domain. Enterprise roles are stored in the directory and contain one or more
           global roles.
           A global role is a role managed in a directory, but its privileges are contained within a
           single database. A global role is created in a database using SQL*Plus. For example:

           SQL> create role global_connect identified globally;
           SQL> create role global_resource identified globally;
           SQL> grant connect to global_connect;
           SQL> grant resource to global_resource;


           Examples
           Examples include listing enterprise roles in an enterprise domain in the realm with and
           without SSL port connectivity to OID.
           Example 7-79 List the Enterprisre Roles with SSL Port Conectivity to OID and
           Use Passwords Stored in the Oracle Wallet

           eusm listEnterpriseRoles domain_name=OracleDefaultDomain
           realm_dn=dc=yy,dc=company,dc=com ldap_host=xxxxx.zz.company.com
           ldap_ssl_port=3131 keystore=/etc/myapp/keyStore keystore_alias=keystore1
           ldap_user_dn=cn=orcladmin ldap_alias=ldabadmin1 wallet_location=/oracle/
           product/db_1/wallets


           Example 7-80      List the Enterprisre Roles with SSL Port Conectivity to OID

           eusm listEnterpriseRoles domain_name=OracleDefaultDomain
           realm_dn=dc=yy,dc=company,dc=com ldap_host=xxxxx.zz.company.com
           ldap_ssl_port=3131 keystore=/etc/myapp/keyStore ldap_user_dn=cn=orcladmin


           Example 7-81      List the Enterprisre Roles with non-SSL Port Conectivity to OID

           eusm listEnterpriseRoles domain_name=OracleDefaultDomain
           realm_dn=dc=yy,dc=company,dc=com ldap_host=xxxxx.zz.company.com
           ldap_port=3060 ldap_user_dn=cn=orcladmin


7.3.26 listEnterpriseRolesOfUser
           Lists the enterprise roles of a user.

           Syntax

           listEnterpriseRolesOfUser
                user_dn=<Distinguished name of user>
                realm_dn=<DN of the realm>
                ldap_host=<OID host>
                ldap_port=<OID non ssl port> | ldap_ssl_port=<OID ssl port>




                                                                                                7-47
                                                                                     Chapter 7
                                   Enterprise User Security Manager (EUSM) Command Summary


     keystore=<path to keystore>
     keystore_alias=<keystore password alias>
     ldap_user_dn=<DN of OID user>
     ldap_alias=<OID user password alias>
     wallet_location=<wallet location>


Options
Each option must be prefixed with a space. Multiple options can be concatenated and
prefixed with single space.


Option                                        Description
user_dn=<Distinguished name of user> DN of the user.
realm_dn=<DN of the realm>                    DN of the realm.
ldap_host=<OID host>                          OID host.
ldap_port=<OID non ssl port> |                OID non ssl port or OID ssl port.
ldap_ssl_port=<OID ssl port>
keystore=<path to keystore>                   Path to the keystore.
keystore_alias=<keystore password             Keystore password taken from the Oracle
alias>                                        wallet.
ldap_user_dn=<DN of OID user>                 DN of OID user which is used for
                                              authenticating and executing a command in
                                              the OID.
ldap_alias=<OID user password alias> OID user password taken from the Oracle
                                              wallet.
wallet_location=<wallet location>             Path to Oracle wallet when using the wallet.

Usage Notes
Enterprise roles are access privileges assigned to enterprise users. Enterprise roles
are a set of Oracle role-based authorizations across one or more databases in an
enterprise domain. Enterprise roles are stored in the directory and contain one or more
global roles.
A global role is a role managed in a directory, but its privileges are contained within a
single database. A global role is created in a database using SQL*Plus. For example:

SQL> create role global_connect identified globally;
SQL> create role global_resource identified globally;
SQL> grant connect to global_connect;
SQL> grant resource to global_resource;


Examples
Examples include listing the enterprise roles of a user in the realm with and without
SSL port connectivity to OID.
Example 7-82 List the Enterprise Roles of a User with SSL Port Conectivity to
OID and Use Passwords Stored in the Oracle Wallet

eusm listEnterpriseRolesOfUser
user_dn=cn=test_user,cn=Users,dc=yy,dc=company,dc=com




                                                                                        7-48
                                                                                               Chapter 7
                                                Enterprise User Security Manager (EUSM) Command Summary


            realm_dn=dc=yy,dc=company,dc=com ldap_host=xxxxx.zz.company.com
            ldap_ssl_port=3131 keystore=/etc/myapp/keyStore keystore_alias=keystore1
            ldap_user_dn=cn=orcladmin ldap_alias=ldabadmin1 wallet_location=/oracle/
            product/db_1/wallets


            Example 7-83     List the Enterprise Roles of a User with SSL Port Conectivity to
            OID

            eusm listEnterpriseRolesOfUser
            user_dn=cn=test_user,cn=Users,dc=yy,dc=company,dc=com
            realm_dn=dc=yy,dc=company,dc=com ldap_host=xxxxx.zz.company.com
            ldap_ssl_port=3131 keystore=/etc/myapp/keyStore ldap_user_dn=cn=orcladmin


            Example 7-84 List the Enterprise Roles of a User with non-SSL Port
            Conectivity to OID

            eusm listEnterpriseRolesOfUser
            user_dn=cn=test_user,cn=Users,dc=yy,dc=company,dc=com
            realm_dn=dc=yy,dc=company,dc=com ldap_host=xxxxx.zz.company.com
            ldap_port=3060 ldap_user_dn=cn=orcladmin


7.3.27 listEnterpriseRoleInfo
            Lists the enterprise role information.

            Syntax

            listEnterpriseRoleInfo
                 enterprise_role=<Enterprise role name>
                 domain_name=<domain name>
                 realm_dn=<DN of the realm>
                 ldap_host=<OID host>
                 ldap_port=<OID non ssl port> | ldap_ssl_port=<OID ssl port>
                 keystore=<path to keystore>
                 keystore_alias=<keystore password alias>
                 ldap_user_dn=<DN of OID user>
                 ldap_alias=<OID user password alias>
                 wallet_location=<wallet location>


            Options
            Each option must be prefixed with a space. Multiple options can be concatenated and
            prefixed with single space.


            Option                                        Description
            enterprise_role=<Enterprise role              Name of the enterprise role.
            name>
            domain_name=<domain name>                     Name of the domain.
            realm_dn=<DN of the realm>                    DN of the realm.
            ldap_host=<OID host>                          OID host.




                                                                                                 7-49
                                                                                     Chapter 7
                                   Enterprise User Security Manager (EUSM) Command Summary




Option                                        Description
ldap_port=<OID non ssl port> |                OID non ssl port or OID ssl port.
ldap_ssl_port=<OID ssl port>
keystore=<path to keystore>                   Path to the keystore.
keystore_alias=<keystore password             Keystore password taken from the Oracle
alias>                                        wallet.
ldap_user_dn=<DN of OID user>                 DN of OID user which is used for
                                              authenticating and executing a command in
                                              the OID.
ldap_alias=<OID user password alias> OID user password taken from the Oracle
                                              wallet.
wallet_location=<wallet location>             Path to Oracle wallet when using the wallet.

Usage Notes
Enterprise roles are access privileges assigned to enterprise users. Enterprise roles
are a set of Oracle role-based authorizations across one or more databases in an
enterprise domain. Enterprise roles are stored in the directory and contain one or more
global roles.
A global role is a role managed in a directory, but its privileges are contained within a
single database. A global role is created in a database using SQL*Plus. For example:

SQL> create role global_connect identified globally;
SQL> create role global_resource identified globally;
SQL> grant connect to global_connect;
SQL> grant resource to global_resource;


Examples
Examples include listing the enterprise role information in an enterprise domain in the
realm with and without SSL port connectivity to OID.
Example 7-85 List the Enterprise Role Information with SSL Port Conectivity to
OID and Use Passwords Stored in the Oracle Wallet

eusm listEnterpriseRoleInfo enterprise_role=ent_connect
domain_name=OracleDefaultDomain realm_dn=dc=yy,dc=company,dc=com
ldap_host=xxxxx.zz.company.com ldap_ssl_port=3131 keystore=/etc/myapp/
keyStore keystore_alias=keystore1 ldap_user_dn=cn=orcladmin
ldap_alias=ldabadmin1 wallet_location=/oracle/product/db_1/wallets


Example 7-86     List the Enterprise Role Information with SSL Port Conectivity to
OID

eusm listEnterpriseRoleInfo enterprise_role=ent_connect
domain_name=OracleDefaultDomain realm_dn=dc=yy,dc=company,dc=com
ldap_host=xxxxx.zz.company.com ldap_ssl_port=3131 keystore=/etc/myapp/
keyStore ldap_user_dn=cn=orcladmin




                                                                                        7-50
                                                                                                  Chapter 7
                                              Enterprise User Security Manager (EUSM) Command Summary


           Example 7-87 List the Enterprise Role Information with non-SSL Port
           Conectivity to OID

           eusm listEnterpriseRoleInfo enterprise_role=ent_connect
           domain_name=OracleDefaultDomain realm_dn=dc=yy,dc=company,dc=com
           ldap_host=xxxxx.zz.company.com ldap_port=3060 ldap_user_dn=cn=orcladmin


7.3.28 listGlobalRolesInDB
           Lists the global roles in the database.

           Syntax

           listGlobalRolesInDB
                dbuser=<Database user name to connect>
                db_alias=<Database username password alias>
                dbconnect_string=<Database connect string>
                wallet_location=<wallet location>


           Options
           Each option must be prefixed with a space. Multiple options can be concatenated and
           prefixed with single space.


           Option                                          Description
           dbuser=<Database user name to        The database user name to connect.
           connect>
           db_alias=<Database username password Password of the database user taken from the
           alias>                               Oracle wallet.
           dbconnect_string=<Database connect              Database connect string
           string>
           wallet_location=<wallet location>               Path to Oracle wallet when using the wallet.

           Usage Notes
           Enterprise roles are access privileges assigned to enterprise users. Enterprise roles
           are a set of Oracle role-based authorizations across one or more databases in an
           enterprise domain. Enterprise roles are stored in the directory and contain one or more
           global roles.
           A global role is a role managed in a directory, but its privileges are contained within a
           single database. A global role is created in a database using SQL*Plus. For example:

           SQL> create role global_connect identified globally;
           SQL> create role global_resource identified globally;
           SQL> grant connect to global_connect;
           SQL> grant resource to global_resource;


           Examples
           Listing the global roles for a database user.




                                                                                                     7-51
                                                                                             Chapter 7
                                           Enterprise User Security Manager (EUSM) Command Summary


          Example 7-88 Listing the Global Roles in the Database and Using Passwords
          Stored in the Oracle Wallet

          eusm listGlobalRolesInDB dbuser=system db_alias=dbadmin1
          dbconnect_string=zzzz10-yy.yy.company.com:1531:dbtest1 wallet_location=/
          oracle/product/db_1/wallets


          Example 7-89    Listing the Global Roles in the Database

          eusm listGlobalRolesInDB dbuser=system dbconnect_string=zzzz10-
          yy.yy.company.com:1531:dbtest1


7.3.29 listSharedSchemasInDB
          Lists the shared schemas in the database.

          Syntax

          listSharedSchemasInDB
               dbuser=<Database user name to connect>
               db_alias=<Database username password alias>
               dbconnect_string=<Database connect string>
               wallet_location=<wallet location>


          Options
          Each option must be prefixed with a space. Multiple options can be concatenated and
          prefixed with single space.


           Option                                     Description
           dbuser=<Database username to         The database user name to connect.
           connect>
           db_alias=<Database username password Password of the database user taken from the
           alias>                               Oracle wallet.
           dbconnect_string=<Database connect         Database connect string
           string>
           wallet_location=<wallet location>          Path to Oracle wallet when using the wallet.

          Usage Notes
          None.

          Examples
          Listing the shared schemas for a database user.
          Example 7-90 List the Shared Schemas in the Database and Use Passwords
          Stored in the Oracle Wallet

          eusm listSharedSchemasInDB dbuser=system db_alias=dbadmin1
          dbconnect_string=zzzz10-yy.yy.company.com:1531:dbtest1 wallet_location=/
          oracle/product/db_1/wallets




                                                                                                7-52
                                                                                             Chapter 7
                                            Enterprise User Security Manager (EUSM) Command Summary


          Example 7-91     List the Shared Schemas in the Database

          eusm listSharedSchemasInDB dbuser=system dbconnect_string=zzzz10-
          yy.yy.company.com:1531:dbtest1


7.3.30 createProxyPerm
          Creates a proxy permission object.

          Syntax

          createProxyPerm
               proxy_permission=<proxy permission name>
               domain_name=<domain name>
               realm_dn=<DN of the realm>
               ldap_host=<OID host>
               ldap_port=<OID non ssl port> | ldap_ssl_port=<OID ssl port>
               keystore=<path to keystore>
               keystore_alias=<keystore password alias>
               ldap_user_dn=<DN of OID user>
               ldap_alias=<OID user password alias>
               wallet_location=<wallet location>


          Options
          Each option must be prefixed with a space. Multiple options can be concatenated and
          prefixed with single space.


           Option                                     Description
           proxy_permission=<proxy permission         Name of the proxy permission.
           name>
           domain_name=<domain name>                  Name of the domain.
           realm_dn=<DN of the realm>                 DN of the realm.
           ldap_host=<OID host>                       OID host.
           ldap_port=<OID non ssl port> |             OID non ssl port or OID ssl port.
           ldap_ssl_port=<OID ssl port>
           keystore=<path to keystore>                Path to the keystore.
           keystore_alias=<keystore password          Keystore password taken from the Oracle
           alias>                                     wallet.
           ldap_user_dn=<DN of OID user>              DN of OID user which is used for
                                                      authenticating and executing a command in
                                                      the OID.
           ldap_alias=<OID user password alias> OID user password taken from the Oracle
                                                      wallet.
           wallet_location=<wallet location>          Path to Oracle wallet when using the wallet.

          Usage Notes
          Proxy Authentication is a process typically employed in an environment with a middle
          tier such as a firewall, wherein the end user authenticates to the middle tier, which
          then authenticates to the directory on the user's behalf—as its proxy. The middle tier



                                                                                                7-53
                                                                                            Chapter 7
                                             Enterprise User Security Manager (EUSM) Command Summary


          logs into the directory as a proxy user. A proxy user can switch identities and, once
          logged into the directory, switch to the end user's identity. It can perform operations on
          the end user's behalf, using the authorization appropriate to that particular end user.
          To create the proxy permission, you must first create the proxy user in the database.

          SQL> create user proxy_test identified by proxy_test;
          SQL> alter user proxy_test grant connect through enterprise users;


          Examples
          Examples include creating a proxy permission object in an enterprise domain in the
          realm with and without SSL port connectivity to OID.
          Example 7-92 Create the Proxy Permission Object PROXY01 with SSL Port
          Conectivity to OID and Use Passwords Stored in the Oracle Wallet

          eusm createProxyPerm proxy_permission=PROXY01
          domain_name=OracleDefaultDomain realm_dn=dc=yy,dc=company,dc=com
          ldap_host=xxxxx.zz.company.com ldap_port=3131 keystore=/etc/myapp/keyStore
          keystore_alias=keystore1 ldap_user_dn=cn=orcladmin ldap_alias=ldabadmin1
          wallet_location=/oracle/product/db_1/wallets


          Example 7-93 Create the Proxy Permission Object PROXY01 with SSL Port
          Conectivity to OID

          eusm createProxyPerm proxy_permission=PROXY01
          domain_name=OracleDefaultDomain realm_dn=dc=yy,dc=company,dc=com
          ldap_host=xxxxx.zz.company.com ldap_port=3131 keystore=/etc/myapp/keyStore
          -K ldap_user_dn=cn=orcladmin


          Example 7-94 Create the Proxy Permission Object PROXY01 with non-SSL Port
          Conectivity to OID

          eusm createProxyPerm proxy_permission=PROXY01
          domain_name=OracleDefaultDomain realm_dn=dc=yy,dc=company,dc=com
          ldap_host=xxxxx.zz.company.com ldap_port=3060 ldap_user_dn=cn=orcladmin


7.3.31 deleteProxyPerm
          Deletes a proxy permission object.

          Syntax

          deleteProxyPerm
               proxy_permission=<proxy permission name>
               domain_name=<domain name>
               realm_dn=<DN of the realm>
               ldap_host=<OID host>
               ldap_port=<OID non ssl port> | ldap_ssl_port=<OID ssl port>
               keystore=<path to keystore>
               keystore_alias=<keystore password alias>
               ldap_user_dn=<DN of OID user>



                                                                                               7-54
                                                                                    Chapter 7
                                   Enterprise User Security Manager (EUSM) Command Summary


     ldap_alias=<OID user password alias>
     wallet_location=<wallet location>


Options
Each option must be prefixed with a space. Multiple options can be concatenated and
prefixed with single space.


Option                                       Description
proxy_permission=<proxy permission           Name of the proxy permission.
name>
domain_name=<domain name>                    Name of the domain.
realm_dn=<DN of the realm>                   DN of the realm.
ldap_host=<OID host>                         OID host.
ldap_port=<OID non ssl port> |               OID non ssl port or OID ssl port.
ldap_ssl_port=<OID ssl port>
keystore=<path to keystore>                  Path to the keystore.
keystore_alias=<keystore password            Keystore password taken from the Oracle
alias>                                       wallet.
ldap_user_dn=<DN of OID user>                DN of OID user which is used for
                                             authenticating and executing a command in
                                             the OID.
ldap_alias=<OID user password alias> OID user password taken from the Oracle
                                             wallet.
wallet_location=<wallet location>            Path to Oracle wallet when using the wallet.

Usage Notes
Proxy Authentication is a process typically employed in an environment with a middle
tier such as a firewall, wherein the end user authenticates to the middle tier, which
then authenticates to the directory on the user's behalf—as its proxy. The middle tier
logs into the directory as a proxy user. A proxy user can switch identities and, once
logged into the directory, switch to the end user's identity. It can perform operations on
the end user's behalf, using the authorization appropriate to that particular end user.

Examples
Examples include deleting a proxy permission object in an enterprise domain in the
realm with and without SSL port connectivity to OID.
Example 7-95 Deleting the Proxy Permission PROXY01 with SSL Port
Conectivity to OID and Using Passwords Stored in the Oracle Wallet

eusm deleteProxyPerm proxy_permission=PROXY01
domain_name=OracleDefaultDomain realm_dn=dc=yy,dc=company,dc=com
ldap_host=xxxxx.zz.company.com ldap_port=3131 keystore=/etc/myapp/keyStore
keystore_alias=keystore1 ldap_user_dn=cn=orcladmin ldap_alias=ldabadmin1
wallet_location=/oracle/product/db_1/wallets




                                                                                       7-55
                                                                                          Chapter 7
                                           Enterprise User Security Manager (EUSM) Command Summary


          Example 7-96 Deleting the Proxy Permission PROXY01 with SSL Port
          Conectivity to OID

          eusm deleteProxyPerm proxy_permission=PROXY01
          domain_name=OracleDefaultDomain realm_dn=dc=yy,dc=company,dc=com
          ldap_host=xxxxx.zz.company.com ldap_port=3131 keystore=/etc/myapp/keyStore
          ldap_user_dn=cn=orcladmin


          Example 7-97 Deleting the Proxy Permission PROXY01 with non-SSL Port
          Conectivity to OID

          eusm deleteProxyPerm proxy_permission=PROXY01
          domain_name=OracleDefaultDomain realm_dn=dc=yy,dc=company,dc=com
          ldap_host=xxxxx.zz.company.com ldap_port=3060 ldap_user_dn=cn=orcladmin


7.3.32 addTargetUser
          Adds a target database user to the proxy permission object.

          Syntax

           addTargetUser
               proxy_permission=<proxy permission name>
               domain_name=<domain name>
               realm_dn=<DN of the realm>
               database_name=<Database name>
               target_user=<Target user in database>
               dbuser=<Database user name to connect>
               db_alias=<Database username password alias>
               dbconnect_string=<Database connect string>
               ldap_host=<OID host>
               ldap_port=<OID non ssl port> | ldap_ssl_port=<OID ssl port>
               keystore=<path to keystore>
               keystore_alias=<keystore password alias>
               ldap_user_dn=<DN of OID user>
               ldap_alias=<OID user password alias>
               wallet_location=<wallet location>


          Options
          Each option must be prefixed with a space. Multiple options can be concatenated and
          prefixed with single space.


           Option                                    Description
           proxy_permission=<proxy permission        Name of the proxy permission.
           name>
           domain_name=<domain name>                 Name of the domain.
           realm_dn=<DN of the realm>                DN of the realm.
           database_name=<Database name>             Database name.
           target_user=<Target user in               Target user in the database.
           database>



                                                                                            7-56
                                                                                    Chapter 7
                                   Enterprise User Security Manager (EUSM) Command Summary




Option                                       Description
dbuser=<Database user name to        The database user name to connect.
connect>
db_alias=<Database username password Password of the database user taken from the
alias>                               Oracle wallet.
dbconnect_string=<Database connect           Database connect string
string>
ldap_host=<OID host>                         OID host.
ldap_port=<OID non ssl port> |               OID non ssl port or OID ssl port.
ldap_ssl_port=<OID ssl port>
keystore=<path to keystore>                  Path to the keystore.
keystore_alias=<keystore password            Keystore password taken from the Oracle
alias>                                       wallet.
ldap_user_dn=<DN of OID user>                DN of OID user which is used for
                                             authenticating and executing a command in
                                             the OID.
ldap_alias=<OID user password alias> OID user password taken from the Oracle
                                             wallet.
wallet_location=<wallet location>            Path to Oracle wallet when using the wallet.

Usage Notes
Proxy Authentication is a process typically employed in an environment with a middle
tier such as a firewall, wherein the end user authenticates to the middle tier, which
then authenticates to the directory on the user's behalf—as its proxy. The middle tier
logs into the directory as a proxy user. A proxy user can switch identities and, once
logged into the directory, switch to the end user's identity. It can perform operations on
the end user's behalf, using the authorization appropriate to that particular end user.

Examples
Examples include adding a target database user to the proxy permission object in an
enterprise domain in the realm with and without SSL port connectivity to OID.
Example 7-98 Add the Target Database User to the Proxy Permission Object
with SSL Port Conectivity to OID and Using Passwords Stored in the Oracle
Wallet

eusm addTargetUser proxy_permission=PROXY01
domain_name=OracleDefaultDomain realm_dn=dc=yy,dc=company,dc=com
database_name=dbtest1 target_user=PROXY_TEST dbuser=system
db_alias=dbadmin1 dbconnect_string=zzzz10-yy.yy.company.com:1531:dbtest1
ldap_host=xxxxx.zz.company.com ldap_port=3131 keystore=/etc/myapp/keyStore
keystore_alias=keystore1 ldap_user_dn=cn=orcladmin ldap_alias=ldabadmin1
wallet_location=/oracle/product/db_1/wallets


Example 7-99 Add the Target Database User to the Proxy Permission Object
with SSL Port Conectivity to OID

eusm addTargetUser proxy_permission=PROXY01
domain_name=OracleDefaultDomain realm_dn=dc=yy,dc=company,dc=com




                                                                                       7-57
                                                                                          Chapter 7
                                           Enterprise User Security Manager (EUSM) Command Summary


          database_name=dbtest1 target_user=PROXY_TEST dbuser=system
          dbconnect_string=zzzz10-yy.yy.company.com:1531:dbtest1
          ldap_host=xxxxx.zz.company.com ldap_port=3131 keystore=/etc/myapp/keyStore
          ldap_user_dn=cn=orcladmin


          Example 7-100 Add the Target Database User to the Proxy Permission Object
          with non-SSL Port Conectivity to OID

          eusm addTargetUser proxy_permission=PROXY01
          domain_name=OracleDefaultDomain realm_dn=dc=yy,dc=company,dc=com
          database_name=dbtest1 target_user=PROXY_TEST dbuser=system
          dbconnect_string=zzzz10-yy.yy.company.com:1531:dbtest1
          ldap_host=xxxxx.zz.company.com ldap_port=3060 ldap_user_dn=cn=orcladmin


7.3.33 removeTargetUser
          Removes a target database user from the proxy permission object.

          Syntax

          removeTargetUser
               proxy_permission=<proxy permission name>
               domain_name=<domain name>
               realm_dn=<DN of the realm>
               database_name=<Database name>
               target_user=<Target user in database>
               dbuser=<Database user name to connect>
               db_alias=<Database username password alias>
               dbconnect_string=<Database connect string>
               ldap_host=<OID host>
               ldap_port=<OID non ssl port> | ldap_ssl_port=<OID ssl port>
               keystore=<path to keystore>
               keystore_alias=<keystore password alias>
               ldap_user_dn=<DN of OID user>
               ldap_alias=<OID user password alias>
               wallet_location=<wallet location>


          Options
          Each option must be prefixed with a space. Multiple options can be concatenated and
          prefixed with single space.


           Option                                    Description
           proxy_permission=<proxy permission        Name of the proxy permission.
           name>
           domain_name=<domain name>                 Name of the domain.
           realm_dn=<DN of the realm>                DN of the realm.
           database_name=<Database name>             Database name.
           target_user=<Target user in               Target user in the database.
           database>




                                                                                            7-58
                                                                                    Chapter 7
                                   Enterprise User Security Manager (EUSM) Command Summary




Option                                       Description
dbuser=<Database username to         The database user name to connect.
connect>
db_alias=<Database username password Password of the database user taken from the
alias>                               Oracle wallet.
dbconnect_string=<Database connect           Database connect string
string>
ldap_host=<OID host>                         OID host.
ldap_port=<OID non ssl port> |               OID non ssl port or OID ssl port.
ldap_ssl_port=<OID ssl port>
keystore=<path to keystore>                  Path to the keystore.
keystore_alias=<keystore password            Keystore password taken from the Oracle
alias>                                       wallet.
ldap_user_dn=<DN of OID user>                DN of OID user which is used for
                                             authenticating and executing a command in
                                             the OID.
ldap_alias=<OID user password alias> OID user password taken from the Oracle
                                             wallet.
wallet_location=<wallet location>            Path to Oracle wallet when using the wallet.

Usage Notes
Proxy Authentication is a process typically employed in an environment with a middle
tier such as a firewall, wherein the end user authenticates to the middle tier, which
then authenticates to the directory on the user's behalf—as its proxy. The middle tier
logs into the directory as a proxy user. A proxy user can switch identities and, once
logged into the directory, switch to the end user's identity. It can perform operations on
the end user's behalf, using the authorization appropriate to that particular end user.

Examples
Examples include removing a target database user from the proxy permission object in
an enterprise domain in the realm with and without SSL port connectivity to OID.
Example 7-101 Removing the Target User from the Proxy Permission Object
with SSL Port Conectivity to OID and Using Passwords Stored in the Oracle
Wallet

eusm removeTargetUser proxy_permission=PROXY01
domain_name=OracleDefaultDomain realm_dn=dc=yy,dc=company,dc=com
database_name=dbtest1 target_user=PROXY_TEST dbuser=system
db_alias=dbadmin1 dbconnect_string=zzzz10-yy.yy.company.com:1531:dbtest1
ldap_host=xxxxx.zz.company.com ldap_port=3131 keystore=/etc/myapp/keyStore
keystore_alias=keystore1 ldap_user_dn=cn=orcladmin ldap_alias=ldabadmin1
wallet_location=/oracle/product/db_1/wallets


Example 7-102 Removing the Target User from the Proxy Permission Object
with SSL Port Conectivity to OID

eusm removeTargetUser proxy_permission=PROXY01
domain_name=OracleDefaultDomain realm_dn=dc=yy,dc=company,dc=com




                                                                                       7-59
                                                                                          Chapter 7
                                           Enterprise User Security Manager (EUSM) Command Summary


          database_name=dbtest1 target_user=PROXY_TEST dbuser=system
          dbconnect_string=zzzz10-yy.yy.company.com:1531:dbtest1
          ldap_host=xxxxx.zz.company.com ldap_port=3131 keystore=/etc/myapp/keyStore
          ldap_user_dn=cn=orcladmin


          Example 7-103 Removing the Target User from the Proxy Permission Object
          with non-SSL Port Conectivity to OID

          eusm removeTargetUser proxy_permission=PROXY01
          domain_name=OracleDefaultDomain realm_dn=dc=yy,dc=company,dc=com
          database_name=dbtest1 target_user=PROXY_TEST dbuser=system
          dbconnect_string=zzzz10-yy.yy.company.com:1531:dbtest1
          ldap_host=xxxxx.zz.company.com ldap_port=3060 ldap_user_dn=cn=orcladmin


7.3.34 grantProxyPerm
          Maps an enterprise user to the database user through the proxy permission object.

          Syntax

          grantProxyPerm
               proxy_permission=<proxy permission name>
               domain_name=<domain name>
               realm_dn=<DN of the realm>
               [user_dn=<Distinguished name of user>]
               [group_dn=<Distinguished name of group>]
               ldap_host=<OID host>
               ldap_port=<OID non ssl port> | ldap_ssl_port=<OID ssl port>
               keystore=<path to keystore>
               keystore_alias=<keystore password alias>
               ldap_user_dn=<DN of OID user>
               ldap_alias=<OID user password alias>
               wallet_location=<wallet location>


          Options
          Each option must be prefixed with a space. Multiple options can be concatenated and
          prefixed with single space.


           Option                                    Description
           proxy_permission=<proxy permission        Name of the proxy permission.
           name>
           domain_name=<domain name>                 Name of the domain.
           realm_dn=<DN of the realm>                DN of the realm.
           [user_dn=<Distinguished name of           DN of the user.
           user>]
           [group_dn=<Distinguished name of          DN of the group.
           group>]
           ldap_host=<OID host>                      OID host.
           ldap_port=<OID non ssl port> |            OID non ssl port or OID ssl port.
           ldap_ssl_port=<OID ssl port>



                                                                                            7-60
                                                                                    Chapter 7
                                   Enterprise User Security Manager (EUSM) Command Summary




Option                                       Description
keystore=<path to keystore>                  Path to the keystore.
keystore_alias=<keystore password            Keystore password taken from the Oracle
alias>                                       wallet.
ldap_user_dn=<DN of OID user>                DN of OID user which is used for
                                             authenticating and executing a command in
                                             the OID.
ldap_alias=<OID user password alias> OID user password taken from the Oracle
                                             wallet.
wallet_location=<wallet location>            Path to Oracle wallet when using the wallet.

Usage Notes
Proxy Authentication is a process typically employed in an environment with a middle
tier such as a firewall, wherein the end user authenticates to the middle tier, which
then authenticates to the directory on the user's behalf—as its proxy. The middle tier
logs into the directory as a proxy user. A proxy user can switch identities and, once
logged into the directory, switch to the end user's identity. It can perform operations on
the end user's behalf, using the authorization appropriate to that particular end user.

Examples
Examples include mapping the enterprise user to the database user through the proxy
permission object in the realm with and without SSL port connectivity to OID.
Example 7-104 Mapping the Enterprise User to the Database User Through the
PROXY01 Permission Object with SSL Port Conectivity to OID and Using
Passwords Stored in the Oracle Wallet

eusm grantProxyPerm proxy_permission=PROXY01
domain_name=OracleDefaultDomain realm_dn=dc=yy,dc=company,dc=com
user_dn=cn=test_user,cn=Users,dc=yy,dc=company,dc=com
ldap_host=xxxxx.zz.company.com ldap_port=3131 keystore=/etc/myapp/keyStore
keystore_alias=keystore1 ldap_user_dn=cn=orcladmin ldap_alias=ldabadmin1
wallet_location=/oracle/product/db_1/wallets


Example 7-105 Mapping the Enterprise User to the Database User Through the
PROXY01 Permission Object with SSL Port Conectivity to OID

eusm grantProxyPerm proxy_permission=PROXY01
domain_name=OracleDefaultDomain realm_dn=dc=yy,dc=company,dc=com
user_dn=cn=test_user,cn=Users,dc=yy,dc=company,dc=com
ldap_host=xxxxx.zz.company.com ldap_port=3131 keystore=/etc/myapp/keyStore
ldap_user_dn=cn=orcladmin


Example 7-106 Mapping the Enterprise User to the Database User Through the
PROXY01 Permission Object with non-SSL Port Conectivity to OID

eusm grantProxyPerm proxy_permission=PROXY01
domain_name=OracleDefaultDomain realm_dn=dc=yy,dc=company,dc=com




                                                                                       7-61
                                                                                            Chapter 7
                                           Enterprise User Security Manager (EUSM) Command Summary


          user_dn=cn=test_user,cn=Users,dc=yy,dc=company,dc=com
          ldap_host=xxxxx.zz.company.com ldap_port=3060 ldap_user_dn=cn=orcladmin


7.3.35 revokeProxyPerm
          Revokes a proxy permission object.

          Syntax

          revokeProxyPerm
               proxy_permission=<proxy permission name>
               domain_name=<domain name>
               realm_dn=<DN of the realm>
               [user_dn=<Distinguished name of user>]
               [group_dn=<Distinguished name of group>]
               ldap_host=<OID host>
               ldap_port=<OID non ssl port> | ldap_ssl_port=<OID ssl port>
               keystore=<path to keystore>
               keystore_alias=<keystore password alias>
               ldap_user_dn=<DN of OID user>
               ldap_alias=<OID user password alias>
               wallet_location=<wallet location>


          Options
          Each option must be prefixed with a space. Multiple options can be concatenated and
          prefixed with single space.


          Option                                     Description
          proxy_permission=<proxy permission         Name of the proxy permission.
          name>
          domain_name=<domain name>                  Name of the domain.
          realm_dn=<DN of the realm>                 DN of the realm.
          [user_dn=<Distinguished name of            DN of the user.
          user>]
          [group_dn=<Distinguished name of           DN of the group.
          group>]
          ldap_host=<OID host>                       OID host.
          ldap_port=<OID non ssl port> |             OID non ssl port or OID ssl port.
          ldap_ssl_port=<OID ssl port>
          keystore=<path to keystore>                Path to the keystore.
          keystore_alias=<keystore password          Keystore password taken from the Oracle
          alias>                                     wallet.
          ldap_user_dn=<DN of OID user>              DN of OID user which is used for
                                                     authenticating and executing a command in
                                                     the OID.
          ldap_alias=<OID user password alias> OID user password taken from the Oracle
                                                     wallet.
          wallet_location=<wallet location>          Path to Oracle wallet when using the wallet.




                                                                                               7-62
                                                                                             Chapter 7
                                              Enterprise User Security Manager (EUSM) Command Summary




           Usage Notes
           Proxy Authentication is a process typically employed in an environment with a middle
           tier such as a firewall, wherein the end user authenticates to the middle tier, which
           then authenticates to the directory on the user's behalf—as its proxy. The middle tier
           logs into the directory as a proxy user. A proxy user can switch identities and, once
           logged into the directory, switch to the end user's identity. It can perform operations on
           the end user's behalf, using the authorization appropriate to that particular end user.

           Examples
           Examples include revoking proxy permission object PROXY01 from the database user
           in the realm with and without SSL port connectivity to OID.
           Example 7-107 Revoking Proxy Permission Object PROXY01 From the User
           with SSL Port Conectivity to OID and Using Passwords Stored in the Oracle
           Wallet

           eusm revokeProxyPerm proxy_permission=PROXY01
           domain_name=OracleDefaultDomain realm_dn=dc=yy,dc=company,dc=com
           user_dn=cn=test_user,cn=Users,dc=yy,dc=company,dc=com
           ldap_host=xxxxx.zz.company.com ldap_port=3131 keystore=/etc/myapp/keyStore
           keystore_alias=keystore1 ldap_user_dn=cn=orcladmin ldap_alias=ldabadmin1
           wallet_location=/oracle/product/db_1/wallets


           Example 7-108 Revoking Proxy Permission Object PROXY01 From the User
           with SSL Port Conectivity to OID

           eusm revokeProxyPerm proxy_permission=PROXY01
           domain_name=OracleDefaultDomain realm_dn=dc=yy,dc=company,dc=com
           user_dn=cn=test_user,cn=Users,dc=yy,dc=company,dc=com
           ldap_host=xxxxx.zz.company.com ldap_port=3131 keystore=/etc/myapp/keyStore
           ldap_user_dn=cn=orcladmin


           Example 7-109 Revoking Proxy Permission Object PROXY01 From the User
           with non-SSL Port Conectivity to OID

           eusm revokeProxyPerm proxy_permission=PROXY01
           domain_name=OracleDefaultDomain realm_dn=dc=yy,dc=company,dc=com
           user_dn=cn=test_user,cn=Users,dc=yy,dc=company,dc=com
           ldap_host=xxxxx.zz.company.com ldap_port=3060 ldap_user_dn=cn=orcladmin


7.3.36 listProxyPermissions
           Lists proxy permissions. Input is the domain name.

           Syntax

            listProxyPermissions
                domain_name=<domain name>
                realm_dn=<DN of the realm>
                ldap_host=<OID host>




                                                                                                7-63
                                                                                    Chapter 7
                                   Enterprise User Security Manager (EUSM) Command Summary


     ldap_port=<OID non ssl port> | ldap_ssl_port=<OID ssl port>
     keystore=<path to keystore>
     keystore_alias=<keystore password alias>
     ldap_user_dn=<DN of OID user>
     ldap_alias=<OID user password alias>
     wallet_location=<wallet location>


Options
Each option must be prefixed with a space. Multiple options can be concatenated and
prefixed with single space.


Option                                       Description
domain_name=<domain name>                    Name of the domain.
realm_dn=<DN of the realm>                   DN of the realm.
ldap_host=<OID host>                         OID host.
ldap_port=<OID non ssl port> |               OID non ssl port or OID ssl port.
ldap_ssl_port=<OID ssl port>
keystore=<path to keystore>                  Path to the keystore.
keystore_alias=<keystore password            Keystore password taken from the Oracle
alias>                                       wallet.
ldap_user_dn=<DN of OID user>                DN of OID user which is used for
                                             authenticating and executing a command in
                                             the OID.
ldap_alias=<OID user password alias> OID user password taken from the Oracle
                                             wallet.
wallet_location=<wallet location>            Path to Oracle wallet when using the wallet.

Usage Notes
Proxy Authentication is a process typically employed in an environment with a middle
tier such as a firewall, wherein the end user authenticates to the middle tier, which
then authenticates to the directory on the user's behalf—as its proxy. The middle tier
logs into the directory as a proxy user. A proxy user can switch identities and, once
logged into the directory, switch to the end user's identity. It can perform operations on
the end user's behalf, using the authorization appropriate to that particular end user.

Examples
Examples include listing the proxy permissions for the enterprise domain in the realm
with and without SSL port connectivity to OID.
Example 7-110 Listing the Proxy Permissions for the Domain with SSL Port
Conectivity to OID and Using Passwords Stored in the Oracle Wallet

eusm listProxyPermissions domain_name=OracleDefaultDomain
realm_dn=dc=yy,dc=company,dc=com ldap_host=xxxxx.zz.company.com
ldap_port=3131 keystore=/etc/myapp/keyStore keystore_alias=keystore1
ldap_user_dn=cn=orcladmin ldap_alias=ldabadmin1 wallet_location=/oracle/
product/db_1/wallets




                                                                                       7-64
                                                                                             Chapter 7
                                             Enterprise User Security Manager (EUSM) Command Summary


           Example 7-111 Listing the Proxy Permissions for the Domain with SSL Port
           Conectivity to OID

           eusm listProxyPermissions domain_name=OracleDefaultDomain
           realm_dn=dc=yy,dc=company,dc=com ldap_host=xxxxx.zz.company.com
           ldap_port=3131 keystore=/etc/myapp/keyStore ldap_user_dn=cn=orcladmin


           Example 7-112 Listing the Proxy Permissions for the Domain with non-SSL
           Port Conectivity to OID

           eusm listProxyPermissions domain_name=OracleDefaultDomain
           realm_dn=dc=yy,dc=company,dc=com ldap_host=xxxxx.zz.company.com
           ldap_port=3060 ldap_user_dn=cn=orcladmin


7.3.37 listProxyPermissionsOfUser
           Lists the proxy permissions for the user. Input is the user distinguished name.

           Syntax

           listProxyPermissionsOfUser
                user_dn=<Distinguished name of user>
                realm_dn=<DN of the realm>
                ldap_host=<OID host>
                ldap_port=<OID non ssl port> | ldap_ssl_port=<OID ssl port>
                keystore=<path to keystore>
                keystore_alias=<keystore password alias>
                ldap_user_dn=<DN of OID user>
                ldap_alias=<OID user password alias>
                wallet_location=<wallet location>


           Options
           Each option must be prefixed with a space. Multiple options can be concatenated and
           prefixed with single space.


           Option                                      Description
           user_dn=<Distinguished name of user> DN of the user.
           realm_dn=<DN of the realm>                  DN of the realm.
           ldap_host=<OID host>                        OID host.
           ldap_port=<OID non ssl port> |              OID non ssl port or OID ssl port.
           ldap_ssl_port=<OID ssl port>
           keystore=<path to keystore>                 Path to the keystore.
           keystore_alias=<keystore password           Keystore password taken from the Oracle
           alias>                                      wallet.
           ldap_user_dn=<DN of OID user>               DN of OID user which is used for
                                                       authenticating and executing a command in
                                                       the OID.
           ldap_alias=<OID user password alias> OID user password taken from the Oracle
                                                       wallet.




                                                                                                 7-65
                                                                                               Chapter 7
                                              Enterprise User Security Manager (EUSM) Command Summary




            Option                                      Description
            wallet_location=<wallet location>           Path to Oracle wallet when using the wallet.

           Usage Notes
           Proxy Authentication is a process typically employed in an environment with a middle
           tier such as a firewall, wherein the end user authenticates to the middle tier, which
           then authenticates to the directory on the user's behalf—as its proxy. The middle tier
           logs into the directory as a proxy user. A proxy user can switch identities and, once
           logged into the directory, switch to the end user's identity. It can perform operations on
           the end user's behalf, using the authorization appropriate to that particular end user.

           Examples
           Examples include listing the proxy permissions for the user in the realm with and
           without SSL port connectivity to OID.
           Example 7-113 List the Proxy Permission for the User with SSL Port
           Conectivity to OID and Use Passwords Stored in the Oracle Wallet

           eusm listProxyPermissionsOfUser
           user_dn=cn=test_user,cn=Users,dc=yy,dc=company,dc=com
           realm_dn=dc=yy,dc=company,dc=com ldap_host=xxxxx.zz.company.com
           ldap_port=3131 keystore=/etc/myapp/keyStore keystore_alias=keystore1
           ldap_user_dn=cn=orcladmin ldap_alias=ldabadmin1 wallet_location=/oracle/
           product/db_1/wallets


           Example 7-114 List the Proxy Permission for the User with SSL Port
           Conectivity to OID

           eusm listProxyPermissionsOfUser
           user_dn=cn=test_user,cn=Users,dc=yy,dc=company,dc=com
           realm_dn=dc=yy,dc=company,dc=com ldap_host=xxxxx.zz.company.com
           ldap_port=3131 keystore=/etc/myapp/keyStore ldap_user_dn=cn=orcladmin


           Example 7-115 List the Proxy Permission for the User with non-SSL Port
           Conectivity to OID

           eusm listProxyPermissionsOfUser
           user_dn=cn=test_user,cn=Users,dc=yy,dc=company,dc=com
           realm_dn=dc=yy,dc=company,dc=com ldap_host=xxxxx.zz.company.com
           ldap_port=3060 ldap_user_dn=cn=orcladmin


7.3.38 listProxyPermissionInfo
           Lists the proxy permission information.

           Syntax

           listProxyPermissionInfo
                proxy_permission=<proxy permission name>




                                                                                                  7-66
                                                                                    Chapter 7
                                   Enterprise User Security Manager (EUSM) Command Summary


     domain_name=<domain name>
     realm_dn=<DN of the realm>
     ldap_host=<OID host>
     ldap_port=<OID non ssl port> | ldap_ssl_port=<OID ssl port>
     keystore=<path to keystore>
     keystore_alias=<keystore password alias>
     ldap_user_dn=<DN of OID user>
     ldap_alias=<OID user password alias>
     wallet_location=<wallet location>


Options
Each option must be prefixed with a space. Multiple options can be concatenated and
prefixed with single space.


Option                                       Description
proxy_permission=<proxy permission           Name of the proxy permission.
name>
domain_name=<domain name>                    Name of the domain.
realm_dn=<DN of the realm>                   DN of the realm.
ldap_host=<OID host>                         OID host.
ldap_port=<OID non ssl port> |               OID non ssl port or OID ssl port.
ldap_ssl_port=<OID ssl port>
keystore=<path to keystore>                  Path to the keystore.
keystore_alias=<keystore password            Keystore password taken from the Oracle
alias>                                       wallet.
ldap_user_dn=<DN of OID user>                DN of OID user which is used for
                                             authenticating and executing a command in
                                             the OID.
ldap_alias=<OID user password alias> OID user password taken from the Oracle
                                             wallet.
wallet_location=<wallet location>            Path to Oracle wallet when using the wallet.

Usage Notes
Proxy Authentication is a process typically employed in an environment with a middle
tier such as a firewall, wherein the end user authenticates to the middle tier, which
then authenticates to the directory on the user's behalf—as its proxy. The middle tier
logs into the directory as a proxy user. A proxy user can switch identities and, once
logged into the directory, switch to the end user's identity. It can perform operations on
the end user's behalf, using the authorization appropriate to that particular end user.

Examples
Examples include listing the proxy permission information for the enterprise domain in
the realm with and without SSL port connectivity to OID.
Example 7-116 List Proxy Permission Information with SSL Port Conectivity to
OID and Using Passwords Stored in the Oracle Wallet

eusm listProxyPermissionInfo proxy_permission=PROXY01
domain_name=OracleDefaultDomain realm_dn=dc=yy,dc=company,dc=com




                                                                                       7-67
                                                                                               Chapter 7
                                              Enterprise User Security Manager (EUSM) Command Summary


           ldap_host=xxxxx.zz.company.com ldap_port=3131 keystore=/etc/myapp/keyStore
           keystore_alias=keystore1 ldap_user_dn=cn=orcladmin ldap_alias=ldabadmin1
           wallet_location=/oracle/product/db_1/wallets


           Example 7-117     List Proxy Permission Information with SSL Port Conectivity to
           OID

           eusm listProxyPermissionInfo proxy_permission=PROXY01
           domain_name=OracleDefaultDomain realm_dn=dc=yy,dc=company,dc=com
           ldap_host=xxxxx.zz.company.com ldap_port=3131 keystore=/etc/myapp/keyStore
           ldap_user_dn=cn=orcladmin


           Example 7-118 List Proxy Permission Information with non-SSL Port
           Conectivity to OID

           eusm listProxyPermissionInfo proxy_permission=PROXY01
           domain_name=OracleDefaultDomain realm_dn=dc=yy,dc=company,dc=com
           ldap_host=xxxxx.zz.company.com ldap_port=3060 ldap_user_dn=cn=orcladmin


7.3.39 listTargetUsersInDB
           Lists the target users in the database.

           Syntax

           listTargetUsersInDB
                dbuser=<Database user name to connect>
                db_alias=<Database username password alias>
                dbconnect_string=<Database connect string>
                wallet_location=<wallet location>


           Options
           Each option must be prefixed with a space. Multiple options can be concatenated and
           prefixed with single space.


           Option                                       Description
           dbuser=<Database user name to        The database user name to connect.
           connect>
           db_alias=<Database username password Password of the database user taken from the
           alias>                               Oracle wallet.
           dbconnect_string=<Database connect           Database connect string
           string>
           wallet_location=<wallet location>            Path to Oracle wallet when using the wallet.

           Usage Notes
           None.




                                                                                                  7-68
                                                                                            Chapter 7
                                             Enterprise User Security Manager (EUSM) Command Summary




          Examples
          Listing the target users in the database.
          Example 7-119 Listing the Target Users in the Database and Using Passwords
          Stored in the Oracle Wallet

          eusm listTargetUsersInDB dbuser=system db_alias=dbadmin1
          dbconnect_string=zzzz10-yy.yy.company.com:1531:dbtest1 wallet_location=/
          oracle/product/db_1/wallets


          Example 7-120     Listing the Target Users in the Database

          eusm listTargetUsersInDB dbuser=system dbconnect_string=zzzz10-
          yy.yy.company.com:1531:dbtest1


7.3.40 setDBOIDAuth
          Sets the database-OID authentication method.

          Syntax

          setDBOIDAuth
               realm_dn=<DN of the realm>
               dboid_auth=<Default DB OID authentication>
               ldap_host=<OID host>
               ldap_port=<OID non ssl port> | ldap_ssl_port=<OID ssl port>
               keystore=<path to keystore>
               keystore_alias=<keystore password alias>
               ldap_user_dn=<DN of OID user>
               ldap_alias=<OID user password alias>
               wallet_location=<wallet location>


          Options
          Each option must be prefixed with a space. Multiple options can be concatenated and
          prefixed with single space.


          Option                                       Description
          realm_dn=<DN of the realm>                   DN of the realm.
          dboid_auth=<Default DB OID                   Default DB OID authentication.
          authentication>
          ldap_host=<OID host>                         OID host.
          ldap_port=<OID non ssl port> |               OID non ssl port or OID ssl port.
          ldap_ssl_port=<OID ssl port>
          keystore=<path to keystore>                  Path to the keystore.
          keystore_alias=<keystore password            Keystore password taken from the Oracle
          alias>                                       wallet.




                                                                                                 7-69
                                                                                             Chapter 7
                                            Enterprise User Security Manager (EUSM) Command Summary




           Option                                     Description
           ldap_user_dn=<DN of OID user>              DN of OID user which is used for
                                                      authenticating and executing a command in
                                                      the OID.
           ldap_alias=<OID user password alias> OID user password taken from the Oracle
                                                      wallet.
           wallet_location=<wallet location>          Path to Oracle wallet when using the wallet.

           Usage Notes
           The OID authentication method can be either SSL or PASSWORD.

           Examples
           Examples include setting the database-OID authentication method in the realm with
           and without SSL port connectivity to OID.
           Example 7-121 Setting the Database-OID Authentication Method with SSL Port
           Conectivity to OID and Using Passwords Stored in the Oracle Wallet

           eusm setDBOIDAuth realm_dn=dc=yy,dc=company,dc=com dboid_auth=SSL
           ldap_host=xxxxx.zz.company.com ldap_port=3131 keystore=/etc/myapp/keyStore
           keystore_alias=keystore1 ldap_user_dn=cn=orcladmin ldap_alias=ldabadmin1
           wallet_location=/oracle/product/db_1/wallets


           Example 7-122 Setting the Database-OID Authentication Method with SSL Port
           Conectivity to OID

           eusm setDBOIDAuth realm_dn=dc=yy,dc=company,dc=com dboid_auth=SSL
           ldap_host=xxxxx.zz.company.com ldap_port=3131 keystore=/etc/myapp/keyStore
           ldap_user_dn=cn=orcladmin


           Example 7-123 Setting the Database-OID Authentication Method with non-SSL
           Port Conectivity to OID

           eusm setDBOIDAuth realm_dn=dc=yy,dc=company,dc=com dboid_auth=SSL
           ldap_host=xxxxx.zz.company.com ldap_port=3060 ldap_user_dn=cn=orcladmin


7.3.41 listDBOIDAuth
           Lists the database-OID authentication method.

           Syntax

           listDBOIDAuth
                realm_dn=<DN of the realm>
                ldap_host=<OID host>
                ldap_port=<OID non ssl port> | ldap_ssl_port=<OID ssl port>
                keystore=<path to keystore>
                keystore_alias=<keystore password alias>
                ldap_user_dn=<DN of OID user>



                                                                                                7-70
                                                                                  Chapter 7
                                 Enterprise User Security Manager (EUSM) Command Summary


     ldap_alias=<OID user password alias>
     wallet_location=<wallet location>


Options
Each option must be prefixed with a space. Multiple options can be concatenated and
prefixed with single space.


Option                                     Description
realm_dn=<DN of the realm>                 DN of the realm.
ldap_host=<OID host>                       OID host.
ldap_port=<OID non ssl port> |             OID non ssl port or OID ssl port.
ldap_ssl_port=<OID ssl port>
keystore=<path to keystore>                Path to the keystore.
keystore_alias=<keystore password          Keystore password taken from the Oracle
alias>                                     wallet.
ldap_user_dn=<DN of OID user>              DN of OID user which is used for
                                           authenticating and executing a command in
                                           the OID.
ldap_alias=<OID user password alias> OID user password taken from the Oracle
                                           wallet.
wallet_location=<wallet location>          Path to Oracle wallet when using the wallet.

Usage Notes
The OID authentication method can be either SSL or PASSWORD.

Examples
Examples include listing the database-OID authentication method in the realm with
and without SSL port connectivity to OID.
Example 7-124 Listing the Database-OID Authentication Method with SSL Port
Conectivity to OID and Using Passwords Stored in the Oracle Wallet

eusm listDBOIDAuth realm_dn=dc=yy,dc=company,dc=com
ldap_host=xxxxx.zz.company.com ldap_port=3131 keystore=/etc/myapp/keyStore
keystore_alias=keystore1 ldap_user_dn=cn=orcladmin ldap_alias=ldabadmin1
wallet_location=/oracle/product/db_1/wallets


Example 7-125 Listing the Database-OID Authentication Method with SSL Port
Conectivity to OID

eusm listDBOIDAuth realm_dn=dc=yy,dc=company,dc=com
ldap_host=xxxxx.zz.company.com ldap_port=3131 keystore=/etc/myapp/keyStore
ldap_user_dn=cn=orcladmin




                                                                                     7-71
                                                                                            Chapter 7
                                           Enterprise User Security Manager (EUSM) Command Summary


          Example 7-126 Listing the Database-OID Authentication Method with non-SSL
          Port Conectivity to OID

          eusm listDBOIDAuth realm_dn=dc=yy,dc=company,dc=com
          ldap_host=xxxxx.zz.company.com ldap_port=3060 ldap_user_dn=cn=orcladmin


7.3.42 addToPwdAccessibleDomains
          Adds a domain to the password accessible domains group in the realm.

          Syntax

          addToPwdAccessibleDomains
               realm_dn=<DN of the realm>
               domain_name=<name of enterprise domain>
               ldap_host=<OID host>
               ldap_port=<OID non ssl port> | ldap_ssl_port=<OID ssl port>
               keystore=<path to keystore>
               keystore_alias=<keystore password alias>
               ldap_user_dn=<DN of OID user>
               ldap_alias=<OID user password alias>
               wallet_location=<wallet location>


          Options
          Each option must be prefixed with a space. Multiple options can be concatenated and
          prefixed with single space.


          Option                                     Description
          realm_dn=<DN of the realm>                 DN of the realm.
          domain_name=<domain name>                  Name of the domain.
          ldap_host=<OID host>                       OID host.
          ldap_port=<OID non ssl port> |             OID non ssl port or OID ssl port.
          ldap_ssl_port=<OID ssl port>
          keystore=<path to keystore>                Path to the keystore.
          keystore_alias=<keystore password          Keystore password taken from the Oracle
          alias>                                     wallet.
          ldap_user_dn=<DN of OID user>              DN of OID user which is used for
                                                     authenticating and executing a command in
                                                     the OID.
          ldap_alias=<OID user password alias> OID user password taken from the Oracle
                                                     wallet.
          wallet_location=<wallet location>          Path to Oracle wallet when using the wallet.

          Usage Notes
          None.




                                                                                               7-72
                                                                                          Chapter 7
                                           Enterprise User Security Manager (EUSM) Command Summary




          Examples
          Examples include adding to password accessible domains in the realm with and
          without SSL port connectivity to OID.
          Example 7-127 Adding to Password Accessible Domains with SSL Port
          Conectivity to OID and Using Passwords Stored in the Oracle Wallet

          eusm addToPwdAccessibleDomains domain_name=test_domain
          realm_dn=dc=yy,dc=company,dc=com ldap_host=xxxxx.zz.company.com
          ldap_port=3131 keystore=/etc/myapp/keyStore keystore_alias=keystore1
          ldap_user_dn=cn=orcladmin ldap_alias=ldabadmin1 wallet_location=/oracle/
          product/db_1/wallets


          Example 7-128 Adding to Password Accessible Domains with SSL Port
          Conectivity to OID

          eusm addToPwdAccessibleDomains domain_name=test_domain
          realm_dn=dc=yy,dc=company,dc=com ldap_host=xxxxx.zz.company.com
          ldap_port=3131 keystore=/etc/myapp/keyStore ldap_user_dn=cn=orcladmin


          Example 7-129 Adding to Password Accessible Domains with non-SSL Port
          Conectivity to OID

          eusm addToPwdAccessibleDomains domain_name=test_domain
          realm_dn=dc=yy,dc=company,dc=com ldap_host=xxxxx.zz.company.com
          ldap_port=3060 ldap_user_dn=cn=orcladmin


7.3.43 removeFromPwdAccessibleDomains
          Removes a domain from the password accessible domains group in the realm.

          Syntax

          removeFromPwdAccessibleDomains
               realm_dn=<DN of the realm>
               domain_name=<name of enterprise domain>
               ldap_host=<OID host>
               ldap_port=<OID non ssl port> | ldap_ssl_port=<OID ssl port>
               keystore=<path to keystore>
               keystore_alias=<keystore password alias>
               ldap_user_dn=<DN of OID user>
               ldap_alias=<OID user password alias>
               wallet_location=<wallet location>


          Options
          Each option must be prefixed with a space. Multiple options can be concatenated and
          prefixed with single space




                                                                                            7-73
                                                                                 Chapter 7
                                Enterprise User Security Manager (EUSM) Command Summary




Option                                    Description
realm_dn=<DN of the realm>                DN of the realm.
domain_name=<domain name>                 Name of the domain.
ldap_host=<OID host>                      OID host.
ldap_port=<OID non ssl port> |            OID non ssl port or OID ssl port.
ldap_ssl_port=<OID ssl port>
keystore=<path to keystore>               Path to the keystore.
keystore_alias=<keystore password         Keystore password taken from the Oracle
alias>                                    wallet.
ldap_user_dn=<DN of OID user>             DN of OID user which is used for
                                          authenticating and executing a command in
                                          the OID.
ldap_alias=<OID user password alias> OID user password taken from the Oracle
                                          wallet.
wallet_location=<wallet location>         Path to Oracle wallet when using the wallet.

Usage Notes
None.

Examples
Examples include removing from password accessible domains in the realm with and
without SSL port connectivity to OID.
Example 7-130 Removing from Password Accessible Domains with SSL Port
Conectivity to OID and Using Passwords Stored in the Oracle Wallet

eusm removeFromPwdAccessibleDomains domain_name=test_domain
realm_dn=dc=yy,dc=company,dc=com ldap_host=xxxxx.zz.company.com
ldap_port=3131 keystore=/etc/myapp/keyStore keystore_alias=keystore1
ldap_user_dn=cn=orcladmin ldap_alias=ldabadmin1 wallet_location=/oracle/
product/db_1/wallets


Example 7-131 Removing from Password Accessible Domains with SSL Port
Conectivity to OID

eusm removeFromPwdAccessibleDomains domain_name=test_domain
realm_dn=dc=yy,dc=company,dc=com ldap_host=xxxxx.zz.company.com
ldap_port=3131 keystore=/etc/myapp/keyStore ldap_user_dn=cn=orcladmin


Example 7-132 Removing from Password Accessible Domains with non-SSL
Port Conectivity to OID

eusm removeFromPwdAccessibleDomains domain_name=test_domain
realm_dn=dc=yy,dc=company,dc=com ldap_host=xxxxx.zz.company.com
ldap_port=3060 ldap_user_dn=cn=orcladmin




                                                                                    7-74
                                                                                            Chapter 7
                                           Enterprise User Security Manager (EUSM) Command Summary




7.3.44 listPwdAccessibleDomains
          Lists the password accessible domains in the realm.

          Syntax

          listPwdAccessibleDomains
               realm_dn=<DN of the realm>
               ldap_host=<OID host>
               ldap_port=<OID non ssl port> | ldap_ssl_port=<OID ssl port>
               keystore=<path to keystore>
               keystore_alias=<keystore password alias>
               ldap_user_dn=<DN of OID user>
               ldap_alias=<OID user password alias>
               wallet_location=<wallet location>


          Options
          Each option must be prefixed with a space. Multiple options can be concatenated and
          prefixed with single space.


           Option                                    Description
           realm_dn=<DN of the realm>                DN of the realm.
           ldap_host=<OID host>                      OID host.
           ldap_port=<OID non ssl port> |            OID non ssl port or OID ssl port.
           ldap_ssl_port=<OID ssl port>
           keystore=<path to keystore>               Path to the keystore.
           keystore_alias=<keystore password         Keystore password taken from the Oracle
           alias>                                    wallet.
           ldap_user_dn=<DN of OID user>             DN of OID user which is used for
                                                     authenticating and executing a command in
                                                     the OID.
           ldap_alias=<OID user password alias> OID user password taken from the Oracle
                                                     wallet.
           wallet_location=<wallet location>         Path to Oracle wallet when using the wallet.

          Usage Notes
          None.

          Examples
          Examples include listing the password accessible domains in the realm with and
          without SSL port connectivity to OID.
          Example 7-133 Listing the Password Accessible Domains with SSL Port
          Conectivity to OID and Using Passwords Stored in the Oracle Wallet

          eusm listPwdAccessibleDomains realm_dn=dc=yy,dc=company,dc=com
          ldap_host=xxxxx.zz.company.com ldap_port=3131 keystore=/etc/myapp/keyStore




                                                                                               7-75
                                                                                          Chapter 7
                                           Enterprise User Security Manager (EUSM) Command Summary


          keystore_alias=keystore1 ldap_user_dn=cn=orcladmin ldap_alias=ldabadmin1
          wallet_location=/oracle/product/db_1/wallets


          Example 7-134 Listing the Password Accessible Domains with SSL Port
          Conectivity to OID

          eusm listPwdAccessibleDomains realm_dn=dc=yy,dc=company,dc=com
          ldap_host=xxxxx.zz.company.com ldap_port=3131 keystore=/etc/myapp/keyStore
          ldap_user_dn=cn=orcladmin


          Example 7-135 Listing the Password Accessible Domains with non-SSL Port
          Conectivity to OID

          eusm listPwdAccessibleDomains realm_dn=dc=yy,dc=company,dc=com
          ldap_host=xxxxx.zz.company.com ldap_port=3060 ldap_user_dn=cn=orcladmin


7.3.45 listRealmCommonAttr
          Lists the realm common attributes.

          Syntax

          listRealmCommonAttr
               realm_dn=<DN of the realm>
               ldap_host=<OID host>
               ldap_port=<OID non ssl port> | ldap_ssl_port=<OID ssl port>
               keystore=<path to keystore>
               keystore_alias=<keystore password alias>
               ldap_user_dn=<DN of OID user>
               ldap_alias=<OID user password alias>
               wallet_location=<wallet location>


          Options
          Each option must be prefixed with a space. Multiple options can be concatenated and
          prefixed with single space.


           Option                                    Description
           realm_dn=<DN of the realm>                DN of the realm.
           ldap_host=<OID host>                      OID host.
           ldap_port=<OID non ssl port> |            OID non ssl port or OID ssl port.
           ldap_ssl_port=<OID ssl port>
           keystore=<path to keystore>               Path to the keystore.
           keystore_alias=<keystore password         Keystore password taken from the Oracle
           alias>                                    wallet.
           ldap_user_dn=<DN of OID user>             DN of OID user which is used for
                                                     authenticating and executing a command in
                                                     the OID.
           ldap_alias=<OID user password alias> OID user password taken from the Oracle
                                                     wallet.




                                                                                               7-76
                                                                                            Chapter 7
                                           Enterprise User Security Manager (EUSM) Command Summary




          Option                                     Description
          wallet_location=<wallet location>          Path to Oracle wallet when using the wallet.

          Usage Notes
          None.

          Examples
          Examples include listing the realm common attributes with and without SSL port
          connectivity to OID.
          Example 7-136 Listing the Realm Common Attributes with SSL Port
          Conectivity to OID and Using Passwords Stored in the Oracle Wallet

          eusm listRealmCommonAttr realm_dn=dc=yy,dc=company,dc=com
          ldap_host=xxxxx.zz.company.com ldap_port=3131 keystore=/etc/myapp/keyStore
          keystore_alias=keystore1 ldap_user_dn=cn=orcladmin ldap_alias=ldabadmin1
          wallet_location=/oracle/product/db_1/wallets


          Example 7-137 Listing the Realm Common Attributes with SSL Port
          Conectivity to OID

          eusm listRealmCommonAttr realm_dn=dc=yy,dc=company,dc=com
          ldap_host=xxxxx.zz.company.com ldap_port=3131 keystore=/etc/myapp/keyStore
          ldap_user_dn=cn=orcladmin


          Example 7-138 Listing the Realm Common Attributes with non-SSL Port
          Conectivity to OID

          eusm listRealmCommonAttr realm_dn=dc=yy,dc=company,dc=com
          ldap_host=xxxxx.zz.company.com ldap_port=3060 ldap_user_dn=cn=orcladmin


7.3.46 createAppCtxNamespace
          Adds a new namespace.

          Syntax

          createAppCtxNamespace
               namespace=<namespace name>
               domain_name=<domain name>
               realm_dn=<DN of the realm>
               ldap_host=<OID host>
               ldap_port=<OID non ssl port> | ldap_ssl_port=<OID ssl port>
               keystore=<path to keystore>
               keystore_alias=<keystore password alias>
               ldap_user_dn=<DN of OID user>
               ldap_alias=<OID user password alias>
               wallet_location=<wallet location>




                                                                                               7-77
                                                                                  Chapter 7
                                 Enterprise User Security Manager (EUSM) Command Summary




Options
Each option must be prefixed with a space. Multiple options can be concatenated and
prefixed with single space.


Option                                     Description
namespace=<namespace name>                 Name of the namespace.
domain_name=<domain name>                  Name of the domain.
realm_dn=<DN of the realm>                 DN of the realm.
ldap_host=<OID host>                       OID host.
ldap_port=<OID non ssl port> |             OID non ssl port or OID ssl port.
ldap_ssl_port=<OID ssl port>
keystore=<path to keystore>                Path to the keystore.
keystore_alias=<keystore password          Keystore password taken interactively at the
alias>                                     prompt or from the Oracle wallet.
ldap_user_dn=<DN of OID user>              DN of OID user which is used for
                                           authenticating and executing a command in
                                           the OID.
ldap_alias=<OID user password alias> OID user password taken interactively at the
                                           prompt or from the Oracle wallet.
wallet_location=<wallet location>          Path to Oracle wallet when using the wallet.

Usage Notes
None.

Examples
Examples include adding a new domain namespace in the realm with and without SSL
port connectivity to OID.
Example 7-139 Adding a New Domain Namespace with SSL Port Conectivity to
OID and Using Passwords Stored in the Oracle Wallet

eusm createAppCtxNamespace namespace=ns1 domain_name=test_domain
realm_dn=dc=yy,dc=company,dc=com ldap_host=xxxxx.zz.company.com
ldap_port=3131 keystore=/etc/myapp/keyStore keystore_alias=keystore1
ldap_user_dn=cn=orcladmin ldap_alias=ldabadmin1 wallet_location=/oracle/
product/db_1/wallets


Example 7-140    Adding a New Domain Namespace with SSL Port Conectivity to
OID

eusm createAppCtxNamespace namespace=ns1 domain_name=test_domain
realm_dn=dc=yy,dc=company,dc=com ldap_host=xxxxx.zz.company.com
ldap_port=3131 keystore=/etc/myapp/keyStore ldap_user_dn=cn=orcladmin




                                                                                     7-78
                                                                                            Chapter 7
                                           Enterprise User Security Manager (EUSM) Command Summary


          Example 7-141 Adding a New Domain Namespace with non-SSL Port
          Conectivity to OID

          eusm createAppCtxNamespace namespace=ns1 domain_name=test_domain
          realm_dn=dc=yy,dc=company,dc=com ldap_host=xxxxx.zz.company.com
          ldap_port=3060 ldap_user_dn=cn=orcladmin


7.3.47 deleteAppCtxNamespace
          Deletes a namespace.

          Syntax

          deleteAppCtxNamespace
               namespace=<namespace name>
               domain_name=<domain name>
               realm_dn=<DN of the realm>
               ldap_host=<OID host>
               ldap_port=<OID non ssl port> | ldap_ssl_port=<OID ssl port>
               keystore=<path to keystore>
               keystore_alias=<keystore password alias>
               ldap_user_dn=<DN of OID user>
               ldap_alias=<OID user password alias>
               wallet_location=<wallet location>


          Options
          Each option must be prefixed with a space. Multiple options can be concatenated and
          prefixed with single space.


          Option                                     Description
          namespace=<namespace name>                 Name of the namespace.
          domain_name=<domain name>                  Name of the domain.
          realm_dn=<DN of the realm>                 DN of the realm.
          ldap_host=<OID host>                       OID host.
          ldap_port=<OID non ssl port> |             OID non ssl port or OID ssl port.
          ldap_ssl_port=<OID ssl port>
          keystore=<path to keystore>                Path to the keystore.
          keystore_alias=<keystore password          Keystore password taken from the Oracle
          alias>                                     wallet.
          ldap_user_dn=<DN of OID user>              DN of OID user which is used for
                                                     authenticating and executing a command in
                                                     the OID.
          ldap_alias=<OID user password alias> OID user password taken from the Oracle
                                                     wallet.
          wallet_location=<wallet location>          Path to Oracle wallet when using the wallet.

          Usage Notes
          None.




                                                                                               7-79
                                                                                          Chapter 7
                                           Enterprise User Security Manager (EUSM) Command Summary




          Examples
          Examples include deleting a domain namespace from the realm with and without SSL
          port connectivity to OID.
          Example 7-142 Deleting a Domain Namespace with SSL Port Conectivity to OID
          and Using Passwords Stored in the Oracle Wallet

          eusm deleteAppCtxNamespace namespace=ns1 domain_name=test_domain
          realm_dn=dc=yy,dc=company,dc=com ldap_host=xxxxx.zz.company.com
          ldap_port=3131 keystore=/etc/myapp/keyStore keystore_alias=keystore1
          ldap_user_dn=cn=orcladmin ldap_alias=ldabadmin1 wallet_location=/oracle/
          product/db_1/wallets


          Example 7-143    Deleting a Domain Namespace with SSL Port Conectivity to OID

          eusm deleteAppCtxNamespace namespace=ns1 domain_name=test_domain
          realm_dn=dc=yy,dc=company,dc=com ldap_host=xxxxx.zz.company.com
          ldap_port=3131 keystore=/etc/myapp/keyStore ldap_user_dn=cn=orcladmin


          Example 7-144    Deleting a Domain Namespace with non-SSL Port Conectivity
          to OID

          eusm deleteAppCtxNamespace namespace=ns1 domain_name=test_domain
          realm_dn=dc=yy,dc=company,dc=com ldap_host=xxxxx.zz.company.com
          ldap_port=3060 ldap_user_dn=cn=orcladmin


7.3.48 listAppCtxNamespaces
          Lists the namespaces.

          Syntax

          listAppCtxNamespaces
               domain_name=<domain name>
               realm_dn=<DN of the realm>
               ldap_host=<OID host>
               ldap_port=<OID non ssl port> | ldap_ssl_port=<OID ssl port>
               keystore=<path to keystore>
               keystore_alias=<keystore password alias>
               ldap_user_dn=<DN of OID user>
               ldap_alias=<OID user password alias>
               wallet_location=<wallet location>


          Options
          Each option must be prefixed with a space. Multiple options can be concatenated and
          prefixed with single space.


           Option                                    Description
           domain_name=<domain name>                 Name of the domain.




                                                                                            7-80
                                                                                            Chapter 7
                                           Enterprise User Security Manager (EUSM) Command Summary




           Option                                    Description
           realm_dn=<DN of the realm>                DN of the realm.
           ldap_host=<OID host>                      OID host.
           ldap_port=<OID non ssl port> |            OID non ssl port or OID ssl port.
           ldap_ssl_port=<OID ssl port>
           keystore=<path to keystore>               Path to the keystore.
           keystore_alias=<keystore password         Keystore password taken from the Oracle
           alias>                                    wallet.
           ldap_user_dn=<DN of OID user>             DN of OID user which is used for
                                                     authenticating and executing a command in
                                                     the OID.
           ldap_alias=<OID user password alias> OID user password taken from the Oracle
                                                     wallet.
           wallet_location=<wallet location>         Path to Oracle wallet when using the wallet.

           Usage Notes
           None.

           Examples
           Examples include listing the domain namespaces in the realm with and without SSL
           port connectivity to OID.
           Example 7-145 Listing the Namespaces with SSL Port Conectivity to OID and
           Using Passwords Stored in the Oracle Wallet

           eusm listAppCtxNamespaces domain_name=test_domain
           realm_dn=dc=yy,dc=company,dc=com ldap_host=xxxxx.zz.company.com
           ldap_port=3131 keystore=/etc/myapp/keyStore keystore_alias=keystore1
           ldap_user_dn=cn=orcladmin ldap_alias=ldabadmin1 wallet_location=/oracle/
           product/db_1/wallets


           Example 7-146     Listing the Namespaces with SSL Port Conectivity to OID

           eusm listAppCtxNamespaces domain_name=test_domain
           realm_dn=dc=yy,dc=company,dc=com ldap_host=xxxxx.zz.company.com
           ldap_port=3131 keystore=/etc/myapp/keyStore ldap_user_dn=cn=orcladmin


           Example 7-147     Listing the Namespaces with non-SSL Port Conectivity to OID

           eusm listAppCtxNamespaces domain_name=test_domain
           realm_dn=dc=yy,dc=company,dc=com ldap_host=xxxxx.zz.company.com
           ldap_port=3060 ldap_user_dn=cn=orcladmin


7.3.49 createAppCtxAttribute
           Adds a new attribute.




                                                                                               7-81
                                                                                  Chapter 7
                                 Enterprise User Security Manager (EUSM) Command Summary




Syntax

createAppCtxAttribute
     attribute_name=<attribute name>
     namespace=<namespace name>
     domain_name=<domain name>
     realm_dn=<DN of the realm>
     ldap_host=<OID host>
     ldap_port=<OID non ssl port> | ldap_ssl_port=<OID ssl port>
     keystore=<path to keystore>
     keystore_alias=<keystore password alias>
     ldap_user_dn=<DN of OID user>
     ldap_alias=<OID user password alias>
     wallet_location=<wallet location>


Options
Each option must be prefixed with a space. Multiple options can be concatenated and
prefixed with single space.


Option                                     Description
attribute_name=<attribute name>            Name of the attribute.
namespace=<namespace name>                 Name of the namespace.
domain_name=<domain name>                  Name of the domain.
realm_dn=<DN of the realm>                 DN of the realm.
ldap_host=<OID host>                       OID host.
ldap_port=<OID non ssl port> |             OID non ssl port or OID ssl port.
ldap_ssl_port=<OID ssl port>
keystore=<path to keystore>                Path to the keystore.
keystore_alias=<keystore password          Keystore password taken from the Oracle
alias>                                     wallet.
ldap_user_dn=<DN of OID user>              DN of OID user which is used for
                                           authenticating and executing a command in
                                           the OID.
ldap_alias=<OID user password alias> OID user password taken from the Oracle
                                           wallet.
wallet_location=<wallet location>          Path to Oracle wallet when using the wallet.

Usage Notes
None.

Examples
Examples include adding a new attribute to a domain namespace in the realm with
and without SSL port connectivity to OID.




                                                                                     7-82
                                                                                           Chapter 7
                                            Enterprise User Security Manager (EUSM) Command Summary


           Example 7-148 Adding a New Attribute with SSL Port Conectivity to OID and
           Using Passwords Stored in the Oracle Wallet

           eusm createAppCtxAttribute attribute_name=attr1 namespace=ns1
           domain_name=test_domain realm_dn=dc=yy,dc=company,dc=com
           ldap_host=xxxxx.zz.company.com ldap_port=3131 keystore=/etc/myapp/keyStore
           keystore_alias=keystore1 ldap_user_dn=cn=orcladmin ldap_alias=ldabadmin1
           wallet_location=/oracle/product/db_1/wallets


           Example 7-149     Adding a New Attribute with SSL Port Conectivity to OID

           eusm createAppCtxAttribute attribute_name=attr1 namespace=ns1
           domain_name=test_domain realm_dn=dc=yy,dc=company,dc=com
           ldap_host=xxxxx.zz.company.com ldap_port=3131 keystore=/etc/myapp/keyStore
           ldap_user_dn=cn=orcladmin


           Example 7-150     Adding a New Attribute with non-SSL Port Conectivity to OID

           eusm createAppcCtxAttribute attribute_name=attr1 namespace=ns1
           domain_name=test_domain realm_dn=dc=yy,dc=company,dc=com
           ldap_host=xxxxx.zz.company.com ldap_port=3060 ldap_user_dn=cn=orcladmin


7.3.50 deleteAppCtxAttribute
           Deletes an attribute.

           Syntax

           deleteAppCtxAttribute
                attribute_name=<attribute name>
                namespace=<namespace name>
                domain_name=<domain name>
                realm_dn=<DN of the realm>
                ldap_host=<OID host>
                ldap_port=<OID non ssl port> | ldap_ssl_port=<OID ssl port>
                keystore=<path to keystore>
                keystore_alias=<keystore password alias>
                ldap_user_dn=<DN of OID user>
                ldap_alias=<OID user password alias>
                wallet_location=<wallet location>


           Options
           Each option must be prefixed with a space. Multiple options can be concatenated and
           prefixed with single space.


            Option                                    Description
            attribute_name=<attribute name>           Name of the attribute.
            namespace=<namespace name>                Name of the namespace.
            domain_name=<domain name>                 Name of the domain.




                                                                                             7-83
                                                                                               Chapter 7
                                              Enterprise User Security Manager (EUSM) Command Summary




            Option                                      Description
            realm_dn=<DN of the realm>                  DN of the realm.
            ldap_host=<OID host>                        OID host.
            ldap_port=<OID non ssl port> |              OID non ssl port or OID ssl port.
            ldap_ssl_port=<OID ssl port>
            keystore=<path to keystore>                 Path to the keystore.
            keystore_alias=<keystore password           Keystore password taken from the Oracle
            alias>                                      wallet.
            ldap_user_dn=<DN of OID user>               DN of OID user which is used for
                                                        authenticating and executing a command in
                                                        the OID.
            ldap_alias=<OID user password alias> OID user password taken from the Oracle
                                                        wallet.
            wallet_location=<wallet location>           Path to Oracle wallet when using the wallet.

            Usage Notes
            None.

            Examples
            Examples include deleting an attribute from a domain namespace in the realm with
            and without SSL port connectivity to OID.
            Example 7-151 Deleting Attributes with SSL Port Conectivity to OID and Using
            Passwords Stored in the Oracle Wallet

            eusm deleteAppCtxAttribute attribute_name=attr1 namespace=ns1
            domain_name=test_domain realm_dn=dc=yy,dc=company,dc=com
            ldap_host=xxxxx.zz.company.com ldap_port=3131 keystore=/etc/myapp/keyStore
            keystore_alias=keystore1 ldap_user_dn=cn=orcladmin ldap_alias=ldabadmin1
            wallet_location=/oracle/product/db_1/wallets


            Example 7-152       Deleting Attributes with SSL Port Conectivity to OID

            eusm deleteAppCtxAttribute attribute_name=attr1 namespace=ns1
            domain_name=test_domain realm_dn=dc=yy,dc=company,dc=com
            ldap_host=xxxxx.zz.company.com ldap_port=3131 keystore=/etc/myapp/keyStore
            ldap_user_dn=cn=orcladmin


            Example 7-153       Deleting Attributes with non-SSL Port Conectivity to OID

            eusm deleteAppCtxAttribute attribute_name=attr1 namespace=ns1
            domain_name=test_domain realm_dn=dc=yy,dc=company,dc=com
            ldap_host=xxxxx.zz.company.com ldap_port=3060 ldap_user_dn=cn=orcladmin


7.3.51 listAppCtxAttributes
            Lists the attributes.




                                                                                                  7-84
                                                                                  Chapter 7
                                 Enterprise User Security Manager (EUSM) Command Summary




Syntax

listAppCtxAttributes
     namespace=<namespace name>
     domain_name=<domain name>
     realm_dn=<DN of the realm>
     ldap_host=<OID host>
     ldap_port=<OID non ssl port> | ldap_ssl_port=<OID ssl port>
     keystore=<path to keystore>
     keystore_alias=<keystore password alias>
     ldap_user_dn=<DN of OID user>
     ldap_alias=<OID user password alias>
     wallet_location=<wallet location>


Options
Each option must be prefixed with a space. Multiple options can be concatenated and
prefixed with single space.


Option                                     Description
namespace=<namespace name>                 Name of the namespace.
domain_name=<domain name>                  Name of the domain.
realm_dn=<DN of the realm>                 DN of the realm.
ldap_host=<OID host>                       OID host.
ldap_port=<OID non ssl port> |             OID non ssl port or OID ssl port.
ldap_ssl_port=<OID ssl port>
keystore=<path to keystore>                Path to the keystore.
keystore_alias=<keystore password          Keystore password taken from the Oracle
alias>                                     wallet.
ldap_user_dn=<DN of OID user>              DN of OID user which is used for
                                           authenticating and executing a command in
                                           the OID.
ldap_alias=<OID user password alias> OID user password taken from the Oracle
                                           wallet.
wallet_location=<wallet location>          Path to Oracle wallet when using the wallet.

Usage Notes
None.

Examples
Examples include listing the domain namespace attributes in the realm with and
without SSL port connectivity to OID.
Example 7-154 Listing Attributes with SSL Port Conectivity to OID and Using
Passwords Stored in the Oracle Wallet

eusm listAppCtxAttributes namespace=ns1 domain_name=test_domain
realm_dn=dc=yy,dc=company,dc=com ldap_host=xxxxx.zz.company.com
ldap_port=3131 keystore=/etc/myapp/keyStore keystore_alias=keystore1




                                                                                     7-85
                                                                                           Chapter 7
                                            Enterprise User Security Manager (EUSM) Command Summary


           ldap_user_dn=cn=orcladmin ldap_alias=ldabadmin1 wallet_location=/oracle/
           product/db_1/wallets


           Example 7-155     Listing Attributes with SSL Port Conectivity to OID

           eusm listAppCtxAttributes namespace=ns1 domain_name=test_domain
           realm_dn=dc=yy,dc=company,dc=com ldap_host=xxxxx.zz.company.com
           ldap_port=3131 keystore=/etc/myapp/keyStore ldap_user_dn=cn=orcladmin


           Example 7-156     Example Title with non-SSL Port Conectivity to OID

           eusm listAppCtxAttributes namespace=ns1 domain_name=test_domain
           realm_dn=dc=yy,dc=company,dc=com ldap_host=xxxxx.zz.company.com
           ldap_port=3060 ldap_user_dn=cn=orcladmin


7.3.52 createAppCtxAttributeValue
           Adds a new attribute value.

           Syntax

           createAppCtxAttributeValue
                attribute_value=<value of the attribute>
                attribute_name=<attribute name>
                namespace=<namespace name>
                domain_name=<domain name>
                realm_dn=<DN of the realm>
                ldap_host=<OID host>
                ldap_port=<OID non ssl port> | ldap_ssl_port=<OID ssl port>
                keystore=<path to keystore>
                keystore_alias=<keystore password alias>
                ldap_user_dn=<DN of OID user>
                ldap_alias=<OID user password alias>
                wallet_location=<wallet location>


           Options
           Each option must be prefixed with a space. Multiple options can be concatenated and
           prefixed with single space.


           Option                                     Description
           attribute_value=<value of the              Value of the attribute.
           attribute>
           attribute_name=<attribute name>            Name of the attribute.
           namespace=<namespace name>                 Name of the namespace.
           domain_name=<domain name>                  Name of the domain.
           realm_dn=<DN of the realm>                 DN of the realm.
           ldap_host=<OID host>                       OID host.
           ldap_port=<OID non ssl port> |             OID non ssl port or OID ssl port.
           ldap_ssl_port=<OID ssl port>



                                                                                             7-86
                                                                                             Chapter 7
                                            Enterprise User Security Manager (EUSM) Command Summary




           Option                                     Description
           keystore=<path to keystore>                Path to the keystore.
           keystore_alias=<keystore password          Keystore password taken from the Oracle
           alias>                                     wallet.
           ldap_user_dn=<DN of OID user>              DN of OID user which is used for
                                                      authenticating and executing a command in
                                                      the OID.
           ldap_alias=<OID user password alias> OID user password taken from the Oracle
                                                      wallet.
           wallet_location=<wallet location>          Path to Oracle wallet when using the wallet.

           Usage Notes
           None.

           Examples
           Examples include adding a new attribute value to an attribute to a domain namespace
           in the realm with and without SSL port connectivity to OID.
           Example 7-157 Adding a New Attribute Value with SSL Port Conectivity to OID
           and Using Passwords Stored in the Oracle Wallet

           eusm createAppCtxAttributeValue attribute_value=val1 attribute_name=attr1
           namespace=ns1 domain_name=test_domain realm_dn=dc=yy,dc=company,dc=com
           ldap_host=xxxxx.zz.company.com ldap_port=3131 keystore=/etc/myapp/keyStore
           keystore_alias=keystore1 ldap_user_dn=cn=orcladmin ldap_alias=ldabadmin1
           wallet_location=/oracle/product/db_1/wallets


           Example 7-158     Adding a New Attribute Value with SSL Port Conectivity to OID

           eusm createAppCtxAttributeValue attribute_value=val1 attribute_name=attr1
           namespace=ns1 domain_name=test_domain realm_dn=dc=yy,dc=company,dc=com
           ldap_host=xxxxx.zz.company.com ldap_port=3131 keystore=/etc/myapp/keyStore
           ldap_user_dn=cn=orcladmin


           Example 7-159     Adding a New Attribute Value with non-SSL Port Conectivity to
           OID

           eusm createAppCtxAttributeValue attribute_value=val1 attribute_name=attr1
           namespace=ns1 domain_name=test_domain realm_dn=dc=yy,dc=company,dc=com
           ldap_host=xxxxx.zz.company.com ldap_port=3060 ldap_user_dn=cn=orcladmin


7.3.53 deleteAppCtxAttributeValue
           Deletes an attribute value.




                                                                                                7-87
                                                                                  Chapter 7
                                 Enterprise User Security Manager (EUSM) Command Summary




Syntax

deleteAppCtxAttributeValue
     attribute_value=<value of the attribute>
     attribute_name=<attribute name>
     namespace=<namespace name>
     domain_name=<domain name>
     realm_dn=<DN of the realm>
     ldap_host=<OID host>
     ldap_port=<OID non ssl port> | ldap_ssl_port=<OID ssl port>
     keystore=<path to keystore>
     keystore_alias=<keystore password alias>
     ldap_user_dn=<DN of OID user>
     ldap_alias=<OID user password alias>
     wallet_location=<wallet location>


Options
Each option must be prefixed with a space. Multiple options can be concatenated and
prefixed with single space.


Option                                     Description
attribute_value=<value of the              Value of the attribute.
attribute>
attribute_name=<attribute name>            Name of the attribute.
namespace=<namespace name>                 Name of the namespace.
domain_name=<domain name>                  Name of the domain.
realm_dn=<DN of the realm>                 DN of the realm.
ldap_host=<OID host>                       OID host.
ldap_port=<OID non ssl port> |             OID non ssl port or OID ssl port.
ldap_ssl_port=<OID ssl port>
keystore=<path to keystore>                Path to the keystore.
keystore_alias=<keystore password          Keystore password taken from the Oracle
alias>                                     wallet.
ldap_user_dn=<DN of OID user>              DN of OID user which is used for
                                           authenticating and executing a command in
                                           the OID.
ldap_alias=<OID user password alias> OID user password taken from the Oracle
                                           wallet.
wallet_location=<wallet location>          Path to Oracle wallet when using the wallet.

Usage Notes
None.

Examples
Examples include deleting an attribute value from an attribute in a domain namespace
in the realm with and without SSL port connectivity to OID.




                                                                                     7-88
                                                                                           Chapter 7
                                            Enterprise User Security Manager (EUSM) Command Summary


           Example 7-160 Deleting an Attribute Value with SSL Port Conectivity to OID
           and Using Passwords Stored in the Oracle Wallet

           eusm deleteAppCtxAttributeValue attribute_value=val1 attribute_name=attr1
           namespace=ns1 domain_name=test_domain realm_dn=dc=yy,dc=company,dc=com
           ldap_host=xxxxx.zz.company.com ldap_port=3131 keystore=/etc/myapp/keyStore
           keystore_alias=keystore1 ldap_user_dn=cn=orcladmin ldap_alias=ldabadmin1
           wallet_location=/oracle/product/db_1/wallets


           Example 7-161      Deleting an Attribute Value with SSL Port Conectivity to OID

           eusm deleteAppCtxAttributeValue attribute_value=val1 attribute_name=attr1
           namespace=ns1 domain_name=test_domain realm_dn=dc=yy,dc=company,dc=com
           ldap_host=xxxxx.zz.company.com ldap_port=3131 keystore=/etc/myapp/keyStore
           ldap_user_dn=cn=orcladmin


           Example 7-162      Deleting an Attribute Value with non-SSL Port Conectivity to
           OID

           eusm deleteAppCtxAttributeValue attribute_value=val1 attribute_name=attr1
           namespace=ns1 domain_name=test_domain realm_dn=dc=yy,dc=company,dc=com
           ldap_host=xxxxx.zz.company.com ldap_port=3060 ldap_user_dn=cn=orcladmin


7.3.54 listAppCtxAttributeValues
           Lists the attribute values.

           Syntax

           listAppCtxAttributeValues
                attribute_name=<attribute name>
                namespace=<namespace name>
                domain_name=<domain name>
                realm_dn=<DN of the realm>
                ldap_host=<OID host>
                ldap_port=<OID non ssl port> | ldap_ssl_port=<OID ssl port>
                keystore=<path to keystore>
                keystore_alias=<keystore password alias>
                ldap_user_dn=<DN of OID user>
                ldap_alias=<OID user password alias>
                wallet_location=<wallet location>


           Options
           Each option must be prefixed with a space. Multiple options can be concatenated and
           prefixed with single space.


            Option                                    Description
            attribute_name=<attribute name>           Name of the attribute.
            namespace=<namespace name>                Name of the namespace.




                                                                                             7-89
                                                                                   Chapter 7
                                  Enterprise User Security Manager (EUSM) Command Summary




Option                                      Description
domain_name=<domain name>                   Name of the domain.
realm_dn=<DN of the realm>                  DN of the realm.
ldap_host=<OID host>                        OID host.
ldap_port=<OID non ssl port> |              OID non ssl port or OID ssl port.
ldap_ssl_port=<OID ssl port>
keystore=<path to keystore>                 Path to the keystore.
keystore_alias=<keystore password           Keystore password taken from the Oracle
alias>                                      wallet.
ldap_user_dn=<DN of OID user>               DN of OID user which is used for
                                            authenticating and executing a command in
                                            the OID.
ldap_alias=<OID user password alias> OID user password taken from the Oracle
                                            wallet.
wallet_location=<wallet location>           Path to Oracle wallet when using the wallet.

Usage Notes
None.

Examples
Examples include listing the attribute values for an attribute for a domain namespace
in the realm with and without SSL port connectivity to OID.
Example 7-163 Listing the Attribute Values with SSL Port Conectivity to OID
and Using Passwords Stored in the Oracle Wallet

eusm listAppCtxAttributeValues attribute_name=attr1 namespace=ns1
domain_name=test_domain realm_dn=dc=yy,dc=company,dc=com
ldap_host=xxxxx.zz.company.com ldap_port=3131 keystore=/etc/myapp/keyStore
keystore_alias=keystore1 ldap_user_dn=cn=orcladmin ldap_alias=ldabadmin1
wallet_location=/oracle/product/db_1/wallets


Example 7-164     Listing the Attribute Values with SSL Port Conectivity to OID

eusm listAppCtxAttributeValues attribute_name=attr1 namespace=ns1
domain_name=test_domain realm_dn=dc=yy,dc=company,dc=com
ldap_host=xxxxx.zz.company.com ldap_port=3131 keystore=/etc/myapp/keyStore
ldap_user_dn=cn=orcladmin


Example 7-165     Listing the Attribute Values with non-SSL Port Conectivity to
OID

eusm listAppCtxAttributeValues attribute_name=attr1 namespace=ns1
domain_name=test_domain realm_dn=dc=yy,dc=company,dc=com
ldap_host=xxxxx.zz.company.com ldap_port=3060 ldap_user_dn=cn=orcladmin




                                                                                      7-90
                                                                                             Chapter 7
                                            Enterprise User Security Manager (EUSM) Command Summary




7.3.55 createAppCtxUsers
          Adds a new user for an attribute value.

          Syntax

          createAppCtxUsers
               user_dn=<Distinguished name of user>
               attribute_value=<value of the attribute>
               attribute_name=<attribute name>
               namespace=<namespace name>
               domain_name=<domain name>
               realm_dn=<DN of the realm>
               ldap_host=<OID host>
               ldap_port=<OID non ssl port> | ldap_ssl_port=<OID ssl port>
               keystore=<path to keystore>
               keystore_alias=<keystore password alias>
               ldap_user_dn=<DN of OID user>
               ldap_alias=<OID user password alias>
               wallet_location=<wallet location>


          Options
          Each option must be prefixed with a space. Multiple options can be concatenated and
          prefixed with single space.


           Option                                     Description
           user_dn=<Distinguished name of user> DN of the user.
           attribute_value=<value of the              Value of the attribute.
           attribute>
           attribute_name=<attribute name>            Name of the attribute.
           namespace=<namespace name>                 Name of the namespace.
           domain_name=<domain name>                  Name of the domain.
           realm_dn=<DN of the realm>                 DN of the realm.
           ldap_host=<OID host>                       OID host.
           ldap_port=<OID non ssl port> |             OID non ssl port or OID ssl port.
           ldap_ssl_port=<OID ssl port>
           keystore=<path to keystore>                Path to the keystore.
           keystore_alias=<keystore password          Keystore password taken from the Oracle
           alias>                                     wallet.
           ldap_user_dn=<DN of OID user>              DN of OID user which is used for
                                                      authenticating and executing a command in
                                                      the OID.
           ldap_alias=<OID user password alias> OID user password taken from the Oracle
                                                      wallet.
           wallet_location=<wallet location>          Path to Oracle wallet when using the wallet.




                                                                                                7-91
                                                                                           Chapter 7
                                            Enterprise User Security Manager (EUSM) Command Summary




          Usage Notes
          None.

          Examples
          Examples include adding a new user for an attribute value to an attribute to a domain
          namespace in the realm with and without SSL port connectivity to OID.
          Example 7-166 Adding a New User for an Attribute Value with SSL Port
          Conectivity to OID and Using Passwords Stored in the Oracle Wallet

          eusm createAppCtxUsers
          user_dn=cn=test_user,cn=Users,dc=yy,dc=company,dc=com attribute_value=val1
          attribute_name=attr1 namespace=ns1 domain_name=test_domain
          realm_dn=dc=yy,dc=company,dc=com ldap_host=xxxxx.zz.company.com
          ldap_port=3131 keystore=/etc/myapp/keyStore keystore_alias=keystore1
          ldap_user_dn=cn=orcladmin ldap_alias=ldabadmin1 wallet_location=/oracle/
          product/db_1/wallets


          Example 7-167 Adding a New User for an Attribute Value with SSL Port
          Conectivity to OID

          eusm createAppCtxUsers
          user_dn=cn=test_user,cn=Users,dc=yy,dc=company,dc=com attribute_value=val1
          attribute_name=attr1 namespace=ns1 domain_name=test_domain
          realm_dn=dc=yy,dc=company,dc=com ldap_host=xxxxx.zz.company.com
          ldap_port=3131 keystore=/etc/myapp/keyStore ldap_user_dn=cn=orcladmin


          Example 7-168 Adding a New User for an Attribute Value with non-SSL Port
          Conectivity to OID

          eusm createAppCtxUsers
          user_dn=cn=test_user,cn=Users,dc=yy,dc=company,dc=com attribute_value=val1
          attribute_name=attr1 namespace=ns1 domain_name=test_domain
          realm_dn=dc=yy,dc=company,dc=com ldap_host=xxxxx.zz.company.com
          ldap_port=3060 ldap_user_dn=cn=orcladmin


7.3.56 deleteAppCtxUsers
          Deletes a user from an attribute value.

          Syntax

          deleteAppCtxUsers
               user_dn=<Distinguished name of user>
               attribute_value=<value of the attribute>
               attribute_name=<attribute name>
               namespace=<namespace name>
               domain_name=<domain name>
               realm_dn=<DN of the realm>
               ldap_host=<OID host>




                                                                                             7-92
                                                                                   Chapter 7
                                  Enterprise User Security Manager (EUSM) Command Summary


     ldap_port=<OID non ssl port> | ldap_ssl_port=<OID ssl port>
     keystore=<path to keystore>
     keystore_alias=<keystore password alias>
     ldap_user_dn=<DN of OID user>
     ldap_alias=<OID user password alias>
     wallet_location=<wallet location>


Options
Each option must be prefixed with a space. Multiple options can be concatenated and
prefixed with single space.


Option                                      Description
user_dn=<Distinguished name of user> DN of the user.
attribute_value=<value of the               Value of the attribute.
attribute>
attribute_name=<attribute name>             Name of the attribute.
namespace=<namespace name>                  Name of the namespace.
domain_name=<domain name>                   Name of the domain.
realm_dn=<DN of the realm>                  DN of the realm.
ldap_host=<OID host>                        OID host.
ldap_port=<OID non ssl port> |              OID non ssl port or OID ssl port.
ldap_ssl_port=<OID ssl port>
keystore=<path to keystore>                 Path to the keystore.
keystore_alias=<keystore password           Keystore password taken from the Oracle
alias>                                      wallet.
ldap_user_dn=<DN of OID user>               DN of OID user which is used for
                                            authenticating and executing a command in
                                            the OID.
ldap_alias=<OID user password alias> OID user password taken from the Oracle
                                            wallet.
wallet_location=<wallet location>           Path to Oracle wallet when using the wallet.

Usage Notes
None.

Examples
Examples include deleting a user from an attribute value for an attribute in a domain
namespace in the realm with and without SSL port connectivity to OID.
Example 7-169 Deleting a User from an Attribute Value with SSL Port
Conectivity to OID and Using Passwords Stored in the Oracle Wallet

eusm deleteAppCtxUsers
user_dn=cn=test_user,cn=Users,dc=yy,dc=company,dc=com attribute_value=val1
attribute_name=attr1 namespace=ns1 domain_name=test_domain
realm_dn=dc=yy,dc=company,dc=com ldap_host=xxxxx.zz.company.com
ldap_port=3131 keystore=/etc/myapp/keyStore keystore_alias=keystore1




                                                                                      7-93
                                                                                               Chapter 7
                                                Enterprise User Security Manager (EUSM) Command Summary


           ldap_user_dn=cn=orcladmin ldap_alias=ldabadmin1 wallet_location=/oracle/
           product/db_1/wallets


           Example 7-170 Deleting a User from an Attribute Value with SSL Port
           Conectivity to OID

           eusm deleteAppCtxUsers
           user_dn=cn=test_user,cn=Users,dc=yy,dc=company,dc=com attribute_value=val1
           attribute_name=attr1 namespace=ns1 domain_name=test_domain
           realm_dn=dc=yy,dc=company,dc=com ldap_host=xxxxx.zz.company.com
           ldap_port=3131 keystore=/etc/myapp/keyStore ldap_user_dn=cn=orcladmin


           Example 7-171 Deleting a User from an Attribute Value with non-SSL Port
           Conectivity to OID

           eusm deleteAppCtxUsers
           user_dn=cn=test_user,cn=Users,dc=yy,dc=company,dc=com attribute_value=val1
           attribute_name=attr1 namespace=ns1 domain_name=test_domain
           realm_dn=dc=yy,dc=company,dc=com ldap_host=xxxxx.zz.company.com
           ldap_port=3060 ldap_user_dn=cn=orcladmin


7.3.57 listAppCtxUsers
           Lists all users for an attribute value.

           Syntax

           listAppCtxUsers
                attribute_value=<value of the attribute>
                attribute_name=<attribute name>
                namespace=<namespace name>
                domain_name=<domain name>
                realm_dn=<DN of the realm>
                ldap_host=<OID host>
                ldap_port=<OID non ssl port> | ldap_ssl_port=<OID ssl port>
                keystore=<path to keystore>
                keystore_alias=<keystore password alias>
                ldap_user_dn=<DN of OID user>
                ldap_alias=<OID user password alias>
                wallet_location=<wallet location>


           Options
           Each option must be prefixed with a space. Multiple options can be concatenated and
           prefixed with single space.


           Option                                         Description
           attribute_value=<value of the                  Value of the attribute.
           attribute>
           attribute_name=<attribute name>                Name of the attribute.
           namespace=<namespace name>                     Name of the namespace.




                                                                                                 7-94
                                                                                     Chapter 7
                                    Enterprise User Security Manager (EUSM) Command Summary




Option                                        Description
domain_name=<domain name>                     Name of the domain.
realm_dn=<DN of the realm>                    DN of the realm.
ldap_host=<OID host>                          OID host.
ldap_port=<OID non ssl port> |                OID non ssl port or OID ssl port.
ldap_ssl_port=<OID ssl port>
keystore=<path to keystore>                   Path to the keystore.
keystore_alias=<keystore password             Keystore password taken from the Oracle
alias>                                        wallet.
ldap_user_dn=<DN of OID user>                 DN of OID user which is used for
                                              authenticating and executing a command in
                                              the OID.
ldap_alias=<OID user password alias> OID user password taken from the Oracle
                                              wallet.
wallet_location=<wallet location>             Path to Oracle wallet when using the wallet.

Usage Notes
None.

Examples
Examples include listing all users for an attribute value for an attribute for a domain
namespace in the realm with and without SSL port connectivity to OID.
Example 7-172 Listing All Users for an Attribute Value with SSL Port
Conectivity to OID and Using Passwords Stored in the Oracle Wallet

eusm listAppCtxUsers attribute_value=val1 attribute_name=attr1
namespace=ns1 domain_name=test_domain realm_dn=dc=yy,dc=company,dc=com
ldap_host=xxxxx.zz.company.com ldap_port=3131 keystore=/etc/myapp/keyStore
keystore_alias=keystore1 ldap_user_dn=cn=orcladmin ldap_alias=ldabadmin1
wallet_location=/oracle/product/db_1/wallets


Example 7-173 Listing All Users for an Attribute Value with SSL Port
Conectivity to OID

eusm listAppCtxUsers attribute_value=val1 attribute_name=attr1
namespace=ns1 domain_name=test_domain realm_dn=dc=yy,dc=company,dc=com
ldap_host=xxxxx.zz.company.com ldap_port=3131 keystore=/etc/myapp/keyStore
ldap_user_dn=cn=orcladmin


Example 7-174 Listing All Users for an Attribute Value with non-SSL Port
Conectivity to OID

eusm listAppcCtxUsers attribute_value=val1 attribute_name=attr1
namespace=ns1 domain_name=test_domain realm_dn=dc=yy,dc=company,dc=com
ldap_host=xxxxx.zz.company.com ldap_port=3060 ldap_user_dn=cn=orcladmin




                                                                                        7-95
A
Using the User Migration Utility
          This chapter describes the User Migration Utility. You can use it to perform bulk
          migrations of database users to an LDAP directory, where they can be stored and
          managed centrally as enterprise users. It contains the following topics:
          •   Benefits of Migrating Local or External Users to Enterprise Users
          •   Introduction to the User Migration Utility
          •   Prerequisites for Performing Migration
          •   User Migration Utility Command-Line Syntax
          •   Accessing Help for the User Migration Utility
          •   User Migration Utility Parameters
          •   User Migration Utility Usage Examples
          •   Troubleshooting Using the User Migration Utility


A.1 Benefits of Migrating Local or External Users to
Enterprise Users
          Migrating from a database user model to an enterprise user model provides solutions
          to administrative, security, and usability challenges in an enterprise environment. In an
          enterprise user model, all user information is moved to an LDAP directory service.
          Enterprise user security provides the ability to easily and securely manage enterprise
          wide users by providing the following benefits:
          •   Centralized storage of user credentials, roles, and privileges in an LDAP version 3-
              compliant directory server
          •   Provides the infrastructure to enable single sign-on using X.509v3-compliant
              certificates, typically deployed where end-to-end SSL is required
          •   Enhanced security through more timely maintenance and fewer user passwords
              The centralization of user information inherent in the enterprise user model makes
              it easier to manage. Security administrators can perform necessary maintenance
              changes to user information immediately, thereby maintaining better control over
              access to critical network resources. In addition, users find the enterprise user
              model easier to use because they have fewer passwords to remember. So, they
              are less likely to choose easily guessed passwords or to write them down where
              others can copy them.




                                                                                               A-1
                                                                                                 Appendix A
                                                                   Introduction to the User Migration Utility




                      See Also:
                      "Introduction to Enterprise User Security" for detailed conceptual
                      information about enterprise user security



A.2 Introduction to the User Migration Utility
           The User Migration Utility is a command-line utility that enables enterprise user
           administrators to move their users from a local database model to an enterprise user
           model. You can easily migrate thousands of local and external database users to an
           enterprise user environment in an LDAP directory where they can be managed from a
           central location. The utility connects to the database using the Oracle JDBC OCI
           driver.
           Enterprise user administrators can select for migration any combination of the
           following user subsets in a database:
           •   List of users specified on the command line or in a file
           •   All external users
           •   All global users
           In addition, enterprise user administrators can specify values for utility parameters that
           determine how the users are migrated such as
           •   Where to put the migrated users in the LDAP directory tree
           •   Map a user with multiple accounts on various databases to a single directory user
               entry
           The following sections explain the migration process and the changes that occur to
           user schemas.



                  Note:
                  After external users are migrated, their external authentication and
                  authorization mechanisms are replaced by directory-based mechanisms.
                  New passwords are randomly generated for migrated users if they are
                  mapped to newly created directory entries.



           This section includes the following topics:
           •   Bulk User Migration Process Overview
           •   About the ORCL_GLOBAL_USR_MIGRATION_DATA Table
           •   Migration Effects on Users' Old Database Schemas
           •   Migration Process


A.2.1 Bulk User Migration Process Overview
           Bulk user migration is a two-phase process. In Phase One, you start the migration
           process by populating user information into an interface database table. Enterprise



                                                                                                       A-2
                                                                                                  Appendix A
                                                                    Introduction to the User Migration Utility


            user administrators then verify that the information is accurate before completing the
            migration with Phase Two, which commits the changes to the database and the
            directory. The process is described in the following steps. If you want to use a secure
            external password store, then you must perform Step 0; otherwise, passwords can be
            provided interactively and you can skip Step 0.
            •   Step 0: About Using a Secure External Password Store
            •   Step 1: (Phase One) Preparing for the Migration
            •   Step 2: Verify User Information
            •   Step 3: (Phase Two) Completing the Migration

A.2.1.1 Step 0: About Using a Secure External Password Store
            Before you run the User Migration Utility, configure a client-side Oracle wallet as a
            secure external password store so that your applications can use password
            credentials stored in the wallet to connect to databases.
            Storing database password credentials in a client-side Oracle wallet eliminates the
            need to embed passwords in application code, batch jobs, or scripts. This reduces the
            risk of exposing passwords in the clear in scripts and application code, and allows you
            to more easily manage password policies for user accounts without changing
            application code or scripts whenever passwords change.
            See Configuring a Client to Use the External Password Store for steps to configure a
            client to use the external password store by using the mkstore command-line utility.



                   Note:
                   The external password store of the wallet is separate from the area where
                   public key infrastructure (PKI) credentials are stored. Consequently, you
                   cannot use Oracle Wallet Manager to manage credentials in the external
                   password store of the wallet. Instead, use the command-line utility mkstore
                   to manage these credentials.



            Using the mkstore CreateCredential command, configure the following user
            credentials by providing information for <alias, username, password>, in which you
            will be prompted to enter the password for each user:
            •   DBALIAS, DBADMIN, password
            •   ENTALIAS, ENTADMIN, password
            •   KEYALIAS, KEYSTORE, password

            Configuring these credentials allows you to use the following parameters on the umu
            script command line:
            •   DBALIAS=<db-password-alias>
            •   ENTALIAS=<enterprise-password-alias>
            •   KEYALIAS=<keystore-password-alias>




                                                                                                        A-3
                                                                                                    Appendix A
                                                                      Introduction to the User Migration Utility


             Umu examples use the following wallet credential information for users DBADMIN ,
             ENTADMIN and KEYSTORE that was provided for the alias name, user name, and
             password. The wallet location is specified as shown.
             •   dbadmin1, sysman, password
             •   entadmin1, entman, password
             •   keystore1, keystore, password
             •   wallet_location=/oracle/product/db_1/wallets

             Umu examples use the following entries on the command-line:
             •   DBALIAS=dbadmin1
             •   ENTALIAS=entadmin1
             •   KEYALIAS=keystore1
             •   wallet_location=/oracle/product/db_1/wallets

             After configuring the client-side wallet, enable auto-login for Oracle Wallets to allow the
             administrator running the User Migration Utility to access and perform these services
             without having to supply the necessary credentials.



                    See Also:

                    •   Managing the Secure External Password Store for Password Credentials
                        for more information about creating a client-side password store wallet to
                        store alias, user name, and password credentials for users
                    •   About Using Auto Login for Oracle Wallets for information about enabling
                        auto login for Oracle wallets that enables PKI-based access to services
                        without requiring human intervention to supply the necessary user name
                        passwords required to run the User Migration Utility



A.2.1.2 Step 1: (Phase One) Preparing for the Migration
             In the first part of the migration process, the utility checks if the
             ORCL_GLOBAL_USR_MIGRATION_DATA interface table exists in the enterprise user
             administrator's schema. If it exists, then the administrator can choose to reuse the
             table (clearing its contents), reuse the table and its contents, or re-create the table.
             Phase One can be run multiple times, each time adding to the interface table. If the
             table does not exist, then the utility creates it in the administrator's schema. The
             interface table is populated with information about the migrating users from the
             database and the directory. The command-line options used determine what
             information populates this table.



                    Note:
                    The utility will not create the interface table in the SYS schema.




                                                                                                          A-4
                                                                                                   Appendix A
                                                                     Introduction to the User Migration Utility




A.2.1.3 Step 2: Verify User Information
             This is an intermediate step to allow the enterprise user administrator to verify that the
             user information is correct in the interface table before committing the changes to the
             database and the directory.

A.2.1.4 Step 3: (Phase Two) Completing the Migration
             After the interface table user information is checked, Phase Two begins. The utility
             retrieves the information from the table and updates the directory and the database.
             Depending on whether directory entries exist for migrating users, the utility creates
             random passwords as follows:
             •   If migrating users are being mapped to newly created directory entries, then the
                 utility generates random passwords, which are used as credentials for both the
                 database and directory.
             •   If migrating users are being mapped to existing directory entries with unset
                 database passwords, then the utility generates random database passwords only.
             In either case, after generating the required random passwords, the utility then stores
             them in the DBPASSWORD and DIRPASSWORD interface table columns. The enterprise user
             administrator can read these passwords from the interface table and inform migrating
             users.



                    See Also:
                    "User Migration Utility Parameters" for a list of command-line options and
                    their descriptions



A.2.2 About the ORCL_GLOBAL_USR_MIGRATION_DATA Table
             This is the interface table which is populated with information about the migrating
             users during Phase One of the bulk user migration process. The information that
             populates this table is pulled from the database and checked against existing entries in
             the directory. If there is corresponding information in the directory, then that is marked
             in the table for that user. After enterprise user administrators verify the information in
             this table, changes are made to the directory and the database in Phase Two.



                    Note:
                    The ORCL_GLOBAL_USR_MIGRATION_DATA interface table contains very
                    sensitive information. Access to it should be tightly controlled using database
                    privileges.



             The table columns are listed in Table A-1.




                                                                                                         A-5
                                                                                                        Appendix A
                                                                          Introduction to the User Migration Utility




Table A-1    ORCL_GLOBAL_USR_MIGRATION_DATA Table Schema

Column Name                   Data Type             Null         Description
USERNAME (Primary Key)        VARCHAR2(30)          NOT NULL     Database user name
OLD_SCHEMA_TYPE               VARCHAR2(10)          -            Old schema type in the database before
                                                                 migration
PASSWORD_VERIFIER             VARCHAR2(30)          -            Not used
USERDN                        VARCHAR2(4000)        -            Distinguished Name (DN) of the user in the
                                                                 directory (new or existing)
USERDN_EXIST_FLAG             CHAR(1)               -            Flag indicating whether the DN already
                                                                 exists in the directory
SHARED_SCHEMA                 VARCHAR2(30)          -            Shared schema name, if users are to be
                                                                 mapped to a shared schema during phase
                                                                 two
MAPPING_TYPE                  VARCHAR2(10)          -            Mapping type (database or domain)
MAPPING_LEVEL                 VARCHAR2(10)          -            Mapping level (entry or subtree)
CASCADE_FLAG                  CHAR(1)               -            Cascade flag used when dropping a user
                                                                 (for shared schema mapping only)
DBPASSWORD_EXIST_FLAG         CHAR(1)               -            Flag indicating whether the database
                                                                 password verifier already exists in the
                                                                 directory for this user
DBPASSWORD                    VARCHAR2(30)          -            Randomly generated database password
                                                                 verifiers to be stored in the directory
DIRPASSWORD                   VARCHAR2(30)          -            Randomly generated directory password for
                                                                 new entries
PHASE_COMPLETED               VARCHAR2(10)          -            Information about the phase that has been
                                                                 completed successfully
NEEDS_ATTENTION_FLAG          CHAR(1)               -            Flag indicating whether the row contains
                                                                 abnormalities that require administrator
                                                                 attention
ATTENTION_DESCRIPTION         VARCHAR2(100)         -            Textual hint for the administrator if the
                                                                 attention flag is set
KERBEROS_PNAME                VARCHAR2(30)          -            Kerberos Principal Name for external
                                                                 kerberos users

                 This section includes the following topic: Which Interface Table Column Values Can
                 Be Modified Between Phase One and Phase Two?.

A.2.2.1 Which Interface Table Column Values Can Be Modified Between Phase
One and Phase Two?
                 After running phase one of the utility, if necessary, enterprise user administrators can
                 change the interface table columns listed in Table A-2.




                                                                                                              A-6
                                                                                                       Appendix A
                                                                         Introduction to the User Migration Utility




Table A-2   Interface Table Column Values That Can Be Modified Between Phase One and Phase
Two

Column Name                Valid Values          Restrictions
USERDN                     DN of user            If this value is changed, then the administrator should
                                                 verify that the USERDN_EXIST_FLAG and the
                                                 DBPASSWORD_EXIST_FLAG values are set accordingly.
USERDN_EXIST_FLAG          T/F                   If the USERDN column value changes, then this column
                                                 value should also change to reflect the new USERDN
                                                 status.
DBPASSWORD_EXIST_FLAG      T/F                   If the USERDN column value changes, then this column
                                                 value should also change to reflect whether a database
                                                 password exists for the new USERDN.
SHARED_SCHEMA              Shared schema name Specify only if a shared schema exists in the database.
MAPPING_TYPE               DB/DOMAIN             Set this value only if SHARED_SCHEMA is not set to NULL.
MAPPING_LEVEL              ENTRY/SUBTREE         Set this value only if SHARED_SCHEMA is not set to NULL.
CASCADE_FLAG               T/F                   Set this value only if SHARED_SCHEMA is not set to NULL. If
                                                 this column is set to true (T), then the users' schema
                                                 objects are forcibly deleted. If this column is set to false
                                                 (F), then the administrator must delete all user schema
                                                 objects before going into Phase Two.
PHASE_COMPLETED            ZERO/ONE/TWO          If the administrator can resolve the conflicts or ambiguities
                                                 specified with the NEEDS_ATTENTION_FLAG, then this
                                                 column value can be changed to ONE so phase two can be
                                                 run with the utility.


A.2.3 Migration Effects on Users' Old Database Schemas
                If shared schema mapping is not used, then users retain their old database schemas.
                If shared schema mapping is used, then users' local schemas are dropped from the
                database, and they are mapped to a shared schema that the enterprise user
                administrator creates for this purpose before performing the migration. When migrated
                users own database objects in their old local database schemas, administrators can
                specify that the schema and objects are not to be dropped by setting the CASCADE
                parameter to NO. When the CASCADE parameter is set to NO, users who own database
                objects in their old local schemas do not migrate successfully so their objects are not
                dropped.
                If some users want to retain the objects in their local database schemas and be
                mapped to a shared schema, then the administrator can manually migrate those
                objects to the shared schema before performing the bulk user migration. However,
                when objects are migrated to a shared schema, they are shared among all users who
                share that new schema.
                Table A-3 summarizes the effects of setting the MAPSCHEMA and CASCADE parameters.




                                                                                                             A-7
                                                                                                                          Appendix A
                                                                                            Introduction to the User Migration Utility




Table A-3        Effects of Choosing Shared Schema Mapping with CASCADE Options

MAPSCHEMA                          CASCADE                          User Migration                   User Schema
Parameter Setting                  Parameter Setting                Successful?                      Objects Dropped?
PRIVATE                            NO (default setting)             Yes                              No
SHARED                             NO                               Yes1                             No
SHARED                             YES                              Yes2                             Yes

1   Users migrate successfully only if they do not own objects in their old database schemas; otherwise, they fail.
2   Users migrate successfully, and their old database schemas are dropped.




                                See Also:
                                "User Migration Utility Parameters" for detailed information about the
                                MAPSCHEMA, CASCADE, and other parameters that can be used with this utility



A.2.4 Migration Process
                       Enterprise users are defined and managed in the directory and can be authenticated
                       to the database either with a password or with a certificate. Users who authenticate
                       with a password require an Oracle Database password, which is stored in the
                       directory. Users who authenticate with a certificate must have a valid X.509 v3
                       certificate.
                       This utility performs the following steps during migration:
                       1.   Selects the users from the database for migration.
                       2.   Creates corresponding user entries or uses existing entries in the directory.
                       3.   Creates new database passwords and copies the corresponding verifiers to the
                            directory for migrating users.
                       4.   Puts the schema mapping information for the migrating users' entries in the
                            directory. (optional)
                       5.   Drops or alters the migrating users' local database schemas. (optional)



                                     Note:
                                     In the current release, the utility migrates users with certificate-based
                                     authentication and makes them ready for password authentication.
                                     Previously, SSL-based authenticated users were required to reset their
                                     Oracle Database passwords. User wallets are not created as part of this
                                     process.




                                                                                                                                A-8
                                                                                                Appendix A
                                                                     Prerequisites for Performing Migration




                       See Also:
                       "Managing Oracle Wallets" for information about creating, managing, and
                       using Oracle wallets



A.3 Prerequisites for Performing Migration
           The User Migration Utility is automatically installed in the following location when you
           install Oracle Database Client:
           $ORACLE_HOME/rdbms/bin/umu

           The following sections describe what programs must be running and what user
           privileges are required to successfully migrate users with the User Migration Utility:
           •    Required Database Privileges
           •    Required Directory Privileges
           •    Required Setup to Run the User Migration Utility


A.3.1 Required Database Privileges
           To successfully use this utility, enterprise user administrators must have the following
           database privileges:
           •    ALTER USER
           •    DROP USER
           •    CREATE TABLE
           •    SELECT_CATALOG_ROLE
           These privileges enable the enterprise user administrator to alter users, drop users,
           look at dictionary views, and create the interface table that is used by this utility.


A.3.2 Required Directory Privileges
           In addition to the required database privileges, enterprise user administrators must
           have the directory privileges which allow them to perform the following tasks:
           •    Create entries in the directory under the specified user base and Oracle context
                location
           •    Browse the user entries under the search bases


A.3.3 Required Setup to Run the User Migration Utility
           Perform the following steps before using the User Migration Utility:
           1.   Ensure that the directory server is running with SSL enabled for no authentication.
           2.   Ensure that the database server is running with encryption and integrity enabled.
           3.   Ensure that the database listener has a TCP listening end point.
           4.   Create an identity management realm in the directory, if it does not already exist.



                                                                                                      A-9
                                                                                               Appendix A
                                                               User Migration Utility Command-Line Syntax


         5.   Create the parent context for the user entries in the directory, if it does not already
              exist. The default (and recommended) location is in the
              orclcommonusercreatebase subtree in the common container in the Oracle
              Context.
         6.   Set up directory access for the database Oracle home by using Oracle Net
              Configuration Assistant to create an ldap.ora file. Note that the ldap.ora file must
              include the identity management realm DN so the utility can locate the correct
              administrative context. The utility searches for this file
              under $LDAP_ADMIN, $ORACLE_HOME/ldap/admin, $TNS_ADMIN, $ORACLE_HOME/
              network/admin, and, finally, the Domain Name System (DNS) server, if you are
              using DNS discovery. (See Oracle Fusion Middleware Administrator's Guide for
              Oracle Internet Directory for information about DNS server discovery.)



                     Note:

                     •   If you plan to use shared schema mapping when migrating users,
                         then you must create the shared schema before running this utility.
                     •   The same ldap.ora file must be used for both Phase One and
                         Phase Two of a user migration.




                     See Also:

                     •   Enterprise User Security Configuration Tasks and Troubleshooting
                         for detailed information about setting up enterprise user
                         authentication after the user migration is finished
                     •   Oracle Fusion Middleware Administrator's Guide for Oracle Internet
                         Directory



A.4 User Migration Utility Command-Line Syntax
         To perform a bulk migration of database users to enterprise users, use the following
         syntax:
         umu parameter1 parameter2 ...

         For parameters that take a single value use the following syntax:
         keyword=value

         For parameters that take multiple values, use a colon (:) to separate the values as in
         the following syntax except for DBLOCATION parameter where, value of
         DATABASE_SERVICE_NAME is separated from value of DATABASE_PORT by using a slash
         (/):
         keyword=value1:value2:...

         Example A-1 shows the syntax used to run the utility through both phases of the bulk
         user migration process.




                                                                                                  A-10
                                                                                    Appendix A
                                                    User Migration Utility Command-Line Syntax




       Note:
       If the enterprise user administrator does not specify the mandatory
       parameters on the command line, then the utility will prompt the user for
       those parameters interactively.



       See Also:

       •   "User Migration Utility Parameters" for a complete list of all available
           parameters and detailed information about them
       •   "User Migration Utility Usage Examples" for examples of typical utility
           uses


Example A-1     User Migration Utility Command-Line Syntax
umu PHASE=ONE

DBADMIN=dba_username
ENTADMIN=enterprise_admin_DN
USERS=[ALL_GLOBAL | ALL_EXTERNAL | LIST | FILE]
DBLOCATION=database_host:database_port/database_service_name
DIRLOCATION=ldap_directory_host:ldap_directory_port
USERSLIST=username1:username2:username3:...
USERSFILE=filename
MAPSCHEMA=[PRIVATE | SHARED]:schema_name
MAPTYPE=[DB | DOMAIN]:[ENTRY | SUBTREE]
CASCADE=[YES | NO]
CONTEXT=user_entries_parent_location
LOGFILE=filename
PARFILE=filename
[DBALIAS=<db-password-alias>]
[ENTALIAS=<enterprise-password-alias>]
[WALLETLOCATION=<wallet-location>]
[KEYALIAS=<keystore-password-alias>]
[KEYSTORE=<keystore-location>]
KREALM=EXAMPLE.COM

umu PHASE=TWO

DBADMIN=dba_username
ENTADMIN=enterprise_admin_DN
DBLOCATION=database_host:database_port/database_service_name
DIRLOCATION=ldap_directory_host:ldap_directory_port
LOGFILE=filename
PARFILE=filename
[DBALIAS=<db-password-alias>]
[ENTALIAS=<enterprise-password-alias>]
[WALLETLOCATION=<wallet-location>]
[KEYALIAS=<keystore-password-alias>]
[KEYSTORE=<keystore-location>]




                                                                                       A-11
                                                                                                 Appendix A
                                                               Accessing Help for the User Migration Utility




A.5 Accessing Help for the User Migration Utility
          To display the command-line syntax for using the User Migration Utility, enter the
          following command at the system prompt:
          umu HELP=YES

          While the HELP parameter is set to YES, the utility cannot run.


A.6 User Migration Utility Parameters
          The following sections list the available parameter keywords and the values that can
          be used with them when running this utility. The keywords are not case-sensitive:
          •   Keyword: HELP
          •   Keyword: PHASE
          •   Keyword: DBLOCATION
          •   Keyword: DIRLOCATION
          •   Keyword: DBADMIN
          •   Keyword: ENTADMIN
          •   Keyword: USERS
          •   Keyword: USERSLIST
          •   Keyword: USERSFILE
          •   Keyword: KREALM
          •   Keyword: MAPSCHEMA
          •   Keyword: MAPTYPE
          •   Keyword: CASCADE
          •   Keyword: CONTEXT
          •   Keyword: LOGFILE
          •   Keyword: PARFILE
          •   Keyword: DBALIAS
          •   Keyword: ENTALIAS
          •   Keyword: WALLETLOCATION
          •   Keyword: KEYALIAS
          •   Keyword: KEYSTORE


A.6.1 Keyword: HELP
          Attribute             Description
          Valid Values:         YES or NO (These values are not case-sensitive.)
          Default Setting:      NO




                                                                                                     A-12
                                                                                                Appendix A
                                                                          User Migration Utility Parameters




          Attribute          Description
          Syntax Examples:   HELP=YES
          Description:       This keyword is used to display Help for the utility. YES displays the
                             complete command-line syntax. To run a command, set the value to NO,
                             or do not specify a value for the parameter to accept the default.
          Restrictions:      None


A.6.2 Keyword: PHASE
          Attribute          Description
          Valid Values:      ONE or TWO (These values are not case-sensitive.)
          Default Setting:   ONE
          Syntax Examples:   PHASE=ONE
                             PHASE=TWO
          Description:       Indicates the phase for the utility. If it is ONE, then the utility populates
                             the interface table with the information specified in the command-line
                             arguments and the existing user entries in the directory. If it is TWO, then
                             the utility uses the information that is available in the interface table and
                             updates the directory and the database.
          Restrictions:      None


A.6.3 Keyword: DBLOCATION
          Attribute          Description
          Valid Values:      host:port/service_name
          Default Setting:   No default setting
          Syntax Examples:   DBLOCATION=my_oracle.us.example.com:7777/ora902
          Description:       Provides the host name, port number, and SERVICE_NAME for the
                             database instance
          Restrictions:      •     This parameter is mandatory.
                             •     The value for this parameter must be the same for both Phase One
                                   and Phase Two.
                             •     The database should be configured for encryption and integrity.


A.6.4 Keyword: DIRLOCATION
          Attribute          Description
          Valid Values:      host:port
          Default Setting:   This value is automatically populated from the ldap.ora file by default.
          Syntax Examples:   DIRLOCATION=my_oracle.us.example.com:636
          Description:       Provides the host name and port number for the directory server where
                             the LDAP server is running on SSL with no authentication




                                                                                                    A-13
                                                                                                Appendix A
                                                                         User Migration Utility Parameters




          Attribute          Description
          Restrictions:      The value for this parameter must be the same for both Phase One and
                             Phase Two.


A.6.5 Keyword: DBADMIN
          Attribute          Description
          Valid Values:      username
          Default Setting:   No default setting
          Syntax Examples:   DBADMIN=system
          Description:       User name for the database administrator with the required privileges
                             for connecting to the database.
          Restrictions:      •   This parameter is mandatory.
                             •   The username value for this parameter must be the same for both
                                 Phase One and Phase Two.


A.6.6 Keyword: ENTADMIN
          Attribute          Description
          Valid Values:      userDN
          Default Setting:   No default setting
          Syntax Examples:   ENTADMIN=cn=janeadmin,dc=acme,dc=com
          Description:       User Distinguished Name (UserDN) for the enterprise directory
                             administrator with the required privileges for logging in to the directory.
                             UserDN can also be specified within double quotation marks ("").
          Restrictions:      This parameter is mandatory.


A.6.7 Keyword: USERS
          Attribute          Description
          Valid Values:      value1:value2...
                             Values can be:
                             •   ALL_EXTERNAL to select all external users, including those who
                                 use Kerberos and RADIUS authentication
                             •   ALL_GLOBAL to select all global users
                             •   LIST to specify users on the command line with "Keyword:
                                 USERSLIST"
                             •   USERSFILE for selecting users from the file that is specified with
                                 the "Keyword: USERSFILE"
                             This parameter takes multiple values. Separate values with a colon (:).
                             (These values are not case-sensitive.)
          Default Setting:   No default setting




                                                                                                   A-14
                                                                                                Appendix A
                                                                         User Migration Utility Parameters




          Attribute          Description
          Syntax Examples:   •   USERS=ALL_EXTERNAL:ALL_GLOBAL
                                 This usage instructs the utility to migrate all external users and all
                                 global users.
                             •   USERS=ALL_EXTERNAL:FILE
                                 This usage instructs the utility to migrate all external users and all
                                 users specified in USERSFILE.
          Description:       Specifies which users are to be migrated. If multiple values are
                             specified for this parameter, then the utility uses the union of these sets
                             of users.
          Restrictions:      This parameter is mandatory for Phase One only, and it is ignored in
                             Phase Two.


A.6.8 Keyword: USERSLIST
          Attribute          Definition
          Valid Values:      user1:user2:...
                             Separate user names with a colon (:).
          Default Setting:   No default setting
          Syntax Examples:   USERSLIST=jdoe:tchin:adesai
          Description:       Specifies a list of database users for migration. The users in this list are
                             migrated with other users specified with the USERS parameter.
          Restrictions:      This optional parameter is effective only when LIST is specified with
                             the USERS parameter.


A.6.9 Keyword: USERSFILE
          Attribute          Definition
          Valid Values:      File name and path
          Default Setting:   No default setting
          Syntax Examples:   USERSFILE=/home/orahome/userslist/hr_users.txt
          Description:       Specifies a file that contains a list of database users (one user listed for
                             each line) for migration. The users in this file are migrated with other
                             users specified with the USERS parameter.
          Restrictions:      This optional parameter is effective only when FILE is specified with
                             the USERS parameter.


A.6.10 Keyword: KREALM
          Attribute          Description
          Valid Values:      kerberos realm
          Default Setting:   No default setting
          Syntax Examples:   KREALM=EXAMPLE.COM




                                                                                                   A-15
                                                                                             Appendix A
                                                                       User Migration Utility Parameters




          Attribute          Description
          Description:       Kerberos REALM for external kerberos users, which will usually be the
                             domain name of the database server.If this parameter is not specified,
                             then all external users who are considered for migration are assumed
                             to be non-Kerberos.
          Restrictions:      •   This parameter is valid only for Phase One.


A.6.11 Keyword: MAPSCHEMA
          Attribute          Description
          Valid Values:      schema_type:schema_name
                             Schema type can be:
                             •   PRIVATE
                                 Retains users' old local schemas. Schema name is ignored when
                                 schema type is PRIVATE. No mapping entries are created in the
                                 directory.
                             •   SHARED
                                 Maps users to a shared schema. Mapping entries are created in
                                 the directory. Schema name specifies the shared schema name.
                                 During shared schema mapping, whether users' local schemas are
                                 dropped from the database is determined by the "Keyword:
                                 CASCADE" setting.
                             (These values are not case-sensitive.)
          Default Setting:   PRIVATE
          Syntax Examples:   MAPSCHEMA=SHARED:HR_ALL
          Description:       Specifies whether the utility populates the interface table with schema
                             mapping information.
          Restrictions:      •   See the SHARED option under Valid Values.
                             •   This parameter is valid only for Phase One.


A.6.12 Keyword: MAPTYPE
          Attribute          Description
          Valid Values:      mapping_type:mapping_level
                             Mapping type can be:
                             •  DB
                             •  DOMAIN
                             Mapping level can be:
                             •  ENTRY
                             •  SUBTREE
                             Separate mapping type from mapping level with a colon (:).
                             (These values are not case-sensitive.)
          Default Setting:   DB:ENTRY
          Syntax Examples:   MAPTYPE=DOMAIN:SUBTREE




                                                                                                 A-16
                                                                                                   Appendix A
                                                                             User Migration Utility Parameters




          Attribute               Description
          Description:            Specifies the type of schema mapping that is to be applied when
                                  "Keyword: MAPSCHEMA" is set to SHARED. If DB is specified as the
                                  mapping type, then the utility creates a mapping in the directory for the
                                  database. If DOMAIN is specified as the mapping type, then the utility
                                  creates a mapping in the directory for the domain containing the
                                  database. For domain mapping, the utility determines the domain that
                                  contains the database by an LDAP search in the relevant Oracle
                                  context.
          Restrictions:           This parameter is effective only when MAPSCHEMA is set to SHARED.




                See Also:
                "About Using the SUBTREE Mapping Level Option" for more information
                about using this mapping level option



A.6.13 Keyword: CASCADE
          Attribute               Description
          Valid Values:           •    NO
                                       When users are mapped to a shared schema, the utility tries to
                                       drop their local schemas from the database. If this parameter is set
                                       to NO, then users are migrated only if they do not own objects in
                                       their local schema. Users who own objects in their old local
                                       schemas do not migrate. An error message is logged in the
                                       migration log file for such users.
                                  •    YES
                                      If this parameter is set to YES, then all users' schema objects are
                                      dropped along with their local schemas when they are migrated.
                                      Privileges and roles that were previously granted to the users are
                                      also revoked.
                                  (These values are not case-sensitive.)
          Default Setting:        NO
          Syntax Examples:        CASCADE=YES
          Description:            Specifies whether a user's local schema is dropped when the user is
                                  mapped to a shared schema
          Restrictions:           This parameter is effective only when MAPSCHEMA is set to SHARED.


A.6.14 Keyword: CONTEXT
          Attribute Description
          Valid       Distinguished Name (DN) of the parent for user entries. This is the same as the
          Values:     user search base or user create base in an Oracle Internet Directory identity
                      management realm.
                      Parent DN can also be specified within double quotation marks ("").




                                                                                                       A-17
                                                                                                    Appendix A
                                                                              User Migration Utility Parameters




          Attribute Description
          Default     Value set in orclCommonUserCreateBase attribute under cn=Common of Oracle
          Setting:    Context
                      Refer to Figure 1-3 for a directory information tree diagram that shows an Oracle
                      Context.
          Syntax  CONTEXT="c=Users, c=us"
          Example
          s:
          Descripti Specifies the DN of the parent entry under which user entries are created in the
          on:       directory if there is no directory entry that matches the userID for the user
          Restricti This parameter is valid only for phase one.
          ons:


A.6.15 Keyword: LOGFILE
          Attribute               Description
          Valid Values:           File name and path
          Default Setting:        $ORACLE_HOME/network/log/umu.log
          Syntax Examples:        LOGFILE=home/orahome/network/log/filename.log
          Description:            Specifies the log file where details about the migration for each user are
                                  written
          Restrictions:           None


A.6.16 Keyword: PARFILE
          Attribute               Description
          Valid Values:           File name and path
          Default Setting:        No default setting
          Syntax Examples:        PARFILE=home/orahome/network/usr/par.txt
          Description:            Specifies a text file containing a list of parameters intended for use in a
                                  user migration. Each parameter must be listed on a separate line in the
                                  file. If a parameter is specified both in the parameter file and on the
                                  command line, then the one specified on the command line takes
                                  precedence.
          Restrictions:           None


A.6.17 Keyword: DBALIAS
          The Database administrator password alias name for the DBADMIN user name.


          Attribute               Description
          Valid Values:           db-password-alias
          Default Setting:        No default setting
          Syntax Examples:        DBALIAS=<db-password-alias>




                                                                                                        A-18
                                                                                                  Appendix A
                                                                            User Migration Utility Parameters




          Attribute             Description
          Description:          Alias for the DBADMIN database administrator password.
          Restrictions:         This parameter is optional.


A.6.18 Keyword: ENTALIAS
          The Enterprise administrator password alias name for the ENTADMIN user name.


          Attribute             Description
          Valid Values:         enterprise-password-alias
          Default Setting:      No default setting
          Syntax Examples:      ENTALIAS=<enterprise-password-alias>
          Description:          Alias for the ENTADMIN enterprise administrator password
          Restrictions:         This parameter is optional.


A.6.19 Keyword: WALLETLOCATION
          The directory specification for the location of the wallet also known as the secure
          external password store.


          Attribute             Description
          Valid Values:         wallet-location
          Default Setting:      No default setting
          Syntax Examples:      [WALLETLOCATION=<wallet-location>]
          Description:          Directory specification of the wallet location for the secure external
                                password store.
          Restrictions:         •   This parameter is optional.
                                •   The value for this parameter must be the same for both Phase One
                                    and Phase Two.


A.6.20 Keyword: KEYALIAS
          The keystore password alias name.


          Attribute                       Description
          Valid Values:                   keystore-password-alias
          Default Setting:                No default setting
          Syntax Examples:                KEYALIAS=<keystore-password-alias>
          Description:                    Alias for the KEYSTORE password.
          Restrictions:                   This parameter is optional.




                                                                                                         A-19
                                                                                                   Appendix A
                                                                        User Migration Utility Usage Examples




A.6.21 Keyword: KEYSTORE
           The directory specification of the location for the keystore.


           Attribute                       Description
           Valid Values:                   keystore-location
           Default Setting:                No default setting
           Syntax Examples:                KEYSTORE=<keystore-location>
           Description:                    Directory specification of the location for the keystore.
           Restrictions:                   This parameter is mandatory.



A.7 User Migration Utility Usage Examples
           The following sections contain examples of the syntax for some typical uses of this
           utility:
           •   Migrating Users While Retaining Their Own Schemas
           •   Migrating Users and Mapping to a Shared Schema
           •   Migrating Users Using the PARFILE, USERSFILE, and LOGFILE Parameters


A.7.1 Migrating Users While Retaining Their Own Schemas
           To migrate users while retaining their old database schemas, set the MAPSCHEMA
           parameter to PRIVATE, which is the default setting. For example, to migrate users
           scott1, scott2, and all external database users, retaining their old schemas, to the
           directory at c=Users, c=us with the newly generated database and directory
           passwords, use the syntax shown in Example A-2.
           The following example assumes that you have stored the DBADMIN and ENTADMIN user
           credentials in the wallet using the syntax <alias, username, password>. For
           example, as dbadmin1, sysman, password and entadmin1, entman, password. See
           Step 0: About Using a Secure External Password Store for more information.



                  Note:
                  All external users being migrated are considered non-Kerberos by default.
                  For existing Kerberos users, you can have the utility set their Kerberos
                  principal name attribute in Oracle Internet Directory after migration. To do
                  this, specify the KREALM parameter on the command line by using the
                  Kerberos REALM value. For example, if the Kerberos REALM value is
                  EXAMPLE.COM, then you would enter KREALM=EXAMPLE.COM. Once you do this,
                  those users with names of the form user@kerberos_realm are considered
                  Kerberos users. In Oracle Internet Directory, their Kerberos principal names
                  are set by using their database user names.
                  See Also: Keyword: KREALM




                                                                                                       A-20
                                                                                              Appendix A
                                                                   User Migration Utility Usage Examples


          Example A-2     Migrating Users with MAPSCHEMA=PRIVATE (Default)
          umu PHASE=ONE

          DBLOCATION=machine1:1521/ora_service_name
          DBADMIN=system
          USERS=ALL_EXTERNAL:LIST
          USERSLIST=scott1:scott2
          DIRLOCATION=machine2:636
          CONTEXT="c=Users,c=us"
          ENTADMIN="cn=janeadmin"
          DBALIAS=dbadmin1
          ENTALIAS=entadmin1
          WALLETLOCATION=/oracle/product/db_1/wallets
          KEYALIAS=keystore1
          KEYSTORE=/oracle/product/db_1/wallets

          umu PHASE=TWO

          DBLOCATION=machine1:1521/ora_service_name
          DBADMIN=system
          DIRLOCATION=machine2:636
          ENTADMIN="cn=janeadmin"
          DBALIAS=dbadmin1
          ENTALIAS=entadmin1
          WALLETLOCATION=/oracle/product/db_1/wallets
          KEYALIAS=keystore1
          KEYSTORE=/oracle/product/db_1/wallets

          After Phase One is completed successfully, the interface table is populated with the
          user migration information. Then, the enterprise user administrator can review the
          table to confirm its contents. Because no value was specified for the MAPSCHEMA
          parameter, the utility runs Phase One using the default value, PRIVATE, so all users'
          old database schemas and objects are retained.


A.7.2 Migrating Users and Mapping to a Shared Schema
          To migrate users and map them to a new shared schema, dropping their old database
          schemas, set the MAPSCHEMA parameter to SHARED. The shared schema must already
          exist, or the enterprise user administrator must create it before running the utility with
          this parameter setting. In the following example, users scott1, scott2, and all external
          database users are migrated to the directory at c=Users, c=us with newly generated
          database and directory passwords, while mapping all migrated users to a new shared
          schema in the database.
          The following example assumes that you have stored the DBADMIN and ENTADMIN user
          credentials in the wallet using the syntax <alias, username, password>. For
          example, as dbadmin1, sysman, password and entadmin1, entman, password. See
          Step 0: About Using a Secure External Password Store for more information.
          Use the syntax shown in Example A-3 to run the migration process with MAPSCHEMA set
          to SHARED.

          Example A-3     Migrating Users with MAPSCHEMA=SHARED
          umu PHASE=ONE

          DBLOCATION=machine1:1521/ora_service_name
          DBADMIN=system




                                                                                                 A-21
                                                                                               Appendix A
                                                                    User Migration Utility Usage Examples


             USERS=ALL_EXTERNAL:LIST
             USERSLIST=scott1:scott2
             MAPSCHEMA=SHARED:schema_32
             DIRLOCATION=machine2:636
             CONTEXT="c=Users, c=us"
             ENTADMIN="cn=janeadmin"
             DBALIAS=dbadmin1
             ENTALIAS=entadmin1
             WALLETLOCATION=/oracle/product/db_1/wallets
             KEYALIAS=keystore1
             KEYSTORE=/oracle/product/db_1/wallets


             umu PHASE=TWO

             DBLOCATION=machine1:1521/ora_service_name
             DBADMIN=system
             DIRLOCATION=machine2:636
             ENTADMIN="cn=janeadmin"
             DBALIAS=dbadmin1
             ENTALIAS=entadmin1
             WALLETLOCATION=/oracle/product/db_1/wallets
             KEYALIAS=keystore1
             KEYSTORE=/oracle/product/db_1/wallets

             After Phase One is completed successfully, the interface table is populated with the
             user migration information. Then, the administrator can review the table to confirm its
             contents. Users scott1, scott2, and the external users are assigned new randomly
             generated database and directory passwords. Because no value was specified for the
             CASCADE parameter, the utility runs Phase One using the default value, NO, which
             means that migrating users who own database objects in their old database schemas
             will fail and their schemas will not be automatically dropped. To determine which users
             have failed, review the log file that is located at $ORACLE_HOME/network/log/umu.log
             by default.
             See the following sections for more information:
             •   Mapping Users to a Shared Schema Using Different CASCADE Options
             •   Mapping Users to a Shared Schema Using Different MAPTYPE Options

A.7.2.1 Mapping Users to a Shared Schema Using Different CASCADE
Options
             The CASCADE parameter setting determines whether users' old database schemas are
             automatically dropped when mapping to a shared schema during migration. CASCADE
             can be used only when MAPSCHEMA is set to SHARED.

             This section describes the following topics:
             •   Mapping Users to a Shared Schema with CASCADE=NO
             •   Mapping Users to a Shared Schema with CASCADE=YES

A.7.2.1.1 Mapping Users to a Shared Schema with CASCADE=NO
             By default, the CASCADE parameter is set to NO. This setting means that when mapping
             migrating users to a shared schema, users who own database objects in their old
             schemas are not migrated. For users who do not own database objects, their old




                                                                                                  A-22
                                                                                                Appendix A
                                                                     User Migration Utility Usage Examples


             database schemas are automatically dropped, and they are mapped to the new
             shared schema.



                    See Also:
                    Example A-3 for a syntax example to map users to a shared schema with
                    CASCADE set to NO. Note that because NO is the default setting for CASCADE,
                    this parameter does not have to be specified in the utility command syntax



A.7.2.1.2 Mapping Users to a Shared Schema with CASCADE=YES
             If it is known that no migrating users own database objects or want to retain the
             objects that they own in their old database schemas, then setting the CASCADE
             parameter to YES automatically drops all users' schemas and schema objects and
             maps them to the new shared schema. Example A-4 shows the syntax to use when
             setting CASCADE to YES. In this example, users scott1, scott2, and all external
             database users are migrated to the directory at c=Users, c=us, while mapping all
             migrating users to a new shared schema in the database.
             The following example assumes that you have stored the DBADMIN and ENTADMIN user
             credentials in the wallet using the syntax <alias, username, password>. For
             example, as dbadmin1, sysman, password and entadmin1, entman, password. See
             Step 0: About Using a Secure External Password Store for more information.



                    Note:
                    If you set the CASCADE parameter to YES, then Oracle recommends that
                    enterprise user administrators back up the database or take an export dump
                    of the users being migrated before running this utility. Then, if migrated users
                    want their old database objects, then they can retrieve them from the export
                    dump.



             Example A-4 Migrating Users with Shared Schema Mapping and
             CASCADE=YES
             umu PHASE=ONE

             DBLOCATION=machine1:1521/ora_service_name
             DBADMIN=system
             USERS=ALL_EXTERNAL:LIST
             USERSLIST=scott1:scott2
             MAPSCHEMA=SHARED:schema_32
             CASCADE=YES
             DIRLOCATION=machine2:636
             CONTEXT="c=Users, c=us"
             ENTADMIN="cn=janeadmin"
             DBALIAS=dbadmin1
             ENTALIAS=entadmin1
             WALLETLOCATION=/oracle/product/db_1/wallets
             KEYALIAS=keystore1
             KEYSTORE=/oracle/product/db_1/wallets




                                                                                                   A-23
                                                                                               Appendix A
                                                                    User Migration Utility Usage Examples



            umu PHASE=TWO

            DBLOCATION=machine1:1521/ora_ervice_name
            DBADMIN=system
            DIRLOCATION=machine2:636
            ENTADMIN="cn=janeadmin"
            DBALIAS=dbadmin1
            ENTALIAS=entadmin1
            WALLETLOCATION=/oracle/product/db_1/wallets
            KEYALIAS=keystore1
            KEYSTORE=/oracle/product/db_1/wallets

            After Phase One is completed successfully, the interface table is populated with the
            user migration information. Then, the administrator can review the table to confirm its
            contents. Because the CASCADE parameter is set to YES, all migrated users' old
            database schemas are automatically dropped, including those who own database
            objects.

A.7.2.2 Mapping Users to a Shared Schema Using Different MAPTYPE
Options
            When MAPSCHEMA is set to SHARED, the mapping type can be set by specifying a value
            for the MAPTYPE parameter. This parameter takes two values, which are mapping type
            and mapping level.
            Mapping type can be set at DB, for database, or DOMAIN, for enterprise domain. When
            mapping type DB is specified, the mapping is applied only to the database where the
            shared schema is stored. When DOMAIN is specified as the mapping type, the mapping
            is applied to the enterprise domain that contains the database where the shared
            schema is stored and also applies to all databases in that domain.
            Mapping level can be set to ENTRY or SUBTREE. When ENTRY is specified, users are
            mapped to the shared schema using their full distinguished name (DN). This results in
            one mapping for each user. When SUBTREE is specified, groups of users who share
            part of their DNs are mapped together. This results in one mapping for user groups
            already grouped under some common root in the directory tree. Example A-5 shows
            the syntax to use when using the MAPTYPE parameter. In this example, users scott1,
            scott2, and all external database users are migrated to the directory at c=Users,
            c=us, while mapping all migrated users to a new shared schema in the database. In
            this example, the mapping will apply to the enterprise domain that contains the
            database, and the mapping will be performed at the entry level, resulting in a mapping
            for each user.
            The following example assumes that you have stored the DBADMIN and ENTADMIN user
            credentials in the wallet using the syntax <alias, username, password>. For
            example, as dbadmin1, sysman, password and entadmin1, entman, password. See
            Step 0: About Using a Secure External Password Store for more information.
            Example A-5 Migrating Users with Shared Schema Mapping Using the
            MAPTYPE Parameter
            umu PHASE=ONE

            DBLOCATION=machine1:1521/ora_service_name
            DBADMIN=system
            USERS=ALL_EXTERNAL:LIST




                                                                                                  A-24
                                                                                               Appendix A
                                                                    User Migration Utility Usage Examples


             USERSLIST=scott1:scott2
             MAPSCHEMA=SHARED:schema_32
             MAPTYPE=DOMAIN:ENTRY
             DIRLOCATION=machine2:636
             CONTEXT="c=Users, c=us"
             ENTADMIN="cn=janeadmin"
             DBALIAS=dbadmin1
             ENTALIAS=entadmin1
             WALLETLOCATION=/oracle/product/db_1/wallets
             KEYALIAS=keystore1
             KEYSTORE=/oracle/product/db_1/wallets


             umu PHASE=TWO

             DBLOCATION=machine1:1521/ora_service_name
             DBADMIN=system
             DIRLOCATION=machine2:636
             ENTADMIN="cn=janeadmin"
             DBALIAS=dbadmin1
             ENTALIAS=entadmin1
             WALLETLOCATION=/oracle/product/db_1/wallets
             KEYALIAS=keystore1
             KEYSTORE=/oracle/product/db_1/wallets


             See the following section for more information: About Using the SUBTREE Mapping
             Level Option.

A.7.2.2.1 About Using the SUBTREE Mapping Level Option
             If a user (scott, for example) who is being migrated will have future user entries in a
             subtree under it, then it makes sense to create a subtree level mapping from this user
             entry (cn=scott) to a schema. However, the database does not interpret the user to be
             in the subtree so the mapping does not apply to scott himself. For example, if you are
             migrating the user scott with the DN cn=scott,o=acme, and you choose SUBTREE as
             the mapping level when you run the utility, then a new mapping is created from
             cn=scott,o=acme to the shared schema, but the user scott is not mapped to that
             schema. Only new users who are created under the scott directory entry are mapped
             to the shared schema. Consequently, the SUBTREE mapping level should only be
             specified when user directory entries are placed under other user directory entries,
             which would be an unusual directory configuration.
             If you want an arbitrary subtree user to be mapped to a single shared schema with
             only one mapping entry, then you must use Oracle Enterprise Manager to create that
             mapping.



                    See Also:
                    "Creating User-Schema Mappings for an Enterprise Domain" for information
                    about using Oracle Enterprise Manager




                                                                                                  A-25
                                                                                              Appendix A
                                                                   User Migration Utility Usage Examples




A.7.3 Migrating Users Using the PARFILE, USERSFILE, and
LOGFILE Parameters
          It is possible to enter user information and User Migration Utility parameters into a text
          file and pass the information and parameters to the utility using the PARFILE and
          USERSFILE parameters. The LOGFILE parameter sets the directory path for the log file
          where details about the migration for each user are written.
          The PARFILE parameter tells the utility where a text file is located that contains the
          parameters for a bulk user migration. The USERSFILE parameter works like the PARFILE
          parameter, except that it contains database users instead of parameters. The
          parameters and users lists contain one parameter or user for each line. The LOGFILE
          parameter tells the utility where to write the system events that occur during a user
          migration, such as errors. Use the USERSFILE parameter during Phase One of the
          migration process. The PARFILE and LOGFILE parameters can be used in both phases.

          Example A-6 shows the syntax for a typical parameter text file to migrate users
          scott1, scott2, and all external database users, while retaining their old schemas, to
          the directory at c=Users, c=us. In this example, a log of migration events is written to
          the file errorfile1 in the directory where the utility is run. If another location is
          desired, then include the path with the file name.
          The following example assumes that you have stored the DBADMIN and ENTADMIN user
          credentials in the wallet using the syntax <alias, username, password>. For
          example, as dbadmin1, sysman, password and entadmin1, entman, password. See
          Step 0: About Using a Secure External Password Store for more information.



                 Note:
                 Although the LOGFILE parameter is specified twice, once in the parameter
                 text file as errorfile1 (shown in Example A-6) and once on the command
                 line as errorfile2 (shown in Example A-8), command-line parameters take
                 precedence over those specified inside the parameter file. Consequently, in
                 Example A-8, the log file will be written to errorfile2 because that value is
                 specified on the command line.



          Example A-6     Parameter Text File (par.txt) to Use with the PARFILE Parameter
          DBLOCATION=machine1:1521/ora_service_name
          DBADMIN=system
          USERS=ALL_EXTERNAL:LIST:FILE
          USERSLIST=scott1:scott2
          USERSFILE=usrs.txt
          DIRLOCATION=machine2:636
          CONTEXT="c=Users, c=us"
          ENTADMIN="cn=janeadmin"
          DBALIAS=dbadmin1
          ENTALIAS=entadmin1
          WALLETLOCATION=/oracle/product/db_1/wallets
          KEYALIAS=keystore1
          KEYSTORE=/oracle/product/db_1/wallets
          LOGFILE=errorfile1




                                                                                                 A-26
                                                                                                 Appendix A
                                                            Troubleshooting Using the User Migration Utility


           Example A-7 shows the syntax for a typical users list text file.
           Example A-7      Users List Text File (usrs.txt) to Use with the USERSFILE
           Parameter
           user1
           user2
           user3

           To run Phase One of the migration process with these parameters and users list text
           files, use the syntax shown in Example A-8.
           Example A-8      Migrating Users Using the PARFILE, USERSFILE, and LOGFILE
           Parameters
           umu PHASE=ONE

           DBADMIN=system
           DBALIAS=dbadmin1
           WALLETLOCATION=/oracle/product/db_1/wallets
           PARFILE=par.txt
           LOGFILE=errorfile2


A.8 Troubleshooting Using the User Migration Utility
           Migration failures are reported to the enterprise user administrator with error
           messages and log messages. The following sections describe common error and log
           messages and what administrators can do to resolve them:
           •   Common User Migration Utility Error Messages
           •   Common User Migration Utility Log Messages
           •   Summary of User Migration Utility Error and Log Messages
           •   Tracing for UMU



                   See Also:
                   "Summary of User Migration Utility Error and Log Messages" for an
                   alphabetical listing of error and log messages and links to where they are
                   described in this section



A.8.1 Common User Migration Utility Error Messages
           When the utility encounters any error while running, it displays an error message and
           stops running. The following sections describe these messages and explain how to
           resolve the errors:
           •   Resolving Error Messages Displayed for Both Phases
           •   Resolving Error Messages Displayed for Phase One
           •   Resolving Error Messages Displayed for Phase One




                                                                                                     A-27
                                                                                                  Appendix A
                                                             Troubleshooting Using the User Migration Utility




A.8.1.1 Resolving Error Messages Displayed for Both Phases
            The following error messages may be displayed while the utility is running either
            Phase One or Phase Two of the migration:
            •    Attribute value missing : : orclCommonNicknameAttribute
            •    Database connection failure
            •    Database error: < database_error_message >
            •    Database not in any domain : : DB-NAME = < database_name >
            •    Database not registered with the directory : : DB-NAME = < dbName >
            •    Directory connection failure
            •    Directory error : : < directory_error_message >
            •    Multiple entries found : : uniqueMember = < database_DN >

            Attribute value missing : : orclCommonNicknameAttribute
            Cause: The nickname attribute is not set in the directory in the root identity
            management realm.

            Action: Use Oracle Internet Directory Self-Service Console to set the nickname
            attribute for the identity management realm.

            Database connection failure
            Cause: The utility was unable to connect to the database.

            Action: Perform these steps:
            1.   Check the database status to determine whether it is configured for encryption
                 and integrity.
            2.   Check the privileges and credentials of the enterprise user administrator who is
                 running the utility.

            Database error: < database_error_message >
            Cause: The utility encountered a database error.

            Action: Check the database error message details for the database.



                    See Also:
                    Oracle Database Error Messages Reference for information about resolving
                    database error messages


            Database not in any domain : : DB-NAME = < database_name >
            Cause: The database is not a member of any enterprise domain.

            Action: Use Oracle Enterprise Manager to add the database to an enterprise domain
            in the directory.




                                                                                                      A-28
                                                                                                   Appendix A
                                                              Troubleshooting Using the User Migration Utility


            Database not registered with the directory : : DB-NAME = < dbName >
            Cause: There is no entry for the database in the Oracle Context that the ldap.ora file
            points to.

            Action: Use Database Configuration Assistant to register the database in the
            directory.

            Directory connection failure
            Cause: The utility was unable to connect to the directory.

            Action: Perform these steps:
            1.   Check the directory server status to determine whether the directory server port is
                 configured for SSL with no authentication.
            2.   Check the privileges and credentials of the enterprise user administrator who is
                 running the utility.

            Directory error : : < directory_error_message >
            Cause: The utility encountered a directory error.

            Action: Check the directory error message details for the directory.



                    See Also:
                    Oracle Fusion Middleware Administrator's Guide for Oracle Internet
                    Directory information about resolving error messages for Oracle Internet
                    Directory


            Multiple entries found : : uniqueMember = < database_DN >
            Cause: The database belongs to more than one enterprise domain in the directory.

            Action: Use Oracle Enterprise Manager to ensure that the database belongs to only
            one enterprise domain.

A.8.1.2 Resolving Error Messages Displayed for Phase One
            While the utility is running Phase One of the migration, syntax or other types of errors
            may occur. The following error messages may be displayed while the utility is running
            Phase One of the migration:
            •    Argument missing or duplicated : : < parameter >
            •    Database object missing : : SHARED-SCHEMA = <shared_schema_name >
            •    Error reading file : : < file_name > : : < io_error_message >
            •    Error reading file : : PARFILE = < file_name > : : < io_error_message>
            •    Getting local host name failed
            •    Interface table creation in SYS schema not allowed
            •    Invalid argument or value : : < argument >
            •    Invalid arguments for the phase
            •    Invalid value : : < user > [ USERSFILE ]




                                                                                                       A-29
                                                                                       Appendix A
                                                  Troubleshooting Using the User Migration Utility


•    Invalid value : : < user > [ USERSFILE ] { = = DBADMIN }
•    Invalid value : : < user > [ USERSLIST ]
•    Invalid value : : < user > [ USERSLIST ] { = = DBADMIN }
•    Logging failure : : < io_error_message >
•    No entry found : : CONTEXT = < context >

Argument missing or duplicated : : < parameter >
Cause: Syntax error. A parameter is missing or has been entered multiple times.

Action: Check the usage syntax.

Database object missing : : SHARED-SCHEMA = <shared_schema_name >
Cause: The shared schema is not present in the database.

Action: Create the shared schema.

Error reading file : : < file_name > : : < io_error_message >
Cause: Syntax error. The utility cannot read the file that contains the users list that is
specified in the USERSFILE parameter.

Action: Perform these steps:
1.   Check to ensure that the file exists.
2.   Check to ensure that the file has the correct permissions so the utility can read it.

Error reading file : : PARFILE = < file_name > : : < io_error_message>
Cause: Syntax error. The utility cannot read the file that contains the list of parameters
that is specified in the PARFILE parameter.

Action: Perform these steps:
1.   Check to ensure that the file exists.
2.   Check to ensure that the file has the correct permissions so the utility can read it.

Getting local host name failed
Cause: Syntax error. The utility is unable to read the local host name for the database
location or the directory location.

Action: Explicitly enter the host name information with the DBLOCATION and
DIRLOCATION parameters.



        See Also:

        •   "Keyword: DBLOCATION"
        •   "Keyword: DIRLOCATION"
        for information about how to use these parameters


Interface table creation in SYS schema not allowed
Cause: The interface table cannot be created in the SYS schema.




                                                                                           A-30
                                                                                      Appendix A
                                                 Troubleshooting Using the User Migration Utility


Action: Specify another user in the DBADMIN parameter.



       See Also:
       "Keyword: DBADMIN" for information about setting the DBADMIN parameter


Invalid argument or value : : < argument >
Cause: Syntax error. The argument name or value has been entered incorrectly.

Action: Check the usage syntax.



       See Also:

       •   "User Migration Utility Command-Line Syntax"
       •   "Accessing Help for the User Migration Utility"
       •   "User Migration Utility Parameters"
       for information about using the command-line syntax for this utility


Invalid arguments for the phase
Cause: Syntax error. This occurs when you have used a command-line argument that
is only intended for Phase One, but you are running Phase Two.

Action: Check the usage syntax.

Invalid value : : < user > [ USERSFILE ]
Cause: Syntax error. The user that is specified in this error message is invalid
because he is not a user in the database that is specified in the DBLOCATION
parameter.

Action: Remove the invalid user from the file that is specified with the USERSFILE
parameter.

Invalid value : : < user > [ USERSFILE ] { = = DBADMIN }
Cause: Syntax error. The file that is specified in the USERSFILE parameter contains the
user who is running the migration utility.

Action: Remove that user from the file.

Invalid value : : < user > [ USERSLIST ]
Cause: Syntax error. The user that is specified in this error message is invalid
because they are not a user in the database that is specified in the DBLOCATION
parameter.

Action: Remove the invalid user from the USERSLIST parameter.

Invalid value : : < user > [ USERSLIST ] { = = DBADMIN }
Cause: Syntax error. The USERSLIST parameter contains the user who is running the
migration utility.




                                                                                          A-31
                                                                                                    Appendix A
                                                               Troubleshooting Using the User Migration Utility


            Action: Remove that user from the USERSLIST parameter.

            Logging failure : : < io_error_message >
            Cause: Syntax error. The utility cannot find the log file or it cannot open the file to
            write to it.

            Action: Perform these steps:
            1.   Check to ensure that the log file exists.
            2.   Check to ensure that the log file has the correct permissions so the utility can
                 write information to it.

            No entry found : : CONTEXT = < context >
            Cause: The CONTEXT entry is not present in the directory.

            Action: Perform one of the following steps:
            •    Use the directory management tool or the LDAP command-line utility to create an
                 entry in the directory for the context value.
            •    Specify another valid context value.

A.8.1.3 Resolving Error Messages Displayed for Phase Two
            Most of the error messages that you encounter while running this utility occur in Phase
            One. After Phase One has completed successfully, and while Phase Two is running,
            the following error may occur:

            Database object missing : : TABLE = ORCL_GLOBAL_USR_MIGRATION_DATA
            Cause: The utility cannot find the interface table.

            Action: Perform one of the following steps:
            •    Run Phase One of the utility to create the interface table.
            •    Check to ensure that the user who is specified in the DBADMIN parameter is the
                 same user who was specified for that parameter for Phase One.


A.8.2 Common User Migration Utility Log Messages
            Typically, log messages are written to the log file for each user who is migrated,
            whether the user was migrated successfully or not. The following sections describe
            these messages and explain how to resolve the errors:
            •    Common Log Messages for Phase One
            •    Common Log Messages for Phase Two

A.8.2.1 Common Log Messages for Phase One
            While the utility is running Phase One of the migration, messages that indicate that a
            user's information has not been successfully populated in the interface table may be
            written to the log file. After the utility completes Phase One, review the log file to check
            for the following messages:
            •    Multiple entries found : : < nickname_attribute > = < username >
            •    No entry found : : < nickname_attribute > = < username > : : Entry found : DN = <
                 dn >



                                                                                                        A-32
                                                                                                Appendix A
                                                           Troubleshooting Using the User Migration Utility


           Multiple entries found : : < nickname_attribute > = < username >
           Cause: The nickname attribute matches multiple users or the user matches with
           multiple nickname attributes.

           Action: Resolve the multiple matches and run the utility again for the users whose log
           file entry displayed this message.

           No entry found : : < nickname_attribute > = < username > : : Entry found : DN =
           < dn >
           Cause: No entry was found for the nickname matching, but an entry already exists for
           the DN in the directory.

           Action: Specify a different DN for the user.

A.8.2.2 Common Log Messages for Phase Two
           While the utility is running Phase Two of the migration, messages that indicate that a
           user has not successfully migrated may be written to the log file. After the utility
           completes Phase Two, review the log file to check for the following messages:
           •   Attribute exists : : orclPassword
           •   Attribute value missing : : orclPassword
           •   Database object missing : : SHARED-SCHEMA = < shared_schema >
           •   Entry found : : DN = < user_DN >
           •   Invalid value : : <interface_table_column_name> = <
               interface_table_column_value >
           •   No entry found : : DN = < user_DN >

           Attribute exists : : orclPassword
           This message typically occurs with the message Invalid
           value::<column_name>=<column_value>.

           Cause: The entry already contains a value for the orclPassword attribute.

           Action: Check the DBPASSWORD_EXIST_FLAG column in the interface table for a T/F
           value that correctly reflects whether a database password exists for this user.

           Attribute value missing : : orclPassword
           This message typically occurs with the message Invalid
           value::<column_name>=<column_value>.

           Cause: The orclPassword attribute of this user's entry has a null value.

           Action: Check the DBPASSWORD_EXIST_FLAG column in the interface table for a T/F
           value that correctly reflects whether a database password exists for this user.

           Database object missing : : SHARED-SCHEMA = < shared_schema >
           Cause: The shared schema that was specified for this user does not exist in the
           database.

           Action: Perform one of the following steps:




                                                                                                    A-33
                                                                                                           Appendix A
                                                                      Troubleshooting Using the User Migration Utility


                   •   Check to ensure that the correct shared schema was specified for this user. If the
                       shared schema name was incorrectly specified, then edit the SHARED_SCHEMA
                       column of the interface table and run Phase Two of the utility for this user again.
                   •   Create the shared schema in the database and run Phase Two of the utility for
                       this user again.

                   Entry found : : DN = < user_DN >
                   This message typically occurs with the message Invalid
                   value::<column_name>=<column_value>.

                   Cause: An entry already exists for the specified user DN.

                   Action: Check the USERDN_EXIST_FLAG column in the interface table for a T/F value
                   that correctly reflects whether a user entry already exists in the directory for this DN.

                   Invalid value : : <interface_table_column_name> = <
                   interface_table_column_value >
                   Cause: The value in the interface table column for this user is invalid. Typically, this
                   message is accompanied by additional log messages for this user.

                   Action: Check to ensure that the correct value has been entered for this user.

                   No entry found : : DN = < user_DN >
                   This message typically occurs with the message Invalid
                   value::<column_name>=<column_value>.

                   Cause: The entry for the DN is missing in the directory.

                   Action: Check the USERDN_EXIST_FLAG column in the interface table for a T/F value
                   that correctly reflects whether a user entry already exists in the directory for this DN.


A.8.3 Summary of User Migration Utility Error and Log Messages
                   Table A-4 and Table A-5 list all of the error and log messages in alphabetical order
                   and provides links to the section in this chapter that describes the message and how
                   to resolve it.

Table A-4    Alphabetical Listing of User Migration Utility Error Messages

User Migration Utility Error Message                                                                        Phase
Argument missing or duplicated : : < parameter >                                                            1
Attribute value missing : : orclCommonNicknameAttribute                                                     Both
Database connection failure                                                                                 Both
Database error: < database_error_message >                                                                  Both
Database not in any domain : : DB-NAME = < database_name >                                                  Both
Database not registered with the directory : : DB-NAME = < dbName >                                         Both
Database object missing : : SHARED-SCHEMA = <shared_schema_name >                                           1
Database object missing : : TABLE = ORCL_GLOBAL_USR_MIGRATION_DATA                                          2
Directory connection failure                                                                                Both
Directory error : : < directory_error_message >                                                             Both




                                                                                                                A-34
                                                                                                              Appendix A
                                                                         Troubleshooting Using the User Migration Utility




Table A-4    (Cont.) Alphabetical Listing of User Migration Utility Error Messages

User Migration Utility Error Message                                                                           Phase
Error reading file : : < file_name > : : < io_error_message >                                                  1
Error reading file : : PARFILE = < file_name > : : < io_error_message>                                         1
Getting local host name failed                                                                                 1
Interface table creation in SYS schema not allowed                                                             1
Invalid argument or value : : < argument >                                                                     1
Invalid arguments for the phase                                                                                1
Invalid value : : < user > [ USERSFILE ]                                                                       1
Invalid value : : < user > [ USERSFILE ] { = = DBADMIN }                                                       1
Invalid value : : < user > [ USERSLIST ]                                                                       1
Invalid value : : < user > [ USERSLIST ] { = = DBADMIN }                                                       1
Logging failure : : < io_error_message >                                                                       1
Multiple entries found : : uniqueMember = < database_DN >                                                      Both
No entry found : : CONTEXT = < context >                                                                       1


Table A-5    Alphabetical Listing of User Migration Utility Log Messages

User Migration Utility Log Message                                                                             Phase
Attribute exists : : orclPassword                                                                              2
Attribute value missing : : orclPassword                                                                       2
Database object missing : : SHARED-SCHEMA = < shared_schema >                                                  2
Entry found : : DN = < user_DN >                                                                               2
Invalid value : : <interface_table_column_name> = < interface_table_column_value >                             2
Multiple entries found : : < nickname_attribute > = < username >                                               1
No entry found : : DN = < user_DN >                                                                            2
No entry found : : < nickname_attribute > = < username > : : Entry found : DN = < dn >                         1


A.8.4 Tracing for UMU
                   Describes how to set tracing for the UMU utility.
                   Setting the environment variable TRACE_UMU to any positive integer value before
                   executing the UMU utility enables the tracing for UMU. Trace messages are printed to
                   UMU output only and can be used for further diagnosis.




                                                                                                                   A-35
B
SSL External Users Conversion Script
      You should run the SSL external users conversion script after upgrading to Oracle
      Database 12c Release 1 (12.1) and later, in case you were using SSL-authenticated
      external users in a pre-Oracle Database 10g Release 2 (10.2) release. The script
      converts SSL-authenticated external users in pre-Oracle Database 10g Release 2
      (10.2) releases into SSL-authenticated external users in Oracle Database 12c Release
      1 (12.1) and later.



             Note:
             The SSL external users conversion script needs to be run only if you have
             upgraded from a pre-Oracle Database 10g Release 2 (10.2) release.



      About Using a Secure External Password Store
      If you want to use a secure external password store, then configure the Oracle wallet
      as described in the information that follows; otherwise, passwords can be provided
      interactively and you can skip this section.
      Before you run the extusrupgrade script, configure a client-side Oracle wallet as a
      secure external password store so that your applications can use password
      credentials stored in the wallet to connect to databases. Storing database password
      credentials in a client-side Oracle wallet eliminates the need to embed passwords in
      application code, batch jobs, or scripts. This reduces the risk of exposing passwords in
      the clear in scripts and application code, and allows you to more easily manage
      password policies for user accounts without changing application code or scripts
      whenever passwords change.
      See Configuring a Client to Use the External Password Store for steps to configure a
      client to use the external password store by using the mkstore command-line utility.



             Note:
             The external password store of the wallet is separate from the area where
             public key infrastructure (PKI) credentials are stored. Consequently, you
             cannot use Oracle Wallet Manager to manage credentials in the external
             password store of the wallet. Instead, use the command-line utility mkstore
             to manage these credentials.



      Using the mkstore CreateCredential command, configure the following dbuser
      credential by providing information for <alias, username, password>, in which you
      will be prompted to enter the password for the user:
      •   dbalias, dbuser, password




                                                                                           B-1
                                                                                              Appendix B
                                                          Using the SSL External Users Conversion Script


         Configuring this user credential allows you to use the following parameter on the
         extusrupgrade script command line:
         •   -dbalias=<db-password-alias>

         Conversion script examples use the following wallet credential information for user
         dbuser that was provided for the alias name, user name, and password. The wallet
         location is specified as shown.
         •   dbmanager1, system, password
         •   wallet_location=/oracle/product/db_1/wallets

         Conversion script examples use the following entries on the command-line:
         •   -dbalias=dbmanager1
         •   wallet_location=/oracle/product/db_1/wallets

         After configuring the client-side wallet, enable auto-login for Oracle Wallets to allow the
         administrator running the extusrupgrade script to access and perform extusrupgrade
         services without having to supply the necessary credentials.



                See Also:

                •   Managing the Secure External Password Store for Password Credentials
                    for more information about creating a client-side password store wallet to
                    store alias, user name, and password credentials for users
                •   About Using Auto Login for Oracle Wallets for information about enabling
                    auto login for Oracle wallets that enables PKI-based access to services
                    without requiring human intervention to supply the necessary user name
                    passwords required to run the extusrupgrade script


         This chapter covers the following topics:
         •   Using the SSL External Users Conversion Script
         •   Converting Global Users into External Users


B.1 Using the SSL External Users Conversion Script
         The SSL external users conversion script has the following syntax:
         $ORACLE_HOME/rdbms/bin/extusrupgrade
         --dbconnectstring database connect string
         --dbuser database user
         [-dbalias database user password alias]
         [-wallet_location wallet location]
         [-a]
         [-l username1,username2,...]
         [-f filename]
         [-o]
         [-h]
         note:          -a upgrade all qualified users
                        -l upgrade list of users seperated by comma
                        -f upgrade list of users specified by the file. One user name per line
                        -o output all qualified users to standard out. Not combine with other




                                                                                                   B-2
                                                                                     Appendix B
                                                 Using the SSL External Users Conversion Script


options
                -h show this help.

The database connect string should be in the format hostname:port_no:sid, where
hostname is the name of the host on which the database is running, port_no is the
listener port number and sid is the system identifier for the database instance.

If you have created a secure external password store using the mkstore command-line
utility, then create the dbuser credential in the wallet using the mkstore
CreateCredential command using the syntax <alias, username, password>. For
example, dbmanager1, system, password.

Next, enable auto login for Oracle wallets. This allows the administrator user running
the extusrupgrade script access toextusrupgrade services without having to supply
the necessary credentials.
Now you can use the database alias parameter -dbalias <database user password
alias> and the wallet location parameter -wallet_location <wallet location> on
the command line for running the extusrupgrade conversion script.

The following examples assume that the wallet has a dbuser credential defined using
the syntax <alias, username, password> as dbmanager1, system, password. For
examples, the wallet location is shown as /oracle/product/19.1.0/db_1/wallets.

Use the -a option to convert all SSL-authenticated external users. Here is an example:
extusrupgrade --dbconnectstring mymachine:1521:ORA001 --dbuser system -dbialis
dbmanager1 -wallet_location /oracle/product/db_1/wallets -a

Use the -l option to specify a comma-delimited list of users to be converted. For
example:
extusrupgrade --dbconnectstring mymachine:1521:ORA001 --dbuser system -dbialis
dbmanager1 -wallet_location /oracle/product/db_1/wallets -l user1,user2,user3

Use the -f option to specify a file that has the list of users to be converted. For
example:
extusrupgrade --dbconnectstring mymachine:1521:ORA001 --dbuser system -dbialis
dbmanager1 -wallet_location /oracle/product/db_1/wallets -f usernames.txt

There should be one user name in each line in the specified file. Here is a sample
usernames.txt file:
user#1
user>2
user,3
user4
user5

You must use the -f option to convert users who have special characters (such as #)
in their user names.




                                                                                          B-3
                                                                                             Appendix B
                                                             Converting Global Users into External Users




                 Note:
                 You can combine the -l and -f options in the same command. The script
                 combines the list of users from both the -l and -f options. If you use the -a
                 option along with the -l option and the -f option, then the -a option is
                 ignored.



         You can use the -o option to print a list of SSL-authenticated external users to the
         standard output device. The output lists the users you can convert using the
         extusrupgrade script. The -o option cannot be combined with any other option.
         extusrupgrade --dbconnectstring mymachine:1521:ORA001 --dbuser system -dbialis
         dbmanager1 -wallet_location /oracle/product/db_1/wallets -o

         A sample output for this could be:
         user1
         user2
         user3



                 Tip:
                 You can redirect the command output to a file to get a list of users who can
                 be converted. You can then edit the file and use it with the -f option.




B.2 Converting Global Users into External Users
         Oracle Database 10g and later allows SSL-authenticated external users and SSL-
         authenticated global users to coexist in the database. Previous releases had the
         restriction that all SSL users must be either global users or external users, depending
         on whether Oracle Internet Directory is being used or not for authenticating the users.
         If you want a user to be able to connect to the database even when Oracle Internet
         Directory is not available, then the user should be configured as an external user. You
         can convert SSL-authenticated global users into SSL-authenticated external users by
         using the SSL external users conversion script.
         If you have created a secure external password store using the mkstore command-line
         utility and have created the dbuser credential in the wallet using the mkstore
         CreateCredential command using the syntax <alias, username, password>. For
         example, dbmanager1, system, password. For examples, the wallet location is shown
         as /oracle/product/db_1/wallets. Now you can use the database alias parameter -
         dbalias <database user password alias> and the wallet location parameter -
         wallet_location <wallet location> on the command line when running the
         extusrupgrade conversion script. Note that if you have enabled auto login for Oracle
         wallets, then the administrator user running the extusrupgrade script can access
         extusrupgrade services without having to supply the necessary credentials.
         For example:
         extusrupgrade --dbconnectstring mymachine:1521:ORA001 --dbuser system -dbialis
         dbmanager1 -wallet_location /oracle/product/db_1/wallets -l user1,user2




                                                                                                   B-4
                                                                                 Appendix B
                                                 Converting Global Users into External Users


The preceding example converts two global users into external users.




                                                                                       B-5
C
Integrating Enterprise User Security with
Microsoft Active Directory
          This appendix lists the steps involved in integrating Enterprise User Security with
          Microsoft Active Directory using kerberos for authentication. It includes the following
          sections:
          •   About Direct Integration with Microsoft Active Directory
          •   Set Up Synchronization Between Active Directory and Oracle Internet Directory
          •   Set Up Active Directory to Interoperate with Oracle Client
          •   Set Up Oracle Database to Interoperate with Microsoft Active Directory
          •   Set Up Oracle Database Client to Interoperate with Microsoft Active Directory
          •   Obtain an Initial Ticket for the Client
          •   Configure Enterprise User Security for Kerberos Authentication


C.1 About Direct Integration with Microsoft Active Directory
          Oracle Database release 18c, version 18.1 and later supports direct integration with
          Microsoft Active Directory (MSAD) using the new centrally managed users capability.
          Beginning with Oracle Database release 18c, version 18.1, Oracle Database
          introduces centrally managed users to authenticate and authorize users directly with
          Microsoft Active Directory. With centrally managed users, users accessing the
          database can be centrally managed to improve an organization's security posture. An
          enterprise user (a user in Microsoft Active Directory) can be exclusively mapped to a
          database account, or many enterprise users (in an Microsoft Active Directory group)
          can be mapped to a shared account in the database. Microsoft Active Directory groups
          can also be mapped to a database global role, which provides users with additional
          privileges and roles above what their login account (exclusive or shared) is granted.
          With centrally managed users, users can be authenticated with passwords, and
          Kerberos and PKI certificates.
          For organizations beginning new directory services projects that do not require some
          of the more complex Enterprise User Security features like trusted database links,
          centrally managed users with Microsoft Active Directory allows you to use their current
          Microsoft Active Directory service as their centralized user management and
          centralized database access authorization. For new directory services projects, this
          may be the preferred option in implementing directory services as this reduces
          complexity as well as costs of operation in terms of maintenance and development.
          Enterprise users can also make use of Oracle Internet Directory, which is a part of the
          Oracle Identity Management infrastructure. If your organization uses a third party
          directory like Microsoft Active Directory to store and manage user entries, then you
          can integrate it with Oracle Internet Directory to manage Enterprise User Security. This
          may be your preferred option if your organization requires some of the more complex
          Enterprise User Security features like trusted database links.




                                                                                                C-1
                                                                                                   Appendix C
                                 Set Up Synchronization Between Active Directory and Oracle Internet Directory




                  See Also:
                  Oracle Database Security Guide for details about configuring centrally
                  managed users with Microsoft Active Directory.




C.2 Set Up Synchronization Between Active Directory and
Oracle Internet Directory
          Oracle components make use of Oracle Internet Directory for centralized security
          administration. Your organization might have a Microsoft Windows domain that uses
          Microsoft Active Directory for centralized administration. You should set up
          synchronization between Oracle Internet Directory and Microsoft Active Directory
          before you configure Enterprise User Security to work with Microsoft Active Directory.
          Synchronization profiles are used to synchronize the two directories. The profile
          contains configuration information required to synchronize the two directories. This
          includes direction of synchronization, mapping rules and formats, connection details of
          Microsoft Windows domain and the like. Mapping rules contain domain rules and
          attribute rules to map a domain and attributes in one directory to the other directory,
          optionally formatting the attributes.



                  See Also:
                  For step-by-step instructions on integrating Oracle Internet Directory with
                  Microsoft Active Directory, refer to the Oracle Identity Management
                  Integration Guide




C.3 Set Up Active Directory to Interoperate with Oracle
Client
          The following tasks must be performed on the Windows domain controller:
          1.   Create the Oracle Database Principal in Microsoft Active Directory.
               This creates a new user for the database in Microsoft Active Directory.
          2.   Use the okcreate command-line utility to automate the creation of the service
               principal keytab file.
               Beginning with Oracle Database 12c Release 2 (12.2), the okcreate utility
               provides for automation of service principal keytab creation on the Key Distribution
               Center (KDC) to create all service keytabs that setup requires. To use an Active
               Directory as a KDC, this requires the keytab file. If the Oracle client does not have
               a keytab file in the location specified by SQLNET.KERBEROS5_CONF, it uses a generic
               krb5.conf file. In this case, it detects realm and KDC settings from DNS. This
               utility takes input about the keytabs to create and output them to a specified
               location. The inputs taken are the service name (defaults to oracle) and a list of
               hostnames on which the database server is installed.




                                                                                                         C-2
                                                                                                    Appendix C
                                         Set Up Oracle Database to Interoperate with Microsoft Active Directory




                   See Also:
                   Oracle Database Security Guide for a detailed listing of the preceding steps.




C.4 Set Up Oracle Database to Interoperate with Microsoft
Active Directory
           The following task must be performed on the host computer where Oracle Database is
           installed:
           •    Update the sqlnet.ora file in the database with kerberos parameters



                   See Also:
                   Oracle Database Security Guide for a detailed description of the preceding
                   step.




C.5 Set Up Oracle Database Client to Interoperate with
Microsoft Active Directory
           The following steps must be performed on the Oracle kerberos client:
           1.   Create client kerberos configuration files
                The client kerberos configuration files refer to the Microsoft Active Directory as the
                kerberos KDC.
           2.   Specify kerberos parameters in the client sqlnet.ora file
                You can either manually update the file or use Oracle Net Manager utility.



                   See Also:
                   Oracle Database Security Guide for a detailed listing of the preceding steps.




C.6 Obtain an Initial Ticket for the Client
           Before a client can connect to the database, the client must request for an initial ticket.
           The initial ticket identifies the client as having the rights to ask for additional service
           tickets. An initial ticket is requested using the okinit command.




                                                                                                          C-3
                                                                                                 Appendix C
                                              Configure Enterprise User Security for Kerberos Authentication




                  See Also:
                  Oracle Database Security Guide for more details on requesting an initial
                  ticket with okinit.




C.7 Configure Enterprise User Security for Kerberos
Authentication
          To configure Enterprise User Security for Kerberos Authentication, use the following
          steps:
          1.   Register the database in Oracle Internet Directory
               You can use Database Configuration Assistant for registering the database.
          2.   Configure Enterprise User Security Objects in the database and Oracle Internet
               Directory
               Create global schemas and global roles in the database. Also create enterprise
               roles in the enterprise domain. Configure user schema mappings for the enterprise
               domain, add global database roles to enterprise roles and grant enterprise roles to
               enterprise users for database access.
          3.   Configure the enterprise domain to accept kerberos authentication
               Use Oracle Enterprise Manager to enable kerberos authentication for your
               enterprise domain.
          4.   Connect as kerberos authenticated enterprise user.
               Launch SQL*Plus and use the command, connect /@net_service_name to
               connect as a kerberos authenticated enterprise user.



                  See Also:
                  For detailed information on the preceding steps, refer to "Configuring
                  Enterprise User Security for Kerberos Authentication" .




                                                                                                       C-4
D
Upgrading from Oracle9i to Oracle
Database Release 18c Version 18.1
          This appendix discusses upgrading Oracle9i Database (9.2.0.8) to Oracle Database
          release 18c, version 18.1 with respect to Enterprise User Security. It includes the
          following sections:
          •    Upgrading Oracle Internet Directory from Release 9.2 to Release 9.0.4
          •    Upgrading Oracle Database from Release 9.2.0.8 to Oracle Database Release
               18c Version 18.1
          •    Upgrading Oracle Database from Release 10g (10.1) and Higher to Oracle
               Database Release 18c Version 18.1


D.1 Upgrading Oracle Internet Directory from Release 9.2 to
Release 9.0.4
          Oracle9i Database Release 2 can work with Oracle Internet Directory Release 9.2 or
          Release 9.0.4. Oracle Database 12c Release 1 (12.1) requires Oracle Internet
          Directory 9.0.4 or later. In case you are using Oracle Internet Directory Release 9.2,
          you need to upgrade it to Release 9.0.4.
          The following list discusses upgrading Oracle Internet Directory Release 9.2 to Oracle
          Internet Directory Release 9.0.4:
          1.   Use Oracle Internet Directory Configuration Assistant to upgrade Oracle Internet
               Directory. This is required if you want to register Oracle Database 12c Release 1
               (12.1) instances in the directory.
          2.   Upgrade Oracle Contexts used for Enterprise User Security to Identity
               Management Realms, if they are not root contexts. Use the Oracle Internet
               Directory Configuration Assistant command-line utility as follows:
               oidca mode=CTXTOIMR

               This step is required if you want to register an Oracle Database 12c Release 1
               (12.1) instance in a realm.
               You cannot use the root Oracle Context for Oracle Database 12c Release 1 (12.1)
               databases because it is not an Identity Management Realm.
          3.   Use Oracle Internet Directory tools, such as ldapmodify and bulkmodify, to add
               the orcluserV2 objectclass to existing user entries. This objectclass is required
               for users to change their database passwords, and for kerberos authentication to
               the database.
          4.   In a realm that contains both Oracle9i Database and Oracle Database 12c
               Release 1 (12.1), use a DAS-based tool in Oracle Internet Directory Release 9.0.4
               to create and manage users. You can use either Oracle Internet Directory Self-




                                                                                                D-1
                                                                                                 Appendix D
                 Upgrading Oracle Database from Release 9.2.0.8 to Oracle Database Release 18c Version 18.1


              Service Console or Enterprise Security Manager Console. Do not use Enterprise
              Security Manager or Enterprise Login Assistant from Oracle9i installations.


D.2 Upgrading Oracle Database from Release 9.2.0.8 to
Oracle Database Release 18c Version 18.1
         For each Oracle9i Database (9.2.0.8) instance that you upgrade to Oracle Database
         release 18c , version 18.1, perform the following steps:
         1.   Use Oracle Wallet Manager to disable automatic login for the database wallet.
         2.   Copy the database distinguished name (DN) from the initialization parameter
              rdbms_server_dn to a file in a secure location.
         3.   Upgrade the database to Oracle Database release 18c , version 18.1.
         4.   Depending on where your database admin directory is stored, move the database
              wallet either to $ORACLE_BASE/admin/olddbuniquename/wallet or $ORACLE_HOME/
              admin/olddbuniquename/wallet. Note that $ORACLE_HOME is for the new Oracle
              Database release 18c , version 18.1. You may have to create the wallet directory.
         5.   Copy the old $ORACLE_HOME/network/admin/ldap.ora file to the
              new $ORACLE_HOME/ldap/admin/ldap.ora file. Alternatively, you can use Oracle
              Net Configuration Assistant to create a new ldap.ora file.
         6.   Use the command-line utility, mkstore, to put the database DN (from the file in the
              previously created secure directory location) into the wallet by using the following
              syntax:
              mkstore -wrl database_wallet_location -createEntry
              ORACLE.SECURITY.DN database_DN

              You will be prompted for the wallet password.
              If you make a mistake in the mkstore command, then you can use the -
              modifyEntry option to correct it.
         7.   Use Database Configuration Assistant to generate the database-to-directory
              password in the database wallet. Choose the Modify Database option.
         8.   Use Oracle Wallet Manager to re-enable automatic login for the database wallet.
         9.   Use Oracle Net Manager to set the new wallet location in the sqlnet.ora file to
              the directory specified in step 4.
         The default for the nickname attribute, such as CN, remains unchanged. The upgrade
         process does not change the default nickname attribute setting. After upgrading from
         Oracle Internet Directory Release 9.2 to Release 9.0.4, if you are unable to log in to
         Oracle Database release 18c , version 18.1, then you must use the DAS-based Oracle
         Internet Directory Self-Service Console to reset your password.


D.3 Upgrading Oracle Database from Release 10g (10.1)
and Higher to Oracle Database Release 18c Version 18.1
         For each Oracle Database 10g Release 1 (10.2) and higher instance that you upgrade
         to Oracle Database release 18c, version 18.1, perform the following steps:




                                                                                                      D-2
                                                                                              Appendix D
Upgrading Oracle Database from Release 10g (10.1) and Higher to Oracle Database Release 18c Version 18.1


     1.   Upgrade the database to Oracle Database release 18c, version 18.1.
     2.   Depending on where your database admin directory is stored, move the database
          wallet either to $ORACLE_BASE/admin/olddbuniquename/wallet or $ORACLE_HOME/
          admin/olddbuniquename/wallet. Note that $ORACLE_HOME is for the new Oracle
          Database release 18c, version 18.1. You may have to create the wallet directory.
     3.   Copy the old $ORACLE_HOME/network/admin/ldap.ora file to the
          new $ORACLE_HOME/ldap/admin/ldap.ora file. Alternatively, you can use Oracle
          Net Configuration Assistant to create a new ldap.ora file.
     4.   Use Oracle Wallet Manager to re-enable automatic login for the database wallet.
     5.   Use Oracle Net Manager to set the new wallet location in the sqlnet.ora file to
          the directory specified in step 2.




                                                                                                   D-3
Glossary
      access control
      The ability of a system to grant or limit access to specific data for specific clients or
      groups of clients.

      Access Control Lists (ACLs)
      The group of access directives that you define. The directives grant levels of access to
      specific data for specific clients, or groups of clients, or both.

      Advanced Encryption Standard
      Advanced Encryption Standard (AES) is a new cryptographic algorithm that has been
      approved by the National Institute of Standards and Technology as a replacement for
      DES. The AES standard is available in Federal Information Processing Standards
      Publication 197. The AES algorithm is a symmetric block cipher that can process data
      blocks of 128 bits, using cipher keys with lengths of 128, 192, and 256 bits.

      AES
      See Advanced Encryption Standard

      attribute
      An item of information that describes some aspect of an entry in an LDAP directory.
      An entry comprises a set of attributes, each of which belongs to an object class.
      Moreover, each attribute has both a type, which describes the kind of information in
      the attribute, and a value, which contains the actual data.

      authentication
      The process of verifying the identity of a user, device, or other entity in a computer
      system, often as a prerequisite to granting access to resources in a system. A
      recipient of an authenticated message can be certain of the message's origin (its
      sender). Authentication is presumed to preclude the possibility that another party has
      impersonated the sender.

      authentication method
      A security method that verifies a user's, client's, or server's identity in distributed
      environments. Network authentication methods can also provide the benefit of single
      sign-on (SSO) for users. The following authentication methods are supported in Oracle
      Database when Oracle Advanced Security is installed:

      •     Kerberos

      •     RADIUS



                                                                                      Glossary-1
                                                                                     Glossary


•     Secure Sockets Layer (SSL)

•     Windows native authentication

authorization
Permission given to a user, program, or process to access an object or set of objects.
In Oracle, authorization is done through the role mechanism. A single person or a
group of people can be granted a role or a group of roles. A role, in turn, can be
granted other roles. The set of privileges available to an authenticated entity.

auto login wallet
An Oracle Wallet Manager feature that enables PKI- or password-based access to
services without providing credentials at the time of access. This auto login access
stays in effect until the auto login feature is disabled for that wallet. File system
permissions provide the necessary security for auto login wallets. When auto login is
enabled for a wallet, it is only available to the operating system user who created that
wallet. Sometimes these are called "SSO wallets" because they provide single sign-on
capability.

base
The root of a subtree search in an LDAP-compliant directory.

CA
See certificate authority

CDS
See Cell Directory Services (CDS)

Cell Directory Services (CDS)
An external naming method that enables users to use Oracle tools transparently and
applications to access Oracle Database databases in a Distributed Computing
Environment (DCE).

certificate
An ITU x.509 v3 standard data structure that securely binds an identify to a public key.

A certificate is created when an entity's public key is signed by a trusted identity, a
certificate authority. The certificate ensures that the entity's information is correct and
that the public key actually belongs to that entity.

A certificate contains the entity's name, identifying information, and public key. It is
also likely to contain a serial number, expiration date, and information about the rights,
uses, and privileges associated with the certificate. Finally, it contains information
about the certificate authority that issued it.

certificate authority
A trusted third party that certifies that other entities—users, databases, administrators,
clients, servers—are who they say they are. When it certifies a user, the certificate
authority first seeks verification that the user is not on the certificate revocation list




                                                                                Glossary-2
                                                                                     Glossary



(CRL), then verifies the user's identity and grants a certificate, signing it with the
certificate authority's private key. The certificate authority has its own certificate and
public key which it publishes. Servers and clients use these to verify signatures the
certificate authority has made. A certificate authority might be an external company
that offers certificate services, or an internal organization such as a corporate MIS
department.

certificate chain
An ordered list of certificates containing an end-user or subscriber certificate and its
certificate authority certificates.

certificate request
A certificate request, which consists of three parts: certification request information, a
signature algorithm identifier, and a digital signature on the certification request
information. The certification request information consists of the subject's distinguished
name, public key, and an optional set of attributes. The attributes may provide
additional information about the subject identity, such as postal address, or a
challenge password by which the subject entity may later request certificate
revocation. See PKCS #10

certificate revocation lists
(CRLs) Signed data structures that contain a list of revoked certificate s. The
authenticity and integrity of the CRL is provided by a digital signature appended to it.
Usually, the CRL signer is the same entity that signed the issued certificate.

checksumming
A mechanism that computes a value for a message packet, based on the data it
contains, and passes it along with the data to authenticate that the data has not been
tampered with. The recipient of the data recomputes the cryptographic checksum and
compares it with the cryptographic checksum passed with the data; if they match, it is
"probabilistic" proof the data was not tampered with during transmission.

Cipher Block Chaining (CBC)
An encryption method that protects against block replay attacks by making the
encryption of a cipher block dependent on all blocks that precede it; it is designed to
make unauthorized decryption incrementally more difficult. Oracle Advanced Security
employs outer cipher block chaining because it is more secure than inner cipher block
chaining, with no material performance penalty.

cipher suite
A set of authentication, encryption, and data integrity algorithms used for exchanging
messages between network nodes. During an SSL handshake, for example, the two
nodes negotiate to see which cipher suite they will use when transmitting messages
back and forth.




                                                                                Glossary-3
                                                                                  Glossary


cipher suite name
Cipher suites describe the kind of cryptographics protection that is used by
connections in a particular session.

ciphertext
Message text that has been encrypted.

cleartext
Unencrypted plain text.

client
A client relies on a service. A client can sometimes be a user, sometimes a process
acting on behalf of the user during a database link (sometimes called a proxy).

confidentiality
A function of cryptography. Confidentiality guarantees that only the intended
recipient(s) of a message can view the message (decrypt the ciphertext).

connect descriptor
A specially formatted description of the destination for a network connection. A
connect descriptor contains destination service and network route information. The
destination service is indicated by using its service name for Oracle9i or Oracle8i
databases or its Oracle system identifier (SID) for Oracle databases version 8.0. The
network route provides, at a minimum, the location of the listener through use of a
network address. See connect identifier

connect identifier
A connect descriptor or a name that maps to a connect descriptor. A connect identifier
can be a net service name, database service name, or net service alias. Users initiate
a connect request by passing a username and password along with a connect
identifier in a connect string for the service to which they wish to connect:
CONNECT username@connect_identifier
Enter password:

connect string
Information the user passes to a service to connect, such as username, password and
net service name. For example:

CONNECT username@net_service_name

Enter password:

credentials
A username, password, or certificate used to gain access to the database.

CRL
See certificate revocation lists




                                                                               Glossary-4
                                                                                   Glossary


CRL Distribution Point
(CRL DP) An optional extension specified by the X.509 version 3 certificate standard,
which indicates the location of the Partitioned CRL where revocation information for a
certificate is stored. Typically, the value in this extension is in the form of a URL. CRL
DPs allow revocation information within a single certificate authority domain to be
posted in multiple CRLs. CRL DPs subdivide revocation information into more
manageable pieces to avoid proliferating voluminous CRLs, thereby providing
performance benefits. For example, a CRL DP is specified in the certificate and can
point to a file on a Web server from which that certificate's revocation information can
be downloaded.

CRL DP
See CRL Distribution Point

cryptography
The practice of encoding and decoding data, resulting in secure messages.

data dictionary
A set of read-only tables that provide information about a database.

database administrator
(1) A person responsible for operating and maintaining an Oracle Server or a database
application. (2) An Oracle username that has been given DBA privileges and can
perform database administration functions. Usually the two meanings coincide. Many
sites have multiple DBAs. (3) Members of the OracleDBAdmins directory
administrative group, who manage the database user-schema mappings for a specific
database entry in the directory. Database Configuration Assistant automatically adds
the person who registers a database in the directory into the OracleDBAdmins group
as the first member of this group for the database being registered.

database alias
See net service name

Database Installation Administrator
Also called a database creator. This administrator is in charge of creating new
databases. This includes registering each database in the directory using the
Database Configuration Assistant. This administrator has create and modify access to
database service objects and attributes. This administrator can also modify the Default
domain.

database link
A network object stored in the local database or in the network definition that identifies
a remote database, a communication path to that database, and optionally, a
username and password. Once defined, the database link is used to access the
remote database.

A public or private database link from one database to another is created on the local
database by a DBA or user.



                                                                               Glossary-5
                                                                                  Glossary


A global database link is created automatically from each database to every other
database in a network with Oracle Names. Global database links are stored in the
network definition.

database method
See Oracle database method

database password verifier
A database password verifier is an irreversible value that is derived from the user's
database password. This value is used during password authentication to the
database to prove the identity of the connecting user.

Database Security Administrator
The highest level administrator for database enterprise user security. This
administrator has permissions on all of the enterprise domains and is responsible for:

•     Administering the Oracle DBSecurityAdmins and OracleDBCreators groups.

Creating new enterprise domains.

•     Moving databases from one domain to another within the enterprise.

DCE
See Distributed Computing Environment (DCE)

decryption
The process of converting the contents of an encrypted message (ciphertext) back into
its original readable format (plaintext).

dictionary attack
A common attack on passwords. the attacker creates a dictionary of many possible
passwords and their corresponding verifiers. Through some means, the attacker then
obtains the verifier corresponding to the target password, and obtains the target
password by looking up the verifier in the dictionary.

Diffie-Hellman key negotiation algorithm
This is a method that lets two parties communicating over an insecure channel to
agree upon a random number known only to them. Though the parties exchange
information over the insecure channel during execution of the Diffie-Hellman key
negotiation algorithm, it is computationally infeasible for an attacker to deduce the
random number they agree upon by analyzing their network communications. Oracle
Advanced Security uses the Diffie-Hellman key negotiation algorithm to generate
session keys.

digital signature
A digital signature is created when a public key algorithm is used to sign the sender's
message with the sender's private key. The digital signature assures that the




                                                                             Glossary-6
                                                                                   Glossary



document is authentic, has not been forged by another entity, has not been altered,
and cannot be repudiated by the sender.

directory information tree (DIT)
A hierarchical tree-like structure consisting of the DNs of the entries in an LDAP
directory. See distinguished name (DN)

directory naming
A naming method that resolves a database service, net service name, or net service
alias to a connect descriptor stored in a central directory server. A

directory naming context
A subtree which is of significance within a directory server. It is usually the top of some
organizational subtree. Some directories only permit one such context which is fixed;
others permit none to many to be configured by the directory administrator.

Distributed Computing Environment (DCE)
A set of integrated network services that works across multiple systems to provide a
distributed environment. The middleware between distributed applications and the
operating system or network services; based on a client/server computing model. DCE
is supported by the Open Group.

distinguished name (DN)
The unique name of a directory entry. It is comprised of all of the individual names of
the parent entries back to the root entry of the directory information tree. See directory
information tree (DIT)

domain
Any tree or subtree within the Domain Name System (DNS) namespace. Domain most
commonly refers to a group of computers whose host names share a common suffix,
the domain name.

Domain Name System (DNS)
A system for naming computers and network services that is organized into a
hierarchy of domains. DNS is used in TCP/IP networks to locate computers through
user-friendly names. DNS resolves a friendly name into an IP address, which is
understood by computers.

In Oracle Net Services, DNS translates the host name in a TCP/IP address into an IP
address.

encrypted text
Text that has been encrypted, using an encryption algorithm; the output stream of an
encryption process. On its face, it is not readable or decipherable, without first being
subject to decryption. Also called ciphertext. Encrypted text ultimately originates as
plaintext.




                                                                              Glossary-7
                                                                                   Glossary


encryption
The process of disguising a message rendering it unreadable to any but the intended
recipient.

enterprise domain
A directory construct that consists of a group of databases and enterprise roles. A
database should only exist in one enterprise domain at any time. Enterprise domains
are different from Windows 2000 domains, which are collections of computers that
share a common directory database.

enterprise domain administrator
User authorized to manage a specific enterprise domain, including the authority to add
new enterprise domain administrators.

enterprise role
Access privileges assigned to enterprise users. A set of Oracle role-based
authorizations across one or more databases in an enterprise domain. Enterprise roles
are stored in the directory and contain one or more global roles.

enterprise user
A user defined and managed in a directory. Each enterprise user has a unique identity
across an enterprise.

entry
The building block of a directory, it contains information about an object of interest to
directory users.

external authentication
Verification of a user identity by a third party authentication service, such as Kerberos
or RADIUS.

file system method
Storing fingerprint templates in files when configuring Identix Biometric authentication.
The alternative is to use the Oracle database method.

Federal Information Processing Standard (FIPS)
A U.S. government standard that defines security requirements for cryptographic
modules—employed within a security system protecting unclassified information within
computer and telecommunication systems. Published by the National Institute of
Standards and Technology (NIST).

FIPS
See Federal Information Processing Standard (FIPS)

forest
A group of one or more Active Directory trees that trust each other. All trees in a forest
share a common schema, configuration, and global catalog. When a forest contains




                                                                              Glossary-8
                                                                                  Glossary



multiple trees, the trees do not form a contiguous namespace. All trees in a given
forest trust each other through transitive bidirectional trust relationships.

forwardable ticket-granting ticket
In Kerberos. A service ticket with the FORWARDABLE flag set. This flag enables
authentication forwarding without requiring the user to enter a password again.

GDS
See Global Directory Service (GDS)

Global Directory Service (GDS)
GDS is the DCE directory service that acts as an agent between DCE CDS and any X.
500 directory service. Both GDS and CDS are obsolete; they are only used by DCE.

global role
A role managed in a directory, but its privileges are contained within a single database.
A global role is created in a database by using the following syntax:
CREATE ROLE <role_name> IDENTIFIED GLOBALLY;

grid computing
A computing architecture that coordinates large numbers of servers and storage to act
as a single large computer. Oracle Grid Computing creates a flexible, on-demand
computing resource for all enterprise computing needs. Applications running on the
Oracle 10g, or later, grid computing infrastructure can take advantage of common
infrastructure services for failover, software provisioning, and management. Oracle
Grid Computing analyzes demand for resources and adjusts supply accordingly.

HTTP
Hypertext Transfer Protocol: The set of rules for exchanging files (text, graphic
images, sound, video, and other multimedia files) on the World Wide Web. Relative to
the TCP/IP suite of protocols (which are the basis for information exchange on the
Internet), HTTP is an application protocol.

HTTPS
The use of Secure Sockets Layer (SSL) as a sublayer under the regular HTTP
application layer.

identity
The combination of the public key and any other public information for an entity. The
public information may include user identification data such as, for example, an e-mail
address. A user certified as being the entity it claims to be.

identity management
The creation, management, and use of online, or digital, entities. Identity management
involves securely managing the full life cycle of a digital identity from creation




                                                                            Glossary-9
                                                                                    Glossary


(provisioning of digital identities) to maintenance (enforcing organizational policies
regarding access to electronic resources), and, finally, to termination.

identity management realm
A subtree in Oracle Internet Directory, including not only an Oracle Context, but also
additional subtrees for users and groups, each of which are protected with access
control lists.

initial ticket
In Kerberos authentication, an initial ticket or ticket granting ticket (TGT) identifies the
user as having the right to ask for additional service tickets. No tickets can be obtained
without an initial ticket. An initial ticket is retrieved by running the okinit program and
providing a password.

instance
Every running Oracle database is associated with an Oracle instance. When a
database is started on a database server (regardless of the type of computer), Oracle
allocates a memory area called the System Global Area (SGA) and starts an Oracle
process. This combination of the SGA and an Oracle process is called an instance.
The memory and the process of an instance manage the associated database's data
efficiently and serve the one or more users of the database.

integrity
The guarantee that the contents of the message received were not altered from the
contents of the original message sent.

java code obfuscation
Java code obfuscation is used to protect Java programs from reverse engineering. A
special program (an obfuscator) is used to scramble Java symbols found in the code.
The process leaves the original program structure intact, letting the program run
correctly while changing the names of the classes, methods, and variables in order to
hide the intended behavior. Although it is possible to decompile and read non-
obfuscated Java code, the obfuscated Java code is sufficiently difficult to decompile to
satisfy U.S. government export controls.

Java Database Connectivity (JDBC)
An industry-standard Java interface for connecting to a relational database from a
Java program, defined by Sun Microsystems.

JDBC
See Java Database Connectivity (JDBC)

KDC
Key Distribution Center. In Kerberos authentication, the KDC maintains a list of user
principals and is contacted through the kinit (okinit is the Oracle version) program
for the user's initial ticket. Frequently, the KDC and the Ticket Granting Service are
combined into the same entity and are simply referred to as the KDC. The Ticket




                                                                              Glossary-10
                                                                                    Glossary



Granting Service maintains a list of service principals and is contacted when a user
wants to authenticate to a server providing such a service. The KDC is a trusted third
party that must run on a secure host. It creates ticket-granting tickets and service
tickets.

Kerberos
A network authentication service developed under Massachusetts Institute of
Technology's Project Athena that strengthens security in distributed environments.
Kerberos is a trusted third-party authentication system that relies on shared secrets
and assumes that the third party is secure. It provides single sign-on capabilities and
database link authentication (MIT Kerberos only) for users, provides centralized
password storage, and enhances PC security.

key
When encrypting data, a key is a value which determines the ciphertext that a given
algorithm will produce from given plaintext. When decrypting data, a key is a value
required to correctly decrypt a ciphertext. A ciphertext is decrypted correctly only if the
correct key is supplied.

With a symmetric encryption algorithm, the same key is used for both encryption and
decryption of the same data. With an asymmetric encryption algorithm (also called a
public-key encryption algorithm or public-key cryptosystem), different keys are used for
encryption and decryption of the same data.

key pair
A public key and its associated private key. See public and private key pair

keytab file
A Kerberos key table file containing one or more service keys. Hosts or services use
keytab files in the same way as users use their passwords.

kinstance
An instantiation or location of a Kerberos authenticated service. This is an arbitrary
string, but the host computer name for a service is typically specified.

kservice
An arbitrary name of a Kerberos service object.

LDAP
See Lightweight Directory Access Protocol (LDAP)

ldap.ora file
A file created by Oracle Net Configuration Assistant that contains the following
directory server access information:

•     Type of directory server

•     Location of the directory server




                                                                             Glossary-11
                                                                                    Glossary


•    Default identity management realm or Oracle Context (including ports) that the
     client or server will use

Lightweight Directory Access Protocol (LDAP)
A standard, extensible directory access protocol. It is a common language that LDAP
clients and servers use to communicate. The framework of design conventions
supporting industry-standard directory products, such as the Oracle Internet Directory.

listener
A process that resides on the server whose responsibility is to listen for incoming client
connection requests and manage the traffic to the server.

Every time a client requests a network session with a server, a listener receives the
actual request. If the client information matches the listener information, then the
listener grants a connection to the server.

listener.ora file
A configuration file for the listener that identifies the:

•    Listener name

•    Protocol addresses that it is accepting connection requests on

•    Services it is listening for

The listener.ora file typically resides in $ORACLE_HOME/network/admin on UNIX
platforms and ORACLE_BASE\ORACLE_HOME\network\admin on Windows.

man-in-the-middle
A security attack characterized by the third-party, surreptitious interception of a
message, wherein the third-party, the man-in-the-middle, decrypts the message, re-
encrypts it (with or without alteration of the original message), and re-transmits it to the
originally-intended recipient—all without the knowledge of the legitimate sender and
receiver. This type of security attack works only in the absence of authentication.

message authentication code
Also known as data authentication code (DAC). A checksumming with the addition of a
secret key. Only someone with the key can verify the cryptographic checksum.

message digest
See checksumming

naming method
The resolution method used by a client application to resolve a connect identifier to a
connect descriptor when attempting to connect to a database service.

National Institute of Standards and Technology (NIST)
An agency within the U.S. Department of Commerce responsible for the development
of security standards related to the design, acquisition, and implementation of
cryptographic-based security systems within computer and telecommunication




                                                                              Glossary-12
                                                                                   Glossary



systems, operated by a Federal agency or by a contractor of a Federal agency or
other organization that processes information on behalf of the Federal Government to
accomplish a Federal function.

net service alias
An alternative name for a directory naming object in a directory server. A directory
server stores net service aliases for any defined net service name or database service.
A net service alias entry does not have connect descriptor information. Instead, it only
references the location of the object for which it is an alias. When a client requests a
directory lookup of a net service alias, the directory determines that the entry is a net
service alias and completes the lookup as if it was actually the entry it is referencing.

net service name
The name used by clients to identify a database server. A net service name is mapped
to a port number and protocol. Also known as a connect string, or database alias.

network authentication service
A means for authenticating clients to servers, servers to servers, and users to both
clients and servers in distributed environments. A network authentication service is a
repository for storing information about users and the services on different servers to
which they have access, as well as information about clients and servers on the
network. An authentication server can be a physically separate computer, or it can be
a facility co-located on another server within the system. To ensure availability, some
authentication services may be replicated to avoid a single point of failure.

network listener
A listener on a server that listens for connection requests for one or more databases
on one or more protocols. See listener

NIST
See Federal Information Processing Standard (FIPS)

non-repudiation
Incontestable proof of the origin, delivery, submission, or transmission of a message.

obfuscation
A process by which information is scrambled into a non-readable form, such that it is
extremely difficult to de-scramble if the algorithm used for scrambling is not known.

obfuscator
A special program used to obfuscate Java source code. See obfuscation

object class
A named group of attributes. When you want to assign attributes to an entry, you do
so by assigning to that entry the object classes that hold those attributes. All objects
associated with the same object class share the same attributes.




                                                                             Glossary-13
                                                                                  Glossary


Oracle Context
1. An entry in an LDAP-compliant internet directory called cn=OracleContext, under
which all Oracle software relevant information is kept, including entries for Oracle Net
Services directory naming and checksumming security.

There can be one or more Oracle Contexts in a directory. An Oracle Context is usually
located in an identity management realm.

OracleContextAdmins
An administrative group in Oracle Internet Directory whose members have full access
to all groups and entries within its associated realm Oracle Context.

Oracle database method
Using an Oracle database to store fingerprint templates when configuring Indentix
Biometric authentication. The alternative is to use the file system method.

OracleDBAdmins
An administrative group in Oracle Internet Directory whose members manage the
database user-schema mappings for a particular database that is registered in the
directory.

OracleDBCreators
An administrative group in Oracle Internet Directory whose members create new
databases and registers them in the directory by using Database Configuration
Assistant.

OracleDBSecurityAdmins
An administrative group in Oracle Internet Directory whose members have
permissions on all of the enterprise domains to configure the identity management
realm for enterprise users.

Oracle Net Services
An Oracle product that enables two or more computers that run the Oracle server or
Oracle tools such as Designer/2000 to exchange data through a third-party network.
Oracle Net Services support distributed processing and distributed database
capability. Oracle Net Services is an open system because it is independent of the
communication protocol, and users can interface Oracle Net to many network
environments.

OraclePasswordAccessibleDomains
See Password-Accessible Domains List

Oracle PKI certificate usages
Defines Oracle application types that a certificate supports.




                                                                           Glossary-14
                                                                                     Glossary


OracleUserSecurityAdmins
An administrative group in Oracle Internet Directory whose members can administer
Oracle database users' security in the directory.

Password-Accessible Domains List
A group of enterprise domains configured to accept connections from password-
authenticated users.

PCMCIA cards
Small credit card-sized computing devices that comply with the Personal Computer
Memory Card International Association (PCMCIA) standard. These devices, also
called PC cards, are used for adding memory, modems, or as hardware security
modules. PCMCIA cards used as hardware security modules securely store the
private key component of a public and private key pair and some also perform the
cryptographic operations as well.

peer identity
SSL connect sessions are between a particular client and a particular server. The
identity of the peer may have been established as part of session setup. Peers are
identified by X.509 certificate chains.

PEM
The Internet Privacy-Enhanced Mail protocols standard, adopted by the Internet
Architecture Board to provide secure electronic mail over the Internet. The PEM
protocols provide for encryption, authentication, message integrity, and key
management. PEM is an inclusive standard, intended to be compatible with a wide
range of key-management approaches, including both symmetric and public-key
schemes to encrypt data-encrypting keys. The specifications for PEM come from four
Internet Engineering Task Force (IETF) documents: RFCs 1421, 1422, 1423, and
1424.

PKCS #10
An RSA Security, Inc., Public-Key Cryptography Standards (PKCS) specification that
describes a syntax for certification requests. A certification request consists of a
distinguished name, a public key, and optionally a set of attributes, collectively signed
by the entity requesting certification. Certification requests are referred to as certificate
requests in this manual. See certificate request

PKCS #11
An RSA Security, Inc., Public-Key Cryptography Standards (PKCS) specification that
defines an application programming interface (API), called Cryptoki, to devices which
hold cryptographic information and perform cryptographic operations. See PCMCIA
cards




                                                                               Glossary-15
                                                                                    Glossary


PKCS #12
An RSA Security, Inc., Public-Key Cryptography Standards (PKCS) specification that
describes a transfer syntax for storing and transferring personal authentication
credentials—typically in a format called a wallet.

PKI
See public key infrastructure (PKI)

plaintext
Message text that has not been encrypted.

principal
A string that uniquely identifies a client or server to which a set of Kerberos credentials
is assigned. It generally has three parts: kservice/kinstance@REALM. In the case of a
user, kservice is the username. See also kservice, kinstance, and realm

private key
In public-key cryptography, this key is the secret key. It is primarily used for decryption
but is also used for encryption with digital signatures. See public and private key pair

proxy authentication
A process typically employed in an environment with a middle tier such as a firewall,
wherein the end user authenticates to the middle tier, which then authenticates to the
directory on the user's behalf—as its proxy. The middle tier logs into the directory as a
proxy user. A proxy user can switch identities and, once logged into the directory,
switch to the end user's identity. It can perform operations on the end user's behalf,
using the authorization appropriate to that particular end user.

public key
In public-key cryptography, this key is made public to all. It is primarily used for
encryption but can be used for verifying signatures. See public and private key pair

public key encryption
The process where the sender of a message encrypts the message with the public key
of the recipient. Upon delivery, the message is decrypted by the recipient using its
private key.

public key infrastructure (PKI)
Information security technology utilizing the principles of public key cryptography.
Public key cryptography involves encrypting and decrypting information using a shared
public and private key pair. Provides for secure, private communications within a
public network.

public and private key pair
A set of two numbers used for encryption and decryption, where one is called the
private key and the other is called the public key. Public keys are typically made widely
available, while private keys are held by their respective owners. Though




                                                                             Glossary-16
                                                                                    Glossary



mathematically related, it is generally viewed as computationally infeasible to derive
the private key from the public key. Public and private keys are used only with
asymmetric encryption algorithms, also called public-key encryption algorithms, or
public-key cryptosystems. Data encrypted with either a public key or a private key from
a key pair can be decrypted with its associated key from the key-pair. However, data
encrypted with a public key cannot be decrypted with the same public key, and data
enwrapped with a private key cannot be decrypted with the same private key.

RADIUS
Remote Authentication Dial-In User Service (RADIUS) is a client/server protocol and
software that enables remote access servers to communication with a central server to
authenticate dial-in users and authorize their access to the requested system or
service.

realm
1. Short for identity management realm. 2. A Kerberos object. A set of clients and
servers operating under a single key distribution center/ticket-granting service (KDC/
TGS). Services (see kservice) in different realms that share the same name are
unique.

realm Oracle Context
An Oracle Context that is part of an identity management realm in Oracle Internet
Directory.

registry
A Windows repository that stores configuration information for a computer.

remote computer
A computer on a network other than the local computer.

root key certificate
See trusted certificate

schema
1. Database schema: A named collection of objects, such as tables, views, clusters,
procedures, packages, attributes, object classes, and their corresponding matching
rules, which are associated with a particular user. 2. LDAP directory schema: The
collection of attributes, object classes, and their corresponding matching rules.

schema mapping
See user-schema mapping

Secure Hash Algorithm (SHA)
An algorithm that assures data integrity by generating a 160-bit cryptographic
message digest value from given data. If as little as a single bit in the data is modified,
the Secure Hash Algorithm checksum for the data changes. Forgery of a given data
set in a way that will cause the Secure Hash Algorithm to generate the same result as
that for the original data is considered computationally infeasible.



                                                                             Glossary-17
                                                                                    Glossary


An algorithm that takes a message of less than 264 bits in length and produces a 160-
bit message digest. The algorithm with its larger message digest makes it more secure
against brute-force collision and inversion attacks.

Secure Sockets Layer (SSL)
An industry standard protocol designed by Netscape Communications Corporation for
securing network connections. SSL provides authentication, encryption, and data
integrity using public key infrastructure (PKI).

server
A provider of a service.

service
1. A network resource used by clients; for example, an Oracle database server.

2. An executable process installed in the Windows registry and administered by
Windows. Once a service is created and started, it can run even when no user is
logged on to the computer.

service name
For Kerberos-based authentication, the kservice portion of a service principal.

service principal
See principal

service table
In Kerberos authentication, a service table is a list of service principals that exist on a
kinstance. This information must be extracted from Kerberos and copied to the Oracle
server computer before Kerberos can be used by Oracle.

service ticket
Trusted information used to authenticate the client. A ticket-granting ticket, which is
also known as the initial ticket, is obtained by directly or indirectly running okinit and
providing a password, and is used by the client to ask for service tickets. A service
ticket is used by a client to authenticate to a service.

session key
A key shared by at least two parties (usually a client and a server) that is used for data
encryption for the duration of a single communication session. Session keys are
typically used to encrypt network traffic; a client and a server can negotiate a session
key at the beginning of a session, and that key is used to encrypt all network traffic
between the parties for that session. If the client and server communicate again in a
new session, they negotiate a new session key.

session layer
A network layer that provides the services needed by the presentation layer entities
that enable them to organize and synchronize their dialogue and manage their data




                                                                             Glossary-18
                                                                                   Glossary



exchange. This layer establishes, manages, and terminates network sessions between
the client and server. An example of a session layer is Network Session.

SHA
See Secure Hash Algorithm (SHA)

shared schema
A database or application schema that can be used by multiple enterprise users.
Oracle Advanced Security supports the mapping of multiple enterprise users to the
same shared schema on a database, which lets an administrator avoid creating an
account for each user in every database. Instead, the administrator can create a user
in one location, the enterprise directory, and map the user to a shared schema that
other enterprise users can also map to. Sometimes called user/schema separation.

single key-pair wallet
A PKCS #12-format wallet that contains a single user certificate and its associated
private key. The public key is imbedded in the certificate.

single password authentication
The ability of a user to authenticate with multiple databases by using a single
password. In the Oracle Advanced Security implementation, the password is stored in
an LDAP-compliant directory and protected with encryption and Access Control Lists.

single sign-on (SSO)
The ability of a user to authenticate once, combined with strong authentication
occurring transparently in subsequent connections to other databases or applications.
Single sign-on lets a user access multiple accounts and applications with a single
password, entered during a single connection. Single password, single authentication.
Oracle Advanced Security supports Kerberos, DCE, and SSL-based single sign-on.

smart card
A plastic card (like a credit card) with an embedded integrated circuit for storing
information, including such information as user names and passwords, and also for
performing computations associated with authentication exchanges. A smart card is
read by a hardware device at any client or server.

A smartcard can generate random numbers which can be used as one-time use
passwords. In this case, smartcards are synchronized with a service on the server so
that the server expects the same password generated by the smart card.

sniffer
Device used to surreptitiously listen to or capture private data traffic from a network.

sqlnet.ora file
A configuration file for the client or server that specifies:

•     Client domain to append to unqualified service names or net service names

•     Order of naming methods the client should use when resolving a name




                                                                             Glossary-19
                                                                                    Glossary


•     Logging and tracing features to use

•     Route of connections

•     Preferred Oracle Names servers
•     External naming parameters

•     Oracle Advanced Security parameters

The sqlnet.ora file typically resides in $ORACLE_HOME/network/admin on UNIX
platforms and ORACLE_BASE\ORACLE_HOME\network\admin on Windows platforms.

SSO
See single sign-on (SSO)

System Global Area (SGA)
A group of shared memory structures that contain data and control information for an
Oracle instance.

system identifier (SID)
A unique name for an Oracle instance. To switch between Oracle databases, users
must specify the desired SID. The SID is included in the CONNECT DATA parts of the
connect descriptor in a tnsnames.ora file, and in the definition of the network listener in
a listener.ora file.

ticket
A piece of information that helps identify who the owner is. See service ticket.

tnsnames.ora
A file that contains connect descriptors; each connect descriptor is mapped to a net
service name. The file may be maintained centrally or locally, for use by all or
individual clients. This file typically resides in the following locations depending on your
platform:

•     (UNIX) ORACLE_HOME/network/admin

•     (Windows) ORACLE_BASE\ORACLE_HOME\network\admin

token card
A device for providing improved ease-of-use for users through several different
mechanisms. Some token cards offer one-time passwords that are synchronized with
an authentication service. The server can verify the password provided by the token
card at any given time by contacting the authentication service. Other token cards
operate on a challenge-response basis. In this case, the server offers a challenge (a
number) which the user types into the token card. The token card then provides
another number (cryptographically-derived from the challenge), which the user then
offers to the server.




                                                                              Glossary-20
                                                                                      Glossary


transport layer
A networking layer that maintains end-to-end reliability through data flow control and
error recovery methods. Oracle Net Services uses Oracle protocol supports for the
transport layer.

trusted certificate
A trusted certificate, sometimes called a root key certificate, is a third party identity that
is qualified with a level of trust. The trusted certificate is used when an identity is being
validated as the entity it claims to be. Typically, the certificate authorities you trust are
called trusted certificates. If there are several levels of trusted certificates, a trusted
certificate at a lower level in the certificate chain does not need to have all its higher
level certificates reverified.

trusted certificate authority
See certificate authority

trust point
See trusted certificate

username
A name that can connect to and access objects in a database.

user-schema mapping
An LDAP directory entry that contains a pair of values: the base in the directory at
which users exist, and the name of the database schema to which they are mapped.
The users referenced in the mapping are connected to the specified schema when
they connect to the database. User-schema mapping entries can apply only to one
database or they can apply to all databases in a domain. See shared schema

user/schema separation
See shared schema

user search base
The node in the LDAP directory under which the user resides.

views
Selective presentations of one or more tables (or other views), showing both their
structure and their data.

wallet
A wallet is a data structure used to store and manage security credentials for an
individual entity. A Wallet Resource Locator (WRL) provides all the necessary
information to locate the wallet.

wallet obfuscation
Wallet obfuscation is used to store and access an Oracle wallet without querying the
user for a password prior to access (supports single sign-on (SSO)).




                                                                               Glossary-21
                                                                                 Glossary


Wallet Resource Locator
A wallet resource locator (WRL) provides all necessary information to locate a wallet. It
is a path to an operating system directory that contains a wallet.

Windows native authentication
An authentication method that enables a client single login access to a Windows
server and a database running on that server.

WRL
See Wallet Resource Locator

X.509
An industry-standard specification for digital certificate s.




                                                                           Glossary-22
Index
A                                                 createProxyPerm
                                                      EUSM command, 7-53
Active Directory Integration, C-2                 createRole
addDatabase                                           EUSM command, 7-34
    EUSM command, 7-17
addDBAdmin
    EUSM command, 7-20
                                                  D
addDomainAdmin                                    database links
    EUSM command, 7-13                                RADIUS not supported, 1-25
addGlobalRole                                     deleteAppcCtxUsers
    EUSM command, 7-37                                EUSM command, 7-92
addTargetUser                                     deleteAppCtxAttribute
    EUSM command, 7-56                                EUSM command, 7-83
addToPwdAccessibleDomains                         deleteAppCtxAttributeValue
    EUSM command, 7-72                                EUSM command, 7-87
                                                  deleteAppCtxNamespace
B                                                     EUSM command, 7-79
                                                  deleteDomain
browser certificates, using with Oracle Wallet        EUSM command, 7-9
       Manager, 6-25                              deleteMapping
                                                      EUSM command, 7-28
                                                  deleteProxyPerm
C                                                     EUSM command, 7-54
centrally managed users                           deleteRole
     with Microsoft Active Directory, C-1             EUSM command, 7-35
certificate                                       direct integration
     browser, using with Oracle Wallet Manager,       Microsoft Active Directory, C-1
             6-25                                 directory, 2-20
commands                                          directory administrative groups
     EUSM                                             OracleContextAdmins, 1-16
          command summary, 7-4                        OracleDBAdmins, 1-16
Configuring OID in RAC, 2-7                           OracleDBCreators, 1-16
CONNECT, 1-23, 1-24                                   OracleDBSecurityAdmins, 1-17
createAppcCtxUsers                                    OraclePasswordAccessibleDomains list, 1-17
     EUSM command, 7-91                               OracleUserSecurityAdmins, 1-17
createAppCtxAttribute                             directory authentication, configuring for SYSDBA
     EUSM command, 7-81                                    or SYSOPER access, 4-10
createAppCtxAttributeValue                        Directory services
     EUSM command, 7-86                               dsi.ora file, compared with ldap.ora, 2-20
createAppCtxNamespace                                 ldap.ora file, compared with dsi.ora, 2-20
     EUSM command, 7-77                           dsi.ora file
createDomain                                          about, 2-20
     EUSM command, 7-7                                changing contents of, 2-20
createMapping                                         compared with ldap.ora, 2-20
     EUSM command, 7-26                               creating, 2-22



                                                                                           Index-1
                                                                                       Index


dsi.ora file (continued)                  EUSM command (continued)
    multitenant environment, 2-20            listDBInfo, 7-23
    placement of, 2-20                       listDBOIDAuth, 7-70
    search order for, 2-20                   listDomainAdmins, 7-16
    WALLET_LOCATION parameter and, 2-20      listDomainInfo, 7-11
    when to use, 2-20                        listDomains, 7-10
dsi.ora file, about, 2-20                    listEnterPriseRoleInfo, 7-49
                                             listEnterpriseRoles, 7-46
                                             listEnterpriseRolesOfUser, 7-47
E                                            listGlobalRolesInDB, 7-51
enterprise user security                     listMappings, 7-29
    components, 1-25                         listProxyPermissionInfo, 7-66
    configuration flow chart, 4-1            listProxyPermissions, 7-63
    configuration roadmap, 4-4               listProxyPermissionsOfUser, 7-65
    directory entries, 1-10                  listPwdAccessibleDomains, 7-75
    enterprise domains, 1-13                 listRealmCommonAttr, 7-76
    enterprise roles, 1-11                   listSharedSchemasInDB, 7-52
    enterprise users, 1-10                   listTargetUsersInDB, 7-68
         mapping, 1-20                       removeDBAdmin, 7-24
    global roles, 1-11                       removeDomainAdmin, 7-14
    overview, 1-1                            removeFromPwdAccessibleDomains, 7-73
    shared schemas, 1-19                     removeGlobalRole, 7-39
         configuring, 1-19                   removeTargetUser, 7-58
    tools summary, 3-1                       revokeProxyPerm, 7-62
    using third-party directories, 1-3       revokeRole, 7-44
EUSM command                                 setAuthTypes, 7-32
    addDatabase, 7-17                        setCulinkStatus, 7-31
    addDBAdmin, 7-20                         setDBOIDAuth, 7-69
    addDomainAdmin, 7-13
    addGlobalRole, 7-37                   G
    addTargetUser, 7-56
    addToPwdAccessibleDomains, 7-72       grantProxyPerm
    createAppCtxAttribute, 7-81               EUSM command, 7-60
    createAppCtxAttributeValue, 7-86      grantRole
    createAppCtxNamespace, 7-77               EUSM command, 7-42
    createAppCtxUsers, 7-91               groups
    createDomain, 7-7                         OracleContextAdmins, 1-16
    createMapping, 7-26                       OracleDBAdmins, 1-16
    createProxyPerm, 7-53                     OracleDBCreators, 1-16
    createRole, 7-34                          OracleDBSecurityAdmins, 1-17
    deleteAppCtxAttribute, 7-83               OraclePasswordAccessibleDomains list, 1-17
    deleteAppCtxAttributeValue, 7-87          OracleUserSecurityAdmins, 1-17
    deleteAppCtxNamespace, 7-79
    deleteAppCtxUsers, 7-92
    deleteDomain, 7-9
                                          I
    deleteMapping, 7-28                   Internet Explorer certificates
    deleteProxyPerm, 7-54                     using with Oracle Wallet Manager, 6-25
    deleteRole, 7-35
    grantProxyPerm, 7-60
    grantRole, 7-42                       K
    listAppCtxAttribute, 7-84             KERBEROS_PNAME column, A-5
    listAppCtxAttributeValues, 7-89       keyalias, A-19
    listAppCtxNamespaces, 7-80
    listAppCtxUsers, 7-94
    listDBAdmins, 7-22



                                                                                  Index-2
                                                                                          Index


keystore, A-19                               listProxyPermissionsOfUser
   path                                           EUSM command, 7-65
        location, A-20                       listPwdAccessibleDomains
keystore password, A-19                           EUSM command, 7-75
                                             listRealmCommonAttr
                                                  EUSM command, 7-76
L                                            listSharedSchemasInDB
LDAP directories                                  EUSM command, 7-52
     donwloading Oracle wallets from, 6-15   listTargetUsersInDB
     Oracle Wallet support of, 6-6                EUSM command, 7-68
     uploading Oracle wallets to, 6-14
ldap.ora file                                M
     about, 2-22
     benefit of, 2-22                        Microsoft Active Directory
     changing contents of, 2-22                  direct integration, C-1
     compared with dsi.ora, 2-20             Microsoft Internet Explorer certificates
     placement of, 2-22                          using with Oracle Wallet Manager, 6-25
     search order for, 2-22                  Microsoft Windows Registry
ldap.ora file, about, 2-22                       wallet storage, 6-2
ldap.ora file, creating, 2-23                mkstore utility, 4-27
listAppCtxAttribute
     EUSM command, 7-84
listAppCtxAttributeValues
                                             N
     EUSM command, 7-89                      Netscape certificates
listAppCtxNamespaces                             using with Oracle Wallet Manager, 6-25
     EUSM command, 7-80                      nickname, 4-5
listAppCtxUsers
     EUSM command, 7-94
listDBAdmins                                 O
     EUSM command, 7-22                      ORA-28885 error, 6-4
listDBInfo                                   Oracle Applications wallet location, 6-17
     EUSM command, 7-23                      Oracle Internet Directory
listDBOIDAuth                                   version supported by Enterprise User
     EUSM command, 7-70                                  Security, 1-3
listDomainAdmins                             Oracle JDBC OCI driver
     EUSM command, 7-16                         used by user migration utility, A-2
listDomainInfo                               Oracle Wallet Manager, 6-4
     EUSM command, 7-11                         about, 6-2
listDomains                                     backward compatibility, 6-3
     EUSM command, 7-10                         importing PKCS #7 certificate chains, 6-23
listEnterPriseRoleInfo                          KeyUsage extension, 6-4
     EUSM command, 7-49                         LDAP directory support, 6-6
listEnterpriseRoles                             Microsoft Windows Registry wallet storage,
     EUSM command, 7-46                                  6-2
listEnterpriseRolesOfUser                       multiple certificate support, 6-4
     EUSM command, 7-47                         password management, 6-2
listGlobalRolesInDB                             starting, 6-7
     EUSM command, 7-51                         strong wallet encryption, 6-2
listMappings                                 Oracle wallets, 6-1
     EUSM command, 7-29                         auto login
listProxyPermissionInfo                              about, 6-19
     EUSM command, 7-66                              disabling, 6-20
listProxyPermissions                                 enabling, 6-19
     EUSM command, 7-63




                                                                                             3
                                                                                                Index


Oracle wallets (continued)                         P
   certificates
        about, 6-20                                Password Policies, 1-17
   certificates, trusted                           passwords
        exporting all certificates, 6-31               Oracle wallets, guidelines for, 6-8
        exporting single certificate, 6-31         PDB, 2-20
        importing, 6-29                            PKCS #7 certificate chain, 6-23
        importing file with, 6-29                      difference from X.509 certificate, 6-23
        removing, 6-30                             proxy
        text-only (BASE64), copying and pasting,       connect, 1-23, 1-24
                 6-29                              public key cryptography standards support, 6-4
   certificates, user                                  Oracle wallets, 6-4
        about, 6-21
        adding certificate request, 6-21
        exporting, 6-27
                                                   R
        importing from email text, 6-23            RADIUS
        importing from file, 6-23                      database links not supported, 1-25
        importing from third-party tools, 6-25     Registering RAC database with OID, 2-7
        importing into wallet, 6-23                removeDBAdmin
        importing third-parties, 6-25                  EUSM command, 7-24
        removing certificate request, 6-27         removeDomainAdmin
        removing from wallet, 6-26                     EUSM command, 7-14
        saving, 6-28                               removeFromPwdAccessibleDomains
   closing, 6-12                                       EUSM command, 7-73
   creating hardware security wallet, 6-10         removeGlobalRole
   creating standard wallet, 6-9                       EUSM command, 7-39
   deleting, 6-17                                  removeTargetUser
   downloading from LDAP directories, 6-15             EUSM command, 7-58
   exporting to non-PKCS#12 tools, 6-13            revokeProxyPerm
   exporting to third-party environments, 6-12         EUSM command, 7-62
   general process for creating, 6-7               revokeRole
   managing, 6-8                                       EUSM command, 7-44
   opening, 6-11
   Oracle Applications wallet location, 6-17
   password guidelines, 6-8                        S
   passwords, changing, 6-18                       setAuthTypes
   saving changes to, 6-16                             EUSM command, 7-32
   saving to new location, 6-16                    setCulinkStatus
   saving to system default directory, 6-17            EUSM command, 7-31
   SSL wallet location, 6-9, 6-17                  setDBOIDAuth
   uploading to LDAP directories, 6-14                 EUSM command, 7-69
OracleContextAdmins directory group, 1-16          shared schemas, 1-19
OracleDBAdmins directory group, 1-16               SSL External Users Conversion Script, B-2
   concepts, 1-14                                  SSL port connectivity
OracleDBCreators directory group, 1-16                 through EUSM to OID, 7-3
OracleDBSecurityAdmins directory group, 1-17       SSL wallet location, 6-9, 6-17
OraclePasswordAccessibleDomains list directory     SYS schema, A-4
        group, 1-17                                SYSDBA privilege
OracleUserSecurityAdmins directory group, 1-17         directory authentication, 4-10
ORCL_GLOBAL_USR_MIGRATION_DATA                     SYSOPER privilege
        interface table, A-4                           directory authentication, 4-10
   access to, A-5
   KERBEROS_PNAME column, A-5




                                                                                            Index-4
                                                                                                  Index



U                                                user migration utility (continued)
                                                     ORCL_GLOBAL_USR_MIGRATION_DATA
UMU utility                                                   interface table, A-4
    TRACE_UMU environment variable, A-35             password authenticated users, A-8
Upgrade EUS, D-1                                     retrieving dropped schema objects, A-23
user migration utility                               shared schema mapping, A-7
    access to interface table, A-5                   SSL authentication for current release, A-8
    accessing help, A-12                             SYS schema, A-4
    certificate authenticated users, A-8             uses Oracle JDBC OCI driver, A-2
    directory location of utility, A-9               X.509 v3 certificates, A-8
    example
         parameter text file (par.txt), A-26
         users list text file (usrs.txt), A-27
                                                 V
         using CASCADE=NO, A-21                  viewing the database wallet DN, 4-27
         using CASCADE=YES, A-23
         using MAPSCHEMA=PRIVATE, A-21
         using MAPSCHEMA=SHARED, A-21            W
         using MAPTYPE options, A-24             wallets, 6-1
         using PARFILE, USERSFILE, and                   See also Oracle wallets
                  LOGFILE parameters, A-27
    KERBEROS_PNAME column, A-5
    keyword: DBALIAS, A-18                       X
    keyword: ENTALIAS, A-19
                                                 X.509 certificate
    keyword: WALLETLOCATION, A-19
                                                     difference from PKCS #7 certificate chain,
    LOGFILE precedence, A-26
                                                              6-23
    MAPTYPE parameter
         SUBTREE mapping level, A-25




                                                                                                     5

